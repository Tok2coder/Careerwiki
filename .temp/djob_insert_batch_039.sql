INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001905:1', '{"dJobCd":"K000001905","dJobCdSeq":"1","dJobNm":"트래블러교환원","workSum":"가공 처리하는 방사의 종류와 규격에 맞는 트래블러(Traveller) 또는 정기적으로 손상된 링방적기의 트래블러를 교환한다.","doWork":"작업지시서에 따라 기계의 회전속도와 방출되는 실의 번수를 확인하고 규격에 맞는 트래블러를 준비한다. 기계를 정지하고 손이나 갈고리로 트래블러를 교환한다. 기계를 재가동하고 실의 장력을 확인한다. 마모되고 손상된 트래블러를 교환하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"기계정비기능사, 기계정비산업기사","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004000:1', '{"dJobCd":"K000004000","dJobCdSeq":"1","dJobNm":"패턴교환원","workSum":"새로운 무늬의 편직물을 짜기 위해 편직기계를 변경·조작·정비한다.","doWork":"새로운 편직물에 대한 무늬설계 및 직물의 종류를 확인한다. 편직기계의 작동 이상 유무를 점검한다. 편직기계에 부착된 패턴체인·편침(편성침)을 수동공구를 사용하여 떼어낸다. 조립된 패턴체인을 기계의 올림대에 걸고 체인을 연결한다. 직물의 종류에 따라 편침을 교환·조정한다. 부서진 편침을 새것으로 교환한다. 실패에 감긴 실을 기계의 받침대에 올리고 실의 끝을 가이드에 꿰어 기계를 시험 가동한다. 작업 후 무늬설계와 일치하는지 검사한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"기계정비기능사, 기계정비산업기사","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"C133","dJobICdNm":"[C133]편조원단 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001484:1', '{"dJobCd":"K000001484","dJobCdSeq":"1","dJobNm":"편망기보전원","workSum":"끈이나 실을 사용하여 그물을 짜는 편망기를 조정·수리한다.","doWork":"보전에 필요한 부속자재를 수령한다. 주기적인 정비계획이나 필요에 따라 가공할 원료의 종류, 기계의 효율 등 기계에 관한 지식과 가공에 관한 지식을 이용하여 기계의 운전 상태를 점검한다. 그물의 넓이, 길이, 그물눈, 회전수를 수동공구와 자를 사용하여 가이드와 장력롤러를 조정한다. 고장난 부분품을 수리하거나 교체한다. 기계의 부분품에 오일이나 그리스를 주입한다. 주요 수리내용을 기록일지에 기록·보고한다. 솔, 공기호스, 기름걸레 등을 사용하여 기계의 주변을 정리·청소한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"제망기보전원","certLic":"기계정비산업기사, 기계정비기능사","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"C139","dJobICdNm":"[C139]기타 섬유제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004017:1', '{"dJobCd":"K000004017","dJobCdSeq":"1","dJobNm":"편직기수리원","workSum":"의류·장갑·양말 등 편직물을 제조하는 기계를 수리·조정한다.","doWork":"제품사양서나 설계도면에 따라 캠·싱커·편성침 등을 수동공구를 사용하여 설치한다. 기계 각 부위를 점검하여 파손되거나 결함이 있는 부품을 수리·교환한다. 기계를 시험 가동하여 편성물이 제품사양서에 표시된 규격대로 제조되는지 점검한다. 기계 각 부위의 먼지를 제거하고 기름을 칠한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"편물기수리원, 편직기조정원","certLic":"기계정비기능사, 기계정비산업기사","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"C144","dJobICdNm":"[C144]의복 액세서리 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004832:1', '{"dJobCd":"K000004832","dJobCdSeq":"1","dJobNm":"편침교정원","workSum":"편물기계의 편성침 혹은 포인트(Points)를 교체하고 일정한 간격으로 사이를 띄운다.","doWork":"바를 지그(Jig) 혹은 바이스에 고정한다. 바에 있는 물림판, 물린 편침 혹은 포인트를 스크루드라이버를 사용하여 느슨하게 한 후 부서지거나 낡은 편성침을 제거한다. 금속 개스킷을 물림판 밑에 설치하고 편성침 혹은 포인트를 교체하고 물림판에 물린다. 간격게이지 및 플라이어를 사용하여 편성침이나 포인트를 정렬하고 일정한 간격으로 띄운다. 기계의 가이드바 및 싱커를 정렬하는 것을 돕기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"니들몰드원, 편성침교환원","certLic":"기계정비기능사, 기계정비산업기사","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"C133","dJobICdNm":"[C133]편조원단 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003346:1', '{"dJobCd":"K000003346","dJobCdSeq":"1","dJobNm":"폐기물고형연료제조설비제작원","workSum":"폐기물고형연료(RDF:Refuse Derived Fuel)제조설비를 설계된 도면과 시방서에 따라 제작하고 설비의 설치 및 시운전 업무를 수행한다.","doWork":"쓰레기를 일정 크기로 파쇄할 수 있도록 축이나 프레임에 회전날과 고정날을 설치한다. 1차 선별기에서 철부분을 선별할 수 있도록 자석 선별기를 연결하고 선별된 생활쓰레기가 건조기로 이송되도록 컨베이어벨트를 연결한다. 건조기에 생활쓰레기 투입속도, 건조온도 감지 등을 자동 조절하는 장치를 부착한다. 건조된 생활쓰레기가 풍력선별기로 이송되도록 한다. 풍력선별기를 완전밀폐형으로 조립하여 쓰레기분진 및 비산을 방지하도록 한다. 풍력선별기에서 선별된 생활쓰레기를 분쇄할 수 있도록 칼날을 설치한다. 최종 선별된 분쇄생활쓰레기를 고형연료로 성형시키기 위해 압축성형기를 설치한다. 고형연료의 길이 조절이 용이하고 커팅 시 전력소모가 없도록 압축성형기를 제작한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"설치","similarNm":"생활쓰레기고형연료제조설비제작원","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"C292","dJobICdNm":"[C292]특수 목적용 기계 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004196:1', '{"dJobCd":"K000004196","dJobCdSeq":"1","dJobNm":"폐기물자원화설비설치원","workSum":"설계도면에 따라 폐기물자원화 설비를 설치한다.","doWork":"폐기물자원화설비설계기술자에 의해 설계된 도면을 보고 설치해야 하는 기계, 부품 및 구조물에 따라 필요한 공구를 준비한다. 시방서에 따라 슬러지 이송피드 및 스크루를 배송펌프 안에 설치하고 슬러지 저장소에 부착하여 슬러지가 건조기의 호퍼로 이송되도록 한다. 건조기에 원심력 집진기와 여과집진기를 설치하여 분진을 모을 수 있도록 하고 고온건조된 슬러지 미립자를 냉각시켜주는 건조슬러지 냉각기를 연결한다. 냉각된 건조슬러지를 저장조로 보낼 수 있도록 파이프를 연결한다. 건조 시 발생하는 악취를 공기예열기 탱크로 보내 다시 태울 수 있도록 송풍기를 설치한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"설치","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"C292","dJobICdNm":"[C292]특수 목적용 기계 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002800:1', '{"dJobCd":"K000002800","dJobCdSeq":"1","dJobNm":"플라이어수리원","workSum":"플라이어(Flyer)를 깨끗이 닦고 분해하여 이상이 있는 부품을 고치거나 교환하고 재조립한다.","doWork":"더럽고, 손상되고, 녹이 슨 플라이어를 수집하여 작업대로 옮긴다. 오일이 묻은 솔을 사용하여 플라이어의 먼지 및 녹을 깨끗이 닦아낸다. 렌치로 플라이어의 와이어 암을 제거하거나 프레스 아래 허브(Hub)를 놓고 클램프를 여는 페달을 밟는다. 새로운 와이어를 허브 속에 끼워 넣고 렌치나 프레스를 사용하여 조인다. 수리한 플라이어의 번호와 형태를 기록한다. 플라이어를 프레스 아래 설치하여 페달을 밟아 와이어 암을 구부리기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"기계정비기능사, 기계정비산업기사","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001735:1', '{"dJobCd":"K000001735","dJobCdSeq":"1","dJobNm":"혼타면기보전원","workSum":"혼타면 기계(원면을 풀어헤쳐 돗자리 모양의 랩을 생산하는 기계)를 조정·수리한다.","doWork":"주기적인 정비계획이나 필요에 따라 가공할 원료의 종류, 기계의 효율 등 기계에 관한 지식과 가공에 관한 지식을 이용하여 기계의 운전 상태를 점검한다. 수동공구·발판·깔판 등을 준비하고 컨베이어·브랜딩베일오프너(Blending Bale Opener)·믹싱오프너(Mixing Opener)·펜콘덴서(Fan Condencer) 등 기계의 각 부분을 분해·소제·정비한다. 수리내용을 기록일지에 기록·보관한다. 작업장을 순회하며 작동결함을 알아낸다. 주유기를 사용하여 가동부품이나 마찰부품에 윤활유를 도포한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"혼타면기수리원, 혼타면기정비원","certLic":"기계정비기능사, 기계정비산업기사","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004273:1', '{"dJobCd":"K000004273","dJobCdSeq":"1","dJobNm":"기계식주차장치설치원","workSum":"건물 내부, 주차타워 등에서 자동차를 이동시키는 기계식주차장치를 조립·설치한다.","doWork":"설계도서와 시방서를 검토하여 필요한 장비를 준비한다. 설치할 바닥면에 마킹(먹줄)작업을 한다. 기둥을 설치하기 위한 앵커볼트, 앵커플레이트 등 고정철물을 설치한다. 자재를 설치할 위치로 양중·운반하고, 기둥, 횡행폴(Pole), 리프트, 중간프레임, 체인가이드, 횡행·회전레일, 행거파렛트, 상하횡행폴, 내·외부 가이드, 구도부, 출입구 등의 순서로 조립한다. 주위를 정리·정돈하고 운반 및 작업 도중 손상된 부분을 방청 도장한다. 제어반을 설치하고 밸런스·부하·착상조정 등의 테스트를 위하여 시운전을 한다. 승강기검사원에게 검사를 의뢰한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"설치","connectJob":"건물내장형주차승강기설치원, 타워형주차승강기설치원, 카리프트설치원","certLic":"승강기기능사, 승강기산업기사","dJobECd":"8112","dJobECdNm":"[8112]승강기 설치·정비원","dJobJCd":"7532","dJobJCdNm":"[7532]승강기 설치 및 정비원","dJobICd":"F422","dJobICdNm":"[F422]건물설비 설치 공사업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001757:1', '{"dJobCd":"K000001757","dJobCdSeq":"1","dJobNm":"기계식주차장치유지관리원","workSum":"건물 내부, 주차타워 등에서 자동차를 이동시키는 기계식주차장치를 조립·설치한다.","doWork":"설계도서와 시방서를 검토하여 필요한 장비를 준비한다. 설치할 바닥면에 마킹(먹줄)작업을 한다. 기둥을 설치하기 위한 앵커볼트, 앵커플레이트 등 고정철물을 설치한다. 자재를 설치할 위치로 양중·운반하고, 기둥, 횡행폴(Pole), 리프트, 중간프레임, 체인가이드, 횡행·회전레일, 행거파렛트, 상하횡행폴, 내·외부 가이드, 구도부, 출입구 등의 순서로 조립한다. 주위를 정리·정돈하고 운반 및 작업 도중 손상된 부분을 방청 도장한다. 제어반을 설치하고 밸런스·부하·착상조정 등의 테스트를 위하여 시운전을 한다. 승강기검사원에게 검사를 의뢰한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"설치","connectJob":"건물내장형주차승강기설치원, 타워형주차승강기설치원, 카리프트설치원","certLic":"승강기기능사, 승강기산업기사","dJobECd":"8112","dJobECdNm":"[8112]승강기 설치·정비원","dJobJCd":"7532","dJobJCdNm":"[7532]승강기 설치 및 정비원","dJobICd":"F422","dJobICdNm":"[F422]건물설비 설치 공사업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005397:1', '{"dJobCd":"K000005397","dJobCdSeq":"1","dJobNm":"승강기설치소장","workSum":"전기를 동력으로 이용하여 수직으로 가동되는 승강기의 표준 부품과 비표준 부품을 도면에 맞추어 조립, 설치하고 검사하는 종사자들을 관리·감독·조정한다.","doWork":"승강기 설치계획에 따라 승강기 자재에 대한 납품 협의를 한다. 승강기 부품을 수령하고 수령한 부품의 이상 여부를 검사한다. 고객의 주문이나 작업지시서의 내용을 이해하고 엘리베이터의 조립 및 설치 계획을 수립한다. 승강기 설치에 따른 제반 사항을 검토한다. 승강기검사 법정기관에 설치검사를 신청한다. 제작도나 설계도의 내용을 승강기설치원들이 이해하도록 교육한다. 작업원들에게 안전교육을 실시하고 작업현장에 인원을 배치한다. 승강기 설치에 필요한 기술과 장비를 지원한다. 승강기 부품을 신청하고 납품된 자재를 지정된 장소에 보관·관리하고, 현장에서 승강기설치를 지휘·감독한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"10년 초과","workStrong":"보통 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"수동조작","similarNm":"엘리베이터설치소장","connectJob":"기계식주차장치설치소장, 에스컬레이터설치소장","certLic":"승강기산업기사, 승강기기능사, 승강기기사","dJobECd":"8112","dJobECdNm":"[8112]승강기 설치·정비원","dJobJCd":"7532","dJobJCdNm":"[7532]승강기 설치 및 정비원","dJobICd":"F422","dJobICdNm":"[F422]건물설비 설치 공사업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006541:1', '{"dJobCd":"K000006541","dJobCdSeq":"1","dJobNm":"에스컬레이터설치원","workSum":"전기를 동력원으로 자동으로 움직이는 에스컬레이터를 조립·설치·정비한다.","doWork":"작업지시서와 설계도면을 숙지하고 필요한 작업도구를 작업할 위치로 운반한다. 설치할 위치를 설정하고 기중기나 동력윈치를 사용하여 에스컬레이터 몸체를 설치한다. 고정된 에스컬레이터 몸체에 금속판(기계대 밑 부분에 붙는 판)과 기계대의 중심을 맞춘다. 난간 및 난간지지대, 선반받이(Bracket), 스태프체인, 스태프, 유리지지금속 등을 조립한다. 조립이 완료되면 배선 및 결선을 한다. 에스컬레이터에 발이 빠지는 것을 방지하기 위하여 스커트가드, 안전 브러시 등을 설치한다. 시운전을 통하여 구동장치의 진동을 확인하고 스탭, 핸드레일의 손상 등 이상 부분을 검사한다. 고장 시 에스컬레이터를 정비한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"힘든 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"설치","similarNm":"에스컬레이터수리원, 에스컬레이터정비원","connectJob":"무빙워크설치원, 무빙워크정비원, 에스컬레이터관리원, 에스컬레이터공무원, 에스컬레이터유지보수원","certLic":"승강기기능사, 승강기산업기사, 전자기기기능사, 전기기능사","dJobECd":"8112","dJobECdNm":"[8112]승강기 설치·정비원","dJobJCd":"7532","dJobJCdNm":"[7532]승강기 설치 및 정비원","dJobICd":"F422","dJobICdNm":"[F422]건물설비 설치 공사업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005625:1', '{"dJobCd":"K000005625","dJobCdSeq":"1","dJobNm":"엘리베이터설치원","workSum":"엘리베이터의 각종 표준 부품과 비표준 부품을 도면에 맞추어 조립, 설치하고 검사한다.","doWork":"설치도면파악, 시방서파악, 승강로구조확인, 설치공법 결정, 설치공정계획수립, 설치자재 파악 등 승강기설치계획을 수립한다. 기계실, 승강로 배선결선 등 엘리베이터의 전기부문을 설치하고 저속 및 고속 시운전을 한다. 형판설치, 기계실부품설치, 주행안내레일설치 등 기계부문 설치를 한다. (에스컬레이터: 트러스트, 디딤판찯작, 손잡이 설치, 전기장치조립 등의 설치하고 조정한다)","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"승강기설치원, 엘리베이터(승강기)수리원, 엘리베이터(승강기)정비원","connectJob":"엘리베이터조립원, 장애인용리프트정비원, 엘리베이터(승강기)관리원, 화물엘리베이터설치원, 화물엘리베이터정비원, 엘리베이터(승강기)유지보수원, 엘리베이터공무원","certLic":"승강기기능사, 승강기산업기사, 전자기기기능사, 전기기능사","dJobECd":"8112","dJobECdNm":"[8112]승강기 설치·정비원","dJobJCd":"7532","dJobJCdNm":"[7532]승강기 설치 및 정비원","dJobICd":"C291","dJobICdNm":"[C291]일반 목적용 기계 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001232:1', '{"dJobCd":"K000001232","dJobCdSeq":"1","dJobNm":"엘리베이터유지관리원","workSum":"엘리베이터, 에스컬레이터의 각종 표준 부품과 비표준 부품을 도면에 맞추어 주기적인 점검, 승강기 또는 승강기부품의 수리 및 승강기부품을 교체를 한다.","doWork":"각종 표준 부품과 비표준 부품을 도면에 맞추어 점검계획을 수립하고 승강기(엘리베이터(기계실, 키, 승강로, 승강장, 피트 등), 에스컬레이터(구동부, 안전장치, 손장빙, 상부기계실, 하부기계실 등)를 주기적으로 점검한다. 부품의 상태를 진단하고 자재를 수급하며, 메다는 장치, 도르레/폴리, 전기부문, 구동기, 키 등 승강기부품을 교체한다. 에스컬레이터의 경우 부품의 상태를 진단하고 자재를 수급하며, 손잡이, 디딤판, 체인, 소모성부품 등 승강기부품을 교체한다. 승강기 설치검사 및 안전검사를 수검한다. 승강기 기계설비 및 제어설비 등의 고장처리를 한다. 원격제어 등 스마트유지관리를 한다. 승강기 유지관리 시 필요한 안전관리 사항 확인, 안전장구준비, 전기안전준수 등 안전문서 작성 등 안전관리를 한다. 폐자재, 폐유 처리 등 환경관리 업무를 한다. 승강기유지관리를 위한 유지보수 계약서 작성, 견적서 작성, 업무일지 작성 등의 업무를 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"승강기(엘리베이터, 에스컬레이터)정비원,  승강기(엘리베이터, 에스컬레이터) 유지보수원","connectJob":"엘리베이터(승강기)유지관리원, 에스컬레이터(승강기) 유지관리원, 엘리베이터공무원","certLic":"승강기기능사, 승강기산업기사, 전자기기기능사, 전기기능사","dJobECd":"8112","dJobECdNm":"[8112]승강기 설치·정비원","dJobJCd":"7532","dJobJCdNm":"[7532]승강기 설치 및 정비원","dJobICd":"C291","dJobICdNm":"[C291]일반 목적용 기계 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001577:1', '{"dJobCd":"K000001577","dJobCdSeq":"1","dJobNm":"리거","workSum":"고객, 검사기관 또는 관련 법규에 따라 각종 기계 장비, 파이프를 고정, 정렬, 하중을 계산하여 기계 장비, 파이프가 안전하게 설치, 취외 운반할 수 있도록 한다.","doWork":"설치 취외 할 기계 장비, 파이프의 제원, 설계도, 하중무게, 무게중심과 안전 관련 규정 등을 파악한다. 작업내용, 작업 범위, 공사 기간 등을 반영하여 작업계획서를 작성한다. 작업에 필요한 공구목록을 작성하고 준비한다. 각종 기계장비, 파이프 등을 취외, 설치, 이동한다. 관련 작업순서와 안전규정에 따라 작업을 하고 작업내용을 기록한다. 작업이 완료되면 작업 내용서를 작성하여 고객 및 작업 요청부서에 인계한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|손사용|시각|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"수동조작","dJobECd":"8113","dJobECdNm":"[8113]물품이동장비 설치·정비원","dJobJCd":"7533","dJobJCdNm":"[7533]물품 이동 장비 설치 및 정비원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002910:1', '{"dJobCd":"K000002910","dJobCdSeq":"1","dJobNm":"지게차정비원","workSum":"지게차의 부속품 및 장치를 수리·교체·정비한다.","doWork":"지게차를 시운전하여 이상 유무를 점검하고 부품의 교체, 조정, 수리, 정비할 부분을 파악한다. 엔진(실린더헤드, 실린더·피스톤, 크랭크샤프트, 캠샤프트, 연료펌프 등), 유압장치, 변속기, 전·후 차축 및 제동장치, 차체(프레임, 롤러, 링크, 트랙슈 등) 등을 탈부착 및 분해·정비한다. 정비이력서를 작성한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"청각|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"건설기계정비기능사, 건설기계정비산업기사, 건설기계정비기능장","dJobECd":"8113","dJobECdNm":"[8113]물품이동장비 설치·정비원","dJobJCd":"7533","dJobJCdNm":"[7533]물품 이동 장비 설치 및 정비원","dJobICd":"F426","dJobICdNm":"[F426]건설장비 운영업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001520:1', '{"dJobCd":"K000001520","dJobCdSeq":"1","dJobNm":"케이블카정비원","workSum":"케이블카를 운전하며 원동기, 전기설비, 기계설비 및 기타 삭도설비를 정비한다.","doWork":"케이블카 운행시간 전에 시운전을 한다. 기어를 점검하고 오일을 주입한다. 케이블카 내부, 외부, 주행상태를 점검하여 이상 유무를 확인한다. 폐쇄회로티브이(CCTV)를 통해 승객의 탑승 여부를 확인한다. 운전 장치를 조작하여 케이블카를 구동한다. 케이블카 운행원의 출발신호를 받아 출발한다. 목적지에 도착 후 승객하차를 확인한다. 운행이 종료되면 운행기록부를 작성한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"승강기기능사, 승강기산업기사","dJobECd":"8113","dJobECdNm":"[8113]물품이동장비 설치·정비원","dJobJCd":"7533","dJobJCdNm":"[7533]물품 이동 장비 설치 및 정비원","dJobICd":"H492","dJobICdNm":"[H492]육상 여객 운송업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002047:1', '{"dJobCd":"K000002047","dJobCdSeq":"1","dJobNm":"타워크레인설치원","workSum":"고층 건물의 건설현장에서 자재, 제품, 재료 등을 수직·수평으로 운반하는 타워크레인을 설치한다.","doWork":"작업반경, 하중지지력, 인양능력 등을 고려하여 정해진 설치 위치를 확인한다. 철근, 고정앵커, 받침앵글을 결속하여 콘크리트를 타설한다. 기초앵커 및 기초마스트를 일렬로 맞춘 후 고정한다. 텔레스코핑케이지, 운전실, 캣헤드, 카운트지브, 메인지브 등을 순서대로 조립한 후 볼트 및 핀을 이용하여 연결부위를 고정한다. 카운터웨이트의 중량을 확인하고 웨이트블록을 배치한다. 와이어로프를 설치한 후 로프이탈 방지장치를 설치한다. 공사 진행 중에 텔레스코핑케이지를 이용하여 공간을 만들고 마스트를 넣어 타워크레인의 높이를 올리는 텔레스코핑 작업을 한다. 골조 작업이 마무리되면 타워크레인을 설치했던 순서의 역순으로 해체한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"힘든 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"설치","similarNm":"타워크레인설치기사","connectJob":"리프트설치원, 호이스트설치원","dJobECd":"8113","dJobECdNm":"[8113]물품이동장비 설치·정비원","dJobJCd":"7533","dJobJCdNm":"[7533]물품 이동 장비 설치 및 정비원","dJobICd":"F421","dJobICdNm":"[F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005399:1', '{"dJobCd":"K000005399","dJobCdSeq":"1","dJobNm":"가스설비설치관리자","workSum":"가스를 수용가에 공급하기 위한 각종 설비의 유지·관리 및 정비를 하는 작업자의 활동을 관리·감독한다.","doWork":"정비할 작업내용을 작업자에게 배포한다. 계획에 의하여 작업자를 배치한다. 작업진행상황을 점검한다. 작업자 직무향상 교육계획을 마련한다. 가스공급상황실의 연락에 따라 긴급상황에 대처한다. 수시 관찰과 면담을 통하여 작업원의 애로사항 및 건의사항을 수렴·해결하고 문제점을 보고한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","certLic":"가스기능사, 가스산업기사, 가스기능장","dJobECd":"8114","dJobECdNm":"[8114]냉동·냉장·공조기 설치·정비원","dJobJCd":"7534","dJobJCdNm":"[7534]냉동·냉장·공조기 설치 및 정비원","dJobICd":"D352","dJobICdNm":"[D352]연료용 가스 제조 및 배관공급업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004472:1', '{"dJobCd":"K000004472","dJobCdSeq":"1","dJobNm":"가스설비정비원","workSum":"가스를 수용가에 공급하기 위해 각종 설비를 유지·관리하고 정비한다.","doWork":"정비를 위한 일정을 수립하고 필요한 자재 및 공구를 준비한다. 각종 설비의 점검표를 이용하여 이상 및 장애요인을 파악한다. 파악된 문제점에 따라 규정에 의해 정비작업을 수행한다. 정비 중 발견된 문제점과 개선사항을 보고한다. 정비에 필요한 각종 문서들을 관리·보관한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"가스기능사, 가스산업기사, 가스기능장","dJobECd":"8114","dJobECdNm":"[8114]냉동·냉장·공조기 설치·정비원","dJobJCd":"7534","dJobJCdNm":"[7534]냉동·냉장·공조기 설치 및 정비원","dJobICd":"D352","dJobICdNm":"[D352]연료용 가스 제조 및 배관공급업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002772:1', '{"dJobCd":"K000002772","dJobCdSeq":"1","dJobNm":"냉동공조설비설치원","workSum":"설계도서에 따라 열원설비, 공조설비, 자동제어설비 등을 설치하고 성능을 확인한다.","doWork":"설계도서에 따라 냉동공조설비 설치계획을 수립한다. 시방서, 내역서, 부하계산서, 설계도면 등 설계도서가 현장 여건과 일치하는지 확인하고 검토한다. 설치할 설비의 상태, 기능, 성능을 점검한다. 설치공사를 시행하고 관리한다. 냉열원장치(증기압축식 냉동장치, 흡수식 냉동장치, 빙축열 설비, 지열설비, GHP, EHP, 시스템에어컨 등), 온열원장치(보일러설비, 증기설비, 난방설비, 급탕설비 등 기타 가열장치)를 설치한다. 공조기, 공조배관, 공조덕트, 환기설비, 급배수설비 등을 설치한다. 공조 및 열원설비의 성능을 유지하고 효율적인 운전을 위한 자동제어시스템을 구성하고 설치한다. 시운전을 통해 평가 및 성능검사를 수행한다. 설치에 따른 안전관리 업무를 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"설치","certLic":"공조냉동산업기사","dJobECd":"8114","dJobECdNm":"[8114]냉동·냉장·공조기 설치·정비원","dJobJCd":"7534","dJobJCdNm":"[7534]냉동·냉장·공조기 설치 및 정비원","dJobICd":"D353","dJobICdNm":"[D353]증기, 냉·온수 및 공기조절 공급업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005956:1', '{"dJobCd":"K000005956","dJobCdSeq":"1","dJobNm":"냉동배관연결원","workSum":"작업표준에 따른 고압냉매가스 및 냉동배관 조립을 위하여 일정한 길이로 동관을 배열하고 냉방기용 코일과 결합시키는 확관기를 조작하여 동관을 연결·조립한다.","doWork":"작업지시서에 따라 조립할 동관제품의 시방서를 확인·검토한다. 동파이프 확관기, 커터기 등 작업에 필요한 장비와 작업공구를 준비한다. 도면 및 작업시방서에 따라 동관의 절단, 확관, 조립방법을 계산한다. 동파이프를 도면에 따라 절단한다. 절단한 파이프의 끝부분을 확관기로 확관한다. 확관부위에 동관을 조립·연결한다. 도면에 따라 동관을 배열하여 고정한다. 작업지시서상의 작업공정을 단계별로 수행한다. 공정 후 연결부위의 누수가 없는지 확인·점검한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"냉동배관원","certLic":"배관기능사, 배관산업기사","dJobECd":"8114","dJobECdNm":"[8114]냉동·냉장·공조기 설치·정비원","dJobJCd":"7534","dJobJCdNm":"[7534]냉동·냉장·공조기 설치 및 정비원","dJobICd":"C291","dJobICdNm":"[C291]일반 목적용 기계 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007382:1', '{"dJobCd":"K000007382","dJobCdSeq":"1","dJobNm":"냉매회수사","workSum":"냉매회수기, 저울, 냉매 저장 용기 등을 사용해 가정용, 상업용, 산업용 냉동공조기의 냉매 회수 작업을 수행한다.","doWork":"작업 매뉴얼에 따라 냉매 종류와 충전량을 확인하고 누출과 수리 여부를 판단해 누출이 없음을 확인 후, 회수·재생 장비(냉매회수기로 수정)를 조작해 회수·재생 작업을 한다. 냉매를 압축기를 통해 흡입하고 응축기를 통해 액화시켜 용기에 담는다. 냉매 누출 등을 정기적으로 점검해 예방하고 냉매 관련 각종 장비를 유지·관리·보수한다. 회수 결과에 대해 감독자에게 보고서(회수결과표)를 작성해 제출한다. 회수한 냉매를 재생, 재처리 업체에 판매한다. 해당 냉매 사용 기기의 최적 효율을 위한 적정 냉매량 유지를 위해 회수한 냉매의 불순 성분 제거 후 냉매를 재활용하거나 추가량을 충전하기도 한다. 냉동기에 대한 기본 지식을 통해 고객상담을 하기도 한다. 가정용, 산업용, 상업용 냉동공조기의 냉매를 회수한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"냉매회수전문가","certLic":"공조냉동기계산업기사, 냉동산업기사, 기능사, 가스기능사","dJobECd":"8114","dJobECdNm":"[8114]냉동·냉장·공조기 설치·정비원","dJobJCd":"7534","dJobJCdNm":"[7534]냉동·냉장·공조기 설치 및 정비원","dJobICd":"D353","dJobICdNm":"[D353]증기, 냉·온수 및 공기조절 공급업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006859:1', '{"dJobCd":"K000006859","dJobCdSeq":"1","dJobNm":"냉장설비수리원","workSum":"공장 및 사무실에 사용되는 냉방 및 냉장설비를 점검하고 정비한다.","doWork":"정기적으로 냉방설비 및 보조설비의 이상 유무를 점검한다. 고장 시 냉장설비 및 보조설비의 온도, 압력, 수위, 진동, 누설, 이상음 발생 등을 진단한다. 배관, 밸브 등 정비할 부품이나 설비를 분해한다. 파손 또는 마모의 경중에 따라 수리하거나 부품을 교체한다. 정비한 설비를 재조립한다. 시운전을 하고 설비의 게이지를 재조정한다. 정기적으로 냉장설비 및 보조설비에 이상이 없는지 점검한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"공조냉동기계기능사, 공조냉동기계산업기사","dJobECd":"8114","dJobECdNm":"[8114]냉동·냉장·공조기 설치·정비원","dJobJCd":"7534","dJobJCdNm":"[7534]냉동·냉장·공조기 설치 및 정비원","dJobICd":"C340","dJobICdNm":"[C340]산업용 기계 및 장비 수리업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004606:1', '{"dJobCd":"K000004606","dJobCdSeq":"1","dJobNm":"지하철설비관리원","workSum":"지하철 역사, 본선 및 기지 내의 기계설비를 설치 및 유지·관리한다.","doWork":"지하철 역사, 본선 및 기지 내에 냉난방설비, 공기조화설비, 환기설비, 배수펌프설비, 위생급수시설, 소화 및 화재탐지시설 등을 설치한다. 주기적으로 설비를 관리·점검하여 유지한다. 고장이 발생했을 경우 고장 부위 및 정도에 따라 외부업체 등에 연락하여 보수하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실외","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"지하철설비공무원","certLic":"기계정비기능사, 기계정비산업기사","dJobECd":"8114","dJobECdNm":"[8114]냉동·냉장·공조기 설치·정비원","dJobJCd":"7534","dJobJCdNm":"[7534]냉동·냉장·공조기 설치 및 정비원","dJobICd":"H492","dJobICdNm":"[H492]육상 여객 운송업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004424:1', '{"dJobCd":"K000004424","dJobCdSeq":"1","dJobNm":"보일러검사원","workSum":"완성된 보일러의 검사를 위해 외부의 성능과 치수 등을 확인하고 각종 시험을 한다.","doWork":"검사기준서의 내용을 확인한다. 검사에 필요한 검사장비 및 도구들을 준비한다. 동체와 노통(노통연관식 보일러에서 연소실, 연소가스 통로 및 전열면으로 사용되는 공간) 사이의 연관취부, 확관 상태를 검사한다. 보일러의 내관 및 외관에 규정부품이 사용되어 조립되었는지를 확인한다. 배관의 배선상태, 난방공급장치, 회전수, 배기장치, 급배기통, 풍량, 부속장치 및 기타 검사기준서의 부속품을 검사하여 기록한다. 보일러 자체검사성적서(공작, 기계적 시험), 보일러 용접부위도, 방사선 투과시험성적서, 초음파탐상시험성적서, 후열처리 기록사항, 보일러제조(용접·구조)검사자체기록서, 압력용기 자체검사성적서(공작) 등을 작성한다. 검사 완료된 제품을 출하장으로 보낸다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"에너지관리기능사, 에너지관리산업기사","dJobECd":"8115","dJobECdNm":"[8115]보일러 설치·정비원","dJobJCd":"7535","dJobJCdNm":"[7535]보일러 설치 및 정비원","dJobICd":"C251","dJobICdNm":"[C251]구조용 금속제품, 탱크 및 증기발생기 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001882:1', '{"dJobCd":"K000001882","dJobCdSeq":"1","dJobNm":"보일러설치반장","workSum":"연료의 연소열로 물을 가열하여 증기를 만드는 산업용 및 건물용 보일러와 부속설비를 설치·조정하는 작업원의 활동을 감독·조정한다.","doWork":"설계도나 시방서의 내용을 확인하여 구체적인 작업계획을 세운다. 보일러설비의 용량과 관의 관경별 필요량을 산출한다. 보일러설치원에게 작업량을 할당하고 안전사항을 교육한다. 각종 장비로 검사하여 연소장치, 배관상태, 안전장치 및 급배기 등을 조정·점검한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","certLic":"에너지관리기능사, 에너지관리산업기사, 에너지관리기능장","dJobECd":"8115","dJobECdNm":"[8115]보일러 설치·정비원","dJobJCd":"7535","dJobJCdNm":"[7535]보일러 설치 및 정비원","dJobICd":"F422","dJobICdNm":"[F422]건물설비 설치 공사업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004686:1', '{"dJobCd":"K000004686","dJobCdSeq":"1","dJobNm":"보일러설치보조원","workSum":"연료의 연소열로 물을 가열하여 증기를 만드는 산업용 및 건물 난방용 보일러, 부속 설비물을 설치·조정하는 보일러설치원을 보조한다.","doWork":"규격에 맞는 슬리브(Sleeve)를 선별하여 절단하고 형강을 이용하여 보일러 받침대를 제작한다. 도면을 보거나 보일러설치원의 지시에 따라 주장비와 보조장비를 연결하는 각종 관을 규격별로 선별하여 절단, 리밍(Reaming), 용접작업을 하고 티(T)·엘보우(Elbow) 등을 이용하여 반조립한다. 보일러 및 부속설비·연결관 등의 외부를 청소하고 부식방지용 페인트를 칠한다. 보일러의 케이싱을 암면, 유리섬유 등의 재료를 이용하여 충분히 보온한다. 모르타르를 배합하여 슬리브 주위·보일러기초·탱크지지대 주위 등에 바른다. 보일러의 최고사용압력·형식·제조자명 및 제조일을 표시한 판을 부착한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"에너지관리기능사, 에너지관리산업기사","dJobECd":"8115","dJobECdNm":"[8115]보일러 설치·정비원","dJobJCd":"7535","dJobJCdNm":"[7535]보일러 설치 및 정비원","dJobICd":"F422","dJobICdNm":"[F422]건물설비 설치 공사업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004295:1', '{"dJobCd":"K000004295","dJobCdSeq":"1","dJobNm":"보일러설치원","workSum":"연료의 연소열로 물을 가열하여 증기를 만드는 산업용 및 건물 난방용 보일러를 설치하기 위하여 보일러, 탱크, 압력용기, 열교환기 등을 설치한다.","doWork":"기반 위에 축조한 콘크리트 또는 철근콘크리트 기초의 수평상태를 수준기로 검사한다. 바닥에 휨과 처짐이 발생하지 않도록 기초 위에 가설받침대를 수평으로 설치하고 기초볼트로 균등하게 조인다. 보일러본체, 탱크, 펌프 등을 새들 및 잭을 사용하여 가설받침대에 올려놓고 정확한 설치치수로 설치한다. 펌프의 누수를 받기 위해 기초 주위에 배수홈을 만든다. 배관은 플랜지 및 밸브를 부착하여 기기류의 탈착이 용이하고 그 중량이 직접 기기에 걸리지 않도록 지지 및 고정한다. 탱크와 연소장치 사이에 연료 이송관을 연결하고 케이트, 밸브, 첵밸브, 유수분리기, 오일필터 등을 연료 이송관에 나사이음으로 조립한다. 용접 또는 리베팅 가공으로 연도를 조립하고, 연도의 이음부분은 기밀을 유지하기 위하여 석면사 또는 패킹을 삽입한다. 연도의 길이에 따라 적당한 부분에 걸이 또는 브래킷과 가대로 지지한다. 보일러의 주밸브와 건물난방용 배관구 또는 산업기기의 스팀 밸브 사이에 관을 연결하여 용접하고 압력계를 설치한다. 온도계, 수면계, 유량계 등 각종 측정기기를 부착한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"설치","connectJob":"산업용보일러시공원, 공장보일러설치원, 공장보일러정비원, 공장보일러설치기사, 공장보일러정비기사, 빌딩용보일러설치원, 빌딩용보일러설치기사, 빌딩용보일러정비기사, APT보일러설치원, APT보일러설치기사, APT보일러정비기사, 가정용보일러설치원, 상가보일러설치원","certLic":"에너지관리기능사, 에너지관리산업기사","dJobECd":"8115","dJobECdNm":"[8115]보일러 설치·정비원","dJobJCd":"7535","dJobJCdNm":"[7535]보일러 설치 및 정비원","dJobICd":"F422","dJobICdNm":"[F422]건물설비 설치 공사업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002843:1', '{"dJobCd":"K000002843","dJobCdSeq":"1","dJobNm":"보일러수리원","workSum":"공장용 또는 건물용 보일러 및 보조설비를 수리한다.","doWork":"고장 난 보일러 및 보조설비의 온도, 압력, 수위, 진동, 누설, 이상음 발생 등을 진단한다. 배관, 밸브 등 정비할 부품이나 설비를 분해한다. 파손 또는 마모의 경중에 따라 수리하거나 부품을 교체한다. 정비한 설비를 재조립한다. 시운전을 하고 설비의 게이지를 재조정한다. 정기적으로 보일러 및 보조설비의 이상 유무를 점검한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"웅크림|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"산업용보일러수리원, 빌딩용보일러수리원, APT보일러 수리원, 가정용보일러수리원","connectJob":"공장보일러공무원, 공장보일러기계설비공무원, 빌딩용보일러유지보수원, 빌딩용보일러공무원, APT보일러공무원","certLic":"에너지관리기능사, 에너지관리산업기사","dJobECd":"8115","dJobECdNm":"[8115]보일러 설치·정비원","dJobJCd":"7535","dJobJCdNm":"[7535]보일러 설치 및 정비원","dJobICd":"C340","dJobICdNm":"[C340]산업용 기계 및 장비 수리업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003730:1', '{"dJobCd":"K000003730","dJobCdSeq":"1","dJobNm":"보일러시험원","workSum":"제조공정이 완료된 보일러의 외관 및 내관의 가동상태를 점검하기 위해 보일러를 시험가동하고 각 부품의 정상가동 여부와 작동압력, 연소기의 작동상태 등을 검사·시험한다.","doWork":"검사기준서를 확인하고 검사, 시험에 필요한 각종 도구를 준비한다. 내·외관상으로 규정부품이 조립되었는지 확인한다. 시험보일러에 연료를 채우고 스위치를 시운전 상태로 켠다. 배관의 세관상태를 확인한다. 착화상태를 시험한다. 자동물보충과 배관의 공기순환이 원활하게 작동되는지 검사한다. 전기가 누전되는지를 시험한다. 가스경보기의 작동을 시험한다. 급기, 환기, 배기상태를 시험한다. 연소기 작동상태 등 작업표준에 의거 규정된 사항을 체크한다. 보일러의 스위치를 다운 정지시키고 배수관 내의 물을 뺀다. 압축공기를 이용하여 내부의 수분을 제거한다. 시험결과를 기록지에 작성하고 보고한다. 명판을 보일러에 부착한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"고온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"에너지관리기능사, 에너지관리산업기사","dJobECd":"8115","dJobECdNm":"[8115]보일러 설치·정비원","dJobJCd":"7535","dJobJCdNm":"[7535]보일러 설치 및 정비원","dJobICd":"C251","dJobICdNm":"[C251]구조용 금속제품, 탱크 및 증기발생기 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005490:1', '{"dJobCd":"K000005490","dJobCdSeq":"1","dJobNm":"지열시스템연결원","workSum":"지중열교환기에서 지중열 교환이 적절하게 이루어지는지 확인한 후 히트펌프와 순환펌프를 연결하고 건물 내 냉난방 시스템이 잘 작동하는지 검사한다.","doWork":"지중열 교환이 적절하게 잘 이루어지고 있는지 확인한 후 지중열교환기 분배헤더를 연결하고 히트펌프 및 순환펌프를 설치한다. 부동액과 물로 이루어진 작동유체의 에어퍼징과 플러싱을 한다. 시스템 시험가동 및 최적화를 위해 히트펌프 정상가동 시험, 냉난방 전환운전 시험, 비상시 안전모드 검사 등을 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"에너지관리기능사, 에너지관리산업기사","dJobECd":"8115","dJobECdNm":"[8115]보일러 설치·정비원","dJobJCd":"7535","dJobJCdNm":"[7535]보일러 설치 및 정비원","dJobICd":"C251","dJobICdNm":"[C251]구조용 금속제품, 탱크 및 증기발생기 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007145:1', '{"dJobCd":"K000007145","dJobCdSeq":"1","dJobNm":"건설기계정비원","workSum":"중장비의 원활한 작동과 운행을 유지하기 위하여 엔진계통과 램프, 배선, 배터리 등의 전기계통과 변속기·기어 등의 전달계통의 부속품 및 장치를 분해하고 수리·교체·정비한다.","doWork":"각종 중장비의 시동순서에 따라 시동을 걸고 시운전하여 엔진의 이상 유무를 점검한다. 수공구나 동력공구를 사용하여 연료분사노즐을 탈거하고 압력게이지를 부착한 후 스타트모터를 동작시켜 실린더 압축력을 측정하여 기준과 일치하는지 점검한다. 오일, 연료, 작동유, 냉각수 등의 누유상태 및 크랭크마모, 엔진노킹, 밸브간격 등을 확인·점검하고 이상발견 시 정비한다. 전기측정테스터를 사용하여 엔진의 점검부위와 고장부위를 검사한다. 라디에이터를 점검·수리한다. 배터리 비중을 측정하고 누전 및 절선상태를 점검하고 이상 부위를 수리한다. 스타트모터, 알터네이터(교류발전기), 레귤레이터(조절장치), 램프 등의 작동상태를 확인·점검하여 마모품·손상품을 수리하거나 교체한다. 변속기·기어 등을 수공구를 사용하여 분해하고 마모되거나 절단된 부분을 발견하여 교체하거나 수리한다. 트랙의 이완이나 마모상태를 확인하여 정비하고 휠(Wheel)의 균형을 조정한다. 트랙류, 롤러류, 시그메트리류 등의 동력전달장치를 정비하여 마모, 절단, 노후화된 부분을 수리·교체한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"청각|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"중장비정비원, 건설장비정비원","connectJob":"중장비엔진정비원, 중장비전기정비원, 콘크리트제조설비정비원, 지게차정비원, 지게차유지보수원, 건설기계공무원, 불도저정비원, 굴삭기정비원, 로더정비원, 롤러정비원, 콘크리트피니셔정비원, 천공기정비원, 포크레인정비원","certLic":"건설기계정비기능사, 건설기계정비산업기사, 건설기계정비기능장","dJobECd":"8116","dJobECdNm":"[8116]건설·광업 기계 설치·정비원","dJobJCd":"7536","dJobJCdNm":"[7536]건설·광업기계 설치 및 정비원","dJobICd":"F426","dJobICdNm":"[F426]건설장비 운영업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006920:1', '{"dJobCd":"K000006920","dJobCdSeq":"1","dJobNm":"광산기계정비원","workSum":"채굴 등 광업활동에 사용되는 각종 장비나 기기의 원활한 가동을 위하여 기능장애 요인을 파악하고 고장 유무 및 윤활 등을 점검하여 기계의 수리 및 부품 교환 작업을 한다.","doWork":"기계 및 기기의 성능이나 작동상태를 성능기기를 통해 점검하거나 사용자의 설명을 듣고 고장원인을 찾는다. 판별된 고장부위의 세부점검을 위해 공구를 사용하여 제품을 분해한다. 부품의 마모 및 손상 여부를 측정기기를 사용하여 측정하거나 육안으로 점검하여 교체 여부를 결정한다. 부품을 교체하거나 재조립 후 성능을 검사한다. 작업 후 작업일지를 작성하고 부품의 재고를 파악한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"광산용기기정비원","connectJob":"공기압축기정비원, 광산기관차정비원, 광차정비원, 권양기정비원, 마쇄기정비원, 착암기정비원, 파쇄기정비원, 선광기정비원, 선탄기정비원, 골재채취용기계정비원","certLic":"기계정비기능사, 기계정비산업기사","dJobECd":"8116","dJobECdNm":"[8116]건설·광업 기계 설치·정비원","dJobJCd":"7536","dJobJCdNm":"[7536]건설·광업기계 설치 및 정비원","dJobICd":"C340","dJobICdNm":"[C340]산업용 기계 및 장비 수리업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005881:1', '{"dJobCd":"K000005881","dJobCdSeq":"1","dJobNm":"농업기계수리원","workSum":"트랙터 및 경운기, 양수기 등 농업용 기계와 설비를 유지 및 정비한다.","doWork":"기중기, 해머, 수동용 공구를 사용하여 고장 및 파손된 농업용 기계를 분해·점검한다. 각종 벨트의 헐거움이나 냉각장치, 윤활장치, 시동장치 등을 테스터기 또는 육안으로 점검하여 엔진의 상태를 점검한다. 각 부품의 마모정도와 손상을 육안 또는 청각으로 조사하여 이상이 있는 부품을 교체하거나 정비한다. 정비 후 시운전을 하여 이상 유무를 확인하고, 부품의 조립상태를 점검한다. 농기구를 점검 및 수리하기도 하고 각종 펌프의 설치 및 유지 보수업무를 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"농업용기계정비원","connectJob":"농업용기계공무원","certLic":"농기계정비기능사, 기계정비기능사, 기계정비산업기사","dJobECd":"8119","dJobECdNm":"[8119]농업용 및 기타 기계장비 설치·정비원","dJobJCd":"7539","dJobJCdNm":"[7539]농업용·기타 기계장비 설치 및 정비원","dJobICd":"C340","dJobICdNm":"[C340]산업용 기계 및 장비 수리업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003446:1', '{"dJobCd":"K000003446","dJobCdSeq":"1","dJobNm":"사무용기기수리원","workSum":"팩시밀리, 복사기, 복합기와 같은 사무기기를 점검 및 수리한다.","doWork":"수리를 의뢰한 기기의 고장내역을 검토한다. 기기를 작동시키고 회로상의 고장인지 물리적인 손상인지 확인한다. 수동공구를 사용하여 기계를 분해하고, 각종 기어, 가이드, 롤러 등의 부품을 검사한다. 수동공구, 전동드라이버, 납땜기구 등을 사용하여 기판을 교체하거나 땜질하고 부품의 교환 작업을 수행한다. 작동 부품을 소제하고 윤활제를 주입한다. 사무기기의 파손 또는 고장원인을 소비자에게 설명하고 제품손상 여부 및 교체부품에 따라 견적을 산출한다. 기계사용의 주의사항이나 조작방법 등을 설명하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"사무기기애프터서비스원, 사무기기A/S수리원, 사무기기에이에스수리원, 사무기기에이에스원, 사무기기A/S원","connectJob":"하는 일에 따라 계수기수리원, 팩스수리원, 빔프로젝트수리원, 복사기수리기사, 사무기기A/S요원, 복합기수리원","dJobECd":"8321","dJobECdNm":"[8321]사무용 전자기기 설치·수리원","dJobJCd":"7611","dJobJCdNm":"[7611]사무용 전자기기 설치 및 수리원","dJobICd":"C340","dJobICdNm":"[C340]산업용 기계 및 장비 수리업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004237:1', '{"dJobCd":"K000004237","dJobCdSeq":"1","dJobNm":"사무용기기수리현장감독자","workSum":"복사기, 계산기, 팩시밀리 등의 사무용 기기제품을 정비하고 수리하는 일에 종사하는 작업원의 활동을 감독·조정한다.","doWork":"공정표·작업지시서에 의하여 조립되는 완제품의 불량 유무를 확인하다. 불량의 원인에 따라 작업·자재·설계·외주 등 구분하여 파악하고 작업일지를 작성하며 동일한 불량의 재발을 방지하기 위하여 관련 부서에 통보한다. 정비와 수리 절차에 대해 작업원들을 훈련시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"사무용기계수리반장, 사무기기A/S수리반장, 사무기기에이에스수리반장, 사무기기A/S반장, 사무기기에이에스반장, 사무용기기수리반장","connectJob":"하는 일에 따라 계수기수리반장, 팩스수리반장, 빔프로젝트수리반장, 복사기수리반장","dJobECd":"8321","dJobECdNm":"[8321]사무용 전자기기 설치·수리원","dJobJCd":"7611","dJobJCdNm":"[7611]사무용 전자기기 설치 및 수리원","dJobICd":"C340","dJobICdNm":"[C340]산업용 기계 및 장비 수리업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003623:1', '{"dJobCd":"K000003623","dJobCdSeq":"1","dJobNm":"가전제품수리원","workSum":"소비자의 의뢰에 따라 파손된 텔레비전이나 냉장고, 세탁기 등의 가전제품의 이상 유무를 확인하여 수리한다.","doWork":"소비자의 방문 또는 통신을 통해 고장수리를 의뢰받는다. 사후 관리를 위해 직접 소비자를 방문하거나 소비자의 직접 방문을 통한 고장물품 접수를 한다. 오실로스코프의 파형을 보면서 제품의 이상결함을 살피거나, 전기테스터기를 이용하여 가전제품의 퓨즈 상태 및 단선, 쇼트 여부를 점검한다. 상태에 따라 유상 또는 무상수리 여부를 결정하여 소비자에게 통보하며 부품 교체나 파손부위 수리를 한다. 수리 후 수리목록을 작성하여 보관한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"가전제품애프터서비스원, 가전제품A/S수리원, 가전제품에이에스수리원, 가전제품A/S원, 가전제품에이에스원, 가정용전기기구수리원","certLic":"전자기능사","dJobECd":"8322","dJobECdNm":"[8322]가전제품 설치·수리원","dJobJCd":"7612","dJobJCdNm":"[7612]가전제품 설치 및 수리원","dJobICd":"S953","dJobICdNm":"[S953]개인 및 가정용품 수리업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003760:1', '{"dJobCd":"K000003760","dJobCdSeq":"1","dJobNm":"가정용전기기구수리원","workSum":"계측기기 및 공구를 사용하여 냉장고, 선풍기, 세탁기 등의 가정용 전자·전기제품을 수리·조정한다.","doWork":"수리가 필요한 제조제품의 명세서를 접수한다. 현장 또는 수리실에서 기구에 전원을 연결하고 전력계, 전압계, 전류계 같은 부착된 기계를 통하여 결함 여부를 시험한다. 계기의 눈금과 기록계 도표를 관찰한다. 기구를 작동시키는 동안 진동, 과열, 누수와 부품의 결함을 검사한다. 기구를 분해하고 전기적 또는 기계적 부품을 검사한다. 도면에 따라 저항계를 사용하여 전기회로를 추적하고 단락 및 접지 여부를 찾아낸다. 시간조절장치 등의 눈금을 조절하여 접점을 조정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"전기기능사, 전자기능사","dJobECd":"8322","dJobECdNm":"[8322]가전제품 설치·수리원","dJobJCd":"7612","dJobJCdNm":"[7612]가전제품 설치 및 수리원","dJobICd":"C285","dJobICdNm":"[C285]가정용 기기 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001451:1', '{"dJobCd":"K000001451","dJobCdSeq":"1","dJobNm":"마스크수리원","workSum":"컬러텔레비전용 수상관에 사용되는 섀도마스크(shadow mask) 금속판의 불량품을 폐품과 수리가능품으로 선별하고 패널(panel)과 마스크를 수리·재생한다.","doWork":"작업대 위에 수리공구를 준비하고 백열등·투광대의 전원이 이상이 있는지 점검한다. 수리품과 폐품을 구분하여 폐품은 폐품함에, 수리품은 가대에 정리한다. 가대차에서 패널과 마스크를 꺼내 고무링 위에 올려놓고 마스크를 분리한다. 마스크를 투광대에서 검사하여 요철은 실버펜으로 표시한 후 수리대에서 수리망치를 사용하여 수리하고, 구멍막힘은 칫솔과 수리침으로 수리하며, 오염된 부분은 알콜램프로 가열한다. 원재료불량은 양품과 불량품으로 판정하여 반품 처리할 수 있도록 창고로 반납하고 수리 후 양품은 수리완료 표시 후 가대차에 담아 재투입하고 폐품은 보관함에 모아 버린다. 드릴의 구동상태, 버프의 마모상태, 컴파운드의 희석정도, 고무링의 청결 상태를 확인하고 패널의 내면 흠·불량을 가대에 실어 수리실로 이동한다. 가대차의 패널을 고무링 위에 올려놓고 불량부위를 검사하여 표시한다. 드릴을 사용하여 불량부위에 연마제가 골고루 묻도록 돌려가며 수평을 유지하며 연마한다. 수리부위를 검사하여 양품은 연마제를 제거하고 불량품은 재수리한다. 수리가 끝나면 패널과 마스크를 조립하여 가대차에 싣고 수리품을 다음 공정으로 운반한다. 수리실을 정리·정돈하고 일보를 작성한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"8322","dJobECdNm":"[8322]가전제품 설치·수리원","dJobJCd":"7612","dJobJCdNm":"[7612]가전제품 설치 및 수리원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2011"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004960:1', '{"dJobCd":"K000004960","dJobCdSeq":"1","dJobNm":"마스크투입원","workSum":"컬러텔레비전용 수상관에 사용되는 섀도마스크(shadow mask) 금속판의 불량품을 폐품과 수리가능품으로 선별하고 패널(panel)과 마스크를 수리·재생한다.","doWork":"작업대 위에 수리공구를 준비하고 백열등·투광대의 전원이 이상이 있는지 점검한다. 수리품과 폐품을 구분하여 폐품은 폐품함에, 수리품은 가대에 정리한다. 가대차에서 패널과 마스크를 꺼내 고무링 위에 올려놓고 마스크를 분리한다. 마스크를 투광대에서 검사하여 요철은 실버펜으로 표시한 후 수리대에서 수리망치를 사용하여 수리하고, 구멍막힘은 칫솔과 수리침으로 수리하며, 오염된 부분은 알콜램프로 가열한다. 원재료불량은 양품과 불량품으로 판정하여 반품 처리할 수 있도록 창고로 반납하고 수리 후 양품은 수리완료 표시 후 가대차에 담아 재투입하고 폐품은 보관함에 모아 버린다. 드릴의 구동상태, 버프의 마모상태, 컴파운드의 희석정도, 고무링의 청결 상태를 확인하고 패널의 내면 흠·불량을 가대에 실어 수리실로 이동한다. 가대차의 패널을 고무링 위에 올려놓고 불량부위를 검사하여 표시한다. 드릴을 사용하여 불량부위에 연마제가 골고루 묻도록 돌려가며 수평을 유지하며 연마한다. 수리부위를 검사하여 양품은 연마제를 제거하고 불량품은 재수리한다. 수리가 끝나면 패널과 마스크를 조립하여 가대차에 싣고 수리품을 다음 공정으로 운반한다. 수리실을 정리·정돈하고 일보를 작성한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"8322","dJobECdNm":"[8322]가전제품 설치·수리원","dJobJCd":"7612","dJobJCdNm":"[7612]가전제품 설치 및 수리원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2011"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007229:1', '{"dJobCd":"K000007229","dJobCdSeq":"1","dJobNm":"비디오수리원","workSum":"비디오제품 제조공정 중 생산라인의 불량부품, 잘못된 작업제품을 수리하고 원인을 점검한다.","doWork":"수리할 부품을 사전에 확보한다. 전자기기에 관한 지식을 활용하여 측정자비 및 각종 공구 등을 사용하여 부품·반제품을 수리하고 원인을 피드백(feedback)시킨다. 수리일보를 작성하고 조정 및 검사의 판별불가항목을 결정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"VTR수리원","dJobECd":"8322","dJobECdNm":"[8322]가전제품 설치·수리원","dJobJCd":"7612","dJobJCdNm":"[7612]가전제품 설치 및 수리원","dJobICd":"C265","dJobICdNm":"[C265]영상 및 음향기기 제조업","inqYear":"2011"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006763:1', '{"dJobCd":"K000006763","dJobCdSeq":"1","dJobNm":"비디오테이프검사원","workSum":"복사된 가정용 비디오테이프의 화질이 이상이 있는지 비디오테이프를 녹화하는 비디오테이프녹화기조작원을 보조한다.","doWork":"녹화할 녹화재생기에 공 비디오테이프를 비디오테이프녹화기조작원의 지시에 따라 삽입하고 완성된비디오테이프를 꺼낸다. 녹화된 비디오테이프의 화질 및 이상 유무를 검사하기 위하여 녹화검사기에 일정 수량씩 삽입한다. 리모콘을 작동하여 모니터를 관찰하며 미세조정상태(treaking)나 화질에 불량이 있는지 점검한다. 되감기 버튼을 눌러가며 중간 부분의 화면상태를 점검한다. 검사된 테이프를 녹화검사기로부터 소거하여지정된 장소에 적재한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"분석","workFunc2":"감독","workFunc3":"수동조작","dJobECd":"8322","dJobECdNm":"[8322]가전제품 설치·수리원","dJobJCd":"7612","dJobJCdNm":"[7612]가전제품 설치 및 수리원","dJobICd":"C182","dJobICdNm":"[C182]기록매체 복제업","inqYear":"2011"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007169:1', '{"dJobCd":"K000007169","dJobCdSeq":"1","dJobNm":"텔레비전수리원","workSum":"계측기기·오실로스코프·테스터기 등 기기와 공구를 사용하여 완성된 제품이나 조립된 반제품의 작업불량이나 성능불량을 수리한다","doWork":"오실로스코프·테스터기 등을 사용하여 영상·음향 등이 규정된 수준에 있는지 검사하고 잘못된 부속품이나 배선에 관하여 찾아낸다. 전동드라이버·인두 등을 사용하여 결함이 있는 부품을 교체한다. 이완된 접속부분을 땜질하고 주변을 소제한다. 작업원들에게 불량내용 및 특성에 대하여 교육한다. 수리한 내용 및 불량요인분석 내용을 기록·정리하고 자료를 집계하여 관련 부서에 통보한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"TV수리원","dJobECd":"8322","dJobECdNm":"[8322]가전제품 설치·수리원","dJobJCd":"7612","dJobJCdNm":"[7612]가전제품 설치 및 수리원","dJobICd":"C265","dJobICdNm":"[C265]영상 및 음향기기 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006582:1', '{"dJobCd":"K000006582","dJobCdSeq":"1","dJobNm":"감시용카메라수리원","workSum":"제작된 감시용카메라를 테스터기·오실로스코프 등의 계측기기를 사용하여 검사한다.","doWork":"케이스의 이상 유무를 확인하고 제작된 인쇄회로기판을 검사 지그에 삽입한다. 오실로스코프·패턴지그·테스터기 등을 사용하여 인쇄회로기판을 검사하고 잘못된 부분을 수리한다. 카메라에 촬상관을 꼽고 검사된 인쇄회로기판을 케이스에 부착한다. 카메라에 렌즈를 부착하고 모니터를 관찰하여 기능이 정상인지 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"CCTV수리원","certLic":"전자기능사","dJobECd":"8329","dJobECdNm":"[8329]기타 전기·전자 기기 설치·수리원","dJobJCd":"7619","dJobJCdNm":"[7619]기타 전기·전자기기 설치 및 수리원","dJobICd":"C264","dJobICdNm":"[C264]통신 및 방송 장비 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003237:1', '{"dJobCd":"K000003237","dJobCdSeq":"1","dJobNm":"감시용카메라조정원","workSum":"제작된 감시용카메라를 각종 계측기기를 사용하여 전기적 특성과 기계적 특성을 조정하고 검사한다.","doWork":"카메라렌즈를 지정된 위치로 고정시키고 카메라를 지그에 고정시킨다. 플러그를 콘센트 및 콘넥터에 끼운다. 인쇄회로기판의 수평주파수를 주파수 카운터기를 사용하여 일정 수준으로 맞춘다. 모니터를 관찰하며 화면 좌우상하의 중심을 조정한다. 카메라요크(렌즈 개방에 의한 휘도, 선명도, 색을 조절)로 인한 잔상의 유무를 관찰한다. 사물이 잘 보이도록 거리 및 초점을 맞춘다. 카메라의 잔상을 관찰하고 재조정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"CCTV조정원","certLic":"전자기능사","dJobECd":"8329","dJobECdNm":"[8329]기타 전기·전자 기기 설치·수리원","dJobJCd":"7619","dJobJCdNm":"[7619]기타 전기·전자기기 설치 및 수리원","dJobICd":"C264","dJobICdNm":"[C264]통신 및 방송 장비 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002021:1', '{"dJobCd":"K000002021","dJobCdSeq":"1","dJobNm":"건전지충전원","workSum":"광산에서 광물이나 자재를 운반하는 축전차 및 개인휴대용 전등의 건전지에 증류수를 채우고 전원에 연결하여 충전시켜 성능시험을 한다.","doWork":"축전차를 충전실로 이동시켜 건전지를 해체한다. 건전지에 일정량 증류수를 보충한다. 전원을 건전지에 연결하고 일정 시간 충전한다. 건전지의 충전상태를 파악하기 위하여 성능시험을 한다. 축전차에 건전지를 조립한다. 충전일지를 작성한다. 작업 후 수거된 개인휴대용 전등이 정상적으로 작동되도록 재충전된 건전지로 교환한다. 건전지를 점검·보수하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"광산전공원, 밧데리충전원","dJobECd":"8329","dJobECdNm":"[8329]기타 전기·전자 기기 설치·수리원","dJobJCd":"7619","dJobJCdNm":"[7619]기타 전기·전자기기 설치 및 수리원","dJobICd":"B051/B061/B062","dJobICdNm":"[B051]석탄 광업 / [B061]철 광업 / [B062]비철금속 광업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002252:1', '{"dJobCd":"K000002252","dJobCdSeq":"1","dJobNm":"계측기기수리원","workSum":"각종 계측기기, 설비, 작업도구를 사용하여 계측기기와 관련된 장치를 소제·수선·조정한다.","doWork":"작업표준에 따라 수리에 필요한 납땜기, 전동드릴 등 수동공구 및 전동공구를 준비하고 작동 여부를 점검하여 작업대에 로딩한다. 고객 또는 생산라인에서 의뢰된 계측기기를 수령하고 작업명세서의 수리내역을 확인한 후 PC보드시험기 등 각종 계측기기 및 설비를 사용하거나 회로도를 이용하여 문제점을 확인한다. 문제의 원인에 따라 계측기기의 구성부품을 분해하고 구성부품에 따라 납땜, 부품교체, 배선 등의 업무를 수행한다. 수리공정을 통하여 문제점이 해결된 제품은 재검사 및 재조정을 통해 확인하여 고객 또는 생산라인에 돌려보낸다. 계측기기 수리 관련 사항의 보고서를 작성하고 도구 및 장비를 정리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"계측기유지보수원, 계측기기보수원, 계측기구수리원, 계측기구보수원","certLic":"전기기능사, 전자기능사","dJobECd":"8329","dJobECdNm":"[8329]기타 전기·전자 기기 설치·수리원","dJobJCd":"7619","dJobJCdNm":"[7619]기타 전기·전자기기 설치 및 수리원","dJobICd":"C272","dJobICdNm":"[C272]측정, 시험, 항해, 제어 및 기타 정밀기기 제조업; 광학기기 제외","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003945:1', '{"dJobCd":"K000003945","dJobCdSeq":"1","dJobNm":"광학기기수리원","workSum":"수리를 의뢰한 광학기기의 상태를 분석하고 부품의 교체 또는 수리 업무를 수행한다.","doWork":"소비자로부터 수리를 의뢰받는다. 의뢰받은 생물현미경, 사진촬영장치, 화상분석장치, 망원경 등의 작동상태를 파악한다. 각종 카메라 및 렌즈, 어댑터 등의 손상 및 파손을 살피고, 교체가 필요할 시 소비자에게 알리고 교체한다. 각종 광학시스템의 구성을 숙지하고 표준값과의 오차를 확인한다. 부품 및 렌즈, 전구, 방열장치 등의 오염 여부를 확인하고 분해 시 소제 후 재조립한다. 조립 후 각종 입·출력신호를 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"광학기구수리원, 광학용품수리원","connectJob":"대상에 따라 정밀렌즈수리원, 쌍안경수리원, 망원경수리원, 천체망원경수리원, 현미경수리원","certLic":"광학기기산업기사, 광학기사","dJobECd":"8329","dJobECdNm":"[8329]기타 전기·전자 기기 설치·수리원","dJobJCd":"7619","dJobJCdNm":"[7619]기타 전기·전자기기 설치 및 수리원","dJobICd":"S953","dJobICdNm":"[S953]개인 및 가정용품 수리업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004230:1', '{"dJobCd":"K000004230","dJobCdSeq":"1","dJobNm":"광학용품제조현장감독자","workSum":"안경·콘택트렌즈·현미경·환등기 등 광학용품을 제조하고 검사하는데 종사하는 작업원들의 활동을 감독·조정한다.","doWork":"광학용품 제조공정, 광학용품 부품, 광학용품 성능 및 기능 등의 광학용품 전반에 관한 지식과 내용을 파악·숙지한다. 각 생산공정을 관리·감독하며 기술을 지원한다. 품질향상을 위하여 작업원들을 감독·점검한다. 광학용품제조에 사용되는 설비의 일상점검, 조정확인과 관리를 한다. 수시로 가동률을 점검한다. 작업표준서 및 작업 체크표를 작성한다. 작업원들에게 안전교육을 실시한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","connectJob":"광학용품조립반장, 광학용품수리반장, 광학용품검사반장, 광학용품제조반장","certLic":"광학기능사, 광학기기산업기사","dJobECd":"8329","dJobECdNm":"[8329]기타 전기·전자 기기 설치·수리원","dJobJCd":"7619","dJobJCdNm":"[7619]기타 전기·전자기기 설치 및 수리원","dJobICd":"C273","dJobICdNm":"[C273]사진장비 및 광학기기 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007315:1', '{"dJobCd":"K000007315","dJobCdSeq":"1","dJobNm":"도시철도신호제어설비유지보수원","workSum":"도시철도 열차 운행 관련 차량과 연관된 운행 설비 등 유지보수 등의 업무를 수행한다.","doWork":"열차의 진행, 정지, 속도 및 진로 등을 제어하는 신호제어설비인 선로전환기, 연동장치, 궤도회로, 열자집중제어장치 등 정기점검 및 유지보수, 고장장애 시 조치 및 안전대책 수립, 고장장애 시 조치 및 안전대책 수립, 고장장애이력 등 데이터 분석 및 이력관리 등의 업무를 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"철도신호기사, 철도신호산업기사","dJobECd":"8329","dJobECdNm":"[8329]기타 전기·전자 기기 설치·수리원","dJobJCd":"7619","dJobJCdNm":"[7619]기타 전기·전자기기 설치 및 수리원","dJobICd":"H492","dJobICdNm":"[H492]육상 여객 운송업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005522:1', '{"dJobCd":"K000005522","dJobCdSeq":"1","dJobNm":"드론수리원","workSum":"의뢰받은 고장난 드론을 점검하고 파손부위를 수리한다.","doWork":"의뢰받은 드론 또는 조종기구의 상태를 점검하고 수리할 부분을 확인한다. 드론의 연결장치를 포함한 구조물을 점검하고 모터, 엔진, 프로펠러, 로터 등 추진 계통을 점검하고 수리한다. 통신, 항법 장비, 안테나, 전송기 간의 전자계통을 점검하고 고장부위를 수리한다. 배터리, 변속기 등을 점검하고 고장부위를 수리한다. 프로그램을 이용하여 작동상태를 점검하고 테스트 비행을 통해 최종 상태를 점검한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"드론정비원, 드론정비사, 드론수리전문가","dJobECd":"8329","dJobECdNm":"[8329]기타 전기·전자 기기 설치·수리원","dJobJCd":"7619","dJobJCdNm":"[7619]기타 전기·전자기기 설치 및 수리원","dJobICd":"C340","dJobICdNm":"[C340]산업용 기계 및 장비 수리업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004643:1', '{"dJobCd":"K000004643","dJobCdSeq":"1","dJobNm":"발전용연료전지유지보수원","workSum":"발전용연료전지시스템이 안정적으로 작동할 수 있도록 주기적인 점검과 유지보수 작업을 수행한다.","doWork":"연료전지 시스템의 안정적 운영을 위해 정기적인 점검과 유지보수 작업을 한다. 기계적·전기적 고장을 진단하고 신속하게 수리한다. 주요 장비의 성능을 관리하고 부품 교체를 통해 성능 저하를 예방하고, 안전 점검을 시행하여 사고를 방지한다. 예방적 유지보수 계획을 수립해 발전소의 지속적이고 효율적인 운영을 지원한다. 작업 내역과 성능 데이터를 기록하여 보고한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실외","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"8329","dJobECdNm":"[8329]기타 전기·전자 기기 설치·수리원","dJobJCd":"7619","dJobJCdNm":"[7619]기타 전기·전자기기 설치 및 수리원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001439:1', '{"dJobCd":"K000001439","dJobCdSeq":"1","dJobNm":"사진기수리원","workSum":"설계도 또는 작업명세서에 따라 수동공구, 자동공구, 계측기기, 납땜기를 사용하여 사진기 및 사진 관련 장비를 수리한다.","doWork":"조립공정 또는 검사공정 중 발생한 사진기의 고장부분과 고장원인을 수리명세서를 보고 원인을 파악한다. 관련 부품과 장비를 이용하여 수리하고 해당 부품을 교환한다. 디지털 이미지 센서, 미러결함, LCD패널 결함, PCB(인쇄회로기판)결함 등을 각종 수동공구, 자동공구, 계측기기, 납땜기 등을 사용하여 수리한다. 수리된 사진기를 다시 조립공정 라인 또는 검사공정에 전달한다. 일일수리내역을 기록하여 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"카메라수리원","connectJob":"대상에 따라 아날로그카메라수리원, 디지털카메라수리원","dJobECd":"8329","dJobECdNm":"[8329]기타 전기·전자 기기 설치·수리원","dJobJCd":"7619","dJobJCdNm":"[7619]기타 전기·전자기기 설치 및 수리원","dJobICd":"C273","dJobICdNm":"[C273]사진장비 및 광학기기 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002980:1', '{"dJobCd":"K000002980","dJobCdSeq":"1","dJobNm":"시계수리원","workSum":"시계제조용 공구·측정기구·소제기구를 사용하여 각종 시계와 관련 기계장치를 소제·수선·조정한다.","doWork":"소비자로부터 수리의뢰를 접수한다. 시계의 파손상태에 따라 수리시간 및 수리비용을 산출하여 소비자에게 알린다. 조립공정 또는 판매된 제품 중 수리가 필요한 제품에 대한 요청서를 받은 후 수리할 부분을 확인하거나 수리할 부분을 찾기 위하여 시계를 분해한다. 확대경(Loupe)을 사용하여 무브먼트(Movement)의 이물질 존재 여부를 확인한다. 고장상태에 따라 드라이버, 핀셋 등을 사용하여 무브먼트 내의 부품을 분해한다. 측정기를 사용하여 부품의 상태를 확인하고 상태에 따라 부품을 소제·조정·교체한다. 시계상태에 따라 케이스 등을 초음파 세척하거나 밴드, 용두 등의 파손된 부품을 교체한다. 유리, 뒤 뚜껑부위, 용두부위 등의 상태를 점검하고 각종 패킹, 링 등을 교환하거나 방수 처리한다. 조립을 완료한 후 시계의 작동상태를 점검한다. 작업 중 도금이나 수리원이 직접 해결할 수 없는 부분은 박스에 담아 관련 부서에 인계한다. 판매 또는 수리한 제품에 대해 보증업무를 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"시계수리공","connectJob":"대상에 따라 손목시계수리원, 탁상시계수리원, 괘종시계수리원","dJobECd":"8329","dJobECdNm":"[8329]기타 전기·전자 기기 설치·수리원","dJobJCd":"7619","dJobJCdNm":"[7619]기타 전기·전자기기 설치 및 수리원","dJobICd":"S953","dJobICdNm":"[S953]개인 및 가정용품 수리업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006802:1', '{"dJobCd":"K000006802","dJobCdSeq":"1","dJobNm":"시티비전유지보수원","workSum":"시티비전의 수리 및 유지 보수를 담당한다.","doWork":"시티비전에 대한 정기점검을 실시하고 결함 발생 시 장해 요인을 수리한다. 폭우와 낙뢰 등으로 인한 피해사항이 많으므로 폭우와 낙뢰 발생 시 자주 피해요인을 검사한다. 시티비전은 셀로 구성되어 셀로 인한 고장 요인이 많으므로 셀의 고장 유무를 수시로 검사한다. 정기적으로 광고 표출현황을 사진기로 촬영하여 보고서로 제출한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실외","physicalAct":"균형감각|","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"유지","dJobECd":"8329","dJobECdNm":"[8329]기타 전기·전자 기기 설치·수리원","dJobJCd":"7619","dJobJCdNm":"[7619]기타 전기·전자기기 설치 및 수리원","dJobICd":"C340","dJobICdNm":"[C340]산업용 기계 및 장비 수리업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002625:1', '{"dJobCd":"K000002625","dJobCdSeq":"1","dJobNm":"안전등관리원","workSum":"갱내 작업원들의 휴대용 조명기구인 안전등을 보수·유지·관리한다.","doWork":"갱내 작업원들이 입갱할 때 안전등을 대출하고 퇴갱 시 반납받는다. 안전등의 대출 및 반납사항을 관리일지에 기록한다. 안전등을 충전시키고 충전상태를 확인한다. 고장난 안전등을 테스터를 이용하여 검사하고 고장원인을 파악한다. 약품을 혼합하고 비중계로 비중을 측정하여 축전지액을 조제한다. 비중액을 축전지에 주입한다. 낡은 전구 및 단선이나 단락된 코드를 교체한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","connectJob":"안전등수리원","dJobECd":"8329","dJobECdNm":"[8329]기타 전기·전자 기기 설치·수리원","dJobJCd":"7619","dJobJCdNm":"[7619]기타 전기·전자기기 설치 및 수리원","dJobICd":"B051/B061/B062","dJobICdNm":"[B051]석탄 광업 / [B061]철 광업 / [B062]비철금속 광업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007212:1', '{"dJobCd":"K000007212","dJobCdSeq":"1","dJobNm":"음향기기수리원","workSum":"각종 계측기기와 공구를 사용하여 완성된 제품이나 조립된 반제품의 작업 및 성능 불량을 수리한다.","doWork":"음향기기의 손상된 부속품, 풀렸거나 절단된 연결부위 및 배선을 검사한다. 결함이 파악된 콘덴서·저항기·발진기 등 부품을 전동드라이버·인두 등을 사용하여 교체한다. 접속부분이 불량한 경우에는 납땜작업을 한다. 각종 계측장비와 측정장비를 사용하여 전력, 출력, 잡음수준, 음향의 질 등을 검사한다. 조립원들에게 불량내용에 대하여 교육하고 동일한 불량이 발생되지 않도록 작업 시 주의사항을 알려준다. 수리한 내용 및 불량요인 분석내용을 기록·정리하고 관련 부서에 알려준다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"오디오수리원","connectJob":"카세트수리원, 오디오수리원, CDP수리원, DVD수리원, MP3수리원","dJobECd":"8329","dJobECdNm":"[8329]기타 전기·전자 기기 설치·수리원","dJobJCd":"7619","dJobJCdNm":"[7619]기타 전기·전자기기 설치 및 수리원","dJobICd":"C265","dJobICdNm":"[C265]영상 및 음향기기 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005503:1', '{"dJobCd":"K000005503","dJobCdSeq":"1","dJobNm":"전기계량기관리원","workSum":"신규신청 이후 설치된 수용가(소비자)의 계량기에 대한 유지·보수 및 관리하는 업무를 수행한다.","doWork":"계량기 고장에 대한 수용가(소비자)의 민원사항을 처리하기 위하여 계량기의 이상점검을 실시한 후 수리 및 교체 여부를 판단하여 교체 또는 수리한다. 위약방지를 위하여 봉인이 누락된 계량기는 봉인조치 한다. 통상 사용량을 초과하는 계량기를 점검하여 이상 유무를 확인하고 정상적인 작동이 되도록 유지·관리한다. 교체계량기에 대한 시험·점검하고 계량기 관리를 한다. 검침상 나타난 이상원인을 PDA(핸드터미널)에 입력한 후 주전산기로 전송하여 고장원인에 대한 자료를 전산화하여 체계적으로 관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"전력량계관리원, 적산전력계관리원","dJobECd":"8329","dJobECdNm":"[8329]기타 전기·전자 기기 설치·수리원","dJobJCd":"7619","dJobJCdNm":"[7619]기타 전기·전자기기 설치 및 수리원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005437:1', '{"dJobCd":"K000005437","dJobCdSeq":"1","dJobNm":"전기기구수리원","workSum":"계측기기 및 공구를 사용하여 각종 전기기구를 수리 및 조립한다.","doWork":"수리가 필요한 제조제품의 명세서를 접수하고 현장 또는 수리실에서 기구에 전원을 연결하여 전력계, 전압계, 전류계 같은 부착된 기계를 통하여 결함 여부를 시험한다. 기구를 작동시키는 동안 지나친 진동, 과열, 누수와 부품의 결함에 대해 검사를 하여, 결함 시 기구를 분해하고 전기적 또는 기계적 부품을 검사한다. 도면에 따라 저항계를 사용하여 전기회로를 추적하고 단락 및 접지 여부를 찾아낸다. 세척제를 사용하여 부품을 세척하고 탄소찌꺼기, 기름, 먼지를 제거한다. 마모되거나 결함이 있는 부품과 배선을 교체한다. 각종 공구를 사용하여 기구를 재조립하고 성능검사를 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8329","dJobECdNm":"[8329]기타 전기·전자 기기 설치·수리원","dJobJCd":"7619","dJobJCdNm":"[7619]기타 전기·전자기기 설치 및 수리원","dJobICd":"C340","dJobICdNm":"[C340]산업용 기계 및 장비 수리업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003007:1', '{"dJobCd":"K000003007","dJobCdSeq":"1","dJobNm":"전기장비수리원","workSum":"제조공정 상에 발생한 불량품이나 소비자에 의해 수리를 요구받은 제품의 이상 원인을 찾아내어 수리하고 점검한다.","doWork":"작업표준에 따라 수리할 제품의 명세서를 확인·검토한다. 용접기, 트렌치 등 작업에 필요한 장비와 작업공구를 준비한다. 현장 또는 수리실에서 장비에 전원을 연결하고 종합테스트기 및 전력계, 전압계, 전류계 등으로 시험한다. 장비를 분해하고 전기적 또는 기계적 부품을 검사한다. 결함이 있는 부품을 교체하거나 수리한다. 장비를 작동하여 이상이 없는지를 검사한다. 알코올이나 솔벤트(다른 물질을 용해시키기 위해 사용하는 액체나 가스) 등을 이용하여 부품을 세척하며, 필요한 부분의 기름이나 절연재를 교체한다. 수리부분 및 교체부분을 기록하여 남긴다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"전기기능사","dJobECd":"8329","dJobECdNm":"[8329]기타 전기·전자 기기 설치·수리원","dJobJCd":"7619","dJobJCdNm":"[7619]기타 전기·전자기기 설치 및 수리원","dJobICd":"C281","dJobICdNm":"[C281]전동기, 발전기 및 전기 변환ㆍ 공급ㆍ제어 장치 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007681:1', '{"dJobCd":"K000007681","dJobCdSeq":"1","dJobNm":"전기차충전기설치원","workSum":"관련 규정과 설치・이용 환경을 검토하여 전기자동차 충전시설을 설치하고 충전동작 및 결제 여부 등을 테스트한다.","doWork":"전기자동차의 충전시설 설치 규정에 따라 전기적 안전과 장소의 안전, 사용자의 안전을 담보할 수 있도록 환경을 고려하여 설치한다. 설치 이후 전기차 충전기의 동작을 충전카드, 전기차 충전앱, 등의 기타 인증수단을 이용하여 확인한다. 통신망(유선, 무선)을 통한 운영관리 시스템과의 연계 상태를 확인한다. 전기자동차 또는 검증 테스트 장비로 충전 동작을 확인하고 충전되는 전력량 등을 확인, 검증한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|손사용|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"전기기사, 전기산업기사, 전기기능사, 전기공사기사, 전기공사산업기사","dJobECd":"8329","dJobECdNm":"[8329]기타 전기·전자 기기 설치·수리원","dJobJCd":"7619","dJobJCdNm":"[7619]기타 전기·전자기기 설치 및 수리원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2025"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007682:1', '{"dJobCd":"K000007682","dJobCdSeq":"1","dJobNm":"전기차충전기정비원","workSum":"전기차 충전기의 원활한 작동을 위해 충전기 시스템 업데이트 및 고장 시 수리·교체 및 유지관리를 한다.","doWork":"충전기 설계도를 검토한다. 충전기 수리작업에 따른 안전수칙과 수리방법 및 절차를 숙지한다. 충전기 작동여부를 점검한다. 충전기 고장원인과 부품을 찾고 신품과 교체하거나 수리절차에 따라 문제를 해결한다. 수리 후 충전기 정상작동 여부를 확인한다. 충전기 그밖에 전기차 충전기 및 충전시설에 관련한 기술지원 업무를 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|손사용|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"전기차충전기AS원","connectJob":"전기차충전시설현장점검원","certLic":"전기기사, 전기산업기사, 전기기능사","dJobECd":"8329","dJobECdNm":"[8329]기타 전기·전자 기기 설치·수리원","dJobJCd":"7619","dJobJCdNm":"[7619]기타 전기·전자기기 설치 및 수리원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2025"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007683:1', '{"dJobCd":"K000007683","dJobCdSeq":"1","dJobNm":"전기차충전기현장점검원","workSum":"전기차 충전기의 원활한 작동을 위해 정기, 수시, 긴급 점검을 하고 충전기 및 충전시설을 유지 관리한다.","doWork":"전기차 충전기의 원활한 사용을 위해 정기적으로 충전기의 동작상태와 주변환경을 점검한다. 전기차 충전기 문제 발생 접수 시 현장에 출동하여 충전기를 점검한다. 전기적 안전을 확인하고 충전기의 기구적 상태 등을 사전 확인한다. 충전 중 발생할 수 있는 충전기의 비정상적 동작을 점검한다. 충전기 및 전기공급 설비 고장 시 수리를 요청을 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|손사용|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"전기기사, 전기산업기사, 전기기능사","dJobECd":"8329","dJobECdNm":"[8329]기타 전기·전자 기기 설치·수리원","dJobJCd":"7619","dJobJCdNm":"[7619]기타 전기·전자기기 설치 및 수리원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2025"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006321:1', '{"dJobCd":"K000006321","dJobCdSeq":"1","dJobNm":"전자의료장비수리원","workSum":"전동공구 및 수동공구, 각종 계측기기, 음파검사기기를 이용하여 X-ray, 초음파진단기기, PET-CT MRI 장비 등 전자의료장비를 검사·수리한다.","doWork":"생산공정 단계 및 출하 후에 발생한 의료장비 고장을 각종 검사계측기기가 포함되어 있는 검사시스템을 사용하여 회로기판, 부품의 단락, 잘못된 연결, 방사선조사량, 초음파출력 등 수리해야 할 부분을 찾아낸다. 수리항목에 따라 의료장비를 분해하고 단락부분은 수공구 또는 손으로 재연결하고 납땜기를 사용하여 납땜한다. 수리부분에 따라 문제가 있는 부분에 대해서는 관련 부분의 PCB기판 등 부품을 교체한다. 수선이 마무리되면 재조립하고 재검사를 통해 수리부분의 이상 유무를 재평가한다. 영상의학장비의 경우 수리 후 병원전산망과의 연결 및 영상의 이상 유무 또한 팬텀 촬영 등을 통하여 재평가한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"의료장비수리원, 의료기기수리원","connectJob":"기기의 종류에 따라 초음파기기수리원, 뇌파기(EEG)수리원, 심전도기(EKG)수리원, 마취기수리원, 심장세동제거기수리원, 투석기수리원, MRI수리원, CT스캐너수리원, X-ray수리원","certLic":"의공산업기사, 의공기사","dJobECd":"8329","dJobECdNm":"[8329]기타 전기·전자 기기 설치·수리원","dJobJCd":"7619","dJobJCdNm":"[7619]기타 전기·전자기기 설치 및 수리원","dJobICd":"C271","dJobICdNm":"[C271]의료용 기기 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006426:1', '{"dJobCd":"K000006426","dJobCdSeq":"1","dJobNm":"정밀기기수리원","workSum":"자동화 시스템, 통신 시스템 등의 정밀제어기기나 시스템을 정비하고 통신흐름을 원활히 유지하도록 정기적으로 보수한다.","doWork":"판매한 정밀기기나 자동화 시스템, 통신 시스템의 정기적인 체크리스트를 작성한다. 작성한 체크리스트와 비교하여 이상이 발생할 시 전기회로도나 부품의 이상 유무를 정밀테스터기를 이용하여 파형을 점검하거나 통전상태를 확인한다. 제품의 이상에 따른 부품 교체작업을 실시하고 제어기판을 교환한다. 수리작업 후 절연시험과 작동 테스트를 실시하고 오차범위를 넘지 않도록 재조정한다. 점검 및 수리 후 수리목록을 작성하고 단순부품결함, 전원의 안정성 여부, 사용자의 운전 미숙 등의 원인을 검토하여 동일 고장 발생을 방지한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"정밀측정기능사","dJobECd":"8329","dJobECdNm":"[8329]기타 전기·전자 기기 설치·수리원","dJobJCd":"7619","dJobJCdNm":"[7619]기타 전기·전자기기 설치 및 수리원","dJobICd":"C340","dJobICdNm":"[C340]산업용 기계 및 장비 수리업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003943:1', '{"dJobCd":"K000003943","dJobCdSeq":"1","dJobNm":"지능형전력기기설비원","workSum":"인홈디스플레이(IHD:In Home Display) 장치와 스마트미터 등 스마트그리드(Smart Grid)에 사용되는 지능형전력기기를 설치하고 유지·보수한다.","doWork":"스마트미터(시간대별 사용량 측정을 통해 그 정보를 송신할 수 있는 기능을 갖추어 시간대별 요금을 알 수 있는 전자식 전력량계)를 설치한다. 전력 사용량 실시간 체크와 전력공급자와 사용자 간 양방향 통신이 가능하도록 통신망을 연결한다. 기기의 초기값을 설정하여 LCD 디스플레이를 통해 원하는 기능이 제대로 작동되는지 확인한다. 전력사용량에 대한 민원이 있을 시에는 가정을 방문하여 스마트미터를 점검하고 필요시 보수하거나 교체한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"8329","dJobECdNm":"[8329]기타 전기·전자 기기 설치·수리원","dJobJCd":"7619","dJobJCdNm":"[7619]기타 전기·전자기기 설치 및 수리원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003203:1', '{"dJobCd":"K000003203","dJobCdSeq":"1","dJobNm":"지하철승강장안전문설치원","workSum":"승객의 선로추락 및 투신, 열차의 접촉을 방지하기 위하여 승강장 환경과 제어방식에 따라 스크린도어를 설치한다.","doWork":"설치환경 및 설계조건을 고려하여 승강장 안전문(PSD:Platform Screen Door,스크린도어)의 설치공법을 협의한다. 모듈 방식의 경우 구조체 전체를 미리 제작하여 설치하고, 조립 방식의 경우 부품 상태로 가져와서 현장에서 조립한다. 승강장의 차량한계, 건축한계 및 열차의 정위치를 고려하여 승강장 안전문의 설치위치를 선정한다. 모듈방식의 경우 선정된 설치위치에 모듈설치 전용장비를 이용하여 미리 제작된 구조체 전체를 설치한다. 조립방식의 경우 수직빔을 설치한 후 헤더박스(구동부 포함), 각종 도어류, 센서 등 승강장 안전문의 구성요소들을 순차적으로 설치한다. 수직빔, 헤더박스 등 중량물 작업 시는 크레인, 리프트 등을 이용하여 안전하게 수행한다. 구조체의 설치가 완료되면 구조체의 수직도, 수평도 등 설치상태를 확인한다. 기본적인 설치 상태가 확인되면 각 가동도어 및 비상도어의 열림/닫힘 동작을 확인하고 필요시 조정작업을 실시한다. 구조체 및 새시 설치가 완료되면 전원, 제어 관련 배관·배선 및 각종 제어반, 조작반을 설치한다. 이후 협의된 절차에 따라 시운전을 진행한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|손사용|","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"지하철스크린도어설치원","dJobECd":"8329","dJobECdNm":"[8329]기타 전기·전자 기기 설치·수리원","dJobJCd":"7619","dJobJCdNm":"[7619]기타 전기·전자기기 설치 및 수리원","dJobICd":"F422","dJobICdNm":"[F422]건물설비 설치 공사업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003920:1', '{"dJobCd":"K000003920","dJobCdSeq":"1","dJobNm":"지하철승강장안전문정비원","workSum":"승강장 이용승객의 안전과 승강장 환경개선 및 에너지 절감을 위해 설치된 스크린도어와 부속 전기·및 통신장비를 유지, 관리하고 보수한다.","doWork":"승강장 안전문(PSD:Platform Screen Door, 스크린도어)이 열차의 선로 진입에 맞춰 원활하게 개폐되는지 유지보수전산기를 통해 담당 역사들을 모니터링한다. 주·야간 점검 시 스크린도어와 관련된 현장 시설물들을 관리한다. 고장 발생 시 로그분석을 통해 스크린도어 동작 이력을 확인하고 원인을 파악한다. 작업 공구를 사용하여 도어 구동부, 장애물센서, 제어반 등의 구성 부품을 수리한다. 풍압이나 파손에 의해 안전문에 이상이 생겼을 경우 도어새시, 강화유리 등을 교체한다. 필요시 외부에 정비나 수리를 요청하기도 한다. 현장 점검 및 정비 후 일지를 작성한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|손사용|","workEnv":"대기환경미흡|위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"지하철스크린도어정비원","certLic":"전기기사, 전파전자통신기사, 전기공사기사, 전기기능사","dJobECd":"8329","dJobECdNm":"[8329]기타 전기·전자 기기 설치·수리원","dJobJCd":"7619","dJobJCdNm":"[7619]기타 전기·전자기기 설치 및 수리원","dJobICd":"H492","dJobICdNm":"[H492]육상 여객 운송업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004639:1', '{"dJobCd":"K000004639","dJobCdSeq":"1","dJobNm":"집광채광시스템설치원","workSum":"광덕트를 설치하고 집광기와 산광기를 조립하여 집광채광시스템을 설치한다.","doWork":"시방서에 따라 건축물의 타공부 등에 광덕트를 설치하고 접합부분은 용접을 통해 고정한다. 집광기를 설치하고 위치와 각도를 확인하여 태양광을 충분히 받을 수 있도록 조정한다. 실내에 빛을 확산시키는 산광기를 설치하고, 필요에 따라 산광기의 빛을 차단할 수 있는 광댐퍼나 실내조명과 광댐퍼를 연동시킨 제어시스템을 설치한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"균형감각|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"8329","dJobECdNm":"[8329]기타 전기·전자 기기 설치·수리원","dJobJCd":"7619","dJobJCdNm":"[7619]기타 전기·전자기기 설치 및 수리원","dJobICd":"F422","dJobICdNm":"[F422]건물설비 설치 공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004355:1', '{"dJobCd":"K000004355","dJobCdSeq":"1","dJobNm":"철도신호설비기술원","workSum":"철도의 신호보안장치 운영을 위하여 신호 관련 장치를 유지·보수한다.","doWork":"열차의 출발가부를 현시하는 신호기장치, 열차의 운행방향을 변경하는 선로전환장치, 열차의 검지 및 속도제어를 위한 궤도회로장치, 열차의 자동정지 및 운전기능을 지원하는 열차자동정지장치(ATS:Automatic Train Stopper), 열차자동운행장치(ATO:Automatic Train Operation) 등을 유지·보수한다. 노후설비에 대한 교체 및 보강공사를 설계·감독하여 장애를 예방한다. 신호설비 안전점검 계획을 수립하고, 점검 결과를 분석·관리한다. 모터카의 부품을 조달·분배하고 운행실적, 구간, 주행거리에 대한 자료를 종합하여 정리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"철도신호설비기술원","certLic":"철도신호산업기사","dJobECd":"8329","dJobECdNm":"[8329]기타 전기·전자 기기 설치·수리원","dJobJCd":"7619","dJobJCdNm":"[7619]기타 전기·전자기기 설치 및 수리원","dJobICd":"H491","dJobICdNm":"[H491]철도 운송업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005285:1', '{"dJobCd":"K000005285","dJobCdSeq":"1","dJobNm":"철도신호제어설비유지보수원","workSum":"신호제어시설의 운용·조작·성능시험, 검사, 유지·보수 등을 수행한다.","doWork":"열차의 진행, 정지, 속도 및 진로 등을 제어하는 신호제어설비, 선로전환기, 연동장치, 궤도회로, 열차집중제어장치 등을 정기적으로 점검하고 유지·보수한다. 고장장애 시 조치 및 안전대책을 수립한다. 고장장애이력 등 데이터분석, 이력관리 등의 업무를 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"철도신호산업기사","dJobECd":"8329","dJobECdNm":"[8329]기타 전기·전자 기기 설치·수리원","dJobJCd":"7619","dJobJCdNm":"[7619]기타 전기·전자기기 설치 및 수리원","dJobICd":"H491","dJobICdNm":"[H491]철도 운송업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006350:1', '{"dJobCd":"K000006350","dJobCdSeq":"1","dJobNm":"카오디오인스톨러","workSum":"차량용 오디오를 설치한다.","doWork":"고객의 요구에 적합한 오디오기기를 추천하고, 최종 선택을 돕는다. 자동차 제조사에서 생산되어 나온 완성 차량에 장착된 본래의 오디오시스템을 차량에서 제거한다. 애프터마켓용 오디오기기를 설치한다. 설치한 오디오기기가 최상의 소리를 낼 수 있도록 조정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"카오디오설치기사","dJobECd":"8329","dJobECdNm":"[8329]기타 전기·전자 기기 설치·수리원","dJobJCd":"7619","dJobJCdNm":"[7619]기타 전기·전자기기 설치 및 수리원","dJobICd":"S952","dJobICdNm":"[S952]자동차 및 모터사이클 수리업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002402:1', '{"dJobCd":"K000002402","dJobCdSeq":"1","dJobNm":"공항전기설비관리원","workSum":"항공기가 이착륙하는 활주로의 각종 등화시설 및 기타 전력설비를 유지·보수한다","doWork":"활주로의 등화시설을 조사하여 파손된 전등을 교체한다. 비상등, 공항경계·통제등 및 기타 조명장치를 검사하여 결함이 있는 렌즈, 전등, 밸브 등을 교체·수리한다. 공항 내의 각종 조명장치 및 전력설비의 정상가동 여부를 확인하고 파손된 부위를 보수한다. 정전 또는 시설의 장애가 발생할 경우에는 비상발전기를 가동하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"전기공사기능사, 전기공사산업기사, 전기기능사","dJobECd":"8311","dJobECdNm":"[8311]산업 전기공","dJobJCd":"7621","dJobJCdNm":"[7621]산업 전기공","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004132:1', '{"dJobCd":"K000004132","dJobCdSeq":"1","dJobNm":"선박계장원","workSum":"선박 및 해양시설에 각종 제어장치 및 계측장치를 설치, 튜빙, 커넥션 후 테스트로 누설 검사 및 시스템이 정상 작동하는지 확인한다.","doWork":"작업도면을 보고 각종 기기의 설치 위치를 확인하고 작업방법을 설정한다. 드라이버, 스패너(Spanner:볼트나 너트를 죄거나 푸는 데 사용하는 공구), 용접장비, 동 튜브, 테이프 등의 작업에 필요한 도구와 설치할 각종 계기를 준비한다. 취부할 계기를 조립하고 용접하여 설치 위치에 고정시킨다. 각종 센서 및 밸브를 설치한다. 조정 장치를 설치한다. 센서 및 밸브와 조정 장치를 결선한다. 설치된 설치된 계장 시스템의 통합 및 성능 테스트. 누설 검사 및 시스템 정상 작동 여부를 도면과의 일치 여부를 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"전계장, 계장","certLic":"전기기능장, 전기기능사, 전기산업기사, 배관기능장, 배관기능사, 배관산업기사, 용접기능사","dJobECd":"8311","dJobECdNm":"[8311]산업 전기공","dJobJCd":"7621","dJobJCdNm":"[7621]산업 전기공","dJobICd":"C311","dJobICdNm":"[C311]선박 및 보트 건조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003626:1', '{"dJobCd":"K000003626","dJobCdSeq":"1","dJobNm":"선박전기의장원","workSum":"선박 및 해양시설의 전기설비를 도면에 따라 선박 내외의 시트류 설치, 케이블 포설 및 결선, 조명기구 설치, 동력기계 결선 등의 전기의장 작업을 한다.","doWork":"작업지시서 또는 도면을 읽고 필요한 장비, 공구, 자재 및 소모품을 준비한다. 전장시스템(POWER, AUTO, LIGHT, NAUTICAL)의 전기장치가 설치될 격벽에 코밍 및 케이블 행거를 설치한다. 설치된 케이블 행거에 케이블을 포설한다. 선내·외 각종 장비 및 스위치 박스, 배전반, 전기의장품을 설치하고 케이블 행거를 통해 포설된 케이블을 결속한다. 접속상자, 회로차단기, 전압조절기, 전동기, 변압기, 제어기, 배전반 및 콘솔에 케이블을 결속하기 위해 피복을 벗겨내고 터미널 압착기로 터미널을 압착하여 연결한다. 필요시 납땜 작업도 수행한다. 전력공급 전장시스템(POWER, AUTO, LIGHT, NAUTICAL) 등을 연결하여 시스템을 활성화 시킨다. 멀티 테스트기를 사용하여 전압, 저항, 전류 등의 전기적 성질을 측정하고 각종 전기장비에 공급하여 작동과 결선 상태를 점검하고 조정한다. 작업이 완료되면 선주 및 선급 검사관과 함께 검사를 수행하고 고품질의 선박을 선주에게 인도한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|청각|손사용|언어력|시각|","workEnv":"대기환경미흡|위험내재|고온|다습|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"선박전기배선원, 선박전기설치원, 선박전기설비설치원, 조선전기설치원, 조선전기설비설치원, 선박전기원, 선박전장설치원, 선박전장배선원, 선박전장결선원","connectJob":"무선항해통신장비설치원, 전선포설원","certLic":"전기기능장, 전기기능사, 전기산업기사","dJobECd":"8311","dJobECdNm":"[8311]산업 전기공","dJobJCd":"7621","dJobJCdNm":"[7621]산업 전기공","dJobICd":"C311","dJobICdNm":"[C311]선박 및 보트 건조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004931:1', '{"dJobCd":"K000004931","dJobCdSeq":"1","dJobNm":"선박전기의장현장감독자","workSum":"선박 및 해양시설에 전기설비 설치, 배선, 결선 작업을 수행하는 전장 작업원의 활동을 감독·조정한다.","doWork":"작업도면 및 장치도를 확인하고 작업방법을 결정한다. 자재 및 장비 수급을 관리하고 인력 배치와 작업을 지시한다. 선박 전기 시스템 설치(조명, 항해통신장비, 전기선로 등) 작업공정을 순회하여 기술 지도를 하고 작업활동과 안전 관리 및 규정을 준수하는지 감독한다. 설치된 각종 장비의 작동상태를 검사하여 불량 발견 시 수정한다. 배선 및 결선 검사를 하고 시운전을 수행하며 검사 및 테스트 결과를 문서화 한다. 작업 중 문제가 발생하면 문제를 해결하고 유지보수 계획 수립 및 정기 점검을 실시한다. 시스템 고장 시 진단 및 수리를 한다. 작업원의 작업을 관리하고 지시하며 교육 및 훈련을 제공한다. 또한 성과를 평가하며 피드백을 제공한다. 다른 부서와 협업하고 작업 진행상황을 보고한다. 신기술을 도입하고 작업 효율성 및 품질 향상을 위해 노력하며, 작업 과정 문제점을 분석 및 개선 제안을 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|손사용|언어력|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"선박전기배선반장, 선박전기설치반장, 선박전기설비설치반장, 조선전기설치반장, 조선전기설비설치반장, 선박전기반장, 선박전장설치반장, 선박전장배선반장, 선박전장결선반장","connectJob":"무선항해통신장비설치팀장, 전기화기팀장","certLic":"전기기능장, 전기기능사, 전기산업기사","dJobECd":"8311","dJobECdNm":"[8311]산업 전기공","dJobJCd":"7621","dJobJCdNm":"[7621]산업 전기공","dJobICd":"C311","dJobICdNm":"[C311]선박 및 보트 건조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004388:1', '{"dJobCd":"K000004388","dJobCdSeq":"1","dJobNm":"원자력계측제어정비원","workSum":"원자력발전소의 안전하고 정상적인 운영을 위하여 원자로, 터빈 및 부속 기기의 계측제어설비 신증설계획과 시공⦁운전⦁유지·정비⦁자재조달 및 기타관련관리를 수행한다.","doWork":"일상 및 계획 예방정비를 통하여 원자로, 터빈 및 부속 기기의 계측설비에 대한 이상 및 장애요인을 제거하고 설비개선 및 관리·감독을 한다. 계측설비의 주기적 정기점검 및 예방순시를 통하여 정상적으로 원자력계측제어설비가 작동되도록 관리·감독한다. 정비절차서 및 교재개발을 통하여 계측제어설비의 점검시험 보수에 관한 기술자료를 체계적인 관리를 한다. 일·이차계통의 계측제어설비의 안전성 및 신뢰성을 검토하여 주요결함, 부적합 사항에 대해서는 설계변경을 위한 기술검토를 실시한다. 해외기술정보 또는 다른 발전소의 사고, 경험사례를 검토하여 계측제어설비에 관련되는 사항에 대해서 대책을 수립 및 시행한다. 중장기 정비계획에 따라 정비자재의 확보계획을 수립하여 내·외자 청구 및 자재기술검토를 시행한다. 돌발사고 발생 시 신속하게 관련 계통을 점검·보수하고 돌발사고의 원인을 분석하여 대책을 수립한 후 작업내용 및 결과를 전산 입력하여 정비이력을 관리한다. 기타 일·이차계통계기의 유지·정비를 위한 제반 업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"일차계통계기원, 이차계통계기원","certLic":"전기기사, 전기공사기사, 원자력기사, 제어계측기사, 정보처리기사","dJobECd":"8311","dJobECdNm":"[8311]산업 전기공","dJobJCd":"7621","dJobJCdNm":"[7621]산업 전기공","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004433:1', '{"dJobCd":"K000004433","dJobCdSeq":"1","dJobNm":"철도차량전공원","workSum":"철도차량의 전기의장 작업을 위하여 전선절단, 배선, 결선 등을 하고 에어컨, 발전기, 변압기 등의 전기장비 등을 취부·결선한다.","doWork":"철도차량의 전기배선을 위하여 배선 도면을 수령하고 작업시방서에 따라 배선 및 결선위치, 배선재료, 배선규격 등을 확인한다. 작업에 필요한 작업표준규격의 전선을 선정하여 준비한다. 작업도구 및 공구(스트리퍼, 니퍼, 절단기, 펜치, 터미널압착기, 전선용테이프)를 준비한다. 도면을 읽고 자동전선 절단기 및 수동절단기를 사용하여 전선을 절단한다. 전선관에 절단된 전선을 예비선을 사용하여 입선한다. 실내, 옥상, 상하에 각종 전장품을 천정크레인 등을 사용하여 위치시키고 볼트, 너트로 고정시킨다. 전선관 단부는 비닐호스, 고무테이프 등을 사용하여 감싸준다. 타이밴드(Tie Band)로 전선을 결속 및 고정한다. 압착공구를 사용하여 터미널 압착작업을 하고 단자 내에 접속한다. 각 전선이 해당 단자 내에 올바로 결선되었는지 확인 및 수정한다. 최종 통전시험을 통하여 이상 유무를 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"철도배선결선원, 철도전기원","connectJob":"차량에 따라 열차전기설비설치원, 전동차전기설비설치원","certLic":"전기기능장, 전기기능사, 전기철도산업기사, 전기공사산업기사","dJobECd":"8311","dJobECdNm":"[8311]산업 전기공","dJobJCd":"7621","dJobJCdNm":"[7621]산업 전기공","dJobICd":"C312","dJobICdNm":"[C312]철도장비 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003352:1', '{"dJobCd":"K000003352","dJobCdSeq":"1","dJobNm":"철도차량전기반장","workSum":"철도차량의 각종 기기취부 및 전기의장 작업에 종사하는 작업원의 활동을 감독·조정한다.","doWork":"철도차량의 전기배선을 위하여 철도차량의 전기배선 및 작업도면을 확인한다. 전기회로 도면에 의해 전기회로 구성에 필요한 부품을 파악하고 이상 유무를 확인한다. 전기·전자 관련 측정장비(멀티테스터기, 오실로스코프), 조립공구(스트리퍼, 니퍼) 등 전기회로 구성에 필요한 장비 및 도구를 준비한다. 작업원들이 원활히 작업할 수 있는 작업환경을 조성한다. 해당 기계장비의 제어방법 및 전기방식을 파악한다. 작업원을 배치하고 작업량을 지시한다. 공정을 순회하여 작업활동을 감독하고 기술적 사항을 지도한다. 각종 기기, 배선·결선상태를 검사하여 도면과 비교하고 이상 시 수정을 지시한다. 통전시험을 통하여 작업결과를 검사 및 시험하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"철도차량전기관리장","certLic":"전기철도산업기사, 전기기능장, 전기기능사","dJobECd":"8311","dJobECdNm":"[8311]산업 전기공","dJobJCd":"7621","dJobJCdNm":"[7621]산업 전기공","dJobICd":"C312","dJobICdNm":"[C312]철도장비 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003337:1', '{"dJobCd":"K000003337","dJobCdSeq":"1","dJobNm":"태양광발전시스템설비설치기술자","workSum":"태양광 발전에 필요한 태양광 관련 설비를 부지에 설치하고, 운영상 나타나는 기계 오작동이나 문제점을 파악하고 해결한다.","doWork":"지상, 수상, 해상, 건물 등 설치 장소와 토목 공사, 창호 공사, 부유체 공사, 구조물 공사 등 설치 목적에 따라 전기공사를 준비한다. 태양광발전시스템 설계도서에 따라서 태양광모듈, 인터버터, 접속함, 모니터링 등을 설치하고 전기공사를 실시한다. 계통연계형 시스템의 경우 계통연계를 실시하고, 독립형시스템의 경우 저장장치를 설치한다. 시스템 설치 이후 시험 운전을 통해서 성능에 이상이 없는지 확인한다. 태양광발전시스템 운영과 관련된 고객의 민원을 접수하고 현장 점검을 통해 태양광발전시스템 운영 시 나타나는 제반 오류 사항을 파악하고 하자 보수 작업을 한다.) ","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실외","physicalAct":"손사용|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"태양광발전시스템시공기술자, 태양광발전시스템설치원,  주택태양광설치원","certLic":"신재생에너지발전설비기사(태양광), 신재생에너지발전설비산업기사(태양광)","dJobECd":"8311","dJobECdNm":"[8311]산업 전기공","dJobJCd":"7621","dJobJCdNm":"[7621]산업 전기공","dJobICd":"F412","dJobICdNm":"[F412]토목 건설업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004867:1', '{"dJobCd":"K000004867","dJobCdSeq":"1","dJobNm":"항공기배선원","workSum":"항공기 전기·전자 시스템에 사용되는 각종 배선을 항공기 내부의 구조물에 설치하고 각 부에 연결한다.","doWork":"배선도(Wiring Diagram)나 전기회로도(Electric Circuit Diagram)를 보고 작업에 필요한 공구와 자재를 준비한다. 항공기 구조물에 배선을 위치시키고 연결한 후, 배선의 끝부분이 적당량만 돌출될 수 있도록 조절한다. 구조물의 전기부품에 배선을 연결한다. 회로시험기(Circuit Tester:전압, 전류, 저항 등을 측정하는 미터 표시의 간이측정기)를 이용하여 배선이 알맞게 설치되었는지 확인한다. 배선을 여러 가닥씩 묶어 정리한다. 장착된 배관과 주변 부품의 간섭, 규정된 간격 준수 여부 및 부품의 손상 유무를 확인한다. 주위를 정리·정돈한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"항공기전기원","connectJob":"항공전기전자계기정비사","certLic":"항공정비사, 항공기사, 항공산업기사, 항공전기·전자정비기능사","dJobECd":"8311","dJobECdNm":"[8311]산업 전기공","dJobJCd":"7621","dJobJCdNm":"[7621]산업 전기공","dJobICd":"C313","dJobICdNm":"[C313]항공기, 우주선 및 부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006626:1', '{"dJobCd":"K000006626","dJobCdSeq":"1","dJobNm":"계장공","workSum":"공장, 빌딩 등의 건축물의 기계·급배수·전기·가스·위생·냉난방 및 기타 공사에 있어서 각종 계기(플랜트 프로세스의 자동제어장치, 공업제어장치, 공업계측 및 컴퓨터 등)를 설치·부착·점검한다.","doWork":"작업지시에 따라 도면을 숙지하고 내선전공과 함께 계장설비를 위한 배관·배선을 설비한다. 설비된 기계, 배관(급배수관·전기관·가스관·위생배관 등), 냉난방장치 및 기타 시설물에 계기(자동제어장치, 계측기)를 설치한다. 테스터기 등을 사용하여 결선상태를 점검한다. 각종 계기 및 계측기가 설치되면 중앙통제실에 중앙제어장치(컴퓨터)를 설치하고 간단한 프로그램을 설치한다. 복잡한 프로그램은 전문가가 설치한다. 각종 계기 및 프로그램의 설치가 완료되면 시운전을 통해 시험·조정한다. 원자력발전소의 1차계통(터빈, 발전기 등)에 연결된 급배수관, 위생배관, 가스관 등의 시설물에 각종 계기를 설치·부착·점검하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"계장기술자","connectJob":"원자력계장원, 플랜트계장원","certLic":"전기공사산업기사, 전기공사기사, 전기기능사","dJobECd":"8312","dJobECdNm":"[8312]내선 전기공","dJobJCd":"7622","dJobJCdNm":"[7622]내선 전기공","dJobICd":"F423","dJobICdNm":"[F423]전기 및 통신 공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001743:1', '{"dJobCd":"K000001743","dJobCdSeq":"1","dJobNm":"내선전공","workSum":"주택, 공장 및 기타 건축물에 전기를 공급하기 위해 전선 및 케이블을 배선하고 각종 전기시설물을 설치·보수한다.","doWork":"옥내배선도나 도면을 확인하고 수용가옥 구조, 구조물 내부상태, 배전선로 위치 등을 파악한다. 배선을 위해 슬래브배관, 노출배관, 벽체배관, 수변전, 분전반, 덕트 등의 배관 및 장치물을 설치한다. 배관을 따라 전선을 인입하고 인출하여 결선한다. 배선루트를 따라 전선관을 설치하고 전선을 입선 및 가선한다. 옥내 배전선과 인입구까지 연결되어 있는 인입선을 케이블로 연결하고 차단기를 설치한다. 건물 내 조명, 콘센트, 스위치, 기구 등의 설비물을 설치하고 인출선에 연결한다. 접지선을 연결하여 땅에 묻는다. 배전함을 가공·설치하고, 전선이나 전선관 보호를 위한 몰드를 설치한다. 회선단락, 저항, 배선상의 결함을 검사하고 전류를 투입하여 시험한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"건축전기원, 건물전기공사원, 건물전기배선원","connectJob":"대상에 따라 아파트전기공사원, 공장전기공사원, 인테리어전기원, 소방전기원, 플랜트전기공사원","certLic":"전기기능사, 전기공사산업기사, 전기공사기사","dJobECd":"8312","dJobECdNm":"[8312]내선 전기공","dJobJCd":"7622","dJobJCdNm":"[7622]내선 전기공","dJobICd":"F423","dJobICdNm":"[F423]전기 및 통신 공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005828:1', '{"dJobCd":"K000005828","dJobCdSeq":"1","dJobNm":"내선전공보조원","workSum":"옥내전선공사 작업을 하는 내선전공의 업무를 보조한다.","doWork":"주택, 공장, 빌딩 등의 옥내배관, 배선 및 등기구류 설비를 시공·보수하는 내선전공의 업무를 보조한다. 배관에 사용되는 금속관이나 합성수지관을 절단하고, 나사내기 및 덕트의 금속판을 절단한다. 전기회로를 구성하기 위해 전선을 설치한다. 벽, 천장, 바닥등에 배선경로를 마련하기 위해 구멍을 뚫고, 케이블 트레이 및 배관을 설치한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","similarNm":"건축전기보조원, 건물전기공사보조원","certLic":"전기기능사","dJobECd":"8312","dJobECdNm":"[8312]내선 전기공","dJobJCd":"7622","dJobJCdNm":"[7622]내선 전기공","dJobICd":"F423","dJobICdNm":"[F423]전기 및 통신 공사업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006049:1', '{"dJobCd":"K000006049","dJobCdSeq":"1","dJobNm":"내선현장감독자","workSum":"주택, 공장 및 기타 건축물에 옥내전선공사를 하는 내선전공의 활동을 감독·조정한다.","doWork":"전기배선도면을 검토하고 작업상황을 파악하여 작업 계획을 세운다. 전선 및 부속자재의 규격과 수량을 확인한다. 내선전공을 작업현장에 배치하고 작업을 지시한다. 작업상황을 감독하고 조정한다. 회선의 단락·저항 및 배선상의 결함 등을 검사한다. 수시 관찰과 면담을 통하여 작업원의 애로사항 및 건의사항을 수렴·해결하고 문제점을 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"건축전기반장, 건물전기공사반장, 내선반장","certLic":"전기기능사, 전기공사산업기사, 전기공사기사","dJobECd":"8312","dJobECdNm":"[8312]내선 전기공","dJobJCd":"7622","dJobJCdNm":"[7622]내선 전기공","dJobICd":"F423","dJobICdNm":"[F423]전기 및 통신 공사업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006590:1', '{"dJobCd":"K000006590","dJobCdSeq":"1","dJobNm":"네온사인제작원","workSum":"광고나 장식물 등으로 활용되는 네온사인을 제작한다.","doWork":"가로로 길게 특수 제작된 가스버너에서 유리관을 가열하여 모양을 변형 가능한 형태로 만든다. 휘어지는 안쪽과 바깥쪽을 골고루 가열하여 유리관의 두께가 항상 일정하게 유지시킨다. 가열되어 물렁물렁해진 유리관을 원하는 문자나 모양으로 구부린 다음 진공상태로 만든다. 구부린 유리관에 네온가스나 아르곤(Argon)가스를 넣는다. 양 끝에 전기가 들어가는 전극부분을 접합하고 배기과정을 거친다. 채널 위 피복동선의 네온문자는 바인드선을 이용하여 고정시킨다. 이때 되도록 배선을 드러내지 않도록 하며 트랜스의 용량을 초과하지 않도록 배선한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|손사용|","workEnv":"위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"협의","workFunc3":"수동조작","certLic":"컴퓨터그래픽스운용기능사","dJobECd":"8312","dJobECdNm":"[8312]내선 전기공","dJobJCd":"7622","dJobJCdNm":"[7622]내선 전기공","dJobICd":"C284","dJobICdNm":"[C284]전구 및 조명장치 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004780:1', '{"dJobCd":"K000004780","dJobCdSeq":"1","dJobNm":"버스터미널시설유지보수원","workSum":"버스터미널의 이용차량 및 승객에게 편의를 제공하기 위하여 수배전 설비 및 발전설비, 통신설비, 소방설비, 조명설비 등의 터미널 종합시설과 편의시설을 관리한다.","doWork":"소화설비, 경보설비 등의 소방설비, 정전 및 비상시 운영하는 발전설비, 방송장비, 전화선로, 교환기 등의 통신설비, 승강기 등의 터미널 전기설비를 유지·보수한다. 야간에 버스터미널을 이용하는 승객 및 차량의 안전한 승하차 및 주정차를 위하여 주차장 조명설비와 터미널 전체의 조명설비를 유지·보수한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"전기기능사, 승강기기능사, 통신기기기능사, 통신선로기능사","dJobECd":"8312","dJobECdNm":"[8312]내선 전기공","dJobJCd":"7622","dJobJCdNm":"[7622]내선 전기공","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006316:1', '{"dJobCd":"K000006316","dJobCdSeq":"1","dJobNm":"변압기설치원","workSum":"주상 및 지상 변압기와 부속기기를 설치·결선·시험·수리한다.","doWork":"설치할 변압기의 용량과 설치장소를 점검한다. 주상 또는 지상 설치장소에 완금, 암타이, 볼트, 방부재를 칠한 목판 등으로 변압기대를 조립한다. 호이스트(Hoist:비교적 소형의 화물을 들어 옮기는 장치)를 이용해 변압기를 변압기대에 얹거나 또는 행거를 써서 설치한다. 변압기를 주상변압기용 행거밴드(Hanger Band)를 이용하여 전주에 고정시킨다. 변압기를 결선하고 탭을 조정한다. 퓨즈 교체에 용이한 개소에 프라이머리 컷아웃스위치(Cut-out Switch:옥내배선의 인입점·분기점 등에 사용되는 스위치), 캐치홀더(Catch-holder:배전용 변압기의 2차측에 부착하는 퓨즈대) 등의 부속기기를 설치하고 변압기와 결선한다. 시험기기를 이용해 저항, 결연내력, 단락, 무부하시험을 하고 설치되어 있는 변압기를 점검하고 부족한 유액을 공급한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"변압기설치및정비원","certLic":"전기공사산업기사, 전기기능사","dJobECd":"8312","dJobECdNm":"[8312]내선 전기공","dJobJCd":"7622","dJobJCdNm":"[7622]내선 전기공","dJobICd":"F423","dJobICdNm":"[F423]전기 및 통신 공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001811:1', '{"dJobCd":"K000001811","dJobCdSeq":"1","dJobNm":"예술품운송설치원","workSum":"작가, 화랑 담당자 등의 요청으로 예술품을 안전하게 운송하고 화랑 등 관람 장소에 작품을 설치한다.","doWork":"고객으로부터 운송·설치할 예술품의 가치, 중요성, 종류 등을 듣고 포장, 운송 방법 등 작업내용을 파악한다. 작업내용 등을 토대로 가격 등을 결정하고 고객과 협의하며 계약서를 작성한다. 작품의 크기, 재료, 재질 등을 토대로 포장방법을 선정하여 발포지, 에어캡, 골판지 등으로 포장한다. 수송차량(무진동, 방온, 방습 차량 포함)에 싣고 설치장소까지 안전하게 이송한다. 수송차량에서 예술품을 내려 작업장소로 옮기고 포장을 푼다. 작가나 화랑관계자와 협의하여 설치할 장소, 위치 등을 결정하고 조도 등을 정하고 작품을 설치하거나 배치한다. 전시가 완료되면 예술작품을 해체하고 포장하여 저장소 등에 다시 운송하고 하역한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|손사용|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"예술품설치원","dJobECd":"8312","dJobECdNm":"[8312]내선 전기공","dJobJCd":"7622","dJobJCdNm":"[7622]내선 전기공","dJobICd":"S969","dJobICdNm":"[S969]그 외 기타 개인 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006535:1', '{"dJobCd":"K000006535","dJobCdSeq":"1","dJobNm":"전기계량기설치원","workSum":"수요자의 신·증설 요구에 따라 전기계량기를 기준 및 규격에 맞도록 설치한다.","doWork":"수요자의 전기계량기 설치요구 접수사항에 대한 의뢰내용을 확인한다. 배전설비의 규정 및 기준에 맞는 계량기 및 주변 설비 등을 검토한다. 전기요금에 맞는 설비를 갖추고 있는지를 검토하여 계약상 관계의 위법 여부를 확인한다. 계량기를 취부 및 봉인하고, 계약용량과 설비용량과의 이상 유무를 확인한다. 수전설비, 일반용 전기공작물을 점검 및 조사한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"수동조작","certLic":"전기공사산업기사, 전기기능사","dJobECd":"8312","dJobECdNm":"[8312]내선 전기공","dJobJCd":"7622","dJobJCdNm":"[7622]내선 전기공","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006801:1', '{"dJobCd":"K000006801","dJobCdSeq":"1","dJobNm":"전기공사현장관리자","workSum":"사업체의 전기설비 개선방안을 검토하고 설비의 유지·관리에 종사하는 작업원의 활동을 감독·조정한다.","doWork":"전기 분야의 각종 자료를 수집·분석하고 설비의 가동상태, 운전상태, 통계 및 정비분석, 사고기록분석 등의 실적평가 및 설비성 등을 검토하여 개선방안을 검토한다. 단위생산 및 부대설비의 사양서, 시공 설계서를 검토하여 공정계획의 기술적인 검토 및 조정을 한다. 설비의 유지 및 관리를 위하여 정비·보수·점검 등의 장단기계획을 수립하고 작업원을 배치하여 작업지시를 한다. 설비운영 및 전체 공정관리를 위한 기술적인 지원을 하며 사고에 대한 원인을 조사·분석하여 대책을 수립한다. 전기기기의 운전에 대한 기술적인 지도 및 안전관리를 한다. 작업현장을 순찰하여 작업원의 활동을 감독하고 이상발생 시 조치한다. 전기설비를 점검·관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"전기기사, 전기공사현장소장","certLic":"전기기사, 전기공사기사, 전기공사산업기사","dJobECd":"8312","dJobECdNm":"[8312]내선 전기공","dJobJCd":"7622","dJobJCdNm":"[7622]내선 전기공","dJobICd":"F423","dJobICdNm":"[F423]전기 및 통신 공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006686:1', '{"dJobCd":"K000006686","dJobCdSeq":"1","dJobNm":"전기수리원","workSum":"사업체 내에 설치되어 있는 전기공작물, 전기시설, 전기장비 등의 원활한 가동 및 유지를 위하여 수배전설비·조명설비·생산설비 등을 유지, 보수, 관리한다.","doWork":"사업체 내의 전기배선설계도를 검토한다. 전기수리작업에 따른 안전수칙과 수리 방법 및 절차를 숙지하고 작업에 필요한 보호구 및 수리도구를 준비하여 성능을 확인한다. 수리작업 장소의 주전원 스위치 개폐상태를 확인하고 작업 표시판을 부착한다. 전기설비의 온도, 동작상태, 체결상태, 절연저항, 부식 여부 등을 점검·검사하여 고장원인과 고장부품을 찾고 신품과 교체하거나 수리절차에 따라 제반 문제점을 해결한다. 전선을 연결하고 누전·합선 등을 방지하기 위하여 절연시험을 한 후 절연테이프로 감는다. 지선을 설치하고 퓨즈상태, 이상소음, 진동상태, 가열 여부 등을 점검·확인한다. 작업내용, 시간, 소요부품, 작업자 등을 작업일지에 기록한다. 전기기기를 설치하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"전기공, 전공, 전기수리공","certLic":"전기공사산업기사, 전기기능사","dJobECd":"8312","dJobECdNm":"[8312]내선 전기공","dJobJCd":"7622","dJobJCdNm":"[7622]내선 전기공","dJobICd":"F423","dJobICdNm":"[F423]전기 및 통신 공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001893:1', '{"dJobCd":"K000001893","dJobCdSeq":"1","dJobNm":"조명기구설치원","workSum":"실내(가정, 사무실, 상업/공장 시설, 전시관 등)와 실외(보안등, 가로등, 경관등 등) 환경에 적용되는 조명용 등기구류를 설치·수리한다.","doWork":"건축도면과 설치상세도를 보고 분전함, 스위치, 콘센트의 설치 위치와 조도 및 조명기구를 확인한다. 벽면 또는 천장에 배선되어 있는 전선을 인출하여 적정 길이로 잘라 피복을 벗긴다. 앵커볼트·인서트를 사용하여 등기구를 단단히 설치하고 필요할 때에는 나무나사 등으로 진동을 방지한다. 전선이 금속부분을 관통하는 경우 전선의 피복이 손상되지 않도록 적당한 보호물을 씌우고 인출선과 등기구선을 스위치와 교차 연결한다. 나무, 대, 종이, 합성수지 및 금속재의 갓, 글로브 등을 부착한다. 조명 불빛을 조절·변화시켜 여러 가지 효과를 내도록 하는 장치·트랜스·소형변압기 등을 설치하여 연결한다. 조명등의 밝기를 조도계를 이용하여 측정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"등기구설치원","connectJob":"LED조명기구설치원, LED조명설치원, 건물조명설치원","certLic":"전기기능사, 전기공사산업기사","dJobECd":"8312","dJobECdNm":"[8312]내선 전기공","dJobJCd":"7622","dJobJCdNm":"[7622]내선 전기공","dJobICd":"F423","dJobICdNm":"[F423]전기 및 통신 공사업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006062:1', '{"dJobCd":"K000006062","dJobCdSeq":"1","dJobNm":"가로등설치원","workSum":"도로조명용 가로등과 교통신호등을 설치·보수한다.","doWork":"설계도면을 파악하고, 등기구의 종류와 설치 위치를 확인한다. 굴착기계 운전원에게 굴착 위치와 크기 및 깊이 등을 지시한다. 지중 전선관을 포설한다. 등주 위치에 철근을 배근하고 콘크리트를 타설한 후 앵커볼트를 매입한다. 지중 전선관에 케이블을 입선한다. 안정기를 외함에 넣고, 조명기구와 전기적으로 접속되지 않도록 설치한다. 조명기구를 등주의 지시된 위치에 부착하고 케이블과 연결한다. 크레인 운전원에게 등주의 설치 위치를 지시하고 설치한다. 등주가 도로의 선형과 일치시키고 암은 도로선과 직각방향이 되도록 조정·설치한다. 가로등, 보안등, 조경등 또는 교통신호등의 점멸을 조정하기 위하여 제어함을 설치하고 제어함과 케이블을 결선한다. 전기계측기 및 공구를 이용하여 퓨즈·안정기 등을 점검·교체한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실외","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"가로등조명설치원","connectJob":"교통신호등설치원, 신호등조명설치원","dJobECd":"8313","dJobECdNm":"[8313]외선 전기공","dJobJCd":"7623","dJobJCdNm":"[7623]외선 전기공","dJobICd":"F423","dJobICdNm":"[F423]전기 및 통신 공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002351:1', '{"dJobCd":"K000002351","dJobCdSeq":"1","dJobNm":"가로등설치현장감독자","workSum":"도로조명용 가로등 또는 교통신호등을 설치·수리하는 작업원의 활동을 감독·조정한다.","doWork":"도로조명용 가로등 또는 교통신호등의 설계도를 이해하고 작업내용을 파악한다. 작업내용을 작업원에게 지시·배치한다. 작업진행상황을 파악하고 작업내용을 보고한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원 및 자재를 공급한다. 작업계획에 따라 세부실행항목을 수립하여 작업 절차 및 방법을 결정하여 작업원에게 작업내용을 지시하고 작업배치를 한다. 표준명세에 따라 지시된 작업이 이루어지는지 작업원과 함께 작업하며 작업상황을 관찰하고 작업내용을 점검한다. 작업원에 대한 직무교육 및 안전위생교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시 관찰과 면담을 통하여 작업원의 애로 및 건의사항을 수렴·해결하고 문제점을 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실외","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"가로등조명설치반장, 가로등설치반장","certLic":"전기기능사, 전기공사산업기사","dJobECd":"8313","dJobECdNm":"[8313]외선 전기공","dJobJCd":"7623","dJobJCdNm":"[7623]외선 전기공","dJobICd":"F423","dJobICdNm":"[F423]전기 및 통신 공사업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005583:1', '{"dJobCd":"K000005583","dJobCdSeq":"1","dJobNm":"광산전공원","workSum":"광산의 전기설비, 전기기기 등의 원활한 가동을 위하여 전기설비·신호기 등을 설치·유지·수리한다.","doWork":"설계도를 검토하여 배선작업을 위한 세부계획을 작성한다. 쇠톱 등으로 전기도관을 측정하여 절단하고 구부린다. 도관 속으로 규정된 전선을 집어넣는다. 칼이나 니퍼(Nipper)로 전선의 절연부분을 벗겨내고 저항시험을 한 뒤 전선을 연결하고 테이프로 감는다. 지선이 필요한 곳은 규정에 의거하여 지선을 설치한다. 배전반에 극성을 확인하고 연결한다. 퓨즈를 점검한다. 누전, 단선, 합선, 이상소음, 진동상태, 가열 여부 및 보호장치를 확인한다. 광산 내의 전등, 신호기 등 전기공작물 및 전시시설을 설치한다. 전기기기의 이상 유무를 확인하기 위하여 테스터를 사용하여 저항·전류 등을 측정한다. 고장난 기기를 분해하여 고장원인을 찾고 신품과 교환하거나 수리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"광산전공, 광산내전원","connectJob":"광산전기기기수리원, 변전원","certLic":"전기기능사, 전기공사산업기사","dJobECd":"8313","dJobECdNm":"[8313]외선 전기공","dJobJCd":"7623","dJobJCdNm":"[7623]외선 전기공","dJobICd":"B051/B061/B062","dJobICdNm":"[B051]석탄 광업 / [B061]철 광업 / [B062]비철금속 광업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005265:1', '{"dJobCd":"K000005265","dJobCdSeq":"1","dJobNm":"광산전기현장감독자","workSum":"광산에서 착암, 운반, 선광 등의 작업에 필요한 전기공작물, 전기시설, 전기장비 등을 설치·유지·수리·관리하는 일을 하는 작업원의 활동을 감독·조정한다.","doWork":"광산보안법과 전기안전수칙을 숙지하고 작업원들에게 안전교육을 실시한다. 변전실, 갱내 전기시설 등을 순찰·점검하고 작업방법을 지시한다. 전기공작물이나 전기시설을 수리하는데 필요한 부품을 구입하는 제반 문제를 해결한다. 전기안전일지를 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"광산전기주임, 광산전공반장, 광산전기반장","certLic":"전기기능사, 전기공사산업기사","dJobECd":"8313","dJobECdNm":"[8313]외선 전기공","dJobJCd":"7623","dJobJCdNm":"[7623]외선 전기공","dJobICd":"B051/B061/B062","dJobICdNm":"[B051]석탄 광업 / [B061]철 광업 / [B062]비철금속 광업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004496:1', '{"dJobCd":"K000004496","dJobCdSeq":"1","dJobNm":"도로조명수선원","workSum":"도로의 가로등, 교통신호등 등을 시험·수선·조정한다.","doWork":"크레인 및 공구를 사용하여 도로상의 전등을 분해한다. 조도계·전압계 및 절연저항계 등의 전기계측장치를 사용하여 부품을 시험·검사하여 수선이나 교체할 것인가를 결정한다. 손상된 연결장치, 결함있는 안전기, 열화된 절연재, 기타 전기부품을 수선·교체한다. 등기구 외함이나 조명기구 안에 수선한 전등을 설치한다. 전등을 설치 후 규정된 조도와 투사각도를 유지하는지를 전기계측장치를 이용하여 측정하고 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"가로등수선원, 수은등수선원, 가로등조명수선원","certLic":"전기기능사, 전기공사산업기사","dJobECd":"8313","dJobECdNm":"[8313]외선 전기공","dJobJCd":"7623","dJobJCdNm":"[7623]외선 전기공","dJobICd":"F423","dJobICdNm":"[F423]전기 및 통신 공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;