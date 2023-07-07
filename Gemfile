# frozen_string_literal: true

source 'https://rubygems.org'

ruby "~> #{File.read('.ruby-version').strip}"

gem 'rails', '~> 7.0.2'

gem 'bootsnap'
gem 'bugsnag'
gem 'friendly_id'
gem 'memery' # Memoization
gem 'oj'
gem 'pg'
gem 'puma'
gem 'react-rails', '~> 2.7.0.rc.0'
gem 'safely_block'
gem 'scenic'
gem 'shakapacker', '7.0.2'
gem 'slim-rails'
gem 'typhoeus'

group :development, :test do
  gem 'dotenv-rails'
  gem 'pgreset'
end

group :development do
  gem 'foreman'
  gem 'gindex'
  gem 'guard'
  gem 'guard-rubocop', require: false
  gem 'guard-shell', require: false
  gem 'rack-toolbar', github: 'swrobel/rack-toolbar', branch: 'rails-pages' # Insert arbitrary code into Rails pages
  gem 'rubocop'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'terminal-notifier-guard'
  gem 'web-console'
end

group :production do
  gem 'hiredis-client'
  gem 'newrelic_rpm'
  gem 'rack-brotli'
  gem 'redis', '~> 5'
end
