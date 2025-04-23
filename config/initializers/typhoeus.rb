# frozen_string_literal: true

Typhoeus.configure do |config|
  config.user_agent = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:137.0) Gecko/20100101 Firefox/137.0'
end
API_RETRIES ||= ENV.fetch('API_RETRIES', 2)
