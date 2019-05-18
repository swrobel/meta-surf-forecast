# frozen_string_literal: true

module ApiRequests
  module Msw
    extend ActiveSupport::Concern

    included do
      def parse_msw
        response.each do |entry|
          tstamp = Time.zone.at(entry['localTimestamp'])
          record = service_class.unscoped.where(spot: requestable, timestamp: tstamp).first_or_initialize
          record.api_request = self
          record.min_height = entry.dig('swell', 'absMinBreakingHeight') || entry.dig('swell', 'absHeight')
          record.max_height = entry.dig('swell', 'absMaxBreakingHeight') || entry.dig('swell', 'absHeight')
          record.rating = entry['solidRating']
          record.wind_effect = entry['fadedRating']
          record.save! if record.rating.present?
        end
      end
    end
  end
end
