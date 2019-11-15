# frozen_string_literal: true

namespace :forecasts do
  desc 'Update forecasts from all sources'
  task update: %w[set_batch_id update_forecasts set_batch_duration database_views:refresh cache:prune]

  multitask update_forecasts: %w[surfline_v1:update surfline_v2:update msw:update spitcast:update]

  desc 'Grab highest batch id from the db & increment by 1'
  task set_batch_id: :environment do
    @batch ||= UpdateBatch.create!
  end

  desc 'Record the duration the batch took to execute'
  task set_batch_duration: :environment do
    @batch.set_duration!
  end
end
