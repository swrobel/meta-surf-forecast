class CreateWaterQualities < ActiveRecord::Migration[5.0]
  def change
    create_table :water_qualities do |t|
      t.belongs_to :dept, foreign_key: { to_table: :water_quality_departments }, index: false
      t.string :site_id
      t.datetime :timestamp
      t.string :name
      t.boolean :ok
      t.string :comments
      t.float :lat
      t.float :lon

      t.timestamps
    end

    add_index :water_qualities, [:dept_id, :site_id, :timestamp]
  end
end
