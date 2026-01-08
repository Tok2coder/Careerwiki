-- Batch tagging SQL generated at 2026-01-06T07:12:22.852Z
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
  '1765283455943446',
  '3D프린팅모델러',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  50, 50, 30, 60, 60, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [3d프린팅모델러]\n-3d 모델을 디자인한다.\n-소프트웨어를 사용한다.\n-프린팅을 준비한다.\n-품질을 검사한다.\n-수정을 실시한다.\n-재료를 선택한다.\n-기술을 연마한다.\n-프로젝... 기반으로 50로 평가","growth":"growth는 [3d프린팅모델러]\n-3d 모델을 디자인한다.\n-소프트웨어를 사용한다.\n-프린팅을 준비한다.\n-품질을 검사한다.\n-수정을 실시한다.\n-재료를 선택한다.\n-기술을 연마한다.\n-프로젝... 기반으로 50로 평가","stability":"stability는 [3d프린팅모델러]\n-3d 모델을 디자인한다.\n-소프트웨어를 사용한다.\n-프린팅을 준비한다.\n-품질을 검사한다.\n-수정을 실시한다.\n-재료를 선택한다.\n-기술을 연마한다.\n-프로젝... 기반으로 50로 평가","income":"income는 [3d프린팅모델러]\n-3d 모델을 디자인한다.\n-소프트웨어를 사용한다.\n-프린팅을 준비한다.\n-품질을 검사한다.\n-수정을 실시한다.\n-재료를 선택한다.\n-기술을 연마한다.\n-프로젝... 기반으로 50로 평가","teamwork":"teamwork는 [3d프린팅모델러]\n-3d 모델을 디자인한다.\n-소프트웨어를 사용한다.\n-프린팅을 준비한다.\n-품질을 검사한다.\n-수정을 실시한다.\n-재료를 선택한다.\n-기술을 연마한다.\n-프로젝... 기반으로 50로 평가","solo_deep":"solo_deep는 [3d프린팅모델러]\n-3d 모델을 디자인한다.\n-소프트웨어를 사용한다.\n-프린팅을 준비한다.\n-품질을 검사한다.\n-수정을 실시한다.\n-재료를 선택한다.\n-기술을 연마한다.\n-프로젝... 기반으로 50로 평가","analytical":"analytical는 [3d프린팅모델러]\n-3d 모델을 디자인한다.\n-소프트웨어를 사용한다.\n-프린팅을 준비한다.\n-품질을 검사한다.\n-수정을 실시한다.\n-재료를 선택한다.\n-기술을 연마한다.\n-프로젝... 기반으로 30로 평가","creative":"creative는 [3d프린팅모델러]\n-3d 모델을 디자인한다.\n-소프트웨어를 사용한다.\n-프린팅을 준비한다.\n-품질을 검사한다.\n-수정을 실시한다.\n-재료를 선택한다.\n-기술을 연마한다.\n-프로젝... 기반으로 60로 평가","execution":"execution는 [3d프린팅모델러]\n-3d 모델을 디자인한다.\n-소프트웨어를 사용한다.\n-프린팅을 준비한다.\n-품질을 검사한다.\n-수정을 실시한다.\n-재료를 선택한다.\n-기술을 연마한다.\n-프로젝... 기반으로 60로 평가","people_facing":"people_facing는 [3d프린팅모델러]\n-3d 모델을 디자인한다.\n-소프트웨어를 사용한다.\n-프린팅을 준비한다.\n-품질을 검사한다.\n-수정을 실시한다.\n-재료를 선택한다.\n-기술을 연마한다.\n-프로젝... 기반으로 50로 평가","degree_required":"degree_required는 [3d프린팅모델러]\n-3d 모델을 디자인한다.\n-소프트웨어를 사용한다.\n-프린팅을 준비한다.\n-품질을 검사한다.\n-수정을 실시한다.\n-재료를 선택한다.\n-기술을 연마한다.\n-프로젝... 기반으로 none로 평가","license_required":"license_required는 [3d프린팅모델러]\n-3d 모델을 디자인한다.\n-소프트웨어를 사용한다.\n-프린팅을 준비한다.\n-품질을 검사한다.\n-수정을 실시한다.\n-재료를 선택한다.\n-기술을 연마한다.\n-프로젝... 기반으로 none로 평가"}'
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
  '1765283419246952',
  '자재·구매사무원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  70, 30, 40, 40, 70, 50,
  'regular', 'none', 'none', 'partial',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [자재사무원]\n-자재를 관리한다.\n-재고를 모니터링한다.\n-주문을 처리한다.\n-공급업체와 협력한다.\n-기록을 유지한다.\n-보고서를 작성한다.\n-문제를 해결한다.\n\n[구매사무원]\n-... 기반으로 50로 평가","growth":"growth는 [자재사무원]\n-자재를 관리한다.\n-재고를 모니터링한다.\n-주문을 처리한다.\n-공급업체와 협력한다.\n-기록을 유지한다.\n-보고서를 작성한다.\n-문제를 해결한다.\n\n[구매사무원]\n-... 기반으로 50로 평가","stability":"stability는 [자재사무원]\n-자재를 관리한다.\n-재고를 모니터링한다.\n-주문을 처리한다.\n-공급업체와 협력한다.\n-기록을 유지한다.\n-보고서를 작성한다.\n-문제를 해결한다.\n\n[구매사무원]\n-... 기반으로 50로 평가","income":"income는 [자재사무원]\n-자재를 관리한다.\n-재고를 모니터링한다.\n-주문을 처리한다.\n-공급업체와 협력한다.\n-기록을 유지한다.\n-보고서를 작성한다.\n-문제를 해결한다.\n\n[구매사무원]\n-... 기반으로 50로 평가","teamwork":"teamwork는 [자재사무원]\n-자재를 관리한다.\n-재고를 모니터링한다.\n-주문을 처리한다.\n-공급업체와 협력한다.\n-기록을 유지한다.\n-보고서를 작성한다.\n-문제를 해결한다.\n\n[구매사무원]\n-... 기반으로 70로 평가","solo_deep":"solo_deep는 [자재사무원]\n-자재를 관리한다.\n-재고를 모니터링한다.\n-주문을 처리한다.\n-공급업체와 협력한다.\n-기록을 유지한다.\n-보고서를 작성한다.\n-문제를 해결한다.\n\n[구매사무원]\n-... 기반으로 30로 평가","analytical":"analytical는 [자재사무원]\n-자재를 관리한다.\n-재고를 모니터링한다.\n-주문을 처리한다.\n-공급업체와 협력한다.\n-기록을 유지한다.\n-보고서를 작성한다.\n-문제를 해결한다.\n\n[구매사무원]\n-... 기반으로 40로 평가","creative":"creative는 [자재사무원]\n-자재를 관리한다.\n-재고를 모니터링한다.\n-주문을 처리한다.\n-공급업체와 협력한다.\n-기록을 유지한다.\n-보고서를 작성한다.\n-문제를 해결한다.\n\n[구매사무원]\n-... 기반으로 40로 평가","execution":"execution는 [자재사무원]\n-자재를 관리한다.\n-재고를 모니터링한다.\n-주문을 처리한다.\n-공급업체와 협력한다.\n-기록을 유지한다.\n-보고서를 작성한다.\n-문제를 해결한다.\n\n[구매사무원]\n-... 기반으로 70로 평가","people_facing":"people_facing는 [자재사무원]\n-자재를 관리한다.\n-재고를 모니터링한다.\n-주문을 처리한다.\n-공급업체와 협력한다.\n-기록을 유지한다.\n-보고서를 작성한다.\n-문제를 해결한다.\n\n[구매사무원]\n-... 기반으로 50로 평가","degree_required":"degree_required는 [자재사무원]\n-자재를 관리한다.\n-재고를 모니터링한다.\n-주문을 처리한다.\n-공급업체와 협력한다.\n-기록을 유지한다.\n-보고서를 작성한다.\n-문제를 해결한다.\n\n[구매사무원]\n-... 기반으로 none로 평가","license_required":"license_required는 [자재사무원]\n-자재를 관리한다.\n-재고를 모니터링한다.\n-주문을 처리한다.\n-공급업체와 협력한다.\n-기록을 유지한다.\n-보고서를 작성한다.\n-문제를 해결한다.\n\n[구매사무원]\n-... 기반으로 none로 평가"}'
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
  '1765283418922102',
  '경리사무원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 70, 50,
  50, 50, 60, 30, 60, 50,
  'regular', 'none', 'none', 'partial',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [경리사무원]\n-회계를 처리한다.\n-거래를 기록한다.\n-청구서를 작성한다.\n-급여를 계산한다.\n-세금을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-기록을 유지한다.\n-감... 기반으로 50로 평가","growth":"growth는 [경리사무원]\n-회계를 처리한다.\n-거래를 기록한다.\n-청구서를 작성한다.\n-급여를 계산한다.\n-세금을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-기록을 유지한다.\n-감... 기반으로 50로 평가","stability":"stability는 [경리사무원]\n-회계를 처리한다.\n-거래를 기록한다.\n-청구서를 작성한다.\n-급여를 계산한다.\n-세금을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-기록을 유지한다.\n-감... 기반으로 70로 평가","income":"income는 [경리사무원]\n-회계를 처리한다.\n-거래를 기록한다.\n-청구서를 작성한다.\n-급여를 계산한다.\n-세금을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-기록을 유지한다.\n-감... 기반으로 50로 평가","teamwork":"teamwork는 [경리사무원]\n-회계를 처리한다.\n-거래를 기록한다.\n-청구서를 작성한다.\n-급여를 계산한다.\n-세금을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-기록을 유지한다.\n-감... 기반으로 50로 평가","solo_deep":"solo_deep는 [경리사무원]\n-회계를 처리한다.\n-거래를 기록한다.\n-청구서를 작성한다.\n-급여를 계산한다.\n-세금을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-기록을 유지한다.\n-감... 기반으로 50로 평가","analytical":"analytical는 [경리사무원]\n-회계를 처리한다.\n-거래를 기록한다.\n-청구서를 작성한다.\n-급여를 계산한다.\n-세금을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-기록을 유지한다.\n-감... 기반으로 60로 평가","creative":"creative는 [경리사무원]\n-회계를 처리한다.\n-거래를 기록한다.\n-청구서를 작성한다.\n-급여를 계산한다.\n-세금을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-기록을 유지한다.\n-감... 기반으로 30로 평가","execution":"execution는 [경리사무원]\n-회계를 처리한다.\n-거래를 기록한다.\n-청구서를 작성한다.\n-급여를 계산한다.\n-세금을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-기록을 유지한다.\n-감... 기반으로 60로 평가","people_facing":"people_facing는 [경리사무원]\n-회계를 처리한다.\n-거래를 기록한다.\n-청구서를 작성한다.\n-급여를 계산한다.\n-세금을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-기록을 유지한다.\n-감... 기반으로 50로 평가","degree_required":"degree_required는 [경리사무원]\n-회계를 처리한다.\n-거래를 기록한다.\n-청구서를 작성한다.\n-급여를 계산한다.\n-세금을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-기록을 유지한다.\n-감... 기반으로 none로 평가","license_required":"license_required는 [경리사무원]\n-회계를 처리한다.\n-거래를 기록한다.\n-청구서를 작성한다.\n-급여를 계산한다.\n-세금을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-기록을 유지한다.\n-감... 기반으로 none로 평가"}'
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
  '1765283473827463',
  '공연·영화 및 음반기획자',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 30, 40,
  70, 30, 30, 60, 60, 60,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [공연기획자]\n-공연을 기획한다.\n-예산을 관리한다.\n-아티스트를 섭외한다.\n-장소를 예약한다.\n-마케팅을 실시한다.\n-프로모션을 진행한다.\n-티켓을 판매한다.\n-보고서를 작성한다... 기반으로 50로 평가","growth":"growth는 [공연기획자]\n-공연을 기획한다.\n-예산을 관리한다.\n-아티스트를 섭외한다.\n-장소를 예약한다.\n-마케팅을 실시한다.\n-프로모션을 진행한다.\n-티켓을 판매한다.\n-보고서를 작성한다... 기반으로 65로 평가","stability":"stability는 [공연기획자]\n-공연을 기획한다.\n-예산을 관리한다.\n-아티스트를 섭외한다.\n-장소를 예약한다.\n-마케팅을 실시한다.\n-프로모션을 진행한다.\n-티켓을 판매한다.\n-보고서를 작성한다... 기반으로 30로 평가","income":"income는 [공연기획자]\n-공연을 기획한다.\n-예산을 관리한다.\n-아티스트를 섭외한다.\n-장소를 예약한다.\n-마케팅을 실시한다.\n-프로모션을 진행한다.\n-티켓을 판매한다.\n-보고서를 작성한다... 기반으로 40로 평가","teamwork":"teamwork는 [공연기획자]\n-공연을 기획한다.\n-예산을 관리한다.\n-아티스트를 섭외한다.\n-장소를 예약한다.\n-마케팅을 실시한다.\n-프로모션을 진행한다.\n-티켓을 판매한다.\n-보고서를 작성한다... 기반으로 70로 평가","solo_deep":"solo_deep는 [공연기획자]\n-공연을 기획한다.\n-예산을 관리한다.\n-아티스트를 섭외한다.\n-장소를 예약한다.\n-마케팅을 실시한다.\n-프로모션을 진행한다.\n-티켓을 판매한다.\n-보고서를 작성한다... 기반으로 30로 평가","analytical":"analytical는 [공연기획자]\n-공연을 기획한다.\n-예산을 관리한다.\n-아티스트를 섭외한다.\n-장소를 예약한다.\n-마케팅을 실시한다.\n-프로모션을 진행한다.\n-티켓을 판매한다.\n-보고서를 작성한다... 기반으로 30로 평가","creative":"creative는 [공연기획자]\n-공연을 기획한다.\n-예산을 관리한다.\n-아티스트를 섭외한다.\n-장소를 예약한다.\n-마케팅을 실시한다.\n-프로모션을 진행한다.\n-티켓을 판매한다.\n-보고서를 작성한다... 기반으로 60로 평가","execution":"execution는 [공연기획자]\n-공연을 기획한다.\n-예산을 관리한다.\n-아티스트를 섭외한다.\n-장소를 예약한다.\n-마케팅을 실시한다.\n-프로모션을 진행한다.\n-티켓을 판매한다.\n-보고서를 작성한다... 기반으로 60로 평가","people_facing":"people_facing는 [공연기획자]\n-공연을 기획한다.\n-예산을 관리한다.\n-아티스트를 섭외한다.\n-장소를 예약한다.\n-마케팅을 실시한다.\n-프로모션을 진행한다.\n-티켓을 판매한다.\n-보고서를 작성한다... 기반으로 60로 평가","degree_required":"degree_required는 [공연기획자]\n-공연을 기획한다.\n-예산을 관리한다.\n-아티스트를 섭외한다.\n-장소를 예약한다.\n-마케팅을 실시한다.\n-프로모션을 진행한다.\n-티켓을 판매한다.\n-보고서를 작성한다... 기반으로 none로 평가","license_required":"license_required는 [공연기획자]\n-공연을 기획한다.\n-예산을 관리한다.\n-아티스트를 섭외한다.\n-장소를 예약한다.\n-마케팅을 실시한다.\n-프로모션을 진행한다.\n-티켓을 판매한다.\n-보고서를 작성한다... 기반으로 none로 평가"}'
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
  '176528340904243',
  '경찰·소방·교도관리자',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 75, 50, 50,
  70, 30, 30, 60, 60, 75,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [경찰관리자]\n-경찰 업무를 감독한다.\n-범죄 예방을 기획한다.\n-팀을 관리한다.\n-교육을 실시한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-커뮤니티를 지원한다.\n\n[소방관리자... 기반으로 50로 평가","growth":"growth는 [경찰관리자]\n-경찰 업무를 감독한다.\n-범죄 예방을 기획한다.\n-팀을 관리한다.\n-교육을 실시한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-커뮤니티를 지원한다.\n\n[소방관리자... 기반으로 75로 평가","stability":"stability는 [경찰관리자]\n-경찰 업무를 감독한다.\n-범죄 예방을 기획한다.\n-팀을 관리한다.\n-교육을 실시한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-커뮤니티를 지원한다.\n\n[소방관리자... 기반으로 50로 평가","income":"income는 [경찰관리자]\n-경찰 업무를 감독한다.\n-범죄 예방을 기획한다.\n-팀을 관리한다.\n-교육을 실시한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-커뮤니티를 지원한다.\n\n[소방관리자... 기반으로 50로 평가","teamwork":"teamwork는 [경찰관리자]\n-경찰 업무를 감독한다.\n-범죄 예방을 기획한다.\n-팀을 관리한다.\n-교육을 실시한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-커뮤니티를 지원한다.\n\n[소방관리자... 기반으로 70로 평가","solo_deep":"solo_deep는 [경찰관리자]\n-경찰 업무를 감독한다.\n-범죄 예방을 기획한다.\n-팀을 관리한다.\n-교육을 실시한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-커뮤니티를 지원한다.\n\n[소방관리자... 기반으로 30로 평가","analytical":"analytical는 [경찰관리자]\n-경찰 업무를 감독한다.\n-범죄 예방을 기획한다.\n-팀을 관리한다.\n-교육을 실시한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-커뮤니티를 지원한다.\n\n[소방관리자... 기반으로 30로 평가","creative":"creative는 [경찰관리자]\n-경찰 업무를 감독한다.\n-범죄 예방을 기획한다.\n-팀을 관리한다.\n-교육을 실시한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-커뮤니티를 지원한다.\n\n[소방관리자... 기반으로 60로 평가","execution":"execution는 [경찰관리자]\n-경찰 업무를 감독한다.\n-범죄 예방을 기획한다.\n-팀을 관리한다.\n-교육을 실시한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-커뮤니티를 지원한다.\n\n[소방관리자... 기반으로 60로 평가","people_facing":"people_facing는 [경찰관리자]\n-경찰 업무를 감독한다.\n-범죄 예방을 기획한다.\n-팀을 관리한다.\n-교육을 실시한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-커뮤니티를 지원한다.\n\n[소방관리자... 기반으로 75로 평가","degree_required":"degree_required는 [경찰관리자]\n-경찰 업무를 감독한다.\n-범죄 예방을 기획한다.\n-팀을 관리한다.\n-교육을 실시한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-커뮤니티를 지원한다.\n\n[소방관리자... 기반으로 none로 평가","license_required":"license_required는 [경찰관리자]\n-경찰 업무를 감독한다.\n-범죄 예방을 기획한다.\n-팀을 관리한다.\n-교육을 실시한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-커뮤니티를 지원한다.\n\n[소방관리자... 기반으로 none로 평가"}'
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
  '1765283487138100',
  '기술영업원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 60, 30, 50,
  50, 50, 70, 40, 40, 75,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [기술영업원]\n-기술 제품을 소개한다.\n-고객의 요구를 파악한다.\n-솔루션을 제안한다.\n-계약을 체결한다.\n-기술 지원을 제공한다.\n-관계를 유지한다.\n-시장 동향을 분석한다.\n-... 기반으로 50로 평가","growth":"growth는 [기술영업원]\n-기술 제품을 소개한다.\n-고객의 요구를 파악한다.\n-솔루션을 제안한다.\n-계약을 체결한다.\n-기술 지원을 제공한다.\n-관계를 유지한다.\n-시장 동향을 분석한다.\n-... 기반으로 60로 평가","stability":"stability는 [기술영업원]\n-기술 제품을 소개한다.\n-고객의 요구를 파악한다.\n-솔루션을 제안한다.\n-계약을 체결한다.\n-기술 지원을 제공한다.\n-관계를 유지한다.\n-시장 동향을 분석한다.\n-... 기반으로 30로 평가","income":"income는 [기술영업원]\n-기술 제품을 소개한다.\n-고객의 요구를 파악한다.\n-솔루션을 제안한다.\n-계약을 체결한다.\n-기술 지원을 제공한다.\n-관계를 유지한다.\n-시장 동향을 분석한다.\n-... 기반으로 50로 평가","teamwork":"teamwork는 [기술영업원]\n-기술 제품을 소개한다.\n-고객의 요구를 파악한다.\n-솔루션을 제안한다.\n-계약을 체결한다.\n-기술 지원을 제공한다.\n-관계를 유지한다.\n-시장 동향을 분석한다.\n-... 기반으로 50로 평가","solo_deep":"solo_deep는 [기술영업원]\n-기술 제품을 소개한다.\n-고객의 요구를 파악한다.\n-솔루션을 제안한다.\n-계약을 체결한다.\n-기술 지원을 제공한다.\n-관계를 유지한다.\n-시장 동향을 분석한다.\n-... 기반으로 50로 평가","analytical":"analytical는 [기술영업원]\n-기술 제품을 소개한다.\n-고객의 요구를 파악한다.\n-솔루션을 제안한다.\n-계약을 체결한다.\n-기술 지원을 제공한다.\n-관계를 유지한다.\n-시장 동향을 분석한다.\n-... 기반으로 70로 평가","creative":"creative는 [기술영업원]\n-기술 제품을 소개한다.\n-고객의 요구를 파악한다.\n-솔루션을 제안한다.\n-계약을 체결한다.\n-기술 지원을 제공한다.\n-관계를 유지한다.\n-시장 동향을 분석한다.\n-... 기반으로 40로 평가","execution":"execution는 [기술영업원]\n-기술 제품을 소개한다.\n-고객의 요구를 파악한다.\n-솔루션을 제안한다.\n-계약을 체결한다.\n-기술 지원을 제공한다.\n-관계를 유지한다.\n-시장 동향을 분석한다.\n-... 기반으로 40로 평가","people_facing":"people_facing는 [기술영업원]\n-기술 제품을 소개한다.\n-고객의 요구를 파악한다.\n-솔루션을 제안한다.\n-계약을 체결한다.\n-기술 지원을 제공한다.\n-관계를 유지한다.\n-시장 동향을 분석한다.\n-... 기반으로 75로 평가","degree_required":"degree_required는 [기술영업원]\n-기술 제품을 소개한다.\n-고객의 요구를 파악한다.\n-솔루션을 제안한다.\n-계약을 체결한다.\n-기술 지원을 제공한다.\n-관계를 유지한다.\n-시장 동향을 분석한다.\n-... 기반으로 none로 평가","license_required":"license_required는 [기술영업원]\n-기술 제품을 소개한다.\n-고객의 요구를 파악한다.\n-솔루션을 제안한다.\n-계약을 체결한다.\n-기술 지원을 제공한다.\n-관계를 유지한다.\n-시장 동향을 분석한다.\n-... 기반으로 none로 평가"}'
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
  '1765283481435437',
  '주방장',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 75, 50, 50,
  50, 50, 30, 60, 60, 75,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [주방장]\n-메뉴를 기획한다.\n-조리를 감독한다.\n-품질을 유지한다.\n-직원을 관리한다.\n-재료를 관리한다.\n-위생을 유지한다.\n-비용을 통제한다.\n-고객 만족을 모니터링한다.\n-... 기반으로 50로 평가","growth":"growth는 [주방장]\n-메뉴를 기획한다.\n-조리를 감독한다.\n-품질을 유지한다.\n-직원을 관리한다.\n-재료를 관리한다.\n-위생을 유지한다.\n-비용을 통제한다.\n-고객 만족을 모니터링한다.\n-... 기반으로 75로 평가","stability":"stability는 [주방장]\n-메뉴를 기획한다.\n-조리를 감독한다.\n-품질을 유지한다.\n-직원을 관리한다.\n-재료를 관리한다.\n-위생을 유지한다.\n-비용을 통제한다.\n-고객 만족을 모니터링한다.\n-... 기반으로 50로 평가","income":"income는 [주방장]\n-메뉴를 기획한다.\n-조리를 감독한다.\n-품질을 유지한다.\n-직원을 관리한다.\n-재료를 관리한다.\n-위생을 유지한다.\n-비용을 통제한다.\n-고객 만족을 모니터링한다.\n-... 기반으로 50로 평가","teamwork":"teamwork는 [주방장]\n-메뉴를 기획한다.\n-조리를 감독한다.\n-품질을 유지한다.\n-직원을 관리한다.\n-재료를 관리한다.\n-위생을 유지한다.\n-비용을 통제한다.\n-고객 만족을 모니터링한다.\n-... 기반으로 50로 평가","solo_deep":"solo_deep는 [주방장]\n-메뉴를 기획한다.\n-조리를 감독한다.\n-품질을 유지한다.\n-직원을 관리한다.\n-재료를 관리한다.\n-위생을 유지한다.\n-비용을 통제한다.\n-고객 만족을 모니터링한다.\n-... 기반으로 50로 평가","analytical":"analytical는 [주방장]\n-메뉴를 기획한다.\n-조리를 감독한다.\n-품질을 유지한다.\n-직원을 관리한다.\n-재료를 관리한다.\n-위생을 유지한다.\n-비용을 통제한다.\n-고객 만족을 모니터링한다.\n-... 기반으로 30로 평가","creative":"creative는 [주방장]\n-메뉴를 기획한다.\n-조리를 감독한다.\n-품질을 유지한다.\n-직원을 관리한다.\n-재료를 관리한다.\n-위생을 유지한다.\n-비용을 통제한다.\n-고객 만족을 모니터링한다.\n-... 기반으로 60로 평가","execution":"execution는 [주방장]\n-메뉴를 기획한다.\n-조리를 감독한다.\n-품질을 유지한다.\n-직원을 관리한다.\n-재료를 관리한다.\n-위생을 유지한다.\n-비용을 통제한다.\n-고객 만족을 모니터링한다.\n-... 기반으로 60로 평가","people_facing":"people_facing는 [주방장]\n-메뉴를 기획한다.\n-조리를 감독한다.\n-품질을 유지한다.\n-직원을 관리한다.\n-재료를 관리한다.\n-위생을 유지한다.\n-비용을 통제한다.\n-고객 만족을 모니터링한다.\n-... 기반으로 75로 평가","degree_required":"degree_required는 [주방장]\n-메뉴를 기획한다.\n-조리를 감독한다.\n-품질을 유지한다.\n-직원을 관리한다.\n-재료를 관리한다.\n-위생을 유지한다.\n-비용을 통제한다.\n-고객 만족을 모니터링한다.\n-... 기반으로 none로 평가","license_required":"license_required는 [주방장]\n-메뉴를 기획한다.\n-조리를 감독한다.\n-품질을 유지한다.\n-직원을 관리한다.\n-재료를 관리한다.\n-위생을 유지한다.\n-비용을 통제한다.\n-고객 만족을 모니터링한다.\n-... 기반으로 none로 평가"}'
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
  '1765283489136648',
  '온라인판매원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  50, 50, 60, 30, 60, 75,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [온라인판매원]\n-제품을 등록한다.\n-가격을 설정한다.\n-고객을 응대한다.\n-주문을 처리한다.\n-배송을 관리한다.\n-리뷰를 모니터링한다.\n-마케팅을 실시한다.\n-판매 실적을 분석한... 기반으로 50로 평가","growth":"growth는 [온라인판매원]\n-제품을 등록한다.\n-가격을 설정한다.\n-고객을 응대한다.\n-주문을 처리한다.\n-배송을 관리한다.\n-리뷰를 모니터링한다.\n-마케팅을 실시한다.\n-판매 실적을 분석한... 기반으로 50로 평가","stability":"stability는 [온라인판매원]\n-제품을 등록한다.\n-가격을 설정한다.\n-고객을 응대한다.\n-주문을 처리한다.\n-배송을 관리한다.\n-리뷰를 모니터링한다.\n-마케팅을 실시한다.\n-판매 실적을 분석한... 기반으로 50로 평가","income":"income는 [온라인판매원]\n-제품을 등록한다.\n-가격을 설정한다.\n-고객을 응대한다.\n-주문을 처리한다.\n-배송을 관리한다.\n-리뷰를 모니터링한다.\n-마케팅을 실시한다.\n-판매 실적을 분석한... 기반으로 50로 평가","teamwork":"teamwork는 [온라인판매원]\n-제품을 등록한다.\n-가격을 설정한다.\n-고객을 응대한다.\n-주문을 처리한다.\n-배송을 관리한다.\n-리뷰를 모니터링한다.\n-마케팅을 실시한다.\n-판매 실적을 분석한... 기반으로 50로 평가","solo_deep":"solo_deep는 [온라인판매원]\n-제품을 등록한다.\n-가격을 설정한다.\n-고객을 응대한다.\n-주문을 처리한다.\n-배송을 관리한다.\n-리뷰를 모니터링한다.\n-마케팅을 실시한다.\n-판매 실적을 분석한... 기반으로 50로 평가","analytical":"analytical는 [온라인판매원]\n-제품을 등록한다.\n-가격을 설정한다.\n-고객을 응대한다.\n-주문을 처리한다.\n-배송을 관리한다.\n-리뷰를 모니터링한다.\n-마케팅을 실시한다.\n-판매 실적을 분석한... 기반으로 60로 평가","creative":"creative는 [온라인판매원]\n-제품을 등록한다.\n-가격을 설정한다.\n-고객을 응대한다.\n-주문을 처리한다.\n-배송을 관리한다.\n-리뷰를 모니터링한다.\n-마케팅을 실시한다.\n-판매 실적을 분석한... 기반으로 30로 평가","execution":"execution는 [온라인판매원]\n-제품을 등록한다.\n-가격을 설정한다.\n-고객을 응대한다.\n-주문을 처리한다.\n-배송을 관리한다.\n-리뷰를 모니터링한다.\n-마케팅을 실시한다.\n-판매 실적을 분석한... 기반으로 60로 평가","people_facing":"people_facing는 [온라인판매원]\n-제품을 등록한다.\n-가격을 설정한다.\n-고객을 응대한다.\n-주문을 처리한다.\n-배송을 관리한다.\n-리뷰를 모니터링한다.\n-마케팅을 실시한다.\n-판매 실적을 분석한... 기반으로 75로 평가","degree_required":"degree_required는 [온라인판매원]\n-제품을 등록한다.\n-가격을 설정한다.\n-고객을 응대한다.\n-주문을 처리한다.\n-배송을 관리한다.\n-리뷰를 모니터링한다.\n-마케팅을 실시한다.\n-판매 실적을 분석한... 기반으로 none로 평가","license_required":"license_required는 [온라인판매원]\n-제품을 등록한다.\n-가격을 설정한다.\n-고객을 응대한다.\n-주문을 처리한다.\n-배송을 관리한다.\n-리뷰를 모니터링한다.\n-마케팅을 실시한다.\n-판매 실적을 분석한... 기반으로 none로 평가"}'
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
  '1765283484954564',
  '방역원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 60, 50, 50,
  50, 50, 40, 40, 70, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [방역원]\n-방역을 실시한다.\n-해충을 방제한다.\n-청소를 한다.\n-장비를 사용한다.\n-안전을 유지한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-교육을 받는다.\n-법규를 준수한... 기반으로 50로 평가","growth":"growth는 [방역원]\n-방역을 실시한다.\n-해충을 방제한다.\n-청소를 한다.\n-장비를 사용한다.\n-안전을 유지한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-교육을 받는다.\n-법규를 준수한... 기반으로 60로 평가","stability":"stability는 [방역원]\n-방역을 실시한다.\n-해충을 방제한다.\n-청소를 한다.\n-장비를 사용한다.\n-안전을 유지한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-교육을 받는다.\n-법규를 준수한... 기반으로 50로 평가","income":"income는 [방역원]\n-방역을 실시한다.\n-해충을 방제한다.\n-청소를 한다.\n-장비를 사용한다.\n-안전을 유지한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-교육을 받는다.\n-법규를 준수한... 기반으로 50로 평가","teamwork":"teamwork는 [방역원]\n-방역을 실시한다.\n-해충을 방제한다.\n-청소를 한다.\n-장비를 사용한다.\n-안전을 유지한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-교육을 받는다.\n-법규를 준수한... 기반으로 50로 평가","solo_deep":"solo_deep는 [방역원]\n-방역을 실시한다.\n-해충을 방제한다.\n-청소를 한다.\n-장비를 사용한다.\n-안전을 유지한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-교육을 받는다.\n-법규를 준수한... 기반으로 50로 평가","analytical":"analytical는 [방역원]\n-방역을 실시한다.\n-해충을 방제한다.\n-청소를 한다.\n-장비를 사용한다.\n-안전을 유지한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-교육을 받는다.\n-법규를 준수한... 기반으로 40로 평가","creative":"creative는 [방역원]\n-방역을 실시한다.\n-해충을 방제한다.\n-청소를 한다.\n-장비를 사용한다.\n-안전을 유지한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-교육을 받는다.\n-법규를 준수한... 기반으로 40로 평가","execution":"execution는 [방역원]\n-방역을 실시한다.\n-해충을 방제한다.\n-청소를 한다.\n-장비를 사용한다.\n-안전을 유지한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-교육을 받는다.\n-법규를 준수한... 기반으로 70로 평가","people_facing":"people_facing는 [방역원]\n-방역을 실시한다.\n-해충을 방제한다.\n-청소를 한다.\n-장비를 사용한다.\n-안전을 유지한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-교육을 받는다.\n-법규를 준수한... 기반으로 50로 평가","degree_required":"degree_required는 [방역원]\n-방역을 실시한다.\n-해충을 방제한다.\n-청소를 한다.\n-장비를 사용한다.\n-안전을 유지한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-교육을 받는다.\n-법규를 준수한... 기반으로 none로 평가","license_required":"license_required는 [방역원]\n-방역을 실시한다.\n-해충을 방제한다.\n-청소를 한다.\n-장비를 사용한다.\n-안전을 유지한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-교육을 받는다.\n-법규를 준수한... 기반으로 none로 평가"}'
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
  '1765283486774724',
  '제품광고영업원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 30, 50,
  50, 50, 70, 40, 40, 75,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [제품광고영업원]\n-광고 공간을 판매한다.\n-클라이언트를 발굴한다.\n-계약을 체결한다.\n-광고 효과를 설명한다.\n-가격을 협상한다.\n-관계를 유지한다.\n-시장 동향을 분석한다.\n-... 기반으로 50로 평가","growth":"growth는 [제품광고영업원]\n-광고 공간을 판매한다.\n-클라이언트를 발굴한다.\n-계약을 체결한다.\n-광고 효과를 설명한다.\n-가격을 협상한다.\n-관계를 유지한다.\n-시장 동향을 분석한다.\n-... 기반으로 50로 평가","stability":"stability는 [제품광고영업원]\n-광고 공간을 판매한다.\n-클라이언트를 발굴한다.\n-계약을 체결한다.\n-광고 효과를 설명한다.\n-가격을 협상한다.\n-관계를 유지한다.\n-시장 동향을 분석한다.\n-... 기반으로 30로 평가","income":"income는 [제품광고영업원]\n-광고 공간을 판매한다.\n-클라이언트를 발굴한다.\n-계약을 체결한다.\n-광고 효과를 설명한다.\n-가격을 협상한다.\n-관계를 유지한다.\n-시장 동향을 분석한다.\n-... 기반으로 50로 평가","teamwork":"teamwork는 [제품광고영업원]\n-광고 공간을 판매한다.\n-클라이언트를 발굴한다.\n-계약을 체결한다.\n-광고 효과를 설명한다.\n-가격을 협상한다.\n-관계를 유지한다.\n-시장 동향을 분석한다.\n-... 기반으로 50로 평가","solo_deep":"solo_deep는 [제품광고영업원]\n-광고 공간을 판매한다.\n-클라이언트를 발굴한다.\n-계약을 체결한다.\n-광고 효과를 설명한다.\n-가격을 협상한다.\n-관계를 유지한다.\n-시장 동향을 분석한다.\n-... 기반으로 50로 평가","analytical":"analytical는 [제품광고영업원]\n-광고 공간을 판매한다.\n-클라이언트를 발굴한다.\n-계약을 체결한다.\n-광고 효과를 설명한다.\n-가격을 협상한다.\n-관계를 유지한다.\n-시장 동향을 분석한다.\n-... 기반으로 70로 평가","creative":"creative는 [제품광고영업원]\n-광고 공간을 판매한다.\n-클라이언트를 발굴한다.\n-계약을 체결한다.\n-광고 효과를 설명한다.\n-가격을 협상한다.\n-관계를 유지한다.\n-시장 동향을 분석한다.\n-... 기반으로 40로 평가","execution":"execution는 [제품광고영업원]\n-광고 공간을 판매한다.\n-클라이언트를 발굴한다.\n-계약을 체결한다.\n-광고 효과를 설명한다.\n-가격을 협상한다.\n-관계를 유지한다.\n-시장 동향을 분석한다.\n-... 기반으로 40로 평가","people_facing":"people_facing는 [제품광고영업원]\n-광고 공간을 판매한다.\n-클라이언트를 발굴한다.\n-계약을 체결한다.\n-광고 효과를 설명한다.\n-가격을 협상한다.\n-관계를 유지한다.\n-시장 동향을 분석한다.\n-... 기반으로 75로 평가","degree_required":"degree_required는 [제품광고영업원]\n-광고 공간을 판매한다.\n-클라이언트를 발굴한다.\n-계약을 체결한다.\n-광고 효과를 설명한다.\n-가격을 협상한다.\n-관계를 유지한다.\n-시장 동향을 분석한다.\n-... 기반으로 none로 평가","license_required":"license_required는 [제품광고영업원]\n-광고 공간을 판매한다.\n-클라이언트를 발굴한다.\n-계약을 체결한다.\n-광고 효과를 설명한다.\n-가격을 협상한다.\n-관계를 유지한다.\n-시장 동향을 분석한다.\n-... 기반으로 none로 평가"}'
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