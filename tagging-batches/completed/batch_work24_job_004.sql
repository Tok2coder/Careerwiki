-- Batch tagging SQL generated at 2026-01-06T06:57:51.243Z
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
  '1765283522625491',
  '떡제조원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  50, 50, 40, 40, 70, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [떡제조원]\n-떡 반죽을 준비한다.\n-재료를 계량한다.\n-반죽을 치댄다.\n-떡을 성형한다.\n-증기를 이용해 찐다.\n-냉각과 포장을 한다.\n-품질을 검사한다.\n-위생을 유지한다.\n-... 기반으로 50로 평가","growth":"growth는 [떡제조원]\n-떡 반죽을 준비한다.\n-재료를 계량한다.\n-반죽을 치댄다.\n-떡을 성형한다.\n-증기를 이용해 찐다.\n-냉각과 포장을 한다.\n-품질을 검사한다.\n-위생을 유지한다.\n-... 기반으로 50로 평가","stability":"stability는 [떡제조원]\n-떡 반죽을 준비한다.\n-재료를 계량한다.\n-반죽을 치댄다.\n-떡을 성형한다.\n-증기를 이용해 찐다.\n-냉각과 포장을 한다.\n-품질을 검사한다.\n-위생을 유지한다.\n-... 기반으로 50로 평가","income":"income는 [떡제조원]\n-떡 반죽을 준비한다.\n-재료를 계량한다.\n-반죽을 치댄다.\n-떡을 성형한다.\n-증기를 이용해 찐다.\n-냉각과 포장을 한다.\n-품질을 검사한다.\n-위생을 유지한다.\n-... 기반으로 50로 평가","teamwork":"teamwork는 [떡제조원]\n-떡 반죽을 준비한다.\n-재료를 계량한다.\n-반죽을 치댄다.\n-떡을 성형한다.\n-증기를 이용해 찐다.\n-냉각과 포장을 한다.\n-품질을 검사한다.\n-위생을 유지한다.\n-... 기반으로 50로 평가","solo_deep":"solo_deep는 [떡제조원]\n-떡 반죽을 준비한다.\n-재료를 계량한다.\n-반죽을 치댄다.\n-떡을 성형한다.\n-증기를 이용해 찐다.\n-냉각과 포장을 한다.\n-품질을 검사한다.\n-위생을 유지한다.\n-... 기반으로 50로 평가","analytical":"analytical는 [떡제조원]\n-떡 반죽을 준비한다.\n-재료를 계량한다.\n-반죽을 치댄다.\n-떡을 성형한다.\n-증기를 이용해 찐다.\n-냉각과 포장을 한다.\n-품질을 검사한다.\n-위생을 유지한다.\n-... 기반으로 40로 평가","creative":"creative는 [떡제조원]\n-떡 반죽을 준비한다.\n-재료를 계량한다.\n-반죽을 치댄다.\n-떡을 성형한다.\n-증기를 이용해 찐다.\n-냉각과 포장을 한다.\n-품질을 검사한다.\n-위생을 유지한다.\n-... 기반으로 40로 평가","execution":"execution는 [떡제조원]\n-떡 반죽을 준비한다.\n-재료를 계량한다.\n-반죽을 치댄다.\n-떡을 성형한다.\n-증기를 이용해 찐다.\n-냉각과 포장을 한다.\n-품질을 검사한다.\n-위생을 유지한다.\n-... 기반으로 70로 평가","people_facing":"people_facing는 [떡제조원]\n-떡 반죽을 준비한다.\n-재료를 계량한다.\n-반죽을 치댄다.\n-떡을 성형한다.\n-증기를 이용해 찐다.\n-냉각과 포장을 한다.\n-품질을 검사한다.\n-위생을 유지한다.\n-... 기반으로 50로 평가","degree_required":"degree_required는 [떡제조원]\n-떡 반죽을 준비한다.\n-재료를 계량한다.\n-반죽을 치댄다.\n-떡을 성형한다.\n-증기를 이용해 찐다.\n-냉각과 포장을 한다.\n-품질을 검사한다.\n-위생을 유지한다.\n-... 기반으로 none로 평가","license_required":"license_required는 [떡제조원]\n-떡 반죽을 준비한다.\n-재료를 계량한다.\n-반죽을 치댄다.\n-떡을 성형한다.\n-증기를 이용해 찐다.\n-냉각과 포장을 한다.\n-품질을 검사한다.\n-위생을 유지한다.\n-... 기반으로 none로 평가"}'
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
  '1765283499829703',
  '공업배관공',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 50, 50,
  50, 50, 40, 40, 70, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [공업배관공]\n-배관 설계도를 읽는다.\n-배관 재료를 준비한다.\n-배관을 절단한다.\n-배관을 연결한다.\n-용접을 실시한다.\n-누수 검사를 한다.\n-배관을 설치한다.\n-유지보수를 한... 기반으로 50로 평가","growth":"growth는 [공업배관공]\n-배관 설계도를 읽는다.\n-배관 재료를 준비한다.\n-배관을 절단한다.\n-배관을 연결한다.\n-용접을 실시한다.\n-누수 검사를 한다.\n-배관을 설치한다.\n-유지보수를 한... 기반으로 65로 평가","stability":"stability는 [공업배관공]\n-배관 설계도를 읽는다.\n-배관 재료를 준비한다.\n-배관을 절단한다.\n-배관을 연결한다.\n-용접을 실시한다.\n-누수 검사를 한다.\n-배관을 설치한다.\n-유지보수를 한... 기반으로 50로 평가","income":"income는 [공업배관공]\n-배관 설계도를 읽는다.\n-배관 재료를 준비한다.\n-배관을 절단한다.\n-배관을 연결한다.\n-용접을 실시한다.\n-누수 검사를 한다.\n-배관을 설치한다.\n-유지보수를 한... 기반으로 50로 평가","teamwork":"teamwork는 [공업배관공]\n-배관 설계도를 읽는다.\n-배관 재료를 준비한다.\n-배관을 절단한다.\n-배관을 연결한다.\n-용접을 실시한다.\n-누수 검사를 한다.\n-배관을 설치한다.\n-유지보수를 한... 기반으로 50로 평가","solo_deep":"solo_deep는 [공업배관공]\n-배관 설계도를 읽는다.\n-배관 재료를 준비한다.\n-배관을 절단한다.\n-배관을 연결한다.\n-용접을 실시한다.\n-누수 검사를 한다.\n-배관을 설치한다.\n-유지보수를 한... 기반으로 50로 평가","analytical":"analytical는 [공업배관공]\n-배관 설계도를 읽는다.\n-배관 재료를 준비한다.\n-배관을 절단한다.\n-배관을 연결한다.\n-용접을 실시한다.\n-누수 검사를 한다.\n-배관을 설치한다.\n-유지보수를 한... 기반으로 40로 평가","creative":"creative는 [공업배관공]\n-배관 설계도를 읽는다.\n-배관 재료를 준비한다.\n-배관을 절단한다.\n-배관을 연결한다.\n-용접을 실시한다.\n-누수 검사를 한다.\n-배관을 설치한다.\n-유지보수를 한... 기반으로 40로 평가","execution":"execution는 [공업배관공]\n-배관 설계도를 읽는다.\n-배관 재료를 준비한다.\n-배관을 절단한다.\n-배관을 연결한다.\n-용접을 실시한다.\n-누수 검사를 한다.\n-배관을 설치한다.\n-유지보수를 한... 기반으로 70로 평가","people_facing":"people_facing는 [공업배관공]\n-배관 설계도를 읽는다.\n-배관 재료를 준비한다.\n-배관을 절단한다.\n-배관을 연결한다.\n-용접을 실시한다.\n-누수 검사를 한다.\n-배관을 설치한다.\n-유지보수를 한... 기반으로 50로 평가","degree_required":"degree_required는 [공업배관공]\n-배관 설계도를 읽는다.\n-배관 재료를 준비한다.\n-배관을 절단한다.\n-배관을 연결한다.\n-용접을 실시한다.\n-누수 검사를 한다.\n-배관을 설치한다.\n-유지보수를 한... 기반으로 none로 평가","license_required":"license_required는 [공업배관공]\n-배관 설계도를 읽는다.\n-배관 재료를 준비한다.\n-배관을 절단한다.\n-배관을 연결한다.\n-용접을 실시한다.\n-누수 검사를 한다.\n-배관을 설치한다.\n-유지보수를 한... 기반으로 none로 평가"}'
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
  '1765283491499585',
  '철도교통관제사',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  50, 50, 40, 40, 70, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [철도관제사]\n-열차 운행을 모니터링한다.\n-신호 체계를 운영한다.\n-열차 스케줄을 관리한다.\n-비상 상황에 대응한다.\n-통신을 유지한다.\n-안전 규정을 준수한다.\n-보고서를 작성... 기반으로 50로 평가","growth":"growth는 [철도관제사]\n-열차 운행을 모니터링한다.\n-신호 체계를 운영한다.\n-열차 스케줄을 관리한다.\n-비상 상황에 대응한다.\n-통신을 유지한다.\n-안전 규정을 준수한다.\n-보고서를 작성... 기반으로 50로 평가","stability":"stability는 [철도관제사]\n-열차 운행을 모니터링한다.\n-신호 체계를 운영한다.\n-열차 스케줄을 관리한다.\n-비상 상황에 대응한다.\n-통신을 유지한다.\n-안전 규정을 준수한다.\n-보고서를 작성... 기반으로 50로 평가","income":"income는 [철도관제사]\n-열차 운행을 모니터링한다.\n-신호 체계를 운영한다.\n-열차 스케줄을 관리한다.\n-비상 상황에 대응한다.\n-통신을 유지한다.\n-안전 규정을 준수한다.\n-보고서를 작성... 기반으로 50로 평가","teamwork":"teamwork는 [철도관제사]\n-열차 운행을 모니터링한다.\n-신호 체계를 운영한다.\n-열차 스케줄을 관리한다.\n-비상 상황에 대응한다.\n-통신을 유지한다.\n-안전 규정을 준수한다.\n-보고서를 작성... 기반으로 50로 평가","solo_deep":"solo_deep는 [철도관제사]\n-열차 운행을 모니터링한다.\n-신호 체계를 운영한다.\n-열차 스케줄을 관리한다.\n-비상 상황에 대응한다.\n-통신을 유지한다.\n-안전 규정을 준수한다.\n-보고서를 작성... 기반으로 50로 평가","analytical":"analytical는 [철도관제사]\n-열차 운행을 모니터링한다.\n-신호 체계를 운영한다.\n-열차 스케줄을 관리한다.\n-비상 상황에 대응한다.\n-통신을 유지한다.\n-안전 규정을 준수한다.\n-보고서를 작성... 기반으로 40로 평가","creative":"creative는 [철도관제사]\n-열차 운행을 모니터링한다.\n-신호 체계를 운영한다.\n-열차 스케줄을 관리한다.\n-비상 상황에 대응한다.\n-통신을 유지한다.\n-안전 규정을 준수한다.\n-보고서를 작성... 기반으로 40로 평가","execution":"execution는 [철도관제사]\n-열차 운행을 모니터링한다.\n-신호 체계를 운영한다.\n-열차 스케줄을 관리한다.\n-비상 상황에 대응한다.\n-통신을 유지한다.\n-안전 규정을 준수한다.\n-보고서를 작성... 기반으로 70로 평가","people_facing":"people_facing는 [철도관제사]\n-열차 운행을 모니터링한다.\n-신호 체계를 운영한다.\n-열차 스케줄을 관리한다.\n-비상 상황에 대응한다.\n-통신을 유지한다.\n-안전 규정을 준수한다.\n-보고서를 작성... 기반으로 50로 평가","degree_required":"degree_required는 [철도관제사]\n-열차 운행을 모니터링한다.\n-신호 체계를 운영한다.\n-열차 스케줄을 관리한다.\n-비상 상황에 대응한다.\n-통신을 유지한다.\n-안전 규정을 준수한다.\n-보고서를 작성... 기반으로 none로 평가","license_required":"license_required는 [철도관제사]\n-열차 운행을 모니터링한다.\n-신호 체계를 운영한다.\n-열차 스케줄을 관리한다.\n-비상 상황에 대응한다.\n-통신을 유지한다.\n-안전 규정을 준수한다.\n-보고서를 작성... 기반으로 none로 평가"}'
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
  '1765283494731969',
  '건축목공',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  50, 50, 30, 60, 60, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [건축목공]\n-목재를 재단한다.\n-골조를 조립한다.\n-문과 창문을 설치한다.\n-마감을 한다.\n-가구를 제작한다.\n-수리를 한다.\n-안전 수칙을 준수한다.\n-도구를 관리한다.\n-품질... 기반으로 50로 평가","growth":"growth는 [건축목공]\n-목재를 재단한다.\n-골조를 조립한다.\n-문과 창문을 설치한다.\n-마감을 한다.\n-가구를 제작한다.\n-수리를 한다.\n-안전 수칙을 준수한다.\n-도구를 관리한다.\n-품질... 기반으로 50로 평가","stability":"stability는 [건축목공]\n-목재를 재단한다.\n-골조를 조립한다.\n-문과 창문을 설치한다.\n-마감을 한다.\n-가구를 제작한다.\n-수리를 한다.\n-안전 수칙을 준수한다.\n-도구를 관리한다.\n-품질... 기반으로 50로 평가","income":"income는 [건축목공]\n-목재를 재단한다.\n-골조를 조립한다.\n-문과 창문을 설치한다.\n-마감을 한다.\n-가구를 제작한다.\n-수리를 한다.\n-안전 수칙을 준수한다.\n-도구를 관리한다.\n-품질... 기반으로 50로 평가","teamwork":"teamwork는 [건축목공]\n-목재를 재단한다.\n-골조를 조립한다.\n-문과 창문을 설치한다.\n-마감을 한다.\n-가구를 제작한다.\n-수리를 한다.\n-안전 수칙을 준수한다.\n-도구를 관리한다.\n-품질... 기반으로 50로 평가","solo_deep":"solo_deep는 [건축목공]\n-목재를 재단한다.\n-골조를 조립한다.\n-문과 창문을 설치한다.\n-마감을 한다.\n-가구를 제작한다.\n-수리를 한다.\n-안전 수칙을 준수한다.\n-도구를 관리한다.\n-품질... 기반으로 50로 평가","analytical":"analytical는 [건축목공]\n-목재를 재단한다.\n-골조를 조립한다.\n-문과 창문을 설치한다.\n-마감을 한다.\n-가구를 제작한다.\n-수리를 한다.\n-안전 수칙을 준수한다.\n-도구를 관리한다.\n-품질... 기반으로 30로 평가","creative":"creative는 [건축목공]\n-목재를 재단한다.\n-골조를 조립한다.\n-문과 창문을 설치한다.\n-마감을 한다.\n-가구를 제작한다.\n-수리를 한다.\n-안전 수칙을 준수한다.\n-도구를 관리한다.\n-품질... 기반으로 60로 평가","execution":"execution는 [건축목공]\n-목재를 재단한다.\n-골조를 조립한다.\n-문과 창문을 설치한다.\n-마감을 한다.\n-가구를 제작한다.\n-수리를 한다.\n-안전 수칙을 준수한다.\n-도구를 관리한다.\n-품질... 기반으로 60로 평가","people_facing":"people_facing는 [건축목공]\n-목재를 재단한다.\n-골조를 조립한다.\n-문과 창문을 설치한다.\n-마감을 한다.\n-가구를 제작한다.\n-수리를 한다.\n-안전 수칙을 준수한다.\n-도구를 관리한다.\n-품질... 기반으로 50로 평가","degree_required":"degree_required는 [건축목공]\n-목재를 재단한다.\n-골조를 조립한다.\n-문과 창문을 설치한다.\n-마감을 한다.\n-가구를 제작한다.\n-수리를 한다.\n-안전 수칙을 준수한다.\n-도구를 관리한다.\n-품질... 기반으로 none로 평가","license_required":"license_required는 [건축목공]\n-목재를 재단한다.\n-골조를 조립한다.\n-문과 창문을 설치한다.\n-마감을 한다.\n-가구를 제작한다.\n-수리를 한다.\n-안전 수칙을 준수한다.\n-도구를 관리한다.\n-품질... 기반으로 none로 평가"}'
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
  '1765283498976241',
  '건물도장공',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  50, 50, 40, 40, 70, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [건물도장공]\n-표면을 준비한다.\n-프라이머를 바른다.\n-페인트를 혼합한다.\n-도장을 실시한다.\n-마무리를 한다.\n-품질을 검사한다.\n-안전 수칙을 준수한다.\n-장비를 관리한다.\n... 기반으로 50로 평가","growth":"growth는 [건물도장공]\n-표면을 준비한다.\n-프라이머를 바른다.\n-페인트를 혼합한다.\n-도장을 실시한다.\n-마무리를 한다.\n-품질을 검사한다.\n-안전 수칙을 준수한다.\n-장비를 관리한다.\n... 기반으로 50로 평가","stability":"stability는 [건물도장공]\n-표면을 준비한다.\n-프라이머를 바른다.\n-페인트를 혼합한다.\n-도장을 실시한다.\n-마무리를 한다.\n-품질을 검사한다.\n-안전 수칙을 준수한다.\n-장비를 관리한다.\n... 기반으로 50로 평가","income":"income는 [건물도장공]\n-표면을 준비한다.\n-프라이머를 바른다.\n-페인트를 혼합한다.\n-도장을 실시한다.\n-마무리를 한다.\n-품질을 검사한다.\n-안전 수칙을 준수한다.\n-장비를 관리한다.\n... 기반으로 50로 평가","teamwork":"teamwork는 [건물도장공]\n-표면을 준비한다.\n-프라이머를 바른다.\n-페인트를 혼합한다.\n-도장을 실시한다.\n-마무리를 한다.\n-품질을 검사한다.\n-안전 수칙을 준수한다.\n-장비를 관리한다.\n... 기반으로 50로 평가","solo_deep":"solo_deep는 [건물도장공]\n-표면을 준비한다.\n-프라이머를 바른다.\n-페인트를 혼합한다.\n-도장을 실시한다.\n-마무리를 한다.\n-품질을 검사한다.\n-안전 수칙을 준수한다.\n-장비를 관리한다.\n... 기반으로 50로 평가","analytical":"analytical는 [건물도장공]\n-표면을 준비한다.\n-프라이머를 바른다.\n-페인트를 혼합한다.\n-도장을 실시한다.\n-마무리를 한다.\n-품질을 검사한다.\n-안전 수칙을 준수한다.\n-장비를 관리한다.\n... 기반으로 40로 평가","creative":"creative는 [건물도장공]\n-표면을 준비한다.\n-프라이머를 바른다.\n-페인트를 혼합한다.\n-도장을 실시한다.\n-마무리를 한다.\n-품질을 검사한다.\n-안전 수칙을 준수한다.\n-장비를 관리한다.\n... 기반으로 40로 평가","execution":"execution는 [건물도장공]\n-표면을 준비한다.\n-프라이머를 바른다.\n-페인트를 혼합한다.\n-도장을 실시한다.\n-마무리를 한다.\n-품질을 검사한다.\n-안전 수칙을 준수한다.\n-장비를 관리한다.\n... 기반으로 70로 평가","people_facing":"people_facing는 [건물도장공]\n-표면을 준비한다.\n-프라이머를 바른다.\n-페인트를 혼합한다.\n-도장을 실시한다.\n-마무리를 한다.\n-품질을 검사한다.\n-안전 수칙을 준수한다.\n-장비를 관리한다.\n... 기반으로 50로 평가","degree_required":"degree_required는 [건물도장공]\n-표면을 준비한다.\n-프라이머를 바른다.\n-페인트를 혼합한다.\n-도장을 실시한다.\n-마무리를 한다.\n-품질을 검사한다.\n-안전 수칙을 준수한다.\n-장비를 관리한다.\n... 기반으로 none로 평가","license_required":"license_required는 [건물도장공]\n-표면을 준비한다.\n-프라이머를 바른다.\n-페인트를 혼합한다.\n-도장을 실시한다.\n-마무리를 한다.\n-품질을 검사한다.\n-안전 수칙을 준수한다.\n-장비를 관리한다.\n... 기반으로 none로 평가"}'
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
  '1765283431074364',
  '자연과학시험원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 50, 70,
  50, 50, 60, 30, 60, 35,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [자연과학시험원]\n-시료를 채취한다.\n-실험을 설계한다.\n-데이터를 수집한다.\n-분석을 실시한다.\n-결과를 해석한다.\n-보고서를 작성한다.\n-장비를 유지한다.\n-안전 수칙을 준수한... 기반으로 50로 평가","growth":"growth는 [자연과학시험원]\n-시료를 채취한다.\n-실험을 설계한다.\n-데이터를 수집한다.\n-분석을 실시한다.\n-결과를 해석한다.\n-보고서를 작성한다.\n-장비를 유지한다.\n-안전 수칙을 준수한... 기반으로 65로 평가","stability":"stability는 [자연과학시험원]\n-시료를 채취한다.\n-실험을 설계한다.\n-데이터를 수집한다.\n-분석을 실시한다.\n-결과를 해석한다.\n-보고서를 작성한다.\n-장비를 유지한다.\n-안전 수칙을 준수한... 기반으로 50로 평가","income":"income는 [자연과학시험원]\n-시료를 채취한다.\n-실험을 설계한다.\n-데이터를 수집한다.\n-분석을 실시한다.\n-결과를 해석한다.\n-보고서를 작성한다.\n-장비를 유지한다.\n-안전 수칙을 준수한... 기반으로 70로 평가","teamwork":"teamwork는 [자연과학시험원]\n-시료를 채취한다.\n-실험을 설계한다.\n-데이터를 수집한다.\n-분석을 실시한다.\n-결과를 해석한다.\n-보고서를 작성한다.\n-장비를 유지한다.\n-안전 수칙을 준수한... 기반으로 50로 평가","solo_deep":"solo_deep는 [자연과학시험원]\n-시료를 채취한다.\n-실험을 설계한다.\n-데이터를 수집한다.\n-분석을 실시한다.\n-결과를 해석한다.\n-보고서를 작성한다.\n-장비를 유지한다.\n-안전 수칙을 준수한... 기반으로 50로 평가","analytical":"analytical는 [자연과학시험원]\n-시료를 채취한다.\n-실험을 설계한다.\n-데이터를 수집한다.\n-분석을 실시한다.\n-결과를 해석한다.\n-보고서를 작성한다.\n-장비를 유지한다.\n-안전 수칙을 준수한... 기반으로 60로 평가","creative":"creative는 [자연과학시험원]\n-시료를 채취한다.\n-실험을 설계한다.\n-데이터를 수집한다.\n-분석을 실시한다.\n-결과를 해석한다.\n-보고서를 작성한다.\n-장비를 유지한다.\n-안전 수칙을 준수한... 기반으로 30로 평가","execution":"execution는 [자연과학시험원]\n-시료를 채취한다.\n-실험을 설계한다.\n-데이터를 수집한다.\n-분석을 실시한다.\n-결과를 해석한다.\n-보고서를 작성한다.\n-장비를 유지한다.\n-안전 수칙을 준수한... 기반으로 60로 평가","people_facing":"people_facing는 [자연과학시험원]\n-시료를 채취한다.\n-실험을 설계한다.\n-데이터를 수집한다.\n-분석을 실시한다.\n-결과를 해석한다.\n-보고서를 작성한다.\n-장비를 유지한다.\n-안전 수칙을 준수한... 기반으로 35로 평가","degree_required":"degree_required는 [자연과학시험원]\n-시료를 채취한다.\n-실험을 설계한다.\n-데이터를 수집한다.\n-분석을 실시한다.\n-결과를 해석한다.\n-보고서를 작성한다.\n-장비를 유지한다.\n-안전 수칙을 준수한... 기반으로 none로 평가","license_required":"license_required는 [자연과학시험원]\n-시료를 채취한다.\n-실험을 설계한다.\n-데이터를 수집한다.\n-분석을 실시한다.\n-결과를 해석한다.\n-보고서를 작성한다.\n-장비를 유지한다.\n-안전 수칙을 준수한... 기반으로 none로 평가"}'
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
  '1765283498312707',
  '미장공',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  50, 50, 30, 60, 60, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [미장공]\n-벽면을 준비한다.\n-모르타르를 혼합한다.\n-미장을 한다.\n-표면을 평탄화한다.\n-마무리를 한다.\n-크랙을 보수한다.\n-안전 수칙을 준수한다.\n-도구를 관리한다.\n-품질... 기반으로 50로 평가","growth":"growth는 [미장공]\n-벽면을 준비한다.\n-모르타르를 혼합한다.\n-미장을 한다.\n-표면을 평탄화한다.\n-마무리를 한다.\n-크랙을 보수한다.\n-안전 수칙을 준수한다.\n-도구를 관리한다.\n-품질... 기반으로 50로 평가","stability":"stability는 [미장공]\n-벽면을 준비한다.\n-모르타르를 혼합한다.\n-미장을 한다.\n-표면을 평탄화한다.\n-마무리를 한다.\n-크랙을 보수한다.\n-안전 수칙을 준수한다.\n-도구를 관리한다.\n-품질... 기반으로 50로 평가","income":"income는 [미장공]\n-벽면을 준비한다.\n-모르타르를 혼합한다.\n-미장을 한다.\n-표면을 평탄화한다.\n-마무리를 한다.\n-크랙을 보수한다.\n-안전 수칙을 준수한다.\n-도구를 관리한다.\n-품질... 기반으로 50로 평가","teamwork":"teamwork는 [미장공]\n-벽면을 준비한다.\n-모르타르를 혼합한다.\n-미장을 한다.\n-표면을 평탄화한다.\n-마무리를 한다.\n-크랙을 보수한다.\n-안전 수칙을 준수한다.\n-도구를 관리한다.\n-품질... 기반으로 50로 평가","solo_deep":"solo_deep는 [미장공]\n-벽면을 준비한다.\n-모르타르를 혼합한다.\n-미장을 한다.\n-표면을 평탄화한다.\n-마무리를 한다.\n-크랙을 보수한다.\n-안전 수칙을 준수한다.\n-도구를 관리한다.\n-품질... 기반으로 50로 평가","analytical":"analytical는 [미장공]\n-벽면을 준비한다.\n-모르타르를 혼합한다.\n-미장을 한다.\n-표면을 평탄화한다.\n-마무리를 한다.\n-크랙을 보수한다.\n-안전 수칙을 준수한다.\n-도구를 관리한다.\n-품질... 기반으로 30로 평가","creative":"creative는 [미장공]\n-벽면을 준비한다.\n-모르타르를 혼합한다.\n-미장을 한다.\n-표면을 평탄화한다.\n-마무리를 한다.\n-크랙을 보수한다.\n-안전 수칙을 준수한다.\n-도구를 관리한다.\n-품질... 기반으로 60로 평가","execution":"execution는 [미장공]\n-벽면을 준비한다.\n-모르타르를 혼합한다.\n-미장을 한다.\n-표면을 평탄화한다.\n-마무리를 한다.\n-크랙을 보수한다.\n-안전 수칙을 준수한다.\n-도구를 관리한다.\n-품질... 기반으로 60로 평가","people_facing":"people_facing는 [미장공]\n-벽면을 준비한다.\n-모르타르를 혼합한다.\n-미장을 한다.\n-표면을 평탄화한다.\n-마무리를 한다.\n-크랙을 보수한다.\n-안전 수칙을 준수한다.\n-도구를 관리한다.\n-품질... 기반으로 50로 평가","degree_required":"degree_required는 [미장공]\n-벽면을 준비한다.\n-모르타르를 혼합한다.\n-미장을 한다.\n-표면을 평탄화한다.\n-마무리를 한다.\n-크랙을 보수한다.\n-안전 수칙을 준수한다.\n-도구를 관리한다.\n-품질... 기반으로 none로 평가","license_required":"license_required는 [미장공]\n-벽면을 준비한다.\n-모르타르를 혼합한다.\n-미장을 한다.\n-표면을 평탄화한다.\n-마무리를 한다.\n-크랙을 보수한다.\n-안전 수칙을 준수한다.\n-도구를 관리한다.\n-품질... 기반으로 none로 평가"}'
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
  '1765283432182558',
  '생명과학시험원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 50, 70,
  50, 50, 60, 30, 60, 35,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [생명과학시험원]\n-생물 시료를 채취한다.\n-실험을 설계한다.\n-데이터를 수집한다.\n-분석을 실시한다.\n-결과를 해석한다.\n-보고서를 작성한다.\n-장비를 유지한다.\n-안전 수칙을 ... 기반으로 50로 평가","growth":"growth는 [생명과학시험원]\n-생물 시료를 채취한다.\n-실험을 설계한다.\n-데이터를 수집한다.\n-분석을 실시한다.\n-결과를 해석한다.\n-보고서를 작성한다.\n-장비를 유지한다.\n-안전 수칙을 ... 기반으로 65로 평가","stability":"stability는 [생명과학시험원]\n-생물 시료를 채취한다.\n-실험을 설계한다.\n-데이터를 수집한다.\n-분석을 실시한다.\n-결과를 해석한다.\n-보고서를 작성한다.\n-장비를 유지한다.\n-안전 수칙을 ... 기반으로 50로 평가","income":"income는 [생명과학시험원]\n-생물 시료를 채취한다.\n-실험을 설계한다.\n-데이터를 수집한다.\n-분석을 실시한다.\n-결과를 해석한다.\n-보고서를 작성한다.\n-장비를 유지한다.\n-안전 수칙을 ... 기반으로 70로 평가","teamwork":"teamwork는 [생명과학시험원]\n-생물 시료를 채취한다.\n-실험을 설계한다.\n-데이터를 수집한다.\n-분석을 실시한다.\n-결과를 해석한다.\n-보고서를 작성한다.\n-장비를 유지한다.\n-안전 수칙을 ... 기반으로 50로 평가","solo_deep":"solo_deep는 [생명과학시험원]\n-생물 시료를 채취한다.\n-실험을 설계한다.\n-데이터를 수집한다.\n-분석을 실시한다.\n-결과를 해석한다.\n-보고서를 작성한다.\n-장비를 유지한다.\n-안전 수칙을 ... 기반으로 50로 평가","analytical":"analytical는 [생명과학시험원]\n-생물 시료를 채취한다.\n-실험을 설계한다.\n-데이터를 수집한다.\n-분석을 실시한다.\n-결과를 해석한다.\n-보고서를 작성한다.\n-장비를 유지한다.\n-안전 수칙을 ... 기반으로 60로 평가","creative":"creative는 [생명과학시험원]\n-생물 시료를 채취한다.\n-실험을 설계한다.\n-데이터를 수집한다.\n-분석을 실시한다.\n-결과를 해석한다.\n-보고서를 작성한다.\n-장비를 유지한다.\n-안전 수칙을 ... 기반으로 30로 평가","execution":"execution는 [생명과학시험원]\n-생물 시료를 채취한다.\n-실험을 설계한다.\n-데이터를 수집한다.\n-분석을 실시한다.\n-결과를 해석한다.\n-보고서를 작성한다.\n-장비를 유지한다.\n-안전 수칙을 ... 기반으로 60로 평가","people_facing":"people_facing는 [생명과학시험원]\n-생물 시료를 채취한다.\n-실험을 설계한다.\n-데이터를 수집한다.\n-분석을 실시한다.\n-결과를 해석한다.\n-보고서를 작성한다.\n-장비를 유지한다.\n-안전 수칙을 ... 기반으로 35로 평가","degree_required":"degree_required는 [생명과학시험원]\n-생물 시료를 채취한다.\n-실험을 설계한다.\n-데이터를 수집한다.\n-분석을 실시한다.\n-결과를 해석한다.\n-보고서를 작성한다.\n-장비를 유지한다.\n-안전 수칙을 ... 기반으로 none로 평가","license_required":"license_required는 [생명과학시험원]\n-생물 시료를 채취한다.\n-실험을 설계한다.\n-데이터를 수집한다.\n-분석을 실시한다.\n-결과를 해석한다.\n-보고서를 작성한다.\n-장비를 유지한다.\n-안전 수칙을 ... 기반으로 none로 평가"}'
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
  '1765283468738131',
  '학예사',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 75, 50, 50,
  50, 50, 50, 50, 50, 60,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [학예사]\n-박물관 자료를 수집한다.\n-전시를 기획한다.\n-자료를 보존한다.\n-교육 프로그램을 개발한다.\n-관람객을 안내한다.\n-연구를 수행한다.\n-자료를 관리한다.\n-보존 방법을... 기반으로 50로 평가","growth":"growth는 [학예사]\n-박물관 자료를 수집한다.\n-전시를 기획한다.\n-자료를 보존한다.\n-교육 프로그램을 개발한다.\n-관람객을 안내한다.\n-연구를 수행한다.\n-자료를 관리한다.\n-보존 방법을... 기반으로 75로 평가","stability":"stability는 [학예사]\n-박물관 자료를 수집한다.\n-전시를 기획한다.\n-자료를 보존한다.\n-교육 프로그램을 개발한다.\n-관람객을 안내한다.\n-연구를 수행한다.\n-자료를 관리한다.\n-보존 방법을... 기반으로 50로 평가","income":"income는 [학예사]\n-박물관 자료를 수집한다.\n-전시를 기획한다.\n-자료를 보존한다.\n-교육 프로그램을 개발한다.\n-관람객을 안내한다.\n-연구를 수행한다.\n-자료를 관리한다.\n-보존 방법을... 기반으로 50로 평가","teamwork":"teamwork는 [학예사]\n-박물관 자료를 수집한다.\n-전시를 기획한다.\n-자료를 보존한다.\n-교육 프로그램을 개발한다.\n-관람객을 안내한다.\n-연구를 수행한다.\n-자료를 관리한다.\n-보존 방법을... 기반으로 50로 평가","solo_deep":"solo_deep는 [학예사]\n-박물관 자료를 수집한다.\n-전시를 기획한다.\n-자료를 보존한다.\n-교육 프로그램을 개발한다.\n-관람객을 안내한다.\n-연구를 수행한다.\n-자료를 관리한다.\n-보존 방법을... 기반으로 50로 평가","analytical":"analytical는 [학예사]\n-박물관 자료를 수집한다.\n-전시를 기획한다.\n-자료를 보존한다.\n-교육 프로그램을 개발한다.\n-관람객을 안내한다.\n-연구를 수행한다.\n-자료를 관리한다.\n-보존 방법을... 기반으로 50로 평가","creative":"creative는 [학예사]\n-박물관 자료를 수집한다.\n-전시를 기획한다.\n-자료를 보존한다.\n-교육 프로그램을 개발한다.\n-관람객을 안내한다.\n-연구를 수행한다.\n-자료를 관리한다.\n-보존 방법을... 기반으로 50로 평가","execution":"execution는 [학예사]\n-박물관 자료를 수집한다.\n-전시를 기획한다.\n-자료를 보존한다.\n-교육 프로그램을 개발한다.\n-관람객을 안내한다.\n-연구를 수행한다.\n-자료를 관리한다.\n-보존 방법을... 기반으로 50로 평가","people_facing":"people_facing는 [학예사]\n-박물관 자료를 수집한다.\n-전시를 기획한다.\n-자료를 보존한다.\n-교육 프로그램을 개발한다.\n-관람객을 안내한다.\n-연구를 수행한다.\n-자료를 관리한다.\n-보존 방법을... 기반으로 60로 평가","degree_required":"degree_required는 [학예사]\n-박물관 자료를 수집한다.\n-전시를 기획한다.\n-자료를 보존한다.\n-교육 프로그램을 개발한다.\n-관람객을 안내한다.\n-연구를 수행한다.\n-자료를 관리한다.\n-보존 방법을... 기반으로 none로 평가","license_required":"license_required는 [학예사]\n-박물관 자료를 수집한다.\n-전시를 기획한다.\n-자료를 보존한다.\n-교육 프로그램을 개발한다.\n-관람객을 안내한다.\n-연구를 수행한다.\n-자료를 관리한다.\n-보존 방법을... 기반으로 none로 평가"}'
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
  '1765283448989966',
  '전기안전기술자',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 60, 50, 50,
  50, 50, 40, 40, 70, 50,
  'regular', 'none', 'none', 'none',
  'bachelor', 'preferred', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [전기안전기술자]\n-전기 설비를 점검한다.\n-안전 기준을 확인한다.\n-문제를 진단한다.\n-보수 계획을 수립한다.\n-수리를 실시한다.\n-안전 조치를 취한다.\n-보고서를 작성한다.\n-... 기반으로 50로 평가","growth":"growth는 [전기안전기술자]\n-전기 설비를 점검한다.\n-안전 기준을 확인한다.\n-문제를 진단한다.\n-보수 계획을 수립한다.\n-수리를 실시한다.\n-안전 조치를 취한다.\n-보고서를 작성한다.\n-... 기반으로 60로 평가","stability":"stability는 [전기안전기술자]\n-전기 설비를 점검한다.\n-안전 기준을 확인한다.\n-문제를 진단한다.\n-보수 계획을 수립한다.\n-수리를 실시한다.\n-안전 조치를 취한다.\n-보고서를 작성한다.\n-... 기반으로 50로 평가","income":"income는 [전기안전기술자]\n-전기 설비를 점검한다.\n-안전 기준을 확인한다.\n-문제를 진단한다.\n-보수 계획을 수립한다.\n-수리를 실시한다.\n-안전 조치를 취한다.\n-보고서를 작성한다.\n-... 기반으로 50로 평가","teamwork":"teamwork는 [전기안전기술자]\n-전기 설비를 점검한다.\n-안전 기준을 확인한다.\n-문제를 진단한다.\n-보수 계획을 수립한다.\n-수리를 실시한다.\n-안전 조치를 취한다.\n-보고서를 작성한다.\n-... 기반으로 50로 평가","solo_deep":"solo_deep는 [전기안전기술자]\n-전기 설비를 점검한다.\n-안전 기준을 확인한다.\n-문제를 진단한다.\n-보수 계획을 수립한다.\n-수리를 실시한다.\n-안전 조치를 취한다.\n-보고서를 작성한다.\n-... 기반으로 50로 평가","analytical":"analytical는 [전기안전기술자]\n-전기 설비를 점검한다.\n-안전 기준을 확인한다.\n-문제를 진단한다.\n-보수 계획을 수립한다.\n-수리를 실시한다.\n-안전 조치를 취한다.\n-보고서를 작성한다.\n-... 기반으로 40로 평가","creative":"creative는 [전기안전기술자]\n-전기 설비를 점검한다.\n-안전 기준을 확인한다.\n-문제를 진단한다.\n-보수 계획을 수립한다.\n-수리를 실시한다.\n-안전 조치를 취한다.\n-보고서를 작성한다.\n-... 기반으로 40로 평가","execution":"execution는 [전기안전기술자]\n-전기 설비를 점검한다.\n-안전 기준을 확인한다.\n-문제를 진단한다.\n-보수 계획을 수립한다.\n-수리를 실시한다.\n-안전 조치를 취한다.\n-보고서를 작성한다.\n-... 기반으로 70로 평가","people_facing":"people_facing는 [전기안전기술자]\n-전기 설비를 점검한다.\n-안전 기준을 확인한다.\n-문제를 진단한다.\n-보수 계획을 수립한다.\n-수리를 실시한다.\n-안전 조치를 취한다.\n-보고서를 작성한다.\n-... 기반으로 50로 평가","degree_required":"degree_required는 [전기안전기술자]\n-전기 설비를 점검한다.\n-안전 기준을 확인한다.\n-문제를 진단한다.\n-보수 계획을 수립한다.\n-수리를 실시한다.\n-안전 조치를 취한다.\n-보고서를 작성한다.\n-... 기반으로 bachelor로 평가","license_required":"license_required는 [전기안전기술자]\n-전기 설비를 점검한다.\n-안전 기준을 확인한다.\n-문제를 진단한다.\n-보수 계획을 수립한다.\n-수리를 실시한다.\n-안전 조치를 취한다.\n-보고서를 작성한다.\n-... 기반으로 preferred로 평가"}'
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