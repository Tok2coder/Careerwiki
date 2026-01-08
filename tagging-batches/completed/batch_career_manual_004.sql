-- Batch tagging SQL generated at 2026-01-06T06:06:38.228Z
-- Tagger version: tagger-v1.0.0
-- Total jobs: 10

BEGIN TRANSACTION;


INSERT INTO job_attributes (
  job_id, job_name, source_system, tagger_version, status,
  wlb, growth, stability, income,
  teamwork, solo_deep, analytical, creative, execution, people_facing,
  work_hours, shift_work, travel, remote_possible,
  degree_required, license_required, experience_required,
  _confidence, _field_confidence_json, evidence_json
) VALUES (
  '1765283350996835',
  '유리부착원',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  50, 50, 40, 40, 70, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 유리부착원은 건축물이나 차량에 유리를 설치하고 고정하는 업무를 수행합니다.\n\n유리의 크기와 모양을 측정하여 절단합니다.\n\n유리를 설치할 표면을 청소하고 준비합니다.\n\n접착제나 실런... 기반으로 50로 평가","growth":"growth는 유리부착원은 건축물이나 차량에 유리를 설치하고 고정하는 업무를 수행합니다.\n\n유리의 크기와 모양을 측정하여 절단합니다.\n\n유리를 설치할 표면을 청소하고 준비합니다.\n\n접착제나 실런... 기반으로 50로 평가","stability":"stability는 유리부착원은 건축물이나 차량에 유리를 설치하고 고정하는 업무를 수행합니다.\n\n유리의 크기와 모양을 측정하여 절단합니다.\n\n유리를 설치할 표면을 청소하고 준비합니다.\n\n접착제나 실런... 기반으로 50로 평가","income":"income는 유리부착원은 건축물이나 차량에 유리를 설치하고 고정하는 업무를 수행합니다.\n\n유리의 크기와 모양을 측정하여 절단합니다.\n\n유리를 설치할 표면을 청소하고 준비합니다.\n\n접착제나 실런... 기반으로 50로 평가","teamwork":"teamwork는 유리부착원은 건축물이나 차량에 유리를 설치하고 고정하는 업무를 수행합니다.\n\n유리의 크기와 모양을 측정하여 절단합니다.\n\n유리를 설치할 표면을 청소하고 준비합니다.\n\n접착제나 실런... 기반으로 50로 평가","solo_deep":"solo_deep는 유리부착원은 건축물이나 차량에 유리를 설치하고 고정하는 업무를 수행합니다.\n\n유리의 크기와 모양을 측정하여 절단합니다.\n\n유리를 설치할 표면을 청소하고 준비합니다.\n\n접착제나 실런... 기반으로 50로 평가","analytical":"analytical는 유리부착원은 건축물이나 차량에 유리를 설치하고 고정하는 업무를 수행합니다.\n\n유리의 크기와 모양을 측정하여 절단합니다.\n\n유리를 설치할 표면을 청소하고 준비합니다.\n\n접착제나 실런... 기반으로 40로 평가","creative":"creative는 유리부착원은 건축물이나 차량에 유리를 설치하고 고정하는 업무를 수행합니다.\n\n유리의 크기와 모양을 측정하여 절단합니다.\n\n유리를 설치할 표면을 청소하고 준비합니다.\n\n접착제나 실런... 기반으로 40로 평가","execution":"execution는 유리부착원은 건축물이나 차량에 유리를 설치하고 고정하는 업무를 수행합니다.\n\n유리의 크기와 모양을 측정하여 절단합니다.\n\n유리를 설치할 표면을 청소하고 준비합니다.\n\n접착제나 실런... 기반으로 70로 평가","people_facing":"people_facing는 유리부착원은 건축물이나 차량에 유리를 설치하고 고정하는 업무를 수행합니다.\n\n유리의 크기와 모양을 측정하여 절단합니다.\n\n유리를 설치할 표면을 청소하고 준비합니다.\n\n접착제나 실런... 기반으로 50로 평가","degree_required":"degree_required는 유리부착원은 건축물이나 차량에 유리를 설치하고 고정하는 업무를 수행합니다.\n\n유리의 크기와 모양을 측정하여 절단합니다.\n\n유리를 설치할 표면을 청소하고 준비합니다.\n\n접착제나 실런... 기반으로 none로 평가","license_required":"license_required는 유리부착원은 건축물이나 차량에 유리를 설치하고 고정하는 업무를 수행합니다.\n\n유리의 크기와 모양을 측정하여 절단합니다.\n\n유리를 설치할 표면을 청소하고 준비합니다.\n\n접착제나 실런... 기반으로 none로 평가"}'
)
ON CONFLICT(job_id) DO UPDATE SET
  job_name = excluded.job_name,
  tagger_version = excluded.tagger_version,
  status = excluded.status,
  wlb = excluded.wlb,
  growth = excluded.growth,
  stability = excluded.stability,
  income = excluded.income,
  teamwork = excluded.teamwork,
  solo_deep = excluded.solo_deep,
  analytical = excluded.analytical,
  creative = excluded.creative,
  execution = excluded.execution,
  people_facing = excluded.people_facing,
  work_hours = excluded.work_hours,
  shift_work = excluded.shift_work,
  travel = excluded.travel,
  remote_possible = excluded.remote_possible,
  degree_required = excluded.degree_required,
  license_required = excluded.license_required,
  experience_required = excluded.experience_required,
  _confidence = excluded._confidence,
  _field_confidence_json = excluded._field_confidence_json,
  evidence_json = excluded.evidence_json,
  updated_at = CURRENT_TIMESTAMP;


INSERT INTO job_attributes (
  job_id, job_name, source_system, tagger_version, status,
  wlb, growth, stability, income,
  teamwork, solo_deep, analytical, creative, execution, people_facing,
  work_hours, shift_work, travel, remote_possible,
  degree_required, license_required, experience_required,
  _confidence, _field_confidence_json, evidence_json
) VALUES (
  '1765283324464330',
  '새시원',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 50, 50,
  50, 50, 40, 40, 70, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 새시원은 창문이나 문의 틀을 제작하고 설치하는 업무를 수행합니다.\n\n새시의 설계도에 따라 재료를 준비합니다.\n\n목재나 금속 재료를 절단하고 가공합니다.\n\n새시 부품을 조립하여 틀을... 기반으로 50로 평가","growth":"growth는 새시원은 창문이나 문의 틀을 제작하고 설치하는 업무를 수행합니다.\n\n새시의 설계도에 따라 재료를 준비합니다.\n\n목재나 금속 재료를 절단하고 가공합니다.\n\n새시 부품을 조립하여 틀을... 기반으로 65로 평가","stability":"stability는 새시원은 창문이나 문의 틀을 제작하고 설치하는 업무를 수행합니다.\n\n새시의 설계도에 따라 재료를 준비합니다.\n\n목재나 금속 재료를 절단하고 가공합니다.\n\n새시 부품을 조립하여 틀을... 기반으로 50로 평가","income":"income는 새시원은 창문이나 문의 틀을 제작하고 설치하는 업무를 수행합니다.\n\n새시의 설계도에 따라 재료를 준비합니다.\n\n목재나 금속 재료를 절단하고 가공합니다.\n\n새시 부품을 조립하여 틀을... 기반으로 50로 평가","teamwork":"teamwork는 새시원은 창문이나 문의 틀을 제작하고 설치하는 업무를 수행합니다.\n\n새시의 설계도에 따라 재료를 준비합니다.\n\n목재나 금속 재료를 절단하고 가공합니다.\n\n새시 부품을 조립하여 틀을... 기반으로 50로 평가","solo_deep":"solo_deep는 새시원은 창문이나 문의 틀을 제작하고 설치하는 업무를 수행합니다.\n\n새시의 설계도에 따라 재료를 준비합니다.\n\n목재나 금속 재료를 절단하고 가공합니다.\n\n새시 부품을 조립하여 틀을... 기반으로 50로 평가","analytical":"analytical는 새시원은 창문이나 문의 틀을 제작하고 설치하는 업무를 수행합니다.\n\n새시의 설계도에 따라 재료를 준비합니다.\n\n목재나 금속 재료를 절단하고 가공합니다.\n\n새시 부품을 조립하여 틀을... 기반으로 40로 평가","creative":"creative는 새시원은 창문이나 문의 틀을 제작하고 설치하는 업무를 수행합니다.\n\n새시의 설계도에 따라 재료를 준비합니다.\n\n목재나 금속 재료를 절단하고 가공합니다.\n\n새시 부품을 조립하여 틀을... 기반으로 40로 평가","execution":"execution는 새시원은 창문이나 문의 틀을 제작하고 설치하는 업무를 수행합니다.\n\n새시의 설계도에 따라 재료를 준비합니다.\n\n목재나 금속 재료를 절단하고 가공합니다.\n\n새시 부품을 조립하여 틀을... 기반으로 70로 평가","people_facing":"people_facing는 새시원은 창문이나 문의 틀을 제작하고 설치하는 업무를 수행합니다.\n\n새시의 설계도에 따라 재료를 준비합니다.\n\n목재나 금속 재료를 절단하고 가공합니다.\n\n새시 부품을 조립하여 틀을... 기반으로 50로 평가","degree_required":"degree_required는 새시원은 창문이나 문의 틀을 제작하고 설치하는 업무를 수행합니다.\n\n새시의 설계도에 따라 재료를 준비합니다.\n\n목재나 금속 재료를 절단하고 가공합니다.\n\n새시 부품을 조립하여 틀을... 기반으로 none로 평가","license_required":"license_required는 새시원은 창문이나 문의 틀을 제작하고 설치하는 업무를 수행합니다.\n\n새시의 설계도에 따라 재료를 준비합니다.\n\n목재나 금속 재료를 절단하고 가공합니다.\n\n새시 부품을 조립하여 틀을... 기반으로 none로 평가"}'
)
ON CONFLICT(job_id) DO UPDATE SET
  job_name = excluded.job_name,
  tagger_version = excluded.tagger_version,
  status = excluded.status,
  wlb = excluded.wlb,
  growth = excluded.growth,
  stability = excluded.stability,
  income = excluded.income,
  teamwork = excluded.teamwork,
  solo_deep = excluded.solo_deep,
  analytical = excluded.analytical,
  creative = excluded.creative,
  execution = excluded.execution,
  people_facing = excluded.people_facing,
  work_hours = excluded.work_hours,
  shift_work = excluded.shift_work,
  travel = excluded.travel,
  remote_possible = excluded.remote_possible,
  degree_required = excluded.degree_required,
  license_required = excluded.license_required,
  experience_required = excluded.experience_required,
  _confidence = excluded._confidence,
  _field_confidence_json = excluded._field_confidence_json,
  evidence_json = excluded.evidence_json,
  updated_at = CURRENT_TIMESTAMP;


INSERT INTO job_attributes (
  job_id, job_name, source_system, tagger_version, status,
  wlb, growth, stability, income,
  teamwork, solo_deep, analytical, creative, execution, people_facing,
  work_hours, shift_work, travel, remote_possible,
  degree_required, license_required, experience_required,
  _confidence, _field_confidence_json, evidence_json
) VALUES (
  '1765283296979840',
  '단조원',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  50, 50, 50, 50, 50, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 단조원은 금속을 가열하여 망치나 프레스로 성형하는 업무를 수행합니다.\n\n금속 재료를 가열로에 넣어 적정 온도로 가열합니다.\n\n가열한 금속을 단조기에 넣고 망치나 프레스로 성형합니다... 기반으로 50로 평가","growth":"growth는 단조원은 금속을 가열하여 망치나 프레스로 성형하는 업무를 수행합니다.\n\n금속 재료를 가열로에 넣어 적정 온도로 가열합니다.\n\n가열한 금속을 단조기에 넣고 망치나 프레스로 성형합니다... 기반으로 50로 평가","stability":"stability는 단조원은 금속을 가열하여 망치나 프레스로 성형하는 업무를 수행합니다.\n\n금속 재료를 가열로에 넣어 적정 온도로 가열합니다.\n\n가열한 금속을 단조기에 넣고 망치나 프레스로 성형합니다... 기반으로 50로 평가","income":"income는 단조원은 금속을 가열하여 망치나 프레스로 성형하는 업무를 수행합니다.\n\n금속 재료를 가열로에 넣어 적정 온도로 가열합니다.\n\n가열한 금속을 단조기에 넣고 망치나 프레스로 성형합니다... 기반으로 50로 평가","teamwork":"teamwork는 단조원은 금속을 가열하여 망치나 프레스로 성형하는 업무를 수행합니다.\n\n금속 재료를 가열로에 넣어 적정 온도로 가열합니다.\n\n가열한 금속을 단조기에 넣고 망치나 프레스로 성형합니다... 기반으로 50로 평가","solo_deep":"solo_deep는 단조원은 금속을 가열하여 망치나 프레스로 성형하는 업무를 수행합니다.\n\n금속 재료를 가열로에 넣어 적정 온도로 가열합니다.\n\n가열한 금속을 단조기에 넣고 망치나 프레스로 성형합니다... 기반으로 50로 평가","analytical":"analytical는 단조원은 금속을 가열하여 망치나 프레스로 성형하는 업무를 수행합니다.\n\n금속 재료를 가열로에 넣어 적정 온도로 가열합니다.\n\n가열한 금속을 단조기에 넣고 망치나 프레스로 성형합니다... 기반으로 50로 평가","creative":"creative는 단조원은 금속을 가열하여 망치나 프레스로 성형하는 업무를 수행합니다.\n\n금속 재료를 가열로에 넣어 적정 온도로 가열합니다.\n\n가열한 금속을 단조기에 넣고 망치나 프레스로 성형합니다... 기반으로 50로 평가","execution":"execution는 단조원은 금속을 가열하여 망치나 프레스로 성형하는 업무를 수행합니다.\n\n금속 재료를 가열로에 넣어 적정 온도로 가열합니다.\n\n가열한 금속을 단조기에 넣고 망치나 프레스로 성형합니다... 기반으로 50로 평가","people_facing":"people_facing는 단조원은 금속을 가열하여 망치나 프레스로 성형하는 업무를 수행합니다.\n\n금속 재료를 가열로에 넣어 적정 온도로 가열합니다.\n\n가열한 금속을 단조기에 넣고 망치나 프레스로 성형합니다... 기반으로 50로 평가","degree_required":"degree_required는 단조원은 금속을 가열하여 망치나 프레스로 성형하는 업무를 수행합니다.\n\n금속 재료를 가열로에 넣어 적정 온도로 가열합니다.\n\n가열한 금속을 단조기에 넣고 망치나 프레스로 성형합니다... 기반으로 none로 평가","license_required":"license_required는 단조원은 금속을 가열하여 망치나 프레스로 성형하는 업무를 수행합니다.\n\n금속 재료를 가열로에 넣어 적정 온도로 가열합니다.\n\n가열한 금속을 단조기에 넣고 망치나 프레스로 성형합니다... 기반으로 none로 평가"}'
)
ON CONFLICT(job_id) DO UPDATE SET
  job_name = excluded.job_name,
  tagger_version = excluded.tagger_version,
  status = excluded.status,
  wlb = excluded.wlb,
  growth = excluded.growth,
  stability = excluded.stability,
  income = excluded.income,
  teamwork = excluded.teamwork,
  solo_deep = excluded.solo_deep,
  analytical = excluded.analytical,
  creative = excluded.creative,
  execution = excluded.execution,
  people_facing = excluded.people_facing,
  work_hours = excluded.work_hours,
  shift_work = excluded.shift_work,
  travel = excluded.travel,
  remote_possible = excluded.remote_possible,
  degree_required = excluded.degree_required,
  license_required = excluded.license_required,
  experience_required = excluded.experience_required,
  _confidence = excluded._confidence,
  _field_confidence_json = excluded._field_confidence_json,
  evidence_json = excluded.evidence_json,
  updated_at = CURRENT_TIMESTAMP;


INSERT INTO job_attributes (
  job_id, job_name, source_system, tagger_version, status,
  wlb, growth, stability, income,
  teamwork, solo_deep, analytical, creative, execution, people_facing,
  work_hours, shift_work, travel, remote_possible,
  degree_required, license_required, experience_required,
  _confidence, _field_confidence_json, evidence_json
) VALUES (
  '1765283354529744',
  '의복수선원',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  50, 50, 40, 40, 70, 75,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 의복수선원은 손상된 의복을 수리하고 수정하는 업무를 수행합니다.\n\n고객의 의복을 검사하여 손상 부위를 확인합니다.\n\n손상된 부분을 재봉틀로 수선합니다.\n\n의복의 길이, 너비 등을 ... 기반으로 50로 평가","growth":"growth는 의복수선원은 손상된 의복을 수리하고 수정하는 업무를 수행합니다.\n\n고객의 의복을 검사하여 손상 부위를 확인합니다.\n\n손상된 부분을 재봉틀로 수선합니다.\n\n의복의 길이, 너비 등을 ... 기반으로 50로 평가","stability":"stability는 의복수선원은 손상된 의복을 수리하고 수정하는 업무를 수행합니다.\n\n고객의 의복을 검사하여 손상 부위를 확인합니다.\n\n손상된 부분을 재봉틀로 수선합니다.\n\n의복의 길이, 너비 등을 ... 기반으로 50로 평가","income":"income는 의복수선원은 손상된 의복을 수리하고 수정하는 업무를 수행합니다.\n\n고객의 의복을 검사하여 손상 부위를 확인합니다.\n\n손상된 부분을 재봉틀로 수선합니다.\n\n의복의 길이, 너비 등을 ... 기반으로 50로 평가","teamwork":"teamwork는 의복수선원은 손상된 의복을 수리하고 수정하는 업무를 수행합니다.\n\n고객의 의복을 검사하여 손상 부위를 확인합니다.\n\n손상된 부분을 재봉틀로 수선합니다.\n\n의복의 길이, 너비 등을 ... 기반으로 50로 평가","solo_deep":"solo_deep는 의복수선원은 손상된 의복을 수리하고 수정하는 업무를 수행합니다.\n\n고객의 의복을 검사하여 손상 부위를 확인합니다.\n\n손상된 부분을 재봉틀로 수선합니다.\n\n의복의 길이, 너비 등을 ... 기반으로 50로 평가","analytical":"analytical는 의복수선원은 손상된 의복을 수리하고 수정하는 업무를 수행합니다.\n\n고객의 의복을 검사하여 손상 부위를 확인합니다.\n\n손상된 부분을 재봉틀로 수선합니다.\n\n의복의 길이, 너비 등을 ... 기반으로 40로 평가","creative":"creative는 의복수선원은 손상된 의복을 수리하고 수정하는 업무를 수행합니다.\n\n고객의 의복을 검사하여 손상 부위를 확인합니다.\n\n손상된 부분을 재봉틀로 수선합니다.\n\n의복의 길이, 너비 등을 ... 기반으로 40로 평가","execution":"execution는 의복수선원은 손상된 의복을 수리하고 수정하는 업무를 수행합니다.\n\n고객의 의복을 검사하여 손상 부위를 확인합니다.\n\n손상된 부분을 재봉틀로 수선합니다.\n\n의복의 길이, 너비 등을 ... 기반으로 70로 평가","people_facing":"people_facing는 의복수선원은 손상된 의복을 수리하고 수정하는 업무를 수행합니다.\n\n고객의 의복을 검사하여 손상 부위를 확인합니다.\n\n손상된 부분을 재봉틀로 수선합니다.\n\n의복의 길이, 너비 등을 ... 기반으로 75로 평가","degree_required":"degree_required는 의복수선원은 손상된 의복을 수리하고 수정하는 업무를 수행합니다.\n\n고객의 의복을 검사하여 손상 부위를 확인합니다.\n\n손상된 부분을 재봉틀로 수선합니다.\n\n의복의 길이, 너비 등을 ... 기반으로 none로 평가","license_required":"license_required는 의복수선원은 손상된 의복을 수리하고 수정하는 업무를 수행합니다.\n\n고객의 의복을 검사하여 손상 부위를 확인합니다.\n\n손상된 부분을 재봉틀로 수선합니다.\n\n의복의 길이, 너비 등을 ... 기반으로 none로 평가"}'
)
ON CONFLICT(job_id) DO UPDATE SET
  job_name = excluded.job_name,
  tagger_version = excluded.tagger_version,
  status = excluded.status,
  wlb = excluded.wlb,
  growth = excluded.growth,
  stability = excluded.stability,
  income = excluded.income,
  teamwork = excluded.teamwork,
  solo_deep = excluded.solo_deep,
  analytical = excluded.analytical,
  creative = excluded.creative,
  execution = excluded.execution,
  people_facing = excluded.people_facing,
  work_hours = excluded.work_hours,
  shift_work = excluded.shift_work,
  travel = excluded.travel,
  remote_possible = excluded.remote_possible,
  degree_required = excluded.degree_required,
  license_required = excluded.license_required,
  experience_required = excluded.experience_required,
  _confidence = excluded._confidence,
  _field_confidence_json = excluded._field_confidence_json,
  evidence_json = excluded.evidence_json,
  updated_at = CURRENT_TIMESTAMP;


INSERT INTO job_attributes (
  job_id, job_name, source_system, tagger_version, status,
  wlb, growth, stability, income,
  teamwork, solo_deep, analytical, creative, execution, people_facing,
  work_hours, shift_work, travel, remote_possible,
  degree_required, license_required, experience_required,
  _confidence, _field_confidence_json, evidence_json
) VALUES (
  '1765283354794836',
  '의복제품검사원',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  50, 50, 50, 50, 50, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 의복제품검사원은 완성된 의복의 품질을 검사하는 업무를 수행합니다.\n\n의복의 치수와 규격을 측정합니다.\n\n의복의 재봉 상태와 마감 상태를 확인합니다.\n\n색상과 패턴의 일치 여부를 검... 기반으로 50로 평가","growth":"growth는 의복제품검사원은 완성된 의복의 품질을 검사하는 업무를 수행합니다.\n\n의복의 치수와 규격을 측정합니다.\n\n의복의 재봉 상태와 마감 상태를 확인합니다.\n\n색상과 패턴의 일치 여부를 검... 기반으로 50로 평가","stability":"stability는 의복제품검사원은 완성된 의복의 품질을 검사하는 업무를 수행합니다.\n\n의복의 치수와 규격을 측정합니다.\n\n의복의 재봉 상태와 마감 상태를 확인합니다.\n\n색상과 패턴의 일치 여부를 검... 기반으로 50로 평가","income":"income는 의복제품검사원은 완성된 의복의 품질을 검사하는 업무를 수행합니다.\n\n의복의 치수와 규격을 측정합니다.\n\n의복의 재봉 상태와 마감 상태를 확인합니다.\n\n색상과 패턴의 일치 여부를 검... 기반으로 50로 평가","teamwork":"teamwork는 의복제품검사원은 완성된 의복의 품질을 검사하는 업무를 수행합니다.\n\n의복의 치수와 규격을 측정합니다.\n\n의복의 재봉 상태와 마감 상태를 확인합니다.\n\n색상과 패턴의 일치 여부를 검... 기반으로 50로 평가","solo_deep":"solo_deep는 의복제품검사원은 완성된 의복의 품질을 검사하는 업무를 수행합니다.\n\n의복의 치수와 규격을 측정합니다.\n\n의복의 재봉 상태와 마감 상태를 확인합니다.\n\n색상과 패턴의 일치 여부를 검... 기반으로 50로 평가","analytical":"analytical는 의복제품검사원은 완성된 의복의 품질을 검사하는 업무를 수행합니다.\n\n의복의 치수와 규격을 측정합니다.\n\n의복의 재봉 상태와 마감 상태를 확인합니다.\n\n색상과 패턴의 일치 여부를 검... 기반으로 50로 평가","creative":"creative는 의복제품검사원은 완성된 의복의 품질을 검사하는 업무를 수행합니다.\n\n의복의 치수와 규격을 측정합니다.\n\n의복의 재봉 상태와 마감 상태를 확인합니다.\n\n색상과 패턴의 일치 여부를 검... 기반으로 50로 평가","execution":"execution는 의복제품검사원은 완성된 의복의 품질을 검사하는 업무를 수행합니다.\n\n의복의 치수와 규격을 측정합니다.\n\n의복의 재봉 상태와 마감 상태를 확인합니다.\n\n색상과 패턴의 일치 여부를 검... 기반으로 50로 평가","people_facing":"people_facing는 의복제품검사원은 완성된 의복의 품질을 검사하는 업무를 수행합니다.\n\n의복의 치수와 규격을 측정합니다.\n\n의복의 재봉 상태와 마감 상태를 확인합니다.\n\n색상과 패턴의 일치 여부를 검... 기반으로 50로 평가","degree_required":"degree_required는 의복제품검사원은 완성된 의복의 품질을 검사하는 업무를 수행합니다.\n\n의복의 치수와 규격을 측정합니다.\n\n의복의 재봉 상태와 마감 상태를 확인합니다.\n\n색상과 패턴의 일치 여부를 검... 기반으로 none로 평가","license_required":"license_required는 의복제품검사원은 완성된 의복의 품질을 검사하는 업무를 수행합니다.\n\n의복의 치수와 규격을 측정합니다.\n\n의복의 재봉 상태와 마감 상태를 확인합니다.\n\n색상과 패턴의 일치 여부를 검... 기반으로 none로 평가"}'
)
ON CONFLICT(job_id) DO UPDATE SET
  job_name = excluded.job_name,
  tagger_version = excluded.tagger_version,
  status = excluded.status,
  wlb = excluded.wlb,
  growth = excluded.growth,
  stability = excluded.stability,
  income = excluded.income,
  teamwork = excluded.teamwork,
  solo_deep = excluded.solo_deep,
  analytical = excluded.analytical,
  creative = excluded.creative,
  execution = excluded.execution,
  people_facing = excluded.people_facing,
  work_hours = excluded.work_hours,
  shift_work = excluded.shift_work,
  travel = excluded.travel,
  remote_possible = excluded.remote_possible,
  degree_required = excluded.degree_required,
  license_required = excluded.license_required,
  experience_required = excluded.experience_required,
  _confidence = excluded._confidence,
  _field_confidence_json = excluded._field_confidence_json,
  evidence_json = excluded.evidence_json,
  updated_at = CURRENT_TIMESTAMP;


INSERT INTO job_attributes (
  job_id, job_name, source_system, tagger_version, status,
  wlb, growth, stability, income,
  teamwork, solo_deep, analytical, creative, execution, people_facing,
  work_hours, shift_work, travel, remote_possible,
  degree_required, license_required, experience_required,
  _confidence, _field_confidence_json, evidence_json
) VALUES (
  '1765283365102331',
  '전기 부품 및 제품 생산직',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  50, 50, 40, 40, 70, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 전기 부품 및 제품 생산직은 전기 부품을 생산하고 조립하는 업무를 수행합니다.\n\n전기 부품의 재료를 준비합니다.\n\n부품을 조립 라인에서 조립합니다.\n\n전기 배선과 연결을 수행합니다... 기반으로 50로 평가","growth":"growth는 전기 부품 및 제품 생산직은 전기 부품을 생산하고 조립하는 업무를 수행합니다.\n\n전기 부품의 재료를 준비합니다.\n\n부품을 조립 라인에서 조립합니다.\n\n전기 배선과 연결을 수행합니다... 기반으로 50로 평가","stability":"stability는 전기 부품 및 제품 생산직은 전기 부품을 생산하고 조립하는 업무를 수행합니다.\n\n전기 부품의 재료를 준비합니다.\n\n부품을 조립 라인에서 조립합니다.\n\n전기 배선과 연결을 수행합니다... 기반으로 50로 평가","income":"income는 전기 부품 및 제품 생산직은 전기 부품을 생산하고 조립하는 업무를 수행합니다.\n\n전기 부품의 재료를 준비합니다.\n\n부품을 조립 라인에서 조립합니다.\n\n전기 배선과 연결을 수행합니다... 기반으로 50로 평가","teamwork":"teamwork는 전기 부품 및 제품 생산직은 전기 부품을 생산하고 조립하는 업무를 수행합니다.\n\n전기 부품의 재료를 준비합니다.\n\n부품을 조립 라인에서 조립합니다.\n\n전기 배선과 연결을 수행합니다... 기반으로 50로 평가","solo_deep":"solo_deep는 전기 부품 및 제품 생산직은 전기 부품을 생산하고 조립하는 업무를 수행합니다.\n\n전기 부품의 재료를 준비합니다.\n\n부품을 조립 라인에서 조립합니다.\n\n전기 배선과 연결을 수행합니다... 기반으로 50로 평가","analytical":"analytical는 전기 부품 및 제품 생산직은 전기 부품을 생산하고 조립하는 업무를 수행합니다.\n\n전기 부품의 재료를 준비합니다.\n\n부품을 조립 라인에서 조립합니다.\n\n전기 배선과 연결을 수행합니다... 기반으로 40로 평가","creative":"creative는 전기 부품 및 제품 생산직은 전기 부품을 생산하고 조립하는 업무를 수행합니다.\n\n전기 부품의 재료를 준비합니다.\n\n부품을 조립 라인에서 조립합니다.\n\n전기 배선과 연결을 수행합니다... 기반으로 40로 평가","execution":"execution는 전기 부품 및 제품 생산직은 전기 부품을 생산하고 조립하는 업무를 수행합니다.\n\n전기 부품의 재료를 준비합니다.\n\n부품을 조립 라인에서 조립합니다.\n\n전기 배선과 연결을 수행합니다... 기반으로 70로 평가","people_facing":"people_facing는 전기 부품 및 제품 생산직은 전기 부품을 생산하고 조립하는 업무를 수행합니다.\n\n전기 부품의 재료를 준비합니다.\n\n부품을 조립 라인에서 조립합니다.\n\n전기 배선과 연결을 수행합니다... 기반으로 50로 평가","degree_required":"degree_required는 전기 부품 및 제품 생산직은 전기 부품을 생산하고 조립하는 업무를 수행합니다.\n\n전기 부품의 재료를 준비합니다.\n\n부품을 조립 라인에서 조립합니다.\n\n전기 배선과 연결을 수행합니다... 기반으로 none로 평가","license_required":"license_required는 전기 부품 및 제품 생산직은 전기 부품을 생산하고 조립하는 업무를 수행합니다.\n\n전기 부품의 재료를 준비합니다.\n\n부품을 조립 라인에서 조립합니다.\n\n전기 배선과 연결을 수행합니다... 기반으로 none로 평가"}'
)
ON CONFLICT(job_id) DO UPDATE SET
  job_name = excluded.job_name,
  tagger_version = excluded.tagger_version,
  status = excluded.status,
  wlb = excluded.wlb,
  growth = excluded.growth,
  stability = excluded.stability,
  income = excluded.income,
  teamwork = excluded.teamwork,
  solo_deep = excluded.solo_deep,
  analytical = excluded.analytical,
  creative = excluded.creative,
  execution = excluded.execution,
  people_facing = excluded.people_facing,
  work_hours = excluded.work_hours,
  shift_work = excluded.shift_work,
  travel = excluded.travel,
  remote_possible = excluded.remote_possible,
  degree_required = excluded.degree_required,
  license_required = excluded.license_required,
  experience_required = excluded.experience_required,
  _confidence = excluded._confidence,
  _field_confidence_json = excluded._field_confidence_json,
  evidence_json = excluded.evidence_json,
  updated_at = CURRENT_TIMESTAMP;


INSERT INTO job_attributes (
  job_id, job_name, source_system, tagger_version, status,
  wlb, growth, stability, income,
  teamwork, solo_deep, analytical, creative, execution, people_facing,
  work_hours, shift_work, travel, remote_possible,
  degree_required, license_required, experience_required,
  _confidence, _field_confidence_json, evidence_json
) VALUES (
  '1765283352648196',
  '음료제조관련조작원',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  50, 50, 50, 50, 50, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 음료제조관련조작원은 음료를 생산하는 기계를 조작하는 업무를 수행합니다.\n\n원료를 투입하고 혼합합니다.\n\n음료 제조 기계를 조작합니다.\n\n제품의 품질을 모니터링합니다.\n\n포장과 라벨... 기반으로 50로 평가","growth":"growth는 음료제조관련조작원은 음료를 생산하는 기계를 조작하는 업무를 수행합니다.\n\n원료를 투입하고 혼합합니다.\n\n음료 제조 기계를 조작합니다.\n\n제품의 품질을 모니터링합니다.\n\n포장과 라벨... 기반으로 50로 평가","stability":"stability는 음료제조관련조작원은 음료를 생산하는 기계를 조작하는 업무를 수행합니다.\n\n원료를 투입하고 혼합합니다.\n\n음료 제조 기계를 조작합니다.\n\n제품의 품질을 모니터링합니다.\n\n포장과 라벨... 기반으로 50로 평가","income":"income는 음료제조관련조작원은 음료를 생산하는 기계를 조작하는 업무를 수행합니다.\n\n원료를 투입하고 혼합합니다.\n\n음료 제조 기계를 조작합니다.\n\n제품의 품질을 모니터링합니다.\n\n포장과 라벨... 기반으로 50로 평가","teamwork":"teamwork는 음료제조관련조작원은 음료를 생산하는 기계를 조작하는 업무를 수행합니다.\n\n원료를 투입하고 혼합합니다.\n\n음료 제조 기계를 조작합니다.\n\n제품의 품질을 모니터링합니다.\n\n포장과 라벨... 기반으로 50로 평가","solo_deep":"solo_deep는 음료제조관련조작원은 음료를 생산하는 기계를 조작하는 업무를 수행합니다.\n\n원료를 투입하고 혼합합니다.\n\n음료 제조 기계를 조작합니다.\n\n제품의 품질을 모니터링합니다.\n\n포장과 라벨... 기반으로 50로 평가","analytical":"analytical는 음료제조관련조작원은 음료를 생산하는 기계를 조작하는 업무를 수행합니다.\n\n원료를 투입하고 혼합합니다.\n\n음료 제조 기계를 조작합니다.\n\n제품의 품질을 모니터링합니다.\n\n포장과 라벨... 기반으로 50로 평가","creative":"creative는 음료제조관련조작원은 음료를 생산하는 기계를 조작하는 업무를 수행합니다.\n\n원료를 투입하고 혼합합니다.\n\n음료 제조 기계를 조작합니다.\n\n제품의 품질을 모니터링합니다.\n\n포장과 라벨... 기반으로 50로 평가","execution":"execution는 음료제조관련조작원은 음료를 생산하는 기계를 조작하는 업무를 수행합니다.\n\n원료를 투입하고 혼합합니다.\n\n음료 제조 기계를 조작합니다.\n\n제품의 품질을 모니터링합니다.\n\n포장과 라벨... 기반으로 50로 평가","people_facing":"people_facing는 음료제조관련조작원은 음료를 생산하는 기계를 조작하는 업무를 수행합니다.\n\n원료를 투입하고 혼합합니다.\n\n음료 제조 기계를 조작합니다.\n\n제품의 품질을 모니터링합니다.\n\n포장과 라벨... 기반으로 50로 평가","degree_required":"degree_required는 음료제조관련조작원은 음료를 생산하는 기계를 조작하는 업무를 수행합니다.\n\n원료를 투입하고 혼합합니다.\n\n음료 제조 기계를 조작합니다.\n\n제품의 품질을 모니터링합니다.\n\n포장과 라벨... 기반으로 none로 평가","license_required":"license_required는 음료제조관련조작원은 음료를 생산하는 기계를 조작하는 업무를 수행합니다.\n\n원료를 투입하고 혼합합니다.\n\n음료 제조 기계를 조작합니다.\n\n제품의 품질을 모니터링합니다.\n\n포장과 라벨... 기반으로 none로 평가"}'
)
ON CONFLICT(job_id) DO UPDATE SET
  job_name = excluded.job_name,
  tagger_version = excluded.tagger_version,
  status = excluded.status,
  wlb = excluded.wlb,
  growth = excluded.growth,
  stability = excluded.stability,
  income = excluded.income,
  teamwork = excluded.teamwork,
  solo_deep = excluded.solo_deep,
  analytical = excluded.analytical,
  creative = excluded.creative,
  execution = excluded.execution,
  people_facing = excluded.people_facing,
  work_hours = excluded.work_hours,
  shift_work = excluded.shift_work,
  travel = excluded.travel,
  remote_possible = excluded.remote_possible,
  degree_required = excluded.degree_required,
  license_required = excluded.license_required,
  experience_required = excluded.experience_required,
  _confidence = excluded._confidence,
  _field_confidence_json = excluded._field_confidence_json,
  evidence_json = excluded.evidence_json,
  updated_at = CURRENT_TIMESTAMP;


INSERT INTO job_attributes (
  job_id, job_name, source_system, tagger_version, status,
  wlb, growth, stability, income,
  teamwork, solo_deep, analytical, creative, execution, people_facing,
  work_hours, shift_work, travel, remote_possible,
  degree_required, license_required, experience_required,
  _confidence, _field_confidence_json, evidence_json
) VALUES (
  '1765283359699295',
  '자동조립라인 및 산업용로봇조작원',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  50, 50, 60, 30, 60, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 자동조립라인 및 산업용로봇조작원은 자동화된 조립 라인을 운영하는 업무를 수행합니다.\n\n자동 조립 라인의 설정과 조작을 담당합니다.\n\n산업용 로봇의 프로그래밍과 운영을 수행합니다.\n... 기반으로 50로 평가","growth":"growth는 자동조립라인 및 산업용로봇조작원은 자동화된 조립 라인을 운영하는 업무를 수행합니다.\n\n자동 조립 라인의 설정과 조작을 담당합니다.\n\n산업용 로봇의 프로그래밍과 운영을 수행합니다.\n... 기반으로 50로 평가","stability":"stability는 자동조립라인 및 산업용로봇조작원은 자동화된 조립 라인을 운영하는 업무를 수행합니다.\n\n자동 조립 라인의 설정과 조작을 담당합니다.\n\n산업용 로봇의 프로그래밍과 운영을 수행합니다.\n... 기반으로 50로 평가","income":"income는 자동조립라인 및 산업용로봇조작원은 자동화된 조립 라인을 운영하는 업무를 수행합니다.\n\n자동 조립 라인의 설정과 조작을 담당합니다.\n\n산업용 로봇의 프로그래밍과 운영을 수행합니다.\n... 기반으로 50로 평가","teamwork":"teamwork는 자동조립라인 및 산업용로봇조작원은 자동화된 조립 라인을 운영하는 업무를 수행합니다.\n\n자동 조립 라인의 설정과 조작을 담당합니다.\n\n산업용 로봇의 프로그래밍과 운영을 수행합니다.\n... 기반으로 50로 평가","solo_deep":"solo_deep는 자동조립라인 및 산업용로봇조작원은 자동화된 조립 라인을 운영하는 업무를 수행합니다.\n\n자동 조립 라인의 설정과 조작을 담당합니다.\n\n산업용 로봇의 프로그래밍과 운영을 수행합니다.\n... 기반으로 50로 평가","analytical":"analytical는 자동조립라인 및 산업용로봇조작원은 자동화된 조립 라인을 운영하는 업무를 수행합니다.\n\n자동 조립 라인의 설정과 조작을 담당합니다.\n\n산업용 로봇의 프로그래밍과 운영을 수행합니다.\n... 기반으로 60로 평가","creative":"creative는 자동조립라인 및 산업용로봇조작원은 자동화된 조립 라인을 운영하는 업무를 수행합니다.\n\n자동 조립 라인의 설정과 조작을 담당합니다.\n\n산업용 로봇의 프로그래밍과 운영을 수행합니다.\n... 기반으로 30로 평가","execution":"execution는 자동조립라인 및 산업용로봇조작원은 자동화된 조립 라인을 운영하는 업무를 수행합니다.\n\n자동 조립 라인의 설정과 조작을 담당합니다.\n\n산업용 로봇의 프로그래밍과 운영을 수행합니다.\n... 기반으로 60로 평가","people_facing":"people_facing는 자동조립라인 및 산업용로봇조작원은 자동화된 조립 라인을 운영하는 업무를 수행합니다.\n\n자동 조립 라인의 설정과 조작을 담당합니다.\n\n산업용 로봇의 프로그래밍과 운영을 수행합니다.\n... 기반으로 50로 평가","degree_required":"degree_required는 자동조립라인 및 산업용로봇조작원은 자동화된 조립 라인을 운영하는 업무를 수행합니다.\n\n자동 조립 라인의 설정과 조작을 담당합니다.\n\n산업용 로봇의 프로그래밍과 운영을 수행합니다.\n... 기반으로 none로 평가","license_required":"license_required는 자동조립라인 및 산업용로봇조작원은 자동화된 조립 라인을 운영하는 업무를 수행합니다.\n\n자동 조립 라인의 설정과 조작을 담당합니다.\n\n산업용 로봇의 프로그래밍과 운영을 수행합니다.\n... 기반으로 none로 평가"}'
)
ON CONFLICT(job_id) DO UPDATE SET
  job_name = excluded.job_name,
  tagger_version = excluded.tagger_version,
  status = excluded.status,
  wlb = excluded.wlb,
  growth = excluded.growth,
  stability = excluded.stability,
  income = excluded.income,
  teamwork = excluded.teamwork,
  solo_deep = excluded.solo_deep,
  analytical = excluded.analytical,
  creative = excluded.creative,
  execution = excluded.execution,
  people_facing = excluded.people_facing,
  work_hours = excluded.work_hours,
  shift_work = excluded.shift_work,
  travel = excluded.travel,
  remote_possible = excluded.remote_possible,
  degree_required = excluded.degree_required,
  license_required = excluded.license_required,
  experience_required = excluded.experience_required,
  _confidence = excluded._confidence,
  _field_confidence_json = excluded._field_confidence_json,
  evidence_json = excluded.evidence_json,
  updated_at = CURRENT_TIMESTAMP;


INSERT INTO job_attributes (
  job_id, job_name, source_system, tagger_version, status,
  wlb, growth, stability, income,
  teamwork, solo_deep, analytical, creative, execution, people_facing,
  work_hours, shift_work, travel, remote_possible,
  degree_required, license_required, experience_required,
  _confidence, _field_confidence_json, evidence_json
) VALUES (
  '1765283364797881',
  '전공',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  50, 50, 40, 40, 70, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 전공은 전자기기와 통신 장비의 설치와 정비 업무를 수행합니다.\n\n전자기기의 설치와 배선을 담당합니다.\n\n통신 장비의 유지보수와 수리를 수행합니다.\n\n시스템의 정상 작동을 점검합니다... 기반으로 50로 평가","growth":"growth는 전공은 전자기기와 통신 장비의 설치와 정비 업무를 수행합니다.\n\n전자기기의 설치와 배선을 담당합니다.\n\n통신 장비의 유지보수와 수리를 수행합니다.\n\n시스템의 정상 작동을 점검합니다... 기반으로 50로 평가","stability":"stability는 전공은 전자기기와 통신 장비의 설치와 정비 업무를 수행합니다.\n\n전자기기의 설치와 배선을 담당합니다.\n\n통신 장비의 유지보수와 수리를 수행합니다.\n\n시스템의 정상 작동을 점검합니다... 기반으로 50로 평가","income":"income는 전공은 전자기기와 통신 장비의 설치와 정비 업무를 수행합니다.\n\n전자기기의 설치와 배선을 담당합니다.\n\n통신 장비의 유지보수와 수리를 수행합니다.\n\n시스템의 정상 작동을 점검합니다... 기반으로 50로 평가","teamwork":"teamwork는 전공은 전자기기와 통신 장비의 설치와 정비 업무를 수행합니다.\n\n전자기기의 설치와 배선을 담당합니다.\n\n통신 장비의 유지보수와 수리를 수행합니다.\n\n시스템의 정상 작동을 점검합니다... 기반으로 50로 평가","solo_deep":"solo_deep는 전공은 전자기기와 통신 장비의 설치와 정비 업무를 수행합니다.\n\n전자기기의 설치와 배선을 담당합니다.\n\n통신 장비의 유지보수와 수리를 수행합니다.\n\n시스템의 정상 작동을 점검합니다... 기반으로 50로 평가","analytical":"analytical는 전공은 전자기기와 통신 장비의 설치와 정비 업무를 수행합니다.\n\n전자기기의 설치와 배선을 담당합니다.\n\n통신 장비의 유지보수와 수리를 수행합니다.\n\n시스템의 정상 작동을 점검합니다... 기반으로 40로 평가","creative":"creative는 전공은 전자기기와 통신 장비의 설치와 정비 업무를 수행합니다.\n\n전자기기의 설치와 배선을 담당합니다.\n\n통신 장비의 유지보수와 수리를 수행합니다.\n\n시스템의 정상 작동을 점검합니다... 기반으로 40로 평가","execution":"execution는 전공은 전자기기와 통신 장비의 설치와 정비 업무를 수행합니다.\n\n전자기기의 설치와 배선을 담당합니다.\n\n통신 장비의 유지보수와 수리를 수행합니다.\n\n시스템의 정상 작동을 점검합니다... 기반으로 70로 평가","people_facing":"people_facing는 전공은 전자기기와 통신 장비의 설치와 정비 업무를 수행합니다.\n\n전자기기의 설치와 배선을 담당합니다.\n\n통신 장비의 유지보수와 수리를 수행합니다.\n\n시스템의 정상 작동을 점검합니다... 기반으로 50로 평가","degree_required":"degree_required는 전공은 전자기기와 통신 장비의 설치와 정비 업무를 수행합니다.\n\n전자기기의 설치와 배선을 담당합니다.\n\n통신 장비의 유지보수와 수리를 수행합니다.\n\n시스템의 정상 작동을 점검합니다... 기반으로 none로 평가","license_required":"license_required는 전공은 전자기기와 통신 장비의 설치와 정비 업무를 수행합니다.\n\n전자기기의 설치와 배선을 담당합니다.\n\n통신 장비의 유지보수와 수리를 수행합니다.\n\n시스템의 정상 작동을 점검합니다... 기반으로 none로 평가"}'
)
ON CONFLICT(job_id) DO UPDATE SET
  job_name = excluded.job_name,
  tagger_version = excluded.tagger_version,
  status = excluded.status,
  wlb = excluded.wlb,
  growth = excluded.growth,
  stability = excluded.stability,
  income = excluded.income,
  teamwork = excluded.teamwork,
  solo_deep = excluded.solo_deep,
  analytical = excluded.analytical,
  creative = excluded.creative,
  execution = excluded.execution,
  people_facing = excluded.people_facing,
  work_hours = excluded.work_hours,
  shift_work = excluded.shift_work,
  travel = excluded.travel,
  remote_possible = excluded.remote_possible,
  degree_required = excluded.degree_required,
  license_required = excluded.license_required,
  experience_required = excluded.experience_required,
  _confidence = excluded._confidence,
  _field_confidence_json = excluded._field_confidence_json,
  evidence_json = excluded.evidence_json,
  updated_at = CURRENT_TIMESTAMP;


INSERT INTO job_attributes (
  job_id, job_name, source_system, tagger_version, status,
  wlb, growth, stability, income,
  teamwork, solo_deep, analytical, creative, execution, people_facing,
  work_hours, shift_work, travel, remote_possible,
  degree_required, license_required, experience_required,
  _confidence, _field_confidence_json, evidence_json
) VALUES (
  '1765283350713746',
  '위생사',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 60, 50, 70,
  50, 50, 40, 40, 70, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 위생사는 식품의 위생과 안전을 관리하는 업무를 수행합니다.\n\n식품의 위생 상태를 검사합니다.\n\n식품 제조 공정의 위생 관리를 담당합니다.\n\n식중독 예방을 위한 지도를 실시합니다.\n... 기반으로 50로 평가","growth":"growth는 위생사는 식품의 위생과 안전을 관리하는 업무를 수행합니다.\n\n식품의 위생 상태를 검사합니다.\n\n식품 제조 공정의 위생 관리를 담당합니다.\n\n식중독 예방을 위한 지도를 실시합니다.\n... 기반으로 60로 평가","stability":"stability는 위생사는 식품의 위생과 안전을 관리하는 업무를 수행합니다.\n\n식품의 위생 상태를 검사합니다.\n\n식품 제조 공정의 위생 관리를 담당합니다.\n\n식중독 예방을 위한 지도를 실시합니다.\n... 기반으로 50로 평가","income":"income는 위생사는 식품의 위생과 안전을 관리하는 업무를 수행합니다.\n\n식품의 위생 상태를 검사합니다.\n\n식품 제조 공정의 위생 관리를 담당합니다.\n\n식중독 예방을 위한 지도를 실시합니다.\n... 기반으로 70로 평가","teamwork":"teamwork는 위생사는 식품의 위생과 안전을 관리하는 업무를 수행합니다.\n\n식품의 위생 상태를 검사합니다.\n\n식품 제조 공정의 위생 관리를 담당합니다.\n\n식중독 예방을 위한 지도를 실시합니다.\n... 기반으로 50로 평가","solo_deep":"solo_deep는 위생사는 식품의 위생과 안전을 관리하는 업무를 수행합니다.\n\n식품의 위생 상태를 검사합니다.\n\n식품 제조 공정의 위생 관리를 담당합니다.\n\n식중독 예방을 위한 지도를 실시합니다.\n... 기반으로 50로 평가","analytical":"analytical는 위생사는 식품의 위생과 안전을 관리하는 업무를 수행합니다.\n\n식품의 위생 상태를 검사합니다.\n\n식품 제조 공정의 위생 관리를 담당합니다.\n\n식중독 예방을 위한 지도를 실시합니다.\n... 기반으로 40로 평가","creative":"creative는 위생사는 식품의 위생과 안전을 관리하는 업무를 수행합니다.\n\n식품의 위생 상태를 검사합니다.\n\n식품 제조 공정의 위생 관리를 담당합니다.\n\n식중독 예방을 위한 지도를 실시합니다.\n... 기반으로 40로 평가","execution":"execution는 위생사는 식품의 위생과 안전을 관리하는 업무를 수행합니다.\n\n식품의 위생 상태를 검사합니다.\n\n식품 제조 공정의 위생 관리를 담당합니다.\n\n식중독 예방을 위한 지도를 실시합니다.\n... 기반으로 70로 평가","people_facing":"people_facing는 위생사는 식품의 위생과 안전을 관리하는 업무를 수행합니다.\n\n식품의 위생 상태를 검사합니다.\n\n식품 제조 공정의 위생 관리를 담당합니다.\n\n식중독 예방을 위한 지도를 실시합니다.\n... 기반으로 50로 평가","degree_required":"degree_required는 위생사는 식품의 위생과 안전을 관리하는 업무를 수행합니다.\n\n식품의 위생 상태를 검사합니다.\n\n식품 제조 공정의 위생 관리를 담당합니다.\n\n식중독 예방을 위한 지도를 실시합니다.\n... 기반으로 none로 평가","license_required":"license_required는 위생사는 식품의 위생과 안전을 관리하는 업무를 수행합니다.\n\n식품의 위생 상태를 검사합니다.\n\n식품 제조 공정의 위생 관리를 담당합니다.\n\n식중독 예방을 위한 지도를 실시합니다.\n... 기반으로 none로 평가"}'
)
ON CONFLICT(job_id) DO UPDATE SET
  job_name = excluded.job_name,
  tagger_version = excluded.tagger_version,
  status = excluded.status,
  wlb = excluded.wlb,
  growth = excluded.growth,
  stability = excluded.stability,
  income = excluded.income,
  teamwork = excluded.teamwork,
  solo_deep = excluded.solo_deep,
  analytical = excluded.analytical,
  creative = excluded.creative,
  execution = excluded.execution,
  people_facing = excluded.people_facing,
  work_hours = excluded.work_hours,
  shift_work = excluded.shift_work,
  travel = excluded.travel,
  remote_possible = excluded.remote_possible,
  degree_required = excluded.degree_required,
  license_required = excluded.license_required,
  experience_required = excluded.experience_required,
  _confidence = excluded._confidence,
  _field_confidence_json = excluded._field_confidence_json,
  evidence_json = excluded.evidence_json,
  updated_at = CURRENT_TIMESTAMP;

COMMIT;