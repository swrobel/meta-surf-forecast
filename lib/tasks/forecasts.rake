# frozen_string_literal: true

namespace :forecasts do
  desc 'Update forecasts from all sources'
  task update: %w[set_batch_id concurrent_update set_batch_duration database_views:refresh cache:prune cleanup:prune_api_requests]

  desc 'Update all forecasts indefinitely with a random wait period between'
  task :daemon_update do
    loop do
      Rake::Task['forecasts:update'].invoke
      sleep rand(24..36) * 60 # 24 - 36 minutes
    end
  end

  multitask concurrent_update: %w[surfline_v1:update surfline_v2:update spitcast_v2:update msw:update]

  desc 'Grab highest batch id from the db & increment by 1'
  task set_batch_id: :environment do
    @batch ||= UpdateBatch.create!
  end

  desc 'Record the duration the batch took to execute'
  task set_batch_duration: :environment do
    @batch.set_duration!
  end
end
