# frozen_string_literal: true

class SurflineNearshore < Surfline
  class << self
    def api_url(spot)
      super(spot, true)
    end
  end
end
