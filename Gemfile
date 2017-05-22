# frozen_string_literal: true
source 'https://rubygems.org'

ruby "~> #{`cat .ruby-version`.strip}"

# Force github sources to use https instead of insecure git protocol
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '5.1.1'

gem 'bootstrap', '~> 4.0.0.alpha3'
gem 'chartkick'
gem 'coffee-rails', '~> 4.2.0'
gem 'friendly_id'
gem 'jquery-rails'
gem 'nokogiri'
gem 'pg', '~> 0.18'
gem 'puma'
gem 'slim-rails'
gem 'sprockets', '~> 4.0.0.beta2'
gem 'turbolinks'
gem 'uglifier', '>= 1.3.0'

group :development, :test do
  gem 'dotenv-rails'
end

group :development do
  gem 'guard'
  gem 'guard-bundler', require: false
  gem 'guard-rubocop', require: false
  gem 'invoker'
  gem 'rack-toolbar'
  gem 'rubocop', '~> 0.47.1'
  gem 'spring'
  gem 'terminal-notifier-guard'
  gem 'web-console', '~> 3.0'
end

group :production do
  gem 'newrelic_rpm'
  gem 'rails_12factor'
end
