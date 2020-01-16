class CreateConsolidatedForecasts < ActiveRecord::Migration[6.0]
  def change
    create_view :consolidated_forecasts, materialized: true
  end
end
