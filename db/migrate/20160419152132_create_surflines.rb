class CreateSurflines < ActiveRecord::Migration[5.0]
  def change
    create_table :surflines do |t|
      t.belongs_to :spot, foreign_key: true, index: false
      t.datetime :timestamp
      t.decimal :min_height
      t.decimal :max_height
      t.decimal :swell_rating
      t.boolean :optimal_wind
      t.belongs_to :api_request, foreign_key: true

      t.timestamps
    end

    add_index :surflines, [:spot_id, :timestamp]
  end
end
