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
  end
end
