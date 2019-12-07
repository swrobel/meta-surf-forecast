class RemoveRequestsCountFromUpdateBatches < ActiveRecord::Migration[6.0]
  def change
    remove_column :update_batches, :requests_count
  end
end
