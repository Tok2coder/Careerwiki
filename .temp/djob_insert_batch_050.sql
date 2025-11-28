INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003562:1', '{"dJobCd":"K000003562","dJobCdSeq":"1","dJobNm":"의약품제조현장감독자","workSum":"원료 및 완제의약품을 제조하는 생산공정에 종사하는 작업원의 활동을 감독·조정한다.","doWork":"일일작업량에 따라 작업원을 배치하고 생산기록계기를 점검한다. 원료 및 부원료의 재고량 등을 확인한다. 각 제조단위공정의 견본을 채취하여 표준작업기준에 따라 모양, 색상, 규격 등을 점검한다. 작업내용에 따라 작업원을 지시·배치한다. 작업의 진행상황을 파악하고 작업내용을 상부관리자에게 보고한다. 작업상황을 관리, 감독하고 기술적인 지원 및 자재를 공급한다. 작업계획에 따라 세부실행항목을 수립하고 작업절차 및 방법을 결정하여 작업원에게 작업내용을 지시하고 작업배치를 한다. 표준작업명세에 따라 지시된 작업이 이루어지는지 작업원과 함께 작업하며 작업상황을 관찰하며 작업내용을 점검한다. 작업완료 후 일일작업량을 작업자들로부터 보고 받고 확인하여 상부에 보고한다. 작업원의 직무교육 및 안전위생 교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴, 해결하고 문제점을 보완한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","similarNm":"의약품제조반장","connectJob":"가공실반장, 배합반장, 수제실반장, 액제실반장, 제립실반장, 충진실반장, 타정실반장, 환제실반장","dJobECd":"8523","dJobECdNm":"[8523]화학제품 생산기계 조작원(고무·플라스틱 제외)","dJobJCd":"8321","dJobJCdNm":"[8321]화학제품 생산기 조작원","dJobICd":"C211/C212","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업 / [C212]의약품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004281:1', '{"dJobCd":"K000004281","dJobCdSeq":"1","dJobNm":"자동주형기조작원","workSum":"비누, 화장품을 제조하기 위하여 재료를 성형판에 주입해 일정한 모양으로 만드는 자동주형기를 조작·관리한다.","doWork":"작업지시서에 따라 온도조절기의 조정장치를 조절한다. 스팀·냉각제·압축공기를 탱크 및 주형에 순환시키기 위하여 각각의 밸브를 연다. 제품을 운반하고자 컨베이어를 작동시킨다. 일정 온도로 가열된 혼합물을 일정량 탱크의 투입구에 붓는다. 혼합물에 기포가 생기지 않도록 탱크의 교반기를 서서히 작동시킨다. 주형회전판을 작동시키고 혼합물이 주입된 주형에 케이스(Case)를 눌러 냉각·성형된 혼합물이 압축공기에 의해 케이스와 결합되도록 한다. 케이스와 결합된 제품을 컨베이어로 이송한다. 성형판에 남은 혼합물을 주걱을 사용하여 긁어낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"자동성형기조작원","connectJob":"좌약주형기조작원","dJobECd":"8523","dJobECdNm":"[8523]화학제품 생산기계 조작원(고무·플라스틱 제외)","dJobJCd":"8321","dJobJCdNm":"[8321]화학제품 생산기 조작원","dJobICd":"C204","dJobICdNm":"[C204]기타 화학제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005029:1', '{"dJobCd":"K000005029","dJobCdSeq":"1","dJobNm":"자동충전(충진)원","workSum":"생산된 화장품 및 의약품을 용기에 포장하기 위하여 충진기를 조작·관리한다.","doWork":"포장하고자 하는 제품의 점도에 맞는 충진기를 선택하고 펌프를 세척한다. 증류수 증기를 이용하여 저장탱크·노즐 등을 깨끗이 세척한다. 저장통에 원료(스킨·로션·크림, 의약품 등)를 넣고 펌프를 가동하여 항압탱크·호퍼통에 이송시킨다. 내용물이 넘거나 미달 시 직접 조절한다. 충진(Filling)이 끝난 후 실링(Sealing) 및 커팅(Cutting)이 순차적으로 이루어지게 한 후, 완제품을 포장공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","dJobECd":"8523","dJobECdNm":"[8523]화학제품 생산기계 조작원(고무·플라스틱 제외)","dJobJCd":"8321","dJobJCdNm":"[8321]화학제품 생산기 조작원","dJobICd":"C204/C212","dJobICdNm":"[C204]기타 화학제품 제조업 / [C212]의약품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002537:1', '{"dJobCd":"K000002537","dJobCdSeq":"1","dJobNm":"재제조토너카트리지품질시험원","workSum":"재제조된 토너 카트리지를 모델에 맞는 프린터에 넣고 프린트하여 색상, 화상도, 줄 이음부분 등의 프린트 품질을 테스트하여 합격 여부를 결정한다.","doWork":"각 조립공정이 끝난 재제조 토너 카트리지를 규격에 맞는 프린터에 장착한다. 여러 가지 화상농도(백지종이에 프린트된 부위의 비율)로 인쇄물을 출력한다. 인쇄물에 흰점(인쇄되지 않은 부위), 검은점(인쇄되지 않아야 할 곳의 점), 고르지 않은 인쇄농도(닥터블레이드 손상 시 나타남), 줄 등이 나타나는지 검사하여 합격품은 포장실로, 불합격품은 분해 및 재조립라인으로 보낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8523","dJobECdNm":"[8523]화학제품 생산기계 조작원(고무·플라스틱 제외)","dJobJCd":"8321","dJobJCdNm":"[8321]화학제품 생산기 조작원","dJobICd":"C204","dJobICdNm":"[C204]기타 화학제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007375:1', '{"dJobCd":"K000007375","dJobCdSeq":"1","dJobNm":"정밀화학합성제조원","workSum":"도료, 접착제, 색소 등의 정밀화학 합성제품제조를 위해 원재료와 합성설비를 이용하여 합성조건에 따라 단량체를 합성하거나 중합체를 합성하는 작업을 수행한다.","doWork":"합성제조 준비를 위해 설비와 안전위험요소를 점검하고 작업지시서를 파악하여 작업지시서대로 작업을 수행한다. 단량체 원재료를 준비하고 단량체를 합성한다. 중합 원재료를 준비하고 중합을 수행한다. 합성 공정제품 및 완제품이 규격에 맞는지 검사하고 합성제조 공정의 안전·환경·보건·위생 점검을 위한 상태를 점검한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8523","dJobECdNm":"[8523]화학제품 생산기계 조작원(고무·플라스틱 제외)","dJobJCd":"8321","dJobJCdNm":"[8321]화학제품 생산기 조작원","dJobICd":"C203/C204","dJobICdNm":"[C203]비료, 농약 및 살균, 살충제 제조업 / [C204]기타 화학제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007376:1', '{"dJobCd":"K000007376","dJobCdSeq":"1","dJobNm":"정밀화학혼합제조원","workSum":"화장품, 계면활성제 등 정밀화학 혼합제품을 제조하기 위해 원재료와 혼합설비를 이용하여 혼합작업조건에 따라 혼합작업을 수행한다.","doWork":"혼합제조 설비의 작동원리를 파악하고 제조설비 점검·관리규정과 주의사항을 숙지한다. 혼합제조 설비를 점검하고 작업지시서에 따라 제조설비를 운전한다. 혼합제조를 위한 원부재료를 준비하고 혼합제조 작업을 수행한다. 혼합공정을 수행하며 혼합공정 이상발생시 감독자의 지시에 따라 적절한 조치를 취한다. 혼합제조 안전·환경·보건·위생 규정을 파악하여 안전·환경·보건·위생 상태를 점검한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8523","dJobECdNm":"[8523]화학제품 생산기계 조작원(고무·플라스틱 제외)","dJobJCd":"8321","dJobJCdNm":"[8321]화학제품 생산기 조작원","dJobICd":"C203/C204","dJobICdNm":"[C203]비료, 농약 및 살균, 살충제 제조업 / [C204]기타 화학제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003617:1', '{"dJobCd":"K000003617","dJobCdSeq":"1","dJobNm":"정제코팅기조작원","workSum":"정제 약제의 안정성과 상품성을 높이고, 복용하기 쉽도록 코팅하는 기계를 조작한다.","doWork":"작업지시서를 확인하여 코팅할 의약품의 형태와 종류 및 수량과 사용될 코팅액의 종류 및 물량을 확인하고 부족 시에는 코팅액을 보충한다. 조제 탱크에 연결된 에탄올 공급 밸브를 열어 투입하고 반제품을 투입하여 완전히 용해시킨다. 코팅액을 제조하고자 조제탱크에 연결된 정제수 공급밸브를 열어 투입하고 교반하면서 반제품, 분산제, 첨가제 등을 작업지시서에 명시된 순서대로 투입하여 용해한다. 용해가 완료되면 하단의 밸브를 열어 투입하고 체로 거른 다음 코팅기에 연결되어 있는 탱크로 이송한다. 코팅액의 준비가 완료되면 나정(Tablets)을 코팅기에 투입하고 분사각도, 분사량, 회전속도, 온도 등의 수치를 조정판에 입력한다. 코팅기를 가동한 후 노즐에서 코팅액의 분사가 원활히 이루어지는지, 코팅기가 규칙적으로 회전하는지를 확인한다. 코팅이 완료되면 일정 온도에서 코팅된 나정(Tablets)을 건조시키기 위하여 코팅액의 노즐분사를 정지시키고 송풍기를 가동하여 건조시킨다. 건조도를 확인하고자 손톱으로 코팅상태를 긁어보거나, 토막내거나, 변색된 것이 없는지 등 결함 여부를 검사한다. 중량과 코팅두께가 명세서대로인지 알아보기 위하여 저울에 달고 캘리퍼스나 마이크로미터를 사용하여 견본정제를 측정한다. 밀폐된 용기에 담아 보관실로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"당의기작업원","dJobECd":"8523","dJobECdNm":"[8523]화학제품 생산기계 조작원(고무·플라스틱 제외)","dJobJCd":"8321","dJobJCdNm":"[8321]화학제품 생산기 조작원","dJobICd":"C212","dJobICdNm":"[C212]의약품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005805:1', '{"dJobCd":"K000005805","dJobCdSeq":"1","dJobNm":"제약동결건조기조작원","workSum":"바이오의약품 등의 역가 손실방지, 장기보관, 유통과정의 품질관리, 상온보관을 위하여 동결 건조시키는 건조기를 조작한다.","doWork":"바이오의약품, 생약제제와 열분해성 의약품 등의 역가(약효) 손실방지, 장기보관, 유통과정의 품질관리, 상온보관을 위한 동결건조제재 제조를 위하여 동결건조기를 조작한다. 동결건조기 조작 방법에 따라 동결건조기의 선반에 건조시킬 약제를 병에 넣어 마개를 얹어 놓은 상태로 올려놓는다. 건조기의 문을 닫고 문의 핸들을 돌려 밀폐시킨다. 동결건조기에 연결되는 냉동기를 작동시키고 동결건조기 내부 온도를 유지시켜 병 속의 액체를 얼게 한다. 동결건조기 내부와 연결된 진공펌프를 작동시키고 동결건조기 내부의 병 속의 물질온도를 서서히 상승시켜 건조될 때까지 온도를 조정, 유지한다. 건조되면 동결건조기 내부와 연결된 파이프에 질소통을 연결하고 밸브를 열어 질소를 충진한다. 스위치를 작동시켜 선반을 밀착시키고 고무마개를 막는다. 동결건조 완료된 병을 동결건조기로부터 끄집어내어 알루미늄캡으로 막기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|저온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8523","dJobECdNm":"[8523]화학제품 생산기계 조작원(고무·플라스틱 제외)","dJobJCd":"8321","dJobJCdNm":"[8321]화학제품 생산기 조작원","dJobICd":"C212","dJobICdNm":"[C212]의약품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002482:1', '{"dJobCd":"K000002482","dJobCdSeq":"1","dJobNm":"제약발효기조작원","workSum":"항생물질 또는 바이오의약품 제조를 위하여 미생물이 번식할 수 있는 배양통에 미생물을 접종하여 배양시킨다.","doWork":"배양할 미생물의 종류와 배양기간 등의 작업지시를 확인한다. 미생물이 증식할 수 있는 배양통을 1차 발효조에 투입하고 스팀을 통과시켜 일정 온도에서 잡균을 멸균한다. 발효조에 냉각수를 통과시켜 균체 배양에 필요한 온도로 냉각한다. 동결건조 또는 동결 보존되고 있는 균주를 용해 또는 원심분리하여 접종준비를 한다. 준비된 배양통에 균주를 일정량씩 주사기 또는 세트를 사용하여 무균적인 방법으로 접종시킨다. 제어판을 조작하여 발효기의 알피엠(RPM:회전수) 및 에어량을 조절하고 발효기 내의 용존산소량을 조절한다. 발효기 내의 거품제거를 위하여 소포제 주입시간과 간격을 조절한다. 접종한 배양통은 2차 배양실로 운반하여 배양이 잘 이루어지도록 온도, 습도 등을 유지한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8523","dJobECdNm":"[8523]화학제품 생산기계 조작원(고무·플라스틱 제외)","dJobJCd":"8321","dJobJCdNm":"[8321]화학제품 생산기 조작원","dJobICd":"C211","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007372:1', '{"dJobCd":"K000007372","dJobCdSeq":"1","dJobNm":"주사제생산원","workSum":"주사제 의약품을 생산을 위해 GMP 규정에 따라 제조조건 설정, 원료칭량, 조제 및 동결건조, 용기세척, 충전 및 멸균, 공정검사 선별·포장 등의 업무를 수행한다.","doWork":"제조장비별 작동원리 및 운용조건을 파악하고, 설정 및 유지 상태를 확인한 후 문제 발생의 유형별 트러블슈팅 방법을 숙지하여 적절한 조치를 한다. 원료 및 주사용수를 조제 탱크에 투입 후 조제 탱크의 온도, RPM, 시간 등을 설정하여 운전한다. 제품별 조제액의 용해 상태 확인 및 최종액량을 정하고, 공정관리용(IPC용) 조제액을 샘플링한다. 약액을 이송하면서 제균 여과, 멸균기를 이용하여 용기를 멸균하고 충전기 작업 조건을 설정하고 가동한다. 용봉, 실링(sealling), 캡핑(capping) 이물검사, 누출검사를 수행하고 동결건조 장비 및 멸균기의 조건을 설정하고 가동한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8523","dJobECdNm":"[8523]화학제품 생산기계 조작원(고무·플라스틱 제외)","dJobJCd":"8321","dJobJCdNm":"[8321]화학제품 생산기 조작원","dJobICd":"C211","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005069:1', '{"dJobCd":"K000005069","dJobCdSeq":"1","dJobNm":"주사제제조원","workSum":"주사액을 제조하기 위하여 조제, 여과, 충전(충진), 멸균하는 장치를 조작한다.","doWork":"제조할 주사액의 종류와 원료를 확인하고 약침용 주사액 제조기의 청결상태를 확인 점검한다. 주사액의 원료를 조합비율에 따라 각각 정량 계량하여 준비한다. 조제탱크에 연결된 스팀밸브를 열어 탱크를 일정 온도까지 올린다. 작업표준서에 명시된 배합비에 따라 원료 및 부원료를 계량하여 순서대로 투입한다. 조제탱크의 조정판에 운전조건을 입력하고 가동한다. 용해가 완료되면 기타 첨가제를 계량하여 투입하고 주사용수의 공급밸브를 열어 일정량을 공급하여 전탕(모두 함께 끓임)한다. 다시 일정 시간 교반을 한 후 견본을 채취하여 산도(pH)를 측정하고 작업표준서에 있는 산도(pH)로 맞추기 위하여 염산으로 적정한다. 주사용수로 최종 세척한 필터홀더를 고압증기로 멸균하고 걸러내기 위하여 투과막을 설치한다. 조제 완료된 약액을 여과기에 통과시키기 위하여 투입밸브를 열고 펌프를 가동한다. 필터홀더에 주사용수를 붓고 다시 비등점을 측정한다. 앰풀충전기를 시운전하여 충진량 및 충진속도를 조정한다. 충진기를 가동하여 약액을 앰풀에 충진하고 충진·용봉이 완료된 완제품을 대차에 적제한 후 건열멸균기에 넣고 온도 및 냉각시간을 입력한 후 멸균한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8523","dJobECdNm":"[8523]화학제품 생산기계 조작원(고무·플라스틱 제외)","dJobJCd":"8321","dJobJCdNm":"[8321]화학제품 생산기 조작원","dJobICd":"C212/C213","dJobICdNm":"[C212]의약품 제조업 / [C213]의료용품 및 기타 의약 관련제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005636:1', '{"dJobCd":"K000005636","dJobCdSeq":"1","dJobNm":"채균원","workSum":"배지(배양기) 또는 세포에 증식된 미생물을 채취하기 위하여 채균세트 및 관련 장비를 조작한다.","doWork":"작업표준에 따라 손을 소독하고 방역신발과 방역모자, 방역마스크 등의 장비를 갖춘다. 미생물이 증식된 배지(배양기) 또는 세포를 배양실에서 대차를 이용하여 채균실로 운반한다. 채균을 위하여 채균세트를 소독기 및 멸균기에 넣어 멸균한다. 채균준비를 한다. 증식된 미생물을 자동 채독기를 이용해 배양한 바이러스를 무균적인 방법으로 채균한다. 배양 및 채균작업에 사용한 용기 및 기구를 멸균기에 넣어 멸균한 후 세척 또는 폐기한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8523","dJobECdNm":"[8523]화학제품 생산기계 조작원(고무·플라스틱 제외)","dJobJCd":"8321","dJobJCdNm":"[8321]화학제품 생산기 조작원","dJobICd":"C211","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004471:1', '{"dJobCd":"K000004471","dJobCdSeq":"1","dJobNm":"캡슐제조기조작원","workSum":"경질캡슐·연질캡슐을 제조하기 위하여 캡슐제조기를 조작·관리한다.","doWork":"캡슐은 온도와 습기에 영향을 받기 쉬우므로, 온도·습도를 조절하기 위하여 항온항습조절기를 조작한다. 배합실에서 경질캡슐 피막원료(젤라틴, 가소제, 정제수)를 공급받아 자동캡슐기계장치에 원료를 공급한다. 기계를 작동해 원통형의 몸체와 캡을 생산한다. 연질캡슐을 만드는 경우에는 캡슐기제(젤라틴 성분의 피막원료에 색소원료를 조색)에 내용물(용액, 현탁액 등·주원료·부원료·유화제를 칭량·봉합·밀링·여과·탈포)을 충진하고 다양한 모양으로 성형한다. 생산된 캡슐은 캡슐 자동검사기를 거쳐 불량품을 검출한다. 제조된 캡슐의 양을 작업일지에 기록하고 외관상의 결함을 검사한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"식품산업기사, 식품가공기능사","dJobECd":"8523","dJobECdNm":"[8523]화학제품 생산기계 조작원(고무·플라스틱 제외)","dJobJCd":"8321","dJobJCdNm":"[8321]화학제품 생산기 조작원","dJobICd":"C107/C204/C211","dJobICdNm":"[C107]기타 식품 제조업 / [C204]기타 화학제품 제조업 / [C211]기초 의약물질 및 생물학적 제제 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005823:1', '{"dJobCd":"K000005823","dJobCdSeq":"1","dJobNm":"캡슐제조현장감독자","workSum":"캡슐을 생산하는 데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"작업내용에 따라 작업원에게 지시·배치한다. 작업의 진행상황을 파악하고 작업내용을 보고한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원 및 자재를 공급한다. 작업계획에 따라 세부실행항목을 수립하고 작업절차 및 방법을 결정하여 작업원에게 작업내용을 지시하고 작업배치를 한다. 표준작업명세에 따라 지시된 작업이 이루어지는지 작업원과 함께 작업하며 작업상황을 관찰하며 작업내용을 점검한다. 작업원의 직무교육 및 안전위생 교육을 하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴·해결하고 문제점을 보완한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","similarNm":"캡슐제조반장","certLic":"식품산업기사, 식품가공기능사","dJobECd":"8523","dJobECdNm":"[8523]화학제품 생산기계 조작원(고무·플라스틱 제외)","dJobJCd":"8321","dJobJCdNm":"[8321]화학제품 생산기 조작원","dJobICd":"C107/C204/C211","dJobICdNm":"[C107]기타 식품 제조업 / [C204]기타 화학제품 제조업 / [C211]기초 의약물질 및 생물학적 제제 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007280:1', '{"dJobCd":"K000007280","dJobCdSeq":"1","dJobNm":"캡슐착색원","workSum":"캡슐의 피막에 색상을 넣기 위해 색소를 혼합·착색하는 기계를 조작·관리한다.","doWork":"캡슐은 온도와 습기에 영향을 받기 쉬우므로, 착색실의 온도와 습도를 적절히 유지하기 위한 항온항습조절기를 조작한다. 제품표준에 맞는 색상을 얻기 위하여 색소원료를 칭량(秤量:저울로 무게를 닮)하고 혼합한다. 혼합된 색소를 용해탱크에 넣은 후 자동착색기를 작동하여 착색한다. 견본을 채취한 후 육안검사하고, 자동검사기를 이용해 수분·색도·점도를 검사한다. 경질캡슐은 건조공정으로 자동이송하고, 연질캡슐은 내용물을 충진·성형하기 위해 대기시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"시각|","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"식품산업기사","dJobECd":"8523","dJobECdNm":"[8523]화학제품 생산기계 조작원(고무·플라스틱 제외)","dJobJCd":"8321","dJobJCdNm":"[8321]화학제품 생산기 조작원","dJobICd":"C107/C204/C211","dJobICdNm":"[C107]기타 식품 제조업 / [C204]기타 화학제품 제조업 / [C211]기초 의약물질 및 생물학적 제제 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003466:1', '{"dJobCd":"K000003466","dJobCdSeq":"1","dJobNm":"혈액분획원","workSum":"혈액에서 혈장을 분리하고 혈장에서 플라스마네이드, 항혈우병인자, 알부민 등을 추출한다.","doWork":"혈액분획제재(혈액을 원료로 한 의약품)를 생성하고자 분획(구분하여 분리함)할 혈액의 종류 및 양을 확인하고 여과기, 고속원심분리기 등의 장비와 알코올, 수소이온, 나트륨이온, 단백질 등 작업에 필요한 혈액분획장비 및 첨가원료를 점검한다. 혈장을 분리용 탱크에 투입하여 나트륨 이온을 첨가하고 반응온도를 유지한다. 여과기로 불순물을 제거하고 원심분리하여 항혈우병인자 분획액을 추출한다. 분획액을 탱크에 투입하고 알코올, 수소이온, 나트륨이온, 단백질 등의 인자를 첨가한다. 온도를 유지하고 교반한다. 불순물을 제거하고 원심분리하여 글로블린 분획액을 추출한다. 추출한 분획액에 증류수, 알코올, 나트륨이온 등을 첨가한 뒤 여과하여 혈액분획제재원액을 제조한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"혈장원심분리기조작원","dJobECd":"8523","dJobECdNm":"[8523]화학제품 생산기계 조작원(고무·플라스틱 제외)","dJobJCd":"8321","dJobJCdNm":"[8321]화학제품 생산기 조작원","dJobICd":"C211","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006631:1', '{"dJobCd":"K000006631","dJobCdSeq":"1","dJobNm":"화장품제조현장감독자","workSum":"각종 화장품을 생산하고자 분산·유화·가용화·혼합·분쇄·성형·포장 공정에 종사하는 작업원의 활동을 감독·조정한다.","doWork":"분산, 유화, 가용화, 혼합, 분쇄, 성형 및 포장 공정 등 화장품의 제조공정에 따라 세부실행항목을 수립한 후 작업원을 배치하고 작업지시를 한다. 기계의 작동상태를 관찰하고 결함이 있는 장비나 부품에 대해 수리 또는 교체를 지시한다. 작업원의 전반적인 작업상황을 관리·감독하고 기술적인 지원 및 자재를 공급한다. 작업원과 함께 작업하며 지시된 작업이 잘 이루어지는지를 확인하고, 각 공정에서 생산이 되고 있는 제품이 표준작업명세서에 맞는가를 검토한다. 작업의 진행상황을 파악하고 작업내용을 보고한다. 작업원의 직무교육을 통해서 직무수행능력을 향상시킨다. 철저한 안전위생 교육을 통하여 중금속 중독, 화학물질에 의한 상해, 기계로 인한 상해 등을 미연에 방지한다. 수시면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴·해결하고 문제점을 보완한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","similarNm":"화장품제조반장","dJobECd":"8523","dJobECdNm":"[8523]화학제품 생산기계 조작원(고무·플라스틱 제외)","dJobJCd":"8321","dJobJCdNm":"[8321]화학제품 생산기 조작원","dJobICd":"C204","dJobICdNm":"[C204]기타 화학제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004015:1', '{"dJobCd":"K000004015","dJobCdSeq":"1","dJobNm":"화학비료제조장치조작원","workSum":"화학비료제품을 제조하기 위하여 중앙조정실에서 제어판 및 관련 장비를 조정해 각종 장치(반응기, 조립기, 건조기, 가열기, 선별기, 분쇄기, 냉각기 등)를 제어한다.","doWork":"교대 근무 시에는 전 근무자의 운전 현황 및 특별사항을 인수인계 받는다. 모니터 등을 이용해 현장의 작업상황을 파악해 현장과 조정판의 운전 상태를 비교하면서 적절한 상태를 유지한다. 문제가 발생 시 화학비료제조장치현장원에게 현장상황을 파악하고 적절한 조치를 하도록 지시한다. 공정 중의 문제가 발생하거나 반응기, 조립기, 건조기 등의 온도, 압력, 속도 등의 변경이 필요할 때에는 제어장치를 조작하여 변경한다. 수리가 필요한 경우에는 공무팀에 연락을 취해 조치를 취한다. 문제점 및 현황에 대해서 화학비료제조장치조작반장에게 보고를 한다. 작업을 완료한 후에는 조정판 운전현황을 기록하고 패널을 정돈한 후 컨트롤 룸을 청소한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"화학비료보드맨","certLic":"위험물산업기사, 위험물기능사","dJobECd":"8523","dJobECdNm":"[8523]화학제품 생산기계 조작원(고무·플라스틱 제외)","dJobJCd":"8321","dJobJCdNm":"[8321]화학제품 생산기 조작원","dJobICd":"C203","dJobICdNm":"[C203]비료, 농약 및 살균, 살충제 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002104:1', '{"dJobCd":"K000002104","dJobCdSeq":"1","dJobNm":"화학비료제조장치조작현장감독자","workSum":"화학비료제품을 제조하기 위하여 중앙조정실에서 제어판 및 관련 장비를 조정하는 화학비료제조장치조작원의 활동을 조정·감독한다.","doWork":"작업계획에 따라 세부실행항목을 수립하여 작업절차 및 방법을 결정하고 화학비료제조장치조작원에게 작업 지시를 내린다. 모니터와 각종 기기를 이용해 운전 및 공정상의 이상 현상을 발견하고 화학비료제조장치조작원에게 적절한 조치를 취하도록 지시한다. 기기장치의 오작동을 방지하고, 기기장치 사고에 대한 요인 분석과 조정상황을 파악해 현장을 파악하게 하는 등 적절한 지시를 내린다. 가동정지의 원인을 분석해 생산의 손실을 줄이고 작업원의 안전을 지키며 가동정지가 발생 시 상부에 보고한다. 작업원에게 직무교육 및 안전위생교육을 시키고 직무수행능력을 향상시켜 안전재해를 예방한다. 수시로 면담과 관찰을 하여 작업원의 애로점 및 건의사항을 수렴하고 문제점을 보고한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","similarNm":"화학비료보드맨반장, 화학비료조정실반장, 화학비료제조장치조작반장","certLic":"위험물산업기사, 위험물기능사","dJobECd":"8523","dJobECdNm":"[8523]화학제품 생산기계 조작원(고무·플라스틱 제외)","dJobJCd":"8321","dJobJCdNm":"[8321]화학제품 생산기 조작원","dJobICd":"C203","dJobICdNm":"[C203]비료, 농약 및 살균, 살충제 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007237:1', '{"dJobCd":"K000007237","dJobCdSeq":"1","dJobNm":"화학비료제조현장조작원","workSum":"화학비료를 제조하기 위해 화학비료제조장치조작원의 지시에 따라 각종 장치(반응기, 조립기, 건조기, 가열기, 선별기, 분쇄기, 냉각기 등)를 현장에서 조작·관리한다.","doWork":"화학비료제조현장조작반장의 작업지시 내용을 이해하고 작업지시서의 내용을 확인한다. 교대 근무 시에는 전 근무자의 운전현황 및 특별사항을 인수인계 받고 SOP(Standard Operating Procedure)의 내용에 따라 순차적인 작업을 진행한다. 일정 시간마다 각종 기기(반응기, 조립기, 건조기, 가열기 등)가 설치된 현장에서 원료공급이 적정하게 이루어지고 있는지를 관찰한다. 설비 적정가동 여부, 누수 여부를 수시로 점검한다. 공정작업 중 문제가 발생 시에는 화학비료제조현장조작반장에게 보고를 하고 지시에 따라 현장 기계 및 장비를 조정한다. 작업이 종료가 되면 주변을 정리정돈 한 후 다음 근무자에게 작업내용과 특이사항 등에 대한 인수인계를 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|","workEnv":"위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"위험물산업기사, 위험물기능사","dJobECd":"8523","dJobECdNm":"[8523]화학제품 생산기계 조작원(고무·플라스틱 제외)","dJobJCd":"8321","dJobJCdNm":"[8321]화학제품 생산기 조작원","dJobICd":"C203","dJobICdNm":"[C203]비료, 농약 및 살균, 살충제 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002570:1', '{"dJobCd":"K000002570","dJobCdSeq":"1","dJobNm":"화학비료제조현장조작현장감독자","workSum":"화학비료를 제조하기 위해 각종 장치(반응기, 조립기, 건조기, 가열기, 선별기, 분쇄기, 냉각기 등)를 조작·관리하는 화학비료제조현장조작원의 활동을 조정·감독한다.","doWork":"화학비료제조현장조작원의 업무 내용과 책임 한계를 명확히 해 효율적인 생산이 이루어지고 안전사고가 발생되지 않도록 작업지시서에 따른 업무 분장을 한다. 조작원들에게 안전과 관련이 된 규정을 교육시키고, 안전 관련 규정의 준수 여부를 확인하고 점검한다. 원료의 공정 투입 현황을 파악하고, 각 제품의 규격별로 생산 확인을 하면서 적정 생산을 관리한다. 작업장의 장치 및 기기에 대해 이상 여부를 확인하고 조작원들에게 제반 사항에 대해 조치를 취하도록 하며, 문제점을 파악해 상부에 보고를 한 후 지시를 받는다. 작업장 주변의 정리정돈 상태를 점검하고 개선을 한다. 환경에 대한 법적 규정에 따라 안전 운전을 하고 규정 준수 여부를 철저히 확인한다. 공정 위험 요소를 발견해 보고하기도 한다. 수시면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴하고 문제점을 보고한다. 공정을 순회해 운전 상태를 점검하고 위험요인을 발견해 현장점검일지를 작성한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","similarNm":"화학비료필드반장, 화학비료제조현장조작반장","certLic":"위험물산업기사, 위험물기능사","dJobECd":"8523","dJobECdNm":"[8523]화학제품 생산기계 조작원(고무·플라스틱 제외)","dJobJCd":"8321","dJobJCdNm":"[8321]화학제품 생산기 조작원","dJobICd":"C203","dJobICdNm":"[C203]비료, 농약 및 살균, 살충제 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005816:1', '{"dJobCd":"K000005816","dJobCdSeq":"1","dJobNm":"화학제품원료계량원","workSum":"의약품, 화장품 제조에 사용되는 각종 원료를 분류한 후 이를 계량하기 위한 장비를 조작·관리한다.","doWork":"작업장과 중량측정을 위한 기구의 청결상태를 점검하고 저울의 영점을 맞춘다. 계량하고자 하는 원료의 양 및 종류에 따라 필요한 용기를 준비하고 용기의 세척상태를 점검한다. 계량하고자 하는 원료의 양에 따라 적절한 저울을 선택하고 감도를 확인한다. 계량용기의 무게를 확인하고 계량하고자 하는 양과 저울의 눈금 및 수치를 정확하게 확인하여 오차 및 잘못된 계량이 없도록 한다. 원료를 계량한 후 계량 근거를 작업일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|시각|","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"화학제품원료중량측정원, 화학제품칭량원","dJobECd":"8523","dJobECdNm":"[8523]화학제품 생산기계 조작원(고무·플라스틱 제외)","dJobJCd":"8321","dJobJCdNm":"[8321]화학제품 생산기 조작원","dJobICd":"C204/C211/C212","dJobICdNm":"[C204]기타 화학제품 제조업 / [C211]기초 의약물질 및 생물학적 제제 제조업 / [C212]의약품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004957:1', '{"dJobCd":"K000004957","dJobCdSeq":"1","dJobNm":"화학제품원료혼합기조작원","workSum":"각종 화학제품을 생산하고자 원료를 혼합하고 가공하여 처리하는 혼합기 및 보조 장비를 조작·관리한다.","doWork":"분쇄공정을 거친 원료를 계량한 후, 혼합 비율표에 따라 혼합기의 호퍼(Hopper)에 일정량의 원료를 넣는다. 혼합하기 위한 입자의 크기·온도·수분함량·공급량·기계의 속도를 조절하기 위하여 조정레버나 밸브를 조작한다. 일정 시간 동안 재료의 혼합을 위하여 교반기를 작동한다. 원료가 혼합되는 동안 지정된 추가 재료를 첨가한다. 공정이 진행되는 동안에 입자의 크기, 모양 및 색깔 등을 보고 공정의 진행 정도나 작업표준과의 차이를 비교·판별하고, 재료의 견본을 추출해 검사하거나 실험실에 보낸다. 필요에 따라 열교환기를 사용하여 반제품 상태로 냉각시키는 경우도 있다. 불순물을 제거하기 위한 여과기나 건조를 위한 건조기 등의 보조장비를 조작하기도 한다. 혼합물을 이송하기 위해 밸브나 펌프를 조작한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"가열용해조조작원, 뇌괴기조작원, 용해장치조작원, 콜로이드밀조작원","dJobECd":"8523","dJobECdNm":"[8523]화학제품 생산기계 조작원(고무·플라스틱 제외)","dJobJCd":"8321","dJobJCdNm":"[8321]화학제품 생산기 조작원","dJobICd":"C204/C211/C212","dJobICdNm":"[C204]기타 화학제품 제조업 / [C211]기초 의약물질 및 생물학적 제제 제조업 / [C212]의약품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003802:1', '{"dJobCd":"K000003802","dJobCdSeq":"1","dJobNm":"화학제품제조배합원","workSum":"의약품, 화장품을 제조하기 위하여 각종 원료 및 향·색소 등의 성분을 계량하여 공정에 따라 배합하고 배합기를 조작·관리한다.","doWork":"제품표준에 맞게 필요한 원료, 향료, 색소 등을 저울, 계량컵, 계량통으로 계량하여 배합통에 붓는다. 배합통의 뚜껑을 닫고 교반기를 작동시킨다. 작업표준에 따라 일정한 시간이 지나면 교반기를 정지시키고, 견본을 채취하여 배합상태를 검사한다. 검사 완료된 배합물을 반제품통이나 저장탱크에 받는다. 배출이 완료된 배합기 및 주변공조기를 정제수, 세척유 등으로 청소한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"화학제품교반기조작원, 화학제품원료혼합원","dJobECd":"8523","dJobECdNm":"[8523]화학제품 생산기계 조작원(고무·플라스틱 제외)","dJobJCd":"8321","dJobJCdNm":"[8321]화학제품 생산기 조작원","dJobICd":"C107/C204/C211","dJobICdNm":"[C107]기타 식품 제조업 / [C204]기타 화학제품 제조업 / [C211]기초 의약물질 및 생물학적 제제 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006060:1', '{"dJobCd":"K000006060","dJobCdSeq":"1","dJobNm":"화학제품제조현장조작원(일반)","workSum":"석유화학제품 및 기타 화학제품을 제조하기 위하여 중앙조정실조작원의 신호에 따라 각 공정(증류·정제·중합반응·흡수 등)의 장치 및 장비를 조작·관리한다.","doWork":"무전기 등으로 중앙조정실조작원과 연락을 유지하면서 공장의 각종 공정을 순회하고 고장과 누설 등의 이상 작동 요소를 점검한다. 이상 발견 시에는 중앙조정실조작원에게 신속히 연락을 취한 후 초지를 취한다. 중앙조정실조작원으로부터 설비 및 장치에 대한 이상을 파악하라는 지시를 받게 되면 수동공구를 이용해 밸브를 열거나 닫는 등의 조치를 취한다. 중간검사를 위하여 시료채취밸브를 열고 시료를 채취한다. 펌프, 압축기, 송풍기와 같은 장비를 작동·정지한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"화학제품필드맨, 화학제품필드운전원, 화학제품현장근무자","connectJob":"가성소다제조공정조작원, 가소로공정조작원, 고순도텔레프탈산제조장치조작원, 산화공정조작원, 아세트알데히드합성공정조작원, 알킬화공정조작원, 암모니아합성장치조작원, 액화염소제조장치조작원, 에탄올합성공정조작원, 옥심공정조작원, 이성화공정조작원, 인산제조장치조작원, 정제공정조작원, 중합공정조작원, 카프로락탐제조장치운전원, 콜타르증류장치조작원, 탈수소공정조작원, 하이암공정조작원, 합성수지제조장치조작원, 황산제조장치조작원","certLic":"화공기사, 위험물산업기사, 위험물기능사","dJobECd":"8523","dJobECdNm":"[8523]화학제품 생산기계 조작원(고무·플라스틱 제외)","dJobJCd":"8321","dJobJCdNm":"[8321]화학제품 생산기 조작원","dJobICd":"C201","dJobICdNm":"[C201]기초 화학물질 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003523:1', '{"dJobCd":"K000003523","dJobCdSeq":"1","dJobNm":"화학제품포장재료검사원","workSum":"의약품, 화장품의 포장용기 및 부재료를 표준과 비교·분석하고 필요한 검사를 한다.","doWork":"포장용기와 부재료에 부스러기가 있거나, 금이 가 있거나, 상표가 찢어졌거나, 변색되어 있는지를 검사한다. 마이크로미터·게이지·측정기 등의 측정도구를 사용하여 용기 및 마개 표본이 표준에 맞는지를 측정한다. 용기의 용량을 확인하기 위하여 액체를 용기 속에 채워 넣거나 눈금에 맞게 부어 본다. 검사결과나 시험결과를 기록한다. 병마개나 용기 덮개부분의 누설 여부를 검사하기도 있다. 충진량을 확인하기 위하여 견본용기에 담은 내용물을 부어서 무게를 측정하는 경우도 있다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|시각|","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8523","dJobECdNm":"[8523]화학제품 생산기계 조작원(고무·플라스틱 제외)","dJobJCd":"8321","dJobJCdNm":"[8321]화학제품 생산기 조작원","dJobICd":"C204/C211/C212","dJobICdNm":"[C204]기타 화학제품 제조업 / [C211]기초 의약물질 및 생물학적 제제 제조업 / [C212]의약품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005861:1', '{"dJobCd":"K000005861","dJobCdSeq":"1","dJobNm":"효소염석원","workSum":"흡착제를 이용하여 뇨 속에 함유되어 있는 혈전용해제를 분리·추출한다.","doWork":"채취한 뇨를 검사하여 탱크에 투입한 후 흡착제를 첨가해서 교반한다. 원심분리기를 사용하여 뇨와 흡착제를 분리한다. 흡착제를 증류수로 세척한다. 추출시약과 흡착제를 탱크에 넣고 교반한다. 원심분리기를 이용하여 흡착제를 제거하고 남은 용액에 유안(황산암모늄)을 첨가하여 혈전용해제를 추출한다. 또한 효소가 들어있는 용액에 용해도가 큰 황산암모늄을 사용하거나 황산암모늄의 농도를 달리함으로써 염류를 용해시켜 효소단백질을 축출하여 효소단백질을 분별 침전시키기도 한다. 염석(염류를 가하여 추출) 후 효소 단백질은 반투막에 넣어 흐르는 물에 담가서 염류를 없애는 투석을 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8523","dJobECdNm":"[8523]화학제품 생산기계 조작원(고무·플라스틱 제외)","dJobJCd":"8321","dJobJCdNm":"[8321]화학제품 생산기 조작원","dJobICd":"C211","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003726:1', '{"dJobCd":"K000003726","dJobCdSeq":"1","dJobNm":"가류성형기조작원","workSum":"성형 공정을 거친 유연한 생 타이어를 일정한 틀(몰드)에 넣어 열과 압력을 가해 원하는 모양의 제품이 만들어지도록 가류성형기를 조작한다.","doWork":"작업지시서를 읽고 성형하려는 형태에 따라 금형을 선택한다. 수동공구를 사용하여 가류기 내부에 금형을 설치한다. 고무제품의 종류·두께에 따라 가류기의 스팀밸브를 열고 압력게이지를 확인하여 가류기를 예열시킨다. 해당 규격의 몰드 속에 반제품을 넣고 일정한 시간 동안 내외부에서 압력과 열을 가해, 유황과 다른 화학약품이 고무와 반응을 일으키도록 한다. 몰드 속에서 가류되는 동안에는 압력이 굉장히 높을 뿐 아니라 부위별로 온도가 다를 수 있기 때문에 고무의 쏠림 현상이 발생할 수 있는데, 이를 방지하기 위해 몰드에 구멍을 뚫어 사용하기도 한다. 가류된 고무제품의 이물질을 없애기 위해 정제된 물로 세척하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"가류기조작원, 가황기조작원","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001727:1', '{"dJobCd":"K000001727","dJobCdSeq":"1","dJobNm":"고무내리원","workSum":"천연고무나 합성고무 등을 고객요구사항에 맞는 고품질 고무제조를 위하여 고무의 탄력과 강도를 높이며 압착하는 롤러기를 조작·관리한다.","doWork":"작업지시서의 내용에 따라서 롤링을 하고자 하는 천연고무나 합성고무 등을 롤러기로 이동시킨다. 천연고무나 합성고무를 롤러기의 좌우에서 당겨 기계에 고정하고 기계를 가동한다. 밸브를 돌려 고무와 칼날 사이에 물이 흐르도록 하고 일정한 크기로 절단한다. 기계의 증기밸브를 조절하여 롤러를 일정 온도로 가열한다. 고무판의 두께를 조절하기 위해 롤러의 간격을 조정한다. 절단한 고무를 압착하기 위해 롤러에 밀어 넣는다. 롤러를 냉각시키기 위해 냉각수밸브를 연다. 롤러를 통과한 고무를 건조시키기 위해 건조대에 건다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006405:1', '{"dJobCd":"K000006405","dJobCdSeq":"1","dJobNm":"고무롤성형가공원","workSum":"다양한 용도(방직용, 인쇄용, 가공용, 특수용 등)에 사용되는 고무롤을 제조하기 위하여 철심 위에 고무생지를 감아서 가공하는 작업을 한다.","doWork":"가공된 고무판의 불순물을 확인하여, 솔벤트로 고무판의 오물 등 이물질을 제거한다. 충진제는 체에 쳐서 내림가공을 한다. 롤러의 철심은 염산수와 물을 작업표준에 맞게 섞은 용액에 일정 시간 담근 후에 건류한다. 1, 2차에 걸쳐서 케미록을 도포한다. 1차 도포를 통해서 철심, 천 등의 불순물을 닦아내고 2차 도포에서는 접착강도를 높인다. 손이나 호이스트를 사용하여 고무롤 성형기 안에 철심을 넣고 브러시를 사용하여 고무접착제를 칠한다. 철심이 회전을 하도록 기계의 시동을 건다. 철심의 둘레에 지시된 양의 고무판을 감고 겹쳐 잇는다. 감은 부분의 주름·기포를 제거하기 위하여 수동 또는 자동 압착롤을 사용하여 누른다. 부착된 선반기를 사용하여 일정한 길이로 자른다. 각각 끝에 마무리용 고무스트립을 접착하고 덧붙인다. 경화를 위하여 완성된 롤에 천을 감는 경우도 있다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"균형감각|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"합성롤제조원","certLic":"위험물산업기사, 위험물기능사","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004727:1', '{"dJobCd":"K000004727","dJobCdSeq":"1","dJobNm":"고무배합롤러기조작원","workSum":"천연고무, 합성고무 등의 고무원료와 가황제, 분산제 등 배합약품을 혼합·분산시키는 고무혼합 롤러기를 조작·관리한다.","doWork":"작업지시서를 확인하고 배합약품과 기후조건 등을 고려해 스팀밸브를 열어 롤러의 표면을 지시된 온도로 유지한다. 혼합된 고무원료의 조건에 따라 롤러의 간격을 결정하고, 간격 조정레버를 회전하여 롤러의 간격을 조정한다. 롤러를 작동시키고 롤러와 맞닿는 부위에 고무원료 및 배합제를 올려놓고 혼합·분산시킨다. 배합되어 떨어지는 고무의 두께 및 분산상태를 보고 레버를 돌려 간격을 점차 좁힌다. 칼을 사용하여 배합된 고무판을 삼각 형태로 접고 롤러의 상단에 올려 완전히 분산될 때까지 반복한다. 혼합·분산된 고무판을 일정한 두께로 잘라 걸대에 건다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"Roll작업자, 고무배합조작원, 고무믹싱원","connectJob":"고무제품롤러기계조작원","certLic":"위험물산업기사, 위험물기능사","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004035:1', '{"dJobCd":"K000004035","dJobCdSeq":"1","dJobNm":"고무성형침지기계조작원","workSum":"골무 모양의 고무제품(고무장갑, 핑거코트, 콘돔 등)을 제조하기 위하여 고무용액 속에 성형체를 침지시켜 성형품을 만들기 위한 고무성형침지기계를 조작한다.","doWork":"고무골무 모양의 유리몰드가 일정한 간격으로 부착된 컨베이어 체인을 작동시킨다. 연속적으로 운전하면서 적정한 수준까지 숙성이 진행된 라텍스 고무용액에 유리몰드를 침지(Dipping)시킨다. 유리몰드 표면에 묻힌 라텍스 고무용액은 열풍 건조실을 통과해 건조가 되면서 몰드 표면에 고무골무 형태의 피막을 형성하는데, 안정적인 피막을 형성하기 위해 침지와 반복을 수차례 실시한다. 형성된 피막은 회전 브러시를 통과하면서 상당 부위에 일정한 굵기의 테두리(링)가 만들어진다. 테두리가 형성된 피막은 약품을 희석한 물에 침지시켜 몰드로부터 피막을 분리하기 용이하도록 부풀린다. 부풀려진 피막은 수압에 의해 몰드로부터 분리되며, 분리된 피막은 고무골무의 모양을 가지게 된다. 피막이 분리된 유리몰드는 세척단계를 거친 후 상기과정을 반복한다. 분리된 고무골무 피막은 고무의 끈끈한 성질에 의한 접착을 방지하고 피막 중에 잔류하고 있는 미반응 약품 및 불순물을 제거하기 위해 적정온도로 가열된 물속에서 일정 시간 교반시킨다. 처리된 고무골무는 탈수하여 가황기에 투입한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"몰드조작원, 금형조작원","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006700:1', '{"dJobCd":"K000006700","dJobCdSeq":"1","dJobNm":"고무압착기조작원","workSum":"철구조물이 함유된 고무판·고무벨트 등의 고무제품을 주형한 성형 재료를 금형의 캐비티(움푹 패인 곳)에 넣고 재료가 경화될 때까지 가열 가압하기 위하여 자동 또는 수동 프레스기를 적용⋅조작한다.","doWork":"고무제품의 종류에 따라 주형을 선택하여 압착기로 옮긴다. 주형의 내부 면에 윤활유나 이형제를 바른다. 주형 위에 고무원료를 넣고 금형의 상판을 덮는다. 제품의 특성에 따라 압착기의 간격을 조절하고 주형을 압착기로 밀어 넣는다. 압착기의 작동스위치를 누르고 가감저항기를 돌려 지정된 온도와 압력을 유지한다. 작업표준절차서의 내용에 따른 일정한 경화시간이 지나면 압착기에서 주형을 꺼낸다. 주형의 상판을 열고 제품을 꺼낸다. 제품의 견본을 시험 의뢰한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"발포고무압착기조작원, 벨트압착기조작원, 성형기조작원, 성형압착기조작원, 수압식증기압착기조작원","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003716:1', '{"dJobCd":"K000003716","dJobCdSeq":"1","dJobNm":"고무재단기조작원","workSum":"판으로 된 고무생지를 원하는 모양으로 재단하기 위하여 프레스 또는 유압식재단기를 조작한다.","doWork":"작업지시서의 내용에 따라 필요한 고무생지의 종류와 양을 파악한 후 컨베이어나 지게차로 고무생지를 운반하여 재단기에 올려놓는다. 재단 칼이나 재단기에 부착된 재단 칼의 상태를 확인하고 조작스위치를 눌러 일정한 모양과 크기로 절단한다. 절단된 고무생지를 저울에 달아 중량을 확인한다. 재단이 완료된 고무생지를 숙성실로 이동시킨다. 작업장 주변을 정리정돈한 후 재단 칼의 성능을 검사하고 파손된 것을 교환한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"고무재단기조작원","connectJob":"발포고무압착기조작원, 벨트압착기조작원, 성형압착기조작원","certLic":"위험물산업기사, 위험물기능사","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006030:1', '{"dJobCd":"K000006030","dJobCdSeq":"1","dJobNm":"고무절단기조작원","workSum":"소련·혼련을 하기 위해 천연고무, 합성고무 등의 원료고무 덩어리를 적당한 크기로 절단한다.","doWork":"원료고무를 소련(혼련기를 사용하여 원료고무의 분자사슬을 기계적으로 절단하여 점탄성을 떨어뜨리는 작업)·혼련(열과 기계를 이용하여 고르게 섞는 작업) 합성하기 전, 원료고무를 적당한 크기로 절단하기 위해 원료고무 덩어리를 카트나 호이스트를 이용하여 절단기 입구에 올려놓는다. 원료고무의 온도를 측정하여 절단하기 좋은 온도로 맞춘다. 절단기의 레버를 당겨 원료고무를 절단한다. 절단 작업이 완료된 원료고무를 세척 롤에서 세척하기도 한다. 절단된 원료고무를 배합카드에 기록된 중량만큼 저울로 측정하여 소련·혼련 공정으로 이동시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"고무절단기조작원","connectJob":"절단공정원, 제품절단원","certLic":"위험물산업기사, 위험물기능사, 품질경영산업기사","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001992:1', '{"dJobCd":"K000001992","dJobCdSeq":"1","dJobNm":"고무제품마무리원","workSum":"성형·압출된 고무제품을 고객이 요구하는 규격에 맞게 가공하기 위해 작업표준절차서에 맞는 장비를 조작·관리한다.","doWork":"성형과 압출 공정을 거친 고무제품을 가공하기 위해 각종 장비(보링기계, 튜빙절단기, 연삭용 선반 등)와 수동공구를 사용하여 조정한다. 성형한 고무 부품, 개스킷, 튜빙, 롤 등을 특정 기계장치에 장착하고 기계를 작동시켜 부품에 구멍을 뚫는다. 튜빙에서 와셔를 잘라 내거나, 튜빙을 길이로 자르거나, 튜빙과 기계 롤을 크기에 맞게 연마한다. 캘리퍼스, 자, 플러그게이지, 형판 등을 사용하여 고무제품의 크기와 형태를 검사한다. 가공이 완료된 단품들을 포장공정으로 이송하거나 조립공정으로 보낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"고무제품사상원","connectJob":"롤연삭원, 보링기조작원, 선반조작원, 와셔절단원","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004169:1', '{"dJobCd":"K000004169","dJobCdSeq":"1","dJobNm":"고무제품성형원","workSum":"고객이 요구하는 고무제품을 제조하기 위하여 제품성형 분야의 고무제품 성형 기초이론 및 제품성형 현장 실무지식을 사용하여 고무제품 설비점검, 성형, 작업 시 문제해결 등의 정해진 업무를 수행한다.","doWork":"고무제품 설비의 성능을 유지하기 위하여 정기점검, 일상점검과 같은 점검계획에 따라 주요 성형설비와 주변기기를 점검, 보수한다. 압출성형, 사출성형, 캘린더링, 프레스 성형 등의 공법 및 가교방법을 선택하여 고무제품을 생산한다. 작업장의 안전 확보 및 환경오염을 방지하기 위해 고무제품 성형 시 발생하게 될 위험요소를 파악하고 작업을 실시한다. 사고 발생 시 감독자의 지시나 작업지시서에 따라 적절한 대응을 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"고무롤성형원, 재생타이어성형원, 호스제조원, (고무제품명)성형작업자","dJobECd":"8524","dJobECdNm":"[8524]고무·플라스틱 제품 조립원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003311:1', '{"dJobCd":"K000003311","dJobCdSeq":"1","dJobNm":"고무제품수선원","workSum":"완성된 고무제품(구명대, 구명조끼, 고무판, 고무호스, 튜브 등)이 고객의 요구조건에 부적합품이 발생하면 표준작업 절차서에 따라 가열기, 고압로, 증기중화인두 등을 사용하여 고무제품을 수선한다.","doWork":"각종 고무제품(구명대, 구명조끼, 고무판, 고무호스, 튜브 등)의 외관을 살피거나 검사기기를 이용해 결함 유무를 확인한다. 찢긴 곳이나 손상된 부분에 고무조각을 붙이고 가열기·고압로·증기중화인두를 사용하여 고무조각을 경화시킨다. 고무조각으로 금속이나 다른 제품의 표면을 덮는다. 수선된 부분의 외관상 결함을 검사한다. 주형이나 거푸집을 이용하여 손상부분을 수리하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006836:1', '{"dJobCd":"K000006836","dJobCdSeq":"1","dJobNm":"고무제품제조현장감독자","workSum":"고객이 요구하는 각종 고무제품(구명대, 구명조끼, 고무판, 고무호스, 튜브 등)을 작업표준절차서에 따라 제조하고자 고무원료를 분쇄·혼합·사출·압출·조립하는 작업원들의 안전을 지원⋅관리하고, 활동을 감독·조정한다.","doWork":"고객이 요구하는 (PQCDA)에 각종 고무제품의 생산량을 작업지시서에 따라 필요한 원부재료의 수량을 작업반원에게 미리 준비를 시킨다. 작업시작 전 작업반원에게 중대재해법과 관련된 TBM훈련(Tool Box Meeting)후 업무를 분장한다. 각 공정에 원료의 투입 현황을 파악하고 각 고무 제품의 종류별로 생산을 확인하면서 적정 생산량을 관리한다. 작업장의 장치 및 기기에 대해 이상 여부를 확인하고 이상발생시 즉시 작업을 중지하고 문제점을 파악해 상부에 보고를 한 후 지시를 받는다. 작업장 주변의 정리정돈 상태를 점검하고 개선을 한다. 중대재해처벌법에 대한 법적 규정에 따라 안전 규정 준수 여부를 철저히 확인한다. 작업자의 안전을 위해 공정 위험 요소를 발견하고 위험성평가를 반기별로 진행하고, 수시면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴하고 문제점을 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","similarNm":"고무제품제조반장","certLic":"위험물산업기사, 위험물기능사","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001421:1', '{"dJobCd":"K000001421","dJobCdSeq":"1","dJobNm":"고무제품주형청소원","workSum":"고객이 요구하는 고무제품을 만들기 위하여 작업절차서에 따라 제조공정에서 사용한 주형(鑄型)을 다음 작업을 위하여 분해해서 청소하고 이물질을 제거한 후 청결하게 지정된 장소에 보관한다.","doWork":"작업표준절차서에 따라 공정순서에 따라 주형을 압착기, 사출기 등에서 분해한 후 주형에 증기를 분무시켜 보호기름이나 이물질 등을 제거한다. 손이나 호이스트 등을 사용하여 주형을 뜨거운 청소용액에 담가 달라붙은 고무입자를 제거한다. 수건이나 철솔 등을 사용하여 롤에 붙은 조각을 완전히 제거한다. 보관하기 전에 주형에 기름을 발라서 녹이 끼는 것을 방지한다. 주형에 녹이 끼었을 경우 모래분사기를 사용하여 주형을 청소하고 변형된 주형은 전문수리소에 의뢰해서 수리한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|고온|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007353:1', '{"dJobCd":"K000007353","dJobCdSeq":"1","dJobNm":"고무컴파운딩작업원","workSum":"고무제품에서 요구되는 특성을 만족시키기 위하여 컴파운딩의 기초이론 및 컴파운딩 실무지식을 사용하여 컴파운딩 작업, 후단공정작업, 설비점검, 작업 시 문제해결 등의 정해진 업무를 수행한다.","doWork":"작업조건에 따라 원료고무에 여러 가지 약품을 첨가하고 고무배합기를 이용하여 고무컴파운딩 작업을 수행한다. 최적의 고무배합물을 제조하기 위해 원료를 개량하고 가공조건과 설비조건을 설정하는 등 고무배합 공정을 설정한다. 고무배합물을 제조하기 위해 작업지시서에 따라 고무컴파운딩 조건을 설정하고 안정적인 고무배합물 제조를 위해 배합설비 및 주변설비를 점검하여 유지·관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"힘든 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005247:1', '{"dJobCd":"K000005247","dJobCdSeq":"1","dJobNm":"고무판제작원","workSum":"직물, 포장박스, 목재 및 기타 여러 가지 재료에 도안과 문자를 인쇄하는데 사용되는 고무판 또는 합성수지판을 제작한다.","doWork":"인쇄롤러의 둘레 또는 도안 및 문구의 규격에 맞추어 고무판을 칼로 자른다. 연필이나 기계제도 도구를 사용하여 고무판 위에 적당한 규격으로 도안 및 문자를 압형한다. 다색 인쇄에 적당한 도안 및 문자를 여러 개의 고무판에 색상에 따라 재배치하고, 칼로 오목 또는 블록형의 무늬를 조각한다. 조각된 내용과 규격 등을 원도와 비교·검사한다. 고무판을 프레스에 고정하거나 인쇄롤러에 장치할 수 있도록 판의 양면에 구멍을 뚫고 보강쇠를 끼운다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"인쇄기능사","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C181","dJobICdNm":"[C181]인쇄 및 인쇄관련 산업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003661:1', '{"dJobCd":"K000003661","dJobCdSeq":"1","dJobNm":"고무혼합원","workSum":"전선을 제조하기 위하여 고무원료(합성고무, 천연고무 등)에 배합약품(보강제, 충전제 등)을 혼합·반죽한 후 절연체 위에 피복·건조하는 혼합기를 조작·관리한다.","doWork":"작업지시서에 따라 고무원료와 각종 배합약품을 준비한 후 계량대로 이동시킨다. 고무배합 표준의 내용에 따라 각각의 재료를 전자저울을 이용하여 순차적으로 계량한다. 계량된 재료를 고무배합 설비로 이동시킨다. 배합별 연화제와 촉진제를 계량한다. 집진기와 혼합기를 가동한 후 고무배합 재료를 투입한다. 고무가 골고루 혼합되는지 확인하고 체임버(Chamber)의 온도를 수시로 확인한다. 재료가 완전히 혼합되면 연화제와 촉진제를 투입하고 혼합한다. 고무혼합 작업이 끝나면 장비를 확인검사하고 주위를 정리정돈한다. 생산결과를 기록서에 기록하고 결과를 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"고무배합원","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C283","dJobICdNm":"[C283]절연선 및 케이블 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003309:1', '{"dJobCd":"K000003309","dJobCdSeq":"1","dJobNm":"그린타이어검사원","workSum":"성형·접착·조립 공정을 거친 반제품 타이어를 작업표준과 비교·검사하기 위하여 각종 계측기기를 이용해 치수, 중량, 외관 상태 등을 검사한다.","doWork":"카카스, 비드, 사이드(림프렌지 포함), 재단물, PA제품, 트레드(Tread)의 폭과 측면의 범위를 권척자나 갤리퍼스, 다이얼 게이지로 측정한다. 규정된 허용오차에 일치하는지 타이어의 무게, 외관을 측정하고 타이어에 중량기록을 한다. 스냅게이지, 권착자, 다이얼 게이지를 사용하여 타이어 성형에 필요한 재료들의 두께를 측정한다. 육안으로 가공된 제품의 외관 상태를 검사한다. 이상이 없으면 다음 공정으로 이동시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"미완성타이어검사원, 그린케이스검사원, 생타이어검사원 ","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001244:1', '{"dJobCd":"K000001244","dJobCdSeq":"1","dJobNm":"라텍스사제조원","workSum":"배합된 라텍스(Latex)로부터 라텍스 리본이나 실을 제조하는 기계를 조작·관리한다.","doWork":"작업지시서의 내용에 따라 응고제의 농도, 건조기의 온도, 롤러의 회전속도 등을 조절한다. 펌프를 작동시키고 노즐이 달린 드럼에 배합이 완료된 라텍스를 충진한다. 에어컴프레서를 작동시켜 라텍스를 압출한 후 노즐을 통해 라텍스 고무줄이 나오게 한다. 노즐에서 나오는 라텍스 고무줄을 응고제 탱크, 세척 탱크, 건조기의 롤에 걸어 잡아당긴다. 일정한 수의 빗살에 노즐에서 나오는 고무줄을 끼워 고무줄을 낱개로 분리하고 일정한 장소에 고정한다. 1차 건조기를 통해 나오는 고무줄을 적당한 수로 묶어 밴드 형태로 만들고, 2차 건조기의 롤에 걸어 건조시킨다. 제품의 상태에 따라 건조기의 온도, 롤의 회전속도 등을 재조정 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005022:1', '{"dJobCd":"K000005022","dJobCdSeq":"1","dJobNm":"라텍스제조원","workSum":"접착성을 부여하거나 카펫 코팅을 위해 라텍스(Latex)를 조제하여 저장탱크에 저장한다.","doWork":"작업지시서나 처방서에 따라 일정량의 라텍스 드럼을 개봉하고 공기압력장치를 이용하여 탱크에 투입한다. 암모니아수나 양잿물 등의 알칼리수 및 촉진제 등 기타 부재료를 탱크에 투입하고 교반기를 사용하여 혼합한다. 혼합된 라텍스를 공기압력장치를 이용해 저장탱크로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001827:1', '{"dJobCd":"K000001827","dJobCdSeq":"1","dJobNm":"라텍스제품마무리원","workSum":"성형된 라텍스(Latex) 제품을 형기(Former)에서 벗기고 표면처리를 한 후 세탁·건조하는 작업을 한다.","doWork":"경화·성형이 완료된 라텍스 제품을 형기(Former)로부터 벗기기 위하여 물 펌프를 가동시킨다. 완성된 라텍스 제품을 밀차에 옮겨 세탁기에 넣고, 표면처리를 위하여 규정된 양의 약품을 세탁기에 넣는다. 표면처리가 완료된 라텍스 제품을 건조기에 넣고 전원스위치를 조정하여 건조시간과 건조온도를 조정한다. 건조가 완료되면 밀차에 넣고 다음 공정으로 운반한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"힘든 작업","workPlace":"실내","workEnv":"대기환경미흡|다습|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004784:1', '{"dJobCd":"K000004784","dJobCdSeq":"1","dJobNm":"라텍스제품제조현장감독자","workSum":"라텍스(Latex) 원료를 이용해 각종 라텍스 제품을 생산하는 데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"제조하고자 하는 라텍스 제품의 생산량을 파악하고 필요한 원부재료의 수량을 작업원에게 준비를 시킨다. 작업원에게 안전과 관련된 규정을 교육한 후 업무 분장을 한다. 작업원과 함께 작업을 하면서 원료의 투입 현황을 파악하고, 라텍스 제품의 종류별로 생산 확인을 하면서 적정 생산량을 관리한다. 작업장의 장치 및 기기에 대해 이상 여부를 확인하고 작업원에게 제반 사항에 대해 조치를 취하도록 하며, 문제점을 파악해 상부에 보고를 한 후 지시를 받는다. 작업장 주변의 정리정돈 상태를 점검하고 개선을 한다. 환경에 대한 법적 규정에 따라 안전 운전을 하고 규정 준수 여부를 철저히 확인한다. 공정 위험 요소를 발견해 보고를 하기도 한다. 수시면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴하고 문제점을 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","similarNm":"라텍스제품제조반장","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003761:1', '{"dJobCd":"K000003761","dJobCdSeq":"1","dJobNm":"마네킹고무주형원","workSum":"마네킹에 부착하는 손·다리·머리 등을 형틀에 넣고 액체고무나 실리콘을 이용해 주형한다.","doWork":"제조하고자 하는 마네킹에 맞는 형틀을 준비해 작업대 위에 올려놓는다. 주형작업을 마친 마네킹 부위를 형틀에서 떼어내기 쉽도록 형틀의 내부에 이형제를 바른다. 액체고무나 실리콘이 형틀 안에 가득 차도록 붓는다. 액체고무나 실리콘이 굳으면 칼을 사용해 형틀에서 마네킹 부위를 떼어낸다. 떼어낸 마네킹 부위의 표면을 다듬고 사포로 연마한다. 작업 후 제품의 외관상 결함을 검사한다. 작업일지에 일일 작업물량을 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"마네킹머리제조원, 마네킹손제조원","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C339","dJobICdNm":"[C339]그 외 기타 제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002091:1', '{"dJobCd":"K000002091","dJobCdSeq":"1","dJobNm":"만년필튜브검사원","workSum":"제조된 만년필에 튜브를 결합하기 전에 튜브 부분의 기밀(기체가 통하지 못하게 밀폐함)을 검사한다.","doWork":"기밀측정기의 기압상태를 확인하고 작업표준에 따라 기밀측정기의 스위치를 조작한다. 유리그릇에 물을 일정량 준비하고 작업대에 타월을 깔아 놓는다. 기밀측정기 호스에 튜브를 한 개씩 결합하여 유리그릇에 담가 조사한다. 공기가 새지 않는 튜브를 목부분과 결합한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C339","dJobICdNm":"[C339]그 외 기타 제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006399:1', '{"dJobCd":"K000006399","dJobCdSeq":"1","dJobNm":"만년필튜브성형기조작원","workSum":"만년필을 제조하기 위하여 만년필 튜브를 성형하는 기계를 조작한다.","doWork":"작업표준에 따라 튜브액을 배합하여 혼합기에 투입한다. 혼합된 튜브액을 배기(밖으로 공기를 빨아냄)시키기 위하여 진공탱크에 넣고 진공펌프스위치를 조작한다. 튜브금형을 작업표준에 따른 일정 온도까지 올리기 위하여 가열기에 넣고 작동시킨다. 가열된 튜브금형을 가열기에서 꺼내어 튜브액을 칠한 후, 금형을 건조기에 넣는다. 건조기에서 건조된 금형을 꺼내어 냉각시킨다. 성형된 제품을 에어기(Air Machine)를 사용하여 튜브를 떼어낸다. 튜브의 색상, 두께, 기포, 터짐 등을 육안이나 도구(게이지 등)를 사용하여 검사한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C339","dJobICdNm":"[C339]그 외 기타 제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004086:1', '{"dJobCd":"K000004086","dJobCdSeq":"1","dJobNm":"발포고무경화원","workSum":"고무혼합물을 이용한 기포고무판을 만들기 위해 컨베이어 경화(硬化) 장치를 조작·관리한다.","doWork":"일정한 농도의 고무 배합을 얻기 위하여 고무와 공기를 혼합탱크에 보내는 펌프를 가동한다. 농도가 제품표준에 맞는지를 측정하기 위해 측정용 컵으로 견본의 무게를 달기도 한다. 배합된 화합물을 고무와 함께 혼합용 탱크 안으로 펌프질하고 혼합시키는 교반기를 가동한다. 벨트 컨베이어를 가동하고 고무관의 넓이를 일정하게 조절하는 조정나사를 돌린다. 경화용 가열기의 열량을 조절하고자 조정나사를 돌린다. 고무 혼합물을 경화용 가열기의 벨트 컨베이어 위로 이송한다. 자 등을 사용하여 경화된 고무판의 크기를 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003336:1', '{"dJobCd":"K000003336","dJobCdSeq":"1","dJobNm":"밴드기계조작원","workSum":"고무밴드를 제조하기 위하여 고무밴드의 중간제인 고무튜브를 만드는 밴드사출기를 조작·관리한다.","doWork":"카렌다롤을 거친 일정한 두께의 고무판을 고무밴드의 크기에 맞추어 절단한다. 절단된 고무판을 접착제를 사용하여 접착하고 밴드사출기 위에 설치한다. 사출기의 끝에 설치된 링 모양의 구멍을 지닌 금형(쇠틀)에 통과하여 튜브 형태로 제작을 한다. 사출과 동시에 튜브 안에는 공기가 주입되어 손상을 억제하게 된다. 완성된 튜브를 건조대에 올려 건조시키고 높은 온도에서 가류시킨다. 제조된 튜브는 절단공정으로 이동시킨다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005379:1', '{"dJobCd":"K000005379","dJobCdSeq":"1","dJobNm":"밴드절단기조작원","workSum":"고무밴드를 제조하기 위하여 가류공정을 거친 고무튜브를 일정한 크기로 자르는 절단기를 조작·관리한다.","doWork":"수동공구를 사용하여 고무밴드 절단기 공급 롤의 속도를 조절하는 기어를 조정한다. 쉽게 절단하고자 튜브를 물에 세척하고 튜브를 공급 롤에 오게 한다. 고무튜브를 일정한 크기의 고무밴드로 절단하는 기계를 작동시킨다. 떨어지는 밴드를 운반상자에 받아 물로 씻어낸다. 세척된 고무밴드는 끊어짐을 방지하기 위한 약품을 칠한 후에 건조기에 통과시켜 건조를 하거나 자연건조를 시킨다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002013:1', '{"dJobCd":"K000002013","dJobCdSeq":"1","dJobNm":"벨트성형원","workSum":"벨트컨베이어에 사용되는 벨트(평형, V형, U형 등)를 제조하고자 항장체(Carcass)에 커버고무(Cover Rubber)를 부착하고 압착한다.","doWork":"원통형으로 감긴 항장체(Carcass)의 끝을 성형기에 밀어 넣어 장착한다. 항장체 위에 커버고무(Cover Rubber)를 부착하고 롤러를 사용하여 압착한다. 자동 절단기의 칼날을 회전시켜 제품규격에 맞게 절단한다. 성형기에서 고무벨트를 뽑아내고 하나씩 낱개로 분리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|다습|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"브이벨트성형원, 컨베이어벨트성형원","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003587:1', '{"dJobCd":"K000003587","dJobCdSeq":"1","dJobNm":"벨트피복원","workSum":"컨베이어벨트, 브이벨트 등에 고무를 입힌 천을 피복(被覆:바깥 부분을 감쌈)시키기 위하여 카버링기를 조작·관리한다.","doWork":"제작하고자 하는 벨트를 기계의 바퀴에 걸고 바퀴를 팽창시켜 벨트를 팽팽하게 한다. 마찰 처리된 피복의 끝을 가이드 위에 놓고 벨트를 피복시키기 위하여 기계의 페달을 밟아 피복지가 클립장치 사이로 들어가게 한다. 벨트에 피복지가 쌓이도록 벨트를 회전시키고 피복지 끝을 자른다. 피복 시 발생되는 기포 등을 제거하고 걸대에 건다. 이송물이 놓이는 상부에는 이송물의 종류 및 용도에 따라 각종 재질(PVC, 우레탄, 고무)로 코팅을 하고, 드럼(Drum)이나 풀리(Pulley)가 닿는 하부에는 용도에 따라 각종 재질을 용착하여 저소음·내마모성의 효과를 얻고 주행성을 증대시키기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"브이벨트카버링원, 브이벨트피복원","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002045:1', '{"dJobCd":"K000002045","dJobCdSeq":"1","dJobNm":"브이벨트절단기조작원","workSum":"제품표준에 맞는 치수·형상의 V(브이) 모양을 만들기 위하여 경화(硬化)하지 않은 고무벨트의 하층부를 깎아 성형하는 절단기를 조작·관리한다.","doWork":"벨트를 뒤집어 기계의 풀리에 걸고 벨트를 팽팽하게 당겨 고정시킨다. 절단 칼의 각도를 조절하기 위하여 절단칼날과 고정나사를 움직여 각도를 조절한다. 기계를 작동하여 벨트를 회전시키면서 하부층을 제품표준에 맞는 브이(V) 모양으로 깎는다. 깎여진 벨트의 무게를 달고 무게가 맞지 않을 때에는 칼날 또는 나사를 돌려 각도를 다시 조절한다. 벨트를 기계에서 분리하고 벨트를 바로 뒤집어 걸대에 건다. 브이벨트의 양 모서리를 절단하기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"브이벨트스카이빙원","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003261:1', '{"dJobCd":"K000003261","dJobCdSeq":"1","dJobNm":"사열형압축롤조작원","workSum":"직물에 고무를 입히거나 플라스틱 필름, 비닐, 장판 등을 제조하기 위하여 사열형 압축롤을 조작·관리한다.","doWork":"자동제어기를 조정하고 온도계를 확인하여 지시된 온도로 압축롤을 가열한다. 기계를 가동시키고 컨베이어의 속도를 조정하여 재료의 공급을 조절한다. 지시된 세팅에 따라 롤러 조절 휠을 돌려 압착시키기 위하여 직물을 편다. 게이지와 자로 재료의 두께와 폭을 확인한다. 칼을 적당한 위치에 설치하여 직물의 가장자리를 다듬는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"시범후 30일 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C221/C222","dJobICdNm":"[C221]고무제품 제조업 / [C222]플라스틱제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005110:1', '{"dJobCd":"K000005110","dJobCdSeq":"1","dJobNm":"소방호스경화원","workSum":"피복(被覆:바깥 부분을 감쌈)된 소방호스의 고무를 경화(硬化)시키기 위해 증기가열장비를 조작·관리한다.","doWork":"일정한 길이의 고무판(Tubing)과 끈으로 짠 직물 호스재킷을 테이블 위에 올려놓는다. 고무관이 재킷에 붙지 않도록 관에 동석(Soapstone) 가루를 뿌린다. 고무관을 스톡 휠(Stock Wheel)에 감기 위하여 크랭크를 돌린다. 재킷을 꿰매는 기계장치로 고무관을 당기는 윈치(Winch:로프를 원통에 감아올려 중량물을 끌어올리거나 도르래를 끼워 매다는 기중기의 일종)를 가동시킨다. 피복된 호스의 끝을 증기관 위에 들어 올려 고정물이 움직이지 않게 고정시킨다. 경화시킬 때는 평평하게 된 곳에 호스를 놓는 작업대 위에 있는 경화용 캐비티(Cavities) 속으로 호스를 누른다. 경화하기 위한 지시된 온도와 압력으로 호스 속에 증기를 주입시키기 위하여 게이지를 관찰하여 밸브를 돌린다. 경화가 완료된 소방호스를 저장용 선반 위에 놓는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007697:1', '{"dJobCd":"K000007697","dJobCdSeq":"1","dJobNm":"압연기레드오프원(코드준비원)","workSum":"재료공정인 압연공정에서 압연기 준비대에 패브릭 코드지를 밀착시키는 분지작업을 한다.","doWork":"규정된 작업지시서에 의하여 타이어 내부의 강도를 강화하고 형태를 유지하는 뼈대 역할을 하는 중요한 소재인 패브릭 코드지를 준비하면서 운전자 보조 직무 및 양성업무를 수행한다. 압연기를 사용하여 코드지를 타이어 고무층과 밀착시키는 압연작업을 한다. 압연기 운전보조원 직무까지 수행하면서 압연기 운전원 부재 시 대행을 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"위험물산업기사, 위험물기능사","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2025"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005460:1', '{"dJobCd":"K000005460","dJobCdSeq":"1","dJobNm":"압연기운전원","workSum":"폴리에스터, 레이온, 나일론코드지에 고무층을 압연기의 상. 하롤에 공급된 얇은 고무층을 압연기에서 설정된 온도. 압력. 속도를 유지하면서 압착(수퀴즈 압력)하여 요구하는 압착정도, 두께, 폭, EPI균일성, 표면 등 품질을 확보하도록 압연기를 운전. 조작한다.","doWork":"직조기에서 생산된 타이어코드 원단을 인출 장치(Let Off)에 준비한다. 가열기(Heater)와 장력 조정장치 스위치를 작동하여 요구 물성 특성이 발현되도록 기계장치의 각 구간별 온도 설정하고 장력을 부여한다. 타이어코드 원단에 얇은고무가 일정하게 압착되도록 고무접착층 공급장치(Dip Bath)와 여분의 접착액을 흡입하는 장치를 확인한다. 기계를 가동 중일 때에 고무접착층이 압착되는 상태를 관찰하고 냉각을 하도록 하여 결점이 없고, 권취 형태가 균일하도록 확인하고 점검한다. 권취기에서 타이어코드지가 일정 길이에 도달하면 절단하여 생산이력을 기록하고 포장을 한 후 보관장으로 이동한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"톱핑원","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C221/C222","dJobICdNm":"[C221]고무제품 제조업 / [C222]플라스틱제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002037:1', '{"dJobCd":"K000002037","dJobCdSeq":"1","dJobNm":"에어백제조원","workSum":"반제품 타이어를 가류하기 위하여 타이어와 같은 형태·크기의 타이어 에어백(Air Bag)을 제조하고, 규정된 수명을 준수하여 노후화된 에어백을 재생하고, 재생이 어려운 에어백은 교체한다.","doWork":"경화되지 않은 에어백을 타이어 규격에 따라 정해진 길이로 절단한다. 칼을 사용하여 절단된 에어백을 지시된 각도로 도려낸다. 접합시킬 부분에 접착제를 바르고 접착제가 건조되면 절단된 단면을 맞추어 접합기(Splicer)에 올려놓고 압착시킨다. 노화된 에어백을 재생시키기 위하여 연마기(Buffing Machine)를 사용하여 연마하고 접착제를 발라 필요한 고무를 부착한다. 에어백을 경화시키기 위하여 가류기를 조작하기도 한다. 제작이 완료된 에어백은 타이어 가류를 위한 공정으로 이동시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"관련없음","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"에어백제조기조작원, 에어백제조기운전원 ","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002567:1', '{"dJobCd":"K000002567","dJobCdSeq":"1","dJobNm":"엽상기조작원","workSum":"고무·스펀지고무 등을 이용해 일정한 모양으로 만든 시트들을 연속적으로 결합시키는 기계를 조작·관리한다.","doWork":"카트나 컨베이어벨트를 사용해서 고무·스펀지고무 등의 재료들을 옮긴 후 호이스트를 사용해서 받침대로 올려놓는다. 두 재료를 완전하게 접착시키기 위하여 회전반의 속도, 결합용 롤러의 압력을 조절한다. 기계를 시동하고 레버를 움직여서 클러치가 맞물리게 하여 재료가 감기게 한다. 회전하는 재료의 하나를 기울어지게 하여 장력을 조절하고 롤의 반대편 끝에 재료를 정돈시킨다. 감긴 재료의 가장자리를 잡아당기거나 이송하여 다른 롤과 함께 정돈한다. 이송 중 어느 하나가 비게 될 때 감는 작업을 멈추고 가위를 사용해서 다른 재료들을 잘라 길이를 맞춘다. 사용되지 않은 재료의 끝을 테이프로 묶고 길이 지시계를 읽고 롤에 남아있는 양을 표시한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005318:1', '{"dJobCd":"K000005318","dJobCdSeq":"1","dJobNm":"유압성형기조작원","workSum":"고무 제품을 만들기 위해 금형에 삽입된 고무생지를 가압·가열하는 유압프레스를 조작·관리한다.","doWork":"작업지시서의 내용에 따라 고무생지를 금형의 크기, 제품의 형태에 따라 일정하게 자른다. 금형의 뚜껑을 열고 고무생지를 적정 위치에 삽입한다. 금형뚜껑을 닫고 유압밸브를 작동하여 프레스열판을 올려 가압한다. 프레스의 스팀압력게이지를 보고 열판의 온도를 확인한다. 설정된 압력에서 제품에 따라 수차례 공기를 빼는 일을 반복한다. 작업지시서에 설정된 가류시간이 되면 유압밸브를 작동하여 프레스의 열판을 내리고 금형뚜껑을 열어 가류성형된 제품을 금형으로부터 분리한다. 성형된 제품의 표면상 결함사항을 검사한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"힘든 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004585:1', '{"dJobCd":"K000004585","dJobCdSeq":"1","dJobNm":"이중호스접착원","workSum":"이중호스(고온용, 고압용, 산업용)를 만들기 위해 고무호스의 여러 면을 붙이는 기계를 조작·관리한다.","doWork":"이중호스를 만드는 기계의 디스펜서(Dispenser)에 고무접착제를 붓고 접착제의 흐름을 조절하기 위해 밸브를 돌린다. 연결하는 호스의 여러 면을 부드럽게 하는 연마기를 조절한다. 공급롤러 사이로 호스를 통과시키기 위하여 기계를 작동시킨다. 게이지를 사용하여 호스의 직경을 측정한다. 연결부분이 고른지 확인하기 위해 이중호스를 검사한다. 검사표를 호스에 붙인다. 상표를 호스에 새기는 고무호스 낙인기를 조작하기도 한다. 열이나 불로부터 호스를 보호하기 위하여 석면을 씌우거나 감기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"이중호스접착기조작원, 호스접착원","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002028:1', '{"dJobCd":"K000002028","dJobCdSeq":"1","dJobNm":"재생타이어가류기운전원","workSum":"미경화상태의 트레드가 부착 완료된 재생타이어를 경화성을 부여하기 위해 가류공정에서 가류기를 조작한다.","doWork":"타이어의 종류와 패턴에 따른 가류 조건을 확인한다. 패턴이 없는 트레드가 부착된 재생타어는 금형(몰드)이 설치된 가류기를 조작하여 설정된 시간. 압력과 온도를 가하여 새로운 패턴을 생성한다. 패턴이 있는 트레드를 부착한 재생타이어는 체임버에 넣어 일정 온도와 압력으로 트레드와 타이어 본체를 결합시킨다. 가류가 완료된 재생타이어는 검사공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"재생가류기운전원","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003642:1', '{"dJobCd":"K000003642","dJobCdSeq":"1","dJobNm":"재생타이어검사원","workSum":"재생타이어를 만들기 위하여 수거한 폐타이어를 검사한 후 재생할 폐타이어를 선별한다.","doWork":"폐타이어 흠집의 크기를 타이어확장기로 확장시켜 재생 가능 여부를 판단하고 결정한다. 건조시킨 타이어의 노후화 상태를 망치로 두드려 울림소리를 듣고 판단한다. 비파괴검사기로 스틸코드의 손상 유무를 확인한다. 재생 가능한 타이어를 분류·표시한다. 재생 가능한 타이어는 수분 및 이물질을 제거하고 건조실에 입고하여 일정 정도의 온도에서 하루 정도 건조하여 수분을 완전히 제거한다. 재생 가능한 타이어는 재가공할 기본형상을 만드는 버핑(연마공정)으로 이동하여 버핑기에 장착한다. 일정한 압력과 속도로 트레드부를 벨트 스틸코드가 노출되지 않도록 연마한 다음 재생하지 못하는 폐타이어는 폐기장소로 이송한다. 재생 가능한 타이어는 작업일지에 기록하고 트레드부를 재상하기 위한 공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002089:1', '{"dJobCd":"K000002089","dJobCdSeq":"1","dJobNm":"재생타이어성형원","workSum":"재생타이어를 만들기 위하여 트레드부를 버핑연마한 트레드부에 특수 고무풀칠을 한 폐타이어에 트레드(Tread: 타이어 특유의 홈이 파진 형태) 고무를 붙여 성형한다.","doWork":"재생 타이어의 버핑(Buffing)정도, 타이어의 종류, 패턴, 재생 작업방법에 따라 알맞은 고무시트를 결정한다. 금형설계와 제품설계에 근거한 용적분포에 따라 균형 있는 타이어의 형태로 새로운 트레드 고무를 덧씌운다. 버핑작업이 완료되면 흠집 마무리 작업을 하여 성형(트레드고무를 붙이는 작업)한다. 성형은 고무풀(솔벤트 등과 고무풀용 고무의 혼합물)을 버핑부에 칠하고 보강 패치를 접착시켜 자동성형기에서 성형기 내에 정해진 프로그램에 따라 트레드용 고무의 두께, 양, 넓이 등을 자동으로 측정·성형한다. 성형작업이 완료된 타이어는 공정일지에 따라 몰드 번호별로 분류되어 가류(가황)공정으로 이동시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005394:1', '{"dJobCd":"K000005394","dJobCdSeq":"1","dJobNm":"재생타이어완제품검사원","workSum":"재생가류가 완료된 재생타이어의 외형(외관)과 트레드 부착상태 및 가류 시 이상유무 등을완제품 검사기준에 의하여 검사한다.","doWork":"가황이 완료된 재생타이어는 트레드의 접합상태를 확인하고 가류과정에서 손상이 없는지 외관과 패턴의 이상 유무를 육안으로 검사한다. 가류가 완료된 트레드의 두께와 위치와 규정두께에 이상이 없는지 검사한다. 검사가 완료된 재생타이어는 보관과 출하를 위해 적치장소로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"재생타이어검사원","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007699:1', '{"dJobCd":"K000007699","dJobCdSeq":"1","dJobNm":"정련공정MCC조작원","workSum":"약품 및 고무배합에 필요한 원재료, 부재료 및 약품 등을 자동으로 평량하고 배합기에 공급하는 역할을 하는 MCC(Machine Control Center)에서 배합기 전체의 정상적인 운전을 하고 이상 시 조치를 취한다.","doWork":"정련공정에서 고무배합에 필요한 오일, 카본 및 고무, 약품 등을 대부분 자동으로 계량하여 배합기에 투입하게 되는데, 이 과정에서 각 설비 및 원재료, 부재료. 약품, 오일 등이 사양에 맞게 투입되는지 등을 컨트롤 룸에서 통제하고 조작한다. 이상 시 신속한 조치를 취한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"위험물산업기사, 위험물기능사","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2025"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001971:1', '{"dJobCd":"K000001971","dJobCdSeq":"1","dJobNm":"중량측정및배합원","workSum":"합성고무 제품을 제조하기 위하여 배합약품(고무에 혼합)을 준비한 후 중량을 측정하고 제품표준에 맞게 배합한다.","doWork":"작업지시서의 내용에 따라 배합에 필요한 각종 배합약품들의 종류와 수량을 파악한다. 원재료 창고에서 필요한 약품을 출고하고 배합실로 운반한다. 배합카드의 내용에 따라 필요한 배합통을 작업대에 진열하고 작업지시서에 명시된 양만큼 저울로 측정한 후 일정 비율로 배합하여 배합통에 쏟아 넣는다. 측정이 끝난 배합통을 모아 필요한 양을 혼합 작업장까지 카트로 운반하고 나머지는 배합통 보관소에 보관한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"위험물산업기사, 위험물기능사","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006803:1', '{"dJobCd":"K000006803","dJobCdSeq":"1","dJobNm":"지우개제조원","workSum":"지우개를 제조하기 위하여 원료를 분쇄·압출하고 규격에 맞게 절단하는 일을 한다.","doWork":"가소화(찌는 작업)되어 일정 크기로 잘라진 원료(천연고무, 합성고무, 친환경 재료 등)를 분쇄기에 투입한다. 원료를 가루로 만들기 위하여 분쇄기를 조작한다. 원료가 가루상태가 되면 작업표준에 명시된 색상의 안료와 혼합한다. 안료와 혼합한 원료를 일정한 형태로 만들기 위하여 압출기에 투입한다. 압출기 작동스위치를 조작한다. 절단기를 사용하여 압출한 지우개를 규격별로 절단한다. 절단한 지우개를 연마기로 연마한다. 성형된 지우개의 견본을 채취하여 크기, 중량 등을 검사한다. 지우개 표면에 회사의 상호나 제품명 등을 인쇄한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"지우개성형검사원, 지우개성형원, 지우개원료분쇄원, 지우개인쇄원, 지우개재단원","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006206:1', '{"dJobCd":"K000006206","dJobCdSeq":"1","dJobNm":"진공성형기조작원","workSum":"고무판으로 제품을 만들기 위하여 진공성형기를 조작·관리한다.","doWork":"스위치를 넣어 성형기 내의 가열기를 예열한다. 성형기의 온도, 진공도, 압력을 확인하고 성형기의 스위치를 넣는다. 고무시트를 성형기에 넣는다. 시제품이 나오면 제품의 두께, 무게, 성형상태를 확인하고 기계를 조정한다. 성형이 끝나면 성형품의 외관의 티끌을 제거한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"성형기조작원","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C221/C222","dJobICdNm":"[C221]고무제품 제조업 / [C222]플라스틱제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004725:1', '{"dJobCd":"K000004725","dJobCdSeq":"1","dJobNm":"캘린더권취장치조작원","workSum":"고무나 플라스틱을 피복한 천과 합성하기 위하여 캘린더롤에 있는 권취 및 건조장치를 조작·관리한다.","doWork":"호이스트를 사용하여 권취장치 감개에 직물이 감긴 롤을 올려놓고 기계를 작동시킨다. 권취되는 천의 폭을 일정하게 유지하고 주름을 방지하기 위하여 가이드롤(Guide Roll)을 조정한다. 권취공정 중 찢어진 부분이 나오면 기계가동을 중단하고 파손된 부분을 재봉기를 사용하여 꿰매어 수선한다. 캘린더롤조작원(고무제품제조·플라스틱제품제조)의 신호에 따라 권취속도를 조절한다. 재료의 결함이나 고장을 점검하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"심금기조작원, 코드권취원","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C221/C222","dJobICdNm":"[C221]고무제품 제조업 / [C222]플라스틱제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003741:1', '{"dJobCd":"K000003741","dJobCdSeq":"1","dJobNm":"캘린더롤조작원","workSum":"고무 또는 플라스틱 시트를 제조하기 위하여 배합·혼련 공정을 거친 원료를 일정한 두께로 압연하는 캘린더롤을 조작·관리한다.","doWork":"캘린더롤을 가동하기 위한 온도, 압력, 조작상태 등을 점검한다. 모터스위치를 눌러 캘린더롤을 가동시킨다. 배합·혼련 공정을 거친 고무 또는 플라스틱 시트의 폭을 일정하게 자르기 위하여, 정해진 간격에 맞게 롤의 하부 양쪽에 절단날을 설치한다. 제어패널의 두께조절버튼, 롤의 회전속도 조절버튼, 온도조절스팀밸브 등을 조정한다. 시트가 캘린더롤을 통과하면서 일정한 폭을 유지하도록 한다. 캘린더롤을 통과한 고무 또는 플라스틱 시트를 엠보·냉각공정으로 자동 이송한다. 이때 시트에 기포·덩어리·줄·오목한 곳 등의 결함사항이 있는지 관찰하고 표시한다. 고무시트가 완전히 성형될 때까지 일정 시간 동안 선반 위에 방치하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C221/C222","dJobICdNm":"[C221]고무제품 제조업 / [C222]플라스틱제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002831:1', '{"dJobCd":"K000002831","dJobCdSeq":"1","dJobNm":"캘린더롤현장감독자","workSum":"직물을 입힌 고무나 플라스틱시트를 제조하기 위해 캘린더롤을 조작하는 작업원의 활동을 감독·조정한다.","doWork":"제품에 따른 고무, 플라스틱, 직물 등의 종류와 스팀의 온도, 롤의 압력, 회전속도 등을 결정한다. 작업을 할당하고 신입 작업원을 훈련시킨다. 작업내용에 따라 작업원에게 지시·배치한다. 작업의 진행상황을 파악하고 작업내용을 보고한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원 및 자재를 공급한다. 작업계획에 따라 세부실행항목을 수립하고 작업절차 및 방법을 결정하여 작업원에게 작업내용을 지시하고 작업배치를 한다. 표준작업명세에 따라 지시된 작업이 이루어지는지 작업원과 함께 작업하며 작업상황을 관찰하며 작업내용을 점검한다. 작업원의 직무교육 및 안전위생 교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴·해결하고 문제점을 보완한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|고온|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"캘린더롤반장","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C221/C222","dJobICdNm":"[C221]고무제품 제조업 / [C222]플라스틱제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003028:1', '{"dJobCd":"K000003028","dJobCdSeq":"1","dJobNm":"캘린더와인더기조작원","workSum":"캘린더롤을 통과해 엠보·냉각 공정을 거친 시트를 롤형태로 감고 일정한 길이와 폭으로 자르기 위하여 캘린더와인더 기계를 조작·관리한다.","doWork":"라이너가 쉽고 정확하게 풀리도록 걸대에 호이스트를 이용하여 건다. 박스를 축에 끼워 권취장치에 장착한다. 라이너와 함께 박스에 말리도록 반제품을 끼운 다음 스위치를 넣어 권취한다. 규정된 길이까지 작업이 완료되면 가위로 절단하고 호이스트로 걸어 창고에 보관한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C221/C222","dJobICdNm":"[C221]고무제품 제조업 / [C222]플라스틱제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006762:1', '{"dJobCd":"K000006762","dJobCdSeq":"1","dJobNm":"타이어검사원","workSum":"가류 공정에서 완성된 타이어의 외관 및 인너부(내부), 비드부를 검사하여 제품표준과 일치하는지 확인·검사한다.","doWork":"손이나 호이스트를 사용하여 타이어를 회전테이블 위에 올린다. 타이어의 내부흠집, 이물질, 기타 결함을 조사하고자 타이어를 회전시키며 외관검사를 한다. 비드(Bead)를 살펴서 비틀림을 알아내고 타이어의 내부표면을 조사하여 펼쳐진 코드(Cord), 플라이(Ply) 등의 변형·균열을 탐지한다. 가황불량, 형태 불균형, 기타 불량품 등을 선별한다. 결함부분을 표시하고 부적합품처리 또는 수리를 의뢰한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003411:1', '{"dJobCd":"K000003411","dJobCdSeq":"1","dJobNm":"타이어경화원","workSum":"그린타이어(생타이어)를 가황(가류)하기 위한 가류기를 운전, 조작한다.","doWork":"제조하고자 하는 타이어의 종류에 따라 가류성형기에 알맞은 금형(몰드)이 설치되어 있는지 확인한다. 설치된 금형(몰드)에 이물이 없도록 압축공기를 이용하여 세척한다. 그린타이어와 브래더(Bladder), 금형(몰드)에 이형제를 도포하고 그린타이어를 가류기에 장착한다. 작업표준에 맞는 증기압을 이용하여 설정된 압력. 온도. 시간이 경과한 후 취출하여 검사공정으로 컨베이어를 통하여 이송하는 작업을 반복한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"타이어가황원, 타이어주형원, 가류기운전원, 가류기조작원 ","connectJob":"재생타이어가황원","certLic":"설비보전기능사","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007694:1', '{"dJobCd":"K000007694","dJobCdSeq":"1","dJobNm":"타이어고무사이드압출기운전원","workSum":"타이어 부품에 필요한 고무 제품을 제조하기 위하여 유황배합 고무를 제조사양에 맞게 준비하고 사이드 압출기를 가동하여 적정온도를 설정하여 압출한다.","doWork":"사이드(sidewall, 타이어의 사이드 측면) 압출물 작업 공정의 중간검사에서 합격된 압출용 고무를 준비한다. 고무를 컨베이어 벨트를 이용하여 압출기 호퍼존까지 인출하여 압출기에 투입 후 적정속도로 압출하여 냉각라인을 통과하고 냉각 후 적재한다. 일정 시간 방치한 후 조립공정인 성형공정에 운반하여 사용한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"위험물산업기사, 위험물기능사","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2025"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003263:1', '{"dJobCd":"K000003263","dJobCdSeq":"1","dJobNm":"타이어롤재단기운전원","workSum":"타이어의 플라이(Ply)를 제조하기 위하여 고무층과 코드가 결합된 토핑코드지(Topping Cord)를 규격별로 절단하는 기계를 조작·관리한다.","doWork":"고무층과 코드가 결합된 토핑코드지(Topping Cord)를 재단기에 인출하여 핸들을 조정 제품표준에 맞는 각도와 폭으로 맞춘다. 호이스트 또는 지게차를 사용하여 토핑코드지(Topping Cord)를 레트오프(준비대)에 올려놓고 레트오프(준비대)의 롤로부터 토핑코드지를 잡아당겨 재단기의 나이프 전단(바로 앞)까지 유도한 다음 폭. 각도를 맞춘다. 기계를 작동시키면서 공급 속도와 절단작업의 속도를 조절해 재단하여 권취기에 적정 길이로 권취한 다음 그린타이어를 제조하는 성형공정으로 이송하여 규격에 맞추어 성형하는 반제품으로 사용한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"재단작업원","connectJob":"캪플라이(Capply)스리팅재단원","certLic":"설비보전기능사","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002913:1', '{"dJobCd":"K000002913","dJobCdSeq":"1","dJobNm":"타이어브래더제조원","workSum":"타이어의 브래더(Bladder)를 제조하기 위하여 고무재료를 접합·성형시키는 기계를 조작·관리한다.","doWork":"브래더(Bladder)를 만들기 위한 고무재료의 끝에 접착제를 바르고 양 끝을 접합하는 압착기를 사용하여 원형 모양이 되도록 재료를 맞붙인다. 원형으로 접합된 고무재료를 저울에 달아 제품규격과 일치하는지 확인한다. 블래더를 성형하는 프레스의 몰드(금형) 안에 원형으로 접합된 고무재료를 넣고 설정된 시간, 온도, 압력을 가한다. 수동연마기나 연마기를 이용하여 사상 후 성형된 블래더를 다듬고 매끈하게 한다. 돔형 가류기 등에서 일정시간.온도.압력 조건으로 가황(가류)한 후 완성된 브래더는 냉각. 보관 후 타이어를 성형하기 위한 성형 및 가류(가황) 공정으로 보낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"브래더제조원, 브래더작업원, 성형기조작원","connectJob":"타이어브래더경화원, 타이어브래더사상원 ","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001896:1', '{"dJobCd":"K000001896","dJobCdSeq":"1","dJobNm":"타이어비드제조원","workSum":"타이어 비드(Bead:타이어를 자동차 림에 장착시키는 부품)를 제조하기 위하여 철선(Wire)에 고무를 토핑(Topping)하는 기계를 조작·관리한다.","doWork":"동과 주석의 합금이 도금되어 있는 강선에 고무를 입힌 다음 타이어 규격에 맞도록 원형으로 감아 커버링 작업을 한다. 동으로 도금된 고강력 스틸와이어와 일정한 두께의 고무를 입혀서 여러 층으로 감고(와이어는 타이어 종류와 크기에 따라서 횟수를 다르게 감는다), 여기에 필러(충진물) 고무를 덮어 하나의 비드를 만든다. 모아진 스틸와이어는 작은 싱글 롤러 다이(Single Roller Die)와 버플다이(Buffle)를 통과하면서 강선(와이어) 사이에 코어 고무가 코팅된다. 이렇게 만들어진 비드에 얇은 삼각형 고무(Apex: 에이펙스)를 덧붙여 비드의 강도를 보강하면 비드 과정이 모두 완성된다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"비드성형기계조작원, 비드기조작원, 비드제조원","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001531:1', '{"dJobCd":"K000001531","dJobCdSeq":"1","dJobNm":"타이어성형기조작원","workSum":"타이어를 제조하기 위해 전 공정에서 만들어진 비드(Bead), 카카스(Carcass), 벨트, 트레드(Tread), 사이드, 인너라이너 등을 결합하여 접착 및 생타이어(그린타이어)를 만든다.","doWork":"수동공구나 게이지를 사용하여 플라이 스티쳐 롤러(Ply Stitcher Roller)와 드럼을 재료의 폭에 따라 조절한다. 인너라이너를 규정폭과 길이로 절단하여 드럼에 감아 부착한다. 플라이를 드럼의 가장자리에 놓는다. 드럼을 회전시키고 일정한 수의 플라이를 감아 타이어의 몸체가 되도록 한다. 플라이를 가닥이음자리에서 자르고 양 끝을 함께 압착한다. 견고히 압착하고자 일정하게 방향을 바꾸면서 압착롤러(스폰지 프레스롤)로 밀착시키는 작업을 되풀이 한다. 스위치를 눌러 비드를 플라이 위에 압착하는 비드 세트를 움직이게 하고 비드의 상향에서 플라이의 가장자리를 회전시키는 롤러에 맞춘다. 트레드를 감기 위하여 드럼을 회전한다. 드럼이 회전할 때 트레드와 플라이를 접착시키는 롤러를 가동한다. 생타이어가 완성되면 드럼을 오므러들게(off)하고, 타이어를 언로딩하여 GTHS(Green Tire Handling System)를 이용하여 스프레이 공정으로 이동한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"타이어성형원, 타이어성형사, 타이어성형기운전원, 타이어성형제조원","certLic":"설비보전기능사, 금형기능사","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007696:1', '{"dJobCd":"K000007696","dJobCdSeq":"1","dJobNm":"타이어수리원","workSum":"가류공정에서 완성된 타이어를 검사표준에 따라 수리 후 재사용이 가능한 타이어로 만든다.","doWork":"가류공정에서 완성된 타이어를 최종 검사를 위한 검사공정으로 컨베이어를 통해 이송한다. 자동검사 또는 수작업 검사를 거친 후 사이드월을 제외한 부위에 가황과정에서 이물질 등 경미한 결함이 발생한 경우에는  수리표준 작업방법에 따라 수리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"위험물산업기사, 위험물기능사","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2025"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002270:1', '{"dJobCd":"K000002270","dJobCdSeq":"1","dJobNm":"타이어제조현장감독자","workSum":"타이어를 제조하기 위해 정련·압출·압연·재단·성형·가류·검사 공정에 종사하는 작업원의 생산관리, 품질관리, 원가(불량), 납기(재고), 안전관리, 설비관리 활동을 감독·조정한다.","doWork":"작업원의 업무 내용과 책임 한계를 명확히 해 효율적인 생산이 이루어지고 안전사고가 발생하지 않도록 작업지시서에 따른 업무 분장을 하고 작업 시작 전 안전교육을 한다. 작업원에게 안전과 관련된 규정을 교육시키고, 안전 관련 규정의 준수 여부를 확인하고 점검한다. 원료의 공정 투입 현황을 파악하고, 타이어 제품의 규격별로 생산 확인을 하면서 적정 생산량을 관리한다. 작업장의 장치(설비) 및 주변기기에 대해 이상 여부를 확인하고 작업원들에게 제반 사항에 대해 조치를 취하도록 하며, 문제점을 파악해 상부에 보고를 한 후 지시를 받는다. 작업장 주변의 정리·정돈·청소 상태를 점검하고 조치를 한다. 환경에 대한 법적 규정에 따라 안전 운전을 하고 규정 준수 여부를 철저히 확인한다. 공정 위험 요소를 발견해 보고하기도 한다. 수시면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴하고 문제점을 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","similarNm":"타이어제조반장","certLic":"용접기능사, 설비보전기능사, 지게차운전기능사","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007693:1', '{"dJobCd":"K000007693","dJobCdSeq":"1","dJobNm":"타이어조립부품PA운전원","workSum":"성형시간을 단축하고 품질향상을 위해 사이드 압출공정에서 압출된 사이드 압출물과 인너 압연기에서 작업된 인너라이너를 접합(Assembly)한다.","doWork":"사이드(sidewall, 타이어의 사이드 측면) 압출물과 압연공정에서 작업된 인너라이너(in-liner, 내부 공기 차단층)를 PA(Pre Assembly Machine)의 접합기를 조작하여 Press Roll 및 간격조절기로 접합한다. 접합 후 적정 길이로 권취한 다음 일정시간 방치 숙성 후 성형 공정에 지게차로 운반한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"위험물산업기사, 위험물기능사","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2025"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005574:1', '{"dJobCd":"K000005574","dJobCdSeq":"1","dJobNm":"튜브성형가공원","workSum":"항공기 부품인 유압배관과 산소계통에 사용되는 튜브를 성형·제작한다.","doWork":"작업표준서나 설계도면을 보고 작업에 필요한 공구 및 자재를 준비한다. 준비된 튜브를 규격에 맞게 절단하고 끝부분의 날카로운 부분을 부드럽게 가공한다. 작업사양에 맞는 공구를 선택하고 장비에 장착한다. 시험 작동을 한 후, 장비에 데이터를 입력하여 성형작업을 실시한다. 성형작업이 완료된 후 측정 장비를 이용해 성형된 튜브를 측정하고 표면을 연마한다. 완성된 제품의 이상 유무를 확인하여 필요한 경우 제품을 보정한다. 용도에 따라 플랜지(Flange, 관(管)과 관, 관과 다른 기계부분을 결합할 때 쓰는 부품), 슬리브(Sleeve, 관(管) 계통에 사용되는 파이프 피스) 등을 장착하기도 한다. 튜브의 재질과 사양에 맞는 공구를 장비에 물리고 스웨징(Swaging:형철에 얹거나 넣어 두들겨 구부리는 것) 작업을 한다. 작업 완료 후 결함을 확인한다. 제작이 완료된 튜브를 압력 시험기에 장착하고 규정된 압력에서 유체누설 및 파손 여부를 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"웅크림|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"판금제관기능장, 판금제관산업기사, 공유압기능사","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C313","dJobICdNm":"[C313]항공기, 우주선 및 부품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006408:1', '{"dJobCd":"K000006408","dJobCdSeq":"1","dJobNm":"튜브압출원","workSum":"고무호스 등에 사용되는 고무튜브를 제조하기 위해 튜브 압출기를 조작·관리한다.","doWork":"제품에 맞는 금형을 선택하고 수동공구를 사용하여 기계의 헤드에 고정시킨다. 제품표준에 맞게 정해진 온도로 금형 및 기계를 가열하기 위하여 스팀밸브를 돌리거나 가열기에 불을 붙인다. 기계를 작동시키고 일정한 압출속도·두께·폭 등을 조절하는 조절기를 돌린다. 특히 튜브를 압출할 때에는 배합고무에 커다란 압력을 가하여 고무 속의 기포가 생기지 않도록 한다. 손이나 컨베이어를 사용하여 일정량의 고무원료를 기계에 공급한다. 고무가 접착하는 것을 방지하기 위하여 활석을 분사한다. 게이지·자 등을 사용하여 압출한 고무의 두께를 검사한다. 튜브에 구멍을 뚫고 주위를 사포로 연마한다. 연마한 부위에 고무풀을 바르고 건조상태를 확인한 후 밸브를 구멍에 맞추어 부착시킨다. 컨베이어와 압출속도를 일치시키기 위하여 바퀴를 돌리거나 레버를 잡아당기기도 한다. 압출되어 나오는 고무제품을 적정 길이로 절단하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"튜브압출기조작원","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004163:1', '{"dJobCd":"K000004163","dJobCdSeq":"1","dJobNm":"튜브절단기조작원","workSum":"고무호스 등에 사용되는 고무튜브를 제조하기 위해 압출된 고무튜브를 제품표준에 맞는 크기로 잘라내기 위한 기계를 조작·관리한다.","doWork":"작업지시서의 내용을 확인한 후 특정 절단주기에 맞게 절단기의 조정판을 조절한다. 튜브가 컨베이어 위를 통과할 때 절단기를 작동시키거나, 튜브를 정지장치에 대고 끝을 잘라 비스듬하게 한다. 트레드나 측면 벽부분이 자동화된 보조장비를 통과하는 것을 살펴보고 보조장비에서 확인번호를 찍는다. 트레드와 측면 벽에 접착제를 붙이고 기준에서 벗어나는지를 알아내기 위해 무게를 측정한다. 기계의 잘못된 기능과 공정상의 결함에 관해 튜브압출원에게 알린다. 찍고, 붙이고, 표시하는 기계의 저장 통을 채운다. 가위로 트레드와 측면 벽을 일정한 길이로 자르기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"내부튜브절단원","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001310:1', '{"dJobCd":"K000001310","dJobCdSeq":"1","dJobNm":"튜브접합원","workSum":"고무호스 등에 사용되는 튜브를 원형 혹은 다른 형상으로 만들기 위하여 경화(硬化)되지 않은 튜브를 크기에 맞게 절단하고 접착한다.","doWork":"비경화 튜브를 접합대 위에 접은 상태로 올려놓고 절단가위를 사용하여 제품표준에 맞는 길이로 절단한다. 받침판을 경화되지 않은 튜브 위에 걸쳐놓고 단면부를 맞춘다. 주걱을 사용하여 단면부를 압착·접합한다. 접합부가 접합기의 중심부에 위치하도록 놓고 양손으로 기계를 작동시킨다. 접합이 끝난 후 밸브구멍으로 공기를 주입하고 눌린 부분을 분리한다. 삽입된 공기를 제거하고 포장용기에 담는다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007695:1', '{"dJobCd":"K000007695","dJobCdSeq":"1","dJobNm":"트레드오토부킹조작원","workSum":"압출기에서 압출된 트레드 및 사이드 압출물을 표준에 정해진 길이로 절단하여 자동 부킹 장비를 조작하여 제품을 제조하고 적재 및 운반하고 교체한다.","doWork":"자동화된 방식의 설비로 트레드(노면에 접촉하는 부분)를 조립하거나 정렬하기 위해 적정길이로 절단된 제품의 트레드를 오토 북킹(Auto Booking: 자동적재장치)에 적재하도록 적재장비를 조작한다. 적재가 완료되면 공정이동 전표를 부착하고 일정 시간 보관한다. 보관 시간 경과 후 숙성된 트레드를 운반카를 이용하여 성형공정에 공급한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"위험물산업기사, 위험물기능사","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2025"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004569:1', '{"dJobCd":"K000004569","dJobCdSeq":"1","dJobNm":"편조기조작원","workSum":"고무제품의 강도를 높이기 위하여(고압호스의 내압 유지, 선박용 전선의 외면보호 등의 목적) 천이나 철사를 꼬아 제품표면을 둘러싸는 편조기를 조작·관리한다.","doWork":"작업지시서에 따라 편조를 하기 위한 줄·고무절연물·철사 등을 준비한 후 편조기(강선 및 실 등을 규칙적으로서 엮어서 짜는 기계)에 설치한다. 고무접착제가 기계 속에 자동적으로 흘러 들어가게 하면서 기계를 작동시킨다. 줄이나 철사재료가 일정한 간격과 동일한 장력을 유지하도록 조정기를 조절한다. 호스나 전선의 사용여건과 압력 등에 따라서 편조층은 이중으로 하기도 하는데, 이때 편조층의 중간에 중간 고무를 넣기도 한다. 작업이 완료되면 끊어진 줄이나 헐거운 꼬임이 있는지 살펴보고 끊어진 줄을 잇거나 장력을 조절한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"편상원, 편조원","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006845:1', '{"dJobCd":"K000006845","dJobCdSeq":"1","dJobNm":"호스제조원","workSum":"고무질화된 직물이나 고무튜브, 점성고무, 플라이 재료 등을 가공해 공업용 호스를 제조한다.","doWork":"고무튜브와 플라이재료를 용제와 고무시멘트를 이용하여 접착성 표면으로 만든다. 내면 고무층에 철심(맨도링)을 넣는다. 맨도링을 회전시키고 플라이 재료를 고무튜브로 보내서 호스를 형성시킨다. 자나 측정기 또는 게이지로 호스의 치수를 재고 과도한 고무는 칼로 잘라낸다. 보강층을 만들기 위해 포를 포층수 폭으로 재단(포에 고무를 돕핑한 것)하여 감은 후 외연 고무층을 감는다. 이것을 랩핑하여 대차 위에서 가류를 시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"포권식호스제조원","dJobECd":"8521","dJobECdNm":"[8521]타이어·고무제품 생산기계 조작원","dJobJCd":"8322","dJobJCdNm":"[8322]타이어 및 고무제품 생산기 조작원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005303:1', '{"dJobCd":"K000005303","dJobCdSeq":"1","dJobNm":"강화플라스틱제조원","workSum":"플라스틱제품을 강화하기 위하여 유리섬유와 수지를 적출하고 보강·연마·착색 등의 작업을 한다.","doWork":"작업도면을 보고 제작할 강화플라스틱의 형태 및 두께, 강도, 색상 등을 확인한다. 완성된 목형, 수지형, 기타 석고형 또는 연마한 철판 등의 형틀을 준비한다. 형틀에 이형제를 도포한 후 얇은 두께의 표면매트(Surface Mat)를 사용하여 내식층을 만든다. 건조 후 상태를 확인하고 형에서 탈형시킨다. 설계도면과 일치하는지 줄자, 버니어캘리퍼스 등의 측정기기로 치수를 확인한다. 외관을 동력연삭기나 사포 등으로 매끄럽게 만든다. 제품표면을 겔코트(Gelcoat)로 착색하고 건조시켜 원하는 색상을 얻는다. 강화플라스틱을 만들기 위해 유리섬유 대신 탄소섬유나 아라미드섬유 등을 사용하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"FRP제조원","connectJob":"겔코트원, 목형원, 보강원, 적층원, 탈형원","dJobECd":"8522","dJobECdNm":"[8522]플라스틱제품 생산기계 조작원","dJobJCd":"8323","dJobJCdNm":"[8323]플라스틱제품 생산기 조작원","dJobICd":"C222","dJobICdNm":"[C222]플라스틱제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001585:1', '{"dJobCd":"K000001585","dJobCdSeq":"1","dJobNm":"강화플라스틱제조현장감독자","workSum":"유리섬유 등으로 강화플라스틱을 제조하는 데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"제작설계 도면을 검토하여 목형, 석고형, 수지형 등의 형틀에서부터 적층완료 시까지의 작업방법 및 작업절차를 계획하고 작업원에게 작업내용을 지시하고 작업배치를 한다. 관련 부서별 업무분담을 한다. 표준작업명세에 따라 지시된 작업이 이루어지는지 작업원과 함께 작업하며 작업상황을 관찰하며 작업내용을 점검한다. 재료 및 자재를 공급·관리하며 작업원에게 기술적 지원 등의 직무교육 및 안전교육을 통해 안전재해를 예방한다. 완성된 제품을 제작도면과 비교하여 이상이 있을 시 부서별로 교체를 지시한다. 작업원의 작업상황을 관리·감독하고 작업내용과 생산량 등을 기록하여 보고한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","similarNm":"FRP제조반장, 강화플라스틱제조반장","dJobECd":"8522","dJobECdNm":"[8522]플라스틱제품 생산기계 조작원","dJobJCd":"8323","dJobJCdNm":"[8323]플라스틱제품 생산기 조작원","dJobICd":"C222","dJobICdNm":"[C222]플라스틱제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005249:1', '{"dJobCd":"K000005249","dJobCdSeq":"1","dJobNm":"경화성수지성형기조작원","workSum":"경화성 수지제품을 제조하기 위하여 요소·멜라민 등의 수지원료를 가열·압착시키는 성형기를 조작·관리한다.","doWork":"작업지시서를 확인하고 제품의 형태와 사용할 수지 및 원료를 확인·점검한다. 일정량의 분말수지원료를 저울 등을 사용하여 계량하고 금형 위에 부어 성형기에서 압착 가열하거나 유체상태로 녹인 분말수지를 금형에 부어 순간 냉각에 의해 형상을 만든다. 일정한 압력과 온도를 게이지를 통해 확인하고 일정한 시간이 지나면 핸들을 작동하여 금형에서 제품을 빼낸다. 제품의 면을 연마기 또는 사포로 연마한다. 제품표면의 결함, 흠 등을 검사하여 불량품을 분리한다. 제품 표면에 색상 또는 무늬를 새기기 위하여 성형된 제품에 색상이나 무늬가 도안된 천 또는 종이를 올려놓고 성형기를 작동하기도 한다. 공기호스와 수동공구를 사용하여 금형과 기계를 청소하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8522","dJobECdNm":"[8522]플라스틱제품 생산기계 조작원","dJobJCd":"8323","dJobJCdNm":"[8323]플라스틱제품 생산기 조작원","dJobICd":"C222","dJobICdNm":"[C222]플라스틱제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005362:1', '{"dJobCd":"K000005362","dJobCdSeq":"1","dJobNm":"낚싯대경화원","workSum":"낚싯대 제조 시 굴대(Mandrel)의 원단에 사용한 결합제를 접착·경화시키기 위해 고온으로 소성하는 전기로를 조작·관리한다.","doWork":"전기로의 스위치를 돌린다. 굴대(Mandrel)에 도포한 낚싯대 재료의 종류에 따라 작업표준에 맞는 일정 온도로 예열한다. 이송컨베이어의 걸대에 굴대를 놓고 전기로의 온도를 확인한다. 레버를 눌러 컨베이어를 가동하고 굴대가 전기로에 투입되는 과정을 확인한다. 전기로의 출구로 소성되어 나오는 낚싯대의 견본을 채취하여 경화상태를 검사한다. 일정 온도로 냉각되면 운반통이나 작업대 위에 경화된 낚싯대를 적재한다. 경화상태가 불량인 제품을 선별하여 제거하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8522","dJobECdNm":"[8522]플라스틱제품 생산기계 조작원","dJobJCd":"8323","dJobJCdNm":"[8323]플라스틱제품 생산기 조작원","dJobICd":"C333","dJobICdNm":"[C333]운동 및 경기용구 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003846:1', '{"dJobCd":"K000003846","dJobCdSeq":"1","dJobNm":"낚싯대롤링원","workSum":"낚싯대를 제조하고자 굴대(Mandrel)에 부착된 원포를 단단하게 압착·성형하는 기계를 조작·관리한다.","doWork":"원단과 굴대가 접착되는 부위에서 이물질을 제거한다. 기계의 온도·압력 스위치를 조정하고 이동거리 레버를 돌려 조정한다. 원포가 부착된 굴대를 기계에 올려놓고 기계가동 스위치를 누른다. 굴대(Mandrel)에 원포가 단단하게 말아지면 보조적인 원포를 감아 마무리한다. 소재에 이상이 있는지 검사하고 운반통에 담는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"롤링기조작원","dJobECd":"8522","dJobECdNm":"[8522]플라스틱제품 생산기계 조작원","dJobJCd":"8323","dJobJCdNm":"[8323]플라스틱제품 생산기 조작원","dJobICd":"C333","dJobICdNm":"[C333]운동 및 경기용구 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005448:1', '{"dJobCd":"K000005448","dJobCdSeq":"1","dJobNm":"낚싯대수지가공원","workSum":"낚싯대 원단에 수지(PP, PET 등)를 입히기 위해 수지함침설비를 조작·관리한다.","doWork":"작업지시서에 따라 수지원료(PP, PET 등)를 함침탱크에 넣고 교반기를 가동한다. 롤 상태의 유리섬유 원단에 축을 끼워 걸대에 건다. 원단의 끝을 건조로에 통과시켜 권취롤러에 일정 횟수 감는다. 함침시간 및 건조시간을 조정하고 기계를 가동한다. 배합, 건조, 온도, 비중, 함침 상태를 관찰하여 작업일지에 기록하고 원단에 꼬리표를 부착한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8522","dJobECdNm":"[8522]플라스틱제품 생산기계 조작원","dJobJCd":"8323","dJobJCdNm":"[8323]플라스틱제품 생산기 조작원","dJobICd":"C333","dJobICdNm":"[C333]운동 및 경기용구 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;