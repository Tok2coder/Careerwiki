-- Batch tagging SQL generated at 2026-01-06T07:19:53.738Z
-- Tagger version: tagger-v1.0.0
-- Total jobs: 3

BEGIN TRANSACTION;


INSERT INTO job_attributes (
  job_id, job_name, source_system, tagger_version, status,
  wlb, growth, stability, income,
  teamwork, solo_deep, analytical, creative, execution, people_facing,
  work_hours, shift_work, travel, remote_possible,
  degree_required, license_required, experience_required,
  _confidence, _field_confidence_json, evidence_json
) VALUES (
  '1765283479636612',
  '음료조리사',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 50, 50,
  50, 50, 30, 60, 60, 60,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [음료조리사]\n-음료를 준비한다.\n-재료를 혼합한다.\n-맛을 조절한다.\n-포장을 한다.\n-위생을 유지한다.\n-재고를 관리한다.\n-고객을 응대한다.\n-메뉴를 개발한다.\n-장비를 청소... 기반으로 50로 평가","growth":"growth는 [음료조리사]\n-음료를 준비한다.\n-재료를 혼합한다.\n-맛을 조절한다.\n-포장을 한다.\n-위생을 유지한다.\n-재고를 관리한다.\n-고객을 응대한다.\n-메뉴를 개발한다.\n-장비를 청소... 기반으로 65로 평가","stability":"stability는 [음료조리사]\n-음료를 준비한다.\n-재료를 혼합한다.\n-맛을 조절한다.\n-포장을 한다.\n-위생을 유지한다.\n-재고를 관리한다.\n-고객을 응대한다.\n-메뉴를 개발한다.\n-장비를 청소... 기반으로 50로 평가","income":"income는 [음료조리사]\n-음료를 준비한다.\n-재료를 혼합한다.\n-맛을 조절한다.\n-포장을 한다.\n-위생을 유지한다.\n-재고를 관리한다.\n-고객을 응대한다.\n-메뉴를 개발한다.\n-장비를 청소... 기반으로 50로 평가","teamwork":"teamwork는 [음료조리사]\n-음료를 준비한다.\n-재료를 혼합한다.\n-맛을 조절한다.\n-포장을 한다.\n-위생을 유지한다.\n-재고를 관리한다.\n-고객을 응대한다.\n-메뉴를 개발한다.\n-장비를 청소... 기반으로 50로 평가","solo_deep":"solo_deep는 [음료조리사]\n-음료를 준비한다.\n-재료를 혼합한다.\n-맛을 조절한다.\n-포장을 한다.\n-위생을 유지한다.\n-재고를 관리한다.\n-고객을 응대한다.\n-메뉴를 개발한다.\n-장비를 청소... 기반으로 50로 평가","analytical":"analytical는 [음료조리사]\n-음료를 준비한다.\n-재료를 혼합한다.\n-맛을 조절한다.\n-포장을 한다.\n-위생을 유지한다.\n-재고를 관리한다.\n-고객을 응대한다.\n-메뉴를 개발한다.\n-장비를 청소... 기반으로 30로 평가","creative":"creative는 [음료조리사]\n-음료를 준비한다.\n-재료를 혼합한다.\n-맛을 조절한다.\n-포장을 한다.\n-위생을 유지한다.\n-재고를 관리한다.\n-고객을 응대한다.\n-메뉴를 개발한다.\n-장비를 청소... 기반으로 60로 평가","execution":"execution는 [음료조리사]\n-음료를 준비한다.\n-재료를 혼합한다.\n-맛을 조절한다.\n-포장을 한다.\n-위생을 유지한다.\n-재고를 관리한다.\n-고객을 응대한다.\n-메뉴를 개발한다.\n-장비를 청소... 기반으로 60로 평가","people_facing":"people_facing는 [음료조리사]\n-음료를 준비한다.\n-재료를 혼합한다.\n-맛을 조절한다.\n-포장을 한다.\n-위생을 유지한다.\n-재고를 관리한다.\n-고객을 응대한다.\n-메뉴를 개발한다.\n-장비를 청소... 기반으로 60로 평가","degree_required":"degree_required는 [음료조리사]\n-음료를 준비한다.\n-재료를 혼합한다.\n-맛을 조절한다.\n-포장을 한다.\n-위생을 유지한다.\n-재고를 관리한다.\n-고객을 응대한다.\n-메뉴를 개발한다.\n-장비를 청소... 기반으로 none로 평가","license_required":"license_required는 [음료조리사]\n-음료를 준비한다.\n-재료를 혼합한다.\n-맛을 조절한다.\n-포장을 한다.\n-위생을 유지한다.\n-재고를 관리한다.\n-고객을 응대한다.\n-메뉴를 개발한다.\n-장비를 청소... 기반으로 none로 평가"}'
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
  '176528348457070',
  '환경미화원 및 재활용품수거원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 60, 50, 50,
  50, 50, 40, 40, 70, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [환경미화원]\n-쓰레기를 수거한다.\n-청소를 실시한다.\n-시설을 유지한다.\n-장비를 사용한다.\n-안전을 준수한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-환경을 보호한다.\n\n[... 기반으로 50로 평가","growth":"growth는 [환경미화원]\n-쓰레기를 수거한다.\n-청소를 실시한다.\n-시설을 유지한다.\n-장비를 사용한다.\n-안전을 준수한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-환경을 보호한다.\n\n[... 기반으로 60로 평가","stability":"stability는 [환경미화원]\n-쓰레기를 수거한다.\n-청소를 실시한다.\n-시설을 유지한다.\n-장비를 사용한다.\n-안전을 준수한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-환경을 보호한다.\n\n[... 기반으로 50로 평가","income":"income는 [환경미화원]\n-쓰레기를 수거한다.\n-청소를 실시한다.\n-시설을 유지한다.\n-장비를 사용한다.\n-안전을 준수한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-환경을 보호한다.\n\n[... 기반으로 50로 평가","teamwork":"teamwork는 [환경미화원]\n-쓰레기를 수거한다.\n-청소를 실시한다.\n-시설을 유지한다.\n-장비를 사용한다.\n-안전을 준수한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-환경을 보호한다.\n\n[... 기반으로 50로 평가","solo_deep":"solo_deep는 [환경미화원]\n-쓰레기를 수거한다.\n-청소를 실시한다.\n-시설을 유지한다.\n-장비를 사용한다.\n-안전을 준수한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-환경을 보호한다.\n\n[... 기반으로 50로 평가","analytical":"analytical는 [환경미화원]\n-쓰레기를 수거한다.\n-청소를 실시한다.\n-시설을 유지한다.\n-장비를 사용한다.\n-안전을 준수한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-환경을 보호한다.\n\n[... 기반으로 40로 평가","creative":"creative는 [환경미화원]\n-쓰레기를 수거한다.\n-청소를 실시한다.\n-시설을 유지한다.\n-장비를 사용한다.\n-안전을 준수한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-환경을 보호한다.\n\n[... 기반으로 40로 평가","execution":"execution는 [환경미화원]\n-쓰레기를 수거한다.\n-청소를 실시한다.\n-시설을 유지한다.\n-장비를 사용한다.\n-안전을 준수한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-환경을 보호한다.\n\n[... 기반으로 70로 평가","people_facing":"people_facing는 [환경미화원]\n-쓰레기를 수거한다.\n-청소를 실시한다.\n-시설을 유지한다.\n-장비를 사용한다.\n-안전을 준수한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-환경을 보호한다.\n\n[... 기반으로 50로 평가","degree_required":"degree_required는 [환경미화원]\n-쓰레기를 수거한다.\n-청소를 실시한다.\n-시설을 유지한다.\n-장비를 사용한다.\n-안전을 준수한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-환경을 보호한다.\n\n[... 기반으로 none로 평가","license_required":"license_required는 [환경미화원]\n-쓰레기를 수거한다.\n-청소를 실시한다.\n-시설을 유지한다.\n-장비를 사용한다.\n-안전을 준수한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-환경을 보호한다.\n\n[... 기반으로 none로 평가"}'
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
  '1765283486347749',
  '검표원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  50, 50, 40, 40, 70, 75,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [검표원]\n-티켓을 확인한다.\n-승객을 통제한다.\n-기록을 관리한다.\n-안전을 유지한다.\n-고객을 안내한다.\n-문제를 해결한다.\n-보고서를 작성한다.\n-시스템을 운영한다.\n-법규를... 기반으로 50로 평가","growth":"growth는 [검표원]\n-티켓을 확인한다.\n-승객을 통제한다.\n-기록을 관리한다.\n-안전을 유지한다.\n-고객을 안내한다.\n-문제를 해결한다.\n-보고서를 작성한다.\n-시스템을 운영한다.\n-법규를... 기반으로 50로 평가","stability":"stability는 [검표원]\n-티켓을 확인한다.\n-승객을 통제한다.\n-기록을 관리한다.\n-안전을 유지한다.\n-고객을 안내한다.\n-문제를 해결한다.\n-보고서를 작성한다.\n-시스템을 운영한다.\n-법규를... 기반으로 50로 평가","income":"income는 [검표원]\n-티켓을 확인한다.\n-승객을 통제한다.\n-기록을 관리한다.\n-안전을 유지한다.\n-고객을 안내한다.\n-문제를 해결한다.\n-보고서를 작성한다.\n-시스템을 운영한다.\n-법규를... 기반으로 50로 평가","teamwork":"teamwork는 [검표원]\n-티켓을 확인한다.\n-승객을 통제한다.\n-기록을 관리한다.\n-안전을 유지한다.\n-고객을 안내한다.\n-문제를 해결한다.\n-보고서를 작성한다.\n-시스템을 운영한다.\n-법규를... 기반으로 50로 평가","solo_deep":"solo_deep는 [검표원]\n-티켓을 확인한다.\n-승객을 통제한다.\n-기록을 관리한다.\n-안전을 유지한다.\n-고객을 안내한다.\n-문제를 해결한다.\n-보고서를 작성한다.\n-시스템을 운영한다.\n-법규를... 기반으로 50로 평가","analytical":"analytical는 [검표원]\n-티켓을 확인한다.\n-승객을 통제한다.\n-기록을 관리한다.\n-안전을 유지한다.\n-고객을 안내한다.\n-문제를 해결한다.\n-보고서를 작성한다.\n-시스템을 운영한다.\n-법규를... 기반으로 40로 평가","creative":"creative는 [검표원]\n-티켓을 확인한다.\n-승객을 통제한다.\n-기록을 관리한다.\n-안전을 유지한다.\n-고객을 안내한다.\n-문제를 해결한다.\n-보고서를 작성한다.\n-시스템을 운영한다.\n-법규를... 기반으로 40로 평가","execution":"execution는 [검표원]\n-티켓을 확인한다.\n-승객을 통제한다.\n-기록을 관리한다.\n-안전을 유지한다.\n-고객을 안내한다.\n-문제를 해결한다.\n-보고서를 작성한다.\n-시스템을 운영한다.\n-법규를... 기반으로 70로 평가","people_facing":"people_facing는 [검표원]\n-티켓을 확인한다.\n-승객을 통제한다.\n-기록을 관리한다.\n-안전을 유지한다.\n-고객을 안내한다.\n-문제를 해결한다.\n-보고서를 작성한다.\n-시스템을 운영한다.\n-법규를... 기반으로 75로 평가","degree_required":"degree_required는 [검표원]\n-티켓을 확인한다.\n-승객을 통제한다.\n-기록을 관리한다.\n-안전을 유지한다.\n-고객을 안내한다.\n-문제를 해결한다.\n-보고서를 작성한다.\n-시스템을 운영한다.\n-법규를... 기반으로 none로 평가","license_required":"license_required는 [검표원]\n-티켓을 확인한다.\n-승객을 통제한다.\n-기록을 관리한다.\n-안전을 유지한다.\n-고객을 안내한다.\n-문제를 해결한다.\n-보고서를 작성한다.\n-시스템을 운영한다.\n-법규를... 기반으로 none로 평가"}'
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