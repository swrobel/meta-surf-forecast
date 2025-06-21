class DropUnsupportedForecasts < ActiveRecord::Migration[8.0]
  def change
    drop_table :msws
    drop_table :spitcast_v1s
    drop_table :surfline_lolas
    drop_table :surfline_nearshores
    drop_table :surfline_v2_lolas
    remove_column :spots, :msw_id
    remove_column :spots, :surfline_v1_id
  end
end
