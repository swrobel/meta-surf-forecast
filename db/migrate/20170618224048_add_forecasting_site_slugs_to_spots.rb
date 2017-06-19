class AddForecastingSiteSlugsToSpots < ActiveRecord::Migration[5.1]
  def change
    add_column :spots, :msw_slug, :string
    add_column :spots, :spitcast_slug, :string
    add_column :spots, :surfline_slug, :string
  end
end
