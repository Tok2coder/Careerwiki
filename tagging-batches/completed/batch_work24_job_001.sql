-- Batch tagging SQL generated at 2026-01-06T06:53:57.667Z
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
  '1765283487501141',
  '상품중개인 및 경매사',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  40, 50, 50, 50,
  30, 70, 60, 30, 60, 75,
  'overtime_some', 'none', 'frequent', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [골동품경매사]\n-골동품 경매를 위해 인터넷 또는 방문을 통하여 출품 접수를 받는다.\n-감정서를 참고하여 골동품의 진위여부를 확인한다.\n-경매 일시와 장소를 결정한다.\n-경매할 품... 기반으로 40로 평가","growth":"growth는 [골동품경매사]\n-골동품 경매를 위해 인터넷 또는 방문을 통하여 출품 접수를 받는다.\n-감정서를 참고하여 골동품의 진위여부를 확인한다.\n-경매 일시와 장소를 결정한다.\n-경매할 품... 기반으로 50로 평가","stability":"stability는 [골동품경매사]\n-골동품 경매를 위해 인터넷 또는 방문을 통하여 출품 접수를 받는다.\n-감정서를 참고하여 골동품의 진위여부를 확인한다.\n-경매 일시와 장소를 결정한다.\n-경매할 품... 기반으로 50로 평가","income":"income는 [골동품경매사]\n-골동품 경매를 위해 인터넷 또는 방문을 통하여 출품 접수를 받는다.\n-감정서를 참고하여 골동품의 진위여부를 확인한다.\n-경매 일시와 장소를 결정한다.\n-경매할 품... 기반으로 50로 평가","teamwork":"teamwork는 [골동품경매사]\n-골동품 경매를 위해 인터넷 또는 방문을 통하여 출품 접수를 받는다.\n-감정서를 참고하여 골동품의 진위여부를 확인한다.\n-경매 일시와 장소를 결정한다.\n-경매할 품... 기반으로 30로 평가","solo_deep":"solo_deep는 [골동품경매사]\n-골동품 경매를 위해 인터넷 또는 방문을 통하여 출품 접수를 받는다.\n-감정서를 참고하여 골동품의 진위여부를 확인한다.\n-경매 일시와 장소를 결정한다.\n-경매할 품... 기반으로 70로 평가","analytical":"analytical는 [골동품경매사]\n-골동품 경매를 위해 인터넷 또는 방문을 통하여 출품 접수를 받는다.\n-감정서를 참고하여 골동품의 진위여부를 확인한다.\n-경매 일시와 장소를 결정한다.\n-경매할 품... 기반으로 60로 평가","creative":"creative는 [골동품경매사]\n-골동품 경매를 위해 인터넷 또는 방문을 통하여 출품 접수를 받는다.\n-감정서를 참고하여 골동품의 진위여부를 확인한다.\n-경매 일시와 장소를 결정한다.\n-경매할 품... 기반으로 30로 평가","execution":"execution는 [골동품경매사]\n-골동품 경매를 위해 인터넷 또는 방문을 통하여 출품 접수를 받는다.\n-감정서를 참고하여 골동품의 진위여부를 확인한다.\n-경매 일시와 장소를 결정한다.\n-경매할 품... 기반으로 60로 평가","people_facing":"people_facing는 [골동품경매사]\n-골동품 경매를 위해 인터넷 또는 방문을 통하여 출품 접수를 받는다.\n-감정서를 참고하여 골동품의 진위여부를 확인한다.\n-경매 일시와 장소를 결정한다.\n-경매할 품... 기반으로 75로 평가","degree_required":"degree_required는 [골동품경매사]\n-골동품 경매를 위해 인터넷 또는 방문을 통하여 출품 접수를 받는다.\n-감정서를 참고하여 골동품의 진위여부를 확인한다.\n-경매 일시와 장소를 결정한다.\n-경매할 품... 기반으로 none로 평가","license_required":"license_required는 [골동품경매사]\n-골동품 경매를 위해 인터넷 또는 방문을 통하여 출품 접수를 받는다.\n-감정서를 참고하여 골동품의 진위여부를 확인한다.\n-경매 일시와 장소를 결정한다.\n-경매할 품... 기반으로 none로 평가"}'
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
  '1765283478991492',
  '숙박시설서비스원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  20, 50, 50, 50,
  70, 30, 60, 30, 60, 75,
  'regular', 'required', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [호텔서비스원]\n-고객이 숙박시설에 도착하면 고객의 예약사항을 확인하고 고객을 안내한다.\n-고객의 짐을 운반하고 객실을 배정한다.\n-객실의 청결상태를 점검하고 고객의 요구사항을 확... 기반으로 20로 평가","growth":"growth는 [호텔서비스원]\n-고객이 숙박시설에 도착하면 고객의 예약사항을 확인하고 고객을 안내한다.\n-고객의 짐을 운반하고 객실을 배정한다.\n-객실의 청결상태를 점검하고 고객의 요구사항을 확... 기반으로 50로 평가","stability":"stability는 [호텔서비스원]\n-고객이 숙박시설에 도착하면 고객의 예약사항을 확인하고 고객을 안내한다.\n-고객의 짐을 운반하고 객실을 배정한다.\n-객실의 청결상태를 점검하고 고객의 요구사항을 확... 기반으로 50로 평가","income":"income는 [호텔서비스원]\n-고객이 숙박시설에 도착하면 고객의 예약사항을 확인하고 고객을 안내한다.\n-고객의 짐을 운반하고 객실을 배정한다.\n-객실의 청결상태를 점검하고 고객의 요구사항을 확... 기반으로 50로 평가","teamwork":"teamwork는 [호텔서비스원]\n-고객이 숙박시설에 도착하면 고객의 예약사항을 확인하고 고객을 안내한다.\n-고객의 짐을 운반하고 객실을 배정한다.\n-객실의 청결상태를 점검하고 고객의 요구사항을 확... 기반으로 70로 평가","solo_deep":"solo_deep는 [호텔서비스원]\n-고객이 숙박시설에 도착하면 고객의 예약사항을 확인하고 고객을 안내한다.\n-고객의 짐을 운반하고 객실을 배정한다.\n-객실의 청결상태를 점검하고 고객의 요구사항을 확... 기반으로 30로 평가","analytical":"analytical는 [호텔서비스원]\n-고객이 숙박시설에 도착하면 고객의 예약사항을 확인하고 고객을 안내한다.\n-고객의 짐을 운반하고 객실을 배정한다.\n-객실의 청결상태를 점검하고 고객의 요구사항을 확... 기반으로 60로 평가","creative":"creative는 [호텔서비스원]\n-고객이 숙박시설에 도착하면 고객의 예약사항을 확인하고 고객을 안내한다.\n-고객의 짐을 운반하고 객실을 배정한다.\n-객실의 청결상태를 점검하고 고객의 요구사항을 확... 기반으로 30로 평가","execution":"execution는 [호텔서비스원]\n-고객이 숙박시설에 도착하면 고객의 예약사항을 확인하고 고객을 안내한다.\n-고객의 짐을 운반하고 객실을 배정한다.\n-객실의 청결상태를 점검하고 고객의 요구사항을 확... 기반으로 60로 평가","people_facing":"people_facing는 [호텔서비스원]\n-고객이 숙박시설에 도착하면 고객의 예약사항을 확인하고 고객을 안내한다.\n-고객의 짐을 운반하고 객실을 배정한다.\n-객실의 청결상태를 점검하고 고객의 요구사항을 확... 기반으로 75로 평가","degree_required":"degree_required는 [호텔서비스원]\n-고객이 숙박시설에 도착하면 고객의 예약사항을 확인하고 고객을 안내한다.\n-고객의 짐을 운반하고 객실을 배정한다.\n-객실의 청결상태를 점검하고 고객의 요구사항을 확... 기반으로 none로 평가","license_required":"license_required는 [호텔서비스원]\n-고객이 숙박시설에 도착하면 고객의 예약사항을 확인하고 고객을 안내한다.\n-고객의 짐을 운반하고 객실을 배정한다.\n-객실의 청결상태를 점검하고 고객의 요구사항을 확... 기반으로 none로 평가"}'
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
  '1765283429959345',
  '은행사무원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  40, 50, 70, 50,
  70, 30, 40, 40, 70, 75,
  'overtime_some', 'none', 'some', 'partial',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [은행창구사무원]\n-고객이 은행을 방문하면 고객의 신분을 확인하고 업무를 안내한다.\n-예금, 출금, 송금 등의 업무를 처리한다.\n-통장 개설, 해지 등의 업무를 담당한다.\n-대출 ... 기반으로 40로 평가","growth":"growth는 [은행창구사무원]\n-고객이 은행을 방문하면 고객의 신분을 확인하고 업무를 안내한다.\n-예금, 출금, 송금 등의 업무를 처리한다.\n-통장 개설, 해지 등의 업무를 담당한다.\n-대출 ... 기반으로 50로 평가","stability":"stability는 [은행창구사무원]\n-고객이 은행을 방문하면 고객의 신분을 확인하고 업무를 안내한다.\n-예금, 출금, 송금 등의 업무를 처리한다.\n-통장 개설, 해지 등의 업무를 담당한다.\n-대출 ... 기반으로 70로 평가","income":"income는 [은행창구사무원]\n-고객이 은행을 방문하면 고객의 신분을 확인하고 업무를 안내한다.\n-예금, 출금, 송금 등의 업무를 처리한다.\n-통장 개설, 해지 등의 업무를 담당한다.\n-대출 ... 기반으로 50로 평가","teamwork":"teamwork는 [은행창구사무원]\n-고객이 은행을 방문하면 고객의 신분을 확인하고 업무를 안내한다.\n-예금, 출금, 송금 등의 업무를 처리한다.\n-통장 개설, 해지 등의 업무를 담당한다.\n-대출 ... 기반으로 70로 평가","solo_deep":"solo_deep는 [은행창구사무원]\n-고객이 은행을 방문하면 고객의 신분을 확인하고 업무를 안내한다.\n-예금, 출금, 송금 등의 업무를 처리한다.\n-통장 개설, 해지 등의 업무를 담당한다.\n-대출 ... 기반으로 30로 평가","analytical":"analytical는 [은행창구사무원]\n-고객이 은행을 방문하면 고객의 신분을 확인하고 업무를 안내한다.\n-예금, 출금, 송금 등의 업무를 처리한다.\n-통장 개설, 해지 등의 업무를 담당한다.\n-대출 ... 기반으로 40로 평가","creative":"creative는 [은행창구사무원]\n-고객이 은행을 방문하면 고객의 신분을 확인하고 업무를 안내한다.\n-예금, 출금, 송금 등의 업무를 처리한다.\n-통장 개설, 해지 등의 업무를 담당한다.\n-대출 ... 기반으로 40로 평가","execution":"execution는 [은행창구사무원]\n-고객이 은행을 방문하면 고객의 신분을 확인하고 업무를 안내한다.\n-예금, 출금, 송금 등의 업무를 처리한다.\n-통장 개설, 해지 등의 업무를 담당한다.\n-대출 ... 기반으로 70로 평가","people_facing":"people_facing는 [은행창구사무원]\n-고객이 은행을 방문하면 고객의 신분을 확인하고 업무를 안내한다.\n-예금, 출금, 송금 등의 업무를 처리한다.\n-통장 개설, 해지 등의 업무를 담당한다.\n-대출 ... 기반으로 75로 평가","degree_required":"degree_required는 [은행창구사무원]\n-고객이 은행을 방문하면 고객의 신분을 확인하고 업무를 안내한다.\n-예금, 출금, 송금 등의 업무를 처리한다.\n-통장 개설, 해지 등의 업무를 담당한다.\n-대출 ... 기반으로 none로 평가","license_required":"license_required는 [은행창구사무원]\n-고객이 은행을 방문하면 고객의 신분을 확인하고 업무를 안내한다.\n-예금, 출금, 송금 등의 업무를 처리한다.\n-통장 개설, 해지 등의 업무를 담당한다.\n-대출 ... 기반으로 none로 평가"}'
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
  '1765283487786895',
  '해외영업원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 30, 50,
  50, 50, 60, 30, 60, 75,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [해외시장영업원]\n-해외 시장 동향을 조사하고 분석한다.\n-해외 고객과 잠재 고객을 발굴한다.\n-해외 전시회나 박람회에 참가한다.\n-해외 바이어와 미팅을 진행한다.\n-수출 계약을 ... 기반으로 50로 평가","growth":"growth는 [해외시장영업원]\n-해외 시장 동향을 조사하고 분석한다.\n-해외 고객과 잠재 고객을 발굴한다.\n-해외 전시회나 박람회에 참가한다.\n-해외 바이어와 미팅을 진행한다.\n-수출 계약을 ... 기반으로 50로 평가","stability":"stability는 [해외시장영업원]\n-해외 시장 동향을 조사하고 분석한다.\n-해외 고객과 잠재 고객을 발굴한다.\n-해외 전시회나 박람회에 참가한다.\n-해외 바이어와 미팅을 진행한다.\n-수출 계약을 ... 기반으로 30로 평가","income":"income는 [해외시장영업원]\n-해외 시장 동향을 조사하고 분석한다.\n-해외 고객과 잠재 고객을 발굴한다.\n-해외 전시회나 박람회에 참가한다.\n-해외 바이어와 미팅을 진행한다.\n-수출 계약을 ... 기반으로 50로 평가","teamwork":"teamwork는 [해외시장영업원]\n-해외 시장 동향을 조사하고 분석한다.\n-해외 고객과 잠재 고객을 발굴한다.\n-해외 전시회나 박람회에 참가한다.\n-해외 바이어와 미팅을 진행한다.\n-수출 계약을 ... 기반으로 50로 평가","solo_deep":"solo_deep는 [해외시장영업원]\n-해외 시장 동향을 조사하고 분석한다.\n-해외 고객과 잠재 고객을 발굴한다.\n-해외 전시회나 박람회에 참가한다.\n-해외 바이어와 미팅을 진행한다.\n-수출 계약을 ... 기반으로 50로 평가","analytical":"analytical는 [해외시장영업원]\n-해외 시장 동향을 조사하고 분석한다.\n-해외 고객과 잠재 고객을 발굴한다.\n-해외 전시회나 박람회에 참가한다.\n-해외 바이어와 미팅을 진행한다.\n-수출 계약을 ... 기반으로 60로 평가","creative":"creative는 [해외시장영업원]\n-해외 시장 동향을 조사하고 분석한다.\n-해외 고객과 잠재 고객을 발굴한다.\n-해외 전시회나 박람회에 참가한다.\n-해외 바이어와 미팅을 진행한다.\n-수출 계약을 ... 기반으로 30로 평가","execution":"execution는 [해외시장영업원]\n-해외 시장 동향을 조사하고 분석한다.\n-해외 고객과 잠재 고객을 발굴한다.\n-해외 전시회나 박람회에 참가한다.\n-해외 바이어와 미팅을 진행한다.\n-수출 계약을 ... 기반으로 60로 평가","people_facing":"people_facing는 [해외시장영업원]\n-해외 시장 동향을 조사하고 분석한다.\n-해외 고객과 잠재 고객을 발굴한다.\n-해외 전시회나 박람회에 참가한다.\n-해외 바이어와 미팅을 진행한다.\n-수출 계약을 ... 기반으로 75로 평가","degree_required":"degree_required는 [해외시장영업원]\n-해외 시장 동향을 조사하고 분석한다.\n-해외 고객과 잠재 고객을 발굴한다.\n-해외 전시회나 박람회에 참가한다.\n-해외 바이어와 미팅을 진행한다.\n-수출 계약을 ... 기반으로 none로 평가","license_required":"license_required는 [해외시장영업원]\n-해외 시장 동향을 조사하고 분석한다.\n-해외 고객과 잠재 고객을 발굴한다.\n-해외 전시회나 박람회에 참가한다.\n-해외 바이어와 미팅을 진행한다.\n-수출 계약을 ... 기반으로 none로 평가"}'
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
  '1765283473274744',
  '연극영화방송기술감독',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 50, 40,
  70, 30, 30, 60, 60, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [연극기술감독]\n-연극 공연의 기술적 측면을 총괄한다.\n-무대 설계와 조명을 기획한다.\n-음향 시스템을 구성한다.\n-특수 효과를 준비한다.\n-리허설을 감독한다.\n-공연 중 기술 문... 기반으로 50로 평가","growth":"growth는 [연극기술감독]\n-연극 공연의 기술적 측면을 총괄한다.\n-무대 설계와 조명을 기획한다.\n-음향 시스템을 구성한다.\n-특수 효과를 준비한다.\n-리허설을 감독한다.\n-공연 중 기술 문... 기반으로 65로 평가","stability":"stability는 [연극기술감독]\n-연극 공연의 기술적 측면을 총괄한다.\n-무대 설계와 조명을 기획한다.\n-음향 시스템을 구성한다.\n-특수 효과를 준비한다.\n-리허설을 감독한다.\n-공연 중 기술 문... 기반으로 50로 평가","income":"income는 [연극기술감독]\n-연극 공연의 기술적 측면을 총괄한다.\n-무대 설계와 조명을 기획한다.\n-음향 시스템을 구성한다.\n-특수 효과를 준비한다.\n-리허설을 감독한다.\n-공연 중 기술 문... 기반으로 40로 평가","teamwork":"teamwork는 [연극기술감독]\n-연극 공연의 기술적 측면을 총괄한다.\n-무대 설계와 조명을 기획한다.\n-음향 시스템을 구성한다.\n-특수 효과를 준비한다.\n-리허설을 감독한다.\n-공연 중 기술 문... 기반으로 70로 평가","solo_deep":"solo_deep는 [연극기술감독]\n-연극 공연의 기술적 측면을 총괄한다.\n-무대 설계와 조명을 기획한다.\n-음향 시스템을 구성한다.\n-특수 효과를 준비한다.\n-리허설을 감독한다.\n-공연 중 기술 문... 기반으로 30로 평가","analytical":"analytical는 [연극기술감독]\n-연극 공연의 기술적 측면을 총괄한다.\n-무대 설계와 조명을 기획한다.\n-음향 시스템을 구성한다.\n-특수 효과를 준비한다.\n-리허설을 감독한다.\n-공연 중 기술 문... 기반으로 30로 평가","creative":"creative는 [연극기술감독]\n-연극 공연의 기술적 측면을 총괄한다.\n-무대 설계와 조명을 기획한다.\n-음향 시스템을 구성한다.\n-특수 효과를 준비한다.\n-리허설을 감독한다.\n-공연 중 기술 문... 기반으로 60로 평가","execution":"execution는 [연극기술감독]\n-연극 공연의 기술적 측면을 총괄한다.\n-무대 설계와 조명을 기획한다.\n-음향 시스템을 구성한다.\n-특수 효과를 준비한다.\n-리허설을 감독한다.\n-공연 중 기술 문... 기반으로 60로 평가","people_facing":"people_facing는 [연극기술감독]\n-연극 공연의 기술적 측면을 총괄한다.\n-무대 설계와 조명을 기획한다.\n-음향 시스템을 구성한다.\n-특수 효과를 준비한다.\n-리허설을 감독한다.\n-공연 중 기술 문... 기반으로 50로 평가","degree_required":"degree_required는 [연극기술감독]\n-연극 공연의 기술적 측면을 총괄한다.\n-무대 설계와 조명을 기획한다.\n-음향 시스템을 구성한다.\n-특수 효과를 준비한다.\n-리허설을 감독한다.\n-공연 중 기술 문... 기반으로 none로 평가","license_required":"license_required는 [연극기술감독]\n-연극 공연의 기술적 측면을 총괄한다.\n-무대 설계와 조명을 기획한다.\n-음향 시스템을 구성한다.\n-특수 효과를 준비한다.\n-리허설을 감독한다.\n-공연 중 기술 문... 기반으로 none로 평가"}'
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
  '1765283479325614',
  '오락시설서비스원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  50, 50, 60, 30, 60, 75,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [놀이공원서비스원]\n-고객이 놀이공원에 도착하면 안내한다.\n-티켓 판매와 검표를 담당한다.\n-놀이기구 안전을 점검한다.\n-고객의 안전을 감독한다.\n-시설 청결을 유지한다.\n-고객 ... 기반으로 50로 평가","growth":"growth는 [놀이공원서비스원]\n-고객이 놀이공원에 도착하면 안내한다.\n-티켓 판매와 검표를 담당한다.\n-놀이기구 안전을 점검한다.\n-고객의 안전을 감독한다.\n-시설 청결을 유지한다.\n-고객 ... 기반으로 50로 평가","stability":"stability는 [놀이공원서비스원]\n-고객이 놀이공원에 도착하면 안내한다.\n-티켓 판매와 검표를 담당한다.\n-놀이기구 안전을 점검한다.\n-고객의 안전을 감독한다.\n-시설 청결을 유지한다.\n-고객 ... 기반으로 50로 평가","income":"income는 [놀이공원서비스원]\n-고객이 놀이공원에 도착하면 안내한다.\n-티켓 판매와 검표를 담당한다.\n-놀이기구 안전을 점검한다.\n-고객의 안전을 감독한다.\n-시설 청결을 유지한다.\n-고객 ... 기반으로 50로 평가","teamwork":"teamwork는 [놀이공원서비스원]\n-고객이 놀이공원에 도착하면 안내한다.\n-티켓 판매와 검표를 담당한다.\n-놀이기구 안전을 점검한다.\n-고객의 안전을 감독한다.\n-시설 청결을 유지한다.\n-고객 ... 기반으로 50로 평가","solo_deep":"solo_deep는 [놀이공원서비스원]\n-고객이 놀이공원에 도착하면 안내한다.\n-티켓 판매와 검표를 담당한다.\n-놀이기구 안전을 점검한다.\n-고객의 안전을 감독한다.\n-시설 청결을 유지한다.\n-고객 ... 기반으로 50로 평가","analytical":"analytical는 [놀이공원서비스원]\n-고객이 놀이공원에 도착하면 안내한다.\n-티켓 판매와 검표를 담당한다.\n-놀이기구 안전을 점검한다.\n-고객의 안전을 감독한다.\n-시설 청결을 유지한다.\n-고객 ... 기반으로 60로 평가","creative":"creative는 [놀이공원서비스원]\n-고객이 놀이공원에 도착하면 안내한다.\n-티켓 판매와 검표를 담당한다.\n-놀이기구 안전을 점검한다.\n-고객의 안전을 감독한다.\n-시설 청결을 유지한다.\n-고객 ... 기반으로 30로 평가","execution":"execution는 [놀이공원서비스원]\n-고객이 놀이공원에 도착하면 안내한다.\n-티켓 판매와 검표를 담당한다.\n-놀이기구 안전을 점검한다.\n-고객의 안전을 감독한다.\n-시설 청결을 유지한다.\n-고객 ... 기반으로 60로 평가","people_facing":"people_facing는 [놀이공원서비스원]\n-고객이 놀이공원에 도착하면 안내한다.\n-티켓 판매와 검표를 담당한다.\n-놀이기구 안전을 점검한다.\n-고객의 안전을 감독한다.\n-시설 청결을 유지한다.\n-고객 ... 기반으로 75로 평가","degree_required":"degree_required는 [놀이공원서비스원]\n-고객이 놀이공원에 도착하면 안내한다.\n-티켓 판매와 검표를 담당한다.\n-놀이기구 안전을 점검한다.\n-고객의 안전을 감독한다.\n-시설 청결을 유지한다.\n-고객 ... 기반으로 none로 평가","license_required":"license_required는 [놀이공원서비스원]\n-고객이 놀이공원에 도착하면 안내한다.\n-티켓 판매와 검표를 담당한다.\n-놀이기구 안전을 점검한다.\n-고객의 안전을 감독한다.\n-시설 청결을 유지한다.\n-고객 ... 기반으로 none로 평가"}'
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
  '1765283460443102',
  '직업상담사',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 60, 50, 50,
  50, 50, 40, 40, 70, 75,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [직업상담센터상담사]\n-구직자의 경력과 희망사항을 파악한다.\n-적합한 직업을 추천한다.\n-이력서와 자기소개서 작성을 지원한다.\n-면접 준비를 돕는다.\n-직업 정보를 제공한다.\n-진... 기반으로 50로 평가","growth":"growth는 [직업상담센터상담사]\n-구직자의 경력과 희망사항을 파악한다.\n-적합한 직업을 추천한다.\n-이력서와 자기소개서 작성을 지원한다.\n-면접 준비를 돕는다.\n-직업 정보를 제공한다.\n-진... 기반으로 60로 평가","stability":"stability는 [직업상담센터상담사]\n-구직자의 경력과 희망사항을 파악한다.\n-적합한 직업을 추천한다.\n-이력서와 자기소개서 작성을 지원한다.\n-면접 준비를 돕는다.\n-직업 정보를 제공한다.\n-진... 기반으로 50로 평가","income":"income는 [직업상담센터상담사]\n-구직자의 경력과 희망사항을 파악한다.\n-적합한 직업을 추천한다.\n-이력서와 자기소개서 작성을 지원한다.\n-면접 준비를 돕는다.\n-직업 정보를 제공한다.\n-진... 기반으로 50로 평가","teamwork":"teamwork는 [직업상담센터상담사]\n-구직자의 경력과 희망사항을 파악한다.\n-적합한 직업을 추천한다.\n-이력서와 자기소개서 작성을 지원한다.\n-면접 준비를 돕는다.\n-직업 정보를 제공한다.\n-진... 기반으로 50로 평가","solo_deep":"solo_deep는 [직업상담센터상담사]\n-구직자의 경력과 희망사항을 파악한다.\n-적합한 직업을 추천한다.\n-이력서와 자기소개서 작성을 지원한다.\n-면접 준비를 돕는다.\n-직업 정보를 제공한다.\n-진... 기반으로 50로 평가","analytical":"analytical는 [직업상담센터상담사]\n-구직자의 경력과 희망사항을 파악한다.\n-적합한 직업을 추천한다.\n-이력서와 자기소개서 작성을 지원한다.\n-면접 준비를 돕는다.\n-직업 정보를 제공한다.\n-진... 기반으로 40로 평가","creative":"creative는 [직업상담센터상담사]\n-구직자의 경력과 희망사항을 파악한다.\n-적합한 직업을 추천한다.\n-이력서와 자기소개서 작성을 지원한다.\n-면접 준비를 돕는다.\n-직업 정보를 제공한다.\n-진... 기반으로 40로 평가","execution":"execution는 [직업상담센터상담사]\n-구직자의 경력과 희망사항을 파악한다.\n-적합한 직업을 추천한다.\n-이력서와 자기소개서 작성을 지원한다.\n-면접 준비를 돕는다.\n-직업 정보를 제공한다.\n-진... 기반으로 70로 평가","people_facing":"people_facing는 [직업상담센터상담사]\n-구직자의 경력과 희망사항을 파악한다.\n-적합한 직업을 추천한다.\n-이력서와 자기소개서 작성을 지원한다.\n-면접 준비를 돕는다.\n-직업 정보를 제공한다.\n-진... 기반으로 75로 평가","degree_required":"degree_required는 [직업상담센터상담사]\n-구직자의 경력과 희망사항을 파악한다.\n-적합한 직업을 추천한다.\n-이력서와 자기소개서 작성을 지원한다.\n-면접 준비를 돕는다.\n-직업 정보를 제공한다.\n-진... 기반으로 none로 평가","license_required":"license_required는 [직업상담센터상담사]\n-구직자의 경력과 희망사항을 파악한다.\n-적합한 직업을 추천한다.\n-이력서와 자기소개서 작성을 지원한다.\n-면접 준비를 돕는다.\n-직업 정보를 제공한다.\n-진... 기반으로 none로 평가"}'
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
  '1765283430223155',
  '보험보상사무원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  40, 50, 50, 50,
  50, 50, 60, 30, 60, 75,
  'overtime_some', 'none', 'some', 'partial',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [보험금청구접수사무원]\n-보험금 청구 서류를 접수한다.\n-청구 서류의 완전성을 확인한다.\n-보험 계약 내용을 검토한다.\n-보험금 지급 여부를 판단한다.\n-보험금 액수를 계산한다.\n... 기반으로 40로 평가","growth":"growth는 [보험금청구접수사무원]\n-보험금 청구 서류를 접수한다.\n-청구 서류의 완전성을 확인한다.\n-보험 계약 내용을 검토한다.\n-보험금 지급 여부를 판단한다.\n-보험금 액수를 계산한다.\n... 기반으로 50로 평가","stability":"stability는 [보험금청구접수사무원]\n-보험금 청구 서류를 접수한다.\n-청구 서류의 완전성을 확인한다.\n-보험 계약 내용을 검토한다.\n-보험금 지급 여부를 판단한다.\n-보험금 액수를 계산한다.\n... 기반으로 50로 평가","income":"income는 [보험금청구접수사무원]\n-보험금 청구 서류를 접수한다.\n-청구 서류의 완전성을 확인한다.\n-보험 계약 내용을 검토한다.\n-보험금 지급 여부를 판단한다.\n-보험금 액수를 계산한다.\n... 기반으로 50로 평가","teamwork":"teamwork는 [보험금청구접수사무원]\n-보험금 청구 서류를 접수한다.\n-청구 서류의 완전성을 확인한다.\n-보험 계약 내용을 검토한다.\n-보험금 지급 여부를 판단한다.\n-보험금 액수를 계산한다.\n... 기반으로 50로 평가","solo_deep":"solo_deep는 [보험금청구접수사무원]\n-보험금 청구 서류를 접수한다.\n-청구 서류의 완전성을 확인한다.\n-보험 계약 내용을 검토한다.\n-보험금 지급 여부를 판단한다.\n-보험금 액수를 계산한다.\n... 기반으로 50로 평가","analytical":"analytical는 [보험금청구접수사무원]\n-보험금 청구 서류를 접수한다.\n-청구 서류의 완전성을 확인한다.\n-보험 계약 내용을 검토한다.\n-보험금 지급 여부를 판단한다.\n-보험금 액수를 계산한다.\n... 기반으로 60로 평가","creative":"creative는 [보험금청구접수사무원]\n-보험금 청구 서류를 접수한다.\n-청구 서류의 완전성을 확인한다.\n-보험 계약 내용을 검토한다.\n-보험금 지급 여부를 판단한다.\n-보험금 액수를 계산한다.\n... 기반으로 30로 평가","execution":"execution는 [보험금청구접수사무원]\n-보험금 청구 서류를 접수한다.\n-청구 서류의 완전성을 확인한다.\n-보험 계약 내용을 검토한다.\n-보험금 지급 여부를 판단한다.\n-보험금 액수를 계산한다.\n... 기반으로 60로 평가","people_facing":"people_facing는 [보험금청구접수사무원]\n-보험금 청구 서류를 접수한다.\n-청구 서류의 완전성을 확인한다.\n-보험 계약 내용을 검토한다.\n-보험금 지급 여부를 판단한다.\n-보험금 액수를 계산한다.\n... 기반으로 75로 평가","degree_required":"degree_required는 [보험금청구접수사무원]\n-보험금 청구 서류를 접수한다.\n-청구 서류의 완전성을 확인한다.\n-보험 계약 내용을 검토한다.\n-보험금 지급 여부를 판단한다.\n-보험금 액수를 계산한다.\n... 기반으로 none로 평가","license_required":"license_required는 [보험금청구접수사무원]\n-보험금 청구 서류를 접수한다.\n-청구 서류의 완전성을 확인한다.\n-보험 계약 내용을 검토한다.\n-보험금 지급 여부를 판단한다.\n-보험금 액수를 계산한다.\n... 기반으로 none로 평가"}'
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
  '1765283494451924',
  '전통건축기능원',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 65, 50, 50,
  50, 50, 60, 30, 60, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [한옥기능원]\n-전통 한옥 건축을 설계한다.\n-전통 재료를 준비한다.\n-기초 공사를 진행한다.\n-목재 골조를 조립한다.\n-지붕을 설치한다.\n-마무리 공사를 한다.\n-전통 기법을 적... 기반으로 50로 평가","growth":"growth는 [한옥기능원]\n-전통 한옥 건축을 설계한다.\n-전통 재료를 준비한다.\n-기초 공사를 진행한다.\n-목재 골조를 조립한다.\n-지붕을 설치한다.\n-마무리 공사를 한다.\n-전통 기법을 적... 기반으로 65로 평가","stability":"stability는 [한옥기능원]\n-전통 한옥 건축을 설계한다.\n-전통 재료를 준비한다.\n-기초 공사를 진행한다.\n-목재 골조를 조립한다.\n-지붕을 설치한다.\n-마무리 공사를 한다.\n-전통 기법을 적... 기반으로 50로 평가","income":"income는 [한옥기능원]\n-전통 한옥 건축을 설계한다.\n-전통 재료를 준비한다.\n-기초 공사를 진행한다.\n-목재 골조를 조립한다.\n-지붕을 설치한다.\n-마무리 공사를 한다.\n-전통 기법을 적... 기반으로 50로 평가","teamwork":"teamwork는 [한옥기능원]\n-전통 한옥 건축을 설계한다.\n-전통 재료를 준비한다.\n-기초 공사를 진행한다.\n-목재 골조를 조립한다.\n-지붕을 설치한다.\n-마무리 공사를 한다.\n-전통 기법을 적... 기반으로 50로 평가","solo_deep":"solo_deep는 [한옥기능원]\n-전통 한옥 건축을 설계한다.\n-전통 재료를 준비한다.\n-기초 공사를 진행한다.\n-목재 골조를 조립한다.\n-지붕을 설치한다.\n-마무리 공사를 한다.\n-전통 기법을 적... 기반으로 50로 평가","analytical":"analytical는 [한옥기능원]\n-전통 한옥 건축을 설계한다.\n-전통 재료를 준비한다.\n-기초 공사를 진행한다.\n-목재 골조를 조립한다.\n-지붕을 설치한다.\n-마무리 공사를 한다.\n-전통 기법을 적... 기반으로 60로 평가","creative":"creative는 [한옥기능원]\n-전통 한옥 건축을 설계한다.\n-전통 재료를 준비한다.\n-기초 공사를 진행한다.\n-목재 골조를 조립한다.\n-지붕을 설치한다.\n-마무리 공사를 한다.\n-전통 기법을 적... 기반으로 30로 평가","execution":"execution는 [한옥기능원]\n-전통 한옥 건축을 설계한다.\n-전통 재료를 준비한다.\n-기초 공사를 진행한다.\n-목재 골조를 조립한다.\n-지붕을 설치한다.\n-마무리 공사를 한다.\n-전통 기법을 적... 기반으로 60로 평가","people_facing":"people_facing는 [한옥기능원]\n-전통 한옥 건축을 설계한다.\n-전통 재료를 준비한다.\n-기초 공사를 진행한다.\n-목재 골조를 조립한다.\n-지붕을 설치한다.\n-마무리 공사를 한다.\n-전통 기법을 적... 기반으로 50로 평가","degree_required":"degree_required는 [한옥기능원]\n-전통 한옥 건축을 설계한다.\n-전통 재료를 준비한다.\n-기초 공사를 진행한다.\n-목재 골조를 조립한다.\n-지붕을 설치한다.\n-마무리 공사를 한다.\n-전통 기법을 적... 기반으로 none로 평가","license_required":"license_required는 [한옥기능원]\n-전통 한옥 건축을 설계한다.\n-전통 재료를 준비한다.\n-기초 공사를 진행한다.\n-목재 골조를 조립한다.\n-지붕을 설치한다.\n-마무리 공사를 한다.\n-전통 기법을 적... 기반으로 none로 평가"}'
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
  '1765283491867444',
  '항공기조종사',
  'WORK24_JOB',
  'tagger-v1.0.0',
  'tagged',
  50, 50, 50, 50,
  50, 50, 40, 40, 70, 50,
  'regular', 'none', 'none', 'none',
  'none', 'none', 'none',
  0.66,
  '{"wlb":0.7,"growth":0.7,"stability":0.7,"income":0.6,"teamwork":0.7,"solo_deep":0.7,"analytical":0.7,"creative":0.7,"execution":0.7,"people_facing":0.7,"degree_required":0.49999999999999994,"license_required":0.49999999999999994}',
  '{"wlb":"wlb는 [여객기조종사]\n-비행 계획을 수립한다.\n-항공기 사전 점검을 실시한다.\n-이륙과 착륙을 담당한다.\n-비행 중 항공기를 조종한다.\n-항공 교통 관제와 통신한다.\n-기상 조건을 모니... 기반으로 50로 평가","growth":"growth는 [여객기조종사]\n-비행 계획을 수립한다.\n-항공기 사전 점검을 실시한다.\n-이륙과 착륙을 담당한다.\n-비행 중 항공기를 조종한다.\n-항공 교통 관제와 통신한다.\n-기상 조건을 모니... 기반으로 50로 평가","stability":"stability는 [여객기조종사]\n-비행 계획을 수립한다.\n-항공기 사전 점검을 실시한다.\n-이륙과 착륙을 담당한다.\n-비행 중 항공기를 조종한다.\n-항공 교통 관제와 통신한다.\n-기상 조건을 모니... 기반으로 50로 평가","income":"income는 [여객기조종사]\n-비행 계획을 수립한다.\n-항공기 사전 점검을 실시한다.\n-이륙과 착륙을 담당한다.\n-비행 중 항공기를 조종한다.\n-항공 교통 관제와 통신한다.\n-기상 조건을 모니... 기반으로 50로 평가","teamwork":"teamwork는 [여객기조종사]\n-비행 계획을 수립한다.\n-항공기 사전 점검을 실시한다.\n-이륙과 착륙을 담당한다.\n-비행 중 항공기를 조종한다.\n-항공 교통 관제와 통신한다.\n-기상 조건을 모니... 기반으로 50로 평가","solo_deep":"solo_deep는 [여객기조종사]\n-비행 계획을 수립한다.\n-항공기 사전 점검을 실시한다.\n-이륙과 착륙을 담당한다.\n-비행 중 항공기를 조종한다.\n-항공 교통 관제와 통신한다.\n-기상 조건을 모니... 기반으로 50로 평가","analytical":"analytical는 [여객기조종사]\n-비행 계획을 수립한다.\n-항공기 사전 점검을 실시한다.\n-이륙과 착륙을 담당한다.\n-비행 중 항공기를 조종한다.\n-항공 교통 관제와 통신한다.\n-기상 조건을 모니... 기반으로 40로 평가","creative":"creative는 [여객기조종사]\n-비행 계획을 수립한다.\n-항공기 사전 점검을 실시한다.\n-이륙과 착륙을 담당한다.\n-비행 중 항공기를 조종한다.\n-항공 교통 관제와 통신한다.\n-기상 조건을 모니... 기반으로 40로 평가","execution":"execution는 [여객기조종사]\n-비행 계획을 수립한다.\n-항공기 사전 점검을 실시한다.\n-이륙과 착륙을 담당한다.\n-비행 중 항공기를 조종한다.\n-항공 교통 관제와 통신한다.\n-기상 조건을 모니... 기반으로 70로 평가","people_facing":"people_facing는 [여객기조종사]\n-비행 계획을 수립한다.\n-항공기 사전 점검을 실시한다.\n-이륙과 착륙을 담당한다.\n-비행 중 항공기를 조종한다.\n-항공 교통 관제와 통신한다.\n-기상 조건을 모니... 기반으로 50로 평가","degree_required":"degree_required는 [여객기조종사]\n-비행 계획을 수립한다.\n-항공기 사전 점검을 실시한다.\n-이륙과 착륙을 담당한다.\n-비행 중 항공기를 조종한다.\n-항공 교통 관제와 통신한다.\n-기상 조건을 모니... 기반으로 none로 평가","license_required":"license_required는 [여객기조종사]\n-비행 계획을 수립한다.\n-항공기 사전 점검을 실시한다.\n-이륙과 착륙을 담당한다.\n-비행 중 항공기를 조종한다.\n-항공 교통 관제와 통신한다.\n-기상 조건을 모니... 기반으로 none로 평가"}'
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