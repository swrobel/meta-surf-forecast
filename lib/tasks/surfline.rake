# frozen_string_literal: true

namespace :surfline do
  desc 'Update forecast from Surfline'
  task update: :environment do
    spots = [
      Spot.find_by(surfline_id: 4211),
      Spot.find_by(surfline_id: 4203),
      Spot.find_by(surfline_id: 4127),
      Spot.find_by(surfline_id: 4190),
    ]

    spots.each do |spot|
      next unless spot
      SurflineNearshore.api_pull(spot)
      SurflineLola.api_pull(spot)
    end
  end
end
