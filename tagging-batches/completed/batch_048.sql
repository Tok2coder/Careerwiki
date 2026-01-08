-- Batch tagging SQL generated at 2026-01-06T10:23:45.920Z
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
  '1765285214441131',
  '유리섬유용융로조작원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  75, 55, 75, 65,
  70, 50, 75, 45, 75, 60,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.75,
  '{"wlb":0.85,"growth":0.75,"stability":0.85,"income":0.8,"teamwork":0.8,"solo_deep":0.7,"analytical":0.9,"creative":0.7,"execution":0.85,"people_facing":0.8,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"가벼운 작업 강도로 야근 적고 교대 근무 없음","growth":"유리 제조 산업 기술 발전 기회 좋음","stability":"제조업으로 고용 안정성 좋음","income":"전문 용융로로 중위 소득","teamwork":"용융 작업 협업 요구","solo_deep":"온도/연료 조절, 용해 상태 모니터링 작업으로 독립 작업 多","analytical":"용해 상태 분석, 게이지 조정으로 분석 매우 중요","creative":"용융 조건 최적화로 창의성 보통","execution":"용융, 방사 실행 중심","people_facing":"작업 감독 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '176528521470693',
  '유리세척기조작원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  65, 50, 75, 60,
  65, 45, 70, 45, 70, 55,
  'regular', 'possible', 'none', 'none',
  'none', 'none', 'none',
  0.74,
  '{"wlb":0.8,"growth":0.7,"stability":0.85,"income":0.75,"teamwork":0.8,"solo_deep":0.6,"analytical":0.85,"creative":0.7,"execution":0.8,"people_facing":0.75,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"힘든 작업 환경으로 야근 가능, 교대 근무 가능","growth":"유리 제조 산업 기술 발전 기회 보통","stability":"제조업으로 고용 안정성 좋음","income":"전문 세척으로 중위 소득","teamwork":"세척 작업 협업 요구","solo_deep":"두께 조절, 상태 점검 작업으로 독립 작업 多","analytical":"오염도 확인, 품질 검사로 분석 중요","creative":"세척 조건 최적화로 창의성 보통","execution":"세척, 건조 실행 중심","people_facing":"작업 점검 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285214995330',
  '유리수지배합원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 50, 75, 60,
  65, 45, 70, 50, 70, 55,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.74,
  '{"wlb":0.8,"growth":0.7,"stability":0.85,"income":0.75,"teamwork":0.8,"solo_deep":0.6,"analytical":0.85,"creative":0.7,"execution":0.8,"people_facing":0.75,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적고 교대 근무 없음","growth":"유리 제조 산업 기술 발전 기회 보통","stability":"제조업으로 고용 안정성 좋음","income":"전문 배합으로 중위 소득","teamwork":"배합 작업 협업 요구","solo_deep":"성분 측정, 온도 조절 작업으로 독립 작업 多","analytical":"성분 측정, 품질 검사로 분석 중요","creative":"수지 조성 최적화로 창의성 보통","execution":"배합, 반응 실행 중심","people_facing":"작업 점검 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285215375137',
  '유리연마기조작원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 50, 75, 60,
  65, 45, 65, 50, 70, 55,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.74,
  '{"wlb":0.8,"growth":0.7,"stability":0.85,"income":0.75,"teamwork":0.8,"solo_deep":0.6,"analytical":0.8,"creative":0.7,"execution":0.8,"people_facing":0.75,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적고 교대 근무 없음","growth":"유리 제조 산업 기술 발전 기회 보통","stability":"제조업으로 고용 안정성 좋음","income":"전문 연마로 중위 소득","teamwork":"연마 작업 협업 요구","solo_deep":"휠 선택, 상태 점검 작업으로 독립 작업 多","analytical":"완성품 검사로 분석 중요","creative":"연마 조건 최적화로 창의성 보통","execution":"연마, 검사 실행 중심","people_facing":"작업 점검 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285215697611',
  '화학비료제조장치조작원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 55, 75, 70,
  70, 55, 80, 50, 80, 65,
  'regular', 'none', 'none', 'none',
  'college', 'none', 'none',
  0.76,
  '{"wlb":0.8,"growth":0.75,"stability":0.85,"income":0.85,"teamwork":0.8,"solo_deep":0.75,"analytical":0.95,"creative":0.7,"execution":0.9,"people_facing":0.85,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"아주 가벼운 작업 환경으로 야근 적고 교대 근무 없음","growth":"화학비료 산업 기술 발전 기회 좋음","stability":"제조업으로 고용 안정성 좋음","income":"전문 제조장치로 상위 소득","teamwork":"제조 작업 협업 요구","solo_deep":"모니터링, 제어판 조작 작업으로 독립 작업 多","analytical":"온도/압력/속도 모니터링, 문제 해결로 분석 매우 중요","creative":"공정 최적화로 창의성 보통","execution":"장치 제어, 문제 해결 실행 중심","people_facing":"현장원 지시, 보고 업무","degree_required":"전문대졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285216100990',
  '유리용융로조작원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  75, 55, 75, 65,
  70, 50, 75, 45, 75, 60,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.75,
  '{"wlb":0.85,"growth":0.75,"stability":0.85,"income":0.8,"teamwork":0.8,"solo_deep":0.7,"analytical":0.9,"creative":0.7,"execution":0.85,"people_facing":0.8,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"가벼운 작업 강도로 야근 적고 교대 근무 없음","growth":"유리 제조 산업 기술 발전 기회 좋음","stability":"제조업으로 고용 안정성 좋음","income":"전문 용융로로 중위 소득","teamwork":"용융 작업 협업 요구","solo_deep":"온도 조절, 용융 상태 모니터링 작업으로 독립 작업 多","analytical":"용융 상태 분석, 기포 제거로 분석 매우 중요","creative":"용융 조건 최적화로 창의성 보통","execution":"원료 투입, 용융 유지 실행 중심","people_facing":"작업 감독 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285216494456',
  '유리원료분쇄원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  65, 50, 75, 60,
  65, 45, 70, 45, 70, 55,
  'regular', 'possible', 'none', 'none',
  'none', 'none', 'none',
  0.74,
  '{"wlb":0.8,"growth":0.7,"stability":0.85,"income":0.75,"teamwork":0.8,"solo_deep":0.6,"analytical":0.85,"creative":0.7,"execution":0.8,"people_facing":0.75,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"실내외 작업으로 야근 가능, 교대 근무 가능","growth":"유리 제조 산업 기술 발전 기회 보통","stability":"제조업으로 고용 안정성 좋음","income":"전문 분쇄로 중위 소득","teamwork":"분쇄 작업 협업 요구","solo_deep":"계량, 분쇄 작업으로 독립 작업 多","analytical":"입도 확인, 품질 검사로 분석 중요","creative":"분쇄 조건 최적화로 창의성 보통","execution":"계량, 분쇄, 저장 실행 중심","people_facing":"작업 점검 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285216849927',
  '유리제조기조작원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  75, 55, 75, 65,
  70, 50, 75, 50, 75, 60,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.75,
  '{"wlb":0.85,"growth":0.75,"stability":0.85,"income":0.8,"teamwork":0.8,"solo_deep":0.7,"analytical":0.9,"creative":0.7,"execution":0.85,"people_facing":0.8,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"가벼운 작업 강도로 야근 적고 교대 근무 없음","growth":"유리 제조 산업 기술 발전 기회 좋음","stability":"제조업으로 고용 안정성 좋음","income":"전문 제조기로 중위 소득","teamwork":"제조 작업 협업 요구","solo_deep":"온도/속도 조절, 상태 모니터링 작업으로 독립 작업 多","analytical":"제조 상태 분석으로 분석 매우 중요","creative":"제조 조건 최적화로 창의성 보통","execution":"제조 실행 중심","people_facing":"작업 감독 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285217211380',
  '유리제품생산기조작원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 55, 75, 65,
  70, 50, 75, 55, 75, 60,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.75,
  '{"wlb":0.8,"growth":0.75,"stability":0.85,"income":0.8,"teamwork":0.8,"solo_deep":0.7,"analytical":0.9,"creative":0.75,"execution":0.85,"people_facing":0.8,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적고 교대 근무 없음","growth":"유리 제조 산업 기술 발전 기회 좋음","stability":"제조업으로 고용 안정성 좋음","income":"전문 생산기로 중위 소득","teamwork":"생산 작업 협업 요구","solo_deep":"기계 설정, 품질 모니터링 작업으로 독립 작업 多","analytical":"생산 상태 분석으로 분석 매우 중요","creative":"생산 조건 최적화로 창의성 높음","execution":"기계 조작, 생산 실행 중심","people_facing":"작업 감독 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285217558468',
  '유리판재단기조작원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 50, 75, 60,
  65, 45, 70, 50, 70, 55,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.74,
  '{"wlb":0.8,"growth":0.7,"stability":0.85,"income":0.75,"teamwork":0.8,"solo_deep":0.6,"analytical":0.85,"creative":0.7,"execution":0.8,"people_facing":0.75,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적고 교대 근무 없음","growth":"유리 제조 산업 기술 발전 기회 보통","stability":"제조업으로 고용 안정성 좋음","income":"전문 재단으로 중위 소득","teamwork":"재단 작업 협업 요구","solo_deep":"규격 설정, 절단 작업으로 독립 작업 多","analytical":"치수 확인으로 분석 중요","creative":"재단 패턴 최적화로 창의성 보통","execution":"재단, 검사 실행 중심","people_facing":"작업 점검 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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