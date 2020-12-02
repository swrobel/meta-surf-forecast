# frozen_string_literal: true

namespace :cache do
  desc 'Prune Rails cache'
  task prune: :environment do
    include ActionView::Helpers::DateHelper

    start_time = Time.current
    Rails.logger.info "Deleting Rails cache keys marked with #{EXPIRE_ON_UPDATE_KEY}..."
    cache_key = if Rails.application.config.cache_store.first == :redis_cache_store
                  "*#{EXPIRE_ON_UPDATE_KEY}*"
                else
                  /#{EXPIRE_ON_UPDATE_KEY}/o
                end
    Rails.cache.delete_matched(cache_key)
    Rails.logger.info "Finished pruning Rails cache in #{distance_of_time_in_words_to_now(start_time)}"
  end
end
