class AddRegionIdToSpots < ActiveRecord::Migration[5.1]
  def change
    add_reference :spots, :region, foreign_key: true
  end
end
