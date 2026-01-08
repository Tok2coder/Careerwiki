-- Batch tagging SQL generated at 2026-01-06T10:21:37.509Z
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
  '1765285139110227',
  '금속원료계량원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  65, 55, 80, 65,
  70, 50, 75, 45, 75, 60,
  'regular', 'possible', 'none', 'none',
  'none', 'none', 'none',
  0.76,
  '{"wlb":0.8,"growth":0.75,"stability":0.9,"income":0.8,"teamwork":0.8,"solo_deep":0.7,"analytical":0.9,"creative":0.7,"execution":0.85,"people_facing":0.8,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적지만 교대 근무 가능","growth":"철강 제조 산업 기술 발전 기회 좋음","stability":"제조업으로 고용 안정성 매우 좋음","income":"전문 계량으로 중위 소득","teamwork":"계량 작업 협업 요구","solo_deep":"품질규격 파악, 수량 산정 작업으로 독립 작업 多","analytical":"품질규격 파악, 수량 산정으로 분석 매우 중요","creative":"원료 배합 최적화로 창의성 보통","execution":"계량, 점검 실행 중심","people_facing":"설비 점검, 안전 관리 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285139392100',
  '금속원료반장',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  60, 65, 85, 75,
  85, 60, 80, 50, 80, 95,
  'regular', 'possible', 'none', 'none',
  'college', 'none', 'none',
  0.79,
  '{"wlb":0.7,"growth":0.8,"stability":0.95,"income":0.9,"teamwork":0.95,"solo_deep":0.8,"analytical":0.95,"creative":0.7,"execution":0.9,"people_facing":0.98,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"실내외 작업으로 야근 적지만 교대 근무 가능","growth":"철강/비철금속 제조 산업 기술 발전 기회 좋음","stability":"제조업으로 고용 안정성 매우 좋음","income":"반장급으로 상위 소득","teamwork":"작업원 감독/관리로 협업 매우 중요","solo_deep":"작업 계획 수립, 원료 상태 확인 작업으로 독립 작업 多","analytical":"원료 상태/재고 분석으로 분석 매우 중요","creative":"작업 방법 최적화로 창의성 보통","execution":"작업 배치, 감독 실행 중심","people_facing":"작업원 교육/면담, 안전 교육으로 대인관계 매우 多","degree_required":"전문대졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285139684546',
  '금속원료준비원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  65, 55, 80, 65,
  70, 50, 75, 45, 75, 60,
  'regular', 'possible', 'none', 'none',
  'none', 'none', 'none',
  0.76,
  '{"wlb":0.8,"growth":0.75,"stability":0.9,"income":0.8,"teamwork":0.8,"solo_deep":0.7,"analytical":0.9,"creative":0.7,"execution":0.85,"people_facing":0.8,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"실내외 작업으로 야근 적지만 교대 근무 가능","growth":"철강/비철금속 제조 산업 기술 발전 기회 좋음","stability":"제조업으로 고용 안정성 매우 좋음","income":"전문 준비로 중위 소득","teamwork":"준비 작업 협업 요구","solo_deep":"저장 상태 점검, 배합 비율 계산 작업으로 독립 작업 多","analytical":"저장 상태/배합 비율 분석으로 분석 매우 중요","creative":"배합 최적화로 창의성 보통","execution":"점검, 배합 실행 중심","people_facing":"설비 점검 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285140017538',
  '금속자원재생원료가공원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  65, 55, 75, 65,
  70, 45, 70, 45, 75, 60,
  'regular', 'possible', 'none', 'none',
  'none', 'none', 'none',
  0.75,
  '{"wlb":0.8,"growth":0.75,"stability":0.85,"income":0.8,"teamwork":0.8,"solo_deep":0.6,"analytical":0.85,"creative":0.7,"execution":0.85,"people_facing":0.8,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적지만 교대 근무 가능","growth":"재생 산업 기술 발전 기회 좋음","stability":"제조업으로 고용 안정성 좋음","income":"전문 가공으로 중위 소득","teamwork":"가공 작업 협업 요구","solo_deep":"시험분석 결과 확인, 분류 작업으로 독립 작업 多","analytical":"분석 결과에 따른 분류로 분석 중요","creative":"분류/혼합 최적화로 창의성 보통","execution":"분쇄, 분류, 혼합 실행 중심","people_facing":"작업 점검 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285140407950',
  '금속재료용해원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  60, 60, 80, 70,
  75, 55, 80, 50, 80, 65,
  'regular', 'possible', 'none', 'none',
  'none', 'none', 'none',
  0.77,
  '{"wlb":0.7,"growth":0.8,"stability":0.9,"income":0.85,"teamwork":0.85,"solo_deep":0.75,"analytical":0.95,"creative":0.7,"execution":0.9,"people_facing":0.85,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 가능, 교대 근무 가능","growth":"철강 제조 산업 기술 발전 기회 좋음","stability":"제조업으로 고용 안정성 매우 좋음","income":"전문 용해로 상위 소득","teamwork":"용해 작업 협업 중요","solo_deep":"배합비 계산, 성분 분석 작업으로 독립 작업 多","analytical":"배합비 계산, 화학 성분 분석으로 분석 매우 중요","creative":"합금 성분 최적화로 창의성 보통","execution":"장입, 용해, 조절 실행 중심","people_facing":"장비 점검, 작업 감독 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285140698251',
  '금속제련원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  60, 65, 80, 75,
  75, 60, 85, 55, 80, 65,
  'regular', 'possible', 'none', 'none',
  'college', 'none', 'none',
  0.78,
  '{"wlb":0.7,"growth":0.85,"stability":0.9,"income":0.9,"teamwork":0.85,"solo_deep":0.8,"analytical":0.95,"creative":0.75,"execution":0.9,"people_facing":0.85,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 가능, 교대 근무 가능","growth":"비철금속 제조 산업 기술 발전 기회 좋음","stability":"제조업으로 고용 안정성 매우 좋음","income":"전문 제련으로 상위 소득","teamwork":"제련 작업 협업 중요","solo_deep":"공정 선택, 반응 최적화 작업으로 독립 작업 多","analytical":"화학반응 분석, 품질 검사로 분석 매우 중요","creative":"제련 공정 최적화로 창의성 높음","execution":"예비처리, 제련 실행 중심","people_facing":"설비 점검 업무","degree_required":"전문대졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285141042643',
  '금제련원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  60, 65, 80, 80,
  70, 60, 85, 50, 80, 65,
  'regular', 'possible', 'none', 'none',
  'none', 'none', 'none',
  0.78,
  '{"wlb":0.7,"growth":0.85,"stability":0.9,"income":0.95,"teamwork":0.8,"solo_deep":0.8,"analytical":0.95,"creative":0.7,"execution":0.9,"people_facing":0.85,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"힘든 작업 환경으로 야근 가능, 교대 근무 가능","growth":"비철금속 제조 산업 기술 발전 기회 좋음","stability":"제조업으로 고용 안정성 매우 좋음","income":"전문 금 제련으로 상위 소득","teamwork":"제련 작업 협업 중요","solo_deep":"온도 조절, 전해 정련 작업으로 독립 작업 多","analytical":"전해 반응 분석, 온도/전류 모니터링으로 분석 매우 중요","creative":"제련 조건 최적화로 창의성 보통","execution":"용해, 전해, 융해 실행 중심","people_facing":"설비 점검 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285141388702',
  '금형다이캐스팅반장',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  60, 60, 80, 75,
  85, 55, 80, 55, 80, 90,
  'regular', 'possible', 'none', 'none',
  'college', 'none', 'none',
  0.78,
  '{"wlb":0.7,"growth":0.8,"stability":0.9,"income":0.9,"teamwork":0.95,"solo_deep":0.75,"analytical":0.95,"creative":0.75,"execution":0.9,"people_facing":0.98,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 가능, 교대 근무 가능","growth":"주조 산업 기술 발전 기회 좋음","stability":"제조업으로 고용 안정성 매우 좋음","income":"반장급으로 상위 소득","teamwork":"작업원 감독/관리로 협업 매우 중요","solo_deep":"작업 계획 수립, 품질 관리 작업으로 독립 작업 多","analytical":"주조 조건 분석, 품질 검토로 분석 매우 중요","creative":"주조 방법 최적화로 창의성 높음","execution":"작업 배치, 감독 실행 중심","people_facing":"작업원 지도/교육/면담으로 대인관계 매우 多","degree_required":"전문대졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285141717099',
  '금형다이캐스팅원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  60, 55, 80, 70,
  75, 50, 75, 50, 75, 65,
  'regular', 'possible', 'none', 'none',
  'none', 'none', 'none',
  0.76,
  '{"wlb":0.7,"growth":0.75,"stability":0.9,"income":0.85,"teamwork":0.85,"solo_deep":0.7,"analytical":0.9,"creative":0.7,"execution":0.85,"people_facing":0.85,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 가능, 교대 근무 가능","growth":"주조 산업 기술 발전 기회 좋음","stability":"제조업으로 고용 안정성 매우 좋음","income":"전문 다이캐스팅으로 상위 소득","teamwork":"주조 작업 협업 중요","solo_deep":"온도/압력 조절, 품질 검사 작업으로 독립 작업 多","analytical":"주조 조건 분석으로 분석 매우 중요","creative":"주조 최적화로 창의성 보통","execution":"주조, 검사 실행 중심","people_facing":"장비 점검 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285142064271',
  '금형주조원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  60, 55, 80, 70,
  75, 50, 75, 50, 75, 65,
  'regular', 'possible', 'none', 'none',
  'none', 'none', 'none',
  0.76,
  '{"wlb":0.7,"growth":0.75,"stability":0.9,"income":0.85,"teamwork":0.85,"solo_deep":0.7,"analytical":0.9,"creative":0.7,"execution":0.85,"people_facing":0.85,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 가능, 교대 근무 가능","growth":"주조 산업 기술 발전 기회 좋음","stability":"제조업으로 고용 안정성 매우 좋음","income":"전문 주조로 상위 소득","teamwork":"주조 작업 협업 중요","solo_deep":"금형 준비, 용탕 주입 작업으로 독립 작업 多","analytical":"주조 조건 분석으로 분석 매우 중요","creative":"주조 방법 최적화로 창의성 보통","execution":"주조, 검사 실행 중심","people_facing":"장비 점검 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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