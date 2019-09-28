# frozen_string_literal: true

source 'https://rubygems.org'

ruby "~> #{`cat .ruby-version`.strip}"

gem 'rails', '~> 6.0.0'

gem 'bootsnap'
gem 'bootstrap', '~> 4.2'
gem 'friendly_id'
gem 'oj'
gem 'pg'
gem 'puma'
gem 'react-rails'
gem 'scenic'
gem 'slim-rails'
gem 'typhoeus'
gem 'webpacker', github: 'rails/webpacker'

group :development, :test do
  gem 'dotenv-rails'
  gem 'pgreset'
end

group :development do
  gem 'gindex'
  gem 'guard'
  gem 'guard-rubocop', require: false
  gem 'guard-shell', require: false
  gem 'invoker', github: 'swrobel/invoker'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rubocop'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'terminal-notifier-guard'
  gem 'web-console'
end

group :production do
  gem 'hiredis'
  gem 'newrelic_rpm'
  gem 'redis'
end
