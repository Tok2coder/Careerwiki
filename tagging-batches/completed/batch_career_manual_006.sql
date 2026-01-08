-- Batch tagging SQL generated at 2026-01-06T06:09:28.704Z
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
  '1765283328957492',
  '세탁원',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  50, 50, 40, 40, 70, 75,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 세탁원은 옷이나 섬유 제품을 세탁하고 관리하는 업무를 수행합니다.\n\n고객의 의류를 접수하고 상태를 확인합니다.\n\n세탁 방법을 결정하고 세제를 선택합니다.\n\n세탁기를 조작하여 세탁을... 기반으로 50로 평가","growth":"growth는 세탁원은 옷이나 섬유 제품을 세탁하고 관리하는 업무를 수행합니다.\n\n고객의 의류를 접수하고 상태를 확인합니다.\n\n세탁 방법을 결정하고 세제를 선택합니다.\n\n세탁기를 조작하여 세탁을... 기반으로 50로 평가","stability":"stability는 세탁원은 옷이나 섬유 제품을 세탁하고 관리하는 업무를 수행합니다.\n\n고객의 의류를 접수하고 상태를 확인합니다.\n\n세탁 방법을 결정하고 세제를 선택합니다.\n\n세탁기를 조작하여 세탁을... 기반으로 50로 평가","income":"income는 세탁원은 옷이나 섬유 제품을 세탁하고 관리하는 업무를 수행합니다.\n\n고객의 의류를 접수하고 상태를 확인합니다.\n\n세탁 방법을 결정하고 세제를 선택합니다.\n\n세탁기를 조작하여 세탁을... 기반으로 50로 평가","teamwork":"teamwork는 세탁원은 옷이나 섬유 제품을 세탁하고 관리하는 업무를 수행합니다.\n\n고객의 의류를 접수하고 상태를 확인합니다.\n\n세탁 방법을 결정하고 세제를 선택합니다.\n\n세탁기를 조작하여 세탁을... 기반으로 50로 평가","solo_deep":"solo_deep는 세탁원은 옷이나 섬유 제품을 세탁하고 관리하는 업무를 수행합니다.\n\n고객의 의류를 접수하고 상태를 확인합니다.\n\n세탁 방법을 결정하고 세제를 선택합니다.\n\n세탁기를 조작하여 세탁을... 기반으로 50로 평가","analytical":"analytical는 세탁원은 옷이나 섬유 제품을 세탁하고 관리하는 업무를 수행합니다.\n\n고객의 의류를 접수하고 상태를 확인합니다.\n\n세탁 방법을 결정하고 세제를 선택합니다.\n\n세탁기를 조작하여 세탁을... 기반으로 40로 평가","creative":"creative는 세탁원은 옷이나 섬유 제품을 세탁하고 관리하는 업무를 수행합니다.\n\n고객의 의류를 접수하고 상태를 확인합니다.\n\n세탁 방법을 결정하고 세제를 선택합니다.\n\n세탁기를 조작하여 세탁을... 기반으로 40로 평가","execution":"execution는 세탁원은 옷이나 섬유 제품을 세탁하고 관리하는 업무를 수행합니다.\n\n고객의 의류를 접수하고 상태를 확인합니다.\n\n세탁 방법을 결정하고 세제를 선택합니다.\n\n세탁기를 조작하여 세탁을... 기반으로 70로 평가","people_facing":"people_facing는 세탁원은 옷이나 섬유 제품을 세탁하고 관리하는 업무를 수행합니다.\n\n고객의 의류를 접수하고 상태를 확인합니다.\n\n세탁 방법을 결정하고 세제를 선택합니다.\n\n세탁기를 조작하여 세탁을... 기반으로 75로 평가","degree_required":"degree_required는 세탁원은 옷이나 섬유 제품을 세탁하고 관리하는 업무를 수행합니다.\n\n고객의 의류를 접수하고 상태를 확인합니다.\n\n세탁 방법을 결정하고 세제를 선택합니다.\n\n세탁기를 조작하여 세탁을... 기반으로 none로 평가","license_required":"license_required는 세탁원은 옷이나 섬유 제품을 세탁하고 관리하는 업무를 수행합니다.\n\n고객의 의류를 접수하고 상태를 확인합니다.\n\n세탁 방법을 결정하고 세제를 선택합니다.\n\n세탁기를 조작하여 세탁을... 기반으로 none로 평가"}'
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
  '1765283394996325',
  '푸드스타일리스트',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 50, 40,
  50, 50, 70, 40, 40, 35,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 푸드스타일리스트는 음식의 외관을 아름답게 연출하는 업무를 수행합니다.\n\n클라이언트의 요구사항을 파악합니다.\n\n음식의 색상과 구성을 계획합니다.\n\n음식을 예쁘게 배열하고 장식합니다.... 기반으로 50로 평가","growth":"growth는 푸드스타일리스트는 음식의 외관을 아름답게 연출하는 업무를 수행합니다.\n\n클라이언트의 요구사항을 파악합니다.\n\n음식의 색상과 구성을 계획합니다.\n\n음식을 예쁘게 배열하고 장식합니다.... 기반으로 65로 평가","stability":"stability는 푸드스타일리스트는 음식의 외관을 아름답게 연출하는 업무를 수행합니다.\n\n클라이언트의 요구사항을 파악합니다.\n\n음식의 색상과 구성을 계획합니다.\n\n음식을 예쁘게 배열하고 장식합니다.... 기반으로 50로 평가","income":"income는 푸드스타일리스트는 음식의 외관을 아름답게 연출하는 업무를 수행합니다.\n\n클라이언트의 요구사항을 파악합니다.\n\n음식의 색상과 구성을 계획합니다.\n\n음식을 예쁘게 배열하고 장식합니다.... 기반으로 40로 평가","teamwork":"teamwork는 푸드스타일리스트는 음식의 외관을 아름답게 연출하는 업무를 수행합니다.\n\n클라이언트의 요구사항을 파악합니다.\n\n음식의 색상과 구성을 계획합니다.\n\n음식을 예쁘게 배열하고 장식합니다.... 기반으로 50로 평가","solo_deep":"solo_deep는 푸드스타일리스트는 음식의 외관을 아름답게 연출하는 업무를 수행합니다.\n\n클라이언트의 요구사항을 파악합니다.\n\n음식의 색상과 구성을 계획합니다.\n\n음식을 예쁘게 배열하고 장식합니다.... 기반으로 50로 평가","analytical":"analytical는 푸드스타일리스트는 음식의 외관을 아름답게 연출하는 업무를 수행합니다.\n\n클라이언트의 요구사항을 파악합니다.\n\n음식의 색상과 구성을 계획합니다.\n\n음식을 예쁘게 배열하고 장식합니다.... 기반으로 70로 평가","creative":"creative는 푸드스타일리스트는 음식의 외관을 아름답게 연출하는 업무를 수행합니다.\n\n클라이언트의 요구사항을 파악합니다.\n\n음식의 색상과 구성을 계획합니다.\n\n음식을 예쁘게 배열하고 장식합니다.... 기반으로 40로 평가","execution":"execution는 푸드스타일리스트는 음식의 외관을 아름답게 연출하는 업무를 수행합니다.\n\n클라이언트의 요구사항을 파악합니다.\n\n음식의 색상과 구성을 계획합니다.\n\n음식을 예쁘게 배열하고 장식합니다.... 기반으로 40로 평가","people_facing":"people_facing는 푸드스타일리스트는 음식의 외관을 아름답게 연출하는 업무를 수행합니다.\n\n클라이언트의 요구사항을 파악합니다.\n\n음식의 색상과 구성을 계획합니다.\n\n음식을 예쁘게 배열하고 장식합니다.... 기반으로 35로 평가","degree_required":"degree_required는 푸드스타일리스트는 음식의 외관을 아름답게 연출하는 업무를 수행합니다.\n\n클라이언트의 요구사항을 파악합니다.\n\n음식의 색상과 구성을 계획합니다.\n\n음식을 예쁘게 배열하고 장식합니다.... 기반으로 none로 평가","license_required":"license_required는 푸드스타일리스트는 음식의 외관을 아름답게 연출하는 업무를 수행합니다.\n\n클라이언트의 요구사항을 파악합니다.\n\n음식의 색상과 구성을 계획합니다.\n\n음식을 예쁘게 배열하고 장식합니다.... 기반으로 none로 평가"}'
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
  '1765283331082680',
  '쇼핑호스트',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  50, 50, 50, 50, 50, 75,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 쇼핑호스트는 tv 홈쇼핑에서 상품을 소개하고 판매하는 업무를 수행합니다.\n\n상품의 특징과 장점을 설명합니다.\n\n시청자와 실시간으로 소통합니다.\n\n상품 판매를 유도합니다.\n\n방송 진... 기반으로 50로 평가","growth":"growth는 쇼핑호스트는 tv 홈쇼핑에서 상품을 소개하고 판매하는 업무를 수행합니다.\n\n상품의 특징과 장점을 설명합니다.\n\n시청자와 실시간으로 소통합니다.\n\n상품 판매를 유도합니다.\n\n방송 진... 기반으로 50로 평가","stability":"stability는 쇼핑호스트는 tv 홈쇼핑에서 상품을 소개하고 판매하는 업무를 수행합니다.\n\n상품의 특징과 장점을 설명합니다.\n\n시청자와 실시간으로 소통합니다.\n\n상품 판매를 유도합니다.\n\n방송 진... 기반으로 50로 평가","income":"income는 쇼핑호스트는 tv 홈쇼핑에서 상품을 소개하고 판매하는 업무를 수행합니다.\n\n상품의 특징과 장점을 설명합니다.\n\n시청자와 실시간으로 소통합니다.\n\n상품 판매를 유도합니다.\n\n방송 진... 기반으로 50로 평가","teamwork":"teamwork는 쇼핑호스트는 tv 홈쇼핑에서 상품을 소개하고 판매하는 업무를 수행합니다.\n\n상품의 특징과 장점을 설명합니다.\n\n시청자와 실시간으로 소통합니다.\n\n상품 판매를 유도합니다.\n\n방송 진... 기반으로 50로 평가","solo_deep":"solo_deep는 쇼핑호스트는 tv 홈쇼핑에서 상품을 소개하고 판매하는 업무를 수행합니다.\n\n상품의 특징과 장점을 설명합니다.\n\n시청자와 실시간으로 소통합니다.\n\n상품 판매를 유도합니다.\n\n방송 진... 기반으로 50로 평가","analytical":"analytical는 쇼핑호스트는 tv 홈쇼핑에서 상품을 소개하고 판매하는 업무를 수행합니다.\n\n상품의 특징과 장점을 설명합니다.\n\n시청자와 실시간으로 소통합니다.\n\n상품 판매를 유도합니다.\n\n방송 진... 기반으로 50로 평가","creative":"creative는 쇼핑호스트는 tv 홈쇼핑에서 상품을 소개하고 판매하는 업무를 수행합니다.\n\n상품의 특징과 장점을 설명합니다.\n\n시청자와 실시간으로 소통합니다.\n\n상품 판매를 유도합니다.\n\n방송 진... 기반으로 50로 평가","execution":"execution는 쇼핑호스트는 tv 홈쇼핑에서 상품을 소개하고 판매하는 업무를 수행합니다.\n\n상품의 특징과 장점을 설명합니다.\n\n시청자와 실시간으로 소통합니다.\n\n상품 판매를 유도합니다.\n\n방송 진... 기반으로 50로 평가","people_facing":"people_facing는 쇼핑호스트는 tv 홈쇼핑에서 상품을 소개하고 판매하는 업무를 수행합니다.\n\n상품의 특징과 장점을 설명합니다.\n\n시청자와 실시간으로 소통합니다.\n\n상품 판매를 유도합니다.\n\n방송 진... 기반으로 75로 평가","degree_required":"degree_required는 쇼핑호스트는 tv 홈쇼핑에서 상품을 소개하고 판매하는 업무를 수행합니다.\n\n상품의 특징과 장점을 설명합니다.\n\n시청자와 실시간으로 소통합니다.\n\n상품 판매를 유도합니다.\n\n방송 진... 기반으로 none로 평가","license_required":"license_required는 쇼핑호스트는 tv 홈쇼핑에서 상품을 소개하고 판매하는 업무를 수행합니다.\n\n상품의 특징과 장점을 설명합니다.\n\n시청자와 실시간으로 소통합니다.\n\n상품 판매를 유도합니다.\n\n방송 진... 기반으로 none로 평가"}'
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
  '1765283301032565',
  '동물조련사',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 60, 50, 50,
  50, 50, 60, 30, 60, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 동물조련사는 동물을 훈련시키고 관리하는 업무를 수행합니다.\n\n동물의 행동을 관찰하고 분석합니다.\n\n훈련 계획을 수립합니다.\n\n동물에게 명령을 가르칩니다.\n\n동물의 건강을 관리합니다... 기반으로 50로 평가","growth":"growth는 동물조련사는 동물을 훈련시키고 관리하는 업무를 수행합니다.\n\n동물의 행동을 관찰하고 분석합니다.\n\n훈련 계획을 수립합니다.\n\n동물에게 명령을 가르칩니다.\n\n동물의 건강을 관리합니다... 기반으로 60로 평가","stability":"stability는 동물조련사는 동물을 훈련시키고 관리하는 업무를 수행합니다.\n\n동물의 행동을 관찰하고 분석합니다.\n\n훈련 계획을 수립합니다.\n\n동물에게 명령을 가르칩니다.\n\n동물의 건강을 관리합니다... 기반으로 50로 평가","income":"income는 동물조련사는 동물을 훈련시키고 관리하는 업무를 수행합니다.\n\n동물의 행동을 관찰하고 분석합니다.\n\n훈련 계획을 수립합니다.\n\n동물에게 명령을 가르칩니다.\n\n동물의 건강을 관리합니다... 기반으로 50로 평가","teamwork":"teamwork는 동물조련사는 동물을 훈련시키고 관리하는 업무를 수행합니다.\n\n동물의 행동을 관찰하고 분석합니다.\n\n훈련 계획을 수립합니다.\n\n동물에게 명령을 가르칩니다.\n\n동물의 건강을 관리합니다... 기반으로 50로 평가","solo_deep":"solo_deep는 동물조련사는 동물을 훈련시키고 관리하는 업무를 수행합니다.\n\n동물의 행동을 관찰하고 분석합니다.\n\n훈련 계획을 수립합니다.\n\n동물에게 명령을 가르칩니다.\n\n동물의 건강을 관리합니다... 기반으로 50로 평가","analytical":"analytical는 동물조련사는 동물을 훈련시키고 관리하는 업무를 수행합니다.\n\n동물의 행동을 관찰하고 분석합니다.\n\n훈련 계획을 수립합니다.\n\n동물에게 명령을 가르칩니다.\n\n동물의 건강을 관리합니다... 기반으로 60로 평가","creative":"creative는 동물조련사는 동물을 훈련시키고 관리하는 업무를 수행합니다.\n\n동물의 행동을 관찰하고 분석합니다.\n\n훈련 계획을 수립합니다.\n\n동물에게 명령을 가르칩니다.\n\n동물의 건강을 관리합니다... 기반으로 30로 평가","execution":"execution는 동물조련사는 동물을 훈련시키고 관리하는 업무를 수행합니다.\n\n동물의 행동을 관찰하고 분석합니다.\n\n훈련 계획을 수립합니다.\n\n동물에게 명령을 가르칩니다.\n\n동물의 건강을 관리합니다... 기반으로 60로 평가","people_facing":"people_facing는 동물조련사는 동물을 훈련시키고 관리하는 업무를 수행합니다.\n\n동물의 행동을 관찰하고 분석합니다.\n\n훈련 계획을 수립합니다.\n\n동물에게 명령을 가르칩니다.\n\n동물의 건강을 관리합니다... 기반으로 50로 평가","degree_required":"degree_required는 동물조련사는 동물을 훈련시키고 관리하는 업무를 수행합니다.\n\n동물의 행동을 관찰하고 분석합니다.\n\n훈련 계획을 수립합니다.\n\n동물에게 명령을 가르칩니다.\n\n동물의 건강을 관리합니다... 기반으로 none로 평가","license_required":"license_required는 동물조련사는 동물을 훈련시키고 관리하는 업무를 수행합니다.\n\n동물의 행동을 관찰하고 분석합니다.\n\n훈련 계획을 수립합니다.\n\n동물에게 명령을 가르칩니다.\n\n동물의 건강을 관리합니다... 기반으로 none로 평가"}'
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
  '1765283351814766',
  '유제품제조원',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  50, 50, 40, 40, 70, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 유제품제조원은 우유를 가공하여 유제품을 생산하는 업무를 수행합니다.\n\n원유를 검사하고 품질을 확인합니다.\n\n유제품 제조 기계를 조작합니다.\n\n살균과 냉각 과정을 담당합니다.\n\n포장... 기반으로 50로 평가","growth":"growth는 유제품제조원은 우유를 가공하여 유제품을 생산하는 업무를 수행합니다.\n\n원유를 검사하고 품질을 확인합니다.\n\n유제품 제조 기계를 조작합니다.\n\n살균과 냉각 과정을 담당합니다.\n\n포장... 기반으로 50로 평가","stability":"stability는 유제품제조원은 우유를 가공하여 유제품을 생산하는 업무를 수행합니다.\n\n원유를 검사하고 품질을 확인합니다.\n\n유제품 제조 기계를 조작합니다.\n\n살균과 냉각 과정을 담당합니다.\n\n포장... 기반으로 50로 평가","income":"income는 유제품제조원은 우유를 가공하여 유제품을 생산하는 업무를 수행합니다.\n\n원유를 검사하고 품질을 확인합니다.\n\n유제품 제조 기계를 조작합니다.\n\n살균과 냉각 과정을 담당합니다.\n\n포장... 기반으로 50로 평가","teamwork":"teamwork는 유제품제조원은 우유를 가공하여 유제품을 생산하는 업무를 수행합니다.\n\n원유를 검사하고 품질을 확인합니다.\n\n유제품 제조 기계를 조작합니다.\n\n살균과 냉각 과정을 담당합니다.\n\n포장... 기반으로 50로 평가","solo_deep":"solo_deep는 유제품제조원은 우유를 가공하여 유제품을 생산하는 업무를 수행합니다.\n\n원유를 검사하고 품질을 확인합니다.\n\n유제품 제조 기계를 조작합니다.\n\n살균과 냉각 과정을 담당합니다.\n\n포장... 기반으로 50로 평가","analytical":"analytical는 유제품제조원은 우유를 가공하여 유제품을 생산하는 업무를 수행합니다.\n\n원유를 검사하고 품질을 확인합니다.\n\n유제품 제조 기계를 조작합니다.\n\n살균과 냉각 과정을 담당합니다.\n\n포장... 기반으로 40로 평가","creative":"creative는 유제품제조원은 우유를 가공하여 유제품을 생산하는 업무를 수행합니다.\n\n원유를 검사하고 품질을 확인합니다.\n\n유제품 제조 기계를 조작합니다.\n\n살균과 냉각 과정을 담당합니다.\n\n포장... 기반으로 40로 평가","execution":"execution는 유제품제조원은 우유를 가공하여 유제품을 생산하는 업무를 수행합니다.\n\n원유를 검사하고 품질을 확인합니다.\n\n유제품 제조 기계를 조작합니다.\n\n살균과 냉각 과정을 담당합니다.\n\n포장... 기반으로 70로 평가","people_facing":"people_facing는 유제품제조원은 우유를 가공하여 유제품을 생산하는 업무를 수행합니다.\n\n원유를 검사하고 품질을 확인합니다.\n\n유제품 제조 기계를 조작합니다.\n\n살균과 냉각 과정을 담당합니다.\n\n포장... 기반으로 50로 평가","degree_required":"degree_required는 유제품제조원은 우유를 가공하여 유제품을 생산하는 업무를 수행합니다.\n\n원유를 검사하고 품질을 확인합니다.\n\n유제품 제조 기계를 조작합니다.\n\n살균과 냉각 과정을 담당합니다.\n\n포장... 기반으로 none로 평가","license_required":"license_required는 유제품제조원은 우유를 가공하여 유제품을 생산하는 업무를 수행합니다.\n\n원유를 검사하고 품질을 확인합니다.\n\n유제품 제조 기계를 조작합니다.\n\n살균과 냉각 과정을 담당합니다.\n\n포장... 기반으로 none로 평가"}'
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
  '1765283337407450',
  '심리학연구원',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 85, 65, 60,
  50, 50, 70, 40, 40, 35,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 심리학연구원은 인간의 심리 현상을 연구하는 업무를 수행합니다.\n\n연구 주제를 설정하고 설계합니다.\n\n실험을 계획하고 실행합니다.\n\n데이터를 수집하고 분석합니다.\n\n연구 결과를 해석... 기반으로 50로 평가","growth":"growth는 심리학연구원은 인간의 심리 현상을 연구하는 업무를 수행합니다.\n\n연구 주제를 설정하고 설계합니다.\n\n실험을 계획하고 실행합니다.\n\n데이터를 수집하고 분석합니다.\n\n연구 결과를 해석... 기반으로 85로 평가","stability":"stability는 심리학연구원은 인간의 심리 현상을 연구하는 업무를 수행합니다.\n\n연구 주제를 설정하고 설계합니다.\n\n실험을 계획하고 실행합니다.\n\n데이터를 수집하고 분석합니다.\n\n연구 결과를 해석... 기반으로 65로 평가","income":"income는 심리학연구원은 인간의 심리 현상을 연구하는 업무를 수행합니다.\n\n연구 주제를 설정하고 설계합니다.\n\n실험을 계획하고 실행합니다.\n\n데이터를 수집하고 분석합니다.\n\n연구 결과를 해석... 기반으로 60로 평가","teamwork":"teamwork는 심리학연구원은 인간의 심리 현상을 연구하는 업무를 수행합니다.\n\n연구 주제를 설정하고 설계합니다.\n\n실험을 계획하고 실행합니다.\n\n데이터를 수집하고 분석합니다.\n\n연구 결과를 해석... 기반으로 50로 평가","solo_deep":"solo_deep는 심리학연구원은 인간의 심리 현상을 연구하는 업무를 수행합니다.\n\n연구 주제를 설정하고 설계합니다.\n\n실험을 계획하고 실행합니다.\n\n데이터를 수집하고 분석합니다.\n\n연구 결과를 해석... 기반으로 50로 평가","analytical":"analytical는 심리학연구원은 인간의 심리 현상을 연구하는 업무를 수행합니다.\n\n연구 주제를 설정하고 설계합니다.\n\n실험을 계획하고 실행합니다.\n\n데이터를 수집하고 분석합니다.\n\n연구 결과를 해석... 기반으로 70로 평가","creative":"creative는 심리학연구원은 인간의 심리 현상을 연구하는 업무를 수행합니다.\n\n연구 주제를 설정하고 설계합니다.\n\n실험을 계획하고 실행합니다.\n\n데이터를 수집하고 분석합니다.\n\n연구 결과를 해석... 기반으로 40로 평가","execution":"execution는 심리학연구원은 인간의 심리 현상을 연구하는 업무를 수행합니다.\n\n연구 주제를 설정하고 설계합니다.\n\n실험을 계획하고 실행합니다.\n\n데이터를 수집하고 분석합니다.\n\n연구 결과를 해석... 기반으로 40로 평가","people_facing":"people_facing는 심리학연구원은 인간의 심리 현상을 연구하는 업무를 수행합니다.\n\n연구 주제를 설정하고 설계합니다.\n\n실험을 계획하고 실행합니다.\n\n데이터를 수집하고 분석합니다.\n\n연구 결과를 해석... 기반으로 35로 평가","degree_required":"degree_required는 심리학연구원은 인간의 심리 현상을 연구하는 업무를 수행합니다.\n\n연구 주제를 설정하고 설계합니다.\n\n실험을 계획하고 실행합니다.\n\n데이터를 수집하고 분석합니다.\n\n연구 결과를 해석... 기반으로 none로 평가","license_required":"license_required는 심리학연구원은 인간의 심리 현상을 연구하는 업무를 수행합니다.\n\n연구 주제를 설정하고 설계합니다.\n\n실험을 계획하고 실행합니다.\n\n데이터를 수집하고 분석합니다.\n\n연구 결과를 해석... 기반으로 none로 평가"}'
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
  '1765283284144159',
  '경영컨설턴트',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 70, 50,
  50, 50, 60, 30, 60, 50,
  'regular', 'none', 'none', 'partial',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 경영컨설턴트는 기업의 경영 문제를 분석하고 해결 방안을 제시하는 업무를 수행합니다.\n\n기업의 현황을 진단합니다.\n\n문제점을 파악하고 해결 방안을 제시합니다.\n\n경영 전략을 수립합니... 기반으로 50로 평가","growth":"growth는 경영컨설턴트는 기업의 경영 문제를 분석하고 해결 방안을 제시하는 업무를 수행합니다.\n\n기업의 현황을 진단합니다.\n\n문제점을 파악하고 해결 방안을 제시합니다.\n\n경영 전략을 수립합니... 기반으로 50로 평가","stability":"stability는 경영컨설턴트는 기업의 경영 문제를 분석하고 해결 방안을 제시하는 업무를 수행합니다.\n\n기업의 현황을 진단합니다.\n\n문제점을 파악하고 해결 방안을 제시합니다.\n\n경영 전략을 수립합니... 기반으로 70로 평가","income":"income는 경영컨설턴트는 기업의 경영 문제를 분석하고 해결 방안을 제시하는 업무를 수행합니다.\n\n기업의 현황을 진단합니다.\n\n문제점을 파악하고 해결 방안을 제시합니다.\n\n경영 전략을 수립합니... 기반으로 50로 평가","teamwork":"teamwork는 경영컨설턴트는 기업의 경영 문제를 분석하고 해결 방안을 제시하는 업무를 수행합니다.\n\n기업의 현황을 진단합니다.\n\n문제점을 파악하고 해결 방안을 제시합니다.\n\n경영 전략을 수립합니... 기반으로 50로 평가","solo_deep":"solo_deep는 경영컨설턴트는 기업의 경영 문제를 분석하고 해결 방안을 제시하는 업무를 수행합니다.\n\n기업의 현황을 진단합니다.\n\n문제점을 파악하고 해결 방안을 제시합니다.\n\n경영 전략을 수립합니... 기반으로 50로 평가","analytical":"analytical는 경영컨설턴트는 기업의 경영 문제를 분석하고 해결 방안을 제시하는 업무를 수행합니다.\n\n기업의 현황을 진단합니다.\n\n문제점을 파악하고 해결 방안을 제시합니다.\n\n경영 전략을 수립합니... 기반으로 60로 평가","creative":"creative는 경영컨설턴트는 기업의 경영 문제를 분석하고 해결 방안을 제시하는 업무를 수행합니다.\n\n기업의 현황을 진단합니다.\n\n문제점을 파악하고 해결 방안을 제시합니다.\n\n경영 전략을 수립합니... 기반으로 30로 평가","execution":"execution는 경영컨설턴트는 기업의 경영 문제를 분석하고 해결 방안을 제시하는 업무를 수행합니다.\n\n기업의 현황을 진단합니다.\n\n문제점을 파악하고 해결 방안을 제시합니다.\n\n경영 전략을 수립합니... 기반으로 60로 평가","people_facing":"people_facing는 경영컨설턴트는 기업의 경영 문제를 분석하고 해결 방안을 제시하는 업무를 수행합니다.\n\n기업의 현황을 진단합니다.\n\n문제점을 파악하고 해결 방안을 제시합니다.\n\n경영 전략을 수립합니... 기반으로 50로 평가","degree_required":"degree_required는 경영컨설턴트는 기업의 경영 문제를 분석하고 해결 방안을 제시하는 업무를 수행합니다.\n\n기업의 현황을 진단합니다.\n\n문제점을 파악하고 해결 방안을 제시합니다.\n\n경영 전략을 수립합니... 기반으로 none로 평가","license_required":"license_required는 경영컨설턴트는 기업의 경영 문제를 분석하고 해결 방안을 제시하는 업무를 수행합니다.\n\n기업의 현황을 진단합니다.\n\n문제점을 파악하고 해결 방안을 제시합니다.\n\n경영 전략을 수립합니... 기반으로 none로 평가"}'
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
  '1765283335247950',
  '시장 및 여론조사전문가',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 70, 50,
  50, 50, 70, 40, 40, 50,
  'regular', 'none', 'none', 'partial',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 시장 및 여론조사전문가는 시장과 여론을 조사하고 분석하는 업무를 수행합니다.\n\n조사 설계를 수립합니다.\n\n샘플을 선정하고 데이터를 수집합니다.\n\n데이터를 분석하고 해석합니다.\n\n보... 기반으로 50로 평가","growth":"growth는 시장 및 여론조사전문가는 시장과 여론을 조사하고 분석하는 업무를 수행합니다.\n\n조사 설계를 수립합니다.\n\n샘플을 선정하고 데이터를 수집합니다.\n\n데이터를 분석하고 해석합니다.\n\n보... 기반으로 65로 평가","stability":"stability는 시장 및 여론조사전문가는 시장과 여론을 조사하고 분석하는 업무를 수행합니다.\n\n조사 설계를 수립합니다.\n\n샘플을 선정하고 데이터를 수집합니다.\n\n데이터를 분석하고 해석합니다.\n\n보... 기반으로 70로 평가","income":"income는 시장 및 여론조사전문가는 시장과 여론을 조사하고 분석하는 업무를 수행합니다.\n\n조사 설계를 수립합니다.\n\n샘플을 선정하고 데이터를 수집합니다.\n\n데이터를 분석하고 해석합니다.\n\n보... 기반으로 50로 평가","teamwork":"teamwork는 시장 및 여론조사전문가는 시장과 여론을 조사하고 분석하는 업무를 수행합니다.\n\n조사 설계를 수립합니다.\n\n샘플을 선정하고 데이터를 수집합니다.\n\n데이터를 분석하고 해석합니다.\n\n보... 기반으로 50로 평가","solo_deep":"solo_deep는 시장 및 여론조사전문가는 시장과 여론을 조사하고 분석하는 업무를 수행합니다.\n\n조사 설계를 수립합니다.\n\n샘플을 선정하고 데이터를 수집합니다.\n\n데이터를 분석하고 해석합니다.\n\n보... 기반으로 50로 평가","analytical":"analytical는 시장 및 여론조사전문가는 시장과 여론을 조사하고 분석하는 업무를 수행합니다.\n\n조사 설계를 수립합니다.\n\n샘플을 선정하고 데이터를 수집합니다.\n\n데이터를 분석하고 해석합니다.\n\n보... 기반으로 70로 평가","creative":"creative는 시장 및 여론조사전문가는 시장과 여론을 조사하고 분석하는 업무를 수행합니다.\n\n조사 설계를 수립합니다.\n\n샘플을 선정하고 데이터를 수집합니다.\n\n데이터를 분석하고 해석합니다.\n\n보... 기반으로 40로 평가","execution":"execution는 시장 및 여론조사전문가는 시장과 여론을 조사하고 분석하는 업무를 수행합니다.\n\n조사 설계를 수립합니다.\n\n샘플을 선정하고 데이터를 수집합니다.\n\n데이터를 분석하고 해석합니다.\n\n보... 기반으로 40로 평가","people_facing":"people_facing는 시장 및 여론조사전문가는 시장과 여론을 조사하고 분석하는 업무를 수행합니다.\n\n조사 설계를 수립합니다.\n\n샘플을 선정하고 데이터를 수집합니다.\n\n데이터를 분석하고 해석합니다.\n\n보... 기반으로 50로 평가","degree_required":"degree_required는 시장 및 여론조사전문가는 시장과 여론을 조사하고 분석하는 업무를 수행합니다.\n\n조사 설계를 수립합니다.\n\n샘플을 선정하고 데이터를 수집합니다.\n\n데이터를 분석하고 해석합니다.\n\n보... 기반으로 none로 평가","license_required":"license_required는 시장 및 여론조사전문가는 시장과 여론을 조사하고 분석하는 업무를 수행합니다.\n\n조사 설계를 수립합니다.\n\n샘플을 선정하고 데이터를 수집합니다.\n\n데이터를 분석하고 해석합니다.\n\n보... 기반으로 none로 평가"}'
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
  '1765283385623157',
  '커플매니저',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 50, 50,
  50, 50, 30, 60, 60, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 커플매니저는 커플의 결혼 준비를 돕고 결혼식을 기획하는 업무를 수행합니다.\n\n커플의 예산과 선호도를 파악합니다.\n\n결혼식 장소와 날짜를 예약합니다.\n\n하객 관리와 초대장을 준비합니... 기반으로 50로 평가","growth":"growth는 커플매니저는 커플의 결혼 준비를 돕고 결혼식을 기획하는 업무를 수행합니다.\n\n커플의 예산과 선호도를 파악합니다.\n\n결혼식 장소와 날짜를 예약합니다.\n\n하객 관리와 초대장을 준비합니... 기반으로 65로 평가","stability":"stability는 커플매니저는 커플의 결혼 준비를 돕고 결혼식을 기획하는 업무를 수행합니다.\n\n커플의 예산과 선호도를 파악합니다.\n\n결혼식 장소와 날짜를 예약합니다.\n\n하객 관리와 초대장을 준비합니... 기반으로 50로 평가","income":"income는 커플매니저는 커플의 결혼 준비를 돕고 결혼식을 기획하는 업무를 수행합니다.\n\n커플의 예산과 선호도를 파악합니다.\n\n결혼식 장소와 날짜를 예약합니다.\n\n하객 관리와 초대장을 준비합니... 기반으로 50로 평가","teamwork":"teamwork는 커플매니저는 커플의 결혼 준비를 돕고 결혼식을 기획하는 업무를 수행합니다.\n\n커플의 예산과 선호도를 파악합니다.\n\n결혼식 장소와 날짜를 예약합니다.\n\n하객 관리와 초대장을 준비합니... 기반으로 50로 평가","solo_deep":"solo_deep는 커플매니저는 커플의 결혼 준비를 돕고 결혼식을 기획하는 업무를 수행합니다.\n\n커플의 예산과 선호도를 파악합니다.\n\n결혼식 장소와 날짜를 예약합니다.\n\n하객 관리와 초대장을 준비합니... 기반으로 50로 평가","analytical":"analytical는 커플매니저는 커플의 결혼 준비를 돕고 결혼식을 기획하는 업무를 수행합니다.\n\n커플의 예산과 선호도를 파악합니다.\n\n결혼식 장소와 날짜를 예약합니다.\n\n하객 관리와 초대장을 준비합니... 기반으로 30로 평가","creative":"creative는 커플매니저는 커플의 결혼 준비를 돕고 결혼식을 기획하는 업무를 수행합니다.\n\n커플의 예산과 선호도를 파악합니다.\n\n결혼식 장소와 날짜를 예약합니다.\n\n하객 관리와 초대장을 준비합니... 기반으로 60로 평가","execution":"execution는 커플매니저는 커플의 결혼 준비를 돕고 결혼식을 기획하는 업무를 수행합니다.\n\n커플의 예산과 선호도를 파악합니다.\n\n결혼식 장소와 날짜를 예약합니다.\n\n하객 관리와 초대장을 준비합니... 기반으로 60로 평가","people_facing":"people_facing는 커플매니저는 커플의 결혼 준비를 돕고 결혼식을 기획하는 업무를 수행합니다.\n\n커플의 예산과 선호도를 파악합니다.\n\n결혼식 장소와 날짜를 예약합니다.\n\n하객 관리와 초대장을 준비합니... 기반으로 50로 평가","degree_required":"degree_required는 커플매니저는 커플의 결혼 준비를 돕고 결혼식을 기획하는 업무를 수행합니다.\n\n커플의 예산과 선호도를 파악합니다.\n\n결혼식 장소와 날짜를 예약합니다.\n\n하객 관리와 초대장을 준비합니... 기반으로 none로 평가","license_required":"license_required는 커플매니저는 커플의 결혼 준비를 돕고 결혼식을 기획하는 업무를 수행합니다.\n\n커플의 예산과 선호도를 파악합니다.\n\n결혼식 장소와 날짜를 예약합니다.\n\n하객 관리와 초대장을 준비합니... 기반으로 none로 평가"}'
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
  '1765283392589306',
  '파티플래너',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 50, 50,
  50, 50, 60, 60, 30, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 파티플래너는 각종 행사와 파티를 기획하고 실행하는 업무를 수행합니다.\n\n클라이언트의 요구사항을 파악합니다.\n\n행사 콘셉트와 예산을 계획합니다.\n\n장소와 날짜를 예약합니다.\n\n행사 ... 기반으로 50로 평가","growth":"growth는 파티플래너는 각종 행사와 파티를 기획하고 실행하는 업무를 수행합니다.\n\n클라이언트의 요구사항을 파악합니다.\n\n행사 콘셉트와 예산을 계획합니다.\n\n장소와 날짜를 예약합니다.\n\n행사 ... 기반으로 65로 평가","stability":"stability는 파티플래너는 각종 행사와 파티를 기획하고 실행하는 업무를 수행합니다.\n\n클라이언트의 요구사항을 파악합니다.\n\n행사 콘셉트와 예산을 계획합니다.\n\n장소와 날짜를 예약합니다.\n\n행사 ... 기반으로 50로 평가","income":"income는 파티플래너는 각종 행사와 파티를 기획하고 실행하는 업무를 수행합니다.\n\n클라이언트의 요구사항을 파악합니다.\n\n행사 콘셉트와 예산을 계획합니다.\n\n장소와 날짜를 예약합니다.\n\n행사 ... 기반으로 50로 평가","teamwork":"teamwork는 파티플래너는 각종 행사와 파티를 기획하고 실행하는 업무를 수행합니다.\n\n클라이언트의 요구사항을 파악합니다.\n\n행사 콘셉트와 예산을 계획합니다.\n\n장소와 날짜를 예약합니다.\n\n행사 ... 기반으로 50로 평가","solo_deep":"solo_deep는 파티플래너는 각종 행사와 파티를 기획하고 실행하는 업무를 수행합니다.\n\n클라이언트의 요구사항을 파악합니다.\n\n행사 콘셉트와 예산을 계획합니다.\n\n장소와 날짜를 예약합니다.\n\n행사 ... 기반으로 50로 평가","analytical":"analytical는 파티플래너는 각종 행사와 파티를 기획하고 실행하는 업무를 수행합니다.\n\n클라이언트의 요구사항을 파악합니다.\n\n행사 콘셉트와 예산을 계획합니다.\n\n장소와 날짜를 예약합니다.\n\n행사 ... 기반으로 60로 평가","creative":"creative는 파티플래너는 각종 행사와 파티를 기획하고 실행하는 업무를 수행합니다.\n\n클라이언트의 요구사항을 파악합니다.\n\n행사 콘셉트와 예산을 계획합니다.\n\n장소와 날짜를 예약합니다.\n\n행사 ... 기반으로 60로 평가","execution":"execution는 파티플래너는 각종 행사와 파티를 기획하고 실행하는 업무를 수행합니다.\n\n클라이언트의 요구사항을 파악합니다.\n\n행사 콘셉트와 예산을 계획합니다.\n\n장소와 날짜를 예약합니다.\n\n행사 ... 기반으로 30로 평가","people_facing":"people_facing는 파티플래너는 각종 행사와 파티를 기획하고 실행하는 업무를 수행합니다.\n\n클라이언트의 요구사항을 파악합니다.\n\n행사 콘셉트와 예산을 계획합니다.\n\n장소와 날짜를 예약합니다.\n\n행사 ... 기반으로 50로 평가","degree_required":"degree_required는 파티플래너는 각종 행사와 파티를 기획하고 실행하는 업무를 수행합니다.\n\n클라이언트의 요구사항을 파악합니다.\n\n행사 콘셉트와 예산을 계획합니다.\n\n장소와 날짜를 예약합니다.\n\n행사 ... 기반으로 none로 평가","license_required":"license_required는 파티플래너는 각종 행사와 파티를 기획하고 실행하는 업무를 수행합니다.\n\n클라이언트의 요구사항을 파악합니다.\n\n행사 콘셉트와 예산을 계획합니다.\n\n장소와 날짜를 예약합니다.\n\n행사 ... 기반으로 none로 평가"}'
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