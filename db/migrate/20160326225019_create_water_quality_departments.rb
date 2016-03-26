class CreateWaterQualityDepartments < ActiveRecord::Migration[5.0]
  def change
    create_table :water_quality_departments do |t|
      t.string :name
      t.string :code
      t.string :url

      t.timestamps
    end
  end
end
