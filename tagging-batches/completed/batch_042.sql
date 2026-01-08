-- Batch tagging SQL generated at 2026-01-06T10:11:33.084Z
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
  '1765284974442428',
  '가발모발직조원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 50, 75, 60,
  65, 45, 65, 55, 70, 55,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.74,
  '{"wlb":0.8,"growth":0.7,"stability":0.85,"income":0.75,"teamwork":0.8,"solo_deep":0.6,"analytical":0.8,"creative":0.75,"execution":0.8,"people_facing":0.75,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적고 교대 근무 없음","growth":"가발 제조 산업 기술 발전 기회 보통","stability":"제조업으로 고용 안정성 좋음","income":"전문 직조로 중위 소득","teamwork":"직조 작업 협업 요구","solo_deep":"재봉 작업, 품질 검사로 독립 작업 多","analytical":"무게 측정, 품질 확인으로 분석 중요","creative":"직조 패턴 최적화로 창의성 높음","execution":"기계 조작, 직조 실행 중심","people_facing":"작업 점검 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '176528497482664',
  '가발베이스제조원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 50, 75, 60,
  65, 45, 70, 70, 70, 55,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.75,
  '{"wlb":0.8,"growth":0.7,"stability":0.85,"income":0.75,"teamwork":0.8,"solo_deep":0.6,"analytical":0.85,"creative":0.9,"execution":0.8,"people_facing":0.75,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적고 교대 근무 없음","growth":"가발 제조 산업 기술 발전 기회 보통","stability":"제조업으로 고용 안정성 좋음","income":"전문 베이스 제조로 중위 소득","teamwork":"베이스 제조 작업 협업 요구","solo_deep":"치수 측정, 재단 작업으로 독립 작업 多","analytical":"치수 계산, 색상 확인으로 분석 중요","creative":"디자인/형태 최적화로 창의성 매우 높음","execution":"재단, 재봉 실행 중심","people_facing":"작업 점검 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765284975220934',
  '가발식모원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 50, 75, 60,
  65, 45, 65, 60, 70, 55,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.74,
  '{"wlb":0.8,"growth":0.7,"stability":0.85,"income":0.75,"teamwork":0.8,"solo_deep":0.6,"analytical":0.8,"creative":0.8,"execution":0.8,"people_facing":0.75,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적고 교대 근무 없음","growth":"가발 제조 산업 기술 발전 기회 보통","stability":"제조업으로 고용 안정성 좋음","income":"전문 식모로 중위 소득","teamwork":"식모 작업 협업 요구","solo_deep":"바늘 조작, 길이 조절 작업으로 독립 작업 多","analytical":"길이 측정, 상태 확인으로 분석 중요","creative":"식모 패턴 최적화로 창의성 높음","execution":"기계 조작, 식모 실행 중심","people_facing":"작업 점검 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765284975637955',
  '가발원사가공처리원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 50, 75, 60,
  65, 45, 70, 55, 70, 55,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.74,
  '{"wlb":0.8,"growth":0.7,"stability":0.85,"income":0.75,"teamwork":0.8,"solo_deep":0.6,"analytical":0.85,"creative":0.75,"execution":0.8,"people_facing":0.75,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적고 교대 근무 없음","growth":"가발 제조 산업 기술 발전 기회 보통","stability":"제조업으로 고용 안정성 좋음","income":"전문 가공으로 중위 소득","teamwork":"가공 작업 협업 요구","solo_deep":"염색/표백, 재단 작업으로 독립 작업 多","analytical":"색상 확인, 중량 측정으로 분석 중요","creative":"색상/길이 최적화로 창의성 높음","execution":"염색, 재단 실행 중심","people_facing":"작업 점검 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765284975923900',
  '가죽건조반장',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  65, 60, 80, 70,
  85, 55, 75, 50, 80, 90,
  'regular', 'possible', 'none', 'none',
  'none', 'none', 'none',
  0.78,
  '{"wlb":0.8,"growth":0.8,"stability":0.9,"income":0.85,"teamwork":0.95,"solo_deep":0.75,"analytical":0.9,"creative":0.7,"execution":0.9,"people_facing":0.98,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적지만 교대 근무 가능","growth":"가죽 제조 산업 기술 발전 기회 좋음","stability":"제조업으로 고용 안정성 매우 좋음","income":"반장급으로 상위 소득","teamwork":"작업원 감독/관리로 협업 매우 중요","solo_deep":"작업 계획 수립, 품질 관리 작업으로 독립 작업 多","analytical":"생산량 분석, 품질 검토로 분석 중요","creative":"공정 최적화로 창의성 보통","execution":"작업 배치, 감독 실행 중심","people_facing":"작업원 지도/교육/면담으로 대인관계 매우 多","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765284976302510',
  '가죽건조원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 50, 75, 60,
  65, 45, 70, 50, 70, 55,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.74,
  '{"wlb":0.8,"growth":0.7,"stability":0.85,"income":0.75,"teamwork":0.8,"solo_deep":0.6,"analytical":0.85,"creative":0.7,"execution":0.8,"people_facing":0.75,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적고 교대 근무 없음","growth":"가죽 제조 산업 기술 발전 기회 보통","stability":"제조업으로 고용 안정성 좋음","income":"전문 건조로 중위 소득","teamwork":"건조 작업 협업 요구","solo_deep":"온도/습도 조절, 상태 관찰 작업으로 독립 작업 多","analytical":"수분함량 측정, 품질 확인으로 분석 중요","creative":"건조 조건 최적화로 창의성 보통","execution":"기계 조작, 건조 실행 중심","people_facing":"작업 점검 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765284976581208',
  '가죽도장공',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 50, 75, 60,
  65, 45, 65, 55, 70, 55,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.74,
  '{"wlb":0.8,"growth":0.7,"stability":0.85,"income":0.75,"teamwork":0.8,"solo_deep":0.6,"analytical":0.8,"creative":0.75,"execution":0.8,"people_facing":0.75,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적고 교대 근무 없음","growth":"가죽 제조 산업 기술 발전 기회 보통","stability":"제조업으로 고용 안정성 좋음","income":"전문 도장으로 중위 소득","teamwork":"도장 작업 협업 요구","solo_deep":"용액 조절, 분무 작업으로 독립 작업 多","analytical":"색상/표면 확인으로 분석 중요","creative":"색상/패턴 최적화로 창의성 높음","execution":"분무, 도장 실행 중심","people_facing":"작업 점검 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765284976852667',
  '가죽마무리공',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 50, 75, 60,
  65, 45, 70, 60, 70, 55,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.74,
  '{"wlb":0.8,"growth":0.7,"stability":0.85,"income":0.75,"teamwork":0.8,"solo_deep":0.6,"analytical":0.85,"creative":0.8,"execution":0.8,"people_facing":0.75,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적고 교대 근무 없음","growth":"가죽 제조 산업 기술 발전 기회 보통","stability":"제조업으로 고용 안정성 좋음","income":"전문 마무리로 중위 소득","teamwork":"마무리 작업 협업 요구","solo_deep":"표면 처리, 광택 작업으로 독립 작업 多","analytical":"표면 상태 확인, 품질 검사로 분석 중요","creative":"마무리 효과 최적화로 창의성 높음","execution":"연마, 코팅 실행 중심","people_facing":"작업 점검 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765284977165119',
  '가죽염색원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 50, 75, 60,
  65, 45, 70, 65, 70, 55,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.75,
  '{"wlb":0.8,"growth":0.7,"stability":0.85,"income":0.75,"teamwork":0.8,"solo_deep":0.6,"analytical":0.85,"creative":0.85,"execution":0.8,"people_facing":0.75,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적고 교대 근무 없음","growth":"가죽 제조 산업 기술 발전 기회 보통","stability":"제조업으로 고용 안정성 좋음","income":"전문 염색으로 중위 소득","teamwork":"염색 작업 협업 요구","solo_deep":"색상 조절, 상태 관찰 작업으로 독립 작업 多","analytical":"색상 확인, 품질 검사로 분석 중요","creative":"색상/패턴 최적화로 창의성 매우 높음","execution":"염색, 처리 실행 중심","people_facing":"작업 점검 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765284977477761',
  '가죽제혁원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  65, 55, 75, 65,
  70, 50, 75, 45, 75, 60,
  'regular', 'possible', 'none', 'none',
  'none', 'none', 'none',
  0.76,
  '{"wlb":0.8,"growth":0.75,"stability":0.85,"income":0.8,"teamwork":0.8,"solo_deep":0.7,"analytical":0.9,"creative":0.7,"execution":0.85,"people_facing":0.8,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적지만 교대 근무 가능","growth":"가죽 제조 산업 기술 발전 기회 좋음","stability":"제조업으로 고용 안정성 좋음","income":"전문 제혁으로 중위 소득","teamwork":"제혁 작업 협업 요구","solo_deep":"화학 처리, 상태 모니터링 작업으로 독립 작업 多","analytical":"처리 상태 분석, 품질 검사로 분석 매우 중요","creative":"처리 방법 최적화로 창의성 보통","execution":"화학 처리, 제혁 실행 중심","people_facing":"작업 감독 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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