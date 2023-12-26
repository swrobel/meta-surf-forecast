class AddUniqueIndexToRegionName < ActiveRecord::Migration[7.0]
  def change
    add_index :regions, :name, unique: true
  end
end
