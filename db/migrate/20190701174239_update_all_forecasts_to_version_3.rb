class UpdateAllForecastsToVersion3 < ActiveRecord::Migration[6.0]
  def change
    update_view :all_forecasts, materialized: true, version: 3, revert_to_version: 2
  end
end
