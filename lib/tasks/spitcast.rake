# frozen_string_literal: true

namespace :spitcast do
  desc 'Update forecast from Spitcast'
  task update: %w[environment forecasts:set_batch_id] do
    Rails.logger.info 'Updating Spitcast data...'
    pool = Concurrent::FixedThreadPool.new(ENV['MAX_WORKER_THREADS'] || 5)
    Spot.where.not(spitcast_id: nil).each do |spot|
      pool.post { Spitcast.api_pull(spot) }
    end
    pool.shutdown
    pool.wait_for_termination
    Rails.logger.info 'Finished updating Spitcast data'
  end
end
