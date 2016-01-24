class CreateSurflines < ActiveRecord::Migration[5.0]
  def change
    create_table :surflines do |t|
      t.integer :spot_id
      t.datetime :timestamp
      t.decimal :min_height
      t.decimal :max_height
      t.string :quality

      t.timestamps
    end
  end
end
