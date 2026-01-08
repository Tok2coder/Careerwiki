-- Batch tagging SQL generated at 2026-01-06T05:56:57.202Z
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
  '1765283335747600',
  '식품공학기술자',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 85, 65, 80,
  50, 50, 60, 60, 30, 35,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 식품공학기술자는 식품의 생산, 가공, 저장, 유통 등 식품의 전 과정에 걸쳐 과학적·기술적 방법을 적용하여 식품의 품질 향상과 안전성 확보를 위한 연구와 개발 업무를 수행합니다.\n... 기반으로 50로 평가","growth":"growth는 식품공학기술자는 식품의 생산, 가공, 저장, 유통 등 식품의 전 과정에 걸쳐 과학적·기술적 방법을 적용하여 식품의 품질 향상과 안전성 확보를 위한 연구와 개발 업무를 수행합니다.\n... 기반으로 85로 평가","stability":"stability는 식품공학기술자는 식품의 생산, 가공, 저장, 유통 등 식품의 전 과정에 걸쳐 과학적·기술적 방법을 적용하여 식품의 품질 향상과 안전성 확보를 위한 연구와 개발 업무를 수행합니다.\n... 기반으로 65로 평가","income":"income는 식품공학기술자는 식품의 생산, 가공, 저장, 유통 등 식품의 전 과정에 걸쳐 과학적·기술적 방법을 적용하여 식품의 품질 향상과 안전성 확보를 위한 연구와 개발 업무를 수행합니다.\n... 기반으로 80로 평가","teamwork":"teamwork는 식품공학기술자는 식품의 생산, 가공, 저장, 유통 등 식품의 전 과정에 걸쳐 과학적·기술적 방법을 적용하여 식품의 품질 향상과 안전성 확보를 위한 연구와 개발 업무를 수행합니다.\n... 기반으로 50로 평가","solo_deep":"solo_deep는 식품공학기술자는 식품의 생산, 가공, 저장, 유통 등 식품의 전 과정에 걸쳐 과학적·기술적 방법을 적용하여 식품의 품질 향상과 안전성 확보를 위한 연구와 개발 업무를 수행합니다.\n... 기반으로 50로 평가","analytical":"analytical는 식품공학기술자는 식품의 생산, 가공, 저장, 유통 등 식품의 전 과정에 걸쳐 과학적·기술적 방법을 적용하여 식품의 품질 향상과 안전성 확보를 위한 연구와 개발 업무를 수행합니다.\n... 기반으로 60로 평가","creative":"creative는 식품공학기술자는 식품의 생산, 가공, 저장, 유통 등 식품의 전 과정에 걸쳐 과학적·기술적 방법을 적용하여 식품의 품질 향상과 안전성 확보를 위한 연구와 개발 업무를 수행합니다.\n... 기반으로 60로 평가","execution":"execution는 식품공학기술자는 식품의 생산, 가공, 저장, 유통 등 식품의 전 과정에 걸쳐 과학적·기술적 방법을 적용하여 식품의 품질 향상과 안전성 확보를 위한 연구와 개발 업무를 수행합니다.\n... 기반으로 30로 평가","people_facing":"people_facing는 식품공학기술자는 식품의 생산, 가공, 저장, 유통 등 식품의 전 과정에 걸쳐 과학적·기술적 방법을 적용하여 식품의 품질 향상과 안전성 확보를 위한 연구와 개발 업무를 수행합니다.\n... 기반으로 35로 평가","degree_required":"degree_required는 식품공학기술자는 식품의 생산, 가공, 저장, 유통 등 식품의 전 과정에 걸쳐 과학적·기술적 방법을 적용하여 식품의 품질 향상과 안전성 확보를 위한 연구와 개발 업무를 수행합니다.\n... 기반으로 none로 평가","license_required":"license_required는 식품공학기술자는 식품의 생산, 가공, 저장, 유통 등 식품의 전 과정에 걸쳐 과학적·기술적 방법을 적용하여 식품의 품질 향상과 안전성 확보를 위한 연구와 개발 업무를 수행합니다.\n... 기반으로 none로 평가"}'
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
  '1765283317262867',
  '부동산중개인',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  30, 70, 70, 40, 40, 75,
  'regular', 'none', 'none', 'partial',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 부동산중개인은 부동산 매매, 임대차 등 부동산 거래를 중개하는 일을 담당합니다.\n\n부동산 매매, 임대차 등 부동산 거래에 관한 계약을 중개합니다.\n\n부동산 거래에 필요한 서류를 작... 기반으로 50로 평가","growth":"growth는 부동산중개인은 부동산 매매, 임대차 등 부동산 거래를 중개하는 일을 담당합니다.\n\n부동산 매매, 임대차 등 부동산 거래에 관한 계약을 중개합니다.\n\n부동산 거래에 필요한 서류를 작... 기반으로 50로 평가","stability":"stability는 부동산중개인은 부동산 매매, 임대차 등 부동산 거래를 중개하는 일을 담당합니다.\n\n부동산 매매, 임대차 등 부동산 거래에 관한 계약을 중개합니다.\n\n부동산 거래에 필요한 서류를 작... 기반으로 50로 평가","income":"income는 부동산중개인은 부동산 매매, 임대차 등 부동산 거래를 중개하는 일을 담당합니다.\n\n부동산 매매, 임대차 등 부동산 거래에 관한 계약을 중개합니다.\n\n부동산 거래에 필요한 서류를 작... 기반으로 50로 평가","teamwork":"teamwork는 부동산중개인은 부동산 매매, 임대차 등 부동산 거래를 중개하는 일을 담당합니다.\n\n부동산 매매, 임대차 등 부동산 거래에 관한 계약을 중개합니다.\n\n부동산 거래에 필요한 서류를 작... 기반으로 30로 평가","solo_deep":"solo_deep는 부동산중개인은 부동산 매매, 임대차 등 부동산 거래를 중개하는 일을 담당합니다.\n\n부동산 매매, 임대차 등 부동산 거래에 관한 계약을 중개합니다.\n\n부동산 거래에 필요한 서류를 작... 기반으로 70로 평가","analytical":"analytical는 부동산중개인은 부동산 매매, 임대차 등 부동산 거래를 중개하는 일을 담당합니다.\n\n부동산 매매, 임대차 등 부동산 거래에 관한 계약을 중개합니다.\n\n부동산 거래에 필요한 서류를 작... 기반으로 70로 평가","creative":"creative는 부동산중개인은 부동산 매매, 임대차 등 부동산 거래를 중개하는 일을 담당합니다.\n\n부동산 매매, 임대차 등 부동산 거래에 관한 계약을 중개합니다.\n\n부동산 거래에 필요한 서류를 작... 기반으로 40로 평가","execution":"execution는 부동산중개인은 부동산 매매, 임대차 등 부동산 거래를 중개하는 일을 담당합니다.\n\n부동산 매매, 임대차 등 부동산 거래에 관한 계약을 중개합니다.\n\n부동산 거래에 필요한 서류를 작... 기반으로 40로 평가","people_facing":"people_facing는 부동산중개인은 부동산 매매, 임대차 등 부동산 거래를 중개하는 일을 담당합니다.\n\n부동산 매매, 임대차 등 부동산 거래에 관한 계약을 중개합니다.\n\n부동산 거래에 필요한 서류를 작... 기반으로 75로 평가","degree_required":"degree_required는 부동산중개인은 부동산 매매, 임대차 등 부동산 거래를 중개하는 일을 담당합니다.\n\n부동산 매매, 임대차 등 부동산 거래에 관한 계약을 중개합니다.\n\n부동산 거래에 필요한 서류를 작... 기반으로 none로 평가","license_required":"license_required는 부동산중개인은 부동산 매매, 임대차 등 부동산 거래를 중개하는 일을 담당합니다.\n\n부동산 매매, 임대차 등 부동산 거래에 관한 계약을 중개합니다.\n\n부동산 거래에 필요한 서류를 작... 기반으로 none로 평가"}'
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
  '1765283365417879',
  '전기공학기술자',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 85, 65, 80,
  50, 50, 50, 50, 50, 35,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 전기공학기술자는 전기, 전자, 통신 등 전기 분야의 기술 개발과 연구를 담당합니다.\n\n전기, 전자, 통신 분야의 새로운 기술을 연구하고 개발합니다.\n\n전기 설비와 기기의 설계, 제... 기반으로 50로 평가","growth":"growth는 전기공학기술자는 전기, 전자, 통신 등 전기 분야의 기술 개발과 연구를 담당합니다.\n\n전기, 전자, 통신 분야의 새로운 기술을 연구하고 개발합니다.\n\n전기 설비와 기기의 설계, 제... 기반으로 85로 평가","stability":"stability는 전기공학기술자는 전기, 전자, 통신 등 전기 분야의 기술 개발과 연구를 담당합니다.\n\n전기, 전자, 통신 분야의 새로운 기술을 연구하고 개발합니다.\n\n전기 설비와 기기의 설계, 제... 기반으로 65로 평가","income":"income는 전기공학기술자는 전기, 전자, 통신 등 전기 분야의 기술 개발과 연구를 담당합니다.\n\n전기, 전자, 통신 분야의 새로운 기술을 연구하고 개발합니다.\n\n전기 설비와 기기의 설계, 제... 기반으로 80로 평가","teamwork":"teamwork는 전기공학기술자는 전기, 전자, 통신 등 전기 분야의 기술 개발과 연구를 담당합니다.\n\n전기, 전자, 통신 분야의 새로운 기술을 연구하고 개발합니다.\n\n전기 설비와 기기의 설계, 제... 기반으로 50로 평가","solo_deep":"solo_deep는 전기공학기술자는 전기, 전자, 통신 등 전기 분야의 기술 개발과 연구를 담당합니다.\n\n전기, 전자, 통신 분야의 새로운 기술을 연구하고 개발합니다.\n\n전기 설비와 기기의 설계, 제... 기반으로 50로 평가","analytical":"analytical는 전기공학기술자는 전기, 전자, 통신 등 전기 분야의 기술 개발과 연구를 담당합니다.\n\n전기, 전자, 통신 분야의 새로운 기술을 연구하고 개발합니다.\n\n전기 설비와 기기의 설계, 제... 기반으로 50로 평가","creative":"creative는 전기공학기술자는 전기, 전자, 통신 등 전기 분야의 기술 개발과 연구를 담당합니다.\n\n전기, 전자, 통신 분야의 새로운 기술을 연구하고 개발합니다.\n\n전기 설비와 기기의 설계, 제... 기반으로 50로 평가","execution":"execution는 전기공학기술자는 전기, 전자, 통신 등 전기 분야의 기술 개발과 연구를 담당합니다.\n\n전기, 전자, 통신 분야의 새로운 기술을 연구하고 개발합니다.\n\n전기 설비와 기기의 설계, 제... 기반으로 50로 평가","people_facing":"people_facing는 전기공학기술자는 전기, 전자, 통신 등 전기 분야의 기술 개발과 연구를 담당합니다.\n\n전기, 전자, 통신 분야의 새로운 기술을 연구하고 개발합니다.\n\n전기 설비와 기기의 설계, 제... 기반으로 35로 평가","degree_required":"degree_required는 전기공학기술자는 전기, 전자, 통신 등 전기 분야의 기술 개발과 연구를 담당합니다.\n\n전기, 전자, 통신 분야의 새로운 기술을 연구하고 개발합니다.\n\n전기 설비와 기기의 설계, 제... 기반으로 none로 평가","license_required":"license_required는 전기공학기술자는 전기, 전자, 통신 등 전기 분야의 기술 개발과 연구를 담당합니다.\n\n전기, 전자, 통신 분야의 새로운 기술을 연구하고 개발합니다.\n\n전기 설비와 기기의 설계, 제... 기반으로 none로 평가"}'
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
  '176528331560112',
  '보건의료정보관리사',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 70, 50,
  30, 70, 40, 40, 70, 50,
  'regular', 'none', 'none', 'partial',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 보건의료정보관리사는 의료기관의 환자 정보, 의료 기록, 진료 데이터 등을 체계적으로 관리하는 업무를 수행합니다.\n\n환자의 의료 정보를 수집, 분류, 저장합니다.\n\n의료 정보 시스템... 기반으로 50로 평가","growth":"growth는 보건의료정보관리사는 의료기관의 환자 정보, 의료 기록, 진료 데이터 등을 체계적으로 관리하는 업무를 수행합니다.\n\n환자의 의료 정보를 수집, 분류, 저장합니다.\n\n의료 정보 시스템... 기반으로 50로 평가","stability":"stability는 보건의료정보관리사는 의료기관의 환자 정보, 의료 기록, 진료 데이터 등을 체계적으로 관리하는 업무를 수행합니다.\n\n환자의 의료 정보를 수집, 분류, 저장합니다.\n\n의료 정보 시스템... 기반으로 70로 평가","income":"income는 보건의료정보관리사는 의료기관의 환자 정보, 의료 기록, 진료 데이터 등을 체계적으로 관리하는 업무를 수행합니다.\n\n환자의 의료 정보를 수집, 분류, 저장합니다.\n\n의료 정보 시스템... 기반으로 50로 평가","teamwork":"teamwork는 보건의료정보관리사는 의료기관의 환자 정보, 의료 기록, 진료 데이터 등을 체계적으로 관리하는 업무를 수행합니다.\n\n환자의 의료 정보를 수집, 분류, 저장합니다.\n\n의료 정보 시스템... 기반으로 30로 평가","solo_deep":"solo_deep는 보건의료정보관리사는 의료기관의 환자 정보, 의료 기록, 진료 데이터 등을 체계적으로 관리하는 업무를 수행합니다.\n\n환자의 의료 정보를 수집, 분류, 저장합니다.\n\n의료 정보 시스템... 기반으로 70로 평가","analytical":"analytical는 보건의료정보관리사는 의료기관의 환자 정보, 의료 기록, 진료 데이터 등을 체계적으로 관리하는 업무를 수행합니다.\n\n환자의 의료 정보를 수집, 분류, 저장합니다.\n\n의료 정보 시스템... 기반으로 40로 평가","creative":"creative는 보건의료정보관리사는 의료기관의 환자 정보, 의료 기록, 진료 데이터 등을 체계적으로 관리하는 업무를 수행합니다.\n\n환자의 의료 정보를 수집, 분류, 저장합니다.\n\n의료 정보 시스템... 기반으로 40로 평가","execution":"execution는 보건의료정보관리사는 의료기관의 환자 정보, 의료 기록, 진료 데이터 등을 체계적으로 관리하는 업무를 수행합니다.\n\n환자의 의료 정보를 수집, 분류, 저장합니다.\n\n의료 정보 시스템... 기반으로 70로 평가","people_facing":"people_facing는 보건의료정보관리사는 의료기관의 환자 정보, 의료 기록, 진료 데이터 등을 체계적으로 관리하는 업무를 수행합니다.\n\n환자의 의료 정보를 수집, 분류, 저장합니다.\n\n의료 정보 시스템... 기반으로 50로 평가","degree_required":"degree_required는 보건의료정보관리사는 의료기관의 환자 정보, 의료 기록, 진료 데이터 등을 체계적으로 관리하는 업무를 수행합니다.\n\n환자의 의료 정보를 수집, 분류, 저장합니다.\n\n의료 정보 시스템... 기반으로 none로 평가","license_required":"license_required는 보건의료정보관리사는 의료기관의 환자 정보, 의료 기록, 진료 데이터 등을 체계적으로 관리하는 업무를 수행합니다.\n\n환자의 의료 정보를 수집, 분류, 저장합니다.\n\n의료 정보 시스템... 기반으로 none로 평가"}'
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
  '1765283358918831',
  '임상병리사',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 70,
  50, 50, 70, 40, 40, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 임상병리사는 환자의 혈액, 소변, 조직 등 생체 검체를 검사하여 질병을 진단하는 데 필요한 정보를 제공하는 업무를 수행합니다.\n\n혈액, 소변, 체액 등의 검체를 채취하고 검사합니다... 기반으로 50로 평가","growth":"growth는 임상병리사는 환자의 혈액, 소변, 조직 등 생체 검체를 검사하여 질병을 진단하는 데 필요한 정보를 제공하는 업무를 수행합니다.\n\n혈액, 소변, 체액 등의 검체를 채취하고 검사합니다... 기반으로 50로 평가","stability":"stability는 임상병리사는 환자의 혈액, 소변, 조직 등 생체 검체를 검사하여 질병을 진단하는 데 필요한 정보를 제공하는 업무를 수행합니다.\n\n혈액, 소변, 체액 등의 검체를 채취하고 검사합니다... 기반으로 50로 평가","income":"income는 임상병리사는 환자의 혈액, 소변, 조직 등 생체 검체를 검사하여 질병을 진단하는 데 필요한 정보를 제공하는 업무를 수행합니다.\n\n혈액, 소변, 체액 등의 검체를 채취하고 검사합니다... 기반으로 70로 평가","teamwork":"teamwork는 임상병리사는 환자의 혈액, 소변, 조직 등 생체 검체를 검사하여 질병을 진단하는 데 필요한 정보를 제공하는 업무를 수행합니다.\n\n혈액, 소변, 체액 등의 검체를 채취하고 검사합니다... 기반으로 50로 평가","solo_deep":"solo_deep는 임상병리사는 환자의 혈액, 소변, 조직 등 생체 검체를 검사하여 질병을 진단하는 데 필요한 정보를 제공하는 업무를 수행합니다.\n\n혈액, 소변, 체액 등의 검체를 채취하고 검사합니다... 기반으로 50로 평가","analytical":"analytical는 임상병리사는 환자의 혈액, 소변, 조직 등 생체 검체를 검사하여 질병을 진단하는 데 필요한 정보를 제공하는 업무를 수행합니다.\n\n혈액, 소변, 체액 등의 검체를 채취하고 검사합니다... 기반으로 70로 평가","creative":"creative는 임상병리사는 환자의 혈액, 소변, 조직 등 생체 검체를 검사하여 질병을 진단하는 데 필요한 정보를 제공하는 업무를 수행합니다.\n\n혈액, 소변, 체액 등의 검체를 채취하고 검사합니다... 기반으로 40로 평가","execution":"execution는 임상병리사는 환자의 혈액, 소변, 조직 등 생체 검체를 검사하여 질병을 진단하는 데 필요한 정보를 제공하는 업무를 수행합니다.\n\n혈액, 소변, 체액 등의 검체를 채취하고 검사합니다... 기반으로 40로 평가","people_facing":"people_facing는 임상병리사는 환자의 혈액, 소변, 조직 등 생체 검체를 검사하여 질병을 진단하는 데 필요한 정보를 제공하는 업무를 수행합니다.\n\n혈액, 소변, 체액 등의 검체를 채취하고 검사합니다... 기반으로 50로 평가","degree_required":"degree_required는 임상병리사는 환자의 혈액, 소변, 조직 등 생체 검체를 검사하여 질병을 진단하는 데 필요한 정보를 제공하는 업무를 수행합니다.\n\n혈액, 소변, 체액 등의 검체를 채취하고 검사합니다... 기반으로 none로 평가","license_required":"license_required는 임상병리사는 환자의 혈액, 소변, 조직 등 생체 검체를 검사하여 질병을 진단하는 데 필요한 정보를 제공하는 업무를 수행합니다.\n\n혈액, 소변, 체액 등의 검체를 채취하고 검사합니다... 기반으로 none로 평가"}'
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
  '1765283341240209',
  '약사 및 한약사',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 70,
  50, 50, 40, 40, 70, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 약사 및 한약사는 환자에게 약을 조제하고 투약에 대한 정보를 제공하는 업무를 수행합니다.\n\n처방전을 검토하고 약을 조제합니다.\n\n약의 용법, 용량, 부작용 등에 대해 환자에게 설명... 기반으로 50로 평가","growth":"growth는 약사 및 한약사는 환자에게 약을 조제하고 투약에 대한 정보를 제공하는 업무를 수행합니다.\n\n처방전을 검토하고 약을 조제합니다.\n\n약의 용법, 용량, 부작용 등에 대해 환자에게 설명... 기반으로 50로 평가","stability":"stability는 약사 및 한약사는 환자에게 약을 조제하고 투약에 대한 정보를 제공하는 업무를 수행합니다.\n\n처방전을 검토하고 약을 조제합니다.\n\n약의 용법, 용량, 부작용 등에 대해 환자에게 설명... 기반으로 50로 평가","income":"income는 약사 및 한약사는 환자에게 약을 조제하고 투약에 대한 정보를 제공하는 업무를 수행합니다.\n\n처방전을 검토하고 약을 조제합니다.\n\n약의 용법, 용량, 부작용 등에 대해 환자에게 설명... 기반으로 70로 평가","teamwork":"teamwork는 약사 및 한약사는 환자에게 약을 조제하고 투약에 대한 정보를 제공하는 업무를 수행합니다.\n\n처방전을 검토하고 약을 조제합니다.\n\n약의 용법, 용량, 부작용 등에 대해 환자에게 설명... 기반으로 50로 평가","solo_deep":"solo_deep는 약사 및 한약사는 환자에게 약을 조제하고 투약에 대한 정보를 제공하는 업무를 수행합니다.\n\n처방전을 검토하고 약을 조제합니다.\n\n약의 용법, 용량, 부작용 등에 대해 환자에게 설명... 기반으로 50로 평가","analytical":"analytical는 약사 및 한약사는 환자에게 약을 조제하고 투약에 대한 정보를 제공하는 업무를 수행합니다.\n\n처방전을 검토하고 약을 조제합니다.\n\n약의 용법, 용량, 부작용 등에 대해 환자에게 설명... 기반으로 40로 평가","creative":"creative는 약사 및 한약사는 환자에게 약을 조제하고 투약에 대한 정보를 제공하는 업무를 수행합니다.\n\n처방전을 검토하고 약을 조제합니다.\n\n약의 용법, 용량, 부작용 등에 대해 환자에게 설명... 기반으로 40로 평가","execution":"execution는 약사 및 한약사는 환자에게 약을 조제하고 투약에 대한 정보를 제공하는 업무를 수행합니다.\n\n처방전을 검토하고 약을 조제합니다.\n\n약의 용법, 용량, 부작용 등에 대해 환자에게 설명... 기반으로 70로 평가","people_facing":"people_facing는 약사 및 한약사는 환자에게 약을 조제하고 투약에 대한 정보를 제공하는 업무를 수행합니다.\n\n처방전을 검토하고 약을 조제합니다.\n\n약의 용법, 용량, 부작용 등에 대해 환자에게 설명... 기반으로 50로 평가","degree_required":"degree_required는 약사 및 한약사는 환자에게 약을 조제하고 투약에 대한 정보를 제공하는 업무를 수행합니다.\n\n처방전을 검토하고 약을 조제합니다.\n\n약의 용법, 용량, 부작용 등에 대해 환자에게 설명... 기반으로 none로 평가","license_required":"license_required는 약사 및 한약사는 환자에게 약을 조제하고 투약에 대한 정보를 제공하는 업무를 수행합니다.\n\n처방전을 검토하고 약을 조제합니다.\n\n약의 용법, 용량, 부작용 등에 대해 환자에게 설명... 기반으로 none로 평가"}'
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
  '1765283381176636',
  '초등학교교사',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 75, 50, 50,
  50, 50, 50, 50, 50, 75,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 초등학교교사는 초등학생을 대상으로 교육과정을 계획하고 실행하는 업무를 수행합니다.\n\n교육과정을 계획하고 수업을 진행합니다.\n\n학생들의 학습 진도를 평가하고 지도합니다.\n\n학생들의 ... 기반으로 50로 평가","growth":"growth는 초등학교교사는 초등학생을 대상으로 교육과정을 계획하고 실행하는 업무를 수행합니다.\n\n교육과정을 계획하고 수업을 진행합니다.\n\n학생들의 학습 진도를 평가하고 지도합니다.\n\n학생들의 ... 기반으로 75로 평가","stability":"stability는 초등학교교사는 초등학생을 대상으로 교육과정을 계획하고 실행하는 업무를 수행합니다.\n\n교육과정을 계획하고 수업을 진행합니다.\n\n학생들의 학습 진도를 평가하고 지도합니다.\n\n학생들의 ... 기반으로 50로 평가","income":"income는 초등학교교사는 초등학생을 대상으로 교육과정을 계획하고 실행하는 업무를 수행합니다.\n\n교육과정을 계획하고 수업을 진행합니다.\n\n학생들의 학습 진도를 평가하고 지도합니다.\n\n학생들의 ... 기반으로 50로 평가","teamwork":"teamwork는 초등학교교사는 초등학생을 대상으로 교육과정을 계획하고 실행하는 업무를 수행합니다.\n\n교육과정을 계획하고 수업을 진행합니다.\n\n학생들의 학습 진도를 평가하고 지도합니다.\n\n학생들의 ... 기반으로 50로 평가","solo_deep":"solo_deep는 초등학교교사는 초등학생을 대상으로 교육과정을 계획하고 실행하는 업무를 수행합니다.\n\n교육과정을 계획하고 수업을 진행합니다.\n\n학생들의 학습 진도를 평가하고 지도합니다.\n\n학생들의 ... 기반으로 50로 평가","analytical":"analytical는 초등학교교사는 초등학생을 대상으로 교육과정을 계획하고 실행하는 업무를 수행합니다.\n\n교육과정을 계획하고 수업을 진행합니다.\n\n학생들의 학습 진도를 평가하고 지도합니다.\n\n학생들의 ... 기반으로 50로 평가","creative":"creative는 초등학교교사는 초등학생을 대상으로 교육과정을 계획하고 실행하는 업무를 수행합니다.\n\n교육과정을 계획하고 수업을 진행합니다.\n\n학생들의 학습 진도를 평가하고 지도합니다.\n\n학생들의 ... 기반으로 50로 평가","execution":"execution는 초등학교교사는 초등학생을 대상으로 교육과정을 계획하고 실행하는 업무를 수행합니다.\n\n교육과정을 계획하고 수업을 진행합니다.\n\n학생들의 학습 진도를 평가하고 지도합니다.\n\n학생들의 ... 기반으로 50로 평가","people_facing":"people_facing는 초등학교교사는 초등학생을 대상으로 교육과정을 계획하고 실행하는 업무를 수행합니다.\n\n교육과정을 계획하고 수업을 진행합니다.\n\n학생들의 학습 진도를 평가하고 지도합니다.\n\n학생들의 ... 기반으로 75로 평가","degree_required":"degree_required는 초등학교교사는 초등학생을 대상으로 교육과정을 계획하고 실행하는 업무를 수행합니다.\n\n교육과정을 계획하고 수업을 진행합니다.\n\n학생들의 학습 진도를 평가하고 지도합니다.\n\n학생들의 ... 기반으로 none로 평가","license_required":"license_required는 초등학교교사는 초등학생을 대상으로 교육과정을 계획하고 실행하는 업무를 수행합니다.\n\n교육과정을 계획하고 수업을 진행합니다.\n\n학생들의 학습 진도를 평가하고 지도합니다.\n\n학생들의 ... 기반으로 none로 평가"}'
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
  '1765283333584615',
  '시각디자이너',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 50, 40,
  50, 50, 50, 50, 50, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 시각디자이너는 시각적 요소를 활용하여 정보를 효과적으로 전달하는 디자인을 기획하고 제작하는 업무를 수행합니다.\n\n클라이언트의 요구사항을 분석하여 디자인 콘셉트를 기획합니다.\n\n포스... 기반으로 50로 평가","growth":"growth는 시각디자이너는 시각적 요소를 활용하여 정보를 효과적으로 전달하는 디자인을 기획하고 제작하는 업무를 수행합니다.\n\n클라이언트의 요구사항을 분석하여 디자인 콘셉트를 기획합니다.\n\n포스... 기반으로 65로 평가","stability":"stability는 시각디자이너는 시각적 요소를 활용하여 정보를 효과적으로 전달하는 디자인을 기획하고 제작하는 업무를 수행합니다.\n\n클라이언트의 요구사항을 분석하여 디자인 콘셉트를 기획합니다.\n\n포스... 기반으로 50로 평가","income":"income는 시각디자이너는 시각적 요소를 활용하여 정보를 효과적으로 전달하는 디자인을 기획하고 제작하는 업무를 수행합니다.\n\n클라이언트의 요구사항을 분석하여 디자인 콘셉트를 기획합니다.\n\n포스... 기반으로 40로 평가","teamwork":"teamwork는 시각디자이너는 시각적 요소를 활용하여 정보를 효과적으로 전달하는 디자인을 기획하고 제작하는 업무를 수행합니다.\n\n클라이언트의 요구사항을 분석하여 디자인 콘셉트를 기획합니다.\n\n포스... 기반으로 50로 평가","solo_deep":"solo_deep는 시각디자이너는 시각적 요소를 활용하여 정보를 효과적으로 전달하는 디자인을 기획하고 제작하는 업무를 수행합니다.\n\n클라이언트의 요구사항을 분석하여 디자인 콘셉트를 기획합니다.\n\n포스... 기반으로 50로 평가","analytical":"analytical는 시각디자이너는 시각적 요소를 활용하여 정보를 효과적으로 전달하는 디자인을 기획하고 제작하는 업무를 수행합니다.\n\n클라이언트의 요구사항을 분석하여 디자인 콘셉트를 기획합니다.\n\n포스... 기반으로 50로 평가","creative":"creative는 시각디자이너는 시각적 요소를 활용하여 정보를 효과적으로 전달하는 디자인을 기획하고 제작하는 업무를 수행합니다.\n\n클라이언트의 요구사항을 분석하여 디자인 콘셉트를 기획합니다.\n\n포스... 기반으로 50로 평가","execution":"execution는 시각디자이너는 시각적 요소를 활용하여 정보를 효과적으로 전달하는 디자인을 기획하고 제작하는 업무를 수행합니다.\n\n클라이언트의 요구사항을 분석하여 디자인 콘셉트를 기획합니다.\n\n포스... 기반으로 50로 평가","people_facing":"people_facing는 시각디자이너는 시각적 요소를 활용하여 정보를 효과적으로 전달하는 디자인을 기획하고 제작하는 업무를 수행합니다.\n\n클라이언트의 요구사항을 분석하여 디자인 콘셉트를 기획합니다.\n\n포스... 기반으로 50로 평가","degree_required":"degree_required는 시각디자이너는 시각적 요소를 활용하여 정보를 효과적으로 전달하는 디자인을 기획하고 제작하는 업무를 수행합니다.\n\n클라이언트의 요구사항을 분석하여 디자인 콘셉트를 기획합니다.\n\n포스... 기반으로 none로 평가","license_required":"license_required는 시각디자이너는 시각적 요소를 활용하여 정보를 효과적으로 전달하는 디자인을 기획하고 제작하는 업무를 수행합니다.\n\n클라이언트의 요구사항을 분석하여 디자인 콘셉트를 기획합니다.\n\n포스... 기반으로 none로 평가"}'
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
  '176528335290888',
  '음반기획자',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 50, 40,
  50, 50, 50, 50, 50, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 음반기획자는 음악 작품의 기획, 제작, 유통을 담당하는 업무를 수행합니다.\n\n음악 작품의 콘셉트를 기획하고 아티스트를 섭외합니다.\n\n녹음, 믹싱, 마스터링 등의 제작 과정을 감독합... 기반으로 50로 평가","growth":"growth는 음반기획자는 음악 작품의 기획, 제작, 유통을 담당하는 업무를 수행합니다.\n\n음악 작품의 콘셉트를 기획하고 아티스트를 섭외합니다.\n\n녹음, 믹싱, 마스터링 등의 제작 과정을 감독합... 기반으로 65로 평가","stability":"stability는 음반기획자는 음악 작품의 기획, 제작, 유통을 담당하는 업무를 수행합니다.\n\n음악 작품의 콘셉트를 기획하고 아티스트를 섭외합니다.\n\n녹음, 믹싱, 마스터링 등의 제작 과정을 감독합... 기반으로 50로 평가","income":"income는 음반기획자는 음악 작품의 기획, 제작, 유통을 담당하는 업무를 수행합니다.\n\n음악 작품의 콘셉트를 기획하고 아티스트를 섭외합니다.\n\n녹음, 믹싱, 마스터링 등의 제작 과정을 감독합... 기반으로 40로 평가","teamwork":"teamwork는 음반기획자는 음악 작품의 기획, 제작, 유통을 담당하는 업무를 수행합니다.\n\n음악 작품의 콘셉트를 기획하고 아티스트를 섭외합니다.\n\n녹음, 믹싱, 마스터링 등의 제작 과정을 감독합... 기반으로 50로 평가","solo_deep":"solo_deep는 음반기획자는 음악 작품의 기획, 제작, 유통을 담당하는 업무를 수행합니다.\n\n음악 작품의 콘셉트를 기획하고 아티스트를 섭외합니다.\n\n녹음, 믹싱, 마스터링 등의 제작 과정을 감독합... 기반으로 50로 평가","analytical":"analytical는 음반기획자는 음악 작품의 기획, 제작, 유통을 담당하는 업무를 수행합니다.\n\n음악 작품의 콘셉트를 기획하고 아티스트를 섭외합니다.\n\n녹음, 믹싱, 마스터링 등의 제작 과정을 감독합... 기반으로 50로 평가","creative":"creative는 음반기획자는 음악 작품의 기획, 제작, 유통을 담당하는 업무를 수행합니다.\n\n음악 작품의 콘셉트를 기획하고 아티스트를 섭외합니다.\n\n녹음, 믹싱, 마스터링 등의 제작 과정을 감독합... 기반으로 50로 평가","execution":"execution는 음반기획자는 음악 작품의 기획, 제작, 유통을 담당하는 업무를 수행합니다.\n\n음악 작품의 콘셉트를 기획하고 아티스트를 섭외합니다.\n\n녹음, 믹싱, 마스터링 등의 제작 과정을 감독합... 기반으로 50로 평가","people_facing":"people_facing는 음반기획자는 음악 작품의 기획, 제작, 유통을 담당하는 업무를 수행합니다.\n\n음악 작품의 콘셉트를 기획하고 아티스트를 섭외합니다.\n\n녹음, 믹싱, 마스터링 등의 제작 과정을 감독합... 기반으로 50로 평가","degree_required":"degree_required는 음반기획자는 음악 작품의 기획, 제작, 유통을 담당하는 업무를 수행합니다.\n\n음악 작품의 콘셉트를 기획하고 아티스트를 섭외합니다.\n\n녹음, 믹싱, 마스터링 등의 제작 과정을 감독합... 기반으로 none로 평가","license_required":"license_required는 음반기획자는 음악 작품의 기획, 제작, 유통을 담당하는 업무를 수행합니다.\n\n음악 작품의 콘셉트를 기획하고 아티스트를 섭외합니다.\n\n녹음, 믹싱, 마스터링 등의 제작 과정을 감독합... 기반으로 none로 평가"}'
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
  '1765283344289283',
  '연예인매니저',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 30, 50,
  50, 50, 30, 60, 60, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 연예인매니저는 연예인의 활동을 기획하고 관리하는 업무를 수행합니다.\n\n연예인의 스케줄을 관리하고 일정을 조율합니다.\n\n연예인의 이미지 관리를 담당합니다.\n\n연예인의 활동을 위한 계... 기반으로 50로 평가","growth":"growth는 연예인매니저는 연예인의 활동을 기획하고 관리하는 업무를 수행합니다.\n\n연예인의 스케줄을 관리하고 일정을 조율합니다.\n\n연예인의 이미지 관리를 담당합니다.\n\n연예인의 활동을 위한 계... 기반으로 65로 평가","stability":"stability는 연예인매니저는 연예인의 활동을 기획하고 관리하는 업무를 수행합니다.\n\n연예인의 스케줄을 관리하고 일정을 조율합니다.\n\n연예인의 이미지 관리를 담당합니다.\n\n연예인의 활동을 위한 계... 기반으로 30로 평가","income":"income는 연예인매니저는 연예인의 활동을 기획하고 관리하는 업무를 수행합니다.\n\n연예인의 스케줄을 관리하고 일정을 조율합니다.\n\n연예인의 이미지 관리를 담당합니다.\n\n연예인의 활동을 위한 계... 기반으로 50로 평가","teamwork":"teamwork는 연예인매니저는 연예인의 활동을 기획하고 관리하는 업무를 수행합니다.\n\n연예인의 스케줄을 관리하고 일정을 조율합니다.\n\n연예인의 이미지 관리를 담당합니다.\n\n연예인의 활동을 위한 계... 기반으로 50로 평가","solo_deep":"solo_deep는 연예인매니저는 연예인의 활동을 기획하고 관리하는 업무를 수행합니다.\n\n연예인의 스케줄을 관리하고 일정을 조율합니다.\n\n연예인의 이미지 관리를 담당합니다.\n\n연예인의 활동을 위한 계... 기반으로 50로 평가","analytical":"analytical는 연예인매니저는 연예인의 활동을 기획하고 관리하는 업무를 수행합니다.\n\n연예인의 스케줄을 관리하고 일정을 조율합니다.\n\n연예인의 이미지 관리를 담당합니다.\n\n연예인의 활동을 위한 계... 기반으로 30로 평가","creative":"creative는 연예인매니저는 연예인의 활동을 기획하고 관리하는 업무를 수행합니다.\n\n연예인의 스케줄을 관리하고 일정을 조율합니다.\n\n연예인의 이미지 관리를 담당합니다.\n\n연예인의 활동을 위한 계... 기반으로 60로 평가","execution":"execution는 연예인매니저는 연예인의 활동을 기획하고 관리하는 업무를 수행합니다.\n\n연예인의 스케줄을 관리하고 일정을 조율합니다.\n\n연예인의 이미지 관리를 담당합니다.\n\n연예인의 활동을 위한 계... 기반으로 60로 평가","people_facing":"people_facing는 연예인매니저는 연예인의 활동을 기획하고 관리하는 업무를 수행합니다.\n\n연예인의 스케줄을 관리하고 일정을 조율합니다.\n\n연예인의 이미지 관리를 담당합니다.\n\n연예인의 활동을 위한 계... 기반으로 50로 평가","degree_required":"degree_required는 연예인매니저는 연예인의 활동을 기획하고 관리하는 업무를 수행합니다.\n\n연예인의 스케줄을 관리하고 일정을 조율합니다.\n\n연예인의 이미지 관리를 담당합니다.\n\n연예인의 활동을 위한 계... 기반으로 none로 평가","license_required":"license_required는 연예인매니저는 연예인의 활동을 기획하고 관리하는 업무를 수행합니다.\n\n연예인의 스케줄을 관리하고 일정을 조율합니다.\n\n연예인의 이미지 관리를 담당합니다.\n\n연예인의 활동을 위한 계... 기반으로 none로 평가"}'
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