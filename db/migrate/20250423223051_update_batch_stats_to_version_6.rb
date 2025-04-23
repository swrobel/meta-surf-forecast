class UpdateBatchStatsToVersion6 < ActiveRecord::Migration[8.0]
  def change
    update_view :batch_stats,
                version: 6,
                revert_to_version: 5,
                materialized: true
  end
end
