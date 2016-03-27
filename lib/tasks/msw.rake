namespace :msw do
  desc "Update forecast from MagicSeaweed"
  task update: :environment do
    Spot.where.not(msw_id: nil).each do |spot|
      Msw.api_pull(spot)
    end
  end
end
