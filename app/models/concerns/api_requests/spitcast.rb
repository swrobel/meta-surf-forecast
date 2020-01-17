# frozen_string_literal: true

module ApiRequests
  module Spitcast
    extend ActiveSupport::Concern

    included do
      def parse_spitcast
        response.each do |entry|
          next unless entry['date'].present? && entry['hour'].present?

          record = service_class.unscoped.where(spot: requestable, timestamp: Time.zone.parse("#{entry['date']} #{entry['hour']}")).first_or_initialize
          record.api_request = self
          record.height = entry['size_ft']
          record.rating = entry['shape_full']
          record.save! if record.rating.present?
        end
      end
    end
  end
end
