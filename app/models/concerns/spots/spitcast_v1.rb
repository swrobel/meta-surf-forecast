# frozen_string_literal: true

module Spots
  module SpitcastV1
    extend ActiveSupport::Concern

    class_methods do
      def spitcast_v1_url(spitcast_slug)
        "https://www.spitcast.com/surf-report/spot/#{spitcast_slug}/"
      end
    end

    included do
      has_many :spitcast_v1s, dependent: :delete_all

      def spitcast_v1_url
        self.class.spitcast_v1_url(spitcast_slug)
      end

      def spitcast_v1_api_url
        raise "No Spitcast spot associated with #{name} (#{id})" if spitcast_id.blank?

        "http://api.spitcast.com/api/spot/forecast/#{spitcast_id}/?dcat=week"
      end
    end
  end
end
