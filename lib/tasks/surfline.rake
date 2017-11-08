# frozen_string_literal: true

def get_surfline_data(spot, get_all_spots)
  SurflineNearshore.api_pull(spot, get_all_spots)
  SurflineLola.api_pull(spot, get_all_spots)
end

namespace :surfline do
  desc 'Update forecast from Surfline'
  task update: :environment do
    threads = []
    # Preload these classes to avoid threads causing circular dependency errors
    SurflineNearshore
    SurflineLola
    Subregion.all.each do |subregion|
      num_spots = subregion.spots.size
      get_all_spots = num_spots > 1
      threads << Thread.new { get_surfline_data(subregion.spots.first, get_all_spots) }
      if ['los-angeles', 'santa-barbara-ventura'].include? subregion.slug
        threads << Thread.new { get_surfline_data(subregion.spots.last, get_all_spots) }
      end
    end
    threads.each(&:join)
  end
end
