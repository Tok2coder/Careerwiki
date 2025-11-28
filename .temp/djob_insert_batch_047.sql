INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006691:1', '{"dJobCd":"K000006691","dJobCdSeq":"1","dJobNm":"누비질반장","workSum":"침구류, 장갑, 이불 등의 제품에 사용되는 천을 누비질하는 데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"기계를 검사하여 정상작동 여부를 점검한다. 누비질한 부위를 관찰하여 끊어진 실, 고르지 못한 가장자리 등의 결함이 있는지 검사한다. 작업의 진행사항을 파악하고 작업내용을 보고한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원 및 낡거나 부러진 바늘 등의 자재를 공급한다. 작업계획에 따라 세부실행항목을 수립하고 작업절차 및 방법을 결정하여 작업원에게 작업내용을 지시하고 작업배치를 한다. 표준작업명세에 따라 지시된 작업이 이루어지는지 작업원과 함께 작업하며 작업상황을 관찰하고 작업내용을 점검한다. 작업원의 직무교육 및 안전위생교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴·해결하고 문제점을 보완한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C139","dJobICdNm":"[C139]기타 섬유제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002202:1', '{"dJobCd":"K000002202","dJobCdSeq":"1","dJobNm":"단일바늘터프팅기조작원","workSum":"융단을 만들기 위해 실을 부품에 심어 짜는 단일바늘을 가진 단일바늘 터프팅기계(Tufting Machine)를 조작한다.","doWork":"작업지시서를 확인하고 융단 표면모양 및 색상 등을 확인한다. 자수기의 작동상태를 확인하고 생산에 필요한 자재를 색상별로 수령한다. 측정테이프, 표시연필, 융단 패턴 등을 사용하여 안감에 융단의 치수 및 윤곽을 표시한다. 크릴스핀들(Creel Spindle) 위에 방사실타래를 설치하고 가이드·장력장치와 바늘 눈을 통해 실 끝을 당긴다. 기계입구에 안감 롤을 놓고 안감의 한쪽 끝을 권취롤러에 끼운다. 버튼과 레버를 눌러 기계를 작동하고 실을 넣어 한 줄로 술을 만든다. 술 제조공정을 관찰하고 기능장애 및 사절상태를 확인한다. 끊어진 실을 바늘에 다시 끼우거나 기능장애가 발생하면 수리를 의뢰한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"유지","similarNm":"단일바늘터프팅원","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C139","dJobICdNm":"[C139]기타 섬유제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004859:1', '{"dJobCd":"K000004859","dJobCdSeq":"1","dJobNm":"래핑원","workSum":"경편직기의 준비과정으로 짜던 실과 교환된 빔의 실을 서로 이어 코(Loop)를 만든다.","doWork":"통경이 완료된 가이드 바(Guide Bar)를 물림대에 끼운다. 여러 개의 빔을 서로 밀착시켜 일정속도로 회전할수 있도록 수동공구를 사용하여 볼트를 조인다. 자동송출 게이지를 조정하여 최종 가동위치에 놓는다. 기계를 서서히 작동하여 코를 만든다. 짜인 편직물을 관찰하여 코가 빠진 부분을 손이나 실 꿰는 바늘을 사용하여 수정한다. 장력조절장치를 돌려 일정 장력이 되게 재조정한다. 풀리는 실의 속도를 일정하게 하기 위해 자동송출장치를 빔에 연결한다. 편직기계의 편성침이나 포인트(Point)를 교체하고 일정간격으로 사이를 띄어 정렬하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"투입인출","similarNm":"코성형원","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C133","dJobICdNm":"[C133]편조원단 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004146:1', '{"dJobCd":"K000004146","dJobCdSeq":"1","dJobNm":"롤회전원","workSum":"편물 옷감을 뒤집어서 롤에 감거나 회전하는 기계를 조작한다.","doWork":"옷감 끝을 회전파이프를 통해 당긴다. 회전파이프와 회전연전기를 통해 옷감 끝을 펼치고 당긴다. 공급롤러 아래로 회전된 천의 끝을 끼우고 권취롤러에 감는다. 레버를 들어 올려 공급 및 권취롤러를 작동한다. 스탠드 위에 편직된 옷감의 롤을 설치하고 회전된 롤을 꺼내기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"시범후 30일 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C133","dJobICdNm":"[C133]편조원단 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006592:1', '{"dJobCd":"K000006592","dJobCdSeq":"1","dJobNm":"문전원","workSum":"어망을 제조하기 위해 북실(밑실)을 감는 기계를 조작한다.","doWork":"실패를 크릴(Creel)에 꽂는다. 빈 북을 고정하고 보빈에서 실 끝을 찾아 안내대를 통과시켜 빈 북에 실이 감기는 것을 확인하여 끊어진 실을 잇는다. 북에 실이 가득차면 기계를 정지하고 칼이나 가위로 실을 잘라 전기인두를 사용하여 실 끝이 풀어지지 않게 마무리한다. 실이 감긴 북을 기계로부터 떼어내고 운반수레에 담는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C139","dJobICdNm":"[C139]기타 섬유제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003037:1', '{"dJobCd":"K000003037","dJobCdSeq":"1","dJobNm":"문지원","workSum":"무늬도면에 따라 자카드 직조기계의 패턴카드에 구멍을 뚫는 기계를 조작한다.","doWork":"기계 전면의 작업대에 무늬도면을 펼쳐 고정하고 천공기 아래 가이드에 재료가 되는 패턴카드를 놓는다. 디자인의 첫 번째 표시 선에 자동표시기를 맞춘다. 천공기를 시동하기 위해 클러치를 맞물린다. 무늬도면에 나타난 구멍의 배열에 따라 절단금형을 조절하는 키를 누른다. 구멍이 뚫어진 카드와 패턴을 비교하여 절단상 결함이 있는지 살펴보고 잘못 뚫어진 구멍 위에는 네모난 종이를 붙인다. 천공된 문지를 번호별로 구분·정리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"문지천공원, 문지펀칭원, 패턴카드제작원","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C132/C133","dJobICdNm":"[C132]직물직조 및 직물제품 제조업 / [C133]편조원단 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004805:1', '{"dJobCd":"K000004805","dJobCdSeq":"1","dJobNm":"문지제작반장","workSum":"무늬 직조작업을 조절하는 데 사용되는 패턴카드를 절단하여 엮어 짜고 복사하는 일에 종사하는 작업원의 활동을 감독·조정한다.","doWork":"생산계획에 맞는 패턴체인(Pattern Chain)의 수효를 결정하기 위해 고객의 주문서와 직물 조직도를 분석한다. 분석된 자료 및 생산량 등에 의해 생산계획을 수립하고 작업내용을 작업원에게 지시한다. 작업도구의 이상 유무를 확인하고 안전교육을 실시한다. 패턴체인을 자르고 엮어 짜기 위해 작업원을 지도한다. 작업원에게 절단, 복사 등 기계조작에 관한 훈련을 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C133","dJobICdNm":"[C133]편조원단 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005548:1', '{"dJobCd":"K000005548","dJobCdSeq":"1","dJobNm":"부직포결합원","workSum":"결속력이 없는 부직포를 직물로 결속하거나 결합한다.","doWork":"소면기를 사용하여 섬유를 일정두께로 배열한다. 양각된 롤을 시동하고, 결속에 알맞은 압력 및 열을 롤에 가하기 위해 핸들이나 밸브를 돌려 게이지(Gauge)를 조정한다. 배열된 섬유를 롤에 투입하여 결속한다. 접착력을 갖는 액상의 수지를 바르거나 스프레이(Spray)로 배합된 수지를 분사하고 건조하여 결속한다. 침봉의 침의 밀도, 깊이, 종류 등을 조정하고 침봉을 회전시킨다. 회전되는 침봉으로 섬유를 투입하여 누벼 결합한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C139","dJobICdNm":"[C139]기타 섬유제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002036:1', '{"dJobCd":"K000002036","dJobCdSeq":"1","dJobNm":"빔걸이원","workSum":"직조의 준비과정으로 경사 끝을 묶어 직조기에 있는 경사의 끝과 일치되도록 실 끝을 정돈한다.","doWork":"잭(Jack)을 사용하여 직조기에 빔을 건다. 직조기의 한쪽 경사와 다른 쪽 끝을 분리하고 사침가닥을 끼워 각 가닥들의 위치가 바뀌지 않도록 한다. 끊어진 실 끝을 잇는다. 빔을 직기에 설치하여 바디와 종광을 기계장치에 끼우고 전체 경사를 앞으로 당겨 장력을 고르게 하고 순간가동과 시험가동을 하여 경사의 장력을 맞춘다. 빈 빔을 소제하며 기계에 기름을 친다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"등기원, 상대원","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C132","dJobICdNm":"[C132]직물직조 및 직물제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001239:1', '{"dJobCd":"K000001239","dJobCdSeq":"1","dJobNm":"사침원","workSum":"통경작업이 쉽도록 일정하게 배열된 경사 가닥을 분리하여 사침을 끼우고 일정 가닥으로 묶는다.","doWork":"경사빔을 작업대에 끼운다. 사침대 위로 경사의 끝을 당기고 막대를 돌려 경사가 팽팽하게 당겨지도록 한다. 작업대 위의 경사를 가이드와 바늘을 거쳐 기계에 꿴다. 경사를 올리고 내려 실이 엉키는 것을 방지한다. 빔에 일정한 길이의 경사가 감겼는지 확인하기 위해 경사빔을 뒤집어 실 끝을 테이프로 붙인다. 작업대에서 호이스트로 경사빔을 도핑한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","similarNm":"리이징(Leasing)원","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C132","dJobICdNm":"[C132]직물직조 및 직물제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002768:1', '{"dJobCd":"K000002768","dJobCdSeq":"1","dJobNm":"생지검사반장","workSum":"직편물을 염색하거나 가공하기 전에 직물을 검사하는 데 종사하는 생지검사원의 활동을 감독·조정한다.","doWork":"생지의 수분점검 목록표 등의 검사항목을 파악하고 검사장비 등을 확인한다. 생지의 종류에 따라 색상, 작업 기간, 작업방법 등을 고려하여 적재하고 생산공정의 균형을 맞추어 검사계획 및 세부검사항목을 수립하고 생지를 투입한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원 및 자재를 공급한다. 생지의 중량검사, 사양검사, 외관검사 등을 통하여 발생된 문제점을 기록하고 제작공정으로 통보한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","certLic":"섬유산업기사","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C132/C134","dJobICdNm":"[C132]직물직조 및 직물제품 제조업 / [C134]섬유제품 염색, 정리 및 마무리 가공업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006216:1', '{"dJobCd":"K000006216","dJobCdSeq":"1","dJobNm":"생지검사원","workSum":"직편물을 염색하거나 가공하기 전에 직편물을 검사·수정한다.","doWork":"작업기준표를 검토하여 생지와 품명을 대조·확인한다. 발 페달을 밟아 검사대 위로 통과하는 직물을 관찰하여 생지의 폭, 밀도, 결점 등을 분필로 표시하거나 스티커를 부착한다. 검사된 생지를 수정하거나 가위로 절단하고 검사기록표에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C132/C134","dJobICdNm":"[C132]직물직조 및 직물제품 제조업 / [C134]섬유제품 염색, 정리 및 마무리 가공업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004808:1', '{"dJobCd":"K000004808","dJobCdSeq":"1","dJobNm":"선염정경원","workSum":"제직에 필요한 복합색의 경사를 만들기 위해 실 꾸러미의 실을 크릴로, 크릴에서 직기 빔으로 옮겨 감는 기계를 조작한다.","doWork":"크릴 앞에 이동용 릴을 놓고 지시된 조직설계에 따라 크릴 위의 실 꾸러미에서 실 끝을 뽑는다. 실 끝을 고리에 묶어 갈고리에 꿰어 실을 감는 동안 실 끝이 빠지지 않도록 한다. 일정 길이의 실이 다 감겼을 때 기계를 정지하고 실 길이 계수기를 맞춘다. 제직하기에 알맞은 위치에 실을 균일하게 배열하기 위해 감는 부분에 사침대를 끼운다. 가위로 실을 잘라 실 끝을 감는 장치 아래에 놓고 실 끝이 풀어지지 않도록 한다. 호이스트를 이용하여 직기 빔을 설치하고 실 끝을 빔에 고정한다. 레버를 당겨 릴을 회전시키고 버튼을 눌러 실이 빔에 감기도록 한다. 호이스트로 다 감긴 직기 빔을 빼낸다. 기계에 호부장치가 부착된 경우 건조통의 온도를 조절하고 호부액을 채우기 위해 밸브를 돌리기도 한다. 크릴기계를 조작하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"선염용정경대지원","certLic":"설비보전기능사","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C132","dJobICdNm":"[C132]직물직조 및 직물제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002297:1', '{"dJobCd":"K000002297","dJobCdSeq":"1","dJobNm":"세폭직물직조기조작원","workSum":"리본이나 테이프 등 폭이 좁은 직물을 일정한 폭과 길이로 짜는 직조기를 조작한다.","doWork":"기계를 관찰하면서 소모된 위사 꾸러미를 새것으로 교환한다. 이상이 있는 북이나 장력스프링, 북귀 등을 손 공구를 사용하여 갈아 끼운다. 실이 끊어지는 등의 문제가 발생하면 직조기를 자동으로 정지시키는 자동정지장치가 부착된 직조기를 조작하기도 한다. 경사를 뽑아내는 통경원의 일을 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"세폭직물직조원","connectJob":"리본직조원, 테이프직조원","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C139","dJobICdNm":"[C139]기타 섬유제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002571:1', '{"dJobCd":"K000002571","dJobCdSeq":"1","dJobNm":"스타킹편직원","workSum":"발과 다리모양에 맞추어 스타킹을 짜는 편물기계를 조작한다.","doWork":"작업지시서에 따라 원하는 디자인, 스타일의 스타킹을 생산하기 위해 원통형 편직기를 점검한다. 연사 또는 커버링된 원사보빈을 실걸이에 끼우고 실 끝을 각 급사구를 통해 편물위치에 도달할 수 있게 홀(Hole)에 끼운다. 수동핸들을 돌려 실이 편성 침에 걸려 편성물이 짜이도록 한다. 패턴체인을 돌려 시작위치에 놓고 스위치를 눌러 기계를 가동한다. 편물하는 동안 천을 팽팽히 유지하는 흡입장치를 가동한다. 짜인 스타킹을 운반용 용기에 담는다. 수동공구를 사용하여 낡은 바늘, 싱커 등을 교체한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"섬유산업기사","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C144","dJobICdNm":"[C144]의복 액세서리 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001367:1', '{"dJobCd":"K000001367","dJobCdSeq":"1","dJobNm":"양말성형기조정원","workSum":"편직된 양말의 모양을 만들고 건조하는 기계를 조작한다.","doWork":"염색 및 탈수, 건조과정을 거친 양말을 족형에 끼워 열과 압력을 가하는 양말성형기를 조작한다. 작업지시서를 보고 기계 각 부위를 점검하고 증기의 압력과 온도를 조절한다. 건조실을 나와 자동으로 양말을 벗기는 장치로 운반하는 컨베이어를 가동한다. 양말이 성형되어 나오는 과정을 관찰하고 기계를 재조절한다. 렌치 등의 공구를 사용하여 편직된 양말의 크기에 따라 건조실과 성형실의 증기압력, 온도를 조절한다. 양말이 투입되는 과정과 성형, 건조되어 나오는 양말을 점검하고 수동공구를 사용하여 파손되거나 마모된 부품을 교체하기도 한다. 성형이 완료된 제품을 검사 및 포장 공정으로 이송시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"양말성형기조작원","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C144","dJobICdNm":"[C144]의복 액세서리 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006591:1', '{"dJobCd":"K000006591","dJobCdSeq":"1","dJobNm":"양말제조반장","workSum":"양말을 짜고, 염색하고, 완성하는 데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"표준작업명세서에 따라 작업절차 및 방법을 결정하고 작업원에게 작업내용을 지시·배치하고 작업상황을 관리 감독한다. 작업공정의 기술적인 내용을 교육, 지원하고 원활하게 자재를 공급한다. 표준작업명세에 따라 지시된 작업이 이루어지는지 작업원과 함께 작업하며 작업상황을 관찰하며 작업내용을 점검한다. 작업원의 직무교육 및 안전위생교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴·해결하고 문제점을 보완한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","certLic":"섬유산업기사","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C144","dJobICdNm":"[C144]의복 액세서리 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002605:1', '{"dJobCd":"K000002605","dJobCdSeq":"1","dJobNm":"양말편직원","workSum":"양말편직기계의 작동상태를 관찰하고 고장난 부분을 수리하거나 원하는 형태의 편직물을 제조하는 편직기를 조작한다.","doWork":"품종별 작업명세서에 따라 양말편직기를 선택하고 기계의 상태 및 이상 유무를 점검한다. 디자인과 특성에 맞는 원사를 공급받아 교환한다. 기계의 캠, 체인 등을 조정하고 실이 감긴 실패를 실패대 위에 올려놓는다. 실 끝을 바늘귀에 꿰고 기계를 작동한다. 기계의 작동을 관찰하고 잘못 작동하는 것이 있으면 편직기수리원에게 알린다. 편직된 양말을 검사하여 구멍, 세로풀리기 등의 결함이 있는지를 확인한다. 명세서와 비교하여 불합격품을 분류하여 합격품은 봉제처리과정 등 다음 공정으로 이송시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"양말편기조정원, 양말편기패턴교환원","certLic":"섬유산업기사","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C144","dJobICdNm":"[C144]의복 액세서리 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001904:1', '{"dJobCd":"K000001904","dJobCdSeq":"1","dJobNm":"연경원","workSum":"동일한 직물을 계속하여 제직하는 경우 경사빔으로부터 제직이 끝난 마지막 부분과 새로운 경사빔의 경사를 연결하는 휴대용 또는 고정된 자동연경기계를 조작하거나 손으로 잇는다.","doWork":"제직이 끝난 경사빔과 새 경사빔의 경사 끝을 가르고, 빗질하고, 가지런히 하고 경사연화제를 바르며 그 끝을 기계의 연결할 위치에 놓는다. 기계를 시동하기 위해 버튼을 누르거나 크랭크를 돌린다. 기계에서 경사빔과 직기빔에 서로 맞는 실이 자동으로 연결되고 매듭 위로 나오는 실이 잘라지는 연경공정을 관찰하고 조절한다. 기계를 멈추고 경사의 배열이 잘못된 것은 고치고 연결된 실을 떼어낸다. 기계에 의해 연결되지 않은 것을 손으로 잇는다. 직조기가 작동할 때 매듭이 풀어지고 절단되는 것을 막기 위해 종광, 바디를 통해 경사를 잡아당기기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"연경기조작원, 타잉(Tying)원","certLic":"섬유산업기사","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C132","dJobICdNm":"[C132]직물직조 및 직물제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004788:1', '{"dJobCd":"K000004788","dJobCdSeq":"1","dJobNm":"원사투입원","workSum":"경편물을 제조하고자 원사를 크릴에 끼운다.","doWork":"입고된 포장상자를 풀어서 현장의 온도 및 습도에 적응되도록 일정 시간 방치한다. 지정된 수량에 따라 원사보빈을 크릴에 끼운다. 원사를 교환한다. 작업지시서와 동일한 작업이 수행되고 있는지 감시한다. 일일 작업량 및 작업내용을 작업일지에 기록한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C133","dJobICdNm":"[C133]편조원단 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005215:1', '{"dJobCd":"K000005215","dJobCdSeq":"1","dJobNm":"위관운반원","workSum":"위권기에서 콘이나 치즈 형태로 실이 감긴 목관인 위관(Pirn)을 운반한다.","doWork":"위권기에서 일정한 크기로 위사가 감긴 위관을 빈 위관으로 교체한다. 위사가 감긴 위관을 손수레에 담아 직조공정으로 운반한다. 위관의 상태를 구분하여 불량품을 선별하거나, 위관의 소요량, 불량 개수 등을 파악하여 기록표에 기록하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C132","dJobICdNm":"[C132]직물직조 및 직물제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003712:1', '{"dJobCd":"K000003712","dJobCdSeq":"1","dJobNm":"위관잔사처리원","workSum":"직조공정에서 사용된 위관(Pirn:콘이나 치즈 형태로 실이 감긴 목관)을 위권공정으로 운반하고 위관에 붙은 이물질을 처리한다.","doWork":"직조공정에서 사용된 빈 위관을 통에 담아 기계 밖으로 운반한다. 잔사처리기를 사용하여 잔사를 위관으로부터 떼어낸다. 위관의 외관을 검사하여 사용 가능한 것과 정비할 것을 분류하기도 한다. 잔사 등 이물질 제거가 완료된 빈 위관을 일정한 장소에 적재한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C132","dJobICdNm":"[C132]직물직조 및 직물제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004031:1', '{"dJobCd":"K000004031","dJobCdSeq":"1","dJobNm":"위권반장","workSum":"직물을 짜기 위해 위사를 목관에 감는 데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"작업지시서나 직조계획에 따라 위사공급계획을 세운다. 타 부서와 협의하여 공급일정을 확인한다. 공급계획 및 일정에 따라 세부실행항목을 수립하고 작업절차 및 방법을 결정하여 작업원에게 작업내용을 지시하고 작업배치를 한다. 작업의 진행사항을 파악하고 작업내용을 보고한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원 및 자재를 공급한다. 표준작업명세에 따라 지시된 작업이 이루어지는지 작업원과 함께 작업하며 작업상황을 관찰하고 작업내용을 점검한다. 작업원의 직무교육 및 안전위생교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴·해결하고 문제점을 보완한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","certLic":"섬유산업기사","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C132","dJobICdNm":"[C132]직물직조 및 직물제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005266:1', '{"dJobCd":"K000005266","dJobCdSeq":"1","dJobNm":"위권틀보기원","workSum":"직조기의 북에 사용하기 위해 콘이나 치즈 형태의 실을 목관에 옮겨 감는 자동기계를 조작한다.","doWork":"손이나 전동호이스트로 호퍼(Hopper:분립체의 저장 및 공급장치)에 빈 실패를 담는다. 홀더에 공급 실 꾸러미를 끼우고 사도와 장력장치를 통과시켜 기계 속의 실 끝과 연결한다. 실이 끊어지지 않았는지 권사장치를 확인하고, 끊어진 경우 기계를 정지하고 실을 가이드로 다시 꿰어 잇는다. 실패에 일정한 크기로 실이 감기면 실패를 교체하여 준다. 생산량을 기록한다. 실패에 감긴 실을 확인하여 끊어진 곳이나 더러운 부분 등을 조사하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"관권대지원, 위권원","certLic":"섬유산업기사","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C132","dJobICdNm":"[C132]직물직조 및 직물제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003123:1', '{"dJobCd":"K000003123","dJobCdSeq":"1","dJobNm":"융단직조기조작원","workSum":"천연섬유나 합성섬유를 사용하여 지정된 색상과 형태, 무늬, 크기에 맞는 그물, 마직물, 융단 등을 제조하기 위해 동력직조기를 조작한다.","doWork":"북을 북집에 넣고 실이 끊어진 곳이 있는지 직조기를 검사한다. 제동장치를 풀고 레버를 당겨서 직조기를 시동한다. 실이 끊어지거나 직조상의 이상이 발생하면 직조기를 정지하고 검사하여 원인을 찾는다. 경사를 가이드와 종광을 통해 롤러와 왁스봉 위로 꿰고 끊어진 경사를 수선하기 위해 결함이 있는 위사를 제거한다. 직조기를 정지하고 빈 북을 갈아 끼운다. 모형이 바뀌면 크릴에 지정된 실패를 끼운다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"융단직조원","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C139","dJobICdNm":"[C139]기타 섬유제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003906:1', '{"dJobCd":"K000003906","dJobCdSeq":"1","dJobNm":"융단직조반장","workSum":"융단을 만들기 위해 실가공 및 제직하는데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"작업계획에 따라 세부실행항목을 수립하고 작업절차 및 방법을 결정하여 작업원에게 작업내용을 지시하고 작업배치를 한다. 기계를 검사하여 정상작동 여부를 점검한다. 직조기와 권취기를 설치하고 조정한다. 새로운 패턴을 짤 수 있도록 직조기 변경을 지시한다. 제품의 품질수준을 확인하기 위해 공정 중 또는 완성된 제품을 검사한다. 작업원의 직무교육 및 안전위생교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 기계별 생산량, 생산품종을 지시받아 각 부분에 인수·인계하고 관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","connectJob":"카펫직조반장","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C139","dJobICdNm":"[C139]기타 섬유제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001433:1', '{"dJobCd":"K000001433","dJobCdSeq":"1","dJobNm":"자동횡편직기운전원","workSum":"편직의류의 앞판, 뒤판 등 부분품을 편직하고자 동횡편직기를 조작한다.","doWork":"작업지시서를 확인하고 편직할 제품의 디자인 및 편직 패턴조직을 확인한다. 실 등의 원료를 수령하고 횡편직기의 이상 유무를 확인한다. 제품별 디자인 및 패턴 조직에 따라 제어판에 프로그램을 입력한다. 입력된 프로그램에 따라 턱 패턴, 라벤 패턴, 래킹 패턴 등 다양한 패턴의 편직물을 편직한다. 편직되는 상태를 확인하고 실 등 원료가 떨어지면 새 실을 이어준다. 편직이 완료된 편직물을 봉제 및 링킹공정 등 다음 공정으로 이송하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"컴퓨터제어횡편기, 자동횡편직기조작원","connectJob":"수동횡편직기운전원, 자카드횡편기조작원","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C133","dJobICdNm":"[C133]편조원단 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006071:1', '{"dJobCd":"K000006071","dJobCdSeq":"1","dJobNm":"자수기조작원","workSum":"직물, 의복, 양말 등의 제품에 자수를 놓는 기계를 조작한다.","doWork":"자수모양과 위치를 정하기 위해 작업지시서를 확인한다. 색상에 맞는 실을 선택하여 실패, 유도장치, 바늘귀에 꿴다. 기계의 각 부위를 점검한 후 자수카드를 기계의 판독기에 삽입한다. 견본 천을 기계의 틀에 끼우고 가동하여 시험 자수를 한다. 자수모양이 규격과 일치하면 제품을 끼워 작업한다. 직물의 경우 팽팽하게 장력을 유지시켜준다. 여러 대의 자수기계를 관리하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"기계자수사, 자수기운전원, 자수틀보기원","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C132","dJobICdNm":"[C132]직물직조 및 직물제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006470:1', '{"dJobCd":"K000006470","dJobCdSeq":"1","dJobNm":"자수카드펀치원","workSum":"직물에 자수를 놓는 데 사용하는 자수카드를 만들기 위해 의장지에 따라 직물에 자수도안을 복사하고 무늬에 따라 카드에 구멍을 뚫는 기계를 조작한다.","doWork":"자수할 직물의 두께, 조직, 밀도, 소재를 파악하여 자수밀도를 결정한다. 의장지를 작업대의 지정된 장소에 부착한다. 견본직물을 기계의 물림대에 올리고 레버를 잡아 당겨 일정한 장력을 유지한다. 견본직물의 옆단을 침판에 걸어 일정 장력으로 유지한다. 지시된 규격의 실을 기계의 크릴에 끼우고 실 끝을 찾아 바늘에 끼운다. 무늬카드를 기계의 축에 끼우고 의장지의 무늬모양에 따라 키를 이동한다. 자수된 직물견본을 조사한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"자수카드천공원","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C132","dJobICdNm":"[C132]직물직조 및 직물제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004484:1', '{"dJobCd":"K000004484","dJobCdSeq":"1","dJobNm":"자카드직조원","workSum":"여러 색의 실을 이용하여 다양한 디자인의 천을 짜는 직조기를 조작한다.","doWork":"직물이 짜이는 작업을 지켜보며 위사 꾸러미가 다 소모되었는지 패턴체인의 카드가 닳아서 직물에 결함이 있는지 알아본다. 소모된 위사 꾸러미를 바꾸고 못 쓰게 된 카드를 패턴카드교환원에게 알린다. 직물의 결함을 수정하기 위해 위사를 뽑아낸다. 같은 무늬로 계속해서 짜이도록 패턴체인과 카드 실린더를 되돌려 건다. 결함이 생긴 부위를 다시 직조하기 위해 코드(Cord)를 당긴다. 결함이 있는 북, 장력스프링 및 북을 손 공구를 사용하여 교환한다. 실이 끊어지거나 북침운동이 지정된 수효대로 짜졌을 때 직조기가 정지하는 자동 정지장치가 부착된 직조기를 조작하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C132","dJobICdNm":"[C132]직물직조 및 직물제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004034:1', '{"dJobCd":"K000004034","dJobCdSeq":"1","dJobNm":"자카드판제조원","workSum":"자동편직기계에서 무늬모양에 따라 바늘의 작동을 조절하기 위해 금속조각으로 무늬판에 있는 바늘구멍을 막는다.","doWork":"편직할 편직물의 도안을 확인하고 특정무늬의 연속체인을 만들기 위해 특정번호의 무늬판이나 카드를 골라서 연결한다. 경편직기조정원을 도와 지정된 바늘구멍 위에 금속조각을 배열하고 기계에 판을 설치한다. 판이 규정된 대로 준비되었는지 알아내기 위해 기계를 시험 작동한다. 바늘대의 간격을 맞추기 위해 빈 모형조각에 구멍을 뚫기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"패턴제조원","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C133","dJobICdNm":"[C133]편조원단 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004763:1', '{"dJobCd":"K000004763","dJobCdSeq":"1","dJobNm":"자카드편직원","workSum":"특정무늬와 도안을 가진 의류를 짜기 위해 자카드편직기계를 조작·관리한다.","doWork":"도안을 보고 편직할 무늬, 규격, 색상 등의 작업규격을 확인한다. 특정한 무늬의 체인, 펀치카드, 전자테이프 등을 설치하거나 컴퓨터에 무늬를 입력한다. 원사를 실패꽂이 위에 색상별로 배열한다. 원사를 가이드, 장력장치, 급사구를 통해 침상 사이로 빼낸다. 운반대 정지장치를 고정하고 편직물운반대의 왕복운동을 조절한다. 레버를 밀어 기계의 바늘판을 분리한다. 편물작업의 바탕을 준비하기 위해 미리 짜놓은 편물조각을 바늘에 건다. 리브(Rib)수치와 색상배열이 규정에 일치하는지 기계를 시험 가동한다. 편직한 원단의 길이, 폭, 밀도를 조사한다. 가동되는 기계 주위를 순회하며 이상이 없는지 관찰한다. 완성된 제품을 운반통 위에 정리하며 조직불량, 색상불량 등을 구분한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"자카드편직기조작원","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C133","dJobICdNm":"[C133]편조원단 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006593:1', '{"dJobCd":"K000006593","dJobCdSeq":"1","dJobNm":"전모원","workSum":"옷감의 짧은 털을 제거하거나 기모 소재, 벨벳 및 플러시 직물의 파일 길이를 균일하게 하기 위하여 전모기(샤링기:Shearing Machine)를 조작한다.","doWork":"호이스트를 사용하여 천이 감긴 롤을 기계의 공급대에 설치한다. 균일한 길이로 옷감의 표면을 자르기 위하여 길이를 세팅한다. 천의 끝단을 전모기의 롤러 사이로 투입한다. 기계를 작동하고 칼날이 바닥천을 자르지 않도록 하기 위해 천의 주름을 편다. 전모된 제품 표면을 육안으로 검사하여 이상 여부를 점검한다. 칼날을 바꾸거나 기계에 기름을 치고 청소한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"샤링원, 절모원","certLic":"섬유산업기사","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C132/C134","dJobICdNm":"[C132]직물직조 및 직물제품 제조업 / [C134]섬유제품 염색, 정리 및 마무리 가공업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001359:1', '{"dJobCd":"K000001359","dJobCdSeq":"1","dJobNm":"정경반장","workSum":"제직을 위해 실을 빔에 감아서 경사를 준비하는 데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"생산품목 및 생산량 등에 따른 작업계획에 따라 세부실행항목을 수립한다. 분석된 직물설계에 따라 실의 번수 및 감는 올수 등의 작업절차 및 방법을 결정하여 작업원에게 작업내용을 지시하고 작업배치를 한다. 작업의 진행사항을 파악하고 작업내용을 보고한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원 및 자재를 공급한다. 표준작업명세에 따라 지시된 작업이 이루어지는지 작업원과 함께 작업하며 작업상황을 관찰하고 작업내용을 점검한다. 작업원의 직무교육 및 안전위생교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴·해결하고 문제점을 보완한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C132","dJobICdNm":"[C132]직물직조 및 직물제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001975:1', '{"dJobCd":"K000001975","dJobCdSeq":"1","dJobNm":"정경원","workSum":"실을 호부, 염색, 제직, 편직하기 전에 빔 위에 자동으로 실을 감는 가속정경기를 조작한다.","doWork":"경사조직표에 따라 실의 배열이나 길이, 색깔, 실 끝의 수가 일치하는지 크릴의 실을 조사한다. 크릴의 실 끝을 뽑아 드로퍼(Dropper)와 장력장치, 측량장치, 연전장치를 거쳐 빈 경사빔에 실 끝을 꿴다. 감겨지는 실의 길이를 기록하기 위해 실 길이 계수기를 맞추고 기계를 시동한다. 실이 끊겨서 기계가 정지되었는지 알아보기 위해 작동상태를 관찰한다. 끊어진 부분은 빔을 되돌려 끊어진 곳을 찾아 잇고 불필요한 실 끝을 가위로 자른다. 빔에 일정량의 실이 감기면 기계를 정지하여 실을 가위로 자르고 실 끝에 접착테이프를 붙여 풀어지지 않도록 한다. 가득 감겨진 빔을 빼내고 새것으로 갈아 끼운다. 빔을 종이나 천으로 싸기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"정경대지원, 정경틀보기원, 정경호대원","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C132","dJobICdNm":"[C132]직물직조 및 직물제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005801:1', '{"dJobCd":"K000005801","dJobCdSeq":"1","dJobNm":"정포원","workSum":"동력 전동검사기를 사용하여 직물의 직조결함을 검사하고 다리미, 집게, 바늘, 실, 핀셋, 수놓는 장치와 가위를 사용하여 결함을 수선한다.","doWork":"롤러 위의 직물을 당겨 검사대 위에 놓고 직물의 끝을 동력을 사용하는 권취빔이나 지관에 감는다. 페달을 밟거나 버튼을 눌러서 기계를 가동하여 검사대 위로 직물을 움직이며 슬러브(Slub), 헐거운 실, 잘못 뽑은 것, 잘못된 파일 및 더러움이 있는지 직물을 살펴본다. 직물의 이상을 발견하면 기계를 정지하고 이상부위를 쪽가위로 자르고, 집게로 실과 파일을 뽑아낸다. 직물에 오염이 있을 시 솔, 세척기 혹은 분무식 세척기를 사용하여 직물로부터 오염을 제거한다. 호이스트를 사용하여 기계로부터 직물의 롤을 빼내기도 한다. 결함 부위에 분필로 표시하거나 스티커나 색실 등을 붙이기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"결정수정원, 생지수선원, 직포정리원","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C132","dJobICdNm":"[C132]직물직조 및 직물제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001958:1', '{"dJobCd":"K000001958","dJobCdSeq":"1","dJobNm":"제망반장","workSum":"끈을 사용하여 밧줄과 어망을 제조하고 수선하는 데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"작업의 진행사항을 파악하고 작업내용을 보고한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원 및 자재를 공급한다. 작업계획에 따라 세부실행항목을 수립하고 작업절차 및 방법을 결정하여 작업원에게 작업내용을 지시하고 작업배치를 한다. 표준작업명세에 따라 지시된 작업이 이루어지는지 작업원과 함께 작업하며 작업상황을 관찰하고 작업내용을 점검한다. 작업원의 직무교육 및 안전위생교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴·해결하고 문제점을 보완한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","similarNm":"편망반장","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C139","dJobICdNm":"[C139]기타 섬유제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004590:1', '{"dJobCd":"K000004590","dJobCdSeq":"1","dJobNm":"직물감기원","workSum":"가공처리 공정에 옷감을 이송하고자 천을 감는 기계를 조작한다.","doWork":"롤에 감겨 있는 천을 가이드와 롤러를 통하여 기계에 투입하거나 기계의 안내천(Leader Cloth)에 끝단을 연결한다. 수동바퀴를 돌려 천의 폭을 조절한다. 기계를 작동하여 천에 결함이 있는지 검사한다. 레버를 조작하여 천의 장력과 기계의 회전속도를 조절한다. 작업표 위에 천 길이를 기록한다. 기계에서 다 감긴 천 롤을 호이스트로 공급운반차에 올려놓거나 지게차에 올린다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C132/C134","dJobICdNm":"[C132]직물직조 및 직물제품 제조업 / [C134]섬유제품 염색, 정리 및 마무리 가공업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002954:1', '{"dJobCd":"K000002954","dJobCdSeq":"1","dJobNm":"직물검사반장","workSum":"직물의 생지검사, 중간검사, 최종검사를 하는 데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"작업계획에 따라 세부실행항목을 수립하여 작업절차 및 방법을 결정한 후 작업원이 효율적으로 작업할 수 있도록 적당한 위치에 배정하고 작업내용을 작업원에게 지시한다. 원사를 검사하고 제품 이상을 관련 부서에 연락한다. 직물의 생지검사, 중간검사, 최종검사에 대한 결과를 확인하고 폭, 길이, 밀도 등을 검사하여 기록표에 기록한다. 시험용 견본조각을 검사하고 재염, 재가공에 대한 의뢰사항을 검토하고 합격 여부를 판정한다. 작업진행상황을 파악하고 작업내용을 보고한다. 작업원의 작업상황을 관리·감독하고 작업공정에 있어 필요한 자재지원 및 기술을 지원한다. 표준명세에 따라 지시된 작업이 이루어지는지 작업원과 함께 작업하며 작업상황을 관찰하고 작업내용을 점검한다. 작업원에 대한 직무교육 및 안전위생교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시로 관찰과 면담을 통하여 작업원의 애로 및 건의사항을 수렴·해결하고 문제점을 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"조정","workFunc2":"감독","workFunc3":"수동조작","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C132","dJobICdNm":"[C132]직물직조 및 직물제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005054:1', '{"dJobCd":"K000005054","dJobCdSeq":"1","dJobNm":"직물검사원","workSum":"직물검사장치를 사용하여 직물의 가공결점을 조사하기 위해 가공되었거나 미가공된 옷감을 검사한다.","doWork":"롤러 위로 직물을 당겨 검사판 위로 내린다. 권취빔 및 지관(종이로 만든 원통) 주위에 옷감의 끝을 감고 장치 아래로 손수레를 놓는다. 길이측정계기를 원점으로 조정하고 페달 및 버튼을 눌러 자동 직물검사장치를 작동시킨다. 기름점, 슬라브, 직조상태, 염색상태 등을 점검한다. 직물의 형태와 직물길이를 기록한다. 실, 분필, 스티커 등으로 결점을 표시한다. 수선가능한 간단한 결점은 가위, 칼, 세척용제 등으로 수선하기도 한다. 호이스트를 사용하여 직물의 롤을 설치하거나 세척하기도 한다. 기록된 기준에 맞추어 직물의 질을 분류하기도 한다. 연속된 공정에서 빠져나오는 원단이 종이나 플라스틱으로 된 원통관에 감기도록 원단이 가득 감긴 관을 새 관으로 교체하기도 한다. 직물에서 견본용 조각을 절단하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"검단원","connectJob":"원단검사원, 최종직물검사원","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C132/C133","dJobICdNm":"[C132]직물직조 및 직물제품 제조업 / [C133]편조원단 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005711:1', '{"dJobCd":"K000005711","dJobCdSeq":"1","dJobNm":"직물정필원","workSum":"포장작업을 하기 전에 일정한 길이로 옷감을 접는 기계를 조작한다.","doWork":"기계 브래킷 위에 옷감의 롤을 밀어 놓고 급송롤러, 장력롤러 상·하 및 정필기의 홈을 통해 옷감을 끼운다. 기계작업대 위 꺽쇠 아래로 옷감의 끝을 삽입하고 길이측정계기를 영점으로 맞춘다. 기계를 작동하고 옷감에 솔기가 있는지 알기 위해 접는 작업을 관찰한다. 작업이 완료되면 페달을 밟아 꺽쇠를 들어 올리고 절단한 옷감을 풀어 기계에서 빼낸다. 생산작업표나 옷감에 부착된 표 위에 길이측정 수를 기록한다. 절단한 각각의 길이 치수를 알기 위해 접은 것을 산출하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"정단원","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C132/C134","dJobICdNm":"[C132]직물직조 및 직물제품 제조업 / [C134]섬유제품 염색, 정리 및 마무리 가공업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001934:1', '{"dJobCd":"K000001934","dJobCdSeq":"1","dJobNm":"직조반장","workSum":"천을 짜기 위해 직조기를 조작하는 데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"생산할 제품별, 품목별 생산량 등에 의하여 작업계획을 수립한다. 작업계획에 따라 세부실행항목을 수립하여 작업절차 및 방법을 결정한 후 작업원이 효율적으로 작업할 수 있도록 적당한 위치에 배정하고 작업내용을 작업원에게 지시한다. 작업진행상황을 파악하고 작업내용을 보고한다. 작업원의 작업상황을 관리·감독하고 작업공정에 있어 필요한 자재지원 및 기술을 지원한다. 표준명세에 따라 지시된 작업이 이루어지는지 작업원과 함께 작업하며 작업상황을 관찰하며 작업내용을 점검한다. 작업원에 대한 직무교육 및 안전위생교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시로 관찰과 면담을 통하여 작업원의 애로 및 건의사항을 수렴·해결하고 문제점을 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","certLic":"섬유산업기사","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C132","dJobICdNm":"[C132]직물직조 및 직물제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001354:1', '{"dJobCd":"K000001354","dJobCdSeq":"1","dJobNm":"직조정리원","workSum":"직조기의 경사가 여러 가닥으로 절단된 부분을 수리한다.","doWork":"끊어진 경사의 각 끝에 짧은 실을 묶고 가위로 마디 부근의 끝을 자른다. 수선된 경사를 코바늘을 사용하여 드로퍼(Dropper), 종광, 바디살을 통해 꿴다. 잘못된 짜임이 발견되면 금속빗을 사용하여 위사를 골라낸다. 제직이 완료된 기계 앞바닥에 포장포를 깔고 기계의 롤러브레이크 레버를 푼다. 일정 길이로 자르고 결점이 있는 곳을 표시하거나 가위나 칼로 자른다. 직물의 수량, 길이, 폭, 등급을 표시하고 종료마크를 찍는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"절포원","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C132","dJobICdNm":"[C132]직물직조 및 직물제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002979:1', '{"dJobCd":"K000002979","dJobCdSeq":"1","dJobNm":"직조지도원","workSum":"직조기술에 관한 지식을 이용하여 직조기를 다루는 방법을 작업원에게 가르친다.","doWork":"작업원이 직조기에 대하여 알 수 있도록 직조기의 부품 및 기능을 설명한다. 직기매듭 매는 법, 북에 실 꿰는 법, 끊어진 경사를 잇는 법, 직조기의 장치들을 조작하는 법 등의 직조기술을 설명한다. 작업원의 작업을 관찰하여 잘못 짜이는 부분을 찾아내고 수정하는 방법을 지도한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"수집","workFunc2":"교육","workFunc3":"제어조작","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C132","dJobICdNm":"[C132]직물직조 및 직물제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001453:1', '{"dJobCd":"K000001453","dJobCdSeq":"1","dJobNm":"직조틀보기원","workSum":"실을 사용하여 다양한 천을 짜기 위해 직조기를 조작한다.","doWork":"가공 중인 직물을 관찰하여 잘못 직조되는 부분이 없는지 확인한다. 위사를 뽑아내거나 잘라서 직물의 결함을 제거한다. 재직조하기 위해 패턴체인을 조정한다. 경사, 위사, 종광 전달 및 기계의 이상 등과 같이 직조기의 정지원인을 알아내기 위해 직조기를 검사한다. 실이 끊어진 경우 코바늘(바디훅)을 사용하여 드로퍼(Dropper), 종광, 바디살을 거쳐 실을 꿰고 끊어진 실을 잇기도 한다. 끊어진 위사를 수선하기 위해 끊어진 위사를 잇거나 뽑아내고, 새 위사를 북 집에 밀어 넣는다. 일정한 길이로 짜인 직물에 표시하거나 자르기도 한다. 위사를 실패에 감는 권사장치가 부착된 직조기를 취급하기도 한다. 직조기 매거진(Magazine)이나 장치에 위관이나 보빈을 끼우거나 북에 빈 보빈을 새것으로 바꾸기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"역직기운전원, 제직틀보기원, 직기대지원, 직포원, 직조기조작원","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C132","dJobICdNm":"[C132]직물직조 및 직물제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004376:1', '{"dJobCd":"K000004376","dJobCdSeq":"1","dJobNm":"치즈교체원","workSum":"실이 감긴 형태를 바꾸거나 다 쓴 실 꾸러미를 교체하기 위해 직조기, 연사기, 정경기, 술제조기 및 기타 다른 섬유기계들의 스핀들에 실 꾸러미들을 건다.","doWork":"실 꾸러미들을 스핀들에 놓고 실 끝을 작은 구멍(안내판) 사이로 꿰거나 실 끝을 전에 있던 실 끝과 연결한다. 오래된 실을 기계에서 제거한다. 먼지와 실 부스러기들을 크릴에서 없앤다. 잘못된 실이 나타나면 실 꾸러미나 실패를 바꾸기도 한다. 다른 부서로부터 치즈를 손수레로 운반하여 오기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"투입인출","similarNm":"콘교체원, 타래교체원","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C132","dJobICdNm":"[C132]직물직조 및 직물제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004525:1', '{"dJobCd":"K000004525","dJobCdSeq":"1","dJobNm":"카빙원","workSum":"제작된 융단에 입체감을 살리기 위해 카빙(Carving)기계로 무늬를 조각한다.","doWork":"작업지시서의 융단 표면무늬를 확인한다. 카빙기계의 주요 작동상태를 확인한다. 융단을 바닥에 펴고 그 위에 앉아 기계를 한 손으로 들고 시동한다. 기계에 부착된 절단날이 무늬부분의 섬유사를 절단하도록 기계를 살며시 들어서 무늬형태에 따라 민다. 카빙기에 솔, 기름걸레, 주유기 등을 사용하여 청소하고 기름을 친다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C139","dJobICdNm":"[C139]기타 섬유제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002662:1', '{"dJobCd":"K000002662","dJobCdSeq":"1","dJobNm":"카펫직조기조작원","workSum":"카펫을 짜기 위해 파일와이어(Pile Wire)장치가 부착된 한 대 이상의 기계를 조작한다.","doWork":"준비된 실을 크릴에 꽂는다. 작업계획에 따라 기계를 조작하여 규정된 규격에 맞도록 조정한다. 북 집에 위사를 감은 콥(Cop)을 끼우고 북을 직조기에 끼운다. 파일와이어에 광택을 내기 위해 기계의 홀더에 왁스를 놓는다. 직조기를 시동하고 기계 주위를 순찰하여 위사의 양, 끊어진 실, 보풀의 잘못 잘림 등의 결함을 확인한다. 무딘 절단날을 교체하고, 실이 바늘에서 빠진 경우에는 통경작업을 실시한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"카펫직조원","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C139","dJobICdNm":"[C139]기타 섬유제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003257:1', '{"dJobCd":"K000003257","dJobCdSeq":"1","dJobNm":"타이어고상중합기조작원","workSum":"타이어코드 섬유가닥들이 고객이 원하는 기계적 물성을 발현할 수 있도록 원료가 되는 중합반응물(폴리머)의 중합반응도를 올려서 점성도를 높이는 설비장치인 고상중합기를 조작한다.","doWork":"작업지시서를 확인하고 원료가 되는 중합반응물을 압축공기를 이용해서 저장조에 수송한다. 수송 중인 중합반응물(폴리머)의 수송상태를 확인하고, 온도가 높은 본 반응기(Reactor)로 이송하기 전에 폴리머의 표면을 딱딱하게 만들어서 중합반응물이 반응기 속에서 서로 달라붙지 않도록 1차 반응기 내 중합반응물의 표면상태 점검, 본 반응기 이후 원하는 중합반응도에 도달했는지를 확인하기 위하여 중합반응물을 표본화하여 의뢰하는 업무를 수행한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C139","dJobICdNm":"[C139]기타 섬유제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001593:1', '{"dJobCd":"K000001593","dJobCdSeq":"1","dJobNm":"타이어코드방사기조작원","workSum":"타이어코드 섬유가닥들(날실:經絲)을 생산하기 위하여 중합반응도가 높은 폴리머를 열과 압축에 의해서 녹이고, 냉각시키고, 원하는 길이가 되도록 일정한 비율로 인장시키고, 일정한 속도로 감는 장치를 조작한다.","doWork":"배대계획서와 작업지시서를 확인하고 원료가 되는 중합반응도가 높은 폴리머를 질소분위기에서 저장조로 수송한다. 수송된 폴리머를 일정한 양으로 수송하면서 열과 압력을 가해서 용융할수 있는 설비에 공급한다. 용융된 폴리머에 차가운 공기를 불어서 냉각한다. 실 표면에 기름을 묻히며 일정한 비율로 인장시키고, 열고정하면서 일정한 속도로 감는 장치를 조작하는 업무를 수행한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"타이어코드방사원","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C139","dJobICdNm":"[C139]기타 섬유제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005756:1', '{"dJobCd":"K000005756","dJobCdSeq":"1","dJobNm":"타이어코드연사기조작원","workSum":"타이어코드 섬유가닥들(날실:經絲)에 고객이 원하는 꼬임수를 부여하여 타이어의 압축 피로성을 향상하기 위하여 직조기에 적합한 길이로 꼬임을 부여하는 연사기를 조작한다.","doWork":"작업 지시서와 배대계획서를 확인하고 선별이 끝난 섬유가닥들을 준비한다. 고객이 원하는 꼬임 가닥수를 확인하여 1가닥, 2가닥, 3가닥에 꼬임을 부여하기 위해서 섬유가닥들을 기계장치의 공급부에 장착한다. 각 섬유가닥에 균일한 꼬임을 부여하기 위해서 연사기각 꼬임 부여되는 장치를 통과시킨 이후에 기계를 가동시킨다. 가동 중에 실이 끊어지면 기계연결장치(Knotter)를 활용하여 연결시키고, 원하는 길이만큼 꼬임이 부여되면 이동대차 또는 운송 상자에 적재하여 직조기로 운송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"타이어코드연사원","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C139","dJobICdNm":"[C139]기타 섬유제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007201:1', '{"dJobCd":"K000007201","dJobCdSeq":"1","dJobNm":"타이어코드직조기조작원","workSum":"타이어코드 섬유가닥들을 날실(經絲)로 사용하여, 날실 가닥 사이에 면사(cotton) 등의 씨실(緯絲)로 느슨한 타이어코드 직물을 짜는 직조기를 조작한다.","doWork":"작업지시서를 확인하고 실에 꼬임이 부여된 날실을 준비한다. 날실이나 씨실의 끊어짐이나 직조용 기계의 이상 등과 같은 정지 원인을 알아내기 위해 직조기를 검사한다. 직조 작업 중 불량품이 있을 경우 제거하고, 날실이 끊어져 있을 경우에는 자동 연결장치(Air Knotter)나 코바늘을 이용하여 잇는다. 씨실이 끊어진 경우에는 끊어진 씨실을 제거하는 등의 기계를 관찰하며 직조상의 결함을 알아낸다. 타이어코드 직물이 일정 길이로 직조가 끝나면 생산이력을 기록하고 직조기에서 보관장으로 이동한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"타이어코드직조원","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C139","dJobICdNm":"[C139]기타 섬유제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002197:1', '{"dJobCd":"K000002197","dJobCdSeq":"1","dJobNm":"타이어코드출하원","workSum":"꼬임이 부여되지 않은 섬유가닥이나 직조가 된 코드지, 접착코팅 공정을 거친 직조물을 고객이 원하는 일정에 제품 파손이 없이 공급이 되도록 출하 관리하는 업무를 담당한다.","doWork":"작업지시서를 확인하고 지정된 컨테이너의 내부를 점검하여 누수나 이물 유무를 확인한다. 제품 적재창고에서 작업지시서에 기록된 제품들을 대조해가면서 선입선출 방법으로 제품 외관상태를 재점검하면서 컨테이너 내부로 이동시킨다. 컨테이너 내부로 이동이 완료된 제품에 운송 중 파손이 되지 않도록 결박작업을 실시한다. 최종 적재현황을 기록·관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|고온|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C139","dJobICdNm":"[C139]기타 섬유제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002474:1', '{"dJobCd":"K000002474","dJobCdSeq":"1","dJobNm":"터프팅기조작원","workSum":"융단, 의복, 침대 씌우개 같은 물품에 사용되는 수술 재료를 짜는 여러 개의 바늘을 가진 터프팅기(Tufting Machine)를 조작한다.","doWork":"도안을 확인하여 생산하고자 하는 수술의 형태를 확인한다. 원사배열이나 기계의 상태를 확인한다. 스핀들 위에 공급실타래를 설치하고 실 끝을 실 가이드 안에 있는 막대에 연결한다. 흡입장치를 사용하여 기계 가이드를 통해 실 끝을 끌어당기고 실 끝을 가이드, 텐션(Tension), 드롭와이어와 바늘 눈을 통해 실 끝을 꿴다. 안감재료의 롤을 기계입구에 있는 브래킷에 놓고 기계바늘 아래로 안감을 잡아당겨 권취롤러에 끝을 부착한다. 일정한 도안에 따라 수술을 짜기 위해 레버를 움직여 캠 바퀴의 맞물림을 조절한다. 송출된 원사가 심어지는 것을 확인하고 기계의 고장이나 사절을 알기 위해 공정을 관찰한다. 끊어진 실 끝을 바늘에 다시 끼우고 부러졌거나 구부러진 바늘을 갈고리로 교체한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C139","dJobICdNm":"[C139]기타 섬유제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001342:1', '{"dJobCd":"K000001342","dJobCdSeq":"1","dJobNm":"터프팅장식원","workSum":"융단 및 침대보 같은 물품의 가장자리를 장식하는 기계를 조작한다.","doWork":"작업지시서상의 제품규격 및 색상 등을 확인한다. 가장자리 부분을 장식하기 위해 규격에 맞추어 가위나 재단기로 자른다. 실타래를 스핀들에 놓고 실 끝을 기계가이드, 장력장치, 바늘귀 사이를 통과시켜 당긴다. 페달을 눌러 술 제조장치를 작동하고 디자인된 명세에 따라 술 제조바늘 아래에 재료를 놓는다. 절단된 바늘이나 실타래의 실량, 사절을 확인하기 위해 공정을 관찰하면서 손상된 바늘을 교체하거나 실타래를 교체하고 끊어진 실을 잇는다. 다양한 색상의 장식을 짜기 위해 지정된 색실을 기계바늘에 다시 끼운다. 각종 라벨이나 스티커를 부착한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"작반원","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C139","dJobICdNm":"[C139]기타 섬유제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005648:1', '{"dJobCd":"K000005648","dJobCdSeq":"1","dJobNm":"통경반장","workSum":"제직을 하기 위해 경사를 준비하는 데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"작업지시서나 직물조직표에 따라 경사를 종광, 드로퍼(Dropper), 바디 등에 꿰는 순서, 올수 등을 알아내고 작업원에게 작업을 지시한다. 작업의 진행사항을 파악하고 작업내용을 보고한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원 및 자재를 공급한다. 작업계획에 따라 세부실행항목을 수립하고 작업절차 및 방법을 결정하여 작업원에게 작업내용을 지시하고 작업배치를 한다. 표준작업명세에 따라 지시된 작업이 이루어지는지 작업원과 함께 작업하며 작업상황을 관찰하고 작업내용을 점검한다. 작업원의 직무교육 및 안전위생교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴·해결하고 문제점을 보완한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C132","dJobICdNm":"[C132]직물직조 및 직물제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004791:1', '{"dJobCd":"K000004791","dJobCdSeq":"1","dJobNm":"통경원","workSum":"무늬 설계에 따라 일정한 무늬로 직물을 짜기 위해 경사를 종광, 드로퍼(Dropper), 바디 등의 직조기 부품을 통해 직조 틀에 꿰는 기계를 조작한다.","doWork":"운반된 경사빔을 통경작업을 위한 작업대에 고정한다. 앞 공정에서 끼운 사침끈을 빼고 사침대로 교환한다. 경사의 끝부분을 빗으로 빗어 엉키지 않게 가지런히 정리한다. 도면설계에 지시된 색깔과 순서에 따라 경사 끝을 찾아내고 코바늘을 사용하여 종광, 드로퍼, 바디를 통하여 실 끝을 배열한다. 준비한 바디를 사침대 앞에 고정하고 엉킨 경사를 빗으로 빗는다. 바디 칼을 사용하여 바디살 사이로 일정 가닥의 실을 순서에 따라 투입·배열한다. 작업이 끝난 빔의 종광, 드로퍼, 바디는 실로 묶는다. 운반차를 이용하여 빔을 지정된 장소에 운반·적재한다. 실 끝을 찾아주는 리칭기계(Reaching Machine)를 사용하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"경통원, 통경대지원, 통경틀보기원","connectJob":"성통원","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C132","dJobICdNm":"[C132]직물직조 및 직물제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003689:1', '{"dJobCd":"K000003689","dJobCdSeq":"1","dJobNm":"파일편직원","workSum":"완구용이나 내피용 파일편직물을 제조하기 위해 화학섬유 톱(Top)이나 편직용실을 사용하여 일정한 색상, 중량으로 무늬를 짜는 편직기를 조작한다.","doWork":"포장된 톱을 여러 개의 통에 나누어 담는다. 통에서 톱의 끝을 찾아 기계선단부의 인입구에 끼우고 콘 상태로 감긴 편직용 실은 크릴에 끼우고 실 끝을 찾아 편성침에 끼운다. 파일직물의 중량을 조절하기 위해 카딩기계(Carding Machine)의 기어 및 속도계기를 바꾸거나 조작한다. 톱의 섬유를 균일하게 하고 불순물을 제거하기 위해 송풍기를 작동한다. 가동상태를 관찰하고 실이 끊어지면 기계를 정지하고 끊어진 실을 이어준다. 톱(Top)의 중량 또는 편직용 실을 점검한다. 수동공구를 사용하여 싱커(Sinker)나 편성침을 교체하기도 한다. 일정 길이로 짠 직물은 칼을 사용하여 절단한다. 절단한 직물이 규격에 일치하는지 점검한다. 오차를 줄이기 위해 기계의 기어나 속도계기를 조절한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"하이파일편직원","certLic":"섬유산업기사","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C133","dJobICdNm":"[C133]편조원단 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005203:1', '{"dJobCd":"K000005203","dJobCdSeq":"1","dJobNm":"패턴체인조립원","workSum":"편직기에서 무늬모양에 따라 가이드바의 작동을 조절하는 패턴체인을 조립한다.","doWork":"도안지의 무늬모형을 확인하고 무늬모형에 따라 각 체인의 고리(Link)를 선택한다. 각도측정기를 사용하여 체인의 순서에 따라 고리를 부착한다. 전기연마기로 고리를 연마하여 가이드바의 작동이 원활히 될 수 있도록 조절한다. 고리를 고정하기 위해 고리의 구멍을 통해 연결핀을 끼운다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"섬유산업기사","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C133","dJobICdNm":"[C133]편조원단 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004036:1', '{"dJobCd":"K000004036","dJobCdSeq":"1","dJobNm":"편망기조작원","workSum":"합·연사된 끈이나 실을 사용하여 그물을 짜는 편망기를조작한다.","doWork":"그물의 종류에 따라 작업지시서에 명시된 실을 선택하여 크릴(Creel)에 권사 된 보빈(Bobbin)을 끼운다. 보빈에서 실 끝을 찾아 롤러, 안내대를 거쳐 결망위치에 건다. 위사를 감은 북을 북통에 끼우고 실 끝을 찾아 경사와 함께 결망위치에 건다. 기계를 작동하고 실이 결절되어 망목이 형성되면 망이 짜이는 상태를 관찰한다. 끊어진 실을 잇고 짜이지 않은 부분은 바늘을 사용하여 묶는다. 빈 보빈을 새 보빈으로, 빈 북 실을 새 북 실로 교체하기 위해 기계를 멈춘다. 길이계기를 확인하여 일정 길이로 짜인 그물에 절단표시를 한다. 완성된 그물은 보망공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"결망원, 제망원, 편망원","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C139","dJobICdNm":"[C139]기타 섬유제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005418:1', '{"dJobCd":"K000005418","dJobCdSeq":"1","dJobNm":"편물원","workSum":"편직용 실을 사용하여 직물, 의류부품 등을 짜기 위해 하나 또는 그 이상의 기계를 조작한다.","doWork":"작업지시서를 확인하고 편직기 등의 장비를 점검한다. 실을 기계의 실 끝과 연결하거나 가이드, 장력스프링, 멈춤장치, 급사기, 편성침을 통과시켜 편사를 꿴다. 편직한 제품의 끝부분을 권취롤러에 감는다. 편직의 이상을 알기 위해 편직된 천을 검사한다. 끊어진 실을 잇고 소모된 실을 교환한다. 기계의 결함이 발견되면 편직기수리원에게 알린다. 가위를 사용하여 편직된 천을 자르고 기계에서 천 롤을 떼어낸다. 수동공구를 사용하여 편성침을 교체하기도 한다. 편직제품 롤의 무게를 측정하여 기록하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"스웨터편직원","certLic":"섬유산업기사","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C133","dJobICdNm":"[C133]편조원단 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003537:1', '{"dJobCd":"K000003537","dJobCdSeq":"1","dJobNm":"편물제품기록원","workSum":"편직된 편직물이나 끝손질을 하는 옷감의 치수나 무게를 재고 기록표를 기록한다.","doWork":"편직제품의 치수나 무게를 재는 계기의 이상 유무를 확인한다. 각 계기로부터 길이수치, 무게를 기록하고 작업지시표의 스타일, 코드번호를 복사한다. 완성된 옷감 또는 편직제품에 기록표를 끼운다. 옷감의 결함이 발견된 때에는 기계를 정지하고 편직반장에게 알린다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"기록","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C133","dJobICdNm":"[C133]편조원단 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007393:1', '{"dJobCd":"K000007393","dJobCdSeq":"1","dJobNm":"편조의복검사원","workSum":"스웨터, 니트 등의 편직물을 검사하여 올이 나가거나 빠지는 등 규격에 맞지 않은 부분을 표시한다.","doWork":"스웨터, 니트 등의 편직물을 제품별로 크기가 다른 마네킹 모양의 검사대에 씌운다. 검사대의 전등을 켜고 육안으로 관찰하여 올이 나가거나 패턴 조직이 빠진 곳 등을 찾는다. 결함부위가 발견되면 스티커를 붙여 표시한다. 편직물의 길이를 재고 명세서와 비교하여 치수를 확인한다. 검사가 완료된 편직물을 정돈하고 포장공정으로 이송시키기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"스웨터검사원, 니트검사원","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C143","dJobICdNm":"[C143]편조의복 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006479:1', '{"dJobCd":"K000006479","dJobCdSeq":"1","dJobNm":"편직물검사원","workSum":"편직물을 검사하여 규격에 맞지 않은 부분을 표시하고 수정한다.","doWork":"편조된 직물 롤을 기계 후면의 걸대에 걸고 직물의 끝단을 검사대에 투입한다. 검사대의 등을 켜고 파손, 얼룩, 골이 빠진 곳 등을 찾는다. 분필이나 스티커로 천의 결함을 표시한다. 직물의 길이를 재고 명세서에 요구된 치수대로 편직이 되었는지 확인한다. 검사한 직물을 접거나 말아 놓는다. 수정 가능한 것은 대바늘이나 코바늘로 수정하고 수정이 완료되거나 양호한 제품을 정돈한다. 검사가 완료된 편직물을 포장공정으로 이송시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"편직의류검사원, 편직장갑검사원","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C133","dJobICdNm":"[C133]편조원단 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006780:1', '{"dJobCd":"K000006780","dJobCdSeq":"1","dJobNm":"편직물절단원","workSum":"일정 길이로 짠 편직물을 절단한다.","doWork":"편직기계에 입력된 수치에 따라 일정 짠 편직물을 가위 또는 칼을 사용하여 절단한다. 절단된 편직물을 저울을 사용하여 중량을 잰다. 편직물의 중량, 일련번호, 제품명, 등급 등을 편직물에 기록한다. 오염을 방지하기 위해 비닐이나 포장지로 포장한다. 절단된 편직물 중 견본을 뽑아 길이를 측정하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C133","dJobICdNm":"[C133]편조원단 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004059:1', '{"dJobCd":"K000004059","dJobCdSeq":"1","dJobNm":"편직반장","workSum":"편직용 실을 사용하여 천, 의복, 기타 다른 편직물을 제조하는 데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"표준작업명세에 따라 작업계획을 세우고 세부실행항목을 수립하여 작업절차 및 방법을 결정한다. 기계를 점검하여 결함이 발견된 부분은 수선하고 조절하도록 지시한다. 작업내용에 따라 작업원에게 지시·배치한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원 및 자재를 공급한다. 작업원과 함께 작업하며 작업상황을 관찰하며 작업내용을 점검한다. 작업원의 직무교육 및 안전위생교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴·해결하고 문제점을 보완한다. 작업의 진행사항을 기록하고 작업내용을 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C133","dJobICdNm":"[C133]편조원단 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006043:1', '{"dJobCd":"K000006043","dJobCdSeq":"1","dJobNm":"편직지도원","workSum":"기계와 가공처리 지식을 응용하여 제품검사 기술이나 섬유기계의 운전에 대해 작업원을 교육한다.","doWork":"편직공정 전반에 대한 장비 및 기술적 내용을 숙지한다. 작업지시서에 따라 작업계획을 세우고 계획에 따라 생산량 및 작업원의 작업위치 등 세부계획을 세운다. 생산기준에 도달할 수 있도록 훈련계획을 세운다. 기계에 실을 꿰어 작동하는 방법, 옷감의 결함을 검사하는 방법, 품질기준에 따라 옷감을 분류하는 방법들을 보여준다. 생산기준에 도달하는지 확인하고자 작업을 평가하며 보고서를 작성한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"교육","workFunc3":"제어조작","certLic":"섬유산업기사","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C133","dJobICdNm":"[C133]편조원단 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001704:1', '{"dJobCd":"K000001704","dJobCdSeq":"1","dJobNm":"호조제원","workSum":"직물을 짜는 공정 중 경사에 풀을 먹이기 위한 풀을 제조하고 공급한다.","doWork":"섬유에 따라 다른 종류의 호제를 구입한 호원료의 견본을 채취하여 중량, 순도, 점도, 색상, 비중 등을 실험기재를 사용하여 시험한다. 작업지시서에 따라 탱크에 물을 넣는 밸브를 돌려 일정수준으로 유지하고, 규정에 따라 계량된 풀 원료를 투입하여 주걱이나 혼합기로 혼합한다. 혼합된 풀을 필요한 기계별로 파이프를 통해 공급하는 밸브를 돌린다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"호조원","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C132","dJobICdNm":"[C132]직물직조 및 직물제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007058:1', '{"dJobCd":"K000007058","dJobCdSeq":"1","dJobNm":"환편직원","workSum":"다양한 실을 사용하여 원통형의 편직물을 짠다.","doWork":"작업지시서에서 편직하고자 하는 편직물의 종류를 확인하고 관련 기계의 이상 유무를 확인한다. 원사를 기계 상부의 실패걸이에 꽂는다. 실패에서 실 끝을 찾아 안내대, 실걸이를 통과시켜 급사장치에 건다. 기계를 가동하고 직물에 줄(Needle Line)이 생기는지 짠 직물을 관찰한다. 편성침을 수리하거나 교환한다. 짠 직물을 권취장치에 감아 놓는다. 짠 직물을 가위를 사용해 일정 절단한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"섬유산업기사","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C133","dJobICdNm":"[C133]편조원단 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004411:1', '{"dJobCd":"K000004411","dJobCdSeq":"1","dJobNm":"가류관조정원","workSum":"운동화의 각 부품이 확실히 접착되도록 가류관을 조정하여 고무를 경화시킨다.","doWork":"작업지시서를 확인하고 제품별 경화시키는 시간, 온도 및 압력 정도를 숙지한다. 각종 약품 및 천연고무(Latex)를 칠한 고무를 열풍을 이용하여 경화시키기 위하여 신발을 가마 안으로 투입한다. 배출밸브를 닫고 가마 속으로 공기를 주입한다. 압력을 확인하고 가류관을 가동시킨다. 적정시간과 적정온도를 확인하고 배출밸브를 연다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|고온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8642","dJobECdNm":"[8642]신발 제조기계 조작원 및 조립원","dJobJCd":"8222","dJobJCdNm":"[8222]신발 제조기 조작원 및 조립원","dJobICd":"C152","dJobICdNm":"[C152]신발 및 신발 부분품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004318:1', '{"dJobCd":"K000004318","dJobCdSeq":"1","dJobNm":"구두광택원","workSum":"완성된 구두에 광택을 내기 위하여 스프레이로 약품을 뿌리거나 스펀지로 문지른다.","doWork":"색깔에 따라 약품 통을 준비한다. 고무장갑을 착용하고 구두를 손에 끼운다. 스펀지로 구두에 약품을 바른다. 약품을 바른 신발이 건조하면 스프레이 작업대에 일정한 간격으로 구두를 배열한다. 스프레이로 약품을 뿌린다. 스프레이를 뿌린 구두가 건조하면 광내는 약으로 문지른다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"염료착색원","dJobECd":"8642","dJobECdNm":"[8642]신발 제조기계 조작원 및 조립원","dJobJCd":"8222","dJobJCdNm":"[8222]신발 제조기 조작원 및 조립원","dJobICd":"C152","dJobICdNm":"[C152]신발 및 신발 부분품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005814:1', '{"dJobCd":"K000005814","dJobCdSeq":"1","dJobNm":"신골가공원","workSum":"겉목을 견본 신골 모양대로 깎아내기 위하여 신골 복사기계를 조작한다.","doWork":"작업의뢰서를 보고 생산할 제품의 크기와 수량을 확인한다. 견본 신골을 기계에 위치시킨다. 둔탁하게 압출 성형된 신골 형태의 플라스틱(겉목)을 기계의 물림쇠에 꽂는다. 기계내부의 칼이 겉목을 견본 신골 모양대로 깎아내도록 기계를 작동시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"라스트가공원, 구두골가공원","dJobECd":"8642","dJobECdNm":"[8642]신발 제조기계 조작원 및 조립원","dJobJCd":"8222","dJobJCdNm":"[8222]신발 제조기 조작원 및 조립원","dJobICd":"C152","dJobICdNm":"[C152]신발 및 신발 부분품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006462:1', '{"dJobCd":"K000006462","dJobCdSeq":"1","dJobNm":"신골마무리원","workSum":"신골 제조공정에서 가공되지 않은 신골 양끝을 기계와 손으로 다듬거나 수선한다.","doWork":"신골의 앞부분을 다듬기 위하여 앞치기 기계를 조작한다. 신골을 기계의 물림쇠에 올려놓는다. 발판스위치를 눌러 신골의 앞부분을 잘라낸다. 신골의 뒷부분은 손을 사용하여 다듬는다. 장갑 낀 한 손으로 자동회전 중인 페퍼에 댄다. 다른 한 손으로 신골의 뒤축부분을 페퍼에 비벼서 거친 면을 다듬는다. 견본 신골 모양대로 신골의 뒤축을 다듬는다. 혹은 신골의 쪼개진 부위에 전기드릴로 구멍을 낸다. 나무나 섬유질 쐐기를 박는다. 신골 면의 쐐기를 전기톱으로 잘라낸다. 수선 부위를 줄질하고 사포용 휠, 줄, 사포로 거친 부위를 부드럽게 한다. 신골 위에 형태, 크기 및 쪽의 치수를 표시하는 도장을 찍는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"대기환경미흡|위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"라스트마무리원","dJobECd":"8642","dJobECdNm":"[8642]신발 제조기계 조작원 및 조립원","dJobJCd":"8222","dJobJCdNm":"[8222]신발 제조기 조작원 및 조립원","dJobICd":"C152","dJobICdNm":"[C152]신발 및 신발 부분품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006289:1', '{"dJobCd":"K000006289","dJobCdSeq":"1","dJobNm":"신골압출기조작원","workSum":"압출기를 조작하여 신골의 원료인 폴리에틸렌을 압출시킨다.","doWork":"폴리에틸렌을 주입구에 집어넣는다. 압출기를 작동시킨다. 압출되어 나오는 떡가래 모양의 폴리에틸렌을 칼을 사용하여 일정 크기로 자른 후 저울로 중량을 잰다. 일정량의 폴리에틸렌을 신골 모양의 금형에 집어넣는다. 금형기를 작동시킨다. 금형에서 거친 신골 모양의 블럭을 꺼낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|고온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"라스트압출기조작원","dJobECd":"8642","dJobECdNm":"[8642]신발 제조기계 조작원 및 조립원","dJobJCd":"8222","dJobJCdNm":"[8222]신발 제조기 조작원 및 조립원","dJobICd":"C152","dJobICdNm":"[C152]신발 및 신발 부분품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003962:1', '{"dJobCd":"K000003962","dJobCdSeq":"1","dJobNm":"신골제작현장관리자","workSum":"신골을 만드는 데 종사하는 신골수선원, 신골절단원, 신골탈골원 등의 활동을 감독·조정한다.","doWork":"작업지시서에 따라 구두골의 형태와 크기를 확인한다. 작업계획에 따라 세부실행항목을 수립한다. 작업절차 및 방법을 결정하여 작업원에게 작업내용을 지시하고 작업배치를 한다. 작업자에게 안전교육을 실시하여 안전사고를 예방한다. 사용할 모형을 선정하고 작업원에게 알린다. 작업에 소요되는 물품을 청구한다. 완성품을 검사하며 이상이 있으면 수정하도록 지시한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"조정","workFunc2":"감독","workFunc3":"수동조작","similarNm":"라스트제작반장","certLic":"신발제조기능사","dJobECd":"8642","dJobECdNm":"[8642]신발 제조기계 조작원 및 조립원","dJobJCd":"8222","dJobJCdNm":"[8222]신발 제조기 조작원 및 조립원","dJobICd":"C152","dJobICdNm":"[C152]신발 및 신발 부분품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006344:1', '{"dJobCd":"K000006344","dJobCdSeq":"1","dJobNm":"신발수선원","workSum":"제조과정에서 손상된 신발을 검사하고 수선한다.","doWork":"결함을 알아내기 위해 신발을 검사하거나 수선표를 검토한다. 칼, 망치, 조립도구, 지렛대, 시침질 및 뜯는 도구 등으로 손상된 부품을 제거한다. 실이 끊어지거나 한 땀 건너 재봉한 바느질을 재 바느질한다. 부분품을 대체한 경우 손바느질 또는 바느질 기계를 조작하여 재결합한다. 외피에 생긴 주름, 속부분의 다발(융기), 비뚤어진 솔기 등 결함을 제거하고 신발을 재조립한다. 손으로 비뚤어진 가장자리, 뒤축, 신발창, 갑피 등 부품을 가지런히 정렬하여 접착한다. 유색왁스 주입기로 신발의 구멍 한 곳을 채우고 압력을 가한다. 작업이 완료된 제품을 포장 및 마무리 공정으로 이송시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"8642","dJobECdNm":"[8642]신발 제조기계 조작원 및 조립원","dJobJCd":"8222","dJobJCdNm":"[8222]신발 제조기 조작원 및 조립원","dJobICd":"C152","dJobICdNm":"[C152]신발 및 신발 부분품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006076:1', '{"dJobCd":"K000006076","dJobCdSeq":"1","dJobNm":"가발모발직조원","workSum":"정모된 모발을 엮어 짜기 위해 모발직기를 이용해 쌍침·단침작업을 한다.","doWork":"정모공정에서 정모 완성된 원사를 규격서의 지시대로 모발직기에 투입한다. 쌍침재봉(2행으로 펼쳐 2중 미싱 바늘로 봉제)틀을 사용하여 정모된 모발을 두 줄로 엮어 짠다. 쌍침재봉된 모발의 중앙부분을 집어 단침재봉(2행으로 펼쳐진 머리를 다시 미싱선을 중심으로 한쪽 방향으로 접어서 봉제)틀로 재봉한다. 모발이 빠지지 않도록 뿌리부분을 접어서 재봉틀로 박아주고 접착제를 바른다. 가위를 사용하여 규정된 모발을 자른다. 저울로 무게를 측정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8649","dJobECdNm":"[8649]기타 직물·신발 기계 조작원 및 조립원","dJobJCd":"8229","dJobJCdNm":"[8229]기타 직물·신발 관련 기계 조작원 및 조립원","dJobICd":"C339","dJobICdNm":"[C339]그 외 기타 제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006694:1', '{"dJobCd":"K000006694","dJobCdSeq":"1","dJobNm":"가발베이스제조원","workSum":"가발 제조 시 레이스, 망사, 거즈 등의 재료를 사용하여 가발의 베이스(Base)를 만든다.","doWork":"머리의 치수에 따라 가발의 형태를 설계·재단한다. 모양을 만들어 두부형태에 따라 핀을 꽂는다. 형태 위에 선을 그어 위치를 표시한다. 골격부위에 거즈를 펴서 핀으로 고정하고 레이스를 자른다. 조절 고무줄을 부착하고 치수에 맞도록 재봉한다. 망의 격자가 중심이나 머리 옆 부분 모두 정방형이 되도록 부착한다. 스킨(Skin)의 두께 및 색상이 기준 칼라와 같은지 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"캡제조원","dJobECd":"8649","dJobECdNm":"[8649]기타 직물·신발 기계 조작원 및 조립원","dJobJCd":"8229","dJobJCdNm":"[8229]기타 직물·신발 관련 기계 조작원 및 조립원","dJobICd":"C339","dJobICdNm":"[C339]그 외 기타 제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006112:1', '{"dJobCd":"K000006112","dJobCdSeq":"1","dJobNm":"가발식모원","workSum":"가발을 제조하고자 일정량의 모발을 스킨(Skin)에 심어주는 기계를 조작한다.","doWork":"제품의 규격에 따라 스킨(Skin)에 작업선을 표시한다. 작업이 용이하도록 모발을 정리한다. 기계의 후면에 모발뭉치를 놓고 바늘을 가동시키기 위해 페달을 밟는다. 기계가 식모 부분 끝에 멈출 때까지 바늘 밑으로 스킨을 지정된 방법으로 움직인다. 식모된 가장자리 부분을 가위를 사용하여 일정 길이로 자른다. 뒷면에 튀어나온 모발을 이발기구를 사용하여 깎는다. 주름을 없애기 위해 인두질을 한다. 모발이 빠지지 않도록 뒷면에 접착제를 바른다. 접착제를 바른 모발을 일정 시간 동안 건조시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"가발스킨원","dJobECd":"8649","dJobECdNm":"[8649]기타 직물·신발 기계 조작원 및 조립원","dJobJCd":"8229","dJobJCdNm":"[8229]기타 직물·신발 관련 기계 조작원 및 조립원","dJobICd":"C339","dJobICdNm":"[C339]그 외 기타 제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005595:1', '{"dJobCd":"K000005595","dJobCdSeq":"1","dJobNm":"가발원사가공처리원","workSum":"가발을 제조하고자 원사를 표백·염색·배합·재단·정리하는 등 가공 처리하는 일을 한다.","doWork":"입고된 머리카락을 비눗물에 담궈 이물질을 제거한 후 정모를 위한 원사로 분리한다. 원하는 색상을 얻기 위해 원사를 일정 시간 동안 표백하거나 염색통에 담가 염색한다. 통에서 꺼낸 원사를 줄에 걸어 자연 건조시킨다. 건조한 원사를 작업대에 놓는다. 가발원사에 약품처리 및 열처리를 하기도 한다. 원사를 고정된 빗니 사이로 당겨서 엉킨 부분을 제거한다. 원사의 길이에 따라 구분하고 칼로 재단한다. 재단이 끝난 원사를 저울로 중량을 달아 기록한다. 모발의 색을 엷게 하거나 그을리기 위해 산 및 소다액에 세척하거나 담그기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"가발원사염색원, 가발원사표백원, 가발원사재단원","dJobECd":"8649","dJobECdNm":"[8649]기타 직물·신발 기계 조작원 및 조립원","dJobJCd":"8229","dJobJCdNm":"[8229]기타 직물·신발 관련 기계 조작원 및 조립원","dJobICd":"C339","dJobICdNm":"[C339]그 외 기타 제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001653:1', '{"dJobCd":"K000001653","dJobCdSeq":"1","dJobNm":"가죽건조반장","workSum":"가죽을 건조하고 부드럽게 하는 일에 종사하는 작업원의 활동을 감독·조정한다.","doWork":"생산품목 및 생산량에 따라 작업계획을 수립한다. 작업계획에 따라 세부실행항목을 수립한다. 작업절차 및 방법을 결정하여 작업원에게 작업내용을 지시하고 작업배치를 한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원 및 자재를 공급한다. 표준작업명세에 따라 지시된 작업이 이루어지는지 작업원과 함께 작업한다. 작업원의 직무교육 및 안전위생교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴·해결하고 문제점을 보완한다. 작업의 진행사항을 파악하고 작업내용을 기록·보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|고온|","workFunc1":"조정","workFunc2":"감독","workFunc3":"수동조작","dJobECd":"8649","dJobECdNm":"[8649]기타 직물·신발 기계 조작원 및 조립원","dJobJCd":"8229","dJobJCdNm":"[8229]기타 직물·신발 관련 기계 조작원 및 조립원","dJobICd":"C151","dJobICdNm":"[C151]가죽, 가방 및 유사제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005092:1', '{"dJobCd":"K000005092","dJobCdSeq":"1","dJobNm":"가죽건조원","workSum":"염색된 가죽의 수분을 제거하고 증발시키기 위하여 건조기를 조작한다.","doWork":"작업지시서를 확인하고 품목, 용도별 건조 시간 및 온도, 습도 등을 확인한다. 건조기를 점검하여 이상 유무를 확인한다. 가죽을 건조기에 걸거나 눕혀 위치시킨다. 건조기의 온도, 습도를 조절하고 스팀 및 온·냉수 공급 상태를 확인한다. 진공건조인 경우 열판 위에 가죽을 펼치고 조작버튼을 누르면 위의 메시망 흡판이 내려와 수분을 빨아들인다. 가죽의 품목별 용도에 따라 건조속도를 조절한다. 건조 상태를 확인하고 지정된 장소에 적재한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|고온|다습|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"열판기조작원","dJobECd":"8649","dJobECdNm":"[8649]기타 직물·신발 기계 조작원 및 조립원","dJobJCd":"8229","dJobJCdNm":"[8229]기타 직물·신발 관련 기계 조작원 및 조립원","dJobICd":"C151","dJobICdNm":"[C151]가죽, 가방 및 유사제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004009:1', '{"dJobCd":"K000004009","dJobCdSeq":"1","dJobNm":"가죽도장공","workSum":"가죽을 도장 처리하고자 가죽표면 위에 안료나 염료래커용액을 분무하는 기계를 조작한다.","doWork":"분무기의 이상 유무를 점검한다. 작업지시서에 따라 분무할 안료나 래커용액을 기계 투입구에 투입한다. 가죽을 기계 입구에 정리한다. 각종 밸브를 조절하여 열고 스위치를 작동한다. 컨베이어를 통하여 가죽이 분무기를 통과하도록 가죽을 컨베이어에 올린다. 스프레이 시 가죽모공 깊숙이 용액이 침투되도록 패드기를 조작하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"가죽도장원","connectJob":"오토스프레이조작원","dJobECd":"8649","dJobECdNm":"[8649]기타 직물·신발 기계 조작원 및 조립원","dJobJCd":"8229","dJobJCdNm":"[8229]기타 직물·신발 관련 기계 조작원 및 조립원","dJobICd":"C151","dJobICdNm":"[C151]가죽, 가방 및 유사제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006370:1', '{"dJobCd":"K000006370","dJobCdSeq":"1","dJobNm":"가죽면적측정원","workSum":"가공처리가 완료된 가죽의 넓이를 자동측정기로 측정한다.","doWork":"자동측정기(계평기)의 전기스위치를 넣는다. 측정기 숫자 화면을 제로상태로 조작한다. 완제품 가죽을 측정기 입구에 정리·정돈한다. 기계를 작동하고 화면에 나타난 넓이를 읽고 기록한다. 가죽표면에 측정된 넓이 스티커를 부착하고 끈으로 묶는다. 가죽다림질장치에서 자동으로 계평장치로 이송되어 넓이를 측정하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"계평기조작원, 계형원","dJobECd":"8649","dJobECdNm":"[8649]기타 직물·신발 기계 조작원 및 조립원","dJobJCd":"8229","dJobJCdNm":"[8229]기타 직물·신발 관련 기계 조작원 및 조립원","dJobICd":"C151","dJobICdNm":"[C151]가죽, 가방 및 유사제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005723:1', '{"dJobCd":"K000005723","dJobCdSeq":"1","dJobNm":"가죽면취원","workSum":"가죽을 용도에 따라 최종 두께로 깎아주기 위해 쉐이빙기계(Shaving Machine)를 조작한다.","doWork":"수분이 제거되고 선별과정을 거친 가죽을 수령한다. 작업지시서에 따라 용도에 따른 가죽두께를 확인한다. 자동 쉐이빙기계의 경우 가죽두께를 입력하고 기계를 작동시킨다. 가죽표면을 벤딩나이프(Bending Knife)에 수차례 접촉시켜 일정한 두께가 되도록 가죽표면을 깎아낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8649","dJobECdNm":"[8649]기타 직물·신발 기계 조작원 및 조립원","dJobJCd":"8229","dJobJCdNm":"[8229]기타 직물·신발 관련 기계 조작원 및 조립원","dJobICd":"C151","dJobICdNm":"[C151]가죽, 가방 및 유사제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002865:1', '{"dJobCd":"K000002865","dJobCdSeq":"1","dJobNm":"가죽선별원","workSum":"가죽제품을 제조하기 위해 가죽이 제품특성에 맞는가를 검사하여 선별한다.","doWork":"작업표준서를 확인하고 제품별 강도, 재질, 색상, 등급, 물성 등의 검사기준을 숙지한다. 선별대 위에 가죽을 펼쳐 놓는다. 손상자국, 얼룩, 흠집 등 결함이 있는가를 육안으로 검사하고 불량부분은 표시한다. 가죽의 두께가 얇고 두꺼운가를 손으로 만져본다. 가죽의 종류, 생상에 따라 등급을 분류하여 적재한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"가죽검사원","dJobECd":"8649","dJobECdNm":"[8649]기타 직물·신발 기계 조작원 및 조립원","dJobJCd":"8229","dJobJCdNm":"[8229]기타 직물·신발 관련 기계 조작원 및 조립원","dJobICd":"C151","dJobICdNm":"[C151]가죽, 가방 및 유사제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002975:1', '{"dJobCd":"K000002975","dJobCdSeq":"1","dJobNm":"가죽신장원","workSum":"구겨진 가죽을 열고정기(Toggle Dryer)에 장착해 좌우로 늘인다.","doWork":"가죽의 최종면적을 결정하고 도장(Coating) 시 균일하게 약품이 착색될 수 있도록 구멍이 뚫린 금속판(Toggle Plate)에 가죽을 펼쳐 놓는다. 가죽을 대각선으로 당겨 일정한 간격으로 클립을 꽂아 고정시킨다. 가죽을 고정시킨 금속판을 열풍 건조실에 넣고 세워 건조시킨다. 일정 시간 건조 후 가죽에서 클립을 제거하고 적재한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|고온|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"토글링작업원","dJobECd":"8649","dJobECdNm":"[8649]기타 직물·신발 기계 조작원 및 조립원","dJobJCd":"8229","dJobJCdNm":"[8229]기타 직물·신발 관련 기계 조작원 및 조립원","dJobICd":"C151","dJobICdNm":"[C151]가죽, 가방 및 유사제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002388:1', '{"dJobCd":"K000002388","dJobCdSeq":"1","dJobNm":"가죽완성반장","workSum":"가죽을 채색·광택내고 마무리하는 일에 종사하는 작업원의 활동을 감독·조정한다.","doWork":"각 공정별 생산량 및 작업내용에 따라 작업계획을 수립한다. 작업계획에 따라 세부실행항목을 수립한다. 작업절차 및 방법을 결정하여 작업원에게 작업내용을 지시하고 작업배치를 한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원 및 자재를 공급한다. 표준작업명세에 따라 지시된 작업이 이루어지는지 작업원과 함께 작업한다. 작업원의 직무교육 및 안전위생교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴·해결하고 문제점을 보완한다. 작업의 진행사항을 파악하고 작업내용을 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|다습|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"수동조작","dJobECd":"8649","dJobECdNm":"[8649]기타 직물·신발 기계 조작원 및 조립원","dJobJCd":"8229","dJobJCdNm":"[8229]기타 직물·신발 관련 기계 조작원 및 조립원","dJobICd":"C151","dJobICdNm":"[C151]가죽, 가방 및 유사제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002781:1', '{"dJobCd":"K000002781","dJobCdSeq":"1","dJobNm":"가죽제품검사원","workSum":"가죽제품의 재봉 상태, 흠집, 부착물 상태 등을 검사한다.","doWork":"검사기준서를 확인하고 품목별 검사기준을 숙지한다. 재봉 상태, 부착물의 부착 상태를 검사한다. 제품에 묻은 얼룩은 세척제로 닦고 실밥을 제거한다. 구김살을 다리미로 펴고 모양을 바로잡는다. 완성품이 견본과 동일한지 확인한다. 검사기준에 합격한 제품에 검사표식도장을 찍고 불합격한 제품은 이전 공정으로 이송시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8649","dJobECdNm":"[8649]기타 직물·신발 기계 조작원 및 조립원","dJobJCd":"8229","dJobJCdNm":"[8229]기타 직물·신발 관련 기계 조작원 및 조립원","dJobICd":"C151","dJobICdNm":"[C151]가죽, 가방 및 유사제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002306:1', '{"dJobCd":"K000002306","dJobCdSeq":"1","dJobNm":"가죽제품완성원","workSum":"가죽제품에 장식품을 부착하는 등 마무리 작업을 한다.","doWork":"송곳이나 구멍 뚫는 기계를 사용하여 가죽제품에 구멍을 뚫고 단추, 링, 걸쇠, 손잡이나 장식을 부착한다. 가죽이 접히는 부분의 부품에 접착제를 바르고 다리미로 다리거나 망치로 두드려 접음질한다. 부품의 가장자리 및 재봉이 필요한 일부분을 재봉틀로 바느질한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"가죽제품마무리원","dJobECd":"8649","dJobECdNm":"[8649]기타 직물·신발 기계 조작원 및 조립원","dJobJCd":"8229","dJobJCdNm":"[8229]기타 직물·신발 관련 기계 조작원 및 조립원","dJobICd":"C151","dJobICdNm":"[C151]가죽, 가방 및 유사제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004306:1', '{"dJobCd":"K000004306","dJobCdSeq":"1","dJobNm":"가죽제품조립반장","workSum":"가죽재단물을 조립하는 데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"완성품이나 부분품의 결함을 검사하여 수정 지시한다. 주문품에 필요한 모형을 준비한다. 작업내용에 따라 작업원에게 지시·배치한다. 작업의 진행사항을 파악하고 작업내용을 보고한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원 및 자재를 공급한다. 작업계획에 따라 세부실행항목을 수립하고 작업절차 및 방법을 결정하여 작업원에게 작업내용을 지시하고 작업배치를 한다. 표준작업명세에 따라 지시된 작업이 이루어지는지 작업원과 함께 작업하며 작업상황을 관찰하며 작업내용을 점검한다. 작업원의 직무교육 및 안전위생교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴·해결하고 문제점을 보완한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"조정","workFunc2":"감독","workFunc3":"수동조작","dJobECd":"8649","dJobECdNm":"[8649]기타 직물·신발 기계 조작원 및 조립원","dJobJCd":"8229","dJobJCdNm":"[8229]기타 직물·신발 관련 기계 조작원 및 조립원","dJobICd":"C151","dJobICdNm":"[C151]가죽, 가방 및 유사제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002389:1', '{"dJobCd":"K000002389","dJobCdSeq":"1","dJobNm":"가죽제품조립원","workSum":"가죽제품에 장식품을 부착하는 등 마무리 작업을 한다.","doWork":"송곳이나 구멍 뚫는 기계를 사용하여 가죽제품에 단추, 링, 걸쇠, 가죽손잡이나 장식을 부착한다. 가위나 주름잡는 다리미로 부품을 접음질한다. 접착한 부위를 단단히 하기 위해 망치질을 한다. 부품의 가장자리와 일부분을 재봉틀로 바느질한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|시각|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8649","dJobECdNm":"[8649]기타 직물·신발 기계 조작원 및 조립원","dJobJCd":"8229","dJobJCdNm":"[8229]기타 직물·신발 관련 기계 조작원 및 조립원","dJobICd":"C151","dJobICdNm":"[C151]가죽, 가방 및 유사제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002237:1', '{"dJobCd":"K000002237","dJobCdSeq":"1","dJobNm":"가죽탈수원","workSum":"가죽의 쉐이빙(Shaving)공정이 원활하도록 가죽수분을 조절하기 위해 탈수기계(Samming Machine)를 조작한다.","doWork":"가죽의 두께에 따라 롤러 사이의 간격을 조절하는 멈춤 나사를 돌린다. 롤러 사이에 가죽을 삽입하고 발판을 누른다. 한쪽 롤러가 흡수성 재질로 되어 있어 물을 빨아들이며 탈수한다. 탈수상태를 관찰하고 탈수처리가 적절치 않은 경우 반복 작업한다. 다음 공정인 쉐이빙기계에 가죽이 매끄럽게 삽입될 수 있도록 가죽 표면에 옥수수 전분을 뿌리기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|다습|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"세밍기조작원","dJobECd":"8649","dJobECdNm":"[8649]기타 직물·신발 기계 조작원 및 조립원","dJobJCd":"8229","dJobJCdNm":"[8229]기타 직물·신발 관련 기계 조작원 및 조립원","dJobICd":"C151","dJobICdNm":"[C151]가죽, 가방 및 유사제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001672:1', '{"dJobCd":"K000001672","dJobCdSeq":"1","dJobNm":"건견원","workSum":"누에고치를 공업원료로 바꾸기 위해 건견기를 사용하여 고치 속의 번데기가 나방이 되어 고치층을 뚫고 나오는 것을 방지하는 일을 한다.","doWork":"습도를 유지하고 환기장치를 조작하여 바람의 속도를 조절하여 건조하는 항율건조와 감율건조를 한다. 건견기 내부의 가열장치, 환기장치 및 공기교환장치의 기능을 관찰한다. 건견이 끝난 누에고치는 선견장으로 운반한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"유지","dJobECd":"8649","dJobECdNm":"[8649]기타 직물·신발 기계 조작원 및 조립원","dJobJCd":"8229","dJobJCdNm":"[8229]기타 직물·신발 관련 기계 조작원 및 조립원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002849:1', '{"dJobCd":"K000002849","dJobCdSeq":"1","dJobNm":"그물검사원","workSum":"그물을 수선하고 검사한다.","doWork":"그물을 검사틀 위에 펼치고 끊어진 실, 불규칙한 매듭 등의 결점을 찾아내기 위해 그물눈을 검사한다. 그물눈이 규정에 맞게 짜였는지 확인하기 위해 그물눈을 검사한다. 그물눈이 규정에 맞게 짜였는지 확인하기 위해 자로 잰다. 그물수선바늘로 늘어진 그물을 묶고 칼이나 가위로 늘어진 실 끝을 자른다. 포장이나 출하하기 쉽도록 그물을 접는다. 천장의 롤러에 걸쳐진 그물의 양끝을 아래로 잡아당기면서 검사하기도 한다. 그물의 끝을 서로 묶기도 한다. 매직잉크나 끈으로 잘못된 부분을 표시하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"어망검사원","dJobECd":"8649","dJobECdNm":"[8649]기타 직물·신발 기계 조작원 및 조립원","dJobJCd":"8229","dJobJCdNm":"[8229]기타 직물·신발 관련 기계 조작원 및 조립원","dJobICd":"C139","dJobICdNm":"[C139]기타 섬유제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003165:1', '{"dJobCd":"K000003165","dJobCdSeq":"1","dJobNm":"금속장식부착원","workSum":"금속장식이 부착되는 섬유제품에 금속장식을 부착하는 프레스기를 조작한다.","doWork":"봉제가 완료된 제품의 특정부위에 고리 등 금속장식을 끼우거나 붙인다. 작업지시서의 부착위치 등을 확인하고 부착할 위치를 프레스기의 압착부분에 놓는다. 프레스기의 조작버튼을 눌러 압착한다. 부착상태를 확인하고 필요한 경우 다시 프레스기로 부착한다. 부착된 부위에 불필요한 티끌 등을 제거한다. 공정일지를 확인하여 재료를 준비하고 작업이 완료되면 일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"금구부착원","dJobECd":"8649","dJobECdNm":"[8649]기타 직물·신발 기계 조작원 및 조립원","dJobJCd":"8229","dJobJCdNm":"[8229]기타 직물·신발 관련 기계 조작원 및 조립원","dJobICd":"C141/C144","dJobICdNm":"[C141]봉제의복 제조업 / [C144]의복 액세서리 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007142:1', '{"dJobCd":"K000007142","dJobCdSeq":"1","dJobNm":"링킹기계조작원","workSum":"스웨터, 니트 등 편조의복의 각종 부속품을 조립하고자 링킹기계(Linking Machine)를 조작한다.","doWork":"공구 및 장비의 이상 유무를 점검하고 편조의복의 각 부분품(앞판, 뒤판, 목, 팔)을 수령한다. 실패걸이에 실패를 끼운다. 링킹기계에 부분품을 올려놓는다. 각 부분품 조각의 바늘 코를 기계의 다이얼에 일일이 꿰어 넣는다. 기계를 작동하여 부분품을 연결시킨다. 실이 끊어지면 기계를 정지하고 실을 잇는다. 작업이 완료된 제품은 세탁공정(Washing)으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"링킹봉조기조작원, 링킹사, 사시사","connectJob":"재봉원","dJobECd":"8649","dJobECdNm":"[8649]기타 직물·신발 기계 조작원 및 조립원","dJobJCd":"8229","dJobJCdNm":"[8229]기타 직물·신발 관련 기계 조작원 및 조립원","dJobICd":"C143","dJobICdNm":"[C143]편조의복 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004528:1', '{"dJobCd":"K000004528","dJobCdSeq":"1","dJobNm":"매트리스스프링가공원","workSum":"강선(철선)을 가공하여 매트리스 스프링을 제조하거나 매트리스 스프링을 열처리하여 매트리스에 조립한다.","doWork":"경강선(철선)의 상태를 확인하여 정품의 강선을 준비한다. 경강선을 전동차를 이용하여 해선기 위에 올려놓은 후 강선관에 삽입한다. 삽입된 강선을 강선 견인용 조정핸들을 조정하면서 손으로 강선 견인롤러에 밀어 넣는다. 스패너와 렌치를 사용하여 작업하고자 하는 치수로 조정한 후 회전형 롤러에 부착한다. 스프링 성형기계를 가동하고 연속적으로 생산되는 스프링의 상태를 확인한 후 제조한다. 열처리로의 온도를 올리기 위해 작업 전 온도 및 시간을 입력하고 조립된 스프링판을 작업대 위에 올려놓는다. 작업하고자 하는 규격으로 클립(Clip)부착기를 장착하고 준비된 스프링판 조립품 수 개를 겹쳐서 열처리로 컨베이어에 올려놓는다. 열처리로의 온도를 확인하면서 열처리되어 나오는 스프링판의 색깔을 확인한다. 클립 및 열처리작업이 끝나면 클립 부착 상태를 검사하며 이상이 없는지 확인한다. 헬리컬(Helical) 스프링으로 조립된 스프링판의 가장자리에 굵은 철선을 조립한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"매트리스스프링성형원, 매트리스스프링조립원","dJobECd":"8649","dJobECdNm":"[8649]기타 직물·신발 기계 조작원 및 조립원","dJobJCd":"8229","dJobJCdNm":"[8229]기타 직물·신발 관련 기계 조작원 및 조립원","dJobICd":"C320","dJobICdNm":"[C320]가구 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005928:1', '{"dJobCd":"K000005928","dJobCdSeq":"1","dJobNm":"매트리스제조반장","workSum":"스프링판 및 침대용 매트리스 제조원들의 활동을 감독·조정한다.","doWork":"생산계획에 따라 스프링제조용 철선, 핀, 케이스용 천 등의 소요재료를 청구하고 재봉틀이나 누비질 기계로 펠트(Felt)나 직물로 장식하는 방법에 대한 계획을 세운다. 작업일지를 작성 및 보고하고 가동기계 및 제조설비를 유지·관리한다. 스프링판을 제조하고 스프링판 펠트나 직물을 씌우고 장식하는 작업자를 지휘하고 배치한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"수동조작","dJobECd":"8649","dJobECdNm":"[8649]기타 직물·신발 기계 조작원 및 조립원","dJobJCd":"8229","dJobJCdNm":"[8229]기타 직물·신발 관련 기계 조작원 및 조립원","dJobICd":"C320","dJobICdNm":"[C320]가구 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006476:1', '{"dJobCd":"K000006476","dJobCdSeq":"1","dJobNm":"매트리스조립원","workSum":"스펀지와 스프링판을 조립하여 매트리스를 제조한다.","doWork":"스펀지, 스프링판, 접착제 등을 준비하고 중앙제어기계의 접착용기 및 스펀지 부착기계의 접착용기에 접착제를 넣는다. 수동조작 패널 모드에 작업하고자 하는 매트 치수를 입력한다. 수동 이송기로 스프링판을 이송시키고 스프링 로봇을 이용하여 사면접착을 한다. 커버 사면 부착이 완료되면 판 조립을 들고 상하 판의 커버를 붙인다. 접착작업이 완료되면 제품을 검사하고 떨어진 곳이 있으면 수작업으로 마무리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8649","dJobECdNm":"[8649]기타 직물·신발 기계 조작원 및 조립원","dJobJCd":"8229","dJobJCdNm":"[8229]기타 직물·신발 관련 기계 조작원 및 조립원","dJobICd":"C320","dJobICdNm":"[C320]가구 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;