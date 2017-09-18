# frozen_string_literal: true

namespace :forecasts do
  desc 'Update forecasts from all sources'
  task update: %w[surfline:update msw:update spitcast:update database_views:refresh]
end
