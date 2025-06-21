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
UNION ALL
SELECT 'surfline_v2_lotus' AS service
       ,spot_id
       ,timestamp
       ,avg(min_height) OVER w AS min_height
       ,(avg(min_height) OVER w + avg(max_height) OVER w) / 2 AS avg_height
       ,avg(max_height) OVER w AS max_height
       ,(avg(rating) OVER w) * 5 / 4 AS rating
       ,updated_at
FROM surfline_v2_lotus
WINDOW w AS (PARTITION BY spot_id ORDER BY timestamp ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING)
