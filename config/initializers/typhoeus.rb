# frozen_string_literal: true

Typhoeus::Config.user_agent = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_3) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/12.0.3 Safari/605.1.15'
TYPHOEUS_CONCURRENCY ||= ENV.fetch('MAX_WORKER_THREADS', 5)
