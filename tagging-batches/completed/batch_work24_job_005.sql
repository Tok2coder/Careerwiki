-- Batch tagging SQL generated at 2026-01-06T06:59:02.076Z
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
  '1765283431359502',
  '천문 및 기상학연구원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 50, 70,
  70, 30, 50, 50, 50, 35,
  'regular', 'none', 'none', 'none',
  'master', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [천문연구원]\n-천체를 관측한다.\n-데이터를 수집한다.\n-현상을 분석한다.\n-모델을 개발한다.\n-연구 결과를 발표한다.\n-논문을 작성한다.\n-장비를 운영한다.\n-국제 협력을 한다.... 기반으로 50로 평가","growth":"growth는 [천문연구원]\n-천체를 관측한다.\n-데이터를 수집한다.\n-현상을 분석한다.\n-모델을 개발한다.\n-연구 결과를 발표한다.\n-논문을 작성한다.\n-장비를 운영한다.\n-국제 협력을 한다.... 기반으로 65로 평가","stability":"stability는 [천문연구원]\n-천체를 관측한다.\n-데이터를 수집한다.\n-현상을 분석한다.\n-모델을 개발한다.\n-연구 결과를 발표한다.\n-논문을 작성한다.\n-장비를 운영한다.\n-국제 협력을 한다.... 기반으로 50로 평가","income":"income는 [천문연구원]\n-천체를 관측한다.\n-데이터를 수집한다.\n-현상을 분석한다.\n-모델을 개발한다.\n-연구 결과를 발표한다.\n-논문을 작성한다.\n-장비를 운영한다.\n-국제 협력을 한다.... 기반으로 70로 평가","teamwork":"teamwork는 [천문연구원]\n-천체를 관측한다.\n-데이터를 수집한다.\n-현상을 분석한다.\n-모델을 개발한다.\n-연구 결과를 발표한다.\n-논문을 작성한다.\n-장비를 운영한다.\n-국제 협력을 한다.... 기반으로 70로 평가","solo_deep":"solo_deep는 [천문연구원]\n-천체를 관측한다.\n-데이터를 수집한다.\n-현상을 분석한다.\n-모델을 개발한다.\n-연구 결과를 발표한다.\n-논문을 작성한다.\n-장비를 운영한다.\n-국제 협력을 한다.... 기반으로 30로 평가","analytical":"analytical는 [천문연구원]\n-천체를 관측한다.\n-데이터를 수집한다.\n-현상을 분석한다.\n-모델을 개발한다.\n-연구 결과를 발표한다.\n-논문을 작성한다.\n-장비를 운영한다.\n-국제 협력을 한다.... 기반으로 50로 평가","creative":"creative는 [천문연구원]\n-천체를 관측한다.\n-데이터를 수집한다.\n-현상을 분석한다.\n-모델을 개발한다.\n-연구 결과를 발표한다.\n-논문을 작성한다.\n-장비를 운영한다.\n-국제 협력을 한다.... 기반으로 50로 평가","execution":"execution는 [천문연구원]\n-천체를 관측한다.\n-데이터를 수집한다.\n-현상을 분석한다.\n-모델을 개발한다.\n-연구 결과를 발표한다.\n-논문을 작성한다.\n-장비를 운영한다.\n-국제 협력을 한다.... 기반으로 50로 평가","people_facing":"people_facing는 [천문연구원]\n-천체를 관측한다.\n-데이터를 수집한다.\n-현상을 분석한다.\n-모델을 개발한다.\n-연구 결과를 발표한다.\n-논문을 작성한다.\n-장비를 운영한다.\n-국제 협력을 한다.... 기반으로 35로 평가","degree_required":"degree_required는 [천문연구원]\n-천체를 관측한다.\n-데이터를 수집한다.\n-현상을 분석한다.\n-모델을 개발한다.\n-연구 결과를 발표한다.\n-논문을 작성한다.\n-장비를 운영한다.\n-국제 협력을 한다.... 기반으로 master로 평가","license_required":"license_required는 [천문연구원]\n-천체를 관측한다.\n-데이터를 수집한다.\n-현상을 분석한다.\n-모델을 개발한다.\n-연구 결과를 발표한다.\n-논문을 작성한다.\n-장비를 운영한다.\n-국제 협력을 한다.... 기반으로 none로 평가"}'
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
  '1765283420725213',
  '생산관리사무원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 70, 50,
  70, 30, 60, 30, 60, 50,
  'regular', 'none', 'none', 'partial',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [생산관리사무원]\n-생산 계획을 수립한다.\n-자원을 배분한다.\n-생산 일정을 관리한다.\n-품질을 감독한다.\n-비용을 통제한다.\n-보고서를 작성한다.\n-데이터를 분석한다.\n-팀과 협... 기반으로 50로 평가","growth":"growth는 [생산관리사무원]\n-생산 계획을 수립한다.\n-자원을 배분한다.\n-생산 일정을 관리한다.\n-품질을 감독한다.\n-비용을 통제한다.\n-보고서를 작성한다.\n-데이터를 분석한다.\n-팀과 협... 기반으로 50로 평가","stability":"stability는 [생산관리사무원]\n-생산 계획을 수립한다.\n-자원을 배분한다.\n-생산 일정을 관리한다.\n-품질을 감독한다.\n-비용을 통제한다.\n-보고서를 작성한다.\n-데이터를 분석한다.\n-팀과 협... 기반으로 70로 평가","income":"income는 [생산관리사무원]\n-생산 계획을 수립한다.\n-자원을 배분한다.\n-생산 일정을 관리한다.\n-품질을 감독한다.\n-비용을 통제한다.\n-보고서를 작성한다.\n-데이터를 분석한다.\n-팀과 협... 기반으로 50로 평가","teamwork":"teamwork는 [생산관리사무원]\n-생산 계획을 수립한다.\n-자원을 배분한다.\n-생산 일정을 관리한다.\n-품질을 감독한다.\n-비용을 통제한다.\n-보고서를 작성한다.\n-데이터를 분석한다.\n-팀과 협... 기반으로 70로 평가","solo_deep":"solo_deep는 [생산관리사무원]\n-생산 계획을 수립한다.\n-자원을 배분한다.\n-생산 일정을 관리한다.\n-품질을 감독한다.\n-비용을 통제한다.\n-보고서를 작성한다.\n-데이터를 분석한다.\n-팀과 협... 기반으로 30로 평가","analytical":"analytical는 [생산관리사무원]\n-생산 계획을 수립한다.\n-자원을 배분한다.\n-생산 일정을 관리한다.\n-품질을 감독한다.\n-비용을 통제한다.\n-보고서를 작성한다.\n-데이터를 분석한다.\n-팀과 협... 기반으로 60로 평가","creative":"creative는 [생산관리사무원]\n-생산 계획을 수립한다.\n-자원을 배분한다.\n-생산 일정을 관리한다.\n-품질을 감독한다.\n-비용을 통제한다.\n-보고서를 작성한다.\n-데이터를 분석한다.\n-팀과 협... 기반으로 30로 평가","execution":"execution는 [생산관리사무원]\n-생산 계획을 수립한다.\n-자원을 배분한다.\n-생산 일정을 관리한다.\n-품질을 감독한다.\n-비용을 통제한다.\n-보고서를 작성한다.\n-데이터를 분석한다.\n-팀과 협... 기반으로 60로 평가","people_facing":"people_facing는 [생산관리사무원]\n-생산 계획을 수립한다.\n-자원을 배분한다.\n-생산 일정을 관리한다.\n-품질을 감독한다.\n-비용을 통제한다.\n-보고서를 작성한다.\n-데이터를 분석한다.\n-팀과 협... 기반으로 50로 평가","degree_required":"degree_required는 [생산관리사무원]\n-생산 계획을 수립한다.\n-자원을 배분한다.\n-생산 일정을 관리한다.\n-품질을 감독한다.\n-비용을 통제한다.\n-보고서를 작성한다.\n-데이터를 분석한다.\n-팀과 협... 기반으로 none로 평가","license_required":"license_required는 [생산관리사무원]\n-생산 계획을 수립한다.\n-자원을 배분한다.\n-생산 일정을 관리한다.\n-품질을 감독한다.\n-비용을 통제한다.\n-보고서를 작성한다.\n-데이터를 분석한다.\n-팀과 협... 기반으로 none로 평가"}'
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
  '1765283467066152',
  '놀이치료사',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 50, 70,
  70, 30, 60, 60, 30, 50,
  'regular', 'none', 'none', 'none',
  'bachelor', 'required', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [놀이치료사]\n-환자의 상태를 평가한다.\n-치료 목표를 설정한다.\n-놀이 활동을 기획한다.\n-치료 세션을 진행한다.\n-행동을 관찰한다.\n-진전을 기록한다.\n-보고서를 작성한다.\n-... 기반으로 50로 평가","growth":"growth는 [놀이치료사]\n-환자의 상태를 평가한다.\n-치료 목표를 설정한다.\n-놀이 활동을 기획한다.\n-치료 세션을 진행한다.\n-행동을 관찰한다.\n-진전을 기록한다.\n-보고서를 작성한다.\n-... 기반으로 65로 평가","stability":"stability는 [놀이치료사]\n-환자의 상태를 평가한다.\n-치료 목표를 설정한다.\n-놀이 활동을 기획한다.\n-치료 세션을 진행한다.\n-행동을 관찰한다.\n-진전을 기록한다.\n-보고서를 작성한다.\n-... 기반으로 50로 평가","income":"income는 [놀이치료사]\n-환자의 상태를 평가한다.\n-치료 목표를 설정한다.\n-놀이 활동을 기획한다.\n-치료 세션을 진행한다.\n-행동을 관찰한다.\n-진전을 기록한다.\n-보고서를 작성한다.\n-... 기반으로 70로 평가","teamwork":"teamwork는 [놀이치료사]\n-환자의 상태를 평가한다.\n-치료 목표를 설정한다.\n-놀이 활동을 기획한다.\n-치료 세션을 진행한다.\n-행동을 관찰한다.\n-진전을 기록한다.\n-보고서를 작성한다.\n-... 기반으로 70로 평가","solo_deep":"solo_deep는 [놀이치료사]\n-환자의 상태를 평가한다.\n-치료 목표를 설정한다.\n-놀이 활동을 기획한다.\n-치료 세션을 진행한다.\n-행동을 관찰한다.\n-진전을 기록한다.\n-보고서를 작성한다.\n-... 기반으로 30로 평가","analytical":"analytical는 [놀이치료사]\n-환자의 상태를 평가한다.\n-치료 목표를 설정한다.\n-놀이 활동을 기획한다.\n-치료 세션을 진행한다.\n-행동을 관찰한다.\n-진전을 기록한다.\n-보고서를 작성한다.\n-... 기반으로 60로 평가","creative":"creative는 [놀이치료사]\n-환자의 상태를 평가한다.\n-치료 목표를 설정한다.\n-놀이 활동을 기획한다.\n-치료 세션을 진행한다.\n-행동을 관찰한다.\n-진전을 기록한다.\n-보고서를 작성한다.\n-... 기반으로 60로 평가","execution":"execution는 [놀이치료사]\n-환자의 상태를 평가한다.\n-치료 목표를 설정한다.\n-놀이 활동을 기획한다.\n-치료 세션을 진행한다.\n-행동을 관찰한다.\n-진전을 기록한다.\n-보고서를 작성한다.\n-... 기반으로 30로 평가","people_facing":"people_facing는 [놀이치료사]\n-환자의 상태를 평가한다.\n-치료 목표를 설정한다.\n-놀이 활동을 기획한다.\n-치료 세션을 진행한다.\n-행동을 관찰한다.\n-진전을 기록한다.\n-보고서를 작성한다.\n-... 기반으로 50로 평가","degree_required":"degree_required는 [놀이치료사]\n-환자의 상태를 평가한다.\n-치료 목표를 설정한다.\n-놀이 활동을 기획한다.\n-치료 세션을 진행한다.\n-행동을 관찰한다.\n-진전을 기록한다.\n-보고서를 작성한다.\n-... 기반으로 bachelor로 평가","license_required":"license_required는 [놀이치료사]\n-환자의 상태를 평가한다.\n-치료 목표를 설정한다.\n-놀이 활동을 기획한다.\n-치료 세션을 진행한다.\n-행동을 관찰한다.\n-진전을 기록한다.\n-보고서를 작성한다.\n-... 기반으로 required로 평가"}'
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
  '1765283491108237',
  '헬리콥터조종사',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  50, 50, 40, 40, 70, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [헬리콥터조종사]\n-비행 계획을 수립한다.\n-헬리콥터를 점검한다.\n-이륙과 착륙을 한다.\n-비행을 조종한다.\n-특별 임무를 수행한다.\n-비상 상황에 대응한다.\n-승객과 화물을 운송... 기반으로 50로 평가","growth":"growth는 [헬리콥터조종사]\n-비행 계획을 수립한다.\n-헬리콥터를 점검한다.\n-이륙과 착륙을 한다.\n-비행을 조종한다.\n-특별 임무를 수행한다.\n-비상 상황에 대응한다.\n-승객과 화물을 운송... 기반으로 50로 평가","stability":"stability는 [헬리콥터조종사]\n-비행 계획을 수립한다.\n-헬리콥터를 점검한다.\n-이륙과 착륙을 한다.\n-비행을 조종한다.\n-특별 임무를 수행한다.\n-비상 상황에 대응한다.\n-승객과 화물을 운송... 기반으로 50로 평가","income":"income는 [헬리콥터조종사]\n-비행 계획을 수립한다.\n-헬리콥터를 점검한다.\n-이륙과 착륙을 한다.\n-비행을 조종한다.\n-특별 임무를 수행한다.\n-비상 상황에 대응한다.\n-승객과 화물을 운송... 기반으로 50로 평가","teamwork":"teamwork는 [헬리콥터조종사]\n-비행 계획을 수립한다.\n-헬리콥터를 점검한다.\n-이륙과 착륙을 한다.\n-비행을 조종한다.\n-특별 임무를 수행한다.\n-비상 상황에 대응한다.\n-승객과 화물을 운송... 기반으로 50로 평가","solo_deep":"solo_deep는 [헬리콥터조종사]\n-비행 계획을 수립한다.\n-헬리콥터를 점검한다.\n-이륙과 착륙을 한다.\n-비행을 조종한다.\n-특별 임무를 수행한다.\n-비상 상황에 대응한다.\n-승객과 화물을 운송... 기반으로 50로 평가","analytical":"analytical는 [헬리콥터조종사]\n-비행 계획을 수립한다.\n-헬리콥터를 점검한다.\n-이륙과 착륙을 한다.\n-비행을 조종한다.\n-특별 임무를 수행한다.\n-비상 상황에 대응한다.\n-승객과 화물을 운송... 기반으로 40로 평가","creative":"creative는 [헬리콥터조종사]\n-비행 계획을 수립한다.\n-헬리콥터를 점검한다.\n-이륙과 착륙을 한다.\n-비행을 조종한다.\n-특별 임무를 수행한다.\n-비상 상황에 대응한다.\n-승객과 화물을 운송... 기반으로 40로 평가","execution":"execution는 [헬리콥터조종사]\n-비행 계획을 수립한다.\n-헬리콥터를 점검한다.\n-이륙과 착륙을 한다.\n-비행을 조종한다.\n-특별 임무를 수행한다.\n-비상 상황에 대응한다.\n-승객과 화물을 운송... 기반으로 70로 평가","people_facing":"people_facing는 [헬리콥터조종사]\n-비행 계획을 수립한다.\n-헬리콥터를 점검한다.\n-이륙과 착륙을 한다.\n-비행을 조종한다.\n-특별 임무를 수행한다.\n-비상 상황에 대응한다.\n-승객과 화물을 운송... 기반으로 50로 평가","degree_required":"degree_required는 [헬리콥터조종사]\n-비행 계획을 수립한다.\n-헬리콥터를 점검한다.\n-이륙과 착륙을 한다.\n-비행을 조종한다.\n-특별 임무를 수행한다.\n-비상 상황에 대응한다.\n-승객과 화물을 운송... 기반으로 none로 평가","license_required":"license_required는 [헬리콥터조종사]\n-비행 계획을 수립한다.\n-헬리콥터를 점검한다.\n-이륙과 착륙을 한다.\n-비행을 조종한다.\n-특별 임무를 수행한다.\n-비상 상황에 대응한다.\n-승객과 화물을 운송... 기반으로 none로 평가"}'
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
  '1765283498658352',
  '도배공',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  50, 50, 40, 40, 70, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [도배공]\n-벽면을 준비한다.\n-벽지를 선택한다.\n-풀을 바른다.\n-벽지를 붙인다.\n-기포를 제거한다.\n-마무리를 한다.\n-품질을 검사한다.\n-안전 수칙을 준수한다.\n-도구를 관리... 기반으로 50로 평가","growth":"growth는 [도배공]\n-벽면을 준비한다.\n-벽지를 선택한다.\n-풀을 바른다.\n-벽지를 붙인다.\n-기포를 제거한다.\n-마무리를 한다.\n-품질을 검사한다.\n-안전 수칙을 준수한다.\n-도구를 관리... 기반으로 50로 평가","stability":"stability는 [도배공]\n-벽면을 준비한다.\n-벽지를 선택한다.\n-풀을 바른다.\n-벽지를 붙인다.\n-기포를 제거한다.\n-마무리를 한다.\n-품질을 검사한다.\n-안전 수칙을 준수한다.\n-도구를 관리... 기반으로 50로 평가","income":"income는 [도배공]\n-벽면을 준비한다.\n-벽지를 선택한다.\n-풀을 바른다.\n-벽지를 붙인다.\n-기포를 제거한다.\n-마무리를 한다.\n-품질을 검사한다.\n-안전 수칙을 준수한다.\n-도구를 관리... 기반으로 50로 평가","teamwork":"teamwork는 [도배공]\n-벽면을 준비한다.\n-벽지를 선택한다.\n-풀을 바른다.\n-벽지를 붙인다.\n-기포를 제거한다.\n-마무리를 한다.\n-품질을 검사한다.\n-안전 수칙을 준수한다.\n-도구를 관리... 기반으로 50로 평가","solo_deep":"solo_deep는 [도배공]\n-벽면을 준비한다.\n-벽지를 선택한다.\n-풀을 바른다.\n-벽지를 붙인다.\n-기포를 제거한다.\n-마무리를 한다.\n-품질을 검사한다.\n-안전 수칙을 준수한다.\n-도구를 관리... 기반으로 50로 평가","analytical":"analytical는 [도배공]\n-벽면을 준비한다.\n-벽지를 선택한다.\n-풀을 바른다.\n-벽지를 붙인다.\n-기포를 제거한다.\n-마무리를 한다.\n-품질을 검사한다.\n-안전 수칙을 준수한다.\n-도구를 관리... 기반으로 40로 평가","creative":"creative는 [도배공]\n-벽면을 준비한다.\n-벽지를 선택한다.\n-풀을 바른다.\n-벽지를 붙인다.\n-기포를 제거한다.\n-마무리를 한다.\n-품질을 검사한다.\n-안전 수칙을 준수한다.\n-도구를 관리... 기반으로 40로 평가","execution":"execution는 [도배공]\n-벽면을 준비한다.\n-벽지를 선택한다.\n-풀을 바른다.\n-벽지를 붙인다.\n-기포를 제거한다.\n-마무리를 한다.\n-품질을 검사한다.\n-안전 수칙을 준수한다.\n-도구를 관리... 기반으로 70로 평가","people_facing":"people_facing는 [도배공]\n-벽면을 준비한다.\n-벽지를 선택한다.\n-풀을 바른다.\n-벽지를 붙인다.\n-기포를 제거한다.\n-마무리를 한다.\n-품질을 검사한다.\n-안전 수칙을 준수한다.\n-도구를 관리... 기반으로 50로 평가","degree_required":"degree_required는 [도배공]\n-벽면을 준비한다.\n-벽지를 선택한다.\n-풀을 바른다.\n-벽지를 붙인다.\n-기포를 제거한다.\n-마무리를 한다.\n-품질을 검사한다.\n-안전 수칙을 준수한다.\n-도구를 관리... 기반으로 none로 평가","license_required":"license_required는 [도배공]\n-벽면을 준비한다.\n-벽지를 선택한다.\n-풀을 바른다.\n-벽지를 붙인다.\n-기포를 제거한다.\n-마무리를 한다.\n-품질을 검사한다.\n-안전 수칙을 준수한다.\n-도구를 관리... 기반으로 none로 평가"}'
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
  '1765283425058548',
  '비서',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  40, 50, 70, 50,
  50, 50, 40, 40, 70, 50,
  'overtime_some', 'none', 'some', 'partial',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [비서]\n-일정을 관리한다.\n-회의를 준비한다.\n-문서를 작성한다.\n-통화를 처리한다.\n-방문객을 응대한다.\n-자료를 정리한다.\n-여행을 준비한다.\n-개인 업무를 지원한다.\n-기밀... 기반으로 40로 평가","growth":"growth는 [비서]\n-일정을 관리한다.\n-회의를 준비한다.\n-문서를 작성한다.\n-통화를 처리한다.\n-방문객을 응대한다.\n-자료를 정리한다.\n-여행을 준비한다.\n-개인 업무를 지원한다.\n-기밀... 기반으로 50로 평가","stability":"stability는 [비서]\n-일정을 관리한다.\n-회의를 준비한다.\n-문서를 작성한다.\n-통화를 처리한다.\n-방문객을 응대한다.\n-자료를 정리한다.\n-여행을 준비한다.\n-개인 업무를 지원한다.\n-기밀... 기반으로 70로 평가","income":"income는 [비서]\n-일정을 관리한다.\n-회의를 준비한다.\n-문서를 작성한다.\n-통화를 처리한다.\n-방문객을 응대한다.\n-자료를 정리한다.\n-여행을 준비한다.\n-개인 업무를 지원한다.\n-기밀... 기반으로 50로 평가","teamwork":"teamwork는 [비서]\n-일정을 관리한다.\n-회의를 준비한다.\n-문서를 작성한다.\n-통화를 처리한다.\n-방문객을 응대한다.\n-자료를 정리한다.\n-여행을 준비한다.\n-개인 업무를 지원한다.\n-기밀... 기반으로 50로 평가","solo_deep":"solo_deep는 [비서]\n-일정을 관리한다.\n-회의를 준비한다.\n-문서를 작성한다.\n-통화를 처리한다.\n-방문객을 응대한다.\n-자료를 정리한다.\n-여행을 준비한다.\n-개인 업무를 지원한다.\n-기밀... 기반으로 50로 평가","analytical":"analytical는 [비서]\n-일정을 관리한다.\n-회의를 준비한다.\n-문서를 작성한다.\n-통화를 처리한다.\n-방문객을 응대한다.\n-자료를 정리한다.\n-여행을 준비한다.\n-개인 업무를 지원한다.\n-기밀... 기반으로 40로 평가","creative":"creative는 [비서]\n-일정을 관리한다.\n-회의를 준비한다.\n-문서를 작성한다.\n-통화를 처리한다.\n-방문객을 응대한다.\n-자료를 정리한다.\n-여행을 준비한다.\n-개인 업무를 지원한다.\n-기밀... 기반으로 40로 평가","execution":"execution는 [비서]\n-일정을 관리한다.\n-회의를 준비한다.\n-문서를 작성한다.\n-통화를 처리한다.\n-방문객을 응대한다.\n-자료를 정리한다.\n-여행을 준비한다.\n-개인 업무를 지원한다.\n-기밀... 기반으로 70로 평가","people_facing":"people_facing는 [비서]\n-일정을 관리한다.\n-회의를 준비한다.\n-문서를 작성한다.\n-통화를 처리한다.\n-방문객을 응대한다.\n-자료를 정리한다.\n-여행을 준비한다.\n-개인 업무를 지원한다.\n-기밀... 기반으로 50로 평가","degree_required":"degree_required는 [비서]\n-일정을 관리한다.\n-회의를 준비한다.\n-문서를 작성한다.\n-통화를 처리한다.\n-방문객을 응대한다.\n-자료를 정리한다.\n-여행을 준비한다.\n-개인 업무를 지원한다.\n-기밀... 기반으로 none로 평가","license_required":"license_required는 [비서]\n-일정을 관리한다.\n-회의를 준비한다.\n-문서를 작성한다.\n-통화를 처리한다.\n-방문객을 응대한다.\n-자료를 정리한다.\n-여행을 준비한다.\n-개인 업무를 지원한다.\n-기밀... 기반으로 none로 평가"}'
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
  '1765283470661316',
  '의상디자이너',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 50, 40,
  50, 50, 50, 50, 50, 35,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [의상디자이너]\n-콘셉트를 개발한다.\n-스케치를 그린다.\n-패턴을 설계한다.\n-원단을 선택한다.\n-프로토타입을 만든다.\n-수정을 한다.\n-컬렉션을 기획한다.\n-시장 동향을 분석한다... 기반으로 50로 평가","growth":"growth는 [의상디자이너]\n-콘셉트를 개발한다.\n-스케치를 그린다.\n-패턴을 설계한다.\n-원단을 선택한다.\n-프로토타입을 만든다.\n-수정을 한다.\n-컬렉션을 기획한다.\n-시장 동향을 분석한다... 기반으로 65로 평가","stability":"stability는 [의상디자이너]\n-콘셉트를 개발한다.\n-스케치를 그린다.\n-패턴을 설계한다.\n-원단을 선택한다.\n-프로토타입을 만든다.\n-수정을 한다.\n-컬렉션을 기획한다.\n-시장 동향을 분석한다... 기반으로 50로 평가","income":"income는 [의상디자이너]\n-콘셉트를 개발한다.\n-스케치를 그린다.\n-패턴을 설계한다.\n-원단을 선택한다.\n-프로토타입을 만든다.\n-수정을 한다.\n-컬렉션을 기획한다.\n-시장 동향을 분석한다... 기반으로 40로 평가","teamwork":"teamwork는 [의상디자이너]\n-콘셉트를 개발한다.\n-스케치를 그린다.\n-패턴을 설계한다.\n-원단을 선택한다.\n-프로토타입을 만든다.\n-수정을 한다.\n-컬렉션을 기획한다.\n-시장 동향을 분석한다... 기반으로 50로 평가","solo_deep":"solo_deep는 [의상디자이너]\n-콘셉트를 개발한다.\n-스케치를 그린다.\n-패턴을 설계한다.\n-원단을 선택한다.\n-프로토타입을 만든다.\n-수정을 한다.\n-컬렉션을 기획한다.\n-시장 동향을 분석한다... 기반으로 50로 평가","analytical":"analytical는 [의상디자이너]\n-콘셉트를 개발한다.\n-스케치를 그린다.\n-패턴을 설계한다.\n-원단을 선택한다.\n-프로토타입을 만든다.\n-수정을 한다.\n-컬렉션을 기획한다.\n-시장 동향을 분석한다... 기반으로 50로 평가","creative":"creative는 [의상디자이너]\n-콘셉트를 개발한다.\n-스케치를 그린다.\n-패턴을 설계한다.\n-원단을 선택한다.\n-프로토타입을 만든다.\n-수정을 한다.\n-컬렉션을 기획한다.\n-시장 동향을 분석한다... 기반으로 50로 평가","execution":"execution는 [의상디자이너]\n-콘셉트를 개발한다.\n-스케치를 그린다.\n-패턴을 설계한다.\n-원단을 선택한다.\n-프로토타입을 만든다.\n-수정을 한다.\n-컬렉션을 기획한다.\n-시장 동향을 분석한다... 기반으로 50로 평가","people_facing":"people_facing는 [의상디자이너]\n-콘셉트를 개발한다.\n-스케치를 그린다.\n-패턴을 설계한다.\n-원단을 선택한다.\n-프로토타입을 만든다.\n-수정을 한다.\n-컬렉션을 기획한다.\n-시장 동향을 분석한다... 기반으로 35로 평가","degree_required":"degree_required는 [의상디자이너]\n-콘셉트를 개발한다.\n-스케치를 그린다.\n-패턴을 설계한다.\n-원단을 선택한다.\n-프로토타입을 만든다.\n-수정을 한다.\n-컬렉션을 기획한다.\n-시장 동향을 분석한다... 기반으로 none로 평가","license_required":"license_required는 [의상디자이너]\n-콘셉트를 개발한다.\n-스케치를 그린다.\n-패턴을 설계한다.\n-원단을 선택한다.\n-프로토타입을 만든다.\n-수정을 한다.\n-컬렉션을 기획한다.\n-시장 동향을 분석한다... 기반으로 none로 평가"}'
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
  '1765283470950965',
  '영상그래픽디자이너',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 50, 40,
  70, 30, 40, 70, 40, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [영상그래픽디자이너]\n-콘셉트를 기획한다.\n-스토리보드를 작성한다.\n-그래픽을 디자인한다.\n-애니메이션을 만든다.\n-특수 효과를 추가한다.\n-색상을 조정한다.\n-최종 편집을 한다.... 기반으로 50로 평가","growth":"growth는 [영상그래픽디자이너]\n-콘셉트를 기획한다.\n-스토리보드를 작성한다.\n-그래픽을 디자인한다.\n-애니메이션을 만든다.\n-특수 효과를 추가한다.\n-색상을 조정한다.\n-최종 편집을 한다.... 기반으로 65로 평가","stability":"stability는 [영상그래픽디자이너]\n-콘셉트를 기획한다.\n-스토리보드를 작성한다.\n-그래픽을 디자인한다.\n-애니메이션을 만든다.\n-특수 효과를 추가한다.\n-색상을 조정한다.\n-최종 편집을 한다.... 기반으로 50로 평가","income":"income는 [영상그래픽디자이너]\n-콘셉트를 기획한다.\n-스토리보드를 작성한다.\n-그래픽을 디자인한다.\n-애니메이션을 만든다.\n-특수 효과를 추가한다.\n-색상을 조정한다.\n-최종 편집을 한다.... 기반으로 40로 평가","teamwork":"teamwork는 [영상그래픽디자이너]\n-콘셉트를 기획한다.\n-스토리보드를 작성한다.\n-그래픽을 디자인한다.\n-애니메이션을 만든다.\n-특수 효과를 추가한다.\n-색상을 조정한다.\n-최종 편집을 한다.... 기반으로 70로 평가","solo_deep":"solo_deep는 [영상그래픽디자이너]\n-콘셉트를 기획한다.\n-스토리보드를 작성한다.\n-그래픽을 디자인한다.\n-애니메이션을 만든다.\n-특수 효과를 추가한다.\n-색상을 조정한다.\n-최종 편집을 한다.... 기반으로 30로 평가","analytical":"analytical는 [영상그래픽디자이너]\n-콘셉트를 기획한다.\n-스토리보드를 작성한다.\n-그래픽을 디자인한다.\n-애니메이션을 만든다.\n-특수 효과를 추가한다.\n-색상을 조정한다.\n-최종 편집을 한다.... 기반으로 40로 평가","creative":"creative는 [영상그래픽디자이너]\n-콘셉트를 기획한다.\n-스토리보드를 작성한다.\n-그래픽을 디자인한다.\n-애니메이션을 만든다.\n-특수 효과를 추가한다.\n-색상을 조정한다.\n-최종 편집을 한다.... 기반으로 70로 평가","execution":"execution는 [영상그래픽디자이너]\n-콘셉트를 기획한다.\n-스토리보드를 작성한다.\n-그래픽을 디자인한다.\n-애니메이션을 만든다.\n-특수 효과를 추가한다.\n-색상을 조정한다.\n-최종 편집을 한다.... 기반으로 40로 평가","people_facing":"people_facing는 [영상그래픽디자이너]\n-콘셉트를 기획한다.\n-스토리보드를 작성한다.\n-그래픽을 디자인한다.\n-애니메이션을 만든다.\n-특수 효과를 추가한다.\n-색상을 조정한다.\n-최종 편집을 한다.... 기반으로 50로 평가","degree_required":"degree_required는 [영상그래픽디자이너]\n-콘셉트를 기획한다.\n-스토리보드를 작성한다.\n-그래픽을 디자인한다.\n-애니메이션을 만든다.\n-특수 효과를 추가한다.\n-색상을 조정한다.\n-최종 편집을 한다.... 기반으로 none로 평가","license_required":"license_required는 [영상그래픽디자이너]\n-콘셉트를 기획한다.\n-스토리보드를 작성한다.\n-그래픽을 디자인한다.\n-애니메이션을 만든다.\n-특수 효과를 추가한다.\n-색상을 조정한다.\n-최종 편집을 한다.... 기반으로 none로 평가"}'
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
  '1765283495857332',
  '경량철골공',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 50, 50,
  50, 50, 40, 40, 70, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [경량철골공]\n-철골 구조를 설계한다.\n-재료를 재단한다.\n-용접을 한다.\n-조립을 실시한다.\n-설치를 한다.\n-안전 검사를 한다.\n-마무리를 한다.\n-유지보수를 한다.\n-안전 수... 기반으로 50로 평가","growth":"growth는 [경량철골공]\n-철골 구조를 설계한다.\n-재료를 재단한다.\n-용접을 한다.\n-조립을 실시한다.\n-설치를 한다.\n-안전 검사를 한다.\n-마무리를 한다.\n-유지보수를 한다.\n-안전 수... 기반으로 65로 평가","stability":"stability는 [경량철골공]\n-철골 구조를 설계한다.\n-재료를 재단한다.\n-용접을 한다.\n-조립을 실시한다.\n-설치를 한다.\n-안전 검사를 한다.\n-마무리를 한다.\n-유지보수를 한다.\n-안전 수... 기반으로 50로 평가","income":"income는 [경량철골공]\n-철골 구조를 설계한다.\n-재료를 재단한다.\n-용접을 한다.\n-조립을 실시한다.\n-설치를 한다.\n-안전 검사를 한다.\n-마무리를 한다.\n-유지보수를 한다.\n-안전 수... 기반으로 50로 평가","teamwork":"teamwork는 [경량철골공]\n-철골 구조를 설계한다.\n-재료를 재단한다.\n-용접을 한다.\n-조립을 실시한다.\n-설치를 한다.\n-안전 검사를 한다.\n-마무리를 한다.\n-유지보수를 한다.\n-안전 수... 기반으로 50로 평가","solo_deep":"solo_deep는 [경량철골공]\n-철골 구조를 설계한다.\n-재료를 재단한다.\n-용접을 한다.\n-조립을 실시한다.\n-설치를 한다.\n-안전 검사를 한다.\n-마무리를 한다.\n-유지보수를 한다.\n-안전 수... 기반으로 50로 평가","analytical":"analytical는 [경량철골공]\n-철골 구조를 설계한다.\n-재료를 재단한다.\n-용접을 한다.\n-조립을 실시한다.\n-설치를 한다.\n-안전 검사를 한다.\n-마무리를 한다.\n-유지보수를 한다.\n-안전 수... 기반으로 40로 평가","creative":"creative는 [경량철골공]\n-철골 구조를 설계한다.\n-재료를 재단한다.\n-용접을 한다.\n-조립을 실시한다.\n-설치를 한다.\n-안전 검사를 한다.\n-마무리를 한다.\n-유지보수를 한다.\n-안전 수... 기반으로 40로 평가","execution":"execution는 [경량철골공]\n-철골 구조를 설계한다.\n-재료를 재단한다.\n-용접을 한다.\n-조립을 실시한다.\n-설치를 한다.\n-안전 검사를 한다.\n-마무리를 한다.\n-유지보수를 한다.\n-안전 수... 기반으로 70로 평가","people_facing":"people_facing는 [경량철골공]\n-철골 구조를 설계한다.\n-재료를 재단한다.\n-용접을 한다.\n-조립을 실시한다.\n-설치를 한다.\n-안전 검사를 한다.\n-마무리를 한다.\n-유지보수를 한다.\n-안전 수... 기반으로 50로 평가","degree_required":"degree_required는 [경량철골공]\n-철골 구조를 설계한다.\n-재료를 재단한다.\n-용접을 한다.\n-조립을 실시한다.\n-설치를 한다.\n-안전 검사를 한다.\n-마무리를 한다.\n-유지보수를 한다.\n-안전 수... 기반으로 none로 평가","license_required":"license_required는 [경량철골공]\n-철골 구조를 설계한다.\n-재료를 재단한다.\n-용접을 한다.\n-조립을 실시한다.\n-설치를 한다.\n-안전 검사를 한다.\n-마무리를 한다.\n-유지보수를 한다.\n-안전 수... 기반으로 none로 평가"}'
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
  '17652834817679',
  '일식조리사',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  50, 50, 50, 50, 50, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [일식조리사]\n-신선한 재료를 준비한다.\n-전통 조리법을 따른다.\n-스시를 만든다.\n-덴푸라를 튀긴다.\n-국물을 우린다.\n-밥을 짓는다.\n-접시를 장식한다.\n-품질을 유지한다.\n-... 기반으로 50로 평가","growth":"growth는 [일식조리사]\n-신선한 재료를 준비한다.\n-전통 조리법을 따른다.\n-스시를 만든다.\n-덴푸라를 튀긴다.\n-국물을 우린다.\n-밥을 짓는다.\n-접시를 장식한다.\n-품질을 유지한다.\n-... 기반으로 50로 평가","stability":"stability는 [일식조리사]\n-신선한 재료를 준비한다.\n-전통 조리법을 따른다.\n-스시를 만든다.\n-덴푸라를 튀긴다.\n-국물을 우린다.\n-밥을 짓는다.\n-접시를 장식한다.\n-품질을 유지한다.\n-... 기반으로 50로 평가","income":"income는 [일식조리사]\n-신선한 재료를 준비한다.\n-전통 조리법을 따른다.\n-스시를 만든다.\n-덴푸라를 튀긴다.\n-국물을 우린다.\n-밥을 짓는다.\n-접시를 장식한다.\n-품질을 유지한다.\n-... 기반으로 50로 평가","teamwork":"teamwork는 [일식조리사]\n-신선한 재료를 준비한다.\n-전통 조리법을 따른다.\n-스시를 만든다.\n-덴푸라를 튀긴다.\n-국물을 우린다.\n-밥을 짓는다.\n-접시를 장식한다.\n-품질을 유지한다.\n-... 기반으로 50로 평가","solo_deep":"solo_deep는 [일식조리사]\n-신선한 재료를 준비한다.\n-전통 조리법을 따른다.\n-스시를 만든다.\n-덴푸라를 튀긴다.\n-국물을 우린다.\n-밥을 짓는다.\n-접시를 장식한다.\n-품질을 유지한다.\n-... 기반으로 50로 평가","analytical":"analytical는 [일식조리사]\n-신선한 재료를 준비한다.\n-전통 조리법을 따른다.\n-스시를 만든다.\n-덴푸라를 튀긴다.\n-국물을 우린다.\n-밥을 짓는다.\n-접시를 장식한다.\n-품질을 유지한다.\n-... 기반으로 50로 평가","creative":"creative는 [일식조리사]\n-신선한 재료를 준비한다.\n-전통 조리법을 따른다.\n-스시를 만든다.\n-덴푸라를 튀긴다.\n-국물을 우린다.\n-밥을 짓는다.\n-접시를 장식한다.\n-품질을 유지한다.\n-... 기반으로 50로 평가","execution":"execution는 [일식조리사]\n-신선한 재료를 준비한다.\n-전통 조리법을 따른다.\n-스시를 만든다.\n-덴푸라를 튀긴다.\n-국물을 우린다.\n-밥을 짓는다.\n-접시를 장식한다.\n-품질을 유지한다.\n-... 기반으로 50로 평가","people_facing":"people_facing는 [일식조리사]\n-신선한 재료를 준비한다.\n-전통 조리법을 따른다.\n-스시를 만든다.\n-덴푸라를 튀긴다.\n-국물을 우린다.\n-밥을 짓는다.\n-접시를 장식한다.\n-품질을 유지한다.\n-... 기반으로 50로 평가","degree_required":"degree_required는 [일식조리사]\n-신선한 재료를 준비한다.\n-전통 조리법을 따른다.\n-스시를 만든다.\n-덴푸라를 튀긴다.\n-국물을 우린다.\n-밥을 짓는다.\n-접시를 장식한다.\n-품질을 유지한다.\n-... 기반으로 none로 평가","license_required":"license_required는 [일식조리사]\n-신선한 재료를 준비한다.\n-전통 조리법을 따른다.\n-스시를 만든다.\n-덴푸라를 튀긴다.\n-국물을 우린다.\n-밥을 짓는다.\n-접시를 장식한다.\n-품질을 유지한다.\n-... 기반으로 none로 평가"}'
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