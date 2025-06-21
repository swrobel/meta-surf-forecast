SELECT
  b.id,
  kind,
  concurrency,
  duration,
  b.created_at,
  b.updated_at,
  SUM(
    CASE
      WHEN success THEN 1
      ELSE 0
    END
  ) AS success,
  SUM(retries) AS retry,
  SUM(
    CASE
      WHEN success THEN 0
      ELSE 1
    END
  ) AS fail,
  SUM(
    CASE
      WHEN service = 'BuoyReport' THEN retries
      ELSE 0
    END
  ) AS buoy_retry,
  SUM(
    CASE
      WHEN success = FALSE
      AND service = 'BuoyReport' THEN 1
      ELSE 0
    END
  ) AS buoy_fail,
  SUM(
    CASE
      WHEN service = 'SurflineV2Lotus' THEN retries
      ELSE 0
    END
  ) AS surfline_v2_retry,
  SUM(
    CASE
      WHEN success = FALSE
      AND service = 'SurflineV2Lotus' THEN 1
      ELSE 0
    END
  ) AS surfline_v2_fail,
  SUM(
    CASE
      WHEN service = 'SpitcastV2' THEN retries
      ELSE 0
    END
  ) AS spitcast_v2_retry,
  SUM(
    CASE
      WHEN success = FALSE
      AND service = 'SpitcastV2' THEN 1
      ELSE 0
    END
  ) AS spitcast_v2_fail
FROM
  api_requests r
  JOIN update_batches b ON r.batch_id = b.id
WHERE
  duration IS NOT NULL
GROUP BY
  b.id,
  kind,
  b.created_at,
  b.updated_at,
  concurrency,
  duration
ORDER BY
  created_at DESC
