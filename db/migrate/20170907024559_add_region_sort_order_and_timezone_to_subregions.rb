class AddRegionSortOrderAndTimezoneToSubregions < ActiveRecord::Migration[5.1]
  def change
    add_column :subregions, :timezone, :string
    add_reference :subregions, :region, foreign_key: true, index: false
    add_column :subregions, :sort_order, :integer
    add_index :subregions, [:region_id, :sort_order], unique: true
    remove_index :subregions, :slug
    add_index :subregions, [:region_id, :slug], unique: true

    reversible do |dir|
      dir.up do
        if Spot.any?
          cal = Region.find_or_create_by(name: 'California', sort_order: 10)
          Subregion.update_all(region_id: cal.id)
        end
      end
    end
  end
end
