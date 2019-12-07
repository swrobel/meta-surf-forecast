class AddRegionSortOrderAndTimezoneToSubregions < ActiveRecord::Migration[5.1]
  def change
    add_column :subregions, :timezone, :string
    add_reference :subregions, :region, foreign_key: true, index: false
    add_column :subregions, :sort_order, :integer
    add_index :subregions, [:region_id, :sort_order], unique: true
    remove_index :subregions, :slug
    add_index :subregions, [:region_id, :slug], unique: true
  end
end
