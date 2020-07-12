SELECT 'msw' AS service
        ,spot_id
        ,timestamp
        ,min_height
        ,max_height
        ,(min_height + max_height) / 2 AS avg_height
        ,rating
        ,updated_at
FROM msws
UNION
SELECT 'spitcast_v1' AS service
       ,spot_id
       ,timestamp
       ,NULL AS min_height
       ,avg(height) OVER w AS avg_height
       ,NULL AS max_height
       ,avg(
         CASE rating
         WHEN 'Poor' THEN 0
         WHEN 'Poor-Fair' THEN 1.25
         WHEN 'Fair' THEN 2.5
         WHEN 'Fair-Good' THEN 3.75
         WHEN 'Good' THEN 5
         ELSE 0 END
       ) OVER w AS rating
       ,updated_at
FROM spitcast_v1s
WINDOW w AS (PARTITION BY spot_id ORDER BY timestamp ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING)
UNION
SELECT 'spitcast_v2' AS service
       ,spot_id
       ,timestamp
       ,NULL AS min_height
       ,avg(height) OVER w AS avg_height
       ,NULL AS max_height
       ,avg(rating * 5 / 1.5) OVER w AS rating
       ,updated_at
FROM spitcast_v2s
WINDOW w AS (PARTITION BY spot_id ORDER BY timestamp ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING)
UNION
SELECT 'lola' AS service
       ,spot_id
       ,timestamp
       ,min_height
       ,max_height
       ,(min_height + max_height) / 2 AS avg_height
       ,(swell_rating * 5 * CASE WHEN optimal_wind THEN 1 ELSE 0.5 END) AS rating
       ,updated_at
FROM surfline_lolas
UNION
SELECT 'nearshore' AS service
       ,spot_id
       ,timestamp
       ,min_height
       ,max_height
       ,(min_height + max_height) / 2 AS avg_height
       ,(swell_rating * 5 * CASE WHEN optimal_wind THEN 1 ELSE 0.5 END) AS rating
       ,updated_at
FROM surfline_nearshores
UNION
SELECT 'surfline_v2' AS service
       ,spot_id
       ,timestamp
       ,avg(min_height) OVER w AS min_height
       ,avg(max_height) OVER w AS max_height
       ,(avg(min_height) OVER w + avg(max_height) OVER w) / 2 AS avg_height
       ,(avg(swell_rating) OVER w + avg(wind_rating) OVER w) * 1.25 AS rating
       ,updated_at
FROM surfline_v2s
WINDOW w AS (PARTITION BY spot_id ORDER BY timestamp ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING)
