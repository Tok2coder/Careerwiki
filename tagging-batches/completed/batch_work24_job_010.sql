-- Batch tagging SQL generated at 2026-01-06T07:05:59.430Z
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
  '1765283465677930',
  '한약사',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 70,
  50, 50, 60, 30, 60, 50,
  'regular', 'none', 'none', 'none',
  'phd', 'required', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [한약사]\n-한약을 조제한다.\n-약재를 검토한다.\n-처방을 분석한다.\n-약을 분쇄한다.\n-탕약을 달인다.\n-포장을 한다.\n-복용법을 설명한다.\n-부작용을 모니터링한다.\n-기록을 관... 기반으로 50로 평가","growth":"growth는 [한약사]\n-한약을 조제한다.\n-약재를 검토한다.\n-처방을 분석한다.\n-약을 분쇄한다.\n-탕약을 달인다.\n-포장을 한다.\n-복용법을 설명한다.\n-부작용을 모니터링한다.\n-기록을 관... 기반으로 50로 평가","stability":"stability는 [한약사]\n-한약을 조제한다.\n-약재를 검토한다.\n-처방을 분석한다.\n-약을 분쇄한다.\n-탕약을 달인다.\n-포장을 한다.\n-복용법을 설명한다.\n-부작용을 모니터링한다.\n-기록을 관... 기반으로 50로 평가","income":"income는 [한약사]\n-한약을 조제한다.\n-약재를 검토한다.\n-처방을 분석한다.\n-약을 분쇄한다.\n-탕약을 달인다.\n-포장을 한다.\n-복용법을 설명한다.\n-부작용을 모니터링한다.\n-기록을 관... 기반으로 70로 평가","teamwork":"teamwork는 [한약사]\n-한약을 조제한다.\n-약재를 검토한다.\n-처방을 분석한다.\n-약을 분쇄한다.\n-탕약을 달인다.\n-포장을 한다.\n-복용법을 설명한다.\n-부작용을 모니터링한다.\n-기록을 관... 기반으로 50로 평가","solo_deep":"solo_deep는 [한약사]\n-한약을 조제한다.\n-약재를 검토한다.\n-처방을 분석한다.\n-약을 분쇄한다.\n-탕약을 달인다.\n-포장을 한다.\n-복용법을 설명한다.\n-부작용을 모니터링한다.\n-기록을 관... 기반으로 50로 평가","analytical":"analytical는 [한약사]\n-한약을 조제한다.\n-약재를 검토한다.\n-처방을 분석한다.\n-약을 분쇄한다.\n-탕약을 달인다.\n-포장을 한다.\n-복용법을 설명한다.\n-부작용을 모니터링한다.\n-기록을 관... 기반으로 60로 평가","creative":"creative는 [한약사]\n-한약을 조제한다.\n-약재를 검토한다.\n-처방을 분석한다.\n-약을 분쇄한다.\n-탕약을 달인다.\n-포장을 한다.\n-복용법을 설명한다.\n-부작용을 모니터링한다.\n-기록을 관... 기반으로 30로 평가","execution":"execution는 [한약사]\n-한약을 조제한다.\n-약재를 검토한다.\n-처방을 분석한다.\n-약을 분쇄한다.\n-탕약을 달인다.\n-포장을 한다.\n-복용법을 설명한다.\n-부작용을 모니터링한다.\n-기록을 관... 기반으로 60로 평가","people_facing":"people_facing는 [한약사]\n-한약을 조제한다.\n-약재를 검토한다.\n-처방을 분석한다.\n-약을 분쇄한다.\n-탕약을 달인다.\n-포장을 한다.\n-복용법을 설명한다.\n-부작용을 모니터링한다.\n-기록을 관... 기반으로 50로 평가","degree_required":"degree_required는 [한약사]\n-한약을 조제한다.\n-약재를 검토한다.\n-처방을 분석한다.\n-약을 분쇄한다.\n-탕약을 달인다.\n-포장을 한다.\n-복용법을 설명한다.\n-부작용을 모니터링한다.\n-기록을 관... 기반으로 phd로 평가","license_required":"license_required는 [한약사]\n-한약을 조제한다.\n-약재를 검토한다.\n-처방을 분석한다.\n-약을 분쇄한다.\n-탕약을 달인다.\n-포장을 한다.\n-복용법을 설명한다.\n-부작용을 모니터링한다.\n-기록을 관... 기반으로 required로 평가"}'
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
  '176528346597017',
  '보건교사',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 60, 50, 50,
  50, 50, 40, 40, 70, 75,
  'regular', 'none', 'none', 'none',
  'bachelor', 'required', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [보건교사]\n-보건 교육을 실시한다.\n-학생 건강을 관리한다.\n-응급 처치를 한다.\n-건강 검진을 감독한다.\n-질병 예방을 교육한다.\n-상담을 진행한다.\n-의료 기록을 관리한다.\n... 기반으로 50로 평가","growth":"growth는 [보건교사]\n-보건 교육을 실시한다.\n-학생 건강을 관리한다.\n-응급 처치를 한다.\n-건강 검진을 감독한다.\n-질병 예방을 교육한다.\n-상담을 진행한다.\n-의료 기록을 관리한다.\n... 기반으로 60로 평가","stability":"stability는 [보건교사]\n-보건 교육을 실시한다.\n-학생 건강을 관리한다.\n-응급 처치를 한다.\n-건강 검진을 감독한다.\n-질병 예방을 교육한다.\n-상담을 진행한다.\n-의료 기록을 관리한다.\n... 기반으로 50로 평가","income":"income는 [보건교사]\n-보건 교육을 실시한다.\n-학생 건강을 관리한다.\n-응급 처치를 한다.\n-건강 검진을 감독한다.\n-질병 예방을 교육한다.\n-상담을 진행한다.\n-의료 기록을 관리한다.\n... 기반으로 50로 평가","teamwork":"teamwork는 [보건교사]\n-보건 교육을 실시한다.\n-학생 건강을 관리한다.\n-응급 처치를 한다.\n-건강 검진을 감독한다.\n-질병 예방을 교육한다.\n-상담을 진행한다.\n-의료 기록을 관리한다.\n... 기반으로 50로 평가","solo_deep":"solo_deep는 [보건교사]\n-보건 교육을 실시한다.\n-학생 건강을 관리한다.\n-응급 처치를 한다.\n-건강 검진을 감독한다.\n-질병 예방을 교육한다.\n-상담을 진행한다.\n-의료 기록을 관리한다.\n... 기반으로 50로 평가","analytical":"analytical는 [보건교사]\n-보건 교육을 실시한다.\n-학생 건강을 관리한다.\n-응급 처치를 한다.\n-건강 검진을 감독한다.\n-질병 예방을 교육한다.\n-상담을 진행한다.\n-의료 기록을 관리한다.\n... 기반으로 40로 평가","creative":"creative는 [보건교사]\n-보건 교육을 실시한다.\n-학생 건강을 관리한다.\n-응급 처치를 한다.\n-건강 검진을 감독한다.\n-질병 예방을 교육한다.\n-상담을 진행한다.\n-의료 기록을 관리한다.\n... 기반으로 40로 평가","execution":"execution는 [보건교사]\n-보건 교육을 실시한다.\n-학생 건강을 관리한다.\n-응급 처치를 한다.\n-건강 검진을 감독한다.\n-질병 예방을 교육한다.\n-상담을 진행한다.\n-의료 기록을 관리한다.\n... 기반으로 70로 평가","people_facing":"people_facing는 [보건교사]\n-보건 교육을 실시한다.\n-학생 건강을 관리한다.\n-응급 처치를 한다.\n-건강 검진을 감독한다.\n-질병 예방을 교육한다.\n-상담을 진행한다.\n-의료 기록을 관리한다.\n... 기반으로 75로 평가","degree_required":"degree_required는 [보건교사]\n-보건 교육을 실시한다.\n-학생 건강을 관리한다.\n-응급 처치를 한다.\n-건강 검진을 감독한다.\n-질병 예방을 교육한다.\n-상담을 진행한다.\n-의료 기록을 관리한다.\n... 기반으로 bachelor로 평가","license_required":"license_required는 [보건교사]\n-보건 교육을 실시한다.\n-학생 건강을 관리한다.\n-응급 처치를 한다.\n-건강 검진을 감독한다.\n-질병 예방을 교육한다.\n-상담을 진행한다.\n-의료 기록을 관리한다.\n... 기반으로 required로 평가"}'
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
  '1765283423754295',
  '고객상담원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 60, 50, 50,
  50, 50, 60, 30, 60, 75,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [고객상담원]\n-고객 문의를 접수한다.\n-질문에 답변한다.\n-불만을 해결한다.\n-정보를 제공한다.\n-주문을 처리한다.\n-기록을 관리한다.\n-피드백을 수집한다.\n-서비스 품질을 유지... 기반으로 50로 평가","growth":"growth는 [고객상담원]\n-고객 문의를 접수한다.\n-질문에 답변한다.\n-불만을 해결한다.\n-정보를 제공한다.\n-주문을 처리한다.\n-기록을 관리한다.\n-피드백을 수집한다.\n-서비스 품질을 유지... 기반으로 60로 평가","stability":"stability는 [고객상담원]\n-고객 문의를 접수한다.\n-질문에 답변한다.\n-불만을 해결한다.\n-정보를 제공한다.\n-주문을 처리한다.\n-기록을 관리한다.\n-피드백을 수집한다.\n-서비스 품질을 유지... 기반으로 50로 평가","income":"income는 [고객상담원]\n-고객 문의를 접수한다.\n-질문에 답변한다.\n-불만을 해결한다.\n-정보를 제공한다.\n-주문을 처리한다.\n-기록을 관리한다.\n-피드백을 수집한다.\n-서비스 품질을 유지... 기반으로 50로 평가","teamwork":"teamwork는 [고객상담원]\n-고객 문의를 접수한다.\n-질문에 답변한다.\n-불만을 해결한다.\n-정보를 제공한다.\n-주문을 처리한다.\n-기록을 관리한다.\n-피드백을 수집한다.\n-서비스 품질을 유지... 기반으로 50로 평가","solo_deep":"solo_deep는 [고객상담원]\n-고객 문의를 접수한다.\n-질문에 답변한다.\n-불만을 해결한다.\n-정보를 제공한다.\n-주문을 처리한다.\n-기록을 관리한다.\n-피드백을 수집한다.\n-서비스 품질을 유지... 기반으로 50로 평가","analytical":"analytical는 [고객상담원]\n-고객 문의를 접수한다.\n-질문에 답변한다.\n-불만을 해결한다.\n-정보를 제공한다.\n-주문을 처리한다.\n-기록을 관리한다.\n-피드백을 수집한다.\n-서비스 품질을 유지... 기반으로 60로 평가","creative":"creative는 [고객상담원]\n-고객 문의를 접수한다.\n-질문에 답변한다.\n-불만을 해결한다.\n-정보를 제공한다.\n-주문을 처리한다.\n-기록을 관리한다.\n-피드백을 수집한다.\n-서비스 품질을 유지... 기반으로 30로 평가","execution":"execution는 [고객상담원]\n-고객 문의를 접수한다.\n-질문에 답변한다.\n-불만을 해결한다.\n-정보를 제공한다.\n-주문을 처리한다.\n-기록을 관리한다.\n-피드백을 수집한다.\n-서비스 품질을 유지... 기반으로 60로 평가","people_facing":"people_facing는 [고객상담원]\n-고객 문의를 접수한다.\n-질문에 답변한다.\n-불만을 해결한다.\n-정보를 제공한다.\n-주문을 처리한다.\n-기록을 관리한다.\n-피드백을 수집한다.\n-서비스 품질을 유지... 기반으로 75로 평가","degree_required":"degree_required는 [고객상담원]\n-고객 문의를 접수한다.\n-질문에 답변한다.\n-불만을 해결한다.\n-정보를 제공한다.\n-주문을 처리한다.\n-기록을 관리한다.\n-피드백을 수집한다.\n-서비스 품질을 유지... 기반으로 none로 평가","license_required":"license_required는 [고객상담원]\n-고객 문의를 접수한다.\n-질문에 답변한다.\n-불만을 해결한다.\n-정보를 제공한다.\n-주문을 처리한다.\n-기록을 관리한다.\n-피드백을 수집한다.\n-서비스 품질을 유지... 기반으로 none로 평가"}'
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
  '1765283416155964',
  '병무행정사무원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  50, 50, 40, 40, 70, 75,
  'regular', 'none', 'none', 'none',
  'bachelor', 'required', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [병무행정사무원]\n-병역 신청을 접수한다.\n-서류를 검토한다.\n-면접을 진행한다.\n-병역 처분을 결정한다.\n-기록을 관리한다.\n-상담을 제공한다.\n-법규를 준수한다.\n-보고서를 작... 기반으로 50로 평가","growth":"growth는 [병무행정사무원]\n-병역 신청을 접수한다.\n-서류를 검토한다.\n-면접을 진행한다.\n-병역 처분을 결정한다.\n-기록을 관리한다.\n-상담을 제공한다.\n-법규를 준수한다.\n-보고서를 작... 기반으로 50로 평가","stability":"stability는 [병무행정사무원]\n-병역 신청을 접수한다.\n-서류를 검토한다.\n-면접을 진행한다.\n-병역 처분을 결정한다.\n-기록을 관리한다.\n-상담을 제공한다.\n-법규를 준수한다.\n-보고서를 작... 기반으로 50로 평가","income":"income는 [병무행정사무원]\n-병역 신청을 접수한다.\n-서류를 검토한다.\n-면접을 진행한다.\n-병역 처분을 결정한다.\n-기록을 관리한다.\n-상담을 제공한다.\n-법규를 준수한다.\n-보고서를 작... 기반으로 50로 평가","teamwork":"teamwork는 [병무행정사무원]\n-병역 신청을 접수한다.\n-서류를 검토한다.\n-면접을 진행한다.\n-병역 처분을 결정한다.\n-기록을 관리한다.\n-상담을 제공한다.\n-법규를 준수한다.\n-보고서를 작... 기반으로 50로 평가","solo_deep":"solo_deep는 [병무행정사무원]\n-병역 신청을 접수한다.\n-서류를 검토한다.\n-면접을 진행한다.\n-병역 처분을 결정한다.\n-기록을 관리한다.\n-상담을 제공한다.\n-법규를 준수한다.\n-보고서를 작... 기반으로 50로 평가","analytical":"analytical는 [병무행정사무원]\n-병역 신청을 접수한다.\n-서류를 검토한다.\n-면접을 진행한다.\n-병역 처분을 결정한다.\n-기록을 관리한다.\n-상담을 제공한다.\n-법규를 준수한다.\n-보고서를 작... 기반으로 40로 평가","creative":"creative는 [병무행정사무원]\n-병역 신청을 접수한다.\n-서류를 검토한다.\n-면접을 진행한다.\n-병역 처분을 결정한다.\n-기록을 관리한다.\n-상담을 제공한다.\n-법규를 준수한다.\n-보고서를 작... 기반으로 40로 평가","execution":"execution는 [병무행정사무원]\n-병역 신청을 접수한다.\n-서류를 검토한다.\n-면접을 진행한다.\n-병역 처분을 결정한다.\n-기록을 관리한다.\n-상담을 제공한다.\n-법규를 준수한다.\n-보고서를 작... 기반으로 70로 평가","people_facing":"people_facing는 [병무행정사무원]\n-병역 신청을 접수한다.\n-서류를 검토한다.\n-면접을 진행한다.\n-병역 처분을 결정한다.\n-기록을 관리한다.\n-상담을 제공한다.\n-법규를 준수한다.\n-보고서를 작... 기반으로 75로 평가","degree_required":"degree_required는 [병무행정사무원]\n-병역 신청을 접수한다.\n-서류를 검토한다.\n-면접을 진행한다.\n-병역 처분을 결정한다.\n-기록을 관리한다.\n-상담을 제공한다.\n-법규를 준수한다.\n-보고서를 작... 기반으로 bachelor로 평가","license_required":"license_required는 [병무행정사무원]\n-병역 신청을 접수한다.\n-서류를 검토한다.\n-면접을 진행한다.\n-병역 처분을 결정한다.\n-기록을 관리한다.\n-상담을 제공한다.\n-법규를 준수한다.\n-보고서를 작... 기반으로 required로 평가"}'
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
  '1765283484278463',
  '세탁원(다림질원)',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  70, 30, 40, 40, 70, 75,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [세탁원]\n-의류를 분류한다.\n-세탁을 실시한다.\n-세제를 사용한다.\n-세탁기를 운영한다.\n-건조를 한다.\n-다림질을 한다.\n-포장을 한다.\n-고객을 응대한다.\n-품질을 검사한다.... 기반으로 50로 평가","growth":"growth는 [세탁원]\n-의류를 분류한다.\n-세탁을 실시한다.\n-세제를 사용한다.\n-세탁기를 운영한다.\n-건조를 한다.\n-다림질을 한다.\n-포장을 한다.\n-고객을 응대한다.\n-품질을 검사한다.... 기반으로 50로 평가","stability":"stability는 [세탁원]\n-의류를 분류한다.\n-세탁을 실시한다.\n-세제를 사용한다.\n-세탁기를 운영한다.\n-건조를 한다.\n-다림질을 한다.\n-포장을 한다.\n-고객을 응대한다.\n-품질을 검사한다.... 기반으로 50로 평가","income":"income는 [세탁원]\n-의류를 분류한다.\n-세탁을 실시한다.\n-세제를 사용한다.\n-세탁기를 운영한다.\n-건조를 한다.\n-다림질을 한다.\n-포장을 한다.\n-고객을 응대한다.\n-품질을 검사한다.... 기반으로 50로 평가","teamwork":"teamwork는 [세탁원]\n-의류를 분류한다.\n-세탁을 실시한다.\n-세제를 사용한다.\n-세탁기를 운영한다.\n-건조를 한다.\n-다림질을 한다.\n-포장을 한다.\n-고객을 응대한다.\n-품질을 검사한다.... 기반으로 70로 평가","solo_deep":"solo_deep는 [세탁원]\n-의류를 분류한다.\n-세탁을 실시한다.\n-세제를 사용한다.\n-세탁기를 운영한다.\n-건조를 한다.\n-다림질을 한다.\n-포장을 한다.\n-고객을 응대한다.\n-품질을 검사한다.... 기반으로 30로 평가","analytical":"analytical는 [세탁원]\n-의류를 분류한다.\n-세탁을 실시한다.\n-세제를 사용한다.\n-세탁기를 운영한다.\n-건조를 한다.\n-다림질을 한다.\n-포장을 한다.\n-고객을 응대한다.\n-품질을 검사한다.... 기반으로 40로 평가","creative":"creative는 [세탁원]\n-의류를 분류한다.\n-세탁을 실시한다.\n-세제를 사용한다.\n-세탁기를 운영한다.\n-건조를 한다.\n-다림질을 한다.\n-포장을 한다.\n-고객을 응대한다.\n-품질을 검사한다.... 기반으로 40로 평가","execution":"execution는 [세탁원]\n-의류를 분류한다.\n-세탁을 실시한다.\n-세제를 사용한다.\n-세탁기를 운영한다.\n-건조를 한다.\n-다림질을 한다.\n-포장을 한다.\n-고객을 응대한다.\n-품질을 검사한다.... 기반으로 70로 평가","people_facing":"people_facing는 [세탁원]\n-의류를 분류한다.\n-세탁을 실시한다.\n-세제를 사용한다.\n-세탁기를 운영한다.\n-건조를 한다.\n-다림질을 한다.\n-포장을 한다.\n-고객을 응대한다.\n-품질을 검사한다.... 기반으로 75로 평가","degree_required":"degree_required는 [세탁원]\n-의류를 분류한다.\n-세탁을 실시한다.\n-세제를 사용한다.\n-세탁기를 운영한다.\n-건조를 한다.\n-다림질을 한다.\n-포장을 한다.\n-고객을 응대한다.\n-품질을 검사한다.... 기반으로 none로 평가","license_required":"license_required는 [세탁원]\n-의류를 분류한다.\n-세탁을 실시한다.\n-세제를 사용한다.\n-세탁기를 운영한다.\n-건조를 한다.\n-다림질을 한다.\n-포장을 한다.\n-고객을 응대한다.\n-품질을 검사한다.... 기반으로 none로 평가"}'
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
  '1765283433280884',
  '의학연구원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 50, 70,
  70, 30, 60, 60, 30, 35,
  'regular', 'none', 'none', 'none',
  'master', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [의학연구원]\n-의학 연구를 수행한다.\n-임상 시험을 설계한다.\n-데이터를 수집한다.\n-분석을 실시한다.\n-논문을 작성한다.\n-치료법을 개발한다.\n-약물을 연구한다.\n-윤리적 문제... 기반으로 50로 평가","growth":"growth는 [의학연구원]\n-의학 연구를 수행한다.\n-임상 시험을 설계한다.\n-데이터를 수집한다.\n-분석을 실시한다.\n-논문을 작성한다.\n-치료법을 개발한다.\n-약물을 연구한다.\n-윤리적 문제... 기반으로 65로 평가","stability":"stability는 [의학연구원]\n-의학 연구를 수행한다.\n-임상 시험을 설계한다.\n-데이터를 수집한다.\n-분석을 실시한다.\n-논문을 작성한다.\n-치료법을 개발한다.\n-약물을 연구한다.\n-윤리적 문제... 기반으로 50로 평가","income":"income는 [의학연구원]\n-의학 연구를 수행한다.\n-임상 시험을 설계한다.\n-데이터를 수집한다.\n-분석을 실시한다.\n-논문을 작성한다.\n-치료법을 개발한다.\n-약물을 연구한다.\n-윤리적 문제... 기반으로 70로 평가","teamwork":"teamwork는 [의학연구원]\n-의학 연구를 수행한다.\n-임상 시험을 설계한다.\n-데이터를 수집한다.\n-분석을 실시한다.\n-논문을 작성한다.\n-치료법을 개발한다.\n-약물을 연구한다.\n-윤리적 문제... 기반으로 70로 평가","solo_deep":"solo_deep는 [의학연구원]\n-의학 연구를 수행한다.\n-임상 시험을 설계한다.\n-데이터를 수집한다.\n-분석을 실시한다.\n-논문을 작성한다.\n-치료법을 개발한다.\n-약물을 연구한다.\n-윤리적 문제... 기반으로 30로 평가","analytical":"analytical는 [의학연구원]\n-의학 연구를 수행한다.\n-임상 시험을 설계한다.\n-데이터를 수집한다.\n-분석을 실시한다.\n-논문을 작성한다.\n-치료법을 개발한다.\n-약물을 연구한다.\n-윤리적 문제... 기반으로 60로 평가","creative":"creative는 [의학연구원]\n-의학 연구를 수행한다.\n-임상 시험을 설계한다.\n-데이터를 수집한다.\n-분석을 실시한다.\n-논문을 작성한다.\n-치료법을 개발한다.\n-약물을 연구한다.\n-윤리적 문제... 기반으로 60로 평가","execution":"execution는 [의학연구원]\n-의학 연구를 수행한다.\n-임상 시험을 설계한다.\n-데이터를 수집한다.\n-분석을 실시한다.\n-논문을 작성한다.\n-치료법을 개발한다.\n-약물을 연구한다.\n-윤리적 문제... 기반으로 30로 평가","people_facing":"people_facing는 [의학연구원]\n-의학 연구를 수행한다.\n-임상 시험을 설계한다.\n-데이터를 수집한다.\n-분석을 실시한다.\n-논문을 작성한다.\n-치료법을 개발한다.\n-약물을 연구한다.\n-윤리적 문제... 기반으로 35로 평가","degree_required":"degree_required는 [의학연구원]\n-의학 연구를 수행한다.\n-임상 시험을 설계한다.\n-데이터를 수집한다.\n-분석을 실시한다.\n-논문을 작성한다.\n-치료법을 개발한다.\n-약물을 연구한다.\n-윤리적 문제... 기반으로 master로 평가","license_required":"license_required는 [의학연구원]\n-의학 연구를 수행한다.\n-임상 시험을 설계한다.\n-데이터를 수집한다.\n-분석을 실시한다.\n-논문을 작성한다.\n-치료법을 개발한다.\n-약물을 연구한다.\n-윤리적 문제... 기반으로 none로 평가"}'
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
  '1765283409874866',
  '예술·디자인·방송관리자',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 50, 40,
  70, 30, 50, 50, 50, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [예술관리자]\n-예술 프로젝트를 기획한다.\n-예술가를 관리한다.\n-예산을 수립한다.\n-프로모션을 진행한다.\n-전시를 감독한다.\n-관객을 관리한다.\n-협찬을 유치한다.\n-보고서를 작... 기반으로 50로 평가","growth":"growth는 [예술관리자]\n-예술 프로젝트를 기획한다.\n-예술가를 관리한다.\n-예산을 수립한다.\n-프로모션을 진행한다.\n-전시를 감독한다.\n-관객을 관리한다.\n-협찬을 유치한다.\n-보고서를 작... 기반으로 65로 평가","stability":"stability는 [예술관리자]\n-예술 프로젝트를 기획한다.\n-예술가를 관리한다.\n-예산을 수립한다.\n-프로모션을 진행한다.\n-전시를 감독한다.\n-관객을 관리한다.\n-협찬을 유치한다.\n-보고서를 작... 기반으로 50로 평가","income":"income는 [예술관리자]\n-예술 프로젝트를 기획한다.\n-예술가를 관리한다.\n-예산을 수립한다.\n-프로모션을 진행한다.\n-전시를 감독한다.\n-관객을 관리한다.\n-협찬을 유치한다.\n-보고서를 작... 기반으로 40로 평가","teamwork":"teamwork는 [예술관리자]\n-예술 프로젝트를 기획한다.\n-예술가를 관리한다.\n-예산을 수립한다.\n-프로모션을 진행한다.\n-전시를 감독한다.\n-관객을 관리한다.\n-협찬을 유치한다.\n-보고서를 작... 기반으로 70로 평가","solo_deep":"solo_deep는 [예술관리자]\n-예술 프로젝트를 기획한다.\n-예술가를 관리한다.\n-예산을 수립한다.\n-프로모션을 진행한다.\n-전시를 감독한다.\n-관객을 관리한다.\n-협찬을 유치한다.\n-보고서를 작... 기반으로 30로 평가","analytical":"analytical는 [예술관리자]\n-예술 프로젝트를 기획한다.\n-예술가를 관리한다.\n-예산을 수립한다.\n-프로모션을 진행한다.\n-전시를 감독한다.\n-관객을 관리한다.\n-협찬을 유치한다.\n-보고서를 작... 기반으로 50로 평가","creative":"creative는 [예술관리자]\n-예술 프로젝트를 기획한다.\n-예술가를 관리한다.\n-예산을 수립한다.\n-프로모션을 진행한다.\n-전시를 감독한다.\n-관객을 관리한다.\n-협찬을 유치한다.\n-보고서를 작... 기반으로 50로 평가","execution":"execution는 [예술관리자]\n-예술 프로젝트를 기획한다.\n-예술가를 관리한다.\n-예산을 수립한다.\n-프로모션을 진행한다.\n-전시를 감독한다.\n-관객을 관리한다.\n-협찬을 유치한다.\n-보고서를 작... 기반으로 50로 평가","people_facing":"people_facing는 [예술관리자]\n-예술 프로젝트를 기획한다.\n-예술가를 관리한다.\n-예산을 수립한다.\n-프로모션을 진행한다.\n-전시를 감독한다.\n-관객을 관리한다.\n-협찬을 유치한다.\n-보고서를 작... 기반으로 50로 평가","degree_required":"degree_required는 [예술관리자]\n-예술 프로젝트를 기획한다.\n-예술가를 관리한다.\n-예산을 수립한다.\n-프로모션을 진행한다.\n-전시를 감독한다.\n-관객을 관리한다.\n-협찬을 유치한다.\n-보고서를 작... 기반으로 none로 평가","license_required":"license_required는 [예술관리자]\n-예술 프로젝트를 기획한다.\n-예술가를 관리한다.\n-예산을 수립한다.\n-프로모션을 진행한다.\n-전시를 감독한다.\n-관객을 관리한다.\n-협찬을 유치한다.\n-보고서를 작... 기반으로 none로 평가"}'
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
  '1765283495454986',
  '건축석공',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  50, 50, 30, 60, 60, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [건축석공]\n-석재를 재단한다.\n-표면을 연마한다.\n-설치를 한다.\n-접합을 실시한다.\n-마무리를 한다.\n-품질을 검사한다.\n-안전 수칙을 준수한다.\n-도구를 관리한다.\n-디자인을... 기반으로 50로 평가","growth":"growth는 [건축석공]\n-석재를 재단한다.\n-표면을 연마한다.\n-설치를 한다.\n-접합을 실시한다.\n-마무리를 한다.\n-품질을 검사한다.\n-안전 수칙을 준수한다.\n-도구를 관리한다.\n-디자인을... 기반으로 50로 평가","stability":"stability는 [건축석공]\n-석재를 재단한다.\n-표면을 연마한다.\n-설치를 한다.\n-접합을 실시한다.\n-마무리를 한다.\n-품질을 검사한다.\n-안전 수칙을 준수한다.\n-도구를 관리한다.\n-디자인을... 기반으로 50로 평가","income":"income는 [건축석공]\n-석재를 재단한다.\n-표면을 연마한다.\n-설치를 한다.\n-접합을 실시한다.\n-마무리를 한다.\n-품질을 검사한다.\n-안전 수칙을 준수한다.\n-도구를 관리한다.\n-디자인을... 기반으로 50로 평가","teamwork":"teamwork는 [건축석공]\n-석재를 재단한다.\n-표면을 연마한다.\n-설치를 한다.\n-접합을 실시한다.\n-마무리를 한다.\n-품질을 검사한다.\n-안전 수칙을 준수한다.\n-도구를 관리한다.\n-디자인을... 기반으로 50로 평가","solo_deep":"solo_deep는 [건축석공]\n-석재를 재단한다.\n-표면을 연마한다.\n-설치를 한다.\n-접합을 실시한다.\n-마무리를 한다.\n-품질을 검사한다.\n-안전 수칙을 준수한다.\n-도구를 관리한다.\n-디자인을... 기반으로 50로 평가","analytical":"analytical는 [건축석공]\n-석재를 재단한다.\n-표면을 연마한다.\n-설치를 한다.\n-접합을 실시한다.\n-마무리를 한다.\n-품질을 검사한다.\n-안전 수칙을 준수한다.\n-도구를 관리한다.\n-디자인을... 기반으로 30로 평가","creative":"creative는 [건축석공]\n-석재를 재단한다.\n-표면을 연마한다.\n-설치를 한다.\n-접합을 실시한다.\n-마무리를 한다.\n-품질을 검사한다.\n-안전 수칙을 준수한다.\n-도구를 관리한다.\n-디자인을... 기반으로 60로 평가","execution":"execution는 [건축석공]\n-석재를 재단한다.\n-표면을 연마한다.\n-설치를 한다.\n-접합을 실시한다.\n-마무리를 한다.\n-품질을 검사한다.\n-안전 수칙을 준수한다.\n-도구를 관리한다.\n-디자인을... 기반으로 60로 평가","people_facing":"people_facing는 [건축석공]\n-석재를 재단한다.\n-표면을 연마한다.\n-설치를 한다.\n-접합을 실시한다.\n-마무리를 한다.\n-품질을 검사한다.\n-안전 수칙을 준수한다.\n-도구를 관리한다.\n-디자인을... 기반으로 50로 평가","degree_required":"degree_required는 [건축석공]\n-석재를 재단한다.\n-표면을 연마한다.\n-설치를 한다.\n-접합을 실시한다.\n-마무리를 한다.\n-품질을 검사한다.\n-안전 수칙을 준수한다.\n-도구를 관리한다.\n-디자인을... 기반으로 none로 평가","license_required":"license_required는 [건축석공]\n-석재를 재단한다.\n-표면을 연마한다.\n-설치를 한다.\n-접합을 실시한다.\n-마무리를 한다.\n-품질을 검사한다.\n-안전 수칙을 준수한다.\n-도구를 관리한다.\n-디자인을... 기반으로 none로 평가"}'
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
  '1765283423024989',
  '의료코디네이터',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 70,
  70, 30, 40, 40, 70, 75,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [의료코디네이터]\n-환자를 안내한다.\n-진료 일정을 조율한다.\n-서류를 준비한다.\n-보험을 처리한다.\n-통역을 지원한다.\n-상담을 진행한다.\n-문제를 해결한다.\n-기록을 관리한다.... 기반으로 50로 평가","growth":"growth는 [의료코디네이터]\n-환자를 안내한다.\n-진료 일정을 조율한다.\n-서류를 준비한다.\n-보험을 처리한다.\n-통역을 지원한다.\n-상담을 진행한다.\n-문제를 해결한다.\n-기록을 관리한다.... 기반으로 50로 평가","stability":"stability는 [의료코디네이터]\n-환자를 안내한다.\n-진료 일정을 조율한다.\n-서류를 준비한다.\n-보험을 처리한다.\n-통역을 지원한다.\n-상담을 진행한다.\n-문제를 해결한다.\n-기록을 관리한다.... 기반으로 50로 평가","income":"income는 [의료코디네이터]\n-환자를 안내한다.\n-진료 일정을 조율한다.\n-서류를 준비한다.\n-보험을 처리한다.\n-통역을 지원한다.\n-상담을 진행한다.\n-문제를 해결한다.\n-기록을 관리한다.... 기반으로 70로 평가","teamwork":"teamwork는 [의료코디네이터]\n-환자를 안내한다.\n-진료 일정을 조율한다.\n-서류를 준비한다.\n-보험을 처리한다.\n-통역을 지원한다.\n-상담을 진행한다.\n-문제를 해결한다.\n-기록을 관리한다.... 기반으로 70로 평가","solo_deep":"solo_deep는 [의료코디네이터]\n-환자를 안내한다.\n-진료 일정을 조율한다.\n-서류를 준비한다.\n-보험을 처리한다.\n-통역을 지원한다.\n-상담을 진행한다.\n-문제를 해결한다.\n-기록을 관리한다.... 기반으로 30로 평가","analytical":"analytical는 [의료코디네이터]\n-환자를 안내한다.\n-진료 일정을 조율한다.\n-서류를 준비한다.\n-보험을 처리한다.\n-통역을 지원한다.\n-상담을 진행한다.\n-문제를 해결한다.\n-기록을 관리한다.... 기반으로 40로 평가","creative":"creative는 [의료코디네이터]\n-환자를 안내한다.\n-진료 일정을 조율한다.\n-서류를 준비한다.\n-보험을 처리한다.\n-통역을 지원한다.\n-상담을 진행한다.\n-문제를 해결한다.\n-기록을 관리한다.... 기반으로 40로 평가","execution":"execution는 [의료코디네이터]\n-환자를 안내한다.\n-진료 일정을 조율한다.\n-서류를 준비한다.\n-보험을 처리한다.\n-통역을 지원한다.\n-상담을 진행한다.\n-문제를 해결한다.\n-기록을 관리한다.... 기반으로 70로 평가","people_facing":"people_facing는 [의료코디네이터]\n-환자를 안내한다.\n-진료 일정을 조율한다.\n-서류를 준비한다.\n-보험을 처리한다.\n-통역을 지원한다.\n-상담을 진행한다.\n-문제를 해결한다.\n-기록을 관리한다.... 기반으로 75로 평가","degree_required":"degree_required는 [의료코디네이터]\n-환자를 안내한다.\n-진료 일정을 조율한다.\n-서류를 준비한다.\n-보험을 처리한다.\n-통역을 지원한다.\n-상담을 진행한다.\n-문제를 해결한다.\n-기록을 관리한다.... 기반으로 none로 평가","license_required":"license_required는 [의료코디네이터]\n-환자를 안내한다.\n-진료 일정을 조율한다.\n-서류를 준비한다.\n-보험을 처리한다.\n-통역을 지원한다.\n-상담을 진행한다.\n-문제를 해결한다.\n-기록을 관리한다.... 기반으로 none로 평가"}'
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
  '1765283494168126',
  '철골공(강구조물건립원)',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 50, 50,
  50, 50, 40, 40, 70, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [철골공]\n-철골 구조를 설계한다.\n-재료를 준비한다.\n-용접을 실시한다.\n-조립을 한다.\n-설치를 진행한다.\n-안전 검사를 한다.\n-마무리를 한다.\n-유지보수를 한다.\n-안전 수... 기반으로 50로 평가","growth":"growth는 [철골공]\n-철골 구조를 설계한다.\n-재료를 준비한다.\n-용접을 실시한다.\n-조립을 한다.\n-설치를 진행한다.\n-안전 검사를 한다.\n-마무리를 한다.\n-유지보수를 한다.\n-안전 수... 기반으로 65로 평가","stability":"stability는 [철골공]\n-철골 구조를 설계한다.\n-재료를 준비한다.\n-용접을 실시한다.\n-조립을 한다.\n-설치를 진행한다.\n-안전 검사를 한다.\n-마무리를 한다.\n-유지보수를 한다.\n-안전 수... 기반으로 50로 평가","income":"income는 [철골공]\n-철골 구조를 설계한다.\n-재료를 준비한다.\n-용접을 실시한다.\n-조립을 한다.\n-설치를 진행한다.\n-안전 검사를 한다.\n-마무리를 한다.\n-유지보수를 한다.\n-안전 수... 기반으로 50로 평가","teamwork":"teamwork는 [철골공]\n-철골 구조를 설계한다.\n-재료를 준비한다.\n-용접을 실시한다.\n-조립을 한다.\n-설치를 진행한다.\n-안전 검사를 한다.\n-마무리를 한다.\n-유지보수를 한다.\n-안전 수... 기반으로 50로 평가","solo_deep":"solo_deep는 [철골공]\n-철골 구조를 설계한다.\n-재료를 준비한다.\n-용접을 실시한다.\n-조립을 한다.\n-설치를 진행한다.\n-안전 검사를 한다.\n-마무리를 한다.\n-유지보수를 한다.\n-안전 수... 기반으로 50로 평가","analytical":"analytical는 [철골공]\n-철골 구조를 설계한다.\n-재료를 준비한다.\n-용접을 실시한다.\n-조립을 한다.\n-설치를 진행한다.\n-안전 검사를 한다.\n-마무리를 한다.\n-유지보수를 한다.\n-안전 수... 기반으로 40로 평가","creative":"creative는 [철골공]\n-철골 구조를 설계한다.\n-재료를 준비한다.\n-용접을 실시한다.\n-조립을 한다.\n-설치를 진행한다.\n-안전 검사를 한다.\n-마무리를 한다.\n-유지보수를 한다.\n-안전 수... 기반으로 40로 평가","execution":"execution는 [철골공]\n-철골 구조를 설계한다.\n-재료를 준비한다.\n-용접을 실시한다.\n-조립을 한다.\n-설치를 진행한다.\n-안전 검사를 한다.\n-마무리를 한다.\n-유지보수를 한다.\n-안전 수... 기반으로 70로 평가","people_facing":"people_facing는 [철골공]\n-철골 구조를 설계한다.\n-재료를 준비한다.\n-용접을 실시한다.\n-조립을 한다.\n-설치를 진행한다.\n-안전 검사를 한다.\n-마무리를 한다.\n-유지보수를 한다.\n-안전 수... 기반으로 50로 평가","degree_required":"degree_required는 [철골공]\n-철골 구조를 설계한다.\n-재료를 준비한다.\n-용접을 실시한다.\n-조립을 한다.\n-설치를 진행한다.\n-안전 검사를 한다.\n-마무리를 한다.\n-유지보수를 한다.\n-안전 수... 기반으로 none로 평가","license_required":"license_required는 [철골공]\n-철골 구조를 설계한다.\n-재료를 준비한다.\n-용접을 실시한다.\n-조립을 한다.\n-설치를 진행한다.\n-안전 검사를 한다.\n-마무리를 한다.\n-유지보수를 한다.\n-안전 수... 기반으로 none로 평가"}'
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