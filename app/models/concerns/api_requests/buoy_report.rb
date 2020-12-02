module ApiRequests
  module BuoyReport
    extend ActiveSupport::Concern

    included do
      FEET_PER_METER = 3.2808398950131

      def parse_buoy_report
        ndbc_id = requestable.ndbc_id
        response.split("\n")[2..].each do |line| # Skip first 2 (header) lines
          next if line.strip.blank?

          Bugsnag.configure do |config|
            config.add_on_error lambda { |report|
              report.add_tab(:rake, {
                               batch: batch_id,
                               request: id,
                               ndbc: ndbc_id,
                               line: line,
                             })
            }
          end

          tstamp = Time.utc(*line[0..15].split, 0)
          record = service_class.unscoped.where(buoy: requestable, timestamp: requestable.utc_stamp_to_local(tstamp)).first_or_initialize
          record.api_request = self
          record.sig_wave_height = line[17..20].to_d * FEET_PER_METER
          record.ground_swell_height = line[22..25].to_d * FEET_PER_METER
          record.ground_swell_period = line[27..30].to_d
          record.wind_swell_height = line[32..35].to_d * FEET_PER_METER
          record.wind_swell_period = line[37..40].to_d
          record.ground_swell_direction = DIRECTION_MAPPING[line[42..44].strip]
          record.wind_swell_direction = DIRECTION_MAPPING[line[46..48].strip]
          record.steepness = line[50..59].strip
          record.avg_period = line[61..64].to_d
          record.mean_wave_direction = line[65..68].to_i
          record.save!
        end
      end
    end
  end
end
