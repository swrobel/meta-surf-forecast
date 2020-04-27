# frozen_string_literal: true

class SpitcastV1 < Forecast
  class << self
    def for_chart
      pluck('round(height, 1)')
    end
  end
end
