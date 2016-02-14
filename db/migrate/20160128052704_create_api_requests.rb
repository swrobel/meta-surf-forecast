class CreateApiRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :api_requests do |t|
      t.string :request
      t.json :response
      t.boolean :success

      t.timestamps
    end
  end
end
