# frozen_string_literal: true

environment ENV.fetch('RAILS_ENV') { 'development' }
port        ENV.fetch('PORT') { 3000 }
threads 1, 1
workers 1

if Rails.env.development?
  # Allow puma to be restarted by `rails restart` command.
  plugin :tmp_restart

  after_worker_boot do
    title = 'MetaSurf server started'
    defined?(TerminalNotifier) && TerminalNotifier::Guard.success('', title: title)
    defined?(Libnotify) && Libnotify.show(summary: title)
    # Trick Webpack into reloading browser
    `touch app/javascript/packs/application.js`
  end
else
  preload_app!
end
