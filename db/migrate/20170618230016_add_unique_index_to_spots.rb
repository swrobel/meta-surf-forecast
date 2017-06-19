class AddUniqueIndexToSpots < ActiveRecord::Migration[5.1]
  def change
    add_index :spots, [:msw_id, :surfline_id, :spitcast_id], unique: true
  end
end
