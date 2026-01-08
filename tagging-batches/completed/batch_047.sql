-- Batch tagging SQL generated at 2026-01-06T10:22:42.912Z
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
  '1765285176268531',
  '열간압연원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  60, 60, 80, 75,
  75, 55, 80, 50, 80, 65,
  'regular', 'possible', 'none', 'none',
  'college', 'none', 'none',
  0.77,
  '{"wlb":0.7,"growth":0.8,"stability":0.9,"income":0.9,"teamwork":0.85,"solo_deep":0.75,"analytical":0.95,"creative":0.7,"execution":0.9,"people_facing":0.85,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 가능, 교대 근무 가능","growth":"철강 제조 산업 기술 발전 기회 좋음","stability":"제조업으로 고용 안정성 매우 좋음","income":"전문 열간압연으로 상위 소득","teamwork":"압연 작업 협업 중요","solo_deep":"압연 조건 조절, 품질 모니터링 작업으로 독립 작업 多","analytical":"텐션 조절, 형상 제어 분석으로 분석 매우 중요","creative":"압연 최적화로 창의성 보통","execution":"압연, 냉각 실행 중심","people_facing":"장비 점검 업무","degree_required":"전문대졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285176742490',
  '열처리검사원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  65, 55, 80, 70,
  70, 60, 85, 40, 75, 65,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.77,
  '{"wlb":0.8,"growth":0.75,"stability":0.9,"income":0.85,"teamwork":0.8,"solo_deep":0.8,"analytical":0.95,"creative":0.65,"execution":0.85,"people_facing":0.85,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적고 교대 근무 없음","growth":"금속 가공 산업 기술 발전 기회 좋음","stability":"제조업으로 고용 안정성 매우 좋음","income":"전문 검사로 상위 소득","teamwork":"검사 작업 협업 중요","solo_deep":"기계적 성질 측정, 조직 검사 작업으로 독립 작업 多","analytical":"경도/조직/결함 분석으로 분석 매우 중요","creative":"검사 방법 최적화로 창의성 낮음","execution":"측정, 판정 실행 중심","people_facing":"장비 점검 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285177241793',
  '열처리반장',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  65, 60, 80, 75,
  85, 55, 75, 50, 80, 90,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.78,
  '{"wlb":0.8,"growth":0.8,"stability":0.9,"income":0.9,"teamwork":0.95,"solo_deep":0.75,"analytical":0.9,"creative":0.7,"execution":0.9,"people_facing":0.98,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"가벼운 작업 환경으로 야근 적고 교대 근무 없음","growth":"금속 가공 산업 기술 발전 기회 좋음","stability":"제조업으로 고용 안정성 매우 좋음","income":"반장급으로 상위 소득","teamwork":"작업원 감독/관리로 협업 매우 중요","solo_deep":"작업 계획 수립, 품질 관리 작업으로 독립 작업 多","analytical":"생산성 분석, 불량 요인 검토로 분석 중요","creative":"공정 최적화로 창의성 보통","execution":"작업 배치, 감독 실행 중심","people_facing":"작업원 지도/교육/면담으로 대인관계 매우 多","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285177689563',
  '열처리원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  65, 55, 80, 70,
  75, 55, 80, 50, 75, 65,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.77,
  '{"wlb":0.8,"growth":0.75,"stability":0.9,"income":0.85,"teamwork":0.85,"solo_deep":0.75,"analytical":0.95,"creative":0.7,"execution":0.85,"people_facing":0.85,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"실내외 작업으로 야근 적고 교대 근무 없음","growth":"금속 가공 산업 기술 발전 기회 좋음","stability":"제조업으로 고용 안정성 매우 좋음","income":"전문 열처리로 상위 소득","teamwork":"열처리 작업 협업 중요","solo_deep":"온도/시간 조절, 냉각 방법 선택 작업으로 독립 작업 多","analytical":"열처리 조건 분석, 경화 정도 확인으로 분석 매우 중요","creative":"열처리 방법 최적화로 창의성 보통","execution":"가열, 냉각 실행 중심","people_facing":"장비 점검 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '176528517810929',
  '용압반장',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  65, 60, 80, 75,
  85, 55, 75, 50, 80, 90,
  'regular', 'possible', 'none', 'none',
  'none', 'none', 'none',
  0.78,
  '{"wlb":0.8,"growth":0.8,"stability":0.9,"income":0.9,"teamwork":0.95,"solo_deep":0.75,"analytical":0.9,"creative":0.7,"execution":0.9,"people_facing":0.98,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적지만 교대 근무 가능","growth":"전선 제조 산업 기술 발전 기회 좋음","stability":"제조업으로 고용 안정성 매우 좋음","income":"반장급으로 상위 소득","teamwork":"작업원 감독/관리로 협업 매우 중요","solo_deep":"생산 계획 수립, 품질 확인 작업으로 독립 작업 多","analytical":"생산량 분석, 규격 확인으로 분석 중요","creative":"공정 최적화로 창의성 보통","execution":"작업 배치, 감독 실행 중심","people_facing":"작업원 지도/교육/안전 관리로 대인관계 매우 多","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285178480648',
  '인발작업원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  60, 55, 80, 70,
  75, 50, 75, 45, 75, 65,
  'regular', 'possible', 'none', 'none',
  'college', 'none', 'none',
  0.76,
  '{"wlb":0.7,"growth":0.75,"stability":0.9,"income":0.85,"teamwork":0.85,"solo_deep":0.7,"analytical":0.9,"creative":0.7,"execution":0.85,"people_facing":0.85,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 가능, 교대 근무 가능","growth":"철강 제조 산업 기술 발전 기회 좋음","stability":"제조업으로 고용 안정성 매우 좋음","income":"전문 인발로 상위 소득","teamwork":"인발 작업 협업 중요","solo_deep":"금형 선택, 작업 조건 조절 작업으로 독립 작업 多","analytical":"형상/크기 제어 분석으로 분석 매우 중요","creative":"인발 조건 최적화로 창의성 보통","execution":"인발, 교정 실행 중심","people_facing":"장비 점검 업무","degree_required":"전문대졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285178831647',
  '입내기조작원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  65, 50, 75, 60,
  65, 45, 65, 45, 70, 55,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.74,
  '{"wlb":0.8,"growth":0.7,"stability":0.85,"income":0.75,"teamwork":0.8,"solo_deep":0.6,"analytical":0.8,"creative":0.7,"execution":0.8,"people_facing":0.75,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적고 교대 근무 없음","growth":"철강 제조 산업 기술 발전 기회 보통","stability":"제조업으로 고용 안정성 좋음","income":"전문 입내기로 중위 소득","teamwork":"입내기 작업 협업 요구","solo_deep":"다이 선택, 계측 작업으로 독립 작업 多","analytical":"선단부 계측, 손상 확인으로 분석 중요","creative":"가공 방법 최적화로 창의성 보통","execution":"소성가공, 계측 실행 중심","people_facing":"작업 점검 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285179155900',
  '전기로반장',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  60, 65, 85, 80,
  85, 60, 80, 55, 85, 90,
  'regular', 'possible', 'none', 'none',
  'college', 'none', 'none',
  0.79,
  '{"wlb":0.7,"growth":0.85,"stability":0.95,"income":0.95,"teamwork":0.95,"solo_deep":0.8,"analytical":0.95,"creative":0.75,"execution":0.95,"people_facing":0.98,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 가능, 교대 근무 가능","growth":"철강 제조 산업 기술 발전 기회 좋음","stability":"제조업으로 고용 안정성 매우 좋음","income":"반장급 전기로로 상위 소득","teamwork":"작업원 감독/관리로 협업 매우 중요","solo_deep":"용해 조건 분석, 품질 관리 작업으로 독립 작업 多","analytical":"용해 조건 분석, 품질 검토로 분석 매우 중요","creative":"용해 공정 최적화로 창의성 높음","execution":"용해, 주조 실행 중심","people_facing":"작업원 지도/교육/안전 관리로 대인관계 매우 多","degree_required":"전문대졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285179484300',
  '전기로조작원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  60, 60, 80, 75,
  75, 55, 80, 50, 80, 65,
  'regular', 'possible', 'none', 'none',
  'none', 'none', 'none',
  0.77,
  '{"wlb":0.7,"growth":0.8,"stability":0.9,"income":0.9,"teamwork":0.85,"solo_deep":0.75,"analytical":0.95,"creative":0.7,"execution":0.9,"people_facing":0.85,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 가능, 교대 근무 가능","growth":"철강 제조 산업 기술 발전 기회 좋음","stability":"제조업으로 고용 안정성 매우 좋음","income":"전문 전기로로 상위 소득","teamwork":"용해 작업 협업 중요","solo_deep":"장입/가열 조절, 온도 모니터링 작업으로 독립 작업 多","analytical":"용해 상태 분석, 품질 검사로 분석 매우 중요","creative":"용해 조건 최적화로 창의성 보통","execution":"장입, 용해 실행 중심","people_facing":"장비 점검 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285179787180',
  '절단반장',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  65, 60, 80, 75,
  85, 55, 75, 50, 80, 90,
  'regular', 'possible', 'none', 'none',
  'none', 'none', 'none',
  0.78,
  '{"wlb":0.8,"growth":0.8,"stability":0.9,"income":0.9,"teamwork":0.95,"solo_deep":0.75,"analytical":0.9,"creative":0.7,"execution":0.9,"people_facing":0.98,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적지만 교대 근무 가능","growth":"금속 가공 산업 기술 발전 기회 좋음","stability":"제조업으로 고용 안정성 매우 좋음","income":"반장급으로 상위 소득","teamwork":"작업원 감독/관리로 협업 매우 중요","solo_deep":"작업 계획 수립, 품질 관리 작업으로 독립 작업 多","analytical":"생산량 분석, 품질 검토로 분석 중요","creative":"공정 최적화로 창의성 보통","execution":"작업 배치, 감독 실행 중심","people_facing":"작업원 지도/교육/면담으로 대인관계 매우 多","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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