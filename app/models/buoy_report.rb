class BuoyReport < ApplicationRecord
  belongs_to :api_request
  belongs_to :buoy

  def swell_wave_size
    swell_height * swell_period * 0.1
  end

  def wind_wave_size
    wind_wave_height * wind_wave_period * 0.1
  end

  def self.parse(body)
    body
  end
end
