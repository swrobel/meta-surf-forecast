# frozen_string_literal: true

class Msw < Forecast
  class << self
    def base_api_url
      "http://magicseaweed.com/api/#{ENV.fetch('MSW_API_KEY', nil)}"
    end
  end
end
