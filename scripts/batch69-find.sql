SELECT id, name, missing_count FROM (
  SELECT id, name,
    (CASE WHEN json_extract(user_contributed_json, '$.way') IS NULL OR json_extract(user_contributed_json, '$.way') = '' THEN 1 ELSE 0 END) +
    (CASE WHEN json_extract(user_contributed_json, '$.overviewSalary') IS NULL THEN 1 ELSE 0 END) +
    (CASE WHEN json_extract(user_contributed_json, '$.overviewProspect') IS NULL THEN 1 ELSE 0 END) +
    (CASE WHEN json_extract(user_contributed_json, '$.trivia') IS NULL THEN 1 ELSE 0 END)
    as missing_count
  FROM jobs WHERE is_active=1
)
WHERE missing_count >= 3
ORDER BY missing_count DESC, name
LIMIT 20;
