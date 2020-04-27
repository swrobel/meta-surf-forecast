class UpdateConsolidatedForecastsToVersion2 < ActiveRecord::Migration[6.0]
  def change
    create_view :consolidated_forecasts, version: 2, materialized: true
  end
end
