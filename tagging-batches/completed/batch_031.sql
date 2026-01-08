-- Batch tagging SQL generated at 2026-01-06T08:21:59.491Z
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
  '1765284504748213',
  '가방판매원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 40, 70, 40,
  60, 40, 50, 50, 80, 85,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'entry',
  0.86,
  '{"wlb":0.8,"growth":0.6,"stability":0.8,"income":0.6,"teamwork":0.7,"solo_deep":0.6,"analytical":0.7,"creative":0.7,"execution":0.9,"people_facing":0.9,"degree_required":0.95,"license_required":0.9}',
  '{"wlb":"상점 업무로 정규 근무","growth":"판매 기술로 성장 기회 있음","stability":"소매업으로 비교적 안정적","income":"판매 수수료로 중간 수준 소득","teamwork":"상점 운영으로 협업 필요","solo_deep":"진열, 재고 관리로 독립 작업","analytical":"재고, 매출 파악으로 분석 요구","creative":"고객 취향 맞춰 추천으로 창의성 요구","execution":"판매, 계산 실행 중심","people_facing":"고객 상담, 추천으로 대면 업무 매우 多","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 요구 없음"}'
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
  '176528450521968',
  '가전제품판매원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 45, 70, 45,
  60, 40, 55, 45, 80, 85,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'entry',
  0.85,
  '{"wlb":0.8,"growth":0.6,"stability":0.8,"income":0.6,"teamwork":0.7,"solo_deep":0.6,"analytical":0.7,"creative":0.6,"execution":0.9,"people_facing":0.9,"degree_required":0.95,"license_required":0.9}',
  '{"wlb":"상점 업무로 정규 근무","growth":"제품 지식 습득으로 성장 기회 있음","stability":"가전 판매업으로 비교적 안정적","income":"판매 수수료로 중간 수준 소득","teamwork":"상점 운영으로 협업 필요","solo_deep":"재고 관리, 설치로 독립 작업","analytical":"재고, 판매 파악으로 분석 요구","creative":"제품 추천으로 창의성 요구","execution":"판매, 설치 실행 중심","people_facing":"고객 상담, 제품 설명으로 대면 업무 매우 多","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 요구 없음"}'
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
  '1765284505719645',
  '건강코디네이터',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 55, 75, 50,
  65, 35, 75, 55, 75, 90,
  'regular', 'none', 'none', 'none',
  'college', 'none', 'none',
  0.83,
  '{"wlb":0.8,"growth":0.7,"stability":0.85,"income":0.6,"teamwork":0.8,"solo_deep":0.5,"analytical":0.85,"creative":0.7,"execution":0.8,"people_facing":0.95,"degree_required":0.9,"license_required":0.8}',
  '{"wlb":"약국 업무로 정규 근무","growth":"건강 상담 전문성 향상 기회 좋음","stability":"의료 관련 업무로 안정적","income":"전문 상담으로 중상위 소득","teamwork":"약국 운영으로 협업 필요","solo_deep":"고객 분석, 프로그램 수립으로 독립 작업","analytical":"건강 상태 분석, 식습관 평가로 분석 중심","creative":"개별화 건강 프로그램 개발로 창의성 높음","execution":"상담, 추천 실행 중심","people_facing":"고객 상담, 건강 안내로 대면 업무 매우 多","degree_required":"전문대졸 정도 학력 요구","license_required":"특별 자격증 요구 없음"}'
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
  '1765284506214663',
  '곡물판매원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 35, 75, 35,
  55, 45, 45, 30, 80, 80,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'entry',
  0.87,
  '{"wlb":0.8,"growth":0.5,"stability":0.85,"income":0.5,"teamwork":0.6,"solo_deep":0.7,"analytical":0.6,"creative":0.5,"execution":0.9,"people_facing":0.9,"degree_required":0.95,"license_required":0.9}',
  '{"wlb":"상점 업무로 정규 근무","growth":"곡물 품질 관리로 성장 기회 제한적","stability":"식료품 판매업으로 안정적","income":"판매 수수료로 중간 수준 소득","teamwork":"상점 운영으로 협업 적음","solo_deep":"재고 관리, 품질 확인으로 독립 작업 多","analytical":"재고, 품질 파악으로 분석 요구","creative":"상품 추천으로 일부 창의성","execution":"판매, 계량 실행 중심","people_facing":"고객 상담, 추천으로 대면 업무 매우 多","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 요구 없음"}'
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
  '1765284506682726',
  '골동품판매원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 50, 65, 45,
  55, 45, 65, 55, 75, 85,
  'regular', 'none', 'none', 'none',
  'college', 'none', 'none',
  0.82,
  '{"wlb":0.8,"growth":0.7,"stability":0.75,"income":0.6,"teamwork":0.6,"solo_deep":0.7,"analytical":0.8,"creative":0.8,"execution":0.8,"people_facing":0.9,"degree_required":0.9,"license_required":0.8}',
  '{"wlb":"상점 업무로 정규 근무","growth":"예술품 지식 습득으로 성장 기회 좋음","stability":"예술품 판매업으로 비교적 안정적","income":"판매 수수료로 중간 수준 소득","teamwork":"상점 운영으로 협업 적음","solo_deep":"품목 연구, 가치 평가로 독립 작업 多","analytical":"예술품 가치, 작가 분석으로 분석 요구","creative":"고객 취향 맞춰 추천으로 창의성 높음","execution":"판매, 배달 실행 중심","people_facing":"고객 상담, 설명으로 대면 업무 매우 多","degree_required":"전문대졸 정도 학력 요구","license_required":"특별 자격증 요구 없음"}'
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
  '1765284507164157',
  '귀금속판매원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 45, 75, 50,
  60, 40, 60, 50, 80, 85,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.84,
  '{"wlb":0.8,"growth":0.6,"stability":0.85,"income":0.7,"teamwork":0.7,"solo_deep":0.6,"analytical":0.7,"creative":0.7,"execution":0.9,"people_facing":0.9,"degree_required":0.95,"license_required":0.9}',
  '{"wlb":"상점 업무로 정규 근무","growth":"귀금속 지식 습득으로 성장 기회 있음","stability":"귀금속 판매업으로 안정적","income":"판매 수수료로 중상위 소득","teamwork":"상점 운영으로 협업 필요","solo_deep":"재고 관리, 시세 확인으로 독립 작업","analytical":"시세, 품질 파악으로 분석 요구","creative":"고객 취향 맞춰 추천으로 창의성 요구","execution":"판매, 포장 실행 중심","people_facing":"고객 상담, 설명으로 대면 업무 매우 多","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 요구 없음"}'
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
  '1765284507676953',
  '꽃판매원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 40, 70, 40,
  55, 45, 50, 70, 80, 85,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'entry',
  0.86,
  '{"wlb":0.8,"growth":0.6,"stability":0.8,"income":0.6,"teamwork":0.6,"solo_deep":0.7,"analytical":0.6,"creative":0.85,"execution":0.9,"people_facing":0.9,"degree_required":0.95,"license_required":0.9}',
  '{"wlb":"상점 업무로 정규 근무","growth":"꽃배열 기술 습득으로 성장 기회 있음","stability":"꽃 판매업으로 비교적 안정적","income":"판매 수수료로 중간 수준 소득","teamwork":"상점 운영으로 협업 적음","solo_deep":"꽃 관리, 배열방식 개발로 독립 작업 多","analytical":"꽃 상태, 고객 요구 파악으로 분석 요구","creative":"꽃배열 디자인으로 창의성 매우 높음","execution":"판매, 배달 실행 중심","people_facing":"고객 상담, 추천으로 대면 업무 매우 多","degree_required":"중졸 정도 학력 요구","license_required":"특별 자격증 요구 없음"}'
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
  '1765284508150704',
  '농약비료판매원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 45, 75, 40,
  55, 45, 60, 40, 80, 80,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.85,
  '{"wlb":0.8,"growth":0.6,"stability":0.85,"income":0.6,"teamwork":0.6,"solo_deep":0.7,"analytical":0.7,"creative":0.6,"execution":0.9,"people_facing":0.9,"degree_required":0.95,"license_required":0.9}',
  '{"wlb":"상점 업무로 정규 근무","growth":"농약 지식 습득으로 성장 기회 있음","stability":"농업 자재 판매로 안정적","income":"판매 수수료로 중간 수준 소득","teamwork":"상점 운영으로 협업 적음","solo_deep":"재고 관리, 사용법 설명으로 독립 작업 多","analytical":"농약 사용법, 안전기준 파악으로 분석 요구","creative":"고객별 추천으로 일부 창의성","execution":"판매, 배달 실행 중심","people_facing":"사용법 설명, 안전 안내로 대면 업무 매우 多","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 요구 없음"}'
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
  '1765284508664849',
  '도료판매원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 40, 75, 40,
  60, 40, 55, 45, 80, 80,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'entry',
  0.86,
  '{"wlb":0.8,"growth":0.6,"stability":0.85,"income":0.6,"teamwork":0.7,"solo_deep":0.6,"analytical":0.7,"creative":0.6,"execution":0.9,"people_facing":0.9,"degree_required":0.95,"license_required":0.9}',
  '{"wlb":"상점 업무로 정규 근무","growth":"도료 지식 습득으로 성장 기회 있음","stability":"건축 자재 판매로 안정적","income":"판매 수수료로 중간 수준 소득","teamwork":"상점 운영으로 협업 필요","solo_deep":"재고 관리, 색상 추천으로 독립 작업","analytical":"재고, 수요 파악으로 분석 요구","creative":"색상, 용도 추천으로 창의성 요구","execution":"판매, 납품 실행 중심","people_facing":"고객 상담, 추천으로 대면 업무 매우 多","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 요구 없음"}'
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
  '1765284509159751',
  '떡판매원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 35, 70, 35,
  55, 45, 40, 40, 80, 80,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'entry',
  0.87,
  '{"wlb":0.8,"growth":0.5,"stability":0.8,"income":0.5,"teamwork":0.6,"solo_deep":0.7,"analytical":0.6,"creative":0.6,"execution":0.9,"people_facing":0.9,"degree_required":0.95,"license_required":0.9}',
  '{"wlb":"상점 업무로 정규 근무","growth":"떡 품질 관리로 성장 기회 제한적","stability":"식료품 판매업으로 비교적 안정적","income":"판매 수수료로 중간 수준 소득","teamwork":"상점 운영으로 협업 적음","solo_deep":"재고 관리, 품질 확인으로 독립 작업 多","analytical":"재고, 품질 파악으로 분석 요구","creative":"기념일 떡 추천으로 일부 창의성","execution":"판매, 배달 실행 중심","people_facing":"고객 상담, 추천으로 대면 업무 매우 多","degree_required":"중졸 정도 학력 요구","license_required":"특별 자격증 요구 없음"}'
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