INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004188:1', '{"dJobCd":"K000004188","dJobCdSeq":"1","dJobNm":"낚싯대절단원","workSum":"낚싯대를 제조하고자 성형·가공된 낚싯대를 일정한 길이로 절단한다.","doWork":"작업지시서에 따라 회전절단기의 칼날과 안내대의 간격을 조정하기 위해 레버를 돌린다. 절단칼날의 과열을 방지하기 위해 물을 공급하는 밸브를 돌린다. 기계가동 스위치를 조작한다. 규격에 맞게 절단되었는지 알아보기 위해 시험소재를 안내대에 밀착하고 회전하는 절단칼날을 작동시켜 절단한다. 시험소재가 가공치수와 일치하면 절단할 소재를 일정 개수 합쳐 같은 방법으로 절단한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8522","dJobECdNm":"[8522]플라스틱제품 생산기계 조작원","dJobJCd":"8323","dJobJCdNm":"[8323]플라스틱제품 생산기 조작원","dJobICd":"C333","dJobICdNm":"[C333]운동 및 경기용구 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007247:1', '{"dJobCd":"K000007247","dJobCdSeq":"1","dJobNm":"낚싯대제조현장감독자","workSum":"낚싯대 및 릴을 제조하는 데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"제조하고자 하는 낚싯대의 생산계획을 세운다. 원료와 생산설비를 점검한다. 작업계획에 따라 세부실행항목을 수립하고 작업절차 및 방법을 결정하여 작업원에게 작업내용을 지시하고 작업배치를 한다. 함께 작업하며 작업의 진행상황을 파악하고 작업내용을 상부에 보고한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원 및 자재를 공급한다. 작업표준에 따라 지시된 작업이 이루어지는지 확인한다. 작업원의 직무교육 및 안전위생 교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴·해결하고 문제점을 보완한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","similarNm":"낚싯대제조반장","dJobECd":"8522","dJobECdNm":"[8522]플라스틱제품 생산기계 조작원","dJobJCd":"8323","dJobJCdNm":"[8323]플라스틱제품 생산기 조작원","dJobICd":"C333","dJobICdNm":"[C333]운동 및 경기용구 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005431:1', '{"dJobCd":"K000005431","dJobCdSeq":"1","dJobNm":"냉장고성형기조작원","workSum":"냉장고 내부의 플라스틱 물질을 일정 모양으로 성형하기 위하여 기계를 조작한다.","doWork":"모델별로 ABS시트, 금형 등을 준비하여 성형기계에 장착한다. 냉각수, 히터 등의 온도를 설정한다. 성형기계를 조작하여 성형작업을 한다. 성형된 제품의 두께를 버니어캘리퍼스, 계측기기, 육안 등으로 측정·검사하고 수시로 열을 조정한다. 성형 후 대형프레스를 사용하여 테두리를 다듬는다. 생산모델이 변경될 때 성형기 내부의 금형을 교환하여 장착한다. 성형기계를 점검하고 청소하며 주유·관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8522","dJobECdNm":"[8522]플라스틱제품 생산기계 조작원","dJobJCd":"8323","dJobJCdNm":"[8323]플라스틱제품 생산기 조작원","dJobICd":"C285","dJobICdNm":"[C285]가정용 기기 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006929:1', '{"dJobCd":"K000006929","dJobCdSeq":"1","dJobNm":"단추검사원","workSum":"완성된 단추를 검사하여 선별한다.","doWork":"이동컨베이어 위에 있는 단추에서 깨짐·이빠짐·늘어짐 등을 육안으로 검사하여 불량품을 선별한다. 색상불량, 광택이 나지 않은 단추 등은 각 제조공정으로 운반한다. 단추의 뒷면에 종이상표를 끼우고 림(Rim:테두리 고리) 밑으로 성형된 핀을 끼우기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","dJobECd":"8522","dJobECdNm":"[8522]플라스틱제품 생산기계 조작원","dJobJCd":"8323","dJobJCdNm":"[8323]플라스틱제품 생산기 조작원","dJobICd":"C339","dJobICdNm":"[C339]그 외 기타 제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005368:1', '{"dJobCd":"K000005368","dJobCdSeq":"1","dJobNm":"단추제조원","workSum":"단추의 형상을 제조하기 위하여 재료를 성형하고 단추의 모양을 만들기 위한 구멍을 뚫고 가장자리를 연마하는 등 단추제조용 가공기를 조작한다.","doWork":"드라이버, 렌치, 마이크로미터, 게이지 등을 사용하여 척(Chuch), 연마숫돌, 절단공구, 드릴비트(Drill Bits) 등을 기계에 설치한다. 단추가공기의 캠(Cam)을 조정하고 단추모형의 깊이를 조정하는 홀더를 설치한다. 단추가공기를 시험가동하고 가공되어 나오는 단추의 규격을 측정기를 사용하여 검사한다. 건조기의 온도스위치를 조정하고 건조기를 가동한다. 일정 시간 경과 후, 용기를 건조기에서 꺼내어 용기 안에 있는 단추봉을 온수건조기에 넣는다. 온수건조기의 온도스위치를 조정하고 기계를 가동한다. 일정 시간 경과 후, 온수건조기에서 단추봉을 꺼내어 건조기에 넣고 재건조한다. 절단공구를 사용하여 가공하고 드릴비트를 연마하기도 한다. 두께에 따라 단추를 선별하는 기계장치를 조작하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"위험내재|고온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"단추성형원, 단추가공원, 단추바렐원","connectJob":"단추가공기조작원, 단추두께선별원, 단추봉성형원, 단추분리기조작원, 단추원심성형기조작원, 단추원통연마기조작원","dJobECd":"8522","dJobECdNm":"[8522]플라스틱제품 생산기계 조작원","dJobJCd":"8323","dJobJCdNm":"[8323]플라스틱제품 생산기 조작원","dJobICd":"C339","dJobICdNm":"[C339]그 외 기타 제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004964:1', '{"dJobCd":"K000004964","dJobCdSeq":"1","dJobNm":"단추제조현장감독자","workSum":"단추를 제조하는데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"단추제조에 관련된 기계를 설치하고 기계, 장비의 이상 유무를 점검한다. 제조된 제품이 작업표준과 일치하는지 검사한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원 및 자재를 공급한다. 작업계획에 따라 세부실행항목을 수립하고 작업절차 및 방법을 결정하여 작업원에게 작업내용을 지시하고 작업배치를 한다. 표준작업명세에 따라 지시된 작업이 이루어지는지 작업원과 함께 작업하며 작업상황을 관찰하며 작업내용을 점검한다. 작업원의 직무교육 및 안전위생 교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴·해결하고 문제점을 보완한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"수동조작","similarNm":"단추제조반장","dJobECd":"8522","dJobECdNm":"[8522]플라스틱제품 생산기계 조작원","dJobJCd":"8323","dJobJCdNm":"[8323]플라스틱제품 생산기 조작원","dJobICd":"C339","dJobICdNm":"[C339]그 외 기타 제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006500:1', '{"dJobCd":"K000006500","dJobCdSeq":"1","dJobNm":"마네킹사출성형원","workSum":"일정한 모양의 형틀에 유리섬유·액체플라스틱 등을 사용하여 마네킹의 형체(몸, 팔, 다리)를 사출 성형한다.","doWork":"만들고자 하는 마네킹의 종류에 맞는 형틀을 준비한다. 형틀의 앞·뒷면을 작업대 위에 올려놓은 후, 작업 후에 주조된 마네킹 형체를 뜯어내기 쉽도록 형틀에 이형제를 바른다. 유리섬유(글라스파이버)나 액체플라스틱을 일정한 두께로 바르고 결합부위에 금속(알루미늄결합구)을 부착한다. 형틀의 앞·뒷면에 액체접착제를 액체 플라스틱 양면이 맞물릴 수 있도록 바르고 금속결합구를 사용하여 서로를 결합시킨다. 일정 시간이 지난 후, 유리섬유나 액체플라스틱이 굳으면 형틀을 분리시켜 필요 없는 부위를 제거한다. 금속의 부착상태, 표면의 균열, 제품의 형태 등을 점검한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8522","dJobECdNm":"[8522]플라스틱제품 생산기계 조작원","dJobJCd":"8323","dJobJCdNm":"[8323]플라스틱제품 생산기 조작원","dJobICd":"C339","dJobICdNm":"[C339]그 외 기타 제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006424:1', '{"dJobCd":"K000006424","dJobCdSeq":"1","dJobNm":"밀폐형혼련기조작원","workSum":"혼합기에서 혼합된 혼합물과 안료를 배합하기 위하여 밀폐혼련기(반바리믹서:Banbury Mixer)를 조작·관리한다.","doWork":"배합하고자 하는 제품의 강도에 따라 스팀 압력을 결정한다. 밀폐혼련기(액체나 점성 물질을 한 가지 이상 포함하는 여러 물질들을 가급적 균질적인 하나의 물질이 되게 혼합하는 기계)를 통과하는 스팀파이프의 밸브를 열고 혼합기에서 혼합된 혼합물과 배합 안료를 혼련기 상부에 있는 호퍼(Hopper)에 쏟아붓는다. 에어레버를 당겨 가압용 램을 상하로 작동시켜 혼합물을 로터(혼련시키는 스크루의 일종)로 눌러 겔(gel) 상태로 혼합한다. 에어레버를 밀어 가압램의 활동을 중지시키고 스팀밸브를 잠근다. 밀폐혼련기 내부에 설치된 압력공기 밸브를 작동시켜 혼련기 내부를 청소한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"반바리믹서조작원","dJobECd":"8522","dJobECdNm":"[8522]플라스틱제품 생산기계 조작원","dJobJCd":"8323","dJobJCdNm":"[8323]플라스틱제품 생산기 조작원","dJobICd":"C222","dJobICdNm":"[C222]플라스틱제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001737:1', '{"dJobCd":"K000001737","dJobCdSeq":"1","dJobNm":"분단기조작원","workSum":"포장용지를 롤상태로 만들기 위하여 제품의 규격에 맞추어 자르고 감기 위한 기계를 조작·관리한다.","doWork":"생산할 포장지의 규격을 확인한다. 권출되어 나오는 인쇄된 포장재 필름을 포장지의 규격에 맞추어 자르기 위해 분단기의 회전칼날의 위치를 조정하고 고정시킨다. 분단기의 속도, 장력 등을 체크하여 분단된 포장지를 권취기에 연결하여 권취시킨다. 기기의 오작동이나 불량 발생 시 조치를 취한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"슬릿터조작원","dJobECd":"8522","dJobECdNm":"[8522]플라스틱제품 생산기계 조작원","dJobJCd":"8323","dJobJCdNm":"[8323]플라스틱제품 생산기 조작원","dJobICd":"C222","dJobICdNm":"[C222]플라스틱제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005831:1', '{"dJobCd":"K000005831","dJobCdSeq":"1","dJobNm":"블로우압출기조작원","workSum":"특정한 형태를 만들기 위하여 예비성형을 한 열가소성 플라스틱재료를 금형에 끼워 내부로 공기를 불어넣는 블로우(Blow)기계를 조작·관리한다.","doWork":"필요한 원료수지를 준비하고 관련 장비를 점검한다. 제어판을 조작하여 제품에 맞는 온도, 스크루의 회전속도 등을 입력하고 원료수지를 압출기에 공급한다. 스크루의 마찰열과 주위의 온도에 의해 녹은 수지를 원통형으로 생긴 압출기의 출구로 이송한다. 성형할 제품의 금형을 준비한다. 압출기 출구에서 나온 원통형 압출물(Parison)을 금형 사이에 끼워 넣는다. 금형에 끼워진 원통형 압출물 내에 압축공기를 불어넣어 금형의 형태로 부풀도록 한다. 부풀려진 압출물을 냉각수를 이용하여 금형째로 상온 가까이 식혀 고화시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"중공성형기조작원, 블로우성형기조작원","dJobECd":"8522","dJobECdNm":"[8522]플라스틱제품 생산기계 조작원","dJobJCd":"8323","dJobJCdNm":"[8323]플라스틱제품 생산기 조작원","dJobICd":"C222","dJobICdNm":"[C222]플라스틱제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006273:1', '{"dJobCd":"K000006273","dJobCdSeq":"1","dJobNm":"사출성형기조작원","workSum":"시계플라스틱기어, 플라스틱의료용품 등을 제조하기 위하여 열가소성 플라스틱재료를 사용하여 사출 성형하는 사출성형기를 조작한다.","doWork":"제품의 성격에 따라 형체압력, 사출압력, 사출작업의 온도 및 사출시간 등을 사출성형기의 제어기에 있는 조절장치를 돌려 조절한다. 혼합된 플라스틱 재료를 사출기 상부에 있는 호퍼에 붓고 뚜껑을 닫는다. 사출성형기에 설치된 제어기의 레버를 당겨 금형 사이로 용해된 플라스틱 재료를 투입한다. 수동공구를 사용하여 사출성형된 제품을 금형에서 축출해 내고 칼 등을 사용하여 필요 없는 부분을 제거한다. 색상을 교환할 경우 경유를 사용하여 사출성형기의 호퍼 및 실린더스크루에 있는 안료를 제거한다. 플라스틱재료가 건조해야 될 경우는 호퍼를 떼어내고 원료투입구에 건조기를 부착하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8522","dJobECdNm":"[8522]플라스틱제품 생산기계 조작원","dJobJCd":"8323","dJobJCdNm":"[8323]플라스틱제품 생산기 조작원","dJobICd":"C222","dJobICdNm":"[C222]플라스틱제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006644:1', '{"dJobCd":"K000006644","dJobCdSeq":"1","dJobNm":"수지함침원","workSum":"발포제, 난연제 등 각종 첨가물을 수지에 투입하여 성질이 다른 합성수지를 제조하기 위한 장비를 조작한다.","doWork":"저장고에 저장된 수지를 유량계를 사용하여 계량하고 밸브를 연 후 펌프를 가동하여 지정된 탱크에 투입한다. 수지 투입이 완료되면 교반기를 작동시켜 고르게 섞어준 후 액면을 확인하고 규정량의 부재료를 작업표준에 따라 순서대로 투입한다. 부재료 투입 후 다시 교반기를 가동하여 잘 혼합한 다음 혼합상태를 육안으로 확인하여 양호하면 스팀밸브를 열어 온도를 올린다. 작업표준이나 중앙조정실운전원의 지시에 따라 일정량의 발포제(팽창제), 난연제(불에 잘 타지 않는 소재) 등을 계량하여 투입한다. 품종에 따라 일정 시간 유지를 한 후 냉각수로 냉각시킨다. 냉각이 완료되면 배출할 중화조를 확인하고 배출밸브를 연 후 펌프를 작동시켜 배출한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|고온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"수지함침원, 함침기조작원","certLic":"위험물산업기사, 위험물기능사","dJobECd":"8522","dJobECdNm":"[8522]플라스틱제품 생산기계 조작원","dJobJCd":"8323","dJobJCdNm":"[8323]플라스틱제품 생산기 조작원","dJobICd":"C202","dJobICdNm":"[C202]합성고무 및 플라스틱 물질 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004336:1', '{"dJobCd":"K000004336","dJobCdSeq":"1","dJobNm":"스펀지제조원","workSum":"스펀지를 제조하고자 화학물질을 반응·발포시키는 발포기를 조작·관리한다.","doWork":"작업지시에 의해 수지 및 기공조절제 등의 화학물질을 작업탱크에 넣고 용해한다. 수지와 반응하는 화학약품을 조절하기 위하여 탱크에서 혼합 선단부로 투입되는 감속기를 조작하여 투입량을 조절한다. 온수 또는 냉각수를 통해 적정온도를 유지시키고 교반기의 교반속도를 조절하고 교반기를 작동시킨다. 화학물질의 교반상태를 점검한다. 소량의 견본을 채취해 반응시험을 하고 결과에 따라 혼합비율·교반속도 등을 재조절한다. 금형의 크기 등을 감안하여 토출시간을 조정한다. 금형에 토출시켜 숙성·반응시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"금형발포기조작원, 연속식발포기조작원, 우레탄발포원","dJobECd":"8522","dJobECdNm":"[8522]플라스틱제품 생산기계 조작원","dJobJCd":"8323","dJobJCdNm":"[8323]플라스틱제품 생산기 조작원","dJobICd":"C222","dJobICdNm":"[C222]플라스틱제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003793:1', '{"dJobCd":"K000003793","dJobCdSeq":"1","dJobNm":"씨디프레스조작원","workSum":"플라스틱 화합물을 CD로 주형하는 자동 증기수압프레스를 조작·관리한다.","doWork":"프레스의 밑바닥 중심 위에 금속판인 스탬퍼(Stamper)를 놓고 미리 계량되고 가열된 비스킷(플라스틱 화합물)을 넣고 프레스기를 작동한다. 성형기에서 나온 기판을 염료(Dye) 코팅 공정과 같은 환경으로 만들기 위해 냉각시킨다. 원심력을 이용하여 색소용액을 성형된 기판 위에 균일하게 도포하여 기록층을 만들고 가장자리로 흘러내린 용액을 씻어낸다. 동일하게 원심력을 이용하여 디스크층에 반사막 및 보호막 코팅의 공정을 거친다. 라벨인쇄 공정을 거쳐 완성된 CD를 검사공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|고온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"CD제작원, 사출성형기조작원","dJobECd":"8522","dJobECdNm":"[8522]플라스틱제품 생산기계 조작원","dJobJCd":"8323","dJobJCdNm":"[8323]플라스틱제품 생산기 조작원","dJobICd":"C222","dJobICdNm":"[C222]플라스틱제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003072:1', '{"dJobCd":"K000003072","dJobCdSeq":"1","dJobNm":"씨디프레스현장감독자","workSum":"CD를 제작·시험·검사하는 데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"작업지시서를 확인하고 CD, DVD의 생산량과 작업공정을 점검한다. 세부수행계획을 세우고 작업원에게 작업내용을 지시하고 작업을 배치한다. CD의 외관검사 및 스캐너 등의 CD검사장비를 사용하여 결함의 원인을 찾아낸다. 사출기, 복제기 등의 장비 및 제어장치를 관리·조정하고 CD합성물의 종류에 따라서 가공작업주기를 조정한다. 코팅할 레코드합성물을 변경하거나 새로운 금형(Stamper)을 주문하거나 금형을 세척하여 결함을 수정토록 작업원에게 지시·감독한다. 작업 중 기기파손품을 수리·교체하고 기기에 소요되는 각종 부품을 관리한다. 유압펌프를 시간별로 점검한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"씨디프레스반장","dJobECd":"8522","dJobECdNm":"[8522]플라스틱제품 생산기계 조작원","dJobJCd":"8323","dJobJCdNm":"[8323]플라스틱제품 생산기 조작원","dJobICd":"C222","dJobICdNm":"[C222]플라스틱제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004824:1', '{"dJobCd":"K000004824","dJobCdSeq":"1","dJobNm":"안경테부품성형원","workSum":"안경테부품인 안경다리, 안경코 등의 실리콘 혹은 고무제품을 제조하기 위하여 왁스사출기, 열처리기, 주조기 등을 사용하여 원본몰드작업, 고무몰드작업, 왁스사출작업 및 주조작업을 한다.","doWork":"작업명세서에 따라 성형할 안경테 모델의 형태와 수량을 확인하고 이를 고려하여 치공구 및 몰드를 준비하고 사출기, 열처리기 등의 장비를 점검한다. 모델유형에 따라 몰드의 수정 및 변형작업을 통해 몰드작업을 한다. 원본몰드를 이용하여 고무에 몰드작업을 하고 왁스가 담긴 통에 고무몰드를 심는다. 왁스에 석고와 물의 양을 적절히 섞어 통에 붓고 석고를 굳힌 다음 열처리작업을 통해서 왁스를 녹여 제거한다. 왁스사출작업과 열처리작업을 하기 위해 왁스사출기의 온도와 열처리기 온도를 제품에 맞게 조절한다. 작업 전후로 주조품이 균일하게 생산되었는지, 왁스사출과 전기로 작업 및 주조상태가 작업조건과 일치하는지, 각 공정별 적정온도가 설정되어 있는지를 수시로 검사한다. 왁스사출작업 후 주조작업으로 도가니에 정해진 양의 베릴륨동을 넣는다. 베릴륨동의 용해에 알맞은 온도를 주조기의 컨트롤박스를 통해 조절한다. 진공상태를 확인하여 주조한다. 주조 후 석고세척기로 세척한다. 에어컷트기로 제품을 커팅한다. 성형이 완료된 제품의 합격 여부를 검사, 판단하여 합격한 제품을 연마공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"8522","dJobECdNm":"[8522]플라스틱제품 생산기계 조작원","dJobJCd":"8323","dJobJCdNm":"[8323]플라스틱제품 생산기 조작원","dJobICd":"C271","dJobICdNm":"[C271]의료용 기기 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005434:1', '{"dJobCd":"K000005434","dJobCdSeq":"1","dJobNm":"안경테수지원","workSum":"안경테에 무늬를 넣기 위하여 주사기, 수지액, 건조기 등을 사용하여 수지액제조·주사기주입·건조 작업 등을 수행한다.","doWork":"명세서를 확인하고 작업할 안경테의 수량과 형태, 작업방법 등을 점검한다. 무늬넣기 작업에 필요한 도구를 준비하여 점검하고 도금된 안경테를 수령한다. 수지와 경화제를 섞어 사용될 수지액을 제조한다. 주사기로 수지액을 주입하여 안경테 면에 고르게 바른다. 수지액이 입혀진 안경테를 건조한다. 안경테무늬 수정작업을 하기 위하여 알코올에 녹여 칼로 벗겨낸다. 제품에 따라 전사지를 붙여 무늬를 넣는 전사처리작업도 한다. 무늬넣기가 완료된 안경테를 다음 공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8522","dJobECdNm":"[8522]플라스틱제품 생산기계 조작원","dJobJCd":"8323","dJobJCdNm":"[8323]플라스틱제품 생산기 조작원","dJobICd":"C271","dJobICdNm":"[C271]의료용 기기 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004085:1', '{"dJobCd":"K000004085","dJobCdSeq":"1","dJobNm":"에프알피선박건조재료제조현장감독자","workSum":"FRP(유리섬유강화플라스틱)선박을 건조하기 위하여 주형을 제작하고, 수지를 적충하고, 선박의 내·외장 조립을 하는데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"FRP(유리섬유강화플라스틱)선박에 필요한 재료를 결정하기 위해 도면 및 작업지시서를 읽고 재료를 요청한다. 작업원을 각 공정에 배치시키고 작업 활동을 감독한다. 공정을 순회하여 작업상의 문제점을 조치하고 기술 지도를 한다. 판의 기포, 두께의 결함 또는 파손상태를 검사하여 표준과 일치하는지 비교한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"수동조작","similarNm":"에프알피선박건조재료제조반장","dJobECd":"8522","dJobECdNm":"[8522]플라스틱제품 생산기계 조작원","dJobJCd":"8323","dJobJCdNm":"[8323]플라스틱제품 생산기 조작원","dJobICd":"C311","dJobICdNm":"[C311]선박 및 보트 건조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001991:1', '{"dJobCd":"K000001991","dJobCdSeq":"1","dJobNm":"에프알피선박수지적층원","workSum":"FRP(유리섬유강화플라스틱)선박의 선체 및 갑판을 제작하기 위하여 주형에 FRP수지를 적층한다.","doWork":"선박주형의 제작이 완료되면 탈형이 잘되도록 주형 표면에 이형제(왁스)를 바르고 부드러운 천으로 닦아낸다. 이형처리가 끝나면 선체의 표면처리제인 겔코트(Gelcoat:불포화 폴리에스테르 수지에 안료를 첨가한 FRP(유리섬유강화플라스틱)표면용 페인트)를 붓이나 분무기를 사용하여 일정한 두께로 바른다. 일정 시간 후 겔코트가 경화되면 그 위에 유리섬유를 적층한다. 합성수지를 합치고, 롤러를 사용하여 평평하게 한다. 적층작업을 명시된 두께가 될 때까지 반복한다. 적층이 끝나면 에프알피 구조기준에 맞는지 검사한다. 선체에 와이어를 연결하고 크레인을 이용하여 형틀에서 분리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"선각원","dJobECd":"8522","dJobECdNm":"[8522]플라스틱제품 생산기계 조작원","dJobJCd":"8323","dJobJCdNm":"[8323]플라스틱제품 생산기 조작원","dJobICd":"C311","dJobICdNm":"[C311]선박 및 보트 건조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006635:1', '{"dJobCd":"K000006635","dJobCdSeq":"1","dJobNm":"엠보싱기조작원","workSum":"비닐제품에 무늬를 넣기 위하여 관련된 장비를 조작·관리한다.","doWork":"생산할 비닐제품의 생산량 및 무늬모양과 두께 등을 확인한다. 호이스트를 이용하여 필름을 걸이에 건다. 적정온도로 가열한 열드럼을 통과시켜 필름을 연화시킨다. 연화시킨 필름을 무늬롤에 통과시켜 필름에 무늬를 성형하거나 압력을 가해 제품의 두께를 성형한다. 제조된 제품의 외관상 결함을 검사한다. 완성된 제품을 후공정 부서로 이송한다. 작업일지에 일일 작업물량을 기재한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|다습|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"무늬기계조작원","dJobECd":"8522","dJobECdNm":"[8522]플라스틱제품 생산기계 조작원","dJobJCd":"8323","dJobJCdNm":"[8323]플라스틱제품 생산기 조작원","dJobICd":"C222","dJobICdNm":"[C222]플라스틱제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003448:1', '{"dJobCd":"K000003448","dJobCdSeq":"1","dJobNm":"우레탄발포기조작원","workSum":"금속패널의 생산을 위해 상·하판이 조립된 금속벽 내부에 우레탄발포기를 사용하여 우레탄 발포작업을 수행한다.","doWork":"도면을 이해하고 작업지시서를 숙지한다. 발포기의 작동 여부를 확인하고 점검한다. 우레탄의 충전을 확인하고 발포량과 시간을 계산한다. 발포면의 오염물질을 제거하는 하지정리 작업을 한다. 우레탄 프라이머를 플라스틱 브러시로 문지르며 도포하는 프라이머 발포작업을 한다. 건과 바닥면이 수직이 되도록 유지한다. 핀홀, 함몰, 스펀지현상이 발생하지 않도록 유의한다. 완성제품이 작업지시서와 일치하는지를 확인한다. 이상이 없으면 표준작업에 따라 양생시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|","workEnv":"소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8522","dJobECdNm":"[8522]플라스틱제품 생산기계 조작원","dJobJCd":"8323","dJobJCdNm":"[8323]플라스틱제품 생산기 조작원","dJobICd":"C251","dJobICdNm":"[C251]구조용 금속제품, 탱크 및 증기발생기 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002939:1', '{"dJobCd":"K000002939","dJobCdSeq":"1","dJobNm":"의료용품검사원","workSum":"수액·수혈세트, 1회용 주사기와 같이 조립된 플라스틱 의료용품에 대하여 자동검사기계나 확대경, 마이크로미터 등을 이용하여 검사대상품의 외관 및 기능검사를 수행한다.","doWork":"검사할 제품을 검사지그에 끼우고 확대경, 마이크로미터, 스코프, 버니어캘리퍼스 등을 사용하여 외경, 눈금, 두께, 착색상태, 긁힘, 길이 등의 외관을 검사한다. 공기압축기, 에어건(Air Gun) 등을 사용하여 주사기 또는 수액·수혈세트 내의 미제거된 찌꺼기나 이물질을 제거한다. 포인트검사기계를 사용하여 침의 포인트를 검사하여 불량품을 가려낸다. 자동검사기의 경우 자동 검사될 수 있도록 제품의 투입과정을 모니터링하며 문제가 발생 시 기계의 동작을 멈추고 문제를 해결한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8522","dJobECdNm":"[8522]플라스틱제품 생산기계 조작원","dJobJCd":"8323","dJobJCdNm":"[8323]플라스틱제품 생산기 조작원","dJobICd":"C271","dJobICdNm":"[C271]의료용 기기 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003791:1', '{"dJobCd":"K000003791","dJobCdSeq":"1","dJobNm":"자성도료제조원","workSum":"비디오·오디오 테이프를 만들기 위하여 자성산화철에 유기용제를 혼합하여 자성도료를 제조한다.","doWork":"혼합조에 일정 비율의 자성산화철분말과 바인더, 용제, 전도성입자, 습윤제, 윤활제, 하전방지제 등의 미세분말 성분을 투입하고 분산기를 작동시켜 분쇄하고 결합제 수지용액 등의 유기용매과 혼합하여 점도를 조정한다. 혼합된 도료가 일정한 온도·점도·광택도를 유지하는지 온도계·점도계 등을 사용하여 확인한다. 확인된 도료를 코팅조건에 맞추어 여과한다. 여과된 도료를 파이프라인을 통해 코팅실로 공급하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|저온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"자성도료공급원","dJobECd":"8522","dJobECdNm":"[8522]플라스틱제품 생산기계 조작원","dJobJCd":"8323","dJobJCdNm":"[8323]플라스틱제품 생산기 조작원","dJobICd":"C222","dJobICdNm":"[C222]플라스틱제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003579:1', '{"dJobCd":"K000003579","dJobCdSeq":"1","dJobNm":"점착테이프제조원","workSum":"원단에 점착제를 도포하고 건조·권취·절단하여 점착테이프를 제조한다.","doWork":"생산할 점착테이프에 따라 점착제와 필름 등의 원단을 결정한다. 원단에 점착제가 일정하게 도포되게 하기 위하여 도포량 조절게이지를 조정하고 점착제를 공급하여 도포한다. 도포된 원단을 덕트(Duct)를 통과시켜 권취기(Winder)로 유도한다. 도포되는 상태를 관찰하고 건조속도와 도포·권취속도가 동일하게 되도록 온도 및 속도, 장력 등을 조절한다. 도포된 점착제의 양, 건조상태 등을 검사하고 양 측면이 일정하게 권취한다. 롤 상태로 권취된 끝부분에 식별이 용이하도록 라벨을 부착한다. 절단기의 회전칼날을 이용하여 제품규격에 맞게 절단한다. 완제품을 포장공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8522","dJobECdNm":"[8522]플라스틱제품 생산기계 조작원","dJobJCd":"8323","dJobJCdNm":"[8323]플라스틱제품 생산기 조작원","dJobICd":"C222","dJobICdNm":"[C222]플라스틱제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005686:1', '{"dJobCd":"K000005686","dJobCdSeq":"1","dJobNm":"카세트테이프제조반장","workSum":"카세트테이프를 생산하는 데 종사하는 작업원들의 활동을 감독·조정한다.","doWork":"작업지시서를 확인하고 생산할 카세트테이프의 양과 종류를 파악한다. 그에 따른 작업계획 및 세부작업절차를 수립하고 작업원들에게 작업내용을 지시하고 작업배치를 한다. 표준작업명세에 따라 지시된 작업이 이루워지는지 작업원과 함께 작업하며 작업상황을 관찰하며 작업내용을 점검한다. 작업노하우 및 직무교육, 안전교육을 실시하여 작업능률향상 및 안전사고를 예방한다. 면담과 관찰을 통하여 작업원들의 애로점 및 건의사항을 수렴·해결하고 문제점을 보완한다. 작업진행사항 및 작업내용을 기록하고 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"종합","workFunc2":"감독","workFunc3":"수동조작","dJobECd":"8522","dJobECdNm":"[8522]플라스틱제품 생산기계 조작원","dJobJCd":"8323","dJobJCdNm":"[8323]플라스틱제품 생산기 조작원","dJobICd":"C222","dJobICdNm":"[C222]플라스틱제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002870:1', '{"dJobCd":"K000002870","dJobCdSeq":"1","dJobNm":"콘택트렌즈검사원","workSum":"가공된 콘택트렌즈를 확대경, 다이얼게이지 등 측정기기를 사용하여 콘택트렌즈의 외경, 도수, 곡률반경 등을 검사한다.","doWork":"작업표준서에 따라 작업도구를 점검하고 관련 공정을 숙지한 뒤 가공된 콘택트렌즈를 수령한다. 확대경을 사용하여 제품 외관을 살펴 표면상태의 둥글고 매끄러운 여부, 흠집 여부 등을 관찰한다. 렌즈미터로 렌즈의 베이스커브와 도수를 측정한다. 확대경을 이용하여 렌즈의 지름을 측정하고 다이얼게이지로 중심두께를 측정한다. 비틀림 검사기로 비틀림 간섭현상 유무를 검사한다. 소프트콘택트렌즈의 경우 멸균기에 온도 및 작동시간을 설정한 후 렌즈를 넣어 멸균한다. 검사를 합격한 렌즈의 용기에 곡률반경, 외경, 굴절력 등의 렌즈특성을 기록하고 포장공정으로 이송시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8522","dJobECdNm":"[8522]플라스틱제품 생산기계 조작원","dJobJCd":"8323","dJobJCdNm":"[8323]플라스틱제품 생산기 조작원","dJobICd":"C271","dJobICdNm":"[C271]의료용 기기 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005965:1', '{"dJobCd":"K000005965","dJobCdSeq":"1","dJobNm":"테니스라켓성형원","workSum":"테니스라켓을 제조하기 위해 라켓의 프레임을 성형한다.","doWork":"에폭시수지(열경화성 수지의 일종)를 배합하기 위해 믹싱기에 넣고 일정 시간 교반한다. 배합된 수지를 성형기에 투입한다. 이형지를 기계의 드럼에 부착하고 탄소섬유를 기계의 걸대에 건다. 섬유다발의 끝을 에폭시수지가 들어있는 통 가운데로 통과시켜 드럼의 우측단 이형지에 붙인다. 수지에 함침된 탄소섬유를 와인딩(winding: 감아 올리기)하기 위해 기계를 가동한다. 와인딩된 탄소섬유를 라켓의 종류나 모델에 따라 자와 연필로 재단을하고 절단기로 절단한다. 비닐튜브안에 막대기를 넣고 절단한 튜브를 규격에 맞게 붙여가면서 래핑을 한다. 시트의 한쪽 끝에 에어콘넥타를 끼우고 테이프로 고정한다. 금형에 래핑된 시트를 삽입한다. 요요크를 금형에 삽입하고 양쪽 끝을 시트로 감싼 다음 금형의 상판을 덮는다. 입모가 된 금형을 프레스에 넣는다. 가압용 밸브를 잠그고 프레스를 가동한다. 에어콘넥터와 에어호스를 연결하고 일정 시간이 지난 후 에어호스를 분리한다. 가압밸브를 열어 압력을 내린다. 금형을 프레스에서 꺼내어 냉각시키기 위하여 냉각기에 넣는다. 금형의 볼트를 풀어 금형을 해체한다. 성형된 뼈대를 금형에서 분리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8522","dJobECdNm":"[8522]플라스틱제품 생산기계 조작원","dJobJCd":"8323","dJobJCdNm":"[8323]플라스틱제품 생산기 조작원","dJobICd":"C333","dJobICdNm":"[C333]운동 및 경기용구 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002493:1', '{"dJobCd":"K000002493","dJobCdSeq":"1","dJobNm":"테이프코팅기조작원","workSum":"비디오·오디오테이프 등의 원단에 자성도료를 도포하여 코팅·건조하는 기계를 조작·관리한다.","doWork":"코팅할 원단필름을 코팅기계에 연결한다. 자성도료를 일정한 두께로 도포하여 코팅하면서 코팅된 필름을 건조가열기로 가열하여 건조시킨다. 건조된 코팅필름을 와인더로 권취시킨다. 작업 후 제품의 외관성 결함을 검사하기도 한다. 다음 공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"와인딩기조작원","dJobECd":"8522","dJobECdNm":"[8522]플라스틱제품 생산기계 조작원","dJobJCd":"8323","dJobJCdNm":"[8323]플라스틱제품 생산기 조작원","dJobICd":"C222","dJobICdNm":"[C222]플라스틱제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001571:1', '{"dJobCd":"K000001571","dJobCdSeq":"1","dJobNm":"폐플라스틱건조기조작원","workSum":"분쇄-세척-탈수를 마친 폐플라스틱(PET) 분칩을 건조시키는 건조기를 운전한다.","doWork":"탈수를 마친 폐플라스틱(PET) 분칩을 건조기에 이송한다. 건조기의 온도와 열풍의 세기 및 시간을 설정한다. 스위치를 켜 모터를 작동시키고 원심력 압축기, 전기히터, 온도제어기 등이 제대로 작동하는지 확인한다. 건조기에서 배기되는 가스 및 습공기의 열이 열회수기를 통과하여 냉각배출되는지 확인한다. 공기덕트를 깨끗하게 청소하고 건조된 분칩을 저장소로 보낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8522","dJobECdNm":"[8522]플라스틱제품 생산기계 조작원","dJobJCd":"8323","dJobJCdNm":"[8323]플라스틱제품 생산기 조작원","dJobICd":"E383","dJobICdNm":"[E383]해체, 선별 및 원료 재생업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006005:1', '{"dJobCd":"K000006005","dJobCdSeq":"1","dJobNm":"폐플라스틱분쇄기조작원","workSum":"선별된 폐플라스틱을 분쇄하는 분쇄기를 운전하며 분쇄기 칼날의 그라인딩 상태를 최적 상태로 유지시켜 분칩 손실을 최소화하도록 한다.","doWork":"분쇄기의 회전칼날과 고정칼날이 제대로 장착되어있는지 확인한다. 분쇄 시 분칩이 잘되도록 칼날의 경사각을 조절한다. 분쇄직경이 작거나 칼날의 그라인딩 상태가 나쁠수록 분칩손실이 일어나기 때문에 칼날이 무디어지면 그라인딩하여 날을 세우거나 칼날을 교체한다. 유압으로 개폐되는 스크린을 주기적으로 교체하고 잘 보일 수 있도록 청소를 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8522","dJobECdNm":"[8522]플라스틱제품 생산기계 조작원","dJobJCd":"8323","dJobJCdNm":"[8323]플라스틱제품 생산기 조작원","dJobICd":"E383","dJobICdNm":"[E383]해체, 선별 및 원료 재생업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006132:1', '{"dJobCd":"K000006132","dJobCdSeq":"1","dJobNm":"폐플라스틱세척기조작원","workSum":"페트(PET)의 오염물질을 제거하고 상대적으로 비중이 작은 라벨 및 PE, PP 재질의 병뚜껑 등을 분리하는 약품세척탱크를 운전한다.","doWork":"분쇄된 페트(PET) 분칩을 세척기 탱크에 넣고 약품이 섞인 물을 채운다. 아지테이터를 작동시켜 페트(PET) 분칩을 물속에서 섞어준다. 하이드로 싸이클론과 진동스크린이 제대로 작동하는지 살펴본다. 원심 및 비중분리를 통해 비중이 작은 라벨과 병뚜껑 및 떠오르는 비페트(PET) 재질들은 제거한다. 가라앉은 페트(PET) 분칩을 스크루컨베이어를 이용하여 탈수탱크로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8522","dJobECdNm":"[8522]플라스틱제품 생산기계 조작원","dJobJCd":"8323","dJobJCdNm":"[8323]플라스틱제품 생산기 조작원","dJobICd":"E383","dJobICdNm":"[E383]해체, 선별 및 원료 재생업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005373:1', '{"dJobCd":"K000005373","dJobCdSeq":"1","dJobNm":"폐플라스틱압축기조작원","workSum":"수거된 폐페트(PET)를 압축하여 선별라인으로 보내는 압축기를 운전한다.","doWork":"압축기의 투입구에 수거되어 재활용할 페트(PET)를 집어넣는다. 압축스위치를 누르고 압축이 잘되는지 살펴본다. 압축기의 유압실린더 압력이 적당한지 살펴본다. 압축기에 문제가 있으면 실린더를 살펴보고 유지보수가 필요하면 유지보수원을 불러 보수를 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8522","dJobECdNm":"[8522]플라스틱제품 생산기계 조작원","dJobJCd":"8323","dJobJCdNm":"[8323]플라스틱제품 생산기 조작원","dJobICd":"E383","dJobICdNm":"[E383]해체, 선별 및 원료 재생업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007354:1', '{"dJobCd":"K000007354","dJobCdSeq":"1","dJobNm":"플라스틱배합작업원","workSum":"플라스틱 공정 감독자의 일반적인 지시 및 감독을 받아 컴파운딩 분야의 제조사양서 및 기초적인 현장 실무지식을 사용하여 정해진 배합작업을 수행하고 배합작업과 관련하여 문제가 발생했을 경우 감독자의 지시나 작업지시서에 따라 문제를 해결한다.","doWork":"플라스틱 컴파운딩 제품을 생산하기 위하여 작업준비를 통해 제품을 생산하고 생산된 제품을 검사 후 정리 정돈한다. 생산된 제품을 건조하고 포장하기 위하여 제품별 후단공정을 파악하고 건조조건 설정, 포장단위 결정 후 포장하고 검사하는 컴파운딩 후공정작업을 수행한다. 원활한 플라스틱 생산을 위하여 정기 점검과 일상 점검을 하고 주변기기를 점검하여 설비를 유지한다. 원부재료와 컴파운딩 제품을 검사하고 물성평가와 통계적 품질 분석을 수행한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8522","dJobECdNm":"[8522]플라스틱제품 생산기계 조작원","dJobJCd":"8323","dJobJCdNm":"[8323]플라스틱제품 생산기 조작원","dJobICd":"C222","dJobICdNm":"[C222]플라스틱제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007366:1', '{"dJobCd":"K000007366","dJobCdSeq":"1","dJobNm":"플라스틱성형작업원","workSum":"플라스틱 공정 감독자의 일반적인 지시 및 감독을 받아 제품성형의 플라스틱가공 기술 및 기초적인 현장 실무지식을 사용하여 성형 준비, 성형작업 등의 정해진 업무를 수행하고 성형작업과 관련하여 문제가 발생했을 경우 감독자의 지시나 작업지시서에 따라 문제를 해결한다.","doWork":"플라스틱의 생산을 위해 원재료 투입, 부대설비 조작, 압출기를 조작하며, 원재료 수급, 성형품 생산, 외관, 치수 검사 등을 수행한다. 플라스틱 성형품 생산을 준비하고 성형조건을 유지하여 성형품을 생산하고 성형기를 선정하고 운전조건을 설정하여 압출 작업을 준비한다. 원재료를 건조하고, 금형을 사출기에 장착하며, 주변설비를 설치하기 위해 준비한다. 압출성형기와 주변기기에 대한 정기점검과 일상점검을 수행한다. 매뉴얼에 따라서 중공·진공성형기, 사출성형기, 주변설비, 부대설비, 금형을 점검하고 유지보수 작업을 한다. 원부재료를 준비하고 금형 장착, 주변설비를 설치하여 최적의 성형조건을 설정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8522","dJobECdNm":"[8522]플라스틱제품 생산기계 조작원","dJobJCd":"8323","dJobJCdNm":"[8323]플라스틱제품 생산기 조작원","dJobICd":"C222","dJobICdNm":"[C222]플라스틱제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001289:1', '{"dJobCd":"K000001289","dJobCdSeq":"1","dJobNm":"플라스틱압착주형기조작원","workSum":"플라스틱제품을 주조하기 위하여 주형을 설치한 후 압착주형기를 조작·관리한다.","doWork":"생산할 제품의 형태에 따라 클램프와 볼트 및 수동공구를 사용하여 금형을 설치하고 금형에 이형제를 뿌리거나 입힌다. 온도조절기를 조절하여 금형의 온도를 일정한 온도로 맞춘다. 혼합·교반된 플라스틱혼합수지의 무게를 달아 금형의 통에 붓거나 금형 위에 직물을 펴고 직물 위에 혼합수지를 붓는다. 수압 또는 유압식 램의 레버를 당겨 압착한다. 수동공구나 압축공기를 사용하여 주형에서 경화된 제품을 빼어낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"힘든 작업","workPlace":"실내","workEnv":"대기환경미흡|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8522","dJobECdNm":"[8522]플라스틱제품 생산기계 조작원","dJobJCd":"8323","dJobJCdNm":"[8323]플라스틱제품 생산기 조작원","dJobICd":"C222","dJobICdNm":"[C222]플라스틱제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001519:1', '{"dJobCd":"K000001519","dJobCdSeq":"1","dJobNm":"플라스틱압출기조작원","workSum":"열가소성 플라스틱 제품을 만들기 위하여 플라스틱 재료에 안료를 혼합하고 압출하는 압출기를 조작·관리한다.","doWork":"작업지시서에 지시된 플라스틱 재료와 안료를 계량하여 배합통에 넣고 일정 시간 동안 회전시켜 배합한다. 압출기의 실린더에 플라스틱 혼합용액을 채워 넣고 공기압력 및 온도, 속도를 제어기를 통해 조정한다. 속도조절기로 스크루의 미는 작업과 압출속도를 같게 조정한다. 생산제품의 크기 및 형태에 따라 압출기의 금형을 교체한다. 압출 성형된 제품이 사이징다이를 통과하여 일정한 크기 및 두께가 되게 하며 냉각수조 등을 통과시켜 냉각시킨다. 작업지시서와 일치하는 제품을 만들기 위하여 플라스틱 양쪽 시트에 칼날을 설치하여 고정시키고 지시된 길이로 절단되는지를 확인하고 압출성형 된 제품을 권취롤에 감기도 한다. 제품의 주름·기포·갈라진 금·결의 결함상태 등을 육안으로 검사하고 두께 등을 마이크로미터·캘리퍼스·게이지 등으로 검사하고 압출된 제품이 명세서와 일치하는지 측정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8522","dJobECdNm":"[8522]플라스틱제품 생산기계 조작원","dJobJCd":"8323","dJobJCdNm":"[8323]플라스틱제품 생산기 조작원","dJobICd":"C222","dJobICdNm":"[C222]플라스틱제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005551:1', '{"dJobCd":"K000005551","dJobCdSeq":"1","dJobNm":"플라스틱용접원","workSum":"열풍용접기를 사용하여 열가소성 플라스틱이나 플라스틱 시트들의 가장자리를 녹인 후 접합시킨다.","doWork":"반제품 플라스틱(열가소성 플라스틱, 플라스틱 시트)을 용접기에 올린다. 가장자리가 일정하도록 설치한 후 칼을 사용하여 매끄럽게 다듬는다. 브이형(V-shape) 이음매를 만들기 위하여 동력용 모래분사기를 사용하여 가장자리를 닦는다. 플라스틱봉을 브이자형의 이음매에 놓고 열분무기를 작동시켜 플라스틱봉을 녹여 브이자형 이음매를 채워 가장자리를 결합시킨다. 용접기에서 제품을 꺼내고 완성제품을 야적장에 쌓아둔다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"8522","dJobECdNm":"[8522]플라스틱제품 생산기계 조작원","dJobJCd":"8323","dJobJCdNm":"[8323]플라스틱제품 생산기 조작원","dJobICd":"C222","dJobICdNm":"[C222]플라스틱제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002262:1', '{"dJobCd":"K000002262","dJobCdSeq":"1","dJobNm":"플라스틱절단기조작원","workSum":"제품화된 스티로폼 등의 플라스틱을 일정 규격에 맞추어 자르기 위하여 절단기를 조작·관리한다.","doWork":"스티로폼 등의 원재료를 운반하여 절단 금형에 올려놓는다. 절단기의 스위치를 넣어 니크롬선에 열을 가한다. 자 등을 이용하여 규격을 확인하고 절단규격에 맞추어 레버를 돌려 절단선에 위치시킨다. 스위치를 눌러 니크롬선을 전진시킨다. 절단이 규정된 치수와 일치하는지 자를 이용하여 검사한다. 검사가 완료된 완제품을 포장장소로 운반한다. 스티로폼 이외의 플라스틱제품들은 회전칼날이 달린 절단기를 이용하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"스티로폼절단원","dJobECd":"8522","dJobECdNm":"[8522]플라스틱제품 생산기계 조작원","dJobJCd":"8323","dJobJCdNm":"[8323]플라스틱제품 생산기 조작원","dJobICd":"C222","dJobICdNm":"[C222]플라스틱제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001855:1', '{"dJobCd":"K000001855","dJobCdSeq":"1","dJobNm":"플라스틱제품가공기조작원","workSum":"플라스틱 포장용기를 고객의 주문 형태에 맞추어 자르고 봉합하는 가공기를 조작·관리한다.","doWork":"생산할 포장용기의 규격을 확인한다. 경화되어 나온 필름을 권취기에 장착한다. 장착된 필름을 절단날의 위치를 조정하여 고정시키고 절단기를 작동하여 규격에 맞추어 절단한다. 절단되어 나오는 포장용기를 봉합기에 넣고 열접합을 하고 열접합된 필름을 냉각시킨다. 접합면을 확인하여 불량을 검사한다. 제품이 되어 나오는 포장지를 지정된 매수로 간추려 묶는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"실링기조작원","dJobECd":"8522","dJobECdNm":"[8522]플라스틱제품 생산기계 조작원","dJobJCd":"8323","dJobJCdNm":"[8323]플라스틱제품 생산기 조작원","dJobICd":"C222","dJobICdNm":"[C222]플라스틱제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002289:1', '{"dJobCd":"K000002289","dJobCdSeq":"1","dJobNm":"플라스틱제품제조현장감독자","workSum":"각종 형태의 플라스틱제품을 제조하기 위하여 합성수지 원료를 혼합·압출·발포·조립·포장하는 데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"작업지시서를 확인하고 생산품목과 생산량에 따라 작업계획과 세부작업절차를 수립하고 작업절차에 따라 작업원에게 작업내용을 지시하고 작업배치를 한다. 작업장비와 원료를 점검하고 공급한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원을 하며 안전위생교육을 통해 안전재해를 예방한다. 작업상황 및 내용을 기록하고 보고한다. 수시면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴·해결하고 문제점을 보완하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","similarNm":"플라스틱제품제조반장","connectJob":"사출성형반장, 압출성형반장, 엠보싱반장, 파이프성형반장","dJobECd":"8522","dJobECdNm":"[8522]플라스틱제품 생산기계 조작원","dJobJCd":"8323","dJobJCdNm":"[8323]플라스틱제품 생산기 조작원","dJobICd":"C222","dJobICdNm":"[C222]플라스틱제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003959:1', '{"dJobCd":"K000003959","dJobCdSeq":"1","dJobNm":"플라스틱파쇄기조작원","workSum":"플라스틱 재료, 불량품, 재활용품, 사출작업 시 발생한 잔여물 등을 파쇄하기 위하여 플라스틱 파쇄기(破碎機, Crusher)를 조작·관리한다.","doWork":"파쇄기의 스위치를 넣어 모터를 작동하고 파쇄기 안의 칼날을 회전시킨다. 파쇄기 상단의 호퍼(Hopper)에 파쇄할 플라스틱(플라스틱 재료, 불량품, 재활용품, 사출작업 시 발생한 잔여물 등)을 삽으로 퍼 넣는다. 작업 중 옷이나 팔, 다리 등이 파쇄기에 끌려 들어가지 않도록 주의하며, 비상시에는 비상정지를 한다. 파쇄할 플라스틱의 색상이 바뀔 경우 파쇄기를 분해하고 공기호스 및 스크레이퍼 등을 사용하여 파쇄기 안을 청소한다. 파쇄기의 칼날이 마모되면 교체를 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","similarNm":"분쇄작업원","dJobECd":"8522","dJobECdNm":"[8522]플라스틱제품 생산기계 조작원","dJobJCd":"8323","dJobJCdNm":"[8323]플라스틱제품 생산기 조작원","dJobICd":"C221/C222","dJobICdNm":"[C221]고무제품 제조업 / [C222]플라스틱제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004862:1', '{"dJobCd":"K000004862","dJobCdSeq":"1","dJobNm":"플라스틱파이프가공원","workSum":"파이프에 열을 가하여 녹인 후 일정한 틀에 넣어 파이프의 끝부분을 넓히는 기계를 조작·관리한다.","doWork":"작업지시서를 확인하고 가공할 파이프의 두께, 외경, 길이 등의 규격을 확인한다. 운반된 파이프를 가열기에 올려놓고 가열한다. 적당하게 가열된 파이프를 규격에 맞게 절단하고 금형에 밀어 넣어 끝부분을 넓힌다. 냉각수를 사용하여 파이프를 냉각하고 완성된 파이프를 규격에 맞게 절단하여 보관 장소로 운반한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8522","dJobECdNm":"[8522]플라스틱제품 생산기계 조작원","dJobJCd":"8323","dJobJCdNm":"[8323]플라스틱제품 생산기 조작원","dJobICd":"C222","dJobICdNm":"[C222]플라스틱제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007318:1', '{"dJobCd":"K000007318","dJobCdSeq":"1","dJobNm":"플라스틱후공정관리자","workSum":"플라스틱 후공정에 대하여 제한된 권한 내에서 플라스틱 제품의 후가공 기술(융착, 증착, 인쇄, 코팅 등) 및 현장 실무지식을 사용하여 전반적인 후공정관리 업무를 수행한다.","doWork":"고객의 압출제품의 가치 향상을 위해 성형품 도장, 성형품 인쇄, 성형품 표면가공, 후가공 검사를 수행한다. 사출 성형품의 외관품질향상을 위해 융착, 인쇄, 도장 등의 작업을 수행한다. 플라스틱 성형품의 외관품질향상을 위해중공·진공 성형품의 외관에 인쇄 또는 도장, 검사를 하고 인쇄공정, 도장공정, 도금공정 등 관리업무를 수행한다. 제품설계에 적합한 재료를 바탕으로 목표한 플라스틱제품 생산을 위하여 코팅장비 선정, 코팅조건 설계, 코팅물성 평가, 코팅공정 표준을 작성한다. 플라스틱 코팅 제품의 품질과 생산성을 높이고 운전조건과 설비를 합리화하기 위하여 공정개선 계획을 수립하고 공정 데이터 분석, 공정 개선안 적용, 공정 자동화를 실행하고 개선의 효과 분석을 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"8522","dJobECdNm":"[8522]플라스틱제품 생산기계 조작원","dJobJCd":"8323","dJobJCdNm":"[8323]플라스틱제품 생산기 조작원","dJobICd":"C222","dJobICdNm":"[C222]플라스틱제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007319:1', '{"dJobCd":"K000007319","dJobCdSeq":"1","dJobNm":"플라스틱후공정작업원","workSum":"플라스틱 공정관리자의 구체적인 지시 및 감독하에 플라스틱 제품의 후가공 기술(융착, 증착, 인쇄, 코팅 등)을 활용하여 작업지시서에 따른 절차화된 작업조건설정을 시행하여 일상적인 후공정 작업을 수행한다.","doWork":"플라스틱 성형품 도장, 성형품 인쇄, 성형품 표면가공, 후가공 검사를 수행한다. 플라스틱 사출 성형품의 외관품질 향상을 위해 융착, 인쇄, 도장 등의 작업을 수행한다. 중공·진공 성형품의 외관에 인쇄 또는 도장을 하고 검사를 수행한다. 원재료배합, 코팅작업, 건조경화, 후가공을 통하여 제품을 만들어 내는 업무를 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8522","dJobECdNm":"[8522]플라스틱제품 생산기계 조작원","dJobJCd":"8323","dJobJCdNm":"[8323]플라스틱제품 생산기 조작원","dJobICd":"C222","dJobICdNm":"[C222]플라스틱제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006327:1', '{"dJobCd":"K000006327","dJobCdSeq":"1","dJobNm":"필름재단기조작원","workSum":"필름을 규정된 넓이 및 길이로 절단하는 재단기를 조작·관리한다.","doWork":"필름지관을 축에 고정시킨다. 지시된 절단 넓이·길이에 따라 제어판을 조정하여 재단속도, 넓이, 길이 등을 입력한다. 필름을 유도장치에 연결하고 피딩롤러로 재단기가 정해진 대로 재료를 자르고 있는지 확인한다. 재단된 필름을 포장 용기에 넣는 일을 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"유지","dJobECd":"8522","dJobECdNm":"[8522]플라스틱제품 생산기계 조작원","dJobJCd":"8323","dJobJCdNm":"[8323]플라스틱제품 생산기 조작원","dJobICd":"C222","dJobICdNm":"[C222]플라스틱제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005372:1', '{"dJobCd":"K000005372","dJobCdSeq":"1","dJobNm":"합성수지발포기조작원","workSum":"합성수지, 복지합판을 발포시키거나 무늬를 내고, 필름과 복지의 접착을 강하게 하기 위하여 합성수지 발포기를 조작·관리한다.","doWork":"제어패널의 버튼을 눌러 발포기 오븐을 일정한 온도로 예열한다. 일정한 무늬롤을 호이스트를 사용하여 롤걸대에 끼우고 고정한다. 호이스트를 사용하여 권취된 복지합판을 발포기에 끼워 걸어 놓는다. 작동버튼을 눌러 발포기의 롤을 회전시켜 복지합판이 가열기 안을 통과하도록 한다. 가열기를 통과한 복지합판 끝을 무늬롤에 끼우고, 다시 무늬롤을 통하여 나오는 복지합판을 냉각드럼을 통하게 하여 권취롤에 감는다. 두께게이지를 사용하여 발포된 복지합판의 두께를 측정하고 육안으로 색상과 무늬를 검사한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8522","dJobECdNm":"[8522]플라스틱제품 생산기계 조작원","dJobJCd":"8323","dJobJCdNm":"[8323]플라스틱제품 생산기 조작원","dJobICd":"C222","dJobICdNm":"[C222]플라스틱제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002866:1', '{"dJobCd":"K000002866","dJobCdSeq":"1","dJobNm":"3D프린팅운영기사","workSum":"원활한 3D프린팅을 위하여 출력과정 중 출력오류에 대처하고 출력 후 안전하게 제품을 회수한다.","doWork":"3D프린터 출력 중 제품이 바닥에 단단히 고정되어 있는지 확인하고 출력 보조물이 정상적으로 출력되고 있는지 확인한다. 제품 출력경로가 G코드와 일치하는지 확인하고 출력오류 감지 시 3D프린터를 중지하여 프린터 장치의 오류와 G코드 상의 오류를 파악한다. 파악한 문제점을 활용하여 소프트웨어 프로그래밍, 3D프린터, 출력방식별로 출력오류에 대처한다. 고체, 액체, 분말 등 소재에 따라 전용공구를 사용하여 제품을 회수하고 출력물 표면에 붙은 가루분말을 제거하거나 세척하고 경화기로 경화시키기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"조작운전","certLic":"컴퓨터응용가공산업기사, 사출금형산업기사, 3D프린팅운용기능사","dJobECd":"8524","dJobECdNm":"[8524]고무·플라스틱 제품 조립원","dJobJCd":"8324","dJobJCdNm":"[8324]고무 및 플라스틱제품 조립원","dJobICd":"C339","dJobICdNm":"[C339]그 외 기타 제품 제조업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001687:1', '{"dJobCd":"K000001687","dJobCdSeq":"1","dJobNm":"3D프린팅채색및후가공원","workSum":"3D프린팅된 출력물의 최종 가공을 위하여 표면처리와 도장을 하고 검증을 통하여 상품화한다.","doWork":"선정한 소재, 출력방식에 따른 표면처리 방식을 파악한다. 표면처리 방식을 바탕으로 작업 절차를 수립한다. 작업할 도료, 도장용구를 준비하고 사용방법을 파악한다. 결정된 디자인을 기준으로 도장 처리 절차를 수립하고 출력물에 도장 처리를 한다. 작업지시서의 검사항목을 기준으로 계측장비를 활용하여 제품을 검증한다. 검증된 결과를 기준으로 검사성적서를 작성한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"표면처리기능사, 금속도장기능사","dJobECd":"8524","dJobECdNm":"[8524]고무·플라스틱 제품 조립원","dJobJCd":"8324","dJobJCdNm":"[8324]고무 및 플라스틱제품 조립원","dJobICd":"C339","dJobICdNm":"[C339]그 외 기타 제품 제조업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003349:1', '{"dJobCd":"K000003349","dJobCdSeq":"1","dJobNm":"가스마스크검사원","workSum":"가스마스크가 명세서대로 제조되었는지 확인하기 위하여 검사장비 및 실험설비 등을 사용하여 기능 및 외관검사를 한다.","doWork":"작업표준에 의하여 검사기준서 및 검사표준서를 준비하고 숙지한다. 검사할 가스마스크의 형태와 규격을 확인한다. 안면부, 정화통부, 렌즈부로 구성된 가스마스크의 각 부품으로 정화통, 고무 또는 실리콘 소재인 안면부위, 끈, 고무호스 등의 탄성 등의 이상 여부를 육안으로 관찰하며 손으로 잡아당겨 검사한다. 기포, 틈, 잘못된 바느질과 같은 결함 여부를 검사하여 이상이 있는 제품은 선별하여 조립공정으로 다시 돌려보낸다. 흡착컵을 써서 유리 혹은 강화플라스틱으로 된 눈부분이 새는지를 시험한다. 검사기기로 정화통이 내용물에 적합한지 가압하여 가스누출 여부를 검사한다. 연기계기를 써서 정화통의 화학물을 흡수하는 성질을 시험한다. 시험에 합격한 가스마스크는 포장 등의 다음 공정으로 이송시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8524","dJobECdNm":"[8524]고무·플라스틱 제품 조립원","dJobJCd":"8324","dJobJCdNm":"[8324]고무 및 플라스틱제품 조립원","dJobICd":"C271","dJobICdNm":"[C271]의료용 기기 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006191:1', '{"dJobCd":"K000006191","dJobCdSeq":"1","dJobNm":"가스마스크조립원","workSum":"천공기와 수동공구를 사용하여 가스마스크를 조립한다.","doWork":"작업명세서에 따라 조립할 가스마스크의 규격과 수량 등을 확인한다. 조립에 필요한 각 부품을 확인하여 준비한다. 천공기, 금속꺽쇠 등의 공구 및 장비를 준비하여 작동 여부를 확인한다. 천공기를 사용하여 마스크 전면에 구멍을 뚫는다. 수동공구를 사용하여 마스크 전면 조각에 정화통 체결부위를 붙인다. 마스크 전면조각의 체결부위에 정화통을 연결시킨다. 머리부분을 만들기 위해 금속꺽쇠를 테이프조각에다 끼우고 마스크에 붙이며 눈부분에 렌즈를 집어넣고 붙이기 위해 가장자리를 죈다. 안면부에 실리콘헤어밴드를 연결하기도 한다. 렌즈가 필요 없는 방진마스크의 경우 실리콘헤어밴드로 대체한다. 조립완성품의 수량을 기록하고 포장 등의 다음 공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8524","dJobECdNm":"[8524]고무·플라스틱 제품 조립원","dJobJCd":"8324","dJobJCdNm":"[8324]고무 및 플라스틱제품 조립원","dJobICd":"C271","dJobICdNm":"[C271]의료용 기기 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006629:1', '{"dJobCd":"K000006629","dJobCdSeq":"1","dJobNm":"고무제품조립원","workSum":"압출·성형·가공 공정을 거친 고무부품을 접착제·나사 등을 사용하거나 홈에 맞추어 완제품이나 부분품으로 조립한다.","doWork":"단품 생산 공정에서 압출·성형·가공된 각종 고무부품과 조립할 각종 부품을 작업대 위에 올려놓는다. 부품의 제조 상태를 점검하여 파손되거나 규격 미달인 부품을 제거한다. 컨베이어벨트 또는 작업대 위에 조립하기 쉽도록 고무부품을 나란히 늘어놓는다. 손가락으로 부품을 눌러 주름이 발생하지 않도록 하면서 홈이나 틀에 맞춘다. 접착제나 나사를 사용하여 고무부품·금속·나무 등에 부착한다. 조립품의 군더더기를 제거한다. 완성된 조립제품은 검사실로 보낸다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8524","dJobECdNm":"[8524]고무·플라스틱 제품 조립원","dJobJCd":"8324","dJobJCdNm":"[8324]고무 및 플라스틱제품 조립원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006419:1', '{"dJobCd":"K000006419","dJobCdSeq":"1","dJobNm":"공가공원","workSum":"각종 부품을 부착하여 야구공 등 공의 외장을 가공한다.","doWork":"공 몸체부분에서 튀어나온 고무부분을 연마숫돌을 사용하여 다듬는다. 재단한 가죽조각을 같은 색깔끼리 맞춘다. 표면에 흠집이 있거나 재단이 잘못된 가죽조각을 선별한다. 재단한 가죽의 가장자리를 스카이빙기계로 얇게 깎는다. 몸체를 풀칠작업대 위에 올려놓고 붓으로 접착제를 칠한 후, 일정 시간 자연 건조시킨다. 건조시킨 몸체를 작업대에 올려놓고 대나무칼을 사용하여 이음매를 따라 문지른다. 몸체에 드릴로 밸브구멍을 뚫는다. 접착력과 외관을 향상시키기 위해 공기주입기와 주형을 사용하여 다림질한다. 실크인쇄기·고주파인쇄기·분무기 등을 사용하여 공에 전사무늬를 넣거나 상표를 붙인다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"농구공조립원, 다림질원, 면도리원, 배구공조립원, 버핑원, 선별원, 접착원, 축구공조립원","dJobECd":"8524","dJobECdNm":"[8524]고무·플라스틱 제품 조립원","dJobJCd":"8324","dJobJCdNm":"[8324]고무 및 플라스틱제품 조립원","dJobICd":"C333","dJobICdNm":"[C333]운동 및 경기용구 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001782:1', '{"dJobCd":"K000001782","dJobCdSeq":"1","dJobNm":"공쿠션고무접착원","workSum":"테니스공 등을 제조하기 위하여 공 내부의 튜브 위에 쿠션고무를 입히는 기계를 조작·관리한다.","doWork":"쿠션고무(천연고무시트)를 기계 앞에 준비한다. 기계의 자동온도조절기에 전원을 공급한다. 기계의 상부금형을 위로 올리는 버튼을 누르고 쿠션고무를 손으로 늘리면서 금형에 부착한다. 실이 감긴 튜브를 상하부 금형 사이에 넣고 상부금형을 내리는 버튼을 누른다. 일정 시간이 경과 후 상부금형을 위로 올리는 버튼을 누른다. 쿠션고무가 접착된 튜브를 기계에서 꺼내어 운반통에 담는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","dJobECd":"8524","dJobECdNm":"[8524]고무·플라스틱 제품 조립원","dJobJCd":"8324","dJobJCdNm":"[8324]고무 및 플라스틱제품 조립원","dJobICd":"C333","dJobICdNm":"[C333]운동 및 경기용구 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006598:1', '{"dJobCd":"K000006598","dJobCdSeq":"1","dJobNm":"공펠트접착원","workSum":"테니스공 등을 제조하기 위하여 성형이 끝난 고무공의 표면을 덮는 펠트(Felt)를 접착한다.","doWork":"성형이 끝난 고무공을 접착제가 칠해진 펠트(Woven Felt, Needle Felt로 구분)로 싼다. 펠트가 고무공에 잘 붙도록 공 덮개를 두드리는 기구에 넣고 전원스위치를 넣는다. 일정 시간 경과 후 공을 꺼내어 접착이 잘 되었는지 검사한다. 검사가 끝난 공은 운반통에 넣는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"공펠트덮개원","dJobECd":"8524","dJobECdNm":"[8524]고무·플라스틱 제품 조립원","dJobJCd":"8324","dJobJCdNm":"[8324]고무 및 플라스틱제품 조립원","dJobICd":"C333","dJobICdNm":"[C333]운동 및 경기용구 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006093:1', '{"dJobCd":"K000006093","dJobCdSeq":"1","dJobNm":"낚시릴조립원","workSum":"낚싯대에 사용되는 낚시용 릴(Reel)의 부품들을 조립한다.","doWork":"전동드라이버를 이용하여 낚시용 릴의 몸체에 각종 부속품을 나사로 고정한다. 기 조립된 로터어셈블리(Rotor Assembly)를 몸체 피니온기어(Pinion Gear)에 삽입하여 동력너트돌리개로 너트를 고정한다. 메인샤프트를 피니온기어 홀에 삽입하여 몸체 내부 오슬레이팅기어(Oscillating Gear)에 전동드라이버로 나사를 고정한다. 바디커버(Body Cover)를 전동드라이버로 고정하고 몸체 베어링 핸들을 손으로 삽입하여 핸들고정 나사를 전동드라이버로 고정한다. 랩핑기(기어조립상태 확인 및 기어비 조정용)의 좌우 회전축을 이용하여 기어상태를 검사한다. 메인샤프트(Main Shaft)축에 스풀(Spool:낚싯줄 감는 부위)을 삽입하고 드래그노브(Drag Knob:낚싯줄 장력 조절용)를 전동드라이버로 조립한다. 조립이 끝난 제품에 묻어 있는 기름을 타월로 제거하고 제품 내부에서 흘러나오는 오일류를 차단하기 위해 비닐백을 씌운다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8524","dJobECdNm":"[8524]고무·플라스틱 제품 조립원","dJobJCd":"8324","dJobJCdNm":"[8324]고무 및 플라스틱제품 조립원","dJobICd":"C333","dJobICdNm":"[C333]운동 및 경기용구 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004278:1', '{"dJobCd":"K000004278","dJobCdSeq":"1","dJobNm":"낚싯대조립원","workSum":"낚싯대를 제조하고자 손잡이·릴시트·캡 등 낚싯대 부품을 조립한다.","doWork":"작업표준을 보면서 연필로 부품의 접착 위치를 표시한다. 접착부분에 접착제를 칠하고 부품을 부착한다. 조립순서에 따라 손잡이·릴시트·캡 등을 조립하고 유동을 방지하기 위해 실을 감는다. 낚싯대 표면을 왁스로 닦는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8524","dJobECdNm":"[8524]고무·플라스틱 제품 조립원","dJobJCd":"8324","dJobJCdNm":"[8324]고무 및 플라스틱제품 조립원","dJobICd":"C333","dJobICdNm":"[C333]운동 및 경기용구 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007156:1', '{"dJobCd":"K000007156","dJobCdSeq":"1","dJobNm":"라이터제조원","workSum":"라이터를 제조하기 위하여 라이터 몸체에 각종 부품을 조립하여 완제품을 제조하는 조립기를 조작한다.","doWork":"작업지시서를 확인하고 제조할 제품에 따라 몸통, 점화장치조립품, 인서트 등의 부품을 자동공급장치에 공급한다. 제품의 크기에 맞춰 이송지그의 위치와 속도를 조정한다. 제품 제조 중 라이터 몸통에 인서트를 삽입하고 융착하는 과정에 이상이 없는지 확인하고 자동가스주입 후 점화장치를 조립하고 불꽃검사, 발화검사 공정에서 불량이 확인된 제품을 제조라인에서 제거한다. 생산이 완료된 제품은 완제품검사를 위해 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"라이터제조기조작원","connectJob":"노즐조립원, 롤러조립원, 몰드플랜결합원, 밸브원","dJobECd":"8524","dJobECdNm":"[8524]고무·플라스틱 제품 조립원","dJobJCd":"8324","dJobJCdNm":"[8324]고무 및 플라스틱제품 조립원","dJobICd":"C339","dJobICdNm":"[C339]그 외 기타 제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001372:1', '{"dJobCd":"K000001372","dJobCdSeq":"1","dJobNm":"라이터제조현장감독자","workSum":"라이터를 제조하기 위하여 부품을 조립하고 가스를 주입하는 데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"제조하고자 하는 라이터의 생산계획을 세운다. 원료와 생산설비를 점검한다. 작업계획에 따라 세부실행항목을 수립하고 작업절차 및 방법을 결정하여 작업원에게 작업내용을 지시하고 작업배치를 한다. 함께 작업하며 작업의 진행상황을 파악하고 작업내용을 상부에 보고한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원 및 자재를 공급한다. 작업표준에 따라 지시된 작업이 이루어지는지 확인한다. 작업원의 직무교육 및 안전위생 교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴·해결하고 문제점을 보완한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"라이터제조반장","dJobECd":"8524","dJobECdNm":"[8524]고무·플라스틱 제품 조립원","dJobJCd":"8324","dJobJCdNm":"[8324]고무 및 플라스틱제품 조립원","dJobICd":"C339","dJobICdNm":"[C339]그 외 기타 제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006167:1', '{"dJobCd":"K000006167","dJobCdSeq":"1","dJobNm":"마네킹마무리원","workSum":"마네킹의 표면을 연마하고 피부색에 맞는 페인트칠을 하는 등 마네킹 제조의 마무리 작업을 한다.","doWork":"결합부를 그라인딩하고 연마지를 제품표면의 곡선에 따라 고르게 문지른다. 연마 작업에서 발생한 먼지를 털어낸 후, 마네킹의 표면에 나타난 흠을 약품을 사용하여 메운다. 일정 시간이 지난 후 제품 표면을 다시 사포로 문지른다. 피부색에 맞는 스프레이를 사용하여 마네킹의 표면에 도장한다. 도장한 마네킹의 표면에 흠집이나 긁힘이 있는지 육안으로 확인하고 흠을 메우거나 긁힘을 없앤다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"사포마무리원","dJobECd":"8524","dJobECdNm":"[8524]고무·플라스틱 제품 조립원","dJobJCd":"8324","dJobJCdNm":"[8324]고무 및 플라스틱제품 조립원","dJobICd":"C339","dJobICdNm":"[C339]그 외 기타 제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004877:1', '{"dJobCd":"K000004877","dJobCdSeq":"1","dJobNm":"승용완구조립원","workSum":"페달형, 전동형, 수동형 승용완구를 제조하기 위하여 각 부품을 조립한다.","doWork":"승용완구에 사용되는 각 부품을 작업대에 준비한다. 전동형 승용완구는 전동장치를 내부에 조립한다. 용접기로 각 부품을 연결한다. 용접이 끝난 각 부품을 사포로 다듬고 스프레이를 사용하여 도장을 한다. 안장·발판 등 플라스틱 부품을 고무망치를 사용하여 부착한다. 몸체·바퀴·핸들 등을 볼트와 너트로 조립한다. 조립이 끝난 완성품을 시운전하여 이상 유무를 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8524","dJobECdNm":"[8524]고무·플라스틱 제품 조립원","dJobJCd":"8324","dJobJCdNm":"[8324]고무 및 플라스틱제품 조립원","dJobICd":"C334","dJobICdNm":"[C334]인형, 장난감 및 오락용품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005741:1', '{"dJobCd":"K000005741","dJobCdSeq":"1","dJobNm":"의료용품조립원","workSum":"수액·수혈세트, 주사기 등과 의료용품을 제조하기 위하여 관련 부품 및 부분품을 조립한다.","doWork":"조립하기 전에 작업지시서를 검토하고 관련 부품을 준비한다. 손이나 공구를 사용하여 부분품을 조립한다.  제품에 따라 접착제, 초음파용착기를 사용하여 부품과 부품을 결합한다. 자동화 공정 라인에서 자동조립될 수 있도록 관련 부품을 위치시키고 중간 검사를 통해서 불량품을 제거한다. 자동화공정에서 기계적인 문제점으로 발생한 미조립품은 직접 손으로 조립한다. 최종 조립된 부품을 멸균 또는 검사공정 등 다음 공정으로 넘긴다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8524","dJobECdNm":"[8524]고무·플라스틱 제품 조립원","dJobJCd":"8324","dJobJCdNm":"[8324]고무 및 플라스틱제품 조립원","dJobICd":"C271","dJobICdNm":"[C271]의료용 기기 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001810:1', '{"dJobCd":"K000001810","dJobCdSeq":"1","dJobNm":"장난감검사원","workSum":"완성된 각종 장난감이나 인형을 육안이나 기구를 사용해 검사한다.","doWork":"장난감 표면에 긁힌 자국이나 흠, 파손 등이 있는지 육안으로 검사해 작업표준과 비교한다. 시험기구를 사용하여 장난감의 작동상태를 확인한다. 이상이 있는 제품은 불량부분을 표시하여 해당 부서로 보낸다. 젖은 스펀지로 장난감의 외부를 닦는다. 봉제인형에 남아있는 실이나 실밥을 가위로 제거하기도 하며 완성된 제품을 포장하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"목제완구검사원, 봉제완구검사원, 플라스틱완구검사원","dJobECd":"8524","dJobECdNm":"[8524]고무·플라스틱 제품 조립원","dJobJCd":"8324","dJobJCdNm":"[8324]고무 및 플라스틱제품 조립원","dJobICd":"C334","dJobICdNm":"[C334]인형, 장난감 및 오락용품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003695:1', '{"dJobCd":"K000003695","dJobCdSeq":"1","dJobNm":"장난감마무리원","workSum":"장난감이나 봉제인형에 각종 장식품을 부착해 마무리를 하고 포장을 한다.","doWork":"각종 장식품을 작업대에 준비한다. 반제품에 접착제를 칠하여 각종 장식품을 붙인다. 먼지와 군더더기 섬유를 송풍기나 공기호스를 사용하여 제거한다. 완성한 제품을 육안으로 검사한 후 포장한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8524","dJobECdNm":"[8524]고무·플라스틱 제품 조립원","dJobJCd":"8324","dJobJCdNm":"[8324]고무 및 플라스틱제품 조립원","dJobICd":"C334","dJobICdNm":"[C334]인형, 장난감 및 오락용품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004440:1', '{"dJobCd":"K000004440","dJobCdSeq":"1","dJobNm":"장난감제조현장감독자","workSum":"각종 장난감을 제조하는 데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"제조하고자 하는 장난감의 생산계획을 세운다. 원료와 생산설비를 점검한다. 작업계획에 따라 세부실행항목을 수립하고 작업절차 및 방법을 결정하여 작업원에게 작업내용을 지시하고 작업배치를 한다. 함께 작업하며 작업의 진행상황을 파악하고 작업내용을 상부에 보고한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원 및 자재를 공급한다. 작업표준에 따라 지시된 작업이 이루어지는지 확인한다. 작업원의 직무교육 및 안전위생 교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴·해결하고 문제점을 보완한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"수동조작","similarNm":"장난감제조반장","connectJob":"나무장난감제조반장, 인형제조반장, 플라스틱장난감제조반장","dJobECd":"8524","dJobECdNm":"[8524]고무·플라스틱 제품 조립원","dJobJCd":"8324","dJobJCdNm":"[8324]고무 및 플라스틱제품 조립원","dJobICd":"C334","dJobICdNm":"[C334]인형, 장난감 및 오락용품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001852:1', '{"dJobCd":"K000001852","dJobCdSeq":"1","dJobNm":"장난감조립원","workSum":"각종 수동, 전동 도구를 사용하여 장난감의 부품을 조립하고 장식품을 부착한다.","doWork":"조립하고자 하는 부품을 손이나 핀셋·플라이어 등의 도구를 사용하여 작업대 위에 놓는다. 드릴프레스, 용접기, 못 박는 자동기계, 플랜지 연결기계, 펀치프레스 등을 사용하여 장난감 부품에 구멍을 뚫거나 절단·용접·다듬기·맞추기·삽입 작업을 한다. 접착제·지그·나사·못·수동공구·동력공구를 사용하여 장난감의 부품을 조립하고 고정한다. 조립한 제품이 제품표준과 맞는지 확인하고 동작 여부를 검사한다. 각종 장식품으로 장난감이나 봉제인형을 장식하고 마무리하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"나무장난감조립원, 인형조립원, 플라스틱장난감조립원","dJobECd":"8524","dJobECdNm":"[8524]고무·플라스틱 제품 조립원","dJobJCd":"8324","dJobJCdNm":"[8324]고무 및 플라스틱제품 조립원","dJobICd":"C334","dJobICdNm":"[C334]인형, 장난감 및 오락용품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007036:1', '{"dJobCd":"K000007036","dJobCdSeq":"1","dJobNm":"전선자재시험원","workSum":"전선제조 공정에 사용하는 원, 부자재를 시험, 검사하여 합격 여부를 판정한다.","doWork":"전선 제조에 사용되는 원, 부자재의 재료 규격 및 인수검사 규격을 확인한다. 규정된 방법으로 원부자재의 시험과 검사를 한다. 시험 및 검사 결과를 기록하고 합격 여부를 결정한 후 관련 부서에 통보한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8524","dJobECdNm":"[8524]고무·플라스틱 제품 조립원","dJobJCd":"8324","dJobJCdNm":"[8324]고무 및 플라스틱제품 조립원","dJobICd":"C283","dJobICdNm":"[C283]절연선 및 케이블 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002172:1', '{"dJobCd":"K000002172","dJobCdSeq":"1","dJobNm":"테니스라켓가공원","workSum":"테니스라켓을 제조하기 위하여 스트링(string)을 매는 구멍을 뚫고 프레임의 표면을 매끄럽게 다듬질한다.","doWork":"테니스라켓의 프레임을 드릴링 형틀에 고정한다. 드릴링기에 드릴날을 끼운다. 드릴날의 끝부분과 형틀에 고정된 프레임의 중심점이 맞도록 드릴링기의 높낮이를 조정한다. 기계의 전원을 넣고 가동한다. 금형 하단의 홈과 기계 중앙의 안내핀을 맞추어 서서히 밀면서 드릴링한다. 일차 드릴링이 끝나면 트위스트 드릴날을 사용하여 다시 구멍을 뚫는다. 굵은 드릴날을 사용하여 큰 구멍을 뚫는다. 성형된 프레임의 표면을 가는 사포로 매끄럽게 연마한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","dJobECd":"8524","dJobECdNm":"[8524]고무·플라스틱 제품 조립원","dJobJCd":"8324","dJobJCdNm":"[8324]고무 및 플라스틱제품 조립원","dJobICd":"C333","dJobICdNm":"[C333]운동 및 경기용구 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006322:1', '{"dJobCd":"K000006322","dJobCdSeq":"1","dJobNm":"테니스라켓완성원","workSum":"라켓 손잡이에 비닐테이프를 씌우고 프레임에 스트링(string)을 얽어 매 테니스 라켓을 완성한다.","doWork":"소비자가 원하는 라켓의 중량과 균형을 맞추기 위하여 납을 사용하여 조정한다. 손잡이 부분의 이물질을 헝겊으로 닦고 양면테이프를 사용하여 라켓의 그립부위에 감는다. 그립가죽을 밑에서부터 폭이 일정하게 돌돌 감는다. 비닐테이프로 가죽을 고정시키고 칼로 끝부분을 끊는다. 라켓 헤드에 스트링(string)을 얽어 매기 위하여 라켓 프레임을 작업대에 너트로 고정한다. 수동공구를 이용해  라켓 헤드의 구멍에 규정된 순서에 따라 스트링(string)을 서로 얽어맨다. 이때 가로줄과 세로줄을 서로 다른 스트링(string)으로 매면서 텐션(공의 컨트롤 조작성과 파워에 영향을 줌)의 세기를 달리하기도 한다. 라켓그립에 수축비닐을 씌운 후, 불에 쬐여 수축이 되게 한다. 저울을 사용하여 라켓의 중량을 측정하고 크기에 맞는 스티커를 부착하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","similarNm":"테니스라켓마무리원","connectJob":"테니스라켓손잡이감기원, 테니스라켓줄매기원","dJobECd":"8524","dJobECdNm":"[8524]고무·플라스틱 제품 조립원","dJobJCd":"8324","dJobJCdNm":"[8324]고무 및 플라스틱제품 조립원","dJobICd":"C333","dJobICdNm":"[C333]운동 및 경기용구 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003223:1', '{"dJobCd":"K000003223","dJobCdSeq":"1","dJobNm":"테니스라켓제조반장","workSum":"테니스라켓을 제조하기 위하여 성형·가공·도장·마무리 공정에 종사하는 작업원들의 활동을 감독·조정한다.","doWork":"제품규격과 고객의 요구에 따라 생산계획을 세운다. 생산계획에 따라 작업표준을 설정한다. 원료와 생산설비를 점검한다. 작업계획에 따라 세부실행항목을 수립하고 작업절차 및 방법을 결정하여 작업원에게 작업내용을 지시하고 작업배치를 한다. 라켓의 헤드에 매는 스트링(string)의 종류와 탄성 강도, 매는 방법을 지시하고 점검한다. 작업의 진행사항을 파악하고 작업내용을 보고한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원 및 자재를 공급한다. 작업표준에 따라 지시된 작업이 이루어지는지 확인한다. 작업원의 직무교육 및 안전위생 교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴·해결하고 문제점을 보완한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"8524","dJobECdNm":"[8524]고무·플라스틱 제품 조립원","dJobJCd":"8324","dJobJCdNm":"[8324]고무 및 플라스틱제품 조립원","dJobICd":"C333","dJobICdNm":"[C333]운동 및 경기용구 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006664:1', '{"dJobCd":"K000006664","dJobCdSeq":"1","dJobNm":"튜브수선원","workSum":"고무호스 등에 사용되는 고무튜브의 결함부를 확인한 후 연마기와 롤러 등을 이용해 수선한다.","doWork":"가류작업이 완료된 후 공기 누출 외관 검사 과정 등을 통해 미리 표시가 된 결함부분을 확인한다. 손연마기로 결함이 있는 부분을 거칠게 연마한다. 연마된 부분을 닦아내고 접착제를 칠한다. 접착제가 적당히 건조되면 결함부분과 동일한 고무조각을 붙이고 롤러를 눌러준다. 접착된 부분을 인두질하여 매끄럽게 마무리한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8524","dJobECdNm":"[8524]고무·플라스틱 제품 조립원","dJobJCd":"8324","dJobJCdNm":"[8324]고무 및 플라스틱제품 조립원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001940:1', '{"dJobCd":"K000001940","dJobCdSeq":"1","dJobNm":"플라스틱제품검사원","workSum":"제조된 플라스틱 제품이 제품표준에 맞는지 확인하기 위하여 측정기, 줄자, 저울 등을 사용하여 강도·색상·표면결함·치수 등을 검사한다.","doWork":"제품 표준을 확인하고 완성된 플라스틱제품 외관상의 긁힘, 변색, 티 등과 같은 결함이 있는지를 육안 또는 확대경을 사용하여 표면 검사한다. 자, 측정기기, 저울, 마이크로미터, 캘리퍼스 등의 장비를 사용하여 제품의 길이, 두께, 무게 등의 규격을 검사한다. 전등 및 눈금이 새겨진 스크린 사이에 투명한 플라스틱제품을 놓고 스크린에 투사된 모형을 관찰하거나 이물질 또는 굴곡이 있는지 관찰한다. 견본 또는 색상카드와 플라스틱제품을 보고 색상을 비교한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"품질경영(산업)기사","dJobECd":"8524","dJobECdNm":"[8524]고무·플라스틱 제품 조립원","dJobJCd":"8324","dJobJCdNm":"[8324]고무 및 플라스틱제품 조립원","dJobICd":"C222","dJobICdNm":"[C222]플라스틱제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004207:1', '{"dJobCd":"K000004207","dJobCdSeq":"1","dJobNm":"플라스틱제품최종작업원","workSum":"사출 성형·압출 성형된 각종 플라스틱 제품, 또는 섬유강화플라스틱 제품을 완성하기 위해 마무리 작업을 한다.","doWork":"동력연삭기나 동력톱, 연삭칼 등을 사용하여 크기와 형태에 따라 군더더기 부분을 갈거나 잘라낸다. 드릴프레스·동력드릴 등을 사용하여 구멍을 뚫는다. 휴대용 대패, 동력사포연삭기 등을 사용하여 제품의 거친 면을 곱게 연마한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"플라스틱제품연삭원","dJobECd":"8524","dJobECdNm":"[8524]고무·플라스틱 제품 조립원","dJobJCd":"8324","dJobJCdNm":"[8324]고무 및 플라스틱제품 조립원","dJobICd":"C222","dJobICdNm":"[C222]플라스틱제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004193:1', '{"dJobCd":"K000004193","dJobCdSeq":"1","dJobNm":"금괴주조원","workSum":"금전해에서 전착된 금음극을 노에서 용해시켜 금괴를 주조한다.","doWork":"금전해 후 음극판에 전착된 금 음극판을 수동공구를 사용하여 박리한다. 박리된 금 음극판을 용해로에 투입하여 용해한다. 용해 후 샘플을 채취하여 순도 분석을 의뢰한 후 그 결과를 각인한다. 용탕 표면에 초석을 장입하여 불순물을 산화시키고 제거한다. 용탕을 주형에 부어 주조한다. 주조된 금을 규정 중량씩 달아 절단하고 재용해시켜 금괴 주조용 주형에 주조한다. 주조된 금괴에 일련번호, 순도, 중량 등을 각인하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"고온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"귀금속주조원","connectJob":"금주조원","certLic":"주조기능사, 주조산업기사, 주조기능장","dJobECd":"8234","dJobECdNm":"[8234]주조기조작원","dJobJCd":"8411","dJobJCdNm":"[8411]주조기 조작원","dJobICd":"C243","dJobICdNm":"[C243]금속 주조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004797:1', '{"dJobCd":"K000004797","dJobCdSeq":"1","dJobNm":"금양극판주조원","workSum":"은전해에서 발생된 금전물 중 은을 질산에 용해시켜 생산된 금사(Gold Sand)를 용해하여 금전해용 금양극을 주조한다.","doWork":"버너를 점화시켜 노를 가열하고 조정기를 조정하여 노의 온도를 일정하게 유지한다. 금사를 붕사와 함께 노에 장입시키고 부유된 붕사 슬래그를 수동공구를 사용하여 제거한다. 슬래그가 제거된 금용탕에 염소가스를 주입시켜 불순물을 산화제거 한다. 금양극 제조용 주형을 버너로 예열하고 수동공구를 사용하여 금용탕을 예열된 주형에 부어 금양극을 주조한다. 생산된 금양극의 양을 일지에 기록·보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"귀금속주조원","connectJob":"금양극판주조원","certLic":"주조기능사, 주조산업기사, 주조기능장","dJobECd":"8234","dJobECdNm":"[8234]주조기조작원","dJobJCd":"8411","dJobJCdNm":"[8411]주조기 조작원","dJobICd":"C243","dJobICdNm":"[C243]금속 주조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005278:1', '{"dJobCd":"K000005278","dJobCdSeq":"1","dJobNm":"금형주조기조작원","workSum":"아연, 알루미늄, 구리 등의 비철금속 재료를 용해하여 금형으로 정밀주조하는 금형주조기를 조작한다.","doWork":"금형을 체인 인양기나 기중기로 들어 올리고 수동공구를 사용하여 기계의 지정된 위치에 바르게 놓는다. 램의 왕복운동을 조정하고 냉각 및 이형제 분사호스를 연결한다. 토치램프 또는 전기가열기로 금형을 예열한다. 주조물의 크기 및 형태, 금속의 종류에 따라 밸브를 돌려 냉각 및 이형제 분사압력을 조절하거나 수동 또는 자동으로 사출속도를 조정한다. 공기 분사호스로 금형의 표면에 붙어 있는 금속 찌꺼기를 씻어내고 금형에서 주조제품이 떨어지도록 금형의 구멍과 플런저에 매 작업마다 이형제와 윤활유를 도포한다. 버튼을 눌러 금형을 닫고 플런저를 작동시켜 금형구멍에 용탕을 주입한다. 자동으로 금형문이 열리면 집게로 주물제품을 꺼낸다. 주물의 결함 여부를 육안으로 검사한다. 용탕의 온도를 일정하게 유지하기 위해 보온로를 관리하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"정밀금형주조기조작원, 다이캐스트주조기조작원, 로스트왁스주조기조작원","certLic":"주조기능사, 주조산업기사, 주조기능장","dJobECd":"8234","dJobECdNm":"[8234]주조기조작원","dJobJCd":"8411","dJobJCdNm":"[8411]주조기 조작원","dJobICd":"C243","dJobICdNm":"[C243]금속 주조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002268:1', '{"dJobCd":"K000002268","dJobCdSeq":"1","dJobNm":"금형주조반장","workSum":"금형을 이용하여 금형주조제품을 생산하는데 종사하는 작업원의 업무를 분장하고 조정한다.","doWork":"작업지시서를 읽고 사용될 주조기계 및 금형의 유형을 결정한다. 주조시간, 금형의 주유, 금형의 가열정도, 금형 사이의 간격 등을 조정한다. 주조제품의 결함을 제거하기 위해 생산계획에 의해 금형교체작업을 지시한다. 작업장을 순회하며 안전교육 및 현장교육을 실시한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"주조제품생산반장","connectJob":"다이캐스팅기주조반장, 로스트왁스주조반장","certLic":"주조기능사, 주조산업기사, 주조기능장","dJobECd":"8234","dJobECdNm":"[8234]주조기조작원","dJobJCd":"8411","dJobJCdNm":"[8411]주조기 조작원","dJobICd":"C243","dJobICdNm":"[C243]금속 주조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005743:1', '{"dJobCd":"K000005743","dJobCdSeq":"1","dJobNm":"밸브주조원","workSum":"용해로에 금속을 주입하여 용융시킨 용융금속을 주형틀에 주입해 밸브를 만든다.","doWork":"작업에 필요한 장비와 안전도구를 준비한다. 작업지시서에 따라 주조할 제품의 명세서를 확인·검토한다. 제품을 작업대 위에 올려놓는다. 작업지시서 및 작업표준에 따라 금속을 용해로에 주입한다. 용융된 금속을 준비된 조형기에 주입하여 기계를 작동한다. 일정한 응고시간이 지난 후 조형기에서 주조물을 분리해 낸다. 주조품 제작을 위해 사용한 거푸집의 모래를 제거하고 제품별로 구분한 뒤 기포 및 불량 여부를 확인한다. 합격품으로 판정된 제품의 후처리 가공을 위하여 다음 공정으로 이송한다. 모형(Pattern:원형)을 이용하여 탕구계를 포함하는 모래 주형(Sand Mold)을 만든다. 주철 및 단조강의 금속을 전기용해로에 주입하여 용융한다. 용융된 금속을 도면에 따라 제작된 주형 안에 주입한다. 작업지시서의 응고시간이 경과한 후 주형틀에서 주조물을 분리한다. 기계적 성질을 강화하기 위하여 담금질, 템퍼링 등 열처리를 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|고온|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"밸브생산원","connectJob":"밸브주조제품생산원","certLic":"주조기능사, 주조산업기사, 주조기능장","dJobECd":"8234","dJobECdNm":"[8234]주조기조작원","dJobJCd":"8411","dJobJCdNm":"[8411]주조기 조작원","dJobICd":"C291","dJobICdNm":"[C291]일반 목적용 기계 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001796:1', '{"dJobCd":"K000001796","dJobCdSeq":"1","dJobNm":"비철주조반장","workSum":"동, 아연, 알루미늄 등 비철금속을 주조하는데 종사하는 작업원의 업무를 분장하고 조정한다.","doWork":"주조계획에 따라 세부실행항목을 수립하고 작업원에게 작업을 지시한다. 작업배치 및 인원을 관리하며 안전교육 및 제반 기술교육을 실시한다. 주형을 선택하고 설치·해체하는 작업을 지시한다. 설비를 점검하고 주조품의 품질을 확인·점검한다. 일일 생산량을 확인하고 작업일지를 작성한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"고온|","workFunc1":"조정","workFunc2":"감독","workFunc3":"수동조작","connectJob":"아연주조반장, 알루미늄주조반장","certLic":"주조기능사, 주조산업기사, 주조기능장","dJobECd":"8234","dJobECdNm":"[8234]주조기조작원","dJobJCd":"8411","dJobJCdNm":"[8411]주조기 조작원","dJobICd":"C243","dJobICdNm":"[C243]금속 주조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004901:1', '{"dJobCd":"K000004901","dJobCdSeq":"1","dJobNm":"비철주조원","workSum":"동, 아연, 알루미늄 등의 비철금속 제품을 주조하는 주조기를 조작한다.","doWork":"주조기의 연속작업을 연결시켜 주는 스위치의 고정상태와 작동상태를 점검한다. 공압장치의 동작장치, 압력, 온도 등을 점검하고 작업표준에 맞도록 유지한다. 주조기의 용탕 주입장치, 슬래그 및 이물질 제거장치 등을 점검한다. 비철주조반장이나 작업지시서에 따라 조형을 설치한다. 용탕온도, 주조속도, 냉각수 등을 확인·조절한다. 유도로 주입구에 용탕을 투입한다. 유도로 출탕구를 개방하고 용탕속도 계기를 조절한다. 주조기 주형에 용탕을 주입하고 주입량을 조절한다. 일정 시간 응고시킨 후 주형을 해체하고 냉각한다. 해체된 주형 상태를 확인하고 휨, 뒤틀림, 형태불균일, 크랙, 기포 등을 육안으로 검사한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"고온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"비철제품주조원","connectJob":"아연주조원, 알루미늄주조원","certLic":"주조기능사, 주조산업기사, 주조기능장","dJobECd":"8234","dJobECdNm":"[8234]주조기조작원","dJobJCd":"8411","dJobJCdNm":"[8411]주조기 조작원","dJobICd":"C243","dJobICdNm":"[C243]금속 주조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002934:1', '{"dJobCd":"K000002934","dJobCdSeq":"1","dJobNm":"선재생산원","workSum":"열간 압연된 소재를 공정설계, 산세작업, 피막작업, 열처리 작업, 신선 작업 등을 통하여 고객이 요구하는 규격 및 용도에 맞게 선재(線材)를 생산한다.","doWork":"선재(線材) 생산을 위한 소재, 설비 및 공정 등을 확인한다. 열간압연된 소재를 작업표준에 따라 산세조에서 표면 스케일을 제거하고 중화처리 후 세척을 진행한다. 신선(인발)의 윤활성과 방청의 목적으로 표면처리 약품조에 침적하여 신선성이 좋은 피막을 입힌다. 압연기를 통해 소재를 치입하고 온도, 압하량, 변형속도 등을 조정하며 1차신선 작업을 한다. 제조된 선재를 필요한 재질을 얻기 위한 열처리 수행 후, 2차신선을 진행한다. 2차신선에서 생산된 소선을 스트랜딩기 및 크로싱(Closing) 설비에서 목적한 치수로 가공한다. 외관 검사 및 물성분석을 통해 합격한 제품은 포장을 실시한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|고온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"선제생산설비조작원","connectJob":"압연설비조작원","certLic":"압연기능사, 압연기능장, 주조기능사, 금속재료기능사, 금속재료산업기사","dJobECd":"8234","dJobECdNm":"[8234]주조기조작원","dJobJCd":"8411","dJobJCdNm":"[8411]주조기 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004657:1', '{"dJobCd":"K000004657","dJobCdSeq":"1","dJobNm":"슬라브정정원","workSum":"연속주조를 통해 생산된 반제품(슬라브, 블룸, 빌렛 등)의 표면 결함을 검사하고, 결함 발생시 스카핑을 통해 결함을 제거한다.","doWork":"작업지시서를 통해, 적치장에서 슬라브 등 반제품의 일련번호를 확인하고, 반제품 표면의 균열, 핀홀 등 결함 유무를 확인하고 위치 및 개소를 기록하고 평점을 기록지에 기재한다. 결함 부위를 석필로 표기하고, 산소-아세틸렌가스 토치를 이용한 스카핑으로 표면 결함을 제거한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"스카핑기술자","connectJob":"슬라브정정원","certLic":"제강기능사, 전기기능사,  주조기능사, 제강기능장, 가스기능사, 용접기능사, 금속재료기능사, 환경, 안전관계 자격","dJobECd":"8234","dJobECdNm":"[8234]주조기조작원","dJobJCd":"8411","dJobJCdNm":"[8411]주조기 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003021:1', '{"dJobCd":"K000003021","dJobCdSeq":"1","dJobNm":"실린더주조원","workSum":"용해로에 금속을 주입하여 용융시킨 용융금속을 주조금형장치에 주입하여 실린더를 주조한다.","doWork":"작업에 필요한 장비와 안전 도구를 준비한다. 작업지시서에 따라 주조할 제품의 명세서를 확인·검토한다. 제품을 작업대 위에 올려놓는다. 용해로 내의 가스, 불순물을 제거하고 용탕을 정련한다. 탄소강 및 단조강의 금속을 전기용해로에 주입하여 용융한다. 용융된 금속을 주형 안에 주입한다. 일정 온도를 유지하며 냉각한다. 제품의 기계적 성질을 강화하기 위하여 열처리를 한다. 건조시킨 후 완성품의 강도 및 경도, 표면상태를 검토한다. 균열이 있거나 불량인 제품은 분리하여 재가공한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|고온|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"실린더주조원","certLic":"주조기능사, 주조산업기사, 주조기능장","dJobECd":"8234","dJobECdNm":"[8234]주조기조작원","dJobJCd":"8411","dJobJCdNm":"[8411]주조기 조작원","dJobICd":"C291","dJobICdNm":"[C291]일반 목적용 기계 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003063:1', '{"dJobCd":"K000003063","dJobCdSeq":"1","dJobNm":"알루미늄연속주조원","workSum":"용해된 알루미늄을 원료로 알루미늄판을 연속적으로 생산하기 위하여 가스 및 이물질을 제거하여 알루미늄연속주조기에 용탕을 주입한다.","doWork":"생산할 알루미늄판의 두께 및 폭에 따라 롤의 구경 및 노즐을 조정한다. 가이드, 필터 등을 조립하고 기계의 이상 여부를 점검한다. 용해로의 용탕 온도, 냉각수 압력 및 온도를 확인하고 주조기를 가동한다. 판이 주조되어 나오면 온도 및 전류계를 확인하고 주조속도를 조절한다. 지시된 두께 및 폭을 맞추기 위하여 압하량 및 주조속도를 조정한다. 가스를 제거하기 위하여 아르곤을 투입한다. 연속 주조되어 나오는 판을 관찰하여 이상 여부를 확인하며 생산을 유지한다. 주조기를 점검하고 급유한다. 정기수리 시 지원한다. 주조된 제품의 표면 상태(휨, 크랙, 기포 등)를 육안으로 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"주조설비조작원","connectJob":"알루미늄주조설비조작원","dJobECd":"8234","dJobECdNm":"[8234]주조기조작원","dJobJCd":"8411","dJobJCdNm":"[8411]주조기 조작원","dJobICd":"C243","dJobICdNm":"[C243]금속 주조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003698:1', '{"dJobCd":"K000003698","dJobCdSeq":"1","dJobNm":"연속주조보조원","workSum":"연속주조 설비를 운전하는 금속연속주조원의 업무를 보조한다.","doWork":"금속연속주조원의 지시를 받아 천장기중기를 통해 이동하는 랜들을 유도하여 턴디시 테이블에 정차시키는 작업을 보조한다. 래이들(Ladle)에서 턴디시로 슬랙의 유출 여부를 감시하며 유출 시 레이들(Ladle) 노즐을 막는 작업을 보조한다. 용강이 외기와 접촉하는 것을 차단하고 윤활성을 부여하기 위하여 몰드에 몰드파우더를 투입한다. 샘플러를 이용하여 용강의 샘플을 채취하여 검사할 수 있게 보조하고 온도측정기로 측온작업을 보조한다. 연주작업이 완료되면 외주업체의 턴디시의 적출 진행을 관리하고, 몰드 주위의 슬랙 및 지금을 제거한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"주조작업보조원","connectJob":"연속주조작업보조원","dJobECd":"8234","dJobECdNm":"[8234]주조기조작원","dJobJCd":"8411","dJobJCdNm":"[8411]주조기 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002616:1', '{"dJobCd":"K000002616","dJobCdSeq":"1","dJobNm":"연속주조압연원","workSum":"열간 압연된 소재를 공정설계, 산세작업, 피막작업, 열처리 작업, 신선 작업 등을 통하여 고객이 요구하는 규격 및 용도에 맞게 선재(線材) 제품을 생산한다.","doWork":"작업지시서에 명기된 제품의 품질 및 규격을 숙지하고, 원소재를 산세처리하여 표면 스케일을 제거하고, 수세 후 건조시킨다. 이후 인발(신선)가공과 윤활성을 목적으로 선재를 피막액에 침적시켜 피막처리한다. 피막처리 제품을 신선기를 사용하여 금형(다이스)에 통과시켜 요구하는 치수(선경)의 제품을 제조한다. 작업지시서에 규정한 권취방법에 따라 신선을 권취한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|고온|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"주조설비조작원","connectJob":"연속주조설비조작원","certLic":"제강기능사, 제강기능장, 압연기능사, 압연기능장","dJobECd":"8234","dJobECdNm":"[8234]주조기조작원","dJobJCd":"8411","dJobJCdNm":"[8411]주조기 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004372:1', '{"dJobCd":"K000004372","dJobCdSeq":"1","dJobNm":"연속주조작업원","workSum":"정련된 용강을 연속적으로 주형에 주입 및 응고시켜 주편을 제조하고 이를 절단하여 슬라브(Slab), 블룸(Bloom) 또는 빌릿(Billet) 등을 제조한다.","doWork":"제강공장에서 생산된 용강을 침지노즐을 통해 턴디시에 주입하고 스토퍼나 슬라이드 게이트를 이용하여 용강을 몰드에 주입한다. 몰드내 용강레벨을 관찰하며 몰드플럭스를 투입한다. 주조(응고) 시작 후 설비 트레킹에 따라 주조속도를 조정하며 경우에 따라 EMS(용강의 전자기교반장치)를 가동한다. 스트랜드로 이송된 주편을 냉각수를 이용하여 적정 속도로 냉각하고TCM을 이용하여 주편을 적정길이로 절단하여 조강(슬라브, 블룸, 빌릿 등)을 생산한다. 이때 디버러를 가동시켜 절단 주편하부의 버를 제거하고 롤러 테이블을 운전하여, 후속공정으로 이송한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","similarNm":"주조제품생산반장","connectJob":"연속주조제품생산반장","certLic":"제강기능사, 전기기능사, 주조기능사, 제강기능장, 가스기능사, 용접기능사","dJobECd":"8234","dJobECdNm":"[8234]주조기조작원","dJobJCd":"8411","dJobJCdNm":"[8411]주조기 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004834:1', '{"dJobCd":"K000004834","dJobCdSeq":"1","dJobNm":"은괴주조원","workSum":"은전해에서 생산된 은결정을 용해로에서 용해하여 은괴를 주조한다.","doWork":"은용해로의 버너를 점화시켜 용해로의 온도를 상승시키고 은전해에서 생산된 은결정을 용해로에 주입하여 용해한다. 용해 후 샘플을 채취하여 순도 분석을 의뢰한 후 그 결과를 각인한다. 은용탕 표면에 생성된 슬래그를 제거하고 은용탕을 예열된 은괴 주형에 주입하여 은괴를 주조한다. 주조된 은괴의 순도를 측정하고 일련번호, 순도, 중량을 각인하여 은 금고에 보관한다. 은전해 후 남은 주반은 및 폐액 중 회수한 은결합제를 함께 은용해로에서 용해시켜 슬래그를 제거한다. 용해된 은을 주조하고, 은 양극을 만들어 다시 은전해조로 장입한다. 은그래뉼(알갱이 형태)로 제조하기도 하며 은그래뉼로 제조하기 위하여 건조기를 조작하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"비철금속주조원","connectJob":"은괴주조원","certLic":"제강기능사, 제강기능장","dJobECd":"8234","dJobECdNm":"[8234]주조기조작원","dJobJCd":"8411","dJobJCdNm":"[8411]주조기 조작원","dJobICd":"C243","dJobICdNm":"[C243]금속 주조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001270:1', '{"dJobCd":"K000001270","dJobCdSeq":"1","dJobNm":"제강원","workSum":"용선 또는 고철을 원료로 용해 및 정련작업을 수행하여 불순성분을 제거하고 목적한 온도와 성분으로 조정하여 양질의 용강을 생산한다.","doWork":"정련작업은 용선 또는 고철에 포함된 불순원소, 가스, 개재물 등을 제거하여 순도를 높이는 작업으로 조업전 용해 및 정련을 위한 전로 또는 전기로 노체와 부대설비 등을 점검한다. 강종 특성에 따라 용해 및 정련과정에서 합금철, 탈산제 투입 및 부원료를 투입하고 온도제어를 통해 목적한 성분과 온도의 용강을 제조한다. 조업 중 측온 및 성분검사를 통해 용강의 품질을 제어하고 슬래그 제재 작업과 출강을 통해 후속공정인 연속주조 또는 조괴작업장으로 용강을 이송한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"고온|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","similarNm":"전로제강원, 전기로제강원","certLic":"제강기능사, 전기기능사, 기계정비기능사, 주조기능사, 제강기능장, 가스기능사, 용접기능사","dJobECd":"8234","dJobECdNm":"[8234]주조기조작원","dJobJCd":"8411","dJobJCdNm":"[8411]주조기 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002174:1', '{"dJobCd":"K000002174","dJobCdSeq":"1","dJobNm":"조동검사원","workSum":"조동주조기에서 주조되는 조동을 검사한다.","doWork":"작업표준에 명시된 검사기준을 확인한다. 주조되는 조동(粗銅, 건식법으로 얻어지는 98~99% 정도 순도의 구리, Blister Copper, Crude Copper)을 관찰하여 중량미달, 형태불균형, 휨, 뒤틀림 등을 검사하고 불량조동은 분리·적재한다. 조동표면에 붙어 있는 불순물을 막대기로 제거한다. 검사일지를 작성한다. 불량품을 해당 부서로 이관 조치한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"고온|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"주조제품품질검사원","connectJob":"주조제품검사원","dJobECd":"8234","dJobECdNm":"[8234]주조기조작원","dJobJCd":"8411","dJobJCdNm":"[8411]주조기 조작원","dJobICd":"C243","dJobICdNm":"[C243]금속 주조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002345:1', '{"dJobCd":"K000002345","dJobCdSeq":"1","dJobNm":"조동주조원","workSum":"정제로에서 정제된 용탕을 주조기에 출탕하여 조동(Blister Copper, Crude Copper, 粗銅)을 주조한다.","doWork":"동정제로조작원으로부터 정제완료시간을 연락받고 출탕준비를 한다. 냉각탱크에 물을 채우고 살수장치의 밸브를 연다. 주조기 주형을 가열하여 일정 온도로 유지한다. 조동주조기의 기능상태를 점검하고 시운전한다. 주형과 주조된 조동의 원활한 분리를 위하여 이형제를 주형에 살포한다. 조동주조기에 정제된 용탕을 주입한다. 주형에서 조동이 떨어지도록 기계를 작동하고 분리된 조동을 냉각탱크에 투입해서 냉각한다. 냉각된 조동을 기중기로 인양한다. 불량주형을 교체하고 탕도를 수리하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"조동분리원, 조동인양원","certLic":"제강기능사, 제강기능장","dJobECd":"8234","dJobECdNm":"[8234]주조기조작원","dJobJCd":"8411","dJobJCdNm":"[8411]주조기 조작원","dJobICd":"C243","dJobICdNm":"[C243]금속 주조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004379:1', '{"dJobCd":"K000004379","dJobCdSeq":"1","dJobNm":"주화제조반장","workSum":"비철금속 판재로부터 타발, 세척, 검사, 계수 등을 통해 소전을 생산하는데 종사하는 직원의 업무를 분장하고 조정한다.","doWork":"생산계획에 따라 소전의 생산에 관련된 작업원들에게 세부작업을 지시한다. 주조라인에서 주조, 면삭된 원판재를 인계받아 타발, 세정, 검사, 계수를 통해 최종 소전을 생산·포장하는 업무를 책임진다. 안전과 폐수처리와 같은 환경점검 및 이상 유무에 대해서도 관리책임을 진다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","similarNm":"소전생산반장","connectJob":"주화제조반장","certLic":"주조기능사, 주조기능장, 주조산업기사","dJobECd":"8234","dJobECdNm":"[8234]주조기조작원","dJobJCd":"8411","dJobJCdNm":"[8411]주조기 조작원","dJobICd":"C331","dJobICdNm":"[C331]귀금속 및 장신용품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003891:1', '{"dJobCd":"K000003891","dJobCdSeq":"1","dJobNm":"주화주조원","workSum":"용해설비, 주조설비 및 관련 설비를 조정·조작하여 주화를 주조한다.","doWork":"작업지시서나 주화제조반장의 지시에 따라 작업내용을 파악한다. 재료를 준비하고 배합표준에 따라 재료를 계근한다. 용해 시 필요한 탈산봉, 숯, 주입봉 등의 부자재를 준비한다. 로체, 인출기, 절단기 등 각종 설비 및 부대장치를 점검하여 이상 여부를 확인하고 제조공정에 맞게 설비를 조립한다. 주조 및 관련 설비를 점검·확인하여 이상 유무를 확인한다. 주조에 적당한 온도가 되면 주조설비를 준비하고 생산할 주화의 종류 등에 따라 인출기, 절단기 등의 준비하여 설비를 조립한다. 주조가 진행됨에 따라 슬랩(Slab)의 길이가 일정하게 되도록 절단한다. 주조가 완료되면 기계설비를 정지하고 설비를 점검한다. 작업내용을 작업일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|고온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"주조제품생산원","connectJob":"금화주조원, 은화주조원","certLic":"주조기능사, 주조기능장, 주조산업기사","dJobECd":"8234","dJobECdNm":"[8234]주조기조작원","dJobJCd":"8411","dJobJCdNm":"[8411]주조기 조작원","dJobICd":"C331","dJobICdNm":"[C331]귀금속 및 장신용품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005280:1', '{"dJobCd":"K000005280","dJobCdSeq":"1","dJobNm":"축전지납주조원","workSum":"격자(Grid) 및 축전지 부품을 생산하기 위해서 납괴를 용해로에 녹이고 주조하는 기계를 조작한다.","doWork":"작업복을 갖추고 용해로를 청소하고 작동 준비를 한다. 극판용 그리드나 극판 제조의 원자재인 칼슘, 합성연을 준비한다. 생산하고자 하는 극판 및 축전지 부품의 치수에 맞게 주조의 틀을 교체한다. 칼슘합성연 덩어리를 용해로에 투입하고 완전히 용해될 때까지 일정 시간 용해로를 가동한다. 용해된 납의 주입이 완료되고 충분한 응고시간이 지난 후 수동공구를 사용해서 주형에서 주조물을 분리한다. 주조된 격자나 부품의 상태를 검사하고 용해로의 온도를 조절한다. 균열·군더더기·결함이 있는 격자 및 주형부품을 골라내고 이상이 있는 부품을 다시 용해로에 집어넣는다. 주조된 기판을 경화시키기 위해 숙성실로 옮기고 일정 기간 상온에서 보관한다. 생산된 격자 및 부품을 일정한 단위로 적재하거나 상자에 담는다. 주형을 교체·수리하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"납주조설비조작원","connectJob":"축전지격자주조원, 축전지부품주조원","certLic":"주조기능사","dJobECd":"8234","dJobECdNm":"[8234]주조기조작원","dJobJCd":"8411","dJobJCdNm":"[8411]주조기 조작원","dJobICd":"C282","dJobICdNm":"[C282]일차전지 및 축전지 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006054:1', '{"dJobCd":"K000006054","dJobCdSeq":"1","dJobNm":"극인압사원","workSum":"원극인 및 극인을 제조하기 위하여 호빙프레스(Hobbing Press)를 사용하여 주어진 문양을 압력으로 전사한다.","doWork":"작업기준에 따라 원극인 및 극인의 제조량 및 소재의 수량과 규격을 확인·인수한다. 소재에 도포된 방청유를 제거하고 건조한다. 주화 종류에 따라 홀더 및 가이드를 선정하고 프레스에 설치한다. 압사속도와 하중을 지정된 기준으로 조정한다. 소재를 삽입하고 원극인을 거치한다. 작업기준에 따라 압사하고, 압사상태를 검사한다. 소재의 절단작업과 연마작업을 수행하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"훈장압사타발원","dJobECd":"8232","dJobECdNm":"[8232]단조기조작원","dJobJCd":"8412","dJobJCdNm":"[8412]단조기 조작원","dJobICd":"C331","dJobICdNm":"[C331]귀금속 및 장신용품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001623:1', '{"dJobCd":"K000001623","dJobCdSeq":"1","dJobNm":"단조기조작원","workSum":"도면 또는 예비형상의 도면이나 견본품을 바탕으로 금속재질을 일정한 형태의 모양이나 규격으로 성형하는 단조기를 조작하고 소재의 가공 및 후처리 작업을 한다.","doWork":"작업지시서에 따른 작업내용을 확인한다. 작업지시서상의 재료가 일치하는지 확인한다. 작업지시서에 따라 작업공정방법을 선택한다. 단조금형을 선택하고 단조기에 금형을 설치하여 고정한다. 시험작동을 하여 윤활상태 등을 점검한다. 단조 성형할 제품을 금형 위에 올려놓는다. 기계를 가동하여 작업지시서의 규격대로 성형한다. 작업 중간 중간에 버니어캘리퍼스, 한계게이지 등으로 규격을 검사한다. 담금질 등의 열처리작업을 위하여 가열로에 소성시켜 냉각한다. 완성품을 이동시키거나 적재한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"냉간단조프레스조작원, 열간단조프레스조작원, 낙하해머조작원, 벨트드롭해머조작원, 에어해머조작원, 업셋프레스조작원, 후렉션프레스조작원","dJobECd":"8232","dJobECdNm":"[8232]단조기조작원","dJobJCd":"8412","dJobJCdNm":"[8412]단조기 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001655:1', '{"dJobCd":"K000001655","dJobCdSeq":"1","dJobNm":"볼트롤링기조작원","workSum":"볼트의 나사산을 형성하기 위해 전조설비를 조작한다.","doWork":"자동리프트로 반제품을 자동 또는 수동으로 투입한다. 기존 금형을 해체하고 신규 금형을 세팅한다. 와셔(Washer:볼트나 너트로 물건을 죌 때, 너트 밑에 끼우는 둥글고 얇은 쇠붙이)를 수동으로 공급한다. 전조설비를 조작하여 나사산(나사의 솟아 나온 부분)을 형성한다. 소재경, 외경, 나사부길이, 외관 등을 버니어캘리퍼스, 외관현미경 등으로 검사한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"전조설비조작원","connectJob":"볼트설비작업원","dJobECd":"8232","dJobECdNm":"[8232]단조기조작원","dJobJCd":"8412","dJobJCdNm":"[8412]단조기 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005629:1', '{"dJobCd":"K000005629","dJobCdSeq":"1","dJobNm":"용접철망기조작원","workSum":"철근콘크리트공사의 슬래브나 벽체의 철근 배근을 대체하기 위한 건축자재용 용접철망 및 금속 울타리 등의 건축 설치용 와이어메시(Wire Mesh)철망을 제조하기 위하여 철선을 직교하여 용접하는 용접철망기를 조작한다.","doWork":"작업지시서에 따라 제작할 용접철망의 규격과 철선의 굵기 등 철선의 규격을 정하고 용접철망기계 및 철선을 용접할 용접설비를 준비·점검한다. 작업지시서를 보고 작업명세에 따라 이형철선 및 원형철선코일을 준비한다. 철선코일을 호이스트로 운반하여 직선기에 걸고 일정 길이로 절단하여 직선을 만든다. 철망 크기를 규격대로 맞추기 위하여 용접장치를 조정하여 설치한다. 철망의 가닥수에 따라 일정수의 철선코일을 각 회전판에 걸고 끝 선을 기계에 투입한다. 직선기를 통과한 일정 규격의 선재를 용접기의 상부공급대에 집어넣고 기계에 한 가닥씩 투입되도록 조정한다. 기계 및 용접설비를 가동시켜 교차된 철선을 용접하여 철망을 제작한다. 일정 길이로 완성된 철망을 절단할 수 있도록 절단장치를 조정한다. 철망의 날카로운 부분이나 양면을 카터기로 절단하여 다듬질한다. 완성된 용접철망을 적재한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"저항용접원","certLic":"용접기능사, 용접산업기사, 용접기능장","dJobECd":"8242","dJobECdNm":"[8242]용접기조작원","dJobJCd":"8413","dJobJCdNm":"[8413]용접기 조작원","dJobICd":"C251","dJobICdNm":"[C251]구조용 금속제품, 탱크 및 증기발생기 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004892:1', '{"dJobCd":"K000004892","dJobCdSeq":"1","dJobNm":"초음파용접기조작원","workSum":"모재를 음극 사이에 지지하고 가압하면서 초음파 진동으로 발생하는 열에너지를 이용하여 이종금속 또는 판 두께가 다른 금속이나 부품을 용접한다.","doWork":"발전기 또는 전력공급원으로부터 나오는 일정한 전력의 양에 대하여 도표에 따라 작동계기를 점검한다. 초음파발진기, 진동자, 용접용팁, 가압기구와 각종 제어장치를 점검한다. 조정기를 돌려 일정한 증폭비율, 속도, 고정압력 등을 조절한다. 버튼을 눌러 발열시간과 용접시간을 조정한다. 공작물을 자동운반대 위의 고정구에 고정시키고 버튼을 누르거나 페달을 밟아 용접기를 작동한다. 작동 중인 기계를 관찰하고 비정상적인 작동 여부를 관찰·보고한다. 고정구로부터 용접된 작업물을 제거한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"초음파용접원","certLic":"특수용접기능사","dJobECd":"8242","dJobECdNm":"[8242]용접기조작원","dJobJCd":"8413","dJobJCdNm":"[8413]용접기 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004627:1', '{"dJobCd":"K000004627","dJobCdSeq":"1","dJobNm":"건식소화설비운전원","workSum":"체임버 본체(CDQ Chamber), 보일러, 터빈 등으로 구성된 코크스건식소화설비(CDQ)를 운전한다.","doWork":"오븐에서 압출된 적열코크스(赤熱, Cokes:가열되어 달아오른 코크스)가 버킷(Bucket)에 담겨 건식소화설비(CDQ:Coke Dry Quenching) 위치로 들어오게 되면 크레인을 조작하여 건식소화설비 체임버(Chamber)에 장입하여 적열코크스를 냉각한다. 적열코크스에서 회수된 열로 보일러를 운전하여 증기를 생산한다. 생산된 증기로 터빈을 가동하여 발전하는 작업을 수행한다. 공정 중에 설비 점검, 정비를 수행한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"고온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"CDQ운전원","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C191","dJobICdNm":"[C191]코크스 및 연탄 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002635:1', '{"dJobCd":"K000002635","dJobCdSeq":"1","dJobNm":"고로반장","workSum":"고로 조업에 필요한 연·원료 및 설비점검, 고로내 열풍 및 원료 취입 및 주상작업을 통해 용선을 제조한다.","doWork":"제선작업 계획 및 설비의 이상유무와 투입 원료인 코크스 및 소결광 등의 품질을 확인한다. \n고로 조업에 적정한 연·원료를 고로에 장입한 후 안정된 노황을 유지하면서 철광석을 용해, 환원시켜 양질의 용선을 출선하여 후속 공정인 제강공정에 공급한다. 이에 필요한 설비관리, 품질관리, 환경안전 관리를 수행한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"균형감각|","workEnv":"대기환경미흡|고온|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","similarNm":"고로조업원, 용광로조업원","certLic":"제선기능사, 제선기능장","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;