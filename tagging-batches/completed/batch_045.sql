-- Batch tagging SQL generated at 2026-01-06T10:20:30.680Z
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
  '1765285097069397',
  '강화플라스틱제조원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 55, 75, 65,
  70, 45, 70, 65, 75, 60,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.75,
  '{"wlb":0.8,"growth":0.75,"stability":0.85,"income":0.8,"teamwork":0.8,"solo_deep":0.6,"analytical":0.85,"creative":0.85,"execution":0.85,"people_facing":0.8,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적고 교대 근무 없음","growth":"플라스틱 제조 산업 기술 발전 기회 좋음","stability":"제조업으로 고용 안정성 좋음","income":"전문 강화제조로 중위 소득","teamwork":"제조 작업 협업 요구","solo_deep":"치수 측정, 연마 작업으로 독립 작업 多","analytical":"치수/강도 측정으로 분석 중요","creative":"형태/색상 디자인 최적화로 창의성 매우 높음","execution":"적층, 연마, 착색 실행 중심","people_facing":"작업 감독 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285097493961',
  '강화플라스틱제조현장감독자',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  65, 65, 80, 75,
  85, 60, 80, 55, 80, 95,
  'regular', 'possible', 'none', 'none',
  'college', 'none', 'none',
  0.79,
  '{"wlb":0.8,"growth":0.8,"stability":0.9,"income":0.9,"teamwork":0.95,"solo_deep":0.8,"analytical":0.95,"creative":0.75,"execution":0.9,"people_facing":0.98,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적지만 교대 근무 가능","growth":"플라스틱 제조 산업 기술 발전 기회 좋음","stability":"제조업으로 고용 안정성 매우 좋음","income":"감독자급으로 상위 소득","teamwork":"작업원 감독/관리로 협업 매우 중요","solo_deep":"작업 계획 수립, 품질 관리 작업으로 독립 작업 多","analytical":"설비 관리, 품질 검토로 분석 매우 중요","creative":"공정 최적화로 창의성 보통","execution":"작업 배치, 감독 실행 중심","people_facing":"작업원 지도/교육/면담으로 대인관계 매우 多","degree_required":"전문대졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285097826308',
  '경화성수지성형기조작원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 50, 75, 60,
  70, 45, 70, 55, 70, 55,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.74,
  '{"wlb":0.8,"growth":0.7,"stability":0.85,"income":0.75,"teamwork":0.8,"solo_deep":0.6,"analytical":0.85,"creative":0.75,"execution":0.8,"people_facing":0.75,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적고 교대 근무 없음","growth":"플라스틱 제조 산업 기술 발전 기회 보통","stability":"제조업으로 고용 안정성 좋음","income":"전문 성형으로 중위 소득","teamwork":"성형 작업 협업 요구","solo_deep":"압력/온도 조절, 품질 검사 작업으로 독립 작업 多","analytical":"압력/온도 모니터링으로 분석 중요","creative":"색상/무늬 디자인 최적화로 창의성 높음","execution":"성형, 연마 실행 중심","people_facing":"작업 점검 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285098238390',
  '낚싯대경화원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 50, 75, 60,
  65, 40, 70, 45, 70, 55,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.74,
  '{"wlb":0.8,"growth":0.7,"stability":0.85,"income":0.75,"teamwork":0.8,"solo_deep":0.6,"analytical":0.85,"creative":0.7,"execution":0.8,"people_facing":0.75,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적고 교대 근무 없음","growth":"스포츠 용구 제조 산업 기술 발전 기회 보통","stability":"제조업으로 고용 안정성 좋음","income":"전문 경화로 중위 소득","teamwork":"경화 작업 협업 요구","solo_deep":"온도 조절, 상태 관찰 작업으로 독립 작업 多","analytical":"경화 상태 검사로 분석 중요","creative":"온도 조건 최적화로 창의성 보통","execution":"소성, 냉각 실행 중심","people_facing":"작업 점검 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285098553178',
  '낚싯대롤링원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 45, 75, 55,
  65, 35, 60, 45, 65, 55,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.73,
  '{"wlb":0.8,"growth":0.65,"stability":0.85,"income":0.7,"teamwork":0.8,"solo_deep":0.55,"analytical":0.8,"creative":0.7,"execution":0.8,"people_facing":0.75,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적고 교대 근무 없음","growth":"스포츠 용구 제조 산업 기술 발전 기회 낮음","stability":"제조업으로 고용 안정성 좋음","income":"기본 롤링으로 중위 하위 소득","teamwork":"롤링 작업 협업 요구","solo_deep":"압력/온도 조절 작업으로 독립 작업 少","analytical":"소재 이상 검사로 분석 보통","creative":"압착 조건 최적화로 창의성 보통","execution":"롤링, 검사 실행 중심","people_facing":"작업 점검 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285098961412',
  '낚싯대수지가공원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 50, 75, 60,
  65, 40, 65, 50, 70, 55,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.74,
  '{"wlb":0.8,"growth":0.7,"stability":0.85,"income":0.75,"teamwork":0.8,"solo_deep":0.6,"analytical":0.8,"creative":0.7,"execution":0.8,"people_facing":0.75,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적고 교대 근무 없음","growth":"스포츠 용구 제조 산업 기술 발전 기회 보통","stability":"제조업으로 고용 안정성 좋음","income":"전문 가공으로 중위 소득","teamwork":"가공 작업 협업 요구","solo_deep":"함침시간 조절, 상태 관찰 작업으로 독립 작업 多","analytical":"함침 상태 모니터링으로 분석 중요","creative":"함침 조건 최적화로 창의성 보통","execution":"함침, 건조 실행 중심","people_facing":"작업 점검 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285099297532',
  '낚싯대절단원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 45, 75, 55,
  65, 35, 60, 40, 65, 55,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.73,
  '{"wlb":0.8,"growth":0.65,"stability":0.85,"income":0.7,"teamwork":0.8,"solo_deep":0.55,"analytical":0.8,"creative":0.65,"execution":0.8,"people_facing":0.75,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적고 교대 근무 없음","growth":"스포츠 용구 제조 산업 기술 발전 기회 낮음","stability":"제조업으로 고용 안정성 좋음","income":"기본 절단으로 중위 하위 소득","teamwork":"절단 작업 협업 요구","solo_deep":"칼날 간격 조절 작업으로 독립 작업 少","analytical":"치수 확인으로 분석 보통","creative":"절단 방법 최적화로 창의성 낮음","execution":"절단, 검사 실행 중심","people_facing":"작업 점검 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285099702988',
  '낚싯대제조반장',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  65, 60, 80, 70,
  85, 55, 75, 50, 80, 90,
  'regular', 'possible', 'none', 'none',
  'none', 'none', 'none',
  0.78,
  '{"wlb":0.8,"growth":0.8,"stability":0.9,"income":0.85,"teamwork":0.95,"solo_deep":0.75,"analytical":0.9,"creative":0.7,"execution":0.9,"people_facing":0.98,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적지만 교대 근무 가능","growth":"스포츠 용구 제조 산업 기술 발전 기회 좋음","stability":"제조업으로 고용 안정성 매우 좋음","income":"반장급으로 상위 소득","teamwork":"작업원 감독/관리로 협업 매우 중요","solo_deep":"작업 계획 수립, 품질 관리 작업으로 독립 작업 多","analytical":"생산량 분석, 품질 검토로 분석 중요","creative":"공정 최적화로 창의성 보통","execution":"작업 배치, 감독 실행 중심","people_facing":"작업원 지도/교육/면담으로 대인관계 매우 多","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285100103918',
  '낚싯대코팅원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 50, 75, 60,
  65, 40, 65, 55, 70, 55,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.74,
  '{"wlb":0.8,"growth":0.7,"stability":0.85,"income":0.75,"teamwork":0.8,"solo_deep":0.6,"analytical":0.8,"creative":0.75,"execution":0.8,"people_facing":0.75,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적고 교대 근무 없음","growth":"스포츠 용구 제조 산업 기술 발전 기회 보통","stability":"제조업으로 고용 안정성 좋음","income":"전문 코팅으로 중위 소득","teamwork":"코팅 작업 협업 요구","solo_deep":"코팅액 조절, 상태 관찰 작업으로 독립 작업 多","analytical":"코팅 상태 확인으로 분석 중요","creative":"코팅 조건 최적화로 창의성 높음","execution":"코팅, 건조 실행 중심","people_facing":"작업 점검 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285100516906',
  '낚싯대풀링원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 45, 75, 55,
  65, 35, 60, 45, 65, 55,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.73,
  '{"wlb":0.8,"growth":0.65,"stability":0.85,"income":0.7,"teamwork":0.8,"solo_deep":0.55,"analytical":0.8,"creative":0.7,"execution":0.8,"people_facing":0.75,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적고 교대 근무 없음","growth":"스포츠 용구 제조 산업 기술 발전 기회 낮음","stability":"제조업으로 고용 안정성 좋음","income":"기본 풀링으로 중위 하위 소득","teamwork":"풀링 작업 협업 요구","solo_deep":"풀링 기계 조작 작업으로 독립 작업 少","analytical":"풀링 상태 확인으로 분석 보통","creative":"풀링 조건 최적화로 창의성 보통","execution":"풀링 실행 중심","people_facing":"작업 점검 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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