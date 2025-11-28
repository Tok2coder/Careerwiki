INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003967:1', '{"dJobCd":"K000003967","dJobCdSeq":"1","dJobNm":"사방작업원","workSum":"산림의 토사유출이나 붕괴를 방지하고 녹화를 위하여 떼 및 나무를 심고, 석축을 쌓는 작업을 한다.","doWork":"황폐된 계곡의 경사를 완화하기 위하여 곡괭이나 삽 등의 도구를 사용하여 흙을 고른다. 사방사업지를 확인하고 사방사업에 필요한 떼나 그물망 등을 운반한다. 곡괭이나 삽 등을 이용하여 일정 넓이로 구덩이를 파고 떼를 잘라 묻는다. 사방종자와 비료를 혼합하여 땅을 판 곳에 붓고 흙으로 덮는다. 구덩이를 파고 나무를 심는다. 붕괴 위험이 있는 곳은 석축을 쌓기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"힘든 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","dJobECd":"9031","dJobECdNm":"[9031]조림∙산림경영인 및 벌목원","dJobJCd":"6201","dJobJCdNm":"[6201]조림·산림경영인 및 벌목원","dJobICd":"A020","dJobICdNm":"[A020]임업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007254:1', '{"dJobCd":"K000007254","dJobCdSeq":"1","dJobNm":"산림목공","workSum":"산림의 사면안정, 배수를 고려하여 콘크리트 타설, 흙막이 등을 위한 형틀(거푸집), 동바리를 제작, 조립, 설치, 해체하는 작업을 한다.","doWork":"기본적으로 산림의 사면, 비탈면, 경사, 지형조건, 토질 및 암반 등을 고려하고, 강우에 의한 배수를 고려하여 작업한다. 합판과 각재를 설계도면에 맞게 재어 절단하여 형틀을 제작한다. 형틀을 설치하기 위하여 수평기를 사용하여 적절한 각도에 따라 형틀을 조립한다. 설치한 형틀의 수평도, 수직도, 설치 상태 등을 점검한다. 콘크리트 양생 후 형틀과 지주를 해체하는 작업을 한다. 거푸집 및 지주가 해체되면 주위를 정리하고 다음 작업을 준비한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"아주 힘든 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|손사용|시각|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"형틀공, 형틀목수, 형틀목수공, 거푸집설치공, 거푸집설치원, 거푸집설치기능원","connectJob":"형틀목공","certLic":"거푸집기능사","dJobECd":"9031","dJobECdNm":"[9031]조림∙산림경영인 및 벌목원","dJobJCd":"6201","dJobJCdNm":"[6201]조림·산림경영인 및 벌목원","dJobICd":"A020","dJobICdNm":"[A020]임업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003783:1', '{"dJobCd":"K000003783","dJobCdSeq":"1","dJobNm":"산림병충해예찰조사원","workSum":"병충해로부터 피해 확산을 방지하기 위하여 산림 내 수목의 잎, 가지, 뿌리 등의 조기 예찰 필요 시 조사 등을 수행한다.","doWork":"산림해충에 대한 참고자료를 수집하며 수종에 따른 병충과 위해에 대한 피해상황 등을 조사·파악하고 조사계획을 수립한다. 조사계획에 따라 피해 예정 지역을 순찰하며 기후, 토양, 수종, 색채, 형태 등을 관찰하여 이상이 발견될 경우 표본을 채취한다. 위해에 대한 사전 대비 계획을 수립하고 연구기관에 병충해 진단조사를 의뢰한다. 병충해 및 위해 발생지역을 알리기 위하여 구획에 표시를 한다. 산림병충해 발견 위치의 구역(좌표), 면적, 본수, 피해도를 조사하여 기록표를 작성한다. 육묘장에서 병해충이 발견되면 묘목을 뽑아 제거하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"시각|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"9031","dJobECdNm":"[9031]조림∙산림경영인 및 벌목원","dJobJCd":"6201","dJobJCdNm":"[6201]조림·산림경영인 및 벌목원","dJobICd":"A020","dJobICdNm":"[A020]임업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004135:1', '{"dJobCd":"K000004135","dJobCdSeq":"1","dJobNm":"산림보호원","workSum":"해당 구역 내의 조림, 육림 등의 상황을 조사하고 산림이 각종 제반 피해로부터 보호되도록 조치한다.","doWork":"산림지역을 순찰하고 도벌 피해가 발견되면 피해 상황을 조사하여 관리책임자에게 보고하고 가해자를 탐문 추적하여 고발 조치한다. 산림지역의 주민에게 애림사상을 고취시키고 도·남벌 예방을 협조·요청하며 피해 정보를 수집한다. 봄·가을철, 공기가 건조한 산림화재 발생 위험 시기에는 입산자를 계몽하고 산불예방을 위하여 입산자를 통제한다. 산불이 발생하면 연락할 수 있는 비상연락망을 만들고 인근 주민을 동원하여 산불진화작업을 한다. 진화작업이 끝나면 피해 상황을 조사하고 피해 원인을 찾아 피해 지역의 조림계획을 세운다. 벌목작업 시 벌채 표시된 대상 이외의 잡목은 벌채하지 못하도록 감독·지도한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"9031","dJobECdNm":"[9031]조림∙산림경영인 및 벌목원","dJobJCd":"6201","dJobJCdNm":"[6201]조림·산림경영인 및 벌목원","dJobICd":"A020","dJobICdNm":"[A020]임업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007374:1', '{"dJobCd":"K000007374","dJobCdSeq":"1","dJobNm":"산림석공","workSum":"산림의 사면안정을 고려한 돌쌓기, 골막이, 바닥막이, 기슭막이, 수제, 계간수로 등을 시공하며, 돌쌓기를 위한 터파기, 바닥면 다듬기, 뒤채움, 되메우기 등 석재를 이용한 시공을 수행한다.","doWork":"기본적으로 사면의 비탈면, 경사, 지형조건, 토질 및 암반 등을 고려하여 사면안정을 도모하는 작업을 수행한다. 비탈면에 규준틀을 설치하고, 땅고르기를 및 터파기, 기초말뚝, 토대목 또는 기초콘크리트 등을 시공한다. 사면안정을 고려하여 찰쌓기, 메쌓기, 켜쌓기, 골쌓기 등 돌쌓기를 수행하며, 돌쌓기 시 석재 종류에 따라 층쌓기 마다 돌이를 수정하거나, 난도 다듬질을 하거나 다듬메를 한다. 사방공사에서는 석재를 이용하여 사방댐, 골막이, 바닥막이, 기슭막이, 수제 등의 시공을 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 힘든 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|손사용|시각|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"석공기능사","dJobECd":"9031","dJobECdNm":"[9031]조림∙산림경영인 및 벌목원","dJobJCd":"6201","dJobJCdNm":"[6201]조림·산림경영인 및 벌목원","dJobICd":"A020","dJobICdNm":"[A020]임업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002782:1', '{"dJobCd":"K000002782","dJobCdSeq":"1","dJobNm":"산림순찰원","workSum":"산림경영을 목적으로 산림조건에 영향을 미치는 각종 자료를 수집하기 위하여 산림지대를 순찰한다.","doWork":"계획서에 따라 산림지역을 순찰한다. 각 표본나무를 선정하고 표본나무의 수고와 직경을 측정하기 위하여 측정자나 각종 도구를 사용하여 관측한다. 나무의 부식, 휨 등의 결함으로 인한 시장 공급 가능량의 손실을 견적하거나 각 나무의 사용할 수 있는 임목의 양을 산정한다. 현지도로(임도), 개울, 호수, 통신시설 등에 관한 자료를 산림지도에 표시하고 수림(나무)의 종류, 크기, 상태 또는 지역별 특징을 파악하여 보고를 준비한다. 산림지역 내의 임목에 병충해의 침입을 알아보기 위하여 잎이나 가지, 줄기를 관찰하고 의심스러운 수종은 표본을 채취하여 병해충 연구 기관에 의뢰한다. 흔적, 경계, 병해충, 피해목, 벌채, 수종 등을 표시하기 위하여 나무껍질 표면에 분무페인트로 칠하거나 뿌린다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"산림순시원","dJobECd":"9031","dJobECdNm":"[9031]조림∙산림경영인 및 벌목원","dJobJCd":"6201","dJobJCdNm":"[6201]조림·산림경영인 및 벌목원","dJobICd":"A020","dJobICdNm":"[A020]임업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007255:1', '{"dJobCd":"K000007255","dJobCdSeq":"1","dJobNm":"산림작업반장","workSum":"산림사업에 필요한 인력들을 관리하고, 작업자들의 작업에 필요한 산림기술을 교육지도 및 작업을 지휘·관리·감독하고 현장대리인에게 작업상황 및 애로사항을 보고한다.","doWork":"설계도면을 읽고 작업계획을 수립한다. 작업계획에 따라 세부실행항목을 수립하여 작업 절차 및 방법을 결정한 후 작업원에게 작업내용을 지시하거나 작업배치를 한다. 표준명세에 따라 지시된 작업이 이루어지는지 작업원과 함께 작업하면서 작업내용을 점검한다. 작업자의 작업 상태를 점검하고 불량부분을 재시공하도록 지시한다. 작업진행상황을 파악하여 현장대리인에게 작업내용을 보고한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원 및 자재 공급을 한다. 작업원에 대한 직무교육 및 안전위생교육을 실시한다. 수시 관찰과 면담을 통하여 작업원의 애로사항 및 건의사항을 수렴·해결하고 현장대리인에게 문제점을 보고한다. 때로는 작업자를 확보 및 현장으로의 이동 등을 담당한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 힘든 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|손사용|시각|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"설치","dJobECd":"9031","dJobECdNm":"[9031]조림∙산림경영인 및 벌목원","dJobJCd":"6201","dJobJCdNm":"[6201]조림·산림경영인 및 벌목원","dJobICd":"A020","dJobICdNm":"[A020]임업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006996:1', '{"dJobCd":"K000006996","dJobCdSeq":"1","dJobNm":"아보리스트","workSum":"등목기술을 이용하여 수목에 올라 수목을 관리 및 제거 또는 수목의 일부를 채취 하는 등의 작업을 수행한다.","doWork":"등목기술을 이용하여 15m 이상인 수목에 올라 병해충목 관리, 위험 수목 제거, 종자채취 등의 일을 수행한다. 국가유산으로 가치가 높은 보호수나 노거수를 관리한다. 작업을 위하여 다양한 매듭을 사용·관리하며, 등목 전 나무 및 작업현장에 대한 위험요소를 조사·파악하여 작업계획을 수립한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 힘든 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|손사용|시각|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"수목관리사","dJobECd":"9031","dJobECdNm":"[9031]조림∙산림경영인 및 벌목원","dJobJCd":"6201","dJobJCdNm":"[6201]조림·산림경영인 및 벌목원","dJobICd":"A020","dJobICdNm":"[A020]임업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004875:1', '{"dJobCd":"K000004875","dJobCdSeq":"1","dJobNm":"양묘관리원","workSum":"우량한 산림수목 생산을 위하여 산림묘포 상의 각종 묘목을 보호하고 관리하는 작업원의 활동을 관리·감독한다.","doWork":"각종 묘포사업장에서 종자의 정선, 매장, 발아촉진, 묘포의 경운, 묘포 경영에 필요한 자재 구입 등을 한다. 간단한 시설의 설계, 농약, 비료, 파종, 볕가림, 제초, 솎기, 삽목(꺾꽂이), 접목(나무를 접붙임) 등 묘포사업 전반에 걸쳐 기술적인 실무를 담당하고 관리한다. 관련 작업원의 활동을 관리·감독한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|","workFunc1":"조정","workFunc2":"감독","workFunc3":"수동조작","dJobECd":"9031","dJobECdNm":"[9031]조림∙산림경영인 및 벌목원","dJobJCd":"6201","dJobJCdNm":"[6201]조림·산림경영인 및 벌목원","dJobICd":"A020","dJobICdNm":"[A020]임업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006136:1', '{"dJobCd":"K000006136","dJobCdSeq":"1","dJobNm":"원목검척원","workSum":"벌채지에서 생산된 가공되기 전 목재(즉, 원목)를 집재지, 중간재재장, 저목장 등에서 반출 전 줄자나 윤척을 사용하여 측정한다.","doWork":"측정자, 줄자 및 기타 측정장치 등으로 각 원목의 크기와 펄프용 목재의 전체 적하를 측정한다. 원목이나 펄프용 목재에서 부패 및 기타 결함을 조사하고, 총부피에서 견적된 폐물을 빼고 결과를 기록한다. 선적인에게 반송을 위하여 표준 이하나 특별한 등급의 원목을 확인하고 분류한다. 하역 전·후 나무의 부피를 측정, 부피 데이터와 공급자를 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"시각|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"벌목검척원, 임목검척원","dJobECd":"9031","dJobECdNm":"[9031]조림∙산림경영인 및 벌목원","dJobJCd":"6201","dJobJCdNm":"[6201]조림·산림경영인 및 벌목원","dJobICd":"A020","dJobICdNm":"[A020]임업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006506:1', '{"dJobCd":"K000006506","dJobCdSeq":"1","dJobNm":"원목등급원","workSum":"산림 내의 벌목장, 집재지, 저장소에서 원목의 상태를 판별하여 등급을 매긴다.","doWork":"측정자, 강철줄자, 측정보조기 등을 사용하여 원목 길이와 직경을 재어 재적환산표를 보고 전체 용적을 계산한다. 건습도, 갈라진 흠, 썩은 부위, 비틀림, 휨 등의 결함을 확인하기 위하여 측정기로 원목을 찌르거나 육안으로 검사한다. 원목등급표의 기준에 따라 원목의 특성을 평가하고 등급을 결정한다. 나무 전체 부피에서 폐기목재 부피를 측정하여 빼고 기록부에 등급에 따라 부피를 기록한다. 등급과 나무종류를 확인하기 위하여 원목표피에 페인트분무기로 분류를 표시하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"시각|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"통나무등급원","dJobECd":"9031","dJobECdNm":"[9031]조림∙산림경영인 및 벌목원","dJobJCd":"6201","dJobJCdNm":"[6201]조림·산림경영인 및 벌목원","dJobICd":"A020","dJobICdNm":"[A020]임업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003080:1', '{"dJobCd":"K000003080","dJobCdSeq":"1","dJobNm":"원목분류원","workSum":"목재소유주의 지시에 따라 나무종류와 크기별로 원목을 분류한다.","doWork":"벌목장에서 조재된 원목을 집재시키기 위하여 나무의 종류와 크기에 따라 분류한다. 분류된 원목별로 집재장소에 옮겨 적재한다. 분류된 원목에 철인을 찍어 분류표시를 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"통나무분류원","dJobECd":"9031","dJobECdNm":"[9031]조림∙산림경영인 및 벌목원","dJobJCd":"6201","dJobJCdNm":"[6201]조림·산림경영인 및 벌목원","dJobICd":"A020","dJobICdNm":"[A020]임업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005181:1', '{"dJobCd":"K000005181","dJobCdSeq":"1","dJobNm":"원목운반원","workSum":"원목을 운반용구를 이용하여 일정 지역에 운반 및 적재한다.","doWork":"원목을 운반하여 쌓을 장소의 지세를 조사하고 집재장소를 설정한다. 동력톱이나 기타 도구를 사용하여 운송할 원목의 가지나 마디를 정리한다. 운반하고자 하는 원목을 집게, 체인, 케이블, 강철 끈 등을 사용하여 묶는다. 목재를 끌기에 용이하도록 길 위에 가로목을 깐다. 묶어진 원목을 가로목 위에 올려놓고 밀거나 앞에서 끌어 토장까지 운반한다. 설정된 집재장소와 운반거리에 따라 트럭이나 철도화물차량 등을 이용하여 운반한다. 작업지시서의 집재방법에 따라 넘어지지 않도록 일정 높이로 쌓는다. 원목을 하나씩 어깨에 메어 운반하기도 하고 겨울에는 적설을 이용하여 운반하기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"운재원, 통나무운반원","connectJob":"통나무적재원, 통나무집재원","dJobECd":"9031","dJobECdNm":"[9031]조림∙산림경영인 및 벌목원","dJobJCd":"6201","dJobJCdNm":"[6201]조림·산림경영인 및 벌목원","dJobICd":"A020","dJobICdNm":"[A020]임업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005761:1', '{"dJobCd":"K000005761","dJobCdSeq":"1","dJobNm":"임업기계장비조작원","workSum":"목재수확지에서 나무를 자르거나 목재를 운반하기 위하여 임업기계장비(체인톱 등), 임업기계차량(하베스터, 포워더 등) 기타 장비 등을 조작한다.","doWork":"임업기계장비를 작동하는 데 필요한 각종 기계의 이상 유무를 점검하고 관리하며 사용연료를 연료통에 채운다. 임업기계장비의 가동상태, 마모상태를 점검하고 장비를 손질한다. 목재수확을하고자 하는 임지로 장비를 휴대 또는 운전하여 이동한다. 임업기계장비를 사용하여 나무를 베고, 가지를 자르거나 원목의 껍질을 제거하고 수송하기에 편리한 임지, 임도변, 적재지로 운반하여 원목을 적재한다. 제거된 가지나 껍질을 일정한 곳에 정리한다. 목재수확에 필요한 각종 도구와 장비를 정비·보수·보관·관리하기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"힘든 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","certLic":"산림기능사","dJobECd":"9031","dJobECdNm":"[9031]조림∙산림경영인 및 벌목원","dJobJCd":"6201","dJobJCdNm":"[6201]조림·산림경영인 및 벌목원","dJobICd":"A020","dJobICdNm":"[A020]임업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004880:1', '{"dJobCd":"K000004880","dJobCdSeq":"1","dJobNm":"조림관리원","workSum":"묘목을 생산하여 산지에 식재하거나 기존 천연림을 보육 관리하고 일정 면적당 적정 밀도를 유지시켜 우량한 목재가 생산되도록 관리한다.","doWork":"채종림 또는 우량 모수를 조사하여 선정하고 익년도 파종을 위한 건전한 종자를 성숙기에 채취한 후, 탈각(껍질을 벗김)시켜 정선하고 종자의 종류에 따라 건조한다. 채취한 종자를 소독하고 파종 및 익년도에 이식하여 간인(솎아베기), 시비, 관수, 약제살포, 제초 등의 작업으로 적정 기준 규격의 묘목을 생산한다. 조림대상지를 선정하고 지형 및 식재대상 수종에 맞도록 대상지의 잡목을 전면 제거 또는 줄베기 등의 방법으로 정리한다. 묘포장에서 생산된 묘목을 선별 포장한다. 식재지까지 운반하여 사질양토로 배수가 잘되는 지역을 선정하고 수량파악이 용이하도록 고랑을 파고 뿌리를 펴서 가식하고 묘목이 건조하지 않도록 관수 등의 조치를 취한다. 식재 예정지의 여건을 조사하여 알맞은 수종을 선정한다. 식수 적기에 단위 면적당 적정 본수를 일정 간격을 유지하며 구덩이를 파고 묘목을 심는다. 천연림에서 형질이 우수한 수확 대상목을 선정하고 대상목에 피해를 주는 방해목, 불량병해충목, 덩쿨류 등을 제거한다. 가지치기 등을 실시하여 우량 목재가 생산되도록 관리한다. 벌채 시 종자를 퍼뜨릴 수 있는 모수를 적정 간격으로 남겨두어 종자가 임지에 고루 떨어질 수 있도록 하고 땅에 떨어진 종자의 발아가 잘 되도록 잡목이나 관목을 베어 주거나 표토를 긁어 주기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"수동조작","dJobECd":"9031","dJobECdNm":"[9031]조림∙산림경영인 및 벌목원","dJobJCd":"6201","dJobJCdNm":"[6201]조림·산림경영인 및 벌목원","dJobICd":"A020","dJobICdNm":"[A020]임업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007146:1', '{"dJobCd":"K000007146","dJobCdSeq":"1","dJobNm":"조림작업원","workSum":"산림지역에 묘목을 심는 등의 조림 및 관리에 필요한 제반 작업을 수행한다.","doWork":"괭이, 삽을 이용하여 산림지역에 묘목을 심는다. 톱, 낫 등의 도구를 사용하여 병들거나 약한 나무를 잘라낸다. 산림 내에 산불이 발생하면 화재를 진압하기 위하여 톱, 삽 등을 사용하여 나무를 베거나 화재 분기점에서 잡목림을 제거하고, 불꽃과 타다 남은 찌꺼기를 제거하여 진화한다. 도끼, 곡괭이, 낫을 사용하여 도로변, 화재진압지역, 야영지역 등과 기타 산림 시설물 주위에 있는 잡목림, 나뭇가지 또는 부스러기를 제거한다. 수동이나 동력 분무기 또는 수목 분사 급수기를 사용하여 나무나 덤불 및 잡초에 제초제를 뿌린다. 산림 시설물 주위에 말뚝, 구멍 파는 도구, 삽, 시멘트를 다져 넣는 도구 및 기타 수동공구를 사용하여 표적과 울타리 등을 설치한다. 측량줄자 또는 윤척 등을 사용하여 산림 측정을 보조하기도 하고 산림이 병충해 피해를 입었을 때는 약제를 살포하기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","dJobECd":"9031","dJobECdNm":"[9031]조림∙산림경영인 및 벌목원","dJobJCd":"6201","dJobJCdNm":"[6201]조림·산림경영인 및 벌목원","dJobICd":"A020","dJobICdNm":"[A020]임업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005428:1', '{"dJobCd":"K000005428","dJobCdSeq":"1","dJobNm":"목초액제조설비운전원","workSum":"톱밥제조기를 조작하여 톱밥과 숯을 만들고 숯을 정제하여 목초액을 만든다.","doWork":"톱밥제조기를 작동한다. 목재로 사용이 불가능한 죽데기(제재하고 남은 찌꺼기)를 손으로 톱밥제조기에 투입한다. 분쇄된 톱밥이 컨베이어 벨트를 따라 자동으로 사일로에 저장되는지 감시한다. 톱밥제조기가 불순물에 걸려서 작동이 멈추면 불순물을 제거하는 등 기계를 정비한다. 사일로에 저장된 톱밥을 보일러(가마)에 투입하여 숯을 만들고 이 과정에서 발생하는 연기를 채집, 냉각하여 목초액을 생산한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"약간의 시범정도","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"손사용|","workEnv":"대기환경미흡|위험내재|고온|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"9039","dJobECdNm":"[9039]임산물 채취 및 기타 임업 종사원","dJobJCd":"6209","dJobJCdNm":"[6209]임산물 채취 및 기타 임업 관련 종사원","dJobICd":"C201","dJobICdNm":"[C201]기초 화학물질 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006180:1', '{"dJobCd":"K000006180","dJobCdSeq":"1","dJobNm":"임목종자채취원","workSum":"임목종자의 성숙시기를 관찰하여 우량한 종자를 수집하고 채취한다.","doWork":"임야지를 걸어 순시하며, 우량 수종을 선별한다. 임목종자를 채취하기 위하여 나무에 직접 올라가거나 나무 밑에서 사다리 등을 사용하여 종자를 따고, 우량한 종자를 선별하여 분리한다. 채취한 종자 중 구과, 장과를 제외한 종자는 건조시키거나, 절구에 넣어 부수거나, 음지에 묻어 썩혀서 종자를 정선한다. 정선된 종자는 각 종자의 특성에 따라 저장고, 노천매장 또는 직접 파종하는 등의 사후관리를 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"단순작업","similarNm":"종자수집원, 종자채취원","dJobECd":"9039","dJobECdNm":"[9039]임산물 채취 및 기타 임업 종사원","dJobJCd":"6209","dJobJCdNm":"[6209]임산물 채취 및 기타 임업 관련 종사원","dJobICd":"A020","dJobICdNm":"[A020]임업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004246:1', '{"dJobCd":"K000004246","dJobCdSeq":"1","dJobNm":"임산물채취원","workSum":"전정가위, 칼, 삽이나 손 또는 수동공구로 산림 내에서 장식용 푸른 잎, 약용초목과 껍질, 나무솔방울, 이끼 또는 버섯을 채취·수집한다.","doWork":"임산물 채취시기에 산림을 순찰하며 각종 임산물을 손이나 수동공구로 채집한다. 구과나 가지 등을 따기 위하여 등산용 벨트와 등산용 구두집(아이젠)을 이용하여 나무에 올라가서 손으로 수집하고자 하는 임산물을 딴다. 수집한 각종 임산물을 크기 또는 종류별로 분류하여 꾸러미로 묶거나 포장하여 구매인에게 판매한다. 임산물의 가격이나 수요량 등을 파악하고, 임산물이 산재하고 있는 산지를 조사하기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","connectJob":"수액채취원, 수피채취원, 심마니, 약초채취원, 버섯채취원","dJobECd":"9039","dJobECdNm":"[9039]임산물 채취 및 기타 임업 종사원","dJobJCd":"6209","dJobJCdNm":"[6209]임산물 채취 및 기타 임업 관련 종사원","dJobICd":"A020","dJobICdNm":"[A020]임업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005544:1', '{"dJobCd":"K000005544","dJobCdSeq":"1","dJobNm":"관상어관리사","workSum":"관상어의 종류별 특성을 파악하고 관상어를 사육 및 관리하고 조언한다.","doWork":"바다고기와 민물고기별 어종 차이와 생태 및 습성에 맞춰 환경을 조성하고 먹이관리를 한다. 관상어별 사료의 종류와 특성을 숙지하고 관상어의 몸 상태, 색상 표현 등을 관찰하여 영양공급 상태를 파악하고 영양 및 색상발현 등에 적당한 사료를 조언하고 제공한다. 어항, 여과장치 등 관상어 사육 시설을 관리하고 운용한다. 관상어를 번식시키기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"다습|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"관상어종관리사","dJobECd":"9041","dJobECdNm":"[9041]양식원","dJobJCd":"6301","dJobJCdNm":"[6301]양식원","dJobICd":"A032","dJobICdNm":"[A032]양식어업 및 어업관련 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002000:1', '{"dJobCd":"K000002000","dJobCdSeq":"1","dJobNm":"양식장관리원","workSum":"양식을 위한 기획 및 활동을 하고 양식장 시설물을 관리하는 양식장 작업원의 활동을 감독·조정한다.","doWork":"양식장의 시설물이나 양식 대상물의 관리계획, 플랑크톤이나 배합사료 등의 먹이수급계획, 양식물 채취 및 시설물 안전관리계획 등을 수립하기 위하여 양식어업자와 협의한다. 양식장작업원을 지휘·감독한다. 각종 병해의 예방이나 성장조건을 알맞게 조절하기 위하여 수온계, 비중계, 투명도판 등을 사용하여 양식어장의 상태를 확인한다. 각종 병해를 수시로 진단하여 치료 또는 구제한다. 양식물의 성장상태를 확인하고, 일정 기간 양식 후 양식장작업원을 지휘하여 양식물을 채취한다. 작업일지를 기록하고 관리한다. 양식장의 상태를 확인하고 양식장작업원을 지휘·감독하여 양식장 내를 청소하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|저온|다습|","workFunc1":"조정","workFunc2":"감독","workFunc3":"수동조작","connectJob":"가물치양식장관리기사, 게양식장관리기사, 광어양식장관리기사, 메기양식장관리기사, 미꾸라지양식장관리기사, 새우양식장관리기사, 송어양식장관리기사, 잉어양식장관리기사, 장어양식장관리기사, 향어양식장관리기사, 굴양식장관리기사, 조개양식장관리기사, 진주조개양식장관리기사, 김양식장관리기사, 다시마양식장관리기사, 미역양식장관리기사","dJobECd":"9041","dJobECdNm":"[9041]양식원","dJobJCd":"6301","dJobJCdNm":"[6301]양식원","dJobICd":"A032","dJobICdNm":"[A032]양식어업 및 어업관련 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005190:1', '{"dJobCd":"K000005190","dJobCdSeq":"1","dJobNm":"양식장작업원","workSum":"어류, 패류, 해조류 양식장에서 시설물을 설치하거나 먹이를 주고 양식물을 채취한다.","doWork":"양식어업자 또는 양식장관리원의 지휘, 감독 하에 양식시설 및 구역표시를 하고 종묘를 양식장에 넣는다. 먹이수급계획에 따라 먹이를 공급하고 양식장을 관찰하여 양식물의 성장상태, 각종 병충해, 해상의 변화를 수시로 검사하여 양식장관리원에게 보고한다. 양식장의 시설물 및 장비를 청소하고 이동시킨다. 양식장 바닥의 산성화, 노화방지를 위하여 선박을 이용하거나 잠수하여 밑을 간다. 채취선, 채취기구를 사용하여 양식물을 채취한다. 양식물을 판매하기 위하여 세척·분류하고, 껍질을 벗기거나 삶아 말리고 포장한다. 도난방지를 위하여 경비를 선다. 태풍 등으로 시설물이 파괴되면 보수한다. 양식이 끝난 시설물을 철거하여 보수·정비한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|저온|다습|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"양식인부","connectJob":"종묘생산작업원, 가물치양식장작업원, 게양식장작업원, 광어양식장작업원, 메기양식장작업원, 미꾸라지양식장작업원, 새우양식장작업원,송어양식장작업원, 잉어양식장작업원, 장어양식장작업원, 향어양식장작업원 , 굴양식장작업원, 조개양식장작업원, 진주조개양식장작업원, 김양식장작업원, 다시마양식장작업원, 미역양식장작업원","dJobECd":"9041","dJobECdNm":"[9041]양식원","dJobJCd":"6301","dJobJCdNm":"[6301]양식원","dJobICd":"A032","dJobICdNm":"[A032]양식어업 및 어업관련 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005733:1', '{"dJobCd":"K000005733","dJobCdSeq":"1","dJobNm":"어류사육사","workSum":"수족관의 산소농도, 온도 등을 조절하여 해수어, 담수어 등의 어류 및 거북이 등의 파충류 등을 사육·관리한다.","doWork":"사육하는 어종별로 습성, 먹이 등의 생태 환경을 점검하여 영양과 식성에 따라 먹이를 관리한다. 수조의 수질, 온도, 산소의 농도 등을 조절하여 생활에 적합한 환경을 조성한다. 어류의 활동 및 외형을 관찰하여 질병을 확인하고 질병의 종류에 따라 적당한 약품을 투입한다. 치어의 먹이를 확보하기 위하여 플랑크톤을 배양한다. 해양의 수질을 조사하여 급수의 적정 여부를 판단하고 차량으로 해수를 공급한다. 각종 어류의 사육방법 및 질병예방에 관련된 자료 및 실험결과를 정리하여 보고 자료를 작성한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"다습|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"수동조작","dJobECd":"9041","dJobECdNm":"[9041]양식원","dJobJCd":"6301","dJobJCdNm":"[6301]양식원","dJobICd":"R902","dJobICdNm":"[R902]도서관, 사적지 및 유사 여가관련 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002506:1', '{"dJobCd":"K000002506","dJobCdSeq":"1","dJobNm":"봉수망어선원","workSum":"불빛을 좋아하는 습성을 가진 꽁치 등의 어류를 봉수망으로 유인하여 물고기를 잡는다.","doWork":"출어 전, 선장 또는 갑판장의 지휘, 감독 하에 봉수망(가운데가 오목한 보자기 모양의 그물) 및 전등, 어구, 윈치(Winch:로프를 원통에 감아올려 중량물을 끌어올리거나 도르래를 끼워 매다는 기중기의 일종), 부상기, 닻 등 각종 어로장비를 수선·정비하고 선체를 보수한다. 선장의 지시에 따라 항해 중 조타실에서 당직을 수행하며, 안개, 비바람 등의 기상조건 악화 시에는 선박의 선수, 선미에서 망보기(견시)를 한다. 조업수역에 도착하면 배의 양옆에 설치된 전등의 불을 켠다. 선박의 속도에 맞추어 그물을 내린다. 일정 시간이 지나 어류가 모이면 포획하기 위하여 그물이 설치된 반대편의 전등을 끄고 그물이 위치한 곳으로 모이게 한다. 포획할 물고기가 모이면 그물을 들어올린다. 포획된 어류를 선상 위로 끌어올려 잡힌 어획물을 꺼낸다. 어획물을 분류하여 상자에 얼음과 함께 넣어 저장실에 저장한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|저온|다습|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"어부, 어선원","dJobECd":"9042","dJobECdNm":"[9042]어부 및 해녀","dJobJCd":"6302","dJobJCdNm":"[6302]어부 및 해녀","dJobICd":"A031","dJobICdNm":"[A031]어로 어업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006808:1', '{"dJobCd":"K000006808","dJobCdSeq":"1","dJobNm":"선망어선원","workSum":"선망(旋網:Surrounding Net, 두릿그물)을 사용하여 고등어, 다랑어 등의 물고기를 잡는다.","doWork":"출어 전, 선장 또는 어로장의 지휘, 감독 아래 선망(기다란 사각형의 그물로 어군을 둘러싼 후 그물의 아랫자락을 죄여서 어군이 도피하지 못하도록 하여 어획하는 데 사용하는 그물) 및 부자, 침자, 보조망사, 로프, 링 등의 어구를 수선·정비하고 선체를 보수한다. 선장의 지시에 따라 항해 중 조타실에서 당직을 수행하며, 안개, 비바람 등의 기상 조건악화 시에는 선박의 선수, 선미에서 망보기(견시)를 한다. 조업수역에 도착하여 어군이 탐지되면 어로장 또는 선장의 지휘 아래 선망 및 어구를 갑판에 정리·배열하고 신호에 따라 윈치(Winch:로프를 원통에 감아올려 중량물을 끌어올리거나 도르래를 끼워 매다는 기중기의 일종) 또는 투망기를 사용하여 투망을 한다. 주선 또는 부선이 재빨리 어군을 둘러싸 망을 조임으로써 어류를 포획하면 앞치마를 두르고 양승(끌어올림) 준비를 한다. 신호에 따라 날개그물을 양망기로 끌어올려 자루그물에 고기가 모이게 되면 데릭(Derrick:원동기를 별도로 설치하여 와이어로프를 조작하여 하역 작업을 하는 크레인의 일종) 및 반두그물을 사용하여 운반선에 고기를 떠 올린 후 자루그물은 본선에서 인력으로 끌어올린다. 운반선의 어창에 어획물을 얼음과 혼합하여 저장한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|저온|다습|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"어부, 선원","connectJob":"대형선망어선원, 건착망어선원","dJobECd":"9042","dJobECdNm":"[9042]어부 및 해녀","dJobJCd":"6302","dJobJCdNm":"[6302]어부 및 해녀","dJobICd":"A031","dJobICdNm":"[A031]어로 어업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002177:1', '{"dJobCd":"K000002177","dJobCdSeq":"1","dJobNm":"어로장","workSum":"선단조업 시 어선원의 활동 및 어로 작업을 총괄 지휘·감독한다.","doWork":"출어 전 선주와 협의하여 어선원을 고용하고, 선단을 구성한다. 어선원을 지휘·감독하여 어구를 설계·제작·보수하고 선박을 정비한다. 어황 정보를 수집하거나 경험을 토대로 어장을 선정하고 출어시기를 결정한다. 어선원을 배치하고 선박, 장비, 인원 등의 출어점검을 한다. 어군탐지선에 승선하여 어군탐지기를 조작, 어장형성이 예측된 부근해역에서 어군탐색을 실시한다. 어군이 탐색되면 경제성을 고려하여 어망 투망 여부를 결정하고 무전기로 선단소속 선박을 호출한다. 어군을 포획하기 위하여 무전기 또는 수기신호로 선박 및 어선원을 지휘하여 본선 또는 부속선을 이용하여 어망(어구)을 투망한다. 어군탐지기에 표시되는 수심 및 암초 등의 해저상황을 판단하여 어망(어구)의 예인 방향을 지시한다. 어군을 포획하면 양망(揚網:친 그물을 걷어 올림)작업을 지휘하여 어획물을 운반선(가공선)에 넣는다. 일몰 시간이 되면 어로작업을 중지하고 선단을 지휘하여 귀항한다. 어획고를 확인하여 선주에게 알린다. 다른 선단과 어획정보를 교환하여 다음의 어로작업을 준비한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|저온|다습|","workFunc1":"조정","workFunc2":"감독","workFunc3":"수동조작","dJobECd":"9042","dJobECdNm":"[9042]어부 및 해녀","dJobJCd":"6302","dJobJCdNm":"[6302]어부 및 해녀","dJobICd":"A031","dJobICdNm":"[A031]어로 어업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005560:1', '{"dJobCd":"K000005560","dJobCdSeq":"1","dJobNm":"어업잠수부","workSum":"잠수복, 수중호흡기를 착용하거나 공기주입선이 달려있는 수중복을 착용하고 해저에서 해면, 전복, 해삼, 성게 등의 패류, 해조류를 채취한다.","doWork":"투구, 잠수복, 컴프레서 등의 잠수장비를 정비하고 점검한다. 어장에 도착하면 잠수기어선원의 보조를 받으며 잠수복, 잠수호스, 철재 및 고무신발, 납, 철재투구를 착용하고 공기압축기(컴프레서)가 작동되면 공기주입이 잘 되는지 확인한다. 물속으로 잠수하여 갈고리, 막대기 등으로 소라, 전복, 해삼, 굴, 홍합 등을 채취하여 망태에 담는다. 망태가 차면 선박과 연결된 신호로프 또는 유선전화기로 신호를 보내 채취한 것을 올려 보낸다. 해저의 오물을 수거하거나 사고현장을 탐사하여 시신이나 기타 기물을 물 밖으로 끌어올리기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실외","physicalAct":"균형감각|손사용|","workEnv":"대기환경미흡|위험내재|저온|다습|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"나잠원, 머구리","connectJob":"해녀","dJobECd":"9042","dJobECdNm":"[9042]어부 및 해녀","dJobJCd":"6302","dJobJCdNm":"[6302]어부 및 해녀","dJobICd":"A031","dJobICdNm":"[A031]어로 어업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003532:1', '{"dJobCd":"K000003532","dJobCdSeq":"1","dJobNm":"연승어선원","workSum":"여러 개의 낚시를 매달은 낚싯줄(연승, 주낙)을 얼레에 감아 물살을 따라서 감기와 풀기를 반복하여 고기를 잡는다.","doWork":"출어 전, 선장 또는 갑판장의 지휘, 감독 아래 주낙 및 각종 어로장비를 수선·정비하고 선체를 보수한다. 항해 중 조타실에서 당직을 수행하며 안개, 비바람 등 기상조건 악화 시에는 선박의 선수, 선미에서 망보기(견시)를 한다. 지정된 조업수역에 도착하면 갑판에 주낙 및 부표, 밧줄, 낚시밥(미끼) 등을 준비하고 배열을 한 다음 미리 준비해 온 낚시밥(미끼)을 낚시에 매단다. 미끼달기 작업이 끝나면 주로 중층 및 저서성(底棲性:바다 밑바닥에서 기어 다니거나 고착하는 특성) 어류를 포획하기 위하여 선장의 지휘 아래 투망을 하여 일정한 수심에 주낙을 설치한다. 일정 시간 후 먼저 설치한 주낙부터 인력 또는 윈치(Winch:로프를 원통에 감아올려 중량물을 끌어올리거나 도르래를 끼워 매다는 기중기의 일종)를 사용하여 갑판 선상에 끌어올려 잡힌 어류를 낚시에서 분류한다. 재 투망할 수 있도록 주낙 바퀴 또는 통에 주낙을 정리한다. 포획한 어류를 얼음 등으로 냉장 처리한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|저온|다습|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"주낙어선원, 어부, 선원","dJobECd":"9042","dJobECdNm":"[9042]어부 및 해녀","dJobJCd":"6302","dJobJCdNm":"[6302]어부 및 해녀","dJobICd":"A031","dJobICdNm":"[A031]어로 어업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003711:1', '{"dJobCd":"K000003711","dJobCdSeq":"1","dJobNm":"인망어선원","workSum":"원추형 또는 원통형 자루 모양의 어망(인망, 끌그물)을 수평방향으로 이동시켜 어군을 인망으로 유인하여 포획한다.","doWork":"출어 전, 선장 또는 갑판장의 지휘, 감독 아래 각종 어망, 권양기, 윈치 등 어로장비를 수선·정비하고 선체를 보수한다. 항해 중 조타실에서 항해당직을 수행하며 안개, 비바람 등 기상조건 악화 시에는 망원경을 사용하여 선박의 선수, 선미에서 망보기(견시)를 한다. 조업수역에 도착하면 갑판에 어망을 배열하여 투망준비를 하고, 어군이 탐지되면 선장 또는 어로장의 지휘에 따라 윈치(Winch:로프를 원통에 감아올려 중량물을 끌어올리거나 도르래를 끼워 매다는 기중기의 일종) 또는 투망기 등을 사용하여 투망을 한다. 심층의 어류가 인망 속으로 유인되어 포획되면 권양기를 조작하여 어망을 선상에 끌어올린다. 어획물을 분류하고 선별하여 상자에 넣어 냉장·냉동실로 운반하거나 또는 가공처리를 위해 가공실로 운반하고 처리한다. 재 투망하기 위하여 어망 및 어구를 갑판 위에 배열한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|저온|다습|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"어부, 선원","connectJob":"기선권현망어선원, 수조망어선원, 저인망어선원, 형망어선원","dJobECd":"9042","dJobECdNm":"[9042]어부 및 해녀","dJobJCd":"6302","dJobJCdNm":"[6302]어부 및 해녀","dJobICd":"A031","dJobICdNm":"[A031]어로 어업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003283:1', '{"dJobCd":"K000003283","dJobCdSeq":"1","dJobNm":"자망어선원","workSum":"어류의 회유로(回遊路)에 자망을 설치하여 물고기를 잡는다.","doWork":"출어 전, 선장 또는 갑판장의 지휘, 감독 아래 자망(어획 대상 물고기의 몸 둘레보다 작은 입구를 한 그물) 및 어구(부표, 부자, 침자, 표시등)를 수선하고 선체를 보수한다. 항해 중 조타실에서 당직을 수행한다. 안개, 비바람 등 기상조건 악화 시에는 선박의 선수, 선미에서 견시(망보기)를 한다. 일몰 전 조업수역에 도착하면 자망을 갑판에 배열하여 필요한 길이로 연결하여 투망 준비를 한다. 어군이 탐색되면 선장의 지휘에 따라 풍향에 따라 후진하면서 어군의 진행 방향을 추정하여 투망을 한다. 투망이 끝나면 망의 한끝을 배에 묶어 그물과 함께 표류하고 표시등을 달아 그물의 이상 유무를 확인한다. 일정 시간 경과 후 어류가 포획되면 윈치(Winch:로프를 원통에 감아올려 중량물을 끌어올리거나 도르래를 끼워 매다는 기중기의 일종) 또는 인력으로 자망을 갑판 위로 끌어 올린다. 꽁치, 멸치, 명태 등을 대상으로 하는 자망어업은 어획물을 그물과 함께 실어 귀항 후 그물과 어획물을 분리·정돈한다. 조기, 삼치 등을 대상으로 하는 자망어업은 갑판에서 직접 분류하여 소금, 얼음 등으로 저장·처리한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|저온|다습|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"어부, 선원","connectJob":"유망어선원, 유자망어선원, 저자망어선원","dJobECd":"9042","dJobECdNm":"[9042]어부 및 해녀","dJobJCd":"6302","dJobJCdNm":"[6302]어부 및 해녀","dJobICd":"A031","dJobICdNm":"[A031]어로 어업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005527:1', '{"dJobCd":"K000005527","dJobCdSeq":"1","dJobNm":"잠수기어선원","workSum":"잠수부를 보조하여 패류, 해조류를 채취한다.","doWork":"잠수부를 도와 공기압축기, 투구, 잠수호스 등 잠수장비를 정비하고 점검한다. 어장에 도착하면 잠수부를 보조하여 투구, 잠수복, 신발 등의 잠수장비 착용을 돕고 수중잠수를 보조한다. 공기압축기(컴프레서)를 조작하여 잠수부에게 공기를 제공하고 압력을 일정하게 유지하기 위하여 압력계를 관찰한다. 신호로프 또는 유선전화기를 통해 신호가 오면 채취 망태를 끌어올려 채취물을 분류하고 상자나 통에 저장한다. 수중에 있는 잠수부와 변동사항이나 작업상황을 신호로프나 유선전화기로 연락한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|저온|다습|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","dJobECd":"9042","dJobECdNm":"[9042]어부 및 해녀","dJobJCd":"6302","dJobJCdNm":"[6302]어부 및 해녀","dJobICd":"A031","dJobICdNm":"[A031]어로 어업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003368:1', '{"dJobCd":"K000003368","dJobCdSeq":"1","dJobNm":"정치망어선원","workSum":"어장의 일정한 장소에 정치망을 일정 기간 설치하여 어망에 들어온 물고기를 잡는다.","doWork":"출어 전, 선장 또는 갑판장의 지휘, 감독 아래 각종 정치망 및 어구장비를 수선·정비하고 선체를 보수한다. 항해 중 조타실에서 당직을 수행하며 안개, 비바람 등의 기상조건 악화 시에는 선박의 선수, 선미에서 망보기(견시)를 한다. 조업수역에 도착하면 갑판에 정치망(定置網:자루 모양의 그물에 테와 깔때기 장치를 한 어구를 어도에 부설하여 대상 생물이 들어가기는 쉬우나 되돌아 나오기 어렵도록 장치한 어구) 및 어구를 준비·배열하여 투망준비를 한다. 선장의 지휘에 따라 먼저 닻, 로프, 부자 등으로 어구의 골격(사개)을 설치한 후, 선체가 조류에 횡직이 되게 조정되면 어포부(예망어구에서 최후에 그물로 고기를 어획하는 부분)부터 망을 투하한다. 투망이 끝나 선체가 조류방향과 일치된 후 일정 시간이 지나면 양망을 준비한다. 선장의 지휘에 따라 조류가 멈춘 순간 선체가 조류에 횡직되게 조정되면 남방줄을 감아 올려 정치망의 수해 및 암해를 측면에 붙이고 어포부를 윈치(Winch:로프를 원통에 감아올려 중량물을 끌어올리거나 도르래를 끼워 매다는 기중기의 일종)로 감아 올려 어획물을 갑판 위로 끌어올린다. 상자, 갈퀴, 얼음 등을 사용하여 포획된 어류를 분류하고 저장 처리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|저온|다습|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"어부, 선원","connectJob":"각망어선원, 건간망어선원, 건망어선원, 낙망어선원, 대모망어선원, 대부망어선원, 소대망어선원, 승망(호망)어선원, 안강망어선원, 주목망어선원","dJobECd":"9042","dJobECdNm":"[9042]어부 및 해녀","dJobJCd":"6302","dJobJCdNm":"[6302]어부 및 해녀","dJobICd":"A031","dJobICdNm":"[A031]어로 어업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002372:1', '{"dJobCd":"K000002372","dJobCdSeq":"1","dJobNm":"채낚기어선원","workSum":"바늘이 없는 낚시 여러 개를 달아맨 낚시줄을 사용하여 오징어 등의 어류를 포획한다.","doWork":"출어 전, 자신의 조상기(긴 낚싯줄을 끌어올리는 자동 장비)와 낚시를 보수한다. 선장의 지시에 따라 선체를 보수하거나 필요한 물품을 운반한다. 항해 중 조타실에서 당직을 수행한다. 안개, 비바람 등 기상조건 악화 시에는 선박의 선수, 선미에서 망보기(견시)를 한다. 조업수역에 도착하면 어선이 조류와 같은 방향으로 일정하게 흘러가도록 선수와 선미에 낙하산형의 물 닻을 수중에 설치하여 어선이 바람 부는 방향으로 흘러가는 것을 방지한다. 어군이 탐지되면 어선선장이 정해준 위치에 앉아 수동조상기 혹은 자동조상기를 설치한다. 야간에 배에 설치된 집어등(어류를 모으는 데 사용하는 등)을 켠다. 낚시가 설치된 조상기를 돌려 새벽까지 오징어를 낚는다. 조업을 마치면 오징어를 상자에 분류·정리하고 얼음을 채워 저장실에 저장한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|저온|다습|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"어부, 선원","connectJob":"원양채낚기어선원, 근해채낚기어선원","dJobECd":"9042","dJobECdNm":"[9042]어부 및 해녀","dJobJCd":"6302","dJobJCdNm":"[6302]어부 및 해녀","dJobICd":"A031","dJobICdNm":"[A031]어로 어업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006653:1', '{"dJobCd":"K000006653","dJobCdSeq":"1","dJobNm":"통발어선원","workSum":"어류가 좋아하는 습성을 이용하거나 또는 미끼로 유인하여 대나무나 그물로 만든 함정(통발)에 빠뜨려 어류를 포획한다.","doWork":"출어 전, 선장 또는 갑판장의 지휘, 감독 아래 통발(또는 단지), 어구, 윈치, 부상기, 닻 등 각종 어로장비를 수선·정비하고 선체를 보수한다. 선장의 지시에 따라 항해 중조타실에서 당직을 수행하며, 안개, 비바람 등의 기상조건 악화 시에는 선박의 선수, 선미에서 망보기(견시)를 한다. 조업수역에 도착하면 줄에 통발을 연결하고 통발 안에 준비한 미끼를 넣고 선장의 지휘에 따라 통발을 수중에 투입하여 설치한다. 통발을 매다는 원줄에 적당한 간격으로 통발을 부착하고 선박의 속도에 맞추어 해저에 투승한다. 통발설치를 표시하는 부표기 또는 부표등(야간)을 주간에는 일정한 간격을 두어 설치하고, 야간에는 어구 한통에 야간부표등을 단다. 물살이 세면 자갈을 군데군데 부착하여 어구의 지나친 요동을 방지한다. 일정 시간이 지나 어류가 포획되면 윈치(Winch:로프를 원통에 감아올려 중량물을 끌어올리거나 도르래를 끼워 매다는 기중기의 일종)를 사용하여 통발을 선상 위로 끌어올려 잡힌 어획물을 꺼낸다. 어획물을 분류하여 상자에 얼음과 함께 넣어 저장실에 저장한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|저온|다습|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"선원, 어부","connectJob":"단지어선원","dJobECd":"9042","dJobECdNm":"[9042]어부 및 해녀","dJobJCd":"6302","dJobJCdNm":"[6302]어부 및 해녀","dJobICd":"A031","dJobICdNm":"[A031]어로 어업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002451:1', '{"dJobCd":"K000002451","dJobCdSeq":"1","dJobNm":"트롤어선원","workSum":"원추형 또는 원통형 자루 모양의 어망(인망, 끌그물)을 수평방향으로 이동시켜 어군을 어망으로 유인하여 포획한다.","doWork":"출어 전, 선장 또는 갑판장의 지휘, 감독 아래 각종 어망, 권양기, 윈치(Winch:로프를 원통에 감아올려 중량물을 끌어올리거나 도르래를 끼워 매다는 기중기의 일종) 등 어로장비를 수선·정비하고 선체를 보수한다. 항해 중 조타실에서 당직을 수행하며 안개, 비바람 등 기상조건악화 시에는 망원경을 사용하여 선박의 선수, 선미에서 망보기(견시)를 한다. 조업수역에 도착하면 갑판에 어망을 배열하여 투망준비를 하고, 어군이 탐지되면 선장 또는 어로장의 지휘에 따라 윈치 또는 투망기 등을 사용하여 투망을 한다. 심층의 어류가 인망 속으로 유인되어 포획되면 권양기를 조작하여 어망을 선상에 끌어올린다. 어획물을 분류하고 선별하여 상자에 넣어 냉장·냉동실로 운반하거나 또는 가공처리를 위해 가공실로 운반하고 처리한다. 재투망하기 위하여 어망 및 어구를 갑판 위에 배열한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|저온|다습|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"트롤선원, 어부, 선원","connectJob":"저인망어선원","dJobECd":"9042","dJobECdNm":"[9042]어부 및 해녀","dJobJCd":"6302","dJobJCdNm":"[6302]어부 및 해녀","dJobICd":"A031","dJobICdNm":"[A031]어로 어업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001376:1', '{"dJobCd":"K000001376","dJobCdSeq":"1","dJobNm":"해녀","workSum":"기계 장치 없이 맨 몸으로 자신의 호흡조절로 바다에 잠수하여 해산물(해조류 및 폐류 등) 등을 채취한다.","doWork":"작업을 위한 도구와 장비, 잠수복 등을 준비한다. 기상 및 해상조건을 살펴 작업여부를 결정한다. 수심 5m~10m까지 잠수하여 해산물(해조류인 미역, 다시마, 폐류인 전복, 성게, 해삼 등) 등을 채취한다. 채취한 해산물과 폐류를 육지로 옮겨 종별로 분류하거나 무게를 잰다. 물질 도구 및 장비, 잠수복 등을 정비하고 손질한다. 상군 해녀들의 경우 기술능력 향상을 위해 중군 및 하군 해녀를 지도한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"힘든 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|시각|","workEnv":"저온|다습|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"나잠","certLic":"나잠필증(해녀증)","dJobECd":"9042","dJobECdNm":"[9042]어부 및 해녀","dJobJCd":"6302","dJobJCdNm":"[6302]어부 및 해녀","dJobICd":"A031","dJobICdNm":"[A031]어로 어업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006759:1', '{"dJobCd":"K000006759","dJobCdSeq":"1","dJobNm":"발효실관리원","workSum":"성형한 빵, 과자 반죽을 발효(Fermentation)하기 위하여 발효실의 온도, 습도를 조작·관리한다.","doWork":"발효실 내부의 온도, 습도 등이 제품 발효에 적당한 조건인지 확인한다. 온도, 습도가 일정하게 유지되도록 발효실을 관리한다. 반죽혼합물이 투입된 용기나 성형된 빵, 과자를 금속판에 올려 발효실로 운반한다. 제품별 입고시간을 기록하여 발효시간을 관리한다. 수시로 발효상태를 점검하고 발효된 제품은 다음 공정으로 운반한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"식품산업기사, 식품가공기능사","dJobECd":"8711","dJobECdNm":"[8711]제과·제빵원","dJobJCd":"7101","dJobJCdNm":"[7101]제빵사 및 제과원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004950:1', '{"dJobCd":"K000004950","dJobCdSeq":"1","dJobNm":"빵성형원","workSum":"제품 표준에 맞는 빵을 만들기 위하여 적당한 크기의 반죽에 속을 넣기도 하면서 일정한 형태로 만든다.","doWork":"컨베이어로 자동 이송되어 온 반죽에 자동충전기(충진기)를 조작하거나 손으로 속(크림, 단팥, 야채 등)을 반죽 위에 일정량 올려놓는다. 속이 채워진 반죽을 자동성형기를 조작하거나 손으로 제품 표준에 맞는 모양으로 만든다. 성형된 제품을 발효실로 운반하고자 금속판 위에 정렬한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"식품산업기사, 식품가공기능사","dJobECd":"8711","dJobECdNm":"[8711]제과·제빵원","dJobJCd":"7101","dJobJCdNm":"[7101]제빵사 및 제과원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003081:1', '{"dJobCd":"K000003081","dJobCdSeq":"1","dJobNm":"제빵반장","workSum":"빵을 제조하고자 원료를 혼합·성형·가열하는 작업원의 활동을 감독·조정한다.","doWork":"생산할 제품의 종류에 따라 원료의 준비상태, 제조기계의 작동상태, 작업장 내 위생상태 등을 확인·검사하고 작업원에게 작업내용을 숙지시킨다. 수시로 각 공정의 견본을 채취하여 가공상태를 점검한다. 작업계획에 따라 세부실행항목을 수립하여 작업절차 및 방법을 결정한 후 작업원이 효율적으로 작업할 수 있도록 적당한 위치에 배정하고 작업내용을 작업원에게 지시한다. 작업진행상황을 파악하고 작업내용을 보고한다. 작업원의 작업상황을 관리·감독하고 작업공정에 있어 필요한 자재지원 및 기술을 지원한다. 표준명세에 따라 지시된 작업이 이루어지는지 작업원과 함께 작업하며 작업상황을 관찰하며 작업내용을 점검한다. 작업원에 대한 직무교육 및 안전위생교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시로 관찰과 면담을 하여 작업원의 애로 및 건의사항을 수렴·해결하고 문제점을 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"고온|다습|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"수동조작","dJobECd":"8711","dJobECdNm":"[8711]제과·제빵원","dJobJCd":"7101","dJobJCdNm":"[7101]제빵사 및 제과원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003624:1', '{"dJobCd":"K000003624","dJobCdSeq":"1","dJobNm":"제빵원","workSum":"빵을 만들기 위해 밀가루, 설탕, 파우더, 계란 등의 원료를 혼합하고 모양을 만들어 오븐에 굽는다.","doWork":"제조할 제품의 종류에 따라 원료를 선별한 후 제품 표준에 맞게 일정 비율로 계량한다. 원료를 혼합기에 투입한 후 혼합이 용이하도록 교반기를 가동한다. 혼합이 완료되면 반죽을 꺼내 작업대 위에 놓고, 일정한 크기로 절단하거나 손이나 형틀을 사용하여 일정 모양으로 성형한 후, 금속판 위에 정렬한다. 오븐의 뚜껑을 열고 금속판을 넣은 후 오븐의 스위치를 조절하여 가열온도를 조절한다. 일정 온도를 유지하기 위해 수시로 관찰·확인한다. 빵이 구워지면 오븐의 가동을 중지하고 제조된 빵을 꺼내 맛, 향, 색상, 형태 등을 점검한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"고온|다습|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"제과제빵사, 파티셰","connectJob":"도넛제조원, 제과원, 파이제조원, 슈가크래프터","certLic":"제빵기능사, 제과기능사","dJobECd":"8711","dJobECdNm":"[8711]제과·제빵원","dJobJCd":"7101","dJobJCdNm":"[7101]제빵사 및 제과원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006077:1', '{"dJobCd":"K000006077","dJobCdSeq":"1","dJobNm":"첨가물제조원","workSum":"제조하고자 하는 빵에 맞는 적당한 당액을 만들거나 빵 속을 채우는 데 필요한 재료를 혼합·조리하는 설비를 조작·관리한다.","doWork":"제조할 첨가물(당액, 속)의 종류에 따라 제품 표준에 맞는 원료를 선별하고 계량용기를 사용하여 계량한다. 계량한 재료(설탕, 초콜릿, 과일 분말, 식용색소, 크림, 팥 등)를 혼합통에 투입하고, 혼합이 용이하도록 교반기를 가동한다. 급수밸브를 조절하여 일정량의 물을 투입하고 견본을 채취하여 농도, 색상, 맛, 향 등을 검사한다. 첨가물의 보존기간에 따라 저장실 혹은 바로 다음 공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"팥소제조원","certLic":"식품산업기사, 식품가공기능사","dJobECd":"8711","dJobECdNm":"[8711]제과·제빵원","dJobJCd":"7101","dJobJCdNm":"[7101]제빵사 및 제과원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001648:1', '{"dJobCd":"K000001648","dJobCdSeq":"1","dJobNm":"케이크장식원","workSum":"종이원통이나 당자루를 사용하여 빵이나 케이크의 표면에 크림, 젤리 등을 장식한다.","doWork":"장식할 모양이나 형태에 따라 종이원통의 배출구에 모형틀을 부착한다. 크림이나 젤리를 주걱을 사용하여 종이원통에 담고 손으로 눌러 빵이나 케이크의 표면에 선, 도형, 꽃 등의 각종 장식을 만든다. 일정한 형태로 미리 제조된 초콜릿, 설탕, 젤리, 과일 등의 장식물을 제품의 표면에 올려놓기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"케이크데커레이터","certLic":"식품산업기사, 식품가공기능사, 제빵기능사, 제과기능사","dJobECd":"8711","dJobECdNm":"[8711]제과·제빵원","dJobJCd":"7101","dJobJCdNm":"[7101]제빵사 및 제과원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002401:1', '{"dJobCd":"K000002401","dJobCdSeq":"1","dJobNm":"강정제조원","workSum":"각종 강정을 만들기 위하여 재료를 세척한 후, 가열·혼합·절단하는 기계를 조작·관리한다.","doWork":"강정의 종류에 따라 사용할 재료(깨, 밥풀, 흑임자, 땅콩, 계피, 잣 등)를 준비한 후, 자동계량기나 저울을 이용해 계량한다. 재료에 섞인 불순물을 골라내고 물로 깨끗이 씻은 후, 물기를 제거한다. 재료를 익히거나 볶는다. 물엿을 일정한 온도가 될 때까지 끓인 후, 재료를 솥이나 혼합 탱크에 넣고 섞는다. 온도를 잘 유지하고 눌러 붙지 않도록 주걱이나 교반기를 이용해 고르게 섞는다. 형틀이나 냉각판에 혼합물을 부은 후 주걱이나 압착판, 또는 손을 사용하여 평평히 누르면서 일정한 두께로 만든다. 냉각이 완료되면 칼이나 절단기를 사용하여 제품규격에 맞게 절단한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|고온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"한식조리기능사","dJobECd":"8712","dJobECdNm":"[8712]떡 제조원","dJobJCd":"7102","dJobJCdNm":"[7102]떡 제조원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007510:1', '{"dJobCd":"K000007510","dJobCdSeq":"1","dJobNm":"떡제조원","workSum":"다양한 종류의 떡, 떡 케이크를 제조하기 위해 떡을 반죽하고 재료를 넣는 기계를 조작·관리한다.","doWork":"제조하려는 떡의 종류(시루떡, 인절미, 경단, 가래떡, 떡 케이크 등)를 파악하고, 필요한 재료를 준비해 저울에 무게를 단다. 준비된 재료를 상자나 통에 넣고 물을 투입해 세척한다. 제조하려는 떡에 맞게 분쇄기의 롤러 간격을 조정하고 호퍼(Hopper)의 배출구를 연 후, 세척한 재료를 투입·분쇄하여 떡 가루를 만든다. 분쇄한 떡 가루와 각종 부재료(소금, 설탕, 첨가물 등)를 반죽통에 투입한 후, 물이나 계란 등을 넣어 적당한 점도를 가지도록 반죽한다. 떡 반죽을 찌기 위하여 찜통에 넣고 밸브를 돌린 후, 조정기를 이용해 찜통의 온도를 올린다. 일정 시간 동안 가열하여 다 쪄진 떡을 성형기나 롤러를 이용해서 고르게 편 후, 소(깨, 설탕 등)를 채우거나 고물을 묻히고 크기에 맞게 절단한다. 이때 제품끼리 붙지 않도록 기름을 바르기도 한다. 떡 케이크를 만들기 위해 케이크 모양으로 만들고 각종 장식을 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"경단제조원, 떡케이크제조원, 시루떡제조원, 오색단자제조원","certLic":"한식조리기능사, 떡제조기능사","dJobECd":"8712","dJobECdNm":"[8712]떡 제조원","dJobJCd":"7102","dJobJCdNm":"[7102]떡 제조원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005610:1', '{"dJobCd":"K000005610","dJobCdSeq":"1","dJobNm":"한과제조원","workSum":"유과(과즐), 약과, 다식, 정과 등의 한과를 제조한다.","doWork":"제조하는 한과의 종류에 따라 밀가루, 찹쌀, 꿀, 깨, 청주, 계핏가루 등 다양한 재료를 사용하여 반죽한다. 종류에 따라 약과는 약과판에 참기름을 바른 뒤 반죽을 찍어 모양을 만들거나 칼로 썰어 모양을 낸다. 유과는 튀김기름에 튀긴 후 기름을 제거한다. 식힌 집청액(한과류의 바탕에 바르는 꿀, 엿 또는 조청 등)을 바르고 찹쌀을 묻힌다. 다식은 다식판에 찍어낸 뒤 참깨, 흑임자, 송화 등 고물을 묻혀 낸다. 완성된 제품을 포장하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|고온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"한식조리기능사","dJobECd":"8712","dJobECdNm":"[8712]떡 제조원","dJobJCd":"7102","dJobJCdNm":"[7102]떡 제조원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004503:1', '{"dJobCd":"K000004503","dJobCdSeq":"1","dJobNm":"가금내장제거원","workSum":"도살된 가금(닭, 오리 등)의 항문주위를 절개하여 내장을 제거한다.","doWork":"컨베이어(Conveyor)에 걸려오는 가금의 항문을 칼로 절개하여 내장을 제거한다. 자동항문절개기의 가동상태를 확인하고, 자동적출기에 의해 내장이 제거되는 과정을 점검한다. 내장이 제거된 가금의 내·외부를 세척한다. 제거한 내장에서 간, 염통, 모이집 등 식용이 가능한 부위를 분류하여 용기에 담기도 한다. 작업장 주위에 쌓인 이물질을 제거하고, 물호스를 사용하여 세척한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|다습|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8721","dJobECdNm":"[8721]정육원 및 도축원","dJobJCd":"7103","dJobJCdNm":"[7103]정육가공원 및 도축원","dJobICd":"C101","dJobICdNm":"[C101]도축, 육류 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002708:1', '{"dJobCd":"K000002708","dJobCdSeq":"1","dJobNm":"가금도살반장","workSum":"닭, 오리 등 가금류를 도살하고 가공하여 포장하는 작업에 종사하는 작업원의 활동을 감독·조정한다.","doWork":"신입 작업원을 교육하고자 가금류를 도살·가공하는 과정을 설명한다. 일일 작업량을 계산하고 가공·처리한 가금류의 수량을 작업일지에 기록한다. 작업내용을 작업원에게 지시·배치한다. 작업진행상황을 파악하고 작업내용을 보고한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원 및 자재를 공급한다. 작업계획에 따라 세부실행항목을 수립하여 작업절차 및 방법을 결정하여 작업원에게 작업내용을 지시하고 작업배치를 한다. 표준명세에 따라 지시된 작업이 이루어지는지 작업원과 함께 작업하며 작업상황을 관찰하고 작업내용을 점검한다. 작업원에 대한 직무교육 및 안전위생교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시 관찰과 면담을 통하여 작업원의 애로 및 건의사항을 수렴·해결하고 문제점을 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|다습|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"수동조작","dJobECd":"8721","dJobECdNm":"[8721]정육원 및 도축원","dJobJCd":"7103","dJobJCdNm":"[7103]정육가공원 및 도축원","dJobICd":"C101","dJobICdNm":"[C101]도축, 육류 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005238:1', '{"dJobCd":"K000005238","dJobCdSeq":"1","dJobNm":"가금도살원","workSum":"식용육 혹은 가공육 등으로 사용하고자 자동체인에 매달린 닭, 오리 등 가금의 목 부위 동맥을 절단하여 도살한다.","doWork":"전살법, CO2가스법 등의 방법을 통해 기절된 상태로 체인에 매달려 이송되는 가금을 관찰한다. 동맥절단기가 가금의 목 부위 경동맥을 절단하여 혈액이 제거되는지 관찰한다. 혈액이 제거된 가금을 다음 공정으로 이송한다. 작업현장을 물로 청소한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","dJobECd":"8721","dJobECdNm":"[8721]정육원 및 도축원","dJobJCd":"7103","dJobJCdNm":"[7103]정육가공원 및 도축원","dJobICd":"C101","dJobICdNm":"[C101]도축, 육류 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001366:1', '{"dJobCd":"K000001366","dJobCdSeq":"1","dJobNm":"가금부위절단원","workSum":"식용육 혹은 가공육 등으로 사용하기 위한 내장이 제거된 닭, 오리 등 가금을 가공할 제품의 종류에 따라 부위별로 절단한다.","doWork":"내장이 제거되고 세척·냉각공정을 거친 가금의 상태를 확인한다. 부위별로 절단하는 칼날을 점검한다. 다리, 날개 등 절단할 부위별로 절단하고자 절단칼날의 간격을 조절하고, 기계를 가동한다. 절단된 각 부위의 견본을 채취하여 중량과 규격을 검사한다. 작업한 수량과 부위별 중량 및 규격을 작업일지에 기록한다. 작업장 주위의 이물질을 제거하고, 물호스를 사용하여 세척한다. 작업이 완료된 부분육을 포장공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8721","dJobECdNm":"[8721]정육원 및 도축원","dJobJCd":"7103","dJobJCdNm":"[7103]정육가공원 및 도축원","dJobICd":"C101","dJobICdNm":"[C101]도축, 육류 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006008:1', '{"dJobCd":"K000006008","dJobCdSeq":"1","dJobNm":"가금분류원","workSum":"식용육 혹은 가공육 등으로 사용하고자 도살·가공된 닭, 오리 등 가금의 외형을 검사하여 식용으로 사용할 수 없는 가금을 분류한다.","doWork":"머리와 다리가 제거되고 내장적출공정을 거쳐 컨베이어에 걸려오는 닭, 오리 등 가금의 외형을 외관품질검사 장비를 사용하여 검사한다. 장비를 모니터링하여 뼈에 금이 가거나 상처 또는 사계(피가 빠지지 않아 붉은 닭)가 있는 닭 등 불량제품을 선별하여 제거한다. 기준에 미달되는 가금은 운반용기에 폐기용과 재가공용으로 분류하여 각 공정으로 운반한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|저온|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8721","dJobECdNm":"[8721]정육원 및 도축원","dJobJCd":"7103","dJobJCdNm":"[7103]정육가공원 및 도축원","dJobICd":"C101","dJobICdNm":"[C101]도축, 육류 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005853:1', '{"dJobCd":"K000005853","dJobCdSeq":"1","dJobNm":"가금육가공원","workSum":"부위별로 가공된 가금육(닭, 오리 등)에 튀김가루를 입혀 기름에 튀기거나 훈제하는 업무를 수행한다.","doWork":"염지공정 및 배합공정을 거친 분쇄육 또는 부위별로 절단된 부분육을 확인한다. 제품에 따라 양념된 분쇄육을 일정한 크기나 모양으로 성형한다. 양념이 스며든 부분육을 훈제실로 운반한다. 일정한 크기나 모양으로 성형한 육류에 튀김가루를 입히는 기계의 이송벨트 위에 올려놓는다. 튀김가루를 입힌 제품을 튀기거나 굽는다. 가공된 육류의 견본을 채취하여 맛, 색깔, 향 등을 점검한다. 가공된 육류의 맛과 신선도를 유지시키기 위하여 급속 냉동시킨다. 제품의 종류에 따라 압력용기에 지육과 양념을 넣어 조리하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8721","dJobECdNm":"[8721]정육원 및 도축원","dJobJCd":"7103","dJobJCdNm":"[7103]정육가공원 및 도축원","dJobICd":"C101","dJobICdNm":"[C101]도축, 육류 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004924:1', '{"dJobCd":"K000004924","dJobCdSeq":"1","dJobNm":"가금육뼈제거원","workSum":"부위별로 절단된 닭, 오리 등 가금육에서 칼을 사용하여 뼈를 제거한다.","doWork":"가공할 제품의 종류에 따라 필요한 부분육을 선별한다. 부분육을 확인하고 금속을 검출하고 잔뼈, 지방, 껍질 등의 이물질을 제거한다. 속살을 칼로 절단하여 통에 담는다. 발라낸 뼈나 연골, 껍질 등은 선별하여 추후공정에 사용할 수 있도록 운반용기에 담는다. 이물질이 제거된 살코기는 가공 또는 포장공정으로 이송한다. 작업장 주위의 이물질을 제거하고 물호스를 사용하여 세척한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|고온|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"닭가공원","dJobECd":"8721","dJobECdNm":"[8721]정육원 및 도축원","dJobJCd":"7103","dJobJCdNm":"[7103]정육가공원 및 도축원","dJobICd":"C101","dJobICdNm":"[C101]도축, 육류 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003245:1', '{"dJobCd":"K000003245","dJobCdSeq":"1","dJobNm":"가축결박원","workSum":"방혈작업을 위하여 기절한 가축을 방혈 컨베이어(Conveyor)로 올린다.","doWork":"타격 및 등골파쇄 작업 후 보정장치나 방혈작업대 위에 기절해 있는 가축의 한쪽 다리에 섀클(Shackle)체인을 감는다. 자연스러운 자세로 섀클체인에 감긴 가축을 들어 올려 방혈컨베이어에 올린다. 컨베이어를 작동시켜 가축을 방혈공정으로 이송한다. 작업한 수량을 작업일지에 기록하고 물호스를 사용하여 작업장 주위를 청소한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|다습|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"가축매걸기원","dJobECd":"8721","dJobECdNm":"[8721]정육원 및 도축원","dJobJCd":"7103","dJobJCdNm":"[7103]정육가공원 및 도축원","dJobICd":"C101","dJobICdNm":"[C101]도축, 육류 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002997:1', '{"dJobCd":"K000002997","dJobCdSeq":"1","dJobNm":"가축계류원","workSum":"가축을 도살하기 전에 이동 중의 스트레스를 최소화하고 휴식 및 안정을 위해 일정 시간 동안 유지·보관시킨다.","doWork":"화물차로 입고된 가축을 종류별 또는 반입된 날짜별로 분류하여 계류(稽留)할 장소를 결정한다. 계류할 장소(계류사)가 있는 통로에 화물차를 정차시킨다. 화물차 위로 올라가 가축을 몰거나 한 마리씩 잡아 계류사에 넣고 문을 닫는다. 사료는 주지 않으나 물은 충분히 제공하며 항생제나 기타 약물을 배출시키기 위하여 일정 시간 동안 계류하여 도살장으로 운반한다. 도살장으로 운반되는 가축의 종류와 수량을 작업일지에 기록한다. 계류사 및 주위장소(또는 어리장)를 물로 청소하거나 소독하기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8721","dJobECdNm":"[8721]정육원 및 도축원","dJobJCd":"7103","dJobJCdNm":"[7103]정육가공원 및 도축원","dJobICd":"C101","dJobICdNm":"[C101]도축, 육류 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003135:1', '{"dJobCd":"K000003135","dJobCdSeq":"1","dJobNm":"가축도살원","workSum":"도축할 가축을 도살처리 기준에 따라 타격법, 전살법 등으로 기절시킨다.","doWork":"도살할 가축에 따라 타격법, 전살법, 총격법, 자격법, CO2가스법 등 다양한 방법 중 한 가지 방법을 통해 가축을 기절시킨다. 철선을 사용하여 기절한 가축의 등골(연수나 척수)을 파쇄한다. 기절한 가축을 도살장 바닥으로 밀어 놓거나 호이스트(Hoist)를 사용하여 체인컨베이어(Chain Conveyor)에 뒷다리의 발목을 건다. 작업한 수량을 작업일지에 기록한다. 물호스를 사용하여 작업장 주위를 청소한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|다습|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"전기도살원, 총격도살원, 가스도살원","connectJob":"타격원, 타액원","dJobECd":"8721","dJobECdNm":"[8721]정육원 및 도축원","dJobJCd":"7103","dJobJCdNm":"[7103]정육가공원 및 도축원","dJobICd":"C101","dJobICdNm":"[C101]도축, 육류 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002762:1', '{"dJobCd":"K000002762","dJobCdSeq":"1","dJobNm":"가축박피기계조작원","workSum":"박피기계를 이용하여 가축의 가죽을 벗기는 작업을 수행한다.","doWork":"예박작업이 된 가축을 대상으로 남아있는 가죽의 양 끝부분을 기계 체인에 감아 연결시켜 고정한다. 가축이 기계를 지나가는 동안 가죽은 말려서 벗겨지게 되는데, 원활한 박피를 위해 중간중간 작업도(작업칼)로 칼집을 내주어 박피한다. 작업도와 손을 세정하고 작업도를 살균기에 넣는다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"대기환경미흡|다습|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8721","dJobECdNm":"[8721]정육원 및 도축원","dJobJCd":"7103","dJobJCdNm":"[7103]정육가공원 및 도축원","dJobICd":"C101","dJobICdNm":"[C101]도축, 육류 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001515:1', '{"dJobCd":"K000001515","dJobCdSeq":"1","dJobNm":"가축방혈원","workSum":"도살된 가축의 육질을 높이기 위하여 기절한 가축의 목동맥을 절단하여 피를 방혈한다.","doWork":"계류를 마치고 전기충격을 이용한 전살법으로 기절시킨 가축이 컨베이어를 통해 이송되면 칼로 가축의 목부위에 있는 경동맥을 잘라 방혈시킨다. 수평방혈이 이루어지면 가축의 한쪽 다리를 섀클(Shackle) 또는 훅(Hook)에 걸어 수직방혈 시킨다. 방혈이 완료된 가축을 세척하고 탕박 및 탈모공정으로 이송시킨다. 닭 등 가금류는 헤드컨베이어로 운반한다. 자동화된 기계의 방혈공정에서 동맥이 절단되지 않은 닭 등 가금류를 선별하여 절단하기도 한다. 약품 또는 식품의 소재로 사용되기도 하는 방혈된 피를 운반용기에 받아 저장장소로 운반하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|다습|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"8721","dJobECdNm":"[8721]정육원 및 도축원","dJobJCd":"7103","dJobJCdNm":"[7103]정육가공원 및 도축원","dJobICd":"C101","dJobICdNm":"[C101]도축, 육류 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003405:1', '{"dJobCd":"K000003405","dJobCdSeq":"1","dJobNm":"가축세척원","workSum":"도축된 가축의 오염부위를 찾아 분리제거하고, 겉과 안에 부착되어 있는 혈액과 오염물을 씻어낸다.","doWork":"이분체 분할작업을 마친 가축이 컨베이어에 걸려서 오면 전 도축공정 동안 상처나고 박피된 부분의 오염정도를 관찰하고 오염부위를 제거한다. 척추와 가축 안쪽에 부착된 혈액과 오염물 등을 제거한다. 내장에 의한 오염이 발견될 경우 오염물을 분리제거하고 세정소독을 한다. 물로 위아래, 앞뒤를 모두 세정한다. 작업도, 손, 팔을 세정하고 작업도(작업칼)를 살균기에 넣는다. 방혈 후, 잔모소각 후, 이분체 분할 후, 등급판정 후 세척하기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"대기환경미흡|다습|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"도체세척원, 지육세척원","dJobECd":"8721","dJobECdNm":"[8721]정육원 및 도축원","dJobJCd":"7103","dJobJCdNm":"[7103]정육가공원 및 도축원","dJobICd":"C101","dJobICdNm":"[C101]도축, 육류 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003865:1', '{"dJobCd":"K000003865","dJobCdSeq":"1","dJobNm":"골발작업원","workSum":"육가공품을 제조하거나 포장육으로 판매하고자 돼지의 식용 또는 소시지육을 부위별로 해체한다.","doWork":"해체실로 운반된 지육을 작업대의 모노레일(Monorail)에 걸어놓고, 칼과 절단기구로 지육을 앞다리, 뒷다리, 몸체 등으로 절단한다. 절단한 지육을 작업대 위에 올려놓고, 칼로 기름덩이나 이물질을 제거한다. 절단한 고기와 뼈, 족을 구분하여 부위별로 쌓는다. 작업한 수량을 작업일지에 기록한다. 물호스를 사용하여 작업장 주위를 청소한다. 무딘 칼날을 연마하고 절단기구를 점검한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|다습|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"비계지방제거원, 지육해체원, 도부","certLic":"식육처리기능사","dJobECd":"8721","dJobECdNm":"[8721]정육원 및 도축원","dJobJCd":"7103","dJobJCdNm":"[7103]정육가공원 및 도축원","dJobICd":"C101","dJobICdNm":"[C101]도축, 육류 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007388:1', '{"dJobCd":"K000007388","dJobCdSeq":"1","dJobNm":"내장처리원","workSum":"해체되어 운반된 가축의 내장 중에서 식용부위를 분류하고 세척한다.","doWork":"운반해 온 내장을 작업대 위에 올려놓고 심장, 지라, 위, 비장, 간 등, 식용이 가능한 부위와 비식용 부위를 구분한다. 식용 부위는 부위별로 분류하여 칼로 절단한다. 창자 등, 식용 부위 속에 든 이물질을 물로 세척하고 손상된 부위를 절단한다. 부위별로 구분된 내장을 운반용기에 담아 냉장창고로 운반한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|다습|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"닭내장처리원, 돼지내장처리원, 소내장처리원","dJobECd":"8721","dJobECdNm":"[8721]정육원 및 도축원","dJobJCd":"7103","dJobJCdNm":"[7103]정육가공원 및 도축원","dJobICd":"C101","dJobICdNm":"[C101]도축, 육류 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004609:1', '{"dJobCd":"K000004609","dJobCdSeq":"1","dJobNm":"도살반장","workSum":"소나 돼지를 도살하여 가죽 및 내장을 제거하고 지육을 부위별로 절단하는 작업원의 활동을 감독·조정한다.","doWork":"일일작업량을 점검하고 가축의 수량을 확인한다. 기계의 조정판을 직접 조절하거나 설비담당 부서에 의뢰하여 생산과정에 따른 모노레일(Monorail)이나 컨베이어(Conveyor)의 속도를 조절한다. 작업계획에 따라 세부실행항목을 수립하여 작업절차 및 방법을 결정한 후 작업원이 효율적으로 작업할 수 있도록 적당한 위치에 배정하고 작업내용을 작업원에게 지시한다. 작업진행상황을 파악하고 작업내용을 보고한다. 작업원의 작업상황을 관리·감독하고 작업공정에 있어 필요한 자재지원 및 기술을 지원한다. 표준명세에 따라 지시된 작업이 이루어지는지 작업원과 함께 작업하며 작업상황을 관찰하고 작업내용을 점검한다. 작업원에 대한 직무교육 및 안전위생교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시로 관찰과 면담을 통하여 작업원의 애로 및 건의사항을 수렴·해결하고 문제점을 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"저온|다습|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"수동조작","connectJob":"돼지도살반장, 소도살반장","dJobECd":"8721","dJobECdNm":"[8721]정육원 및 도축원","dJobJCd":"7103","dJobJCdNm":"[7103]정육가공원 및 도축원","dJobICd":"C101","dJobICdNm":"[C101]도축, 육류 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006713:1', '{"dJobCd":"K000006713","dJobCdSeq":"1","dJobNm":"도살보조원","workSum":"소, 돼지 등의 가축을 도살하는 도살장에서 보조 업무를 수행한다.","doWork":"가축을 가두어놓은 계류사를 청소한다. 도살할 소를 몰거나 고삐를 잡아 고정한다. 박피된 소껍질을 운반·저장하거나 해체작업으로 나온 부산물을 냉동창고로 운반한다. 절단한 머리나 족을 바구니에 담아 운반하고 계량원의 일을 돕는다. 호스를 사용하여 지육을 세척하고 솔, 스크레이퍼(Scraper), 물, 세척제 등을 사용하여 고기, 기름덩이, 혈흔 등 오물이 묻어 있는 화물차의 화물칸이나 작업장, 운반용 수레 등을 청소한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"시범후 30일 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|다습|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","dJobECd":"8721","dJobECdNm":"[8721]정육원 및 도축원","dJobJCd":"7103","dJobJCdNm":"[7103]정육가공원 및 도축원","dJobICd":"C101","dJobICdNm":"[C101]도축, 육류 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004213:1', '{"dJobCd":"K000004213","dJobCdSeq":"1","dJobNm":"도축육계량원","workSum":"도살한 지육을 경매하고자 중량을 측정한다.","doWork":"수세 및 검사를 마친 지육(枝肉)을 갈고리에 꿰거나 모노레일에 걸어 계량기로 운반한다. 저울 또는 자동계량기(전자저울)로 도체 지육의 중량을 측정하여 일지에 기록한다. 품목표에 품종, 중량, 부위 등을 기록하여 지육의 상단에 부착하거나 전산처리한다. 계량한 지육이나 가축을 경매장이나 냉동실로 운반한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|","workEnv":"대기환경미흡|저온|다습|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","similarNm":"계근원","dJobECd":"8721","dJobECdNm":"[8721]정육원 및 도축원","dJobJCd":"7103","dJobJCdNm":"[7103]정육가공원 및 도축원","dJobICd":"C101","dJobICdNm":"[C101]도축, 육류 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006898:1', '{"dJobCd":"K000006898","dJobCdSeq":"1","dJobNm":"도축육해체원","workSum":"모노레일(Monorail)이나 컨베이어(Conveyer)에 거꾸로 걸려있는 도축육의 머리, 다리, 항문 및 엉덩이, 앞가슴을 절단하고 가죽을 벗기며, 복부를 절개하여 내장을 적출한다.","doWork":"피를 빼내는 방혈과정에서 일부 절단되어 있는 머리 부분의 가죽을 살균·소독된 작업도(작업칼)로 일부만 남기로 분리한 후 두골과 경추 사이를 분리한다. 작업도로 앞다리 부분의 가죽을 제거한 뒤, 족절단기와 작업도로 앞발목뼈와 앞발허리뼈 사이 관절을 절개하여 앞다리를 절단한다. 뒷다리도 같은 방법으로 절단한다. 절단한 다리를 훅에 건다. 항문 주위와 둔부의 가죽을 박피한다. 앞가슴 부분의 가죽을 벗기고 가축의 배 주위 사선을 따라 작업도로 음경, 고환, 유방을 제거한다. 앞가슴 쪽부터 위에서 아래로 복부를 절개하고 내장을 적출한다. 직장, 소장, 대장, 십이지장, 위 등의 백내장을 먼저 적출하고, 간장, 폐장, 기관지, 심장 등의 적내장을 적출한다. 작업도, 손, 팔, 앞치마를 세정하고, 작업도를 살균기에 넣는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"대기환경미흡|다습|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"머리절단원, 백내장적출원, 적내장적출원, 도체원, 배활원","certLic":"식육처리기능사","dJobECd":"8721","dJobECdNm":"[8721]정육원 및 도축원","dJobJCd":"7103","dJobJCdNm":"[7103]정육가공원 및 도축원","dJobICd":"C101","dJobICdNm":"[C101]도축, 육류 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006423:1', '{"dJobCd":"K000006423","dJobCdSeq":"1","dJobNm":"생육살균원","workSum":"도축공정 중 내장이 파손되어 오염된 도체에 대하여 천연살균제를 사용하여 살균처리한다.","doWork":"내장적출 시 내장이 파손되어 오염된 도체를 파악한다. 파손된 내장의 이물질에 의하여 오염된 도체 부위를 세척한다. 세척 부위를 물로 희석한 구연산 등 천연 유기산 세정제를 사용하여 소독하여 살균처리한다. 오염되어 살균처리된 도체를 실험실검사원에게 알려 일반세균 및 대장균 등의 세균 검사를 요청하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|저온|다습|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"도체살균원","dJobECd":"8721","dJobECdNm":"[8721]정육원 및 도축원","dJobJCd":"7103","dJobJCdNm":"[7103]정육가공원 및 도축원","dJobICd":"C101","dJobICdNm":"[C101]도축, 육류 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006533:1', '{"dJobCd":"K000006533","dJobCdSeq":"1","dJobNm":"생육정형원","workSum":"해체된 지육을 부위별로 절단하고 다듬어 햄육과 포장육으로 분류한다.","doWork":"전(前) 공정에서 작업도에 의해 상처난 부분과 박피부분에 오물 등이 묻어 있지 않도록 점검하고 살균 소독된 작업도로 오염부위를 분리하여 제거한다. 척추와 도체 내측에 묻어있는 혈액과 오염물 등을 제거한다. 내장에 의해 오염된 경우는 오염물을 분리제거하고 세정소독을 실시한다. 칼을 사용하여 등심, 안심, 삼겹, 사태 등을 절단한다. 부위에 따라 햄, 소시지 등을 만들기 위해 햄육을 분류하여 세절공정으로 운반한다. 비닐이나 포장지로 포장하여 냉장창고로 운반한다. 작업한 수량을 작업일지에 기록하고 물호스를 사용하여 작업장 주위를 청소한다. 작업이 완료되면 작업도는 살균기에 집어넣는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|저온|다습|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"트리밍(Trimming)원","certLic":"식육처리기능사","dJobECd":"8721","dJobECdNm":"[8721]정육원 및 도축원","dJobJCd":"7103","dJobJCdNm":"[7103]정육가공원 및 도축원","dJobICd":"C101","dJobICdNm":"[C101]도축, 육류 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007251:1', '{"dJobCd":"K000007251","dJobCdSeq":"1","dJobNm":"소박피원","workSum":"작업도, 박피기를 사용하여 도살된 소의 가죽을 벗긴다.","doWork":"살균된 작업도를 사용하여 흉부와 복부의 중앙선을 따라 가죽을 절개한다. 살균 소독된 박피기를 가지고 복부의 가죽을 잡고 박피한다. 기계로 박피작업을 할 경우 드럼의 체인에 하복부 및 퇴골주위의 원피를 감고 기계를 조작하여 양측의 균형이 잘 맞도록 박피한다. 기계로 박피되는 가죽과 도체 사이의 지방부위를 칼 또는 에어커터(Air Knife)를 사용하여 잘라준다. 사용한 작업도 및 박피기를 살균기로 살균·소독한다. 지육은 절단작업을 위해 모노레일이나 버킷컨베이어에 걸어 다음 공정으로 운반하기도 한다. 벗긴 가죽을 통에 담아 보관한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|다습|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"돼지박피원","dJobECd":"8721","dJobECdNm":"[8721]정육원 및 도축원","dJobJCd":"7103","dJobJCdNm":"[7103]정육가공원 및 도축원","dJobICd":"C101","dJobICdNm":"[C101]도축, 육류 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001293:1', '{"dJobCd":"K000001293","dJobCdSeq":"1","dJobNm":"예비박피원","workSum":"도살한 소와 돼지의 다리, 꼬리 등 몸통 이외의 가죽을 벗기는 작업을 수행한다.","doWork":"살균 소독된 작업도의 칼날을 밖으로 향하게 하여 대퇴부 가죽을 절개한다. 둔부 및 하복부의 중앙의 가죽을 절개한다. 팔목보호대를 착용하고 넓적다리 안쪽으로 다리부분에 이르기까지 박피기를 사용하여 박피한다. 꼬리 가죽의 박피 시 꼬리의 끝부분 가죽과 털을 품종 보증용으로 일부 남기기도 한다. 박피 작업을 완료한 후 박피기와 손과 손목을 세정하고 박피기를 살균기에 넣어 살균한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"저온|다습|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"예비제피원","dJobECd":"8721","dJobECdNm":"[8721]정육원 및 도축원","dJobJCd":"7103","dJobJCdNm":"[7103]정육가공원 및 도축원","dJobICd":"C101","dJobICdNm":"[C101]도축, 육류 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002500:1', '{"dJobCd":"K000002500","dJobCdSeq":"1","dJobNm":"육류성형틀해체원","workSum":"햄, 소시지의 성형을 위하여 제품을 감싼 성형틀(Mold)이나 포장비닐(Casing)을 제거한다.","doWork":"훈연 및 열처리작업이 완료되면 밀대를 작업장으로 운반하여 물로 냉각한다. 제품이 냉각되면 성형틀을 제거하거나, 제품원료를 채워 넣었던 비닐을 벗겨낸다. 연결된 소시지를 후가공을 위해 하나씩 절단하기도 한다. 해체된 성형틀을 세척용 탱크에 넣어 물로 세척한 후 성형공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"시범후 30일 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|다습|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","dJobECd":"8721","dJobECdNm":"[8721]정육원 및 도축원","dJobJCd":"7103","dJobJCdNm":"[7103]정육가공원 및 도축원","dJobICd":"C101","dJobICdNm":"[C101]도축, 육류 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006249:1', '{"dJobCd":"K000006249","dJobCdSeq":"1","dJobNm":"육류세척원","workSum":"해체 및 계량된 도체(지육)의 오염부위를 분리제거하고 도체의 상품성 향상을 위하여 도체 세정기를 사용하여 도체를 세척한다.","doWork":"버킷컨베이어(Bucket Conveyor)에 걸린 지육에 묻은 피와 오물 등 오염부위를 제거하고자 고압으로 살수되는 도체 세정기를 통과시킨다. 분사식 세척의 경우 위에서 아래로 세척한다. 세정 마무리 단계에서 유기산, 염소수 또는 열수 등을 고압으로 분무하여 살균하기도 한다. 도체 세정작업이 완료되면 표면의 물기를 제거하고 냉각실로 이송시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"시범후 30일 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|저온|다습|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","similarNm":"육류세정기조작원, 도체세정기조작원","dJobECd":"8721","dJobECdNm":"[8721]정육원 및 도축원","dJobJCd":"7103","dJobJCdNm":"[7103]정육가공원 및 도축원","dJobICd":"C101","dJobICdNm":"[C101]도축, 육류 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002920:1', '{"dJobCd":"K000002920","dJobCdSeq":"1","dJobNm":"육류이분체분할원","workSum":"내장이 적출되고 박피된 가축을 척추를 중심으로 좌우 똑같이 분할한다.","doWork":"내장이 적출되고 박피된 가축이 컨베이어를 타고 지나갈 때, 지나가는 속도에 맞추어 가축의 척추를 중심으로 정확히 이분할한다. 살균 소독된 전동톱을 이용하여 분할한다. 작업이 완료되면 전동톱을 세정한 후 전용 살균기에 넣는다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"대기환경미흡|다습|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"이분체배할원","connectJob":"돼지이분체분할원, 소이분체분할원","certLic":"식육처리기능사","dJobECd":"8721","dJobECdNm":"[8721]정육원 및 도축원","dJobJCd":"7103","dJobJCdNm":"[7103]정육가공원 및 도축원","dJobICd":"C101","dJobICdNm":"[C101]도축, 육류 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005662:1', '{"dJobCd":"K000005662","dJobCdSeq":"1","dJobNm":"육류포장원","workSum":"골발 및 정선공정을 마친 정선육을 사양에 따라 진공 포장 또는 비닐 포장을 하고 냉동실로 운반한다.","doWork":"뼈와 식용으로 부적합한 부산물 등이 제거된 고기(정선육)를 작업대에 놓고, 부위별로 절단한다. 부위 및 제품사양에 따라 고기를 분류하고 비닐 또는 진공포장기를 사용하여 포장한다. 포장된 고기를 냉동실로 운반한다. 작업 후 작업도구 및 작업대를 소독한다. 부산물 처리 과정에서 나온 잡육을 동그랗게 말아 냉동실로 운반하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"냉동육성형원","dJobECd":"8721","dJobECdNm":"[8721]정육원 및 도축원","dJobJCd":"7103","dJobJCdNm":"[7103]정육가공원 및 도축원","dJobICd":"C101","dJobICdNm":"[C101]도축, 육류 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004007:1', '{"dJobCd":"K000004007","dJobCdSeq":"1","dJobNm":"탈모기조작원","workSum":"돼지 도체의 털을 제거하는 기계를 조작한다.","doWork":"탕침 탱크(Scalding Tank)에 온수를 채우고 일정 온도로 가열한다. 컨베이어로 운반된 돼지 도체를 탕침 탱크에 넣어 일정 시간 담근다. 돼지 도체를 꺼내 탈모기에 투입하고 탈모기를 가동한다. 탈모기의 가동상태 및 돼지 도체의 탈모상태를 확인한다. 탈모에 사용되는 다수의 강철제의 할퀴기 손톱이 붙는 고무벨트(Scraper Paddles)를 교체하기도 한다. 호이스트체인(Hoist Chain)에 걸려오는 돼지 도체에 일정 시간 온수를 뿌린 후 탈모작업을 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"고온|다습|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"탕박기조작원","dJobECd":"8721","dJobECdNm":"[8721]정육원 및 도축원","dJobJCd":"7103","dJobJCdNm":"[7103]정육가공원 및 도축원","dJobICd":"C101","dJobICdNm":"[C101]도축, 육류 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006251:1', '{"dJobCd":"K000006251","dJobCdSeq":"1","dJobNm":"탕적기조작원","workSum":"도살된 닭의 깃털을 제거하고자 탕적기와 탈모기를 조작·관리한다.","doWork":"탕적기와 탈모기를 확인하고 고무솔 등 부품의 이상 여부를 점검한다. 탕적기에 온수를 채우고 닭 이송컨베이어의 속도를 확인하고 탕적기에 닭이 투입되는 시간을 조절한다. 자동탈모기에 탕적기를 통과한 닭이 투입되는 것을 관찰한다. 탈모기를 통과한 닭을 연속으로 다시 자동탈모기에 투입시켜 깃털을 완전하게 제거한다. 탈모작업이 완료된 닭을 닭머리 및 닭발 제거공정으로 이송시킨다. 작업장에 쌓인 깃털, 피 등의 이물질을 제거하고 물호스를 사용하여 작업장을 청소한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|고온|다습|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8721","dJobECdNm":"[8721]정육원 및 도축원","dJobJCd":"7103","dJobJCdNm":"[7103]정육가공원 및 도축원","dJobICd":"C101","dJobICdNm":"[C101]도축, 육류 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005885:1', '{"dJobCd":"K000005885","dJobCdSeq":"1","dJobNm":"냉동육등급분류원","workSum":"냉각(Chilling)처리된 가금육(닭고기 등)을 중량별로 선별하여 규격별, 등급별로 포장한다.","doWork":"냉각(Chilling)공정을 거쳐 컨베이어(Conveyor)에 걸려오는 냉각처리된 가금육을 확인한다. 컴퓨터에 의해 중량별로 구분되어 포장되는 가금육을 모니터링한다. 신선한 육질을 유지하기 위해 포장된 제품은 냉각시설인 정온실로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","dJobECd":"8723","dJobECdNm":"[8723]식품·담배 등급원","dJobJCd":"7104","dJobJCdNm":"[7104]식품 및 담배 등급원","dJobICd":"C101","dJobICdNm":"[C101]도축, 육류 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004819:1', '{"dJobCd":"K000004819","dJobCdSeq":"1","dJobNm":"육류등급판정원","workSum":"도축된 지육상태의 소, 돼지, 닭, 오리 등을 일정한 기준에 따라서 검사한 후 등급을 판정한다.","doWork":"소고기, 돼지고기, 오리고기, 닭고기 등을 검사하여 등급을 판정한다. 소의 도체를 근내지방도(Marbling), 육색, 지방색, 조직감, 성숙도 등에 따라 육질상태를 구분하고 등지방두께, 배최장근단면적, 도체의 중량을 측정하여 육량지수에 따라 등급으로 구분한다. 돼지의 경우 도체의 중량, 등지방두께, 외관과 육질상태를 평가하여 등급을 구분하여 판정한다. 측정·검사된 지육의 등급을 등급판정기록표에 기록한다. 판정내용을 해당 도축육의 경매에 사용될 수 있도록 도축장 측에 제공한다. 가축의 육질개선을 위해 출하자에게 통고한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"시각|","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"육류품질평가사","dJobECd":"8723","dJobECdNm":"[8723]식품·담배 등급원","dJobJCd":"7104","dJobJCdNm":"[7104]식품 및 담배 등급원","dJobICd":"C101","dJobICdNm":"[C101]도축, 육류 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003200:1', '{"dJobCd":"K000003200","dJobCdSeq":"1","dJobNm":"잎담배품질관리원","workSum":"잎담배를 제조하는 과정에서 제품의 품질향상과 공정을 원활히 유지하려고 품질관리 계획을 수립하고 시행한다.","doWork":"수시로 각 공정의 제품을 수거하여 수분함량을 검사하고 작업자에게 통보한다. 잎담배에 이물질이 없는지 점검하고 니코틴(Nicotine) 함량을 검사하여 등급을 분류한다. 완제품을 수거하여 중량, 맛, 향, 니코틴·타르 함유량 등을 검사하고 제품의 표준과 비교한다. 검사한 자료를 작업일지에 기록·정리하여 관리자에게 보고한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"담배등급원","certLic":"농산물품질관리사, 품질경영기사","dJobECd":"8723","dJobECdNm":"[8723]식품·담배 등급원","dJobJCd":"7104","dJobJCdNm":"[7104]식품 및 담배 등급원","dJobICd":"C120","dJobICdNm":"[C120]담배 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004039:1', '{"dJobCd":"K000004039","dJobCdSeq":"1","dJobNm":"김치제조원","workSum":"절인 배추에 양념을 버무려 김치를 제조한다.","doWork":"청결을 위해 장갑, 위생복, 위생모를 착용한다. 준비된 양념속과 절임배추로 김치를 제조한다. 절단된 배추에 따라 양념속과 절단된 배추를 버무리기도 하고 배추잎 사이에 양념속을 넣기도 한다. 김치의 종류에 따라 배추 이외에 무, 오이 등을 이용하여 김치를 제조하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"김치속넣기원","connectJob":"물김치제조원, 깍두기제조원, 오이김치제조원","dJobECd":"8722","dJobECdNm":"[8722]김치·밑반찬 제조 종사원","dJobJCd":"7105","dJobJCdNm":"[7105]김치 및 밑반찬 제조 종사원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003607:1', '{"dJobCd":"K000003607","dJobCdSeq":"1","dJobNm":"농산물세척원","workSum":"마늘, 고추, 양파 등의 농산물을 세척한다.","doWork":"작업대 위에 세척할 농산물을 올려놓고, 칼을 사용하여 잔뿌리나 필요 없는 줄기를 제거한다. 손으로 껍질을 벗기거나 털어서 이물질을 먼저 제거한다. 세척탱크의 급수밸브를 열어 일정량의 물을 급수한 후, 농산물을 투입한다. 농산물에 부착된 이물질을 세척하고, 깨끗한 물이 채워진 통에 다시 세척한다. 금속망이 부착된 건조대 위에 세척한 농산물을 올려 물기를 제거한다. 제거한 뿌리, 줄기 등의 이물질을 모아 소각장으로 운반한다. 작업대 위를 세척하고 다음 작업을 준비한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"시범후 30일 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"배추세척원, 단무지세척원","dJobECd":"8722","dJobECdNm":"[8722]김치·밑반찬 제조 종사원","dJobJCd":"7105","dJobJCdNm":"[7105]김치 및 밑반찬 제조 종사원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003827:1', '{"dJobCd":"K000003827","dJobCdSeq":"1","dJobNm":"도시락제조반장","workSum":"도시락을 제조하고자 쌀, 야채, 고기 등의 원료를 분쇄·조리·성형하는 작업원의 활동을 감독·조정한다.","doWork":"일일 작업량을 파악하고 음식재료의 반입 및 제품의 출하상태를 점검한다. 작업원, 원료, 제품의 위생상태를 점검하고 필요한 조치를 마련한다. 수요자의 요구에 맞게 조리법을 도시락제조원들에게 교육하며 조리를 지시한다. 도시락제조원의 작업 중 높은 숙련이 필요한 일을 대신 수행하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"고온|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"수동조작","connectJob":"김밥제조반장","dJobECd":"8722","dJobECdNm":"[8722]김치·밑반찬 제조 종사원","dJobJCd":"7105","dJobJCdNm":"[7105]김치 및 밑반찬 제조 종사원","dJobICd":"C106","dJobICdNm":"[C106]곡물가공품, 전분 및 전분제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001312:1', '{"dJobCd":"K000001312","dJobCdSeq":"1","dJobNm":"도시락제조원","workSum":"도시락을 제조하고자 쌀, 야채, 고기 등의 원료를 분쇄·조리·성형하는 장비를 조작한다.","doWork":"제품의 종류 또는 수요자의 요구에 따라 조리될 재료를 준비한다. 쌀, 고기, 야채, 생선, 과일 등 도시락 재료를 제조방법에 따라 규격용기를 사용하여 계량한다. 세척탱크에 원료를 넣고 세척하고 밑손질을 한다. 칼이나 절단기를 사용하여 일정한 크기로 재료를 절단하고, 요리제조방법에 따라 재료를 조리한다. 조리된 반찬을 일정 크기로 자르고, 밥과 반찬을 포장용기(플라스틱용기나 스티로폼용기)에 순서대로 넣는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"김밥제조원","certLic":"한식조리기능사","dJobECd":"8722","dJobECdNm":"[8722]김치·밑반찬 제조 종사원","dJobJCd":"7105","dJobJCdNm":"[7105]김치 및 밑반찬 제조 종사원","dJobICd":"C106","dJobICdNm":"[C106]곡물가공품, 전분 및 전분제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004095:1', '{"dJobCd":"K000004095","dJobCdSeq":"1","dJobNm":"배추절단원","workSum":"김치를 만들기 위해 배추를 가공목적에 맞게 절단한다.","doWork":"크기별로 포기김치용, 맛김치용으로 선별된 배추를 가공목적에 맞게 절단한다. 자동배추절단기 또는 수작업으로 배추를 알맞은 크기로 절단한다. 배추 속에 있는 이물질이나 잔류 농약성분을 제거하기 위해 세척하고 이송 컨베이어 벨트를 이용 절임공정으로 이송한다. 절임공정 이후 배추를 절단하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"단무지절단원","dJobECd":"8722","dJobECdNm":"[8722]김치·밑반찬 제조 종사원","dJobJCd":"7105","dJobJCdNm":"[7105]김치 및 밑반찬 제조 종사원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005425:1', '{"dJobCd":"K000005425","dJobCdSeq":"1","dJobNm":"배추절임원","workSum":"김치를 만들기 위해 배추를 소금에 절인다.","doWork":"목적에 맞게 배추를 절이기 위한 소금농도, 절임시간, 온도 등을 확인하고 절단한 배추를 망사형 스테인리스통이나 그물망에 넣고 이동식 스테인리스 절임조에 침수시킨다. 물의 수질, 절임조의 형태, 절임방법 등에 따라 절임 시간을 조정한다. 절임공정이 끝난 배추를 탈염 및 세척공정으로 이송한다. 절임작업이 끝난 후 절임조를 세척한다. 소금물을 사용하는 습식절임 이외에 소금을 뿌리는 방식의 건식절임을 병행하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8722","dJobECdNm":"[8722]김치·밑반찬 제조 종사원","dJobJCd":"7105","dJobJCdNm":"[7105]김치 및 밑반찬 제조 종사원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004848:1', '{"dJobCd":"K000004848","dJobCdSeq":"1","dJobNm":"배추탈염원","workSum":"절인 배추를 일정한 염농도가 되도록 세척 및 탈염한다.","doWork":"절인 배추를 세척과 동시에 탈염시킨다. 김치를 담그기 위한 일정한 염농도가 되도록 컨베이어 벨트로 이송된 절임용 용기를 세척조에 침지시킨다. 세척조에 투입되는 수량을 조정하고 이물질이 투입되지 않도록 단계적으로 탈염 및 세척되는 배추를 관찰한다. 세척한 배추를 혼합공정으로 이송하기 전 망사구조의 탈수대 및 탈수기를 이용하여 일정 수분 함량까지 탈수시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"단무지탈염원","dJobECd":"8722","dJobECdNm":"[8722]김치·밑반찬 제조 종사원","dJobJCd":"7105","dJobJCdNm":"[7105]김치 및 밑반찬 제조 종사원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004673:1', '{"dJobCd":"K000004673","dJobCdSeq":"1","dJobNm":"생선절단원","workSum":"참치(황다랑어) 등 대형 수산물을 일정한 크기로 절단한다.","doWork":"물탱크에서 자연 해동시켜 내장 등을 제거한 수산물의 상태를 확인한다. 전기톱을 사용하여 수산물을 일정한 크기로 절단한다. 그라인더를 사용하여 불필요한 부위를 제거한다. 용도에 따라 냉동상태로 절단하기도 하며 얇게 혹은 넓게 자르기도 한다. 절단작업이 끝난 수산물을 다음 공정으로 이송시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|저온|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"생선커팅원, 냉동생선절단원","dJobECd":"8729","dJobECdNm":"[8729]기타 식품가공 종사원","dJobJCd":"7109","dJobJCdNm":"[7109]기타 식품가공 관련 종사원","dJobICd":"C102","dJobICdNm":"[C102]수산물 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003704:1', '{"dJobCd":"K000003704","dJobCdSeq":"1","dJobNm":"생선조미원","workSum":"참치나 연어 등 수산물을 훈제하고자 음식의 맛을 알맞게 조절하는 조미액에 침지한다.","doWork":"훈제하기 위한 수산물의 종류와 수량을 확인한다. 훈제할 수산물에 따라 조미액에 필요한 양념을 준비한다. 작업표준서의 비율대로 양념을 계량한 후 배합탱크에 투입하고 교반기를 가동하여 혼합한다. 양념이 혼합된 조미액을 색상이나 맛을 확인하고, 규격대로 절단한 수산물을 침지한다. 수산물의 종류에 따라 침지시간을 조정한다. 일정 시간이 지나면 건조대에 수산물을 올려 수분을 제거한다. 훈제에 알맞은 수분함유량을 육안 또는 촉감으로 확인하고 훈제실로 운반한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|다습|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8729","dJobECdNm":"[8729]기타 식품가공 종사원","dJobJCd":"7109","dJobJCdNm":"[7109]기타 식품가공 관련 종사원","dJobICd":"C102","dJobICdNm":"[C102]수산물 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005315:1', '{"dJobCd":"K000005315","dJobCdSeq":"1","dJobNm":"생선해체원","workSum":"해동된 생선을 가공하고자 하는 부위별로 해체한다.","doWork":"해동된 생선 또는 선어(미동결 생선)를 작업대 위에 올린다. 생선의 배를 가르고 내장을 제거한다. 중량이나 크기에 따라 일정 크기로 절단한다. 가공 등의 필요에 따라 등뼈, 지느러미 및 가시 등을 제거하기도 한다. 가공이 완료된 생선을 세척공정으로 이송한다. 물호스나 솥을 사용하여 작업장 주위를 청소한다. 제거한 내장에서 식용가능 부위를 선별하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"대기환경미흡|다습|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"참치해체원, 고래해체원, 장어해체원","dJobECd":"8729","dJobECdNm":"[8729]기타 식품가공 종사원","dJobJCd":"7109","dJobJCdNm":"[7109]기타 식품가공 관련 종사원","dJobICd":"C102","dJobICdNm":"[C102]수산물 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007232:1', '{"dJobCd":"K000007232","dJobCdSeq":"1","dJobNm":"수산물원료처리원","workSum":"수산물을 가공하고자 원료(어패류)를 세척하고 부위별로 절단한다.","doWork":"어패류 또는 해동(저온, 자연)된 어패류를 작업명세표의 규격을 확인한 후, 크기별로 선별한다. 패류는 껍질을 제거하고자 탈각공정으로 운반한다. 어류는 종류에 따라 지느러미, 꼬리, 머리를 칼이나 회전칼을 사용하여 절단하거나 필렛(Fillet:뼈를 제거하여 순살만 손질)작업을 한다. 비늘을 제거하고 배를 갈라 내장을 제거하기도 한다. 작업이 완료된 원료를 세척한다. 바구니나 수절대(구멍뚫린 금속판) 위에 올려 물기를 제거한다. 물기가 제거된 원료를 냉동팬에 넣고 동결시킨다. 동결시킨 원료를 회전칼을 사용하여 일정 크기로 절단한다. 절단한 생선을 소금물에 침지하거나, 절단한 원료를 포장공정으로 이송시킨다. 물호스를 사용하여 작업장 주위의 이물질을 제거한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"시범후 30일 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|저온|다습|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8729","dJobECdNm":"[8729]기타 식품가공 종사원","dJobJCd":"7109","dJobJCdNm":"[7109]기타 식품가공 관련 종사원","dJobICd":"C102","dJobICdNm":"[C102]수산물 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004974:1', '{"dJobCd":"K000004974","dJobCdSeq":"1","dJobNm":"어염건어물제조원","workSum":"어염건어물을 제조하고자 어류를 소금에 절여 건조한다.","doWork":"어류의 배를 절개하여 내장, 뼈 등 불필요한 부분을 제거하고 머리를 절단한 후, 물탱크에 넣어 세척한다. 세척하여 이물질을 제거한 어류의 수분을 제거한다. 어류를 작업대 위에 올려놓고 소금을 뿌린다. 소금이 살포된 어류를 일정 시간 동안 두어 염분이 침지되도록 하고 재세척하여 여분의 소금을 제거한다. 염분이 스며든 어류를 건조하고자 양지에 걸어 놓고 제품에 탄력성을 주려고 음지로 옮겨 건조한다. 생산량 등에 따라 건조장비를 사용하여 빠른 시간에 건조하기도 한다. 건조된 어류를 중량별로 일정량씩 포장한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"염지건어물제조원","dJobECd":"8729","dJobECdNm":"[8729]기타 식품가공 종사원","dJobJCd":"7109","dJobJCdNm":"[7109]기타 식품가공 관련 종사원","dJobICd":"C102","dJobICdNm":"[C102]수산물 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001503:1', '{"dJobCd":"K000001503","dJobCdSeq":"1","dJobNm":"연육결착원","workSum":"가공된 연육(얇게 저민 고기)의 결착력을 높이기 위해 가공되지 않은 연육을 바른다.","doWork":"연육기의 회전 칼날을 통과하여 세로방향으로 칼집을 넣은 연육이 찢어지는 것을 방지하기 위해 연육통에서 연육을 손으로 펴서 골고루 바른다. 절단기 칼날을 조절하여 일정 길이로 연육을 자른다. 잘려진 연육의 모양을 내기 위해 죽발에 감거나 연육 사이에 비닐을 끼워 넣는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8729","dJobECdNm":"[8729]기타 식품가공 종사원","dJobJCd":"7109","dJobJCdNm":"[7109]기타 식품가공 관련 종사원","dJobICd":"C102","dJobICdNm":"[C102]수산물 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003273:1', '{"dJobCd":"K000003273","dJobCdSeq":"1","dJobNm":"엽선절단기조작원","workSum":"농가로부터 입수한 잎담배의 주맥(담배의 엽맥부위)과 잎부분을 분리하는 엽선절단기를 조작한다.","doWork":"작업량 및 작업일정을 확인하고 작업대상물을 작업대로 이송한다. 절단기의 절단칼날을 점검하고 잎담배를 투입하는 공기이송장치의 가동상태를 확인한다. 조정판의 스위치를 조절하여 절단칼날의 회전속도 등을 입력하고 기계를 가동한다. 분리된 잎담배의 주맥과 잎을 관찰하여 분리상태를 점검하고 최적의 분리가 이루어지도록 조정판의 스위치를 재조절한다. 공기이송장치를 가동하여 분리된 잎과 주맥을 다음 공정으로 운반한다. 작업이 완료되면 절단칼날의 마모상태를 점검하고 투입된 잎담배의 수량을 작업일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"절엽해속기조작원, 주맥분리기조작원","dJobECd":"8729","dJobECdNm":"[8729]기타 식품가공 종사원","dJobJCd":"7109","dJobJCdNm":"[7109]기타 식품가공 관련 종사원","dJobICd":"C120","dJobICdNm":"[C120]담배 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003955:1', '{"dJobCd":"K000003955","dJobCdSeq":"1","dJobNm":"젓갈조미원","workSum":"각종 젓갈의 맛을 내기 위하여 소금, 고춧가루, 설탕 등 첨가료를 일정 비율로 넣고 혼합하여 숙성시킨다.","doWork":"스테인리스(Stainless)통, 항아리, 고무통 등의 용기에 세척한 명란, 창란, 오징어, 조개, 굴 등의 어패류를 붓는다. 소금, 고춧가루, 감미료 등의 각종 첨가물을 일정 비율로 넣고 혼합한다. 용기를 밀봉하고 일정 시간 저온상태에서 숙성한다. 젓갈의 색깔, 제품상태, 중량, 파손상태 등을 육안으로 점검하여 불량품을 선별한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|다습|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8729","dJobECdNm":"[8729]기타 식품가공 종사원","dJobJCd":"7109","dJobJCdNm":"[7109]기타 식품가공 관련 종사원","dJobICd":"C102","dJobICdNm":"[C102]수산물 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001485:1', '{"dJobCd":"K000001485","dJobCdSeq":"1","dJobNm":"홍삼제조원","workSum":"홍삼을 제조하고자 수삼을 세척·증숙·건조·농축하는 설비를 조작·관리한다.","doWork":"홍삼(수삼을 껍질을 벗기지 않은 상태로 증기 및 기타 방법으로 쪄서 말린 것)제조에 적당한 수삼(원료삼)을 선별한 후, 드럼세척기나 수압세척기 등을 이용해 세척한다. 세척한 수삼의 물기를 제거한 후, 중량이나 크기별로 분류하여 증삼솥에 넣는다. 증삼솥의 조정판에 원료삼의 중량이나 크기에 맞는 증삼시간을 입력한 후, 규정된 시간 동안 증기를 이용해 증삼한다. 사포닌 수를 증가시키고 유효성분을 활성화할 수 있게 증삼이 완료된 원료삼을 열풍건조실로 이송한 후 일정한 시간 동안 1차 건조시키고 보다 낮은 온도에서 2차 건조시킨다. 2차에 걸쳐 건조된 원료삼의 잔뿌리를 칼로 제거하고 일정한 크기로 잘라서 포장하거나 추출기로 이송하여 홍삼원액을 추출한다. 추출이 완료된 홍삼원액은 농축기로 이송하여 적정 시간 동안 농축시킨 후 맛과 약효 성분이 잘 조화되도록 일정 기간 숙성시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"곡삼제조원, 백삼제조원, 직삼제조원","dJobECd":"8729","dJobECdNm":"[8729]기타 식품가공 종사원","dJobJCd":"7109","dJobJCdNm":"[7109]기타 식품가공 관련 종사원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004846:1', '{"dJobCd":"K000004846","dJobCdSeq":"1","dJobNm":"모피의류패턴사","workSum":"모피의복의 원형을 만들고자 디자인과 품목별로 실제 완제품과 크기가 동일한 모형을 제작한다.","doWork":"작업지시서를 확인한 후 가위, 패턴용지 등의 재료를 준비한다. 디자인별로 모피의복의 본을 패턴용지에 제도한 후 패턴 라인대로 오려 패턴모형을 만든다. 면 등의 원단재료를 사용하여 시제품을 제작한다. 패턴모형과 시제품을 비교하여 패턴을 수정·보완하고 모피재단사에게 넘긴다. 완성된 제품에 결점이 있는가를 검사한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"양복기능사, 양장기능사","dJobECd":"8621","dJobECdNm":"[8621]패턴사","dJobJCd":"7211","dJobJCdNm":"[7211]패턴사","dJobICd":"C142","dJobICdNm":"[C142]모피제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005360:1', '{"dJobCd":"K000005360","dJobCdSeq":"1","dJobNm":"신발패턴사","workSum":"수작업이나 캐드(CAD)을 이용하여 신발패턴을 설계하고 신발제조의 기준이 되는 패턴을 제작한다.","doWork":"디자인을 분석하여 신발패턴을 설계한다. 기본 문대의 패턴을 제작한다. 시험생산을 통해 패턴이 검정되면, 그 기준 문대에 근거하여 그레이딩(Grading)규칙에 따라 모든 신발 사이즈에 맞게 패턴을 설계하고 제작한다. 제작된 패턴은 창과 함께 완제신발을 만들어 최종 패턴을 확정한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"Pattern Engineer, 신발캐드사","certLic":"신발제조류기능사, 신발개발기사","dJobECd":"8621","dJobECdNm":"[8621]패턴사","dJobJCd":"7211","dJobJCdNm":"[7211]패턴사","dJobICd":"C152","dJobICdNm":"[C152]신발 및 신발 부분품 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003118:1', '{"dJobCd":"K000003118","dJobCdSeq":"1","dJobNm":"의복패턴사","workSum":"의류의 디자인스케치를 보고 패턴제작법을 이용하여 패턴을 제작한다.","doWork":"작업지시서의 디자인 및 제품별로 요척(옷을 만드는 데 필요한 원단의 최소 야드 수)을 계산하여 패턴모형을 종이에 그린다. 컴퓨터 캐드를 이용해 패턴모형을 그리기도 한다. 원단 재질의 축소 여부를 확인하고 패턴제작에 반영한다. 가위나 칼로 패턴을 재단한다. 패턴모형에 치수와 모양 등의 내용을 명시한다. 체형이나 크기에 따라서 다른 규격의 패턴을 그리는 그레이딩(Grading) 작업을 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"패턴사","certLic":"양복기능사, 양장기능사","dJobECd":"8621","dJobECdNm":"[8621]패턴사","dJobJCd":"7211","dJobJCdNm":"[7211]패턴사","dJobICd":"C141","dJobICdNm":"[C141]봉제의복 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005003:1', '{"dJobCd":"K000005003","dJobCdSeq":"1","dJobNm":"자수밑그림복사원","workSum":"자수를 하기 위해 면포에 밑그림을 복사한다.","doWork":"작업지시서에 따라 생산에 필요한 자재를 준비한다. 면포 두루마리를 펴서 자수틀 못에 손으로 잡아당겨 고정한다. 작업지시서의 규격, 디자인에 맞게 가장자리 선을 줄자와 연필로 표시한다. 디자인된 아스테이지를 면포에 올려놓고 솔이나 롤러에 먹물을 묻혀 복사가 되게 문지른다. 디자인된 전사지를 면포에 올려놓고 다리미로 다려 면포에 디자인을 복사하기도 한다. 작업지시서와 일치하는지 확인한 후 세워서 정돈한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"수동조작","dJobECd":"8621","dJobECdNm":"[8621]패턴사","dJobJCd":"7211","dJobJCdNm":"[7211]패턴사","dJobICd":"C132","dJobICdNm":"[C132]직물직조 및 직물제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004062:1', '{"dJobCd":"K000004062","dJobCdSeq":"1","dJobNm":"자수의장도해사","workSum":"직물에 자수를 하거나 패턴체인을 제조하고자 디자인을 도안하고 의장지에 자수선을 그려 넣는다.","doWork":"수요자가 제시한 디자인에 따라 자수의 폭, 길이, 그리고 크기를 확인하고 디자인의 크기를 결정한다. 자수할 실의 종류, 굵기에 따라 무늬 사이의 간격을 결정한다. 의장지 또는 열전사지 등에 무늬의 간격, 디자인의 크기에 따라 연필, 자, 컴퍼스, 디바이더 등을 사용하여 무늬를 그린다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"자수도안사","certLic":"섬유디자인산업기사","dJobECd":"8621","dJobECdNm":"[8621]패턴사","dJobJCd":"7211","dJobJCdNm":"[7211]패턴사","dJobICd":"C132","dJobICdNm":"[C132]직물직조 및 직물제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002872:1', '{"dJobCd":"K000002872","dJobCdSeq":"1","dJobNm":"패턴반장","workSum":"의류패턴을 만드는 데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"패턴생산에 대한 지식 및 내용을 숙지하고 생산의뢰서 또는 작업지시서를 확인한다. 원단의 소모량을 최소화해서 재단을 하기 위하여 수작업 또는 컴퓨터 캐드를 사용하여 패턴원을 관리·감독한다. 지시된 패턴대로 의류모형이 제작되었는지 점검한다. 패턴원이 제작한 패턴이 제조하려는 의복디자인에 적합한지를 작업지시서와 비교·검토하여 패턴모형을 수정한다. 수행할 직무에 대해 작업원을 훈련시킨다. 부서 간의 작업 흐름을 조정하기 위해 다른 반장들과 협의하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","certLic":"양복기능사, 양장기능사","dJobECd":"8621","dJobECdNm":"[8621]패턴사","dJobJCd":"7211","dJobJCdNm":"[7211]패턴사","dJobICd":"C141","dJobICdNm":"[C141]봉제의복 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001906:1', '{"dJobCd":"K000001906","dJobCdSeq":"1","dJobNm":"패턴분해원","workSum":"편직물에 무늬를 넣기 위해 도안지에 무늬를 그린다.","doWork":"제품사양서를 확인하고 무늬의 크기, 색상, 밀도 등에 따라 직물의 짜임새를 그리기 위한 모눈종이인 의장지를 선택한다. 제품사양서에 따르거나 편직물의 표준견본을 확대경으로 관찰하여 직물의 조직과 실의 방향을 알아낸다. 연필이나 컬러펜을 사용하여 의장지에 무늬를 그리거나 실의 방향을 그린다. 무늬가 그리진 도안지를 다음 공정인 패턴체인조립원에게 넘긴다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"의장원","certLic":"양복기능사, 양장기능사","dJobECd":"8621","dJobECdNm":"[8621]패턴사","dJobJCd":"7211","dJobJCdNm":"[7211]패턴사","dJobICd":"C133","dJobICdNm":"[C133]편조원단 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;