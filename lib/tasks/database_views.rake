# frozen_string_literal: true

namespace :database_views do
  desc 'Refresh materialized database views'
  task refresh: :environment do
    Rails.logger.info 'Refreshing materialized views...'
    Scenic.database.refresh_materialized_view('all_forecasts', concurrently: false, cascade: false)
    Rails.logger.info 'Finished refreshing materialized views'
  end
end
