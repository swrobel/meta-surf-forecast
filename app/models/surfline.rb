class Surfline < Forecast
  class << self
    def api_url(spot)
      "http://api.surfline.com/v1/forecasts/#{spot.surfline_id}?resources=surf,analysis,wind,weather,tide,sort&days=30&getAllSpots=false&units=e&interpolate=true&showOptimal=true&usenearshore=true"
    end

    def parse_response(spot, request, responses)
      forecasts = {}

      responses.Surf.dateStamp.each_with_index do |day, day_index|
        day.each_with_index do |timestamp, timestamp_index|
          forecast = forecasts[Time.zone.parse(timestamp)] = {}
          forecast[:min_height] = responses.Surf.surf_min[day_index][timestamp_index]
          forecast[:max_height] = responses.Surf.surf_max[day_index][timestamp_index]
        end
      end

      responses.Sort.dateStamp.each_with_index do |day, day_index|
        day.each_with_index do |timestamp, timestamp_index|
          max_swell_rating = 0
          forecast = forecasts[Time.zone.parse(timestamp)] = {}
          (1..6).each do |swell_index|
            max_swell_rating = [max_swell_rating, responses.Sort["optimal#{swell_index}"][day_index][timestamp_index].to_d].max
          end
          forecast[:swell_rating] = max_swell_rating
        end
      end

      responses.Wind.dateStamp.each_with_index do |day, day_index|
        day.each_with_index do |timestamp, timestamp_index|
          forecast = forecasts[Time.zone.parse(timestamp)] = {}
          forecast[:optimal_wind] = responses.Wind.optimalWind[day_index][timestamp_index]
        end
      end

      forecasts.each do |key, values|
        record = unscoped.where(spot_id: spot.id, timestamp: key).first_or_initialize
        record.api_request = request
        values.each do |k, v|
          record[k] = v
        end
        record.save!
      end
    end
  end
end
