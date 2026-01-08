-- Batch tagging SQL generated at 2026-01-06T10:33:41.619Z
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
  '1765285525552877',
  '인쇄타발반장',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 55, 75, 70,
  80, 55, 75, 50, 75, 85,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.76,
  '{"wlb":0.8,"growth":0.75,"stability":0.85,"income":0.85,"teamwork":0.9,"solo_deep":0.75,"analytical":0.9,"creative":0.7,"execution":0.85,"people_facing":0.95,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적고 교대 근무 없음","growth":"종이 용기 산업 기술 발전 기회 좋음","stability":"제조업으로 고용 안정성 좋음","income":"반장급으로 상위 소득","teamwork":"작업원 감독/관리로 협업 매우 중요","solo_deep":"설비 점검, 생산 관리 작업으로 독립 작업 多","analytical":"생산 목표 달성 분석으로 분석 매우 중요","creative":"공정 최적화로 창의성 보통","execution":"작업 배치, 감독 실행 중심","people_facing":"작업원 지도/교육/안전 관리로 대인관계 매우 多","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285526052932',
  '절곡제판원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 50, 75, 65,
  70, 55, 80, 70, 75, 60,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.76,
  '{"wlb":0.8,"growth":0.7,"stability":0.85,"income":0.8,"teamwork":0.8,"solo_deep":0.75,"analytical":0.95,"creative":0.9,"execution":0.85,"people_facing":0.8,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적고 교대 근무 없음","growth":"종이 용기 산업 기술 발전 기회 보통","stability":"제조업으로 고용 안정성 좋음","income":"전문 제판으로 중위 소득","teamwork":"조작 작업 협업 요구","solo_deep":"설계도면 해석, 철선 조립 작업으로 독립 작업 多","analytical":"규격/간격 분석으로 분석 매우 중요","creative":"제판 디자인으로 창의성 매우 높음","execution":"철선 조립, 연마 실행 중심","people_facing":"작업 협업 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285526460644',
  '접착기조작원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 50, 75, 65,
  70, 50, 75, 50, 75, 60,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.75,
  '{"wlb":0.8,"growth":0.7,"stability":0.85,"income":0.8,"teamwork":0.8,"solo_deep":0.7,"analytical":0.9,"creative":0.7,"execution":0.85,"people_facing":0.8,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적고 교대 근무 없음","growth":"종이 용기 산업 기술 발전 기회 보통","stability":"제조업으로 고용 안정성 좋음","income":"전문 접착으로 중위 소득","teamwork":"조작 작업 협업 요구","solo_deep":"장치 설정, 품질 검사 작업으로 독립 작업 多","analytical":"접착 상태 분석으로 분석 매우 중요","creative":"접착 방법 최적화로 창의성 보통","execution":"접착기 조작 실행 중심","people_facing":"작업 협업 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285526920817',
  '제대기조작원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 50, 75, 65,
  70, 50, 75, 50, 75, 60,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.75,
  '{"wlb":0.8,"growth":0.7,"stability":0.85,"income":0.8,"teamwork":0.8,"solo_deep":0.7,"analytical":0.9,"creative":0.7,"execution":0.85,"people_facing":0.8,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적고 교대 근무 없음","growth":"종이 용기 산업 기술 발전 기회 보통","stability":"제조업으로 고용 안정성 좋음","income":"전문 제대기로 중위 소득","teamwork":"조작 작업 협업 요구","solo_deep":"장치 설정, 품질 검사 작업으로 독립 작업 多","analytical":"봉합 상태 분석으로 분석 매우 중요","creative":"제대 방법 최적화로 창의성 보통","execution":"제대기 조작 실행 중심","people_facing":"작업 협업 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '17652855273452',
  '제함기조작원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 45, 75, 60,
  70, 45, 65, 45, 70, 65,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.74,
  '{"wlb":0.8,"growth":0.65,"stability":0.85,"income":0.75,"teamwork":0.8,"solo_deep":0.6,"analytical":0.8,"creative":0.7,"execution":0.8,"people_facing":0.85,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적고 교대 근무 없음","growth":"종이 용기 산업 기술 발전 기회 낮음","stability":"제조업으로 고용 안정성 좋음","income":"전문 제함기로 중위 소득","teamwork":"조작 작업 협업 요구","solo_deep":"기계 세팅, 문제 해결 작업으로 독립 작업 多","analytical":"작업 상태 확인으로 분석 중요","creative":"세팅 방법 최적화로 창의성 보통","execution":"제함기 조작 실행 중심","people_facing":"작업 협업 업무","degree_required":"중졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285527900160',
  '제호설비조작원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 50, 75, 65,
  70, 50, 75, 50, 75, 60,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.75,
  '{"wlb":0.8,"growth":0.7,"stability":0.85,"income":0.8,"teamwork":0.8,"solo_deep":0.7,"analytical":0.9,"creative":0.7,"execution":0.85,"people_facing":0.8,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적고 교대 근무 없음","growth":"제지 산업 기술 발전 기회 보통","stability":"제조업으로 고용 안정성 좋음","income":"전문 제호설비로 중위 소득","teamwork":"조작 작업 협업 요구","solo_deep":"점도/온도 조절, 계기 모니터링 작업으로 독립 작업 多","analytical":"점도/온도 분석으로 분석 매우 중요","creative":"혼합 비율 최적화로 창의성 보통","execution":"설비 조작 실행 중심","people_facing":"작업 협업 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285528302203',
  '조성반장',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 60, 80, 75,
  85, 60, 80, 55, 80, 90,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.78,
  '{"wlb":0.8,"growth":0.8,"stability":0.9,"income":0.9,"teamwork":0.95,"solo_deep":0.8,"analytical":0.95,"creative":0.75,"execution":0.9,"people_facing":0.98,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적고 교대 근무 없음","growth":"제지 산업 기술 발전 기회 좋음","stability":"제조업으로 고용 안정성 매우 좋음","income":"반장급으로 상위 소득","teamwork":"작업원 감독/관리로 협업 매우 중요","solo_deep":"설비 점검, 품질 관리 작업으로 독립 작업 多","analytical":"작업 진행/품질 분석으로 분석 매우 중요","creative":"공정 최적화로 창의성 높음","execution":"작업 배치, 감독 실행 중심","people_facing":"작업원 지도/교육/안전 관리로 대인관계 매우 多","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285528750458',
  '지관제조원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 50, 75, 65,
  70, 50, 75, 50, 75, 60,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.75,
  '{"wlb":0.8,"growth":0.7,"stability":0.85,"income":0.8,"teamwork":0.8,"solo_deep":0.7,"analytical":0.9,"creative":0.7,"execution":0.85,"people_facing":0.8,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적고 교대 근무 없음","growth":"제지 산업 기술 발전 기회 보통","stability":"제조업으로 고용 안정성 좋음","income":"전문 제조로 중위 소득","teamwork":"조작 작업 협업 요구","solo_deep":"설비 설정, 품질 모니터링 작업으로 독립 작업 多","analytical":"제조 상태 분석으로 분석 매우 중요","creative":"제조 방법 최적화로 창의성 보통","execution":"제조기 조작 실행 중심","people_facing":"작업 협업 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285529198802',
  '지관제조현장감독자',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 60, 80, 75,
  85, 60, 80, 55, 80, 90,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.78,
  '{"wlb":0.8,"growth":0.8,"stability":0.9,"income":0.9,"teamwork":0.95,"solo_deep":0.8,"analytical":0.95,"creative":0.75,"execution":0.9,"people_facing":0.98,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적고 교대 근무 없음","growth":"제지 산업 기술 발전 기회 좋음","stability":"제조업으로 고용 안정성 매우 좋음","income":"현장감독급으로 상위 소득","teamwork":"작업원 감독/관리로 협업 매우 중요","solo_deep":"공정 관리, 품질 분석 작업으로 독립 작업 多","analytical":"생산 공정 분석, 품질 관리로 분석 매우 중요","creative":"공정 개선 최적화로 창의성 높음","execution":"작업 배치, 감독 실행 중심","people_facing":"작업원 지도/교육/안전 관리로 대인관계 매우 多","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285529592956',
  '지기제조원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 50, 75, 65,
  70, 50, 75, 55, 75, 60,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.75,
  '{"wlb":0.8,"growth":0.7,"stability":0.85,"income":0.8,"teamwork":0.8,"solo_deep":0.7,"analytical":0.9,"creative":0.75,"execution":0.85,"people_facing":0.8,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적고 교대 근무 없음","growth":"종이 용기 산업 기술 발전 기회 보통","stability":"제조업으로 고용 안정성 좋음","income":"전문 제조로 중위 소득","teamwork":"조작 작업 협업 요구","solo_deep":"설비 설정, 품질 모니터링 작업으로 독립 작업 多","analytical":"제조 상태 분석으로 분석 매우 중요","creative":"제조 방법 최적화로 창의성 높음","execution":"제조기 조작 실행 중심","people_facing":"작업 협업 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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