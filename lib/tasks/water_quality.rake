namespace :water_quality do
  desc 'Update forecast from Water Quality Departments'
  task update: :environment do
    WaterQuality.la_public_health_pull
  end
end
