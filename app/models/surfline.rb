class Surfline < Forecast
  class << self
    def api_url(spot)
      "http://api.surfline.com/v1/forecasts/#{spot.surfline_id}?resources=surf,analysis,wind,weather,tide,sort&days=30&getAllSpots=true&units=e&interpolate=true&showOptimal=true&usenearshore=true"
    end

    def parse_response(_spot, request, responses)
      # If get_all_spots is false, response will be a single object instead of an array
      responses = [responses] unless responses.is_a? Array
      forecasts = {}

      responses.each do |response|
        id = response.id
        forecasts[id] ||= {}
        response.Surf.dateStamp.each_with_index do |day, day_index|
          day.each_with_index do |timestamp, timestamp_index|
            ts = Time.zone.parse(timestamp)
            forecasts[id][ts] ||= {}
            forecasts[id][ts][:min_height] = response.Surf.surf_min[day_index][timestamp_index]
            forecasts[id][ts][:max_height] = response.Surf.surf_max[day_index][timestamp_index]
          end
        end

        response.Sort.dateStamp.each_with_index do |day, day_index|
          day.each_with_index do |timestamp, timestamp_index|
            ts = Time.zone.parse(timestamp)
            forecasts[id][ts] ||= {}
            max_swell_rating = 0
            (1..6).each do |swell_index|
              max_swell_rating = [max_swell_rating, response.Sort["optimal#{swell_index}"][day_index][timestamp_index].to_d].max
            end
            forecasts[id][ts][:swell_rating] = max_swell_rating
          end
        end

        response.Wind.dateStamp.each_with_index do |day, day_index|
          day.each_with_index do |timestamp, timestamp_index|
            ts = Time.zone.parse(timestamp)
            forecasts[id][ts] ||= {}
            forecasts[id][ts][:optimal_wind] = response.Wind.optimalWind[day_index][timestamp_index]
          end
        end
      end

      forecasts.each do |surfline_id, timestamps|
        timestamps.each do |timestamp, values|
          record = unscoped.where(spot_id: Spot.find_by_surfline_id(surfline_id), timestamp: timestamp).first_or_initialize
          record.api_request = request
          values.each do |attribute, value|
            record[attribute] = value
          end
          record.save!
        end
      end
    end
  end
end
