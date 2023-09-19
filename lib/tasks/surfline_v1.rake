# frozen_string_literal: true

namespace :surfline_v1 do
  desc 'Update forecast from Surfline v1 API'
  task update: %w[environment forecasts:get_batch] do
    include ActionView::Helpers::DateHelper

    start_time = Time.current
    Rails.logger.info 'Updating Surfline v1 data...'

    hydra = Typhoeus::Hydra.new(max_concurrency: @batch.concurrency)

    Spot.where.not(surfline_v1_id: nil).find_each do |spot|
      ApiRequest.new(batch: @batch, requestable: spot, service: SurflineNearshore, options: { get_all_spots: false }, hydra:).get
      ApiRequest.new(batch: @batch, requestable: spot, service: SurflineLola, options: { get_all_spots: false }, hydra:).get
    end

    hydra.run

    Rails.logger.info "Finished updating Surfline v1 data in #{distance_of_time_in_words_to_now(start_time)}"
  end
end
