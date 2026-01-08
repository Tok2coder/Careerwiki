-- Batch tagging SQL generated at 2026-01-06T06:07:39.424Z
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
  '1765283331682714',
  '수질환경연구원',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 50, 70,
  50, 50, 50, 50, 50, 35,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 수질환경연구원은 수질 오염의 원인과 영향을 연구하고 수질 개선 방안을 개발하는 업무를 수행합니다.\n\n수질 샘플을 채취하고 분석합니다.\n\n수질 오염원을 조사하고 평가합니다.\n\n수질 ... 기반으로 50로 평가","growth":"growth는 수질환경연구원은 수질 오염의 원인과 영향을 연구하고 수질 개선 방안을 개발하는 업무를 수행합니다.\n\n수질 샘플을 채취하고 분석합니다.\n\n수질 오염원을 조사하고 평가합니다.\n\n수질 ... 기반으로 65로 평가","stability":"stability는 수질환경연구원은 수질 오염의 원인과 영향을 연구하고 수질 개선 방안을 개발하는 업무를 수행합니다.\n\n수질 샘플을 채취하고 분석합니다.\n\n수질 오염원을 조사하고 평가합니다.\n\n수질 ... 기반으로 50로 평가","income":"income는 수질환경연구원은 수질 오염의 원인과 영향을 연구하고 수질 개선 방안을 개발하는 업무를 수행합니다.\n\n수질 샘플을 채취하고 분석합니다.\n\n수질 오염원을 조사하고 평가합니다.\n\n수질 ... 기반으로 70로 평가","teamwork":"teamwork는 수질환경연구원은 수질 오염의 원인과 영향을 연구하고 수질 개선 방안을 개발하는 업무를 수행합니다.\n\n수질 샘플을 채취하고 분석합니다.\n\n수질 오염원을 조사하고 평가합니다.\n\n수질 ... 기반으로 50로 평가","solo_deep":"solo_deep는 수질환경연구원은 수질 오염의 원인과 영향을 연구하고 수질 개선 방안을 개발하는 업무를 수행합니다.\n\n수질 샘플을 채취하고 분석합니다.\n\n수질 오염원을 조사하고 평가합니다.\n\n수질 ... 기반으로 50로 평가","analytical":"analytical는 수질환경연구원은 수질 오염의 원인과 영향을 연구하고 수질 개선 방안을 개발하는 업무를 수행합니다.\n\n수질 샘플을 채취하고 분석합니다.\n\n수질 오염원을 조사하고 평가합니다.\n\n수질 ... 기반으로 50로 평가","creative":"creative는 수질환경연구원은 수질 오염의 원인과 영향을 연구하고 수질 개선 방안을 개발하는 업무를 수행합니다.\n\n수질 샘플을 채취하고 분석합니다.\n\n수질 오염원을 조사하고 평가합니다.\n\n수질 ... 기반으로 50로 평가","execution":"execution는 수질환경연구원은 수질 오염의 원인과 영향을 연구하고 수질 개선 방안을 개발하는 업무를 수행합니다.\n\n수질 샘플을 채취하고 분석합니다.\n\n수질 오염원을 조사하고 평가합니다.\n\n수질 ... 기반으로 50로 평가","people_facing":"people_facing는 수질환경연구원은 수질 오염의 원인과 영향을 연구하고 수질 개선 방안을 개발하는 업무를 수행합니다.\n\n수질 샘플을 채취하고 분석합니다.\n\n수질 오염원을 조사하고 평가합니다.\n\n수질 ... 기반으로 35로 평가","degree_required":"degree_required는 수질환경연구원은 수질 오염의 원인과 영향을 연구하고 수질 개선 방안을 개발하는 업무를 수행합니다.\n\n수질 샘플을 채취하고 분석합니다.\n\n수질 오염원을 조사하고 평가합니다.\n\n수질 ... 기반으로 none로 평가","license_required":"license_required는 수질환경연구원은 수질 오염의 원인과 영향을 연구하고 수질 개선 방안을 개발하는 업무를 수행합니다.\n\n수질 샘플을 채취하고 분석합니다.\n\n수질 오염원을 조사하고 평가합니다.\n\n수질 ... 기반으로 none로 평가"}'
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
  '1765283385623157',
  '커플매니저',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 50, 50,
  50, 50, 30, 60, 60, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 커플매니저는 커플의 결혼 준비를 돕고 결혼식을 기획하는 업무를 수행합니다.\n\n커플의 예산과 선호도를 파악합니다.\n\n결혼식 장소와 날짜를 예약합니다.\n\n하객 관리와 초대장을 준비합니... 기반으로 50로 평가","growth":"growth는 커플매니저는 커플의 결혼 준비를 돕고 결혼식을 기획하는 업무를 수행합니다.\n\n커플의 예산과 선호도를 파악합니다.\n\n결혼식 장소와 날짜를 예약합니다.\n\n하객 관리와 초대장을 준비합니... 기반으로 65로 평가","stability":"stability는 커플매니저는 커플의 결혼 준비를 돕고 결혼식을 기획하는 업무를 수행합니다.\n\n커플의 예산과 선호도를 파악합니다.\n\n결혼식 장소와 날짜를 예약합니다.\n\n하객 관리와 초대장을 준비합니... 기반으로 50로 평가","income":"income는 커플매니저는 커플의 결혼 준비를 돕고 결혼식을 기획하는 업무를 수행합니다.\n\n커플의 예산과 선호도를 파악합니다.\n\n결혼식 장소와 날짜를 예약합니다.\n\n하객 관리와 초대장을 준비합니... 기반으로 50로 평가","teamwork":"teamwork는 커플매니저는 커플의 결혼 준비를 돕고 결혼식을 기획하는 업무를 수행합니다.\n\n커플의 예산과 선호도를 파악합니다.\n\n결혼식 장소와 날짜를 예약합니다.\n\n하객 관리와 초대장을 준비합니... 기반으로 50로 평가","solo_deep":"solo_deep는 커플매니저는 커플의 결혼 준비를 돕고 결혼식을 기획하는 업무를 수행합니다.\n\n커플의 예산과 선호도를 파악합니다.\n\n결혼식 장소와 날짜를 예약합니다.\n\n하객 관리와 초대장을 준비합니... 기반으로 50로 평가","analytical":"analytical는 커플매니저는 커플의 결혼 준비를 돕고 결혼식을 기획하는 업무를 수행합니다.\n\n커플의 예산과 선호도를 파악합니다.\n\n결혼식 장소와 날짜를 예약합니다.\n\n하객 관리와 초대장을 준비합니... 기반으로 30로 평가","creative":"creative는 커플매니저는 커플의 결혼 준비를 돕고 결혼식을 기획하는 업무를 수행합니다.\n\n커플의 예산과 선호도를 파악합니다.\n\n결혼식 장소와 날짜를 예약합니다.\n\n하객 관리와 초대장을 준비합니... 기반으로 60로 평가","execution":"execution는 커플매니저는 커플의 결혼 준비를 돕고 결혼식을 기획하는 업무를 수행합니다.\n\n커플의 예산과 선호도를 파악합니다.\n\n결혼식 장소와 날짜를 예약합니다.\n\n하객 관리와 초대장을 준비합니... 기반으로 60로 평가","people_facing":"people_facing는 커플매니저는 커플의 결혼 준비를 돕고 결혼식을 기획하는 업무를 수행합니다.\n\n커플의 예산과 선호도를 파악합니다.\n\n결혼식 장소와 날짜를 예약합니다.\n\n하객 관리와 초대장을 준비합니... 기반으로 50로 평가","degree_required":"degree_required는 커플매니저는 커플의 결혼 준비를 돕고 결혼식을 기획하는 업무를 수행합니다.\n\n커플의 예산과 선호도를 파악합니다.\n\n결혼식 장소와 날짜를 예약합니다.\n\n하객 관리와 초대장을 준비합니... 기반으로 none로 평가","license_required":"license_required는 커플매니저는 커플의 결혼 준비를 돕고 결혼식을 기획하는 업무를 수행합니다.\n\n커플의 예산과 선호도를 파악합니다.\n\n결혼식 장소와 날짜를 예약합니다.\n\n하객 관리와 초대장을 준비합니... 기반으로 none로 평가"}'
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
  '1765283315326388',
  '병원코디네이터',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 70,
  50, 50, 60, 30, 60, 75,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 병원코디네이터는 환자와 의료진 사이의 의사소통을 돕고 병원 이용을 지원하는 업무를 수행합니다.\n\n환자의 진료 예약을 관리합니다.\n\n외국인 환자의 통역을 담당합니다.\n\n병원 이용 안... 기반으로 50로 평가","growth":"growth는 병원코디네이터는 환자와 의료진 사이의 의사소통을 돕고 병원 이용을 지원하는 업무를 수행합니다.\n\n환자의 진료 예약을 관리합니다.\n\n외국인 환자의 통역을 담당합니다.\n\n병원 이용 안... 기반으로 50로 평가","stability":"stability는 병원코디네이터는 환자와 의료진 사이의 의사소통을 돕고 병원 이용을 지원하는 업무를 수행합니다.\n\n환자의 진료 예약을 관리합니다.\n\n외국인 환자의 통역을 담당합니다.\n\n병원 이용 안... 기반으로 50로 평가","income":"income는 병원코디네이터는 환자와 의료진 사이의 의사소통을 돕고 병원 이용을 지원하는 업무를 수행합니다.\n\n환자의 진료 예약을 관리합니다.\n\n외국인 환자의 통역을 담당합니다.\n\n병원 이용 안... 기반으로 70로 평가","teamwork":"teamwork는 병원코디네이터는 환자와 의료진 사이의 의사소통을 돕고 병원 이용을 지원하는 업무를 수행합니다.\n\n환자의 진료 예약을 관리합니다.\n\n외국인 환자의 통역을 담당합니다.\n\n병원 이용 안... 기반으로 50로 평가","solo_deep":"solo_deep는 병원코디네이터는 환자와 의료진 사이의 의사소통을 돕고 병원 이용을 지원하는 업무를 수행합니다.\n\n환자의 진료 예약을 관리합니다.\n\n외국인 환자의 통역을 담당합니다.\n\n병원 이용 안... 기반으로 50로 평가","analytical":"analytical는 병원코디네이터는 환자와 의료진 사이의 의사소통을 돕고 병원 이용을 지원하는 업무를 수행합니다.\n\n환자의 진료 예약을 관리합니다.\n\n외국인 환자의 통역을 담당합니다.\n\n병원 이용 안... 기반으로 60로 평가","creative":"creative는 병원코디네이터는 환자와 의료진 사이의 의사소통을 돕고 병원 이용을 지원하는 업무를 수행합니다.\n\n환자의 진료 예약을 관리합니다.\n\n외국인 환자의 통역을 담당합니다.\n\n병원 이용 안... 기반으로 30로 평가","execution":"execution는 병원코디네이터는 환자와 의료진 사이의 의사소통을 돕고 병원 이용을 지원하는 업무를 수행합니다.\n\n환자의 진료 예약을 관리합니다.\n\n외국인 환자의 통역을 담당합니다.\n\n병원 이용 안... 기반으로 60로 평가","people_facing":"people_facing는 병원코디네이터는 환자와 의료진 사이의 의사소통을 돕고 병원 이용을 지원하는 업무를 수행합니다.\n\n환자의 진료 예약을 관리합니다.\n\n외국인 환자의 통역을 담당합니다.\n\n병원 이용 안... 기반으로 75로 평가","degree_required":"degree_required는 병원코디네이터는 환자와 의료진 사이의 의사소통을 돕고 병원 이용을 지원하는 업무를 수행합니다.\n\n환자의 진료 예약을 관리합니다.\n\n외국인 환자의 통역을 담당합니다.\n\n병원 이용 안... 기반으로 none로 평가","license_required":"license_required는 병원코디네이터는 환자와 의료진 사이의 의사소통을 돕고 병원 이용을 지원하는 업무를 수행합니다.\n\n환자의 진료 예약을 관리합니다.\n\n외국인 환자의 통역을 담당합니다.\n\n병원 이용 안... 기반으로 none로 평가"}'
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
  '1765283392589306',
  '파티플래너',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 50, 50,
  50, 50, 60, 60, 30, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 파티플래너는 각종 행사와 파티를 기획하고 실행하는 업무를 수행합니다.\n\n클라이언트의 요구사항을 파악합니다.\n\n행사 콘셉트와 예산을 계획합니다.\n\n장소와 날짜를 예약합니다.\n\n행사 ... 기반으로 50로 평가","growth":"growth는 파티플래너는 각종 행사와 파티를 기획하고 실행하는 업무를 수행합니다.\n\n클라이언트의 요구사항을 파악합니다.\n\n행사 콘셉트와 예산을 계획합니다.\n\n장소와 날짜를 예약합니다.\n\n행사 ... 기반으로 65로 평가","stability":"stability는 파티플래너는 각종 행사와 파티를 기획하고 실행하는 업무를 수행합니다.\n\n클라이언트의 요구사항을 파악합니다.\n\n행사 콘셉트와 예산을 계획합니다.\n\n장소와 날짜를 예약합니다.\n\n행사 ... 기반으로 50로 평가","income":"income는 파티플래너는 각종 행사와 파티를 기획하고 실행하는 업무를 수행합니다.\n\n클라이언트의 요구사항을 파악합니다.\n\n행사 콘셉트와 예산을 계획합니다.\n\n장소와 날짜를 예약합니다.\n\n행사 ... 기반으로 50로 평가","teamwork":"teamwork는 파티플래너는 각종 행사와 파티를 기획하고 실행하는 업무를 수행합니다.\n\n클라이언트의 요구사항을 파악합니다.\n\n행사 콘셉트와 예산을 계획합니다.\n\n장소와 날짜를 예약합니다.\n\n행사 ... 기반으로 50로 평가","solo_deep":"solo_deep는 파티플래너는 각종 행사와 파티를 기획하고 실행하는 업무를 수행합니다.\n\n클라이언트의 요구사항을 파악합니다.\n\n행사 콘셉트와 예산을 계획합니다.\n\n장소와 날짜를 예약합니다.\n\n행사 ... 기반으로 50로 평가","analytical":"analytical는 파티플래너는 각종 행사와 파티를 기획하고 실행하는 업무를 수행합니다.\n\n클라이언트의 요구사항을 파악합니다.\n\n행사 콘셉트와 예산을 계획합니다.\n\n장소와 날짜를 예약합니다.\n\n행사 ... 기반으로 60로 평가","creative":"creative는 파티플래너는 각종 행사와 파티를 기획하고 실행하는 업무를 수행합니다.\n\n클라이언트의 요구사항을 파악합니다.\n\n행사 콘셉트와 예산을 계획합니다.\n\n장소와 날짜를 예약합니다.\n\n행사 ... 기반으로 60로 평가","execution":"execution는 파티플래너는 각종 행사와 파티를 기획하고 실행하는 업무를 수행합니다.\n\n클라이언트의 요구사항을 파악합니다.\n\n행사 콘셉트와 예산을 계획합니다.\n\n장소와 날짜를 예약합니다.\n\n행사 ... 기반으로 30로 평가","people_facing":"people_facing는 파티플래너는 각종 행사와 파티를 기획하고 실행하는 업무를 수행합니다.\n\n클라이언트의 요구사항을 파악합니다.\n\n행사 콘셉트와 예산을 계획합니다.\n\n장소와 날짜를 예약합니다.\n\n행사 ... 기반으로 50로 평가","degree_required":"degree_required는 파티플래너는 각종 행사와 파티를 기획하고 실행하는 업무를 수행합니다.\n\n클라이언트의 요구사항을 파악합니다.\n\n행사 콘셉트와 예산을 계획합니다.\n\n장소와 날짜를 예약합니다.\n\n행사 ... 기반으로 none로 평가","license_required":"license_required는 파티플래너는 각종 행사와 파티를 기획하고 실행하는 업무를 수행합니다.\n\n클라이언트의 요구사항을 파악합니다.\n\n행사 콘셉트와 예산을 계획합니다.\n\n장소와 날짜를 예약합니다.\n\n행사 ... 기반으로 none로 평가"}'
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


INSERT INTO job_attributes (
  job_id, job_name, source_system, tagger_version, status,
  wlb, growth, stability, income,
  teamwork, solo_deep, analytical, creative, execution, people_facing,
  work_hours, shift_work, travel, remote_possible,
  degree_required, license_required, experience_required,
  _confidence, _field_confidence_json, evidence_json
) VALUES (
  '1765283378710422',
  '직조원',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  50, 50, 40, 40, 70, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 직조원은 섬유를 직조하여 천을 생산하는 업무를 수행합니다.\n\n직조 기계를 설정하고 운영합니다.\n\n섬유의 품질을 검사합니다.\n\n생산된 천의 품질을 확인합니다.\n\n기계의 유지보수를 담... 기반으로 50로 평가","growth":"growth는 직조원은 섬유를 직조하여 천을 생산하는 업무를 수행합니다.\n\n직조 기계를 설정하고 운영합니다.\n\n섬유의 품질을 검사합니다.\n\n생산된 천의 품질을 확인합니다.\n\n기계의 유지보수를 담... 기반으로 50로 평가","stability":"stability는 직조원은 섬유를 직조하여 천을 생산하는 업무를 수행합니다.\n\n직조 기계를 설정하고 운영합니다.\n\n섬유의 품질을 검사합니다.\n\n생산된 천의 품질을 확인합니다.\n\n기계의 유지보수를 담... 기반으로 50로 평가","income":"income는 직조원은 섬유를 직조하여 천을 생산하는 업무를 수행합니다.\n\n직조 기계를 설정하고 운영합니다.\n\n섬유의 품질을 검사합니다.\n\n생산된 천의 품질을 확인합니다.\n\n기계의 유지보수를 담... 기반으로 50로 평가","teamwork":"teamwork는 직조원은 섬유를 직조하여 천을 생산하는 업무를 수행합니다.\n\n직조 기계를 설정하고 운영합니다.\n\n섬유의 품질을 검사합니다.\n\n생산된 천의 품질을 확인합니다.\n\n기계의 유지보수를 담... 기반으로 50로 평가","solo_deep":"solo_deep는 직조원은 섬유를 직조하여 천을 생산하는 업무를 수행합니다.\n\n직조 기계를 설정하고 운영합니다.\n\n섬유의 품질을 검사합니다.\n\n생산된 천의 품질을 확인합니다.\n\n기계의 유지보수를 담... 기반으로 50로 평가","analytical":"analytical는 직조원은 섬유를 직조하여 천을 생산하는 업무를 수행합니다.\n\n직조 기계를 설정하고 운영합니다.\n\n섬유의 품질을 검사합니다.\n\n생산된 천의 품질을 확인합니다.\n\n기계의 유지보수를 담... 기반으로 40로 평가","creative":"creative는 직조원은 섬유를 직조하여 천을 생산하는 업무를 수행합니다.\n\n직조 기계를 설정하고 운영합니다.\n\n섬유의 품질을 검사합니다.\n\n생산된 천의 품질을 확인합니다.\n\n기계의 유지보수를 담... 기반으로 40로 평가","execution":"execution는 직조원은 섬유를 직조하여 천을 생산하는 업무를 수행합니다.\n\n직조 기계를 설정하고 운영합니다.\n\n섬유의 품질을 검사합니다.\n\n생산된 천의 품질을 확인합니다.\n\n기계의 유지보수를 담... 기반으로 70로 평가","people_facing":"people_facing는 직조원은 섬유를 직조하여 천을 생산하는 업무를 수행합니다.\n\n직조 기계를 설정하고 운영합니다.\n\n섬유의 품질을 검사합니다.\n\n생산된 천의 품질을 확인합니다.\n\n기계의 유지보수를 담... 기반으로 50로 평가","degree_required":"degree_required는 직조원은 섬유를 직조하여 천을 생산하는 업무를 수행합니다.\n\n직조 기계를 설정하고 운영합니다.\n\n섬유의 품질을 검사합니다.\n\n생산된 천의 품질을 확인합니다.\n\n기계의 유지보수를 담... 기반으로 none로 평가","license_required":"license_required는 직조원은 섬유를 직조하여 천을 생산하는 업무를 수행합니다.\n\n직조 기계를 설정하고 운영합니다.\n\n섬유의 품질을 검사합니다.\n\n생산된 천의 품질을 확인합니다.\n\n기계의 유지보수를 담... 기반으로 none로 평가"}'
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
  '176528338532796',
  '캐스팅디렉터',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 30, 50,
  50, 50, 60, 30, 60, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 캐스팅디렉터는 연극, 영화, 방송 등의 출연자를 선발하는 업무를 수행합니다.\n\n작품의 요구사항을 분석합니다.\n\n배우 오디션을 진행합니다.\n\n적합한 출연자를 선발합니다.\n\n출연 계약... 기반으로 50로 평가","growth":"growth는 캐스팅디렉터는 연극, 영화, 방송 등의 출연자를 선발하는 업무를 수행합니다.\n\n작품의 요구사항을 분석합니다.\n\n배우 오디션을 진행합니다.\n\n적합한 출연자를 선발합니다.\n\n출연 계약... 기반으로 50로 평가","stability":"stability는 캐스팅디렉터는 연극, 영화, 방송 등의 출연자를 선발하는 업무를 수행합니다.\n\n작품의 요구사항을 분석합니다.\n\n배우 오디션을 진행합니다.\n\n적합한 출연자를 선발합니다.\n\n출연 계약... 기반으로 30로 평가","income":"income는 캐스팅디렉터는 연극, 영화, 방송 등의 출연자를 선발하는 업무를 수행합니다.\n\n작품의 요구사항을 분석합니다.\n\n배우 오디션을 진행합니다.\n\n적합한 출연자를 선발합니다.\n\n출연 계약... 기반으로 50로 평가","teamwork":"teamwork는 캐스팅디렉터는 연극, 영화, 방송 등의 출연자를 선발하는 업무를 수행합니다.\n\n작품의 요구사항을 분석합니다.\n\n배우 오디션을 진행합니다.\n\n적합한 출연자를 선발합니다.\n\n출연 계약... 기반으로 50로 평가","solo_deep":"solo_deep는 캐스팅디렉터는 연극, 영화, 방송 등의 출연자를 선발하는 업무를 수행합니다.\n\n작품의 요구사항을 분석합니다.\n\n배우 오디션을 진행합니다.\n\n적합한 출연자를 선발합니다.\n\n출연 계약... 기반으로 50로 평가","analytical":"analytical는 캐스팅디렉터는 연극, 영화, 방송 등의 출연자를 선발하는 업무를 수행합니다.\n\n작품의 요구사항을 분석합니다.\n\n배우 오디션을 진행합니다.\n\n적합한 출연자를 선발합니다.\n\n출연 계약... 기반으로 60로 평가","creative":"creative는 캐스팅디렉터는 연극, 영화, 방송 등의 출연자를 선발하는 업무를 수행합니다.\n\n작품의 요구사항을 분석합니다.\n\n배우 오디션을 진행합니다.\n\n적합한 출연자를 선발합니다.\n\n출연 계약... 기반으로 30로 평가","execution":"execution는 캐스팅디렉터는 연극, 영화, 방송 등의 출연자를 선발하는 업무를 수행합니다.\n\n작품의 요구사항을 분석합니다.\n\n배우 오디션을 진행합니다.\n\n적합한 출연자를 선발합니다.\n\n출연 계약... 기반으로 60로 평가","people_facing":"people_facing는 캐스팅디렉터는 연극, 영화, 방송 등의 출연자를 선발하는 업무를 수행합니다.\n\n작품의 요구사항을 분석합니다.\n\n배우 오디션을 진행합니다.\n\n적합한 출연자를 선발합니다.\n\n출연 계약... 기반으로 50로 평가","degree_required":"degree_required는 캐스팅디렉터는 연극, 영화, 방송 등의 출연자를 선발하는 업무를 수행합니다.\n\n작품의 요구사항을 분석합니다.\n\n배우 오디션을 진행합니다.\n\n적합한 출연자를 선발합니다.\n\n출연 계약... 기반으로 none로 평가","license_required":"license_required는 캐스팅디렉터는 연극, 영화, 방송 등의 출연자를 선발하는 업무를 수행합니다.\n\n작품의 요구사항을 분석합니다.\n\n배우 오디션을 진행합니다.\n\n적합한 출연자를 선발합니다.\n\n출연 계약... 기반으로 none로 평가"}'
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
  '1765283396606169',
  '학습지방문교사',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  40, 50, 50, 50,
  30, 70, 70, 40, 40, 75,
  'overtime_some', 'none', 'some', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 학습지방문교사는 학생들의 집을 방문하여 학습을 지도하는 업무를 수행합니다.\n\n학생의 학습 수준을 평가합니다.\n\n개인별 맞춤 학습 계획을 수립합니다.\n\n학습지 교재를 활용하여 수업을... 기반으로 40로 평가","growth":"growth는 학습지방문교사는 학생들의 집을 방문하여 학습을 지도하는 업무를 수행합니다.\n\n학생의 학습 수준을 평가합니다.\n\n개인별 맞춤 학습 계획을 수립합니다.\n\n학습지 교재를 활용하여 수업을... 기반으로 50로 평가","stability":"stability는 학습지방문교사는 학생들의 집을 방문하여 학습을 지도하는 업무를 수행합니다.\n\n학생의 학습 수준을 평가합니다.\n\n개인별 맞춤 학습 계획을 수립합니다.\n\n학습지 교재를 활용하여 수업을... 기반으로 50로 평가","income":"income는 학습지방문교사는 학생들의 집을 방문하여 학습을 지도하는 업무를 수행합니다.\n\n학생의 학습 수준을 평가합니다.\n\n개인별 맞춤 학습 계획을 수립합니다.\n\n학습지 교재를 활용하여 수업을... 기반으로 50로 평가","teamwork":"teamwork는 학습지방문교사는 학생들의 집을 방문하여 학습을 지도하는 업무를 수행합니다.\n\n학생의 학습 수준을 평가합니다.\n\n개인별 맞춤 학습 계획을 수립합니다.\n\n학습지 교재를 활용하여 수업을... 기반으로 30로 평가","solo_deep":"solo_deep는 학습지방문교사는 학생들의 집을 방문하여 학습을 지도하는 업무를 수행합니다.\n\n학생의 학습 수준을 평가합니다.\n\n개인별 맞춤 학습 계획을 수립합니다.\n\n학습지 교재를 활용하여 수업을... 기반으로 70로 평가","analytical":"analytical는 학습지방문교사는 학생들의 집을 방문하여 학습을 지도하는 업무를 수행합니다.\n\n학생의 학습 수준을 평가합니다.\n\n개인별 맞춤 학습 계획을 수립합니다.\n\n학습지 교재를 활용하여 수업을... 기반으로 70로 평가","creative":"creative는 학습지방문교사는 학생들의 집을 방문하여 학습을 지도하는 업무를 수행합니다.\n\n학생의 학습 수준을 평가합니다.\n\n개인별 맞춤 학습 계획을 수립합니다.\n\n학습지 교재를 활용하여 수업을... 기반으로 40로 평가","execution":"execution는 학습지방문교사는 학생들의 집을 방문하여 학습을 지도하는 업무를 수행합니다.\n\n학생의 학습 수준을 평가합니다.\n\n개인별 맞춤 학습 계획을 수립합니다.\n\n학습지 교재를 활용하여 수업을... 기반으로 40로 평가","people_facing":"people_facing는 학습지방문교사는 학생들의 집을 방문하여 학습을 지도하는 업무를 수행합니다.\n\n학생의 학습 수준을 평가합니다.\n\n개인별 맞춤 학습 계획을 수립합니다.\n\n학습지 교재를 활용하여 수업을... 기반으로 75로 평가","degree_required":"degree_required는 학습지방문교사는 학생들의 집을 방문하여 학습을 지도하는 업무를 수행합니다.\n\n학생의 학습 수준을 평가합니다.\n\n개인별 맞춤 학습 계획을 수립합니다.\n\n학습지 교재를 활용하여 수업을... 기반으로 none로 평가","license_required":"license_required는 학습지방문교사는 학생들의 집을 방문하여 학습을 지도하는 업무를 수행합니다.\n\n학생의 학습 수준을 평가합니다.\n\n개인별 맞춤 학습 계획을 수립합니다.\n\n학습지 교재를 활용하여 수업을... 기반으로 none로 평가"}'
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
  '1765283289215513',
  '교육학연구원',
  'CAREERNET',
  'tagger-v1.0.0',
  'tagged',
  40, 95, 65, 60,
  50, 50, 60, 60, 30, 35,
  'overtime_some', 'none', 'some', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 교육학연구원은 교육 방법과 교육 제도의 연구와 개발 업무를 수행합니다.\n\n교육 현장을 조사하고 교육 데이터를 수집합니다.\n\n교육 프로그램의 효과성을 연구합니다.\n\n새로운 교육 방법... 기반으로 40로 평가","growth":"growth는 교육학연구원은 교육 방법과 교육 제도의 연구와 개발 업무를 수행합니다.\n\n교육 현장을 조사하고 교육 데이터를 수집합니다.\n\n교육 프로그램의 효과성을 연구합니다.\n\n새로운 교육 방법... 기반으로 95로 평가","stability":"stability는 교육학연구원은 교육 방법과 교육 제도의 연구와 개발 업무를 수행합니다.\n\n교육 현장을 조사하고 교육 데이터를 수집합니다.\n\n교육 프로그램의 효과성을 연구합니다.\n\n새로운 교육 방법... 기반으로 65로 평가","income":"income는 교육학연구원은 교육 방법과 교육 제도의 연구와 개발 업무를 수행합니다.\n\n교육 현장을 조사하고 교육 데이터를 수집합니다.\n\n교육 프로그램의 효과성을 연구합니다.\n\n새로운 교육 방법... 기반으로 60로 평가","teamwork":"teamwork는 교육학연구원은 교육 방법과 교육 제도의 연구와 개발 업무를 수행합니다.\n\n교육 현장을 조사하고 교육 데이터를 수집합니다.\n\n교육 프로그램의 효과성을 연구합니다.\n\n새로운 교육 방법... 기반으로 50로 평가","solo_deep":"solo_deep는 교육학연구원은 교육 방법과 교육 제도의 연구와 개발 업무를 수행합니다.\n\n교육 현장을 조사하고 교육 데이터를 수집합니다.\n\n교육 프로그램의 효과성을 연구합니다.\n\n새로운 교육 방법... 기반으로 50로 평가","analytical":"analytical는 교육학연구원은 교육 방법과 교육 제도의 연구와 개발 업무를 수행합니다.\n\n교육 현장을 조사하고 교육 데이터를 수집합니다.\n\n교육 프로그램의 효과성을 연구합니다.\n\n새로운 교육 방법... 기반으로 60로 평가","creative":"creative는 교육학연구원은 교육 방법과 교육 제도의 연구와 개발 업무를 수행합니다.\n\n교육 현장을 조사하고 교육 데이터를 수집합니다.\n\n교육 프로그램의 효과성을 연구합니다.\n\n새로운 교육 방법... 기반으로 60로 평가","execution":"execution는 교육학연구원은 교육 방법과 교육 제도의 연구와 개발 업무를 수행합니다.\n\n교육 현장을 조사하고 교육 데이터를 수집합니다.\n\n교육 프로그램의 효과성을 연구합니다.\n\n새로운 교육 방법... 기반으로 30로 평가","people_facing":"people_facing는 교육학연구원은 교육 방법과 교육 제도의 연구와 개발 업무를 수행합니다.\n\n교육 현장을 조사하고 교육 데이터를 수집합니다.\n\n교육 프로그램의 효과성을 연구합니다.\n\n새로운 교육 방법... 기반으로 35로 평가","degree_required":"degree_required는 교육학연구원은 교육 방법과 교육 제도의 연구와 개발 업무를 수행합니다.\n\n교육 현장을 조사하고 교육 데이터를 수집합니다.\n\n교육 프로그램의 효과성을 연구합니다.\n\n새로운 교육 방법... 기반으로 none로 평가","license_required":"license_required는 교육학연구원은 교육 방법과 교육 제도의 연구와 개발 업무를 수행합니다.\n\n교육 현장을 조사하고 교육 데이터를 수집합니다.\n\n교육 프로그램의 효과성을 연구합니다.\n\n새로운 교육 방법... 기반으로 none로 평가"}'
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