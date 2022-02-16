# frozen_string_literal: true

require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_view/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MetaSurfForecast
  class Application < Rails::Application
    config.load_defaults '6.0'
    config.active_support.cache_format_version = 7.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.time_zone = 'UTC'

    config.force_ssl = true

    # Disable view rendering logs
    config.action_view.logger = nil
  end
end

# Faster migrations: https://github.com/ankane/strong_migrations#faster-migrations
ActiveRecord.dump_schema_after_migration = Rails.env.development? &&
                                           `git status db/migrate/ --porcelain`.present?

DIRECTION_MAPPING = {
  'N' => 0,
  'NNE' => 22.5,
  'NE' => 45,
  'ENE' => 67.5,
  'E' => 90,
  'ESE' => 112.5,
  'SE' => 135,
  'SSE' => 157.5,
  'S' => 180,
  'SSW' => 202.5,
  'SW' => 225,
  'WSW' => 247.5,
  'W' => 270,
  'WNW' => 292.5,
  'NW' => 315,
  'NNW' => 337.5,
}.freeze
EXPIRE_ON_UPDATE_KEY = :expire_on_update
RATING_COLORS = {
  0 => {
    max: 'D9B0B7',
    avg: 'C3818C',
    min: 'B46270',
  },
  1 => {
    max: 'F49B90',
    avg: 'EE6352',
    min: 'D95A4B',
  },
  2 => {
    max: 'FBD698',
    avg: 'FAC05E',
    min: 'E4AF56',
  },
  3 => {
    max: 'FEF8A1',
    avg: 'FEF56C',
    min: 'E7DF63',
  },
  4 => {
    max: '95DFB8',
    avg: '59CD90',
    min: '51BB83',
  },
  5 => {
    max: '9BFFFF',
    avg: '54EAEA',
    min: '00D3D3',
  },
}.freeze
RATING_TEXT = {
  0 => 'Poor',
  1 => 'Poor - Fair',
  2 => 'Fair',
  3 => 'Fair - Good',
  4 => 'Good',
  5 => 'Very Good',
}.freeze
