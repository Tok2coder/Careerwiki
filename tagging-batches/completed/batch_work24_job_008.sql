-- Batch tagging SQL generated at 2026-01-06T07:02:52.984Z
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
  '1765283418586250',
  '감사사무원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 70, 50,
  50, 50, 60, 30, 60, 35,
  'regular', 'none', 'none', 'partial',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [감사사무원]\n-감사 계획을 수립한다.\n-재무 서류를 검토한다.\n-내부 통제를 평가한다.\n-리스크를 식별한다.\n-감사 증거를 수집한다.\n-보고서를 작성한다.\n-문제를 발견하고 해결... 기반으로 50로 평가","growth":"growth는 [감사사무원]\n-감사 계획을 수립한다.\n-재무 서류를 검토한다.\n-내부 통제를 평가한다.\n-리스크를 식별한다.\n-감사 증거를 수집한다.\n-보고서를 작성한다.\n-문제를 발견하고 해결... 기반으로 50로 평가","stability":"stability는 [감사사무원]\n-감사 계획을 수립한다.\n-재무 서류를 검토한다.\n-내부 통제를 평가한다.\n-리스크를 식별한다.\n-감사 증거를 수집한다.\n-보고서를 작성한다.\n-문제를 발견하고 해결... 기반으로 70로 평가","income":"income는 [감사사무원]\n-감사 계획을 수립한다.\n-재무 서류를 검토한다.\n-내부 통제를 평가한다.\n-리스크를 식별한다.\n-감사 증거를 수집한다.\n-보고서를 작성한다.\n-문제를 발견하고 해결... 기반으로 50로 평가","teamwork":"teamwork는 [감사사무원]\n-감사 계획을 수립한다.\n-재무 서류를 검토한다.\n-내부 통제를 평가한다.\n-리스크를 식별한다.\n-감사 증거를 수집한다.\n-보고서를 작성한다.\n-문제를 발견하고 해결... 기반으로 50로 평가","solo_deep":"solo_deep는 [감사사무원]\n-감사 계획을 수립한다.\n-재무 서류를 검토한다.\n-내부 통제를 평가한다.\n-리스크를 식별한다.\n-감사 증거를 수집한다.\n-보고서를 작성한다.\n-문제를 발견하고 해결... 기반으로 50로 평가","analytical":"analytical는 [감사사무원]\n-감사 계획을 수립한다.\n-재무 서류를 검토한다.\n-내부 통제를 평가한다.\n-리스크를 식별한다.\n-감사 증거를 수집한다.\n-보고서를 작성한다.\n-문제를 발견하고 해결... 기반으로 60로 평가","creative":"creative는 [감사사무원]\n-감사 계획을 수립한다.\n-재무 서류를 검토한다.\n-내부 통제를 평가한다.\n-리스크를 식별한다.\n-감사 증거를 수집한다.\n-보고서를 작성한다.\n-문제를 발견하고 해결... 기반으로 30로 평가","execution":"execution는 [감사사무원]\n-감사 계획을 수립한다.\n-재무 서류를 검토한다.\n-내부 통제를 평가한다.\n-리스크를 식별한다.\n-감사 증거를 수집한다.\n-보고서를 작성한다.\n-문제를 발견하고 해결... 기반으로 60로 평가","people_facing":"people_facing는 [감사사무원]\n-감사 계획을 수립한다.\n-재무 서류를 검토한다.\n-내부 통제를 평가한다.\n-리스크를 식별한다.\n-감사 증거를 수집한다.\n-보고서를 작성한다.\n-문제를 발견하고 해결... 기반으로 35로 평가","degree_required":"degree_required는 [감사사무원]\n-감사 계획을 수립한다.\n-재무 서류를 검토한다.\n-내부 통제를 평가한다.\n-리스크를 식별한다.\n-감사 증거를 수집한다.\n-보고서를 작성한다.\n-문제를 발견하고 해결... 기반으로 none로 평가","license_required":"license_required는 [감사사무원]\n-감사 계획을 수립한다.\n-재무 서류를 검토한다.\n-내부 통제를 평가한다.\n-리스크를 식별한다.\n-감사 증거를 수집한다.\n-보고서를 작성한다.\n-문제를 발견하고 해결... 기반으로 none로 평가"}'
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
  '1765283413781188',
  '인적자원전문가',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 75, 70, 50,
  70, 30, 30, 60, 60, 35,
  'regular', 'none', 'none', 'partial',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [인사관리자]\n-인사 정책을 수립한다.\n-채용 계획을 개발한다.\n-인재를 발굴한다.\n-교육 프로그램을 기획한다.\n-성과 관리를 한다.\n-보상 체계를 설계한다.\n-노무 문제를 처리한... 기반으로 50로 평가","growth":"growth는 [인사관리자]\n-인사 정책을 수립한다.\n-채용 계획을 개발한다.\n-인재를 발굴한다.\n-교육 프로그램을 기획한다.\n-성과 관리를 한다.\n-보상 체계를 설계한다.\n-노무 문제를 처리한... 기반으로 75로 평가","stability":"stability는 [인사관리자]\n-인사 정책을 수립한다.\n-채용 계획을 개발한다.\n-인재를 발굴한다.\n-교육 프로그램을 기획한다.\n-성과 관리를 한다.\n-보상 체계를 설계한다.\n-노무 문제를 처리한... 기반으로 70로 평가","income":"income는 [인사관리자]\n-인사 정책을 수립한다.\n-채용 계획을 개발한다.\n-인재를 발굴한다.\n-교육 프로그램을 기획한다.\n-성과 관리를 한다.\n-보상 체계를 설계한다.\n-노무 문제를 처리한... 기반으로 50로 평가","teamwork":"teamwork는 [인사관리자]\n-인사 정책을 수립한다.\n-채용 계획을 개발한다.\n-인재를 발굴한다.\n-교육 프로그램을 기획한다.\n-성과 관리를 한다.\n-보상 체계를 설계한다.\n-노무 문제를 처리한... 기반으로 70로 평가","solo_deep":"solo_deep는 [인사관리자]\n-인사 정책을 수립한다.\n-채용 계획을 개발한다.\n-인재를 발굴한다.\n-교육 프로그램을 기획한다.\n-성과 관리를 한다.\n-보상 체계를 설계한다.\n-노무 문제를 처리한... 기반으로 30로 평가","analytical":"analytical는 [인사관리자]\n-인사 정책을 수립한다.\n-채용 계획을 개발한다.\n-인재를 발굴한다.\n-교육 프로그램을 기획한다.\n-성과 관리를 한다.\n-보상 체계를 설계한다.\n-노무 문제를 처리한... 기반으로 30로 평가","creative":"creative는 [인사관리자]\n-인사 정책을 수립한다.\n-채용 계획을 개발한다.\n-인재를 발굴한다.\n-교육 프로그램을 기획한다.\n-성과 관리를 한다.\n-보상 체계를 설계한다.\n-노무 문제를 처리한... 기반으로 60로 평가","execution":"execution는 [인사관리자]\n-인사 정책을 수립한다.\n-채용 계획을 개발한다.\n-인재를 발굴한다.\n-교육 프로그램을 기획한다.\n-성과 관리를 한다.\n-보상 체계를 설계한다.\n-노무 문제를 처리한... 기반으로 60로 평가","people_facing":"people_facing는 [인사관리자]\n-인사 정책을 수립한다.\n-채용 계획을 개발한다.\n-인재를 발굴한다.\n-교육 프로그램을 기획한다.\n-성과 관리를 한다.\n-보상 체계를 설계한다.\n-노무 문제를 처리한... 기반으로 35로 평가","degree_required":"degree_required는 [인사관리자]\n-인사 정책을 수립한다.\n-채용 계획을 개발한다.\n-인재를 발굴한다.\n-교육 프로그램을 기획한다.\n-성과 관리를 한다.\n-보상 체계를 설계한다.\n-노무 문제를 처리한... 기반으로 none로 평가","license_required":"license_required는 [인사관리자]\n-인사 정책을 수립한다.\n-채용 계획을 개발한다.\n-인재를 발굴한다.\n-교육 프로그램을 기획한다.\n-성과 관리를 한다.\n-보상 체계를 설계한다.\n-노무 문제를 처리한... 기반으로 none로 평가"}'
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
  '1765283497645927',
  '방수공',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  50, 50, 40, 40, 70, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [방수공]\n-표면을 준비한다.\n-방수제를 선택한다.\n-프라이머를 바른다.\n-방수층을 시공한다.\n-마무리를 한다.\n-품질을 검사한다.\n-누수 여부를 확인한다.\n-수리를 한다.\n-안전... 기반으로 50로 평가","growth":"growth는 [방수공]\n-표면을 준비한다.\n-방수제를 선택한다.\n-프라이머를 바른다.\n-방수층을 시공한다.\n-마무리를 한다.\n-품질을 검사한다.\n-누수 여부를 확인한다.\n-수리를 한다.\n-안전... 기반으로 50로 평가","stability":"stability는 [방수공]\n-표면을 준비한다.\n-방수제를 선택한다.\n-프라이머를 바른다.\n-방수층을 시공한다.\n-마무리를 한다.\n-품질을 검사한다.\n-누수 여부를 확인한다.\n-수리를 한다.\n-안전... 기반으로 50로 평가","income":"income는 [방수공]\n-표면을 준비한다.\n-방수제를 선택한다.\n-프라이머를 바른다.\n-방수층을 시공한다.\n-마무리를 한다.\n-품질을 검사한다.\n-누수 여부를 확인한다.\n-수리를 한다.\n-안전... 기반으로 50로 평가","teamwork":"teamwork는 [방수공]\n-표면을 준비한다.\n-방수제를 선택한다.\n-프라이머를 바른다.\n-방수층을 시공한다.\n-마무리를 한다.\n-품질을 검사한다.\n-누수 여부를 확인한다.\n-수리를 한다.\n-안전... 기반으로 50로 평가","solo_deep":"solo_deep는 [방수공]\n-표면을 준비한다.\n-방수제를 선택한다.\n-프라이머를 바른다.\n-방수층을 시공한다.\n-마무리를 한다.\n-품질을 검사한다.\n-누수 여부를 확인한다.\n-수리를 한다.\n-안전... 기반으로 50로 평가","analytical":"analytical는 [방수공]\n-표면을 준비한다.\n-방수제를 선택한다.\n-프라이머를 바른다.\n-방수층을 시공한다.\n-마무리를 한다.\n-품질을 검사한다.\n-누수 여부를 확인한다.\n-수리를 한다.\n-안전... 기반으로 40로 평가","creative":"creative는 [방수공]\n-표면을 준비한다.\n-방수제를 선택한다.\n-프라이머를 바른다.\n-방수층을 시공한다.\n-마무리를 한다.\n-품질을 검사한다.\n-누수 여부를 확인한다.\n-수리를 한다.\n-안전... 기반으로 40로 평가","execution":"execution는 [방수공]\n-표면을 준비한다.\n-방수제를 선택한다.\n-프라이머를 바른다.\n-방수층을 시공한다.\n-마무리를 한다.\n-품질을 검사한다.\n-누수 여부를 확인한다.\n-수리를 한다.\n-안전... 기반으로 70로 평가","people_facing":"people_facing는 [방수공]\n-표면을 준비한다.\n-방수제를 선택한다.\n-프라이머를 바른다.\n-방수층을 시공한다.\n-마무리를 한다.\n-품질을 검사한다.\n-누수 여부를 확인한다.\n-수리를 한다.\n-안전... 기반으로 50로 평가","degree_required":"degree_required는 [방수공]\n-표면을 준비한다.\n-방수제를 선택한다.\n-프라이머를 바른다.\n-방수층을 시공한다.\n-마무리를 한다.\n-품질을 검사한다.\n-누수 여부를 확인한다.\n-수리를 한다.\n-안전... 기반으로 none로 평가","license_required":"license_required는 [방수공]\n-표면을 준비한다.\n-방수제를 선택한다.\n-프라이머를 바른다.\n-방수층을 시공한다.\n-마무리를 한다.\n-품질을 검사한다.\n-누수 여부를 확인한다.\n-수리를 한다.\n-안전... 기반으로 none로 평가"}'
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
  '1765283429587234',
  '출납창구사무원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 70, 50,
  50, 50, 50, 50, 50, 75,
  'regular', 'none', 'none', 'partial',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [출납창구사무원]\n-고객을 응대한다.\n-현금 입출금을 처리한다.\n-거래 기록을 입력한다.\n-서류를 검토한다.\n-거래를 승인한다.\n-잔고를 확인한다.\n-문제를 해결한다.\n-보고서를 ... 기반으로 50로 평가","growth":"growth는 [출납창구사무원]\n-고객을 응대한다.\n-현금 입출금을 처리한다.\n-거래 기록을 입력한다.\n-서류를 검토한다.\n-거래를 승인한다.\n-잔고를 확인한다.\n-문제를 해결한다.\n-보고서를 ... 기반으로 50로 평가","stability":"stability는 [출납창구사무원]\n-고객을 응대한다.\n-현금 입출금을 처리한다.\n-거래 기록을 입력한다.\n-서류를 검토한다.\n-거래를 승인한다.\n-잔고를 확인한다.\n-문제를 해결한다.\n-보고서를 ... 기반으로 70로 평가","income":"income는 [출납창구사무원]\n-고객을 응대한다.\n-현금 입출금을 처리한다.\n-거래 기록을 입력한다.\n-서류를 검토한다.\n-거래를 승인한다.\n-잔고를 확인한다.\n-문제를 해결한다.\n-보고서를 ... 기반으로 50로 평가","teamwork":"teamwork는 [출납창구사무원]\n-고객을 응대한다.\n-현금 입출금을 처리한다.\n-거래 기록을 입력한다.\n-서류를 검토한다.\n-거래를 승인한다.\n-잔고를 확인한다.\n-문제를 해결한다.\n-보고서를 ... 기반으로 50로 평가","solo_deep":"solo_deep는 [출납창구사무원]\n-고객을 응대한다.\n-현금 입출금을 처리한다.\n-거래 기록을 입력한다.\n-서류를 검토한다.\n-거래를 승인한다.\n-잔고를 확인한다.\n-문제를 해결한다.\n-보고서를 ... 기반으로 50로 평가","analytical":"analytical는 [출납창구사무원]\n-고객을 응대한다.\n-현금 입출금을 처리한다.\n-거래 기록을 입력한다.\n-서류를 검토한다.\n-거래를 승인한다.\n-잔고를 확인한다.\n-문제를 해결한다.\n-보고서를 ... 기반으로 50로 평가","creative":"creative는 [출납창구사무원]\n-고객을 응대한다.\n-현금 입출금을 처리한다.\n-거래 기록을 입력한다.\n-서류를 검토한다.\n-거래를 승인한다.\n-잔고를 확인한다.\n-문제를 해결한다.\n-보고서를 ... 기반으로 50로 평가","execution":"execution는 [출납창구사무원]\n-고객을 응대한다.\n-현금 입출금을 처리한다.\n-거래 기록을 입력한다.\n-서류를 검토한다.\n-거래를 승인한다.\n-잔고를 확인한다.\n-문제를 해결한다.\n-보고서를 ... 기반으로 50로 평가","people_facing":"people_facing는 [출납창구사무원]\n-고객을 응대한다.\n-현금 입출금을 처리한다.\n-거래 기록을 입력한다.\n-서류를 검토한다.\n-거래를 승인한다.\n-잔고를 확인한다.\n-문제를 해결한다.\n-보고서를 ... 기반으로 75로 평가","degree_required":"degree_required는 [출납창구사무원]\n-고객을 응대한다.\n-현금 입출금을 처리한다.\n-거래 기록을 입력한다.\n-서류를 검토한다.\n-거래를 승인한다.\n-잔고를 확인한다.\n-문제를 해결한다.\n-보고서를 ... 기반으로 none로 평가","license_required":"license_required는 [출납창구사무원]\n-고객을 응대한다.\n-현금 입출금을 처리한다.\n-거래 기록을 입력한다.\n-서류를 검토한다.\n-거래를 승인한다.\n-잔고를 확인한다.\n-문제를 해결한다.\n-보고서를 ... 기반으로 none로 평가"}'
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
  '1765283488476842',
  '노점 및 이동판매원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 30, 50,
  50, 50, 60, 30, 60, 75,
  'regular', 'none', 'some', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [노점상]\n-장소를 선정한다.\n-상품을 진열한다.\n-고객을 응대한다.\n-판매를 한다.\n-가격을 협상한다.\n-계산을 한다.\n-상품을 관리한다.\n-청결을 유지한다.\n-안전을 지킨다.\n... 기반으로 50로 평가","growth":"growth는 [노점상]\n-장소를 선정한다.\n-상품을 진열한다.\n-고객을 응대한다.\n-판매를 한다.\n-가격을 협상한다.\n-계산을 한다.\n-상품을 관리한다.\n-청결을 유지한다.\n-안전을 지킨다.\n... 기반으로 50로 평가","stability":"stability는 [노점상]\n-장소를 선정한다.\n-상품을 진열한다.\n-고객을 응대한다.\n-판매를 한다.\n-가격을 협상한다.\n-계산을 한다.\n-상품을 관리한다.\n-청결을 유지한다.\n-안전을 지킨다.\n... 기반으로 30로 평가","income":"income는 [노점상]\n-장소를 선정한다.\n-상품을 진열한다.\n-고객을 응대한다.\n-판매를 한다.\n-가격을 협상한다.\n-계산을 한다.\n-상품을 관리한다.\n-청결을 유지한다.\n-안전을 지킨다.\n... 기반으로 50로 평가","teamwork":"teamwork는 [노점상]\n-장소를 선정한다.\n-상품을 진열한다.\n-고객을 응대한다.\n-판매를 한다.\n-가격을 협상한다.\n-계산을 한다.\n-상품을 관리한다.\n-청결을 유지한다.\n-안전을 지킨다.\n... 기반으로 50로 평가","solo_deep":"solo_deep는 [노점상]\n-장소를 선정한다.\n-상품을 진열한다.\n-고객을 응대한다.\n-판매를 한다.\n-가격을 협상한다.\n-계산을 한다.\n-상품을 관리한다.\n-청결을 유지한다.\n-안전을 지킨다.\n... 기반으로 50로 평가","analytical":"analytical는 [노점상]\n-장소를 선정한다.\n-상품을 진열한다.\n-고객을 응대한다.\n-판매를 한다.\n-가격을 협상한다.\n-계산을 한다.\n-상품을 관리한다.\n-청결을 유지한다.\n-안전을 지킨다.\n... 기반으로 60로 평가","creative":"creative는 [노점상]\n-장소를 선정한다.\n-상품을 진열한다.\n-고객을 응대한다.\n-판매를 한다.\n-가격을 협상한다.\n-계산을 한다.\n-상품을 관리한다.\n-청결을 유지한다.\n-안전을 지킨다.\n... 기반으로 30로 평가","execution":"execution는 [노점상]\n-장소를 선정한다.\n-상품을 진열한다.\n-고객을 응대한다.\n-판매를 한다.\n-가격을 협상한다.\n-계산을 한다.\n-상품을 관리한다.\n-청결을 유지한다.\n-안전을 지킨다.\n... 기반으로 60로 평가","people_facing":"people_facing는 [노점상]\n-장소를 선정한다.\n-상품을 진열한다.\n-고객을 응대한다.\n-판매를 한다.\n-가격을 협상한다.\n-계산을 한다.\n-상품을 관리한다.\n-청결을 유지한다.\n-안전을 지킨다.\n... 기반으로 75로 평가","degree_required":"degree_required는 [노점상]\n-장소를 선정한다.\n-상품을 진열한다.\n-고객을 응대한다.\n-판매를 한다.\n-가격을 협상한다.\n-계산을 한다.\n-상품을 관리한다.\n-청결을 유지한다.\n-안전을 지킨다.\n... 기반으로 none로 평가","license_required":"license_required는 [노점상]\n-장소를 선정한다.\n-상품을 진열한다.\n-고객을 응대한다.\n-판매를 한다.\n-가격을 협상한다.\n-계산을 한다.\n-상품을 관리한다.\n-청결을 유지한다.\n-안전을 지킨다.\n... 기반으로 none로 평가"}'
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
  '1765283430510688',
  '보험대리인 및 중개인',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 60, 30, 50,
  30, 70, 60, 30, 60, 75,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [보험대리인]\n-보험 상품을 소개한다.\n-고객 상담을 한다.\n-계약을 체결한다.\n-보험금을 청구한다.\n-고객을 관리한다.\n-시장 조사를 한다.\n-교육을 받는다.\n-성과를 기록한다.... 기반으로 50로 평가","growth":"growth는 [보험대리인]\n-보험 상품을 소개한다.\n-고객 상담을 한다.\n-계약을 체결한다.\n-보험금을 청구한다.\n-고객을 관리한다.\n-시장 조사를 한다.\n-교육을 받는다.\n-성과를 기록한다.... 기반으로 60로 평가","stability":"stability는 [보험대리인]\n-보험 상품을 소개한다.\n-고객 상담을 한다.\n-계약을 체결한다.\n-보험금을 청구한다.\n-고객을 관리한다.\n-시장 조사를 한다.\n-교육을 받는다.\n-성과를 기록한다.... 기반으로 30로 평가","income":"income는 [보험대리인]\n-보험 상품을 소개한다.\n-고객 상담을 한다.\n-계약을 체결한다.\n-보험금을 청구한다.\n-고객을 관리한다.\n-시장 조사를 한다.\n-교육을 받는다.\n-성과를 기록한다.... 기반으로 50로 평가","teamwork":"teamwork는 [보험대리인]\n-보험 상품을 소개한다.\n-고객 상담을 한다.\n-계약을 체결한다.\n-보험금을 청구한다.\n-고객을 관리한다.\n-시장 조사를 한다.\n-교육을 받는다.\n-성과를 기록한다.... 기반으로 30로 평가","solo_deep":"solo_deep는 [보험대리인]\n-보험 상품을 소개한다.\n-고객 상담을 한다.\n-계약을 체결한다.\n-보험금을 청구한다.\n-고객을 관리한다.\n-시장 조사를 한다.\n-교육을 받는다.\n-성과를 기록한다.... 기반으로 70로 평가","analytical":"analytical는 [보험대리인]\n-보험 상품을 소개한다.\n-고객 상담을 한다.\n-계약을 체결한다.\n-보험금을 청구한다.\n-고객을 관리한다.\n-시장 조사를 한다.\n-교육을 받는다.\n-성과를 기록한다.... 기반으로 60로 평가","creative":"creative는 [보험대리인]\n-보험 상품을 소개한다.\n-고객 상담을 한다.\n-계약을 체결한다.\n-보험금을 청구한다.\n-고객을 관리한다.\n-시장 조사를 한다.\n-교육을 받는다.\n-성과를 기록한다.... 기반으로 30로 평가","execution":"execution는 [보험대리인]\n-보험 상품을 소개한다.\n-고객 상담을 한다.\n-계약을 체결한다.\n-보험금을 청구한다.\n-고객을 관리한다.\n-시장 조사를 한다.\n-교육을 받는다.\n-성과를 기록한다.... 기반으로 60로 평가","people_facing":"people_facing는 [보험대리인]\n-보험 상품을 소개한다.\n-고객 상담을 한다.\n-계약을 체결한다.\n-보험금을 청구한다.\n-고객을 관리한다.\n-시장 조사를 한다.\n-교육을 받는다.\n-성과를 기록한다.... 기반으로 75로 평가","degree_required":"degree_required는 [보험대리인]\n-보험 상품을 소개한다.\n-고객 상담을 한다.\n-계약을 체결한다.\n-보험금을 청구한다.\n-고객을 관리한다.\n-시장 조사를 한다.\n-교육을 받는다.\n-성과를 기록한다.... 기반으로 none로 평가","license_required":"license_required는 [보험대리인]\n-보험 상품을 소개한다.\n-고객 상담을 한다.\n-계약을 체결한다.\n-보험금을 청구한다.\n-고객을 관리한다.\n-시장 조사를 한다.\n-교육을 받는다.\n-성과를 기록한다.... 기반으로 none로 평가"}'
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
  '1765283412658784',
  '건설·채굴관리자',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  70, 30, 40, 40, 70, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [건설관리자]\n-프로젝트 계획을 수립한다.\n-예산을 관리한다.\n-팀을 감독한다.\n-품질을 통제한다.\n-일정을 관리한다.\n-안전을 유지한다.\n-하청업체를 관리한다.\n-보고서를 작성한... 기반으로 50로 평가","growth":"growth는 [건설관리자]\n-프로젝트 계획을 수립한다.\n-예산을 관리한다.\n-팀을 감독한다.\n-품질을 통제한다.\n-일정을 관리한다.\n-안전을 유지한다.\n-하청업체를 관리한다.\n-보고서를 작성한... 기반으로 50로 평가","stability":"stability는 [건설관리자]\n-프로젝트 계획을 수립한다.\n-예산을 관리한다.\n-팀을 감독한다.\n-품질을 통제한다.\n-일정을 관리한다.\n-안전을 유지한다.\n-하청업체를 관리한다.\n-보고서를 작성한... 기반으로 50로 평가","income":"income는 [건설관리자]\n-프로젝트 계획을 수립한다.\n-예산을 관리한다.\n-팀을 감독한다.\n-품질을 통제한다.\n-일정을 관리한다.\n-안전을 유지한다.\n-하청업체를 관리한다.\n-보고서를 작성한... 기반으로 50로 평가","teamwork":"teamwork는 [건설관리자]\n-프로젝트 계획을 수립한다.\n-예산을 관리한다.\n-팀을 감독한다.\n-품질을 통제한다.\n-일정을 관리한다.\n-안전을 유지한다.\n-하청업체를 관리한다.\n-보고서를 작성한... 기반으로 70로 평가","solo_deep":"solo_deep는 [건설관리자]\n-프로젝트 계획을 수립한다.\n-예산을 관리한다.\n-팀을 감독한다.\n-품질을 통제한다.\n-일정을 관리한다.\n-안전을 유지한다.\n-하청업체를 관리한다.\n-보고서를 작성한... 기반으로 30로 평가","analytical":"analytical는 [건설관리자]\n-프로젝트 계획을 수립한다.\n-예산을 관리한다.\n-팀을 감독한다.\n-품질을 통제한다.\n-일정을 관리한다.\n-안전을 유지한다.\n-하청업체를 관리한다.\n-보고서를 작성한... 기반으로 40로 평가","creative":"creative는 [건설관리자]\n-프로젝트 계획을 수립한다.\n-예산을 관리한다.\n-팀을 감독한다.\n-품질을 통제한다.\n-일정을 관리한다.\n-안전을 유지한다.\n-하청업체를 관리한다.\n-보고서를 작성한... 기반으로 40로 평가","execution":"execution는 [건설관리자]\n-프로젝트 계획을 수립한다.\n-예산을 관리한다.\n-팀을 감독한다.\n-품질을 통제한다.\n-일정을 관리한다.\n-안전을 유지한다.\n-하청업체를 관리한다.\n-보고서를 작성한... 기반으로 70로 평가","people_facing":"people_facing는 [건설관리자]\n-프로젝트 계획을 수립한다.\n-예산을 관리한다.\n-팀을 감독한다.\n-품질을 통제한다.\n-일정을 관리한다.\n-안전을 유지한다.\n-하청업체를 관리한다.\n-보고서를 작성한... 기반으로 50로 평가","degree_required":"degree_required는 [건설관리자]\n-프로젝트 계획을 수립한다.\n-예산을 관리한다.\n-팀을 감독한다.\n-품질을 통제한다.\n-일정을 관리한다.\n-안전을 유지한다.\n-하청업체를 관리한다.\n-보고서를 작성한... 기반으로 none로 평가","license_required":"license_required는 [건설관리자]\n-프로젝트 계획을 수립한다.\n-예산을 관리한다.\n-팀을 감독한다.\n-품질을 통제한다.\n-일정을 관리한다.\n-안전을 유지한다.\n-하청업체를 관리한다.\n-보고서를 작성한... 기반으로 none로 평가"}'
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
  '1765283411272742',
  '음식서비스관리자',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 75, 50, 50,
  50, 50, 50, 50, 50, 60,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [레스토랑관리자]\n-메뉴를 기획한다.\n-직원을 관리한다.\n-서비스 질을 감독한다.\n-재고를 관리한다.\n-예약을 처리한다.\n-고객 불편을 해결한다.\n-매출을 분석한다.\n-마케팅을 실... 기반으로 50로 평가","growth":"growth는 [레스토랑관리자]\n-메뉴를 기획한다.\n-직원을 관리한다.\n-서비스 질을 감독한다.\n-재고를 관리한다.\n-예약을 처리한다.\n-고객 불편을 해결한다.\n-매출을 분석한다.\n-마케팅을 실... 기반으로 75로 평가","stability":"stability는 [레스토랑관리자]\n-메뉴를 기획한다.\n-직원을 관리한다.\n-서비스 질을 감독한다.\n-재고를 관리한다.\n-예약을 처리한다.\n-고객 불편을 해결한다.\n-매출을 분석한다.\n-마케팅을 실... 기반으로 50로 평가","income":"income는 [레스토랑관리자]\n-메뉴를 기획한다.\n-직원을 관리한다.\n-서비스 질을 감독한다.\n-재고를 관리한다.\n-예약을 처리한다.\n-고객 불편을 해결한다.\n-매출을 분석한다.\n-마케팅을 실... 기반으로 50로 평가","teamwork":"teamwork는 [레스토랑관리자]\n-메뉴를 기획한다.\n-직원을 관리한다.\n-서비스 질을 감독한다.\n-재고를 관리한다.\n-예약을 처리한다.\n-고객 불편을 해결한다.\n-매출을 분석한다.\n-마케팅을 실... 기반으로 50로 평가","solo_deep":"solo_deep는 [레스토랑관리자]\n-메뉴를 기획한다.\n-직원을 관리한다.\n-서비스 질을 감독한다.\n-재고를 관리한다.\n-예약을 처리한다.\n-고객 불편을 해결한다.\n-매출을 분석한다.\n-마케팅을 실... 기반으로 50로 평가","analytical":"analytical는 [레스토랑관리자]\n-메뉴를 기획한다.\n-직원을 관리한다.\n-서비스 질을 감독한다.\n-재고를 관리한다.\n-예약을 처리한다.\n-고객 불편을 해결한다.\n-매출을 분석한다.\n-마케팅을 실... 기반으로 50로 평가","creative":"creative는 [레스토랑관리자]\n-메뉴를 기획한다.\n-직원을 관리한다.\n-서비스 질을 감독한다.\n-재고를 관리한다.\n-예약을 처리한다.\n-고객 불편을 해결한다.\n-매출을 분석한다.\n-마케팅을 실... 기반으로 50로 평가","execution":"execution는 [레스토랑관리자]\n-메뉴를 기획한다.\n-직원을 관리한다.\n-서비스 질을 감독한다.\n-재고를 관리한다.\n-예약을 처리한다.\n-고객 불편을 해결한다.\n-매출을 분석한다.\n-마케팅을 실... 기반으로 50로 평가","people_facing":"people_facing는 [레스토랑관리자]\n-메뉴를 기획한다.\n-직원을 관리한다.\n-서비스 질을 감독한다.\n-재고를 관리한다.\n-예약을 처리한다.\n-고객 불편을 해결한다.\n-매출을 분석한다.\n-마케팅을 실... 기반으로 60로 평가","degree_required":"degree_required는 [레스토랑관리자]\n-메뉴를 기획한다.\n-직원을 관리한다.\n-서비스 질을 감독한다.\n-재고를 관리한다.\n-예약을 처리한다.\n-고객 불편을 해결한다.\n-매출을 분석한다.\n-마케팅을 실... 기반으로 none로 평가","license_required":"license_required는 [레스토랑관리자]\n-메뉴를 기획한다.\n-직원을 관리한다.\n-서비스 질을 감독한다.\n-재고를 관리한다.\n-예약을 처리한다.\n-고객 불편을 해결한다.\n-매출을 분석한다.\n-마케팅을 실... 기반으로 none로 평가"}'
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
  '1765283431922351',
  '농학연구원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  40, 65, 50, 70,
  70, 30, 60, 60, 30, 35,
  'overtime_some', 'none', 'some', 'none',
  'master', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [농학연구원]\n-작물 품종을 개발한다.\n-토양을 분석한다.\n-병충해 방제를 연구한다.\n-재배 기술을 개발한다.\n-실험을 설계한다.\n-데이터를 수집한다.\n-보고서를 작성한다.\n-논문... 기반으로 40로 평가","growth":"growth는 [농학연구원]\n-작물 품종을 개발한다.\n-토양을 분석한다.\n-병충해 방제를 연구한다.\n-재배 기술을 개발한다.\n-실험을 설계한다.\n-데이터를 수집한다.\n-보고서를 작성한다.\n-논문... 기반으로 65로 평가","stability":"stability는 [농학연구원]\n-작물 품종을 개발한다.\n-토양을 분석한다.\n-병충해 방제를 연구한다.\n-재배 기술을 개발한다.\n-실험을 설계한다.\n-데이터를 수집한다.\n-보고서를 작성한다.\n-논문... 기반으로 50로 평가","income":"income는 [농학연구원]\n-작물 품종을 개발한다.\n-토양을 분석한다.\n-병충해 방제를 연구한다.\n-재배 기술을 개발한다.\n-실험을 설계한다.\n-데이터를 수집한다.\n-보고서를 작성한다.\n-논문... 기반으로 70로 평가","teamwork":"teamwork는 [농학연구원]\n-작물 품종을 개발한다.\n-토양을 분석한다.\n-병충해 방제를 연구한다.\n-재배 기술을 개발한다.\n-실험을 설계한다.\n-데이터를 수집한다.\n-보고서를 작성한다.\n-논문... 기반으로 70로 평가","solo_deep":"solo_deep는 [농학연구원]\n-작물 품종을 개발한다.\n-토양을 분석한다.\n-병충해 방제를 연구한다.\n-재배 기술을 개발한다.\n-실험을 설계한다.\n-데이터를 수집한다.\n-보고서를 작성한다.\n-논문... 기반으로 30로 평가","analytical":"analytical는 [농학연구원]\n-작물 품종을 개발한다.\n-토양을 분석한다.\n-병충해 방제를 연구한다.\n-재배 기술을 개발한다.\n-실험을 설계한다.\n-데이터를 수집한다.\n-보고서를 작성한다.\n-논문... 기반으로 60로 평가","creative":"creative는 [농학연구원]\n-작물 품종을 개발한다.\n-토양을 분석한다.\n-병충해 방제를 연구한다.\n-재배 기술을 개발한다.\n-실험을 설계한다.\n-데이터를 수집한다.\n-보고서를 작성한다.\n-논문... 기반으로 60로 평가","execution":"execution는 [농학연구원]\n-작물 품종을 개발한다.\n-토양을 분석한다.\n-병충해 방제를 연구한다.\n-재배 기술을 개발한다.\n-실험을 설계한다.\n-데이터를 수집한다.\n-보고서를 작성한다.\n-논문... 기반으로 30로 평가","people_facing":"people_facing는 [농학연구원]\n-작물 품종을 개발한다.\n-토양을 분석한다.\n-병충해 방제를 연구한다.\n-재배 기술을 개발한다.\n-실험을 설계한다.\n-데이터를 수집한다.\n-보고서를 작성한다.\n-논문... 기반으로 35로 평가","degree_required":"degree_required는 [농학연구원]\n-작물 품종을 개발한다.\n-토양을 분석한다.\n-병충해 방제를 연구한다.\n-재배 기술을 개발한다.\n-실험을 설계한다.\n-데이터를 수집한다.\n-보고서를 작성한다.\n-논문... 기반으로 master로 평가","license_required":"license_required는 [농학연구원]\n-작물 품종을 개발한다.\n-토양을 분석한다.\n-병충해 방제를 연구한다.\n-재배 기술을 개발한다.\n-실험을 설계한다.\n-데이터를 수집한다.\n-보고서를 작성한다.\n-논문... 기반으로 none로 평가"}'
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
  '1765283421791357',
  '품질관리사무원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 70, 50,
  50, 50, 60, 30, 60, 50,
  'regular', 'none', 'none', 'partial',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [품질관리사무원]\n-품질 기준을 설정한다.\n-검사 계획을 수립한다.\n-샘플을 채취한다.\n-테스트를 실시한다.\n-결과를 기록한다.\n-문제를 분석한다.\n-개선 방안을 제안한다.\n-보고... 기반으로 50로 평가","growth":"growth는 [품질관리사무원]\n-품질 기준을 설정한다.\n-검사 계획을 수립한다.\n-샘플을 채취한다.\n-테스트를 실시한다.\n-결과를 기록한다.\n-문제를 분석한다.\n-개선 방안을 제안한다.\n-보고... 기반으로 50로 평가","stability":"stability는 [품질관리사무원]\n-품질 기준을 설정한다.\n-검사 계획을 수립한다.\n-샘플을 채취한다.\n-테스트를 실시한다.\n-결과를 기록한다.\n-문제를 분석한다.\n-개선 방안을 제안한다.\n-보고... 기반으로 70로 평가","income":"income는 [품질관리사무원]\n-품질 기준을 설정한다.\n-검사 계획을 수립한다.\n-샘플을 채취한다.\n-테스트를 실시한다.\n-결과를 기록한다.\n-문제를 분석한다.\n-개선 방안을 제안한다.\n-보고... 기반으로 50로 평가","teamwork":"teamwork는 [품질관리사무원]\n-품질 기준을 설정한다.\n-검사 계획을 수립한다.\n-샘플을 채취한다.\n-테스트를 실시한다.\n-결과를 기록한다.\n-문제를 분석한다.\n-개선 방안을 제안한다.\n-보고... 기반으로 50로 평가","solo_deep":"solo_deep는 [품질관리사무원]\n-품질 기준을 설정한다.\n-검사 계획을 수립한다.\n-샘플을 채취한다.\n-테스트를 실시한다.\n-결과를 기록한다.\n-문제를 분석한다.\n-개선 방안을 제안한다.\n-보고... 기반으로 50로 평가","analytical":"analytical는 [품질관리사무원]\n-품질 기준을 설정한다.\n-검사 계획을 수립한다.\n-샘플을 채취한다.\n-테스트를 실시한다.\n-결과를 기록한다.\n-문제를 분석한다.\n-개선 방안을 제안한다.\n-보고... 기반으로 60로 평가","creative":"creative는 [품질관리사무원]\n-품질 기준을 설정한다.\n-검사 계획을 수립한다.\n-샘플을 채취한다.\n-테스트를 실시한다.\n-결과를 기록한다.\n-문제를 분석한다.\n-개선 방안을 제안한다.\n-보고... 기반으로 30로 평가","execution":"execution는 [품질관리사무원]\n-품질 기준을 설정한다.\n-검사 계획을 수립한다.\n-샘플을 채취한다.\n-테스트를 실시한다.\n-결과를 기록한다.\n-문제를 분석한다.\n-개선 방안을 제안한다.\n-보고... 기반으로 60로 평가","people_facing":"people_facing는 [품질관리사무원]\n-품질 기준을 설정한다.\n-검사 계획을 수립한다.\n-샘플을 채취한다.\n-테스트를 실시한다.\n-결과를 기록한다.\n-문제를 분석한다.\n-개선 방안을 제안한다.\n-보고... 기반으로 50로 평가","degree_required":"degree_required는 [품질관리사무원]\n-품질 기준을 설정한다.\n-검사 계획을 수립한다.\n-샘플을 채취한다.\n-테스트를 실시한다.\n-결과를 기록한다.\n-문제를 분석한다.\n-개선 방안을 제안한다.\n-보고... 기반으로 none로 평가","license_required":"license_required는 [품질관리사무원]\n-품질 기준을 설정한다.\n-검사 계획을 수립한다.\n-샘플을 채취한다.\n-테스트를 실시한다.\n-결과를 기록한다.\n-문제를 분석한다.\n-개선 방안을 제안한다.\n-보고... 기반으로 none로 평가"}'
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