# frozen_string_literal: true

class SubregionsController < ApplicationController
  def show
    zone = ActiveSupport::TimeZone.new(subregion.timezone)
    zone_id = zone.tzinfo.identifier
    forecasts ||= Spot.connection.select_all <<-SQL
      SELECT
         id AS spot_id
        ,name
        ,slug
        ,lat
        ,lon
        ,msw_id
        ,msw_slug
        ,spitcast_id
        ,spitcast_slug
        ,surfline_v1_id
        ,surfline_v2_id
        ,s.updated_at AS spot_updated_at
        ,timestamp
        ,round(min(min_height), 1) AS min
        ,round(avg(avg_height) - min(min_height), 1) AS avg_delta
        ,round(max(max_height) - avg(avg_height), 1) AS max_delta
        ,max(max_height) AS max
        ,round(avg(rating)) AS avg_rating
      FROM all_forecasts sub
      JOIN spots s ON sub.spot_id = s.id
      WHERE sub.timestamp > now() at time zone '#{zone_id}'
        AND sub.updated_at > now() at time zone '#{zone_id}' - interval '1 day'
        AND extract(hour from sub.timestamp)::integer % 3 = 0
        AND s.subregion_id = #{subregion.id}
      GROUP BY id
              ,name
              ,slug
              ,lat
              ,lon
              ,timestamp
              ,surfline_v1_id
              ,msw_id
              ,msw_slug
              ,spitcast_id
              ,spitcast_slug
              ,surfline_v2_id
              ,s.updated_at
      HAVING count(*) >= CASE
                           WHEN s.surfline_v2_id IS NOT NULL THEN 1
                           ELSE 0
                         END +
                         CASE
                           WHEN s.msw_id IS NOT NULL THEN 1
                           ELSE 0
                         END
      ORDER BY sort_order
              ,id
              ,timestamp
    SQL
    @max = 0.0
    forecasts.each(&:symbolize_keys!)
    forecasts.each do |forecast|
      forecast[:xaxis_time] = helpers.format_timestamp(forecast[:timestamp])
      forecast[:tooltip_time] = forecast[:timestamp].strftime('%a, %b %-e, %-l %p')
      %i[max min avg_delta max_delta].each do |field|
        forecast[field] = forecast[field].to_f
      end
      @max = [forecast[:max], @max].max
      forecast[:avg_rating] = forecast[:avg_rating].to_i
    end
    @spots = forecasts.group_by do |s|
      { spot_id: s[:spot_id],
        name: s[:name],
        slug: s[:slug],
        lat: s[:lat],
        lon: s[:lon],
        msw_id: s[:msw_id],
        msw_slug: s[:msw_slug],
        spitcast_id: s[:spitcast_id],
        spitcast_slug: s[:spitcast_slug],
        surfline_v1_id: s[:surfline_v1_id],
        surfline_v2_id: s[:surfline_v2_id],
        spot_updated_at: s[:spot_updated_at] }
    end
  end

private

  def region
    @region ||= Region.find(params[:region_id])
  end

  def subregion
    @subregion ||= region.subregions.find(params[:subregion_id])
  end
end
