-- 각 직업별로 어떤 소스가 있는지 확인
SELECT 
  COALESCE(
    JSON_EXTRACT(normalized_payload, '$.name'),
    JSON_EXTRACT(raw_payload, '$.dJobNm'),
    JSON_EXTRACT(raw_payload, '$.jobNm')
  ) as job_name,
  GROUP_CONCAT(DISTINCT source_system ORDER BY source_system) as sources
FROM job_sources
WHERE job_name IS NOT NULL
GROUP BY job_name
HAVING sources IS NOT NULL
ORDER BY sources, job_name
LIMIT 200;


