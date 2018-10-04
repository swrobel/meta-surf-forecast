# frozen_string_literal: true

class Forecast < ApplicationRecord
  extend ApiMethods
  self.abstract_class = true

  belongs_to :api_request
  belongs_to :spot

  class << self
    def current
      where(timestamp: Time.now.utc..(Time.now.utc + 1.month)).where(updated_at: (Time.now.utc - 1.day)..Time.now.utc)
    end

    def ordered
      order(:spot_id, :timestamp)
    end

    def default_scope
      current.ordered
    end

    def api_url(spot)
      raise_not_implemented_error
    end

    def parse_response(spot, request, responses)
      raise_not_implemented_error
    end

    def api_pull(spot, get_all_spots = nil)
      api_url = get_all_spots.nil? ? api_url(spot) : api_url(spot, get_all_spots)
      return false unless (result = api_get(api_url))

      parse_response(spot, result.request, result.response)
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
