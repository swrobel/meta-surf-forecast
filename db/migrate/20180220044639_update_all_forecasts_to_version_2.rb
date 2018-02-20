class UpdateAllForecastsToVersion2 < ActiveRecord::Migration[5.2]
  def change
    update_view :all_forecasts, materialized: true, version: 2, revert_to_version: 1
  end
end
