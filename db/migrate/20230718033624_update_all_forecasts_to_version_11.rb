class UpdateAllForecastsToVersion11 < ActiveRecord::Migration[7.0]
  def up
    drop_view :consolidated_forecasts, materialized: true
    drop_view :all_forecasts, materialized: true
    create_view :all_forecasts, version: 11, materialized: true
    create_view :consolidated_forecasts, version: 2, materialized: true
  end

  def down
    drop_view :consolidated_forecasts, materialized: true
    drop_view :all_forecasts, materialized: true
    create_view :all_forecasts, version: 10, materialized: true
    create_view :consolidated_forecasts, version: 2, materialized: true
  end
end