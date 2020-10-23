class CreateBuoys < ActiveRecord::Migration[6.0]
  def change
    create_table :buoys do |t|
      t.string :name, null: false
      t.float :lat, null: false
      t.float :lon, null: false
      t.integer :ndbc_id, null: false
      t.string :slug, null: false
      t.belongs_to :region, null: false, foreign_key: true, index: false
      t.integer :sort_order

      t.timestamps
    end
    add_index :buoys, :ndbc_id, unique: true
    add_index :buoys, [:region_id, :slug], unique: true
    add_index :buoys, [:region_id, :sort_order, :lat, :lon]
  end
end
