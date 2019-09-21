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
SELECT 'spitcast' AS service
       ,spot_id
       ,timestamp
       ,avg(height) OVER w AS min_height
       ,avg(height) OVER w AS max_height
       ,avg(height) OVER w AS avg_height
       ,avg(rating) OVER w - 0.5 AS rating
       ,updated_at
FROM spitcasts
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
       ,avg(swell_rating) OVER w + avg(wind_rating) OVER w + 0.5 AS rating
       ,updated_at
FROM surfline_v2s
WINDOW w AS (PARTITION BY spot_id ORDER BY timestamp ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING)
