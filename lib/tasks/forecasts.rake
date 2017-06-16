# frozen_string_literal: true

namespace :forecasts do
  desc 'Update forecasts from all sources'
  multitask update: ['surfline:update', 'msw:update', 'spitcast:update']
end
