# frozen_string_literal: true

class Msw < Forecast
  def avg_height
    (min_height + max_height) / 2
  end

  class << self
    def site_url
      'http://magicseaweed.com'
    end

    def api_url(spot)
      "http://magicseaweed.com/api/#{ENV['MSW_API_KEY']}/forecast?spot_id=#{spot.msw_id}&units=us"
    end

    def for_chart
      pluck('round(min_height, 1)', 'round(max_height, 1)')
    end

    def parse_response(spot, request, responses)
      responses.each do |response|
        timestamp = Time.zone.at(response.timestamp)
        # Correct for Daylight Savings Time shift handled incorrectly by MSW
        timestamp += 1.hour unless timestamp.in_time_zone(spot.subregion.timezone).dst?
        record = unscoped.where(spot: spot, timestamp: timestamp).first_or_initialize
        record.api_request = request
        record.min_height = response.swell.absMinBreakingHeight
        record.max_height = response.swell.absMaxBreakingHeight
        record.rating = response.solidRating
        record.wind_effect = response.fadedRating
        record.save! if record.rating.present?
      end
    end
  end
end
