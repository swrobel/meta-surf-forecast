class AddIndexOnBatchIdToApiRequests < ActiveRecord::Migration[6.0]
  disable_ddl_transaction!

  def change
    add_index :api_requests, [:batch_id], algorithm: :concurrently
  end
end
