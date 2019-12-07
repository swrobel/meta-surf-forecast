class CreateBatchStats < ActiveRecord::Migration[6.0]
  def change
    create_view :batch_stats, materialized: true
  end
end
