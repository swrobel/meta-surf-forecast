class CreateBuoyReports < ActiveRecord::Migration[6.0]
  def change
    create_table :buoy_reports do |t|
      t.belongs_to :buoy, null: false, foreign_key: true
      t.datetime :timestamp, null: false
      t.decimal :ground_swell_height
      t.decimal :ground_swell_period
      t.decimal :ground_swell_direction
      t.decimal :wind_swell_height
      t.decimal :wind_swell_period
      t.decimal :wind_swell_direction
      t.string :steepness
      t.decimal :sig_wave_height
      t.decimal :avg_period
      t.integer :mean_wave_direction
      t.belongs_to :api_request, null: false, foreign_key: true

      t.timestamps
    end
  end
end
