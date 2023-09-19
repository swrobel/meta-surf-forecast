# frozen_string_literal: true

namespace :msw do
  desc 'Update forecast from MagicSeaweed'
  task update: %w[environment forecasts:get_batch] do
    include ActionView::Helpers::DateHelper

    start_time = Time.current
    Rails.logger.info 'Updating MagicSeaweed data...'

    hydra = Typhoeus::Hydra.new(max_concurrency: @batch.concurrency)

    Spot.where.not(msw_id: nil).find_each do |spot|
      ApiRequest.new(batch: @batch, requestable: spot, service: Msw, hydra:, typhoeus_opts: { cookie: "MSW_session=#{ENV.fetch('MSW_SESSION_ID', nil)}" }).get
    end

    hydra.run

    Rails.logger.info "Finished updating MagicSeaweed data in #{distance_of_time_in_words_to_now(start_time)}"
  end
end
