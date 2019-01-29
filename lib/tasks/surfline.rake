# frozen_string_literal: true

namespace :surfline do
  desc 'Update forecast from Surfline'
  task update: :environment do
    Rails.logger.info 'Updating Surfline data...'
    pool = Concurrent::FixedThreadPool.new(ENV['MAX_WORKER_THREADS'] || 5)
    # Preload these classes to avoid threads causing circular dependency errors
    ApiRequest
    Surfline
    SurflineNearshore
    SurflineLola
    Subregion.all.each do |subregion|
      get_all_spots = subregion.spots.size > 1
      spot = subregion.spots.first
      pool.post { SurflineNearshore.api_pull(spot, get_all_spots) }
      pool.post { SurflineLola.api_pull(spot, get_all_spots) }

      # These subregions contain two surfline regions, so we need to do two separate requests for them
      next unless ['los-angeles', 'santa-barbara-ventura'].include? subregion.slug

      spot2 = subregion.spots.last
      pool.post { SurflineNearshore.api_pull(spot2, get_all_spots) }
      pool.post { SurflineLola.api_pull(spot2, get_all_spots) }
    end

    pool.shutdown
    pool.wait_for_termination
    Rails.logger.info 'Finished updating Surfline data'
  end
end
