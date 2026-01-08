-- Batch tagging SQL generated at 2026-01-06T06:25:09.539Z
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
  '1765283306411848',
  '무용가',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 40,
  50, 50, 40, 70, 40, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 무용가는 춤을 추고 공연하는 업무를 수행합니다.\n\n춤 연습을 합니다.\n\n공연을 준비합니다.\n\n무대에서 춤을 춥니다.\n\n안무를 창작합니다.\n\n후배 무용수를 지도합니다.... 기반으로 50로 평가","growth":"growth는 무용가는 춤을 추고 공연하는 업무를 수행합니다.\n\n춤 연습을 합니다.\n\n공연을 준비합니다.\n\n무대에서 춤을 춥니다.\n\n안무를 창작합니다.\n\n후배 무용수를 지도합니다.... 기반으로 50로 평가","stability":"stability는 무용가는 춤을 추고 공연하는 업무를 수행합니다.\n\n춤 연습을 합니다.\n\n공연을 준비합니다.\n\n무대에서 춤을 춥니다.\n\n안무를 창작합니다.\n\n후배 무용수를 지도합니다.... 기반으로 50로 평가","income":"income는 무용가는 춤을 추고 공연하는 업무를 수행합니다.\n\n춤 연습을 합니다.\n\n공연을 준비합니다.\n\n무대에서 춤을 춥니다.\n\n안무를 창작합니다.\n\n후배 무용수를 지도합니다.... 기반으로 40로 평가","teamwork":"teamwork는 무용가는 춤을 추고 공연하는 업무를 수행합니다.\n\n춤 연습을 합니다.\n\n공연을 준비합니다.\n\n무대에서 춤을 춥니다.\n\n안무를 창작합니다.\n\n후배 무용수를 지도합니다.... 기반으로 50로 평가","solo_deep":"solo_deep는 무용가는 춤을 추고 공연하는 업무를 수행합니다.\n\n춤 연습을 합니다.\n\n공연을 준비합니다.\n\n무대에서 춤을 춥니다.\n\n안무를 창작합니다.\n\n후배 무용수를 지도합니다.... 기반으로 50로 평가","analytical":"analytical는 무용가는 춤을 추고 공연하는 업무를 수행합니다.\n\n춤 연습을 합니다.\n\n공연을 준비합니다.\n\n무대에서 춤을 춥니다.\n\n안무를 창작합니다.\n\n후배 무용수를 지도합니다.... 기반으로 40로 평가","creative":"creative는 무용가는 춤을 추고 공연하는 업무를 수행합니다.\n\n춤 연습을 합니다.\n\n공연을 준비합니다.\n\n무대에서 춤을 춥니다.\n\n안무를 창작합니다.\n\n후배 무용수를 지도합니다.... 기반으로 70로 평가","execution":"execution는 무용가는 춤을 추고 공연하는 업무를 수행합니다.\n\n춤 연습을 합니다.\n\n공연을 준비합니다.\n\n무대에서 춤을 춥니다.\n\n안무를 창작합니다.\n\n후배 무용수를 지도합니다.... 기반으로 40로 평가","people_facing":"people_facing는 무용가는 춤을 추고 공연하는 업무를 수행합니다.\n\n춤 연습을 합니다.\n\n공연을 준비합니다.\n\n무대에서 춤을 춥니다.\n\n안무를 창작합니다.\n\n후배 무용수를 지도합니다.... 기반으로 50로 평가","degree_required":"degree_required는 무용가는 춤을 추고 공연하는 업무를 수행합니다.\n\n춤 연습을 합니다.\n\n공연을 준비합니다.\n\n무대에서 춤을 춥니다.\n\n안무를 창작합니다.\n\n후배 무용수를 지도합니다.... 기반으로 none로 평가","license_required":"license_required는 무용가는 춤을 추고 공연하는 업무를 수행합니다.\n\n춤 연습을 합니다.\n\n공연을 준비합니다.\n\n무대에서 춤을 춥니다.\n\n안무를 창작합니다.\n\n후배 무용수를 지도합니다.... 기반으로 none로 평가"}'
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
  '1765283332223520',
  '스턴트맨',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 40,
  50, 50, 50, 50, 50, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 스턴트맨은 영화나 공연에서 위험한 장면을 대신하는 업무를 수행합니다.\n\n스턴트 장면을 연습합니다.\n\n안전 장비를 착용합니다.\n\n위험한 동작을 수행합니다.\n\n감독의 지시에 따릅니다.... 기반으로 50로 평가","growth":"growth는 스턴트맨은 영화나 공연에서 위험한 장면을 대신하는 업무를 수행합니다.\n\n스턴트 장면을 연습합니다.\n\n안전 장비를 착용합니다.\n\n위험한 동작을 수행합니다.\n\n감독의 지시에 따릅니다.... 기반으로 50로 평가","stability":"stability는 스턴트맨은 영화나 공연에서 위험한 장면을 대신하는 업무를 수행합니다.\n\n스턴트 장면을 연습합니다.\n\n안전 장비를 착용합니다.\n\n위험한 동작을 수행합니다.\n\n감독의 지시에 따릅니다.... 기반으로 50로 평가","income":"income는 스턴트맨은 영화나 공연에서 위험한 장면을 대신하는 업무를 수행합니다.\n\n스턴트 장면을 연습합니다.\n\n안전 장비를 착용합니다.\n\n위험한 동작을 수행합니다.\n\n감독의 지시에 따릅니다.... 기반으로 40로 평가","teamwork":"teamwork는 스턴트맨은 영화나 공연에서 위험한 장면을 대신하는 업무를 수행합니다.\n\n스턴트 장면을 연습합니다.\n\n안전 장비를 착용합니다.\n\n위험한 동작을 수행합니다.\n\n감독의 지시에 따릅니다.... 기반으로 50로 평가","solo_deep":"solo_deep는 스턴트맨은 영화나 공연에서 위험한 장면을 대신하는 업무를 수행합니다.\n\n스턴트 장면을 연습합니다.\n\n안전 장비를 착용합니다.\n\n위험한 동작을 수행합니다.\n\n감독의 지시에 따릅니다.... 기반으로 50로 평가","analytical":"analytical는 스턴트맨은 영화나 공연에서 위험한 장면을 대신하는 업무를 수행합니다.\n\n스턴트 장면을 연습합니다.\n\n안전 장비를 착용합니다.\n\n위험한 동작을 수행합니다.\n\n감독의 지시에 따릅니다.... 기반으로 50로 평가","creative":"creative는 스턴트맨은 영화나 공연에서 위험한 장면을 대신하는 업무를 수행합니다.\n\n스턴트 장면을 연습합니다.\n\n안전 장비를 착용합니다.\n\n위험한 동작을 수행합니다.\n\n감독의 지시에 따릅니다.... 기반으로 50로 평가","execution":"execution는 스턴트맨은 영화나 공연에서 위험한 장면을 대신하는 업무를 수행합니다.\n\n스턴트 장면을 연습합니다.\n\n안전 장비를 착용합니다.\n\n위험한 동작을 수행합니다.\n\n감독의 지시에 따릅니다.... 기반으로 50로 평가","people_facing":"people_facing는 스턴트맨은 영화나 공연에서 위험한 장면을 대신하는 업무를 수행합니다.\n\n스턴트 장면을 연습합니다.\n\n안전 장비를 착용합니다.\n\n위험한 동작을 수행합니다.\n\n감독의 지시에 따릅니다.... 기반으로 50로 평가","degree_required":"degree_required는 스턴트맨은 영화나 공연에서 위험한 장면을 대신하는 업무를 수행합니다.\n\n스턴트 장면을 연습합니다.\n\n안전 장비를 착용합니다.\n\n위험한 동작을 수행합니다.\n\n감독의 지시에 따릅니다.... 기반으로 none로 평가","license_required":"license_required는 스턴트맨은 영화나 공연에서 위험한 장면을 대신하는 업무를 수행합니다.\n\n스턴트 장면을 연습합니다.\n\n안전 장비를 착용합니다.\n\n위험한 동작을 수행합니다.\n\n감독의 지시에 따릅니다.... 기반으로 none로 평가"}'
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
  '1765283343467158',
  '연극연출가',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 50, 40,
  50, 50, 40, 70, 40, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 연극연출가는 연극 공연을 기획하고 감독하는 업무를 수행합니다.\n\n대본을 선정합니다.\n\n배우를 캐스팅합니다.\n\n연습을 지도합니다.\n\n무대 디자인을 결정합니다.\n\n공연을 총괄합니다.... 기반으로 50로 평가","growth":"growth는 연극연출가는 연극 공연을 기획하고 감독하는 업무를 수행합니다.\n\n대본을 선정합니다.\n\n배우를 캐스팅합니다.\n\n연습을 지도합니다.\n\n무대 디자인을 결정합니다.\n\n공연을 총괄합니다.... 기반으로 65로 평가","stability":"stability는 연극연출가는 연극 공연을 기획하고 감독하는 업무를 수행합니다.\n\n대본을 선정합니다.\n\n배우를 캐스팅합니다.\n\n연습을 지도합니다.\n\n무대 디자인을 결정합니다.\n\n공연을 총괄합니다.... 기반으로 50로 평가","income":"income는 연극연출가는 연극 공연을 기획하고 감독하는 업무를 수행합니다.\n\n대본을 선정합니다.\n\n배우를 캐스팅합니다.\n\n연습을 지도합니다.\n\n무대 디자인을 결정합니다.\n\n공연을 총괄합니다.... 기반으로 40로 평가","teamwork":"teamwork는 연극연출가는 연극 공연을 기획하고 감독하는 업무를 수행합니다.\n\n대본을 선정합니다.\n\n배우를 캐스팅합니다.\n\n연습을 지도합니다.\n\n무대 디자인을 결정합니다.\n\n공연을 총괄합니다.... 기반으로 50로 평가","solo_deep":"solo_deep는 연극연출가는 연극 공연을 기획하고 감독하는 업무를 수행합니다.\n\n대본을 선정합니다.\n\n배우를 캐스팅합니다.\n\n연습을 지도합니다.\n\n무대 디자인을 결정합니다.\n\n공연을 총괄합니다.... 기반으로 50로 평가","analytical":"analytical는 연극연출가는 연극 공연을 기획하고 감독하는 업무를 수행합니다.\n\n대본을 선정합니다.\n\n배우를 캐스팅합니다.\n\n연습을 지도합니다.\n\n무대 디자인을 결정합니다.\n\n공연을 총괄합니다.... 기반으로 40로 평가","creative":"creative는 연극연출가는 연극 공연을 기획하고 감독하는 업무를 수행합니다.\n\n대본을 선정합니다.\n\n배우를 캐스팅합니다.\n\n연습을 지도합니다.\n\n무대 디자인을 결정합니다.\n\n공연을 총괄합니다.... 기반으로 70로 평가","execution":"execution는 연극연출가는 연극 공연을 기획하고 감독하는 업무를 수행합니다.\n\n대본을 선정합니다.\n\n배우를 캐스팅합니다.\n\n연습을 지도합니다.\n\n무대 디자인을 결정합니다.\n\n공연을 총괄합니다.... 기반으로 40로 평가","people_facing":"people_facing는 연극연출가는 연극 공연을 기획하고 감독하는 업무를 수행합니다.\n\n대본을 선정합니다.\n\n배우를 캐스팅합니다.\n\n연습을 지도합니다.\n\n무대 디자인을 결정합니다.\n\n공연을 총괄합니다.... 기반으로 50로 평가","degree_required":"degree_required는 연극연출가는 연극 공연을 기획하고 감독하는 업무를 수행합니다.\n\n대본을 선정합니다.\n\n배우를 캐스팅합니다.\n\n연습을 지도합니다.\n\n무대 디자인을 결정합니다.\n\n공연을 총괄합니다.... 기반으로 none로 평가","license_required":"license_required는 연극연출가는 연극 공연을 기획하고 감독하는 업무를 수행합니다.\n\n대본을 선정합니다.\n\n배우를 캐스팅합니다.\n\n연습을 지도합니다.\n\n무대 디자인을 결정합니다.\n\n공연을 총괄합니다.... 기반으로 none로 평가"}'
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
  '1765283402459323',
  '화가',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 40,
  50, 50, 50, 50, 50, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 화가는 그림을 그리는 업무를 수행합니다.\n\n주제를 선정합니다.\n\n스케치를 합니다.\n\n물감을 사용합니다.\n\n작품을 완성합니다.\n\n전시회를 준비합니다.... 기반으로 50로 평가","growth":"growth는 화가는 그림을 그리는 업무를 수행합니다.\n\n주제를 선정합니다.\n\n스케치를 합니다.\n\n물감을 사용합니다.\n\n작품을 완성합니다.\n\n전시회를 준비합니다.... 기반으로 50로 평가","stability":"stability는 화가는 그림을 그리는 업무를 수행합니다.\n\n주제를 선정합니다.\n\n스케치를 합니다.\n\n물감을 사용합니다.\n\n작품을 완성합니다.\n\n전시회를 준비합니다.... 기반으로 50로 평가","income":"income는 화가는 그림을 그리는 업무를 수행합니다.\n\n주제를 선정합니다.\n\n스케치를 합니다.\n\n물감을 사용합니다.\n\n작품을 완성합니다.\n\n전시회를 준비합니다.... 기반으로 40로 평가","teamwork":"teamwork는 화가는 그림을 그리는 업무를 수행합니다.\n\n주제를 선정합니다.\n\n스케치를 합니다.\n\n물감을 사용합니다.\n\n작품을 완성합니다.\n\n전시회를 준비합니다.... 기반으로 50로 평가","solo_deep":"solo_deep는 화가는 그림을 그리는 업무를 수행합니다.\n\n주제를 선정합니다.\n\n스케치를 합니다.\n\n물감을 사용합니다.\n\n작품을 완성합니다.\n\n전시회를 준비합니다.... 기반으로 50로 평가","analytical":"analytical는 화가는 그림을 그리는 업무를 수행합니다.\n\n주제를 선정합니다.\n\n스케치를 합니다.\n\n물감을 사용합니다.\n\n작품을 완성합니다.\n\n전시회를 준비합니다.... 기반으로 50로 평가","creative":"creative는 화가는 그림을 그리는 업무를 수행합니다.\n\n주제를 선정합니다.\n\n스케치를 합니다.\n\n물감을 사용합니다.\n\n작품을 완성합니다.\n\n전시회를 준비합니다.... 기반으로 50로 평가","execution":"execution는 화가는 그림을 그리는 업무를 수행합니다.\n\n주제를 선정합니다.\n\n스케치를 합니다.\n\n물감을 사용합니다.\n\n작품을 완성합니다.\n\n전시회를 준비합니다.... 기반으로 50로 평가","people_facing":"people_facing는 화가는 그림을 그리는 업무를 수행합니다.\n\n주제를 선정합니다.\n\n스케치를 합니다.\n\n물감을 사용합니다.\n\n작품을 완성합니다.\n\n전시회를 준비합니다.... 기반으로 50로 평가","degree_required":"degree_required는 화가는 그림을 그리는 업무를 수행합니다.\n\n주제를 선정합니다.\n\n스케치를 합니다.\n\n물감을 사용합니다.\n\n작품을 완성합니다.\n\n전시회를 준비합니다.... 기반으로 none로 평가","license_required":"license_required는 화가는 그림을 그리는 업무를 수행합니다.\n\n주제를 선정합니다.\n\n스케치를 합니다.\n\n물감을 사용합니다.\n\n작품을 완성합니다.\n\n전시회를 준비합니다.... 기반으로 none로 평가"}'
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
  '1765283363398634',
  '장례지도사',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  50, 50, 50, 50, 50, 75,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 장례지도사는 장례 절차를 진행하는 업무를 수행합니다.\n\n고인과 가족을 상담합니다.\n\n장례 절차를 계획합니다.\n\n장례식을 진행합니다.\n\n행정 절차를 처리합니다.\n\n유족을 지원합니다.... 기반으로 50로 평가","growth":"growth는 장례지도사는 장례 절차를 진행하는 업무를 수행합니다.\n\n고인과 가족을 상담합니다.\n\n장례 절차를 계획합니다.\n\n장례식을 진행합니다.\n\n행정 절차를 처리합니다.\n\n유족을 지원합니다.... 기반으로 50로 평가","stability":"stability는 장례지도사는 장례 절차를 진행하는 업무를 수행합니다.\n\n고인과 가족을 상담합니다.\n\n장례 절차를 계획합니다.\n\n장례식을 진행합니다.\n\n행정 절차를 처리합니다.\n\n유족을 지원합니다.... 기반으로 50로 평가","income":"income는 장례지도사는 장례 절차를 진행하는 업무를 수행합니다.\n\n고인과 가족을 상담합니다.\n\n장례 절차를 계획합니다.\n\n장례식을 진행합니다.\n\n행정 절차를 처리합니다.\n\n유족을 지원합니다.... 기반으로 50로 평가","teamwork":"teamwork는 장례지도사는 장례 절차를 진행하는 업무를 수행합니다.\n\n고인과 가족을 상담합니다.\n\n장례 절차를 계획합니다.\n\n장례식을 진행합니다.\n\n행정 절차를 처리합니다.\n\n유족을 지원합니다.... 기반으로 50로 평가","solo_deep":"solo_deep는 장례지도사는 장례 절차를 진행하는 업무를 수행합니다.\n\n고인과 가족을 상담합니다.\n\n장례 절차를 계획합니다.\n\n장례식을 진행합니다.\n\n행정 절차를 처리합니다.\n\n유족을 지원합니다.... 기반으로 50로 평가","analytical":"analytical는 장례지도사는 장례 절차를 진행하는 업무를 수행합니다.\n\n고인과 가족을 상담합니다.\n\n장례 절차를 계획합니다.\n\n장례식을 진행합니다.\n\n행정 절차를 처리합니다.\n\n유족을 지원합니다.... 기반으로 50로 평가","creative":"creative는 장례지도사는 장례 절차를 진행하는 업무를 수행합니다.\n\n고인과 가족을 상담합니다.\n\n장례 절차를 계획합니다.\n\n장례식을 진행합니다.\n\n행정 절차를 처리합니다.\n\n유족을 지원합니다.... 기반으로 50로 평가","execution":"execution는 장례지도사는 장례 절차를 진행하는 업무를 수행합니다.\n\n고인과 가족을 상담합니다.\n\n장례 절차를 계획합니다.\n\n장례식을 진행합니다.\n\n행정 절차를 처리합니다.\n\n유족을 지원합니다.... 기반으로 50로 평가","people_facing":"people_facing는 장례지도사는 장례 절차를 진행하는 업무를 수행합니다.\n\n고인과 가족을 상담합니다.\n\n장례 절차를 계획합니다.\n\n장례식을 진행합니다.\n\n행정 절차를 처리합니다.\n\n유족을 지원합니다.... 기반으로 75로 평가","degree_required":"degree_required는 장례지도사는 장례 절차를 진행하는 업무를 수행합니다.\n\n고인과 가족을 상담합니다.\n\n장례 절차를 계획합니다.\n\n장례식을 진행합니다.\n\n행정 절차를 처리합니다.\n\n유족을 지원합니다.... 기반으로 none로 평가","license_required":"license_required는 장례지도사는 장례 절차를 진행하는 업무를 수행합니다.\n\n고인과 가족을 상담합니다.\n\n장례 절차를 계획합니다.\n\n장례식을 진행합니다.\n\n행정 절차를 처리합니다.\n\n유족을 지원합니다.... 기반으로 none로 평가"}'
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
  '1765283356346547',
  '인문계중등학교교사',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  50, 50, 70, 40, 40, 75,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 인문계중등학교교사는 중학교에서 인문 과목을 가르치는 업무를 수행합니다.\n\n수업 계획을 세웁니다.\n\n학생들을 가르칩니다.\n\n시험을 출제합니다.\n\n성적을 평가합니다.\n\n학생 상담을 합... 기반으로 50로 평가","growth":"growth는 인문계중등학교교사는 중학교에서 인문 과목을 가르치는 업무를 수행합니다.\n\n수업 계획을 세웁니다.\n\n학생들을 가르칩니다.\n\n시험을 출제합니다.\n\n성적을 평가합니다.\n\n학생 상담을 합... 기반으로 50로 평가","stability":"stability는 인문계중등학교교사는 중학교에서 인문 과목을 가르치는 업무를 수행합니다.\n\n수업 계획을 세웁니다.\n\n학생들을 가르칩니다.\n\n시험을 출제합니다.\n\n성적을 평가합니다.\n\n학생 상담을 합... 기반으로 50로 평가","income":"income는 인문계중등학교교사는 중학교에서 인문 과목을 가르치는 업무를 수행합니다.\n\n수업 계획을 세웁니다.\n\n학생들을 가르칩니다.\n\n시험을 출제합니다.\n\n성적을 평가합니다.\n\n학생 상담을 합... 기반으로 50로 평가","teamwork":"teamwork는 인문계중등학교교사는 중학교에서 인문 과목을 가르치는 업무를 수행합니다.\n\n수업 계획을 세웁니다.\n\n학생들을 가르칩니다.\n\n시험을 출제합니다.\n\n성적을 평가합니다.\n\n학생 상담을 합... 기반으로 50로 평가","solo_deep":"solo_deep는 인문계중등학교교사는 중학교에서 인문 과목을 가르치는 업무를 수행합니다.\n\n수업 계획을 세웁니다.\n\n학생들을 가르칩니다.\n\n시험을 출제합니다.\n\n성적을 평가합니다.\n\n학생 상담을 합... 기반으로 50로 평가","analytical":"analytical는 인문계중등학교교사는 중학교에서 인문 과목을 가르치는 업무를 수행합니다.\n\n수업 계획을 세웁니다.\n\n학생들을 가르칩니다.\n\n시험을 출제합니다.\n\n성적을 평가합니다.\n\n학생 상담을 합... 기반으로 70로 평가","creative":"creative는 인문계중등학교교사는 중학교에서 인문 과목을 가르치는 업무를 수행합니다.\n\n수업 계획을 세웁니다.\n\n학생들을 가르칩니다.\n\n시험을 출제합니다.\n\n성적을 평가합니다.\n\n학생 상담을 합... 기반으로 40로 평가","execution":"execution는 인문계중등학교교사는 중학교에서 인문 과목을 가르치는 업무를 수행합니다.\n\n수업 계획을 세웁니다.\n\n학생들을 가르칩니다.\n\n시험을 출제합니다.\n\n성적을 평가합니다.\n\n학생 상담을 합... 기반으로 40로 평가","people_facing":"people_facing는 인문계중등학교교사는 중학교에서 인문 과목을 가르치는 업무를 수행합니다.\n\n수업 계획을 세웁니다.\n\n학생들을 가르칩니다.\n\n시험을 출제합니다.\n\n성적을 평가합니다.\n\n학생 상담을 합... 기반으로 75로 평가","degree_required":"degree_required는 인문계중등학교교사는 중학교에서 인문 과목을 가르치는 업무를 수행합니다.\n\n수업 계획을 세웁니다.\n\n학생들을 가르칩니다.\n\n시험을 출제합니다.\n\n성적을 평가합니다.\n\n학생 상담을 합... 기반으로 none로 평가","license_required":"license_required는 인문계중등학교교사는 중학교에서 인문 과목을 가르치는 업무를 수행합니다.\n\n수업 계획을 세웁니다.\n\n학생들을 가르칩니다.\n\n시험을 출제합니다.\n\n성적을 평가합니다.\n\n학생 상담을 합... 기반으로 none로 평가"}'
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
  '1765283330181114',
  '소음진동기술자',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  50, 50, 60, 30, 60, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 소음진동기술자는 소음과 진동을 측정하고 제어하는 업무를 수행합니다.\n\n측정 장비를 설치합니다.\n\n소음과 진동을 측정합니다.\n\n데이터를 분석합니다.\n\n제어 방법을 제안합니다.\n\n보고... 기반으로 50로 평가","growth":"growth는 소음진동기술자는 소음과 진동을 측정하고 제어하는 업무를 수행합니다.\n\n측정 장비를 설치합니다.\n\n소음과 진동을 측정합니다.\n\n데이터를 분석합니다.\n\n제어 방법을 제안합니다.\n\n보고... 기반으로 50로 평가","stability":"stability는 소음진동기술자는 소음과 진동을 측정하고 제어하는 업무를 수행합니다.\n\n측정 장비를 설치합니다.\n\n소음과 진동을 측정합니다.\n\n데이터를 분석합니다.\n\n제어 방법을 제안합니다.\n\n보고... 기반으로 50로 평가","income":"income는 소음진동기술자는 소음과 진동을 측정하고 제어하는 업무를 수행합니다.\n\n측정 장비를 설치합니다.\n\n소음과 진동을 측정합니다.\n\n데이터를 분석합니다.\n\n제어 방법을 제안합니다.\n\n보고... 기반으로 50로 평가","teamwork":"teamwork는 소음진동기술자는 소음과 진동을 측정하고 제어하는 업무를 수행합니다.\n\n측정 장비를 설치합니다.\n\n소음과 진동을 측정합니다.\n\n데이터를 분석합니다.\n\n제어 방법을 제안합니다.\n\n보고... 기반으로 50로 평가","solo_deep":"solo_deep는 소음진동기술자는 소음과 진동을 측정하고 제어하는 업무를 수행합니다.\n\n측정 장비를 설치합니다.\n\n소음과 진동을 측정합니다.\n\n데이터를 분석합니다.\n\n제어 방법을 제안합니다.\n\n보고... 기반으로 50로 평가","analytical":"analytical는 소음진동기술자는 소음과 진동을 측정하고 제어하는 업무를 수행합니다.\n\n측정 장비를 설치합니다.\n\n소음과 진동을 측정합니다.\n\n데이터를 분석합니다.\n\n제어 방법을 제안합니다.\n\n보고... 기반으로 60로 평가","creative":"creative는 소음진동기술자는 소음과 진동을 측정하고 제어하는 업무를 수행합니다.\n\n측정 장비를 설치합니다.\n\n소음과 진동을 측정합니다.\n\n데이터를 분석합니다.\n\n제어 방법을 제안합니다.\n\n보고... 기반으로 30로 평가","execution":"execution는 소음진동기술자는 소음과 진동을 측정하고 제어하는 업무를 수행합니다.\n\n측정 장비를 설치합니다.\n\n소음과 진동을 측정합니다.\n\n데이터를 분석합니다.\n\n제어 방법을 제안합니다.\n\n보고... 기반으로 60로 평가","people_facing":"people_facing는 소음진동기술자는 소음과 진동을 측정하고 제어하는 업무를 수행합니다.\n\n측정 장비를 설치합니다.\n\n소음과 진동을 측정합니다.\n\n데이터를 분석합니다.\n\n제어 방법을 제안합니다.\n\n보고... 기반으로 50로 평가","degree_required":"degree_required는 소음진동기술자는 소음과 진동을 측정하고 제어하는 업무를 수행합니다.\n\n측정 장비를 설치합니다.\n\n소음과 진동을 측정합니다.\n\n데이터를 분석합니다.\n\n제어 방법을 제안합니다.\n\n보고... 기반으로 none로 평가","license_required":"license_required는 소음진동기술자는 소음과 진동을 측정하고 제어하는 업무를 수행합니다.\n\n측정 장비를 설치합니다.\n\n소음과 진동을 측정합니다.\n\n데이터를 분석합니다.\n\n제어 방법을 제안합니다.\n\n보고... 기반으로 none로 평가"}'
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
  '1765283340456966',
  '애니메이션작가',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 50, 40,
  70, 30, 30, 60, 60, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 애니메이션작가는 애니메이션 스토리를 쓰는 업무를 수행합니다.\n\n스토리를 기획합니다.\n\n등장인물을 설정합니다.\n\n대본을 작성합니다.\n\n콘티를 만듭니다.\n\n제작팀과 협의합니다.... 기반으로 50로 평가","growth":"growth는 애니메이션작가는 애니메이션 스토리를 쓰는 업무를 수행합니다.\n\n스토리를 기획합니다.\n\n등장인물을 설정합니다.\n\n대본을 작성합니다.\n\n콘티를 만듭니다.\n\n제작팀과 협의합니다.... 기반으로 65로 평가","stability":"stability는 애니메이션작가는 애니메이션 스토리를 쓰는 업무를 수행합니다.\n\n스토리를 기획합니다.\n\n등장인물을 설정합니다.\n\n대본을 작성합니다.\n\n콘티를 만듭니다.\n\n제작팀과 협의합니다.... 기반으로 50로 평가","income":"income는 애니메이션작가는 애니메이션 스토리를 쓰는 업무를 수행합니다.\n\n스토리를 기획합니다.\n\n등장인물을 설정합니다.\n\n대본을 작성합니다.\n\n콘티를 만듭니다.\n\n제작팀과 협의합니다.... 기반으로 40로 평가","teamwork":"teamwork는 애니메이션작가는 애니메이션 스토리를 쓰는 업무를 수행합니다.\n\n스토리를 기획합니다.\n\n등장인물을 설정합니다.\n\n대본을 작성합니다.\n\n콘티를 만듭니다.\n\n제작팀과 협의합니다.... 기반으로 70로 평가","solo_deep":"solo_deep는 애니메이션작가는 애니메이션 스토리를 쓰는 업무를 수행합니다.\n\n스토리를 기획합니다.\n\n등장인물을 설정합니다.\n\n대본을 작성합니다.\n\n콘티를 만듭니다.\n\n제작팀과 협의합니다.... 기반으로 30로 평가","analytical":"analytical는 애니메이션작가는 애니메이션 스토리를 쓰는 업무를 수행합니다.\n\n스토리를 기획합니다.\n\n등장인물을 설정합니다.\n\n대본을 작성합니다.\n\n콘티를 만듭니다.\n\n제작팀과 협의합니다.... 기반으로 30로 평가","creative":"creative는 애니메이션작가는 애니메이션 스토리를 쓰는 업무를 수행합니다.\n\n스토리를 기획합니다.\n\n등장인물을 설정합니다.\n\n대본을 작성합니다.\n\n콘티를 만듭니다.\n\n제작팀과 협의합니다.... 기반으로 60로 평가","execution":"execution는 애니메이션작가는 애니메이션 스토리를 쓰는 업무를 수행합니다.\n\n스토리를 기획합니다.\n\n등장인물을 설정합니다.\n\n대본을 작성합니다.\n\n콘티를 만듭니다.\n\n제작팀과 협의합니다.... 기반으로 60로 평가","people_facing":"people_facing는 애니메이션작가는 애니메이션 스토리를 쓰는 업무를 수행합니다.\n\n스토리를 기획합니다.\n\n등장인물을 설정합니다.\n\n대본을 작성합니다.\n\n콘티를 만듭니다.\n\n제작팀과 협의합니다.... 기반으로 50로 평가","degree_required":"degree_required는 애니메이션작가는 애니메이션 스토리를 쓰는 업무를 수행합니다.\n\n스토리를 기획합니다.\n\n등장인물을 설정합니다.\n\n대본을 작성합니다.\n\n콘티를 만듭니다.\n\n제작팀과 협의합니다.... 기반으로 none로 평가","license_required":"license_required는 애니메이션작가는 애니메이션 스토리를 쓰는 업무를 수행합니다.\n\n스토리를 기획합니다.\n\n등장인물을 설정합니다.\n\n대본을 작성합니다.\n\n콘티를 만듭니다.\n\n제작팀과 협의합니다.... 기반으로 none로 평가"}'
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

COMMIT;