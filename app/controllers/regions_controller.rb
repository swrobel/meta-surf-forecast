# frozen_string_literal: true

class RegionsController < ApplicationController
  before_action :set_region

  def show
    @forecasts = Spot.connection.select_all <<-SQL
      SELECT id
            ,name
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
        FROM
        ( SELECT 'msw'
                 ,spot_id
                 ,timestamp
                 ,min_height
                 ,max_height
                 ,(min_height + max_height) / 2 AS avg_height
         FROM msws
         UNION SELECT 'spitcast'
                      ,spot_id
                      ,timestamp
                      ,height AS min_height
                      ,height AS max_height
                      ,height AS avg_height
         FROM spitcasts
         UNION SELECT 'lola'
                      ,spot_id
                      ,timestamp
                      ,min_height
                      ,max_height
                      ,(min_height + max_height) / 2 AS avg_height
         FROM surfline_lolas
         UNION SELECT 'nearshore'
                      ,spot_id
                      ,timestamp
                      ,min_height
                      ,max_height
                      ,(min_height + max_height) / 2 AS avg_height
         FROM surfline_nearshores) sub
        JOIN spots s ON sub.spot_id = s.id
        WHERE sub.timestamp > now() at time zone 'utc'
          AND sub.timestamp <= (select max(timestamp) from spitcasts)
          AND s.region_id = #{@region.id}
        GROUP BY id
                ,name
                ,lat
                ,lon
                ,timestamp
                ,surfline_id
                ,surfline_slug
                ,msw_id
                ,msw_slug
                ,spitcast_id
                ,spitcast_slug
        HAVING count(*) = CASE
                            WHEN s.surfline_id IS NULL THEN 0
                            ELSE 2
                        END
                        + CASE
                          WHEN s.msw_id IS NULL THEN 0
                          ELSE 1
                        END
                        + CASE
                            WHEN s.spitcast_id IS NULL THEN 0
                            ELSE 1
                        END
        ORDER BY id,
                 timestamp
    SQL
    @forecasts.map(&:symbolize_keys!)
    @forecasts.map! do |forecast|
      forecast[:time] = helpers.format_timestamp(Time.zone.parse("#{forecast[:timestamp]} UTC"))
    end
    @max = @forecasts.collect { |s| s[:max].to_d }.max
    @forecasts = @forecasts.group_by { |s| { id: s[:id], name: s[:name], lat: s[:lat], lon: s[:lon], msw_id: s[:msw_id], msw_slug: s[:msw_slug], spitcast_id: s[:spitcast_id], spitcast_slug: s[:spitcast_slug], surfline_id: s[:surfline_id], surfline_slug: s[:surfline_slug] } }
  end

private

  def set_region
    @region = Region.find(params[:id])
  end
end
