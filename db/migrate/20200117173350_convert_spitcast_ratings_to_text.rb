class ConvertSpitcastRatingsToText < ActiveRecord::Migration[6.0]
  def change
    drop_view :consolidated_forecasts, materialized: true
    drop_view :all_forecasts, materialized: true
    change_column :spitcasts, :rating, :string
  end
end
