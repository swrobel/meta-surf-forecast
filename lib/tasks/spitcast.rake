# frozen_string_literal: true

namespace :spitcast do
  desc 'Update forecast from Spitcast'
  task update: :environment do
    logger.info 'Updating Spitcast data...'
    pool = Concurrent::FixedThreadPool.new(ENV['MAX_WORKER_THREADS'] || 5)
    Spot.where.not(spitcast_id: nil).each do |spot|
      pool.post { Spitcast.api_pull(spot) }
    end
    pool.shutdown
    pool.wait_for_termination
  end
end
