-- Batch tagging SQL generated at 2026-01-06T07:15:01.494Z
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
  '1765283469844377',
  '대중무용수',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 40,
  70, 30, 40, 40, 70, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [대중무용수]\n-춤을 연습한다.\n-공연에 참여한다.\n-안무를 익힌다.\n-표현력을 연마한다.\n-팀과 협력한다.\n-의상을 관리한다.\n-무대를 준비한다.\n-관객과 소통한다.\n-기술을 유... 기반으로 50로 평가","growth":"growth는 [대중무용수]\n-춤을 연습한다.\n-공연에 참여한다.\n-안무를 익힌다.\n-표현력을 연마한다.\n-팀과 협력한다.\n-의상을 관리한다.\n-무대를 준비한다.\n-관객과 소통한다.\n-기술을 유... 기반으로 50로 평가","stability":"stability는 [대중무용수]\n-춤을 연습한다.\n-공연에 참여한다.\n-안무를 익힌다.\n-표현력을 연마한다.\n-팀과 협력한다.\n-의상을 관리한다.\n-무대를 준비한다.\n-관객과 소통한다.\n-기술을 유... 기반으로 50로 평가","income":"income는 [대중무용수]\n-춤을 연습한다.\n-공연에 참여한다.\n-안무를 익힌다.\n-표현력을 연마한다.\n-팀과 협력한다.\n-의상을 관리한다.\n-무대를 준비한다.\n-관객과 소통한다.\n-기술을 유... 기반으로 40로 평가","teamwork":"teamwork는 [대중무용수]\n-춤을 연습한다.\n-공연에 참여한다.\n-안무를 익힌다.\n-표현력을 연마한다.\n-팀과 협력한다.\n-의상을 관리한다.\n-무대를 준비한다.\n-관객과 소통한다.\n-기술을 유... 기반으로 70로 평가","solo_deep":"solo_deep는 [대중무용수]\n-춤을 연습한다.\n-공연에 참여한다.\n-안무를 익힌다.\n-표현력을 연마한다.\n-팀과 협력한다.\n-의상을 관리한다.\n-무대를 준비한다.\n-관객과 소통한다.\n-기술을 유... 기반으로 30로 평가","analytical":"analytical는 [대중무용수]\n-춤을 연습한다.\n-공연에 참여한다.\n-안무를 익힌다.\n-표현력을 연마한다.\n-팀과 협력한다.\n-의상을 관리한다.\n-무대를 준비한다.\n-관객과 소통한다.\n-기술을 유... 기반으로 40로 평가","creative":"creative는 [대중무용수]\n-춤을 연습한다.\n-공연에 참여한다.\n-안무를 익힌다.\n-표현력을 연마한다.\n-팀과 협력한다.\n-의상을 관리한다.\n-무대를 준비한다.\n-관객과 소통한다.\n-기술을 유... 기반으로 40로 평가","execution":"execution는 [대중무용수]\n-춤을 연습한다.\n-공연에 참여한다.\n-안무를 익힌다.\n-표현력을 연마한다.\n-팀과 협력한다.\n-의상을 관리한다.\n-무대를 준비한다.\n-관객과 소통한다.\n-기술을 유... 기반으로 70로 평가","people_facing":"people_facing는 [대중무용수]\n-춤을 연습한다.\n-공연에 참여한다.\n-안무를 익힌다.\n-표현력을 연마한다.\n-팀과 협력한다.\n-의상을 관리한다.\n-무대를 준비한다.\n-관객과 소통한다.\n-기술을 유... 기반으로 50로 평가","degree_required":"degree_required는 [대중무용수]\n-춤을 연습한다.\n-공연에 참여한다.\n-안무를 익힌다.\n-표현력을 연마한다.\n-팀과 협력한다.\n-의상을 관리한다.\n-무대를 준비한다.\n-관객과 소통한다.\n-기술을 유... 기반으로 none로 평가","license_required":"license_required는 [대중무용수]\n-춤을 연습한다.\n-공연에 참여한다.\n-안무를 익힌다.\n-표현력을 연마한다.\n-팀과 협력한다.\n-의상을 관리한다.\n-무대를 준비한다.\n-관객과 소통한다.\n-기술을 유... 기반으로 none로 평가"}'
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
  '1765283424233266',
  '전산자료입력원 및 사무보조원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  40, 50, 70, 50,
  70, 30, 40, 40, 70, 50,
  'overtime_some', 'none', 'some', 'partial',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [전산자료입력원]\n-데이터를 입력한다.\n-문서를 스캔한다.\n-파일을 정리한다.\n-데이터를 검증한다.\n-보고서를 작성한다.\n-시스템을 운영한다.\n-백업을 실시한다.\n-문제를 해결한다... 기반으로 40로 평가","growth":"growth는 [전산자료입력원]\n-데이터를 입력한다.\n-문서를 스캔한다.\n-파일을 정리한다.\n-데이터를 검증한다.\n-보고서를 작성한다.\n-시스템을 운영한다.\n-백업을 실시한다.\n-문제를 해결한다... 기반으로 50로 평가","stability":"stability는 [전산자료입력원]\n-데이터를 입력한다.\n-문서를 스캔한다.\n-파일을 정리한다.\n-데이터를 검증한다.\n-보고서를 작성한다.\n-시스템을 운영한다.\n-백업을 실시한다.\n-문제를 해결한다... 기반으로 70로 평가","income":"income는 [전산자료입력원]\n-데이터를 입력한다.\n-문서를 스캔한다.\n-파일을 정리한다.\n-데이터를 검증한다.\n-보고서를 작성한다.\n-시스템을 운영한다.\n-백업을 실시한다.\n-문제를 해결한다... 기반으로 50로 평가","teamwork":"teamwork는 [전산자료입력원]\n-데이터를 입력한다.\n-문서를 스캔한다.\n-파일을 정리한다.\n-데이터를 검증한다.\n-보고서를 작성한다.\n-시스템을 운영한다.\n-백업을 실시한다.\n-문제를 해결한다... 기반으로 70로 평가","solo_deep":"solo_deep는 [전산자료입력원]\n-데이터를 입력한다.\n-문서를 스캔한다.\n-파일을 정리한다.\n-데이터를 검증한다.\n-보고서를 작성한다.\n-시스템을 운영한다.\n-백업을 실시한다.\n-문제를 해결한다... 기반으로 30로 평가","analytical":"analytical는 [전산자료입력원]\n-데이터를 입력한다.\n-문서를 스캔한다.\n-파일을 정리한다.\n-데이터를 검증한다.\n-보고서를 작성한다.\n-시스템을 운영한다.\n-백업을 실시한다.\n-문제를 해결한다... 기반으로 40로 평가","creative":"creative는 [전산자료입력원]\n-데이터를 입력한다.\n-문서를 스캔한다.\n-파일을 정리한다.\n-데이터를 검증한다.\n-보고서를 작성한다.\n-시스템을 운영한다.\n-백업을 실시한다.\n-문제를 해결한다... 기반으로 40로 평가","execution":"execution는 [전산자료입력원]\n-데이터를 입력한다.\n-문서를 스캔한다.\n-파일을 정리한다.\n-데이터를 검증한다.\n-보고서를 작성한다.\n-시스템을 운영한다.\n-백업을 실시한다.\n-문제를 해결한다... 기반으로 70로 평가","people_facing":"people_facing는 [전산자료입력원]\n-데이터를 입력한다.\n-문서를 스캔한다.\n-파일을 정리한다.\n-데이터를 검증한다.\n-보고서를 작성한다.\n-시스템을 운영한다.\n-백업을 실시한다.\n-문제를 해결한다... 기반으로 50로 평가","degree_required":"degree_required는 [전산자료입력원]\n-데이터를 입력한다.\n-문서를 스캔한다.\n-파일을 정리한다.\n-데이터를 검증한다.\n-보고서를 작성한다.\n-시스템을 운영한다.\n-백업을 실시한다.\n-문제를 해결한다... 기반으로 none로 평가","license_required":"license_required는 [전산자료입력원]\n-데이터를 입력한다.\n-문서를 스캔한다.\n-파일을 정리한다.\n-데이터를 검증한다.\n-보고서를 작성한다.\n-시스템을 운영한다.\n-백업을 실시한다.\n-문제를 해결한다... 기반으로 none로 평가"}'
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
  '1765283409595695',
  '보건·의료관리자',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 50, 70,
  70, 30, 50, 50, 50, 60,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [보건관리자]\n-보건 정책을 수립한다.\n-프로그램을 기획한다.\n-예산을 관리한다.\n-직원을 감독한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-커뮤니티를 지원한다.\n-평가를 실시... 기반으로 50로 평가","growth":"growth는 [보건관리자]\n-보건 정책을 수립한다.\n-프로그램을 기획한다.\n-예산을 관리한다.\n-직원을 감독한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-커뮤니티를 지원한다.\n-평가를 실시... 기반으로 65로 평가","stability":"stability는 [보건관리자]\n-보건 정책을 수립한다.\n-프로그램을 기획한다.\n-예산을 관리한다.\n-직원을 감독한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-커뮤니티를 지원한다.\n-평가를 실시... 기반으로 50로 평가","income":"income는 [보건관리자]\n-보건 정책을 수립한다.\n-프로그램을 기획한다.\n-예산을 관리한다.\n-직원을 감독한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-커뮤니티를 지원한다.\n-평가를 실시... 기반으로 70로 평가","teamwork":"teamwork는 [보건관리자]\n-보건 정책을 수립한다.\n-프로그램을 기획한다.\n-예산을 관리한다.\n-직원을 감독한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-커뮤니티를 지원한다.\n-평가를 실시... 기반으로 70로 평가","solo_deep":"solo_deep는 [보건관리자]\n-보건 정책을 수립한다.\n-프로그램을 기획한다.\n-예산을 관리한다.\n-직원을 감독한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-커뮤니티를 지원한다.\n-평가를 실시... 기반으로 30로 평가","analytical":"analytical는 [보건관리자]\n-보건 정책을 수립한다.\n-프로그램을 기획한다.\n-예산을 관리한다.\n-직원을 감독한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-커뮤니티를 지원한다.\n-평가를 실시... 기반으로 50로 평가","creative":"creative는 [보건관리자]\n-보건 정책을 수립한다.\n-프로그램을 기획한다.\n-예산을 관리한다.\n-직원을 감독한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-커뮤니티를 지원한다.\n-평가를 실시... 기반으로 50로 평가","execution":"execution는 [보건관리자]\n-보건 정책을 수립한다.\n-프로그램을 기획한다.\n-예산을 관리한다.\n-직원을 감독한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-커뮤니티를 지원한다.\n-평가를 실시... 기반으로 50로 평가","people_facing":"people_facing는 [보건관리자]\n-보건 정책을 수립한다.\n-프로그램을 기획한다.\n-예산을 관리한다.\n-직원을 감독한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-커뮤니티를 지원한다.\n-평가를 실시... 기반으로 60로 평가","degree_required":"degree_required는 [보건관리자]\n-보건 정책을 수립한다.\n-프로그램을 기획한다.\n-예산을 관리한다.\n-직원을 감독한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-커뮤니티를 지원한다.\n-평가를 실시... 기반으로 none로 평가","license_required":"license_required는 [보건관리자]\n-보건 정책을 수립한다.\n-프로그램을 기획한다.\n-예산을 관리한다.\n-직원을 감독한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-커뮤니티를 지원한다.\n-평가를 실시... 기반으로 none로 평가"}'
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
  '1765283428493538',
  '보험인수심사원(언더라이터)',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 50, 50,
  70, 30, 50, 50, 50, 35,
  'regular', 'none', 'none', 'partial',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [보험인수심사원]\n-보험 신청을 심사한다.\n-리스크를 평가한다.\n-계약 조건을 결정한다.\n-가격을 설정한다.\n-승인을 내린다.\n-거부를 처리한다.\n-기록을 관리한다.\n-보고서를 작... 기반으로 50로 평가","growth":"growth는 [보험인수심사원]\n-보험 신청을 심사한다.\n-리스크를 평가한다.\n-계약 조건을 결정한다.\n-가격을 설정한다.\n-승인을 내린다.\n-거부를 처리한다.\n-기록을 관리한다.\n-보고서를 작... 기반으로 65로 평가","stability":"stability는 [보험인수심사원]\n-보험 신청을 심사한다.\n-리스크를 평가한다.\n-계약 조건을 결정한다.\n-가격을 설정한다.\n-승인을 내린다.\n-거부를 처리한다.\n-기록을 관리한다.\n-보고서를 작... 기반으로 50로 평가","income":"income는 [보험인수심사원]\n-보험 신청을 심사한다.\n-리스크를 평가한다.\n-계약 조건을 결정한다.\n-가격을 설정한다.\n-승인을 내린다.\n-거부를 처리한다.\n-기록을 관리한다.\n-보고서를 작... 기반으로 50로 평가","teamwork":"teamwork는 [보험인수심사원]\n-보험 신청을 심사한다.\n-리스크를 평가한다.\n-계약 조건을 결정한다.\n-가격을 설정한다.\n-승인을 내린다.\n-거부를 처리한다.\n-기록을 관리한다.\n-보고서를 작... 기반으로 70로 평가","solo_deep":"solo_deep는 [보험인수심사원]\n-보험 신청을 심사한다.\n-리스크를 평가한다.\n-계약 조건을 결정한다.\n-가격을 설정한다.\n-승인을 내린다.\n-거부를 처리한다.\n-기록을 관리한다.\n-보고서를 작... 기반으로 30로 평가","analytical":"analytical는 [보험인수심사원]\n-보험 신청을 심사한다.\n-리스크를 평가한다.\n-계약 조건을 결정한다.\n-가격을 설정한다.\n-승인을 내린다.\n-거부를 처리한다.\n-기록을 관리한다.\n-보고서를 작... 기반으로 50로 평가","creative":"creative는 [보험인수심사원]\n-보험 신청을 심사한다.\n-리스크를 평가한다.\n-계약 조건을 결정한다.\n-가격을 설정한다.\n-승인을 내린다.\n-거부를 처리한다.\n-기록을 관리한다.\n-보고서를 작... 기반으로 50로 평가","execution":"execution는 [보험인수심사원]\n-보험 신청을 심사한다.\n-리스크를 평가한다.\n-계약 조건을 결정한다.\n-가격을 설정한다.\n-승인을 내린다.\n-거부를 처리한다.\n-기록을 관리한다.\n-보고서를 작... 기반으로 50로 평가","people_facing":"people_facing는 [보험인수심사원]\n-보험 신청을 심사한다.\n-리스크를 평가한다.\n-계약 조건을 결정한다.\n-가격을 설정한다.\n-승인을 내린다.\n-거부를 처리한다.\n-기록을 관리한다.\n-보고서를 작... 기반으로 35로 평가","degree_required":"degree_required는 [보험인수심사원]\n-보험 신청을 심사한다.\n-리스크를 평가한다.\n-계약 조건을 결정한다.\n-가격을 설정한다.\n-승인을 내린다.\n-거부를 처리한다.\n-기록을 관리한다.\n-보고서를 작... 기반으로 none로 평가","license_required":"license_required는 [보험인수심사원]\n-보험 신청을 심사한다.\n-리스크를 평가한다.\n-계약 조건을 결정한다.\n-가격을 설정한다.\n-승인을 내린다.\n-거부를 처리한다.\n-기록을 관리한다.\n-보고서를 작... 기반으로 none로 평가"}'
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
  '1765283476124646',
  '수의사보조원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 60, 50, 70,
  50, 50, 40, 40, 70, 75,
  'regular', 'none', 'none', 'none',
  'phd', 'required', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [수의사보조원]\n-동물을 진정시킨다.\n-기구를 준비한다.\n-수의사를 지원한다.\n-동물을 관리한다.\n-청결을 유지한다.\n-기록을 관리한다.\n-고객을 응대한다.\n-약을 준비한다.\n-교... 기반으로 50로 평가","growth":"growth는 [수의사보조원]\n-동물을 진정시킨다.\n-기구를 준비한다.\n-수의사를 지원한다.\n-동물을 관리한다.\n-청결을 유지한다.\n-기록을 관리한다.\n-고객을 응대한다.\n-약을 준비한다.\n-교... 기반으로 60로 평가","stability":"stability는 [수의사보조원]\n-동물을 진정시킨다.\n-기구를 준비한다.\n-수의사를 지원한다.\n-동물을 관리한다.\n-청결을 유지한다.\n-기록을 관리한다.\n-고객을 응대한다.\n-약을 준비한다.\n-교... 기반으로 50로 평가","income":"income는 [수의사보조원]\n-동물을 진정시킨다.\n-기구를 준비한다.\n-수의사를 지원한다.\n-동물을 관리한다.\n-청결을 유지한다.\n-기록을 관리한다.\n-고객을 응대한다.\n-약을 준비한다.\n-교... 기반으로 70로 평가","teamwork":"teamwork는 [수의사보조원]\n-동물을 진정시킨다.\n-기구를 준비한다.\n-수의사를 지원한다.\n-동물을 관리한다.\n-청결을 유지한다.\n-기록을 관리한다.\n-고객을 응대한다.\n-약을 준비한다.\n-교... 기반으로 50로 평가","solo_deep":"solo_deep는 [수의사보조원]\n-동물을 진정시킨다.\n-기구를 준비한다.\n-수의사를 지원한다.\n-동물을 관리한다.\n-청결을 유지한다.\n-기록을 관리한다.\n-고객을 응대한다.\n-약을 준비한다.\n-교... 기반으로 50로 평가","analytical":"analytical는 [수의사보조원]\n-동물을 진정시킨다.\n-기구를 준비한다.\n-수의사를 지원한다.\n-동물을 관리한다.\n-청결을 유지한다.\n-기록을 관리한다.\n-고객을 응대한다.\n-약을 준비한다.\n-교... 기반으로 40로 평가","creative":"creative는 [수의사보조원]\n-동물을 진정시킨다.\n-기구를 준비한다.\n-수의사를 지원한다.\n-동물을 관리한다.\n-청결을 유지한다.\n-기록을 관리한다.\n-고객을 응대한다.\n-약을 준비한다.\n-교... 기반으로 40로 평가","execution":"execution는 [수의사보조원]\n-동물을 진정시킨다.\n-기구를 준비한다.\n-수의사를 지원한다.\n-동물을 관리한다.\n-청결을 유지한다.\n-기록을 관리한다.\n-고객을 응대한다.\n-약을 준비한다.\n-교... 기반으로 70로 평가","people_facing":"people_facing는 [수의사보조원]\n-동물을 진정시킨다.\n-기구를 준비한다.\n-수의사를 지원한다.\n-동물을 관리한다.\n-청결을 유지한다.\n-기록을 관리한다.\n-고객을 응대한다.\n-약을 준비한다.\n-교... 기반으로 75로 평가","degree_required":"degree_required는 [수의사보조원]\n-동물을 진정시킨다.\n-기구를 준비한다.\n-수의사를 지원한다.\n-동물을 관리한다.\n-청결을 유지한다.\n-기록을 관리한다.\n-고객을 응대한다.\n-약을 준비한다.\n-교... 기반으로 phd로 평가","license_required":"license_required는 [수의사보조원]\n-동물을 진정시킨다.\n-기구를 준비한다.\n-수의사를 지원한다.\n-동물을 관리한다.\n-청결을 유지한다.\n-기록을 관리한다.\n-고객을 응대한다.\n-약을 준비한다.\n-교... 기반으로 required로 평가"}'
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
  '1765283411845348',
  '여행·호텔관리자',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 50, 50,
  50, 50, 30, 60, 60, 75,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [여행관리자]\n-여행 상품을 기획한다.\n-예약을 관리한다.\n-가이드를 감독한다.\n-고객을 지원한다.\n-예산을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-마케팅을 실시한다... 기반으로 50로 평가","growth":"growth는 [여행관리자]\n-여행 상품을 기획한다.\n-예약을 관리한다.\n-가이드를 감독한다.\n-고객을 지원한다.\n-예산을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-마케팅을 실시한다... 기반으로 65로 평가","stability":"stability는 [여행관리자]\n-여행 상품을 기획한다.\n-예약을 관리한다.\n-가이드를 감독한다.\n-고객을 지원한다.\n-예산을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-마케팅을 실시한다... 기반으로 50로 평가","income":"income는 [여행관리자]\n-여행 상품을 기획한다.\n-예약을 관리한다.\n-가이드를 감독한다.\n-고객을 지원한다.\n-예산을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-마케팅을 실시한다... 기반으로 50로 평가","teamwork":"teamwork는 [여행관리자]\n-여행 상품을 기획한다.\n-예약을 관리한다.\n-가이드를 감독한다.\n-고객을 지원한다.\n-예산을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-마케팅을 실시한다... 기반으로 50로 평가","solo_deep":"solo_deep는 [여행관리자]\n-여행 상품을 기획한다.\n-예약을 관리한다.\n-가이드를 감독한다.\n-고객을 지원한다.\n-예산을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-마케팅을 실시한다... 기반으로 50로 평가","analytical":"analytical는 [여행관리자]\n-여행 상품을 기획한다.\n-예약을 관리한다.\n-가이드를 감독한다.\n-고객을 지원한다.\n-예산을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-마케팅을 실시한다... 기반으로 30로 평가","creative":"creative는 [여행관리자]\n-여행 상품을 기획한다.\n-예약을 관리한다.\n-가이드를 감독한다.\n-고객을 지원한다.\n-예산을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-마케팅을 실시한다... 기반으로 60로 평가","execution":"execution는 [여행관리자]\n-여행 상품을 기획한다.\n-예약을 관리한다.\n-가이드를 감독한다.\n-고객을 지원한다.\n-예산을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-마케팅을 실시한다... 기반으로 60로 평가","people_facing":"people_facing는 [여행관리자]\n-여행 상품을 기획한다.\n-예약을 관리한다.\n-가이드를 감독한다.\n-고객을 지원한다.\n-예산을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-마케팅을 실시한다... 기반으로 75로 평가","degree_required":"degree_required는 [여행관리자]\n-여행 상품을 기획한다.\n-예약을 관리한다.\n-가이드를 감독한다.\n-고객을 지원한다.\n-예산을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-마케팅을 실시한다... 기반으로 none로 평가","license_required":"license_required는 [여행관리자]\n-여행 상품을 기획한다.\n-예약을 관리한다.\n-가이드를 감독한다.\n-고객을 지원한다.\n-예산을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-마케팅을 실시한다... 기반으로 none로 평가"}'
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
  '1765283429152823',
  '증권사무원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 60, 70, 50,
  50, 50, 40, 40, 70, 75,
  'regular', 'none', 'none', 'partial',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [증권사무원]\n-거래를 처리한다.\n-서류를 검토한다.\n-고객을 응대한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-시스템을 운영한다.\n-문제를 해결한다.\n-교... 기반으로 50로 평가","growth":"growth는 [증권사무원]\n-거래를 처리한다.\n-서류를 검토한다.\n-고객을 응대한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-시스템을 운영한다.\n-문제를 해결한다.\n-교... 기반으로 60로 평가","stability":"stability는 [증권사무원]\n-거래를 처리한다.\n-서류를 검토한다.\n-고객을 응대한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-시스템을 운영한다.\n-문제를 해결한다.\n-교... 기반으로 70로 평가","income":"income는 [증권사무원]\n-거래를 처리한다.\n-서류를 검토한다.\n-고객을 응대한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-시스템을 운영한다.\n-문제를 해결한다.\n-교... 기반으로 50로 평가","teamwork":"teamwork는 [증권사무원]\n-거래를 처리한다.\n-서류를 검토한다.\n-고객을 응대한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-시스템을 운영한다.\n-문제를 해결한다.\n-교... 기반으로 50로 평가","solo_deep":"solo_deep는 [증권사무원]\n-거래를 처리한다.\n-서류를 검토한다.\n-고객을 응대한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-시스템을 운영한다.\n-문제를 해결한다.\n-교... 기반으로 50로 평가","analytical":"analytical는 [증권사무원]\n-거래를 처리한다.\n-서류를 검토한다.\n-고객을 응대한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-시스템을 운영한다.\n-문제를 해결한다.\n-교... 기반으로 40로 평가","creative":"creative는 [증권사무원]\n-거래를 처리한다.\n-서류를 검토한다.\n-고객을 응대한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-시스템을 운영한다.\n-문제를 해결한다.\n-교... 기반으로 40로 평가","execution":"execution는 [증권사무원]\n-거래를 처리한다.\n-서류를 검토한다.\n-고객을 응대한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-시스템을 운영한다.\n-문제를 해결한다.\n-교... 기반으로 70로 평가","people_facing":"people_facing는 [증권사무원]\n-거래를 처리한다.\n-서류를 검토한다.\n-고객을 응대한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-시스템을 운영한다.\n-문제를 해결한다.\n-교... 기반으로 75로 평가","degree_required":"degree_required는 [증권사무원]\n-거래를 처리한다.\n-서류를 검토한다.\n-고객을 응대한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-시스템을 운영한다.\n-문제를 해결한다.\n-교... 기반으로 none로 평가","license_required":"license_required는 [증권사무원]\n-거래를 처리한다.\n-서류를 검토한다.\n-고객을 응대한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-시스템을 운영한다.\n-문제를 해결한다.\n-교... 기반으로 none로 평가"}'
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
  '176528342030072',
  '수상운송사무원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 70, 50,
  70, 30, 40, 40, 70, 75,
  'regular', 'none', 'none', 'partial',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [수상운송사무원]\n-선박 일정을 관리한다.\n-화물 예약을 처리한다.\n-서류를 준비한다.\n-고객을 응대한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-문제를 해... 기반으로 50로 평가","growth":"growth는 [수상운송사무원]\n-선박 일정을 관리한다.\n-화물 예약을 처리한다.\n-서류를 준비한다.\n-고객을 응대한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-문제를 해... 기반으로 50로 평가","stability":"stability는 [수상운송사무원]\n-선박 일정을 관리한다.\n-화물 예약을 처리한다.\n-서류를 준비한다.\n-고객을 응대한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-문제를 해... 기반으로 70로 평가","income":"income는 [수상운송사무원]\n-선박 일정을 관리한다.\n-화물 예약을 처리한다.\n-서류를 준비한다.\n-고객을 응대한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-문제를 해... 기반으로 50로 평가","teamwork":"teamwork는 [수상운송사무원]\n-선박 일정을 관리한다.\n-화물 예약을 처리한다.\n-서류를 준비한다.\n-고객을 응대한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-문제를 해... 기반으로 70로 평가","solo_deep":"solo_deep는 [수상운송사무원]\n-선박 일정을 관리한다.\n-화물 예약을 처리한다.\n-서류를 준비한다.\n-고객을 응대한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-문제를 해... 기반으로 30로 평가","analytical":"analytical는 [수상운송사무원]\n-선박 일정을 관리한다.\n-화물 예약을 처리한다.\n-서류를 준비한다.\n-고객을 응대한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-문제를 해... 기반으로 40로 평가","creative":"creative는 [수상운송사무원]\n-선박 일정을 관리한다.\n-화물 예약을 처리한다.\n-서류를 준비한다.\n-고객을 응대한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-문제를 해... 기반으로 40로 평가","execution":"execution는 [수상운송사무원]\n-선박 일정을 관리한다.\n-화물 예약을 처리한다.\n-서류를 준비한다.\n-고객을 응대한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-문제를 해... 기반으로 70로 평가","people_facing":"people_facing는 [수상운송사무원]\n-선박 일정을 관리한다.\n-화물 예약을 처리한다.\n-서류를 준비한다.\n-고객을 응대한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-문제를 해... 기반으로 75로 평가","degree_required":"degree_required는 [수상운송사무원]\n-선박 일정을 관리한다.\n-화물 예약을 처리한다.\n-서류를 준비한다.\n-고객을 응대한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-문제를 해... 기반으로 none로 평가","license_required":"license_required는 [수상운송사무원]\n-선박 일정을 관리한다.\n-화물 예약을 처리한다.\n-서류를 준비한다.\n-고객을 응대한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-문제를 해... 기반으로 none로 평가"}'
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
  '176528341097915',
  '연구관리자',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 50, 70,
  70, 30, 50, 50, 50, 35,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [연구관리자]\n-연구 프로젝트를 기획한다.\n-연구팀을 관리한다.\n-예산을 감독한다.\n-진전을 모니터링한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-성과를 평가한다.\n-자원을 배... 기반으로 50로 평가","growth":"growth는 [연구관리자]\n-연구 프로젝트를 기획한다.\n-연구팀을 관리한다.\n-예산을 감독한다.\n-진전을 모니터링한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-성과를 평가한다.\n-자원을 배... 기반으로 65로 평가","stability":"stability는 [연구관리자]\n-연구 프로젝트를 기획한다.\n-연구팀을 관리한다.\n-예산을 감독한다.\n-진전을 모니터링한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-성과를 평가한다.\n-자원을 배... 기반으로 50로 평가","income":"income는 [연구관리자]\n-연구 프로젝트를 기획한다.\n-연구팀을 관리한다.\n-예산을 감독한다.\n-진전을 모니터링한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-성과를 평가한다.\n-자원을 배... 기반으로 70로 평가","teamwork":"teamwork는 [연구관리자]\n-연구 프로젝트를 기획한다.\n-연구팀을 관리한다.\n-예산을 감독한다.\n-진전을 모니터링한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-성과를 평가한다.\n-자원을 배... 기반으로 70로 평가","solo_deep":"solo_deep는 [연구관리자]\n-연구 프로젝트를 기획한다.\n-연구팀을 관리한다.\n-예산을 감독한다.\n-진전을 모니터링한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-성과를 평가한다.\n-자원을 배... 기반으로 30로 평가","analytical":"analytical는 [연구관리자]\n-연구 프로젝트를 기획한다.\n-연구팀을 관리한다.\n-예산을 감독한다.\n-진전을 모니터링한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-성과를 평가한다.\n-자원을 배... 기반으로 50로 평가","creative":"creative는 [연구관리자]\n-연구 프로젝트를 기획한다.\n-연구팀을 관리한다.\n-예산을 감독한다.\n-진전을 모니터링한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-성과를 평가한다.\n-자원을 배... 기반으로 50로 평가","execution":"execution는 [연구관리자]\n-연구 프로젝트를 기획한다.\n-연구팀을 관리한다.\n-예산을 감독한다.\n-진전을 모니터링한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-성과를 평가한다.\n-자원을 배... 기반으로 50로 평가","people_facing":"people_facing는 [연구관리자]\n-연구 프로젝트를 기획한다.\n-연구팀을 관리한다.\n-예산을 감독한다.\n-진전을 모니터링한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-성과를 평가한다.\n-자원을 배... 기반으로 35로 평가","degree_required":"degree_required는 [연구관리자]\n-연구 프로젝트를 기획한다.\n-연구팀을 관리한다.\n-예산을 감독한다.\n-진전을 모니터링한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-성과를 평가한다.\n-자원을 배... 기반으로 none로 평가","license_required":"license_required는 [연구관리자]\n-연구 프로젝트를 기획한다.\n-연구팀을 관리한다.\n-예산을 감독한다.\n-진전을 모니터링한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-성과를 평가한다.\n-자원을 배... 기반으로 none로 평가"}'
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
  '1765283472411372',
  '연극 및 뮤지컬배우',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 40,
  70, 30, 70, 40, 40, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [연극배우]\n-대본을 분석한다.\n-연기를 준비한다.\n-리허설에 참여한다.\n-공연을 한다.\n-감정을 표현한다.\n-팀과 협력한다.\n-기술을 연마한다.\n-프로모션에 참여한다.\n\n[뮤지컬... 기반으로 50로 평가","growth":"growth는 [연극배우]\n-대본을 분석한다.\n-연기를 준비한다.\n-리허설에 참여한다.\n-공연을 한다.\n-감정을 표현한다.\n-팀과 협력한다.\n-기술을 연마한다.\n-프로모션에 참여한다.\n\n[뮤지컬... 기반으로 50로 평가","stability":"stability는 [연극배우]\n-대본을 분석한다.\n-연기를 준비한다.\n-리허설에 참여한다.\n-공연을 한다.\n-감정을 표현한다.\n-팀과 협력한다.\n-기술을 연마한다.\n-프로모션에 참여한다.\n\n[뮤지컬... 기반으로 50로 평가","income":"income는 [연극배우]\n-대본을 분석한다.\n-연기를 준비한다.\n-리허설에 참여한다.\n-공연을 한다.\n-감정을 표현한다.\n-팀과 협력한다.\n-기술을 연마한다.\n-프로모션에 참여한다.\n\n[뮤지컬... 기반으로 40로 평가","teamwork":"teamwork는 [연극배우]\n-대본을 분석한다.\n-연기를 준비한다.\n-리허설에 참여한다.\n-공연을 한다.\n-감정을 표현한다.\n-팀과 협력한다.\n-기술을 연마한다.\n-프로모션에 참여한다.\n\n[뮤지컬... 기반으로 70로 평가","solo_deep":"solo_deep는 [연극배우]\n-대본을 분석한다.\n-연기를 준비한다.\n-리허설에 참여한다.\n-공연을 한다.\n-감정을 표현한다.\n-팀과 협력한다.\n-기술을 연마한다.\n-프로모션에 참여한다.\n\n[뮤지컬... 기반으로 30로 평가","analytical":"analytical는 [연극배우]\n-대본을 분석한다.\n-연기를 준비한다.\n-리허설에 참여한다.\n-공연을 한다.\n-감정을 표현한다.\n-팀과 협력한다.\n-기술을 연마한다.\n-프로모션에 참여한다.\n\n[뮤지컬... 기반으로 70로 평가","creative":"creative는 [연극배우]\n-대본을 분석한다.\n-연기를 준비한다.\n-리허설에 참여한다.\n-공연을 한다.\n-감정을 표현한다.\n-팀과 협력한다.\n-기술을 연마한다.\n-프로모션에 참여한다.\n\n[뮤지컬... 기반으로 40로 평가","execution":"execution는 [연극배우]\n-대본을 분석한다.\n-연기를 준비한다.\n-리허설에 참여한다.\n-공연을 한다.\n-감정을 표현한다.\n-팀과 협력한다.\n-기술을 연마한다.\n-프로모션에 참여한다.\n\n[뮤지컬... 기반으로 40로 평가","people_facing":"people_facing는 [연극배우]\n-대본을 분석한다.\n-연기를 준비한다.\n-리허설에 참여한다.\n-공연을 한다.\n-감정을 표현한다.\n-팀과 협력한다.\n-기술을 연마한다.\n-프로모션에 참여한다.\n\n[뮤지컬... 기반으로 50로 평가","degree_required":"degree_required는 [연극배우]\n-대본을 분석한다.\n-연기를 준비한다.\n-리허설에 참여한다.\n-공연을 한다.\n-감정을 표현한다.\n-팀과 협력한다.\n-기술을 연마한다.\n-프로모션에 참여한다.\n\n[뮤지컬... 기반으로 none로 평가","license_required":"license_required는 [연극배우]\n-대본을 분석한다.\n-연기를 준비한다.\n-리허설에 참여한다.\n-공연을 한다.\n-감정을 표현한다.\n-팀과 협력한다.\n-기술을 연마한다.\n-프로모션에 참여한다.\n\n[뮤지컬... 기반으로 none로 평가"}'
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