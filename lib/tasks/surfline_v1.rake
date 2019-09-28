# frozen_string_literal: true

namespace :surfline_v1 do
  desc 'Update forecast from Surfline v1 API'
  task update: %w[environment forecasts:set_batch_id] do
    include ActionView::Helpers::DateHelper

    start_time = Time.current
    Rails.logger.info 'Updating Surfline v1 data...'

    hydra = Typhoeus::Hydra.new(max_concurrency: 3)

    Subregion.all.each do |subregion|
      get_all_spots = subregion.spots.size > 1
      spot = subregion.spots.first
      ApiRequest.new(batch: @batch, requestable: spot, service: SurflineNearshore, options: { get_all_spots: get_all_spots }, hydra: hydra).get
      ApiRequest.new(batch: @batch, requestable: spot, service: SurflineLola, options: { get_all_spots: get_all_spots }, hydra: hydra).get

      # These subregions contain two surfline regions, so we need to do two separate requests for them
      next unless %w[los-angeles santa-barbara-ventura].include? subregion.slug

      spot2 = subregion.spots.last
      ApiRequest.new(batch: @batch, requestable: spot2, service: SurflineNearshore, options: { get_all_spots: get_all_spots }, hydra: hydra).get
      ApiRequest.new(batch: @batch, requestable: spot2, service: SurflineLola, options: { get_all_spots: get_all_spots }, hydra: hydra).get
    end

    hydra.run

    Rails.logger.info "Finished updating Surfline v1 data in #{distance_of_time_in_words_to_now(start_time)}"
  end
end
