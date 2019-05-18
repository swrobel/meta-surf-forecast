# frozen_string_literal: true

Typhoeus::Config.user_agent = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:69.0) Gecko/20100101 Firefox/69.0'
API_CONCURRENCY ||= ENV.fetch('MAX_WORKER_THREADS', 5)
API_RETRIES ||= ENV.fetch('API_RETRIES', 2)
