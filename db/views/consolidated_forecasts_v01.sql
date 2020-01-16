SELECT
   s.id AS spot_id
  ,s.subregion_id
  ,s.name
  ,s.slug
  ,s.lat
  ,s.lon
  ,s.msw_id
  ,s.spitcast_id
  ,s.spitcast_slug
  ,s.surfline_v1_id
  ,s.surfline_v2_id
  ,s.updated_at AS spot_updated_at
  ,fc.timestamp
  ,least(avg(min_height), avg(case when service = 'spitcast' then avg_height end)) AS min
  ,avg(avg_height) - least(avg(min_height), avg(case when service = 'spitcast' then avg_height end)) AS avg_delta
  ,greatest(avg(max_height), avg(case when service = 'spitcast' then avg_height end)) - avg(avg_height) AS max_delta
  ,ceil(greatest(avg(max_height), avg(case when service = 'spitcast' then avg_height end))) AS max
  ,round(avg(rating)) AS avg_rating
FROM all_forecasts fc
JOIN spots s ON fc.spot_id = s.id
JOIN subregions sr ON s.subregion_id = sr.id
WHERE extract(hour from fc.timestamp)::integer % 3 = 0
  AND fc.timestamp >= now() at time zone sr.timezone
  AND fc.updated_at >= now() at time zone sr.timezone - interval '1 day'
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
ORDER BY s.subregion_id
        ,s.sort_order
        ,s.id
        ,fc.timestamp
