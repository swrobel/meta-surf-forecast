# frozen_string_literal: true

Typhoeus.configure do |config|
  config.user_agent = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36'
end
API_RETRIES ||= ENV.fetch('API_RETRIES', 2)
