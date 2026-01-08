-- Batch tagging SQL generated at 2026-01-06T06:44:20.706Z
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
  '1765283335492538',
  '식품가공검사원',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  50, 50, 50, 50, 50, 50,
  'regular', 'none', 'none', 'none',
  'bachelor', 'required', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 식품가공검사원은 식품의 품질을 검사하는 업무를 수행합니다.\n\n식품 샘플을 수집합니다.\n\n품질 검사를 실시합니다.\n\n안전 기준을 확인합니다.\n\n검사 결과를 기록합니다.\n\n문제 발생 ... 기반으로 50로 평가","growth":"growth는 식품가공검사원은 식품의 품질을 검사하는 업무를 수행합니다.\n\n식품 샘플을 수집합니다.\n\n품질 검사를 실시합니다.\n\n안전 기준을 확인합니다.\n\n검사 결과를 기록합니다.\n\n문제 발생 ... 기반으로 50로 평가","stability":"stability는 식품가공검사원은 식품의 품질을 검사하는 업무를 수행합니다.\n\n식품 샘플을 수집합니다.\n\n품질 검사를 실시합니다.\n\n안전 기준을 확인합니다.\n\n검사 결과를 기록합니다.\n\n문제 발생 ... 기반으로 50로 평가","income":"income는 식품가공검사원은 식품의 품질을 검사하는 업무를 수행합니다.\n\n식품 샘플을 수집합니다.\n\n품질 검사를 실시합니다.\n\n안전 기준을 확인합니다.\n\n검사 결과를 기록합니다.\n\n문제 발생 ... 기반으로 50로 평가","teamwork":"teamwork는 식품가공검사원은 식품의 품질을 검사하는 업무를 수행합니다.\n\n식품 샘플을 수집합니다.\n\n품질 검사를 실시합니다.\n\n안전 기준을 확인합니다.\n\n검사 결과를 기록합니다.\n\n문제 발생 ... 기반으로 50로 평가","solo_deep":"solo_deep는 식품가공검사원은 식품의 품질을 검사하는 업무를 수행합니다.\n\n식품 샘플을 수집합니다.\n\n품질 검사를 실시합니다.\n\n안전 기준을 확인합니다.\n\n검사 결과를 기록합니다.\n\n문제 발생 ... 기반으로 50로 평가","analytical":"analytical는 식품가공검사원은 식품의 품질을 검사하는 업무를 수행합니다.\n\n식품 샘플을 수집합니다.\n\n품질 검사를 실시합니다.\n\n안전 기준을 확인합니다.\n\n검사 결과를 기록합니다.\n\n문제 발생 ... 기반으로 50로 평가","creative":"creative는 식품가공검사원은 식품의 품질을 검사하는 업무를 수행합니다.\n\n식품 샘플을 수집합니다.\n\n품질 검사를 실시합니다.\n\n안전 기준을 확인합니다.\n\n검사 결과를 기록합니다.\n\n문제 발생 ... 기반으로 50로 평가","execution":"execution는 식품가공검사원은 식품의 품질을 검사하는 업무를 수행합니다.\n\n식품 샘플을 수집합니다.\n\n품질 검사를 실시합니다.\n\n안전 기준을 확인합니다.\n\n검사 결과를 기록합니다.\n\n문제 발생 ... 기반으로 50로 평가","people_facing":"people_facing는 식품가공검사원은 식품의 품질을 검사하는 업무를 수행합니다.\n\n식품 샘플을 수집합니다.\n\n품질 검사를 실시합니다.\n\n안전 기준을 확인합니다.\n\n검사 결과를 기록합니다.\n\n문제 발생 ... 기반으로 50로 평가","degree_required":"degree_required는 식품가공검사원은 식품의 품질을 검사하는 업무를 수행합니다.\n\n식품 샘플을 수집합니다.\n\n품질 검사를 실시합니다.\n\n안전 기준을 확인합니다.\n\n검사 결과를 기록합니다.\n\n문제 발생 ... 기반으로 bachelor로 평가","license_required":"license_required는 식품가공검사원은 식품의 품질을 검사하는 업무를 수행합니다.\n\n식품 샘플을 수집합니다.\n\n품질 검사를 실시합니다.\n\n안전 기준을 확인합니다.\n\n검사 결과를 기록합니다.\n\n문제 발생 ... 기반으로 required로 평가"}'
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
  '1765283333317899',
  '스포츠해설가',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 40,
  50, 50, 70, 40, 40, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 스포츠해설가는 스포츠 경기를 해설하는 업무를 수행합니다.\n\n경기를 분석합니다.\n\n해설을 준비합니다.\n\n방송에서 해설합니다.\n\n전술을 설명합니다.\n\n관중과 소통합니다.... 기반으로 50로 평가","growth":"growth는 스포츠해설가는 스포츠 경기를 해설하는 업무를 수행합니다.\n\n경기를 분석합니다.\n\n해설을 준비합니다.\n\n방송에서 해설합니다.\n\n전술을 설명합니다.\n\n관중과 소통합니다.... 기반으로 50로 평가","stability":"stability는 스포츠해설가는 스포츠 경기를 해설하는 업무를 수행합니다.\n\n경기를 분석합니다.\n\n해설을 준비합니다.\n\n방송에서 해설합니다.\n\n전술을 설명합니다.\n\n관중과 소통합니다.... 기반으로 50로 평가","income":"income는 스포츠해설가는 스포츠 경기를 해설하는 업무를 수행합니다.\n\n경기를 분석합니다.\n\n해설을 준비합니다.\n\n방송에서 해설합니다.\n\n전술을 설명합니다.\n\n관중과 소통합니다.... 기반으로 40로 평가","teamwork":"teamwork는 스포츠해설가는 스포츠 경기를 해설하는 업무를 수행합니다.\n\n경기를 분석합니다.\n\n해설을 준비합니다.\n\n방송에서 해설합니다.\n\n전술을 설명합니다.\n\n관중과 소통합니다.... 기반으로 50로 평가","solo_deep":"solo_deep는 스포츠해설가는 스포츠 경기를 해설하는 업무를 수행합니다.\n\n경기를 분석합니다.\n\n해설을 준비합니다.\n\n방송에서 해설합니다.\n\n전술을 설명합니다.\n\n관중과 소통합니다.... 기반으로 50로 평가","analytical":"analytical는 스포츠해설가는 스포츠 경기를 해설하는 업무를 수행합니다.\n\n경기를 분석합니다.\n\n해설을 준비합니다.\n\n방송에서 해설합니다.\n\n전술을 설명합니다.\n\n관중과 소통합니다.... 기반으로 70로 평가","creative":"creative는 스포츠해설가는 스포츠 경기를 해설하는 업무를 수행합니다.\n\n경기를 분석합니다.\n\n해설을 준비합니다.\n\n방송에서 해설합니다.\n\n전술을 설명합니다.\n\n관중과 소통합니다.... 기반으로 40로 평가","execution":"execution는 스포츠해설가는 스포츠 경기를 해설하는 업무를 수행합니다.\n\n경기를 분석합니다.\n\n해설을 준비합니다.\n\n방송에서 해설합니다.\n\n전술을 설명합니다.\n\n관중과 소통합니다.... 기반으로 40로 평가","people_facing":"people_facing는 스포츠해설가는 스포츠 경기를 해설하는 업무를 수행합니다.\n\n경기를 분석합니다.\n\n해설을 준비합니다.\n\n방송에서 해설합니다.\n\n전술을 설명합니다.\n\n관중과 소통합니다.... 기반으로 50로 평가","degree_required":"degree_required는 스포츠해설가는 스포츠 경기를 해설하는 업무를 수행합니다.\n\n경기를 분석합니다.\n\n해설을 준비합니다.\n\n방송에서 해설합니다.\n\n전술을 설명합니다.\n\n관중과 소통합니다.... 기반으로 none로 평가","license_required":"license_required는 스포츠해설가는 스포츠 경기를 해설하는 업무를 수행합니다.\n\n경기를 분석합니다.\n\n해설을 준비합니다.\n\n방송에서 해설합니다.\n\n전술을 설명합니다.\n\n관중과 소통합니다.... 기반으로 none로 평가"}'
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
  '1765283364416525',
  '재활용 처리 및 소각로 조작원',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  50, 50, 40, 40, 70, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 재활용 처리 및 소각로 조작원은 폐기물을 처리하는 업무를 수행합니다.\n\n폐기물을 분류합니다.\n\n재활용 과정을 운영합니다.\n\n소각로를 조작합니다.\n\n환경 안전을 확인합니다.\n\n장비를... 기반으로 50로 평가","growth":"growth는 재활용 처리 및 소각로 조작원은 폐기물을 처리하는 업무를 수행합니다.\n\n폐기물을 분류합니다.\n\n재활용 과정을 운영합니다.\n\n소각로를 조작합니다.\n\n환경 안전을 확인합니다.\n\n장비를... 기반으로 50로 평가","stability":"stability는 재활용 처리 및 소각로 조작원은 폐기물을 처리하는 업무를 수행합니다.\n\n폐기물을 분류합니다.\n\n재활용 과정을 운영합니다.\n\n소각로를 조작합니다.\n\n환경 안전을 확인합니다.\n\n장비를... 기반으로 50로 평가","income":"income는 재활용 처리 및 소각로 조작원은 폐기물을 처리하는 업무를 수행합니다.\n\n폐기물을 분류합니다.\n\n재활용 과정을 운영합니다.\n\n소각로를 조작합니다.\n\n환경 안전을 확인합니다.\n\n장비를... 기반으로 50로 평가","teamwork":"teamwork는 재활용 처리 및 소각로 조작원은 폐기물을 처리하는 업무를 수행합니다.\n\n폐기물을 분류합니다.\n\n재활용 과정을 운영합니다.\n\n소각로를 조작합니다.\n\n환경 안전을 확인합니다.\n\n장비를... 기반으로 50로 평가","solo_deep":"solo_deep는 재활용 처리 및 소각로 조작원은 폐기물을 처리하는 업무를 수행합니다.\n\n폐기물을 분류합니다.\n\n재활용 과정을 운영합니다.\n\n소각로를 조작합니다.\n\n환경 안전을 확인합니다.\n\n장비를... 기반으로 50로 평가","analytical":"analytical는 재활용 처리 및 소각로 조작원은 폐기물을 처리하는 업무를 수행합니다.\n\n폐기물을 분류합니다.\n\n재활용 과정을 운영합니다.\n\n소각로를 조작합니다.\n\n환경 안전을 확인합니다.\n\n장비를... 기반으로 40로 평가","creative":"creative는 재활용 처리 및 소각로 조작원은 폐기물을 처리하는 업무를 수행합니다.\n\n폐기물을 분류합니다.\n\n재활용 과정을 운영합니다.\n\n소각로를 조작합니다.\n\n환경 안전을 확인합니다.\n\n장비를... 기반으로 40로 평가","execution":"execution는 재활용 처리 및 소각로 조작원은 폐기물을 처리하는 업무를 수행합니다.\n\n폐기물을 분류합니다.\n\n재활용 과정을 운영합니다.\n\n소각로를 조작합니다.\n\n환경 안전을 확인합니다.\n\n장비를... 기반으로 70로 평가","people_facing":"people_facing는 재활용 처리 및 소각로 조작원은 폐기물을 처리하는 업무를 수행합니다.\n\n폐기물을 분류합니다.\n\n재활용 과정을 운영합니다.\n\n소각로를 조작합니다.\n\n환경 안전을 확인합니다.\n\n장비를... 기반으로 50로 평가","degree_required":"degree_required는 재활용 처리 및 소각로 조작원은 폐기물을 처리하는 업무를 수행합니다.\n\n폐기물을 분류합니다.\n\n재활용 과정을 운영합니다.\n\n소각로를 조작합니다.\n\n환경 안전을 확인합니다.\n\n장비를... 기반으로 none로 평가","license_required":"license_required는 재활용 처리 및 소각로 조작원은 폐기물을 처리하는 업무를 수행합니다.\n\n폐기물을 분류합니다.\n\n재활용 과정을 운영합니다.\n\n소각로를 조작합니다.\n\n환경 안전을 확인합니다.\n\n장비를... 기반으로 none로 평가"}'
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
  '1765283294732750',
  '네이미스트',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  50, 50, 60, 30, 60, 75,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 네이미스트는 메이크업과 헤어스타일을 하는 업무를 수행합니다.\n\n고객의 얼굴을 분석합니다.\n\n메이크업을 합니다.\n\n헤어스타일을 연출합니다.\n\n도구를 준비합니다.\n\n피부 관리를 합니다... 기반으로 50로 평가","growth":"growth는 네이미스트는 메이크업과 헤어스타일을 하는 업무를 수행합니다.\n\n고객의 얼굴을 분석합니다.\n\n메이크업을 합니다.\n\n헤어스타일을 연출합니다.\n\n도구를 준비합니다.\n\n피부 관리를 합니다... 기반으로 50로 평가","stability":"stability는 네이미스트는 메이크업과 헤어스타일을 하는 업무를 수행합니다.\n\n고객의 얼굴을 분석합니다.\n\n메이크업을 합니다.\n\n헤어스타일을 연출합니다.\n\n도구를 준비합니다.\n\n피부 관리를 합니다... 기반으로 50로 평가","income":"income는 네이미스트는 메이크업과 헤어스타일을 하는 업무를 수행합니다.\n\n고객의 얼굴을 분석합니다.\n\n메이크업을 합니다.\n\n헤어스타일을 연출합니다.\n\n도구를 준비합니다.\n\n피부 관리를 합니다... 기반으로 50로 평가","teamwork":"teamwork는 네이미스트는 메이크업과 헤어스타일을 하는 업무를 수행합니다.\n\n고객의 얼굴을 분석합니다.\n\n메이크업을 합니다.\n\n헤어스타일을 연출합니다.\n\n도구를 준비합니다.\n\n피부 관리를 합니다... 기반으로 50로 평가","solo_deep":"solo_deep는 네이미스트는 메이크업과 헤어스타일을 하는 업무를 수행합니다.\n\n고객의 얼굴을 분석합니다.\n\n메이크업을 합니다.\n\n헤어스타일을 연출합니다.\n\n도구를 준비합니다.\n\n피부 관리를 합니다... 기반으로 50로 평가","analytical":"analytical는 네이미스트는 메이크업과 헤어스타일을 하는 업무를 수행합니다.\n\n고객의 얼굴을 분석합니다.\n\n메이크업을 합니다.\n\n헤어스타일을 연출합니다.\n\n도구를 준비합니다.\n\n피부 관리를 합니다... 기반으로 60로 평가","creative":"creative는 네이미스트는 메이크업과 헤어스타일을 하는 업무를 수행합니다.\n\n고객의 얼굴을 분석합니다.\n\n메이크업을 합니다.\n\n헤어스타일을 연출합니다.\n\n도구를 준비합니다.\n\n피부 관리를 합니다... 기반으로 30로 평가","execution":"execution는 네이미스트는 메이크업과 헤어스타일을 하는 업무를 수행합니다.\n\n고객의 얼굴을 분석합니다.\n\n메이크업을 합니다.\n\n헤어스타일을 연출합니다.\n\n도구를 준비합니다.\n\n피부 관리를 합니다... 기반으로 60로 평가","people_facing":"people_facing는 네이미스트는 메이크업과 헤어스타일을 하는 업무를 수행합니다.\n\n고객의 얼굴을 분석합니다.\n\n메이크업을 합니다.\n\n헤어스타일을 연출합니다.\n\n도구를 준비합니다.\n\n피부 관리를 합니다... 기반으로 75로 평가","degree_required":"degree_required는 네이미스트는 메이크업과 헤어스타일을 하는 업무를 수행합니다.\n\n고객의 얼굴을 분석합니다.\n\n메이크업을 합니다.\n\n헤어스타일을 연출합니다.\n\n도구를 준비합니다.\n\n피부 관리를 합니다... 기반으로 none로 평가","license_required":"license_required는 네이미스트는 메이크업과 헤어스타일을 하는 업무를 수행합니다.\n\n고객의 얼굴을 분석합니다.\n\n메이크업을 합니다.\n\n헤어스타일을 연출합니다.\n\n도구를 준비합니다.\n\n피부 관리를 합니다... 기반으로 none로 평가"}'
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
  '176528333850062',
  '악기수리원 및 조율사',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 40,
  50, 50, 40, 40, 70, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 악기수리원 및 조율사는 악기를 수리하고 조율하는 업무를 수행합니다.\n\n악기의 상태를 진단합니다.\n\n수리 작업을 합니다.\n\n조율을 실시합니다.\n\n부품을 교체합니다.\n\n음질을 테스트합... 기반으로 50로 평가","growth":"growth는 악기수리원 및 조율사는 악기를 수리하고 조율하는 업무를 수행합니다.\n\n악기의 상태를 진단합니다.\n\n수리 작업을 합니다.\n\n조율을 실시합니다.\n\n부품을 교체합니다.\n\n음질을 테스트합... 기반으로 50로 평가","stability":"stability는 악기수리원 및 조율사는 악기를 수리하고 조율하는 업무를 수행합니다.\n\n악기의 상태를 진단합니다.\n\n수리 작업을 합니다.\n\n조율을 실시합니다.\n\n부품을 교체합니다.\n\n음질을 테스트합... 기반으로 50로 평가","income":"income는 악기수리원 및 조율사는 악기를 수리하고 조율하는 업무를 수행합니다.\n\n악기의 상태를 진단합니다.\n\n수리 작업을 합니다.\n\n조율을 실시합니다.\n\n부품을 교체합니다.\n\n음질을 테스트합... 기반으로 40로 평가","teamwork":"teamwork는 악기수리원 및 조율사는 악기를 수리하고 조율하는 업무를 수행합니다.\n\n악기의 상태를 진단합니다.\n\n수리 작업을 합니다.\n\n조율을 실시합니다.\n\n부품을 교체합니다.\n\n음질을 테스트합... 기반으로 50로 평가","solo_deep":"solo_deep는 악기수리원 및 조율사는 악기를 수리하고 조율하는 업무를 수행합니다.\n\n악기의 상태를 진단합니다.\n\n수리 작업을 합니다.\n\n조율을 실시합니다.\n\n부품을 교체합니다.\n\n음질을 테스트합... 기반으로 50로 평가","analytical":"analytical는 악기수리원 및 조율사는 악기를 수리하고 조율하는 업무를 수행합니다.\n\n악기의 상태를 진단합니다.\n\n수리 작업을 합니다.\n\n조율을 실시합니다.\n\n부품을 교체합니다.\n\n음질을 테스트합... 기반으로 40로 평가","creative":"creative는 악기수리원 및 조율사는 악기를 수리하고 조율하는 업무를 수행합니다.\n\n악기의 상태를 진단합니다.\n\n수리 작업을 합니다.\n\n조율을 실시합니다.\n\n부품을 교체합니다.\n\n음질을 테스트합... 기반으로 40로 평가","execution":"execution는 악기수리원 및 조율사는 악기를 수리하고 조율하는 업무를 수행합니다.\n\n악기의 상태를 진단합니다.\n\n수리 작업을 합니다.\n\n조율을 실시합니다.\n\n부품을 교체합니다.\n\n음질을 테스트합... 기반으로 70로 평가","people_facing":"people_facing는 악기수리원 및 조율사는 악기를 수리하고 조율하는 업무를 수행합니다.\n\n악기의 상태를 진단합니다.\n\n수리 작업을 합니다.\n\n조율을 실시합니다.\n\n부품을 교체합니다.\n\n음질을 테스트합... 기반으로 50로 평가","degree_required":"degree_required는 악기수리원 및 조율사는 악기를 수리하고 조율하는 업무를 수행합니다.\n\n악기의 상태를 진단합니다.\n\n수리 작업을 합니다.\n\n조율을 실시합니다.\n\n부품을 교체합니다.\n\n음질을 테스트합... 기반으로 none로 평가","license_required":"license_required는 악기수리원 및 조율사는 악기를 수리하고 조율하는 업무를 수행합니다.\n\n악기의 상태를 진단합니다.\n\n수리 작업을 합니다.\n\n조율을 실시합니다.\n\n부품을 교체합니다.\n\n음질을 테스트합... 기반으로 none로 평가"}'
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
  '1765283399047550',
  '해부학연구원',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 50, 70,
  50, 50, 70, 40, 40, 35,
  'regular', 'none', 'none', 'none',
  'master', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 해부학연구원은 인체 구조를 연구하는 업무를 수행합니다.\n\n해부학적 연구를 수행합니다.\n\n조직 샘플을 분석합니다.\n\n연구 데이터를 수집합니다.\n\n연구 결과를 발표합니다.\n\n의학 발전... 기반으로 50로 평가","growth":"growth는 해부학연구원은 인체 구조를 연구하는 업무를 수행합니다.\n\n해부학적 연구를 수행합니다.\n\n조직 샘플을 분석합니다.\n\n연구 데이터를 수집합니다.\n\n연구 결과를 발표합니다.\n\n의학 발전... 기반으로 65로 평가","stability":"stability는 해부학연구원은 인체 구조를 연구하는 업무를 수행합니다.\n\n해부학적 연구를 수행합니다.\n\n조직 샘플을 분석합니다.\n\n연구 데이터를 수집합니다.\n\n연구 결과를 발표합니다.\n\n의학 발전... 기반으로 50로 평가","income":"income는 해부학연구원은 인체 구조를 연구하는 업무를 수행합니다.\n\n해부학적 연구를 수행합니다.\n\n조직 샘플을 분석합니다.\n\n연구 데이터를 수집합니다.\n\n연구 결과를 발표합니다.\n\n의학 발전... 기반으로 70로 평가","teamwork":"teamwork는 해부학연구원은 인체 구조를 연구하는 업무를 수행합니다.\n\n해부학적 연구를 수행합니다.\n\n조직 샘플을 분석합니다.\n\n연구 데이터를 수집합니다.\n\n연구 결과를 발표합니다.\n\n의학 발전... 기반으로 50로 평가","solo_deep":"solo_deep는 해부학연구원은 인체 구조를 연구하는 업무를 수행합니다.\n\n해부학적 연구를 수행합니다.\n\n조직 샘플을 분석합니다.\n\n연구 데이터를 수집합니다.\n\n연구 결과를 발표합니다.\n\n의학 발전... 기반으로 50로 평가","analytical":"analytical는 해부학연구원은 인체 구조를 연구하는 업무를 수행합니다.\n\n해부학적 연구를 수행합니다.\n\n조직 샘플을 분석합니다.\n\n연구 데이터를 수집합니다.\n\n연구 결과를 발표합니다.\n\n의학 발전... 기반으로 70로 평가","creative":"creative는 해부학연구원은 인체 구조를 연구하는 업무를 수행합니다.\n\n해부학적 연구를 수행합니다.\n\n조직 샘플을 분석합니다.\n\n연구 데이터를 수집합니다.\n\n연구 결과를 발표합니다.\n\n의학 발전... 기반으로 40로 평가","execution":"execution는 해부학연구원은 인체 구조를 연구하는 업무를 수행합니다.\n\n해부학적 연구를 수행합니다.\n\n조직 샘플을 분석합니다.\n\n연구 데이터를 수집합니다.\n\n연구 결과를 발표합니다.\n\n의학 발전... 기반으로 40로 평가","people_facing":"people_facing는 해부학연구원은 인체 구조를 연구하는 업무를 수행합니다.\n\n해부학적 연구를 수행합니다.\n\n조직 샘플을 분석합니다.\n\n연구 데이터를 수집합니다.\n\n연구 결과를 발표합니다.\n\n의학 발전... 기반으로 35로 평가","degree_required":"degree_required는 해부학연구원은 인체 구조를 연구하는 업무를 수행합니다.\n\n해부학적 연구를 수행합니다.\n\n조직 샘플을 분석합니다.\n\n연구 데이터를 수집합니다.\n\n연구 결과를 발표합니다.\n\n의학 발전... 기반으로 master로 평가","license_required":"license_required는 해부학연구원은 인체 구조를 연구하는 업무를 수행합니다.\n\n해부학적 연구를 수행합니다.\n\n조직 샘플을 분석합니다.\n\n연구 데이터를 수집합니다.\n\n연구 결과를 발표합니다.\n\n의학 발전... 기반으로 none로 평가"}'
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
  '1765283395572810',
  '프로바둑기사',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 75, 50, 40,
  50, 50, 70, 40, 40, 35,
  'regular', 'none', 'none', 'none',
  'college', 'preferred', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 프로바둑기사는 바둑 경기에 참가하는 업무를 수행합니다.\n\n바둑 실력을 향상시킵니다.\n\n대국을 준비합니다.\n\n경기에 참가합니다.\n\n전략을 연구합니다.\n\n교육 활동을 합니다.... 기반으로 50로 평가","growth":"growth는 프로바둑기사는 바둑 경기에 참가하는 업무를 수행합니다.\n\n바둑 실력을 향상시킵니다.\n\n대국을 준비합니다.\n\n경기에 참가합니다.\n\n전략을 연구합니다.\n\n교육 활동을 합니다.... 기반으로 75로 평가","stability":"stability는 프로바둑기사는 바둑 경기에 참가하는 업무를 수행합니다.\n\n바둑 실력을 향상시킵니다.\n\n대국을 준비합니다.\n\n경기에 참가합니다.\n\n전략을 연구합니다.\n\n교육 활동을 합니다.... 기반으로 50로 평가","income":"income는 프로바둑기사는 바둑 경기에 참가하는 업무를 수행합니다.\n\n바둑 실력을 향상시킵니다.\n\n대국을 준비합니다.\n\n경기에 참가합니다.\n\n전략을 연구합니다.\n\n교육 활동을 합니다.... 기반으로 40로 평가","teamwork":"teamwork는 프로바둑기사는 바둑 경기에 참가하는 업무를 수행합니다.\n\n바둑 실력을 향상시킵니다.\n\n대국을 준비합니다.\n\n경기에 참가합니다.\n\n전략을 연구합니다.\n\n교육 활동을 합니다.... 기반으로 50로 평가","solo_deep":"solo_deep는 프로바둑기사는 바둑 경기에 참가하는 업무를 수행합니다.\n\n바둑 실력을 향상시킵니다.\n\n대국을 준비합니다.\n\n경기에 참가합니다.\n\n전략을 연구합니다.\n\n교육 활동을 합니다.... 기반으로 50로 평가","analytical":"analytical는 프로바둑기사는 바둑 경기에 참가하는 업무를 수행합니다.\n\n바둑 실력을 향상시킵니다.\n\n대국을 준비합니다.\n\n경기에 참가합니다.\n\n전략을 연구합니다.\n\n교육 활동을 합니다.... 기반으로 70로 평가","creative":"creative는 프로바둑기사는 바둑 경기에 참가하는 업무를 수행합니다.\n\n바둑 실력을 향상시킵니다.\n\n대국을 준비합니다.\n\n경기에 참가합니다.\n\n전략을 연구합니다.\n\n교육 활동을 합니다.... 기반으로 40로 평가","execution":"execution는 프로바둑기사는 바둑 경기에 참가하는 업무를 수행합니다.\n\n바둑 실력을 향상시킵니다.\n\n대국을 준비합니다.\n\n경기에 참가합니다.\n\n전략을 연구합니다.\n\n교육 활동을 합니다.... 기반으로 40로 평가","people_facing":"people_facing는 프로바둑기사는 바둑 경기에 참가하는 업무를 수행합니다.\n\n바둑 실력을 향상시킵니다.\n\n대국을 준비합니다.\n\n경기에 참가합니다.\n\n전략을 연구합니다.\n\n교육 활동을 합니다.... 기반으로 35로 평가","degree_required":"degree_required는 프로바둑기사는 바둑 경기에 참가하는 업무를 수행합니다.\n\n바둑 실력을 향상시킵니다.\n\n대국을 준비합니다.\n\n경기에 참가합니다.\n\n전략을 연구합니다.\n\n교육 활동을 합니다.... 기반으로 college로 평가","license_required":"license_required는 프로바둑기사는 바둑 경기에 참가하는 업무를 수행합니다.\n\n바둑 실력을 향상시킵니다.\n\n대국을 준비합니다.\n\n경기에 참가합니다.\n\n전략을 연구합니다.\n\n교육 활동을 합니다.... 기반으로 preferred로 평가"}'
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
  '1765283339629658',
  '안무가',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 40,
  50, 50, 60, 60, 30, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 안무가는 춤 동작을 창작하는 업무를 수행합니다.\n\n음악을 분석합니다.\n\n춤 동작을 디자인합니다.\n\n안무를 구성합니다.\n\n무용수를 지도합니다.\n\n공연을 감독합니다.... 기반으로 50로 평가","growth":"growth는 안무가는 춤 동작을 창작하는 업무를 수행합니다.\n\n음악을 분석합니다.\n\n춤 동작을 디자인합니다.\n\n안무를 구성합니다.\n\n무용수를 지도합니다.\n\n공연을 감독합니다.... 기반으로 50로 평가","stability":"stability는 안무가는 춤 동작을 창작하는 업무를 수행합니다.\n\n음악을 분석합니다.\n\n춤 동작을 디자인합니다.\n\n안무를 구성합니다.\n\n무용수를 지도합니다.\n\n공연을 감독합니다.... 기반으로 50로 평가","income":"income는 안무가는 춤 동작을 창작하는 업무를 수행합니다.\n\n음악을 분석합니다.\n\n춤 동작을 디자인합니다.\n\n안무를 구성합니다.\n\n무용수를 지도합니다.\n\n공연을 감독합니다.... 기반으로 40로 평가","teamwork":"teamwork는 안무가는 춤 동작을 창작하는 업무를 수행합니다.\n\n음악을 분석합니다.\n\n춤 동작을 디자인합니다.\n\n안무를 구성합니다.\n\n무용수를 지도합니다.\n\n공연을 감독합니다.... 기반으로 50로 평가","solo_deep":"solo_deep는 안무가는 춤 동작을 창작하는 업무를 수행합니다.\n\n음악을 분석합니다.\n\n춤 동작을 디자인합니다.\n\n안무를 구성합니다.\n\n무용수를 지도합니다.\n\n공연을 감독합니다.... 기반으로 50로 평가","analytical":"analytical는 안무가는 춤 동작을 창작하는 업무를 수행합니다.\n\n음악을 분석합니다.\n\n춤 동작을 디자인합니다.\n\n안무를 구성합니다.\n\n무용수를 지도합니다.\n\n공연을 감독합니다.... 기반으로 60로 평가","creative":"creative는 안무가는 춤 동작을 창작하는 업무를 수행합니다.\n\n음악을 분석합니다.\n\n춤 동작을 디자인합니다.\n\n안무를 구성합니다.\n\n무용수를 지도합니다.\n\n공연을 감독합니다.... 기반으로 60로 평가","execution":"execution는 안무가는 춤 동작을 창작하는 업무를 수행합니다.\n\n음악을 분석합니다.\n\n춤 동작을 디자인합니다.\n\n안무를 구성합니다.\n\n무용수를 지도합니다.\n\n공연을 감독합니다.... 기반으로 30로 평가","people_facing":"people_facing는 안무가는 춤 동작을 창작하는 업무를 수행합니다.\n\n음악을 분석합니다.\n\n춤 동작을 디자인합니다.\n\n안무를 구성합니다.\n\n무용수를 지도합니다.\n\n공연을 감독합니다.... 기반으로 50로 평가","degree_required":"degree_required는 안무가는 춤 동작을 창작하는 업무를 수행합니다.\n\n음악을 분석합니다.\n\n춤 동작을 디자인합니다.\n\n안무를 구성합니다.\n\n무용수를 지도합니다.\n\n공연을 감독합니다.... 기반으로 none로 평가","license_required":"license_required는 안무가는 춤 동작을 창작하는 업무를 수행합니다.\n\n음악을 분석합니다.\n\n춤 동작을 디자인합니다.\n\n안무를 구성합니다.\n\n무용수를 지도합니다.\n\n공연을 감독합니다.... 기반으로 none로 평가"}'
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
  '1765283329795669',
  '소설가',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 50, 40,
  50, 50, 40, 70, 40, 35,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 소설가는 소설을 쓰는 업무를 수행합니다.\n\n스토리를 기획합니다.\n\n등장인물을 개발합니다.\n\n줄거리를 구성합니다.\n\n원고를 작성합니다.\n\n출판 과정을 담당합니다.... 기반으로 50로 평가","growth":"growth는 소설가는 소설을 쓰는 업무를 수행합니다.\n\n스토리를 기획합니다.\n\n등장인물을 개발합니다.\n\n줄거리를 구성합니다.\n\n원고를 작성합니다.\n\n출판 과정을 담당합니다.... 기반으로 65로 평가","stability":"stability는 소설가는 소설을 쓰는 업무를 수행합니다.\n\n스토리를 기획합니다.\n\n등장인물을 개발합니다.\n\n줄거리를 구성합니다.\n\n원고를 작성합니다.\n\n출판 과정을 담당합니다.... 기반으로 50로 평가","income":"income는 소설가는 소설을 쓰는 업무를 수행합니다.\n\n스토리를 기획합니다.\n\n등장인물을 개발합니다.\n\n줄거리를 구성합니다.\n\n원고를 작성합니다.\n\n출판 과정을 담당합니다.... 기반으로 40로 평가","teamwork":"teamwork는 소설가는 소설을 쓰는 업무를 수행합니다.\n\n스토리를 기획합니다.\n\n등장인물을 개발합니다.\n\n줄거리를 구성합니다.\n\n원고를 작성합니다.\n\n출판 과정을 담당합니다.... 기반으로 50로 평가","solo_deep":"solo_deep는 소설가는 소설을 쓰는 업무를 수행합니다.\n\n스토리를 기획합니다.\n\n등장인물을 개발합니다.\n\n줄거리를 구성합니다.\n\n원고를 작성합니다.\n\n출판 과정을 담당합니다.... 기반으로 50로 평가","analytical":"analytical는 소설가는 소설을 쓰는 업무를 수행합니다.\n\n스토리를 기획합니다.\n\n등장인물을 개발합니다.\n\n줄거리를 구성합니다.\n\n원고를 작성합니다.\n\n출판 과정을 담당합니다.... 기반으로 40로 평가","creative":"creative는 소설가는 소설을 쓰는 업무를 수행합니다.\n\n스토리를 기획합니다.\n\n등장인물을 개발합니다.\n\n줄거리를 구성합니다.\n\n원고를 작성합니다.\n\n출판 과정을 담당합니다.... 기반으로 70로 평가","execution":"execution는 소설가는 소설을 쓰는 업무를 수행합니다.\n\n스토리를 기획합니다.\n\n등장인물을 개발합니다.\n\n줄거리를 구성합니다.\n\n원고를 작성합니다.\n\n출판 과정을 담당합니다.... 기반으로 40로 평가","people_facing":"people_facing는 소설가는 소설을 쓰는 업무를 수행합니다.\n\n스토리를 기획합니다.\n\n등장인물을 개발합니다.\n\n줄거리를 구성합니다.\n\n원고를 작성합니다.\n\n출판 과정을 담당합니다.... 기반으로 35로 평가","degree_required":"degree_required는 소설가는 소설을 쓰는 업무를 수행합니다.\n\n스토리를 기획합니다.\n\n등장인물을 개발합니다.\n\n줄거리를 구성합니다.\n\n원고를 작성합니다.\n\n출판 과정을 담당합니다.... 기반으로 none로 평가","license_required":"license_required는 소설가는 소설을 쓰는 업무를 수행합니다.\n\n스토리를 기획합니다.\n\n등장인물을 개발합니다.\n\n줄거리를 구성합니다.\n\n원고를 작성합니다.\n\n출판 과정을 담당합니다.... 기반으로 none로 평가"}'
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
  '1765283389104338',
  '토양환경기술자',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  50, 50, 70, 40, 40, 50,
  'regular', 'none', 'none', 'none',
  'bachelor', 'preferred', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 토양환경기술자는 토양 환경을 조사하고 개선하는 업무를 수행합니다.\n\n토양 샘플을 수집합니다.\n\n토양 성분을 분석합니다.\n\n환경 오염을 평가합니다.\n\n개선 방법을 제안합니다.\n\n모니... 기반으로 50로 평가","growth":"growth는 토양환경기술자는 토양 환경을 조사하고 개선하는 업무를 수행합니다.\n\n토양 샘플을 수집합니다.\n\n토양 성분을 분석합니다.\n\n환경 오염을 평가합니다.\n\n개선 방법을 제안합니다.\n\n모니... 기반으로 50로 평가","stability":"stability는 토양환경기술자는 토양 환경을 조사하고 개선하는 업무를 수행합니다.\n\n토양 샘플을 수집합니다.\n\n토양 성분을 분석합니다.\n\n환경 오염을 평가합니다.\n\n개선 방법을 제안합니다.\n\n모니... 기반으로 50로 평가","income":"income는 토양환경기술자는 토양 환경을 조사하고 개선하는 업무를 수행합니다.\n\n토양 샘플을 수집합니다.\n\n토양 성분을 분석합니다.\n\n환경 오염을 평가합니다.\n\n개선 방법을 제안합니다.\n\n모니... 기반으로 50로 평가","teamwork":"teamwork는 토양환경기술자는 토양 환경을 조사하고 개선하는 업무를 수행합니다.\n\n토양 샘플을 수집합니다.\n\n토양 성분을 분석합니다.\n\n환경 오염을 평가합니다.\n\n개선 방법을 제안합니다.\n\n모니... 기반으로 50로 평가","solo_deep":"solo_deep는 토양환경기술자는 토양 환경을 조사하고 개선하는 업무를 수행합니다.\n\n토양 샘플을 수집합니다.\n\n토양 성분을 분석합니다.\n\n환경 오염을 평가합니다.\n\n개선 방법을 제안합니다.\n\n모니... 기반으로 50로 평가","analytical":"analytical는 토양환경기술자는 토양 환경을 조사하고 개선하는 업무를 수행합니다.\n\n토양 샘플을 수집합니다.\n\n토양 성분을 분석합니다.\n\n환경 오염을 평가합니다.\n\n개선 방법을 제안합니다.\n\n모니... 기반으로 70로 평가","creative":"creative는 토양환경기술자는 토양 환경을 조사하고 개선하는 업무를 수행합니다.\n\n토양 샘플을 수집합니다.\n\n토양 성분을 분석합니다.\n\n환경 오염을 평가합니다.\n\n개선 방법을 제안합니다.\n\n모니... 기반으로 40로 평가","execution":"execution는 토양환경기술자는 토양 환경을 조사하고 개선하는 업무를 수행합니다.\n\n토양 샘플을 수집합니다.\n\n토양 성분을 분석합니다.\n\n환경 오염을 평가합니다.\n\n개선 방법을 제안합니다.\n\n모니... 기반으로 40로 평가","people_facing":"people_facing는 토양환경기술자는 토양 환경을 조사하고 개선하는 업무를 수행합니다.\n\n토양 샘플을 수집합니다.\n\n토양 성분을 분석합니다.\n\n환경 오염을 평가합니다.\n\n개선 방법을 제안합니다.\n\n모니... 기반으로 50로 평가","degree_required":"degree_required는 토양환경기술자는 토양 환경을 조사하고 개선하는 업무를 수행합니다.\n\n토양 샘플을 수집합니다.\n\n토양 성분을 분석합니다.\n\n환경 오염을 평가합니다.\n\n개선 방법을 제안합니다.\n\n모니... 기반으로 bachelor로 평가","license_required":"license_required는 토양환경기술자는 토양 환경을 조사하고 개선하는 업무를 수행합니다.\n\n토양 샘플을 수집합니다.\n\n토양 성분을 분석합니다.\n\n환경 오염을 평가합니다.\n\n개선 방법을 제안합니다.\n\n모니... 기반으로 preferred로 평가"}'
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