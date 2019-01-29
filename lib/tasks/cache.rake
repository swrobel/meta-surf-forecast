# frozen_string_literal: true

namespace :cache do
  desc 'Clear Rails cache'
  task clear: :environment do
    Rails.logger.info 'Clearing Rails cache...'
    Rails.cache.clear
    Rails.logger.info 'Finished clearing Rails cache'
  end
end
