# frozen_string_literal: true

module Spots
  module Spitcast
    extend ActiveSupport::Concern

    class_methods do
      def spitcast_url(spitcast_slug)
        "http://www.spitcast.com/surf-report/spot/#{spitcast_slug}/"
      end
    end

    included do
      has_many :spitcasts, dependent: :delete_all

      def spitcast_url
        self.class.spitcast_url(spitcast_slug)
      end

      def spitcast_api_url
        raise "No Spitcast spot associated with #{name} (#{id})" if spitcast_id.blank?

        "http://api.spitcast.com/api/spot/forecast/#{spitcast_id}/?dcat=week"
      end
    end
  end
end
