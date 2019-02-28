# frozen_string_literal: true

class Forecast < ApplicationRecord
  extend ApiMethods
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

    def api_pull(spot, get_all_spots: nil, hydra: nil, options: {})
      api_url = get_all_spots.nil? ? api_url(spot) : api_url(spot, get_all_spots)
      retries = 0
      result = nil

      until result || retries > API_RETRIES
        result = api_get(api_url, hydra: hydra, options: options)
        retries += 1
      end

      return false unless result.present?
      parse_data(spot, result.request, result.data)
      true
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
