# frozen_string_literal: true

namespace :msw do
  desc 'Update forecast from MagicSeaweed'
  task update: :environment do
    logger.info 'Updating MagicSeaweed data...'
    pool = Concurrent::FixedThreadPool.new(ENV['MAX_WORKER_THREADS'] || 5)
    Spot.where.not(msw_id: nil).each do |spot|
      pool.post { Msw.api_pull(spot) }
    end
    pool.shutdown
    pool.wait_for_termination
  end
end
