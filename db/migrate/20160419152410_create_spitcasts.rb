class CreateSpitcasts < ActiveRecord::Migration[5.0]
  def change
    create_table :spitcasts do |t|
      t.belongs_to :spot, foreign_key: true, index: false
      t.datetime :timestamp
      t.decimal :height
      t.integer :rating
      t.belongs_to :api_request, foreign_key: true

      t.timestamps
    end

    add_index :spitcasts, [:spot_id, :timestamp]
  end
end
