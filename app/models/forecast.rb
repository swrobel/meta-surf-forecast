# frozen_string_literal: true

class Forecast < ApplicationRecord
  self.abstract_class = true

  belongs_to :api_request
  belongs_to :spot

  scope :current, -> { where(timestamp: Time.now.utc..(Time.now.utc + 1.month)).where(updated_at: (Time.now.utc - 1.day)..Time.now.utc) }
  scope :ordered, -> { order(:spot_id, :timestamp) }

  class << self
    def default_scope
      current.ordered
    end

    def api_url(spot)
      raise_not_implemented_error
    end

    def parse_data(spot, request, data)
      raise_not_implemented_error
    end

    def api_get(spot:, url:, hydra: nil, options: {}, retries: 0)
      request = Typhoeus::Request.new(url, options.merge(followlocation: true))

      request.on_complete do |response|
        if response.success?
          data = JSON.parse(response.body, object_class: OpenStruct)
          request = ApiRequest.create(request: url, response: response.body, success: true, batch_id: UpdateBatch.id)
          parse_data(spot, request, data)
        else
          ApiRequest.create(request: url, response: { message: response.return_message, headers: response.headers, status: response.code }, success: false, batch_id: UpdateBatch.id)
          api_get(spot: spot, url: url, hydra: hydra, options: options, retries: retries + 1) unless retries >= API_RETRIES
        end
      end

      if hydra.present?
        hydra.queue(request)
      else
        request.run
      end
    end

    def api_pull(spot, get_all_spots: nil, hydra: nil, options: {})
      url = get_all_spots.nil? ? api_url(spot) : api_url(spot, get_all_spots)
      api_get(spot: spot, url: url, hydra: hydra, options: options)
    end

    def forecasted_max(stamps)
      [
        Spitcast.where(timestamp: stamps).maximum(:height),
        Msw.where(timestamp: stamps).maximum(:max_height),
        SurflineNearshore.where(timestamp: stamps).maximum(:max_height),
        SurflineLola.where(timestamp: stamps).maximum(:max_height)
      ].map { |v| v || 0 }.max
    end
  end
end
