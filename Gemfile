# frozen_string_literal: true

source 'https://rubygems.org'

ruby "~> #{`cat .ruby-version`.strip}"

# Force github sources to use https instead of insecure git protocol
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.2.0.beta2'

gem 'bootsnap'
gem 'bootstrap', '~> 4.0.0.alpha3'
gem 'friendly_id'
gem 'pg'
gem 'puma'
gem 'react-rails'
gem 'scenic'
gem 'slim-rails'
gem 'webpacker'

group :development, :test do
  gem 'dotenv-rails'
  gem 'pgreset'
end

group :development do
  gem 'guard'
  gem 'guard-bundler', require: false
  gem 'guard-rubocop', require: false
  gem 'guard-shell', require: false
  gem 'invoker'
  gem 'rack-toolbar'
  gem 'rubocop'
  gem 'spring'
  gem 'spring-commands-rubocop', require: false
  gem 'spring-watcher-listen'
  gem 'terminal-notifier-guard'
  gem 'web-console', '~> 3.0'
end

group :production do
  gem 'newrelic_rpm'
  gem 'rails_12factor'
  gem 'redis-rails'
end
