class AddRequestableAndServiceToApiRequests < ActiveRecord::Migration[6.0]
  def change
    add_reference :api_requests, :requestable, polymorphic: true
    add_column :api_requests, :service, :string
  end
end
