# frozen_string_literal: true

# Allow puma to be restarted by `rails restart` command.
plugin :tmp_restart

unless Rails.env.development?
  preload_app!

  threads ENV['PUMA_THREADS'] || 2, ENV['PUMA_THREADS'] || 2
  workers ENV['PUMA_WORKERS'] || 2
end

on_worker_boot do
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end
end
