-- Batch tagging SQL generated at 2026-01-06T06:56:38.822Z
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
  '1765283435222108',
  '컴퓨터시스템설계 및 분석가',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 50, 50,
  70, 30, 50, 50, 50, 35,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [컴퓨터시스템설계사]\n-사용자 요구사항을 분석한다.\n-시스템 아키텍처를 설계한다.\n-데이터베이스 구조를 설계한다.\n-네트워크 구성을 계획한다.\n-보안 요구사항을 정의한다.\n-시스템... 기반으로 50로 평가","growth":"growth는 [컴퓨터시스템설계사]\n-사용자 요구사항을 분석한다.\n-시스템 아키텍처를 설계한다.\n-데이터베이스 구조를 설계한다.\n-네트워크 구성을 계획한다.\n-보안 요구사항을 정의한다.\n-시스템... 기반으로 65로 평가","stability":"stability는 [컴퓨터시스템설계사]\n-사용자 요구사항을 분석한다.\n-시스템 아키텍처를 설계한다.\n-데이터베이스 구조를 설계한다.\n-네트워크 구성을 계획한다.\n-보안 요구사항을 정의한다.\n-시스템... 기반으로 50로 평가","income":"income는 [컴퓨터시스템설계사]\n-사용자 요구사항을 분석한다.\n-시스템 아키텍처를 설계한다.\n-데이터베이스 구조를 설계한다.\n-네트워크 구성을 계획한다.\n-보안 요구사항을 정의한다.\n-시스템... 기반으로 50로 평가","teamwork":"teamwork는 [컴퓨터시스템설계사]\n-사용자 요구사항을 분석한다.\n-시스템 아키텍처를 설계한다.\n-데이터베이스 구조를 설계한다.\n-네트워크 구성을 계획한다.\n-보안 요구사항을 정의한다.\n-시스템... 기반으로 70로 평가","solo_deep":"solo_deep는 [컴퓨터시스템설계사]\n-사용자 요구사항을 분석한다.\n-시스템 아키텍처를 설계한다.\n-데이터베이스 구조를 설계한다.\n-네트워크 구성을 계획한다.\n-보안 요구사항을 정의한다.\n-시스템... 기반으로 30로 평가","analytical":"analytical는 [컴퓨터시스템설계사]\n-사용자 요구사항을 분석한다.\n-시스템 아키텍처를 설계한다.\n-데이터베이스 구조를 설계한다.\n-네트워크 구성을 계획한다.\n-보안 요구사항을 정의한다.\n-시스템... 기반으로 50로 평가","creative":"creative는 [컴퓨터시스템설계사]\n-사용자 요구사항을 분석한다.\n-시스템 아키텍처를 설계한다.\n-데이터베이스 구조를 설계한다.\n-네트워크 구성을 계획한다.\n-보안 요구사항을 정의한다.\n-시스템... 기반으로 50로 평가","execution":"execution는 [컴퓨터시스템설계사]\n-사용자 요구사항을 분석한다.\n-시스템 아키텍처를 설계한다.\n-데이터베이스 구조를 설계한다.\n-네트워크 구성을 계획한다.\n-보안 요구사항을 정의한다.\n-시스템... 기반으로 50로 평가","people_facing":"people_facing는 [컴퓨터시스템설계사]\n-사용자 요구사항을 분석한다.\n-시스템 아키텍처를 설계한다.\n-데이터베이스 구조를 설계한다.\n-네트워크 구성을 계획한다.\n-보안 요구사항을 정의한다.\n-시스템... 기반으로 35로 평가","degree_required":"degree_required는 [컴퓨터시스템설계사]\n-사용자 요구사항을 분석한다.\n-시스템 아키텍처를 설계한다.\n-데이터베이스 구조를 설계한다.\n-네트워크 구성을 계획한다.\n-보안 요구사항을 정의한다.\n-시스템... 기반으로 none로 평가","license_required":"license_required는 [컴퓨터시스템설계사]\n-사용자 요구사항을 분석한다.\n-시스템 아키텍처를 설계한다.\n-데이터베이스 구조를 설계한다.\n-네트워크 구성을 계획한다.\n-보안 요구사항을 정의한다.\n-시스템... 기반으로 none로 평가"}'
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
  '1765283460171364',
  '청소년지도사',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 75, 50, 50,
  30, 70, 30, 60, 60, 75,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [청소년상담사]\n-청소년의 고민을 상담한다.\n-정서적 지지를 제공한다.\n-진로 상담을 진행한다.\n-학습 지도를 돕는다.\n-부모 상담을 실시한다.\n-위기 청소년을 지원한다.\n-프로그... 기반으로 50로 평가","growth":"growth는 [청소년상담사]\n-청소년의 고민을 상담한다.\n-정서적 지지를 제공한다.\n-진로 상담을 진행한다.\n-학습 지도를 돕는다.\n-부모 상담을 실시한다.\n-위기 청소년을 지원한다.\n-프로그... 기반으로 75로 평가","stability":"stability는 [청소년상담사]\n-청소년의 고민을 상담한다.\n-정서적 지지를 제공한다.\n-진로 상담을 진행한다.\n-학습 지도를 돕는다.\n-부모 상담을 실시한다.\n-위기 청소년을 지원한다.\n-프로그... 기반으로 50로 평가","income":"income는 [청소년상담사]\n-청소년의 고민을 상담한다.\n-정서적 지지를 제공한다.\n-진로 상담을 진행한다.\n-학습 지도를 돕는다.\n-부모 상담을 실시한다.\n-위기 청소년을 지원한다.\n-프로그... 기반으로 50로 평가","teamwork":"teamwork는 [청소년상담사]\n-청소년의 고민을 상담한다.\n-정서적 지지를 제공한다.\n-진로 상담을 진행한다.\n-학습 지도를 돕는다.\n-부모 상담을 실시한다.\n-위기 청소년을 지원한다.\n-프로그... 기반으로 30로 평가","solo_deep":"solo_deep는 [청소년상담사]\n-청소년의 고민을 상담한다.\n-정서적 지지를 제공한다.\n-진로 상담을 진행한다.\n-학습 지도를 돕는다.\n-부모 상담을 실시한다.\n-위기 청소년을 지원한다.\n-프로그... 기반으로 70로 평가","analytical":"analytical는 [청소년상담사]\n-청소년의 고민을 상담한다.\n-정서적 지지를 제공한다.\n-진로 상담을 진행한다.\n-학습 지도를 돕는다.\n-부모 상담을 실시한다.\n-위기 청소년을 지원한다.\n-프로그... 기반으로 30로 평가","creative":"creative는 [청소년상담사]\n-청소년의 고민을 상담한다.\n-정서적 지지를 제공한다.\n-진로 상담을 진행한다.\n-학습 지도를 돕는다.\n-부모 상담을 실시한다.\n-위기 청소년을 지원한다.\n-프로그... 기반으로 60로 평가","execution":"execution는 [청소년상담사]\n-청소년의 고민을 상담한다.\n-정서적 지지를 제공한다.\n-진로 상담을 진행한다.\n-학습 지도를 돕는다.\n-부모 상담을 실시한다.\n-위기 청소년을 지원한다.\n-프로그... 기반으로 60로 평가","people_facing":"people_facing는 [청소년상담사]\n-청소년의 고민을 상담한다.\n-정서적 지지를 제공한다.\n-진로 상담을 진행한다.\n-학습 지도를 돕는다.\n-부모 상담을 실시한다.\n-위기 청소년을 지원한다.\n-프로그... 기반으로 75로 평가","degree_required":"degree_required는 [청소년상담사]\n-청소년의 고민을 상담한다.\n-정서적 지지를 제공한다.\n-진로 상담을 진행한다.\n-학습 지도를 돕는다.\n-부모 상담을 실시한다.\n-위기 청소년을 지원한다.\n-프로그... 기반으로 none로 평가","license_required":"license_required는 [청소년상담사]\n-청소년의 고민을 상담한다.\n-정서적 지지를 제공한다.\n-진로 상담을 진행한다.\n-학습 지도를 돕는다.\n-부모 상담을 실시한다.\n-위기 청소년을 지원한다.\n-프로그... 기반으로 none로 평가"}'
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
  '1765283460711835',
  '생활지도원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 75, 50, 50,
  30, 70, 30, 60, 60, 75,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [생활지도교사]\n-학생들의 일상 생활을 감독한다.\n-기숙사 생활을 관리한다.\n-생활 규칙을 교육한다.\n-청결과 안전을 유지한다.\n-개인 위생을 지도한다.\n-식사와 취침을 관리한다.... 기반으로 50로 평가","growth":"growth는 [생활지도교사]\n-학생들의 일상 생활을 감독한다.\n-기숙사 생활을 관리한다.\n-생활 규칙을 교육한다.\n-청결과 안전을 유지한다.\n-개인 위생을 지도한다.\n-식사와 취침을 관리한다.... 기반으로 75로 평가","stability":"stability는 [생활지도교사]\n-학생들의 일상 생활을 감독한다.\n-기숙사 생활을 관리한다.\n-생활 규칙을 교육한다.\n-청결과 안전을 유지한다.\n-개인 위생을 지도한다.\n-식사와 취침을 관리한다.... 기반으로 50로 평가","income":"income는 [생활지도교사]\n-학생들의 일상 생활을 감독한다.\n-기숙사 생활을 관리한다.\n-생활 규칙을 교육한다.\n-청결과 안전을 유지한다.\n-개인 위생을 지도한다.\n-식사와 취침을 관리한다.... 기반으로 50로 평가","teamwork":"teamwork는 [생활지도교사]\n-학생들의 일상 생활을 감독한다.\n-기숙사 생활을 관리한다.\n-생활 규칙을 교육한다.\n-청결과 안전을 유지한다.\n-개인 위생을 지도한다.\n-식사와 취침을 관리한다.... 기반으로 30로 평가","solo_deep":"solo_deep는 [생활지도교사]\n-학생들의 일상 생활을 감독한다.\n-기숙사 생활을 관리한다.\n-생활 규칙을 교육한다.\n-청결과 안전을 유지한다.\n-개인 위생을 지도한다.\n-식사와 취침을 관리한다.... 기반으로 70로 평가","analytical":"analytical는 [생활지도교사]\n-학생들의 일상 생활을 감독한다.\n-기숙사 생활을 관리한다.\n-생활 규칙을 교육한다.\n-청결과 안전을 유지한다.\n-개인 위생을 지도한다.\n-식사와 취침을 관리한다.... 기반으로 30로 평가","creative":"creative는 [생활지도교사]\n-학생들의 일상 생활을 감독한다.\n-기숙사 생활을 관리한다.\n-생활 규칙을 교육한다.\n-청결과 안전을 유지한다.\n-개인 위생을 지도한다.\n-식사와 취침을 관리한다.... 기반으로 60로 평가","execution":"execution는 [생활지도교사]\n-학생들의 일상 생활을 감독한다.\n-기숙사 생활을 관리한다.\n-생활 규칙을 교육한다.\n-청결과 안전을 유지한다.\n-개인 위생을 지도한다.\n-식사와 취침을 관리한다.... 기반으로 60로 평가","people_facing":"people_facing는 [생활지도교사]\n-학생들의 일상 생활을 감독한다.\n-기숙사 생활을 관리한다.\n-생활 규칙을 교육한다.\n-청결과 안전을 유지한다.\n-개인 위생을 지도한다.\n-식사와 취침을 관리한다.... 기반으로 75로 평가","degree_required":"degree_required는 [생활지도교사]\n-학생들의 일상 생활을 감독한다.\n-기숙사 생활을 관리한다.\n-생활 규칙을 교육한다.\n-청결과 안전을 유지한다.\n-개인 위생을 지도한다.\n-식사와 취침을 관리한다.... 기반으로 none로 평가","license_required":"license_required는 [생활지도교사]\n-학생들의 일상 생활을 감독한다.\n-기숙사 생활을 관리한다.\n-생활 규칙을 교육한다.\n-청결과 안전을 유지한다.\n-개인 위생을 지도한다.\n-식사와 취침을 관리한다.... 기반으로 none로 평가"}'
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
  '1765283427741398',
  '신용분석가',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 70, 50,
  30, 70, 50, 50, 50, 60,
  'regular', 'none', 'none', 'partial',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [신용평가사]\n-기업의 재무 상태를 분석한다.\n-신용 등급을 평가한다.\n-리스크를 평가한다.\n-보고서를 작성한다.\n-신용 정보를 수집한다.\n-모델을 개발한다.\n-의사결정을 지원한다... 기반으로 50로 평가","growth":"growth는 [신용평가사]\n-기업의 재무 상태를 분석한다.\n-신용 등급을 평가한다.\n-리스크를 평가한다.\n-보고서를 작성한다.\n-신용 정보를 수집한다.\n-모델을 개발한다.\n-의사결정을 지원한다... 기반으로 65로 평가","stability":"stability는 [신용평가사]\n-기업의 재무 상태를 분석한다.\n-신용 등급을 평가한다.\n-리스크를 평가한다.\n-보고서를 작성한다.\n-신용 정보를 수집한다.\n-모델을 개발한다.\n-의사결정을 지원한다... 기반으로 70로 평가","income":"income는 [신용평가사]\n-기업의 재무 상태를 분석한다.\n-신용 등급을 평가한다.\n-리스크를 평가한다.\n-보고서를 작성한다.\n-신용 정보를 수집한다.\n-모델을 개발한다.\n-의사결정을 지원한다... 기반으로 50로 평가","teamwork":"teamwork는 [신용평가사]\n-기업의 재무 상태를 분석한다.\n-신용 등급을 평가한다.\n-리스크를 평가한다.\n-보고서를 작성한다.\n-신용 정보를 수집한다.\n-모델을 개발한다.\n-의사결정을 지원한다... 기반으로 30로 평가","solo_deep":"solo_deep는 [신용평가사]\n-기업의 재무 상태를 분석한다.\n-신용 등급을 평가한다.\n-리스크를 평가한다.\n-보고서를 작성한다.\n-신용 정보를 수집한다.\n-모델을 개발한다.\n-의사결정을 지원한다... 기반으로 70로 평가","analytical":"analytical는 [신용평가사]\n-기업의 재무 상태를 분석한다.\n-신용 등급을 평가한다.\n-리스크를 평가한다.\n-보고서를 작성한다.\n-신용 정보를 수집한다.\n-모델을 개발한다.\n-의사결정을 지원한다... 기반으로 50로 평가","creative":"creative는 [신용평가사]\n-기업의 재무 상태를 분석한다.\n-신용 등급을 평가한다.\n-리스크를 평가한다.\n-보고서를 작성한다.\n-신용 정보를 수집한다.\n-모델을 개발한다.\n-의사결정을 지원한다... 기반으로 50로 평가","execution":"execution는 [신용평가사]\n-기업의 재무 상태를 분석한다.\n-신용 등급을 평가한다.\n-리스크를 평가한다.\n-보고서를 작성한다.\n-신용 정보를 수집한다.\n-모델을 개발한다.\n-의사결정을 지원한다... 기반으로 50로 평가","people_facing":"people_facing는 [신용평가사]\n-기업의 재무 상태를 분석한다.\n-신용 등급을 평가한다.\n-리스크를 평가한다.\n-보고서를 작성한다.\n-신용 정보를 수집한다.\n-모델을 개발한다.\n-의사결정을 지원한다... 기반으로 60로 평가","degree_required":"degree_required는 [신용평가사]\n-기업의 재무 상태를 분석한다.\n-신용 등급을 평가한다.\n-리스크를 평가한다.\n-보고서를 작성한다.\n-신용 정보를 수집한다.\n-모델을 개발한다.\n-의사결정을 지원한다... 기반으로 none로 평가","license_required":"license_required는 [신용평가사]\n-기업의 재무 상태를 분석한다.\n-신용 등급을 평가한다.\n-리스크를 평가한다.\n-보고서를 작성한다.\n-신용 정보를 수집한다.\n-모델을 개발한다.\n-의사결정을 지원한다... 기반으로 none로 평가"}'
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
  '1765283413242494',
  '제조·생산관리자',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  70, 30, 40, 40, 70, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [생산관리자]\n-생산 계획을 수립한다.\n-자원을 배분한다.\n-생산 일정을 관리한다.\n-품질을 감독한다.\n-효율성을 개선한다.\n-비용을 통제한다.\n-팀을 감독한다.\n-보고서를 작성한... 기반으로 50로 평가","growth":"growth는 [생산관리자]\n-생산 계획을 수립한다.\n-자원을 배분한다.\n-생산 일정을 관리한다.\n-품질을 감독한다.\n-효율성을 개선한다.\n-비용을 통제한다.\n-팀을 감독한다.\n-보고서를 작성한... 기반으로 50로 평가","stability":"stability는 [생산관리자]\n-생산 계획을 수립한다.\n-자원을 배분한다.\n-생산 일정을 관리한다.\n-품질을 감독한다.\n-효율성을 개선한다.\n-비용을 통제한다.\n-팀을 감독한다.\n-보고서를 작성한... 기반으로 50로 평가","income":"income는 [생산관리자]\n-생산 계획을 수립한다.\n-자원을 배분한다.\n-생산 일정을 관리한다.\n-품질을 감독한다.\n-효율성을 개선한다.\n-비용을 통제한다.\n-팀을 감독한다.\n-보고서를 작성한... 기반으로 50로 평가","teamwork":"teamwork는 [생산관리자]\n-생산 계획을 수립한다.\n-자원을 배분한다.\n-생산 일정을 관리한다.\n-품질을 감독한다.\n-효율성을 개선한다.\n-비용을 통제한다.\n-팀을 감독한다.\n-보고서를 작성한... 기반으로 70로 평가","solo_deep":"solo_deep는 [생산관리자]\n-생산 계획을 수립한다.\n-자원을 배분한다.\n-생산 일정을 관리한다.\n-품질을 감독한다.\n-효율성을 개선한다.\n-비용을 통제한다.\n-팀을 감독한다.\n-보고서를 작성한... 기반으로 30로 평가","analytical":"analytical는 [생산관리자]\n-생산 계획을 수립한다.\n-자원을 배분한다.\n-생산 일정을 관리한다.\n-품질을 감독한다.\n-효율성을 개선한다.\n-비용을 통제한다.\n-팀을 감독한다.\n-보고서를 작성한... 기반으로 40로 평가","creative":"creative는 [생산관리자]\n-생산 계획을 수립한다.\n-자원을 배분한다.\n-생산 일정을 관리한다.\n-품질을 감독한다.\n-효율성을 개선한다.\n-비용을 통제한다.\n-팀을 감독한다.\n-보고서를 작성한... 기반으로 40로 평가","execution":"execution는 [생산관리자]\n-생산 계획을 수립한다.\n-자원을 배분한다.\n-생산 일정을 관리한다.\n-품질을 감독한다.\n-효율성을 개선한다.\n-비용을 통제한다.\n-팀을 감독한다.\n-보고서를 작성한... 기반으로 70로 평가","people_facing":"people_facing는 [생산관리자]\n-생산 계획을 수립한다.\n-자원을 배분한다.\n-생산 일정을 관리한다.\n-품질을 감독한다.\n-효율성을 개선한다.\n-비용을 통제한다.\n-팀을 감독한다.\n-보고서를 작성한... 기반으로 50로 평가","degree_required":"degree_required는 [생산관리자]\n-생산 계획을 수립한다.\n-자원을 배분한다.\n-생산 일정을 관리한다.\n-품질을 감독한다.\n-효율성을 개선한다.\n-비용을 통제한다.\n-팀을 감독한다.\n-보고서를 작성한... 기반으로 none로 평가","license_required":"license_required는 [생산관리자]\n-생산 계획을 수립한다.\n-자원을 배분한다.\n-생산 일정을 관리한다.\n-품질을 감독한다.\n-효율성을 개선한다.\n-비용을 통제한다.\n-팀을 감독한다.\n-보고서를 작성한... 기반으로 none로 평가"}'
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
  '1765283412115147',
  '영업·판매관리자',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 75, 50, 50,
  70, 30, 50, 50, 50, 60,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [영업관리자]\n-영업 전략을 수립한다.\n-판매 목표를 설정한다.\n-팀을 관리한다.\n-성과를 모니터링한다.\n-교육을 실시한다.\n-고객 관계를 관리한다.\n-시장 분석을 진행한다.\n-보... 기반으로 50로 평가","growth":"growth는 [영업관리자]\n-영업 전략을 수립한다.\n-판매 목표를 설정한다.\n-팀을 관리한다.\n-성과를 모니터링한다.\n-교육을 실시한다.\n-고객 관계를 관리한다.\n-시장 분석을 진행한다.\n-보... 기반으로 75로 평가","stability":"stability는 [영업관리자]\n-영업 전략을 수립한다.\n-판매 목표를 설정한다.\n-팀을 관리한다.\n-성과를 모니터링한다.\n-교육을 실시한다.\n-고객 관계를 관리한다.\n-시장 분석을 진행한다.\n-보... 기반으로 50로 평가","income":"income는 [영업관리자]\n-영업 전략을 수립한다.\n-판매 목표를 설정한다.\n-팀을 관리한다.\n-성과를 모니터링한다.\n-교육을 실시한다.\n-고객 관계를 관리한다.\n-시장 분석을 진행한다.\n-보... 기반으로 50로 평가","teamwork":"teamwork는 [영업관리자]\n-영업 전략을 수립한다.\n-판매 목표를 설정한다.\n-팀을 관리한다.\n-성과를 모니터링한다.\n-교육을 실시한다.\n-고객 관계를 관리한다.\n-시장 분석을 진행한다.\n-보... 기반으로 70로 평가","solo_deep":"solo_deep는 [영업관리자]\n-영업 전략을 수립한다.\n-판매 목표를 설정한다.\n-팀을 관리한다.\n-성과를 모니터링한다.\n-교육을 실시한다.\n-고객 관계를 관리한다.\n-시장 분석을 진행한다.\n-보... 기반으로 30로 평가","analytical":"analytical는 [영업관리자]\n-영업 전략을 수립한다.\n-판매 목표를 설정한다.\n-팀을 관리한다.\n-성과를 모니터링한다.\n-교육을 실시한다.\n-고객 관계를 관리한다.\n-시장 분석을 진행한다.\n-보... 기반으로 50로 평가","creative":"creative는 [영업관리자]\n-영업 전략을 수립한다.\n-판매 목표를 설정한다.\n-팀을 관리한다.\n-성과를 모니터링한다.\n-교육을 실시한다.\n-고객 관계를 관리한다.\n-시장 분석을 진행한다.\n-보... 기반으로 50로 평가","execution":"execution는 [영업관리자]\n-영업 전략을 수립한다.\n-판매 목표를 설정한다.\n-팀을 관리한다.\n-성과를 모니터링한다.\n-교육을 실시한다.\n-고객 관계를 관리한다.\n-시장 분석을 진행한다.\n-보... 기반으로 50로 평가","people_facing":"people_facing는 [영업관리자]\n-영업 전략을 수립한다.\n-판매 목표를 설정한다.\n-팀을 관리한다.\n-성과를 모니터링한다.\n-교육을 실시한다.\n-고객 관계를 관리한다.\n-시장 분석을 진행한다.\n-보... 기반으로 60로 평가","degree_required":"degree_required는 [영업관리자]\n-영업 전략을 수립한다.\n-판매 목표를 설정한다.\n-팀을 관리한다.\n-성과를 모니터링한다.\n-교육을 실시한다.\n-고객 관계를 관리한다.\n-시장 분석을 진행한다.\n-보... 기반으로 none로 평가","license_required":"license_required는 [영업관리자]\n-영업 전략을 수립한다.\n-판매 목표를 설정한다.\n-팀을 관리한다.\n-성과를 모니터링한다.\n-교육을 실시한다.\n-고객 관계를 관리한다.\n-시장 분석을 진행한다.\n-보... 기반으로 none로 평가"}'
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
  '1765283416814542',
  '광고·홍보·마케팅사무원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 50, 50,
  50, 50, 50, 50, 50, 75,
  'regular', 'none', 'none', 'partial',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [광고사무원]\n-광고 자료를 준비한다.\n-광고 게재를 관리한다.\n-계약서를 작성한다.\n-광고비를 정산한다.\n-광고 효과를 분석한다.\n-고객과 소통한다.\n-문서를 관리한다.\n-보고서... 기반으로 50로 평가","growth":"growth는 [광고사무원]\n-광고 자료를 준비한다.\n-광고 게재를 관리한다.\n-계약서를 작성한다.\n-광고비를 정산한다.\n-광고 효과를 분석한다.\n-고객과 소통한다.\n-문서를 관리한다.\n-보고서... 기반으로 65로 평가","stability":"stability는 [광고사무원]\n-광고 자료를 준비한다.\n-광고 게재를 관리한다.\n-계약서를 작성한다.\n-광고비를 정산한다.\n-광고 효과를 분석한다.\n-고객과 소통한다.\n-문서를 관리한다.\n-보고서... 기반으로 50로 평가","income":"income는 [광고사무원]\n-광고 자료를 준비한다.\n-광고 게재를 관리한다.\n-계약서를 작성한다.\n-광고비를 정산한다.\n-광고 효과를 분석한다.\n-고객과 소통한다.\n-문서를 관리한다.\n-보고서... 기반으로 50로 평가","teamwork":"teamwork는 [광고사무원]\n-광고 자료를 준비한다.\n-광고 게재를 관리한다.\n-계약서를 작성한다.\n-광고비를 정산한다.\n-광고 효과를 분석한다.\n-고객과 소통한다.\n-문서를 관리한다.\n-보고서... 기반으로 50로 평가","solo_deep":"solo_deep는 [광고사무원]\n-광고 자료를 준비한다.\n-광고 게재를 관리한다.\n-계약서를 작성한다.\n-광고비를 정산한다.\n-광고 효과를 분석한다.\n-고객과 소통한다.\n-문서를 관리한다.\n-보고서... 기반으로 50로 평가","analytical":"analytical는 [광고사무원]\n-광고 자료를 준비한다.\n-광고 게재를 관리한다.\n-계약서를 작성한다.\n-광고비를 정산한다.\n-광고 효과를 분석한다.\n-고객과 소통한다.\n-문서를 관리한다.\n-보고서... 기반으로 50로 평가","creative":"creative는 [광고사무원]\n-광고 자료를 준비한다.\n-광고 게재를 관리한다.\n-계약서를 작성한다.\n-광고비를 정산한다.\n-광고 효과를 분석한다.\n-고객과 소통한다.\n-문서를 관리한다.\n-보고서... 기반으로 50로 평가","execution":"execution는 [광고사무원]\n-광고 자료를 준비한다.\n-광고 게재를 관리한다.\n-계약서를 작성한다.\n-광고비를 정산한다.\n-광고 효과를 분석한다.\n-고객과 소통한다.\n-문서를 관리한다.\n-보고서... 기반으로 50로 평가","people_facing":"people_facing는 [광고사무원]\n-광고 자료를 준비한다.\n-광고 게재를 관리한다.\n-계약서를 작성한다.\n-광고비를 정산한다.\n-광고 효과를 분석한다.\n-고객과 소통한다.\n-문서를 관리한다.\n-보고서... 기반으로 75로 평가","degree_required":"degree_required는 [광고사무원]\n-광고 자료를 준비한다.\n-광고 게재를 관리한다.\n-계약서를 작성한다.\n-광고비를 정산한다.\n-광고 효과를 분석한다.\n-고객과 소통한다.\n-문서를 관리한다.\n-보고서... 기반으로 none로 평가","license_required":"license_required는 [광고사무원]\n-광고 자료를 준비한다.\n-광고 게재를 관리한다.\n-계약서를 작성한다.\n-광고비를 정산한다.\n-광고 효과를 분석한다.\n-고객과 소통한다.\n-문서를 관리한다.\n-보고서... 기반으로 none로 평가"}'
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
  '1765283531374356',
  '과수작물재배원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 75, 50, 50,
  50, 50, 60, 30, 60, 35,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [과수원관리자]\n-나무를 심는다.\n-물을 공급한다.\n-비료를 준다.\n-해충을 방제한다.\n-가지치기를 한다.\n-수확을 한다.\n-품질을 검사한다.\n-장비를 유지한다.\n-기록을 관리한다... 기반으로 50로 평가","growth":"growth는 [과수원관리자]\n-나무를 심는다.\n-물을 공급한다.\n-비료를 준다.\n-해충을 방제한다.\n-가지치기를 한다.\n-수확을 한다.\n-품질을 검사한다.\n-장비를 유지한다.\n-기록을 관리한다... 기반으로 75로 평가","stability":"stability는 [과수원관리자]\n-나무를 심는다.\n-물을 공급한다.\n-비료를 준다.\n-해충을 방제한다.\n-가지치기를 한다.\n-수확을 한다.\n-품질을 검사한다.\n-장비를 유지한다.\n-기록을 관리한다... 기반으로 50로 평가","income":"income는 [과수원관리자]\n-나무를 심는다.\n-물을 공급한다.\n-비료를 준다.\n-해충을 방제한다.\n-가지치기를 한다.\n-수확을 한다.\n-품질을 검사한다.\n-장비를 유지한다.\n-기록을 관리한다... 기반으로 50로 평가","teamwork":"teamwork는 [과수원관리자]\n-나무를 심는다.\n-물을 공급한다.\n-비료를 준다.\n-해충을 방제한다.\n-가지치기를 한다.\n-수확을 한다.\n-품질을 검사한다.\n-장비를 유지한다.\n-기록을 관리한다... 기반으로 50로 평가","solo_deep":"solo_deep는 [과수원관리자]\n-나무를 심는다.\n-물을 공급한다.\n-비료를 준다.\n-해충을 방제한다.\n-가지치기를 한다.\n-수확을 한다.\n-품질을 검사한다.\n-장비를 유지한다.\n-기록을 관리한다... 기반으로 50로 평가","analytical":"analytical는 [과수원관리자]\n-나무를 심는다.\n-물을 공급한다.\n-비료를 준다.\n-해충을 방제한다.\n-가지치기를 한다.\n-수확을 한다.\n-품질을 검사한다.\n-장비를 유지한다.\n-기록을 관리한다... 기반으로 60로 평가","creative":"creative는 [과수원관리자]\n-나무를 심는다.\n-물을 공급한다.\n-비료를 준다.\n-해충을 방제한다.\n-가지치기를 한다.\n-수확을 한다.\n-품질을 검사한다.\n-장비를 유지한다.\n-기록을 관리한다... 기반으로 30로 평가","execution":"execution는 [과수원관리자]\n-나무를 심는다.\n-물을 공급한다.\n-비료를 준다.\n-해충을 방제한다.\n-가지치기를 한다.\n-수확을 한다.\n-품질을 검사한다.\n-장비를 유지한다.\n-기록을 관리한다... 기반으로 60로 평가","people_facing":"people_facing는 [과수원관리자]\n-나무를 심는다.\n-물을 공급한다.\n-비료를 준다.\n-해충을 방제한다.\n-가지치기를 한다.\n-수확을 한다.\n-품질을 검사한다.\n-장비를 유지한다.\n-기록을 관리한다... 기반으로 35로 평가","degree_required":"degree_required는 [과수원관리자]\n-나무를 심는다.\n-물을 공급한다.\n-비료를 준다.\n-해충을 방제한다.\n-가지치기를 한다.\n-수확을 한다.\n-품질을 검사한다.\n-장비를 유지한다.\n-기록을 관리한다... 기반으로 none로 평가","license_required":"license_required는 [과수원관리자]\n-나무를 심는다.\n-물을 공급한다.\n-비료를 준다.\n-해충을 방제한다.\n-가지치기를 한다.\n-수확을 한다.\n-품질을 검사한다.\n-장비를 유지한다.\n-기록을 관리한다... 기반으로 none로 평가"}'
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
  '1765283497973108',
  '타일·대리석시공원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  50, 50, 40, 40, 70, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [타일시공원]\n-바닥을 준비한다.\n-타일을 재단한다.\n-접착제를 바른다.\n-타일을 붙인다.\n-줄눈을 채운다.\n-표면을 마무리한다.\n-품질을 검사한다.\n-안전 수칙을 준수한다.\n-도... 기반으로 50로 평가","growth":"growth는 [타일시공원]\n-바닥을 준비한다.\n-타일을 재단한다.\n-접착제를 바른다.\n-타일을 붙인다.\n-줄눈을 채운다.\n-표면을 마무리한다.\n-품질을 검사한다.\n-안전 수칙을 준수한다.\n-도... 기반으로 50로 평가","stability":"stability는 [타일시공원]\n-바닥을 준비한다.\n-타일을 재단한다.\n-접착제를 바른다.\n-타일을 붙인다.\n-줄눈을 채운다.\n-표면을 마무리한다.\n-품질을 검사한다.\n-안전 수칙을 준수한다.\n-도... 기반으로 50로 평가","income":"income는 [타일시공원]\n-바닥을 준비한다.\n-타일을 재단한다.\n-접착제를 바른다.\n-타일을 붙인다.\n-줄눈을 채운다.\n-표면을 마무리한다.\n-품질을 검사한다.\n-안전 수칙을 준수한다.\n-도... 기반으로 50로 평가","teamwork":"teamwork는 [타일시공원]\n-바닥을 준비한다.\n-타일을 재단한다.\n-접착제를 바른다.\n-타일을 붙인다.\n-줄눈을 채운다.\n-표면을 마무리한다.\n-품질을 검사한다.\n-안전 수칙을 준수한다.\n-도... 기반으로 50로 평가","solo_deep":"solo_deep는 [타일시공원]\n-바닥을 준비한다.\n-타일을 재단한다.\n-접착제를 바른다.\n-타일을 붙인다.\n-줄눈을 채운다.\n-표면을 마무리한다.\n-품질을 검사한다.\n-안전 수칙을 준수한다.\n-도... 기반으로 50로 평가","analytical":"analytical는 [타일시공원]\n-바닥을 준비한다.\n-타일을 재단한다.\n-접착제를 바른다.\n-타일을 붙인다.\n-줄눈을 채운다.\n-표면을 마무리한다.\n-품질을 검사한다.\n-안전 수칙을 준수한다.\n-도... 기반으로 40로 평가","creative":"creative는 [타일시공원]\n-바닥을 준비한다.\n-타일을 재단한다.\n-접착제를 바른다.\n-타일을 붙인다.\n-줄눈을 채운다.\n-표면을 마무리한다.\n-품질을 검사한다.\n-안전 수칙을 준수한다.\n-도... 기반으로 40로 평가","execution":"execution는 [타일시공원]\n-바닥을 준비한다.\n-타일을 재단한다.\n-접착제를 바른다.\n-타일을 붙인다.\n-줄눈을 채운다.\n-표면을 마무리한다.\n-품질을 검사한다.\n-안전 수칙을 준수한다.\n-도... 기반으로 70로 평가","people_facing":"people_facing는 [타일시공원]\n-바닥을 준비한다.\n-타일을 재단한다.\n-접착제를 바른다.\n-타일을 붙인다.\n-줄눈을 채운다.\n-표면을 마무리한다.\n-품질을 검사한다.\n-안전 수칙을 준수한다.\n-도... 기반으로 50로 평가","degree_required":"degree_required는 [타일시공원]\n-바닥을 준비한다.\n-타일을 재단한다.\n-접착제를 바른다.\n-타일을 붙인다.\n-줄눈을 채운다.\n-표면을 마무리한다.\n-품질을 검사한다.\n-안전 수칙을 준수한다.\n-도... 기반으로 none로 평가","license_required":"license_required는 [타일시공원]\n-바닥을 준비한다.\n-타일을 재단한다.\n-접착제를 바른다.\n-타일을 붙인다.\n-줄눈을 채운다.\n-표면을 마무리한다.\n-품질을 검사한다.\n-안전 수칙을 준수한다.\n-도... 기반으로 none로 평가"}'
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
  '1765283472672395',
  '영상·녹화 및 편집기사',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 40,
  50, 50, 40, 40, 70, 50,
  'regular', 'none', 'none', 'none',
  'college', 'preferred', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [영상촬영기사]\n-촬영 장비를 준비한다.\n-촬영 계획을 수립한다.\n-조명과 구도를 설정한다.\n-촬영을 진행한다.\n-음성을 녹음한다.\n-장면을 연출한다.\n-안전 수칙을 준수한다.\n-... 기반으로 50로 평가","growth":"growth는 [영상촬영기사]\n-촬영 장비를 준비한다.\n-촬영 계획을 수립한다.\n-조명과 구도를 설정한다.\n-촬영을 진행한다.\n-음성을 녹음한다.\n-장면을 연출한다.\n-안전 수칙을 준수한다.\n-... 기반으로 50로 평가","stability":"stability는 [영상촬영기사]\n-촬영 장비를 준비한다.\n-촬영 계획을 수립한다.\n-조명과 구도를 설정한다.\n-촬영을 진행한다.\n-음성을 녹음한다.\n-장면을 연출한다.\n-안전 수칙을 준수한다.\n-... 기반으로 50로 평가","income":"income는 [영상촬영기사]\n-촬영 장비를 준비한다.\n-촬영 계획을 수립한다.\n-조명과 구도를 설정한다.\n-촬영을 진행한다.\n-음성을 녹음한다.\n-장면을 연출한다.\n-안전 수칙을 준수한다.\n-... 기반으로 40로 평가","teamwork":"teamwork는 [영상촬영기사]\n-촬영 장비를 준비한다.\n-촬영 계획을 수립한다.\n-조명과 구도를 설정한다.\n-촬영을 진행한다.\n-음성을 녹음한다.\n-장면을 연출한다.\n-안전 수칙을 준수한다.\n-... 기반으로 50로 평가","solo_deep":"solo_deep는 [영상촬영기사]\n-촬영 장비를 준비한다.\n-촬영 계획을 수립한다.\n-조명과 구도를 설정한다.\n-촬영을 진행한다.\n-음성을 녹음한다.\n-장면을 연출한다.\n-안전 수칙을 준수한다.\n-... 기반으로 50로 평가","analytical":"analytical는 [영상촬영기사]\n-촬영 장비를 준비한다.\n-촬영 계획을 수립한다.\n-조명과 구도를 설정한다.\n-촬영을 진행한다.\n-음성을 녹음한다.\n-장면을 연출한다.\n-안전 수칙을 준수한다.\n-... 기반으로 40로 평가","creative":"creative는 [영상촬영기사]\n-촬영 장비를 준비한다.\n-촬영 계획을 수립한다.\n-조명과 구도를 설정한다.\n-촬영을 진행한다.\n-음성을 녹음한다.\n-장면을 연출한다.\n-안전 수칙을 준수한다.\n-... 기반으로 40로 평가","execution":"execution는 [영상촬영기사]\n-촬영 장비를 준비한다.\n-촬영 계획을 수립한다.\n-조명과 구도를 설정한다.\n-촬영을 진행한다.\n-음성을 녹음한다.\n-장면을 연출한다.\n-안전 수칙을 준수한다.\n-... 기반으로 70로 평가","people_facing":"people_facing는 [영상촬영기사]\n-촬영 장비를 준비한다.\n-촬영 계획을 수립한다.\n-조명과 구도를 설정한다.\n-촬영을 진행한다.\n-음성을 녹음한다.\n-장면을 연출한다.\n-안전 수칙을 준수한다.\n-... 기반으로 50로 평가","degree_required":"degree_required는 [영상촬영기사]\n-촬영 장비를 준비한다.\n-촬영 계획을 수립한다.\n-조명과 구도를 설정한다.\n-촬영을 진행한다.\n-음성을 녹음한다.\n-장면을 연출한다.\n-안전 수칙을 준수한다.\n-... 기반으로 college로 평가","license_required":"license_required는 [영상촬영기사]\n-촬영 장비를 준비한다.\n-촬영 계획을 수립한다.\n-조명과 구도를 설정한다.\n-촬영을 진행한다.\n-음성을 녹음한다.\n-장면을 연출한다.\n-안전 수칙을 준수한다.\n-... 기반으로 preferred로 평가"}'
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