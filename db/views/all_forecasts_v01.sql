SELECT 'msw' AS service
        ,spot_id
        ,timestamp
        ,min_height
        ,max_height
        ,(min_height + max_height) / 2 AS avg_height
        ,rating
FROM msws
UNION
SELECT 'spitcast' AS service
       ,spot_id
       ,timestamp
       ,height AS min_height
       ,height AS max_height
       ,height AS avg_height
       ,rating - 0.5 AS rating
FROM spitcasts
UNION
SELECT 'lola' AS service
       ,spot_id
       ,timestamp
       ,min_height
       ,max_height
       ,(min_height + max_height) / 2 AS avg_height
       ,(swell_rating * 5 * CASE WHEN optimal_wind THEN 1 ELSE 0.5 END) AS rating
FROM surfline_lolas
UNION
SELECT 'nearshore' AS service
       ,spot_id
       ,timestamp
       ,min_height
       ,max_height
       ,(min_height + max_height) / 2 AS avg_height
       ,(swell_rating * 5 * CASE WHEN optimal_wind THEN 1 ELSE 0.5 END) AS rating
FROM surfline_nearshores
