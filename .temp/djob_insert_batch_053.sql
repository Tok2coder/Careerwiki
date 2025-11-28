INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002365:1', '{"dJobCd":"K000002365","dJobCdSeq":"1","dJobNm":"신선검사원","workSum":"신선공정의 선재를 각 공정별로 시료를 채취하여 경도, 외경, 단면모양, 인장력 등의 특징을 검사한다.","doWork":"작업장을 순회하며 공정별로 시료를 채취하여 마이크로미터를 사용하여 외경을 측정한다. 각종 검사기구를 사용하여 선재의 인장, 강도, 신장률, 단면 감소율 등을 검사한다. 검사 후 불량 원인을 분석하여 다음 공정에 알린다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"선재품질관리원","connectJob":"선재검사원","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001281:1', '{"dJobCd":"K000001281","dJobCdSeq":"1","dJobNm":"신선기조작원","workSum":"코일선재를 일련의 다이(Die)에 통과시켜 선재를 가늘게 뽑아내어 신선하는 기계를 조작한다.","doWork":"작업지시서에 따라서 신선기의 종류를 선택한다. 코일선재의 끝을 다이의 유도장치 및 드럼에 삽입하여 통과시킨다. 신선기를 가동하고 신선을 촉진하기 위해 윤활유를 바른다. 측정 기구를 사용해서 신선된 코일의 규격을 확인한다. 드럼에 일정량의 선재가 감기게 되면 기계를 정지하고 기구를 사용하여 선재를 인출하여 적재 장소에 적재한다. 제품의 규격, 재질 등의 식별이 가능하도록 꼬리표를 부착한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001331:1', '{"dJobCd":"K000001331","dJobCdSeq":"1","dJobNm":"신선반장","workSum":"코일선재를 일정한 구경의 다이(Die)에 통과시켜 신선제품을 만드는 일에 종사하는 작업원의 직무를 분장하고 조정한다.","doWork":"작업지시서에 따라 작업원을 배치하고 신선기 및 금형의 선별상태, 기타 보조공구를 확인한다. 작업원들과 함께 작업하기도 하며 작업지시를 한다. 신선되는 코일의 상태를 육안으로 검사하고 측정기구를 사용하여 작업기준에 규정된 규격과 일치하는지 확인한다. 작업원의 직무를 분장하고 근무상태, 작업태도, 작업진행상황 등을 감독한다. 제품의 생산량을 작업일지에 기록하여 보관한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","connectJob":"코일선재제조반장","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006885:1', '{"dJobCd":"K000006885","dJobCdSeq":"1","dJobNm":"알루미늄코일중합기조작원","workSum":"알루미늄코일을 알루미늄박으로 생산하기 위하여 두 장의 알루미늄코일을 겹치는 중합기를 조작한다.","doWork":"작업지시서의 중합규격에 의하여 두께 및 사이즈 등의 작업내용을 숙지하고 중합기 등 관련 설비를 점검한다. 중압 후 코일의 두께 및 표면 상태를 확인하고, 롤이 이상 있을 시 교체한다. 가이드롤의 표면을 깨끗한 헝겊으로 닦고 가이드롤 면의 상처 유·무를 체크한다. 모서리부분을 절취하기 위하여 칼날을 최대 적정 사이즈로 맞춘다. 기중기로 코일을 옮겨 언와인더에 두 개의 알루미늄코일을 장착한다. 두 개의 알루미늄코일의 선단을 가이드롤 사이로 통과시켜 권취되는 쪽의 스플에 감는다. 머지(Merge) 한 장을 앞 코일에 테이프로 접착시키고 오일밸브를 연다. 두 장의 재료가 트리밍되면서 감기면 서서히 속도를 올리고 공기압을 준다. 작업이 진행되는 동안 정상작업이 되는지 코일의 인장상태, 공기압상태, 기계의 이상 유무를 관찰한다. 작업이 끝나면 권취된 쪽의 스플을 빼내어 저울에 중량을 달고 작업일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"더블러조작원","connectJob":"알루미늄박생산원","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"C242","dJobICdNm":"[C242]1차 비철금속 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006862:1', '{"dJobCd":"K000006862","dJobCdSeq":"1","dJobNm":"압연롤정비원","workSum":"열간 또는 냉간압연용 롤(Roll)의 정도 개선을 위한 표면연삭 및 교체와 쵸크, 베어링 등 압연기 부품 정비와 압연롤 교체 업무를 통해 최적의 압연 조건을 유지한다.","doWork":"기술표준 및 작업표준에 따라 압연롤의 표면품질 평가와 연마/선삭기준, 재사용 기준을 숙지하여 롤을 세척하고 연마설비를 통해 표면 정도를 개선한다. 압연작업 중 롤의 결함이나 이상상태를 확인하고 개선조치를 수행한다. 압연장치의 해체와 조립업무를 수행하면서 압연롤을 교체하고, 원활한 압연이 이루어지도록 압연롤의 상태의 점검과 보수를 지속한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"롤연마원, 롤조립원","certLic":"기계정비기능사, 기계정비산업기사","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004620:1', '{"dJobCd":"K000004620","dJobCdSeq":"1","dJobNm":"압연원","workSum":"전처리된 소재를 회전하는 롤(Roll)사이에 치입하고 압연하여 판, 봉, 선, 관, 형강 등 목적한 형상의 제품으로 가공하는 업무를 수행한다.","doWork":"작업지시서에 따라 입고된 소재의 치수 및 중량이 일치하는지 확인하고 강종 특성을 숙지하며, 압연기 및 부속설비의 이상유무를 점검한다. 소재 이상 확인시 작업표준서에 따라 절단 및 표면정정작업을 수행할 수 있다. 소재를 압연기에 치입(Biting)하고 롤갭(Roll Gap), 압연속도 및 스킨패스를 조정하여 목적한 형상의 제품으로 압연한다. 압연 중 목적한 형상으로 제어하기 위한 압연설비 조작과 표면의 품질 이상유무를 확인한다. 작업 및 기술표준서를 기초로 부적합품이 고객에게 인도되지 않도록 정보처리를 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|고온|소음·진동|","workFunc1":"조정","workFunc2":"교육","workFunc3":"제어조작","connectJob":"열간압연반장, 냉간압연반장","certLic":"압연기능사, 압연기능장","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003041:1', '{"dJobCd":"K000003041","dJobCdSeq":"1","dJobNm":"압연유관리원","workSum":"압연기에 사용되는 각종 압연유 및 유압류를 혼합하고 관리한다.","doWork":"압연유 관리기준에 따라, 상시 압연유의 성분과 상태를 관리한다. 압연유 성분과 상태가 후행공정에 미치는 영향을 인지하고 압연유 상태에 따라 클리닝 설비를 가동한다. 조업기준에 따라 프리믹싱(Pre Mixing) 압연유를 제조하고, 압연기 조작원과 협조하여 최적의 압연이 이루어지도록 압연유 및 유압류를 공급한다. 압연유에 기인된 품질불량 항목을 판단하고 이를 조치한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"압연기능사, 압연기능장","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002957:1', '{"dJobCd":"K000002957","dJobCdSeq":"1","dJobNm":"압연재정정원","workSum":"압연공정에서 생산된 압연재의 형상이 불량한 경우 Roller 또는 Press 교정작업을 실시하고, 표면 불량재는 보수하여 표면을 정정하는 업무를 수행한다.","doWork":"압연공정에서 생산, 냉각된 압연재를 절단하고, 형상이 불량한 경우 열연코일은 스킨패스 라인에 투입하여 재압연, 검사, 절단, 권취작업을 실시한다. 후판의 경우 롤러(Roller) 또는 프레스(Press)로 교정작업을 실시한다. 표면불량재는 작업표준서에 기초하여 그라인더 등을 이용하여 보수하고 이를 기록한다. 이후 제품을 컨베이어 또는 롤러테이블을 통과시킨 후 제품 평량, 라벨부착 및 포장 등 제품의 출하 단계로 이송한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"압연제품정정원, 압연재교정원","certLic":"압연기능사, 압연기능장","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004076:1', '{"dJobCd":"K000004076","dJobCdSeq":"1","dJobNm":"압출작업원","workSum":"가열된 빌릿(Billet) 소재를 일련의 금형에 압력을 주어 통과시키는 압출기를 이용하여 이음매 없는 관이나 환봉 등을 생산한다.","doWork":"작업지시서와 압출성형 설비 및 금형 상태를 점검한다. 빌릿(Billet)을 조건에 맞도록 가열한 후 표면 스케일을 제거한다. 빌릿의 내·외면에 윤활제를 도포하여 컨테이너(Container) 속으로 장입되도록 기계를 조작한다. 램(Ram)을 조작하여 적정 압력으로 금형을 통해 압출하고, 압출된 제품을 냉각 후 검사하여 이를 기록한다. 품질 이상시 교정기를 이용하여 교정하고, 방청제를 도포한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|청각|손사용|시각|","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"압출원","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003975:1', '{"dJobCd":"K000003975","dJobCdSeq":"1","dJobNm":"여과압착기조작원","workSum":"황산에 녹인 아연용액에서 불순물을 제거하여 케이크(Cake) 형상으로 만들어주는 여과압착기를 조작한다.","doWork":"여과압착기의 여과틀 사이에 여과포를 삽입하고 일정 유압으로 압착한다. 압력에 의해 아연용액이 정화조에서 여과압착기로 흐르도록 펌프를 가동한다. 아연정액원의 신호에 따라 공기밸브를 조절하여 여과틀 사이에 있는 케이크 형상을 하부 호퍼에 떨어지게 한다. 마모된 여과포를 교환하고 필요시 여과압착기를 보수하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"다습|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004724:1', '{"dJobCd":"K000004724","dJobCdSeq":"1","dJobNm":"열간압연원","workSum":"소재를 최적의 압연온도로 가열한 후 회전하는 롤 사이로 통과시켜 재결정온도 이상에서 압연하여 판, 봉, 선, 형강 등의 제품을 생산한다.","doWork":"작업표준서 및 압연할 소재의 특성과 치수 등을 확인한다. 압연 설비를 매뉴얼에 따라 성능과 점검 포인트를 확인하여 이상유무를 점검한다. 압연스케줄 편성, 압연유, 압연롤 등 사전 준비 후 고압살수를 통한 표면스케일을 제거한다. 고객이 요구하는 두께, 폭, 형상을 만족시키도록 열간중에 압연과 냉각을 진행한다. 설비사양서를 기초로 소재별 텐션량을 조절하고, 압연조건을 최적화하여 두께 및 형상제어를 실시한다. 경우에 따라 표면 및 재질 개선을 위한 교정압연을 진행한다. 이후 고객이 요구하는 품질의 폭 전단 및 표면검사를 실시하여 작업일지를 작성한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"열간압연원","connectJob":"열간작업원","certLic":"압연기능사, 압연기능장","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004560:1', '{"dJobCd":"K000004560","dJobCdSeq":"1","dJobNm":"열처리검사원","workSum":"열처리 전·후 제품의 품질이 일치하는지 확인하기 위하여 열처리 후에 가공된 금속을 검사한다.","doWork":"제품주문서 및 작업지시서에 따라 열처리된 금속의 검사시편을 제작한다. 금속의 기계적 성질(경도, 경화 깊이) 및 금속조직 검사, 비파괴검사 및 정해진 부위의 제품치수를 측정한다. 열처리 기준에 맞고 편차가 없는지, 요구하는 기계적 성질과 조직에 맞는지, 표면과 내부의 결함이 없는지 검사하고 기준에 따라 판정한다. 로크웰, 브리넬 및 성분분석기 등의 시험기로 소재를 측정한다. 조미니 시험기(Jominy Test:강 등의 경도를 정하는 시험 방법), 초음파탐상기, 자기탐상기 등으로 시험·검사하여 경화, 내부 및 표면 결함을 측정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|고온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"열처리품질검사원","certLic":"열처리기능사","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005953:1', '{"dJobCd":"K000005953","dJobCdSeq":"1","dJobNm":"열처리반장","workSum":"금속제품의 조직과 특성을 변화시키기 위해 열처리 작업에 종사하는 작업원의 직무를 분장하고 업무를 조정하는 등 열처리공정 전반에 대하여 관리하고 감독한다.","doWork":"소재 열처리와 표면 열처리를 구분해 작업계획을 세운다. 각각에 맞는 공정과 추진항목을 검토해 열처리원을 배치하고 작업에 대한 기본적인 내용을 교육한다. 열처리원에게 관련된 설비를 검사하고 시험 작동할 것을 지시한다. 작업계획에 의해 열처리 과정을 함께 진행하며, 수시로 그 내용을 확인한다. 이상이 있거나 작업에 부하가 걸리는 일이 있으면 그 문제점을 해결한다. 완성된 열처리 제품에 대해서 기본적인 육안 검사를 실시한 후, 열처리검사원에게 검사를 의뢰한다. 생산성 파악 및 불량요인을 분석하고 작업내용을 작업일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","similarNm":"열처리공정관리원","connectJob":"열처리팀장","certLic":"열처리기능사","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004655:1', '{"dJobCd":"K000004655","dJobCdSeq":"1","dJobNm":"열처리원","workSum":"금속제품의 조직과 특성을 향상하기 위한 열처리를 위해 금속의 가열과 냉각 및 화학처리를 하는 설비를 조작한다.","doWork":"작업계획의 세부 추진항목에 따른 작업내용 및 열처리반장의 작업지시를 확인한다. 열처리 작업을 위한 각종 설비 및 공구를 점검하고 준비한다. 열처리조업지침에 따라 열처리 방법 및 절차, 온도, 시간을 결정한다. 가공품을 노에 장입·가열하고 온도계를 관찰하며 일정 온도로 유지한다. 열처리된 제품을 노에서 꺼내 물, 기름, 화학약품, 기타 용액을 사용하거나 공기 중에서 냉각한다. 가공품의 열처리 상태를 확인하기 위하여 경화 정도 등을 시험하기도 한다. 열처리 설비를 가열하기 위해 유도장치를 조작하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"열처리로조작원","connectJob":"열처리작업원","certLic":"열처리기능사","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004404:1', '{"dJobCd":"K000004404","dJobCdSeq":"1","dJobNm":"용압반장","workSum":"전선을 제조하기 위해 알루미늄을 용해·주조·압연하는 작업원의 직무를 분장하고 조정한다.","doWork":"주문서에 따라 작업지시서를 만든다. 납기일에 따라 일일생산량계획을 수립한다. 작업에 필요한 각종 공구와 기계 등을 점검하고 확인한다. 작업공정 방법과 순서를 정하여 작업원을 배치하고 작업을 지시한다. 작업공정을 순회하고 공정별 기술적인 지도를 한다. 완성된 제품의 규격이 작업지시서와 일치하는지 확인하고 검사한다. 불량품에 대해서는 재가공 및 수정을 지시한다. 고온에 의한 화상 등 작업장의 안전과 작업원의 위생 등을 관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"고온|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"C283","dJobICdNm":"[C283]절연선 및 케이블 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004275:1', '{"dJobCd":"K000004275","dJobCdSeq":"1","dJobNm":"인발작업원","workSum":"인발기의 경사진 구멍(Taper 형상)의 금형에 소재를 통과시키고, 단면적을 감소시켜 원하는 형상과 크기의 봉재, 선재, 관재 등을 생산한다.","doWork":"작업조건과 인발성형 설비 및 금형을 점검한다. 원소재의 표면 흠, 스케일 등을 제거하기 위한 산(Acid)세척, 그라인딩 등 전처리를 수행한다. 인발기를 이용하여 인발작업을 수행하고, 유압펌프를 작동하여 윤활유를 바르거나 손으로 도포한다. 금형을 통과하여 인발된 제품을 적치대에 쌓아둔다. 품질 이상시 교정기를 이용하여 교정하고, 방청제를 도포한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|청각|손사용|시각|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"인발원","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002657:1', '{"dJobCd":"K000002657","dJobCdSeq":"1","dJobNm":"입내기조작원","workSum":"인발을 위해 금속소재의 선단부를 다이의 직경보다 가늘게 가공한다.","doWork":"작업지시서에 맞게 다이 또는 날을 선택하여 기계에 고정한다. 소재를 작업대 위에 올리고 클램프(Clamp)에 물린다. 기계를 작동하여 다이를 열고 소재를 장입한다. 소재의 선단부를 가늘게 소성가공하거나 깎는다. 계측기를 사용하여 작업된 선단부를 계측하고 제품에 손상이 없는지 확인한다. 작업이 완료된 제품을 인발공정으로 운반하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"포인팅작업원","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002868:1', '{"dJobCd":"K000002868","dJobCdSeq":"1","dJobNm":"자동차용범퍼압출원","workSum":"자동차용 고장력 알루미늄 범퍼를 생산하기 위하여 압출기를 조작한다.","doWork":"작업지시서에 따라 생산할 범퍼의 종류와 규격, 형태, 수량, 납기일 등을 확인하여 작업계획을 세운다. 압출기의 윤활상태 및 각 계기판을 점검하여 작동 여부를 확인한다. 안전화, 안전모, 보호안경 등의 안전장비를 착용한다. 범퍼의 종류 및 생산량에 따라 알루미늄 빌릿(Billet:형강으로 압연하기 전의 각형 단면강재)을 지게차로 운반하여 작업장으로 이송한다. 호이스트를 이용하여 알루미늄 빌릿을 압출기의 작업대에 놓는다. 압출기의 제어장치를 조작하여 예열온도로 맞추고 빌릿을 일정한 온도로 충분히 예열한다. 예열된 빌릿의 상태를 확인한 후 압출기를 조작하여 압출속도, 압출가압, 압출온도를 조절하고 알루미늄 빌릿을 압출한다. 압출과정을 육안으로 주시하고 관찰하며 압출상태에 따라 압출기의 컨트롤박스를 조작하여 압출작업을 한다. 압출된 알루미늄제품의 외형 및 상태를 작업지시서의 규격과 비교한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"알루미늄범퍼압출원","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"C303","dJobICdNm":"[C303]자동차 신품 부품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003932:1', '{"dJobCd":"K000003932","dJobCdSeq":"1","dJobNm":"전선신선원","workSum":"코일선재를 일련의 금형틀에 통과하여 일정 구경의 선재를 만들고 이로 인해 발생하는 잔류응력을 제거하기 위해 신선기를 조작한다.","doWork":"작업표준에 따라 기계장비를 점검한다. 작업지시서에 따라 모선(작업 할 선재), 코일받이, 권취기 등을 준비한다. 신선기의 압력, 신선유, 코일받이, 냉각수의 상태를 점검한다. 직경을 확인하고 다이, 금형틀을 장착한다. 모선을 신선기에 장착한다. 신선기를 예열한다. 본작업 버튼을 눌러 장비를 작동한다. 모선의 풀림 상태, 선재의 진행상태, 텐션 동작상태, 권취상태를 확인한다. 선재의 긁힘이나 끊어짐을 주의 깊게 관찰한다. 작업종료 시 다음 작업이 있으면 모선을 장착한다. 신선된 선재의 직경, 외관, 권취상태를 검사하고 기록한다. 장비의 전원을 끄고 서서히 냉각되는 여열에 주의하며 장비, 남은 선재, 작업도구를 정리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"전선신선기조작원","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"C283","dJobICdNm":"[C283]절연선 및 케이블 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001788:1', '{"dJobCd":"K000001788","dJobCdSeq":"1","dJobNm":"전선연선반장","workSum":"전선을 제조하기 위하여 연선 작업을 하는 종업원의 직무를 분장하고 조정한다.","doWork":"생산계획에 의하여 원자재, 인원 등을 각 공정의 소요시간에 알맞게 배치한다. 원자재의 각종 특성을 숙지하여 작업지시서를 작성한다. 작업원을 교육하며 기술적인 지도를 한다. 작업표준서 및 시방서와 생산제품이 일치하는지 검사, 확인한다. 기계의 이상 유무를 확인하고 유지, 보수한다. 소모품, 마모된 부품을 확인하여 청구한다. 작업 능률을 높이기 위하여 작업환경의 개선을 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"전선생산반장","connectJob":"전선집합반장, 전선연합반장","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"C283","dJobICdNm":"[C283]절연선 및 케이블 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004483:1', '{"dJobCd":"K000004483","dJobCdSeq":"1","dJobNm":"전선연선원","workSum":"케이블의 유연성을 증대하고 외경감소를 위해 두 개 이상의 나선을 꼬는 연선작업을 하고, 종이, 동, PVC, 알루미늄 등의 절연재로 피복을 형성하는 연선기를 조작한다.","doWork":"작업지시서에 따라 선재 및 소요자재를 확인한다. 다이스, 가이드롤러를 준비한다. 종이, 동, PVC, 알루미늄 등 절연재를 장착한다. 보빈을 크래들에 장착하고 보빈에서 선을 빼내어 보조선에 연결한다. 조작레버로 기계를 가동한다. 단선들이 꼬여서 연선이 되는 상태를 관찰한다. 연선상태, 선재의 보급을 확인한다. 다이스를 통과하여 나온 선재에 조권사(부직포, 종이테이프, 폴리에틸렌)를 감고 권취보빈에 감기는 동작을 확인한다. 피치(일정 구간에 감기는 횟수), 권취 상태, 테이핑 상태를 점검한다. 선제의 공급, 절연테이프의 공급을 점검한다. 조작레버로 장비를 정지한다. 소선경(선제외경, 도체외경), 피치, 가닥수, 꼬임방향, 작업외경 등을 검사하여 기록한다. 생산량 및 불량을 보고한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"대성연원, 세연원, 밀작업원","connectJob":"전선집합원, 전선연합원","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"C283","dJobICdNm":"[C283]절연선 및 케이블 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005199:1', '{"dJobCd":"K000005199","dJobCdSeq":"1","dJobNm":"제습관철망제작원","workSum":"제습관(흄관, Hume Pipe:원심력을 이용하여 만든 철근콘크리트 관)을 제작하기 위하여 철선을 편성기에 넣고 밀대를 회전하면서 밖으로 나오는 직선철선에 나선철선을 스폿용접하여 조립철망을 제조한다.","doWork":"직선절단을 위해 철망을 원형회전대에 넣고 철선 끝을 직선기에 넣는다. 길이에 맞게 리미트 스위치를 조절하고 버튼을 눌러 절단한다. 편성기에 배전판을 끼우고 편성기의 지름을 조절한 다음 직선철선을 삽입한다. 철선을 용접기에 연결하고 핸들레버를 조작하여 용접기의 나선과 직선철선이 맞닿게 한다. 메인버튼을 눌러 편성을 시작한다. 편성 종료 후 자동복귀 버튼을 눌러 밀대를 후진한다. 용접이 끝나면 핸들레버를 밀어 철망을 앞으로 빼내고 나선철선을 자른다. 스페이서를 부착하고 보관장소로 이동한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"흄관철근통제작원","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004470:1', '{"dJobCd":"K000004470","dJobCdSeq":"1","dJobNm":"주사침제조원","workSum":"주사침을 제조하기 위해 절단기, 연마기 등을 사용하여 절단·연마작업을 수행한다.","doWork":"작업지시서에 따라 제조할 주사침의 규격과 수량 등을 확인한다. 제조에 필요한 연마기, 절단기, 호닝기계, 초음파세척기 등의 공구 및 장비를 준비한다. 주사침용 파이프 절단기로 일정한 길이로 절단하고 절단치수가 허용오차 내에 있는지 확인한다. 절단된 주삿바늘을 일정한 연마 각도로 맞춰 바늘 끝을 연마한다. 전해연마기나 바렐(Barrel)연마기를 사용하여 2차로 연마한다. 호닝기계(Honing Machine)를 사용하여 주삿바늘의 외부를 가공한다. 초음파세척기를 사용하여 주삿바늘의 내외부의 이물질을 세척한다. 제조가 완료된 주삿바늘은 자동검사기를 이용하여 절단각도, 절단외경, 절단길이 등을 측정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"주사침생산원","connectJob":"주사침연마원","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"C271","dJobICdNm":"[C271]의료용 기기 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007041:1', '{"dJobCd":"K000007041","dJobCdSeq":"1","dJobNm":"주화압연원","workSum":"소전의 재료가 되는 비철금속 판재를 압연 제조하는 압연기를 조작한다.","doWork":"작업지시서나 작업표준명세의 작업내용을 숙지하고 공정카드에 기록된 슬래브의 규격, 로트 번호 등을 확인한다. 재료를 작업대로 운반하여 적치한다. 압연스크루의 작동상태, 롤의 표면상태 등을 점검하여 설비의 이상 유무를 확인·점검하고 주유한다. 압연소재의 두께를 측정하고 그에 따른 압연계획을 결정한 다음 롤 간격을 설정한다. 압연소재의 표면을 확인하여 먼지, 기름 등 이물질의 유무를 확인하고 롤 사이로 통과한다. 압연된 소재를 받아 상부롤 위로 넘긴다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"압연기조작원","connectJob":"압연작업원","certLic":"압연기능사, 압연기능장","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"C331","dJobICdNm":"[C331]귀금속 및 장신용품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003553:1', '{"dJobCd":"K000003553","dJobCdSeq":"1","dJobNm":"주화타발원","workSum":"소전을 만들기 위하여 원하는 모양으로 압출하는 기계를 조작한다.","doWork":"작업표준명세나 작업지시서의 내용을 확인하고 재료, 공정카드에 기록된 규격, 재질, 중량 등을 확인한다. 타발공구의 연마상태를 확인하고 펀치 및 작업대를 홀더에 고정한 후 타발위치를 조정한다. 가이드 내부에 판재를 장입하여 가이드롤 간격을 조정하고 타발기 퇴출슈트(Shute)의 이물 여부를 확인한다. 기계의 작동상태를 점검하고 재료를 투입한다. 수동으로 펀치를 상하 작동하여 타발시험을 하고 센터링과 소전의 가공상태를 확인한다. 이상이 없으면 기계를 가동해 소전을 타발한다. 자동 계수된 소전의 수량으로 무게를 산출한 뒤 공정카드에 수량 및 중량을 기입한다. 작업 완료된 제품은 다음 공정으로 수량 및 중량, 품질 등이 기록된 카드와 함께 보낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"타발기조작원","connectJob":"주화타발원","certLic":"압연기능사, 압연기능장","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"C331","dJobICdNm":"[C331]귀금속 및 장신용품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005275:1', '{"dJobCd":"K000005275","dJobCdSeq":"1","dJobNm":"질화처리원","workSum":"암모니아를 고온에서 분해했을 때 나타나는 질소를 금속물 표면에 침투시켜 내마모성을 증가시키고 표면을 단단하게 만드는 질화처리설비를 조작한다.","doWork":"작업표준 및 작업지시서에 따라 질화처리 작업을 위한 공정을 계획한다. 규정된 가열온도, 시간을 조정하고 가스를 일정량 투입하여 열처리를 위한 온도, 압력 등의 조건을 조성한다. 질화방지부분에는 주석도금을 한다. 준비작업이 끝난 가공물을 가열로의 유효가열대 안으로 밀어 넣는다. 지정된 온도로 일정 시간 가열하고 질화처리 분위기 등 가열로의 가동상태를 점검한다. 가열이 완료되면 지시된 냉각방법에 따라 냉각설비를 점검하고 가공품을 투입하여 냉각한다. 가열 및 냉각설비를 청소하며, 간단한 점검 및 보수를 실시한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"질화작업원","connectJob":"질화설비조작원","certLic":"열처리기능사","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003899:1', '{"dJobCd":"K000003899","dJobCdSeq":"1","dJobNm":"철선제조원","workSum":"치과에서 쓰이는 철선을 만들거나 인조장신구를 만드는 기계를 조작한다.","doWork":"작업지시서에 따라 제조할 철선의 직경 등 규격을 확인한다. 제작에 필요한 금, 은, 구리, 형상기억합금 등 철선의 수량을 확인하여 준비한다. 롤러다이, 마이크로미터 등 공구 및 장비를 준비한다. 작은 직경의 구멍이 뚫린 다이를 통해 철선을 넣고 반대쪽 끝을 급송기계장치에 연결하고 끌어당겨 구멍의 크기에 따라 지름을 감소시키는 신선(伸線)조작가공을 한다. 마이크로미터를 사용하여 크기가 명세서와 일치하는지 확인하기 위하여 철선의 두께를 측정한다. 점점 작은 직경의 다이를 설치하고 철선의 직경이 명세서와 일치할 때까지 조작을 되풀이한다. 명세서와 일치되는 철선이 완성되면 포장공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"신선기조작원","connectJob":"철선생산원","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"C271","dJobICdNm":"[C271]의료용 기기 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001932:1', '{"dJobCd":"K000001932","dJobCdSeq":"1","dJobNm":"침탄담금질원","workSum":"저탄소강 금속의 표면만을 단단하게 하기 위하여 금속 표면에 탄소를 확산 침투시켜 내마모성을 향상시키는 침탄설비와 냉각설비를 조작한다.","doWork":"원하는 금속의 표면강도를 얻기 위해 침탄시간·온도 등을 확인한다. 조작반의 전원스위치를 조작하여 강의 표면에 탄소(Carbon)를 침투시키는 침탄로(浸炭爐)를 일정 온도로 유지한다. 밸브를 조절하여 불활성 기체나 프로판가스 등 가스를 노 내에 주입한다. 침탄제의 종류에 따라 고체침탄, 염욕침탄, 가스침탄, 플라스마침탄, 진공침탄 작업을 한다. 금속물의 균열 상태를 육안으로 확인한다. 손잡이를 조정하여 침탄로 뚜껑을 열고 금속물을 운반통에 담아서 노 내에 넣는다. 노의 뚜껑을 닫고 밀폐한다. 침탄처리가 완료가 되면 노에서 운반통을 꺼내 냉각용 기름 탱크 속에 기중기를 이용해 침적한다. 금속물을 기름 탱크에서 꺼내 준비된 상자에 쏟거나 다음 공정으로 운반한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"침탄원","connectJob":"침탄설비조작원","certLic":"열처리기능사","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004644:1', '{"dJobCd":"K000004644","dJobCdSeq":"1","dJobNm":"칼라강판출측원","workSum":"도장이 완료된 칼라강판의 평탄도를 유지하고 재권취하여 출측하는 설비를 조작한다.","doWork":"도장이 완료된 코일이 누그러지거나 평탄하지 않은지를 확인한다. 평탄도를 조절하기 위하여 텐션레벨기의 계기판을 조정하여 형상을 바로잡기 위하여 조정한다. 샘플을 채취하여 벤딩시험·충격시험 등을 통하여 표준치와 비교하여 도장상태의 합격 여부를 판정한다. 도장된 코일을 제품화하기 위해 롤형태로 재권취 작업을 한다. 완료된 제품은 출하할 수 있도록 제품을 천장기중기를 이용하여 적하장으로 운반한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"강판설비조작원","connectJob":"칼라강판생산원","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001432:1', '{"dJobCd":"K000001432","dJobCdSeq":"1","dJobNm":"탄소나노튜브분쇄기조작원","workSum":"합성로에서 작업된 탄소나노튜브(CNT:Carbon Nanotube) 덩어리(Bundle)를 믹서에 넣어 분쇄한다.","doWork":"반응판(포트) 위에 탄소나노튜브 번들을 믹서용기에 넣은 뒤 믹서용기의 뚜껑을 닫는다. 믹서의 작동시간과 강도를 조절하여 탄소나노튜브 번들을 분산 및 혼합이 용이한 파우더 형태로 분쇄한다. 믹싱이 끝난 용기 내 파우더가 진정되면 작업 중 발생하는 분진을 흡입하기 위해 후드를 작동시키고 뚜껑을 열어 포장 용기에 파우더를 옮겨 담는다. 전자저울을 사용하여 포장의 무게를 조정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"탄소나노튜뷰믹싱원","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"C239","dJobICdNm":"[C239]기타 비금속 광물제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005242:1', '{"dJobCd":"K000005242","dJobCdSeq":"1","dJobNm":"평탄교정보조원","workSum":"금속코일에 평탄 처리하는 평탄교정원을 보조한다.","doWork":"평탄 처리할 금속코일을 두께와 재질을 확인하여 작업진행에 맞추어 준비한다. 코일을 교정작업할 수 있도록 언코일러에 감아주는 작업을 보조한다. 연기계의 출측부에서 평탄 처리되어 나오는 코일을 감아주는 리코일러 작업을 보조한다. 처리되어 나오는 코일을 관찰하여 이상 여부를 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"코일교정기조작보조원, 텐션레벨기조작보조원","connectJob":"코일교정작업보조원","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001595:1', '{"dJobCd":"K000001595","dJobCdSeq":"1","dJobNm":"평탄교정원","workSum":"금속코일의 평탄도를 교정하는 교정기(Leveller)를 조작한다.","doWork":"압연된 코일의 두께 및 재질을 확인하다. 유압 및 냉각수 펌프 등 관련 설비의 작동상태 및 기기상태의 이상 여부를 확인한다. 장력, 압하율, 연신율, 속도 등을 조정하기 위하여 기기의 조작반을 조작한다. 언코일러에 투입된 코일을 기계에 걸고 작동롤의 높이를 조정하여 코일을 교정한다. 교정되는 코일의 상태를 감시하며 교정된 코일표면의 이상 여부를 관찰하여 기록한다. 기계에 장치된 도유장치, 분할장치를 조작하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"코일교정기조작원, 텐션레벨기조작원","connectJob":"코일평탄교정원","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006375:1', '{"dJobCd":"K000006375","dJobCdSeq":"1","dJobNm":"풀림원","workSum":"기계 가공성 및 연성을 좋게 하기 위하여 경화된 금속을 가열한 후 냉각속도를 조절하는 열처리로를 조작한다.","doWork":"강의 종류 및 두께별로 작업명세에 제시된 가열온도 및 유지시간, 냉각속도 등을 확인한다. 노를 가열하여 노 내의 분위기를 조정하고 가공품을 풀림로에 장입한다. 풀림로의 가열온도, 시간, 분위기 등을 작업지시서에 의해 관리하고 풀림로의 가동상태를 점검한다. 가열이 완료되면 지시된 냉각방법에 따라 노의 온도를 하강시키면서 노 안에서 냉각처리를 하며 냉각속도를 확인한다. 지시된 온도까지 냉각이 끝나면 노의 전원을 끊고 가공품을 꺼낸다. 경도기로 완성제품의 품질을 검사한다. 가열 및 냉각설비를 청소하며 간단한 점검 및 보수를 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|고온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"소둔로조작원, 어닐링원","connectJob":"풀림설비조작원","certLic":"열처리기능사","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002855:1', '{"dJobCd":"K000002855","dJobCdSeq":"1","dJobNm":"핀셋제조원","workSum":"핀셋을 기록된 지시사항에 맞춰 제조한다.","doWork":"작업지시서에 따라 제작할 핀셋의 규격, 형태, 수량 등을 확인한다. 제작에 필요한 스테인리스 강판을 확인하여 준비한다. 프레스, 용접기, 도금기, 연마기 등의 도구 및 장비를 점검한다. 스테인리스 강판을 각 용도에 맞게 프레스를 이용하여 재단하고 연마한다. 재단하여 연마 가공한 스테인리스 강판을 용접하여 잇는다. 사용되는 목적에 따라 핀셋 앞의 선단을 구부리기도 하고 니켈 등의 도금을 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"핀셋가공원","connectJob":"핀셋작업원","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"C271","dJobICdNm":"[C271]의료용 기기 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004181:1', '{"dJobCd":"K000004181","dJobCdSeq":"1","dJobNm":"후판압연원","workSum":"슬래브(Slab)를 후판으로 가공하기 위해 압연기를 조작한다.","doWork":"압연개시 전 롤(Roll)의 좌우간격 게이지를 조정하고 각종 베어링 및 볼트의 이완상태, 기어의 마모 및 급유상태를 점검·손질하고 시운전을 한다. 가열로에서 가열된 슬래브가 이송되면, 압연기 전후면의 강괴전복장치를 롤테이블 중심에 맞춘다. 슬래브의 재질 및 크기에 따라 압하량 및 압연속도를 조정하고 매회 소정의 두께, 폭의 측정신호에 맞춰 수동으로 조종한다. 슬래브를 압연기 전후면으로 연속 역전시켜 명시된 크기로 압연한다. 기중기를 유도하여 롤 교체작업을 실시한다. 압연기 및 부속기기를 점검하고 정기적으로 수리작업을 지원한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"후판압연기조작원","connectJob":"후판압연작업원","certLic":"압연기능사, 압연기능장","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005902:1', '{"dJobCd":"K000005902","dJobCdSeq":"1","dJobNm":"보일러제작반장","workSum":"보일러의 제작과정을 관리, 감독하며 작업원들에게 작업을 지시하고 필요한 지침을 하달하며 기술지도 및 작업현장의 안전·위생 등에 관한 업무를 한다.","doWork":"작업주문서나 작업지시서에 따라 생산계획을 수립한다. 생산공정에 따라 제작설비, 부분품, 작업방법, 작업인원 등을 수립한다. 각 공정에 설비와 인원을 배치한다. 공정별로 작업지시를 한다. 각 공정을 순회하며 주요설비의 이상 유무를 점검·확인한다. 생산된 제품이 작업지시서나 시방서의 규격과 일치하는지를 검사·확인한다. 작업원에게 기술교육 및 안전교육을 실시한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","connectJob":"보일러생산반장","certLic":"에너지관리기능사, 에너지관리산업기사","dJobECd":"8224","dJobECdNm":"[8224]제관기조작원","dJobJCd":"8416","dJobJCdNm":"[8416]제관기 조작원","dJobICd":"C251","dJobICdNm":"[C251]구조용 금속제품, 탱크 및 증기발생기 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002816:1', '{"dJobCd":"K000002816","dJobCdSeq":"1","dJobNm":"연소기구조립반장","workSum":"산업용 또는 가정용 보일러와 연소기구 제조를 위해 재단, 성형, 용접, 조립을 하는 연소기구 제작원의 직무를 분장하고 조정한다.","doWork":"작업주문서에 따라 작업지시서를 만든다. 납기일에 따라 일일생산량계획을 수립한다. 작업에 필요한 각종 공구와 기계 등을 점검하고 확인한다. 작업공정 방법과 순서를 정하여, 작업원을 배치하고 작업원들에게 지시한다. 작업공정을 순회하고 공정별 기술적인 지도를 한다. 완성된 제품의 규격이 작업지시서와 일치하는지를 확인하고 검사한다. 작업장의 안전과 작업원의 위생 등을 관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","similarNm":"보일러조립반장","connectJob":"버너조립반장, 보일러조립반장","certLic":"판금제관기능사, 판금제관산업기사, 판금제관기능장","dJobECd":"8224","dJobECdNm":"[8224]제관기조작원","dJobJCd":"8416","dJobJCdNm":"[8416]제관기 조작원","dJobICd":"C251","dJobICdNm":"[C251]구조용 금속제품, 탱크 및 증기발생기 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003035:1', '{"dJobCd":"K000003035","dJobCdSeq":"1","dJobNm":"조관기조작원","workSum":"강관을 제조하기 위하여 성형, 용접, 냉각, 정형시키는 조관설비를 조작한다.","doWork":"작업지시서를 확인하고 관의 규격에 따라 롤을 선택·설치한다. 관의 규격에 맞추어 규정된 성형 각도 및 롤 간격을 조정한다. 기계를 운전하여 재료(Skelp)를 성형부의 롤에 투입하여 관을 성형한다. 성형되어 나오는 관의 스켈프(Skelp) 양 끝단 이음면이 가압롤 센터와 일치하도록 한다. 용접기를 조정하여 이음면을 용접한다. 용접 시 발생한 비드를 제거하기 위하여 비드를 조정한다. 일정 길이로 주어진 공냉과 조관유탱크로 이루어진 수냉장치로서 용접부위를 냉각한다. 정형롤을 조정하여 지시된 규격치수로 관을 정형한다. 조관된 강관의 외경을 측정하여 규정된 치수와 일치 여부를 확인한다. 제품에 따라 방청액을 분사하기도 한다. 비파괴검사기(와류탐상기, 초음파탐상기 등)로 용접부를 검사하기도 한다. 절단기를 설정하여 작업지시서상의 길이로 관을 자동 절단하며, 수동 조작으로 샘플을 절단하여 용접부위의 수직, 직각압력시험과 확관시험, 플랜지시험 등을 하여 관 용접부의 이상 유무를 판단하여 조치한다. 제품의 직진도 및 진원도를 향상시키기 위해 교정롤의 각도와 사이 간격을 수동으로 조작하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"조관설비조작원, 조관원","connectJob":"강관용접원, 관성형원, 롤밴더조작원, 밀운전원","certLic":"판금제관기능사, 판금제관산업기사, 판금제관기능장, 용접기능사, 용접산업기사, 용접기사, 용접기능장","dJobECd":"8224","dJobECdNm":"[8224]제관기조작원","dJobJCd":"8416","dJobJCdNm":"[8416]제관기 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006881:1', '{"dJobCd":"K000006881","dJobCdSeq":"1","dJobNm":"조관반장","workSum":"강관을 제조하기 위하여 코일(Coil) 등의 금속소재를 성형·용접·정형·절단·가공처리 하는 작업을 수행하고 작업원의 직무를 분장하고 조정하며 설비점검 및 유지관리 업무를 한다.","doWork":"작업계획을 검토하고 세부추진항목을 수립하여 작업원의 배치 및 작업내용을 지시한다. 코일 등의 조관 원료의 상태를 확인하여 이상 유무를 파악한다. 조관기, 절단기, 면취기 등의 조관설비조작을 감독하고 이상 시 조치한다. 조관기의 롤 교환을 지시·감독한다. 조관된 제품의 표면 및 치수를 검사하여 결함부분을 조정한다. 조관설비를 점검·관리하고 이상 시 정비를 의뢰하여 조치를 확인한다. 자재를 점검하고 작업일지 및 보고서를 작성한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","similarNm":"강관제조반장, 파이프제조반장","connectJob":"스파이럴강관반장","certLic":"판금제관기능장, 용접기능장","dJobECd":"8224","dJobECdNm":"[8224]제관기조작원","dJobJCd":"8416","dJobJCdNm":"[8416]제관기 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002545:1', '{"dJobCd":"K000002545","dJobCdSeq":"1","dJobNm":"고압용기제조반장","workSum":"보통의 압력용기보다 높은 고압용 가스용기를 제조하기 위하여 원판을 절단, 봉합, 열처리, 도장하는 작업원의 직무를 분장하고 조정한다.","doWork":"작업주문서나 작업지시서에 따라 생산계획을 수립한다. 생산량에 따른 일일생산계획을 수립한다. 생산공정에 따라 제작설비, 부분품, 작업방법, 작업인원 등을 수립한다. 각 공정에 맞게 작업기계 등의 설비와 인원을 배치한다. 공정별로 작업지시를 한다. 각 공정을 순회하며 주요설비의 이상 유무를 점검, 확인한다. 생산된 제품이 작업지시서나 시방서의 규격과 일치하는지를 검사, 확인한다. 작업원에게 기술교육 및 안전교육을 실시한다. 작업완료 후 다음 작업단계인 고압용기검사부에 통보한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"수동조작","connectJob":"압력용기제조반장","certLic":"판금제관기능사, 판금제관산업기사, 판금제관기능장","dJobECd":"8222","dJobECdNm":"[8222]판금기조작원","dJobJCd":"8417","dJobJCdNm":"[8417]판금기 조작원","dJobICd":"C251","dJobICdNm":"[C251]구조용 금속제품, 탱크 및 증기발생기 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002743:1', '{"dJobCd":"K000002743","dJobCdSeq":"1","dJobNm":"보온함석원","workSum":"선박 및 해양구조물의 거주부 및 내부구조의 습기방지, 방화벽, 소음방지, 유체의 통로제작 등을 위하여 판금작업을 한다.","doWork":"작업도면을 보고 작업할 구획을 검토한다. 구획에 따라 보온자재, 판금자재 및 공구를 준비한다. 보온할 선각구조물의 크기에 따라 칼, 가위를 사용하여 보온재를 절단한다. 절단된 보온재를 설치하고 고정한다. 구획통로의 규격을 확인하고 함석을 절단한다. 절단한 함석판을 수동드릴 및 리벳기를 사용하여 통로에 설치한다. 함석작업 후 표면검사를 하여 함석에 틈이 발생되었는지 확인하고 수정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"보온원, 함석원, 덕트원","connectJob":"철판가공원","certLic":"판금제관기능사, 판금제관산업기사, 판금제관기능장","dJobECd":"8222","dJobECdNm":"[8222]판금기조작원","dJobJCd":"8417","dJobJCdNm":"[8417]판금기 조작원","dJobICd":"C311","dJobICdNm":"[C311]선박 및 보트 건조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006703:1', '{"dJobCd":"K000006703","dJobCdSeq":"1","dJobNm":"보일러관체제작원","workSum":"절단기와 용접기 등을 이용해 보일러를 제작한다.","doWork":"작업지시서에 따른 작업내용을 확인한다. 작업지시서상의 재료가 일치하는지 확인한다. 작업지시서에 따라 작업공정방법을 선택한다. 제작에 필요한 공구와 각종 자재를 준비한 후 작업공정에 맞게 배열한다. 축관기를 이용하여 파이프 배관재를 만든다. 용접기를 사용하여 파이프관재를 도면대로 용접한다. 압연강판을 프레스전단기를 이용하여 규격대로 절단한다. 벤딩기를 이용하여 도면대로 성형한다. 홀가공한 관판에 파이프배관재를 조립하여 용접한다. 가스라인, 증기출구관, 직수필터, 펌프퇴수콕크, 세퍼레이터, 가스경보기 등의 부분품을 장착한다. 관체커버를 부착하고 보온재를 관체둘레에 씌운다. 베드(Bed) 위에 관체를 올려놓고 볼트와 너트를 이용하여 고정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"보일러생산원","certLic":"판금제관기능사, 판금제관산업기사, 판금제관기능장","dJobECd":"8222","dJobECdNm":"[8222]판금기조작원","dJobJCd":"8417","dJobJCdNm":"[8417]판금기 조작원","dJobICd":"C251","dJobICdNm":"[C251]구조용 금속제품, 탱크 및 증기발생기 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001636:1', '{"dJobCd":"K000001636","dJobCdSeq":"1","dJobNm":"선상가열원","workSum":"선박의 건조 또는 수리를 위하여 강재의 표면을 가열하고 망치 등으로 두들겨 구부리는 등의 작업을 한다.","doWork":"작업지시서를 읽고 소요되는 자재 및 공구를 준비한다. 수리할 선박에 승선하여 가스토치를 사용하여 강재의 표면을 가열한다. 형태에 맞추어 구부리고 정형하기 위한 표시를 한다. 굴곡 및 비틀림의 정도에 맞춰 형태를 확인한다. 굴곡을 만들기 위하여 정반상에 핀대 및 공구를 사용하여 형태를 만든다. 굴곡 및 비틀림 부위에 단목을 괴고 부재를 고정한다. 가스토치의 열을 조절하고 가열한다. 망치 또는 담금 해머를 적절히 사용하여 성형한다. 작업 중간 또는 종료 후 도면에 맞게 작업이 되었는지를 확인하기 위하여 구부러진 정도 또는 정형의 정도를 확인하고 필요한 수정작업을 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|손사용|","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"곡직원","certLic":"판금제관기능사, 판금제관산업기사, 판금제관기능장","dJobECd":"8222","dJobECdNm":"[8222]판금기조작원","dJobJCd":"8417","dJobJCdNm":"[8417]판금기 조작원","dJobICd":"C311","dJobICdNm":"[C311]선박 및 보트 건조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003435:1', '{"dJobCd":"K000003435","dJobCdSeq":"1","dJobNm":"인장성형기조작원","workSum":"항공기 기체에 사용되는 각종 부품을 제작하기 위하여 인장성형기를 조작한다.","doWork":"작업표준서나 설계도면을 보고 작업에 필요한 공구와 자재를 준비한다. 인장성형기(고체의 가소성을 이용하여 어떤 모양을 만드는 가공 기계)의 성형 틀에 부품을 넣고 집게를 물린다. 인장성형기를 가동하고 제어판에 서정값(인장성형에 있어서 구부릴 방향과 각도의 수치)을 입력한 후 작동한다. 인장성형이 완료되면 부품을 장비에서 탈착한다. 완료된 부품이 도면과 일치하는지 확인한다. 부품의 이력을 확인할 수 있도록 임시 부품표를 부착하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"인장성형원","certLic":"판금제관기능사, 판금제관산업기사, 판금제관기능장","dJobECd":"8222","dJobECdNm":"[8222]판금기조작원","dJobJCd":"8417","dJobJCdNm":"[8417]판금기 조작원","dJobICd":"C313","dJobICdNm":"[C313]항공기, 우주선 및 부품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005713:1', '{"dJobCd":"K000005713","dJobCdSeq":"1","dJobNm":"가구도장원","workSum":"붓이나 스프레이로 목재가구에 페인트칠을 한다.","doWork":"작업복, 장갑, 마스크 등을 착용한 후 환풍기를 가동한다. 도료를 제품에 맞게 배합하고 제품에 묻어있는 먼지 및 오물을 제거한다. 도장 면을 세밀히 관찰하여 벗겨진 부분을 보수할 경우에는 붓이나 소형페인트 분사기를 사용하여 착색 보수한다. 지정된 색상을 견본패널과 대조하여 페인트분사기로 가로세로 수 회 도장하고 마감상태에 따라 투명도장한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"시각|","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"목재가구상도원, 목재가구중도원, 목재가구하도원, 목재가구칠원, 가구왁스칠원, 가구옻칠원, 나전칠기도장원, 가구칠부, 가구캐슈칠원, 합판도색가공원, 목재자동스프레이조작원, 문짝칠원","certLic":"가구제작기능사","dJobECd":"8251","dJobECdNm":"[8251]도장원(도장기조작원)","dJobJCd":"8421","dJobJCdNm":"[8421]도장기 조작원","dJobICd":"C320","dJobICdNm":"[C320]가구 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002760:1', '{"dJobCd":"K000002760","dJobCdSeq":"1","dJobNm":"거울페인트도장공","workSum":"거울의 은도금된 부분을 보호하기 위하여 도금면에 페인트를 도장하는 기계를 운전·조작한다.","doWork":"작업지시서에 따라 도장할 거울의 종류 및 형태, 규격을 확인한다. 작업표준서에 따라 페인트와 희석제를 배합비율로 정량 혼합하여 페인트 혼합탱크에 넣는다. 도장기의 윤활유 및 오일상태를 점검하여 작동 여부를 확인한다. 작업표준서에 따라 디지털 입력기에 분사압력수치와 분사속도, 분사량 등을 입력한다. 샘플에 시험도장을 하여 도막두께 및 도장상태를 확인한다. 은도금된 거울을 도장기의 작업대에 올려놓는다. 도장기를 가동하여 혼합된 페인트를 분무기의 상단부로 이동한다. 시동 버튼을 눌러 은도금된 거울의 뒷면에 페인트를 코팅한다. 육안으로 분사노즐의 상태를 확인하며 도장 과정을 주시한다. 완성된 도장형태를 점검한다. 사용한 기구는 깨끗이 청소한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"거울페인트도장원","certLic":"표면처리기능사","dJobECd":"8251","dJobECdNm":"[8251]도장원(도장기조작원)","dJobJCd":"8421","dJobJCdNm":"[8421]도장기 조작원","dJobICd":"C231","dJobICdNm":"[C231]유리 및 유리제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005505:1', '{"dJobCd":"K000005505","dJobCdSeq":"1","dJobNm":"금속가구도색원","workSum":"캐비닛, 책상, 로커 등의 금속가구 부품들을 도색한다.","doWork":"도색할 색상을 제품 사양서에 맞게 선정하고 도료 저장탱크에 도료를 채운다. 컨베이어 라인(Conveyer Line)에 제품을 걸고 양극을 발생하는 양극판을 부착한다. 분체도장기를 가동하여 도료를 제품에 분사한다. 도료가 제품에 부착되면 이를 가열 용융시키고 건조한다. 건조된 금속부품의 도색 정도를 육안으로 확인한다. 이상 유무를 파악하고 이상이 있을 시, 재 도색 후 건조한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"금속가구도장원","certLic":"금속도장기능사, 가구제작기능사","dJobECd":"8251","dJobECdNm":"[8251]도장원(도장기조작원)","dJobJCd":"8421","dJobJCdNm":"[8421]도장기 조작원","dJobICd":"C320","dJobICdNm":"[C320]가구 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003222:1', '{"dJobCd":"K000003222","dJobCdSeq":"1","dJobNm":"낚싯대도장공","workSum":"낚싯대 표면의 변색을 방지하기 위해 유색도료로 도막을 입히는 분무기를 조작한다.","doWork":"작업지시서의 배합표에 따라 배합통에 유색도료와 경화제를 넣고 주교반본으로 혼합한다. 배합된 도료를 분무탱크에 넣는다. 도장할 표면을 연마하고 약품이나 물로 세척한다. 걸대에 도장할 소재를 걸고 이동컨베이어를 가동한다. 분무기를 가동하여 하도도장을 한 후 중도도장을 한다. 건조된 도막을 연마, 세척 후 상도도장을 한다. 인쇄, 마크 등을 한 후 핸들 등을 도색하여 마무리한다. 도장한 소재를 건조시키기 위해 건조기에 넣는다. 일정 시간이 경과한 후 건조기에서 낚싯대를 꺼내어 일정 수량씩 묶는다. 수작업이 필요한 공정은 붓에 도료를 묻혀서 권사부위에 골고루 칠한다. 도료를 칠한 소재를 자연건조 시키거나 건조기 물림대에 끼워 건조한다. 도장된 상태를 검사하고 소재의 중량·명칭 등을 기록표에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"낚싯대도포원, 낚싯대도장원","dJobECd":"8251","dJobECdNm":"[8251]도장원(도장기조작원)","dJobJCd":"8421","dJobJCdNm":"[8421]도장기 조작원","dJobICd":"C333","dJobICdNm":"[C333]운동 및 경기용구 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004749:1', '{"dJobCd":"K000004749","dJobCdSeq":"1","dJobNm":"내장재도장공","workSum":"무늬기계를 통과한 내장재에 도료를 도포하기 위하여 도장기계를 조작·관리한다.","doWork":"작업지시서에 따라 도료 및 연화제를 준비하고 도료혼합기를 가동한다. 압력펌프의 작동스위치를 조작하여 도장기계의 호퍼에 정량의 도료를 공급한다. 도장할 내장재 표면의 이물질을 제거하여 도장면을 깨끗이 한다. 도장기계를 가동시키고 내장재를 투입하여 도장을 한다. 도장물을 건조실로 이송하고 도장상태를 확인하고 결함이 있으면 결함부분 수정용 도료로 수정한다. 도장작업이 완료된 내장재를 다음 공정으로 운반하기 위하여 적재판에 적재한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"내장재도장원","dJobECd":"8251","dJobECdNm":"[8251]도장원(도장기조작원)","dJobJCd":"8421","dJobJCdNm":"[8421]도장기 조작원","dJobICd":"C239","dJobICdNm":"[C239]기타 비금속 광물제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003982:1', '{"dJobCd":"K000003982","dJobCdSeq":"1","dJobNm":"냉동장비도장공","workSum":"냉동장비의 도장을 위해 도료분말을 관리하며 분체도장기를 작동한다.","doWork":"작업지시서에 따라 도장할 제품을 확인한다. 지게차, 스키드로더 장비를 이용하여 분체도장 전용부스로 이동한다. 분체도료 공급장치, 컨베이어, 회수장치 등의 작동 여부를 점검한다. 호퍼, 스프레이건의 상태를 점검한다. 작업지시에 따라 도장도료를 준비하여 도료공급장치에 넣는다. 컨베이어를 작동시켜 분체도장기 안으로 서서히 가공물을 입고한다. 도포상태를 확인하여 가공물의 도장이 균일하도록 한다. 도장이 끝난 제품을 건조로로 이동한다. 일정한 시간 동안 냉각시키며 도장의 결함 유무를 확인한다. 건조시킨 후 도막상태를 체크한다. 불량부분은 재도장을 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"냉동장비도장원","certLic":"금속도장기능사","dJobECd":"8251","dJobECdNm":"[8251]도장원(도장기조작원)","dJobJCd":"8421","dJobJCdNm":"[8421]도장기 조작원","dJobICd":"C291","dJobICdNm":"[C291]일반 목적용 기계 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004586:1', '{"dJobCd":"K000004586","dJobCdSeq":"1","dJobNm":"분무도장공","workSum":"분무기를 사용하여 페인트, 에나멜, 겔코팅제, 래커 등을 제품에 칠한다.","doWork":"물과 세척제로 도장할 제품에 묻은 기름과 먼지 등을 닦아낸다. 도장하지 않을 부분을 가리기 위해 마스킹을 한다. 구멍이 나거나 찌그러진 부분에 퍼티(Putty)를 발라 매끄럽게 연마한다. 자동혼합기를 사용하거나 수동으로 도장용액을 혼합·조색한다. 분무기 통에 혼합액을 넣고 공기호스를 연결한다. 분무기의 밸브를 돌려 분무기의 간격과 압력을 조절한다. 방아쇠를 당겨 작업부분에 분무한다. 분무기로 칠할 수 없는 곳은 붓으로 칠한다. 희석제로 분무장비와 붓을 세척한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"스프레이도장공","certLic":"금속도장기능사","dJobECd":"8251","dJobECdNm":"[8251]도장원(도장기조작원)","dJobJCd":"8421","dJobJCdNm":"[8421]도장기 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006355:1', '{"dJobCd":"K000006355","dJobCdSeq":"1","dJobNm":"분체도장공","workSum":"금속·플라스틱 등을 분체도장기 및 그 부속설비를 조작하여 탈지·수세·피막·건조 과정을 거쳐 도장(Painting)한다.","doWork":"작업지시서 및 표준에 따라 가공소재를 준비한다. 도장기의 작동 유무 및 상태를 확인하여 필요시 정비한다. 가공소재에 따라 도장높이, 분체시간, 용착시간, 온도게이지를 조정한다. 소재를 담은 철망그릇을 탈지조에 넣고 일정 시간 탈지한다. 탈지가 끝난 소재를 일정 시간 탱크, 저수조에 넣은 후 수세한다. 건조로에서 일정 시간 건조 후 고리에 정돈하고 분체작업대에 정렬한다. 가공소재를 분체도장기 내의 고정된 황동봉에 안착시키며 도장기 뚜껑을 밀폐시키고 가동스위치를 넣는다. 분체가 도포된 제품을 수레에다 옮겨 용착로에 넣는다. 점화스위치를 넣어 용착한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"분체도장원","certLic":"금속도장기능사","dJobECd":"8251","dJobECdNm":"[8251]도장원(도장기조작원)","dJobJCd":"8421","dJobJCdNm":"[8421]도장기 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005087:1', '{"dJobCd":"K000005087","dJobCdSeq":"1","dJobNm":"송풍기도장공","workSum":"완성된 송풍기를 도장하기 위해 도장사양서와 작업지시서를 확인하고 적절한 도료를 선택하여 점도를 조절한 후 송풍기를 도장한다.","doWork":"사용설비 및 공구류에 대해 상태를 점검하고 작업 복장을 점검한다. 제작도면과 작업지시서를 검토하여 사용재료의 유무를 확인하고 부족한 재료를 보충한다. 도장물의 이물질이나 기름을 제거한 후 적절한 도료에 첨가제를 사용하여 점도를 조정한다. 제품에 따라 도막두께를 결정하며 스프레이와 도장물의 거리를 적절하게 유지한다. 하도도장을 하기 위해 케이싱을 작업대에 올리거나 호이스트로 떠서 밑면을 도장하고 처리한다. 하도도장이 완료되고 완전 건조된 후 내부, 외부의 순으로 상도도장을 실시한다. 도장 후 일정 건조시간을 유지하고 도장의 상태를 파악한다. 완전건조가 된 송풍기의 검사를 위해 검사원에게 보낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|다습|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"송풍기도장원","certLic":"금속도장기능사","dJobECd":"8251","dJobECdNm":"[8251]도장원(도장기조작원)","dJobJCd":"8421","dJobJCdNm":"[8421]도장기 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002918:1', '{"dJobCd":"K000002918","dJobCdSeq":"1","dJobNm":"야광제도포원","workSum":"시계의 문자판을 어두운 곳에서 판독할 수 있도록 시계의 바늘과 문자에 야광제를 도포한다.","doWork":"작업지시서에 따라 도포할 시계의 규격과 수량을 파악하여 확인한다. 작업표준에 의하여 적합한 야광제를 만들기 위하여 야광분말과 결합제를 일정 비율로 배합하여 준비한다. 집진실의 집진시설을 가동시키고 여러 개의 형틀로 구성되어 동시에 여러 개의 문자판을 도포할 수 있는 도장지그에 끼운다. 패드를 사용하여 야광제를 찍어 입히거나 가는 솔을 이용하여 야광제를 도포한다. 도포작업을 마친 후 도장이 완료된 문자판을 도장지그에서 꺼내어 일정한 시간을 건조한 후 도장 상태를 검사한다. 도장지그를 세척액으로 세척하여 다음 도장공정을 준비한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"금속도장기능사","dJobECd":"8251","dJobECdNm":"[8251]도장원(도장기조작원)","dJobJCd":"8421","dJobJCdNm":"[8421]도장기 조작원","dJobICd":"C274","dJobICdNm":"[C274]시계 및 시계부품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006720:1', '{"dJobCd":"K000006720","dJobCdSeq":"1","dJobNm":"유브이코팅도료도포기조작원","workSum":"제품의 표면에 자외선경화형도료(UV Coating)를 도포하는 기계를 조작·관리한다.","doWork":"작업지시서를 보고 코팅 대상물인 렌즈 등의 제품에 따라 분사압력, 도료의 도포두께 등을 확인한다. 자외선 경화형 불포화 폴리에스테르수지 등의 원료량을 확인하고 공급펌프의 작동 유무를 확인한다. 도료가 도포되는 제품의 표면을 고르게 연마한다. 도포기 내부를 진공상태 혹은 질소로 충전한다. 도포기 노즐의 각도 등을 조절하고 환풍기를 작동한다. 제품에 도료가 고르게 도포되는지 확인하고 자외선 파장을 대상물에 조사하여 건조시킨다. 생산제품의 종류 및 외관상태를 검사하고 작업일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"자외선경화형도료도포원","dJobECd":"8251","dJobECdNm":"[8251]도장원(도장기조작원)","dJobJCd":"8421","dJobJCdNm":"[8421]도장기 조작원","dJobICd":"C273","dJobICdNm":"[C273]사진장비 및 광학기기 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004837:1', '{"dJobCd":"K000004837","dJobCdSeq":"1","dJobNm":"자동도장기조작원","workSum":"장비 및 대형공작물의 전체 도장을 위해 컨트롤 패널을 통해 자동도장기를 작동하거나 유지·보수한다.","doWork":"작업지시서에 따라 도장할 제품을 확인한다. 제품의 종류·형태 등에 따라 도장 방법 및 절차를 결정한다. 자동도장기의 도료, 유압, 윤활상태 등을 점검한다. 탈지제를 사용하여 탈지작업을 한다. 자동도장기의 제어패널 압력계를 보면서 점도, 토출량, 분사량, 공기량을 설정한다. 장비를 작동시키고 컨베이어장치를 통하여 자동도장기 내부로 도장할 장비를 이동한다. 기계를 작동하여 도장작업을 실시한다. 도장공정이 끝난 장비의 도장상태를 확인한 후 점도상태, 토출량, 분사량, 공기량, 온도, 속도, 도막두께, 경도, 외관색상에 대한 검사를 실시한다. 포장을 위해 정해진 위치로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"금속도장기능사","dJobECd":"8251","dJobECdNm":"[8251]도장원(도장기조작원)","dJobJCd":"8421","dJobJCdNm":"[8421]도장기 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004427:1', '{"dJobCd":"K000004427","dJobCdSeq":"1","dJobNm":"자동차도장공","workSum":"완성된 차체를 세척하고 차체 각 부분의 도장작업을 수행한다.","doWork":"작업표준을 보고 필요한 공구 및 도장원료를 준비한다. 마스크 및 귀마개 등 안전장구를 착용한다. 고압의 물호스를 이용하여 차체의 이물질을 제거한다. 세척하는 탈지공정, 차체의 방청을 주목적으로 하는 전처리 공정을 수행한다. 외판, 차체 내부를 균일하게 도장한다. 차체의 부식을 방지하는 전착(電着)공정, 보디와 패널이 겹치는 부분 등에 실러를 도포하는 실러공정, 차체 바닥이나 도어 내부에 언더코팅을 하여 소음과 진동을 감소시키는 언더코팅공정을 수행한다. 상도의 질을 높이기 위한 중간칠 작업인 중도(中途)공정, 차체 표면의 미관과 색채감의 외관품질을 결정하는 상도(上塗)공정을 수행한다. 조립공정에서 긁힘 등의 상처가 생겼을 경우 이를 부분적으로 마무리하는 마무리 도장공정을 수행한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"자동차도장원","connectJob":"언더코팅원, 데드너작업원, 도장수정원, 자동차정비도장원, 자동차상도원, 차체도장원, 자동차하체도장원, 자동차보수도장원","certLic":"자동차보수도장기능사, 금속도장기능사","dJobECd":"8251","dJobECdNm":"[8251]도장원(도장기조작원)","dJobJCd":"8421","dJobJCdNm":"[8421]도장기 조작원","dJobICd":"C301","dJobICdNm":"[C301]자동차용 엔진 및 자동차 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002362:1', '{"dJobCd":"K000002362","dJobCdSeq":"1","dJobNm":"제품도장공(일반)","workSum":"금속부품 및 완제품, 장비의 부식 방지, 미관을 위해 지정된 도료로 도장한다.","doWork":"작업지시서에 따라 일일작업량을 확인하고 도료를 준비한다. 준비된 도료를 저울 등을 사용하여 배합비율에 따라 혼합한다. 도장물을 쇼트블라스트나 브러시 및 기타의 방법 등으로 녹, 수분 및 기타 오염물질을 깨끗하게 제거하고 도장할 표면의 상태를 점검한다. 스프레이건으로 인한 날림, 먼지 혼입 등이 없고 불필요한 도장을 피하기 위해 도장물 주위를 깨끗하게 치운다. 도장면의 흠이 있을 경우 흠이 있는 부분을 메우고 연마지로 갈아낸다. 스프레이건을 작동시켜 뿌려지는 상태를 점검한다. 도장을 실시하기 전 도장 전 표면의 전처리상태를 확인하고 해당 도료의 규정된 분량으로 경화제를 섞어 준비한다. 분무기를 사용하여 도장한다. 도장된 제품을 건조기에 넣어 건조시킨 후 이동한다. 해당 도면을 참고로 하여 도장부위의 변형 및 흠집, 흐름자국 등을 점검한다. 작업지시서에 따라 도료의 종류, 도장횟수 및 도막두께, 건조시간 및 온도, 색상 등을 관리한다. 완성된 부품 또는 장비의 이동을 위해 적재 위치에 대기한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"제품도장원","connectJob":"기계도장원, 철구조물도장원, 선박도장원, 금속가구도장공, 자동차도장공, 철도차량도장공, 로봇도장공","certLic":"금속도장기능사, 자동차보수도장기능사, 광고도장기능사","dJobECd":"8251","dJobECdNm":"[8251]도장원(도장기조작원)","dJobJCd":"8421","dJobJCdNm":"[8421]도장기 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005578:1', '{"dJobCd":"K000005578","dJobCdSeq":"1","dJobNm":"철도차량도장공","workSum":"철도차량의 외관을 꾸미기 위하여 초벌칠이 끝난 차량에 퍼티(Putty), 연마 및 최종 도장을 한다.","doWork":"작업도면 및 작업시방서를 확인하여 도장 부위, 도장두께, 도장컬러 등을 확인하고 도료량을 산출한다. 붓, 롤러, 스프레이건, 공기압송식에 맞는 도장기구 등을 선택하여 준비한다. 규격의 도료를 작업표준에 따라 정량으로 조색 배합하고 중량비에 따라 희석한다. 작업 전 도장작업 주위 및 도장면의 인접부분을 보양 작업한다. 기름 등의 불순물을 제거하기 위하여 표면세척을 한다. 세척 후 용접부위를 그라인더 등으로 평탄화 작업을 한다. 그리트블라스트머신 등 기계적인 방법으로 산화막을 제거한 후 도료의 접착력을 증가시키기 위하여 알루미늄 차체의 표면에 적합한 입자크기의 모래를 분사하는 샌드블라스팅(Sand Blasting)작업을 한다. 샌드블라스팅 후에 퍼티작업을 한다. 에폭시 프라이머 코팅과 폴리우레탄 그라운드코팅을 차례로 실시한다. 폴리우레탄 마감 코팅을 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"철도차량도장원","certLic":"금속도장기능사","dJobECd":"8251","dJobECdNm":"[8251]도장원(도장기조작원)","dJobJCd":"8421","dJobJCdNm":"[8421]도장기 조작원","dJobICd":"C312","dJobICdNm":"[C312]철도장비 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002895:1', '{"dJobCd":"K000002895","dJobCdSeq":"1","dJobNm":"칼라강판도장기조작원","workSum":"칼라강판을 제조하기 위하여 코일이나 박판에 각종 도료로 도장하는 설비 및 부대설비를 조작한다.","doWork":"작업지시서나 생산계획서의 작업내용을 파악하고 작업방법 및 절차 등을 선정한다. 작업표준에 의하여 하도도장 및 상도도장을 위한 각종 도료를 배합하고 탱크에 저장한다. 도장기 및 부대설비의 이상 유무를 확인한다. 소재의 도금 및 세척상태 등 표면상태를 검사한다. 도장설비 및 부대설비를 가동하여 코일이나 박판에 도막의 밀착성과 내식성을 확보하기 위해 1차 하도도장(Primer Coating)을 하고 열풍건조기를 통해 건조한다. 요구 색상을 위한 도료를 상도도장하고 열풍건조기를 통하여 건조한다. 상도도장이 작업표준에서 요구하는 색상이나 질감으로 도장되었는지 확인하기 위하여 표면상태 등을 검사한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"코어터원","connectJob":"철강류코팅도금원","dJobECd":"8251","dJobECdNm":"[8251]도장원(도장기조작원)","dJobJCd":"8421","dJobJCdNm":"[8421]도장기 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007111:1', '{"dJobCd":"K000007111","dJobCdSeq":"1","dJobNm":"칼라강판제조반장","workSum":"칼라강판을 제조하기 위하여 소재에 도금재 및 도장재를 도장·도포하는 관련 설비를 조작하는 작업원의 활동을 감독·지휘한다.","doWork":"작업계획에 따라 세부실행계획을 수립하고 작업 절차 및 방법을 작업원에게 지시하며 작업이행 여부를 확인한다. 코일, 도장재, 도금재 등 원료의 수량 및 표면상태를 점검한다. 설비의 이상 유무를 점검하고 이상 시 보수를 지시한다. 작업원에 대한 직무교육 및 안전위생교육을 통하여 직무능력을 향상시키고 재해를 예방한다. 작업완료 시 제품의 표면상태 등을 점검한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","dJobECd":"8251","dJobECdNm":"[8251]도장원(도장기조작원)","dJobJCd":"8421","dJobJCdNm":"[8421]도장기 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002690:1', '{"dJobCd":"K000002690","dJobCdSeq":"1","dJobNm":"턴건조작원","workSum":"턴디시 내부에 축조된 내화물의 표면을 보호하기 위해 위한 내화재를 도장하는 분사기계를 조작한다.","doWork":"작업지시서의 지시내용을 확인하고 내화재료 탱크를 설정하여 탱크가압 스위치를 작동한다. 기중기를 이용하여 내화재를 도장할 턴디시를 작업대 위에 올려놓고 표준명세에 따라 조작반에 작업내용을 입력한다. 수동으로 분사장치를 조작하여 시험분사하고 내화재의 도장상태 등을 관찰하여 이상이 없으면 자동으로 전환한다. 물펌프 및 공기펌프를 작동하고 물의 분사상태를 확인한다. 턴디시가 분사하는 기계의 움직이는 방향으로 자동으로 움직이는 장치를 작동한다. 작업이 완료되면 초기 위치로 이동되도록 조작한다. 기중기를 이용하여 작업대에서 턴디시를 제거한다. 각종 장비 및 부품을 점검하고 작업내용을 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"턴디시내화재도장원","connectJob":"턴디시영구유입시공기조작원","dJobECd":"8251","dJobECdNm":"[8251]도장원(도장기조작원)","dJobJCd":"8421","dJobJCdNm":"[8421]도장기 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006900:1', '{"dJobCd":"K000006900","dJobCdSeq":"1","dJobNm":"펌프도장공","workSum":"작업표준에 따라 펌프의 외관에 적절한 도료를 혼합하여 도색 및 건조작업을 수행한다.","doWork":"작업도면 및 작업시방서를 확인하여 도장 부위, 도장두께, 도장컬러 등을 확인하고 도료량 산출작업에 필요한 장비와 안전도구를 준비한다. 작업지시서에 따라 도장할 제품을 확인한다. 표면의 물 등 이물질을 제거한다. 표면 에어블로잉(Air Blowing) 작업을 한다. 고정대에 제품을 고정하고 코너부위 등을 경사붓으로 터치업 도장을 한다. 스프레이 작업 전 주제, 경화제를 교반기로 믹싱한다. 페인트 흘러내림에 주의하면서 스프레이 도장을 한다. 건조시킨 후 도막상태를 점검한다. 불량부분은 재도장을 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"펌프도장원","certLic":"금속도장기능사","dJobECd":"8251","dJobECdNm":"[8251]도장원(도장기조작원)","dJobJCd":"8421","dJobJCdNm":"[8421]도장기 조작원","dJobICd":"C291","dJobICdNm":"[C291]일반 목적용 기계 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006528:1', '{"dJobCd":"K000006528","dJobCdSeq":"1","dJobNm":"프라이밍원","workSum":"칼라강판을 제조하기 위하여 프라이머(Primmer:본도장 전에 도장재의 접착이 용이하게 하기 위한 밑도장재)를 도포하는 장치 및 관련 설비를 조작한다.","doWork":"작업지시서에 따라 작업내용을 확인하고 작업방법 및 절차를 선택한다. 프라이머 도장기계, 건조기, 롤, 분무장치 등을 점검한다. 작업표준에 맞게 밑도장재를 배합하고 도장탱크에 투입한다. 스위치를 눌러 구동장치를 회전시키고 분무장치에서 나온 밑도장재가 롤에 골고루 도장되는지 관찰한다. 코일이나 박판을 투입하여 프라이머를 도장하고 물로 냉각한다. 프라이머가 도포된 코일이나 박판을 건조기에 투입하고 건조시킨다. 코일이나 박판의 표면상태를 검사한다. 건조된 코일이나 박판을 본도장 공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|고온|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8251","dJobECdNm":"[8251]도장원(도장기조작원)","dJobJCd":"8421","dJobJCdNm":"[8421]도장기 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005660:1', '{"dJobCd":"K000005660","dJobCdSeq":"1","dJobNm":"항공기도장공","workSum":"항공기의 표면을 세척하고 도장설비를 이용해 도장작업을 수행한다.","doWork":"항공기를 도장실로 이동하고 안전 조치를 취한다. 작업표준서나 도면을 보고 작업에 필요한 공구와 자재, 도료를 준비한다. 산화물이나 이물질이 남아 있지 않도록 사포(沙布)로 도장 면을 깨끗이 갈아낸다. 솔벤트(Solvent)와 물을 일정하게 섞은 세척제를 사포질한 면에 묻힌 후 깨끗이 닦아낸다. 알루미늄 재질일 경우 알칼리 비누로 깨끗이 씻어 말린 후 알로다인(Alodine) 처리를 한다. 도장설비를 가동하여 온도와 풍향, 풍속이 일정하도록 유지한다. 캐노피(Canopy:항공기의 조종석 위에 있는 투명한 덮개), 창문, 전구 등에 페인트가 묻지 않도록 마스킹(Masking) 작업을 한다. 페인트를 칠하기 전에 프라이머(Primer:내식성과 부식성을 증가시키기 위하여 맨 처음 밑바탕에 칠하는 도료)로 코팅을 한다. 프라이머가 완전히 굳은 후에 스프레이로 일정한 두께의 페인트를 칠하고 건조되면 위장 페인트를 다시 칠한다. 항공기운행 시 공기저항을 많이 받는 부위에는 다시 페인트를 칠한다. 도장작업이 완료되면 각 부의 두께가 명세표에 준하는지 확인하고 주변을 청소한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"항공기도장원","connectJob":"항공기도장검사원","certLic":"금속도장기능사","dJobECd":"8251","dJobECdNm":"[8251]도장원(도장기조작원)","dJobJCd":"8421","dJobJCdNm":"[8421]도장기 조작원","dJobICd":"C313","dJobICdNm":"[C313]항공기, 우주선 및 부품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004871:1', '{"dJobCd":"K000004871","dJobCdSeq":"1","dJobNm":"PCB도금원","workSum":"회로설계를 근거로 회로 부품을 접속하는 전기배선을 배선도형으로 표현하고 부품을 접속하기 위해 도금을 통하여 도체회로를 절연기판의 표면 또는 내부에 형성한다.","doWork":"작업표준서를 보고 작업에 필요한 장비와 공구를 준비한다. 동박적층판의 구조와 재질을 파악하고 단면 PCB와 양면 PCB 제작을 위하여 동박을 입힌 동박적층판을 준비한다. 재단기를 사용하여 실제로 작업에 사용할 크기인 패널(Penel) 크기로 동박적층판을 잘라낸다. 재단된 동박적층판의 모서리를 부드럽게 만들기 위한 면취가공을 한다. 배선의 끊어짐과 단락의 불량을 방지하기 위하여 동박적층판의 표면을 세정하기 위한 화학적 정면처리 또는 기계적 정면처리를 실시한다. PCB상에 D/F와 같은 감광제에 의한 배선패턴을 기판상에 형성하기 위해서 화상형성공정을 실시한다. 부식레지스트로 이용하여 동박의 배선패턴을 형성한다. 비아홀 매립 및 건조, PSR 도포, 노광 및 현상, 열경화 등의 흐름도에 따라 솔더레지스트 패턴을 형성한다. PCB에 인쇄하는 부품명, 부품위치 등을 표시하는 심벌마크 인쇄를 한다. 기판에 대한 최종적인 표면 마감처리를 실시한다. PCB에 전원을 공급하기 위하여 금, 니켈, 로듐과 같이 경도가 높고 도전성이 좋은 금속으로 단자도금을 한다. 솔더레지스트 및 심벌마크의 인쇄가 완료된 기판에 대하여 외형 및 부품삽입용 홀을 가공한다. 완성된 PCB에 대하여 물리적, 전기적인 검사를 실시하여 불량발생에 대처한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"대기환경미흡|위험내재|다습|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"표면처리기능사, 표면처리산업기사, 표면처리기능장","dJobECd":"8252","dJobECdNm":"[8252]도금·금속분무기 조작원","dJobJCd":"8422","dJobJCdNm":"[8422]도금 및 금속 분무기 조작원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005602:1', '{"dJobCd":"K000005602","dJobCdSeq":"1","dJobNm":"극인도금원","workSum":"부식과 마모에 저항성을 높이고 장식 목적 또는 전기·자기적 특성을 균분하기 위하여 금속제품 또는 부품을 극인도금하는 기기를 조작한다.","doWork":"작업명세서에 따라 도금할 제품을 확인한다. 도금의 두께와 색깔 등을 계산하여 작업공정을 계획한다. 도금조, 정류기, 에칭조 등의 기계시설을 점검한다. 전류분포가 균일하도록 제품걸이(래커)를 제작한다. 양극판의 산화피막을 제거하고 거치한다. 과산화납을 생성시키고, 불순물을 제거하기 위해 약전해 한다. 증류수에 크롬도금첨가제, 황산, 탈지제 등을 혼합한 도금액과 탈지액을 제조한다. 초음파 세정기를 이용하여 극인 표면에 묻어있는 광택연마제를 제거하고 육안으로 검사하여 불량제품을 선별한다. 유지분 및 유기오물을 알칼리용액에 침지하거나 전기분해하여 제거하고 황산용액 활성화 및 이온수를 이용하여 수세한다. 인면부를 제외한 나머지 부분을 도금방지 처리한 후 도금걸이에 거치한다. 인면의 산화방지용 방청유지를 제거하고 수세한다. 인면을 전해탈지조에 거치하여 전해탈지·수세하고, 산화막을 제거하기 위해 산용액에 담근다. 에칭(Etching)작업 후 도금조에 거치하여 저전류, 정격전류 및 조정전류를 통전한다. 도금방지처리부를 제거하고 알코올 등으로 세척·건조한다. 건조 후 제품상태를 검사하고, 불량요인에 따라 재생가능 제품은 탈도금한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"훈장도금원","certLic":"표면처리기능사, 표면처리산업기사, 표면처리기능장","dJobECd":"8252","dJobECdNm":"[8252]도금·금속분무기 조작원","dJobJCd":"8422","dJobJCdNm":"[8422]도금 및 금속 분무기 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006435:1', '{"dJobCd":"K000006435","dJobCdSeq":"1","dJobNm":"금속코팅기조작원","workSum":"압연가공한 철, 알루미늄 등 금속의 표면에 PVC, 아연, 폴리에스터필름 및 각종 도장재로 부식, 녹 등을 방지하기 위하여 코일의 표면을 도장 가공하는 코팅기를 조작한다.","doWork":"작업지시 및 작업표준에 따라 코팅할 제품을 확인한다. 코팅할 재료의 성질과 특성을 파악하고 확인한다. 작업내용을 숙지하고 관련 설비를 점검한다. 코일, 접착제, 아연, PVC, 폴리에스터필름 및 각종 필름 등 소재를 준비하고 접착제를 혼합하여 농도를 맞추고 가이드롤, 오일롤, 프레스롤 등의 작업이 진행될 수 있도록 적정 온도로 가열한다. 작업 주문서와 도면을 해석하고 기계조작 방법을 결정한다. 코팅기기를 적정온도로 가열한다. 기기를 조작하며 도장할 필름이 금속 표면에 정확히 코팅되는지 확인하고 작업을 진행한다. 코팅한 금속의 표면에 줄이나 흠이 발생하는지 확인한다. 철선의 인장상태에 주의하여 코팅기기의 정상속도를 유지한다. 긁힘이나 홈 등이 파손되지 않도록 코팅기의 피치간격을 조절한다. 코팅된 제품의 표면을 검사한 후 운반하여 적재한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"드라이라미네이터","certLic":"표면처리기능사, 표면처리산업기사, 표면처리기능장","dJobECd":"8252","dJobECdNm":"[8252]도금·금속분무기 조작원","dJobJCd":"8422","dJobJCdNm":"[8422]도금 및 금속 분무기 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006299:1', '{"dJobCd":"K000006299","dJobCdSeq":"1","dJobNm":"기판부식원","workSum":"동으로 되어있는 플라스틱·에폭시(Epoxy)판 위에 전도성 원형을 인쇄·부식하여 인쇄회로기판을 제조한다.","doWork":"일정 크기로 잘린 기판의 산화물이나 오염물질을 세척·제거하기 위해 화학용액에 담근다. 기판 표면에 감광 에나멜을 분무하거나 솔질하고 에나멜을 고르게 펴기 위해 선회기 안에 기판을 넣는다. 기판 위에 감광의 내식막을 도포하는 기계를 조작하여 감광막을 입힌다. 기판에 회로의 영상을 옮기기 위해 일정 시간 동안 빛을 노출한다. 표면에 내식막원형을 형성시키기 위하여 용액에 노출된 기판을 담근다. 견본과 비교하여 원형의 현상도를 확인하기 위해 기판을 검사한다. 현상되지 않은 원형부위에 내산성을 바르기 위해 솔을 사용하여 기판에 칠하기도 한다. 기판을 산용액에 담그거나 또는 동 표면 위에 전도성 있는 원형을 부식하는 기계를 조작한다. 용해된 에나멜용액에 기판을 담근다. 작업견본·도면 및 도해에 따라 드릴프레스를 사용하여 기판에 구멍을 뚫는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"표면처리기능사, 표면처리산업기사, 표면처리기능장","dJobECd":"8252","dJobECdNm":"[8252]도금·금속분무기 조작원","dJobJCd":"8422","dJobJCdNm":"[8422]도금 및 금속 분무기 조작원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001688:1', '{"dJobCd":"K000001688","dJobCdSeq":"1","dJobNm":"기판함침원","workSum":"인쇄회로용 절연적층판을 제조하기 위하여 기재(Raw Paper)를 혼합용액에 함침하고 일정 크기로 절단한다.","doWork":"롤 상태로 된 일정 두께의 기재를 함침기 위에 올려놓는다. 용액의 도포량을 조절하기 위해 함침시간을 조정한 후 기계를 동작하여 혼합용액에 함침한다. 용액이 묻은 기재를 건조오븐기에 건조한다. 건조된 기재를 절단기에 통과시켜 지정된 길이로 절단하고 적재한다. 절단된 기재를 관찰하여 용액의 도포량과 절단상태를 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"기판절단원","dJobECd":"8252","dJobECdNm":"[8252]도금·금속분무기 조작원","dJobJCd":"8422","dJobJCdNm":"[8422]도금 및 금속 분무기 조작원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004010:1', '{"dJobCd":"K000004010","dJobCdSeq":"1","dJobNm":"도금반장","workSum":"각종 제품을 도금하기 위하여 탈수, 연마, 탈지, 도금, 후처리, 탈수 및 건조 등 도금의 전반적인 과정과 종사하는 작업원의 활동을 감독·조정한다.","doWork":"고객의 주문사항이나 작업지시서의 내용을 이해하고 세부계획을 수립한다. 도금생산계획에 맞추어 도금전처리원, 도금원, 도금후처리원 등에게 역할을 분담하고 필요한 업무를 수행하도록 지시를 한다. 도금액관리원에게 작업에 필요한 도금액을 준비시키고 농도의 적절성을 확인한다. 도금전처리 과정에서 양질의 도금에 필요한 재료의 준비가 이루어지고 있는지 확인한다. 도금용액의 농도, 전류의 양, 도금제품의 침적시간 등이 작업명세서와 일치하는지 확인한다. 도금과정 중 도금원에게 기술적 지원을 하고 적절한 작업이 이루어지고 있는지 작업지시서의 내용과 비교·검토를 한다. 도금이 완료된 제품의 후처리공정을 확인하고 도금의 상태를 검사한다. 생산량과 작업의 내용을 일지에 적고 다음 작업을 준비한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|다습|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","connectJob":"용융도금반장, 전기도금반장, 니켈도금반장,아연도금반장, 주석도금반장, 청화동도금반장, 크롬도금반장, 황화동도금반장, 도금전처리반장, 도금후처리반장","certLic":"표면처리기능사, 표면처리산업기사, 표면처리기능장, 화학분석기능사","dJobECd":"8252","dJobECdNm":"[8252]도금·금속분무기 조작원","dJobJCd":"8422","dJobJCdNm":"[8422]도금 및 금속 분무기 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002886:1', '{"dJobCd":"K000002886","dJobCdSeq":"1","dJobNm":"도금액관리원","workSum":"도금에 필요한 도금액의 농도를 관리하고 도금액과 피막액을 분석하며 화학시험기기, 전기시험기기 등을 사용해 도금시험을 한다.","doWork":"도금에 필요한 조사항목을 확인한다. 분석에 필요한 각종 실험기기를 준비하고 분석하고자 하는 샘플을 채취한다. 내완충액 테스트, 염수분무, 액분석, 3가크롬 분석 등 각종 검사를 한다. 부적합 발생 시 대책을 수립하고 현물을 보관하고 유지하도록 한다. 테스트 내용을 기록하고 정해진 기간까지 보관한다. 공정명칭, 제조설비, 점검항목, 관리항목, 담당자, 관리스펙, 측정방법, 주기, 기록, 이상처리 등의 내용이 포함된 도금액 관리 일지를 작성한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|다습|소음·진동|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"도금액분석원","certLic":"화학분석기능사, 표면처리기능사","dJobECd":"8252","dJobECdNm":"[8252]도금·금속분무기 조작원","dJobJCd":"8422","dJobJCdNm":"[8422]도금 및 금속 분무기 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002209:1', '{"dJobCd":"K000002209","dJobCdSeq":"1","dJobNm":"도금전처리원","workSum":"도금대상 제품 표면에 묻어 있는 녹이나 방청유 등의 이물질을 제거하여 내식성과 부착성을 향상시키기 위해 탈지, 산처리, 중화, 수세, 박리 등의 전처리 업무를 한다.","doWork":"작업지시서나 도금반장의 지시에 따라 작업을 준비한다. 탈지용액을 준비해 탈지조에 일정 농도로 용액을 혼합한다. 도금할 제품을 용기에 담거나 랙에 걸어 기중기나 손으로 순서에 따라 탈지조, 중화조, 수세조에 넣고 꺼낸다. 수세가 끝난 제품을 건조기나 상온에서 건조한다. 박리제를 희석시킨 박리액 탱크에 불량 도금제품을 담가 피막을 벗겨낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|다습|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"도금박리원, 산처리작업원, 수세원, 침지탈지원","certLic":"표면처리기능사, 표면처리산업기사, 표면처리기능장","dJobECd":"8252","dJobECdNm":"[8252]도금·금속분무기 조작원","dJobJCd":"8422","dJobJCdNm":"[8422]도금 및 금속 분무기 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004629:1', '{"dJobCd":"K000004629","dJobCdSeq":"1","dJobNm":"도금후처리원","workSum":"도금된 제품의 표면을 보호하고 부식에 잘 견디도록 크롬 피막을 입히거나 양질의 제품상태를 유지시키기 위해 세척, 탈수, 건조, 변색처리 한다.","doWork":"작업지시서에 따라 세척과 후처리를 위한 준비를 한다. 전기도금원의 도금작업이 완료된 후 세척조를 가동한다. 이물질 제거를 위해 도금이 완료된 제품을 세척조에 넣어 수세한다. 수세가 끝나면 도금한 제품의 내식성을 높이기 위하여 크롬 피막을 입히는 크로메이트기기를 작동한다. 크로메이트 작업이 완료되면 다시 수세를 하고 탈수기에 넣어 탈수한다. 탈수기와 건조기를 가동시켜 탈수와 건조 작업을 한다. 도금후처리 과정이 완료된 제품 중 세척불량인 제품을 골라 다시 탈수와 건조 작업을 거친다. 이상이 없으면 출고를 위한 검사 및 도장 과정으로 보낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|다습|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"표면처리기능사, 표면처리산업기사, 표면처리기능장","dJobECd":"8252","dJobECdNm":"[8252]도금·금속분무기 조작원","dJobJCd":"8422","dJobJCdNm":"[8422]도금 및 금속 분무기 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004495:1', '{"dJobCd":"K000004495","dJobCdSeq":"1","dJobNm":"무전해도금원","workSum":"외부로부터 전기에너지를 공급받지 않고 금속염 수용액 중의 금속이온을 환원제의 힘에 의해 자기 촉매적으로 환원시켜 피처리물의 표면 위에 금속을 석출시킨다.","doWork":"작업표준서를 보고 작업에 필요한 장비와 공구를 준비한다. 밀착을 좋게 하기 위하여 성형응력을 제거하고, 친수성을 가지게 한다. 다음 공정의 에칭을 균일하게 하기 위하여 표면조정 및 탈지액을 건욕하고 탈지를 실시한다. 작업표준서 대로 에칭(Etching)액을 건욕하고 에칭을 한다. 감수성처리(Sensitizing)액을 건욕하고 부식에 의해 조화된 표면에 환원력이 강한 주석이온을 흡착시킨다. 활성화처리(Activation)액을 건욕하고 무전해 도금에서 촉매가 될 금속 팔라듐을 석출시킨다. 캐털리스팅에서 흡착된 염화제일주석과 염화팔라듐 콜로이드 촉매 중 염화제일주석을 제거하기 위하여 액셀러레이션 처리를 한다. 화학니켈도금액 또는 화학구리도금액을 건욕하고 화학도금을 한다. 전기를 통하여 황산구리도금을 실시한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"대기환경미흡|위험내재|고온|다습|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"표면처리기능장, 표면처리산업기사, 표면처리기능사","dJobECd":"8252","dJobECdNm":"[8252]도금·금속분무기 조작원","dJobJCd":"8422","dJobJCdNm":"[8422]도금 및 금속 분무기 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004253:1', '{"dJobCd":"K000004253","dJobCdSeq":"1","dJobNm":"볼트도금원","workSum":"열처리된 볼트를 도금하기 위해 도금설비를 조작한다.","doWork":"자동리프트를 사용하여 제품을 바렐(연마기의 일종)에 투입하고 뚜껑을 닫는다. 작업지시서에 따라 약품을 투입한다. 제품에 따라 아연·니켈 도금을 하거나 크롬도금을 한다. 자동캐리어를 이용하여 바스켓으로 제품을 이동한다. 호이스트를 이용하여 바스켓을 크로메이트조로 이동한다. 바스켓을 흔들어 크로메이트를 처리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|고온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"표면처리기능사, 표면처리산업기사, 표면처리기능장","dJobECd":"8252","dJobECdNm":"[8252]도금·금속분무기 조작원","dJobJCd":"8422","dJobJCdNm":"[8422]도금 및 금속 분무기 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002792:1', '{"dJobCd":"K000002792","dJobCdSeq":"1","dJobNm":"부식가공원","workSum":"항공기 부품을 화학적으로 강제 부식시켜 부품의 형상에 맞게 가공한다.","doWork":"작업표준서를 보고 작업에 필요한 공구와 자재를 준비한다. 준비된 부품을 작업대 위에 고정한다. 탈지제, 세척용액 등을 이용하여 세척하고 건조한다. 피복제를 부품에 균일하게 도포(塗布)하고 건조시킨 후 가공할 부위의 피복제를 제거한다. 도면에서 요구되는 부식가공량을 기준으로 작업시간을 산정하고, 정해진 작업시간 동안 부식용액에 장입(裝入:원료나 연료 따위를 쟁여 넣는 것)하여 부식가공한다. 작업이 끝나면 세척조에서 부품을 세척한다. 부식가공된 부위의 두께를 측정하여 실제 가공량을 측정하고 가공량이 부족하면 부족시간 만큼 추가로 가공한다. 부식가공이 마무리되면 피복제를 제거하고 부분적인 오염물질을 세척한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"대기환경미흡|위험내재|다습|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"표면처리기능장, 표면처리산업기사, 표면처리기능사","dJobECd":"8252","dJobECdNm":"[8252]도금·금속분무기 조작원","dJobJCd":"8422","dJobJCdNm":"[8422]도금 및 금속 분무기 조작원","dJobICd":"C313","dJobICdNm":"[C313]항공기, 우주선 및 부품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002250:1', '{"dJobCd":"K000002250","dJobCdSeq":"1","dJobNm":"산세반장","workSum":"코일, 강선, 강관, 강판 등 금속물의 산화피막 제거, 녹의 제거 및 방지, 기름 제거 등을 위하여 세척하는 데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"세척하려는 금속물의 양·크기·종류 등에 따라 침적시간, 용액농도, 산의 종류를 설정한다. 산세공정의 설비를 점검하고 관리한다. 부자재 및 공구를 확인하고 부족분을 청구한다. 작업원의 활동을 감독하고 기술을 지도한다. 세척된 물체의 표면을 검사하여 결함 여부를 조사한다. 실험실 분석을 위하여 산용액의 시료를 수집·분류한다. 세척탱크·온수조·걸대 등 각종 설비를 검사하여 이상이 있을 때 보수를 의뢰한다. 산 재생공정과 수시로 연락하여 세척탱크의 적정 농도와 온도를 유지한다. 비중·적정시험검사 등 각종 시험을 수행하기도 하며, 명세서와 일치하는지 확인하기 위해 세척용액을 분석하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|다습|","workFunc1":"조정","workFunc2":"감독","workFunc3":"수동조작","certLic":"표면처리기능사, 표면처리산업기사, 표면처리기능장","dJobECd":"8252","dJobECdNm":"[8252]도금·금속분무기 조작원","dJobJCd":"8422","dJobJCdNm":"[8422]도금 및 금속 분무기 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006413:1', '{"dJobCd":"K000006413","dJobCdSeq":"1","dJobNm":"산세원","workSum":"코일, 강선, 강관, 강판 등 금속물의 산화피막제거, 녹의 제거 및 방지, 기름제거 등을 위하여 화학약품으로 세척한다.","doWork":"온수탱크에 가열증기를 주입하여 일정 온도로 가열한다. 지시된 염산, 인산 등 의약품을 탱크에 혼합하여 작업표준에 지시된 산의 농도로 맞춘다. 산세할 제품을 천장기중기에 걸어 산세용 적치대에 놓는다. 천장기중기를 조작하여 적치대를 들어 올려 산탱크에 일정 시간 침적시켜 산으로 세척한다. 세척된 제품을 냉·온수 탱크에 침적시켜 산액을 씻어낸다. 산세된 제품의 표면을 검사하여 결함여부를 확인한다. 비중계를 사용하여 산의 농도를 검사하고 규정농도를 유지하기 위하여 화학약품을 첨가한다. 세척이 완료된 제품을 천장기중기를 사용하여 적치장에 적치한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|다습|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"표면처리기능사, 표면처리산업기사, 표면처리기능장","dJobECd":"8252","dJobECdNm":"[8252]도금·금속분무기 조작원","dJobJCd":"8422","dJobJCdNm":"[8422]도금 및 금속 분무기 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005146:1', '{"dJobCd":"K000005146","dJobCdSeq":"1","dJobNm":"산유세원","workSum":"선박 및 해양구조물의 파이프라인(윤활유, 유압유, 연료유 계통 및 기타 중요 파이프라인)에 발생한 녹 및 슬러그를 화공약품을 사용하여 제거한다.","doWork":"도면을 보고 파이프라인을 확인한다. 파이프 내외부의 오일을 제거한다. 화공약품이나 물을 이용하여 파이프를 세척한다. 녹의 발생을 방지하기 위하여 인산, 아연 피막처리를 한다. 파이프에 오일을 투입하기 위한 가배관을 설치한다. 가배관을 파이프에 연결하고 기어펌프를 조작하여 파이프에 플러싱(Flushing) 작업을 실시한다. 필터 및 분석기를 이용하여 파이프 청소 상태를 검사하고 이상이 없으면 기름을 제거한다. 가배관된 파이프의 복구작업을 한다. 화공약품의 조제 및 조정 작업을 한다. 폐 약품을 규정에 따라 밀봉하여 처리한다. 작업장 주위를 정리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"산세원","connectJob":"배관세정원","certLic":"표면처리기능사, 표면처리산업기사, 표면처리기능장","dJobECd":"8252","dJobECdNm":"[8252]도금·금속분무기 조작원","dJobJCd":"8422","dJobJCdNm":"[8422]도금 및 금속 분무기 조작원","dJobICd":"C241/C311","dJobICdNm":"[C241]1차 철강 제조업 / [C311]선박 및 보트 건조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002241:1', '{"dJobCd":"K000002241","dJobCdSeq":"1","dJobNm":"석도원","workSum":"절연피복되지 않은 나선에 부식방지와 용접성을 증가시키기 위해 용융주석으로 도금하는 기계를 조작한다.","doWork":"작업하는 제품의 규격을 확인하고 일정량의 주석을 계량하여 기계의 용융조에 넣는다. 가열기를 가동해서 주석을 용융한다. 권취보빈, 용융할 주석 등을 준비한다. 선재를 선재걸이에 걸고 잡아당긴다. 선재의 시단을 기계에 설치한다. 권취 스위치를 누르면서 권취보빈에 선재의 시단을 감는다. 보조 장력조절장치를 조작하여 적당한 장력으로 유지한다. 석도된 선재의 외관 및 권취상태, 전처리상태, 주석용융상태 등을 확인한다. 작업이 끝나면 선재의 외관·신율·도체경을 측정한다. 작업일지에 품명, 규격, 생산량 등을 기록한다. 다이스를 통과시킨 선재의 외관·도체율 등을 검사한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"주석도금원, 전선석도원","certLic":"표면처리기능사, 표면처리산업기사, 표면처리기능장","dJobECd":"8252","dJobECdNm":"[8252]도금·금속분무기 조작원","dJobJCd":"8422","dJobJCdNm":"[8422]도금 및 금속 분무기 조작원","dJobICd":"C262/C283","dJobICdNm":"[C262]전자부품 제조업 / [C283]절연선 및 케이블 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003438:1', '{"dJobCd":"K000003438","dJobCdSeq":"1","dJobNm":"시계도금원","workSum":"시계문자판 표면, 시곗바늘, 시곗줄 등 시계부품의 표면을 금이나 니켈도금을 하거나 시계부분품을 경화시키기 위하여 열처리 또는 담금질하는 노(爐)를 조작한다.","doWork":"작업명세서에 따라 도금할 시계부품의 규격, 수량, 형태 등을 확인한다. 도금액, 도금조, 원심분리건조기 등의 원료 및 장비를 준비하고 점검한다. 시계부품을 증류수로 세척하고 산·알카리 등으로 처리하여 중화작업을 한다. 각 도금조의 온도 및 정류기의 전류상태를 수시로 확인한다. 모양이나 색상에 따라 문자판에 니켈·금·은 등의 도금을 한다. 도금이 끝난 문자판을 원심분리건조기에 넣어 습기를 제거한다. 전기스위치를 넣어 필터를 가열하고 니켈·금 등의 도금액 및 광택제를 넣어 시곗바늘 등 부품을 도금한다. 도금한 부품을 탈지액으로 수세한 후 흐르는 물에 담근다. 아세톤과 시너(Thinner) 등으로 부품을 닦고 건조 후 이동상자에 담는다. 문자판의 변형 및 탈색을 방지하기 위한 공정으로 일정 온도에 따라 부품을 금속바구니나 실린더에 넣고 노(爐) 속에 삽입하여 작업표준에 맞게 열처리를 하여 노온도와 열처리 시간을 조절하면서 경화작업을 하기도 한다. 노에 열전대를 삽입하기도 하며 기록장치에 열전대를 연결하기도 한다. 각 도금조의 농도를 확인하고 부족한 용액을 보충한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"표면처리기능사, 표면처리산업기사, 표면처리기능장","dJobECd":"8252","dJobECdNm":"[8252]도금·금속분무기 조작원","dJobJCd":"8422","dJobJCdNm":"[8422]도금 및 금속 분무기 조작원","dJobICd":"C274","dJobICdNm":"[C274]시계 및 시계부품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003150:1', '{"dJobCd":"K000003150","dJobCdSeq":"1","dJobNm":"양극산화처리원","workSum":"전해액에서 물건을 양극으로 하고 전류를 흘린다. 양극에서 발생하는 산소에 의해서 금속 표면에 내식성이 크며 미세한 다공성으로 되어있어 여러 가지 색상의 착색이 가능한 산화피막을 형성한다.","doWork":"작업표준서를 보고 작업에 필요한 장비와 재료를 준비한다. 알칼리탈지액 및 전해탈지액을 건욕하고 알루미늄 재료에 탈지를 실시한다. 황산법에 의해 양극산화처리액을 건욕하고 피막이 무르고 착색력이 좋은 막을 얻고자 할 때, 경도가 크고 다공성이 적은 피막을 얻고자 할 때는 액온 및 농도를 조정하여 양극산화처리를 한다. 양극산화처리 후 수세와 중화를 충분히 하여 중화처리를 한다. 원하는 컬러를 얻기 위하여 착색액을 건욕하여 착색처리를 하고, 착색이 잘못되었을 때는 황산의 전해액이나 진한 질산액에 침지하여 탈색하고 재차 염색한다. 니켈-코발트염의 수용액 또는 비등수에서 봉공처리(Sealing)를 한 후 건조한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"대기환경미흡|위험내재|고온|다습|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"표면처리기능장, 표면처리산업기사, 표면처리기능사","dJobECd":"8252","dJobECdNm":"[8252]도금·금속분무기 조작원","dJobJCd":"8422","dJobJCdNm":"[8422]도금 및 금속 분무기 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003408:1', '{"dJobCd":"K000003408","dJobCdSeq":"1","dJobNm":"용융도금원","workSum":"알루미늄, 주석, 아연 등의 용융비철금속 도금을 위해 금속 용융액에 도금할 물건을 담아서 도금하는 기계설비를 조작한다.","doWork":"도금반장이나 작업지시서의 지시와 내용에 따라 하고자 하는 작업내용을 확인한다. 설비 및 도구의 이상 유무를 확인하고 작업표준에 따라 용융액을 혼합하고 비중계로 농도를 측정한다. 유지의 부착이 많은 피도금물은 산세 전에 탈지를 한 후 1차 물세척을 통해 이물질을 제거한다. 피도금물의 녹이나 흑피, 스케일 등의 제거를 위해 염산이나 황산을 사용하여 산세 작업을 한다. 피도금물의 표면에 부착되어 있는 산액 및 철염의 세정과 산세 중에 흡장한 수소를 제거하기 위해 2차 물세척을 실시한다. 도금하고자 하는 금속 용융액 속에 기중기나 컨베이어 벨트를 사용해 금속 제품을 담가 표면에 용융액을 부착하게 한 후 꺼낸다. 다른 종류의 금속 합금의 얇은 층을 만들어 공냉 또는 수냉을 통하여 냉각을 한다. 검사해서 불량품은 재도금을 실시하고 후처리를 하여 완제품을 생산한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"용착도금원, 침지도금원, 용융도금기조작원","connectJob":"니켈용융도금원, 아연용융도금원, 주석용융도금원, 아연도금기조작원, 니켈도금기조작원, 크롬도금원","certLic":"표면처리기능사, 표면처리산업기사, 표면처리기능장","dJobECd":"8252","dJobECdNm":"[8252]도금·금속분무기 조작원","dJobJCd":"8422","dJobJCdNm":"[8422]도금 및 금속 분무기 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003003:1', '{"dJobCd":"K000003003","dJobCdSeq":"1","dJobNm":"원통도금원","workSum":"회전하는 통(배럴) 안에 도금하고자 하는 제품을 넣고 전기도금을 하는 원통도금 기계를 조작한다.","doWork":"도금반장의 지시나 작업지시서에 따라 도금하고자 하는 내용을 숙지한다. 나사나 핀 등의 작은 물품을 대량 도금하는 경우 원통도금 기기를 이용하기 위한 준비를 한다. 작은 구멍들이 뚫려 있는 일정한 용기(다각형, 원통형, 나무통 모양)에 도금하고자 하는 금속제품을 넣고 뚜껑을 닫는다. 레버를 조작해 피도금체들이 벨트형 배럴(Barrel)이 회전함에 따라 서로 접촉하여 연마되면서 도금되고 광택을 내도록 전해액이 든 도금욕조 속에 담그고 수평회전한다. 연속적인 작업이 잘 이루어지도록 도금상태를 수시로 육안 확인한다. 도금이 완료되면 원통용기를 세척액 탱크에 넣어 세척한다. 원심건조기를 이용하여 도금된 제품을 건조한다. 비중계를 사용하여 도금액의 농도를 측정하고 부족한 화학성분을 첨가하여 혼합한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|다습|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"드럼도금원, 바렐도금원","certLic":"표면처리기능사, 표면처리산업기사, 표면처리기능장","dJobECd":"8252","dJobECdNm":"[8252]도금·금속분무기 조작원","dJobJCd":"8422","dJobJCdNm":"[8422]도금 및 금속 분무기 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003662:1', '{"dJobCd":"K000003662","dJobCdSeq":"1","dJobNm":"인산염도금원","workSum":"강이나 아연으로 코팅이 된 표면의 결합력을 유지하기 위하여 도금할 금속제품 표면에 인산염 피막을 입힌다.","doWork":"전처리 공정에 따라 탈지, 샌딩, 수세, 산세 등의 작업을 한다. 인산염피막을 할 제품을 전처리한 후 도금걸이(렉)에 걸거나, 작은 부품의 경우 바렐을 이용해 담는다. 도금시킬 제품을 렉과 바렐을 이용해 인산염처리 용액에 담근다. 일정 시간 동안 정지욕(Dipping)에서 인산염 처리과정을 거친 후 도금이 된 제품을 꺼낸다. 인산염이 처리된 용액의 수면에 떠 있는 오물을 제거한다. 수세와 탕세, 건조 등의 후처리를 위해 다음 공정으로 이동한다. 염수시험을 통해 내식성을 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|다습|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"표면처리기능사, 표면처리산업기사, 표면처리기능장","dJobECd":"8252","dJobECdNm":"[8252]도금·금속분무기 조작원","dJobJCd":"8422","dJobJCdNm":"[8422]도금 및 금속 분무기 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006157:1', '{"dJobCd":"K000006157","dJobCdSeq":"1","dJobNm":"인쇄기실린더도금원","workSum":"그라비어 인쇄용 실린더를 조각할 수 있도록 동·니켈·크롬 등으로 철 실린더에 도금한다.","doWork":"도금할 철 실린더의 유지를 제거하기 위하여 유기용제로 세척한다. 전기도금 장치에 세척된 철 실린더를 호이스트를 이용하여 올려놓고 고정한다. 피도금 실린더가 적정 위치까지 잠기도록 크롬액을 넣는다. 도금장치의 모터를 가동하여 일정 시간 동안 철 실린더를 회전한다. 크롬도금상태를 확인하고 건조한다. 크롬도금 실린더에 조각할 수 있도록 동 또는 니켈 전기도금을 한다. 도금두께에 따라 도금전류를 계산하고 도금상태를 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"표면처리기능사, 표면처리산업기사, 표면처리기능장","dJobECd":"8252","dJobECdNm":"[8252]도금·금속분무기 조작원","dJobJCd":"8422","dJobJCdNm":"[8422]도금 및 금속 분무기 조작원","dJobICd":"C181","dJobICdNm":"[C181]인쇄 및 인쇄관련 산업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004186:1', '{"dJobCd":"K000004186","dJobCdSeq":"1","dJobNm":"자동도금설비조작원","workSum":"탈지와 도금 공정을 기계화하여 자동으로 도금작업이 이루어지도록 한 자동도금 설비를 조작한다.","doWork":"도금반장의 지시나 작업지시서의 내용을 통해 도금계획을 세우고 자동도금 설비를 점검한다. 도금해야 할 제품의 종류와 형태를 확인하고, 도금액의 온도와 농도 등을 측정한다. 도금용액 탱크에 흐르는 전류의 양을 조절하고 규정 전류가 공급되는지 계기를 주시한다. 도금하고자 하는 제품의 도금용액 탱크침적시간을 결정하여 자동이송장치에 입력한다. 설비를 작동해 바렐과 렉을 이용하여 딥핑(Deeping)에 의한 자동도금을 진행한다. 건조기, 이온교환기, 농축기 등 부대장치의 정상작동 여부를 계기를 통하여 확인한다. 도금작업이 완료가 되면 자동적으로 설비의 작동이 멈추도록 조절한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|다습|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"표면처리기능사, 표면처리산업기사, 표면처리기능장","dJobECd":"8252","dJobECdNm":"[8252]도금·금속분무기 조작원","dJobJCd":"8422","dJobJCdNm":"[8422]도금 및 금속 분무기 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002592:1', '{"dJobCd":"K000002592","dJobCdSeq":"1","dJobNm":"전기도금원","workSum":"방식, 표면경화, 표면미화, 표면평활화 또는 빛 등의 반사율을 개선할 목적으로 전기분해를 이용해 금속 표면 또는 비금속 표면에 니켈, 아연, 은, 주석, 크롬 등의 밀착성 금속피막을 전착하는 표면처리 업무를 수행한다.","doWork":"전류조건, 전해액의 온도, 전착시간 등을 작업지시서에서 확인하거나 도금반장으로부터 지시를 받는다. 도금할 물체의 표면에 묻은 이물질을 제거하고, 전착시키고자 하는 금속의 이온을 함유한 전해액을 적절한 농도로 맞춘다. 비금속일 경우에는 전도율을 높이기 위해 전착하고자 하는 물건의 표면에 미리 흑연가루를 칠하거나 전도성 래커, 비전착성판 등으로 코팅을 한다. 정류기의 음극터미널에 도금하고자 하는 부품을 연결한다. 범퍼 등의 큰 부품은 랙으로 이동, 작은 부품들(와셔, 너트, 볼트, 나사못 등)은 회전배럴을 이용, 전선과 같은 재료는 특별히 고안이 된 장치를 이용해 도금을 한다. 금과 같이 비싼 금속은 필요한 곳만 선택적 도금을 한다(도금 필요가 없는 곳에 테이프를 대거나 마스킹을 한다). 스위치를 이용, 전류를 흐르게 해 용액의 금속물을 용해하고 부품 표면 위에 석출하게 한다. 일정한 도금시간이 지나면 도금된 물체를 꺼내 상태를 검사하고 물로 세척을 한다. 도금한 내용을 일지에 기록하고 다음 작업을 준비한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|다습|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"전기도금기조작원, 금속전기도금기조작원","connectJob":"금속정제기조작원, 금속침착기조작원, 금속피복기조작원, 고열침지도금기조작원, 금속선피복기조작원, 아노다이징원, 바렐도금원, PCB도금원, 핸드폰부품도금원, 알루미늄도금원, 수세도금원, 금속선코팅기조작원, 알루미늄표면처리원, 불소수지코팅원","certLic":"표면처리기능사, 표면처리산업기사, 표면처리기능장","dJobECd":"8252","dJobECdNm":"[8252]도금·금속분무기 조작원","dJobJCd":"8422","dJobJCdNm":"[8422]도금 및 금속 분무기 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002163:1', '{"dJobCd":"K000002163","dJobCdSeq":"1","dJobNm":"전기방식반장","workSum":"상수도공사의 지중에 매설된 상수관의 부식을 방지하기 위하여 양극(양전극)을 설치하는 작업원의 활동을 감독·조정한다.","doWork":"시방서 및 설계도면을 확인하고 현장여건에 알맞은 양극(양전극)설치 계획을 세운다. 필요한 양극(마그네슘, 아연)·모래·전선 등의 각종 자재를 구입한다. 전기방식원에게 양극설치에 따른 제반 요건 및 방법을 교육한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","certLic":"표면처리기능사, 표면처리산업기사, 표면처리기능장","dJobECd":"8252","dJobECdNm":"[8252]도금·금속분무기 조작원","dJobJCd":"8422","dJobJCdNm":"[8422]도금 및 금속 분무기 조작원","dJobICd":"F412","dJobICdNm":"[F412]토목 건설업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002663:1', '{"dJobCd":"K000002663","dJobCdSeq":"1","dJobNm":"전기방식원","workSum":"상수도공사의 지중에 매설된 상수관의 부식을 방지하기 위하여 양극(양전극)을 설치한다.","doWork":"용접할 부분의 배관도장을 끌과 망치로 제거한다. 배관 표면의 습기나 녹 및 기름기를 제거한다. 전선을 배관과 일치하게 놓고 몰드를 설치하여 화약과 동으로 용접을 한다. 용접부위를 에폭시(경화제, 주제)로 방수처리하고 테이프로 보양한다. 지중에 매설된 관의 부식상태를 측정하기 위하여 일정 간격으로 측정함을 설치한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"산화막처리기조작원","certLic":"표면처리기능사, 표면처리산업기사, 표면처리기능장","dJobECd":"8252","dJobECdNm":"[8252]도금·금속분무기 조작원","dJobJCd":"8422","dJobJCdNm":"[8422]도금 및 금속 분무기 조작원","dJobICd":"F412","dJobICdNm":"[F412]토목 건설업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006346:1', '{"dJobCd":"K000006346","dJobCdSeq":"1","dJobNm":"진공증착도금원","workSum":"도금액을 사용하지 않고 물리적 증착(PVD)기 및 화학적 증착(CVD)기를 사용하여 고온의 소재 위에 반응원료 가스를 보내어 소재 표면에서 반응하도록 하여 박막의 고체생성물을 석출시킨다.","doWork":"작업지시서의 작업내용을 숙지하고 진공 중에서 금속, 금속화합물 또는 합금을 가열 증발시킨다. 증발금속 또는 증발금속 화합물을 목적 물질의 표면에 응축하게 하고 피막을 형성시키기 위하여 진공증착기 및 관련 설비의 이상 유무를 점검한다. 컴프레서를 작동하여 진공증착할 때 필요한 진공도를 맞춘다. 피증착물에 적당한 약품을 사용하여 화학적 청정을 한다. 피증착물의 표면이 거칠 때에는 증착물의 광택도를 높이기 위하여 연마하든가 합성수지 도료로 도장하든가 해서 표면을 매끈하게 해준다. 진공증착 장비를 조작하여 피증착물에 진공증착을 실시한다. 진공도금 후에는 장식품일 때 도금의 변색방지, 마모로부터의 보호, 염색 등의 목적으로 투명코팅을 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"표면처리기능장, 표면처리산업기사, 표면처리기능사","dJobECd":"8252","dJobECdNm":"[8252]도금·금속분무기 조작원","dJobJCd":"8422","dJobJCdNm":"[8422]도금 및 금속 분무기 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006514:1', '{"dJobCd":"K000006514","dJobCdSeq":"1","dJobNm":"초음파세척원","workSum":"금속물체를 가공처리하기 위해 기름때, 찌꺼기, 이물질 등을 화학적·물리적 성질을 이용하여 세척하는 기계장치를 조작한다.","doWork":"금속제품에 묻은 먼지, 흠집, 녹슨 홈 등을 솔이나 세척용 걸레로 털어 낸다. 세척유를 준비하여 세척용기에 담은 다음, 초음파세척기를 작동한다. 세척상자에 금속제품을 담아서 손이나 기중기, 이송장치 등으로 옮겨 세척액에 담근다. 용액의 온도를 조절한다. 이송장치를 작동하고 속도를 조절한다. 용액기에 일정량의 화합물을 추가로 투입하여 일정 농도를 유지한다. 망에 제품을 올려두고 물을 뿌려 씻거나 습기를 닦아낸다. 화학제를 세척용기에 채워 넣는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|다습|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"표면처리기능사, 표면처리산업기사, 표면처리기능장","dJobECd":"8252","dJobECdNm":"[8252]도금·금속분무기 조작원","dJobJCd":"8422","dJobJCdNm":"[8422]도금 및 금속 분무기 조작원","dJobICd":"C291","dJobICdNm":"[C291]일반 목적용 기계 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002538:1', '{"dJobCd":"K000002538","dJobCdSeq":"1","dJobNm":"축전지격자연도원","workSum":"축전지 극판을 제조하기 위해서 경화된 그리드(격자)의 음극판에 연화물(극판활물질)을 도포한다.","doWork":"혼합된 연화물(극판활물질)을 연화물 도포기의 호퍼에 투입하고 경화된 그리드(격자)를 기계에 적재한다. 자동으로 그리드(격자)를 공급하는 기계를 가동하고 유도장치 사이에 그리드(격자)를 놓는다. 연화물 도포기를 작동하고 연화물이 그리드(격자)의 음극판에 도포되는 상태를 관찰한다. 연화물이 음극판에 도포 완료된 극판을 적재한 후 극판숙성실로 옮긴다. 극판숙성실에서 일정 시간 숙성, 건조시킨 생극판을 화성극판으로 만들기 위한 공정으로 보내기 위해 일정 장소에 적재한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"축전지격자도포원, 축전지연화물도포원","connectJob":"축전지극판숙성원","certLic":"표면처리기능사, 표면처리산업기사, 표면처리기능장","dJobECd":"8252","dJobECdNm":"[8252]도금·금속분무기 조작원","dJobJCd":"8422","dJobJCdNm":"[8422]도금 및 금속 분무기 조작원","dJobICd":"C282","dJobICdNm":"[C282]일차전지 및 축전지 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001923:1', '{"dJobCd":"K000001923","dJobCdSeq":"1","dJobNm":"탈지기운전원","workSum":"냉간압연작업 중에 금속소재에 부착된 압연유 및 기타 이물질을 세척유를 사용하여 제거하기 위한 장비를 조작한다.","doWork":"작업지시서의 작업내용을 숙지하고 탈지기 및 관련 설비의 이상 유무를 점검한다. 탈지할 소재를 언코일러(Uncoiler)에 장입하고 탈지장비에 소재를 투입한다. 탈지기를 조작하여 탈지작업을 시작하고 작업진행상황을 관찰한다. 작업이 완료되어 나온 소재가 리코일러에 감기도록 한다. 작업이 완료되면 풀리지 않도록 밴딩한다. 탈지작업이 완료된 소재는 다음 공정이나 적하장으로 보낸다. 되감긴 소재의 바깥테를 소정의 형상 및 일정한 치수로 절단하는 트리밍작업을 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"표면처리기능사, 표면처리산업기사, 표면처리기능장","dJobECd":"8252","dJobECdNm":"[8252]도금·금속분무기 조작원","dJobJCd":"8422","dJobJCdNm":"[8422]도금 및 금속 분무기 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003615:1', '{"dJobCd":"K000003615","dJobCdSeq":"1","dJobNm":"탈지원","workSum":"압연가공된 금속코일 표면에 형성된 스케일과 같은 이물질 및 산화피막 등을 제거하기 위해 탈지설비를 조작한다.","doWork":"작업지시서를 숙지하고 탈지설비의 이상 유무를 점검한다. 탈지조의 액 보충, 압축공기의 정상 배출 여부, 언코일러 및 리코일러의 작동 여부, 건조기·기기장치의 작동 여부 등을 확인하는 등 탈지설비의 가동을 점검한다. 탈지설비의 주전원을 켜고 회수조의 냉각수량, 액면확인, 용제액 온도 등을 확인하고 유압 유닛 스위치를 켠다. 탈지설비를 운전하여 코일 표면의 이물질이 제거되었는지 확인하고 작업을 진행한다. 작업이 완료되면 탈지된 코일의 표면을 검사하고 다음 공정으로 운반한다. 탈지조 및 회수조의 오물 및 불순물을 제거하여 청소하고 탈지액을 정화한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"표면처리기능사, 표면처리산업기사, 표면처리기능장","dJobECd":"8252","dJobECdNm":"[8252]도금·금속분무기 조작원","dJobJCd":"8422","dJobJCdNm":"[8422]도금 및 금속 분무기 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004195:1', '{"dJobCd":"K000004195","dJobCdSeq":"1","dJobNm":"강화로조작원","workSum":"성형판유리에 열처리한 후 급냉효과로 압축 응력층을 형성하여 유리의 강도를 높이기 위하여 강화로 기계를 운전·조작한다.","doWork":"작업지시서에 따라 강화 작업할 성형유리의 종류와 규격을 확인한다. 강화작업 유리의 종류에 따라 온도, 압력 등을 계산하여 컨트롤박스에 입력한다. 강화로의 윤활상태, 오일상태 및 작동 여부를 점검한다. 면취기로 각면취 및 양면취 작업을 한다. 세척기를 통과시켜 오염물질을 제거한다. 강화로를 가동하여 노 내의 온도를 적정연화온도(서냉점과 연화점 사이 온도)로 높인다. 자동컨베이어 이송대차에 강화작업을 할 유리를 건다. 이송대차를 조작하여 유리를 강화로의 유리내각에 수직으로 장입한다. 열처리기계를 가동하여 연화온도로 열처리한다. 열처리된 유리를 꺼내어 이동대차 또는 자동롤러를 이용하여 냉각기를 통과시켜 실온까지 냉각한다. 강화가공된 유리의 표면과 형태를 육안으로 검사한다. 강화가공된 유리를 적재한다. 제품에 따라 수직강화로, 수평강화로를 조작하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|고온|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"유리강화로조작원","certLic":"열처리기능사","dJobECd":"8261","dJobECdNm":"[8261]유리·유리제품 생산기계 조작원","dJobJCd":"8431","dJobJCdNm":"[8431]유리 제조 및 가공기 조작원","dJobICd":"C231","dJobICdNm":"[C231]유리 및 유리제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006572:1', '{"dJobCd":"K000006572","dJobCdSeq":"1","dJobNm":"거울도금원","workSum":"거울제조 공정 중 은, 동 용액을 혼합하여 거울 유리면에 뿌리는 도금렌지(Range)를 운전·조작한다.","doWork":"작업표준서에 따라 도금할 거울의 종류 및 형태, 규격, 수량을 확인한다. 도금기등 장치의 작동 여부와 분사노즐의 상태를 점검한다. 규정된 양만큼 각각의 원료를 계량한다. 분사기의 혼합통에 물을 채운다. 계량된 도금혼합물을 혼합통에 넣어 혼합한다. 도금혼합물을 도금기의 저장탱크로 이동한다. 분사량 및 분사속도 등의 수치를 도금기의 디지털입력기에 입력한다. 저장탱크의 도금혼합물을 분사기로 이동시킨다. 자동컨베이어로 원판유리를 도금기의 작업대로 운반한다. 분사노즐을 가동하여 시험가동을 한다. 시험도금된 제품의 도막형태와 두께 등을 검사한다. 이상이 없으면 연속작업을 하며 육안으로 노즐의 분사상태를 확인한다. 완성된 도금제품의 도막상태, 도막 두께 등을 확인, 점검한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"금속도장기능사","dJobECd":"8261","dJobECdNm":"[8261]유리·유리제품 생산기계 조작원","dJobJCd":"8431","dJobJCdNm":"[8431]유리 제조 및 가공기 조작원","dJobICd":"C231","dJobICdNm":"[C231]유리 및 유리제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005420:1', '{"dJobCd":"K000005420","dJobCdSeq":"1","dJobNm":"관유리성형원","workSum":"형광등 관유리, 이화학용 관유리 등과 같이 튜브 형태의 관유리를 성형하는 관유리 성형기를 운전·조작한다","doWork":"작업지시서에 따라 성형할 관유리의 종류, 형태, 규격, 수량을 확인한다. 관유리 성형기계의 입구 상태, 전로(Fore Hearth) 상태, 슬리브의 회전각도 등을 점검한다. 성형기계의 윤활유, 오일상태와 작동상태를 점검한다. 작업표준에 맞게 조합한 슬리브를 가마에 장입한다. 승온 시 슬리브의 팽창에 따른 파손을 막기 위해 승온곡선에 따라 버너를 조절하여 작업온도까지 가열한다. 슬리브드라이브(Sleeve Drive)의 스위치를 넣어 슬리브(또는 Mandrel)를 회전시킨다. 슬리브에 압축공기 호스를 연결하고 규정압력으로 압축공기를 불어 넣는다. 용융유리물 공급탱크의 배출구를 열어 슬리브에 공급하고 제품규격에 따라 공급되는 유리소지의 양을 조절한다. 슬리브에서 유리관이 성형되어 나오면 집게로 집고 서서히 당기면서 관인기의 타이밍벨트에 연결하여 관인기에 삽입한다. 관인된 제품과 품질규격에 명시된 두께·외경·길이 등을 비교하여 각종 설비를 조정한다. 관인기에서 나온 관유리를 규격에 맞추어 절단하고 절단기에 연결된 컨베이어의 속도를 조절한다. 완성된 관유리를 검사한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"고온|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"관인기조작원","dJobECd":"8261","dJobECdNm":"[8261]유리·유리제품 생산기계 조작원","dJobJCd":"8431","dJobJCdNm":"[8431]유리 제조 및 가공기 조작원","dJobICd":"C231","dJobICdNm":"[C231]유리 및 유리제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003602:1', '{"dJobCd":"K000003602","dJobCdSeq":"1","dJobNm":"광학유리재단원","workSum":"정밀기구에 사용되는 렌즈·프리즘·거울 또는 기타 광학용품의 제조를 위하여 광학유리판을 여러 크기와 모양으로 자르는 다이아몬드톱기계를 조작한다.","doWork":"작업지시서 또는 지시받은 내용을 확인한다. 다이아몬드톱기계를 점검하고 차트(Chart)를 참고로 생산품의 규격을 결정한다. 유리 외관의 기포나 깨진 부분 등의 결함 여부를 살피고 재료를 최대한으로 이용하기 위하여 유리판의 절단방법을 결정한다. 연필 등으로 유리판에 절단선을 긋고 작업대 위에 올려놓는다. 절단 깊이와 폭에 따라 유도장치를 고정한다. 절단선에 따라 다이아몬드톱기계로 절단한다. 절단된 재료에 모난 가장자리 등을 연삭기로 연삭한다. 절단된 재료의 불필요한 부분을 표면 연마기를 사용하여 제거하기도 한다. 절단된 생산품을 꺼내어 치수와 형태, 무게 등을 측정하여 명세서와 일치 여부를 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"렌즈유리재단원, 프리즘유리재단원, 거울유리재단원","connectJob":"렌즈절단원, 렌즈절단기조작원, 유리절단기조작원, 렌즈커팅기조작원","dJobECd":"8261","dJobECdNm":"[8261]유리·유리제품 생산기계 조작원","dJobJCd":"8431","dJobJCdNm":"[8431]유리 제조 및 가공기 조작원","dJobICd":"C273","dJobICdNm":"[C273]사진장비 및 광학기기 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;