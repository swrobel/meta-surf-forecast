class CreateSpitcastV2s < ActiveRecord::Migration[6.0]
  def change
    create_table :spitcast_v2s do |t|
      t.belongs_to :spot, null: false, foreign_key: true, index: false
      t.datetime :timestamp, null: false
      t.decimal :height, null: false
      t.decimal :rating, null: false
      t.belongs_to :api_request, null: false, foreign_key: true

      t.timestamps
    end
    add_index :spitcast_v2s, [:spot_id, :timestamp]
    drop_view :consolidated_forecasts, materialized: true
    drop_view :all_forecasts, materialized: true
    rename_table :spitcasts, :spitcast_v1s
  end
end
