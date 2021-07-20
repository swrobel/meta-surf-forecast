class BuoyReport < ApplicationRecord
  belongs_to :api_request
  belongs_to :buoy

  default_scope -> { order(:buoy_id, timestamp: :desc) }
  scope :past, -> { joins(buoy: :region).where("timestamp < now() at time zone regions.timezone - interval '7 day'") }

  def wave_height(swell, period)
    swell * period * 0.1
  end

  def wave_data(swell, period)
    "#{wave_height(swell, period).round(1)}ft (#{swell.round(1)} @ #{period}"
  end

  def swell_wave_height
    wave_height(ground_swell_height, ground_swell_period)
  end

  def swell_wave_data
    wave_data(ground_swell_height, ground_swell_period)
  end

  def wind_wave_height
    wave_height(wind_swell_height, wind_swell_period)
  end

  def wind_wave_data
    wave_data(wind_swell_height, wind_swell_period)
  end

  def self.parse(body)
    body
  end
end
