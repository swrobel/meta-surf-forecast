class AddBatchIdToApiRequests < ActiveRecord::Migration[6.0]
  def change
    add_column :api_requests, :batch_id, :integer
  end
end
