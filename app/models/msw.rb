class Msw < ApplicationRecord
  belongs_to :spot

  def self.api_pull(spot)
    response = JSON.parse(Net::HTTP.get(URI("http://magicseaweed.com/api/#{ENV['MSW_API_KEY']}/forecast?spot_id=#{spot.msw_id}&units=us")), object_class: OpenStruct)

    response.each do |response|
      record = Msw.find_or_create_by(spot_id: spot.id, timestamp: Time.at(response.timestamp))
      record.update(
        min_height: response.swell.absMinBreakingHeight,
        max_height: response.swell.absMaxBreakingHeight,
        rating: response.solidRating,
        wind_effect: response.fadedRating,
      )
    end
  end
end
