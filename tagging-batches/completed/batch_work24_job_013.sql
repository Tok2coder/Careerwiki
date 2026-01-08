-- Batch tagging SQL generated at 2026-01-06T07:09:41.249Z
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
  '1765283415778123',
  '법원공무원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  50, 50, 40, 40, 70, 75,
  'regular', 'none', 'none', 'none',
  'none', 'required', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [법원공무원]\n-법원 업무를 지원한다.\n-서류를 관리한다.\n-재판을 준비한다.\n-기록을 유지한다.\n-안내를 제공한다.\n-법규를 준수한다.\n-보고서를 작성한다.\n-시스템을 운영한다.... 기반으로 50로 평가","growth":"growth는 [법원공무원]\n-법원 업무를 지원한다.\n-서류를 관리한다.\n-재판을 준비한다.\n-기록을 유지한다.\n-안내를 제공한다.\n-법규를 준수한다.\n-보고서를 작성한다.\n-시스템을 운영한다.... 기반으로 50로 평가","stability":"stability는 [법원공무원]\n-법원 업무를 지원한다.\n-서류를 관리한다.\n-재판을 준비한다.\n-기록을 유지한다.\n-안내를 제공한다.\n-법규를 준수한다.\n-보고서를 작성한다.\n-시스템을 운영한다.... 기반으로 50로 평가","income":"income는 [법원공무원]\n-법원 업무를 지원한다.\n-서류를 관리한다.\n-재판을 준비한다.\n-기록을 유지한다.\n-안내를 제공한다.\n-법규를 준수한다.\n-보고서를 작성한다.\n-시스템을 운영한다.... 기반으로 50로 평가","teamwork":"teamwork는 [법원공무원]\n-법원 업무를 지원한다.\n-서류를 관리한다.\n-재판을 준비한다.\n-기록을 유지한다.\n-안내를 제공한다.\n-법규를 준수한다.\n-보고서를 작성한다.\n-시스템을 운영한다.... 기반으로 50로 평가","solo_deep":"solo_deep는 [법원공무원]\n-법원 업무를 지원한다.\n-서류를 관리한다.\n-재판을 준비한다.\n-기록을 유지한다.\n-안내를 제공한다.\n-법규를 준수한다.\n-보고서를 작성한다.\n-시스템을 운영한다.... 기반으로 50로 평가","analytical":"analytical는 [법원공무원]\n-법원 업무를 지원한다.\n-서류를 관리한다.\n-재판을 준비한다.\n-기록을 유지한다.\n-안내를 제공한다.\n-법규를 준수한다.\n-보고서를 작성한다.\n-시스템을 운영한다.... 기반으로 40로 평가","creative":"creative는 [법원공무원]\n-법원 업무를 지원한다.\n-서류를 관리한다.\n-재판을 준비한다.\n-기록을 유지한다.\n-안내를 제공한다.\n-법규를 준수한다.\n-보고서를 작성한다.\n-시스템을 운영한다.... 기반으로 40로 평가","execution":"execution는 [법원공무원]\n-법원 업무를 지원한다.\n-서류를 관리한다.\n-재판을 준비한다.\n-기록을 유지한다.\n-안내를 제공한다.\n-법규를 준수한다.\n-보고서를 작성한다.\n-시스템을 운영한다.... 기반으로 70로 평가","people_facing":"people_facing는 [법원공무원]\n-법원 업무를 지원한다.\n-서류를 관리한다.\n-재판을 준비한다.\n-기록을 유지한다.\n-안내를 제공한다.\n-법규를 준수한다.\n-보고서를 작성한다.\n-시스템을 운영한다.... 기반으로 75로 평가","degree_required":"degree_required는 [법원공무원]\n-법원 업무를 지원한다.\n-서류를 관리한다.\n-재판을 준비한다.\n-기록을 유지한다.\n-안내를 제공한다.\n-법규를 준수한다.\n-보고서를 작성한다.\n-시스템을 운영한다.... 기반으로 none로 평가","license_required":"license_required는 [법원공무원]\n-법원 업무를 지원한다.\n-서류를 관리한다.\n-재판을 준비한다.\n-기록을 유지한다.\n-안내를 제공한다.\n-법규를 준수한다.\n-보고서를 작성한다.\n-시스템을 운영한다.... 기반으로 required로 평가"}'
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
  '1765283496293366',
  '철근공',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 50, 50,
  50, 50, 40, 40, 70, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [철근공]\n-철근을 재단한다.\n-철근을 조립한다.\n-용접을 실시한다.\n-보강을 한다.\n-안전 수칙을 준수한다.\n-품질을 검사한다.\n-장비를 관리한다.\n-기록을 유지한다.\n-설계를 ... 기반으로 50로 평가","growth":"growth는 [철근공]\n-철근을 재단한다.\n-철근을 조립한다.\n-용접을 실시한다.\n-보강을 한다.\n-안전 수칙을 준수한다.\n-품질을 검사한다.\n-장비를 관리한다.\n-기록을 유지한다.\n-설계를 ... 기반으로 65로 평가","stability":"stability는 [철근공]\n-철근을 재단한다.\n-철근을 조립한다.\n-용접을 실시한다.\n-보강을 한다.\n-안전 수칙을 준수한다.\n-품질을 검사한다.\n-장비를 관리한다.\n-기록을 유지한다.\n-설계를 ... 기반으로 50로 평가","income":"income는 [철근공]\n-철근을 재단한다.\n-철근을 조립한다.\n-용접을 실시한다.\n-보강을 한다.\n-안전 수칙을 준수한다.\n-품질을 검사한다.\n-장비를 관리한다.\n-기록을 유지한다.\n-설계를 ... 기반으로 50로 평가","teamwork":"teamwork는 [철근공]\n-철근을 재단한다.\n-철근을 조립한다.\n-용접을 실시한다.\n-보강을 한다.\n-안전 수칙을 준수한다.\n-품질을 검사한다.\n-장비를 관리한다.\n-기록을 유지한다.\n-설계를 ... 기반으로 50로 평가","solo_deep":"solo_deep는 [철근공]\n-철근을 재단한다.\n-철근을 조립한다.\n-용접을 실시한다.\n-보강을 한다.\n-안전 수칙을 준수한다.\n-품질을 검사한다.\n-장비를 관리한다.\n-기록을 유지한다.\n-설계를 ... 기반으로 50로 평가","analytical":"analytical는 [철근공]\n-철근을 재단한다.\n-철근을 조립한다.\n-용접을 실시한다.\n-보강을 한다.\n-안전 수칙을 준수한다.\n-품질을 검사한다.\n-장비를 관리한다.\n-기록을 유지한다.\n-설계를 ... 기반으로 40로 평가","creative":"creative는 [철근공]\n-철근을 재단한다.\n-철근을 조립한다.\n-용접을 실시한다.\n-보강을 한다.\n-안전 수칙을 준수한다.\n-품질을 검사한다.\n-장비를 관리한다.\n-기록을 유지한다.\n-설계를 ... 기반으로 40로 평가","execution":"execution는 [철근공]\n-철근을 재단한다.\n-철근을 조립한다.\n-용접을 실시한다.\n-보강을 한다.\n-안전 수칙을 준수한다.\n-품질을 검사한다.\n-장비를 관리한다.\n-기록을 유지한다.\n-설계를 ... 기반으로 70로 평가","people_facing":"people_facing는 [철근공]\n-철근을 재단한다.\n-철근을 조립한다.\n-용접을 실시한다.\n-보강을 한다.\n-안전 수칙을 준수한다.\n-품질을 검사한다.\n-장비를 관리한다.\n-기록을 유지한다.\n-설계를 ... 기반으로 50로 평가","degree_required":"degree_required는 [철근공]\n-철근을 재단한다.\n-철근을 조립한다.\n-용접을 실시한다.\n-보강을 한다.\n-안전 수칙을 준수한다.\n-품질을 검사한다.\n-장비를 관리한다.\n-기록을 유지한다.\n-설계를 ... 기반으로 none로 평가","license_required":"license_required는 [철근공]\n-철근을 재단한다.\n-철근을 조립한다.\n-용접을 실시한다.\n-보강을 한다.\n-안전 수칙을 준수한다.\n-품질을 검사한다.\n-장비를 관리한다.\n-기록을 유지한다.\n-설계를 ... 기반으로 none로 평가"}'
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
  '1765283472936861',
  '개그맨 및 코미디언',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 50, 40,
  70, 30, 30, 60, 60, 35,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [개그맨]\n-개그를 준비한다.\n-공연을 한다.\n-대본을 작성한다.\n-즉흥 연기를 한다.\n-관객과 소통한다.\n-프로모션을 한다.\n-기술을 연마한다.\n-팀과 협력한다.\n\n[코미디언]\n... 기반으로 50로 평가","growth":"growth는 [개그맨]\n-개그를 준비한다.\n-공연을 한다.\n-대본을 작성한다.\n-즉흥 연기를 한다.\n-관객과 소통한다.\n-프로모션을 한다.\n-기술을 연마한다.\n-팀과 협력한다.\n\n[코미디언]\n... 기반으로 65로 평가","stability":"stability는 [개그맨]\n-개그를 준비한다.\n-공연을 한다.\n-대본을 작성한다.\n-즉흥 연기를 한다.\n-관객과 소통한다.\n-프로모션을 한다.\n-기술을 연마한다.\n-팀과 협력한다.\n\n[코미디언]\n... 기반으로 50로 평가","income":"income는 [개그맨]\n-개그를 준비한다.\n-공연을 한다.\n-대본을 작성한다.\n-즉흥 연기를 한다.\n-관객과 소통한다.\n-프로모션을 한다.\n-기술을 연마한다.\n-팀과 협력한다.\n\n[코미디언]\n... 기반으로 40로 평가","teamwork":"teamwork는 [개그맨]\n-개그를 준비한다.\n-공연을 한다.\n-대본을 작성한다.\n-즉흥 연기를 한다.\n-관객과 소통한다.\n-프로모션을 한다.\n-기술을 연마한다.\n-팀과 협력한다.\n\n[코미디언]\n... 기반으로 70로 평가","solo_deep":"solo_deep는 [개그맨]\n-개그를 준비한다.\n-공연을 한다.\n-대본을 작성한다.\n-즉흥 연기를 한다.\n-관객과 소통한다.\n-프로모션을 한다.\n-기술을 연마한다.\n-팀과 협력한다.\n\n[코미디언]\n... 기반으로 30로 평가","analytical":"analytical는 [개그맨]\n-개그를 준비한다.\n-공연을 한다.\n-대본을 작성한다.\n-즉흥 연기를 한다.\n-관객과 소통한다.\n-프로모션을 한다.\n-기술을 연마한다.\n-팀과 협력한다.\n\n[코미디언]\n... 기반으로 30로 평가","creative":"creative는 [개그맨]\n-개그를 준비한다.\n-공연을 한다.\n-대본을 작성한다.\n-즉흥 연기를 한다.\n-관객과 소통한다.\n-프로모션을 한다.\n-기술을 연마한다.\n-팀과 협력한다.\n\n[코미디언]\n... 기반으로 60로 평가","execution":"execution는 [개그맨]\n-개그를 준비한다.\n-공연을 한다.\n-대본을 작성한다.\n-즉흥 연기를 한다.\n-관객과 소통한다.\n-프로모션을 한다.\n-기술을 연마한다.\n-팀과 협력한다.\n\n[코미디언]\n... 기반으로 60로 평가","people_facing":"people_facing는 [개그맨]\n-개그를 준비한다.\n-공연을 한다.\n-대본을 작성한다.\n-즉흥 연기를 한다.\n-관객과 소통한다.\n-프로모션을 한다.\n-기술을 연마한다.\n-팀과 협력한다.\n\n[코미디언]\n... 기반으로 35로 평가","degree_required":"degree_required는 [개그맨]\n-개그를 준비한다.\n-공연을 한다.\n-대본을 작성한다.\n-즉흥 연기를 한다.\n-관객과 소통한다.\n-프로모션을 한다.\n-기술을 연마한다.\n-팀과 협력한다.\n\n[코미디언]\n... 기반으로 none로 평가","license_required":"license_required는 [개그맨]\n-개그를 준비한다.\n-공연을 한다.\n-대본을 작성한다.\n-즉흥 연기를 한다.\n-관객과 소통한다.\n-프로모션을 한다.\n-기술을 연마한다.\n-팀과 협력한다.\n\n[코미디언]\n... 기반으로 none로 평가"}'
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
  '1765283421053844',
  '항공운송사무원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  50, 50, 40, 40, 70, 75,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [항공운송사무원]\n-항공편을 예약한다.\n-티켓을 발권한다.\n-수하물을 처리한다.\n-승객을 안내한다.\n-비상 상황에 대응한다.\n-문서를 관리한다.\n-고객 불편을 해결한다.\n-안전 수... 기반으로 50로 평가","growth":"growth는 [항공운송사무원]\n-항공편을 예약한다.\n-티켓을 발권한다.\n-수하물을 처리한다.\n-승객을 안내한다.\n-비상 상황에 대응한다.\n-문서를 관리한다.\n-고객 불편을 해결한다.\n-안전 수... 기반으로 50로 평가","stability":"stability는 [항공운송사무원]\n-항공편을 예약한다.\n-티켓을 발권한다.\n-수하물을 처리한다.\n-승객을 안내한다.\n-비상 상황에 대응한다.\n-문서를 관리한다.\n-고객 불편을 해결한다.\n-안전 수... 기반으로 50로 평가","income":"income는 [항공운송사무원]\n-항공편을 예약한다.\n-티켓을 발권한다.\n-수하물을 처리한다.\n-승객을 안내한다.\n-비상 상황에 대응한다.\n-문서를 관리한다.\n-고객 불편을 해결한다.\n-안전 수... 기반으로 50로 평가","teamwork":"teamwork는 [항공운송사무원]\n-항공편을 예약한다.\n-티켓을 발권한다.\n-수하물을 처리한다.\n-승객을 안내한다.\n-비상 상황에 대응한다.\n-문서를 관리한다.\n-고객 불편을 해결한다.\n-안전 수... 기반으로 50로 평가","solo_deep":"solo_deep는 [항공운송사무원]\n-항공편을 예약한다.\n-티켓을 발권한다.\n-수하물을 처리한다.\n-승객을 안내한다.\n-비상 상황에 대응한다.\n-문서를 관리한다.\n-고객 불편을 해결한다.\n-안전 수... 기반으로 50로 평가","analytical":"analytical는 [항공운송사무원]\n-항공편을 예약한다.\n-티켓을 발권한다.\n-수하물을 처리한다.\n-승객을 안내한다.\n-비상 상황에 대응한다.\n-문서를 관리한다.\n-고객 불편을 해결한다.\n-안전 수... 기반으로 40로 평가","creative":"creative는 [항공운송사무원]\n-항공편을 예약한다.\n-티켓을 발권한다.\n-수하물을 처리한다.\n-승객을 안내한다.\n-비상 상황에 대응한다.\n-문서를 관리한다.\n-고객 불편을 해결한다.\n-안전 수... 기반으로 40로 평가","execution":"execution는 [항공운송사무원]\n-항공편을 예약한다.\n-티켓을 발권한다.\n-수하물을 처리한다.\n-승객을 안내한다.\n-비상 상황에 대응한다.\n-문서를 관리한다.\n-고객 불편을 해결한다.\n-안전 수... 기반으로 70로 평가","people_facing":"people_facing는 [항공운송사무원]\n-항공편을 예약한다.\n-티켓을 발권한다.\n-수하물을 처리한다.\n-승객을 안내한다.\n-비상 상황에 대응한다.\n-문서를 관리한다.\n-고객 불편을 해결한다.\n-안전 수... 기반으로 75로 평가","degree_required":"degree_required는 [항공운송사무원]\n-항공편을 예약한다.\n-티켓을 발권한다.\n-수하물을 처리한다.\n-승객을 안내한다.\n-비상 상황에 대응한다.\n-문서를 관리한다.\n-고객 불편을 해결한다.\n-안전 수... 기반으로 none로 평가","license_required":"license_required는 [항공운송사무원]\n-항공편을 예약한다.\n-티켓을 발권한다.\n-수하물을 처리한다.\n-승객을 안내한다.\n-비상 상황에 대응한다.\n-문서를 관리한다.\n-고객 불편을 해결한다.\n-안전 수... 기반으로 none로 평가"}'
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
  '1765283478150821',
  '항공기객실승무원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 60, 50, 50,
  50, 50, 50, 50, 50, 75,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [항공기객실승무원]\n-승객을 안내한다.\n-안전을 설명한다.\n-식음료를 제공한다.\n-응급 처치를 한다.\n-비상 상황에 대응한다.\n-청결을 유지한다.\n-승객을 지원한다.\n-보고서를 작... 기반으로 50로 평가","growth":"growth는 [항공기객실승무원]\n-승객을 안내한다.\n-안전을 설명한다.\n-식음료를 제공한다.\n-응급 처치를 한다.\n-비상 상황에 대응한다.\n-청결을 유지한다.\n-승객을 지원한다.\n-보고서를 작... 기반으로 60로 평가","stability":"stability는 [항공기객실승무원]\n-승객을 안내한다.\n-안전을 설명한다.\n-식음료를 제공한다.\n-응급 처치를 한다.\n-비상 상황에 대응한다.\n-청결을 유지한다.\n-승객을 지원한다.\n-보고서를 작... 기반으로 50로 평가","income":"income는 [항공기객실승무원]\n-승객을 안내한다.\n-안전을 설명한다.\n-식음료를 제공한다.\n-응급 처치를 한다.\n-비상 상황에 대응한다.\n-청결을 유지한다.\n-승객을 지원한다.\n-보고서를 작... 기반으로 50로 평가","teamwork":"teamwork는 [항공기객실승무원]\n-승객을 안내한다.\n-안전을 설명한다.\n-식음료를 제공한다.\n-응급 처치를 한다.\n-비상 상황에 대응한다.\n-청결을 유지한다.\n-승객을 지원한다.\n-보고서를 작... 기반으로 50로 평가","solo_deep":"solo_deep는 [항공기객실승무원]\n-승객을 안내한다.\n-안전을 설명한다.\n-식음료를 제공한다.\n-응급 처치를 한다.\n-비상 상황에 대응한다.\n-청결을 유지한다.\n-승객을 지원한다.\n-보고서를 작... 기반으로 50로 평가","analytical":"analytical는 [항공기객실승무원]\n-승객을 안내한다.\n-안전을 설명한다.\n-식음료를 제공한다.\n-응급 처치를 한다.\n-비상 상황에 대응한다.\n-청결을 유지한다.\n-승객을 지원한다.\n-보고서를 작... 기반으로 50로 평가","creative":"creative는 [항공기객실승무원]\n-승객을 안내한다.\n-안전을 설명한다.\n-식음료를 제공한다.\n-응급 처치를 한다.\n-비상 상황에 대응한다.\n-청결을 유지한다.\n-승객을 지원한다.\n-보고서를 작... 기반으로 50로 평가","execution":"execution는 [항공기객실승무원]\n-승객을 안내한다.\n-안전을 설명한다.\n-식음료를 제공한다.\n-응급 처치를 한다.\n-비상 상황에 대응한다.\n-청결을 유지한다.\n-승객을 지원한다.\n-보고서를 작... 기반으로 50로 평가","people_facing":"people_facing는 [항공기객실승무원]\n-승객을 안내한다.\n-안전을 설명한다.\n-식음료를 제공한다.\n-응급 처치를 한다.\n-비상 상황에 대응한다.\n-청결을 유지한다.\n-승객을 지원한다.\n-보고서를 작... 기반으로 75로 평가","degree_required":"degree_required는 [항공기객실승무원]\n-승객을 안내한다.\n-안전을 설명한다.\n-식음료를 제공한다.\n-응급 처치를 한다.\n-비상 상황에 대응한다.\n-청결을 유지한다.\n-승객을 지원한다.\n-보고서를 작... 기반으로 none로 평가","license_required":"license_required는 [항공기객실승무원]\n-승객을 안내한다.\n-안전을 설명한다.\n-식음료를 제공한다.\n-응급 처치를 한다.\n-비상 상황에 대응한다.\n-청결을 유지한다.\n-승객을 지원한다.\n-보고서를 작... 기반으로 none로 평가"}'
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
  '176528341709323',
  '경영기획사무원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 70, 50,
  70, 30, 50, 50, 50, 50,
  'regular', 'none', 'none', 'partial',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [경영기획사무원]\n-경영 계획을 수립한다.\n-데이터를 분석한다.\n-보고서를 작성한다.\n-프로젝트를 지원한다.\n-예산을 관리한다.\n-성과를 모니터링한다.\n-제안을 준비한다.\n-회의를... 기반으로 50로 평가","growth":"growth는 [경영기획사무원]\n-경영 계획을 수립한다.\n-데이터를 분석한다.\n-보고서를 작성한다.\n-프로젝트를 지원한다.\n-예산을 관리한다.\n-성과를 모니터링한다.\n-제안을 준비한다.\n-회의를... 기반으로 65로 평가","stability":"stability는 [경영기획사무원]\n-경영 계획을 수립한다.\n-데이터를 분석한다.\n-보고서를 작성한다.\n-프로젝트를 지원한다.\n-예산을 관리한다.\n-성과를 모니터링한다.\n-제안을 준비한다.\n-회의를... 기반으로 70로 평가","income":"income는 [경영기획사무원]\n-경영 계획을 수립한다.\n-데이터를 분석한다.\n-보고서를 작성한다.\n-프로젝트를 지원한다.\n-예산을 관리한다.\n-성과를 모니터링한다.\n-제안을 준비한다.\n-회의를... 기반으로 50로 평가","teamwork":"teamwork는 [경영기획사무원]\n-경영 계획을 수립한다.\n-데이터를 분석한다.\n-보고서를 작성한다.\n-프로젝트를 지원한다.\n-예산을 관리한다.\n-성과를 모니터링한다.\n-제안을 준비한다.\n-회의를... 기반으로 70로 평가","solo_deep":"solo_deep는 [경영기획사무원]\n-경영 계획을 수립한다.\n-데이터를 분석한다.\n-보고서를 작성한다.\n-프로젝트를 지원한다.\n-예산을 관리한다.\n-성과를 모니터링한다.\n-제안을 준비한다.\n-회의를... 기반으로 30로 평가","analytical":"analytical는 [경영기획사무원]\n-경영 계획을 수립한다.\n-데이터를 분석한다.\n-보고서를 작성한다.\n-프로젝트를 지원한다.\n-예산을 관리한다.\n-성과를 모니터링한다.\n-제안을 준비한다.\n-회의를... 기반으로 50로 평가","creative":"creative는 [경영기획사무원]\n-경영 계획을 수립한다.\n-데이터를 분석한다.\n-보고서를 작성한다.\n-프로젝트를 지원한다.\n-예산을 관리한다.\n-성과를 모니터링한다.\n-제안을 준비한다.\n-회의를... 기반으로 50로 평가","execution":"execution는 [경영기획사무원]\n-경영 계획을 수립한다.\n-데이터를 분석한다.\n-보고서를 작성한다.\n-프로젝트를 지원한다.\n-예산을 관리한다.\n-성과를 모니터링한다.\n-제안을 준비한다.\n-회의를... 기반으로 50로 평가","people_facing":"people_facing는 [경영기획사무원]\n-경영 계획을 수립한다.\n-데이터를 분석한다.\n-보고서를 작성한다.\n-프로젝트를 지원한다.\n-예산을 관리한다.\n-성과를 모니터링한다.\n-제안을 준비한다.\n-회의를... 기반으로 50로 평가","degree_required":"degree_required는 [경영기획사무원]\n-경영 계획을 수립한다.\n-데이터를 분석한다.\n-보고서를 작성한다.\n-프로젝트를 지원한다.\n-예산을 관리한다.\n-성과를 모니터링한다.\n-제안을 준비한다.\n-회의를... 기반으로 none로 평가","license_required":"license_required는 [경영기획사무원]\n-경영 계획을 수립한다.\n-데이터를 분석한다.\n-보고서를 작성한다.\n-프로젝트를 지원한다.\n-예산을 관리한다.\n-성과를 모니터링한다.\n-제안을 준비한다.\n-회의를... 기반으로 none로 평가"}'
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
  '1765283419641669',
  '물류사무원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 70, 50,
  70, 30, 40, 40, 70, 50,
  'regular', 'none', 'none', 'partial',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [물류사무원]\n-물류 계획을 수립한다.\n-주문을 처리한다.\n-재고를 관리한다.\n-배송을 추적한다.\n-문서를 작성한다.\n-공급업체와 협력한다.\n-문제를 해결한다.\n-보고서를 작성한다... 기반으로 50로 평가","growth":"growth는 [물류사무원]\n-물류 계획을 수립한다.\n-주문을 처리한다.\n-재고를 관리한다.\n-배송을 추적한다.\n-문서를 작성한다.\n-공급업체와 협력한다.\n-문제를 해결한다.\n-보고서를 작성한다... 기반으로 50로 평가","stability":"stability는 [물류사무원]\n-물류 계획을 수립한다.\n-주문을 처리한다.\n-재고를 관리한다.\n-배송을 추적한다.\n-문서를 작성한다.\n-공급업체와 협력한다.\n-문제를 해결한다.\n-보고서를 작성한다... 기반으로 70로 평가","income":"income는 [물류사무원]\n-물류 계획을 수립한다.\n-주문을 처리한다.\n-재고를 관리한다.\n-배송을 추적한다.\n-문서를 작성한다.\n-공급업체와 협력한다.\n-문제를 해결한다.\n-보고서를 작성한다... 기반으로 50로 평가","teamwork":"teamwork는 [물류사무원]\n-물류 계획을 수립한다.\n-주문을 처리한다.\n-재고를 관리한다.\n-배송을 추적한다.\n-문서를 작성한다.\n-공급업체와 협력한다.\n-문제를 해결한다.\n-보고서를 작성한다... 기반으로 70로 평가","solo_deep":"solo_deep는 [물류사무원]\n-물류 계획을 수립한다.\n-주문을 처리한다.\n-재고를 관리한다.\n-배송을 추적한다.\n-문서를 작성한다.\n-공급업체와 협력한다.\n-문제를 해결한다.\n-보고서를 작성한다... 기반으로 30로 평가","analytical":"analytical는 [물류사무원]\n-물류 계획을 수립한다.\n-주문을 처리한다.\n-재고를 관리한다.\n-배송을 추적한다.\n-문서를 작성한다.\n-공급업체와 협력한다.\n-문제를 해결한다.\n-보고서를 작성한다... 기반으로 40로 평가","creative":"creative는 [물류사무원]\n-물류 계획을 수립한다.\n-주문을 처리한다.\n-재고를 관리한다.\n-배송을 추적한다.\n-문서를 작성한다.\n-공급업체와 협력한다.\n-문제를 해결한다.\n-보고서를 작성한다... 기반으로 40로 평가","execution":"execution는 [물류사무원]\n-물류 계획을 수립한다.\n-주문을 처리한다.\n-재고를 관리한다.\n-배송을 추적한다.\n-문서를 작성한다.\n-공급업체와 협력한다.\n-문제를 해결한다.\n-보고서를 작성한다... 기반으로 70로 평가","people_facing":"people_facing는 [물류사무원]\n-물류 계획을 수립한다.\n-주문을 처리한다.\n-재고를 관리한다.\n-배송을 추적한다.\n-문서를 작성한다.\n-공급업체와 협력한다.\n-문제를 해결한다.\n-보고서를 작성한다... 기반으로 50로 평가","degree_required":"degree_required는 [물류사무원]\n-물류 계획을 수립한다.\n-주문을 처리한다.\n-재고를 관리한다.\n-배송을 추적한다.\n-문서를 작성한다.\n-공급업체와 협력한다.\n-문제를 해결한다.\n-보고서를 작성한다... 기반으로 none로 평가","license_required":"license_required는 [물류사무원]\n-물류 계획을 수립한다.\n-주문을 처리한다.\n-재고를 관리한다.\n-배송을 추적한다.\n-문서를 작성한다.\n-공급업체와 협력한다.\n-문제를 해결한다.\n-보고서를 작성한다... 기반으로 none로 평가"}'
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
  '1765283453790950',
  '폐기물처리기술자',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 50, 50,
  50, 50, 50, 50, 50, 35,
  'regular', 'none', 'none', 'none',
  'bachelor', 'preferred', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [폐기물처리기술자]\n-폐기물을 분류한다.\n-처리 방법을 결정한다.\n-장비를 운영한다.\n-환경 영향을 평가한다.\n-안전 수칙을 준수한다.\n-법규를 따른다.\n-보고서를 작성한다.\n-유... 기반으로 50로 평가","growth":"growth는 [폐기물처리기술자]\n-폐기물을 분류한다.\n-처리 방법을 결정한다.\n-장비를 운영한다.\n-환경 영향을 평가한다.\n-안전 수칙을 준수한다.\n-법규를 따른다.\n-보고서를 작성한다.\n-유... 기반으로 65로 평가","stability":"stability는 [폐기물처리기술자]\n-폐기물을 분류한다.\n-처리 방법을 결정한다.\n-장비를 운영한다.\n-환경 영향을 평가한다.\n-안전 수칙을 준수한다.\n-법규를 따른다.\n-보고서를 작성한다.\n-유... 기반으로 50로 평가","income":"income는 [폐기물처리기술자]\n-폐기물을 분류한다.\n-처리 방법을 결정한다.\n-장비를 운영한다.\n-환경 영향을 평가한다.\n-안전 수칙을 준수한다.\n-법규를 따른다.\n-보고서를 작성한다.\n-유... 기반으로 50로 평가","teamwork":"teamwork는 [폐기물처리기술자]\n-폐기물을 분류한다.\n-처리 방법을 결정한다.\n-장비를 운영한다.\n-환경 영향을 평가한다.\n-안전 수칙을 준수한다.\n-법규를 따른다.\n-보고서를 작성한다.\n-유... 기반으로 50로 평가","solo_deep":"solo_deep는 [폐기물처리기술자]\n-폐기물을 분류한다.\n-처리 방법을 결정한다.\n-장비를 운영한다.\n-환경 영향을 평가한다.\n-안전 수칙을 준수한다.\n-법규를 따른다.\n-보고서를 작성한다.\n-유... 기반으로 50로 평가","analytical":"analytical는 [폐기물처리기술자]\n-폐기물을 분류한다.\n-처리 방법을 결정한다.\n-장비를 운영한다.\n-환경 영향을 평가한다.\n-안전 수칙을 준수한다.\n-법규를 따른다.\n-보고서를 작성한다.\n-유... 기반으로 50로 평가","creative":"creative는 [폐기물처리기술자]\n-폐기물을 분류한다.\n-처리 방법을 결정한다.\n-장비를 운영한다.\n-환경 영향을 평가한다.\n-안전 수칙을 준수한다.\n-법규를 따른다.\n-보고서를 작성한다.\n-유... 기반으로 50로 평가","execution":"execution는 [폐기물처리기술자]\n-폐기물을 분류한다.\n-처리 방법을 결정한다.\n-장비를 운영한다.\n-환경 영향을 평가한다.\n-안전 수칙을 준수한다.\n-법규를 따른다.\n-보고서를 작성한다.\n-유... 기반으로 50로 평가","people_facing":"people_facing는 [폐기물처리기술자]\n-폐기물을 분류한다.\n-처리 방법을 결정한다.\n-장비를 운영한다.\n-환경 영향을 평가한다.\n-안전 수칙을 준수한다.\n-법규를 따른다.\n-보고서를 작성한다.\n-유... 기반으로 35로 평가","degree_required":"degree_required는 [폐기물처리기술자]\n-폐기물을 분류한다.\n-처리 방법을 결정한다.\n-장비를 운영한다.\n-환경 영향을 평가한다.\n-안전 수칙을 준수한다.\n-법규를 따른다.\n-보고서를 작성한다.\n-유... 기반으로 bachelor로 평가","license_required":"license_required는 [폐기물처리기술자]\n-폐기물을 분류한다.\n-처리 방법을 결정한다.\n-장비를 운영한다.\n-환경 영향을 평가한다.\n-안전 수칙을 준수한다.\n-법규를 따른다.\n-보고서를 작성한다.\n-유... 기반으로 preferred로 평가"}'
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
  '1765283412976396',
  '전기·가스·수도관리자',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  50, 50, 40, 40, 70, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [전기관리자]\n-전기 시스템을 관리한다.\n-유지보수를 감독한다.\n-안전을 유지한다.\n-예산을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-기술을 감독한다.\n\n[가스관리자]... 기반으로 50로 평가","growth":"growth는 [전기관리자]\n-전기 시스템을 관리한다.\n-유지보수를 감독한다.\n-안전을 유지한다.\n-예산을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-기술을 감독한다.\n\n[가스관리자]... 기반으로 50로 평가","stability":"stability는 [전기관리자]\n-전기 시스템을 관리한다.\n-유지보수를 감독한다.\n-안전을 유지한다.\n-예산을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-기술을 감독한다.\n\n[가스관리자]... 기반으로 50로 평가","income":"income는 [전기관리자]\n-전기 시스템을 관리한다.\n-유지보수를 감독한다.\n-안전을 유지한다.\n-예산을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-기술을 감독한다.\n\n[가스관리자]... 기반으로 50로 평가","teamwork":"teamwork는 [전기관리자]\n-전기 시스템을 관리한다.\n-유지보수를 감독한다.\n-안전을 유지한다.\n-예산을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-기술을 감독한다.\n\n[가스관리자]... 기반으로 50로 평가","solo_deep":"solo_deep는 [전기관리자]\n-전기 시스템을 관리한다.\n-유지보수를 감독한다.\n-안전을 유지한다.\n-예산을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-기술을 감독한다.\n\n[가스관리자]... 기반으로 50로 평가","analytical":"analytical는 [전기관리자]\n-전기 시스템을 관리한다.\n-유지보수를 감독한다.\n-안전을 유지한다.\n-예산을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-기술을 감독한다.\n\n[가스관리자]... 기반으로 40로 평가","creative":"creative는 [전기관리자]\n-전기 시스템을 관리한다.\n-유지보수를 감독한다.\n-안전을 유지한다.\n-예산을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-기술을 감독한다.\n\n[가스관리자]... 기반으로 40로 평가","execution":"execution는 [전기관리자]\n-전기 시스템을 관리한다.\n-유지보수를 감독한다.\n-안전을 유지한다.\n-예산을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-기술을 감독한다.\n\n[가스관리자]... 기반으로 70로 평가","people_facing":"people_facing는 [전기관리자]\n-전기 시스템을 관리한다.\n-유지보수를 감독한다.\n-안전을 유지한다.\n-예산을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-기술을 감독한다.\n\n[가스관리자]... 기반으로 50로 평가","degree_required":"degree_required는 [전기관리자]\n-전기 시스템을 관리한다.\n-유지보수를 감독한다.\n-안전을 유지한다.\n-예산을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-기술을 감독한다.\n\n[가스관리자]... 기반으로 none로 평가","license_required":"license_required는 [전기관리자]\n-전기 시스템을 관리한다.\n-유지보수를 감독한다.\n-안전을 유지한다.\n-예산을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-기술을 감독한다.\n\n[가스관리자]... 기반으로 none로 평가"}'
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
  '1765283411571832',
  '환경∙청소∙경비 관련 관리자',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 75, 30, 50,
  50, 50, 30, 60, 60, 60,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [환경관리자]\n-환경 정책을 수립한다.\n-오염을 모니터링한다.\n-개선 방안을 개발한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-프로그램을 운영한다.\n-교육을 실시한다.\n\n[청소... 기반으로 50로 평가","growth":"growth는 [환경관리자]\n-환경 정책을 수립한다.\n-오염을 모니터링한다.\n-개선 방안을 개발한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-프로그램을 운영한다.\n-교육을 실시한다.\n\n[청소... 기반으로 75로 평가","stability":"stability는 [환경관리자]\n-환경 정책을 수립한다.\n-오염을 모니터링한다.\n-개선 방안을 개발한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-프로그램을 운영한다.\n-교육을 실시한다.\n\n[청소... 기반으로 30로 평가","income":"income는 [환경관리자]\n-환경 정책을 수립한다.\n-오염을 모니터링한다.\n-개선 방안을 개발한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-프로그램을 운영한다.\n-교육을 실시한다.\n\n[청소... 기반으로 50로 평가","teamwork":"teamwork는 [환경관리자]\n-환경 정책을 수립한다.\n-오염을 모니터링한다.\n-개선 방안을 개발한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-프로그램을 운영한다.\n-교육을 실시한다.\n\n[청소... 기반으로 50로 평가","solo_deep":"solo_deep는 [환경관리자]\n-환경 정책을 수립한다.\n-오염을 모니터링한다.\n-개선 방안을 개발한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-프로그램을 운영한다.\n-교육을 실시한다.\n\n[청소... 기반으로 50로 평가","analytical":"analytical는 [환경관리자]\n-환경 정책을 수립한다.\n-오염을 모니터링한다.\n-개선 방안을 개발한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-프로그램을 운영한다.\n-교육을 실시한다.\n\n[청소... 기반으로 30로 평가","creative":"creative는 [환경관리자]\n-환경 정책을 수립한다.\n-오염을 모니터링한다.\n-개선 방안을 개발한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-프로그램을 운영한다.\n-교육을 실시한다.\n\n[청소... 기반으로 60로 평가","execution":"execution는 [환경관리자]\n-환경 정책을 수립한다.\n-오염을 모니터링한다.\n-개선 방안을 개발한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-프로그램을 운영한다.\n-교육을 실시한다.\n\n[청소... 기반으로 60로 평가","people_facing":"people_facing는 [환경관리자]\n-환경 정책을 수립한다.\n-오염을 모니터링한다.\n-개선 방안을 개발한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-프로그램을 운영한다.\n-교육을 실시한다.\n\n[청소... 기반으로 60로 평가","degree_required":"degree_required는 [환경관리자]\n-환경 정책을 수립한다.\n-오염을 모니터링한다.\n-개선 방안을 개발한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-프로그램을 운영한다.\n-교육을 실시한다.\n\n[청소... 기반으로 none로 평가","license_required":"license_required는 [환경관리자]\n-환경 정책을 수립한다.\n-오염을 모니터링한다.\n-개선 방안을 개발한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-프로그램을 운영한다.\n-교육을 실시한다.\n\n[청소... 기반으로 none로 평가"}'
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