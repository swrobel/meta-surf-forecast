class RenameRegionsToSubregions < ActiveRecord::Migration[5.1]
  def change
    rename_table :regions, :subregions

    rename_column :spots, :region_id, :subregion_id
  end
end
