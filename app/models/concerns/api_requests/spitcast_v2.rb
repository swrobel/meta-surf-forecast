# frozen_string_literal: true

module ApiRequests
  module SpitcastV2
    extend ActiveSupport::Concern

    included do
      def parse_spitcast_v2
        response.each do |entry|
          next unless (timestamp = entry['timestamp'])

          record = service_class.unscoped.where(spot: requestable, timestamp: requestable.utc_stamp_to_local(timestamp)).first_or_initialize
          record.api_request = self
          record.height = entry['size_ft']
          record.rating = entry['shape']
          record.save! if record.rating.present?
        end
      end
    end
  end
end
