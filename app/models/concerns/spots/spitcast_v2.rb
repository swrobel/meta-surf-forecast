# frozen_string_literal: true

module Spots
  module SpitcastV2
    extend ActiveSupport::Concern

    included do
      has_many :spitcast_v2s, dependent: :delete_all

      def spitcast_v2_api_url
        raise "No Spitcast spot associated with #{name} (#{id})" if spitcast_id.blank?

        d = Date.current
        "https://api.spitcast.com/api/spot_forecast/#{spitcast_id}/#{d.year}/#{d.month}/#{d.day}"
      end
    end
  end
end
