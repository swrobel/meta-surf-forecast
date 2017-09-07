# frozen_string_literal: true

namespace :surfline do
  desc 'Update forecast from Surfline'
  task update: :environment do
    Subregion.all.each do |subregion|
      get_all_spots = subregion.spots.size > 1
      spot = subregion.spots.sample
      SurflineNearshore.api_pull(spot, get_all_spots)
      SurflineLola.api_pull(spot, get_all_spots)
    end
  end
end
