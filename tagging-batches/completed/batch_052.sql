-- Batch tagging SQL generated at 2026-01-06T10:30:36.472Z
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
  '1765285377804679',
  '문자판조립원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 50, 75, 65,
  70, 50, 75, 70, 75, 60,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.75,
  '{"wlb":0.8,"growth":0.7,"stability":0.85,"income":0.8,"teamwork":0.8,"solo_deep":0.7,"analytical":0.9,"creative":0.9,"execution":0.85,"people_facing":0.8,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"가벼운 작업 강도로 야근 적고 교대 근무 없음","growth":"시계 산업 기술 발전 기회 보통","stability":"제조업으로 고용 안정성 좋음","income":"전문 조립으로 중위 소득","teamwork":"조립 작업 협업 요구","solo_deep":"도면 파악, 정밀 작업으로 독립 작업 多","analytical":"치수/품질 확인으로 분석 매우 중요","creative":"디자인/패턴 최적화로 창의성 매우 높음","execution":"용접, 도금, 부착 실행 중심","people_facing":"작업 협업 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285378161122',
  '문자판타공원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 50, 75, 65,
  70, 50, 75, 45, 75, 60,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.75,
  '{"wlb":0.8,"growth":0.7,"stability":0.85,"income":0.8,"teamwork":0.8,"solo_deep":0.7,"analytical":0.9,"creative":0.7,"execution":0.85,"people_facing":0.8,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"가벼운 작업 강도로 야근 적고 교대 근무 없음","growth":"시계 산업 기술 발전 기회 보통","stability":"제조업으로 고용 안정성 좋음","income":"전문 타공으로 중위 소득","teamwork":"타공 작업 협업 요구","solo_deep":"측정기 사용, 위치 확인으로 독립 작업 多","analytical":"위치 거리 측정, 품질 확인으로 분석 매우 중요","creative":"타공 패턴 최적화로 창의성 보통","execution":"프레스 조작, 타공 실행 중심","people_facing":"작업 협업 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285378599262',
  '박막트랜지스터검사원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 70, 80, 75,
  70, 60, 85, 50, 75, 65,
  'regular', 'none', 'none', 'none',
  'college', 'none', 'none',
  0.77,
  '{"wlb":0.8,"growth":0.85,"stability":0.9,"income":0.9,"teamwork":0.8,"solo_deep":0.8,"analytical":0.95,"creative":0.7,"execution":0.85,"people_facing":0.85,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"가벼운 작업 강도로 야근 적고 교대 근무 없음","growth":"반도체/디스플레이 산업 기술 발전 기회 매우 좋음","stability":"제조업으로 고용 안정성 매우 좋음","income":"전문 검사로 상위 소득","teamwork":"검사 작업 협업 중요","solo_deep":"측정장비 조작, 데이터 분석으로 독립 작업 多","analytical":"전기적/광학적 특성 분석, 품질 평가로 분석 매우 중요","creative":"검사 방법 최적화로 창의성 보통","execution":"측정, 판정 실행 중심","people_facing":"결과 통보 업무","degree_required":"전문대졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285379122323',
  '박막트랜지스터모듈조립원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 65, 80, 70,
  75, 55, 75, 55, 80, 70,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.76,
  '{"wlb":0.8,"growth":0.8,"stability":0.9,"income":0.85,"teamwork":0.85,"solo_deep":0.75,"analytical":0.9,"creative":0.75,"execution":0.9,"people_facing":0.9,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적고 교대 근무 없음","growth":"반도체/디스플레이 산업 기술 발전 기회 좋음","stability":"제조업으로 고용 안정성 매우 좋음","income":"전문 모듈조립으로 상위 소득","teamwork":"조립 작업 협업 중요","solo_deep":"TAB 부착, IC 실장 작업으로 독립 작업 多","analytical":"구동 평가, 품질 확인으로 분석 매우 중요","creative":"모듈 설계 최적화로 창의성 높음","execution":"TAB 부착, IC 실장, BLU 연결 실행 중심","people_facing":"라인 작업 협업 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285379622640',
  '박막트랜지스터세정원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 60, 80, 70,
  70, 55, 75, 50, 75, 65,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.76,
  '{"wlb":0.8,"growth":0.8,"stability":0.9,"income":0.85,"teamwork":0.8,"solo_deep":0.75,"analytical":0.9,"creative":0.7,"execution":0.85,"people_facing":0.85,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적고 교대 근무 없음","growth":"반도체/디스플레이 산업 기술 발전 기회 좋음","stability":"제조업으로 고용 안정성 매우 좋음","income":"전문 세정으로 상위 소득","teamwork":"세정 작업 협업 중요","solo_deep":"세정기기 조작, 품질 모니터링 작업으로 독립 작업 多","analytical":"이물질 제거 상태 분석으로 분석 매우 중요","creative":"세정 방법 최적화로 창의성 보통","execution":"세정, 건조 실행 중심","people_facing":"작업 협업 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285380062752',
  '박막트랜지스터편광판부착원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 60, 80, 70,
  70, 55, 75, 50, 75, 65,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.76,
  '{"wlb":0.8,"growth":0.8,"stability":0.9,"income":0.85,"teamwork":0.8,"solo_deep":0.75,"analytical":0.9,"creative":0.7,"execution":0.85,"people_facing":0.85,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적고 교대 근무 없음","growth":"반도체/디스플레이 산업 기술 발전 기회 좋음","stability":"제조업으로 고용 안정성 매우 좋음","income":"전문 부착으로 상위 소득","teamwork":"부착 작업 협업 중요","solo_deep":"편광판 교차 각도 조절 작업으로 독립 작업 多","analytical":"패널 상태 점검으로 분석 매우 중요","creative":"부착 방법 최적화로 창의성 보통","execution":"편광판 부착 실행 중심","people_facing":"작업 협업 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285380378139',
  '반도체장비전장조립원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 70, 85, 80,
  75, 60, 85, 60, 80, 70,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.78,
  '{"wlb":0.8,"growth":0.85,"stability":0.95,"income":0.95,"teamwork":0.85,"solo_deep":0.8,"analytical":0.95,"creative":0.8,"execution":0.9,"people_facing":0.9,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적고 교대 근무 없음","growth":"반도체 장비 산업 기술 발전 기회 매우 좋음","stability":"제조업으로 고용 안정성 매우 좋음","income":"전문 전장조립으로 상위 소득","teamwork":"조립 작업 협업 중요","solo_deep":"배선 설계, 안전 기준 분석 작업으로 독립 작업 多","analytical":"전원 특성 분석, 안전 기준 준수로 분석 매우 중요","creative":"배선 최적화 설계로 창의성 높음","execution":"배선 작업 실행 중심","people_facing":"라인 작업 협업 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285380766840',
  '반도체장비조립원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 70, 85, 80,
  75, 55, 80, 55, 80, 70,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.78,
  '{"wlb":0.8,"growth":0.85,"stability":0.95,"income":0.95,"teamwork":0.85,"solo_deep":0.75,"analytical":0.95,"creative":0.75,"execution":0.9,"people_facing":0.9,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적고 교대 근무 없음","growth":"반도체 장비 산업 기술 발전 기회 매우 좋음","stability":"제조업으로 고용 안정성 매우 좋음","income":"전문 조립으로 상위 소득","teamwork":"조립 작업 협업 중요","solo_deep":"부품 조립, 품질 검사 작업으로 독립 작업 多","analytical":"조립 품질 분석으로 분석 매우 중요","creative":"조립 방법 최적화로 창의성 높음","execution":"부품 조립, 연결 실행 중심","people_facing":"라인 작업 협업 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285381154667',
  '반도체장비청소원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 55, 80, 65,
  75, 45, 65, 40, 70, 70,
  'regular', 'possible', 'none', 'none',
  'none', 'none', 'none',
  0.75,
  '{"wlb":0.8,"growth":0.75,"stability":0.9,"income":0.8,"teamwork":0.85,"solo_deep":0.6,"analytical":0.8,"creative":0.65,"execution":0.8,"people_facing":0.9,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 가능, 교대 근무 가능","growth":"반도체 산업 기술 발전 기회 좋음","stability":"제조업으로 고용 안정성 매우 좋음","income":"전문 청소로 중위 소득","teamwork":"청소 작업 협업 중요","solo_deep":"청소 장비 조작, 오염도 확인 작업으로 독립 작업 多","analytical":"오염 상태 분석으로 분석 중요","creative":"청소 방법 최적화로 창의성 낮음","execution":"청소, 점검 실행 중심","people_facing":"작업 협업 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285381582455',
  '반도체장비품질관리원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 70, 85, 80,
  75, 65, 85, 55, 80, 70,
  'regular', 'none', 'none', 'none',
  'college', 'none', 'none',
  0.78,
  '{"wlb":0.8,"growth":0.85,"stability":0.95,"income":0.95,"teamwork":0.85,"solo_deep":0.85,"analytical":0.95,"creative":0.75,"execution":0.9,"people_facing":0.9,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적고 교대 근무 없음","growth":"반도체 장비 산업 기술 발전 기회 매우 좋음","stability":"제조업으로 고용 안정성 매우 좋음","income":"전문 품질관리로 상위 소득","teamwork":"품질관리 작업 협업 중요","solo_deep":"품질 데이터 분석, 개선안 수립 작업으로 독립 작업 多","analytical":"품질 데이터 분석, 개선안 수립으로 분석 매우 중요","creative":"품질 관리 시스템 최적화로 창의성 높음","execution":"품질 검사, 보고 실행 중심","people_facing":"부서 간 협업 업무","degree_required":"전문대졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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