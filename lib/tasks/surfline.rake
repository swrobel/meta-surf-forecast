# frozen_string_literal: true

namespace :surfline do
  desc 'Update forecast from Surfline'
  task update: %w[environment forecasts:set_batch_id] do
    Rails.logger.info 'Updating Surfline data...'

    hydra = Typhoeus::Hydra.new(max_concurrency: TYPHOEUS_CONCURRENCY)

    Subregion.all.each do |subregion|
      get_all_spots = subregion.spots.size > 1
      spot = subregion.spots.first
      SurflineNearshore.api_pull(spot, get_all_spots: get_all_spots, hydra: hydra)
      SurflineLola.api_pull(spot, get_all_spots: get_all_spots, hydra: hydra)

      # These subregions contain two surfline regions, so we need to do two separate requests for them
      next unless ['los-angeles', 'santa-barbara-ventura'].include? subregion.slug

      spot2 = subregion.spots.last
      SurflineNearshore.api_pull(spot2, get_all_spots: get_all_spots, hydra: hydra)
      SurflineLola.api_pull(spot2, get_all_spots: get_all_spots, hydra: hydra)
    end

    hydra.run

    Rails.logger.info 'Finished updating Surfline data'
  end
end
