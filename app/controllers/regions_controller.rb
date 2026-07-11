class RegionsController < ApplicationController
  # 1/3 is the smoothing factor for the exponential weighted moving average
  EWMA_ALPHA = (1r / 3).to_f.freeze

  def buoys
    sql = Buoy.send(
      :sanitize_sql_array,
      [
        <<~SQL.squish,
          WITH RECURSIVE bounds AS (
            SELECT now() AT TIME ZONE :timezone AS current_time
          ),
          scoped AS (
            SELECT
               b.id AS buoy_id
              ,b.ndbc_id
              ,b.name
              ,b.slug
              ,b.lat
              ,b.lon
              ,br.timestamp
              ,(br.ground_swell_height * br.ground_swell_period * 0.1)::float8 AS swell_wave_height
              ,br.ground_swell_height::float8 AS ground_swell_height
              ,br.ground_swell_period::float8 AS ground_swell_period
              ,br.ground_swell_direction::float8 AS ground_swell_direction
              ,(br.wind_swell_height * br.wind_swell_period * 0.1)::float8 AS wind_wave_height
              ,br.wind_swell_height::float8 AS wind_swell_height
              ,br.wind_swell_period::float8 AS wind_swell_period
              ,br.wind_swell_direction::float8 AS wind_swell_direction
            FROM buoy_reports br
            JOIN buoys b ON br.buoy_id = b.id
            CROSS JOIN bounds
            WHERE b.region_id = :region_id
              AND br.timestamp >= bounds.current_time - interval '2 day'
          ),
          ordered AS (
            SELECT
               s.*
              ,SIN(RADIANS(s.ground_swell_direction)) AS ground_swell_direction_sin
              ,COS(RADIANS(s.ground_swell_direction)) AS ground_swell_direction_cos
              ,SIN(RADIANS(s.wind_swell_direction)) AS wind_swell_direction_sin
              ,COS(RADIANS(s.wind_swell_direction)) AS wind_swell_direction_cos
              ,ROW_NUMBER() OVER (PARTITION BY s.buoy_id ORDER BY s.timestamp) AS rn
            FROM scoped s
          ),
          smoothed AS (
            SELECT
               o.*
              ,o.swell_wave_height AS swell_wave_height_ma
              ,o.ground_swell_height AS ground_swell_height_ma
              ,o.ground_swell_period AS ground_swell_period_ma
              ,o.wind_wave_height AS wind_wave_height_ma
              ,o.wind_swell_height AS wind_swell_height_ma
              ,o.wind_swell_period AS wind_swell_period_ma
              ,o.ground_swell_direction_sin AS ground_swell_direction_sin_ma
              ,o.ground_swell_direction_cos AS ground_swell_direction_cos_ma
              ,o.wind_swell_direction_sin AS wind_swell_direction_sin_ma
              ,o.wind_swell_direction_cos AS wind_swell_direction_cos_ma
            FROM ordered o
            WHERE o.rn = 1

            UNION ALL

            SELECT
               o.*
              ,(:alpha * o.swell_wave_height + (1 - :alpha) * s.swell_wave_height_ma) AS swell_wave_height_ma
              ,(:alpha * o.ground_swell_height + (1 - :alpha) * s.ground_swell_height_ma) AS ground_swell_height_ma
              ,(:alpha * o.ground_swell_period + (1 - :alpha) * s.ground_swell_period_ma) AS ground_swell_period_ma
              ,(:alpha * o.wind_wave_height + (1 - :alpha) * s.wind_wave_height_ma) AS wind_wave_height_ma
              ,(:alpha * o.wind_swell_height + (1 - :alpha) * s.wind_swell_height_ma) AS wind_swell_height_ma
              ,(:alpha * o.wind_swell_period + (1 - :alpha) * s.wind_swell_period_ma) AS wind_swell_period_ma
              ,(:alpha * o.ground_swell_direction_sin + (1 - :alpha) * s.ground_swell_direction_sin_ma) AS ground_swell_direction_sin_ma
              ,(:alpha * o.ground_swell_direction_cos + (1 - :alpha) * s.ground_swell_direction_cos_ma) AS ground_swell_direction_cos_ma
              ,(:alpha * o.wind_swell_direction_sin + (1 - :alpha) * s.wind_swell_direction_sin_ma) AS wind_swell_direction_sin_ma
              ,(:alpha * o.wind_swell_direction_cos + (1 - :alpha) * s.wind_swell_direction_cos_ma) AS wind_swell_direction_cos_ma
            FROM smoothed s
            JOIN ordered o
              ON o.buoy_id = s.buoy_id
             AND o.rn = s.rn + 1
          )
          SELECT
             ndbc_id
            ,name
            ,slug
            ,lat
            ,lon
            ,timestamp
            ,swell_wave_height_ma AS swell_wave_height
            ,ground_swell_height_ma AS ground_swell_height
            ,ground_swell_period_ma AS ground_swell_period
            ,CASE
              WHEN DEGREES(ATAN2(ground_swell_direction_sin_ma, ground_swell_direction_cos_ma)) < 0 THEN
                DEGREES(ATAN2(ground_swell_direction_sin_ma, ground_swell_direction_cos_ma)) + 360
              ELSE DEGREES(ATAN2(ground_swell_direction_sin_ma, ground_swell_direction_cos_ma))
            END AS ground_swell_direction
            ,wind_wave_height_ma AS wind_wave_height
            ,wind_swell_height_ma AS wind_swell_height
            ,wind_swell_period_ma AS wind_swell_period
            ,CASE
              WHEN DEGREES(ATAN2(wind_swell_direction_sin_ma, wind_swell_direction_cos_ma)) < 0 THEN
                DEGREES(ATAN2(wind_swell_direction_sin_ma, wind_swell_direction_cos_ma)) + 360
              ELSE DEGREES(ATAN2(wind_swell_direction_sin_ma, wind_swell_direction_cos_ma))
            END AS wind_swell_direction
          FROM smoothed
          CROSS JOIN bounds
          WHERE timestamp >= bounds.current_time - interval '1 day'
          ORDER BY lat DESC, timestamp ASC
        SQL
        {
          region_id: region.id,
          timezone: region.timezone,
          alpha: EWMA_ALPHA,
        },
      ],
    )
    buoy_reports ||= Buoy.connection.select_all(sql)
    buoy_reports.each(&:symbolize_keys!)
    buoy_reports.each do |buoy_report|
      buoy_report[:xaxis_time] = buoy_report[:timestamp].strftime('%-l:%M%P')[0..-2]
      buoy_report[:tooltip_time] = buoy_report[:timestamp].strftime('%a, %-m/%-e, %-l:%M%P')
    end
    @buoy_reports = buoy_reports.group_by do |b|
      { ndbc_id: b[:ndbc_id],
        name: b[:name],
        slug: b[:slug],
        lat: b[:lat],
        lon: b[:lon] }
    end
  end

private

  def region
    @region ||= Region.find(params.expect(:region_id))
  end
end
