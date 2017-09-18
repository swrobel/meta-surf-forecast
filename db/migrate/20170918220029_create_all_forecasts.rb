class CreateAllForecasts < ActiveRecord::Migration[5.0]
  def change
    create_view :all_forecasts, materialized: true
    add_index :all_forecasts, :spot_id
    add_index :all_forecasts, :timestamp
  end
end
