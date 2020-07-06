# frozen_string_literal: true

module ApiRequests
  module SurflineV1
    extend ActiveSupport::Concern

    included do
      def parse_surfline_v1
        # If get_all_spots is false, entry will be a single object instead of an array
        data = response.is_a?(Array) ? response : [response]
        forecasts = {}

        data.each do |entry|
          spot_id = entry['id']
          forecasts[spot_id] ||= {}
          entry.dig('Surf', 'dateStamp')&.each_with_index do |day, day_index|
            day&.each_with_index do |timestamp, timestamp_index|
              tstamp = Time.zone.parse(timestamp)
              forecasts[spot_id][tstamp] ||= {}
              forecasts[spot_id][tstamp][:min_height] = entry.dig('Surf', 'surf_min')[day_index][timestamp_index]
              forecasts[spot_id][tstamp][:max_height] = entry.dig('Surf', 'surf_max')[day_index][timestamp_index]
            end
          end

          entry.dig('Sort', 'dateStamp')&.each_with_index do |day, day_index|
            day&.each_with_index do |timestamp, timestamp_index|
              tstamp = Time.zone.parse(timestamp)
              forecasts[spot_id][tstamp] ||= {}
              max_swell_rating = 0
              (1..6).each do |swell_index|
                max_swell_rating = [max_swell_rating, entry['Sort']["optimal#{swell_index}"][day_index][timestamp_index].to_d].max
              end
              forecasts[spot_id][tstamp][:swell_rating] = max_swell_rating
            end
          end

          entry.dig('Wind', 'dateStamp')&.each_with_index do |day, day_index|
            day&.each_with_index do |timestamp, timestamp_index|
              tstamp = Time.zone.parse(timestamp)
              forecasts[spot_id][tstamp] ||= {}
              forecasts[spot_id][tstamp][:optimal_wind] = entry.dig('Wind', 'optimalWind')[day_index][timestamp_index]
            end
          end
        end

        # Fill in blanks in swell ratings by averaging previous & next ratings
        forecasts.each_key do |spot_id|
          spot_data = forecasts[spot_id]
          # [1..-2] gets all elements except first & last
          spot_data.keys[1..-2]&.each_with_index do |tstamp, index|
            next if spot_data[:swell_rating].present?

            prev_tstamp = spot_data.keys[index] # index is already offset by 1
            next_tstamp = spot_data.keys[index + 2]
            prev_rating = spot_data[prev_tstamp][:swell_rating]
            next_rating = spot_data[next_tstamp][:swell_rating]
            forecasts[spot_id][tstamp][:swell_rating] = (prev_rating + next_rating) / 2 if prev_rating && next_rating
          end
        end

        forecasts.each do |surfline_v1_id, timestamps|
          next unless (forecasted_spot = Spot.find_by(surfline_v1_id: surfline_v1_id))

          timestamps.each do |timestamp, values|
            # Adjust for DST-related shifts in timestamps so they're all multiples of 3
            timestamp -= (timestamp.utc.hour % 3).hours
            record = service_class.unscoped.where(spot_id: forecasted_spot.id, timestamp: timestamp).first_or_initialize
            record.api_request = self
            values.each do |attribute, value|
              record[attribute] = value
            end
            record.save! if record.swell_rating.present?
          end
        end
      end

      alias_method :parse_surfline_nearshore, :parse_surfline_v1
      alias_method :parse_surfline_lola, :parse_surfline_v1
    end
  end
end
