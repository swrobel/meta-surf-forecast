class AddSortOrderAndNewIndexesToSpots < ActiveRecord::Migration[5.1]
  def change
    add_column :spots, :sort_order, :integer

    remove_index :spots, :slug
    remove_index :spots, :subregion_id
    add_index :spots, [:subregion_id, :slug], unique: true
    add_index :spots, [:subregion_id, :sort_order], unique: true
  end
end
