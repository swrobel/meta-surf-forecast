NOTIFY_RELEASE_STAGES = %w[production staging].freeze

Bugsnag.configure do |config|
  config.api_key = ENV.fetch('BUGSNAG_BACKEND', nil)
  config.notify_release_stages = NOTIFY_RELEASE_STAGES
  config.send_environment = true
  config.app_version = ENV.fetch('HEROKU_RELEASE_VERSION', nil)
  config.ignore_classes << ActiveRecord::RecordNotFound
  config.ignore_classes << Mime::Type::InvalidMimeType
  config.ignore_classes << ActionController::RoutingError
end
