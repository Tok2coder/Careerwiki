-- Batch tagging SQL generated at 2026-01-06T06:02:05.101Z
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
  '1765283278683691',
  '가스ㆍ수도ㆍ전기 계기 검침원 및 안전점검원',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  40, 50, 50, 50,
  50, 50, 50, 50, 50, 50,
  'overtime_some', 'none', 'frequent', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 가스·수도·전기 계기 검침원 및 안전점검원은 정기적으로 담당 가구나 업소에 방문해서 가스, 수도, 전력 사용량을 검침하고 기록하는 업무를 수행합니다.\n\n가스, 수도, 전력 등의 사... 기반으로 40로 평가","growth":"growth는 가스·수도·전기 계기 검침원 및 안전점검원은 정기적으로 담당 가구나 업소에 방문해서 가스, 수도, 전력 사용량을 검침하고 기록하는 업무를 수행합니다.\n\n가스, 수도, 전력 등의 사... 기반으로 50로 평가","stability":"stability는 가스·수도·전기 계기 검침원 및 안전점검원은 정기적으로 담당 가구나 업소에 방문해서 가스, 수도, 전력 사용량을 검침하고 기록하는 업무를 수행합니다.\n\n가스, 수도, 전력 등의 사... 기반으로 50로 평가","income":"income는 가스·수도·전기 계기 검침원 및 안전점검원은 정기적으로 담당 가구나 업소에 방문해서 가스, 수도, 전력 사용량을 검침하고 기록하는 업무를 수행합니다.\n\n가스, 수도, 전력 등의 사... 기반으로 50로 평가","teamwork":"teamwork는 가스·수도·전기 계기 검침원 및 안전점검원은 정기적으로 담당 가구나 업소에 방문해서 가스, 수도, 전력 사용량을 검침하고 기록하는 업무를 수행합니다.\n\n가스, 수도, 전력 등의 사... 기반으로 50로 평가","solo_deep":"solo_deep는 가스·수도·전기 계기 검침원 및 안전점검원은 정기적으로 담당 가구나 업소에 방문해서 가스, 수도, 전력 사용량을 검침하고 기록하는 업무를 수행합니다.\n\n가스, 수도, 전력 등의 사... 기반으로 50로 평가","analytical":"analytical는 가스·수도·전기 계기 검침원 및 안전점검원은 정기적으로 담당 가구나 업소에 방문해서 가스, 수도, 전력 사용량을 검침하고 기록하는 업무를 수행합니다.\n\n가스, 수도, 전력 등의 사... 기반으로 50로 평가","creative":"creative는 가스·수도·전기 계기 검침원 및 안전점검원은 정기적으로 담당 가구나 업소에 방문해서 가스, 수도, 전력 사용량을 검침하고 기록하는 업무를 수행합니다.\n\n가스, 수도, 전력 등의 사... 기반으로 50로 평가","execution":"execution는 가스·수도·전기 계기 검침원 및 안전점검원은 정기적으로 담당 가구나 업소에 방문해서 가스, 수도, 전력 사용량을 검침하고 기록하는 업무를 수행합니다.\n\n가스, 수도, 전력 등의 사... 기반으로 50로 평가","people_facing":"people_facing는 가스·수도·전기 계기 검침원 및 안전점검원은 정기적으로 담당 가구나 업소에 방문해서 가스, 수도, 전력 사용량을 검침하고 기록하는 업무를 수행합니다.\n\n가스, 수도, 전력 등의 사... 기반으로 50로 평가","degree_required":"degree_required는 가스·수도·전기 계기 검침원 및 안전점검원은 정기적으로 담당 가구나 업소에 방문해서 가스, 수도, 전력 사용량을 검침하고 기록하는 업무를 수행합니다.\n\n가스, 수도, 전력 등의 사... 기반으로 none로 평가","license_required":"license_required는 가스·수도·전기 계기 검침원 및 안전점검원은 정기적으로 담당 가구나 업소에 방문해서 가스, 수도, 전력 사용량을 검침하고 기록하는 업무를 수행합니다.\n\n가스, 수도, 전력 등의 사... 기반으로 none로 평가"}'
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
  '1765283311344239',
  '방사선사',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 70,
  50, 50, 40, 40, 70, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 방사선사는 방사선을 이용하여 환자의 진단을 위한 영상을 촬영하고, 치료를 위한 방사선 치료를 실시하는 업무를 수행합니다.\n\n환자의 진단을 위해 x선, ct, mri 등의 방사선 영... 기반으로 50로 평가","growth":"growth는 방사선사는 방사선을 이용하여 환자의 진단을 위한 영상을 촬영하고, 치료를 위한 방사선 치료를 실시하는 업무를 수행합니다.\n\n환자의 진단을 위해 x선, ct, mri 등의 방사선 영... 기반으로 50로 평가","stability":"stability는 방사선사는 방사선을 이용하여 환자의 진단을 위한 영상을 촬영하고, 치료를 위한 방사선 치료를 실시하는 업무를 수행합니다.\n\n환자의 진단을 위해 x선, ct, mri 등의 방사선 영... 기반으로 50로 평가","income":"income는 방사선사는 방사선을 이용하여 환자의 진단을 위한 영상을 촬영하고, 치료를 위한 방사선 치료를 실시하는 업무를 수행합니다.\n\n환자의 진단을 위해 x선, ct, mri 등의 방사선 영... 기반으로 70로 평가","teamwork":"teamwork는 방사선사는 방사선을 이용하여 환자의 진단을 위한 영상을 촬영하고, 치료를 위한 방사선 치료를 실시하는 업무를 수행합니다.\n\n환자의 진단을 위해 x선, ct, mri 등의 방사선 영... 기반으로 50로 평가","solo_deep":"solo_deep는 방사선사는 방사선을 이용하여 환자의 진단을 위한 영상을 촬영하고, 치료를 위한 방사선 치료를 실시하는 업무를 수행합니다.\n\n환자의 진단을 위해 x선, ct, mri 등의 방사선 영... 기반으로 50로 평가","analytical":"analytical는 방사선사는 방사선을 이용하여 환자의 진단을 위한 영상을 촬영하고, 치료를 위한 방사선 치료를 실시하는 업무를 수행합니다.\n\n환자의 진단을 위해 x선, ct, mri 등의 방사선 영... 기반으로 40로 평가","creative":"creative는 방사선사는 방사선을 이용하여 환자의 진단을 위한 영상을 촬영하고, 치료를 위한 방사선 치료를 실시하는 업무를 수행합니다.\n\n환자의 진단을 위해 x선, ct, mri 등의 방사선 영... 기반으로 40로 평가","execution":"execution는 방사선사는 방사선을 이용하여 환자의 진단을 위한 영상을 촬영하고, 치료를 위한 방사선 치료를 실시하는 업무를 수행합니다.\n\n환자의 진단을 위해 x선, ct, mri 등의 방사선 영... 기반으로 70로 평가","people_facing":"people_facing는 방사선사는 방사선을 이용하여 환자의 진단을 위한 영상을 촬영하고, 치료를 위한 방사선 치료를 실시하는 업무를 수행합니다.\n\n환자의 진단을 위해 x선, ct, mri 등의 방사선 영... 기반으로 50로 평가","degree_required":"degree_required는 방사선사는 방사선을 이용하여 환자의 진단을 위한 영상을 촬영하고, 치료를 위한 방사선 치료를 실시하는 업무를 수행합니다.\n\n환자의 진단을 위해 x선, ct, mri 등의 방사선 영... 기반으로 none로 평가","license_required":"license_required는 방사선사는 방사선을 이용하여 환자의 진단을 위한 영상을 촬영하고, 치료를 위한 방사선 치료를 실시하는 업무를 수행합니다.\n\n환자의 진단을 위해 x선, ct, mri 등의 방사선 영... 기반으로 none로 평가"}'
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
  '1765283339918805',
  '압연원',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  50, 50, 40, 40, 70, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 압연원은 금속을 가열하여 압연기를 이용해 얇게 펴거나 특정 형상으로 만드는 업무를 수행합니다.\n\n금속 재료를 압연기에 넣기 전에 가열합니다.\n\n압연기의 속도와 압력을 조절하여 금속... 기반으로 50로 평가","growth":"growth는 압연원은 금속을 가열하여 압연기를 이용해 얇게 펴거나 특정 형상으로 만드는 업무를 수행합니다.\n\n금속 재료를 압연기에 넣기 전에 가열합니다.\n\n압연기의 속도와 압력을 조절하여 금속... 기반으로 50로 평가","stability":"stability는 압연원은 금속을 가열하여 압연기를 이용해 얇게 펴거나 특정 형상으로 만드는 업무를 수행합니다.\n\n금속 재료를 압연기에 넣기 전에 가열합니다.\n\n압연기의 속도와 압력을 조절하여 금속... 기반으로 50로 평가","income":"income는 압연원은 금속을 가열하여 압연기를 이용해 얇게 펴거나 특정 형상으로 만드는 업무를 수행합니다.\n\n금속 재료를 압연기에 넣기 전에 가열합니다.\n\n압연기의 속도와 압력을 조절하여 금속... 기반으로 50로 평가","teamwork":"teamwork는 압연원은 금속을 가열하여 압연기를 이용해 얇게 펴거나 특정 형상으로 만드는 업무를 수행합니다.\n\n금속 재료를 압연기에 넣기 전에 가열합니다.\n\n압연기의 속도와 압력을 조절하여 금속... 기반으로 50로 평가","solo_deep":"solo_deep는 압연원은 금속을 가열하여 압연기를 이용해 얇게 펴거나 특정 형상으로 만드는 업무를 수행합니다.\n\n금속 재료를 압연기에 넣기 전에 가열합니다.\n\n압연기의 속도와 압력을 조절하여 금속... 기반으로 50로 평가","analytical":"analytical는 압연원은 금속을 가열하여 압연기를 이용해 얇게 펴거나 특정 형상으로 만드는 업무를 수행합니다.\n\n금속 재료를 압연기에 넣기 전에 가열합니다.\n\n압연기의 속도와 압력을 조절하여 금속... 기반으로 40로 평가","creative":"creative는 압연원은 금속을 가열하여 압연기를 이용해 얇게 펴거나 특정 형상으로 만드는 업무를 수행합니다.\n\n금속 재료를 압연기에 넣기 전에 가열합니다.\n\n압연기의 속도와 압력을 조절하여 금속... 기반으로 40로 평가","execution":"execution는 압연원은 금속을 가열하여 압연기를 이용해 얇게 펴거나 특정 형상으로 만드는 업무를 수행합니다.\n\n금속 재료를 압연기에 넣기 전에 가열합니다.\n\n압연기의 속도와 압력을 조절하여 금속... 기반으로 70로 평가","people_facing":"people_facing는 압연원은 금속을 가열하여 압연기를 이용해 얇게 펴거나 특정 형상으로 만드는 업무를 수행합니다.\n\n금속 재료를 압연기에 넣기 전에 가열합니다.\n\n압연기의 속도와 압력을 조절하여 금속... 기반으로 50로 평가","degree_required":"degree_required는 압연원은 금속을 가열하여 압연기를 이용해 얇게 펴거나 특정 형상으로 만드는 업무를 수행합니다.\n\n금속 재료를 압연기에 넣기 전에 가열합니다.\n\n압연기의 속도와 압력을 조절하여 금속... 기반으로 none로 평가","license_required":"license_required는 압연원은 금속을 가열하여 압연기를 이용해 얇게 펴거나 특정 형상으로 만드는 업무를 수행합니다.\n\n금속 재료를 압연기에 넣기 전에 가열합니다.\n\n압연기의 속도와 압력을 조절하여 금속... 기반으로 none로 평가"}'
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
  '1765283404065979',
  '환경설비기술자',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 85, 65, 80,
  50, 50, 40, 40, 70, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 환경설비기술자는 대기, 수질, 폐기물 등의 환경 오염을 방지하기 위한 설비를 설계, 설치, 운영하는 업무를 수행합니다.\n\n환경 오염 방지 설비의 설계도를 작성합니다.\n\n환경설비의 ... 기반으로 50로 평가","growth":"growth는 환경설비기술자는 대기, 수질, 폐기물 등의 환경 오염을 방지하기 위한 설비를 설계, 설치, 운영하는 업무를 수행합니다.\n\n환경 오염 방지 설비의 설계도를 작성합니다.\n\n환경설비의 ... 기반으로 85로 평가","stability":"stability는 환경설비기술자는 대기, 수질, 폐기물 등의 환경 오염을 방지하기 위한 설비를 설계, 설치, 운영하는 업무를 수행합니다.\n\n환경 오염 방지 설비의 설계도를 작성합니다.\n\n환경설비의 ... 기반으로 65로 평가","income":"income는 환경설비기술자는 대기, 수질, 폐기물 등의 환경 오염을 방지하기 위한 설비를 설계, 설치, 운영하는 업무를 수행합니다.\n\n환경 오염 방지 설비의 설계도를 작성합니다.\n\n환경설비의 ... 기반으로 80로 평가","teamwork":"teamwork는 환경설비기술자는 대기, 수질, 폐기물 등의 환경 오염을 방지하기 위한 설비를 설계, 설치, 운영하는 업무를 수행합니다.\n\n환경 오염 방지 설비의 설계도를 작성합니다.\n\n환경설비의 ... 기반으로 50로 평가","solo_deep":"solo_deep는 환경설비기술자는 대기, 수질, 폐기물 등의 환경 오염을 방지하기 위한 설비를 설계, 설치, 운영하는 업무를 수행합니다.\n\n환경 오염 방지 설비의 설계도를 작성합니다.\n\n환경설비의 ... 기반으로 50로 평가","analytical":"analytical는 환경설비기술자는 대기, 수질, 폐기물 등의 환경 오염을 방지하기 위한 설비를 설계, 설치, 운영하는 업무를 수행합니다.\n\n환경 오염 방지 설비의 설계도를 작성합니다.\n\n환경설비의 ... 기반으로 40로 평가","creative":"creative는 환경설비기술자는 대기, 수질, 폐기물 등의 환경 오염을 방지하기 위한 설비를 설계, 설치, 운영하는 업무를 수행합니다.\n\n환경 오염 방지 설비의 설계도를 작성합니다.\n\n환경설비의 ... 기반으로 40로 평가","execution":"execution는 환경설비기술자는 대기, 수질, 폐기물 등의 환경 오염을 방지하기 위한 설비를 설계, 설치, 운영하는 업무를 수행합니다.\n\n환경 오염 방지 설비의 설계도를 작성합니다.\n\n환경설비의 ... 기반으로 70로 평가","people_facing":"people_facing는 환경설비기술자는 대기, 수질, 폐기물 등의 환경 오염을 방지하기 위한 설비를 설계, 설치, 운영하는 업무를 수행합니다.\n\n환경 오염 방지 설비의 설계도를 작성합니다.\n\n환경설비의 ... 기반으로 50로 평가","degree_required":"degree_required는 환경설비기술자는 대기, 수질, 폐기물 등의 환경 오염을 방지하기 위한 설비를 설계, 설치, 운영하는 업무를 수행합니다.\n\n환경 오염 방지 설비의 설계도를 작성합니다.\n\n환경설비의 ... 기반으로 none로 평가","license_required":"license_required는 환경설비기술자는 대기, 수질, 폐기물 등의 환경 오염을 방지하기 위한 설비를 설계, 설치, 운영하는 업무를 수행합니다.\n\n환경 오염 방지 설비의 설계도를 작성합니다.\n\n환경설비의 ... 기반으로 none로 평가"}'
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

COMMIT;