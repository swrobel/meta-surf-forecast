class AddSlugToSpots < ActiveRecord::Migration[5.0]
  def up
    add_column :spots, :slug, :string
    add_index :spots, :slug, unique: true

    Spot.find_each(&:save) # Generate slugs for all existing spots
  end

  def down
    remove_column :spots, :slug
    remove_index :spots, :slug
  end
end
