# frozen_string_literal: true
class SurflineLola < Surfline
  class << self
    def api_url(spot)
      super(spot, false)
    end
  end
end
