class CreateWaterQualities < ActiveRecord::Migration[5.0]
  def change
    create_table :water_qualities do |t|
      t.integer :dept_id
      t.string :site_id
      t.datetime :timestamp
      t.string :name
      t.boolean :ok
      t.string :comments
      t.float :lat
      t.float :lon

      t.timestamps
    end
  end
end
