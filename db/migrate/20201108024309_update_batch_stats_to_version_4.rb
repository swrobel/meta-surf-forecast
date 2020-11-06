class UpdateBatchStatsToVersion4 < ActiveRecord::Migration[6.0]
  def change
    update_view :batch_stats,
      version: 4,
      revert_to_version: 3,
      materialized: true
  end
end
