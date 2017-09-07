class CreateNewRegions < ActiveRecord::Migration[5.1]
  def change
    create_table :regions do |t|
      t.string :name
      t.string :slug
      t.integer :sort_order
    end
    add_index :regions, :slug, unique: true
    add_index :regions, :sort_order, unique: true
  end
end
