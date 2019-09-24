# frozen_string_literal: true

class SurflineV2 < Forecast
  CACHE_KEY = 'surfline_token'

  class << self
    def access_token
      Rails.cache.fetch(CACHE_KEY) do
        body = "grant_type=password&username=#{ENV['SURFLINE_EMAIL']}&password=#{ENV['SURFLINE_PASSWORD']}&device_id=Firefox-69.0&device_type=Firefox%2069.0%20on%20OS%20X%2010.14&forced=true"
        headers = {
          'Accept' => 'application/json',
          'Accept-Language' => 'en-US,en;q=0.5',
          'Authorization' => 'Basic NWM1OWU3YzNmMGI2Y2IxYWQwMmJhZjY2OnNrX1FxWEpkbjZOeTVzTVJ1MjdBbWcz',
          'content-type' => 'application/x-www-form-urlencoded',
          'credentials' => 'same-origin'
        }
        response = Typhoeus.post("#{SurflineV2.base_api_url}/trusted/token?isShortLived=false", headers: headers, body: body)
        raise "Surfline access token refresh error: #{response.body}" unless response.success?

        JSON.parse(response.body)['access_token']
      end
    end

    def base_api_url
      'https://services.surfline.com'
    end

    def expire_access_token
      Rails.cache.delete(CACHE_KEY)
    end
  end
end
