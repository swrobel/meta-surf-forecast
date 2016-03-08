class CreateWaterQualities < ActiveRecord::Migration[5.0]
  def change
    create_table :water_qualities do |t|
      t.string :dept_id
      t.string :name
      t.boolean :ok
      t.string :comments

      t.timestamps
    end
  end
end
