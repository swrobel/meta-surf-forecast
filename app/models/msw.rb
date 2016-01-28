class Msw < Forecast
  class << self
    def api_url(spot)
      "http://magicseaweed.com/api/#{ENV['MSW_API_KEY']}/forecast?spot_id=#{spot.msw_id}&units=us"
    end

    def parse_response(spot, response)
      response.each do |response|
        record = self.where(spot_id: spot.id, timestamp: Time.at(response.timestamp)).first_or_initialize
        record.min_height = response.swell.absMinBreakingHeight
        record.max_height = response.swell.absMaxBreakingHeight
        record.rating = response.solidRating
        record.wind_effect = response.fadedRating
        record.save
      end
    end
  end
end
