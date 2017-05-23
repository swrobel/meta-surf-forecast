# frozen_string_literal: true
class Forecast < ApplicationRecord
  extend ApiMethods
  self.abstract_class = true

  belongs_to :api_request
  belongs_to :spot

  class << self
    def current
      where(timestamp: Time.now.utc..(Time.now.utc + 1.month))
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

    def api_pull(spot)
      return false unless (result = api_get(api_url(spot)))
      parse_response(spot, result.request, JSON.parse(result.response, object_class: OpenStruct))
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

  private

    def raise_not_implemented_error
      raise NotImplementedError, "Subclass should override method '#{caller[0][/`.*'/][1..-2]}'"
    end
  end
end
