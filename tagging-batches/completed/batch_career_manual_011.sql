-- Batch tagging SQL generated at 2026-01-06T06:22:01.189Z
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
  '1765283377334662',
  '지질학연구원',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  40, 65, 50, 70,
  50, 50, 70, 40, 40, 35,
  'overtime_some', 'none', 'some', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 지질학연구원은 지구의 구성 물질과 구조를 연구하는 업무를 수행합니다.\n\n지질 현장을 조사합니다.\n\n암석과 광물 샘플을 수집합니다.\n\n지질 데이터를 분석합니다.\n\n지질도를 작성합니다... 기반으로 40로 평가","growth":"growth는 지질학연구원은 지구의 구성 물질과 구조를 연구하는 업무를 수행합니다.\n\n지질 현장을 조사합니다.\n\n암석과 광물 샘플을 수집합니다.\n\n지질 데이터를 분석합니다.\n\n지질도를 작성합니다... 기반으로 65로 평가","stability":"stability는 지질학연구원은 지구의 구성 물질과 구조를 연구하는 업무를 수행합니다.\n\n지질 현장을 조사합니다.\n\n암석과 광물 샘플을 수집합니다.\n\n지질 데이터를 분석합니다.\n\n지질도를 작성합니다... 기반으로 50로 평가","income":"income는 지질학연구원은 지구의 구성 물질과 구조를 연구하는 업무를 수행합니다.\n\n지질 현장을 조사합니다.\n\n암석과 광물 샘플을 수집합니다.\n\n지질 데이터를 분석합니다.\n\n지질도를 작성합니다... 기반으로 70로 평가","teamwork":"teamwork는 지질학연구원은 지구의 구성 물질과 구조를 연구하는 업무를 수행합니다.\n\n지질 현장을 조사합니다.\n\n암석과 광물 샘플을 수집합니다.\n\n지질 데이터를 분석합니다.\n\n지질도를 작성합니다... 기반으로 50로 평가","solo_deep":"solo_deep는 지질학연구원은 지구의 구성 물질과 구조를 연구하는 업무를 수행합니다.\n\n지질 현장을 조사합니다.\n\n암석과 광물 샘플을 수집합니다.\n\n지질 데이터를 분석합니다.\n\n지질도를 작성합니다... 기반으로 50로 평가","analytical":"analytical는 지질학연구원은 지구의 구성 물질과 구조를 연구하는 업무를 수행합니다.\n\n지질 현장을 조사합니다.\n\n암석과 광물 샘플을 수집합니다.\n\n지질 데이터를 분석합니다.\n\n지질도를 작성합니다... 기반으로 70로 평가","creative":"creative는 지질학연구원은 지구의 구성 물질과 구조를 연구하는 업무를 수행합니다.\n\n지질 현장을 조사합니다.\n\n암석과 광물 샘플을 수집합니다.\n\n지질 데이터를 분석합니다.\n\n지질도를 작성합니다... 기반으로 40로 평가","execution":"execution는 지질학연구원은 지구의 구성 물질과 구조를 연구하는 업무를 수행합니다.\n\n지질 현장을 조사합니다.\n\n암석과 광물 샘플을 수집합니다.\n\n지질 데이터를 분석합니다.\n\n지질도를 작성합니다... 기반으로 40로 평가","people_facing":"people_facing는 지질학연구원은 지구의 구성 물질과 구조를 연구하는 업무를 수행합니다.\n\n지질 현장을 조사합니다.\n\n암석과 광물 샘플을 수집합니다.\n\n지질 데이터를 분석합니다.\n\n지질도를 작성합니다... 기반으로 35로 평가","degree_required":"degree_required는 지질학연구원은 지구의 구성 물질과 구조를 연구하는 업무를 수행합니다.\n\n지질 현장을 조사합니다.\n\n암석과 광물 샘플을 수집합니다.\n\n지질 데이터를 분석합니다.\n\n지질도를 작성합니다... 기반으로 none로 평가","license_required":"license_required는 지질학연구원은 지구의 구성 물질과 구조를 연구하는 업무를 수행합니다.\n\n지질 현장을 조사합니다.\n\n암석과 광물 샘플을 수집합니다.\n\n지질 데이터를 분석합니다.\n\n지질도를 작성합니다... 기반으로 none로 평가"}'
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
  '1765283358210803',
  '일반공무원',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 70, 50,
  50, 50, 50, 50, 50, 75,
  'regular', 'none', 'none', 'partial',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 일반공무원은 공공 기관에서 행정 업무를 수행하는 업무를 담당합니다.\n\n민원인을 응대합니다.\n\n서류를 접수하고 처리합니다.\n\n행정 절차를 안내합니다.\n\n공공 서비스를 제공합니다.\n\n... 기반으로 50로 평가","growth":"growth는 일반공무원은 공공 기관에서 행정 업무를 수행하는 업무를 담당합니다.\n\n민원인을 응대합니다.\n\n서류를 접수하고 처리합니다.\n\n행정 절차를 안내합니다.\n\n공공 서비스를 제공합니다.\n\n... 기반으로 50로 평가","stability":"stability는 일반공무원은 공공 기관에서 행정 업무를 수행하는 업무를 담당합니다.\n\n민원인을 응대합니다.\n\n서류를 접수하고 처리합니다.\n\n행정 절차를 안내합니다.\n\n공공 서비스를 제공합니다.\n\n... 기반으로 70로 평가","income":"income는 일반공무원은 공공 기관에서 행정 업무를 수행하는 업무를 담당합니다.\n\n민원인을 응대합니다.\n\n서류를 접수하고 처리합니다.\n\n행정 절차를 안내합니다.\n\n공공 서비스를 제공합니다.\n\n... 기반으로 50로 평가","teamwork":"teamwork는 일반공무원은 공공 기관에서 행정 업무를 수행하는 업무를 담당합니다.\n\n민원인을 응대합니다.\n\n서류를 접수하고 처리합니다.\n\n행정 절차를 안내합니다.\n\n공공 서비스를 제공합니다.\n\n... 기반으로 50로 평가","solo_deep":"solo_deep는 일반공무원은 공공 기관에서 행정 업무를 수행하는 업무를 담당합니다.\n\n민원인을 응대합니다.\n\n서류를 접수하고 처리합니다.\n\n행정 절차를 안내합니다.\n\n공공 서비스를 제공합니다.\n\n... 기반으로 50로 평가","analytical":"analytical는 일반공무원은 공공 기관에서 행정 업무를 수행하는 업무를 담당합니다.\n\n민원인을 응대합니다.\n\n서류를 접수하고 처리합니다.\n\n행정 절차를 안내합니다.\n\n공공 서비스를 제공합니다.\n\n... 기반으로 50로 평가","creative":"creative는 일반공무원은 공공 기관에서 행정 업무를 수행하는 업무를 담당합니다.\n\n민원인을 응대합니다.\n\n서류를 접수하고 처리합니다.\n\n행정 절차를 안내합니다.\n\n공공 서비스를 제공합니다.\n\n... 기반으로 50로 평가","execution":"execution는 일반공무원은 공공 기관에서 행정 업무를 수행하는 업무를 담당합니다.\n\n민원인을 응대합니다.\n\n서류를 접수하고 처리합니다.\n\n행정 절차를 안내합니다.\n\n공공 서비스를 제공합니다.\n\n... 기반으로 50로 평가","people_facing":"people_facing는 일반공무원은 공공 기관에서 행정 업무를 수행하는 업무를 담당합니다.\n\n민원인을 응대합니다.\n\n서류를 접수하고 처리합니다.\n\n행정 절차를 안내합니다.\n\n공공 서비스를 제공합니다.\n\n... 기반으로 75로 평가","degree_required":"degree_required는 일반공무원은 공공 기관에서 행정 업무를 수행하는 업무를 담당합니다.\n\n민원인을 응대합니다.\n\n서류를 접수하고 처리합니다.\n\n행정 절차를 안내합니다.\n\n공공 서비스를 제공합니다.\n\n... 기반으로 none로 평가","license_required":"license_required는 일반공무원은 공공 기관에서 행정 업무를 수행하는 업무를 담당합니다.\n\n민원인을 응대합니다.\n\n서류를 접수하고 처리합니다.\n\n행정 절차를 안내합니다.\n\n공공 서비스를 제공합니다.\n\n... 기반으로 none로 평가"}'
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
  '1765283355055753',
  '이공학계열교수',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 50, 50,
  50, 50, 70, 40, 40, 35,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 이공학계열교수는 대학에서 이공학 분야를 가르치는 업무를 수행합니다.\n\n강의를 준비하고 진행합니다.\n\n연구를 수행합니다.\n\n논문을 작성합니다.\n\n학생들을 지도합니다.\n\n학술 활동에 ... 기반으로 50로 평가","growth":"growth는 이공학계열교수는 대학에서 이공학 분야를 가르치는 업무를 수행합니다.\n\n강의를 준비하고 진행합니다.\n\n연구를 수행합니다.\n\n논문을 작성합니다.\n\n학생들을 지도합니다.\n\n학술 활동에 ... 기반으로 65로 평가","stability":"stability는 이공학계열교수는 대학에서 이공학 분야를 가르치는 업무를 수행합니다.\n\n강의를 준비하고 진행합니다.\n\n연구를 수행합니다.\n\n논문을 작성합니다.\n\n학생들을 지도합니다.\n\n학술 활동에 ... 기반으로 50로 평가","income":"income는 이공학계열교수는 대학에서 이공학 분야를 가르치는 업무를 수행합니다.\n\n강의를 준비하고 진행합니다.\n\n연구를 수행합니다.\n\n논문을 작성합니다.\n\n학생들을 지도합니다.\n\n학술 활동에 ... 기반으로 50로 평가","teamwork":"teamwork는 이공학계열교수는 대학에서 이공학 분야를 가르치는 업무를 수행합니다.\n\n강의를 준비하고 진행합니다.\n\n연구를 수행합니다.\n\n논문을 작성합니다.\n\n학생들을 지도합니다.\n\n학술 활동에 ... 기반으로 50로 평가","solo_deep":"solo_deep는 이공학계열교수는 대학에서 이공학 분야를 가르치는 업무를 수행합니다.\n\n강의를 준비하고 진행합니다.\n\n연구를 수행합니다.\n\n논문을 작성합니다.\n\n학생들을 지도합니다.\n\n학술 활동에 ... 기반으로 50로 평가","analytical":"analytical는 이공학계열교수는 대학에서 이공학 분야를 가르치는 업무를 수행합니다.\n\n강의를 준비하고 진행합니다.\n\n연구를 수행합니다.\n\n논문을 작성합니다.\n\n학생들을 지도합니다.\n\n학술 활동에 ... 기반으로 70로 평가","creative":"creative는 이공학계열교수는 대학에서 이공학 분야를 가르치는 업무를 수행합니다.\n\n강의를 준비하고 진행합니다.\n\n연구를 수행합니다.\n\n논문을 작성합니다.\n\n학생들을 지도합니다.\n\n학술 활동에 ... 기반으로 40로 평가","execution":"execution는 이공학계열교수는 대학에서 이공학 분야를 가르치는 업무를 수행합니다.\n\n강의를 준비하고 진행합니다.\n\n연구를 수행합니다.\n\n논문을 작성합니다.\n\n학생들을 지도합니다.\n\n학술 활동에 ... 기반으로 40로 평가","people_facing":"people_facing는 이공학계열교수는 대학에서 이공학 분야를 가르치는 업무를 수행합니다.\n\n강의를 준비하고 진행합니다.\n\n연구를 수행합니다.\n\n논문을 작성합니다.\n\n학생들을 지도합니다.\n\n학술 활동에 ... 기반으로 35로 평가","degree_required":"degree_required는 이공학계열교수는 대학에서 이공학 분야를 가르치는 업무를 수행합니다.\n\n강의를 준비하고 진행합니다.\n\n연구를 수행합니다.\n\n논문을 작성합니다.\n\n학생들을 지도합니다.\n\n학술 활동에 ... 기반으로 none로 평가","license_required":"license_required는 이공학계열교수는 대학에서 이공학 분야를 가르치는 업무를 수행합니다.\n\n강의를 준비하고 진행합니다.\n\n연구를 수행합니다.\n\n논문을 작성합니다.\n\n학생들을 지도합니다.\n\n학술 활동에 ... 기반으로 none로 평가"}'
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
  '1765283348245382',
  '운동경기심판',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 40,
  50, 50, 40, 40, 70, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 운동경기심판은 스포츠 경기에서 규칙 준수를 감독하는 업무를 수행합니다.\n\n경기 규칙을 적용합니다.\n\n선수들의 행동을 관찰합니다.\n\n위반 사항을 판단합니다.\n\n경기 진행을 관리합니다... 기반으로 50로 평가","growth":"growth는 운동경기심판은 스포츠 경기에서 규칙 준수를 감독하는 업무를 수행합니다.\n\n경기 규칙을 적용합니다.\n\n선수들의 행동을 관찰합니다.\n\n위반 사항을 판단합니다.\n\n경기 진행을 관리합니다... 기반으로 50로 평가","stability":"stability는 운동경기심판은 스포츠 경기에서 규칙 준수를 감독하는 업무를 수행합니다.\n\n경기 규칙을 적용합니다.\n\n선수들의 행동을 관찰합니다.\n\n위반 사항을 판단합니다.\n\n경기 진행을 관리합니다... 기반으로 50로 평가","income":"income는 운동경기심판은 스포츠 경기에서 규칙 준수를 감독하는 업무를 수행합니다.\n\n경기 규칙을 적용합니다.\n\n선수들의 행동을 관찰합니다.\n\n위반 사항을 판단합니다.\n\n경기 진행을 관리합니다... 기반으로 40로 평가","teamwork":"teamwork는 운동경기심판은 스포츠 경기에서 규칙 준수를 감독하는 업무를 수행합니다.\n\n경기 규칙을 적용합니다.\n\n선수들의 행동을 관찰합니다.\n\n위반 사항을 판단합니다.\n\n경기 진행을 관리합니다... 기반으로 50로 평가","solo_deep":"solo_deep는 운동경기심판은 스포츠 경기에서 규칙 준수를 감독하는 업무를 수행합니다.\n\n경기 규칙을 적용합니다.\n\n선수들의 행동을 관찰합니다.\n\n위반 사항을 판단합니다.\n\n경기 진행을 관리합니다... 기반으로 50로 평가","analytical":"analytical는 운동경기심판은 스포츠 경기에서 규칙 준수를 감독하는 업무를 수행합니다.\n\n경기 규칙을 적용합니다.\n\n선수들의 행동을 관찰합니다.\n\n위반 사항을 판단합니다.\n\n경기 진행을 관리합니다... 기반으로 40로 평가","creative":"creative는 운동경기심판은 스포츠 경기에서 규칙 준수를 감독하는 업무를 수행합니다.\n\n경기 규칙을 적용합니다.\n\n선수들의 행동을 관찰합니다.\n\n위반 사항을 판단합니다.\n\n경기 진행을 관리합니다... 기반으로 40로 평가","execution":"execution는 운동경기심판은 스포츠 경기에서 규칙 준수를 감독하는 업무를 수행합니다.\n\n경기 규칙을 적용합니다.\n\n선수들의 행동을 관찰합니다.\n\n위반 사항을 판단합니다.\n\n경기 진행을 관리합니다... 기반으로 70로 평가","people_facing":"people_facing는 운동경기심판은 스포츠 경기에서 규칙 준수를 감독하는 업무를 수행합니다.\n\n경기 규칙을 적용합니다.\n\n선수들의 행동을 관찰합니다.\n\n위반 사항을 판단합니다.\n\n경기 진행을 관리합니다... 기반으로 50로 평가","degree_required":"degree_required는 운동경기심판은 스포츠 경기에서 규칙 준수를 감독하는 업무를 수행합니다.\n\n경기 규칙을 적용합니다.\n\n선수들의 행동을 관찰합니다.\n\n위반 사항을 판단합니다.\n\n경기 진행을 관리합니다... 기반으로 none로 평가","license_required":"license_required는 운동경기심판은 스포츠 경기에서 규칙 준수를 감독하는 업무를 수행합니다.\n\n경기 규칙을 적용합니다.\n\n선수들의 행동을 관찰합니다.\n\n위반 사항을 판단합니다.\n\n경기 진행을 관리합니다... 기반으로 none로 평가"}'
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
  '1765283333034320',
  '스포츠트레이너',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 75, 50, 40,
  50, 50, 30, 60, 60, 35,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 스포츠트레이너는 운동선수의 체력과 기술 향상을 지원하는 업무를 수행합니다.\n\n훈련 프로그램을 개발합니다.\n\n체력 훈련을 지도합니다.\n\n부상 예방을 교육합니다.\n\n컨디션 관리를 담당... 기반으로 50로 평가","growth":"growth는 스포츠트레이너는 운동선수의 체력과 기술 향상을 지원하는 업무를 수행합니다.\n\n훈련 프로그램을 개발합니다.\n\n체력 훈련을 지도합니다.\n\n부상 예방을 교육합니다.\n\n컨디션 관리를 담당... 기반으로 75로 평가","stability":"stability는 스포츠트레이너는 운동선수의 체력과 기술 향상을 지원하는 업무를 수행합니다.\n\n훈련 프로그램을 개발합니다.\n\n체력 훈련을 지도합니다.\n\n부상 예방을 교육합니다.\n\n컨디션 관리를 담당... 기반으로 50로 평가","income":"income는 스포츠트레이너는 운동선수의 체력과 기술 향상을 지원하는 업무를 수행합니다.\n\n훈련 프로그램을 개발합니다.\n\n체력 훈련을 지도합니다.\n\n부상 예방을 교육합니다.\n\n컨디션 관리를 담당... 기반으로 40로 평가","teamwork":"teamwork는 스포츠트레이너는 운동선수의 체력과 기술 향상을 지원하는 업무를 수행합니다.\n\n훈련 프로그램을 개발합니다.\n\n체력 훈련을 지도합니다.\n\n부상 예방을 교육합니다.\n\n컨디션 관리를 담당... 기반으로 50로 평가","solo_deep":"solo_deep는 스포츠트레이너는 운동선수의 체력과 기술 향상을 지원하는 업무를 수행합니다.\n\n훈련 프로그램을 개발합니다.\n\n체력 훈련을 지도합니다.\n\n부상 예방을 교육합니다.\n\n컨디션 관리를 담당... 기반으로 50로 평가","analytical":"analytical는 스포츠트레이너는 운동선수의 체력과 기술 향상을 지원하는 업무를 수행합니다.\n\n훈련 프로그램을 개발합니다.\n\n체력 훈련을 지도합니다.\n\n부상 예방을 교육합니다.\n\n컨디션 관리를 담당... 기반으로 30로 평가","creative":"creative는 스포츠트레이너는 운동선수의 체력과 기술 향상을 지원하는 업무를 수행합니다.\n\n훈련 프로그램을 개발합니다.\n\n체력 훈련을 지도합니다.\n\n부상 예방을 교육합니다.\n\n컨디션 관리를 담당... 기반으로 60로 평가","execution":"execution는 스포츠트레이너는 운동선수의 체력과 기술 향상을 지원하는 업무를 수행합니다.\n\n훈련 프로그램을 개발합니다.\n\n체력 훈련을 지도합니다.\n\n부상 예방을 교육합니다.\n\n컨디션 관리를 담당... 기반으로 60로 평가","people_facing":"people_facing는 스포츠트레이너는 운동선수의 체력과 기술 향상을 지원하는 업무를 수행합니다.\n\n훈련 프로그램을 개발합니다.\n\n체력 훈련을 지도합니다.\n\n부상 예방을 교육합니다.\n\n컨디션 관리를 담당... 기반으로 35로 평가","degree_required":"degree_required는 스포츠트레이너는 운동선수의 체력과 기술 향상을 지원하는 업무를 수행합니다.\n\n훈련 프로그램을 개발합니다.\n\n체력 훈련을 지도합니다.\n\n부상 예방을 교육합니다.\n\n컨디션 관리를 담당... 기반으로 none로 평가","license_required":"license_required는 스포츠트레이너는 운동선수의 체력과 기술 향상을 지원하는 업무를 수행합니다.\n\n훈련 프로그램을 개발합니다.\n\n체력 훈련을 지도합니다.\n\n부상 예방을 교육합니다.\n\n컨디션 관리를 담당... 기반으로 none로 평가"}'
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
  '1765283401390211',
  '호스피스전문간호사',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 70,
  50, 50, 40, 40, 70, 75,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 호스피스전문간호사는 말기 환자의 돌봄을 담당하는 업무를 수행합니다.\n\n환자의 증상을 관리합니다.\n\n통증을 완화합니다.\n\n정서적 지원을 제공합니다.\n\n가족을 상담합니다.\n\n임종 과정... 기반으로 50로 평가","growth":"growth는 호스피스전문간호사는 말기 환자의 돌봄을 담당하는 업무를 수행합니다.\n\n환자의 증상을 관리합니다.\n\n통증을 완화합니다.\n\n정서적 지원을 제공합니다.\n\n가족을 상담합니다.\n\n임종 과정... 기반으로 50로 평가","stability":"stability는 호스피스전문간호사는 말기 환자의 돌봄을 담당하는 업무를 수행합니다.\n\n환자의 증상을 관리합니다.\n\n통증을 완화합니다.\n\n정서적 지원을 제공합니다.\n\n가족을 상담합니다.\n\n임종 과정... 기반으로 50로 평가","income":"income는 호스피스전문간호사는 말기 환자의 돌봄을 담당하는 업무를 수행합니다.\n\n환자의 증상을 관리합니다.\n\n통증을 완화합니다.\n\n정서적 지원을 제공합니다.\n\n가족을 상담합니다.\n\n임종 과정... 기반으로 70로 평가","teamwork":"teamwork는 호스피스전문간호사는 말기 환자의 돌봄을 담당하는 업무를 수행합니다.\n\n환자의 증상을 관리합니다.\n\n통증을 완화합니다.\n\n정서적 지원을 제공합니다.\n\n가족을 상담합니다.\n\n임종 과정... 기반으로 50로 평가","solo_deep":"solo_deep는 호스피스전문간호사는 말기 환자의 돌봄을 담당하는 업무를 수행합니다.\n\n환자의 증상을 관리합니다.\n\n통증을 완화합니다.\n\n정서적 지원을 제공합니다.\n\n가족을 상담합니다.\n\n임종 과정... 기반으로 50로 평가","analytical":"analytical는 호스피스전문간호사는 말기 환자의 돌봄을 담당하는 업무를 수행합니다.\n\n환자의 증상을 관리합니다.\n\n통증을 완화합니다.\n\n정서적 지원을 제공합니다.\n\n가족을 상담합니다.\n\n임종 과정... 기반으로 40로 평가","creative":"creative는 호스피스전문간호사는 말기 환자의 돌봄을 담당하는 업무를 수행합니다.\n\n환자의 증상을 관리합니다.\n\n통증을 완화합니다.\n\n정서적 지원을 제공합니다.\n\n가족을 상담합니다.\n\n임종 과정... 기반으로 40로 평가","execution":"execution는 호스피스전문간호사는 말기 환자의 돌봄을 담당하는 업무를 수행합니다.\n\n환자의 증상을 관리합니다.\n\n통증을 완화합니다.\n\n정서적 지원을 제공합니다.\n\n가족을 상담합니다.\n\n임종 과정... 기반으로 70로 평가","people_facing":"people_facing는 호스피스전문간호사는 말기 환자의 돌봄을 담당하는 업무를 수행합니다.\n\n환자의 증상을 관리합니다.\n\n통증을 완화합니다.\n\n정서적 지원을 제공합니다.\n\n가족을 상담합니다.\n\n임종 과정... 기반으로 75로 평가","degree_required":"degree_required는 호스피스전문간호사는 말기 환자의 돌봄을 담당하는 업무를 수행합니다.\n\n환자의 증상을 관리합니다.\n\n통증을 완화합니다.\n\n정서적 지원을 제공합니다.\n\n가족을 상담합니다.\n\n임종 과정... 기반으로 none로 평가","license_required":"license_required는 호스피스전문간호사는 말기 환자의 돌봄을 담당하는 업무를 수행합니다.\n\n환자의 증상을 관리합니다.\n\n통증을 완화합니다.\n\n정서적 지원을 제공합니다.\n\n가족을 상담합니다.\n\n임종 과정... 기반으로 none로 평가"}'
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
  '1765283318400738',
  '비파괴검사원',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  50, 50, 70, 40, 40, 35,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 비파괴검사원은 물체의 내부 결함을 파괴하지 않고 검사하는 업무를 수행합니다.\n\n검사 장비를 준비합니다.\n\n물체의 표면을 검사합니다.\n\n결함을 탐지합니다.\n\n검사 결과를 분석합니다.... 기반으로 50로 평가","growth":"growth는 비파괴검사원은 물체의 내부 결함을 파괴하지 않고 검사하는 업무를 수행합니다.\n\n검사 장비를 준비합니다.\n\n물체의 표면을 검사합니다.\n\n결함을 탐지합니다.\n\n검사 결과를 분석합니다.... 기반으로 50로 평가","stability":"stability는 비파괴검사원은 물체의 내부 결함을 파괴하지 않고 검사하는 업무를 수행합니다.\n\n검사 장비를 준비합니다.\n\n물체의 표면을 검사합니다.\n\n결함을 탐지합니다.\n\n검사 결과를 분석합니다.... 기반으로 50로 평가","income":"income는 비파괴검사원은 물체의 내부 결함을 파괴하지 않고 검사하는 업무를 수행합니다.\n\n검사 장비를 준비합니다.\n\n물체의 표면을 검사합니다.\n\n결함을 탐지합니다.\n\n검사 결과를 분석합니다.... 기반으로 50로 평가","teamwork":"teamwork는 비파괴검사원은 물체의 내부 결함을 파괴하지 않고 검사하는 업무를 수행합니다.\n\n검사 장비를 준비합니다.\n\n물체의 표면을 검사합니다.\n\n결함을 탐지합니다.\n\n검사 결과를 분석합니다.... 기반으로 50로 평가","solo_deep":"solo_deep는 비파괴검사원은 물체의 내부 결함을 파괴하지 않고 검사하는 업무를 수행합니다.\n\n검사 장비를 준비합니다.\n\n물체의 표면을 검사합니다.\n\n결함을 탐지합니다.\n\n검사 결과를 분석합니다.... 기반으로 50로 평가","analytical":"analytical는 비파괴검사원은 물체의 내부 결함을 파괴하지 않고 검사하는 업무를 수행합니다.\n\n검사 장비를 준비합니다.\n\n물체의 표면을 검사합니다.\n\n결함을 탐지합니다.\n\n검사 결과를 분석합니다.... 기반으로 70로 평가","creative":"creative는 비파괴검사원은 물체의 내부 결함을 파괴하지 않고 검사하는 업무를 수행합니다.\n\n검사 장비를 준비합니다.\n\n물체의 표면을 검사합니다.\n\n결함을 탐지합니다.\n\n검사 결과를 분석합니다.... 기반으로 40로 평가","execution":"execution는 비파괴검사원은 물체의 내부 결함을 파괴하지 않고 검사하는 업무를 수행합니다.\n\n검사 장비를 준비합니다.\n\n물체의 표면을 검사합니다.\n\n결함을 탐지합니다.\n\n검사 결과를 분석합니다.... 기반으로 40로 평가","people_facing":"people_facing는 비파괴검사원은 물체의 내부 결함을 파괴하지 않고 검사하는 업무를 수행합니다.\n\n검사 장비를 준비합니다.\n\n물체의 표면을 검사합니다.\n\n결함을 탐지합니다.\n\n검사 결과를 분석합니다.... 기반으로 35로 평가","degree_required":"degree_required는 비파괴검사원은 물체의 내부 결함을 파괴하지 않고 검사하는 업무를 수행합니다.\n\n검사 장비를 준비합니다.\n\n물체의 표면을 검사합니다.\n\n결함을 탐지합니다.\n\n검사 결과를 분석합니다.... 기반으로 none로 평가","license_required":"license_required는 비파괴검사원은 물체의 내부 결함을 파괴하지 않고 검사하는 업무를 수행합니다.\n\n검사 장비를 준비합니다.\n\n물체의 표면을 검사합니다.\n\n결함을 탐지합니다.\n\n검사 결과를 분석합니다.... 기반으로 none로 평가"}'
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
  '1765283346355412',
  '영화시나리오작가',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 50, 40,
  70, 30, 40, 70, 40, 35,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 영화시나리오작가는 영화의 대본을 쓰는 업무를 수행합니다.\n\n스토리를 기획합니다.\n\n등장인물을 개발합니다.\n\n대본을 작성합니다.\n\n수정을 거칩니다.\n\n감독과 협의합니다.... 기반으로 50로 평가","growth":"growth는 영화시나리오작가는 영화의 대본을 쓰는 업무를 수행합니다.\n\n스토리를 기획합니다.\n\n등장인물을 개발합니다.\n\n대본을 작성합니다.\n\n수정을 거칩니다.\n\n감독과 협의합니다.... 기반으로 65로 평가","stability":"stability는 영화시나리오작가는 영화의 대본을 쓰는 업무를 수행합니다.\n\n스토리를 기획합니다.\n\n등장인물을 개발합니다.\n\n대본을 작성합니다.\n\n수정을 거칩니다.\n\n감독과 협의합니다.... 기반으로 50로 평가","income":"income는 영화시나리오작가는 영화의 대본을 쓰는 업무를 수행합니다.\n\n스토리를 기획합니다.\n\n등장인물을 개발합니다.\n\n대본을 작성합니다.\n\n수정을 거칩니다.\n\n감독과 협의합니다.... 기반으로 40로 평가","teamwork":"teamwork는 영화시나리오작가는 영화의 대본을 쓰는 업무를 수행합니다.\n\n스토리를 기획합니다.\n\n등장인물을 개발합니다.\n\n대본을 작성합니다.\n\n수정을 거칩니다.\n\n감독과 협의합니다.... 기반으로 70로 평가","solo_deep":"solo_deep는 영화시나리오작가는 영화의 대본을 쓰는 업무를 수행합니다.\n\n스토리를 기획합니다.\n\n등장인물을 개발합니다.\n\n대본을 작성합니다.\n\n수정을 거칩니다.\n\n감독과 협의합니다.... 기반으로 30로 평가","analytical":"analytical는 영화시나리오작가는 영화의 대본을 쓰는 업무를 수행합니다.\n\n스토리를 기획합니다.\n\n등장인물을 개발합니다.\n\n대본을 작성합니다.\n\n수정을 거칩니다.\n\n감독과 협의합니다.... 기반으로 40로 평가","creative":"creative는 영화시나리오작가는 영화의 대본을 쓰는 업무를 수행합니다.\n\n스토리를 기획합니다.\n\n등장인물을 개발합니다.\n\n대본을 작성합니다.\n\n수정을 거칩니다.\n\n감독과 협의합니다.... 기반으로 70로 평가","execution":"execution는 영화시나리오작가는 영화의 대본을 쓰는 업무를 수행합니다.\n\n스토리를 기획합니다.\n\n등장인물을 개발합니다.\n\n대본을 작성합니다.\n\n수정을 거칩니다.\n\n감독과 협의합니다.... 기반으로 40로 평가","people_facing":"people_facing는 영화시나리오작가는 영화의 대본을 쓰는 업무를 수행합니다.\n\n스토리를 기획합니다.\n\n등장인물을 개발합니다.\n\n대본을 작성합니다.\n\n수정을 거칩니다.\n\n감독과 협의합니다.... 기반으로 35로 평가","degree_required":"degree_required는 영화시나리오작가는 영화의 대본을 쓰는 업무를 수행합니다.\n\n스토리를 기획합니다.\n\n등장인물을 개발합니다.\n\n대본을 작성합니다.\n\n수정을 거칩니다.\n\n감독과 협의합니다.... 기반으로 none로 평가","license_required":"license_required는 영화시나리오작가는 영화의 대본을 쓰는 업무를 수행합니다.\n\n스토리를 기획합니다.\n\n등장인물을 개발합니다.\n\n대본을 작성합니다.\n\n수정을 거칩니다.\n\n감독과 협의합니다.... 기반으로 none로 평가"}'
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
  '1765283321094381',
  '사회단체활동가',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 50, 50,
  50, 50, 60, 60, 30, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 사회단체활동가는 사회 문제를 해결하기 위한 활동을 하는 업무를 수행합니다.\n\n사회 문제를 조사합니다.\n\n캠페인을 기획합니다.\n\n참여자를 모집합니다.\n\n활동을 조직합니다.\n\n성과를 ... 기반으로 50로 평가","growth":"growth는 사회단체활동가는 사회 문제를 해결하기 위한 활동을 하는 업무를 수행합니다.\n\n사회 문제를 조사합니다.\n\n캠페인을 기획합니다.\n\n참여자를 모집합니다.\n\n활동을 조직합니다.\n\n성과를 ... 기반으로 65로 평가","stability":"stability는 사회단체활동가는 사회 문제를 해결하기 위한 활동을 하는 업무를 수행합니다.\n\n사회 문제를 조사합니다.\n\n캠페인을 기획합니다.\n\n참여자를 모집합니다.\n\n활동을 조직합니다.\n\n성과를 ... 기반으로 50로 평가","income":"income는 사회단체활동가는 사회 문제를 해결하기 위한 활동을 하는 업무를 수행합니다.\n\n사회 문제를 조사합니다.\n\n캠페인을 기획합니다.\n\n참여자를 모집합니다.\n\n활동을 조직합니다.\n\n성과를 ... 기반으로 50로 평가","teamwork":"teamwork는 사회단체활동가는 사회 문제를 해결하기 위한 활동을 하는 업무를 수행합니다.\n\n사회 문제를 조사합니다.\n\n캠페인을 기획합니다.\n\n참여자를 모집합니다.\n\n활동을 조직합니다.\n\n성과를 ... 기반으로 50로 평가","solo_deep":"solo_deep는 사회단체활동가는 사회 문제를 해결하기 위한 활동을 하는 업무를 수행합니다.\n\n사회 문제를 조사합니다.\n\n캠페인을 기획합니다.\n\n참여자를 모집합니다.\n\n활동을 조직합니다.\n\n성과를 ... 기반으로 50로 평가","analytical":"analytical는 사회단체활동가는 사회 문제를 해결하기 위한 활동을 하는 업무를 수행합니다.\n\n사회 문제를 조사합니다.\n\n캠페인을 기획합니다.\n\n참여자를 모집합니다.\n\n활동을 조직합니다.\n\n성과를 ... 기반으로 60로 평가","creative":"creative는 사회단체활동가는 사회 문제를 해결하기 위한 활동을 하는 업무를 수행합니다.\n\n사회 문제를 조사합니다.\n\n캠페인을 기획합니다.\n\n참여자를 모집합니다.\n\n활동을 조직합니다.\n\n성과를 ... 기반으로 60로 평가","execution":"execution는 사회단체활동가는 사회 문제를 해결하기 위한 활동을 하는 업무를 수행합니다.\n\n사회 문제를 조사합니다.\n\n캠페인을 기획합니다.\n\n참여자를 모집합니다.\n\n활동을 조직합니다.\n\n성과를 ... 기반으로 30로 평가","people_facing":"people_facing는 사회단체활동가는 사회 문제를 해결하기 위한 활동을 하는 업무를 수행합니다.\n\n사회 문제를 조사합니다.\n\n캠페인을 기획합니다.\n\n참여자를 모집합니다.\n\n활동을 조직합니다.\n\n성과를 ... 기반으로 50로 평가","degree_required":"degree_required는 사회단체활동가는 사회 문제를 해결하기 위한 활동을 하는 업무를 수행합니다.\n\n사회 문제를 조사합니다.\n\n캠페인을 기획합니다.\n\n참여자를 모집합니다.\n\n활동을 조직합니다.\n\n성과를 ... 기반으로 none로 평가","license_required":"license_required는 사회단체활동가는 사회 문제를 해결하기 위한 활동을 하는 업무를 수행합니다.\n\n사회 문제를 조사합니다.\n\n캠페인을 기획합니다.\n\n참여자를 모집합니다.\n\n활동을 조직합니다.\n\n성과를 ... 기반으로 none로 평가"}'
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
  '1765283359273705',
  '임상심리사',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 70,
  30, 70, 70, 40, 40, 75,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 임상심리사는 환자의 정신 건강 문제를 진단하고 치료하는 업무를 수행합니다.\n\n환자의 증상을 평가합니다.\n\n심리 검사를 실시합니다.\n\n치료 계획을 수립합니다.\n\n개인 상담과 집단 치... 기반으로 50로 평가","growth":"growth는 임상심리사는 환자의 정신 건강 문제를 진단하고 치료하는 업무를 수행합니다.\n\n환자의 증상을 평가합니다.\n\n심리 검사를 실시합니다.\n\n치료 계획을 수립합니다.\n\n개인 상담과 집단 치... 기반으로 50로 평가","stability":"stability는 임상심리사는 환자의 정신 건강 문제를 진단하고 치료하는 업무를 수행합니다.\n\n환자의 증상을 평가합니다.\n\n심리 검사를 실시합니다.\n\n치료 계획을 수립합니다.\n\n개인 상담과 집단 치... 기반으로 50로 평가","income":"income는 임상심리사는 환자의 정신 건강 문제를 진단하고 치료하는 업무를 수행합니다.\n\n환자의 증상을 평가합니다.\n\n심리 검사를 실시합니다.\n\n치료 계획을 수립합니다.\n\n개인 상담과 집단 치... 기반으로 70로 평가","teamwork":"teamwork는 임상심리사는 환자의 정신 건강 문제를 진단하고 치료하는 업무를 수행합니다.\n\n환자의 증상을 평가합니다.\n\n심리 검사를 실시합니다.\n\n치료 계획을 수립합니다.\n\n개인 상담과 집단 치... 기반으로 30로 평가","solo_deep":"solo_deep는 임상심리사는 환자의 정신 건강 문제를 진단하고 치료하는 업무를 수행합니다.\n\n환자의 증상을 평가합니다.\n\n심리 검사를 실시합니다.\n\n치료 계획을 수립합니다.\n\n개인 상담과 집단 치... 기반으로 70로 평가","analytical":"analytical는 임상심리사는 환자의 정신 건강 문제를 진단하고 치료하는 업무를 수행합니다.\n\n환자의 증상을 평가합니다.\n\n심리 검사를 실시합니다.\n\n치료 계획을 수립합니다.\n\n개인 상담과 집단 치... 기반으로 70로 평가","creative":"creative는 임상심리사는 환자의 정신 건강 문제를 진단하고 치료하는 업무를 수행합니다.\n\n환자의 증상을 평가합니다.\n\n심리 검사를 실시합니다.\n\n치료 계획을 수립합니다.\n\n개인 상담과 집단 치... 기반으로 40로 평가","execution":"execution는 임상심리사는 환자의 정신 건강 문제를 진단하고 치료하는 업무를 수행합니다.\n\n환자의 증상을 평가합니다.\n\n심리 검사를 실시합니다.\n\n치료 계획을 수립합니다.\n\n개인 상담과 집단 치... 기반으로 40로 평가","people_facing":"people_facing는 임상심리사는 환자의 정신 건강 문제를 진단하고 치료하는 업무를 수행합니다.\n\n환자의 증상을 평가합니다.\n\n심리 검사를 실시합니다.\n\n치료 계획을 수립합니다.\n\n개인 상담과 집단 치... 기반으로 75로 평가","degree_required":"degree_required는 임상심리사는 환자의 정신 건강 문제를 진단하고 치료하는 업무를 수행합니다.\n\n환자의 증상을 평가합니다.\n\n심리 검사를 실시합니다.\n\n치료 계획을 수립합니다.\n\n개인 상담과 집단 치... 기반으로 none로 평가","license_required":"license_required는 임상심리사는 환자의 정신 건강 문제를 진단하고 치료하는 업무를 수행합니다.\n\n환자의 증상을 평가합니다.\n\n심리 검사를 실시합니다.\n\n치료 계획을 수립합니다.\n\n개인 상담과 집단 치... 기반으로 none로 평가"}'
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