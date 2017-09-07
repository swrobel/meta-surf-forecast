# frozen_string_literal: true

class SurflineLola < Surfline
  class << self
    def api_url(spot, get_all_spots = true)
      super(spot, false, get_all_spots)
    end
  end
end
