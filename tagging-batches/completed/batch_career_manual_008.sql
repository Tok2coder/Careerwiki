-- Batch tagging SQL generated at 2026-01-06T06:11:45.680Z
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
  '1765283279872989',
  '간판제작원',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 50, 50,
  50, 50, 30, 60, 60, 75,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 간판제작원은 간판을 디자인하고 제작하는 업무를 수행합니다.\n\n고객의 요구사항을 파악합니다.\n\n간판 디자인을 기획합니다.\n\n재료를 선정하고 가공합니다.\n\n간판을 조립하고 설치합니다.... 기반으로 50로 평가","growth":"growth는 간판제작원은 간판을 디자인하고 제작하는 업무를 수행합니다.\n\n고객의 요구사항을 파악합니다.\n\n간판 디자인을 기획합니다.\n\n재료를 선정하고 가공합니다.\n\n간판을 조립하고 설치합니다.... 기반으로 65로 평가","stability":"stability는 간판제작원은 간판을 디자인하고 제작하는 업무를 수행합니다.\n\n고객의 요구사항을 파악합니다.\n\n간판 디자인을 기획합니다.\n\n재료를 선정하고 가공합니다.\n\n간판을 조립하고 설치합니다.... 기반으로 50로 평가","income":"income는 간판제작원은 간판을 디자인하고 제작하는 업무를 수행합니다.\n\n고객의 요구사항을 파악합니다.\n\n간판 디자인을 기획합니다.\n\n재료를 선정하고 가공합니다.\n\n간판을 조립하고 설치합니다.... 기반으로 50로 평가","teamwork":"teamwork는 간판제작원은 간판을 디자인하고 제작하는 업무를 수행합니다.\n\n고객의 요구사항을 파악합니다.\n\n간판 디자인을 기획합니다.\n\n재료를 선정하고 가공합니다.\n\n간판을 조립하고 설치합니다.... 기반으로 50로 평가","solo_deep":"solo_deep는 간판제작원은 간판을 디자인하고 제작하는 업무를 수행합니다.\n\n고객의 요구사항을 파악합니다.\n\n간판 디자인을 기획합니다.\n\n재료를 선정하고 가공합니다.\n\n간판을 조립하고 설치합니다.... 기반으로 50로 평가","analytical":"analytical는 간판제작원은 간판을 디자인하고 제작하는 업무를 수행합니다.\n\n고객의 요구사항을 파악합니다.\n\n간판 디자인을 기획합니다.\n\n재료를 선정하고 가공합니다.\n\n간판을 조립하고 설치합니다.... 기반으로 30로 평가","creative":"creative는 간판제작원은 간판을 디자인하고 제작하는 업무를 수행합니다.\n\n고객의 요구사항을 파악합니다.\n\n간판 디자인을 기획합니다.\n\n재료를 선정하고 가공합니다.\n\n간판을 조립하고 설치합니다.... 기반으로 60로 평가","execution":"execution는 간판제작원은 간판을 디자인하고 제작하는 업무를 수행합니다.\n\n고객의 요구사항을 파악합니다.\n\n간판 디자인을 기획합니다.\n\n재료를 선정하고 가공합니다.\n\n간판을 조립하고 설치합니다.... 기반으로 60로 평가","people_facing":"people_facing는 간판제작원은 간판을 디자인하고 제작하는 업무를 수행합니다.\n\n고객의 요구사항을 파악합니다.\n\n간판 디자인을 기획합니다.\n\n재료를 선정하고 가공합니다.\n\n간판을 조립하고 설치합니다.... 기반으로 75로 평가","degree_required":"degree_required는 간판제작원은 간판을 디자인하고 제작하는 업무를 수행합니다.\n\n고객의 요구사항을 파악합니다.\n\n간판 디자인을 기획합니다.\n\n재료를 선정하고 가공합니다.\n\n간판을 조립하고 설치합니다.... 기반으로 none로 평가","license_required":"license_required는 간판제작원은 간판을 디자인하고 제작하는 업무를 수행합니다.\n\n고객의 요구사항을 파악합니다.\n\n간판 디자인을 기획합니다.\n\n재료를 선정하고 가공합니다.\n\n간판을 조립하고 설치합니다.... 기반으로 none로 평가"}'
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
  '1765283288362360',
  '광고디자이너',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 50, 40,
  70, 30, 40, 70, 40, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 광고디자이너는 광고물을 디자인하는 업무를 수행합니다.\n\n광고 콘셉트를 기획합니다.\n\n시각적 요소를 디자인합니다.\n\n그래픽 프로그램을 활용합니다.\n\n클라이언트와 협의합니다.\n\n최종 ... 기반으로 50로 평가","growth":"growth는 광고디자이너는 광고물을 디자인하는 업무를 수행합니다.\n\n광고 콘셉트를 기획합니다.\n\n시각적 요소를 디자인합니다.\n\n그래픽 프로그램을 활용합니다.\n\n클라이언트와 협의합니다.\n\n최종 ... 기반으로 65로 평가","stability":"stability는 광고디자이너는 광고물을 디자인하는 업무를 수행합니다.\n\n광고 콘셉트를 기획합니다.\n\n시각적 요소를 디자인합니다.\n\n그래픽 프로그램을 활용합니다.\n\n클라이언트와 협의합니다.\n\n최종 ... 기반으로 50로 평가","income":"income는 광고디자이너는 광고물을 디자인하는 업무를 수행합니다.\n\n광고 콘셉트를 기획합니다.\n\n시각적 요소를 디자인합니다.\n\n그래픽 프로그램을 활용합니다.\n\n클라이언트와 협의합니다.\n\n최종 ... 기반으로 40로 평가","teamwork":"teamwork는 광고디자이너는 광고물을 디자인하는 업무를 수행합니다.\n\n광고 콘셉트를 기획합니다.\n\n시각적 요소를 디자인합니다.\n\n그래픽 프로그램을 활용합니다.\n\n클라이언트와 협의합니다.\n\n최종 ... 기반으로 70로 평가","solo_deep":"solo_deep는 광고디자이너는 광고물을 디자인하는 업무를 수행합니다.\n\n광고 콘셉트를 기획합니다.\n\n시각적 요소를 디자인합니다.\n\n그래픽 프로그램을 활용합니다.\n\n클라이언트와 협의합니다.\n\n최종 ... 기반으로 30로 평가","analytical":"analytical는 광고디자이너는 광고물을 디자인하는 업무를 수행합니다.\n\n광고 콘셉트를 기획합니다.\n\n시각적 요소를 디자인합니다.\n\n그래픽 프로그램을 활용합니다.\n\n클라이언트와 협의합니다.\n\n최종 ... 기반으로 40로 평가","creative":"creative는 광고디자이너는 광고물을 디자인하는 업무를 수행합니다.\n\n광고 콘셉트를 기획합니다.\n\n시각적 요소를 디자인합니다.\n\n그래픽 프로그램을 활용합니다.\n\n클라이언트와 협의합니다.\n\n최종 ... 기반으로 70로 평가","execution":"execution는 광고디자이너는 광고물을 디자인하는 업무를 수행합니다.\n\n광고 콘셉트를 기획합니다.\n\n시각적 요소를 디자인합니다.\n\n그래픽 프로그램을 활용합니다.\n\n클라이언트와 협의합니다.\n\n최종 ... 기반으로 40로 평가","people_facing":"people_facing는 광고디자이너는 광고물을 디자인하는 업무를 수행합니다.\n\n광고 콘셉트를 기획합니다.\n\n시각적 요소를 디자인합니다.\n\n그래픽 프로그램을 활용합니다.\n\n클라이언트와 협의합니다.\n\n최종 ... 기반으로 50로 평가","degree_required":"degree_required는 광고디자이너는 광고물을 디자인하는 업무를 수행합니다.\n\n광고 콘셉트를 기획합니다.\n\n시각적 요소를 디자인합니다.\n\n그래픽 프로그램을 활용합니다.\n\n클라이언트와 협의합니다.\n\n최종 ... 기반으로 none로 평가","license_required":"license_required는 광고디자이너는 광고물을 디자인하는 업무를 수행합니다.\n\n광고 콘셉트를 기획합니다.\n\n시각적 요소를 디자인합니다.\n\n그래픽 프로그램을 활용합니다.\n\n클라이언트와 협의합니다.\n\n최종 ... 기반으로 none로 평가"}'
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
  '1765283303892190',
  '메이크업아티스트',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  50, 50, 60, 30, 60, 75,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 메이크업아티스트는 화장을 하는 업무를 수행합니다.\n\n고객의 피부 상태를 분석합니다.\n\n화장품을 선택합니다.\n\n화장을 진행합니다.\n\n고객의 만족도를 확인합니다.\n\n화장 도구를 관리합... 기반으로 50로 평가","growth":"growth는 메이크업아티스트는 화장을 하는 업무를 수행합니다.\n\n고객의 피부 상태를 분석합니다.\n\n화장품을 선택합니다.\n\n화장을 진행합니다.\n\n고객의 만족도를 확인합니다.\n\n화장 도구를 관리합... 기반으로 50로 평가","stability":"stability는 메이크업아티스트는 화장을 하는 업무를 수행합니다.\n\n고객의 피부 상태를 분석합니다.\n\n화장품을 선택합니다.\n\n화장을 진행합니다.\n\n고객의 만족도를 확인합니다.\n\n화장 도구를 관리합... 기반으로 50로 평가","income":"income는 메이크업아티스트는 화장을 하는 업무를 수행합니다.\n\n고객의 피부 상태를 분석합니다.\n\n화장품을 선택합니다.\n\n화장을 진행합니다.\n\n고객의 만족도를 확인합니다.\n\n화장 도구를 관리합... 기반으로 50로 평가","teamwork":"teamwork는 메이크업아티스트는 화장을 하는 업무를 수행합니다.\n\n고객의 피부 상태를 분석합니다.\n\n화장품을 선택합니다.\n\n화장을 진행합니다.\n\n고객의 만족도를 확인합니다.\n\n화장 도구를 관리합... 기반으로 50로 평가","solo_deep":"solo_deep는 메이크업아티스트는 화장을 하는 업무를 수행합니다.\n\n고객의 피부 상태를 분석합니다.\n\n화장품을 선택합니다.\n\n화장을 진행합니다.\n\n고객의 만족도를 확인합니다.\n\n화장 도구를 관리합... 기반으로 50로 평가","analytical":"analytical는 메이크업아티스트는 화장을 하는 업무를 수행합니다.\n\n고객의 피부 상태를 분석합니다.\n\n화장품을 선택합니다.\n\n화장을 진행합니다.\n\n고객의 만족도를 확인합니다.\n\n화장 도구를 관리합... 기반으로 60로 평가","creative":"creative는 메이크업아티스트는 화장을 하는 업무를 수행합니다.\n\n고객의 피부 상태를 분석합니다.\n\n화장품을 선택합니다.\n\n화장을 진행합니다.\n\n고객의 만족도를 확인합니다.\n\n화장 도구를 관리합... 기반으로 30로 평가","execution":"execution는 메이크업아티스트는 화장을 하는 업무를 수행합니다.\n\n고객의 피부 상태를 분석합니다.\n\n화장품을 선택합니다.\n\n화장을 진행합니다.\n\n고객의 만족도를 확인합니다.\n\n화장 도구를 관리합... 기반으로 60로 평가","people_facing":"people_facing는 메이크업아티스트는 화장을 하는 업무를 수행합니다.\n\n고객의 피부 상태를 분석합니다.\n\n화장품을 선택합니다.\n\n화장을 진행합니다.\n\n고객의 만족도를 확인합니다.\n\n화장 도구를 관리합... 기반으로 75로 평가","degree_required":"degree_required는 메이크업아티스트는 화장을 하는 업무를 수행합니다.\n\n고객의 피부 상태를 분석합니다.\n\n화장품을 선택합니다.\n\n화장을 진행합니다.\n\n고객의 만족도를 확인합니다.\n\n화장 도구를 관리합... 기반으로 none로 평가","license_required":"license_required는 메이크업아티스트는 화장을 하는 업무를 수행합니다.\n\n고객의 피부 상태를 분석합니다.\n\n화장품을 선택합니다.\n\n화장을 진행합니다.\n\n고객의 만족도를 확인합니다.\n\n화장 도구를 관리합... 기반으로 none로 평가"}'
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
  '1765283344624181',
  '연주가',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 40,
  50, 50, 50, 50, 50, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 연주가는 악기를 연주하는 업무를 수행합니다.\n\n악보를 익힙니다.\n\n연습을 합니다.\n\n공연을 준비합니다.\n\n무대에서 연주합니다.\n\n청중과 소통합니다.... 기반으로 50로 평가","growth":"growth는 연주가는 악기를 연주하는 업무를 수행합니다.\n\n악보를 익힙니다.\n\n연습을 합니다.\n\n공연을 준비합니다.\n\n무대에서 연주합니다.\n\n청중과 소통합니다.... 기반으로 50로 평가","stability":"stability는 연주가는 악기를 연주하는 업무를 수행합니다.\n\n악보를 익힙니다.\n\n연습을 합니다.\n\n공연을 준비합니다.\n\n무대에서 연주합니다.\n\n청중과 소통합니다.... 기반으로 50로 평가","income":"income는 연주가는 악기를 연주하는 업무를 수행합니다.\n\n악보를 익힙니다.\n\n연습을 합니다.\n\n공연을 준비합니다.\n\n무대에서 연주합니다.\n\n청중과 소통합니다.... 기반으로 40로 평가","teamwork":"teamwork는 연주가는 악기를 연주하는 업무를 수행합니다.\n\n악보를 익힙니다.\n\n연습을 합니다.\n\n공연을 준비합니다.\n\n무대에서 연주합니다.\n\n청중과 소통합니다.... 기반으로 50로 평가","solo_deep":"solo_deep는 연주가는 악기를 연주하는 업무를 수행합니다.\n\n악보를 익힙니다.\n\n연습을 합니다.\n\n공연을 준비합니다.\n\n무대에서 연주합니다.\n\n청중과 소통합니다.... 기반으로 50로 평가","analytical":"analytical는 연주가는 악기를 연주하는 업무를 수행합니다.\n\n악보를 익힙니다.\n\n연습을 합니다.\n\n공연을 준비합니다.\n\n무대에서 연주합니다.\n\n청중과 소통합니다.... 기반으로 50로 평가","creative":"creative는 연주가는 악기를 연주하는 업무를 수행합니다.\n\n악보를 익힙니다.\n\n연습을 합니다.\n\n공연을 준비합니다.\n\n무대에서 연주합니다.\n\n청중과 소통합니다.... 기반으로 50로 평가","execution":"execution는 연주가는 악기를 연주하는 업무를 수행합니다.\n\n악보를 익힙니다.\n\n연습을 합니다.\n\n공연을 준비합니다.\n\n무대에서 연주합니다.\n\n청중과 소통합니다.... 기반으로 50로 평가","people_facing":"people_facing는 연주가는 악기를 연주하는 업무를 수행합니다.\n\n악보를 익힙니다.\n\n연습을 합니다.\n\n공연을 준비합니다.\n\n무대에서 연주합니다.\n\n청중과 소통합니다.... 기반으로 50로 평가","degree_required":"degree_required는 연주가는 악기를 연주하는 업무를 수행합니다.\n\n악보를 익힙니다.\n\n연습을 합니다.\n\n공연을 준비합니다.\n\n무대에서 연주합니다.\n\n청중과 소통합니다.... 기반으로 none로 평가","license_required":"license_required는 연주가는 악기를 연주하는 업무를 수행합니다.\n\n악보를 익힙니다.\n\n연습을 합니다.\n\n공연을 준비합니다.\n\n무대에서 연주합니다.\n\n청중과 소통합니다.... 기반으로 none로 평가"}'
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
  '176528334096238',
  '반려동물미용사',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  50, 50, 40, 40, 70, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 반려동물미용사는 반려동물의 미용을 담당하는 업무를 수행합니다.\n\n반려동물의 건강 상태를 확인합니다.\n\n털을 손질합니다.\n\n목욕을 시킵니다.\n\n爪을 다듬습니다.\n\n미용 도구를 관리합... 기반으로 50로 평가","growth":"growth는 반려동물미용사는 반려동물의 미용을 담당하는 업무를 수행합니다.\n\n반려동물의 건강 상태를 확인합니다.\n\n털을 손질합니다.\n\n목욕을 시킵니다.\n\n爪을 다듬습니다.\n\n미용 도구를 관리합... 기반으로 50로 평가","stability":"stability는 반려동물미용사는 반려동물의 미용을 담당하는 업무를 수행합니다.\n\n반려동물의 건강 상태를 확인합니다.\n\n털을 손질합니다.\n\n목욕을 시킵니다.\n\n爪을 다듬습니다.\n\n미용 도구를 관리합... 기반으로 50로 평가","income":"income는 반려동물미용사는 반려동물의 미용을 담당하는 업무를 수행합니다.\n\n반려동물의 건강 상태를 확인합니다.\n\n털을 손질합니다.\n\n목욕을 시킵니다.\n\n爪을 다듬습니다.\n\n미용 도구를 관리합... 기반으로 50로 평가","teamwork":"teamwork는 반려동물미용사는 반려동물의 미용을 담당하는 업무를 수행합니다.\n\n반려동물의 건강 상태를 확인합니다.\n\n털을 손질합니다.\n\n목욕을 시킵니다.\n\n爪을 다듬습니다.\n\n미용 도구를 관리합... 기반으로 50로 평가","solo_deep":"solo_deep는 반려동물미용사는 반려동물의 미용을 담당하는 업무를 수행합니다.\n\n반려동물의 건강 상태를 확인합니다.\n\n털을 손질합니다.\n\n목욕을 시킵니다.\n\n爪을 다듬습니다.\n\n미용 도구를 관리합... 기반으로 50로 평가","analytical":"analytical는 반려동물미용사는 반려동물의 미용을 담당하는 업무를 수행합니다.\n\n반려동물의 건강 상태를 확인합니다.\n\n털을 손질합니다.\n\n목욕을 시킵니다.\n\n爪을 다듬습니다.\n\n미용 도구를 관리합... 기반으로 40로 평가","creative":"creative는 반려동물미용사는 반려동물의 미용을 담당하는 업무를 수행합니다.\n\n반려동물의 건강 상태를 확인합니다.\n\n털을 손질합니다.\n\n목욕을 시킵니다.\n\n爪을 다듬습니다.\n\n미용 도구를 관리합... 기반으로 40로 평가","execution":"execution는 반려동물미용사는 반려동물의 미용을 담당하는 업무를 수행합니다.\n\n반려동물의 건강 상태를 확인합니다.\n\n털을 손질합니다.\n\n목욕을 시킵니다.\n\n爪을 다듬습니다.\n\n미용 도구를 관리합... 기반으로 70로 평가","people_facing":"people_facing는 반려동물미용사는 반려동물의 미용을 담당하는 업무를 수행합니다.\n\n반려동물의 건강 상태를 확인합니다.\n\n털을 손질합니다.\n\n목욕을 시킵니다.\n\n爪을 다듬습니다.\n\n미용 도구를 관리합... 기반으로 50로 평가","degree_required":"degree_required는 반려동물미용사는 반려동물의 미용을 담당하는 업무를 수행합니다.\n\n반려동물의 건강 상태를 확인합니다.\n\n털을 손질합니다.\n\n목욕을 시킵니다.\n\n爪을 다듬습니다.\n\n미용 도구를 관리합... 기반으로 none로 평가","license_required":"license_required는 반려동물미용사는 반려동물의 미용을 담당하는 업무를 수행합니다.\n\n반려동물의 건강 상태를 확인합니다.\n\n털을 손질합니다.\n\n목욕을 시킵니다.\n\n爪을 다듬습니다.\n\n미용 도구를 관리합... 기반으로 none로 평가"}'
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
  '17652833553168',
  '이미지컨설턴트',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  30, 70, 70, 40, 40, 75,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 이미지컨설턴트는 개인의 이미지를 컨설팅하는 업무를 수행합니다.\n\n고객의 현재 이미지를 분석합니다.\n\n개선 방향을 제시합니다.\n\n의상과 스타일을 추천합니다.\n\n메이크업과 헤어스타일을... 기반으로 50로 평가","growth":"growth는 이미지컨설턴트는 개인의 이미지를 컨설팅하는 업무를 수행합니다.\n\n고객의 현재 이미지를 분석합니다.\n\n개선 방향을 제시합니다.\n\n의상과 스타일을 추천합니다.\n\n메이크업과 헤어스타일을... 기반으로 50로 평가","stability":"stability는 이미지컨설턴트는 개인의 이미지를 컨설팅하는 업무를 수행합니다.\n\n고객의 현재 이미지를 분석합니다.\n\n개선 방향을 제시합니다.\n\n의상과 스타일을 추천합니다.\n\n메이크업과 헤어스타일을... 기반으로 50로 평가","income":"income는 이미지컨설턴트는 개인의 이미지를 컨설팅하는 업무를 수행합니다.\n\n고객의 현재 이미지를 분석합니다.\n\n개선 방향을 제시합니다.\n\n의상과 스타일을 추천합니다.\n\n메이크업과 헤어스타일을... 기반으로 50로 평가","teamwork":"teamwork는 이미지컨설턴트는 개인의 이미지를 컨설팅하는 업무를 수행합니다.\n\n고객의 현재 이미지를 분석합니다.\n\n개선 방향을 제시합니다.\n\n의상과 스타일을 추천합니다.\n\n메이크업과 헤어스타일을... 기반으로 30로 평가","solo_deep":"solo_deep는 이미지컨설턴트는 개인의 이미지를 컨설팅하는 업무를 수행합니다.\n\n고객의 현재 이미지를 분석합니다.\n\n개선 방향을 제시합니다.\n\n의상과 스타일을 추천합니다.\n\n메이크업과 헤어스타일을... 기반으로 70로 평가","analytical":"analytical는 이미지컨설턴트는 개인의 이미지를 컨설팅하는 업무를 수행합니다.\n\n고객의 현재 이미지를 분석합니다.\n\n개선 방향을 제시합니다.\n\n의상과 스타일을 추천합니다.\n\n메이크업과 헤어스타일을... 기반으로 70로 평가","creative":"creative는 이미지컨설턴트는 개인의 이미지를 컨설팅하는 업무를 수행합니다.\n\n고객의 현재 이미지를 분석합니다.\n\n개선 방향을 제시합니다.\n\n의상과 스타일을 추천합니다.\n\n메이크업과 헤어스타일을... 기반으로 40로 평가","execution":"execution는 이미지컨설턴트는 개인의 이미지를 컨설팅하는 업무를 수행합니다.\n\n고객의 현재 이미지를 분석합니다.\n\n개선 방향을 제시합니다.\n\n의상과 스타일을 추천합니다.\n\n메이크업과 헤어스타일을... 기반으로 40로 평가","people_facing":"people_facing는 이미지컨설턴트는 개인의 이미지를 컨설팅하는 업무를 수행합니다.\n\n고객의 현재 이미지를 분석합니다.\n\n개선 방향을 제시합니다.\n\n의상과 스타일을 추천합니다.\n\n메이크업과 헤어스타일을... 기반으로 75로 평가","degree_required":"degree_required는 이미지컨설턴트는 개인의 이미지를 컨설팅하는 업무를 수행합니다.\n\n고객의 현재 이미지를 분석합니다.\n\n개선 방향을 제시합니다.\n\n의상과 스타일을 추천합니다.\n\n메이크업과 헤어스타일을... 기반으로 none로 평가","license_required":"license_required는 이미지컨설턴트는 개인의 이미지를 컨설팅하는 업무를 수행합니다.\n\n고객의 현재 이미지를 분석합니다.\n\n개선 방향을 제시합니다.\n\n의상과 스타일을 추천합니다.\n\n메이크업과 헤어스타일을... 기반으로 none로 평가"}'
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
  '1765283357251884',
  '인테리어디자이너',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 50, 40,
  50, 50, 40, 70, 40, 75,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 인테리어디자이너는 실내 공간을 디자인하는 업무를 수행합니다.\n\n고객의 요구사항을 파악합니다.\n\n공간 설계를 기획합니다.\n\n재료와 가구를 선택합니다.\n\n디자인을 시각화합니다.\n\n시공... 기반으로 50로 평가","growth":"growth는 인테리어디자이너는 실내 공간을 디자인하는 업무를 수행합니다.\n\n고객의 요구사항을 파악합니다.\n\n공간 설계를 기획합니다.\n\n재료와 가구를 선택합니다.\n\n디자인을 시각화합니다.\n\n시공... 기반으로 65로 평가","stability":"stability는 인테리어디자이너는 실내 공간을 디자인하는 업무를 수행합니다.\n\n고객의 요구사항을 파악합니다.\n\n공간 설계를 기획합니다.\n\n재료와 가구를 선택합니다.\n\n디자인을 시각화합니다.\n\n시공... 기반으로 50로 평가","income":"income는 인테리어디자이너는 실내 공간을 디자인하는 업무를 수행합니다.\n\n고객의 요구사항을 파악합니다.\n\n공간 설계를 기획합니다.\n\n재료와 가구를 선택합니다.\n\n디자인을 시각화합니다.\n\n시공... 기반으로 40로 평가","teamwork":"teamwork는 인테리어디자이너는 실내 공간을 디자인하는 업무를 수행합니다.\n\n고객의 요구사항을 파악합니다.\n\n공간 설계를 기획합니다.\n\n재료와 가구를 선택합니다.\n\n디자인을 시각화합니다.\n\n시공... 기반으로 50로 평가","solo_deep":"solo_deep는 인테리어디자이너는 실내 공간을 디자인하는 업무를 수행합니다.\n\n고객의 요구사항을 파악합니다.\n\n공간 설계를 기획합니다.\n\n재료와 가구를 선택합니다.\n\n디자인을 시각화합니다.\n\n시공... 기반으로 50로 평가","analytical":"analytical는 인테리어디자이너는 실내 공간을 디자인하는 업무를 수행합니다.\n\n고객의 요구사항을 파악합니다.\n\n공간 설계를 기획합니다.\n\n재료와 가구를 선택합니다.\n\n디자인을 시각화합니다.\n\n시공... 기반으로 40로 평가","creative":"creative는 인테리어디자이너는 실내 공간을 디자인하는 업무를 수행합니다.\n\n고객의 요구사항을 파악합니다.\n\n공간 설계를 기획합니다.\n\n재료와 가구를 선택합니다.\n\n디자인을 시각화합니다.\n\n시공... 기반으로 70로 평가","execution":"execution는 인테리어디자이너는 실내 공간을 디자인하는 업무를 수행합니다.\n\n고객의 요구사항을 파악합니다.\n\n공간 설계를 기획합니다.\n\n재료와 가구를 선택합니다.\n\n디자인을 시각화합니다.\n\n시공... 기반으로 40로 평가","people_facing":"people_facing는 인테리어디자이너는 실내 공간을 디자인하는 업무를 수행합니다.\n\n고객의 요구사항을 파악합니다.\n\n공간 설계를 기획합니다.\n\n재료와 가구를 선택합니다.\n\n디자인을 시각화합니다.\n\n시공... 기반으로 75로 평가","degree_required":"degree_required는 인테리어디자이너는 실내 공간을 디자인하는 업무를 수행합니다.\n\n고객의 요구사항을 파악합니다.\n\n공간 설계를 기획합니다.\n\n재료와 가구를 선택합니다.\n\n디자인을 시각화합니다.\n\n시공... 기반으로 none로 평가","license_required":"license_required는 인테리어디자이너는 실내 공간을 디자인하는 업무를 수행합니다.\n\n고객의 요구사항을 파악합니다.\n\n공간 설계를 기획합니다.\n\n재료와 가구를 선택합니다.\n\n디자인을 시각화합니다.\n\n시공... 기반으로 none로 평가"}'
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
  '1765283357861281',
  '일러스트레이터',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 50, 40,
  70, 30, 40, 70, 40, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 일러스트레이터는 삽화를 그리는 업무를 수행합니다.\n\n의뢰 내용을 파악합니다.\n\n콘셉트를 기획합니다.\n\n스케치를 합니다.\n\n최종 작품을 완성합니다.\n\n클라이언트와 협의합니다.... 기반으로 50로 평가","growth":"growth는 일러스트레이터는 삽화를 그리는 업무를 수행합니다.\n\n의뢰 내용을 파악합니다.\n\n콘셉트를 기획합니다.\n\n스케치를 합니다.\n\n최종 작품을 완성합니다.\n\n클라이언트와 협의합니다.... 기반으로 65로 평가","stability":"stability는 일러스트레이터는 삽화를 그리는 업무를 수행합니다.\n\n의뢰 내용을 파악합니다.\n\n콘셉트를 기획합니다.\n\n스케치를 합니다.\n\n최종 작품을 완성합니다.\n\n클라이언트와 협의합니다.... 기반으로 50로 평가","income":"income는 일러스트레이터는 삽화를 그리는 업무를 수행합니다.\n\n의뢰 내용을 파악합니다.\n\n콘셉트를 기획합니다.\n\n스케치를 합니다.\n\n최종 작품을 완성합니다.\n\n클라이언트와 협의합니다.... 기반으로 40로 평가","teamwork":"teamwork는 일러스트레이터는 삽화를 그리는 업무를 수행합니다.\n\n의뢰 내용을 파악합니다.\n\n콘셉트를 기획합니다.\n\n스케치를 합니다.\n\n최종 작품을 완성합니다.\n\n클라이언트와 협의합니다.... 기반으로 70로 평가","solo_deep":"solo_deep는 일러스트레이터는 삽화를 그리는 업무를 수행합니다.\n\n의뢰 내용을 파악합니다.\n\n콘셉트를 기획합니다.\n\n스케치를 합니다.\n\n최종 작품을 완성합니다.\n\n클라이언트와 협의합니다.... 기반으로 30로 평가","analytical":"analytical는 일러스트레이터는 삽화를 그리는 업무를 수행합니다.\n\n의뢰 내용을 파악합니다.\n\n콘셉트를 기획합니다.\n\n스케치를 합니다.\n\n최종 작품을 완성합니다.\n\n클라이언트와 협의합니다.... 기반으로 40로 평가","creative":"creative는 일러스트레이터는 삽화를 그리는 업무를 수행합니다.\n\n의뢰 내용을 파악합니다.\n\n콘셉트를 기획합니다.\n\n스케치를 합니다.\n\n최종 작품을 완성합니다.\n\n클라이언트와 협의합니다.... 기반으로 70로 평가","execution":"execution는 일러스트레이터는 삽화를 그리는 업무를 수행합니다.\n\n의뢰 내용을 파악합니다.\n\n콘셉트를 기획합니다.\n\n스케치를 합니다.\n\n최종 작품을 완성합니다.\n\n클라이언트와 협의합니다.... 기반으로 40로 평가","people_facing":"people_facing는 일러스트레이터는 삽화를 그리는 업무를 수행합니다.\n\n의뢰 내용을 파악합니다.\n\n콘셉트를 기획합니다.\n\n스케치를 합니다.\n\n최종 작품을 완성합니다.\n\n클라이언트와 협의합니다.... 기반으로 50로 평가","degree_required":"degree_required는 일러스트레이터는 삽화를 그리는 업무를 수행합니다.\n\n의뢰 내용을 파악합니다.\n\n콘셉트를 기획합니다.\n\n스케치를 합니다.\n\n최종 작품을 완성합니다.\n\n클라이언트와 협의합니다.... 기반으로 none로 평가","license_required":"license_required는 일러스트레이터는 삽화를 그리는 업무를 수행합니다.\n\n의뢰 내용을 파악합니다.\n\n콘셉트를 기획합니다.\n\n스케치를 합니다.\n\n최종 작품을 완성합니다.\n\n클라이언트와 협의합니다.... 기반으로 none로 평가"}'
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
  '1765283362064117',
  '자연과학연구원',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 50, 70,
  50, 50, 70, 40, 40, 35,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 자연과학연구원은 자연 현상에 대한 연구를 수행하는 업무를 수행합니다.\n\n연구 주제를 설정하고 계획합니다.\n\n실험을 설계하고 실행합니다.\n\n데이터를 수집하고 분석합니다.\n\n연구 결과... 기반으로 50로 평가","growth":"growth는 자연과학연구원은 자연 현상에 대한 연구를 수행하는 업무를 수행합니다.\n\n연구 주제를 설정하고 계획합니다.\n\n실험을 설계하고 실행합니다.\n\n데이터를 수집하고 분석합니다.\n\n연구 결과... 기반으로 65로 평가","stability":"stability는 자연과학연구원은 자연 현상에 대한 연구를 수행하는 업무를 수행합니다.\n\n연구 주제를 설정하고 계획합니다.\n\n실험을 설계하고 실행합니다.\n\n데이터를 수집하고 분석합니다.\n\n연구 결과... 기반으로 50로 평가","income":"income는 자연과학연구원은 자연 현상에 대한 연구를 수행하는 업무를 수행합니다.\n\n연구 주제를 설정하고 계획합니다.\n\n실험을 설계하고 실행합니다.\n\n데이터를 수집하고 분석합니다.\n\n연구 결과... 기반으로 70로 평가","teamwork":"teamwork는 자연과학연구원은 자연 현상에 대한 연구를 수행하는 업무를 수행합니다.\n\n연구 주제를 설정하고 계획합니다.\n\n실험을 설계하고 실행합니다.\n\n데이터를 수집하고 분석합니다.\n\n연구 결과... 기반으로 50로 평가","solo_deep":"solo_deep는 자연과학연구원은 자연 현상에 대한 연구를 수행하는 업무를 수행합니다.\n\n연구 주제를 설정하고 계획합니다.\n\n실험을 설계하고 실행합니다.\n\n데이터를 수집하고 분석합니다.\n\n연구 결과... 기반으로 50로 평가","analytical":"analytical는 자연과학연구원은 자연 현상에 대한 연구를 수행하는 업무를 수행합니다.\n\n연구 주제를 설정하고 계획합니다.\n\n실험을 설계하고 실행합니다.\n\n데이터를 수집하고 분석합니다.\n\n연구 결과... 기반으로 70로 평가","creative":"creative는 자연과학연구원은 자연 현상에 대한 연구를 수행하는 업무를 수행합니다.\n\n연구 주제를 설정하고 계획합니다.\n\n실험을 설계하고 실행합니다.\n\n데이터를 수집하고 분석합니다.\n\n연구 결과... 기반으로 40로 평가","execution":"execution는 자연과학연구원은 자연 현상에 대한 연구를 수행하는 업무를 수행합니다.\n\n연구 주제를 설정하고 계획합니다.\n\n실험을 설계하고 실행합니다.\n\n데이터를 수집하고 분석합니다.\n\n연구 결과... 기반으로 40로 평가","people_facing":"people_facing는 자연과학연구원은 자연 현상에 대한 연구를 수행하는 업무를 수행합니다.\n\n연구 주제를 설정하고 계획합니다.\n\n실험을 설계하고 실행합니다.\n\n데이터를 수집하고 분석합니다.\n\n연구 결과... 기반으로 35로 평가","degree_required":"degree_required는 자연과학연구원은 자연 현상에 대한 연구를 수행하는 업무를 수행합니다.\n\n연구 주제를 설정하고 계획합니다.\n\n실험을 설계하고 실행합니다.\n\n데이터를 수집하고 분석합니다.\n\n연구 결과... 기반으로 none로 평가","license_required":"license_required는 자연과학연구원은 자연 현상에 대한 연구를 수행하는 업무를 수행합니다.\n\n연구 주제를 설정하고 계획합니다.\n\n실험을 설계하고 실행합니다.\n\n데이터를 수집하고 분석합니다.\n\n연구 결과... 기반으로 none로 평가"}'
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

COMMIT;