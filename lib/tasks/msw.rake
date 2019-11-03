# frozen_string_literal: true

namespace :msw do
  desc 'Update forecast from MagicSeaweed'
  task update: %w[environment forecasts:set_batch_id] do
    include ActionView::Helpers::DateHelper

    start_time = Time.current
    Rails.logger.info 'Updating MagicSeaweed data...'

    hydra = Typhoeus::Hydra.new(max_concurrency: @batch.concurrency)

    Spot.where.not(msw_id: nil).each do |spot|
      ApiRequest.new(batch: @batch, requestable: spot, service: Msw, hydra: hydra, typhoeus_opts: { cookie: "MSW_session=#{ENV['MSW_SESSION_ID']}" }).get
    end

    hydra.run

    Rails.logger.info "Finished updating MagicSeaweed data in #{distance_of_time_in_words_to_now(start_time)}"
  end
end
