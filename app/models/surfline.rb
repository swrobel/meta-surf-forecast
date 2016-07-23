# frozen_string_literal: true
class Surfline < Forecast
  self.abstract_class = true

  def display_swell_rating
    (swell_rating * 5 * wind_factor).round unless swell_rating.nil? || optimal_wind.nil?
  end

  def wind_factor
    optimal_wind ? 1 : 0.5
  end

  def avg_height
    (min_height + max_height) / 2
  end

  class << self
    def with_rating_and_wind
      where.not(swell_rating: nil).where.not(optimal_wind: nil)
    end

    def default_scope
      super.with_rating_and_wind
    end

    def site_url
      'http://www.surfline.com/'
    end

    def api_url(spot, use_nearshore = true)
      "http://api.surfline.com/v1/forecasts/#{spot.surfline_id}?resources=surf,analysis,wind,weather,tide,sort&days=30&getAllSpots=true&units=e&interpolate=true&showOptimal=true&usenearshore=#{use_nearshore}"
    end

    def parse_response(_spot, request, responses)
      # If get_all_spots is false, response will be a single object instead of an array
      responses = [responses] unless responses.is_a? Array
      forecasts = {}

      responses.each do |response|
        spot_id = response.id
        forecasts[spot_id] ||= {}
        response.Surf.dateStamp.each_with_index do |day, day_index|
          day.each_with_index do |timestamp, timestamp_index|
            tstamp = Time.zone.parse(timestamp)
            forecasts[spot_id][tstamp] ||= {}
            forecasts[spot_id][tstamp][:min_height] = response.Surf.surf_min[day_index][timestamp_index]
            forecasts[spot_id][tstamp][:max_height] = response.Surf.surf_max[day_index][timestamp_index]
          end
        end

        response.Sort.dateStamp.each_with_index do |day, day_index|
          day.each_with_index do |timestamp, timestamp_index|
            tstamp = Time.zone.parse(timestamp)
            forecasts[spot_id][tstamp] ||= {}
            max_swell_rating = 0
            (1..6).each do |swell_index|
              max_swell_rating = [max_swell_rating, response.Sort["optimal#{swell_index}"][day_index][timestamp_index].to_d].max
            end
            forecasts[spot_id][tstamp][:swell_rating] = max_swell_rating
          end
        end

        response.Wind.dateStamp.each_with_index do |day, day_index|
          day.each_with_index do |timestamp, timestamp_index|
            tstamp = Time.zone.parse(timestamp)
            forecasts[spot_id][tstamp] ||= {}
            forecasts[spot_id][tstamp][:optimal_wind] = response.Wind.optimalWind[day_index][timestamp_index]
          end
        end
      end

      # Fill in blanks in swell ratings by averaging previous & next ratings
      forecasts.keys.each do |spot_id|
        spot_data = forecasts[spot_id]
        # [1..-2] gets all elements except first & last
        spot_data.keys[1..-2].each_with_index do |tstamp, index|
          next unless spot_data[:swell_rating].blank?
          prev_tstamp = spot_data.keys[index] # index is already offset by 1
          next_tstamp = spot_data.keys[index + 2]
          prev_rating = spot_data[prev_tstamp][:swell_rating]
          next_rating = spot_data[next_tstamp][:swell_rating]
          forecasts[spot_id][tstamp][:swell_rating] = (prev_rating + next_rating) / 2 if prev_rating && next_rating
        end
      end

      forecasts.each do |surfline_id, timestamps|
        next unless (spot = Spot.find_by_surfline_id(surfline_id))
        timestamps.each do |timestamp, values|
          record = unscoped.where(spot_id: spot.id, timestamp: timestamp).first_or_initialize
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
