class CreateSpots < ActiveRecord::Migration[5.0]
  def change
    create_table :spots do |t|
      t.string :name
      t.float :lat
      t.float :lon
      t.integer :surfline_id
      t.integer :msw_id
      t.integer :spitcast_id

      t.timestamps
    end
  end
end
