INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004559:1', '{"dJobCd":"K000004559","dJobCdSeq":"1","dJobNm":"재난정보시스템기획관리자","workSum":"효율적인 재난관리업무를 지원하기 위해 각종 재난정보를 분류·체계화하여 실시간 의사결정을 지원하는 스마트재난정보시스템을 기획·관리한다.","doWork":"재난위험 예측에 필요한 데이터를 유형에 따라 추출하고 검증하여 재난 분석에 필요한 형태로 수집한다. 수집한 데이터를 분석 목적에 따라 대조, 분류, 집계한다. 데이터를 분석하여 재난징후를 파악하고 시각화한다. 위해(危害)의 원리를 분석하고, 이를 바탕으로 위해의 빈도와 규모를 평가하여 재난의 피해규모를 시·공간적으로 파악한다. 재난관리 역량을 분석하고 재난현장의 취약성을 구조적, 비구조적, 시스템적으로 구분하고 평가한다. 위험요소 모델링, 재난 피해규모 평가, 사회적·경제적 영향평가, 기술적 재해영향을 평가한다. 재난예측 인공지능을 활용하여 재난위험지도를 작성한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"수자원개발기술사, 토목구조기술사, 토질및기초기술사, 도시계획기술사, 정보관리기술사, 도시계획기사, 토목기사","dJobECd":"1581","dJobECdNm":"[1581]방재 기술자 및 연구원","dJobJCd":"2361","dJobJCdNm":"[2361]방재 기술자 및 연구원","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003939:1', '{"dJobCd":"K000003939","dJobCdSeq":"1","dJobNm":"재난정보시스템설계원","workSum":"효율적인 재난관리업무를 지원하기 위해 각종 재난정보를 분류하고 체계화하여 실시간 의사결정을 지원하는 스마트재난정보시스템을 설계한다.","doWork":"재난관리(예방, 대비, 대응, 복구)에 대한 관련 법령, 제도, 관련 업무매뉴얼, 재난관리 시나리오, 유관기관의 업무현황 등을 파악한다. 재난 유형별로 구체적인 관리대상을 설정하고 재난관리 표준모델, 분야별 특성에 따른 재난관리 목표, 수행계획, 업무흐름도를 수립한다. 재난정보관리시스템에 적용 가능한 스마트기술(ICBM:사물인터넷, 클라우드 컴퓨팅, 빅데이터, 모바일, 인공지능 기술)을 조사·선정하고 재난현장 및 정보수집·운영체계에 적용한다. 재난관리 목표달성을 위한 재난정보관리계획을 수립하고 업무로드맵을 작성한다. 재난 규모 및 유형에 따라 대용량의 각종 재난정보를 분류하고 체계화하여 실시간 의사결정을 지원할 수 있는 스마트재난정보시스템을 설계하고 구축한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"수자원개발기술사, 토목구조기술사, 토질및기초기술사, 도시계획기술사, 정보관리기술사, 도시계획기사, 토목기사","dJobECd":"1581","dJobECdNm":"[1581]방재 기술자 및 연구원","dJobJCd":"2361","dJobJCdNm":"[2361]방재 기술자 및 연구원","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004653:1', '{"dJobCd":"K000004653","dJobCdSeq":"1","dJobNm":"소방감리원","workSum":"소방시설 설계의 적법성과 적합성을 검토하고, 공사감리를 계획, 행정처리, 수행, 결과보고를 한다.","doWork":"발주자를 대신하여 설계계획서, 설계설명서, 기본설계도서, 종합방재계획서, 실시설계도서를 검토하고 설계공정을 관리한다. 계획된 공사기간을 준수하고 규정된 시공품질을 확보하기 위하여 감리공정표, 감리자 지정신고서, 품질·안전 계획서, 투입인력 계획서, 자재승인, 시공검측, 감리일지를 작성하고, 설계도서를 검토한다. 시공된 시설이 설계도서와 관련 법규를 충족하는지와 시설의 시운전 결과가 설계성능을 만족하였는지 판단하기 위하여 준공검사보고서, 감리결과 보고서, 시설물 유지관리 지침서를 작성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","certLic":"소방기술사, 소방설비기사(기계), 소방설비기사(전기), 소방설비산업기사(기계) 소방설비산업기사(전기)","dJobECd":"1582","dJobECdNm":"[1582]소방공학 기술자 및 연구원","dJobJCd":"2362","dJobJCdNm":"[2362]소방공학 기술자 및 연구원","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004635:1', '{"dJobCd":"K000004635","dJobCdSeq":"1","dJobNm":"소방시공기술자","workSum":"소방시설공사를 계획, 관리하며 소방 관련 설비를 시공한다.","doWork":"시공직무를 수행하기 위해 설계도서를 검토하고 실행내역서 및 시공계획서를 작성한다. 적합한 공정관리, 품질관리, 자재관리, 노무관리를 수행한다. 설계도서에 따라 옥·내외 소화전설비, 스프링클러설비, 물·미분무소화설비, 포·강화액소화설비, 이산화탄소소화설비, 할로겐화합물소화설비, 청정소화약제소화설비, 분말소화설비, 소화기구, 동화재탐지설비, 비상방송설비, 자동화재속보설비 등을 시공한다. 소방시설의 적법성, 적정성을 확인하기 위하여 완공검사의 일환으로 각 소방설비의 성능을 시험한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"소방기술사, 소방설비기사(기계), 소방설비기사(전기), 소방설비산업기사(기계), 소방설비산업기사(전기), 건축기계설비기술사, 건축시공기술사, 전기설비기술사","dJobECd":"1582","dJobECdNm":"[1582]소방공학 기술자 및 연구원","dJobJCd":"2362","dJobJCdNm":"[2362]소방공학 기술자 및 연구원","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001387:1', '{"dJobCd":"K000001387","dJobCdSeq":"1","dJobNm":"소방시설설계기술자","workSum":"소방시설을 설계하고, 화재안전성능 확보를 위한 계획 수립 및 기술적 검토를 수행한다.","doWork":"소방시설을 설계하기 위하여 설계공정표, 투입인력계획서, 성과물 목록표, 품질관리계획서를 작성한다. 소방대물의 규모·용도·위험성과 신기술·신공법 반영, 사례조사, 관련법규 조사, 적용설비 등을 검토하여 설계를 준비한다. 실시설계를 하기 위해 관련 도서를 검토하고 소방시설 계통도를 작성하며 기준층 평면도 작성, 장비배치도 작성, 예상 공사비 산출을 한다. 화재로 인한 인명피해와 재산손실을 최소화하기 위하여 특정 소방대상물의 내화구조, 방화구획을 검토하고, 화재·피난 시뮬레이션을 실시하며 피난계획서를 작성하고 종합방재계획을 수립한다. 공학적 기법을 활용한 화재안전대책과 강화된 화재안전대책을 수립하기 위하여 성능위주 설계요소를 적용하고 피난안전성 확보방안을 작성한다. 종합재난관리체제를 구축하고 내진설계와 공간구조·배치계획을 수립하며 피난계획과 제연계획 수립, 보안·테러·침수·해일 대비계획을 수립한다. 기본설계에서 제시한 설계기준에 따라 인허가도면, 시공도면, 계산서, 공사시방서, 공사비내역서, 자가발전설비 계산서, 설계도면, 설계완료 보고서를 작성하고 준공도서를 확인한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"협의","workFunc3":"정밀작업","similarNm":"소방설계전문가, 소방시설설계자","connectJob":"소방방재설계기술자","certLic":"소방기술사, 소방설비기사(기계), 소방설비기사(전기), 소방설비산업기사(기계) 소방설비산업기사(전기)","dJobECd":"1582","dJobECdNm":"[1582]소방공학 기술자 및 연구원","dJobJCd":"2362","dJobJCdNm":"[2362]소방공학 기술자 및 연구원","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004584:1', '{"dJobCd":"K000004584","dJobCdSeq":"1","dJobNm":"소방안전관리자","workSum":"소방대상물의 화재안전을 위한 계획을 수립하고, 이에 따른 소방안전교육과 소방시설을 관리 및 유지보수한다.","doWork":"담당하는 특정소방대상물에 관한 예산편성을 계획하고 점검 이력사항을 파악하며 점검·정비 계획을 수립한다. 교육훈련 일정을 수립하여 교육대상자에게 효과적인 강의와 교안으로 교육훈련을 실시하고 비상시 대응력을 키우기 위한 안전교육 훈련을 한다. 소방관리 부분의 위험요소를 파악하고 공사장 소방안전관리, 소방안전관리감독, 화기취급감독을 한다. 소화전, 비상경보설비 등 소화설비 및 경보설비의 이상 유무를 점검한다. 화재 시 피난안전성을 확보하고, 소화활동·방화시설의 정상작동을 위하여 피난설비, 건축방화시설 등을 점검한다. 소방대상물의 주·월·연간 점검계획을 수립하여 점검을 시행하고 보고서를 작성 및 제출하며, 대책을 수립한다. 법정 소방점검 이외에 특정 소방대상물의 관계인의 요청에 따라 건축물의 소방시설에 대한 설비의 적정한 설치 상태를 유지하며, 화재발생 시 원인을 파악하며, 설비의 정상작동 여부를 확인하고 평상시 유지 관리와 보수를 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"수동조작","certLic":"소방기술사, 소방시설관리사, 소방안전교육사","dJobECd":"1582","dJobECdNm":"[1582]소방공학 기술자 및 연구원","dJobJCd":"2362","dJobJCdNm":"[2362]소방공학 기술자 및 연구원","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004907:1', '{"dJobCd":"K000004907","dJobCdSeq":"1","dJobNm":"소방공학시험원","workSum":"기존 설비 및 장비의 성능을 개선하거나 새로운 제품 및 장비의 개발을 위해 각종 소방 설비, 장비, 부품을 시험·검사한다.","doWork":"새로운 소화기류, 경보기류, 기계류, 방염류 등에 대해 형식승인 또는 성능인증 신청서류를 접수받는다. 검사에 필요한 제품명세서, 시험시설명세서, 시제품 등을 확인한다. 각종 검사장비를 사용하여 형상, 구조, 재질, 성분 및 성능을 시험하고 시험성적서를 작성한다. 관련 기준에 따라 적합, 부적합 또는 보완사항을 판정한다. 형식승인 또는 성능인증을 득하여 생산되는 제품 또는 제조과정을 검사하여 구조·성능이 승인사항과 일치하고 기술기준에 적합한지 판정한다. 소방관련 제도에 따라 KFI인정(한국소방산업기술원인정), 저발화성담배 성능인증, 선박용물건형식승인, 고효율시험, 우수품질인증, 조달물품검사, 방염성능검사, 위험물탱크검사, 위험물제조소 검사, 위험물제품검사, 소방장비검사, 소방장비 정밀점검 등 다양한 시험 및 검사를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"소방설비산업기사(전기분야), 소방설비산업기사(기계분야)","dJobECd":"1583","dJobECdNm":"[1583]소방공학 시험원","dJobJCd":"2363","dJobJCdNm":"[2363]소방공학 시험원","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004432:1', '{"dJobCd":"K000004432","dJobCdSeq":"1","dJobNm":"소방시설관리사","workSum":"소방대상물 관계자의 소방안전관리 업무를 대행하여 소화전, 스프링클러 등 소방시설을 점검하고 설치기준 및 국가화재안전 기준에 따라 유지·관리한다.","doWork":"소방대상물 관계인과의 계약을 통해 안전관리 또는 소방시설의 점검을 위탁받아  점검대상처, 점검유형, 소방 관련 도면, 전년도 점검결과 보고서, 소방시설, 소방시설점검표, 점검지침서, 관련법령 등을 확인한다. 소화전밸브압력계, 방수압력측정계, 절연저항계, 폐쇄력측정기, 입도계, 열감지시험기, 누전계, 차압계 등 각종 소방점검 장비를 준비하고 관리한다. 점검대상처에 방문하여 소방시설의 설치상태, 화재발생 시 원인 파악, 설비의 정상작동 여부, 평상시 유지관리, 보수 등을 점검한다. 가스계·분말소화설비, 소화기구·수계소화설비 등 소화설비를 점검한다. 자동화재탐지설비, 비상경보설비, 비상방송설비, 자동화재속보설비 등 경보설비를 점검한다. 피난설비, 제연설비, 연결송수관·연결살수설비, 비상콘센트, 무선통신보조설비, 연소방지설비, 건축방화시설, 비상전원설비 등 피난·소화활동·방화시설을 점검한다. 점검결과를 종합하여 보고서를 작성하고 건물주, 소방서 등에 제출한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"소방시설관리사","dJobECd":"1583","dJobECdNm":"[1583]소방공학 시험원","dJobJCd":"2363","dJobJCdNm":"[2363]소방공학 시험원","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006212:1', '{"dJobCd":"K000006212","dJobCdSeq":"1","dJobNm":"가스관로안전관리원","workSum":"가스관로의 안전성을 확보하기 위하여 관로순찰원의 활동을 감독하고 관로를 관리하는 제반 업무를 수행한다.","doWork":"가스가 흐르는 관로의 안전성을 확보하기 위하여 가스관로순찰원에게 관로와 부속시설물의 상태 및 위험요소 등에 대한 감시를 지시한다. 가스관로순찰원으로부터 이상 유무를 보고받고 기록한다. 배관의 이동, 건설현장, 도로 공사 등 각종 공사에 따른 안전성 확보를 위하여 인·허가 및 현장을 감독한다. 가스관로의 누설 검사를 위하여 센서와 가스누설탐지 차량을 이용하여 누설 검사를 한다. 효율적인 관리를 위하여 가스배관망의 정보시스템을 이용한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"균형감각|","workFunc1":"조정","workFunc2":"감독","workFunc3":"수동조작","certLic":"가스기사, 가스산업기사, 산업안전기사","dJobECd":"1584","dJobECdNm":"[1584]산업 안전원 및 위험 관리원","dJobJCd":"2364","dJobJCdNm":"[2364]산업 안전 및 위험 관리원","dJobICd":"D352","dJobICdNm":"[D352]연료용 가스 제조 및 배관공급업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003218:1', '{"dJobCd":"K000003218","dJobCdSeq":"1","dJobNm":"가스시설안전관리원","workSum":"가스 생산시설에서의 각종 설비 및 작업원 안전, 가스 공급을 위한 배관망, 수용가 등에 대한 설비품질의 점검 및 안전진단을 한다.","doWork":"가스시설 내 안전관리를 위한 세부계획을 수립한다. 안전기술 검토와 절차 개선을 위한 자료 수집과 분석을 한다. 작업장소를 순회하여 시설의 안전성 여부를 점검하고, 작업에 따른 위험요인을 사전예방하기 위하여 응급조치 또는 적절한 방지조치를 한다. 안전장치 및 안전에 관련된 각종 보호구의 성능확인과 정기점검을 한다. 가스생산기지 내의 안전조치를 요하는 지역에서의 안전수칙 및 대처방법 등에 대한 안전표시물을 부착·관리하고 소방대를 운영·관리한다. 사고예방 및 방지를 위한 작업자 안전교육과 훈련을 실시한다. 안전 관련 대관 인·허가 및 점검 등에 대한 행정업무를 한다. 가스생산기지 내의 안전 관련 주요 사항을 기록·보존한다. 탱크류, LPG충전소, 도시가스제조시설의 안전도를 확인하기 위하여 현장을 방문하여 설계나 각종 기술사항을 검토하여 완성검사를 한다. 기계설비나 전기설비 운전 시 입회하여 운전상태를 확인하고 정비설비에 대한 자료를 수집하고 검토한다. 설비정비 기본방향을 수립하고, 정비현장에 입회하여 점검한다. 도시가스시설 건설공사 시 용접절차사양서를 작성하고 용접원의 기량을 시험하여 결과를 판정하고 공사에 배치한다. 각종 시설이 설계도에 맞게 설치되었는지 확인한다. 비파괴검사를 위해 도면, 시방서 등을 검토한다. 비파괴검사 물량을 산출하고 설계서를 작성하여 용역계약을 관련 부서에 의뢰한다. 수용가에서 가스표본을 채취하여 부취농도를 시험하고 문제점을 규명한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"가스기사, 일반기계기사, 전기기사, 산업안전","dJobECd":"1584","dJobECdNm":"[1584]산업 안전원 및 위험 관리원","dJobJCd":"2364","dJobJCdNm":"[2364]산업 안전 및 위험 관리원","dJobICd":"D352","dJobICdNm":"[D352]연료용 가스 제조 및 배관공급업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005321:1', '{"dJobCd":"K000005321","dJobCdSeq":"1","dJobNm":"건설안전관리원","workSum":"건설현장에서 작업원의 안전과 건설재해요인 예측, 재해예방 등을 위하여 각종 설비의 안전성 확보 및 안전관리를 위한 제반 업무를 수행한다.","doWork":"건설재해예방을 위한 세부계획을 수립한다. 안전기술 검토와 절차서 개선을 위한 자료를 수집하고 분석한다. 작업현장을 순회하여 안전장치 및 보호구를 정기적으로 점검하고, 위험요인 예방대책을 수립한다. 작업환경 개선, 유해 위험방지 등의 안전에 관한 기술적인 사항을 관리한다. 건설물이나 설비작업의 위험에 따른 응급조치를 한다. 산업재해가 발생하면 사고경과를 조사하고 원인을 규명하여 사고재발 방지대책을 모색하고 대외기관에 대한 섭외업무를 수행한다. 작업원 및 관리자를 대상으로 안전 및 방화교육을 실시한다. 안전관리책임자의 지시에 따라 안전관리를 실시하고 작업과정에서 발생한 주요 사항을 보고한다. 필요한 경우 전문업체에 의뢰하여 안전성 검사를 실시하고 시설물에 대한 비파괴검사를 한다. 시설물 점검 후 이상 시에는 전문 수리업체에 수리를 의뢰한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"건설안전기술자","connectJob":"건축안전기술자, 토목안전환경기술자","certLic":"산업안전기사, 산업안전지도사, 건설안전기술사, 건설안전기사, 건설안전산업기사","dJobECd":"1584","dJobECdNm":"[1584]산업 안전원 및 위험 관리원","dJobJCd":"2364","dJobJCdNm":"[2364]산업 안전 및 위험 관리원","dJobICd":"F411/F412","dJobICdNm":"[F411]건물 건설업 / [F412]토목 건설업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004353:1', '{"dJobCd":"K000004353","dJobCdSeq":"1","dJobNm":"광업안전감독자","workSum":"광업소의 조업과 작업원의 안전관리를 위하여 작업장에 발생할 수 있는 위해 및 광해를 사전 조사하고 안전사고 발생 시 안전조치를 취한다.","doWork":"광산 내를 정기 또는 수시로 순시하여 조업 상 사용하는 기계 및 기구, 건설물 및 공작물 등의 시설, 동력시설, 화약류 및 관련 재료, 화약취급 상황 등을 조사한다. 정기적으로 채광방법을 검토하여 채굴의 난이도를 파악한다. 광산시설의 사용, 정지, 수리, 개조 및 이전, 광업실시 방법의 개선 및 기타 보안에 필요한 사항을 조사한다. 재해발생 시에 응급구조조치 또는 위험방지조치를 한다. 조사된 사항을 일지에 기록하고 문제점이 나타나면 광업안전보안관리자 또는 광업안전보안원에게 통보하여 시정을 권고하고 조치된 사항을 확인한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","certLic":"광산보안기사, 광산보안산업기사, 광산보안기능사","dJobECd":"1584","dJobECdNm":"[1584]산업 안전원 및 위험 관리원","dJobJCd":"2364","dJobJCdNm":"[2364]산업 안전 및 위험 관리원","dJobICd":"B051/B061/B062","dJobICdNm":"[B051]석탄 광업 / [B061]철 광업 / [B062]비철금속 광업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006990:1', '{"dJobCd":"K000006990","dJobCdSeq":"1","dJobNm":"광업안전보안원","workSum":"광업소의 갱내, 갱외, 기계, 전기, 화약, 발파, 방폭 등에서 발생할 수 있는 위해 및 광해로부터 작업원의 피해를 방지하기 위하여 점검·확인함으로써 작업원의 안전을 관리한다.","doWork":"안전보안관리자에게 보안계획 및 관리사항을 지시받아 보안과정을 숙지하고 작업에 필요한 측정기 및 각종 기기를 점검한다. 각 작업장의 출입자 및 인원현황을 파악하고, 일정한 시간마다 순회하여 보안사항을 점검한다. 가스검정기·풍속기 등을 사용하여 갱내의 가스량·통기량 등을 측정하고 입갱자들의 발화물질 휴대를 검사한다. 갱내외 낙반 및 붕괴에 대비하여 지주를 점검하고 이상이 발견될 때 지주의 회수 및 보수를 지시한다. 채탄 및 굴진 작업장의 안전사항을 점검하고, 위험발생이 예상되면 작업원을 대피소로 대피시킨다. 화약류의 저장·운반·사용 및 안전상태를 점검한다. 발파 시 작업원을 안전장소로 대피시키고 발파 전후의 상황을 점검한다. 측정기를 사용하여 전선의 마모·부식·누전·절연상태를 점검하고 안전 등의 충전상태 및 이상 유무를 점검·관리한다. 갱내외 시설물 및 배수시설 상태를 점검한다. 화재발생 가능지역을 점검하고, 방화시설상태를 점검한다. 채굴시설, 광차, 기관차, 파쇄기, 착암기 등 광산기계 및 장비의 안전상태를 점검한다. 보안점검일지 및 보고서를 작성하여 광업안전보안관리자에게 보고한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"광업보안원","connectJob":"갱내안전계원, 갱외안전계원, 기계안전계원, 전기안전계원, 화약발파안전계원, 광해안전계원","certLic":"광산보안기능사, 광산보안산업기사, 광산보안기사, 화약취급기능사, 화약류관리기술사, 화약류관리기사, 화약류관리산업기사","dJobECd":"1584","dJobECdNm":"[1584]산업 안전원 및 위험 관리원","dJobJCd":"2364","dJobJCdNm":"[2364]산업 안전 및 위험 관리원","dJobICd":"B051/B061/B062","dJobICdNm":"[B051]석탄 광업 / [B061]철 광업 / [B062]비철금속 광업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004288:1', '{"dJobCd":"K000004288","dJobCdSeq":"1","dJobNm":"궤도시설안전검사원","workSum":"관광지 등에서 승객을 운송하는 케이블카, 모노레일 등 궤도시설에 대한 성능 및 안전성유지를 위하여 전기‧기계‧토목 분야의 공학적인 전문지식을 바탕으로 검사‧진단 장비를 활용하여 관련 규정의 적합성 여부를 확인한다.","doWork":"케이블카, 모노레일 등 궤도시설을 설치하기 전 설계도면, 기술문서 등 관련된 문서가 관련규정에 적합여부를 확인한다. 운영단계에서는 검사장비 장비를 활용하여 설비진단 및 안전관리계획 이행여부를 확인 운행 단계의 안전성 여부를 확인한다. 아울러 사고예방을 위해 사고조사 및 예방대책 마련, 관련 종사자에 대한 전문교육 실시, 해외 안전관리체계 및 기술기준에 대한 조사‧연구를 실시하여 제도개선 방안도 마련한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"수동조작","certLic":"일반기계기사, 건설기계설비기사, 설비보전기사, 기계설계산업기사, 건설기계설비산업기사, 전기기사, 전기산업기사","dJobECd":"1584","dJobECdNm":"[1584]산업 안전원 및 위험 관리원","dJobJCd":"2364","dJobJCdNm":"[2364]산업 안전 및 위험 관리원","dJobICd":"H492","dJobICdNm":"[H492]육상 여객 운송업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001549:1', '{"dJobCd":"K000001549","dJobCdSeq":"1","dJobNm":"궤도시설안전관리자","workSum":"케이블카, 모노레일 등 궤도시설의 안전사고 예방 등을 위하여 궤도운송종사자를 관리하고 서비스 안내원에게 안전관리교육을 한다.","doWork":"케이블카, 모노레일 등 궤도시설의 안전사고 예방을 위하여 안전점검, 시설정비 등의 업무를 총괄 관리하고 궤도운송종사자를 지휘‧감독한다. 매년 안전관리계획을 수립하여 운행 가능여부 확인, 자체 안전점검과 시설정비가 지속적으로 유지 되도록 관리‧ 감독한다. 비상 시 탑승객구조 등을 지휘‧감독하며 필요 시 사고재발 방지 대책 등을 마련한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"조작운전","certLic":"교통안전관리자(삭도)","dJobECd":"1584","dJobECdNm":"[1584]산업 안전원 및 위험 관리원","dJobJCd":"2364","dJobJCdNm":"[2364]산업 안전 및 위험 관리원","dJobICd":"H492","dJobICdNm":"[H492]육상 여객 운송업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006019:1', '{"dJobCd":"K000006019","dJobCdSeq":"1","dJobNm":"기계식주차장검사원","workSum":"기계식 주차장의 성능과 안전도 확보를 위하여 설계단계의 안전기준 적합 여부를 검사하는 설계서 안전도 심사를 하고, 기계식주차장 설치 완료 후 사고예방을 위하여 사용검사와 정기검사를 실시한다.","doWork":"기계식 주차장을 설치하기 전 주차기 설계도면의 법적 안전성 및 기계 안전성을 검사하기 위하여 설계서 안전도 심사를 실시한다. 설계서 안전도 심사에서 승인 받은 설계서와 현장시설물에 대하여 안전장치, 기계장치, 재료규격 및 주차장 규격 등을 비교하는 사용검사를 한다. 설치된 기계식 주차장의 용도변경 여부 및 성능을 확인하는 정기검사를 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"수동조작","dJobECd":"1584","dJobECdNm":"[1584]산업 안전원 및 위험 관리원","dJobJCd":"2364","dJobJCdNm":"[2364]산업 안전 및 위험 관리원","dJobICd":"F422","dJobICdNm":"[F422]건물설비 설치 공사업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002440:1', '{"dJobCd":"K000002440","dJobCdSeq":"1","dJobNm":"반도체재료안전관리기술자","workSum":"반도체재료의 물성, 물질안전자료, 제반 법규 및 관리규정 등을 이해하고, 재료 개발·생산현장을 고려한 사고발생 요인을 분석·예방하여 안전한 작업환경을 확보한다.","doWork":"반도체재료의 물질안전보건자료와 유독물질 관련 규정을 기준으로 사고발생 요인 및 대응방안을 구축하여 관련 기술자에게 안전사고예방 교육을 실시한다. 훈련지침을 활용하여 사고 발생을 사전에 방지하며, 사고발생 시 원인분석, 재발방지 대책에 대한 보고서를 작성·공유한다. 반도체재료 생산라인 근무자 대상으로 안전보호구 등 각종 안전 관련 도구, 장치 및 장비 사용방법, 응급조치 교육을 주기적으로 실시한다. 반도체재료 생산현장에서 발생할 수 있는 위험 요인들을 조사하고, 위험 등급을 분류하여 공유한다. 사고발생 위험요인을 주기적으로 사전 점검할 수 있도록 관리하며, 잠재적 비상사태에 대한 대응 매뉴얼을 작성·공유하며, 정기 대응훈련 계획을 수립·실행한다. 반도체재료 생산현장에서 발생하는 산업폐기물의 종류와 특성을 분류하고, 관련 법규에 따라 안전하게 처리하도록 지원한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"1584","dJobECdNm":"[1584]산업 안전원 및 위험 관리원","dJobJCd":"2364","dJobJCdNm":"[2364]산업 안전 및 위험 관리원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001740:1', '{"dJobCd":"K000001740","dJobCdSeq":"1","dJobNm":"방사선기술자","workSum":"방사선 설비의 조작기술의 향상을 위한 각종 기술표준서의 작성과 방사선 관련 작업원의 안전관리 및 교육을 주관하고 방사선 설비의 시설관리 업무를 총괄한다.","doWork":"방사선 설비의 사양을 검토·조정하고 신기술 도입방안을 연구한다. 방사선 시설의 관리체계를 수립하고 일상 및 정기 점검계획을 작성·실시한다. 방사선에 관한 관계법령에 따라 필요한 보호조치를 실시하고 이에 따른 허가, 보고서제출, 정기검사수검 등의 행정업무를 수행한다. 방사선 장해예방을 위한 기술표준서를 작성·시행한다. 각종 방사선 측정기구, 보호기구를 유지·관리하고 방사선의 위험정도를 검측·조사한다. 방사선 취급시설 및 기기의 점검과 위험표시를 하고 취급자에 대한 안전교육을 실시한다. 방사선 사고자에 대한 응급조치, 방사선 오염물에 의한 위험방지 조치를 취한다. 방사선량을 측정하여 기록을 보존한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"방사선관리기술사, 원자력기사","dJobECd":"1584","dJobECdNm":"[1584]산업 안전원 및 위험 관리원","dJobJCd":"2364","dJobJCdNm":"[2364]산업 안전 및 위험 관리원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007173:1', '{"dJobCd":"K000007173","dJobCdSeq":"1","dJobNm":"보건관리자","workSum":"근로자의 안전을 위하여 보건교육 계획을 수립 및 실시하고 작업장의 위험요인에 대해 점검하고 평가를 실시하는 업무를 수행한다.","doWork":"정기적으로 사업장을 순회점검한다. 유해·위험 요인을 찾는 위험성 평가를 실시한다. 보건과 관련된 보호구 구입 시 적격품 선정에 관하여 지도 및 조언한다. 화학물질에 대하여 작성된 물질안전보건자료의 게시에 관하여 지도 및 조언한다. 사업장의 보건교육 계획을 수립하고 교육 실시에 대하여 보좌한다. 작업현장의 환기 및 국소 배기장치 등에 대해 설비 점검을 실시한다. 설비와 장비 점검 결과를 바탕으로 공학적 개선에 대하여 지도 및 조언한다. 산업재해 발생 시, 사고의 원인을 조사 및 분석한다. 재발방지를 위하여 위험성을 모색하고, 대책 수립 계획에 대해 조언한다. 안전관리자와 협의하여 업무를 수행한다. 의사 및 간호사 면허를 소지한 경우 사업장 근로자의 보호를 위한 의료행위를 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"안전보건관리자, 산업간호사","certLic":"의사, 간호사, 산업위생관리산업기사, 대기환경산업기사, 인간공학기사","dJobECd":"1584","dJobECdNm":"[1584]산업 안전원 및 위험 관리원","dJobJCd":"2364","dJobJCdNm":"[2364]산업 안전 및 위험 관리원","dJobICd":"C","dJobICdNm":"[C]제조업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007209:1', '{"dJobCd":"K000007209","dJobCdSeq":"1","dJobNm":"석유화학안전관리자","workSum":"석유화학제품 사업장 작업자의 안전사고를 예방하기 위해 안전·보건 점검원의 업무를 지시하고 감독하며 관련 법규에 따라 대책 수립, 위험성 평가, 교육 등을 수행한다.","doWork":"사고의 발생 원인을 파악하고 분석하여 재발방지대책을 수립한다. 휴먼 에러 빈도 및 유형을 파악하고, 휴먼 에러 예방 원칙을 수립하여 휴먼 에러 예방 대책에 적용한다. 위험성 및 유해 위험 요인을 파악하고, 위험성 감소대책을 수립하고 시행한다. 유형별 사고 사례 파악 및 사고 발생 시 응급조치 및 사고현장 복구 등 적절한 대응을 하고, 사고대비 훈련과 안전·보건 교육을 실시한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"1584","dJobECdNm":"[1584]산업 안전원 및 위험 관리원","dJobJCd":"2364","dJobJCdNm":"[2364]산업 안전 및 위험 관리원","dJobICd":"C201/M","dJobICdNm":"[C201]기초 화학물질 제조업 / [M]전문, 과학 및 기술 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007210:1', '{"dJobCd":"K000007210","dJobCdSeq":"1","dJobNm":"석유화학안전점검원","workSum":"석유화학제품 사업장 작업자의 안전을 확보하고 화재·폭발·누출사고 피해를 최소화하기 위하여 작업현장을 수시로 점검한다.","doWork":"현장의 안전을 위해 안전 점검을 실시하고 안전관리 수준을 평가하여 안전점검표를 작성하고 관리한다. 화재·폭발·누출사고 피해를 최소화하고, 화재·폭발·누출 사고 예방을 위해 화재·폭발·누출 다발물질 및 설비를 파악한다. 누출사고 유형을 파악하여 화재·폭발·누출방지 대책을 수립한다. 위험물 및 소방시설 점검항목과 고압가스 점검항목을 확인하고, 점검하여 결과보고서를 작성한다. 작업환경 측정과 작업환경 개선 대상을 파악하여 조치하고 현장 작업자들의 건강검진을 실시하고, 건강검진 결과보고서를 작성·관리하며 유소견자를 관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"수동조작","dJobECd":"1584","dJobECdNm":"[1584]산업 안전원 및 위험 관리원","dJobJCd":"2364","dJobJCdNm":"[2364]산업 안전 및 위험 관리원","dJobICd":"C201/M","dJobICdNm":"[C201]기초 화학물질 제조업 / [M]전문, 과학 및 기술 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004949:1', '{"dJobCd":"K000004949","dJobCdSeq":"1","dJobNm":"소수력발전토목설비안전관리원","workSum":"댐의 구조안전을 점검하고 전기설비를 제외한 수력설비의 유지 및 운용에 관한 안전관리를 한다.","doWork":"소수력발전소의 구조물과 댐 구조물의 누수나 크랙(금)이 발생하였는지 육안으로 검사하고 필요에 따라 비파괴 검사 등을 실시하여 안전을 점검한다. 전기설비를 제외한 수차, 가동보 등의 수력설비의 이상 유무를 점거하고 이상 발생 시 유지 보수를 실시하여 전기발전에 이상이 없도록 조치한다. 가동보의 동작상태와 안전관리를 실시하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"수동조작","certLic":"건설안전기술사, 건설안전기사, 건설안전산업","dJobECd":"1584","dJobECdNm":"[1584]산업 안전원 및 위험 관리원","dJobJCd":"2364","dJobJCdNm":"[2364]산업 안전 및 위험 관리원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001843:1', '{"dJobCd":"K000001843","dJobCdSeq":"1","dJobNm":"수력발전전기설비안전관리원","workSum":"수력발전(소수력발전포함) 전기설비의 유지 및 운용과 전기수용설비 및 비상용 예비발전설비의 안전관리를 실시한다.","doWork":"수력발전소에 설치된 변압기, 배전반, 발전기의 제어시설 등과 전기선로, 계측기기 등의 전기설비의 이상 유무를 확인하고 점검표를 작성하여 보관한다. 전기시설을 운용하고 작동 이상 시 원인을 분석하며, 전기발전에 지장을 줄 경우 관리자에게 통보하고 전기 생산을 중지하도록 한다. 전기수용 설비 및 비상용 예비발전설비의 안전관리를 수행한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"발송배전기술사, 전기응용기술사, 전기공사기사, 전기기사","dJobECd":"1584","dJobECdNm":"[1584]산업 안전원 및 위험 관리원","dJobJCd":"2364","dJobJCdNm":"[2364]산업 안전 및 위험 관리원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001250:1', '{"dJobCd":"K000001250","dJobCdSeq":"1","dJobNm":"수소충전소안전관리자","workSum":"수소충전소의 설비, 시설, 운영 등에 대한 안전관리를 담당하며 수소 누출, 폭발, 화재 등 사고를 예방하고 대응한다.","doWork":"수소충전소의 불꽃감지기, 수소가스감지기, 인터록 안전장치 등 안전장치를 점검하고 작업과정이 안전한지 관리한다. 산업통상자원부령으로 정하는 사항을 포함한 안전관리규정을 기준으로 안전관리 기록을 작성하고 보존한다. 수소 누출, 폭발, 화재 등 사고를 예방하기 위해 불안전한 시설이나 행동요인 등을 시정하여 위해를 방지한다. 수소충전소 내 종사자(작업원)가 있을 시 종사자(작업원) 업무를 지휘하고 감독한다. 이상 상태 발생 시 응급조치를 하고 안전관리책임자에게 보고한다. 종사자 및 협력업체 직원에게 안전교육을 실시한다. 충전시설의 공사 및 수리보수 등을 감독하고 관리한다. 안전관련 대관 인·허가 및 점검 등에 대한 행정업무를 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"가스기능사, 가스산업기사, 가스기사, 일반시설안전관리자교육 등 양성교육","dJobECd":"1584","dJobECdNm":"[1584]산업 안전원 및 위험 관리원","dJobJCd":"2364","dJobJCdNm":"[2364]산업 안전 및 위험 관리원","dJobICd":"D352","dJobICdNm":"[D352]연료용 가스 제조 및 배관공급업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006894:1', '{"dJobCd":"K000006894","dJobCdSeq":"1","dJobNm":"승강기검사원","workSum":"각종 측정장비를 사용하여 승강기의 작동상태와 안전성 여부를 검사한다.","doWork":"관리주체(승강기 소유주)에게 검사 유효기간의 만료를 고지한다. 검사신청서를 접수하고 검사 일정계획을 수립한다. 진동계, 소음계, 전류계, 속도계 등의 측정장비를 점검한다. 서류검토를 통해 법률 위반사항 여부를 확인한다. 제어반, 권상기, 조속기 등의 기계실을 검사한다. 승강로에 진입하여 부품을 검사한다. 피트(저층기계장치)에서 누수나 완충기의 상태를 검사한다. 승강장의 버튼과 표시기의 정상작동 유무를 검사한다. 카넷(승강기 내부)의 각종 버튼과 장비를 검사한다. 검사항목에 체크된 자료를 바탕으로 성적서를 작성한다. 합격 여부를 판정하여 관리주체에게 통보한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"수동조작","certLic":"승강기기능사, 승강기산업기사, 승강기기사","dJobECd":"1584","dJobECdNm":"[1584]산업 안전원 및 위험 관리원","dJobJCd":"2364","dJobJCdNm":"[2364]산업 안전 및 위험 관리원","dJobICd":"M729","dJobICdNm":"[M729]기타 과학기술 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005633:1', '{"dJobCd":"K000005633","dJobCdSeq":"1","dJobNm":"안전관리사무원","workSum":"종업원의 안전 작업을 위해 안전 관련 행정 및 교육업무를 수행한다.","doWork":"안전사고를 방지하기 위한 교육 계획을 수립하고 실시한다. 산업재해 등이 발생하면 관련 기관에 신고하고 이를 처리한다. 종업원의 안전규칙 준수 여부를 정기적으로 점검하고 지도한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","certLic":"산업안전지도사","dJobECd":"1584","dJobECdNm":"[1584]산업 안전원 및 위험 관리원","dJobJCd":"2364","dJobJCdNm":"[2364]산업 안전 및 위험 관리원","dJobICd":"C","dJobICdNm":"[C]제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005552:1', '{"dJobCd":"K000005552","dJobCdSeq":"1","dJobNm":"안전위생관리기술자","workSum":"산업재해 예방계획의 수립에 관한 사항을 수행하며, 작업환경의 점검 및 개선에 관한 사항, 위해(危害) 및 위험방지에 관한 사항, 사고사례 분석 및 개선에 관한 사항, 근로자의 안전교육 및 훈련에 관한 업무를 수행한다.","doWork":"현장조사, 재해보고서, 재해통계자료, 국내외 안전위생 관계 문헌 등의 자료를 수집·분석하고 작업원의 건강진단 등에 대한 안전 및 위생 종합관리 계획을 입안한다. 중대재해 예방대책을 수립하고 안전위생 관리기준을 설정한다. 연간 안전위생 교육계획을 수립하고 재해 및 위생사례집 등 교육교재를 개발하여 현장에 보급한다. 연수원 집합교육, 현장직무교육 시 안전교육 자료를 작성 재해예방 및 각종 사고 예방교육을 실시한다. 정기적으로 현장을 순회하고 점검하여 불안전 요인을 제거한다. 현장 여건에 적합한 안전위생 활동기법을 개선·보급한다. 재해 및 위생사고 발행 시 현상분석을 통하여 기술적 보완대책을 수립한다. 위험한 기계 및 기구에 대한 자체 검사계획을 수립하여 위해 요인을 제거한다. 안전보호구의 품질개선 및 수급관리 제도를 개선한다. 안전위생 관리지표 설정 및 목표달성 방안을 강구한다. 재해 및 각종 사고 발생 상황과 위생사고 요인 파악 및 계통을 보고한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"산업안전위생관리기술자","connectJob":"가스안전관리기술자, 기계안전관리기술자, 소방설비안전관리기술자, 전기안전관리기술자, 화공안전관리기술자","certLic":"산업안전기사, 산업위생관리기사, 산업위생관","dJobECd":"1584","dJobECdNm":"[1584]산업 안전원 및 위험 관리원","dJobJCd":"2364","dJobJCdNm":"[2364]산업 안전 및 위험 관리원","dJobICd":"C","dJobICdNm":"[C]제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002155:1', '{"dJobCd":"K000002155","dJobCdSeq":"1","dJobNm":"알아이폐기물관리원","workSum":"방사성폐기물인 알아이(RI:Radioactive Isotope)폐기물을 인수하여 운반·처리·처분하는 일을 관리한다.","doWork":"알아이(RI:Radioactive Isotope)폐기물을 처분하기 위해 인수 및 감용·운반계획을 수립한다. 잡고체 폐기물의 시료를 채취하여 방사선 측정결과를 확인하여 처분 방식을 결정한다. 고방사능량 밀봉선원폐기물의 처분시설 운반계획을 수립하고 관리한다. 알아이폐기물을 안전하게 관리하기 위해 작업장의 선량률과 오염도 및 방사능 피폭을 관리하고 방사능재난 예방 및 물리적 방호체계를 수립하고 이행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"방사성동의원소폐기물관리원","certLic":"방사성동위원소취급일반면허, 방사선취급감독자면허, 원자력기사","dJobECd":"1584","dJobECdNm":"[1584]산업 안전원 및 위험 관리원","dJobJCd":"2364","dJobJCdNm":"[2364]산업 안전 및 위험 관리원","dJobICd":"E382","dJobICdNm":"[E382]폐기물 처리업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003636:1', '{"dJobCd":"K000003636","dJobCdSeq":"1","dJobNm":"열환경안전관리원","workSum":"열기관 설비의 가동으로 인한 환경오염 및 안전사고를 사전에 예방하고 안전대책을 수립한다.","doWork":"산업안전, 보건, 환경관리 등의 관련 법규 및 규정을 검토하여 안전, 환경에 대한 중장기 기본계획 및 대응전략을 수립한다. 환경친화적 경영관리에 필요한 자료를 수집한다. 대기, 수질, 유해화학, 폐기물, 토양 등과 같은 각종 환경오염의 방지시설에 관한 기술타당성을 조사하여 검토 후 방지시설을 운영한다. 산업안전관리 이행 평가제도를 실시하여 환경오염 발생 시 혹은 안전사고 시 환경·화학설비를 진단한다. 사고원인을 조사하여 대책을 수립한다. 열기관의 설치 및 가동으로 인한 주변 환경변화를 예측하기 위해 환경영향평가를 실시하는 등 안전·환경 관련 대내외 업무를 총괄한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|고온|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"조작운전","similarNm":"열산업안전기술자","certLic":"건설안전산업기사, 에너지관리기사, 대기환경기사","dJobECd":"1584","dJobECdNm":"[1584]산업 안전원 및 위험 관리원","dJobJCd":"2364","dJobJCdNm":"[2364]산업 안전 및 위험 관리원","dJobICd":"D353","dJobICdNm":"[D353]증기, 냉·온수 및 공기조절 공급업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004770:1', '{"dJobCd":"K000004770","dJobCdSeq":"1","dJobNm":"운전정밀검사요원","workSum":"교통사고 예방을 위하여 사업용 운전자의 적성 등 행동능력을 검사하고 결함사항을 도출하여 사고 운전자를 교정하고 지도한다.","doWork":"교통사고를 예방하기 위하여 사업용 운전자의 성격, 인지-판단-조작 과정상의 불균형과 지각속도 등 심리·생리적인 특성을 분석하고 결함사항을 도출하여 안전운전에 도움이 되도록 교정·지도한다. 사업용 자동차 운전자를 대상으로 하는 신규검사와 사고자 또는 법규위반자를 대상으로 특별검사를 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"수동조작","dJobECd":"1584","dJobECdNm":"[1584]산업 안전원 및 위험 관리원","dJobJCd":"2364","dJobJCdNm":"[2364]산업 안전 및 위험 관리원","dJobICd":"O842","dJobICdNm":"[O842]사회 및 산업정책 행정","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006482:1', '{"dJobCd":"K000006482","dJobCdSeq":"1","dJobNm":"원자력안전관리원","workSum":"원자력발전소의 건설 및 운전과정에서의 안전한 시공과 가동의 안전관리에 관한 종합계획을 수립한다.","doWork":"원자력발전소의 설계과정에서 발생할 수 있는 각종 위해요인을 검토하여 예방책을 수립한다. 점검세부계획서 및 점검표를 작성하고 점검계획에 대해 관련 부서 간의 협조를 한다. 원자로 설비별로 현장점검을 실시하여 점검사항을 기록일지에 작성·관리하고 결과보고서를 작성한다. 운전 중인 주요 기기 및 설비의 신뢰성 평가자료의 수집체계를 개발·보완하여 이에 따른 평가자료를 수집·검토한다. 검토결과를 운영부서에 통보하고 발전소별 정기점검 결과를 수집·분석한다. 사고가 발생한 원자로의 손상에 관하여 평가하고 원자로의 가동중지 여부를 분석한다. 국내외 핵사고의 원인을 검토하여 사고 발생 요인을 분석한다. 설비의 안전규정에 관한 지침서를 작성하여 신입 작업원을 교육한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workEnv":"위험내재|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"제어조작","connectJob":"원자로안전책임자","certLic":"방사선관리기술사, 안전관리기사, 원자로조종사면허, 원자력기사, 방사성동위원소 취급자면허, 방사선취급 감독자면허","dJobECd":"1584","dJobECdNm":"[1584]산업 안전원 및 위험 관리원","dJobJCd":"2364","dJobJCdNm":"[2364]산업 안전 및 위험 관리원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006954:1', '{"dJobCd":"K000006954","dJobCdSeq":"1","dJobNm":"위험물취급원","workSum":"위험물이 들어있는 컨테이너를 안전하게 하역하고 보관하기 위한 안전관리를 한다.","doWork":"컨테이너 화물의 하역신청서를 접수하고 위험물의 내용을 확인하여 자료를 입력한다. 통관 수출입 물품을 보세구역 안에 임시로 보관하는 양하 및 적하 작업현장의 안전을 관리하고, 위험물 컨테이너를 장치하고 관리한다. 위험물 작업의 이행상태를 점검하고 관련 서류를 작성한다. 안전설비를 점검하고 위험물 취급에 관한 교육훈련을 한다. 재해 발생에 대비하여 안전대책을 강구하고 각종 위험물 표지판을 설치하고 관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"위험물관리원","certLic":"위험물기능사, 위험물산업기사","dJobECd":"1584","dJobECdNm":"[1584]산업 안전원 및 위험 관리원","dJobJCd":"2364","dJobJCdNm":"[2364]산업 안전 및 위험 관리원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003281:1', '{"dJobCd":"K000003281","dJobCdSeq":"1","dJobNm":"전기안전관리원","workSum":"송·변전 및 배전설비에서 발생하는 안전사고 및 재해로부터 인명과 재산을 보호하기 위하여 안전검사실시, 사고조사, 사고예방대책수립 등의 업무를 수행한다.","doWork":"안전사고 사례집, 통계집 등 안전관리교육 자료를 수집하여 안전교육지침을 작성하고, 안전검사를 수행하는 직원 및 도급업자에 대한 안전교육을 시행한다. 사업소의 관할구역을 순시하여 위해 발생요인을 제거하도록 조치하고 실적을 점검한다. 설비운영현장 및 공사현장을 확인하여 안전작업수칙의 준수 여부를 확인·점검한다. 안전장구의 관리 및 사용실태를 확인·점검하고 안전표지물의 적정 부착 유무를 점검한다. 안전회의 및 안전위원회의 개최를 준비하고, 의결사항의 시행을 독려한다. 산업안전보건 활동 강조기간, 도급자 간담회 등 기타 안전행사를 주관한다. 안전관리 활동실적을 정리·점검하고, 사업소별로 실적을 종합·분석하여 보고서를 작성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"균형감각|","workEnv":"대기환경미흡|위험내재|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"전기안전기술자","certLic":"산업안전기사, 전기안전기술사, 전기산업기사, 전기기사 ","dJobECd":"1584","dJobECdNm":"[1584]산업 안전원 및 위험 관리원","dJobJCd":"2364","dJobJCdNm":"[2364]산업 안전 및 위험 관리원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007211:1', '{"dJobCd":"K000007211","dJobCdSeq":"1","dJobNm":"정밀화학안전환경보건위생관리자","workSum":"정밀화학제품 종사 근로자들의 건강하고 안전한 작업을 지원하고 환경 및 생태계 보호를 위해 관련 법규에 따라 사업장 내 안전·환경·보건·위생 시스템을 체계적으로 관리하고 담당자를 감독한다.","doWork":"정밀화학제품 사업장의 안전·환경·소방 시설 운전의 최적화를 위해 안전·환경·보건·위생 점검원을 감독하고 안전·환경·보건·위생법규 이행계획을 수립한다. 사내 안전·환경·보건·위생규정을 관리한다. 안전·환경·보건·위생관련 사고 발생에 대응하기 위한 사고대응 시나리오를 수립하고 사고대응·사고예방 교육 및 훈련을 한다. 사고발생시 사고원인을 조사하고 사고 재발방지 대책을 수립한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"1584","dJobECdNm":"[1584]산업 안전원 및 위험 관리원","dJobJCd":"2364","dJobJCdNm":"[2364]산업 안전 및 위험 관리원","dJobICd":"C203/C204","dJobICdNm":"[C203]비료, 농약 및 살균, 살충제 제조업 / [C204]기타 화학제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007023:1', '{"dJobCd":"K000007023","dJobCdSeq":"1","dJobNm":"정밀화학안전환경보건위생점검원","workSum":"정밀화학제품 종사자의 건강, 환경 및 생태계 보호와 사업장 내 안전·환경·보건·위생 시설의 사고를 예방하기 위해 관리자의 지시 및 감독을 받으며 안전·환경·보건·위생 시설을 점검하고 위험물 및 유해물질을 점검한다.","doWork":"안전점검을 주기적으로 실시하고 안전시설을 운영한다. 환경시설 및 소방·위험물 시설의 점검을 하고 환경시설과 소방 방재 시설을 운영한다. 보건·위생 시설을 운영하며 관리자의 지시와 작업 일정에 따라 보건·위생 점검을 실시한다. 작업장에서의 위험 상황 발생을 예방하기 위해 관리자의 감독을 받으며 위험물 및 유해물질을 관리하고 작업위험 요소를 발굴한다. 환경오염물질의 종류와 특성을 파악하고 측정 장치를 안전하게 운용한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"정밀화학안전환경보건위생사무원, 정밀화학안전환경보건위생검사원","dJobECd":"1584","dJobECdNm":"[1584]산업 안전원 및 위험 관리원","dJobJCd":"2364","dJobJCdNm":"[2364]산업 안전 및 위험 관리원","dJobICd":"C203/C204","dJobICdNm":"[C203]비료, 농약 및 살균, 살충제 제조업 / [C204]기타 화학제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002052:1', '{"dJobCd":"K000002052","dJobCdSeq":"1","dJobNm":"항공안전관리원","workSum":"항공분야 종사자들의 인적요소(Human Factor)에 의한 사고를 예방하기 위한 안전 관련 업무를 담당한다.","doWork":"항공분야 교통안전 실무자를 대상으로 안전실무 지도서를 제작·보급한다. 각국 항공교통안전과 관련된 시청각 자료를 수집하고 분석하여 안전홍보 자료를 제작·보급한다. 항공분야 종사자 및 관련 단체를 대상으로 항공안전 관련 세미나를 개최한다. 정부기관, 군부대, 관련 협회 등 항공분야 유관기관과 항공안전 업무에 대해 정보 및 자료를 수집하고 교환한다. 항공 관련 각종 준사고(경미한 사고)에 관한 내용을 접수·분석하여 사고예방 자료 및 지침으로 활용하고 필요한 기관에 제공한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"항공안전관리자","certLic":"교통안전관리자(항공) 운송용조종사, 사업용조종사, 항공교통관제사, 항공운항관리사. 항공정비사","dJobECd":"1584","dJobECdNm":"[1584]산업 안전원 및 위험 관리원","dJobJCd":"2364","dJobJCdNm":"[2364]산업 안전 및 위험 관리원","dJobICd":"H511/H512","dJobICdNm":"[H511]항공 여객 운송업 / [H512]항공 화물 운송업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001328:1', '{"dJobCd":"K000001328","dJobCdSeq":"1","dJobNm":"해양안전품질감독","workSum":"선주를 대리하여 선박의 정기적 검사 및 선박안전 관련 인증의 취득과 유지 등 선박의 안전과 품질에 관한 업무를 담당한다.","doWork":"선박의 정기적 검사를 대행한다. 선박안전 관련 인증(ISM, ISPS, MMC)의 취득과 유지를 담당한다. 선박안전과 품질관리와 관련된 시스템을 설계하고 운영한다. 해양안전과 품질에 대해 관계자에게 교육한다. 안전 저해요소 발굴 및 예방지침 제공, 그리고 준사고 관리 등 선박사고 관리 및 예방활동을 한다. 항만국 통제 검사관리 및 예방활동을 한다. 대관청 및 선급 검사업무를 지원한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"선박관리전문가, 해사감독","connectJob":"화물감독","certLic":"해기사(1등 항해사), 선박안전관리사","dJobECd":"1584","dJobECdNm":"[1584]산업 안전원 및 위험 관리원","dJobJCd":"2364","dJobJCdNm":"[2364]산업 안전 및 위험 관리원","dJobICd":"H501","dJobICdNm":"[H501]해상 운송업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006563:1', '{"dJobCd":"K000006563","dJobCdSeq":"1","dJobNm":"해양플랜트안전관리자","workSum":"해양플랜트에서 발생하는 안전사고를 예방하고 인명, 재산, 환경피해를 막기 위하여 해양플랜트의 안전을 관리 및 감독한다.","doWork":"해양플랜트에서 발생할 수 있는 각종 사고를 검토하고 사고예방을 위해 안전세부계획을 수립한다. 작업공정을 확인하여 안전에 문제가 없는지 확인한다. 오염물질이 누출되지 않도록 관리한다. 작업원들이 안전의무사항을 지키는지 감독한다. 문제가 생기면 빠르게 조치하고 보고서를 작성한다. 해양플랜트 관련 각종 사고를 정리하고 분석해서 안전관리교육 프로그램을 실시한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"언어력|","workEnv":"위험내재|소음·진동|","workFunc1":"분석","workFunc2":"감독","workFunc3":"관련없음","similarNm":"Safety Officer, HSE Manager","certLic":"NEBOSH, 선박안전관리사","dJobECd":"1584","dJobECdNm":"[1584]산업 안전원 및 위험 관리원","dJobJCd":"2364","dJobJCdNm":"[2364]산업 안전 및 위험 관리원","dJobICd":"C311/F412","dJobICdNm":"[C311]선박 및 보트 건조업 / [F412]토목 건설업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006508:1', '{"dJobCd":"K000006508","dJobCdSeq":"1","dJobNm":"화학물질안전관리사","workSum":"화학물질 등록 및 위해성평가 대행, 유독물 취급시설의 관리계획서 작성 및 관리, 화학사고의 예방 및 대응한다.","doWork":"관련법규에 따라 취급하는 화학물질의 종류와 수량을 파악하고 적정량, 지정수량을 산정한다. 화학물질의 종류에 따라 GHS-MSDS 경고표시가 제대로 부착되어 있는지 확인하고 화학물질 취급방법에 대한 작업관리지침을 점검하여 화학물질 취급안전을 위한 기술 및 절차를 준수하고 있는지 검토한다. 화학물질 대기방지 설비, 수질오염방지 시설 등의 설비를 점검한다. 화학물질 등록 및 위해성 평가를 실시한다. 유독물 위급시설의 관리계획서를 작성 및 관리하고 화학사고 예방 및 대응에 대한 업무를 수행한다. 화학물질 관리와 관련한 기관 및 국제기구 등과의 협력하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","certLic":"환경위해관리기사, 위험물기능사, 위험물기능장, 위험물산업기사, 산업안전기사, 화학분석기사, 화공안전기술사 등","dJobECd":"1584","dJobECdNm":"[1584]산업 안전원 및 위험 관리원","dJobJCd":"2364","dJobJCdNm":"[2364]산업 안전 및 위험 관리원","dJobICd":"C/M","dJobICdNm":"[C]제조업 / [M]전문, 과학 및 기술 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004066:1', '{"dJobCd":"K000004066","dJobCdSeq":"1","dJobNm":"산업보건관리원","workSum":"산업체에 종사하는 근로자들의 건강하고 안전한 작업을 지원하기 위해 보건관리, 작업환경 측정 및 개선, 보건교육 및 지도 등을 수행한다.","doWork":"정기 건강진단, 채용 건강진단 등에 따른 필요한 행정적 조치를 취하고 이에 따른 개인별 카드를 기록·유지하며 결과를 보고한다. 작업환경, 작업특성에 적합한 위생보호구를 개발·지급하고 착용실태 등을 파악하여 보고한다. 현장 직원들의 질병 예방을 위해 현장을 순회하여 보건교육 실시에 필요한 행정적 조치를 취하고 그 결과를 보고한다. 작업환경 측정장비를 이용하여 작업장 내의 현장 설비, 직무수행 등에 따른 분진, 소음, 유기용제, 중금속 등의 유해물질이 작업원에게 노출되는 정도를 측정하고 측정 결과표와 위생관리에 따른 점검표를 작성하여 보고한다. 환자발생 원인 통계 등 각종 자료를 기록·유지하고 보고한다. 산업보건관리에 필요한 각종 검사측정 기구 및 약품을 보존·관리한다. 의료장비, 의약품, 의료비품 등을 구매·관리하고 구급약품 및 영양제를 지급·관리하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"산업위생관리기술사, 산업위생관리기사, 산업위생관리산업기사","dJobECd":"1555","dJobECdNm":"[1555]보건위생·환경 검사원","dJobJCd":"2365","dJobJCdNm":"[2365]보건 위생 및 환경 검사원","dJobICd":"O842","dJobICdNm":"[O842]사회 및 산업정책 행정","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003430:1', '{"dJobCd":"K000003430","dJobCdSeq":"1","dJobNm":"상수원수질관리원","workSum":"수질감시선을 운영·관리하고 상수원의 수질을 감시하기 위한 제반 업무를 수행한다.","doWork":"선박을 이용하여 상수원의 수질을 감시하고 오염물질을 제거한다. 수질시험을 위한 수질시료 채수 및 현장조사를 통하여 물의 색깔, 유량, 인근지역의 공사현황, 오염물 투기 등에 대해 감시한다. 상수원 지역의 보호를 위하여 불법 침입자 및 불법 행위자에 대한 계도활동을 한다. 수질감시선의 운영과 관리업무를 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실외","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"단순작업","certLic":"수질관리기술사, 수질환경기사, 수질환경산업기사, 동력수상레저기구조정면허(선박조정면허)","dJobECd":"1555","dJobECdNm":"[1555]보건위생·환경 검사원","dJobJCd":"2365","dJobJCdNm":"[2365]보건 위생 및 환경 검사원","dJobICd":"E360","dJobICdNm":"[E360]수도업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007115:1', '{"dJobCd":"K000007115","dJobCdSeq":"1","dJobNm":"석유화학환경관리사무원","workSum":"석유화학제품 사업장의 환경 오염물질 배출 및 주변 영향의 최소화를 위하여 대기, 수질, 화학물질, 폐기물, 소음·진동 측정 장비 등을 활용하여 대기, 수질, 폐기물, 소음·진동 등을 점검한다.","doWork":"대기 점검 항목과 대기 측정 장비 사용법을 확인하고 대기 점검을 실시하여 대기 점검 결과보고서를 작성한다. 수질 점검 항목과 수질 측정 장비 사용법을 확인하고 수질 점검을 실시하여 수질 점검 결과보고서를 작성한다. 화학물질 점검 항목과 화학물질 장비 사용법을 확인하고 화학물질 점검을 실시하여 화학물질 점검 결과보고서를 작성한다. 폐기물 점검 항목과 폐기물 장비 사용법을 확인하고 폐기물 점검을 실시하여 폐기물 점검 결과보고서를 작성한다. 소음·진동 점검 항목과 소음·진동 측정 장비 사용법을 확인하고 소음·진동 점검을 실시하여 소음·진동 점검 결과보고서를 작성한다","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"1555","dJobECdNm":"[1555]보건위생·환경 검사원","dJobJCd":"2365","dJobJCdNm":"[2365]보건 위생 및 환경 검사원","dJobICd":"C201/M","dJobICdNm":"[C201]기초 화학물질 제조업 / [M]전문, 과학 및 기술 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007208:1', '{"dJobCd":"K000007208","dJobCdSeq":"1","dJobNm":"석유화학환경관리자","workSum":"석유화학제품 사업장의 환경오염 및 환경사고 예방을 위하여 관련 법규에 따라 환경영향평가, 배출물질 저감, 화학물질 등록, 환경사고 대응 등의 업무를 수행한다.","doWork":"석유화학제품 사업장의 환경영향평가 대상 및 평가항목을 선정하여 환경영향평가를 실시하고 공정을 개선한다. 화학물질 배출 감축 계획수립과 에너지, 온실가스, 화학물질의 저감 활동을 실행하고 관리한다. 환경 민원·사고 예방대책을 수립하고 환경 민원·사고 조치 계획을 수립한다. 환경교육 계획을 수립하고 환경교육 자료를 작성하여 환경 교육을 실시하고 평가 및 환경 교육 이력을 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"1555","dJobECdNm":"[1555]보건위생·환경 검사원","dJobJCd":"2365","dJobJCdNm":"[2365]보건 위생 및 환경 검사원","dJobICd":"C201/M","dJobICdNm":"[C201]기초 화학물질 제조업 / [M]전문, 과학 및 기술 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003356:1', '{"dJobCd":"K000003356","dJobCdSeq":"1","dJobNm":"식품위생감시원","workSum":"식품 접객업소의 위생상태 및 유통식품의 식품표지 위반 여부를 감시한다.","doWork":"민원과 필요에 따라 식품위생감시원증을 착용하고 식품 접객업소를 방문한다. 매장, 주방, 기타 창고 시설 등의 위생환경을 살피고 원·부자재의 보관상태와 종사자들의 건강관리 등을 점검한다. 검사 후 출입검사기록부(업소관계인의 기명날인 또는 현장사진 첨부된)를 작성하고, 위반사항에 대해서는 관련 법규에 의거 영업정지 등의 행정조치를 취하도록 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","certLic":"위생사, 영양사, 식품산업기사","dJobECd":"1555","dJobECdNm":"[1555]보건위생·환경 검사원","dJobJCd":"2365","dJobJCdNm":"[2365]보건 위생 및 환경 검사원","dJobICd":"O842","dJobICdNm":"[O842]사회 및 산업정책 행정","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004699:1', '{"dJobCd":"K000004699","dJobCdSeq":"1","dJobNm":"지하철환경관리원","workSum":"안전한 지하철 역사 및 주변 환경을 유지하기 위해 공기오염도 및 소음 등을 측정하고 관리한다.","doWork":"지하철의 승강장, 객차를 포함하여 지하 및 지상 역사와 주변 터널 등 지하철 주변의 소음, 진동, 수질 및 공기의 오염도 등을 측정한다. 기준치와 비교하여 오염수준이 높을 경우 원인을 분석하고, 환기장치, 공기정화설비 등의 설치 여부를 검토하여 개선방안을 강구한다. 측정장비 및 전광판 등 환경장비를 관리하고 지하철 폐수 등 수질을 관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"환경측정분석사, 환경위해관리기사, 산업위생산업기사","dJobECd":"1555","dJobECdNm":"[1555]보건위생·환경 검사원","dJobJCd":"2365","dJobJCdNm":"[2365]보건 위생 및 환경 검사원","dJobICd":"H492","dJobICdNm":"[H492]육상 여객 운송업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003416:1', '{"dJobCd":"K000003416","dJobCdSeq":"1","dJobNm":"폐기물환경관리원","workSum":"공장 또는 유원지, 동물원 등에서 발생되는 산업폐기물을 정화하고 중성화하여 처리하는 관련 작업을 기획하고 작업원의 활동을 감독·조정한다.","doWork":"처리하기 위한 폐기물의 양과 종류에 따라 화학약품, 부원료, 활성오니처리, 여과, 소각 등 처리방법을 결정한다. 담수의 수질향상을 위해 수질을 조정하고 분석결과를 기록·유지한다. 신입 작업원을 훈련시키고 작업을 할당한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"감독","workFunc3":"수동조작","similarNm":"폐기물처리자","certLic":"환경기능사, 폐기물처리기술사, 폐기물처리기사, 폐기물처리산업기사","dJobECd":"1555","dJobECdNm":"[1555]보건위생·환경 검사원","dJobJCd":"2365","dJobJCdNm":"[2365]보건 위생 및 환경 검사원","dJobICd":"E370","dJobICdNm":"[E370]하수, 폐수 및 분뇨 처리업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006205:1', '{"dJobCd":"K000006205","dJobCdSeq":"1","dJobNm":"방사선투과검사기술자","workSum":"방사선 동위원소와 X선 장비를 이용하여 제품 또는 재료의 내부상태를 촬영하여 검사·판정한다.","doWork":"금속, 플라스틱, 콘크리트 또는 기타 재료를 사용한 주물, 견본품, 파이프 및 각 부품과 용접부위 등의 균열, 파손, 이물질 등을 검사하기 위하여 방사선동위원소 또는 휴대용 X선 장비를 사용하여 촬영한다. 시편의 불규칙한 부분이나 용접부위 등을 검사하여 표면처리하고 필름홀더(Holder)에 필름을 끼워 시편에 밀착시킨다. 시편의 밀도와 두께에 따라 표준공식을 적용하여 방사선원의 지름, 유동, 강도, 노출시간 및 거리를 결정하고 방사선원 및 필름의 종류를 선택한다. X선 장비를 조작하거나 방사선원을 노출시켜 촬영한다. 방사선원과 시편과의 거리를 적당히 조절하고 투과도계를 사용하여 필름의 감도를 확인하면서 규정된 노출시간 동안 필름을 감광시킨다. 자동현상기에 필름을 넣어 현상 처리한다. 인화된 필름을 해독하여 결함의 종류를 파악하고 판정규격에 적용시켜 등급을 결정한다. 판정내용을 기록하고 필름과 함께 보존한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"방사선비파괴검사기사, 방사선비파괴검사산업기사","dJobECd":"1585","dJobECdNm":"[1585]비파괴 검사원","dJobJCd":"2366","dJobJCdNm":"[2366]비파괴 검사원","dJobICd":"M729","dJobICdNm":"[M729]기타 과학기술 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007545:1', '{"dJobCd":"K000007545","dJobCdSeq":"1","dJobNm":"비파괴검사원","workSum":"제조물을 손상·파괴하지 않고 제조물의 내·외부에 존재하는 불연속 혹은 결함을 탐지하거나 물리적, 기계적 특성을 파악하기 위하여 검사장비를 사용하여 측정·검사·평가한다.","doWork":"검사제품의 특성을 고려하여 검사방법을 결정하고 검사일정 등 검사계획을 수립한다. 수립된 계획에 따라 관련 장비를 준비하고 설치한다. 검사절차에 따라 요구되는 방사선투과검사, 초음파탐상검사, 자기탐상검사, 침투탐상검사, 와전류탐상검사, 누설검사를 실시한다. 각각의 검사장비에 나타난 초음파의 음향임피던스, 와전류의 변화, 자분의 집속, 결함 등을 읽고 분석한다. 소재의 특성 및 구조물의 안전성 및 신뢰성 등을 평가한다. 합격 또는 불합격 여부를 포함하여 검사결과보고서를 작성하여 보고한다. 결과물을 의뢰인에게 제출한다. 검사장비를 안전하게 관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"비파괴시험원","connectJob":"방사선비파괴검사원, 초음파비파괴검사원, 자기비파괴검사원, 침투비파괴검사원, 와전류비파괴검사원, 누설비파괴검사원","certLic":"초음파비파괴검사기사(산업기사, 기능사), 침투비파괴검사기사(산업기사, 기능사), 누설비파괴검사기사, 자기비파괴검사기사(산업기사,기능사), 방사선비파괴검사기사(산업기사, 기능사), 와전류비파괴검사기사","dJobECd":"1585","dJobECdNm":"[1585]비파괴 검사원","dJobJCd":"2366","dJobJCdNm":"[2366]비파괴 검사원","dJobICd":"M729","dJobICdNm":"[M729]기타 과학기술 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007392:1', '{"dJobCd":"K000007392","dJobCdSeq":"1","dJobNm":"광해복원기술자","workSum":"광해복원사업을 사전준비하고 광해방지시설을 사후관리하며 광해방지사업을 감리한다.","doWork":"복원사업 시공 가능 여부를 검토하기 위해 설계도서를 검토하고, 인허가 준비, 현장 실증시험 업무를 한다. 광산 활동에 의해 발생하는 광산(산성)배수를 처리하기 위해 산화처리, 침전처리, 알칼리 처리, 식물정화 처리를 이용한 시설 등을 설치한다. 광산 활동에 의해 오염된 토양을 처리하기 위해 안정화제 포설, 토양 복토, 환토반출, 중금속추출 처리, 석면오염토 처리를 한다. 오염원의 확산방지와 무해화를 위해 유실방지 시설물을 설치하고, 고형화·안정화 처리를 하고, 무해화·자원순환 처리 공정을 운용한다. 광물찌꺼기에 의한 토양오염, 침출수 유출, 지하수 오염을 파악하고 복원 공사의 필요 여부를 결정한다. 광산채굴로 인하여 발생된 공동상부의 안정성을 확보하고 검증한다. 환경피해를 최소화하기 위해 광폐석을 정리하고 사면을 보강하며 훼손산림을 녹화한다. 가행 광산에서 발생되는 먼지, 소음, 진동을 방지하고 대응하기 위해 먼지, 소음, 진동 현황을 측정·분석하고 평가한다. 광해 방지 사업에 의해 설치된 시설의 기능을 지속적으로 유지 및 향상시키기 위하여 시설물을 평가·계측·유지 보수한다. 광해방지 복원공사 수행 시 품질관리를 위해 공정계획 검토, 품질관리, 시공관리, 시공검수를 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"광산보안기사·산업기사, 광해방지기술사·기사, 구조기술사, 대기관리기술사, 대기환경기사·산업기사, 산림기술사·기사·산업기사, 소음진동기술사·기사·산업기사, 수질관리기술사, 수질환경기사·산업기사, 응용지질기사, 자원관리기술사, 지질및지반기술사, 토목기사·산업기사, 토양환경기술사·기사, 폐기물처리기술사·기사·산업기사, 산업안전기술사·기사·산업기사, 측량및지형공간정보기사, 화약류관리기사","dJobECd":"1553","dJobECdNm":"[1553]환경공학 기술자 및 연구원","dJobJCd":"2371","dJobJCdNm":"[2371]환경공학 기술자 및 연구원","dJobICd":"B051/B061/B062","dJobICdNm":"[B051]석탄 광업 / [B061]철 광업 / [B062]비철금속 광업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003154:1', '{"dJobCd":"K000003154","dJobCdSeq":"1","dJobNm":"광해복원연구원","workSum":"지반침하, 광산오염토양, 광물찌꺼기, 광산배수, 광산사면, 광산 먼지날림·소음·진동 등 광해 현황을 조사하고 이를 바탕으로 광산환경 기본설계 및 실시설계를 수행한다.","doWork":"광산 개발에 따라 발생하는 광해의 현황을 조사하기 위해 광해 특성을 분석하고 광해 관련 법규에 따라 광해조사 계획을 수립한다. 현재 광산의 개발 상황과 실태를 파악하기 위해 문헌조사, 탐문조사 및 실태조사를 하고 광해발생 원인을 조사한다. 광산개발에 의해 오염된 토양의 오염도와 오염 범위를 파악하여 복원 공사 필요 여부를 결정하기 위해 자료조사, 방문조사, 시료채취, 오염분석을 하고 오염토양 평가를 수행한다. 광물찌꺼기에 의한 토양오염, 침출수 유출, 지하수 오염을 파악하여 복원 공사의 필요 여부를 결정하기 위해 오염원 조사, 광물찌꺼기 채취, 현장시험, 시료분석을 하고 광물찌꺼기를 평가한다. 광업활동에 따른 광산배수, 적치사면, 채굴사면 등의 오염도를 파악하여 복원 공사의 필요 여부를 결정하고 안정성을 평가한다. 가행 광산에서 발생하는 먼지, 소음, 진동을 방지하고 대응하기 위해 먼지, 소음, 진동현황을 측정·분석하고 평가한다. 조사 결과를 기초하여 광해복원사업을 실시하기 위해 개략적인 복원범위, 복원공법을 선정하고, 선정된 공법의 현장 적용을 위한 기본설계도서를 작성한다. 광해복원에 대한 기본설계를 바탕으로 광해복원 공사를 실시하기 위해 기본설계의 문제점을 보완하고 수정하여 최종 설계보고서, 공사도면, 시방서, 설계내역서의 최종 성과품을 작성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"광산보안기사·산업기사, 광해방지기술사·기사, 대기환경기사·산업기사, 산림기술사·기사·산업기사, 산업안전기술사·기사, 소음진동기술사·기사·산업기사, 수질환경기사·산업기사, 응용지질기사, 측량및지형공간정보기사, 토목기사·산업기사, 토양환경기술사·기사, 폐기물처리기술사·기사, 화약류관리기사, 구조기술사, 대기관리기술사, 수질관리기술사, 자원관리기술사, 지질및지반기술사, 토질및기초기술사","dJobECd":"1553","dJobECdNm":"[1553]환경공학 기술자 및 연구원","dJobJCd":"2371","dJobJCdNm":"[2371]환경공학 기술자 및 연구원","dJobICd":"B051/B061/B062","dJobICdNm":"[B051]석탄 광업 / [B061]철 광업 / [B062]비철금속 광업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005969:1', '{"dJobCd":"K000005969","dJobCdSeq":"1","dJobNm":"대기오염관제원","workSum":"사업장 굴뚝에서 배출되는 오염물질을 측정해 관제센터에 전송하고 원격으로 제어하여 대기총량을 관리한다.","doWork":"측정기로 사업장 굴뚝에서 배출되는 오염물질(먼지, CO, NOx, SO₂, HCI, HF, NH), 보정자료(온도, 유량, 산소 등)를 수집한다. 측정값을 평균자료로 생성하여 저장한다. 유·무선 통신 등을 통해 측정된 자료를 실시간으로 관제센터와 각 사업장의 자체관리시스템으로 전송해 사업장의 배출 및 방지시설 개선 등에 활용한다. 배출허용기준을 초과할 우려가 있거나 초과 시 각 사업장과 지방자치단체에 유무선(전화, 이동전화, 팩스, 문자메시지 등)통신으로 자동으로 송신한다. 수동덤프 기능으로 자료수집기의 미송신자료를 전송받는다. 측정자료의 신뢰성을 확보하기 위하여 원격제어로 측정기기에 표준가스를 주입하여 측정기의 정상작동 여부를 확인한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"환경측정분석사, 대기관리기술사, 대기환경기사, 대기환경산업기사","dJobECd":"1553","dJobECdNm":"[1553]환경공학 기술자 및 연구원","dJobJCd":"2371","dJobJCdNm":"[2371]환경공학 기술자 및 연구원","dJobICd":"O842","dJobICdNm":"[O842]사회 및 산업정책 행정","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005338:1', '{"dJobCd":"K000005338","dJobCdSeq":"1","dJobNm":"대기오염총량관리원","workSum":"사업장 대기오염물질 총량관리제 및 배출권 전자거래시스템 관련 정책의 지원, 대기총량관리시스템 설치 및 운영, 도로 비산먼지 이동측정시스템을 구축·운영한다.","doWork":"사업장 대기오염물질 총량관리 업무를 대행하고, 대기총량관리 및 굴뚝원격감시체계 사업장에 대한 기술지원을 한다. 대기총량관리 및 굴뚝자동측정관제센터 운영 관련 정책지원을 한다. 대기총량관리시스템, 굴뚝원격감시체계 관제센터를 설치·운영한다. 배출허용총량관리를 위한 전산장비를 도입·설치 및 유지 관리하고, 측정자료 수집 및 배출량 산정 프로그램 개발 및 유지 관리한다. 배출허용기준을 초과한 사업장에 부과금 산정자료를 제공한다. 도로 재비산먼지 이동측정시스템을 구축·운영한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"대기총량관리원","certLic":"환경측정분석사, 대기관리기술사, 대기환경기사, 대기환경산업기사","dJobECd":"1553","dJobECdNm":"[1553]환경공학 기술자 및 연구원","dJobJCd":"2371","dJobJCdNm":"[2371]환경공학 기술자 및 연구원","dJobICd":"O842","dJobICdNm":"[O842]사회 및 산업정책 행정","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005482:1', '{"dJobCd":"K000005482","dJobCdSeq":"1","dJobNm":"발전환경연구원","workSum":"발전소 운영에 따른 대기, 수질, 토양, 해양 등 환경오염에 대한 측정, 평가, 방지 및 예방에 대한 기술개발 및 현장지원을 위한 제반 업무를 수행한다.","doWork":"발전설비의 건설 및 운영이 대기, 수질, 토양, 해양 등에 미치는 영향을 규명하기 위해 발전소 주변의 환경영향평가를 실시하여 오염정도를 분석하고, 영향 최소화 방안에 대해 연구한다. 지구환경보호를 위한 기후협약 등 각종 국제환경협약에 대처하기 위한 대기환경 보존기술을 개발한다. 발전소 환경관리를 위한 기술지원 업무를 수행한다. 발전소 건설 및 운영에 따른 주변 환경에 미치는 영향을 규명하고 발생한 현안 문제점을 해결할 수 있도록 환경관리기술을 지원한다. 발전소 배출 대기오염물질에 대한 저감기술, 회수기술, 저장방법 및 흡수제 개발, 무공해 정제기술 개발 등을 연구한다. 기타 환경관련 제반 연구업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"대기관리기술사, 대기환경기사·산업기사, 수질관리기술사, 수질환경기사·산업기사, 소음진동기술사·기사·산업기사, 폐기물처리기술사·기사·산업기사, 토양환경기술사·기사, 환경측정분석사","dJobECd":"1553","dJobECdNm":"[1553]환경공학 기술자 및 연구원","dJobJCd":"2371","dJobJCdNm":"[2371]환경공학 기술자 및 연구원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002864:1', '{"dJobCd":"K000002864","dJobCdSeq":"1","dJobNm":"생산시설환경기술자","workSum":"환경상의 위해 예방과 법적 요구사항을 만족시키기 위하여 생산시설 내 대기오염방지시설, 물처리시설, 폐기물 처리 시설을 안전하게 관리 운영한다.","doWork":"시설 운영에 필요한 환경법규를 준수하여 대관 업무수행과 시설운영 계획을 수립하고 운영한다. 배출시설에서 발생하는 가스상·입자상 오염물질을 처리하기 위하여 대기오염방지시설을 운영한다. 폐수 및 오수처리 단계별 수질모니터링을 통한 공정별 최적운전조건을 파악함으로써 시설을 보다 안정적으로 운전하고 유지보수한다. 환경안전계획을 수립하여 화학물질관리, 시설물 정기점검을 통해 환경상의 위해를 관리하고 예방한다. 사업장에서 발생하는 오염물질 등을 최소화하기 위하여 배출시설 등을 통합 관리하고, 최적의 환경관리기법을 각 사업장의 여건에 맞게 적용할 수 있는 체계를 구축한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"대기관리기술사, 수질관리기술사, 소음진동기술사, 토양환경기술사, 폐기물처리기술사, 대기환경기사, 수질환경기사, 소음진동기사, 토양환경기사, 폐기물처리기사, 온실가스기사, 환경위해관리기사, 대기환경산업기사, 수질환경산업기사, 소음진동산업기사, 폐기물처리산업기사, 온실가스산업기사, 환경기능사","dJobECd":"1553","dJobECdNm":"[1553]환경공학 기술자 및 연구원","dJobJCd":"2371","dJobJCdNm":"[2371]환경공학 기술자 및 연구원","dJobICd":"C","dJobICdNm":"[C]제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004324:1', '{"dJobCd":"K000004324","dJobCdSeq":"1","dJobNm":"선박환경검사원","workSum":"선박에서 발생하는 환경오염 물질 배출량을 측정하여 선박이 국제 혹은 국내 환경기준에 부합하는지 평가한다.","doWork":"국내외 선박 환경기준(대기오염물질 배출량, 에너지 효율, 오폐수 배출량 등)에 대해 파악한다. 파악된 환경기준에 따라 대기오염물질 측정기, 오폐수 측정기 등의 환경오염 측정기를 활용하여 국내 선박의 환경 적합성 여부를 검사하고 평가한다. 외국에서 우리나라에 입항하는 선박도 환경검사를 실시하여 평가한다. 평가 후 선박 환경기준에 충족시키지 못할 경우 국내선박에 대해선 시정 조치를 취하도록 행정적 명령을 내리며, 외국 선박에 대해서는 입항을 제한하는 조치를 취한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"환경측정분석사, 대기관리기술사, 대기환경기사·산업기사, 수질관리기술사, 수질환경기사·산업기사","dJobECd":"1553","dJobECdNm":"[1553]환경공학 기술자 및 연구원","dJobJCd":"2371","dJobJCdNm":"[2371]환경공학 기술자 및 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003826:1', '{"dJobCd":"K000003826","dJobCdSeq":"1","dJobNm":"소음진동기술자","workSum":"각종 산업현장 및 공사현장의 소음 및 진동 발생원의 현황을 측정 분석한다. 분석된 자료를 바탕으로 영향성을 예측하여 정숙한 소음 및 진동 환경을 관리, 보전하고 대책안을 수립한다.","doWork":"소음과 진동발생 설비가 있는 모든 사업장, 공사장, 기계실 및 도로 및 철도 등이 있으며 소음과 진동에 관련한 민원 발생 현장에 투입하여 소음계, 진동계, 주파수 분석계 등을 이용하여 측정 및 분석하고 설계단계에서 소음과 진동에 대한 영향성을 예측하여 대책을 수립한다. 분석 방법에 따라 설비의 이상유무, 건축물의 안전성, 민원 피해 평가, 대책방안 설계 등 다양한 목적으로 활용할 수 있다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"청각|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"환경측정분석사, 소음진동기술사, 소음진동기사, 소음진동산업기사","dJobECd":"1553","dJobECdNm":"[1553]환경공학 기술자 및 연구원","dJobJCd":"2371","dJobJCdNm":"[2371]환경공학 기술자 및 연구원","dJobICd":"M729","dJobICdNm":"[M729]기타 과학기술 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003299:1', '{"dJobCd":"K000003299","dJobCdSeq":"1","dJobNm":"수자원환경연구원","workSum":"수자원환경 및 생태계 모니터링, 유역 오염원 관리와 오염물질의 저감 방안, 환경영향평가, 수질개선관리, 수질모델링, 수자원환경 정보구축을 위한 연구·개발을 한다.","doWork":"수질데이터를 분석하여 수질진단 및 수질관리 방안을 연구하고, 수질 모니터링 등을 위한 정보구축기술을 개발한다. 수량 및 수질을 고려한 효율적 이수관리를 위하여 저수지의 최적 운영을 연구하고, 저수지 내의 퇴사예측 및 대책방안을 수립한다. 하천유역의 물순환을 분석하고, 자연형 하천복원을 위한 하천의 특성을 연구한다. 생태환경관리를 위한 기초자료를 축적하고 연구한다. 수질·생태환경 정책 개발 및 대안을 제시한다. 기타 연구원(일반)들이 수행하는 일반적인 활동을 한다. 유역오염원 및 오염물질에 대한 조사분석으로 유입방지대책을 연구한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"수질환경감시원","connectJob":"물감시원","certLic":"토목기사, 측량및지형공간정보기사, 수질환경기사, 자연생태 및 환경기사, 사무자동화산업기사, 상하수도기술사","dJobECd":"1553","dJobECdNm":"[1553]환경공학 기술자 및 연구원","dJobJCd":"2371","dJobJCdNm":"[2371]환경공학 기술자 및 연구원","dJobICd":"E360","dJobICdNm":"[E360]수도업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002766:1', '{"dJobCd":"K000002766","dJobCdSeq":"1","dJobNm":"온실가스관리컨설턴트","workSum":"조직의 기후변화 대응 및 온실가스 감축을 위하여 관련 법규 및 지침에 따라 온실가스 배출량 산정과 보고, 온실가스 감축활동을 기획·수행·관리한다.","doWork":"정부, 정부기관, 기업 등과 상담하여 온실가스관리 컨설팅 사업을 수주한다. 온실가스 배출량, 배출원, 배출활동, 관리조직, 재무현황 등을 조사하여 온실가스 관리 현황을 파악한다. 감축잠재량 평가, 배출량 예측, 감축사업의 우선순위 도출, 감축목표량 달성 방안 수립, 온실가스관리제도에 대한 대응방안, 투자경제성 분석 등의 업무를 수행하고 보고서를 작성한다. 전체 조직원 및 관리조직을 대상으로 온실가스관리 방안, 국내외 온실가스 관련 제도, 동향 등을 교육한다. 구축된 온실가스관리 시스템을 점검하고 보완한다. 정부 부분에서 활동하는 경우 온실가스 감축정책의 설계, 운영방법 및 이해관계자의 역할, 영향 및 제도의 기대효과 등에 대한 자문업무를 수행한다. 정부 산하기관에서 활동하는 경우 중앙정부의 정책에 대한 구체적 실천 방법, 운영 방안, 매뉴얼, 절차서 등 제도 실행을 위한 구체적인 업무 정의 및 수행기법 개발업무를 수행한다. 기업체를 대상으로 활동하는 경우 정부 제도의 대응방안을 구체적으로 수립(온실가스 배출량 산정, 관리 체계 구축, 감축 방안 및 시나리오 구성, 의사결정 수단 및 절차 등 제시)한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"자문","workFunc3":"정밀작업","similarNm":"온실가스목표관리제컨설턴트, 온실가스배출거래제컨설턴트, 에너지진단컨설턴트","connectJob":"온실가스인증검증심사원","certLic":"온실가스관리기사","dJobECd":"1553","dJobECdNm":"[1553]환경공학 기술자 및 연구원","dJobJCd":"2371","dJobJCdNm":"[2371]환경공학 기술자 및 연구원","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003373:1', '{"dJobCd":"K000003373","dJobCdSeq":"1","dJobNm":"재활용기술자","workSum":"생활폐기물이나 산업폐기물을 대상으로 유용한 자원을 추출하거나 재사용하는 데 필요한 기술을 연구·개발한다.","doWork":"생활폐기물이나 산업폐기물의 발생, 분류, 수거에 대한 흐름을 이해하고 금속자원(금속캔, 폐전지, 철스크랩, 비철금속, 폐촉매 등), 세라믹(유리병, 석탄회, 주물사, 건설부산물, 광재 및 분진, 소각재, 폐형광등 등), 고분자자원(폐플라스틱 포장용기, 열가소성 플라스틱, 열경화성 플라스틱, 폐고무, 폐유, 폐유기용제, 폐합성섬유 등), 유기성자원(오니류, 음식물류, 폐종이, 폐목재, 폐산·알칼리 등), 제품(폐가전제품, 폐자동자, 폐전자제품, 전자산업 스크랩) 등의 폐기물 특성에 따른 화학적 재활용, 원료 재활용 등 자원 재활용 방법을 연구한다. 경제적인 재활용 공정을 위한 자원 추출 및 재활용 관련 기기와 공정을 연구·개발한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"폐기물처리기술사, 폐기물처리기사, 폐기물처리산업기사","dJobECd":"1553","dJobECdNm":"[1553]환경공학 기술자 및 연구원","dJobJCd":"2371","dJobJCdNm":"[2371]환경공학 기술자 및 연구원","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004325:1', '{"dJobCd":"K000004325","dJobCdSeq":"1","dJobNm":"정수수질관리기술자","workSum":"정수장 및 수돗물 공급관로의 수질관리 계획을 수립하고 수질을 조사·분석하여 안전한 수돗물이 공급되도록 관리한다.","doWork":"정수장 및 수돗물 공급관로의 수질상태를 수시로 조사·분석하여 안전하고 신뢰성 있는 수돗물을 공급하기 위한 수질측정 종합체계를 운영한다. 유입원수의 수질 변화 및 특성을 정수장에서 상시 모니터링하여 최적의 수돗물을 생산하기 위한 상수원수 조류 예보제를 운영한다. 유입원수를 정수하기 위하여 투여하는 각종 약품이 적정량으로 투입되는지를 관리하고 수질상태가 규정치와 일치하는지 등 정수 수질관리를 한다. 정수과정에서 발생된 이물질을 처리하기 위한 응집제의 양과 농도를 조정하고 배출수의 수질상태를 검사한다. 수질측정을 위한 각종 수질계측기를 관리하고 운영한다. 수질관리를 위하여 일일, 주간, 월별로 수온, pH, 탁도, 전기전도도, 알칼리도, 잔류염소 등 규정된 검사사항을 조사하여 수질을 분석한다. 수질실험실을 운영하고 실험실에서 사용한 폐액을 규정대로 처리하고 수질시료의 채수 및 현장조사를 한다. 공급관로(배수지포함)의 현장조사와 수질분석 결과표를 작성하고, 공급계통(배수지 포함)의 수질상태를 파악한다. 공급관로 계통인 배수지 등의 오염물질 유입 여부를 감시하고 오염방지 시설물의 가동을 촉구하고 감독한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"시각|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"수자원환경연구원, 수질감시원","connectJob":"상수원수질관리원, 정수장수질관리원, 물감시원","certLic":"수질관리기술사, 수질환경기사, 수질환경산업기사, 산업계측제어기술사, 정수시설운영관리사, 사무자동화산업기사, 상하수도기술사","dJobECd":"1553","dJobECdNm":"[1553]환경공학 기술자 및 연구원","dJobJCd":"2371","dJobJCdNm":"[2371]환경공학 기술자 및 연구원","dJobICd":"E360","dJobICdNm":"[E360]수도업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003172:1', '{"dJobCd":"K000003172","dJobCdSeq":"1","dJobNm":"제품생산환경평가기술자","workSum":"제품의 생산 과정에서 발생하는 환경오염물질과 에너지 효율을 측정·분석하여 개선을 위한 기술적인 조언을 한다.","doWork":"제품의 생산공정을 파악하고 각 생산공정에서 배출되는 환경오염 물질과 에너지 낭비 요소를 측정·분석한다. 공정기술자, 설비기술자 등과 협의하여 분석 결과를 토대로 환경오염 물질 저감 또는 에너지 효율화 기술을 적용하여 제품공정 재설계, 생산설비 개선 등과 같은 환경 및 에너지 개선 계획을 수립한다. 환경 개선에 대한 효과와 경제성을 평가한다. 공정 재설계, 설비설계 과정에서 환경적 요소에 관해 조언한다. 환경개선 목표의 달성 여부를 평가한다. 환경오염 저감 설비의 추가 설치를 조언하기도 한다. 해당 설비들이 적절히 설치되었는지 관리·감독하기도 한다. 개선 후 제품생산 공정에서 배출되는 환경오염 물질을 측정·분석하여 효과성과 경제성을 평가하고 보고한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"자문","workFunc3":"정밀작업","dJobECd":"1553","dJobECdNm":"[1553]환경공학 기술자 및 연구원","dJobJCd":"2371","dJobJCdNm":"[2371]환경공학 기술자 및 연구원","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002991:1', '{"dJobCd":"K000002991","dJobCdSeq":"1","dJobNm":"제품생산환경평가원","workSum":"제품의 생산 과정에서 발생하는 환경오염 물질과 에너지 효율을 측정·분석하여, 개선을 위한 기술적 조언을 제공한다.","doWork":"제품의 생산공정을 파악하고 각 생산공정에서 배출되는 환경오염 물질과 에너지 낭비 요소를 측정·분석한다. 분석 결과를 토대로 환경오염 물질 저감 또는 에너지 효율화기술을 적용하여 제품공정 재설계, 생산설비 개선 등과 같은 환경 및 에너지 개선 계획을 수립하고 공정기술자, 설비기술자 등과 환경 개선에 대한 효과와 경제성을 평가·협의하여 최적의 개선 계획을 수립한다. 생산공정 재설계, 설비설계 과정에서 환경적 요소에 관해 조언하고 환경개선 목표의 달성 여부를 평가한다. 환경오염 저감 설비의 추가 설치를 조언하기도 하고 해당설비들이 적절히 설치되었는지 관리·감독하기도 한다. 개선 후 제품생산 공정에서 배출되는 환경오염 물질을 측정·분석하여 그 효과와 경제성을 평가하고 보고한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"제품생산환경평가기술가","certLic":"환경측정분석사","dJobECd":"1553","dJobECdNm":"[1553]환경공학 기술자 및 연구원","dJobJCd":"2371","dJobJCdNm":"[2371]환경공학 기술자 및 연구원","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005196:1', '{"dJobCd":"K000005196","dJobCdSeq":"1","dJobNm":"지하수관리기술자","workSum":"지하수 활용과 관련하여 지하수 부존 현황을 조사하고, 지하수에 대한 기준 및 표준화를 통하여 지하수의 체계적인 보전과 관리를 위한 제반 기술을 개발한다.","doWork":"농·어촌 용수를 포함한 지하수의 조사에 관한 계획을 수립하고 관리한다. 가뭄피해 대책의 수단으로서 지하수에 대한 연구를 한다. 농촌지역의 지하수 부존현황 및 사용량을 조사하여 체계적인 관리를 통하여 가뭄에 대처한다. 지하수에 대한 기준 및 표준화를 수립하여 체계적인 조사와 관리를 위한 방안을 개발한다. 지하수 개발을 위한 신기술 개발과 보급에 관한 업무를 수행한다. 지하수 사업에 관한 법규 및 제도의 개선을 위한 연구를 한다. 지하수 자원의 합리적인 보전과 관리에 대해 연구한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"응용지질기사, 수질관리기술사, 수질환경기사, 수질환경산업기사","dJobECd":"1553","dJobECdNm":"[1553]환경공학 기술자 및 연구원","dJobJCd":"2371","dJobJCdNm":"[2371]환경공학 기술자 및 연구원","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002967:1', '{"dJobCd":"K000002967","dJobCdSeq":"1","dJobNm":"지하수연구원","workSum":"지하수 사용지역의 지하수를 효율적으로 개발, 이용, 보존 및 관리를 위한 제반 연구를 한다.","doWork":"지하수를 효율적으로 개발, 이용 및 보전하기 위하여 지하수환경에 대한 연구를 한다. 지하수 수질 및 환경오염방지 대책을 연구한다. 지하수 및 토목지질과 관련된 자료를 수집하고 관리한다. 지하수오염에 대한 정화처리 방안을 연구한다. 위성 관측장비를 이용하여 지하수 분포 현황 및 상황을 지도로 제작하고 체계적인 관리를 위한 방안을 연구한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"수리지질연구원","connectJob":"토양환경기술자","certLic":"응용지질기사, 수질관리기술사, 수질환경기사, 수질환경산업기사, 토양환경기사","dJobECd":"1553","dJobECdNm":"[1553]환경공학 기술자 및 연구원","dJobJCd":"2371","dJobJCdNm":"[2371]환경공학 기술자 및 연구원","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002793:1', '{"dJobCd":"K000002793","dJobCdSeq":"1","dJobNm":"토양환경기술자","workSum":"토양오염의 현황파악하고, 토양오염으로 인한 부지의 복원을 위한 설계 , 시공 및 관련기술을 개발하며, 토양 오염 예방을 위한 대책 수립의 업무를 수행한다.","doWork":"토양 및 지하수 시료를 채취하여 ,공정시험법에 따라 시험·분석하고, 중금속 및 유기오염물질 등의 오염농도와 오염범위를 파악한다. 생물학적 처리, 물리화학적 처리 및 열적처리 등의 다양한 토양정화공법을 이용하여 토양오염 복원을 위한 계획안을 마련한다. 정화기술 및 정화시스템을 설계하고 정화작업을 감독한다. 토양오염을 예방할 수 있는 대책을 마련하고 토양환경 관련 연구업무를 수행한다.표토유실현황 조사와, 표토유실 방지를 위한 대책을 마련한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workEnv":"대기환경미흡|소음·진동|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"환경공학기술자","certLic":"토양환경기술사, 토양환경기사","dJobECd":"1553","dJobECdNm":"[1553]환경공학 기술자 및 연구원","dJobJCd":"2371","dJobJCdNm":"[2371]환경공학 기술자 및 연구원","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007554:1', '{"dJobCd":"K000007554","dJobCdSeq":"1","dJobNm":"폐기물처리기술자","workSum":"일반 및 산업 폐기물의 관리, 처리 및 재활용에 관한 계획, 지도, 안전진단 및 감리업무 등을 수행한다.","doWork":"일상생활과 관련된 일반폐기물과 산업 활동의 부산물로 발생된 산업폐기물을 소각·재활용하기 위한 소각로설비, 재활용처리 방법 및 설비, 쓰레기나 폐기물에 대한 중계처리시스템 등 제반 폐기물 관련 문제점을 분석한다. 폐기물처리에 대한 부지선정, 기술검토, 경제성 검토 및 환경영향평가를 분석한다. 시공되는 현장에서 기술지원 및 시공상 발생되는 문제점에 대해 해결방안을 제시하고 조언한다. 시공에 수반되는 안전성 검사와 감리업무를 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"폐기물소각로기술자, 폐기물매립기술자, 폐기물재활용기술자","certLic":"폐기물처리기술사, 폐기물처리기사, 폐기물처리산업기사","dJobECd":"1553","dJobECdNm":"[1553]환경공학 기술자 및 연구원","dJobJCd":"2371","dJobJCdNm":"[2371]환경공학 기술자 및 연구원","dJobICd":"E382","dJobICdNm":"[E382]폐기물 처리업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007287:1', '{"dJobCd":"K000007287","dJobCdSeq":"1","dJobNm":"하수오니처리기술자","workSum":"하수처리 과정에서 발생되어 침전된 슬러지를 제거하고 주변 환경을 관리·감독한다.","doWork":"수처리 과정에서 발생된 슬러지를 농축조, 소화조 및 탈수기로 적정 관리하여 슬러지를 위생적으로 처리한다. 슬러지 처리시설의 효율을 주기적으로 점검하고 탈수약품을 적정 투입하여 슬러지 케익의 함수율을 조절한다. 농축조, 소화조 및 탈수기에서 발생하는 악취를 포집하여 탈취한다. 슬러지처리를 위한 전기, 기계 및 계장 시설물을 효과적으로 유지·관리하여 안전사고 및 감전사고에 대비하고 관련 현장 담당자를 지도·감독한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|다습|소음·진동|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"수질관리기술사, 수질환경기사, 수질환경산업기사, 폐기물처리기술사, 폐기물처리기사, 폐기물처리산업기사, 환경기능사","dJobECd":"1553","dJobECdNm":"[1553]환경공학 기술자 및 연구원","dJobJCd":"2371","dJobJCdNm":"[2371]환경공학 기술자 및 연구원","dJobICd":"E370","dJobICdNm":"[E370]하수, 폐수 및 분뇨 처리업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002930:1', '{"dJobCd":"K000002930","dJobCdSeq":"1","dJobNm":"하수처리기술자","workSum":"생활활동에서 발생되는 하수를 일련의 단위처리공정으로 조합된 하수처리시설로 정화시킨다.","doWork":"하수처리설비의 전기, 기계 및 계장 시설물을 유지·관리하면서 유입되는 하수를 침사지, 유입펌프장, 침전지, 포기조, 최종침전지 등을 거쳐 정화한다. 처리 관련 현장을 지도 및 감독하고 홍수에 대비하여 하수의 역류현상을 방지하고자 수방대책을 계획, 수립 및 실행한다. 유입하수와 방류하수의 생물학적 산소요구량, 총질소, 총인, 포기조의 용존산소량 등의 측정 자료를 검토하여 하수처리시설의 효율을 점검하고, 보완·개량시킨다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"수질관리기술사, 수질환경기사, 수질환경산업기사, 환경기능사","dJobECd":"1553","dJobECdNm":"[1553]환경공학 기술자 및 연구원","dJobJCd":"2371","dJobJCdNm":"[2371]환경공학 기술자 및 연구원","dJobICd":"E370","dJobICdNm":"[E370]하수, 폐수 및 분뇨 처리업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004523:1', '{"dJobCd":"K000004523","dJobCdSeq":"1","dJobNm":"하수처리시설관리자","workSum":"하수의 처리장치 및 부대시설물을 유지·관리하고 시설개선을 위한 계획, 지도, 안전진단 및 감독업무 등을 수행한다.","doWork":"주기적인 순찰실시로 하수의 외부 유출을 방지하고 하수처리시설 내 우수 토실·토사 준설작업을 시행한다. 건축, 토목시설물 및 수도시설의 보수·개량 공사를 시행하고 도로보수 작업을 한다. 하수처리시설 내 체육시설 및 조경시설물을 유지·관리하고 분기별 및 반기별로 하수처리시설 내 정기 점검을 실시하여 재난 및 안전사고를 예방한다. 동절기에는 재설대책을 계획하고 수립한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|다습|소음·진동|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"하수시설관리원","certLic":"토목기사, 토목산업기사, 건축기사, 건축산업기사, 수질관리기술사, 수질환경기사, 수질환경산업기사, 환경기능사","dJobECd":"1553","dJobECdNm":"[1553]환경공학 기술자 및 연구원","dJobJCd":"2371","dJobJCdNm":"[2371]환경공학 기술자 및 연구원","dJobICd":"E370","dJobICdNm":"[E370]하수, 폐수 및 분뇨 처리업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004438:1', '{"dJobCd":"K000004438","dJobCdSeq":"1","dJobNm":"해양기술자","workSum":"항만개발(방파제, 항구, 부두 등의 수상구조물), 임해공업단지 조성 및 개발 등을 위한 기초자료를 조사·분석하고 해양생물, 해양지질, 해양화학, 해양물리, 해양자원 및 해양공학 등의 전문적인 지식을 이용하여 해양환경현황을 조사, 관측, 평가 및 계획한다.","doWork":"항만개발, 임해공업단지조성, 연안해양의 물리현상 등의 조사, 관측을 목적으로 조석관측(해수면의 높이관측), 연속조류관측, 층별조류관측(해수층의 표·중·저별 유향유속관측)을 실시한다. 수온·염분관측, 해수 중의 부유사의 농도 및 입경조사, 해저지질조사, 부표추적조사, 소류사의 양 및 방향 관측, 기타 수질관측과 기상관측을 통하여 환경영향평가 및 위치적 타당성 검토를 위한 기초자료를 수집한다. 분석된 자료를 해양측량사에게 제출한다. 흙의 일반적인 성질과 압밀, 침하, 활동현상을 분석하고, 토압의 산정과 구조물의 하중에 대한 지지력을 추적하여 해안보전 시설물, 방파제, 방사제, 호안시설 등 해양구조물의 안정을 위한 합리적인 공법 및 도면작성, 재료선택, 시공 및 시공에 따른 오염물의 확산, 해안 건설공사로 인한 생태계의 영향 등을 관련 기술자에게 자문한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"해양공학기술자","certLic":"해양기술사, 해양공학기사, 해양자원개발기사, 해양조사산업기사, 해양환경기사","dJobECd":"1553","dJobECdNm":"[1553]환경공학 기술자 및 연구원","dJobJCd":"2371","dJobJCdNm":"[2371]환경공학 기술자 및 연구원","dJobICd":"F412/M721","dJobICdNm":"[F412]토목 건설업 / [M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003669:1', '{"dJobCd":"K000003669","dJobCdSeq":"1","dJobNm":"해양환경연구원","workSum":"전국 연근해역의 해양환경을 모니터링하고 연안어장 환경회복 및 적정관리에 관해 연구한다.","doWork":"어장환경의 적정관리 기술에 관해 연구한다. 어장환경 개선기술에 관해 연구한다. 어장환경 평가 및 제어에 관해 연구한다. 어장환경의 평가, 회복 및 적정관리 기술에 관해 연구한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"1553","dJobECdNm":"[1553]환경공학 기술자 및 연구원","dJobJCd":"2371","dJobJCdNm":"[2371]환경공학 기술자 및 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006896:1', '{"dJobCd":"K000006896","dJobCdSeq":"1","dJobNm":"환경기술자(일반)","workSum":"대기오염, 수질오염, 소음 및 진동 문제, 폐기물처리 등 공해방지시설, 건설공사현장의 환경개선 등 이와 관련된 분야를 연구·개발하는 업무를 수행한다.","doWork":"자연환경과 생활환경을 오염시키는 대기오염, 수질오염, 폐기물로 인한 오염 및 건설현장에서 발생하는 소음 및 진동을 최소화하고 해소하기 위한 대처방안을 연구한다. 고체, 액체, 기체상태의 오염물질을 pH계 화학약품, 원심분리기, 분광분석기, 현미경 등 측정기기를 사용하여 분석한다. 배출가스, 폐수 등의 견본을 수집하고 원인을 조사한다. 조사한 자료를 분석하여 오염 원인을 분석하고 방지대책을 세우거나 기계를 제작한다. 방지시설의 타당성 검토, 시공감리, 운전상의 문제점 등을 점검·조치한다. 가스 및 액체유동시스템, 화학반응시스템 및 검사기기 등을 설치·운영한다. 대기·수질오염을 방지하기 위한 시설, 장치 및 공법을 실험·연구하여 방안을 제시하고 폐기물에 대한 처리, 폐기물에 대한 재생, 소각로의 개발 등에 관한 연구, 개발을 한다. 환경통제 또는 환경보호의 한 분야를 전문으로 연구·개발하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"환경공학기술자","connectJob":"대기환경공학기술자, 수질환경공학기술자, 토양환경공학기술자, 폐기물환경공학기술자, 소음진동환경공학기술자","certLic":"대기관리기술사, 대기환경기사·산업기사, 수질관리기술사, 수질환경기사·산업기사, 소음진동기술사·기사·산업기사, 폐기물처리기술사·기사·산업기사, 토양환경기술사·기사, 환경측정분석사","dJobECd":"1553","dJobECdNm":"[1553]환경공학 기술자 및 연구원","dJobJCd":"2371","dJobJCdNm":"[2371]환경공학 기술자 및 연구원","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002191:1', '{"dJobCd":"K000002191","dJobCdSeq":"1","dJobNm":"환경설비기술자","workSum":"오염된 토양의 정화와 상·하수 등의 수질 개선, 폐기물 처리, 대기오염 방지와 관련한 설비의 공정을 연구·개발하고, 이를 조작 운영한다.","doWork":"토양, 대기, 폐기물 및 수질 등의 환경오염 방지와 처리를 위한 장비와 설비의 공정을 연구한다. 각종 환경설비를 조작 운영, 보수, 개조 업무를 수행한다. 환경설비에 유입되는 오염물질의 유입량과 처리 속도의 변화를 관찰하고, 이에 관련된 실험을 수행하고 기록한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"대기관리기술사, 대기환경기사·산업기사, 수질관리기술사, 수질환경기사·산업기사, 소음진동기술사·기사·산업기사, 폐기물처리기술사·기사·산업기사, 토양환경기술사·기사, 환경측정분석사","dJobECd":"1553","dJobECdNm":"[1553]환경공학 기술자 및 연구원","dJobJCd":"2371","dJobJCdNm":"[2371]환경공학 기술자 및 연구원","dJobICd":"C291","dJobICdNm":"[C291]일반 목적용 기계 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006388:1', '{"dJobCd":"K000006388","dJobCdSeq":"1","dJobNm":"환경연구원(일반)","workSum":"환경문제를 연구·분석·평가하고 환경오염의 통제방법 및 환경문제의 개선책을 개발한다.","doWork":"연구계획에 따라 자료의 수집방법을 결정한다. 환경오염원을 추적·분석하여 오염원에 의한 영향력을 조사한다. 조사한 자료를 종합·분석하여 환경상태를 평가하고 기준을 세우며 환경통제에 관한 접근방법을 개발한다. 대기, 수질, 토지, 소음 및 방사능 등에 관련하여 미래의 오염가능성이나 오염의 상태 및 원인 등에 관한 보고서를 작성한다. 환경문제에 관하여 정책을 수립하고 추진하는 지역사회 및 정부기관에 자문역할을 수행하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실외","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"대기오염분석가, 수질오염분석가, 토양오염분석가","certLic":"대기관리기술사, 대기환경기사·산업기사, 수질관리기술사, 수질환경기사·산업기사, 소음진동기술사·기사·산업기사, 폐기물처리기술사·기사·산업기사, 토양환경기술사·기사, 환경측정분석사","dJobECd":"1553","dJobECdNm":"[1553]환경공학 기술자 및 연구원","dJobJCd":"2371","dJobJCdNm":"[2371]환경공학 기술자 및 연구원","dJobICd":"M721/M729","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업 / [M729]기타 과학기술 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007582:1', '{"dJobCd":"K000007582","dJobCdSeq":"1","dJobNm":"환경영향평가원","workSum":"사업 시행에 따른 부정적인 환경영향을 최소화하기 위하여 사업계획과 환경조사분석 결과를 토대로 주변 환경에 미치는 영향을 예측·평가하고 목표 기준에 대한 최적의 저감 방안 및 사후 환경관리 계획을 수립한다.","doWork":"사업내용, 환경조사분석 자료, 사업관련 법령을 검토하여 사업계획 전반을 파악한다. 환경영향 요소 도출, 평가 항목별 범위와 방법을 설정하고 평가준비서를 작성하여 환경영향평가협의회 심의 결과를 반영한다. 사업계획과 환경조사분석 결과를 토대로 육상생물상, 육수생물상, 해양생물상과 자연환경자산을 평가한다. 사업계획과 환경조사분석 결과를 토대로 기상, 대기질, 악취 및 온실가스를 평가한다. 환경조사분석 결과와 사업계획서를 이용하여 사업의 시행이 수질, 수리·수문, 해양환경에 미치는 영향을 예측 평가하고 저감대책을 수립한다. 사업계획과 환경조사분석 결과를 토대로 토지이용, 토양, 지형·지질을 평가한다. 사업계획과 환경조사분석 결과를 토대로 친환경적 자원순환, 소음·진동, 위락·경관, 위생·공중보건, 전파장해, 일조장해를 평가한다. 환경조사분석 결과와 사업계획서를 이용하여 사업의 시행이 인구, 주거, 산업에 미치는 영향을 예측 평가하고 저감대책을 수립한다. 사업의 시행과 관련하여 관계기관이나 지역주민들의 의견과 공청회 과정에서 수렴된 의견을 취합하여 반영여부를 확인한다. 항목별 환경영향평가의 예측결과, 저감방안에 대한 종합평가와 불가피한 영향 도출, 사업계획에 대한 친환경적 대안 제시 등 환경영향평가의 전문가적 조언을 작성한다. 환경영향평가 결과를 토대로 사후환경영향조사계획과 협의내용 관리계획을 수립하고 저감방안을 취합 검토한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"협의","workFunc3":"정밀작업","similarNm":"환경영향평가사","connectJob":"해양환경영향평가사","certLic":"대기관리기술사, 수질관리기술사, 소음진동기술사, 토양환경기술사, 폐기물처리기술사, 대기환경기사, 수질환경기사, 소음진동기사, 토양환경기사, 폐기물처리기사, 온실가스기사, 환경위해관리기사, 대기환경산업기사, 수질환경산업기사, 소음진동산업기사, 폐기물처리산업기사, 온실가스산업기사, 환경기능사, 해양해양환경기사, 해양자원개발기사, 해양공학기사, 해양생산관리기사","dJobECd":"1553","dJobECdNm":"[1553]환경공학 기술자 및 연구원","dJobJCd":"2371","dJobJCdNm":"[2371]환경공학 기술자 및 연구원","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002595:1', '{"dJobCd":"K000002595","dJobCdSeq":"1","dJobNm":"환경컨설턴트","workSum":"기업이나 공공의 환경관리 및 보전상의 문제점을 조사하고 진단하여 이에 대한 해결책을 제시한다.","doWork":"친환경 경영시스템, 환경회계 감사, 환경법과 환경규제에 대한 대응, 환경경영체제(ISO 14001) 관련 친환경기업 지정 등의 환경경영컨설팅 신청을 받아 각 평가 및 조사에 관련된 기준을 검토하고 현장조사를 위한 일정 등의 계획을 수립한다. 각 평가항목의 법적, 규범적 기준에 따라 전략, 정책, 조직구조, 문제점을 재고할 수 있도록 현재 수준을 파악하고 격차분석(Gap) 등을 통해 평가한다. 주요 성과지표, 산업동향, 글로벌 수준, 모범사례 대비 정책과 전략, 성과분석을 위해 관련 문서를 조사·평가하고, 조직의 면담 및 조사와 평가현장의 방문조사를 통해 취약점과 보완 가능성을 분석한다. 조사, 진단, 평가된 내용을 정리하고 기술적, 사회적 해결책을 제시한 보고서를 작성한다. 환경과 관련한 이해당사자들의 의견을 청취하고 조율하기 위한 간담회를 진행하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"언어력|시각|","workFunc1":"종합","workFunc2":"자문","workFunc3":"관련없음","connectJob":"제품환경컨설턴트","certLic":"대기관리기술사, 대기환경기사·산업기사, 수질관리기술사, 수질환경기사·산업기사, 소음진동기술사·기사·산업기사, 폐기물처리기술사·기사·산업기사, 토양환경기술사·기사, 환경측정분석사, ISO 14001 심사원","dJobECd":"1553","dJobECdNm":"[1553]환경공학 기술자 및 연구원","dJobJCd":"2371","dJobJCdNm":"[2371]환경공학 기술자 및 연구원","dJobICd":"M715","dJobICdNm":"[M715]회사 본부 및 경영 컨설팅 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002273:1', '{"dJobCd":"K000002273","dJobCdSeq":"1","dJobNm":"계통지령원","workSum":"수용가에게 안전하고 원활한 가스 공급을 할 수 있도록 가스 공급 상황을 감시하고 공급 계통을 통제·관리한다.","doWork":"생산기지의 설비가동현황을 파악하고 송출량을 조정한다. 가스 수송선의 입항일정에 따른 적정재고량 유지 여부를 파악하고 송출량을 조정하며 가스공급망의 운전상황을 감시하고 주배관 계통의 적정 압력과 적정 공급량이 유지되도록 가스공급계통을 운영한다. 중앙지령실은 전국주배관망 계통감시 및 지령, 전국 및 지역통제소 간 계통 복구 총괄 지휘, 지역통제소 백업(Back-Up)기능을 수행하며, 지역통제소에서는 관할 지역계통감시 및 통제, 사고 지역응급조치 및 비상조작을 한다. 공급관리소의 운영현황을 파악하여 주요사항을 작성하여 보고한다. 생산기지 및 공급관리소의 주요 경보사항을 감시·분석하여 문제점이 해결되도록 조치한다. 가스공급망의 경보발생 여부를 감시하고 조정한다. 비상상황이 발생하면 긴급조치규정에 따라 처리하도록 지시한다. 공급관리소 및 지사의 가스공급관련 밸브의 조작신청에 따른 조작내용에 대한 검토와 승인업무를 한다. 중앙지령실의 각종 설비응용프로그램을 운영한다. 가스공급에 따른 작업내용을 분석하여 일보·월보 등의 자료로 작성한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"제어조작","connectJob":"계통감시원, 데이터관리원, 고압계통원, 중저압계통원","dJobECd":"1551","dJobECdNm":"[1551]가스·에너지공학 기술자 및 연구원","dJobJCd":"2372","dJobJCdNm":"[2372]가스·에너지 기술자 및 연구원","dJobICd":"D352","dJobICdNm":"[D352]연료용 가스 제조 및 배관공급업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004077:1', '{"dJobCd":"K000004077","dJobCdSeq":"1","dJobNm":"광산기술자","workSum":"광산에서 지하자원을 캐내기 위하여 채광계획을 세우고 탐사, 시추, 채광, 선광방법, 지주, 배수, 통기 등에 대하여 연구, 개발 및 기술지도를 한다.","doWork":"광상(鑛床:광물자원이 암석 속에 자연 상태로 집중되어 있는 것)의 위치, 심도, 규모, 가치, 광맥의 변화, 출수 등 조건변화에 따라 가장 효율적인 채광방법 및 지질학적 연구를 한다. 광산공학적 지식을 토대로 광상의 심도와 특성, 주변 지층의 발달상태에 따라 가장 효과적이고 경제적인 채광방법을 계획한다. 유용자원을 탐사하고 시추하는 방법을 연구한다. 수갱·사갱·수평갱도의 위치 및 굴착방향을 계획하고, 채굴갱도의 규모 및 배치, 채광방법과 생산량, 채광장비 및 운반장비를 결정한다. 광석을 분류하는 장소와 맥석과 광석을 저장하는 장소를 물색하고, 지하공동의 충전(충진) 방법을 결정한다. 갱도굴착 및 유지, 배수·통기·동력공급, 레일과 컨베이어 설비 등을 건설하고 운영한다. 효율성과 안전을 고려하여 인력과 장비의 사용을 계획하고 조정한다. 환경공학적 지식을 적용하여 광산환경에 따른 문제점을 해결한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"힘든 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"광산연구기술자, 채광기술자","certLic":"광산보안기사, 광산보안산업기사, 응용지질기사","dJobECd":"1551","dJobECdNm":"[1551]가스·에너지공학 기술자 및 연구원","dJobJCd":"2372","dJobJCdNm":"[2372]가스·에너지 기술자 및 연구원","dJobICd":"B051/B061/B062","dJobICdNm":"[B051]석탄 광업 / [B061]철 광업 / [B062]비철금속 광업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006938:1', '{"dJobCd":"K000006938","dJobCdSeq":"1","dJobNm":"바이오에너지연구원","workSum":"바이오매스(동식물성 자원 및 그 파생 물질)로부터 열화학적 또는 생물학적 기술에 의한 에너지 및 연료(메탄, 바이오디젤, 바이오에탄올, 수소, 합성가스 등)의 생산 기술을 연구·개발한다.","doWork":"동·식물성 바이오매스나 유기성 폐기물로부터 화석 에너지를 대체할 수 있는 바이오 고형연료(우드칩, 펠렛), 가스(메탄, 수소) 또는 액상연료(바이오디젤, 바이오에탄올, BTL) 등 재생에너지원의 생산 및 활용 기술을 연구·개발한다. 미세조류 고농도 배양 및 바이오연료 생산 기술을 연구·개발한다. 목질계 에탄올 생산 기술, 바이오매스 열분해 및 가스화 기술, 바이오매스 초임계수 가스화 기술을 연구·개발한다. 비식용 원료 활용 바이오디젤 생산 공정 기술, 유기성 폐기물 및 에너지 작물(농산부산물)의 통합 바이오가스화 기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"바이오화학제품제조산업기사","dJobECd":"1551","dJobECdNm":"[1551]가스·에너지공학 기술자 및 연구원","dJobJCd":"2372","dJobJCdNm":"[2372]가스·에너지 기술자 및 연구원","dJobICd":"C204","dJobICdNm":"[C204]기타 화학제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004815:1', '{"dJobCd":"K000004815","dJobCdSeq":"1","dJobNm":"방사선안전관리요원","workSum":"방사선, 방사능 측정기를 통해 작업장의 환경감시, 방사능 오염검사, 방사선취급 작업을 관리한다.","doWork":"원자력이용시설 방사선관리구역의 방사선위해도 평가를 위하여 방사선, 방사능 측정기기를 활용하여 작업공간의 공간선량률, 표면오염도, 공기 중 방사능 농도 등을 측정한다. 방사선취급작업 시 방사선작업종사자의 방사선위해가 최소화될 수 있도록 적절한 방호용구 착용을 지시하고 오염구역 통제 및 방사선량 저감화 조치 등의 현장 방사선 취급작업을 관리한다. 각 원자력이용시설 사업소 특성에 따라 보유하고 있는 방사선안전관리장비를 유지관리한다. 방사선작업종사자의 방사선피폭 판독, 방사선감시기의 유지보수, 방사성물질 운반에 대한 방사선안전관리, 방사성시료 및 방사성폐기물의 분석 등 방사선안전관리 업무를 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workEnv":"위험내재|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"방사선관리요원, 방사선안전관리원","certLic":"원자력기사, 방사선관리기술사, 방사성동위원소취급면허, 핵연료물질취급면허","dJobECd":"1551","dJobECdNm":"[1551]가스·에너지공학 기술자 및 연구원","dJobJCd":"2372","dJobJCdNm":"[2372]가스·에너지 기술자 및 연구원","dJobICd":"D351/M729","dJobICdNm":"[D351]전기업 / [M729]기타 과학기술 서비스업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006779:1', '{"dJobCd":"K000006779","dJobCdSeq":"1","dJobNm":"방사선안전관리자","workSum":"원자력이용시설의 규정 및 기술기준 준수여부를 점검하고 방사선작업종사자에 대한 장해방어조치등 방사선안전관리 업무를 총괄한다.","doWork":"원자력이용시설의 설계 및 운영을 위하여 방사선설비의 기술기준 사양을 검토⋅조정한다. 원자력이용시설의 인허가 업무와 방사선안전과 관련하여 운영지침서 및 절차서를 개발한다. 원자력이용시설의 방사선 위해 방지 및 방사선작업종사자 장해방지조치를 예방한다. 방사선 위해 방지 및 방사선작업종사자의 장해방지 보호조치를 위하여 원자력이용시설에서 보유한 방사선원항의 관리 및 방사선 취급시설의 안전점검을 총괄관리한다. 방사선작업종자자의 방사선피폭관리, 방사선교육, 건강진단관리, 방사선취급작업에 대한 방사선안전관리를 한다. 원자력안전법에서 정한 원자력이용시설 사업자의 규모에 따라 정해진 주기마다 방사선안전관리 기록물을 보고하고 생산한다. 정부 및 규제기관에서 실시하는 방사선 안전 정기검사를 실시한다. 관련 사업소 등에서 보유하고 원자력이용시설의 방사선안전관리에 대하여 총괄한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"방사선관리자, 방사선기술자","certLic":"방사선관리기술사, 원자력기사, 방사성동위원소취급면허, 핵연료물질취급면허","dJobECd":"1551","dJobECdNm":"[1551]가스·에너지공학 기술자 및 연구원","dJobJCd":"2372","dJobJCdNm":"[2372]가스·에너지 기술자 및 연구원","dJobICd":"M701/M702","dJobICdNm":"[M701]자연과학 및 공학 연구개발업 / [M702]인문 및 사회과학 연구개발업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002071:1', '{"dJobCd":"K000002071","dJobCdSeq":"1","dJobNm":"방사성폐기물관리원","workSum":"원자력발전소에서 발생하는 각종 방사성 물질의 처리 및 폐기물의 관리를 위한 제반 업무를 수행한다.","doWork":"발전소에서 발생하는 방사성 액체 및 고체 폐기물의 방출, 기계 폐기물의 처리 및 저장 등 각종 방사성 물질의 관리에 관한 장·단기 계획을 수립한다. 폐기물에서 방사되는 방사능의 양을 측정하여 국제규격에 적합한지 판별한다. 폐기물 보관창고의 안전상태를 점검하고 재고량을 점검한다. 소각할 폐기물의 종류와 매장할 폐기물의 종류를 분류하는 기준을 작성한다. 방사성폐기물 처리방법과 관리방법을 연구·개선하여 폐기물의 수량과 작업자의 피폭량을 최소화한다. 국외 방사성 처리에 관한 정보를 수집·분석하여 국내에 맞는 처리 방법을 연구한다. 폐기물 처리 방법에 관한 자료를 검토·분석하여 지침서를 작성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"원자력기사, 방사선관리기술사","dJobECd":"1551","dJobECdNm":"[1551]가스·에너지공학 기술자 및 연구원","dJobJCd":"2372","dJobJCdNm":"[2372]가스·에너지 기술자 및 연구원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007810:1', '{"dJobCd":"K000007810","dJobCdSeq":"1","dJobNm":"방사성폐기물자체관리자","workSum":"원자력시설 방사선관리구역에서 발생하는 폐기물 중 자체처분 가능한 폐기물을 분류/처리하여 규정에 따라 자체처분 위한 제반 업무를 수행한다.","doWork":"방사선관리구역에서 발생하는 폐기물 중 사전검사(표면오염도 및 방사능 측정 등)를 통해 자체처분 가능한 폐기물을 분류하여 수집한다. 자체처분대상폐기물의 대표시료를 채취하고 계측장비를 통해 핵종농도를 분석한다. 자체처분대상 폐기물의 발생이력 등을 조사하고 폐기물의 특성규명 자료(피폭선량 산출 포함)를 활용하여 자체처분계획서를 절차에 맞게 작성한다. 규제기관에 자체처분 신청하고 그 계획서를 제출한다. 규제기관에 심사 진행에 따라 질의응답에 대응하여 자체처분 적합 통보를 수령하는 일련의 과정을 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"방사성폐기처리처분연구원, 방사성폐기물관리원","certLic":"방사성동위원소취급자일반면허, 방사선취급감독자면허, 방사선관리기술사","dJobECd":"1551","dJobECdNm":"[1551]가스·에너지공학 기술자 및 연구원","dJobJCd":"2372","dJobJCdNm":"[2372]가스·에너지 기술자 및 연구원","dJobICd":"E382","dJobICdNm":"[E382]폐기물 처리업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001377:1', '{"dJobCd":"K000001377","dJobCdSeq":"1","dJobNm":"방사성폐기물처리시설안전관리원","workSum":"처분시설의 안전한 운영을 위해 방사성폐기물의 시료 분석 및 안전관리를 수행한다.","doWork":"방사성폐기물 처분장 운영 중 발생하는 방서선량을 측정하기 위해 방사선 감시설비를 운영한다. 기체·액체·고체방사성폐기물과 비방사성폐기물의 시료를 채집한다. 계측장비를 사용하여 알파방사능, 베타방사능 등의 방사선량을 분석하고 배출한다. 검사결과를 확인하고 검증한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"방사성동위원소취급자일반면허, 방사선취급감독자면허, 방사선관리기술사","dJobECd":"1551","dJobECdNm":"[1551]가스·에너지공학 기술자 및 연구원","dJobJCd":"2372","dJobJCdNm":"[2372]가스·에너지 기술자 및 연구원","dJobICd":"E382","dJobICdNm":"[E382]폐기물 처리업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005665:1', '{"dJobCd":"K000005665","dJobCdSeq":"1","dJobNm":"방사성폐기물처분관리원","workSum":"안전성을 확보하기 위해 방사성폐기물의 처분 과정에서 발생하는 정보를 관리시스템으로관리하고 처분에 사용되는 전용장비를 유지·관리한다.","doWork":"방사성폐기물 처분 계획을 수립하고 처분검사 및 처분 작업지시서를 작성한다. 처분할 방사능폐기물을 처분용기에 넣어 전용차량을 이용하여 운반하고 크레인을 이용하여 사일로에 적치시킨다. 각 사일로의 처분수량 및 처분방사능량을 확인하고 결과를 보고한다. 처분용기와 처분트럭, 사일로 크레인의 점검 및 유지, 보수를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|고온|","workFunc1":"분석","workFunc2":"협의","workFunc3":"정밀작업","dJobECd":"1551","dJobECdNm":"[1551]가스·에너지공학 기술자 및 연구원","dJobJCd":"2372","dJobJCdNm":"[2372]가스·에너지 기술자 및 연구원","dJobICd":"E382","dJobICdNm":"[E382]폐기물 처리업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005118:1', '{"dJobCd":"K000005118","dJobCdSeq":"1","dJobNm":"방사성폐기물처분시설안전성평가원","workSum":"방사성폐기물처리시설의 안전성 평가방식을 계획하고 방사성폐기물의 운반 및 처리시설 운영에 대한 안전성을 평가·입증한다.","doWork":"안전성 평가를 위한 종합프로그램을 이행함으로써 전체 처분시설의 안전성을 입증한다. 처분시설 운영과 폐쇄 후 안정성 평가를 위해 핵종재고량 평가하고 안전성 평가 자료를 수집한다. 여러 상황에 따른 안정성 평가방식을 수립한다. 폐기물 운반 시 운반경로의 방사선영향평가를 위해 방사선 선량평가를 수행하고 이를 통해 안전성을 입증한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"협의","workFunc3":"정밀작업","certLic":"방사성동위원소취급자 일반면허, 방사성동위원소취급 감독자면허, 원자력기사, 방사선관리기술사","dJobECd":"1551","dJobECdNm":"[1551]가스·에너지공학 기술자 및 연구원","dJobJCd":"2372","dJobJCdNm":"[2372]가스·에너지 기술자 및 연구원","dJobICd":"E382","dJobICdNm":"[E382]폐기물 처리업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002069:1', '{"dJobCd":"K000002069","dJobCdSeq":"1","dJobNm":"방사성폐기물추적관리원","workSum":"방사성폐기물의 발생에서 처분 후 관리기간까지 전체 방사성폐기물의 이력정보를 관리한다.","doWork":"발생기관 자체검사, 발생지 예비검사, 운반, 처분시설 인수검사 및 규제기관 처분검사, 처분 후 생성되는 방사성폐기물의 물리적, 화학적, 방사선적 특성정보를 추적·관리한다. 처분시설 운영 중 및 폐쇄 후의 핵종별 재고량 및 방사능량 예측 등의 업무를 수행한다. 방사성폐기물추적관리시스템의 방사성폐기물 연간 인도·인수 계획, 발생기관 자체검사 자료, 발생지 예비검사 자료, 처분장 인수검사 자료 등을 입력하고 운영·유지 관리한다. 안전성분석보고서에 따라 방사성폐기물에 대한 정보를 실시간으로 추적관리하고 관련 정보를 제공한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"웅크림|","workFunc1":"분석","workFunc2":"협의","workFunc3":"정밀작업","certLic":"원자력기사, 정보처리기사, 방사성동위원소취급자 일반면허","dJobECd":"1551","dJobECdNm":"[1551]가스·에너지공학 기술자 및 연구원","dJobJCd":"2372","dJobJCdNm":"[2372]가스·에너지 기술자 및 연구원","dJobICd":"E382","dJobICdNm":"[E382]폐기물 처리업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001420:1', '{"dJobCd":"K000001420","dJobCdSeq":"1","dJobNm":"석유기술자","workSum":"석유공학 및 관련 기술과 지식을 이용하여 유가스전에서 원유 또는 천연가스를 최대한 회수하는 방법을 도출하기 위하여 기술적 요소 및 비용을 분석한다.","doWork":"원유 및 천연가스 부존 지역에서 개발 가능성과 경제성이 큰 시추공의 위치를 선정하기 위해 원유 및 천연가스의 부존 예상 지역에 지질자료와 탐사자료를 검토한다. 자연생산 또는 인공채유가 가능한 원유 및 천연가스 회수율을 평가한다. 원유 및 천연가스 회수 증진방법을 통해 생산 가능한 원유 및 천연가스 회수율을 평가한다. 일반적으로 저류층에 존재하지 않는 물질을 주입하여 원유 및 천연가스 회수를 증대하는 공정을 설계한다. 유가스전에서 시추공 굴착을 위한 지질 및 탐사 전문가의 의견을 검토한다. 방향성 시추 등과 같은 특수공정의 사용 여부, 케이싱, 시추액을 포함한 시추 자재의 소요 및 비용을 명시하여 경영진의 동의를 얻기 위한 시추계획을 수립한다. 시추공 불안정, 이수 유실, 비트볼링, 시추공 궤도이탈, 파이프 고착 등 시추 시 발생하는 문제점 해결 방안을 제시한다. 굴착 조건을 개선하기 위하여 시추액 혼합물 또는 장비의 교체 계획을 수립한다. 최종 케이싱 및 튜빙의 설치가 제대로 완료되었는지 결정하기 위하여 시추공을 검사한다. 생산유체에서 원유와 천연가스를 분리처리저장수송하기 위한 유가스전의 생산 설비와 공정을 설계한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|다습|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"석유생산기술자, 저류기술자, 지열개발기술자","certLic":"자원관리기술사","dJobECd":"1551","dJobECdNm":"[1551]가스·에너지공학 기술자 및 연구원","dJobJCd":"2372","dJobJCdNm":"[2372]가스·에너지 기술자 및 연구원","dJobICd":"B052","dJobICdNm":"[B052]원유 및 천연가스 채굴업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003756:1', '{"dJobCd":"K000003756","dJobCdSeq":"1","dJobNm":"선광기술자","workSum":"광석으로부터 유용광물을 추출하기 위하여 경제적이고 효율적인 선광법을 연구·개선하고, 선광조업 기술을 지도한다.","doWork":"광산에서 채취된 시료를 파쇄·분쇄하여 일정량으로 나눈다. 광석에 따라 적정한 시험법을 선택한다. 선광의 품질과 회수율 향상을 위하여 광석의 입도별 시험, 포수제 및 억제제 사용량, 변화시험, 광액 농도 변화시험, 광액 온도 변화시험, 정선회수 변화시험, 급광속도 변화시험, 자력 및 전기력 변화시험 등을 하고 시험결과를 분석하여 유용광물을 가장 경제적이고 효율적으로 회수할 수 있는 방법과 조건을 찾아낸다. 광종·산지·시험목적·시료의 성질, 시험방법 및 결과 등을 기록한 자료를 작성하고 관리한다. 현장의 선광장에서 기술지도를 통하여 기계의 용량, 선광공정의 기선, 수정, 보완, 시약의 선택 및 양 등에 대하여 자문하고 지도한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"힘든 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"선탄기술자","certLic":"광산보안기사, 자원관리기술사, 광산보안산업기사","dJobECd":"1551","dJobECdNm":"[1551]가스·에너지공학 기술자 및 연구원","dJobJCd":"2372","dJobJCdNm":"[2372]가스·에너지 기술자 및 연구원","dJobICd":"B051/B061/B062","dJobICdNm":"[B051]석탄 광업 / [B061]철 광업 / [B062]비철금속 광업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006493:1', '{"dJobCd":"K000006493","dJobCdSeq":"1","dJobNm":"시추기술자","workSum":"지하자원 부존위치와 형태를 파악하고 그라우팅이나 지하수개발을 위하여 지층의 지질학적 특성을 분석하기 위한 시추를 계획하고 지휘한다.","doWork":"지하자원 탐사기술자로부터 시추위치와 시추심도를 통보받거나 결정한다. 암석의 강도, 지층의 구조 등에 따라 광산시추 프로그램, 소요장비 및 자재, 인원, 공사비 등을 결정하여 시추 계획을 작성한다. 이수의 점성과 혼합할 약품의 종류 또는 비율을 결정한다. 시추가 진행되는 동안 시추공이 휘는 것을 방지하기 위하여 트로파리(Tropari), 파자리(Pazary) 등의 공곡(空曲)측정기를 사용하여 공곡을 측정하고 수정한다. 채취된 암추(Core)의 상태를 검사한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"힘든 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"광산보안기사, 광산보안산업기사, 자원관리기술사","dJobECd":"1551","dJobECdNm":"[1551]가스·에너지공학 기술자 및 연구원","dJobJCd":"2372","dJobJCdNm":"[2372]가스·에너지 기술자 및 연구원","dJobICd":"B051/B052/B080","dJobICdNm":"[B051]석탄 광업 / [B052]원유 및 천연가스 채굴업 / [B080]광업 지원 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003180:1', '{"dJobCd":"K000003180","dJobCdSeq":"1","dJobNm":"신재생에너지안전기술연구원","workSum":"신·재생에너지 이용 부분의 안전성 확보를 위하여 안전기술을 연구하고 관련 제품 검사 및 안전성에 대한 인증을 한다.","doWork":"수소 이용 안전기술, 연료전지 이용 안전기술, DME 이용 안전기술, 메탄하이드레이트 이용 안전기술 등 신생에너지 안전기술을 연구·개발한다. 매립지가스 등 재생에너지 관련 안전기술을 연구·개발한다. 새로운 에너지 이용의 안전성 확보를 위한 제도적 기반을 구축하고, 신·재생 에너지 보급시스템에 의한 대형사고를 미연에 방지하기 위한 연구를 한다. 수소 스테이션, 개질기, 연료전지, NGV, 환경기술 관련 제품검사 및 안전성에 대한 인증을 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"신재생에너지발전설비기능사(태양광), 신재생에너지발전설비산업기사(태양광), 신재생에너지발전설비기사(태양광)","dJobECd":"1551","dJobECdNm":"[1551]가스·에너지공학 기술자 및 연구원","dJobJCd":"2372","dJobJCdNm":"[2372]가스·에너지 기술자 및 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004266:1', '{"dJobCd":"K000004266","dJobCdSeq":"1","dJobNm":"에너지공정연구원","workSum":"새로운 에너지 및 각종 에너지 변환기기에 관하여 연구한다.","doWork":"건물, 수송, 산업 부문의 에너지 수요관리 및 절약 기술을 연구한다. 에너지 효율향상 및 에너지 저장기술을 개발한다. 열에너지의 효율적인 이용을 위해 변환기술 및 열에너지시스템에 관한 연구 및 에너지 기기의 효율향상을 위한 연구를 한다. 차세대 에너지 분야를 위한 소재를 연구·개발한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"1551","dJobECdNm":"[1551]가스·에너지공학 기술자 및 연구원","dJobJCd":"2372","dJobJCdNm":"[2372]가스·에너지 기술자 및 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005413:1', '{"dJobCd":"K000005413","dJobCdSeq":"1","dJobNm":"원자력기술자","workSum":"원자력발전소 건설 시 안전성 및 신뢰성 확보를 위하여 엄격한 관리로 원자력 관련 제 규정, 규격 및 품질보증 요구조건에 따라 1차 계통(발전기, 터빈 등과 관련된 시설물)의 설비시공을 관리·감독하는 직무를 수행한다.","doWork":"원자력발전소의 건설에 따른 장·단기 설비 시공계획을 설정하고 세부 시행계획을 수립하여 시공에 따른 공사항목의 검토 승인 및 이의 시행을 위한 업무를 수행한다. 소요자재 조달에 대한 검토 및 자재의 품질을 검사하여 승인한다. 공사시행에 따라 시공된 설비의 합격 여부를 판정하여 시공상의 모든 책임을 진다. 1차 계통 설비시설물의 설계서를 검토하고 잘못된 부분을 수정하여 합격 여부를 판정하고 승인한다. 기술정산보고서를 검토하고 승인한다. 시공된 원자로와 관련된 배관시설, 전기시설, 발전기계 등 1차 계통 시설물의 안전성, 신뢰성 품목에 대한 품질준수 요건 검토 및 현장적용 요건을 확인하고 대내외 규제 기관(본사 품질관리처 및 원자력안전기술원 등)의 수검계획 수립을 확인하여 수검업무를 수행한다. 문제점에 대한 시정조치 내용을 협의·검토하고 처리지침을 결정·시달한다. 안전성과 신뢰성이 있는 시공이 되도록 1차 계통의 설비물이 세부설계도나 시방서의 내용과 실제 현장 적용사항을 검사하고 작업원을 관리·감독한다. 원자력발전소의 시공 후 유지·관리하기 위하여 각종 기술정보를 수집·검토·정리하고 운영계획을 설정하고 세부시행계획을 수립하여 연차적으로 보수·개선방안을 강구한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"원자력공학기술자","connectJob":"원자력기계기술자, 원자력전기기술자, 원자력계측제어기술자","certLic":"원자력발전기술사, 원자력기사","dJobECd":"1551","dJobECdNm":"[1551]가스·에너지공학 기술자 및 연구원","dJobJCd":"2372","dJobJCdNm":"[2372]가스·에너지 기술자 및 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004986:1', '{"dJobCd":"K000004986","dJobCdSeq":"1","dJobNm":"원자로공학연구원","workSum":"원자력발전소의 안전하고 경제적인 운영지원을 위해 원자로시스템 전반에 관한 연구 및 기술개발업무를 수행한다.","doWork":"핵연료인 노심의 안전성 확보 및 경제적 연소를 위한 노심설계, 원자로 운전 분석, 노심 보호 및 감시 등에 대한 기술적인 사항을 진단·분석·평가하기 위한 연구·개발업무를 수행한다. 시뮬레이션, 신호처리, 운전상태 추적 및 과도예측, 웹 기반의 운영지원시스템 등 시스템 공학적 기술을 연구·개발한다. 원전 설계 전산코드를 개선하고, 핵 설계 전산코드운용 기술 및 핵 설계 자동화시스템을 연구·개발한다. 분산 노심모델과 원전 시뮬레이터의 기타 계통의 실시간 연계기술, 제어기 시뮬레이터 연계기술에 관한 연구·개발업무를 수행한다. 기타 노심계통에 관한 연구·개발업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"1551","dJobECdNm":"[1551]가스·에너지공학 기술자 및 연구원","dJobJCd":"2372","dJobJCdNm":"[2372]가스·에너지 기술자 및 연구원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002527:1', '{"dJobCd":"K000002527","dJobCdSeq":"1","dJobNm":"음식물쓰레기자원화시설운전원","workSum":"음식물자원화시설은 퇴비화, 사료화, 바이오가스화시설이 있으며, 이들 시설은 전처리, 본처리, 후처리과정을 거치므로 이러한 과정을 이해하고 운전한다.","doWork":"반입시설의 구성과 운전방법을 숙지한다. 전처리시설(파봉, ㅍ파쐐, 선별, 탈수)의 기능을 이해하고 운전한다. 퇴비화, 사료화, 바이오가스화시설의 특성, 운전인자를 사전에 숙지하고 운전한다. 후처리시설(선별, 탈취, 음폐수처리 등)의 방법, 절차 등을 이해하고 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"폐기물산업기사, 폐기물기사","dJobECd":"1551","dJobECdNm":"[1551]가스·에너지공학 기술자 및 연구원","dJobJCd":"2372","dJobJCdNm":"[2372]가스·에너지 기술자 및 연구원","dJobICd":"C108","dJobICdNm":"[C108]동물용 사료 및 조제식품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002619:1', '{"dJobCd":"K000002619","dJobCdSeq":"1","dJobNm":"지열폐열연구원","workSum":"지열 및 발전소 폐열을 이용한 냉난방 시설, 관련 기술 개발 및 보급 등 신재생 에너지를 연구·개발한다.","doWork":"지열 및 발전소에서 버려지는 폐열을 회수해 주택, 업무용 건물, 농어촌 및 농어업 시설의 냉난방·급탕 등에 이용할 수 있는 방법을 연구·개발한다. 지중 열교환기, 지열용 히트펌프, 지열용 물탱크, 지열 시스템이 최적의 상태로 운전되게 하는 제어설비 등을 연구·개발한다. 고온의 폐수열을 이용하는 폐수열교환용 물탱크, 시수열교환기, 폐수열용 히트펌프, 폐수열교환용 물탱크 등의 설계를 통하여 발전소 주변의 농어촌 시설에 대한 열공급 시스템을 을 연구·개발한다. 지열과 폐열을 함께 적용한 하이브리드 냉난방 및 온수생성시스템을 연구·개발한다. 에너지 비용 구조를 개선해 지열폐열 냉난방 시스템이 적용된 건축물의 경쟁력을 향상시키기 위한 에너지 이용 효율화 방법을 연구·개발한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"지열설계사, 지열시공사","certLic":"일반기계기사, 냉동공조기사","dJobECd":"1551","dJobECdNm":"[1551]가스·에너지공학 기술자 및 연구원","dJobJCd":"2372","dJobJCdNm":"[2372]가스·에너지 기술자 및 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005324:1', '{"dJobCd":"K000005324","dJobCdSeq":"1","dJobNm":"지하자원탐사기술자","workSum":"지하자원 부존위치를 찾기 위하여 각종 탐사방법 및 해당기기를 사용하여 지하자원을 탐사한다.","doWork":"지질도와 기존 조사자료를 검토하여 지하자원 부존 예상지역을 선정한다. 부존예상 광종에 따라 탐사방법 및 기기를 결정한다. 탐사면적, 기간, 인원 등을 고려하여 탐사계획을 수립한다. 현장에서 예상광종에 따라 탄성파검사, 중력탐사, 자력탐사, 화학탐사, 저류탐사 등의 탐사방법 중 몇 가지를 병행하거나 한 가지를 선택하여 탐사를 실시한다. 얻어진 자료를 분석하여 부존 예상지역을 찾아내고 견본을 채취한다. 시추위치를 선정하고 시추심도를 결정하여 시추기술자에게 시추를 의뢰한다. 실험실에서 현미경 등으로 광석 견본을 검사하고 각종 측정기기를 사용하여 저항, 자성 등 암석의 물리적 성질을 측정한다. 탐사자료, 시추결과 등을 종합하여 확보광량, 차맥률 등 탐사효과를 얻어낸다. 탐사장비를 유지·관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workEnv":"대기환경미흡|위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"자원탐사기술자","certLic":"자원관리기술사, 응용지질기사","dJobECd":"1551","dJobECdNm":"[1551]가스·에너지공학 기술자 및 연구원","dJobJCd":"2372","dJobJCdNm":"[2372]가스·에너지 기술자 및 연구원","dJobICd":"M729","dJobICdNm":"[M729]기타 과학기술 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004118:1', '{"dJobCd":"K000004118","dJobCdSeq":"1","dJobNm":"수질분석요원","workSum":"수질환경오염의 원인규명과 수질오염 정도를 파악하기 위하여 시험·분석한다.","doWork":"수질의 오염분석을 위한 적정 기법을 확인하고 수질오염 현황을 조사한다. 하천, 하천유역, 댐, 지하수, 정수처리시설, 하수처리시설, 폐수처리시설 등의 유기물, 중금속, 미량유기오염물질 등 수질실험, 부영양화(수중생태계의 영양물질이 증가하여 조류가 증식하는 현상) 원인물질 분석 등의 수질오염도를 측정한다. 수질의 생태독성 실험을 위하여 물벼룩 등을 배양하고 독성실험을 수행한다. 각종 분석용 장비 및 시설을 유지·관리한다. 실험용 시약을 제조하고 관리한다. 수질검사를 통하여 분석된 각종 자료를 관련 부서 및 기관의 요청에 따라 제공한다. 분석값의 일정한 정확도와 정밀도를 유지하기 위한 정도관리를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"기기분석수질실험원, 이화학수질실험원, 생물실험원","certLic":"수질관리기술사, 수질환경기사, 수질환경산업기사, 수질환경측정분석사, 환경기능사","dJobECd":"1554","dJobECdNm":"[1554]환경공학 시험원","dJobJCd":"2373","dJobJCdNm":"[2373]환경공학 시험원","dJobICd":"E360","dJobICdNm":"[E360]수도업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001463:1', '{"dJobCd":"K000001463","dJobCdSeq":"1","dJobNm":"제품환경분석원","workSum":"제품의 폐기 시 발생하는 환경오염 물질을 측정·분석하거나, 폐기 후의 재활용상태 등을 점검한다.","doWork":"폐기 업체나 폐기 장소를 방문하여 대기오염측정기(입자상측정기, 가스상 측정기), 수질오염측정기(BOD, COD측정, 용존산소량 측정기 등), 토양오염측정기(토양분석기) 등 각종 환경오염 측정기로 유해 물질을 측정·분석한다. 제품의 재활용 가능 부분과 소재 등을 조사하고 재활용 실태를 분석한다. 제품개발자 또는 제품생산기술자를 직접 면담하여 측정 및 조사된 결과를 설명한다. 환경오염 측정기가 정확성을 유지할 수 있도록 관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"환경측정분석사, 대기환경산업기사, 수질환경산업기사","dJobECd":"1554","dJobECdNm":"[1554]환경공학 시험원","dJobJCd":"2373","dJobJCdNm":"[2373]환경공학 시험원","dJobICd":"E390","dJobICdNm":"[E390]환경 정화 및 복원업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005478:1', '{"dJobCd":"K000005478","dJobCdSeq":"1","dJobNm":"환경시험원(일반)","workSum":"대기, 수질, 소음진동 등 환경 시설 및 방법 등의 연구 및 개발과 관련하여 환경공학기술자 및 연구원의 지휘·감독 하에 시험업무를 수행한다.","doWork":"대기, 수질, 소음진동, 토양, 폐기물 등의 오염분석을 위한 적정 기법을 확인하고 오염 현황을 조사한다. 시료를 채취하거나 준비된 시료를 토대로 원인물질 분석, 중금속 실험, 극미량 유기물 분석을 통하여 수질의 오염도를 측정한다. 오염도 등을 측정하여 환경에 미치는 영향을 조사한다. 환경오염 제거방법에 대해 실험을 한다. 각종 분석용 장비를 유지·관리한다. 실험용 시약을 제조하고 관리한다. 분석된 각종 자료를 관련 부서 및 기관의 요청에 따라 제공한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"대기시험원, 수질시험원, 소음진동시험원, 폐기물시험원, 토양시험원","certLic":"환경측정분석사, 대기환경기사, 대기환경산업기사, 수질환경기사, 수질환경산업기사, 소음진동기사, 소음진동산업기사, 폐기물처리기사, 폐기물처리산업기사, 토양기사, 토양산업기사","dJobECd":"1554","dJobECdNm":"[1554]환경공학 시험원","dJobJCd":"2373","dJobJCdNm":"[2373]환경공학 시험원","dJobICd":"E360","dJobICdNm":"[E360]수도업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;