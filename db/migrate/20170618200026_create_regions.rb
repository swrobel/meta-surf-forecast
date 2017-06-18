class CreateRegions < ActiveRecord::Migration[5.1]
  def change
    create_table :regions do |t|
      t.string :name
      t.string :slug

      t.timestamps
    end
    add_index :regions, :slug, unique: true
  end
end
