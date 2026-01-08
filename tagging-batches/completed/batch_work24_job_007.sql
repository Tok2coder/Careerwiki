-- Batch tagging SQL generated at 2026-01-06T07:01:33.612Z
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
  '1765283412377363',
  '운송관리자',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  70, 30, 40, 40, 70, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [운송관리자]\n-운송 계획을 수립한다.\n-차량을 배분한다.\n-운송 경로를 최적화한다.\n-운송업체를 관리한다.\n-화물 추적을 한다.\n-비용을 통제한다.\n-안전 수칙을 준수한다.\n-보... 기반으로 50로 평가","growth":"growth는 [운송관리자]\n-운송 계획을 수립한다.\n-차량을 배분한다.\n-운송 경로를 최적화한다.\n-운송업체를 관리한다.\n-화물 추적을 한다.\n-비용을 통제한다.\n-안전 수칙을 준수한다.\n-보... 기반으로 50로 평가","stability":"stability는 [운송관리자]\n-운송 계획을 수립한다.\n-차량을 배분한다.\n-운송 경로를 최적화한다.\n-운송업체를 관리한다.\n-화물 추적을 한다.\n-비용을 통제한다.\n-안전 수칙을 준수한다.\n-보... 기반으로 50로 평가","income":"income는 [운송관리자]\n-운송 계획을 수립한다.\n-차량을 배분한다.\n-운송 경로를 최적화한다.\n-운송업체를 관리한다.\n-화물 추적을 한다.\n-비용을 통제한다.\n-안전 수칙을 준수한다.\n-보... 기반으로 50로 평가","teamwork":"teamwork는 [운송관리자]\n-운송 계획을 수립한다.\n-차량을 배분한다.\n-운송 경로를 최적화한다.\n-운송업체를 관리한다.\n-화물 추적을 한다.\n-비용을 통제한다.\n-안전 수칙을 준수한다.\n-보... 기반으로 70로 평가","solo_deep":"solo_deep는 [운송관리자]\n-운송 계획을 수립한다.\n-차량을 배분한다.\n-운송 경로를 최적화한다.\n-운송업체를 관리한다.\n-화물 추적을 한다.\n-비용을 통제한다.\n-안전 수칙을 준수한다.\n-보... 기반으로 30로 평가","analytical":"analytical는 [운송관리자]\n-운송 계획을 수립한다.\n-차량을 배분한다.\n-운송 경로를 최적화한다.\n-운송업체를 관리한다.\n-화물 추적을 한다.\n-비용을 통제한다.\n-안전 수칙을 준수한다.\n-보... 기반으로 40로 평가","creative":"creative는 [운송관리자]\n-운송 계획을 수립한다.\n-차량을 배분한다.\n-운송 경로를 최적화한다.\n-운송업체를 관리한다.\n-화물 추적을 한다.\n-비용을 통제한다.\n-안전 수칙을 준수한다.\n-보... 기반으로 40로 평가","execution":"execution는 [운송관리자]\n-운송 계획을 수립한다.\n-차량을 배분한다.\n-운송 경로를 최적화한다.\n-운송업체를 관리한다.\n-화물 추적을 한다.\n-비용을 통제한다.\n-안전 수칙을 준수한다.\n-보... 기반으로 70로 평가","people_facing":"people_facing는 [운송관리자]\n-운송 계획을 수립한다.\n-차량을 배분한다.\n-운송 경로를 최적화한다.\n-운송업체를 관리한다.\n-화물 추적을 한다.\n-비용을 통제한다.\n-안전 수칙을 준수한다.\n-보... 기반으로 50로 평가","degree_required":"degree_required는 [운송관리자]\n-운송 계획을 수립한다.\n-차량을 배분한다.\n-운송 경로를 최적화한다.\n-운송업체를 관리한다.\n-화물 추적을 한다.\n-비용을 통제한다.\n-안전 수칙을 준수한다.\n-보... 기반으로 none로 평가","license_required":"license_required는 [운송관리자]\n-운송 계획을 수립한다.\n-차량을 배분한다.\n-운송 경로를 최적화한다.\n-운송업체를 관리한다.\n-화물 추적을 한다.\n-비용을 통제한다.\n-안전 수칙을 준수한다.\n-보... 기반으로 none로 평가"}'
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
  '176528348109248',
  '양식조리사',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 75, 50, 50,
  50, 50, 30, 60, 60, 35,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [양식조리사]\n-양식 요리를 한다.\n-재료를 준비한다.\n-조리법을 따른다.\n-맛을 조절한다.\n-접시를 장식한다.\n-위생을 유지한다.\n-메뉴를 개발한다.\n-재고를 관리한다.\n-교육을... 기반으로 50로 평가","growth":"growth는 [양식조리사]\n-양식 요리를 한다.\n-재료를 준비한다.\n-조리법을 따른다.\n-맛을 조절한다.\n-접시를 장식한다.\n-위생을 유지한다.\n-메뉴를 개발한다.\n-재고를 관리한다.\n-교육을... 기반으로 75로 평가","stability":"stability는 [양식조리사]\n-양식 요리를 한다.\n-재료를 준비한다.\n-조리법을 따른다.\n-맛을 조절한다.\n-접시를 장식한다.\n-위생을 유지한다.\n-메뉴를 개발한다.\n-재고를 관리한다.\n-교육을... 기반으로 50로 평가","income":"income는 [양식조리사]\n-양식 요리를 한다.\n-재료를 준비한다.\n-조리법을 따른다.\n-맛을 조절한다.\n-접시를 장식한다.\n-위생을 유지한다.\n-메뉴를 개발한다.\n-재고를 관리한다.\n-교육을... 기반으로 50로 평가","teamwork":"teamwork는 [양식조리사]\n-양식 요리를 한다.\n-재료를 준비한다.\n-조리법을 따른다.\n-맛을 조절한다.\n-접시를 장식한다.\n-위생을 유지한다.\n-메뉴를 개발한다.\n-재고를 관리한다.\n-교육을... 기반으로 50로 평가","solo_deep":"solo_deep는 [양식조리사]\n-양식 요리를 한다.\n-재료를 준비한다.\n-조리법을 따른다.\n-맛을 조절한다.\n-접시를 장식한다.\n-위생을 유지한다.\n-메뉴를 개발한다.\n-재고를 관리한다.\n-교육을... 기반으로 50로 평가","analytical":"analytical는 [양식조리사]\n-양식 요리를 한다.\n-재료를 준비한다.\n-조리법을 따른다.\n-맛을 조절한다.\n-접시를 장식한다.\n-위생을 유지한다.\n-메뉴를 개발한다.\n-재고를 관리한다.\n-교육을... 기반으로 30로 평가","creative":"creative는 [양식조리사]\n-양식 요리를 한다.\n-재료를 준비한다.\n-조리법을 따른다.\n-맛을 조절한다.\n-접시를 장식한다.\n-위생을 유지한다.\n-메뉴를 개발한다.\n-재고를 관리한다.\n-교육을... 기반으로 60로 평가","execution":"execution는 [양식조리사]\n-양식 요리를 한다.\n-재료를 준비한다.\n-조리법을 따른다.\n-맛을 조절한다.\n-접시를 장식한다.\n-위생을 유지한다.\n-메뉴를 개발한다.\n-재고를 관리한다.\n-교육을... 기반으로 60로 평가","people_facing":"people_facing는 [양식조리사]\n-양식 요리를 한다.\n-재료를 준비한다.\n-조리법을 따른다.\n-맛을 조절한다.\n-접시를 장식한다.\n-위생을 유지한다.\n-메뉴를 개발한다.\n-재고를 관리한다.\n-교육을... 기반으로 35로 평가","degree_required":"degree_required는 [양식조리사]\n-양식 요리를 한다.\n-재료를 준비한다.\n-조리법을 따른다.\n-맛을 조절한다.\n-접시를 장식한다.\n-위생을 유지한다.\n-메뉴를 개발한다.\n-재고를 관리한다.\n-교육을... 기반으로 none로 평가","license_required":"license_required는 [양식조리사]\n-양식 요리를 한다.\n-재료를 준비한다.\n-조리법을 따른다.\n-맛을 조절한다.\n-접시를 장식한다.\n-위생을 유지한다.\n-메뉴를 개발한다.\n-재고를 관리한다.\n-교육을... 기반으로 none로 평가"}'
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
  '1765283473551514',
  '광고영상감독',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 50, 40,
  70, 30, 30, 60, 60, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [광고영상감독]\n-광고 콘셉트를 기획한다.\n-스토리보드를 작성한다.\n-촬영을 감독한다.\n-배우를 지도한다.\n-특수 효과를 감독한다.\n-편집을 지휘한다.\n-클라이언트와 협의한다.\n-... 기반으로 50로 평가","growth":"growth는 [광고영상감독]\n-광고 콘셉트를 기획한다.\n-스토리보드를 작성한다.\n-촬영을 감독한다.\n-배우를 지도한다.\n-특수 효과를 감독한다.\n-편집을 지휘한다.\n-클라이언트와 협의한다.\n-... 기반으로 65로 평가","stability":"stability는 [광고영상감독]\n-광고 콘셉트를 기획한다.\n-스토리보드를 작성한다.\n-촬영을 감독한다.\n-배우를 지도한다.\n-특수 효과를 감독한다.\n-편집을 지휘한다.\n-클라이언트와 협의한다.\n-... 기반으로 50로 평가","income":"income는 [광고영상감독]\n-광고 콘셉트를 기획한다.\n-스토리보드를 작성한다.\n-촬영을 감독한다.\n-배우를 지도한다.\n-특수 효과를 감독한다.\n-편집을 지휘한다.\n-클라이언트와 협의한다.\n-... 기반으로 40로 평가","teamwork":"teamwork는 [광고영상감독]\n-광고 콘셉트를 기획한다.\n-스토리보드를 작성한다.\n-촬영을 감독한다.\n-배우를 지도한다.\n-특수 효과를 감독한다.\n-편집을 지휘한다.\n-클라이언트와 협의한다.\n-... 기반으로 70로 평가","solo_deep":"solo_deep는 [광고영상감독]\n-광고 콘셉트를 기획한다.\n-스토리보드를 작성한다.\n-촬영을 감독한다.\n-배우를 지도한다.\n-특수 효과를 감독한다.\n-편집을 지휘한다.\n-클라이언트와 협의한다.\n-... 기반으로 30로 평가","analytical":"analytical는 [광고영상감독]\n-광고 콘셉트를 기획한다.\n-스토리보드를 작성한다.\n-촬영을 감독한다.\n-배우를 지도한다.\n-특수 효과를 감독한다.\n-편집을 지휘한다.\n-클라이언트와 협의한다.\n-... 기반으로 30로 평가","creative":"creative는 [광고영상감독]\n-광고 콘셉트를 기획한다.\n-스토리보드를 작성한다.\n-촬영을 감독한다.\n-배우를 지도한다.\n-특수 효과를 감독한다.\n-편집을 지휘한다.\n-클라이언트와 협의한다.\n-... 기반으로 60로 평가","execution":"execution는 [광고영상감독]\n-광고 콘셉트를 기획한다.\n-스토리보드를 작성한다.\n-촬영을 감독한다.\n-배우를 지도한다.\n-특수 효과를 감독한다.\n-편집을 지휘한다.\n-클라이언트와 협의한다.\n-... 기반으로 60로 평가","people_facing":"people_facing는 [광고영상감독]\n-광고 콘셉트를 기획한다.\n-스토리보드를 작성한다.\n-촬영을 감독한다.\n-배우를 지도한다.\n-특수 효과를 감독한다.\n-편집을 지휘한다.\n-클라이언트와 협의한다.\n-... 기반으로 50로 평가","degree_required":"degree_required는 [광고영상감독]\n-광고 콘셉트를 기획한다.\n-스토리보드를 작성한다.\n-촬영을 감독한다.\n-배우를 지도한다.\n-특수 효과를 감독한다.\n-편집을 지휘한다.\n-클라이언트와 협의한다.\n-... 기반으로 none로 평가","license_required":"license_required는 [광고영상감독]\n-광고 콘셉트를 기획한다.\n-스토리보드를 작성한다.\n-촬영을 감독한다.\n-배우를 지도한다.\n-특수 효과를 감독한다.\n-편집을 지휘한다.\n-클라이언트와 협의한다.\n-... 기반으로 none로 평가"}'
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
  '1765283475491690',
  '피부 및 체형관리사',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 60, 50, 50,
  50, 50, 40, 40, 70, 75,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [피부관리사]\n-피부 상태를 진단한다.\n-클렌징을 한다.\n-마사지를 실시한다.\n-팩을 적용한다.\n-관리법을 교육한다.\n-제품을 추천한다.\n-기록을 관리한다.\n-위생을 유지한다.\n-... 기반으로 50로 평가","growth":"growth는 [피부관리사]\n-피부 상태를 진단한다.\n-클렌징을 한다.\n-마사지를 실시한다.\n-팩을 적용한다.\n-관리법을 교육한다.\n-제품을 추천한다.\n-기록을 관리한다.\n-위생을 유지한다.\n-... 기반으로 60로 평가","stability":"stability는 [피부관리사]\n-피부 상태를 진단한다.\n-클렌징을 한다.\n-마사지를 실시한다.\n-팩을 적용한다.\n-관리법을 교육한다.\n-제품을 추천한다.\n-기록을 관리한다.\n-위생을 유지한다.\n-... 기반으로 50로 평가","income":"income는 [피부관리사]\n-피부 상태를 진단한다.\n-클렌징을 한다.\n-마사지를 실시한다.\n-팩을 적용한다.\n-관리법을 교육한다.\n-제품을 추천한다.\n-기록을 관리한다.\n-위생을 유지한다.\n-... 기반으로 50로 평가","teamwork":"teamwork는 [피부관리사]\n-피부 상태를 진단한다.\n-클렌징을 한다.\n-마사지를 실시한다.\n-팩을 적용한다.\n-관리법을 교육한다.\n-제품을 추천한다.\n-기록을 관리한다.\n-위생을 유지한다.\n-... 기반으로 50로 평가","solo_deep":"solo_deep는 [피부관리사]\n-피부 상태를 진단한다.\n-클렌징을 한다.\n-마사지를 실시한다.\n-팩을 적용한다.\n-관리법을 교육한다.\n-제품을 추천한다.\n-기록을 관리한다.\n-위생을 유지한다.\n-... 기반으로 50로 평가","analytical":"analytical는 [피부관리사]\n-피부 상태를 진단한다.\n-클렌징을 한다.\n-마사지를 실시한다.\n-팩을 적용한다.\n-관리법을 교육한다.\n-제품을 추천한다.\n-기록을 관리한다.\n-위생을 유지한다.\n-... 기반으로 40로 평가","creative":"creative는 [피부관리사]\n-피부 상태를 진단한다.\n-클렌징을 한다.\n-마사지를 실시한다.\n-팩을 적용한다.\n-관리법을 교육한다.\n-제품을 추천한다.\n-기록을 관리한다.\n-위생을 유지한다.\n-... 기반으로 40로 평가","execution":"execution는 [피부관리사]\n-피부 상태를 진단한다.\n-클렌징을 한다.\n-마사지를 실시한다.\n-팩을 적용한다.\n-관리법을 교육한다.\n-제품을 추천한다.\n-기록을 관리한다.\n-위생을 유지한다.\n-... 기반으로 70로 평가","people_facing":"people_facing는 [피부관리사]\n-피부 상태를 진단한다.\n-클렌징을 한다.\n-마사지를 실시한다.\n-팩을 적용한다.\n-관리법을 교육한다.\n-제품을 추천한다.\n-기록을 관리한다.\n-위생을 유지한다.\n-... 기반으로 75로 평가","degree_required":"degree_required는 [피부관리사]\n-피부 상태를 진단한다.\n-클렌징을 한다.\n-마사지를 실시한다.\n-팩을 적용한다.\n-관리법을 교육한다.\n-제품을 추천한다.\n-기록을 관리한다.\n-위생을 유지한다.\n-... 기반으로 none로 평가","license_required":"license_required는 [피부관리사]\n-피부 상태를 진단한다.\n-클렌징을 한다.\n-마사지를 실시한다.\n-팩을 적용한다.\n-관리법을 교육한다.\n-제품을 추천한다.\n-기록을 관리한다.\n-위생을 유지한다.\n-... 기반으로 none로 평가"}'
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
  '1765283433813430',
  '약학연구원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 50, 70,
  70, 30, 60, 60, 30, 35,
  'regular', 'none', 'none', 'none',
  'master', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [약학연구원]\n-신약을 개발한다.\n-약물 효능을 연구한다.\n-임상 시험을 설계한다.\n-데이터를 분석한다.\n-보고서를 작성한다.\n-논문을 발표한다.\n-안전성을 평가한다.\n-규제를 준... 기반으로 50로 평가","growth":"growth는 [약학연구원]\n-신약을 개발한다.\n-약물 효능을 연구한다.\n-임상 시험을 설계한다.\n-데이터를 분석한다.\n-보고서를 작성한다.\n-논문을 발표한다.\n-안전성을 평가한다.\n-규제를 준... 기반으로 65로 평가","stability":"stability는 [약학연구원]\n-신약을 개발한다.\n-약물 효능을 연구한다.\n-임상 시험을 설계한다.\n-데이터를 분석한다.\n-보고서를 작성한다.\n-논문을 발표한다.\n-안전성을 평가한다.\n-규제를 준... 기반으로 50로 평가","income":"income는 [약학연구원]\n-신약을 개발한다.\n-약물 효능을 연구한다.\n-임상 시험을 설계한다.\n-데이터를 분석한다.\n-보고서를 작성한다.\n-논문을 발표한다.\n-안전성을 평가한다.\n-규제를 준... 기반으로 70로 평가","teamwork":"teamwork는 [약학연구원]\n-신약을 개발한다.\n-약물 효능을 연구한다.\n-임상 시험을 설계한다.\n-데이터를 분석한다.\n-보고서를 작성한다.\n-논문을 발표한다.\n-안전성을 평가한다.\n-규제를 준... 기반으로 70로 평가","solo_deep":"solo_deep는 [약학연구원]\n-신약을 개발한다.\n-약물 효능을 연구한다.\n-임상 시험을 설계한다.\n-데이터를 분석한다.\n-보고서를 작성한다.\n-논문을 발표한다.\n-안전성을 평가한다.\n-규제를 준... 기반으로 30로 평가","analytical":"analytical는 [약학연구원]\n-신약을 개발한다.\n-약물 효능을 연구한다.\n-임상 시험을 설계한다.\n-데이터를 분석한다.\n-보고서를 작성한다.\n-논문을 발표한다.\n-안전성을 평가한다.\n-규제를 준... 기반으로 60로 평가","creative":"creative는 [약학연구원]\n-신약을 개발한다.\n-약물 효능을 연구한다.\n-임상 시험을 설계한다.\n-데이터를 분석한다.\n-보고서를 작성한다.\n-논문을 발표한다.\n-안전성을 평가한다.\n-규제를 준... 기반으로 60로 평가","execution":"execution는 [약학연구원]\n-신약을 개발한다.\n-약물 효능을 연구한다.\n-임상 시험을 설계한다.\n-데이터를 분석한다.\n-보고서를 작성한다.\n-논문을 발표한다.\n-안전성을 평가한다.\n-규제를 준... 기반으로 30로 평가","people_facing":"people_facing는 [약학연구원]\n-신약을 개발한다.\n-약물 효능을 연구한다.\n-임상 시험을 설계한다.\n-데이터를 분석한다.\n-보고서를 작성한다.\n-논문을 발표한다.\n-안전성을 평가한다.\n-규제를 준... 기반으로 35로 평가","degree_required":"degree_required는 [약학연구원]\n-신약을 개발한다.\n-약물 효능을 연구한다.\n-임상 시험을 설계한다.\n-데이터를 분석한다.\n-보고서를 작성한다.\n-논문을 발표한다.\n-안전성을 평가한다.\n-규제를 준... 기반으로 master로 평가","license_required":"license_required는 [약학연구원]\n-신약을 개발한다.\n-약물 효능을 연구한다.\n-임상 시험을 설계한다.\n-데이터를 분석한다.\n-보고서를 작성한다.\n-논문을 발표한다.\n-안전성을 평가한다.\n-규제를 준... 기반으로 none로 평가"}'
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
  '1765283499348417',
  '건설배관공',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 50, 50,
  50, 50, 40, 40, 70, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [건설배관공]\n-배관 설계를 읽는다.\n-재료를 준비한다.\n-배관을 절단한다.\n-배관을 연결한다.\n-용접을 실시한다.\n-누수 검사를 한다.\n-배관을 설치한다.\n-유지보수를 한다.\n-... 기반으로 50로 평가","growth":"growth는 [건설배관공]\n-배관 설계를 읽는다.\n-재료를 준비한다.\n-배관을 절단한다.\n-배관을 연결한다.\n-용접을 실시한다.\n-누수 검사를 한다.\n-배관을 설치한다.\n-유지보수를 한다.\n-... 기반으로 65로 평가","stability":"stability는 [건설배관공]\n-배관 설계를 읽는다.\n-재료를 준비한다.\n-배관을 절단한다.\n-배관을 연결한다.\n-용접을 실시한다.\n-누수 검사를 한다.\n-배관을 설치한다.\n-유지보수를 한다.\n-... 기반으로 50로 평가","income":"income는 [건설배관공]\n-배관 설계를 읽는다.\n-재료를 준비한다.\n-배관을 절단한다.\n-배관을 연결한다.\n-용접을 실시한다.\n-누수 검사를 한다.\n-배관을 설치한다.\n-유지보수를 한다.\n-... 기반으로 50로 평가","teamwork":"teamwork는 [건설배관공]\n-배관 설계를 읽는다.\n-재료를 준비한다.\n-배관을 절단한다.\n-배관을 연결한다.\n-용접을 실시한다.\n-누수 검사를 한다.\n-배관을 설치한다.\n-유지보수를 한다.\n-... 기반으로 50로 평가","solo_deep":"solo_deep는 [건설배관공]\n-배관 설계를 읽는다.\n-재료를 준비한다.\n-배관을 절단한다.\n-배관을 연결한다.\n-용접을 실시한다.\n-누수 검사를 한다.\n-배관을 설치한다.\n-유지보수를 한다.\n-... 기반으로 50로 평가","analytical":"analytical는 [건설배관공]\n-배관 설계를 읽는다.\n-재료를 준비한다.\n-배관을 절단한다.\n-배관을 연결한다.\n-용접을 실시한다.\n-누수 검사를 한다.\n-배관을 설치한다.\n-유지보수를 한다.\n-... 기반으로 40로 평가","creative":"creative는 [건설배관공]\n-배관 설계를 읽는다.\n-재료를 준비한다.\n-배관을 절단한다.\n-배관을 연결한다.\n-용접을 실시한다.\n-누수 검사를 한다.\n-배관을 설치한다.\n-유지보수를 한다.\n-... 기반으로 40로 평가","execution":"execution는 [건설배관공]\n-배관 설계를 읽는다.\n-재료를 준비한다.\n-배관을 절단한다.\n-배관을 연결한다.\n-용접을 실시한다.\n-누수 검사를 한다.\n-배관을 설치한다.\n-유지보수를 한다.\n-... 기반으로 70로 평가","people_facing":"people_facing는 [건설배관공]\n-배관 설계를 읽는다.\n-재료를 준비한다.\n-배관을 절단한다.\n-배관을 연결한다.\n-용접을 실시한다.\n-누수 검사를 한다.\n-배관을 설치한다.\n-유지보수를 한다.\n-... 기반으로 50로 평가","degree_required":"degree_required는 [건설배관공]\n-배관 설계를 읽는다.\n-재료를 준비한다.\n-배관을 절단한다.\n-배관을 연결한다.\n-용접을 실시한다.\n-누수 검사를 한다.\n-배관을 설치한다.\n-유지보수를 한다.\n-... 기반으로 none로 평가","license_required":"license_required는 [건설배관공]\n-배관 설계를 읽는다.\n-재료를 준비한다.\n-배관을 절단한다.\n-배관을 연결한다.\n-용접을 실시한다.\n-누수 검사를 한다.\n-배관을 설치한다.\n-유지보수를 한다.\n-... 기반으로 none로 평가"}'
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
  '1765283490818405',
  '철도·전동차기관사',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 60, 50, 50,
  50, 50, 40, 40, 70, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [철도기관사]\n-열차를 운전한다.\n-신호를 확인한다.\n-속도를 조절한다.\n-안전 수칙을 준수한다.\n-승객 안전을 책임진다.\n-비상 상황에 대응한다.\n-기록을 관리한다.\n-정비를 확... 기반으로 50로 평가","growth":"growth는 [철도기관사]\n-열차를 운전한다.\n-신호를 확인한다.\n-속도를 조절한다.\n-안전 수칙을 준수한다.\n-승객 안전을 책임진다.\n-비상 상황에 대응한다.\n-기록을 관리한다.\n-정비를 확... 기반으로 60로 평가","stability":"stability는 [철도기관사]\n-열차를 운전한다.\n-신호를 확인한다.\n-속도를 조절한다.\n-안전 수칙을 준수한다.\n-승객 안전을 책임진다.\n-비상 상황에 대응한다.\n-기록을 관리한다.\n-정비를 확... 기반으로 50로 평가","income":"income는 [철도기관사]\n-열차를 운전한다.\n-신호를 확인한다.\n-속도를 조절한다.\n-안전 수칙을 준수한다.\n-승객 안전을 책임진다.\n-비상 상황에 대응한다.\n-기록을 관리한다.\n-정비를 확... 기반으로 50로 평가","teamwork":"teamwork는 [철도기관사]\n-열차를 운전한다.\n-신호를 확인한다.\n-속도를 조절한다.\n-안전 수칙을 준수한다.\n-승객 안전을 책임진다.\n-비상 상황에 대응한다.\n-기록을 관리한다.\n-정비를 확... 기반으로 50로 평가","solo_deep":"solo_deep는 [철도기관사]\n-열차를 운전한다.\n-신호를 확인한다.\n-속도를 조절한다.\n-안전 수칙을 준수한다.\n-승객 안전을 책임진다.\n-비상 상황에 대응한다.\n-기록을 관리한다.\n-정비를 확... 기반으로 50로 평가","analytical":"analytical는 [철도기관사]\n-열차를 운전한다.\n-신호를 확인한다.\n-속도를 조절한다.\n-안전 수칙을 준수한다.\n-승객 안전을 책임진다.\n-비상 상황에 대응한다.\n-기록을 관리한다.\n-정비를 확... 기반으로 40로 평가","creative":"creative는 [철도기관사]\n-열차를 운전한다.\n-신호를 확인한다.\n-속도를 조절한다.\n-안전 수칙을 준수한다.\n-승객 안전을 책임진다.\n-비상 상황에 대응한다.\n-기록을 관리한다.\n-정비를 확... 기반으로 40로 평가","execution":"execution는 [철도기관사]\n-열차를 운전한다.\n-신호를 확인한다.\n-속도를 조절한다.\n-안전 수칙을 준수한다.\n-승객 안전을 책임진다.\n-비상 상황에 대응한다.\n-기록을 관리한다.\n-정비를 확... 기반으로 70로 평가","people_facing":"people_facing는 [철도기관사]\n-열차를 운전한다.\n-신호를 확인한다.\n-속도를 조절한다.\n-안전 수칙을 준수한다.\n-승객 안전을 책임진다.\n-비상 상황에 대응한다.\n-기록을 관리한다.\n-정비를 확... 기반으로 50로 평가","degree_required":"degree_required는 [철도기관사]\n-열차를 운전한다.\n-신호를 확인한다.\n-속도를 조절한다.\n-안전 수칙을 준수한다.\n-승객 안전을 책임진다.\n-비상 상황에 대응한다.\n-기록을 관리한다.\n-정비를 확... 기반으로 none로 평가","license_required":"license_required는 [철도기관사]\n-열차를 운전한다.\n-신호를 확인한다.\n-속도를 조절한다.\n-안전 수칙을 준수한다.\n-승객 안전을 책임진다.\n-비상 상황에 대응한다.\n-기록을 관리한다.\n-정비를 확... 기반으로 none로 평가"}'
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
  '1765283421371269',
  '도로운송사무원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 70, 50,
  50, 50, 40, 40, 70, 75,
  'regular', 'none', 'none', 'partial',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [도로운송사무원]\n-운송 일정을 관리한다.\n-화물 예약을 받는다.\n-운송 경로를 계획한다.\n-운송장을 작성한다.\n-화물 추적을 한다.\n-고객을 응대한다.\n-문제를 해결한다.\n-기록... 기반으로 50로 평가","growth":"growth는 [도로운송사무원]\n-운송 일정을 관리한다.\n-화물 예약을 받는다.\n-운송 경로를 계획한다.\n-운송장을 작성한다.\n-화물 추적을 한다.\n-고객을 응대한다.\n-문제를 해결한다.\n-기록... 기반으로 50로 평가","stability":"stability는 [도로운송사무원]\n-운송 일정을 관리한다.\n-화물 예약을 받는다.\n-운송 경로를 계획한다.\n-운송장을 작성한다.\n-화물 추적을 한다.\n-고객을 응대한다.\n-문제를 해결한다.\n-기록... 기반으로 70로 평가","income":"income는 [도로운송사무원]\n-운송 일정을 관리한다.\n-화물 예약을 받는다.\n-운송 경로를 계획한다.\n-운송장을 작성한다.\n-화물 추적을 한다.\n-고객을 응대한다.\n-문제를 해결한다.\n-기록... 기반으로 50로 평가","teamwork":"teamwork는 [도로운송사무원]\n-운송 일정을 관리한다.\n-화물 예약을 받는다.\n-운송 경로를 계획한다.\n-운송장을 작성한다.\n-화물 추적을 한다.\n-고객을 응대한다.\n-문제를 해결한다.\n-기록... 기반으로 50로 평가","solo_deep":"solo_deep는 [도로운송사무원]\n-운송 일정을 관리한다.\n-화물 예약을 받는다.\n-운송 경로를 계획한다.\n-운송장을 작성한다.\n-화물 추적을 한다.\n-고객을 응대한다.\n-문제를 해결한다.\n-기록... 기반으로 50로 평가","analytical":"analytical는 [도로운송사무원]\n-운송 일정을 관리한다.\n-화물 예약을 받는다.\n-운송 경로를 계획한다.\n-운송장을 작성한다.\n-화물 추적을 한다.\n-고객을 응대한다.\n-문제를 해결한다.\n-기록... 기반으로 40로 평가","creative":"creative는 [도로운송사무원]\n-운송 일정을 관리한다.\n-화물 예약을 받는다.\n-운송 경로를 계획한다.\n-운송장을 작성한다.\n-화물 추적을 한다.\n-고객을 응대한다.\n-문제를 해결한다.\n-기록... 기반으로 40로 평가","execution":"execution는 [도로운송사무원]\n-운송 일정을 관리한다.\n-화물 예약을 받는다.\n-운송 경로를 계획한다.\n-운송장을 작성한다.\n-화물 추적을 한다.\n-고객을 응대한다.\n-문제를 해결한다.\n-기록... 기반으로 70로 평가","people_facing":"people_facing는 [도로운송사무원]\n-운송 일정을 관리한다.\n-화물 예약을 받는다.\n-운송 경로를 계획한다.\n-운송장을 작성한다.\n-화물 추적을 한다.\n-고객을 응대한다.\n-문제를 해결한다.\n-기록... 기반으로 75로 평가","degree_required":"degree_required는 [도로운송사무원]\n-운송 일정을 관리한다.\n-화물 예약을 받는다.\n-운송 경로를 계획한다.\n-운송장을 작성한다.\n-화물 추적을 한다.\n-고객을 응대한다.\n-문제를 해결한다.\n-기록... 기반으로 none로 평가","license_required":"license_required는 [도로운송사무원]\n-운송 일정을 관리한다.\n-화물 예약을 받는다.\n-운송 경로를 계획한다.\n-운송장을 작성한다.\n-화물 추적을 한다.\n-고객을 응대한다.\n-문제를 해결한다.\n-기록... 기반으로 none로 평가"}'
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
  '1765283468460636',
  '방송기자',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 40,
  50, 50, 50, 50, 50, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [방송기자]\n-뉴스를 취재한다.\n-인터뷰를 진행한다.\n-기사를 작성한다.\n-영상을 촬영한다.\n-편집을 한다.\n-방송을 진행한다.\n-사실을 검증한다.\n-데드라인을 지킨다.\n-시청자와... 기반으로 50로 평가","growth":"growth는 [방송기자]\n-뉴스를 취재한다.\n-인터뷰를 진행한다.\n-기사를 작성한다.\n-영상을 촬영한다.\n-편집을 한다.\n-방송을 진행한다.\n-사실을 검증한다.\n-데드라인을 지킨다.\n-시청자와... 기반으로 50로 평가","stability":"stability는 [방송기자]\n-뉴스를 취재한다.\n-인터뷰를 진행한다.\n-기사를 작성한다.\n-영상을 촬영한다.\n-편집을 한다.\n-방송을 진행한다.\n-사실을 검증한다.\n-데드라인을 지킨다.\n-시청자와... 기반으로 50로 평가","income":"income는 [방송기자]\n-뉴스를 취재한다.\n-인터뷰를 진행한다.\n-기사를 작성한다.\n-영상을 촬영한다.\n-편집을 한다.\n-방송을 진행한다.\n-사실을 검증한다.\n-데드라인을 지킨다.\n-시청자와... 기반으로 40로 평가","teamwork":"teamwork는 [방송기자]\n-뉴스를 취재한다.\n-인터뷰를 진행한다.\n-기사를 작성한다.\n-영상을 촬영한다.\n-편집을 한다.\n-방송을 진행한다.\n-사실을 검증한다.\n-데드라인을 지킨다.\n-시청자와... 기반으로 50로 평가","solo_deep":"solo_deep는 [방송기자]\n-뉴스를 취재한다.\n-인터뷰를 진행한다.\n-기사를 작성한다.\n-영상을 촬영한다.\n-편집을 한다.\n-방송을 진행한다.\n-사실을 검증한다.\n-데드라인을 지킨다.\n-시청자와... 기반으로 50로 평가","analytical":"analytical는 [방송기자]\n-뉴스를 취재한다.\n-인터뷰를 진행한다.\n-기사를 작성한다.\n-영상을 촬영한다.\n-편집을 한다.\n-방송을 진행한다.\n-사실을 검증한다.\n-데드라인을 지킨다.\n-시청자와... 기반으로 50로 평가","creative":"creative는 [방송기자]\n-뉴스를 취재한다.\n-인터뷰를 진행한다.\n-기사를 작성한다.\n-영상을 촬영한다.\n-편집을 한다.\n-방송을 진행한다.\n-사실을 검증한다.\n-데드라인을 지킨다.\n-시청자와... 기반으로 50로 평가","execution":"execution는 [방송기자]\n-뉴스를 취재한다.\n-인터뷰를 진행한다.\n-기사를 작성한다.\n-영상을 촬영한다.\n-편집을 한다.\n-방송을 진행한다.\n-사실을 검증한다.\n-데드라인을 지킨다.\n-시청자와... 기반으로 50로 평가","people_facing":"people_facing는 [방송기자]\n-뉴스를 취재한다.\n-인터뷰를 진행한다.\n-기사를 작성한다.\n-영상을 촬영한다.\n-편집을 한다.\n-방송을 진행한다.\n-사실을 검증한다.\n-데드라인을 지킨다.\n-시청자와... 기반으로 50로 평가","degree_required":"degree_required는 [방송기자]\n-뉴스를 취재한다.\n-인터뷰를 진행한다.\n-기사를 작성한다.\n-영상을 촬영한다.\n-편집을 한다.\n-방송을 진행한다.\n-사실을 검증한다.\n-데드라인을 지킨다.\n-시청자와... 기반으로 none로 평가","license_required":"license_required는 [방송기자]\n-뉴스를 취재한다.\n-인터뷰를 진행한다.\n-기사를 작성한다.\n-영상을 촬영한다.\n-편집을 한다.\n-방송을 진행한다.\n-사실을 검증한다.\n-데드라인을 지킨다.\n-시청자와... 기반으로 none로 평가"}'
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
  '1765283530916658',
  '곡식작물재배원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  50, 50, 40, 40, 70, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [곡식재배원]\n-종자를 심는다.\n-물을 공급한다.\n-비료를 준다.\n-해충을 방제한다.\n-성장을 모니터링한다.\n-수확을 한다.\n-곡물을 저장한다.\n-품질을 검사한다.\n-장비를 유지한... 기반으로 50로 평가","growth":"growth는 [곡식재배원]\n-종자를 심는다.\n-물을 공급한다.\n-비료를 준다.\n-해충을 방제한다.\n-성장을 모니터링한다.\n-수확을 한다.\n-곡물을 저장한다.\n-품질을 검사한다.\n-장비를 유지한... 기반으로 50로 평가","stability":"stability는 [곡식재배원]\n-종자를 심는다.\n-물을 공급한다.\n-비료를 준다.\n-해충을 방제한다.\n-성장을 모니터링한다.\n-수확을 한다.\n-곡물을 저장한다.\n-품질을 검사한다.\n-장비를 유지한... 기반으로 50로 평가","income":"income는 [곡식재배원]\n-종자를 심는다.\n-물을 공급한다.\n-비료를 준다.\n-해충을 방제한다.\n-성장을 모니터링한다.\n-수확을 한다.\n-곡물을 저장한다.\n-품질을 검사한다.\n-장비를 유지한... 기반으로 50로 평가","teamwork":"teamwork는 [곡식재배원]\n-종자를 심는다.\n-물을 공급한다.\n-비료를 준다.\n-해충을 방제한다.\n-성장을 모니터링한다.\n-수확을 한다.\n-곡물을 저장한다.\n-품질을 검사한다.\n-장비를 유지한... 기반으로 50로 평가","solo_deep":"solo_deep는 [곡식재배원]\n-종자를 심는다.\n-물을 공급한다.\n-비료를 준다.\n-해충을 방제한다.\n-성장을 모니터링한다.\n-수확을 한다.\n-곡물을 저장한다.\n-품질을 검사한다.\n-장비를 유지한... 기반으로 50로 평가","analytical":"analytical는 [곡식재배원]\n-종자를 심는다.\n-물을 공급한다.\n-비료를 준다.\n-해충을 방제한다.\n-성장을 모니터링한다.\n-수확을 한다.\n-곡물을 저장한다.\n-품질을 검사한다.\n-장비를 유지한... 기반으로 40로 평가","creative":"creative는 [곡식재배원]\n-종자를 심는다.\n-물을 공급한다.\n-비료를 준다.\n-해충을 방제한다.\n-성장을 모니터링한다.\n-수확을 한다.\n-곡물을 저장한다.\n-품질을 검사한다.\n-장비를 유지한... 기반으로 40로 평가","execution":"execution는 [곡식재배원]\n-종자를 심는다.\n-물을 공급한다.\n-비료를 준다.\n-해충을 방제한다.\n-성장을 모니터링한다.\n-수확을 한다.\n-곡물을 저장한다.\n-품질을 검사한다.\n-장비를 유지한... 기반으로 70로 평가","people_facing":"people_facing는 [곡식재배원]\n-종자를 심는다.\n-물을 공급한다.\n-비료를 준다.\n-해충을 방제한다.\n-성장을 모니터링한다.\n-수확을 한다.\n-곡물을 저장한다.\n-품질을 검사한다.\n-장비를 유지한... 기반으로 50로 평가","degree_required":"degree_required는 [곡식재배원]\n-종자를 심는다.\n-물을 공급한다.\n-비료를 준다.\n-해충을 방제한다.\n-성장을 모니터링한다.\n-수확을 한다.\n-곡물을 저장한다.\n-품질을 검사한다.\n-장비를 유지한... 기반으로 none로 평가","license_required":"license_required는 [곡식재배원]\n-종자를 심는다.\n-물을 공급한다.\n-비료를 준다.\n-해충을 방제한다.\n-성장을 모니터링한다.\n-수확을 한다.\n-곡물을 저장한다.\n-품질을 검사한다.\n-장비를 유지한... 기반으로 none로 평가"}'
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