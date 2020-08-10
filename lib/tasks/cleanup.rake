# frozen_string_literal: true

namespace :cleanup do
  desc 'remove api_requests not attached to forecasts & more than 7 days old'
  task prune_api_requests: :environment do
    include ActionView::Helpers::DateHelper

    start_time = Time.current
    Rails.logger.info 'Pruning ApiRequests more than 7 days old without attached forecasts...'
    ApiRequest.connection.execute <<-SQL
      delete from api_requests where created_at < now() - interval '7 day' and service = 'Msw' and not exists(select from msws where api_request_id = api_requests.id);
      delete from api_requests where created_at < now() - interval '7 day' and service = 'SpitcastV1' and not exists(select from spitcast_v1s where api_request_id = api_requests.id);
      delete from api_requests where created_at < now() - interval '7 day' and service = 'SpitcastV2' and not exists(select from spitcast_v2s where api_request_id = api_requests.id);
      delete from api_requests where created_at < now() - interval '7 day' and service = 'SurflineV2' and not exists(select from surfline_v2s where api_request_id = api_requests.id);
      delete from api_requests where created_at < now() - interval '7 day' and  service = 'SurflineLola' and not exists(select from surfline_lolas where api_request_id = api_requests.id);
      delete from api_requests where created_at < now() - interval '7 day' and service = 'SurflineNearshore' and not exists(select from surfline_nearshores where api_request_id = api_requests.id);
    SQL
    Rails.logger.info "Finished pruning ApiRequests in #{distance_of_time_in_words_to_now(start_time)}"
  end

  desc 'Remove forecasts that are in the past'
  task prune_past_forecasts: :environment do
    SurflineLola.unscoped.past.delete_all
    SurflineNearshore.unscoped.past.delete_all
    SurflineV2.unscoped.past.delete_all
    Msw.unscoped.past.delete_all
    SpitcastV1.unscoped.past.delete_all
    SpitcastV2.unscoped.past.delete_all
    Rake::Task['cleanup:prune_api_requests'].invoke
  end

  desc 'Remove forecasts that are in the future'
  task wipe_future_forecasts: :environment do
    SurflineLola.unscoped.future.delete_all
    SurflineNearshore.unscoped.future.delete_all
    SurflineV2.unscoped.future.delete_all
    Msw.unscoped.future.delete_all
    SpitcastV1.unscoped.future.delete_all
    SpitcastV2.unscoped.future.delete_all
    Rake::Task['cleanup:prune_api_requests'].invoke
  end
end
