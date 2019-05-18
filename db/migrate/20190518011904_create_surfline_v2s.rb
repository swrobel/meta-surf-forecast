class CreateSurflineV2s < ActiveRecord::Migration[6.0]
  def change
    create_table :surfline_v2s do |t|
      t.belongs_to :spot, null: false, foreign_key: true, index: false
      t.datetime :timestamp
      t.decimal :min_height
      t.decimal :max_height
      t.integer :swell_rating
      t.integer :wind_rating
      t.belongs_to :api_request, null: false, foreign_key: true

      t.timestamps
    end

    add_index :surfline_v2s, [:spot_id, :timestamp]
  end
end
