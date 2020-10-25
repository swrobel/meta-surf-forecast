namespace :buoys do
  desc 'Update buoy data from NDBC'
  task update: %w[environment forecasts:set_batch_id] do
    include ActionView::Helpers::DateHelper

    start_time = Time.current
    Rails.logger.info 'Updating NDBC buoy data...'

    hydra = Typhoeus::Hydra.new(max_concurrency: @batch.concurrency)

    Buoy.all.each do |buoy|
      ApiRequest.new(batch: @batch, requestable: buoy, service: BuoyReport, hydra: hydra).get
    end

    hydra.run

    Rails.logger.info "Finished updating NDBC buoy data in #{distance_of_time_in_words_to_now(start_time)}"
  end
end
