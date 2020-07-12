# frozen_string_literal: true

namespace :forecasts do
  desc 'Update forecasts from all sources'
  task update: %w[set_batch_id concurrent_update set_batch_duration cleanup:prune_past_forecasts database_views:refresh cache:prune]

  desc 'Update all forecasts indefinitely with a random wait period between'
  task daemon_update: :environment do
    update_task = Rake::Task['forecasts:update']
    loop do
      update_task.reenable
      update_task.all_prerequisite_tasks.each &:reenable
      update_task.invoke
      sleep_for = rand(24..36)
      Rails.logger.info "Waiting #{sleep_for} minutes before updating forecasts again..."
      sleep sleep_for.minutes
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
