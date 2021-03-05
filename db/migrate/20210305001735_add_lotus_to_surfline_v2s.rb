class AddLotusToSurflineV2s < ActiveRecord::Migration[6.1]
  def change
    create_table :surfline_v2_lotus do |t|
      t.belongs_to :spot, null: false, foreign_key: true, index: false
      t.datetime :timestamp
      t.decimal :min_height
      t.decimal :max_height
      t.integer :swell_rating
      t.integer :wind_rating
      t.belongs_to :api_request, null: false, foreign_key: true

      t.timestamps
    end

    add_index :surfline_v2_lotus, [:spot_id, :timestamp]

    rename_table :surfline_v2s, :surfline_v2_lolas

    reversible do |dir|
      dir.up do
        ApiRequest.where(service: 'SurflineV2').update_all(service: 'SurflineV2Lola')
      end

      dir.down do
        ApiRequest.where(service: 'SurflineV2Lola').update_all(service: 'SurflineV2')
      end
    end
  end
end
