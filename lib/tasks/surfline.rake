namespace :surfline do
  desc 'Update forecast from Surfline'
  task update: :environment do
    venice = Spot.find_by_surfline_id(4211)
    county_line = Spot.find_by_surfline_id(4203)
    Surfline.api_pull(venice) if venice
    Surfline.api_pull(county_line) if county_line
  end
end
