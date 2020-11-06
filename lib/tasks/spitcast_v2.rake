# frozen_string_literal: true

namespace :spitcast_v2 do
  desc 'Update forecast from Spitcast v2'
  task update: %w[environment forecasts:get_batch] do
    include ActionView::Helpers::DateHelper

    start_time = Time.current
    Rails.logger.info 'Updating Spitcast v2 data...'

    # pipelining 2 means HTTP/2 multiplexing https://curl.haxx.se/libcurl/c/CURLMOPT_PIPELINING.html
    hydra = Typhoeus::Hydra.new(max_concurrency: @batch.concurrency, pipelining: 2)

    Spot.where.not(spitcast_id: nil).each do |spot|
      ApiRequest.new(batch: @batch, requestable: spot, service: SpitcastV2, hydra: hydra).get
    end

    hydra.run

    Rails.logger.info "Finished updating Spitcast v2 data in #{distance_of_time_in_words_to_now(start_time)}"
  end
end
