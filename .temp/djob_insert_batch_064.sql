INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002613:1', '{"dJobCd":"K000002613","dJobCdSeq":"1","dJobNm":"자동판매기관리원","workSum":"커피, 캔 음료, 복권, 일회용 물품 등의 음식료품과 기타 물품을 판매하기 위해 자동판매기를 관리한다.","doWork":"건물주 또는 회사와 계약을 체결하고 설치 장소를 결정한다. 건물의 복도, 식당, 지하철역 부근, 구내매점 등에 자동판매기를 설치하고 작동상태를 점검한다. 건물주 또는 주인에게 자동판매기 관리법을 교육하여 자동판매기 임대료를 받거나 관리원이 직접 판매기 내의 소모품이나 음료 캔의 수량 등을 확인하여 부족 시 보충한다. 일일 판매액을 회수하고 자동판매기의 청결 및 작동에 관한 책임을 지며 고장 시 제조회사에 수리를 의뢰한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"단순작업","dJobECd":"5622","dJobECdNm":"[5622]자동판매기 관리원","dJobJCd":"9922","dJobJCdNm":"[9922]자동판매기 관리원","dJobICd":"G479","dJobICdNm":"[G479]무점포 소매업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005472:1', '{"dJobCd":"K000005472","dJobCdSeq":"1","dJobNm":"주정차계도원","workSum":"불법 주정차량을 단속하고 계도한다.","doWork":"상시 불법 주정차 지역이나 교통혼잡 지역, 사람이 다니는 보도에 불법으로 주정차한 차량을 단속한다. 버스 승강장 주변이나 인도 등에 불법으로 주정차한 차량에 대해 이동주차할 것을 안내한다. 불법 주정차 예방 홍보활동을 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"시범후 30일 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"시각|","workEnv":"대기환경미흡|","workFunc1":"기록","workFunc2":"말하기신호","workFunc3":"단순작업","similarNm":"주정차단속원","dJobECd":"5623","dJobECdNm":"[5623]주차 관리·안내원","dJobJCd":"9923","dJobJCdNm":"[9923]주차 관리원 및 안내원","dJobICd":"O841","dJobICdNm":"[O841]입법 및 일반 정부 행정","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003526:1', '{"dJobCd":"K000003526","dJobCdSeq":"1","dJobNm":"주차장관리원","workSum":"무료 또는 유료로 운영되는 주차시설을 관리한다.","doWork":"주차장 입구에서 입차한 차량의 주차일시가 기록되어 있는 주차권을 배부한다. 차량사고를 예방하고 효율적인 주차를 위해 주차장 내부에서 주차공간을 안내한다. 고객이 안전하게 주차할 수 있도록 돕는다. 차량이 주차장 밖으로 나갈 때 출구를 안내한다. 기계식 주차설비의 경우, 주차대수 규모를 파악하여 고객의 차량 입·출차를 돕고, 승강기를 작동한다. 주차위치 및 주차공간을 확인하기 위해 무전기로 주차장 내부 근무자와 연락하기도 한다. 주차공간이 부족하면 고객을 대신해 차량을 주차하기도 한다. CCTV로 종합적인 주차관리 및 차량사고를 감시하기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workEnv":"대기환경미흡|","workFunc1":"기록","workFunc2":"서비스제공","workFunc3":"단순작업","similarNm":"주차관리요원","dJobECd":"5623","dJobECdNm":"[5623]주차 관리·안내원","dJobJCd":"9923","dJobJCdNm":"[9923]주차 관리원 및 안내원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001565:1', '{"dJobCd":"K000001565","dJobCdSeq":"1","dJobNm":"구두미화원","workSum":"구두의 오염물질을 제거하고 광택을 내며 간단한 수리를 한다.","doWork":"광택을 내거나 수리할 구두를 모아온다. 구두솔을 사용하여 구두표면과 바닥의 이물질을 제거한다. 가죽의 종류와 색을 판단하여 구두약을 칠한다. 헝겊과 물을 이용하여 광택을 낸다. 낡은 구두굽이나 벌어진 부위 등 간단한 것은 직접 수선한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"단순작업","similarNm":"구두닦이","dJobECd":"5614","dJobECdNm":"[5614]구두 미화원","dJobJCd":"9991","dJobJCdNm":"[9991]구두 미화원","dJobICd":"S969","dJobICdNm":"[S969]그 외 기타 개인 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007200:1', '{"dJobCd":"K000007200","dJobCdSeq":"1","dJobNm":"세탁물접수원","workSum":"고객으로부터 세탁물을 접수받고 세탁 종류와 방법에 따라 표시·분류한다.","doWork":"고객으로부터 세탁물에 관한 정보를 듣고 세탁방법, 얼룩, 변색, 종류, 수량 등을 점검·기록한다. 고객의 성명을 기록지(분류표)에 기록하여 세탁물에 부착하고 세탁영수증을 발행한다. 고객이 제시한 세탁영수증을 대조하여 세탁물의 종류와 수량을 확인하고 세탁물을 찾아 인계한다. 고객을 방문하여 세탁물을 접수하기도 하며 세탁한 의류를 포장하기도 한다. 세탁한 의류를 배달하기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"기록","workFunc2":"서비스제공","workFunc3":"관련없음","connectJob":"세탁물배달원","dJobECd":"5615","dJobECdNm":"[5615]세탁원(다림질원)","dJobJCd":"9992","dJobJCdNm":"[9992]세탁원 및 다림질원","dJobICd":"S969","dJobICdNm":"[S969]그 외 기타 개인 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003443:1', '{"dJobCd":"K000003443","dJobCdSeq":"1","dJobNm":"세탁보조원","workSum":"세탁원을 보조하고 세탁물을 고객으로부터 수거하고 배달한다.","doWork":"고객에게 세탁물을 접수받아 장부와 세탁물에 번호, 고객성명, 특이사항 등을 기입한다. 세탁원이 분류한 세탁물을 세탁기계에 넣고 세탁이 끝난 후 종류에 따라 건조기에 옮긴다. 드라이클리닝과 건조가 끝난 세탁물을 옷걸이에 걸거나 접어서 정리한다. 고객에게 성명, 번호를 확인 후에 진열대에서 세탁물을 찾아주고 요금을 정산하여 영수증을 지급한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"시범후 30일 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"세탁배달원","dJobECd":"5615","dJobECdNm":"[5615]세탁원(다림질원)","dJobJCd":"9992","dJobJCdNm":"[9992]세탁원 및 다림질원","dJobICd":"S969","dJobICdNm":"[S969]그 외 기타 개인 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006384:1', '{"dJobCd":"K000006384","dJobCdSeq":"1","dJobNm":"세탁원","workSum":"고객으로부터 의뢰받은 의류나 침구류 등을 세탁하고 다림질한다.","doWork":"고객으로부터 의뢰받은 세탁물을 옷감의 종류에 따라 분류한다. 구분된 세탁물을 물과 세제를 사용하여 물세탁한 후 건조기를 사용하여 건조하거나 유기용제를 사용하여 드라이크리닝을 한다. 드라이크리닝 시에는 유기용제의 농도 등을 고려하여 드라이크리닝기를 조작하여 세탁한다. 세탁물에 따라 얼룩을 빼거나 특수처리를 한다. 세탁이 완료된 후에는 세탁물의 상태를 확인하고 다림질한 후 정리한다. 주기적으로 세탁기계와 다림질기계를 점검하고 청소한다. 때에 따라 의류 등을 수선하는 업무를 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"가죽제품세탁원, 손세탁원, 특수물세탁원, 얼룩빼기세탁원","certLic":"세탁기능사","dJobECd":"5615","dJobECdNm":"[5615]세탁원(다림질원)","dJobJCd":"9992","dJobJCdNm":"[9992]세탁원 및 다림질원","dJobICd":"S969","dJobICdNm":"[S969]그 외 기타 개인 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003129:1', '{"dJobCd":"K000003129","dJobCdSeq":"1","dJobNm":"호텔세탁원","workSum":"고객의 세탁물과 직원 유니폼, 객실침구류 등의 세탁물을 분류하여 세탁하고 배분한다.","doWork":"고객의 세탁물과 직원의 유니폼 세탁물을 수거하여 세탁 전에 상태를 확인한다. 물세탁, 특수세탁 등을 구분하고 분류한다. 고객의 세탁물을 세탁하여 요청한 시간 내에 전달한다. 세탁물의 정확한 세탁법과 세탁기계 사용법을 숙지한다. 세탁기계 상태를 점검하고 확인한다. 객실 침구류의 분실과 손상상태를 파악하며, 때에 따라 수선한다. 사용 가능한 유니폼을 분류하고 정리한다. 객실침구류 보관 창고와 유니폼 실을 정리·정돈한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"시범후 30일 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"웅크림|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"린넨담당원","dJobECd":"5615","dJobECdNm":"[5615]세탁원(다림질원)","dJobJCd":"9992","dJobJCdNm":"[9992]세탁원 및 다림질원","dJobICd":"I551","dJobICdNm":"[I551]일반 및 생활 숙박시설 운영업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002745:1', '{"dJobCd":"K000002745","dJobCdSeq":"1","dJobNm":"등하교교통안전원","workSum":"초등학생들이 교통사고 등으로부터 안전하게 등·하교를 할 수 있도록 교통지도를 한다.","doWork":"어린이가 안전하게 등·하교를 할 수 있도록 깃발, 호루라기를 사용하여 교통을 통제한다. 초등학교 주변에서 발생할 수 있는 폭력이나 유괴 등의 각종 범죄를 예방하기 위해 순찰활동을 하기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"약간의 시범정도","workStrong":"가벼운 작업","workPlace":"실외","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"단순작업","connectJob":"학교보안관, 학교지킴이","dJobECd":"5629","dJobECdNm":"[5629]기타 서비스 단순 종사원","dJobJCd":"9999","dJobJCdNm":"[9999]기타 서비스 관련 단순 종사원","dJobICd":"S969","dJobICdNm":"[S969]그 외 기타 개인 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004282:1', '{"dJobCd":"K000004282","dJobCdSeq":"1","dJobNm":"등하굣길동행도우미","workSum":"주로 맞벌이 또는 저소득층 가정의 초등학교 저 학년생을 대상으로 등하굣길의 교통사고, 유괴, 폭력 등의 각종 사고와 범죄를 미연에 방지하고자 등하굣길에 어린이와 동행한다.","doWork":"대상 어린이의 집으로 어린이를 데리러 간다. 학교까지 동행한다. 학업이 끝나는 시간에 맞추어 학교 앞에서 어린이를 기다렸다가 어린이의 집까지 동행한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"약간의 시범정도","workStrong":"가벼운 작업","workPlace":"실외","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"단순작업","dJobECd":"5629","dJobECdNm":"[5629]기타 서비스 단순 종사원","dJobJCd":"9999","dJobJCdNm":"[9999]기타 서비스 관련 단순 종사원","dJobICd":"S969","dJobICdNm":"[S969]그 외 기타 개인 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003014:1', '{"dJobCd":"K000003014","dJobCdSeq":"1","dJobNm":"양수장감시원","workSum":"양수장관리원을 보조하고, 양수시설 및 주변 환경을 감시한다.","doWork":"양수장 내의 양수설비를 양수장관리원의 지시에 따라 가동하고 정지한다. 양수장 및 주변 환경을 청결하게 한다. 양수장의 용수 흡입배관 입구에 쌓인 이물질 및 잡초를 제거하여 용수공급이 원활하게 이루어지도록 한다. 방조제, 하천, 강 등의 수위를 측정하고 보고한다. 양수설비를 점검하고 이상이 발생하면 보고한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","dJobECd":"5629","dJobECdNm":"[5629]기타 서비스 단순 종사원","dJobJCd":"9999","dJobJCdNm":"[9999]기타 서비스 관련 단순 종사원","dJobICd":"A014","dJobICdNm":"[A014]작물재배 및 축산 관련 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004082:1', '{"dJobCd":"K000004082","dJobCdSeq":"1","dJobNm":"지하철도우미","workSum":"지하철 승객의 지하철 승·하차 시에 질서유지를 지도하고, 지하철 이용에 관한 각종 안내를 한다.","doWork":"지하철의 신속·안전한 운행과 승객의 안전을 위해 승객의 지하철 승·하차 시에 질서유지를 지도 및 안내를 한다. 지하철이용자들에게 승강기의 탑승 안내, 승차권발급기의 사용요령 등 각종 안내를 한다. 지하철 무임승차의 단속 업무를 하기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"시범후 30일 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"단순작업","dJobECd":"5629","dJobECdNm":"[5629]기타 서비스 단순 종사원","dJobJCd":"9999","dJobJCdNm":"[9999]기타 서비스 관련 단순 종사원","dJobICd":"H492","dJobICdNm":"[H492]육상 여객 운송업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003879:1', '{"dJobCd":"K000003879","dJobCdSeq":"1","dJobNm":"환경감시원","workSum":"발전소 주변을 순시하며 환경 및 수질 보호를 위하여 감시하는 업무를 수행한다.","doWork":"발전소의 환경 및 수질 보호를 위하여 쓰레기투척, 낚시, 물놀이, 폐수방류 등에 대한 단속을 위하여 도보 및 차량을 이용하여 순회하며 주변을 감시하고 단속한다. 발전소 주변에 환경 및 수질을 오염시키는 자를 단속하여 보고하고 관련 기관에 고발조치 한다. 투척된 오염물질을 제거하도록 관련 부서에 보고한다. 기타 발전소 주변의 환경보호를 위한 감시활동을 수행한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","dJobECd":"5629","dJobECdNm":"[5629]기타 서비스 단순 종사원","dJobJCd":"9999","dJobJCdNm":"[9999]기타 서비스 관련 단순 종사원","dJobICd":"O842","dJobICdNm":"[O842]사회 및 산업정책 행정","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;