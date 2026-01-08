-- Batch tagging SQL generated at 2026-01-06T07:53:42.707Z
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
  '1765284325073103',
  '컨테이너부두운영사무원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  65, 55, 75, 45,
  60, 40, 50, 35, 60, 70,
  'regular', 'none', 'some', 'none',
  'college', 'none', 'none',
  0.85,
  '{"wlb":0.8,"growth":0.7,"stability":0.9,"income":0.6,"teamwork":0.8,"solo_deep":0.7,"analytical":0.7,"creative":0.6,"execution":0.8,"people_facing":0.8,"degree_required":0.9,"license_required":0.8}',
  '{"wlb":"실내 사무직으로 정규 근무시간, 야근 가능성 있지만 상시 아님","growth":"터미널 운영 현대화, 신기술 기획 참여로 성장 기회","stability":"항만 운영 필수 업무로 안정적","income":"운송 사무직으로 중간 수준 소득","teamwork":"선사 협의, 고객 요구사항 접수로 협업 필요","solo_deep":"전략 수립, 데이터 분석으로 일부 독립 작업","analytical":"시장 분석, 경쟁사 자료 수집으로 분석 요구","creative":"마케팅 전략 수립으로 일부 창의성","execution":"계약 체결, 운영 관리로 실행 중심","people_facing":"고객 요구사항 접수, 선사 협의로 대면 업무 多","degree_required":"전문대졸 정도 학력 요구","license_required":"특별 자격증 요구 없음"}'
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
  '1765284325505964',
  '컨테이너부두운영정보관리원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 45, 80, 40,
  50, 50, 65, 25, 70, 40,
  'regular', 'none', 'none', 'partial',
  'college', 'none', 'entry',
  0.88,
  '{"wlb":0.85,"growth":0.6,"stability":0.9,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.8,"creative":0.5,"execution":0.8,"people_facing":0.6,"degree_required":0.9,"license_required":0.8}',
  '{"wlb":"실내 사무직으로 정규 근무, 야근 적음","growth":"정보 관리 업무로 전문성 향상 기회 제한적","stability":"항만 운영 핵심 업무로 매우 안정적","income":"사무직으로 중간 수준 소득","teamwork":"데이터 관리로 일부 협업","solo_deep":"정보 입력, 분석으로 독립/협업 반반","analytical":"데이터 분석, 통계 관리로 분석 중심","creative":"표준화된 업무로 창의성 낮음","execution":"정보 입력, 관리 실행 중심","people_facing":"내부 보고, 일부 외부 연락으로 중간 수준","degree_required":"전문대졸 정도 학력 요구","license_required":"특별 자격증 요구 없음"}'
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
  '176528432584544',
  '컨테이너부두정보화기획원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  60, 65, 75, 50,
  55, 45, 70, 40, 65, 45,
  'regular', 'none', 'none', 'partial',
  'bachelor', 'none', 'none',
  0.82,
  '{"wlb":0.8,"growth":0.7,"stability":0.9,"income":0.6,"teamwork":0.7,"solo_deep":0.6,"analytical":0.8,"creative":0.6,"execution":0.7,"people_facing":0.6,"degree_required":0.9,"license_required":0.8}',
  '{"wlb":"실내외 사무직으로 정규 근무, 야근 가능성","growth":"정보화 기획, 시스템 개발 참여로 성장 기회 좋음","stability":"항만 운영 IT 업무로 안정적","income":"전문 사무직으로 중상위 소득","teamwork":"기획 협의, 운영 조정으로 협업 필요","solo_deep":"계획 수립, 분석으로 독립 작업 多","analytical":"운영 데이터 분석, 통계 처리로 분석 중심","creative":"정보화 기획으로 일부 창의성 요구","execution":"시스템 기획, 운영 관리로 실행 중심","people_facing":"내부 협의, 외부 연락으로 중간 수준","degree_required":"대졸 정도 학력 요구","license_required":"특별 자격증 요구 없음"}'
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
  '1765284326274327',
  '컨테이너작업정산사무원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  75, 40, 85, 35,
  45, 55, 60, 20, 75, 35,
  'regular', 'none', 'none', 'partial',
  'none', 'none', 'entry',
  0.9,
  '{"wlb":0.9,"growth":0.6,"stability":0.95,"income":0.7,"teamwork":0.7,"solo_deep":0.7,"analytical":0.8,"creative":0.5,"execution":0.85,"people_facing":0.6,"degree_required":0.95,"license_required":0.9}',
  '{"wlb":"실내 사무직으로 정규 근무, 야근 거의 없음","growth":"정산 업무로 전문성 향상 제한적","stability":"항만 운영 필수 업무로 매우 안정적","income":"기초 사무직으로 중하위 소득","teamwork":"독립적 정산 업무로 협업 적음","solo_deep":"계산, 기록 업무로 독립 작업 多","analytical":"요금 계산, 데이터 확인으로 분석 요구","creative":"표준화된 정산 업무로 창의성 낮음","execution":"계산, 기록 실행 중심","people_facing":"내부 업무 위주로 대면 적음","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 요구 없음"}'
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
  '1765284326723730',
  '컨테이너장비배차원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  55, 50, 75, 45,
  65, 35, 55, 30, 70, 60,
  'overtime_some', 'none', 'none', 'none',
  'college', 'none', 'none',
  0.83,
  '{"wlb":0.7,"growth":0.6,"stability":0.9,"income":0.6,"teamwork":0.8,"solo_deep":0.6,"analytical":0.7,"creative":0.5,"execution":0.8,"people_facing":0.7,"degree_required":0.9,"license_required":0.8}',
  '{"wlb":"실내외 업무로 야근 가능성, 장비 배차 업무 특성","growth":"장비 운영 관리로 일부 전문성 향상","stability":"항만 운영 필수 업무로 안정적","income":"운송 사무직으로 중간 수준 소득","teamwork":"장비조작원 관리, 안전교육으로 협업 필요","solo_deep":"배차 계획, 기록으로 독립 작업","analytical":"장비 사용 현황 분석으로 분석 요구","creative":"배차 계획 수립으로 일부 창의성","execution":"배차, 관리 실행 중심","people_facing":"장비조작원 교육, 업무 지시로 대면 업무","degree_required":"전문대졸 정도 학력 요구","license_required":"특별 자격증 요구 없음"}'
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
  '1765284327146986',
  '컨테이너플래너',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  50, 60, 70, 55,
  70, 30, 75, 45, 65, 75,
  'overtime_frequent', 'possible', 'some', 'none',
  'college', 'none', 'none',
  0.79,
  '{"wlb":0.6,"growth":0.7,"stability":0.8,"income":0.6,"teamwork":0.8,"solo_deep":0.5,"analytical":0.85,"creative":0.6,"execution":0.7,"people_facing":0.8,"degree_required":0.9,"license_required":0.8}',
  '{"wlb":"실내외 업무, 항만 운영으로 야근/교대 가능성 높음","growth":"플래닝 업무로 전문성 향상 기회 좋음","stability":"항만 운영 핵심 업무로 비교적 안정적","income":"전문 플래닝 업무로 중상위 소득","teamwork":"선사 협의, 운영 조율로 협업 多","solo_deep":"계획 수립으로 일부 독립 작업","analytical":"스케줄링, 장치계획 수립으로 분석 중심","creative":"운영 계획 수립으로 창의성 요구","execution":"스케줄 조정, 계획 실행","people_facing":"선사 협의, 요구사항 접수로 대면 업무 多","degree_required":"전문대졸 정도 학력 요구","license_required":"특별 자격증 요구 없음"}'
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
  '1765284327557884',
  '컨테이너화물집하장검수원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  65, 35, 80, 35,
  40, 60, 45, 15, 80, 30,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.87,
  '{"wlb":0.8,"growth":0.5,"stability":0.9,"income":0.7,"teamwork":0.6,"solo_deep":0.7,"analytical":0.6,"creative":0.4,"execution":0.9,"people_facing":0.5,"degree_required":0.95,"license_required":0.9}',
  '{"wlb":"실내외 검수 업무로 정규 근무","growth":"검수 업무로 성장 기회 제한적","stability":"항만 운영 필수 업무로 매우 안정적","income":"기초 검수 업무로 낮은 소득","teamwork":"독립적 검수 업무로 협업 적음","solo_deep":"화물 확인, 기록으로 독립 작업 多","analytical":"화물 상태 확인으로 일부 분석","creative":"표준화된 검수로 창의성 낮음","execution":"검수, 기록 실행 중심","people_facing":"내부 업무 위주로 대면 적음","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 요구 없음"}'
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
  '1765284327989169',
  '컨테이너화물집하장수입사무원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 45, 80, 40,
  55, 45, 55, 25, 70, 50,
  'regular', 'none', 'none', 'partial',
  'college', 'none', 'none',
  0.85,
  '{"wlb":0.8,"growth":0.6,"stability":0.9,"income":0.6,"teamwork":0.7,"solo_deep":0.6,"analytical":0.7,"creative":0.5,"execution":0.8,"people_facing":0.7,"degree_required":0.9,"license_required":0.8}',
  '{"wlb":"실내 사무직으로 정규 근무","growth":"수입 업무 관리로 일부 성장 기회","stability":"항만 운영 업무로 매우 안정적","income":"사무직으로 중간 수준 소득","teamwork":"창고관리원 협의로 협업 필요","solo_deep":"서류 처리, 기록으로 독립 작업","analytical":"화물 정보 확인, 분석으로 분석 요구","creative":"표준화된 업무로 창의성 낮음","execution":"서류 처리, 작업 지시 실행 중심","people_facing":"내부 연락, 화주 응대로 대면 업무","degree_required":"전문대졸 정도 학력 요구","license_required":"특별 자격증 요구 없음"}'
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
  '1765284328439668',
  '컨테이너화물집하장수출사무원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 45, 80, 40,
  55, 45, 55, 25, 70, 50,
  'regular', 'none', 'none', 'partial',
  'college', 'none', 'none',
  0.85,
  '{"wlb":0.8,"growth":0.6,"stability":0.9,"income":0.6,"teamwork":0.7,"solo_deep":0.6,"analytical":0.7,"creative":0.5,"execution":0.8,"people_facing":0.7,"degree_required":0.9,"license_required":0.8}',
  '{"wlb":"실내 사무직으로 정규 근무","growth":"수출 업무 관리로 일부 성장 기회","stability":"항만 운영 업무로 매우 안정적","income":"사무직으로 중간 수준 소득","teamwork":"창고관리원 협의로 협업 필요","solo_deep":"서류 처리, 기록으로 독립 작업","analytical":"화물 정보 확인, 분석으로 분석 요구","creative":"표준화된 업무로 창의성 낮음","execution":"서류 처리, 작업 지시 실행 중심","people_facing":"내부 연락, 화주 응대로 대면 업무","degree_required":"전문대졸 정도 학력 요구","license_required":"특별 자격증 요구 없음"}'
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
  '1765284328829139',
  '탑승수속사무원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  60, 35, 75, 35,
  65, 35, 40, 20, 75, 85,
  'overtime_some', 'possible', 'none', 'none',
  'college', 'none', 'none',
  0.86,
  '{"wlb":0.7,"growth":0.5,"stability":0.9,"income":0.6,"teamwork":0.8,"solo_deep":0.6,"analytical":0.6,"creative":0.4,"execution":0.8,"people_facing":0.95,"degree_required":0.9,"license_required":0.8}',
  '{"wlb":"항공 업무로 야근/교대 가능성, 고객 응대 업무","growth":"수속 업무로 성장 기회 제한적","stability":"항공 운영 필수 업무로 안정적","income":"서비스 사무직으로 중하위 소득","teamwork":"승객 응대, 좌석 배정 협업","solo_deep":"수속 처리로 독립 작업","analytical":"예약 정보 확인으로 일부 분석","creative":"표준화된 수속으로 창의성 낮음","execution":"수속 처리, 안내 실행 중심","people_facing":"승객 응대, 안내로 대면 업무 多","degree_required":"전문대졸 정도 학력 요구","license_required":"특별 자격증 요구 없음"}'
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