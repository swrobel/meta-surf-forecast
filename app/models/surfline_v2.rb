# frozen_string_literal: true

class SurflineV2 < Forecast
  self.abstract_class = true
  AUTH_STRING = 'Basic NWM1OWU3YzNmMGI2Y2IxYWQwMmJhZjY2OnNrX1FxWEpkbjZOeTVzTVJ1MjdBbWcz'
  CACHE_KEY = 'surfline_token'
  ORIGIN = 'https://www.surfline.com'

  class << self
    def access_token
      Rails.cache.fetch(CACHE_KEY) do
        body = {
          authorizationString: AUTH_STRING,
          grant_type: :password,
          forced: true,
          username: ENV.fetch('SURFLINE_EMAIL', nil),
          password: ENV.fetch('SURFLINE_PASSWORD', nil),
          device_id: 'Chrome-136.0.0.0',
          device_type: 'Chrome 136.0.0.0 on OS X 10.15.7 64-bit',
        }.to_json
        headers = {
          'Accept' => 'application/json',
          'Accept-Language' => 'en-US,en;q=0.9',
          'Authorization' => AUTH_STRING,
          'Content-Type' => 'application/json',
          'Origin' => ORIGIN,
          'Priority' => 'u=1, i',
          'Referer' => "#{ORIGIN}/",
          'sec-ch-ua' => '"Chromium";v="136", "Google Chrome";v="136", "Not.A/Brand";v="99"',
          'sec-ch-ua-mobile' => '?0',
          'sec-ch-ua-platform' => '"macOS"',
          'sec-fetch-dest' => 'empty',
          'sec-fetch-mode' => 'cors',
          'sec-fetch-site' => 'same-origin',
        }
        response = Typhoeus.post("#{SurflineV2.base_api_url}/trusted/token?isShortLived=false", headers:, body:, accept_encoding: 'gzip')
        raise "Surfline v2 access token refresh error code #{response.code}: #{response.body}" unless response.success?

        logger.info 'Surfline v2 access token refreshed!'

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
