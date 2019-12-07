SELECT b.id,
       concurrency,
       duration,
       SUM(CASE
             WHEN success THEN 1
             ELSE 0
           END)     AS success,
       SUM(retries) AS retry,
       SUM(CASE
             WHEN success THEN 0
             ELSE 1
           END)     AS fail,
       SUM(CASE
             WHEN service = 'Msw' THEN retries
             ELSE 0
           END)     AS msw_retry,
       SUM(CASE
             WHEN success = FALSE
                  AND service = 'Msw' THEN 1
             ELSE 0
           END)     AS msw_fail,
       SUM(CASE
             WHEN service IN ( 'SurflineLola', 'SurflineNearshore' ) THEN
             retries
             ELSE 0
           END)     AS surfline_v1_retry,
       SUM(CASE
             WHEN success = FALSE
                  AND service IN ( 'SurflineLola', 'SurflineNearshore' ) THEN 1
             ELSE 0
           END)     AS surfline_v1_fail,
       SUM(CASE
             WHEN service = 'SurflineV2' THEN retries
             ELSE 0
           END)     AS surfline_v2_retry,
       SUM(CASE
             WHEN success = FALSE
                  AND service = 'SurflineV2' THEN 1
             ELSE 0
           END)     AS surfline_v2_fail,
       SUM(CASE
             WHEN service = 'Spitcast' THEN retries
             ELSE 0
           END)     AS spitcast_retry,
       SUM(CASE
             WHEN success = FALSE
                  AND service = 'Spitcast' THEN 1
             ELSE 0
           END)     AS spitcast_fail
FROM   api_requests r
       join update_batches b
         ON r.batch_id = b.id
GROUP  BY b.id,
          concurrency,
          duration
