# frozen_string_literal: true

namespace :spitcast_v1 do
  desc 'Update forecast from Spitcast v1'
  task update: %w[environment forecasts:set_batch_id] do
    include ActionView::Helpers::DateHelper

    start_time = Time.current
    Rails.logger.info 'Updating Spitcast v1 data...'

    hydra = Typhoeus::Hydra.new(max_concurrency: @batch.concurrency)

    Spot.where.not(spitcast_id: nil).each do |spot|
      ApiRequest.new(batch: @batch, requestable: spot, service: SpitcastV1, hydra: hydra).get
    end

    hydra.run

    Rails.logger.info "Finished updating Spitcast v1 data in #{distance_of_time_in_words_to_now(start_time)}"
  end
end
