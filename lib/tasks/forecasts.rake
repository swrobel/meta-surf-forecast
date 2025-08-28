# frozen_string_literal: true

namespace :forecasts do
  desc 'Update forecasts from all sources'
  task update: %w[get_batch concurrent_update set_batch_duration cleanup:prune_api_requests database_views:refresh cache:prune]

  multitask concurrent_update: %w[surfline_v2:update spitcast_v2:update]

  desc "Create an UpdateBatch if one doesn't already exist"
  task get_batch: :environment do
    @batch ||= UpdateBatch.create!(kind: :forecast)
  end

  desc 'Record the duration the batch took to execute'
  task set_batch_duration: :environment do
    @batch.set_duration!
  end
end
