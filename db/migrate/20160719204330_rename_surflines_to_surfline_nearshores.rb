class RenameSurflinesToSurflineNearshores < ActiveRecord::Migration[5.0]
  def change
    rename_table :surflines, :surfline_nearshores
  end
end
