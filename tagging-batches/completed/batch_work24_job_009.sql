-- Batch tagging SQL generated at 2026-01-06T07:04:09.041Z
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
  '1765283471246882',
  '실내장식디자이너',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 50, 40,
  50, 50, 50, 50, 50, 60,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [실내장식디자이너]\n-공간을 분석한다.\n-콘셉트를 개발한다.\n-레이아웃을 설계한다.\n-색상을 선택한다.\n-가구를 배치한다.\n-조명을 계획한다.\n-재료를 선정한다.\n-시공을 감독한다... 기반으로 50로 평가","growth":"growth는 [실내장식디자이너]\n-공간을 분석한다.\n-콘셉트를 개발한다.\n-레이아웃을 설계한다.\n-색상을 선택한다.\n-가구를 배치한다.\n-조명을 계획한다.\n-재료를 선정한다.\n-시공을 감독한다... 기반으로 65로 평가","stability":"stability는 [실내장식디자이너]\n-공간을 분석한다.\n-콘셉트를 개발한다.\n-레이아웃을 설계한다.\n-색상을 선택한다.\n-가구를 배치한다.\n-조명을 계획한다.\n-재료를 선정한다.\n-시공을 감독한다... 기반으로 50로 평가","income":"income는 [실내장식디자이너]\n-공간을 분석한다.\n-콘셉트를 개발한다.\n-레이아웃을 설계한다.\n-색상을 선택한다.\n-가구를 배치한다.\n-조명을 계획한다.\n-재료를 선정한다.\n-시공을 감독한다... 기반으로 40로 평가","teamwork":"teamwork는 [실내장식디자이너]\n-공간을 분석한다.\n-콘셉트를 개발한다.\n-레이아웃을 설계한다.\n-색상을 선택한다.\n-가구를 배치한다.\n-조명을 계획한다.\n-재료를 선정한다.\n-시공을 감독한다... 기반으로 50로 평가","solo_deep":"solo_deep는 [실내장식디자이너]\n-공간을 분석한다.\n-콘셉트를 개발한다.\n-레이아웃을 설계한다.\n-색상을 선택한다.\n-가구를 배치한다.\n-조명을 계획한다.\n-재료를 선정한다.\n-시공을 감독한다... 기반으로 50로 평가","analytical":"analytical는 [실내장식디자이너]\n-공간을 분석한다.\n-콘셉트를 개발한다.\n-레이아웃을 설계한다.\n-색상을 선택한다.\n-가구를 배치한다.\n-조명을 계획한다.\n-재료를 선정한다.\n-시공을 감독한다... 기반으로 50로 평가","creative":"creative는 [실내장식디자이너]\n-공간을 분석한다.\n-콘셉트를 개발한다.\n-레이아웃을 설계한다.\n-색상을 선택한다.\n-가구를 배치한다.\n-조명을 계획한다.\n-재료를 선정한다.\n-시공을 감독한다... 기반으로 50로 평가","execution":"execution는 [실내장식디자이너]\n-공간을 분석한다.\n-콘셉트를 개발한다.\n-레이아웃을 설계한다.\n-색상을 선택한다.\n-가구를 배치한다.\n-조명을 계획한다.\n-재료를 선정한다.\n-시공을 감독한다... 기반으로 50로 평가","people_facing":"people_facing는 [실내장식디자이너]\n-공간을 분석한다.\n-콘셉트를 개발한다.\n-레이아웃을 설계한다.\n-색상을 선택한다.\n-가구를 배치한다.\n-조명을 계획한다.\n-재료를 선정한다.\n-시공을 감독한다... 기반으로 60로 평가","degree_required":"degree_required는 [실내장식디자이너]\n-공간을 분석한다.\n-콘셉트를 개발한다.\n-레이아웃을 설계한다.\n-색상을 선택한다.\n-가구를 배치한다.\n-조명을 계획한다.\n-재료를 선정한다.\n-시공을 감독한다... 기반으로 none로 평가","license_required":"license_required는 [실내장식디자이너]\n-공간을 분석한다.\n-콘셉트를 개발한다.\n-레이아웃을 설계한다.\n-색상을 선택한다.\n-가구를 배치한다.\n-조명을 계획한다.\n-재료를 선정한다.\n-시공을 감독한다... 기반으로 none로 평가"}'
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
  '1765283477441606',
  '여행사무원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 50, 50,
  50, 50, 60, 60, 30, 75,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [여행사무원]\n-여행 상품을 기획한다.\n-예약을 접수한다.\n-항공권을 발권한다.\n-호텔을 예약한다.\n-관광지를 안내한다.\n-비자를 준비한다.\n-고객을 상담한다.\n-문제를 해결한다.... 기반으로 50로 평가","growth":"growth는 [여행사무원]\n-여행 상품을 기획한다.\n-예약을 접수한다.\n-항공권을 발권한다.\n-호텔을 예약한다.\n-관광지를 안내한다.\n-비자를 준비한다.\n-고객을 상담한다.\n-문제를 해결한다.... 기반으로 65로 평가","stability":"stability는 [여행사무원]\n-여행 상품을 기획한다.\n-예약을 접수한다.\n-항공권을 발권한다.\n-호텔을 예약한다.\n-관광지를 안내한다.\n-비자를 준비한다.\n-고객을 상담한다.\n-문제를 해결한다.... 기반으로 50로 평가","income":"income는 [여행사무원]\n-여행 상품을 기획한다.\n-예약을 접수한다.\n-항공권을 발권한다.\n-호텔을 예약한다.\n-관광지를 안내한다.\n-비자를 준비한다.\n-고객을 상담한다.\n-문제를 해결한다.... 기반으로 50로 평가","teamwork":"teamwork는 [여행사무원]\n-여행 상품을 기획한다.\n-예약을 접수한다.\n-항공권을 발권한다.\n-호텔을 예약한다.\n-관광지를 안내한다.\n-비자를 준비한다.\n-고객을 상담한다.\n-문제를 해결한다.... 기반으로 50로 평가","solo_deep":"solo_deep는 [여행사무원]\n-여행 상품을 기획한다.\n-예약을 접수한다.\n-항공권을 발권한다.\n-호텔을 예약한다.\n-관광지를 안내한다.\n-비자를 준비한다.\n-고객을 상담한다.\n-문제를 해결한다.... 기반으로 50로 평가","analytical":"analytical는 [여행사무원]\n-여행 상품을 기획한다.\n-예약을 접수한다.\n-항공권을 발권한다.\n-호텔을 예약한다.\n-관광지를 안내한다.\n-비자를 준비한다.\n-고객을 상담한다.\n-문제를 해결한다.... 기반으로 60로 평가","creative":"creative는 [여행사무원]\n-여행 상품을 기획한다.\n-예약을 접수한다.\n-항공권을 발권한다.\n-호텔을 예약한다.\n-관광지를 안내한다.\n-비자를 준비한다.\n-고객을 상담한다.\n-문제를 해결한다.... 기반으로 60로 평가","execution":"execution는 [여행사무원]\n-여행 상품을 기획한다.\n-예약을 접수한다.\n-항공권을 발권한다.\n-호텔을 예약한다.\n-관광지를 안내한다.\n-비자를 준비한다.\n-고객을 상담한다.\n-문제를 해결한다.... 기반으로 30로 평가","people_facing":"people_facing는 [여행사무원]\n-여행 상품을 기획한다.\n-예약을 접수한다.\n-항공권을 발권한다.\n-호텔을 예약한다.\n-관광지를 안내한다.\n-비자를 준비한다.\n-고객을 상담한다.\n-문제를 해결한다.... 기반으로 75로 평가","degree_required":"degree_required는 [여행사무원]\n-여행 상품을 기획한다.\n-예약을 접수한다.\n-항공권을 발권한다.\n-호텔을 예약한다.\n-관광지를 안내한다.\n-비자를 준비한다.\n-고객을 상담한다.\n-문제를 해결한다.... 기반으로 none로 평가","license_required":"license_required는 [여행사무원]\n-여행 상품을 기획한다.\n-예약을 접수한다.\n-항공권을 발권한다.\n-호텔을 예약한다.\n-관광지를 안내한다.\n-비자를 준비한다.\n-고객을 상담한다.\n-문제를 해결한다.... 기반으로 none로 평가"}'
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
  '1765283414045777',
  '경영·진단전문가',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 60, 70, 50,
  50, 50, 60, 30, 60, 50,
  'regular', 'none', 'none', 'partial',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [경영컨설턴트]\n-기업 진단을 실시한다.\n-경영 전략을 수립한다.\n-프로세스를 개선한다.\n-시스템을 구축한다.\n-교육을 실시한다.\n-성과를 측정한다.\n-보고서를 작성한다.\n-프로젝... 기반으로 50로 평가","growth":"growth는 [경영컨설턴트]\n-기업 진단을 실시한다.\n-경영 전략을 수립한다.\n-프로세스를 개선한다.\n-시스템을 구축한다.\n-교육을 실시한다.\n-성과를 측정한다.\n-보고서를 작성한다.\n-프로젝... 기반으로 60로 평가","stability":"stability는 [경영컨설턴트]\n-기업 진단을 실시한다.\n-경영 전략을 수립한다.\n-프로세스를 개선한다.\n-시스템을 구축한다.\n-교육을 실시한다.\n-성과를 측정한다.\n-보고서를 작성한다.\n-프로젝... 기반으로 70로 평가","income":"income는 [경영컨설턴트]\n-기업 진단을 실시한다.\n-경영 전략을 수립한다.\n-프로세스를 개선한다.\n-시스템을 구축한다.\n-교육을 실시한다.\n-성과를 측정한다.\n-보고서를 작성한다.\n-프로젝... 기반으로 50로 평가","teamwork":"teamwork는 [경영컨설턴트]\n-기업 진단을 실시한다.\n-경영 전략을 수립한다.\n-프로세스를 개선한다.\n-시스템을 구축한다.\n-교육을 실시한다.\n-성과를 측정한다.\n-보고서를 작성한다.\n-프로젝... 기반으로 50로 평가","solo_deep":"solo_deep는 [경영컨설턴트]\n-기업 진단을 실시한다.\n-경영 전략을 수립한다.\n-프로세스를 개선한다.\n-시스템을 구축한다.\n-교육을 실시한다.\n-성과를 측정한다.\n-보고서를 작성한다.\n-프로젝... 기반으로 50로 평가","analytical":"analytical는 [경영컨설턴트]\n-기업 진단을 실시한다.\n-경영 전략을 수립한다.\n-프로세스를 개선한다.\n-시스템을 구축한다.\n-교육을 실시한다.\n-성과를 측정한다.\n-보고서를 작성한다.\n-프로젝... 기반으로 60로 평가","creative":"creative는 [경영컨설턴트]\n-기업 진단을 실시한다.\n-경영 전략을 수립한다.\n-프로세스를 개선한다.\n-시스템을 구축한다.\n-교육을 실시한다.\n-성과를 측정한다.\n-보고서를 작성한다.\n-프로젝... 기반으로 30로 평가","execution":"execution는 [경영컨설턴트]\n-기업 진단을 실시한다.\n-경영 전략을 수립한다.\n-프로세스를 개선한다.\n-시스템을 구축한다.\n-교육을 실시한다.\n-성과를 측정한다.\n-보고서를 작성한다.\n-프로젝... 기반으로 60로 평가","people_facing":"people_facing는 [경영컨설턴트]\n-기업 진단을 실시한다.\n-경영 전략을 수립한다.\n-프로세스를 개선한다.\n-시스템을 구축한다.\n-교육을 실시한다.\n-성과를 측정한다.\n-보고서를 작성한다.\n-프로젝... 기반으로 50로 평가","degree_required":"degree_required는 [경영컨설턴트]\n-기업 진단을 실시한다.\n-경영 전략을 수립한다.\n-프로세스를 개선한다.\n-시스템을 구축한다.\n-교육을 실시한다.\n-성과를 측정한다.\n-보고서를 작성한다.\n-프로젝... 기반으로 none로 평가","license_required":"license_required는 [경영컨설턴트]\n-기업 진단을 실시한다.\n-경영 전략을 수립한다.\n-프로세스를 개선한다.\n-시스템을 구축한다.\n-교육을 실시한다.\n-성과를 측정한다.\n-보고서를 작성한다.\n-프로젝... 기반으로 none로 평가"}'
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
  '1765283418119932',
  '총무사무원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  70, 30, 40, 40, 70, 50,
  'regular', 'none', 'none', 'partial',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [총무사무원]\n-행정 업무를 처리한다.\n-문서를 관리한다.\n-회의를 준비한다.\n-비품을 관리한다.\n-시설을 유지한다.\n-계약을 관리한다.\n-보고서를 작성한다.\n-예산을 관리한다.\n... 기반으로 50로 평가","growth":"growth는 [총무사무원]\n-행정 업무를 처리한다.\n-문서를 관리한다.\n-회의를 준비한다.\n-비품을 관리한다.\n-시설을 유지한다.\n-계약을 관리한다.\n-보고서를 작성한다.\n-예산을 관리한다.\n... 기반으로 50로 평가","stability":"stability는 [총무사무원]\n-행정 업무를 처리한다.\n-문서를 관리한다.\n-회의를 준비한다.\n-비품을 관리한다.\n-시설을 유지한다.\n-계약을 관리한다.\n-보고서를 작성한다.\n-예산을 관리한다.\n... 기반으로 50로 평가","income":"income는 [총무사무원]\n-행정 업무를 처리한다.\n-문서를 관리한다.\n-회의를 준비한다.\n-비품을 관리한다.\n-시설을 유지한다.\n-계약을 관리한다.\n-보고서를 작성한다.\n-예산을 관리한다.\n... 기반으로 50로 평가","teamwork":"teamwork는 [총무사무원]\n-행정 업무를 처리한다.\n-문서를 관리한다.\n-회의를 준비한다.\n-비품을 관리한다.\n-시설을 유지한다.\n-계약을 관리한다.\n-보고서를 작성한다.\n-예산을 관리한다.\n... 기반으로 70로 평가","solo_deep":"solo_deep는 [총무사무원]\n-행정 업무를 처리한다.\n-문서를 관리한다.\n-회의를 준비한다.\n-비품을 관리한다.\n-시설을 유지한다.\n-계약을 관리한다.\n-보고서를 작성한다.\n-예산을 관리한다.\n... 기반으로 30로 평가","analytical":"analytical는 [총무사무원]\n-행정 업무를 처리한다.\n-문서를 관리한다.\n-회의를 준비한다.\n-비품을 관리한다.\n-시설을 유지한다.\n-계약을 관리한다.\n-보고서를 작성한다.\n-예산을 관리한다.\n... 기반으로 40로 평가","creative":"creative는 [총무사무원]\n-행정 업무를 처리한다.\n-문서를 관리한다.\n-회의를 준비한다.\n-비품을 관리한다.\n-시설을 유지한다.\n-계약을 관리한다.\n-보고서를 작성한다.\n-예산을 관리한다.\n... 기반으로 40로 평가","execution":"execution는 [총무사무원]\n-행정 업무를 처리한다.\n-문서를 관리한다.\n-회의를 준비한다.\n-비품을 관리한다.\n-시설을 유지한다.\n-계약을 관리한다.\n-보고서를 작성한다.\n-예산을 관리한다.\n... 기반으로 70로 평가","people_facing":"people_facing는 [총무사무원]\n-행정 업무를 처리한다.\n-문서를 관리한다.\n-회의를 준비한다.\n-비품을 관리한다.\n-시설을 유지한다.\n-계약을 관리한다.\n-보고서를 작성한다.\n-예산을 관리한다.\n... 기반으로 50로 평가","degree_required":"degree_required는 [총무사무원]\n-행정 업무를 처리한다.\n-문서를 관리한다.\n-회의를 준비한다.\n-비품을 관리한다.\n-시설을 유지한다.\n-계약을 관리한다.\n-보고서를 작성한다.\n-예산을 관리한다.\n... 기반으로 none로 평가","license_required":"license_required는 [총무사무원]\n-행정 업무를 처리한다.\n-문서를 관리한다.\n-회의를 준비한다.\n-비품을 관리한다.\n-시설을 유지한다.\n-계약을 관리한다.\n-보고서를 작성한다.\n-예산을 관리한다.\n... 기반으로 none로 평가"}'
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
  '1765283422140793',
  '철도·지하철운송사무원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  50, 50, 40, 40, 70, 75,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [철도운송사무원]\n-열차 스케줄을 관리한다.\n-승차권을 발매한다.\n-승객을 안내한다.\n-화물을 처리한다.\n-안전 수칙을 준수한다.\n-문제를 해결한다.\n-보고서를 작성한다.\n-시스템... 기반으로 50로 평가","growth":"growth는 [철도운송사무원]\n-열차 스케줄을 관리한다.\n-승차권을 발매한다.\n-승객을 안내한다.\n-화물을 처리한다.\n-안전 수칙을 준수한다.\n-문제를 해결한다.\n-보고서를 작성한다.\n-시스템... 기반으로 50로 평가","stability":"stability는 [철도운송사무원]\n-열차 스케줄을 관리한다.\n-승차권을 발매한다.\n-승객을 안내한다.\n-화물을 처리한다.\n-안전 수칙을 준수한다.\n-문제를 해결한다.\n-보고서를 작성한다.\n-시스템... 기반으로 50로 평가","income":"income는 [철도운송사무원]\n-열차 스케줄을 관리한다.\n-승차권을 발매한다.\n-승객을 안내한다.\n-화물을 처리한다.\n-안전 수칙을 준수한다.\n-문제를 해결한다.\n-보고서를 작성한다.\n-시스템... 기반으로 50로 평가","teamwork":"teamwork는 [철도운송사무원]\n-열차 스케줄을 관리한다.\n-승차권을 발매한다.\n-승객을 안내한다.\n-화물을 처리한다.\n-안전 수칙을 준수한다.\n-문제를 해결한다.\n-보고서를 작성한다.\n-시스템... 기반으로 50로 평가","solo_deep":"solo_deep는 [철도운송사무원]\n-열차 스케줄을 관리한다.\n-승차권을 발매한다.\n-승객을 안내한다.\n-화물을 처리한다.\n-안전 수칙을 준수한다.\n-문제를 해결한다.\n-보고서를 작성한다.\n-시스템... 기반으로 50로 평가","analytical":"analytical는 [철도운송사무원]\n-열차 스케줄을 관리한다.\n-승차권을 발매한다.\n-승객을 안내한다.\n-화물을 처리한다.\n-안전 수칙을 준수한다.\n-문제를 해결한다.\n-보고서를 작성한다.\n-시스템... 기반으로 40로 평가","creative":"creative는 [철도운송사무원]\n-열차 스케줄을 관리한다.\n-승차권을 발매한다.\n-승객을 안내한다.\n-화물을 처리한다.\n-안전 수칙을 준수한다.\n-문제를 해결한다.\n-보고서를 작성한다.\n-시스템... 기반으로 40로 평가","execution":"execution는 [철도운송사무원]\n-열차 스케줄을 관리한다.\n-승차권을 발매한다.\n-승객을 안내한다.\n-화물을 처리한다.\n-안전 수칙을 준수한다.\n-문제를 해결한다.\n-보고서를 작성한다.\n-시스템... 기반으로 70로 평가","people_facing":"people_facing는 [철도운송사무원]\n-열차 스케줄을 관리한다.\n-승차권을 발매한다.\n-승객을 안내한다.\n-화물을 처리한다.\n-안전 수칙을 준수한다.\n-문제를 해결한다.\n-보고서를 작성한다.\n-시스템... 기반으로 75로 평가","degree_required":"degree_required는 [철도운송사무원]\n-열차 스케줄을 관리한다.\n-승차권을 발매한다.\n-승객을 안내한다.\n-화물을 처리한다.\n-안전 수칙을 준수한다.\n-문제를 해결한다.\n-보고서를 작성한다.\n-시스템... 기반으로 none로 평가","license_required":"license_required는 [철도운송사무원]\n-열차 스케줄을 관리한다.\n-승차권을 발매한다.\n-승객을 안내한다.\n-화물을 처리한다.\n-안전 수칙을 준수한다.\n-문제를 해결한다.\n-보고서를 작성한다.\n-시스템... 기반으로 none로 평가"}'
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
  '1765283496709939',
  '단열공',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  50, 50, 40, 40, 70, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [단열공]\n-단열 재료를 준비한다.\n-표면을 청소한다.\n-단열재를 설치한다.\n-기밀을 유지한다.\n-단열 효과를 검사한다.\n-마무리를 한다.\n-안전 수칙을 준수한다.\n-장비를 관리한... 기반으로 50로 평가","growth":"growth는 [단열공]\n-단열 재료를 준비한다.\n-표면을 청소한다.\n-단열재를 설치한다.\n-기밀을 유지한다.\n-단열 효과를 검사한다.\n-마무리를 한다.\n-안전 수칙을 준수한다.\n-장비를 관리한... 기반으로 50로 평가","stability":"stability는 [단열공]\n-단열 재료를 준비한다.\n-표면을 청소한다.\n-단열재를 설치한다.\n-기밀을 유지한다.\n-단열 효과를 검사한다.\n-마무리를 한다.\n-안전 수칙을 준수한다.\n-장비를 관리한... 기반으로 50로 평가","income":"income는 [단열공]\n-단열 재료를 준비한다.\n-표면을 청소한다.\n-단열재를 설치한다.\n-기밀을 유지한다.\n-단열 효과를 검사한다.\n-마무리를 한다.\n-안전 수칙을 준수한다.\n-장비를 관리한... 기반으로 50로 평가","teamwork":"teamwork는 [단열공]\n-단열 재료를 준비한다.\n-표면을 청소한다.\n-단열재를 설치한다.\n-기밀을 유지한다.\n-단열 효과를 검사한다.\n-마무리를 한다.\n-안전 수칙을 준수한다.\n-장비를 관리한... 기반으로 50로 평가","solo_deep":"solo_deep는 [단열공]\n-단열 재료를 준비한다.\n-표면을 청소한다.\n-단열재를 설치한다.\n-기밀을 유지한다.\n-단열 효과를 검사한다.\n-마무리를 한다.\n-안전 수칙을 준수한다.\n-장비를 관리한... 기반으로 50로 평가","analytical":"analytical는 [단열공]\n-단열 재료를 준비한다.\n-표면을 청소한다.\n-단열재를 설치한다.\n-기밀을 유지한다.\n-단열 효과를 검사한다.\n-마무리를 한다.\n-안전 수칙을 준수한다.\n-장비를 관리한... 기반으로 40로 평가","creative":"creative는 [단열공]\n-단열 재료를 준비한다.\n-표면을 청소한다.\n-단열재를 설치한다.\n-기밀을 유지한다.\n-단열 효과를 검사한다.\n-마무리를 한다.\n-안전 수칙을 준수한다.\n-장비를 관리한... 기반으로 40로 평가","execution":"execution는 [단열공]\n-단열 재료를 준비한다.\n-표면을 청소한다.\n-단열재를 설치한다.\n-기밀을 유지한다.\n-단열 효과를 검사한다.\n-마무리를 한다.\n-안전 수칙을 준수한다.\n-장비를 관리한... 기반으로 70로 평가","people_facing":"people_facing는 [단열공]\n-단열 재료를 준비한다.\n-표면을 청소한다.\n-단열재를 설치한다.\n-기밀을 유지한다.\n-단열 효과를 검사한다.\n-마무리를 한다.\n-안전 수칙을 준수한다.\n-장비를 관리한... 기반으로 50로 평가","degree_required":"degree_required는 [단열공]\n-단열 재료를 준비한다.\n-표면을 청소한다.\n-단열재를 설치한다.\n-기밀을 유지한다.\n-단열 효과를 검사한다.\n-마무리를 한다.\n-안전 수칙을 준수한다.\n-장비를 관리한... 기반으로 none로 평가","license_required":"license_required는 [단열공]\n-단열 재료를 준비한다.\n-표면을 청소한다.\n-단열재를 설치한다.\n-기밀을 유지한다.\n-단열 효과를 검사한다.\n-마무리를 한다.\n-안전 수칙을 준수한다.\n-장비를 관리한... 기반으로 none로 평가"}'
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
  '1765283493607565',
  '집배원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  50, 50, 40, 40, 70, 75,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [집배원]\n-우편물을 분류한다.\n-배달 경로를 계획한다.\n-우편물을 배달한다.\n-등기 우편을 처리한다.\n-고객을 응대한다.\n-기록을 관리한다.\n-안전을 유지한다.\n-문제를 해결한다... 기반으로 50로 평가","growth":"growth는 [집배원]\n-우편물을 분류한다.\n-배달 경로를 계획한다.\n-우편물을 배달한다.\n-등기 우편을 처리한다.\n-고객을 응대한다.\n-기록을 관리한다.\n-안전을 유지한다.\n-문제를 해결한다... 기반으로 50로 평가","stability":"stability는 [집배원]\n-우편물을 분류한다.\n-배달 경로를 계획한다.\n-우편물을 배달한다.\n-등기 우편을 처리한다.\n-고객을 응대한다.\n-기록을 관리한다.\n-안전을 유지한다.\n-문제를 해결한다... 기반으로 50로 평가","income":"income는 [집배원]\n-우편물을 분류한다.\n-배달 경로를 계획한다.\n-우편물을 배달한다.\n-등기 우편을 처리한다.\n-고객을 응대한다.\n-기록을 관리한다.\n-안전을 유지한다.\n-문제를 해결한다... 기반으로 50로 평가","teamwork":"teamwork는 [집배원]\n-우편물을 분류한다.\n-배달 경로를 계획한다.\n-우편물을 배달한다.\n-등기 우편을 처리한다.\n-고객을 응대한다.\n-기록을 관리한다.\n-안전을 유지한다.\n-문제를 해결한다... 기반으로 50로 평가","solo_deep":"solo_deep는 [집배원]\n-우편물을 분류한다.\n-배달 경로를 계획한다.\n-우편물을 배달한다.\n-등기 우편을 처리한다.\n-고객을 응대한다.\n-기록을 관리한다.\n-안전을 유지한다.\n-문제를 해결한다... 기반으로 50로 평가","analytical":"analytical는 [집배원]\n-우편물을 분류한다.\n-배달 경로를 계획한다.\n-우편물을 배달한다.\n-등기 우편을 처리한다.\n-고객을 응대한다.\n-기록을 관리한다.\n-안전을 유지한다.\n-문제를 해결한다... 기반으로 40로 평가","creative":"creative는 [집배원]\n-우편물을 분류한다.\n-배달 경로를 계획한다.\n-우편물을 배달한다.\n-등기 우편을 처리한다.\n-고객을 응대한다.\n-기록을 관리한다.\n-안전을 유지한다.\n-문제를 해결한다... 기반으로 40로 평가","execution":"execution는 [집배원]\n-우편물을 분류한다.\n-배달 경로를 계획한다.\n-우편물을 배달한다.\n-등기 우편을 처리한다.\n-고객을 응대한다.\n-기록을 관리한다.\n-안전을 유지한다.\n-문제를 해결한다... 기반으로 70로 평가","people_facing":"people_facing는 [집배원]\n-우편물을 분류한다.\n-배달 경로를 계획한다.\n-우편물을 배달한다.\n-등기 우편을 처리한다.\n-고객을 응대한다.\n-기록을 관리한다.\n-안전을 유지한다.\n-문제를 해결한다... 기반으로 75로 평가","degree_required":"degree_required는 [집배원]\n-우편물을 분류한다.\n-배달 경로를 계획한다.\n-우편물을 배달한다.\n-등기 우편을 처리한다.\n-고객을 응대한다.\n-기록을 관리한다.\n-안전을 유지한다.\n-문제를 해결한다... 기반으로 none로 평가","license_required":"license_required는 [집배원]\n-우편물을 분류한다.\n-배달 경로를 계획한다.\n-우편물을 배달한다.\n-등기 우편을 처리한다.\n-고객을 응대한다.\n-기록을 관리한다.\n-안전을 유지한다.\n-문제를 해결한다... 기반으로 none로 평가"}'
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
  '1765283432443693',
  '축산학 및 수의학연구원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  40, 75, 50, 70,
  50, 50, 60, 60, 30, 35,
  'overtime_some', 'none', 'some', 'none',
  'master', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [축산학연구원]\n-축산 기술을 연구한다.\n-사료를 개발한다.\n-축산물을 개선한다.\n-병충해 방제를 연구한다.\n-실험을 설계한다.\n-데이터를 수집한다.\n-보고서를 작성한다.\n-현장을... 기반으로 40로 평가","growth":"growth는 [축산학연구원]\n-축산 기술을 연구한다.\n-사료를 개발한다.\n-축산물을 개선한다.\n-병충해 방제를 연구한다.\n-실험을 설계한다.\n-데이터를 수집한다.\n-보고서를 작성한다.\n-현장을... 기반으로 75로 평가","stability":"stability는 [축산학연구원]\n-축산 기술을 연구한다.\n-사료를 개발한다.\n-축산물을 개선한다.\n-병충해 방제를 연구한다.\n-실험을 설계한다.\n-데이터를 수집한다.\n-보고서를 작성한다.\n-현장을... 기반으로 50로 평가","income":"income는 [축산학연구원]\n-축산 기술을 연구한다.\n-사료를 개발한다.\n-축산물을 개선한다.\n-병충해 방제를 연구한다.\n-실험을 설계한다.\n-데이터를 수집한다.\n-보고서를 작성한다.\n-현장을... 기반으로 70로 평가","teamwork":"teamwork는 [축산학연구원]\n-축산 기술을 연구한다.\n-사료를 개발한다.\n-축산물을 개선한다.\n-병충해 방제를 연구한다.\n-실험을 설계한다.\n-데이터를 수집한다.\n-보고서를 작성한다.\n-현장을... 기반으로 50로 평가","solo_deep":"solo_deep는 [축산학연구원]\n-축산 기술을 연구한다.\n-사료를 개발한다.\n-축산물을 개선한다.\n-병충해 방제를 연구한다.\n-실험을 설계한다.\n-데이터를 수집한다.\n-보고서를 작성한다.\n-현장을... 기반으로 50로 평가","analytical":"analytical는 [축산학연구원]\n-축산 기술을 연구한다.\n-사료를 개발한다.\n-축산물을 개선한다.\n-병충해 방제를 연구한다.\n-실험을 설계한다.\n-데이터를 수집한다.\n-보고서를 작성한다.\n-현장을... 기반으로 60로 평가","creative":"creative는 [축산학연구원]\n-축산 기술을 연구한다.\n-사료를 개발한다.\n-축산물을 개선한다.\n-병충해 방제를 연구한다.\n-실험을 설계한다.\n-데이터를 수집한다.\n-보고서를 작성한다.\n-현장을... 기반으로 60로 평가","execution":"execution는 [축산학연구원]\n-축산 기술을 연구한다.\n-사료를 개발한다.\n-축산물을 개선한다.\n-병충해 방제를 연구한다.\n-실험을 설계한다.\n-데이터를 수집한다.\n-보고서를 작성한다.\n-현장을... 기반으로 30로 평가","people_facing":"people_facing는 [축산학연구원]\n-축산 기술을 연구한다.\n-사료를 개발한다.\n-축산물을 개선한다.\n-병충해 방제를 연구한다.\n-실험을 설계한다.\n-데이터를 수집한다.\n-보고서를 작성한다.\n-현장을... 기반으로 35로 평가","degree_required":"degree_required는 [축산학연구원]\n-축산 기술을 연구한다.\n-사료를 개발한다.\n-축산물을 개선한다.\n-병충해 방제를 연구한다.\n-실험을 설계한다.\n-데이터를 수집한다.\n-보고서를 작성한다.\n-현장을... 기반으로 master로 평가","license_required":"license_required는 [축산학연구원]\n-축산 기술을 연구한다.\n-사료를 개발한다.\n-축산물을 개선한다.\n-병충해 방제를 연구한다.\n-실험을 설계한다.\n-데이터를 수집한다.\n-보고서를 작성한다.\n-현장을... 기반으로 none로 평가"}'
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
  '1765283490532443',
  '선박교통관제사',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  50, 50, 40, 40, 70, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [선박교통관제사]\n-선박 운항을 모니터링한다.\n-항해 정보를 제공한다.\n-교통 흐름을 조절한다.\n-비상 상황에 대응한다.\n-통신을 유지한다.\n-안전 수칙을 준수한다.\n-보고서를 작... 기반으로 50로 평가","growth":"growth는 [선박교통관제사]\n-선박 운항을 모니터링한다.\n-항해 정보를 제공한다.\n-교통 흐름을 조절한다.\n-비상 상황에 대응한다.\n-통신을 유지한다.\n-안전 수칙을 준수한다.\n-보고서를 작... 기반으로 50로 평가","stability":"stability는 [선박교통관제사]\n-선박 운항을 모니터링한다.\n-항해 정보를 제공한다.\n-교통 흐름을 조절한다.\n-비상 상황에 대응한다.\n-통신을 유지한다.\n-안전 수칙을 준수한다.\n-보고서를 작... 기반으로 50로 평가","income":"income는 [선박교통관제사]\n-선박 운항을 모니터링한다.\n-항해 정보를 제공한다.\n-교통 흐름을 조절한다.\n-비상 상황에 대응한다.\n-통신을 유지한다.\n-안전 수칙을 준수한다.\n-보고서를 작... 기반으로 50로 평가","teamwork":"teamwork는 [선박교통관제사]\n-선박 운항을 모니터링한다.\n-항해 정보를 제공한다.\n-교통 흐름을 조절한다.\n-비상 상황에 대응한다.\n-통신을 유지한다.\n-안전 수칙을 준수한다.\n-보고서를 작... 기반으로 50로 평가","solo_deep":"solo_deep는 [선박교통관제사]\n-선박 운항을 모니터링한다.\n-항해 정보를 제공한다.\n-교통 흐름을 조절한다.\n-비상 상황에 대응한다.\n-통신을 유지한다.\n-안전 수칙을 준수한다.\n-보고서를 작... 기반으로 50로 평가","analytical":"analytical는 [선박교통관제사]\n-선박 운항을 모니터링한다.\n-항해 정보를 제공한다.\n-교통 흐름을 조절한다.\n-비상 상황에 대응한다.\n-통신을 유지한다.\n-안전 수칙을 준수한다.\n-보고서를 작... 기반으로 40로 평가","creative":"creative는 [선박교통관제사]\n-선박 운항을 모니터링한다.\n-항해 정보를 제공한다.\n-교통 흐름을 조절한다.\n-비상 상황에 대응한다.\n-통신을 유지한다.\n-안전 수칙을 준수한다.\n-보고서를 작... 기반으로 40로 평가","execution":"execution는 [선박교통관제사]\n-선박 운항을 모니터링한다.\n-항해 정보를 제공한다.\n-교통 흐름을 조절한다.\n-비상 상황에 대응한다.\n-통신을 유지한다.\n-안전 수칙을 준수한다.\n-보고서를 작... 기반으로 70로 평가","people_facing":"people_facing는 [선박교통관제사]\n-선박 운항을 모니터링한다.\n-항해 정보를 제공한다.\n-교통 흐름을 조절한다.\n-비상 상황에 대응한다.\n-통신을 유지한다.\n-안전 수칙을 준수한다.\n-보고서를 작... 기반으로 50로 평가","degree_required":"degree_required는 [선박교통관제사]\n-선박 운항을 모니터링한다.\n-항해 정보를 제공한다.\n-교통 흐름을 조절한다.\n-비상 상황에 대응한다.\n-통신을 유지한다.\n-안전 수칙을 준수한다.\n-보고서를 작... 기반으로 none로 평가","license_required":"license_required는 [선박교통관제사]\n-선박 운항을 모니터링한다.\n-항해 정보를 제공한다.\n-교통 흐름을 조절한다.\n-비상 상황에 대응한다.\n-통신을 유지한다.\n-안전 수칙을 준수한다.\n-보고서를 작... 기반으로 none로 평가"}'
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
  '1765283468195818',
  '잡지기자',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 50, 40,
  50, 50, 40, 70, 40, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [잡지기자]\n-기사를 기획한다.\n-취재를 실시한다.\n-인터뷰를 진행한다.\n-기사를 작성한다.\n-사진을 촬영한다.\n-편집을 한다.\n-사실을 검증한다.\n-데드라인을 지킨다.\n-독자를 ... 기반으로 50로 평가","growth":"growth는 [잡지기자]\n-기사를 기획한다.\n-취재를 실시한다.\n-인터뷰를 진행한다.\n-기사를 작성한다.\n-사진을 촬영한다.\n-편집을 한다.\n-사실을 검증한다.\n-데드라인을 지킨다.\n-독자를 ... 기반으로 65로 평가","stability":"stability는 [잡지기자]\n-기사를 기획한다.\n-취재를 실시한다.\n-인터뷰를 진행한다.\n-기사를 작성한다.\n-사진을 촬영한다.\n-편집을 한다.\n-사실을 검증한다.\n-데드라인을 지킨다.\n-독자를 ... 기반으로 50로 평가","income":"income는 [잡지기자]\n-기사를 기획한다.\n-취재를 실시한다.\n-인터뷰를 진행한다.\n-기사를 작성한다.\n-사진을 촬영한다.\n-편집을 한다.\n-사실을 검증한다.\n-데드라인을 지킨다.\n-독자를 ... 기반으로 40로 평가","teamwork":"teamwork는 [잡지기자]\n-기사를 기획한다.\n-취재를 실시한다.\n-인터뷰를 진행한다.\n-기사를 작성한다.\n-사진을 촬영한다.\n-편집을 한다.\n-사실을 검증한다.\n-데드라인을 지킨다.\n-독자를 ... 기반으로 50로 평가","solo_deep":"solo_deep는 [잡지기자]\n-기사를 기획한다.\n-취재를 실시한다.\n-인터뷰를 진행한다.\n-기사를 작성한다.\n-사진을 촬영한다.\n-편집을 한다.\n-사실을 검증한다.\n-데드라인을 지킨다.\n-독자를 ... 기반으로 50로 평가","analytical":"analytical는 [잡지기자]\n-기사를 기획한다.\n-취재를 실시한다.\n-인터뷰를 진행한다.\n-기사를 작성한다.\n-사진을 촬영한다.\n-편집을 한다.\n-사실을 검증한다.\n-데드라인을 지킨다.\n-독자를 ... 기반으로 40로 평가","creative":"creative는 [잡지기자]\n-기사를 기획한다.\n-취재를 실시한다.\n-인터뷰를 진행한다.\n-기사를 작성한다.\n-사진을 촬영한다.\n-편집을 한다.\n-사실을 검증한다.\n-데드라인을 지킨다.\n-독자를 ... 기반으로 70로 평가","execution":"execution는 [잡지기자]\n-기사를 기획한다.\n-취재를 실시한다.\n-인터뷰를 진행한다.\n-기사를 작성한다.\n-사진을 촬영한다.\n-편집을 한다.\n-사실을 검증한다.\n-데드라인을 지킨다.\n-독자를 ... 기반으로 40로 평가","people_facing":"people_facing는 [잡지기자]\n-기사를 기획한다.\n-취재를 실시한다.\n-인터뷰를 진행한다.\n-기사를 작성한다.\n-사진을 촬영한다.\n-편집을 한다.\n-사실을 검증한다.\n-데드라인을 지킨다.\n-독자를 ... 기반으로 50로 평가","degree_required":"degree_required는 [잡지기자]\n-기사를 기획한다.\n-취재를 실시한다.\n-인터뷰를 진행한다.\n-기사를 작성한다.\n-사진을 촬영한다.\n-편집을 한다.\n-사실을 검증한다.\n-데드라인을 지킨다.\n-독자를 ... 기반으로 none로 평가","license_required":"license_required는 [잡지기자]\n-기사를 기획한다.\n-취재를 실시한다.\n-인터뷰를 진행한다.\n-기사를 작성한다.\n-사진을 촬영한다.\n-편집을 한다.\n-사실을 검증한다.\n-데드라인을 지킨다.\n-독자를 ... 기반으로 none로 평가"}'
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