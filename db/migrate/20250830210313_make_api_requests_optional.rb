class MakeApiRequestsOptional < ActiveRecord::Migration[8.0]
  def up
    # Remove NOT NULL constraints from api_request_id columns
    change_column_null :buoy_reports, :api_request_id, true
    change_column_null :spitcast_v2s, :api_request_id, true
    change_column_null :surfline_v2_lotus, :api_request_id, true

    # Drop existing foreign key constraints
    remove_foreign_key :buoy_reports, :api_requests
    remove_foreign_key :spitcast_v2s, :api_requests
    remove_foreign_key :surfline_v2_lotus, :api_requests

    # Add new foreign key constraints with SET NULL on delete
    add_foreign_key :buoy_reports, :api_requests, on_delete: :nullify
    add_foreign_key :spitcast_v2s, :api_requests, on_delete: :nullify
    add_foreign_key :surfline_v2_lotus, :api_requests, on_delete: :nullify
  end

  def down
    # Drop new foreign key constraints
    remove_foreign_key :buoy_reports, :api_requests
    remove_foreign_key :spitcast_v2s, :api_requests
    remove_foreign_key :surfline_v2_lotus, :api_requests

    # Add back original foreign key constraints
    add_foreign_key :buoy_reports, :api_requests
    add_foreign_key :spitcast_v2s, :api_requests
    add_foreign_key :surfline_v2_lotus, :api_requests

    # Restore NOT NULL constraints
    change_column_null :buoy_reports, :api_request_id, false
    change_column_null :spitcast_v2s, :api_request_id, false
    change_column_null :surfline_v2_lotus, :api_request_id, false
  end
end
