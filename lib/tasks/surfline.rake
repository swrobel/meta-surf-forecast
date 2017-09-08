# frozen_string_literal: true

def get_surfline_data(spot, get_all_spots)
  SurflineNearshore.api_pull(spot, get_all_spots)
  SurflineLola.api_pull(spot, get_all_spots)
end

namespace :surfline do
  desc 'Update forecast from Surfline'
  task update: :environment do
    Subregion.all.each do |subregion|
      num_spots = subregion.spots.size
      get_all_spots = num_spots > 1
      get_surfline_data(subregion.spots.first, get_all_spots)
      # TODO: better logic for subregions that encompass multiple Surfline regions
      get_surfline_data(subregion.spots.last, get_all_spots) if num_spots > 10
    end
  end
end
