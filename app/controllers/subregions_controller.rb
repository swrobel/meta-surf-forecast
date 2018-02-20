# frozen_string_literal: true

class SubregionsController < ApplicationController
  def show
    forecasts ||= Spot.connection.select_all <<-SQL
      SELECT
         id
        ,name
        ,slug
        ,lat
        ,lon
        ,msw_id
        ,msw_slug
        ,spitcast_id
        ,spitcast_slug
        ,surfline_id
        ,surfline_slug
        ,timestamp
        ,round(min(min_height), 1) AS min
        ,round(avg(avg_height) - min(min_height), 1) AS avg_delta
        ,round(max(max_height) - avg(avg_height), 1) AS max_delta
        ,max(max_height) AS max
        ,round(avg(rating)) AS avg_rating
      FROM all_forecasts sub
      JOIN spots s ON sub.spot_id = s.id
      WHERE sub.timestamp > now() at time zone 'utc'
        AND sub.updated_at > now() at time zone 'utc' - interval '1 day'
        AND s.subregion_id = #{subregion.id}
      GROUP BY id
              ,name
              ,slug
              ,lat
              ,lon
              ,timestamp
              ,surfline_id
              ,surfline_slug
              ,msw_id
              ,msw_slug
              ,spitcast_id
              ,spitcast_slug
      HAVING count(*) >= CASE
                           WHEN s.surfline_id IS NOT NULL THEN 2
                           ELSE 1
                         END +
                         CASE
                           WHEN s.spitcast_id IS NOT NULL THEN 1
                           ELSE 0
                         END
      ORDER BY sort_order
              ,id
              ,timestamp
    SQL
    @max = 0.0
    forecasts.each(&:symbolize_keys!)
    forecasts.each_with_index do |forecast, _index|
      forecast[:timestamp] = Time.zone.parse("#{forecast[:timestamp]} UTC").in_time_zone(subregion.timezone)
      forecast[:time] = helpers.format_timestamp(forecast[:timestamp])
      %i[max min avg_delta max_delta].each do |field|
        forecast[field] = forecast[field].to_f
      end
      @max = [forecast[:max], @max].max
      forecast[:avg_rating] = forecast[:avg_rating].to_i
    end
    @spots = forecasts.group_by { |s| { id: s[:id], name: s[:name], slug: s[:slug], lat: s[:lat], lon: s[:lon], msw_id: s[:msw_id], msw_slug: s[:msw_slug], spitcast_id: s[:spitcast_id], spitcast_slug: s[:spitcast_slug], surfline_id: s[:surfline_id], surfline_slug: s[:surfline_slug] } }
  end

private

  def region
    @region ||= Region.find(params[:region_id])
  end

  def subregion
    @subregion ||= region.subregions.find(params[:subregion_id])
  end
end
