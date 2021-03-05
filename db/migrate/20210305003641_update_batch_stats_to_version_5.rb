class UpdateBatchStatsToVersion5 < ActiveRecord::Migration[6.1]
  def change
    update_view :batch_stats,
      version: 5,
      revert_to_version: 4,
      materialized: true
  end
end
