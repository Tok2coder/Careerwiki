INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005333:1', '{"dJobCd":"K000005333","dJobCdSeq":"1","dJobNm":"금속공학기술자(일반)","workSum":"금속 및 합금의 제조 및 가공방법을 개발하기 위하여 금속의 물리적 특성과 조직적 특성 등을 실험·연구하며 금속분야의 장단기 기술정책을 입안한다.","doWork":"금속제품의 제조, 가공, 합금, 금속조직과 합금시료 등 금속분야에 대한 각종 자료를 수집·분석하여 사업체운영에 맞는 장단기 기술정책을 입안하고 생산기술향상 및 신기술개발을 위한 방안을 연구한다. 산업표준화 및 사내기술규격표준 등의 조정업무를 통하여 생산효율성을 높이고 이에 따른 인허가에 대한 업무를 수행한다. 금속분야에 관련된 각종 설비계획에 기술적 조정업무를 수행한다. 기존설비의 시설용량, 규격 및 형식 등을 검토하여 설비 개선방안을 연구한다. 기존설비와 확장 또는 증설하는 금속설비계획과 상관관계를 종합판단하여 보고한다. 기술 및 설비관리제도를 설정하고 총괄한다. 기술용역의 범위, 제출자료, 훈련계획 등의 기술용역계약에 포함되는 제반 기술사항의 작성·검토업무를 총괄한다. 확장설비건설을 위한 용역의 범위, 건설용원의 소요판단과 조정, 구입사양서 검토 및 조정 등의 기술적 지원업무를 수행한다. 금속기술에 관한 기술적인 사항을 교육한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"금속기술자","connectJob":"금속재료기술자, 금속가공기술자, 금속물리기술자, 금속분석기술자, 금속표면처리기술자, 금속도금기술자, 금속탐상기술자, 도금연구개발자, 금속표면분석전문가","certLic":"표면처리산업기사, 표면처리기술사, 금속재료산업기사, 금속재료기사, 금속재료기술사, 금속재료가공기술사, 금속제련기술사","dJobECd":"1521","dJobECdNm":"[1521]금속·재료공학 기술자 및 연구원","dJobJCd":"2331","dJobJCdNm":"[2331]금속·재료 공학 연구원 및 기술자","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002835:1', '{"dJobCd":"K000002835","dJobCdSeq":"1","dJobNm":"금속품질관리기술자","workSum":"금속제품을 생산하는 공정상의 품질관리를 하며 품질표준을 개선하기 위한 연구, 개발, 시험, 적용 등을 수행한다.","doWork":"생산되는 제품의 품질을 관리한다. 품질관리체계를 수립한다. 연도·분기별 품질관리목표를 설정하며 각 지침을 수립한다. 공정 간의 원료, 소재, 반제품, 완제품 등의 품질에 대해 각각의 검사기준, 검사방법 등을 작성하며 실시한다. 생산되는 제품품질을 종합관리하며 품질의 통계적 관리를 위해 관리도 등을 작성한다. 품질관리업무의 전산화체계를 수립한다. 재료나 제품의 검사·시험·평가방법 및 절차 등에 대한 품질검사기준을 설정하고, 품질검사원을 지도·교육하여 동일한 공정의 품질검사를 실시한다. 목적 외의 부적합이 발생한 제품에 대하여 별도로 구분 관리하고 재검사, 등외처리 등의 조치를 취한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"금속품질보증기술자","certLic":"금속재료산업기사, 금속재료기사, 금속재료기술사, 금속재료가공기술사, 금속제련기술사","dJobECd":"1521","dJobECdNm":"[1521]금속·재료공학 기술자 및 연구원","dJobJCd":"2331","dJobJCdNm":"[2331]금속·재료 공학 연구원 및 기술자","dJobICd":"C241/M701","dJobICdNm":"[C241]1차 철강 제조업 / [M701]자연과학 및 공학 연구개발업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005771:1', '{"dJobCd":"K000005771","dJobCdSeq":"1","dJobNm":"나노공학기술자(일반)","workSum":"나노기술을 활용하여 전자(소자), 바이오, 소재, 공장장비 및 측정기기 등의 개발, 개선, 시험 등에 적용한다.","doWork":"나노미터(십억 분의 일) 단위의 조작을 통해 기존의 전자, 바이오, 소재, 장비 및 기기에 나노기술을 적용한다. 핵심나노소재 기술 및 인간유전체기능연구, 생체기능조절물질개발 등 각종 분야에 걸쳐 연구·개발되고 있는 나노기술(초소형·초경량제품의 개발, 고가소재 성형공정의 단순화, 저에너지의 신공정 개발, 초고속·초고집적·초저소비전력 나노소자개발, 나노단위부품의 설계·제어·측정 및 공정장비 기술개발, 나노기공 다공체복합소재, 광학소재 등)의 방법을 검토하여 적용하고 시험을 통해 개선한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"나노공학엔지니어","connectJob":"나노소자기술자, 나노바이오기술자, 나노소재 기술자, 나노공정기술자","dJobECd":"1521","dJobECdNm":"[1521]금속·재료공학 기술자 및 연구원","dJobJCd":"2331","dJobJCdNm":"[2331]금속·재료 공학 연구원 및 기술자","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003258:1', '{"dJobCd":"K000003258","dJobCdSeq":"1","dJobNm":"나노소자공정개발원","workSum":"나노소자구조 설계에 따른 공정요구사항을 파악하고 공정기술을 개발하며 공정사양을 유지·관리한다.","doWork":"나노소자구조에 대한 적합한 공정사양을 선정한다. 소자구조에 적합한 공정의 핵심사항을 개발 및 결정한다. 나노소자의 사양, 구조 및 설계에 적합한 공정을 개발한다. 인적, 물적 자원을 활용하여 나노소자 생산계획을 수립한다. 공정조건에 맞추어 효율적으로 제품을 생산하고 결과를 검사한다. 기존 소자공정의 효율성을 높이기 위한 주요사항을 개선한다. 공정 및 소자성능을 유지·관리한다. 공정장비의 기능을 숙지한다. 각 공정흐름도(Process Flow)를 파악한다. 공정환경을 관리하고 기록한다. 공정·검사매뉴얼을 개선하고 공정장비의 기능을 향상한다. 새로운 나노소자에 대한 공정검사매뉴얼을 제작하고 공정, 장비의 기능을 설계한다. 나노소자 대량생산을 위한 스케일업(Scale-Up) 공정을 검토한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"나노소자생산기술개발자","dJobECd":"1521","dJobECdNm":"[1521]금속·재료공학 기술자 및 연구원","dJobJCd":"2331","dJobJCdNm":"[2331]금속·재료 공학 연구원 및 기술자","dJobICd":"C339","dJobICdNm":"[C339]그 외 기타 제품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006824:1', '{"dJobCd":"K000006824","dJobCdSeq":"1","dJobNm":"나노소자설계원","workSum":"나노미터 크기의 물질이나 구조가 갖는 독특한 성질과 현상을 이용하여 특정한 목적의 기능을 발휘하는 나노소자를 설계한다.","doWork":"새로운 나노소자의 사양, 구조 및 설계의 핵심사항을 선정한다. 제품성능 및 특성을 정의한다. 회로, 공정(상향식, 하향식), 구조 등에 대한 요구사항을 파악한다. 나노소자의 구조에 따른 부분별 설계도를 작성한다. 부분별로 작성된 소자구조 설계를 취합하여 전체 소자를 설계한다. 소자 설계가 요구조건을 충족하는지 확인하고 검증한다. 소자의 공정, 구조 등 기술적 핵심사양을 설계한다. 나노소자의 종류에 따라 반도체용 나노소자(메모리소자, 로직소자, 광소자), 센서용 나노소자(물리센서, 화학센서, 생체인식센서), 디스플레이용 나노소자(LCD용 나노소자, OLED용 나노소자, Backplane소자, Touch용 나노소자), 에너지용 나노소자(이차전지, 연료전지, 태양전지 등) 등을 개발한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"설치","dJobECd":"1521","dJobECdNm":"[1521]금속·재료공학 기술자 및 연구원","dJobJCd":"2331","dJobJCdNm":"[2331]금속·재료 공학 연구원 및 기술자","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002960:1', '{"dJobCd":"K000002960","dJobCdSeq":"1","dJobNm":"나노소자연구원","workSum":"자체로서 특정한 하나 이상의 기능을 수행하는 나노소자를 연구·개발한다.","doWork":"나노CMOS분야와 나노전자소자분야, 나노자기소자, 나노과소자 등으로 구분되는 나노소자분야에서 기존과 다른 현상 및 원리에 기초한 새로운 공정을 통해 소자를 개발한다. 반도체소자들의 기술적, 제조상의 한계를 극복하고 초고속·초고집적·초저소비전력을 가능케 하는 나노소자를 개발한다. 100 nm 이하 나노스케일의 물질이나 구조를 갖는 독특한 성질의 현상을 이용하여 특정목적의 소재 또는 부품을 만드는 소자를 연구한다. 기타 연구원(일반)들이 수행하는 일반적인 활동을 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1521","dJobECdNm":"[1521]금속·재료공학 기술자 및 연구원","dJobJCd":"2331","dJobJCdNm":"[2331]금속·재료 공학 연구원 및 기술자","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004740:1', '{"dJobCd":"K000004740","dJobCdSeq":"1","dJobNm":"나노소자측정평가기술자","workSum":"나노소자 측정·평가기술을 개발하고 공정 및 소자성능을 유지·관리한다.","doWork":"확립된 측정법을 이용하여 나노소자의 특성을 측정하고 결과를 정리한다. 측정·평가기술의 효율성 저해요소를 조사하여 원인을 파악하고 개선안을 도출하여 측정·평가기술을 개선한다. 나노소자의 성능향상 및 새로운 측정, 평가가 필요한 항목을 조사하여 특성·평가기술을 설계·개발한다. 개발된 측정·평가기술을 표준화한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1521","dJobECdNm":"[1521]금속·재료공학 기술자 및 연구원","dJobJCd":"2331","dJobJCdNm":"[2331]금속·재료 공학 연구원 및 기술자","dJobICd":"C339","dJobICdNm":"[C339]그 외 기타 제품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006455:1', '{"dJobCd":"K000006455","dJobCdSeq":"1","dJobNm":"나노소재설계원","workSum":"기존 소재를 개선하거나 새로운 특성의 나노소재를 설계한다.","doWork":"기존 소재의 특성 개선요구사항, 신소재 개발 필요성을 파악하고 성능분야(전자적, 열적, 기계적 특성)별로 분류·분석한다. 소재개발에 필요한 기술력, 관련 분야의 개발동향, 국제규격 및 규제, 사업성, 기술성, 장래성, 기존 제품과의 연관성 등을 고려하여 신규개발 소재의 타당성을 검토한다. 개발할 나노소재를 선정하고 재료물성의 종류 및 특성을 설정한다. 나노소재의 목표성능을 설정하고 특성항목별로 유효성 검증기술, 분석 및 분석결과 해석기술 등을 개발한다. 기타 연구원(일반)들이 수행하는 일반적인 활동을 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1521","dJobECdNm":"[1521]금속·재료공학 기술자 및 연구원","dJobJCd":"2331","dJobJCdNm":"[2331]금속·재료 공학 연구원 및 기술자","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006042:1', '{"dJobCd":"K000006042","dJobCdSeq":"1","dJobNm":"나노소재연구원(일반)","workSum":"나노기초소재, 나노박막소재, 나노기공체, 나노벌크소재, 나노복합소재 등 정보·전자, 생명과학, 환경·에너지, 자동차 및 항공우주 등 각종 분야에 쓰이는 나노소재를 연구개발한다.","doWork":"생활용품, 환경 관련 제품, 바이오분야 등 각종 분야에 사용되는 탄소나노튜브(CNT), 은나노, 광촉매, 고강도·초경량 소재, 연료전지 소재, 각종 촉매물질, 의학용 소재 등을 연구·개발한다. 나노소재 연구개발을 위해 시험, 측정, 분석 업무를 한다. 기타 연구원(일반)들이 수행하는 일반적인 활동을 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1521","dJobECdNm":"[1521]금속·재료공학 기술자 및 연구원","dJobJCd":"2331","dJobJCdNm":"[2331]금속·재료 공학 연구원 및 기술자","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002630:1', '{"dJobCd":"K000002630","dJobCdSeq":"1","dJobNm":"나노소재제품공정개발원","workSum":"나노소재 제품을 생산할 수 있도록 생산공정기술을 개발하고 적용한다.","doWork":"설명서(매뉴얼)를 통해 나노소재 제조공정 및 장비(반응기, 증착기, Evaporator, Sputter, CVD, Stirred Batch Reactor 등), 검사장비(광학현미경, 입도측정기, SEM, FTIR, XRD 등의 검사장비)및 검사방법을 확인한다. 각 공정흐름도(Process Flow)를 파악한다. 공정환경을 관리하고 기록한다. 공정·검사매뉴얼을 개선하고 공정장비의 기능을 향상한다. 새로운 나노소재에 대한 공정검사매뉴얼을 제작하고 공정·장비의 기능을 설계한다. 나노소재 대량생산을 위한 스케일업(Scale-Up)공정을 검토한다. 양산물에 대한 기기분석(결정학, 투과현미경, 원자현미경 이론, XPS, TEM, STM, AFM)을 한다. 대량생산공정을 표준화하고 표준화된 공정을 플랜트에 적용한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"나노소재생산기술개발자","dJobECd":"1521","dJobECdNm":"[1521]금속·재료공학 기술자 및 연구원","dJobJCd":"2331","dJobJCdNm":"[2331]금속·재료 공학 연구원 및 기술자","dJobICd":"C339","dJobICdNm":"[C339]그 외 기타 제품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004490:1', '{"dJobCd":"K000004490","dJobCdSeq":"1","dJobNm":"나노소재측정평가기술자","workSum":"나노소재의 측정·평가기술을 개발하고 기술표준화를 연구한다.","doWork":"나노소재의 특성에 따른 측정법을 분류·분석한다. 각종 측정법에 따른 특성분석 및 평가기술을 설계하고 문서화한다. XRD(엑스선회절분석기), EELS(전자에너지손실분광법), EDX(에너지분산형 X선 분광법), TEM(투사전자현미경), SEM(주사전자현미경), 측정자동화프로그램 등 측정·평가장비를 운용한다. 측정절차에 따라 측정을 진행하고 측정된 데이터를 분석한다. 측정평가방법의 표준화절차를 수행하고 매뉴얼을 작성한다. 측정·평가기술을 개선하고 새로운 분석법도 개발한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1521","dJobECdNm":"[1521]금속·재료공학 기술자 및 연구원","dJobJCd":"2331","dJobJCdNm":"[2331]금속·재료 공학 연구원 및 기술자","dJobICd":"C339","dJobICdNm":"[C339]그 외 기타 제품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005888:1', '{"dJobCd":"K000005888","dJobCdSeq":"1","dJobNm":"나노연구원(일반)","workSum":"현재의 마이크로기술을 대체할 나노기술을 연구한다.","doWork":"물질을 원자, 분자수준단계에서 물리적 혹은 화학적으로 제어하여 나타나는 새로운 현상 및 특성, 유용한 구조와 기능을 규명·제어·연구한다. 소재, 소자, 바이오기술 등 각종 다른 산업과의 융합기술에 대해 연구·개발한다. 나노구조 물질의 생산 및 나노구조물질과 나노복합재료의 제조, 복잡한 규모의 나노구조물질의 제조 등 단계별 연구를 한다. 높은 물질의 효용성, 경제성, 환경친화성, 기술집약도 등을 목표로 각종 실험 및 연구를 수행한다. 기타연구원(일반)들이 수행하는 일반적인 활동을 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1521","dJobECdNm":"[1521]금속·재료공학 기술자 및 연구원","dJobJCd":"2331","dJobJCdNm":"[2331]금속·재료 공학 연구원 및 기술자","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007129:1', '{"dJobCd":"K000007129","dJobCdSeq":"1","dJobNm":"나노장비개발원","workSum":"나노소재·소자 공정 및 분석 장비를 설계·개발한다.","doWork":"개발하는 장비에 따라 나노소재 및 나노소자의 기본요소를 합성, 증착 및 패터닝하는 공정기술 및 이에 관련된 물성, 소자특성 측정기술 등 나노제품 생산공정·장비기술을 연구한다. 개발할 장비의 사양을 고객(개발진)과 협의하여 선정한다. 설계도구를 활용하여 생산할 생산장비의 외형을 작성한다. 전기장치 및 제어프로그램을 구성하고 도면을 작성한다. 생산장비의 사양이 반영된 모의구성을 설계한다. 세부구조를 설계하고 분석한다. 총괄구조를 설계하고 분석한다. 장비의 종류에 따라 나노공정 및 장비(나노박막 증착, 나노선 합성, 나노점 합성), 나노기반 공정 (나노패터닝, 나노식각, 저가 대면적 공정, 자기조립 기반 공정 등), 나노소재 측정분석(나노 화학구조분석, 나노 광학특성분석, 나노 전기적 특성분석, 나노역학 특성분석 등)장비 등을 개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"설치","certLic":"기계기술사, 일반기계기사","dJobECd":"1521","dJobECdNm":"[1521]금속·재료공학 기술자 및 연구원","dJobJCd":"2331","dJobJCdNm":"[2331]금속·재료 공학 연구원 및 기술자","dJobICd":"C339","dJobICdNm":"[C339]그 외 기타 제품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005175:1', '{"dJobCd":"K000005175","dJobCdSeq":"1","dJobNm":"내열구조세라믹소재기술자","workSum":"내열구조소재 기술을 개발하고 생산공정에 적용한다.","doWork":"내열구조세라믹 생산에 필요한 접합기술(세라믹-금속 접합, 세라믹-세라믹 접합 관련 기술, 접합체와 기계적 접합, 메탈라이징, 공정접합법, 활성금속법, 고압주조접합법, 고상접합법), 가공기술(소성 후 변형제어, 표면 조도 및 결함제거를 위한 절단, 연마, 방전가공, 그린가공기술), 특성평가기술(제조된 세라믹 소재 또는 제조공정평가를 위한 입도, 비표면적, 열전도도, 강도, 경도, 인성, 내마모성 등을 평가하는 기술)을 연구·개발한다. 개발기술을 토대로 생산공정계획을 수립하고 적용한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"설치","certLic":"세라믹기술사","dJobECd":"1521","dJobECdNm":"[1521]금속·재료공학 기술자 및 연구원","dJobJCd":"2331","dJobJCdNm":"[2331]금속·재료 공학 연구원 및 기술자","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003043:1', '{"dJobCd":"K000003043","dJobCdSeq":"1","dJobNm":"내화물연구자","workSum":"내화벽돌, 도가니 등의 내화제품의 제조방식에 관한 시험·분석, 원료분석, 요로의 성능, 연료와 연소효율 등에 관한 연구업무를 수행하고 기술적인 문제를 지도 및 조언한다.","doWork":"내화벽돌, 내화타일, 도가니, 가마 등 내화제품의 개발 및 제조를 위하여 국내외 각종 첨단기술 및 정보를 수집·검토하여 내화물 제조기술연구, 내화물 제조테스트, 제조실험, 제품분석 등을 한다. 내화제품 개발에 필요한 내화제품별 기능, 제조공정방법, 연소효율과 관련한 연구와 실험 등의 업무를 수행한다. 제품별 원료의 종류, 원료의 최적조합비율, 물성, 품질조건 등을 점검하고 시험하기 위한 기준을 설정한다. 여러 실험을 거쳐 어떤 재료가 어떤 양으로 섞일 때 가장 좋은지 최적의 조성을 구한다. 신제품 개발과 내화물 특성개발을 위한 자료로 활용하기 위해 실험결과를 분석하고 기록한다. 내화물의 생산관리 작업기준을 설정한다. 입고된 원료나 소성된 내화물의 견본을 채취하여 각종 실험(수분함유도, 내화도, 소성실험, 내침식성, 균열도·비중, 무게 등)을 하고, 결과치와 검사규격의 표준치를 비교한다. 신제품 개발자료로 활용하기 위해 시간에 따른 시편의 상태변화 등을 기록·정리한다. 측정에 사용된 시료를 보관하거나 폐기하며 측정장치 및 기구는 점검 및 청소를 한다. 개발한 내화물제품의 품질인증 및 기타 인허가사항을 신청한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"내화물연구원","certLic":"세라믹기술사","dJobECd":"1521","dJobECdNm":"[1521]금속·재료공학 기술자 및 연구원","dJobJCd":"2331","dJobJCdNm":"[2331]금속·재료 공학 연구원 및 기술자","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004413:1', '{"dJobCd":"K000004413","dJobCdSeq":"1","dJobNm":"노재기술자","workSum":"노재(爐材)의 기술개발과 개선을 위한 방안을 연구하고 현장적용을 위한 기술업무를 수행한다.","doWork":"내화물 사용에 따른 증감요인, 해외선진제철소의 사용실적 등을 조사하고 종합·분석하여 노재부문 중장기계획수립 및 기술발전방향을 제시한다. 제철공정변화 등에 대응한 신내화물 및 신소재 연구과제에 대한 연구계획서를 검토하고 이에 따른 실적관리, 연구결과평가 등을 통하여 현장 활용방안을 강구하고 개선방안을 제안한다. 노재부문의 문제점 및 현황을 분석하고 선진노재기술동향 조사 및 적용으로 이를 개선한다. 사업체의 철강 생산능력을 검토하여 중장기 생산계획에 따른 안정조업을 도모하기 위한 내화물의 수급계획을 수립한다. 내화물 실시공법 및 보수기술 도입을 검토하고, 내화물축조 및 해체장비의 기계화 등 노재수리장비의 합리화를 추진한다. 노재부문 교육훈련에 필요한 제반 기술사항을 작성한다. 해외제철소 및 내화물 제조업체 등과 기술교류회의를 개최하여 신기술정보를 입수하고 사내에 전파한다. 사내 관련 설비의 현장관찰과 자료조사를 행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"세라믹기술사","dJobECd":"1521","dJobECdNm":"[1521]금속·재료공학 기술자 및 연구원","dJobJCd":"2331","dJobJCdNm":"[2331]금속·재료 공학 연구원 및 기술자","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001641:1', '{"dJobCd":"K000001641","dJobCdSeq":"1","dJobNm":"도자기제품개발원","workSum":"각종 도자기제품을 연구·개발한다.","doWork":"가정용도자기, 위생용도자기, 산업용도자기, 기타 일반도자기 제품에 대한 자료와 정보를 수집한다. 소지토배합, 포밍공정, 건조, 1차소성, 페인팅공정, 유약입히기, 재벌구이(2차소성)공정 등의 시간 및 비율을 산정하고 유약개발을 위한 최적의 조합비율을 개발한다. 신제품개발을 위하여 소지토를 저울로 무게를 재서 소정의 비율로 배합한다. 배합원료를 분쇄기로 분쇄하고 시편을 만든다. 유약의 조합비를 산출하여 조합하고 시편에 도포한다. 시유한 시편을 가마에서 소성한다. 시편의 색상·광택·기계적 강도·내구성·투광성 등의 제품특성을 조사하여 품질규격과 비교한다. 제품특성의 개선 또는 신제품개발자료로 활용할 수 있도록 실험결과를 분류·정리한다. 실험을 통해 확정된 유약이나 안료의 배합비율과 소성조건을 작업자에게 알리거나 공정을 개선한다. 생산제품을 시험하여 제품의 특성이나 품질규격이 기준과 일치하는지 확인한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"도자기연구원","connectJob":"도기제품제조기술자, 자기제품제조기술자","certLic":"세라믹기술사","dJobECd":"1521","dJobECdNm":"[1521]금속·재료공학 기술자 및 연구원","dJobJCd":"2331","dJobJCdNm":"[2331]금속·재료 공학 연구원 및 기술자","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004096:1', '{"dJobCd":"K000004096","dJobCdSeq":"1","dJobNm":"무기재료코팅연구원","workSum":"세라믹재료에 고경도, 고저항, 고열전도도 등의 기능성 세라믹 물질을 코팅(Coating)하여 표면내마모성, 저항, 열전도도 등의 기능을 높이기 위한 연구를 수행한다.","doWork":"모재(母材)조성분석 및 외관 부스러기검사 등을 실시한다. 모재표면을 알칼리 및 알코올액으로 도포한 후 초음파로 세척한다. 코팅반응기 내로 코팅할 모재를 일정하게 장입한다. 도입 반응가스 유량, 압력, 온도 등의 코팅조건을 설정한다. 모재가 코팅될 수 있도록 반응기용 쟁반을 반응기로 밀봉하고 가열기로 덮는다. 가스저장실 내의 사용할 반응가스량을 확인한다. 설정된 프로그램대로 코팅공정이 진행되는지를 확인한다. 코팅반응기와 가열기를 제거하고 반응기용 쟁반 내에 장입된 모재를 빼낸다. 코팅품의 두께, 색상, 미세구조를 관찰하고, 코팅 소재의 요구 기능에 부합하는 절삭시험, 전기 및 열전도도 평가 등을 실시한다. 기타 연구원(일반)들이 수행하는 일반적인 활동을 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"세라믹기술사","dJobECd":"1521","dJobECdNm":"[1521]금속·재료공학 기술자 및 연구원","dJobJCd":"2331","dJobJCdNm":"[2331]금속·재료 공학 연구원 및 기술자","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002645:1', '{"dJobCd":"K000002645","dJobCdSeq":"1","dJobNm":"반도체가스재료개발연구원","workSum":"반도체소자·공정·재료 기술로드맵 및 고객 요구성능을 이해하고, 소자제조공정을 위한 가스재료를 연구·개발하여 반도체소자의 미세화 및 고집적화를 지원한다.","doWork":"반도체 식각, 이온주입, 확산, 화학기상증착 및 가스재료 공정연구원과 공동으로 재료개발목표를 수립하고, 소재, 공정, 장치 및 장비기술 연구·개발활동을 관리한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 다양한 가스재료를 분석, 시험평가, 검증하고, 최적화하는 연구·개발활동을 관리한다. 가스재료 개발과정에는 내부 및 고객사 생산라인 응용에서 최고의 품질 및 생산성을 고려한 재료기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체재료개발연구원","connectJob":"반도체불활성가스개발연구원, 반도체공정가스개발연구원, 반도체전구체개발연구원","dJobECd":"1521","dJobECdNm":"[1521]금속·재료공학 기술자 및 연구원","dJobJCd":"2331","dJobJCdNm":"[2331]금속·재료 공학 연구원 및 기술자","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003805:1', '{"dJobCd":"K000003805","dJobCdSeq":"1","dJobNm":"반도체가스재료공정연구원","workSum":"반도체소자·공정 기술로드맵 및 고객 요구성능을 이해하고, 소재, 부품, 장치, 장비기술 기반으로 가스재료 공정기술을 연구·개발하여 반도체 미세화 및 고집적화를 지원한다.","doWork":"반도체 식각, 이온주입, 확산, 화학기상증착 및 가스재료개발 연구원과 공동으로 재료개발목표를 수립하고, 소재, 공정, 장치 및 장비기술 연구·개발활동을 수행한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 다양한 소재, 부품, 장치, 장비 및 공정기술을 분석, 시험평가, 검증하고, 최적화하는 연구·개발활동을 관리한다. 가스재료 공정개발과정에는 내부 및 고객사 생산라인 응용에서 최고의 품질 및 생산성을 고려한 소재, 부품, 장치, 징비 및 공정기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체공정연구원","connectJob":"반도체불활성가스공정연구원, 반도체공정가스공정연구원, 반도체전구체공정연구원","dJobECd":"1521","dJobECdNm":"[1521]금속·재료공학 기술자 및 연구원","dJobJCd":"2331","dJobJCdNm":"[2331]금속·재료 공학 연구원 및 기술자","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004283:1', '{"dJobCd":"K000004283","dJobCdSeq":"1","dJobNm":"반도체광학재료개발연구원","workSum":"반도체소자·공정·재료 기술로드맵 및 고객 요구성능을 이해하고, 소자제조 공정·장비응용을 위한 광학재료를 연구·개발하여 반도체소자의 미세화 및 고집적화를 지원한다.","doWork":"반도체 사진현상, 식각, 이온주입, 박막, 연마, 소자웨이퍼검사, 절단 및 광학재료 공정연구원과 공동으로 재료개발목표를 수립하고, 소재, 공정, 장치 및 장비기술 연구·개발활동을 관리한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 다양한 광학재료를 분석, 시험평가, 검증하고, 최적화하는 연구·개발활동을 관리한다. 광학재료 개발과정에는 내부 및 고객사 생산라인 응용에서 최고의 품질 및 생산성을 고려한 재료기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체재료연구원","connectJob":"반도체레이저개발연구원, 반도체램프개발연구원","dJobECd":"1521","dJobECdNm":"[1521]금속·재료공학 기술자 및 연구원","dJobJCd":"2331","dJobJCdNm":"[2331]금속·재료 공학 연구원 및 기술자","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006823:1', '{"dJobCd":"K000006823","dJobCdSeq":"1","dJobNm":"반도체광학재료공정연구원","workSum":"반도체소자·공정 기술로드맵 및 고객 요구성능을 이해하고, 소재, 부품, 장치, 장비기술 기반으로 공학재료 공정기술을 연구·개발하여 반도체 미세화 및 고집적화를 지원한다.","doWork":"반도체 사진현상, 식각, 이온주입, 박막, 연마, 소자웨이퍼검사, 절단 및 광학재료개발 연구원과 공동으로 재료개발목표를 수립하고, 소재, 공정, 장치 및 장비기술 연구·개발활동을 수행한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 다양한 소재, 부품, 장치, 장비 및 공정기술을 분석, 시험평가, 검증하고, 최적화하는 연구·개발활동을 관리한다. 광학재료 공정개발과정에는 내부 및 고객사 생산라인 응용에서 최고의 품질 및 생산성을 고려한 소재, 부품, 장치, 장비 및 공정기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체공정연구원","connectJob":"반도체레이저공정연구원, 반도체램프공정연구원","dJobECd":"1521","dJobECdNm":"[1521]금속·재료공학 기술자 및 연구원","dJobJCd":"2331","dJobJCdNm":"[2331]금속·재료 공학 연구원 및 기술자","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004897:1', '{"dJobCd":"K000004897","dJobCdSeq":"1","dJobNm":"반도체금속재료개발연구원","workSum":"반도체소자·공정·재료 기술로드맵 및 고객 요구성능을 이해하고, 소자제조공정을 위한 금속재료를 연구·개발하여 반도체소자의 미세화 및 고집적화를 지원한다.","doWork":"반도체 금속막증착, 칩접합 및 금속재료 공정연구원과 공동으로 재료개발목표를 수립하고, 소재, 공정, 장치 및 장비기술 연구·개발활동을 관리한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 다양한 금속 재료를 분석, 시험평가, 검증하고, 최적화하는 연구·개발활동을 관리한다. 금속재료 개발과정에는 내부 및 고객사 생산라인 응용에서 최고의 품질 및 생산성을 고려한 재료기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체재료개발연구원","connectJob":"반도체타깃개발연구원","dJobECd":"1521","dJobECdNm":"[1521]금속·재료공학 기술자 및 연구원","dJobJCd":"2331","dJobJCdNm":"[2331]금속·재료 공학 연구원 및 기술자","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005809:1', '{"dJobCd":"K000005809","dJobCdSeq":"1","dJobNm":"반도체금속재료공정연구원","workSum":"반도체소자·공정 기술로드맵 및 고객 요구성능을 이해하고, 소재, 부품, 장치, 장비기술 기반으로 금속재료 공정기술을 연구·개발하여 반도체 미세화 및 고집적화를 지원한다.","doWork":"반도체 금속막증착, 칩접합 및 금속재료개발 연구원과 공동으로 재료개발목표를 수립하고, 소재, 공정, 장치 및 장비기술 연구·개발활동을 수행한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 다양한 소재, 부품, 장치, 장비 및 공정기술을 분석, 시험평가, 검증하고, 최적화하는 연구·개발활동을 관리한다. 금속재료 공정개발과정에는 내부 및 고객사 생산라인 응용에서 최고의 품질 및 생산성을 고려한 소재, 부품, 장치, 징비 및 공정기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체공정연구원","connectJob":"반도체타깃개발연구원","dJobECd":"1521","dJobECdNm":"[1521]금속·재료공학 기술자 및 연구원","dJobJCd":"2331","dJobJCdNm":"[2331]금속·재료 공학 연구원 및 기술자","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004762:1', '{"dJobCd":"K000004762","dJobCdSeq":"1","dJobNm":"반도체웨이퍼재료개발연구원","workSum":"반도체소자·공정·재료 기술로드맵 및 고객 요구성능을 이해하고, 소자제조공정을 위한 웨이퍼재료를 연구·개발하여 반도체소자의 미세화 및 고집적화를 지원한다.","doWork":"반도체소자 및 공정연구원과 공동으로 재료개발 목표를 수립하고, 소재, 공정, 장치 및 장비기술 연구·개발활동을 관리한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 다양한 웨이퍼 재료를 분석, 시험평가, 검증하고, 최적화하는 연구·개발활동을 관리한다. 웨이퍼재료 개발과정에는 생산라인 응용에서 최고의 품질 및 생산성을 고려한 재료기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체재료개발연구원","connectJob":"반도체실리콘웨이퍼개발연구원, 사파이어웨이퍼개발연구원, SiC웨이퍼개발연구원","dJobECd":"1521","dJobECdNm":"[1521]금속·재료공학 기술자 및 연구원","dJobJCd":"2331","dJobJCdNm":"[2331]금속·재료 공학 연구원 및 기술자","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002298:1', '{"dJobCd":"K000002298","dJobCdSeq":"1","dJobNm":"반도체웨이퍼재료공정연구원","workSum":"반도체소자·공정 기술로드맵 및 고객 요구성능을 이해하고, 소재, 부품, 장치, 장비기술 기반으로 웨이퍼재료 공정기술을 연구·개발하여 반도체 미세화 및 고집적화를 지원한다.","doWork":"반도체 계측검사, 웨이퍼재료개발연구원과 공동으로 웨이퍼 제조공정목표를 수립하고, 소재, 부품, 장치, 장비 및 공정기술 연구·개발활동을 수행한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 다양한 소재, 부품, 장치, 장비 및 공정기술을 시험평가, 검증하고, 최적화하는 연구·개발활동을 단독 또는 공동으로 수행한다. 웨이퍼재료 공정개발과정에는 생산라인 이관 시 최고의 품질 및 생산성을 고려한 소재, 부품, 장치, 장비 및 공정기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체공정연구원","connectJob":"반도체실리콘웨이퍼공정연구원, 사파이어웨이퍼공정연구원, SiC웨이퍼공정연구원","dJobECd":"1521","dJobECdNm":"[1521]금속·재료공학 기술자 및 연구원","dJobJCd":"2331","dJobJCdNm":"[2331]금속·재료 공학 연구원 및 기술자","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005860:1', '{"dJobCd":"K000005860","dJobCdSeq":"1","dJobNm":"반도체화학약품재료개발연구원","workSum":"반도체소자·공정·재료 기술로드맵 및 고객 요구성능을 이해하고, 소자제조공정을 위한 화학약품재료를 연구·개발하여 반도체소자의 미세화 및 고집적화를 지원한다.","doWork":"반도체 사진현상, 세정, 연마, 연삭, 몰딩 및 화학약품재료 공정연구원과 공동으로 재료개발목표를 수립하고, 소재, 공정, 장치 및 장비기술 연구·개발활동을 관리한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 다양한 화학약품재료를 분석, 시험평가, 검증하고, 최적화하는 연구·개발활동을 관리한다. 화학약품재료 개발과정에는 내부 및 고객사 생산라인 응용에서 최고의 품질 및 생산성을 고려한 재료기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체재료개발연구원","connectJob":"반도체감광막개발연구원, 반도체세정액개발연구원, 반도체슬러리개발연구원","dJobECd":"1521","dJobECdNm":"[1521]금속·재료공학 기술자 및 연구원","dJobJCd":"2331","dJobJCdNm":"[2331]금속·재료 공학 연구원 및 기술자","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002932:1', '{"dJobCd":"K000002932","dJobCdSeq":"1","dJobNm":"반도체화학약품재료공정연구원","workSum":"반도체소자·공정 기술로드맵 및 고객 요구성능을 이해하고, 소재, 부품, 장치, 장비기술 기반으로 화학약품재료 공정기술을 연구·개발하여 반도체 미세화 및 고집적화를 지원한다.","doWork":"반도체 사진현상, 세정, 연마, 연삭, 몰딩 및 화학약품재료개발연구원과 공동으로 재료개발목표를 수립하고, 소재, 공정, 장치 및 장비기술 연구·개발활동을 수행한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 다양한 소재, 부품, 장치, 장비 및 공정기술을 분석, 시험평가, 검증하고, 최적화하는 연구·개발활동을 관리한다. 화학약품재료 공정개발과정에는 내부 및 고객사 생산라인 응용에서 최고의 품질 및 생산성을 고려한 소재, 부품, 장치, 징비 및 공정기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체공정연구원","connectJob":"반도체감광막공정연구원, 반도체세정액공정연구원, 반도체슬러리공정연구원","dJobECd":"1521","dJobECdNm":"[1521]금속·재료공학 기술자 및 연구원","dJobJCd":"2331","dJobJCdNm":"[2331]금속·재료 공학 연구원 및 기술자","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006712:1', '{"dJobCd":"K000006712","dJobCdSeq":"1","dJobNm":"세라믹소재연구원","workSum":"세라믹 소재를 합성, 성형 소결하여 특정 성능을 발현하는 소재를 만드는 기술을 연구 개발한다.","doWork":"세라믹 성능 중 개발하고자 하는 특성과 개발 목표 수준을 명확히 정의한다. 문헌 조사를 통하여 실현 가능한 소재 조성물을 선정한다. 선택된 조성물을 합성하기 위한 합성방법(고상반응법, 침전법, 수열합성법 등)을 선정하고 선정된 방법에 따라 합성 공정을 set-up 한다. 합성한 세라믹 원료를 이용하여 평가 시편을 제조하기 위한 공정(성형, 소결, 시편가공, 특성평가)을 확립한다. 선택된 조성물계의 미세한 조성변화나 특정 첨가물의 혼합 등의 방법으로 요구하는 특성의 성능을 만족하는 조성을 확보하기 위한 다양한 조성물 변화 실험을 실시하여 조성 변화에 따른 특성을 평가하고 최적의 조성물을 확정한다. 최적의 조성물에 대한 재현성과 신뢰성을 평가 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"바이오세라믹연구원, 광학세라믹연구원, 전기전자세라믹연구원, 구조세라믹연구원","certLic":"세라믹기술사","dJobECd":"1521","dJobECdNm":"[1521]금속·재료공학 기술자 및 연구원","dJobJCd":"2331","dJobJCdNm":"[2331]금속·재료 공학 연구원 및 기술자","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006812:1', '{"dJobCd":"K000006812","dJobCdSeq":"1","dJobNm":"시멘트품질분석연구원","workSum":"시멘트 제품의 품질규격 유지, 생산비용 절감, 우수한 제품의 개발과 생산을 위하여 원료와 제품의 시험·분석결과를 종합하고 생산공정에 대한 연구·분석한다.","doWork":"시멘트 원료와 제품의 시험·분석결과를 검토한다. 제품생산·원료의 채굴, 운반, 저장, 건조, 분쇄, 혼합, 조립, 소성, 냉각, 집진, 포장 등의 제조공정과 제품분석결과를 토대로 효율적인 제조방식을 개발한다. 시멘트 품질규격을 유지하도록 작업표준을 개발한다. 기타 연구원(일반)들이 수행하는 일반적인 활동을 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"시멘트개발연구원","certLic":"세라믹기술사, 화공기사, 화공기술사","dJobECd":"1521","dJobECdNm":"[1521]금속·재료공학 기술자 및 연구원","dJobJCd":"2331","dJobJCdNm":"[2331]금속·재료 공학 연구원 및 기술자","dJobICd":"C233","dJobICdNm":"[C233]시멘트, 석회, 플라스터 및 그 제품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007191:1', '{"dJobCd":"K000007191","dJobCdSeq":"1","dJobNm":"위변조방지기술개발원","workSum":"지폐·유가증권·여권 등의 위·변조 방지를 위한 기술, 물질 및 요소를 개선·개발하기 위한 제반 연구업무를 수행한다.","doWork":"위·변조에 사용되는 칼라복사기, 칼라프린터 등의 기술 및 기기의 동향을 분석한다. 광학적인 특성을 이용한 위변조 방지기술인 홀로그램, 시변광잉크, 위변조방지용지, 요판잠상기법(비스듬히 볼 경우에만 보이는 그림), 미세문자, 복사방지마크, 2차원 바코드, 배경무늬, 은화(숨은그림), 형광색사(형광을 발광하는 가느다란 섬유를 용지에 삽입), 앞뒤판 맞춤인쇄기법 등을 개발한다. 개발된 기술이나 잉크와 같은 제품에 대하여 레이저기기 등 시험기구를 이용하여 시험한다. 시험결과를 수학적 또는 과학적인 분석결과를 통하여 해석과 재현성이 가능한 제품을 개발하기 위하여 연구한다. 특수기능성잉크를 위변조 방지기술에 적용 실제인쇄에 응용한다. 시험용 제품을 제작하여 시험한다. 위변조 식별기술 및 식별기기에 대해 연구하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"화폐위변조방지물질개발원, 화폐위변조방지요소개발원","dJobECd":"1521","dJobECdNm":"[1521]금속·재료공학 기술자 및 연구원","dJobJCd":"2331","dJobJCdNm":"[2331]금속·재료 공학 연구원 및 기술자","dJobICd":"C181","dJobICdNm":"[C181]인쇄 및 인쇄관련 산업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002475:1', '{"dJobCd":"K000002475","dJobCdSeq":"1","dJobNm":"유리기술자","workSum":"유리원료의 화학성분분석, 유리제조기술연구, 유리제조실험, 유리제품분석 등의 연구를 하거나 유리제조를 위한 기술지도 및 감독을 한다.","doWork":"유리의 개발 및 제조를 위한 각종 첨단기술 및 정보를 수집하고 검토한다. 유리제품 개발에 필요한 유리제품별 기능, 제조공정방법, 재생과 관련한 연구와 실험 등의 업무를 수행한다. 제품별 원료의 종류, 원료의 최적조합비율, 물성, 품질조건 등을 점검하고 테스트하기 위한 기준을 설정한다. 여러 실험을 거쳐 어떤 재료가 어떤 양으로 섞일 때 가장 좋은지 최적의 유리조성을 구한다. 실험결과를 분석하고 기록하여 신제품 개발과 유리특성개발을 위한 자료로 활용한다. 유리제품 생산공정인 배합, 용해, 급냉, 서냉, 검사, 가공, 강화, 세척, 포장 등의 생산관리작업기준을 설정한다. 유리용융로의 기술적인 관리를 정기적으로 한다. 유리공정상의 단위공정설비시설의 시방을 하며 관리한다. 개발한 유리제품의 품질인증 및 기타 인허가사항을 신청한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"고온|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"유리기술연구원","connectJob":"유리섬유기술자","dJobECd":"1521","dJobECdNm":"[1521]금속·재료공학 기술자 및 연구원","dJobJCd":"2331","dJobJCdNm":"[2331]금속·재료 공학 연구원 및 기술자","dJobICd":"C231","dJobICdNm":"[C231]유리 및 유리제품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004795:1', '{"dJobCd":"K000004795","dJobCdSeq":"1","dJobNm":"유리소재(조성)연구원","workSum":"다양한 유리에서 요구되는 특정 특성을 향상하기 위한 신조성 유리 조성물을 실험하고 연구한다.","doWork":"개발하고자 하는 특성에 부합하는 조성에 대한 문헌조사를 수행하고 그 결과에 따라 최적의 공급 원료를 조사한다. 각 원료의 혼합비율을 결정하고 용융실험을 진행한다. 용융시편을 이용하여 원하는 특성(기계적 강도, 열적 성질, 전기적 성질, 화학석 성질, 광학적 성질 등)을 평가한다. 혼합비율의 변화와 특성 향상을 위한 첨가제 추가 등의 추가적인 실험을 통하여 최적의 신조성비를 결정한다. 실험 결과를 정리하여 기록하고 양산 공정에 적용하는 업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"고온|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1521","dJobECdNm":"[1521]금속·재료공학 기술자 및 연구원","dJobJCd":"2331","dJobJCdNm":"[2331]금속·재료 공학 연구원 및 기술자","dJobICd":"C231/M701","dJobICdNm":"[C231]유리 및 유리제품 제조업 / [M701]자연과학 및 공학 연구개발업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005120:1', '{"dJobCd":"K000005120","dJobCdSeq":"1","dJobNm":"인조흑연제조기술자","workSum":"인조흑연 제조공정을 설계·운용한다.","doWork":"인조흑연을 생산하기 위하여 제품사양에 적합한 원재료(석탄계, 석유계, 등방성, 이방성 코크스)를 선정하고 물성을 측정한다. 바인더 피치(석탄계, 석유계 첨가제)의 종류를 파악하고 분석한다. 생산할 인조흑연제품의 종류에 따라 성형방법을 선정하고 원료규격과 성형조건을 결정한다. 바인더 피치를 혼합한다. 소성설비와 공정을 운용한다. 함침공정(소성품의 공극에 함침 피치를 채운 후 재소성하여 소성품의 밀도를 높이는 공정)을 운용한다. 탄화로를 운용하여 원하는 특성의 흑연제품을 제조한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"위험내재|고온|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"화공기사, 화공기술사, 화학분석기사","dJobECd":"1521","dJobECdNm":"[1521]금속·재료공학 기술자 및 연구원","dJobJCd":"2331","dJobJCdNm":"[2331]금속·재료 공학 연구원 및 기술자","dJobICd":"C239","dJobICdNm":"[C239]기타 비금속 광물제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006733:1', '{"dJobCd":"K000006733","dJobCdSeq":"1","dJobNm":"자기탐상기술자","workSum":"강자성 특성의 피검체를 자화하여 표면 또는 표면직하의 결함의 존재 및 위치를 찾아 제품의 품질관리 및 품질보증 업무를 수행한다.","doWork":"자화 및 탈자 장비를 점검한 후 피검체 표면의 청결상태와 조명 장치를 점검한다. 피검체에 마그네틱요크(Magnetic Yoke) 또는 코일(Coil)에 자속(Magnetic Flux)을 발생시켜 자화시킨 후자분을 시편 표면에 살포한다. 자분의 지시 모양을 확인하고 배열상태를 확인하고 전원을 끊어 자화를 중지한다. 결함부분에 집결된 자분의 양과 집결상태를 보고 판독한 후 결과보고서를 작성한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"비파괴검사기술자","certLic":"자기비파괴검사기능사, 자기비파괴검사산업기사, 자기비파괴검사기사, 비파괴검사기술사","dJobECd":"1521","dJobECdNm":"[1521]금속·재료공학 기술자 및 연구원","dJobJCd":"2331","dJobJCdNm":"[2331]금속·재료 공학 연구원 및 기술자","dJobICd":"M729","dJobICdNm":"[M729]기타 과학기술 서비스업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003253:1', '{"dJobCd":"K000003253","dJobCdSeq":"1","dJobNm":"자동차휠공정관리자","workSum":"자동차휠 생산을 위하여 용해, 주조, 탕구(湯口:Pouring Gate, 주조작업에서용해된 금속을 주형에 부어 넣는 입구), 열처리, 쇼트, 가공, 기밀시험, 도장 공정을 점검하고 작업자를 관리·감독한다.","doWork":"생산계획에 따라 원부재료의 재고를 파악하고 생산공정에 인원을 배치한다. 생산할 제품의 품목, 수량을 점검한다. 급속용해로에 투입할 원료(주로 알루미늄)의 양을 산정하고 용해온도, 시간을 정하고 용해로 가동을 지시한다. 압축공기를 사용하는 저압주조기에 알루미늄 용탕을 주입하여 휠모양으로 주조하도록 지시한다. 주조 시 발생되는 주입구부의 압탕부(재료를 주입하면서 생긴 흠)를 탕구프레스(탕구제거용 유압장치)로 제거하도록 한다. 휠의 모양이 완성되면 연속열처리로를 가동하여 표면처리하고 쇼트기로 표면처리하도록 지시한다. 검사부서의 검사결과를 토대로 결함부를 확인한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","dJobECd":"1521","dJobECdNm":"[1521]금속·재료공학 기술자 및 연구원","dJobJCd":"2331","dJobJCdNm":"[2331]금속·재료 공학 연구원 및 기술자","dJobICd":"C303","dJobICdNm":"[C303]자동차 신품 부품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006239:1', '{"dJobCd":"K000006239","dJobCdSeq":"1","dJobNm":"전기방식기술자","workSum":"발전소, 항만, 화학단지의 토중, 수중, 해수 중에 설치되어 있는 철구조물의 부식을 방지하기 위하여 토양과 물의 전기적인 저항가를 접지저항측정기로 측정·조사하고 양극설치에 따른 작업순서와 방법을 설계한다.","doWork":"토양의 저항값을 측정하기 위하여 접지저항측정기를 철구조물 설치위치에 장착하고 계기를 작동시켜 수치를 확인한다. 대상 구조물의 상황, 환경조건, 방식공법의 기대이용 연수, 시공법, 경제성을 고려하여 방식공법을 선정한다. 전기방식을 대상으로 하는 강재표면적과 소요방식전류를 산출한다. 측정된 토양저항값에 따라 철부식을 방지하기에 알맞은 양극의 수량을 계산하고 양극설치에 따른 방법, 작업절차, 위치 등을 설치도면에 그린다. 양극설치에 따른 시방서를 작성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"전기방식기사","certLic":"표면처리산업기사, 표면처리기사","dJobECd":"1521","dJobECdNm":"[1521]금속·재료공학 기술자 및 연구원","dJobJCd":"2331","dJobJCdNm":"[2331]금속·재료 공학 연구원 및 기술자","dJobICd":"F412","dJobICdNm":"[F412]토목 건설업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005104:1', '{"dJobCd":"K000005104","dJobCdSeq":"1","dJobNm":"제강설비기술자","workSum":"금속제품을 생산하기 위하여 확장 또는 증설하는 관련 설비의 각종 자료를 수집·분석·검토하여 설비의 설비계획, 공정계획, 배치계획 및 설비사양 등을 작성하며 기존 설비의 개선방안을 연구한다.","doWork":"확장 또는 증설하는 설비의 용량, 투자시점, 설비형식, 소요예산 등을 종합파악하여 타당성을 검토한다. 설비기본계획 및 종합기술계획을 세운다. 설비의 기본수급계획, 공정계획, 배치계획 등을 세우고 각 설비의 투자비를 산정하여 소요예산을 편성한다. 설비계획에 의거 단위설비사양을 작성하고, 설비사양 계약협상 시 기술적인 협조업무를 수행한다. 설비공급사로부터 제출되는 설비 관련 도면을 검토·승인한다. 시험 및 시운전 시 개선사항을 발췌하여 차기 설비계획에 반영한다. 설비의 작업순서, 공사품질 등을 고려하여 종합공정계획서를작성한다. 기존설비의 용량·규격·형식 등을 검토하여 설비개선방안을 연구한다. 사업계획서, 재무계획서 작성에 필요한 각종 자료를 수집·분석한다. 기존 설비와 확장 또는 증설되는 설비와의 관련성을 종합적으로 분석한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workEnv":"위험내재|소음·진동|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"금속가공기술사, 금속재료기술사, 금속재료기사, 금속제련기술사","dJobECd":"1521","dJobECdNm":"[1521]금속·재료공학 기술자 및 연구원","dJobJCd":"2331","dJobJCdNm":"[2331]금속·재료 공학 연구원 및 기술자","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004248:1', '{"dJobCd":"K000004248","dJobCdSeq":"1","dJobNm":"주화금형연구원","workSum":"주화제품의 제조에 사용되는 금형소재, 열처리방법, 표면처리방법, 극인(極印:주화에 도안이나 액면가, 발행연도 등을 찍어 새김)형상 등을 연구한다.","doWork":"금형소재, 열주화제품의 크기, 소재, 심도(Depth) 등에 따라 타발금형, 에칭(Etching)금형, 문자각인금형, 극인, 칼라, 극인압사금형 등의 사용목적에 적합한 소재를 선정하고 금형조건을 설계한다. 선정된 소재의 경도, 인장강도, 충격강도 등의 물리적 성질을 분석한다. 전자현미경으로 조직 및 내부결함 등을 분석한다. 분석결과를 종합하여 내충격성, 내마모성이 우수한 금속열처리 및 표면처리방법을 연구한다. 기타 연구원(일반)들이 수행하는 일반적인 활동을 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"금속재료산업기사, 금속재료기사, 금속재료기술사","dJobECd":"1521","dJobECdNm":"[1521]금속·재료공학 기술자 및 연구원","dJobJCd":"2331","dJobJCdNm":"[2331]금속·재료 공학 연구원 및 기술자","dJobICd":"C331","dJobICdNm":"[C331]귀금속 및 장신용품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002811:1', '{"dJobCd":"K000002811","dJobCdSeq":"1","dJobNm":"주화소재개발원","workSum":"위조방지와 주화제품의 품위를 향상시키기 위하여 금속합금 및 비금속소재를 연구·개발한다.","doWork":"주괴(Ingot)를 압연, 타발, 소둔, 에칭(Etching), 표면처리 등의 소전제조공정을 거쳐 내식성, 내마모성, 주화 압인적성 등이 우수한 주화 신소재를 연구·개발한다. 비금속으로 주화제조가 가능한 신소재를 개발하여 주화제품의 위조방지와 품질을 향상한다. 주화의 기초소재연구와 국내외 관련 자료를 분석하여 소재개발연구를 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"금속재료산업기사, 금속재료기사, 금속재료기술사","dJobECd":"1521","dJobECdNm":"[1521]금속·재료공학 기술자 및 연구원","dJobJCd":"2331","dJobJCdNm":"[2331]금속·재료 공학 연구원 및 기술자","dJobICd":"C331","dJobICdNm":"[C331]귀금속 및 장신용품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004021:1', '{"dJobCd":"K000004021","dJobCdSeq":"1","dJobNm":"주화신제품개발원","workSum":"국민의 기호와 세계적인 추세에 부응하고 유통 중 위변조를 방지할 수 있는 새로운 유통주화, 기념주화 및 메달제품을 연구·개발한다.","doWork":"세계 각국의 유통주화, 기념주화 및 메달을 수집하여 제품의 품위와 기호도 등 세계적인 추세를 파악한다. 금속소재, 위변조 방지기술, 제조방법 등을 체계적으로 분석한다. 도안, 소재, 규격(직경, 두께, 무게), 테두리 형상 등 전체적인 주화 신제품의 제조방법을 설계한다. 설계된 제조방법에 따라 용해, 압연, 타발, 에칭(Etching), 표면처리 등의 공정을 거쳐 소전(주화에 도안이나 액면가, 발행연도 등이 새겨지지 않은 원형상태의 동전)을 제조한다. 선정된 도안으로 극인을 제조하고 소전을 압인하여 주화신제품을 제조한다. 제조된 주화의 품위, 위변조 방지효과, 유통 중 변색방지효과, 생산능력 등을 검토하여 실용화 기술을 연구한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"금속가공기술사, 금속재료기사, 금속재료기술사","dJobECd":"1521","dJobECdNm":"[1521]금속·재료공학 기술자 및 연구원","dJobJCd":"2331","dJobJCdNm":"[2331]금속·재료 공학 연구원 및 기술자","dJobICd":"C331","dJobICdNm":"[C331]귀금속 및 장신용품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002043:1', '{"dJobCd":"K000002043","dJobCdSeq":"1","dJobNm":"주화제조공정연구원","workSum":"소전제조, 금형제조, 압인기술, 검사 및 포장기술 등 주화제조공정 전반에 대한 문제점을 분석하고 개선한다.","doWork":"주화압인 소재인 소전(주화에 도안이나 액면가, 발행연도 등이 새겨지지 않은 원형상태의 동전)의 품질을 향상시킬 수 있는 소전표면 처리방법을 연구한다. 금형제조기술향상을 위하여 각종 주화용 금형소재의 열처리 방법, 진공증착기술 등 내마모성이 우수한 금속표면 처리기술 방법을 연구한다. 구속금형인 칼라의 정밀가공방법 등을 연구한다. 주화제품의 품질향상과 생산성향상을 위해 고속압인기에 적합한 금형소재를 선정한다. 주화검사 및 포장 공정기계화와 자동화 등 생산효율향상 방안을 연구한다. 기타 연구원(일반)들이 수행하는 일반적인 활동을 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"금속가공기술사, 금속재료기사, 금속재료기술사","dJobECd":"1521","dJobECdNm":"[1521]금속·재료공학 기술자 및 연구원","dJobJCd":"2331","dJobJCdNm":"[2331]금속·재료 공학 연구원 및 기술자","dJobICd":"C331","dJobICdNm":"[C331]귀금속 및 장신용품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006456:1', '{"dJobCd":"K000006456","dJobCdSeq":"1","dJobNm":"주화표면처리연구원","workSum":"각종 주화용 금속소재의 변색방지, 광택처리, 착색, 압인(Coining)적성 등 주화제품에 적합한 표면처리방법을 연구·개발한다.","doWork":"주화제조용 금속소재를 규정된 크기 및 모양으로 따내는 타발, 금속가열 후 서서히 식히는 소둔, 산세척, 광택 및 변색 방지처리 등을 실험한다. 색상 및 내식성이 우수한 귀금속도금 및 대량생산을 위한 바렐도금기술을 연구한다. 다양한 색상의 메달제조를 위하여 금속소재별 착색기법을 연구한다. 문양의 음영효과를 자연스럽게 표현할 수 있는 착색피막을 벗겨내는 작업인 조색기법을 연구한다. 각종 금형의 내마모성을 증대시키기 위한 경질크롬도금, 진공증착 등의 표면처리방법을 연구한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"표면처리산업기사, 표면처리기술사","dJobECd":"1521","dJobECdNm":"[1521]금속·재료공학 기술자 및 연구원","dJobJCd":"2331","dJobJCdNm":"[2331]금속·재료 공학 연구원 및 기술자","dJobICd":"C331","dJobICdNm":"[C331]귀금속 및 장신용품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002055:1', '{"dJobCd":"K000002055","dJobCdSeq":"1","dJobNm":"집광채광시스템연구원","workSum":"태양광을 집광하여 건물내부 조명에 이용하는 집광채광시스템을 연구·개발한다.","doWork":"효율성 높은 집광채광시스템을 개발하기 위해 투과율 높은 채광판과 집광에 유리한 반사필름의 조합을 연구한다. 전일채광을 위한 태양추적시스템과 채광량이 낮을 때 실내조명을 자동으로 점등하는 시스템 등을 연구·개발한다. 제품이 설치될 위치에 따른 제품설계를 한다. 설치된 집광채광시스템의 조도를 검사하기도 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1521","dJobECdNm":"[1521]금속·재료공학 기술자 및 연구원","dJobJCd":"2331","dJobJCdNm":"[2331]금속·재료 공학 연구원 및 기술자","dJobICd":"C291","dJobICdNm":"[C291]일반 목적용 기계 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006094:1', '{"dJobCd":"K000006094","dJobCdSeq":"1","dJobNm":"초음파탐상기술자","workSum":"제품 또는 부품의 내부의 품질 검사 및 결함검출을 위한 초음파를 검사부재 내부에 입사시켜 불연속부를 검출하는 초음파 장비를 운전하고, 신호해석을 통한 제품의 품질관리 및 품질보증 업무를 수행한다.","doWork":"검사표준에 따른 초음파탐상 대상재의 특성과 탐상장비의 성능 검사를 통해 검사의 적합성을 확인한다. 표준시험편 및 대비시험편을 이용하여 시간축 및 기준감도를 최적화한다. 검사절차서에 따라 탐촉자, 접촉매질, 케이블 등을 사용하여 피컴체 내부를 탐상한다. 탐상장비의 스크린에 나타나는 신호를 판독하여 내부의 불연속부분을 추출하고 피검체 도면, 적용코드, 판정규격 등을 검토하여 결함의 종류와 유해정도를 판정한다. 검사가 완료되면 판정내용을 기록한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"비파괴검사기술자","certLic":"초음파비파괴검사산업기사, 초음파비파괴검사기사, 비파괴검사기술사","dJobECd":"1521","dJobECdNm":"[1521]금속·재료공학 기술자 및 연구원","dJobJCd":"2331","dJobJCdNm":"[2331]금속·재료 공학 연구원 및 기술자","dJobICd":"M729","dJobICdNm":"[M729]기타 과학기술 서비스업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004261:1', '{"dJobCd":"K000004261","dJobCdSeq":"1","dJobNm":"침투탐상기술자","workSum":"시험체의 표면에 열려있는 균열 등 결함을 검출하기 위하여 침투액, 현상액, 세척액 등의 약품을 사용하여 결함의 위치, 크기 등을 검사한다.","doWork":"피검체 표면의 특성을 살피고, 세척액을 이용하여 깨끗이 세척한다. 침투액을 표면으로 열린 결함 부위에 충분히 침투시킨 후 표면의 침투액을 닦아내고, 백색 미분말의 현상액으로 내부 결함 내에 침투한 침투액을 빨아내어 그것을 직접 또는 조명을 비추어 관찰하고, 결함이 있는 장소와 결함의 크기를 기록하고 보고서를 작성한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"비파괴검사기술자","connectJob":"초음파탐상기술자, 방사선탐상기술자, 자기탐상기술자","certLic":"침투비파괴검사기사, 침투비파괴검사산업기사, 침투비파괴검사기능사","dJobECd":"1521","dJobECdNm":"[1521]금속·재료공학 기술자 및 연구원","dJobJCd":"2331","dJobJCdNm":"[2331]금속·재료 공학 연구원 및 기술자","dJobICd":"M729","dJobICdNm":"[M729]기타 과학기술 서비스업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002075:1', '{"dJobCd":"K000002075","dJobCdSeq":"1","dJobNm":"카본블랙제조기술자","workSum":"카본블랙 제조공정을 설계·운용한다.","doWork":"카본블랙(흑색의 미세한 탄소분말. 천연가스·타르 등을 불완전 연소시켜 생긴 그을음을 모으거나 그것들을 열분해하여 제조함) 원료유를 선정한다. 원료의 성분 및 미량금속을 분석한다. 원료유와 산소함량에 따른 반응온도, 반응로의 크기에 따른 제품등급, 중지수(반응온도를 급냉하여 반응을 중지시키기 위하여 공급되는 냉각수)의 투입위치, 원료유의 혼합비율 등 반응조건을 설계한다. 카본블랙 제조공정과 단위공정을 설계한다. 생산설비 운용계획, 생산일정 관리, 원료의 규격, 반응조건 등을 고려하여 생산지침서를 작성한다. 생산공정을 운용한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"위험내재|고온|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"화공기사, 화공기술사","dJobECd":"1521","dJobECdNm":"[1521]금속·재료공학 기술자 및 연구원","dJobJCd":"2331","dJobJCdNm":"[2331]금속·재료 공학 연구원 및 기술자","dJobICd":"C239","dJobICdNm":"[C239]기타 비금속 광물제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004106:1', '{"dJobCd":"K000004106","dJobCdSeq":"1","dJobNm":"탄소나노튜브연구개발자","workSum":"탄소나노튜브의 생산기술과 기능성 탄소나노튜브(CNT:Carbon NanoTube) 물질의 조성에 대해 연구·개발한다.","doWork":"단일벽 탄소나노튜브(Single-Walled CNT: SWCNT) 및 다중벽(Multi-Walled CNT:MWCNT)을 대량생산하기 위한 기술과 정제기술을 연구·개발한다. 강철, 다이아몬드, 구리 등에 비해 높은 탄성, 인장강도, 열전도도, 전기전도도 등의 특성을 활용하기 위해 다양한 촉매와 결합하여 전지, 디스플레이, 요구하는 특성을 지닌 기능성 탄소나노튜브 물질(Paste)조성과 응용에 대해 연구한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1521","dJobECdNm":"[1521]금속·재료공학 기술자 및 연구원","dJobJCd":"2331","dJobJCdNm":"[2331]금속·재료 공학 연구원 및 기술자","dJobICd":"C239","dJobICdNm":"[C239]기타 비금속 광물제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001878:1', '{"dJobCd":"K000001878","dJobCdSeq":"1","dJobNm":"탄소복합재료제조기술자","workSum":"탄소재료에 점결재를 혼합하고 성형, 건조 경화, 저온탄화, 고온탄화 공정을 통하여 탄소·탄소 간의 복합재로 구성된 탄소제품을 제조한다.","doWork":"탄소-탄소복합재료(Carbon-Carbon Composites:탄소계의 입자, 섬유와 탄소계의 모체 등 두 종류 이상을 조합한 재료)를 생산하기 위하여 원료를 선정하고 원료품질을 분석한다. 원료분체를 배합한다. 점결능력이 없는 충진재 탄소재료에 수지점결재를 혼합한다. 혼합방법과 성형방법에 따라 성형체 제조조건을 결정한다. 성형방법에 따라(수지를 용매에 용해하여 충전재(충진재)를 분산시키는 습식방법과 충진재 탄소섬유에 수지를 함침하는 건식방법) 성형한다. 제조된 성형체에 적합한 저온탄화방법을 선정하고 공정조건을 설정하여 저온탄화공정을 수행한다. 제조된 탄화품에 적합한 고온탄화법을 선정하고 공정조건을 설정하여 고온열처리공정을 수행한다. 중간제품과 최종제품을 검사항목에 따라 검사하고 품질을 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"화공기사, 화공기술사, 화학분석기사","dJobECd":"1521","dJobECdNm":"[1521]금속·재료공학 기술자 및 연구원","dJobJCd":"2331","dJobJCdNm":"[2331]금속·재료 공학 연구원 및 기술자","dJobICd":"C239","dJobICdNm":"[C239]기타 비금속 광물제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002423:1', '{"dJobCd":"K000002423","dJobCdSeq":"1","dJobNm":"탄소섬유제조기술자","workSum":"탄소섬유 제조공정을 설계·운용한다.","doWork":"탄소섬유의 원료(아크릴로니트릴, 석유계 피치, 석탄계 피치, 페놀수지, 셀룰로오스 등)를 선정한다. 원료 고분자를 중합하기 위하여 중합체 제조방법과 설비를 파악하고 결정한다. 중합조건을 선정하고 적용한다. 제조된 중합체의 물성을 파악하여 방사공정 적합 여부를 판단하고 조치한다. 탄소섬유 전구체를 제조하기 위하여 중합체 방사방법(습식방사, 건식방사, 용융방사, 전기방사 등)을 선정한다. 방사공정을 운용하여 탄소섬유 전구체(前驅體:Precursor)를 제조한다. 전구체 섬유 안정화 공정을 운용한다. 안정화 섬유(열처리에 의한 안정화·산화상태 이전의 섬유)를 탄소섬유로 전환하는 섬유탄화설비(저온탄화, 고온탄화, 흑연화)를 운용하여 탄소섬유를 제조한다. 탄화섬유의 표면처리, 사이징 등 후처리공정을 수행하여 제품을 생산한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"위험내재|고온|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1521","dJobECdNm":"[1521]금속·재료공학 기술자 및 연구원","dJobJCd":"2331","dJobJCdNm":"[2331]금속·재료 공학 연구원 및 기술자","dJobICd":"C205","dJobICdNm":"[C205]화학섬유 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004466:1', '{"dJobCd":"K000004466","dJobCdSeq":"1","dJobNm":"태양열발전연구원","workSum":"태양열발전시스템의 각종 장치, 소재 등의 요소기술 및 공정기술을 연구하고 개발한다.","doWork":"태양열을 집열하여 전기에너지로 전환하는 데 필요한 태양열발전시스템에 관한 국내외 논문과 기술동향, 정부의 재생에너지정책에 대한 조사·연구를 실시하여 연구의 방향을 설정한다. 태양열발전시스템의 각종 장치, 소재 등의 요소기술 및 공정기술을 개발한다. 미래 기술개발 예측 및 실용화 방안에 대한 중장기로드맵을 구축하여 관련 연구를 수행한다. 기타 연구원(일반)들이 수행하는 일반적인 활동을 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"신재생에너지발전설비산업기사(태양광), 신재생에너지발전설비기사(태양광)","dJobECd":"1521","dJobECdNm":"[1521]금속·재료공학 기술자 및 연구원","dJobJCd":"2331","dJobJCdNm":"[2331]금속·재료 공학 연구원 및 기술자","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004403:1', '{"dJobCd":"K000004403","dJobCdSeq":"1","dJobNm":"태양열소재개발자","workSum":"집열부와 축열부에 사용되는 열효율이 높은 태양열 소재를 연구·개발한다.","doWork":"태양열 소재와 관련 국내외 논문과 기술동향을 분석하여 연구의 방향을 설정하고 연구기획을 수립한다. 태양열을 집열하는 집열부와 열에너지를 축열하는 축열부에 사용되는 열전도, 열보관 등 열효율이 높은 소재를 연구·개발한다. 효율 높은 집열판, 강화유리, 축열제의 구성의 연구를 통해 향상된 태양열시스템을 개발하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1521","dJobECdNm":"[1521]금속·재료공학 기술자 및 연구원","dJobJCd":"2331","dJobJCdNm":"[2331]금속·재료 공학 연구원 및 기술자","dJobICd":"C281","dJobICdNm":"[C281]전동기, 발전기 및 전기 변환ㆍ 공급ㆍ제어 장치 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002466:1', '{"dJobCd":"K000002466","dJobCdSeq":"1","dJobNm":"환경소재연구원","workSum":"저비용 완전분해성 소재를 개발하고 응용하는 연구를 수행한다.","doWork":"광분해, 미생물 분해가 용이한 소재를 개발한다. 전분과 석유계 물질을 합성하여 분해가 용이한 소재를 개발한다. 자료조사를 통해 기능성 물질을 유추하고 반응기에서 화학적 합성을 하거나 V-믹서나 U-믹서에 넣고 교반하여 소재를 개발한다. 압출성형기를 이용하여 펠릿(Pellet)을 만들고 스티로폼, 비닐, 용기 등의 시제품을 제작하여 분석한다. 파열강도, 내열성 등의 상품성과 분해성 실험을 한다. 기타 연구원(일반)들이 수행하는 일반적인 활동을 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"종합","workFunc2":"자문","workFunc3":"정밀작업","dJobECd":"1521","dJobECdNm":"[1521]금속·재료공학 기술자 및 연구원","dJobJCd":"2331","dJobJCdNm":"[2331]금속·재료 공학 연구원 및 기술자","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005641:1', '{"dJobCd":"K000005641","dJobCdSeq":"1","dJobNm":"활성탄제조기술자","workSum":"활성탄 제조공정을 설계·운용한다.","doWork":"활성탄(기체 또는 용액 중의 용질 등에 대해 강한 흡착성을 나타내는 탄소질 물질) 원료를 선정한다. 원료의 성분을 분석하고 품질을 검사한다. 산화가스의 특성, 활성화 온도·시간, 활성화 장치, 제품특성을 고려하여 활성화 조건을 설계한다. 원료의 규격, 반응조건, 생산장비에 따라 생산지침서를 작성한다. 활성탄소제품 제조공정을 운용한다. 품질규격에 따라 검사하고 품질을 측정한다. 품질검사결과를 생산공정에 반영하고 개선한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"위험내재|고온|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"화공기사, 화공기술사, 화학분석기사","dJobECd":"1521","dJobECdNm":"[1521]금속·재료공학 기술자 및 연구원","dJobJCd":"2331","dJobJCdNm":"[2331]금속·재료 공학 연구원 및 기술자","dJobICd":"C239","dJobICdNm":"[C239]기타 비금속 광물제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006893:1', '{"dJobCd":"K000006893","dJobCdSeq":"1","dJobNm":"광석시료제조원","workSum":"광물의 성상을 알기 위하여 시험에 적당한 형태로 광석을 가공하여 광석시료를 제조한다.","doWork":"광물화학분석, 선광시험 등을 하기 위하여 파쇄기로 광석을 파쇄하고 마쇄기로시험에 적절한 크기로 분말화한다. 광물의 현미경적 관찰을 위하여 암석을 절단하여 슬라이드글라스에 부착시킨 뒤 연마한다. 커버글라스를 부착하여 박편을 제작하고 암석조각을 베클라이트를 사용하여 성형한 후 연마하여 연마편을 제작한다. 암석의 물리적 성질을 측정하기 위하여 일정한 규격과 형태로 절단하고 연마한다. 야외 혹은 갱도나 선광장의 여러 곳에서 광석견본을 수집하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"박편원","dJobECd":"1522","dJobECdNm":"[1522]금속·재료공학 시험원","dJobJCd":"2332","dJobJCdNm":"[2332]금속 및 재료 공학 시험원","dJobICd":"B051/B061/B062","dJobICdNm":"[B051]석탄 광업 / [B061]철 광업 / [B062]비철금속 광업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005403:1', '{"dJobCd":"K000005403","dJobCdSeq":"1","dJobNm":"광학세라믹소재결정성장제어원","workSum":"재료가 요구하는 광학적 기능 및 부가적인 기능을 구현하기 위해 재료를 용융하여 한 개의 결정방위로 재 결정화 하면서 성장시키는 공정장비를 제어한다.","doWork":"종자결정의 방위를 결정하고 요구형상을 가공한다. 결정성장장치의 온도와 분위기를 제어하고 결정성장로의 온도구배(물체 내부를 열전도 할 때 평행한 양면의 온도가 각각 일정하고 물체 내부가 일정하다면 물체 내부의 온도분포는 직선이 되며 이 직선의 기울기를 온도구배라 한다)를 제어한다.결정성장공법에 따라 도가니재질, 원료소재의 용융, 고화특성, 종자결정의 회전속도, 온도, 결정성장장치의 분위기, 용융물 흐름, 공정 중 자기장, 성장된 결정의 열충격, 자기장의 변화를 제어한다. 성장로의 온도를 내릴 때 내부의 온도구배를 제어하고 상온까지 냉각시켜 성장로 밖으로 추출한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"1522","dJobECdNm":"[1522]금속·재료공학 시험원","dJobJCd":"2332","dJobJCdNm":"[2332]금속 및 재료 공학 시험원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006830:1', '{"dJobCd":"K000006830","dJobCdSeq":"1","dJobNm":"귀금속품질평가사","workSum":"귀금속의 순도를 분석하고, 제품의 수량, 무게, 표면품질 등을 정확히 평가·계량하여 이를 정량화한다.","doWork":"생산된 귀금속의 정확한 평량을 위하여 계량기의 이상 유무를 확인·점검한다. 제품을 정확히 평량하고 제품 정보를 기록한다. 경우에 따라 제품을 물리적 또는 화학적 방법을 통해 순도(품위)를 분석하고, 장비를 사용하여 표면품질을 확인, 제품의 품질을 관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"귀금속품질관리원","certLic":"귀금속가공기능사, 귀금속가공산업기사, 귀금속가공기능장","dJobECd":"1522","dJobECdNm":"[1522]금속·재료공학 시험원","dJobJCd":"2332","dJobJCdNm":"[2332]금속 및 재료 공학 시험원","dJobICd":"C331","dJobICdNm":"[C331]귀금속 및 장신용품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005364:1', '{"dJobCd":"K000005364","dJobCdSeq":"1","dJobNm":"금속재료시험원","workSum":"금속 제품의 적합성 검토와 판단을 위한 시험계획을 수립하고, 시험준비 단계를 거쳐 기계적, 물리적, 화학적 시험 등을 수행한다.","doWork":"금속 제품의 시험을 위한 관련 규격 검토 및 시험편 채취 및 실험장비 조건 등 시험계획을 수립한다. 시험 전 관련 규격에서 명시된 규격으로 시험편을 가공하여 준비한다. 시험 장비의 이상 유무를 확인한 후, 선정된 시험계획 및 설계에 따라 장비를 활용하여 시험을 수행하고 정확도 및 재현성을 확인한다. 시험을 통해 얻어진 자료를 분석하고 결과보고서를 작성한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"금속재료시험원","connectJob":"금속화학시험원, 금속물리시험원, 금속조직시험원, 금속재료시험원","certLic":"금속재료기사, 금속재료산업기사, 재료조직평가산업기사, 금속재료시험기능사, 열처리기능사, 화학분석기능사","dJobECd":"1522","dJobECdNm":"[1522]금속·재료공학 시험원","dJobJCd":"2332","dJobJCdNm":"[2332]금속 및 재료 공학 시험원","dJobICd":"C","dJobICdNm":"[C]제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004814:1', '{"dJobCd":"K000004814","dJobCdSeq":"1","dJobNm":"나노소자품질검사원","workSum":"나노소자 개발 및 양상단계에서 발생할 수 있는 문제점을 예방하고 공정, 출하, 제품품질을 검사하여 품질을 관리한다.","doWork":"나노소자 모듈공정사양에 따라 조립생산, 공정유지 및 보수업무를 수행한다. 조립생산의 반복 공정작업을 수행하고 관리한다. 나노소자 공정으로부터 제작된 회로, 센서부, 구동부, 검출부 등을 부착하여 소자, 모듈을 조립 완성한다. 모듈공정의 작업성 및 품질개선을 수행한다. 모듈공정의 변경, 제거, 대체작업을 수행한다. 신개념 기술, 공법, 새로운 장비, 공정사항을 숙지한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1522","dJobECdNm":"[1522]금속·재료공학 시험원","dJobJCd":"2332","dJobJCdNm":"[2332]금속 및 재료 공학 시험원","dJobICd":"C339","dJobICdNm":"[C339]그 외 기타 제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001892:1', '{"dJobCd":"K000001892","dJobCdSeq":"1","dJobNm":"나노소재품질시험원","workSum":"생산된 나노소재의 시험결과를 판정하여 출하 여부를 결정하며 품질개선업무를 수행한다.","doWork":"나노소재 원·부자재 및 단위 공정 생산품의 샘플선정방법을 수립하고 품질관리인자를 도출한다. 품질에 영향을 주는 인자를 고려하여 검사공정을 선정한다. 측정방법을 확립하고 지속적으로 개선한다. 시험실, 시험장비, 시험기기, 측정기기를 점검하고 관리한다. 생산품의 품질을 측정·기록·관리한다. 원자재, 완제품의 시험결과를 분석·기록하고 판정한다. 원자재 및 부분품을 평가한다. 클레임 등 소비자의 요구를 취합·정리하여 관련 부서에 전달한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1522","dJobECdNm":"[1522]금속·재료공학 시험원","dJobJCd":"2332","dJobJCdNm":"[2332]금속 및 재료 공학 시험원","dJobICd":"C339","dJobICdNm":"[C339]그 외 기타 제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002852:1', '{"dJobCd":"K000002852","dJobCdSeq":"1","dJobNm":"내열구조세라믹재료품질관리원","workSum":"수요자의 요구에 적합한 품질의 내열구조 세라믹소재를 합리적으로 생산하기 위해 수입검사, 공정검사, 출하검사를 수행한다.","doWork":"수입검사를 하여 원자재 또는 부자재의 적합 유무를 판단한다. 원재료의 성적서를 확인한다. 원재료의 특성을 파악하고 공정 투입 여부를 결정한다. 수입검사기록을 작성한다. 공정검사를 하여 제품생산공정이 진행 중인 자재 및 기기의 적합 유무를 판단한다. 공정이 진행 중인 제품의 적합 유무를 판단한다. 부적합품을 관리한다. 공정검사보고서를 작성한다. 출하검사를 하여 완제품의 출하 적합 여부를 판단한다. 분석·검사장비의 검교정을 실시하거나 전문업체에 의뢰하여 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"품질관리기술사, 품질경영기사, 품질경영산업기사, 세라믹기술사","dJobECd":"1522","dJobECdNm":"[1522]금속·재료공학 시험원","dJobJCd":"2332","dJobJCdNm":"[2332]금속 및 재료 공학 시험원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005388:1', '{"dJobCd":"K000005388","dJobCdSeq":"1","dJobNm":"도장시험원","workSum":"각종 자동차 도장공정의 설비 및 도료의 개선 또는 변경에 관한 시험을 한다.","doWork":"작업표준에 의해 방청(녹 방지)을 주목적으로 하는 전처리 공정, 외판은 물론 차체 내부까지 균일하게 도장한다. 차체의 부식을 방지하는 전착(電着)공정, 보디와 패널이 겹치는 부분 등에 실러를 도포하는 실러공정, 차체 바닥이나 도어 내부에 언더코팅을 한다. 주행 시 소음과 신동을 감소시키는 언더코팅공정, 상도의 질을 높이기 위한 중간칠작업인 중도(中途)공정, 차체표면의 미관과 색채감의 외관품질을 결정하는 상도(上塗)공정, 그리고 조립공정에서 긁힘 등의 상처가 생겼을 경우 이를 부분적으로 마무리하는 마무리공정 작업방법에 따라 도료를 준비하고 현장에 적용하여 도장시험을 한다. 시험결과를 분석해 보고한다. 도장작업표준의 설정, 소요자재 및 부자재의 소요량을 산정하기 위한 기초자료를 조사한다. 열풍로, 도장부스, 오븐 등의 온도 및 작업조건 등을 측정한다. 자체시험이 불가능한 사항은 시험부서나 외부전문기관에 시험을 의뢰한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"금속재료산업기사, 화학분석사","dJobECd":"1522","dJobECdNm":"[1522]금속·재료공학 시험원","dJobJCd":"2332","dJobJCdNm":"[2332]금속 및 재료 공학 시험원","dJobICd":"C301","dJobICdNm":"[C301]자동차용 엔진 및 자동차 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001690:1', '{"dJobCd":"K000001690","dJobCdSeq":"1","dJobNm":"바이오세라믹재료시험원","workSum":"바이오세라믹재료의 적절한 제조·판매를 위해 물리, 화학, 생물학적 안정성 및 성능을 시험한다.","doWork":"생체재료의 제조 및 품질관리기준(GMP:Good Manufacturing Practice, 의료기기, 의약품 및 화장품 등의 안정성과 유효성을 품질면에서 보증하는 기본조건으로서 원료의 입고에서부터 출고에 이르기까지 품질관리의 전반에 걸쳐 지켜야 할 규범)에 따라 시험의 종류와 규격을 확인한다. 물리·화학적 시험(인체에 접촉·삽입되거나 인체에 주입되는 혈액, 체액 또는 약물 등과 접촉하는 재료의 완제품 또는 원재료에 대한 시험이며 제조업체가 의도한 안정성, 유효성을 확보하기 위하여 완제품 또는 원재료의 물리적, 화학적 성질에 관한 시험), 성능시험(기술문서 등의 심사를 위하여 제출하여야 하는 자료의 종류 중 하나로서 진단이나 치료의 목적으로 사용되는 의료기기의 유효성을 입증하는 시험), 생물학적 시험(의료기기 및 원자재의 안정성과 관련된 생물학적 평가지침의 선정에 관한 총괄적인 지침에 의한 시험), 안정성시험(멸균 의료기기 또는 시간이 경과됨에 따라 원재료의 물리·화학적 변화로 인한 안정성 또는 성능의 변화가 예측되는 의료기기가 제조자가 설정한 운송, 보관조건 등에서 사용기한 동안 제품의 특성, 성능, 안전성 등이 유지됨을 입증하는 시험)을 한다. 시험성적서를 작성한다. 기술문서(개발자가 개발제품의 위험관리가 실제적으로 이루어지고 있음을 허가당국에 증명하는 서류, 원자재, 구조, 사용목적, 사용방법, 작용원리, 사용 시 주의사항, 시험규격 등을 기술한 문서)를 작성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"위험내재|고온|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"세라믹기술사","dJobECd":"1522","dJobECdNm":"[1522]금속·재료공학 시험원","dJobJCd":"2332","dJobJCdNm":"[2332]금속 및 재료 공학 시험원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004229:1', '{"dJobCd":"K000004229","dJobCdSeq":"1","dJobNm":"바이오세라믹재료품질관리원","workSum":"수요자의 요구에 적합한 품질의 생체재료를 합리적으로 생산하기 위해 수입·공정·출하검사 및 밸리데이션업무를 수행한다.","doWork":"고품질의 생체재료를 합리적으로 생산하기 위해 수입검사, 공정검사, 출하검사를 한다. 부적합으로 판정된 원자재, 소모자재, 공정품, 제품, 설비 등에 대한 보고서를 작성하고 대처한다. 밸리데이션(Validation:주로 의료업에서 제조소의 구조설비 및 작업의 흐름, 제조공정, 제조관리와 품질관리 등과 이를 지원하는 모든 운영관리 및 작업이 표준화되어 계획대로 재현성 및 유의성 있게 기대하는 제품을 제조할 수 있다는 것을 과학적으로 검증하여 문서화하는 것으로 설치적격성평가IQ, 운전적격성평가OQ, 성능적격성평가PQ로 구성)업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"바이오세라믹재료밸디데이터, 바이오세라믹품질보증원","certLic":"품질관리기술사, 품질경영기사, 품질경영산업기사, 세라믹기술사","dJobECd":"1522","dJobECdNm":"[1522]금속·재료공학 시험원","dJobJCd":"2332","dJobJCdNm":"[2332]금속 및 재료 공학 시험원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005867:1', '{"dJobCd":"K000005867","dJobCdSeq":"1","dJobNm":"반도체재료성능평가기술자","workSum":"반도체 공정기술 및 고객 요구성능을 이해하고, 재료개발 또는 생산계획수립을 지원하고, 반도체 재료의 분석, 시험평가, 보완, 검증작업을 반복·수행한다.","doWork":"반도체재료 성능평가 계획을 수립하고, 재료물성분석을 실시하여 구성물질의 함량, 구조, 물리화학적 특성에 대한 정보를 수집한다. 반도체재료의 물질안전자료를 재료설계 및 공정연구원과 공동으로 작성, 내부연구원, 외부고객과 공유한다. 반도체 생산라인과 유사한 평가작업장 환경에서 재료 성능평가 계획을 기준으로 기초공정 성능평가를 실시한 다음, 보완, 검증작업을 반복 수행한다. 반도체 생산라인에서 소자제조공정 및 고객요구수준에 적합한 공정신뢰성 평가를 실시하고, 보완, 검증작업을 반복 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체재료기술자","dJobECd":"1522","dJobECdNm":"[1522]금속·재료공학 시험원","dJobJCd":"2332","dJobJCdNm":"[2332]금속 및 재료 공학 시험원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004674:1', '{"dJobCd":"K000004674","dJobCdSeq":"1","dJobNm":"시멘트품질시험원","workSum":"시멘트 제품의 품질규격의 유지를 위하여 원료 및 제품에 대한 검사업무를 수행한다.","doWork":"시멘트의 종류에 따라 초결·종결시간을 측정하여 응결시간을 검사하고, 시멘트제품을 경화시켜 압축강도, 고강도 등을 측정한다. 시험·분석 결과와 품질규격을 검토하여 시멘트제품의 품질을 판정한다. 원료와 제품에 대한 강열함량(Residue on Ignition), 불용잔분함량, 황산무수물(Sulfuric Anhydride)함량 등을 측정하고 분말도, 클링커(Clinker)조직, 비중시험, 안정성시험, 강도시험, 비파괴시험, 팽창수축시험, 화학저항성시험, 수화열시험 등의 각종시험, 측정결과를 종합·분석한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"화학분석사","dJobECd":"1522","dJobECdNm":"[1522]금속·재료공학 시험원","dJobJCd":"2332","dJobJCdNm":"[2332]금속 및 재료 공학 시험원","dJobICd":"C233","dJobICdNm":"[C233]시멘트, 석회, 플라스터 및 그 제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002712:1', '{"dJobCd":"K000002712","dJobCdSeq":"1","dJobNm":"요업제품품질검사원","workSum":"내화요업제품, 구조용 정형내화제품, 점토벽돌, 블록 및 유사 비내화요업제품 등의 내화제품이나 점토제품의 성형품을 각종 검사기구와 육안을 통해 외관검사 및 측정검사를 한다.","doWork":"제조공정상의 내화제품이나 점토제품의 성형품(내화요업제품, 구조용 정형내화제품, 점토벽돌, 블록 및 유사 비내화요업제품)을 제토, 성형, 소성 등 각 공정의 견본(Sample)을 채취하여 검사대로 운반한다. 육안으로 표면의 균열, 겉모양, 깨짐, 귀 떨어짐, 뒤틀림 등을 표준견본과 비교·검사한다. 측정기구(자, 비중측정기, 입도측정기)로 각종 검사를 한다. 검사항목과 검사결과를 작업일지에 기록한다. 강도측정기로 성형품의 강도를 측정한다. 검사표준 미달제품은 색연필 또는 매직으로 표기하여 선별해 놓는다. 합격품은 검사필증, 품질기능서 등을 부착하고 포장을 위하여 이송한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"화학분석사","dJobECd":"1522","dJobECdNm":"[1522]금속·재료공학 시험원","dJobJCd":"2332","dJobJCdNm":"[2332]금속 및 재료 공학 시험원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004759:1', '{"dJobCd":"K000004759","dJobCdSeq":"1","dJobNm":"인조흑연시험분석원","workSum":"인조흑연제품의 품질향상을 위해 물리화학적, 기계적 물성을 시험·분석하고 품질규격에 적용한다.","doWork":"인조흑연을 생산하기 위하여 제품사양에 적합한 원재료(석탄계, 석유계, 등방성, 이방성 코크스)를 선정하고 물성을 측정한다. 바인더 피치(석탄계, 석유계 첨가제)의 종류를 파악하고 분석한다. 생산할 인조흑연제품의 종류에 따라 성형방법을 선정하고 원료규격과 성형조건을 결정한다. 바인더 피치를 혼합한다. 소성설비와 공정을 운용한다. 함침공정(소성품의 공극에 함침 피치를 채운 후 재소성하여 소성품의 밀도를 높이는 공정)을 운용한다. 탄화로를 운용하여 원하는 특성의 흑연제품을 제조한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"위험내재|고온|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"화학분석기사","dJobECd":"1522","dJobECdNm":"[1522]금속·재료공학 시험원","dJobJCd":"2332","dJobJCdNm":"[2332]금속 및 재료 공학 시험원","dJobICd":"C239","dJobICdNm":"[C239]기타 비금속 광물제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003997:1', '{"dJobCd":"K000003997","dJobCdSeq":"1","dJobNm":"전선재료시험원","workSum":"각종 분석방법을 사용해서 전선제조에 사용되는 금속, 플라스틱, 화학제품 등의 원료들의 특성을 시험·검사한다.","doWork":"각종 검사기구를 사용해서 시험할 금속선재의 경도, 중량, 하중, 인장력 등을 계산한다. 확대 촬영기구를 사용해서 금속조직을 검사한다. 염수분무시험기에 나선을 넣어 응력부식 시험을 한다. 플라스틱 재료가 제조명세서의 품명, 규격 등과 일치하는지 확인하고 시험장비의 속도, 온도, 시간, 압력 등을 기준서에 맞추어 조정한다. 작업지시서에 규정된 방법으로 인장시험, 내유시험, 변형시험, 내열시험, 수축시험, 굴곡시험 등을 시행한다. 전선제조에 사용되는 테이프, 화학제품, 절연지 등을 각종 시험기구와 화학물질을 사용해서 검사한다. 각종 시험결과를 기록표에 기록하고 합격 여부를 판정한다. 시험결과를 담당부서에 통보하고 기록된 자료를 평가·분석한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"감독","workFunc3":"제어조작","certLic":"재료조직평가산업기사, 화학분석사","dJobECd":"1522","dJobECdNm":"[1522]금속·재료공학 시험원","dJobJCd":"2332","dJobJCdNm":"[2332]금속 및 재료 공학 시험원","dJobICd":"C283","dJobICdNm":"[C283]절연선 및 케이블 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003051:1', '{"dJobCd":"K000003051","dJobCdSeq":"1","dJobNm":"전자세라믹소재검사원","workSum":"제조된 전자세라믹 부품의 전기적, 자기적, 광학적 특성 등을 측정하여 소자 응용가능성을 평가한다.","doWork":"유전체, 압전체, 자성체 등 전기전자 세라믹소재의 요구특성을 확인한다. 저울, 오실로스코프, 전류계, 마이크로미터, 절연저항계, 전압계 등 검사장비로 제품검사표준 및 검사지시서에 따라 제품을 검사한다. 품질규정에 따라 검사한 제품의 품질을 평가하고 성적서를 작성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"세라믹기술사","dJobECd":"1522","dJobECdNm":"[1522]금속·재료공학 시험원","dJobJCd":"2332","dJobJCdNm":"[2332]금속 및 재료 공학 시험원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005248:1', '{"dJobCd":"K000005248","dJobCdSeq":"1","dJobNm":"주물사시험원","workSum":"제조된 주물사의 강도, 통기도, 분진 등을 정기적으로 측정·분석하여 규정된 기준에 적합하도록 점결재 및 경화재의 양을 조정하고 관리한다.","doWork":"주물사의 합격 여부를 판정하기 위하여 표준명세를 확인하고 각종 장비의 이상 유무를 점검한다. 제조된 주물사가 규정된 기준에 적합한지를 판정하기 위하여 주물사 및 각종 시험장비를 준비한다. 각종 시험장비를 조작하고 계절 등 기온변화를 고려하여 주물사의 강도, 통기도, 분진 등이 표준명세의 기준에 적합한지를 측정한다. 계절 등의 기온변화를 고려하여 주물사에 첨가할 점결재 및 경화재를 조절한다. 기준에 적합한지 판정하고 작업내용을 작업일지에 기록하여 보고한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|고온|소음·진동|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"금속재료산업기사, 재료조직평가산업기사, 주조산업기사","dJobECd":"1522","dJobECdNm":"[1522]금속·재료공학 시험원","dJobJCd":"2332","dJobJCdNm":"[2332]금속 및 재료 공학 시험원","dJobICd":"C243","dJobICdNm":"[C243]금속 주조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006513:1', '{"dJobCd":"K000006513","dJobCdSeq":"1","dJobNm":"카본블랙시험분석원","workSum":"카본블랙의 시료를 채취하여 물성, 응용물성을 측정하고 결과를 분석하며 품질규격을 관리한다.","doWork":"단위공정(반응공정, 조립공정, 건조공정, 포장공정)에 따라 평가시료를 채취한다. 콜로이드물성측정법(요오드 흡착량, 질소 흡착량, 오일 흡착량, 이물질 함량 등), 표면물성측정법(산도, 휘발성 물질 함량, 산소 함량 등) 등을 활용하여 물성을 측정한다. 고무용분야 및 비고무용분야(플라스틱, 도료, 잉크, 토너, 세라믹 등)의 측정항목에 따라 응용물성(점도, 기계적물성, 동적 탄성물성, 전기전도성, 흑도 등)을 측정한다. 카본블랙의 물성에 대하여 통계적 관리기법을 활용하여 평균, 표준편차, 산포, 신뢰도 등을 산출한다. 물성치를 근거로 제품출하 여부를 판단한다. 분석결과를 제조공정과 응용분야에 반영한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"위험내재|고온|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"화학분석기사","dJobECd":"1522","dJobECdNm":"[1522]금속·재료공학 시험원","dJobJCd":"2332","dJobJCdNm":"[2332]금속 및 재료 공학 시험원","dJobICd":"C239","dJobICdNm":"[C239]기타 비금속 광물제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001448:1', '{"dJobCd":"K000001448","dJobCdSeq":"1","dJobNm":"탄소섬유시험분석원","workSum":"탄소섬유제품의 품질유지를 위하여 물성 분석, 표면특성 분석, 응융특성 분석을 수행하고 제품생산과 품질규격을 관리한다.","doWork":"탄소섬유제품의 화학적 물성을 분석하기 위하여 시료를 선정하고 원소분석방법을 파악한다. 원소분석장비, 기계적 물성 분석장비, 표면특성 분석장비를 사용하여 시료의 화학적, 기계적, 표면특성 물성을 분석한다. 응용특성을 파악하기 위하여 고분자 수지의 종류에 따라 측정방법을 결정하고 분석장비를 사용하여 분석한다. 제품표준규격서의 기준과 비교하여 시험성적서를 작성하고 합격 여부를 판정한다. 품질규격을 관리하기 위하여 흑연제품의 물성에 대한 통계적 관리기법을 활용하며, 측정데이터를 근거로 제품출하 여부를 판단하고 조치한다. 측정결과를 제조공정에 반영한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"위험내재|고온|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"화학분석기사","dJobECd":"1522","dJobECdNm":"[1522]금속·재료공학 시험원","dJobJCd":"2332","dJobJCdNm":"[2332]금속 및 재료 공학 시험원","dJobICd":"C205","dJobICdNm":"[C205]화학섬유 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004899:1', '{"dJobCd":"K000004899","dJobCdSeq":"1","dJobNm":"탄소재료시험분석원","workSum":"화학적, 물리적, 광학적, 표면분석 등을 실시하여 탄소로 이루어진 다양한 재료의 특성을 파악한다.","doWork":"카본블랙, 탄소섬유, 활성탄소, 인조흑연, 탄소복합재료 등 다양한 탄소제품원료의 원소특성, 종류별 특성, 제조방법별 특성을 파악한다. 화학조성 분석(원소분석, 전기화학특성 측정, 분광특성을 측정하여 물질을 구성하는 원자들의 양, 비율을 분석), 전기화학 분석(전자의 이동과 관련된 화학적 변화의 내용을 분석), 분광학 분석(분자의 구조를 분석), 흡광 분석(재료가 다양한 파장의 빛을 흡수하는 성질을 분석), 발광특성 분석(재료로부터 다양한 파장의 빛이 나오는 성질을 분석), 표면화학조성 분석(재료의 표면을 구성하는 원자들의 양, 비율, 화학구조 등을 분석), 표면형태 분석(재료표면의 균일도, 형태, 크기 등을 분석) 등 분석방법을 활용하여 분석한다. 분석자료를 해석하고 보고서를 작성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"위험내재|고온|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"화학분석기사","dJobECd":"1522","dJobECdNm":"[1522]금속·재료공학 시험원","dJobJCd":"2332","dJobJCdNm":"[2332]금속 및 재료 공학 시험원","dJobICd":"C239","dJobICdNm":"[C239]기타 비금속 광물제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005547:1', '{"dJobCd":"K000005547","dJobCdSeq":"1","dJobNm":"폐자재금속자원재생원료시험원","workSum":"금속자원재생에 필요한 폐자재를 샘플링하여 금속 등의 함량분석을 통해 재활용 원료를 분석한다.","doWork":"폐인쇄회로(PCB)기판, 도금 후폐수 슬러지 등의 원자재를 샘플링한다. 분석할 시료형상과 균일성을 검사한다. 금속의 종류에 따라 분석방법에 적합하도록 전처리한다. 이온화, X선조사, 고온용융, 미세분쇄 등의 분석방법을 활용하여 정성·정량분석을 한다. 각 물질의 함량을 측정하고 작업일지에 기록하여 관련 부서에 보고한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"금속재료산업기사, 재료조직평가산업기사","dJobECd":"1522","dJobECdNm":"[1522]금속·재료공학 시험원","dJobJCd":"2332","dJobJCdNm":"[2332]금속 및 재료 공학 시험원","dJobICd":"E383","dJobICdNm":"[E383]해체, 선별 및 원료 재생업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001610:1', '{"dJobCd":"K000001610","dJobCdSeq":"1","dJobNm":"가정용전기기구제조기술자","workSum":"가정용 전기·전자제품을 제조하기 위하여 연구·설계·개발하며 제품양산을 위해 생산라인에서 감독·지원·조언한다.","doWork":"신제품 개발을 위한 시장조사 및 원가구조를 검토하여 사업성 여부를 결정한다. 개발하고자 하는 제품의 형상을 구체화하고 디자인 부문에서 고안된 형상에 맞춰 회로 및 부품을 설계하고 금형 및 부품을 개발한다. 시제작된 제품의 성능과 내구력 등을 시험하여 평가·개선한다. 시제품을 생산라인에 직접 적용하여 생산라인에서 제품을 조립할 수 있는지 여부를 평가한다. 개발된 제품의 형식승인 및 산업소유권에 관한 국내외 표준을 취득·관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"가정용전기기구개발원, 가정용전기제품개발원, 가정용전기제품제조기술자, 가정용전기기구설계기술자, 가정용전기제품설계기술자","connectJob":"부품을 연구·설계·개발하면 가정용전기부품설계기술자","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"C285","dJobICdNm":"[C285]가정용 기기 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002244:1', '{"dJobCd":"K000002244","dJobCdSeq":"1","dJobNm":"건축전기설비감리원","workSum":"전기설비의 시공, 보수공사가 설계도서 및 기타 관계서류의 내용대로 시공되는지 감독·확인한다.","doWork":"전기설비 감리업무 수행에 요구되는 절차와 세부내용을 발주자, 건설사, 공사업자 등과 협의한다. 공사시공에 사용되는 설계도서의 내용이 관련법규에 충족하는지, 그리고 시공에 적합한지 여부를 검토한다. 전기설비의 규격, 수량 등이 공사계약서와 일치하는지, 품질확보에 적합한지 검토·확인한다. 공사 또는 감리에 관한 변경설계도서, 계획서 및 감리결과보고서를 작성한다. 문제점이 발생할 경우 재시공을 지시하거나 작업을 중지시키며 발주자에게 보고한다. 작업환경 및 작업자의 안전 등을 점검하며 이에 대한 기술지도를 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"감독","workFunc3":"수동조작","similarNm":"건축전기감리기술자, 전기감리기술자","certLic":"건축전기설비기술사, 전기기사, 전기산업기사","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"F423","dJobICdNm":"[F423]전기 및 통신 공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006805:1', '{"dJobCd":"K000006805","dJobCdSeq":"1","dJobNm":"건축전기설비기술자","workSum":"빌딩, 플랜트, 상가, 아파트 등의 건축구조물에 전력인입설비, 수변전설비, 예비전원설비, 동력설비, 조명설비, 특수설비, 접지·피뢰설비 및 기타 약전설비와 같은 전기설비의 기본계획을 수립하고 설계 및 시공에 따르는 안전성 확인, 감리 등의 업무를 한다.","doWork":"전기인입, 배선(Route), 구내변전소 위치, 부하용량 등을 검토하여 건축물 내 전기설비에 대한 계획 및 타당성 조사를 한다. 수변전설비, 조명, 동력설비, 약전설비, 전기배선설비, 전기부하설비, 자동화설비, 승강기설비, 전기방재설비, 예비전원설비, 감시제어설비 등 건축물 내 전기설비에 대한 기본설계 및 상세설계를 한다. 시공에 따른 문제점에 대한 기술지원 및 해결방안 제시, 현장감독 및 감리업무를 한다. 차단기, 개폐기, 유입차단기, 변압기 등과 같은 전기기기의 안전성과 조작상태를 측정(접지저항측정, 절연저항측정 등)하고 시험(절연내력시험, 보호계전기시험, 시퀀스시험, 내전압시험, 절연유시험 등)하여 점검한다. 시공에 따르는 안전성 검사와 감리업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","similarNm":"건축전기설비설계기술자","certLic":"건축전기설비기술사, 전기응용기술사","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"F423/M721","dJobICdNm":"[F423]전기 및 통신 공사업 / [M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003415:1', '{"dJobCd":"K000003415","dJobCdSeq":"1","dJobNm":"계장기술자","workSum":"산업용 플랜트(기계, 전기, 화공 등)나 건설용 장비(운송장비 등)의 자동제어, 계측장치 등을 설계·제작·조정한다.","doWork":"현장설비 배치도나 장비에 따라 계장계통도 및 작업순서 등을 계획한다. 계통도에 따른 계기의 종류를 산출하고 계측장치 및 제어장치의 계기위치 및 계장부대설비에 관하여 설계한다. 공사사양서 또는 시공계획서를 작성한다. 계장공사에 대해 감리, 감독을 한다. 공사완료 후 시험가동을 하여 안전성 및 문제점 등을 보완·개선한다. 자동제어장치, 계측장치 등 전기계장장치의 기술연구, 테스트, 실험업무를 수행하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"전기계장기술자, 전기제어기술자, PLC전기제어기술자, 전기제어기술지원엔지니어","connectJob":"계장공","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"C281","dJobICdNm":"[C281]전동기, 발전기 및 전기 변환ㆍ 공급ㆍ제어 장치 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006764:1', '{"dJobCd":"K000006764","dJobCdSeq":"1","dJobNm":"반도체장비전장개발자","workSum":"반도체장비의 전원 관련 국제표준 및 고객 요구수준을 이해하고, 전원부, 전력변환부, 전기제어부에 대하여 전력용량을 계산한 다음, 적합한 소자를 선정하여 전장 패널을 설계한다.","doWork":"반도체장비 설치장소의 전압 및 전력사양에 대해 조사하고, 장비 입력전원의 최소·최대용량을 계산한다. 전장설계 시뮬레이션을 통해 전력량을 계산하고, 장비 부하용량을 결정한 다음 전압강하를 계산하여 입력용량 및 보호기기의 규격을 결정한다. 장비 전력소자의 종류와 허용용량을 확인하고, 전력용량에 적합한 전력소자를 선정한다. 전력소자와 기타 전장부품가의 호환관계를 고려하여 설계하며, 전력소자의 전자파의 발생 및 세기를 시뮬레이션하여 전력소자의 전자파에 대한 차폐 및 감축방안을 도출한다. 고객 요구사항과 장비 설치환경에 적합한 전장 패널 설계사양서를 작성하고, 설치환경과 안전을 고려하는 전장설계부품과 재료를 선정하여 설계에 반영한다. 전력설비와 전기제어장치를 도면이나 파일형태로 설계하고, 고객 요구사항에 따라 유무선을 활용한 외부연결 제어기기를 설계한다. 전장패널의 공간위치를 고려하여 배치하고, 유지보수가 가능하도록 설계한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 반도체장비의 전장설계기술을 시험평가하고, 최적화하는 연구·개발활동을 단독 또는 공동으로 수행한다. 전장설계과정에는 반도체장비의 전력공급 및 관리에 있어 최고의 품질 및 유지관리를 고려한 전장설계 및 장비응용기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체장비연구원","connectJob":"반도체전장설계연구원, 반도체장비전장설계기술자","certLic":"전기기사","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006737:1', '{"dJobCd":"K000006737","dJobCdSeq":"1","dJobNm":"발전계전연구원","workSum":"발전용 계전설비, 보조설비 등의 안정성 및 신뢰성 향상과 효율적 운영, 관리, 유지, 정비를 위하여 기술연구 및 개발업무를 수행한다.","doWork":"발전 및 각종 플랜트의 제어계측시스템을 연구·개발하고, 설비의 운영 및 관리를 위한 기술을 지원한다. 화력발전소, 복합발전소 및 산업용 열병합 설비의 보일러제어시스템, 각종 회전기기의 출력과 속도제어시스템, 전동기 속도제어시스템, 원자력발전에 관련된 디지털제어시스템 등을 연구·개발한다. 발전설비의 안정적 운영을 위하여 회전체 및 구조물의 소음진동진단기술을 지원하고, 제어시운전, 터빈·보일러제어기술, 발전기제어기술, 직류송전변환기술 등의 지원업무를 수행한다. 발전용 계전설비의 고장원인을 진단하는 기술을 개발하고 설비고장 원인규명, 운영, 진단 및 정비에 대한 기술을 지원한다. 기타 연구원(일반)들이 수행하는 일반적인 활동을 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","similarNm":"발전용계전설비연구원, 발전용계측제어장비연구원","certLic":"전기기사","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005008:1', '{"dJobCd":"K000005008","dJobCdSeq":"1","dJobNm":"발전설비연구원","workSum":"발전소의 설비를 진단·보수하며, 효율적인 운영을 위한 연구·개발업무를 수행한다.","doWork":"발전소의 보일러, 터빈 및 연료공급설비, 공기공급설비, 각종 펌프류와 같은 회전기기 및 그와 관련된 주요 부속장치의 이상진단 및 예방진단을 실시한다. 기존 발전설비의 성능진단을 실시하고 진단결과에 대한 자료해석을 통하여 시설물 교체, 세정, 정비 및 청소 등의 시기를 결정하거나 효율향상 및 효율관리를 위한 대안을 제시한다. 건설된 발전시설이 계약서상의 요구조건을 충족하는지 인수성능시험을 실시하고 결과를 관련 부서에 통보한다. 고열이 발생하는 가스터빈의 버킷, 블레이드(Blade:추진기 따위의 날개) 등 주요 고온재료를 국산화하기 위한 연구·개발업무를 수행한다. 운영 중인 발전설비의 장수명화를 위하여 설비재료 표면의 코팅기술을 개발한다. 발전시설물 및 보조기기의 이상 및 손상에 대한 정확한 원인분석을 통해 손상해석기술을 연구·개발한다. 발전설비에서 발생하는 각종 진동 및 소음 방지를 위해 연구·개발한다. 발전설비의 효율성을 높이고, 에너지를 관리하기 위한 진단 및 현장지원업무를 수행한다. 기타 연구원(일반)들이 수행하는 일반적인 활동을 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","connectJob":"발전설비에 따라 화력발전설비연구원, 열병합발전설비연구원, 복합화력발전설비연구원, 디젤발전설비연구원, 지열발전설비연구원, 수력발전설비연구원, 핵발전설비연구원, 폐열발전설비연구원, 가스발전설비연구원, 청정발전설비연구원, 연료전지발전설비연구원, 조력발전설비연구원, 태양광발전설비연구원","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002684:1', '{"dJobCd":"K000002684","dJobCdSeq":"1","dJobNm":"발전책임운전원","workSum":"발전소의 정상적인 기동, 가동, 정지를 위하여 발전설비 및 보조기기의 동작상태를 점검·기록하며, 발전설비조정제어원의 업무를 관리·감독한다.","doWork":"발전기, 터빈, 보일러, 송·변전설비, 전기설비 및 기타 보조기기 등에 대한 순시를 통하여 이상 유무와 장애요인을 점검한다. 발전설비조정제어원(조정제어실에서 배전반을 제어·운전하여 발전기의 출력, 전압, 주파수 등을 조정하는 작업원)의 활동을 관리·감독한다. 발전설비의 운전기록 및 인계일지 등을 검토하고 중요사항을 보고한다. 설비의 이상기기 수리 후 시운전에 입회하여 기기성능을 확인하고 주요기기의 조작 시 입회하여 기술을 지원한다. 조작사항 및 특기사항을 작성하고 인계일지에 기록하여 인계한다. 기동 및 정지 시 각 단계별 주요기기의 조작을 감독 및 지원한다. 정기보수공사 및 주요기기 보수 시 보수내용을 파악하고 보수에 관련된 조작사항을 해당기기 운전원에게 지시한다. 각종 기기 조작 전에 작업승인표(Red-Tag)를 발행하고 보수완료 후에는 작업승인표를 정리한다. 돌발사고에 대한 사항을 정리하여 관리하고 주요사항을 기록하여 인계한다. 발전설비조정제어원의 직무교육, 근태사항, 작업활동 등을 관리·감독한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","similarNm":"발전소배전반운영반장, 발전소배전반조작반장","connectJob":"발전설비에 따라 화력발전책임운전원, 열병합발전책임운전원, 복합화력발전책임운전원, 디젤발전책임운전원, 지열발전책임운전원, 수력발전책임운전원, 핵발전책임운전원, 폐열발전책임운전원, 가스발전책임운전원, 청정발전책임운전원, 연료전지발전책임운전원, 조력발전책임운전원, 태양광발전책임운전원","certLic":"전기기사, 전기공사기사, 에너지관리기사","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001738:1', '{"dJobCd":"K000001738","dJobCdSeq":"1","dJobNm":"발전효율관리원","workSum":"고효율·저원가전력을 생산하기 위하여 보일러, 터빈, 발전기 등 발전설비의 운전상태를 파악하고, 타당성을 검토하여 적정운전 여부 판단 및 효율저하요인 대책을 수립한다.","doWork":"발전설비의 운전자료를 기초로 발전량, 소비전력량, 연료사용량 등을 점검하고, 연료의 발열량을 확인하여 발전효율계산에 필요한 자료를 작성한다. 발전량, 연료사용량, 주요기기의 운전실적자료 등을 통해 일일성능 및 발전효율저하 원인을 분석한다. 지역사회 내 상황, 투자비 등을 고려하여 발전설비의 추가, 확장, 사용연한, 폐기 등의 타당성을 검토한다. 전력거래 입찰 및 계량업무를 한다. 성능저하요인을 검토하여 효율향상방안을 수립하고, 발전설비의 단위기기별 발전손실량을 측정·계산하여 적정운전 여부를 판단한다. 주요 발전기기의 운전시간, 발전실적, 일일 최대부하 시 주요운전항목 등을 기록·정리한다. 월간 발전실적을 종합·분석하여 발전효율, 전력량결정서 등을 작성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","certLic":"전기기사, 에너지관리기사","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002909:1', '{"dJobCd":"K000002909","dJobCdSeq":"1","dJobNm":"배전공사기술자","workSum":"전력수요의 확장 및 안전한 공급을 위하여 신·증설 수용가의 신규수용 배전공사와 건축물 관련 배전선로 이설공사의 설계 및 시공을 감독하고, 승압업무를 수행한다.","doWork":"배전설비 신·증설계획에 따라 현장조사를 통해 경과지, 계통구성 등을 선정한다. 배전설비, 지중배전선로 이설, 설비보강공사 등에 관한 설계를 하고, 공사에 따른 시공감독을 한다. 배전설비의 신·증설에 따른 도로점용 및 도로굴착 등의 허가 또는 신고서류를 작성하여 해당관서에 제출하고 협의한다. 신규고객을 관리한다. 배전설비 자재의 청구·구매·검수업무를 한다. 승압추진계획을 수립하여 승압공사에 따른 설계 및 시공감독, 전력량계 취부 및 봉인, 종합강압기제거 시공에 따른 협조 등의 승압업무를 한다. 지중배전설비의 신·증설공사설계 및 시공감독, 가공설비의 지중화 관련 조사, 지중설비의 유지·보수 등의 지중배전업무를 수행한다. 배전설비의 효율적인 운영·관리를 위하여 전력손실에 대한 분석 및 대책을 수립한다. 배전공사에 따른 각종 정보자료를 전산화하고 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|","workFunc1":"분석","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"배전설계원, 배전설계기술자","connectJob":"송배전설비공사기술자","certLic":"전기기사, 전기공사기사, 전기산업기사, 전기공사산업기사","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"F423","dJobICdNm":"[F423]전기 및 통신 공사업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003808:1', '{"dJobCd":"K000003808","dJobCdSeq":"1","dJobNm":"배전기술연구원","workSum":"배전계통의 안정적인 전기품질을 유지하고, 배전기기의 효율적인 운영기술을 개발하며 전력을 수요자에게 안정적으로 공급하기 위한 스마트배전기술을 개발·연구한다.","doWork":"변압기, 개폐기, 애자(전기도체 절연 및 지지 목적으로 사용되는 고체절연물) 및 피뢰기(선로, 전기기기 등을 이상전압으로부터 보호하는 장치) 등과 같은 배전설비의 고장분석, 열화평가 및 진단기술, 고장예지방법, 이상전압 및 접지해석 등 운영기술을 연구한다. 배전계통이 안정적으로 공급될 수 있도록 전기품질 및 분산전원기법을 개발한다. 고조파(기본 주파수의 정수배 주파수를 갖는 것), 플리커(Flicker:주파수가 낮으면 깜박깜박하는 빛의 감각이 일어나는 현상) 등 전기품질관련 기준을 수립·표준화하여 현장에 지원한다. 배전계통 부하 예측, 배전선로 구성의 최적화, 배전용 변전소의 최적입지 선정, 개폐기 조작을 통한 부하평준화 및 손실최소화, 신뢰성 및 경제성을 고려한 투자우선순위 결정 등에 대한 연구를 수행한다. 원거리 개폐기의 원격감시, 원격제어, 원격계측, 원격셋팅 기능의 배전자동화시스템을 개발한다. 배전자동화를 위한 자동화개폐기 설치위치 선정, 배전자동화 이상동작 원인분석, 배전선로 보호를 위하여 기술을 개발하여 현장에 지원한다. 실증시험을 이용하여 장기열화시험, 배전계통구성 및 운영기준을 수립하고 제시한다. 배전설비에 대한 전기화재 감식, 화재사고 원인·분석과 전기안전사고에 대한 원인을 분석한다. 기타 배전기술을 향상시키기 위한 연구를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","certLic":"전기기사, 전기공사기사","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002581:1', '{"dJobCd":"K000002581","dJobCdSeq":"1","dJobNm":"배전사령원","workSum":"배전계통에서 양질의 전력을 안전하게 공급하기 위하여 배전계통의 운전상태를 감시하고, 배전선로의 계통조작을 지시한다.","doWork":"전원개발계획에 따른 배전선로의 증설 및 변경사항을 파악하고, 변화된 수용가의 전력량을 확인한다. 배전계통의 운전상태를 감시하며, 이상발생 시 수리하도록 배전보수원에게 지시한다. 휴전계획서를 참고하여 휴전시행 전 휴전구간의 부하상태, 개폐기 조작점의 변동 유무, 사전안내 여부 등을 확인한다. 정전·휴전, 배전선로의 돌발사고, 배전설비의 가동상황 등을 보고받아 적절한 계통조작을 지시한다. 휴전작업 시행결과에 대한 보고서를 작성한다. 배전선로의 신·증설공사, 개·보수공사 및 계통운영상 변경이 요구되는 경우 배전계통도의 정비를 지시하고, 변경사항을 관련 계통운전담당자에게 통보한다. 각 변전소의 보고내용 및 지시사항을 기록 및 정리하여 보고자료를 작성한다. 관내 계통의 부하분포, 중요 집단수용 등을 확인하여 사고발생 시 공급우선순위를 결정한다. 자동화개폐기설치위치, 복구현장 등을 순시하여 사고복구지령의 참고정보로 활용한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"보선사령원","certLic":"전기기사, 전기공사기사, 전기산업기사, 전기공사산업기사 ","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002094:1', '{"dJobCd":"K000002094","dJobCdSeq":"1","dJobNm":"배전설비보수기술원","workSum":"배전설비 보수작업에 기술을 지원하고, 공사감독 및 관련 기술행정 업무를 수행한다.","doWork":"배전선로 및 배전설비에 대한 보수시행계획을 수립하여 양질의 전력이 원활히 공급될 수 있도록 지원한다. 저전압 해소공사, 취약 경과지 변경공사, 주요 공업단지 공급선로 보강공사, 지장전주 이설공사에 대한 설계 및 시공감독업무를 수행한다. 배전설비에 대한 보수작업 시 시공업체에 대한 자격평가, 발주, 인·허가 관련 대관업무, 시행 및 승인업무를 수행한다. 휴전계획을 수립하고, 휴전 및 정전에 대한 수용가의 불편을 신속히 해소하기 위하여 보수공사에 대해 관리·감독한다. 각종 기자재에 대한 품질평가를 통하여 하자가 생긴 물품을 처리한다. 기타 배전설비의 보수 관련 기술지원 및 기술행정 업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"배전설비기술자","certLic":"전기산업기사, 전기공사산업기사, 전기기사, 전기공사기사 ","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001729:1', '{"dJobCd":"K000001729","dJobCdSeq":"1","dJobNm":"변전기술연구원","workSum":"변전설비가 안정적인 전력공급을 하도록 변전소의 건설 및 운영에 필요한 기술, 고장진단기술, 송변전계통 절연설계기술 등의 개발 및 연구업무를 수행한다.","doWork":"변환설비의 고장·기능·동작에 대한 분석, 낙뢰에 대한 연구, 각종 대기 중 오손물에 의한 영향과 대책연구, 계통운전과정에서 발생하는 과전압 해석 및 고장원인 분석, 접지기술 연구 등을 통하여 직류송전, 낙뢰사고 및 전력계통 과도현상에 대한 대책방안을 수립한다. 전자기파 및 음향신호 검출, 가스분석 등을 통해 가스절연개폐장치, 변압기 등 주요설비의 고장원인을 분석한다. 낙뢰사고 방지를 위한 접지설계, 악조건 및 특수지역 또는 조건이 나쁜 변전소의 접지설계, 낙뢰사고 방지를 위한 접지설계, GIS(Gas Insulated Switchgear) 열화진단 및 고장원인 분석 등을 통하여 기술개발 및 연구업무를 수행한다. 변전소 설계기술, 저소음기기 및 기기 파열방지기술 등 기타 변전기술개발을 위해 연구한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workEnv":"위험내재|소음·진동|","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","certLic":"전기기사, 전기공사기사","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003177:1', '{"dJobCd":"K000003177","dJobCdSeq":"1","dJobNm":"변전정비기술원","workSum":"변전소의 안정적인 운영을 위하여 변전설비 점검, 고장 개소의 정비, 노후설비의 교체 및 유지보수, 보수공사에 따른 설계, 시공, 감독 및 관리업무를 수행한다.","doWork":"변전설비의 정상적인 운영을 위하여 각종 기기를 점검한다. 자료를 수집하여 변전설비의 철거, 보강, 교체 여부 등을 검토한다. 취약 및 노후설비에 대한 정비방안을 입안하여 정비계획을 수립한다. 관할변전소의 개폐기류, 지지애자, 피뢰기 등의 변전기기와 변전설비에 대한 정기적인 성능시험을 통하여 이상 유무를 점검한다. 관내 변전소별 예비기기와 비상자재의 보유현황을 파악하여 대장을 관리한다. 사용에 따른 변동사항을 기록·정리한다. 각종 변전설비에 대한 개·보수 및 신·증설에 따라 현장을 조사한다. 시공방법, 작업조건 등을 검토하고 설계도면을 작성한다. 각종 변전설비 공사에 따른 감독, 관리와 공사 준공처리업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"감독","workFunc3":"정밀작업","certLic":"전기기사, 전기공사기사","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003098:1', '{"dJobCd":"K000003098","dJobCdSeq":"1","dJobNm":"사무용기기기술자","workSum":"복사기, 팩시밀리(FAX와 유사) 등의 사무용기기를 연구·설계하고 개발한다.","doWork":"신속한 사무처리에 적합한 장치와 기계를 연구·설계한다. 개발된 사무기기를 시험제작하여 제품의 성능을 확인한다. 시제품에서 발생하는 문제점을 분석하고 문제점의 개선책에 대하여 연구한다. 생산 시 발생되는 생산비용을 산출하고 공정도를 작성한다. 개발된 제품을 생산할 때는 각 부품의 생산 또는 조립상황을 감독하고, 생산품을 검사하여 제품 설계내용과 생산제품을 비교·검토한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"사무용기기술자, 사무용기계기술자","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"C291","dJobICdNm":"[C291]일반 목적용 기계 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006790:1', '{"dJobCd":"K000006790","dJobCdSeq":"1","dJobNm":"송변전기술연구원","workSum":"안정된 송·변전설비에 관한 기술을 개발하고, 고장진단 및 유지보수 등에 대한 제반 기술개발 연구업무를 수행한다.","doWork":"송·변전설비의 전자계 측정·영향분석, 송전선로 스페이서(Spacer) 사고요인 분석, 초고압송전 관련 기기 국산화, 기기 내구성 시험분석 등을 통하여 초고압송전 및 전기환경개선을 위한 대책기술을 개발한다. 고압직류변환설비의 고장, 기능·동작에 대한 분석, 낙뢰에 의한 사고분석, 과도현상에 의한 설비의 고장원인 분석 등을 통하여 직류송전, 낙뢰사고 및 전력계통 과도현상에 대한 대책방안을 수립한다. 변압기 열화 및 고장원인 분석, 낙뢰사고 방지를 위한 접지설계, 악조건 및 특수지역 변전소 접지설계, 낙뢰사고 방지를 위한 접지설계, GIS, 변압기 및 커패시터(Capacitor:축전기)의 열화진단 및 고장원인 분석 등을 통하여 기술개발연구를 한다. 송전선설계 및 운영, 송전선 및 송전탑에 대한 규격 및 수명예측, 지중송전케이블의 운영 등 송전기술향상을 위한 분석 및 개발을 한다. 광 및 조명에 대한 기술개발을 위하여 방전등 및 일반 조명, 레이저-분광응용, 광센서 및 광계측, 초고주파공학 등을 연구한다. 기타 송·변전 기술개발을 위한 각종 연구를 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","certLic":"전기기사, 전기공사기사","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006107:1', '{"dJobCd":"K000006107","dJobCdSeq":"1","dJobNm":"송전기술연구원","workSum":"전력공급 송전선로의 건설 및 운용에 대한 기술개발, 제반 연구업무를 수행한다.","doWork":"송전설비의 전자계 측정·영향분석, 전력설비의 전자계 및 각종 전기환경에 대한 평가 및 저감설계 기술개발, 송전선로 스페이서 사고요인 분석, 기기 내구성 시험분석 등을 통하여 환경친화적 초고압송전 및 전기환경개선을 위한 기술을 개발한다. 송전선로 건설에 필요한 설계 및 운영, 송전선 및 송전탑에 대한 규격 및 수명 예측, 지중송전케이블의 운영 등 송전기술향상을 위해 분석 및 개발한다. 지중송전선로 설비의 안전성 및 초고압케이블의 신뢰성 확보를 위한 실증시험장의 부지선정, 시험선로, 진동시험설비, 전기환경모의시험설비, 충격전압시험장 등을 관리하며 가공, 지중송전설비 설계, 건설, 운용에 대한 기술을 개발·연구한다. 애자의 수명예측 및 교체기준을 제시하기 위해 급준파시험, 경년가속열화시험, 과전가속열화시험, 물성실험 등을 실시하여 시멘트 및 자기열화의 요인을 분석한다. 기타 연구원(일반)들이 수행하는 일반적인 활동을 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"웅크림|","workEnv":"위험내재|소음·진동|","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","certLic":"전기기사, 전기공사기사","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003896:1', '{"dJobCd":"K000003896","dJobCdSeq":"1","dJobNm":"송전설비관리원","workSum":"송전설비의 안정된 운용을 위하여 송전선로 및 설비를 유지·관리하고 송전설비를 순시·점검하는 작업자의 활동을 관리·감독한다.","doWork":"관내 철탑, 가공송전선로, 지중송전선로, 전력선 및 기타 부속물과 같은 송전설비에 대한 보강계획자료를 수집·검토하여 보수계획을 수립한다. 관내 송전설비의 선로별 담당 송전전기원의 구간 및 일정에 대한 순시점검계획을 입안한다. 확정된 계획에 따라 설비를 순시·점검하도록 지시한다. 순시점검 결과보고에 대한 불량사항 또는 장애요소를 파악·조사하여 대책을 입안하고 보수하도록 지시한다. 관련 대장을 기록·관리한다. 고압전류가 흐르는 전력선의 애자이상 및 장애요인을 파악하도록 관련 작업자에게 지시하고 작업실적을 기록하여 보고한다. 송전설비의 개·보수공사에 따른 시공설계 및 공사관리를 한다. 관련 인·허가 및 행정업무를 처리한다. 송전설비의 효율적 운영을 위한 설비현황, 경과지도 및 각종 도면을 관리한다. 관내 송전설비의 유지·보수에 대한 실적을 작성하여 보고한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"송전설비기술자, 송전설계원","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005818:1', '{"dJobCd":"K000005818","dJobCdSeq":"1","dJobNm":"수도사업전기설비기술원","workSum":"상수도 및 하수도 관련 전기설비를 유지·관리하고, 고장정비를 위한 기술지원을 한다.","doWork":"수도전기설비의 개량 및 유지·보수를 위한 예산안 및 계획을 수립하고 수립된 계획에 따라 설비를 점검하고 정비한다. 수·변전설비, 변전소, 차단기, 전동기 등을 포함한 전기설비를 점검하여 안전한 수돗물을 공급할 수 있도록 유지·관리한다. 관할 사업장을 순회하며 전력설비 및 전기설비의 정기검사를 통하여 사고발생을 예방한다. 각 사업장에 발생한 고장 및 장애요인을 제거하기 위한 기술지원을 한다. 각 사업장의 전기설비 운영실적을 분석하고 에너지 절약을 위한 방안을 강구한다. 전기설비의 정비계획, 자재확보, 불량요소 해소 등을 위하여 전기설비의 기기이력관리를 한다. 기타 수도전기설비의 효율적 운영을 위한 기술자료수집과 기술개발을 위한 연구업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|고온|소음·진동|","workFunc1":"분석","workFunc2":"교육","workFunc3":"정밀작업","certLic":"전기공사기사, 전기산업기사, 전기기사","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"E360","dJobICdNm":"[E360]수도업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007447:1', '{"dJobCd":"K000007447","dJobCdSeq":"1","dJobNm":"수력발전개발자","workSum":"수력발전소(소수력발전 포함) 건설을 위한 타당성 조사, 인허가, 발전설비와 관련된 시스템을 분석하고 적용한다.","doWork":"지형, 유량, 유속, 환경보호, 지역사회 등을 고려하여 수력발전소 건설입지를 선정하고 발전방식(수로식, 댐식, 댐수로식, 유역변경식, 양수식 등) 및 발전소 용량, 설비배치, 주기기 및 보조기기 기본 규격 등을 결정한다. 수력발전의 경제성 분석과 더불어 정책, 제도개선, 환경영향, 인허가 등의 문제를 해결하기 위해 관련 전문가들과 협의한다. 수력발전시스템의 최적화 운영 및 계통병입 안전장치를 분석하고 반영을 결정한다. 수력발전이 가능한 자원을 조사하거나 개발 활성화방안을 분석하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"수력개발자, 소수력발전개발자","connectJob":"발전사업 개발자, 발전사업 설계사","certLic":"발송배전기술사, 전기응용기술사, 전기공사기사, 전기기사, 기계기술사, 일반기계기사, 토목구조기술사, 건축전기설비기술사, 토목기사","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001789:1', '{"dJobCd":"K000001789","dJobCdSeq":"1","dJobNm":"수력발전시스템기술자","workSum":"소수력발전소를 포함한 수력발전소의 설계, 시공, 유지보수 등을 담당하고 발전기, 수차, 보조설비를 유지관리한다.","doWork":"수력발전개발계획에 따라 수력발전개발자가 선정한 입지에 따른 적합한 발전시스템과 기기를 상세 설계한다. 발전용량을 계산하여 각 설비의 수량 및 규격을 계산하고, 보조설비의 배치 및 연결방법을 결정한다. 수력발전설비 및 시스템의 설치작업을 책임지고, 수력발전설비 설치원들을 감독한다. 수력발전소가 정상적으로 전기를 생산할 수 있도록 중앙제어실에서 수력발전의 상태 및 현황 등을 모니터링한다. 발전소설비 현장을 순회하면서 각종 전기 및 기계설비의 작동상태를 점검한다. 수력발전소의 현장특성을 반영한 수차, 발전기, 보조기기의 성능평가를 통하여 체계적 성능관리와 최적 성능상태에 대한 분석 및 노후 발전설비의 손상해석과 수명연장 등에 관하여 분석한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"종합","workFunc2":"협의","workFunc3":"관련없음","similarNm":"수력발전설비설계기술자, 수력발전정비사","connectJob":"발전설비설계사, 발전설비정비사","certLic":"발송배전기술사, 전기응용기술사, 전기공사기사, 전기기사, 기계기술사, 일반기계기사","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004426:1', '{"dJobCd":"K000004426","dJobCdSeq":"1","dJobNm":"수력발전연구원","workSum":"수력발전(소수력발전포함) 시스템, 댐 설계, 발전방식의 효과분석, 관련 구성기기 및 설비에 대한 기술을 연구·개발한다.","doWork":"수력발전(위치에너지를 전기에너지로 바꾸어 전력을 생산)시스템과 발전기를 연구한다. 발전방식(수로식, 댐식, 댐수로식, 유역변경식, 양수식 등)에 적합한 최적의 시스템 및 효과를 분석하고 터빈 등의 관련 설비를 연구·개발한다. 다양한 장소(발전용댐, 다목적댐, 농업용 저수지 및 보, 하수처리장, 정수장 등)에 적용할 수 있는 방법을 연구하고, 그에 맞는 효율적인 시스템을 개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"소수력발전연구원, 수력연구원","connectJob":"발전전문연구원","certLic":"발송배전기술사, 전기응용기술사, 전기공사기사, 전기기사, 기계기술사, 기계설계기사, 일반기계기사","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001830:1', '{"dJobCd":"K000001830","dJobCdSeq":"1","dJobNm":"스마트그리드망운영원","workSum":"통합운영센터(TOC:Terminal Operation Company)에서 전력거래 일정에 따라 스마트그리드(Smart Grid:지능형 전력망) 전력계통 및 전력시장 운영을 담당한다.","doWork":"거래 전일 마감시간까지 입찰된 일반수요, 수요감축, 수요측 발전입찰 내용을 바탕으로 수요예측자료를 수집한다. 수집된 자료를 분석하여 최적화 발전계획을 수립한다. 실시간 발전기 운전상태를 점검하고, 낙찰된 발전량 등에 따라 실시간 발전계획을 수립하고 전력가격을 발표한다. 급전가능자원(발전 및 수요감축(DR))에 대한 급전지시를 내린다. 실시간 전력거래 및 실시간 계통운영을 수행하며 전력의 흐름, 전력계통 신뢰도 등을 감시한다. 정산 관련 계량자료를 취득하여 정산명세서를 발행한다. 운영실적을 분석하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"스마트그리드서비스운영원, 스마트그리드통합운영원, 지능형전력망운영원","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006932:1', '{"dJobCd":"K000006932","dJobCdSeq":"1","dJobNm":"스마트그리드제품개발원","workSum":"전력망에 정보기술을 접목하여 전력공급자와 소비자가 양방향으로 실시간 정보를 교환함으로써 에너지 효율을 최적화하는 차세대지능형전력망 제품을 개발한다.","doWork":"부하감지내장형변압기, 디지털변전소종합운영시스템, 스마트에너지시스템, 스마트그리드 및 스카다(SCADA:Supervisory Control And Data Acquisition)용 보완관제 솔루션 등 차세대 지능형 전력망 핵심제품을 개발한다. 변압기 내부에 부하상태를 측정할 수 있는 센서와 데이터처리 단말장치를 일체화하여 측정데이터를 무선통신을 통해 서버로 전송해 관리자가 온라인상태에서 변압기의 동작상태를 손쉽게 모니터할 수 있는 신개념 변압기감시진단시스템을 개발한다. 스마트그리드 단지에 설치하여 전력설비 보호를 위한 전압·전류계측·제어 명령 등의 기능을 수행하고 상위 HMI에서는 운용자에게 현장의 운전상황을 시각적으로 구분 표시하여 효율적인 운영을 지원하는 시스템을 개발한다. 실시간으로 에너지 사용량에 대한 정보가 제공되어 전기사용자 스스로 혹은 자동화된 기기제어를 통해 에너지 사용을 제어할 수 있는 핵심 인프라시스템을 개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"지능형전력망제품개발원","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;