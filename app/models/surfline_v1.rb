# frozen_string_literal: true

class SurflineV1 < Forecast
  self.abstract_class = true

  scope :with_rating_and_wind, -> { where.not(swell_rating: nil).where.not(optimal_wind: nil) }

  def display_swell_rating
    (swell_rating * 5 * wind_factor).round unless swell_rating.nil? || optimal_wind.nil?
  end

  def wind_factor
    optimal_wind ? 1 : 0.5
  end

  class << self
    def default_scope
      super.with_rating_and_wind
    end

    def api_pull(spot, hydra: nil, options: {}, typhoeus_opts: {})
      api_get(spot: spot, url: api_url(spot, options[:get_all_spots] || false), hydra: hydra, options: options, typhoeus_opts: typhoeus_opts)
    end
  end
end
