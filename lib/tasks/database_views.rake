# frozen_string_literal: true

namespace :database_views do
  desc 'Refresh materialized database views'
  task refresh: :environment do
    include ActionView::Helpers::DateHelper

    start_time = Time.current
    Rails.logger.info 'Refreshing materialized views...'
    Scenic.database.refresh_materialized_view('all_forecasts', concurrently: false, cascade: false)
    Scenic.database.refresh_materialized_view('consolidated_forecasts', concurrently: false, cascade: false)
    Scenic.database.refresh_materialized_view('batch_stats', concurrently: false, cascade: false)
    Rails.logger.info "Finished refreshing materialized views in #{distance_of_time_in_words_to_now(start_time)}"
  end
end
