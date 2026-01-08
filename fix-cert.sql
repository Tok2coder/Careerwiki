UPDATE jobs 
SET merged_profile_json = json_set(
  merged_profile_json, 
  '$.sidebarCerts', 
  json('[{"name":"직업상담사 1, 2급(국가기술)","url":null}]')
) 
WHERE name = '직업상담사';








