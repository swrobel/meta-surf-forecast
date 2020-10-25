class AddTimezoneToRegions < ActiveRecord::Migration[6.0]
  def change
    add_column :regions, :timezone, :string
  end

  def up
    BuoyReport.destroy_all
  end
end
