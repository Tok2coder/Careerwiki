-- Batch tagging SQL generated at 2026-01-06T07:13:40.907Z
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
  '1765283438279407',
  '데이터분석가(빅데이터분석가)',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 70, 50,
  70, 30, 60, 60, 30, 35,
  'regular', 'none', 'none', 'partial',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [데이터분석가]\n-데이터를 수집한다.\n-데이터를 정제한다.\n-분석을 실시한다.\n-패턴을 발견한다.\n-보고서를 작성한다.\n-시각화를 만든다.\n-모델을 개발한다.\n-결과를 해석한다.\n... 기반으로 50로 평가","growth":"growth는 [데이터분석가]\n-데이터를 수집한다.\n-데이터를 정제한다.\n-분석을 실시한다.\n-패턴을 발견한다.\n-보고서를 작성한다.\n-시각화를 만든다.\n-모델을 개발한다.\n-결과를 해석한다.\n... 기반으로 65로 평가","stability":"stability는 [데이터분석가]\n-데이터를 수집한다.\n-데이터를 정제한다.\n-분석을 실시한다.\n-패턴을 발견한다.\n-보고서를 작성한다.\n-시각화를 만든다.\n-모델을 개발한다.\n-결과를 해석한다.\n... 기반으로 70로 평가","income":"income는 [데이터분석가]\n-데이터를 수집한다.\n-데이터를 정제한다.\n-분석을 실시한다.\n-패턴을 발견한다.\n-보고서를 작성한다.\n-시각화를 만든다.\n-모델을 개발한다.\n-결과를 해석한다.\n... 기반으로 50로 평가","teamwork":"teamwork는 [데이터분석가]\n-데이터를 수집한다.\n-데이터를 정제한다.\n-분석을 실시한다.\n-패턴을 발견한다.\n-보고서를 작성한다.\n-시각화를 만든다.\n-모델을 개발한다.\n-결과를 해석한다.\n... 기반으로 70로 평가","solo_deep":"solo_deep는 [데이터분석가]\n-데이터를 수집한다.\n-데이터를 정제한다.\n-분석을 실시한다.\n-패턴을 발견한다.\n-보고서를 작성한다.\n-시각화를 만든다.\n-모델을 개발한다.\n-결과를 해석한다.\n... 기반으로 30로 평가","analytical":"analytical는 [데이터분석가]\n-데이터를 수집한다.\n-데이터를 정제한다.\n-분석을 실시한다.\n-패턴을 발견한다.\n-보고서를 작성한다.\n-시각화를 만든다.\n-모델을 개발한다.\n-결과를 해석한다.\n... 기반으로 60로 평가","creative":"creative는 [데이터분석가]\n-데이터를 수집한다.\n-데이터를 정제한다.\n-분석을 실시한다.\n-패턴을 발견한다.\n-보고서를 작성한다.\n-시각화를 만든다.\n-모델을 개발한다.\n-결과를 해석한다.\n... 기반으로 60로 평가","execution":"execution는 [데이터분석가]\n-데이터를 수집한다.\n-데이터를 정제한다.\n-분석을 실시한다.\n-패턴을 발견한다.\n-보고서를 작성한다.\n-시각화를 만든다.\n-모델을 개발한다.\n-결과를 해석한다.\n... 기반으로 30로 평가","people_facing":"people_facing는 [데이터분석가]\n-데이터를 수집한다.\n-데이터를 정제한다.\n-분석을 실시한다.\n-패턴을 발견한다.\n-보고서를 작성한다.\n-시각화를 만든다.\n-모델을 개발한다.\n-결과를 해석한다.\n... 기반으로 35로 평가","degree_required":"degree_required는 [데이터분석가]\n-데이터를 수집한다.\n-데이터를 정제한다.\n-분석을 실시한다.\n-패턴을 발견한다.\n-보고서를 작성한다.\n-시각화를 만든다.\n-모델을 개발한다.\n-결과를 해석한다.\n... 기반으로 none로 평가","license_required":"license_required는 [데이터분석가]\n-데이터를 수집한다.\n-데이터를 정제한다.\n-분석을 실시한다.\n-패턴을 발견한다.\n-보고서를 작성한다.\n-시각화를 만든다.\n-모델을 개발한다.\n-결과를 해석한다.\n... 기반으로 none로 평가"}'
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
  '1765283414610719',
  '상품기획자',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 50, 50,
  50, 50, 60, 60, 30, 60,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [상품기획자]\n-시장 조사를 실시한다.\n-상품 콘셉트를 개발한다.\n-디자인을 기획한다.\n-가격을 설정한다.\n-생산을 감독한다.\n-마케팅을 계획한다.\n-판매를 모니터링한다.\n-피드백... 기반으로 50로 평가","growth":"growth는 [상품기획자]\n-시장 조사를 실시한다.\n-상품 콘셉트를 개발한다.\n-디자인을 기획한다.\n-가격을 설정한다.\n-생산을 감독한다.\n-마케팅을 계획한다.\n-판매를 모니터링한다.\n-피드백... 기반으로 65로 평가","stability":"stability는 [상품기획자]\n-시장 조사를 실시한다.\n-상품 콘셉트를 개발한다.\n-디자인을 기획한다.\n-가격을 설정한다.\n-생산을 감독한다.\n-마케팅을 계획한다.\n-판매를 모니터링한다.\n-피드백... 기반으로 50로 평가","income":"income는 [상품기획자]\n-시장 조사를 실시한다.\n-상품 콘셉트를 개발한다.\n-디자인을 기획한다.\n-가격을 설정한다.\n-생산을 감독한다.\n-마케팅을 계획한다.\n-판매를 모니터링한다.\n-피드백... 기반으로 50로 평가","teamwork":"teamwork는 [상품기획자]\n-시장 조사를 실시한다.\n-상품 콘셉트를 개발한다.\n-디자인을 기획한다.\n-가격을 설정한다.\n-생산을 감독한다.\n-마케팅을 계획한다.\n-판매를 모니터링한다.\n-피드백... 기반으로 50로 평가","solo_deep":"solo_deep는 [상품기획자]\n-시장 조사를 실시한다.\n-상품 콘셉트를 개발한다.\n-디자인을 기획한다.\n-가격을 설정한다.\n-생산을 감독한다.\n-마케팅을 계획한다.\n-판매를 모니터링한다.\n-피드백... 기반으로 50로 평가","analytical":"analytical는 [상품기획자]\n-시장 조사를 실시한다.\n-상품 콘셉트를 개발한다.\n-디자인을 기획한다.\n-가격을 설정한다.\n-생산을 감독한다.\n-마케팅을 계획한다.\n-판매를 모니터링한다.\n-피드백... 기반으로 60로 평가","creative":"creative는 [상품기획자]\n-시장 조사를 실시한다.\n-상품 콘셉트를 개발한다.\n-디자인을 기획한다.\n-가격을 설정한다.\n-생산을 감독한다.\n-마케팅을 계획한다.\n-판매를 모니터링한다.\n-피드백... 기반으로 60로 평가","execution":"execution는 [상품기획자]\n-시장 조사를 실시한다.\n-상품 콘셉트를 개발한다.\n-디자인을 기획한다.\n-가격을 설정한다.\n-생산을 감독한다.\n-마케팅을 계획한다.\n-판매를 모니터링한다.\n-피드백... 기반으로 30로 평가","people_facing":"people_facing는 [상품기획자]\n-시장 조사를 실시한다.\n-상품 콘셉트를 개발한다.\n-디자인을 기획한다.\n-가격을 설정한다.\n-생산을 감독한다.\n-마케팅을 계획한다.\n-판매를 모니터링한다.\n-피드백... 기반으로 60로 평가","degree_required":"degree_required는 [상품기획자]\n-시장 조사를 실시한다.\n-상품 콘셉트를 개발한다.\n-디자인을 기획한다.\n-가격을 설정한다.\n-생산을 감독한다.\n-마케팅을 계획한다.\n-판매를 모니터링한다.\n-피드백... 기반으로 none로 평가","license_required":"license_required는 [상품기획자]\n-시장 조사를 실시한다.\n-상품 콘셉트를 개발한다.\n-디자인을 기획한다.\n-가격을 설정한다.\n-생산을 감독한다.\n-마케팅을 계획한다.\n-판매를 모니터링한다.\n-피드백... 기반으로 none로 평가"}'
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
  '1765283474115560',
  '미디어콘텐츠창작자(크리에이터)',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 50, 40,
  50, 50, 50, 50, 50, 35,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [미디어콘텐츠창작자]\n-콘텐츠를 기획한다.\n-콘텐츠를 제작한다.\n-촬영을 실시한다.\n-편집을 한다.\n-플랫폼에 업로드한다.\n-시청자를 분석한다.\n-콘텐츠를 최적화한다.\n-팬과 소통... 기반으로 50로 평가","growth":"growth는 [미디어콘텐츠창작자]\n-콘텐츠를 기획한다.\n-콘텐츠를 제작한다.\n-촬영을 실시한다.\n-편집을 한다.\n-플랫폼에 업로드한다.\n-시청자를 분석한다.\n-콘텐츠를 최적화한다.\n-팬과 소통... 기반으로 65로 평가","stability":"stability는 [미디어콘텐츠창작자]\n-콘텐츠를 기획한다.\n-콘텐츠를 제작한다.\n-촬영을 실시한다.\n-편집을 한다.\n-플랫폼에 업로드한다.\n-시청자를 분석한다.\n-콘텐츠를 최적화한다.\n-팬과 소통... 기반으로 50로 평가","income":"income는 [미디어콘텐츠창작자]\n-콘텐츠를 기획한다.\n-콘텐츠를 제작한다.\n-촬영을 실시한다.\n-편집을 한다.\n-플랫폼에 업로드한다.\n-시청자를 분석한다.\n-콘텐츠를 최적화한다.\n-팬과 소통... 기반으로 40로 평가","teamwork":"teamwork는 [미디어콘텐츠창작자]\n-콘텐츠를 기획한다.\n-콘텐츠를 제작한다.\n-촬영을 실시한다.\n-편집을 한다.\n-플랫폼에 업로드한다.\n-시청자를 분석한다.\n-콘텐츠를 최적화한다.\n-팬과 소통... 기반으로 50로 평가","solo_deep":"solo_deep는 [미디어콘텐츠창작자]\n-콘텐츠를 기획한다.\n-콘텐츠를 제작한다.\n-촬영을 실시한다.\n-편집을 한다.\n-플랫폼에 업로드한다.\n-시청자를 분석한다.\n-콘텐츠를 최적화한다.\n-팬과 소통... 기반으로 50로 평가","analytical":"analytical는 [미디어콘텐츠창작자]\n-콘텐츠를 기획한다.\n-콘텐츠를 제작한다.\n-촬영을 실시한다.\n-편집을 한다.\n-플랫폼에 업로드한다.\n-시청자를 분석한다.\n-콘텐츠를 최적화한다.\n-팬과 소통... 기반으로 50로 평가","creative":"creative는 [미디어콘텐츠창작자]\n-콘텐츠를 기획한다.\n-콘텐츠를 제작한다.\n-촬영을 실시한다.\n-편집을 한다.\n-플랫폼에 업로드한다.\n-시청자를 분석한다.\n-콘텐츠를 최적화한다.\n-팬과 소통... 기반으로 50로 평가","execution":"execution는 [미디어콘텐츠창작자]\n-콘텐츠를 기획한다.\n-콘텐츠를 제작한다.\n-촬영을 실시한다.\n-편집을 한다.\n-플랫폼에 업로드한다.\n-시청자를 분석한다.\n-콘텐츠를 최적화한다.\n-팬과 소통... 기반으로 50로 평가","people_facing":"people_facing는 [미디어콘텐츠창작자]\n-콘텐츠를 기획한다.\n-콘텐츠를 제작한다.\n-촬영을 실시한다.\n-편집을 한다.\n-플랫폼에 업로드한다.\n-시청자를 분석한다.\n-콘텐츠를 최적화한다.\n-팬과 소통... 기반으로 35로 평가","degree_required":"degree_required는 [미디어콘텐츠창작자]\n-콘텐츠를 기획한다.\n-콘텐츠를 제작한다.\n-촬영을 실시한다.\n-편집을 한다.\n-플랫폼에 업로드한다.\n-시청자를 분석한다.\n-콘텐츠를 최적화한다.\n-팬과 소통... 기반으로 none로 평가","license_required":"license_required는 [미디어콘텐츠창작자]\n-콘텐츠를 기획한다.\n-콘텐츠를 제작한다.\n-촬영을 실시한다.\n-편집을 한다.\n-플랫폼에 업로드한다.\n-시청자를 분석한다.\n-콘텐츠를 최적화한다.\n-팬과 소통... 기반으로 none로 평가"}'
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
  '17652834880882',
  '소규모판매점장',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  50, 50, 40, 40, 70, 75,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [소규모판매점장]\n-매장을 관리한다.\n-재고를 관리한다.\n-직원을 감독한다.\n-고객을 응대한다.\n-판매를 실시한다.\n-청결을 유지한다.\n-주문을 처리한다.\n-기록을 관리한다.\n-보... 기반으로 50로 평가","growth":"growth는 [소규모판매점장]\n-매장을 관리한다.\n-재고를 관리한다.\n-직원을 감독한다.\n-고객을 응대한다.\n-판매를 실시한다.\n-청결을 유지한다.\n-주문을 처리한다.\n-기록을 관리한다.\n-보... 기반으로 50로 평가","stability":"stability는 [소규모판매점장]\n-매장을 관리한다.\n-재고를 관리한다.\n-직원을 감독한다.\n-고객을 응대한다.\n-판매를 실시한다.\n-청결을 유지한다.\n-주문을 처리한다.\n-기록을 관리한다.\n-보... 기반으로 50로 평가","income":"income는 [소규모판매점장]\n-매장을 관리한다.\n-재고를 관리한다.\n-직원을 감독한다.\n-고객을 응대한다.\n-판매를 실시한다.\n-청결을 유지한다.\n-주문을 처리한다.\n-기록을 관리한다.\n-보... 기반으로 50로 평가","teamwork":"teamwork는 [소규모판매점장]\n-매장을 관리한다.\n-재고를 관리한다.\n-직원을 감독한다.\n-고객을 응대한다.\n-판매를 실시한다.\n-청결을 유지한다.\n-주문을 처리한다.\n-기록을 관리한다.\n-보... 기반으로 50로 평가","solo_deep":"solo_deep는 [소규모판매점장]\n-매장을 관리한다.\n-재고를 관리한다.\n-직원을 감독한다.\n-고객을 응대한다.\n-판매를 실시한다.\n-청결을 유지한다.\n-주문을 처리한다.\n-기록을 관리한다.\n-보... 기반으로 50로 평가","analytical":"analytical는 [소규모판매점장]\n-매장을 관리한다.\n-재고를 관리한다.\n-직원을 감독한다.\n-고객을 응대한다.\n-판매를 실시한다.\n-청결을 유지한다.\n-주문을 처리한다.\n-기록을 관리한다.\n-보... 기반으로 40로 평가","creative":"creative는 [소규모판매점장]\n-매장을 관리한다.\n-재고를 관리한다.\n-직원을 감독한다.\n-고객을 응대한다.\n-판매를 실시한다.\n-청결을 유지한다.\n-주문을 처리한다.\n-기록을 관리한다.\n-보... 기반으로 40로 평가","execution":"execution는 [소규모판매점장]\n-매장을 관리한다.\n-재고를 관리한다.\n-직원을 감독한다.\n-고객을 응대한다.\n-판매를 실시한다.\n-청결을 유지한다.\n-주문을 처리한다.\n-기록을 관리한다.\n-보... 기반으로 70로 평가","people_facing":"people_facing는 [소규모판매점장]\n-매장을 관리한다.\n-재고를 관리한다.\n-직원을 감독한다.\n-고객을 응대한다.\n-판매를 실시한다.\n-청결을 유지한다.\n-주문을 처리한다.\n-기록을 관리한다.\n-보... 기반으로 75로 평가","degree_required":"degree_required는 [소규모판매점장]\n-매장을 관리한다.\n-재고를 관리한다.\n-직원을 감독한다.\n-고객을 응대한다.\n-판매를 실시한다.\n-청결을 유지한다.\n-주문을 처리한다.\n-기록을 관리한다.\n-보... 기반으로 none로 평가","license_required":"license_required는 [소규모판매점장]\n-매장을 관리한다.\n-재고를 관리한다.\n-직원을 감독한다.\n-고객을 응대한다.\n-판매를 실시한다.\n-청결을 유지한다.\n-주문을 처리한다.\n-기록을 관리한다.\n-보... 기반으로 none로 평가"}'
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
  '1765283474642714',
  '직업운동선수',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 75, 50, 40,
  50, 50, 60, 30, 60, 35,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [직업운동선수]\n-훈련을 실시한다.\n-경기에 참가한다.\n-기량을 향상시킨다.\n-전술을 연구한다.\n-체력을 유지한다.\n-부상을 예방한다.\n-미디어 활동을 한다.\n-팬과 소통한다.\n-... 기반으로 50로 평가","growth":"growth는 [직업운동선수]\n-훈련을 실시한다.\n-경기에 참가한다.\n-기량을 향상시킨다.\n-전술을 연구한다.\n-체력을 유지한다.\n-부상을 예방한다.\n-미디어 활동을 한다.\n-팬과 소통한다.\n-... 기반으로 75로 평가","stability":"stability는 [직업운동선수]\n-훈련을 실시한다.\n-경기에 참가한다.\n-기량을 향상시킨다.\n-전술을 연구한다.\n-체력을 유지한다.\n-부상을 예방한다.\n-미디어 활동을 한다.\n-팬과 소통한다.\n-... 기반으로 50로 평가","income":"income는 [직업운동선수]\n-훈련을 실시한다.\n-경기에 참가한다.\n-기량을 향상시킨다.\n-전술을 연구한다.\n-체력을 유지한다.\n-부상을 예방한다.\n-미디어 활동을 한다.\n-팬과 소통한다.\n-... 기반으로 40로 평가","teamwork":"teamwork는 [직업운동선수]\n-훈련을 실시한다.\n-경기에 참가한다.\n-기량을 향상시킨다.\n-전술을 연구한다.\n-체력을 유지한다.\n-부상을 예방한다.\n-미디어 활동을 한다.\n-팬과 소통한다.\n-... 기반으로 50로 평가","solo_deep":"solo_deep는 [직업운동선수]\n-훈련을 실시한다.\n-경기에 참가한다.\n-기량을 향상시킨다.\n-전술을 연구한다.\n-체력을 유지한다.\n-부상을 예방한다.\n-미디어 활동을 한다.\n-팬과 소통한다.\n-... 기반으로 50로 평가","analytical":"analytical는 [직업운동선수]\n-훈련을 실시한다.\n-경기에 참가한다.\n-기량을 향상시킨다.\n-전술을 연구한다.\n-체력을 유지한다.\n-부상을 예방한다.\n-미디어 활동을 한다.\n-팬과 소통한다.\n-... 기반으로 60로 평가","creative":"creative는 [직업운동선수]\n-훈련을 실시한다.\n-경기에 참가한다.\n-기량을 향상시킨다.\n-전술을 연구한다.\n-체력을 유지한다.\n-부상을 예방한다.\n-미디어 활동을 한다.\n-팬과 소통한다.\n-... 기반으로 30로 평가","execution":"execution는 [직업운동선수]\n-훈련을 실시한다.\n-경기에 참가한다.\n-기량을 향상시킨다.\n-전술을 연구한다.\n-체력을 유지한다.\n-부상을 예방한다.\n-미디어 활동을 한다.\n-팬과 소통한다.\n-... 기반으로 60로 평가","people_facing":"people_facing는 [직업운동선수]\n-훈련을 실시한다.\n-경기에 참가한다.\n-기량을 향상시킨다.\n-전술을 연구한다.\n-체력을 유지한다.\n-부상을 예방한다.\n-미디어 활동을 한다.\n-팬과 소통한다.\n-... 기반으로 35로 평가","degree_required":"degree_required는 [직업운동선수]\n-훈련을 실시한다.\n-경기에 참가한다.\n-기량을 향상시킨다.\n-전술을 연구한다.\n-체력을 유지한다.\n-부상을 예방한다.\n-미디어 활동을 한다.\n-팬과 소통한다.\n-... 기반으로 none로 평가","license_required":"license_required는 [직업운동선수]\n-훈련을 실시한다.\n-경기에 참가한다.\n-기량을 향상시킨다.\n-전술을 연구한다.\n-체력을 유지한다.\n-부상을 예방한다.\n-미디어 활동을 한다.\n-팬과 소통한다.\n-... 기반으로 none로 평가"}'
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
  '17652834329924',
  '수산학연구원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  40, 75, 50, 70,
  50, 50, 60, 60, 30, 35,
  'overtime_some', 'none', 'some', 'none',
  'master', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [수산학연구원]\n-수산 자원을 연구한다.\n-양식 기술을 개발한다.\n-생태계를 분석한다.\n-질병을 연구한다.\n-사료를 개발한다.\n-환경 영향을 평가한다.\n-보고서를 작성한다.\n-현장... 기반으로 40로 평가","growth":"growth는 [수산학연구원]\n-수산 자원을 연구한다.\n-양식 기술을 개발한다.\n-생태계를 분석한다.\n-질병을 연구한다.\n-사료를 개발한다.\n-환경 영향을 평가한다.\n-보고서를 작성한다.\n-현장... 기반으로 75로 평가","stability":"stability는 [수산학연구원]\n-수산 자원을 연구한다.\n-양식 기술을 개발한다.\n-생태계를 분석한다.\n-질병을 연구한다.\n-사료를 개발한다.\n-환경 영향을 평가한다.\n-보고서를 작성한다.\n-현장... 기반으로 50로 평가","income":"income는 [수산학연구원]\n-수산 자원을 연구한다.\n-양식 기술을 개발한다.\n-생태계를 분석한다.\n-질병을 연구한다.\n-사료를 개발한다.\n-환경 영향을 평가한다.\n-보고서를 작성한다.\n-현장... 기반으로 70로 평가","teamwork":"teamwork는 [수산학연구원]\n-수산 자원을 연구한다.\n-양식 기술을 개발한다.\n-생태계를 분석한다.\n-질병을 연구한다.\n-사료를 개발한다.\n-환경 영향을 평가한다.\n-보고서를 작성한다.\n-현장... 기반으로 50로 평가","solo_deep":"solo_deep는 [수산학연구원]\n-수산 자원을 연구한다.\n-양식 기술을 개발한다.\n-생태계를 분석한다.\n-질병을 연구한다.\n-사료를 개발한다.\n-환경 영향을 평가한다.\n-보고서를 작성한다.\n-현장... 기반으로 50로 평가","analytical":"analytical는 [수산학연구원]\n-수산 자원을 연구한다.\n-양식 기술을 개발한다.\n-생태계를 분석한다.\n-질병을 연구한다.\n-사료를 개발한다.\n-환경 영향을 평가한다.\n-보고서를 작성한다.\n-현장... 기반으로 60로 평가","creative":"creative는 [수산학연구원]\n-수산 자원을 연구한다.\n-양식 기술을 개발한다.\n-생태계를 분석한다.\n-질병을 연구한다.\n-사료를 개발한다.\n-환경 영향을 평가한다.\n-보고서를 작성한다.\n-현장... 기반으로 60로 평가","execution":"execution는 [수산학연구원]\n-수산 자원을 연구한다.\n-양식 기술을 개발한다.\n-생태계를 분석한다.\n-질병을 연구한다.\n-사료를 개발한다.\n-환경 영향을 평가한다.\n-보고서를 작성한다.\n-현장... 기반으로 30로 평가","people_facing":"people_facing는 [수산학연구원]\n-수산 자원을 연구한다.\n-양식 기술을 개발한다.\n-생태계를 분석한다.\n-질병을 연구한다.\n-사료를 개발한다.\n-환경 영향을 평가한다.\n-보고서를 작성한다.\n-현장... 기반으로 35로 평가","degree_required":"degree_required는 [수산학연구원]\n-수산 자원을 연구한다.\n-양식 기술을 개발한다.\n-생태계를 분석한다.\n-질병을 연구한다.\n-사료를 개발한다.\n-환경 영향을 평가한다.\n-보고서를 작성한다.\n-현장... 기반으로 master로 평가","license_required":"license_required는 [수산학연구원]\n-수산 자원을 연구한다.\n-양식 기술을 개발한다.\n-생태계를 분석한다.\n-질병을 연구한다.\n-사료를 개발한다.\n-환경 영향을 평가한다.\n-보고서를 작성한다.\n-현장... 기반으로 none로 평가"}'
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
  '1765283433543336',
  '농림어업시험원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  40, 75, 50, 70,
  50, 50, 60, 60, 30, 35,
  'overtime_some', 'none', 'some', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [농림어업시험원]\n-시험을 설계한다.\n-데이터를 수집한다.\n-분석을 실시한다.\n-기술을 개발한다.\n-결과를 평가한다.\n-보고서를 작성한다.\n-현장을 지원한다.\n-교육을 실시한다.\n... 기반으로 40로 평가","growth":"growth는 [농림어업시험원]\n-시험을 설계한다.\n-데이터를 수집한다.\n-분석을 실시한다.\n-기술을 개발한다.\n-결과를 평가한다.\n-보고서를 작성한다.\n-현장을 지원한다.\n-교육을 실시한다.\n... 기반으로 75로 평가","stability":"stability는 [농림어업시험원]\n-시험을 설계한다.\n-데이터를 수집한다.\n-분석을 실시한다.\n-기술을 개발한다.\n-결과를 평가한다.\n-보고서를 작성한다.\n-현장을 지원한다.\n-교육을 실시한다.\n... 기반으로 50로 평가","income":"income는 [농림어업시험원]\n-시험을 설계한다.\n-데이터를 수집한다.\n-분석을 실시한다.\n-기술을 개발한다.\n-결과를 평가한다.\n-보고서를 작성한다.\n-현장을 지원한다.\n-교육을 실시한다.\n... 기반으로 70로 평가","teamwork":"teamwork는 [농림어업시험원]\n-시험을 설계한다.\n-데이터를 수집한다.\n-분석을 실시한다.\n-기술을 개발한다.\n-결과를 평가한다.\n-보고서를 작성한다.\n-현장을 지원한다.\n-교육을 실시한다.\n... 기반으로 50로 평가","solo_deep":"solo_deep는 [농림어업시험원]\n-시험을 설계한다.\n-데이터를 수집한다.\n-분석을 실시한다.\n-기술을 개발한다.\n-결과를 평가한다.\n-보고서를 작성한다.\n-현장을 지원한다.\n-교육을 실시한다.\n... 기반으로 50로 평가","analytical":"analytical는 [농림어업시험원]\n-시험을 설계한다.\n-데이터를 수집한다.\n-분석을 실시한다.\n-기술을 개발한다.\n-결과를 평가한다.\n-보고서를 작성한다.\n-현장을 지원한다.\n-교육을 실시한다.\n... 기반으로 60로 평가","creative":"creative는 [농림어업시험원]\n-시험을 설계한다.\n-데이터를 수집한다.\n-분석을 실시한다.\n-기술을 개발한다.\n-결과를 평가한다.\n-보고서를 작성한다.\n-현장을 지원한다.\n-교육을 실시한다.\n... 기반으로 60로 평가","execution":"execution는 [농림어업시험원]\n-시험을 설계한다.\n-데이터를 수집한다.\n-분석을 실시한다.\n-기술을 개발한다.\n-결과를 평가한다.\n-보고서를 작성한다.\n-현장을 지원한다.\n-교육을 실시한다.\n... 기반으로 30로 평가","people_facing":"people_facing는 [농림어업시험원]\n-시험을 설계한다.\n-데이터를 수집한다.\n-분석을 실시한다.\n-기술을 개발한다.\n-결과를 평가한다.\n-보고서를 작성한다.\n-현장을 지원한다.\n-교육을 실시한다.\n... 기반으로 35로 평가","degree_required":"degree_required는 [농림어업시험원]\n-시험을 설계한다.\n-데이터를 수집한다.\n-분석을 실시한다.\n-기술을 개발한다.\n-결과를 평가한다.\n-보고서를 작성한다.\n-현장을 지원한다.\n-교육을 실시한다.\n... 기반으로 none로 평가","license_required":"license_required는 [농림어업시험원]\n-시험을 설계한다.\n-데이터를 수집한다.\n-분석을 실시한다.\n-기술을 개발한다.\n-결과를 평가한다.\n-보고서를 작성한다.\n-현장을 지원한다.\n-교육을 실시한다.\n... 기반으로 none로 평가"}'
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
  '176528342884033',
  '신용추심원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 70, 50,
  50, 50, 40, 40, 70, 75,
  'regular', 'none', 'none', 'partial',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [신용추심원]\n-채무자를 접촉한다.\n-상환 계획을 수립한다.\n-법적 절차를 안내한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-고객을 응대한다.\n-문제를 해결... 기반으로 50로 평가","growth":"growth는 [신용추심원]\n-채무자를 접촉한다.\n-상환 계획을 수립한다.\n-법적 절차를 안내한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-고객을 응대한다.\n-문제를 해결... 기반으로 50로 평가","stability":"stability는 [신용추심원]\n-채무자를 접촉한다.\n-상환 계획을 수립한다.\n-법적 절차를 안내한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-고객을 응대한다.\n-문제를 해결... 기반으로 70로 평가","income":"income는 [신용추심원]\n-채무자를 접촉한다.\n-상환 계획을 수립한다.\n-법적 절차를 안내한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-고객을 응대한다.\n-문제를 해결... 기반으로 50로 평가","teamwork":"teamwork는 [신용추심원]\n-채무자를 접촉한다.\n-상환 계획을 수립한다.\n-법적 절차를 안내한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-고객을 응대한다.\n-문제를 해결... 기반으로 50로 평가","solo_deep":"solo_deep는 [신용추심원]\n-채무자를 접촉한다.\n-상환 계획을 수립한다.\n-법적 절차를 안내한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-고객을 응대한다.\n-문제를 해결... 기반으로 50로 평가","analytical":"analytical는 [신용추심원]\n-채무자를 접촉한다.\n-상환 계획을 수립한다.\n-법적 절차를 안내한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-고객을 응대한다.\n-문제를 해결... 기반으로 40로 평가","creative":"creative는 [신용추심원]\n-채무자를 접촉한다.\n-상환 계획을 수립한다.\n-법적 절차를 안내한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-고객을 응대한다.\n-문제를 해결... 기반으로 40로 평가","execution":"execution는 [신용추심원]\n-채무자를 접촉한다.\n-상환 계획을 수립한다.\n-법적 절차를 안내한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-고객을 응대한다.\n-문제를 해결... 기반으로 70로 평가","people_facing":"people_facing는 [신용추심원]\n-채무자를 접촉한다.\n-상환 계획을 수립한다.\n-법적 절차를 안내한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-고객을 응대한다.\n-문제를 해결... 기반으로 75로 평가","degree_required":"degree_required는 [신용추심원]\n-채무자를 접촉한다.\n-상환 계획을 수립한다.\n-법적 절차를 안내한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-고객을 응대한다.\n-문제를 해결... 기반으로 none로 평가","license_required":"license_required는 [신용추심원]\n-채무자를 접촉한다.\n-상환 계획을 수립한다.\n-법적 절차를 안내한다.\n-기록을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-고객을 응대한다.\n-문제를 해결... 기반으로 none로 평가"}'
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
  '1765283483893926',
  '육아도우미',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 60, 50, 50,
  50, 50, 40, 40, 70, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [육아도우미]\n-아이를 돌본다.\n-식사를 준비한다.\n-청결을 유지한다.\n-놀이를 지원한다.\n-교육을 돕는다.\n-안전을 감독한다.\n-건강을 모니터링한다.\n-부모와 소통한다.\n-기록을... 기반으로 50로 평가","growth":"growth는 [육아도우미]\n-아이를 돌본다.\n-식사를 준비한다.\n-청결을 유지한다.\n-놀이를 지원한다.\n-교육을 돕는다.\n-안전을 감독한다.\n-건강을 모니터링한다.\n-부모와 소통한다.\n-기록을... 기반으로 60로 평가","stability":"stability는 [육아도우미]\n-아이를 돌본다.\n-식사를 준비한다.\n-청결을 유지한다.\n-놀이를 지원한다.\n-교육을 돕는다.\n-안전을 감독한다.\n-건강을 모니터링한다.\n-부모와 소통한다.\n-기록을... 기반으로 50로 평가","income":"income는 [육아도우미]\n-아이를 돌본다.\n-식사를 준비한다.\n-청결을 유지한다.\n-놀이를 지원한다.\n-교육을 돕는다.\n-안전을 감독한다.\n-건강을 모니터링한다.\n-부모와 소통한다.\n-기록을... 기반으로 50로 평가","teamwork":"teamwork는 [육아도우미]\n-아이를 돌본다.\n-식사를 준비한다.\n-청결을 유지한다.\n-놀이를 지원한다.\n-교육을 돕는다.\n-안전을 감독한다.\n-건강을 모니터링한다.\n-부모와 소통한다.\n-기록을... 기반으로 50로 평가","solo_deep":"solo_deep는 [육아도우미]\n-아이를 돌본다.\n-식사를 준비한다.\n-청결을 유지한다.\n-놀이를 지원한다.\n-교육을 돕는다.\n-안전을 감독한다.\n-건강을 모니터링한다.\n-부모와 소통한다.\n-기록을... 기반으로 50로 평가","analytical":"analytical는 [육아도우미]\n-아이를 돌본다.\n-식사를 준비한다.\n-청결을 유지한다.\n-놀이를 지원한다.\n-교육을 돕는다.\n-안전을 감독한다.\n-건강을 모니터링한다.\n-부모와 소통한다.\n-기록을... 기반으로 40로 평가","creative":"creative는 [육아도우미]\n-아이를 돌본다.\n-식사를 준비한다.\n-청결을 유지한다.\n-놀이를 지원한다.\n-교육을 돕는다.\n-안전을 감독한다.\n-건강을 모니터링한다.\n-부모와 소통한다.\n-기록을... 기반으로 40로 평가","execution":"execution는 [육아도우미]\n-아이를 돌본다.\n-식사를 준비한다.\n-청결을 유지한다.\n-놀이를 지원한다.\n-교육을 돕는다.\n-안전을 감독한다.\n-건강을 모니터링한다.\n-부모와 소통한다.\n-기록을... 기반으로 70로 평가","people_facing":"people_facing는 [육아도우미]\n-아이를 돌본다.\n-식사를 준비한다.\n-청결을 유지한다.\n-놀이를 지원한다.\n-교육을 돕는다.\n-안전을 감독한다.\n-건강을 모니터링한다.\n-부모와 소통한다.\n-기록을... 기반으로 50로 평가","degree_required":"degree_required는 [육아도우미]\n-아이를 돌본다.\n-식사를 준비한다.\n-청결을 유지한다.\n-놀이를 지원한다.\n-교육을 돕는다.\n-안전을 감독한다.\n-건강을 모니터링한다.\n-부모와 소통한다.\n-기록을... 기반으로 none로 평가","license_required":"license_required는 [육아도우미]\n-아이를 돌본다.\n-식사를 준비한다.\n-청결을 유지한다.\n-놀이를 지원한다.\n-교육을 돕는다.\n-안전을 감독한다.\n-건강을 모니터링한다.\n-부모와 소통한다.\n-기록을... 기반으로 none로 평가"}'
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
  '1765283477829404',
  '열차객실승무원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 60, 50, 50,
  50, 50, 50, 50, 50, 75,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [열차객실승무원]\n-승객을 안내한다.\n-티켓을 확인한다.\n-안전을 설명한다.\n-식음료를 제공한다.\n-청결을 유지한다.\n-응급 상황에 대응한다.\n-승객을 지원한다.\n-보고서를 작성한... 기반으로 50로 평가","growth":"growth는 [열차객실승무원]\n-승객을 안내한다.\n-티켓을 확인한다.\n-안전을 설명한다.\n-식음료를 제공한다.\n-청결을 유지한다.\n-응급 상황에 대응한다.\n-승객을 지원한다.\n-보고서를 작성한... 기반으로 60로 평가","stability":"stability는 [열차객실승무원]\n-승객을 안내한다.\n-티켓을 확인한다.\n-안전을 설명한다.\n-식음료를 제공한다.\n-청결을 유지한다.\n-응급 상황에 대응한다.\n-승객을 지원한다.\n-보고서를 작성한... 기반으로 50로 평가","income":"income는 [열차객실승무원]\n-승객을 안내한다.\n-티켓을 확인한다.\n-안전을 설명한다.\n-식음료를 제공한다.\n-청결을 유지한다.\n-응급 상황에 대응한다.\n-승객을 지원한다.\n-보고서를 작성한... 기반으로 50로 평가","teamwork":"teamwork는 [열차객실승무원]\n-승객을 안내한다.\n-티켓을 확인한다.\n-안전을 설명한다.\n-식음료를 제공한다.\n-청결을 유지한다.\n-응급 상황에 대응한다.\n-승객을 지원한다.\n-보고서를 작성한... 기반으로 50로 평가","solo_deep":"solo_deep는 [열차객실승무원]\n-승객을 안내한다.\n-티켓을 확인한다.\n-안전을 설명한다.\n-식음료를 제공한다.\n-청결을 유지한다.\n-응급 상황에 대응한다.\n-승객을 지원한다.\n-보고서를 작성한... 기반으로 50로 평가","analytical":"analytical는 [열차객실승무원]\n-승객을 안내한다.\n-티켓을 확인한다.\n-안전을 설명한다.\n-식음료를 제공한다.\n-청결을 유지한다.\n-응급 상황에 대응한다.\n-승객을 지원한다.\n-보고서를 작성한... 기반으로 50로 평가","creative":"creative는 [열차객실승무원]\n-승객을 안내한다.\n-티켓을 확인한다.\n-안전을 설명한다.\n-식음료를 제공한다.\n-청결을 유지한다.\n-응급 상황에 대응한다.\n-승객을 지원한다.\n-보고서를 작성한... 기반으로 50로 평가","execution":"execution는 [열차객실승무원]\n-승객을 안내한다.\n-티켓을 확인한다.\n-안전을 설명한다.\n-식음료를 제공한다.\n-청결을 유지한다.\n-응급 상황에 대응한다.\n-승객을 지원한다.\n-보고서를 작성한... 기반으로 50로 평가","people_facing":"people_facing는 [열차객실승무원]\n-승객을 안내한다.\n-티켓을 확인한다.\n-안전을 설명한다.\n-식음료를 제공한다.\n-청결을 유지한다.\n-응급 상황에 대응한다.\n-승객을 지원한다.\n-보고서를 작성한... 기반으로 75로 평가","degree_required":"degree_required는 [열차객실승무원]\n-승객을 안내한다.\n-티켓을 확인한다.\n-안전을 설명한다.\n-식음료를 제공한다.\n-청결을 유지한다.\n-응급 상황에 대응한다.\n-승객을 지원한다.\n-보고서를 작성한... 기반으로 none로 평가","license_required":"license_required는 [열차객실승무원]\n-승객을 안내한다.\n-티켓을 확인한다.\n-안전을 설명한다.\n-식음료를 제공한다.\n-청결을 유지한다.\n-응급 상황에 대응한다.\n-승객을 지원한다.\n-보고서를 작성한... 기반으로 none로 평가"}'
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