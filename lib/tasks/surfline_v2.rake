# frozen_string_literal: true

namespace :surfline_v2 do
  desc 'Update forecast from Surfline v2 API'
  task update: %w[environment forecasts:get_batch] do
    include ActionView::Helpers::DateHelper

    start_time = Time.current
    Rails.logger.info 'Updating Surfline v2 data...'

    surfline_v2_spots = Spot.where.not(surfline_v2_id: nil)
    first_spot = surfline_v2_spots.first

    first_quest = ApiRequest.new(batch: @batch, requestable: first_spot, service: SurflineV2Lotus)
    first_quest.get(max_retries: 0)
    # Early exit if the first request fails, usually because of an access token issue. Don't want to stampede Surfline in that case.
    if first_quest.success?
      hydra = Typhoeus::Hydra.new(max_concurrency: @batch.concurrency)

      surfline_v2_spots.where.not(id: first_spot.id).find_each do |spot|
        ApiRequest.new(batch: @batch, requestable: spot, service: SurflineV2Lotus, hydra:).get
      end

      hydra.run
    end

    Rails.logger.info "Finished updating Surfline v2 data in #{distance_of_time_in_words_to_now(start_time)}"
  end
end
