class AddRetriesToApiRequests < ActiveRecord::Migration[6.0]
  def change
    add_column :api_requests, :retries, :integer
  end
end
