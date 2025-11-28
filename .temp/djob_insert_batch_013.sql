INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001528:1', '{"dJobCd":"K000001528","dJobCdSeq":"1","dJobNm":"발전기계연구원","workSum":"발전용 기계설비, 보조설비 등의 안정성 및 신뢰성 향상과 효율적 운영, 관리, 유지, 정비를 위한 기술연구 및 개발업무를 수행한다.","doWork":"발전용 기계설비의 운영 및 정비를 위한 각종 기술을 개발한다. 발전설비의 수명평가 및 관리기술, 신뢰성평가기술, 비파괴평가 및 진단기술 등의 개발을 통하여 효율적인 운영과 부품의 적정 교체시기 등에 대한 판단근거를 제시한다. 발전설비의 소음, 진동으로 인한 배관의 뒤틀림 등의 피해를 최소화하기 위해 배관배치와 같은 구조역학 및 기계구조해석에 대한 기술을 연구한다. 발전설비의 부식방지, 표면처리 및 내마모성에 대한 기술을 연구한다. 터빈보조설비에 대한 안정성 및 효율성 개선 및 개발을 위한 연구업무를 수행한다. 발전기계설비의 이상 여부에 대한 판단을 위한 비파괴진단 및 평가, 비파괴자동화 등 기술개발을 위해 연구한다. 기타 발전용 기계설비에 대한 성능개선 및 개발을 위해 연구한다. 기타 연구원(일반)들이 수행하는 일반적인 활동을 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","certLic":"기계기술사, 기계설계산업기사, 일반기계기사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"C281","dJobICdNm":"[C281]전동기, 발전기 및 전기 변환ㆍ 공급ㆍ제어 장치 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003989:1', '{"dJobCd":"K000003989","dJobCdSeq":"1","dJobNm":"배출가스저감장치개발자","workSum":"자동차와 건설기계 등에 사용되는 내연기관의 배출가스 내 유해물질을 저감하기 위한 배출가스저감장치를 연구·개발한다.","doWork":"자동차 등 내연기관에서 배출되는 유해물질을 조사·분석한다. 국내외 배출가스규제기준을 파악한다. 기존 배출가스저감장치의 경제성, 효율성을 평가·검토하고 개선점을 도출한다. 일산화탄소(CO), 이산화탄소(CO2), 탄화수소(HC), 질소산화물(NOx), 아황산가스(SOx), 입자상물질(PM), 흑연(Pb), 용해성 유기물질(SOF 등)을 저감시키기 위한 촉매, 필터, 연소기술 등을 연구한다. 삼원촉매시스템, 디젤산화촉매(DOC:Diesel Oxidation Catalyst), 매연여과장치(DPF:Diesel Particulate Filter Trap) 등 매연가스후처리시스템을 연구·개발한다. 차량에 배출가스저감장치를 부착하고 성능을 시험·평가한다. 개발된 제품의 성능개선연구를수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"매연저감장치개발자, 매연여과장치개발자","connectJob":"매연포집기개발자","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"C303","dJobICdNm":"[C303]자동차 신품 부품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002858:1', '{"dJobCd":"K000002858","dJobCdSeq":"1","dJobNm":"산업용기계설계기술자","workSum":"기계, 구조물, 부품 등의 설계에 대한 계획을 수립하고 CAD시스템을 사용하여 도면을 작성하며 모델링을 통하여 안전성과 설계사항을 검토한다.","doWork":"고객이 요구하는 제품의 품질을 만족시키기 위해 고객의 요구품질에 대한 정보를 수집 및 분석한다. 설계순서, 방법, 일정, 인원, 목표, 예산 등을 산정하고 계획을 수립한다. 설계의 목표사양과 기능, 성능을 검토하여 만족하는 설계요소품, 기구모듈을 선정하고 선정된 모든 기계요소를 조합하고 배치한다. 구동방식의 결정, 구성요소의 선정, 구성요소의 종합하여 최적의 시스템을 구성한다. 선정된 기계요소품에 관련된 설계변수를 선정한다. 부품별 제원, 성능곡선표, 특성을 고려하여 설계계산에 반영한다. 설계사양 및 구성요소를 확인하고 설계 컴퓨터프로그램을 이용하여 2D도면을 작성한다. 설계사항과 구성요소를 확인하여 공학적 해석을 수행하고 설계에 반영한다. 설계영역에 따라 축설계, 동력전달시스템, 링크장치, 제동 및 완충장치, 구조물, 치구, 측정공구, 공압 및 유압장치를 설계한다. 모델링프로그램을 이용하여 모델링을 하며 설계의 문제점과 개선점을 파악한다. 설계도면에 따라 시제품을 제작하고 깨짐이나 뒤틀림 등 문제점을 파악한다. 도면, 파일, 설계DB 등을 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"산업용기계공학기술자","connectJob":"지그설계기술자, 치공구설계기술자, 구조해석엔지니어(기계), 구조해석엔지니어(산업기계),감속기설계기술자, 기어설계기술자, 식품기계설계기술자, 식품포장기계설계기술자, 세탁장비기계설계기술자, 기구설계기술자","certLic":"기계설계산업기사, 기계기술사, 일반기계기사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007265:1', '{"dJobCd":"K000007265","dJobCdSeq":"1","dJobNm":"석유화학설비관리자","workSum":"생산성 및 설비의 효율성을 높이기 위하여 설비에 대한 종합적 판단을 통해 계획, 진단, 유지, 개선하는 업무를 수행한다.","doWork":"설비의 정비, 인력 동원과 자재 수급을 계획하고 사용 장비와 공구, 예방정비 대상을 선정한다. 사고 예방 보전 이력을 관리하고 진단항목 조사, 진단장비를 준비한다. 설비의 판정기준의 검토 후 설비성능을 판정하고 고장 시 원인을 분석하고 고장 재발방지 대책을 수립한다. 설비를 개선하기 위해 외주업체를 선정·관리를 통해 외주 정비상태 및 품질상태를 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"C201","dJobICdNm":"[C201]기초 화학물질 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004591:1', '{"dJobCd":"K000004591","dJobCdSeq":"1","dJobNm":"선박기술자","workSum":"선박의 구조, 설비, 장치에 대하여 연구·설계·자문하고 선박의 건조, 개발, 유지, 수리를 계획·감독한다.","doWork":"선박 또는 해양시설을 건조·개발·유지보수하기 위하여 국내·국제기준을 수집하고 연구한다. 선박설계의 변화 여부를 결정하고 설계계획안을 검토·분석·자문한다. 선박의 건조과정에서 작업자들을 지휘·감독한다. 부두 및 바다에서 선박시험(속도, 조종성, 연료소비량, 추진기관의 성능, 각종 장비의 작동, 안전성 등에 관한 시험)에 참여하여 각종 장비의 작동을 감독·평가한다. 설계도와 시험자료에 따라 선박의 안정성, 효율성, 경제성에 대한 기준을 제시한다. 선체 각 부분의 시험성적서를 작성하고 수선 여부를 결정한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"조선공학기술자","connectJob":"선박건조기술자, 선박기계장치기술자, 선박전기기술자, 선박연구원, 선박설계기술자, 선박생산관리기술자, 선박품질관리기술자","certLic":"일반기계기사, 공조냉동기계기사, 공조냉동기계기술사, 조선기사, 조선기술사, 해양기술사, 해양공학기사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"C311","dJobICdNm":"[C311]선박 및 보트 건조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001513:1', '{"dJobCd":"K000001513","dJobCdSeq":"1","dJobNm":"선박배관설계기술자","workSum":"선박의 거주구역(Deck House)과 기관실(Engine Room) 구역을 제외한 전구역의 배관설계을 위하여 Building Specifications과 규칙 및 규정(Rule & Regulation)에 준하여 Hull Piping and Cargo Piping Diagram 작성, 상세배치 설계 및 시스템 구성에 필요한 사양작성, 배관재의 제작 및 설치를 위한 생산도 작성한다.","doWork":"계약 시 선주 기술 협의를 통해 작성된 건조 사양서, 일반배치도(G/A, General Arrangement), 기관실 배치도(M/A; Machinery Arrangement), 거주구 배치도(Accommodation Arrangement),  MOM(Minutes Of Meeting, Meeting 메모), MOU 등을 검토한다.  배의 화물을 싣고, 내리고, 저장하고, 운반하는데 필요한 시스템 에 대한 Diagram을 작성하고, 배치도와 생산도 작성을 위한  Valve and Fitting List 및  Piping Practice 등 배관도를 작성한다. 시스템별로 설비되어야 하는 장비의 사양을 검토하여 POS(Purchase Order Specifications) 작성 후 각 해당 장비 Maker와 기술적 사항을 협의, 결정하고 Follow Up하기 위한 주요 구매 사양서 작성 및 선정업무를 한다. 배관 기본도를 토대로 해당 시스템의 기능이 효율적으로 작동되도록, 실제 구역에 맞게 장비, 펌프, 파이프, 밸브, Fitting(Flange, Elbow, Tee, Reducer, etc) 및 Instrument에 대한 배치도를 작성하는 구역배치도를 작성한다. 설계 지침서, 체크리스트, 현장요구사항, 선주/선급 코멘트, A/S Claim 등을 검토하는 등 도면 품질유지 및 향상 업무를 한다. 설치 완료 된 배관시스템에 요구되는 성능을 검증하기 위해 배관시스템 사양, Test 절차, 주의사항 등을 작성하고 Test시 발생 되는 문제점을 처리하기 위해 On-Board Test Procedure을 작성한다.  배치도를 기준으로 Pipe & Support의 제작 및 설치를 위한 도면을 작성하기 위한 구역별 생산도를 작성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"선박설계사","certLic":"조선기사, 조선기술사, 조선산업기사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"C311","dJobICdNm":"[C311]선박 및 보트 건조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003676:1', '{"dJobCd":"K000003676","dJobCdSeq":"1","dJobNm":"선박선형설계기술자","workSum":"선박의 선속(船速) 및 제반 성능을 달성하기 위하여 선형(船型:선박의 겉모양, Hull Form)을 설계한다.","doWork":"기존에 건조된 선박의 선형(船型)자료와 유체해석시스템을 활용하여 선형을 개발한다. 각종 컴퓨터시뮬레이션을 수행한다. 선형을 모델링(Linear Modeling)한다. 속도성능프로그램을 사용하여 속도성능을 계산한다. 마더십(Mother Ship:선박의 원형)을 결정하고 선형설계프로그램을 사용하여 선형을 설계한다. 모형시험을 실시하고 측정값을 기록한다. 선박시운전에 승선하여 속도성능을 확인하고 선박의 성능을 입증한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"선박선형설계사","certLic":"조선기사, 조선기술사, 조선산업기사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"C311","dJobICdNm":"[C311]선박 및 보트 건조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001702:1', '{"dJobCd":"K000001702","dJobCdSeq":"1","dJobNm":"선박설계관리자","workSum":"선박설계도를 작성하기 위하여 분야별(기본설계, 종합설계, 구조설계, 선형설계, 전장설계, 기장설계, 배관설계 등) 선박설계기술자들의 활동을 지휘·감독한다.","doWork":"선주의 요구사항(선박의 종류, 크기, 적재능력, 항로, 선속, 선체구조강도 등)을 만족시키는 최적의 선박설계도를 작성하기 위하여 기본설계(선체구조, 기관실 및 각종 장비의 배치, 배관계통, 전선계통, 갑판장비, 항해장비, 거주시설 등을 설계), 상세설계(기본설계를 토대로 생산에 필요한 원자재의 수량, 기자재의 발주사항 등을 설계), 생산설계(상세설계를 토대로 작업자에게 제공하는 공작도면, 각종 기계의 부착상세도 등을 설계)에 대한 주요정책을 수립한다. 설계부서의 인력, 예산을 효율적으로 배분하여 업무지시를 한다. 설계기술자를 지휘·감독한다. 선주에게 설계도와 계산서, 사양서의 승인을 의뢰한다. 안정성에 관련된 도면은 선급협회에 승인을 의뢰한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","certLic":"조선기사, 조선기술사, 조선산업기사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"C311","dJobICdNm":"[C311]선박 및 보트 건조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003331:1', '{"dJobCd":"K000003331","dJobCdSeq":"1","dJobNm":"선박설계기술자","workSum":"선박건조와 선주(船主:Ship Owner) 및 선급(船級:Cclassification)의 승인을 위하여 선박의 기본도면 및 생산도면을 작성한다.","doWork":"선박설계프로그램을 사용하여 선체구조, 기관실, 각종 장비, 배관계통도, 전기장치계통도, 갑판장비의 배치, 항해장비, 거주설비 등에 대한 선박 기본도면을 작성한다. 완성된 선박 기본도면을 토대로 생산현장에서 이해될 수 있도록 시스템별 도면으로 상세히 표현하는 생산도면을 작성한다. 경사시험(傾斜試驗:Inclining Experiment)을 실시하여 배의 무게중심 및 선각중량(船殼重量:Hull Weight, 선각을 구성하는 부재전체의 중량)을 확정한다. 선박 시운전에 승선하여 각종 성능을 측정하고 입증한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"선박설계사","connectJob":"선각설계기술자, 선박의장설계기술자, 선박기본설계기술자, 선박상세설계기술자, 선박생산설계기술자, 선박배관설계기술자, 조선의장설계기술자, 선체설계기술자, TRIBON선박설계기술자, 조선기장설계기술자, 조선PACKAGEUNIT설계기술자, 선실설계기술자, 선박안전시스템개발자, 족장설계기술자","certLic":"조선기사, 조선기술사, 조선산업기사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"C311","dJobICdNm":"[C311]선박 및 보트 건조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005391:1', '{"dJobCd":"K000005391","dJobCdSeq":"1","dJobNm":"선박환경설비기술자","workSum":"선박에서 발생하는 대기오염원이나 해양오염원(오폐수 등) 등을 저감하거나 제거하는 설비를 연구·개발하고 설치한다.","doWork":"선박에서 발생가능한 환경오염원을 분석하고 그에 적합한 선박용 오폐수처리설비(평형수처리설비 등), 대기오염처리설비(질소산화물·황산화물·이산화탄소처리설비 등) 등을 개발한다. 선박설계기술자와 면담하여 개발된 선박환경설비의 기능, 효과 등에 관해 설명을 하거나 설치에 관한 협의를 진행한다. 설비가 선박에 장착되도록 관리·감독한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"조선기사, 조선기술사, 조선산업기사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"C311","dJobICdNm":"[C311]선박 및 보트 건조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004704:1', '{"dJobCd":"K000004704","dJobCdSeq":"1","dJobNm":"섬유가공설비개발기술자","workSum":"섬유의 제조나 가공에 사용되는 설비, 장비를 설계·개발한다.","doWork":"섬유가공에 사용되는 각종 기계 및 설계에 관한 공학적인 제안을 한다. 가공설비 및 가공공정상의 기술적인 문제점과 각종 자료를 연구·분석한다. 섬유가공과정에서 섬유와 가공제(加工劑)의 관계를 분석하여 설비를 개선·개발한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"합성섬유가공설비개발기술자, 화학섬유가공설비개발기술자","certLic":"섬유기사, 섬유기술사, 의류기사, 의류기술사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"C292","dJobICdNm":"[C292]특수 목적용 기계 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002660:1', '{"dJobCd":"K000002660","dJobCdSeq":"1","dJobNm":"수도계측제어설비기술자","workSum":"각종 수도계측제어설비를 유지·관리하고 정비를 위한 기술지원을 한다.","doWork":"기록·관리하는 계측제어설비(유량계, 수위계, ph계, 탁도계, 알칼리도계, 잔류염소계, 수온계, 지시계, 기록계, 조절계, 전송로, 피뢰계 및 집중감시제어시스템)의 개량, 대체 및 유지·정비를 위한 계획을 수립한다. 수립한 정비계획에 따라 정비를 수행하는 정비원의 작업을 관리 및 감독한다. 정비할 계측제어설비의 설계도를 해석하고 기술평가를 통하여 정비가 이루어질 수 있도록 기술지원을 한다. 수도설비의 원활한 작동이 이루어지도록 감시·제어하는 설비를 운영하고 유지·관리한다. 관할지역의 계측제어설비의 안전진단 및 정기검사를 통하여 안전성과 신뢰성을 확보한다. 계측제어설비의 각종 기자재의 수급관리를 위한 계획을 수립하고 자재를 수급한다. 관할구역의 사업장에서 발생하는 설비의 고장 및 장애요인을 제거하기 위한 기술지원 및 자문을 한다. 감시·보안설비, 통신설비, 방송설비 등에 대한 설비점검과 유지, 관리를 한다. 계측제어설비의 효율성을 확보하고 설비개선을 위하여 기술개발을 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","certLic":"기계정비산업기사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"E360","dJobICdNm":"[E360]수도업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002169:1', '{"dJobCd":"K000002169","dJobCdSeq":"1","dJobNm":"수도기계설비기술자","workSum":"각종 수도기계설비를 유지·관리하고 정비를 위한 기술지원을 한다.","doWork":"각종 수도기계설비의 개량, 대체 및 유지·정비를 위한 계획을 수립한다. 수립한 정비계획에 따라 정비를 수행하는 정비원의 작업을 관리 및 감독한다. 정비할 기계설비의 설계도를 해석하고 기술평가를 통하여 안전하고 신속한 정비가 이루어질 수 있도록 기술지원을 한다. 각 사업장의 펌프, 배관, 밸브, 가압설비, 혼합기, 스크래퍼, 탈수설비 등 기계설비의 안전진단 및 정기검사를 통하여 설비의 안전성과 신뢰성을 확보한다. 기계설비의 각종 기자재의 수급관리를 위한 계획을 수립하고 자재를 수급한다. 관할구역의 사업장에서 발생하는 각종 기계설비의 고장 및 장애요인을 제거하기 위한 기술지원 및 자문을 한다. 각종 기계설비를 운전·조작하는 작업원의 안전확보를 위해 유해요소, 위험설비 점검 및 안전관리를 실시한다. 기계설비의 효율성을 확보하고 설비개선을 위한 기술개발을 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|고온|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","certLic":"기계정비산업기사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"E360","dJobICdNm":"[E360]수도업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004813:1', '{"dJobCd":"K000004813","dJobCdSeq":"1","dJobNm":"수도설비운영관리원","workSum":"상수원의 물을 취수하여 수요자에게 공급하기 위한 취수설비, 가압설비, 정수설비를 유지·관리하고 운영한다.","doWork":"수도시설의 유지보수에 관한 자료를 수집·정리하여 유지·보수에 관한 계획을 수립한다. 정기 및 수시예방점검을 실시하고 조치결과를 기록하고 관리한다. 유지·보수운영관리기준을 제정하고 관리한다. 장단기 시설개량이나 대체계획을 수립하고 조정한다. 유지·보수에 필요한 자재수급계획을 수립하고 재고자재의 보유실태를 확인·점검하여 관리방안을 연구한다. 공사설계도를 작성하여 실행하고 시공과정을 감독한다. 용수시설의 돌발사고 및 단수 시 원인을 분석하고 조치결과를 정리하여 보관한다. 사고원인분석을 위하여 누수사고현황을 정리·분석한다. 사고 시 신속한 조치를 위하여 수도시설 현황설계도를 관리한다. 생활용수 및 공업용수를 생산하기 위한 취수설비, 가압설비 및 정수설비를 운전·조작하는 작업원의 활동을 감독하고 작업원의 직무교육을 실시한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|","workFunc1":"조정","workFunc2":"감독","workFunc3":"유지","connectJob":"취수설비운영관리원, 가압설비운영관리원, 정수설비운영관리원","certLic":"정수시설운영관리사(1급, 2급, 3급)","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"E360","dJobICdNm":"[E360]수도업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007289:1', '{"dJobCd":"K000007289","dJobCdSeq":"1","dJobNm":"스마트공장설비설계사","workSum":"센서, 로봇, 계측기술 등을 활용하여 단위설비의 기본성능과 데이터 연결성을 고려하여 설비를 설계한다.","doWork":"최적의 설비를 설계하기 위해 시스템의 기술규격을 검토하고 설비 간 상호운용성을 분석한다. 스마트설비의 메커니즘 구성, 구성부품과 제어방식을 결정하여 스마트설비 메커니즘을 설계한다. 스마트설비의 기구설계를 모델링하고 설비 구성 단위요소를 설계한다. 설비전원 시스템, 컨트롤 전원, 제어반을 설계한다. 입출력 신호 종류 및 수량을 검토하여 기계장치에 필요한 센서, PLC, 구동장치를 활용하여 자동화된 제어시스템을 설계한다. 하드웨어의 구성, 동작 등을 고려하여 스마트센서 활용을 검토한다. 로봇협업 설계를 검토하여 스마트설비와 로봇의 협업을 설계한다. 감시제어시스템 및 안전설계를 하고 스마트설비의 최적화를 검토한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"정보처리기사, 정보처리산업기사, 생산자동화산업기사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"C","dJobICdNm":"[C]제조업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003323:1', '{"dJobCd":"K000003323","dJobCdSeq":"1","dJobNm":"시계제조기술자","workSum":"시계 신제품 및 부품을 연구·개발하고 품질을 관리한다.","doWork":"손목시계, 전자식시계, 벽시계, 괘종시계, 탁상시계 등의 개발을 위하여 각종 시계관련 국내외 정보를 수집·분석하여 연구한다. 해외시계 박람회 등을 방문하여 국내외 시계시장의 흐름을 파악한다. 무브먼트(Movement), 케이스, 디자인 등을 연구하고 신제품을 개발한다. 부품 생산에 필요한 치공구를 개발한다. 각 부품의 생산 및 조립상황을 감독하고 기술을 지도한다. 생산품을 검사하여 설계와 비교·검토한다. 불량감소 및 품질향상을 위하여 공정을 점검한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"시계제조연구원","connectJob":"시계부품개발자","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"C274","dJobICdNm":"[C274]시계 및 시계부품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005474:1', '{"dJobCd":"K000005474","dJobCdSeq":"1","dJobNm":"신발금형기술자","workSum":"신발디자인에 따라 제품을 가공할 수 있는 금형구조를 분석하고, 재료에 따른 수축률을 이해하여 금형을 설계하고 제작한다.","doWork":"신발디자인에 따라 제품을 가공할 수 있는 금형구조를 분석한다. 형 구조의 특성에 따라 가공방법을 판단한다. CAD·CAM프로그램으로 2D설계와 다양한 기능을 이용해 3D금형을 설계하고 제작한다. 완제품이 최상의 품질이 유지될 수 있도록 갑피와 창의 피팅이 맞는지 확인한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"금형전문가, 몰드전문가, Tooling Engineer","certLic":"금형기능사, 사출금형산업기사, 신발개발기사, 신발기능사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"C152","dJobICdNm":"[C152]신발 및 신발 부분품 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005390:1', '{"dJobCd":"K000005390","dJobCdSeq":"1","dJobNm":"엘이디조명기구설계기술자","workSum":"엘이디(LED) 조명제품기구설계와 시제품평가를 통해 양산제품의 외형을 설계한다.","doWork":"엘이디(LED)조명기구의 개발을 위해 조명기구의 적용대상과 설치환경에 대한 정보를 수집하여 시제품 제조를 위한 도면을 설계한다. 시제품의 제조과정에서 발견되는 제품의 외관, 성능, 생산공정에서의 문제점 등과 시제품의 설치과정에서 발견되는 문제점을 반영하여 양산제품의 도면을 개발·설계한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"LED조명기구설계기술자, LED등기구설계기술자, 엘이디등기구설계기술자","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"C284","dJobICdNm":"[C284]전구 및 조명장치 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001984:1', '{"dJobCd":"K000001984","dJobCdSeq":"1","dJobNm":"엘이디조명기술개발자","workSum":"효율이 높은 LED조명제품의 설계, 개발, 성능분석 등을 담당하고, 생산하기 위한 자동화라인 등의 관련 기술을 연구·개발한다.","doWork":"엘이디(LED)조명에 대한 시장조사를 통하여 경제성을 분석하고 기술동향을 파악하여 개발계획을 수립하고, 세부 기술과제를 검토하여 기술개발이 필요한 기술을 선정한다. 조명기구 생산을 위한 설계기술과 양산기술 및 발열, 전기관리 등 관련기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"LED조명기술개발자, LED조명개발자, LED조명기술자","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"C284","dJobICdNm":"[C284]전구 및 조명장치 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003249:1', '{"dJobCd":"K000003249","dJobCdSeq":"1","dJobNm":"여과기제조기술자","workSum":"여과기를 개발·설계하고 품질을 관리한다.","doWork":"신제품 개발 및 제조기술 향상을 위해 국내외 기술정보를 수집·검토한다. 압력여과기, 중력여과기, 엽상여과기, 연속여과기, 원심여과기, 특수여과기 등 다양한 여과기를 개발한다. 각종 필터의 기능, 수명 및 재생과 관련된 실험을 한다. 제품별 처리량, 고체입자의 농도와 크기, 여액의 물성, 여과의 조건, 여과되고 남은 찌꺼기의 성질, 함액률 등을 시험한다. 개발된 제품의 생산공정을 설계한다. 완성된 제품을 검사하여 품질을 평가한다. 품질 관련 기준(한국공업규격 등)에 따라 안전성 및 적합성 여부를 검사한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"대기환경미흡|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"일반기계기사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"C291","dJobICdNm":"[C291]일반 목적용 기계 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006059:1', '{"dJobCd":"K000006059","dJobCdSeq":"1","dJobNm":"열배관관리기술자","workSum":"냉·난방 공급에 필요한 열수송배관시설의 설치공사계획 및 인허가업무를 수행한다.","doWork":"지역사회에 필요한 냉·난방 공급을 위해 원격검침장치 및 누수탐지시스템과 같은 열수송배관시설의 공사계획을 수립한다. 공사도서를 작성하고 관리한다. 설치공사를 감독하고 시공기술을 지원한다. 설치된 시설을 검사하고 인허가 관련 서류를 작성하여 제출한다. 주기적으로 시설을 점검하고 유지·보수계획을 수립한다. 보수장비 운용 및 안전관리계획을 수립한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"위험내재|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","certLic":"배관산업기사, 배관기사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"D353","dJobICdNm":"[D353]증기, 냉·온수 및 공기조절 공급업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003957:1', '{"dJobCd":"K000003957","dJobCdSeq":"1","dJobNm":"열유체시스템연구원","workSum":"에너지플랜트설계 및 공정기술, 산업용열유체시스템 고효율화기술, 열교환기 등 열유체시스템을 연구·개발한다.","doWork":"열유체시스템을 기반으로 가스플랜트, 담수화플랜트 등 에너지플랜트의 원천기술을 연구한다. 에너지플랜트설계 및 공정기술, 산업용열유체시스템 고효율화기술, 열교환기 등 열유체부품기술을 개발한다. 열교환기, 에너지회수장치, 마이크로열유체장치 등 핵심기기의 개발 및 성능향상을 위한 연구를 한다. 고압에너지회수형 해수담수화장치, 가스액화용마이크로 열교환기 및 열교환기접합장비, 히트펌프시스템 등을 개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"기계기술사, 일반기계기사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002905:1', '{"dJobCd":"K000002905","dJobCdSeq":"1","dJobNm":"염색설비개발기술자","workSum":"염색에 사용되는 장비, 설비 등을 설계·개발한다.","doWork":"염색설비의 기술적인 자료를 연구·분석한다. 염색공정에서 섬유와 염료의 관계를 분석하여 설비를 개선하고 개발한다. 장치 및 장비를 설계하고 검사한다. 장치의 운용, 유지, 보수작업을 계획한다. 기계 및 염색에 관한 공학적인 제안을 하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"섬유산업기사, 섬유기사, 섬유기술사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"C134","dJobICdNm":"[C134]섬유제품 염색, 정리 및 마무리 가공업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005687:1', '{"dJobCd":"K000005687","dJobCdSeq":"1","dJobNm":"온실가스저감장치기술자","workSum":"온실가스가 대기 중에 직접 방출되지 않도록 온실가스를 처리하고 저감하는 저감장치를 연구·개발한다.","doWork":"화학적 반응을 통해 온실가스를 분해·제거하는 화학적 처리방식과 필터, 여과장치 등을 통해 온실가스를 걸러내는 물리적 처리방식을 연구한다. 운송장비, 생산설비, 연소설비 등에서 배출되는 주요 온실가스를 조사·분석한다. 온실가스의 특성에 따른 화학적·물리적 처리방법의 적용가능성 및 타당성을 검토하여 적합한 처리방식을 적용한다. 온실가스저감장치 설치대상의 구조, 특성 등을 반영하여 처리장치를 설계한다. 설계에 따라 장치 및 설비가 제작되고 설치될 수 있도록 관리·감독한다. 설치 전후의 온실가스 배출량을 조사·분석하여 온실가스저감장치의 성능·효과를 평가한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"기계기술사, 기계설계산업기사, 일반기계기사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004018:1', '{"dJobCd":"K000004018","dJobCdSeq":"1","dJobNm":"온실가스측정기개발자","workSum":"대기 중의 온실가스농도를 측정하는 온실가스측정기를 연구·개발한다.","doWork":"연소가스나 대기 등에 포함된 온실가스의 농도를 측정하기 위해 온실가스의 물리화학적 특성을 파악한다. 온실가스에 특성에 따라 비분산 적외선 가스분석식 열전도식, 크로마토그래프식, 습식분석식, 자외선흡광식, 전기화학식 등의 검출방식을 적용한 온실가스 검사장비를 연구·개발한다. 포집된 공기의 정확한 분석을 위해 표준가스와의 비교방식을 연구한다. 시료표집기나 튜브, 센서 등이 시료에 오염되어도 정확도를 유지하는 기술을 연구·개발한다. 사용용도에 따라 휴대형, 연속형, 고정식 온실가스검사장비를 개발한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"온실가스분석기개발자","certLic":"기계기술사, 기계설계산업기사, 일반기계기사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003210:1', '{"dJobCd":"K000003210","dJobCdSeq":"1","dJobNm":"온실가스포집설비기술자","workSum":"온실가스를 포집·저장·운송하는 설비를 기획하고 설계·개발한다.","doWork":"온실가스를 포집하고 저장·운송하는 처리설비에 대한 경제성, 효율성을 평가·검토한다. 설비제작이 결정되면 온실가스처리기술을 적용할 설비를 설계한다. 화석연료의 연소 전·후에 발생하는 온실가스를 포집하는 설비를 설계도면에 따라 제작·설치될 수 있도록 관리·감독한다. 설치 전후의 온실가스 포집결과를 조사·분석하여 온실가스처리설비의 성능, 효과성, 안정성 등을 평가한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"기계기술사, 기계설계산업기사, 일반기계기사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003546:1', '{"dJobCd":"K000003546","dJobCdSeq":"1","dJobNm":"용접공학기술자","workSum":"용접기술에 대한 전문지식과 실무경험을 바탕으로 용접에 대한 계획, 연구, 설계, 시험, 장비운영, 시공, 평가 또는 이에 관한 지도, 감리 등의 기술업무를 수행한다.","doWork":"일반산업, 화공시설, 발전소, 각종 플랜트, 강선건조 등에 관련된 용접기준을 파악하고 용접공정을 기획한다. 용접대상물의 기계, 설비, 기능, 성능, 환경 등을 고려하여 적합한 용접방법을 선정한다. 시공방법, 규격 등의 내용을 담은 용접설계도서를 작성한다. 용접부의 강도를 계산하여 설계에 반영한다. 용접현장 안전관리 및 용접기술을 지원한다. 시공물의 용접부를 검사하고 설계도서와 비교하여 평가한다. 다양한 용접기기의 정밀도를 보정하고 용접재료를 선정·검사한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"선박생산기술자(용접)","certLic":"용접산업기사, 용접기사, 용접기술사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001466:1', '{"dJobCd":"K000001466","dJobCdSeq":"1","dJobNm":"원전설비연구원","workSum":"원자력발전설비를 안전하고 효율적으로 운영, 관리를 위하여 설비의 진단, 운전 및 정비에 관한 기술을 개발하고 현장업무를 지원한다.","doWork":"원자력발전설비의 안전성 및 효율성을 분석·평가한다. 가동 중 검사, 비파괴검사 등을 한다. 터빈-발전기 및 주요 회전기기, 습분분리재열기(Moisture Separator Reheat Exchanger) 및 열교환기에 대한 현장기술지원업무를 수행한다. 원자력발전소의 설비진단, 효율관리에 대한 검사를 통하여 나타난 설비의 문제점을 해결하기 위해 기술을 지원한다. 원자력발전설비의 수명관리, 터빈-발전기 엔지니어링, 운전 및 정비를 위한 기술개발, 주요 회전기기 진동진단 및 분석기술에 대한 현장지원을 한다. 원자력발전설비의 각종 기기 및 구조물에서 발생하는 소음, 진동에 대한 분석을 통해 설비이상을 점검하고, 발생할 문제를 검토하며 해결방안을 제시한다. 기타 원자력발전설비에 대한 각종 기술지원을 위한 각종 연구·개발업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","certLic":"원자력발전기술사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006942:1', '{"dJobCd":"K000006942","dJobCdSeq":"1","dJobNm":"자기부상열차연구원","workSum":"도시형자기부상열차를 시험 및 분석해 실용화를 추진하고, 초고속자기부상열차의 부상 및 추진기술 등을 연구·개발한다.","doWork":"자기부상, 선형추진 및 기계기술의 융합을 바탕으로 자기부상열차, 친환경수송시스템의 핵심기술을 연구한다. 소음, 진동, 충격, 회전 등 동특성 설계·해석 및 제어기술을 연구한다. 자기부상기술, 선형추진기술, 주행성능평가기술을 개발한다. 시스템 엔지니어링, 분기기의 개발 등 도시형·초고속자기부상열차의 부상 및 추진기술을 연구한다. 도시형자기부상열차 실용화사업시스템 통합기술을 개발해 도시형자기부상열차의 실용화사업을 추진한다. 자기부상식이송시스템 개발, 자기부상 및 선형추진기술을 이용한 미래수송시스템을 연구한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"기계기술사, 일반기계기사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"C312","dJobICdNm":"[C312]철도장비 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004541:1', '{"dJobCd":"K000004541","dJobCdSeq":"1","dJobNm":"자동차기술자(일반)","workSum":"각종 차량의 차체, 엔진, 제동장치, 차대 및 기타 구성품에 관하여 연구 및 설계하며 개발 및 제조를 계획·감독한다.","doWork":"새로운 자동차를 개발하기 위하여 관련 자료를 검토·분석한다. 각종 부품 및 전체 디자인을 설계한다. 부품의 형상과 재료 및 배치를 결정한다. 엔진, 변속기 등 주요 부품을 시험·평가하여 개선점을 설계에 반영한다. 자동차의 전체적인 성능을 시험·평가하고 개선점을 설계에 반영한다. 시뮬레이션을 통하여 시험·설계비용을 절감한다. 차량의 제조공정이 공학기술상의 설계와 일치하는지 확인한다. 특수한 기능적, 조작적 성능을 구현하기 위해 설계를 수정한다. 구성부품제조 및 차량제조공정의 품질을 관리하고 기술을 지원한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"자동차연구원, 자동차충돌시험연구원, 카일렉트로닉스기술자, 자동차진단시스템엔지니어, 구조해석엔지니어, 하이브리드자동차연구원, 친환경자동차연구원, 전기자동차기술자","certLic":"차량기술사, 일반기계기사, 자동차정비기사, 자동차정비산업기사, 기계설계산업기사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"C301","dJobICdNm":"[C301]자동차용 엔진 및 자동차 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006193:1', '{"dJobCd":"K000006193","dJobCdSeq":"1","dJobNm":"자동차설계기술자","workSum":"자동차를 제조하기 위하여 자동차의 설계, 공학원리, 제조과정 등의 지식을 적용하여 기본 및 생산도면을 설계한다.","doWork":"설계할 자동차의 유형에 따른 구조적 특징, 설비품 등을 검토하고 관련 자료를 분석한다. 안전성, 성능 및 경제성 등을 고려하여 기본 및 생산도면을 설계한다. 차량부품성능의 적합성을 시험을 한다. 차량구조물에 대한 구조해석, 피로해석, 충돌해석을 한다. 완성된 차량구조물에 대하여 성능확인시험 및 내구력시험을 수행하고 설계에 반영한다. 차량에서 발생하는 소음 및 진동을 제어하기 위해 실내·외 소음해석 및 차체음향특성 측정 및 예측, 진동해석 및 시험을 한다. 해석 및 시험을 통하여 설계개선안을 도출하여 설계에 반영한다. 해석 및 시험장비를 관리하고 점검한다. 차량전체의 기본 레이아웃계획, 각 유니트계획, 시작설계, 양산설계, 생산 후 개선사양 변경설계를 기본으로 하는 기본계획에 따라 시장성, 진보성, 개발품, 초도품, 양산품의 기준에 적합한 제품의 개념을 수립한다. 가격경쟁력, 재료의 선택, 가공방법, 재질의 특성 등 타당성 분석을 한다. 품질사양, 성능사양, 규격 관련, 등급 관련 등 일반사양 및 특수사양을 확정한다. 외관의 형태, 경제성 분석, 단품의 적합성, 강도검토, 구조해석 등 제품의 신뢰성 확보를 위한 구상을 한다. 설계제도작업을 실시한다. 원재료 및 부자재리스트(Bill of Material)를 작성하고 재료비, 가공비, 전처리, 후처리, 노무비 등 자동차생산 집행예산을 산출하고 확정한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"자동차설계사","certLic":"일반기계기사, 차량기술사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"C301","dJobICdNm":"[C301]자동차용 엔진 및 자동차 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005523:1', '{"dJobCd":"K000005523","dJobCdSeq":"1","dJobNm":"자동차시험검사연구원","workSum":"신규자동차의 형식승인을 위하여 등화장치, 운전자의 시계(視界), 난연성 등을 시험한다.","doWork":"각종 등화장치의 광도, 조도, 조사거리, 조사특성, 색상을 종합적으로 시험하는 광학시험을 수행한다. 운전자의 전방시계, 후방시계범위를 측정하는 운전자시계범위시험을 수행한다. 차량화재발생 시 실내 연소성물질의 화염전파속도를 규제하기 위한 난연성시험을 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"차량기술사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"M729","dJobICdNm":"[M729]기타 과학기술 서비스업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004477:1', '{"dJobCd":"K000004477","dJobCdSeq":"1","dJobNm":"자동차안전시험연구원","workSum":"자동차 충돌사고에 대한 자동차의 안전성능을 평가하기 위하여 정면충돌, 부분정면충돌, 측면충돌, 기동측면충돌시험 및 좌석안정성시험을 수행하고 등급을 평가한다.","doWork":"차량의 각 부위에 표시장치를 하고 일정속도로 벽면에 충돌시켜 파손부위, 인체모형(Dummy)의 충돌상황, 충격량 등을 시험한다. 모의충돌 시험장비를 이용하여 충돌상태를 반복적으로 시험한다. 인체모형(Dummy)의 파손상태 및 충격량을 확인하여 에어백, 핸들의 부착위치 등 안전장치를 점검하고 피해를 최소화할 수 있는 방법을 연구한다. 천장강도 및 옆문강도(Side Impact), 범퍼, 시트강도, 안전띠강도 등을 시험하는 충격시험을 수행한다. 시험장비를 개발하고 각종 감지(Sensing)장비의 교정검사를 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"차량기술사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"M729","dJobICdNm":"[M729]기타 과학기술 서비스업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003191:1', '{"dJobCd":"K000003191","dJobCdSeq":"1","dJobNm":"자동차엔진기술자","workSum":"연료효율이 높고 배기가스를 줄일 수 있는 자동차엔진을 연구·개발한다.","doWork":"엔진의 성능을 연구하고 구조, 구동, 의장, 배관, 제어 등을 설계한다. 경량재질의 부품을 개발하여 엔진의 무게를 줄이고 동력전달부품의 동력손실을 최소화하기 위한 구조설계를 한다. 새로운 코팅소재의 적용, 효율적인 내부연소를 위해 점화타이밍과 레이저 등을 이용한 점화방식의 개선 등의 성능향상에 대해 연구한다. 에너지의 효율적인 사용을 위해 엔진에서 발생하는 열에너지를 활용할 수 있도록 열전도재질을 사용한 엔진이나 예혼합압축착화(HCCI:Homogeneous Charge Compression Ignition)엔진과 같은 새로운 연소방식을 연구한다. GDI(Gasoline Direct Injection), 커먼레일엔진(Common Rail Direct Injectionengine) 등의 직분사엔진, 엔진과 전기모터를 결합한 하이브리드(Hybrid)엔진 등의 가솔린, 디젤, 가스 등의 다양한 연료를 이용한 고효율·고성능엔진을 개발한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"자동차엔진설계기술자","connectJob":"고효율엔진기술자","certLic":"차량기술사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"C301","dJobICdNm":"[C301]자동차용 엔진 및 자동차 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005850:1', '{"dJobCd":"K000005850","dJobCdSeq":"1","dJobNm":"자동차주행시험연구원","workSum":"고속주회로, 직선로, 범용시험로, 원형저마찰로, 전파장해시험로 등의 각종 주행시험장에서 차량종합 주행시험을 한다.","doWork":"최고속도 및 내구성을 측정하는 고속주회로 주행시험을 수행한다. 소음, 제동, 연비 등을 시험하기 위한 직선로 주행시험을 한다. 제동, 연비, 조정안정성을 측정하기위한 범용시험로 주행시험을 한다. 미끄럼 방지장치(ABS:Anti-locked Brake System)의 성능, 노면수막 및 결빙상태에서 주행성능을 시험하기 위한 원형저마찰로 주행시험을 한다. 차량에서 나오는 전자파 방사시험을 위해 전파장해시험로 주행시험을 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"C301","dJobICdNm":"[C301]자동차용 엔진 및 자동차 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003696:1', '{"dJobCd":"K000003696","dJobCdSeq":"1","dJobNm":"자동차휠개발자","workSum":"자동차휠을 제조하기 위하여 디자인을 결정하고 생산공정을 개발한다.","doWork":"디자인 콘셉트를 개발하고 검토한다. 2D설계 및 3D모델링을 의뢰하고 검토한다. 제품의 내구성, 주조성을 시뮬레이션으로 검토한다. 제품디자인이 승인되면 모형을 제작하고 제품설계도 및 금형을 설계하고 제작한다. 초도제품을 생산하고 내구성시험, 내식성시험 등 각종 시험을 실시한다. 제품의 생산이 결정되면 생산공정을 개발한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"C303","dJobICdNm":"[C303]자동차 신품 부품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003599:1', '{"dJobCd":"K000003599","dJobCdSeq":"1","dJobNm":"자동화설비기술자","workSum":"자동화설비의 개발을 위해 연구하고 설계하며 계획에 따라 개발한다.","doWork":"각종 자료수집 및 공정분석을 거쳐 자동화설비개발 및 운용에 대한 계획을 수립한다. 자동화설비의 메커니즘(기계류), 구성요소, 설계, 운영 및 성능에 관해 연구한다. 유·공압제어기술, 논리제어기(PLC), 마이크로프로세서 등 기계 및 전기·전자기술을 적용하여 각종 전기, 전자, 기계장치를 자동화하는 설비를 설계한다. 설계를 토대로 제품을 개발하고 시험한다. 관련 부서의 기술자들과 연구, 개발에 관하여 협의한다. 공장의 생산설비를 자동화하기 위하여 최신제조기술, 자동화기술 등에 대하여 자문하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"메카트로닉스기술자, 자동화설비기계설계기술자","certLic":"기계기술사, 일반기계기사, 생산자동화산업기사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005943:1', '{"dJobCd":"K000005943","dJobCdSeq":"1","dJobNm":"자동화설비연구원","workSum":"제어하는 목적에 따라 전기·전자·기계장치 등이 자동으로 조절되는 설비를 연구하고 개발한다.","doWork":"각종 자료수집 및 실사를 거쳐 자동화설비개발 및 운용에 대한 계획을 수립한다. 생산공정, 하드웨어, 구동부(Actuator), 센서, 소프트웨어 등 자동화설비의 구성요소를 고려하여 제품을 설계한다. 제대로 작동되지 않는 설비의 문제점을 해결하고 납품된 설비에 대해 정기적인 점검을 실시하기도 한다. 관련 부서의 기술자들과 연구, 개발, 설계에 관하여 협의한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"공장자동화연구원, 사무자동화연구원, 홈오토메이션연구원","certLic":"기계기술사, 일반기계기사, 생산자동화산업기사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"C272","dJobICdNm":"[C272]측정, 시험, 항해, 제어 및 기타 정밀기기 제조업; 광학기기 제외","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003090:1', '{"dJobCd":"K000003090","dJobCdSeq":"1","dJobNm":"자전거설계기술자","workSum":"자전거의 기본설계 및 생산설계를 하고 도면을 그린다.","doWork":"자전거의 시장성, 진보성, 상품성, 경제성, 실용성, 시제품, 양산품의 기준에 적합한 제품의 개념을 수립한다. 기본 레이아웃, 부분품계획, 시작설계 및 양산설계, 개선사양변경설계 등을 고려하여 설계계획을 수립한다. 자전거의 유형에 따른 구조적 특징, 프레임, 포크, 림, 변속기, 핸들, 브레이크, 타이어 등 관련 기술을 분석한다. 안전성, 성능 및 경제성 등을 고려하여 기본 및 생산도면을 그린다. 부품의 적합성, 시제품의 성능, 내구성을 시험하고 개선안을 도출하여 설계에 반영한다. 가격경쟁력, 재료의 선택, 가공방법, 재질의 특성 등을 고려하여 생산성을 분석한다. 품질사양, 성능사양, 관련 규격 등을 확정한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"전기자전거설계기술자","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"C301","dJobICdNm":"[C301]자동차용 엔진 및 자동차 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004304:1', '{"dJobCd":"K000004304","dJobCdSeq":"1","dJobNm":"재활기구설계연구원","workSum":"휠체어, 대퇴의적 등 재활기구나 장비를 설계·제작·시험한다.","doWork":"기구사용 장애자의 신체적 특성 등을 고려하여 재활기구나 장비를 개발하기 위한 계획을 수립한다. 관절각도, 무게 등 다양한 요인을 적용하여 시뮬레이션한다. CAD를 이용하여 기구를 설계한다. 인장강도, 스트레스, 충돌상의 문제점, 소음 등을 측정하고 검사한다. 시험 및 측정을 위한 치공구를 설계한다. 시험 및 충돌장치 등을 계획하고 조립한다. 환자가 사용한 후 발생하는 문제점을 확인하여 보완한다. 보행기기 및 이동기기 등 재활보조기구의 성능과 내구성 및 안전성 확보를 위한 규격화 및 시험방법 제정에 대해 연구하기도 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"의지보조기기사, 기계설계산업기사, 일반기계기사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"C271","dJobICdNm":"[C271]의료용 기기 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006503:1', '{"dJobCd":"K000006503","dJobCdSeq":"1","dJobNm":"전기자동차설계기술자","workSum":"개발제품의 요구사양을 분석하고, 2D, 3D기반의 CAD시스템과 ISO, DIN 등 국제기준에 맞추어 모델링과 분석을 통해 전장설계와 차체설계를 수행한다.","doWork":"저속에서 높은 토크와 일정 동력전달, 연속적이고 부드러운 운행 및 제어, 높은 효율과 회생제동, 낮은 소음과 경량화 등 전기자동차 목표기능을 설정한다. 목표기능을 달성하기 위한 차량성능 및 역학모델, 구동모터 파라미터, 차량성능 파라미터, 제어 및 하드웨어, 모터추진시스템의 최적화를 고안한다. 주행사이클에 대한 평균전력, 과부하 횟수 및 환경, 에너지소스에 따른 최대전력, 평균 및 최소전압과 기어박스·감속기에 대한 정보를 설계에 반영한다. 전기자동차 관련 국제기준을 검토하고 설계와 비교·평가한다. 시뮬레이션을 통해 설계를 분석하고 수정한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"그린전동자동차기사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"C301","dJobICdNm":"[C301]자동차용 엔진 및 자동차 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005528:1', '{"dJobCd":"K000005528","dJobCdSeq":"1","dJobNm":"전동휠체어기술자","workSum":"정보와 자료를 수집하여 분석하고 종합하여 전동휠체어를 연구·개발하며 설계한다.","doWork":"새로운 종류의 전동휠체어장비, 기존 전동휠체어의 변경된 기능, 또는 양산되고 있는 전동휠체어제품을 연구하기 위하여 각종 첨단기술정보를 수집하고 검토한다. 전동휠체어설계에 필요한 기술연구, 안전테스트, 실험 등의 업무를 수행한다. 각종 전동휠체어장비의 기능, 수명과 관련한 개발계획에 대한 연구보고서를 작성한다. 설계모형제작을 위한 금형을 주문하고 그에 따른 모형을 제작한다. 캐드(CAD)를 이용한 본 설계도면을 해석한다. 제작된 전동휠체어의 개발제품에 대한 부품의 성능이나 치수, 생산성 등을 검증한다. 설계도면으로 인한 제품의 하자부분은 재검토하여 수정한다. 최종검사, 합격한 제품에 대한 양산도면을 해석한다. 생산공정에 기술적인 자문과 조언을 하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"종합","workFunc2":"감독","workFunc3":"정밀작업","connectJob":"휠체어설계원","certLic":"기계기술사, 기계설계산업기사, 일반기계기사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"C319","dJobICdNm":"[C319]그 외 기타 운송장비 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007266:1', '{"dJobCd":"K000007266","dJobCdSeq":"1","dJobNm":"정밀화학설비보전관리자","workSum":"정밀화학 제품설비의 기능을 가장 효과적으로 활용하기 위해 설비에 대한 종합적인 판단을 하고 설비에 대한 계획, 유지, 개선을 수행한다.","doWork":"설비보전계획을 세우고 설비의 중요도를 평가한다. 설비의 최적 보전 주기를 설정하고 정기점검 일정을 계획하여 점검자에게 정기점검을 지시하고 관리한다. 설비 점검에서 이상 징후 발생 시 원인을 파악하고이상 징후를 제거한다. 이상 징후가 발견된 설비의 개선안을 도출하고 도출된 개선안을 실행한다. 설비 예지 보전대상을 선정하고 특정 값을 측정하여 특정 값 분석 및 설비 이상을 예지한다. 설비의 신뢰성 향상을 위한 설비유지관리 목표와 대책을 수립한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"수동조작","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"C203/C204","dJobICdNm":"[C203]비료, 농약 및 살균, 살충제 제조업 / [C204]기타 화학제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003986:1', '{"dJobCd":"K000003986","dJobCdSeq":"1","dJobNm":"지능형운송시스템개발자","workSum":"주택용, 주차장용, 충전소용 충전설비, 배터리교환소 등 전기자동차의 충전인프라와 시스템을 개발한다.","doWork":"주택용 충전설비(단독주택의 차고에서 가정용 전원 또는 전기자동차 충전전용 전원으로 충전하는 시스템)를 개발한다. 주차장용 충전설비(교류전원을 전기자동차에 공급하면 차량 내의 변환기에서 직류로 변환해 배터리에 전원을 공급하는 시스템)의 전류공급 안전장치, 인증, 통신, 요금부과 등을 위한 장치 등을 개발한다. 충전소용 급속충전설비(짧은 시간에 많은 전력을 차량에 공급하기 위한 급속충전설비로서 외부에서 교류를 직류로 변환해 차량의 배터리에 직류를 직접 공급)의 배터리, 차량과 충전설비 간의 통신방법을 연구·개발한다. 배터리교환소(소비자는 배터리를 제외한 가격으로 전기자동차를 구매, 사업자는 소비자에게 배터리 충전 또는 교환, 차량운전자는 주행거리에 따라 요금을 지불하는 시스템)의 충전인프라와 시스템을 개발한다. 실시간요금정보, 전력공급정보 및 서비스정보 등을 제공하고 제어하는 중앙관리시스템(Central Management Server System)과 통신망연결방법을 개발한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"그린전동자동차기사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002601:1', '{"dJobCd":"K000002601","dJobCdSeq":"1","dJobNm":"지열시스템설계기술자","workSum":"대상건물의 냉난방 부하량에 맞게 히트펌프, 지중열교환기의 용량을 선정하는 등 지열시스템을 설계한다.","doWork":"대상건물의 냉난방 부하를 계산하기 위하여 건축물을 분석하고 냉난방 부하프로그램에 입력값을 넣어 시뮬레이션을 통해 부하량을 산정한다. 냉난방 부하량, 대상건물의 크기와 구조, 초기비용 등을 감안하여 수직형, 수평형, 폐쇄루프형, 개방루프형 등 지열시스템의 종류를 선정한다. 지중해석프로그램을 이용한 시뮬레이션을 통해 지중열교환기 설치부의 지반을 조사하고 시추공 영상촬영장치의 결과를 비교분석하여 히트펌프와 지중열교환기의 용량을 선정한다. 설계가 끝나면 시공부서에 넘겨 지열시스템을 설계도면에 맞게 시공하도록 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"기계기술자, 기계설계산업기사, 일반기계기사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003762:1', '{"dJobCd":"K000003762","dJobCdSeq":"1","dJobNm":"철도차량설계기술자","workSum":"철도차량을 제조하기 위하여 철도차량의 구조, 배관, 의장, 대차, 전장 등의 기본도면 및 생산도면을 설계한다.","doWork":"철도차량을 제조하기 위하여 설계기본계획(설계의 기초가 되는 기준:매개변수, 기초자료 및 정보, 규제법령, 규격, 표준 및 과업지시서)을 수립한다. 철도차량 입찰 시 설계기준서 작성계획(설계기본요건, 성능요건, 규제요건, 규격 및 표준요건, 공단요건, 표준기술문서, 설계개선사항, 환경친화적인 설계사항, 인허가 관련 사항, 교통영향평가보고서, 환경영향평가보고서 등 환경조건을 반영)을 수립하여 제출한다. 설계 계획수립에 필요한 정보를 수집하기 위하여 철도공단에 회의를 요청하거나 과거의 설계성과물에서 파악된 설계개선사항을 요청한다. 수주된 차량을 생산하기 위하여 사양을 검토하고 기본설계 및 필요부품목록을 작성한다. 이를 토대로 제작도, 부품사양서, 시험·검사기준서를 작성한다. 성능보증자료 및 계산서를 작성하여 수요처와 기술협의를 하고 때에 따라 교육을 시키기도 한다. 생산원가를 절감하기 위해 생산성 향상에 관련된 연구개발에 참여하고, 설계예산 수립 및 공정계획을 수립한다. 기술도입 관련 기술적 사항이나 기술도입 타당성 및 시장성을 분석하여 보고한다. 설계 및 시험에 필요한 장비 등을 점검하고 유지 관리한다. 시제품제작 시 현장지원을 하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","certLic":"철도차량기술사, 철도차량기사, 철도차량산업기사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"C312","dJobICdNm":"[C312]철도장비 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005604:1', '{"dJobCd":"K000005604","dJobCdSeq":"1","dJobNm":"컴퓨터기반공학기술자","workSum":"소프트웨어 해석결과를 기반으로 제품의 문제점을 분석하고 개선안을 도출, 제품개발효율을 높이는 데 역할을 한다.","doWork":"CAD를 활용한 간략화된 3D모델의 가하모델을 구성한다. 유한요소법 이론 등 해석기본이론에 기초하여 해석모델을 생성한다. 해석모델에 대한 재료특성(물성치)를 입력하고, 요소 및 요소망을 생성한다. 주어진 문제특성에 맞게 하중경계조건을 부여하고, 하중조건을 부가한다. 문제에 적합한 소프트웨어 해석툴을 활용하여 CAE 해석을 수행한다,","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"손사용|언어력|시각|","workFunc1":"분석","workFunc2":"자문","workFunc3":"제어조작","similarNm":"CAE엔지니어, 수치해석엔지니어","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005825:1', '{"dJobCd":"K000005825","dJobCdSeq":"1","dJobNm":"케이블카기술자","workSum":"케이블카(리프트, 곤돌라 포함)를 제작하기 위하여 국내외의 정보와 자료를 수집하여 연구·분석·종합하고 실험을 실시한다.","doWork":"케이블카(리프트, 곤돌라 포함)를 제작하기 위하여 국내외의 정보와 자료를 수집·분석·연구·종합한다. 도면을 바탕으로 모형을 제작하며 안전시험을 한다. 궤도안전법(케이블카, 리프트카 등 궤도운송법에 따른 안전법)에 따라 케이블카의 반기(Cabin:승객이 탑승하는 차), 지주(Tower:산록정차장과 산정정차장 사이의 기둥), 케이블카구동부, 지삭(Rope), 예삭(케이블카를 이동시키는 줄)등의 구성시스템을 연구한다. 케이블카시스템의 기본 설계도면을 해석한다. 모의시험을 통하여 시험운전 시 시승하여 케이블카의 안정성을 입증한다. 케이블카의 제작·설치공정에 기술적인 자문과 조언을 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"감독","workFunc3":"정밀작업","certLic":"기계기술사, 승강기기사, 일반기계기사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"C319","dJobICdNm":"[C319]그 외 기타 운송장비 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005273:1', '{"dJobCd":"K000005273","dJobCdSeq":"1","dJobNm":"폐기물고형연료제조설비설계기술자","workSum":"생활쓰레기, 폐타이어 등 폐기물에서 가연성물질을 추출하여 고형연료를 만드는 제조설비를 설계한다.","doWork":"생활쓰레기에서 금속, 유리 등 비가연성 폐기물을 선별하기 위하여 진동스크린, 풍력선별기, 광학선별기 등 선별기의 종류와 사양을 결정한다. 선별된 폐기물에서 회분, 염소, 황, 금속성분의 함량이 규정치를 넘지 않도록 여러 가지 복합적인 선별공정을 설계한다. 선별된 쓰레기가 분쇄되고 건조된 후 성형되는 공정을 설계한다. 성형 및 비성형 고형연료의 최대 수분함수량의 차이에 따라 건조기의 사양을 결정한다. 각 공정별로 결정된 설비, 기계, 구조물, 부품등의 설계도면을 작성한다. 설비제작원 및 설비구축업체와 협의하여 설계를 수정·보완한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"생활쓰레기고형연료제조설비설계기술자","certLic":"기계기술사, 기계설계산업기사, 폐기물처리기술사, 페기물처리기사, 일반기계기사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"C292","dJobICdNm":"[C292]특수 목적용 기계 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005787:1', '{"dJobCd":"K000005787","dJobCdSeq":"1","dJobNm":"폐기물자원화설비설계기술자","workSum":"각종 폐기물의 성분 및 특성에 따라 파쇄, 건조, 탄화, 성형공정을 수립하고 이와 관련된 기계, 구조물, 부품 등의 설계도면을 작성한다.","doWork":"폐기물 성분 및 특성에 따른 미립화율, 건조온도, 건조시간, 탄화도에 따라 설비의 사양을 결정한다. 결정된 사양의 설비를 기반으로 슬러지의 반입, 저장, 파쇄, 건조, 탄화, 성형에 이르는 공정을 설계한다. 연료화과정에서 부산물로 발생하는 악취를 제거하는 악취처리시스템 및 폐열회수시스템 공정을 설계한다. 각 공정별로 결정된 설비, 기계, 구조물, 부품 등의 설계도면을 작성한다. 모델링을 통해 안정성 및 설계사항을 검토한다. 설비제작원 및 설비구축업체와 협의하여 설계를 수정·보완한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"음식쓰레기자원화설비설계기술자, 하수슬러지자원화설비설계기술자, 바이오매스자원화설비설계기술자, 사업장폐기물자원화설비설계기술자","certLic":"기계기술사, 기계설계산업기사, 폐기물처리기술사, 페기물처리기사, 일반기계기사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"C292","dJobICdNm":"[C292]특수 목적용 기계 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004487:1', '{"dJobCd":"K000004487","dJobCdSeq":"1","dJobNm":"풍력발전기기계설계기술자","workSum":"풍력발전기의 회전날개(Blade), 허브시스템(Hub System), 회전축(Shaft), 증속기(Gear Box) 등 기계부분을 설계한다.","doWork":"같은 풍력 속에서도 높은 전기적 출력을 얻기 위해 경량화 및 공기역학적 구조를 감안하여 회전날개를 설계한다. 터빈의 소음도를 낮추고 낙뢰발생 시 터빈이 정상적으로 작동하도록 낙뢰흡수시스템을 설계한다. 드라이브트레인에 적절한 롤러베어링을 장착시켜 로터에서 기어박스로 전달되는 외력을 최소화한다. 기어, 베어링 등 핵심부품에 자동윤활유 공급시스템을 적용한다. 기어박스의 진동 및 감쇠효과를 위해 유압지지시스템을 설계한다. 유압갤리퍼브레이크시스템을 적용하여 드라이브의 회전시작 시의 안정성을 향상한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"기계기술사, 기계설계산업기사, 일반기계기사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"C291","dJobICdNm":"[C291]일반 목적용 기계 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001643:1', '{"dJobCd":"K000001643","dJobCdSeq":"1","dJobNm":"풍력타워설계기술자","workSum":"풍력발전을 위한 윈드타워(Wind Tower)를 연구·설계한다.","doWork":"풍력발전의 입지의 지반조건, 접근성 등의 설치환경, 발전기의 제작사, 발전량, 중량 등을 조사·분석한다. 설치조건에 따라 윈드타워의 모듈크기와 부하량 등을 산정하고 한계조건을 계산한다. 전선 등을 설치할 수 있는 전공구와 유지보수를 위한 사다리 등 조립과 유지보수를 고려하여 윈드타워를 설계하고 도면을 작성한다. 설계를 3D모델링하고 시뮬레이션을 통해 구조의 안정성과 조립, 시공의 편의성 등을 검증한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"윈드타워설계기술자","certLic":"기계기술사, 기계설계산업기사, 일반기계기사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"C291","dJobICdNm":"[C291]일반 목적용 기계 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003815:1', '{"dJobCd":"K000003815","dJobCdSeq":"1","dJobNm":"하이브리드동력시스템개발자","workSum":"하이브리드 동력시스템을 개발한다.","doWork":"하이브리드자동차가 엔진동력에서 모터동력으로 또는 그 반대로 전환하여 구동하는 데 효율성이 높고 안정적인 제어가 가능한 동력시스템을 연구·개발한다. 저속에서는 전기모터동력을 활용하고, 일정 속도를 넘어 엔진연비와 연소율이 높아 배기가스의 배출이 최저인 시점에서는 엔진동력을 활용하도록 제어하는 시스템을 개발한다. 엔진동력에서 모터동력으로 전환되는 데 있어 물리적, 기계적으로 안정적인 동력전환시스템을 개발한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"기계기술사, 기계설계산업기사, 그린전동자동차기사, 일반기계기사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"C303","dJobICdNm":"[C303]자동차 신품 부품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006534:1', '{"dJobCd":"K000006534","dJobCdSeq":"1","dJobNm":"항공기기관사","workSum":"항공기조종사를 보좌하여 비행규정, 운항규정에 따라 엔진과 각종 기기의 정상적인 가동을 확인·유지한다.","doWork":"조종실 내의 각종 계기 및 기계계통의 정상가동 여부를 확인한다. 항공기의 외부 및 엔진의 외형을 확인하고 중량, 균형 및 연료의 탑재량을 점검한다. 항공기조종사의 지시에 따라 엔진을 가동하여 출력을 조절하고 각종 계기 및 스위치를 조작한다. 항공기의 연료소모량을 조절하고 결빙상태를 감시한다. 기내의 압력과 온도를 조절한다. 항로상의 기상을 감시하고 항공기의 속도를 확인한다. 운항 중에 발생한 기기의 이상 현상을 정리하여 운항일지에 기록하고 정비관련 부서에 통보한다. 항공기조종사의 지시에 따라 운항에 필요한 각종 자료나의견을 제시하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"청각|손사용|시각|","workEnv":"위험내재|","workFunc1":"조정","workFunc2":"협의","workFunc3":"정밀작업","similarNm":"Flight Engineer","certLic":"항공산업기사, 항공정비사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"H511/H512","dJobICdNm":"[H511]항공 여객 운송업 / [H512]항공 화물 운송업","inqYear":"2023","etc":"민간영역에서는 사라진 직업임"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002180:1', '{"dJobCd":"K000002180","dJobCdSeq":"1","dJobNm":"항공기기체기술자","workSum":"항공기의 기계적 구조와 성능을 연구·검토하여 운용절차를 수립한다.","doWork":"엔진의 가동, 지상주행, 이륙, 상승, 순항, 강하, 착륙 등의 비행단계에서 필요한 운용절차를 수립한다. 항공시스템의 일부 결함으로 인한 비정상적인 운항에서 단계별로 대응하기 위한 운용절차를 분석한다. 비바람, 폭설, 가시거리 불량 등의 기상상태에서 운용절차를 수립한다. 운용절차를 수립하기 위하여 항공기의 시스템을 연구하고 항공기제작사, 엔진제작사 및 타 항공사의 최신정보를 수집하며 모의조정설비(Simulator)를 이용한 시험을 하여 결과를 분석한다. 각종 분석결과를 종합하여 안정성과 경제성을 고려한 최대효율의 운용절차를 수립한다. 항공기 결함, 기능장애를 연구한다. 항공사고예방기술을 개발한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"청각|시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"항공기운용기술자","connectJob":"항공기안전기술자","certLic":"항공기사, 항공산업기사, 항공정비사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"H511/H512","dJobICdNm":"[H511]항공 여객 운송업 / [H512]항공 화물 운송업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006497:1', '{"dJobCd":"K000006497","dJobCdSeq":"1","dJobNm":"항공기설계기술자","workSum":"항공공학적 원리(공기역학, 추진, 구조, 안정성, 제어)와 기술을 적용하여 항공기를 설계·개발·시험한다.","doWork":"일반 항공기나 특수목적의 항공기 또는 기타 관련된 항공기를 초기설계한다. 초기설계 후에 항공기부품을 설계·개발한다. 비행체 원형(原型)을 제작·시험한다. 원형의 시험이 성공적이면 생산을 시작하며, 이러한 과정의 모든 단계에 참여한다. 항공기기체 구성품(날개, 동체, 착륙장치, 조종시스템 등)의 설계, 개발을 전문으로 하기도 한다. 지상 또는 비행시험에 관한 프로그램의 분석이나 소음 및 진동해석, 열역학적 해석 또는 추진시스템의 개발을 전문으로 하기도 한다. 항공사에서 장비의 구입, 보수, 운용에 관한 기술적 업무를 수행하기도 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"균형감각|손사용|시각|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"항공공학기술자","connectJob":"항공기검사기술자, 항공기기관(엔진)기술자, 항공기기체기술자, 항공기기술자, 항공기정비기술자, 항공기제작기술자, 항공기조립기술자, 항공기계통설계연구원, 항공기전자설비연구원, 항공역학연구원, 항공기부품연구원, 항공기부품개발기술자, 무인항공기기술자","certLic":"항공기관기술사, 항공기체기술사, 항공산업기사, 항공기사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"C313","dJobICdNm":"[C313]항공기, 우주선 및 부품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007749:1', '{"dJobCd":"K000007749","dJobCdSeq":"1","dJobNm":"항공기인증기술자","workSum":"항공기등(항공기, 엔진, 프로펠러), 부품·장비품의 형식 설계에 대한 적합성 확인 및 합치성 검사를 수행하고, 이를 생산하는 시설의 품질시스템을 평가하는 등의 종합적이고 체계적인 항공기 인증 검사 업무를 수행한다.","doWork":"항공기의 구조, 비행성능, 추진, 세부, 기내환경, 기계장치, 항공전자, 전기 등 전문 분야별 항공기 기술기준의 적용성을 판단하고, 인증 신청자가 제출한 적합성 입증자료(해석, 검사, 시험 등)에 대한 적절성을 판단한다. 최종 항공 제품이 형식설계에 합치하고, 안전하게 작동할 수 있는 상태임을 확인한다. 항공기의 설계․제작․인증과 관련한 연구, 교육 등의 업무를 수행한다. 인증 진행 과정 및 평가 결과 등을 종합적으로 정리하여 보고서 또는 의견서를 작성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내·외","physicalAct":"청각|언어력|시각|","workEnv":"위험내재|고온|저온|다습|소음·진동|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"항공기인증엔지니어, 항공기인증검사원","certLic":"항공기사, 항공기체기술사, 항공기관기술사, 항공정비사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"C313/M729/O842","dJobICdNm":"[C313]항공기, 우주선 및 부품 제조업 / [M729]기타 과학기술 서비스업 / [O842]사회 및 산업정책 행정","inqYear":"2025"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002832:1', '{"dJobCd":"K000002832","dJobCdSeq":"1","dJobNm":"항공모의조종장비기술자","workSum":"항공기조종사의 훈련을 지원하기 위하여 모의조종장치를 조작·관리한다.","doWork":"훈련에 임하는 조종사에게 모의조종장치(Simulator)의 조종단계 및 난이도를 설명하고 관련 프로그램을 입력한다. 모의조종장치의 화면이 정상적으로 작동되는지 확인하고 컴퓨터의 단말기와 입력장치로 훈련의 난이도를 입력한다. 조종사의 훈련상황을 관찰하고 각 계기 및 조정판의 이상 유무를 확인한다. 상황별로 훈련결과를 분석·정리한다. 조종사의 효과적인 훈련을 위하여 훈련내용별로 프로그램을 개발한다. 각 시스템의 정기점검을 하고 가동일지를 작성한다. 조종사의 훈련내용을 컴퓨터와 프린터로 출력하여 관련 부서에 인계한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"보통 작업","workPlace":"실내","physicalAct":"청각|손사용|시각|","workFunc1":"조정","workFunc2":"교육","workFunc3":"정밀작업","similarNm":"시뮬레이터정비사, 항공기모의조종장비기술자","certLic":"항공기정비사,항공기전자전기계기정비사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"H511/H512","dJobICdNm":"[H511]항공 여객 운송업 / [H512]항공 화물 운송업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001481:1', '{"dJobCd":"K000001481","dJobCdSeq":"1","dJobNm":"항로표지설계기술자","workSum":"등대, 등표, 입표, 부표, 안개신호, 전파표지, 특수신호표지 등 항행하는 선박에게 지표가 되는 항로표지시설을 설계한다.","doWork":"선박의 안전, 해저지형, 수심, 저질, 장해물 등의 여건을 고려하여 해도상에 항로표지의 설치위치를 결정한다. 설치지점의 해저지형이나 지질, 수심, 조류, 파고 및 풍력 등 해상여건을 조사·검토한다. 항로표지의 형식, 개류구, 부속장치 등의 종류와 크기를 결정한다. 항로한계선, 등·부표배치선, 항로상 변칙점, 준설항로 및 협소한 자연적 항로, 법정권고 설치기준, 항만표지 배치기준 등을 검토한다. 등·부표의 중량분포, 중심·부심·경심의 높이, 진동주기, 외력에 의한 경사각, 배수체적과 흘수, 조류, 파도 등을 고려해서 등부표의 안정성을 계산한다. 적절한 체인의 길이와 장력을 계산하고 침주의 종류와 중량을 결정한다. 규정에 따라 부표설치요구서를 주무관청에 제출하고 승인을 받는다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"항로표지기사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"F412","dJobICdNm":"[F412]토목 건설업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006055:1', '{"dJobCd":"K000006055","dJobCdSeq":"1","dJobNm":"해양플랜트검사관리자","workSum":"해양플랜트에 설치된 모든 장비 및 시설의 품질을 보증하기 위해 관리·감독한다.","doWork":"설계단계에서 승인받은 문서와 도면을 기준으로 선주, 선급 및 각 공정 현장담당자와 함께 현물에 대한 검사를 진행한다. 배관, 전장, 의장 등 의장설치부서와 함께 설치품에 대한 검증을 실시한다. 배관의 경우 설치검사, 수압검사, 내부 상태검사를 진행하며, 전장의 경우 전선의 설치검사 및 저항, 절연검사를 진행해 설치완성도를 높이는 업무를 담당한다. 각 의장품 및 안전장비에 대해서도 선급규정에 따라 적절하게 설치되었는지 검증업무를 진행하며, 장비가 설치되고 나서 진행되는 시운전 중 발생되는 불합격사항에 대한 재검사 진행 여부 판단 및 선주, 선급과 협의를 통해 필요 검사내용과 과정에 대한 합의점을 이끌어 낸다. 선박에 설치되는 모든 장비 및 설치품에 대한 품질의 인증업무가 주요업무이며 이를 위한 규정의 이해도 및 협의 능력이 필요하다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"청각|","workEnv":"위험내재|소음·진동|","workFunc1":"분석","workFunc2":"감독","workFunc3":"제어조작","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"C311/F412","dJobICdNm":"[C311]선박 및 보트 건조업 / [F412]토목 건설업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006446:1', '{"dJobCd":"K000006446","dJobCdSeq":"1","dJobNm":"해양플랜트구조설계사","workSum":"해양플랜트구조물의 설계하중 및 구조계산을 통해 구조물 형상 및 배치를 위한 설계 및 검증을 담당한다.","doWork":"해양플랜트구조물을 이루고 있는 구조물의 작업환경에 따른 설계하중을 정의한다. 구조계산 및 해석을 통해 구조물을 이루고 있는 재료의 특성 및 형상과 배치를 설계한다. 또한 도면작성계획 및 선체구조도면을 작성하며, 선체무게를 추정한다. 기본구조설계에서 확정된 선형 Data를 기반으로 기본구조해석을 통해 선체중앙부단면을 확정한다. 이와 더불어 선체의 종방향단면을 나타냄과 동시에 갑판평면도와 이중저평면도를 덧붙여 나타내는 선체종단면도를 작성하며, 외판전개도 도면을 만든다. 기본구조설계에서의 결과는 선주·급 승인 후 선체설계로 전달된다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내·외","physicalAct":"손사용|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"C311/F412","dJobICdNm":"[C311]선박 및 보트 건조업 / [F412]토목 건설업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006103:1', '{"dJobCd":"K000006103","dJobCdSeq":"1","dJobNm":"해양플랜트기계설계사","workSum":"해양플랜트구조물에 설치될 기계의 위치 및 상세 사양을 작성하고 설계된 내용을 검증한다.","doWork":"장비를 구매하기 위한 세부자료로서 세부내역서, 데이터시트, 기본도면(형상 및 사이즈만 표기되는 기초적인 엔지니어링 도면), P&ID, 전기세부사양서 등을 작성하고 검토한다. 세부내역서가 작성되면 시공일정에 맞춰 장비구매를 위한 절차를 진행한다. 납품처에서 제출하는 문서를 검토하고 이를 다른 공정담당자에게 전달하여 품질향상을 책임진다. 장비가 입고되기까지 일정관리 및 장비도착 후 설치과정에서 발생할 문제점에 대해 사전검토 및 발생된 문제에 대해 수정작업을 진행한다. 입고된 장비의 검사과정, 설치과정 및 시운전과정까지 완료되어야 모든 업무가 종료된다. 기계설계 상세업무분야 중 기계의 특성에 따라 업무를 구분하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내·외","physicalAct":"손사용|","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"C311/F412","dJobICdNm":"[C311]선박 및 보트 건조업 / [F412]토목 건설업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006155:1', '{"dJobCd":"K000006155","dJobCdSeq":"1","dJobNm":"해양플랜트기본설계사","workSum":"해양플랜트의 기본설계안을 작성한다.","doWork":"해양플랜트를 설치할 해양의 환경조건을 검토한다. 모든 공정요건과 클라이언트의 요구사항을 확인한다. 조사결과와 기술축정정보를 토대로 설계의 사양을 정한다. 클라이언트의 요구사항을 기반으로 구조 및 기능을 검토한 계획안을 설계도면 등에 구현하여 개념설계(Conceptual Design)를 한다. 개념설계에서 빠진 것이 없는지 확인한다. 개념설계를 기반으로 구체적인 치수와 재료를 정하여 기본설계(Basic Design)를 한다. 기본설계안을 공학적으로 해석하고 평가한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"F412","dJobICdNm":"[F412]토목 건설업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006014:1', '{"dJobCd":"K000006014","dJobCdSeq":"1","dJobNm":"해양플랜트배관설계사","workSum":"해양플랜트구조물에 설치될 배관의 위치 및 상세사양에 대해 설계 및 검증을 담당한다.","doWork":"기계설계를 기반으로 배관을 효율적으로 배치하기 위한 설계업무 및 배관을 통과하는 유체에 따른 상세사양설계를 수행한다. 초기 레이아웃에 대한 설계가 끝난 이후에 PDMS를 통한 전체적인 설계를 시작하게 되며 3차원으로 표현된 디자인환경에서 배관 및 장치의 배치를 이해하고 효과적인 배관 Route를 진행한다. 다른 부서와 협업설계를 진행해야 한다. 기계, 프로세스 등 엔지니어링 관련 부서별 요청사항을 배관설계에 반영한다. 상세작업내용으로는 P&ID의 작성과 업데이트, 배관의 사양 및 단열, 도장의 확인, 기계 및 장치류 배관의 특수사항 검토, 배관 관련된 변동사항을 확인하고 업데이트 및 공사에 반영한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내·외","physicalAct":"손사용|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"C311/F412","dJobICdNm":"[C311]선박 및 보트 건조업 / [F412]토목 건설업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002950:1', '{"dJobCd":"K000002950","dJobCdSeq":"1","dJobNm":"해양플랜트시운전설계기술자","workSum":"해양플랜트의 계약요구사항, 현장실무조건, 시스템 및 장비별 특성에 따라 안전하고 효과적으로 시운전을 수행할 수 있도록 시운전절차서, 시운전설명서 등을 설계·개발한다.","doWork":"해양플랜트프로젝트의 특성 및 요구사항, 제반 시설 등을 분석하여 시운전수행전략계획서를 작성하고 발주처에 제출한다. 효과적인 검사업무를 수행하기 위해 시스템을 기계, 전기, 공조, 화재 및 가스감지, 계장 등 세부단위로 분개(시운전이 가능한 단위로 시스템을 나누는 것)하고 각 공종(공정, 기계, 전기, 계장, 공조, 항로통신)별 서브시스템 도면 및 목록을 작성한다. 시운전항목 및 시스템 간의 연관관계 및 시운전 수행장소에 따른 제약조건을 고려하여 효과적인 시운전수행순서를 정립한다. 프로젝트컴플리션(Project Completion)프로그램을 구성하고 해당 데이터를 입력하여 검사수행을 위한 데이터베이스를 구축한다. 컴플리션단계 및 공사종류별 장비특성에 따라 검사항목 및 적용표(체크시트)를 작성한다. 해양플랜트프로세스 시운전절차서, 기계시운전절차서, 전기시운전절차서, 시스템운전설명서를 작성한다. 장비별 보존 요구사항을 분석하여 장비보전절차를 수립한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006617:1', '{"dJobCd":"K000006617","dJobCdSeq":"1","dJobNm":"해양플랜트시운전설계사","workSum":"해양플랜트구조물이 건조된 후 장비작동 및 시스템적정성평가를 위한 절차서 작성 및 검증을 담당한다.","doWork":"전체적인 계약요구사항, 조직도, 스케줄 등 계약자의 효과적인 시운전수행전략 및 의도를 설명하는 수행전략계획서를 작성한다. 공종별 서브시스템 도면 및 목록을 작성한다. 시운전항목 및 시스템 간의 연관관계를 이해하고 수행장소별(Onshore, Near shore, Offshore) 제약조건을 고려하여 효과적인 시운전수행순서를 작성한다. 프로젝트 컴플리션절차에 따라 PCS프로그램을 구성하고 해당 데이터를 입력하여 검사수행을 위한 데이터베이스를 구축한다. 컴플리션단계 및 공종별로 장비특성에 따라 검사항목 및 적용표를 작성한다. 해양플랜트프로세스시스템의 시운전수행을 위해 필요한 절차서의 작성계획 수립, 작성전제조건 점검, 절차서를 구체화한다. 해양플랜트의 기계장비류, 계장장비류, 전기장비류의 시운전수행을 위해 필요한 절차서의 작성계획 수립, 작성 전제조건 점검, 절차서를 구체화한다. 해양플랜트 운전설명서 작성계획 수립, 시스템별 운전설명서작성 전제조건분석, 시스템별 운전설명서를 구체화하여 작성한다. 장비별 보존요구사항을 분석하고 실제 표준보존업무와의 최적화를 통해 장비별, 단계별 장비보전방안을 작성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내·외","physicalAct":"손사용|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"C311/F412","dJobICdNm":"[C311]선박 및 보트 건조업 / [F412]토목 건설업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005507:1', '{"dJobCd":"K000005507","dJobCdSeq":"1","dJobNm":"해양플랜트안전설계사","workSum":"해양플랜트구조물에 필요한 안전사항에 대해 설계 및 검토를 담당한다.","doWork":"해양플랜트구조물에 설치된 각종 장비에 대해 필요한 안전사항을 규정에 따라 검토하고 상세설계 중 발생한 문제점을 확인하여 장비의 사양 및 배치 등에 대해 개정을 요청한다. 특정장비의 중요도에 따라 여분의 장비를 도입할지에 대한 필요도 확인, 각 시스템이 작동 중 중단되었을 때 발생되는 위험성에 대한 평가를 진행한다. 필요시 개정작업요청, 안전사항이 만족되지 않을 시 구조의 개정요청 등을 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내·외","physicalAct":"손사용|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"C311/F412","dJobICdNm":"[C311]선박 및 보트 건조업 / [F412]토목 건설업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006961:1', '{"dJobCd":"K000006961","dJobCdSeq":"1","dJobNm":"해양플랜트종합설계사","workSum":"해양플랜트구조물의 전체 구조 및 구조물의 복원성과 종강도 등의 설계 및 검증을 담당한다.","doWork":"일반배치도의 상세확정 및 각종 화물선적에 따른 탱크의 용량계산식과 구조물의 복원성 및 종강도를 계산하여 설계도에 반영 및 현장상황에 따른 개정을 수행한다. 시운전 중 구조물의 경사시험을 계획, 수행, 보고 및 운행하는 동안 나타나는 구조물의 속력과 조정성에 대해 해석하고 필요시 보완책을 설계도에 반영한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내·외","physicalAct":"손사용|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"C311/F412","dJobICdNm":"[C311]선박 및 보트 건조업 / [F412]토목 건설업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001249:1', '{"dJobCd":"K000001249","dJobCdSeq":"1","dJobNm":"로봇공정시뮬레이션기술자","workSum":"로봇 및 자동화시스템 공정을 설계하고 로봇공정 시뮬레이션을 통해 생산량 및 문제점 등을 분석한다.","doWork":"로봇 및 자동시스템의 실제 공정을 설치하기 전 3D프로그램을 이용하여 로봇 및 자동화시스템 공정을 설계하고 시뮬레이션을 통해 작업공정의 정확성, 생산성 및 문제점을 분석한다. 로봇의 동작영역(reach)과 엔드에펙터 선정의 적절성, 공정시간(cycle time) 등을 고려하여 로봇 자동화시스템의 3D모델링과 로봇 프로그래밍의 적합성 등을 시뮬레이션프로그램으로 수행하고 정상 동작 상태를 분석한다. 로봇 자동화시스템 공정이 설치된 현장에서 로봇 필드엔지니어와 로봇 티칭 및 작업공정의 문제점에 대한 의견을 공유하며 이를 해결하기 위한 기술에 대해 분석 및 연구한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1512","dJobECdNm":"[1512]로봇공학 기술자 및 연구원","dJobJCd":"2352","dJobJCdNm":"[2352]로봇공학 기술자 및 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006342:1', '{"dJobCd":"K000006342","dJobCdSeq":"1","dJobNm":"로봇기구개발자","workSum":"로봇기구, 주변장치, 툴 등을 설계·제작하고 시험평가결과를 반영하여 로봇기구를 개발한다.","doWork":"로봇수요자의 요구 및 로봇이 수행할 작업, 운용환경, 제약조건, 관련 기술, 관련 규정, 개발유효성 등을 검토하여 개발기획서를 작성한다. 개발할 로봇의 개념을 정의하고 외관을 고안하여 개념도를 작성한다. 축(Shaft), 브래킷(Bracket), 케이스(Case), 몸체(Body), 기어, 풀리 등 개발에 필요한 요소부품과 재료를 선정하고 요소부품 중 표준화된 부품이 아닌 경우 신규부품을 설계한다. 로봇기구의 요소 및 구조 부품을 3D모델링하고 구조해석과 동역학해석 결과를 상세설계에 반영한다. 개념설계 및 구조해석결과에 따라 상세설계를 한다. 로봇주행 장치, 로봇설치대 등 주변장치와 치공구 등을 설계한다. 엔드이펙터(End Effector: 로봇이 작업 할 때 작업대상에 직접 작용하는 기능이 있는 부분)를 설계한다. 시제품을 제작한다. 로봇의 기구, 하드웨어, 소프트웨어를 통합하여 조립하고 기능, 성능, 신뢰성시험 및 필드테스트를 수행한다. 로봇을 포함한 전체 작업시스템을 검토, 설계하고 제작된 모듈을 조립하여 로봇시스템을 완성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"로봇기구설계기술자, 로봇기구설계사","certLic":"기계기술사, 기계설계기사, 기계설계산업기사, 로봇기구개발기사","dJobECd":"1512","dJobECdNm":"[1512]로봇공학 기술자 및 연구원","dJobJCd":"2352","dJobJCdNm":"[2352]로봇공학 기술자 및 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006748:1', '{"dJobCd":"K000006748","dJobCdSeq":"1","dJobNm":"로봇동작생성연구원","workSum":"로봇의 움직임과 이동 등 로봇동작을 계획·제어하기 위한 방식을 연구·개발한다.","doWork":"로봇의 동작특성을 파악한다. 가상의 힘요소(스프링, 댐퍼, 관절제한, 반발력 등)를 고려하여 동역학모델링하고 해석한다. 외력에 대응하는 힘을 제어하는 동작제어프로그램을 개발한다. 시뮬레이션프로그램을 활용하여 자세제어기술을 개발한다. 로봇이 다양한 외부환경 변수에 따라 사전에 설정된 동작을 수행하도록 알고리즘·프로그램을 개발한다. 로봇이 자가학습기능을 통해 행동패턴을 스스로 수정하는 기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1512","dJobECdNm":"[1512]로봇공학 기술자 및 연구원","dJobJCd":"2352","dJobJCdNm":"[2352]로봇공학 기술자 및 연구원","dJobICd":"C292/M701","dJobICdNm":"[C292]특수 목적용 기계 제조업 / [M701]자연과학 및 공학 연구개발업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006320:1', '{"dJobCd":"K000006320","dJobCdSeq":"1","dJobNm":"로봇소프트웨어개발자","workSum":"로봇작업 요구사항을 분석하고 로봇 관련 소프트웨어를 설계, 개발하고 시험 및 평가한다.","doWork":"로봇 기구 및 하드웨어의 특성을 이해하고 로봇의 동작환경 및 실제 사용자그룹별 로봇의 패턴 및 동작에 대한 요구사항을 분석한다. 주어진 목표성능과 신뢰성을 만족하도록 로봇의 액추에이터를 제어하는 소프트웨어를 개발한다. 로봇이 계획된 동작을 수행하고 주변환경을 인식하기 위한 다양한 센서 인터페이스프로그램을 개발한다. 로봇애플리케이션개발자가 로봇의 다양한 센서, 액추에이터 및 공통 기능요소들을 사용하기 쉽게 추상화하여 API로 제공하고 이들을 운용·관리할 수 있는 로봇 미들웨어를 개발한다. 인간과 로봇 간의 의사소통 및 상호 협력을 가능하게 하는 상호작용환경을 디자인하고 구현한다. 로봇 소프트웨어 아키텍처를 설계하기 위해서 요구사항을 분석하고 소프트웨어 아키텍처를 정의, 설계 및 검증한다. 로봇동작과 디지털멀티미디어콘텐츠가 연동되도록 로봇콘텐츠를 설계하고 개발한다. 개발한 로봇소프트웨어를 다양한 경우의 수에 잠재적으로 가지고 있을 수 있는 결함을 식별한다. 여러 대의 로봇 및 서버가 연동하여 동작할 때 이를 일괄적으로 모니터링하고 원활하게 동작할 수 있게 하는 프로그램을 개발한다. 로봇 운용에 필요한 소프트웨어 설치를 위하여 계획을 수립하고 절차에 의해 설치 또는 업그레이드를 진행하며, 그룹별 사용자 교육을 진행하고, 주기적 혹은 요청 시점에 예방, 정기, 긴급 등 각종 유지보수작업을 실행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"로봇소프트웨어개발기사","dJobECd":"1512","dJobECdNm":"[1512]로봇공학 기술자 및 연구원","dJobJCd":"2352","dJobJCdNm":"[2352]로봇공학 기술자 및 연구원","dJobICd":"C292/M701","dJobICdNm":"[C292]특수 목적용 기계 제조업 / [M701]자연과학 및 공학 연구개발업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005495:1', '{"dJobCd":"K000005495","dJobCdSeq":"1","dJobNm":"로봇유지보수엔지니어","workSum":"로봇유지보수계획을 수립하고 수행한다.","doWork":"산업현장에서 로봇을 효율적으로 사용하기 위하여 설치 시운전계획과 점검주기별 유지보수계획을 수립하고 전반적인 유지보수업무 프로세스를 구축한다. 고객의 요구사항에 따라 로봇을 설치하기 위하여 로봇의 설치요소를 확보하고 설치도구를 준비하여 로봇을 설치 시운전한다. 로봇을 정상적인 상태로 유지하기 위하여 매뉴얼을 분석하고 매뉴얼에 따라 기구부와 제어부를 유지관리한다. 문제점이 발생된 로봇에 대하여 매뉴얼에 따라 상태를 현장 또는 원격으로 진단하며, 안전환경조건을 만족시키는지 점검한다. 문제점이 발생한 로봇기구부, 제어부, 시스템인터페이스의 원활한 동작운용을 위하여 동작상태를 점검하고 문제를 해결하며, 보수된 부분의 동작을 확인한다. 로봇의 유지보수를 원활하게 수행하기 위하여 유지보수에 사용되는 부품의 재고를 관리하고 부품의 보관계획을 수립하며, 불용재고를 관리한다. 유지보수업무에 활용하기 위하여 로봇의 유지보수과정에서 발생한 수리점검목록을 작성하고 수리점검내역을 확인하며, 유지보수보고서를 작성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"필드서비스엔지니어","certLic":"기계정비기능사·산업기사, 전기기능사·기사·산업기사, 전자기사·산업기사, 생산자동화기능사·산업기사, 산업안전기사·산업기사, 설비보전기능사, 전자계산기제어산업기사","dJobECd":"1512","dJobECdNm":"[1512]로봇공학 기술자 및 연구원","dJobJCd":"2352","dJobJCdNm":"[2352]로봇공학 기술자 및 연구원","dJobICd":"C/M701","dJobICdNm":"[C]제조업 / [M701]자연과학 및 공학 연구개발업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007216:1', '{"dJobCd":"K000007216","dJobCdSeq":"1","dJobNm":"로봇지능개발자","workSum":"로봇의 대화지능, 시각지능, 제스처지능, 감성지능, 환경인지지능, 이동지능, 작업지능, 학습지능 등을 개발, 시험평가 및 유지·보수한다.","doWork":"로봇 사용자의 음성에서 의도를 분석하고 로봇의 특성을 반영하여 대화모델을 설계하고 학습시켜 적절한 응답을 구현한다. 로봇이 시각센서로 영상데이터를 획득하고 물체 및 사람을 인식할 수 있도록 알고리즘의 요구사항을 파악하고 설계·구현한다. 로봇 제스처 인식 요구사항과 목표성능을 설정하고 센서로 수집한 데이터를 분석하여 제스처 인식 알고리즘을 설계·구현한다. 로봇 사용자의 감정, 의도에 따라 상황에 맞는 행동을 표현하기 위해서 로봇 감성모델을 설계하고 사용자 감정인지 및 로봇행동을 구현한다. 로봇시스템 센서에서 수집한 환경데이터를 분석하여 로봇이 처한 환경을 판단할 수 있는 지능을 개발한다. 로봇이 환경지도정보를 기반으로 로봇 자신의 위치를 파악하고 주행경로를 생성하여 주어진 목적지로 이동하는 지능을 설계하고 구현한다. 로봇 작업환경에 관한 요구사항과 작업특성을 파악하여 작업수행 알고리즘을 구현한다. 다양한 데이터를 분석하고 분류하거나 예측하는 지능을 개발한다. 로봇지능시스템의 안정적인 사용을 보장하기 위하여 고장분석 및 예방대책을 수립하고 사용자를 교육한다. 로봇지능시스템이 의도된 기능을 적절하게 수행하는지와 잠재적 결함을 식별할 수 있는지를 검증하기 위하여 시험절차를 설계하고 기능 및 신뢰성 시험을 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"로봇인공지능개발자, 로봇지능시스템개발자","dJobECd":"1512","dJobECdNm":"[1512]로봇공학 기술자 및 연구원","dJobJCd":"2352","dJobJCdNm":"[2352]로봇공학 기술자 및 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006224:1', '{"dJobCd":"K000006224","dJobCdSeq":"1","dJobNm":"로봇하드웨어설계기술자","workSum":"각종 산업활동에 사용되는 로봇 하드웨어를 설계한다.","doWork":"로봇제품에 요구되는 사항을 분석하여 로봇 하드웨어의 사양과 구조의 개념설계를 한다. 로봇에 사용되는 액츄에이터(Actuator:동력으로 기계를 동작하는 구동장치)를 구동하는 드라이버를 요구사항에 맞게 분석하고 사양을 선정하여 드라이버 구동회로를 설계한다. 로봇의 자세 및 동작을 제어하기 위한 동작 프로파일, 모션제어 하드웨어 및 구조, 회로를 설계한다. 로봇의 동작 및 구성에 필요한 각각의 기능모듈에 대한 신호 및 전자적 인터페이스 요구사항을 분석하여 입출력 인터페이스 하드웨어를 설계한다. 로봇의 동작에 필요한 전원과 각 기능에 필요한 전원분배, 모니터링, 전원관리에 대한 사항을 분석하고 설계한다. 로봇 운영 컨트롤부(로봇 초기화, 운영제어처리, 센서데이터 획득, 신호입출력처리, 구동명령 등)를 설계한다. 로봇시스템의 요구사항에 따라 전장사양 및 구조를 설계한다. 로봇에 부착된 다양한 센서신호를 획득하고 분석하여 동작상태, 반응상태, 누적 편차 등을 인터페이스 장치로 전달하는 센서 신호처리부를 설계한다. PCB와 전기전자 부품, 하드웨어 부품 등을 통합하여 로봇 하드웨어를 제작한다. 규격에 맞게 제작, 조립되었는지 시험·평가한다. 로봇 하드웨어의 안정적인 사용을 보장하기 위하여 고장 분석, 예방대책을 수립하고 사용자를 교육한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"로봇시스템설계기술자","certLic":"기계기술사, 기계설계기사, 기계설계산업기사, 로봇하드웨어개발기사","dJobECd":"1512","dJobECdNm":"[1512]로봇공학 기술자 및 연구원","dJobJCd":"2352","dJobJCdNm":"[2352]로봇공학 기술자 및 연구원","dJobICd":"C292/M701","dJobICdNm":"[C292]특수 목적용 기계 제조업 / [M701]자연과학 및 공학 연구개발업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003463:1', '{"dJobCd":"K000003463","dJobCdSeq":"1","dJobNm":"산업용로봇운영프로그램설치기술자","workSum":"산업용 로봇 및 로봇 주변설비가 자동화 작업을 수행할 수 있도록 통합운영시스템 프로그램을 설치한다.","doWork":"산업용 로봇자동화설비를 설치할 고객사의 공정을 분석한다. 생산조건과 방법 등을 확인한다. 3D시뮬레이션을 통해 로봇자동화설비의 적용가능 여부를 판단하고 로봇자동화설비 설계에 반영한다. 로봇자동화설비의 제작이 완료되면 티칭(로봇이 동작하는 영역과 순서 등을 전용 프로그램으로 작성하는 업무)업무를 수행한다. PLC프로그램과 연계하여 동작시작, 동작완료, 타 설비 동작요청 등 신호체계를 수립한다. 제품을 생산하는 과정에서 로봇 그리퍼를 미세조정하여 로봇의 동작영역을 입력한다. 전체 설비의 생산속도를 높이기 위해 로봇의 동작구간을 최단거리로 조정하는 등 최적화 작업을 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"SI전문가","certLic":"생산자동화산업기사","dJobECd":"1512","dJobECdNm":"[1512]로봇공학 기술자 및 연구원","dJobJCd":"2352","dJobJCdNm":"[2352]로봇공학 기술자 및 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006367:1', '{"dJobCd":"K000006367","dJobCdSeq":"1","dJobNm":"산업용로봇자동화설비설계기술자","workSum":"산업용 로봇자동화설비를 산업현장에 설치하기 위해 로봇 주변장치 및 자동화설비를 설계한다.","doWork":"자동화 대상 공정을 조사하고 기존 설비의 현황, 기능, 생산속도, 위치, 자동화설비를 설치할 공간, 생산제품의 공정특성, 근로자의 작업 패턴 등을 분석한다. 기존 설비와 자동화설비가 설치될 공간, 전·후 공정의 위치 등을 고려하여 레이아웃도면을 제작한다. 자동화설비의 전반적인 사양을 선정하고 선정된 사양이 반영된 유닛별 세부제작도면을 작성한다. 디스태커(Destacker), 센터링테이블, 컨베이어, 로봇 그리퍼, 안전펜스 등 유닛의 가공 및 제작, 외주구매 여부를 결정하고 사양을 도면에 표시한다. 유닛별 적용 타당성을 계산한다. 유닛별 조립도면을 제작한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"SI전문가","certLic":"기계기술사, 기계설계기사, 기계설계산업기사, 생산자동화산업기사, 로봇하드웨어개발기사","dJobECd":"1512","dJobECdNm":"[1512]로봇공학 기술자 및 연구원","dJobJCd":"2352","dJobJCdNm":"[2352]로봇공학 기술자 및 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001861:1', '{"dJobCd":"K000001861","dJobCdSeq":"1","dJobNm":"산업용로봇자동화설비제작기술자","workSum":"산업용 로봇의 주변장치 및 자동화설비를 가공·조립·설치한다.","doWork":"제작도면, 부품도면, 조립도면, 설치도면 등을 접수하고 작업종류에 따라 도면을 분류한다. 각종 공작기계로 필요한 부품을 가공·생산하거나, 외주제작 및 구매품을 접수하여 조립을 준비한다. 조립도면에 따라 각 부품을 조립하고 부품의 작동방향, 작동범위 등을 점검한다. 조립이 완료된 유닛에 전원, 급유, 공기압 등을 공급하고 시운전을 한다. 시운전에서 발견한 부품간섭, 이상마모, 소음, 진동 등 문제를 해결한다. 제작된 설비를 분해하여 설치현장으로 이송한다. 설치도면을 참고하고 다양한 현장의 여건에 대응하면서 조립·설치한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"SI전문가","certLic":"기계기술사, 기계설계기사, 기계설계산업기사, 생산자동화산업기사","dJobECd":"1512","dJobECdNm":"[1512]로봇공학 기술자 및 연구원","dJobJCd":"2352","dJobJCdNm":"[2352]로봇공학 기술자 및 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002853:1', '{"dJobCd":"K000002853","dJobCdSeq":"1","dJobNm":"산업용로봇자동화통합시스템제어기술자","workSum":"산업용 로봇과 주변설비를 제어하는 자동화시스템을 개발한다.","doWork":"산업용 로봇 자동화시스템에 사용될 주요부품을 선정한다. 로봇 및 주변설비에 공급될 전원과 입출력 배선이 표기된 제작도면을 작성한다. 전체 공정의 순서, 오퍼레이터가 조작할 생산조건, 현재 운영상태, 알람내역 등이 표시될 터치스크린 화면을 설계한다. 동작·정지명령, 동작·정지조건, 근로자 및 설비보호용 차단기능, 생산조건 조정·관리기능, 모니터링, 생산량 집계 등 자동화설비를 제어하는 PLC(Programmable Logic Controller:각종 센서로부터 신호를 받아 제어기에 신호를 보냄으로써 사람이 지정해둔 대로 작동시키는 장치)를 프로그래밍한다. 각 부분을 제작한 후 전원과 입출력배선을 설치한다. 시운전을 하여 정상작동 여부를 확인한다. 수정과 운전을 반복하여 제어시스템의 신뢰성, 안정성을 확보한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"SI전문가","certLic":"생산자동화산업기사, 로봇하드웨어개발기사","dJobECd":"1512","dJobECdNm":"[1512]로봇공학 기술자 및 연구원","dJobJCd":"2352","dJobJCdNm":"[2352]로봇공학 기술자 및 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006852:1', '{"dJobCd":"K000006852","dJobCdSeq":"1","dJobNm":"지능형로봇연구원","workSum":"로봇이 외부환경에 대한 정보를 인식(Perception)할 수있는 관련기기, 알고리즘과 스스로 상황을 판단(Cognition)하여 자율적으로 동작(Manipulation)하는 지능형로봇(Intelligent Robots)을 연구·개발한다.","doWork":"로봇의 물체인식(물체의 종류, 크기, 방향, 위치 등을 인지하는 기술), 위치인식(센서, 마크, 스테레오비전 등을 통해 로봇 스스로 공간지각 능력을 가지도록 하는 기술), 음성인식(로봇이 음성으로부터 언어적 의미를 식별하는 기술), HRI(Human Robot Interaction:로봇이 인간의 자세, 동작, 표정 등을 인식하고 상호작용하는 기술) 등에 관련된 알고리즘을 연구·개발한다. 외부환경의 인식과 외부물체의 행동을 인지하고 이를 해석하기 위한 카메라나 센서 등의 부품과 정보를 해석하고 분석한다. 머니퓰레이터(Manipulator), 장착형·부축형 보행보조기기, 비전·음성SoC(System on Chip), 실시간제어체계 등의 시스템통합 플랫폼 기술을 바탕으로 모터와 관절 등의 부품과 이를 제어하는 제어시스템을 개발한다. 대상의 행동이나 상황에 따라 GPS나 초음파센서, 전자지도, RFID 등을 이용하여 자기의 위치를 파악하여 스스로 이동하고 로봇이 취할 대응행동양식을 제어하기 위한 하드웨어시스템과 프로그램의 개발을 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1512","dJobECdNm":"[1512]로봇공학 기술자 및 연구원","dJobJCd":"2352","dJobJCdNm":"[2352]로봇공학 기술자 및 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002862:1', '{"dJobCd":"K000002862","dJobCdSeq":"1","dJobNm":"휴먼노이드로봇공학기술자","workSum":"사람과 닮은 휴먼노이드 로봇을 연구·개발한다.","doWork":"사람의 모습과 행동을 로봇에 구현하기 위해 인간의 외형을 모델링하여 얼굴, 골격, 손 등의 생체모방 로봇구조를 설계한다. 인간의 외모와 비슷한 느낌이 날 수 있고 로봇의 동작에 자연스럽게 반응할 수 있는 재질로 로봇의 외피를 만든다. 로봇의 형상을 구동할 수 있도록 모터와 기구를 설계한다. 로봇 제어시스템과 외부의 정보를 수집할 수 있는 비전, 센서들의 인터페이스를 구성하고 구동을 위한 동력장치를 설계한다. 로봇의 구동을 위한 알고리즘과 프로그램의 구조를 설계하여 작성하고 로봇에 탑재한다. 완성된 안드로이드 로봇의 성능을 테스트한다. 인간에 가까운 인지능력과 행동을 구현 하도록 안드로이드 로봇의 기계, 전자, 소프트웨어의 성능향상을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1512","dJobECdNm":"[1512]로봇공학 기술자 및 연구원","dJobJCd":"2352","dJobJCdNm":"[2352]로봇공학 기술자 및 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004693:1', '{"dJobCd":"K000004693","dJobCdSeq":"1","dJobNm":"건설기계검사원","workSum":"건설현장의 재해를 사전에 예방하기 위하여 건설기계의 등록사항과 동일성을 확인하고 성능 및 안전도를 검사한다.","doWork":"검사신청서를 지역·일정별로 분류한다. 버니어캘리퍼스, 테스트해머, 반사경, 비중계 등의 출장 검사기기를 준비한다. 당일 수검대상 건설기계 소유자에게 검사장소와 일정을 통보한다. 검사대상 기계를 사진으로 촬영한다. 건설기계의 등록번호표, 등록번호 새김 및 주요제원이 검사증과 일치하는지 확인한다. 원동기부, 하체부, 차체, 작업장치 등의 안정성 및 성능을 전조등시험기, 매연테스트기, 속도계 등으로 정밀검사하거나 육안검사를 한다. 기술검사표를 작성하고 등록원부를 확인한다. 검사결과를 컴퓨터에 입력한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"건설기계시험원","certLic":"건설기계정비기사, 건설기계정비산업기사","dJobECd":"1513","dJobECdNm":"[1513]기계·로봇공학 시험원","dJobJCd":"2353","dJobJCdNm":"[2353]기계 및 로봇공학 시험원","dJobICd":"S951","dJobICdNm":"[S951]컴퓨터 및 통신장비 수리업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006919:1', '{"dJobCd":"K000006919","dJobCdSeq":"1","dJobNm":"고압용기검사원","workSum":"LGP가스, 고압탱크 등 고압용기를 검사하여 결함 유무를 확인한다.","doWork":"검사기준서를 준비한다. 사용철판의 두께, 부식측정편, 용접검사(육안검사, 용접방법 및 시공, 용접 후 열처리, 용접이음의 기계시험, 용접부의 비파괴시험), 수압시험, 저온압력용기의 충격시험, 내·외면의 가공상태 및 변형, 본체, 자켓, 노즐, 부속물, 지지대, 기초볼트, 볼트, 너트의 이완덮개판, 플랜지, 가스켓 등의 상태, 안전밸브, 온도계, 압력계 등의 방호장치의 상태, 기초볼트 등의 기초상태 등을 검사한다. 검사한 제품에 대한 기록을 하고 정리하여 보고한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"화공기사, 위험물산업기사, 방사선비파괴기사","dJobECd":"1513","dJobECdNm":"[1513]기계·로봇공학 시험원","dJobJCd":"2353","dJobJCdNm":"[2353]기계 및 로봇공학 시험원","dJobICd":"C251","dJobICdNm":"[C251]구조용 금속제품, 탱크 및 증기발생기 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003284:1', '{"dJobCd":"K000003284","dJobCdSeq":"1","dJobNm":"공정장비시험분석원","workSum":"공정장비의 품질검사를 위해 생산품을 시험·분석한다.","doWork":"공정장비의 품질검사를 위해 시험절차, 규격 등의 시험계획을 수립한다. 공정장비의 시운전에 필요한 자재를 준비한다. 습도, 온도 등의 실내조건 등의 공정조건을 파악한다. 공정장비를 설치하고 중간재를 투입하여 나온 생산품의 외형, 물성, 성능 등이 규격에 적합한지 시험·분석하여 공정장비의 품질을 검사한다. 검사결과가 규격에 미달하여 불량이나 이상의 발견되면 문제점 해결을 위해 원인분석을 실시하고 분석된 결과를 생산부서에 통보한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"생산자동화산업기사","dJobECd":"1513","dJobECdNm":"[1513]기계·로봇공학 시험원","dJobJCd":"2353","dJobJCdNm":"[2353]기계 및 로봇공학 시험원","dJobICd":"C292","dJobICdNm":"[C292]특수 목적용 기계 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005663:1', '{"dJobCd":"K000005663","dJobCdSeq":"1","dJobNm":"농업기계검사원","workSum":"트랙터, 이앙기, 콤바인, 경운기, 탈곡기, 관개배수용펌프 및 전동기 등 각종 농업기계를 검사·검정한다.","doWork":"농업기계검사를 위하여 의뢰자의 신청서를 접수하고 검사계획을 수립한다. 검사표준서에 따라 검사장치를 준비하고 점검한다. 농기계의 기종에 따라 형식검사와 사후검사로 나누어 검사한다. 종합검정 및 기술지도검정에 따라 기종형식, 규격, 성능, 안전성, 국제규범, 조작의 난이도검사를 실시한다. 성적심의 및 적부판정을 하여 검사성적서를 발급한다. 검사표준을 설정하기 위하여 검사기준 및 방안을 작성한다. 학계, 관련업체, 관련기관, 판매업소 및 사용자로 구성된 검사협의회에 상정하여 심의한다. 제품의 하자부분을 판정하고 불량부분을 기록하여 보고한다. 검정기준 및 방법, 개정사항을 관계규정에 고시한다. 관련업체와 협의하여 검정방법을 확정하여 통보한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|시각|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"농업기계기사, 농업기계산업기사","dJobECd":"1513","dJobECdNm":"[1513]기계·로봇공학 시험원","dJobJCd":"2353","dJobJCdNm":"[2353]기계 및 로봇공학 시험원","dJobICd":"C292","dJobICdNm":"[C292]특수 목적용 기계 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007031:1', '{"dJobCd":"K000007031","dJobCdSeq":"1","dJobNm":"동력전달장치시험원","workSum":"다이나모메타 등의 동력시험장비로 조립이 완성된 산업용 변속기의 작동상태를 시험한다.","doWork":"검사기준서 및 작업지시서에 따라 검사장치를 준비하고 점검한다. 호이스트로 기어장치를 시험장치에 고정한다. 다이나모메타에 제품을 연결한다. 동력장치를 작동하여 토크(Torque)와 회전수를 측정하여 동력의 출력을 시험한다. 변속조작 시 기어변속이 원활히 이루어지는지 확인한다. 측정장비를 조작하여 소음·진동, 표면온도, 오일레벨, 누수 등을 검사한다. 기타 취부볼트의 체결상태나 체인 및 벨트의 느슨함을 확인한다. 제품의 하자 여부를 판정하고 불량부분을 기록하여 분석한다. 불량제품을 표기하여 분리하고 재가공부서로 이송한다. 이상이 없는 제품에 검사필증을 부착하고 시험성적표 등을 첨부한다. 출하를 위하여 적재보관소로 이송한다. 검사장비 및 검사설비장치를 정돈하고 주위를 정리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"1513","dJobECdNm":"[1513]기계·로봇공학 시험원","dJobJCd":"2353","dJobJCdNm":"[2353]기계 및 로봇공학 시험원","dJobICd":"C291","dJobICdNm":"[C291]일반 목적용 기계 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005931:1', '{"dJobCd":"K000005931","dJobCdSeq":"1","dJobNm":"발전기계공무기술원","workSum":"발전소의 원활한 운영을 위하여 발전기계설비의 유지·정비를 위한 제반 기술공무를 수행한다.","doWork":"발전소의 원활한 운영을 위하여 발전기계 설비를 유지·정비한다. 발전기계설비의 유지·보수를 위하여 관련 정비업체의 설계도면, 기술절차서, 작업사항 등을 제시하고 규정대로 작업을 수행하는지 관리·감독한다. 발전기계설비의 유지를 위하여 도면 및 각종 절차서 등의 기술자료를 체계적으로 관리한다. 발전소의 효율적이고 안전한 운영을 위하여 운전절차, 정비 등의 품질관리 및 안전관리를 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|","workFunc1":"분석","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"발전기계설비공무기술원","certLic":"일반기계기사, 건설기계기사, 산업안전기사, 정보처리기사","dJobECd":"1513","dJobECdNm":"[1513]기계·로봇공학 시험원","dJobJCd":"2353","dJobJCdNm":"[2353]기계 및 로봇공학 시험원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002879:1', '{"dJobCd":"K000002879","dJobCdSeq":"1","dJobNm":"선박검사원","workSum":"정해진 작업표준에 따라 선박이 건조되었는지 또는 운행 중인 선박의 시설물이 법으로 규정된 기준을 충족하고 있는 지 등을 검사한다.","doWork":"검사의뢰자와 검사일시, 준비사항 등을 협의한다. 검사할 선박의 종류와 검사형태에 따라 검사항목, 검사기준 등 검사관련 자료를 수집하고 정리한다. 검사선박에 탑승하여 선장 또는 기관사와 검사 대상의 위치를 확인한다. 선박 선체부나 기관의 설비 등을 계측기를 비롯한 검사기기를 사용하여 검사한다. 기준 합당 여부를 판단하여 체크리스트 등에 기록한다. 검사 시 발견된 문제점과 보완일정 등을 검사노트에 기록하고 검사의뢰자에게 통보한다. 검사가 수일 동안 지속될 경우 매일 검사일지를 작성한다. 검사가 완료된 후 검사보고서를 작성하고 의뢰자, 검사대상자, 그리고 행정기관 등에 통보한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|청각|손사용|시각|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"선체검사원, 기관검사원, 특수검사원, 항만국통제검사관(PSC검사관)","certLic":"조선산업기사, 조선기사","dJobECd":"1513","dJobECdNm":"[1513]기계·로봇공학 시험원","dJobJCd":"2353","dJobJCdNm":"[2353]기계 및 로봇공학 시험원","dJobICd":"M729","dJobICdNm":"[M729]기타 과학기술 서비스업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001556:1', '{"dJobCd":"K000001556","dJobCdSeq":"1","dJobNm":"선박커미셔닝 엔지니어","workSum":"선박, 해양설비에 설치된 각종기기를 검사기관 또는 관련 법규에 따라 커미셔닝을 통해 설계 및 제작 사양에 부합하는지 점검, 수리, 시험·검사한다.","doWork":"커미셔닝 할 개별 장비의 제원, 설계도, 검사 관련 규정 등을 파악한다. 설계준비 단계에서 시스템별로 구분하여 시스템, 장비설치 구역등 세부항목으로 구분하여 커미셔닝 목록, 공사기간, 요구품질 등을 반영하여 커미셔닝 절차서를 작성한다. 절차서에 따라 사전점검, 기기 작동검사, 정상운전을 실시한다. 커미셔닝에 필요한 자재 및 공구 목록을 작성하고 발주, 입고검사, 보관, 이동한다. 대분류는 기계, 전기, 계장로 분류하고 세분류로는 전기, 기계, 프로세스, 유틸리티, 메인트런스, 텔레콤, HVAC 등으로 분류하여 관련 규정이나 법규에 따라 설계, 제작 사양에 부합하는지 시험검사를 하고 검사결과를 기록한다. 완공사양서 및 검사이력서를 작성하고 선주검사관에게 인계한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"선박기계시운전원, 선박기관시운전원, 해양플랜트 엔지니어","certLic":"기계조립산업기사, 동력기계정비기능사, 배관산업기사, 공조냉동기계기사, 기계정비 산업기사, 전기기사","dJobECd":"1513","dJobECdNm":"[1513]기계·로봇공학 시험원","dJobJCd":"2353","dJobJCdNm":"[2353]기계 및 로봇공학 시험원","dJobICd":"C311","dJobICdNm":"[C311]선박 및 보트 건조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007268:1', '{"dJobCd":"K000007268","dJobCdSeq":"1","dJobNm":"섬유가공설비개발시험원","workSum":"성능이 개선된 섬유가공설비를 제작하여 시험·분석한다.","doWork":"섬유가공설비개발기술자가 작성한 제품명세서, 장비명세서 및 작업수행요건 등을 분석한다. 개발할 섬유가공설비 시제품을 제작한다. 관련 장비와 설비를 가동하여 검사항목에 대해 시험을 한다. 결과를 분석하여 정상 여부를 판단한다. 설비조작원들이 이용할 수 있도록 작업표준서를 작성한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"합성섬유가공설비시험원, 화학섬유가공설비시험원","certLic":"섬유산업기사, 섬유기사","dJobECd":"1513","dJobECdNm":"[1513]기계·로봇공학 시험원","dJobJCd":"2353","dJobJCdNm":"[2353]기계 및 로봇공학 시험원","dJobICd":"C292","dJobICdNm":"[C292]특수 목적용 기계 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002185:1', '{"dJobCd":"K000002185","dJobCdSeq":"1","dJobNm":"실험용항공기제작원","workSum":"목재·금속가공장비와 수동공구를 사용하여 실험용 항공기를 제작·설치한다.","doWork":"도면을 보고 작업에 필요한 공구와 각종 자재를 준비한다. 삼각자와 게이지(Gauge), 캘리퍼스(Callipers) 등의 측정도구를 사용하여 도면에 맞는 치수를 모형재료에 도안한다. 각종 모형재료를 성형하고 제조하기 위하여 띠톱, 목재선반, 금속선반, 탁상원형톱, 드릴프레스, 전단기 및 제동기를 설치하고 조작한다. 휴대용 동력공구를 사용하여 볼트 및 리벳(Rivet)을 끼울 구멍을 부품과 조립품에 뚫는다. 수평기(水平器:면이 수평한지 측정할 때 사용하는 도구)를 사용하여 구조조립품을 배치한 후 수동공구를 사용하여 조립한다. 날개, 동체 및 꼬리부분 등의 조립부품을 조임새, 볼트 및 너트로 조인다. 조립과 장착상의 문제를 해결하기 위하여 기술자와 의논한다. 착륙장치, 동력장치, 날개 및 방향키를 장착하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"항공기사, 항공산업기사","dJobECd":"1513","dJobECdNm":"[1513]기계·로봇공학 시험원","dJobJCd":"2353","dJobJCdNm":"[2353]기계 및 로봇공학 시험원","dJobICd":"C313","dJobICdNm":"[C313]항공기, 우주선 및 부품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003102:1', '{"dJobCd":"K000003102","dJobCdSeq":"1","dJobNm":"에너지기기시험성능평가원","workSum":"에너지기기에 대한 국제공인인증시험, 정부공인인증시험 및 일반시험을 수행하고 평가한다.","doWork":"에너지기기 및 기술에 대한 안전성 확보와 보급촉진을 위하여 국가를 대신해 에너지기기(태양열 집열기, 태양열 온수기, 태양광발전용 인버터, 결정질 태양전지모듈, 소형풍력발전시스템, 고분자연료전지시스템 등)에 대한 국제공인시험업무를 한다. 고효율에너지기자재 인증, 신·재생에너지설비 인증, 수소저장설비, 친환경건축물(그린빌딩) 인증 등의 공인시험을 한다. 에너지기자재, 자동차, 신·재생에너지설비, 태양광발전소 및 태양광발전설비, 환경기술 및 설비, 열사용기자재 등의 일반시험을 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1513","dJobECdNm":"[1513]기계·로봇공학 시험원","dJobJCd":"2353","dJobJCdNm":"[2353]기계 및 로봇공학 시험원","dJobICd":"M729","dJobICdNm":"[M729]기타 과학기술 서비스업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003501:1', '{"dJobCd":"K000003501","dJobCdSeq":"1","dJobNm":"엔진검사원","workSum":"엔진을 시운전하여 제품사양 및 검사표준과의 일치 여부를 시험·평가한다.","doWork":"검사표준서 및 작업지시서에 따라 검사장치를 준비하고 점검한다. 호이스트를 사용하여 검사할 엔진을 검사장치 위에 올려놓는다. 부품의 조립부품이 규정품인지 육안으로 관찰하여 검사한다. 전원을 연결하고 토크(Torque)와 회전수를 측정하여 엔진의 출력을 시험한다. 이상음 또는 소리의 급격한 변화를 확인한다. 비정상적인 진동이나 진동의 급격한 변화가 없는지 확인한다. 냉각수의 누수를 확인한다. 정지 시 유면계이지 눈금을 확인한다. 운전 중의 유면게이지 변화를 확인한다. 오일 시그널 및 플로우게이지의 정상작동을 확인한다. 연료 공급장치 관련 부품에서 연료 누출이 없는지 확인한다. 냉각수 또는 윤활유의 누수가 없는지 확인한다. 점화플러그의 점화시기를 측정하여 확인한다. 제품의 하자부분을 판정하고 불량부분을 기록하여 보고한다. 불량제품을 표기하여 분리하고 재가공부서로 이송한다. 이상이 없는 제품에 검사필증을 부착하고 시험성적표 등을 첨부한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"자동차정비산업기사, 자동차정비기사","dJobECd":"1513","dJobECdNm":"[1513]기계·로봇공학 시험원","dJobJCd":"2353","dJobJCdNm":"[2353]기계 및 로봇공학 시험원","dJobICd":"C291","dJobICdNm":"[C291]일반 목적용 기계 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004982:1', '{"dJobCd":"K000004982","dJobCdSeq":"1","dJobNm":"열배관정보운용원","workSum":"열배관 감시장치 및 분석장치를 사용하여 열배관 정보를 수집하고 운용한다.","doWork":"대형 컴퓨터와 측량기기를 이용하여 지리정보시스템(GIS)을 구축하고 지중 열수송 배관의 매설위치 및 깊이를 정밀하게 탐사한다. 매설 배관시설에 대한 자료를 축적하고 손괴에 의한 안전사고를 예방하여 시설물을 효율적으로 관리한다. 교체 및 신설되는 열배관시설에 대한 데이터 수정 및 보완을 통해 타 기관의 통합지리정보시스템과 시설물정보를 교환 및 공유한다. 열원시설 도면관리시스템에 의한 자료전산화를 수행하고 관련정보를 제공한다. 지리정보시스템에 관한 신기술을 개발하고 지역 냉·난방사업 시 열배관 공사설계업무를 지원한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"협의","workFunc3":"제어조작","dJobECd":"1513","dJobECdNm":"[1513]기계·로봇공학 시험원","dJobJCd":"2353","dJobJCdNm":"[2353]기계 및 로봇공학 시험원","dJobICd":"D353","dJobICdNm":"[D353]증기, 냉·온수 및 공기조절 공급업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002317:1', '{"dJobCd":"K000002317","dJobCdSeq":"1","dJobNm":"염색설비개발시험원","workSum":"성능이 개선된 염색설비를 대상으로 시험·분석하고 작업표준서를 작성한다.","doWork":"염색설비개발기술자의 지시에 따라 염색설비를 시험·분석하여 작업표준서를 작성한다. 염색가공 중 발생하는 결함의 원인을 분석하여 염색설비개발기술자가 장비를 설계 및 개발하는 데 관련 자료를 제시한다. 염색설비를 가동하여 고장 여부를 판단하고 고장이 발견되면 보수작업을 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"섬유기사, 섬유산업기사","dJobECd":"1513","dJobECdNm":"[1513]기계·로봇공학 시험원","dJobJCd":"2353","dJobJCdNm":"[2353]기계 및 로봇공학 시험원","dJobICd":"C134","dJobICdNm":"[C134]섬유제품 염색, 정리 및 마무리 가공업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002347:1', '{"dJobCd":"K000002347","dJobCdSeq":"1","dJobNm":"자동차성능시험원","workSum":"자동차엔진, 배기가스, 환경적응, 소음, 전파장애 등의 자동차 성능을 시험한다.","doWork":"엔진개발 및 신규자동차의 성능시험을 목적으로 엔진출력 및 엔진내구성을 시험한다. 신규 제작된 자동차의 배기가스가 대기오염 기준 한계치를 넘는지 확인하기 위하여 정해진 시험환경 및 조건에서 시험대상 자동차의 배기가스를 분석한다. 혹한, 혹서 등의 악조건 하에서 자동차의 내구성을 확인하기 위하여 환경적응시험을 한다. 가속주행 시 소음, 배기소음, 경적소음, 실내소음 등을 측정하는 소음측정시험을 한다. 차량에서 방출되는 전자파를 측정하는 전자파방사시험 및 임의의 전자파에 대해 차량이 얼마나 견딜 수 있는지 확인하는 전자파내성시험을 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"자동차정비기사, 자동차산업기사","dJobECd":"1513","dJobECdNm":"[1513]기계·로봇공학 시험원","dJobJCd":"2353","dJobJCdNm":"[2353]기계 및 로봇공학 시험원","dJobICd":"M729","dJobICdNm":"[M729]기타 과학기술 서비스업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002721:1', '{"dJobCd":"K000002721","dJobCdSeq":"1","dJobNm":"자동차휠검사원","workSum":"자동차휠 생산을 위하여 용해, 주조, 탕구(湯口:Ppouring Gate, 주조작업에서 용해된 금속을 주형에 부어 넣는 입구), 열처리, 쇼트, 가공, 기밀시험, 도장공정의 각 요소에서 샘플을 채취하여 품질검사를 실시한다.","doWork":"자동차휠 제조공정의 각 요소에서 샘플을 채취하여 수입검사, 성분분석, 공정검사, X-ray검사, 치수검사, 외관검사, 기밀검사, 내구성검사, 도장시험 및 전처리약품시험검사를 실시한다. 충격시험기를 조작하여 충격으로 가해지는 외력에 대한 저항력을 시험한다. 내구성시험기를 가동하여 코너주행 시 휠에 걸리는 피로에 대한 내구성을 시험한다. 3차원 측정기를 사용하여 휠의 가로, 세로, 높이의 정확한 치수검사를 실시한다. 표면조도측정기를 사용하여 휠외부의 거칠기를 측정한다. 자동밸런스 및 런아웃머신을 사용하여 언밸런스상태(회전체에서 회전 중심과 무게중심이 차이가 나는 상태) 및 완전원형, 좌우대칭상태를 측정한다. 인장시험, 압축시험, 휨시험을 실시한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"자동차정비기사, 자동차산업기사","dJobECd":"1513","dJobECdNm":"[1513]기계·로봇공학 시험원","dJobJCd":"2353","dJobJCdNm":"[2353]기계 및 로봇공학 시험원","dJobICd":"C303","dJobICdNm":"[C303]자동차 신품 부품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001344:1', '{"dJobCd":"K000001344","dJobCdSeq":"1","dJobNm":"저울품질검사원","workSum":"국가별 사양에 따른 저울의 정밀도를 측정하기 위해 정밀측정계기와 수동공구를 사용하여 저울의 품질상태를 검사한다.","doWork":"저울의 국내기준 및 저울을 이용하는 국가에 맞는 국가별 사양을 검토한다. 국내 및 각 국가의 품질기준과 작업표준서를 확인한다. 외주가공부품, 구입부품, 공장가공부품 등이 결함이 있는지 검사한다. 제품설계도, 경도시험기, 마이크로미터, 버니어캘리퍼스, 나사게이지 등의 정밀측정계기를 사용하여 구성품의 경도, 치수, 공차를 검사한다. 피계량물 샘플 또는 테스트용 분동을 이용하여 필요한 정밀도가 나오는지 검사한다. 조립된 저울들의 외양, 검정공차, 신뢰성, 정확성을 점검 및 시험한다. 검사결과를 보고하고 합격품을 출하한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"저울시험원","certLic":"정밀측정산업기사, 정밀측정기능사","dJobECd":"1513","dJobECdNm":"[1513]기계·로봇공학 시험원","dJobJCd":"2353","dJobJCdNm":"[2353]기계 및 로봇공학 시험원","dJobICd":"C291","dJobICdNm":"[C291]일반 목적용 기계 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006142:1', '{"dJobCd":"K000006142","dJobCdSeq":"1","dJobNm":"풍력발전시스템평가원","workSum":"출력성능, 소음특성, 전력품질, 기계하중 등 풍력발전시스템 성능을 평가한다.","doWork":"풍력의 질에 비해 원하는 출력이 충분히 나오는지 분석한다. 목표한 만큼 출력이 나오지 않으면 블레이드, 파워트레인, 기어박스, 발전기, 컨버터를 조절하는 프로그램의 입력값을 조절하여 효율이 좋아지는지 평가한다. 메인샤프트의 피로하중을 측정하여 낙뢰 시 터빈이 정상동작 할 수 있는지 검사한다. 마찰이 생기는 부분에 적절하게 윤활유가 공급됨으로써 유지보수시간을 얼마나 절약할 수 있는지 분석한다. 기어에 전달되는 충격량을 측정하여 기본값과 비교하고 충격량이 크면 설계기술자에게 알려 다른 기어방식을 사용하도록 한다. 우수한 전력품질을 위해 필터가 잘 적용되고 있는지 파악한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"일반기계기사","dJobECd":"1513","dJobECdNm":"[1513]기계·로봇공학 시험원","dJobJCd":"2353","dJobJCdNm":"[2353]기계 및 로봇공학 시험원","dJobICd":"C281","dJobICdNm":"[C281]전동기, 발전기 및 전기 변환ㆍ 공급ㆍ제어 장치 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002205:1', '{"dJobCd":"K000002205","dJobCdSeq":"1","dJobNm":"재난안전연구원","workSum":"자연적, 사회적 재난의 원인을 조사·분석하고 재난을 방지하기 위한 기술, 방법, 설비 및 장비 등을 연구하고 개발한다.","doWork":"재난의 원인을 조사 분석한다. 데이터분석 등을 통해 잠재적 위험을 탐색하고 정책적 제언을 한다. 풍수해, 지진 등 재난을 방지하거나 저감하는 기술, 방법, 장비 등을 연구하고 개발한다. 재난과 관련된 각종 시설의 설계 기준 등 재난 표준화연구를 수행한다. 재난과 관련된 영향평가 및 위험물의 안전도를 평가하고 개선방안을 연구한다. 재난 방지를 위한 각종 교육과 지도업무를 한다. 기타 연구결과 보고서를 작성하고 발표하는 등 연구원들이 수행하는 업무를 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1581","dJobECdNm":"[1581]방재 기술자 및 연구원","dJobJCd":"2361","dJobJCdNm":"[2361]방재 기술자 및 연구원","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;