# frozen_string_literal: true

module ApiRequests
  module SurflineV2
    extend ActiveSupport::Concern

    included do
      def parse_surfline_v2
        type = options[:type] || 'wave'
        send("parse_surfline_v2_#{type}")
      end
      alias_method :parse_surfline_v2_lola, :parse_surfline_v2
      alias_method :parse_surfline_v2_lotus, :parse_surfline_v2

      def parse_surfline_v2_wind
        response.dig('data', 'wind').each do |entry|
          next unless (timestamp = entry['timestamp'])

          record = service_class.unscoped.find_by(spot: requestable, timestamp: requestable.utc_stamp_to_local(timestamp))
          next unless record

          record.wind_rating = entry['optimalScore']
          record.save! if record.wind_rating.present?
        end
      end

      def parse_surfline_v2_wave
        response.dig('data', 'wave').each do |entry|
          next unless (timestamp = entry['timestamp'])

          record = service_class.unscoped.where(spot: requestable, timestamp: requestable.utc_stamp_to_local(timestamp)).first_or_initialize
          record.api_request = self
          record.min_height = entry.dig('surf', 'min')
          record.max_height = entry.dig('surf', 'max')
          record.swell_rating = entry.dig('surf', 'optimalScore')
          record.save! if record.swell_rating.present?
        end

        # Wind request needs to be made after wave request is completed
        ApiRequest.new(batch:, requestable:, service:, hydra:, options: options.merge(type: 'wind'), typhoeus_opts:).get
      end
    end
  end
end
