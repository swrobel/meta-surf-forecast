# frozen_string_literal: true
namespace :surfline do
  desc 'Update forecast from Surfline'
  task update: :environment do
    venice = Spot.find_by_surfline_id(4211)
    county_line = Spot.find_by_surfline_id(4203)

    if venice
      SurflineNearshore.api_pull(venice)
      SurflineLola.api_pull(venice)
    end

    if county_line
      SurflineNearshore.api_pull(county_line)
      SurflineLola.api_pull(county_line)
    end
  end
end
