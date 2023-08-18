class UpdateConsolidatedForecastsToVersion3 < ActiveRecord::Migration[7.0]
  def up
    drop_view :consolidated_forecasts, materialized: true
    create_view :consolidated_forecasts, version: 3, materialized: true
  end

  def down
    drop_view :consolidated_forecasts, materialized: true
    create_view :consolidated_forecasts, version: 2, materialized: true
  end
end
