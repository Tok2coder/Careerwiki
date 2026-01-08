-- Batch tagging SQL generated at 2026-01-06T08:32:16.391Z
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
  '1765284617313606',
  '국악금부악기제조원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 45, 70, 45,
  55, 45, 60, 65, 75, 35,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.84,
  '{"wlb":0.8,"growth":0.6,"stability":0.8,"income":0.6,"teamwork":0.6,"solo_deep":0.7,"analytical":0.7,"creative":0.8,"execution":0.8,"people_facing":0.5,"degree_required":0.95,"license_required":0.9}',
  '{"wlb":"실내 작업장 업무로 정규 근무","growth":"전통 악기 제조로 숙련도 향상 기회 있음","stability":"전통 악기 제조업으로 비교적 안정적","income":"숙련공으로 중간 수준 소득","teamwork":"작업장 협업으로 일부 협업","solo_deep":"금속 성형, 음 조절로 독립 작업 多","analytical":"금속 배합 비율, 음 조절로 분석 요구","creative":"악기 모양 성형, 음 조절로 창의성 높음","execution":"주조, 성형, 조립 실행 중심","people_facing":"내부 협업으로 대면 업무 적음","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 요구 없음"}'
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
  '1765284617571790',
  '금관악기제조원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 50, 70, 45,
  55, 45, 60, 60, 80, 35,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.85,
  '{"wlb":0.8,"growth":0.7,"stability":0.8,"income":0.6,"teamwork":0.6,"solo_deep":0.7,"analytical":0.7,"creative":0.8,"execution":0.9,"people_facing":0.5,"degree_required":0.95,"license_required":0.9}',
  '{"wlb":"실내 작업장 업무로 정규 근무","growth":"금관악기 제조로 숙련도 향상 기회 좋음","stability":"악기 제조업으로 비교적 안정적","income":"숙련공으로 중간 수준 소득","teamwork":"작업장 협업으로 일부 협업","solo_deep":"금속 가공, 조립으로 독립 작업 多","analytical":"금속 재료 선별, 음 조정으로 분석 요구","creative":"부품 성형, 조립 디자인으로 창의성 높음","execution":"절단, 압연, 조립 실행 중심","people_facing":"내부 협업으로 대면 업무 적음","degree_required":"중졸 정도 학력 요구","license_required":"특별 자격증 요구 없음"}'
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
  '1765284617862807',
  '기타넥가공원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 45, 70, 40,
  60, 40, 65, 55, 80, 35,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.86,
  '{"wlb":0.8,"growth":0.6,"stability":0.8,"income":0.6,"teamwork":0.7,"solo_deep":0.6,"analytical":0.8,"creative":0.7,"execution":0.9,"people_facing":0.5,"degree_required":0.95,"license_required":0.9}',
  '{"wlb":"실내 작업장 업무로 정규 근무","growth":"기타 넥 가공으로 숙련도 향상 기회 있음","stability":"악기 제조업으로 비교적 안정적","income":"목공 작업으로 중간 수준 소득","teamwork":"작업장 협업으로 협업 필요","solo_deep":"목재 가공, 측정으로 독립 작업","analytical":"목재 선별, 측정, 프레트 홈 가공으로 분석 중심","creative":"넥 디자인, 프레트 배치로 창의성 요구","execution":"절단, 연마, 조립 실행 중심","people_facing":"내부 협업으로 대면 업무 적음","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 요구 없음"}'
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
  '1765284618183222',
  '기타제작원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 50, 70, 45,
  60, 40, 70, 70, 75, 40,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.82,
  '{"wlb":0.8,"growth":0.7,"stability":0.8,"income":0.6,"teamwork":0.7,"solo_deep":0.6,"analytical":0.8,"creative":0.85,"execution":0.8,"people_facing":0.6,"degree_required":0.95,"license_required":0.9}',
  '{"wlb":"실내 작업장 업무로 정규 근무","growth":"기타 제작으로 숙련도 향상 기회 좋음","stability":"악기 제조업으로 비교적 안정적","income":"숙련공으로 중간 수준 소득","teamwork":"작업장 협업으로 협업 필요","solo_deep":"목재 가공, 조립으로 독립 작업","analytical":"목재 선별, 측정, 음 조율로 분석 중심","creative":"기타 디자인, 형태 성형으로 창의성 매우 높음","execution":"가공, 접착, 도장 실행 중심","people_facing":"내부 협업, 연주 점검으로 대면 업무 적음","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 요구 없음"}'
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
  '176528461846099',
  '리드절삭원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 40, 75, 40,
  60, 40, 60, 30, 85, 35,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.87,
  '{"wlb":0.8,"growth":0.6,"stability":0.85,"income":0.6,"teamwork":0.7,"solo_deep":0.6,"analytical":0.7,"creative":0.5,"execution":0.95,"people_facing":0.5,"degree_required":0.95,"license_required":0.9}',
  '{"wlb":"실내 작업장 업무로 정규 근무","growth":"리드 절삭으로 숙련도 향상 기회 있음","stability":"악기 제조업으로 안정적","income":"정밀 작업으로 중간 수준 소득","teamwork":"작업장 협업으로 협업 필요","solo_deep":"정밀 절삭, 측정으로 독립 작업","analytical":"두께 측정, 정밀도 확인으로 분석 요구","creative":"표준화된 작업으로 창의성 낮음","execution":"절삭, 측정 실행 중심","people_facing":"내부 협업으로 대면 업무 적음","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 요구 없음"}'
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
  '1765284618705534',
  '리드조정원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 50, 70, 45,
  55, 45, 75, 50, 80, 35,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.84,
  '{"wlb":0.8,"growth":0.7,"stability":0.8,"income":0.6,"teamwork":0.6,"solo_deep":0.7,"analytical":0.85,"creative":0.7,"execution":0.9,"people_facing":0.5,"degree_required":0.95,"license_required":0.9}',
  '{"wlb":"실내 작업장 업무로 정규 근무","growth":"리드 조정으로 숙련도 향상 기회 좋음","stability":"악기 제조업으로 비교적 안정적","income":"정밀 조정 작업으로 중상위 소득","teamwork":"작업장 협업으로 일부 협업","solo_deep":"정밀 조정, 연마로 독립 작업 多","analytical":"리드 위치 교정, 음 튜닝으로 분석 중심","creative":"음 조정 방법으로 창의성 요구","execution":"연마, 교정 실행 중심","people_facing":"내부 협업으로 대면 업무 적음","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 요구 없음"}'
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
  '1765284619006155',
  '리코더조립원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 40, 75, 40,
  65, 35, 55, 35, 80, 40,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'entry',
  0.86,
  '{"wlb":0.8,"growth":0.6,"stability":0.85,"income":0.6,"teamwork":0.8,"solo_deep":0.5,"analytical":0.7,"creative":0.5,"execution":0.9,"people_facing":0.6,"degree_required":0.95,"license_required":0.9}',
  '{"wlb":"실내 작업장 업무로 정규 근무","growth":"리코더 조립으로 숙련도 향상 기회 있음","stability":"악기 제조업으로 안정적","income":"조립 작업으로 중간 수준 소득","teamwork":"작업장 협업으로 협업 필요","solo_deep":"부품 조립, 음정 검사로 독립 작업","analytical":"부품 점검, 음정 검사로 분석 요구","creative":"표준화된 작업으로 창의성 낮음","execution":"조립, 검사, 포장 실행 중심","people_facing":"내부 협업으로 대면 업무 적음","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 요구 없음"}'
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
  '176528461937733',
  '목관악기제조원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 50, 70, 45,
  55, 45, 65, 65, 75, 35,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.83,
  '{"wlb":0.8,"growth":0.7,"stability":0.8,"income":0.6,"teamwork":0.6,"solo_deep":0.7,"analytical":0.8,"creative":0.8,"execution":0.8,"people_facing":0.5,"degree_required":0.95,"license_required":0.9}',
  '{"wlb":"실내 작업장 업무로 정규 근무","growth":"목관악기 제조로 숙련도 향상 기회 좋음","stability":"악기 제조업으로 비교적 안정적","income":"숙련공으로 중간 수준 소득","teamwork":"작업장 협업으로 일부 협업","solo_deep":"목재 가공, 조립으로 독립 작업 多","analytical":"재료 선별, 음정 조정으로 분석 요구","creative":"악기 디자인, 형태 성형으로 창의성 높음","execution":"절삭, 조립, 음정 조정 실행 중심","people_facing":"내부 협업으로 대면 업무 적음","degree_required":"중졸 정도 학력 요구","license_required":"특별 자격증 요구 없음"}'
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
  '17652846198145',
  '악기수리원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 50, 75, 45,
  55, 45, 70, 60, 80, 60,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.85,
  '{"wlb":0.8,"growth":0.7,"stability":0.85,"income":0.6,"teamwork":0.6,"solo_deep":0.7,"analytical":0.8,"creative":0.8,"execution":0.9,"people_facing":0.7,"degree_required":0.95,"license_required":0.9}',
  '{"wlb":"실내 작업장 업무로 정규 근무","growth":"악기 수리로 숙련도 향상 기회 좋음","stability":"악기 수리업으로 안정적","income":"전문 수리로 중상위 소득","teamwork":"작업장 협업으로 일부 협업","solo_deep":"악기 진단, 수리로 독립 작업 多","analytical":"파손 부위 진단, 소리 점검으로 분석 중심","creative":"수리 방법 개발로 창의성 높음","execution":"분해, 교체, 조율 실행 중심","people_facing":"고객 상담, 악기 인도로 대면 업무","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 요구 없음"}'
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
  '1765284620232786',
  '악기품질시험원',
  'WORK24_DJOB',
  'tagger-v1.0.0',
  'tagged',
  70, 55, 75, 50,
  65, 35, 80, 40, 75, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.82,
  '{"wlb":0.8,"growth":0.7,"stability":0.85,"income":0.7,"teamwork":0.8,"solo_deep":0.5,"analytical":0.9,"creative":0.6,"execution":0.8,"people_facing":0.7,"degree_required":0.95,"license_required":0.9}',
  '{"wlb":"실내 실험실 업무로 정규 근무","growth":"악기 품질 시험으로 전문성 향상 기회 매우 좋음","stability":"악기 제조업으로 안정적","income":"전문 시험으로 상위 소득","teamwork":"시험 결과 공유로 협업 필요","solo_deep":"시험기 조작, 데이터 분석으로 독립 작업","analytical":"시험 조건 설정, 결과 분석으로 분석 중심","creative":"시험 방법 개발로 일부 창의성","execution":"시험 실시, 보고서 작성 실행 중심","people_facing":"팀 협의, 보고로 대면 업무 적음","degree_required":"고졸 정도 학력 요구","license_required":"특별 자격증 요구 없음"}'
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