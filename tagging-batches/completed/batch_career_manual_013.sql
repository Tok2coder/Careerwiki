-- Batch tagging SQL generated at 2026-01-06T06:43:10.176Z
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
  '1765283341791607',
  '양장사 및 양복사',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 50, 50,
  50, 50, 30, 60, 60, 75,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 양장사 및 양복사는 양복과 양장을 디자인하고 제작하는 업무를 수행합니다.\n\n고객의 체형과 취향을 파악합니다.\n\n패턴을 설계합니다.\n\n천을 재단합니다.\n\n봉제 작업을 합니다.\n\n완성... 기반으로 50로 평가","growth":"growth는 양장사 및 양복사는 양복과 양장을 디자인하고 제작하는 업무를 수행합니다.\n\n고객의 체형과 취향을 파악합니다.\n\n패턴을 설계합니다.\n\n천을 재단합니다.\n\n봉제 작업을 합니다.\n\n완성... 기반으로 65로 평가","stability":"stability는 양장사 및 양복사는 양복과 양장을 디자인하고 제작하는 업무를 수행합니다.\n\n고객의 체형과 취향을 파악합니다.\n\n패턴을 설계합니다.\n\n천을 재단합니다.\n\n봉제 작업을 합니다.\n\n완성... 기반으로 50로 평가","income":"income는 양장사 및 양복사는 양복과 양장을 디자인하고 제작하는 업무를 수행합니다.\n\n고객의 체형과 취향을 파악합니다.\n\n패턴을 설계합니다.\n\n천을 재단합니다.\n\n봉제 작업을 합니다.\n\n완성... 기반으로 50로 평가","teamwork":"teamwork는 양장사 및 양복사는 양복과 양장을 디자인하고 제작하는 업무를 수행합니다.\n\n고객의 체형과 취향을 파악합니다.\n\n패턴을 설계합니다.\n\n천을 재단합니다.\n\n봉제 작업을 합니다.\n\n완성... 기반으로 50로 평가","solo_deep":"solo_deep는 양장사 및 양복사는 양복과 양장을 디자인하고 제작하는 업무를 수행합니다.\n\n고객의 체형과 취향을 파악합니다.\n\n패턴을 설계합니다.\n\n천을 재단합니다.\n\n봉제 작업을 합니다.\n\n완성... 기반으로 50로 평가","analytical":"analytical는 양장사 및 양복사는 양복과 양장을 디자인하고 제작하는 업무를 수행합니다.\n\n고객의 체형과 취향을 파악합니다.\n\n패턴을 설계합니다.\n\n천을 재단합니다.\n\n봉제 작업을 합니다.\n\n완성... 기반으로 30로 평가","creative":"creative는 양장사 및 양복사는 양복과 양장을 디자인하고 제작하는 업무를 수행합니다.\n\n고객의 체형과 취향을 파악합니다.\n\n패턴을 설계합니다.\n\n천을 재단합니다.\n\n봉제 작업을 합니다.\n\n완성... 기반으로 60로 평가","execution":"execution는 양장사 및 양복사는 양복과 양장을 디자인하고 제작하는 업무를 수행합니다.\n\n고객의 체형과 취향을 파악합니다.\n\n패턴을 설계합니다.\n\n천을 재단합니다.\n\n봉제 작업을 합니다.\n\n완성... 기반으로 60로 평가","people_facing":"people_facing는 양장사 및 양복사는 양복과 양장을 디자인하고 제작하는 업무를 수행합니다.\n\n고객의 체형과 취향을 파악합니다.\n\n패턴을 설계합니다.\n\n천을 재단합니다.\n\n봉제 작업을 합니다.\n\n완성... 기반으로 75로 평가","degree_required":"degree_required는 양장사 및 양복사는 양복과 양장을 디자인하고 제작하는 업무를 수행합니다.\n\n고객의 체형과 취향을 파악합니다.\n\n패턴을 설계합니다.\n\n천을 재단합니다.\n\n봉제 작업을 합니다.\n\n완성... 기반으로 none로 평가","license_required":"license_required는 양장사 및 양복사는 양복과 양장을 디자인하고 제작하는 업무를 수행합니다.\n\n고객의 체형과 취향을 파악합니다.\n\n패턴을 설계합니다.\n\n천을 재단합니다.\n\n봉제 작업을 합니다.\n\n완성... 기반으로 none로 평가"}'
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
  '1765283343766144',
  '연근해 어부 및 해녀',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  50, 50, 40, 40, 70, 50,
  'regular', 'none', 'some', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 연근해 어부 및 해녀는 바다에서 물고기를 잡는 업무를 수행합니다.\n\n물고기의 이동 패턴을 관찰합니다.\n\n그물을 설치합니다.\n\n물고기를 포획합니다.\n\n수확물을 정리합니다.\n\n안전 수... 기반으로 50로 평가","growth":"growth는 연근해 어부 및 해녀는 바다에서 물고기를 잡는 업무를 수행합니다.\n\n물고기의 이동 패턴을 관찰합니다.\n\n그물을 설치합니다.\n\n물고기를 포획합니다.\n\n수확물을 정리합니다.\n\n안전 수... 기반으로 50로 평가","stability":"stability는 연근해 어부 및 해녀는 바다에서 물고기를 잡는 업무를 수행합니다.\n\n물고기의 이동 패턴을 관찰합니다.\n\n그물을 설치합니다.\n\n물고기를 포획합니다.\n\n수확물을 정리합니다.\n\n안전 수... 기반으로 50로 평가","income":"income는 연근해 어부 및 해녀는 바다에서 물고기를 잡는 업무를 수행합니다.\n\n물고기의 이동 패턴을 관찰합니다.\n\n그물을 설치합니다.\n\n물고기를 포획합니다.\n\n수확물을 정리합니다.\n\n안전 수... 기반으로 50로 평가","teamwork":"teamwork는 연근해 어부 및 해녀는 바다에서 물고기를 잡는 업무를 수행합니다.\n\n물고기의 이동 패턴을 관찰합니다.\n\n그물을 설치합니다.\n\n물고기를 포획합니다.\n\n수확물을 정리합니다.\n\n안전 수... 기반으로 50로 평가","solo_deep":"solo_deep는 연근해 어부 및 해녀는 바다에서 물고기를 잡는 업무를 수행합니다.\n\n물고기의 이동 패턴을 관찰합니다.\n\n그물을 설치합니다.\n\n물고기를 포획합니다.\n\n수확물을 정리합니다.\n\n안전 수... 기반으로 50로 평가","analytical":"analytical는 연근해 어부 및 해녀는 바다에서 물고기를 잡는 업무를 수행합니다.\n\n물고기의 이동 패턴을 관찰합니다.\n\n그물을 설치합니다.\n\n물고기를 포획합니다.\n\n수확물을 정리합니다.\n\n안전 수... 기반으로 40로 평가","creative":"creative는 연근해 어부 및 해녀는 바다에서 물고기를 잡는 업무를 수행합니다.\n\n물고기의 이동 패턴을 관찰합니다.\n\n그물을 설치합니다.\n\n물고기를 포획합니다.\n\n수확물을 정리합니다.\n\n안전 수... 기반으로 40로 평가","execution":"execution는 연근해 어부 및 해녀는 바다에서 물고기를 잡는 업무를 수행합니다.\n\n물고기의 이동 패턴을 관찰합니다.\n\n그물을 설치합니다.\n\n물고기를 포획합니다.\n\n수확물을 정리합니다.\n\n안전 수... 기반으로 70로 평가","people_facing":"people_facing는 연근해 어부 및 해녀는 바다에서 물고기를 잡는 업무를 수행합니다.\n\n물고기의 이동 패턴을 관찰합니다.\n\n그물을 설치합니다.\n\n물고기를 포획합니다.\n\n수확물을 정리합니다.\n\n안전 수... 기반으로 50로 평가","degree_required":"degree_required는 연근해 어부 및 해녀는 바다에서 물고기를 잡는 업무를 수행합니다.\n\n물고기의 이동 패턴을 관찰합니다.\n\n그물을 설치합니다.\n\n물고기를 포획합니다.\n\n수확물을 정리합니다.\n\n안전 수... 기반으로 none로 평가","license_required":"license_required는 연근해 어부 및 해녀는 바다에서 물고기를 잡는 업무를 수행합니다.\n\n물고기의 이동 패턴을 관찰합니다.\n\n그물을 설치합니다.\n\n물고기를 포획합니다.\n\n수확물을 정리합니다.\n\n안전 수... 기반으로 none로 평가"}'
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
  '1765283342342747',
  '언어학연구원',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 85, 65, 60,
  50, 50, 70, 40, 40, 35,
  'regular', 'none', 'none', 'none',
  'master', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 언어학연구원은 언어의 구조와 발전을 연구하는 업무를 수행합니다.\n\n언어 데이터를 수집합니다.\n\n언어 현상을 분석합니다.\n\n연구 결과를 정리합니다.\n\n논문을 작성합니다.\n\n학술 활동... 기반으로 50로 평가","growth":"growth는 언어학연구원은 언어의 구조와 발전을 연구하는 업무를 수행합니다.\n\n언어 데이터를 수집합니다.\n\n언어 현상을 분석합니다.\n\n연구 결과를 정리합니다.\n\n논문을 작성합니다.\n\n학술 활동... 기반으로 85로 평가","stability":"stability는 언어학연구원은 언어의 구조와 발전을 연구하는 업무를 수행합니다.\n\n언어 데이터를 수집합니다.\n\n언어 현상을 분석합니다.\n\n연구 결과를 정리합니다.\n\n논문을 작성합니다.\n\n학술 활동... 기반으로 65로 평가","income":"income는 언어학연구원은 언어의 구조와 발전을 연구하는 업무를 수행합니다.\n\n언어 데이터를 수집합니다.\n\n언어 현상을 분석합니다.\n\n연구 결과를 정리합니다.\n\n논문을 작성합니다.\n\n학술 활동... 기반으로 60로 평가","teamwork":"teamwork는 언어학연구원은 언어의 구조와 발전을 연구하는 업무를 수행합니다.\n\n언어 데이터를 수집합니다.\n\n언어 현상을 분석합니다.\n\n연구 결과를 정리합니다.\n\n논문을 작성합니다.\n\n학술 활동... 기반으로 50로 평가","solo_deep":"solo_deep는 언어학연구원은 언어의 구조와 발전을 연구하는 업무를 수행합니다.\n\n언어 데이터를 수집합니다.\n\n언어 현상을 분석합니다.\n\n연구 결과를 정리합니다.\n\n논문을 작성합니다.\n\n학술 활동... 기반으로 50로 평가","analytical":"analytical는 언어학연구원은 언어의 구조와 발전을 연구하는 업무를 수행합니다.\n\n언어 데이터를 수집합니다.\n\n언어 현상을 분석합니다.\n\n연구 결과를 정리합니다.\n\n논문을 작성합니다.\n\n학술 활동... 기반으로 70로 평가","creative":"creative는 언어학연구원은 언어의 구조와 발전을 연구하는 업무를 수행합니다.\n\n언어 데이터를 수집합니다.\n\n언어 현상을 분석합니다.\n\n연구 결과를 정리합니다.\n\n논문을 작성합니다.\n\n학술 활동... 기반으로 40로 평가","execution":"execution는 언어학연구원은 언어의 구조와 발전을 연구하는 업무를 수행합니다.\n\n언어 데이터를 수집합니다.\n\n언어 현상을 분석합니다.\n\n연구 결과를 정리합니다.\n\n논문을 작성합니다.\n\n학술 활동... 기반으로 40로 평가","people_facing":"people_facing는 언어학연구원은 언어의 구조와 발전을 연구하는 업무를 수행합니다.\n\n언어 데이터를 수집합니다.\n\n언어 현상을 분석합니다.\n\n연구 결과를 정리합니다.\n\n논문을 작성합니다.\n\n학술 활동... 기반으로 35로 평가","degree_required":"degree_required는 언어학연구원은 언어의 구조와 발전을 연구하는 업무를 수행합니다.\n\n언어 데이터를 수집합니다.\n\n언어 현상을 분석합니다.\n\n연구 결과를 정리합니다.\n\n논문을 작성합니다.\n\n학술 활동... 기반으로 master로 평가","license_required":"license_required는 언어학연구원은 언어의 구조와 발전을 연구하는 업무를 수행합니다.\n\n언어 데이터를 수집합니다.\n\n언어 현상을 분석합니다.\n\n연구 결과를 정리합니다.\n\n논문을 작성합니다.\n\n학술 활동... 기반으로 none로 평가"}'
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
  '1765283327753431',
  '성악가',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 60, 50, 40,
  50, 50, 40, 40, 70, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 성악가는 클래식 음악에서 노래를 부르는 업무를 수행합니다.\n\n음역과 테크닉을 훈련합니다.\n\n곡을 연습합니다.\n\n공연에서 노래합니다.\n\n목소리를 관리합니다.\n\n음악을 해석합니다.... 기반으로 50로 평가","growth":"growth는 성악가는 클래식 음악에서 노래를 부르는 업무를 수행합니다.\n\n음역과 테크닉을 훈련합니다.\n\n곡을 연습합니다.\n\n공연에서 노래합니다.\n\n목소리를 관리합니다.\n\n음악을 해석합니다.... 기반으로 60로 평가","stability":"stability는 성악가는 클래식 음악에서 노래를 부르는 업무를 수행합니다.\n\n음역과 테크닉을 훈련합니다.\n\n곡을 연습합니다.\n\n공연에서 노래합니다.\n\n목소리를 관리합니다.\n\n음악을 해석합니다.... 기반으로 50로 평가","income":"income는 성악가는 클래식 음악에서 노래를 부르는 업무를 수행합니다.\n\n음역과 테크닉을 훈련합니다.\n\n곡을 연습합니다.\n\n공연에서 노래합니다.\n\n목소리를 관리합니다.\n\n음악을 해석합니다.... 기반으로 40로 평가","teamwork":"teamwork는 성악가는 클래식 음악에서 노래를 부르는 업무를 수행합니다.\n\n음역과 테크닉을 훈련합니다.\n\n곡을 연습합니다.\n\n공연에서 노래합니다.\n\n목소리를 관리합니다.\n\n음악을 해석합니다.... 기반으로 50로 평가","solo_deep":"solo_deep는 성악가는 클래식 음악에서 노래를 부르는 업무를 수행합니다.\n\n음역과 테크닉을 훈련합니다.\n\n곡을 연습합니다.\n\n공연에서 노래합니다.\n\n목소리를 관리합니다.\n\n음악을 해석합니다.... 기반으로 50로 평가","analytical":"analytical는 성악가는 클래식 음악에서 노래를 부르는 업무를 수행합니다.\n\n음역과 테크닉을 훈련합니다.\n\n곡을 연습합니다.\n\n공연에서 노래합니다.\n\n목소리를 관리합니다.\n\n음악을 해석합니다.... 기반으로 40로 평가","creative":"creative는 성악가는 클래식 음악에서 노래를 부르는 업무를 수행합니다.\n\n음역과 테크닉을 훈련합니다.\n\n곡을 연습합니다.\n\n공연에서 노래합니다.\n\n목소리를 관리합니다.\n\n음악을 해석합니다.... 기반으로 40로 평가","execution":"execution는 성악가는 클래식 음악에서 노래를 부르는 업무를 수행합니다.\n\n음역과 테크닉을 훈련합니다.\n\n곡을 연습합니다.\n\n공연에서 노래합니다.\n\n목소리를 관리합니다.\n\n음악을 해석합니다.... 기반으로 70로 평가","people_facing":"people_facing는 성악가는 클래식 음악에서 노래를 부르는 업무를 수행합니다.\n\n음역과 테크닉을 훈련합니다.\n\n곡을 연습합니다.\n\n공연에서 노래합니다.\n\n목소리를 관리합니다.\n\n음악을 해석합니다.... 기반으로 50로 평가","degree_required":"degree_required는 성악가는 클래식 음악에서 노래를 부르는 업무를 수행합니다.\n\n음역과 테크닉을 훈련합니다.\n\n곡을 연습합니다.\n\n공연에서 노래합니다.\n\n목소리를 관리합니다.\n\n음악을 해석합니다.... 기반으로 none로 평가","license_required":"license_required는 성악가는 클래식 음악에서 노래를 부르는 업무를 수행합니다.\n\n음역과 테크닉을 훈련합니다.\n\n곡을 연습합니다.\n\n공연에서 노래합니다.\n\n목소리를 관리합니다.\n\n음악을 해석합니다.... 기반으로 none로 평가"}'
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
  '1765283362693974',
  '작곡가',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 40,
  50, 50, 40, 70, 40, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 작곡가는 음악 작품을 작곡하는 업무를 수행합니다.\n\n멜로디를 창작합니다.\n\n화성을 구성합니다.\n\n곡을 편곡합니다.\n\n녹음을 감독합니다.\n\n음악적 아이디어를 발전시킵니다.... 기반으로 50로 평가","growth":"growth는 작곡가는 음악 작품을 작곡하는 업무를 수행합니다.\n\n멜로디를 창작합니다.\n\n화성을 구성합니다.\n\n곡을 편곡합니다.\n\n녹음을 감독합니다.\n\n음악적 아이디어를 발전시킵니다.... 기반으로 50로 평가","stability":"stability는 작곡가는 음악 작품을 작곡하는 업무를 수행합니다.\n\n멜로디를 창작합니다.\n\n화성을 구성합니다.\n\n곡을 편곡합니다.\n\n녹음을 감독합니다.\n\n음악적 아이디어를 발전시킵니다.... 기반으로 50로 평가","income":"income는 작곡가는 음악 작품을 작곡하는 업무를 수행합니다.\n\n멜로디를 창작합니다.\n\n화성을 구성합니다.\n\n곡을 편곡합니다.\n\n녹음을 감독합니다.\n\n음악적 아이디어를 발전시킵니다.... 기반으로 40로 평가","teamwork":"teamwork는 작곡가는 음악 작품을 작곡하는 업무를 수행합니다.\n\n멜로디를 창작합니다.\n\n화성을 구성합니다.\n\n곡을 편곡합니다.\n\n녹음을 감독합니다.\n\n음악적 아이디어를 발전시킵니다.... 기반으로 50로 평가","solo_deep":"solo_deep는 작곡가는 음악 작품을 작곡하는 업무를 수행합니다.\n\n멜로디를 창작합니다.\n\n화성을 구성합니다.\n\n곡을 편곡합니다.\n\n녹음을 감독합니다.\n\n음악적 아이디어를 발전시킵니다.... 기반으로 50로 평가","analytical":"analytical는 작곡가는 음악 작품을 작곡하는 업무를 수행합니다.\n\n멜로디를 창작합니다.\n\n화성을 구성합니다.\n\n곡을 편곡합니다.\n\n녹음을 감독합니다.\n\n음악적 아이디어를 발전시킵니다.... 기반으로 40로 평가","creative":"creative는 작곡가는 음악 작품을 작곡하는 업무를 수행합니다.\n\n멜로디를 창작합니다.\n\n화성을 구성합니다.\n\n곡을 편곡합니다.\n\n녹음을 감독합니다.\n\n음악적 아이디어를 발전시킵니다.... 기반으로 70로 평가","execution":"execution는 작곡가는 음악 작품을 작곡하는 업무를 수행합니다.\n\n멜로디를 창작합니다.\n\n화성을 구성합니다.\n\n곡을 편곡합니다.\n\n녹음을 감독합니다.\n\n음악적 아이디어를 발전시킵니다.... 기반으로 40로 평가","people_facing":"people_facing는 작곡가는 음악 작품을 작곡하는 업무를 수행합니다.\n\n멜로디를 창작합니다.\n\n화성을 구성합니다.\n\n곡을 편곡합니다.\n\n녹음을 감독합니다.\n\n음악적 아이디어를 발전시킵니다.... 기반으로 50로 평가","degree_required":"degree_required는 작곡가는 음악 작품을 작곡하는 업무를 수행합니다.\n\n멜로디를 창작합니다.\n\n화성을 구성합니다.\n\n곡을 편곡합니다.\n\n녹음을 감독합니다.\n\n음악적 아이디어를 발전시킵니다.... 기반으로 none로 평가","license_required":"license_required는 작곡가는 음악 작품을 작곡하는 업무를 수행합니다.\n\n멜로디를 창작합니다.\n\n화성을 구성합니다.\n\n곡을 편곡합니다.\n\n녹음을 감독합니다.\n\n음악적 아이디어를 발전시킵니다.... 기반으로 none로 평가"}'
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
  '1765283357564908',
  '일기예보관',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 70,
  50, 50, 70, 40, 40, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 일기예보관은 날씨 정보를 수집하고 예보하는 업무를 수행합니다.\n\n기상 데이터를 수집합니다.\n\n날씨 패턴을 분석합니다.\n\n예보 모델을 실행합니다.\n\n예보를 발표합니다.\n\n재해 예보를... 기반으로 50로 평가","growth":"growth는 일기예보관은 날씨 정보를 수집하고 예보하는 업무를 수행합니다.\n\n기상 데이터를 수집합니다.\n\n날씨 패턴을 분석합니다.\n\n예보 모델을 실행합니다.\n\n예보를 발표합니다.\n\n재해 예보를... 기반으로 50로 평가","stability":"stability는 일기예보관은 날씨 정보를 수집하고 예보하는 업무를 수행합니다.\n\n기상 데이터를 수집합니다.\n\n날씨 패턴을 분석합니다.\n\n예보 모델을 실행합니다.\n\n예보를 발표합니다.\n\n재해 예보를... 기반으로 50로 평가","income":"income는 일기예보관은 날씨 정보를 수집하고 예보하는 업무를 수행합니다.\n\n기상 데이터를 수집합니다.\n\n날씨 패턴을 분석합니다.\n\n예보 모델을 실행합니다.\n\n예보를 발표합니다.\n\n재해 예보를... 기반으로 70로 평가","teamwork":"teamwork는 일기예보관은 날씨 정보를 수집하고 예보하는 업무를 수행합니다.\n\n기상 데이터를 수집합니다.\n\n날씨 패턴을 분석합니다.\n\n예보 모델을 실행합니다.\n\n예보를 발표합니다.\n\n재해 예보를... 기반으로 50로 평가","solo_deep":"solo_deep는 일기예보관은 날씨 정보를 수집하고 예보하는 업무를 수행합니다.\n\n기상 데이터를 수집합니다.\n\n날씨 패턴을 분석합니다.\n\n예보 모델을 실행합니다.\n\n예보를 발표합니다.\n\n재해 예보를... 기반으로 50로 평가","analytical":"analytical는 일기예보관은 날씨 정보를 수집하고 예보하는 업무를 수행합니다.\n\n기상 데이터를 수집합니다.\n\n날씨 패턴을 분석합니다.\n\n예보 모델을 실행합니다.\n\n예보를 발표합니다.\n\n재해 예보를... 기반으로 70로 평가","creative":"creative는 일기예보관은 날씨 정보를 수집하고 예보하는 업무를 수행합니다.\n\n기상 데이터를 수집합니다.\n\n날씨 패턴을 분석합니다.\n\n예보 모델을 실행합니다.\n\n예보를 발표합니다.\n\n재해 예보를... 기반으로 40로 평가","execution":"execution는 일기예보관은 날씨 정보를 수집하고 예보하는 업무를 수행합니다.\n\n기상 데이터를 수집합니다.\n\n날씨 패턴을 분석합니다.\n\n예보 모델을 실행합니다.\n\n예보를 발표합니다.\n\n재해 예보를... 기반으로 40로 평가","people_facing":"people_facing는 일기예보관은 날씨 정보를 수집하고 예보하는 업무를 수행합니다.\n\n기상 데이터를 수집합니다.\n\n날씨 패턴을 분석합니다.\n\n예보 모델을 실행합니다.\n\n예보를 발표합니다.\n\n재해 예보를... 기반으로 50로 평가","degree_required":"degree_required는 일기예보관은 날씨 정보를 수집하고 예보하는 업무를 수행합니다.\n\n기상 데이터를 수집합니다.\n\n날씨 패턴을 분석합니다.\n\n예보 모델을 실행합니다.\n\n예보를 발표합니다.\n\n재해 예보를... 기반으로 none로 평가","license_required":"license_required는 일기예보관은 날씨 정보를 수집하고 예보하는 업무를 수행합니다.\n\n기상 데이터를 수집합니다.\n\n날씨 패턴을 분석합니다.\n\n예보 모델을 실행합니다.\n\n예보를 발표합니다.\n\n재해 예보를... 기반으로 none로 평가"}'
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
  '1765283333868113',
  '시멘트제조원',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  50, 50, 40, 40, 70, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 시멘트제조원은 시멘트를 생산하는 업무를 수행합니다.\n\n원재료를 준비합니다.\n\n제조 공정을 운영합니다.\n\n품질을 검사합니다.\n\n안전 수칙을 준수합니다.\n\n생산량을 관리합니다.... 기반으로 50로 평가","growth":"growth는 시멘트제조원은 시멘트를 생산하는 업무를 수행합니다.\n\n원재료를 준비합니다.\n\n제조 공정을 운영합니다.\n\n품질을 검사합니다.\n\n안전 수칙을 준수합니다.\n\n생산량을 관리합니다.... 기반으로 50로 평가","stability":"stability는 시멘트제조원은 시멘트를 생산하는 업무를 수행합니다.\n\n원재료를 준비합니다.\n\n제조 공정을 운영합니다.\n\n품질을 검사합니다.\n\n안전 수칙을 준수합니다.\n\n생산량을 관리합니다.... 기반으로 50로 평가","income":"income는 시멘트제조원은 시멘트를 생산하는 업무를 수행합니다.\n\n원재료를 준비합니다.\n\n제조 공정을 운영합니다.\n\n품질을 검사합니다.\n\n안전 수칙을 준수합니다.\n\n생산량을 관리합니다.... 기반으로 50로 평가","teamwork":"teamwork는 시멘트제조원은 시멘트를 생산하는 업무를 수행합니다.\n\n원재료를 준비합니다.\n\n제조 공정을 운영합니다.\n\n품질을 검사합니다.\n\n안전 수칙을 준수합니다.\n\n생산량을 관리합니다.... 기반으로 50로 평가","solo_deep":"solo_deep는 시멘트제조원은 시멘트를 생산하는 업무를 수행합니다.\n\n원재료를 준비합니다.\n\n제조 공정을 운영합니다.\n\n품질을 검사합니다.\n\n안전 수칙을 준수합니다.\n\n생산량을 관리합니다.... 기반으로 50로 평가","analytical":"analytical는 시멘트제조원은 시멘트를 생산하는 업무를 수행합니다.\n\n원재료를 준비합니다.\n\n제조 공정을 운영합니다.\n\n품질을 검사합니다.\n\n안전 수칙을 준수합니다.\n\n생산량을 관리합니다.... 기반으로 40로 평가","creative":"creative는 시멘트제조원은 시멘트를 생산하는 업무를 수행합니다.\n\n원재료를 준비합니다.\n\n제조 공정을 운영합니다.\n\n품질을 검사합니다.\n\n안전 수칙을 준수합니다.\n\n생산량을 관리합니다.... 기반으로 40로 평가","execution":"execution는 시멘트제조원은 시멘트를 생산하는 업무를 수행합니다.\n\n원재료를 준비합니다.\n\n제조 공정을 운영합니다.\n\n품질을 검사합니다.\n\n안전 수칙을 준수합니다.\n\n생산량을 관리합니다.... 기반으로 70로 평가","people_facing":"people_facing는 시멘트제조원은 시멘트를 생산하는 업무를 수행합니다.\n\n원재료를 준비합니다.\n\n제조 공정을 운영합니다.\n\n품질을 검사합니다.\n\n안전 수칙을 준수합니다.\n\n생산량을 관리합니다.... 기반으로 50로 평가","degree_required":"degree_required는 시멘트제조원은 시멘트를 생산하는 업무를 수행합니다.\n\n원재료를 준비합니다.\n\n제조 공정을 운영합니다.\n\n품질을 검사합니다.\n\n안전 수칙을 준수합니다.\n\n생산량을 관리합니다.... 기반으로 none로 평가","license_required":"license_required는 시멘트제조원은 시멘트를 생산하는 업무를 수행합니다.\n\n원재료를 준비합니다.\n\n제조 공정을 운영합니다.\n\n품질을 검사합니다.\n\n안전 수칙을 준수합니다.\n\n생산량을 관리합니다.... 기반으로 none로 평가"}'
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
  '1765283356623903',
  '인문사회계열교수',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 50, 50,
  50, 50, 70, 40, 40, 35,
  'regular', 'none', 'none', 'none',
  'phd', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 인문사회계열교수는 인문사회 분야를 가르치는 업무를 수행합니다.\n\n강의를 준비합니다.\n\n학생들을 가르칩니다.\n\n연구를 수행합니다.\n\n논문을 작성합니다.\n\n학술 활동에 참여합니다.... 기반으로 50로 평가","growth":"growth는 인문사회계열교수는 인문사회 분야를 가르치는 업무를 수행합니다.\n\n강의를 준비합니다.\n\n학생들을 가르칩니다.\n\n연구를 수행합니다.\n\n논문을 작성합니다.\n\n학술 활동에 참여합니다.... 기반으로 65로 평가","stability":"stability는 인문사회계열교수는 인문사회 분야를 가르치는 업무를 수행합니다.\n\n강의를 준비합니다.\n\n학생들을 가르칩니다.\n\n연구를 수행합니다.\n\n논문을 작성합니다.\n\n학술 활동에 참여합니다.... 기반으로 50로 평가","income":"income는 인문사회계열교수는 인문사회 분야를 가르치는 업무를 수행합니다.\n\n강의를 준비합니다.\n\n학생들을 가르칩니다.\n\n연구를 수행합니다.\n\n논문을 작성합니다.\n\n학술 활동에 참여합니다.... 기반으로 50로 평가","teamwork":"teamwork는 인문사회계열교수는 인문사회 분야를 가르치는 업무를 수행합니다.\n\n강의를 준비합니다.\n\n학생들을 가르칩니다.\n\n연구를 수행합니다.\n\n논문을 작성합니다.\n\n학술 활동에 참여합니다.... 기반으로 50로 평가","solo_deep":"solo_deep는 인문사회계열교수는 인문사회 분야를 가르치는 업무를 수행합니다.\n\n강의를 준비합니다.\n\n학생들을 가르칩니다.\n\n연구를 수행합니다.\n\n논문을 작성합니다.\n\n학술 활동에 참여합니다.... 기반으로 50로 평가","analytical":"analytical는 인문사회계열교수는 인문사회 분야를 가르치는 업무를 수행합니다.\n\n강의를 준비합니다.\n\n학생들을 가르칩니다.\n\n연구를 수행합니다.\n\n논문을 작성합니다.\n\n학술 활동에 참여합니다.... 기반으로 70로 평가","creative":"creative는 인문사회계열교수는 인문사회 분야를 가르치는 업무를 수행합니다.\n\n강의를 준비합니다.\n\n학생들을 가르칩니다.\n\n연구를 수행합니다.\n\n논문을 작성합니다.\n\n학술 활동에 참여합니다.... 기반으로 40로 평가","execution":"execution는 인문사회계열교수는 인문사회 분야를 가르치는 업무를 수행합니다.\n\n강의를 준비합니다.\n\n학생들을 가르칩니다.\n\n연구를 수행합니다.\n\n논문을 작성합니다.\n\n학술 활동에 참여합니다.... 기반으로 40로 평가","people_facing":"people_facing는 인문사회계열교수는 인문사회 분야를 가르치는 업무를 수행합니다.\n\n강의를 준비합니다.\n\n학생들을 가르칩니다.\n\n연구를 수행합니다.\n\n논문을 작성합니다.\n\n학술 활동에 참여합니다.... 기반으로 35로 평가","degree_required":"degree_required는 인문사회계열교수는 인문사회 분야를 가르치는 업무를 수행합니다.\n\n강의를 준비합니다.\n\n학생들을 가르칩니다.\n\n연구를 수행합니다.\n\n논문을 작성합니다.\n\n학술 활동에 참여합니다.... 기반으로 phd로 평가","license_required":"license_required는 인문사회계열교수는 인문사회 분야를 가르치는 업무를 수행합니다.\n\n강의를 준비합니다.\n\n학생들을 가르칩니다.\n\n연구를 수행합니다.\n\n논문을 작성합니다.\n\n학술 활동에 참여합니다.... 기반으로 none로 평가"}'
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
  '1765283341791607',
  '양장사 및 양복사',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 50, 50,
  50, 50, 30, 60, 60, 75,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 양장사 및 양복사는 양복과 양장을 디자인하고 제작하는 업무를 수행합니다.\n\n고객의 체형과 취향을 파악합니다.\n\n패턴을 설계합니다.\n\n천을 재단합니다.\n\n봉제 작업을 합니다.\n\n완성... 기반으로 50로 평가","growth":"growth는 양장사 및 양복사는 양복과 양장을 디자인하고 제작하는 업무를 수행합니다.\n\n고객의 체형과 취향을 파악합니다.\n\n패턴을 설계합니다.\n\n천을 재단합니다.\n\n봉제 작업을 합니다.\n\n완성... 기반으로 65로 평가","stability":"stability는 양장사 및 양복사는 양복과 양장을 디자인하고 제작하는 업무를 수행합니다.\n\n고객의 체형과 취향을 파악합니다.\n\n패턴을 설계합니다.\n\n천을 재단합니다.\n\n봉제 작업을 합니다.\n\n완성... 기반으로 50로 평가","income":"income는 양장사 및 양복사는 양복과 양장을 디자인하고 제작하는 업무를 수행합니다.\n\n고객의 체형과 취향을 파악합니다.\n\n패턴을 설계합니다.\n\n천을 재단합니다.\n\n봉제 작업을 합니다.\n\n완성... 기반으로 50로 평가","teamwork":"teamwork는 양장사 및 양복사는 양복과 양장을 디자인하고 제작하는 업무를 수행합니다.\n\n고객의 체형과 취향을 파악합니다.\n\n패턴을 설계합니다.\n\n천을 재단합니다.\n\n봉제 작업을 합니다.\n\n완성... 기반으로 50로 평가","solo_deep":"solo_deep는 양장사 및 양복사는 양복과 양장을 디자인하고 제작하는 업무를 수행합니다.\n\n고객의 체형과 취향을 파악합니다.\n\n패턴을 설계합니다.\n\n천을 재단합니다.\n\n봉제 작업을 합니다.\n\n완성... 기반으로 50로 평가","analytical":"analytical는 양장사 및 양복사는 양복과 양장을 디자인하고 제작하는 업무를 수행합니다.\n\n고객의 체형과 취향을 파악합니다.\n\n패턴을 설계합니다.\n\n천을 재단합니다.\n\n봉제 작업을 합니다.\n\n완성... 기반으로 30로 평가","creative":"creative는 양장사 및 양복사는 양복과 양장을 디자인하고 제작하는 업무를 수행합니다.\n\n고객의 체형과 취향을 파악합니다.\n\n패턴을 설계합니다.\n\n천을 재단합니다.\n\n봉제 작업을 합니다.\n\n완성... 기반으로 60로 평가","execution":"execution는 양장사 및 양복사는 양복과 양장을 디자인하고 제작하는 업무를 수행합니다.\n\n고객의 체형과 취향을 파악합니다.\n\n패턴을 설계합니다.\n\n천을 재단합니다.\n\n봉제 작업을 합니다.\n\n완성... 기반으로 60로 평가","people_facing":"people_facing는 양장사 및 양복사는 양복과 양장을 디자인하고 제작하는 업무를 수행합니다.\n\n고객의 체형과 취향을 파악합니다.\n\n패턴을 설계합니다.\n\n천을 재단합니다.\n\n봉제 작업을 합니다.\n\n완성... 기반으로 75로 평가","degree_required":"degree_required는 양장사 및 양복사는 양복과 양장을 디자인하고 제작하는 업무를 수행합니다.\n\n고객의 체형과 취향을 파악합니다.\n\n패턴을 설계합니다.\n\n천을 재단합니다.\n\n봉제 작업을 합니다.\n\n완성... 기반으로 none로 평가","license_required":"license_required는 양장사 및 양복사는 양복과 양장을 디자인하고 제작하는 업무를 수행합니다.\n\n고객의 체형과 취향을 파악합니다.\n\n패턴을 설계합니다.\n\n천을 재단합니다.\n\n봉제 작업을 합니다.\n\n완성... 기반으로 none로 평가"}'
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
  '1765283343766144',
  '연근해 어부 및 해녀',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  50, 50, 40, 40, 70, 50,
  'regular', 'none', 'some', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 연근해 어부 및 해녀는 바다에서 물고기를 잡는 업무를 수행합니다.\n\n물고기의 이동 패턴을 관찰합니다.\n\n그물을 설치합니다.\n\n물고기를 포획합니다.\n\n수확물을 정리합니다.\n\n안전 수... 기반으로 50로 평가","growth":"growth는 연근해 어부 및 해녀는 바다에서 물고기를 잡는 업무를 수행합니다.\n\n물고기의 이동 패턴을 관찰합니다.\n\n그물을 설치합니다.\n\n물고기를 포획합니다.\n\n수확물을 정리합니다.\n\n안전 수... 기반으로 50로 평가","stability":"stability는 연근해 어부 및 해녀는 바다에서 물고기를 잡는 업무를 수행합니다.\n\n물고기의 이동 패턴을 관찰합니다.\n\n그물을 설치합니다.\n\n물고기를 포획합니다.\n\n수확물을 정리합니다.\n\n안전 수... 기반으로 50로 평가","income":"income는 연근해 어부 및 해녀는 바다에서 물고기를 잡는 업무를 수행합니다.\n\n물고기의 이동 패턴을 관찰합니다.\n\n그물을 설치합니다.\n\n물고기를 포획합니다.\n\n수확물을 정리합니다.\n\n안전 수... 기반으로 50로 평가","teamwork":"teamwork는 연근해 어부 및 해녀는 바다에서 물고기를 잡는 업무를 수행합니다.\n\n물고기의 이동 패턴을 관찰합니다.\n\n그물을 설치합니다.\n\n물고기를 포획합니다.\n\n수확물을 정리합니다.\n\n안전 수... 기반으로 50로 평가","solo_deep":"solo_deep는 연근해 어부 및 해녀는 바다에서 물고기를 잡는 업무를 수행합니다.\n\n물고기의 이동 패턴을 관찰합니다.\n\n그물을 설치합니다.\n\n물고기를 포획합니다.\n\n수확물을 정리합니다.\n\n안전 수... 기반으로 50로 평가","analytical":"analytical는 연근해 어부 및 해녀는 바다에서 물고기를 잡는 업무를 수행합니다.\n\n물고기의 이동 패턴을 관찰합니다.\n\n그물을 설치합니다.\n\n물고기를 포획합니다.\n\n수확물을 정리합니다.\n\n안전 수... 기반으로 40로 평가","creative":"creative는 연근해 어부 및 해녀는 바다에서 물고기를 잡는 업무를 수행합니다.\n\n물고기의 이동 패턴을 관찰합니다.\n\n그물을 설치합니다.\n\n물고기를 포획합니다.\n\n수확물을 정리합니다.\n\n안전 수... 기반으로 40로 평가","execution":"execution는 연근해 어부 및 해녀는 바다에서 물고기를 잡는 업무를 수행합니다.\n\n물고기의 이동 패턴을 관찰합니다.\n\n그물을 설치합니다.\n\n물고기를 포획합니다.\n\n수확물을 정리합니다.\n\n안전 수... 기반으로 70로 평가","people_facing":"people_facing는 연근해 어부 및 해녀는 바다에서 물고기를 잡는 업무를 수행합니다.\n\n물고기의 이동 패턴을 관찰합니다.\n\n그물을 설치합니다.\n\n물고기를 포획합니다.\n\n수확물을 정리합니다.\n\n안전 수... 기반으로 50로 평가","degree_required":"degree_required는 연근해 어부 및 해녀는 바다에서 물고기를 잡는 업무를 수행합니다.\n\n물고기의 이동 패턴을 관찰합니다.\n\n그물을 설치합니다.\n\n물고기를 포획합니다.\n\n수확물을 정리합니다.\n\n안전 수... 기반으로 none로 평가","license_required":"license_required는 연근해 어부 및 해녀는 바다에서 물고기를 잡는 업무를 수행합니다.\n\n물고기의 이동 패턴을 관찰합니다.\n\n그물을 설치합니다.\n\n물고기를 포획합니다.\n\n수확물을 정리합니다.\n\n안전 수... 기반으로 none로 평가"}'
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