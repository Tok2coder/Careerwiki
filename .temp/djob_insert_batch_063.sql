INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001959:1', '{"dJobCd":"K000001959","dJobCdSeq":"1","dJobNm":"라싱작업원","workSum":"컨테이너선에 적재된 컨테이너의 양화를 위해 라싱도구를 해체하거나 적화 후 선박의 요동에 컨테이너가 넘어지지 않도록 고정한다.","doWork":"컨테이너선박에 적재된 컨테이너를 양화하기 위해 사다리, 라싱 케이지(Lashing Cage)를 이용하여 라싱콘(Lashing Cone), 라싱로드(Lashing Rod)를 해체한다. 해체된 도구들은 박스에 담거나 한쪽으로 모은다. 반대로 컨테이너가 완전히 선박에 적재된 다음 컨테이너가 항해 도중 선박의 요동에 의해 무너지지 않도록 라싱콘이나 라싱로드를 체결하여 컨테이너를 단단히 고정시킨다. 컨테이너가 아닌 일반화물인 경우 와이어로프, 와이어 클립, 턴버클(Turn Buckle), 샤클(Shakle) 등을 이용하여 와이어로프로 화물과 선박의 바닥이나 측면과 연결하여 화물을 고정시키고 해체시키기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"쇼링작업원, 고박작업원","dJobECd":"6244","dJobECdNm":"[6244]하역·적재 종사원","dJobJCd":"9210","dJobJCdNm":"[9210]하역 및 적재 단순 종사원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002796:1', '{"dJobCd":"K000002796","dJobCdSeq":"1","dJobNm":"본선하역반장","workSum":"선박 상에서 화물하역 작업내용을 파악하고 하역작업원들에게 작업을 지시한다.","doWork":"작업 전 현장의 장비와 인원을 점검한다. 작업자들에게 작업을 설명하고 안전회의를 한다. 작업자를 배치한다. 본선작업이 변경되었을 경우 작업자의 인원과 장비를 조정하고 재배치한다. 작업자들이 안전하게 작업할 수 있도록 관리한다. 관리자에게 작업진행 사항을 보고한다. 본선 특수화물 하역작업에 따른 제반 조치를 하고 감독한다. 작업 종료 후 인원을 점검하고 컨테이너 크레인 등 장비상태와 계류위치를 확인한다. 작업방법과 작업기준을 개발 지도한다. 작업자에게 안전수칙을 교육하고 지도한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","dJobECd":"6244","dJobECdNm":"[6244]하역·적재 종사원","dJobJCd":"9210","dJobJCdNm":"[9210]하역 및 적재 단순 종사원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006916:1', '{"dJobCd":"K000006916","dJobCdSeq":"1","dJobNm":"부두노무반장","workSum":"선박 또는 부두에서 화물을 하역하고 운반하는 부두노무원들의 활동을 관리·감독한다.","doWork":"선박에 적양화할 화물의 종류 및 수량을 확인하고 필요한 인원을 산출한다. 부두노무원에게 업무를 할당하고 지시한다. 화물의 처리, 적재, 안전취급방법 등을 설명한다. 특별한 취급을 요하는 화물을 확인하여 적재방법을 결정한다. 작업 중 부두작업자의 안전관리를 담당한다. 화물의 손상을 방지하기 위하여 적재된 화물을 정리한다. 화물처리량을 계산하고 부두작업자의 임금을 계산하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"다습|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","similarNm":"포맨","dJobECd":"6244","dJobECdNm":"[6244]하역·적재 종사원","dJobJCd":"9210","dJobJCdNm":"[9210]하역 및 적재 단순 종사원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002178:1', '{"dJobCd":"K000002178","dJobCdSeq":"1","dJobNm":"수하물운반원","workSum":"고객의 화물을 손이나 운반장비를 사용하여 고객이 원하는 장소까지 운반한다.","doWork":"여객터미널(버스, 항구), 공항, 기차역에서 승객의 요청 또는 대기실에 접수된 순서에 따라 손이나 운반장비(손수레, 캐리어 등)를 사용하여 차량으로부터 대합실까지 또는 대합실로부터 후속 운송수단(버스, 열차, 택시 등)까지 수화물을 운반한다. 요금을 수령한다.","optionJobInfo":{"eduLevel":"6년 이하(초졸 이하)","skillYear":"시범후 30일 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"웅크림|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"짐운반원","dJobECd":"6244","dJobECdNm":"[6244]하역·적재 종사원","dJobJCd":"9210","dJobJCdNm":"[9210]하역 및 적재 단순 종사원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004554:1', '{"dJobCd":"K000004554","dJobCdSeq":"1","dJobNm":"신호수","workSum":"수신호, 호루라기, 무전기를 사용하여 컨테이너 또는 대형화물의 정확한 양적하를 돕는다.","doWork":"작업지시서 및 현장 공정(물류)을 숙지하여 작업순서 목록을 만든다. 이동할 화물의 종류와 무게, 위치, 이동경로, 이동 간 장애물의 유무를 확인한다. 화물의 구속을 확인한다. 장비와 화물의 종류에 따라 각종 장비운전원(선박화물양적하작업사무원, 신호수, 선박화물양적하작업관리자, 컨테이너크레인 기사, 야드트랙터 기사)에게 무전과 깃발신호를 전달하여 화물의 이동을 돕는다. 컨테이너크레인 주행 시 레일선상의 장애물을 확인하여 주행신호를 보내고, 컨테이너크레인 밑의 차량정리를 하고 속도를 제한하기도 한다. 야드트랙터 기사에게 상하차 위치를 지정하고 출발신호를 전달하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"힘든 작업","workPlace":"실외","physicalAct":"균형감각|손사용|","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","dJobECd":"6244","dJobECdNm":"[6244]하역·적재 종사원","dJobJCd":"9210","dJobJCdNm":"[9210]하역 및 적재 단순 종사원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007034:1', '{"dJobCd":"K000007034","dJobCdSeq":"1","dJobNm":"악기운반원","workSum":"악기, 보면대 등 경음악단·관현악단의 연주에 필요한 각종 장비를 관리하고 무대로 운반·이동하고 배치한다.","doWork":"각종 악기의 관리방법 및 이동방법을 숙지하고 악단지휘자 또는 경음악단지휘자의 지시에 따라 악단, 인원의 구성 및 배치에 따라서 악기를 무대로 운반하여 배치하고 세팅(설치)한다. 마이크, 앰프 등을 이동 및 배치한다. 연주가 끝난 후에 악기를 무대에서 운반, 철수하여 창고에 보관하여 관리한다. 악기를 안전하게 보관 및 운반하기 위하여 악기케이스, 포장재료를 보유한다. 악기가 먼 거리를 이동하는 경우 항공, 선박을 이용한 악기운송방법을 고안하기도 한다. 악기의 전문적인 수리가 필요하다고 판단되거나 기악연주자의 요청을 받아서 전문수리업체에 악기수리를 의뢰하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"힘든 작업","workPlace":"실내·외","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","dJobECd":"6244","dJobECdNm":"[6244]하역·적재 종사원","dJobJCd":"9210","dJobJCdNm":"[9210]하역 및 적재 단순 종사원","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006581:1', '{"dJobCd":"K000006581","dJobCdSeq":"1","dJobNm":"원목인양반장","workSum":"원목하역 작업과 그에 종사하는 작업원들의 활동을 조정·감독한다.","doWork":"본선 선장과 작업관계를 협의한다. 하역방법을 계획하고 작업원을 배치한다. 각 작업원에게 작업지시를 하고 감독한다. 안전사고가 발생하지 않도록 안전사고 예방교육을 하고 주의를 시킨다. 본선 작업에서 바지선(부선) 작업까지 감독한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실외","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","dJobECd":"6244","dJobECdNm":"[6244]하역·적재 종사원","dJobJCd":"9210","dJobJCdNm":"[9210]하역 및 적재 단순 종사원","dJobICd":"C161","dJobICdNm":"[C161]제재 및 목재 가공업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002406:1', '{"dJobCd":"K000002406","dJobCdSeq":"1","dJobNm":"원목인양원","workSum":"해상의 본선에 적재되어 있는 원목을 바지선에 인양할 때 원목에 와이어를 결속하여 원목인양기에 걸어주고, 바지선에서 와이어를 풀어놓는 일을 한다.","doWork":"본선 작업자는 원목에 와이어를 결속하여 원목인양기에 걸어주고 원목인양기조종원에게 손으로 신호하여 원목을 운반하도록 한다. 바지선 작업자는 적재장소에 운반된 원목에 걸린 와이어를 풀고 원목인양기조종원에게 작업완료 신호를 한다. 원목인양기로 원목을 들어 올린 후 적재장소에 내려놓을 때 꺾쇠를 사용하여 적당한 장소로 유도하고 무너지거나 굴러떨어지지 않도록 적재한다. 꺾쇠나 보조목을 박아 적재된 원목이 무너지거나 떨어지지 않도록 하기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"힘든 작업","workPlace":"실외","physicalAct":"웅크림|손사용|","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","similarNm":"해상인양원","connectJob":"바지선에 타서 바지선과 예인선을 연결하거나 해지하는 경우 바지선선원, 바지선이나 트레일러에 적재되는 원목의 개수를 세는 경우 원목검수원","dJobECd":"6244","dJobECdNm":"[6244]하역·적재 종사원","dJobJCd":"9210","dJobJCdNm":"[9210]하역 및 적재 단순 종사원","dJobICd":"C161","dJobICdNm":"[C161]제재 및 목재 가공업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006606:1', '{"dJobCd":"K000006606","dJobCdSeq":"1","dJobNm":"유조선하역원","workSum":"유조선, 천연가스선 등의 탱크에 이송관을 연결하여 원유, 정제유, 액화가스 등을 하역한다.","doWork":"선박 및 하역할 화물의 종류, 유량 등을 검토·확인하고 로딩 암(Loading Arm), 이송관 등의 설비를 점검한다. 탱크의 뚜껑을 열고 렌치, 스패너 등의 수공구를 사용하여 이송관을 매니폴드(Manifold)나 로딩 암에 연결한다. 액체화물이 이송관을 통과할 때 정전기나 마찰에 의한 폭발을 방지하기 위하여 접지전선을 연결한다. 펌프가 가동되어 화물이 이송되면 연결부위를 재점검하여 유출 여부를 확인한다. 하역 중 압력을 점검한다. 작업이 완료되면 연결부위를 점검하고 선박에 연락한다. 작업이 완료되면 이송관을 분리하고 뚜껑을 밀폐한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실외","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"6244","dJobECdNm":"[6244]하역·적재 종사원","dJobJCd":"9210","dJobJCdNm":"[9210]하역 및 적재 단순 종사원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002801:1', '{"dJobCd":"K000002801","dJobCdSeq":"1","dJobNm":"육류냉동창고작업원","workSum":"지육, 수산물 등의 원료 또는 가공된 제품을 보관하는 냉동창고를 관리한다.","doWork":"입고가 결정된 지육, 수산물 등의 원료나 가공제품을 창고로 운반하기 위하여 냉동실 내부의 공간을 확인한다. 입고되는 제품원료나 제품의 수량을 확인하고 지게차나 손수레를 사용하여 냉동창고 안으로 운반하여 쌓는다. 입고날짜와 수량을 명세서와 작업일지 또는 컴퓨터에 기록하고 명세서를 쌓아 놓은 제품에 부착한다. 운반작업이 완료되면 냉동실 문을 닫고 제품의 선도에 맞는 온도 및 습도로 조절한다. 창고에서 가공할 원료를 반출하기 위하여 해동실로 원료를 운반하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|저온|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"투입인출","similarNm":"급속동결실작업원, 예냉실작업원","connectJob":"냉장창고에서 작업하는 경우 냉장창고작업원","certLic":"지게차운전기능사","dJobECd":"6244","dJobECdNm":"[6244]하역·적재 종사원","dJobJCd":"9210","dJobJCdNm":"[9210]하역 및 적재 단순 종사원","dJobICd":"C101","dJobICdNm":"[C101]도축, 육류 가공 및 저장 처리업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002750:1', '{"dJobCd":"K000002750","dJobCdSeq":"1","dJobNm":"이사작업원","workSum":"고객의 이삿짐을 포장하여 운반하고 정리하는 일을 한다.","doWork":"이사규모, 이사지역 및 거리에 따라 수립된 작업일정을 확인한다. 차량에 탑승하여 이사 출발장소로 이동한다. 포장박스, 충격방지 보강물 등을 이용하여 이삿짐을 포장한다. 포장된 이삿짐을 손 또는 대차를 사용하여 운반한다. 고층건물 또는 대형 이삿짐의 경우 경우 호이스트(운반용 엘리베이터) 및 사다리차를 사용하여 운반한다. 차량에 이삿짐을 적재하고 이동 중 파손되지 않도록 결속한다. 이사 도착장소에서 이삿짐을 운반한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"아주 힘든 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|손사용|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"이삿짐운반원, 포장이사원","dJobECd":"6244","dJobECdNm":"[6244]하역·적재 종사원","dJobJCd":"9210","dJobJCdNm":"[9210]하역 및 적재 단순 종사원","dJobICd":"S969","dJobICdNm":"[S969]그 외 기타 개인 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001461:1', '{"dJobCd":"K000001461","dJobCdSeq":"1","dJobNm":"적재원","workSum":"생산된 제품이나 원료를 일정 수량 또는 단위 중량씩 적재한다.","doWork":"적재시킬 제품의 종류, 형상, 크기 등에 따라 적재 방법 및 절차를 결정한다. 적재하는데 필요한 수동도구를 준비한다. 적재장소의 바닥을 고르거나 나무 등을 놓는다. 손으로 들거나 운반도구를 이용하여 물품을 운반하고 균형을 잡으며 적재한다. 적재량을 작업일지에 기록한다. 자연재해로부터 적재품을 보호하기 위하여 방호조치를 하기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"출하계획에 따라 물품을 출하하는 경우 출하작업원","dJobECd":"6244","dJobECdNm":"[6244]하역·적재 종사원","dJobJCd":"9210","dJobJCdNm":"[9210]하역 및 적재 단순 종사원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005240:1', '{"dJobCd":"K000005240","dJobCdSeq":"1","dJobNm":"줄잡이원","workSum":"부두 접안 시 선박을 부두의 볼라드(Bollard)에 계류줄로 고정한다.","doWork":"부두에 대기하고 있다가, 선박이 부두에 접안하면 갑판원이 내려주는 예인줄을 받아 부두로 잡아당긴다. 예인줄 끝에 매달린 선박의 계류줄을 볼라드(Bollard:뱃줄, 스프링 로프 등을 걸거나 매게 되어 있는 작은 기둥)에 고정한다. 선박출항 시에는 다시 계류줄을 볼라드로부터 풀어준다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실외","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"6244","dJobECdNm":"[6244]하역·적재 종사원","dJobJCd":"9210","dJobJCdNm":"[9210]하역 및 적재 단순 종사원","dJobICd":"H501/H502","dJobICdNm":"[H501]해상 운송업 / [H502]내륙 수상 및 항만 내 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005061:1', '{"dJobCd":"K000005061","dJobCdSeq":"1","dJobNm":"창고작업원(일반)","workSum":"창고관리자의 지시를 받아 자재, 공구, 설비, 생산제품 및 기타 물품의 입고, 보관, 불출 등의 업무를 수행한다.","doWork":"운반하고 모으거나 분출할 항목을 알아보기 위하여 생산계획서, 고객주문서, 작업순서, 선적순서 등에 따라 운반도구를 사용하여 재료나 물품을 수령한다. 수령한 물품 등을 생산장소로부터 창고나 지정된 장소로 운반한다. 순서에 따라 재료나 물품을 크기, 형태, 양식, 종류 등으로 분류하여 수량을 파악하고 선반에 얹거나 상자에 담는다. 창고 내에 적재된 물품을 정리한다. 물품청구서 또는 창고관리원의 지시에 따라 물품을 찾아 수량을 세어 불출한다. 입고되거나 불출한 수량을 물품대장에 기록한다. 회사표준에 따라 물품을 분류하기 위하여 무게를 달거나 수량을 파악하여 재고량을 현황일자에 기록한다. 창고를 청소하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"단순작업","connectJob":"창고운반원","dJobECd":"6244","dJobECdNm":"[6244]하역·적재 종사원","dJobJCd":"9210","dJobJCdNm":"[9210]하역 및 적재 단순 종사원","dJobICd":"H521","dJobICdNm":"[H521]보관 및 창고업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004384:1', '{"dJobCd":"K000004384","dJobCdSeq":"1","dJobNm":"하역반장","workSum":"원료 및 제품 등을 선박에 싣거나 내리기 위하여 하역장비 및 반입·반출 설비를 운전하거나 이에 종사하는 작업원의 활동을 감독·조정한다.","doWork":"업무의 내역, 적재공간, 선적지시 등을 고려하여 하역작업에 필요한 인원, 장비, 시간, 방법 및 절차 등을 결정한다. 작업원에 대한 직무교육 및 안전위생교육을 통하여 직무수행능력을 향상시키고 안전재해 예방을 한다. 화물을 선적하거나 하역하는 작업이 안전규정에 위배되는지 확인하고 감독한다. 작업인원·장비·시간·작업량 등 작업내용을 작업일지에 기록하고 관련 부서에 제출한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|","workFunc1":"조정","workFunc2":"감독","workFunc3":"단순작업","dJobECd":"6244","dJobECdNm":"[6244]하역·적재 종사원","dJobJCd":"9210","dJobJCdNm":"[9210]하역 및 적재 단순 종사원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004943:1', '{"dJobCd":"K000004943","dJobCdSeq":"1","dJobNm":"하역원","workSum":"목적지까지 운송하거나 목적지에 도착한 원료 및 제품을 선박이나 부두, 화물차, 열차, 항공기 등에 적재 및 하역한다.","doWork":"작업지시서나 하역반장의 지시에 따라 작업방법 및 절차를 숙지한다. 필요한 장비 및 도구를 사용하여 화물을 부두, 선박, 항공기, 열차 및 화물차 등에 운반하여 적재하거나 하역한다. 적재한 화물이 파손되지 않도록 로프를 사용하여 고정한다. 화물을 분류하고 정리하기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"시범후 30일 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"웅크림|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"투입인출","connectJob":"근무하는 장소에 따라 부두하역원, 선박하역원, 화물운반원, 항공하역원, 철도하역원, 육상화물하역원, 가구하역원, 상하차원","dJobECd":"6244","dJobECdNm":"[6244]하역·적재 종사원","dJobJCd":"9210","dJobJCdNm":"[9210]하역 및 적재 단순 종사원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005322:1', '{"dJobCd":"K000005322","dJobCdSeq":"1","dJobNm":"항공화물물류센터반입원","workSum":"항공화물 물류센터(포워더 물류센터)에서 다수의 화주로부터 집결된 화물을 물류센터에 반입하는 업무를 수행한다.","doWork":"화물입고 예정 정보를 확인한다. 물류센터에 도착한 화물의 부적합 사항을 확인한다. 지게차, 팔레트를 사용하여 화물을 하차한다. 화물의 선적서류를 확인한다. 화물의 중량을 계량하고 라벨을 부착한다. 화물의 포장상태를 점검하고 재포장하여 화물분류장소(Location)로 이동한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"손사용|시각|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"조작운전","certLic":"지게차운전기능사","dJobECd":"6244","dJobECdNm":"[6244]하역·적재 종사원","dJobJCd":"9210","dJobJCdNm":"[9210]하역 및 적재 단순 종사원","dJobICd":"H511","dJobICdNm":"[H511]항공 여객 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003543:1', '{"dJobCd":"K000003543","dJobCdSeq":"1","dJobNm":"항공화물물류센터반출원","workSum":"항공화물 물류센터(포워더 물류센터)에서 항공화물을 반출하여 항공화물터미널(항공사)에 반입하는 작업을 수행한다.","doWork":"ULD(Unit Load Device:항공화물용 Pallet, Container, Igloo 등 단위용기) 작업(Build-up)이 완료된 화물의 출고예정 정보를 확인한다. ULD에 마스터라벨, 수출화물반입계를 부착한다. 화물의 부적합사항을 점검하고 조치한다. ULD를 셔틀차량(Roller Bed)에 상차하여 항공사화물터미널(활주로)로 이동한다. 항공사 화물터미널에 도착하면 물류센터로부터 전달된 화물 출고 통지 내역을 확인한다. 항공사 또는 지상조업사에 화물을 인수인계한다. 조업사 또는 항공사의 중량계측, 보안검색을 받아 확인필증을 받는다. 선적서류(Airwaybill:송하인과 항공사 간에 화물운송 계약체결을 증명하는 서류)을 항공사 카운터에 접수한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"손사용|시각|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"조작운전","dJobECd":"6244","dJobECdNm":"[6244]하역·적재 종사원","dJobJCd":"9210","dJobJCdNm":"[9210]하역 및 적재 단순 종사원","dJobICd":"H511","dJobICdNm":"[H511]항공 여객 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003938:1', '{"dJobCd":"K000003938","dJobCdSeq":"1","dJobNm":"항공화물물류센터빌드업작업원","workSum":"항공화물 물류센터(포워더 물류센터)에 집결된 화물을 항공화물탑재용기(ULD)에 적재하는 작업(Build-up)을 수행한다.","doWork":"각 항공사로부터 ULD(Unit Load Device:항공화물용 Pallet, Container, Igloo 등 단위용기)의 적정 재고를 확보한다. CBA(Cargo Boarding Advisory:항공사의 예약카운터가 예약된 화물의 데이터를 항공기별로 집약하여 공항 화물점소에 일괄 발신하는 목록)를 확인하여 ULD작업 정보를 파악한다. ULD 최적화 시뮬레이션을 수행한다. 화물을 ULD에 적재하고 중량을 계량한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"손사용|시각|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"조작운전","similarNm":"항공화물빌드업작업원","dJobECd":"6244","dJobECdNm":"[6244]하역·적재 종사원","dJobJCd":"9210","dJobJCdNm":"[9210]하역 및 적재 단순 종사원","dJobICd":"H511","dJobICdNm":"[H511]항공 여객 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005105:1', '{"dJobCd":"K000005105","dJobCdSeq":"1","dJobNm":"항공화물지상조업원","workSum":"지상조업사에 소속되어 RAMP에서 화물조업 활동을 한다.","doWork":"RAMP(여객의 탑승·하기, 화물의 적재, 항공기의 정비점검, 연료보급 등을 위해 설치된 비행장의 일정 지역으로 터미널 빌딩 및 정비지구에 인접한 지역) 화물조업 운영계획 및 안전품질, 생산성 관리계획을 숙지한다. 화물항공기별 조업 정보를 확인한다. SPOT(수하물 또는 화물의 하기(下機) 등을 위해 항공기가 주기(駐機)하는 장소)에서 국적기 및 외항사 화물기의 화물 상하역 작업을 한다. 수출, 수입, 통과 화물에 대한 검수, 적재, 분류 업무를 진행한다. 국적기의 항공우편물 적재 및 분류 업무를 진행한다. 수입화물에 대한 세관신고 및 위험품 창고 관리업무를 수행한다. 외항사 항공기의 W&B(항공무게중심) 관련 업무를 진행한다. 지상조업장비의 일일점검을 실시한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"손사용|시각|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"조작운전","dJobECd":"6244","dJobECdNm":"[6244]하역·적재 종사원","dJobJCd":"9210","dJobJCdNm":"[9210]하역 및 적재 단순 종사원","dJobICd":"H511","dJobICdNm":"[H511]항공 여객 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003305:1', '{"dJobCd":"K000003305","dJobCdSeq":"1","dJobNm":"화물취급원(일반)","workSum":"열차, 차량, 선박, 창고 및 기타 운송장비에 화물을 상하차, 적재, 운송, 하역 및 보관한다.","doWork":"열차 및 차량의 상하차 작업, 선박의 적양화 하역작업, 창고 입출고 작업, 기타 운송장비로 운송을 위해 와이어로프 스링, 네트, 버킷, 손수레, 호이스트 장비 등을 이용한다. 화물을 취급하기 위해 장비로 인양되는 화물을 밀거나 당기고 스링을 걸고 벗긴다. 화물을 고정시키거나 묶기 위해 던니지(Dunnage)를 화물 사이에 넣거나 로프로 화물을 묶는다. 화물 사이에 솜이나 종이 등의 완충제를 끼우기도 한다. 어깨에 화물을 올려 운반하기도 한다.","optionJobInfo":{"eduLevel":"6년 이하(초졸 이하)","skillYear":"시범후 30일 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"웅크림|","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","similarNm":"부두노무원","dJobECd":"6244","dJobECdNm":"[6244]하역·적재 종사원","dJobJCd":"9210","dJobJCdNm":"[9210]하역 및 적재 단순 종사원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007455:1', '{"dJobCd":"K000007455","dJobCdSeq":"1","dJobNm":"집배원","workSum":"우체통에서 우편물을 수집하여 이륜차 또는 배달용 차량으로 우편물을 표기주소지에 배달한다.","doWork":"우체국 관할 구역 내에 설치되어 있는 우체통에서 우편물을 지정된 시간에 수집하여 우체국 발착실에 인계한다. 특수발착실로부터 관할 구역 내에 배달될 우편물을 담당 구역별 및 순로별로 구분·파속(끈으로 묶음)한다. 특수통상우편물(등기, 특급(국내·국제), 소포(국내·국제)는 따로 구별하여 인계받는다. 지정된 순서에 따라 이륜차 또는 배달용 차량으로 우편물을 표기주소지에 배달한다. 특수통상우편물과 경조환, 전신환, 우편대체 등은 배달증에 수령자의 수령인을 PDA에 입력하여 저장한다. 우편 부족요금을 수금하기도 한다. 주소불명, 수취인불명 및 기타 배달 불능 우편물은 전달하지 못한 사유를 기재하여 우체국 특수계에 인계한다. 우편물을 배달한 후 단말기에 배달결과를 입력한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"힘든 작업","workPlace":"실외","physicalAct":"손사용|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"조작운전","similarNm":"우편집배원","connectJob":"우편원, 상시계약집배원, 우체국택배원","certLic":"제1·2종 보통운전면허, 제2종 소형면허, 원동기장치 자전거면허, 사무자동화산업기사, 정보기술자격(ITQ), 정보기기운용기능사, 정보처리기능사, 워드프로세서, 컴퓨터활용능력 2급, 인터넷정보관리사 3급","dJobECd":"6242","dJobECdNm":"[6242]우편물 집배원","dJobJCd":"9221","dJobJCdNm":"[9221]우편집배원","dJobICd":"J611","dJobICdNm":"[J611]공영 우편업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007056:1', '{"dJobCd":"K000007056","dJobCdSeq":"1","dJobNm":"퀵배달원","workSum":"이륜차 혹은 1.5톤 미만 사륜차를 이용하여 의뢰인이 요청한 물품을 수령자에게 안전하게 전달한다.","doWork":"퀵서비스 사무실로부터 물품배송 의뢰자가 요청한 주소, 성명 및 연락처를 받는다. 상차지의 위치를 확인하고 가장 빠른 길을 찾아내어 방문한다. 배송물품을 수령하고 업무용 차량에 안전하게 적재한다. 하차지 위치를 확인하고 가장 빠른 길을 찾아내어 방문한다. 소화물을 하차지에 안전하게 배송하고 운임을 받는다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"시범후 30일 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|손사용|","workEnv":"대기환경미흡|위험내재|고온|저온|다습|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"조작운전","similarNm":"퀵서비스배달원, 오토바이퀵서비스배달원, 퀵서비스원, 택배라이더","certLic":"운전면허, 원동기면허, 2종소형면허","dJobECd":"6241","dJobECdNm":"[6241]택배원","dJobJCd":"9222","dJobJCdNm":"[9222]택배원","dJobICd":"H494","dJobICdNm":"[H494]소화물 전문 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007557:1', '{"dJobCd":"K000007557","dJobCdSeq":"1","dJobNm":"택배원","workSum":"물품의 배송이나 납품을 위하여 물품을 싣고, 차량을 이용하여 고객의 물품을 목적지까지 신속하고 정확하게 배달한다.","doWork":"배송하거나 납품해야 할 물품, 물품의 수량, 장소, 시간 등을 사무원으로부터 확인한다. 물품을 차량에 싣는다. 배송지 및 소비지까지 안전하게 도착할 수 있도록 기본적인 차량을 점검하고 주행 중 정속운전 및 준법운전을 한다. 배송지 및 소비지에 도착한 후 물품을 내리거나 소비자에게 전달한다. 차량의 상태를 수시로 점검한다. 차량 사고 또는 이상 발생 시 신속하게 안전조치를 취하고 관련 부서와 보험 및 수리에 관련된 일련의 조치를 취한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"웅크림|손사용|시각|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","similarNm":"택배배달원, 배송운전원, 택배배송원, 택배기사","connectJob":"아파트 단지 내의 택배를 담당하는 경우 아파트택배원, 지하철을 이용하여 택배를 하는 경우 지하철택배원","certLic":"자동차운전면허증","dJobECd":"6241","dJobECdNm":"[6241]택배원","dJobJCd":"9222","dJobJCdNm":"[9222]택배원","dJobICd":"H494","dJobICdNm":"[H494]소화물 전문 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006129:1', '{"dJobCd":"K000006129","dJobCdSeq":"1","dJobNm":"급식배달원","workSum":"조리된 음식물 및 원재료 등을 계약한 단체, 기관 및 모임에 배달하고 음식을 배열한다.","doWork":"일일 주문계획서를 확인하고 장소를 숙지한다. 주문량에 따라 차량을 선별하고 인원수를 결정한다. 계절과 음식물, 파손 등을 고려하여 포장한다. 진열을 위해 필요한 각종 인테리어 또는 그릇, 수저 등을 준비하고 포장한다. 계약된 장소로 음식물을 배달하며 출장배달의 경우 연회 또는 모임이 있는 실내외 장소에 음식물을 차린다. 음식물의 운반상태 및 수량을 확인하고 인계한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"균형감각|손사용|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"서비스제공","workFunc3":"단순작업","dJobECd":"5324","dJobECdNm":"[5324]음식 배달원","dJobJCd":"9223","dJobJCdNm":"[9223]음식 배달원","dJobICd":"G479","dJobICdNm":"[G479]무점포 소매업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007534:1', '{"dJobCd":"K000007534","dJobCdSeq":"1","dJobNm":"음식배달원","workSum":"각종 음식점에서 고객의 주문에 따라 음식을 배달한다.","doWork":"고객으로부터 음식배달을 주문받는다. 배달할 음식과 수저 등을 준비한다. 배달장소를 확인한다. 자전거, 오토바이 등을 운전하여 배달장소로 주문받은 음식을 배달한다. 고객에게 음식물을 전달하고 음식요금을 계산한다. 빈 그릇을 수거하거나 식당을 청소하기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"약간의 시범정도","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"조작운전","connectJob":"식사배달원, 야식배달원, 도시락배달원, 요리배달원, 분식배달원, 중국음식배달원, 피자배달원, 치킨배달원","dJobECd":"5324","dJobECdNm":"[5324]음식 배달원","dJobJCd":"9223","dJobJCdNm":"[9223]음식 배달원","dJobICd":"I561","dJobICdNm":"[I561]음식점업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002294:1', '{"dJobCd":"K000002294","dJobCdSeq":"1","dJobNm":"인쇄물우송원","workSum":"신문, 정기간행물, 책자 등 각종 인쇄물을 우송·배달한다.","doWork":"인쇄물을 손이나 포장기를 사용하여 일정 수량씩 모은다. 발송처가 쓰인 종이를 올려놓고 포장한다. 포장된 인쇄물의 포장지에 주소를 적거나, 주소 및 포장부수가 기록된 꼬리표를 붙인다. 우송목록과 배달주문서에 따라 소인을 찍는다. 배달 및 우송지역에 따라 꾸러미를 분류하여 행낭에 넣거나, 차에 적재한다. 취급꾸러미의 숫자를 작업일지에 기록한다. 이송컨베이어 또는 트럭에 꾸러미를 싣고 내린다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","connectJob":"신문배달원, 우편물분류원, 생활정보지배포원, 전단지배포원","dJobECd":"6249","dJobECdNm":"[6249]기타 배달원","dJobJCd":"9229","dJobJCdNm":"[9229]기타 배달원","dJobICd":"N759","dJobICdNm":"[N759]기타 사업지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003402:1', '{"dJobCd":"K000003402","dJobCdSeq":"1","dJobNm":"가구부품포장원","workSum":"성형, 재단, 가공된 가구부품들을 상자로 포장한다.","doWork":"작업지시서와 비교하여 줄자로 부품별 규격을 검사하고 상자 표기를 확인한다. 가구부품을 상자 위에 놓고 그 위에 지판을 놓는다. 제품의 지지대를 측판 옆 오른쪽에 놓고 상자를 접는다. 상자 중앙에 테이프를 부착하고 테이핑기에 밀어 넣는다. 상자에 쓰인 제품 표기를 확인하고 운송 적재대에 올려놓는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","dJobECd":"8900","dJobECdNm":"[8900]제조 단순 종사원","dJobJCd":"9300","dJobJCdNm":"[9300]제조 관련 단순 종사원","dJobICd":"C320","dJobICdNm":"[C320]가구 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001792:1', '{"dJobCd":"K000001792","dJobCdSeq":"1","dJobNm":"고지선별원","workSum":"고지(폐지) 속에 포함된 이물질을 제거하고 분류한다.","doWork":"와이어로 묶여있는 고지뭉치를 지게차 또는 수레를 이용하여 컨베이어에 위치시킨다. 절단기를 이용하여 고지 뭉치의 포장 철사를 끊는다. 비닐, 쇠붙이, 유리조각, 나무토막 등의 이물질을 골라낸다. 선별된 고지를 투입 위치까지 운반한다. 절단된 포장 철사를 일정한 장소로 운반하여 쌓는다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"시범후 30일 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"손사용|","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","dJobECd":"8900","dJobECdNm":"[8900]제조 단순 종사원","dJobJCd":"9300","dJobJCdNm":"[9300]제조 관련 단순 종사원","dJobICd":"C171","dJobICdNm":"[C171]펄프, 종이 및 판지 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001692:1', '{"dJobCd":"K000001692","dJobCdSeq":"1","dJobNm":"관사운반원","workSum":"정방공정에서 생산된 관사를 권사공정으로 운반하고, 권사공정에서 나오는 빈목관을 색상별로 구분하여 정방공정에 공급한다.","doWork":"권사공정의 품목번호 및 목관의 색상에 따라 빈 목관을 통에 담아 기계 밖으로 운반한다. 잔사처리기를 사용하여 잔사를 목관으로부터 떼어낸다. 빈 목관을 색상별로 구분하여 통에 넣어 저장소에 적재한다. 실을 품종별로 구분하고 꼬리표를 확인한다. 실 꾸러미를 운반통에 정렬하여 싣는다. 공정 중 떨어진 부산물을 용기에 담아 운반하기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","connectJob":"목관선별원, 치즈운반원, 조사운반원, 타래운반원","dJobECd":"8900","dJobECdNm":"[8900]제조 단순 종사원","dJobJCd":"9300","dJobJCdNm":"[9300]제조 관련 단순 종사원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003679:1', '{"dJobCd":"K000003679","dJobCdSeq":"1","dJobNm":"도자기포장원","workSum":"깨지기 쉬운 다양한 종류의 도자기류 및 요업 완제품을 분류하여 포장지나 박스에 담아 포장한다.","doWork":"작업지시서에 따라 현재 생산되고 있는 제품의 종류, 제품별 포장 수량 등을 파악한다. 포장할 제품의 종류와 크기에 따라 포장방법을 확인한다. 포장하는 데 필요한 자재나 수동기계를 준비하고 점검한다. 포장용기 내부 밑에 덧받침을 넣고 마분지상자를 조립하거나 나무판재 상자를 조립한다. 작업표준에 따라 최종 공정을 거쳐 나온 제품을 포장용기에 담으며 제품의 흠집, 안료 부착 위치, 색깔 등의 불량 유무 및 품질표시 스티커 부착 여부, 낙관인쇄 여부 등을 확인한다. 포장할 제품을 분류하여 상자에 담고 제품을 보호하고 손상을 방지하기 위하여 제품 주위에 솜 또는 공기충전 보호자재를 댄다. 용기나 박스에 못을 박거나 테이프로 봉한다. 포장용기나 박스에 상표를 붙이고 제조일자 수량, 로트번호 등을 표기한다. 제품의 특수성에 따라 배열 또는 선발하여 포장하며, 포장된 용기를 봉한 후에 품목별, 크기별로 분류하여 적재한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","dJobECd":"8900","dJobECdNm":"[8900]제조 단순 종사원","dJobJCd":"9300","dJobJCdNm":"[9300]제조 관련 단순 종사원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003110:1', '{"dJobCd":"K000003110","dJobCdSeq":"1","dJobNm":"랩운반원","workSum":"혼타면 공정에서 생산된 랩(Lap)을 운반차에 실어 소면공정으로 운반한다.","doWork":"면이나 화학섬유 등의 원료를 종류나 번수에 따라 품종을 구분하여 표시하거나 다른 포장보자기로 포장하여 운반차에 싣는다. 랩을 운반하여 소면기계 앞에 놓고 포장보자기를 벗긴다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","dJobECd":"8900","dJobECdNm":"[8900]제조 단순 종사원","dJobJCd":"9300","dJobJCdNm":"[9300]제조 관련 단순 종사원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003486:1', '{"dJobCd":"K000003486","dJobCdSeq":"1","dJobNm":"목관운반원","workSum":"직기에서 다 사용된 위사 목관을 회수한다.","doWork":"제직공정에서 빈 목관을 회수하여 목관스트리퍼(Stripper)로 운반한다. 일정량의 실이 감긴 관사들을 손수레에 담아 제직공정으로 운반하여 목관보급 상자에 채운다. 실의 굵기별로 일정한 색으로 칠해진 목관을 색깔이나 소요량에 따라 모은다. 목관의 상태를 구분하여 불량품을 선별하거나 목관의 소요량, 불량 개수 등을 파악하여 기록표에 기록한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","similarNm":"목관회수원","dJobECd":"8900","dJobECdNm":"[8900]제조 단순 종사원","dJobJCd":"9300","dJobJCdNm":"[9300]제조 관련 단순 종사원","dJobICd":"C132","dJobICdNm":"[C132]직물직조 및 직물제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004307:1', '{"dJobCd":"K000004307","dJobCdSeq":"1","dJobNm":"봉투제조원","workSum":"재단된 종이를 손으로 접고 접착제를 발라서 봉투를 만든다.","doWork":"재단지 위에 일정 규격으로 접을 위치를 표시한다. 재단지를 자국에 따라 접고 가장자리에 솔로 접착제를 발라 완성된 봉투의 외형을 가위로 다듬고 일정 매수로 세어서 끈으로 묶는다. 봉투의 외형을 장식하거나 실용적으로 만들기 위하여 장식용품을 부착하거나, 봉투의 입구에 접착제를 발라 그대로 건조하기도 한다. 제대기(製袋機)에서 제조된 지대(紙袋:봉투)나 가방에 종이손잡이나 손잡이용 끈을 달기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"시범후 30일 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","dJobECd":"8900","dJobECdNm":"[8900]제조 단순 종사원","dJobJCd":"9300","dJobJCdNm":"[9300]제조 관련 단순 종사원","dJobICd":"C179","dJobICdNm":"[C179]기타 종이 및 판지 제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005923:1', '{"dJobCd":"K000005923","dJobCdSeq":"1","dJobNm":"부산물하조원","workSum":"혼타면, 소면, 정소면 공정에서 생산된 부산물과 기타 공정에서 발생된 풍면, 유면 등을 모아 묶어서 지정된 장소로 운반한다.","doWork":"손수레나 바퀴 달린 운반도구에 혼합된 섬유나 부산물을 담고 지정된 장소로 운반한다. 빗자루나 공기압축기(Air Compressor)로 작업장 주위를 청소한다. 배관을 통해 임시저장고로 운반된 혼합섬유뭉치 등을 빗자루나 갈고리 등으로 쓸거나 모아서 아래층의 작업장과 연결된 배관으로 밀어 넣기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"시범후 30일 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","similarNm":"부산물운반원","dJobECd":"8900","dJobECdNm":"[8900]제조 단순 종사원","dJobJCd":"9300","dJobJCdNm":"[9300]제조 관련 단순 종사원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001891:1', '{"dJobCd":"K000001891","dJobCdSeq":"1","dJobNm":"빔운반원","workSum":"제직준비가 끝난 빔이나 호부가공(Sizing)된 경사빔을 제직공정으로 운반하고 제직이 끝난 빈 빔을 준비공정으로 운반한다.","doWork":"제직할 빔이 없는 직기를 파악하거나 작업일정표에 따라 준비되거나 비어 있는 경사빔을 운반차를 이용하여 각 공정으로 운반한다. 제직이 끝난 경사빔을 잔여경사가 없도록 풀어내기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"시범후 30일 이하","workStrong":"힘든 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","dJobECd":"8900","dJobECdNm":"[8900]제조 단순 종사원","dJobJCd":"9300","dJobJCdNm":"[9300]제조 관련 단순 종사원","dJobICd":"C132","dJobICdNm":"[C132]직물직조 및 직물제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006781:1', '{"dJobCd":"K000006781","dJobCdSeq":"1","dJobNm":"생사정리원","workSum":"되올리기가 끝난 실타래를 큰 얼레에서 떼어내어 타래를 짓고 괄을 만들어 포장한다.","doWork":"되올리기를 마친 얼레를 양반기에서 떼어내고 실타래의 감긴 정도, 마른 정도를 조사한다. 실타래별로 겉 실마리와 속 실마리를 찾아 일정한 굵기의 면사로 묶는다. 실타래가 엉키지 않도록 면사로 5개조를 묶어서 얼레로부터 타래별로 떼어낸다. 실 한 타래의 무게를 달아 규정량으로 구분한다. 실타래 만들기가 끝나면 육안검사실로 옮겨 면사로 묶고 중심부에 상표를 부착하여 얇은 종이로 포장한다. 괄을 만드는 괄조기에 실타래를 일정하게 배열하고 압축하여 면사로 묶어내고 얇은 종이로 포장하기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","dJobECd":"8900","dJobECdNm":"[8900]제조 단순 종사원","dJobJCd":"9300","dJobJCdNm":"[9300]제조 관련 단순 종사원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003797:1', '{"dJobCd":"K000003797","dJobCdSeq":"1","dJobNm":"수동포장원(일반)","workSum":"완제품을 포장지나 박스에 담아 포장한다.","doWork":"포장용기를 손으로 투입한다. 기타 부속물을 손으로 삽입한다. 육안으로 불량유무를 검사한다. 완제품을 포장지에 담는다. 몇 개씩 묶음으로 포장된 제품을 박스에 담는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","connectJob":"포장제품결속원","dJobECd":"8900","dJobECdNm":"[8900]제조 단순 종사원","dJobJCd":"9300","dJobJCdNm":"[9300]제조 관련 단순 종사원","dJobICd":"N759","dJobICdNm":"[N759]기타 사업지원 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001767:1', '{"dJobCd":"K000001767","dJobCdSeq":"1","dJobNm":"슬리버운반원","workSum":"소면, 정소면, 연조, 조방기 사이에서 슬리버 통을 빼내어 다음 공정으로 운반한다.","doWork":"작업순서에 따라 소면기계에서 연조기계로, 연조기계에서 조방기계로 가득 찬 슬리버 통을 밀고 다닌다. 연조기계나 조방기계에서 빈 통을 빼내어 소면기계에 재사용하기 위해 준비한다. 작업장을 쓸고 기계를 청소하기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"시범후 30일 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","connectJob":"연조운반원, 정소면운반원","dJobECd":"8900","dJobECdNm":"[8900]제조 단순 종사원","dJobJCd":"9300","dJobJCdNm":"[9300]제조 관련 단순 종사원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003544:1', '{"dJobCd":"K000003544","dJobCdSeq":"1","dJobNm":"신발분류원","workSum":"완성된 신발류를 형태별, 크기별로 분류하여 포장박스에 넣는다.","doWork":"신발 적재대에서 신발을 꺼내어 형태별, 크기별로 분류한다. 신발짝을 맞추어 꼬리표를 부착한다. 신발의 형태를 보호하기 위해 보호형 종이, 플라스틱 패드 등을 넣는다. 포장용 박스에 신발을 넣고 포장한다. 포장된 박스를 신발 종류별로 적재하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","similarNm":"신발포장원","dJobECd":"8900","dJobECdNm":"[8900]제조 단순 종사원","dJobJCd":"9300","dJobJCdNm":"[9300]제조 관련 단순 종사원","dJobICd":"C152","dJobICdNm":"[C152]신발 및 신발 부분품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003593:1', '{"dJobCd":"K000003593","dJobCdSeq":"1","dJobNm":"원단포장원","workSum":"편직이나 염색이 완료된 원단을 비닐이나 종이 등으로 포장한다.","doWork":"검사가 완료된 원단의 개수를 확인한다. 편직이 완료된 생지원단 및 원통형 관에 감긴 염색이 끝난 원단을 비닐자루에 넣고 끝을 끈으로 묶는다. 중량, 작업내용 등의 내용을 적거나 프린트된 라벨을 붙인다. 출하될 위치로 옮겨 컨베이어를 사용하여 차량에 싣거나 창고로 운반해서 세워두거나 바닥에 쌓는다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","dJobECd":"8900","dJobECdNm":"[8900]제조 단순 종사원","dJobJCd":"9300","dJobJCdNm":"[9300]제조 관련 단순 종사원","dJobICd":"C133/C134","dJobICdNm":"[C133]편조원단 제조업 / [C134]섬유제품 염색, 정리 및 마무리 가공업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004308:1', '{"dJobCd":"K000004308","dJobCdSeq":"1","dJobNm":"자판원","workSum":"제조 포장된 전선케이블이 감긴 목 드럼 제품에 품명, 규격, 길이, 중량, 제조원 등을 표시한다.","doWork":"표시할 자판의 목록을 확인하고 목 드럼 제품의 총 중량을 계산한다. 표준활자 및 마크의 모양과 크기를 선정한다. 자판지 위에 제도하고 제도부분을 자와 칼을 사용하여 오려낸다. 자판지, 붓, 등사잉크, 페인트, 휘발유 등을 준비한다. 일정 비율로 등사잉크, 휘발유, 페인트 등을 혼합한다. 목 드럼에 제조원, 인증기관, 인증번호, 지장번호품명, 규격, 중량, 제조연월, 길이, 방향표시 등을 표기한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","dJobECd":"8900","dJobECdNm":"[8900]제조 단순 종사원","dJobJCd":"9300","dJobJCdNm":"[9300]제조 관련 단순 종사원","dJobICd":"C283","dJobICdNm":"[C283]절연선 및 케이블 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003781:1', '{"dJobCd":"K000003781","dJobCdSeq":"1","dJobNm":"재목공급원","workSum":"목제품을 가공하는 목공기계의 컨베이어 위나 호퍼 속 또는 롤러 사이에 재목을 공급한다.","doWork":"손수레 등의 운반도구를 이용하여 목재 저장소에서 목공기계로 운반한다. 운반도구에서 목재를 들어 올려 기계의 컨베이어 위나 호퍼(Hopper:분립체의 저장 및 공급장치) 속 또는 롤러 사이에 공급한다. 수동공구를 사용하여 기계 속에서 막혀 움직이지 않는 목재를 꺼내기도 한다. 기계 주위의 나뭇조각을 모아 분쇄기 속에 투입하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"투입인출","dJobECd":"8900","dJobECdNm":"[8900]제조 단순 종사원","dJobJCd":"9300","dJobJCdNm":"[9300]제조 관련 단순 종사원","dJobICd":"C162","dJobICdNm":"[C162]나무제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002095:1', '{"dJobCd":"K000002095","dJobCdSeq":"1","dJobNm":"재목운반원","workSum":"목제품 가공 기계로 가공된 목재를 쌓거나 운반한다.","doWork":"다음 공정을 위해 해당 작업부서로 이송할 수 있도록 목재를 쌓아두거나, 트럭화물용 적재판 또는 컨베이어 위에 올려놓는다. 목재의 수량을 파악하고, 외형의 결함을 검사하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","dJobECd":"8900","dJobECdNm":"[8900]제조 단순 종사원","dJobJCd":"9300","dJobJCdNm":"[9300]제조 관련 단순 종사원","dJobICd":"C162","dJobICdNm":"[C162]나무제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004329:1', '{"dJobCd":"K000004329","dJobCdSeq":"1","dJobNm":"절삭환거원","workSum":"합판제조공정에서 절단기(Chipper)로 들어가는 화목 중 사용 가능한 재료를 수거하여 정리한다.","doWork":"화목컨베이어 주변의 환거작업대에서 컨베이어로 들어가는 중판 화목 중 사용가능한 것을 회수한다. 회수한 화목은 길이별로 분류한다. 분류한 화목은 깔판에 적재하고 작업일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","dJobECd":"8900","dJobECdNm":"[8900]제조 단순 종사원","dJobJCd":"9300","dJobJCdNm":"[9300]제조 관련 단순 종사원","dJobICd":"C162","dJobICdNm":"[C162]나무제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002415:1', '{"dJobCd":"K000002415","dJobCdSeq":"1","dJobNm":"제재소작업원","workSum":"원목(통나무)이나 제재목을 자르기 위한 준비를 하거나 켜진 목재를 제재소에 보관하는 등의 잡무를 수행한다.","doWork":"지렛대를 이용하거나 손이나 트럭으로 열차에서 목재를 내리거나 싣는다. 제재소작업장으로 원목(통나무)을 옮겨 놓는다. 원목의 쇳조각, 돌, 썩은 곳, 쪼개진 곳 등을 검사하여 표시한다. 원목제재기의 앞면에서 원목제재원의 지시에 따라 쇠갈고리나 손으로 제재할 목재를 켜기에 용이하도록 회전시켜 위치를 잡는다. 켜져 나오는 반제품을 분류하고 롤러테이블이나 컨베이어 위로 안내하여 가장자리가 다듬어지도록 한다. 움직이는 컨베이어 위에 목재를 똑바로 놓는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","dJobECd":"8900","dJobECdNm":"[8900]제조 단순 종사원","dJobJCd":"9300","dJobJCdNm":"[9300]제조 관련 단순 종사원","dJobICd":"C161","dJobICdNm":"[C161]제재 및 목재 가공업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003960:1', '{"dJobCd":"K000003960","dJobCdSeq":"1","dJobNm":"제품적재원","workSum":"제재된 목제품을 크기나 길이에 따라 분류·적재한다.","doWork":"일정 규격으로 제재되어 컨베이어에 실려 나오는 목제품을 목제품의 규격, 품목에 따라 육안으로 선별·구분한다. 불량품을 골라내고 적재방법에 따라 지정된 장소에 차례로 적재·정리한다. 제재된 목재를 건조하기 위해 목재를 층층이 쌓기도 하며, 제재된 목재를 육안으로 보고 규격에 따라 선별하여 다음 가공을 위해 지정된 목재제재기나 적재 장소에 일정량씩 운반하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"약간의 시범정도","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","similarNm":"제품운반원, 제품정리원","dJobECd":"8900","dJobECdNm":"[8900]제조 단순 종사원","dJobJCd":"9300","dJobJCdNm":"[9300]제조 관련 단순 종사원","dJobICd":"C161","dJobICdNm":"[C161]제재 및 목재 가공업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002718:1', '{"dJobCd":"K000002718","dJobCdSeq":"1","dJobNm":"지관조립원","workSum":"받침지관(紙管), 내부지관, 외부지관, 컵, 링 등을 완전한 지관제품으로 조립한다.","doWork":"조립할 지관제품의 작업내용 및 작업순서를 숙지한다. 받침지관(紙管), 내부지관, 외부지관, 컵, 링 등의 원·부자재를 준비한다. 몸통에 컵, 받침, 속통 등을 조립하고 뚜껑을 덮어 완료한다. 완성된 지관제품의 수량을 파악하여 일정 수량씩 묶어 저장소에 운반한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"시범후 30일 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","dJobECd":"8900","dJobECdNm":"[8900]제조 단순 종사원","dJobJCd":"9300","dJobJCdNm":"[9300]제조 관련 단순 종사원","dJobICd":"C179","dJobICdNm":"[C179]기타 종이 및 판지 제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003527:1', '{"dJobCd":"K000003527","dJobCdSeq":"1","dJobNm":"직기청소원","workSum":"직조기와 그 부품 및 작업장을 공기호스나 솔 등을 사용하여 청소한다.","doWork":"청소에 필요한 물품을 준비한다. 직조기의 동작 상태를 확인한다. 작동이 멈춘 직조기 및 직조기 부분품을 청소세제, 빗자루, 걸레, 청소기계, 공기호스 등을 사용하여 청소한다. 화장실, 실내 등을 쓸고 닦는다. 청소 후 청결상태를 확인한다. 청소도구를 정리하고 관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","similarNm":"공기청소원, 공대청소원","dJobECd":"8900","dJobECdNm":"[8900]제조 단순 종사원","dJobJCd":"9300","dJobJCdNm":"[9300]제조 관련 단순 종사원","dJobICd":"C132","dJobICdNm":"[C132]직물직조 및 직물제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004104:1', '{"dJobCd":"K000004104","dJobCdSeq":"1","dJobNm":"직물운반원","workSum":"직조기나 편직기에서 옷감 롤을 떼내어 지정된 장소로 운반한다.","doWork":"직물이 기계에 표시된 일정 길이로 롤에 감기면 기계를 멈춘다. 가위로 직물을 자르고 직물 롤을 호이스트나 손으로 들어내어 손수레에 놓는다. 수량이나 품목번호 등의 확인표를 천 롤에 찍거나 붙인다. 손수레에 담긴 직물을 창고나 수정·검사부로 운반한다. 떼 낸 직물 롤의 무게를 달아 기록하기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","similarNm":"생지운반원, 홍두깨운반원","dJobECd":"8900","dJobECdNm":"[8900]제조 단순 종사원","dJobJCd":"9300","dJobJCdNm":"[9300]제조 관련 단순 종사원","dJobICd":"C132/C133","dJobICdNm":"[C132]직물직조 및 직물제품 제조업 / [C133]편조원단 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002123:1', '{"dJobCd":"K000002123","dJobCdSeq":"1","dJobNm":"포장반장","workSum":"포장작업과 포장원의 작업을 관리한다.","doWork":"완제품을 포장할 용기의 입고현황을 파악한다. 일일 생산량을 파악한다. 포장공정 중에 문제가 발생할 경우 조치를 취한다. 포장원의 근태를 관리한다. 일일 생산일지를 작성한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"수동조작","dJobECd":"8900","dJobECdNm":"[8900]제조 단순 종사원","dJobJCd":"9300","dJobJCdNm":"[9300]제조 관련 단순 종사원","dJobICd":"N759","dJobICdNm":"[N759]기타 사업지원 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001264:1', '{"dJobCd":"K000001264","dJobCdSeq":"1","dJobNm":"혼타면개포원","workSum":"혼타면 공정 전에 원면을 묶거나 포장한 철 띠 및 포장지를 제거하고 원면을 혼타면 기계 앞으로 운반한다.","doWork":"입고된 원면의 번수와 조별번호(Lot)를 확인하고 손수레에 실어 지정된 장소로 운반한다. 절단기를 사용하여 원면을 포장한 철 띠를 자르고 제거한다. 포장지를 제거하고 원면을 혼타면 기계의 급면부 앞으로 운반한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","dJobECd":"8900","dJobECdNm":"[8900]제조 단순 종사원","dJobJCd":"9300","dJobJCdNm":"[9300]제조 관련 단순 종사원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003452:1', '{"dJobCd":"K000003452","dJobCdSeq":"1","dJobNm":"기내청소원","workSum":"항공기의 청결을 유지하기 위하여 항공기의 내부를 청소한다.","doWork":"출발 및 도착하는 항공기를 확인하고 진공청소기, 세제 등의 작업도구를 준비한다. 기내의 재떨이, 쓰레기통을 비우고 바닥을 청소한다. 오염된 좌석의 커버를 교체하고 화장실을 청소한다. 모포, 기내지 등의 기내 용품을 정리한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"시범후 30일 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","similarNm":"캐빈청소원","dJobECd":"5611","dJobECdNm":"[5611]청소원","dJobJCd":"9411","dJobJCdNm":"[9411]청소원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004088:1', '{"dJobCd":"K000004088","dJobCdSeq":"1","dJobNm":"병원청소원","workSum":"병원의 진료실, 병실, 욕실, 실험실 및 기타 부속시설을 청소·소독한다.","doWork":"청소에 필요한 물품을 준비한다. 청소세제, 빗자루, 걸레, 청소기계 등을 사용하여 화장실, 실내 등을 쓸고 닦는다. 청소 후 청결상태를 평가한다. 청소도구를 정리하고 관리한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"시범후 30일 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","dJobECd":"5611","dJobECdNm":"[5611]청소원","dJobJCd":"9411","dJobJCdNm":"[9411]청소원","dJobICd":"N742","dJobICdNm":"[N742]건물ㆍ산업설비 청소 및 방제 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007015:1', '{"dJobCd":"K000007015","dJobCdSeq":"1","dJobNm":"세차원","workSum":"물과 세척액을 사용하여 자동차 외부를 세차하며 진공청소기로 차량 내부에 있는 먼지를 제거한다.","doWork":"오염된 차량표면과 하부에 물을 분사한다. 세정제를 이용하여 유리 및 차량표면을 세척한다. 진공청소기를 사용하여 차량 실내의 먼지를 제거한다. 각종 시트나 커버를 청소한다. 세차고객이 원할 경우 차량에 광택을 내기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"가벼운 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|손사용|","workEnv":"다습|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"5611","dJobECdNm":"[5611]청소원","dJobJCd":"9411","dJobJCdNm":"[9411]청소원","dJobICd":"S952","dJobICdNm":"[S952]자동차 및 모터사이클 수리업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007184:1', '{"dJobCd":"K000007184","dJobCdSeq":"1","dJobNm":"역구내정리원","workSum":"역구내 및 플랫폼을 청소하고 손·망실된 승객 편의시설을 개·보수한다.","doWork":"역구내 및 플랫폼 등의 청결을 유지하기 위하여 빗자루나 걸레 등을 사용하여 쓸고 닦는다. 화장실, 승강장 등 승객 편의시설물 등을 청소하고 부족 부품을 보충한다. 방화수, 방화사, 구내 시설물 등을 정리하고 부족한 양을 보충한다. 승강장 출입문, 계단, 화장실 등 승객의 편의시설의 손·망실을 점검하고 수리한다. 역구내에서 화물을 싣거나 내리는 일을 하기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"시범후 30일 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"웅크림|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","dJobECd":"5611","dJobECdNm":"[5611]청소원","dJobJCd":"9411","dJobJCdNm":"[9411]청소원","dJobICd":"H491","dJobICdNm":"[H491]철도 운송업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007705:1', '{"dJobCd":"K000007705","dJobCdSeq":"1","dJobNm":"유창청소원","workSum":"선박의 기름창고(油艙, 유창)를 청소하고 선박 및 해양에서 발생하는 각종 폐기물, 기름 등의 오염물질과 폐기물을 수거하고 처리한다.","doWork":"효율적이고 안전한 작업을 하기 위해 청소 대상 물질 및 그 특성을 파악하고 작업환경을 확인한다. 스퀴지, 워셔 등 청소 및 오염물질 제거에 사용하는 장비를 준비하고 점검한다. 보호구 및 작업복을 착용하고 선박의 기름창고(油艙, 유창)나 화물창고에서 관련 장비나 도구를 사용하여 청소한다. 선박 및 해양에서 발생하는 윤활유, 폐슬러지, 빌지 등의 오염물질의 수거, 보관, 관리 및 처리한다. 펜스 설치 등 급유 및 양․하역 시 발생하는 환경오염 사고에 대응하여 작업한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|고온|다습|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"해양오염방제작업자","dJobECd":"5611","dJobECdNm":"[5611]청소원","dJobJCd":"9411","dJobJCdNm":"[9411]청소원","dJobICd":"N742","dJobICdNm":"[N742]건물ㆍ산업설비 청소 및 방제 서비스업","inqYear":"2025"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003659:1', '{"dJobCd":"K000003659","dJobCdSeq":"1","dJobNm":"청소원(일반)","workSum":"사무실, 공공건물, 아파트 등에서 건물 내외부를 청소한다.","doWork":"청소에 필요한 물품을 준비한다. 청소세제, 빗자루, 걸레, 청소기계 등을 사용하여 화장실, 복도, 유리나 외벽, 가구 등을 청소한다. 청소 후 청결상태를 평가한다. 청소도구를 정리하고 관리한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"시범후 30일 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"웅크림|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","similarNm":"건물청소원","connectJob":"아파트청소원, 빌딩청소원, 고공외벽청소원","dJobECd":"5611","dJobECdNm":"[5611]청소원","dJobJCd":"9411","dJobJCdNm":"[9411]청소원","dJobICd":"N742","dJobICdNm":"[N742]건물ㆍ산업설비 청소 및 방제 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002391:1', '{"dJobCd":"K000002391","dJobCdSeq":"1","dJobNm":"항공기세척원","workSum":"부식 방지 및 청결, 원활한 작동을 유지하기 위해 항공기 외부를 청소한다.","doWork":"세척장 내로 견인된 항공기를 확인하고, 세제나 왁스, 솔 등의 작업도구를 준비한다. 급수장비를 사용하여 물을 뿌리고 세제를 사용하여 이물질을 제거하거나 물을 사용하지 않고 왁스를 이용하여 세척한다. 항공기 외관의 제빙 및 제설작업을 수행한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"균형감각|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","dJobECd":"5611","dJobECdNm":"[5611]청소원","dJobJCd":"9411","dJobJCdNm":"[9411]청소원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002179:1', '{"dJobCd":"K000002179","dJobCdSeq":"1","dJobNm":"호텔객실청소원","workSum":"호텔이나 여관 등의 숙박업소에서 깨끗하고 청결한 객실을 유지·관리한다.","doWork":"걸레, 세제, 진공청소기 등의 청소기구를 사용하여 객실을 청소한다. 화기나 전기에 의한 화재를 예방한다. 객실문이 열리고 닫혔는지 여부를 점검한다. 객실 및 복도에 설치된 각종 비품상태를 점검하고 보충한다. 투숙고객이 의뢰한 세탁물을 수거하고 배달한다. 객실에서 일어나는 상황을 부서에 신속히 알려준다. 청소 중 습득물을 관련 부서에 통보한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"시범후 30일 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"웅크림|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","similarNm":"룸메이드, 하우스키퍼(Housekeeper), 객실청소원","certLic":"호텔서비스사","dJobECd":"5611","dJobECdNm":"[5611]청소원","dJobJCd":"9411","dJobJCdNm":"[9411]청소원","dJobICd":"I551","dJobICdNm":"[I551]일반 및 생활 숙박시설 운영업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003176:1', '{"dJobCd":"K000003176","dJobCdSeq":"1","dJobNm":"고물상","workSum":"고물과 재화를 수집 및 판매한다.","doWork":"리어카 또는 트럭을 이용하여 이동하면서 고물과 재화(폐지, 고철, 비철, 폐전선, 구리, 스테인리스, 재활용품 등)를 수집한다. 개인 고물상의 경우 수집한 고물을 고물 도매상에게 판매하고 고물 도매상의 경우 고물을 폐지, 고철, 구리, 스테인리스 등으로 분류하여 제지공장, 철강회사, 재활용 공장 등에 판매한다. 철거현장 또는 이사 장소에 나가서 고물을 수집하거나 매입하기도 한다.","optionJobInfo":{"eduLevel":"6년 이하(초졸 이하)","skillYear":"약간의 시범정도","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"손사용|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","connectJob":"폐지수집상, 고철수집상","dJobECd":"5612","dJobECdNm":"[5612]환경미화원 및 재활용품 수거원","dJobJCd":"9412","dJobJCdNm":"[9412]환경미화원 및 재활용품 수거원","dJobICd":"G467","dJobICdNm":"[G467]기타 전문 도매업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002065:1', '{"dJobCd":"K000002065","dJobCdSeq":"1","dJobNm":"공항관리작업원","workSum":"공항의 주변 및 각종 시설물의 청결을 유지하기 위하여 청소하고 보수업무를 지원한다.","doWork":"청사내외, 계류장, 도로 및 인도에 버려진 쓰레기나 먼지를 청소한다. 공항 주변의 환경을 관리하기 위하여 관목 및 잔디에 물과 거름을 주고 잡초를 제거한다. 오물 및 쓰레기를 치우거나 장비를 운반하기 위하여 소형 트럭을 운전한다. 괭이, 삽, 갈고리 등을 사용하여 활주로와 배수구를 청소하고 파손된 부위를 수리한다. 전기시설, 배관시설을 수리하는 작업원을 보조하기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","dJobECd":"5612","dJobECdNm":"[5612]환경미화원 및 재활용품 수거원","dJobJCd":"9412","dJobJCdNm":"[9412]환경미화원 및 재활용품 수거원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003313:1', '{"dJobCd":"K000003313","dJobCdSeq":"1","dJobNm":"재제조잉크카트리지선별원","workSum":"폐잉크카트리지의 노즐을 육안으로 1차 검사한 후 검사장비에 넣어 화면에 노즐 손상이 없는지 체크한 후 노즐 막힘이 심한 폐카트리지는 폐기 처분하고 노즐 막힘이 적은 카트리지를 선별한다.","doWork":"여러 가지 종류의 폐잉크카트리지가 담긴 박스를 작업대 위에 올려놓고 선별한다. 재생되지 않은 잉크카트리지(버진잉크카트리지)인지 아니면 한 번 이상 재생한 잉크카트리지인지 먼저 구분한 후 각자 브랜드별로 재분류한다. 육안으로 노즐이 막혔는지, 노즐 부분의 잉크가 혼합되어 섞여 있는지, 잉크가 샌 흔적은 없는지 조사하여 재생이 어려운 폐카트리지는 분류하여 폐기 처리한다. 육안으로 검사된 폐카트리지를 검사장비에 넣어 노즐 막힘이 있는지 상세 검사하여 재생이 가능한 폐카트리지를 따로 선별한 후 카트리지 조립라인으로 보낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","dJobECd":"5612","dJobECdNm":"[5612]환경미화원 및 재활용품 수거원","dJobJCd":"9412","dJobJCdNm":"[9412]환경미화원 및 재활용품 수거원","dJobICd":"C204","dJobICdNm":"[C204]기타 화학제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006252:1', '{"dJobCd":"K000006252","dJobCdSeq":"1","dJobNm":"폐플라스틱선별원","workSum":"선별라인에서 일반플라스틱, 알루미늄 병뚜껑, 기타 이물질 등을 구분하여 제거한다.","doWork":"압축된 재활용 플라스틱이 컨베이어를 타고 지나가면 금속류, 재생대상이 아닌 플라스틱, 기타 생활쓰레기, 알루미늄 병뚜껑 등의 이물질을 제거한다. 플라스틱병이 롤링 현상, 미끄러짐 현상이 일어나지 않도록 벨트가 잘 장착되어 있는지 확인한다. 선별력이 떨어지면 근적외선 신호(Pulse:펄스)를 보정하여 높은 페트 선별도를 유지한다. 선별된 페트를 호퍼에 담아 다음 공정인 분쇄기로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","dJobECd":"5612","dJobECdNm":"[5612]환경미화원 및 재활용품 수거원","dJobJCd":"9412","dJobJCdNm":"[9412]환경미화원 및 재활용품 수거원","dJobICd":"E383","dJobICdNm":"[E383]해체, 선별 및 원료 재생업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004218:1', '{"dJobCd":"K000004218","dJobCdSeq":"1","dJobNm":"환경미화원","workSum":"공원, 운동장, 상가, 주택가, 거리 등 공공장소에서 청소하고 재활용, 폐기물을 분리, 수거한다.","doWork":"관할 구역 내의 공공장소나 거리에 있는 폐기물을 빗자루와 운반차량을 이용하여 청소한다. 일정 구역을 돌면서 상가나 주택가의 쓰레기를 수집한다. 휴지통이나 쓰레기 투여 지정 장소에서 쓰레기를 옮겨 담아 비운다. 쓰레기를 임시 집하소가 있는 곳에 운반한다. 임시 적재소에서 수집한 쓰레기 중에서 재활용품을 구분, 분류한다. 재활용품은 별도의 수거차량에 적재하여 재활용센터, 재활공장으로 운반한다. 음식 쓰레기와 폐기되어야 할 쓰레기는 소각장이나 매립장으로 운반한다. 쓰레기 수거차량을 운전하여 작업하기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"시범후 30일 이하","workStrong":"힘든 작업","workPlace":"실외","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","similarNm":"쓰레기수거원","connectJob":"음식물쓰레기수거원","certLic":"운전면허","dJobECd":"5612","dJobECdNm":"[5612]환경미화원 및 재활용품 수거원","dJobJCd":"9412","dJobJCdNm":"[9412]환경미화원 및 재활용품 수거원","dJobICd":"N742","dJobICdNm":"[N742]건물ㆍ산업설비 청소 및 방제 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007361:1', '{"dJobCd":"K000007361","dJobCdSeq":"1","dJobNm":"경비반장","workSum":"사업체를 순찰하고 정문출입을 확인·통제하는데 종사하는 경비원의 활동을 감독·조정한다.","doWork":"경비원의 근무시간 및 인원을 조정한다. 각 부서를 순찰하고 당직일지, 출입자일지, 순찰일지 등을 확인하고 근무상황을 점검한다. 기타 제반 경비 업무를 수행한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"감독","workFunc3":"단순작업","certLic":"일반경비지도사","dJobECd":"5420","dJobECdNm":"[5420]경비원(건물 관리원)","dJobJCd":"9421","dJobJCdNm":"[9421]건물 관리원","dJobICd":"N753","dJobICdNm":"[N753]경비, 경호 및 탐정업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007575:1', '{"dJobCd":"K000007575","dJobCdSeq":"1","dJobNm":"경비원","workSum":"아파트 등 공공주택 및 사업장, 학교, 오피스텔 등에서 방문자의 출입을 점검하고 불법침입, 도난, 화재, 기타 위험 방지와 재산을 감시한다.","doWork":"경비에 필요한 직무내용을 숙지한다. 건물에 출입하는 방문자를 점검한다. 출입자에게 방문목적, 방문대상자, 연락처 등을 받아 기록한다. 주요 시설물을 순찰하고 보안상에 이상이 없는지 확인한다. 교대근무자에게 경비에 필요한 제반 사항을 인수하거나 인계받는다. 청소 등 환경관리 업무를 하기도 한다. 재활용가능자원의 분리배출 정리·단속업무를 하기도 한다. 위험·도난 발생 방지 목적을 전제로 한 주차관리와 택배물품 보관 등의 업무를 하기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"시범후 30일 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"단순작업","connectJob":"방호원","certLic":"일반경비지도사","dJobECd":"5420","dJobECdNm":"[5420]경비원(건물 관리원)","dJobJCd":"9421","dJobJCdNm":"[9421]건물 관리원","dJobICd":"N753","dJobICdNm":"[N753]경비, 경호 및 탐정업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004556:1', '{"dJobCd":"K000004556","dJobCdSeq":"1","dJobNm":"교구관리인","workSum":"종교단체(교회, 성당, 사찰 등)의 예배시설 및 집기를 관리한다.","doWork":"예배시설 내부를 청소하고 난로, 보일러 등의 난방 및 냉방시설을 유지·관리한다. 전기, 전화, 방재, 수도 등의 시설을 유지·관리한다. 종교의식을 준비하고 용기 및 비품 등을 관리한다. 화원 및 조경시설을 관리한다. 종교의식의 진행을 보조하거나 방문자를 안내하기도 한다. 도둑이나 건물의 파손을 방지하기 위하여 건물을 순찰하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"단순작업","dJobECd":"5420","dJobECdNm":"[5420]경비원(건물 관리원)","dJobJCd":"9421","dJobJCdNm":"[9421]건물 관리원","dJobICd":"S949","dJobICdNm":"[S949]기타 협회 및 단체","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003557:1', '{"dJobCd":"K000003557","dJobCdSeq":"1","dJobNm":"묘지관리원","workSum":"공동묘지의 유택을 분할하고 관리한다.","doWork":"공동묘지 내의 지형을 검토하고 유택을 분할한다. 유족들과 협의하여 유택을 결정하고 장례에 따른 절차와 조건을 결정한다. 장례행렬을 인도한다. 봉분을 만들고 잔디를 입히는 작업자를 감독한다. 봉분의 잡초를 제거하고 잔디를 깎으며 묘지 내의 도로와 나무를 관리한다. 납골당 시설을 관리하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"웅크림|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"단순작업","dJobECd":"5420","dJobECdNm":"[5420]경비원(건물 관리원)","dJobJCd":"9421","dJobJCdNm":"[9421]건물 관리원","dJobICd":"S969","dJobICdNm":"[S969]그 외 기타 개인 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005386:1', '{"dJobCd":"K000005386","dJobCdSeq":"1","dJobNm":"쓰레기매립장관리원","workSum":"산업쓰레기, 가정용쓰레기 등의 운반차량을 점검·확인하여 반입을 허가·관리한다.","doWork":"쓰레기의 반입량 및 반입차량을 확인하고 쓰레기의 종류를 점검한다. 쓰레기의 종류를 확인하여 매립이 가능한 것은 반입을 허가하고 산업 폐기물이나 유독성 물질은 관련 처리장으로 운반하도록 설명한다. 일정량의 쓰레기가 쌓이면 흙이나 모래를 사용하여 복토작업을 실시하도록 지시한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"대기환경미흡|다습|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"단순작업","dJobECd":"5420","dJobECdNm":"[5420]경비원(건물 관리원)","dJobJCd":"9421","dJobJCdNm":"[9421]건물 관리원","dJobICd":"E381","dJobICdNm":"[E381]폐기물 수집, 운반업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002153:1', '{"dJobCd":"K000002153","dJobCdSeq":"1","dJobNm":"장내정리원","workSum":"경마장, 경륜장 내 자산을 보호하고, 부정행위의 사전예방과 위법행위의 단속 및 장내질서를 유지하는데 관련된 제반 업무를 수행한다.","doWork":"부정 위법행위에 대한 정보를 수집하기 위하여 부정신고센터를 운영한다. 입장권 미소지자, 부정행위자, 만취자, 미성년자에 대하여 입장을 거부한다. 소요, 방화 등 긴급사태 발생 시 고객들을 안전지대로 대피시킨다. 경마장, 경륜장 내 자산보호를 위하여 기타 경비업무를 수행한다. 긴급사태 발생 시 경찰업무를 지원한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"단순작업","similarNm":"사설단속원","dJobECd":"5420","dJobECdNm":"[5420]경비원(건물 관리원)","dJobJCd":"9421","dJobJCdNm":"[9421]건물 관리원","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007523:1', '{"dJobCd":"K000007523","dJobCdSeq":"1","dJobNm":"검표원","workSum":"극장, 유원지, 경기장 등에서 입장객의 표를 검사하고 출입객을 관리한다.","doWork":"출입문에서 고객의 입장권을 검사·확인하거나 표를 받는다. 출입객, 외래자를 관리하며, 부정으로 출입하려는 자를 막는다. 매표소 또는 주변 게시판을 관리한다. 각종 일지를 작성한다. 부대시설을 안내하고 고객의 문의사항에 응대한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"시범후 30일 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"단순작업","similarNm":"수표원, 집표원","dJobECd":"5624","dJobECdNm":"[5624]검표원","dJobJCd":"9422","dJobJCdNm":"[9422]검표원","dJobICd":"R912","dJobICdNm":"[R912]유원지 및 기타 오락관련 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001986:1', '{"dJobCd":"K000001986","dJobCdSeq":"1","dJobNm":"버스표검표원","workSum":"차량을 이용할 승객의 안전한 승차를 위하여 승차 안내를 하며 차량 출발 시 후진을 유도한다.","doWork":"차량노선, 출발시간, 요금 그리고 차종 등을 기준으로 승객의 승차권을 검사하고 승차권을 회수하며 승객과 승차권의 매수 및 만석 여부를 확인한다. 무임승차를 단속하기도 한다. 수화물을 취급하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"단순작업","similarNm":"개찰원","dJobECd":"5624","dJobECdNm":"[5624]검표원","dJobJCd":"9422","dJobJCdNm":"[9422]검표원","dJobICd":"H492","dJobICdNm":"[H492]육상 여객 운송업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003836:1', '{"dJobCd":"K000003836","dJobCdSeq":"1","dJobNm":"케이블카검표원","workSum":"고객에게 케이블카 탑승을 안내하고 승객의 탑승 표를 검사한다.","doWork":"케이블카를 이용하는 고객에게 승차장소를 안내하고 탑승구 내 질서를 유지한다. 케이블카조작원의 신호를 확인한 후 운행상태를 확인하여 고객의 승차권을 확인한다. 승객의 승·하차 시 케이블카의 바깥쪽 문을 개폐한다. 승강장 및 케이블카 주변의 청결상태를 유지한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"단순작업","dJobECd":"5624","dJobECdNm":"[5624]검표원","dJobJCd":"9422","dJobJCdNm":"[9422]검표원","dJobICd":"H492","dJobICdNm":"[H492]육상 여객 운송업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007566:1', '{"dJobCd":"K000007566","dJobCdSeq":"1","dJobNm":"가사관리사","workSum":"가정을 방문하여 청소, 세탁, 요리 등의 가사 업무를 대행한다.","doWork":"일시적으로 도움이 필요한 가정을 방문하거나 일정 기간 고용되어 집안일을 돕는다. 가정의 화장실, 거실 등의 집안을 청소하고, 가재도구의 먼지를 제거하는 등 집안을 정리·정돈한다. 의복, 이불 등을 세탁·건조하고 다림질한 후 정돈한다. 우편물을 보관하고, 공과금을 대신 납부한다. 요청에 따라 음식을 만들고 대접하는 등의 가사업무를 수행한다. 가정용품의 구입을 대행한다. 고객이 원하는 장소에 방문하여 부모를 대신하여 자녀 혹은 노인을 돌본다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"단순작업","similarNm":"파출부, 가정부, 가사보조원, 가사도우미","dJobECd":"5616","dJobECdNm":"[5616]가사 도우미","dJobJCd":"9511","dJobJCdNm":"[9511]가사 도우미","dJobICd":"T970","dJobICdNm":"[T970]가구 내 고용활동","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006187:1', '{"dJobCd":"K000006187","dJobCdSeq":"1","dJobNm":"수납정리원","workSum":"고객의 의뢰에 따라 쾌적하고 효율적인 생활 및 사무공간 구성을 위해 물건과 공간을 정리하는 서비스를 제공한다.","doWork":"가정, 기업, 공장, 학교 등 정리수납을 필요로 하는 고객의 의뢰에 따라 전화 또는 방문하여 정리수납을 상담한다. 견적서를 작성하고 계약을 체결한다. 작업공간, 작업인원, 일정, 준비사항, 레이아웃(영역별로 청결하고 효율적인 수납시스템을 구성하기) 등을 고려하여 작업계획서를 작성한다. 정리수납 작업원을 섭외 및 구성하고 작업영역별로 배치한다. 다양한 정리수납 기법(물건의 분류, 수납위치 결정, 동선을 고려한 배치, 수납질서 구축, 수납용품의 활용, 수납총량 원칙에 의한 수납량 조절 및 물건 버리기, 청결하고 효율적인 수납시스템 구성 등)을 현장에 적용하여 정리수납 작업을 한다. 현장에서 문제점이 발생하면 작업원과 상의하여 조치한다. 작업영역별로 작업결과를 확인·점검한다. 작업이 완료되면 고객에게 정리수납 시스템을 유지할 수 있도록 설명한다. 고객의 추가요구 사항을 확인하고 조치한다. 작업평가서 및 작업완료 확인서를 작성한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"단순작업","similarNm":"주변환경정리전문가, 정리정돈전문가, 정리컨설턴트, 수납컨설턴트","dJobECd":"5616","dJobECdNm":"[5616]가사 도우미","dJobJCd":"9511","dJobJCdNm":"[9511]가사 도우미","dJobICd":"S969","dJobICdNm":"[S969]그 외 기타 개인 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007520:1', '{"dJobCd":"K000007520","dJobCdSeq":"1","dJobNm":"육아도우미","workSum":"가정에서 부모를 대신하여 아이를 돌보는 일을 한다.","doWork":"부모에게 아이의 특이사항 및 주의사항을 듣고 숙지한다. 문제 발생 시 연락할 연락처, 부모가 돌아오는 시간 등을 확인한다. 아이를 안전하게 보호하며 식사, 놀이, 수면, 배변 등 아이의 일상적인 활동을 돕는다. 긴급사항이 발생 시 적절히 대처한다. 돌봄이 종료되는 시점에 부모에게 당일 특이사항을 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"약간의 시범정도","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"웅크림|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","similarNm":"베이비시터","dJobECd":"5502","dJobECdNm":"[5502]육아 도우미","dJobJCd":"9512","dJobJCdNm":"[9512]육아 도우미","dJobICd":"S969","dJobICdNm":"[S969]그 외 기타 개인 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002206:1', '{"dJobCd":"K000002206","dJobCdSeq":"1","dJobNm":"패스트푸드원","workSum":"패스트푸드점에서 햄버거를 굽거나 용기에 담는 등 단순 반복적인 음식 제공 업무를 수행한다.","doWork":"제품별 조리 매뉴얼을 숙지하고 조리·위생 관련 주의사항을 확인한다. 주재료와 부재료(각종 소스나 조미료 등)를 조리용기에 담고 소모량을 보충한다. 고객의 주문서를 확인하고 햄버거, 피자, 닭튀김, 도넛 등 패스트푸드를 간단히 조리한다. 포장지에 포장하거나 용기에 담아서 제공한다. 튀김솥, 그릴, 집게, 뜰채, 커피머신, 음료머신, 아이스크림머신 등 조리시설을 청결하게 유지한다. 매장을 청소하기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"약간의 시범정도","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"단순작업","dJobECd":"5321","dJobECdNm":"[5321]패스트푸드 준비원","dJobJCd":"9521","dJobJCdNm":"[9521]패스트푸드 준비원","dJobICd":"I561","dJobICdNm":"[I561]음식점업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007025:1', '{"dJobCd":"K000007025","dJobCdSeq":"1","dJobNm":"급식도우미","workSum":"초등학교에서 학생들의 급식을 돕는다.","doWork":"거주지 인근의 초등학교에 파견되어 주로 저학년 학생들을 대상으로 점심식사 배식을 돕는다. 식사 시에 손씻기, 편식하지 않기 등의 식사예절을 지도한다. 식사 후 식탁닦기 등의 뒷정리를 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"시범후 30일 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"관련없음","workFunc2":"서비스제공","workFunc3":"단순작업","similarNm":"학교급식보조원","dJobECd":"5323","dJobECdNm":"[5323]주방 보조원","dJobJCd":"9522","dJobJCdNm":"[9522]주방 보조원","dJobICd":"I561","dJobICdNm":"[I561]음식점업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005684:1', '{"dJobCd":"K000005684","dJobCdSeq":"1","dJobNm":"병원배식원","workSum":"병원에서 입원환자의 식사를 식판에 담아 배달한다.","doWork":"메뉴판의 내용을 읽고 환자의 식사내용에 따라 식판에 필요한 그릇을 놓는다. 그릇에 음식을 담아 배식차에 넣고 환자에게 식사를 배달한다. 환자가 식사를 마친 후, 그릇들을 수거하여 주방으로 운반한다. 그릇, 조리대, 찬장, 오븐 등을 세척한다. 음식찌꺼기와 오물을 수거하여 쓰레기를 처리한다. 입원 중인 환자의 식사 현황을 기록·보고한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"단순작업","similarNm":"병원배선배식원","dJobECd":"5323","dJobECdNm":"[5323]주방 보조원","dJobJCd":"9522","dJobJCdNm":"[9522]주방 보조원","dJobICd":"I561","dJobICdNm":"[I561]음식점업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005093:1', '{"dJobCd":"K000005093","dJobCdSeq":"1","dJobNm":"조리사보조원","workSum":"음식을 요리하는 숙련 조리사를 보조하여 주방정리, 기물세척, 식재료 준비 등의 업무를 수행한다.","doWork":"채소와 과일을 세척하고, 껍질을 벗기고 잘라서 씨를 제거한다. 육류, 가금류 등을 조리용으로 준비한다. 해산물을 세척하여 가르고 잘라 요리용으로 만든다. 냄비, 솥, 접시 등의 조리용구를 작업대나 가스레인지 또는 냉장고로 운반한다. 조리된 음식을 지정된 장소로 운반하여 알맞은 온도로 보관한다. 주방용구와 기구를 세척하고 남은 음식을 처리한다. 조리장과 주변의 청결을 유지하기 위하여 청소를 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|고온|다습|","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"수동조작","similarNm":"요리사보조원","connectJob":"주방보조원","dJobECd":"5323","dJobECdNm":"[5323]주방 보조원","dJobJCd":"9522","dJobJCdNm":"[9522]주방 보조원","dJobICd":"I561","dJobICdNm":"[I561]음식점업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004922:1', '{"dJobCd":"K000004922","dJobCdSeq":"1","dJobNm":"가스충전원","workSum":"충전기를 사용하여 차량에 LPG가스를 충전한다.","doWork":"위험물을 취급하는데 필요한 기본사항을 숙지한다. 가스충전을 원하는 차량의 충전구 위치를 파악하여 차량을 충전기 옆으로 적절히 인도한다. 충전기를 사용하여 적절한 양을 충전한다. 가스 대금을 정산한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"가벼운 작업","workPlace":"실외","physicalAct":"손사용|","workEnv":"대기환경미흡|위험내재|","workFunc1":"계산","workFunc2":"관련없음","workFunc3":"관련없음","similarNm":"LPG충전원","dJobECd":"6157","dJobECdNm":"[6157]주유원(가스충전원)","dJobJCd":"9531","dJobJCdNm":"[9531]주유원","dJobICd":"G477","dJobICdNm":"[G477]연료 소매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002463:1', '{"dJobCd":"K000002463","dJobCdSeq":"1","dJobNm":"선박급유원","workSum":"선박에 연료를 주입하고 연료량을 관리한다.","doWork":"화재와 누유에 대비한 선박 설비들을 점검한다. 급유 시 안전한 사용법을 숙지한다. 작업일지를 검토하여 급유할 선박의 종류 및 급유량을 확인한다. 급유선박의 접안을 확인하고 밧줄을 사용하여 급유할 선박과 연결한다. 급유호스를 선박 위로 올리고 연료탱크의 뚜껑을 열어 선박의 매니폴드(Manifold:봉입 밸브를 여러 개 병렬로 부착시킨 분기관)와 연결한다. 정전기로 인한 화재를 예방하기 위하여 선박과 급유선박을 접지한다. 펌프를 가동하고 밸브를 열어 연료를 급유한다. 유량계를 점검하여 선박에 급유된 연료를 확인한다. 선박의 명칭 및 급유량 등을 작업일지에 기록한다. 수상에 설치된 급유관을 사용하여 급유하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"힘든 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"유지","dJobECd":"6157","dJobECdNm":"[6157]주유원(가스충전원)","dJobJCd":"9531","dJobJCdNm":"[9531]주유원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001579:1', '{"dJobCd":"K000001579","dJobCdSeq":"1","dJobNm":"수소충전원","workSum":"충전기 노즐을 연결하여 차량에 수소를 충전한다.","doWork":"수소충전을 원하는 차량의 충전구 위치를 파악하여 차량을 충전기 옆으로 적절히 인도한다. 충전 노즐을 차량에 연결한 뒤, 충전시작 버튼을 눌러 충전을 시작한다. 충전과정을 모니터링하고 충전이 완료되면 버튼을 눌러 충전을 종료한다. 충전양을 확인하고 카드단말기 등으로 요금을 정산한다. 안전문제가 발생하면 조치를 취하고 안전관리자 업무를 보조하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"가벼운 작업","workPlace":"실외","physicalAct":"손사용|","workEnv":"위험내재|","workFunc1":"계산","workFunc2":"서비스제공","workFunc3":"관련없음","certLic":"가스기능사","dJobECd":"6157","dJobECdNm":"[6157]주유원(가스충전원)","dJobJCd":"9531","dJobJCdNm":"[9531]주유원","dJobICd":"G477","dJobICdNm":"[G477]연료 소매업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005847:1', '{"dJobCd":"K000005847","dJobCdSeq":"1","dJobNm":"차량주유원","workSum":"가솔린, 디젤 등 각종 차량의 연료 종류에 맞는 연료를 주유기를 사용하여 주유한다.","doWork":"위험물 취급과 관련된 기본사항을 숙지한다. 주유를 원하는 차량의 종류(가솔린차량, 디젤차량, 가솔린 및 디젤차량)와 주유구의 위치를 파악하여 차량을 적절한 주유기 옆으로 인도한다. 주유기를 사용하여 적절한 양을 주유하고 대금을 정산한다. 소비자의 요구에 따라 워셔액, 부동액, 엔진첨가제 등을 판매하기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"시범후 30일 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"투입인출","similarNm":"주유원, 주유판매원","dJobECd":"6157","dJobECdNm":"[6157]주유원(가스충전원)","dJobJCd":"9531","dJobJCdNm":"[9531]주유원","dJobICd":"G477","dJobICdNm":"[G477]연료 소매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004645:1', '{"dJobCd":"K000004645","dJobCdSeq":"1","dJobNm":"철도급유원","workSum":"기관차 운행에 필요한 연료를 주입하고 연료의 양을 관리한다.","doWork":"탱크로리(Tank Lorry)로 입고된 기름의 양을 확인하고 지하탱크에 주입하도록 한다. 주유하기 위하여 입고된 기관차의 주유구를 열고, 주유호스를 주입한다. 펌프를 작동하거나 밸브를 열어 주유를 한다. 주유량을 확인하여 일지에 기록한다. 차량의 운전거리 계기판을 확인하여 운전거리, 입출고사항, 통과역명 등을 정리하여 기름소요량을 산출한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|","workFunc1":"기록","workFunc2":"서비스제공","workFunc3":"투입인출","connectJob":"연료관리원","dJobECd":"6157","dJobECdNm":"[6157]주유원(가스충전원)","dJobJCd":"9531","dJobJCdNm":"[9531]주유원","dJobICd":"H491","dJobICdNm":"[H491]철도 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003646:1', '{"dJobCd":"K000003646","dJobCdSeq":"1","dJobNm":"항공기급유원","workSum":"펌프 기능의 급유트럭을 조작하여 항공기에 항공유를 급유한다.","doWork":"급유할 항공기의 기종 및 유량을 확인한다. 하이드런트(Hydrant Fuel System:항공기 급유 방식의 일종) 펌프트럭을 이용하여 주기장 내 지하에 설치되어 있는 급유전과 항공기 연료탱크를 연결한다. 펌프기를 가동하여 항공유를 급유한다. 급유량을 확인하여 일지에 기록하고 해당 항공편 정비사에게 전달한다. 항공유를 실은 급유차를 이용하여 급유하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실외","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","dJobECd":"6157","dJobECdNm":"[6157]주유원(가스충전원)","dJobJCd":"9531","dJobJCdNm":"[9531]주유원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006124:1', '{"dJobCd":"K000006124","dJobCdSeq":"1","dJobNm":"매장정리원","workSum":"의류 매장, 액세서리 매장, 스포츠용품 매장 등 각종 상품을 판매하는 매장에서 상품을 진열하고 집기를 정리한다.","doWork":"창고 또는 배송차량으로부터 상품을 수령하고 비어있는 진열대에 상품을 보충한다. 유통기한의 경과, 신제품으로 교체, 판매중단, 상품진열의 변화, 상품가격의 변동, 할인행사, 각종 프로모션 등에 의해 매장의 상품을 교체하거나 새로 진열한다. 재고를 파악하거나 상품창고를 정리하기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"힘든 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"단순작업","connectJob":"상품운반원, 상품진열원, 상품정리원, 물품정리원, 매장물품정리원, 백화점상품진열원, 대형마트상품진열원, 쇼핑카트운반원, 쇼핑카트정리원, 매장정리보조원, 판매보조원","dJobECd":"6179","dJobECdNm":"[6179]기타 판매 단순 종사원","dJobJCd":"9539","dJobJCdNm":"[9539]기타 판매 관련 단순 종사원","dJobICd":"G471","dJobICdNm":"[G471]종합 소매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004977:1', '{"dJobCd":"K000004977","dJobCdSeq":"1","dJobNm":"쇼핑몰택배준비원","workSum":"홈쇼핑, 인터넷 쇼핑몰에서 주문된 상품을 택배로 발송하기 위한 준비작업과 발송의뢰를 한다.","doWork":"전자상거래 시스템을 이용하여 주문정보(주문서)를 확인한다. 상품의 재고 및 위치를 파악한다. 주문서에 따라 상품의 종류와 개수를 확인한다. 상품의 종류에 따라 소분(완제품을 나누어 재포장) 작업을 하기도 한다. 충진재 포장, 에어캡 포장, 진공 포장, 비닐 포장, 묶음 포장 등을 하여 상품이 운송과정에서 파손되지 않도록 조치한다. 택배박스에 상품을 포장하고 운송장을 작성하여 부착한다. 택배회사로 출고한다. 전자상거래 시스템에 운송장 번호를 입력한다. 택배로 입고된 반품이나 교환품을 처리하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"약간의 시범정도","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","connectJob":"쇼핑몰상품준비원, 택배물품포장원","dJobECd":"6179","dJobECdNm":"[6179]기타 판매 단순 종사원","dJobJCd":"9539","dJobJCdNm":"[9539]기타 판매 관련 단순 종사원","dJobICd":"H494","dJobICdNm":"[H494]소화물 전문 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001248:1', '{"dJobCd":"K000001248","dJobCdSeq":"1","dJobNm":"전단지배포원","workSum":"거리에서 행인들에게 광고전단지를 배포하거나 포스터와 같은 홍보물을 게시판 등에 부착한다.","doWork":"구청의 전단지 배포 신고필증이 날인된 전단지를 수령한다. 전단지를 거리에서 행인들에게 배포(가두배포) 한다. 포스터의 경우 거리에 지정된 홍보게시판에 부착한다. 아파트의 경우 관리사무소의 승낙을 받아 정해진 수수료를 납부하고 세대에 배포하거나 게시판에 부착한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"약간의 시범정도","workStrong":"가벼운 작업","workPlace":"실외","workFunc1":"관련없음","workFunc2":"관련없음","workFunc3":"단순작업","connectJob":"카탈로그배포원, 홍보지배포원, 벽보원, 포스터부착원, 스티커부착원, 광고스티커부착원","dJobECd":"6179","dJobECdNm":"[6179]기타 판매 단순 종사원","dJobJCd":"9539","dJobJCdNm":"[9539]기타 판매 관련 단순 종사원","dJobICd":"M713","dJobICdNm":"[M713]광고업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004633:1', '{"dJobCd":"K000004633","dJobCdSeq":"1","dJobNm":"정보지배포관리원","workSum":"정보지나 기타 무가지 등의 배포대를 관리하고, 배포대에 생활정보지나 무가지 등을 비치한다.","doWork":"차량 등을 이용하여 정보지(생활정보지)나 기타 무가지를 배포한다. 통행인이 많은 곳에 배포대를 설치하고, 정기적으로 발간되는 무가지를 비치한다. 우천시나 기타 기후의 변화에 따라 배포대에 비닐을 씌우는 등 필요한 조치를 취하여 관리한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"시범후 30일 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"관련없음","workFunc2":"말하기신호","workFunc3":"단순작업","dJobECd":"6179","dJobECdNm":"[6179]기타 판매 단순 종사원","dJobJCd":"9539","dJobJCdNm":"[9539]기타 판매 관련 단순 종사원","dJobICd":"M713","dJobICdNm":"[M713]광고업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003074:1', '{"dJobCd":"K000003074","dJobCdSeq":"1","dJobNm":"농업단순노무자","workSum":"숙련 농업종사원을 도와서 농사일을 보조한다.","doWork":"농지의 용수를 공급하고 배수하기 위한 목적으로 도랑을 파거나 삽질을 한다. 각종 농산물을 싣고 내린다. 건초를 손질하여 쌓는다. 농산물에 물을 주고 제초작업을 한다. 가축에게 사료 또는 물을 주고 축사를 청소한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"시범후 30일 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"웅크림|","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","dJobECd":"9050","dJobECdNm":"[9050]농림어업 단순 종사원","dJobJCd":"9910","dJobJCdNm":"[9910]농림·어업 관련 단순 종사원","dJobICd":"A011","dJobICdNm":"[A011]작물 재배업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001726:1', '{"dJobCd":"K000001726","dJobCdSeq":"1","dJobNm":"산림병충해방제작업원","workSum":"산림지역이 병해나 위해로부터 피해를 받았을 시 병충해 방제를 위하여 약제를 살포한다.","doWork":"산림병충해예찰조사원으로부터 피해지역과 병충해의 종류를 확인하고 약제를 선택·준비한다. 약제와 물의 혼합비율에 따라 약제를 조제·혼합한다. 비행기에 약제통을 싣고 살포기구를 부착한다. 약제살포지역, 비행속도, 고도 등을 비행기 조종사와 협의한다. 비행기를 타고 병충해 지역으로 이동하여 피해지역을 안내하여 살포토록 한다. 휴대용 분무장비를 사용하여 일부의 산림지역에 약제를 살포하기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"단순작업","dJobECd":"9050","dJobECdNm":"[9050]농림어업 단순 종사원","dJobJCd":"9910","dJobJCdNm":"[9910]농림·어업 관련 단순 종사원","dJobICd":"A020","dJobICdNm":"[A020]임업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003507:1', '{"dJobCd":"K000003507","dJobCdSeq":"1","dJobNm":"산불감시원","workSum":"화재예방에 대한 계획을 수립하고 지정된 산림과 벌목예정지역을 순찰하며 산불을 감시한다.","doWork":"산림지대나 벌목지대를 수시로 순찰하여 화재위험 대상 및 여부를 조사한다. 산불진화에 필요한 소화호스, 양동이, 소화기 등의 상태를 확인하고 소화장비를 검사하여 목록을 작성한다. 조사내용에 대한 상황보고서를 준비한다. 위반사항을 시정하도록 지침서와 지시서를 발행하며 지시대로 이행되는지 확인하기 위하여 시정 지역을 재조사한다. 소화공구 및 장비의 관리와 수리를 위하여 소모 또는 상실되거나 고장 난 소화공구·장비를 대체하고 필요한 물품을 보충하기 위하여 새로운 장비와 물자공급을 요구한다. 산불이 많이 발생하는 건조기에는 산림지대 내 사람들의 접근과 오락 및 나무채취 등을 제한한다. 산불이 발생하면 관련 기관에 무전기를 통하여 알리고 진화작업을 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"단순작업","dJobECd":"9050","dJobECdNm":"[9050]농림어업 단순 종사원","dJobJCd":"9910","dJobJCdNm":"[9910]농림·어업 관련 단순 종사원","dJobICd":"A020","dJobICdNm":"[A020]임업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003499:1', '{"dJobCd":"K000003499","dJobCdSeq":"1","dJobNm":"수산물채취원","workSum":"간조 시에 갯벌에서 낫, 호미, 해조틀이, 갈고리 등을 사용하여 패류, 해조류 등을 채취한다.","doWork":"낫, 호미, 해조틀이, 갈고리, 망태 등의 작업도구를 준비한다. 갯벌에 들어가 바지락, 대합, 꼬막 등의 패류 및 해조류를 채취하여 망태 또는 바구니에 담는다. 채취물을 판매하기 위하여 건조하거나 세척하고 분류한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"시범후 30일 이하","workStrong":"힘든 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|저온|다습|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","connectJob":"패류채취원, 해조류채취원","dJobECd":"9050","dJobECdNm":"[9050]농림어업 단순 종사원","dJobJCd":"9910","dJobJCdNm":"[9910]농림·어업 관련 단순 종사원","dJobICd":"A031","dJobICdNm":"[A031]어로 어업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001373:1', '{"dJobCd":"K000001373","dJobCdSeq":"1","dJobNm":"약제살포원","workSum":"트럭에 장치한 탱크와 호스를 사용해서 나무와 관목, 잔디밭 등에 제초제, 살충제, 살균제를 살포한다.","doWork":"호스와 펌프를 사용해서 배합비에 따라 분무탱크에 물과 화학작용제를 채워 혼합한다. 분무호스를 트럭에 장치된 릴(Reel)에서 잡아당기고, 바람의 방향이나 작업현장의 특성을 감안하여 약제의 분사방향을 설정하여 잡초와 나무, 관목, 잔디 등에 살포한다. 때에 따라서는 동력트럭에 장치된 활줄을 통제하는 레버를 조작해서 분무막대의 위치를 정하고 압축된 화학용약을 살포한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실외","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","dJobECd":"9050","dJobECdNm":"[9050]농림어업 단순 종사원","dJobJCd":"9910","dJobJCdNm":"[9910]농림·어업 관련 단순 종사원","dJobICd":"A014","dJobICdNm":"[A014]작물재배 및 축산 관련 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003594:1', '{"dJobCd":"K000003594","dJobCdSeq":"1","dJobNm":"어업단순노무자","workSum":"숙련 어업종사원을 도와서 해저 청소, 사료제공, 해초, 이끼, 어패류 등을 채취한다.","doWork":"도구를 사용하여 해저를 청소한다. 양식하고 있는 물고기나 연체동물에게 사료를 준다. 해초, 이끼, 조개 및 기타 연체동물 및 어패류를 채취한다. 기타 어업과 관련된 간단한 업무를 수행한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"시범후 30일 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"웅크림|","workEnv":"위험내재|다습|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","dJobECd":"9050","dJobECdNm":"[9050]농림어업 단순 종사원","dJobJCd":"9910","dJobJCdNm":"[9910]농림·어업 관련 단순 종사원","dJobICd":"A031","dJobICdNm":"[A031]어로 어업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004116:1', '{"dJobCd":"K000004116","dJobCdSeq":"1","dJobNm":"임업단순노무자","workSum":"숙련 임업종사원을 도와서 묘목을 운반하고, 구덩이를 파거나 관목을 제거하는 등 간단한 임무를 수행한다.","doWork":"나무를 심기 위하여 구덩이를 판다. 목재수확을 하기 위하여 관목을 제거하거나 가지를 친다. 통나무 및 목재를 운반하여 쌓는다. 기타 숙련 임업종사원이 지시하는 간단한 임무를 수행한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"시범후 30일 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","similarNm":"영림단원, 영림원","dJobECd":"9050","dJobECdNm":"[9050]농림어업 단순 종사원","dJobJCd":"9910","dJobJCdNm":"[9910]농림·어업 관련 단순 종사원","dJobICd":"A020","dJobICdNm":"[A020]임업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003606:1', '{"dJobCd":"K000003606","dJobCdSeq":"1","dJobNm":"검침사무원","workSum":"수요자의 전력사용과 관련된 계량기검침, 사용량협정, 위약조사 등의 행정 및 민원 사항에 대한 사무업무를 수행한다.","doWork":"전기 사용에 대한 신규계약 후 발생하는 무단사용, 용도 외 사용 등 위약사항에 대한 조사를 위하여 검침한다. 검침결과를 기준으로 계약을 정상화한 후 요금 및 위약금을 부과한다. 수요자가 사용하는 전기계량기의 불량으로 발생한 검침오류에 대하여 조사한 후 고장기간, 사용량 등을 추정하여 고객에게 제시하고 협의하여 적정요금을 부과한다. 검침을 담당하는 용역업체가 검침업무를 공정하고 신속하게 처리할 수 있도록 관리한다. 오 검침, 사용량 과다, 검침누락 등의 민원을 처리하고 관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"5621","dJobECdNm":"[5621]계기 검침원 및 가스 점검원","dJobJCd":"9921","dJobJCdNm":"[9921]계기 검침원 및 가스 점검원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006083:1', '{"dJobCd":"K000006083","dJobCdSeq":"1","dJobNm":"검침원","workSum":"가스·수도·전력 등을 사용한 곳을 방문하여 계량기를 검침하여 사용량을 기록한다.","doWork":"정기적으로 담당 구역의 수용가(소비자)를 방문하여 계량기의 지침을 읽고 기록장치에 사용량을 기록한다. 계량기의 가동상태를 확인한다. 소비자가 요금징수와 계산방법, 문제점 등에 대해 질문하면 이에 대한 해결방법을 알려준다. 불량계량기 또는 도용 사항을 점검·확인하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"시범후 30일 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"기록","workFunc2":"말하기신호","workFunc3":"단순작업","similarNm":"계기검침원","connectJob":"가스검침원, 수도검침원, 전기검침원","dJobECd":"5621","dJobECdNm":"[5621]계기 검침원 및 가스 점검원","dJobJCd":"9921","dJobJCdNm":"[9921]계기 검침원 및 가스 점검원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;