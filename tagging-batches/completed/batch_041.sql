-- Batch tagging SQL generated at 2026-01-06T10:09:44.447Z
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
  '1765284941152193',
  '직물방축가공원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 50, 75, 60,
  65, 40, 65, 50, 70, 55,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.74,
  '{"wlb":0.8,"growth":0.7,"stability":0.85,"income":0.75,"teamwork":0.8,"solo_deep":0.6,"analytical":0.8,"creative":0.7,"execution":0.8,"people_facing":0.75,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적고 교대 근무 없음","growth":"섬유 가공 산업 기술 발전 기회 보통","stability":"제조업으로 고용 안정성 좋음","income":"전문 방축으로 중위 소득","teamwork":"방축 작업 협업 요구","solo_deep":"온도/속도 조절, 상태 관찰 작업으로 독립 작업 多","analytical":"폭 측정, 품질 확인으로 분석 중요","creative":"방축 조건 최적화로 창의성 보통","execution":"기계 조작, 방축 실행 중심","people_facing":"작업 점검 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765284941447467',
  '직물수지가공반장',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  65, 60, 80, 70,
  85, 55, 75, 50, 80, 90,
  'regular', 'possible', 'none', 'none',
  'none', 'none', 'none',
  0.78,
  '{"wlb":0.8,"growth":0.8,"stability":0.9,"income":0.85,"teamwork":0.95,"solo_deep":0.75,"analytical":0.9,"creative":0.7,"execution":0.9,"people_facing":0.98,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적지만 교대 근무 가능","growth":"섬유 가공 산업 기술 발전 기회 좋음","stability":"제조업으로 고용 안정성 매우 좋음","income":"반장급으로 상위 소득","teamwork":"작업원 감독/관리로 협업 매우 중요","solo_deep":"작업 계획 수립, 품질 관리 작업으로 독립 작업 多","analytical":"작업 상황 분석, 품질 점검으로 분석 중요","creative":"가공 방법 최적화로 창의성 보통","execution":"작업 배치, 감독 실행 중심","people_facing":"작업원 지도/교육/면담으로 대인관계 매우 多","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765284941774907',
  '직물열처리원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 50, 75, 60,
  65, 45, 70, 50, 70, 55,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.74,
  '{"wlb":0.8,"growth":0.7,"stability":0.85,"income":0.75,"teamwork":0.8,"solo_deep":0.6,"analytical":0.85,"creative":0.7,"execution":0.8,"people_facing":0.75,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적고 교대 근무 없음","growth":"섬유 가공 산업 기술 발전 기회 보통","stability":"제조업으로 고용 안정성 좋음","income":"전문 열처리로 중위 소득","teamwork":"열처리 작업 협업 요구","solo_deep":"게이지 조절, 상태 점검 작업으로 독립 작업 多","analytical":"폭/길이 측정, 품질 확인으로 분석 중요","creative":"열처리 조건 최적화로 창의성 보통","execution":"기계 조작, 열처리 실행 중심","people_facing":"작업 점검 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765284942101133',
  '직편물건조원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 50, 75, 60,
  65, 40, 65, 50, 70, 55,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.74,
  '{"wlb":0.8,"growth":0.7,"stability":0.85,"income":0.75,"teamwork":0.8,"solo_deep":0.6,"analytical":0.8,"creative":0.7,"execution":0.8,"people_facing":0.75,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적고 교대 근무 없음","growth":"섬유 가공 산업 기술 발전 기회 보통","stability":"제조업으로 고용 안정성 좋음","income":"전문 건조로 중위 소득","teamwork":"건조 작업 협업 요구","solo_deep":"온도 조절, 상태 관찰 작업으로 독립 작업 多","analytical":"색상 관찰, 품질 확인으로 분석 중요","creative":"건조 조건 최적화로 창의성 보통","execution":"기계 조작, 건조 실행 중심","people_facing":"작업 점검 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765284942424851',
  '청바지탈색가공원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  65, 55, 75, 65,
  70, 50, 75, 60, 75, 60,
  'regular', 'possible', 'none', 'none',
  'none', 'none', 'none',
  0.76,
  '{"wlb":0.8,"growth":0.75,"stability":0.85,"income":0.8,"teamwork":0.8,"solo_deep":0.7,"analytical":0.9,"creative":0.8,"execution":0.85,"people_facing":0.8,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적지만 교대 근무 가능","growth":"섬유 가공 산업 기술 발전 기회 좋음","stability":"제조업으로 고용 안정성 좋음","income":"전문 탈색으로 중위 소득","teamwork":"탈색 작업 협업 요구","solo_deep":"색상 비교, 조정 작업으로 독립 작업 多","analytical":"색상 비교, 품질 확인으로 분석 매우 중요","creative":"탈색 패턴/색상 최적화로 창의성 높음","execution":"기계 조작, 탈색 실행 중심","people_facing":"작업 감독 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765284942694440',
  '축융가공원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 50, 75, 60,
  65, 40, 65, 55, 70, 55,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.74,
  '{"wlb":0.8,"growth":0.7,"stability":0.85,"income":0.75,"teamwork":0.8,"solo_deep":0.6,"analytical":0.8,"creative":0.75,"execution":0.8,"people_facing":0.75,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적고 교대 근무 없음","growth":"섬유 가공 산업 기술 발전 기회 보통","stability":"제조업으로 고용 안정성 좋음","income":"전문 축융으로 중위 소득","teamwork":"축융 작업 협업 요구","solo_deep":"압력 조절, 상태 관찰 작업으로 독립 작업 多","analytical":"조직형태 확인으로 분석 중요","creative":"축융 조건 최적화로 창의성 높음","execution":"기계 조작, 축융 실행 중심","people_facing":"작업 점검 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765284942974539',
  '코팅가공기운전원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 50, 75, 60,
  65, 40, 65, 55, 70, 55,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.74,
  '{"wlb":0.8,"growth":0.7,"stability":0.85,"income":0.75,"teamwork":0.8,"solo_deep":0.6,"analytical":0.8,"creative":0.75,"execution":0.8,"people_facing":0.75,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적고 교대 근무 없음","growth":"섬유 가공 산업 기술 발전 기회 보통","stability":"제조업으로 고용 안정성 좋음","income":"전문 코팅으로 중위 소득","teamwork":"코팅 작업 협업 요구","solo_deep":"두께 조절, 결함 관찰 작업으로 독립 작업 多","analytical":"결함 확인으로 분석 중요","creative":"코팅 조건 최적화로 창의성 높음","execution":"기계 조작, 코팅 실행 중심","people_facing":"작업 점검 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765284943309271',
  '표백기조작원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 50, 75, 60,
  65, 45, 70, 50, 70, 55,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.74,
  '{"wlb":0.8,"growth":0.7,"stability":0.85,"income":0.75,"teamwork":0.8,"solo_deep":0.6,"analytical":0.85,"creative":0.7,"execution":0.8,"people_facing":0.75,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적고 교대 근무 없음","growth":"섬유 가공 산업 기술 발전 기회 보통","stability":"제조업으로 고용 안정성 좋음","income":"전문 표백으로 중위 소득","teamwork":"표백 작업 협업 요구","solo_deep":"온도/시간 조절, 상태 관찰 작업으로 독립 작업 多","analytical":"표백 상태 확인으로 분석 중요","creative":"표백 조건 최적화로 창의성 보통","execution":"기계 조작, 표백 실행 중심","people_facing":"작업 점검 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765284943582778',
  '표백탈수기조작원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 50, 75, 60,
  65, 40, 65, 50, 70, 55,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.74,
  '{"wlb":0.8,"growth":0.7,"stability":0.85,"income":0.75,"teamwork":0.8,"solo_deep":0.6,"analytical":0.8,"creative":0.7,"execution":0.8,"people_facing":0.75,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적고 교대 근무 없음","growth":"섬유 가공 산업 기술 발전 기회 보통","stability":"제조업으로 고용 안정성 좋음","income":"전문 탈수로 중위 소득","teamwork":"탈수 작업 협업 요구","solo_deep":"기계 설정, 수분량 확인 작업으로 독립 작업 多","analytical":"수분량 측정으로 분석 중요","creative":"탈수 조건 최적화로 창의성 보통","execution":"기계 조작, 탈수 실행 중심","people_facing":"작업 점검 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765284943887487',
  '프린트염색기조작원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 55, 75, 65,
  70, 50, 75, 60, 75, 60,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.76,
  '{"wlb":0.8,"growth":0.75,"stability":0.85,"income":0.8,"teamwork":0.8,"solo_deep":0.7,"analytical":0.9,"creative":0.8,"execution":0.85,"people_facing":0.8,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적고 교대 근무 없음","growth":"섬유 가공 산업 기술 발전 기회 좋음","stability":"제조업으로 고용 안정성 좋음","income":"전문 프린트로 중위 소득","teamwork":"프린트 작업 협업 요구","solo_deep":"패턴 조정, 색상 관리 작업으로 독립 작업 多","analytical":"색상 확인, 품질 검사로 분석 매우 중요","creative":"디자인/색상 최적화로 창의성 높음","execution":"기계 조작, 프린트 실행 중심","people_facing":"작업 감독 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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