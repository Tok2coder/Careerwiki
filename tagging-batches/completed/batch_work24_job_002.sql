-- Batch tagging SQL generated at 2026-01-06T06:55:19.839Z
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
  '1765283476471779',
  '장례지도사 및 장례상담원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 30, 50,
  50, 50, 40, 40, 70, 75,
  'regular', 'none', 'none', 'none',
  'none', 'preferred', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [장례지도사]\n-고인과 유족의 상담을 진행한다.\n-장례 절차를 설명하고 계획을 수립한다.\n-장례식장과 관, 수의를 준비한다.\n-장례식을 진행하고 사회를 본다.\n-유족의 심리적 지지... 기반으로 50로 평가","growth":"growth는 [장례지도사]\n-고인과 유족의 상담을 진행한다.\n-장례 절차를 설명하고 계획을 수립한다.\n-장례식장과 관, 수의를 준비한다.\n-장례식을 진행하고 사회를 본다.\n-유족의 심리적 지지... 기반으로 50로 평가","stability":"stability는 [장례지도사]\n-고인과 유족의 상담을 진행한다.\n-장례 절차를 설명하고 계획을 수립한다.\n-장례식장과 관, 수의를 준비한다.\n-장례식을 진행하고 사회를 본다.\n-유족의 심리적 지지... 기반으로 30로 평가","income":"income는 [장례지도사]\n-고인과 유족의 상담을 진행한다.\n-장례 절차를 설명하고 계획을 수립한다.\n-장례식장과 관, 수의를 준비한다.\n-장례식을 진행하고 사회를 본다.\n-유족의 심리적 지지... 기반으로 50로 평가","teamwork":"teamwork는 [장례지도사]\n-고인과 유족의 상담을 진행한다.\n-장례 절차를 설명하고 계획을 수립한다.\n-장례식장과 관, 수의를 준비한다.\n-장례식을 진행하고 사회를 본다.\n-유족의 심리적 지지... 기반으로 50로 평가","solo_deep":"solo_deep는 [장례지도사]\n-고인과 유족의 상담을 진행한다.\n-장례 절차를 설명하고 계획을 수립한다.\n-장례식장과 관, 수의를 준비한다.\n-장례식을 진행하고 사회를 본다.\n-유족의 심리적 지지... 기반으로 50로 평가","analytical":"analytical는 [장례지도사]\n-고인과 유족의 상담을 진행한다.\n-장례 절차를 설명하고 계획을 수립한다.\n-장례식장과 관, 수의를 준비한다.\n-장례식을 진행하고 사회를 본다.\n-유족의 심리적 지지... 기반으로 40로 평가","creative":"creative는 [장례지도사]\n-고인과 유족의 상담을 진행한다.\n-장례 절차를 설명하고 계획을 수립한다.\n-장례식장과 관, 수의를 준비한다.\n-장례식을 진행하고 사회를 본다.\n-유족의 심리적 지지... 기반으로 40로 평가","execution":"execution는 [장례지도사]\n-고인과 유족의 상담을 진행한다.\n-장례 절차를 설명하고 계획을 수립한다.\n-장례식장과 관, 수의를 준비한다.\n-장례식을 진행하고 사회를 본다.\n-유족의 심리적 지지... 기반으로 70로 평가","people_facing":"people_facing는 [장례지도사]\n-고인과 유족의 상담을 진행한다.\n-장례 절차를 설명하고 계획을 수립한다.\n-장례식장과 관, 수의를 준비한다.\n-장례식을 진행하고 사회를 본다.\n-유족의 심리적 지지... 기반으로 75로 평가","degree_required":"degree_required는 [장례지도사]\n-고인과 유족의 상담을 진행한다.\n-장례 절차를 설명하고 계획을 수립한다.\n-장례식장과 관, 수의를 준비한다.\n-장례식을 진행하고 사회를 본다.\n-유족의 심리적 지지... 기반으로 none로 평가","license_required":"license_required는 [장례지도사]\n-고인과 유족의 상담을 진행한다.\n-장례 절차를 설명하고 계획을 수립한다.\n-장례식장과 관, 수의를 준비한다.\n-장례식을 진행하고 사회를 본다.\n-유족의 심리적 지지... 기반으로 preferred로 평가"}'
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
  '1765283469551675',
  '만화영화작가(애니메이터)',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 50, 40,
  70, 30, 30, 60, 60, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [만화작가]\n-스토리를 기획하고 구성한다.\n-등장인물을 디자인한다.\n-만화 원고를 그린다.\n-대사를 작성한다.\n-색상을 입힌다.\n-편집과 교정을 한다.\n-출판사와 협의한다.\n-독자... 기반으로 50로 평가","growth":"growth는 [만화작가]\n-스토리를 기획하고 구성한다.\n-등장인물을 디자인한다.\n-만화 원고를 그린다.\n-대사를 작성한다.\n-색상을 입힌다.\n-편집과 교정을 한다.\n-출판사와 협의한다.\n-독자... 기반으로 65로 평가","stability":"stability는 [만화작가]\n-스토리를 기획하고 구성한다.\n-등장인물을 디자인한다.\n-만화 원고를 그린다.\n-대사를 작성한다.\n-색상을 입힌다.\n-편집과 교정을 한다.\n-출판사와 협의한다.\n-독자... 기반으로 50로 평가","income":"income는 [만화작가]\n-스토리를 기획하고 구성한다.\n-등장인물을 디자인한다.\n-만화 원고를 그린다.\n-대사를 작성한다.\n-색상을 입힌다.\n-편집과 교정을 한다.\n-출판사와 협의한다.\n-독자... 기반으로 40로 평가","teamwork":"teamwork는 [만화작가]\n-스토리를 기획하고 구성한다.\n-등장인물을 디자인한다.\n-만화 원고를 그린다.\n-대사를 작성한다.\n-색상을 입힌다.\n-편집과 교정을 한다.\n-출판사와 협의한다.\n-독자... 기반으로 70로 평가","solo_deep":"solo_deep는 [만화작가]\n-스토리를 기획하고 구성한다.\n-등장인물을 디자인한다.\n-만화 원고를 그린다.\n-대사를 작성한다.\n-색상을 입힌다.\n-편집과 교정을 한다.\n-출판사와 협의한다.\n-독자... 기반으로 30로 평가","analytical":"analytical는 [만화작가]\n-스토리를 기획하고 구성한다.\n-등장인물을 디자인한다.\n-만화 원고를 그린다.\n-대사를 작성한다.\n-색상을 입힌다.\n-편집과 교정을 한다.\n-출판사와 협의한다.\n-독자... 기반으로 30로 평가","creative":"creative는 [만화작가]\n-스토리를 기획하고 구성한다.\n-등장인물을 디자인한다.\n-만화 원고를 그린다.\n-대사를 작성한다.\n-색상을 입힌다.\n-편집과 교정을 한다.\n-출판사와 협의한다.\n-독자... 기반으로 60로 평가","execution":"execution는 [만화작가]\n-스토리를 기획하고 구성한다.\n-등장인물을 디자인한다.\n-만화 원고를 그린다.\n-대사를 작성한다.\n-색상을 입힌다.\n-편집과 교정을 한다.\n-출판사와 협의한다.\n-독자... 기반으로 60로 평가","people_facing":"people_facing는 [만화작가]\n-스토리를 기획하고 구성한다.\n-등장인물을 디자인한다.\n-만화 원고를 그린다.\n-대사를 작성한다.\n-색상을 입힌다.\n-편집과 교정을 한다.\n-출판사와 협의한다.\n-독자... 기반으로 50로 평가","degree_required":"degree_required는 [만화작가]\n-스토리를 기획하고 구성한다.\n-등장인물을 디자인한다.\n-만화 원고를 그린다.\n-대사를 작성한다.\n-색상을 입힌다.\n-편집과 교정을 한다.\n-출판사와 협의한다.\n-독자... 기반으로 none로 평가","license_required":"license_required는 [만화작가]\n-스토리를 기획하고 구성한다.\n-등장인물을 디자인한다.\n-만화 원고를 그린다.\n-대사를 작성한다.\n-색상을 입힌다.\n-편집과 교정을 한다.\n-출판사와 협의한다.\n-독자... 기반으로 none로 평가"}'
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
  '1765283435491699',
  '정보통신컨설턴트 및 감리원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 75, 50, 50,
  50, 50, 70, 40, 40, 75,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [정보통신컨설턴트]\n-고객의 it 요구사항을 분석한다.\n-시스템 설계를 제안한다.\n-기술 솔루션을 추천한다.\n-프로젝트 계획을 수립한다.\n-벤더사와 협상한다.\n-구현 과정을 감독한... 기반으로 50로 평가","growth":"growth는 [정보통신컨설턴트]\n-고객의 it 요구사항을 분석한다.\n-시스템 설계를 제안한다.\n-기술 솔루션을 추천한다.\n-프로젝트 계획을 수립한다.\n-벤더사와 협상한다.\n-구현 과정을 감독한... 기반으로 75로 평가","stability":"stability는 [정보통신컨설턴트]\n-고객의 it 요구사항을 분석한다.\n-시스템 설계를 제안한다.\n-기술 솔루션을 추천한다.\n-프로젝트 계획을 수립한다.\n-벤더사와 협상한다.\n-구현 과정을 감독한... 기반으로 50로 평가","income":"income는 [정보통신컨설턴트]\n-고객의 it 요구사항을 분석한다.\n-시스템 설계를 제안한다.\n-기술 솔루션을 추천한다.\n-프로젝트 계획을 수립한다.\n-벤더사와 협상한다.\n-구현 과정을 감독한... 기반으로 50로 평가","teamwork":"teamwork는 [정보통신컨설턴트]\n-고객의 it 요구사항을 분석한다.\n-시스템 설계를 제안한다.\n-기술 솔루션을 추천한다.\n-프로젝트 계획을 수립한다.\n-벤더사와 협상한다.\n-구현 과정을 감독한... 기반으로 50로 평가","solo_deep":"solo_deep는 [정보통신컨설턴트]\n-고객의 it 요구사항을 분석한다.\n-시스템 설계를 제안한다.\n-기술 솔루션을 추천한다.\n-프로젝트 계획을 수립한다.\n-벤더사와 협상한다.\n-구현 과정을 감독한... 기반으로 50로 평가","analytical":"analytical는 [정보통신컨설턴트]\n-고객의 it 요구사항을 분석한다.\n-시스템 설계를 제안한다.\n-기술 솔루션을 추천한다.\n-프로젝트 계획을 수립한다.\n-벤더사와 협상한다.\n-구현 과정을 감독한... 기반으로 70로 평가","creative":"creative는 [정보통신컨설턴트]\n-고객의 it 요구사항을 분석한다.\n-시스템 설계를 제안한다.\n-기술 솔루션을 추천한다.\n-프로젝트 계획을 수립한다.\n-벤더사와 협상한다.\n-구현 과정을 감독한... 기반으로 40로 평가","execution":"execution는 [정보통신컨설턴트]\n-고객의 it 요구사항을 분석한다.\n-시스템 설계를 제안한다.\n-기술 솔루션을 추천한다.\n-프로젝트 계획을 수립한다.\n-벤더사와 협상한다.\n-구현 과정을 감독한... 기반으로 40로 평가","people_facing":"people_facing는 [정보통신컨설턴트]\n-고객의 it 요구사항을 분석한다.\n-시스템 설계를 제안한다.\n-기술 솔루션을 추천한다.\n-프로젝트 계획을 수립한다.\n-벤더사와 협상한다.\n-구현 과정을 감독한... 기반으로 75로 평가","degree_required":"degree_required는 [정보통신컨설턴트]\n-고객의 it 요구사항을 분석한다.\n-시스템 설계를 제안한다.\n-기술 솔루션을 추천한다.\n-프로젝트 계획을 수립한다.\n-벤더사와 협상한다.\n-구현 과정을 감독한... 기반으로 none로 평가","license_required":"license_required는 [정보통신컨설턴트]\n-고객의 it 요구사항을 분석한다.\n-시스템 설계를 제안한다.\n-기술 솔루션을 추천한다.\n-프로젝트 계획을 수립한다.\n-벤더사와 협상한다.\n-구현 과정을 감독한... 기반으로 none로 평가"}'
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
  '1765283426345613',
  '자산운용가',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 70, 50,
  50, 50, 50, 50, 50, 60,
  'regular', 'none', 'none', 'partial',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [주식운용가]\n-시장 동향을 분석한다.\n-주식 포트폴리오를 구성한다.\n-투자 전략을 수립한다.\n-주식 매매를 실행한다.\n-성과를 모니터링한다.\n-리스크를 관리한다.\n-보고서를 작성... 기반으로 50로 평가","growth":"growth는 [주식운용가]\n-시장 동향을 분석한다.\n-주식 포트폴리오를 구성한다.\n-투자 전략을 수립한다.\n-주식 매매를 실행한다.\n-성과를 모니터링한다.\n-리스크를 관리한다.\n-보고서를 작성... 기반으로 65로 평가","stability":"stability는 [주식운용가]\n-시장 동향을 분석한다.\n-주식 포트폴리오를 구성한다.\n-투자 전략을 수립한다.\n-주식 매매를 실행한다.\n-성과를 모니터링한다.\n-리스크를 관리한다.\n-보고서를 작성... 기반으로 70로 평가","income":"income는 [주식운용가]\n-시장 동향을 분석한다.\n-주식 포트폴리오를 구성한다.\n-투자 전략을 수립한다.\n-주식 매매를 실행한다.\n-성과를 모니터링한다.\n-리스크를 관리한다.\n-보고서를 작성... 기반으로 50로 평가","teamwork":"teamwork는 [주식운용가]\n-시장 동향을 분석한다.\n-주식 포트폴리오를 구성한다.\n-투자 전략을 수립한다.\n-주식 매매를 실행한다.\n-성과를 모니터링한다.\n-리스크를 관리한다.\n-보고서를 작성... 기반으로 50로 평가","solo_deep":"solo_deep는 [주식운용가]\n-시장 동향을 분석한다.\n-주식 포트폴리오를 구성한다.\n-투자 전략을 수립한다.\n-주식 매매를 실행한다.\n-성과를 모니터링한다.\n-리스크를 관리한다.\n-보고서를 작성... 기반으로 50로 평가","analytical":"analytical는 [주식운용가]\n-시장 동향을 분석한다.\n-주식 포트폴리오를 구성한다.\n-투자 전략을 수립한다.\n-주식 매매를 실행한다.\n-성과를 모니터링한다.\n-리스크를 관리한다.\n-보고서를 작성... 기반으로 50로 평가","creative":"creative는 [주식운용가]\n-시장 동향을 분석한다.\n-주식 포트폴리오를 구성한다.\n-투자 전략을 수립한다.\n-주식 매매를 실행한다.\n-성과를 모니터링한다.\n-리스크를 관리한다.\n-보고서를 작성... 기반으로 50로 평가","execution":"execution는 [주식운용가]\n-시장 동향을 분석한다.\n-주식 포트폴리오를 구성한다.\n-투자 전략을 수립한다.\n-주식 매매를 실행한다.\n-성과를 모니터링한다.\n-리스크를 관리한다.\n-보고서를 작성... 기반으로 50로 평가","people_facing":"people_facing는 [주식운용가]\n-시장 동향을 분석한다.\n-주식 포트폴리오를 구성한다.\n-투자 전략을 수립한다.\n-주식 매매를 실행한다.\n-성과를 모니터링한다.\n-리스크를 관리한다.\n-보고서를 작성... 기반으로 60로 평가","degree_required":"degree_required는 [주식운용가]\n-시장 동향을 분석한다.\n-주식 포트폴리오를 구성한다.\n-투자 전략을 수립한다.\n-주식 매매를 실행한다.\n-성과를 모니터링한다.\n-리스크를 관리한다.\n-보고서를 작성... 기반으로 none로 평가","license_required":"license_required는 [주식운용가]\n-시장 동향을 분석한다.\n-주식 포트폴리오를 구성한다.\n-투자 전략을 수립한다.\n-주식 매매를 실행한다.\n-성과를 모니터링한다.\n-리스크를 관리한다.\n-보고서를 작성... 기반으로 none로 평가"}'
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
  '176528346901264',
  '기록물관리사',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 70, 50,
  50, 50, 60, 30, 60, 35,
  'regular', 'none', 'none', 'partial',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [기록물관리사]\n-기록물 수집 계획을 수립한다.\n-기록물을 분류하고 정리한다.\n-기록물을 보존한다.\n-기록물을 디지털화한다.\n-기록물 접근을 관리한다.\n-기록물 파기를 처리한다.\n... 기반으로 50로 평가","growth":"growth는 [기록물관리사]\n-기록물 수집 계획을 수립한다.\n-기록물을 분류하고 정리한다.\n-기록물을 보존한다.\n-기록물을 디지털화한다.\n-기록물 접근을 관리한다.\n-기록물 파기를 처리한다.\n... 기반으로 65로 평가","stability":"stability는 [기록물관리사]\n-기록물 수집 계획을 수립한다.\n-기록물을 분류하고 정리한다.\n-기록물을 보존한다.\n-기록물을 디지털화한다.\n-기록물 접근을 관리한다.\n-기록물 파기를 처리한다.\n... 기반으로 70로 평가","income":"income는 [기록물관리사]\n-기록물 수집 계획을 수립한다.\n-기록물을 분류하고 정리한다.\n-기록물을 보존한다.\n-기록물을 디지털화한다.\n-기록물 접근을 관리한다.\n-기록물 파기를 처리한다.\n... 기반으로 50로 평가","teamwork":"teamwork는 [기록물관리사]\n-기록물 수집 계획을 수립한다.\n-기록물을 분류하고 정리한다.\n-기록물을 보존한다.\n-기록물을 디지털화한다.\n-기록물 접근을 관리한다.\n-기록물 파기를 처리한다.\n... 기반으로 50로 평가","solo_deep":"solo_deep는 [기록물관리사]\n-기록물 수집 계획을 수립한다.\n-기록물을 분류하고 정리한다.\n-기록물을 보존한다.\n-기록물을 디지털화한다.\n-기록물 접근을 관리한다.\n-기록물 파기를 처리한다.\n... 기반으로 50로 평가","analytical":"analytical는 [기록물관리사]\n-기록물 수집 계획을 수립한다.\n-기록물을 분류하고 정리한다.\n-기록물을 보존한다.\n-기록물을 디지털화한다.\n-기록물 접근을 관리한다.\n-기록물 파기를 처리한다.\n... 기반으로 60로 평가","creative":"creative는 [기록물관리사]\n-기록물 수집 계획을 수립한다.\n-기록물을 분류하고 정리한다.\n-기록물을 보존한다.\n-기록물을 디지털화한다.\n-기록물 접근을 관리한다.\n-기록물 파기를 처리한다.\n... 기반으로 30로 평가","execution":"execution는 [기록물관리사]\n-기록물 수집 계획을 수립한다.\n-기록물을 분류하고 정리한다.\n-기록물을 보존한다.\n-기록물을 디지털화한다.\n-기록물 접근을 관리한다.\n-기록물 파기를 처리한다.\n... 기반으로 60로 평가","people_facing":"people_facing는 [기록물관리사]\n-기록물 수집 계획을 수립한다.\n-기록물을 분류하고 정리한다.\n-기록물을 보존한다.\n-기록물을 디지털화한다.\n-기록물 접근을 관리한다.\n-기록물 파기를 처리한다.\n... 기반으로 35로 평가","degree_required":"degree_required는 [기록물관리사]\n-기록물 수집 계획을 수립한다.\n-기록물을 분류하고 정리한다.\n-기록물을 보존한다.\n-기록물을 디지털화한다.\n-기록물 접근을 관리한다.\n-기록물 파기를 처리한다.\n... 기반으로 none로 평가","license_required":"license_required는 [기록물관리사]\n-기록물 수집 계획을 수립한다.\n-기록물을 분류하고 정리한다.\n-기록물을 보존한다.\n-기록물을 디지털화한다.\n-기록물 접근을 관리한다.\n-기록물 파기를 처리한다.\n... 기반으로 none로 평가"}'
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
  '1765283417453409',
  '인사·교육·훈련사무원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 75, 50, 50,
  50, 50, 50, 50, 50, 75,
  'regular', 'none', 'none', 'partial',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [인사사무원]\n-채용 공고를 작성한다.\n-지원서 접수를 관리한다.\n-면접 일정을 조율한다.\n-신입사원 서류를 처리한다.\n-인사 기록을 관리한다.\n-급여를 계산한다.\n-인사 정책을 ... 기반으로 50로 평가","growth":"growth는 [인사사무원]\n-채용 공고를 작성한다.\n-지원서 접수를 관리한다.\n-면접 일정을 조율한다.\n-신입사원 서류를 처리한다.\n-인사 기록을 관리한다.\n-급여를 계산한다.\n-인사 정책을 ... 기반으로 75로 평가","stability":"stability는 [인사사무원]\n-채용 공고를 작성한다.\n-지원서 접수를 관리한다.\n-면접 일정을 조율한다.\n-신입사원 서류를 처리한다.\n-인사 기록을 관리한다.\n-급여를 계산한다.\n-인사 정책을 ... 기반으로 50로 평가","income":"income는 [인사사무원]\n-채용 공고를 작성한다.\n-지원서 접수를 관리한다.\n-면접 일정을 조율한다.\n-신입사원 서류를 처리한다.\n-인사 기록을 관리한다.\n-급여를 계산한다.\n-인사 정책을 ... 기반으로 50로 평가","teamwork":"teamwork는 [인사사무원]\n-채용 공고를 작성한다.\n-지원서 접수를 관리한다.\n-면접 일정을 조율한다.\n-신입사원 서류를 처리한다.\n-인사 기록을 관리한다.\n-급여를 계산한다.\n-인사 정책을 ... 기반으로 50로 평가","solo_deep":"solo_deep는 [인사사무원]\n-채용 공고를 작성한다.\n-지원서 접수를 관리한다.\n-면접 일정을 조율한다.\n-신입사원 서류를 처리한다.\n-인사 기록을 관리한다.\n-급여를 계산한다.\n-인사 정책을 ... 기반으로 50로 평가","analytical":"analytical는 [인사사무원]\n-채용 공고를 작성한다.\n-지원서 접수를 관리한다.\n-면접 일정을 조율한다.\n-신입사원 서류를 처리한다.\n-인사 기록을 관리한다.\n-급여를 계산한다.\n-인사 정책을 ... 기반으로 50로 평가","creative":"creative는 [인사사무원]\n-채용 공고를 작성한다.\n-지원서 접수를 관리한다.\n-면접 일정을 조율한다.\n-신입사원 서류를 처리한다.\n-인사 기록을 관리한다.\n-급여를 계산한다.\n-인사 정책을 ... 기반으로 50로 평가","execution":"execution는 [인사사무원]\n-채용 공고를 작성한다.\n-지원서 접수를 관리한다.\n-면접 일정을 조율한다.\n-신입사원 서류를 처리한다.\n-인사 기록을 관리한다.\n-급여를 계산한다.\n-인사 정책을 ... 기반으로 50로 평가","people_facing":"people_facing는 [인사사무원]\n-채용 공고를 작성한다.\n-지원서 접수를 관리한다.\n-면접 일정을 조율한다.\n-신입사원 서류를 처리한다.\n-인사 기록을 관리한다.\n-급여를 계산한다.\n-인사 정책을 ... 기반으로 75로 평가","degree_required":"degree_required는 [인사사무원]\n-채용 공고를 작성한다.\n-지원서 접수를 관리한다.\n-면접 일정을 조율한다.\n-신입사원 서류를 처리한다.\n-인사 기록을 관리한다.\n-급여를 계산한다.\n-인사 정책을 ... 기반으로 none로 평가","license_required":"license_required는 [인사사무원]\n-채용 공고를 작성한다.\n-지원서 접수를 관리한다.\n-면접 일정을 조율한다.\n-신입사원 서류를 처리한다.\n-인사 기록을 관리한다.\n-급여를 계산한다.\n-인사 정책을 ... 기반으로 none로 평가"}'
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
  '1765283471832373',
  '음향·녹음기사',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 40,
  50, 50, 40, 40, 70, 50,
  'regular', 'none', 'none', 'none',
  'college', 'preferred', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [녹음기사]\n-녹음 장비를 설치한다.\n-마이크를 설정한다.\n-음질을 조정한다.\n-녹음을 진행한다.\n-음성을 편집한다.\n-마스터링을 한다.\n-품질을 검사한다.\n-녹음 파일을 관리한다... 기반으로 50로 평가","growth":"growth는 [녹음기사]\n-녹음 장비를 설치한다.\n-마이크를 설정한다.\n-음질을 조정한다.\n-녹음을 진행한다.\n-음성을 편집한다.\n-마스터링을 한다.\n-품질을 검사한다.\n-녹음 파일을 관리한다... 기반으로 50로 평가","stability":"stability는 [녹음기사]\n-녹음 장비를 설치한다.\n-마이크를 설정한다.\n-음질을 조정한다.\n-녹음을 진행한다.\n-음성을 편집한다.\n-마스터링을 한다.\n-품질을 검사한다.\n-녹음 파일을 관리한다... 기반으로 50로 평가","income":"income는 [녹음기사]\n-녹음 장비를 설치한다.\n-마이크를 설정한다.\n-음질을 조정한다.\n-녹음을 진행한다.\n-음성을 편집한다.\n-마스터링을 한다.\n-품질을 검사한다.\n-녹음 파일을 관리한다... 기반으로 40로 평가","teamwork":"teamwork는 [녹음기사]\n-녹음 장비를 설치한다.\n-마이크를 설정한다.\n-음질을 조정한다.\n-녹음을 진행한다.\n-음성을 편집한다.\n-마스터링을 한다.\n-품질을 검사한다.\n-녹음 파일을 관리한다... 기반으로 50로 평가","solo_deep":"solo_deep는 [녹음기사]\n-녹음 장비를 설치한다.\n-마이크를 설정한다.\n-음질을 조정한다.\n-녹음을 진행한다.\n-음성을 편집한다.\n-마스터링을 한다.\n-품질을 검사한다.\n-녹음 파일을 관리한다... 기반으로 50로 평가","analytical":"analytical는 [녹음기사]\n-녹음 장비를 설치한다.\n-마이크를 설정한다.\n-음질을 조정한다.\n-녹음을 진행한다.\n-음성을 편집한다.\n-마스터링을 한다.\n-품질을 검사한다.\n-녹음 파일을 관리한다... 기반으로 40로 평가","creative":"creative는 [녹음기사]\n-녹음 장비를 설치한다.\n-마이크를 설정한다.\n-음질을 조정한다.\n-녹음을 진행한다.\n-음성을 편집한다.\n-마스터링을 한다.\n-품질을 검사한다.\n-녹음 파일을 관리한다... 기반으로 40로 평가","execution":"execution는 [녹음기사]\n-녹음 장비를 설치한다.\n-마이크를 설정한다.\n-음질을 조정한다.\n-녹음을 진행한다.\n-음성을 편집한다.\n-마스터링을 한다.\n-품질을 검사한다.\n-녹음 파일을 관리한다... 기반으로 70로 평가","people_facing":"people_facing는 [녹음기사]\n-녹음 장비를 설치한다.\n-마이크를 설정한다.\n-음질을 조정한다.\n-녹음을 진행한다.\n-음성을 편집한다.\n-마스터링을 한다.\n-품질을 검사한다.\n-녹음 파일을 관리한다... 기반으로 50로 평가","degree_required":"degree_required는 [녹음기사]\n-녹음 장비를 설치한다.\n-마이크를 설정한다.\n-음질을 조정한다.\n-녹음을 진행한다.\n-음성을 편집한다.\n-마스터링을 한다.\n-품질을 검사한다.\n-녹음 파일을 관리한다... 기반으로 college로 평가","license_required":"license_required는 [녹음기사]\n-녹음 장비를 설치한다.\n-마이크를 설정한다.\n-음질을 조정한다.\n-녹음을 진행한다.\n-음성을 편집한다.\n-마스터링을 한다.\n-품질을 검사한다.\n-녹음 파일을 관리한다... 기반으로 preferred로 평가"}'
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
  '176528349017555',
  '홍보도우미 및 판촉원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  40, 50, 50, 50,
  50, 50, 40, 40, 70, 75,
  'overtime_some', 'none', 'some', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [홍보도우미]\n-제품을 시연한다.\n-고객에게 정보를 제공한다.\n-이벤트를 진행한다.\n-시료를 배부한다.\n-고객 반응을 관찰한다.\n-판매를 유도한다.\n-홍보 자료를 관리한다.\n\n[판... 기반으로 40로 평가","growth":"growth는 [홍보도우미]\n-제품을 시연한다.\n-고객에게 정보를 제공한다.\n-이벤트를 진행한다.\n-시료를 배부한다.\n-고객 반응을 관찰한다.\n-판매를 유도한다.\n-홍보 자료를 관리한다.\n\n[판... 기반으로 50로 평가","stability":"stability는 [홍보도우미]\n-제품을 시연한다.\n-고객에게 정보를 제공한다.\n-이벤트를 진행한다.\n-시료를 배부한다.\n-고객 반응을 관찰한다.\n-판매를 유도한다.\n-홍보 자료를 관리한다.\n\n[판... 기반으로 50로 평가","income":"income는 [홍보도우미]\n-제품을 시연한다.\n-고객에게 정보를 제공한다.\n-이벤트를 진행한다.\n-시료를 배부한다.\n-고객 반응을 관찰한다.\n-판매를 유도한다.\n-홍보 자료를 관리한다.\n\n[판... 기반으로 50로 평가","teamwork":"teamwork는 [홍보도우미]\n-제품을 시연한다.\n-고객에게 정보를 제공한다.\n-이벤트를 진행한다.\n-시료를 배부한다.\n-고객 반응을 관찰한다.\n-판매를 유도한다.\n-홍보 자료를 관리한다.\n\n[판... 기반으로 50로 평가","solo_deep":"solo_deep는 [홍보도우미]\n-제품을 시연한다.\n-고객에게 정보를 제공한다.\n-이벤트를 진행한다.\n-시료를 배부한다.\n-고객 반응을 관찰한다.\n-판매를 유도한다.\n-홍보 자료를 관리한다.\n\n[판... 기반으로 50로 평가","analytical":"analytical는 [홍보도우미]\n-제품을 시연한다.\n-고객에게 정보를 제공한다.\n-이벤트를 진행한다.\n-시료를 배부한다.\n-고객 반응을 관찰한다.\n-판매를 유도한다.\n-홍보 자료를 관리한다.\n\n[판... 기반으로 40로 평가","creative":"creative는 [홍보도우미]\n-제품을 시연한다.\n-고객에게 정보를 제공한다.\n-이벤트를 진행한다.\n-시료를 배부한다.\n-고객 반응을 관찰한다.\n-판매를 유도한다.\n-홍보 자료를 관리한다.\n\n[판... 기반으로 40로 평가","execution":"execution는 [홍보도우미]\n-제품을 시연한다.\n-고객에게 정보를 제공한다.\n-이벤트를 진행한다.\n-시료를 배부한다.\n-고객 반응을 관찰한다.\n-판매를 유도한다.\n-홍보 자료를 관리한다.\n\n[판... 기반으로 70로 평가","people_facing":"people_facing는 [홍보도우미]\n-제품을 시연한다.\n-고객에게 정보를 제공한다.\n-이벤트를 진행한다.\n-시료를 배부한다.\n-고객 반응을 관찰한다.\n-판매를 유도한다.\n-홍보 자료를 관리한다.\n\n[판... 기반으로 75로 평가","degree_required":"degree_required는 [홍보도우미]\n-제품을 시연한다.\n-고객에게 정보를 제공한다.\n-이벤트를 진행한다.\n-시료를 배부한다.\n-고객 반응을 관찰한다.\n-판매를 유도한다.\n-홍보 자료를 관리한다.\n\n[판... 기반으로 none로 평가","license_required":"license_required는 [홍보도우미]\n-제품을 시연한다.\n-고객에게 정보를 제공한다.\n-이벤트를 진행한다.\n-시료를 배부한다.\n-고객 반응을 관찰한다.\n-판매를 유도한다.\n-홍보 자료를 관리한다.\n\n[판... 기반으로 none로 평가"}'
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
  '1765283414312245',
  '광고·홍보·마케팅전문가',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 50, 50,
  70, 30, 50, 50, 50, 60,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [광고기획자]\n-광고 전략을 수립한다.\n-타겟 고객을 분석한다.\n-광고 콘셉트를 개발한다.\n-미디어 플랜을 작성한다.\n-광고 제작을 감독한다.\n-광고 효과를 측정한다.\n-보고서를 ... 기반으로 50로 평가","growth":"growth는 [광고기획자]\n-광고 전략을 수립한다.\n-타겟 고객을 분석한다.\n-광고 콘셉트를 개발한다.\n-미디어 플랜을 작성한다.\n-광고 제작을 감독한다.\n-광고 효과를 측정한다.\n-보고서를 ... 기반으로 65로 평가","stability":"stability는 [광고기획자]\n-광고 전략을 수립한다.\n-타겟 고객을 분석한다.\n-광고 콘셉트를 개발한다.\n-미디어 플랜을 작성한다.\n-광고 제작을 감독한다.\n-광고 효과를 측정한다.\n-보고서를 ... 기반으로 50로 평가","income":"income는 [광고기획자]\n-광고 전략을 수립한다.\n-타겟 고객을 분석한다.\n-광고 콘셉트를 개발한다.\n-미디어 플랜을 작성한다.\n-광고 제작을 감독한다.\n-광고 효과를 측정한다.\n-보고서를 ... 기반으로 50로 평가","teamwork":"teamwork는 [광고기획자]\n-광고 전략을 수립한다.\n-타겟 고객을 분석한다.\n-광고 콘셉트를 개발한다.\n-미디어 플랜을 작성한다.\n-광고 제작을 감독한다.\n-광고 효과를 측정한다.\n-보고서를 ... 기반으로 70로 평가","solo_deep":"solo_deep는 [광고기획자]\n-광고 전략을 수립한다.\n-타겟 고객을 분석한다.\n-광고 콘셉트를 개발한다.\n-미디어 플랜을 작성한다.\n-광고 제작을 감독한다.\n-광고 효과를 측정한다.\n-보고서를 ... 기반으로 30로 평가","analytical":"analytical는 [광고기획자]\n-광고 전략을 수립한다.\n-타겟 고객을 분석한다.\n-광고 콘셉트를 개발한다.\n-미디어 플랜을 작성한다.\n-광고 제작을 감독한다.\n-광고 효과를 측정한다.\n-보고서를 ... 기반으로 50로 평가","creative":"creative는 [광고기획자]\n-광고 전략을 수립한다.\n-타겟 고객을 분석한다.\n-광고 콘셉트를 개발한다.\n-미디어 플랜을 작성한다.\n-광고 제작을 감독한다.\n-광고 효과를 측정한다.\n-보고서를 ... 기반으로 50로 평가","execution":"execution는 [광고기획자]\n-광고 전략을 수립한다.\n-타겟 고객을 분석한다.\n-광고 콘셉트를 개발한다.\n-미디어 플랜을 작성한다.\n-광고 제작을 감독한다.\n-광고 효과를 측정한다.\n-보고서를 ... 기반으로 50로 평가","people_facing":"people_facing는 [광고기획자]\n-광고 전략을 수립한다.\n-타겟 고객을 분석한다.\n-광고 콘셉트를 개발한다.\n-미디어 플랜을 작성한다.\n-광고 제작을 감독한다.\n-광고 효과를 측정한다.\n-보고서를 ... 기반으로 60로 평가","degree_required":"degree_required는 [광고기획자]\n-광고 전략을 수립한다.\n-타겟 고객을 분석한다.\n-광고 콘셉트를 개발한다.\n-미디어 플랜을 작성한다.\n-광고 제작을 감독한다.\n-광고 효과를 측정한다.\n-보고서를 ... 기반으로 none로 평가","license_required":"license_required는 [광고기획자]\n-광고 전략을 수립한다.\n-타겟 고객을 분석한다.\n-광고 콘셉트를 개발한다.\n-미디어 플랜을 작성한다.\n-광고 제작을 감독한다.\n-광고 효과를 측정한다.\n-보고서를 ... 기반으로 none로 평가"}'
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
  '1765283485749444',
  '주차관리·안내원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  40, 50, 50, 50,
  50, 50, 60, 30, 60, 75,
  'overtime_some', 'none', 'some', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [주차관리원]\n-차량 진입을 통제한다.\n-주차 공간을 안내한다.\n-주차 요금을 징수한다.\n-차량 안전을 감독한다.\n-주차장을 순찰한다.\n-문제 상황을 해결한다.\n-주차 기록을 관리... 기반으로 40로 평가","growth":"growth는 [주차관리원]\n-차량 진입을 통제한다.\n-주차 공간을 안내한다.\n-주차 요금을 징수한다.\n-차량 안전을 감독한다.\n-주차장을 순찰한다.\n-문제 상황을 해결한다.\n-주차 기록을 관리... 기반으로 50로 평가","stability":"stability는 [주차관리원]\n-차량 진입을 통제한다.\n-주차 공간을 안내한다.\n-주차 요금을 징수한다.\n-차량 안전을 감독한다.\n-주차장을 순찰한다.\n-문제 상황을 해결한다.\n-주차 기록을 관리... 기반으로 50로 평가","income":"income는 [주차관리원]\n-차량 진입을 통제한다.\n-주차 공간을 안내한다.\n-주차 요금을 징수한다.\n-차량 안전을 감독한다.\n-주차장을 순찰한다.\n-문제 상황을 해결한다.\n-주차 기록을 관리... 기반으로 50로 평가","teamwork":"teamwork는 [주차관리원]\n-차량 진입을 통제한다.\n-주차 공간을 안내한다.\n-주차 요금을 징수한다.\n-차량 안전을 감독한다.\n-주차장을 순찰한다.\n-문제 상황을 해결한다.\n-주차 기록을 관리... 기반으로 50로 평가","solo_deep":"solo_deep는 [주차관리원]\n-차량 진입을 통제한다.\n-주차 공간을 안내한다.\n-주차 요금을 징수한다.\n-차량 안전을 감독한다.\n-주차장을 순찰한다.\n-문제 상황을 해결한다.\n-주차 기록을 관리... 기반으로 50로 평가","analytical":"analytical는 [주차관리원]\n-차량 진입을 통제한다.\n-주차 공간을 안내한다.\n-주차 요금을 징수한다.\n-차량 안전을 감독한다.\n-주차장을 순찰한다.\n-문제 상황을 해결한다.\n-주차 기록을 관리... 기반으로 60로 평가","creative":"creative는 [주차관리원]\n-차량 진입을 통제한다.\n-주차 공간을 안내한다.\n-주차 요금을 징수한다.\n-차량 안전을 감독한다.\n-주차장을 순찰한다.\n-문제 상황을 해결한다.\n-주차 기록을 관리... 기반으로 30로 평가","execution":"execution는 [주차관리원]\n-차량 진입을 통제한다.\n-주차 공간을 안내한다.\n-주차 요금을 징수한다.\n-차량 안전을 감독한다.\n-주차장을 순찰한다.\n-문제 상황을 해결한다.\n-주차 기록을 관리... 기반으로 60로 평가","people_facing":"people_facing는 [주차관리원]\n-차량 진입을 통제한다.\n-주차 공간을 안내한다.\n-주차 요금을 징수한다.\n-차량 안전을 감독한다.\n-주차장을 순찰한다.\n-문제 상황을 해결한다.\n-주차 기록을 관리... 기반으로 75로 평가","degree_required":"degree_required는 [주차관리원]\n-차량 진입을 통제한다.\n-주차 공간을 안내한다.\n-주차 요금을 징수한다.\n-차량 안전을 감독한다.\n-주차장을 순찰한다.\n-문제 상황을 해결한다.\n-주차 기록을 관리... 기반으로 none로 평가","license_required":"license_required는 [주차관리원]\n-차량 진입을 통제한다.\n-주차 공간을 안내한다.\n-주차 요금을 징수한다.\n-차량 안전을 감독한다.\n-주차장을 순찰한다.\n-문제 상황을 해결한다.\n-주차 기록을 관리... 기반으로 none로 평가"}'
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