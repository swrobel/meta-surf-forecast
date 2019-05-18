# frozen_string_literal: true

module Spots
  module SurflineV1
    extend ActiveSupport::Concern

    class_methods do
      def surfline_v1_url(surfline_v1_id)
        "https://www.surfline.com/surfdata/report-c.cfm?id=#{surfline_v1_id}"
      end
    end

    included do
      has_many :surfline_nearshores, dependent: :delete_all
      has_many :surfline_lolas, dependent: :delete_all

      def surfline_v1_url
        self.class.surfline_v1_url(surfline_v1_id)
      end

      def surfline_api_url(use_nearshore: true, get_all_spots: true)
        raise "No Surfline spot associated with #{name} (#{id})" if surfline_v1_id.blank?

        "http://api.surfline.com/v1/forecasts/#{surfline_v1_id}?resources=surf,wind,sort&days=#{ENV['SURFLINE_DAYS'] || 15}&getAllSpots=#{get_all_spots}&units=e&interpolate=true&showOptimal=true&usenearshore=#{use_nearshore}"
      end
    end
  end
end
