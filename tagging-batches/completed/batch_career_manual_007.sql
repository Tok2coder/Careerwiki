-- Batch tagging SQL generated at 2026-01-06T06:10:36.337Z
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
  '1765283360512443',
  '자동차영업원',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 30, 50,
  50, 50, 40, 40, 70, 75,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 자동차영업원은 자동차를 판매하고 고객을 관리하는 업무를 수행합니다.\n\n고객의 요구사항을 파악합니다.\n\n적합한 자동차 모델을 추천합니다.\n\n가격과 조건을 협상합니다.\n\n계약서를 작성... 기반으로 50로 평가","growth":"growth는 자동차영업원은 자동차를 판매하고 고객을 관리하는 업무를 수행합니다.\n\n고객의 요구사항을 파악합니다.\n\n적합한 자동차 모델을 추천합니다.\n\n가격과 조건을 협상합니다.\n\n계약서를 작성... 기반으로 50로 평가","stability":"stability는 자동차영업원은 자동차를 판매하고 고객을 관리하는 업무를 수행합니다.\n\n고객의 요구사항을 파악합니다.\n\n적합한 자동차 모델을 추천합니다.\n\n가격과 조건을 협상합니다.\n\n계약서를 작성... 기반으로 30로 평가","income":"income는 자동차영업원은 자동차를 판매하고 고객을 관리하는 업무를 수행합니다.\n\n고객의 요구사항을 파악합니다.\n\n적합한 자동차 모델을 추천합니다.\n\n가격과 조건을 협상합니다.\n\n계약서를 작성... 기반으로 50로 평가","teamwork":"teamwork는 자동차영업원은 자동차를 판매하고 고객을 관리하는 업무를 수행합니다.\n\n고객의 요구사항을 파악합니다.\n\n적합한 자동차 모델을 추천합니다.\n\n가격과 조건을 협상합니다.\n\n계약서를 작성... 기반으로 50로 평가","solo_deep":"solo_deep는 자동차영업원은 자동차를 판매하고 고객을 관리하는 업무를 수행합니다.\n\n고객의 요구사항을 파악합니다.\n\n적합한 자동차 모델을 추천합니다.\n\n가격과 조건을 협상합니다.\n\n계약서를 작성... 기반으로 50로 평가","analytical":"analytical는 자동차영업원은 자동차를 판매하고 고객을 관리하는 업무를 수행합니다.\n\n고객의 요구사항을 파악합니다.\n\n적합한 자동차 모델을 추천합니다.\n\n가격과 조건을 협상합니다.\n\n계약서를 작성... 기반으로 40로 평가","creative":"creative는 자동차영업원은 자동차를 판매하고 고객을 관리하는 업무를 수행합니다.\n\n고객의 요구사항을 파악합니다.\n\n적합한 자동차 모델을 추천합니다.\n\n가격과 조건을 협상합니다.\n\n계약서를 작성... 기반으로 40로 평가","execution":"execution는 자동차영업원은 자동차를 판매하고 고객을 관리하는 업무를 수행합니다.\n\n고객의 요구사항을 파악합니다.\n\n적합한 자동차 모델을 추천합니다.\n\n가격과 조건을 협상합니다.\n\n계약서를 작성... 기반으로 70로 평가","people_facing":"people_facing는 자동차영업원은 자동차를 판매하고 고객을 관리하는 업무를 수행합니다.\n\n고객의 요구사항을 파악합니다.\n\n적합한 자동차 모델을 추천합니다.\n\n가격과 조건을 협상합니다.\n\n계약서를 작성... 기반으로 75로 평가","degree_required":"degree_required는 자동차영업원은 자동차를 판매하고 고객을 관리하는 업무를 수행합니다.\n\n고객의 요구사항을 파악합니다.\n\n적합한 자동차 모델을 추천합니다.\n\n가격과 조건을 협상합니다.\n\n계약서를 작성... 기반으로 none로 평가","license_required":"license_required는 자동차영업원은 자동차를 판매하고 고객을 관리하는 업무를 수행합니다.\n\n고객의 요구사항을 파악합니다.\n\n적합한 자동차 모델을 추천합니다.\n\n가격과 조건을 협상합니다.\n\n계약서를 작성... 기반으로 none로 평가"}'
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
  '1765283351534799',
  '유전공학연구원',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 50, 70,
  50, 50, 60, 60, 30, 35,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 유전공학연구원은 유전자를 조작하고 연구하는 업무를 수행합니다.\n\n유전자 구조를 분석합니다.\n\n유전자 조작 기술을 개발합니다.\n\n유전자 치료법을 연구합니다.\n\n생명공학 제품을 개발합... 기반으로 50로 평가","growth":"growth는 유전공학연구원은 유전자를 조작하고 연구하는 업무를 수행합니다.\n\n유전자 구조를 분석합니다.\n\n유전자 조작 기술을 개발합니다.\n\n유전자 치료법을 연구합니다.\n\n생명공학 제품을 개발합... 기반으로 65로 평가","stability":"stability는 유전공학연구원은 유전자를 조작하고 연구하는 업무를 수행합니다.\n\n유전자 구조를 분석합니다.\n\n유전자 조작 기술을 개발합니다.\n\n유전자 치료법을 연구합니다.\n\n생명공학 제품을 개발합... 기반으로 50로 평가","income":"income는 유전공학연구원은 유전자를 조작하고 연구하는 업무를 수행합니다.\n\n유전자 구조를 분석합니다.\n\n유전자 조작 기술을 개발합니다.\n\n유전자 치료법을 연구합니다.\n\n생명공학 제품을 개발합... 기반으로 70로 평가","teamwork":"teamwork는 유전공학연구원은 유전자를 조작하고 연구하는 업무를 수행합니다.\n\n유전자 구조를 분석합니다.\n\n유전자 조작 기술을 개발합니다.\n\n유전자 치료법을 연구합니다.\n\n생명공학 제품을 개발합... 기반으로 50로 평가","solo_deep":"solo_deep는 유전공학연구원은 유전자를 조작하고 연구하는 업무를 수행합니다.\n\n유전자 구조를 분석합니다.\n\n유전자 조작 기술을 개발합니다.\n\n유전자 치료법을 연구합니다.\n\n생명공학 제품을 개발합... 기반으로 50로 평가","analytical":"analytical는 유전공학연구원은 유전자를 조작하고 연구하는 업무를 수행합니다.\n\n유전자 구조를 분석합니다.\n\n유전자 조작 기술을 개발합니다.\n\n유전자 치료법을 연구합니다.\n\n생명공학 제품을 개발합... 기반으로 60로 평가","creative":"creative는 유전공학연구원은 유전자를 조작하고 연구하는 업무를 수행합니다.\n\n유전자 구조를 분석합니다.\n\n유전자 조작 기술을 개발합니다.\n\n유전자 치료법을 연구합니다.\n\n생명공학 제품을 개발합... 기반으로 60로 평가","execution":"execution는 유전공학연구원은 유전자를 조작하고 연구하는 업무를 수행합니다.\n\n유전자 구조를 분석합니다.\n\n유전자 조작 기술을 개발합니다.\n\n유전자 치료법을 연구합니다.\n\n생명공학 제품을 개발합... 기반으로 30로 평가","people_facing":"people_facing는 유전공학연구원은 유전자를 조작하고 연구하는 업무를 수행합니다.\n\n유전자 구조를 분석합니다.\n\n유전자 조작 기술을 개발합니다.\n\n유전자 치료법을 연구합니다.\n\n생명공학 제품을 개발합... 기반으로 35로 평가","degree_required":"degree_required는 유전공학연구원은 유전자를 조작하고 연구하는 업무를 수행합니다.\n\n유전자 구조를 분석합니다.\n\n유전자 조작 기술을 개발합니다.\n\n유전자 치료법을 연구합니다.\n\n생명공학 제품을 개발합... 기반으로 none로 평가","license_required":"license_required는 유전공학연구원은 유전자를 조작하고 연구하는 업무를 수행합니다.\n\n유전자 구조를 분석합니다.\n\n유전자 조작 기술을 개발합니다.\n\n유전자 치료법을 연구합니다.\n\n생명공학 제품을 개발합... 기반으로 none로 평가"}'
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
  '1765283352401621',
  '은행출납사무원',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 70, 50,
  50, 50, 40, 40, 70, 75,
  'regular', 'none', 'none', 'partial',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 은행출납사무원은 은행의 현금 출납과 관련 업무를 수행합니다.\n\n고객의 입출금 업무를 처리합니다.\n\n현금과 수표를 관리합니다.\n\n거래 기록을 정확히 입력합니다.\n\n보안 절차를 준수합... 기반으로 50로 평가","growth":"growth는 은행출납사무원은 은행의 현금 출납과 관련 업무를 수행합니다.\n\n고객의 입출금 업무를 처리합니다.\n\n현금과 수표를 관리합니다.\n\n거래 기록을 정확히 입력합니다.\n\n보안 절차를 준수합... 기반으로 50로 평가","stability":"stability는 은행출납사무원은 은행의 현금 출납과 관련 업무를 수행합니다.\n\n고객의 입출금 업무를 처리합니다.\n\n현금과 수표를 관리합니다.\n\n거래 기록을 정확히 입력합니다.\n\n보안 절차를 준수합... 기반으로 70로 평가","income":"income는 은행출납사무원은 은행의 현금 출납과 관련 업무를 수행합니다.\n\n고객의 입출금 업무를 처리합니다.\n\n현금과 수표를 관리합니다.\n\n거래 기록을 정확히 입력합니다.\n\n보안 절차를 준수합... 기반으로 50로 평가","teamwork":"teamwork는 은행출납사무원은 은행의 현금 출납과 관련 업무를 수행합니다.\n\n고객의 입출금 업무를 처리합니다.\n\n현금과 수표를 관리합니다.\n\n거래 기록을 정확히 입력합니다.\n\n보안 절차를 준수합... 기반으로 50로 평가","solo_deep":"solo_deep는 은행출납사무원은 은행의 현금 출납과 관련 업무를 수행합니다.\n\n고객의 입출금 업무를 처리합니다.\n\n현금과 수표를 관리합니다.\n\n거래 기록을 정확히 입력합니다.\n\n보안 절차를 준수합... 기반으로 50로 평가","analytical":"analytical는 은행출납사무원은 은행의 현금 출납과 관련 업무를 수행합니다.\n\n고객의 입출금 업무를 처리합니다.\n\n현금과 수표를 관리합니다.\n\n거래 기록을 정확히 입력합니다.\n\n보안 절차를 준수합... 기반으로 40로 평가","creative":"creative는 은행출납사무원은 은행의 현금 출납과 관련 업무를 수행합니다.\n\n고객의 입출금 업무를 처리합니다.\n\n현금과 수표를 관리합니다.\n\n거래 기록을 정확히 입력합니다.\n\n보안 절차를 준수합... 기반으로 40로 평가","execution":"execution는 은행출납사무원은 은행의 현금 출납과 관련 업무를 수행합니다.\n\n고객의 입출금 업무를 처리합니다.\n\n현금과 수표를 관리합니다.\n\n거래 기록을 정확히 입력합니다.\n\n보안 절차를 준수합... 기반으로 70로 평가","people_facing":"people_facing는 은행출납사무원은 은행의 현금 출납과 관련 업무를 수행합니다.\n\n고객의 입출금 업무를 처리합니다.\n\n현금과 수표를 관리합니다.\n\n거래 기록을 정확히 입력합니다.\n\n보안 절차를 준수합... 기반으로 75로 평가","degree_required":"degree_required는 은행출납사무원은 은행의 현금 출납과 관련 업무를 수행합니다.\n\n고객의 입출금 업무를 처리합니다.\n\n현금과 수표를 관리합니다.\n\n거래 기록을 정확히 입력합니다.\n\n보안 절차를 준수합... 기반으로 none로 평가","license_required":"license_required는 은행출납사무원은 은행의 현금 출납과 관련 업무를 수행합니다.\n\n고객의 입출금 업무를 처리합니다.\n\n현금과 수표를 관리합니다.\n\n거래 기록을 정확히 입력합니다.\n\n보안 절차를 준수합... 기반으로 none로 평가"}'
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
  '1765283405528943',
  '회계사무원',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 70, 50,
  50, 50, 40, 40, 70, 50,
  'regular', 'none', 'none', 'partial',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 회계사무원은 기업의 재무 기록을 관리하는 업무를 수행합니다.\n\n거래 내역을 기록합니다.\n\n장부를 작성합니다.\n\n세금 신고를 준비합니다.\n\n재무 보고서를 작성합니다.\n\n예산을 관리합... 기반으로 50로 평가","growth":"growth는 회계사무원은 기업의 재무 기록을 관리하는 업무를 수행합니다.\n\n거래 내역을 기록합니다.\n\n장부를 작성합니다.\n\n세금 신고를 준비합니다.\n\n재무 보고서를 작성합니다.\n\n예산을 관리합... 기반으로 50로 평가","stability":"stability는 회계사무원은 기업의 재무 기록을 관리하는 업무를 수행합니다.\n\n거래 내역을 기록합니다.\n\n장부를 작성합니다.\n\n세금 신고를 준비합니다.\n\n재무 보고서를 작성합니다.\n\n예산을 관리합... 기반으로 70로 평가","income":"income는 회계사무원은 기업의 재무 기록을 관리하는 업무를 수행합니다.\n\n거래 내역을 기록합니다.\n\n장부를 작성합니다.\n\n세금 신고를 준비합니다.\n\n재무 보고서를 작성합니다.\n\n예산을 관리합... 기반으로 50로 평가","teamwork":"teamwork는 회계사무원은 기업의 재무 기록을 관리하는 업무를 수행합니다.\n\n거래 내역을 기록합니다.\n\n장부를 작성합니다.\n\n세금 신고를 준비합니다.\n\n재무 보고서를 작성합니다.\n\n예산을 관리합... 기반으로 50로 평가","solo_deep":"solo_deep는 회계사무원은 기업의 재무 기록을 관리하는 업무를 수행합니다.\n\n거래 내역을 기록합니다.\n\n장부를 작성합니다.\n\n세금 신고를 준비합니다.\n\n재무 보고서를 작성합니다.\n\n예산을 관리합... 기반으로 50로 평가","analytical":"analytical는 회계사무원은 기업의 재무 기록을 관리하는 업무를 수행합니다.\n\n거래 내역을 기록합니다.\n\n장부를 작성합니다.\n\n세금 신고를 준비합니다.\n\n재무 보고서를 작성합니다.\n\n예산을 관리합... 기반으로 40로 평가","creative":"creative는 회계사무원은 기업의 재무 기록을 관리하는 업무를 수행합니다.\n\n거래 내역을 기록합니다.\n\n장부를 작성합니다.\n\n세금 신고를 준비합니다.\n\n재무 보고서를 작성합니다.\n\n예산을 관리합... 기반으로 40로 평가","execution":"execution는 회계사무원은 기업의 재무 기록을 관리하는 업무를 수행합니다.\n\n거래 내역을 기록합니다.\n\n장부를 작성합니다.\n\n세금 신고를 준비합니다.\n\n재무 보고서를 작성합니다.\n\n예산을 관리합... 기반으로 70로 평가","people_facing":"people_facing는 회계사무원은 기업의 재무 기록을 관리하는 업무를 수행합니다.\n\n거래 내역을 기록합니다.\n\n장부를 작성합니다.\n\n세금 신고를 준비합니다.\n\n재무 보고서를 작성합니다.\n\n예산을 관리합... 기반으로 50로 평가","degree_required":"degree_required는 회계사무원은 기업의 재무 기록을 관리하는 업무를 수행합니다.\n\n거래 내역을 기록합니다.\n\n장부를 작성합니다.\n\n세금 신고를 준비합니다.\n\n재무 보고서를 작성합니다.\n\n예산을 관리합... 기반으로 none로 평가","license_required":"license_required는 회계사무원은 기업의 재무 기록을 관리하는 업무를 수행합니다.\n\n거래 내역을 기록합니다.\n\n장부를 작성합니다.\n\n세금 신고를 준비합니다.\n\n재무 보고서를 작성합니다.\n\n예산을 관리합... 기반으로 none로 평가"}'
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
  '1765283319463731',
  '사서',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 70, 50,
  50, 50, 30, 60, 60, 75,
  'regular', 'none', 'none', 'partial',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 사서는 도서관 자료를 관리하고 이용자를 지원하는 업무를 수행합니다.\n\n도서를 분류하고 정리합니다.\n\n자료를 검색하고 대출합니다.\n\n독서 프로그램을 기획합니다.\n\n이용자를 안내합니다... 기반으로 50로 평가","growth":"growth는 사서는 도서관 자료를 관리하고 이용자를 지원하는 업무를 수행합니다.\n\n도서를 분류하고 정리합니다.\n\n자료를 검색하고 대출합니다.\n\n독서 프로그램을 기획합니다.\n\n이용자를 안내합니다... 기반으로 65로 평가","stability":"stability는 사서는 도서관 자료를 관리하고 이용자를 지원하는 업무를 수행합니다.\n\n도서를 분류하고 정리합니다.\n\n자료를 검색하고 대출합니다.\n\n독서 프로그램을 기획합니다.\n\n이용자를 안내합니다... 기반으로 70로 평가","income":"income는 사서는 도서관 자료를 관리하고 이용자를 지원하는 업무를 수행합니다.\n\n도서를 분류하고 정리합니다.\n\n자료를 검색하고 대출합니다.\n\n독서 프로그램을 기획합니다.\n\n이용자를 안내합니다... 기반으로 50로 평가","teamwork":"teamwork는 사서는 도서관 자료를 관리하고 이용자를 지원하는 업무를 수행합니다.\n\n도서를 분류하고 정리합니다.\n\n자료를 검색하고 대출합니다.\n\n독서 프로그램을 기획합니다.\n\n이용자를 안내합니다... 기반으로 50로 평가","solo_deep":"solo_deep는 사서는 도서관 자료를 관리하고 이용자를 지원하는 업무를 수행합니다.\n\n도서를 분류하고 정리합니다.\n\n자료를 검색하고 대출합니다.\n\n독서 프로그램을 기획합니다.\n\n이용자를 안내합니다... 기반으로 50로 평가","analytical":"analytical는 사서는 도서관 자료를 관리하고 이용자를 지원하는 업무를 수행합니다.\n\n도서를 분류하고 정리합니다.\n\n자료를 검색하고 대출합니다.\n\n독서 프로그램을 기획합니다.\n\n이용자를 안내합니다... 기반으로 30로 평가","creative":"creative는 사서는 도서관 자료를 관리하고 이용자를 지원하는 업무를 수행합니다.\n\n도서를 분류하고 정리합니다.\n\n자료를 검색하고 대출합니다.\n\n독서 프로그램을 기획합니다.\n\n이용자를 안내합니다... 기반으로 60로 평가","execution":"execution는 사서는 도서관 자료를 관리하고 이용자를 지원하는 업무를 수행합니다.\n\n도서를 분류하고 정리합니다.\n\n자료를 검색하고 대출합니다.\n\n독서 프로그램을 기획합니다.\n\n이용자를 안내합니다... 기반으로 60로 평가","people_facing":"people_facing는 사서는 도서관 자료를 관리하고 이용자를 지원하는 업무를 수행합니다.\n\n도서를 분류하고 정리합니다.\n\n자료를 검색하고 대출합니다.\n\n독서 프로그램을 기획합니다.\n\n이용자를 안내합니다... 기반으로 75로 평가","degree_required":"degree_required는 사서는 도서관 자료를 관리하고 이용자를 지원하는 업무를 수행합니다.\n\n도서를 분류하고 정리합니다.\n\n자료를 검색하고 대출합니다.\n\n독서 프로그램을 기획합니다.\n\n이용자를 안내합니다... 기반으로 none로 평가","license_required":"license_required는 사서는 도서관 자료를 관리하고 이용자를 지원하는 업무를 수행합니다.\n\n도서를 분류하고 정리합니다.\n\n자료를 검색하고 대출합니다.\n\n독서 프로그램을 기획합니다.\n\n이용자를 안내합니다... 기반으로 none로 평가"}'
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
  '1765283328079234',
  '성우',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 40,
  50, 50, 70, 40, 40, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 성우는 목소리로 연기를 하는 업무를 수행합니다.\n\n대본을 분석합니다.\n\n목소리 연기를 준비합니다.\n\n녹음을 진행합니다.\n\n감정 표현을 삽입합니다.\n\n편집과 수정 작업을 합니다.... 기반으로 50로 평가","growth":"growth는 성우는 목소리로 연기를 하는 업무를 수행합니다.\n\n대본을 분석합니다.\n\n목소리 연기를 준비합니다.\n\n녹음을 진행합니다.\n\n감정 표현을 삽입합니다.\n\n편집과 수정 작업을 합니다.... 기반으로 50로 평가","stability":"stability는 성우는 목소리로 연기를 하는 업무를 수행합니다.\n\n대본을 분석합니다.\n\n목소리 연기를 준비합니다.\n\n녹음을 진행합니다.\n\n감정 표현을 삽입합니다.\n\n편집과 수정 작업을 합니다.... 기반으로 50로 평가","income":"income는 성우는 목소리로 연기를 하는 업무를 수행합니다.\n\n대본을 분석합니다.\n\n목소리 연기를 준비합니다.\n\n녹음을 진행합니다.\n\n감정 표현을 삽입합니다.\n\n편집과 수정 작업을 합니다.... 기반으로 40로 평가","teamwork":"teamwork는 성우는 목소리로 연기를 하는 업무를 수행합니다.\n\n대본을 분석합니다.\n\n목소리 연기를 준비합니다.\n\n녹음을 진행합니다.\n\n감정 표현을 삽입합니다.\n\n편집과 수정 작업을 합니다.... 기반으로 50로 평가","solo_deep":"solo_deep는 성우는 목소리로 연기를 하는 업무를 수행합니다.\n\n대본을 분석합니다.\n\n목소리 연기를 준비합니다.\n\n녹음을 진행합니다.\n\n감정 표현을 삽입합니다.\n\n편집과 수정 작업을 합니다.... 기반으로 50로 평가","analytical":"analytical는 성우는 목소리로 연기를 하는 업무를 수행합니다.\n\n대본을 분석합니다.\n\n목소리 연기를 준비합니다.\n\n녹음을 진행합니다.\n\n감정 표현을 삽입합니다.\n\n편집과 수정 작업을 합니다.... 기반으로 70로 평가","creative":"creative는 성우는 목소리로 연기를 하는 업무를 수행합니다.\n\n대본을 분석합니다.\n\n목소리 연기를 준비합니다.\n\n녹음을 진행합니다.\n\n감정 표현을 삽입합니다.\n\n편집과 수정 작업을 합니다.... 기반으로 40로 평가","execution":"execution는 성우는 목소리로 연기를 하는 업무를 수행합니다.\n\n대본을 분석합니다.\n\n목소리 연기를 준비합니다.\n\n녹음을 진행합니다.\n\n감정 표현을 삽입합니다.\n\n편집과 수정 작업을 합니다.... 기반으로 40로 평가","people_facing":"people_facing는 성우는 목소리로 연기를 하는 업무를 수행합니다.\n\n대본을 분석합니다.\n\n목소리 연기를 준비합니다.\n\n녹음을 진행합니다.\n\n감정 표현을 삽입합니다.\n\n편집과 수정 작업을 합니다.... 기반으로 50로 평가","degree_required":"degree_required는 성우는 목소리로 연기를 하는 업무를 수행합니다.\n\n대본을 분석합니다.\n\n목소리 연기를 준비합니다.\n\n녹음을 진행합니다.\n\n감정 표현을 삽입합니다.\n\n편집과 수정 작업을 합니다.... 기반으로 none로 평가","license_required":"license_required는 성우는 목소리로 연기를 하는 업무를 수행합니다.\n\n대본을 분석합니다.\n\n목소리 연기를 준비합니다.\n\n녹음을 진행합니다.\n\n감정 표현을 삽입합니다.\n\n편집과 수정 작업을 합니다.... 기반으로 none로 평가"}'
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
  '1765283337718596',
  '아나운서',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 40,
  50, 50, 50, 50, 50, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 아나운서는 방송에서 뉴스와 프로그램을 진행하는 업무를 수행합니다.\n\n스크립트를 준비합니다.\n\n방송을 진행합니다.\n\n시청자와 소통합니다.\n\n발음을 정확히 합니다.\n\n긴급 상황에 대응... 기반으로 50로 평가","growth":"growth는 아나운서는 방송에서 뉴스와 프로그램을 진행하는 업무를 수행합니다.\n\n스크립트를 준비합니다.\n\n방송을 진행합니다.\n\n시청자와 소통합니다.\n\n발음을 정확히 합니다.\n\n긴급 상황에 대응... 기반으로 50로 평가","stability":"stability는 아나운서는 방송에서 뉴스와 프로그램을 진행하는 업무를 수행합니다.\n\n스크립트를 준비합니다.\n\n방송을 진행합니다.\n\n시청자와 소통합니다.\n\n발음을 정확히 합니다.\n\n긴급 상황에 대응... 기반으로 50로 평가","income":"income는 아나운서는 방송에서 뉴스와 프로그램을 진행하는 업무를 수행합니다.\n\n스크립트를 준비합니다.\n\n방송을 진행합니다.\n\n시청자와 소통합니다.\n\n발음을 정확히 합니다.\n\n긴급 상황에 대응... 기반으로 40로 평가","teamwork":"teamwork는 아나운서는 방송에서 뉴스와 프로그램을 진행하는 업무를 수행합니다.\n\n스크립트를 준비합니다.\n\n방송을 진행합니다.\n\n시청자와 소통합니다.\n\n발음을 정확히 합니다.\n\n긴급 상황에 대응... 기반으로 50로 평가","solo_deep":"solo_deep는 아나운서는 방송에서 뉴스와 프로그램을 진행하는 업무를 수행합니다.\n\n스크립트를 준비합니다.\n\n방송을 진행합니다.\n\n시청자와 소통합니다.\n\n발음을 정확히 합니다.\n\n긴급 상황에 대응... 기반으로 50로 평가","analytical":"analytical는 아나운서는 방송에서 뉴스와 프로그램을 진행하는 업무를 수행합니다.\n\n스크립트를 준비합니다.\n\n방송을 진행합니다.\n\n시청자와 소통합니다.\n\n발음을 정확히 합니다.\n\n긴급 상황에 대응... 기반으로 50로 평가","creative":"creative는 아나운서는 방송에서 뉴스와 프로그램을 진행하는 업무를 수행합니다.\n\n스크립트를 준비합니다.\n\n방송을 진행합니다.\n\n시청자와 소통합니다.\n\n발음을 정확히 합니다.\n\n긴급 상황에 대응... 기반으로 50로 평가","execution":"execution는 아나운서는 방송에서 뉴스와 프로그램을 진행하는 업무를 수행합니다.\n\n스크립트를 준비합니다.\n\n방송을 진행합니다.\n\n시청자와 소통합니다.\n\n발음을 정확히 합니다.\n\n긴급 상황에 대응... 기반으로 50로 평가","people_facing":"people_facing는 아나운서는 방송에서 뉴스와 프로그램을 진행하는 업무를 수행합니다.\n\n스크립트를 준비합니다.\n\n방송을 진행합니다.\n\n시청자와 소통합니다.\n\n발음을 정확히 합니다.\n\n긴급 상황에 대응... 기반으로 50로 평가","degree_required":"degree_required는 아나운서는 방송에서 뉴스와 프로그램을 진행하는 업무를 수행합니다.\n\n스크립트를 준비합니다.\n\n방송을 진행합니다.\n\n시청자와 소통합니다.\n\n발음을 정확히 합니다.\n\n긴급 상황에 대응... 기반으로 none로 평가","license_required":"license_required는 아나운서는 방송에서 뉴스와 프로그램을 진행하는 업무를 수행합니다.\n\n스크립트를 준비합니다.\n\n방송을 진행합니다.\n\n시청자와 소통합니다.\n\n발음을 정확히 합니다.\n\n긴급 상황에 대응... 기반으로 none로 평가"}'
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
  '17652833431652',
  '역사학연구원',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 95, 65, 60,
  50, 50, 70, 40, 40, 35,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 역사학연구원은 역사적 사실을 연구하고 해석하는 업무를 수행합니다.\n\n역사 자료를 수집합니다.\n\n역사적 사건을 분석합니다.\n\n연구 결과를 발표합니다.\n\n역사 교육을 담당합니다.\n\n문... 기반으로 50로 평가","growth":"growth는 역사학연구원은 역사적 사실을 연구하고 해석하는 업무를 수행합니다.\n\n역사 자료를 수집합니다.\n\n역사적 사건을 분석합니다.\n\n연구 결과를 발표합니다.\n\n역사 교육을 담당합니다.\n\n문... 기반으로 95로 평가","stability":"stability는 역사학연구원은 역사적 사실을 연구하고 해석하는 업무를 수행합니다.\n\n역사 자료를 수집합니다.\n\n역사적 사건을 분석합니다.\n\n연구 결과를 발표합니다.\n\n역사 교육을 담당합니다.\n\n문... 기반으로 65로 평가","income":"income는 역사학연구원은 역사적 사실을 연구하고 해석하는 업무를 수행합니다.\n\n역사 자료를 수집합니다.\n\n역사적 사건을 분석합니다.\n\n연구 결과를 발표합니다.\n\n역사 교육을 담당합니다.\n\n문... 기반으로 60로 평가","teamwork":"teamwork는 역사학연구원은 역사적 사실을 연구하고 해석하는 업무를 수행합니다.\n\n역사 자료를 수집합니다.\n\n역사적 사건을 분석합니다.\n\n연구 결과를 발표합니다.\n\n역사 교육을 담당합니다.\n\n문... 기반으로 50로 평가","solo_deep":"solo_deep는 역사학연구원은 역사적 사실을 연구하고 해석하는 업무를 수행합니다.\n\n역사 자료를 수집합니다.\n\n역사적 사건을 분석합니다.\n\n연구 결과를 발표합니다.\n\n역사 교육을 담당합니다.\n\n문... 기반으로 50로 평가","analytical":"analytical는 역사학연구원은 역사적 사실을 연구하고 해석하는 업무를 수행합니다.\n\n역사 자료를 수집합니다.\n\n역사적 사건을 분석합니다.\n\n연구 결과를 발표합니다.\n\n역사 교육을 담당합니다.\n\n문... 기반으로 70로 평가","creative":"creative는 역사학연구원은 역사적 사실을 연구하고 해석하는 업무를 수행합니다.\n\n역사 자료를 수집합니다.\n\n역사적 사건을 분석합니다.\n\n연구 결과를 발표합니다.\n\n역사 교육을 담당합니다.\n\n문... 기반으로 40로 평가","execution":"execution는 역사학연구원은 역사적 사실을 연구하고 해석하는 업무를 수행합니다.\n\n역사 자료를 수집합니다.\n\n역사적 사건을 분석합니다.\n\n연구 결과를 발표합니다.\n\n역사 교육을 담당합니다.\n\n문... 기반으로 40로 평가","people_facing":"people_facing는 역사학연구원은 역사적 사실을 연구하고 해석하는 업무를 수행합니다.\n\n역사 자료를 수집합니다.\n\n역사적 사건을 분석합니다.\n\n연구 결과를 발표합니다.\n\n역사 교육을 담당합니다.\n\n문... 기반으로 35로 평가","degree_required":"degree_required는 역사학연구원은 역사적 사실을 연구하고 해석하는 업무를 수행합니다.\n\n역사 자료를 수집합니다.\n\n역사적 사건을 분석합니다.\n\n연구 결과를 발표합니다.\n\n역사 교육을 담당합니다.\n\n문... 기반으로 none로 평가","license_required":"license_required는 역사학연구원은 역사적 사실을 연구하고 해석하는 업무를 수행합니다.\n\n역사 자료를 수집합니다.\n\n역사적 사건을 분석합니다.\n\n연구 결과를 발표합니다.\n\n역사 교육을 담당합니다.\n\n문... 기반으로 none로 평가"}'
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
  '1765283359699295',
  '자동조립라인 및 산업용로봇조작원',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  50, 50, 60, 30, 60, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 자동조립라인 및 산업용로봇조작원은 자동화된 조립 라인을 운영하는 업무를 수행합니다.\n\n자동 조립 라인의 설정과 조작을 담당합니다.\n\n산업용 로봇의 프로그래밍과 운영을 수행합니다.\n... 기반으로 50로 평가","growth":"growth는 자동조립라인 및 산업용로봇조작원은 자동화된 조립 라인을 운영하는 업무를 수행합니다.\n\n자동 조립 라인의 설정과 조작을 담당합니다.\n\n산업용 로봇의 프로그래밍과 운영을 수행합니다.\n... 기반으로 50로 평가","stability":"stability는 자동조립라인 및 산업용로봇조작원은 자동화된 조립 라인을 운영하는 업무를 수행합니다.\n\n자동 조립 라인의 설정과 조작을 담당합니다.\n\n산업용 로봇의 프로그래밍과 운영을 수행합니다.\n... 기반으로 50로 평가","income":"income는 자동조립라인 및 산업용로봇조작원은 자동화된 조립 라인을 운영하는 업무를 수행합니다.\n\n자동 조립 라인의 설정과 조작을 담당합니다.\n\n산업용 로봇의 프로그래밍과 운영을 수행합니다.\n... 기반으로 50로 평가","teamwork":"teamwork는 자동조립라인 및 산업용로봇조작원은 자동화된 조립 라인을 운영하는 업무를 수행합니다.\n\n자동 조립 라인의 설정과 조작을 담당합니다.\n\n산업용 로봇의 프로그래밍과 운영을 수행합니다.\n... 기반으로 50로 평가","solo_deep":"solo_deep는 자동조립라인 및 산업용로봇조작원은 자동화된 조립 라인을 운영하는 업무를 수행합니다.\n\n자동 조립 라인의 설정과 조작을 담당합니다.\n\n산업용 로봇의 프로그래밍과 운영을 수행합니다.\n... 기반으로 50로 평가","analytical":"analytical는 자동조립라인 및 산업용로봇조작원은 자동화된 조립 라인을 운영하는 업무를 수행합니다.\n\n자동 조립 라인의 설정과 조작을 담당합니다.\n\n산업용 로봇의 프로그래밍과 운영을 수행합니다.\n... 기반으로 60로 평가","creative":"creative는 자동조립라인 및 산업용로봇조작원은 자동화된 조립 라인을 운영하는 업무를 수행합니다.\n\n자동 조립 라인의 설정과 조작을 담당합니다.\n\n산업용 로봇의 프로그래밍과 운영을 수행합니다.\n... 기반으로 30로 평가","execution":"execution는 자동조립라인 및 산업용로봇조작원은 자동화된 조립 라인을 운영하는 업무를 수행합니다.\n\n자동 조립 라인의 설정과 조작을 담당합니다.\n\n산업용 로봇의 프로그래밍과 운영을 수행합니다.\n... 기반으로 60로 평가","people_facing":"people_facing는 자동조립라인 및 산업용로봇조작원은 자동화된 조립 라인을 운영하는 업무를 수행합니다.\n\n자동 조립 라인의 설정과 조작을 담당합니다.\n\n산업용 로봇의 프로그래밍과 운영을 수행합니다.\n... 기반으로 50로 평가","degree_required":"degree_required는 자동조립라인 및 산업용로봇조작원은 자동화된 조립 라인을 운영하는 업무를 수행합니다.\n\n자동 조립 라인의 설정과 조작을 담당합니다.\n\n산업용 로봇의 프로그래밍과 운영을 수행합니다.\n... 기반으로 none로 평가","license_required":"license_required는 자동조립라인 및 산업용로봇조작원은 자동화된 조립 라인을 운영하는 업무를 수행합니다.\n\n자동 조립 라인의 설정과 조작을 담당합니다.\n\n산업용 로봇의 프로그래밍과 운영을 수행합니다.\n... 기반으로 none로 평가"}'
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
  '1765283404339546',
  '환경영향평가원',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 85, 65, 80,
  70, 30, 60, 60, 30, 35,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 환경영향평가원은 개발 사업이 환경에 미치는 영향을 평가하는 업무를 수행합니다.\n\n개발 사업의 환경 영향을 조사합니다.\n\n환경 영향 평가서를 작성합니다.\n\n환경 보전 대책을 제안합니... 기반으로 50로 평가","growth":"growth는 환경영향평가원은 개발 사업이 환경에 미치는 영향을 평가하는 업무를 수행합니다.\n\n개발 사업의 환경 영향을 조사합니다.\n\n환경 영향 평가서를 작성합니다.\n\n환경 보전 대책을 제안합니... 기반으로 85로 평가","stability":"stability는 환경영향평가원은 개발 사업이 환경에 미치는 영향을 평가하는 업무를 수행합니다.\n\n개발 사업의 환경 영향을 조사합니다.\n\n환경 영향 평가서를 작성합니다.\n\n환경 보전 대책을 제안합니... 기반으로 65로 평가","income":"income는 환경영향평가원은 개발 사업이 환경에 미치는 영향을 평가하는 업무를 수행합니다.\n\n개발 사업의 환경 영향을 조사합니다.\n\n환경 영향 평가서를 작성합니다.\n\n환경 보전 대책을 제안합니... 기반으로 80로 평가","teamwork":"teamwork는 환경영향평가원은 개발 사업이 환경에 미치는 영향을 평가하는 업무를 수행합니다.\n\n개발 사업의 환경 영향을 조사합니다.\n\n환경 영향 평가서를 작성합니다.\n\n환경 보전 대책을 제안합니... 기반으로 70로 평가","solo_deep":"solo_deep는 환경영향평가원은 개발 사업이 환경에 미치는 영향을 평가하는 업무를 수행합니다.\n\n개발 사업의 환경 영향을 조사합니다.\n\n환경 영향 평가서를 작성합니다.\n\n환경 보전 대책을 제안합니... 기반으로 30로 평가","analytical":"analytical는 환경영향평가원은 개발 사업이 환경에 미치는 영향을 평가하는 업무를 수행합니다.\n\n개발 사업의 환경 영향을 조사합니다.\n\n환경 영향 평가서를 작성합니다.\n\n환경 보전 대책을 제안합니... 기반으로 60로 평가","creative":"creative는 환경영향평가원은 개발 사업이 환경에 미치는 영향을 평가하는 업무를 수행합니다.\n\n개발 사업의 환경 영향을 조사합니다.\n\n환경 영향 평가서를 작성합니다.\n\n환경 보전 대책을 제안합니... 기반으로 60로 평가","execution":"execution는 환경영향평가원은 개발 사업이 환경에 미치는 영향을 평가하는 업무를 수행합니다.\n\n개발 사업의 환경 영향을 조사합니다.\n\n환경 영향 평가서를 작성합니다.\n\n환경 보전 대책을 제안합니... 기반으로 30로 평가","people_facing":"people_facing는 환경영향평가원은 개발 사업이 환경에 미치는 영향을 평가하는 업무를 수행합니다.\n\n개발 사업의 환경 영향을 조사합니다.\n\n환경 영향 평가서를 작성합니다.\n\n환경 보전 대책을 제안합니... 기반으로 35로 평가","degree_required":"degree_required는 환경영향평가원은 개발 사업이 환경에 미치는 영향을 평가하는 업무를 수행합니다.\n\n개발 사업의 환경 영향을 조사합니다.\n\n환경 영향 평가서를 작성합니다.\n\n환경 보전 대책을 제안합니... 기반으로 none로 평가","license_required":"license_required는 환경영향평가원은 개발 사업이 환경에 미치는 영향을 평가하는 업무를 수행합니다.\n\n개발 사업의 환경 영향을 조사합니다.\n\n환경 영향 평가서를 작성합니다.\n\n환경 보전 대책을 제안합니... 기반으로 none로 평가"}'
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