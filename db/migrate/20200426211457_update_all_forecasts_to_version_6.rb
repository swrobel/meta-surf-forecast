class UpdateAllForecastsToVersion6 < ActiveRecord::Migration[6.0]
  def change
    create_view :all_forecasts, version: 6, materialized: true
  end
end
