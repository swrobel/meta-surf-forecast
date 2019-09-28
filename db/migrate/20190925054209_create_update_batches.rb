class CreateUpdateBatches < ActiveRecord::Migration[6.0]
  def up
    create_table :update_batches do |t|
      t.integer :concurrency
      t.interval :duration
      t.integer :requests_count

      t.timestamps
    end
    ApiRequest.update_all(batch_id: nil)
    add_foreign_key :api_requests, :update_batches, column: :batch_id
  end

  def down
    remove_foreign_key :api_requests, :update_batches, column: :batch_id
    drop_table :update_batches
  end
end
