# frozen_string_literal: true

require 'active_support/core_ext/integer/time'

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  config.log_level = :info

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  config.action_controller.perform_caching = false
  config.action_controller.enable_fragment_cache_logging = true

  config.public_file_server.headers = {
    'Cache-Control' => "public, max-age=#{2.days.to_i}",
  }

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise exceptions for disallowed deprecations.
  config.active_support.disallowed_deprecation = :raise

  # Tell Active Support which deprecation messages to disallow.
  config.active_support.disallowed_deprecation_warnings = []

  # Raises error for missing translations.
  config.i18n.raise_on_missing_translations = true

  # Annotate rendered view with file names.
  config.action_view.annotate_rendered_view_with_filenames = true

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true

  # Raises error for missing translations.
  # config.action_view.raise_on_missing_translations = true

  # Uncomment if you wish to allow Action Cable access from any origin.
  # config.action_cable.disable_request_forgery_protection = true

  dev_server = Webpacker.config.dev_server
  WEBPACK_SCRIPT_TAG ||= "<script src='#{"http#{dev_server[:https] && 's'}"}://#{dev_server[:host]}:#{dev_server[:port]}/webpack-dev-server.js'></script>".freeze
  config.middleware.insert_before ActionDispatch::ShowExceptions, Rack::Toolbar,
                                  snippet: WEBPACK_SCRIPT_TAG,
                                  insertion_point: '</head>',
                                  insertion_method: :before
end
