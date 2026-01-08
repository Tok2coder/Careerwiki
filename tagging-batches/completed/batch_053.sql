-- Batch tagging SQL generated at 2026-01-06T10:31:33.296Z
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
  '1765285428599474',
  '가공삭도운전원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  65, 50, 80, 70,
  75, 50, 70, 45, 75, 70,
  'regular', 'possible', 'none', 'none',
  'none', 'none', 'none',
  0.75,
  '{"wlb":0.8,"growth":0.7,"stability":0.9,"income":0.85,"teamwork":0.85,"solo_deep":0.7,"analytical":0.85,"creative":0.7,"execution":0.85,"people_facing":0.9,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 가능, 교대 근무 가능","growth":"광산 산업 기술 발전 기회 보통","stability":"제조업으로 고용 안정성 매우 좋음","income":"전문 운전으로 상위 소득","teamwork":"운전 작업 협업 중요","solo_deep":"장비 점검, 신호 모니터링 작업으로 독립 작업 多","analytical":"장비 상태 분석으로 분석 중요","creative":"운전 방법 최적화로 창의성 보통","execution":"장비 조작, 운반 실행 중심","people_facing":"신호 교환, 협업 업무","degree_required":"중졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285429179918',
  '가구자재운반원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 45, 75, 60,
  75, 40, 60, 40, 70, 70,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.74,
  '{"wlb":0.8,"growth":0.65,"stability":0.85,"income":0.75,"teamwork":0.85,"solo_deep":0.6,"analytical":0.8,"creative":0.65,"execution":0.8,"people_facing":0.9,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"가벼운 작업 강도로 야근 적고 교대 근무 없음","growth":"가구 산업 기술 발전 기회 낮음","stability":"제조업으로 고용 안정성 좋음","income":"전문 운반으로 중위 소득","teamwork":"운반 작업 협업 중요","solo_deep":"지게차 조작, 시야 확인 작업으로 독립 작업 多","analytical":"자재 상태 확인으로 분석 보통","creative":"운반 방법 최적화로 창의성 낮음","execution":"지게차 조작, 운반 실행 중심","people_facing":"작업 협업 업무","degree_required":"중졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285429794910',
  '갑문조정판조작원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 55, 80, 70,
  75, 60, 75, 50, 80, 85,
  'regular', 'possible', 'none', 'none',
  'none', 'none', 'none',
  0.77,
  '{"wlb":0.8,"growth":0.75,"stability":0.9,"income":0.85,"teamwork":0.85,"solo_deep":0.8,"analytical":0.9,"creative":0.7,"execution":0.9,"people_facing":0.95,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적지만 교대 근무 가능","growth":"항만 산업 기술 발전 기회 좋음","stability":"제조업으로 고용 안정성 매우 좋음","income":"전문 조작으로 상위 소득","teamwork":"조작 작업 협업 중요","solo_deep":"선박 정보 분석, 수위 모니터링 작업으로 독립 작업 多","analytical":"선박 제원 분석, 수위/유량 모니터링으로 분석 매우 중요","creative":"조작 방법 최적화로 창의성 보통","execution":"조정판 조작, 기록 실행 중심","people_facing":"선장/도선사 통보로 대인관계 매우 多","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285430381929',
  '갠트리크레인조종원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  65, 60, 80, 75,
  80, 55, 70, 45, 80, 85,
  'regular', 'possible', 'none', 'none',
  'none', 'none', 'none',
  0.77,
  '{"wlb":0.8,"growth":0.8,"stability":0.9,"income":0.9,"teamwork":0.9,"solo_deep":0.75,"analytical":0.85,"creative":0.7,"execution":0.9,"people_facing":0.95,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 가능, 교대 근무 가능","growth":"항만 산업 기술 발전 기회 좋음","stability":"제조업으로 고용 안정성 매우 좋음","income":"전문 조종으로 상위 소득","teamwork":"조종 작업 협업 매우 중요","solo_deep":"컨테이너 정보 확인, 신호 응답 작업으로 독립 작업 多","analytical":"컨테이너 규격 분석으로 분석 중요","creative":"조종 방법 최적화로 창의성 보통","execution":"크레인 조종, 하역 실행 중심","people_facing":"신호수와 협업으로 대인관계 매우 多","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '176528543097114',
  '곡물하역장치조작원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 50, 80, 70,
  75, 55, 75, 45, 80, 75,
  'regular', 'possible', 'none', 'none',
  'none', 'none', 'none',
  0.76,
  '{"wlb":0.8,"growth":0.7,"stability":0.9,"income":0.85,"teamwork":0.85,"solo_deep":0.75,"analytical":0.9,"creative":0.7,"execution":0.9,"people_facing":0.9,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 적지만 교대 근무 가능","growth":"항만 산업 기술 발전 기회 보통","stability":"제조업으로 고용 안정성 매우 좋음","income":"전문 조작으로 상위 소득","teamwork":"조작 작업 협업 중요","solo_deep":"하역량 계산, 모니터링 작업으로 독립 작업 多","analytical":"하역량/저장능력 분석으로 분석 매우 중요","creative":"조작 방법 최적화로 창의성 보통","execution":"장치 조작, 일지 작성 실행 중심","people_facing":"선사측 협의로 대인관계 多","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285431460189',
  '권양기조종보조원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  65, 45, 80, 65,
  85, 50, 65, 40, 75, 90,
  'regular', 'possible', 'none', 'none',
  'none', 'none', 'entry',
  0.75,
  '{"wlb":0.8,"growth":0.65,"stability":0.9,"income":0.8,"teamwork":0.95,"solo_deep":0.7,"analytical":0.8,"creative":0.65,"execution":0.85,"people_facing":0.98,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 가능, 교대 근무 가능","growth":"광산 산업 기술 발전 기회 낮음","stability":"제조업으로 고용 안정성 매우 좋음","income":"보조원으로 중위 소득","teamwork":"보조 작업 협업 매우 중요","solo_deep":"장비 점검, 신호 송수신 작업으로 독립 작업 多","analytical":"안전 상태 확인으로 분석 중요","creative":"보조 방법 최적화로 창의성 낮음","execution":"신호 송신, 기록 실행 중심","people_facing":"조종원과의 신호 교환으로 대인관계 매우 多","degree_required":"중졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285431887238',
  '권양기조종원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  65, 50, 80, 70,
  80, 55, 75, 45, 80, 85,
  'regular', 'possible', 'none', 'none',
  'none', 'none', 'none',
  0.76,
  '{"wlb":0.8,"growth":0.7,"stability":0.9,"income":0.85,"teamwork":0.9,"solo_deep":0.75,"analytical":0.9,"creative":0.7,"execution":0.9,"people_facing":0.95,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 가능, 교대 근무 가능","growth":"광산 산업 기술 발전 기회 보통","stability":"제조업으로 고용 안정성 매우 좋음","income":"전문 조종으로 상위 소득","teamwork":"조종 작업 협업 중요","solo_deep":"계기 점검, 위치 모니터링 작업으로 독립 작업 多","analytical":"계기 모니터링, 과부하 확인으로 분석 매우 중요","creative":"조종 방법 최적화로 창의성 보통","execution":"레버 조작, 브레이크 실행 중심","people_facing":"신호 교환, 인계 업무","degree_required":"중졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '176528543236306',
  '그레이더운전원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  60, 50, 80, 70,
  75, 55, 70, 50, 80, 75,
  'regular', 'possible', 'none', 'none',
  'none', 'none', 'none',
  0.76,
  '{"wlb":0.7,"growth":0.7,"stability":0.9,"income":0.85,"teamwork":0.85,"solo_deep":0.75,"analytical":0.85,"creative":0.7,"execution":0.9,"people_facing":0.9,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 가능, 교대 근무 가능","growth":"건설 산업 기술 발전 기회 보통","stability":"제조업으로 고용 안정성 매우 좋음","income":"전문 운전으로 상위 소득","teamwork":"운전 작업 협업 중요","solo_deep":"지형 분석, 블레이드 조절 작업으로 독립 작업 多","analytical":"지형 상태 분석으로 분석 중요","creative":"운전 방법 최적화로 창의성 보통","execution":"그레이더 조작 실행 중심","people_facing":"팀 협업 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285432860585',
  '기중기운전원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  65, 50, 80, 70,
  80, 50, 70, 45, 80, 85,
  'regular', 'possible', 'none', 'none',
  'none', 'none', 'none',
  0.76,
  '{"wlb":0.8,"growth":0.7,"stability":0.9,"income":0.85,"teamwork":0.9,"solo_deep":0.7,"analytical":0.85,"creative":0.7,"execution":0.9,"people_facing":0.95,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 가능, 교대 근무 가능","growth":"건설/물류 산업 기술 발전 기회 보통","stability":"제조업으로 고용 안정성 매우 좋음","income":"전문 운전으로 상위 소득","teamwork":"운전 작업 협업 중요","solo_deep":"중량물 취급, 신호 응답 작업으로 독립 작업 多","analytical":"중량/균형 분석으로 분석 중요","creative":"운전 방법 최적화로 창의성 보통","execution":"기중기 조작 실행 중심","people_facing":"신호수 협업으로 대인관계 매우 多","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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
  '1765285433349428',
  '기중기조종보조원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  65, 45, 80, 65,
  85, 45, 65, 40, 75, 90,
  'regular', 'possible', 'none', 'none',
  'none', 'none', 'none',
  0.75,
  '{"wlb":0.8,"growth":0.65,"stability":0.9,"income":0.8,"teamwork":0.95,"solo_deep":0.6,"analytical":0.8,"creative":0.65,"execution":0.85,"people_facing":0.98,"degree_required":0.9,"license_required":0.9}',
  '{"wlb":"일반 사무 환경으로 야근 가능, 교대 근무 가능","growth":"건설/물류 산업 기술 발전 기회 낮음","stability":"제조업으로 고용 안정성 매우 좋음","income":"보조원으로 중위 소득","teamwork":"보조 작업 협업 매우 중요","solo_deep":"신호 송신, 물품 유도 작업으로 독립 작업 多","analytical":"물품 상태 확인으로 분석 중요","creative":"보조 방법 최적화로 창의성 낮음","execution":"신호 송신, 유도 실행 중심","people_facing":"조종원과의 신호 교환으로 대인관계 매우 多","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 불필요"}'
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