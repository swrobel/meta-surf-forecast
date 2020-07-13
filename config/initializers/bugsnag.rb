NOTIFY_RELEASE_STAGES = %w[production staging].freeze

Bugsnag.configure do |config|
  config.api_key = ENV['BUGSNAG_BACKEND']
  config.notify_release_stages = NOTIFY_RELEASE_STAGES
  config.send_environment = true
  config.app_version = ENV['HEROKU_RELEASE_VERSION']
  config.ignore_classes << ActiveRecord::RecordNotFound
  config.ignore_classes << Mime::Type::InvalidMimeType
end
