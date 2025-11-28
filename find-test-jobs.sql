-- 1) 커리어넷 + 고용24직업 + 고용24사전 (3개)
SELECT '=== Case 1: CAREERNET + WORK24_JOB + WORK24_DJOB ===' as header;
SELECT DISTINCT
  COALESCE(
    JSON_EXTRACT(normalized_payload, '$.name'),
    JSON_EXTRACT(raw_payload, '$.dJobNm'),
    JSON_EXTRACT(raw_payload, '$.jobNm')
  ) as job_name
FROM job_sources
WHERE job_name IN (
  SELECT job_name FROM (
    SELECT 
      COALESCE(
        JSON_EXTRACT(normalized_payload, '$.name'),
        JSON_EXTRACT(raw_payload, '$.dJobNm'),
        JSON_EXTRACT(raw_payload, '$.jobNm')
      ) as job_name,
      GROUP_CONCAT(DISTINCT source_system ORDER BY source_system) as sources
    FROM job_sources
    GROUP BY job_name
    HAVING sources = 'CAREERNET,WORK24_DJOB,WORK24_JOB'
    LIMIT 3
  )
)
GROUP BY job_name;

-- 6) 커리어넷만 (3개)  
SELECT '=== Case 6: CAREERNET only ===' as header;
SELECT DISTINCT
  COALESCE(
    JSON_EXTRACT(normalized_payload, '$.name'),
    JSON_EXTRACT(raw_payload, '$.dJobNm'),
    JSON_EXTRACT(raw_payload, '$.jobNm')
  ) as job_name
FROM job_sources
WHERE job_name IN (
  SELECT job_name FROM (
    SELECT 
      COALESCE(
        JSON_EXTRACT(normalized_payload, '$.name'),
        JSON_EXTRACT(raw_payload, '$.dJobNm'),
        JSON_EXTRACT(raw_payload, '$.jobNm')
      ) as job_name,
      GROUP_CONCAT(DISTINCT source_system ORDER BY source_system) as sources
    FROM job_sources
    GROUP BY job_name
    HAVING sources = 'CAREERNET'
    LIMIT 3
  )
)
GROUP BY job_name;

-- 5) 고용24사전만 (3개)
SELECT '=== Case 5: WORK24_DJOB only ===' as header;
SELECT DISTINCT
  COALESCE(
    JSON_EXTRACT(normalized_payload, '$.name'),
    JSON_EXTRACT(raw_payload, '$.dJobNm'),
    JSON_EXTRACT(raw_payload, '$.jobNm')
  ) as job_name
FROM job_sources
WHERE job_name IN (
  SELECT job_name FROM (
    SELECT 
      COALESCE(
        JSON_EXTRACT(normalized_payload, '$.name'),
        JSON_EXTRACT(raw_payload, '$.dJobNm'),
        JSON_EXTRACT(raw_payload, '$.jobNm')
      ) as job_name,
      GROUP_CONCAT(DISTINCT source_system ORDER BY source_system) as sources
    FROM job_sources
    GROUP BY job_name
    HAVING sources = 'WORK24_DJOB'
    LIMIT 3
  )
)
GROUP BY job_name;

-- 7) 고용24직업만 (3개)
SELECT '=== Case 7: WORK24_JOB only ===' as header;
SELECT DISTINCT
  COALESCE(
    JSON_EXTRACT(normalized_payload, '$.name'),
    JSON_EXTRACT(raw_payload, '$.dJobNm'),
    JSON_EXTRACT(raw_payload, '$.jobNm')
  ) as job_name
FROM job_sources
WHERE job_name IN (
  SELECT job_name FROM (
    SELECT 
      COALESCE(
        JSON_EXTRACT(normalized_payload, '$.name'),
        JSON_EXTRACT(raw_payload, '$.dJobNm'),
        JSON_EXTRACT(raw_payload, '$.jobNm')
      ) as job_name,
      GROUP_CONCAT(DISTINCT source_system ORDER BY source_system) as sources
    FROM job_sources
    GROUP BY job_name
    HAVING sources = 'WORK24_JOB'
    LIMIT 3
  )
)
GROUP BY job_name;


