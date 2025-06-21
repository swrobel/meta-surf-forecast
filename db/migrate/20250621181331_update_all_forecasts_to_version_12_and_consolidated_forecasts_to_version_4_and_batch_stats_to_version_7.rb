class UpdateAllForecastsToVersion12AndConsolidatedForecastsToVersion4AndBatchStatsToVersion7 < ActiveRecord::Migration[8.0]
  def up
    drop_view :consolidated_forecasts, materialized: true
    drop_view :all_forecasts, materialized: true
    create_view :all_forecasts, version: 12, materialized: true
    create_view :consolidated_forecasts, version: 4, materialized: true
    update_view :batch_stats, version: 7, materialized: true
  end

  def down
    drop_view :consolidated_forecasts, materialized: true
    drop_view :all_forecasts, materialized: true
    create_view :all_forecasts, version: 11, materialized: true
    create_view :consolidated_forecasts, version: 3, materialized: true
    update_view :batch_stats, version: 6, materialized: true
  end
end
