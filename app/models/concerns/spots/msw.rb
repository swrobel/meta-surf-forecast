# frozen_string_literal: true

module Spots
  module Msw
    extend ActiveSupport::Concern

    class_methods do
      def msw_url(msw_id)
        "http://magicseaweed.com/Surf-Report/#{msw_id}/"
      end
    end

    included do
      has_many :msws, dependent: :delete_all

      def msw_url
        self.class.msw_url(msw_id)
      end

      def msw_api_url
        raise "No MagicSeaweed spot associated with #{name} (#{id})" if msw_id.blank?

        "#{::Msw.base_api_url}/forecast?spot_id=#{msw_id}&units=us&fields=localTimestamp,solidRating,fadedRating,swell.absMinBreakingHeight,swell.absMaxBreakingHeight,swell.absHeight"
      end
    end
  end
end
