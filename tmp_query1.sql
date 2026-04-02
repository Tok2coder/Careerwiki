SELECT 
  AVG(json_array_length(json_extract(user_contributed_json, '$.detailReady.curriculum'))) as avg_curriculum,
  AVG(json_array_length(json_extract(user_contributed_json, '$.detailReady.recruit'))) as avg_recruit,
  AVG(json_array_length(json_extract(user_contributed_json, '$.detailReady.training'))) as avg_training,
  SUM(CASE WHEN json_array_length(json_extract(user_contributed_json, '$.detailReady.curriculum')) = 0 THEN 1 ELSE 0 END) as empty_curriculum,
  SUM(CASE WHEN json_array_length(json_extract(user_contributed_json, '$.detailReady.recruit')) = 0 THEN 1 ELSE 0 END) as empty_recruit,
  SUM(CASE WHEN json_array_length(json_extract(user_contributed_json, '$.detailReady.training')) = 0 THEN 1 ELSE 0 END) as empty_training
FROM jobs 
WHERE user_contributed_json IS NOT NULL AND length(user_contributed_json) >= 500
