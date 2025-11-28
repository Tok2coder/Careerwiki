INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002040:1', '{"dJobCd":"K000002040","dJobCdSeq":"1","dJobNm":"마장취체위원","workSum":"경마에 필요한 설비와 예시장을 관리하고 경기를 취체(取締:규칙, 법령, 명령 따위를 지키도록 통제)한다.","doWork":"출입문의 개폐 여부와 주로상의 이물질 방치 여부 등을 점검한다. 경마프로그램을 확인하고 말의 장구나 경마기수의 의상이 규정에 맞는지 확인한다. 규정에 위배되는 장구나 의상은 바꾸도록 지시한다. 출마표상의 출주마와 경마기수가 일치하는지 확인한다. 경기 중 부여된 부담중량의 준수 여부를 확인하기 위하여 경마기수를 관찰한다. 고객이 출주마필을 확인할 수 있도록 마필관리자에게 출주마필을 예시장에 집합시키도록 지시한다. 경주 중 또는 한 경주와 다음 경주 사이에 차량과 사람의 출입을 통제한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"감독","workFunc3":"관련없음","similarNm":"개최집무위원","dJobECd":"4209","dJobECdNm":"[4209]기타 스포츠 및 여가서비스 종사원","dJobJCd":"4329","dJobJCdNm":"[4329]기타 여가 서비스 종사원","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005299:1', '{"dJobCd":"K000005299","dJobCdSeq":"1","dJobNm":"운동경기정찰원","workSum":"경기 전에 상대팀의 경기를 관찰·분석하여 대응방법을 구상할 수 있도록 상대팀의 전력을 분석하여 운동선수코치에게 보고한다.","doWork":"다음에 상대할 팀의 경기를 관찰하고 경기내용을 분석한다. 선수 개개인의 컨디션, 팀분위기 및 경기내용 등을 파악하고 녹화한다. 상대팀의 상황, 팀전술에 따라 대응방법을 분석하고 기록한 내용을 정리하여 운동선수코치에게 보고한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"4209","dJobECdNm":"[4209]기타 스포츠 및 여가서비스 종사원","dJobJCd":"4329","dJobJCdNm":"[4329]기타 여가 서비스 종사원","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001679:1', '{"dJobCd":"K000001679","dJobCdSeq":"1","dJobNm":"응원단원","workSum":"운동경기 중 소속팀의 사기를 북돋우기 위하여 응원을 한다.","doWork":"경기가 시작되기 전에 소속팀의 선수명단을 확인하고 명단이나 구호를 사전에 미리 암기한다. 응원복을 착용하고 확성기와 응원도구를 이용하여 관중의 이목을 집중시킨다. 춤이나 동작 등을 취하여 관중들이 따라 하거나 함성을 지르도록 유도하고 각종 구호를 연호하도록 선창한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"웅크림|","workFunc1":"비교","workFunc2":"오락제공","workFunc3":"관련없음","similarNm":"치어걸, 치어리더","connectJob":"응원단장","dJobECd":"4209","dJobECdNm":"[4209]기타 스포츠 및 여가서비스 종사원","dJobJCd":"4329","dJobJCdNm":"[4329]기타 여가 서비스 종사원","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004219:1', '{"dJobCd":"K000004219","dJobCdSeq":"1","dJobNm":"카지노딜러","workSum":"카지노 영업장에서 고객을 상대로 테이블게임을 진행한다.","doWork":"게임테이블에서 고객의 착석이나 규정된 돈을 확인한다. 카드, 주사위, 룰렛 등을 사용하여 해당 테이블의 게임을 진행한다. 게임 진행 후 승자나 당첨자에게 일정비율에 의거 칩을 지불하고 패자에게서 칩을 거둬들인다. 현금, 수표, 여행자수표 등을 칩으로 교환하여 준다. 고객의 고액권 칩을 저액권 칩으로 교환하여 준다. 고객의 주문사항이 있으면 웹패드에 입력시키거나 플로어퍼슨에게 알린다. 규칙을 위반하는 고객을 감시하여 플로어퍼슨에게 통보한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"계산","workFunc2":"오락제공","workFunc3":"수동조작","dJobECd":"4209","dJobECdNm":"[4209]기타 스포츠 및 여가서비스 종사원","dJobJCd":"4329","dJobJCdNm":"[4329]기타 여가 서비스 종사원","dJobICd":"R912","dJobICdNm":"[R912]유원지 및 기타 오락관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007223:1', '{"dJobCd":"K000007223","dJobCdSeq":"1","dJobNm":"플로어퍼슨","workSum":"카지노 영업장 피트 내의 특정 플로어(게임테이블)를 담당하여 관할 구역 내에 발생한 모든 사항을 감독한다.","doWork":"피트보스 감독·지시를 받는다. 6개 이하의 게임테이블에서 이루어지는 행위를 1차적으로 감독한다. 게임의 진행을 담당하고 있는 딜러가 실수를 하지 않나 관찰하며 게임진행의 문제점에 대하여 딜러의 보고를 받는다. 칩(카지노에서 사용하는 현금대용화폐)이 부족하면 음식점접객원에게 통보하여 보충하고 여분이 있으면 반납한다. 보충·반납 시 양식지에 서명한다. 바니에게 딜러로부터 주문받은 음료, 술, 담배 등을 배달하도록 지시한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","similarNm":"플로어맨","dJobECd":"4209","dJobECdNm":"[4209]기타 스포츠 및 여가서비스 종사원","dJobJCd":"4329","dJobJCdNm":"[4329]기타 여가 서비스 종사원","dJobICd":"R912","dJobICdNm":"[R912]유원지 및 기타 오락관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004598:1', '{"dJobCd":"K000004598","dJobCdSeq":"1","dJobNm":"피트보스","workSum":"카지노 영업장의 한 구역(피트)을 총괄하고 게임진행을 관장한다.","doWork":"담당 피트(14개 이하의 게임테이블로 구성된 2~3개의 플로어) 내에서 이루어지는 모든 행위를 감독·지휘한다. 영업장 상황을 점검하고 발생한 모든 업무를 쉬프트매니저에게 보고한다. 담당 피트의 영업활동을 계획한다. 플로어퍼슨, 카지노딜러를 교육하고 업무를 평가한다. 고객 인원수, 시간에 따른 게임테이블의 운영 여부를 결정하여 보고하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"4209","dJobECdNm":"[4209]기타 스포츠 및 여가서비스 종사원","dJobJCd":"4329","dJobJCdNm":"[4329]기타 여가 서비스 종사원","dJobICd":"R912","dJobICdNm":"[R912]유원지 및 기타 오락관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005387:1', '{"dJobCd":"K000005387","dJobCdSeq":"1","dJobNm":"병원조리사","workSum":"병원에서 환자에게 제공할 음식을 조리한다.","doWork":"영양사가 작성한 일일식단표와 조리지시를 확인한다. 조리할 재료를 다듬고 씻어 준비한다. 식료품을 일반환자식과 치료식으로 구분한다. 주방기구 및 설비를 이용하여 밥, 국, 반찬을 조리한다. 조리에 사용된 기구 및 식기류를 세척하거나 작업장소를 정리한다. 조리에 사용할 재료 등의 재고를 확인하고 주문한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"대기환경미흡|위험내재|고온|다습|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"병원요리사","certLic":"한식조리산업기사, 한식조리기능사, 양식조리산업기사, 양식조리기능사,  일식조리산업기사, 일식조리기능사, 중식조리산업기사, 중식조리기능사, 복어조리산업기사, 복어조리기능사, 조리장","dJobECd":"5312","dJobECdNm":"[5312]한식 조리사","dJobJCd":"4411","dJobJCdNm":"[4411]한식 조리사","dJobICd":"I561","dJobICdNm":"[I561]음식점업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005905:1', '{"dJobCd":"K000005905","dJobCdSeq":"1","dJobNm":"사업체식당조리사","workSum":"사업체 구내 식당에서 근로자들을 위해 한식, 일식, 중식 등의 음식을 조리한다.","doWork":"주문서나 식단계획표에 따라 재료를 주문한다. 식료품의 상태를 검수하고 관리한다. 요리기기를 점검하고 이상 유무를 확인한다. 식단과 주문량에 따라 재료를 선택하여 다듬고 세척한다. 각종 양념·조리료 등을 준비한다. 오븐·증기솥·토스트·전자레인지·믹서 등 각종 요리기구를 사용하여 적당한 조리법에 따라 한식·일식·중식·양식 등을 요리한다. 식기·요리기구·장내를 청결히 관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"대기환경미흡|위험내재|고온|다습|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"구내식당조리사, 단체급식조리사","connectJob":"한식조리사","certLic":"한식조리산업기사, 양식조리산업기사, 일식조리산업기사, 중식조리산업기사, 복어조리산업기사, 한식조리기능사, 양식조리기능사, 일식조리기능사, 중식조리기능사, 복어조리기능사, 조리장","dJobECd":"5312","dJobECdNm":"[5312]한식 조리사","dJobJCd":"4411","dJobJCdNm":"[4411]한식 조리사","dJobICd":"I561","dJobICdNm":"[I561]음식점업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007538:1', '{"dJobCd":"K000007538","dJobCdSeq":"1","dJobNm":"한식조리사","workSum":"한식 식당에서 국, 찌개, 국물요리, 찜, 조림, 무침 등의 다양한 한국전통음식을 조리한다.","doWork":"주문서나 식단계획표에 따라 재료를 주문한다. 재료의 상태를 검수하고 관리한다. 요리기기를 조작·점검하고 이상 유무를 확인한다. 식단과 주문량에 따라 재료를 선택하여 다듬고 세척한다. 요리기구(솥, 들통, 국자, 화덕, 냄비, 용기, 온도계, 스푼, 체, 주걱, 도마, 칼, 채반, 구절판, 프라이 팬, 숯, 가스기구, 석쇠 등)를 사용하여 각종 한식요리(육수 및 국물, 전채 요리, 전·튀김·구이·볶음 요리, 찜 및 조림 요리, 탕·전골 및 찌개 요리, 면 요리, 밥·죽 요리, 김치 및 반찬, 한과류 등)를 조리한다. 조리가 완료되면 조리법, 재료의 특성에 따라 적당한 그릇을 선택하여 담아낸다. 조리된 음식의 맛, 영양상태 등을 파악하고 점검 및 개선한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"대기환경미흡|위험내재|고온|다습|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"수동조작","connectJob":"선박조리사(선박조리부원)","certLic":"조리기능장, 한식조리산업기사, 한식조리기능사, 복어조리산업기사, 복어조리기능사","dJobECd":"5312","dJobECdNm":"[5312]한식 조리사","dJobJCd":"4411","dJobJCdNm":"[4411]한식 조리사","dJobICd":"I561","dJobICdNm":"[I561]음식점업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007450:1', '{"dJobCd":"K000007450","dJobCdSeq":"1","dJobNm":"중식조리사","workSum":"중국식 식당에서 각종 탕, 튀김, 면류 등의 중식을 조리한다.","doWork":"주문서나 식단계획표에 따라 재료를 주문한다. 재료의 상태를 검수하고 관리한다. 요리기기를 조작·점검하고 이상 유무를 확인한다. 식단과 주문량에 따라 재료를 선택하여 다듬고 세척한다. 요리기구(솥, 들통, 국자, 화덕, 냄비, 용기, 온도계, 스푼, 체, 주걱, 도마, 칼, 채반, 구절판, 프라잉 팬, 숯, 가스기구, 석쇠 등)를 사용하여 각종 중식요리(소스·육수, 냉채, 튀김·볶음·구이 요리, 스프 및 탕 요리, 찜 및 조림 요리, 딤섬 및 만두 요리, 면 요리, 밥·죽 요리, 절임 및 부식 등)를 조리한다. 조리가 완료되면 조리법, 재료의 특성에 따라 적당한 그릇을 선택하여 담아낸다. 조리된 음식의 맛, 영양상태 등을 파악하고 점검 및 개선한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"대기환경미흡|위험내재|고온|다습|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"수동조작","certLic":"조리기능장, 중식조리산업기사, 중식조리기능사","dJobECd":"5313","dJobECdNm":"[5313]중식 조리사","dJobJCd":"4412","dJobJCdNm":"[4412]중식 조리사","dJobICd":"I561","dJobICdNm":"[I561]음식점업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007555:1', '{"dJobCd":"K000007555","dJobCdSeq":"1","dJobNm":"양식조리사","workSum":"양식 식당에서 각종 육류, 면류 등의 서양식 요리를 조리한다.","doWork":"주문서나 식단계획표에 따라 재료를 주문한다. 재료의 상태를 검수하고 관리한다. 요리기기를 조작·점검하고 이상 유무를 확인한다. 식단과 주문량에 따라 재료를 선택하여 다듬고 세척한다. 요리기구(솥, 들통, 국자, 화덕, 냄비, 용기, 온도계, 스푼, 체, 소창, 콜런터, 분쇄기, 자루냄비, 짤주머니, 프라이 팬, 나무요지, 거품기, 믹싱볼, 주걱, 도마, 칼, 채반, 브로일러, 오븐, 레인지, 살라만더, 튀김기, 소스냄비, 로스팅 팬, 시트 팬, 미트 포크, 자동타이머 등)를 사용하여 각종 양식요리(스톡·소스, 수프, 애피타이저, 샐러드, 생선류 요리, 육류 요리, 가금류 요리, 사이드 디쉬, 샌드위치, 파스타, 계란 요리 등)를 조리한다. 조리가 완료되면 조리법, 재료의 특성에 따라 적당한 그릇을 선택하여 담아낸다. 조리된 음식의 맛, 영양상태 등을 파악하고 점검 및 개선한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"대기환경미흡|위험내재|고온|다습|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"조리기능장, 양식조리산업기사, 양식조리기능사","dJobECd":"5314","dJobECdNm":"[5314]양식 조리사","dJobJCd":"4413","dJobJCdNm":"[4413]양식 조리사","dJobICd":"I561","dJobICdNm":"[I561]음식점업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007579:1', '{"dJobCd":"K000007579","dJobCdSeq":"1","dJobNm":"일식조리사","workSum":"일식 식당에서 각종 육류, 생선류, 면류 등의 일본식 요리를 조리한다.","doWork":"주문서나 식단계획표에 따라 재료를 주문한다. 재료의 상태를 검수하고 관리한다. 요리기기를 조작·점검하고 이상 유무를 확인한다. 식단과 주문량에 따라 재료를 선택하여 다듬고 세척한다. 요리기구(찜통, 냄비, 국자, 젓가락, 꼬치, 굳힘틀, 도마, 칼, 계량컵, 석쇠, 프라이팬, 호일, 아미-튀김가루 건져내는 기구, 가제수건, 김발, 초밥통, 누름상자, 소바 틀, 데바-생선을 다듬거나 포를 뜰 때 사용하는 칼, 야나기바-끝이 뾰족한 생선회칼 등)를 사용하여 각종 일식요리(다시 요리, 전채 요리, 사시미 요리, 냄비·찜·조림 요리, 구이 요리, 튀김 요리, 초회 요리, 밥, 돈부리, 오차즈케, 스시 요리, 면 요리, 절임 요리, 복 요리(복어))등을 조리한다. 조리가 완료되면 조리법, 재료의 특성에 따라 적당한 그릇을 선택하여 담아낸다. 조리된 음식의 맛, 영양상태 등을 파악하고 점검 및 개선한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"대기환경미흡|위험내재|고온|다습|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"조리기능장, 일식조리산업기사, 일식조리기능사","dJobECd":"5315","dJobECdNm":"[5315]일식 조리사","dJobJCd":"4414","dJobJCdNm":"[4414]일식 조리사","dJobICd":"I561","dJobICdNm":"[I561]음식점업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004956:1', '{"dJobCd":"K000004956","dJobCdSeq":"1","dJobNm":"바리스타","workSum":"고객이 주문한 에스프레소, 카푸치노, 아메리카노 등의 커피를 커피머신을 조작하거나 사이펀, 드리퍼 등 기기를 사용하여 고객의 기호에 맞게 조리하여 제공한다.","doWork":"조리할 재료를 준비하고 커피머신 등의 작동상태를 확인한다. 고객의 주문을 확인하고 원두를 갈고 커피머신을 작동하여 커피를 추출한다. 커피에 따라 우유, 크림 등을 넣고 하트, 꽃, 동물 등 다양한 그림을 그려낸다. 사이펀이나 드리퍼 등을 사용하여 원두 미세정도(분쇄도), 물의 온도, 투입량 등을 고려하여 수제 커피를 우려낸다. 조리한 커피를 고객에게 제공한다. 커피 원료인 원두의 재고를 파악하여 주문하거나 관리한다. 커피추출기구 등 커피관련 기기나 장비를 유지관리한다. 커피의 생두를 볶거나 원두의 상태나 등급을 평가하고 감정하기도 한다. 교육훈련생을 대상으로 교육하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"고온|","workFunc1":"수집","workFunc2":"서비스제공","workFunc3":"수동조작","similarNm":"커피전문가, 커피마스터","connectJob":"커피로스터, 커피원두감별사","dJobECd":"5317","dJobECdNm":"[5317]음료 조리사","dJobJCd":"4415","dJobJCdNm":"[4415]음료 조리사","dJobICd":"I562","dJobICdNm":"[I562]주점 및 비알코올 음료점업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004287:1', '{"dJobCd":"K000004287","dJobCdSeq":"1","dJobNm":"차조리사","workSum":"커피, 녹차, 전통차 등 각종 차를 고객의 기호에 맞게 조리하여 제공한다.","doWork":"고객의 입맛에 맞는 차를 서비스하기 위하여 각종 차 재료를 손질한다. 고객으로부터 주문받은 차를 조리방법에 맞게 기계로 추출하거나 수동으로 물에 우려낸다. 조리한 차를 고객에게 제공한다. 조리와 관련된 각종 기계나 기구 등을 유지하고 관리한다. 조리한 장소를 정리하고 사업장의 청결을 유지한다. 차의 재고를 파악하고 주문하거나 차의 특성에 맞게 관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"고온|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"수동조작","connectJob":"커피를 전문으로 조리하는 경우 바리스타","dJobECd":"5317","dJobECdNm":"[5317]음료 조리사","dJobJCd":"4415","dJobJCdNm":"[4415]음료 조리사","dJobICd":"I562","dJobICdNm":"[I562]주점 및 비알코올 음료점업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002590:1', '{"dJobCd":"K000002590","dJobCdSeq":"1","dJobNm":"곤충식품조리사","workSum":"곤충을 이용한 식품의 조리방법을 연구하고 조리한다.","doWork":"주문을 받아 곤충이 사용된 요리를 조리한다. 맛과 영양을 고려하여 곤충의 물성 영양분 등의 특성에 맞는 조리법을 연구한다. 섭취가 용이하고 풍미와 시각적으로 좋은 색과 모양을 연구한다. 그 외 일반적인 조리사의 직무를 수행한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"곤충요리사","dJobECd":"5319","dJobECdNm":"[5319]기타 조리사","dJobJCd":"4419","dJobJCdNm":"[4419]기타 조리사","dJobICd":"I561","dJobICdNm":"[I561]음식점업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005219:1', '{"dJobCd":"K000005219","dJobCdSeq":"1","dJobNm":"분식점조리사","workSum":"분식점에서 음식 재료를 준비하고 고객이 주문한 음식을 조리한다.","doWork":"조리에 필요한 재료의 목록을 작성하고 품질을 고려하여 구입한다. 영업이 시작되기 전에 재료를 다듬거나 조합하여 조리를 준비한다. 남은 재료를 냉장고 등에 정리·보관한다. 매장에서 주문받은 음식을 조리방법에 맞게 조리한다. 사용한 식기류 등을 세척하고 정리한다. 주방의 위생상태와 조리도구, 식기류 등의 청결상태를 수시로 점검한다. 음식물과 재료의 신선도를 확인하여 변질을 방지한다. 새로운 종류의 음식을 연구하여 개발한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|고온|다습|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","dJobECd":"5319","dJobECdNm":"[5319]기타 조리사","dJobJCd":"4419","dJobJCdNm":"[4419]기타 조리사","dJobICd":"I561","dJobICdNm":"[I561]음식점업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002387:1', '{"dJobCd":"K000002387","dJobCdSeq":"1","dJobNm":"바텐더","workSum":"고객의 주문에 따라 각종 알코올음료 및 비알코올음료를 제조하여 제공하는 일을 한다.","doWork":"고객의 취향에 맞는 칵테일을 서비스하기 위하여 알코올의 농도, 맛, 향이 각기 다른 알코올성 음료와 청량음료, 기타 부재료를 적당한 비율로 혼합하여 맛을 낸다. 생과일, 올리브 등을 잔 위에 걸쳐 시각적인 장식효과를 낸다. 셰이커를 흔드는 등 칵테일 제조방법을 연출하여 볼거리를 제공한다. 사용한 도구와 유리잔 등을 직접 세척하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"관련없음","similarNm":"조주사","certLic":"조주기능사","dJobECd":"5316","dJobECdNm":"[5316]바텐더","dJobJCd":"4421","dJobJCdNm":"[4421]바텐더","dJobICd":"I562","dJobICdNm":"[I562]주점 및 비알코올 음료점업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003209:1', '{"dJobCd":"K000003209","dJobCdSeq":"1","dJobNm":"꽃차소믈리에","workSum":"산야초의 꽃, 열매, 뿌리 등을 제다, 법제 기법을 통해 꽃차로 만들고 음다방법을 알려주며 개인 성향에 맞는 꽃차를 제안한다.","doWork":"산과 들에 있는 산야초의 꽃, 뿌리, 열매 등 꽃차 원료를 세척하고 손질한다. 꽃차 원료의 성질에 따라 제다방식을 선택하여 고온 또는 저온에서 여러 번 닦고 식히는 과정 또는 김을 쐬어주는 증제 과정을 진행한다. 미량의 독성이 있는 원료의 경우 독성을 없애기 위해 삶거나 감초물 등에 담갔다 말리는 등의 법제 과정을 거치기도 한다. 최종 완성되기 전 꽃차의 남은 수분을 체크하여 수분을 제거하고 숙성시킨다. 꽃차에 대한 설명과 마시는 방법을 알려준다. 계절이나 개인 성향에 따라 어울리는 꽃차를 제안하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","dJobECd":"5329","dJobECdNm":"[5329]기타 음식 서비스 종사원","dJobJCd":"4422","dJobJCdNm":"[4422]웨이터","dJobICd":"I562","dJobICdNm":"[I562]주점 및 비알코올 음료점업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002005:1', '{"dJobCd":"K000002005","dJobCdSeq":"1","dJobNm":"분식점시중원","workSum":"분식점에서 고객을 맞이하고 주문을 받은 후 음식을 제공한다.","doWork":"고객을 맞이하고 고객에게 메뉴판을 제공한다. 고객에게 주문을 받은 후 주방과 카운터에 주문사항을 알린다. 고객에게 음료와 음식을 전달하고 고객의 요구사항이 있을 시 해결하거나 주방과 관리자에게 알린다. 고객이 식사를 마친 후에 식기류를 치우고 식탁과 좌석을 정리한다. 분식점 내부를 청소하고 쓰레기를 치운다. 전화 받은 주문사항을 주방에 알린다. 점포에 따라 분식점조리사를 보조하기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"관련없음","workFunc2":"서비스제공","workFunc3":"관련없음","dJobECd":"5322","dJobECdNm":"[5322]홀서빙원","dJobJCd":"4422","dJobJCdNm":"[4422]웨이터","dJobICd":"I561","dJobICdNm":"[I561]음식점업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005731:1', '{"dJobCd":"K000005731","dJobCdSeq":"1","dJobNm":"와인감별사","workSum":"레스토랑이나 바에서 와인의 구입과 보관을 책임지고, 고객에게 적합한 와인을 추천하여 와인 선택에 도움을 준다.","doWork":"포도의 품종, 숙성방법, 원산지, 수확연도의 일조량 등을 고려하여 가격·품질에 맞게 선택하여 와인 구입을 조언한다. 메뉴판에 나와 있는 포도주 각각의 특징에 대하여 손님에게 정보를 제공한다. 고객이 주문한 음식과의 조화, 고객의 기호, 모임·파티의 성격 등을 고려하여 고객에게 적합한 와인을 추천한다. 고객이 선택한 와인의 마개를 개방하여 고객에게 시음을 권한 후 잔에 따라준다. 와인의 저장과 재고를 관리하고 와인 메뉴판을 작성하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"분석","workFunc2":"서비스제공","workFunc3":"단순작업","similarNm":"소믈리에(Sommelier), 와인스튜어더, 와인웨이터","dJobECd":"5329","dJobECdNm":"[5329]기타 음식 서비스 종사원","dJobJCd":"4422","dJobJCdNm":"[4422]웨이터","dJobICd":"I562","dJobICdNm":"[I562]주점 및 비알코올 음료점업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003407:1', '{"dJobCd":"K000003407","dJobCdSeq":"1","dJobNm":"음식점접객원","workSum":"음식점에서 고객에게 음식 및 서비스를 제공한다.","doWork":"업무시간 전에 용모 및 복장을 단정히 하고 근무에 필요한 준비를 한다. 음식점에 들어온 고객에게 인사를 하고 자리를 안내한다. 고객에게 메뉴판을 제시하고 질문에 답하며 음식과 음료를 추천한다. 음·식료의 주문을 받아 적거나 기억하여 주방에 전달한다. 주방으로부터 음·식료가 나오면 고객에게 제공한다. 고객에게 필요한 사항이 없는지 계속 점검하고 요구하는 서비스를 제공한다. 고객의 식사가 끝나면 식기류를 치운다. 식사가 끝나면 계산서를 제시하고 내용을 확인하게 도와준다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"단순작업","similarNm":"홀서빙원, 웨이터, 웨이트리스","dJobECd":"5322","dJobECdNm":"[5322]홀서빙원","dJobJCd":"4422","dJobJCdNm":"[4422]웨이터","dJobICd":"I561","dJobICdNm":"[I561]음식점업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001949:1', '{"dJobCd":"K000001949","dJobCdSeq":"1","dJobNm":"제과점종업원","workSum":"제과점에서 빵과 음료를 판매하고, 매장 정리를 한다.","doWork":"고객으로부터 주문을 받아 주문사항을 카운터에 알린다. 고객이 주문한 빵과 음료수를 제공한다. 사용한 컵, 포크 등을 치우고, 테이블과 좌석을 정리·정돈한다. 제과와 음료 등을 진열장에 보충하고 부족한 상품을 기재해 제과점 관리자에게 알린다. 아이스크림, 푸딩, 음료 등을 적정온도로 유지·관리하여 상품의 변질을 방지한다. 음료수 상자와 빵 재료 등을 정리·정돈한다. 상품이 진열된 진열장을 주기적으로 닦는 등 제과점을 청소한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"시범후 30일 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"수집","workFunc2":"서비스제공","workFunc3":"관련없음","dJobECd":"5322","dJobECdNm":"[5322]홀서빙원","dJobJCd":"4422","dJobJCdNm":"[4422]웨이터","dJobICd":"I561","dJobICdNm":"[I561]음식점업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002806:1', '{"dJobCd":"K000002806","dJobCdSeq":"1","dJobNm":"찻집서비스원","workSum":"찻집을 방문한 고객에게 차와 음료 등을 공급한다.","doWork":"방문한 고객에게 좌석을 안내한다. 고객에게 메뉴판을 제시하고 차 주문을 받는다. 주문 접수한 내용을 확인하여 카운터에 표시하고 조리실에 알린다. 고객이 주문한 차가 주방에서 나오면 해당 고객에게 제공한다. 고객이 나간 후 테이블과 좌석을 정리·정돈한다. 사용한 찻잔, 집기 등을 조리실로 옮기고 테이블을 닦는다. 찻집 실내외 전반을 정리·정돈한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"시범후 30일 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"관련없음","workFunc2":"서비스제공","workFunc3":"관련없음","similarNm":"찻집시중원","connectJob":"카페서비스원","dJobECd":"5322","dJobECdNm":"[5322]홀서빙원","dJobJCd":"4422","dJobJCdNm":"[4422]웨이터","dJobICd":"I562","dJobICdNm":"[I562]주점 및 비알코올 음료점업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007464:1', '{"dJobCd":"K000007464","dJobCdSeq":"1","dJobNm":"자동차영업원","workSum":"고객에게 차량에 대한 전문지식과 사양 등 다양한 정보를 제공하고 자동차를 판매한다.","doWork":"고객에게 카탈로그를 제시하면서 차량의 종류, 제원, 성능 등을 설명한다. 소비자가 원하는 차종과 종류를 파악한다. 가격, 연비, 옵션사항, 차량의 외관, 내장, 안전성, 컬러에 관한 사항을 설명하여 차량의 구매를 돕는다. 고객과 판매계약을 체결한다. 소비자에게 차량을 인도하기까지의 절차를 대행한다. 판매한 차량의 보증 업무를 제공한다. 신차정보 등의 정보 제공을 통해 고객을 관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"설득","workFunc3":"관련없음","similarNm":"자동차영업원, 자동차영업사원, 신차영업원, 신차판매원","connectJob":"트럭영업원, 버스영업원, 승용차영업원, 수입차영업원, 카매니저, 카마케터, 자동차딜러, 수입자동차딜러","dJobECd":"6123","dJobECdNm":"[6123]자동차 영업원","dJobJCd":"5101","dJobJCdNm":"[5101]자동차 영업원","dJobICd":"G451","dJobICdNm":"[G451]자동차 판매업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006000:1', '{"dJobCd":"K000006000","dJobCdSeq":"1","dJobNm":"중고자동차영업원","workSum":"개인 고객 또는 법인으로부터 중고차를 매입하고 재판매를 위한 상품화 과정 및 마케팅 및 영업활동을 통해 중고차를 판매한다.","doWork":"중고차를 매입할 채널을 운영하고 잠재고객을 관리하는 등 영업활동을 한다. 고객이 차량매입을 신청하면 찾아가서 가격산정을 위한 진단을 한다. 보험이력, 사고유무, 침수 및 주행거리 조작 여부를 비롯해 내외관에서 확인되는 주요 수리 여부를 확인하고 매입가격을 제시한다. 중고차 매입에 따른 계약서 작성 등 매입 절차를 수행하고 차량산정 금액을 판매자에게 지급한다. 매입된 중고차량을 진단하고 차량 상태를 점검하여 고객에게 재판매를 위한 상품화 과정과 차량의 상세 진단을 거쳐 온라인사이트에 차량에 대한 상세 사진과 설명내용을 작성하여 올린다. 중고차의 판매를 위해 전화 또는 고객과 대면 등을 통해 영업활동을 한다. 타국과의 중고차 거래를 위해 통관작업 및 선적 관련 업무를 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"웅크림|손사용|언어력|","workFunc1":"수집","workFunc2":"설득","workFunc3":"관련없음","similarNm":"중고차영업원, 중고차판매원, 중고차딜러","connectJob":"중고자동차매입원, 차량평가사, 자동차진단평가사, 중고자동차해외선적원, 폐자동차영업원","certLic":"자동차정비기능사, 자동차정비산업기사, 자동차진단평가사","dJobECd":"6123","dJobECdNm":"[6123]자동차 영업원","dJobJCd":"5101","dJobJCdNm":"[5101]자동차 영업원","dJobICd":"G451","dJobICdNm":"[G451]자동차 판매업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001290:1', '{"dJobCd":"K000001290","dJobCdSeq":"1","dJobNm":"건축자재영업원","workSum":"각종 건축자재나 인테리어 재료를 판매하기 위한 영업을 한다.","doWork":"건축현장의 현장소장, 건축회사의 자재 담당자, 건축설계사 사무소 등 건축자재(합판, 타일, 창호, 양변기, 황토벽돌, 조명, 유리, 벽난로 등)의 소비자들을 방문하거나, 전화, 카탈로그 등을 배포하여 제품을 소개하고 판매를 촉진하는 활동을 한다. 건축자재 주문을 접수하거나 견적의뢰에 따라 견적서를 작성하여 제출한다. 공사발주 관련 영업을 한다. 제조사에 물품을 주문한다. 납품되는 물품에 대하여 수량을 검수하고 치수, 겉모양 등 품질의 이상 여부를 검사한다. 물품의 특성과 용도, 가격을 숙지한다. 판매장부를 작성하고 판매량과 재고량을 파악한다. 제조사에 소속되어 영업하는 경우 소매업체와 수량과 대금납부시기 등을 고려해 물품가격과 결제조건 등을 협의한다. 소매업체(대리점)의 주문에 따라 건축현장 등 지정하는 장소에 제품을 납품하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"설득","workFunc3":"관련없음","connectJob":"건설수주영업원, 레미콘영업원, 건설관공서영업원, 건설자재영업원, 가설재영업원, 내외장재영업원, 마감재영업원, 목재영업원, 방화재영업원, 창호재영업원, 방수재영업원, 인테리어내장재영업원, 욕실자재영업원, 배관자재영업원, 콘크리트블럭영업원, 타일영업원, 조립식칸막이영업원, 전기자재영업원, PVC영업원, 토목자재영업원, 페인트영업원, 샤시영업원","dJobECd":"6124","dJobECdNm":"[6124]제품·광고 영업원","dJobJCd":"5102","dJobJCdNm":"[5102]제품 및 광고 영업원","dJobICd":"G466","dJobICdNm":"[G466]건축자재, 철물 및 난방장치 도매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006828:1', '{"dJobCd":"K000006828","dJobCdSeq":"1","dJobNm":"광고매체구매원","workSum":"각종 광고를 수용자에게 효율적으로 전달하기 위하여 각종 매체(방송, 신문, 잡지, 옥외광고탑, 전광판 등)의 광고지면, 공간, 시간대 등을 확보하기 위한 매체구매(Media Buying) 활동을 한다.","doWork":"효율적인 활동을 위해 국내외의 매체정보를 수집·분석한다. 원하는 매체의 구독률 및 열독율을 점검한다. 신문이나 잡지의 경우, 발행부수(유가지, 무가지 등)를 조사하고, 구독자의 특성을 파악한다. 옥외광고탑이나 전광판 등의 경우 일일통행인구를 조사분석하고 통행인구의 특성을 파악한다. 방송매체의 시청률 및 청취율을 점검하고 광고매체기획원(Media Planner)이 종합 분석하여 제작한 보고서를 참조하여, 경쟁사의 방송광고전략 등을 검토한 뒤 대응전략의 일환으로 적절한 시간대의 방송광고시간 구매 계약을 체결한다. 업무의 효율성을 높이기 위해 각 방송사, 방송광고공사를 방문하여 정보를 획득하고 보고하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"협의","workFunc3":"관련없음","connectJob":"분야에 따라 면광고매체구매원, 방송광고매체구매원","dJobECd":"6124","dJobECdNm":"[6124]제품·광고 영업원","dJobJCd":"5102","dJobJCdNm":"[5102]제품 및 광고 영업원","dJobICd":"M713","dJobICdNm":"[M713]광고업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006137:1', '{"dJobCd":"K000006137","dJobCdSeq":"1","dJobNm":"광고영업사무원","workSum":"신문·잡지 등의 출판물의 지면에 수록될 광고의 판매를 위한 영업을 한다.","doWork":"광고계획이나 방침에 따라 구체적인 영업전략을 수립한다. 영업전략에 따라 판매할 광고에 대한 유망고객 및 가능성 있는 광고주에 대한 정보를 수집한다. 광고 수주에 따른 실적 및 경향 등에 대한 과거와 현재의 광고수요 동향을 비교·분석한다. 분석한 자료를 근거로 구 광고주 또는 유망고객의 명부를 작성한다. 광고주의 광고집행 담당 부서장 또는 담당 직원을 만나서 각종 광고매체의 장단점 등에 대하여 설명하여 광고를 수주한다. 광고주가 원하는 색상·크기·광고 위치 등 각종 사항에 대한 내용을 광고의뢰서에 작성한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"설득","workFunc3":"관련없음","similarNm":"광고수주원, 광고판매원","connectJob":"판매하는 광고매체의 종류에 따라 옥외광고영업사무원, 인터넷광고영업사무원","dJobECd":"6124","dJobECdNm":"[6124]제품·광고 영업원","dJobJCd":"5102","dJobJCdNm":"[5102]제품 및 광고 영업원","dJobICd":"J581","dJobICdNm":"[J581]서적, 잡지 및 기타 인쇄물 출판업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003640:1', '{"dJobCd":"K000003640","dJobCdSeq":"1","dJobNm":"광고영업원","workSum":"거래처를 방문하여 광고 의뢰에 대해 상담하고 광고용역계약을 추진하며, 새로운 거래처를 발굴하는 일을 한다.","doWork":"회사의 계획이나 방침에 따라 영업전략을 수립한다. 거래처를 방문하여 새로운 광고콘셉트, 광고제작 완료 기간, 소요비용 등 용역에 대해 고객과 협의한다. 협의 내용에 대해 부서장에게 보고하고 광고제작 관련 담당자 등과 기간 및 일정 등을 협의한다. 광고용역이 완료되는 시점까지 고객이 요구하는 사항을 확인하고 광고제작진에게 요구사항을 전달하여 협의한다. 새로운 거래처를 개척하기 위하여 고객에 대한 정보를 수집한다. 광고 동향에 대해 조사하거나 교육을 받는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"언어력|","workFunc1":"수집","workFunc2":"설득","workFunc3":"관련없음","connectJob":"전화번호부광고영업원, 전단광고영업원, 신문광고영업원, 전단물영업원, 광고대행영업원, 인터넷콘텐츠광고영업원, 디지털컨텐츠영업원","dJobECd":"6124","dJobECdNm":"[6124]제품·광고 영업원","dJobJCd":"5102","dJobJCdNm":"[5102]제품 및 광고 영업원","dJobICd":"M713","dJobICdNm":"[M713]광고업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005158:1', '{"dJobCd":"K000005158","dJobCdSeq":"1","dJobNm":"무인경비영업원","workSum":"무인(기계)경비 서비스를 고객에서 설명하고 견적 및 계약유치 업무를 하고, 고객관리를 한다.","doWork":"담당 구역 내의 가입예상 고객을 파악하고 방문하여 무인보안시스템 및 계약의 내용과 보장범위를 설명한다. 고객의 업무 및 관리체계를 파악하고 경비대상물에 대한 위험도에 따라 적정한 보안기기의 종류와 서비스 및 설치조건을 판단하여 고객에서 권유한다. 경비장소의 약식평면도와 시스템구성도를 작성한다. 선정된 보안기기의 종류와 보안서비스에 따른 용역료 산출조견표를 참고하여 견적가를 산출하고 산출명세서를 작성한다. 고객과 협의하여 월정계약료 및 설치공사비를 확정·계약한다. 고객과 공사일정을 협의하여 보안시스템 공사의뢰를 한다. 공사가 완료되면 고객에게 보안기기의 사용법을 설명하고 출입문 키(Key)를 인수받아 경비개시의 일정을 확정한다. 보안경비의 진행 중에 사용자의 변동에 의한 승계합의서나 납입조건 변경을 위한 합의서를 작성하기도 한다. 월정계약료를 조정하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"설득","workFunc3":"관련없음","connectJob":"보안 분야에 따라 시설경비영업원, 특수경비영업원, 호송경비영업원, 신변보호경호영업원, 보안용역대리인, 보안용역기획원, 보안용역계약관리인, 기계경비영업원","dJobECd":"6124","dJobECdNm":"[6124]제품·광고 영업원","dJobJCd":"5102","dJobJCdNm":"[5102]제품 및 광고 영업원","dJobICd":"N753","dJobICdNm":"[N753]경비, 경호 및 탐정업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006211:1', '{"dJobCd":"K000006211","dJobCdSeq":"1","dJobNm":"산업폐수영업사무원","workSum":"병원, 생산업체 등에서 발생하는 산업폐수를 수거·정화하기 위한 서비스를 판매하기 위해 고객의 업체를 방문하여 영업활동을 한다.","doWork":"병원이나 생산업체 등을 방문하여 산업폐수에 대한 처리 대행 업무를 홍보한다. 폐기물 처리 업무를 의뢰받을 수 있도록 산업폐수 방출 사업체에 대하여 산업폐수 처리 방법에 대한 회사의 방침을 설명한다. 산업폐수 처리 업무 대행에 따른 비용을 이해시키고 계약을 체결한다. 산업폐수 방출 업체와 산업폐수 처리에 관한 계약이 이루어지면 폐수수거원에게 지시하여 산업폐수를 수거해 오도록 한다. 산업폐수 처리 대행에 따른 수금 업무도 수행한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"설득","workFunc3":"관련없음","dJobECd":"6124","dJobECdNm":"[6124]제품·광고 영업원","dJobJCd":"5102","dJobJCdNm":"[5102]제품 및 광고 영업원","dJobICd":"E370","dJobICdNm":"[E370]하수, 폐수 및 분뇨 처리업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004738:1', '{"dJobCd":"K000004738","dJobCdSeq":"1","dJobNm":"상조영업원","workSum":"상조회사에 소속되어 회원모집 활동을 한다.","doWork":"상조회사(장의업)의 모집인 교육프로그램에 참가하여 장례의전, 회원모집 전략, 가입조건, 제공하는 서비스, 자사 서비스의 특장점, 영업에 따른 수당 및 승급정책, 적법한 모집활동, 불법피해사례 등에 대한 교육을 받는다. 주변인, 친인척, 동료, 동창, 모임, 조직, 지역, 인터넷 등을 활용한 영업전략을 수립하고 추진한다. 고객을 대상으로 상조회 가입을 권유한다. 회원가입신청서를 작성하여 상조회사에 송부한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"설득","workFunc3":"관련없음","dJobECd":"6124","dJobECdNm":"[6124]제품·광고 영업원","dJobJCd":"5102","dJobJCdNm":"[5102]제품 및 광고 영업원","dJobICd":"S969","dJobICdNm":"[S969]그 외 기타 개인 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005283:1', '{"dJobCd":"K000005283","dJobCdSeq":"1","dJobNm":"식품영업원","workSum":"주류, 곡류, 채소류, 과일류, 육류 등 식품에 관련된 영업활동을 하고 거래처 확보, 납품업무를 수행한다.","doWork":"취급하는 식품의 종류, 명칭, 가격, 원산지, 공급량, 유통기한, 물류방법(냉장, 상온, 포장 등), 취급주의사항, 특장점 등을 파악한다. 식품류 소비자 및 거래처의 요구사항, 자사 품목의 시장점유율, 경쟁업체의 동향, 품목의 동향 등 시장상황에 대한 정보를 파악하고 영업활동과 연계시킨다. 영업전략 수립에 필요한 시장의 정보를 수집하고 정리하여 보고하기도 한다. 신규 거래처를 개발한다. 거래처 담당자와 주문수량, 배달일정, 반품처리, 결제조건 등을 협의한다. 판촉, 홍보, 행사 등 영업활동을 수행한다. 주문을 처리하고 납품을 한다. 주문량과 매출액 등을 기록한다. 반품이나 하자 등 판매 후 발생하는 문제를 처리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"언어력|","workFunc1":"수집","workFunc2":"설득","workFunc3":"관련없음","similarNm":"식품영업사원","connectJob":"농수산물영업원, 냉동수산물영업원, 유통업체식품영업원, 건강기능식품영업원, 빙과영업원, 과자영업원, 음료영업원, 식자재영업원, 아이스크림루트영업원, 육류영업원, 제과영업원, 급식자재영업원, 주류영업원, 마트식품영업원, 콩나물영업원, 두부영업원, 주스영업원, 담배영업원","dJobECd":"6124","dJobECdNm":"[6124]제품·광고 영업원","dJobJCd":"5102","dJobJCdNm":"[5102]제품 및 광고 영업원","dJobICd":"G463","dJobICdNm":"[G463]음ㆍ식료품 및 담배 도매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003029:1', '{"dJobCd":"K000003029","dJobCdSeq":"1","dJobNm":"연쇄점모집영업원","workSum":"연쇄점(동일한 메이커 제품을 취급하는 소매상점을 여러 곳에 두고 중앙에서 통제·경영하는 점포 조직, 체인점) 개설을 위한 영업활동을 한다.","doWork":"연쇄점(가맹점)을 확보하기 위한 사업설명 자료를 작성한다. 사업설명회를 개최하고 아이템의 취지, 특장점, 운영현황, 제품 및 서비스, 메뉴, 경쟁력, 개설비용, 예상수익, 입지조건, 운영방안 등을 소개한다. 연쇄점 개설에 따르는 절차를 지원한다. 기존 연쇄점의 운영 실태 조사, 자재 공급, 경영지도 등 운영·관리에 필요한 제반 서비스를 지원한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"설득","workFunc3":"관련없음","similarNm":"프랜차이즈영업원, 가맹점영업원, 대리점모집원, 대리점모집영업원, 체인점모집영업원","dJobECd":"6124","dJobECdNm":"[6124]제품·광고 영업원","dJobJCd":"5102","dJobJCdNm":"[5102]제품 및 광고 영업원","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005989:1', '{"dJobCd":"K000005989","dJobCdSeq":"1","dJobNm":"인쇄영업원","workSum":"고객에게 인쇄 및 출판에 관한 정보를 제공하고 주문을 받는 등 판촉 및 영업활동을 한다.","doWork":"고객을 방문하여 인쇄범위, 인쇄 및 제책가격, 출판물의 종류 등 인쇄·출판에 관한 정보를 제공한다. 고객의 주문을 받고 주문서를 작성한다. 인쇄교정쇄 및 견본을 고객에게 전달하고 인쇄 및 제책에 있어서 요구사항이나 계획의 변경 및 교정본을 받아 관련 부서에 전달한다. 인쇄 및 출판물을 고객에게 전달하거나 운송차량을 안내하여 인수·인계한다. 인쇄대금 및 미수금을 받는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"언어력|","workFunc1":"수집","workFunc2":"설득","workFunc3":"관련없음","similarNm":"인쇄외무원","dJobECd":"6124","dJobECdNm":"[6124]제품·광고 영업원","dJobJCd":"5102","dJobJCdNm":"[5102]제품 및 광고 영업원","dJobICd":"C181","dJobICdNm":"[C181]인쇄 및 인쇄관련 산업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003522:1', '{"dJobCd":"K000003522","dJobCdSeq":"1","dJobNm":"주택수주영업사무원","workSum":"재건축 또는 재개발에 대한 수주 제안이나 사업성이 검토된 개발가능지역에 대한 개발권을 수주하기 위한 업무를 수행한다.","doWork":"주택단지 및 아파트단지를 조성하기 위한 수주 제안이나 개발가능지역 등 사업지의 가치를 평가하기 위한 수주대상사업지를 행정기관·부동산업자·지역설계사무소 등을 통하여 조사한다. 조사자료가 타당성이 있으면 수주대상지역에 대한 재건축 또는 재개발 수주를 하기 위한 계획을 수립한다. 자사가 수주할 경우 대상지의 주민이나 조합원 등이 받는 각종 장점 등을 홍보한다. 수주가 되면 시공할 시공업자를 선정한다. 수주계획에 따라 이주계획, 철거계획, 착공시점, 공사시점, 완공시점 등으로부터 시작해서 분양되어 완료되는 시점까지의 계획을 관리하고 조정한다. 필요시에는 주택분양성사무원에게 의뢰하여 분양성조사를 의뢰하거나 재건축이나 재개발을 위한 타당성을 조사하는 주택분양성 업무를 하기도 한다. 수주계획에 따라 대상지의 용지를 구입하기 위하여 주택용지매입사무원에게 의뢰하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"설득","workFunc3":"관련없음","similarNm":"건축수주영업원","connectJob":"재개발사업권수주영업원, 재건축사업권수주영업원","dJobECd":"6124","dJobECdNm":"[6124]제품·광고 영업원","dJobJCd":"5102","dJobJCdNm":"[5102]제품 및 광고 영업원","dJobICd":"F411","dJobICdNm":"[F411]건물 건설업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005836:1', '{"dJobCd":"K000005836","dJobCdSeq":"1","dJobNm":"호텔판촉지배인","workSum":"공항에 상주하면서 공항이용 고객을 대상으로 호텔 판촉 업무를 수행한다.","doWork":"공항에서 숙소가 정해지지 않은 고객을 대상으로 호텔 숙박비와 시설 등을 설명한다. 귀빈 방문 시 공항에서 영접서비스를 하고 출국 시 배웅한다. 고객에게 호텔 버스와 공항 리무진을 안내하고 고객의 요청에 따라 택시를 잡아주기도 한다. 고객의 공항 수속을 대행해주기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"공항담당호텔직원","certLic":"호텔경영사","dJobECd":"6124","dJobECdNm":"[6124]제품·광고 영업원","dJobJCd":"5102","dJobJCdNm":"[5102]제품 및 광고 영업원","dJobICd":"I551","dJobICdNm":"[I551]일반 및 생활 숙박시설 운영업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004582:1', '{"dJobCd":"K000004582","dJobCdSeq":"1","dJobNm":"회원모집영업원","workSum":"스포츠나 오락시설 등을 이용하려는 회원을 모집하기 위한 영업활동을 한다.","doWork":"모집하려는 회원의 대상, 제공하는 서비스의 종류와 특징, 모집인원, 회원의 등급, 가입기간, 회원의 자격과 권리, 가입비용 등을 종합하여 회원모집계획서를 작성한다. 모집하려는 회원의 잠재고객집단을 개발한다. 온라인마케팅, 광고, 전단지, 제휴마케팅, 이벤트, 프로모션, 기존회원의 소개 등 회원모집 방법을 기획하고 추진한다. 회원가입 문의에 응대하고 회원가입신청서를 작성한다. 회원관리프로그램을 이용하여 회원등록, 가입비, 서비스이용 기간 및 횟수 등을 관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"설득","workFunc3":"관련없음","connectJob":"스포츠회원모집영업원, 레크리에이션회원모집영업원, 놀이시설회원모집영업원, 여행상품영업원, 해외여행영업원","dJobECd":"6124","dJobECdNm":"[6124]제품·광고 영업원","dJobJCd":"5102","dJobJCdNm":"[5102]제품 및 광고 영업원","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006181:1', '{"dJobCd":"K000006181","dJobCdSeq":"1","dJobNm":"보험설계사","workSum":"보험가입 가망고객에게 계약을 맺은 보험회사의 상품들 중 고객에게 적합한 보험상품을 안내하고 계약을 체결한다.","doWork":"보험가입대상자를 대상으로 각 보험상품의 종류와 특성을 설명한다. 개인 및 기업고객의 재정상태, 가족상황, 건강상태, 미래계획 등을 파악하여 적합한 보험상품을 안내·권유한다. 보험가입절차, 보험료 납입방법, 보험금 지급방식과 시기에 대해 설명한다. 고객이 보험가입을 희망하면 보험계약서의 작성요령을 설명하고 작성한 계약서를 검토·보완한다. 계약서 작성이 완료되면 계약서를 영업점에 제출한다. 회사에서 보험청약을 승낙하면 보험증서의 발송상황과 영수증을 확인한다. 고객의 계약서내용을 컴퓨터프로그램에 직접 입력하기도 하며 보험료가 연체된 계약자에게 납입요청을 하기도 한다. 고객과 보험료 납입방법을 결정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"언어력|","workFunc1":"수집","workFunc2":"설득","workFunc3":"관련없음","similarNm":"보험모집인, 보험대리인, 보험영업원, 보험설계사, 보험중개사, 라이프플래너(LP:Life Planner), 보험외판원, 보험판매원, 라이프컨설턴트(LC:Life Consultant), 생활설계사","connectJob":"전문영역에 따라 생명보험모집인, 손해보험모집인, 보증보험모집인, 연금보험모집인","certLic":"보험설계사등록자격","dJobECd":"0332","dJobECdNm":"[0332]보험 모집인 및 투자 권유 대행인","dJobJCd":"5103","dJobJCdNm":"[5103]보험 모집인 및 투자 권유 대행인","dJobICd":"K662","dJobICdNm":"[K662]보험 및 연금관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006761:1', '{"dJobCd":"K000006761","dJobCdSeq":"1","dJobNm":"보험중개인","workSum":"보험회사를 위하여 각기 다른 보험회사의 보험상품을 비교하여 보험계약자에게 보험상품을 추천하고 보험계약자와 보험사업자 사이에 독립적으로 보험계약 체결을 중개한다.","doWork":"고객인 보험계약자의 위험을 확인·평가·분석하고 보험회사 보험상품의 담보내용 및 요율, 조건 등을 비교하여 고객의 보험계획에 적합한 최상의 보험상품을 권유·주선한다. 보험계약자의 보험설계에 대한 검토 및 검증을 하며, 독립적으로 보험계약자와 보험사업자 사이에 보험계약체결을 중개하는 업무를 수행한다. 어느 특정한 보험사업자에게 소속되지 않고 보험가입을 권유하며 보험계약자의 지시에 따라 보험계약자가 선정하는 보험사업자에 대하여 보험계약을 청약하거나 보험계약자가 선정할 수 없는 경우에는 중개인 자신이 정한 보험사업자에 대하여 보험계약의 청약을 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"설득","workFunc3":"관련없음","similarNm":"보험중개사","connectJob":"취급하는 보험상품에 따라 인보험중개인, 손해보험중개인","certLic":"보험중개사","dJobECd":"0332","dJobECdNm":"[0332]보험 모집인 및 투자 권유 대행인","dJobJCd":"5103","dJobJCdNm":"[5103]보험 모집인 및 투자 권유 대행인","dJobICd":"K662","dJobICdNm":"[K662]보험 및 연금관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002084:1', '{"dJobCd":"K000002084","dJobCdSeq":"1","dJobNm":"애견보험판매원","workSum":"고객들에게 애견보험상품을 설명하고 견주에게 적합한 보험을 판매한다.","doWork":"고객에게 상담요청이 들어오면, 애견의 견종, 나이, 질병병력 등 애견에 대한 정보를 파악한다. 보험상품에 대하여 설명한다. 질병치료비, 상해치료비 및 배상책임 등에 대한 보상내용, 보상되지 않는 주요질병 및 보험의 특징에 대한 설명을 한다. 애견에 대한 정보를 바탕으로 보험료를 계산하여 고객과 애견에 맞는 애견보험을 추천한다. 보험가입이 완료되면 보험증권, 약관, 상품설명서 등 문서화된 서류를 교부한다. 보험사에 애견보험 관련 자문을 하기도 한다. 애견보험 관련 홍보활동, 보험판매촉진 활동을 하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"비교","workFunc2":"설득","workFunc3":"관련없음","dJobECd":"0332","dJobECdNm":"[0332]보험 모집인 및 투자 권유 대행인","dJobJCd":"5103","dJobJCdNm":"[5103]보험 모집인 및 투자 권유 대행인","dJobICd":"K651","dJobICdNm":"[K651]보험업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005974:1', '{"dJobCd":"K000005974","dJobCdSeq":"1","dJobNm":"재무설계사","workSum":"고객의 생활환경, 재무상황 및 장래계획을 파악하여 고객의 생애주기에 적합한 금융 및 자산설계를 지원하고 보험상품, 펀드, 은행상품, 대출 등 고객에게 적합한 솔루션을 권유한다.","doWork":"고객의 가족구성, 직업 등의 생활환경과 수입, 지출, 자산, 부채 등의 재무상황을 파악한다. 파악한 정보를 토대로 고객의 결혼계획, 자녀교육계획, 자녀결혼계획 등의 장래계획의 목표를 달성하기 위한 위험관리, 저축 및 투자계획, 증여 및 상속, 노후자금관리, 세금대책 등에 대하여 상담한다. 고객의 목표달성을 위한 단기 및 중장기 솔루션으로서 보험, 펀드, 은행상품, 대출 등을 설명하고 가입을 권유한다. 고객이 원하면 상품가입 혹은 계약 등의 절차를 설명한다. 고객에게 상품을 판매한 후에는 고객의 투자방침, 위험관리, 절세 등의 전반적인 자산설계에 대한 정보를 제공한다. 펀드가입자에게는 수익상황동향을 수시로 분석하여 제공한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"언어력|","workFunc1":"조정","workFunc2":"설득","workFunc3":"관련없음","similarNm":"파이낸셜플래너(FP:Financial Planner), 파이낸셜컨설턴트(FC:Financial Consultant), 개인재무상담사, 개인재무설계사","certLic":"자산관리사(FP)","dJobECd":"0332","dJobECdNm":"[0332]보험 모집인 및 투자 권유 대행인","dJobJCd":"5103","dJobJCdNm":"[5103]보험 모집인 및 투자 권유 대행인","dJobICd":"K662","dJobICdNm":"[K662]보험 및 연금관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003524:1', '{"dJobCd":"K000003524","dJobCdSeq":"1","dJobNm":"투자권유대행인","workSum":"금융투자회사(증권사)와 전속 계약을 맺고 업무위탁을 받아 투자자를 상대로 금융투자상품의 매매 또는 투자자문, 투자일임, 신탁계약을 체결하도록 권유한다.","doWork":"투자자와 면담하여 투자권유 희망여부, 투자자 유형, 투자성향 등을 파악하고 투자자정보 확인서를 작성한다. 투자자의 정보를 분석하고 적절한 금융투자상품(증권, 펀드, 파생상품)을 추천한다. 투자자에게 금융투자상품에 대한 정보를 제공하고 의견을 교환하며 투자를 권유한다. 금융투자상품의 내용, 위험, 투자성, 수수료, 계약 및 해지에 관한 사항을 설명한다. 매매, 투자자문, 투자일임, 신탁계약 등을 체결하고 계약서류를 교부한다. 투자를 유치한 고객의 주식거래 수수료 또는 판매한 금융상품 수수료 중 일정액을 수수료로 받는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"설득","workFunc3":"관련없음","similarNm":"증권투자권유대행인, 펀드투자권유대행인, 파생상품투자권유대행인","certLic":"증권투자권유대행인, 펀드투자권유대행인, 파생상품투자권유대행인으로 자격이 필요함","dJobECd":"0332","dJobECdNm":"[0332]보험 모집인 및 투자 권유 대행인","dJobJCd":"5103","dJobJCdNm":"[5103]보험 모집인 및 투자 권유 대행인","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004947:1', '{"dJobCd":"K000004947","dJobCdSeq":"1","dJobNm":"대출상담사","workSum":"금융회사나 대출모집법인으로부터 업무를 위탁받아 대면, 온라인, 전화 등으로 대출상품을 설명하고 대출신청에 관한 상담업무를 수행하거나 대출수요자를 발굴하여 대출신청자를 모집한다.","doWork":"대출상품 수요자를 발굴하고 대면, 온라인, 전화, 상품안내장 배포 등의 방법으로 대출상품을 설명하고 홍보한다. 대출상품의 조건 및 대출내용(대출가능조건, 대출가능금액, 대출금리, 대출 시 부대비용, 대출만기 및 대출상환방법, 중도 상환 시 불이익, 대출이자 또는 원금 연체 시 불이익 및 기타 금융소비자가 반드시 알아야 할 중요한 내용)을 설명한다. 대출서류를 접수하거나 접수한 서류를 대출모집업무를 위탁한 금융회사 또는 대출모집법인에 전달한다. 대출 모집 실적에 따라 금융회사 또는 대출모집법인으로부터 모집수수료를 받는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"수집","workFunc2":"설득","workFunc3":"관련없음","similarNm":"대출모집인, 대출영업원","certLic":"활동하기 위해서는 등록해야 함","dJobECd":"0331","dJobECdNm":"[0331]대출 및 신용카드 모집인","dJobJCd":"5104","dJobJCdNm":"[5104]대출 및 신용카드 모집인","dJobICd":"K641","dJobICdNm":"[K641]은행 및 저축기관","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005212:1', '{"dJobCd":"K000005212","dJobCdSeq":"1","dJobNm":"카드상담사","workSum":"신용카드 회사로부터 업무를 위탁받아 신용카드 발급계약의 체결을 중개한다.","doWork":"신용카드 발급 수요자를 발굴하고 대면, 온라인, 전화, 상품안내장 배포 등의 방법으로 신용카드 상품을 설명하고 홍보한다. 신용카드 발급 수요자에게 신용카드 약관, 연회비 등의 거래조건 등을 설명하고 가입을 권유한다. 신용카드 신청서류를 접수하고 접수한 서류를 신용카드 회사에 전달한다. 신용카드 모집 실적에 따라 신용카드 회사로부터 모집수수료를 받는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"수집","workFunc2":"설득","workFunc3":"관련없음","similarNm":"카드모집인, 카드영업원, 신용카드설계사","dJobECd":"0331","dJobECdNm":"[0331]대출 및 신용카드 모집인","dJobJCd":"5104","dJobJCdNm":"[5104]대출 및 신용카드 모집인","dJobICd":"K649","dJobICdNm":"[K649]기타 금융업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001705:1', '{"dJobCd":"K000001705","dJobCdSeq":"1","dJobNm":"매장매니저","workSum":"도소매업체에서 상품 판매와 직원관리를 책임진다.","doWork":"도소매업체에서 상품의 판매와 관련된 계획을 수립한다. 상품 및 상점판매원을 관리한다. 판매 실적을 정산한다. 점포 및 매장의 매출관리, 실적관리, 가격재조정, 광고예산집행업무, 판매사원 교육, 판매전략 회의, 판매지원 관련 업무를 수행한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"매장점장, 점장, 매장슈퍼바이저, 샵마스터, 판매관리인, 매장관리인, 판매점장","connectJob":"직영체인점점장, 슈퍼마켓점장, 할인매장점장, 백화점매장점장, 서점점장, 마트매장점장, 주유소점장, 쇼핑몰관리인","certLic":"유통관리사","dJobECd":"6140","dJobECdNm":"[6140]소규모 상점 경영 및 일선 관리 종사원","dJobJCd":"5211","dJobJCdNm":"[5211]소규모 상점 경영 및 일선 관리 종사원","dJobICd":"G471","dJobICdNm":"[G471]종합 소매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004678:1', '{"dJobCd":"K000004678","dJobCdSeq":"1","dJobNm":"슈퍼마켓관리자","workSum":"슈퍼마켓의 판매에 관련한 전반적인 사항을 관리한다.","doWork":"슈퍼마켓의 상품 판매에 관련된 전반적인 사항을 처리·관리한다. 해당 매장에서 일하는 직원의 채용, 월급, 복지, 복무사항 등에 대해 전반적으로 관리한다. 슈퍼마켓에서 물품의 수요와 재고를 파악하여 유통업체에 물품 구매 신청을 한다. 납품된 물품에 대한 검수·검사를 실시한다. 유통업체나 제조사와 신규 상품에 대한 납품 계약을 협의하고 작성한다. 농수산물의 경우 수익증가를 위해 생산지와 직접 거래하기도 한다. 구매가 용이하도록 물품의 진열, 할인 등 특별판매를 계획하여 판매를 증가시킨다. 수익을 계산하여 물품의 가격을 책정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"단순작업","dJobECd":"6140","dJobECdNm":"[6140]소규모 상점 경영 및 일선 관리 종사원","dJobJCd":"5211","dJobJCdNm":"[5211]소규모 상점 경영 및 일선 관리 종사원","dJobICd":"G471","dJobICdNm":"[G471]종합 소매업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004802:1', '{"dJobCd":"K000004802","dJobCdSeq":"1","dJobNm":"편의점수퍼바이저","workSum":"주변의 상권조사를 바탕으로 편의점 직영점과 가맹점의 매출을 향상시키기 위해 영업컨설팅과 재고 및 자금 등을 관리한다.","doWork":"점포들의 매출 관련 자료와 상품동향 등을 분석하며 주변 상권을 조사하여 파악한다. 분석한 자료를 바탕으로 각 지역 점포에 알맞은 경영컨설팅 및 상담을 하고 행사를 기획한다. 매출이익을 높이고 고객만족도를 향상시킬 수 있도록 점주를 대상으로 교육, 지도 및 조언한다. 본사 회의에 참석하여 신상품, 행사, 시스템 변경 등 본사의 운영방침 및 업무정책을 숙지한다. 본사의 방침이나 정책을 관리하는 점주들에게 전달한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실외","physicalAct":"언어력|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"FC(Field Consultant), OFC(Operation Field Counselor)","dJobECd":"6140","dJobECdNm":"[6140]소규모 상점 경영 및 일선 관리 종사원","dJobJCd":"5211","dJobJCdNm":"[5211]소규모 상점 경영 및 일선 관리 종사원","dJobICd":"G471","dJobICdNm":"[G471]종합 소매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002164:1', '{"dJobCd":"K000002164","dJobCdSeq":"1","dJobNm":"3D프린팅운영전문가","workSum":"고객의 요구에 따라 3D프린터를 활용하여 출력 대행과 시제품을 제작한다.","doWork":"3D프린터를 활용하여 출력을 대행한다. 개인, 광고대행사나 영화사 등의 의뢰로 3D프린터를 이용해 시제품을 만들어 준다. 3D프린팅 출력물 후가공을 진행한다. 3D프린팅 출력물에 사상작업을 거쳐 채색 및 도장을 하여 완제품을 생산, 유통한다. 3D프린팅 교육 및 홍보를 수행한다. 이밖에 제품제작 외에 3D프린터 대여사업도 한다. 기타 사업체 운영과 관련한 업무를 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"서비스제공","workFunc3":"제어조작","similarNm":"3D프린팅숍매니저","dJobECd":"6151","dJobECdNm":"[6151]상점 판매원","dJobJCd":"5212","dJobJCdNm":"[5212]상점 판매원","dJobICd":"G478","dJobICdNm":"[G478]기타 상품 전문 소매업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001309:1', '{"dJobCd":"K000001309","dJobCdSeq":"1","dJobNm":"가구판매원","workSum":"사무용, 가정용, 주방용 가구 및 전통가구 등을 소비자에게 판매한다.","doWork":"판매량, 재고량을 파악하고 유행하는 가구를 파악하여 도매업자에게 주문한다. 고객이 필요로 하는 용도와 크기, 디자인, 색상 등을 파악하여 물품을 추천한다. 거래가 성사되면 고객으로부터 대금을 받아 거스름돈을 지불하거나 신용카드를 이용하여 계산을 하고 영수증을 준다. 고객이 원하는 장소에 운반하여 조립·설치한다. 대량으로 판매를 하거나 고객이 원하는 경우에는 원재료, 디자인을 파악하여 도매업체를 통하지 않고 제조공장에 주문하여 판매하기도 한다. 도매업체로부터 부품만을 구매한 후 조립하여 판매하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"언어력|","workFunc1":"수집","workFunc2":"설득","workFunc3":"단순작업","connectJob":"판매하는 제품에 따라 사무가구판매원, 생활가구판매원, 주방가구판매원","dJobECd":"6151","dJobECdNm":"[6151]상점 판매원","dJobJCd":"5212","dJobJCdNm":"[5212]상점 판매원","dJobICd":"G475","dJobICdNm":"[G475]기타 생활용품 소매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002845:1', '{"dJobCd":"K000002845","dJobCdSeq":"1","dJobNm":"가방판매원","workSum":"백(Bag), 학생용 가방, 여행가방, 서류가방 등 각종 가방을 소비자에게 판매한다.","doWork":"도매업체로부터 물품을 주문하여 구매한다. 매입·매출 내역과 재고량, 판매수익을 파악한다. 진열대에 물품을 전시한다. 용도와 크기, 디자인, 색상 등 가방의 특성을 파악한다. 고객의 취향, 의상 등을 파악하여 어울리는 가방을 추천한다. 고객에게 가방의 용도와 크기, 디자인, 색상 등의 특성과 가격 등을 알려준다. 고객이 원하는 가방을 시연할 수 있도록 꺼내준다. 시연 후 상품을 다시 정리하고, 손질하여 진열대에 진열한다. 고객으로부터 대금을 받아 거스름돈을 지불하거나 신용카드를 이용하여 계산을 하고 영수증을 준다. 신용카드의 경우 판독기를 통하여 결제확인을 하고 대금 입력 후 영수증에 서명을 받는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"언어력|","workFunc1":"수집","workFunc2":"설득","workFunc3":"단순작업","dJobECd":"6151","dJobECdNm":"[6151]상점 판매원","dJobJCd":"5212","dJobJCdNm":"[5212]상점 판매원","dJobICd":"G474","dJobICdNm":"[G474]섬유, 의복, 신발 및 가죽제품 소매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002099:1', '{"dJobCd":"K000002099","dJobCdSeq":"1","dJobNm":"가전제품판매원","workSum":"영상제품, 음향제품, 주방전기제품 등의 가전제품을 소비자에게 판매한다.","doWork":"컴퓨터, 음향기기, 영상기기, 주방기기, 생활용 가전제품을 소비자에게 판매한다. 판매량과 재고량을 파악하여 물품을 주문한다. 제품에 대한 지식을 갖추어 소비자에게 물품별 차이점을 설명하여 구매를 돕는다. 고장난 제품에 대하여 무상수리 주문을 대행하여 해당 제품 공장에 입고시킨다. 물품보증서를 작성하여 고객에게 준다. 텔레비전, 세탁기, 냉장고, 에어컨 등 대형제품일 경우에는 해당 장소에 운송하여 사용이 가능하도록 직접 설치하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"설득","workFunc3":"단순작업","similarNm":"전자제품판매원, 생활가전판매원","connectJob":"텔레비전판매원, 냉장고판매원, 세탁기판매원, 청소기판매원, 에어컨판매원, 김치냉장고판매원","dJobECd":"6151","dJobECdNm":"[6151]상점 판매원","dJobJCd":"5212","dJobJCdNm":"[5212]상점 판매원","dJobICd":"G475","dJobICdNm":"[G475]기타 생활용품 소매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001997:1', '{"dJobCd":"K000001997","dJobCdSeq":"1","dJobNm":"건강코디네이터","workSum":"건강, 영양, 식품 지식을 토대로 약국(병원)에 방문하는 소비자(환자 포함)에게 기능성 식품의 섭취 방법 및 부작용 등 건강에 대한 상담과 판매 활동을 한다.","doWork":"약국(병원)에 방문하는 소비자(환자 포함)를 대상으로 생활 습관, 식습관, 질병 유무 등을 확인한다. 건강증진에 도움이 되는 기능성 원료와 영양소와 식품에 대한 상담을 통해 적합한 기능성 식품을 추천한다. 제품의 기능성과 제품 섭취량과 섭취법을 설명한다. 판매 후 소비자(환자 포함)의 건강증진 여부를 확인하고 추가 정보 등을 알려준다. 일일 업무보고 등 행정업무를 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"수집","workFunc2":"설득","workFunc3":"관련없음","similarNm":"건강식품코디네이터","dJobECd":"6151","dJobECdNm":"[6151]상점 판매원","dJobJCd":"5212","dJobJCdNm":"[5212]상점 판매원","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005695:1', '{"dJobCd":"K000005695","dJobCdSeq":"1","dJobNm":"곡물판매원","workSum":"쌀, 보리, 수수, 조 등의 곡물을 원산지나 도매상으로부터 구입하여 소비자에게 판매한다.","doWork":"곡물을 원산지나 도매상으로부터 구입하여 상점에 종류별로 진열하거나 창고에 보관한다. 소비자에게 곡물에 관한 정보를 제공하여 곡물의 구입을 돕는다. 소비자가 원하는 곡물을 저울에 올려 계량한 후 판매하거나 일정한 양을 포장하여 판매한다. 거래가 성사되면 고객으로부터 대금을 받아 거스름돈을 지불하거나 신용카드를 이용하여 계산을 하고 영수증을 제시한다. 매입·매출과 재고 등을 장부에 기록하고 확인한다. 보유한 상품의 상태와 상품의 보관 환경을 수시로 확인하여 부패를 방지한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"힘든 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"설득","workFunc3":"단순작업","dJobECd":"6151","dJobECdNm":"[6151]상점 판매원","dJobJCd":"5212","dJobJCdNm":"[5212]상점 판매원","dJobICd":"G472","dJobICdNm":"[G472]음ㆍ식료품 및 담배 소매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004548:1', '{"dJobCd":"K000004548","dJobCdSeq":"1","dJobNm":"골동품판매원","workSum":"소비자에게 도자기, 장신구 등의 각종 골동품이나 동양화, 서예 등의 작품을 판매한다.","doWork":"골동품을 매입한다. 각종 전시회를 통하여 전시품을 판매한다. 소비자에게 골동품의 작가, 특징, 예술적 가치 등을 설명하여 구매를 돕는다. 소비자가 선정한 물품이 파손되지 않도록 포장하여 소비자가 원하는 곳까지 배달 또는 전시한다. 작품의 유지 및 보존에 관한 정보를 제공하거나 제반 업무를 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"설득","workFunc3":"관련없음","connectJob":"예술품판매원","dJobECd":"6151","dJobECdNm":"[6151]상점 판매원","dJobJCd":"5212","dJobJCdNm":"[5212]상점 판매원","dJobICd":"G478","dJobICdNm":"[G478]기타 상품 전문 소매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003829:1', '{"dJobCd":"K000003829","dJobCdSeq":"1","dJobNm":"귀금속판매원","workSum":"고객에게 금, 은 등의 귀금속이나 반지, 목걸이, 팔찌 등의 귀금속 장신구를 판매한다.","doWork":"귀금속(금, 은 등)이나 귀금속 장신구(금, 은, 백금, 사파이어, 에메랄드, 오팔, 산호, 진주, 수정, 자수정 등으로 만든 반지, 목걸이, 팔찌)에 관한 상품설명을 하거나 고객에게 상품 안내책자를 제공하여 고객의 상품 선택을 돕고 알맞은 상품을 권한다. 고객이 원하거나 장신구의 종류에 따라 고객의 신체 치수를 재고 치수에 맞춰 주문 제작을 의뢰한다. 귀금속 시세에 따라 판매가격을 계산한다. 고객이 구입한 상품을 포장하여 주기도 하고 배달하기도 한다. 매입·매출이나 재고상태를 파악하고 장부를 정리한다. 상점의 보안과 청결 등의 상태를 수시로 확인하고 관리한다. 고객의 요청에 따라 보석의 감정을 의뢰해주기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"수집","workFunc2":"설득","workFunc3":"관련없음","connectJob":"판매하는 제품의 종류에 따라 금은판매원, 장신구판매원","certLic":"보석감정사","dJobECd":"6151","dJobECdNm":"[6151]상점 판매원","dJobJCd":"5212","dJobJCdNm":"[5212]상점 판매원","dJobICd":"G478","dJobICdNm":"[G478]기타 상품 전문 소매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004499:1', '{"dJobCd":"K000004499","dJobCdSeq":"1","dJobNm":"꽃판매원","workSum":"고객에게 꽃을 포장하여 판매한다.","doWork":"화훼에 대한 지식을 갖추어 고객의 의도, 목적에 맞는 꽃을 추천한다. 판매량과 재고량을 파악하여 필요한 화훼를 주문한다. 화훼가 시들지 않도록 적정한 온도와 습도를 갖추어 보관한다. 화훼가 시들지 않도록 물을 주고 관리한다. 분재가위를 사용하여 화훼를 적당한 크기로 자르고 줄, 포장지, 상자, 받침대 등을 이용하여 꽃바구니, 꽃상자, 꽃다발, 축하·근조화환, 웨딩부케 등을 만든다. 고객에게 꽃이나 분재, 동서양란 등을 판매한다. 화분, 비료 등 화훼를 키우는데 필요한 물품을 팔기도 한다. 고객이 원할 경우 해당 장소까지 운반해 준다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"설득","workFunc3":"단순작업","similarNm":"원예판매원","connectJob":"화초판매원, 나무판매원, 분재판매원","dJobECd":"6151","dJobECdNm":"[6151]상점 판매원","dJobJCd":"5212","dJobJCdNm":"[5212]상점 판매원","dJobICd":"G478","dJobICdNm":"[G478]기타 상품 전문 소매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005143:1', '{"dJobCd":"K000005143","dJobCdSeq":"1","dJobNm":"농약비료판매원","workSum":"대량 구매 고객이나 소비자에게 각종 농약과 비료를 판매한다.","doWork":"고객에게 각종 농약(종자소독제, 살충제, 살균제, 살비제, 제초제, 토양살충제, 생장조절제 등)과 비료(요소, 질소, 복합비료, 인산비료 등)의 사용법과 안전사용기준 등에 관한 정보를 제공하여 구입하도록 돕는다. 동시 공동방제를 홍보하여 방제효과를 높이도록 홍보한다. 농업용 비닐, 마대, 끈, 씨앗 등을 판매하기도 한다. 고객이 구입한 상품을 포장하여 주기도 하고 배달하기도 한다. 매입·매출이나 재고상태를 파악하고 장부를 정리한다. 상점과 창고의 상태를 수시로 확인하고 관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"설득","workFunc3":"단순작업","dJobECd":"6151","dJobECdNm":"[6151]상점 판매원","dJobJCd":"5212","dJobJCdNm":"[5212]상점 판매원","dJobICd":"G467","dJobICdNm":"[G467]기타 전문 도매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005509:1', '{"dJobCd":"K000005509","dJobCdSeq":"1","dJobNm":"도료판매원","workSum":"건축용 도료, 목공용 도료, 바닥 특수 도료, 방수재, 내화 도료 등을 소매업체에 대량으로 판매한다.","doWork":"제조사에 물품 구매 신청을 한다. 납품된 물품을 통풍이 잘되는 창고에 종류별로 저장한다. 물품에 대한 특성과 가격을 숙지한다. 고객이 물품을 구매하고자 할 때 용도에 알맞은 물품과 색상에 대한 지식을 토대로 주위환경에 알맞은 색상을 추천한다. 판매장부를 작성하여 재고량과 수요량을 파악한다. 도색에 사용되는 붓이나 스프레이, 시너(Thinner) 등을 판매하기도 한다. 건축자재에 사용될 도료를 대량으로 건축 현장에 판매할 때 직접 납품을 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|","workFunc1":"수집","workFunc2":"설득","workFunc3":"단순작업","dJobECd":"6151","dJobECdNm":"[6151]상점 판매원","dJobJCd":"5212","dJobJCdNm":"[5212]상점 판매원","dJobICd":"G466","dJobICdNm":"[G466]건축자재, 철물 및 난방장치 도매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005688:1', '{"dJobCd":"K000005688","dJobCdSeq":"1","dJobNm":"떡판매원","workSum":"가래떡, 꿀떡, 백설기, 인절미 등의 각종 떡을 소비자에게 판매한다.","doWork":"곡물상으로부터 좋은 품질의 곡물을 구매한 후 떡을 직접 만들거나 대형 떡 제조공장에서 떡을 구매한다. 떡의 맛과 첨가물 등을 고객에게 알려주고 구입하게 한다. 떡과 재료의 상태를 수시로 점검한다. 고객이 구입을 희망하는 양만큼 포장하여 판매한다. 고객으로부터 대금을 받고 영수증을 제시한다. 떡을 소량으로 포장하여 상품을 진열한다. 고객의 요청에 따라 기념일 등에 적합한 떡을 예약받고 예정일에 맞추어 배달한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"설득","workFunc3":"관련없음","dJobECd":"6151","dJobECdNm":"[6151]상점 판매원","dJobJCd":"5212","dJobJCdNm":"[5212]상점 판매원","dJobICd":"G472","dJobICdNm":"[G472]음ㆍ식료품 및 담배 소매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005626:1', '{"dJobCd":"K000005626","dJobCdSeq":"1","dJobNm":"면세점판매원","workSum":"면세점에서 외국인 및 내국인을 상대로 면세상품, 주류, 외제품, 특산품 등을 판매한다.","doWork":"면세점(세금이 부과되지 않는 비과세 상점)에서 고객에게 상품을 설명하고 다양한 모델 및 색상을 보여준다. 고객이 상품을 선택·구매하도록 유도한다. 외국인 고객의 경우 외국어를 구사하여 판매한다. 환율에 따라 상품금액을 고객의 지불화폐로 계산한다. 고객이 제시하는 여권과 출국정보(항공편)를 확인한다. 공항면세점의 경우 상품을 포장하여 고객에게 인도한다. 시내면세점의 경우 고객이 구입한 상품을 공항 내 면세품 인도장에서 받을 수 있도록(물품의 구입을 온라인 코드로 처리하고 실물은 공항면세창고에서 출고) 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"수집","workFunc2":"설득","workFunc3":"단순작업","similarNm":"면세상품판매원","dJobECd":"6151","dJobECdNm":"[6151]상점 판매원","dJobJCd":"5212","dJobJCdNm":"[5212]상점 판매원","dJobICd":"G471","dJobICdNm":"[G471]종합 소매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004199:1', '{"dJobCd":"K000004199","dJobCdSeq":"1","dJobNm":"목재판매원","workSum":"유통업체나 제조사를 통하여 원목이나 가공목을 구매하여 소매업체에 대량으로 판매한다.","doWork":"유통업체나 목재 제조사를 통하여 원목, 제재목, 합판, 패널, 목가공품 등 필요한 물품을 구매한다. 인테리어나 건축자재 등 용도에 맞게 원목을 절단한다. 납품되는 물품을 직사광선과 습기를 피하여 보관한다. 판매장부와 창고 물품의 수량이 맞는지 파악한다. 부족한 물품에 대하여 구매 신청을 한다. 목재별 특성과 사용 용도를 파악하여 소매업체에 알맞은 물품을 추천한다. 소매업체가 원하는 장소에 운반한다. 수량과 가격, 대금 납부 일정에 목재를 필요로 하는 건축현장 등에 물품을 납품하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"설득","workFunc3":"단순작업","dJobECd":"6151","dJobECdNm":"[6151]상점 판매원","dJobJCd":"5212","dJobJCdNm":"[5212]상점 판매원","dJobICd":"G466","dJobICdNm":"[G466]건축자재, 철물 및 난방장치 도매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005048:1', '{"dJobCd":"K000005048","dJobCdSeq":"1","dJobNm":"백화점상품판매원","workSum":"백화점에서 고객에게 상품을 판매한다.","doWork":"백화점상품관리자의 일반적인 지휘·감독하에 상품을 판매한다. 업체에서 발송한 상품의 수량과 품질을 검사한다. 상품을 진열하며 재고상품을 관리한다. 고객이 상품을 살펴볼 수 있게 도와주고 고객의 상품선택을 조언한다. 고객이 구입한 상품을 포장한다. 재고량을 파악하여 필요한 상품을 요청한다. 고객의 요청에 따라 상품을 교환·환불·반품한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"수집","workFunc2":"설득","workFunc3":"단순작업","similarNm":"백화점판매원","dJobECd":"6151","dJobECdNm":"[6151]상점 판매원","dJobJCd":"5212","dJobJCdNm":"[5212]상점 판매원","dJobICd":"G471","dJobICdNm":"[G471]종합 소매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001560:1', '{"dJobCd":"K000001560","dJobCdSeq":"1","dJobNm":"벽돌판매원","workSum":"시멘트벽돌, 점토벽돌, 보도벽돌, 미장벽돌, 유약벽돌 등을 대량으로 소매업체에 판매한다.","doWork":"제조사에 물품을 주문한다. 납품되는 물품에 대하여 수량을 검수하고 치수, 겉모양 등의 품질 이상 유무를 검사한다. 물품을 통풍이 잘되고 직사광선과 습기를 피하여 보관한다. 물품의 특성과 용도, 가격을 숙지한다. 판매장부를 작성하고 판매량과 재고량을 파악한다. 소매업체와 수량과 대금납부시기 등을 고려해 물품가격을 협의한다. 소매업체가 원하는 장소에 운반한다. 대량으로 건축자재에 사용될 경우 건축현장에 직접 납품하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"설득","workFunc3":"단순작업","dJobECd":"6151","dJobECdNm":"[6151]상점 판매원","dJobJCd":"5212","dJobJCdNm":"[5212]상점 판매원","dJobICd":"G466","dJobICdNm":"[G466]건축자재, 철물 및 난방장치 도매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006822:1', '{"dJobCd":"K000006822","dJobCdSeq":"1","dJobNm":"보석판매원","workSum":"다이아몬드, 귀석, 반귀석, 합성석, 인조석 등 여러 종류의 보석을 대량 구매고객이나 소비자에게 판매한다.","doWork":"구매자들의 구매의욕을 높이기 위하여 보석에 관한 지식을 이용하여 제품을 종류별, 색상별, 중량별, 품위별, 연마정도 등에 따라 판매대에 진열한다. 빛의 굴절률을 이용하여 조명의 방향과 조광도를 조정한다. 고객이 상점에 방문하면 영접하고 고객에게 보석에 관한 정보를 제공하고 보석 선택을 돕는다. 고객이 원하면 보석을 착용하는데 도움을 주기도 한다. 고객이 구입한 상품을 포장하여 주기도 하고 배달하기도 한다. 매입·매출이나 재고상태를 파악하고 장부를 정리한다. 상점의 보안과 청결 등의 상태를 수시로 확인하고 관리한다. 고객의 요청에 따라 보석을 감정해주기도 한다. 각종 보석의 수선을 주선하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"설득","workFunc3":"단순작업","dJobECd":"6151","dJobECdNm":"[6151]상점 판매원","dJobJCd":"5212","dJobJCdNm":"[5212]상점 판매원","dJobICd":"G478","dJobICdNm":"[G478]기타 상품 전문 소매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001663:1', '{"dJobCd":"K000001663","dJobCdSeq":"1","dJobNm":"사무용기기판매원","workSum":"팩시밀리, 복사기, 계산기와 같은 사무용기기를 판매한다.","doWork":"소비자의 구매의욕을 높이기 위해 사무용기기의 가격대별, 제조사별 진열 및 홍보 전략을 세운다. 소비자의 요구에 따른 제품별, 가격별, 제조회사별 설명과 장단점을 비교 설명한다. 기기의 작동법과 주의사항을 설명하거나 작동테스트를 한다. 판매할 제품을 운반하여 적정한 위치에 설치하고 확인한다. 각종 토너 및 잉크, 복사용지, 소모성부품 등을 판매한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"설득","workFunc3":"관련없음","dJobECd":"6151","dJobECdNm":"[6151]상점 판매원","dJobJCd":"5212","dJobJCdNm":"[5212]상점 판매원","dJobICd":"G478","dJobICdNm":"[G478]기타 상품 전문 소매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002543:1', '{"dJobCd":"K000002543","dJobCdSeq":"1","dJobNm":"수산물판매원","workSum":"일반 활어와 냉동, 건조, 염장한 수산물을 현지와 도매상에서 구입하여 소비자에게 판매한다.","doWork":"신선도, 색, 크기 등을 고려하여 수산물을 도매로 구입한다. 수산물을 종류별로 정돈하여 진열대에 진열한다. 수산물의 신선도를 유지하기 위하여 냉동·냉장시키거나 해수에 담가 보관한다. 고객의 요청에 따라 수산물을 조리하기 용이하도록 자르거나 손질을 하고 적당량을 포장하여 판매한다. 상품의 종류에 따라 고객이 요구하는 양을 저울에 계량하여 판매한다. 거래가 성사되면 고객에게 현금이나 신용카드로 대금을 받고 영수증을 발급해준다. 매입·매출과 재고 등을 장부에 기록하고 확인한다. 냉장냉동고와 수족관 등을 수시로 확인하여 깨끗하게 청소·관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"웅크림|","workEnv":"다습|","workFunc1":"수집","workFunc2":"설득","workFunc3":"단순작업","connectJob":"물고기판매원, 어패류판매원, 젓갈판매원","dJobECd":"6151","dJobECdNm":"[6151]상점 판매원","dJobJCd":"5212","dJobJCdNm":"[5212]상점 판매원","dJobICd":"G472","dJobICdNm":"[G472]음ㆍ식료품 및 담배 소매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003520:1', '{"dJobCd":"K000003520","dJobCdSeq":"1","dJobNm":"슈퍼마켓판매원","workSum":"슈퍼마켓에서 소비자에게 물품을 판매한다.","doWork":"창고에 있는 물품의 재고를 파악하여 가판대에 정리하여 비치한다. 냉장·냉동 식품의 경우에는 냉장·냉동실의 온도를 수시로 확인하여 상하는 것을 방지한다. 스티커를 물품에 부착하여 가격표시를 한다. 중량으로 가격을 정하는 물품의 경우에는 저울을 사용하여 가격을 계산하고 단위별로 묶어서 계산하여 판매하기도 한다. 홍보전단지 배포나 특별 할인 판매, 사은품 증정 등의 홍보활동을 하여 판매를 촉진시킨다. 계산기를 사용하여 소비자가 구입한 물품의 총합을 계산한다. 물품 대금을 받고 소비자에게 영수증을 준다. 신용카드의 경우 판독기를 통하여 결제확인을 하고 대금 입력 후 영수증에 소비자의 서명을 받는다. 대량으로 물품을 구매할 경우 고객이 원하는 장소까지 배달하기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"시범후 30일 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"설득","workFunc3":"단순작업","connectJob":"대형마트판매원, 대형할인점판매원","dJobECd":"6151","dJobECdNm":"[6151]상점 판매원","dJobJCd":"5212","dJobJCdNm":"[5212]상점 판매원","dJobICd":"G471","dJobICdNm":"[G471]종합 소매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002963:1', '{"dJobCd":"K000002963","dJobCdSeq":"1","dJobNm":"시계판매원","workSum":"시계 및 관련된 제품을 소비자에게 판매한다.","doWork":"유행이나 수요를 파악하여 도매업체나 유통업체로부터 탁상시계, 벽시계, 손목시계 등 시계 및 부속품을 구매한다. 재고량과 판매량을 기록한다. 구비되는 물품을 종류별로 비치한다. 고객이 관심 두는 물품에 대해 설명해주고, 재질이나 디자인과 같은 물품에 대한 지식을 갖추어 고객이 물품을 구매하는 데 도움을 준다. 더 좋은 상품이나 고객에게 더 적합한 상품을 선택하여 추천해준다. 구매를 결정한 상품을 계산하고 포장한다. 반품하는 상품을 처리한다. 상품을 진열하고 정리한다. 건전지 교환이나 시곗줄 교환 등 단순한 수리, 교체 업무를 수행하고 복잡한 수리의 경우에는 전문 수리점에 의뢰하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"설득","workFunc3":"단순작업","dJobECd":"6151","dJobECdNm":"[6151]상점 판매원","dJobJCd":"5212","dJobJCdNm":"[5212]상점 판매원","dJobICd":"G478","dJobICdNm":"[G478]기타 상품 전문 소매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003834:1', '{"dJobCd":"K000003834","dJobCdSeq":"1","dJobNm":"식품판매원","workSum":"식품매장에서 농산물, 축산물, 건어물, 냉동식품 등 다양한 종류의 식품을 판매한다.","doWork":"판매하는 식품의 종류에 따라 저온, 냉동, 상온 등 상품 진열방법을 파악하고 냉동고, 냉장진열대, 습도조절진열대, 상온판매대 등에 진열한다. 고객에게 상품을 설명하고 구매를 유도한다. 상품바코드가 부착되지 않은 중량판매품이나 수량판매품의 경우 저울을 사용하여 계량하거나 상품 개수를 확인하여 상품가격을 표시한다. 식품의 신선도 유지를 위해 온도와 습도를 조절한다. 유통기한 및 오염·훼손·신선도 저하 상품을 판매대에서 회수한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"시범후 30일 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"설득","workFunc3":"관련없음","connectJob":"음료판매원, 농산물판매원, 축산물판매원, 건어물판매원, 제과점판매원, 특산물판매원, 건강식품판매원, 공원매점판매원, 고수부지매점판매원, 휴게소판매원, 친환경농산물판매원, 친환경식품판매원","dJobECd":"6151","dJobECdNm":"[6151]상점 판매원","dJobJCd":"5212","dJobJCdNm":"[5212]상점 판매원","dJobICd":"G472","dJobICdNm":"[G472]음ㆍ식료품 및 담배 소매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002496:1', '{"dJobCd":"K000002496","dJobCdSeq":"1","dJobNm":"신발판매원","workSum":"운동화, 구두 등의 각종 신발을 소비자에게 판매한다.","doWork":"상점을 방문하는 고객을 맞이한다. 고객이 원하는 신발을 치수에 맞게 선보이거나 고객에게 착용시킨다. 고객에게 신발에 관한 정보를 제공한다. 거래가 성사되면 신발값을 받고 거스름돈과 영수증을 준다. 신용카드로 지불할 경우 결제를 하고 영수증을 준다. 고객이 구입한 상품을 포장한다. 매입·매출이나 재고상태를 파악하고 장부를 정리한다. 상점과 창고의 상태를 수시로 확인하고 관리한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"시범후 30일 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"비교","workFunc2":"설득","workFunc3":"단순작업","dJobECd":"6151","dJobECdNm":"[6151]상점 판매원","dJobJCd":"5212","dJobJCdNm":"[5212]상점 판매원","dJobICd":"G474","dJobICdNm":"[G474]섬유, 의복, 신발 및 가죽제품 소매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002707:1', '{"dJobCd":"K000002707","dJobCdSeq":"1","dJobNm":"아로마제품판매원","workSum":"고객에게 아로마 오일제품의 효능 및 사용방법을 안내하고, 알맞은 제품을 추천하고 판매한다.","doWork":"고객에게 아로마 제품의 효능에 대해 설명하고 상담을 통하여 고객에게 적합한 오일을 추천한다. 오일이 고객의 피부에 적합한지 테스트를 실시한다. 고객에게 흡입법, 수요법, 스팀법, 마사지법, 좌욕법 등의 오일 사용방법과 사용용량, 첨가오일, 브랜딩 방법 등에 대해 설명한다. 고객이 구매하고자 하는 아로마 제품을 계산한다. 오일을 이용한 관련 제품을 직접 제작하기도 한다. 상품을 진열 및 정리한다. 고객정보를 관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"수집","workFunc2":"설득","workFunc3":"단순작업","similarNm":"향기치료사","dJobECd":"6151","dJobECdNm":"[6151]상점 판매원","dJobJCd":"5212","dJobJCdNm":"[5212]상점 판매원","dJobICd":"G478","dJobICdNm":"[G478]기타 상품 전문 소매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003328:1', '{"dJobCd":"K000003328","dJobCdSeq":"1","dJobNm":"악기판매원","workSum":"현악기, 관악기, 타악기, 건반악기, 국악기, 전자악기, 교재용 악기 등을 소비자에게 판매한다.","doWork":"도매업체나 수입 유통업체를 통하여 악기를 구매한다. 보유하고 있지 않은 물품의 경우에는 고객으로부터 주문을 받아 도매업체에 주문을 하거나 수입 유통업체에 수입주문을 하여 판매한다. 악기 사용법을 익혀서 고객에게 시연하고, 물품별 차이를 설명한다. 각종 악기에 대한 특성과 가격 등을 숙지하여 고객의 질문에 응대한다. 제품 대금을 계산하여 고객에게 돈을 받는다. 악보와 앰프, 이펙터 등 악기와 관련된 부속품을 판매하기도 한다. 악기의 조율 등과 같은 지식을 갖추어 수리업무를 병행하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"설득","workFunc3":"단순작업","connectJob":"판매하는 악기의 종류에 따라 관악기판매원, 타악기판매원, 현악기판매원","dJobECd":"6151","dJobECdNm":"[6151]상점 판매원","dJobJCd":"5212","dJobJCdNm":"[5212]상점 판매원","dJobICd":"G475","dJobICdNm":"[G475]기타 생활용품 소매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005730:1', '{"dJobCd":"K000005730","dJobCdSeq":"1","dJobNm":"얼음판매원","workSum":"식용이나 공업용으로 사용될 얼음을 생산공장으로부터 구매하여 소비자에게 판매한다.","doWork":"얼음을 공장에서 구입하여 녹지 않도록 냉동고에 보관한다. 절단기나 각종 수동도구(톱이나 칼, 정, 망치 등)를 이용하여 고객이 원하는 만큼의 얼음을 잘라서 판매한다. 수요량이 일정하지 않으므로 계절별 수요량을 고려하여 적정량만을 구매하여 냉동고에 보관한다. 고객의 요청 시 배달하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"시범후 30일 이하","workStrong":"힘든 작업","workPlace":"실내·외","workEnv":"위험내재|저온|","workFunc1":"비교","workFunc2":"설득","workFunc3":"수동조작","dJobECd":"6151","dJobECdNm":"[6151]상점 판매원","dJobJCd":"5212","dJobJCdNm":"[5212]상점 판매원","dJobICd":"G472","dJobICdNm":"[G472]음ㆍ식료품 및 담배 소매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006726:1', '{"dJobCd":"K000006726","dJobCdSeq":"1","dJobNm":"오토바이판매원","workSum":"각 오토바이 제조회사로부터 상품을 확보하여 진열, 관리, 판매한다.","doWork":"제조회사별 신차 또는 중고 오토바이를 확보하여 진열한다. 소비자가 통신 또는 방문을 통하여 구매하고자 하면 제조회사별, 색상별, 성능별로 분리 설명하여 구매를 돕는다. 구입계약을 체결하고 수반되는 행정적인 업무를 수행한다. 진열상품의 재고를 파악하여 주문 또는 확보한다. 계절별 구매율 및 타 업소의 판매율을 비교·분석하여 판매전략을 세운다. 판매 예약된 오토바이를 소비자에게 인도한다. 소비자의 요구에 따라 헬멧을 판매하거나 각종 액세서리를 부착하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"설득","workFunc3":"관련없음","similarNm":"오토바이영업원","connectJob":"판매하는 오토바이에 따라 중고오토바이판매원","dJobECd":"6151","dJobECdNm":"[6151]상점 판매원","dJobJCd":"5212","dJobJCdNm":"[5212]상점 판매원","dJobICd":"G453","dJobICdNm":"[G453]모터사이클 및 부품 판매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004347:1', '{"dJobCd":"K000004347","dJobCdSeq":"1","dJobNm":"완구모조장식품판매원","workSum":"인형, 장난감 등의 완구류와 반지, 핀, 빗, 브로치, 팔찌, 목걸이 등과 같은 모조장식품(귀금속제품 제외)을 도매 또는 소매로 판매한다.","doWork":"고객이 완구점이나 모조장식품 상점을 방문하면 고객에게 완구제품이나 모조장식품을 설명하고 권유한다. 플라스틱, 헝겊, 솜 등과 같은 각종 재료로 만든 인형, 장난감 등의 완구류와 반지, 핀, 빗, 브로치, 팔찌, 목걸이 등과 같은 모조장식품(귀금속제품 제외)을 인형가게, 장난감가게, 모조장식품 전문점 등에 대량으로 판매하거나 개인소비자에게 소매로 판매한다. 고객이 구입한 상품을 포장하여 주기도 하고 배달하기도 한다. 매입·매출이나 재고상태를 파악하고 장부를 정리한다. 상점과 창고의 상태를 수시로 확인하고 관리한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"시범후 30일 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"설득","workFunc3":"관련없음","dJobECd":"6151","dJobECdNm":"[6151]상점 판매원","dJobJCd":"5212","dJobJCdNm":"[5212]상점 판매원","dJobICd":"G476","dJobICdNm":"[G476]문화, 오락 및 여가 용품 소매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003828:1', '{"dJobCd":"K000003828","dJobCdSeq":"1","dJobNm":"유리판매원","workSum":"건축용 유리, 인테리어 유리, 가구용 유리, 거울 등을 유리공사업체나 소매업체 또는 일반 소비자에게 판매한다.","doWork":"제조사와 전산망이나 전화를 통하여 물품 주문을 한다. 납품되는 물품에 대하여 검수, 검사를 실시한다. 파손에 유의하여 물품을 종류별로 보관한다. 건축용 유리, 인테리어 유리 등은 크기에 맞게 절단하여 판매한다. 장부를 작성하여 매입, 매출을 파악한다. 종류, 용도, 색상이나 크기를 파악하여 소매업체에 주문을 받아 지정된 장소에 납품한다. 물품에 대한 특성이나 가격을 숙지한다. 대량으로 건축에 사용될 경우 건축현장에 직접 납품하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"설득","workFunc3":"단순작업","dJobECd":"6151","dJobECdNm":"[6151]상점 판매원","dJobJCd":"5212","dJobJCdNm":"[5212]상점 판매원","dJobICd":"G466","dJobICdNm":"[G466]건축자재, 철물 및 난방장치 도매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005620:1', '{"dJobCd":"K000005620","dJobCdSeq":"1","dJobNm":"육류판매원","workSum":"소, 돼지, 닭 등의 육류를 원산지나 도매상으로부터 구입하여 소비자에게 판매한다.","doWork":"쇠고기, 돼지고기 및 각종 부산물 등을 도매로 구매하여 냉장 냉동실에 보관·관리한다. 육류의 부위별 명칭과 용도를 숙지한다. 고객이 원하는 부위나 양을 확인하여 육류를 잘라 저울에 올려 양을 계량한 후 고객에게 포장하여 준다. 사전에 일정한 양으로 절단 및 포장한 후 판매하기도 한다. 거래가 성사되면 고객으로부터 대금을 현금으로 받아 거스름돈을 지불하거나 신용카드를 이용하여 대금을 받고 영수증을 제시한다. 육류를 부위별로 분류해 진열한다. 매입·매출과 재고 등을 장부에 기록하고 확인한다. 수시로 냉장·냉동실의 상태를 확인하여 육류의 신선도를 유지한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"시범후 30일 이하","workStrong":"힘든 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"설득","workFunc3":"제어조작","dJobECd":"6151","dJobECdNm":"[6151]상점 판매원","dJobJCd":"5212","dJobJCdNm":"[5212]상점 판매원","dJobICd":"G472","dJobICdNm":"[G472]음ㆍ식료품 및 담배 소매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001497:1', '{"dJobCd":"K000001497","dJobCdSeq":"1","dJobNm":"음반판매원","workSum":"음반 및 영상물을 소비자에게 판매한다.","doWork":"가요, 팝, 클래식 등이 저장된 CD나 테이프 형태의 음향매체나 뮤직비디오, 영화, 다큐멘터리 등이 저장된 DVD, 블루레이 등과 같은 영상매체를 도매업체로부터 구입한다. 보유하고 있지 않은 물품을 주문하여 구비한다. 수요를 파악하고 구비되지 않은 물품의 경우에는 도매업체에 주문한다. 물품을 종류, 장르별로 정리하여 소비자가 원하는 물품을 찾기 쉽도록 한다. 매장 내에 포스터나 판매정보를 기재하는 등 음악을 소개하여 구매를 촉진시킨다. 음악가, 음악장르, 영화감독 등 물품에 대한 지식을 갖추어 고객에게 조언한다. 물품에 대한 대금을 계산한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"설득","workFunc3":"단순작업","dJobECd":"6151","dJobECdNm":"[6151]상점 판매원","dJobJCd":"5212","dJobJCdNm":"[5212]상점 판매원","dJobICd":"G476","dJobICdNm":"[G476]문화, 오락 및 여가 용품 소매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003677:1', '{"dJobCd":"K000003677","dJobCdSeq":"1","dJobNm":"의류판매원","workSum":"일반 소비자에게 정장의류, 내의류, 캐주얼의류, 의류액세서리 등을 판매한다.","doWork":"도매업체나 유통업체로부터 의류를 주문하여 구입한다. 납품된 물품을 검수, 검사하고 창고에 물품별로 정리하여 보관한다. 진열대에 물품을 종류별로 전시하고 마네킹에 상품을 입혀 고객의 구매를 돕는다. 고객에게 어울리는 색상과 스타일의 의류를 추천한다. 고객이 입어볼 수 있도록 알맞은 치수의 의류를 제공한다. 고객이 의류의 길이나 폭을 수선하려는 경우에 전문 수선점에 맡긴다. 하자가 있는 상품의 경우 도매업체나 유통업체에 반품한다. 거래내역 대장을 작성하고 일일 수익을 계산한다. 할인행사를 하여 이월된 재고품을 처리하기도 한다. 물품에 대한 계산을 하여 고객으로부터 대금을 받고 영수증을 준다. 신용카드의 경우 판독기를 통하여 결제확인을 하고 대금 입력 후 영수증에 서명을 받는다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"시범후 30일 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"설득","workFunc3":"단순작업","connectJob":"남성의류판매원, 여성의류판매원, 신사복판매원, 여성정장판매원, 남성정장판매원, 내의판매원, 아동의류판매원, 여성복판매원, 캐주얼판매원, 아동복판매원, 유아복판매원, 속옷판매원, 청바지판매원","dJobECd":"6151","dJobECdNm":"[6151]상점 판매원","dJobJCd":"5212","dJobJCdNm":"[5212]상점 판매원","dJobICd":"G474","dJobICdNm":"[G474]섬유, 의복, 신발 및 가죽제품 소매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006020:1', '{"dJobCd":"K000006020","dJobCdSeq":"1","dJobNm":"자동차부품판매원","workSum":"자동차와 관련한 각종 정비공구, 윤활유, 소모성 부품, 액세서리 및 중요부품을 정비업체 또는 소비자에게 판매한다.","doWork":"소비자나 정비업체에서 의뢰한 부품구입의뢰서를 전화, 팩스, 방문 등을 통해 확인한다. 차종을 확인한 후 해당 차종메이커의 부품목록과 가격, 재고상태를 확인한다. 해당 부품에 관한 정보나 정비요령, 가격정보를 제공한다. 차량정비 공구나 윤활유, 소모성 부품(브레이크 패드, 라이닝, 배터리, 각종 댐퍼 등), 각종 차량용 액세서리를 판매한다. 재고상태를 파악하여 필요한 부품의 명칭, 수량 등을 주문한다. 필요에 따라 부품을 배달하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"설득","workFunc3":"단순작업","connectJob":"자동차용품판매원","dJobECd":"6151","dJobECdNm":"[6151]상점 판매원","dJobJCd":"5212","dJobJCdNm":"[5212]상점 판매원","dJobICd":"G452","dJobICdNm":"[G452]자동차 부품 및 내장품 판매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003052:1', '{"dJobCd":"K000003052","dJobCdSeq":"1","dJobNm":"자전거판매원","workSum":"일반 소비자에게 자전거를 추천하고 판매한다.","doWork":"제조사나 유통업체로부터 특수용, 여성용, 아동용, 일반 자전거의 납품을 요청한다. 납품되는 물품에 대하여 검수·검사를 실시한다. 납품된 물품을 품목별로 정리하여 창고에 보관한다. 자전거의 특성, 가격 등을 구매자에게 소개하고 구매를 돕는다. 자전거 부품을 구비하여 고장이 났을 때 수리하거나 교체하기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"설득","workFunc3":"단순작업","dJobECd":"6151","dJobECdNm":"[6151]상점 판매원","dJobJCd":"5212","dJobJCdNm":"[5212]상점 판매원","dJobICd":"G476","dJobICdNm":"[G476]문화, 오락 및 여가 용품 소매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003801:1', '{"dJobCd":"K000003801","dJobCdSeq":"1","dJobNm":"잡화점원","workSum":"다양한 잡화를 판매하는 매장에서 고객에게 상품을 판매한다.","doWork":"맥주, 소주, 막걸리 등의 알코올성 음료와 사이다, 콜라 등의 비알코올성 음료, 과자, 빵, 사탕, 껌 등 각종 식료품을 판매한다. 비누, 치약 등과 같은 각종 일용품과 반찬거리, 채소, 과일, 담배 등을 판매한다. 고객이 구입한 상품을 포장하여 주기도 하고 배달하기도 한다. 매입·매출이나 재고상태를 파악하고 장부를 정리한다. 상점과 창고의 상태를 수시로 확인하고 관리한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"시범후 30일 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"설득","workFunc3":"단순작업","similarNm":"잡화판매원","connectJob":"담배판매원, 세제류판매원, 욕실용품판매원, 액세서리판매원, 철물판매원","dJobECd":"6151","dJobECdNm":"[6151]상점 판매원","dJobJCd":"5212","dJobJCdNm":"[5212]상점 판매원","dJobICd":"G471","dJobICdNm":"[G471]종합 소매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003652:1', '{"dJobCd":"K000003652","dJobCdSeq":"1","dJobNm":"조명기구판매원","workSum":"조명기구를 대량으로 소매업자 및 조명기구 설치자에게 판매한다.","doWork":"벽등, 천장등, 스탠드, 인테리어조명, 산업용 조명, 특수조명을 소매업자에게 대량으로 판매한다. 소매업자가 구매를 원하거나 수요가 많은 물품을 제조사에 주문한다. 납품된 물품을 취급에 주의하여 창고에 보관한다. 조도, 광도, 휘도를 고려하여 인테리어 환경에 알맞은 물품을 추천한다. 판매장부를 작성하여 재고량과 수요량, 거래내역을 파악한다. 전기에 대한 지식을 갖추어 제품설치에 조언을 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"설득","workFunc3":"단순작업","dJobECd":"6151","dJobECdNm":"[6151]상점 판매원","dJobJCd":"5212","dJobJCdNm":"[5212]상점 판매원","dJobICd":"G464","dJobICdNm":"[G464]생활용품 도매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005911:1', '{"dJobCd":"K000005911","dJobCdSeq":"1","dJobNm":"종이제품판매원","workSum":"종이제품을 대량으로 소매업자 및 주문 고객에게 판매한다.","doWork":"포장지, 복사지, 라벨지, 박스용지, 코팅지 등 여러 용도로 사용되는 종이제품을 판매한다. 소매업자나 고객에게 주문을 받아 제조사에 구매신청을 한다. 납품되는 종이제품에 대하여 검수, 검사를 실시한다. 판매장부를 기입하여 매출량, 재고량, 고객과의 거래 실적 등을 파악한다. 종이제품의 특성이나 단가 등을 파악하여 용도에 알맞은 물품을 주문하도록 한다. 제조사에서 납품되는 종이제품을 절단·부착하여 고객이 원하는 물품으로 가공한다. 고객과 물품단가, 물품수량, 거래대금방법 등에 대하여 협상하고 계약서를 작성한다. 고객이 원하는 경우에는 프린트나 색상의뢰, 추가 부속 등에 대하여 의뢰를 받아 관련 제조업체나 납품업체를 소개한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"설득","workFunc3":"단순작업","dJobECd":"6151","dJobECdNm":"[6151]상점 판매원","dJobJCd":"5212","dJobJCdNm":"[5212]상점 판매원","dJobICd":"G464","dJobICdNm":"[G464]생활용품 도매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003239:1', '{"dJobCd":"K000003239","dJobCdSeq":"1","dJobNm":"주류판매원","workSum":"주류판매점에서 주류를 도매상으로부터 구입하고 소비자에게 판매한다.","doWork":"주류의 명칭, 가격, 원산지 등을 고려하여 도매상으로부터 주문하여 구입한다. 진열대에 상품을 종류별로 진열하여 고객의 구매를 돕는다. 고객에게 제품의 특성과 다른 상품과의 차이 등의 정보를 설명하여 상품의 선택을 돕는다. 고객이 원하는 상품을 진열대에서 꺼내 보이거나 창고에서 가져다준다. 고객이 선택한 상품을 포장하여 준다. 거래가 성사되면 고객으로부터 대금을 현금으로 받아 거스름돈을 지불하거나 신용카드를 이용하여 대금을 받고 영수증을 제시한다. 판매 장부를 기록하고 재고관리를 한다. 진열상품을 보충하고 진열상품과 진열대를 청소·관리한다. 고객에게 주류의 시음을 권유하기도 한다. 고객의 요청에 따라 배달을 하기도 한다. 할인행사를 하여 이월되는 재고품을 처리하기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"설득","workFunc3":"관련없음","dJobECd":"6151","dJobECdNm":"[6151]상점 판매원","dJobJCd":"5212","dJobJCdNm":"[5212]상점 판매원","dJobICd":"G472","dJobICdNm":"[G472]음ㆍ식료품 및 담배 소매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003027:1', '{"dJobCd":"K000003027","dJobCdSeq":"1","dJobNm":"주방용품판매원","workSum":"가정용 식기 및 주방용품을 소비자에게 판매한다.","doWork":"커피잔, 머그잔, 접시, 찬기, 주기, 다기 등 가정용 식기와 칼, 도마, 수저 등 주방용품을 판매한다. 도매업체나 제조업체, 유통업체로부터 물품을 주문하여 구입한다. 물품의 특성이나 가격, 신상품 출시 등에 대하여 숙지한다. 납품된 물품을 취급에 주의하며 정리하여 보관한다. 진열대에 종류별로 전시한다. 고객이 원하는 상품을 진열대에서 꺼내 보이거나 창고에서 가져다준다. 고객에게 물품 선택에 대해 조언을 한다. 고객이 선택한 상품을 포장하여 준다. 거래가 성사되면 고객으로부터 대금을 받아 거스름돈을 지불하거나 신용카드를 이용하여 대금을 처리하고 영수증을 제시한다. 주방용품 사용에 대한 지식을 갖추어 물품의 불편한 점과 편리한 점을 고객에게 설명한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"설득","workFunc3":"단순작업","connectJob":"식기류판매원","dJobECd":"6151","dJobECdNm":"[6151]상점 판매원","dJobJCd":"5212","dJobJCdNm":"[5212]상점 판매원","dJobICd":"G475","dJobICdNm":"[G475]기타 생활용품 소매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006308:1', '{"dJobCd":"K000006308","dJobCdSeq":"1","dJobNm":"중고물품판매원","workSum":"공공기관 및 민간으로부터 중고 물품을 매입하여 재활용 가능한 물품의 부품교체 및 수리작업을 하여 소비자에게 재판매한다.","doWork":"소비자로부터 또는 공공기관으로부터 전화, 인터넷, 방문을 통해 중고물품을 접수받는다. 접수받은 장소로 이동하여 물품(사무용기구, 사무용기기, 가전제품, 일반가구, OA기기 등)을 수거 및 매입한다. 제품의 손상 여부를 판단하여 부품교체 및 수리를 한다. 물건 가격을 다시 산정하여 매장에 진열한다. 판매할 제품을 차량을 통해 운반하기도 한다. 판매한 제품에 대해 일정기간 보증하는 업무를 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"설득","workFunc3":"단순작업","similarNm":"재활용물품판매원","connectJob":"판매하는 중고제품에 따라 중고가구판매원, 중고가전제품판매원, 중고사무기기판매원","dJobECd":"6151","dJobECdNm":"[6151]상점 판매원","dJobJCd":"5212","dJobJCdNm":"[5212]상점 판매원","dJobICd":"G478","dJobICdNm":"[G478]기타 상품 전문 소매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006240:1', '{"dJobCd":"K000006240","dJobCdSeq":"1","dJobNm":"지물판매원","workSum":"장판지·벽지·창호지 등의 각종 지물류 및 비닐장판 등을 판매한다.","doWork":"소비자의 요청이나 수요량 등을 고려하여 제조회사, 대형대리점 등으로부터 지물류를 구입한다. 고객이 상점에 방문 시 영접하고 고객에게 지물류의 정보를 제공하여 고객의 선택을 돕는다. 거래가 성사되면 고객으로부터 대금을 현금으로 받아 거스름돈을 지불하거나 신용카드를 이용하여 대금을 받고 영수증을 제시한다. 고객이 구입한 상품을 포장하여 주기도 하고 배달하기도 한다. 매입·매출이나 재고상태를 파악하고 장부를 정리한다. 상점과 창고의 상태를 수시로 확인하고 관리한다. 고객의 요청에 따라 벽지를 바르거나 장판을 깔아주기도 하고, 도배공이나 기타 인부를 소개해 주기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"설득","workFunc3":"단순작업","similarNm":"벽지판매원","certLic":"도배기능사","dJobECd":"6151","dJobECdNm":"[6151]상점 판매원","dJobJCd":"5212","dJobJCdNm":"[5212]상점 판매원","dJobICd":"G475","dJobICdNm":"[G475]기타 생활용품 소매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002547:1', '{"dJobCd":"K000002547","dJobCdSeq":"1","dJobNm":"직물제품판매원","workSum":"직물 제품을 소비자에게 판매한다.","doWork":"제조공장이나 유통업체를 통하여 직물 제품을 구매한다. 구매한 직물을 소비자가 필요한 단위로 절단하여 판매한다. 재질, 색상, 디자인 등 물품의 특성이나 가격에 대하여 숙지하여 고객이 필요한 물품을 찾고 구매에 도움을 준다. 판매장부를 작성하고 판매량과 재고량을 파악한다. 납품되는 물품에 대하여 검수한다. 습기, 직사광선을 피하여 물품을 창고에 보관한다. 고객이 원하는 장소, 시간에 배달하여 납품한다. 제조사와 납품 방법, 수량, 결제방법, 결제일에 대하여 협의한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"설득","workFunc3":"단순작업","similarNm":"직물판매원","dJobECd":"6151","dJobECdNm":"[6151]상점 판매원","dJobJCd":"5212","dJobJCdNm":"[5212]상점 판매원","dJobICd":"G467","dJobICdNm":"[G467]기타 전문 도매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002837:1', '{"dJobCd":"K000002837","dJobCdSeq":"1","dJobNm":"청과물판매원","workSum":"청과물을 원산지나 도매상으로부터 구입하여 소비자에게 판매한다.","doWork":"청과물의 외형과 맛을 고려하여 원산지나 도매상부터 청과물을 구입한다. 청과물을 정리하여 진열대에 진열하고 냉장고 등에 보관한다. 고객에게 원산지, 상태 등의 정보를 제공하여 상품의 선택을 돕는다. 거래가 성사되면 고객으로부터 현금이나 신용카드로 대금을 지급받고 영수증을 발급해준다. 매입·매출과 재고 등을 장부에 기록하고 확인한다. 고객의 요청에 따라 상품을 포장하고 배달한다. 수시로 상품과 냉장고의 상태를 확인하여 신선도를 유지하고 상품의 변질을 방지한다. 때에 따라 고객에게 시식을 권유하거나 상품을 씻고 자르기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"시범후 30일 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workFunc1":"비교","workFunc2":"설득","workFunc3":"단순작업","connectJob":"과일판매원, 채소판매원","dJobECd":"6151","dJobECdNm":"[6151]상점 판매원","dJobJCd":"5212","dJobJCdNm":"[5212]상점 판매원","dJobICd":"G472","dJobICdNm":"[G472]음ㆍ식료품 및 담배 소매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006069:1', '{"dJobCd":"K000006069","dJobCdSeq":"1","dJobNm":"침구판매원","workSum":"침구용품(베개, 이불, 침대커버, 소파커버, 테이블보 등)이나 커튼(봉, 레일, 링, 레이스, 고리, 원단 등)을 소비자에게 판매한다.","doWork":"제품의 특성을 파악하고 명칭과 가격 등 제품과 관련된 사항을 숙지한다. 소비자의 요청이나 수요량 등을 고려하여 제조회사 등으로부터 주문하여 구입한다. 디자인 샘플을 준비하고 진열대에 물품을 전시한다. 고객이 원하는 상품을 꺼내어 보여준다. 원단과 디자인의 장·단점을 조언하며 고객의 취향에 맞게 선택하도록 한다. 고객이 원하는 경우에는 원단, 디자인을 파악하여 도매업체이나 제조공장에 주문하여 판매한다. 장부를 정리하여 매입·매출내역과 거래내역을 파악하며 물품의 재고상태를 파악하고 필요한 재료를 도매업체에 주문·구매하여 수령한다. 물품에 대한 계산을 하여 대금을 받고 영수증을 준다. 신용카드의 경우 판독기를 통하여 결제확인을 하고 대금 입력 후 영수증에 서명을 받는다. 고객이 원하는 장소에 방문하여 직접 설치하기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"시범후 30일 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"설득","workFunc3":"단순작업","dJobECd":"6151","dJobECdNm":"[6151]상점 판매원","dJobJCd":"5212","dJobJCdNm":"[5212]상점 판매원","dJobICd":"G474","dJobICdNm":"[G474]섬유, 의복, 신발 및 가죽제품 소매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005646:1', '{"dJobCd":"K000005646","dJobCdSeq":"1","dJobNm":"컴퓨터판매원","workSum":"컴퓨터 본체나 모니터, 키보드, 소프트웨어 등과 관련 소모품 등을 소비자에게 판매한다.","doWork":"컴퓨터 본체나 모니터, 키보드, 소프트웨어 등과 관련 소모품 등을 제조사별로 매장에 진열한다. 각 사양별 특징과 가격대, 성능, 제조사별 특징 등을 설명서를 통해 설명하여 소비자의 구매를 돕는다. 소비자가 요구한 패키지상품이나 조립사양을 검토하여 견적을 산출하고 조정한다. 컴퓨터와 관련한 스캐너, 프린터기 등의 제품을 설명한다. 컴퓨터 작동을 위한 운영체제와 응용프로그램 등을 설치하고 제품의 안정성을 테스트한다. 소비자가 원하는 시간과 장소에 배달·설치하고 작동상태를 확인한다. 컴퓨터와 관련된 사무용지, 잉크 및 토너, 소모성 부품, 게임이나 사무 관련 소프트웨어를 판매한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"설득","workFunc3":"관련없음","connectJob":"컴퓨터부품판매원","dJobECd":"6151","dJobECdNm":"[6151]상점 판매원","dJobJCd":"5212","dJobJCdNm":"[5212]상점 판매원","dJobICd":"G473","dJobICdNm":"[G473]가전제품 및 정보통신장비 소매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005009:1', '{"dJobCd":"K000005009","dJobCdSeq":"1","dJobNm":"타이어판매원","workSum":"소비자가 요구하는 신품 또는 재생타이어 및 휠을 판매한다.","doWork":"소비자의 차량 제원을 확인하고, 부합하는 상품의 특징과 장·단점을 설명하여 소비자의 선택을 돕는다. 휠에서 헌 타이어를 탈거하고 새 타이어를 장착한다. 휠평형시험원 또는 정비원에 의뢰하여 휠 평형을 점검하여 평형이 맞지 않을 경우 조정한 후 차량에 장착한다. 진열된 상품의 재고를 파악하여 모업체 또는 제조업체로부터 주문한다. 재생타이어를 판매하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"설득","workFunc3":"단순작업","dJobECd":"6151","dJobECdNm":"[6151]상점 판매원","dJobJCd":"5212","dJobJCdNm":"[5212]상점 판매원","dJobICd":"G452","dJobICdNm":"[G452]자동차 부품 및 내장품 판매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006515:1', '{"dJobCd":"K000006515","dJobCdSeq":"1","dJobNm":"퍼스널쇼퍼","workSum":"고객의 직업, 나이, 체형, 구매성향, 스타일, 경제수준 등을 종합적으로 파악하여 고객에게 가장 적합한 상품을 추천한다.","doWork":"전화로 VIP 고객들의 방문예약을 받거나 쇼핑을 부탁받는다. 고객이 요구하는 상품의 종류(옷, 보석, 화장품, 여행상품, 웨딩 등)를 예약한다. 고객의 직업, 구매성향, 선호브랜드, 스타일 등을 파악한다. 고객 방문을 예약할 때는 고객의 정보를 바탕으로 추천할 몇 가지 상품들에 대해 각 매장의 브랜드 매니저와 상의하여 결정한다. 점심계획이 있는 고객에게는 식당을 예약해 둔다. 쇼핑 부탁을 받은 경우 고객이 원하는 상품들을 대신 구매한다. 고객이 방문하기로 한 당일에는 방문할 고객목록을 파악하여 고객이 원하는 상품들의 준비상태를 확인한다. 방문시간 전에 고객에게 방문 확인 전화를 하고 도착할 때를 기다려 마중한다. 준비된 상품들을 설명하기 위해 고객과 함께 매장을 둘러보며 상품선택에 대해 상담 및 조언을 한다. 고객의 상품구매가 끝나면 구매한 상품을 고객의 차까지 운반해 준다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"수집","workFunc2":"설득","workFunc3":"단순작업","similarNm":"Personal Shopper","connectJob":"백화점컨시어지, 기프트어드바이저","dJobECd":"6151","dJobECdNm":"[6151]상점 판매원","dJobJCd":"5212","dJobJCdNm":"[5212]상점 판매원","dJobICd":"G471","dJobICdNm":"[G471]종합 소매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007249:1', '{"dJobCd":"K000007249","dJobCdSeq":"1","dJobNm":"편의점판매원","workSum":"편의점에서 소비자에게 물품을 판매한다.","doWork":"소비자에게 편의점에 구비된 물품을 판매한다. 물품의 수요와 재고를 파악하여 회사에 주문한다. 회사에서 운송되는 물품을 검수, 검사하고 판매대에 비치한다. 냉장·냉동 식품의 경우에는 냉장·냉동실의 온도를 수시로 확인하여 상하지 않게 한다. 판매를 촉진시키기 위하여 포스터 등의 제품 홍보물을 부착한다. 소비자에게 판매한 물품을 정산한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"시범후 30일 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"웅크림|","workFunc1":"비교","workFunc2":"설득","workFunc3":"단순작업","dJobECd":"6151","dJobECdNm":"[6151]상점 판매원","dJobJCd":"5212","dJobJCdNm":"[5212]상점 판매원","dJobICd":"G471","dJobICdNm":"[G471]종합 소매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001286:1', '{"dJobCd":"K000001286","dJobCdSeq":"1","dJobNm":"한복판매원","workSum":"전통한복, 개량한복 등의 한복 및 관련된 물품을 판매한다.","doWork":"한복의 원단과 디자인을 설명하며, 고객의 취향, 목적에 맞게 선택하도록 조언한다. 디자인 샘플을 만들어 고객의 선택에 도움을 주기도 한다. 고객의 체형을 측정한다. 재단 공장에 한복 제조를 주문한다. 필요한 원단을 주문, 구매, 비치한다. 전통의상에 대한 지식을 갖추어 고객의 구매를 돕는다. 판매량과 재고량을 파악한다. 물품에 대한 계산을 하여 대금을 받고 영수증을 준다. 완성품을 구비하여 임대하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"설득","workFunc3":"단순작업","dJobECd":"6151","dJobECdNm":"[6151]상점 판매원","dJobJCd":"5212","dJobJCdNm":"[5212]상점 판매원","dJobICd":"G474","dJobICdNm":"[G474]섬유, 의복, 신발 및 가죽제품 소매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006108:1', '{"dJobCd":"K000006108","dJobCdSeq":"1","dJobNm":"한약재판매원","workSum":"녹용, 인삼, 감초, 꿀, 오미자, 영지버섯 등의 각종 한약재를 판매한다.","doWork":"약초채집인, 동물수렵인 등으로부터 감초, 인삼, 웅담, 사향, 우황, 계피, 갈근, 방풍, 길경, 오미자, 복령, 황기 등의 각종 한약재의 약효를 감정한 후 구매한다. 한약방, 한약건재상 등에 대량으로 판매하거나 소비자에게 소매로 소량 판매한다. 고객이 원하는 한약재나 한약방에서 처방된 한약재를 처방전에 맞추어 판매한다. 복용법과 유의사항에 대하여 조언한다. 한약재의 특성과 약효 등을 고려하여 보관에 유의한다. 고객이 구입한 상품을 포장하여 주기도 하고 배달하기도 한다. 매입·매출이나 재고상태를 파악하고 장부를 정리한다. 상점과 창고의 상태를 수시로 확인하고 관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"설득","workFunc3":"관련없음","certLic":"한약업자","dJobECd":"6151","dJobECdNm":"[6151]상점 판매원","dJobJCd":"5212","dJobJCdNm":"[5212]상점 판매원","dJobICd":"G472","dJobICdNm":"[G472]음ㆍ식료품 및 담배 소매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007276:1', '{"dJobCd":"K000007276","dJobCdSeq":"1","dJobNm":"화장품판매원","workSum":"화장품, 비누, 향수 등 미용에 관련된 제품을 소비자에게 판매한다.","doWork":"물품의 수요와 재고를 파악하여 도매업체로부터 구입하고 장부를 정리한다. 납품된 물품을 종류, 용도별로 판매대에 찾기 쉽도록 비치한다. 제품의 특성, 차이점과 가격 등을 숙지하여 고객의 취향, 용도에 맞게 물품을 선택하도록 돕는다. 고객에게 화장법이나 미용법을 권유하여 판매를 촉진시킨다. 소비자가 구입한 물품의 가격을 계산기로 계산하여 대금을 받고 영수증을 준다. 신용카드의 경우 판독기를 통하여 결제확인을 하고 대금입력 후 영수증에 서명을 받는다. 고객이 원할 경우에는 제품을 포장하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"설득","workFunc3":"단순작업","dJobECd":"6151","dJobECdNm":"[6151]상점 판매원","dJobJCd":"5212","dJobJCdNm":"[5212]상점 판매원","dJobICd":"G478","dJobICdNm":"[G478]기타 상품 전문 소매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001274:1', '{"dJobCd":"K000001274","dJobCdSeq":"1","dJobNm":"경주권발매원","workSum":"경마장, 경륜장, 경정장에서 고객이 제시한 구매표를 전산처리하여 마권 또는 경주권을 발매하고 적중된 마권 및 경주권에 대한 환급금을 지급한다.","doWork":"당일 예상되는 환전액에 해당하는 금액을 관련 부서에서 수령한다. 고객이 제시한 구매표를 판독기로 전산처리하여 각종 마권 및 경주권을 발매한다. 발매한 마권 또는 경주권의 액면금액과 대금이 일치하는지 확인한다. 경주가 종결되면 고객이 제시한 적중마권 또는 경주권을 판독기에 삽입한다. 컴퓨터시스템의 산정프로그램에 따른 환급금의 계산결과를 고객에게 확인시키고 환급금을 지급한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"계산","workFunc2":"서비스제공","workFunc3":"단순작업","similarNm":"마권발매원, 경륜권발매원, 경정권발매원","dJobECd":"6162","dJobECdNm":"[6162]매표원 및 복권 판매원","dJobJCd":"5213","dJobJCdNm":"[5213]매표원 및 복권 판매원","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;