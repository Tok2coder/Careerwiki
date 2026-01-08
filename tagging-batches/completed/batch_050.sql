-- Batch tagging SQL generated at 2026-01-06T10:26:56.806Z
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
  '1765285289636481',
  '자동차검사반장',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 65, 80, 75,
  85, 55, 80, 50, 80, 90,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.78,
  '{"wlb":0.8,"growth":0.85,"stability":0.9,"income":0.9,"teamwork":0.95,"solo_deep":0.75,"analytical":0.95,"creative":0.7,"execution":0.9,"people_facing":0.98,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"가벼운 작업 강도로 야근 적고 교대 근무 없음","growth":"자동차 산업 기술 발전 기회 좋음","stability":"제조업으로 고용 안정성 매우 좋음","income":"반장급으로 상위 소득","teamwork":"작업원 감독/관리로 협업 매우 중요","solo_deep":"검사 계획 수립, 품질 분석 작업으로 독립 작업 多","analytical":"차체/섀시 분석, 검사카드 점검으로 분석 매우 중요","creative":"공정 최적화로 창의성 보통","execution":"작업 배치, 감독 실행 중심","people_facing":"작업원 지도/교육/면담으로 대인관계 매우 多","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285290359859',
  '자동차섀시검사원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 60, 80, 70,
  75, 60, 85, 45, 75, 65,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.77,
  '{"wlb":0.8,"growth":0.8,"stability":0.9,"income":0.85,"teamwork":0.85,"solo_deep":0.8,"analytical":0.95,"creative":0.7,"execution":0.85,"people_facing":0.85,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"가벼운 작업 강도로 야근 적고 교대 근무 없음","growth":"자동차 산업 기술 발전 기회 좋음","stability":"제조업으로 고용 안정성 매우 좋음","income":"전문 섀시검사로 상위 소득","teamwork":"검사 작업 협업 중요","solo_deep":"부품 조립 상태 분석, 엔진 작동 검사 작업으로 독립 작업 多","analytical":"조립 상태/성능 분석, 계기 관찰로 분석 매우 중요","creative":"검사 방법 최적화로 창의성 보통","execution":"부품 검사, 엔진 시험 실행 중심","people_facing":"작업원 지시 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285290922717',
  '자동차서브조립원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 55, 80, 65,
  75, 50, 70, 45, 75, 65,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.75,
  '{"wlb":0.8,"growth":0.75,"stability":0.9,"income":0.8,"teamwork":0.85,"solo_deep":0.7,"analytical":0.85,"creative":0.7,"execution":0.85,"people_facing":0.85,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적고 교대 근무 없음","growth":"자동차 산업 기술 발전 기회 좋음","stability":"제조업으로 고용 안정성 매우 좋음","income":"전문 서브조립으로 중위 소득","teamwork":"조립 작업 협업 중요","solo_deep":"부품 준비, 공구 조작 작업으로 독립 작업 多","analytical":"부품 상태 확인으로 분석 중요","creative":"조립 방법 최적화로 창의성 보통","execution":"부품 조립, 윤활유 주입 실행 중심","people_facing":"라인 작업 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285291488193',
  '자동차수밀검사원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 55, 80, 70,
  70, 55, 80, 45, 75, 65,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.76,
  '{"wlb":0.8,"growth":0.75,"stability":0.9,"income":0.85,"teamwork":0.8,"solo_deep":0.75,"analytical":0.95,"creative":0.7,"execution":0.85,"people_facing":0.85,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"가벼운 작업 강도로 야근 적고 교대 근무 없음","growth":"자동차 산업 기술 발전 기회 좋음","stability":"제조업으로 고용 안정성 매우 좋음","income":"전문 수밀검사로 상위 소득","teamwork":"검사 작업 협업 중요","solo_deep":"분사장치 조작, 누수 확인 작업으로 독립 작업 多","analytical":"누수 부위 분석, 검사카드 기록으로 분석 매우 중요","creative":"검사 방법 최적화로 창의성 보통","execution":"압력 분사, 누수 검사 실행 중심","people_facing":"작업원 지시 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285292031239',
  '자동차수밀수정원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  65, 55, 80, 65,
  70, 50, 70, 50, 70, 60,
  'regular', 'possible', 'none', 'none',
  'none', 'none', 'none',
  0.75,
  '{"wlb":0.8,"growth":0.7,"stability":0.9,"income":0.8,"teamwork":0.8,"solo_deep":0.7,"analytical":0.85,"creative":0.7,"execution":0.8,"people_facing":0.8,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 가능, 교대 근무 가능","growth":"자동차 산업 기술 발전 기회 좋음","stability":"제조업으로 고용 안정성 매우 좋음","income":"전문 수밀수정으로 중위 소득","teamwork":"수정 작업 협업 중요","solo_deep":"누수 부위 판별, 기밀재 적용 작업으로 독립 작업 多","analytical":"결함 부위 분석으로 분석 중요","creative":"수정 방법 최적화로 창의성 보통","execution":"밀봉재 도포, 팩킹 교환 실행 중심","people_facing":"작업 점검 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285292715472',
  '자동차완성검사원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 60, 80, 75,
  70, 60, 85, 45, 75, 65,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.77,
  '{"wlb":0.8,"growth":0.8,"stability":0.9,"income":0.9,"teamwork":0.8,"solo_deep":0.8,"analytical":0.95,"creative":0.7,"execution":0.85,"people_facing":0.85,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"가벼운 작업 강도로 야근 적고 교대 근무 없음","growth":"자동차 산업 기술 발전 기회 좋음","stability":"제조업으로 고용 안정성 매우 좋음","income":"전문 완성검사로 상위 소득","teamwork":"검사 작업 협업 중요","solo_deep":"주행 시험, 품질지수 산출 작업으로 독립 작업 多","analytical":"성능 검사, 품질지수 산출로 분석 매우 중요","creative":"검사 방법 최적화로 창의성 보통","execution":"계기 검사, 주행 시험 실행 중심","people_facing":"보고서 작성 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285293227499',
  '자동차의장검사원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 55, 80, 70,
  70, 55, 80, 45, 75, 65,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.76,
  '{"wlb":0.8,"growth":0.75,"stability":0.9,"income":0.85,"teamwork":0.8,"solo_deep":0.75,"analytical":0.95,"creative":0.7,"execution":0.85,"people_facing":0.85,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적고 교대 근무 없음","growth":"자동차 산업 기술 발전 기회 좋음","stability":"제조업으로 고용 안정성 매우 좋음","income":"전문 의장검사로 상위 소득","teamwork":"검사 작업 협업 중요","solo_deep":"부품 조립 상태 분석, 간격 측정 작업으로 독립 작업 多","analytical":"조립 상태/간격 분석으로 분석 매우 중요","creative":"검사 방법 최적화로 창의성 보통","execution":"부품 검사, 필증 부착 실행 중심","people_facing":"작업원 지시 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285293746713',
  '자동차전장검사원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 60, 80, 70,
  70, 55, 80, 50, 75, 65,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.77,
  '{"wlb":0.8,"growth":0.8,"stability":0.9,"income":0.85,"teamwork":0.8,"solo_deep":0.75,"analytical":0.95,"creative":0.7,"execution":0.85,"people_facing":0.85,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적고 교대 근무 없음","growth":"자동차 산업 기술 발전 기회 좋음","stability":"제조업으로 고용 안정성 매우 좋음","income":"전문 전장검사로 상위 소득","teamwork":"검사 작업 협업 중요","solo_deep":"전기장치 작동 검사, 계기 확인 작업으로 독립 작업 多","analytical":"전기장치 성능 분석으로 분석 매우 중요","creative":"검사 방법 최적화로 창의성 보통","execution":"장치 검사, 필증 부착 실행 중심","people_facing":"작업원 지시 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '176528529426649',
  '자동차조립원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  65, 55, 80, 65,
  80, 45, 70, 50, 75, 70,
  'regular', 'possible', 'none', 'none',
  'none', 'none', 'none',
  0.76,
  '{"wlb":0.8,"growth":0.75,"stability":0.9,"income":0.8,"teamwork":0.9,"solo_deep":0.6,"analytical":0.85,"creative":0.7,"execution":0.85,"people_facing":0.9,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 가능, 교대 근무 가능","growth":"자동차 산업 기술 발전 기회 좋음","stability":"제조업으로 고용 안정성 매우 좋음","income":"전문 조립으로 중위 소득","teamwork":"라인 작업으로 협업 매우 중요","solo_deep":"부품 조립, 공구 조작 작업으로 독립 작업 多","analytical":"부품 상태 확인으로 분석 중요","creative":"조립 방법 최적화로 창의성 보통","execution":"부품 조립, 결합 실행 중심","people_facing":"라인 협업 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285294787157',
  '자동차차체검사원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 55, 80, 70,
  70, 55, 80, 45, 75, 65,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.76,
  '{"wlb":0.8,"growth":0.75,"stability":0.9,"income":0.85,"teamwork":0.8,"solo_deep":0.75,"analytical":0.95,"creative":0.7,"execution":0.85,"people_facing":0.85,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적고 교대 근무 없음","growth":"자동차 산업 기술 발전 기회 좋음","stability":"제조업으로 고용 안정성 매우 좋음","income":"전문 차체검사로 상위 소득","teamwork":"검사 작업 협업 중요","solo_deep":"차체 구조 분석, 용접 상태 확인 작업으로 독립 작업 多","analytical":"차체 상태/용접 분석으로 분석 매우 중요","creative":"검사 방법 최적화로 창의성 보통","execution":"차체 검사, 필증 부착 실행 중심","people_facing":"작업원 지시 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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