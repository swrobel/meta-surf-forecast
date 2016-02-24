class CreateSpitcasts < ActiveRecord::Migration[5.0]
  def change
    create_table :spitcasts do |t|
      t.integer :spot_id
      t.datetime :timestamp
      t.decimal :height
      t.integer :rating
      t.integer :api_request_id

      t.timestamps
    end
  end
end
