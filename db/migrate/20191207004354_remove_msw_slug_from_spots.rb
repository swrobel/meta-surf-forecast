class RemoveMswSlugFromSpots < ActiveRecord::Migration[6.0]
  def change
    remove_column :spots, :msw_slug
  end
end
