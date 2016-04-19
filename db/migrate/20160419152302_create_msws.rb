class CreateMsws < ActiveRecord::Migration[5.0]
  def change
    create_table :msws do |t|
      t.belongs_to :spot, foreign_key: true, index: false
      t.datetime :timestamp
      t.decimal :min_height
      t.decimal :max_height
      t.integer :rating
      t.integer :wind_effect
      t.belongs_to :api_request, foreign_key: true

      t.timestamps
    end

    add_index :msws, [:spot_id, :timestamp]
  end
end
