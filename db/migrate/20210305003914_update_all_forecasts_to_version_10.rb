class UpdateAllForecastsToVersion10 < ActiveRecord::Migration[6.1]
  def up
    drop_view :consolidated_forecasts, materialized: true
    drop_view :all_forecasts, materialized: true
    create_view :all_forecasts, version: 10, materialized: true
    create_view :consolidated_forecasts, version: 2, materialized: true
  end

  def down
    drop_view :consolidated_forecasts, materialized: true
    drop_view :all_forecasts, materialized: true
    create_view :all_forecasts, version: 9, materialized: true
    create_view :consolidated_forecasts, version: 2, materialized: true
  end
end
