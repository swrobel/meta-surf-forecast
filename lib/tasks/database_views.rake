# frozen_string_literal: true

namespace :database_views do
  desc 'Refresh materialized database views'
  task refresh: :environment do
    Scenic.database.refresh_materialized_view('all_forecasts', concurrently: false, cascade: false)
  end
end
