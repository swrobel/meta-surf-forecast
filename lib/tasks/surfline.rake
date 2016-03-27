namespace :surfline do
  desc "Update forecast from Surfline"
  task update: :environment do
    venice = Spot.find_by_surfline_id(4211)
    county = Spot.find_by_surfline_id(4203)
    Surfline.api_pull(venice, true) # second param is to get all spots
    Surfline.api_pull(county, true)
  end
end
