# frozen_string_literal: true

module Spots
  module SurflineV2
    extend ActiveSupport::Concern

    class_methods do
      def surfline_v2_url(surfline_v2_id)
        "https://www.surfline.com/surf-report/_/#{surfline_v2_id}"
      end

      alias_method :surfline_url, :surfline_v2_url
    end

    included do
      has_many :surfline_v2_lolas, dependent: :delete_all
      has_many :surfline_v2_lotus, dependent: :delete_all

      def surfline_v2_url
        self.class.surfline_v2_url(surfline_v2_id)
      end
      alias_method :surfline_url, :surfline_v2_url

      def surfline_v2_api_url(type:, use_lotus:)
        raise "No Surfline v2 spot associated with #{name} (#{id})" if surfline_v2_id.blank?

        "#{::SurflineV2.base_api_url}/kbyg/spots/forecasts/#{type}?spotId=#{surfline_v2_id}&sds=#{use_lotus}&days=17&intervalHours=1&maxHeights=false&accesstoken=#{::SurflineV2.access_token}"
      end

      def surfline_v2_lola_api_url(type: 'wave')
        surfline_v2_api_url(type: type, use_lotus: false)
      end

      def surfline_v2_lotus_api_url(type: 'wave')
        surfline_v2_api_url(type: type, use_lotus: true)
      end
    end
  end
end
