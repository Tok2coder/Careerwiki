-- Batch tagging SQL generated at 2026-01-06T08:18:18.982Z
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
  '1765284457339836',
  '병원보조원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  60, 35, 75, 35,
  70, 30, 40, 25, 80, 80,
  'regular', 'required', 'none', 'none',
  'none', 'none', 'entry',
  0.87,
  '{"wlb":0.7,"growth":0.5,"stability":0.85,"income":0.5,"teamwork":0.8,"solo_deep":0.5,"analytical":0.6,"creative":0.4,"execution":0.9,"people_facing":0.9,"degree_required":0.95,"license_required":0.9}',
  '{"wlb":"병원 업무로 교대 근무 필수","growth":"보조 업무로 성장 기회 제한적","stability":"병원 업무로 안정적","income":"보조 업무로 중간 수준 소득","teamwork":"의료진 지원으로 협업 필요","solo_deep":"물품 정리, 소독으로 독립 작업","analytical":"물품 확인, 환자 상태 파악으로 일부 분석","creative":"표준화된 업무로 창의성 낮음","execution":"물품 정리, 소독, 환자 지원 실행 중심","people_facing":"환자 옷 갈아입히기, 활동 돕기로 대면 업무 多","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 요구 없음"}'
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
  '176528445773824',
  '정신질환치료보조원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  55, 45, 75, 40,
  75, 25, 55, 45, 80, 95,
  'regular', 'required', 'none', 'none',
  'none', 'none', 'entry',
  0.83,
  '{"wlb":0.6,"growth":0.6,"stability":0.85,"income":0.6,"teamwork":0.8,"solo_deep":0.4,"analytical":0.7,"creative":0.6,"execution":0.9,"people_facing":0.98,"degree_required":0.95,"license_required":0.9}',
  '{"wlb":"병원 업무로 교대 근무 필수","growth":"치료 보조로 환자 이해 기회 있음","stability":"병원 업무로 안정적","income":"보조 업무로 중간 수준 소득","teamwork":"의료진 협업으로 팀워크 중요","solo_deep":"환자 관찰, 기록으로 독립 작업","analytical":"환자 행동 관찰, 치료 활동 유도로 분석 요구","creative":"치료 활동 기획으로 창의성 요구","execution":"환자 목욕, 옷 갈아입히기, 치료 활동 유도 실행 중심","people_facing":"환자 목욕, 옷 갈아입히기, 치료 활동 유도로 대면 업무 매우 多","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 요구 없음"}'
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
  '1765284458134848',
  '환자이송원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  60, 30, 80, 35,
  65, 35, 35, 20, 85, 85,
  'regular', 'required', 'none', 'none',
  'none', 'none', 'entry',
  0.88,
  '{"wlb":0.7,"growth":0.4,"stability":0.9,"income":0.5,"teamwork":0.7,"solo_deep":0.5,"analytical":0.5,"creative":0.3,"execution":0.95,"people_facing":0.9,"degree_required":0.95,"license_required":0.9}',
  '{"wlb":"병원 업무로 교대 근무 필수","growth":"이송 업무로 성장 기회 매우 제한적","stability":"병원 업무로 안정적","income":"이송 업무로 중간 수준 소득","teamwork":"의료진 지시대로 협업 필요","solo_deep":"환자 이송, 확인으로 독립 작업","analytical":"환자 정보 확인으로 최소 분석","creative":"표준화된 업무로 창의성 낮음","execution":"환자 이송 실행 중심","people_facing":"환자 이송, 안전 확보로 대면 업무 多","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 요구 없음"}'
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
  '1765284458471426',
  '미용보조원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  65, 40, 70, 35,
  75, 25, 45, 40, 80, 90,
  'regular', 'possible', 'none', 'none',
  'none', 'none', 'entry',
  0.86,
  '{"wlb":0.8,"growth":0.6,"stability":0.8,"income":0.5,"teamwork":0.8,"solo_deep":0.4,"analytical":0.6,"creative":0.6,"execution":0.9,"people_facing":0.95,"degree_required":0.95,"license_required":0.9}',
  '{"wlb":"미용실 업무로 교대 근무 가능","growth":"미용 보조로 기술 습득 기회 있음","stability":"미용업으로 비교적 안정적","income":"보조 업무로 중간 수준 소득","teamwork":"미용사 지원으로 협업 多","solo_deep":"기구 정리, 세탁으로 독립 작업","analytical":"고객 요구 파악으로 일부 분석","creative":"미용 기구 준비, 정리로 창의성 요구","execution":"기구 준비, 정리, 세탁 실행 중심","people_facing":"고객 지원, 서비스로 대면 업무 매우 多","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 요구 없음"}'
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
  '1765284458952955',
  '다이어트프로그래머',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 55, 65, 45,
  65, 35, 75, 60, 75, 85,
  'regular', 'none', 'none', 'partial',
  'college', 'none', 'none',
  0.82,
  '{"wlb":0.8,"growth":0.7,"stability":0.75,"income":0.6,"teamwork":0.8,"solo_deep":0.5,"analytical":0.85,"creative":0.8,"execution":0.8,"people_facing":0.9,"degree_required":0.9,"license_required":0.8}',
  '{"wlb":"피트니스 업무로 정규 근무","growth":"다이어트 프로그램 개발로 전문성 향상 기회 좋음","stability":"피트니스 업계로 비교적 안정적","income":"전문 프로그램으로 중상위 소득","teamwork":"프로그램 개발, 고객 상담으로 협업 필요","solo_deep":"프로그램 설계, 분석으로 독립 작업","analytical":"체형 분석, 식습관 검토, 프로그램 설계로 분석 중심","creative":"개별화 프로그램 개발로 창의성 높음","execution":"프로그램 설명, 점검 실행 중심","people_facing":"고객 상담, 프로그램 설명으로 대면 업무 매우 多","degree_required":"전문대졸 정도 학력 요구","license_required":"특별 자격증 요구 없음"}'
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
  '1765284459411973',
  '두피모발관리사',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 50, 70, 45,
  60, 40, 70, 55, 80, 90,
  'regular', 'none', 'none', 'none',
  'college', 'none', 'none',
  0.84,
  '{"wlb":0.8,"growth":0.7,"stability":0.8,"income":0.6,"teamwork":0.7,"solo_deep":0.6,"analytical":0.8,"creative":0.7,"execution":0.9,"people_facing":0.95,"degree_required":0.9,"license_required":0.8}',
  '{"wlb":"미용실 업무로 정규 근무","growth":"두피 모발 관리로 전문성 향상 기회 좋음","stability":"미용업으로 비교적 안정적","income":"전문 관리로 중상위 소득","teamwork":"고객 상담, 관리로 협업 적음","solo_deep":"두피 상태 측정, 관리 계획 수립으로 독립 작업","analytical":"두피 측정, 고객 정보 분석으로 분석 요구","creative":"관리 프로그램 개발로 창의성 높음","execution":"스케일링, 영양제 사용 실행 중심","people_facing":"고객 상담, 관리로 대면 업무 매우 多","degree_required":"전문대졸 정도 학력 요구","license_required":"특별 자격증 요구 없음"}'
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
  '1765284459827410',
  '목욕관리사',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  60, 30, 70, 35,
  60, 40, 35, 30, 85, 95,
  'regular', 'required', 'none', 'none',
  'none', 'none', 'entry',
  0.89,
  '{"wlb":0.7,"growth":0.4,"stability":0.8,"income":0.5,"teamwork":0.7,"solo_deep":0.6,"analytical":0.5,"creative":0.5,"execution":0.95,"people_facing":0.98,"degree_required":0.95,"license_required":0.9}',
  '{"wlb":"목욕탕 업무로 교대 근무 필수","growth":"청결 서비스로 성장 기회 제한적","stability":"목욕탕 업무로 비교적 안정적","income":"서비스 업무로 중간 수준 소득","teamwork":"목욕탕 운영으로 협업 필요","solo_deep":"때 밀기, 마사지로 독립 작업 多","analytical":"고객 요구 파악으로 최소 분석","creative":"서비스 제공 방식으로 일부 창의성","execution":"때 밀기, 마사지 실행 중심","people_facing":"고객 때 밀기, 마사지로 대면 업무 매우 多","degree_required":"중졸 정도 학력 요구","license_required":"특별 자격증 요구 없음"}'
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
  '1765284460136258',
  '손톱미용사',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 45, 70, 40,
  55, 45, 50, 60, 80, 90,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.85,
  '{"wlb":0.8,"growth":0.6,"stability":0.8,"income":0.6,"teamwork":0.6,"solo_deep":0.7,"analytical":0.6,"creative":0.8,"execution":0.9,"people_facing":0.95,"degree_required":0.95,"license_required":0.9}',
  '{"wlb":"미용실 업무로 정규 근무","growth":"손톱 미용 기술로 전문성 향상 기회 있음","stability":"미용업으로 비교적 안정적","income":"미용 업무로 중간 수준 소득","teamwork":"미용실 운영으로 협업 적음","solo_deep":"시술 준비, 정리로 독립 작업 多","analytical":"고객 건강상태 파악으로 분석 요구","creative":"네일 디자인으로 창의성 높음","execution":"시술, 정리 실행 중심","people_facing":"고객 상담, 시술로 대면 업무 매우 多","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 요구 없음"}'
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
  '1765284460507591',
  '왁서',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 45, 70, 40,
  55, 45, 55, 65, 80, 90,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'entry',
  0.84,
  '{"wlb":0.8,"growth":0.6,"stability":0.8,"income":0.6,"teamwork":0.6,"solo_deep":0.7,"analytical":0.7,"creative":0.8,"execution":0.9,"people_facing":0.95,"degree_required":0.95,"license_required":0.9}',
  '{"wlb":"미용실 업무로 정규 근무","growth":"왁싱 기술로 전문성 향상 기회 있음","stability":"미용업으로 비교적 안정적","income":"왁싱 업무로 중간 수준 소득","teamwork":"미용실 운영으로 협업 적음","solo_deep":"시술 준비, 디자인으로 독립 작업 多","analytical":"고객 체형, 선호 파악으로 분석 요구","creative":"디자인, 시술 방법으로 창의성 매우 높음","execution":"왁싱 시술 실행 중심","people_facing":"고객 상담, 시술로 대면 업무 매우 多","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 요구 없음"}'
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
  '1765284460846677',
  '페디큐어리스트',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 45, 70, 40,
  55, 45, 50, 60, 80, 90,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'entry',
  0.85,
  '{"wlb":0.8,"growth":0.6,"stability":0.8,"income":0.6,"teamwork":0.6,"solo_deep":0.7,"analytical":0.6,"creative":0.8,"execution":0.9,"people_facing":0.95,"degree_required":0.95,"license_required":0.9}',
  '{"wlb":"미용실 업무로 정규 근무","growth":"페디큐어 기술로 전문성 향상 기회 있음","stability":"미용업으로 비교적 안정적","income":"페디큐어 업무로 중간 수준 소득","teamwork":"미용실 운영으로 협업 적음","solo_deep":"시술 준비, 정리로 독립 작업 多","analytical":"고객 건강상태 파악으로 분석 요구","creative":"발톱 디자인으로 창의성 높음","execution":"각질 제거, 매니큐어 실행 중심","people_facing":"고객 상담, 시술로 대면 업무 매우 多","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 요구 없음"}'
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