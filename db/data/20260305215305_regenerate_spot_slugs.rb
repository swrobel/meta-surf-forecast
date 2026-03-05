# frozen_string_literal: true

class RegenerateSpotSlugs < ActiveRecord::Migration[8.1]
  def up
    Spot.where('name ~ ?', "[`'’]").find_each do |spot|
      spot.slug = nil
      spot.save!(validate: false)
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
