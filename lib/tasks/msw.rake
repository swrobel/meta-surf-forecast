# frozen_string_literal: true

namespace :msw do
  desc 'Update forecast from MagicSeaweed'
  task update: %w[environment forecasts:set_batch_id] do
    Rails.logger.info 'Updating MagicSeaweed data...'
    pool = Concurrent::FixedThreadPool.new(ENV['MAX_WORKER_THREADS'] || 5)
    Spot.where.not(msw_id: nil).each do |spot|
      pool.post { Msw.api_pull(spot) }
    end
    pool.shutdown
    pool.wait_for_termination
    Rails.logger.info 'Finished updating MagicSeaweed data'
  end
end
