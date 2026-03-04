# frozen_string_literal: true

class SeparateTorranceBeachAndHaggertys < ActiveRecord::Migration[8.1]
  def up
    Spot.find_by(name: 'Torrance Beach/Haggertys')&.update!(name: "Haggerty's")
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
