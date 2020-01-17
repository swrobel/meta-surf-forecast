class UpdateAllForecastsToVersion5 < ActiveRecord::Migration[6.0]
  def change
    create_view :all_forecasts, version: 5, materialized: true
    create_view :consolidated_forecasts, materialized: true
  end
end
