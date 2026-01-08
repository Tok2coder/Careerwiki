-- Batch tagging SQL generated at 2026-01-06T07:18:47.131Z
-- Tagger version: tagger-v1.0.0
-- Total jobs: 1

BEGIN TRANSACTION;


INSERT INTO job_attributes (
  job_id, job_name, source_system, tagger_version, status,
  wlb, growth, stability, income,
  teamwork, solo_deep, analytical, creative, execution, people_facing,
  work_hours, shift_work, travel, remote_possible,
  degree_required, license_required, experience_required,
  _confidence, _field_confidence_json, evidence_json
) VALUES (
  '1765283324729983',
  '서예가',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 40,
  30, 70, 50, 50, 50, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 서예가는 먹과 붓을 이용하여 화선지에 글이나 시를 쓰거나 사군자를 그리는 일을 합니다.\n\n완성된 작품에 대하여 표구(그림의 뒷면이나 테두리에 종이 또는 천을 발라서 꾸미는 일)를 ... 기반으로 50로 평가","growth":"growth는 서예가는 먹과 붓을 이용하여 화선지에 글이나 시를 쓰거나 사군자를 그리는 일을 합니다.\n\n완성된 작품에 대하여 표구(그림의 뒷면이나 테두리에 종이 또는 천을 발라서 꾸미는 일)를 ... 기반으로 50로 평가","stability":"stability는 서예가는 먹과 붓을 이용하여 화선지에 글이나 시를 쓰거나 사군자를 그리는 일을 합니다.\n\n완성된 작품에 대하여 표구(그림의 뒷면이나 테두리에 종이 또는 천을 발라서 꾸미는 일)를 ... 기반으로 50로 평가","income":"income는 서예가는 먹과 붓을 이용하여 화선지에 글이나 시를 쓰거나 사군자를 그리는 일을 합니다.\n\n완성된 작품에 대하여 표구(그림의 뒷면이나 테두리에 종이 또는 천을 발라서 꾸미는 일)를 ... 기반으로 40로 평가","teamwork":"teamwork는 서예가는 먹과 붓을 이용하여 화선지에 글이나 시를 쓰거나 사군자를 그리는 일을 합니다.\n\n완성된 작품에 대하여 표구(그림의 뒷면이나 테두리에 종이 또는 천을 발라서 꾸미는 일)를 ... 기반으로 30로 평가","solo_deep":"solo_deep는 서예가는 먹과 붓을 이용하여 화선지에 글이나 시를 쓰거나 사군자를 그리는 일을 합니다.\n\n완성된 작품에 대하여 표구(그림의 뒷면이나 테두리에 종이 또는 천을 발라서 꾸미는 일)를 ... 기반으로 70로 평가","analytical":"analytical는 서예가는 먹과 붓을 이용하여 화선지에 글이나 시를 쓰거나 사군자를 그리는 일을 합니다.\n\n완성된 작품에 대하여 표구(그림의 뒷면이나 테두리에 종이 또는 천을 발라서 꾸미는 일)를 ... 기반으로 50로 평가","creative":"creative는 서예가는 먹과 붓을 이용하여 화선지에 글이나 시를 쓰거나 사군자를 그리는 일을 합니다.\n\n완성된 작품에 대하여 표구(그림의 뒷면이나 테두리에 종이 또는 천을 발라서 꾸미는 일)를 ... 기반으로 50로 평가","execution":"execution는 서예가는 먹과 붓을 이용하여 화선지에 글이나 시를 쓰거나 사군자를 그리는 일을 합니다.\n\n완성된 작품에 대하여 표구(그림의 뒷면이나 테두리에 종이 또는 천을 발라서 꾸미는 일)를 ... 기반으로 50로 평가","people_facing":"people_facing는 서예가는 먹과 붓을 이용하여 화선지에 글이나 시를 쓰거나 사군자를 그리는 일을 합니다.\n\n완성된 작품에 대하여 표구(그림의 뒷면이나 테두리에 종이 또는 천을 발라서 꾸미는 일)를 ... 기반으로 50로 평가","degree_required":"degree_required는 서예가는 먹과 붓을 이용하여 화선지에 글이나 시를 쓰거나 사군자를 그리는 일을 합니다.\n\n완성된 작품에 대하여 표구(그림의 뒷면이나 테두리에 종이 또는 천을 발라서 꾸미는 일)를 ... 기반으로 none로 평가","license_required":"license_required는 서예가는 먹과 붓을 이용하여 화선지에 글이나 시를 쓰거나 사군자를 그리는 일을 합니다.\n\n완성된 작품에 대하여 표구(그림의 뒷면이나 테두리에 종이 또는 천을 발라서 꾸미는 일)를 ... 기반으로 none로 평가"}'
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