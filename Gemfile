source 'https://rubygems.org'

ruby `cat .ruby-version`.strip

gem 'rails', '>= 5.0.0.beta1', '< 5.1'

gem 'bootstrap', '~> 4.0.0.alpha3'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'pg', '~> 0.18'
gem 'puma'
gem 'slim-rails', github: 'okuramasafumi/slim-rails'
gem 'turbolinks'
gem 'uglifier', '>= 1.3.0'

group :development, :test do
  gem 'dotenv-rails'
end

group :development do
  gem 'guard'
  gem 'guard-bundler', require: false
  gem 'guard-rubocop', require: false
  gem 'quiet_assets', github: 'marcroberts/quiet_assets', branch: 'rails5'
  gem 'spring'
  gem 'terminal-notifier-guard'
  gem 'web-console', '~> 3.0'
end
