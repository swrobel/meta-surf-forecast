# frozen_string_literal: true

class SeparateNorthernAndSouthernCalifornia < ActiveRecord::Migration[7.0]
  def up
    Region.find_by(name: 'California')&.update!(name: 'Northern California')
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
