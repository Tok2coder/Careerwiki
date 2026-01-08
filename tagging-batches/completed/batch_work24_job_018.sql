-- Batch tagging SQL generated at 2026-01-06T07:16:27.324Z
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
  '1765283486042792',
  '계기검침원 및 가스점검원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 60, 50, 50,
  50, 50, 40, 40, 70, 75,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [계기검침원]\n-계기를 검침한다.\n-데이터를 기록한다.\n-오류를 확인한다.\n-보고서를 작성한다.\n-고객을 응대한다.\n-안전을 유지한다.\n-기록을 관리한다.\n-문제를 해결한다.\n-교... 기반으로 50로 평가","growth":"growth는 [계기검침원]\n-계기를 검침한다.\n-데이터를 기록한다.\n-오류를 확인한다.\n-보고서를 작성한다.\n-고객을 응대한다.\n-안전을 유지한다.\n-기록을 관리한다.\n-문제를 해결한다.\n-교... 기반으로 60로 평가","stability":"stability는 [계기검침원]\n-계기를 검침한다.\n-데이터를 기록한다.\n-오류를 확인한다.\n-보고서를 작성한다.\n-고객을 응대한다.\n-안전을 유지한다.\n-기록을 관리한다.\n-문제를 해결한다.\n-교... 기반으로 50로 평가","income":"income는 [계기검침원]\n-계기를 검침한다.\n-데이터를 기록한다.\n-오류를 확인한다.\n-보고서를 작성한다.\n-고객을 응대한다.\n-안전을 유지한다.\n-기록을 관리한다.\n-문제를 해결한다.\n-교... 기반으로 50로 평가","teamwork":"teamwork는 [계기검침원]\n-계기를 검침한다.\n-데이터를 기록한다.\n-오류를 확인한다.\n-보고서를 작성한다.\n-고객을 응대한다.\n-안전을 유지한다.\n-기록을 관리한다.\n-문제를 해결한다.\n-교... 기반으로 50로 평가","solo_deep":"solo_deep는 [계기검침원]\n-계기를 검침한다.\n-데이터를 기록한다.\n-오류를 확인한다.\n-보고서를 작성한다.\n-고객을 응대한다.\n-안전을 유지한다.\n-기록을 관리한다.\n-문제를 해결한다.\n-교... 기반으로 50로 평가","analytical":"analytical는 [계기검침원]\n-계기를 검침한다.\n-데이터를 기록한다.\n-오류를 확인한다.\n-보고서를 작성한다.\n-고객을 응대한다.\n-안전을 유지한다.\n-기록을 관리한다.\n-문제를 해결한다.\n-교... 기반으로 40로 평가","creative":"creative는 [계기검침원]\n-계기를 검침한다.\n-데이터를 기록한다.\n-오류를 확인한다.\n-보고서를 작성한다.\n-고객을 응대한다.\n-안전을 유지한다.\n-기록을 관리한다.\n-문제를 해결한다.\n-교... 기반으로 40로 평가","execution":"execution는 [계기검침원]\n-계기를 검침한다.\n-데이터를 기록한다.\n-오류를 확인한다.\n-보고서를 작성한다.\n-고객을 응대한다.\n-안전을 유지한다.\n-기록을 관리한다.\n-문제를 해결한다.\n-교... 기반으로 70로 평가","people_facing":"people_facing는 [계기검침원]\n-계기를 검침한다.\n-데이터를 기록한다.\n-오류를 확인한다.\n-보고서를 작성한다.\n-고객을 응대한다.\n-안전을 유지한다.\n-기록을 관리한다.\n-문제를 해결한다.\n-교... 기반으로 75로 평가","degree_required":"degree_required는 [계기검침원]\n-계기를 검침한다.\n-데이터를 기록한다.\n-오류를 확인한다.\n-보고서를 작성한다.\n-고객을 응대한다.\n-안전을 유지한다.\n-기록을 관리한다.\n-문제를 해결한다.\n-교... 기반으로 none로 평가","license_required":"license_required는 [계기검침원]\n-계기를 검침한다.\n-데이터를 기록한다.\n-오류를 확인한다.\n-보고서를 작성한다.\n-고객을 응대한다.\n-안전을 유지한다.\n-기록을 관리한다.\n-문제를 해결한다.\n-교... 기반으로 none로 평가"}'
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
  '1765283415146530',
  '일반행정공무원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  70, 30, 40, 40, 70, 50,
  'regular', 'none', 'none', 'none',
  'none', 'required', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [일반행정공무원]\n-행정 업무를 처리한다.\n-서류를 검토한다.\n-민원을 접수한다.\n-법규를 적용한다.\n-보고서를 작성한다.\n-기록을 관리한다.\n-시민을 지원한다.\n-회의를 준비한다... 기반으로 50로 평가","growth":"growth는 [일반행정공무원]\n-행정 업무를 처리한다.\n-서류를 검토한다.\n-민원을 접수한다.\n-법규를 적용한다.\n-보고서를 작성한다.\n-기록을 관리한다.\n-시민을 지원한다.\n-회의를 준비한다... 기반으로 50로 평가","stability":"stability는 [일반행정공무원]\n-행정 업무를 처리한다.\n-서류를 검토한다.\n-민원을 접수한다.\n-법규를 적용한다.\n-보고서를 작성한다.\n-기록을 관리한다.\n-시민을 지원한다.\n-회의를 준비한다... 기반으로 50로 평가","income":"income는 [일반행정공무원]\n-행정 업무를 처리한다.\n-서류를 검토한다.\n-민원을 접수한다.\n-법규를 적용한다.\n-보고서를 작성한다.\n-기록을 관리한다.\n-시민을 지원한다.\n-회의를 준비한다... 기반으로 50로 평가","teamwork":"teamwork는 [일반행정공무원]\n-행정 업무를 처리한다.\n-서류를 검토한다.\n-민원을 접수한다.\n-법규를 적용한다.\n-보고서를 작성한다.\n-기록을 관리한다.\n-시민을 지원한다.\n-회의를 준비한다... 기반으로 70로 평가","solo_deep":"solo_deep는 [일반행정공무원]\n-행정 업무를 처리한다.\n-서류를 검토한다.\n-민원을 접수한다.\n-법규를 적용한다.\n-보고서를 작성한다.\n-기록을 관리한다.\n-시민을 지원한다.\n-회의를 준비한다... 기반으로 30로 평가","analytical":"analytical는 [일반행정공무원]\n-행정 업무를 처리한다.\n-서류를 검토한다.\n-민원을 접수한다.\n-법규를 적용한다.\n-보고서를 작성한다.\n-기록을 관리한다.\n-시민을 지원한다.\n-회의를 준비한다... 기반으로 40로 평가","creative":"creative는 [일반행정공무원]\n-행정 업무를 처리한다.\n-서류를 검토한다.\n-민원을 접수한다.\n-법규를 적용한다.\n-보고서를 작성한다.\n-기록을 관리한다.\n-시민을 지원한다.\n-회의를 준비한다... 기반으로 40로 평가","execution":"execution는 [일반행정공무원]\n-행정 업무를 처리한다.\n-서류를 검토한다.\n-민원을 접수한다.\n-법규를 적용한다.\n-보고서를 작성한다.\n-기록을 관리한다.\n-시민을 지원한다.\n-회의를 준비한다... 기반으로 70로 평가","people_facing":"people_facing는 [일반행정공무원]\n-행정 업무를 처리한다.\n-서류를 검토한다.\n-민원을 접수한다.\n-법규를 적용한다.\n-보고서를 작성한다.\n-기록을 관리한다.\n-시민을 지원한다.\n-회의를 준비한다... 기반으로 50로 평가","degree_required":"degree_required는 [일반행정공무원]\n-행정 업무를 처리한다.\n-서류를 검토한다.\n-민원을 접수한다.\n-법규를 적용한다.\n-보고서를 작성한다.\n-기록을 관리한다.\n-시민을 지원한다.\n-회의를 준비한다... 기반으로 none로 평가","license_required":"license_required는 [일반행정공무원]\n-행정 업무를 처리한다.\n-서류를 검토한다.\n-민원을 접수한다.\n-법규를 적용한다.\n-보고서를 작성한다.\n-기록을 관리한다.\n-시민을 지원한다.\n-회의를 준비한다... 기반으로 required로 평가"}'
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
  '1765283488855673',
  '통신기기·서비스판매원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 60, 30, 50,
  50, 50, 60, 30, 60, 75,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [통신기기판매원]\n-통신 기기를 소개한다.\n-고객 상담을 한다.\n-계약을 체결한다.\n-설치를 지원한다.\n-문제를 해결한다.\n-기록을 관리한다.\n-성과를 추적한다.\n-교육을 받는다.... 기반으로 50로 평가","growth":"growth는 [통신기기판매원]\n-통신 기기를 소개한다.\n-고객 상담을 한다.\n-계약을 체결한다.\n-설치를 지원한다.\n-문제를 해결한다.\n-기록을 관리한다.\n-성과를 추적한다.\n-교육을 받는다.... 기반으로 60로 평가","stability":"stability는 [통신기기판매원]\n-통신 기기를 소개한다.\n-고객 상담을 한다.\n-계약을 체결한다.\n-설치를 지원한다.\n-문제를 해결한다.\n-기록을 관리한다.\n-성과를 추적한다.\n-교육을 받는다.... 기반으로 30로 평가","income":"income는 [통신기기판매원]\n-통신 기기를 소개한다.\n-고객 상담을 한다.\n-계약을 체결한다.\n-설치를 지원한다.\n-문제를 해결한다.\n-기록을 관리한다.\n-성과를 추적한다.\n-교육을 받는다.... 기반으로 50로 평가","teamwork":"teamwork는 [통신기기판매원]\n-통신 기기를 소개한다.\n-고객 상담을 한다.\n-계약을 체결한다.\n-설치를 지원한다.\n-문제를 해결한다.\n-기록을 관리한다.\n-성과를 추적한다.\n-교육을 받는다.... 기반으로 50로 평가","solo_deep":"solo_deep는 [통신기기판매원]\n-통신 기기를 소개한다.\n-고객 상담을 한다.\n-계약을 체결한다.\n-설치를 지원한다.\n-문제를 해결한다.\n-기록을 관리한다.\n-성과를 추적한다.\n-교육을 받는다.... 기반으로 50로 평가","analytical":"analytical는 [통신기기판매원]\n-통신 기기를 소개한다.\n-고객 상담을 한다.\n-계약을 체결한다.\n-설치를 지원한다.\n-문제를 해결한다.\n-기록을 관리한다.\n-성과를 추적한다.\n-교육을 받는다.... 기반으로 60로 평가","creative":"creative는 [통신기기판매원]\n-통신 기기를 소개한다.\n-고객 상담을 한다.\n-계약을 체결한다.\n-설치를 지원한다.\n-문제를 해결한다.\n-기록을 관리한다.\n-성과를 추적한다.\n-교육을 받는다.... 기반으로 30로 평가","execution":"execution는 [통신기기판매원]\n-통신 기기를 소개한다.\n-고객 상담을 한다.\n-계약을 체결한다.\n-설치를 지원한다.\n-문제를 해결한다.\n-기록을 관리한다.\n-성과를 추적한다.\n-교육을 받는다.... 기반으로 60로 평가","people_facing":"people_facing는 [통신기기판매원]\n-통신 기기를 소개한다.\n-고객 상담을 한다.\n-계약을 체결한다.\n-설치를 지원한다.\n-문제를 해결한다.\n-기록을 관리한다.\n-성과를 추적한다.\n-교육을 받는다.... 기반으로 75로 평가","degree_required":"degree_required는 [통신기기판매원]\n-통신 기기를 소개한다.\n-고객 상담을 한다.\n-계약을 체결한다.\n-설치를 지원한다.\n-문제를 해결한다.\n-기록을 관리한다.\n-성과를 추적한다.\n-교육을 받는다.... 기반으로 none로 평가","license_required":"license_required는 [통신기기판매원]\n-통신 기기를 소개한다.\n-고객 상담을 한다.\n-계약을 체결한다.\n-설치를 지원한다.\n-문제를 해결한다.\n-기록을 관리한다.\n-성과를 추적한다.\n-교육을 받는다.... 기반으로 none로 평가"}'
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
  '1765283425991686',
  '통계사무원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 70, 50,
  50, 50, 60, 30, 60, 50,
  'regular', 'none', 'none', 'partial',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [통계사무원]\n-데이터를 수집한다.\n-통계를 계산한다.\n-보고서를 작성한다.\n-데이터를 검증한다.\n-시스템을 운영한다.\n-분석을 지원한다.\n-기록을 관리한다.\n-법규를 준수한다.\n... 기반으로 50로 평가","growth":"growth는 [통계사무원]\n-데이터를 수집한다.\n-통계를 계산한다.\n-보고서를 작성한다.\n-데이터를 검증한다.\n-시스템을 운영한다.\n-분석을 지원한다.\n-기록을 관리한다.\n-법규를 준수한다.\n... 기반으로 50로 평가","stability":"stability는 [통계사무원]\n-데이터를 수집한다.\n-통계를 계산한다.\n-보고서를 작성한다.\n-데이터를 검증한다.\n-시스템을 운영한다.\n-분석을 지원한다.\n-기록을 관리한다.\n-법규를 준수한다.\n... 기반으로 70로 평가","income":"income는 [통계사무원]\n-데이터를 수집한다.\n-통계를 계산한다.\n-보고서를 작성한다.\n-데이터를 검증한다.\n-시스템을 운영한다.\n-분석을 지원한다.\n-기록을 관리한다.\n-법규를 준수한다.\n... 기반으로 50로 평가","teamwork":"teamwork는 [통계사무원]\n-데이터를 수집한다.\n-통계를 계산한다.\n-보고서를 작성한다.\n-데이터를 검증한다.\n-시스템을 운영한다.\n-분석을 지원한다.\n-기록을 관리한다.\n-법규를 준수한다.\n... 기반으로 50로 평가","solo_deep":"solo_deep는 [통계사무원]\n-데이터를 수집한다.\n-통계를 계산한다.\n-보고서를 작성한다.\n-데이터를 검증한다.\n-시스템을 운영한다.\n-분석을 지원한다.\n-기록을 관리한다.\n-법규를 준수한다.\n... 기반으로 50로 평가","analytical":"analytical는 [통계사무원]\n-데이터를 수집한다.\n-통계를 계산한다.\n-보고서를 작성한다.\n-데이터를 검증한다.\n-시스템을 운영한다.\n-분석을 지원한다.\n-기록을 관리한다.\n-법규를 준수한다.\n... 기반으로 60로 평가","creative":"creative는 [통계사무원]\n-데이터를 수집한다.\n-통계를 계산한다.\n-보고서를 작성한다.\n-데이터를 검증한다.\n-시스템을 운영한다.\n-분석을 지원한다.\n-기록을 관리한다.\n-법규를 준수한다.\n... 기반으로 30로 평가","execution":"execution는 [통계사무원]\n-데이터를 수집한다.\n-통계를 계산한다.\n-보고서를 작성한다.\n-데이터를 검증한다.\n-시스템을 운영한다.\n-분석을 지원한다.\n-기록을 관리한다.\n-법규를 준수한다.\n... 기반으로 60로 평가","people_facing":"people_facing는 [통계사무원]\n-데이터를 수집한다.\n-통계를 계산한다.\n-보고서를 작성한다.\n-데이터를 검증한다.\n-시스템을 운영한다.\n-분석을 지원한다.\n-기록을 관리한다.\n-법규를 준수한다.\n... 기반으로 50로 평가","degree_required":"degree_required는 [통계사무원]\n-데이터를 수집한다.\n-통계를 계산한다.\n-보고서를 작성한다.\n-데이터를 검증한다.\n-시스템을 운영한다.\n-분석을 지원한다.\n-기록을 관리한다.\n-법규를 준수한다.\n... 기반으로 none로 평가","license_required":"license_required는 [통계사무원]\n-데이터를 수집한다.\n-통계를 계산한다.\n-보고서를 작성한다.\n-데이터를 검증한다.\n-시스템을 운영한다.\n-분석을 지원한다.\n-기록을 관리한다.\n-법규를 준수한다.\n... 기반으로 none로 평가"}'
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
  '1765283423403768',
  '안내 및 접수사무원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  40, 50, 70, 50,
  70, 30, 40, 40, 70, 75,
  'overtime_some', 'none', 'some', 'partial',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [안내사무원]\n-방문객을 안내한다.\n-질문을 답변한다.\n-시설 정보를 제공한다.\n-안전을 유지한다.\n-기록을 관리한다.\n-문제를 해결한다.\n-청결을 유지한다.\n-응급 상황에 대응한... 기반으로 40로 평가","growth":"growth는 [안내사무원]\n-방문객을 안내한다.\n-질문을 답변한다.\n-시설 정보를 제공한다.\n-안전을 유지한다.\n-기록을 관리한다.\n-문제를 해결한다.\n-청결을 유지한다.\n-응급 상황에 대응한... 기반으로 50로 평가","stability":"stability는 [안내사무원]\n-방문객을 안내한다.\n-질문을 답변한다.\n-시설 정보를 제공한다.\n-안전을 유지한다.\n-기록을 관리한다.\n-문제를 해결한다.\n-청결을 유지한다.\n-응급 상황에 대응한... 기반으로 70로 평가","income":"income는 [안내사무원]\n-방문객을 안내한다.\n-질문을 답변한다.\n-시설 정보를 제공한다.\n-안전을 유지한다.\n-기록을 관리한다.\n-문제를 해결한다.\n-청결을 유지한다.\n-응급 상황에 대응한... 기반으로 50로 평가","teamwork":"teamwork는 [안내사무원]\n-방문객을 안내한다.\n-질문을 답변한다.\n-시설 정보를 제공한다.\n-안전을 유지한다.\n-기록을 관리한다.\n-문제를 해결한다.\n-청결을 유지한다.\n-응급 상황에 대응한... 기반으로 70로 평가","solo_deep":"solo_deep는 [안내사무원]\n-방문객을 안내한다.\n-질문을 답변한다.\n-시설 정보를 제공한다.\n-안전을 유지한다.\n-기록을 관리한다.\n-문제를 해결한다.\n-청결을 유지한다.\n-응급 상황에 대응한... 기반으로 30로 평가","analytical":"analytical는 [안내사무원]\n-방문객을 안내한다.\n-질문을 답변한다.\n-시설 정보를 제공한다.\n-안전을 유지한다.\n-기록을 관리한다.\n-문제를 해결한다.\n-청결을 유지한다.\n-응급 상황에 대응한... 기반으로 40로 평가","creative":"creative는 [안내사무원]\n-방문객을 안내한다.\n-질문을 답변한다.\n-시설 정보를 제공한다.\n-안전을 유지한다.\n-기록을 관리한다.\n-문제를 해결한다.\n-청결을 유지한다.\n-응급 상황에 대응한... 기반으로 40로 평가","execution":"execution는 [안내사무원]\n-방문객을 안내한다.\n-질문을 답변한다.\n-시설 정보를 제공한다.\n-안전을 유지한다.\n-기록을 관리한다.\n-문제를 해결한다.\n-청결을 유지한다.\n-응급 상황에 대응한... 기반으로 70로 평가","people_facing":"people_facing는 [안내사무원]\n-방문객을 안내한다.\n-질문을 답변한다.\n-시설 정보를 제공한다.\n-안전을 유지한다.\n-기록을 관리한다.\n-문제를 해결한다.\n-청결을 유지한다.\n-응급 상황에 대응한... 기반으로 75로 평가","degree_required":"degree_required는 [안내사무원]\n-방문객을 안내한다.\n-질문을 답변한다.\n-시설 정보를 제공한다.\n-안전을 유지한다.\n-기록을 관리한다.\n-문제를 해결한다.\n-청결을 유지한다.\n-응급 상황에 대응한... 기반으로 none로 평가","license_required":"license_required는 [안내사무원]\n-방문객을 안내한다.\n-질문을 답변한다.\n-시설 정보를 제공한다.\n-안전을 유지한다.\n-기록을 관리한다.\n-문제를 해결한다.\n-청결을 유지한다.\n-응급 상황에 대응한... 기반으로 none로 평가"}'
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
  '1765283424652482',
  '취업알선원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 30, 50,
  50, 50, 40, 40, 70, 75,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [취업알선원]\n-구직자를 상담한다.\n-적합한 일자리를 추천한다.\n-이력서를 검토한다.\n-면접을 준비한다.\n-기업과 연계한다.\n-계약을 지원한다.\n-기록을 관리한다.\n-보고서를 작성... 기반으로 50로 평가","growth":"growth는 [취업알선원]\n-구직자를 상담한다.\n-적합한 일자리를 추천한다.\n-이력서를 검토한다.\n-면접을 준비한다.\n-기업과 연계한다.\n-계약을 지원한다.\n-기록을 관리한다.\n-보고서를 작성... 기반으로 50로 평가","stability":"stability는 [취업알선원]\n-구직자를 상담한다.\n-적합한 일자리를 추천한다.\n-이력서를 검토한다.\n-면접을 준비한다.\n-기업과 연계한다.\n-계약을 지원한다.\n-기록을 관리한다.\n-보고서를 작성... 기반으로 30로 평가","income":"income는 [취업알선원]\n-구직자를 상담한다.\n-적합한 일자리를 추천한다.\n-이력서를 검토한다.\n-면접을 준비한다.\n-기업과 연계한다.\n-계약을 지원한다.\n-기록을 관리한다.\n-보고서를 작성... 기반으로 50로 평가","teamwork":"teamwork는 [취업알선원]\n-구직자를 상담한다.\n-적합한 일자리를 추천한다.\n-이력서를 검토한다.\n-면접을 준비한다.\n-기업과 연계한다.\n-계약을 지원한다.\n-기록을 관리한다.\n-보고서를 작성... 기반으로 50로 평가","solo_deep":"solo_deep는 [취업알선원]\n-구직자를 상담한다.\n-적합한 일자리를 추천한다.\n-이력서를 검토한다.\n-면접을 준비한다.\n-기업과 연계한다.\n-계약을 지원한다.\n-기록을 관리한다.\n-보고서를 작성... 기반으로 50로 평가","analytical":"analytical는 [취업알선원]\n-구직자를 상담한다.\n-적합한 일자리를 추천한다.\n-이력서를 검토한다.\n-면접을 준비한다.\n-기업과 연계한다.\n-계약을 지원한다.\n-기록을 관리한다.\n-보고서를 작성... 기반으로 40로 평가","creative":"creative는 [취업알선원]\n-구직자를 상담한다.\n-적합한 일자리를 추천한다.\n-이력서를 검토한다.\n-면접을 준비한다.\n-기업과 연계한다.\n-계약을 지원한다.\n-기록을 관리한다.\n-보고서를 작성... 기반으로 40로 평가","execution":"execution는 [취업알선원]\n-구직자를 상담한다.\n-적합한 일자리를 추천한다.\n-이력서를 검토한다.\n-면접을 준비한다.\n-기업과 연계한다.\n-계약을 지원한다.\n-기록을 관리한다.\n-보고서를 작성... 기반으로 70로 평가","people_facing":"people_facing는 [취업알선원]\n-구직자를 상담한다.\n-적합한 일자리를 추천한다.\n-이력서를 검토한다.\n-면접을 준비한다.\n-기업과 연계한다.\n-계약을 지원한다.\n-기록을 관리한다.\n-보고서를 작성... 기반으로 75로 평가","degree_required":"degree_required는 [취업알선원]\n-구직자를 상담한다.\n-적합한 일자리를 추천한다.\n-이력서를 검토한다.\n-면접을 준비한다.\n-기업과 연계한다.\n-계약을 지원한다.\n-기록을 관리한다.\n-보고서를 작성... 기반으로 none로 평가","license_required":"license_required는 [취업알선원]\n-구직자를 상담한다.\n-적합한 일자리를 추천한다.\n-이력서를 검토한다.\n-면접을 준비한다.\n-기업과 연계한다.\n-계약을 지원한다.\n-기록을 관리한다.\n-보고서를 작성... 기반으로 none로 평가"}'
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
  '1765283482838495',
  '음식배달원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  50, 50, 40, 40, 70, 75,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [음식배달원]\n-주문을 접수한다.\n-음식을 준비한다.\n-배달을 실시한다.\n-고객을 응대한다.\n-안전을 유지한다.\n-기록을 관리한다.\n-문제를 해결한다.\n-시간을 준수한다.\n-피드백... 기반으로 50로 평가","growth":"growth는 [음식배달원]\n-주문을 접수한다.\n-음식을 준비한다.\n-배달을 실시한다.\n-고객을 응대한다.\n-안전을 유지한다.\n-기록을 관리한다.\n-문제를 해결한다.\n-시간을 준수한다.\n-피드백... 기반으로 50로 평가","stability":"stability는 [음식배달원]\n-주문을 접수한다.\n-음식을 준비한다.\n-배달을 실시한다.\n-고객을 응대한다.\n-안전을 유지한다.\n-기록을 관리한다.\n-문제를 해결한다.\n-시간을 준수한다.\n-피드백... 기반으로 50로 평가","income":"income는 [음식배달원]\n-주문을 접수한다.\n-음식을 준비한다.\n-배달을 실시한다.\n-고객을 응대한다.\n-안전을 유지한다.\n-기록을 관리한다.\n-문제를 해결한다.\n-시간을 준수한다.\n-피드백... 기반으로 50로 평가","teamwork":"teamwork는 [음식배달원]\n-주문을 접수한다.\n-음식을 준비한다.\n-배달을 실시한다.\n-고객을 응대한다.\n-안전을 유지한다.\n-기록을 관리한다.\n-문제를 해결한다.\n-시간을 준수한다.\n-피드백... 기반으로 50로 평가","solo_deep":"solo_deep는 [음식배달원]\n-주문을 접수한다.\n-음식을 준비한다.\n-배달을 실시한다.\n-고객을 응대한다.\n-안전을 유지한다.\n-기록을 관리한다.\n-문제를 해결한다.\n-시간을 준수한다.\n-피드백... 기반으로 50로 평가","analytical":"analytical는 [음식배달원]\n-주문을 접수한다.\n-음식을 준비한다.\n-배달을 실시한다.\n-고객을 응대한다.\n-안전을 유지한다.\n-기록을 관리한다.\n-문제를 해결한다.\n-시간을 준수한다.\n-피드백... 기반으로 40로 평가","creative":"creative는 [음식배달원]\n-주문을 접수한다.\n-음식을 준비한다.\n-배달을 실시한다.\n-고객을 응대한다.\n-안전을 유지한다.\n-기록을 관리한다.\n-문제를 해결한다.\n-시간을 준수한다.\n-피드백... 기반으로 40로 평가","execution":"execution는 [음식배달원]\n-주문을 접수한다.\n-음식을 준비한다.\n-배달을 실시한다.\n-고객을 응대한다.\n-안전을 유지한다.\n-기록을 관리한다.\n-문제를 해결한다.\n-시간을 준수한다.\n-피드백... 기반으로 70로 평가","people_facing":"people_facing는 [음식배달원]\n-주문을 접수한다.\n-음식을 준비한다.\n-배달을 실시한다.\n-고객을 응대한다.\n-안전을 유지한다.\n-기록을 관리한다.\n-문제를 해결한다.\n-시간을 준수한다.\n-피드백... 기반으로 75로 평가","degree_required":"degree_required는 [음식배달원]\n-주문을 접수한다.\n-음식을 준비한다.\n-배달을 실시한다.\n-고객을 응대한다.\n-안전을 유지한다.\n-기록을 관리한다.\n-문제를 해결한다.\n-시간을 준수한다.\n-피드백... 기반으로 none로 평가","license_required":"license_required는 [음식배달원]\n-주문을 접수한다.\n-음식을 준비한다.\n-배달을 실시한다.\n-고객을 응대한다.\n-안전을 유지한다.\n-기록을 관리한다.\n-문제를 해결한다.\n-시간을 준수한다.\n-피드백... 기반으로 none로 평가"}'
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
  '176528347686481',
  '자연 및 문화해설사',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 75, 50, 50,
  50, 50, 30, 60, 60, 75,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [자연해설사]\n-자연 현상을 설명한다.\n-관광객을 안내한다.\n-환경 교육을 실시한다.\n-안전을 유지한다.\n-프로그램을 기획한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-법규를 ... 기반으로 50로 평가","growth":"growth는 [자연해설사]\n-자연 현상을 설명한다.\n-관광객을 안내한다.\n-환경 교육을 실시한다.\n-안전을 유지한다.\n-프로그램을 기획한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-법규를 ... 기반으로 75로 평가","stability":"stability는 [자연해설사]\n-자연 현상을 설명한다.\n-관광객을 안내한다.\n-환경 교육을 실시한다.\n-안전을 유지한다.\n-프로그램을 기획한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-법규를 ... 기반으로 50로 평가","income":"income는 [자연해설사]\n-자연 현상을 설명한다.\n-관광객을 안내한다.\n-환경 교육을 실시한다.\n-안전을 유지한다.\n-프로그램을 기획한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-법규를 ... 기반으로 50로 평가","teamwork":"teamwork는 [자연해설사]\n-자연 현상을 설명한다.\n-관광객을 안내한다.\n-환경 교육을 실시한다.\n-안전을 유지한다.\n-프로그램을 기획한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-법규를 ... 기반으로 50로 평가","solo_deep":"solo_deep는 [자연해설사]\n-자연 현상을 설명한다.\n-관광객을 안내한다.\n-환경 교육을 실시한다.\n-안전을 유지한다.\n-프로그램을 기획한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-법규를 ... 기반으로 50로 평가","analytical":"analytical는 [자연해설사]\n-자연 현상을 설명한다.\n-관광객을 안내한다.\n-환경 교육을 실시한다.\n-안전을 유지한다.\n-프로그램을 기획한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-법규를 ... 기반으로 30로 평가","creative":"creative는 [자연해설사]\n-자연 현상을 설명한다.\n-관광객을 안내한다.\n-환경 교육을 실시한다.\n-안전을 유지한다.\n-프로그램을 기획한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-법규를 ... 기반으로 60로 평가","execution":"execution는 [자연해설사]\n-자연 현상을 설명한다.\n-관광객을 안내한다.\n-환경 교육을 실시한다.\n-안전을 유지한다.\n-프로그램을 기획한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-법규를 ... 기반으로 60로 평가","people_facing":"people_facing는 [자연해설사]\n-자연 현상을 설명한다.\n-관광객을 안내한다.\n-환경 교육을 실시한다.\n-안전을 유지한다.\n-프로그램을 기획한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-법규를 ... 기반으로 75로 평가","degree_required":"degree_required는 [자연해설사]\n-자연 현상을 설명한다.\n-관광객을 안내한다.\n-환경 교육을 실시한다.\n-안전을 유지한다.\n-프로그램을 기획한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-법규를 ... 기반으로 none로 평가","license_required":"license_required는 [자연해설사]\n-자연 현상을 설명한다.\n-관광객을 안내한다.\n-환경 교육을 실시한다.\n-안전을 유지한다.\n-프로그램을 기획한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-법규를 ... 기반으로 none로 평가"}'
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
  '1765283470379750',
  '패션소품디자이너',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 50, 40,
  50, 50, 50, 50, 50, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [패션소품디자이너]\n-패션 소품을 디자인한다.\n-트렌드를 분석한다.\n-스케치를 그린다.\n-프로토타입을 만든다.\n-재료를 선택한다.\n-생산을 감독한다.\n-시장 조사를 실시한다.\n-클... 기반으로 50로 평가","growth":"growth는 [패션소품디자이너]\n-패션 소품을 디자인한다.\n-트렌드를 분석한다.\n-스케치를 그린다.\n-프로토타입을 만든다.\n-재료를 선택한다.\n-생산을 감독한다.\n-시장 조사를 실시한다.\n-클... 기반으로 65로 평가","stability":"stability는 [패션소품디자이너]\n-패션 소품을 디자인한다.\n-트렌드를 분석한다.\n-스케치를 그린다.\n-프로토타입을 만든다.\n-재료를 선택한다.\n-생산을 감독한다.\n-시장 조사를 실시한다.\n-클... 기반으로 50로 평가","income":"income는 [패션소품디자이너]\n-패션 소품을 디자인한다.\n-트렌드를 분석한다.\n-스케치를 그린다.\n-프로토타입을 만든다.\n-재료를 선택한다.\n-생산을 감독한다.\n-시장 조사를 실시한다.\n-클... 기반으로 40로 평가","teamwork":"teamwork는 [패션소품디자이너]\n-패션 소품을 디자인한다.\n-트렌드를 분석한다.\n-스케치를 그린다.\n-프로토타입을 만든다.\n-재료를 선택한다.\n-생산을 감독한다.\n-시장 조사를 실시한다.\n-클... 기반으로 50로 평가","solo_deep":"solo_deep는 [패션소품디자이너]\n-패션 소품을 디자인한다.\n-트렌드를 분석한다.\n-스케치를 그린다.\n-프로토타입을 만든다.\n-재료를 선택한다.\n-생산을 감독한다.\n-시장 조사를 실시한다.\n-클... 기반으로 50로 평가","analytical":"analytical는 [패션소품디자이너]\n-패션 소품을 디자인한다.\n-트렌드를 분석한다.\n-스케치를 그린다.\n-프로토타입을 만든다.\n-재료를 선택한다.\n-생산을 감독한다.\n-시장 조사를 실시한다.\n-클... 기반으로 50로 평가","creative":"creative는 [패션소품디자이너]\n-패션 소품을 디자인한다.\n-트렌드를 분석한다.\n-스케치를 그린다.\n-프로토타입을 만든다.\n-재료를 선택한다.\n-생산을 감독한다.\n-시장 조사를 실시한다.\n-클... 기반으로 50로 평가","execution":"execution는 [패션소품디자이너]\n-패션 소품을 디자인한다.\n-트렌드를 분석한다.\n-스케치를 그린다.\n-프로토타입을 만든다.\n-재료를 선택한다.\n-생산을 감독한다.\n-시장 조사를 실시한다.\n-클... 기반으로 50로 평가","people_facing":"people_facing는 [패션소품디자이너]\n-패션 소품을 디자인한다.\n-트렌드를 분석한다.\n-스케치를 그린다.\n-프로토타입을 만든다.\n-재료를 선택한다.\n-생산을 감독한다.\n-시장 조사를 실시한다.\n-클... 기반으로 50로 평가","degree_required":"degree_required는 [패션소품디자이너]\n-패션 소품을 디자인한다.\n-트렌드를 분석한다.\n-스케치를 그린다.\n-프로토타입을 만든다.\n-재료를 선택한다.\n-생산을 감독한다.\n-시장 조사를 실시한다.\n-클... 기반으로 none로 평가","license_required":"license_required는 [패션소품디자이너]\n-패션 소품을 디자인한다.\n-트렌드를 분석한다.\n-스케치를 그린다.\n-프로토타입을 만든다.\n-재료를 선택한다.\n-생산을 감독한다.\n-시장 조사를 실시한다.\n-클... 기반으로 none로 평가"}'
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
  '176528341541716',
  '관세행정사무원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 70, 50,
  50, 50, 60, 30, 60, 75,
  'regular', 'none', 'none', 'partial',
  'bachelor', 'required', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [관세행정사무원]\n-관세 신고를 접수한다.\n-서류를 검토한다.\n-관세를 계산한다.\n-검사를 실시한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-상담을 제공한다... 기반으로 50로 평가","growth":"growth는 [관세행정사무원]\n-관세 신고를 접수한다.\n-서류를 검토한다.\n-관세를 계산한다.\n-검사를 실시한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-상담을 제공한다... 기반으로 50로 평가","stability":"stability는 [관세행정사무원]\n-관세 신고를 접수한다.\n-서류를 검토한다.\n-관세를 계산한다.\n-검사를 실시한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-상담을 제공한다... 기반으로 70로 평가","income":"income는 [관세행정사무원]\n-관세 신고를 접수한다.\n-서류를 검토한다.\n-관세를 계산한다.\n-검사를 실시한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-상담을 제공한다... 기반으로 50로 평가","teamwork":"teamwork는 [관세행정사무원]\n-관세 신고를 접수한다.\n-서류를 검토한다.\n-관세를 계산한다.\n-검사를 실시한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-상담을 제공한다... 기반으로 50로 평가","solo_deep":"solo_deep는 [관세행정사무원]\n-관세 신고를 접수한다.\n-서류를 검토한다.\n-관세를 계산한다.\n-검사를 실시한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-상담을 제공한다... 기반으로 50로 평가","analytical":"analytical는 [관세행정사무원]\n-관세 신고를 접수한다.\n-서류를 검토한다.\n-관세를 계산한다.\n-검사를 실시한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-상담을 제공한다... 기반으로 60로 평가","creative":"creative는 [관세행정사무원]\n-관세 신고를 접수한다.\n-서류를 검토한다.\n-관세를 계산한다.\n-검사를 실시한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-상담을 제공한다... 기반으로 30로 평가","execution":"execution는 [관세행정사무원]\n-관세 신고를 접수한다.\n-서류를 검토한다.\n-관세를 계산한다.\n-검사를 실시한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-상담을 제공한다... 기반으로 60로 평가","people_facing":"people_facing는 [관세행정사무원]\n-관세 신고를 접수한다.\n-서류를 검토한다.\n-관세를 계산한다.\n-검사를 실시한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-상담을 제공한다... 기반으로 75로 평가","degree_required":"degree_required는 [관세행정사무원]\n-관세 신고를 접수한다.\n-서류를 검토한다.\n-관세를 계산한다.\n-검사를 실시한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-상담을 제공한다... 기반으로 bachelor로 평가","license_required":"license_required는 [관세행정사무원]\n-관세 신고를 접수한다.\n-서류를 검토한다.\n-관세를 계산한다.\n-검사를 실시한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-상담을 제공한다... 기반으로 required로 평가"}'
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