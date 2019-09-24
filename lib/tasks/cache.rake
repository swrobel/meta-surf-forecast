# frozen_string_literal: true

namespace :cache do
  desc 'Prune Rails cache'
  task prune: :environment do
    Rails.logger.info "Deleting Rails cache keys marked with #{EXPIRE_ON_UPDATE_KEY}..."
    Rails.cache.delete_matched("*#{EXPIRE_ON_UPDATE_KEY}*")
    Rails.logger.info 'Finished pruning Rails cache'
  end
end
