INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004450:1', '{"dJobCd":"K000004450","dJobCdSeq":"1","dJobNm":"자동면삭기조작원","workSum":"압연금속재의 슬래브표면에 발생한 표면결함(스케일, 산화피막, 기공의 불순물, 요철)을 제거하기 위하여 자동면삭기로 면삭한다.","doWork":"작업지시서에 따라 금속평면의 절삭할 제품을 확인하여 소재의 종류·형태 등에 따라 면삭방법 및 절차를 결정한다. 면삭기의 유압, 윤활 상태 등을 점검하고 시험 가동한다. 가공품을 호이스트로 운반하여 고정틀을 사용하여 베드 위에 고정한다. 면삭기의 전원을 연결하고 스위치를 오픈한다. 작업명세서에 따라 가공수치 및 데이터를 디지털계기에 입력한다. 작업 공정 중 가공품의 표면 면삭상태를 확인한다. 표면상태, 조도상태, 치수 및 규격 등을 검사한다. 규격과 다를 시 작업표준에 맞도록 교정한다. 가공된 최종 제품을 작업명세서상의 규격 및 수치와 비교한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"자동스카핑조작원","certLic":"컴퓨터응용가공산업기사","dJobECd":"8132","dJobECdNm":"[8132]금속 공작기계 조작원","dJobJCd":"8510","dJobJCdNm":"[8510]금속 공작 기계 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002794:1', '{"dJobCd":"K000002794","dJobCdSeq":"1","dJobNm":"자동연마기조작원","workSum":"금속재의 슬래브표면을 갈거나 매끈하게 하기 위하여 자동연마기로 금속표면의 흠이나 피로층을 제거한다.","doWork":"작업지시서에 따라 금속평면의 연마할 제품을 확인한다. 소재의 종류·형태 등에 따라 연마석, 연마방법 및 절차를 결정한다. 연마기의 유압, 윤활상태 등을 점검하고 시험 가동한다. 가공품을 호이스트로 운반하여 고정틀을 사용하여 작업대에 고정한다. 연마기의 전원을 연결하고 스위치를 오픈한다. 작업명세서에 따라 가공수치 및 데이터를 디지털계기에 입력한다. 가공품에 적당한 연마석을 기계에 장착한다. 기계를 작동시켜 가공품을 연마한다. 작업공정 중 가공품의 표면연마 상태를 확인한다. 표면상태, 조도상태, 치수 및 규격 등을 검사한다. 규격과 다를 시 작업표준에 맞도록 교정한다. 가공된 최종 제품을 작업명세서상의 규격 및 수치와 비교한다. 완성된 제품은 다음 공정을 위하여 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8132","dJobECdNm":"[8132]금속 공작기계 조작원","dJobJCd":"8510","dJobJCdNm":"[8510]금속 공작 기계 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003199:1', '{"dJobCd":"K000003199","dJobCdSeq":"1","dJobNm":"전기전자장비부품가공원","workSum":"전기전자장비의 부품과 재료를 가공 처리하기 위하여 기계가공장비를 사용하여 전동기, 발전기, 변압기 등의 부품 또는 재료를 절단하거나 일정한 모양으로 가공한다.","doWork":"전동기, 발전기, 변압기 등과 같은 전기장비의 외형 틀이나 축, 각종 부품을 가공하기 위하여 선반이나 밀링머신, 드릴링머신, 보링머신, 프레스기, 절단기 등을 사용하여 표시된 위치에 구멍을 내거나 필요한 치수에 따라 강판을 절단하거나 구부리며 압착한다. 조작하는 장비에 따라 선반작업, 밀링작업, 드릴작업 등을 수행한다. 작업이 완료되면 다음 공정으로 가공품을 보낸다. 결정체 조각·땜납·금속원판·리드선 같은 부품과 재료를 용융하기 전에 배치하기도 한다. 부품을 일정한 틀 안에 끼우기 위해 용접하고, 압축·접착시키는 종류의 작업을 수행하는 관련 장비를 다루기도 한다. 작업효율 향상 및 생산기준을 관리하기 위하여 간단한 수리작업과 소제작업을 수행하기도 한다. 명세서와 일치하는지를 확인하기 위하여 전자시험장비를 사용하여 부품을 시험하기도 한다. 제조의 결함이나 홈을 살피기 위해 현미경과 확대가구를 사용하여 부품을 시험하기도 한다. 특수한 분류 및 측정기구를 사용하여 전기특성에 따라 부품을 분류하기도 한다. 작업이 끝나면 작업내용을 기록·보관한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"컴퓨터응용가공산업기사","dJobECd":"8132","dJobECdNm":"[8132]금속 공작기계 조작원","dJobJCd":"8510","dJobJCdNm":"[8510]금속 공작 기계 조작원","dJobICd":"C281","dJobICdNm":"[C281]전동기, 발전기 및 전기 변환ㆍ 공급ㆍ제어 장치 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006230:1', '{"dJobCd":"K000006230","dJobCdSeq":"1","dJobNm":"전단기조작원","workSum":"압연가공한 철판코일 등의 금속재료를 명세된 길이로 자르는 전단기(Shear Line)를 조작한다.","doWork":"작업명세서에 따라 전단할 제품을 확인한다. 생산계획에 따라 전단할 제품의 종류와 형태에 따라 장비를 조정한다. 스위치를 넣어 전단기를 작동시키고 핀치롤의 상하조정기 및 유도장치를 조정하며 전단입구를 개폐한다. 언코일러(Uncoiler:코일을 되감는 장치)에 장착된 코일을 정밀 레벨러에서 평탄하도록 한다. 프레스에 코일을 투입한다. 메스샤링롤에 길이를 검출하여 제품을 일정 길이로 절단한다. 기계의 작동상태 및 전단상태를 점검·확인한다. 절단된 제품을 파일럿에 적재한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"시범후 30일 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"샤링기조작원","dJobECd":"8132","dJobECdNm":"[8132]금속 공작기계 조작원","dJobJCd":"8510","dJobJCdNm":"[8510]금속 공작 기계 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001572:1', '{"dJobCd":"K000001572","dJobCdSeq":"1","dJobNm":"절곡기조작원","workSum":"금속판이나 자재를 도면에 따라 일정한 각이나 윤곽에 따라 구부리기 위해 절곡기(동력프레스기)를 조작한다.","doWork":"작업지시서나 작업표준에 따라 작업방법을 정한다. 정반에 금형을 올려놓고 지지대를 고정한다. 치수, 직각, 각도, 대각을 입력하고 기기의 작동상태와 윤활상태를 점검한다. 도면을 참고하여 적절한 공기압력과 유압을 조정하여 장비를 작동한다. 성형된 제품을 줄자, 버니어캘리퍼스, 직각자, 각도기를 사용하여 직각, 치수, 각도, 대각을 확인하여 이상이 없으면 자동화 절곡기로 다량생산을 실시한다. 작업이 끝나면 금형상태를 확인한 후 정비한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"벤딩기조작원, 절곡원","connectJob":"샤링절단원, 철판샤링절단기조작원, 유압샤링절단기조작원, SHEARING절단기조작원, V-CUTTING기조작원, 금속절곡기조작원, 샤링벤딩기조작원, 롤러벤딩기조작원, 절단절곡기조작원, NC절곡기조작원, 금속CNC절곡기조작원, CNC벤딩기조작원. 샤링절곡기조작원, 스텐EGI절단기조작원, 절곡커팅기조작원, 와이어벤딩기조작원, 유압절곡기조작원, V커팅기조작원, 형강류벤딩조작원, 롤포밍기조작원, 포밍기조작원","certLic":"컴퓨터응용가공산업기사","dJobECd":"8132","dJobECdNm":"[8132]금속 공작기계 조작원","dJobJCd":"8510","dJobJCdNm":"[8510]금속 공작 기계 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004878:1', '{"dJobCd":"K000004878","dJobCdSeq":"1","dJobNm":"주화면삭원","workSum":"용해되어 주조된 슬래브(Slab)표면에 묻은 이물질을 제거하고 일정한 두께로 면삭 가공하는 기계를 조작한다.","doWork":"면삭기 장입구에 천장크레인이나 지게차로 판재코일을 놓는다. 언코일러에 자동으로 장착되는 것을 확인한다. 면삭기를 수동으로 조작하여 판재의 선단을 물린다. 면삭정도에 따라 면삭칼날의 마모정도를 점검하고 교체한다. 평탄도와 판재의 불규칙한 좌우 양면을 절삭하여 리코일한다. 선후단과 양옆의 불규칙한 절단면을 절삭한다. 자동으로 취합된 절삭 스크립을 다음 용해 시 사용할 수 있도록 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8132","dJobECdNm":"[8132]금속 공작기계 조작원","dJobJCd":"8510","dJobJCdNm":"[8510]금속 공작 기계 조작원","dJobICd":"C331","dJobICdNm":"[C331]귀금속 및 장신용품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003994:1', '{"dJobCd":"K000003994","dJobCdSeq":"1","dJobNm":"캠가공원","workSum":"작업지시서 및 도면에 따라 금속재료로부터 수평캠, 경사캠, 평면캠, 입체캠을 가공하기 위해 캠밀링머신을 작동하여 캠을 가공한다.","doWork":"작업지시서에 따라 가공할 제품을 확인한다. 소재의 종류·형태 등에 따라 가공방법 및 절차를 결정한다. 캠밀링기의 유압, 윤활상태 등을 점검하고 시험 가동한다. 회전속도 및 피드를 설정하여 게이지에 입력한다. 마스터캠과 공작물을 동축 사이에 놓는다. 마스터캠을 스프링으로 롤러에 밀어붙인다. 기계를 작동하여 롤러를 회전시켜 연삭작업을 한다. 마이크로미터나 측정기기를 사용하여 작업명세서의 일치 여부를 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"컴퓨터응용가공산업기사, 컴퓨터응용밀링기능사","dJobECd":"8132","dJobECdNm":"[8132]금속 공작기계 조작원","dJobJCd":"8510","dJobJCdNm":"[8510]금속 공작 기계 조작원","dJobICd":"C291","dJobICdNm":"[C291]일반 목적용 기계 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005376:1', '{"dJobCd":"K000005376","dJobCdSeq":"1","dJobNm":"컴퓨터자동조각기조작원","workSum":"컴퓨터자동조각기를 조작하여 수공으로 조각하기 어려운 부분모형을 조각한다.","doWork":"컴퓨터를 이용하여 모형의 부분별 전개도를 그린다. CAM(컴퓨터자동조각기)에 자동으로 조작할 수 있도록 프로그래밍을 한다. 프로그램된 데이터를 CAM에 입력시켜 조작한다. CAM에 의해 조각되는 부분별 모형을 확인하고 잘못된 부분을 수정하여 조각한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"컴퓨터응용가공산업기사","dJobECd":"8132","dJobECdNm":"[8132]금속 공작기계 조작원","dJobJCd":"8510","dJobJCdNm":"[8510]금속 공작 기계 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006793:1', '{"dJobCd":"K000006793","dJobCdSeq":"1","dJobNm":"탭핑원","workSum":"주조된 제품에 탭핑기(Tapping Machine)를 이용하여 탭(Tap)을 가공한다.","doWork":"작업지시도와 제품도면을 검토하여 탭(Tap) 가공의 위치를 확인한다. 탭핑기에 필요한 나사날을 교체하고 가공한 주조품을 탭핑기에 고정한다. 버튼을 눌러 탭핑 위치와 나사날의 위치가 일치하는지 확인한 후 탭핑기를 작동시켜 제품에 탭을 가공한다. 가공된 제품이 규격과 일치하는지 확인한 후 이상이 없으면 적재한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"태핑기조작원","certLic":"컴퓨터응용가공산업기사","dJobECd":"8132","dJobECdNm":"[8132]금속 공작기계 조작원","dJobJCd":"8510","dJobJCdNm":"[8510]금속 공작 기계 조작원","dJobICd":"C243","dJobICdNm":"[C243]금속 주조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001364:1', '{"dJobCd":"K000001364","dJobCdSeq":"1","dJobNm":"톱날절단원","workSum":"명세된 규격에 따라 금속 및 비철금속을 일정 길이로 자르는 절단기를 조작한다.","doWork":"절단할 제품의 종류나 재질에 따라 절단속도를 조정한다. 자, 조립게이지, 형판 등을 사용하여 절단길이에 맞추어 정지장치를 설치·고정한다. 정치장치 반대쪽 기계베드 위에 소재를 올려놓는다. 고정구나 손으로 절단할 소재를 고정시키고, 스위치를 조작하여 절단날 및 이송용 컨베이어벨트를 작동한다. 절단 방법 및 절차에 따라 소재를 명세된 길이로 절단한다. 절단되는 소재와 톱날의 마찰열로 인한 피해를 방지하기 위하여 물배관 밸브를 연다. 균열 및 홈 등의 결함부분, 규정된 길이 등으로 절단·제거한다. 치수를 확인하기 위해 게이지·형판·자 등의 측정기구를 사용하여 측정한다. 작업일지에 일일생산량을 기록한다. 절단기의 간단한 수리 및 정비를 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"원형톱절단원, 띠톱절단원, 핫쇼절단원, 원형톱기계조작원, 대톱기계조작원, 마찰톱기계조작원","dJobECd":"8132","dJobECdNm":"[8132]금속 공작기계 조작원","dJobJCd":"8510","dJobJCdNm":"[8510]금속 공작 기계 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002404:1', '{"dJobCd":"K000002404","dJobCdSeq":"1","dJobNm":"트리밍기조작원","workSum":"성형된 제품의 버(Burr:금속을 잘랐을 때 생기는 가시 모양의 그루터기), 테두리 등 필요 없는 부분을 제거하기 위해 트리밍기를 조작한다.","doWork":"작업지시서나 작업표준에 따라 프레스의 작동상태 및 안전장치 작동 여부, 윤활상태를 점검하여 이상이 있을 시 정비한다. 금형 위에 프레스 성형된 제품을 올려놓는다. 최종 제품의 형상과 관계없는 테두리 및 기타 절단하고자 하는 부위를 결정한다. 장비를 작동시켜 필요 없는 부분을 절단한다. 버니어캘리퍼스나 마이크로미터를 사용하여 수치를 측정한다. 이상 없는 제품을 적재하여 타 공정라인으로 이동한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"트리밍원","dJobECd":"8132","dJobECdNm":"[8132]금속 공작기계 조작원","dJobJCd":"8510","dJobJCdNm":"[8510]금속 공작 기계 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001700:1', '{"dJobCd":"K000001700","dJobCdSeq":"1","dJobNm":"펀칭가공원","workSum":"작업지시서 및 도면에 따라 절단한 강판 등 가공물의 펀칭가공을 위해 펀칭머신을 작동하여 구멍을 낸다.","doWork":"작업지시서에 따라 가공할 제품을 확인한다. 소재의 종류·형태 등에 따라 가공방법을 결정한다. 펀칭머신의 유압, 윤활상태 등을 점검하고 시험 가동한다. 펀칭머신을 작동하여 초품을 가공한다. 초품의 규격이 작업명세서와 일치하면 연속작업을 한다. 마이크로미터나 측정기기를 사용하여 작업명세서의 일치 여부를 확인한다. 완성된 제품은 다음 공정을 위하여 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8132","dJobECdNm":"[8132]금속 공작기계 조작원","dJobJCd":"8510","dJobJCdNm":"[8510]금속 공작 기계 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001813:1', '{"dJobCd":"K000001813","dJobCdSeq":"1","dJobNm":"프레스조작원","workSum":"원자재 또는 절단된 자재를 원하는 형상으로 성형하기 위해 프레스기를 작동한다.","doWork":"작업을 하기 위한 절단소재를 이동한다. 작업지시서, 작업표준, 도면을 읽고 금형을 선택하여 고정한다. 상부, 하부 금형의 고정상태, 안전장치, 윤활상태 등을 점검한다. 소재를 금형 위에 위치시키고 프레스기를 조작한다. 줄자나 버니어캘리퍼스를 이용해 초도 작업물의 치수를 재고 외관 등을 검사한다. 초도 작업물에 이상이 없으면 연속작업을 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"기계프레스조작원","connectJob":"핀프레스조작원, 유압프레스조작원, 고속프레스조작원, 액압프레스조작원, 수치제어프레스조작원(NC프레스조작원), 파워프레스조작원, 프레스재단원, 프레스가공기술자, 프레스절단가공원, NC프레스가공원, 수동프레스기조작원, 유공압프레스기조작원","certLic":"컴퓨터응용가공산업기사","dJobECd":"8132","dJobECdNm":"[8132]금속 공작기계 조작원","dJobJCd":"8510","dJobJCdNm":"[8510]금속 공작 기계 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001597:1', '{"dJobCd":"K000001597","dJobCdSeq":"1","dJobNm":"핫프레스포밍작업원","workSum":"가열로에 의해 고온으로 가열된 원자재 또는 절단된 철판소재를 원하는 형상으로 성형하기 위해 프레스 기계를 조작한다.","doWork":"제품도에서 요구하는 인장강도를 확보하기 위해 가열, 이송, 성형, 냉각조건, 후가공 등의 작업내용을 확인한다. 작업지시서와 작업표준 및 금형조건을 확인한다. 프레스 기계를 작동유무를 확인 후 상하형 금형을 프레스 기계에 셋팅한다. 상부, 하부 금형의 고정상태, 안전장치, 윤활상태, 하형 냉각구조 등을 점검한다. 가열로에서 가열된 철판소재가 하형금형 안착을 확인한 후 프레스기를 조작한다. 프레스작업 사이클 타임을 체크하고 초도작업품의 냉각상태를 확인한 후 크랙과 소착 등의 외관품질이 이상이 없으면 연속작업을 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"기계프레스 조작원","dJobECd":"8132","dJobECdNm":"[8132]금속 공작기계 조작원","dJobJCd":"8510","dJobJCdNm":"[8510]금속 공작 기계 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006775:1', '{"dJobCd":"K000006775","dJobCdSeq":"1","dJobNm":"호빙기조작원","workSum":"작업지시서 및 도면에 따라 금속가공물에 기어를 가공하기 위하여 호빙기를 조작한다.","doWork":"작업지시서나 도면에 따라 기어절삭공구(호프) 및 고정구 등을 준비한다. 가공치수를 확인하고 기어의 오차범위, 기기정수, 빗각(옵티컬각)을 제어판에 입력하여 결정한다. 프로그램 데이터를 입력하기도 한다. 공작물을 고정구에 조이고 기계의 중심부분에 축을 장치한다. 렌치를 사용하여 공작물과 관련된 축에 기어절삭공구를 고정한다. 작업물을 고정구(지그)에 고정한다. CNC제어판의 각종 경고표시를 확인한다. 버튼조작으로 기계를 가동시키고 자동프로그램으로 이송률, 공작물회전속도를 조절하면서 공작물의 가공 상태, 장치의 작동을 관찰한다. 작업 중 문제가 발생하면 기기를 중지시키고 작업반장에게 보고한다. 초도 작업물에 이상이 없으면 프로그램 및 수치를 고정하고 연속작업을 한다. 작업결과물의 수치, 상태를 측정기기로 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"호빙작업원, 기어가공원","dJobECd":"8132","dJobECdNm":"[8132]금속 공작기계 조작원","dJobJCd":"8510","dJobJCdNm":"[8510]금속 공작 기계 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004729:1', '{"dJobCd":"K000004729","dJobCdSeq":"1","dJobNm":"냉동공조설비유지관리원","workSum":"냉동공조 설비를 최적의 상태로 유지하기 위하여 설비의 점검 및 진단하여 성능과 효율을 관리한다.","doWork":"냉동공조 및 열원장치가 제 성능을 유지하면서 지속적으로 가동될 수 있도록 점검 및 보수 계획을 수립한다. 냉동공조 설비의 에너지절약 및 열효율을 극대화하기 위하여 가스, 유류, 전기 등의 에너지사용량을 측정, 분석하고 시행한다. 유지보수 계획에 따라 공조 및 열원설비 등의 내구수명 유지 및 성능저하 방지를 위해 보수하고 시운전을 한다. 감시제어반, 전자밸브, 제어밸브, 전원차단, 제어설비센서, 판넬 배선 등 제어시스템을 유지·보수·관리한다. 관련 법규를 파악하여 법정검사를 준비하고 안전관리교육을 실시한다. 공조설비의 기능을 최적의 상태로 운영하기 위하여 공기조화기 및 부속장치를 점검, 보수 및 진단한다. 냉동기, 보일러, 냉각탑, 열펌프, 열교환기, 축열조 및 기타 열의 생산과 관련 있는 부속설비 일체를 효율적으로 운영 및 관리한다. 유지보수를 위하여 필요한 소모품, 공구 및 측정기기 등의 자재를 필요한 시점에 공급할 수 있도록 계획을 세워 구매하고 관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"영선원, 공무원","connectJob":"공업용냉동냉장기계시설관리조작원, 공업용냉장기영선원, 공업용냉동기영선원, 공업용냉장기영선원, 공업용냉동시설관리원, 공업용냉동기계설비관리원, 공업용냉동기계관리원, 공조설비유지관리원","certLic":"공조냉동기계기능사, 공조냉동기계산업기사","dJobECd":"8140","dJobECdNm":"[8140]냉·난방 설비 조작원","dJobJCd":"8520","dJobJCdNm":"[8520]냉난방 관련 설비 조작원","dJobICd":"D353","dJobICdNm":"[D353]증기, 냉·온수 및 공기조절 공급업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001385:1', '{"dJobCd":"K000001385","dJobCdSeq":"1","dJobNm":"냉방설비조작원","workSum":"공장설비 및 사무실 가동에 사용되는 냉방설비를 점검하고 조작한다.","doWork":"냉방설비를 자동 또는 수동으로 가동한다. 냉방설비 및 공기조화시설 등의 본체와 부속설비의 온도 및 습도 등의 정상 여부를 확인한다. 냉방시설을 순찰하고 감시한다. 고장 시 응급조치를 한다. 정기적으로 설비의 이상 유무 등을 점검하고 일지에 기록한다. 정기적으로 냉방설비 및 보조설비를 유지·관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"공업용냉동기조작원, 공업용냉장기조작원, 공업용얼음제조기조작원, 공업용냉각장치조작원, 산업용냉장시스템조작원, 선박냉동기조작원","certLic":"공조냉동기계기능사, 공조냉동기계산업기사","dJobECd":"8140","dJobECdNm":"[8140]냉·난방 설비 조작원","dJobJCd":"8520","dJobJCdNm":"[8520]냉난방 관련 설비 조작원","dJobICd":"D353","dJobICdNm":"[D353]증기, 냉·온수 및 공기조절 공급업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003477:1', '{"dJobCd":"K000003477","dJobCdSeq":"1","dJobNm":"보일러조작원","workSum":"공장용 또는 건물용 보일러 및 보조설비를 조작하여 운영한다.","doWork":"컴퓨터제어장치를 이용하여 원격으로 보일러를 가동한다. 보일러 본체와 부속설비 게이지의 온도, 압력, 수위 등의 정상 여부를 원격으로 확인한다. 보일러 시설을 순찰, 감시하며 문제점을 파악한다. 비정상 시 자동 및 수동으로 온도, 압력 등을 조정한다. 고장 시 응급조치요령에 따라 조치를 취한다. 정기적으로 보일러 및 보조설비의 이상 유무 등을 점검하고 점검일지에 기록한다. 정기적으로 보일러 및 보일러보조설비를 유지·관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"아파트보일러영선원, 아파트보일러기계실영선원, 아파트보일러기계설비조작원, 빌딩보일러조작원, 대중목욕탕보일러조작원, 빌딩보일러조작원, 빌딩냉난방기계실설비조작원, 건물냉난방기계설비조작원, 아파트냉난방기계시설관리조작원, 찜질방보일러공무, 목욕탕보일러공무, 사우나보일러공무, 백화점보일러기계공무, 병원보일러기계설비원, 학교보일러기계설비원, 오피스빌딩보일러기계설비원, 수영장보일러실공무, 건물보일러운전원, 건물보일러조작원, 건물보일러관리원, 건물보일러난방기사, 건물보일러영선원","certLic":"에너지관리기능사, 에너지관리산업기사","dJobECd":"8140","dJobECdNm":"[8140]냉·난방 설비 조작원","dJobJCd":"8520","dJobJCdNm":"[8520]냉난방 관련 설비 조작원","dJobICd":"D353","dJobICdNm":"[D353]증기, 냉·온수 및 공기조절 공급업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003639:1', '{"dJobCd":"K000003639","dJobCdSeq":"1","dJobNm":"식용얼음제조원","workSum":"식용 얼음을 제조하기 위하여 제빙기, 분쇄기, 선별기, 계량기, 포장기 등을 조작·관리한다.","doWork":"취수, 살균 및 정수과정을 거친 물을 얼음 성형틀에 채워 결빙한다. 결빙이 완료되면 상온의 물을 흘려주어 성형틀과 원빙이 분리되도록 용빙기를 작동한다. 분리된 원빙을 제품에 따라 판얼음으로 제조하거나 컨베이어벨트를 이용하여 쇄빙공정으로 이송한다. 분쇄기를 사용하여 원빙을 규격에 맞게 분쇄한다. 쇄빙된 얼음은 선별기로 이송하여 규격과 맞지 않는 얼음을 분리한다. 선별이 완료된 분쇄 얼음은 제품에 따라 비닐 또는 컵에 채워 포장한다. 포장이 완료된 제품은 저장창고로 이송하고 출하되기 전까지 저온에서 보관한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"저온|다습|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"제빙기조작원, 제빙기기사","certLic":"공조냉동기계기능사","dJobECd":"8140","dJobECdNm":"[8140]냉·난방 설비 조작원","dJobJCd":"8520","dJobJCdNm":"[8520]냉난방 관련 설비 조작원","dJobICd":"C112","dJobICdNm":"[C112]비알코올음료 및 얼음 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003496:1', '{"dJobCd":"K000003496","dJobCdSeq":"1","dJobNm":"염색용얼음제조원","workSum":"산성염료 및 염료중간체의 1차 반응물을 적정 온도로 유지하기 위해 얼음을 제조하고 분쇄해 각 부서로 이송한다.","doWork":"작업지시서의 내용에 따라 일일생산량과 각 부서에서 필요한 양을 확인한다. 작업에 들어가기 전에 제빙기, 물(용수) 공급파이프 및 기타 장비의 작동상태를 점검한다. 제빙기에 용수를 공급하기 위하여 밸브를 열고 펌프를 가동한다. 물이 다 채워지면 제빙기의 온도를 확인하고 가동한다. 가동 중 결빙상태를 수시로 관찰한다. 불순물의 유입 여부를 검사한다. 육안으로 확인 가능한 불순물은 집게 등을 사용하여 제거한다. 결빙이 완료되면 대차에 실어 냉동실로 운반·보관한다. 냉동실의 얼음을 쇄빙기(Crusher)로 분쇄하고, 분쇄된 얼음조각을 송풍기를 이용하여 얼음이 필요한 부서로 보낸다. 얼음 이송 중 압축기의 가동상태를 수시로 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|저온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"제빙원, 제빙기조작원","certLic":"공조냉동기계기능사","dJobECd":"8140","dJobECdNm":"[8140]냉·난방 설비 조작원","dJobJCd":"8520","dJobJCdNm":"[8520]냉난방 관련 설비 조작원","dJobICd":"C112","dJobICdNm":"[C112]비알코올음료 및 얼음 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002498:1', '{"dJobCd":"K000002498","dJobCdSeq":"1","dJobNm":"제설기조작원","workSum":"스키장의 슬로프(Slope)에 제설기를 작동하여 눈을 만들어 뿌린다.","doWork":"기온을 측정하여 제설이 가능한 온도인가를 확인한다. 기계실에 무전기로 연락하여 컴프레서와 펌프를 가동한다. 제설기에 압축공기호스와 물호스를 연결하고 레버를 고정한다. 밸브를 열 때 급격한 압력상승으로 인하여 제설기가 넘어지지 않도록 기계를 고정하고 압축공기와 물호스의 밸브를 연결한다. 버튼을 눌러 제설기를 작동한다. 뿌려지는 눈을 확인하고 공기압력과 물의 양을 조절한다. 일정량의 눈이 보충되면 제설기를 조작하여 장소를 이동한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"시범후 30일 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","dJobECd":"8140","dJobECdNm":"[8140]냉·난방 설비 조작원","dJobJCd":"8520","dJobJCdNm":"[8520]냉난방 관련 설비 조작원","dJobICd":"R912","dJobICdNm":"[R912]유원지 및 기타 오락관련 서비스업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004380:1', '{"dJobCd":"K000004380","dJobCdSeq":"1","dJobNm":"폐기물자원화설비운전원","workSum":"폐기물 자원화 설비를 운전한다.","doWork":"폐기물저장조에 하수슬러지가 이상 없이 반입되는지 확인한다. 공급펌프를 가동시켜 슬러지를 파쇄기 호퍼로 이송한다. 푸쉬로드 배출시스템을 확인하고 가교현상(고체 입자군이 중첩될 때, 입자 상호 간의 부착성이나 마찰 등으로 인해 공급파이프에 입자가 걸려 막히는 현상)을 방지한다. 공급펌프의 피스톤 속도를 제어하여 공급량을 조절한다. 파쇄된 슬러지가 미립화되면 건조기로 보내 열풍건조를 한다. 건조기의 온도와 시간이 적정한지 제어판 세팅을 확인한다. 슬러지에서 나는 악취 여부를 검사하여 건조기의 밀폐를 확인한다. 열풍기로 인한 화재 및 분진폭발을 방지하기 위한 안전장치의 구동 여부를 점검한다. 연료로 사용할 수 있을 정도로 슬러지의 함수율이 떨어지면 탄화시키고 탄화된 슬러지를 건조슬러지 저장조로 보낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"음식쓰레기자원화설비운전원, 하수슬러지자원화설비운전원, 바이오매스자원화설비운전원, 사업장폐기물자원화설비운전원","dJobECd":"8140","dJobECdNm":"[8140]냉·난방 설비 조작원","dJobJCd":"8520","dJobJCdNm":"[8520]냉난방 관련 설비 조작원","dJobICd":"C292","dJobICdNm":"[C292]특수 목적용 기계 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001973:1', '{"dJobCd":"K000001973","dJobCdSeq":"1","dJobNm":"흑액연소보일러조작원","workSum":"펄프증해공정에서 발생하는 흑액을 농축시켜 다시 연료로 사용하는 흑액연소보일러 및 부대설비를 조작·관리한다.","doWork":"보일러 및 집진 설비를 순회하며 점검을 통하여 정상적인 작업이 이루어질 수 있도록 예비점검, 유지 및 보수를 한다. 작업지시서를 확인하고 작업공정에 따른 증기공급계획을 수립한다. 조작반에 나타난 각종 설비의 작동상태를 점검하고 이상 유무를 파악한다. 작업계획에 따라 흑액연소용 보일러, 분진회수용 집진기 등의 조작스위치를 조작하여 노 안으로 분사되는 연료의 비율과 온도, 분진의 집진상태를 조정한다. 조작반에 나타난 비정상적인 상태를 해결하기 위하여 흑액연소보일러조작보조원에게 해결하도록 지시하고, 문제점에 대하여 관련 부서에 보고한다. 작업내용을 작업일지에 기록한다. 터빈을 돌리고 남은 스팀이 공장운영 동력으로 사용되도록 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"에너지관리기능사, 에너지관리산업기사","dJobECd":"8140","dJobECdNm":"[8140]냉·난방 설비 조작원","dJobJCd":"8520","dJobJCdNm":"[8520]냉난방 관련 설비 조작원","dJobICd":"C171","dJobICdNm":"[C171]펄프, 종이 및 판지 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001552:1', '{"dJobCd":"K000001552","dJobCdSeq":"1","dJobNm":"블라스팅로봇조작원","workSum":"선박 및 해양시설 건조 시 각종 철의장재, 선박외판, 파이프 등의 후처리 작업을 자동으로 수행하는 블라스팅로봇(Blasting Robot)을 조작한다.","doWork":"작업지시서 또는 도면을 보고 작업위치와 작업방법을 확인한다. 블라스팅로봇(Blasting Robot:고경도 분말이나 입자를 고속으로 분사하여 표면에 붙은 녹, 오물 등을 얇게 깎아 내어 제거하는 로봇) 및 소모자재, 전원공급케이블을 준비한다. 작업위치로 이동하여 작업 시작지점과 종료지점을 확인한다. 로봇의 작동상태를 점검한다. 로봇을 작동시켜 선박 외판의 용접선이나 파이프 내부의 오염물을 제거한다. 로봇의 작동을 관찰하고 필요시 입력패널에 입력요소를 재조정한다. 작업 중에 발생한 분진 및 이물질은 흡입용 호스를 통해 저장탱크로 회수한다. 작업결과를 확인하고 이상이 없으면 로봇을 회수하고 정비한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"선박블라스팅로봇조작원","connectJob":"벽면흡착식블라스팅로봇조작원, 선체외판블라스팅로봇조작원, 스파이더블라스팅로봇조작원","certLic":"용접기능사, 용접산업기사, 용접기능장","dJobECd":"8150","dJobECdNm":"[8150]자동조립라인·산업용로봇 조작원","dJobJCd":"8530","dJobJCdNm":"[8530]자동 조립라인 및 산업용로봇 조작원","dJobICd":"C311","dJobICdNm":"[C311]선박 및 보트 건조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004126:1', '{"dJobCd":"K000004126","dJobCdSeq":"1","dJobNm":"산업용로봇제어조작원","workSum":"산업용로봇을 현장의 작업에 맞게 설치조정하기 위하여 교시하고 제어·조작한다.","doWork":"로봇 제어기의 주된 사용자 인터페이스장치인 조작반(Teaching Pendant)을 이용하여 로봇이 작업할 이동 궤적과 수행 작업에 대한 프로그램을 작성하고 프로그램 파일을 저장·관리한다. 작성된 프로그램을 실행하여 위치를 교시한다. 로봇 동작과 각 관절의 위치를 관찰하고 정확한 작업이 수행되는지 확인하여 제어기 게인(Gain)값을 수정, 입력한다. 방호조치 영역 내에서 로봇의 조작에 대한 안전조치를 취하고 안전운전속도를 확인한다. 산업용로봇이 작업하는 동안 작동상태를 모니터링한다. 컴퓨터 기반의 제어기의 경우 프로그램을 작성하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"수집","workFunc2":"감독","workFunc3":"제어조작","similarNm":"산업용로봇조작원, 자동조립라인조작원, 자동조립기계시설조작원, 자동조립기계설비조작원, 자동화설비조작원","connectJob":"로봇시운전원, 로봇설치원, 로봇프로그래머, 로봇SI전문가","certLic":"생산자동화기능사, 생산자동화산업기사","dJobECd":"8150","dJobECdNm":"[8150]자동조립라인·산업용로봇 조작원","dJobJCd":"8530","dJobJCdNm":"[8530]자동 조립라인 및 산업용로봇 조작원","dJobICd":"C","dJobICdNm":"[C]제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001299:1', '{"dJobCd":"K000001299","dJobCdSeq":"1","dJobNm":"선박용접로봇조작원","workSum":"선박 및 해양구조물의 건조 시 각종 철구조물을 용접하기 위하여 용접로봇을 조작한다.","doWork":"작업지시서 또는 도면을 보고 작업위치와 작업방법을 확인한다. 자동용접로봇 및 용접자재를 준비한다. 로봇의 본체, 용접유닛(용접헤드), 용접재료 공급장치, 추적센서, 보조장치 등의 상태를 점검한다. 입력패널에 용접속도, 전류, 전압, 토치각 등을 입력한다. 로봇을 작동시켜 블록, 탱크, 스테인리스파이프 등에 용접을 실시한다. 로봇의 작동을 관찰하고 이상발생 시 간단한 문제는 자체 해결하고 필요시 관련 부서에 조치를 의뢰한다. 입력패널을 조작해서 로봇을 조정하기도 한다. 작업이 종료되면 용접상태를 검사한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"용접로봇조작원","certLic":"용접기능사, 용접산업기사, 용접기능장, 가스텅스텐아크용접기능사, 이산화탄소가스아크용접기능사","dJobECd":"8150","dJobECdNm":"[8150]자동조립라인·산업용로봇 조작원","dJobJCd":"8530","dJobJCdNm":"[8530]자동 조립라인 및 산업용로봇 조작원","dJobICd":"C311","dJobICdNm":"[C311]선박 및 보트 건조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006599:1', '{"dJobCd":"K000006599","dJobCdSeq":"1","dJobNm":"자동차용접로봇조작원","workSum":"차체 조립 시 사용되는 용접로봇에 용접프로그램을 입력하고 작동상태를 확인한다.","doWork":"차종에 따라 미리 준비된 구동 프로그램을 입력한다. 소모자재의 재고와 공급을 확인한다. 자동차생산계획에 따라 컨베이어 시스템으로 차체가 이송되며 차체에 사이드 판넬(Side Panel)과 도어가 자동 이송되고 있는지 확인한다. 이송된 판넬 부품이 용접대 위에 정확히 자리 잡아 자동 용접공정에 문제가 발생하지 않도록 확인한다. 자동으로 용접이 수행되면 이상 유무를 확인하고 로봇이 정상적으로 작동되는지 감시한다. 이상 발생 시 간단한 문제는 자체 해결한다. 필요시 관련 부서에 조치를 의뢰하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"용접로봇조작원","certLic":"용접기능사, 특수용접기능사","dJobECd":"8150","dJobECdNm":"[8150]자동조립라인·산업용로봇 조작원","dJobJCd":"8530","dJobJCdNm":"[8530]자동 조립라인 및 산업용로봇 조작원","dJobICd":"C301","dJobICdNm":"[C301]자동차용 엔진 및 자동차 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003886:1', '{"dJobCd":"K000003886","dJobCdSeq":"1","dJobNm":"적재로봇조작원","workSum":"출고제품을 팔레트에 적재하는 로봇을 조정한다.","doWork":"작업지시서를 보고 출고될 제품의 규격과 수량 등을 확인한다. 로봇의 팔레트(화물 운반 및 저장용 받침대) 적재 작업을 위해 로봇조종패널에 이동경로, 제품의 특성 및 규격 등에 관한 요소를 입력한다. 로봇을 시운전하고 점검한다. 로봇을 구동한다. 로봇의 팔레타이징 작업(Palletizing:팔레트를 자동으로 공급하고 운반하는 작업)을 관찰하고 필요시 입력요소를 재조정한다. 고장 시 응급조치를 취하며 기본 정비를 하거나 필요시 관련 부서에 정비를 요청한다. 작업 후 작업수량 등을 작업일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"로봇적재기조작원","dJobECd":"8150","dJobECdNm":"[8150]자동조립라인·산업용로봇 조작원","dJobJCd":"8530","dJobJCdNm":"[8530]자동 조립라인 및 산업용로봇 조작원","dJobICd":"C","dJobICdNm":"[C]제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004310:1', '{"dJobCd":"K000004310","dJobCdSeq":"1","dJobNm":"대형차섀시조립반장","workSum":"대형차 섀시(Chassis)에 엔진 및 연료탱크 및 각종 부품을 조립하는 작업원의 활동을 감독한다.","doWork":"자동차의 종류에 따라 조립도면을 확인하고 작업표준에 의하여 작업방법을 결정한다. 각 공정에 작업원을 배치하고 조립 자동차의 생산량, 차종 등에 따라 조립방법을 설명한다. 작업표준에 따라 엔진, 동력전달장치, 현가장치, 조향장치, 브레이크장치 등의 조립계획을 수립한다. 조립에 필요한 부품을 조달하고 재고를 관리한다. 조립공정에 따라 작업원을 배치하고 조립장비를 점검하며 조립방법을 설명한다. 작업장을 순회하여 작업활동을 감독하고 조립된 상태를 점검하며 기술을 지도한다. 결함사항을 기록하고 통계를 담당 부서에 통보한다. 작업장의 환경개선을 위하여 건의하며 작업원의 안전과 위생, 건강을 점검한다. 조립품을 검사하여 명세서와 비교한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"수동조작","dJobECd":"8171","dJobECdNm":"[8171]자동차 조립원","dJobJCd":"8541","dJobJCdNm":"[8541]자동차 조립원","dJobICd":"C301","dJobICdNm":"[C301]자동차용 엔진 및 자동차 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001656:1', '{"dJobCd":"K000001656","dJobCdSeq":"1","dJobNm":"대형차섀시조립원","workSum":"완성된 대형차 프레임에 엔진, 연료탱크 등 각종 섀시(Chassis)부품을 조립하거나 장착한다.","doWork":"버스 등 대형 차종에 따라 도면을 확인하고 작업표준에 의해 작업방법을 결정한다. 각종 공구와 장비를 준비하고 조립할 섀시부품을 확인한다. 전방, 중앙, 후방 섀시를 조립하기 위해 지그를 설치한다. 지그의 위치에 맞춰 전방, 중앙, 후방 섀시를 설치하고 볼트로 조이거나 용접하여 고정한다. 수동 및 동력공구를 사용하여 엔진, 구동장치, 조향장치, 제동장치 등을 조립순서에 따라 프레임에 조립한다. 각종 배선, 배관 등을 연결한다. 자동차의 전후차축 타이어, 판스프링, 스티어링유닛, 연료탱크 등을 조립한다. 윤활유를 주입하고 타이어에 공기를 넣어 압력을 조정한다. 조립된 섀시부품을 검사하여 이상 여부를 확인한다. 엔진변속기 등 필요한 서브 부품을 조립하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|","workEnv":"소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8171","dJobECdNm":"[8171]자동차 조립원","dJobJCd":"8541","dJobJCdNm":"[8541]자동차 조립원","dJobICd":"C301","dJobICdNm":"[C301]자동차용 엔진 및 자동차 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002455:1', '{"dJobCd":"K000002455","dJobCdSeq":"1","dJobNm":"대형차의장조립반장","workSum":"버스, 특장차, 산업용차 등의 대형 차체 내외부에 각종 의장부품 조립에 종사하는 작업원의 활동을 감독한다.","doWork":"생산계획에 따라 차량의 종류와 수량을 확인하고 조립에 필요한 자재의 재고를 확인하고 조달한다. 의장조립라인에 작업원을 배치하고 작업방법, 작업량을 지시한다. 공장을 순회하며 작업활동을 감독한다. 작업원들에게 기술지도를 하기도 한다. 조립품을 검사하여 명세서와 비교한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"수동조작","dJobECd":"8171","dJobECdNm":"[8171]자동차 조립원","dJobJCd":"8541","dJobJCdNm":"[8541]자동차 조립원","dJobICd":"C301","dJobICdNm":"[C301]자동차용 엔진 및 자동차 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001525:1', '{"dJobCd":"K000001525","dJobCdSeq":"1","dJobNm":"대형차의장조립원","workSum":"버스, 특장차, 산업용차 등의 대형차체 내·외부에 각종 의장부품을 조립·장착한다.","doWork":"바디에 붙어있는 작업표를 보고 자재의 수량, 종류를 확인하고 각종 공구와 볼트, 너트, 리벳, 본드 등 작업도구를 준비한다. 트롤리 컨베이어 시스템에 의해 이동하는 작업장에서 작업도면 및 순서에 따라 배선, 유리, 목재, 후사경, 벨트, 알루미늄범퍼 등의 각종 의장부품을 조립하거나 장착한다. 차체에 유압배관을 설치한다. 각종 철골 구조물 등 차량의 기능에 따라 상부 의장품을 탑재한다. 조립·장착된 의장품의 상태를 점검하여 조정 및 수정한다. 선반, 도어, 배전판 등을 조립하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"버스의장조립원, 특장차의장조립원, 실내의장원, 합판장착조립원, 배선원, 유압배관원","dJobECd":"8171","dJobECdNm":"[8171]자동차 조립원","dJobJCd":"8541","dJobJCdNm":"[8541]자동차 조립원","dJobICd":"C301","dJobICdNm":"[C301]자동차용 엔진 및 자동차 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005799:1', '{"dJobCd":"K000005799","dJobCdSeq":"1","dJobNm":"대형차차체조립원","workSum":"버스 등과 같은 대형차의 차체 조립에 사용되는 앞장, 옆장, 뒷장, 천정 등을 조립하거나 조립된 반제품을 섀시프레임(Chassis Frame)에 조립하여 보디를 완성한다.","doWork":"섀시프레임(Chassis Frame)에 앞장, 옆장, 천정 등을 조립하기 위하여 조립지그에 골조를 설치한다. 조립지그에 앞장, 옆장, 천정 등을 조립하고 가용접한다. 골조의 조립상태를 점검하여 수정한다. 판넬을 조립하고 현도, 드릴, 리베팅한다. 조립이 완성되면 골조에 차체를 끼우고 조임쇠 버클 등을 사용하여 고정시키고 용접한다. 보디 내부의 벽면에 패널, 브래킷을 조립·부착한다. 가용접 부위를 모두 용접한다. 용접부분을 그라인더 등으로 사상하여 표면을 정리한다. 제품이 도면과 일치되는지 확인하고 필요시 수정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"자동차차체부분품조립원","certLic":"용접기능사, 특수용접기능사","dJobECd":"8171","dJobECdNm":"[8171]자동차 조립원","dJobJCd":"8541","dJobJCdNm":"[8541]자동차 조립원","dJobICd":"C301","dJobICdNm":"[C301]자동차용 엔진 및 자동차 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006340:1', '{"dJobCd":"K000006340","dJobCdSeq":"1","dJobNm":"자동차검사반장","workSum":"완성된 자동차의 차체, 외장, 섀시, 전장품의 조립 및 성능상태를 검사하는 작업원의 활동을 감독·조정한다.","doWork":"작업표준에 의하여 조립·완성된 자동차의 생산량, 차종 등에 따라 어셈블리 인스펙션라인의 차체, 외장, 섀시, 조립, 품질 등의 검사계획을 수립한다. 차종에 따라 프레스의 철판 절단 및 압축성형상태, 차체 프레스철판의 용접, 조립상태, 차체의 방음, 방진, 방청 처리 및 색도장 상태, 의장부분인 차체의 내·외장 및 섀시조립 상태 등의 검사항목을 확인한다. 검사부분에 따라 작업원을 배치하고 검사장비를 점검하며 검사방법을 설명한다. 검사작업장을 순회하여 작업활동을 감독하고 작성된 검사카드를 점검한다. 결함사항을 기록하고 담당 부서에 통보한다. 작업장의 환경개선을 위하여 건의하며 작업원의 안전과 위생, 건강을 점검한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"수동조작","certLic":"자동차정비기능사, 자동차정비산업기사, 자동차정비기능장","dJobECd":"8171","dJobECdNm":"[8171]자동차 조립원","dJobJCd":"8541","dJobJCdNm":"[8541]자동차 조립원","dJobICd":"C301","dJobICdNm":"[C301]자동차용 엔진 및 자동차 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002196:1', '{"dJobCd":"K000002196","dJobCdSeq":"1","dJobNm":"자동차섀시검사원","workSum":"섀시(Chassis)조립공정 또는 완성공정에서 승용차, 트럭, 버스 등 각종 자동차의 섀시부품의 조립상태, 성능, 동작상태 등을 각종 검사기준서 및 도면에 따라 검사한다.","doWork":"프레임, 실린더 블록 등 기관 주요부를 비롯하여 밸브장치, 윤활장치, 냉각장치, 연료장치, 점화장치 등의 엔진 반조립 부품 조립공정 및 섀시조립공정의 소음기, 프로펠러축, 차축·변속기·연료배관, 제동장치배관·현가장치 등의 조립상태, 누유, 누수, 조임토크의 하체검사를 한다. 엔진의 전기, 냉각, 조향 등 각종 장치와 에어콘용 압축기 등의 조립상태·결선상태, 간섭 등을 검사하고 각종 페달류의 유격·동작상태, 기화기의 동작상태, 각종 오일 및 냉각수의 주입량, 조임토크 등의 상체검사를 한다. 엔진을 작동시키고 엔진계기, 전장 및 성능을 검사한다. 전기장치, 공조장치, 안전장치, 내외장품 등의 정상작동 여부를 검사한다. 검사과정에서 발견된 결함을 담당 작업원에게 수정하도록 지시하고 결과를 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"자동차샤시검사원, 자동차새시검사원, 자동차샷시검사원","dJobECd":"8171","dJobECdNm":"[8171]자동차 조립원","dJobJCd":"8541","dJobJCdNm":"[8541]자동차 조립원","dJobICd":"C301","dJobICdNm":"[C301]자동차용 엔진 및 자동차 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003359:1', '{"dJobCd":"K000003359","dJobCdSeq":"1","dJobNm":"자동차서브조립원","workSum":"자동차 조립에 필요한 엔진, 도어, 타이어 등의 자동차부분품을 조립한다.","doWork":"조립품의 종류에 따라 각종 공구 및 장비, 조립부품, 소모품을 준비한다. 자동차조립 메인라인에 연결된 서브라인(Sub Line)에 위치한 수동 및 동력공구를 사용하여 차량생산계획에 의해 순서대로 조립라인에 투입되는 차체에 엔진, 도어, 타이어 등 각종 부품을 조립한다. 조립과정에서 전 부품의 검사를 수행하여 부품의 이상 여부를 확인하고 조치한다. 타이어 공기압을 확인하고 공기를 주입한다. 엔진에 윤활유를 주입한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"자동차부품조립원","connectJob":"도어조립원, 엔진조립원, 타이어서브조립원","dJobECd":"8171","dJobECdNm":"[8171]자동차 조립원","dJobJCd":"8541","dJobJCdNm":"[8541]자동차 조립원","dJobICd":"C301","dJobICdNm":"[C301]자동차용 엔진 및 자동차 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007294:1', '{"dJobCd":"K000007294","dJobCdSeq":"1","dJobNm":"자동차수밀검사원","workSum":"완성된 차량의 실내로 물이 유입되는지 여부를 검사한다.","doWork":"완성 차량을 수밀(水密, Watertight)검사장으로 운전하여 정차한다. 차량의 도어와 창문을 밀폐한다. 일정하게 가압된 물을 자동분사장치를 사용하여 적당한 시간 동안 차 외부에 압력분사하여 수밀시험을 한다. 시험이 끝난 후 문부분, 대쉬 판넬부분, 앞뒤 유리부분의 누수 여부를 중점적으로 확인한다. 트렁크 내부의 배선·전조등·후미등의 누수 여부를 확인한다. 검사내용을 차량검사카드에 기록하여 검사 중 발견된 결함사항을 작업원에게 수정토록 지시한다. 검사가 완료되면 수밀검사필증을 부착한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workEnv":"다습|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8171","dJobECdNm":"[8171]자동차 조립원","dJobJCd":"8541","dJobJCdNm":"[8541]자동차 조립원","dJobICd":"C301","dJobICdNm":"[C301]자동차용 엔진 및 자동차 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004173:1', '{"dJobCd":"K000004173","dJobCdSeq":"1","dJobNm":"자동차수밀수정원","workSum":"완성된 차량의 수밀불량부위를 기밀재를 이용하여 수정한다.","doWork":"완성된 차량의 수밀(水密, Watertight) 검사카드를 보고 수밀검사에서 지적된 결함부위를 확인한다. 누수부위를 수정할 수 있는 고무망치, 밀봉재, 팩킹, 물호스 등의 수동공구와 자재를 준비한다. 도어, 트렁크 내부, 판넬, 배선, 전조등 및 후미등의 누수부위를 찾아내어 밀폐도장, 기밀재(Weather Strip)교환, 플랜지수정, 밀봉재도포, 팩킹교환 등 수밀불량 수정작업을 한다. 수정이 완료되면 물호스를 사용하여 누수 여부를 재확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"다습|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"자동차수밀작업원","dJobECd":"8171","dJobECdNm":"[8171]자동차 조립원","dJobJCd":"8541","dJobJCdNm":"[8541]자동차 조립원","dJobICd":"C301","dJobICdNm":"[C301]자동차용 엔진 및 자동차 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001340:1', '{"dJobCd":"K000001340","dJobCdSeq":"1","dJobNm":"자동차완성검사원","workSum":"완성된 승용차, 트럭, 버스 등 자동차가 품질검사기준에 일치하는지 확인하기 위하여 각종 장치를 점검한다.","doWork":"완성된 차량의 의장부품 조립상태 및 작동상태, 외부도장상태, 주요부위의 간격 및 단차 등 외관검사를 한다. 조향장치, 현가장치, 동력전달장치 등 섀시의 주요부위를 구성하고 있는 부품의 조임상태를 토크렌치를 사용하여 검사한다. 자동차를 주행시험기의 롤러 위에 놓고 기어를 바꾸어 가며 차축을 돌린다. 엔진, 변속장치, 뒤 차축의 동작 불량을 알아보기 위하여 소리를 듣고 계기판에 있는 계기 등을 관찰한다. 지정된 도로에서 자동차를 운전하여 주행 중 소리 및 떨림 상태를 감지하고 브레이크, 전조등, 경적 상태를 검사한다. 검사결과를 종합하여 완성차 품질검사기준에 따라 품질지수를 산출하고 보고서를 작성한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"균형감각|청각|시각|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"자동차최종검사원","connectJob":"승용차완성검사원, 버스완성검사원, 트럭완성검사원","dJobECd":"8171","dJobECdNm":"[8171]자동차 조립원","dJobJCd":"8541","dJobJCdNm":"[8541]자동차 조립원","dJobICd":"C301","dJobICdNm":"[C301]자동차용 엔진 및 자동차 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006207:1', '{"dJobCd":"K000006207","dJobCdSeq":"1","dJobNm":"자동차의장검사원","workSum":"의장조립공정에서 각종 의장부품의 조립·동작상태 등을 검사기준서 또는 도면에 따라 검사한다.","doWork":"검사기준서에 따라 자동차의 각종 전기배선의 결속상태, 내장부품의 조립 및 작동상태, 각종 등, 전기장치의 조립 및 작동상태, 방열기 등의 외관부품의 조립상태를 검사한다. 도어, 엔진후드, 트렁크 리드 등 외관상 주요한 부위의 간격 및 단차를 검사한다. 검사과정에서 발견된 결함사항을 자동차의장조립원에게 수정하도록 지시하고 결과를 확인하여 의장검사필증을 부착한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"승용차의장검사원, 버스의장검사원, 트럭의장검사원","dJobECd":"8171","dJobECdNm":"[8171]자동차 조립원","dJobJCd":"8541","dJobJCdNm":"[8541]자동차 조립원","dJobICd":"C301","dJobICdNm":"[C301]자동차용 엔진 및 자동차 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001713:1', '{"dJobCd":"K000001713","dJobCdSeq":"1","dJobNm":"자동차조립반장","workSum":"자동차 조립에 종사하는 작업원의 활동을 감독·조정한다.","doWork":"생산계획에 따라 차량의 종류와 수량을 확인한다. 조립에 필요한 자재를 조달하고 재고를 관리한다. 조립라인에 작업원을 편성하고 작업방법, 작업량을 지시한다. 공장을 순회하며 작업활동을 감독한다. 작업원들에게 기술을 지도하기도 한다. 조립라인에서는 전 부품의 품질검사를 한다. 각종 조립품을 검사하고 명세서와 비교한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"수동조작","connectJob":"섀시조립반장, 완성조립반장, 의장조립반장","dJobECd":"8171","dJobECdNm":"[8171]자동차 조립원","dJobJCd":"8541","dJobJCdNm":"[8541]자동차 조립원","dJobICd":"C301","dJobICdNm":"[C301]자동차용 엔진 및 자동차 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007548:1', '{"dJobCd":"K000007548","dJobCdSeq":"1","dJobNm":"자동차조립원","workSum":"자동차 차체에 조향장치 등 각종 부속품을 조립한다.","doWork":"작업지시서에 따라 조립에 필요한 공구 및 자재를 확인한다. 조립작업 라인에 위치하여 동력공구나 공정에 맞는 특수 공구를 사용하여 각종 내장 부품과 배선, 내장트림(Trim:장식), 램프류를 조립한다. 차량의 앞, 뒤 유리와 옆문 유리를 부착한다. 스프링 완충기, 스태빌라이저(Stabilizer) 등 현가장치류를 조립한다. 조향기어 및 기타 부품을 조립한다. 디스크 브레이크와 드럼 브레이크 등 제동장치를 조립한다. 엔진과 변속기를 차체의 엔진룸(Engine Room)의 연결부에 조립한다. 배기관, 머플러 등의 배기장치를 조립한다. 타이어, 앞뒤 범퍼(Bumper), 전조등, 제동등 등 외장 부품을 조립한다. 운전석과 조수석 내부 의자를 조립한다. 조립이 완료되면 브레이크 오일, 냉각수, 엔진오일, 가솔린 등을 주입하여 주행 가능한 상태로 마무리한다. 완성된 차량을 검사장으로 이동한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"자동차내장제조립원, 자동차유리부착원, 자동차현가장치조립원, 자동차조향장치조립원, 자동차제동장치조립원, 자동차엔진조립원, 자동차배기장치조립원, 자동차외장부품조립원, 승용차조립원, 트럭조립원, 버스조립원, 특장차조립원, 외장조립원, 완성차조립원, 특장차장착원","dJobECd":"8171","dJobECdNm":"[8171]자동차 조립원","dJobJCd":"8541","dJobJCdNm":"[8541]자동차 조립원","dJobICd":"C301","dJobICdNm":"[C301]자동차용 엔진 및 자동차 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001318:1', '{"dJobCd":"K000001318","dJobCdSeq":"1","dJobNm":"자동차주행검사원","workSum":"완성된 승용차 및 트럭의 주행을 통하여 엔진, 변속기, 조향장치, 제동장치 등을 종합적으로 검사한다.","doWork":"주행하기 전 완성된 차량의 엔진, 조향장치, 제동장치, 전기장치 등 주요부위 부품들의 취부상태, 오일량 및 냉각수량 누유상태를 점검한다. 차량을 기동하고 작동시험을 한다. 명세서에 기입된 검사를 수행하기 위하여 검사트랙, 도시차도 혹은 고속도로에서 차량을 운전한다. 주행 성능, 브레이크 성능을 시험하며 기타 이음발생 여부, 떨림 등을 통하여 주요부위의 결함사항을 감지한다. 주행 전후의 상태를 비교확인하며 검사결과를 차량검사카드에 기록한다. 검사 중 발견된 결함사항을 해당 작업원에게 수정하도록 지시한다. 주행검사필증을 부착한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|청각|손사용|시각|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"조작운전","dJobECd":"8171","dJobECdNm":"[8171]자동차 조립원","dJobJCd":"8541","dJobJCdNm":"[8541]자동차 조립원","dJobICd":"C301","dJobICdNm":"[C301]자동차용 엔진 및 자동차 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002114:1', '{"dJobCd":"K000002114","dJobCdSeq":"1","dJobNm":"자동차차체검사원","workSum":"차체 조립의 완성공정에서 도면 및 검사 기준서에 따라 차체의 조립상태를 육안, 촉감 및 각종 게이지로 검사한다.","doWork":"차량도면 및 검사기준서에 따라 완성된 차체의 판넬간격, 단차, 실링(Sealing)상태 및 용접상태를 육안과 측정게이지로 검사한다. 패널의 표면요철, 용접 스크랩의 제거상태, 스폿(Spot)자국의 제거상태를 확인한다. 차체 조립작업 중에 발생한 패널의 긁힘 등 손상 여부를 육안 및 촉감으로 검사한다. 각종 볼트의 조립상태를 점검한다. 결함사항이 발견되면 수정작업을 지시하고 작업결과를 확인한 후 차체검사필증을 발급한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8171","dJobECdNm":"[8171]자동차 조립원","dJobJCd":"8541","dJobJCdNm":"[8541]자동차 조립원","dJobICd":"C301","dJobICdNm":"[C301]자동차용 엔진 및 자동차 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006378:1', '{"dJobCd":"K000006378","dJobCdSeq":"1","dJobNm":"자동차차체조립반장","workSum":"자동차 차체를 제작하기 위하여 철판을 가공·용접·조립하는 작업원의 활동을 감독·조정한다.","doWork":"자동차생산계획에 따라 차체조립라인에서 일어나는 용접작업, 실러(Sealer)작업, 금속표면 마감작업, 볼트작업, 헤밍(Hemming)작업 등 각종 공정에 인원을 배정하고 작업을 지시한다. 로봇용접기의 작동상태를 확인한다. 공장을 순회하며 작업원을 감독한다. 기술을 지도하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"수동조작","dJobECd":"8171","dJobECdNm":"[8171]자동차 조립원","dJobJCd":"8541","dJobJCdNm":"[8541]자동차 조립원","dJobICd":"C301","dJobICdNm":"[C301]자동차용 엔진 및 자동차 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002054:1', '{"dJobCd":"K000002054","dJobCdSeq":"1","dJobNm":"자동차최종검사원","workSum":"동력시험장에서 완성된 자동차의 제동력, 속도, 사이드슬립(Side Slip) 등을 검사한다.","doWork":"작업표준에 의해 육안으로 완성된 자동차의 도장상태, 타이어 및 외장부품 등 외관검사를 한다. 엔진을 기동하고 운전하여 전차륜을 사이드슬립검사기(Side Slip Tester)에 올려놓고 검사원의 신호에 따라 자동차를 조작한다. 측정값을 읽어 기록한다. 자동차를 운전하여 제동력 테스터기에 올려놓고 검사원의 신호에 따라 자동차를 조작한다. 측정값을 읽어 기록한다. 자동차를 운전하여 배기량 및 속도계, 계기의 작동상태를 검사한다. 필요시 차량을 검사트랙에서 운전하여 문제점을 재확인 한다. 검사 중에 발견된 결함사항을 담당 작업원에게 수정, 지시하고 결과를 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"조작운전","dJobECd":"8171","dJobECdNm":"[8171]자동차 조립원","dJobJCd":"8541","dJobJCdNm":"[8541]자동차 조립원","dJobICd":"C301","dJobICdNm":"[C301]자동차용 엔진 및 자동차 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005329:1', '{"dJobCd":"K000005329","dJobCdSeq":"1","dJobNm":"전기자동차조립원","workSum":"배터리, 타이어, 도어, 전장 모듈, 동력전달장치, 구동계 등을 장착하여 전기자동차를 조립한다.","doWork":"생산계획에 따라 필요한 공구 및 자재를 확인한다. 자동차 프레임에 자체를 조립한다. 차량의 내·외장 의장 및 전장 모듈 및 기능단위 부품을 작업표준에 따라 차제에 동력공구를 이용하여 결합한다. 차축에 스프링 완충기 등의 현가장치를 조립하고, 조향장치와 기타 부품을 조립한다. 모터와 기어장치를 구동축에 연결하고 배터리 팩과 인버터, 컨버터 등의 전기제어 장치를 조립한다. 타이어를 장착하고 범퍼를 부착한다. 창문유리와 같은 외장유리를 단 후 운전석과 내부 의자를 차 바닥에 고정시키고 완성된 차량을 검사장으로 이동한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"하이브리드자동차조립원","dJobECd":"8171","dJobECdNm":"[8171]자동차 조립원","dJobJCd":"8541","dJobJCdNm":"[8541]자동차 조립원","dJobICd":"C301","dJobICdNm":"[C301]자동차용 엔진 및 자동차 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003064:1', '{"dJobCd":"K000003064","dJobCdSeq":"1","dJobNm":"변속기조립원","workSum":"일반 산업용기계나 운송기계 등에 삽입되는 변속기를 최종 제품으로 만들기 위해 부품을 결합·조립한다.","doWork":"작업지시서에 따라 조립할 제품의 부분품을 확인·검토한다. 작업에 필요한 장비와 작업공구를 준비한다. 변속기 케이스를 작업대에 고정시키고 작업순서에 따라 변속기 부품과 기어들을 결합한다. 조립이 완료된 제품을 시운전하여 기어 변속 작동 여부 및 진동, 소음 등을 검사한다. 윤활작업을 통해 작동 여부를 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8172","dJobECdNm":"[8172]자동차 부품 조립원","dJobJCd":"8542","dJobJCdNm":"[8542]자동차 부품 조립원","dJobICd":"C291","dJobICdNm":"[C291]일반 목적용 기계 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002867:1', '{"dJobCd":"K000002867","dJobCdSeq":"1","dJobNm":"소형엔진조립원","workSum":"작업지시서를 보고 엔진의 부분품을 조립하여 소형엔진을 조립한다.","doWork":"작업지시서를 보고 필요한 자재 및 공구를 준비한다. 크랭크 어셈블리를 조립대 위에 놓는다. 크랭크 어셈블리에 조립한 실린더에 스파크플러그를 조립한다. 크랭크샤프트에 마그네트 로터를 조립하고 점화코일을 간극에 맞게 조립한다. 스파크플러그를 크랭크샤프트에, 클러치를 마그네트에 조립한다. 머플러, 리코일 스타터, 인테이크 어셈블리를 차례로 실린더에 조립한다. 기화기 어셈블리를 인테이크 어셈블리에 조립한다. 엔진 마운트 볼트를 조립한다. 실린더 커버, 머플러, 스파크플러그 커버를 조립한다. 완성된 엔진의 외관 상태를 확인하고 대차에 적재한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8172","dJobECdNm":"[8172]자동차 부품 조립원","dJobJCd":"8542","dJobJCdNm":"[8542]자동차 부품 조립원","dJobICd":"C301/C319","dJobICdNm":"[C301]자동차용 엔진 및 자동차 제조업 / [C319]그 외 기타 운송장비 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001583:1', '{"dJobCd":"K000001583","dJobCdSeq":"1","dJobNm":"시동모터계철조립원","workSum":"작업표준에 따라 시동모터의 부품인 요크(계철)를 조립한다.","doWork":"일정 크기의 성형·연결된 계자코일을 요크의 크기에 맞게 손 및 수동공구로 원형으로 구부린다. 철심의 상하 계철(繼鐵)코어 각 중앙부를 절단하여 형성된 철심의 좌우 다리코어에 코일이 권선된 권선코일을 조립한다. 요크의 원형인 계자코일에 극(Pole)을 밀착시키고 요크와 극을 볼트로 끼워 수동공구로 조여 준다. 계철코어의 절단면을 마주 보는 사이에 비자성체를 배치하여 일정 간격의 공극을 형성한다. 한 쌍의 권선코일 및 철심코어를 비자성체 클램프로 결박하여 조립한다. 조립된 계자코일과 요크를 전기검사기구를 사용하여 검사한다. 플러그게이지를 사용하여 도면과 요크 내경의 일치 여부를 측정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"시동전동기요크조립원","dJobECd":"8172","dJobECdNm":"[8172]자동차 부품 조립원","dJobJCd":"8542","dJobJCdNm":"[8542]자동차 부품 조립원","dJobICd":"C281","dJobICdNm":"[C281]전동기, 발전기 및 전기 변환ㆍ 공급ㆍ제어 장치 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002342:1', '{"dJobCd":"K000002342","dJobCdSeq":"1","dJobNm":"시동모터조립원","workSum":"원동기, 모터사이클, 자동차에 장착되는 시동모터를 조립한다.","doWork":"작업지시서 및 작업표준에 따라 작업에 필요한 장비와 공구를 준비한다. 부품조립 순서에 따라 렌치 및 기타 공구를 사용하여 조립작업을 실시한다. 조립순서에 따라서 오버러닝(Over Running)기어가 조립된 전기자와 레버 물림대, 평형핀, 스프링 등의 부품을 상부 하우징에 삽입한다. 전기자와 레버가 삽입된 하우징에 요크를 씌운다. 요크 계자코일에 부착된 탄소브러시를 물림대에 삽입한다. 전기자의 유동을 방지하기 위해 조정와셔를 정류자 측면 축에 삽입한다. 하부 하우징 금속부에 주유기로 그리스를 넣고 요크에 연결한다. 상하 하우징과 요크가 고정되도록 고정볼트로 끼우고 수동공구로 조인다. 하우징 조립이 완료된 시동모터의 레버에 플런저(Plunger)를 끼우고 자석스위치 고정벨트를 하부 하우징에 끼운다. 자석스위치 플런저 구멍 중심에 코일스프링을 끼우고 플런저 중심 홈에 스프링을 연결시켜 볼트로 체결한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8172","dJobECdNm":"[8172]자동차 부품 조립원","dJobJCd":"8542","dJobJCdNm":"[8542]자동차 부품 조립원","dJobICd":"C281","dJobICdNm":"[C281]전동기, 발전기 및 전기 변환ㆍ 공급ㆍ제어 장치 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003778:1', '{"dJobCd":"K000003778","dJobCdSeq":"1","dJobNm":"엔진조립원","workSum":"산업용장비 및 자동차, 모터사이클, 농업기계 등에 장착하기 위해서 엔진조립라인에서 수동 및 동력공구, 측정기구 등을 사용하여 엔진을 조립한다.","doWork":"작업지시서에 따라 조립할 제품의 부분품을 확인검토한다. 작업에 필요한 장비와 작업공구를 준비한다. 작업표준에 따라 엔진의 실린더 블럭을 고정시키고 크랭크샤프트 오일실과 메인 저널 캡 및 크랭크샤프트를 토크렌치를 사용하여 규정된 토크로 조인다. 크랭크축의 정해진 방향으로 플라이휠을 조립한 후 피스톤 어셈블리 및 커넥팅로드 결합품을 설치하고 볼트로 조인다. 프론트케이스 및 오일 펌프와 오일 스트레이너, 오일 팬을 조립한 후 실린더 헤드 개스킷을 조립하고 실린더 헤드를 조립한다. 캠축 어셈블리를 규정된 토크로 조립하고 리어커버와 로커암 어셈블리 및 로커암커버를 조립한다. 부품을 조사하거나 완성된 조립품의 유격을 관찰하여 잘못된 기능을 검사하여 수정·교체한다. 그 외 각종 부속장치를 토크렌치나 임팩트렌치를 사용하여 조립한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"가솔린엔진조립원, 디젤엔진조립원, 모터사이클엔진조립원, 선박엔진조립원, 자동차엔진조립원, 철도차엔진조립원, 기계엔진조립원","dJobECd":"8172","dJobECdNm":"[8172]자동차 부품 조립원","dJobJCd":"8542","dJobJCdNm":"[8542]자동차 부품 조립원","dJobICd":"C291","dJobICdNm":"[C291]일반 목적용 기계 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007333:1', '{"dJobCd":"K000007333","dJobCdSeq":"1","dJobNm":"고속철도차량대차차입원","workSum":"고속철도차량 제작 시 차체와 대차를 조립하기 위하여 대차를 차체 밑으로 차입(끌어서 넣음)한다.","doWork":"동력대차 및 객차대차 등 차입할 대차의 종류를 확인한다. 천정크레인 및 리프트로 조립 완성된 고속철도차량의 전두부 차체를 서서히 들어 올려 일정한 거리를 두고 정지한다. 조립된 동력대차를 트레바샤(바퀴의 제동장치) 및 레일카로 이동한 후 들어 올린 차체의 바닥에 고정한다. 리프트를 가동하여 들어 올려진 차체를 서서히 하강하여 차체와 대차가 결합하도록 한다. 객차와 객차 사이에 대차가 연접(연접대차)하도록 조정한다. 대차와 전두부차체 및 객차차체의 완전한 결합을 확인한 후 리프트를 제거한다. 차체와 대차의 접합부분을 작업표준에 따라 조립부품 및 장비로 조립한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"균형감각|","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8173","dJobECdNm":"[8173]운송장비 조립원","dJobJCd":"8543","dJobJCdNm":"[8543]운송장비 조립원","dJobICd":"C312","dJobICdNm":"[C312]철도장비 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002996:1', '{"dJobCd":"K000002996","dJobCdSeq":"1","dJobNm":"대차조립반장","workSum":"철도차량의 대차를 조립하는데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"철도차량의 대차조립을 위하여 대차구조를 숙지하고 대차조립 도면을 검토확인한다. 대차조립 도면에 따라 조립공정을 구상하여 조립공정 계획을 수립한다. 조립공정에 필요한 리프트, 천장크레인 등 장비의 작동을 확인하고 체크한다. 작업공정에 따라 작업원을 배치한다. 견인후크, 사이드버퍼, 견인기어 등의 연결부분을 확인한다. 작업원들에게 조립순서 및 조립부분을 지시한다. 작업활동을 감독하고 도면에 따라 조립작업이 수행되는지 검사한다. 기술적 문제 발생 시 직접 조치하고 측정기구, 게이지 등을 사용하여 조립된 대차를 검사하고 수정을 지시한다. 작업의 안전교육 등 작업원들에게 대차조립공정에 대한 교육을 한다. 작업환경 및 위생의 개선을 위하여 노력한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"대차조립관리장","dJobECd":"8173","dJobECdNm":"[8173]운송장비 조립원","dJobJCd":"8543","dJobJCdNm":"[8543]운송장비 조립원","dJobICd":"C312","dJobICdNm":"[C312]철도장비 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003387:1', '{"dJobCd":"K000003387","dJobCdSeq":"1","dJobNm":"대차조립원","workSum":"철도차량의 대차를 제조하기 위하여 바퀴, 차축, 프레임, 스프링, 브레이크 등의 각종 부품을 조립한다.","doWork":"대차조립도면을 검토한다. 스패너, 렌치, 해머 등의 각종 조립 공구를 준비한다. 호이스트 및 리프트, 천장크레인 등의 이송장비의 작동 여부를 확인한다. 대차와 동력객차를 연결하기 위하여 견인 후크(Hook:연결고리)에 사이드기어를 조립하여 대차를 끌어 근접한다. 제동장치부분의 부분품(프레임과 윤축, 볼스터, 스프링)을 준비한다. 호이스트를 사용하여 부분품을 이동한다. 대차 및 프레임, 볼스터 등을 조립순서에 따라 조립한다. 1차 현가장치인 고무스프링을 조립하고 상향방향 댐퍼를 조립한다. 2차 현가장치인 좌우방향 댐퍼, 전후댐퍼, 상하방향 댐퍼, 코일스프링을 조립한다. 바퀴와 차축에 베어링 및 베어링 박스를 조립한다. 지그(Jig) 위에 바퀴와 차축을 결합한다. 측판으로 차체의 수평을 검사하고 수정한다. 각종 게이지를 사용하여 조립된 각종 부위를 검사한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8173","dJobECdNm":"[8173]운송장비 조립원","dJobJCd":"8543","dJobJCdNm":"[8543]운송장비 조립원","dJobICd":"C312","dJobICdNm":"[C312]철도장비 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003641:1', '{"dJobCd":"K000003641","dJobCdSeq":"1","dJobNm":"모터사이클부분품조립원","workSum":"수동공구 및 동력공구를 사용하여 포크·연료탱크·프레임 등 모터사이클의 부분품을 조립한다.","doWork":"작업지시서에 따라 작업대에 부품과 구성부속품을 준비한다. 수동공구·송곳 또는 압축기를 사용해 부품에 구멍을 뚫고, 깎고, 부품과 구성부품을 조립한다. 드라이버·렌치 또는 탄력성 있는 동력압축기를 사용하여 부품을 조립한다. 결함이 있는 부품을 알기 위하여 미완성 조립부품의 작동상태를 관찰하고 결함 부품은 교체한다. 완성된 부분품을 적재하거나 조립라인으로 이동한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"오토바이부분품조립원","dJobECd":"8173","dJobECdNm":"[8173]운송장비 조립원","dJobJCd":"8543","dJobJCdNm":"[8543]운송장비 조립원","dJobICd":"C319","dJobICdNm":"[C319]그 외 기타 운송장비 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001988:1', '{"dJobCd":"K000001988","dJobCdSeq":"1","dJobNm":"모터사이클성능시험원","workSum":"모터사이클 성능이 표준서와 일치하는지 확인하기 위하여 시험기를 이용하여 완성된 모터사이클의 성능을 시험한다.","doWork":"모터사이클을 시험기에 올려놓고 시험기에 고정한다. 시험기의 리드를 모터사이클의 발전기, 오일펌프, 플라이휠 등 측정하고자 하는 부분에 연결한다. 엔진의 속도를 다양하게 변화시키면서 발전기의 출력, 오일압력, 분당 회전수 등을 측정하고 시험기준서와 비교하여 이상 유무를 확인한다. 기어를 변속하면서 소리를 듣고 결함사항을 찾아낸다. 드라이버를 이용하여 엔진의 공회전 속도를 조절한다. 전조등의 밝기 및 빛의 각도가 규정 값에 맞는지 확인한다. 손공구를 사용하여 프레임의 볼트, 너트의 조임상태를 확인한다. 모터사이클을 운전하면서 엔진의 속도, 소음·진동, 변속상태 등을 검사한다. 작업표에 각 측정값을 기록하고 이상 유무를 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|청각|","workEnv":"소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"모터사이클내구성시험원, 오토바이성능시험원","dJobECd":"8173","dJobECdNm":"[8173]운송장비 조립원","dJobJCd":"8543","dJobJCdNm":"[8543]운송장비 조립원","dJobICd":"C319","dJobICdNm":"[C319]그 외 기타 운송장비 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005348:1', '{"dJobCd":"K000005348","dJobCdSeq":"1","dJobNm":"모터사이클조립반장","workSum":"모터사이클 포크·모터·변속장치·바퀴·체인·의장품 등의 부품 및 부분품을 조립하는 데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"도면 및 작업지시서를 검토하여 조립방법 및 순서를 결정한다. 조립에 필요한 공구 및 장비를 관리한다. 필요한 자재의 종류를 확인하고 수급을 관리한다. 각 공정에 작업원을 배치하고 작업방법을 설명한다. 공정을 순회하여 작업활동을 감독하고 조립기술을 지도한다. 조립품을 검사하여 표준과 일치하는지 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"수동조작","similarNm":"오토바이조립반장","dJobECd":"8173","dJobECdNm":"[8173]운송장비 조립원","dJobJCd":"8543","dJobJCdNm":"[8543]운송장비 조립원","dJobICd":"C319","dJobICdNm":"[C319]그 외 기타 운송장비 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001805:1', '{"dJobCd":"K000001805","dJobCdSeq":"1","dJobNm":"모터사이클조립원","workSum":"수동 및 동력 공구를 이용하여 엔진, 프레임 등 각종 부분품을 조립하여 모터사이클을 완성한다.","doWork":"주어진 작업지시서에 따라 부품을 준비한다. 컨베이어에 차체 프레임을 놓고 고정한다. 수동공구 또는 동력공구를 사용하여 포크·모터·변속장치·전후 바퀴·체인장치·손잡이 등 기타 부품을 조립한다. 차체 프레임에 생산 고유번호를 타각한다. 엔진에 연료를 적절하게 공급하기 위해 연료조절장치를 조절하고 점화플러그, 기화기를 조정한다. 체인 및 클러치의 유격을 조절하기 위하여 나사를 돌린다. 각 회전부위에 그리스를 주입하고 적당량의 연료를 주유한다. 엔진을 기동하여 이상 유무를 확인한다. 완성된 모터사이클을 제동력 시험·속도시험을 하고 검사장으로 이동한다. 각 공정 작업자는 이전 공정 작업자의 작업에 대한 검사를 실시한 후 작업한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"오토바이조립원","dJobECd":"8173","dJobECdNm":"[8173]운송장비 조립원","dJobJCd":"8543","dJobJCdNm":"[8543]운송장비 조립원","dJobICd":"C319","dJobICdNm":"[C319]그 외 기타 운송장비 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003577:1', '{"dJobCd":"K000003577","dJobCdSeq":"1","dJobNm":"반목원","workSum":"선박 및 해양구조물의 건조를 위하여 반목(배를 앉힐 때 받쳐주는 받침), 심출조정대, 진수대 등을 설치하고 선체 인양작업을 한다.","doWork":"작업지시서에 따라 필요 공구를 준비한다. 도면을 확인하여 선체의 길이, 폭, 블록의 위치를 선대에 표시한다. 작업지시서에 맞게 지주를 제작한다. 선체에 따라 반목을 배열한다. 장목에 배열하고 레일을 놓은 후 고정한다. 표시된 대차 위치에 대차를 인입한다. 고정대를 정확한 길이로 배열하고 단수판으로 연결하여 수중까지 연장한다. 대차나 교정대를 설치하고 주행으로 인하여 기울어지는 것을 예방하기 위해 수미부에는 포뱃트를 설치한다. 반목 등의 독쇼아 및 핀을 외벽에 부착하고 자키를 작동한다. 레일을 깔고 선체점 위치의 조정용으로 양 현에 닻 부위를 설치한다. 선박 종류에 따라 인양용 대차수를 정하고 잠수부에 지시하여 선체의 정 위치를 조정한다. 독(Dock)에 따라 자동반목(Adjustable Side Block:입거선박의 선저높이와 경사에 맞도록 유압 또는 기계식으로 조절되는 반목), 모래반목(Sand Block:진수작업 때 빼내기 쉽도록 마른 모래로 채운 철강제 상자 또는 모래주머니와 조합한 목재 반목)을 설치·조작하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"선목원, 지주설치원","dJobECd":"8173","dJobECdNm":"[8173]운송장비 조립원","dJobJCd":"8543","dJobJCdNm":"[8543]운송장비 조립원","dJobICd":"C311","dJobICdNm":"[C311]선박 및 보트 건조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004147:1', '{"dJobCd":"K000004147","dJobCdSeq":"1","dJobNm":"선박건조반장","workSum":"선박 및 해양구조물을 건조하기 위하여 건조공사(가공된 선체블록을 조립하는 공정)를 지휘하고 작업원의 활동을 감독·조정한다.","doWork":"선박생산설계도를 읽고 건조할 선박의 종류와 형태를 확인한다. 선박건조 일정에 따라 기중기 및 크레인기사(타워크레인, 천정크레인), 조립신호수, 운반용 차량(트랜스포터), 철목원, 용접원 등에게 작업지시를 한다. 평판블록(선저판, 선측판, 격벽판 등), 곡외판블록(선체의 선수부분, 선미부분 등 외판이 곡면을 형성한 블록), 상부구조블록(갑판 등) 등을 선대(또는 독)로 이동시켜 선체에 고정시키는 탑재작업을 지휘한다. 작업장을 순회하여 기술을 지도하고 작업활동을 감독한다. 선체의 치수, 용접상태를 점검하여 도면과 비교한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","connectJob":"선체건조반장","dJobECd":"8173","dJobECdNm":"[8173]운송장비 조립원","dJobJCd":"8543","dJobJCdNm":"[8543]운송장비 조립원","dJobICd":"C311","dJobICdNm":"[C311]선박 및 보트 건조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003204:1', '{"dJobCd":"K000003204","dJobCdSeq":"1","dJobNm":"선박기계반장","workSum":"선박 및 해양구조물을 건조하기 위하여 기관 및 기계류를 설치하고 시운전하는 작업원의 활동을 감독·조정한다.","doWork":"선박생산설계도를 읽고 건조할 선박의 종류와 형태를 확인한다. 축기계(동력축), 프로펠러, 타기계(조정장치), 기관(엔진), 보조기계(Essential Auxiliary Machinery:선박의 추진, 인명의 안전, 선박의 고유기능에 관계되는 기계류), 갑판기계(갑판에 설치되는 각종 기계장치) 등을 설치하기 위하여 위치를 확인하고 작업방법을 설정한다. 설치 및 운전에 필요한 장비, 공구를 확보한다. 작업원을 작업장에 배치하고 작업을 지시한다. 작업장을 순회하여 작업활동을 감독하고 기술지도를 한다. 설치된 기계가 도면과 일치하는지 확인한다. 시운전이 끝난 기관·기계를 검사하고 이상이 없으면 선주 및 선급검사를 받는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실외","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","connectJob":"선박기계설치반장, 선박기계운전반장, 선박기관반장","certLic":"동력기계정비기능사","dJobECd":"8173","dJobECdNm":"[8173]운송장비 조립원","dJobJCd":"8543","dJobJCdNm":"[8543]운송장비 조립원","dJobICd":"C311","dJobICdNm":"[C311]선박 및 보트 건조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003859:1', '{"dJobCd":"K000003859","dJobCdSeq":"1","dJobNm":"선박기계설치원","workSum":"선박 및 해양시설에 프로펠러, 펌프, 보일러, 조정장치 등 선박기계장치를 설치한다.","doWork":"선박 또는 해양시설의 종류에 따라 기계도면 및 시공지침서를 확인한다. 조립공구, 측정공구, 마킹공구, 양중공구(중량물을 이동하기 위한 공구), 대차, 작업대, 유압공구, 지그를 준비한다. 각종 기계류와 설치 위치를 확인한다. 도면치수에 맞도록 설치방향, 위치 및 천공위치 등을 표시한다. 축, 스팀라인 등을 연결하기 위하여 격벽, 갑판 등에 구멍을 뚫는다. 증발기, 펌프, 보일러, 프로펠러 등의 선박기계장치를 작업순서에 의거하여 설치한다. 설치된 기계 및 장비를 검사하여 도면과 일치하는지 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"갑판기계설치원, 보조기계설치원","certLic":"동력기계정비기능사, 기계정비기능사, 기계정비산업기사","dJobECd":"8173","dJobECdNm":"[8173]운송장비 조립원","dJobJCd":"8543","dJobJCdNm":"[8543]운송장비 조립원","dJobICd":"C311","dJobICdNm":"[C311]선박 및 보트 건조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002167:1', '{"dJobCd":"K000002167","dJobCdSeq":"1","dJobNm":"선박기관설치원","workSum":"선박 및 해양시설에 가솔린 또는 디젤기관을 설치한다.","doWork":"선박 또는 해양시설의 종류에 따라 기관도면 및 시공지침서를 숙지한다. 기관설치에 필요한 조립공구, 측정공구, 마킹공구, 양중공구(중량물을 이동하기 위한 공구), 대차, 작업대, 유압공구를 준비한다. 도면에 따라 기관설치 위치를 표시하고 철판에 구멍을 뚫는다. 기중기를 이용하여 설치할 구멍 위에 기관을 올려놓고, 기관성능이 유지될 수 있도록 중심을 맞추고 볼트로 고정한다. 작업방법 및 순서에 따라 보조기관·부품 및 각종 게이지 등을 완전조립하고 작동시험을 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"선박엔진설치원","certLic":"동력기계정비기능사, 기계정비기능사, 기계정비산업기사","dJobECd":"8173","dJobECdNm":"[8173]운송장비 조립원","dJobJCd":"8543","dJobJCdNm":"[8543]운송장비 조립원","dJobICd":"C311","dJobICdNm":"[C311]선박 및 보트 건조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006568:1', '{"dJobCd":"K000006568","dJobCdSeq":"1","dJobNm":"선박의장반장","workSum":"선박 및 해양구조물의 의장(艤裝, Outfit)공사를 지휘하고 각종 의장품을 설치하는데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"선박 및 해양구조물의 종류에 따라 생산도면을 읽고 소요되는 의장품을 파악한다. 의장품(배관, 전기전자, 보온, 기계, 항해, 통신, 거주, 창고, 통풍, 공조, 냉각, 조명, 계단, 난간, 소화, 하역, 각종 파이프 등)을 설치하는 작업원을 배치하고 작업방법을 설명한다. 작업장을 순회하여 기술을 지도하고 작업활동을 감독한다. 의장품 설치가 완료되면 의장검사를 실시하여 도면과의 일치 여부를 판단한다. 해상시운전(건조된 선박을 바다에서 실제로 운전하는 시험)에 승선하여 기타 설비류의 성능을 검증한다. 해상시운전이 완료되면 선주검사관(선주측 검사관, 선급검사관)에게 인계한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|손사용|","workEnv":"대기환경미흡|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","connectJob":"배관반장, 전기반장, 함석반장, 기계반장, 거주부반장, 공조반장, 선목의장반장, 철의장반장, 선체의장반장, 전기의장반장","certLic":"선체건조기능사","dJobECd":"8173","dJobECdNm":"[8173]운송장비 조립원","dJobJCd":"8543","dJobJCdNm":"[8543]운송장비 조립원","dJobICd":"C311","dJobICdNm":"[C311]선박 및 보트 건조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005463:1', '{"dJobCd":"K000005463","dJobCdSeq":"1","dJobNm":"선박환경설비설치원","workSum":"선박에 환경설비를 설치하거나 설치된 환경설비를 보수·유지·관리한다.","doWork":"선박환경설비기술자의 지시에 따라 환경설비(오폐수 처리장치, 선박 평형수 처리장치, 온실가스 처리장치 등)를 설치할 곳의 구조와 도면, 작업계획을 파악한다. 세부 작업계획을 수립하고 구체적인 작업방법을 계획한다. 설치할 선박환경설비를 확인하고 설치장소에 고정한다. 동력 및 배관을 설치하고 전기·계장공사를 수행하여 전기 및 전자시스템을 구성한다. 설치 후 환경설비의 작동 여부를 분석하고 확인한다. 오작동, 고장 등이 발생할 경우 문제의 원인을 분석하고 적절한 수리를 한다. 선박에 상주하면서 환경설비를 모니터링하고 고장과 오작동이 없도록 사전 관리하거나 예방적 조치를 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|손사용|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"선체건조기능사","dJobECd":"8173","dJobECdNm":"[8173]운송장비 조립원","dJobJCd":"8543","dJobJCdNm":"[8543]운송장비 조립원","dJobICd":"C311","dJobICdNm":"[C311]선박 및 보트 건조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006328:1', '{"dJobCd":"K000006328","dJobCdSeq":"1","dJobNm":"소취다듬원","workSum":"차체조립과정에서 생긴 철도차량 외판의 굴곡을 고정하기 위하여 산소토치 및 냉각수로 소취다듬작업을 한다.","doWork":"작업기준서에 따라 열차 각 부분의 규격을 확인한다. 토치, 그라인더 등의 장비를 준비한다. 작업지시서에 따라 차량 각 부분의 소취다듬 부분을 확인한다. 작업표준에 따라 용접부위의 돌출부분을 그라인딩하여 다듬는다. 차체의 옆면, 끝부분 및 지붕외관을 산소토치로 가열한다. 자체조립에서 변형된 옆면기둥을 고정한다. 출입대 측의 내측기둥과 출입대 발판을 취부한다. 차체 내부의 천정 및 격벽을 취부하기 위하여 다듬작업을 한다. 지붕의 물받이를 취부한다. 모든 취부작업이 끝나면 2차 다듬작업을 한다. 작업완료 후 작업표준규격 및 작업지시서의 규격과 일치하는지 비교·검사하여 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"균형감각|손사용|","workEnv":"위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"8173","dJobECdNm":"[8173]운송장비 조립원","dJobJCd":"8543","dJobJCdNm":"[8543]운송장비 조립원","dJobICd":"C312","dJobICdNm":"[C312]철도장비 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006746:1', '{"dJobCd":"K000006746","dJobCdSeq":"1","dJobNm":"쇼트피닝기조작원","workSum":"항공기 부품의 표면을 단단하고 곱게 하기 위하여 쇼트피닝기(Shot Peening Machine)를 조작한다.","doWork":"작업표준서를 보고 작업에 필요한 공구와 각종 자재를 준비한다. 쇼트피닝(Shot Peening:원심력이나 압축공기로 조그마한 강철 구슬을 강철 재료의 표면에 충돌시키는 작업) 작업 대상물의 표면상태 및 조도, 오염 여부를 확인한다. 작업 공정표상의 공정 수행 요구조건을 확인한다. 기술지침서에서 요구하는 응력, 응력분포를 만족시키기 위해 장비의 각 변수들과 쇼트볼, 제품고정 방법 등의 변수들을 조정한다. 적절한 치구를 이용하여 시편(試片:시험분석에 쓰기 위하여 골라낸 조각)을 준비하고 작업된 시편 값을 확인한다. 제품을 작업대에 걸고 쇼트피닝 작업을 수행한다. 작업이 완료되면 작업내용을 기록하고 제품을 인계한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8173","dJobECdNm":"[8173]운송장비 조립원","dJobJCd":"8543","dJobJCdNm":"[8543]운송장비 조립원","dJobICd":"C313","dJobICdNm":"[C313]항공기, 우주선 및 부품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005893:1', '{"dJobCd":"K000005893","dJobCdSeq":"1","dJobNm":"철도차량교정원","workSum":"철도차량의 단품 및 원자재를 일정한 형태로 교정하고 다듬는다.","doWork":"공정간 작업기준서에 따라 철도차량 부품의 단품 및 원자재를 작업표준에 일치하도록 가공하여 교정한다. 작업지시서에 따라 작업을 확인하고 교정 및 가공할 부품 및 원자재를 확인한다. 토치, 렌치, 해머, 손망치, 측정기구 등의 작업에 필요한 공구 및 도구를 준비한다. 교정물을 작업대에 고정한다. 측정기구 및 게이지를 사용하여 교정물의 대각 및 평면을 측정한다. 교정물의 요철부분을 토치를 사용하여 열간 작업을 하고 해머를 사용하여 명세서에 맞게 교정을 한다. 가공 및 교정 후 작업표준규격과 일치하는지 검사하여 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|고온|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"철차교정원","dJobECd":"8173","dJobECdNm":"[8173]운송장비 조립원","dJobJCd":"8543","dJobJCdNm":"[8543]운송장비 조립원","dJobICd":"C312","dJobICdNm":"[C312]철도장비 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002035:1', '{"dJobCd":"K000002035","dJobCdSeq":"1","dJobNm":"철도차량기기취부원","workSum":"철도차량의 동력장치, 전원장치, 제동장치, 연결장치 등의 각종 기기를 차량에 취부한다.","doWork":"철도차량을 조립하기 위하여 작업배치도 및 도면에 따라 프레임과 윤축, 볼스터, 스프링, 제동장치부분의 부분품 등 각종 기기들의 부품 및 재료를 준비한다. 동력, 전원, 제동, 연결장치 등 작업도면에 따라 취부할 부품의 위치를 확인한다. 현가장치, 고무스프링, 상하·전후 댐퍼, 코일스프링 등의 상태를 확인한다. 크레인, 지게차, 용접기 등의 부분품 운송장비와 수동공구를 준비한다. 각 기기의 부분조립을 하고 차량에 운반하여 도면에 표시된 위치에 취부장비 및 공구를 사용하여 정확하게 취부한다. 취부된 기기를 육안이나 측정기로 검사하여 도면과 일치하는지 확인하고 잘못된 곳을 수정한다. 취부된 각종 기기의 작동시험을 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|손사용|","workEnv":"소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"철도차량취부사","certLic":"용접기능사, 용접산업기사, 용접기능장","dJobECd":"8173","dJobECdNm":"[8173]운송장비 조립원","dJobJCd":"8543","dJobJCdNm":"[8543]운송장비 조립원","dJobICd":"C312","dJobICdNm":"[C312]철도장비 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005667:1', '{"dJobCd":"K000005667","dJobCdSeq":"1","dJobNm":"철도차량내장판조립원","workSum":"철도차량의 실내 내장판을 절단·굴곡하여 차량에 조립한다.","doWork":"공정별 작업기준서 및 작업도면에 따라 내장작업 부분을 확인한다. 작업공정 및 작업계획을 수립한다. 작업도구 및 장비(절단기, 벤딩기, 드릴, 탭, 전동드라이버)를 준비한다. 작업지시에 따라 도면을 확인하고 소요되는 내장판을 종류별로 준비한다. 내장판의 절단규격을 결정하고 절단기를 조작하여 내장판을 절단한다. 벤딩기를 사용하여 내장판을 필요한 형태로 굴곡한다. 절단된 내장판을 차체에 취부하고 드릴, 탭, 드라이버 등을 사용하여 나사로 고정한다. 조립된 내장판을 검사하여 도면과 일치하는지 확인한다. 객실 내장재를 경량의 고강도 복합소재인 특수 패널 등으로 시공하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"균형감각|손사용|","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"판금제관기능사, 판금제관산업기사, 판금제관기능장","dJobECd":"8173","dJobECdNm":"[8173]운송장비 조립원","dJobJCd":"8543","dJobJCdNm":"[8543]운송장비 조립원","dJobICd":"C312","dJobICdNm":"[C312]철도장비 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002223:1', '{"dJobCd":"K000002223","dJobCdSeq":"1","dJobNm":"철도차량도어조립원","workSum":"명세서와 도면에 따라 철도차량의 실내외의 각종 도어를 조립한다.","doWork":"작업도면을 확인하여 차종별 도어의 종류 및 규격, 수량을 확인한다. 내부 객실도어, 외부 출입도어의 위치와 규격을 확인한다. 작업시방서 및 공정별 작업기준서를 숙지하여 작업표준에 따라 순서대로 조립한다. 쇠톱, 줄, 드릴 및 태핑기 등의 작업공구와 도어 및 부품을 준비한다. 도어자물쇠, 유리창고무, 손잡이 등의 부품을 도어에 조립한다. 도어가 조립될 철도차량의 차체에 상하레일을 설치한다. 도어롤러 등 각 부분품을 설치한다. 조립된 도어를 취부하여 조립한다. 조립된 도어의 작동상태를 검사한다. 자동으로 작동되는 도어의 경우 벨트, 모터, 크랭크 등의 도어 어셈블리를 조립한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|손사용|","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8173","dJobECdNm":"[8173]운송장비 조립원","dJobJCd":"8543","dJobJCdNm":"[8543]운송장비 조립원","dJobICd":"C312","dJobICdNm":"[C312]철도장비 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005045:1', '{"dJobCd":"K000005045","dJobCdSeq":"1","dJobNm":"철도차량몰딩원","workSum":"철도차량에 실내 몰딩작업을 한다.","doWork":"작업도면을 검토하고 몰딩공정 작업기준서에 따라 몰딩부분, 몰딩방법 및 몰딩작업 물량을 확인한다. 작업도면에 의거하여 몰딩의 종류 및 작업순서를 선정한다. 작업에 필요한 절단기, 그라인더, 드릴, 전동드라이버 등의 작업도구 및 장비를 준비한다. 작업표준에 따라 절단기를 사용하여 규정된 치수로 절단한다. 드릴, 줄, 사포를 사용하여 몰딩에 나사 구멍을 낸다. 나사 구멍을 낸 곳에 접시머리나사가 조립될 수 있도록 절단부위를 사상한다. 도면에 따라 차량 내부에 몰딩을 나사로 고정한다. 몰딩의 상태를 점검한다. 방음 관련 작업을 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"몰딩취부원","dJobECd":"8173","dJobECdNm":"[8173]운송장비 조립원","dJobJCd":"8543","dJobJCdNm":"[8543]운송장비 조립원","dJobICd":"C312","dJobICdNm":"[C312]철도장비 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005576:1', '{"dJobCd":"K000005576","dJobCdSeq":"1","dJobNm":"철도차량설비조립원","workSum":"철도차량의 실내외에 취부되는 각종 설비품을 차량에 조립한다.","doWork":"차종별 설비도면을 검토하여 객실선반, 객실모니터, 객실창문, 조명, 출입문 개폐용 엔진, 화장실 유닛 등 철도차량 내부 설비품의 종류, 위치 및 수량을 확인한다. 각 설비품의 작업시방서와 작업표준에 의거하여 작업방법을 결정하고 작업순서계획을 수립한다. 작업에 필요한 지그, 전동드릴, 전동드라이버 등의 장비와 공구를 준비한다. 각 설비품의 지그(Jig)를 설치한다. 전동공구 및 수공구를 이용하여 의자, 손잡이, 화장실 및 세면실 설비 등의 각종 설비품을 조립한다. 조립이 완료된 설비품을 차량 내외부에 수동공구 및 전동공구를 사용하여 취부한다. 각종 설비품의 조립된 형태, 위치 등을 확인하여 도면과 비교·검토한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8173","dJobECdNm":"[8173]운송장비 조립원","dJobJCd":"8543","dJobJCdNm":"[8543]운송장비 조립원","dJobICd":"C312","dJobICdNm":"[C312]철도장비 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002434:1', '{"dJobCd":"K000002434","dJobCdSeq":"1","dJobNm":"철도차량연결기조립원","workSum":"철도차량을 서로 연결하는 차량연결기(Coupler)를 조립한다.","doWork":"작업지시서와 조립도면을 수령하고 작업시방서를 확인한다. 철도차량 연결방법(밀착식 자동연결, 밀착식 소형 자동연결, 밀착식 연결)에 따라 조립계획을 수립한다. 핸들카를 이용하여 부분품을 조립할 장소로 이송한다. 철도차량조립 지침서에 따라 조립에 필요한 조립부분품(주철제 철도차량 연결기 및 철도차량 연결부 완충기)을 확인한다. 조립도면을 숙지하고 조립공구(렌치, 해머, 스패너)를 준비한다. 작업시방에 따라 연결기의 머리부분과 동체부분을 차체에 조립한다. 조립된 상태를 검사하여 도면과 일치하는지 확인한다. 조립된 연결기를 시험연결장치에 접속시켜 결합상태를 검사한다. 수동그라인더를 사용하여 연결기부품을 다듬기도 한다. 연결·조립 후 연결기의 연결상태 및 개방성을 확인한다. 연결기의 여유 틈새가 적은지, 곡선·구배의 변화에 지장이 없는지 확인하고 너클(Knuckle)의 틈과 측면 상하의 유동(遊動)이 없는지를 확인점검한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8173","dJobECdNm":"[8173]운송장비 조립원","dJobJCd":"8543","dJobJCdNm":"[8543]운송장비 조립원","dJobICd":"C312","dJobICdNm":"[C312]철도장비 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002489:1', '{"dJobCd":"K000002489","dJobCdSeq":"1","dJobNm":"철도차량의장검사원","workSum":"철도차량의 내장설비품, 도어, 문, 몰딩 등 의장품의 외관, 기능 및 결함상태를 검사한다.","doWork":"설계도면 및 사양서에 따라 내외장품의 위치, 규격, 설치, 성능 등을 검사한다. 작업도면 및 사양서에 따라 검사기준 및 항목을 설정한다. 내장설비품(객실선반, 시트, 조명, 객실모니터, 객실창문, 객실도어, 출입문도어, 출입계단, 몰딩, 배관설치, 케이블설치)의 설치검사를 한다. 냉·난방시스템, 기내방송시스템, 화장실 유닛, 창문개폐, 조명, 모니터 등을 작동하여 성능시험을 한다. 차량 내부의 단열재 재단 및 시공, 내장판 절단 및 조립, 몰딩조립, 설비품의 취부 및 조립상태 등을 기준에 의하여 검사하고 불량상태를 표시한다. 검사결과를 작성하여 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"8173","dJobECdNm":"[8173]운송장비 조립원","dJobJCd":"8543","dJobJCdNm":"[8543]운송장비 조립원","dJobICd":"C312","dJobICdNm":"[C312]철도장비 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006891:1', '{"dJobCd":"K000006891","dJobCdSeq":"1","dJobNm":"철도차량의장반장","workSum":"철도차량 내외부의 설비품, 내장판, 문, 몰딩 등의 의장조립작업을 수행하는 작업원의 활동을 감독·조정한다.","doWork":"차량의장 작업지시서에 따라 공정별 의장작업계획(내장의장, 외장의장, 객실선반, 객실도어, 객실창문, 화장실 유닛, 냉·난방시스템, 천장 조명, 독서등 조명, 시트)을 수립한다. 작업설비 및 인원을 확인하고 공정별 작업을 배치하고 작업량을 배분하고 작업을 지시한다. 공정을 순회하여 작업활동을 감독하고 기술지도를 한다. 의장조립상태를 검사하여 도면과의 일치 여부를 확인한다. 소음검사, 누수검사를 실시하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"철도차량의장관리장","dJobECd":"8173","dJobECdNm":"[8173]운송장비 조립원","dJobJCd":"8543","dJobJCdNm":"[8543]운송장비 조립원","dJobICd":"C312","dJobICdNm":"[C312]철도장비 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004256:1', '{"dJobCd":"K000004256","dJobCdSeq":"1","dJobNm":"철도차량차체조립반장","workSum":"철도차량의 차체를 제작하기 위하여 차량의 하부, 옆면, 끝부분 및 지붕의 골조를 제관, 용접, 사상, 교정하는 작업에 종사하는 작업원의 활동을 감독·조정한다.","doWork":"철도차량의 구체(차체)를 조립하기 위하여 공정별 작업기준서에 따라 철도차량 각 부품(차량지붕프레임, 차량좌·우측면프레임, 사이드프레임, 차량전·후면프레임, 바닥을 포함한 대형 압출 형강재인 언더프레임 등)의 통합조립 공정계획을 수립한다. 차량 종류별 제작도면을 확인하고 필요한 장비·자재 등을 확보한다. 작업원을 각 공정에 배치하고 작업 지시한다. 공정을 순회하여 작업활동을 감독하고 기술적인 사항을 지도한다. 제관품이나 용접된 상태를 검사하여 잘못된 부분을 수정하도록 지시한다. 완성된 차체를 검사하여 작업도면과 일치하는지 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"철도차량차체조립관리장","dJobECd":"8173","dJobECdNm":"[8173]운송장비 조립원","dJobJCd":"8543","dJobJCdNm":"[8543]운송장비 조립원","dJobICd":"C312","dJobICdNm":"[C312]철도장비 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005473:1', '{"dJobCd":"K000005473","dJobCdSeq":"1","dJobNm":"철목원","workSum":"제조된 선박블록(Block)을 도면에 따라 조립하기 위하여 블록의 위치를 정렬 및 조정하고 용접하여 취부, 용접작업이 용이하도록 고정(Setting)한다.","doWork":"작업도면을 보고 블록상태를 확인한다. 블록과 도면을 대조하면서 블록의 길이, 높이, 폭, 수평도, 수직도, 직각도 등의 정확한 정도를 체크한다. 지게차, 집크레인을 사용하여 블록을 조립위치로 이동한다. 고소차(Hold Stage)에 탑승하거나 족장을 이용하여 작업 위치로 이동한다. 수준기(Auto Level기) 또는 3차원계측기, 줄자, 추 등을 사용하여 블록의 평형상태를 검사하고, 블록의 조정량을 계산한다. 블록의 절단 부위를 표기한다. 자동절단기를 사용하여 절단한다. 절단된 블록의 상태를 확인하고 정 위치로 이동 및 조정한다. 조정작업이 완료되면 블록의 이동을 막기 위하여 용접기를 사용하여 가용접(Setting)을 한다. 최종 정렬상태를 확인하고 기록한다. 선주 및 선급검사관에게 선체의 길이, 폭, 깊이를 검사받기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"셋팅원, 심출사, 취부사","certLic":"용접기능사, 용접산업기사, 용접기능장, 선체건조기능사","dJobECd":"8173","dJobECdNm":"[8173]운송장비 조립원","dJobJCd":"8543","dJobJCdNm":"[8543]운송장비 조립원","dJobICd":"C311","dJobICdNm":"[C311]선박 및 보트 건조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005765:1', '{"dJobCd":"K000005765","dJobCdSeq":"1","dJobNm":"항공기기체계통조립원","workSum":"항공기 기체에 보조날개, 방향키, 승강키 등 기체 계통을 설치한다.","doWork":"작업표준서나 도면을 보고 작업에 필요한 공구 및 자재를 준비한다. 잭을 이용하여 항공기 동체를 지지한다. 조립된 날개의 외관 상태를 확인한다. 호이스트(Hoist)를 이용하여 보조날개(주날개 뒤에 달려 하나의 키 역할)를 기체의 조립 위치에 놓는다. 보조날개의 위치를 도면에 맞게 정확히 맞추고 리벳(Rivet:공작물을 영구 이음하는 머리가 달린 핀이나 볼트)이나 볼트를 이용하여 고정한다. 호이스트를 이용하여 기 조립된 방향키(수직 꼬리날개 뒤에 위치), 승강키(수평 꼬리날개 뒤에 위치) 등을 기체에 조립한다.동체의 배관 및 배선을 각 부분에 연결하고 알맞게 연결되었는지 확인한다. 전체 유압배관이 연결되면 외부 유압장치에 연결한다. 외부 연결 장비를 기동하여 유압압력을 서서히 증가한다. 정상 압력에 도달하면 각 연결부의 파손 및 유체누설이 없는지 확인하고, 각 부의 작동상태를 점검한다. 외부 전원을 연결한다. 외부 전기를 넣고 각 전기장치의 작동상태를 확인하고 정상 작동되는지 확인하고 필요시 수정한다. 해당 작업원에 작업을 의뢰하기도 한다. 작동에 이상이 없으면 압력을 제거하고 정리정돈한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"균형감각|손사용|시각|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"항공기기체계통설치원","connectJob":"항공기기체계통검사원","certLic":"항공기정비기능사, 항공산업기사","dJobECd":"8173","dJobECdNm":"[8173]운송장비 조립원","dJobJCd":"8543","dJobJCdNm":"[8543]운송장비 조립원","dJobICd":"C313","dJobICdNm":"[C313]항공기, 우주선 및 부품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006001:1', '{"dJobCd":"K000006001","dJobCdSeq":"1","dJobNm":"항공기기체조립원","workSum":"조립 치공구를 설치하고 각각의 부분품을 드릴링, 리벳팅(Riveting)또는 패스닝(Fastening) 하여 항공기 기체구조물(골격)을 완성한다.","doWork":"작업표준서 및 설계도면을 보고 필요한 공구 및 자재를 준비한다. 조립 구조물의 치공구(기체 부품을 일정한 자리에 위치하여 고정하는 보조용 기구)를 설치하고 설치 치수가 허용 공차 내에 있는지 확인한다. 기체구조 주요 부품을 지그에 고정시키고 드릴링(Drilling:구멍 뚫기) 작업을 한다. 부품을 치공구에서 해체하여 드릴로 가공된 구멍 부분을 깨끗이 다듬고 청소한 후 다시 치공구에 고정한다. 필요 부위에 실링(Sealing) 작업을 한다. 리베팅 또는 패스닝(Fastening)작업을 통해 부품을 설계도면대로 조립한다. 마지막으로 스킨(Skin)또는 외부 파트(Part)를 드릴링과 리베팅 또는 패스닝(Fastening)작업을 하여 마무리 한다. 완성된 기체구조물(골격)의 외형 상태를 확인하고, 이상부위를 수정한다. 표면을 청소하고 작업 주변을 정리정돈한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|손사용|시각|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"항공기체구조물조립원","connectJob":"항공기날개조립원, 항공기동체조립원","certLic":"항공산업기사","dJobECd":"8173","dJobECdNm":"[8173]운송장비 조립원","dJobJCd":"8543","dJobJCdNm":"[8543]운송장비 조립원","dJobICd":"C313","dJobICdNm":"[C313]항공기, 우주선 및 부품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006105:1', '{"dJobCd":"K000006105","dJobCdSeq":"1","dJobNm":"항공기날개조립원","workSum":"조립 치공구를 설치하고 각각의 부분품을 드릴링(Drilling:구멍 뚫기), 리벳팅(Riveting)또는 패스닝(Fastening)하여 항공기 날개골조를 완성하고 스킨(Skin)을 장착한다.","doWork":"작업표준서 및 설계도면을 보고 필요한 공구 및 자재를 준비한다. 조립 구조물의 치공구(기체 부품을 일정한 자리에 위치하여 고정하는 보조용 기구)를 설치하고 설치 치수가 허용 공차 내에 있는지 확인한다. 날개의 골격을 형성하는 주요 부품을 치공구에 고정시키고 드릴링(Drilling:구멍 뚫기) 작업을 한다. 부품을 치공구에서 해체하여 구멍 부분을 다듬고 깨끗이 청소한 후 다시 치공구에 고정한다. 필요 부위에 실링(Sealing) 작업을 하기도 한다. 리벳팅(Riveting)또는 패스닝(Fastening)을 통해 부품을 설계도면대로 조립한다. 구조물 내부에 기능품 장착을 위한 고정대를 장착한다. 스킨(Skin)을 올려놓고 구멍을 뚫고 패스닝(Fastening) 작업을 한다. 완성된 날개의 외형 상태를 확인하고, 이상부위를 수정한다. 표면을 청소하고 작업 주변을 정돈한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|손사용|시각|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"항공기기체조립검사원","certLic":"항공기정비기능사, 항공산업기사","dJobECd":"8173","dJobECdNm":"[8173]운송장비 조립원","dJobJCd":"8543","dJobJCdNm":"[8543]운송장비 조립원","dJobICd":"C313","dJobICdNm":"[C313]항공기, 우주선 및 부품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005171:1', '{"dJobCd":"K000005171","dJobCdSeq":"1","dJobNm":"항공기동체조립원","workSum":"항공기 기체구조물(골격)에 날개를 조립하기 위하여 호이스트(hoist)를 이용하여 날개를 인양한 후 동체에 조립한다.","doWork":"작업표준서 및 설계도면을 보고 작업에 필요한 공구와 자재를 준비한다. 호이스트를 이용하여 날개를 인양한 후 동체에 위치시킨다. 가공된 구멍에 볼트와 너트를 장착한 후 도면에서 요구하는 토크 값을 적용한다. 날개와 동체 접합면에 실링을 하기도 한다. 연료배관을 연결하여 연결부위의 누설 여부를 확인한다. 완성된 동체의 외형 상태를 확인한다. 이상부위를 수정하고 표면을 청소한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|시각|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"항공기구조물조립원, 항공기날개조립원, 항공기동체검사원","certLic":"항공기정비기능사, 항공산업기사","dJobECd":"8173","dJobECdNm":"[8173]운송장비 조립원","dJobJCd":"8543","dJobJCdNm":"[8543]운송장비 조립원","dJobICd":"C313","dJobICdNm":"[C313]항공기, 우주선 및 부품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002330:1', '{"dJobCd":"K000002330","dJobCdSeq":"1","dJobNm":"항공기라우터조작원","workSum":"항공기 부품에 사용되는 비철금속판이나 플라스틱판 제품을 비정형의 형상으로 가공할 수 있는 라우터(Router:홈파기, 면 정리, 모양내기 등을 작업할 수 있는 기계)를 조작한다.","doWork":"작업지침서나 설계도면을 읽고 작업에 필요한 공구와 각종 재료를 준비한다. 작업 전 보안경 및 방진복을 착용하고 주위 위험 요소들을 제거한다. 작업 목적에 맞는 치공구(治工具:물건을 고정할 때 사용하는 공구)와 커터를 선택한다. 가공할 제품을 치공구에 장착하고 규격에 맞는지 확인한다. 치공구를 사용하여 부품을 가공한다. 작업이 완료되면 가공부위의 날카로운 부분을 제거한다. 완성된 부품이 설계도면 및 작업지시서에 맞는지 확인한다. 부품의 이력을 확인할 수 있도록 임시 부품표를 부착한다. 부품에 이상이 없으면 작업완료 보고를 한다. 인수인계서를 작성한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"항공기루터조작원","dJobECd":"8173","dJobECdNm":"[8173]운송장비 조립원","dJobJCd":"8543","dJobJCdNm":"[8543]운송장비 조립원","dJobICd":"C313","dJobICdNm":"[C313]항공기, 우주선 및 부품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004745:1', '{"dJobCd":"K000004745","dJobCdSeq":"1","dJobNm":"항공기엔진설치원","workSum":"항공기 엔진의 제작조립은 물론 수리후 엔진을 조립하여 항공기기체에 장착할 수 있도록 엔진외부부품인 QEC(Quick Engine Change) 까지 작업한다.","doWork":"작업표준서나 설치도면을 보고 작업에 필요한 공구와 각종 자재를 준비한다. 설치도면을 보고 엔진이 조립될 기체 위치를 확인한다. 리프트를 이용하여 엔진을 기체의 연결부위에 위치시킨다. 엔진의 수평을 유지하면서 연결부위에 고정한다. 연료탱크의 연료라인을 엔진에 연결한다. 전기 배선을 엔진에 연결한다. 작업이 완료되면 엔진시험장으로 항공기를 이동한다. 연료탱크에 연료를 주입하고 소화기 등 안전장치를 준비한다. 안전보호구를 착용하고 주변의 이물질 등을 제거한다. 항공기를 기동하고 엔진성능을 시험한다. 시험이 완료되면 엔진을 정지하고 유류 및 각종 오일이 누설되지 않았는지 확인한다. 필요시 부품을 교환하거나 수정작업을 하고 해당 작업자에게 작업을 의뢰하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|청각|시각|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"항공기엔진조립원, 항공기엔진탑제원, 항공기엔진정비사, 항공엔진기술자","certLic":"항공정비사, 항공기정비기능사","dJobECd":"8173","dJobECdNm":"[8173]운송장비 조립원","dJobJCd":"8543","dJobJCdNm":"[8543]운송장비 조립원","dJobICd":"C313","dJobICdNm":"[C313]항공기, 우주선 및 부품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003112:1', '{"dJobCd":"K000003112","dJobCdSeq":"1","dJobNm":"항공기전자부품설치원","workSum":"항공기 전자, 전기제품을 제작조립 설치하고, 작동상태를 조정한다.","doWork":"작업표준서나 배치도면을 보고 작업에 필요한 공구와 자재를 준비한다. 엔진 시동계통을 설치하고 점검한다. 조종석 내부의 각종 계기를 설치하고 배선한다. GPS 단말기와 레이더 장치를 설치한다. 공중 급유 장치, 공조시스템(고속 팬 모터, 기압장치, 온도조절장치)을 설치한다. 설치된 전자계통 부품의 방향성이 일치되도록 조정한다. 회로시험기(Circuit Tester:전압, 전류, 저항 등을 측정하는 미터 표시의 간이측정기) 등을 이용해 계기의 작동상태, 상호작용상태, 각종 경고등의 작동상태 등을 점검한다. 필요시 부품을 수정하거나 교환하고 해당 작업자에게 작업을 의뢰하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|청각|손사용|시각|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"항공기전자부품기술자","certLic":"항공전기전자정비기능사, 항공산업기사","dJobECd":"8173","dJobECdNm":"[8173]운송장비 조립원","dJobJCd":"8543","dJobJCdNm":"[8543]운송장비 조립원","dJobICd":"C313","dJobICdNm":"[C313]항공기, 우주선 및 부품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007308:1', '{"dJobCd":"K000007308","dJobCdSeq":"1","dJobNm":"항공기착륙장치설치원","workSum":"항공기 기체에 착륙장치를 설치하고 작동 점검을 수행한다.","doWork":"항공기의 착륙장치(랜딩기어)를 기체에 탈거 및 장착을 수행한다. 착륙장치 장착 시 계통 유압 배관을 연결하고 전기 장치 배선을 연결한다. 착륙장치 성능 검사를 수행하고 항공기 출발 태세를 확보한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"항공기기체부품정비사","certLic":"항공정비사","dJobECd":"8173","dJobECdNm":"[8173]운송장비 조립원","dJobJCd":"8543","dJobJCdNm":"[8543]운송장비 조립원","dJobICd":"C313","dJobICdNm":"[C313]항공기, 우주선 및 부품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006524:1', '{"dJobCd":"K000006524","dJobCdSeq":"1","dJobNm":"항공기최종검사원","workSum":"항공기의 상태 및 성능의 품질이 품질기준에 적합한가를 검사하여 판정한다.","doWork":"정비를 수행한 항공기의 상태 및 성능의 품질이 제작사 정비 매뉴얼 및 항공기 운영사 작업 지시서의 내용에 적합한가를 검사하여 판정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"항공기 엔진검사원, 항공기 전기, 전자검사원, 항공기 보기 검사원","certLic":"항공정비사","dJobECd":"8173","dJobECdNm":"[8173]운송장비 조립원","dJobJCd":"8543","dJobJCdNm":"[8543]운송장비 조립원","dJobICd":"C313","dJobICdNm":"[C313]항공기, 우주선 및 부품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005718:1', '{"dJobCd":"K000005718","dJobCdSeq":"1","dJobNm":"공정장비조립원","workSum":"공정장비의 조립절차에 따라 부속품과 모듈을 조립하여 공정장비를 완성한다.","doWork":"공정장비의 설계도와 조립순서를 확인한다. 공정장비의 조립절차에 따라 부속품과 모듈을 수동공구나 전동드라이버 등을 이용하여 새시에 조립한다. 공정장비 내부의 파이프류를 연결하고 각 제어부 간에 신호전달과 전기공급을 위한 신호케이블과 전력선을 연결하고 제어패널에 접속한다. 공정장비 내의 조립된 부속품들이 장비의 진동에 의해 풀어지지 않도록 단단히 고정시키기 위해 나사고정제(록타이트) 등으로 마무리하고 조립위치를 표시한다. 모터나 기어 같은 구동부위에 윤활물질을 도포한다. 개스킷이나 고무패킹 등을 이용하여 조립된 부위의 기물 상태를 확인한다. 공정장비의 각 부분의 작동을 검사하여 공정장비의 조립을 완성한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"공정장비조립검사원","certLic":"기계가공조립기능사, 기계가공조립산업기사","dJobECd":"8161","dJobECdNm":"[8161]일반기계 조립원","dJobJCd":"8544","dJobJCdNm":"[8544]일반기계 조립원","dJobICd":"C292","dJobICdNm":"[C292]특수 목적용 기계 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007196:1', '{"dJobCd":"K000007196","dJobCdSeq":"1","dJobNm":"냉방장치조립원","workSum":"냉방장치와 관련된 부품을 조립하거나 납땜하고 기밀시험을 통해 제품의 이상 유무를 확인한다.","doWork":"작업지시서에 따라 조립할 제품의 부분품을 확인하고 검토한다. 작업에 필요한 장비와 작업공구를 준비한다. 수동공구를 사용하여 압축기에 케이싱을 조립하고 최종 하우징을 조립한다. 컨트롤 패널과 단자를 연결한다. 출고할 제품에 냉매를 주입하고 제품을 시운전한다. 완제품에 자동포장기로 비닐을 씌운 후 창고에 적재한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8161","dJobECdNm":"[8161]일반기계 조립원","dJobJCd":"8544","dJobJCdNm":"[8544]일반기계 조립원","dJobICd":"C291","dJobICdNm":"[C291]일반 목적용 기계 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002513:1', '{"dJobCd":"K000002513","dJobCdSeq":"1","dJobNm":"반도체장비기구조립원","workSum":"반도체장비 도면 및 조립 특성을 이해하고, 기구장치와 연결되는 전기, 부품, 장치 등을 조립 순서도에 맞게 조립하고, 개별 동작점검 및 개선 활동을 통해 조립 정밀도를 향상시킨다.","doWork":"반도체장비 기구설계 도면을 보고 조립 순서를 기준으로 부품 가공 정밀도를 측정하여 정상 여부를 판단한다. 부분별 세부 조립 순서를 기준으로 기구조립 안전수칙을 준수하여 전기, 부품, 장치 등을 배치하고, 조립한다. 각 기구장치에서 요구하는 전기, 부품, 장치 관련 기본 조립을 실시한 다음, 개별 동작을 점검한다. 점검 시 발생한 문제점을 해결하기 위해 설계, 공정 연구원들과 협의하여 조치한 다음, 개별 동작 점검을 재실시하여 조립 성능을 검증한다. 부품, 장치, 모듈 단계로 확장하여 기구를 조립하고, 동작점검을 실시하여 전체 조립을 완성한다. 소프트웨어 설계연구원과 공정연구원의 장비 단위동작, 전장배선, 세부동작 및 전체 완성 성능평가를 지원한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"수동조작","certLic":"반도체설비보전기능사","dJobECd":"8161","dJobECdNm":"[8161]일반기계 조립원","dJobJCd":"8544","dJobJCdNm":"[8544]일반기계 조립원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005848:1', '{"dJobCd":"K000005848","dJobCdSeq":"1","dJobNm":"배출가스저감장치조립원","workSum":"필터와 필터케이스를 조립, 용접하여 배출가스저감 장치를 제조한다.","doWork":"생산제품의 종류에 따라 필터와 필터케이스 등의 자재를 준비한다. 필터담체를 필터케이스에 맞게 절단기를 이용하여 절단한다. 반원형의 필터케이스에 필터담체를 부착하고 반원형의 케이스를 덮은 뒤 용접하여 붙인다. 조립이 완성된 제품의 외관을 검사하고 용접된 부위를 그라인더를 이용하여 다듬기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"매연저감장치조립원, 매연여과장치조립원","connectJob":"매연포집기조립원","dJobECd":"8161","dJobECdNm":"[8161]일반기계 조립원","dJobJCd":"8544","dJobJCdNm":"[8544]일반기계 조립원","dJobICd":"C303","dJobICdNm":"[C303]자동차 신품 부품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003773:1', '{"dJobCd":"K000003773","dJobCdSeq":"1","dJobNm":"소화용부품조립원","workSum":"소화용 밸브를 생산하기 위해 각종 밸브 부품, 압력계, 경보장치 등을 조립하고 라벨을 부착한다.","doWork":"작업지시서 및 작업표준을 확인한다. 생산계획에 따른 수량을 확인하고 조립에 필요한 공구 및 장비를 준비한다. 자동화된 생산라인의 부품조립 순서에 따라 렌치 및 기타 공구를 사용하여 각종 부품의 조립작업을 실시한다. 제조사와 제품명 등이 기록된 라벨을 부착하여 제품을 완성한다. 도색 상태를 확인하면서 불량품을 선별한다. 완성품을 검사원에게 이송하고 새로운 부품을 입고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8161","dJobECdNm":"[8161]일반기계 조립원","dJobJCd":"8544","dJobJCdNm":"[8544]일반기계 조립원","dJobICd":"C291","dJobICdNm":"[C291]일반 목적용 기계 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003744:1', '{"dJobCd":"K000003744","dJobCdSeq":"1","dJobNm":"송풍기제조반장","workSum":"송풍기를 생산하기 위한 부품제조와 공정관리 업무, 제품시험 및 불량품에 관련한 생산기술 업무를 수행한다.","doWork":"도면 및 작업지시서, 제작시방서를 참고하여 공정라인에 일일작업량 제시 등 작업지시를 한다. 사용할 자재의 입고 여부를 파악하고 사용할 공구의 유무를 확인하여 조치한다. 공정별 장비의 점검일지를 작성하고 시간대별 생산량을 점검하여 작업량을 조절한다. 도면검토 중 치수 및 형상에 관한 문제 발견 시 기술부서장과 협의한다. 불량원인을 분석하여 공정상 문제점을 발견하고 공정의 재배치 또는 기술적 지원을 한다. 작업자의 상태나 숙련정도를 파악하고 인원의 재배치 또는 기술적 지원을 한다. 생산 내역과 기타 사항을 작업일지에 기록을 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"수동조작","dJobECd":"8161","dJobECdNm":"[8161]일반기계 조립원","dJobJCd":"8544","dJobJCdNm":"[8544]일반기계 조립원","dJobICd":"C291","dJobICdNm":"[C291]일반 목적용 기계 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006666:1', '{"dJobCd":"K000006666","dJobCdSeq":"1","dJobNm":"송풍기조립원","workSum":"송풍기를 만들기 위해 모터와 임펠러, 케이싱 등의 각종 부품을 조립한다.","doWork":"송풍기제관원이 만든 몸체와 임펠러가공원이 만든 임펠러의 입고를 확인한다. 각 부품을 조립하기 위해 도면 및 작업지시서를 검토한 후 부품들의 이상 유무를 확인한다. 모터에 임펠러를 끼우고 너트를 잠근다. 케이싱과 각종 부속품을 조립한다. 무게균형 측정장치를 이용하여 송풍기 날개의 무게균형과 각도를 검사하고 볼트 조임의 불량 여부를 검사한다. 작업이 완료된 후 간단한 압력 테스트와 성능 테스트를 한다. 상도 도장을 하기 위해 송풍기도장원에게 완성된 제품을 보낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8161","dJobECdNm":"[8161]일반기계 조립원","dJobJCd":"8544","dJobJCdNm":"[8544]일반기계 조립원","dJobICd":"C291","dJobICdNm":"[C291]일반 목적용 기계 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003334:1', '{"dJobCd":"K000003334","dJobCdSeq":"1","dJobNm":"액체펌프공정검사원","workSum":"액체펌프의 제조공정 중 중간검사 및 수압검사, 조립공정 검사업무를 수행하며, 제조공정 중의 문제점이나 불량제품을 검사한다.","doWork":"작업표준 및 작업지시서에 따라 공정관리 기록표와 관련 도면을 준비하고 점검한다. 액체를 흡입·배출하는 임펠러를 구비한 펌프부공정을 검사한다. 펌프부를 구동하는 모터부 공정을 검사한다. 펌프부를 내장하는 케이스공정을 검사한다. 모터부와 펌프부를 격리하는 칸막이판 공정을 검사한다. 모터부를 보호하기 위해 모터부와 일체 성형된 몰드수지공정을 검사한다. 주축과 임펠러(Impeller)의 평형상태를 검사한다. 임펠러와 라이닝의 틈새간격을 검사한다. 유격 및 진동을 측정한다. 누수상태 및 토출량을 측정한다. 검사결과의 품질관리 리스트를 작성한다. 불량제품을 표기하여 분리하고 재가공부서로 이송한다. 이상이 없는 제품에 검사필증을 부착하고 시험성적표 등을 첨부한다. 출하를 위하여 적재보관소로 이송한다. 검사장비 및 검사설비장치를 정돈하고 주위를 정리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|시각|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8161","dJobECdNm":"[8161]일반기계 조립원","dJobJCd":"8544","dJobJCdNm":"[8544]일반기계 조립원","dJobICd":"C291","dJobICdNm":"[C291]일반 목적용 기계 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001654:1', '{"dJobCd":"K000001654","dJobCdSeq":"1","dJobNm":"여과기시험원","workSum":"수질측정기, 디지털온도계, pH알림기, 누수압력시험기 등을 사용하여 액체여과기 내의 압력, 밀폐, 부식, 용접상태, 여과상태를 점검한다.","doWork":"작업지시서에 따라 가공 및 제작된 액체여과기 제품을 확인한다. 검사에 필요한 장비를 구성하여 준비한다. 검사 기준서에 따라 제품의 내부식성 및 멸균성, 수밀성, 내후성, 복원성, 방로성, 용기 내의 압력 등을 검사한다. 필터의 처리량, 여과되고 남은 찌꺼기의 성질을 검사한다. 기밀시험기 내의 수조에 물을 채운다. 제품 주입구 이외의 불필요한 구멍을 막고 물을 채운다. 용기를 수조에 넣고 수압기로 내압시험 압력까지 용기에 물을 압입하여 압력을 시험한다. 용기에 물을 채운 뒤 수압기로 일정 압력을 가하여 용접부위의 변형 및 누설상태를 검사하여 용접, 밀폐상태를 검사한다. 전자식수질측정기 및 산도 pH알림기로 여과되고 남은 찌꺼기의 성질을 검사한다. 일정 시간 후 디지털 온도계로 제품 내부의 수질온도를 측정한다. 불량제품을 표기하여 분리하고 재가공부서로 이송한다. 이상이 없는 제품에 검사필증을 부착하고 시험성적표 등을 첨부한다. 출하를 위하여 적재보관소로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8161","dJobECdNm":"[8161]일반기계 조립원","dJobJCd":"8544","dJobJCdNm":"[8544]일반기계 조립원","dJobICd":"C291","dJobICdNm":"[C291]일반 목적용 기계 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001851:1', '{"dJobCd":"K000001851","dJobCdSeq":"1","dJobNm":"여과기조립원","workSum":"공구를 사용하여 관련 부속품을 조립하여 액체여과기를 조립한다.","doWork":"작업지시서에 따라 작업에 필요한 공구를 준비한다. 필터장치를 고정하여 프레임 내부에 조립한다. 압력탱크를 튜빙호스에 연결하여 조립한다. 멤브레인 하우징을 체크밸브에 연결한다. 오토샷업 밸브를 멤브레인 하우징에 연결하여 조립한다. 압력스위치를 오토샷업 밸브에 연결하여 조립한다. 폐수저항기를 조립하여 설치한다. 전원 및 안전상태를 확인한다. 레버를 장착하고 외부 프레임을 조립한다. 생산된 제품을 마이크로미터나 버니어캘리퍼스로 측정하여 불량 여부를 판정하고 원인을 판단하여 장비를 정비한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8161","dJobECdNm":"[8161]일반기계 조립원","dJobJCd":"8544","dJobJCdNm":"[8544]일반기계 조립원","dJobICd":"C291","dJobICdNm":"[C291]일반 목적용 기계 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003871:1', '{"dJobCd":"K000003871","dJobCdSeq":"1","dJobNm":"치공구제작반장","workSum":"치공구를 제작하는 일에 종사하는 작업원의 활동을 감독·조정한다.","doWork":"시방서나 설계도면의 내용을 확인한다. 금형설계도에 따른 지그, 절삭공구, 고정구, 게이지, 수동 공구제품 등의 형태에 따라 작업공정계획을 수립한다. 공정별 공정계획을 수립한다. 작업에 필요한 장비, 인원, 재료, 방법 등의 계획을 수립한다. 공정별 작업자 및 작업인원과 선반, 밀링기, 보링기, 그라인더기 등의 작업장비를 점검하고 감독한다. 작업지시서를 작성하여 작업자에게 설명하고 각 공정에 역할을 분담한다. 작업공정을 감독·조정하며 작업공정상의 개선사항을 지시한다. 수동 및 자동계측기를 이용하여 부분품이나 완성된 치공구 제품을 계측하여 도면이나 시방서와 일치하는지 확인한다. 완성된 치공구 제품의 품질을 검사하고, 필요시 작업일지에 기록을 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"수동조작","certLic":"기계가공기능장","dJobECd":"8161","dJobECdNm":"[8161]일반기계 조립원","dJobJCd":"8544","dJobJCdNm":"[8544]일반기계 조립원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003089:1', '{"dJobCd":"K000003089","dJobCdSeq":"1","dJobNm":"펌프조립원","workSum":"펌프와 관련된 부품을 조립공정에 따라 조립하거나 조립설비의 작동 검사 및 유지보수 업무를 수행한다.","doWork":"작업지시서 및 작업표준에 따라 조립공정을 확인한다. 조립설비의 윤활 및 작동상태를 확인하고 펌프의 종류에 따른 부품을 배치한다. 케이싱과 임펠러를 조립한 후 베어링 하우징을 조립한다. 완성된 조립품을 패킹상자와 결합한 후 조립설비를 작동하여 링을 조립한다. 베어링 커버를 조립한 후 육안으로 점검한다. 완성된 조립품에 라벨을 붙이고 동작 테스트를 한다. 완성된 조립품의 검사가 끝나면 도장 공정으로 이동하기 위해 제품을 적재한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8161","dJobECdNm":"[8161]일반기계 조립원","dJobJCd":"8544","dJobJCdNm":"[8544]일반기계 조립원","dJobICd":"C291","dJobICdNm":"[C291]일반 목적용 기계 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;