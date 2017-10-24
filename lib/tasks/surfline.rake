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
      get_surfline_data(subregion.spots.last, get_all_spots) if subregion.slug == 'los-angeles'
    end
  end
end
