class AddResponseTimeToApiRequests < ActiveRecord::Migration[6.0]
  def change
    add_column :api_requests, :response_time, :float
  end
end
