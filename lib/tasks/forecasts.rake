# frozen_string_literal: true

namespace :forecasts do
  desc 'Update forecasts from all sources'
  task update: %w[set_batch_id surfline_v2:update msw:update spitcast:update database_views:refresh cache:prune]

  desc 'Grab highest batch id from the db & increment by 1'
  task set_batch_id: :environment do
    UpdateBatch.id ||= (ApiRequest.maximum(:batch_id) || 0) + 1
  end
end
