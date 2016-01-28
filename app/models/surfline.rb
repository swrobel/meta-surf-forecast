class Surfline < Forecast
  class << self
    def api_url(spot)
      "http://api.surfline.com/v1/forecasts/#{spot.surfline_id}?resources=surf,analysis,wind,weather,tide,sort&days=30&getAllSpots=false&units=e&interpolate=true&showOptimal=true&usenearshore=true"
    end

    def parse_response(spot, response)
      response.Surf.dateStamp.each_with_index do |day, day_index|
        day.each_with_index do |timestamp, timestamp_index|
          record = self.where(spot_id: spot.id, timestamp: Time.zone.parse(timestamp)).first_or_initialize
          record.min_height = response.Surf.surf_min[day_index][timestamp_index]
          record.max_height = response.Surf.surf_max[day_index][timestamp_index]
          record.save
        end
      end

      response.Sort.dateStamp.each_with_index do |day, day_index|
        day.each_with_index do |timestamp, timestamp_index|
          max_swell_rating = 0
          (1..6).each do |swell_index|
            max_swell_rating = [max_swell_rating, response.Sort["optimal#{swell_index}"][day_index][timestamp_index].to_d].max
          end
          record = self.where(spot_id: spot.id, timestamp: Time.zone.parse(timestamp)).first_or_initialize
          record.swell_rating = max_swell_rating
          record.save
        end
      end

      response.Wind.dateStamp.each_with_index do |day, day_index|
        day.each_with_index do |timestamp, timestamp_index|
          record = self.where(spot_id: spot.id, timestamp: Time.zone.parse(timestamp)).first_or_initialize
          record.optimal_wind = response.Wind.optimalWind[day_index][timestamp_index]
          record.save
        end
      end
    end
  end
end
