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
          record.rating = case entry['shape_full']
                          when 'Poor' then 1
                          when 'Poor-Fair' then 2
                          when 'Fair' then 3
                          when 'Fair-Good' then 4
                          when 'Good' then 5
                          else 0
                          end
          record.save! if record.rating.present?
        end
      end
    end
  end
end
