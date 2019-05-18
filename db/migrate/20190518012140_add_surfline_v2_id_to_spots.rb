class AddSurflineV2IdToSpots < ActiveRecord::Migration[6.0]
  def change
    add_column :spots, :surfline_v2_id, :string
    remove_index :spots, %i[msw_id surfline_id spitcast_id]
    add_index :spots, %i[msw_id surfline_id surfline_v2_id spitcast_id], unique: true, name: 'spots_unique_index'
  end
end
