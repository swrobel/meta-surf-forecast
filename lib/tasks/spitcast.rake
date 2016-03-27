namespace :spitcast do
  desc "Update forecast from Spitcast"
  task update: :environment do
    Spot.where.not(spitcast_id: nil).each do |spot|
      Spitcast.api_pull(spot)
    end
  end
end
