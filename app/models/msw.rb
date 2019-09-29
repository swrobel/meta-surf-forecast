# frozen_string_literal: true

class Msw < Forecast
  class << self
    def base_api_url
      "http://magicseaweed.com/api/#{ENV['MSW_API_KEY']}"
    end
  end
end
