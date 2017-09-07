# frozen_string_literal: true

class SurflineNearshore < Surfline
  class << self
    def api_url(spot, get_all_spots = true)
      super(spot, true, get_all_spots)
    end
  end
end
