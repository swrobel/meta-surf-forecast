# frozen_string_literal: true

namespace :cleanup do
  desc 'remove api_requests more than 30 days old'
  task prune_api_requests: :environment do
    include ActionView::Helpers::DateHelper

    start_time = Time.current
    Rails.logger.info 'Pruning ApiRequests more than 30 days old...'
    ApiRequest.connection.execute <<-SQL.squish
      delete from api_requests where created_at < now() - interval '30 day'
    SQL
    Rails.logger.info "Finished pruning ApiRequests in #{distance_of_time_in_words_to_now(start_time)}"
  end

  desc 'Remove forecasts that are in the past'
  task prune_past_forecasts: :environment do
    SurflineV2Lotus.unscoped.past.delete_all
    SpitcastV2.unscoped.past.delete_all
    Rake::Task['cleanup:prune_api_requests'].invoke
  end

  desc 'Remove forecasts that are in the future'
  task wipe_future_forecasts: :environment do
    SurflineV2Lotus.unscoped.future.delete_all
    SpitcastV2.unscoped.future.delete_all
    Rake::Task['cleanup:prune_api_requests'].invoke
  end
end
