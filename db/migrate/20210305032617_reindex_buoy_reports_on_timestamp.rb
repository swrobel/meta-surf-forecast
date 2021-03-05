class ReindexBuoyReportsOnTimestamp < ActiveRecord::Migration[6.1]
  disable_ddl_transaction!
  
  def change
    remove_index :buoy_reports, [:buoy_id, :timestamp]
    add_index :buoy_reports, :timestamp, algorithm: :concurrently
  end
end
