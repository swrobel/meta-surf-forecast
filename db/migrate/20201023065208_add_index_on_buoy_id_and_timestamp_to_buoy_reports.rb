class AddIndexOnBuoyIdAndTimestampToBuoyReports < ActiveRecord::Migration[6.0]
  disable_ddl_transaction!

  def change
    add_index :buoy_reports, [:buoy_id, :timestamp], algorithm: :concurrently
  end
end
