-- Batch tagging SQL generated at 2026-01-06T08:28:10.984Z
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
  '1765284582981604',
  '농산물세척원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 30, 70, 35,
  60, 40, 40, 25, 80, 30,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'entry',
  0.87,
  '{"wlb":0.8,"growth":0.4,"stability":0.8,"income":0.5,"teamwork":0.7,"solo_deep":0.6,"analytical":0.5,"creative":0.4,"execution":0.9,"people_facing":0.5,"degree_required":0.95,"license_required":0.9}',
  '{"wlb":"식품 가공 공장 업무로 정규 근무","growth":"세척 작업으로 성장 기회 제한적","stability":"식품 가공업으로 비교적 안정적","income":"세척 작업으로 중간 수준 소득","teamwork":"공장 라인 작업으로 협업 필요","solo_deep":"세척, 운반 작업으로 독립 작업","analytical":"품질 확인으로 일부 분석","creative":"표준화된 작업으로 창의성 낮음","execution":"세척, 운반 실행 중심","people_facing":"내부 협업으로 대면 업무 적음","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 요구 없음"}'
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
  '1765284583352553',
  '도시락제조반장',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  65, 50, 75, 45,
  80, 20, 60, 50, 75, 70,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.84,
  '{"wlb":0.8,"growth":0.6,"stability":0.85,"income":0.6,"teamwork":0.9,"solo_deep":0.4,"analytical":0.7,"creative":0.7,"execution":0.8,"people_facing":0.8,"degree_required":0.95,"license_required":0.9}',
  '{"wlb":"식품 제조 공장 업무로 정규 근무","growth":"반장으로 관리 능력 향상 기회 있음","stability":"식품 제조업으로 안정적","income":"반장급으로 중상위 소득","teamwork":"작업원 감독으로 협업 多","solo_deep":"품질 점검으로 독립 작업","analytical":"작업량 파악, 품질 점검으로 분석 요구","creative":"조리법 교육으로 창의성 요구","execution":"감독, 교육 실행 중심","people_facing":"작업원 교육, 점검으로 대면 업무 多","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 요구 없음"}'
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
  '1765284583623194',
  '도시락제조원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 35, 75, 40,
  70, 30, 45, 40, 80, 40,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'entry',
  0.86,
  '{"wlb":0.8,"growth":0.5,"stability":0.85,"income":0.6,"teamwork":0.8,"solo_deep":0.5,"analytical":0.6,"creative":0.6,"execution":0.9,"people_facing":0.6,"degree_required":0.95,"license_required":0.9}',
  '{"wlb":"식품 제조 공장 업무로 정규 근무","growth":"제조 작업으로 성장 기회 제한적","stability":"식품 제조업으로 안정적","income":"제조 작업으로 중간 수준 소득","teamwork":"공장 라인 작업으로 협업 필요","solo_deep":"계량, 조리 작업으로 독립 작업","analytical":"재료 계량으로 일부 분석","creative":"요리 제조 방식으로 창의성 요구","execution":"계량, 조리, 포장 실행 중심","people_facing":"내부 협업으로 대면 업무 적음","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 요구 없음"}'
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
  '1765284583898906',
  '배추절단원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 30, 75, 35,
  65, 35, 40, 25, 85, 35,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'entry',
  0.87,
  '{"wlb":0.8,"growth":0.4,"stability":0.85,"income":0.5,"teamwork":0.8,"solo_deep":0.5,"analytical":0.5,"creative":0.4,"execution":0.95,"people_facing":0.5,"degree_required":0.95,"license_required":0.9}',
  '{"wlb":"김치 공장 업무로 정규 근무","growth":"절단 작업으로 성장 기회 제한적","stability":"식품 가공업으로 안정적","income":"절단 작업으로 중간 수준 소득","teamwork":"공장 라인 작업으로 협업 필요","solo_deep":"배추 절단으로 독립 작업","analytical":"크기별 선별로 일부 분석","creative":"표준화된 작업으로 창의성 낮음","execution":"선별, 절단 실행 중심","people_facing":"내부 협업으로 대면 업무 적음","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 요구 없음"}'
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
  '1765284584229386',
  '배추절임원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 35, 75, 35,
  65, 35, 50, 30, 80, 35,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'entry',
  0.86,
  '{"wlb":0.8,"growth":0.5,"stability":0.85,"income":0.5,"teamwork":0.8,"solo_deep":0.5,"analytical":0.6,"creative":0.5,"execution":0.9,"people_facing":0.5,"degree_required":0.95,"license_required":0.9}',
  '{"wlb":"김치 공장 업무로 정규 근무","growth":"절임 작업으로 성장 기회 제한적","stability":"식품 가공업으로 안정적","income":"절임 작업으로 중간 수준 소득","teamwork":"공장 라인 작업으로 협업 필요","solo_deep":"소금농도 조정으로 독립 작업","analytical":"염농도, 시간 조정으로 분석 요구","creative":"절임 방법 조정으로 일부 창의성","execution":"침수, 세척 실행 중심","people_facing":"내부 협업으로 대면 업무 적음","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 요구 없음"}'
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
  '1765284584609260',
  '배추탈염원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 35, 75, 35,
  65, 35, 50, 25, 85, 35,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'entry',
  0.87,
  '{"wlb":0.8,"growth":0.5,"stability":0.85,"income":0.5,"teamwork":0.8,"solo_deep":0.5,"analytical":0.6,"creative":0.4,"execution":0.95,"people_facing":0.5,"degree_required":0.95,"license_required":0.9}',
  '{"wlb":"김치 공장 업무로 정규 근무","growth":"탈염 작업으로 성장 기회 제한적","stability":"식품 가공업으로 안정적","income":"탈염 작업으로 중간 수준 소득","teamwork":"공장 라인 작업으로 협업 필요","solo_deep":"염농도 조정으로 독립 작업","analytical":"염농도 조정으로 분석 요구","creative":"표준화된 작업으로 창의성 낮음","execution":"세척, 탈수 실행 중심","people_facing":"내부 협업으로 대면 업무 적음","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 요구 없음"}'
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
  '1765284584899498',
  '생선절단원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 40, 75, 40,
  60, 40, 45, 25, 85, 35,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.86,
  '{"wlb":0.8,"growth":0.6,"stability":0.85,"income":0.6,"teamwork":0.7,"solo_deep":0.6,"analytical":0.6,"creative":0.4,"execution":0.95,"people_facing":0.5,"degree_required":0.95,"license_required":0.9}',
  '{"wlb":"수산물 가공 공장 업무로 정규 근무","growth":"절단 작업으로 숙련도 향상 기회 있음","stability":"수산물 가공업으로 안정적","income":"절단 작업으로 중간 수준 소득","teamwork":"공장 라인 작업으로 협업 필요","solo_deep":"전기톱 조작으로 독립 작업 多","analytical":"크기별 절단으로 일부 분석","creative":"표준화된 작업으로 창의성 낮음","execution":"해동, 절단 실행 중심","people_facing":"내부 협업으로 대면 업무 적음","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 요구 없음"}'
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
  '1765284585172569',
  '생선조미원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 40, 75, 40,
  60, 40, 55, 45, 80, 35,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.85,
  '{"wlb":0.8,"growth":0.6,"stability":0.85,"income":0.6,"teamwork":0.7,"solo_deep":0.6,"analytical":0.7,"creative":0.6,"execution":0.9,"people_facing":0.5,"degree_required":0.95,"license_required":0.9}',
  '{"wlb":"수산물 가공 공장 업무로 정규 근무","growth":"조미 작업으로 숙련도 향상 기회 있음","stability":"수산물 가공업으로 안정적","income":"조미 작업으로 중간 수준 소득","teamwork":"공장 라인 작업으로 협업 필요","solo_deep":"양념 배합, 침지로 독립 작업","analytical":"종류별 양념 비율로 분석 요구","creative":"맛 조절로 창의성 요구","execution":"양념 준비, 침지 실행 중심","people_facing":"내부 협업으로 대면 업무 적음","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 요구 없음"}'
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
  '1765284585467118',
  '생선해체원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 40, 75, 40,
  60, 40, 50, 30, 85, 35,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.86,
  '{"wlb":0.8,"growth":0.6,"stability":0.85,"income":0.6,"teamwork":0.7,"solo_deep":0.6,"analytical":0.6,"creative":0.5,"execution":0.95,"people_facing":0.5,"degree_required":0.95,"license_required":0.9}',
  '{"wlb":"수산물 가공 공장 업무로 정규 근무","growth":"해체 작업으로 숙련도 향상 기회 있음","stability":"수산물 가공업으로 안정적","income":"해체 작업으로 중간 수준 소득","teamwork":"공장 라인 작업으로 협업 필요","solo_deep":"생선 해체로 독립 작업 多","analytical":"부위별 해체로 일부 분석","creative":"해체 방식으로 일부 창의성","execution":"해체, 세척 실행 중심","people_facing":"내부 협업으로 대면 업무 적음","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 요구 없음"}'
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
  '1765284585695819',
  '수산물원료처리원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 40, 75, 40,
  65, 35, 50, 30, 85, 35,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'entry',
  0.86,
  '{"wlb":0.8,"growth":0.6,"stability":0.85,"income":0.6,"teamwork":0.8,"solo_deep":0.5,"analytical":0.6,"creative":0.5,"execution":0.95,"people_facing":0.5,"degree_required":0.95,"license_required":0.9}',
  '{"wlb":"수산물 가공 공장 업무로 정규 근무","growth":"원료 처리로 숙련도 향상 기회 있음","stability":"수산물 가공업으로 안정적","income":"원료 처리로 중간 수준 소득","teamwork":"공장 라인 작업으로 협업 필요","solo_deep":"선별, 절단 작업으로 독립 작업","analytical":"크기별 선별로 분석 요구","creative":"처리 방식으로 일부 창의성","execution":"선별, 절단, 세척 실행 중심","people_facing":"내부 협업으로 대면 업무 적음","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 요구 없음"}'
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