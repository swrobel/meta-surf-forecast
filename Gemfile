# frozen_string_literal: true

source 'https://rubygems.org'

ruby "~> #{`cat .ruby-version`.strip}"

# Force github sources to use https instead of insecure git protocol
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 6.0.0.beta2'

gem 'bootsnap'
gem 'bootstrap', '~> 4.2'
gem 'friendly_id', github: 'norman/friendly_id'
gem 'pg'
gem 'puma'
gem 'react-rails'
gem 'scenic'
gem 'slim-rails'
gem 'typhoeus'
gem 'webpacker', '~> 4.0.0.rc.7'

group :development, :test do
  gem 'dotenv-rails'
  gem 'pgreset'
end

group :development do
  gem 'gindex'
  gem 'guard'
  gem 'guard-bundler', require: false
  gem 'guard-rubocop', require: false
  gem 'guard-shell', require: false
  gem 'invoker'
  gem 'rack-toolbar'
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
