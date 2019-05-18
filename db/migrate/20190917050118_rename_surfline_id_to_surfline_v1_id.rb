class RenameSurflineIdToSurflineV1Id < ActiveRecord::Migration[6.0]
  def change
    rename_column :spots, :surfline_id, :surfline_v1_id
  end
end
