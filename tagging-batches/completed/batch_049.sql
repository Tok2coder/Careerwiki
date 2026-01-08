-- Batch tagging SQL generated at 2026-01-06T10:25:43.576Z
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
  '1765285252686185',
  '원석할석원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  60, 50, 75, 60,
  70, 45, 70, 45, 70, 60,
  'regular', 'possible', 'none', 'none',
  'none', 'none', 'none',
  0.74,
  '{"wlb":0.7,"growth":0.7,"stability":0.85,"income":0.75,"teamwork":0.8,"solo_deep":0.6,"analytical":0.85,"creative":0.7,"execution":0.8,"people_facing":0.8,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"힘든 작업 환경으로 야근 가능, 교대 근무 가능","growth":"석재 가공 산업 기술 발전 기회 보통","stability":"제조업으로 고용 안정성 좋음","income":"전문 할석으로 중위 소득","teamwork":"할석 작업 협업 요구","solo_deep":"톱날 마모 점검, 고정 작업으로 독립 작업 多","analytical":"톱날 상태 확인으로 분석 중요","creative":"할석 조건 최적화로 창의성 보통","execution":"기계 조작, 할석 실행 중심","people_facing":"작업 감독 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '17652852529692',
  '원형톱할석원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  65, 50, 75, 60,
  70, 45, 75, 50, 70, 60,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.74,
  '{"wlb":0.8,"growth":0.7,"stability":0.85,"income":0.75,"teamwork":0.8,"solo_deep":0.6,"analytical":0.9,"creative":0.7,"execution":0.8,"people_facing":0.8,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적고 교대 근무 없음","growth":"석재 가공 산업 기술 발전 기회 보통","stability":"제조업으로 고용 안정성 좋음","income":"전문 할석으로 중위 소득","teamwork":"할석 작업 협업 요구","solo_deep":"치수 표시, 절단 작업으로 독립 작업 多","analytical":"치수 측정, 절단 상태 확인으로 분석 매우 중요","creative":"절단 패턴 최적화로 창의성 보통","execution":"톱날 조작, 절단 실행 중심","people_facing":"작업 감독 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285253286863',
  '파쇄반장',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  60, 60, 80, 75,
  85, 55, 80, 50, 80, 90,
  'regular', 'possible', 'none', 'none',
  'none', 'none', 'none',
  0.78,
  '{"wlb":0.7,"growth":0.8,"stability":0.9,"income":0.9,"teamwork":0.95,"solo_deep":0.75,"analytical":0.95,"creative":0.7,"execution":0.9,"people_facing":0.98,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"실외 작업 환경으로 야근 가능, 교대 근무 가능","growth":"광업 산업 기술 발전 기회 좋음","stability":"제조업으로 고용 안정성 매우 좋음","income":"반장급으로 상위 소득","teamwork":"작업원 감독/관리로 협업 매우 중요","solo_deep":"기계 상태 점검, 입자 크기 조절 작업으로 독립 작업 多","analytical":"파쇄 상태 분석, 기계 조정으로 분석 매우 중요","creative":"파쇄 공정 최적화로 창의성 보통","execution":"작업 배치, 감독 실행 중심","people_facing":"작업원 지도/교육/면담으로 대인관계 매우 多","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285253569679',
  '광학세라믹소재가공원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 60, 75, 70,
  70, 55, 80, 65, 75, 60,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.76,
  '{"wlb":0.8,"growth":0.8,"stability":0.85,"income":0.85,"teamwork":0.8,"solo_deep":0.75,"analytical":0.95,"creative":0.85,"execution":0.85,"people_facing":0.8,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적고 교대 근무 없음","growth":"광학세라믹 산업 기술 발전 기회 좋음","stability":"제조업으로 고용 안정성 좋음","income":"전문 가공으로 상위 소득","teamwork":"가공 작업 협업 요구","solo_deep":"머시닝센터 조작, 레이저 가공 작업으로 독립 작업 多","analytical":"도면 파악, 품질 검사로 분석 매우 중요","creative":"가공 방법 디자인으로 창의성 매우 높음","execution":"머시닝, 연마, 코팅 실행 중심","people_facing":"작업 감독 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285253906368',
  '광학세라믹소재성형원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 60, 75, 70,
  70, 55, 80, 60, 75, 60,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.76,
  '{"wlb":0.8,"growth":0.8,"stability":0.85,"income":0.85,"teamwork":0.8,"solo_deep":0.75,"analytical":0.95,"creative":0.8,"execution":0.85,"people_facing":0.8,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적고 교대 근무 없음","growth":"광학세라믹 산업 기술 발전 기회 좋음","stability":"제조업으로 고용 안정성 좋음","income":"전문 성형으로 상위 소득","teamwork":"성형 작업 협업 요구","solo_deep":"냉각속도 조절, 몰딩 타이밍 결정 작업으로 독립 작업 多","analytical":"점도 관찰, 균질도 검사로 분석 매우 중요","creative":"몰드 구조 디자인으로 창의성 높음","execution":"냉각, 성형, 검사 실행 중심","people_facing":"작업 감독 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '17652852542834',
  '광학세라믹소재어닐링원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  75, 60, 75, 70,
  70, 55, 85, 50, 75, 60,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.76,
  '{"wlb":0.85,"growth":0.8,"stability":0.85,"income":0.85,"teamwork":0.8,"solo_deep":0.75,"analytical":0.95,"creative":0.7,"execution":0.85,"people_facing":0.8,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"가벼운 작업 강도로 야근 적고 교대 근무 없음","growth":"광학세라믹 산업 기술 발전 기회 좋음","stability":"제조업으로 고용 안정성 좋음","income":"전문 어닐링으로 상위 소득","teamwork":"어닐링 작업 협업 요구","solo_deep":"온도/시간 결정, 응력 평가 작업으로 독립 작업 多","analytical":"잔류응력 분석, 평가로 분석 매우 중요","creative":"어닐링 조건 최적화로 창의성 보통","execution":"가열장비 조작, 평가 실행 중심","people_facing":"작업 감독 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285254578806',
  '광학세라믹소재용융원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 60, 75, 70,
  70, 55, 80, 50, 75, 60,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.76,
  '{"wlb":0.8,"growth":0.8,"stability":0.85,"income":0.85,"teamwork":0.8,"solo_deep":0.75,"analytical":0.95,"creative":0.7,"execution":0.85,"people_facing":0.8,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적고 교대 근무 없음","growth":"광학세라믹 산업 기술 발전 기회 좋음","stability":"제조업으로 고용 안정성 좋음","income":"전문 용융으로 상위 소득","teamwork":"용융 작업 협업 요구","solo_deep":"청징 준비, 용융도 결정 작업으로 독립 작업 多","analytical":"청징 정도 결정, 용융도 분석으로 분석 매우 중요","creative":"용융 조건 최적화로 창의성 보통","execution":"용융로 조작, 청징 실행 중심","people_facing":"작업 감독 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285254904496',
  '광학세라믹소재품질관리원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 60, 75, 70,
  75, 60, 85, 50, 75, 65,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.76,
  '{"wlb":0.8,"growth":0.8,"stability":0.85,"income":0.85,"teamwork":0.85,"solo_deep":0.8,"analytical":0.95,"creative":0.7,"execution":0.85,"people_facing":0.85,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적고 교대 근무 없음","growth":"광학세라믹 산업 기술 발전 기회 좋음","stability":"제조업으로 고용 안정성 좋음","income":"전문 품질관리로 상위 소득","teamwork":"품질관리 작업 협업 중요","solo_deep":"광학특성 측정, 품질 평가 작업으로 독립 작업 多","analytical":"광학특성 분석, 품질 평가로 분석 매우 중요","creative":"품질 기준 최적화로 창의성 보통","execution":"측정, 평가 실행 중심","people_facing":"작업 감독 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285255203098',
  '광학세라믹소재혼합원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 55, 75, 65,
  70, 50, 75, 50, 70, 60,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.75,
  '{"wlb":0.8,"growth":0.75,"stability":0.85,"income":0.8,"teamwork":0.8,"solo_deep":0.7,"analytical":0.9,"creative":0.7,"execution":0.8,"people_facing":0.8,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적고 교대 근무 없음","growth":"광학세라믹 산업 기술 발전 기회 좋음","stability":"제조업으로 고용 안정성 좋음","income":"전문 혼합으로 중위 소득","teamwork":"혼합 작업 협업 요구","solo_deep":"배합비 계산, 혼합 작업으로 독립 작업 多","analytical":"배합비 조절, 품질 확인으로 분석 매우 중요","creative":"혼합 비율 최적화로 창의성 보통","execution":"배합, 혼합 실행 중심","people_facing":"작업 감독 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285255520568',
  '광학유리제조원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 55, 75, 65,
  70, 50, 75, 55, 75, 60,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.75,
  '{"wlb":0.8,"growth":0.75,"stability":0.85,"income":0.8,"teamwork":0.8,"solo_deep":0.7,"analytical":0.9,"creative":0.75,"execution":0.85,"people_facing":0.8,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적고 교대 근무 없음","growth":"광학유리 산업 기술 발전 기회 좋음","stability":"제조업으로 고용 안정성 좋음","income":"전문 제조로 중위 소득","teamwork":"제조 작업 협업 요구","solo_deep":"용융 조절, 성형 작업으로 독립 작업 多","analytical":"용융 상태 분석으로 분석 매우 중요","creative":"제조 조건 최적화로 창의성 높음","execution":"용융, 성형 실행 중심","people_facing":"작업 감독 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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