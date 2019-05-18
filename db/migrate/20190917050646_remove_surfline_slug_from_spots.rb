class RemoveSurflineSlugFromSpots < ActiveRecord::Migration[6.0]
  def change
    remove_column :spots, :surfline_slug, :string
  end
end
