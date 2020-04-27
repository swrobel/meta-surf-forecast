# frozen_string_literal: true

class SpitcastV2 < Forecast
  class << self
    def for_chart
      pluck('round(height, 1)')
    end
  end
end
