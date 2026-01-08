-- Batch tagging SQL generated at 2026-01-06T07:08:26.544Z
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
  '1765283482488732',
  '패스트푸드준비원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  70, 30, 40, 40, 70, 75,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [패스트푸드준비원]\n-주문을 받는다.\n-음식을 준비한다.\n-포장을 한다.\n-청결을 유지한다.\n-고객을 응대한다.\n-재고를 관리한다.\n-장비를 조작한다.\n-안전을 준수한다.\n-팀과 ... 기반으로 50로 평가","growth":"growth는 [패스트푸드준비원]\n-주문을 받는다.\n-음식을 준비한다.\n-포장을 한다.\n-청결을 유지한다.\n-고객을 응대한다.\n-재고를 관리한다.\n-장비를 조작한다.\n-안전을 준수한다.\n-팀과 ... 기반으로 50로 평가","stability":"stability는 [패스트푸드준비원]\n-주문을 받는다.\n-음식을 준비한다.\n-포장을 한다.\n-청결을 유지한다.\n-고객을 응대한다.\n-재고를 관리한다.\n-장비를 조작한다.\n-안전을 준수한다.\n-팀과 ... 기반으로 50로 평가","income":"income는 [패스트푸드준비원]\n-주문을 받는다.\n-음식을 준비한다.\n-포장을 한다.\n-청결을 유지한다.\n-고객을 응대한다.\n-재고를 관리한다.\n-장비를 조작한다.\n-안전을 준수한다.\n-팀과 ... 기반으로 50로 평가","teamwork":"teamwork는 [패스트푸드준비원]\n-주문을 받는다.\n-음식을 준비한다.\n-포장을 한다.\n-청결을 유지한다.\n-고객을 응대한다.\n-재고를 관리한다.\n-장비를 조작한다.\n-안전을 준수한다.\n-팀과 ... 기반으로 70로 평가","solo_deep":"solo_deep는 [패스트푸드준비원]\n-주문을 받는다.\n-음식을 준비한다.\n-포장을 한다.\n-청결을 유지한다.\n-고객을 응대한다.\n-재고를 관리한다.\n-장비를 조작한다.\n-안전을 준수한다.\n-팀과 ... 기반으로 30로 평가","analytical":"analytical는 [패스트푸드준비원]\n-주문을 받는다.\n-음식을 준비한다.\n-포장을 한다.\n-청결을 유지한다.\n-고객을 응대한다.\n-재고를 관리한다.\n-장비를 조작한다.\n-안전을 준수한다.\n-팀과 ... 기반으로 40로 평가","creative":"creative는 [패스트푸드준비원]\n-주문을 받는다.\n-음식을 준비한다.\n-포장을 한다.\n-청결을 유지한다.\n-고객을 응대한다.\n-재고를 관리한다.\n-장비를 조작한다.\n-안전을 준수한다.\n-팀과 ... 기반으로 40로 평가","execution":"execution는 [패스트푸드준비원]\n-주문을 받는다.\n-음식을 준비한다.\n-포장을 한다.\n-청결을 유지한다.\n-고객을 응대한다.\n-재고를 관리한다.\n-장비를 조작한다.\n-안전을 준수한다.\n-팀과 ... 기반으로 70로 평가","people_facing":"people_facing는 [패스트푸드준비원]\n-주문을 받는다.\n-음식을 준비한다.\n-포장을 한다.\n-청결을 유지한다.\n-고객을 응대한다.\n-재고를 관리한다.\n-장비를 조작한다.\n-안전을 준수한다.\n-팀과 ... 기반으로 75로 평가","degree_required":"degree_required는 [패스트푸드준비원]\n-주문을 받는다.\n-음식을 준비한다.\n-포장을 한다.\n-청결을 유지한다.\n-고객을 응대한다.\n-재고를 관리한다.\n-장비를 조작한다.\n-안전을 준수한다.\n-팀과 ... 기반으로 none로 평가","license_required":"license_required는 [패스트푸드준비원]\n-주문을 받는다.\n-음식을 준비한다.\n-포장을 한다.\n-청결을 유지한다.\n-고객을 응대한다.\n-재고를 관리한다.\n-장비를 조작한다.\n-안전을 준수한다.\n-팀과 ... 기반으로 none로 평가"}'
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
  '1765283410710701',
  '유치원 원장 및 원감',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 75, 50, 50,
  50, 50, 30, 60, 60, 75,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [유치원 원장]\n-유치원을 관리한다.\n-교육 프로그램을 기획한다.\n-교직원을 감독한다.\n-부모와 소통한다.\n-예산을 관리한다.\n-법규를 준수한다.\n-안전을 유지한다.\n\n[유치원 원... 기반으로 50로 평가","growth":"growth는 [유치원 원장]\n-유치원을 관리한다.\n-교육 프로그램을 기획한다.\n-교직원을 감독한다.\n-부모와 소통한다.\n-예산을 관리한다.\n-법규를 준수한다.\n-안전을 유지한다.\n\n[유치원 원... 기반으로 75로 평가","stability":"stability는 [유치원 원장]\n-유치원을 관리한다.\n-교육 프로그램을 기획한다.\n-교직원을 감독한다.\n-부모와 소통한다.\n-예산을 관리한다.\n-법규를 준수한다.\n-안전을 유지한다.\n\n[유치원 원... 기반으로 50로 평가","income":"income는 [유치원 원장]\n-유치원을 관리한다.\n-교육 프로그램을 기획한다.\n-교직원을 감독한다.\n-부모와 소통한다.\n-예산을 관리한다.\n-법규를 준수한다.\n-안전을 유지한다.\n\n[유치원 원... 기반으로 50로 평가","teamwork":"teamwork는 [유치원 원장]\n-유치원을 관리한다.\n-교육 프로그램을 기획한다.\n-교직원을 감독한다.\n-부모와 소통한다.\n-예산을 관리한다.\n-법규를 준수한다.\n-안전을 유지한다.\n\n[유치원 원... 기반으로 50로 평가","solo_deep":"solo_deep는 [유치원 원장]\n-유치원을 관리한다.\n-교육 프로그램을 기획한다.\n-교직원을 감독한다.\n-부모와 소통한다.\n-예산을 관리한다.\n-법규를 준수한다.\n-안전을 유지한다.\n\n[유치원 원... 기반으로 50로 평가","analytical":"analytical는 [유치원 원장]\n-유치원을 관리한다.\n-교육 프로그램을 기획한다.\n-교직원을 감독한다.\n-부모와 소통한다.\n-예산을 관리한다.\n-법규를 준수한다.\n-안전을 유지한다.\n\n[유치원 원... 기반으로 30로 평가","creative":"creative는 [유치원 원장]\n-유치원을 관리한다.\n-교육 프로그램을 기획한다.\n-교직원을 감독한다.\n-부모와 소통한다.\n-예산을 관리한다.\n-법규를 준수한다.\n-안전을 유지한다.\n\n[유치원 원... 기반으로 60로 평가","execution":"execution는 [유치원 원장]\n-유치원을 관리한다.\n-교육 프로그램을 기획한다.\n-교직원을 감독한다.\n-부모와 소통한다.\n-예산을 관리한다.\n-법규를 준수한다.\n-안전을 유지한다.\n\n[유치원 원... 기반으로 60로 평가","people_facing":"people_facing는 [유치원 원장]\n-유치원을 관리한다.\n-교육 프로그램을 기획한다.\n-교직원을 감독한다.\n-부모와 소통한다.\n-예산을 관리한다.\n-법규를 준수한다.\n-안전을 유지한다.\n\n[유치원 원... 기반으로 75로 평가","degree_required":"degree_required는 [유치원 원장]\n-유치원을 관리한다.\n-교육 프로그램을 기획한다.\n-교직원을 감독한다.\n-부모와 소통한다.\n-예산을 관리한다.\n-법규를 준수한다.\n-안전을 유지한다.\n\n[유치원 원... 기반으로 none로 평가","license_required":"license_required는 [유치원 원장]\n-유치원을 관리한다.\n-교육 프로그램을 기획한다.\n-교직원을 감독한다.\n-부모와 소통한다.\n-예산을 관리한다.\n-법규를 준수한다.\n-안전을 유지한다.\n\n[유치원 원... 기반으로 none로 평가"}'
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
  '1765283422539898',
  '출판·자료편집사무원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 70, 50,
  70, 30, 40, 40, 70, 50,
  'regular', 'none', 'none', 'partial',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [출판사무원]\n-원고를 편집한다.\n-교정을 본다.\n-레이아웃을 구성한다.\n-인쇄를 준비한다.\n-저자와 협의한다.\n-일정을 관리한다.\n-기록을 관리한다.\n\n[자료편집사무원]\n-자료를... 기반으로 50로 평가","growth":"growth는 [출판사무원]\n-원고를 편집한다.\n-교정을 본다.\n-레이아웃을 구성한다.\n-인쇄를 준비한다.\n-저자와 협의한다.\n-일정을 관리한다.\n-기록을 관리한다.\n\n[자료편집사무원]\n-자료를... 기반으로 50로 평가","stability":"stability는 [출판사무원]\n-원고를 편집한다.\n-교정을 본다.\n-레이아웃을 구성한다.\n-인쇄를 준비한다.\n-저자와 협의한다.\n-일정을 관리한다.\n-기록을 관리한다.\n\n[자료편집사무원]\n-자료를... 기반으로 70로 평가","income":"income는 [출판사무원]\n-원고를 편집한다.\n-교정을 본다.\n-레이아웃을 구성한다.\n-인쇄를 준비한다.\n-저자와 협의한다.\n-일정을 관리한다.\n-기록을 관리한다.\n\n[자료편집사무원]\n-자료를... 기반으로 50로 평가","teamwork":"teamwork는 [출판사무원]\n-원고를 편집한다.\n-교정을 본다.\n-레이아웃을 구성한다.\n-인쇄를 준비한다.\n-저자와 협의한다.\n-일정을 관리한다.\n-기록을 관리한다.\n\n[자료편집사무원]\n-자료를... 기반으로 70로 평가","solo_deep":"solo_deep는 [출판사무원]\n-원고를 편집한다.\n-교정을 본다.\n-레이아웃을 구성한다.\n-인쇄를 준비한다.\n-저자와 협의한다.\n-일정을 관리한다.\n-기록을 관리한다.\n\n[자료편집사무원]\n-자료를... 기반으로 30로 평가","analytical":"analytical는 [출판사무원]\n-원고를 편집한다.\n-교정을 본다.\n-레이아웃을 구성한다.\n-인쇄를 준비한다.\n-저자와 협의한다.\n-일정을 관리한다.\n-기록을 관리한다.\n\n[자료편집사무원]\n-자료를... 기반으로 40로 평가","creative":"creative는 [출판사무원]\n-원고를 편집한다.\n-교정을 본다.\n-레이아웃을 구성한다.\n-인쇄를 준비한다.\n-저자와 협의한다.\n-일정을 관리한다.\n-기록을 관리한다.\n\n[자료편집사무원]\n-자료를... 기반으로 40로 평가","execution":"execution는 [출판사무원]\n-원고를 편집한다.\n-교정을 본다.\n-레이아웃을 구성한다.\n-인쇄를 준비한다.\n-저자와 협의한다.\n-일정을 관리한다.\n-기록을 관리한다.\n\n[자료편집사무원]\n-자료를... 기반으로 70로 평가","people_facing":"people_facing는 [출판사무원]\n-원고를 편집한다.\n-교정을 본다.\n-레이아웃을 구성한다.\n-인쇄를 준비한다.\n-저자와 협의한다.\n-일정을 관리한다.\n-기록을 관리한다.\n\n[자료편집사무원]\n-자료를... 기반으로 50로 평가","degree_required":"degree_required는 [출판사무원]\n-원고를 편집한다.\n-교정을 본다.\n-레이아웃을 구성한다.\n-인쇄를 준비한다.\n-저자와 협의한다.\n-일정을 관리한다.\n-기록을 관리한다.\n\n[자료편집사무원]\n-자료를... 기반으로 none로 평가","license_required":"license_required는 [출판사무원]\n-원고를 편집한다.\n-교정을 본다.\n-레이아웃을 구성한다.\n-인쇄를 준비한다.\n-저자와 협의한다.\n-일정을 관리한다.\n-기록을 관리한다.\n\n[자료편집사무원]\n-자료를... 기반으로 none로 평가"}'
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
  '1765283497178369',
  '섀시조립·설치원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  50, 50, 40, 40, 70, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [섀시조립원]\n-섀시 부품을 준비한다.\n-조립을 실시한다.\n-용접을 한다.\n-품질을 검사한다.\n-안전 수칙을 준수한다.\n-장비를 사용한다.\n-기록을 관리한다.\n\n[섀시설치원]\n-섀... 기반으로 50로 평가","growth":"growth는 [섀시조립원]\n-섀시 부품을 준비한다.\n-조립을 실시한다.\n-용접을 한다.\n-품질을 검사한다.\n-안전 수칙을 준수한다.\n-장비를 사용한다.\n-기록을 관리한다.\n\n[섀시설치원]\n-섀... 기반으로 50로 평가","stability":"stability는 [섀시조립원]\n-섀시 부품을 준비한다.\n-조립을 실시한다.\n-용접을 한다.\n-품질을 검사한다.\n-안전 수칙을 준수한다.\n-장비를 사용한다.\n-기록을 관리한다.\n\n[섀시설치원]\n-섀... 기반으로 50로 평가","income":"income는 [섀시조립원]\n-섀시 부품을 준비한다.\n-조립을 실시한다.\n-용접을 한다.\n-품질을 검사한다.\n-안전 수칙을 준수한다.\n-장비를 사용한다.\n-기록을 관리한다.\n\n[섀시설치원]\n-섀... 기반으로 50로 평가","teamwork":"teamwork는 [섀시조립원]\n-섀시 부품을 준비한다.\n-조립을 실시한다.\n-용접을 한다.\n-품질을 검사한다.\n-안전 수칙을 준수한다.\n-장비를 사용한다.\n-기록을 관리한다.\n\n[섀시설치원]\n-섀... 기반으로 50로 평가","solo_deep":"solo_deep는 [섀시조립원]\n-섀시 부품을 준비한다.\n-조립을 실시한다.\n-용접을 한다.\n-품질을 검사한다.\n-안전 수칙을 준수한다.\n-장비를 사용한다.\n-기록을 관리한다.\n\n[섀시설치원]\n-섀... 기반으로 50로 평가","analytical":"analytical는 [섀시조립원]\n-섀시 부품을 준비한다.\n-조립을 실시한다.\n-용접을 한다.\n-품질을 검사한다.\n-안전 수칙을 준수한다.\n-장비를 사용한다.\n-기록을 관리한다.\n\n[섀시설치원]\n-섀... 기반으로 40로 평가","creative":"creative는 [섀시조립원]\n-섀시 부품을 준비한다.\n-조립을 실시한다.\n-용접을 한다.\n-품질을 검사한다.\n-안전 수칙을 준수한다.\n-장비를 사용한다.\n-기록을 관리한다.\n\n[섀시설치원]\n-섀... 기반으로 40로 평가","execution":"execution는 [섀시조립원]\n-섀시 부품을 준비한다.\n-조립을 실시한다.\n-용접을 한다.\n-품질을 검사한다.\n-안전 수칙을 준수한다.\n-장비를 사용한다.\n-기록을 관리한다.\n\n[섀시설치원]\n-섀... 기반으로 70로 평가","people_facing":"people_facing는 [섀시조립원]\n-섀시 부품을 준비한다.\n-조립을 실시한다.\n-용접을 한다.\n-품질을 검사한다.\n-안전 수칙을 준수한다.\n-장비를 사용한다.\n-기록을 관리한다.\n\n[섀시설치원]\n-섀... 기반으로 50로 평가","degree_required":"degree_required는 [섀시조립원]\n-섀시 부품을 준비한다.\n-조립을 실시한다.\n-용접을 한다.\n-품질을 검사한다.\n-안전 수칙을 준수한다.\n-장비를 사용한다.\n-기록을 관리한다.\n\n[섀시설치원]\n-섀... 기반으로 none로 평가","license_required":"license_required는 [섀시조립원]\n-섀시 부품을 준비한다.\n-조립을 실시한다.\n-용접을 한다.\n-품질을 검사한다.\n-안전 수칙을 준수한다.\n-장비를 사용한다.\n-기록을 관리한다.\n\n[섀시설치원]\n-섀... 기반으로 none로 평가"}'
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
  '176528342701427',
  '증권·외환딜러',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 70, 50,
  50, 50, 40, 40, 70, 75,
  'regular', 'none', 'none', 'partial',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [증권딜러]\n-주식 거래를 실행한다.\n-시장 동향을 모니터링한다.\n-주문을 처리한다.\n-리스크를 관리한다.\n-보고서를 작성한다.\n-고객과 소통한다.\n-법규를 준수한다.\n\n[외환딜러... 기반으로 50로 평가","growth":"growth는 [증권딜러]\n-주식 거래를 실행한다.\n-시장 동향을 모니터링한다.\n-주문을 처리한다.\n-리스크를 관리한다.\n-보고서를 작성한다.\n-고객과 소통한다.\n-법규를 준수한다.\n\n[외환딜러... 기반으로 50로 평가","stability":"stability는 [증권딜러]\n-주식 거래를 실행한다.\n-시장 동향을 모니터링한다.\n-주문을 처리한다.\n-리스크를 관리한다.\n-보고서를 작성한다.\n-고객과 소통한다.\n-법규를 준수한다.\n\n[외환딜러... 기반으로 70로 평가","income":"income는 [증권딜러]\n-주식 거래를 실행한다.\n-시장 동향을 모니터링한다.\n-주문을 처리한다.\n-리스크를 관리한다.\n-보고서를 작성한다.\n-고객과 소통한다.\n-법규를 준수한다.\n\n[외환딜러... 기반으로 50로 평가","teamwork":"teamwork는 [증권딜러]\n-주식 거래를 실행한다.\n-시장 동향을 모니터링한다.\n-주문을 처리한다.\n-리스크를 관리한다.\n-보고서를 작성한다.\n-고객과 소통한다.\n-법규를 준수한다.\n\n[외환딜러... 기반으로 50로 평가","solo_deep":"solo_deep는 [증권딜러]\n-주식 거래를 실행한다.\n-시장 동향을 모니터링한다.\n-주문을 처리한다.\n-리스크를 관리한다.\n-보고서를 작성한다.\n-고객과 소통한다.\n-법규를 준수한다.\n\n[외환딜러... 기반으로 50로 평가","analytical":"analytical는 [증권딜러]\n-주식 거래를 실행한다.\n-시장 동향을 모니터링한다.\n-주문을 처리한다.\n-리스크를 관리한다.\n-보고서를 작성한다.\n-고객과 소통한다.\n-법규를 준수한다.\n\n[외환딜러... 기반으로 40로 평가","creative":"creative는 [증권딜러]\n-주식 거래를 실행한다.\n-시장 동향을 모니터링한다.\n-주문을 처리한다.\n-리스크를 관리한다.\n-보고서를 작성한다.\n-고객과 소통한다.\n-법규를 준수한다.\n\n[외환딜러... 기반으로 40로 평가","execution":"execution는 [증권딜러]\n-주식 거래를 실행한다.\n-시장 동향을 모니터링한다.\n-주문을 처리한다.\n-리스크를 관리한다.\n-보고서를 작성한다.\n-고객과 소통한다.\n-법규를 준수한다.\n\n[외환딜러... 기반으로 70로 평가","people_facing":"people_facing는 [증권딜러]\n-주식 거래를 실행한다.\n-시장 동향을 모니터링한다.\n-주문을 처리한다.\n-리스크를 관리한다.\n-보고서를 작성한다.\n-고객과 소통한다.\n-법규를 준수한다.\n\n[외환딜러... 기반으로 75로 평가","degree_required":"degree_required는 [증권딜러]\n-주식 거래를 실행한다.\n-시장 동향을 모니터링한다.\n-주문을 처리한다.\n-리스크를 관리한다.\n-보고서를 작성한다.\n-고객과 소통한다.\n-법규를 준수한다.\n\n[외환딜러... 기반으로 none로 평가","license_required":"license_required는 [증권딜러]\n-주식 거래를 실행한다.\n-시장 동향을 모니터링한다.\n-주문을 처리한다.\n-리스크를 관리한다.\n-보고서를 작성한다.\n-고객과 소통한다.\n-법규를 준수한다.\n\n[외환딜러... 기반으로 none로 평가"}'
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
  '1765283414891152',
  '조사전문가',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 70, 50,
  50, 50, 60, 30, 60, 50,
  'regular', 'none', 'none', 'partial',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [조사전문가]\n-조사 계획을 수립한다.\n-데이터를 수집한다.\n-분석을 실시한다.\n-보고서를 작성한다.\n-결과를 해석한다.\n-추천안을 제시한다.\n-법규를 준수한다.\n-기록을 관리한다... 기반으로 50로 평가","growth":"growth는 [조사전문가]\n-조사 계획을 수립한다.\n-데이터를 수집한다.\n-분석을 실시한다.\n-보고서를 작성한다.\n-결과를 해석한다.\n-추천안을 제시한다.\n-법규를 준수한다.\n-기록을 관리한다... 기반으로 50로 평가","stability":"stability는 [조사전문가]\n-조사 계획을 수립한다.\n-데이터를 수집한다.\n-분석을 실시한다.\n-보고서를 작성한다.\n-결과를 해석한다.\n-추천안을 제시한다.\n-법규를 준수한다.\n-기록을 관리한다... 기반으로 70로 평가","income":"income는 [조사전문가]\n-조사 계획을 수립한다.\n-데이터를 수집한다.\n-분석을 실시한다.\n-보고서를 작성한다.\n-결과를 해석한다.\n-추천안을 제시한다.\n-법규를 준수한다.\n-기록을 관리한다... 기반으로 50로 평가","teamwork":"teamwork는 [조사전문가]\n-조사 계획을 수립한다.\n-데이터를 수집한다.\n-분석을 실시한다.\n-보고서를 작성한다.\n-결과를 해석한다.\n-추천안을 제시한다.\n-법규를 준수한다.\n-기록을 관리한다... 기반으로 50로 평가","solo_deep":"solo_deep는 [조사전문가]\n-조사 계획을 수립한다.\n-데이터를 수집한다.\n-분석을 실시한다.\n-보고서를 작성한다.\n-결과를 해석한다.\n-추천안을 제시한다.\n-법규를 준수한다.\n-기록을 관리한다... 기반으로 50로 평가","analytical":"analytical는 [조사전문가]\n-조사 계획을 수립한다.\n-데이터를 수집한다.\n-분석을 실시한다.\n-보고서를 작성한다.\n-결과를 해석한다.\n-추천안을 제시한다.\n-법규를 준수한다.\n-기록을 관리한다... 기반으로 60로 평가","creative":"creative는 [조사전문가]\n-조사 계획을 수립한다.\n-데이터를 수집한다.\n-분석을 실시한다.\n-보고서를 작성한다.\n-결과를 해석한다.\n-추천안을 제시한다.\n-법규를 준수한다.\n-기록을 관리한다... 기반으로 30로 평가","execution":"execution는 [조사전문가]\n-조사 계획을 수립한다.\n-데이터를 수집한다.\n-분석을 실시한다.\n-보고서를 작성한다.\n-결과를 해석한다.\n-추천안을 제시한다.\n-법규를 준수한다.\n-기록을 관리한다... 기반으로 60로 평가","people_facing":"people_facing는 [조사전문가]\n-조사 계획을 수립한다.\n-데이터를 수집한다.\n-분석을 실시한다.\n-보고서를 작성한다.\n-결과를 해석한다.\n-추천안을 제시한다.\n-법규를 준수한다.\n-기록을 관리한다... 기반으로 50로 평가","degree_required":"degree_required는 [조사전문가]\n-조사 계획을 수립한다.\n-데이터를 수집한다.\n-분석을 실시한다.\n-보고서를 작성한다.\n-결과를 해석한다.\n-추천안을 제시한다.\n-법규를 준수한다.\n-기록을 관리한다... 기반으로 none로 평가","license_required":"license_required는 [조사전문가]\n-조사 계획을 수립한다.\n-데이터를 수집한다.\n-분석을 실시한다.\n-보고서를 작성한다.\n-결과를 해석한다.\n-추천안을 제시한다.\n-법규를 준수한다.\n-기록을 관리한다... 기반으로 none로 평가"}'
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
  '1765283472138895',
  '영화배우 및 탤런트',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 40,
  70, 30, 60, 30, 60, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [영화배우]\n-대본을 분석한다.\n-연기를 준비한다.\n-촬영에 참여한다.\n-감정을 표현한다.\n-감독과 협의한다.\n-프로모션에 참여한다.\n-기술을 연마한다.\n\n[탤런트]\n-방송에 출연... 기반으로 50로 평가","growth":"growth는 [영화배우]\n-대본을 분석한다.\n-연기를 준비한다.\n-촬영에 참여한다.\n-감정을 표현한다.\n-감독과 협의한다.\n-프로모션에 참여한다.\n-기술을 연마한다.\n\n[탤런트]\n-방송에 출연... 기반으로 50로 평가","stability":"stability는 [영화배우]\n-대본을 분석한다.\n-연기를 준비한다.\n-촬영에 참여한다.\n-감정을 표현한다.\n-감독과 협의한다.\n-프로모션에 참여한다.\n-기술을 연마한다.\n\n[탤런트]\n-방송에 출연... 기반으로 50로 평가","income":"income는 [영화배우]\n-대본을 분석한다.\n-연기를 준비한다.\n-촬영에 참여한다.\n-감정을 표현한다.\n-감독과 협의한다.\n-프로모션에 참여한다.\n-기술을 연마한다.\n\n[탤런트]\n-방송에 출연... 기반으로 40로 평가","teamwork":"teamwork는 [영화배우]\n-대본을 분석한다.\n-연기를 준비한다.\n-촬영에 참여한다.\n-감정을 표현한다.\n-감독과 협의한다.\n-프로모션에 참여한다.\n-기술을 연마한다.\n\n[탤런트]\n-방송에 출연... 기반으로 70로 평가","solo_deep":"solo_deep는 [영화배우]\n-대본을 분석한다.\n-연기를 준비한다.\n-촬영에 참여한다.\n-감정을 표현한다.\n-감독과 협의한다.\n-프로모션에 참여한다.\n-기술을 연마한다.\n\n[탤런트]\n-방송에 출연... 기반으로 30로 평가","analytical":"analytical는 [영화배우]\n-대본을 분석한다.\n-연기를 준비한다.\n-촬영에 참여한다.\n-감정을 표현한다.\n-감독과 협의한다.\n-프로모션에 참여한다.\n-기술을 연마한다.\n\n[탤런트]\n-방송에 출연... 기반으로 60로 평가","creative":"creative는 [영화배우]\n-대본을 분석한다.\n-연기를 준비한다.\n-촬영에 참여한다.\n-감정을 표현한다.\n-감독과 협의한다.\n-프로모션에 참여한다.\n-기술을 연마한다.\n\n[탤런트]\n-방송에 출연... 기반으로 30로 평가","execution":"execution는 [영화배우]\n-대본을 분석한다.\n-연기를 준비한다.\n-촬영에 참여한다.\n-감정을 표현한다.\n-감독과 협의한다.\n-프로모션에 참여한다.\n-기술을 연마한다.\n\n[탤런트]\n-방송에 출연... 기반으로 60로 평가","people_facing":"people_facing는 [영화배우]\n-대본을 분석한다.\n-연기를 준비한다.\n-촬영에 참여한다.\n-감정을 표현한다.\n-감독과 협의한다.\n-프로모션에 참여한다.\n-기술을 연마한다.\n\n[탤런트]\n-방송에 출연... 기반으로 50로 평가","degree_required":"degree_required는 [영화배우]\n-대본을 분석한다.\n-연기를 준비한다.\n-촬영에 참여한다.\n-감정을 표현한다.\n-감독과 협의한다.\n-프로모션에 참여한다.\n-기술을 연마한다.\n\n[탤런트]\n-방송에 출연... 기반으로 none로 평가","license_required":"license_required는 [영화배우]\n-대본을 분석한다.\n-연기를 준비한다.\n-촬영에 참여한다.\n-감정을 표현한다.\n-감독과 협의한다.\n-프로모션에 참여한다.\n-기술을 연마한다.\n\n[탤런트]\n-방송에 출연... 기반으로 none로 평가"}'
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
  '1765283470121350',
  'UX·UI디자이너',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 50, 40,
  50, 50, 60, 60, 30, 35,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [ux디자이너]\n-사용자 조사를 실시한다.\n-사용자 경험을 설계한다.\n-와이어프레임을 만든다.\n-프로토타입을 개발한다.\n-테스트를 진행한다.\n-피드백을 분석한다.\n-개선을 한다.\n... 기반으로 50로 평가","growth":"growth는 [ux디자이너]\n-사용자 조사를 실시한다.\n-사용자 경험을 설계한다.\n-와이어프레임을 만든다.\n-프로토타입을 개발한다.\n-테스트를 진행한다.\n-피드백을 분석한다.\n-개선을 한다.\n... 기반으로 65로 평가","stability":"stability는 [ux디자이너]\n-사용자 조사를 실시한다.\n-사용자 경험을 설계한다.\n-와이어프레임을 만든다.\n-프로토타입을 개발한다.\n-테스트를 진행한다.\n-피드백을 분석한다.\n-개선을 한다.\n... 기반으로 50로 평가","income":"income는 [ux디자이너]\n-사용자 조사를 실시한다.\n-사용자 경험을 설계한다.\n-와이어프레임을 만든다.\n-프로토타입을 개발한다.\n-테스트를 진행한다.\n-피드백을 분석한다.\n-개선을 한다.\n... 기반으로 40로 평가","teamwork":"teamwork는 [ux디자이너]\n-사용자 조사를 실시한다.\n-사용자 경험을 설계한다.\n-와이어프레임을 만든다.\n-프로토타입을 개발한다.\n-테스트를 진행한다.\n-피드백을 분석한다.\n-개선을 한다.\n... 기반으로 50로 평가","solo_deep":"solo_deep는 [ux디자이너]\n-사용자 조사를 실시한다.\n-사용자 경험을 설계한다.\n-와이어프레임을 만든다.\n-프로토타입을 개발한다.\n-테스트를 진행한다.\n-피드백을 분석한다.\n-개선을 한다.\n... 기반으로 50로 평가","analytical":"analytical는 [ux디자이너]\n-사용자 조사를 실시한다.\n-사용자 경험을 설계한다.\n-와이어프레임을 만든다.\n-프로토타입을 개발한다.\n-테스트를 진행한다.\n-피드백을 분석한다.\n-개선을 한다.\n... 기반으로 60로 평가","creative":"creative는 [ux디자이너]\n-사용자 조사를 실시한다.\n-사용자 경험을 설계한다.\n-와이어프레임을 만든다.\n-프로토타입을 개발한다.\n-테스트를 진행한다.\n-피드백을 분석한다.\n-개선을 한다.\n... 기반으로 60로 평가","execution":"execution는 [ux디자이너]\n-사용자 조사를 실시한다.\n-사용자 경험을 설계한다.\n-와이어프레임을 만든다.\n-프로토타입을 개발한다.\n-테스트를 진행한다.\n-피드백을 분석한다.\n-개선을 한다.\n... 기반으로 30로 평가","people_facing":"people_facing는 [ux디자이너]\n-사용자 조사를 실시한다.\n-사용자 경험을 설계한다.\n-와이어프레임을 만든다.\n-프로토타입을 개발한다.\n-테스트를 진행한다.\n-피드백을 분석한다.\n-개선을 한다.\n... 기반으로 35로 평가","degree_required":"degree_required는 [ux디자이너]\n-사용자 조사를 실시한다.\n-사용자 경험을 설계한다.\n-와이어프레임을 만든다.\n-프로토타입을 개발한다.\n-테스트를 진행한다.\n-피드백을 분석한다.\n-개선을 한다.\n... 기반으로 none로 평가","license_required":"license_required는 [ux디자이너]\n-사용자 조사를 실시한다.\n-사용자 경험을 설계한다.\n-와이어프레임을 만든다.\n-프로토타입을 개발한다.\n-테스트를 진행한다.\n-피드백을 분석한다.\n-개선을 한다.\n... 기반으로 none로 평가"}'
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
  '1765283413511282',
  '정부·공공행정전문가',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 50, 50,
  50, 50, 50, 50, 50, 60,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [정부행정전문가]\n-정책을 개발한다.\n-프로그램을 기획한다.\n-예산을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-시민을 지원한다.\n-데이터를 분석한다.\n-프로젝트를 관리... 기반으로 50로 평가","growth":"growth는 [정부행정전문가]\n-정책을 개발한다.\n-프로그램을 기획한다.\n-예산을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-시민을 지원한다.\n-데이터를 분석한다.\n-프로젝트를 관리... 기반으로 65로 평가","stability":"stability는 [정부행정전문가]\n-정책을 개발한다.\n-프로그램을 기획한다.\n-예산을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-시민을 지원한다.\n-데이터를 분석한다.\n-프로젝트를 관리... 기반으로 50로 평가","income":"income는 [정부행정전문가]\n-정책을 개발한다.\n-프로그램을 기획한다.\n-예산을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-시민을 지원한다.\n-데이터를 분석한다.\n-프로젝트를 관리... 기반으로 50로 평가","teamwork":"teamwork는 [정부행정전문가]\n-정책을 개발한다.\n-프로그램을 기획한다.\n-예산을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-시민을 지원한다.\n-데이터를 분석한다.\n-프로젝트를 관리... 기반으로 50로 평가","solo_deep":"solo_deep는 [정부행정전문가]\n-정책을 개발한다.\n-프로그램을 기획한다.\n-예산을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-시민을 지원한다.\n-데이터를 분석한다.\n-프로젝트를 관리... 기반으로 50로 평가","analytical":"analytical는 [정부행정전문가]\n-정책을 개발한다.\n-프로그램을 기획한다.\n-예산을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-시민을 지원한다.\n-데이터를 분석한다.\n-프로젝트를 관리... 기반으로 50로 평가","creative":"creative는 [정부행정전문가]\n-정책을 개발한다.\n-프로그램을 기획한다.\n-예산을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-시민을 지원한다.\n-데이터를 분석한다.\n-프로젝트를 관리... 기반으로 50로 평가","execution":"execution는 [정부행정전문가]\n-정책을 개발한다.\n-프로그램을 기획한다.\n-예산을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-시민을 지원한다.\n-데이터를 분석한다.\n-프로젝트를 관리... 기반으로 50로 평가","people_facing":"people_facing는 [정부행정전문가]\n-정책을 개발한다.\n-프로그램을 기획한다.\n-예산을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-시민을 지원한다.\n-데이터를 분석한다.\n-프로젝트를 관리... 기반으로 60로 평가","degree_required":"degree_required는 [정부행정전문가]\n-정책을 개발한다.\n-프로그램을 기획한다.\n-예산을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-시민을 지원한다.\n-데이터를 분석한다.\n-프로젝트를 관리... 기반으로 none로 평가","license_required":"license_required는 [정부행정전문가]\n-정책을 개발한다.\n-프로그램을 기획한다.\n-예산을 관리한다.\n-보고서를 작성한다.\n-법규를 준수한다.\n-시민을 지원한다.\n-데이터를 분석한다.\n-프로젝트를 관리... 기반으로 none로 평가"}'
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
  '1765283485383403',
  '가사관리사',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  50, 50, 40, 40, 70, 75,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [가사관리사]\n-청소를 실시한다.\n-세탁을 한다.\n-요리를 준비한다.\n-장보기를 한다.\n-가구를 관리한다.\n-안전을 유지한다.\n-고객을 지원한다.\n-기록을 관리한다.\n-서비스를 제... 기반으로 50로 평가","growth":"growth는 [가사관리사]\n-청소를 실시한다.\n-세탁을 한다.\n-요리를 준비한다.\n-장보기를 한다.\n-가구를 관리한다.\n-안전을 유지한다.\n-고객을 지원한다.\n-기록을 관리한다.\n-서비스를 제... 기반으로 50로 평가","stability":"stability는 [가사관리사]\n-청소를 실시한다.\n-세탁을 한다.\n-요리를 준비한다.\n-장보기를 한다.\n-가구를 관리한다.\n-안전을 유지한다.\n-고객을 지원한다.\n-기록을 관리한다.\n-서비스를 제... 기반으로 50로 평가","income":"income는 [가사관리사]\n-청소를 실시한다.\n-세탁을 한다.\n-요리를 준비한다.\n-장보기를 한다.\n-가구를 관리한다.\n-안전을 유지한다.\n-고객을 지원한다.\n-기록을 관리한다.\n-서비스를 제... 기반으로 50로 평가","teamwork":"teamwork는 [가사관리사]\n-청소를 실시한다.\n-세탁을 한다.\n-요리를 준비한다.\n-장보기를 한다.\n-가구를 관리한다.\n-안전을 유지한다.\n-고객을 지원한다.\n-기록을 관리한다.\n-서비스를 제... 기반으로 50로 평가","solo_deep":"solo_deep는 [가사관리사]\n-청소를 실시한다.\n-세탁을 한다.\n-요리를 준비한다.\n-장보기를 한다.\n-가구를 관리한다.\n-안전을 유지한다.\n-고객을 지원한다.\n-기록을 관리한다.\n-서비스를 제... 기반으로 50로 평가","analytical":"analytical는 [가사관리사]\n-청소를 실시한다.\n-세탁을 한다.\n-요리를 준비한다.\n-장보기를 한다.\n-가구를 관리한다.\n-안전을 유지한다.\n-고객을 지원한다.\n-기록을 관리한다.\n-서비스를 제... 기반으로 40로 평가","creative":"creative는 [가사관리사]\n-청소를 실시한다.\n-세탁을 한다.\n-요리를 준비한다.\n-장보기를 한다.\n-가구를 관리한다.\n-안전을 유지한다.\n-고객을 지원한다.\n-기록을 관리한다.\n-서비스를 제... 기반으로 40로 평가","execution":"execution는 [가사관리사]\n-청소를 실시한다.\n-세탁을 한다.\n-요리를 준비한다.\n-장보기를 한다.\n-가구를 관리한다.\n-안전을 유지한다.\n-고객을 지원한다.\n-기록을 관리한다.\n-서비스를 제... 기반으로 70로 평가","people_facing":"people_facing는 [가사관리사]\n-청소를 실시한다.\n-세탁을 한다.\n-요리를 준비한다.\n-장보기를 한다.\n-가구를 관리한다.\n-안전을 유지한다.\n-고객을 지원한다.\n-기록을 관리한다.\n-서비스를 제... 기반으로 75로 평가","degree_required":"degree_required는 [가사관리사]\n-청소를 실시한다.\n-세탁을 한다.\n-요리를 준비한다.\n-장보기를 한다.\n-가구를 관리한다.\n-안전을 유지한다.\n-고객을 지원한다.\n-기록을 관리한다.\n-서비스를 제... 기반으로 none로 평가","license_required":"license_required는 [가사관리사]\n-청소를 실시한다.\n-세탁을 한다.\n-요리를 준비한다.\n-장보기를 한다.\n-가구를 관리한다.\n-안전을 유지한다.\n-고객을 지원한다.\n-기록을 관리한다.\n-서비스를 제... 기반으로 none로 평가"}'
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