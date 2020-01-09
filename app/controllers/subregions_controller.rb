# frozen_string_literal: true

class SubregionsController < ApplicationController
  def show
    forecasts ||= Spot.connection.select_all <<-SQL
      SELECT
         s.id AS spot_id
        ,s.name
        ,s.slug
        ,s.lat
        ,s.lon
        ,msw_id
        ,s.spitcast_id
        ,s.spitcast_slug
        ,s.surfline_v1_id
        ,s.surfline_v2_id
        ,s.updated_at AS spot_updated_at
        ,fc.timestamp
        ,round(avg(min_height), 1) AS min
        ,round(avg(avg_height) - min(min_height), 1) AS avg_delta
        ,round(avg(max_height) - avg(avg_height), 1) AS max_delta
        ,avg(max_height) AS max
        ,round(avg(rating)) AS avg_rating
      FROM all_forecasts fc
      JOIN spots s ON fc.spot_id = s.id
      JOIN subregions sr ON s.subregion_id = sr.id
      WHERE fc.timestamp >= now() at time zone sr.timezone
        AND fc.updated_at >= now() at time zone sr.timezone - interval '1 day'
        AND extract(hour from fc.timestamp)::integer % 3 = 0
        AND sr.id = #{subregion.id}
      GROUP BY s.id
              ,s.name
              ,s.slug
              ,s.lat
              ,s.lon
              ,fc.timestamp
              ,s.surfline_v1_id
              ,s.msw_id
              ,s.spitcast_id
              ,s.spitcast_slug
              ,s.surfline_v2_id
              ,s.updated_at
      HAVING count(*) >= CASE
                           WHEN s.surfline_v2_id IS NOT NULL THEN 1
                           ELSE 0
                         END +
                         CASE
                           WHEN s.msw_id IS NOT NULL THEN 1
                           ELSE 0
                         END
      ORDER BY s.sort_order
              ,s.id
              ,fc.timestamp
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
