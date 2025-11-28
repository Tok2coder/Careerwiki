INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003355:1', '{"dJobCd":"K000003355","dJobCdSeq":"1","dJobNm":"아이스크림냉동기조작원","workSum":"아이스크림의 혼합물을 반고체로 냉각하는 냉동기계를 조작·관리한다.","doWork":"숙성탱크의 아이스크림 혼합물을 확인하고 이송펌프를 가동하여 냉동기의 실린더로 혼합액을 주입한다. 제품의 종류에 따라 규정된 냉각온도, 공기압력, 기계의 속도 등을 입력한다. 밸브를 열어 암모니아가스 또는 프레온가스 등의 냉매를 냉각코일에 주입한다. 조직을 부드럽게 하고 용적을 증가시키기 위하여 공기를 혼합물에 주입한다. 교반기의 스크레이퍼(Scraper), 익스펠러(Expeller)를 가동하여 실린더 벽면에 동결한 혼합물을 깎아 부드럽고 미세한 결정을 만든다. 규정된 냉각온도, 공기압력, 기계의 속도를 유지하고 온도계를 확인한다. 투입된 용액의 종류와 시간, 양 등을 작업일지에 기록하고, 탱크의 상단에 부착한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"저온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"동결기조작원","dJobECd":"8731","dJobECdNm":"[8731]육류·어패류·낙농품 가공기계 조작원","dJobJCd":"8113","dJobJCdNm":"[8113]육류·어패류 및 낙농품 가공 기계 조작원","dJobICd":"C105","dJobICdNm":"[C105]낙농제품 및 식용빙과류 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006518:1', '{"dJobCd":"K000006518","dJobCdSeq":"1","dJobNm":"아이스크림성형기조작원","workSum":"냉동된 아이스크림 혼합물을 일정한 모양으로 성형하고자 혼합물 충전·성형하고 경화하는 성형기계를 조작한다.","doWork":"이송펌프를 가동하여 냉동기에서 혼합 냉동된 아이스크림용액을 충전기의 호퍼에 일정량 공급한다. 충전기의 노즐압력과 용량조절밸브를 조정한다. 아이스크림이 경화되도록 냉동매체(염화칼슘용액) 순환펌프를 가동한다. 감속기를 조절하여 성형기의 속도를 충전기의 충전속도와 맞춘다. 아이스크림이 채워진 성형틀에 나무 또는 플라스틱 막대기를 꽂아주는 자동스틱기계(Automatic Stick Machine)를 조정하고 호퍼에 스틱을 공급한다. 경화된 아이스크림을 성형틀에서 쉽게 뽑아내기 위하여 성형틀 하부에 장치된 가열탱크에 증기를 주입하여 일정 온도로 가열한다. 성형된 아이스크림을 자동으로 뽑는 기계의 속도와 성형기의 속도가 일치하는지 점검한다. 작업한 수량과 제품의 종류를 작업일지에 기록한다. 제품의 특성에 따라 코팅기를 조작하기도 하며 단팥, 잼 등으로 아이스크림의 속을 채우기도 한다. 제품의 형태에 따라 성형틀을 교체하기도 하며 성형틀에 종이, 플라스틱 또는 과자로 된 콘(Cone:원추용 용기)을 채우기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|다습|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"바(bar)성형기조작원, 콘성형기조작원","dJobECd":"8731","dJobECdNm":"[8731]육류·어패류·낙농품 가공기계 조작원","dJobJCd":"8113","dJobJCdNm":"[8113]육류·어패류 및 낙농품 가공 기계 조작원","dJobICd":"C105","dJobICdNm":"[C105]낙농제품 및 식용빙과류 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006006:1', '{"dJobCd":"K000006006","dJobCdSeq":"1","dJobNm":"아이스크림원료배합기조작원","workSum":"아이스크림, 빙과의 원료를 배합하고 균의 오염을 방지하고자 원료배합기 및 살균기를 관리·조작한다.","doWork":"제품의 종류에 따라 배합원료를 확인하고, 수령한다. 설탕, 전지분유, 물엿, 기타 첨가물(색소, 과일엑기스) 등을 배합표에 의해 정량 계량하여 혼합기의 투입구에 분말형태로 투입하거나 물과 혼합하여 투입한다. 교반기를 가동하여 일정 시간 동안 혼합한다. 육안으로 혼합물의 색상을 점검하고 당도계로 당도를 검사하여 작업일지에 기록한다. 혼합액을 필터(Filter)를 통과시켜 여과시키고 살균기를 통과시켜 가열 살균한다. 살균된 용액을 숙성탱크로 이송한다. 혼합한 용액의 종류와 투입된 원료의 양을 작업일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"액당제조원","dJobECd":"8731","dJobECdNm":"[8731]육류·어패류·낙농품 가공기계 조작원","dJobJCd":"8113","dJobJCdNm":"[8113]육류·어패류 및 낙농품 가공 기계 조작원","dJobICd":"C105","dJobICdNm":"[C105]낙농제품 및 식용빙과류 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003664:1', '{"dJobCd":"K000003664","dJobCdSeq":"1","dJobNm":"아이스크림제조반장","workSum":"아이스크림 생산과정을 감독하고 문제 발생 시 조치를 취한다.","doWork":"아이스크림 제조 생산직 근로자의 근태를 관리한다. 일일 생산일지를 작성한다. 생산과정을 관찰하고 문제가 발생할 경우 조치를 취한다. 필요시 작업원과 함께 작업한다. 기타 교육 및 안전관리 등 반장이 수행하는 업무를 수행한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","dJobECd":"8731","dJobECdNm":"[8731]육류·어패류·낙농품 가공기계 조작원","dJobJCd":"8113","dJobJCdNm":"[8113]육류·어패류 및 낙농품 가공 기계 조작원","dJobICd":"C105","dJobICdNm":"[C105]낙농제품 및 식용빙과류 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004075:1', '{"dJobCd":"K000004075","dJobCdSeq":"1","dJobNm":"아이스크림제조중앙통제장치조작원","workSum":"아이스크림 제조에 사용되는 배합기, 균질기, 살균기 등을 중앙통제장치에서 조작한다.","doWork":"아이스크림 제조에 사용되는 멜팅기, 플로메타, 배합기, 균질기, 살균기, 냉각기, 코팅기 등의 가동상태를 모니터링한다. 현장을 순찰하여 배합기, 균질기, 살균기 등의 가동상태 유무를 확인한다. 필요시 밸브 등을 조절하여 수치를 조정한다. 작업과정에서 발생하는 특이사항 등을 작업일지에 작성한다. 고장 시 응급처리를 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8731","dJobECdNm":"[8731]육류·어패류·낙농품 가공기계 조작원","dJobJCd":"8113","dJobJCdNm":"[8113]육류·어패류 및 낙농품 가공 기계 조작원","dJobICd":"C105","dJobICdNm":"[C105]낙농제품 및 식용빙과류 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001913:1', '{"dJobCd":"K000001913","dJobCdSeq":"1","dJobNm":"아이스크림충전원","workSum":"아이스크림 원료믹스를 충전하는 충전기를 조작한다.","doWork":"아이스크림 종류에 따라 충전방법을 확인한다. 바류의 경우 몰드에 아이스크림 원료믹스를 충전하고 콘류는 제품 용기에 직접 충전한다. 충전과정을 모니터링하고 문제가 발생하면 조치를 취한다. 충전된 아이스크림을 급속 냉동공정 또는 포장공정으로 이송한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"시범후 30일 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"아이스크림충진원","dJobECd":"8731","dJobECdNm":"[8731]육류·어패류·낙농품 가공기계 조작원","dJobJCd":"8113","dJobJCdNm":"[8113]육류·어패류 및 낙농품 가공 기계 조작원","dJobICd":"C105","dJobICdNm":"[C105]낙농제품 및 식용빙과류 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002194:1', '{"dJobCd":"K000002194","dJobCdSeq":"1","dJobNm":"어묵제조반장","workSum":"어묵을 제조하고자 원료를 배합하고 성형하는 데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"어묵을 제조하고자 배합되는 연육과 첨가물의 신선도를 검사한다. 성형기의 가동상태를 점검하고 제품의 가공상태를 점검한다. 작업의 진행사항을 파악하고 작업내용을 보고한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원 및 자재를 공급한다. 작업계획에 따라 세부실행항목을 수립하고 작업절차 및 방법을 결정하여 작업원에게 작업내용을 지시하고 작업을 배치한다. 작업원의 직무교육 및 안전위생교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴·해결하고 문제점을 보완한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|저온|다습|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","connectJob":"맛살제조반장","dJobECd":"8731","dJobECdNm":"[8731]육류·어패류·낙농품 가공기계 조작원","dJobJCd":"8113","dJobJCdNm":"[8113]육류·어패류 및 낙농품 가공 기계 조작원","dJobICd":"C102","dJobICdNm":"[C102]수산물 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003262:1', '{"dJobCd":"K000003262","dJobCdSeq":"1","dJobNm":"어묵제조원","workSum":"어묵을 제조하고자 어육을 배합·스팀·성형·튀김·냉각하는 설비를 조작한다.","doWork":"제품의 종류에 따라 사용할 생선 연육 및 부재료를 확인한다. 배합기, 성형기 등 각종 장비를 점검한다. 연육 및 부재료를 배합하고 운반하여 삽 등으로 성형기에 투입한다. 생산 제품별 모양에 따라 다양한 형태로 성형한다. 성형된 어묵을 제품의 특성에 따라 튀기거나 굽는다. 어묵의 견본을 채취하여 맛, 향, 색상 등을 검사하고 제품 표준과 비교한다. 완성된 어묵을 포장공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"수제어묵제조원","dJobECd":"8731","dJobECdNm":"[8731]육류·어패류·낙농품 가공기계 조작원","dJobJCd":"8113","dJobJCdNm":"[8113]육류·어패류 및 낙농품 가공 기계 조작원","dJobICd":"C102","dJobICdNm":"[C102]수산물 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005737:1', '{"dJobCd":"K000005737","dJobCdSeq":"1","dJobNm":"어육분리기조작원","workSum":"급속 냉동된 어육을 팬(Pan)과 분리시키는 기계를 조작한다.","doWork":"급속냉동실로부터 급속 냉동된 팬을 밀차에 실어 운반한다. 작업대 양쪽 지주대에 팬을 뒤집어서 걸쳐놓고 고정한다. 모터를 가동시키고 기계 해머(Hammer)를 위로 올린 후 떨어뜨려 어육을 팬과 분리한다. 분리된 어육을 절단공정이나 저장창고 등 다음 공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|저온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"탈팬작업원","dJobECd":"8731","dJobECdNm":"[8731]육류·어패류·낙농품 가공기계 조작원","dJobJCd":"8113","dJobJCdNm":"[8113]육류·어패류 및 낙농품 가공 기계 조작원","dJobICd":"C102","dJobICdNm":"[C102]수산물 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004776:1', '{"dJobCd":"K000004776","dJobCdSeq":"1","dJobNm":"어육정형원","workSum":"제피·가공된 어육을 일정한 포장용기에 넣어 냉동하는 설비를 조작·관리한다.","doWork":"제품별 또는 정형중량에 따라 포장용기를 선별한다. 컨베이어로 운반되는 어육을 자동저울이나 계량용기로 중량을 측정하여 용기에 집어넣는다. 금속탐지기를 사용하여 이물질을 검사한다. 비닐포장지를 위에 덮고 밀봉한 후, 중량을 재점검한다. 제품밀봉이 완료된 제품을 박스 등으로 외포장한다. 포장이 완료된 제품을 냉동실로 운반한다. 제품을 출고시키기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|저온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"어육포장원","dJobECd":"8731","dJobECdNm":"[8731]육류·어패류·낙농품 가공기계 조작원","dJobJCd":"8113","dJobJCdNm":"[8113]육류·어패류 및 낙농품 가공 기계 조작원","dJobICd":"C102","dJobICdNm":"[C102]수산물 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002375:1', '{"dJobCd":"K000002375","dJobCdSeq":"1","dJobNm":"연유제조원","workSum":"연유를 제조하고자 원유를 살균·농축·냉각·숙성하는 장비를 조작한다.","doWork":"원유검사를 합격한 원유를 고온살균기를 통과시켜 살균한다. 펌프를 가동하여 살균된 원유를 농축기에 주입하고 밸브를 잠근다. 진공펌프를 가동하여 농축기 내부에 일정한 압력을 유지한다. 농축기의 압력과 온도를 일정하게 유지하면서 원유를 농축한다. 농축과정을 관찰하고 점검한다. 굴절계(Refractometer)와 액체비중계를 사용하여 증발된 용액의 농축도를 확인하여 증기의 압력이나 온수의 공급을 조절한다. 농축이 완료되면 밸브를 조절하여 냉각탱크로 이송한다. 냉각탱크의 재킷에 냉각수를 순환시켜 농축액을 냉각한다. 냉각된 농축유를 냉각탱크에서 서서히 교반기를 돌리면서 냉각시킨 후 숙성시킨다. 숙성이 완료된 농축유를 포장공정으로 이송한다. 자동화된 기계의 조정판에 살균·농축·냉각하는 시간이나 가동순서를 입력하여 제조되는 과정을 관찰·조절하기도 한다. 가당연유의 경우 원유를 예열시켜 설탕을 첨가하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|다습|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8731","dJobECdNm":"[8731]육류·어패류·낙농품 가공기계 조작원","dJobJCd":"8113","dJobJCdNm":"[8113]육류·어패류 및 낙농품 가공 기계 조작원","dJobICd":"C105","dJobICdNm":"[C105]낙농제품 및 식용빙과류 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001266:1', '{"dJobCd":"K000001266","dJobCdSeq":"1","dJobNm":"연육배합기조작원","workSum":"맛살과 각종 어묵제품을 제조하고자 연육(얇게 저민 고기), 밀가루, 전분 및 기타 첨가물(소금, 설탕 등)을 배합하는 기계를 조작한다.","doWork":"제품의 종류에 따라 밀가루, 전분, 소금, 설탕 등 첨가물을 일정 비율로 계량한다. 배합기를 조작하여 교반 속도, 시간 등을 조절한다. 해동·분쇄된 연육을 투입하고 계량한 첨가물을 배합순서에 따라 투입한다. 일정 시간 배합 후, 견본을 채취하여 색상, 맛, 향 등을 검사한다. 배합이 완료되면 배출밸브를 열고 펌프를 가동하여 성형공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|","workEnv":"저온|다습|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8731","dJobECdNm":"[8731]육류·어패류·낙농품 가공기계 조작원","dJobJCd":"8113","dJobJCdNm":"[8113]육류·어패류 및 낙농품 가공 기계 조작원","dJobICd":"C102","dJobICdNm":"[C102]수산물 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004602:1', '{"dJobCd":"K000004602","dJobCdSeq":"1","dJobNm":"열탕살균원","workSum":"통조림의 장기보존 및 내용물의 변질방지를 위하여 내부의 균을 살균하는 기계를 조작한다.","doWork":"살균탱크의 유량계를 확인하여 부족한 수량을 채운다. 통조림의 내용물 종류와 크기에 따른 살균 온도와 시간을 확인한다. 증기밸브 등을 조절하여 살균탱크의 물을 일정 온도로 가열한다. 컨베이어의 이송속도를 조절하여 살균시간을 조정한다. 이송컨베이어를 가동하여 살균탱크로 통조림을 투입한다. 살균된 통조림을 냉각탱크에 통과시켜 내용물의 신선도를 유지한다. 냉각되어 나오는 통조림의 외형이나 밀봉상태를 관찰하여 불량한 제품을 선별한다. 작업한 수량을 일지에 기록하고 작업장 주위를 청소한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|고온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"살균기조작원","dJobECd":"8731","dJobECdNm":"[8731]육류·어패류·낙농품 가공기계 조작원","dJobJCd":"8113","dJobJCdNm":"[8113]육류·어패류 및 낙농품 가공 기계 조작원","dJobICd":"C101","dJobICdNm":"[C101]도축, 육류 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002533:1', '{"dJobCd":"K000002533","dJobCdSeq":"1","dJobNm":"용해유살균배양원","workSum":"발효유를 제조하고자 용해유를 배양탱크에서 배양한다.","doWork":"용해유가 배양탱크로 이송되면 스팀을 이용하여 일정한 온도까지 가열·조작하면서 관찰한다. 살균이 완료되면 규정된 온도까지 냉각시킨다. 종균을 가져와서 탱크 안에 일정량을 넣은 뒤 교반기를 작동하여 혼합하면서 접종한다. 일정한 기간 동안 작업표준에 따라 배양한 후 적정온도가 맞는지, 생균수와 산도(酸度:산성도)가 적정하게 유지되는지 확인한다. 작업상황을 작업일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"균형감각|","workEnv":"위험내재|다습|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8731","dJobECdNm":"[8731]육류·어패류·낙농품 가공기계 조작원","dJobJCd":"8113","dJobJCdNm":"[8113]육류·어패류 및 낙농품 가공 기계 조작원","dJobICd":"C105","dJobICdNm":"[C105]낙농제품 및 식용빙과류 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001347:1', '{"dJobCd":"K000001347","dJobCdSeq":"1","dJobNm":"우유수령원","workSum":"집유되는 원유의 양을 목장별로 계량하여 집유량을 기록하고 저장탱크로 이송하는 펌프를 조작한다.","doWork":"자동저울의 스위치를 넣고 우유통을 저울 위로 올려 중량을 확인한다. 목장 단위별로 우유통의 수량을 확인한다. 통의 뚜껑을 열어 원유의 보관상태나 색상을 육안으로 확인한다. 시험분석을 위하여 원유의 견본을 채취하여 관련 부서에 보낸다. 운반용 탱크차량의 우유를 저장용 탱크에 수송하고자 차량 하부밸브의 관을 저장용 탱크로 연결하여 밸브를 열고 우유를 전달시킨다. 원유가 완전히 투입되면 원유주입량 계기를 확인하여 기록표에 기록한다. 집유작업이 완료되면 원유를 종류별로 저장탱크에 이송한다. 물호스 또는 자동세척장비를 사용하여 집유통, 집유탱크, 펌프장비 등을 세척한다. 각 공정에 원유를 공급하고자 밸브, 펌프 등을 조작하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|","workEnv":"대기환경미흡|다습|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"원유검사보조원","dJobECd":"8731","dJobECdNm":"[8731]육류·어패류·낙농품 가공기계 조작원","dJobJCd":"8113","dJobJCdNm":"[8113]육류·어패류 및 낙농품 가공 기계 조작원","dJobICd":"C105","dJobICdNm":"[C105]낙농제품 및 식용빙과류 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005217:1', '{"dJobCd":"K000005217","dJobCdSeq":"1","dJobNm":"유지배합기조작원","workSum":"유지 원료를 계량하고 배합기에 투입하며 제어장치를 조작한다.","doWork":"제품의 종류에 따라 배합원료를 확인하고, 필요한 물품을 수령한다. 유지의 원료와 첨가물을 저울로 계량한다. 작업지시서에 따라 제어장치를 조정하여 원료와 첨가물을 투입한다. 자동화 투입이 어려운 원료는 직접 손으로 투입한다. 혼합공정이 원활히 이루어지는지 제어장치로 감시한다. 투입된 원료의 양 등 업무내용을 일지에 작성한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"유지배합원","dJobECd":"8731","dJobECdNm":"[8731]육류·어패류·낙농품 가공기계 조작원","dJobJCd":"8113","dJobJCdNm":"[8113]육류·어패류 및 낙농품 가공 기계 조작원","dJobICd":"C105","dJobICdNm":"[C105]낙농제품 및 식용빙과류 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001828:1', '{"dJobCd":"K000001828","dJobCdSeq":"1","dJobNm":"유지제조중앙통제장치조작원","workSum":"유지 제조에 사용되는 배합기, 균질기, 살균기 등을 중앙통제장치에서 조작한다.","doWork":"유지 제조에 사용되는 배합기, 균질기, 살균기 등의 가동상태를 모니터링한다. 현장을 순찰하여 배합기, 균질기, 살균기 등의 가동상태를 확인한다. 작업 중에 발생하는 특이사항 등을 작업일지에 작성한다. 기계가 고장 나면 응급처리를 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8731","dJobECdNm":"[8731]육류·어패류·낙농품 가공기계 조작원","dJobJCd":"8113","dJobJCdNm":"[8113]육류·어패류 및 낙농품 가공 기계 조작원","dJobICd":"C105","dJobICdNm":"[C105]낙농제품 및 식용빙과류 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006679:1', '{"dJobCd":"K000006679","dJobCdSeq":"1","dJobNm":"육류박피기조작원","workSum":"예비박피된 육류의 몸체에서 가죽을 벗기는 박피기계를 조작한다.","doWork":"예비박피가 된 육류의 몸체를 호이스트(Hoist:소형의 몸체를 감아올리는 장치)나 쇠갈고리를 이용하여 운반한다. 박피기의 롤러(Roller) 사이에 가죽을 끼운다. 박피기를 가동하고 육류의 가죽이 롤러 사이로 말려들어가게 하여 가죽을 벗긴다. 박피된 가죽을 모아 창고로 운반하고 지육을 호이스트 체인(Hoist Chain)에 걸고, 모노레일(Monorail)이나 버킷컨베이어(Bucket Conveyor)를 이용하여 다음 공정으로 운반한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|고온|다습|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","similarNm":"제피기조작원","connectJob":"돼지박피기조작원, 소박피기조작원","dJobECd":"8731","dJobECdNm":"[8731]육류·어패류·낙농품 가공기계 조작원","dJobJCd":"8113","dJobJCdNm":"[8113]육류·어패류 및 낙농품 가공 기계 조작원","dJobICd":"C101","dJobICdNm":"[C101]도축, 육류 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006704:1', '{"dJobCd":"K000006704","dJobCdSeq":"1","dJobNm":"육류세절기조작원","workSum":"소시지를 제조하고자 절단기(Grinder)로 육류를 절단한다.","doWork":"절단기 호퍼(Hopper)의 뚜껑을 열고 각 부위별로 계량한 육류를 투입한다. 절단기를 가동하여 육류를 절단한다. 절단기의 배출구 아래에 운반용기를 놓아 절단된 육류를 담는다. 절단된 육류를 세절 및 혼합공정으로 이송한다. 물호스와 세척솔을 사용하여 절단기를 세척한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","similarNm":"육류분쇄원","dJobECd":"8731","dJobECdNm":"[8731]육류·어패류·낙농품 가공기계 조작원","dJobJCd":"8113","dJobJCdNm":"[8113]육류·어패류 및 낙농품 가공 기계 조작원","dJobICd":"C101","dJobICdNm":"[C101]도축, 육류 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005936:1', '{"dJobCd":"K000005936","dJobCdSeq":"1","dJobNm":"육류튀김원","workSum":"튀김육을 제조하고자 혼합기 및 튀김설비를 조작한다.","doWork":"자동 이송 컨베이어, 튀김기(Fryer), 튀김유 자동공급장치 등의 설비를 점검한다. 제품별로 일정한 모양으로 성형된 제품에 밀가루, 튀김가루, 빵가루 등의 튀김옷을 입힌다. 제품에 따라 온도, 시간 등을 조절하여 입력한다. 컨베이어가 튀김기를 통과하면 튀김이 진행되는 과정을 관찰하며 일정 온도에 따라 적절히 튀겨져 나오는지 점검한다. 불량품은 집어내어서 용기에 따로 적재한다. 완성된 제품을 냉동공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","dJobECd":"8731","dJobECdNm":"[8731]육류·어패류·낙농품 가공기계 조작원","dJobJCd":"8113","dJobJCdNm":"[8113]육류·어패류 및 낙농품 가공 기계 조작원","dJobICd":"C101","dJobICdNm":"[C101]도축, 육류 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003558:1', '{"dJobCd":"K000003558","dJobCdSeq":"1","dJobNm":"자연치즈전처리원","workSum":"자연치즈를 제조하고자 살균된 원유의 접종, 혼합, 응고, 절단 등에 사용하는 각종 설비를 조작·관리한다","doWork":"살균된 원유를 이송펌프를 조작하여 치즈제조탱크로 이송한다. 유산균이 적절하게 증식될 수 있도록 탱크의 온도를 일정수준까지 올린다. 동결 건조된 유산균을 원유가 들어 있는 치즈탱크에 일정량을 투여하고 교반기를 작동한다. 일정한 시간이 지난 후 물에 희석한 응유효소(凝乳酵素:레닛)를 탱크에 투여하고 우유와 응유효소가 잘 섞이도록 다시 교반기를 작동하여 교반한다. 교반이 완료된 후 저장시켜 응고상태를 확인한 후 탱크 안에 달린 커드칼을 작동하여 응고된 혼합물(우유와 유산균 등이 혼합·가공되어서 생긴 자연치즈의 주원료, 지방과 카세인으로 이루어진 커드(Curd)와 훼이(Whey:유청)가 혼합된 응고액)을 일정한 크기로 자른다. 커드 내 수분을 제거하고자 스팀밸브를 열어 일정한 온도로 가열한다. 커드에서 분리된 유청을 배출구를 통해 제거한다. 커드의 수분을 제거하고자 교반기를 고속으로 가동한다. 탱크에서 커드의 표본을 추출해서 손으로 커드의 엉켜 붙은 정도를 검사한 후 일정 정도의 응고상태가 된다고 판단되면 커드를 마무리저장조(Finish Vat)로 이송한다. 원유량, 예열온도 등을 작업일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|","workEnv":"다습|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8731","dJobECdNm":"[8731]육류·어패류·낙농품 가공기계 조작원","dJobJCd":"8113","dJobJCdNm":"[8113]육류·어패류 및 낙농품 가공 기계 조작원","dJobICd":"C105","dJobICdNm":"[C105]낙농제품 및 식용빙과류 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003314:1', '{"dJobCd":"K000003314","dJobCdSeq":"1","dJobNm":"자연치즈제조원","workSum":"젖산균, 응유효소와 산을 이용하여 우유 중의 카세인(Casein:치즈성분)을 응고시키고 부산물(Whey:훼이)을 제거하여 자연치즈를 제조한다.","doWork":"치즈제조 용기에 전유, 탈지유, 크림, 버터밀크 등의 원료를 계량하여 투입한다. 유산균(젖산균), 산 등의 스타터를 일정 비율로 투입한 후, 교반기를 가동하여 혼합한다. 일정 시간이 지나 커드(덩어리)와 유청(물)으로 분리되면 응유효소인 레닛(Rennet)을 첨가하여 카세인을 응고시킨다. 카세인이 응고되면 부산물인 수분을 배출시키거나 천을 사용하여 제거한다. 단단하게 굳은 커드를 절단기에 넣어 일정규격으로 절단한다. 절단한 카세인을 일정 산도가 되도록 숙성실에 넣어 숙성한다. 숙성이 완료되면 치즈에 식염을 첨가하고 일정한 형틀에 넣어 압착한다. 형틀을 제거하여 형태가 완료되면 보관대에 쌓아 숙성실로 운반한다. 숙성실의 치즈보관 상태를 파악하고 숙성 중의 변화를 관찰한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"청각|손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8731","dJobECdNm":"[8731]육류·어패류·낙농품 가공기계 조작원","dJobJCd":"8113","dJobJCdNm":"[8113]육류·어패류 및 낙농품 가공 기계 조작원","dJobICd":"C105","dJobICdNm":"[C105]낙농제품 및 식용빙과류 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006272:1', '{"dJobCd":"K000006272","dJobCdSeq":"1","dJobNm":"자연치즈후처리원","workSum":"전처리된 자연치즈용 커드(Curd)를 압착, 냉각, 성형, 가염, 숙성하고자 관련 기계 및 설비를 조작·관리한다.","doWork":"전처리과정을 거쳐서 마무리저장조(Finish Vat)로 이송된 커드의 양을 확인한다. 커드 중에 남아 있는 훼이(Whey:유청)를 분리할 수 있도록 커드를 마무리저장조 양쪽으로 분리한다. 커드알갱이가 균일한 조직을 가지면서 잘 뭉쳐지도록 일정한 온도 하에서 마무리저장조 내의 커드를 반복적으로 휘젓거나 뒤집어주면서 정기적으로 산도측정기로 커드의 산도(유산균 생성정도)를 측정한다. 커드의 산도가 기준치에 도달하면 더 이상의 유산균 생성을 멈추게 하고자 마무리저장조에 부착된 냉각밸브를 열고 냉각수를 커드에 투입한다. 냉각된 커드를 스트레칭기계의 투입구에 투입하고 기계를 작동하여 얇고 납작한 형태로 배출되는 치즈를 받아낸다. 스트레칭공정이 완료된 치즈를 일정한 형틀에 넣고 눌러서 빼내거나 성형기의 형틀에 부어서 성형기를 조작한 뒤 필요한 모양을 만든다. 성형된 치즈를 일정한 염도의 소금물에 규정된 시간동안 담궈 가염한다. 가염된 치즈를 종류에 맞는 온도와 습도를 제어조작하여 숙성시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"다습|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8731","dJobECdNm":"[8731]육류·어패류·낙농품 가공기계 조작원","dJobJCd":"8113","dJobJCdNm":"[8113]육류·어패류 및 낙농품 가공 기계 조작원","dJobICd":"C105","dJobICdNm":"[C105]낙농제품 및 식용빙과류 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003246:1', '{"dJobCd":"K000003246","dJobCdSeq":"1","dJobNm":"절육원","workSum":"증숙된 소고기나 돼지고기를 캔(Can)에 담기 위해 적당한 크기로 절단하고 분할한다.","doWork":"증숙(蒸熟:쪄서 익힘)된 고기를 작업대 위에 놓고 칼을 사용하여 일정한 크기로 절단한다. 절단한 고기를 캔에 담아 중량을 측정한다. 작업이 완료되면 밀봉기로 운반한다. 자동화된 기계를 사용하여 고기의 중량 등을 입력한다. 고기가 절단되고 캔에 담기는 과정을 관찰하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"시범후 30일 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|저온|다습|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","similarNm":"절육작업원","connectJob":"절육기조정판조작원","dJobECd":"8731","dJobECdNm":"[8731]육류·어패류·낙농품 가공기계 조작원","dJobJCd":"8113","dJobJCdNm":"[8113]육류·어패류 및 낙농품 가공 기계 조작원","dJobICd":"C101","dJobICdNm":"[C101]도축, 육류 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006068:1', '{"dJobCd":"K000006068","dJobCdSeq":"1","dJobNm":"절임액주입원","workSum":"햄의 원료인 육류에 맛과 향을 부여하고 보존성을 높이기 위하여 염지액(소금, 조미료, 향신료 등의 혼합물)을 주입하여 염지하는 기계를 조작한다.","doWork":"가공할 육류의 크기 및 종류에 따라 침지, 텀블러(Tumbler), 인젝션(Injection)방식 등 염지방법을 선정한다. 염지방식에 따라 염지액의 종류와 양, 기계의 주사바늘 수와 높이, 컨베이어(Conveyor)의 속도, 주입압력을 조절하거나 육류를 첨지시킬 염지탱크의 염지액 농도 및 염지시간을 조정판에서 조절한다. 컨베이어에 육류를 놓고 기계와 컨베이어를 가동한다. 염지액이 육류에 주입되는 과정을 관찰하며 제품의 종류에 따라 염지액의 투입속도를 조절한다. 컨베이어에 운반된 육류를 운반용기에 넣어 마사지 탱크(Massage Tank:질을 부드럽게 하기 위하여 육류끼리 부딪히게 하는 기계)로 운반한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"단미작업원, 염지원, 피클액주입원","connectJob":"침지염지원, 텀블러염지원, 인젝션염지원","dJobECd":"8731","dJobECdNm":"[8731]육류·어패류·낙농품 가공기계 조작원","dJobJCd":"8113","dJobJCdNm":"[8113]육류·어패류 및 낙농품 가공 기계 조작원","dJobICd":"C101","dJobICdNm":"[C101]도축, 육류 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002176:1', '{"dJobCd":"K000002176","dJobCdSeq":"1","dJobNm":"제피기조작원","workSum":"해체한 어육의 껍질을 벗기는 기계를 조작한다.","doWork":"제피기의 칼날, 압착고무대 및 롤러(Roller)의 상태를 점검하고 이물질 등을 제거한다. 칼날과 롤러 사이의 간격을 조절한다. 컨베이어를 가동하여 해체한 어육을 투입하고 제피되는 상태를 점검한다. 제피된 어육의 견본을 취하여 가공상태를 점검한다. 운반용기를 제피기의 배출구에 대고 어육을 받아 다음 공정으로 운반한다. 작업이 완료되면 물호스를 사용하여 기계에 부착된 이물질을 제거한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|저온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8731","dJobECdNm":"[8731]육류·어패류·낙농품 가공기계 조작원","dJobJCd":"8113","dJobJCdNm":"[8113]육류·어패류 및 낙농품 가공 기계 조작원","dJobICd":"C102","dJobICdNm":"[C102]수산물 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001441:1', '{"dJobCd":"K000001441","dJobCdSeq":"1","dJobNm":"조미반장","workSum":"생선, 굴, 명란 등의 맛을 내기 위하여 조미액을 제조하고 주액하는 조미액제조원의 활동을 감독·조정한다.","doWork":"작업일지를 확인하여 혼합할 고춧가루, 소금, 조미료, 향료, 색소 등의 원료를 점검하고 배합비를 확인한다. 조미된 수산물의 견본을 채취하여 맛, 향, 색상 등을 검사하고, 제품 표준과 비교한다. 작업내용에 따라 조미액제조원에게 지시·배치한다. 작업의 진행사항을 파악하고 작업내용을 보고한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원 및 자재를 공급한다. 작업계획에 따라 세부실행항목을 수립하고 작업절차 및 방법을 결정하여 작업원에게 작업내용을 지시하고 작업배치를 한다. 표준작업명세에 따라 지시된 작업이 이루어지는지 작업원과 함께 작업하며 작업상황을 관찰하고 작업내용을 점검한다. 작업원의 직무교육 및 안전위생교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴·해결하고 문제점을 보완한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|저온|다습|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","dJobECd":"8731","dJobECdNm":"[8731]육류·어패류·낙농품 가공기계 조작원","dJobJCd":"8113","dJobJCdNm":"[8113]육류·어패류 및 낙농품 가공 기계 조작원","dJobICd":"C102","dJobICdNm":"[C102]수산물 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006145:1', '{"dJobCd":"K000006145","dJobCdSeq":"1","dJobNm":"조미액제조원","workSum":"통조림의 조미액을 제조하고자 원료(설탕, 과당, 구연산, 소금 등)를 계량·용해·가열하는 장비를 조작한다.","doWork":"제품의 종류에 따라 첨가할 조미액의 종류를 확인한다. 설탕, 구연산, 과당, 소금, 간장 등의 첨가물을 계량한다. 계량한 원료를 일정 비율로 혼합탱크의 호퍼(Hopper)에 쏟는다. 급수밸브를 조절하여 혼합탱크에 일정량의 물을 투입한다. 호퍼의 뚜껑을 닫고 교반기를 가동하여 원료를 물에 용해시킨다. 용해가 용이하도록 증기밸브를 조절하여 혼합탱크의 재킷(Jacket)에 증기를 주입하여 가열한다. 용해가 완료되면 견본을 채취하여 산도, 당도, 염도 등을 측정한다. 하부의 배출밸브를 조절하여 조미액을 운반용기에 담거나 배관라인을 통하여 다음 공정으로 이송한다. 물호스나 세척솔을 사용하여 혼합탱크의 내부를 세척한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8731","dJobECdNm":"[8731]육류·어패류·낙농품 가공기계 조작원","dJobJCd":"8113","dJobJCdNm":"[8113]육류·어패류 및 낙농품 가공 기계 조작원","dJobICd":"C102","dJobICdNm":"[C102]수산물 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003731:1', '{"dJobCd":"K000003731","dJobCdSeq":"1","dJobNm":"조미액주액원","workSum":"충전한 통조림에 규정량의 조미액(음식의 맛을 알맞게 맞추는 액체)을 넣는 기계를 조작한다.","doWork":"제조된 조미액(소금물, 설탕물, 간장, 샐러드유, 토마토 퓌레 등)을 주액기의 저장탱크에 채운다. 조미액을 채울 통조림의 크기에 따라 노즐의 주입량을 조절한다. 컨베이어의 가동상태 및 내용물이 충전된 통조림의 이송상태를 확인한다. 주액기 노즐을 통해 통조림에 조미액이 충전되는 상태를 관찰한다. 주액이 완료된 통조림을 자동중량측정기로 통과시켜 중량을 점검한다. 제품규격에 중량이 미달되면 조미액을 보충하여 정량으로 채운다. 작업한 수량을 확인하여 일지에 기록하고 물호스나 세척솔을 사용하여 저장탱크의 내부를 청소한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|다습|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8731","dJobECdNm":"[8731]육류·어패류·낙농품 가공기계 조작원","dJobJCd":"8113","dJobJCdNm":"[8113]육류·어패류 및 낙농품 가공 기계 조작원","dJobICd":"C102","dJobICdNm":"[C102]수산물 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004513:1', '{"dJobCd":"K000004513","dJobCdSeq":"1","dJobNm":"집유원","workSum":"원유를 모으려고 목장을 돌면서 견본을 채취하고 집유기기를 조작하여 탱크트럭에 원유를 모은다.","doWork":"해당노선표를 확인하고 전표 등을 준비한다. 펌프, 유량계, 공기제거기 등 집유기기의 작동상태를 점검한다. 목장에 설치된 저장탱크의 냉각기 및 교반기의 가동상태를 확인한다. 저장탱크의 배출구에 집유기기를 장치하여 집유차 탱크(Tank)로 집유한다. 유량을 확인하고 전표를 작성한다. 실험실의 분석을 위하여 견본병에 원유를 채취한다. 집유작업이 끝나면 공장의 저장탱크에 원유를 하차하고 집유차 탱크와 집유기기를 물호스나 세척솔을 사용하여 세척한다. 집유 양을 작성·보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"저온|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8731","dJobECdNm":"[8731]육류·어패류·낙농품 가공기계 조작원","dJobJCd":"8113","dJobJCdNm":"[8113]육류·어패류 및 낙농품 가공 기계 조작원","dJobICd":"C105","dJobICdNm":"[C105]낙농제품 및 식용빙과류 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006050:1', '{"dJobCd":"K000006050","dJobCdSeq":"1","dJobNm":"치즈제조반장","workSum":"치즈를 제조하고자 우유에 젖산균을 접종하여 살균·가공·숙성하는 데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"제품의 종류에 따라 접종할 균의 종류나 양을 결정하고 작업인원을 파악한다. 일일 작업량과 소요된 자재의 양을 기록한다. 작업내용에 따라 작업원에게 지시·배치한다. 작업의 진행사항을 파악하고 작업내용을 보고한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원 및 자재를 공급한다. 작업계획에 따라 세부실행항목을 수립하고 작업절차 및 방법을 결정하여 작업원에게 작업내용을 지시하고 작업배치를 한다. 표준작업명세에 따라 지시된 작업이 이루어지는지 작업원과 함께 작업하며 작업상황을 관찰하고 작업내용을 점검한다. 작업원의 직무교육 및 안전위생교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴·해결하고 문제점을 보완한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","certLic":"식품가공기능사, 식품산업기사","dJobECd":"8731","dJobECdNm":"[8731]육류·어패류·낙농품 가공기계 조작원","dJobJCd":"8113","dJobJCdNm":"[8113]육류·어패류 및 낙농품 가공 기계 조작원","dJobICd":"C105","dJobICdNm":"[C105]낙농제품 및 식용빙과류 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001426:1', '{"dJobCd":"K000001426","dJobCdSeq":"1","dJobNm":"크림분리기조작원","workSum":"버터, 아이스크림 또는 기타 낙농품을 제조하고자 원유를 크림과 탈지유로 분리하는 원심분리기를 조작한다.","doWork":"수동공구를 사용하여 분리용 보울(Bowl)과 덮개를 원심분리기에 설치한다. 제품의 종류에 따라 원심분리기의 속도를 조절한 후, 원유저장탱크의 배출구를 열어 원유를 투입하고 분리기를 가동한다. 펌프를 가동하여 일정한 압력을 유지한다. 상부배출구를 열어 분리된 크림을 저장탱크로 이송하고 하부배출구를 열어 분리된 탈지유를 가공공정으로 이송한다. 작업이 완료되면 물호스를 사용하여 원심분리기의 내부와 작업장 주위를 청소한다. 자동화된 기계의 조정판에 분리기의 회전속도와 배출밸브의 개폐시간을 입력하여 크림이 분리되는 상태를 확인하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|다습|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8731","dJobECdNm":"[8731]육류·어패류·낙농품 가공기계 조작원","dJobJCd":"8113","dJobJCdNm":"[8113]육류·어패류 및 낙농품 가공 기계 조작원","dJobICd":"C105","dJobICdNm":"[C105]낙농제품 및 식용빙과류 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007192:1', '{"dJobCd":"K000007192","dJobCdSeq":"1","dJobNm":"통조림밀봉기조작원","workSum":"가공 처리된 내용물의 장기보존을 위하여 내용물을 담은 통조림관의 뚜껑을 밀봉하는 권체기(Seamer)를 조작한다.","doWork":"탈기공정을 거쳐 컨베이어로 운반되는 내부의 공기가 제거된 통조림의 속도를 조절한다. 권체기를 가동하고 통조림을 밀봉한다. 밀봉되어 나오는 통조림의 견본을 채취하고 밀봉측정기를 사용하여 밀봉상태가 작업표준과 일치하는지 확인한다. 제품의 밀봉상태가 불량이면 기계의 세팅(Setting)을 조절한다. 밀봉상태가 불량인 제품을 제거하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"권체기(券諦機)조작원","connectJob":"권체기조정판조작원, 이중권체기조작원, 진공권체기조작원","dJobECd":"8731","dJobECdNm":"[8731]육류·어패류·낙농품 가공기계 조작원","dJobJCd":"8113","dJobJCdNm":"[8113]육류·어패류 및 낙농품 가공 기계 조작원","dJobICd":"C101","dJobICdNm":"[C101]도축, 육류 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004515:1', '{"dJobCd":"K000004515","dJobCdSeq":"1","dJobNm":"통조림살균반장","workSum":"통조림의 내용물을 장기간 보존하고 변질을 방지하고자 살균하는 데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"작업장과 작업원의 위생상태를 점검한다. 살균탱크나 통조림의 살균시간을 수시로 점검한다. 작업한 제품의 종류와 수량을 작업일지에 기록한다. 작업내용에 따라 작업원에게 지시·배치한다. 작업의 진행사항을 파악하고 작업내용을 보고한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원 및 자재를 공급한다. 작업계획에 따라 세부실행항목을 수립하고 작업절차 및 방법을 결정하여 작업원에게 작업내용을 지시하고 작업배치를 한다. 표준작업명세에 따라 지시된 작업이 이루어지는지 작업원과 함께 작업하며 작업상황을 관찰하고 작업내용을 점검한다. 작업원의 직무교육 및 안전위생교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴·해결하고 문제점을 보완한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|고온|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","dJobECd":"8731","dJobECdNm":"[8731]육류·어패류·낙농품 가공기계 조작원","dJobJCd":"8113","dJobJCdNm":"[8113]육류·어패류 및 낙농품 가공 기계 조작원","dJobICd":"C101","dJobICdNm":"[C101]도축, 육류 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005655:1', '{"dJobCd":"K000005655","dJobCdSeq":"1","dJobNm":"통조림증숙원","workSum":"껍질이 벗겨지고 절단·세척된 원료(어패류, 과실류, 채소류)를 통조림으로 가공하고자 끓는 물이나 증기로 익혀 조리한다.","doWork":"이물질 및 농약 등의 제거를 위해 세정을 하고 먹을 수 없는 부분을 제거하여 적당한 크기와 모양으로 절단된 원료(어패류, 과실류, 채소류)의 중량을 측정하여 조리탱크나 압력탱크에 투입한다. 원료의 종류에 따라 증기밸브를 조절하여 조리에 적합한 온도 및 압력을 가한다. 원료의 종류에 따라 조리시간을 조정한다. 일정 시간이 지나 조리가 완료되면 조리물의 점도, 향, 색상 등을 검사하여 제품규격과 비교한다. 조리탱크의 배출밸브를 열어 이송관으로 이송하거나 운반용기에 담아 다음 공정으로 이송한다. 작업량을 일지에 기록하고 물호스와 세척솔을 사용하여 조리탱크 내부를 세척한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"농산물증숙원, 수산물증숙원, 육류증숙원","dJobECd":"8731","dJobECdNm":"[8731]육류·어패류·낙농품 가공기계 조작원","dJobJCd":"8113","dJobJCdNm":"[8113]육류·어패류 및 낙농품 가공 기계 조작원","dJobICd":"C101","dJobICdNm":"[C101]도축, 육류 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003721:1', '{"dJobCd":"K000003721","dJobCdSeq":"1","dJobNm":"통조림충전반장","workSum":"가공된 어패류를 빈 캔(Can)에 충진(充塡)하는 데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"작업장, 작업원의 위생상태를 점검하고 가공어패류의 종류를 확인한다. 충진(육힐)된 캔(can)의 견본을 채취하여 제품규격과 비교한다. 작업내용에 따라 작업원에게 지시·배치한다. 작업의 진행사항을 파악하고 작업내용을 보고한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원 및 자재를 공급한다. 작업계획에 따라 세부실행항목을 수립하고 작업절차 및 방법을 결정하여 작업원에게 작업내용을 지시하고 작업배치를 한다. 표준작업명세에 따라 지시된 작업이 이루어지는지 작업원과 함께 작업하며 작업상황을 관찰하고 작업내용을 점검한다. 작업원의직무교육 및 안전위생교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴·해결하고 문제점을 보완한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|저온|다습|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","similarNm":"육힐(肉詰)반장","dJobECd":"8731","dJobECdNm":"[8731]육류·어패류·낙농품 가공기계 조작원","dJobJCd":"8113","dJobJCdNm":"[8113]육류·어패류 및 낙농품 가공 기계 조작원","dJobICd":"C101","dJobICdNm":"[C101]도축, 육류 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001584:1', '{"dJobCd":"K000001584","dJobCdSeq":"1","dJobNm":"통조림충전원","workSum":"조리·가공한 내용물(어패류, 과실류, 채소류)을 일정량씩 계량하여 빈 캔(Can)에 충전하는 기계를 조작한다.","doWork":"삶거나 쪄 조리·가공한 충전할 내용물(어패류, 과실류, 채소류)의 종류를 확인한다. 크기별로 선별하고 이물질 등을 제거한다. 충전기에 정해진 내용량(고형물량 또는 내용총량)을 입력하여 설정한다. 기계를 가동하고 빈 캔에 내용물이 충전되는 것을 관찰한다. 견본을 채취하여 충전상태를 점검하고 중량이 부족한 캔을 선별하여 내용물을 채운다. 작업수량을 점검하여 작업일지에 기록한다. 물호스와 세척솔을 사용하여 호퍼나 연결호스를 세척한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|저온|다습|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"살재임원, 육힐원","dJobECd":"8731","dJobECdNm":"[8731]육류·어패류·낙농품 가공기계 조작원","dJobJCd":"8113","dJobJCdNm":"[8113]육류·어패류 및 낙농품 가공 기계 조작원","dJobICd":"C101","dJobICdNm":"[C101]도축, 육류 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003325:1', '{"dJobCd":"K000003325","dJobCdSeq":"1","dJobNm":"패류껍질제거원","workSum":"굴, 조개 등의 패류를 가공하고자 자숙(煮熟)하여 껍질을 제거하는 탈각기를 조작한다.","doWork":"탈각기의 각 부위를 점검하고 회전금속망에 부착된 이물질을 제거한다. 스팀밸브를 조절하여 탈각기탱크의 내부온도를 알맞게 조정한다. 탱크의 내부온도가 알맞게 상승하면 회전금속망을 가동하고 투입밸브를 조절하여 원료(패류)를 탈각기에 투입한다. 회전하는 금속망을 통하여 떨어지는 패류의 내용물과 껍질의 상태를 관찰한다. 스팀밸브를 재조절하여 탈각기탱크 내부온도를 일정하게 유지한다. 껍질이 제거되지 않은 패류를 선별하여 탈각기의 호퍼에 재투입한다. 작업이 완료되면 껍질은 폐기장으로 운반하고 탱크를 냉각하여 물을 제거한 후 원료(패류의 내용물)를 다음 공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|다습|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"패류탈각기조작원, 패류탈각원","dJobECd":"8731","dJobECdNm":"[8731]육류·어패류·낙농품 가공기계 조작원","dJobJCd":"8113","dJobJCdNm":"[8113]육류·어패류 및 낙농품 가공 기계 조작원","dJobICd":"C102","dJobICdNm":"[C102]수산물 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001798:1', '{"dJobCd":"K000001798","dJobCdSeq":"1","dJobNm":"편육기조작원","workSum":"냉동시킨 육류를 포장하고자 얇게 절단하는 기계를 조작·관리한다.","doWork":"육류 제품의 종류 및 두께에 따라 다이얼을 돌려 절단기의 간격을 조정한다. 냉동육류를 작업대 위로 운반한다 레버를 당겨 고기를 공급대 쪽으로 고정하고 공급기를 가동한다. 절단되어 나오는 육류의 수량을 확인하고 중량을 측정한다. 절단된 육류를 포장공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|저온|다습|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8731","dJobECdNm":"[8731]육류·어패류·낙농품 가공기계 조작원","dJobJCd":"8113","dJobJCdNm":"[8113]육류·어패류 및 낙농품 가공 기계 조작원","dJobICd":"C101","dJobICdNm":"[C101]도축, 육류 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006196:1', '{"dJobCd":"K000006196","dJobCdSeq":"1","dJobNm":"해동실작업원","workSum":"동결된 어육이나 가축육을 가공처리하기 위해 해동실을 관리하고 해동작업을 한다.","doWork":"냉동창고에서 작업할 어육이나 가축육을 운반하여 작업대 위에 올린다. 어육이나 가축육의 수량과 부위를 확인하고 박스 등 예비포장지를 제거한다. 해동할 원료육에 따라 해동실의 온도 및 시간 등 해동조건을 확인한다. 손수레나 운반용 밀차로 해동할 원료육을 운반하여 해동실 내부의 걸대에 지육을 걸거나 적재한다. 해동실 문을 닫고, 송풍스위치를 가동하여 일정 온도의 온풍을 불어 넣는다. 해동실의 유리창을 통해 해동과정을 관찰하면서 일정한 시간과 온도가 되면 해동실 문을 열고 해동된 어육이나 지육을 다음 공정으로 운반한다. 작업한 수량을 작업일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|저온|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"해동실관리원","dJobECd":"8731","dJobECdNm":"[8731]육류·어패류·낙농품 가공기계 조작원","dJobJCd":"8113","dJobJCdNm":"[8113]육류·어패류 및 낙농품 가공 기계 조작원","dJobICd":"C101/C102","dJobICdNm":"[C101]도축, 육류 가공 및 저장 처리업 / [C102]수산물 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001929:1', '{"dJobCd":"K000001929","dJobCdSeq":"1","dJobNm":"햄가공반장","workSum":"햄, 소시지, 베이컨 등을 제조하는 데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"제품을 생산하는 데 필요한 원료의 양을 계산하고 작업량에 따라 생산관리부서와 협의하여 작업원을 배치한다. 작업환경, 위생상태 등을 점검한다. 작업계획에 따라 세부실행항목을 수립하여 작업절차 및 방법을 결정한 후 작업원이 효율적으로 작업할 수 있도록 적당한 위치에 배정하고 작업내용을 작업원에게 지시한다. 작업진행상황을 파악하고 작업내용을 보고한다. 작업원의 작업상황을 관리·감독하고 작업공정에 있어 필요한 자재지원 및 기술을 지원한다. 표준명세에 따라 지시된 작업이 이루어지는지 작업원과 함께 작업하며 작업상황을 관찰하고 작업내용을 점검한다. 작업원에 대한 직무교육 및 안전위생교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시로 관찰과 면담을 통하여 작업원의 애로 및 건의사항을 수렴·해결하고 문제점을 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|고온|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","connectJob":"소시지가공반장","dJobECd":"8731","dJobECdNm":"[8731]육류·어패류·낙농품 가공기계 조작원","dJobJCd":"8113","dJobJCdNm":"[8113]육류·어패류 및 낙농품 가공 기계 조작원","dJobICd":"C101","dJobICdNm":"[C101]도축, 육류 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005611:1', '{"dJobCd":"K000005611","dJobCdSeq":"1","dJobNm":"햄충전기조작원","workSum":"햄을 제조하고자 혼합된 육류를 충전·포장하는 기계를 조작·관리한다.","doWork":"갈려진 원료육에 각종 첨가제가 혼합된 혼합육을 충전기의 호퍼(Hopper)에 투입한다. 제품의 규격에 따라 맞는 성형틀을 충전기의 배출구에 끼운다. 혼합육이 충전될 케이싱(Casing:소시지, 햄의 원료를 채워 넣는 데 쓰는 비닐 등 얇은 막의 재료)의 양을 확인하고 충전기의 노즐에 끼우거나 감는다. 조정판에 제품의 충전량을 입력한다. 충전기를 가동하고 충전과정을 관찰한다. 충전된 햄의 양끝을 결착하고 일정량씩 밀차(Trolly)에 걸어 훈제실로 운반한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"시범후 30일 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|다습|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","connectJob":"소시지충전기조작원","dJobECd":"8731","dJobECdNm":"[8731]육류·어패류·낙농품 가공기계 조작원","dJobJCd":"8113","dJobJCdNm":"[8113]육류·어패류 및 낙농품 가공 기계 조작원","dJobICd":"C101","dJobICdNm":"[C101]도축, 육류 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004151:1', '{"dJobCd":"K000004151","dJobCdSeq":"1","dJobNm":"향료배합원","workSum":"아이스크림, 빙과, 가공우유 등에 향료, 색소 등을 혼합하여 독특한 향을 부여하는 업무를 수행한다.","doWork":"제품에 따라 사용될 시럽, 버터, 과즙, 향료, 견과 등의 원료를 배합표에 따라 계량한다. 혼합통에 우유와 계량한 원료를 투입한 후, 교반기(혼합기)를 가동하여 혼합한다. 원료에 따라 가열하여 용해하기도 한다. 혼합된 원료를 저장탱크로 이송하거나 여과 및 균질공정 등 다음 공정으로 이송한다. 작업이 완료되면 용기와 장비를 소독하고 물호스를 사용하여 세척한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|저온|다습|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","similarNm":"향료실종사원","dJobECd":"8731","dJobECdNm":"[8731]육류·어패류·낙농품 가공기계 조작원","dJobJCd":"8113","dJobJCdNm":"[8113]육류·어패류 및 낙농품 가공 기계 조작원","dJobICd":"C105","dJobICdNm":"[C105]낙농제품 및 식용빙과류 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003868:1', '{"dJobCd":"K000003868","dJobCdSeq":"1","dJobNm":"과실농축원","workSum":"과실을 사용하여 잼, 넥타(Nectar:과육음료), 과즙음료 등을 제조하고자 과실액에 첨가물을 혼합하여 농축하는 기계를 조작·관리한다.","doWork":"생산할 제품을 확인하고 혼합탱크에 투입될 첨가물을 준비하고 혼합탱크 및 농축기의 조정판에 첨가물 투입량, 온도, 압력 등을 입력한다. 여과·분리공정을 거친 과즙을 혼합탱크에 투입하고 설탕, 포도당, 향료, 착색제 등의 첨가물을 작업표준에 따라 혼합탱크에 투입한다. 혼합탱크를 가동한 후 교반기가 가동되는지 확인하고 과즙과 첨가물의 혼합이 용이하게 이뤄지는지 관찰한다. 혼합이 완료되면 펌프를 가동하여 진공농축기로 이송하고 농축기를 가동한다. 압력계, 온도계를 수시로 확인하고 농축과정 시 생기는 수분을 배출한다. 농축이 완료되면 견본을 채취하여 농축도를 검사하고 일부를 실험실로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8734","dJobECdNm":"[8734]과실·채소 기계 조작원","dJobJCd":"8114","dJobJCdNm":"[8114]과실 및 채소 가공 관련 기계 조작원","dJobICd":"C103","dJobICdNm":"[C103]과실, 채소 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004771:1', '{"dJobCd":"K000004771","dJobCdSeq":"1","dJobNm":"과실착즙기조작원","workSum":"과실액을 제조하고자 과실을 분쇄하고 착즙하는 분쇄기, 착즙기를 조작·관리한다.","doWork":"제품별로 선별된 과실원료의 종류 및 수량을 확인하고 분쇄기의 칼날과 착즙기의 상태를 점검·조정한다. 컨베이어를 통해 분쇄기에 투입되는 과실 중에서 상태가 좋지 않은 과실을 선별한다. 과실이 투입되는 과정을 관찰하고 문제가 생기면 해결한다. 분쇄기와 착즙기를 가동한 후 착즙상태를 확인하여 필요시 재조정한다. 착즙된 과실즙은 여과공정으로 이송하고 찌꺼기는 폐기장으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8734","dJobECdNm":"[8734]과실·채소 기계 조작원","dJobJCd":"8114","dJobJCdNm":"[8114]과실 및 채소 가공 관련 기계 조작원","dJobICd":"C103","dJobICdNm":"[C103]과실, 채소 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002951:1', '{"dJobCd":"K000002951","dJobCdSeq":"1","dJobNm":"통조림재료세척원","workSum":"표면의 먼지, 흙 등의 이물질을 제거하고자 통조림 원료인 농·수산물을 세척용수(수돗물, 해수)로 세척한다.","doWork":"컨베이어를 통해 자동세척기(Rotary Washer)에 원료를 넣는다. 세척용수 밸브를 조작하여 컨베이어 상부에 장치된 노즐로 세척용수를 분사하여 원료를 세척한다. 세척된 원료를 버킷컨베이어(Bucket Conveyor)로 이송한다. 세척용수를 끌어 올리는 배관과 펌프를 점검한다. 세척된 원료를 바구니에 담아 물을 제거하기도 하며, 냉동된 수산물을 적정한 온도의 물로 해동하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"시범후 30일 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","dJobECd":"8734","dJobECdNm":"[8734]과실·채소 기계 조작원","dJobJCd":"8114","dJobJCdNm":"[8114]과실 및 채소 가공 관련 기계 조작원","dJobICd":"C101/C102/C103","dJobICdNm":"[C101]도축, 육류 가공 및 저장 처리업 / [C102]수산물 가공 및 저장 처리업 / [C103]과실, 채소 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003351:1', '{"dJobCd":"K000003351","dJobCdSeq":"1","dJobNm":"곡자제조원","workSum":"고량주, 주정 등의 알코올성 음료 제조 시 전분질 원료의 당화에 필요한 곡자(누룩)를 제조하고자 전분질 원료의 효소를 배양한다.","doWork":"곡자 제조에 필요한 물과 보리 등의 전분질 원료를 작업표준에 따라 곡자탱크에 일정 비율로 투입한 후 교반기를 가동하여 혼합한다. 곡자탱크의 온도가 일정하게 유지되는지 관찰하고 필요시 증기밸브를 돌려 순환관에 증기를 투입한다. 혼합한 원료를 일정 시간 가열하여 살균한 후 냉각한다. 작업표준에 따라 일정량의 종균을 원료에 접종한다. 종균접종이 완료되면 곡자실의 온도, 습도를 일정하게 유지하고 배양하여 곡자를 제조한다. 수시로 곡자실의 온도, 습도 등을 확인하여 배양이 순조롭게 이루어지는지 확인·점검한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"누룩제조원, 곡주제조원","dJobECd":"8735","dJobECdNm":"[8735]음료 제조기계 조작원","dJobJCd":"8120","dJobJCdNm":"[8120]음료 제조 관련 기계 조작원","dJobICd":"C111","dJobICdNm":"[C111]알코올음료 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001386:1', '{"dJobCd":"K000001386","dJobCdSeq":"1","dJobNm":"과립기조작원","workSum":"각종 차나 커피, 조미료 등의 과립(顆粒) 형태를 만들기 위하여 과립기(항습장치)를 조작·관리한다.","doWork":"분말원료의 입도(입자크기)를 검사한다. 과립성형이 용이하도록, 미세분쇄기를 이용하여 제품 표준에 규정된 아주 작은 입도의 차, 커피가루(조미료가루)로 분쇄한다. 미세하게 분쇄된 차, 커피가루(조미료가루)를 과립기(항습장치)의 호퍼(Hopper)에 투입한 후, 과립기의 운전상태가 작업표준과 일치하는지를 점검한다. 과립기(항습장치)를 작동시켜 증기를 뿌리면서 차, 커피가루(조미료가루)들이 수증기와 엉켜 일정한 크기의 과립(顆粒:Granule) 형태가 되도록 한다. 제품 표준보다 굵은 과립을 분리하고자 사별기를 가동한 후, 걸러진 굵은 과립은 다시 미쇄분쇄기에 투입한다. 규정에 맞는 과립들을 저장탱크로 자동 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"조미료과립기조작원, 커피과립기조작원","certLic":"식품산업기사, 식품가공기능사","dJobECd":"8735","dJobECdNm":"[8735]음료 제조기계 조작원","dJobJCd":"8120","dJobJCdNm":"[8120]음료 제조 관련 기계 조작원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001763:1', '{"dJobCd":"K000001763","dJobCdSeq":"1","dJobNm":"과립음료제조원","workSum":"과립음료를 제조하고자 과립농축액, 설탕, 향료와 기타 첨가물을 혼합하고 살균·탈기·균질하는 기계를 조작한다.","doWork":"음료에 첨가할 과립을 선별한 후 저울을 사용하여 계량한다. 혼합탱크를 투입구에 계량한 과립을 넣고 일정 비율의 설탕, 향료, 색소 등의 첨가물을 투입한다. 교반기를 가동하여 혼합한 후 밸브를 열어 탈기장치, 균질기, 열교환기로 시럽을 이송한다. 제조된 시럽을 과립충전탱크로 이송하여 과립과 시럽을 일정 비율로 혼합한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|다습|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8735","dJobECdNm":"[8735]음료 제조기계 조작원","dJobJCd":"8120","dJobJCdNm":"[8120]음료 제조 관련 기계 조작원","dJobICd":"C112","dJobICdNm":"[C112]비알코올음료 및 얼음 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001326:1', '{"dJobCd":"K000001326","dJobCdSeq":"1","dJobNm":"글루타민산발효균배양원","workSum":"화학조미료에 사용하는 글루타민산나트륨(MSG)을 배양시키기 위하여 배양조에 종균을 접종하여 발효·배양한다.","doWork":"배양조를 고온으로 살균하고자 증기밸브를 돌려 재킷(Jacket)에 증기를 주입한다. 배양조의 상부밸브를 열어 일정량의 배양배지를 투입하고, 살균이 완료되면 냉각수 밸브를 열어 배양조의 순환관에 냉각수를 투입하여 종균이 배양할 수 있는 최적 온도를 유지한다. 배양조의 뚜껑을 열고 식균기로 실험실에서 배양한 종균을 접종(接種)한다. 종균과 배양배지의 혼합이 용이하도록 저속의 교반기를 일정 시간 동안 가동한다. 배양이 완료되면 본 배양을 하고자 2차 배양배지로 배양액을 이송한다. 본 배양에 적합한 온도와 산도(pH)를 유지하여 배양액 내의 글루타민산나트륨을 축적시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"본배양조조작원, 전배양조조작원","certLic":"식품산업기사, 식품가공기능사","dJobECd":"8735","dJobECdNm":"[8735]음료 제조기계 조작원","dJobJCd":"8120","dJobJCdNm":"[8120]음료 제조 관련 기계 조작원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005499:1', '{"dJobCd":"K000005499","dJobCdSeq":"1","dJobNm":"냉동건조커피제조원","workSum":"냉동건조커피(입자커피)를 제조하고자 동결건조기(냉동건조기, 식품 등의 보존이나 운반을 편하게 하기 위해서 냉동시킨 후 수분을 증발시키는 기계)를 조작·관리한다.","doWork":"커피농축액 저장탱크의 유량계를 확인한 후 견본을 채취하여 수분함유량을 점검한다. 자동화된 기계의 조정판에 동결(凍結) 온도와 시간 등을 입력한다. 저장탱크의 배출밸브를 열어 농축된 커피액을 일정량씩 동결시킨다. 동결된 커피액을 일정한 크기로 분쇄하여 진공건조기로 투입한 후 수분을 증발시킨다. 이때 기압을 낮춰서 고체 상태의 물이 기체로 승화할 수 있게 하는데 이 과정을 통해 커피 향의 손실을 최소화한다. 수시로 견본을 채취하여 수분함유량을 검사한다. 냉동 건조된 커피분말을 저장탱크의 호퍼(Hopper)에 투입한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"동결건조기조정판조작원","certLic":"식품산업기사, 식품가공기능사","dJobECd":"8735","dJobECdNm":"[8735]음료 제조기계 조작원","dJobJCd":"8120","dJobJCdNm":"[8120]음료 제조 관련 기계 조작원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004512:1', '{"dJobCd":"K000004512","dJobCdSeq":"1","dJobNm":"담금발효원","workSum":"맥주를 제조하고자 제근된 맥아를 파쇄·당화·냉각·발효·여과하는 장치를 조작·관리한다.","doWork":"제근된 맥아를 발효시키기 위해 파쇄기, 당화조, 냉각기, 발효조, 여과기 등의 작동상태를 점검하고 수시로 공장을 순시하여 이상 유무를 확인한다. 전체적인 공정을 중앙통제실(CCR)에서 통제·조절하며 중앙통제실의 호출이 있을 때 현장으로 이동하여 장치의 이상유무를 살피고 조절한다. 맥아, 전분질부원료, 양조용수, 효모 등의 공급상황을 점검하고 문제발생 시 신속히 조치한다. 발효가 완료된 반제품을 여과하고자 여과기의 상태를 점검하고 여과포나 규조토를 교체한다. 당화가 완료된 원료를 발효조에 투입하고 일정 비율의 효모균을 투입한다. 발효실의 온도, 압력, 발효시간, 습도 등이 작업표준과 일치하는지 확인하고 규정된 기간 동안 발효시킨다. 발효가 완료되면 발효탱크의 배출밸브를 열고 이송펌프를 가동하여 증류탑으로 이송한다. 발효상태를 수시로 검사하고 필요한 조치를 취한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"맥주발효원, 사입원","dJobECd":"8735","dJobECdNm":"[8735]음료 제조기계 조작원","dJobJCd":"8120","dJobJCdNm":"[8120]음료 제조 관련 기계 조작원","dJobICd":"C111","dJobICdNm":"[C111]알코올음료 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005121:1', '{"dJobCd":"K000005121","dJobCdSeq":"1","dJobNm":"맥아제조원","workSum":"맥주를 제조하고자 대맥을 선별, 침맥, 발아, 배조, 제근하는 장치를 조작·관리한다.","doWork":"원맥을 발아시키기 위해 정선기, 정립기, 정수기, 탈근기 등의 작동상태를 점검하고 수시로 공장을 순시하여 이상 유무를 확인한다. 전체적인 공정은 중앙통제실(CCR)에서 통제·조절되며 중앙통제실의 호출이 있을 때에 현장으로 이동하여 장치의 이상 유무를 살피고 조절한다. 급수상태를 확인하고 침지된 원맥을 고르게 펴주거나 원맥을 섞어주는 장치를 가동한다. 발아상태를 수시로 확인하고 발아가 완료된 맥아를 건조실로 이송한다. 건조된 맥아를 저장창고에 입고시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"맥아발아원, 맥아제근원, 제맥공정운전원, 침맥원","dJobECd":"8735","dJobECdNm":"[8735]음료 제조기계 조작원","dJobJCd":"8120","dJobJCdNm":"[8120]음료 제조 관련 기계 조작원","dJobICd":"C111","dJobICdNm":"[C111]알코올음료 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004110:1', '{"dJobCd":"K000004110","dJobCdSeq":"1","dJobNm":"맥주양조사","workSum":"맥주양조책임자가 작성한 맥주제조법에 맞게 주재료를 관리·감별하고 맥주 제조공정을 관리하며 양조장비의 작동, 세척, 살균, 관리 등을 통해 맥주를 완성하고 품질을 관리한다.","doWork":"맥주의 원부자재인 맥아, 홉, 효모, 물, 부가물 등을 관리한다. 맥주제조법에 맞게 맥아를 분쇄한 뒤 당화조, 여과조를 거쳐 맥즙을 생산하고 이를 끓임조에 넣은 후 홉을 투입한다. 열교환기를 거쳐 냉각된 맥즙을 발효조에 주입하고 효모를 첨가하여 발효와 숙성공정을 거치게 한다. 완성된 맥주의 생산하고 제품을 포장한다. 맥주의 품질관리와 위생을 위해 양조장비의 세척 살균업무를 수행한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실내","workEnv":"고온|다습|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"맥주양조기술자, 수제맥주양조사, 브루어(Brewers)","certLic":"주류제조관리사","dJobECd":"8735","dJobECdNm":"[8735]음료 제조기계 조작원","dJobJCd":"8120","dJobJCdNm":"[8120]음료 제조 관련 기계 조작원","dJobICd":"C111","dJobICdNm":"[C111]알코올음료 제조업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002977:1', '{"dJobCd":"K000002977","dJobCdSeq":"1","dJobNm":"보리엑기스추출원","workSum":"보리음료를 제조하고자 사용되는 보리의 엑기스를 추출하는 기계를 조작·관리한다.","doWork":"추출기의 작동상태의 이상 유무와 조정판의 온도 및 압력 값이 제대로 입력되었는지 확인한다. 컨베이어나 공기송풍기를 통해 이송된 볶은 보리를 물과 함께 추출기에 투입한다. 추출기를 가동하고 추출기 내의 압력과 온도가 일정하게 유지되는지 관찰한다. 추출이 완료되면 견본을 채취하여 엑기스의 농도를 검사하고 일부를 실험실로 보낸다. 탱크 내에 남은 보리찌꺼기를 폐기장으로 운반한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"향료추출원","dJobECd":"8735","dJobECdNm":"[8735]음료 제조기계 조작원","dJobJCd":"8120","dJobJCdNm":"[8120]음료 제조 관련 기계 조작원","dJobICd":"C111","dJobICdNm":"[C111]알코올음료 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005621:1', '{"dJobCd":"K000005621","dJobCdSeq":"1","dJobNm":"분말기조작원","workSum":"각종 차, 커피의 분말을 만들기 위하여 배전·배합·분쇄·추출하는 기계의 조정판을 관찰·조절한다.","doWork":"자동화된 기계의 조정판에 각종 차, 커피원두의 투입량, 물의 급수량, 추출기의 가열온도·가열시간, 추출액의 여과기투입량, 농축기의 가열온도·가열시간 등을 입력한다. 조정판의 모니터를 통하여 각종 차, 커피원두의 투입상태를 확인하고 작업순서에 따라 각 공정의 스위치를 조절한다. 일정 시간마다 견본을 채취하여 색상, 농도 등을 제품 표준과 비교·검사한다. 검사한 자료를 토대로 최적의 추출이 이루어지도록 조정판의 스위치를 재조절한다. 조정판의 모니터를 확인하여 이상이 발생하면 기계의 가동을 중지하고 현장을 확인하거나 조정판의 스위치를 재조절한다. 추출·농축에 투입된 각종 차, 커피원두의 수량과 작업조건 등을 작업일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"식품산업기사, 식품가공기능사","dJobECd":"8735","dJobECdNm":"[8735]음료 제조기계 조작원","dJobJCd":"8120","dJobJCdNm":"[8120]음료 제조 관련 기계 조작원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006097:1', '{"dJobCd":"K000006097","dJobCdSeq":"1","dJobNm":"소주제성원","workSum":"주정(에틸알코올)을 소주로 제조하고자 희석탱크, 여과기, 배합기 등의 장치를 조작·관리한다.","doWork":"주정, 희석탱크, 여과기, 배합기, 활성탄, 급수상태 등을 확인·점검한다. 제품 종류를 확인하고 작업표준에 따라 조정판의 입력값을 확인·수정한다. 주정 저장탱크로부터 이송되어 온 주정을 희석탱크에 물과 일정 비율로 투입하고 희석되는 과정을 관찰한다. 불순물을 제거하고자 희석탱크에 일정량의 분말활성탄을 투입하고 에어교반기를 가동한다. 희석, 탈취, 여과 과정을 거친 주정을 제품의 알코올도수에 맞게 희석시키기 위하여 희석탱크의 조정판을 확인·수정하고 가동한다. 첨가물 탱크에서 배합된 첨가물과 희석이 완료된 주정을 배합탱크에서 배합하고자 조정판을 확인·수정·가동한다. 배합이 완료되어 여과기를 통과한 소주의 견본을 채취하여 관능검사 및 성분검사를 하고 숙성실로 이송한다. 탈취 및 여과를 위하여 사용되는 활성탄과 여과기의 상태 등을 점검한 후 교체한다. 전체적인 공정은 중앙통제실(CCR)에서 통제·조절되기도 하며 중앙통제실의 호출이 있을 때에 현장으로 이동하여 장치의 이상 유무를 살피고 조절한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"증류식소주제성원, 희석식소주제성원","dJobECd":"8735","dJobECdNm":"[8735]음료 제조기계 조작원","dJobJCd":"8120","dJobJCdNm":"[8120]음료 제조 관련 기계 조작원","dJobICd":"C111","dJobICdNm":"[C111]알코올음료 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002334:1', '{"dJobCd":"K000002334","dJobCdSeq":"1","dJobNm":"시럽제조원","workSum":"향미료액 및 시럽(Syrup)을 제조하고자 조제탱크에 원료, 부원료, 기타 첨가제를 투입하여 교반·용해시켜 조제액을 제조한다.","doWork":"제품의 종류에 따라 혼합할 원료(과즙, 설탕, 향료)를 선별한 후 계량용기를 사용하여 계량한다. 혼합탱크의 뚜껑을 열어 계량한 원료를 투입하고 급수밸브를 조절하여 일정 비율의 물을 급수한다. 작업표준서에 따라 원료를 순서대로 투입한 후 일정 시간 교반·용해한다. 증기밸브를 열고 순환관이나 재킷(Jacket)에 증기를 투입하여 일정 온도로 가열한다. 냉각밸브를 열어 조제탱크액을 일정 온도까지 냉각시킨 후 첨가제를 투입하고 교반한다. 일정 시간 교반한 후 냉각수 밸브를 열고 일정 온도까지 냉각한다. 최종 첨가제를 투입하고 조제 용수밸브를 열어 총 부피를 조절한다. 조제가 완료되면 견본을 채취하여 액의 pH를 측정한다. 완료되면 견본을 채취하여 품질관리부서에 보낸다. 검사결과를 통보받고 충전실(충진실)로 이송한다. 견본을 채취하여 맛, 향, 농도 등을 검사하고 제품 표준과 비교한다. 작업이 완료되면 혼합탱크의 배출구를 열고 펌프를 가동하여 제조한 시럽을 저장탱크로 이송한다. 물호스와 세척솥을 사용하여 혼합탱크 내부의 이물질을 세척한다. 시럽을 여과하여 불순물을 제거하기도 한다. 가공하지 않은 시럽을 배합하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|다습|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8735","dJobECdNm":"[8735]음료 제조기계 조작원","dJobJCd":"8120","dJobJCdNm":"[8120]음료 제조 관련 기계 조작원","dJobICd":"C112","dJobICdNm":"[C112]비알코올음료 및 얼음 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004060:1', '{"dJobCd":"K000004060","dJobCdSeq":"1","dJobNm":"연속증류탑조작원","workSum":"주정을 생산하고자 발효가 끝난 술덧(술밑)에서 주정분을 분리하는 연속증류기를 조작·관리한다.","doWork":"중앙통제실(CCR)에서 통제되는 증류기의 작동과 원료의 이송을 관찰한다. 수시로 술덧예열탑, 초류탑, 초류탈수탑, 추출탑, 정제탑, 제품탑, 불량주류탑 등 각 탑에 부착된 유량계, 온도계, 압력계 등을 관찰하고 주정의 흐름을 일정하게 유지하고자 이송 펌프나 증기밸브를 조절한다. 증류탑의 상태를 검사·관찰하고 문제발생 시 중앙통제실로부터 연락을 받고 현장으로 가 조치를 취한다. 중앙통제실에서 근무하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|고온|다습|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8735","dJobECdNm":"[8735]음료 제조기계 조작원","dJobJCd":"8120","dJobJCdNm":"[8120]음료 제조 관련 기계 조작원","dJobICd":"C111","dJobICdNm":"[C111]알코올음료 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001566:1', '{"dJobCd":"K000001566","dJobCdSeq":"1","dJobNm":"음료혼합기조작원","workSum":"탄산음료, 탄산과실음료 등 청량음료를 제조하고자 물, 시럽, 이산화탄소(CO2)를 혼합하는 기계를 조작·관리한다.","doWork":"여과 및 살균된 물과 시럽원료를 계량하여 혼합기에 규정된 비율로 투입한다. 교반기를 작동하여 일정 시간 혼합하고 견본을 채취한다. 당도계를 사용하여 혼합물의 당도를 검사한다. 이산화탄소를 주입하기 전 이산화탄소의 용해도를 증가시키기 위해 혼합물을 냉각시킨다. 혼합물을 고압탱크로 이송하고 고압탱크 내 이산화탄소를 주입한다. 이산화탄소의 주입이 완료되면 견본을 채취하여 탄산가스의 함유량을 검사하고 제품 표준과 비교·검사한다. 작업이 완료되면 고압탱크의 배출구를 열고 펌프를 가동하여 혼합액을 저장탱크로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|저온|다습|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"과실음료혼합원, 섬유음료혼합원, 이온음료혼합원, 탄산음료혼합원","dJobECd":"8735","dJobECdNm":"[8735]음료 제조기계 조작원","dJobJCd":"8120","dJobJCdNm":"[8120]음료 제조 관련 기계 조작원","dJobICd":"C111/C112","dJobICdNm":"[C111]알코올음료 제조업 / [C112]비알코올음료 및 얼음 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004851:1', '{"dJobCd":"K000004851","dJobCdSeq":"1","dJobNm":"인삼차제조원","workSum":"인삼차를 제조하고자 인삼농축액과 각종 원료(포도당, 유당 등)를 혼합·과립·건조·사별하는 기계를 조작·관리한다.","doWork":"제품의 종류에 따라 혼합할 원료를 선별한 후 일정량의 원료와 인삼농축액을 혼합기에 투입한다. 혼합이 용이하도록 교반기를 가동하고, 견본을 채취하여 혼합상태를 점검한다. 혼합이 완료되면 혼합기의 배출밸브를 열고 혼합된 원료를 과립기(항습장치)로 이송한다. 과립기의 호퍼(Hopper)에 혼합된 원료를 투입한 후, 과립기를 가동해 노즐에서 습한 증기가 나오도록 한다. 혼합된 원료들이 수증기와 엉켜 일정한 크기의 과립(顆粒:Granule) 형태가 되도록 한다. 제품 표준보다 굵은 과립을 분리하고자 사별기를 가동한 후, 걸러진 굵은 과립은 다시 미세분쇄기에 투입한다. 규정에 맞는 과립들이 건조기를 거쳐 저장탱크로 가도록 자동 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"식품산업기사, 식품가공기능사","dJobECd":"8735","dJobECdNm":"[8735]음료 제조기계 조작원","dJobJCd":"8120","dJobJCdNm":"[8120]음료 제조 관련 기계 조작원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001288:1', '{"dJobCd":"K000001288","dJobCdSeq":"1","dJobNm":"입국제조원","workSum":"탁주, 약주 제조 시 전분질 원료의 당화(전분이나 섬유소와 같은 다당류를 효소나 산의 작용으로 가수분해해서 단당류 또는 이당류로 변화시키는 것)에 필요한 효소를 생산하고자 입국미에 종국(곰팡이)을 배양한다.","doWork":"입국실의 온도 및 습도를 배양에 적합하도록 일정하게 유지한다. 삽을 사용하여 증자된 밀가루, 밀쌀, 찹쌀 등의 전분질 원료를 보자기(천) 위에 고르게 편다. 적당량의 종국을 고르게 뿌려 삽으로 원료를 뒤집고, 적정 온도를 유지하고자 보자기로 덮는다. 일정 시간 후 보자기를 펴서 삽으로 뒤집어 섞은 후 보자기로 덮는다. 종국 배양이 완료되면 견본을 채취하여 입국의 배양상태를 검사하고 제품 표준과 비교한다. 제조된 입국을 운반용기를 사용하여 주모실과 사입실로 운반한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|고온|다습|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8735","dJobECdNm":"[8735]음료 제조기계 조작원","dJobJCd":"8120","dJobJCdNm":"[8120]음료 제조 관련 기계 조작원","dJobICd":"C111","dJobICdNm":"[C111]알코올음료 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002978:1', '{"dJobCd":"K000002978","dJobCdSeq":"1","dJobNm":"제국기조작원","workSum":"청주를 양조하고자 증자된 쌀에 곰팡이류(황국균)를 번식시키는 제국기를 조작·관리한다.","doWork":"종국이 혼합된 증미가 제국기에 일정량 투입되는지 관찰한다. 조정판을 조작하여 곰팡이의 배양이 용이하도록 제국기 내부의 온도와 습도, 교반기의 속도를 입력한다. 제국기 내부의 상태를 관찰한다. 저속의 교반기를 가동한다. 제국기 내부의 온도와 습도가 일정하게 유지되는지 관찰하고 필요시 조정판의 값을 변경한다. 수시로 견본을 채취하여 배양상태를 검사하고 제품 표준과 비교한다. 배양이 완료되면 공기이송기를 가동하여 주모실과 담금실로 황국균이 배양된 증미를 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|다습|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8735","dJobECdNm":"[8735]음료 제조기계 조작원","dJobJCd":"8120","dJobJCdNm":"[8120]음료 제조 관련 기계 조작원","dJobICd":"C111","dJobICdNm":"[C111]알코올음료 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005424:1', '{"dJobCd":"K000005424","dJobCdSeq":"1","dJobNm":"제핵기조작원","workSum":"과실주스나 음료 및 통조림 등을 제조하고자 과실의 씨를 제거하는 제핵기를 조작·관리한다.","doWork":"생산할 제품을 확인하고 여과망이나 칼날 등 제핵기의 설비를 조정한다. 과실이 제핵기에 투입되기 전 가동상태를 점검한 후 절단기를 통과하여 컨베이어를 통해 이송된 과실의 절단상태를 확인하고 제핵기에 잘 투입되는지 확인·관찰한다. 과실의 씨와 과실육의 분리가 이루어지는지를 확인하고 분리상태에 따라 제핵기를 조정한다. 낡은 절단용 칼이나 여과망을 수리하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|다습|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8735","dJobECdNm":"[8735]음료 제조기계 조작원","dJobJCd":"8120","dJobJCdNm":"[8120]음료 제조 관련 기계 조작원","dJobICd":"C103","dJobICdNm":"[C103]과실, 채소 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002644:1', '{"dJobCd":"K000002644","dJobCdSeq":"1","dJobNm":"주류배합원","workSum":"위스키, 브랜디 등과 같은 증류주(혼성주)를 제조하고자 원액을 배합·숙성·여과하는 설비를 조작·관리한다.","doWork":"제품의 종류와 품질에 따라 배합할 원액의 종류를 선별한 후 펌프를 가동하여 혼합탱크로 이송한다. 조정판에 각 원료의 혼합비를 입력하고 배합기를 가동한다. 배합이 완료되면 견본을 채취하여 작업표준과 비교한다. 이물질 등을 침전시키고, 제품에 따라 맛과 향이 증가되도록 일정 시간 동안 숙성시킨다. 여과포나 여과망을 여과기에 설치하고 펌프를 가동하여 배합액을 여과기로 이송한다. 여과가 완료된 배합액을 병에 주입하고자 주입기의 저장탱크로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"주류제조관리사","dJobECd":"8735","dJobECdNm":"[8735]음료 제조기계 조작원","dJobJCd":"8120","dJobJCdNm":"[8120]음료 제조 관련 기계 조작원","dJobICd":"C111","dJobICdNm":"[C111]알코올음료 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001315:1', '{"dJobCd":"K000001315","dJobCdSeq":"1","dJobNm":"주모제조원","workSum":"탁주, 약주, 청주 등을 양조하고자 밀가루, 밀쌀, 찹쌀 등의 전분질 원료를 발효시키는 효모를 배양한다.","doWork":"주모탱크에 펌프를 가동하여 입국과 물을 일정 비율로 투입한다. 자동계량된 효모를 주모탱크에 일정량 투입한다. 배양이 용이하게 이루어지도록 주모탱크 내부의 산소함량과 배양온도가 일정하게 유지되는지 등을 확인·관찰한다. 수시로 견본을 채취하여 배양상태를 점검한다. 배양이 완료되면 주모탱크의 배출구를 열고 펌프를 가동하여 다음 공정으로 배양액을 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|저온|다습|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8735","dJobECdNm":"[8735]음료 제조기계 조작원","dJobJCd":"8120","dJobJCdNm":"[8120]음료 제조 관련 기계 조작원","dJobICd":"C111","dJobICdNm":"[C111]알코올음료 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005169:1', '{"dJobCd":"K000005169","dJobCdSeq":"1","dJobNm":"주정침지원","workSum":"청주를 제조하고자 백미에 포함된 이물질을 제거하고 물에 침지하는 탱크를 조작·관리한다.","doWork":"저장탱크에서 배출된 백미를 자동계량기를 통해 계량하고 컨베이어를 사용하여 세척탱크에 투입한다. 세척탱크의 급수밸브를 열어 일정량의 물을 급수한 후 세척한다. 배출구를 열어 이물질이 포함된 물을 배수하고 재세척한다. 세척이 완료되면 세척탱크 배출구를 열고 펌프를 가동하여 침지탱크에 세척한 백미를 이송한다. 일정량의 물을 급수하여 백미의 종류에 따라 규정된 시간 동안 침지한다. 수시로 견본을 채취하여 백미의 수분함량을 검사하고 제품 표준과 비교한다. 침지가 완료되면 배출구를 열고 컨베이어를 이용하여 다음 공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"시범후 30일 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|다습|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8735","dJobECdNm":"[8735]음료 제조기계 조작원","dJobJCd":"8120","dJobJCdNm":"[8120]음료 제조 관련 기계 조작원","dJobICd":"C111","dJobICdNm":"[C111]알코올음료 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002956:1', '{"dJobCd":"K000002956","dJobCdSeq":"1","dJobNm":"증류기조작원","workSum":"발효·숙성된 원료액에서 브랜디, 위스키, 주정 등의 알코올을 추출하고자 증류기를 조작·관리한다.","doWork":"압력계, 온도계, 유량계, 응축기, 공급증기, 진공펌프 등을 점검하고 공정순서에 따라 제어장치를 점검한다. 발효·숙성된 원료액을 이송 받아 증류기의 저장탱크에 저장한다. 조정판에 압력, 온도, 시간 등 조정값을 입력하고 증류기를 가동한다. 증류상태, 냉각상태, 미증류분의 재증류 상태 등을 관찰·점검한다. 냉각기를 통과한 알코올 원액을 펌프를 가동하여 저장탱크로 이송한다. 견본을 채취하여 알코올도수를 검사하고 제품 표준과 비교한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|다습|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"맥아증류기조작원","dJobECd":"8735","dJobECdNm":"[8735]음료 제조기계 조작원","dJobJCd":"8120","dJobJCdNm":"[8120]음료 제조 관련 기계 조작원","dJobICd":"C111","dJobICdNm":"[C111]알코올음료 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001634:1', '{"dJobCd":"K000001634","dJobCdSeq":"1","dJobNm":"증류반장","workSum":"주정, 고량주, 위스키 등의 술을 증류하는 일에 종사하는 작업원의 활동을 감독·조정한다.","doWork":"일일 작업량을 확인하고 작업원에게 주의사항을 알린다. 증류기와 중앙통제실의 작동상태를 점검하고 가열설비를 확인한다. 생산된 증류주의 수량과 알코올함량을 작업표준과 확인한다. 작업내용에 따라 작업원에게 지시·배치한다. 작업의 진행사항을 파악하고 작업내용을 보고한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원 및 자재를 공급한다. 작업계획에 따라 세부실행항목을 수립하고 작업절차 및 방법을 결정하여 작업원에게 작업내용을 지시하고 작업배치를 한다. 표준작업명세에 따라 지시된 작업이 이루어지는지 작업원과 함께 작업하며 작업상황을 관찰하고 작업내용을 점검한다. 작업원의 직무교육 및 안전위생교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴·해결하고 문제점을 보완한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|고온|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","dJobECd":"8735","dJobECdNm":"[8735]음료 제조기계 조작원","dJobJCd":"8120","dJobJCdNm":"[8120]음료 제조 관련 기계 조작원","dJobICd":"C111","dJobICdNm":"[C111]알코올음료 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001815:1', '{"dJobCd":"K000001815","dJobCdSeq":"1","dJobNm":"증류솥조작원","workSum":"고량주의 원액을 제조하고자 술덧에서 알코올성분을 추출하는 증류솥을 조작·관리한다.","doWork":"숙성탱크의 견본을 채취하여 술덧의 발효상태를 점검한 후 펌프를 가동하여 증류솥에 투입한다. 증류솥 내부의 온도가 일정하게 유지되는지 확인하고 필요시 증기밸브를 조작한다. 끓는점(비점)에 따른 증류와 냉각이 원활히 이루어지는지 관찰·확인하고 제품의 순도를 높이기 위한 재순환이 용이하게 이루어지는지 확인·점검한다. 수시로 알코올의 견본을 채취하여 알코올도수를 검사하고 제품 표준과 비교한다. 증류가 완료되면 증류솥 내부의 압력과 온도를 낮추고 다음 작업을 위하여 증류솥 내부를 세척한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|고온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8735","dJobECdNm":"[8735]음료 제조기계 조작원","dJobJCd":"8120","dJobJCdNm":"[8120]음료 제조 관련 기계 조작원","dJobICd":"C111","dJobICdNm":"[C111]알코올음료 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005899:1', '{"dJobCd":"K000005899","dJobCdSeq":"1","dJobNm":"차배전기조작원","workSum":"각종 차와 커피를 제조하고자 원료를 볶는 배전기(Roaster)를 조작·관리한다.","doWork":"제품(차, 커피 등)의 종류에 따라 원료를 선별·분리하고 계량용기(Hopper Scale:자동계량설비)에 투입한다. 원료를 균일한 온도로 볶기 위하여 교반기를 작동시킨 후, 배전기 내부의 온도가 일정하게 유지되는지 관찰한다. 자동 계량된 원료를 배전기의 호퍼(Hopper)에 투입한 후, 배전기를 가동하고 원료가 균일하게 볶아지는지 관찰한다. 이때 온도가 너무 높거나 낮아서 차나 커피의 향과 맛이 떨어지지 않도록 작업표준을 준수한다. 작업 중인 원료의 색상을 살피고 제품 표준과 비교하여 조정판의 배전 시간을 조정한다. 원료의 볶아진 상태를 작업표준과 비교하며 필요시 배전기의 온도 및 시간을 다시 입력·조정한다. 다 볶아진 원료는 컨베이어를 사용하여 원료 저장탱크로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"로스터조작원","connectJob":"커피로스터조작원","certLic":"식품산업기사, 식품가공기능사","dJobECd":"8735","dJobECdNm":"[8735]음료 제조기계 조작원","dJobJCd":"8120","dJobJCdNm":"[8120]음료 제조 관련 기계 조작원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001255:1', '{"dJobCd":"K000001255","dJobCdSeq":"1","dJobNm":"차배합기조작원","workSum":"각종 차, 커피를 제조하고자 볶은 원료에 식품첨가물(커피의 경우는 다른 맛이 나는 커피)을 일정 비율로 배합하는 기계를 조작·관리한다.","doWork":"배합지시서를 확인한 후 계량용기를 사용하여 원료를 계량하고 배합기에 투입한다. 제품에 맞는 식품첨가물(설탕, 우유, 유화제, 안정제, 향료 등)을 배합기에 투입한 후, 교반기를 가동하여 원료와 고르게 배합되도록 한다. 커피를 배합할 때에는 특정한 맛이 부족한 원두와 그 맛을 보충해 줄 수 있는 원두를 배합한다. 제품에 따라 정해진 시간 동안 배합한 후 견본을 채취하여 향, 맛, 색상 등으로 배합상태를 검사하고 제품 표준과 비교한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"식품산업기사, 식품가공기능사","dJobECd":"8735","dJobECdNm":"[8735]음료 제조기계 조작원","dJobJCd":"8120","dJobJCdNm":"[8120]음료 제조 관련 기계 조작원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003153:1', '{"dJobCd":"K000003153","dJobCdSeq":"1","dJobNm":"차분쇄기조작원","workSum":"배전·배합공정을 거친 각종 차, 커피를 추출과 포장이 용이하도록 분쇄하는 기계를 조작·관리한다.","doWork":"제품규격에 따라 분쇄기의 롤러(Roller) 간격을 알맞게 조절한 후 원료(차, 커피)를 분쇄기에 투입한다. 분쇄기를 가동하고 분쇄상태를 관찰한다. 이때 분쇄된 크기는 추출속도를 결정하므로, 어느 정도 크기로 분쇄할지 작업표준을 준수한다. 특히 커피의 경우는 추출 기구에 따라 입자 크기(입도)를 달리해야 한다. 분쇄기의 배출구로 분쇄되어 나오는 원료의 견본을 채취하여 분쇄된 입자의 크기가 제품 표준과 일치하는지 검사한다. 분쇄가 완료되면 제품에 맞게 다음 공정(추출, 농축, 포장 공정 등)으로 컨베이어를 가동해 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"식품산업기사, 식품가공기능사","dJobECd":"8735","dJobECdNm":"[8735]음료 제조기계 조작원","dJobJCd":"8120","dJobJCdNm":"[8120]음료 제조 관련 기계 조작원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004920:1', '{"dJobCd":"K000004920","dJobCdSeq":"1","dJobNm":"차제조반장","workSum":"커피, 녹차 등의 차를 제조하고자 원료를 배전·분쇄·추출·농축·혼합·건조·포장하는 데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"일일 작업량과 저장실의 원료량을 비교·확인하고 장치의 이상 유무를 점검·확인한다. 원료의 보관상태 및 품질을 점검한다. 제품이 생산되는 동안 수시로 작업장을 순회하며 작업상태를 점검한다. 또한 각 공정의 견본을 채취하여 맛, 향, 색상 등을 점검하여 제품 표준과 비교하거나 견본의 일부를 실험실로 보낸다. 각 제조공정 중의 견본을 채취하여 작업표준과 비교한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","dJobECd":"8735","dJobECdNm":"[8735]음료 제조기계 조작원","dJobJCd":"8120","dJobJCdNm":"[8120]음료 제조 관련 기계 조작원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003394:1', '{"dJobCd":"K000003394","dJobCdSeq":"1","dJobNm":"청주제성원","workSum":"발효·숙성된 탁·약주를 규정된 알코올농도로 제조하고자 물을 첨가하여 여과하고 제성한다.","doWork":"제성탱크로 이송된 숙성된 탁·약주의 농도를 확인한 후 조정판에 급수량을 입력하고 가동하여 일정량의 물을 첨가한다. 자동압착기 조정판의 입력수치를 확인한 후 가동하여 발효액(주요)이 액상(청주)과 고형(주박)으로 용이하게 분리되는지 관찰한다. 압착기 내부를 수시로 점검하여 압착기에 남은 고형(주박)을 주걱이나 금속막대를 사용하여 벗겨낸다. 청주의 견본을 채취하여 알코올함량을 검사하고 제품 표준과 맞추기 위하여 급수밸브를 열고 일정량의 물을 투입한다. 제성작업이 완료되면 탱크의 배출구를 열고 펌프를 가동하여 주입기의 저장탱크로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"제성기조작원","dJobECd":"8735","dJobECdNm":"[8735]음료 제조기계 조작원","dJobJCd":"8120","dJobJCdNm":"[8120]음료 제조 관련 기계 조작원","dJobICd":"C111","dJobICdNm":"[C111]알코올음료 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006547:1', '{"dJobCd":"K000006547","dJobCdSeq":"1","dJobNm":"청주제조반장","workSum":"청주를 제조하고자 증자·담금·발효·압착·숙성하는 데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"작업시작 전에 작업원에게 일일 작업량과 주의사항을 주지시킨다. 각 공정의 견본을 채취하여 맛, 향, 투명도 등을 제품규격과 비교하거나 견본을 분석실로 보낸다. 각 증자탱크, 발효탱크, 도정기, 세미탱크, 주모탱크, 압착기, 배합기, 여과기 등 장치의 이상 유무를 확인·점검하고 기타 첨가물의 확보상태를 점검한다. 작업표준서에 따라 청주의 조합비를 확인한다. 숙성실의 숙성환경을 점검한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"고온|저온|다습|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","dJobECd":"8735","dJobECdNm":"[8735]음료 제조기계 조작원","dJobJCd":"8120","dJobJCdNm":"[8120]음료 제조 관련 기계 조작원","dJobICd":"C111","dJobICdNm":"[C111]알코올음료 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002840:1', '{"dJobCd":"K000002840","dJobCdSeq":"1","dJobNm":"청주조합원","workSum":"균일한 주질의 청주를 제조하고자 각 숙성탱크의 청주를 조합하는 탱크를 조작·관리한다.","doWork":"각 숙성탱크의 견본을 채취하여 맛, 향, 투명도 등을 검사한 후, 균일한 주질의 청주를 제조하고자 조합비를 청주제조반장과 협의한다. 각 저장탱크의 배출밸브를 열고 펌프를 가동하여 작업표준서의 조합비에 따라 조합탱크에 투입한다. 혼합이 용이하도록 이산화탄소를 투입하여 일정 시간 동안 교반한 후 견본을 채취하여 맛, 향, 투명도 등을 검사하고 제품 표준과 비교한다. 채취한 견본의 성분분석을 위하여 견본을 분석실로 보낸다. 조합탱크의 배출구를 열고 펌프를 가동하여 다음 공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|저온|다습|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"청주배합원","dJobECd":"8735","dJobECdNm":"[8735]음료 제조기계 조작원","dJobJCd":"8120","dJobJCdNm":"[8120]음료 제조 관련 기계 조작원","dJobICd":"C111","dJobICdNm":"[C111]알코올음료 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005675:1', '{"dJobCd":"K000005675","dJobCdSeq":"1","dJobNm":"캔제품검사원","workSum":"자동화 공정라인에서 가공된 캔제품의 품질을 검사한다.","doWork":"제품의 진공상태 등을 타검봉(打檢棒:두드려 보는 막대기 같은 기구)을 사용하여 검사한다. 자동검사기에서 불량품으로 걸러진 제품을 운반한다. 근무자, 날짜, 날인 등의 인쇄에 사용되는 자동인쇄기의 작업진행 상황을 모니터링한다. 매 시간 제품의 중량미달 여부 등을 검사하고 생산량 등을 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","dJobECd":"8735","dJobECdNm":"[8735]음료 제조기계 조작원","dJobJCd":"8120","dJobJCdNm":"[8120]음료 제조 관련 기계 조작원","dJobICd":"C111/C112","dJobICdNm":"[C111]알코올음료 제조업 / [C112]비알코올음료 및 얼음 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003095:1', '{"dJobCd":"K000003095","dJobCdSeq":"1","dJobNm":"캔커피포장기조작원","workSum":"충진된 캔커피를 포장하고자 자동포장기를 조작한다.","doWork":"제품의 크기, 수 등을 고려하여 포장기 컨트롤 패널에 조건을 입력한다. 포장용기, 박스 등을 손으로 투입한다. 자동적으로 포장되는지 진행상황을 지속적으로 모니터링한다. 문제가 발생할 경우 제반조건을 재설정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","dJobECd":"8735","dJobECdNm":"[8735]음료 제조기계 조작원","dJobJCd":"8120","dJobJCdNm":"[8120]음료 제조 관련 기계 조작원","dJobICd":"C112","dJobICdNm":"[C112]비알코올음료 및 얼음 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003699:1', '{"dJobCd":"K000003699","dJobCdSeq":"1","dJobNm":"폐당밀처리원","workSum":"효모배양의 주원료인 당밀을 청등(청정)당액으로 제조하기 위하여 폐당밀을 희석·가열·분리하여 불순물을 제거하는 장비를 조작·관리한다.","doWork":"자동 이송되어 탱크에 투입된 폐당밀에 일정량의 물을 투입하고 교반기를 작동시킨다. 희석된 폐당밀이 담긴 탱크를 일정 온도로 가열한다. 온도가 일정하게 유지되는지 등을 관찰·확인하고 필요한 조치를 취한다. 일정 시간 가열한 후 배출밸브를 열어 희석·가열된 폐당밀액을 당밀분리기에 투입한다. 견본을 채취하여 불순물의 잔존 여부를 검사한 후 세균의 번식을 방지하고자 분리된 당액을 열교환기에 투입하여 살균한다. 살균된 당액을 저장탱크로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"고온|다습|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8735","dJobECdNm":"[8735]음료 제조기계 조작원","dJobJCd":"8120","dJobJCdNm":"[8120]음료 제조 관련 기계 조작원","dJobICd":"C106","dJobICdNm":"[C106]곡물가공품, 전분 및 전분제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006908:1', '{"dJobCd":"K000006908","dJobCdSeq":"1","dJobNm":"포도주발효원","workSum":"포도액에 효모와 포도당을 첨가하여 발효시키는 장치를 조작·관리한다.","doWork":"자동 이송된 포도액이 발효탱크에 원활히 투입되는지 관찰한다. 작업표준에 따라 포도액 투입량에 맞춰 일정량의 효모나 포도당 등 첨가물을 발효탱크에 투입한다. 포도액의 발효가 용이하도록 저속의 교반기를 가동한다. 발효탱크 내부의 온도와 습도가 일정하게 유지되는지 관찰하고 필요시 조정판을 조작하여 발효탱크 내부의 온도를 일정하게 유지한다. 견본을 채취하여 발효상태를 검사하고 제품 표준과 비교한다. 발효가 완료되면 펌프를 가동하여 저장탱크로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|저온|다습|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8735","dJobECdNm":"[8735]음료 제조기계 조작원","dJobJCd":"8120","dJobJCdNm":"[8120]음료 제조 관련 기계 조작원","dJobICd":"C111","dJobICdNm":"[C111]알코올음료 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001639:1', '{"dJobCd":"K000001639","dJobCdSeq":"1","dJobNm":"포도주저온살균원","workSum":"포도주를 장기간 보존하고자 발효된 포도주를 저온으로 살균하는 탱크를 조작·관리한다.","doWork":"살균탱크의 증기밸브를 돌려 순환관에 증기를 투입하여 탱크 내부의 온도를 살균에 알맞게 유지한다. 저장탱크의 밸브를 열고 펌프를 가동하여 포도주를 투입한다. 온도계를 관찰하여 규정된 살균온도로 유지하고자 증기밸브를 조절한다. 포도주에 함유된 미생물을 검사하고자 견본을 채취하여 실험실로 보낸다. 살균이 완료되면 살균탱크의 배출구를 열고 펌프를 가동하여 저장탱크로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8735","dJobECdNm":"[8735]음료 제조기계 조작원","dJobJCd":"8120","dJobJCdNm":"[8120]음료 제조 관련 기계 조작원","dJobICd":"C111","dJobICdNm":"[C111]알코올음료 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003549:1', '{"dJobCd":"K000003549","dJobCdSeq":"1","dJobNm":"포도주저장실반장","workSum":"포도주를 저장·숙성하는 데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"제품의 종류에 따라 저장할 탱크를 결정하고 주입량을 점검한다. 각 탱크의 견본을 채취하여 숙성상태를 점검하고 작업일지에 기록한다. 포도주의 숙성상태에 따라 출하시기를 조정한다. 작업내용에 따라 작업원에게 지시·배치한다. 작업의 진행사항을 파악하고 작업내용을 보고한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원 및 자재를 공급한다. 작업계획에 따라 세부실행항목을 수립하고 작업절차 및 방법을 결정하여 작업원에게 작업내용을 지시하고 작업배치를 한다. 표준작업명세에 따라 지시된 작업이 이루어지는지 작업상황을 관찰하고 작업내용을 점검한다. 작업원의 직무교육 및 안전위생교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시면담과 관찰을 하여 작업원의 애로점 및 건의사항을 수렴·해결하고 문제점을 보완한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|저온|다습|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","dJobECd":"8735","dJobECdNm":"[8735]음료 제조기계 조작원","dJobJCd":"8120","dJobJCdNm":"[8120]음료 제조 관련 기계 조작원","dJobICd":"C111","dJobICdNm":"[C111]알코올음료 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007379:1', '{"dJobCd":"K000007379","dJobCdSeq":"1","dJobNm":"포도주정화원","workSum":"발효된 포도주에 포함된 숙취물질과 이물질을 정화하는 기계를 조작·관리한다.","doWork":"정화탱크의 밸브를 열고 펌프를 가동하여 발효된 포도주를 투입한다. 포도주에 포함된 숙취물질과 이물질을 침전시키기 위하여 가성소다나 화학약품을 투입하고 혼합이 용이하도록 교반기를 가동한다. 일정 시간 혼합한 후 교반기를 중지하고 생성된 이물질을 침전시킨다. 배출구의 밸브를 열어 침전물을 배출하고 펌프를 가동하여 정화된 포도주를 여과공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|다습|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8735","dJobECdNm":"[8735]음료 제조기계 조작원","dJobJCd":"8120","dJobJCdNm":"[8120]음료 제조 관련 기계 조작원","dJobICd":"C111","dJobICdNm":"[C111]알코올음료 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005350:1', '{"dJobCd":"K000005350","dJobCdSeq":"1","dJobNm":"포도파쇄원","workSum":"포도주 발효에 사용되는 포도액을 제조하고자 포도송이를 분쇄하는 기계를 조작·관리한다.","doWork":"파쇄기의 호퍼(Hopper)에 일정량의 포도송이를 투입하고 파쇄날을 점검한다. 호퍼의 배출구를 열고 기계를 가동하여 포도송이의 줄기와 포도알을 분리한다. 호퍼의 배출구에 포도송이가 잘 들어갈 수 있도록 포도송이를 배출구 속으로 밀어 넣어 주고 눈에 띄는 이물질을 제거한다. 파쇄기의 배출구를 열고 펌프를 가동하여 포도액을 저장탱크로 이송하고 포도줄기를 제거한다. 파쇄가 완료되면 물호스와 세척솔을 사용하여 파쇄기 내부에 부착된 이물질을 제거한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|다습|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8735","dJobECdNm":"[8735]음료 제조기계 조작원","dJobJCd":"8120","dJobJCdNm":"[8120]음료 제조 관련 기계 조작원","dJobICd":"C111","dJobICdNm":"[C111]알코올음료 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006978:1', '{"dJobCd":"K000006978","dJobCdSeq":"1","dJobNm":"가공염제조원","workSum":"가공염을 제조하고자 원염을 분쇄하는 분쇄기(타공기)를 조작·관리한다.","doWork":"작업지시서에 따라 일일 작업량을 확인한다. 작업표준에 따라 분쇄기(타공기)의 타공망을 제품규격에 맞게 교체한다. 호퍼(Hopper)의 하부배출구를 분쇄기에 맞춘다. 운반대차나 페이로우더를 이용해 호퍼에 원염을 투입하도록 한다. 분쇄기를 가동해 분쇄작업을 한다. 견본을 채취하여 작업표준과 비교한다. 분쇄가 완료되면 가공염을 가공염 저장탱크로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"식품산업기사, 식품가공기능사","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004809:1', '{"dJobCd":"K000004809","dJobCdSeq":"1","dJobNm":"가공유지배합원","workSum":"마가린이나 쇼트닝(Shortening)같은 제품을 제조하기 위하여 정제·여과한 유지를 계량·배합하고 고체화시키기 위해 냉각설비를 조작한다.","doWork":"정제·여과된 유지에 기능성을 부여하기 위하여 유화제, 풍미제, 착색제 등을 준비된 배합비율에 따라 계량하고 혼합한다. 기름에 녹는 첨가물이 투입된 유상부와 물에 녹는 첨가물이 투입되는 수상부는 적절한 온도로 가온하여 첨가된 첨가물들을 완전히 용해시킨다. 준비된 유상부와 수상부는 적합한 온도에서 살균과 유화를 거친 후 이송밸브를 조절하여 냉각설비로 보낸다. 냉매는 밸브를 조절하여 설비의 온도를 일정하게 유지하고, 냉각과정을 관찰하며 견본을 채취하여 제품 분석실로 품질평가를 위해 보낸다. 제조하는 제품의 종류에 따라 일정한 규격을 가진 형틀로 유지를 고화시키기도 한다. 자동화된 기계의 조정판에 가열온도, 가열시간, 냉각온도 등을 입력하여 가공상태를 관찰하고 조절하여 계량, 배합, 급냉, 충전상황을 점검한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"고온|다습|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"물성조정유지제조원","connectJob":"마가린제조원, 쇼트닝제조원","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C103","dJobICdNm":"[C103]과실, 채소 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007154:1', '{"dJobCd":"K000007154","dJobCdSeq":"1","dJobNm":"가수분해기조작원","workSum":"식물단백질가수분해물(HVP:Hydrolyzed Vegetable Protein) 제조 시 단백질의 맛을 높이고 소화가 용이하도록 가수분해하는 기계를 조작·관리한다.","doWork":"계량된 원료(대두박, 글루텐, 염산 등)와 일정량의 물을 분해탱크에 투입한다. 분해탱크 내부의 온도가 일정하게 유지되는지 관찰하고 가수분해가 완료되면 중화기로 분해액을 이송한다. 탄산소다, 탄산나트륨 등의 강알칼리성 물질을 작업표준에 따라 중화기 내부로 일정량 투입한 후 교반기를 작동시켜 강산성의 분해된 액을 약산성으로 중화시킨다. 일정량 중화가 진행되면 산도측정을 위해 견본을 채취한 후 실험실로 보내고, 규정 산도에 도달하면 중화된 용액을 여과기로 보낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"식품산업기사, 식품가공기능사","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002057:1', '{"dJobCd":"K000002057","dJobCdSeq":"1","dJobNm":"가향기조작원","workSum":"각초의 보습성을 유지하고 담배 품종별로 향을 주기 위하여 잎담배에 가향액을 혼합하는 기계를 조작한다.","doWork":"담배 종류에 따라 쓰일 가향액의 종류를 확인하고 가향기의 가향액 저장탱크의 유량을 점검한다. 가향기의 노즐을 점검하고 전기가열장치를 가동하여 일정 온도로 예열한다. 조정판의 스위치를 조절하여 가향액의 분무량, 잎담배의 투입량, 가열온도 등을 입력하고 기계를 가동한다. 기계의 작동상태를 수시로 점검하고, 가향된 잎담배의 견본을 채취하여 가향상태를 검사한다. 이상 발생 시 스위치를 재조절하여 가향조건을 변경하기도 한다. 작업이 완료되면 가향기의 가동을 중지하고 가향기 내부의 이물질을 제거한다. 가향기에 투입된 잎담배의 수량, 가향액의 소모량 등을 작업일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"순엽가향원, 주맥가향원, 토스트가향원","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C120","dJobICdNm":"[C120]담배 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003255:1', '{"dJobCd":"K000003255","dJobCdSeq":"1","dJobNm":"각초냉각기조작원","workSum":"혼합건조된 각초(잎담배를 잘게 자른 것)를 가향 작업의 조건에 맞도록 일정 온도로 냉각하는 냉각기를 조작한다.","doWork":"냉각기의 송풍팬, 각초(칼 따위로 잘게 썬 담배)를 분리하는 진동체 등이 잘 작동하는지 점검한다. 혼합각초를 궐련기에 투입하는 공수기의 가동상태를 점검한 후 냉각기, 공수기 순으로 가동한다. 계절이나 온도 변화에 따른 냉각온도를 일정하게 유지하고자 냉풍 인입량을 조절한다. 냉각된 혼합각초의 수분을 일정하게 유지하고자 증기밸브 및 전기가열장치를 조절한다. 혼합각초의 과냉각 및 과건조가 발생하면 과건습 저장로(Silo)공정으로 각초를 운반한다. 냉각이 완료되면 각초의 견본을 채취하여 냉각온도 및 건조상태를 점검한다. 고장 시 응급조치를 취한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C120","dJobICdNm":"[C120]담배 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005977:1', '{"dJobCd":"K000005977","dJobCdSeq":"1","dJobNm":"각초조화원","workSum":"가향액을 균일하게 흡수시키기 위하여 가향된 각초를 저장하여 숙성시키는 탱크를 조작한다.","doWork":"숙성탱크에 투입할 각초의 견본을 채취하여 수분함유량 및 가향상태를 검사하여 등급별로 분류한다. 탱크의 투입구를 열고 공수기를 가동하여 등급별로 분류된 각초를 투입한다. 각초 조화실 및 탱크의 기준 습도를 점검하여 기준 온도 및 습도를 유지한다. 가공공정에 필요한 각초를 공급하고자 탱크의 배출구를 열고 공수기를 가동하여 운반한다. 각초 조화실에 투입된 각초의 수량과 각 공정으로 운반한 각초의 수량을 작업일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"다습|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"각초숙성원","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C120","dJobICdNm":"[C120]담배 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006364:1', '{"dJobCd":"K000006364","dJobCdSeq":"1","dJobNm":"각초팽화기조작원","workSum":"냉동건조된 각초(잎담배를 잘게 자른 것)를 부풀리는 기계인 팽화기를 조작한다.","doWork":"각초팽화기 및 조정판의 이상 유무를 확인하고 팽화약품, 온수탱크, 냉각탱크의 유량을 점검한다. 조정판의 스위치를 조절하여 팽화액의 분무량, 온수의 투입량, 팽화시간 등을 입력하여 팽화되는 상태를 관찰·조절한다. 팽화가 완료되면 조정판의 스위치를 조절하여 가공실의 문을 열고 팽화된 각초를 공수기를 사용하여 저장탱크로 운반한다. 가공공정 중 이상이 발생하면 조정판의 스위치를 재조절하고 기계를 점검한다. 작업이 완료되면 팽화액, 온수 등의 유량을 점검하고 투입된 팽화액·온수의 수량을 작업일지에 기록한다. 고장 시 응급조치를 취한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"주맥팽화기조작원","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C120","dJobICdNm":"[C120]담배 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004506:1', '{"dJobCd":"K000004506","dJobCdSeq":"1","dJobNm":"견과탈각원","workSum":"밤, 호두, 땅콩 등의 견과를 식료품 제조에 이용하고자 껍질을 제거한다.","doWork":"탈각기의 회전해머(Hammer)를 확인·점검한다. 탈각기의 호퍼에 탈각할 견과(밤, 호두, 땅콩 등)를 투입한 후, 호퍼(Hopper)의 배출구를 열고 탈각기를 가동한다. 탈각된 견과의 상태를 점검하고 해머의 회전속도를 조절한다. 분리된 견과의 알맹이를 운반용기에 담아 저장실이나 다음 공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"시범후 30일 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005817:1', '{"dJobCd":"K000005817","dJobCdSeq":"1","dJobNm":"결정기조작원","workSum":"농축된 당액을 가열해 수분을 증발시킨 후, 결정핵(Seed)을 투입하여 굵은 설탕입자로 만드는 결정기를 조작·관리한다.","doWork":"정제당 증발기를 통해 농축된 설탕농축액이 결정기에 정상적으로 투입되는지 확인한다. 결정기를 가동해 열을 가하면서 수분을 증발시킨다. 작업표준에 따라 정해진 수준까지 수분이 증발되면, 제조하고자 하는 설탕의 종류에 따라 크기와 분량을 달리하는 일정량의 결정핵(Seed:아주 곱게 갈린 설탕 알갱이)을 투입한다. 결정기를 진공상태로 가동한 후 결정기 내부의 온도가 일정하게 유지되는지 확인한다. 확대모니터와 투시경(Sight Glass)을 통해 결정핵과 설탕입자가 결정입자(Mass:결정핵이 굵어지는 형태)로 성장하는 것을 관찰한다. 결정핵이 부족할 경우 필요한 만큼의 결정핵을 더 투입하고, 일정 크기로 결정입자가 성장하면 설탕결정을 분리하는 공정으로 자동 이송한다. 자동화된 기계의 조정판에 농축도, 결정기의 온도, 결정핵의 투입량, 펌프의 이송속도 등을 입력하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"식품산업기사, 식품가공기능사","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001752:1', '{"dJobCd":"K000001752","dJobCdSeq":"1","dJobNm":"결정반장","workSum":"설탕농축액으로부터 다양한 크기의 설탕결정을 제조하는 데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"일일 작업량을 확인하고 장치의 조정판에 입력 값이 올바르게 입력되었는지 확인한다. 작업표준에 따라 제조할 설탕의 결정 크기, 색, 당도 등의 제품규격을 검토하고 설비의 이상 유무를 확인하고 검사한다. 수시로 작업장을 순회하며 생산공정의 가동상황을 확인, 조치를 취한다. 농축된 설탕용액의 수분함유량을 점검하고 결정기에 투입되는 결정핵의 수량을 점검한다. 제조된 설탕의 수분함유량을 점검하여 건조온도를 조절한다. 결정이 완료된 설탕입자의 결정 크기를 제품 표준과 비교·검사한다. 견본을 채취하여 실험실로 보낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"보통 작업","workPlace":"실내","workEnv":"고온|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","certLic":"식품가공기능사","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005292:1', '{"dJobCd":"K000005292","dJobCdSeq":"1","dJobNm":"결정분리기조작원","workSum":"결정입자(Mass:결정과정을 거치면서 과포화가 된 상태)에서 당액을 분리해 설탕을 만드는 원심분리기를 조작·관리한다.","doWork":"원심분리기 드럼의 여과망 상태를 점검하고 필요시 교체한다. 원심분리기의 조정판에 회전시간, 회전속도, 세척시간 등을 입력한다. 원심분리기 드럼에 과포화된 상태의 결정입자(Mass)를 일정량 투입하고 원심분리기를 가동하여 설탕입자와 당액을 분리한다. 분리가 완료되면 설탕입자는 건조하기 위해 건조공정으로 자동 이송한다. 남은 당액은 회수한 후 다시 설탕입자로 만들기 위해 결정공정으로 자동 이송한다. 분리된 설탕입자의 수분함량을 측정하고자 견본을 실험실로 보낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"식품산업기사, 식품가공기능사","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004299:1', '{"dJobCd":"K000004299","dJobCdSeq":"1","dJobNm":"궐련제조기조작원","workSum":"각초, 궐련지, 필터 등을 사용하여 궐련을 제조하는 궐련제조기를 조작한다.","doWork":"궐련기 각 부위의 가동상태를 점검하고 이상 유무를 확인한다. 절엽이송 컨베이어를 점검하고 궐련기의 호퍼에 각초가 자동 투입되도록 설정한 후 필터, 팁페이퍼 등을 궐련기에 채운다. 조정판의 스위치를 조절하여 각초의 투입량, 궐련지의 투입속도, 필터의 수량, 팁페이퍼의 투입속도 등을 입력하고 기계를 가동한다. 궐련의 제조되는 상태를 관찰하고 수시로 견본을 채취하여 규격을 검사한다. 일정량의 담배가 제조되면 컨베이어에 포장담배박스를 적재하고 수시로 접착제, 인쇄잉크의 충전량을 확인한다. 작업이 완료되면 각초의 투입량, 필터 및 팁페이퍼의 사용량, 접착제, 인쇄잉크의 소모량 등을 작업일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|","workEnv":"소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"궐련기조작원","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C120","dJobICdNm":"[C120]담배 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006372:1', '{"dJobCd":"K000006372","dJobCdSeq":"1","dJobNm":"담배가향액배합원","workSum":"담배제품에 고유한 향을 첨가하기 위한 향료를 배합한다.","doWork":"가향수조의 각종 계기를 확인하고, 배합기의 배관시설 및 누수상태를 확인한다. 가향 조제탱크 및 보조탱크의 밸브를 돌려 적정온도로 예열한다. 가향조견표에 따라 계량용기를 사용하여 향료를 배합기에 투입한다. 쉽게 혼합할 수 있게 교반기를 가동한다. 배합이 완료되면 견본을 채취하여 향과 농도를 검사한다. 배합기의 배출구를 열고 펌프를 가동하여 각초(잎담배를 잘게 자른 것) 저장탱크로 이송한다. 각 가향작업에서 남는 잔여물을 가향기의 보조탱크로 이송한다. 가향액에 투입된 향료의 수량과 각 가향공정으로 이송한 가향액의 수량을 작업일지에 기록한다. 작업 중에 기계가 고장 나면 적절한 조치를 취한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C120","dJobICdNm":"[C120]담배 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002786:1', '{"dJobCd":"K000002786","dJobCdSeq":"1","dJobNm":"담배건조기조작원","workSum":"절각기에서 운반된 각초(잎담배를 잘게 자른 것)의 수분을 일정하게 유지시키는 건조기를 조작한다.","doWork":"건조기에 각초를 투입하는 정량공급기와 운반장치의 이상 유무를 확인한다. 건조기를 일정 온도로 가열하고자 스위치를 조작하여 실린더를 공회전시킨다. 혼합각초의 수분함량을 확인하고 정량공급기를 가동하여 건조기에 투입한다. 건조기의 가동상태를 점검하고 건조되어 배출되는 혼합각초의 견본을 채취하여 수분함량을 검사하고 작업표준과 비교한다. 냉각공정으로 혼합각초를 운반하는 공수기를 가동한다. 작업이 완료되면 실린더 내부의 이물질을 제거하고 작업장 주위를 청소한다. 건조공정에 투입된 혼합각초의 수량을 작업일지에 기록한다. 고장 시 응급조치를 취한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C120","dJobICdNm":"[C120]담배 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001487:1', '{"dJobCd":"K000001487","dJobCdSeq":"1","dJobNm":"담배되손질기조작원","workSum":"궐련(종이로 말은 담배)을 제조 및 포장하는 과정에서 나온 불량품 중에서 사용이 가능한 각초(잎담배를 잘게 자른 것)를 분리하는 기계인 되손질기를 조작한다.","doWork":"되손질기의 분리칼날의 마모상태와 공수기의 가동상태를 점검한다. 분리기의 상태와 각종 노즐의 이상 유무를 점검한 후 실린더를 가동하여 기계를 적정 온·습도로 유지한다. 조정판의 스위치를 조절하여 분리칼날의 회전속도, 불량궐련의 투입량, 분리망의 가동속도 등을 입력하고 기계를 가동한다. 분리된 각초의 견본을 수시로 채취하여 부산물의 함유상태를 점검한다. 최적의 분리가 이루어지도록 조정판의 스위치를 재조절한다. 기계에 투입된 불량궐련의 수량과 분리된 각초의 수량을 작업일지에 기록한다. 고장 시 응급조치를 취한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C120","dJobICdNm":"[C120]담배 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;