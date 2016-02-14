class CreateMsws < ActiveRecord::Migration[5.0]
  def change
    create_table :msws do |t|
      t.integer :spot_id
      t.datetime :timestamp
      t.decimal :min_height
      t.decimal :max_height
      t.integer :rating
      t.integer :wind_effect
      t.integer :api_request_id

      t.timestamps
    end
  end
end
