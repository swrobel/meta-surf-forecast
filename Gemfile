# frozen_string_literal: true

source 'https://rubygems.org'

ruby "~> #{File.read('.ruby-version').strip}"

gem 'rails', '~> 7.1.2'

gem 'bootsnap'
gem 'bugsnag'
gem 'data_migrate'
gem 'friendly_id'
gem 'memery' # Memoization
gem 'oj'
gem 'pg'
gem 'puma'
gem 'react-rails', '~> 3.1.0'
gem 'safely_block'
gem 'scenic'
gem 'shakapacker', '7.2.1'
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
  gem 'solargraph'
  gem 'solargraph-rails', github: 'masamitsu-murase/solargraph-rails', branch: 'fix_incompatibility_with_rails7.1'
  gem 'solargraph-syntax-suggest'
  gem 'terminal-notifier-guard'
  gem 'web-console'
end

group :production do
  gem 'hiredis-client'
  gem 'newrelic_rpm'
  gem 'rack-brotli'
  gem 'redis', '~> 5'
end
