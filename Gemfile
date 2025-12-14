# frozen_string_literal: true

source 'https://gem.coop'

ruby "~> #{File.read('.ruby-version').strip}"

gem 'rails', '~> 8.1.0'

gem 'bootsnap'
gem 'bugsnag'
gem 'data_migrate'
gem 'friendly_id'
gem 'memery' # Memoization
gem 'oj'
gem 'pg'
gem 'puma'
gem 'safely_block'
gem 'scenic'
gem 'shakapacker', '9.4.0'
gem 'slim-rails'
gem 'typhoeus' # HTTP client

group :development, :test do
  gem 'dotenv'
  gem 'pgreset'
end

group :development do
  gem 'foreman'
  gem 'gindex'
  gem 'guard'
  gem 'guard-rubocop', require: false
  gem 'guard-shell', require: false
  gem 'rubocop'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'terminal-notifier-guard'
  gem 'web-console'
end

group :production do
  gem 'connection_pool', '< 3' # Locked until new Rails version with compat
  gem 'hiredis-client'
  gem 'lograge' # More concise logs
  gem 'newrelic_rpm'
  gem 'pghero'
  gem 'pghero_assets'
  gem 'pg_query', '>= 2'
  gem 'rack-brotli'
  gem 'redis', '~> 5'
end
