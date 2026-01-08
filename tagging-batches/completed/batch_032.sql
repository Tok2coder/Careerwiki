-- Batch tagging SQL generated at 2026-01-06T08:24:13.386Z
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
  '1765284545102822',
  '육우목장작업원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  55, 30, 70, 35,
  60, 40, 40, 25, 80, 40,
  'regular', 'required', 'none', 'none',
  'none', 'none', 'entry',
  0.87,
  '{"wlb":0.7,"growth":0.4,"stability":0.8,"income":0.5,"teamwork":0.7,"solo_deep":0.6,"analytical":0.5,"creative":0.4,"execution":0.9,"people_facing":0.6,"degree_required":0.95,"license_required":0.9}',
  '{"wlb":"축사 업무로 교대 근무 필수","growth":"축사 작업으로 성장 기회 제한적","stability":"축산업으로 비교적 안정적","income":"축사 작업으로 중간 수준 소득","teamwork":"사육사 협업으로 협업 필요","solo_deep":"사료 운반, 청소로 독립 작업 多","analytical":"소 상태 관찰로 일부 분석","creative":"표준화된 작업으로 창의성 낮음","execution":"사료 공급, 청소 실행 중심","people_facing":"사육사 보고로 대면 업무 적음","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 요구 없음"}'
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
  '1765284545414273',
  '육우사육사',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  60, 45, 70, 40,
  65, 35, 65, 40, 75, 50,
  'regular', 'required', 'none', 'none',
  'none', 'none', 'none',
  0.84,
  '{"wlb":0.7,"growth":0.6,"stability":0.8,"income":0.6,"teamwork":0.8,"solo_deep":0.5,"analytical":0.8,"creative":0.6,"execution":0.8,"people_facing":0.7,"degree_required":0.95,"license_required":0.9}',
  '{"wlb":"축사 업무로 교대 근무 필수","growth":"축산 전문성 습득으로 성장 기회 있음","stability":"축산업으로 비교적 안정적","income":"축산 사육으로 중간 수준 소득","teamwork":"작업원 감독으로 협업 필요","solo_deep":"소 관찰, 기록으로 독립 작업","analytical":"건강 상태, 증체 분석으로 분석 요구","creative":"사료 급여 계획으로 일부 창의성","execution":"사료 공급, 치료 실행 중심","people_facing":"수의사 협의로 대면 업무 적음","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 요구 없음"}'
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
  '1765284545758744',
  '자급사료생산관리자',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  65, 50, 75, 45,
  75, 25, 70, 50, 70, 60,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.83,
  '{"wlb":0.8,"growth":0.7,"stability":0.85,"income":0.6,"teamwork":0.8,"solo_deep":0.4,"analytical":0.8,"creative":0.7,"execution":0.8,"people_facing":0.7,"degree_required":0.95,"license_required":0.9}',
  '{"wlb":"농장 업무로 정규 근무","growth":"사료 생산 관리로 전문성 향상 기회 좋음","stability":"축산업으로 안정적","income":"사료 생산 관리로 중상위 소득","teamwork":"작업원 감독으로 협업 多","solo_deep":"계획 수립, 연구로 독립 작업","analytical":"토양 분석, 수확 방안 연구로 분석 중심","creative":"증산 방안 개발로 창의성 요구","execution":"재배 계획 실행 중심","people_facing":"작업원 지휘로 대면 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 요구 없음"}'
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
  '1765284546064451',
  '자급사료생산작업원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  60, 35, 75, 35,
  65, 35, 45, 25, 80, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'entry',
  0.86,
  '{"wlb":0.7,"growth":0.5,"stability":0.85,"income":0.5,"teamwork":0.8,"solo_deep":0.5,"analytical":0.6,"creative":0.4,"execution":0.9,"people_facing":0.7,"degree_required":0.95,"license_required":0.9}',
  '{"wlb":"농장 업무로 정규 근무","growth":"농장 작업으로 성장 기회 제한적","stability":"축산업으로 안정적","income":"농장 작업으로 중간 수준 소득","teamwork":"관리자 지시대로 협업 필요","solo_deep":"재배, 수확 작업으로 독립 작업","analytical":"작물 상태 관찰로 일부 분석","creative":"표준화된 작업으로 창의성 낮음","execution":"파종, 수확 실행 중심","people_facing":"관리자 보고로 대면 업무 적음","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 요구 없음"}'
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
  '1765284546334149',
  '종계사육사',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  60, 45, 70, 40,
  60, 40, 65, 35, 75, 45,
  'regular', 'required', 'none', 'none',
  'none', 'none', 'none',
  0.84,
  '{"wlb":0.7,"growth":0.6,"stability":0.8,"income":0.6,"teamwork":0.7,"solo_deep":0.6,"analytical":0.8,"creative":0.5,"execution":0.8,"people_facing":0.6,"degree_required":0.95,"license_required":0.9}',
  '{"wlb":"계사 업무로 교대 근무 필수","growth":"양계 사육으로 전문성 향상 기회 있음","stability":"양계업으로 비교적 안정적","income":"양계 사육으로 중간 수준 소득","teamwork":"작업원 감독으로 협업 필요","solo_deep":"상태 점검, 기록으로 독립 작업","analytical":"육성률, 부화율 분석으로 분석 요구","creative":"품종 관리로 일부 창의성","execution":"사료 공급, 방역 실행 중심","people_facing":"내부 보고로 대면 업무 적음","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 요구 없음"}'
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
  '1765284546640683',
  '종돈사육사',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  60, 50, 70, 45,
  60, 40, 75, 40, 75, 45,
  'regular', 'required', 'none', 'none',
  'none', 'none', 'none',
  0.82,
  '{"wlb":0.7,"growth":0.7,"stability":0.8,"income":0.6,"teamwork":0.7,"solo_deep":0.6,"analytical":0.85,"creative":0.6,"execution":0.8,"people_facing":0.6,"degree_required":0.95,"license_required":0.9}',
  '{"wlb":"축사 업무로 교대 근무 필수","growth":"종돈 개량으로 전문성 향상 기회 좋음","stability":"양돈업으로 비교적 안정적","income":"종돈 사육으로 중상위 소득","teamwork":"인공 수정, 관리로 협업 적음","solo_deep":"성적 기록, 분석으로 독립 작업 多","analytical":"번식 성적 분석, 선발 결정으로 분석 중심","creative":"개량 계획으로 일부 창의성","execution":"인공 수정, 선발 실행 중심","people_facing":"내부 보고로 대면 업무 적음","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 요구 없음"}'
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
  '1765284546983123',
  '토끼사육사',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  65, 40, 70, 35,
  55, 45, 50, 30, 75, 45,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.85,
  '{"wlb":0.8,"growth":0.6,"stability":0.8,"income":0.5,"teamwork":0.6,"solo_deep":0.7,"analytical":0.6,"creative":0.5,"execution":0.8,"people_facing":0.6,"degree_required":0.95,"license_required":0.9}',
  '{"wlb":"사육장 업무로 정규 근무","growth":"토끼 사육으로 전문성 향상 기회 있음","stability":"축산업으로 비교적 안정적","income":"토끼 사육으로 중간 수준 소득","teamwork":"사육 작업으로 협업 적음","solo_deep":"먹이 공급, 치료로 독립 작업 多","analytical":"건강 상태 관찰로 분석 요구","creative":"사육 환경 조성으로 일부 창의성","execution":"먹이 공급, 치료 실행 중심","people_facing":"내부 보고로 대면 업무 적음","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 요구 없음"}'
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
  '1765284547404903',
  '가금부화작업원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  55, 35, 75, 35,
  65, 35, 50, 25, 80, 40,
  'regular', 'required', 'none', 'none',
  'none', 'none', 'none',
  0.86,
  '{"wlb":0.6,"growth":0.5,"stability":0.85,"income":0.5,"teamwork":0.8,"solo_deep":0.5,"analytical":0.6,"creative":0.4,"execution":0.9,"people_facing":0.6,"degree_required":0.95,"license_required":0.9}',
  '{"wlb":"부화장 업무로 교대 근무 필수","growth":"부화 작업으로 성장 기회 제한적","stability":"양계업으로 안정적","income":"부화 작업으로 중간 수준 소득","teamwork":"부화장 운영으로 협업 필요","solo_deep":"알 분류, 온도 조절로 독립 작업","analytical":"수정 여부 확인으로 분석 요구","creative":"표준화된 작업으로 창의성 낮음","execution":"알 배열, 온도 조절 실행 중심","people_facing":"내부 보고로 대면 업무 적음","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 요구 없음"}'
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
  '1765284547709599',
  '가금인공부화장관리원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  65, 50, 75, 45,
  75, 25, 65, 45, 70, 65,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.83,
  '{"wlb":0.8,"growth":0.7,"stability":0.85,"income":0.6,"teamwork":0.8,"solo_deep":0.4,"analytical":0.8,"creative":0.6,"execution":0.8,"people_facing":0.8,"degree_required":0.95,"license_required":0.9}',
  '{"wlb":"부화장 업무로 정규 근무","growth":"부화장 관리로 전문성 향상 기회 좋음","stability":"양계업으로 안정적","income":"부화장 관리로 중상위 소득","teamwork":"작업원 지휘로 협업 多","solo_deep":"계획 수립, 보고서 작성으로 독립 작업","analytical":"부화 계획, 시장 예측으로 분석 요구","creative":"부화 정책 개발로 창의성 요구","execution":"장비 관리, 판매 협의 실행 중심","people_facing":"작업원 지휘, 판매 협의로 대면 업무 多","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 요구 없음"}'
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
  '1765284548064636',
  '곤충양식자',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 40, 70, 35,
  55, 45, 55, 35, 75, 45,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.84,
  '{"wlb":0.8,"growth":0.6,"stability":0.8,"income":0.5,"teamwork":0.6,"solo_deep":0.7,"analytical":0.7,"creative":0.5,"execution":0.8,"people_facing":0.6,"degree_required":0.95,"license_required":0.9}',
  '{"wlb":"양식장 업무로 정규 근무","growth":"곤충 양식으로 전문성 향상 기회 있음","stability":"곤충 양식업으로 비교적 안정적","income":"곤충 양식으로 중간 수준 소득","teamwork":"양식 작업으로 협업 적음","solo_deep":"환경 조절, 먹이 공급으로 독립 작업 多","analytical":"성장 조건 파악으로 분석 요구","creative":"양식 환경 조성으로 일부 창의성","execution":"먹이 공급, 분류 실행 중심","people_facing":"내부 보고로 대면 업무 적음","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 요구 없음"}'
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