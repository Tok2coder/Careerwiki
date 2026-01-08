-- Batch tagging SQL generated at 2026-01-06T06:17:14.481Z
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


INSERT INTO job_attributes (
  job_id, job_name, source_system, tagger_version, status,
  wlb, growth, stability, income,
  teamwork, solo_deep, analytical, creative, execution, people_facing,
  work_hours, shift_work, travel, remote_possible,
  degree_required, license_required, experience_required,
  _confidence, _field_confidence_json, evidence_json
) VALUES (
  '1765283347979133',
  '운동감독',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 75, 50, 40,
  70, 30, 60, 60, 30, 35,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 운동감독은 스포츠 팀의 훈련과 경기를 감독하는 업무를 수행합니다.\n\n훈련 프로그램을 기획합니다.\n\n선수들의 기량을 평가합니다.\n\n전술을 개발합니다.\n\n경기 전략을 수립합니다.\n\n선... 기반으로 50로 평가","growth":"growth는 운동감독은 스포츠 팀의 훈련과 경기를 감독하는 업무를 수행합니다.\n\n훈련 프로그램을 기획합니다.\n\n선수들의 기량을 평가합니다.\n\n전술을 개발합니다.\n\n경기 전략을 수립합니다.\n\n선... 기반으로 75로 평가","stability":"stability는 운동감독은 스포츠 팀의 훈련과 경기를 감독하는 업무를 수행합니다.\n\n훈련 프로그램을 기획합니다.\n\n선수들의 기량을 평가합니다.\n\n전술을 개발합니다.\n\n경기 전략을 수립합니다.\n\n선... 기반으로 50로 평가","income":"income는 운동감독은 스포츠 팀의 훈련과 경기를 감독하는 업무를 수행합니다.\n\n훈련 프로그램을 기획합니다.\n\n선수들의 기량을 평가합니다.\n\n전술을 개발합니다.\n\n경기 전략을 수립합니다.\n\n선... 기반으로 40로 평가","teamwork":"teamwork는 운동감독은 스포츠 팀의 훈련과 경기를 감독하는 업무를 수행합니다.\n\n훈련 프로그램을 기획합니다.\n\n선수들의 기량을 평가합니다.\n\n전술을 개발합니다.\n\n경기 전략을 수립합니다.\n\n선... 기반으로 70로 평가","solo_deep":"solo_deep는 운동감독은 스포츠 팀의 훈련과 경기를 감독하는 업무를 수행합니다.\n\n훈련 프로그램을 기획합니다.\n\n선수들의 기량을 평가합니다.\n\n전술을 개발합니다.\n\n경기 전략을 수립합니다.\n\n선... 기반으로 30로 평가","analytical":"analytical는 운동감독은 스포츠 팀의 훈련과 경기를 감독하는 업무를 수행합니다.\n\n훈련 프로그램을 기획합니다.\n\n선수들의 기량을 평가합니다.\n\n전술을 개발합니다.\n\n경기 전략을 수립합니다.\n\n선... 기반으로 60로 평가","creative":"creative는 운동감독은 스포츠 팀의 훈련과 경기를 감독하는 업무를 수행합니다.\n\n훈련 프로그램을 기획합니다.\n\n선수들의 기량을 평가합니다.\n\n전술을 개발합니다.\n\n경기 전략을 수립합니다.\n\n선... 기반으로 60로 평가","execution":"execution는 운동감독은 스포츠 팀의 훈련과 경기를 감독하는 업무를 수행합니다.\n\n훈련 프로그램을 기획합니다.\n\n선수들의 기량을 평가합니다.\n\n전술을 개발합니다.\n\n경기 전략을 수립합니다.\n\n선... 기반으로 30로 평가","people_facing":"people_facing는 운동감독은 스포츠 팀의 훈련과 경기를 감독하는 업무를 수행합니다.\n\n훈련 프로그램을 기획합니다.\n\n선수들의 기량을 평가합니다.\n\n전술을 개발합니다.\n\n경기 전략을 수립합니다.\n\n선... 기반으로 35로 평가","degree_required":"degree_required는 운동감독은 스포츠 팀의 훈련과 경기를 감독하는 업무를 수행합니다.\n\n훈련 프로그램을 기획합니다.\n\n선수들의 기량을 평가합니다.\n\n전술을 개발합니다.\n\n경기 전략을 수립합니다.\n\n선... 기반으로 none로 평가","license_required":"license_required는 운동감독은 스포츠 팀의 훈련과 경기를 감독하는 업무를 수행합니다.\n\n훈련 프로그램을 기획합니다.\n\n선수들의 기량을 평가합니다.\n\n전술을 개발합니다.\n\n경기 전략을 수립합니다.\n\n선... 기반으로 none로 평가"}'
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
  '1765283363066288',
  '작업치료사',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 50, 70,
  50, 50, 60, 60, 30, 35,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 작업치료사는 환자의 일상 생활 기능을 회복시키는 업무를 수행합니다.\n\n환자의 기능 상태를 평가합니다.\n\n치료 목표를 설정합니다.\n\n치료 프로그램을 개발합니다.\n\n치료 활동을 지도합... 기반으로 50로 평가","growth":"growth는 작업치료사는 환자의 일상 생활 기능을 회복시키는 업무를 수행합니다.\n\n환자의 기능 상태를 평가합니다.\n\n치료 목표를 설정합니다.\n\n치료 프로그램을 개발합니다.\n\n치료 활동을 지도합... 기반으로 65로 평가","stability":"stability는 작업치료사는 환자의 일상 생활 기능을 회복시키는 업무를 수행합니다.\n\n환자의 기능 상태를 평가합니다.\n\n치료 목표를 설정합니다.\n\n치료 프로그램을 개발합니다.\n\n치료 활동을 지도합... 기반으로 50로 평가","income":"income는 작업치료사는 환자의 일상 생활 기능을 회복시키는 업무를 수행합니다.\n\n환자의 기능 상태를 평가합니다.\n\n치료 목표를 설정합니다.\n\n치료 프로그램을 개발합니다.\n\n치료 활동을 지도합... 기반으로 70로 평가","teamwork":"teamwork는 작업치료사는 환자의 일상 생활 기능을 회복시키는 업무를 수행합니다.\n\n환자의 기능 상태를 평가합니다.\n\n치료 목표를 설정합니다.\n\n치료 프로그램을 개발합니다.\n\n치료 활동을 지도합... 기반으로 50로 평가","solo_deep":"solo_deep는 작업치료사는 환자의 일상 생활 기능을 회복시키는 업무를 수행합니다.\n\n환자의 기능 상태를 평가합니다.\n\n치료 목표를 설정합니다.\n\n치료 프로그램을 개발합니다.\n\n치료 활동을 지도합... 기반으로 50로 평가","analytical":"analytical는 작업치료사는 환자의 일상 생활 기능을 회복시키는 업무를 수행합니다.\n\n환자의 기능 상태를 평가합니다.\n\n치료 목표를 설정합니다.\n\n치료 프로그램을 개발합니다.\n\n치료 활동을 지도합... 기반으로 60로 평가","creative":"creative는 작업치료사는 환자의 일상 생활 기능을 회복시키는 업무를 수행합니다.\n\n환자의 기능 상태를 평가합니다.\n\n치료 목표를 설정합니다.\n\n치료 프로그램을 개발합니다.\n\n치료 활동을 지도합... 기반으로 60로 평가","execution":"execution는 작업치료사는 환자의 일상 생활 기능을 회복시키는 업무를 수행합니다.\n\n환자의 기능 상태를 평가합니다.\n\n치료 목표를 설정합니다.\n\n치료 프로그램을 개발합니다.\n\n치료 활동을 지도합... 기반으로 30로 평가","people_facing":"people_facing는 작업치료사는 환자의 일상 생활 기능을 회복시키는 업무를 수행합니다.\n\n환자의 기능 상태를 평가합니다.\n\n치료 목표를 설정합니다.\n\n치료 프로그램을 개발합니다.\n\n치료 활동을 지도합... 기반으로 35로 평가","degree_required":"degree_required는 작업치료사는 환자의 일상 생활 기능을 회복시키는 업무를 수행합니다.\n\n환자의 기능 상태를 평가합니다.\n\n치료 목표를 설정합니다.\n\n치료 프로그램을 개발합니다.\n\n치료 활동을 지도합... 기반으로 none로 평가","license_required":"license_required는 작업치료사는 환자의 일상 생활 기능을 회복시키는 업무를 수행합니다.\n\n환자의 기능 상태를 평가합니다.\n\n치료 목표를 설정합니다.\n\n치료 프로그램을 개발합니다.\n\n치료 활동을 지도합... 기반으로 none로 평가"}'
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
  '1765283349532437',
  '웨딩플래너',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 30, 50,
  50, 50, 40, 70, 40, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 웨딩플래너는 결혼식을 기획하고 진행하는 업무를 수행합니다.\n\n커플의 요구사항을 파악합니다.\n\n결혼식 예산을 계획합니다.\n\n장소와 날짜를 예약합니다.\n\n업체와 계약을 체결합니다.\n\n... 기반으로 50로 평가","growth":"growth는 웨딩플래너는 결혼식을 기획하고 진행하는 업무를 수행합니다.\n\n커플의 요구사항을 파악합니다.\n\n결혼식 예산을 계획합니다.\n\n장소와 날짜를 예약합니다.\n\n업체와 계약을 체결합니다.\n\n... 기반으로 65로 평가","stability":"stability는 웨딩플래너는 결혼식을 기획하고 진행하는 업무를 수행합니다.\n\n커플의 요구사항을 파악합니다.\n\n결혼식 예산을 계획합니다.\n\n장소와 날짜를 예약합니다.\n\n업체와 계약을 체결합니다.\n\n... 기반으로 30로 평가","income":"income는 웨딩플래너는 결혼식을 기획하고 진행하는 업무를 수행합니다.\n\n커플의 요구사항을 파악합니다.\n\n결혼식 예산을 계획합니다.\n\n장소와 날짜를 예약합니다.\n\n업체와 계약을 체결합니다.\n\n... 기반으로 50로 평가","teamwork":"teamwork는 웨딩플래너는 결혼식을 기획하고 진행하는 업무를 수행합니다.\n\n커플의 요구사항을 파악합니다.\n\n결혼식 예산을 계획합니다.\n\n장소와 날짜를 예약합니다.\n\n업체와 계약을 체결합니다.\n\n... 기반으로 50로 평가","solo_deep":"solo_deep는 웨딩플래너는 결혼식을 기획하고 진행하는 업무를 수행합니다.\n\n커플의 요구사항을 파악합니다.\n\n결혼식 예산을 계획합니다.\n\n장소와 날짜를 예약합니다.\n\n업체와 계약을 체결합니다.\n\n... 기반으로 50로 평가","analytical":"analytical는 웨딩플래너는 결혼식을 기획하고 진행하는 업무를 수행합니다.\n\n커플의 요구사항을 파악합니다.\n\n결혼식 예산을 계획합니다.\n\n장소와 날짜를 예약합니다.\n\n업체와 계약을 체결합니다.\n\n... 기반으로 40로 평가","creative":"creative는 웨딩플래너는 결혼식을 기획하고 진행하는 업무를 수행합니다.\n\n커플의 요구사항을 파악합니다.\n\n결혼식 예산을 계획합니다.\n\n장소와 날짜를 예약합니다.\n\n업체와 계약을 체결합니다.\n\n... 기반으로 70로 평가","execution":"execution는 웨딩플래너는 결혼식을 기획하고 진행하는 업무를 수행합니다.\n\n커플의 요구사항을 파악합니다.\n\n결혼식 예산을 계획합니다.\n\n장소와 날짜를 예약합니다.\n\n업체와 계약을 체결합니다.\n\n... 기반으로 40로 평가","people_facing":"people_facing는 웨딩플래너는 결혼식을 기획하고 진행하는 업무를 수행합니다.\n\n커플의 요구사항을 파악합니다.\n\n결혼식 예산을 계획합니다.\n\n장소와 날짜를 예약합니다.\n\n업체와 계약을 체결합니다.\n\n... 기반으로 50로 평가","degree_required":"degree_required는 웨딩플래너는 결혼식을 기획하고 진행하는 업무를 수행합니다.\n\n커플의 요구사항을 파악합니다.\n\n결혼식 예산을 계획합니다.\n\n장소와 날짜를 예약합니다.\n\n업체와 계약을 체결합니다.\n\n... 기반으로 none로 평가","license_required":"license_required는 웨딩플래너는 결혼식을 기획하고 진행하는 업무를 수행합니다.\n\n커플의 요구사항을 파악합니다.\n\n결혼식 예산을 계획합니다.\n\n장소와 날짜를 예약합니다.\n\n업체와 계약을 체결합니다.\n\n... 기반으로 none로 평가"}'
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
  '1765283308474424',
  '물리학연구원',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 50, 70,
  50, 50, 60, 60, 30, 35,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 물리학연구원은 물리 현상을 연구하고 새로운 지식을 개발하는 업무를 수행합니다.\n\n연구 주제를 설정합니다.\n\n실험을 설계합니다.\n\n데이터를 수집하고 분석합니다.\n\n연구 결과를 발표합... 기반으로 50로 평가","growth":"growth는 물리학연구원은 물리 현상을 연구하고 새로운 지식을 개발하는 업무를 수행합니다.\n\n연구 주제를 설정합니다.\n\n실험을 설계합니다.\n\n데이터를 수집하고 분석합니다.\n\n연구 결과를 발표합... 기반으로 65로 평가","stability":"stability는 물리학연구원은 물리 현상을 연구하고 새로운 지식을 개발하는 업무를 수행합니다.\n\n연구 주제를 설정합니다.\n\n실험을 설계합니다.\n\n데이터를 수집하고 분석합니다.\n\n연구 결과를 발표합... 기반으로 50로 평가","income":"income는 물리학연구원은 물리 현상을 연구하고 새로운 지식을 개발하는 업무를 수행합니다.\n\n연구 주제를 설정합니다.\n\n실험을 설계합니다.\n\n데이터를 수집하고 분석합니다.\n\n연구 결과를 발표합... 기반으로 70로 평가","teamwork":"teamwork는 물리학연구원은 물리 현상을 연구하고 새로운 지식을 개발하는 업무를 수행합니다.\n\n연구 주제를 설정합니다.\n\n실험을 설계합니다.\n\n데이터를 수집하고 분석합니다.\n\n연구 결과를 발표합... 기반으로 50로 평가","solo_deep":"solo_deep는 물리학연구원은 물리 현상을 연구하고 새로운 지식을 개발하는 업무를 수행합니다.\n\n연구 주제를 설정합니다.\n\n실험을 설계합니다.\n\n데이터를 수집하고 분석합니다.\n\n연구 결과를 발표합... 기반으로 50로 평가","analytical":"analytical는 물리학연구원은 물리 현상을 연구하고 새로운 지식을 개발하는 업무를 수행합니다.\n\n연구 주제를 설정합니다.\n\n실험을 설계합니다.\n\n데이터를 수집하고 분석합니다.\n\n연구 결과를 발표합... 기반으로 60로 평가","creative":"creative는 물리학연구원은 물리 현상을 연구하고 새로운 지식을 개발하는 업무를 수행합니다.\n\n연구 주제를 설정합니다.\n\n실험을 설계합니다.\n\n데이터를 수집하고 분석합니다.\n\n연구 결과를 발표합... 기반으로 60로 평가","execution":"execution는 물리학연구원은 물리 현상을 연구하고 새로운 지식을 개발하는 업무를 수행합니다.\n\n연구 주제를 설정합니다.\n\n실험을 설계합니다.\n\n데이터를 수집하고 분석합니다.\n\n연구 결과를 발표합... 기반으로 30로 평가","people_facing":"people_facing는 물리학연구원은 물리 현상을 연구하고 새로운 지식을 개발하는 업무를 수행합니다.\n\n연구 주제를 설정합니다.\n\n실험을 설계합니다.\n\n데이터를 수집하고 분석합니다.\n\n연구 결과를 발표합... 기반으로 35로 평가","degree_required":"degree_required는 물리학연구원은 물리 현상을 연구하고 새로운 지식을 개발하는 업무를 수행합니다.\n\n연구 주제를 설정합니다.\n\n실험을 설계합니다.\n\n데이터를 수집하고 분석합니다.\n\n연구 결과를 발표합... 기반으로 none로 평가","license_required":"license_required는 물리학연구원은 물리 현상을 연구하고 새로운 지식을 개발하는 업무를 수행합니다.\n\n연구 주제를 설정합니다.\n\n실험을 설계합니다.\n\n데이터를 수집하고 분석합니다.\n\n연구 결과를 발표합... 기반으로 none로 평가"}'
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
  '1765283373650318',
  '조명기사',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  40, 65, 50, 40,
  50, 50, 30, 60, 60, 50,
  'overtime_some', 'none', 'some', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 조명기사는 공연이나 촬영 현장에서 조명을 설계하고 운영하는 업무를 수행합니다.\n\n조명 설계를 기획합니다.\n\n조명 장비를 설치합니다.\n\n조명 효과를 조절합니다.\n\n기술적인 문제를 해... 기반으로 40로 평가","growth":"growth는 조명기사는 공연이나 촬영 현장에서 조명을 설계하고 운영하는 업무를 수행합니다.\n\n조명 설계를 기획합니다.\n\n조명 장비를 설치합니다.\n\n조명 효과를 조절합니다.\n\n기술적인 문제를 해... 기반으로 65로 평가","stability":"stability는 조명기사는 공연이나 촬영 현장에서 조명을 설계하고 운영하는 업무를 수행합니다.\n\n조명 설계를 기획합니다.\n\n조명 장비를 설치합니다.\n\n조명 효과를 조절합니다.\n\n기술적인 문제를 해... 기반으로 50로 평가","income":"income는 조명기사는 공연이나 촬영 현장에서 조명을 설계하고 운영하는 업무를 수행합니다.\n\n조명 설계를 기획합니다.\n\n조명 장비를 설치합니다.\n\n조명 효과를 조절합니다.\n\n기술적인 문제를 해... 기반으로 40로 평가","teamwork":"teamwork는 조명기사는 공연이나 촬영 현장에서 조명을 설계하고 운영하는 업무를 수행합니다.\n\n조명 설계를 기획합니다.\n\n조명 장비를 설치합니다.\n\n조명 효과를 조절합니다.\n\n기술적인 문제를 해... 기반으로 50로 평가","solo_deep":"solo_deep는 조명기사는 공연이나 촬영 현장에서 조명을 설계하고 운영하는 업무를 수행합니다.\n\n조명 설계를 기획합니다.\n\n조명 장비를 설치합니다.\n\n조명 효과를 조절합니다.\n\n기술적인 문제를 해... 기반으로 50로 평가","analytical":"analytical는 조명기사는 공연이나 촬영 현장에서 조명을 설계하고 운영하는 업무를 수행합니다.\n\n조명 설계를 기획합니다.\n\n조명 장비를 설치합니다.\n\n조명 효과를 조절합니다.\n\n기술적인 문제를 해... 기반으로 30로 평가","creative":"creative는 조명기사는 공연이나 촬영 현장에서 조명을 설계하고 운영하는 업무를 수행합니다.\n\n조명 설계를 기획합니다.\n\n조명 장비를 설치합니다.\n\n조명 효과를 조절합니다.\n\n기술적인 문제를 해... 기반으로 60로 평가","execution":"execution는 조명기사는 공연이나 촬영 현장에서 조명을 설계하고 운영하는 업무를 수행합니다.\n\n조명 설계를 기획합니다.\n\n조명 장비를 설치합니다.\n\n조명 효과를 조절합니다.\n\n기술적인 문제를 해... 기반으로 60로 평가","people_facing":"people_facing는 조명기사는 공연이나 촬영 현장에서 조명을 설계하고 운영하는 업무를 수행합니다.\n\n조명 설계를 기획합니다.\n\n조명 장비를 설치합니다.\n\n조명 효과를 조절합니다.\n\n기술적인 문제를 해... 기반으로 50로 평가","degree_required":"degree_required는 조명기사는 공연이나 촬영 현장에서 조명을 설계하고 운영하는 업무를 수행합니다.\n\n조명 설계를 기획합니다.\n\n조명 장비를 설치합니다.\n\n조명 효과를 조절합니다.\n\n기술적인 문제를 해... 기반으로 none로 평가","license_required":"license_required는 조명기사는 공연이나 촬영 현장에서 조명을 설계하고 운영하는 업무를 수행합니다.\n\n조명 설계를 기획합니다.\n\n조명 장비를 설치합니다.\n\n조명 효과를 조절합니다.\n\n기술적인 문제를 해... 기반으로 none로 평가"}'
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
  '1765283353685379',
  '음향기사',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  40, 65, 50, 40,
  50, 50, 40, 40, 70, 50,
  'overtime_some', 'none', 'some', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 음향기사는 공연이나 녹음 현장에서 음향을 설계하고 운영하는 업무를 수행합니다.\n\n음향 시스템을 설계합니다.\n\n음향 장비를 설치합니다.\n\n음질을 조절합니다.\n\n기술적인 문제를 해결합... 기반으로 40로 평가","growth":"growth는 음향기사는 공연이나 녹음 현장에서 음향을 설계하고 운영하는 업무를 수행합니다.\n\n음향 시스템을 설계합니다.\n\n음향 장비를 설치합니다.\n\n음질을 조절합니다.\n\n기술적인 문제를 해결합... 기반으로 65로 평가","stability":"stability는 음향기사는 공연이나 녹음 현장에서 음향을 설계하고 운영하는 업무를 수행합니다.\n\n음향 시스템을 설계합니다.\n\n음향 장비를 설치합니다.\n\n음질을 조절합니다.\n\n기술적인 문제를 해결합... 기반으로 50로 평가","income":"income는 음향기사는 공연이나 녹음 현장에서 음향을 설계하고 운영하는 업무를 수행합니다.\n\n음향 시스템을 설계합니다.\n\n음향 장비를 설치합니다.\n\n음질을 조절합니다.\n\n기술적인 문제를 해결합... 기반으로 40로 평가","teamwork":"teamwork는 음향기사는 공연이나 녹음 현장에서 음향을 설계하고 운영하는 업무를 수행합니다.\n\n음향 시스템을 설계합니다.\n\n음향 장비를 설치합니다.\n\n음질을 조절합니다.\n\n기술적인 문제를 해결합... 기반으로 50로 평가","solo_deep":"solo_deep는 음향기사는 공연이나 녹음 현장에서 음향을 설계하고 운영하는 업무를 수행합니다.\n\n음향 시스템을 설계합니다.\n\n음향 장비를 설치합니다.\n\n음질을 조절합니다.\n\n기술적인 문제를 해결합... 기반으로 50로 평가","analytical":"analytical는 음향기사는 공연이나 녹음 현장에서 음향을 설계하고 운영하는 업무를 수행합니다.\n\n음향 시스템을 설계합니다.\n\n음향 장비를 설치합니다.\n\n음질을 조절합니다.\n\n기술적인 문제를 해결합... 기반으로 40로 평가","creative":"creative는 음향기사는 공연이나 녹음 현장에서 음향을 설계하고 운영하는 업무를 수행합니다.\n\n음향 시스템을 설계합니다.\n\n음향 장비를 설치합니다.\n\n음질을 조절합니다.\n\n기술적인 문제를 해결합... 기반으로 40로 평가","execution":"execution는 음향기사는 공연이나 녹음 현장에서 음향을 설계하고 운영하는 업무를 수행합니다.\n\n음향 시스템을 설계합니다.\n\n음향 장비를 설치합니다.\n\n음질을 조절합니다.\n\n기술적인 문제를 해결합... 기반으로 70로 평가","people_facing":"people_facing는 음향기사는 공연이나 녹음 현장에서 음향을 설계하고 운영하는 업무를 수행합니다.\n\n음향 시스템을 설계합니다.\n\n음향 장비를 설치합니다.\n\n음질을 조절합니다.\n\n기술적인 문제를 해결합... 기반으로 50로 평가","degree_required":"degree_required는 음향기사는 공연이나 녹음 현장에서 음향을 설계하고 운영하는 업무를 수행합니다.\n\n음향 시스템을 설계합니다.\n\n음향 장비를 설치합니다.\n\n음질을 조절합니다.\n\n기술적인 문제를 해결합... 기반으로 none로 평가","license_required":"license_required는 음향기사는 공연이나 녹음 현장에서 음향을 설계하고 운영하는 업무를 수행합니다.\n\n음향 시스템을 설계합니다.\n\n음향 장비를 설치합니다.\n\n음질을 조절합니다.\n\n기술적인 문제를 해결합... 기반으로 none로 평가"}'
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
  '1765283340183943',
  '애니메이션기획자',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 50, 40,
  70, 30, 30, 60, 60, 35,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 애니메이션기획자는 애니메이션 작품을 기획하고 개발하는 업무를 수행합니다.\n\n스토리를 개발합니다.\n\n콘셉트를 기획합니다.\n\n제작팀을 구성합니다.\n\n예산을 관리합니다.\n\n제작 과정을 ... 기반으로 50로 평가","growth":"growth는 애니메이션기획자는 애니메이션 작품을 기획하고 개발하는 업무를 수행합니다.\n\n스토리를 개발합니다.\n\n콘셉트를 기획합니다.\n\n제작팀을 구성합니다.\n\n예산을 관리합니다.\n\n제작 과정을 ... 기반으로 65로 평가","stability":"stability는 애니메이션기획자는 애니메이션 작품을 기획하고 개발하는 업무를 수행합니다.\n\n스토리를 개발합니다.\n\n콘셉트를 기획합니다.\n\n제작팀을 구성합니다.\n\n예산을 관리합니다.\n\n제작 과정을 ... 기반으로 50로 평가","income":"income는 애니메이션기획자는 애니메이션 작품을 기획하고 개발하는 업무를 수행합니다.\n\n스토리를 개발합니다.\n\n콘셉트를 기획합니다.\n\n제작팀을 구성합니다.\n\n예산을 관리합니다.\n\n제작 과정을 ... 기반으로 40로 평가","teamwork":"teamwork는 애니메이션기획자는 애니메이션 작품을 기획하고 개발하는 업무를 수행합니다.\n\n스토리를 개발합니다.\n\n콘셉트를 기획합니다.\n\n제작팀을 구성합니다.\n\n예산을 관리합니다.\n\n제작 과정을 ... 기반으로 70로 평가","solo_deep":"solo_deep는 애니메이션기획자는 애니메이션 작품을 기획하고 개발하는 업무를 수행합니다.\n\n스토리를 개발합니다.\n\n콘셉트를 기획합니다.\n\n제작팀을 구성합니다.\n\n예산을 관리합니다.\n\n제작 과정을 ... 기반으로 30로 평가","analytical":"analytical는 애니메이션기획자는 애니메이션 작품을 기획하고 개발하는 업무를 수행합니다.\n\n스토리를 개발합니다.\n\n콘셉트를 기획합니다.\n\n제작팀을 구성합니다.\n\n예산을 관리합니다.\n\n제작 과정을 ... 기반으로 30로 평가","creative":"creative는 애니메이션기획자는 애니메이션 작품을 기획하고 개발하는 업무를 수행합니다.\n\n스토리를 개발합니다.\n\n콘셉트를 기획합니다.\n\n제작팀을 구성합니다.\n\n예산을 관리합니다.\n\n제작 과정을 ... 기반으로 60로 평가","execution":"execution는 애니메이션기획자는 애니메이션 작품을 기획하고 개발하는 업무를 수행합니다.\n\n스토리를 개발합니다.\n\n콘셉트를 기획합니다.\n\n제작팀을 구성합니다.\n\n예산을 관리합니다.\n\n제작 과정을 ... 기반으로 60로 평가","people_facing":"people_facing는 애니메이션기획자는 애니메이션 작품을 기획하고 개발하는 업무를 수행합니다.\n\n스토리를 개발합니다.\n\n콘셉트를 기획합니다.\n\n제작팀을 구성합니다.\n\n예산을 관리합니다.\n\n제작 과정을 ... 기반으로 35로 평가","degree_required":"degree_required는 애니메이션기획자는 애니메이션 작품을 기획하고 개발하는 업무를 수행합니다.\n\n스토리를 개발합니다.\n\n콘셉트를 기획합니다.\n\n제작팀을 구성합니다.\n\n예산을 관리합니다.\n\n제작 과정을 ... 기반으로 none로 평가","license_required":"license_required는 애니메이션기획자는 애니메이션 작품을 기획하고 개발하는 업무를 수행합니다.\n\n스토리를 개발합니다.\n\n콘셉트를 기획합니다.\n\n제작팀을 구성합니다.\n\n예산을 관리합니다.\n\n제작 과정을 ... 기반으로 none로 평가"}'
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
  '1765283382576331',
  '치과기공사',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 50, 70,
  50, 50, 40, 40, 70, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 치과기공사는 치과 치료에 필요한 의료기기를 제작하는 업무를 수행합니다.\n\n치과의사의 지시에 따라 의료기기를 설계합니다.\n\n금속, 세라믹 등의 재료를 가공합니다.\n\n틀을 만들고 재료... 기반으로 50로 평가","growth":"growth는 치과기공사는 치과 치료에 필요한 의료기기를 제작하는 업무를 수행합니다.\n\n치과의사의 지시에 따라 의료기기를 설계합니다.\n\n금속, 세라믹 등의 재료를 가공합니다.\n\n틀을 만들고 재료... 기반으로 65로 평가","stability":"stability는 치과기공사는 치과 치료에 필요한 의료기기를 제작하는 업무를 수행합니다.\n\n치과의사의 지시에 따라 의료기기를 설계합니다.\n\n금속, 세라믹 등의 재료를 가공합니다.\n\n틀을 만들고 재료... 기반으로 50로 평가","income":"income는 치과기공사는 치과 치료에 필요한 의료기기를 제작하는 업무를 수행합니다.\n\n치과의사의 지시에 따라 의료기기를 설계합니다.\n\n금속, 세라믹 등의 재료를 가공합니다.\n\n틀을 만들고 재료... 기반으로 70로 평가","teamwork":"teamwork는 치과기공사는 치과 치료에 필요한 의료기기를 제작하는 업무를 수행합니다.\n\n치과의사의 지시에 따라 의료기기를 설계합니다.\n\n금속, 세라믹 등의 재료를 가공합니다.\n\n틀을 만들고 재료... 기반으로 50로 평가","solo_deep":"solo_deep는 치과기공사는 치과 치료에 필요한 의료기기를 제작하는 업무를 수행합니다.\n\n치과의사의 지시에 따라 의료기기를 설계합니다.\n\n금속, 세라믹 등의 재료를 가공합니다.\n\n틀을 만들고 재료... 기반으로 50로 평가","analytical":"analytical는 치과기공사는 치과 치료에 필요한 의료기기를 제작하는 업무를 수행합니다.\n\n치과의사의 지시에 따라 의료기기를 설계합니다.\n\n금속, 세라믹 등의 재료를 가공합니다.\n\n틀을 만들고 재료... 기반으로 40로 평가","creative":"creative는 치과기공사는 치과 치료에 필요한 의료기기를 제작하는 업무를 수행합니다.\n\n치과의사의 지시에 따라 의료기기를 설계합니다.\n\n금속, 세라믹 등의 재료를 가공합니다.\n\n틀을 만들고 재료... 기반으로 40로 평가","execution":"execution는 치과기공사는 치과 치료에 필요한 의료기기를 제작하는 업무를 수행합니다.\n\n치과의사의 지시에 따라 의료기기를 설계합니다.\n\n금속, 세라믹 등의 재료를 가공합니다.\n\n틀을 만들고 재료... 기반으로 70로 평가","people_facing":"people_facing는 치과기공사는 치과 치료에 필요한 의료기기를 제작하는 업무를 수행합니다.\n\n치과의사의 지시에 따라 의료기기를 설계합니다.\n\n금속, 세라믹 등의 재료를 가공합니다.\n\n틀을 만들고 재료... 기반으로 50로 평가","degree_required":"degree_required는 치과기공사는 치과 치료에 필요한 의료기기를 제작하는 업무를 수행합니다.\n\n치과의사의 지시에 따라 의료기기를 설계합니다.\n\n금속, 세라믹 등의 재료를 가공합니다.\n\n틀을 만들고 재료... 기반으로 none로 평가","license_required":"license_required는 치과기공사는 치과 치료에 필요한 의료기기를 제작하는 업무를 수행합니다.\n\n치과의사의 지시에 따라 의료기기를 설계합니다.\n\n금속, 세라믹 등의 재료를 가공합니다.\n\n틀을 만들고 재료... 기반으로 none로 평가"}'
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
  '1765283348496732',
  '운동선수',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 60, 50, 40,
  70, 30, 40, 40, 70, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 운동선수는 스포츠 경기에 참가하여 경기를 하는 업무를 수행합니다.\n\n훈련 프로그램에 따라 운동합니다.\n\n기술과 체력을 향상시킵니다.\n\n경기에 참가하여 최고의 기량을 발휘합니다.\n\n... 기반으로 50로 평가","growth":"growth는 운동선수는 스포츠 경기에 참가하여 경기를 하는 업무를 수행합니다.\n\n훈련 프로그램에 따라 운동합니다.\n\n기술과 체력을 향상시킵니다.\n\n경기에 참가하여 최고의 기량을 발휘합니다.\n\n... 기반으로 60로 평가","stability":"stability는 운동선수는 스포츠 경기에 참가하여 경기를 하는 업무를 수행합니다.\n\n훈련 프로그램에 따라 운동합니다.\n\n기술과 체력을 향상시킵니다.\n\n경기에 참가하여 최고의 기량을 발휘합니다.\n\n... 기반으로 50로 평가","income":"income는 운동선수는 스포츠 경기에 참가하여 경기를 하는 업무를 수행합니다.\n\n훈련 프로그램에 따라 운동합니다.\n\n기술과 체력을 향상시킵니다.\n\n경기에 참가하여 최고의 기량을 발휘합니다.\n\n... 기반으로 40로 평가","teamwork":"teamwork는 운동선수는 스포츠 경기에 참가하여 경기를 하는 업무를 수행합니다.\n\n훈련 프로그램에 따라 운동합니다.\n\n기술과 체력을 향상시킵니다.\n\n경기에 참가하여 최고의 기량을 발휘합니다.\n\n... 기반으로 70로 평가","solo_deep":"solo_deep는 운동선수는 스포츠 경기에 참가하여 경기를 하는 업무를 수행합니다.\n\n훈련 프로그램에 따라 운동합니다.\n\n기술과 체력을 향상시킵니다.\n\n경기에 참가하여 최고의 기량을 발휘합니다.\n\n... 기반으로 30로 평가","analytical":"analytical는 운동선수는 스포츠 경기에 참가하여 경기를 하는 업무를 수행합니다.\n\n훈련 프로그램에 따라 운동합니다.\n\n기술과 체력을 향상시킵니다.\n\n경기에 참가하여 최고의 기량을 발휘합니다.\n\n... 기반으로 40로 평가","creative":"creative는 운동선수는 스포츠 경기에 참가하여 경기를 하는 업무를 수행합니다.\n\n훈련 프로그램에 따라 운동합니다.\n\n기술과 체력을 향상시킵니다.\n\n경기에 참가하여 최고의 기량을 발휘합니다.\n\n... 기반으로 40로 평가","execution":"execution는 운동선수는 스포츠 경기에 참가하여 경기를 하는 업무를 수행합니다.\n\n훈련 프로그램에 따라 운동합니다.\n\n기술과 체력을 향상시킵니다.\n\n경기에 참가하여 최고의 기량을 발휘합니다.\n\n... 기반으로 70로 평가","people_facing":"people_facing는 운동선수는 스포츠 경기에 참가하여 경기를 하는 업무를 수행합니다.\n\n훈련 프로그램에 따라 운동합니다.\n\n기술과 체력을 향상시킵니다.\n\n경기에 참가하여 최고의 기량을 발휘합니다.\n\n... 기반으로 50로 평가","degree_required":"degree_required는 운동선수는 스포츠 경기에 참가하여 경기를 하는 업무를 수행합니다.\n\n훈련 프로그램에 따라 운동합니다.\n\n기술과 체력을 향상시킵니다.\n\n경기에 참가하여 최고의 기량을 발휘합니다.\n\n... 기반으로 none로 평가","license_required":"license_required는 운동선수는 스포츠 경기에 참가하여 경기를 하는 업무를 수행합니다.\n\n훈련 프로그램에 따라 운동합니다.\n\n기술과 체력을 향상시킵니다.\n\n경기에 참가하여 최고의 기량을 발휘합니다.\n\n... 기반으로 none로 평가"}'
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