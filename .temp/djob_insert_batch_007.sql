INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001252:1', '{"dJobCd":"K000001252","dJobCdSeq":"1","dJobNm":"스마트물류통합관리자","workSum":"스마트물류 플랫폼을 활용하여 물류의 기능들을 최적으로 수행하기 위한 정보통신기술(ICT) 기반의 지능형 물류 서비스를 통합 관리한다.","doWork":"스마트물류 플랫폼을 활용한 정보통신기술(ICT) 기반의 물류서비스 운용을 위한 통합관리 환경을 분석한다. 스마트물류 운영에 있어서 수요 예측과 운영상의 위험을 분석하여 효과적으로 대응한다. 스마트물류 IoT장비운용 계획에 따라 센서, 매핑, 제어를 관리한다. 스마트물류 자원과 장비의 운용상황을 실시간으로 제어할 수 있는 어플리케이션을 운영관리하고, DBMS의 관리 정책에 따라 시스템과 데이터를 유지 관리한다. 지능정보기술을 활용하여 스마트물류 활동 전반에 대한 정보보안과 작업중 일어나는 안전을 관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"정보처리기능사, 정보통신산업기사, 빅데이터분석산업기사, 정보보안산업기사","dJobECd":"1339","dJobECdNm":"[1339]기타 컴퓨터 전문가 및 소프트웨어 전문가","dJobJCd":"2229","dJobJCdNm":"[2229]기타 컴퓨터 시스템 및 소프트웨어 전문가","dJobICd":"C264/J582","dJobICdNm":"[C264]통신 및 방송 장비 제조업 / [J582]소프트웨어 개발 및 공급업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005694:1', '{"dJobCd":"K000005694","dJobCdSeq":"1","dJobNm":"컴퓨터소프트웨어유지원","workSum":"사용자가 불편함 없이 소프트웨어를 사용할 수 있도록 소프트웨어를 점검하여 결함을 해소한다.","doWork":"소프트웨어 사용자의 문의에 대하여 응답을 한다. 설치지시서에 따라 컴퓨터에 소프트웨어를 설치하고 셋업(Set-up)을 한다. 사용자가 상품을 효율적으로 사용하는 데 불편이 없는지를 평가하기 위해 소프트웨어를 검사하고 모니터한다. 소프트웨어를 평가한 보고서를 준비하여 관리자가 참고할 수 있는 제언을 한다. 제품제공자(Vendor)나 서비스전문가(Technician for Service)에게 주요 소프트웨어의 문제 혹은 결함 있는 상품을 알려준다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"정보처리기사","dJobECd":"1339","dJobECdNm":"[1339]기타 컴퓨터 전문가 및 소프트웨어 전문가","dJobJCd":"2229","dJobJCdNm":"[2229]기타 컴퓨터 시스템 및 소프트웨어 전문가","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001903:1', '{"dJobCd":"K000001903","dJobCdSeq":"1","dJobNm":"홀로그램전문가","workSum":"홀로그램(빛의 간섭효과를 이용한 3차원 입체영상 제작기술)을 이용하여 공연, 전시 등을 기획하고 콘텐츠를 생산하며 영상장비를 운영한다.","doWork":"행사, 공연, 전시, 엔터테인먼트 기획자와 홀로그램이 활용되는 장소, 방법, 시간, 환경, 예산 등을 협의한다. 연출, 콘텐츠, 하드웨어시스템 등 전반적인 기획을 한다. 홀로그램 콘텐츠제작방법(CG 또는 촬영)을 결정한다. 홀로그램의 이동, 회전, 속도, 나타남, 사라짐, 음향, 조명 등을 연출하고 스토리보드를 제작한다. 콘텐츠를 CG로 제작하는 경우 3D모델링기법을 활용하고, 촬영하는 경우 비디오카메라로 실물을 촬영하여 활용한다. 배경음악 및 특수효과음을 제작한다. 관객의 시선방향 및 무대높이 등을 확인하고 오디오, 영상, 프로젝터, 조명, 서버컴퓨터, 반사판, 포일(반투명한 스크린), 스피커 등 홀로그램 구성요소(홀로그램시스템)를 현장에 설치한다. 무대감독, 음향감독 등 현장스태프와 협력하고 홀로그램시스템을 운용하여 홀로그램을 구현한다. 홀로그램기술에 따라 플로팅방법, 레이저방법, 미러방법을 활용한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"홀로그램영상공연기획자, 홀로그램기술개발연구원, 홀로그램엔지니어, 홀로그램콘텐츠제작자, 홀로그램영상장비오퍼레이터","dJobECd":"1339","dJobECdNm":"[1339]기타 컴퓨터 전문가 및 소프트웨어 전문가","dJobJCd":"2229","dJobJCdNm":"[2229]기타 컴퓨터 시스템 및 소프트웨어 전문가","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004946:1', '{"dJobCd":"K000004946","dJobCdSeq":"1","dJobNm":"공간정보데이터베이스관리자","workSum":"안정적이고 지속적인 공간정보서비스를 운영하기 위해 공간정보 데이터베이스를 제공 및 갱신하고 관리한다.","doWork":"공간정보서비스의 원활한 운영을 위한 공간정보 데이터베이스의 요구사양 및 품질기준을 확인한다. 품질기준에 따라 검증대상서비스 및 데이터베이스의 검증방안을 도출하고 적용한다. 데이터베이스 유지보수 대상항목을 식별하고 도출한다. 유지보수사안을 해결하기 위한 프로그래밍을 수행한다. 데이터베이스를 기록·저장·수정·이동한다. 공간정보서비스에 관련된 새로운 데이터를 갱신한다. 위성영상, 지도정보 등 다양한 콘텐츠별로 규정된 보안관리규정을 숙지하고 적용한다. 데이터베이스에 관련된 기술지원요청에 대응한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"정보처리기사, 정보처리산업기사, 정보처리기능사, 공간정보융합기사, 공간정보융합산업기사","dJobECd":"1341","dJobECdNm":"[1341]데이터 전문가","dJobJCd":"2231","dJobJCdNm":"[2231]데이터 전문가","dJobICd":"J639","dJobICdNm":"[J639]기타 정보 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005035:1', '{"dJobCd":"K000005035","dJobCdSeq":"1","dJobNm":"데이터베이스관리자","workSum":"데이터베이스시스템의 설치 및 유지와 관련된 업무를 총괄하며 이와 관련하여 교육 및 모니터링을 실시한다.","doWork":"데이터베이스시스템의 설치를 위한 업무분석 및 설계에 참여하여 논리적·물리적 기술을 지원한다. 개발환경 구성을 위한 테이블과 인덱스를 생성한다. 데이터베이스 변경사항 발생 시 기존 기록을 저장하고 수정한다. 실제 서버로의 데이터베이스 이전작업을 한다. 데이터베이스시스템에 대한 보고서를 작성한다. 정기적으로 데이터를 백업한다. 데이터베이스의 속도 및 데이터의 신뢰성에 대한 모니터링을 실시한다. 데이터베이스 관련 기능향상이 있을 때는 유지 및 보수 관련자들에게 정보를 제공한다. 데이터베이스의 변경이나 새로운 시스템이 설치되었을 경우 사용자들을 대상으로 교육을 실시한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"데이터베이스전문가, 데이터베이스매니저, DB매니저, DB전문가","connectJob":"프로그램에 따라 OracleDB전문가, MS-SQL전문가, MySQL전문가, DBA전문가, mSQL전문가","certLic":"SQL전문가, SQL개발자","dJobECd":"1341","dJobECdNm":"[1341]데이터 전문가","dJobJCd":"2231","dJobJCdNm":"[2231]데이터 전문가","dJobICd":"J639","dJobICdNm":"[J639]기타 정보 서비스업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006940:1', '{"dJobCd":"K000006940","dJobCdSeq":"1","dJobNm":"데이터베이스운영원","workSum":"데이터베이스를 설계하고, 최적화를 위한 관리업무를 수행한다.","doWork":"데이터베이스(DB:Data Base) 구축에 앞서 업무를 파악한다. 데이터의 물리구조를 설계한다. 온라인 업무를 위한 라인을 설계한다. 데이터베이스의 크기를 산정하고 최적화 배치를 한다. 온라인가동환경을 구축한다. 데이터베이스의 애플리케이션을 변경관리한다. 구축된 데이터베이스 및 온라인성능의 추이를 분석하고 소프트웨어를 변경하거나 버전을 변경하여 튜닝을 한다. 데이터베이스의 용량을 관리한다. 교대업무 시 시스템을 가동정지하고 시스템을 감시하며 데이터를 백업하고 출력물을 관리하며 각종 통계자료의 후처리를 실시하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"데이터베이스설계가, DB설계가, 데이터베이스개발자, DB개발자","certLic":"정보처리기사, 전자계산기조직응용기사, SQL전문가, SQL개발자","dJobECd":"1341","dJobECdNm":"[1341]데이터 전문가","dJobJCd":"2231","dJobJCdNm":"[2231]데이터 전문가","dJobICd":"J639","dJobICdNm":"[J639]기타 정보 서비스업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004005:1', '{"dJobCd":"K000004005","dJobCdSeq":"1","dJobNm":"데이터분석가(일반)","workSum":"수집된 데이터를 전처리, 분석, 시각화하여 시사점을 도출하고 비즈니스 활용전략을 수립한다.","doWork":"비즈니스 요구사항을 분석하여 목표를 설정한다. 설정된 목표에 맞춰 Hadoop, Spark 기반 빅데이터플랫폼 및 데이터수집시스템을 통해 데이터를 검색하고 수집·분류·정제한다. 빅데이터 분석모델링을 통하여 수집된 데이터에서 목표데이터를 추출하고 분석한다. 분석된 데이터를 시각화한다.  수집된 결과와 도출한 인사이트를 보고서로 작성하고 보고한다. 분석결과를 토대로 사업을 기획하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"빅데이터분석컨설턴트, 데이터컨설턴트, 빅데이터분석가","connectJob":"미디어콘텐츠데이터분석가","certLic":"빅데이터분석기사","dJobECd":"1341","dJobECdNm":"[1341]데이터 전문가","dJobJCd":"2231","dJobJCdNm":"[2231]데이터 전문가","dJobICd":"J639","dJobICdNm":"[J639]기타 정보 서비스업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004912:1', '{"dJobCd":"K000004912","dJobCdSeq":"1","dJobNm":"데이터시각화전문가","workSum":"데이터 분석결과를 효과적으로 그리고 이해하기 쉽게 전달하도록 핵심요소를 타이포그래피, 그리드, 색상 등 시각적으로 표현한다.","doWork":"다양한 형태의 데이터와 분석결과를 시각화하기 위하여 표현규칙, 사용자관점의 시각화 요건을 정의한다. 시각화 요건에 따른 사용자시나리오를 작성하고 핵심요소 및 그래픽요소를 이용하여 스토리보드를 기획한다. 기획된 스토리보드에 따라 시각화를 구현하기 위한 도구와 기술을 선택하고 정보시각화를 위한 접근방법을 결정한다. 분석의 핵심내용을 단순하고 명확하게 전달할 수 있도록 구조적으로 시각화한다. 추가정보를 이용하여 시각화한 그래프를 보정하고 시각표현을 극대화하여 품질을 높이기 위해 타이포그래피, 그리드, 색상, 아이소타이프 등 그래픽디자인을 적용한다. 정보사용자의 행동이나 조작에 따른 반응, 정보시각화의 변화 등으로 정보와 정보사용자 간의 관계확장을 위해 사용자 참여를 유도하는 인터렉션 기능을 구현한다. 최종 디자인된 시각화결과물이 시각적으로 적절하게 구현되었는지 확인한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"Data Visualization Specialist","certLic":"경영빅데이터분석사, ADP","dJobECd":"1341","dJobECdNm":"[1341]데이터 전문가","dJobJCd":"2231","dJobJCdNm":"[2231]데이터 전문가","dJobICd":"J639","dJobICdNm":"[J639]기타 정보 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001573:1', '{"dJobCd":"K000001573","dJobCdSeq":"1","dJobNm":"데이터엔지니어","workSum":"빅데이터서비스 운영지침에 따라 제공서비스를 모니터링하여 서비스의 가용성, 연속성 등을 관리하고 서비스 변경내역을 관리한다.","doWork":"서비스 제공의 안정성을 보장하기 위해 서비스 성능관리기준에 따라 서비스 성능을 측정한다. 서비스 성능개선을 위해 성능지연발생 시 근본원인을 파악하고 제거한다. 서비스 가용성 관리기준에 따라 가용성을 측정하고 서비스 가용성 관리기준 미준수 시 근본원인을 분석한다. 서비스 가용성 향상을 위해 서비스 가용성을 저해하는 근본원인을 제거한다. 서비스 품질보증을 위하여 서비스 변경내역을 관리한다. 사용자 및 서비스 운영자 변화관리를 위하여 서비스 변경 발생 시 변경된 내용을 전파한다. 변경내용이 안정적으로 적용되었는지 확인하기 위하여 제공서비스를 모니터링한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"데이터운영관리원, 빅데이터엔지니어","dJobECd":"1341","dJobECdNm":"[1341]데이터 전문가","dJobJCd":"2231","dJobJCdNm":"[2231]데이터 전문가","dJobICd":"J639","dJobICdNm":"[J639]기타 정보 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005795:1', '{"dJobCd":"K000005795","dJobCdSeq":"1","dJobNm":"데이터품질관리자","workSum":"데이터품질을 향상시키기 위하여 데이터표준화관리, 데이터품질진단, 데이터오류관리업무 등을 수행한다.","doWork":"용어, 도메인, 코드, DB오브젝트 등 데이터표준체계를 설계·개발·개정하고 관련 지침을 작성하며 정기적인 모니터링 등을 통해 데이터표준화업무를 수행한다. 데이터품질지침에 근거하여 입력된 데이터의 오류를 검토하고 시정을 요구하며 오류율 점검 등 데이터품질을 정기적으로 측정하고 개선한다. 데이터품질을 확산시키기 위하여 데이터품질인증, 데이터관리인증, 데이터보안인증 등 객관적인 평가추진과 업무규칙수립을 통해 데이터오류관리업무를 수행한다. 데이터품질 향상을 위한 교육이나 간담회 개최 등 활동을 기획하고 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"1341","dJobECdNm":"[1341]데이터 전문가","dJobJCd":"2231","dJobJCdNm":"[2231]데이터 전문가","dJobICd":"J639","dJobICdNm":"[J639]기타 정보 서비스업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001227:1', '{"dJobCd":"K000001227","dJobCdSeq":"1","dJobNm":"미디어콘텐츠데이터분석가","workSum":"콘텐츠 제작에 필요한 인사이트를 얻기 위해 필요한 데이터를 정의, 수집, 전처리, 분석, 시각화 하여 콘텐츠, 마케팅, 스토리텔링에 활용한다.","doWork":"디지털플랫폼에 글, 이미지, 영상 등으로 되어 있는 콘텐츠를 수집하는 데이터수집시스템을 구축한다. 정성적인 데이터를 별도의 모델링을 통해 정량화하여 대중의 니즈 및 트렌드를 추출하고 분석한다. 분석된 데이터는 시각화 및 보고서 형태로 작성하고 보고한다. 도출된 인사이트를 토대로 콘텐츠 기획 및 제작 그리고 분석에 활용한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"뉴미디어컨설턴트, 뉴미디어데이터분석가, 콘텐츠데이터분석가, 뉴미디어빅데이터","certLic":"빅데이터분석기사","dJobECd":"1341","dJobECdNm":"[1341]데이터 전문가","dJobJCd":"2231","dJobJCdNm":"[2231]데이터 전문가","dJobICd":"ALL","dJobICdNm":"[ALL]전체","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003473:1', '{"dJobCd":"K000003473","dJobCdSeq":"1","dJobNm":"빅데이터아키텍처전문가","workSum":"정보시스템구축을 위해 업무 및 요구사항을 분석하여 모든 업무데이터를 데이터측면에서 체계화하여 설계한다.","doWork":"데이터 요구사항을 분석하고 요구사항에 대하여 검증하여 데이터 요건을 분석한다. 데이터표준화를 위한 구성요소를 파악한다. 데이터표준화원칙을 수립하고 데이터품질유지를 위하여 관리한다. 개념데이터, 논리데이터, 물리데이터를 모델링한다. 범용적인 데이터베이스를 설계하고 데이터베이스의 성능개선업무를 수행한다. 특정업무를 컴퓨터가 이해할 수 있도록 정형화하고 구조화하여 데이터베이스를 설계하기도 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"빅데이터엔지니어","certLic":"데이터아키텍처전문가","dJobECd":"1341","dJobECdNm":"[1341]데이터 전문가","dJobJCd":"2231","dJobJCdNm":"[2231]데이터 전문가","dJobICd":"J639","dJobICdNm":"[J639]기타 정보 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004026:1', '{"dJobCd":"K000004026","dJobCdSeq":"1","dJobNm":"빅데이터전문가","workSum":"사람들의 행동패턴 또는 시장의 경제상황 등을 예측하며 데이터 속에 함축된 트렌드나 인사이트를 도출하고 이로부터 새로운 부가가치를 창출하기 위해 대량의 빅데이터를 관리하고 분석한다.","doWork":"분석목표에 따라 빅데이터의 분석방법을 기획한다. 분석할 빅데이터자원을 수집한다. 대용량의 데이터를 처리하는 플랫폼을 활용하여 처리, 분석한다. 분석방법에 따라 마이닝(데이터마이닝, 텍스트마이닝, 오피니언마이닝), 계량정보 분석(계량서지학, 계량정보학, 웹계량화), 네트워크 분석(사회네트워크 분석, 지식네트워크 분석, 언어네트워크 분석), 복잡계기법 분석(복잡계네트워크 분석, 행위자 기반모형, 시스템다이나믹스), 클러스터 분석(비슷한 특성을 가진 개체를 합해서 유사그룹을 발굴) 등을 활용한다. 프로그램을 사용하여 분석결과를 시각화한다. 실시간으로 데이터를 수집·저장·분석하고 시각화하여 의미있는 분석결과를 도출하기도 한다. 빅데이터와 관련된 새로운 기술, 유행, 트렌드 등을 수시로 파악한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"데이터사이언티스트, 빅데이터분석가, 자연어처리전문가","certLic":"빅데이터분석기사, 데이터분석전문가, 데이터분석준전문가","dJobECd":"1341","dJobECdNm":"[1341]데이터 전문가","dJobJCd":"2231","dJobJCdNm":"[2231]데이터 전문가","dJobICd":"J639","dJobICdNm":"[J639]기타 정보 서비스업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007301:1', '{"dJobCd":"K000007301","dJobCdSeq":"1","dJobNm":"임상데이터매니저","workSum":"임상자료관리계획 개발, 데이터베이스구조 개발, 자료입력, 불일치 자료 확인, 논리적오류 확인, 의학적 코딩, 잠금업무 등 임상시험 전체 진행에 대한 임상데이터를 관리하고 지원한다.","doWork":"자료관리 업무 절차설명 및 담당자 명시, 표준작업지침서 및 양식, 데이베이스 구조설명 등을 담은 자료관리계획(Data Management Plan, DMP)을 개발한다. 자료 입력을 위한 데이터베이스 구조 및 변수를 생성하는 데이터베이스구조(Database Structure)를 개발한다. 자료입력을 위한 입력화면(Data Entry Screen, DES) 개발 및 증례기록서상 오류검출을 위한 자료검증방안(Data Validation Specification, DVS)을 개발한다. 증례기록서 자료 입력 전 데이터 검증 및 테스트 작업(Database Validation & User Acceptance Test)을 수행한다. 입력된 데이터(Data Entry)에 대한 타당성을 확인하기 위하여 자료의 질을 확인 및 관리(Query Management)하고 이상반응과 병용약물 등에 대하여 표준용어체계를 이용하여 표준화된 분류하는 코딩작업(Medical Coding)을 한다. 모든 자료관리 절차의 수행이 마감되면 데이터베이스 잠금(DB Lock) 업무를 수행한다. 데이터베이스 잠금 후 통계분석에 적합한 형태와 구조의 데이터를 통계분석 담당자에게 전달(Data Transfer)한다. 자료관리 과정 시 생성된 문서는 자료관리 마스터파일에 정리 및 보관하고 데이터 백업(Archiving) 작업을 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"DBA, CDA, DMA, Data Manager","certLic":"정보처리기사, SQL전문가, SQL개발자","dJobECd":"1341","dJobECdNm":"[1341]데이터 전문가","dJobJCd":"2231","dJobJCdNm":"[2231]데이터 전문가","dJobICd":"M739","dJobICdNm":"[M739]그 외 기타 전문, 과학 및 기술 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003670:1', '{"dJobCd":"K000003670","dJobCdSeq":"1","dJobNm":"정보개발제공자","workSum":"신문, 방송, 잡지 등 언론기관의 사업수행 시 필요한 각종 전문정보원(Information Source)에 대해 정리하여 정보인프라를 구축하고 관련 데이터베이스를 유지·보수한다.","doWork":"각 분야 전문가 및 기관에 대한 총람의 조사 및 각종 데이터를 체계적으로 수집, 정리, 가공 및 입력한다. 데이터베이스를 구축·관리·분석하여 정보인프라를 구축한다. 신문, 방송, 잡지의 원활한 제작을 진행할 수 있도록 돕는다. 사용자에 대한 등록 및 데이터의 접근범위, 읽고 쓰기 권한, 사용자의 로그인 및 암호관리 등을 통하여 정보인프라의 이용을 활성화하도록 한다. 생성자료를 인터넷 등으로 수용자에게 제공한다. 데이터베이스시스템의 고장이나 사용상의 문제가 발생하면 신속히 원인을 파악하여 조속히 복구하는 등 데이터베이스화된 자료를 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"데이터베이스관리자","certLic":"정보관리기술사, 정보처리기사, 전자계산기조직응용기사","dJobECd":"1341","dJobECdNm":"[1341]데이터 전문가","dJobJCd":"2231","dJobJCdNm":"[2231]데이터 전문가","dJobICd":"J639","dJobICdNm":"[J639]기타 정보 서비스업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004884:1', '{"dJobCd":"K000004884","dJobCdSeq":"1","dJobNm":"콘텐츠관리원","workSum":"주전산기에 입력할 각종 정보를 정리·분석하고 신규서비스를 제공하기 위하여 자료를 개발·관리한다.","doWork":"장기사업계획 및 신규서비스에 따른 입력정보의 종류 및 수량을 확인하고 관련 자료를 수집·분석한다. 정보의 종류에 따라 입력할 위치를 결정하고 내용을 정리한다. 일일 입력정보의 내용을 검토하고 관련 프로그램을 수정한다. 정보를 제공하는 단체 또는 개인과 협의하여 입력형식을 결정하고 관련 부서에 통보하여 프로그램을 개발한다. 전산기에 입력된 정보의 종류를 정리하여 판촉계획을 수립하고 영업을 지원한다. 전산기 및 고객의 컴퓨터와 연결할 수 있는 시스템의 개발, 신기술의 도입, 고객의 전산교육 등을 지원한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"1341","dJobECdNm":"[1341]데이터 전문가","dJobJCd":"2231","dJobJCdNm":"[2231]데이터 전문가","dJobICd":"J631","dJobICdNm":"[J631]자료처리, 호스팅, 포털 및 기타 인터넷 정보매개 서비스업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005297:1', '{"dJobCd":"K000005297","dJobCdSeq":"1","dJobNm":"콘텐츠구조관리원","workSum":"인터넷 및 각종 통신서비스가입자를 위한 서비스메뉴의 관리를 편리하게 할 수 있도록 서비스전체의 구조를 설계하고 관리한다.","doWork":"서비스의 디렉토리(Directory)구조를 관리한다. 수천 가지의 개별서비스메뉴를 분야별로 분류를 하고 개별상품의 메뉴를 등록할 수 있도록 설계한다. 관리의 로직(Logic)에 따라 항목(Index)의 생성, 수정, 삭제 등 항목관리(Index Management)프로그램을 이용하여 항목(Index)을 관리한다. 새로운 상품을 콘텐츠관리원, 커뮤니티관리원, 웹서비스기획원 등으로부터 받아 서비스 내의 분류상품명을 결정하여 구조 내에 삽입한다. 메뉴의 개편에 따라 하위디렉토리(Sub-Directory)를 만들거나 통폐합하고 중요도에 따라 재배열한다. 상품의 가치가 없어지거나 정보제공자(IP:Information Provider)의 계약해지에 따라 항목운용(Index Management) 프로그램을 통해 메뉴를 삭제한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"서비스메뉴관리원","dJobECd":"1341","dJobECdNm":"[1341]데이터 전문가","dJobJCd":"2231","dJobJCdNm":"[2231]데이터 전문가","dJobICd":"J631","dJobICdNm":"[J631]자료처리, 호스팅, 포털 및 기타 인터넷 정보매개 서비스업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006574:1', '{"dJobCd":"K000006574","dJobCdSeq":"1","dJobNm":"통신정보관리원","workSum":"주전산기에 입력할 각종 정보를 정리·분석하고 신규서비스를 제공하기 위하여 자료를 개발·관리하는 업무를 수행한다.","doWork":"장기사업계획에 따른 입력정보의 종류 및 수량을 확인하고 관련 자료를 수집·분석한다. 정보의 종류에 따라 입력할 위치를 결정하고 필요한 내용을 정리한다. 일일 입력정보의 내용을 검토하고 관련 프로그램을 수정한다. 신규서비스를 위한 정보의 종류 및 규모를 파악하여 관련 자료를 수집한다. 정보를 제공하는 단체나 개인과 협의하여 입력형식을 결정하고 관련 부서에 통보하여 프로그램을 개발한다. 전산기에 입력된 정보의 종류를 정리하여 판촉계획을 수립하고 영업을 지원한다. 전산기 및 고객의 컴퓨터와 연결할 수 있는 시스템의 개발, 신기술의 도입, 고객의 전산교육 등을 지원한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"제어조작","connectJob":"인터넷정보관리원","dJobECd":"1341","dJobECdNm":"[1341]데이터 전문가","dJobJCd":"2231","dJobJCdNm":"[2231]데이터 전문가","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005301:1', '{"dJobCd":"K000005301","dJobCdSeq":"1","dJobNm":"네트워크설계자","workSum":"개별사이트에 영향을 미치는 네트워크의 성능을 모니터링하고 진단·컨트롤·측정하여 네트워크시스템을 계획 및 설계한다.","doWork":"다수의 사이트로 구성된 네트워크시스템의 설계와 구조를 분석한다. 분석된 문제점의 해결책을 설명하기 위해 네트워크 구성도, 소프트웨어 설계도를 작성한다. 다수의 네트워크환경 내에서의 멀티미디어(음성, 데이터, 이미지)의 전송을 위한 경로와 전송로직을 설계하기 위해 디지털 기호화형식, 라인코드, 타이밍기술을 적용한다. 고객의 통신요구사항에 대한 해결책을 정의하고 분석·제공하기 위해 사용자와 논의한다. 설계도구를 사용하여 계획된 네트워크의 활용을 평가하고 다수의 사이트 네트워크를 위한 매체, 기술, 비용 등의 해결책을 제시한다. 다수의 사이트 네트워크 프로젝트를 위해 비용산출모델, 보고서, 기술적 해결책을 제공한다. 하위 직무수행자를 대상으로 담당분야에 대한 기술적 교육 실시 및 교육과정을 개발한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"정보처리기사, 전자계산기조직응용기사","dJobECd":"1342","dJobECdNm":"[1342]네트워크 시스템 개발자","dJobJCd":"2232","dJobJCdNm":"[2232]네트워크 시스템 개발자","dJobICd":"J620/J631","dJobICdNm":"[J620]컴퓨터 프로그래밍, 시스템 통합 및 관리업 / [J631]자료처리, 호스팅, 포털 및 기타 인터넷 정보매개 서비스업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001475:1', '{"dJobCd":"K000001475","dJobCdSeq":"1","dJobNm":"네트워크엔지니어","workSum":"사용자의 요구사항에 부합하는 네트워크시스템을 분석·설계·구축한다.","doWork":"전체적인 네트워크시스템의 구조를 분석하고 평가하여 문제점과 개선책을 도출한다. 사용자의 요구사항에 부합되는 기본적인 네트워크시스템의 구조를 기능성, 안정성, 확장성, 변경가능성, 관리용이성에 입각하여 설계한다. 구성요소에 대한 세부적 사양을 설정한다. 네트워크 관련 시스템에 대한 조사, 분석과 벤치마킹의 과정을 통해 활용가능성을 평가한다. 평가, 검증된 네트워크시스템을 기초로 세부적으로 시스템을 설계한다. 시스템 구축 전에 네트워크 장비들에 대한 설치위치, 환경, 케이블 등 구비요건을 확인·점검한다. 시스템이 도입되면 단위시스템에 대한 인터페이스와 설치과정을 통해 시스템의 기능과 성능을 평가한다. 단위 시스템의 평가가 완료되면 전체적으로 네트워크시스템과 컴퓨터시스템들을 통합 연동하여 종합적으로 평가하고 분석한다. 통합 구축된 네트워크시스템의 시험평가가 완료되면, 실제 운영에 대비한 네트워크시스템의 운영관리체계를 정립한다. 구축완료된 네트워크시스템에 대해서 일정기간 실제 운영한 데이터를 분석평가하여 시스템의 조정과정을 거쳐 기능과 성능을 향상시킨다. 네트워크의 고장이 발생하였을 경우 네트워크관리자와 함께 원인을 파악하고 복구를 위한 대책을 강구한다. 네트워크시스템에 관한 보안정책을 수립하고, 네트워크를 통한 해킹을 방지하기 위한 기술적 보안과 관리적 보안을 설계한다. 네트워크의 기술동향 및 추세를 지속적으로 조사·분석하여, 정보기술의 변화에 대비한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"네트워크시스템개발자","connectJob":"하는 일에 따라 네트워크분석엔지니어, 네트워크개발엔지니어","certLic":"정보처리기사, 전자계산기조직응용기사, 전자계산기기사, 정보통신기사","dJobECd":"1342","dJobECdNm":"[1342]네트워크 시스템 개발자","dJobJCd":"2232","dJobJCdNm":"[2232]네트워크 시스템 개발자","dJobICd":"J582/J620/J631","dJobICdNm":"[J582]소프트웨어 개발 및 공급업 / [J620]컴퓨터 프로그래밍, 시스템 통합 및 관리업 / [J631]자료처리, 호스팅, 포털 및 기타 인터넷 정보매개 서비스업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001225:1', '{"dJobCd":"K000001225","dJobCdSeq":"1","dJobNm":"IoT보안전문가","workSum":"다양한 IoT 장치 특성과 장치와 함께 운영되는 아키덱처 전반을 이해하고 사물인터넷장치 및 연계 시스템에서 발생되는 데이터의 보호 및 보안 문제를 다룬다.","doWork":"인가 또는 인증된 장치인지 파악하고, 장치에 대한 접근 권한을 관리한다. 장치에 설치되는 펌웨어 보안성을 검토한다. 펌웨어가 위변조 되지 않도록 모니터링하고 업데이트 상황을 관리한다. 장치 내 데이터의 보호 여부를 파악하고, 장치 제어에 대한 외부 침입 문제를 검토 및 관리한다. 장치에 대하여 보안 테스트를 하고 보안 취약점과 위협을 사전에 예방한다. 장치와 중계기, 중계기와 서버 간의 통신상 데이터 위변조가 발생하지 않도록 검토 및 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"협의","workFunc3":"제어조작","certLic":"정보보안기사","dJobECd":"1350","dJobECdNm":"[1350]정보보안 전문가","dJobJCd":"2233","dJobJCdNm":"[2233]정보 보안 전문가","dJobICd":"J620","dJobICdNm":"[J620]컴퓨터 프로그래밍, 시스템 통합 및 관리업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005112:1', '{"dJobCd":"K000005112","dJobCdSeq":"1","dJobNm":"개인정보보호전문가","workSum":"개인정보의 안전한 활용 및 이용자의 사생활 보호를 위하여 개인정보의 관리, 감독, 모니터링, 자문 등을 한다.","doWork":"개인정보보호 관련 법과 정책에 따라 개인정보보호 규정, 지침 등을 수립한다. 개인정보보호정책 준수에 필요한 시스템의 구축 및 업그레이드 계획을 수립한다. 개인정보보호 요구사항에 따라 개인정보보호 목표를 정하고 필요한 인력 및 예산계획을 수립한다. 계획에 따라 개인정보보호정책 준수에 대한 이행 여부를 점검하고 결과에 대한 보고서를 작성한다. 개인정보 유출 또는 침해사고가 발생할 경우 원인을 분석하고 대책방안을 수립한다. 개인정보보호정책에 대한 교육을 실시한다. 개인정보보호 영향평가 및 개인정보보호 관리체계인증에 대하여 대응한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"제어조작","certLic":"변호사, 정보보안기사, 정보보안산업기사","dJobECd":"1350","dJobECdNm":"[1350]정보보안 전문가","dJobJCd":"2233","dJobJCdNm":"[2233]정보 보안 전문가","dJobICd":"J620","dJobICdNm":"[J620]컴퓨터 프로그래밍, 시스템 통합 및 관리업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006501:1', '{"dJobCd":"K000006501","dJobCdSeq":"1","dJobNm":"국가사이버안전요원","workSum":"국내 주요 전산망의 위협요인을 사전에 차단하고, 예방하는 업무를 수행한다.","doWork":"국가기관, 산업체, 연구소 등 주요 전산망의 안전성 여부를 확인하여 사이버 공격징후를 탐지한다. 위험요소가 포착될 경우 각 기관에 알려 사이버테러를 예방할 수 있도록 조치한다. 사이버공격에 대한 진원지 및 의도를 파악하고, 재발방지를 위한 보안기술을 지원한다. 보안취약점을 발굴하고 해킹취약성을 진단하여 보안책을 지원한다. 사이버테러 발생 시 현장 또는 원격으로 사고원인을 분석하고 복구한다. 사이버 보안교육, 모의훈련 등을 실시한다. 사이버위협 정보분석, 보안기술연구, 국내외 사이버위협 동향, 보안취약성 분석 등의 업무를 수행한다. 사이버테러 발생 시 유관기관과 합동으로 복구작업을 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"협의","workFunc3":"제어조작","connectJob":"화이트해커","dJobECd":"1350","dJobECdNm":"[1350]정보보안 전문가","dJobJCd":"2233","dJobJCdNm":"[2233]정보 보안 전문가","dJobICd":"O844","dJobICdNm":"[O844]사법 및 공공질서 행정","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004855:1', '{"dJobCd":"K000004855","dJobCdSeq":"1","dJobNm":"보안프로그램개발자","workSum":"해커의 해킹으로부터 인터넷 및 컴퓨터의 보안을 유지하기 위한 프로그램을 개발한다.","doWork":"다양한 해킹방법을 인터넷을 이용하여 조사·연구한다. 보안상태를 점검하기 위한 시험도구(Test Tool)를 개발한다. 해킹(Hacking)방법을 가상으로 시뮬레이션하여 특정 인터넷사이트의 보안상태를 직접 침투함으로써 보안상태를 점검하고 운영체계(O/S)버전의 업그레이드 등 필요한 해결책을 제시한다. 정상적인 컴퓨터 사용을 방해하는 악성프로그램(멀웨어)을 분석하여 치료방법을 개발한다. 악성프로그램을 예방 및 치료할 수 있는 프로그램을 개발한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"보안프로그램개발자","connectJob":"인터넷보안전문가, 정보보호컨설턴트","dJobECd":"1350","dJobECdNm":"[1350]정보보안 전문가","dJobJCd":"2233","dJobJCdNm":"[2233]정보 보안 전문가","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002517:1', '{"dJobCd":"K000002517","dJobCdSeq":"1","dJobNm":"암호알고리즘개발원","workSum":"각종 정보에 대한 보안유지에 필요한 암호의 알고리즘을 수학적 원리와 이론을 토대로 연구·개발한다.","doWork":"CPU, 자료의 크기, 공격강도, 속도, 안전성 등의 요구사항을 고려하여 알고리즘(Algorithm)을 설계한다. 개발한 알고리즘을 토대로 언어를 사용하여 프로그램하고 실제암호의 작동 여부 등을 시험한다. 개발한 알고리즘을 토대로 하드웨어를 개발한다. 개발보고서를 작성한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"암호알고리즘연구원","dJobECd":"1350","dJobECdNm":"[1350]정보보안 전문가","dJobJCd":"2233","dJobJCdNm":"[2233]정보 보안 전문가","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007781:1', '{"dJobCd":"K000007781","dJobCdSeq":"1","dJobNm":"자동차사이버보안전문가","workSum":"모빌리티의 안정성 확보를 위하여 보안 조직을 구성하고 전략과 정책 수립, 법령 준수, 생명주기 전 단계에 걸쳐 보안 위협 및 위험을 식별하고 보안성을 검증하며, 대응방안을 수립, 적용, 평가, 인증한다.","doWork":"국내외에서 요구되는 모빌리티 보안 관련 법령, 규제, 가이드라인 등을 기반으로 모빌리티 보안을 위한 전략 및 의사결정 체계를 수립하고 관리한다. 모빌리티 보안 취약점을 파악하여 적절한 대응 및 예방 조치가 가능하도록 모빌리티 관련 공급망, 장치 및 시스템에서 발생할 수 있는 잠재적인 위협을 식별하고 각 위협의 위험도를 평가한다. 자산 및 보안 통제항목을 식별한 후 위험평가 계획에 따라 위험을 관리하고 지속적인 모니터링을 한다. 모빌리티의 보안 위험 대응 조치를 평가, 분석하는 시험을 통해 조치의 적정성을 확인한다. 모빌리티 보안 목표 달성을 위한 완화 조치 유효성을 평가한다. 모빌리티를 활용, 운영하는 서비스에 있어 지속적인 관리와 점검을 통해 보안 체계를 유지한다. 사이버보안 관리를 위해 적합한 관리체계와 프로세스를 갖추고, 생명주기 모든 단계에서 적절한 보안 조치나 대책이 반영되고 있음을 인증 받는다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","certLic":"정보보안기사","dJobECd":"1350","dJobECdNm":"[1350]정보보안 전문가","dJobJCd":"2233","dJobJCdNm":"[2233]정보 보안 전문가","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2025"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005581:1', '{"dJobCd":"K000005581","dJobCdSeq":"1","dJobNm":"전산보안관제원","workSum":"보안관제센터에서 각종 보안위협을 실시간으로 감시 및 분석, 대응하는 보안관제업무를 수행한다.","doWork":"보안관제센터(IT자원 및 보안시스템에 대한 운영 및 관리를 전문적으로 수행하는 센터) 및 보안관제서비스센터(MSS:Managed Security Service, 고객이 보유한 정보자산을 보호해주는 보안관리대행서비스)에서 실시간으로 관제화면을 통해 침해위협을 탐지한다. IDS(Intrusion Detection System:정보시스템의 보안을 위협하는 침입행위가 발생할 경우 이를 탐지하고 대응하는 시스템), IPS(Intrusion Prevention Systems:침입차단시스템) Anti-DDos(Anti-Distributed Denial of Service:디도스(분산서비스 거부공격) 방어시스템), 웹방화벽(Web Application Firewall:웹애플리케이션 서비스보호방화벽) 등 보안관제프로그램을 사용하여 관제한다. 보안위협이 발생한 경우 대응팀과 협조하여 네트워크와 시스템의 침입을 차단하는 등 발생된 보안위협에 대응한다. 고객기업에 파견된 경우, 파견된 기업(클라이언트)의 보안솔루션을 관리한다. 원격으로 관제하는 경우, 원격으로 네트워크보안장비에 대한 관제업무를 수행하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"보안관제요원, 전산보안관제요원","certLic":"정보관리기술사, 정보처리기사, 정보처리산업기사","dJobECd":"1350","dJobECdNm":"[1350]정보보안 전문가","dJobJCd":"2233","dJobJCdNm":"[2233]정보 보안 전문가","dJobICd":"J620","dJobICdNm":"[J620]컴퓨터 프로그래밍, 시스템 통합 및 관리업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003974:1', '{"dJobCd":"K000003974","dJobCdSeq":"1","dJobNm":"정보보호프로그래머","workSum":"정보보호제품을 기획·설계하고, 컴퓨터바이러스 백신프로그램을 개발한다.","doWork":"정보보호산업의 동향을 파악한다. 고객이 요구하는 수준의 정보보호제품을 기획한다. 정보보호제품을 설계한다. 암호화알고리즘을 개발한다. 인증서를 이용한 제품을 개발한다. 인증서를 발행하는 프로그램을 개발한다. 정보보호기술 및 규격에 관한 표준화작업에 참여한다. 외부 네트워크로부터의 불법적인 침입을 탐지하기 위한 시스템과 침입을 방지하기 위한 방화벽을 개발한다. 컴퓨터바이러스 백신프로그램을 개발·보급한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"정보처리기사","dJobECd":"1350","dJobECdNm":"[1350]정보보안 전문가","dJobJCd":"2233","dJobJCdNm":"[2233]정보 보안 전문가","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007141:1', '{"dJobCd":"K000007141","dJobCdSeq":"1","dJobNm":"침입탐지시스템엔지니어","workSum":"고객의 실제적, 잠재적 불안을 해소하기 위해 침입탐지시스템을 모니터하고, 인가되지 않은 서버 접근에 즉각 대응한다.","doWork":"고객사의 서버현황을 실시간으로 모니터한다. 인가되지 않은 서버에 대한 접근을 차단한다. 시스템 불통으로 인한 고객의 전화에 응대한다. 전 근무자로부터 상황에 대하여 인수인계받는다. 서버상의 오류발생 시 수정(디버깅)한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"컨트롤시스템엔지니어(Control System Engineer)","certLic":"정보처리기사, 전자계산기조직응용기사","dJobECd":"1350","dJobECdNm":"[1350]정보보안 전문가","dJobJCd":"2233","dJobJCdNm":"[2233]정보 보안 전문가","dJobICd":"J582/J620","dJobICdNm":"[J582]소프트웨어 개발 및 공급업 / [J620]컴퓨터 프로그래밍, 시스템 통합 및 관리업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007001:1', '{"dJobCd":"K000007001","dJobCdSeq":"1","dJobNm":"침해사고대응엔지니어","workSum":"시스템이나 네트워크를 분석하여 이상징후를 탐지하고 침해사고에 대응한다.","doWork":"악성코드 분석 및 침해사고에 대응한다. 시스템·네트워크·애플리케이션 보안성을 검토한다. 보안운영을 위해 보안 장비 및 보안솔루션을 관리하고, 사내 인프라의 보안성을 개선한다. 사내 보안관련 제반 정책을 관리하며, 보안지침 및 가이드를 제공하고 보안점검 및 보안교육을 실시한다. 최신 위협 동향을 연구하고 보안 취약점을 보완한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","certLic":"정보보안기사","dJobECd":"1350","dJobECdNm":"[1350]정보보안 전문가","dJobJCd":"2233","dJobJCdNm":"[2233]정보 보안 전문가","dJobICd":"J620","dJobICdNm":"[J620]컴퓨터 프로그래밍, 시스템 통합 및 관리업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002151:1', '{"dJobCd":"K000002151","dJobCdSeq":"1","dJobNm":"컴퓨터바이러스치료사","workSum":"새로운 컴퓨터바이러스를 분석하여 감염경로나 방법, 증상, 치료방법 등을 분석하고 치료가능한 백신프로그램을 제작한다.","doWork":"바이러스 분석툴(Tool)을 이용하여 메모리 감염방법, 다른 파일 감염방법 등 컴퓨터바이러스가 가지고 있는 특징을 분석한다. 감염증상 외에 파괴증상이 있는지 또는 특정한 날에만 활동을 하는지 등도 분석한다. 분석이 끝나면 컴퓨터바이러스의 치료데이터를 만든다. 메모리를 치료하는 방법, 파일을 치료하는 방법, 부트(Boot)바이러스인 경우 원래 부트가 있는 위치 등 컴퓨터바이러스를 치료하기 위한 모든 정보를 찾는다. 기존 백신프로그램에 컴퓨터바이러스를 치료하기 위한 데이터를 추가한다. 컴퓨터바이러스에 관해 사용자들을 대상으로 상담하고 컴퓨터바이러스를 치료할 수 있는 방법을 설명하거나 해결방법을 제시한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"컴퓨터바이러스기술자","dJobECd":"1350","dJobECdNm":"[1350]정보보안 전문가","dJobJCd":"2233","dJobJCdNm":"[2233]정보 보안 전문가","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007002:1', '{"dJobCd":"K000007002","dJobCdSeq":"1","dJobNm":"클라우드보안담당자","workSum":"정보유출방지, 보안운영, 보안성 검토, 해킹방지 및 침해사고 대응업무를 통해 사내 정보자산과 서비스를 보호한다.","doWork":"클라우드 정보보호 거버넌스 및 정책을 수립하며 관리한다. On-Premis 환경, 클라우드 및 IaaS/PaaS/SaaS 기반의 인프라 아키텍처 보안성을 검토한다. 클라우드 보안 아키텍쳐를 수립하고 평가한다. IDS, WAF, SSL VA 등 다양한 네트워크 보안장비를 구축하고 운영한다. 인프라 환경의 운영 및 구현 단계에서의 보안성을 검토한다. 클라우드 고객의 기술적 보안 컨설팅을 수행한다. 시스템에 접근 가능한 업무용 단말기의 보안성을 점검하고 보호대책을 마련한다. ISMS-P/ISO/CSAP/CSA Star 등 각종 보안인증의 기술적·관리적 보호조치에 대응한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","certLic":"정보보안기사","dJobECd":"1350","dJobECdNm":"[1350]정보보안 전문가","dJobJCd":"2233","dJobJCdNm":"[2233]정보 보안 전문가","dJobICd":"J620","dJobICdNm":"[J620]컴퓨터 프로그래밍, 시스템 통합 및 관리업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005014:1', '{"dJobCd":"K000005014","dJobCdSeq":"1","dJobNm":"클라우드시스템정보보안전문가","workSum":"클라우드시스템의 안정적인 운영을 위해 보안문제를 다룬다.","doWork":"클라우드환경에서 발생하는 각종 보안문제를 수집 및 분석하고 대안방법을 제안한다. 데이터의 유출을 방지하기 위하여 인가되지 않은 방식에 의한 정보와 소프트웨어에 대한 접근 및 정보변경이 이뤄지지 않도록 정확성과 안정성을 확보한다. 사용자가 정보나 서비스를 요구할 때 언제든지 사용이 가능하도록 시스템을 모니터링한다. 가상화시스템 보호를 위해 가상자원을 모니터링하고 관리한다. 데이터의 위변조를 막기 위해 데이터인증코드를 통해 모니터링하고 무결성을 유지한다. 사고발생 시 데이터보호를 위해 사고를 차단하고 위험요소를 제거하며 시스템을 복구한다. 모의테스트 및 위험평가를 통해 보안취약점과 위협들을 사전에 예방한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"클라우드보안전문가","dJobECd":"1350","dJobECdNm":"[1350]정보보안 전문가","dJobJCd":"2233","dJobJCdNm":"[2233]정보 보안 전문가","dJobICd":"J620","dJobICdNm":"[J620]컴퓨터 프로그래밍, 시스템 통합 및 관리업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002171:1', '{"dJobCd":"K000002171","dJobCdSeq":"1","dJobNm":"모의해킹전문가","workSum":"기업의 내부 또는 외부 네트워크상에 있는 서비스와 정보시스템으로의 침투가능성을 진단한다.","doWork":"기업이 서비스를 제공하는 웹서버, 데이터베이스서버, 방화벽, 네트워크 장비를 대상으로 해커가 사용하는 기법 및 도구를 사용하여 침투 가능성을 진단한다. 정보나 시스템의 관리 권한을 불법적으로 획득 가능한지와 각 진단 모듈에서 발견된 취약점을 점검한다. 불법침입의 가능성이 발견될 경우 취약점에 대한 대응책 및 개선방안을 마련하여 해결책을 협의한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"해킹컨설턴트","dJobECd":"1349","dJobECdNm":"[1349]기타 데이터 및 네트워크 전문가","dJobJCd":"2239","dJobJCdNm":"[2239]기타 데이터 및 네트워크 관련 전문가","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003329:1', '{"dJobCd":"K000003329","dJobCdSeq":"1","dJobNm":"사이버포렌식전문가","workSum":"디지털, 사이버 증거자료를 확보하기 위하여 수집절차에 따라 시스템, 하드웨어, 모바일 등 증거대상자료를 수집, 확보하고 분석툴을 활용하여 자료를 복구하거나 분석하여 증거분석서를 작성한다.","doWork":"의료소송, 가사 및 행정소송, 기업정보유출사건 관계자로부터 의뢰내용을 사전에 파악한다. 현장에 나가서 시스템의 종류 등 증거 수집할 내용과 특성을 분석하여 자료를 수집하며 시간이 지나면 삭제되는 휘발성자료의 경우 무결성 등을 확보하기 위하여 조치를 취한다. 시스템 등 현장에서 분석이 필요한 경우 현장에서 분석한다. 수집한 증거물 또는 의뢰받은 증거물을 인증된 분석장비, 분석프로그램 등을 사용하여 절차에 따라 데이터, 파일을 복구하고 분석한다. 증거수집절차와 과정, 결과 등을 제시한 증거분석서를 작성한다. 정보보안측면에서 침해사고가 발생했을 때 침투흔적분석, 경로추적, 흔적분석을 한다. 영업비밀유출 등 디지털포렌식 범죄와 관련하여 사전예방조치 등에 대해 컨설팅하거나 임직원을 대상으로 사전예방조치를 위한 교육을 한다. 필요시 법정에 출두하여 증언하기도 한다. 경찰조사 시 입회하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"디지털포렌식전문가","certLic":"디지털포렌식전문가 1급, 2급","dJobECd":"1349","dJobECdNm":"[1349]기타 데이터 및 네트워크 전문가","dJobJCd":"2239","dJobJCdNm":"[2239]기타 데이터 및 네트워크 관련 전문가","dJobICd":"J620","dJobICdNm":"[J620]컴퓨터 프로그래밍, 시스템 통합 및 관리업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004962:1', '{"dJobCd":"K000004962","dJobCdSeq":"1","dJobNm":"가스계통관리원","workSum":"가스의 공급상황을 감시 및 운영하는 중앙지령실의 전산설비 및 응용프로그램을 유지·관리하고 개선하기 위한 제반 업무를 수행한다.","doWork":"중앙통제실의 전국가스배관망 및 생산설비를 감시하고 통제하는 전산설비가 원활히 작동되도록 유지하고 관리한다. 전국가스배관망을 관리하는 프로그램 및 수요예측과 배관망을 분석하는 응용프로그램을 유지하고 관리한다. 중앙통제실 내의 정보처리를 지원한다. 중앙통제실의 시스템의 신·증설 및 개선에 따른 계획을 수립한다. 시스템의 신·증설 및 개선에 있어 시공을 감독하고 감리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"1343","dJobECdNm":"[1343]정보시스템 운영자","dJobJCd":"2241","dJobJCdNm":"[2241]정보 시스템 운영자","dJobICd":"D352","dJobICdNm":"[D352]연료용 가스 제조 및 배관공급업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007499:1', '{"dJobCd":"K000007499","dJobCdSeq":"1","dJobNm":"네트워크관리자","workSum":"클라이언트, 서버, 인터넷 및 인트라넷 형태의 전산망 관련 하드웨어 및 소프트웨어자원을 관리하고 운영한다.","doWork":"네트워크시스템에 대한 운영과 관리의 지침을 마련한다. 전체적인 네트워크시스템의 구성상태를 파악하고 실시간 시스템의 운영상태를 모니터링하고 관리한다. 네트워크케이블의 포설 위치, 레이아웃, 배선상태 등에 관한 자료를 기록·관리하고 네트워크케이블의 확장 및 변경 시 수정·관리한다. 네트워크에 연결된 사용자의 PC, 서버컴퓨터, 주변기기 등에 대해서 주소체계를 설정 및 부여한다. 네트워크의 변경 및 확장 시 주소의 설정을 조정한다. 네트워크시스템의 고장 및 운영상에 이상이 발견되면 문제점을 파악하여 복구한다. 네트워크시스템의 변경 및 신규 확장추가 시 신규로 조달된 시스템을 설치하고, 시험계획에 입각하여 기능 및 성능을 시험평가한다. 네트워크매니지먼트시스템(NMS)의 기능과 특성을 이용해서 성능관리, 구성관리 및 고장관리를 효율적으로 수행한다. 네트워크시스템에 관한 보안정책을 수립하고 외부 네트워크를 통한 해킹을 방지하기 위한 기술적 보안과 관리적 보안을 이행한다. 네트워크 이용자를 위한 전자우편 ID의 등록, 부여, 삭제 등을 관리하고 인터넷 관련 서비스를 제공한다. 네트워크관리자는 사용자의 PC상에 네트워크의 접속을 위한 네트워크프로토콜 및 서비스에 대한 셋업의 절차와 행위에 대한 교육과 기술적 자문을 지원한다. 사용자의 PC가 네트워크에 접속하는 데 문제가 있을 경우 기술적으로 지원한다. 외부망과 연동되는 통신회선(전용선, 전화망 등)에 대해서 외부망사업자와의 긴밀한 협조 하에 통신장애를 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"정보처리기사, 전자계산기조직응용기사","dJobECd":"1343","dJobECdNm":"[1343]정보시스템 운영자","dJobJCd":"2241","dJobJCdNm":"[2241]정보 시스템 운영자","dJobICd":"J582/J620/J631","dJobICdNm":"[J582]소프트웨어 개발 및 공급업 / [J620]컴퓨터 프로그래밍, 시스템 통합 및 관리업 / [J631]자료처리, 호스팅, 포털 및 기타 인터넷 정보매개 서비스업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004064:1', '{"dJobCd":"K000004064","dJobCdSeq":"1","dJobNm":"대학전산운영원","workSum":"대학의 중앙전산원 또는 정보관리소에서 대학 내 전산업무 전반을 담당한다.","doWork":"대학 내의 전체적인 전산네트워크를 설치·관리한다. 학내 인트라넷을 구축하며 학내 모든 컴퓨터의 운영 및 관리업무를 담당한다. 교내 컴퓨터에 교육용 소프트웨어의 구매계획을 세우고 관리한다. 네트워크에 문제발생 시 해결하고 바이러스 점검을 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"대학전산시스템운영원, 대학전산시스템오퍼레이터, 대학전산실운영원","dJobECd":"1343","dJobECdNm":"[1343]정보시스템 운영자","dJobJCd":"2241","dJobJCdNm":"[2241]정보 시스템 운영자","dJobICd":"P853","dJobICdNm":"[P853]고등 교육기관","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006385:1', '{"dJobCd":"K000006385","dJobCdSeq":"1","dJobNm":"물류전산조작원","workSum":"바코드(Bar Code)로 생산라인의 흐름을 파악하고 관리하기 위하여 물류전산기를 조작한다.","doWork":"공정별 배치현황, 기계·장비 배치현황, 단위공정당 작업량 및 작업시간 등을 컴퓨터에 입력한다. 생산라인상에서 부착된 바코드가 판독기를 통과하며 들어오는 정보를 수집·분석한다. 제품의 공정별 생산량, 장비의 이상 유무, 작업원의 작업상태, 생산품의 이상 유무 등을 모니터로 파악하고 필요한 조치를 취할 수 있도록 해당 부서에 연락한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"바코드조작원","dJobECd":"1343","dJobECdNm":"[1343]정보시스템 운영자","dJobJCd":"2241","dJobJCdNm":"[2241]정보 시스템 운영자","dJobICd":"C","dJobICdNm":"[C]제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004314:1', '{"dJobCd":"K000004314","dJobCdSeq":"1","dJobNm":"씨티아이운영원","workSum":"콜센터 등에서 고객상담원의 상담이 용이하도록 고객정보를 제공하는 컴퓨터전화통합시스템(CTI:Computer Telephone Integration)을 운영하고 필요시 유지·보수한다.","doWork":"컴퓨터전화통합시스템(CTI:Computer Telephone Integration, 컴퓨터와 전화시스템의 통합을 지칭. PC를 통해 전화시스템을 효율적으로 관리하는 기술로서 CTI시스템을 활용하면, 고객이 전화음성안내에 따라 음성으로 원하는 정보를 듣거나 팩스로 문서를 받아볼 수 있고, 음성안내에 따라 주문사항과 거래내용을 입력하여 은행계좌이체나 티켓예약판매서비스를 받을 수 있으며, 고객의 전화번호를 데이터베이스화하여 각 고객에게 적합한 대응방법을 도모할 수 있음)의 작동상황을 단말기를 통하여 수시로 모니터링을 한다. 이상 발생 시 응급조치로서 전원을 공급 및 차단하며, 랜(LAN)상의 문제를 확인하고 전화국에 연락하여 통신망의 이상을 확인한다. 프로그램의 에러를 확인하고 수리가 불가능하면 기기공급업체에 의뢰를 한다. 각종 고객상담에 대한 통계데이터를 백업한다. 상담프로그램 등의 변형, 대량신규가입자가 발생하는 경우 등 사용자의 요구를 취합하여 인터페이스의 변경을 업자에게 요구하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"CTI운영원, 컴퓨터전화통합시스템운영원, 콜센터씨티아이운영원, 콜센터CTI운영원, 콜센터컴퓨터전화통합시스템운영원, CTI콜시스템운영원, 씨티아이콜시스템운영원","certLic":"정보통신기사, 정보통신산업기사, 통신기기기능사","dJobECd":"1343","dJobECdNm":"[1343]정보시스템 운영자","dJobJCd":"2241","dJobJCdNm":"[2241]정보 시스템 운영자","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002896:1', '{"dJobCd":"K000002896","dJobCdSeq":"1","dJobNm":"유비쿼터스도시서비스운영원","workSum":"시민에게 유비쿼터스 도시의 각종 도시서비스가 안정적으로 제공되는데 필요한 각종 정보의 수집 및 제공업무를 하고, 통합운영센터를 운영한다.","doWork":"시민들이 교통, 교육, 행정, 주거, 보건복지, 방범, 방재, 환경 등의 서비스를 안정적으로 제공받고 도시인프라가 효율적으로 운영되도록 유비쿼터스 도시(U-City:Ubiquitous City, 시간과 장소에 구애받지 않고 언제 어디서나 인터넷 접속이 가능한 유비쿼터스 기술을 기반으로 하는 미래형 첨단도시)서비스에 대한 정보를 수집·가공하여 제공하는 업무를 수행한다. 유비쿼터스도시의 기능과 관련된 정보가 수집되고 모니터링되는 통합운영센터를 운영한다. 통합운영센터에 수집된 데이터정보를 분석하여 문제발생을 사전에 예방하거나 발생 시 신속한 조치를 취한다. 현장장치(센서 등)로부터 수집된 정보를 서비스화하기 위해 정보를 통계화하고, 수집된 정보에서 의미있는 비즈니스이벤트를 개발한다. 가공된 정보를 현장의 IT-pole(예시:지능형 복합가로등) 등의 디지털단말기나 주민들의 모바일장치로 송신한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"청각|손사용|언어력|시각|","workFunc1":"분석","workFunc2":"협의","workFunc3":"제어조작","similarNm":"U-City서비스운영원","dJobECd":"1343","dJobECdNm":"[1343]정보시스템 운영자","dJobJCd":"2241","dJobJCdNm":"[2241]정보 시스템 운영자","dJobICd":"L682","dJobICdNm":"[L682]부동산 관련 서비스업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007784:1', '{"dJobCd":"K000007784","dJobCdSeq":"1","dJobNm":"인공지능서비스운영관리자","workSum":"인공지능 서비스의 체계적인 운영을 위하여 계획을 수립하고, 서비스 이용자 관리, 운영 환경 관리, 운영 모니터링, 운영 품질관리, 운영 장애관리, 운영수준 관리, 운영 개선 관리, 외부 인프라관리, 운영 지원 도구 관리 등을 한다.","doWork":"인공지능서비스의 체계적인 운영을 위하여 인공지능서비스에 필요한 운영 제반 계획을 수립한다. 인공지능서비스의 적절한 활용을 위해서 인공지능서비스에 대한 이용 지침을 수립하고 과금 관리를 계획하며, 이용 불만 사항(VOC)에 대응한다. 환경 변화에 대응하기 위하여 인공지능서비스 고도화 반영 및 운영 성과 분석과 규제 이슈에 대응하고 운영매뉴얼을 관리한다. 지속적인 기능과 성능 유지를 위하여 필요한 운영자원 및 인터페이스를 점검하고, 운영 성능 모니터링 및 운영점검 사항을 체계적으로 관리한다. 인공지능서비스의 지속적인 품질 개선을 위하여 지표를 선정하고 서비스 요소별 품질을 점검하여 개선한다. 인공지능서비스의 운영 시 발생할 수 있는 장애를 접수하고 원인을 분석하여 장애 처리 결과를 보고한다. 이용자와 약정한 서비스 수준을 유지하기 위하여 운영수준 관리 체계를 정립한 후, 측정 대상 선정 및 측정 지표를 정의하고, 측정을 통해 인공지능서비스의 이용자 관점 운영수준을 평가한다. 지속적인 서비스 기능 개선과 성능 유지를 위하여 수집한 인공지능서비스의 개선을 수행하고 결과를 평가한다. 운영 중인 서비스가 최적의 성능을 유지할 수 있도록 외부 인프라 현황을 모니터링하고 개선계획을 수립한다. 서비스의 지속적이고 효율적인 운영을 지원하기 위해 필요한 도구를 식별, 비교, 도입하고 그 성능을 정기적으로 평가한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"정보관리기술사, 컴퓨터시스템응용기술사, 정보처리기사, 정보처리산업기사, 빅데이터분석기사, 데이터분석전문가, 데이터분석준전문가, SQL개발자, SQL전문가","dJobECd":"1343","dJobECdNm":"[1343]정보시스템 운영자","dJobJCd":"2241","dJobJCdNm":"[2241]정보 시스템 운영자","dJobICd":"J620","dJobICdNm":"[J620]컴퓨터 프로그래밍, 시스템 통합 및 관리업","inqYear":"2025"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005470:1', '{"dJobCd":"K000005470","dJobCdSeq":"1","dJobNm":"인터넷데이터센터서버관리원","workSum":"인터넷데이터센터(IDC) 가입자를 위한 서버의 개통처리를 하고 가입자 엑세스 스위치를 운용하며 라우터와 중계기 간의 네트워크를 관리한다.","doWork":"인터넷데이터센터(IDC:Internet Data Center, 기업의 전산시설을 위탁관리하는 곳. 일명 서버호텔) 가입자의 서버와 IDC센터의 메인호스트서버와의 연결을 관리한다. 메인호스트의 사양과 설치방법에 맞도록 세팅을 하고 전원을 연결한다. 주기적으로 서버의 작동상황을 관제실에서 모니터링하고 문제발생 시 OS(Operating System)의 업그레이드, 메모리의 증설 등 필요한 조치를 취한다. 가입자의 숫자를 고려하여 최적으로 사용할 수 있도록 하드웨어 적정량을 판단한다. 고객의 장비수리를 위한 유지보수공구 및 측정기 등을 구비하여 고장발생 시 고객을 위해 제공하기도 한다. 서버와 라우터 사이의 중계기와 라우터와 중계기 간의 네트워크를 감시프로그램을 사용하여 주기적으로 감시하고 문제발생 시 경보메시지에 따라 조치한다. 로그분석을 통해 이상발생의 원인이 회선절체, 라우터, 중계기 문제인지 장비의 문제인지를 확인하고 조치한다. 물리적 보안을 위하여 IDC 내 담당구역의 출입자를 관리하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"정보통신기사, 정보통신산업기사","dJobECd":"1343","dJobECdNm":"[1343]정보시스템 운영자","dJobJCd":"2241","dJobJCdNm":"[2241]정보 시스템 운영자","dJobICd":"J631","dJobICdNm":"[J631]자료처리, 호스팅, 포털 및 기타 인터넷 정보매개 서비스업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002349:1', '{"dJobCd":"K000002349","dJobCdSeq":"1","dJobNm":"인터넷데이터센터운용원","workSum":"인터넷데이터센터(IDC:Internet Data Center) 운용에 필요한 각종 서버의 관리 및 DNS(Domain Name Server) 등록 등의 업무를 수행한다.","doWork":"SMS(System Management System), FMS(Facility Management System) 등 인터넷데이터센터(IDC) 운용에 필요한 서버시설을 운용한다. 방화벽(FW:Fire Wall), 침입탐지시스템(IDS:Intruder Detect System) 등 보안시스템의 운용 및 유지보수를 한다. MRTG(Multi Router Traffic Grapher:라우터의 트래픽을 모니터링하는 툴로서, 실시간의 트래픽정보를 그래프로 보여주는 html 페이지를 생성한다. 그래프는 GIF파일에 저장되고 이 파일은 사용자가 지정하는 시간만큼의 단위로 리프레시된다)를 이용하여 네트워크의 트래픽을 감시하고 DNS의 등록신청을 받아 IP를 할당하고 부여한다. 인터넷데이터센터(IDC)의 물리적, 하드웨어적, 소프트웨어적 보안계획을 수립하고 총괄한다. Co-Location(고객의 서버를 인터넷 백본네트워크에 직접 접속하는 서비스) 가입자를 위하여 서버기술지원을 실시한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"정보통신기사, 정보통신산업기사, 통신기기기능사","dJobECd":"1343","dJobECdNm":"[1343]정보시스템 운영자","dJobJCd":"2241","dJobJCdNm":"[2241]정보 시스템 운영자","dJobICd":"J631","dJobICdNm":"[J631]자료처리, 호스팅, 포털 및 기타 인터넷 정보매개 서비스업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002044:1', '{"dJobCd":"K000002044","dJobCdSeq":"1","dJobNm":"전보시설운영원","workSum":"전보 자동처리에 따른 전산 시스템운용, 데이터베이스 관리, 전신교환기를 운용하고 유지·관리한다.","doWork":"전보접수원으로부터 접수 되어진 전신 데이터를 전보단말기로부터 받아 착신국 전보단말기로 보내어주는 전신교환기의 작동을 터미널을 통하여 감시하고, 이상 발생 시 알람경고에 따라 에러 메시지를 확인하고 유지·보수한다. 전신교환기의 소프트웨어, 단말기, 프린터 모뎀을 관리한다. 단말기 착신국으로부터 출력미비, 전문유실 등의 전보발신의 이상이 발생할 경우 요구에 따라 교환기로부터 전문조회용 데이터를 로딩하고 전문조회 검색을 통보하며 장애전문을 출력 통보하고 전신데이터를 찾아 재전송한다. 논리로그, 시스템소프트웨어, 일반전보, 예약전보, 관리 및 통계데이터를 백업하고 로딩한다. 과금을 조회ㆍ검색하여 통보한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"단순작업","certLic":"정보처리기사","dJobECd":"1343","dJobECdNm":"[1343]정보시스템 운영자","dJobJCd":"2241","dJobJCdNm":"[2241]정보 시스템 운영자","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2011"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005156:1', '{"dJobCd":"K000005156","dJobCdSeq":"1","dJobNm":"전보전산시스템운용원","workSum":"전보자동처리에 따른 전산시스템 운용, 데이터베이스 관리, 전신교환기를 운용하고 유지·보수한다.","doWork":"전보접수원으로부터 접수받은 전신데이터를 전보단말기로부터 받아 착신국 전보단말기로 보내어주는 전신교환기의 작동을 터미널을 통하여 감시한다. 이상발생 시 알람경고에 따라 에러메시지를 확인하고 유지·보수한다. 전신교환기의 소프트웨어, 단말기, 프린터, 모뎀을 관리한다. 단말기착신국으로부터 출력미비, 전문유실 등의 전보발신의 이상이 발생할 경우 요구에 따라 교환기로부터 전문조회용 데이터를 로딩하고, 전문조회검색을 통보하며, 장애전문의 출력을 통보하고, 전신데이터를 찾아 재전송한다. 논리로그, 시스템소프트웨어, 일반전보, 예약전보, 관리 및 통계데이터를 백업하고 로딩한다. 과금을 조회·검색하여 통보한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"전보시스템운영원, 전보시설운영원","certLic":"정보처리기사","dJobECd":"1343","dJobECdNm":"[1343]정보시스템 운영자","dJobJCd":"2241","dJobJCdNm":"[2241]정보 시스템 운영자","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001791:1', '{"dJobCd":"K000001791","dJobCdSeq":"1","dJobNm":"전산관리원","workSum":"전산프로그램 및 온라인회선의 관리와 단말기관리업무를 수행한다.","doWork":"컴퓨터프로그램, 사내전산망, 컴퓨터단말기, 전화회선 등 전산장비를 관리하며 고장 및 오류 시 문제점을 찾아내어 수리하거나 원상회복을 한다. 컴퓨터프로그램 오류, 사내전산망 오류, 컴퓨터단말기 고장, 전화회선 고장 및 통신회선 장애발생에 관한 내용을 접수하고 회복조치를 한다. 치명적인 바이러스감염 및 해킹문제발생 등 자체처리 불가능한 장애인 경우에는 관련 전문업체에 의뢰한다. 각 지점의 컴퓨터 및 단말기 증설이나 변경요청내역 심의자료를 작성한다. 예비단말기의 보존상태를 유지한다. 온라인장애나 단말기장애에 관한 장애통계자료와 단말기현황자료를 작성하여 기록·보관한다. 전산업무의 전문화로 인한 컴퓨터프로그램의 보안, 외부바이러스감염에 대한 방비, 해킹위험에 대한 방어 등 인터넷 관련 관리업무를 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"웅크림|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"전산실운영원","connectJob":"전산사무원","dJobECd":"1343","dJobECdNm":"[1343]정보시스템 운영자","dJobJCd":"2241","dJobJCdNm":"[2241]정보 시스템 운영자","dJobICd":"J620","dJobICdNm":"[J620]컴퓨터 프로그래밍, 시스템 통합 및 관리업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004343:1', '{"dJobCd":"K000004343","dJobCdSeq":"1","dJobNm":"전산시스템운영원","workSum":"영업관리 및 고객관리시스템을 운용할 수 있도록 전산시스템을 설치하고 운용한다.","doWork":"각종 전산시스템의 기존 용량을 검토하여 시스템구조(Architecture)를 설계한다. 시스템을 설치하고 각종 부대장비 가동환경을 구축한다. 시스템의 성능을 분석하고 로그의 축적으로 성능이 저하되면 로그파일(Log File)을 제거한다. 처리용량을 분석하고 처리용량계획을 수립한다. 소프트웨어를 변경하고 버전을 변경한다. 시스템운영관리를 위하여 비주얼(Visual) C 또는 C++ 등의 프로그램언어를 이용하여 데이터베이스(DB)의 효율성, 용량 등을 측정할 수 있는 모니터링시스템을 개발한다. 교대업무 시 시스템을 가동·정지하고 시스템을 감시하며 데이터를 백업하고 출력물을 관리하며 각종 통계자료의 후처리를 실시하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"전산시스템오퍼레이터","certLic":"무선설비기사","dJobECd":"1343","dJobECdNm":"[1343]정보시스템 운영자","dJobJCd":"2241","dJobJCdNm":"[2241]정보 시스템 운영자","dJobICd":"J620","dJobICdNm":"[J620]컴퓨터 프로그래밍, 시스템 통합 및 관리업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006682:1', '{"dJobCd":"K000006682","dJobCdSeq":"1","dJobNm":"정보제공시스템관리원","workSum":"인터넷이용자를 위하여 정보제공업무를 수행할 정보제공자(IP:Information Provider)를 선정하고 계약을 체결한다.","doWork":"인터넷(Internet)의 웹(Web) 서비스 및 각종 전문잡지 등을 통해 최신정보를 수집한다. 정보제공을 위한 정보제공자(IP)로부터 제안서를 받아 전문분야별 지식에 따라 사업성 및 윤리적 전통성을 검토한다. 제안서가 채택되어지면 계약을 맺는다. 계약된 자료를 바탕으로 하여 게시판 자료실 등 기본적인 구조에 대한 항목(Directory)를 개발하고 게시판의 각 항목에 대한 기능을 규정하기도 한다. 게시판 제목전환 또는 성격의 변화가 생기면 정보제공자(IP)의 요구에 따라 메뉴를 수정한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"인터넷정보제공자관리원","dJobECd":"1343","dJobECdNm":"[1343]정보시스템 운영자","dJobJCd":"2241","dJobJCdNm":"[2241]정보 시스템 운영자","dJobICd":"J631","dJobICdNm":"[J631]자료처리, 호스팅, 포털 및 기타 인터넷 정보매개 서비스업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007692:1', '{"dJobCd":"K000007692","dJobCdSeq":"1","dJobNm":"지능형교통체계유지관리자","workSum":"지능형교통체계의 유지관리 대상을 분석하여 계획을 수립하고 유지관리, 성능관리 및 유지관리 결과를 분석한다.","doWork":"지능형교통체계가 설치된 현장 및 센터 설비의 성능을 유지하기 위하여 장애이력 등 설비현황을 분석한다. 유지보수 매뉴얼에 따라 지능형교통체계 시설별 사전보전 및 사후보전 계획을 수립한다. 지능형교통체계 설비의 기능 유지를 위해 일상적인 점검⋅정비 및 장애조치를 수행하고, 시설물 성능유지를 위하여 대상설비의 성능을 검증하고 관리한다. 지능형교통체계 설비의 가동률 향상 및 최상의 기능 유지를 위하여 유지관리 수행 결과에 대하여 종합적으로 분석한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"정보처리기사, 정보처리산업기사, 전기기사, 정보통신기사, S/W기술자","dJobECd":"1343","dJobECdNm":"[1343]정보시스템 운영자","dJobJCd":"2241","dJobJCdNm":"[2241]정보 시스템 운영자","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2025"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002106:1', '{"dJobCd":"K000002106","dJobCdSeq":"1","dJobNm":"컴퓨터시스템관리원","workSum":"정보시스템을 안정적으로 관리·운영하고, 시스템의 성능을 최적의 상태로 유지하기 위한 제반 업무를 수행한다.","doWork":"정보시스템의 관리와 운영에 대한 지침서를 작성한다. 컴퓨터시스템의 구성요소에 대한 유지, 보수 등 관리방안을 마련한다. 전산실의 온도, 습도, 분진 등을 체크하여 적정수준을 유지시켜 시스템장비를 보호한다. 정보시스템의 사용자를 등록·관리하고 이들에 대하여 시스템 접근을 관리한다. 정보시스템의 자원을 보호하기 위한 관리적, 기술적 보안조치를 마련하고, 이를 관리·통제한다. 정보시스템의 안정적인 운영을 위하여 수시로 시스템의 성능 및 기능을 점검하고, 문제를 해결한다. 시스템에서 운영되고 있는 실제데이터를 정기적으로 백업한다. 시스템 운영상의 문제점 및 고장이 발생되었을 경우 원인을 파악하여 시스템을 최단시간 내에 복구한다. 정보시스템의 관리현황을 문서로 기록·관리한다. 시스템 성능향상 시 종합적으로 시스템의 기능 및 성능을 평가한다. 사용자의 불편 및 요구사항을 수시로 점검하고, 개선책을 마련한다. 사용자의 기술 관련 문의에 응대하고, 시스템 사용교육을 실시한다. 정보시스템의 가동 및 정지의 권한을 갖고 필요시 시스템을 가동 및 정지시킨다. 하드웨어 및 소프트웨어에 대한 정보기술의 발전동향과 추세를 분석하여 향후 시스템의 성능향상 시 반영한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"시스템운영관리자, 시스템관리자, 컴퓨터시스템관리자, 전산시스템관리자","connectJob":"IT장비기술지원원, 전산장비운영자, 전산장비관리자","certLic":"정보처리기사, 전자계산기조직응용기사","dJobECd":"1343","dJobECdNm":"[1343]정보시스템 운영자","dJobJCd":"2241","dJobJCdNm":"[2241]정보 시스템 운영자","dJobICd":"J620","dJobICdNm":"[J620]컴퓨터 프로그래밍, 시스템 통합 및 관리업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003230:1', '{"dJobCd":"K000003230","dJobCdSeq":"1","dJobNm":"컴퓨터시스템오퍼레이터","workSum":"기업이나 연구소 등의 전산실업무가 원활히 수행될 수 있도록 컴퓨터시스템의 가동상태를 점검·관리한다.","doWork":"각 기업 또는 연구소에 설치된 컴퓨터의 종류와 사양을 확인하고, 사용되는 프로그램을 검토한다. 컴퓨터의 운영체계 및 시스템 사용방법을 확인하고, 효율적인 사용방법을 조언한다. 새로 개발된 컴퓨터시스템을 작동하여 운영체계, 속도, 안정성, 오류 등을 점검하고 보고자료를 작성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"컴퓨터시스템운영원","certLic":"전자계산기조직응용기사","dJobECd":"1343","dJobECdNm":"[1343]정보시스템 운영자","dJobJCd":"2241","dJobJCdNm":"[2241]정보 시스템 운영자","dJobICd":"J620","dJobICdNm":"[J620]컴퓨터 프로그래밍, 시스템 통합 및 관리업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003961:1', '{"dJobCd":"K000003961","dJobCdSeq":"1","dJobNm":"컴퓨터운영지원원","workSum":"컴퓨터 및 주변기기의 작동상태를 시험하고, 작동프로그램을 작성하여 컴퓨터에 적용하고, 작업원들을 교육한다.","doWork":"컴퓨터가 사용자의 의도대로 작동할 수 있도록 각종 회로 기판과 관련된 자료를 수집하여 작동프로그램을 작성한다. 컴퓨터의 오작동을 확인하고 프로그램을 수정하며 작업원들을 교육한다. 개별생산공정에 따른 프로그램을 컴퓨터에 이식하여 문제점이 발생하면 조치한다. 각종 회로 기판과 시스템에 맞는 요소별 작동프로그램을 준비한다. 프로그램의 평가 및 오류를 찾아 수정한다. 프로그램을 생산공정에 적용하고 작업원을 교육한다. 테스트작업 시 프로그램에 문제가 발생하면 원인을 찾아 조치·해결한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"정보처리기사, 전자계산기기사, 전자계산기조직응용기사","dJobECd":"1343","dJobECdNm":"[1343]정보시스템 운영자","dJobJCd":"2241","dJobJCdNm":"[2241]정보 시스템 운영자","dJobICd":"C263","dJobICdNm":"[C263]컴퓨터 및 주변장치 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005144:1', '{"dJobCd":"K000005144","dJobCdSeq":"1","dJobNm":"컴퓨터하드웨어기술지원원","workSum":"컴퓨터사용자가 컴퓨터하드웨어를 이용할 수 있도록 프로그램 설치, 시스템 최적화, 운영 중 문제점 해결안 제시 등의 기술적 지원을 한다.","doWork":"하드웨어를 설치하기 위하여 전원과 환경을 점검한다. 운영체제(OS)를 인스톨하고 응용소프트웨어를 설치한다. 고객이 사용하기를 원하는 특정응용프로그램을 설치해준다. 시스템을 설치한 후에 각종 튜닝툴을 이용하여 점검을 하고 시스템이 최적의 성능을 발휘할 수 있도록 분석해서 조정해주는 시스템 튜닝을 한다. 고객이 시스템 운영 중에 문제가 발생하면 컴퓨터에 나타난 문제를 진단하고 전문적인 지원을 해준다. 시스템이 정확하게 작동을 하는지 혹은 오류가 있는지를 진단하기 위해 테스트한다. 사용자가 상품을 효율적으로 사용하는 데 불편이 없는지를 평가하기 위해 하드웨어 그리고 주변장치를 검사하고 모니터한다. 시스템이 문제가 발생할 소지가 있는지를 분석하고 주기적인 점검을 하여 예상되는 문제점을 고객에게 알려주고 해결하기 위한 대안도 제시해준다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"전자계산기조직응용기사","dJobECd":"1343","dJobECdNm":"[1343]정보시스템 운영자","dJobJCd":"2241","dJobJCdNm":"[2241]정보 시스템 운영자","dJobICd":"J620","dJobICdNm":"[J620]컴퓨터 프로그래밍, 시스템 통합 및 관리업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001540:1', '{"dJobCd":"K000001540","dJobCdSeq":"1","dJobNm":"클라우드기술지원엔지니어","workSum":"클라우드 서비스를 사용하는 고객의 기술적인 문제 및 요구사항을 파악하고 적절한 해결책을 제공한다.","doWork":"클라우드 서비스의 다양한 문제 및 고객의 요구에 대하여 상황에 맞는 적절한 해결책을 제공하기 위한 트러블 슈팅 업무로서 클라우드 환경의 서버, 스토리지, 데이터베이스, 네트워크, 보안 등 인프라 구성 및 설치, 이중화를 비롯하여 API, Data, 메일, 비즈니스 업무도구 등 다양한 클라우드 서비스에 대한 고객의 기술적인 문제를 파악하고 해결하여 지원하며 장애 발생 시 이를 대응하고 처리한다. 클라우드 제품에 대한 고객의 피드백, 이슈, 제안사항 등을 내부 유관부서에 제공하고 협업하여 고객의 문제 해결을 지원하고 효과적이고 효율적인 기술지원 방안을 모색한다.  고객지원 관련 프로세스 및 고객을 위한 기술지원 서비스를 개선한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"1343","dJobECdNm":"[1343]정보시스템 운영자","dJobJCd":"2241","dJobJCdNm":"[2241]정보 시스템 운영자","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004491:1', '{"dJobCd":"K000004491","dJobCdSeq":"1","dJobNm":"애드마스터","workSum":"인터넷광고서버를 관리하고, 새로운 광고기법에 대해 연구한다.","doWork":"인터넷광고서버인 애드서버에 배너의 노출 및 클릭 수를 점검한다. 애드서버에 쓰이는 플래시작업을 한다. 애드서버에 프로그램을 설치한다. 광고주의 요청에 따라 광고를 수정한다. 애드서버의 업그레이드작업을 한다. 새로운 광고기법에 대해 연구하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"광고서버관리자","dJobECd":"1344","dJobECdNm":"[1344]웹 운영자","dJobJCd":"2242","dJobJCdNm":"[2242]웹 운영자","dJobICd":"M713","dJobICdNm":"[M713]광고업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002318:1', '{"dJobCd":"K000002318","dJobCdSeq":"1","dJobNm":"웹마스터","workSum":"웹서버구축 및 관리, 홈페이지 운영전반에 걸쳐 실무적인 책임을 진다.","doWork":"홈페이지 운영전반에 관한 책임을 진다. 서비스될 내용을 선택한다. 서비스내용에 대한 기획을 한다. 홈페이지 제작 및 구성, 디자인업무를 책임진다. 사용자인터페이스와 레이아웃, 가이드라인을 적용한다. 웹서버구축 및 운영에 대한 기술적인 책임을 진다. 새로운 웹 관련 기술의 적용에 대한 책임을 진다. 홈페이지에서 운영될 각종 응용프로그램을 개발한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"제어조작","dJobECd":"1344","dJobECdNm":"[1344]웹 운영자","dJobJCd":"2242","dJobJCdNm":"[2242]웹 운영자","dJobICd":"J620","dJobICdNm":"[J620]컴퓨터 프로그래밍, 시스템 통합 및 관리업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005778:1', '{"dJobCd":"K000005778","dJobCdSeq":"1","dJobNm":"웹서버관리원","workSum":"인터넷에 접속하기 위한 전용망의 운용 및 유지보수, 회선개통과 장애처리를 지원한다.","doWork":"시스템의 부하, 프로세스를 점검한다. 출력메시지를 분석하여 조치한다. 네트워크 전산동작을 감시한다. 하드디스크 사용량 및 여유상태를 점검한다. 루트(Root) 계정상태를 확인한다. 로그인상태를 확인한다. 회선망을 감시한다. 접속노드(Node)별 망 감시기능을 점검한다. 서버 등 시스템 간의 트래픽을 관리한다. 가입자회선구성 및 개통에 따른 지원을 한다. 각종 기기변경에 따른 데이터베이스(DB)를 변경한다. 노드별 접속포트시설을 관리한다. 모뎀을 점검한다. 데이터서비스장치(DSU:Data Service Unit)를 점검한다. 접속번호를 호출시험한다. 회선접속장비, 국제연동회선, 컴퓨터통신망, 공중기업통신망, 가입자전용선을 시험한다. 가입자고장신고 접수 시 고장내용을 분석하고 수리를 의뢰한다. 시스템, 부대시설을 정기점검하고 콘솔(Console)에러메시지를 분석·관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"서버운영원, 서버관리자, 서버엔지니어","connectJob":"UNIX계열서버운영원, LINUX계열서버운영원, NT계열서버운영원, 게임서버운영관리자, 웹호스팅기술자","certLic":"정보처리산업기사, 무선설비기사, 무선설비산업기사, 무선설비기능사","dJobECd":"1344","dJobECdNm":"[1344]웹 운영자","dJobJCd":"2242","dJobJCdNm":"[2242]웹 운영자","dJobICd":"J631","dJobICdNm":"[J631]자료처리, 호스팅, 포털 및 기타 인터넷 정보매개 서비스업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006614:1', '{"dJobCd":"K000006614","dJobCdSeq":"1","dJobNm":"커뮤니티서비스관리원","workSum":"인터넷이용자를 대상으로 커뮤니티 및 커뮤니케이션서비스를 기획·운영하고 이용자를 관리한다.","doWork":"커뮤니티나 동호회의 활동과 관련된 행사, 회원관리 등에 대한 지원 및 메뉴개편, 장애처리 등의 동호회시스템을 지원한다. 전자우편 및 대화방, 자료실 등의 시스템을 구축 및 운용한다. 게시판서비스를 제공한다. 성인자료 및 불법자료에 대해 주기적으로 모니터링하고 관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"비비에스서비스관리원, BBS서비스관리원, BBS관리원, 커뮤니티관리원","dJobECd":"1344","dJobECdNm":"[1344]웹 운영자","dJobJCd":"2242","dJobJCdNm":"[2242]웹 운영자","dJobICd":"J631","dJobICdNm":"[J631]자료처리, 호스팅, 포털 및 기타 인터넷 정보매개 서비스업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005408:1', '{"dJobCd":"K000005408","dJobCdSeq":"1","dJobNm":"공중기업망운용원","workSum":"공중기업망의 운용 및 유지보수, 이상고장 대책수립 및 기술지원, 고장분석, 운용보전, 회선개통, 장애처리를 한다.","doWork":"공중기업망(CO-LAN:Central Office-Local Area Network, 기업의 전산시스템과 분산된 단말기 간을 서로 효과적으로 통신할 수 있도록 일반전화 회선다중화장치(VDM)를 설치하고 전화국에 회선다중화장치와 국설용 가상회선교환(Virtual Circuit Switching)방식의 데이터교환기를 설치하여 음성과 데이터를 동시에 제공하는 패킷교환방식의 데이터통신망 서비스)의 시스템 동작상태를 예방점검하고, 접속노드별 번호관리를 한다. 각종 데이터를 수집, 보고, 저장, 처리 및 출력관리를 한다. 운용소프트웨어를 업데이트한다. 회선망을 관리한다. 시스템의 날짜, 시간표시를 점검하고 트렁크 회선상태를 점검한다. 가입자 댁내시설을 조사하며 순회점검한다. 단말기다중화장치(SAM), 원격음성·데이터다중화장치(R-VDM:Remote Voice Data Multiplexer), 전화국용음성·데이터다중화장치(CO-VDM:Central Office-Voice Data Multiplexer), 데이터서비스장치(DSU:DataService Unit이란 단말기 또는 컴퓨터에서 출력되는 디지털신호를 디지털 전송로에 알맞은 신호형식으로 변환하는 기능과 그 역변환을 수행하는 데이터 종단장치를 말한다) 등 망의 유지에 필요한 기기들을 확인·점검한다. 단자정리 및 배선정리를 하여 접속노드를 정리한다. 전화국용음성·데이터다중화장치(CO-VDM)를 점검하고 포트를 정리한다. 가입자 회선구성 여부 및 개통 관련 문서를 접수하고 처리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"CO-LAN운용원","certLic":"정보통신기사, 통신선로기사, 통신선로산업기사","dJobECd":"1360","dJobECdNm":"[1360]통신·방송송출 장비 기사","dJobJCd":"2250","dJobJCdNm":"[2250]통신 및 방송 송출 장비 기사","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006285:1', '{"dJobCd":"K000006285","dJobCdSeq":"1","dJobNm":"교환기운용원","workSum":"전화통화의 질을 향상하기 위하여 전자교환시스템을 운용하고 유지보수한다.","doWork":"전화국 또는 전화집중국에 설치된 전자식교환시스템의 단말기를 통해 교환기의 작동상황을 파악한다. 전자식교환시스템의 정기시험 및 자체점검을 실시하여 장애요인을 사전에 방지하고 회선단락·신호미착 등의 장애요인을 분석한다. 전자식교환시스템 프로그램과 전자설비의 변경에 따라 기판을 교체한다. 교환설비의 착발신호, 통화전류, 신호절단 등 각종 기능의 이상 유무를 시험한다. 파손된 설비의 출력장치를 확인하여 파손부위를 확인하고 장애가 발생한 기판을 교체한다. 주기적으로 중앙전산처리장치와 전자교환기가 정상적으로 작동하는지 점검하고 작업일지에 기록한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"전자식교환시스템운용원, 교환설비운용원","certLic":"정보통신기사, 정보통신산업기사, 통신기기기능사","dJobECd":"1360","dJobECdNm":"[1360]통신·방송송출 장비 기사","dJobJCd":"2250","dJobJCdNm":"[2250]통신 및 방송 송출 장비 기사","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002965:1', '{"dJobCd":"K000002965","dJobCdSeq":"1","dJobNm":"디지털회선분배장치운용원","workSum":"디지털교차접속시스템을 점검 및 운용하고, 가입자 회선을 수용 및 관리한다.","doWork":"디지털교차접속시스템(Digital Cross-connect System：고속디지털회선에서 각 디지털신호에 대한 전자적 교차접속을 수행하는 기능을 하고 트래픽의 통합, 회선분배 및 재분배를 가능하게 하여 네트워크의 이용과 효율성을 증진하는 시스템)의 전원부, 경보회로, 동기클럭(서로 다른 시스템이나 네트워크에서 클럭 주파수나 비트, 프레임, 워드 등을 일치시키는 것) 등을 점검한다. 데이터를 백업하여 저장 및 관리한다. 회선접속을 해지하고 프린터에 메시지를 출력하여 분석한다. 고장회로 기판을 교체한다. 운용일지를 작성한다. 고장관리를 분석한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"정보통신기사, 정보통신산업기사, 통신기기기능사","dJobECd":"1360","dJobECdNm":"[1360]통신·방송송출 장비 기사","dJobJCd":"2250","dJobJCdNm":"[2250]통신 및 방송 송출 장비 기사","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002558:1', '{"dJobCd":"K000002558","dJobCdSeq":"1","dJobNm":"무선기기감시원","workSum":"무선단말기의 불법이용에 대한 신고를 받아 대응조치를 취하고, 불법 무선단말기 추적을 위한 방법을 찾고 관련 시스템을 개발한다.","doWork":"불법복제 무선단말기 방지대책을 수립한다. 불법무선단말기 추적시스템을 개발·구축한다. 불법 무선단말기 신고센터를 운영하여 고객으로부터 직접 접수를 받아 상담을 하고 불법사용내역을 분석한다. 분석결과를 고객에게 알려주고 일정기간 후에 전화로 불법사용 여부에 대한 재확인을 한다. 분석결과 불법행위가 이루어지는 것으로 판단이 되면 관계기관에 조사를 의뢰한다. 생산업체에 불법방지대책을 협조한다. 불법사용에 대하여 외국사례 및 우리나라 사례를 분석하고 사례집을 발간한다. 불법무선국(전파법에 의해 무선국의 허가를 받지 않고 불법으로 전파를 발사하는 무선국), 불법감청설비, 불법정보통신기기를 탐색하고 단속하기도 한다. 불법 무선단말기 추적을 위한 방법을 찾고 관련 시스템을 개발한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"불법무선통신관리원","certLic":"전파통신기사, 전파통신산업기사, 전파통신기능사","dJobECd":"1360","dJobECdNm":"[1360]통신·방송송출 장비 기사","dJobJCd":"2250","dJobJCdNm":"[2250]통신 및 방송 송출 장비 기사","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004457:1', '{"dJobCd":"K000004457","dJobCdSeq":"1","dJobNm":"무선기지국운용원","workSum":"무선기지국 및 중계기관리에 필요한 각종 장비 및 용역서비스를 관리한다.","doWork":"기지국관리시스템을 운용·관리한다. 기지국, 중계기의 상황 및 데이터를 관리한다. 기지국 관리에 필요한 계측기, 예비품, 공기구, 유지용품, 비품, 차량을 관리한다. 냉방기, 철탑, 중계기의 유지보수 등에 대한 용역을 관리한다. 수리차량을 종합관리한다. 기지국 출입통제 및 시설 보안관리를 한다. 긴급복구를 지원한다. 전파사용료 및 면허세관리를 한다. 기지국을 정기점검한다. 장애처리 및 긴급복구를 한다. 기지국 장애상황을 기록관리한다. 기지국의 신설, 증설, 변경, 이설 및 인수업무를 수행한다. 이동중계기를 설치·운용하며 유지보수를 한다. 가입자 통화불만을 접수하여 처리한다. 기지국 통화품질불량이 발생하면 특별점검을 실시한다. 통화품질을 측정하고 관리한다. 무선국을 정기검사한다. 기지국 건물의 민원발생 시 처리를 한다. 기지국 유니트의 고장 시 수리를 의뢰한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"무선중계기시스템운영원, 무선호출기지국운용원, 중계기운용원","certLic":"무선설비기사, 무선설비산업기사, 무선설비기능사, 전파통신기사, 전파통신산업기사, 통신기기기능사","dJobECd":"1360","dJobECdNm":"[1360]통신·방송송출 장비 기사","dJobJCd":"2250","dJobJCdNm":"[2250]통신 및 방송 송출 장비 기사","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004677:1', '{"dJobCd":"K000004677","dJobCdSeq":"1","dJobNm":"발전통신원","workSum":"발전소의 보안설비, 인터넷, 사무자동화설비, 전력·통신설비 등 각종 정보·통신설비를 유지·관리·운영하기 위한 제반 기술공무를 수행한다.","doWork":"발전소의 효율적 운영을 위하여 정보·통신설비에 대한 순회점검, 정기점검 등을 통하여 정상적인 가동이 이루어지도록 유지·관리한다. 전력소를 운영하는 데 필요한 각종 자료를 처리하는 전산설비 및 전산시스템을 정상적인 상태로 유지되도록 관리한다. 경비용 인터폰, CCTV 및 적외선감지설비 등의 보안시스템의 정상적인 작동상태가 유지되도록 관리한다. 비상사태 및 위험한 상황에 대처하기 위하여 군부대 및 유관기관에 연결된 직통전화의 상태를 점검하고 정상적인 작동이 되도록 유지·관리한다. 기타 정보통신 및 전산설비에 대한 유지·관리와 공무를 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"발전통신엔지니어, 발전통신기사","certLic":"정보처리산업기사, 무선설비산업기사","dJobECd":"1360","dJobECdNm":"[1360]통신·방송송출 장비 기사","dJobJCd":"2250","dJobJCdNm":"[2250]통신 및 방송 송출 장비 기사","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004446:1', '{"dJobCd":"K000004446","dJobCdSeq":"1","dJobNm":"방송송출기사","workSum":"종합유선방송사업자(SO:System Operator) 및 시청자에게 제작된 방송프로그램을 송출하기 위해 송출장비를 조작·운용한다.","doWork":"편성된 프로그램 스케줄을 확인하고, 미리 준비된 프로그램 제작테이프를 실행시킨다. 송출장비(마스터스위처)를 조작하여 프로그램을 송출한다. 모니터링을 통해 방송사고에 항상 대비하고, 송출신호흐름이 원활한지 관찰한다. 긴급상황으로 인한 프로그램 변경요청이 있을 시 송출장비를 조작하여 변경한다. 송출장비 조작에 문제가 발생할 경우 방송시스템관리자와 문제점에 대하여 논의한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"방송송출장비기사, 방송송출기술자","connectJob":"라디오를 송출하면 라디오송출기사","dJobECd":"1360","dJobECdNm":"[1360]통신·방송송출 장비 기사","dJobJCd":"2250","dJobJCdNm":"[2250]통신 및 방송 송출 장비 기사","dJobICd":"J601/J602","dJobICdNm":"[J601]라디오 방송업 / [J602]텔레비전 방송업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006810:1', '{"dJobCd":"K000006810","dJobCdSeq":"1","dJobNm":"방송주조감독","workSum":"라디오 및 텔레비전방송국의 송신장비를 조작하는 작업원들의 활동을 감독·조정한다.","doWork":"라디오, 텔레비전방송국의 주조정실에서 방송프로그램의 편성순서에 따라 녹화방송 및 생방송을 확인한다. 영상 및 음향신호의 송신신호를 일정수치로 유지하기 위하여 송신장비를 수시로 확인한다. 송신장비의 고장원인을 조사하고 수리하도록 지시한다. 방송송신장비의 전반적인 작동상태를 감독하고 장비의 조작을 지시한다. 긴급사고 발생 시에는 응급조치를 취하고 수리 관련 부서에 연락한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"보통 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","similarNm":"주조기술감독, 주조정실감독","connectJob":"하는 일에 따라 라디오주조기술감독, 텔레비전주조기술감독, 케이블TV주조기술감독","certLic":"전파통신기사","dJobECd":"1360","dJobECdNm":"[1360]통신·방송송출 장비 기사","dJobJCd":"2250","dJobJCdNm":"[2250]통신 및 방송 송출 장비 기사","dJobICd":"J602","dJobICdNm":"[J602]텔레비전 방송업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006351:1', '{"dJobCd":"K000006351","dJobCdSeq":"1","dJobNm":"방송중계회선기사","workSum":"방송국 외의 현장에서 스포츠 및 행사를 중계방송하기 위해 텔레비전 또는 라디오중계차 등의 방송장비를 설치·운용한다.","doWork":"기술감독, 조명감독 및 음향감독 등과 중계방송할 현장에 방문하여 회선을 설치할 장소를 미리 파악한다. 현장에 적합한 회선의 종류를 선택하고 기술진과 협의한다. 중계방송장비를 현장에 설치하고 방송 전에 시험 가동한다. 케이블 등의 유무선회선 설치종사자의 업무를 지시·감독한다. 모니터를 확인하여 색상, 화면번짐 등의 장애를 제거하고 회선을 관리한다. 방송 후 회선을 철거하거나 철거인력의 활동을 조정·감독한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"시각|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"중계방송회선설치기사, 중계방송회선엔지니어","dJobECd":"1360","dJobECdNm":"[1360]통신·방송송출 장비 기사","dJobJCd":"2250","dJobJCdNm":"[2250]통신 및 방송 송출 장비 기사","dJobICd":"J601/J602","dJobICdNm":"[J601]라디오 방송업 / [J602]텔레비전 방송업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002240:1', '{"dJobCd":"K000002240","dJobCdSeq":"1","dJobNm":"부가서비스장비운용원","workSum":"교환장비에 부착된 각종 부가서비스 장비를 통합 관리한다.","doWork":"교환기에 부착된 음성메시지서비스(VMS:Voice Message Service), 단문메시지서비스(SMS:Short Message Service), 음성인식다이얼서비스(VAD:Voice Acknowledge·Activated Dialing Service), 가입자위치측정(HLR:Home Location Register), 착신번호시스템 등 각종 부가서비스 장비의 작동을 감시한다. 운용데이터를 백업하고 출력물을 관리하며 각종 통계자료의 후처리를 실시하기도 한다. 이상이 발견된 회로 기판을 교체하고 난해한 고장은 장비공급자에게 수리의뢰를 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","connectJob":"통신유형에 따라 유선통신부가서비스장비운용원, 무선통신부가서비스장비운용원","certLic":"정보통신기사, 정보통신산업기사, 통신기기기능사","dJobECd":"1360","dJobECdNm":"[1360]통신·방송송출 장비 기사","dJobJCd":"2250","dJobJCdNm":"[2250]통신 및 방송 송출 장비 기사","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003668:1', '{"dJobCd":"K000003668","dJobCdSeq":"1","dJobNm":"선박통신사","workSum":"선박의 통신부에서 무선통신의 수발, 통신일지의 정리, 소관장비·용품을 정비·관리한다.","doWork":"국제신호서와 표준해사항해 용어를 이용하여 무선전신 또는 무선전화에 의한 선박의 항해안전과 수송에 필요한 통신을 수발한다. 무선통신기나 무선전화기로 통신문을 송신하고 무전에 의한 항해 및 기타 자료의 입수를 포함하여 들어오는 통신문을 수신하고 기록한다. 공중통신의 취급, 무선기기의 취급, 보수, 유지와 무선부의 장비, 용품을 정비하고 관리한다. 항해 중에 무선부의 당직에 임하여 통상의 업무연락을 하고 조난주파수에 의한 청취를 하며 사무부 소관업무를 수행한다. 수색 및 구조·구난무선통신을 착신하여 선박끼리의 교신에 대처한다. 송수신한 통신문의 내용에 따라 항해일지를 기록하고 간단한 경우 무전설비를 수리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"선박통신원, 선박통신엔지니어, 선박통신기사","connectJob":"선박통신시스템엔지니어, 선박통신장비엔지니어","certLic":"전파통신산업기사, 전파전자산업기사","dJobECd":"1360","dJobECdNm":"[1360]통신·방송송출 장비 기사","dJobJCd":"2250","dJobJCdNm":"[2250]통신 및 방송 송출 장비 기사","dJobICd":"H501","dJobICdNm":"[H501]해상 운송업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002411:1', '{"dJobCd":"K000002411","dJobCdSeq":"1","dJobNm":"위성통신설비관리원","workSum":"원활한 국제통신소통 및 위성중계 등을 위하여 안테나·중계장치·변환장치 등의 위성통신송수신설비를 관리한다.","doWork":"위성통신지구국(지구궤도에 떠있는 통신위성과 전파를 송수신하여 한국과 외국 사이에 통신 및 텔레비전 중계가 가능하도록 설치된 통신중계시설)의 위성통신설비를 관리한다. 중계장치, 변환장치 등 각종 설비의 가동 및 정기시험 중에 발생하는 장애원인을 파악하고 유형별로 분류하여 정리한다. 통신설비의 가동계획에 따라 안테나제어장치를 점검하고 사용주파수를 확인한다. 송수신장치 및 중계장치 등 설비별로 기능시험을 실시하여 혼선, 잡음 등의 중복장애를 사전에 제거한다. 주기적으로 외부에 설치된 안테나의 가동상태를 점검하고 일지에 기록한다. 파손되거나 낡은 부품을 교체하고 관련 부서에 수리를 의뢰한다. 각종 설비에 대한 정기 및 비정기시험계획을 수립하고 사용주파수, 사용시간 등을 관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"위성통신망운용원, 위성통신망관리원","connectJob":"인공위성관제원","certLic":"전파전자산업기사, 전파통신기사, 전파통신산업기사, 방송통신기사, 무선설비기능사","dJobECd":"1360","dJobECdNm":"[1360]통신·방송송출 장비 기사","dJobJCd":"2250","dJobJCdNm":"[2250]통신 및 방송 송출 장비 기사","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006397:1', '{"dJobCd":"K000006397","dJobCdSeq":"1","dJobNm":"유선통신망관리원","workSum":"유선통신관제를 실시하고, 장애발생 시 복구를 실시한다.","doWork":"통신망관리센터에서 집중운용보전시스템을 모니터링한다. 트래픽, 통화품질을 관리하는 망관리시스템의 이상신호 발생 시 장애의 원인을 분석한다. 통신망 시설장애에 대한 해결책을 모색하고, 장애발생 시 복구를 실시한다. 통신망관리센터의 운용계획을 수립한다. 통신망시설 및 운용상태를 주기적으로 점검한다. 통신망 회선운용관리기준 및 중계선로 적용기준을 설정하기도 한다. 과금관리, 보안관리, 고객망관리를 수행하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"초고속통신망관제원, 유선통신망관제원, 유선통신설비관리원","certLic":"정보통신기사, 정보통신산업기사, 정보통신기능사","dJobECd":"1360","dJobECdNm":"[1360]통신·방송송출 장비 기사","dJobJCd":"2250","dJobJCdNm":"[2250]통신 및 방송 송출 장비 기사","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003053:1', '{"dJobCd":"K000003053","dJobCdSeq":"1","dJobNm":"인공위성제어시스템유지보수원","workSum":"위성지구국에서 위성제어에 필요한 각종 안테나와 장치를 유지보수한다.","doWork":"위성지구국에서 위성관제에 필요한 RF(Radio Frequency)기기, IF(Intermediate Frequency:주파수 변환기에 의해 수신전파의 주파수와 국부발진기 주파수의 차에 해당하는 주파수, 일반적으로 중간주파수는 수신주파수보다 낮게 하여 증폭하기 쉽고 선택도 및 충실도를 높게 하는 것을 목적으로 함), BB(Base Band)기기, 텔레메트리체인(Telemetry Chain:인공위성의 상태를 알려주는 시스템), 커맨드체인(Command Chain:인공위성에 명령을 내리는 시스템), TTC(Telemetry Tracking and Command:위성트랙킹과 링크를 위한 시스템)시스템, SCC(Satellite Control Center)시스템을 점검하고 이상발생 시 유지보수한다. 위성안테나 시설 및 안테나제어시스템을 운용하고 유지보수를 한다. 위성통신망운용원과 함께 위성방송에 필요한 DBS(Digital Broadcasting System:디지털방송) 부송신국 시설을 점검한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"방송통신기사, 무선설비기사, 무선설비산업기사, 무선설비기능사","dJobECd":"1360","dJobECdNm":"[1360]통신·방송송출 장비 기사","dJobJCd":"2250","dJobJCdNm":"[2250]통신 및 방송 송출 장비 기사","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001629:1', '{"dJobCd":"K000001629","dJobCdSeq":"1","dJobNm":"전동차통신사령원","workSum":"안전한 열차의 운행을 위하여 각종 통신기기의 중앙감시제어를 하고 이상발생 시 적절히 대처한다.","doWork":"열차종합제어시스템(TTC:Total Traffic Control) 및 열차중앙제어시스템(CTC:Centralized Traffic Control)운용으로 열차의 운행상황을 직접 파악하여 열차운행을 감시한다. 열차운전관리의 신속·정확성을 위해 컴퓨터를 운용하여 현장신호기제어, 열차속도지령, 열차번호변경, 진로설정 이상 유무 등 기계동작상태를 점검 및 유지·보수한다. 정보전송장치(DTS:Data Transfer System)를 운용하여 현장과 사령 간의 정보송수신의 정확을 기하고 이상 시 데이터를 조사하고 조치를 취한다. 열차운행 중 신호장치 이상 시 적절한 조취를 취하여 열차의 정상운행을 재개하도록 한다. 컴퓨터, 정보전송장치, 인터페이스, 역 간판(Station Sign) 등의 신호장치 및 현장신호설비의 동작상태를 확인·감시한다. 기계실의 컴퓨터 및 주변장치, 정보전송장치(DTS), 전원장치, 에어컨과 사령실표시판, 터미널보드, 모니터 등을 점검하고 보수한다. 현장신호설비의 장애사항과 사고발생상황을 파악하고 운전사령원과 협조하여 열차지연을 최소화하고 각 통신분소와 협조하여 장애를 신속히 복구토록 한다. 사령실 및 기계실의 프린터로 출력되는 정보의 내용을 분석하여 보고한다. 현장 및 기계실의 컴퓨터, 정보전송장치, 신호설비장치를 분기별, 반기별로 검사한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"1360","dJobECdNm":"[1360]통신·방송송출 장비 기사","dJobJCd":"2250","dJobJCdNm":"[2250]통신 및 방송 송출 장비 기사","dJobICd":"H492","dJobICdNm":"[H492]육상 여객 운송업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003272:1', '{"dJobCd":"K000003272","dJobCdSeq":"1","dJobNm":"전송설비운용원","workSum":"통신선로의 효율적인 운용을 위하여 하나의 선로에 이용주파수를 분할하는 반송장치를 유지·보수한다.","doWork":"다중시험기, 회로시험기, 단국장치 등 각종 측정장비를 사용하여 반송변환장치의 송수신부, 원방감시장치(Supervisory Control And Data Acquisition), 단국장치(Terminal Equipment), 통화로변환장치(Channel Translating Equipment) 등의 설비에 대한 기능시험 및 점검을 실시한다. 장애가 발생한 반송설비 및 장치에 관련된 문제점을 찾기 위하여 상대국(타 전화국)기술자와 의견을 교환하고, 각종 측정장비를 사용하여 파손원인 및 위치를 점검한다. 파손된 설비의 부품을 교체하고 원인을 분석한다. 교체한 부품의 종류 및 규격을 일지에 기록하고 장애원인 및 보수방법을 정리하여 보고자료를 작성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","connectJob":"광전송설비운용원, 동축전송설비운용원, 해저전송설비운용원","certLic":"정보통신기사, 정보통신산업기사, 통신선로산업기사, 통신선로기능사, 통신기기기능사","dJobECd":"1360","dJobECdNm":"[1360]통신·방송송출 장비 기사","dJobJCd":"2250","dJobJCdNm":"[2250]통신 및 방송 송출 장비 기사","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001868:1', '{"dJobCd":"K000001868","dJobCdSeq":"1","dJobNm":"전용회선관리기술자","workSum":"전용회선집중운용시스템(DELMONSE)을 이용하여 전용회선의 고장접수, 고장수배 및 결과통보를 하고, 델몬스시스템의 호스트컴퓨터, 주변장치, 단말기 등을 유지보수한다.","doWork":"모니터상의 출력메시지를 분석하여 이상이 발견되면 델몬스(DELMONSE:가입자의 회선청약에서부터 회선개통, 고장신고의 접수, 회선 데이터 검색, 고장회선의 시험을 통한 고장수리명령서 발송, 고장처리접수 등을 처리할 수 있고, 원격지의 시험장치를 제어할 수 있는 다수의 집중처리컴퓨터 장치)의 랜(LAN)을 점검하여 고장 처리한다. 중앙처리장치(CPU), 원격제어용 회선, 원격장치, 집중운용실 단말기, 자동응답기의 고장수리를 한다. 운영체계인 오라클의 동작상태를 점검하고 로그파일을 분석·조치하며 델몬스프로그램의 동작환경을 점검한다. 시스템을 백업한다. 델몬스프로그램 모듈별 운용에러를 처리한다. 고장신고를 접수하고 전용회선에 대한 시험을 하고 선로원에게 연락한다. 고장확인시험을 하고 결과를 통보한다. 일일 고장통계를 분석하고 개통회선시험을 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"델몬스운용원, 전용회선집중운용시스템관리원","certLic":"정보통신기사, 정보통신산업기사, 통신기기기능사","dJobECd":"1360","dJobECdNm":"[1360]통신·방송송출 장비 기사","dJobJCd":"2250","dJobJCdNm":"[2250]통신 및 방송 송출 장비 기사","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001317:1', '{"dJobCd":"K000001317","dJobCdSeq":"1","dJobNm":"전용회선운용기술자","workSum":"가입자의 통화품질을 유지하기 위하여 선로집중운용시스템을 운용 및 유지·보수한다.","doWork":"가입자 선로집중운용시스템(DELMOS:전용회선집중운용시스템, NeOSS:New Operation Support System, 오퍼레이션 통합운용관리시스템, OM-AS, LCR:Least Cost Router, 최저요금회선 자동선택장치)의 컴퓨터시스템과 주변장치 및 자동분배장치, 자동선로시험기와 단말기를 유지보수·관리한다. 고장신고회선 및 가입자 선로시험용 회선시험을 한다. 통계의 산출을 위한 사용자로부터 입력된 데이터를 관리하고 교환, 중계, 전력, 소통관리, 선로, 품질관리 등의 분야의 이상 및 장애 시 긴급대처하여 시스템을 안정화한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"웅크림|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"선로집중운용시스템관리원, 선로집중운용원","certLic":"정보통신기사, 정보통신산업기사, 통신선로기능사, 통신기기기능사","dJobECd":"1360","dJobECdNm":"[1360]통신·방송송출 장비 기사","dJobJCd":"2250","dJobJCdNm":"[2250]통신 및 방송 송출 장비 기사","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005674:1', '{"dJobCd":"K000005674","dJobCdSeq":"1","dJobNm":"전화교환원","workSum":"착신국의 교환원을 연결하거나 가입자의 번호를 선별하여 전화를 교환·접속하는 교환대를 조작한다.","doWork":"고객으로부터 발신증을 받거나 전화신청을 접수한다. 응답코드의 플러그를 연결하고 착신국의 교환원을 호출한다. 번호통화인 경우에는 전화번호를 확인하고 지명통화의 경우에는 대화자를 호출하여 확인한다. 확인이 완료되면 통화를 연결한다. 통화시간 기록기에 발신증을 끼우고 통화완료 램프가 점등되면 통화시간을 기록한다. 고객에게 통화한 시간 및 요금을 통보한다. 발신국과 착신국이 연결되지 않은 지역의 전화를 중계하기도한다. 국제전화·시외전화 등을 교환하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","connectJob":"국제전화교환원, 시외전화교환원","dJobECd":"1360","dJobECdNm":"[1360]통신·방송송출 장비 기사","dJobJCd":"2250","dJobJCdNm":"[2250]통신 및 방송 송출 장비 기사","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003935:1', '{"dJobCd":"K000003935","dJobCdSeq":"1","dJobNm":"중계방송기술자","workSum":"운동경기, 뉴스 등의 인공위성을 통한 방송이나 국내방송을 중계한다.","doWork":"방송수요 발생 시 송수신 요청을 받아 시간을 결정한다. 해외사업자 또는 국내사업자와 조정을 하여 통신회사의 회선을 개통한다. 방송중계 시 오디오와 비디오기기를 제어하여 최상의 화면을 유지한다. 신호세기 노이즈 등을 영상변환장치를 모니터링하여 방송의 품질을 감시하고 측정한다. 품질이 좋지 않을 경우 좋은 회선으로 라우팅(Routing)을 한다. 위성지구국의 안테나를 네트워크운영시스템(NMS:Network Management System)방식으로 운용한다. 방송품질이 낮은 경우 원인을 규명한다. 위성지구국(정지궤도에 위치한 위성을 중계로 하여 원거리에 전송하는 통신방식에서 지상에 설치한 고정국) 회선을 시험하고 안테나를 검사한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"중계방송엔지니어","connectJob":"경기장통신원","certLic":"방송통신기사","dJobECd":"1360","dJobECdNm":"[1360]통신·방송송출 장비 기사","dJobJCd":"2250","dJobJCdNm":"[2250]통신 및 방송 송출 장비 기사","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001911:1', '{"dJobCd":"K000001911","dJobCdSeq":"1","dJobNm":"지상파DMB멀티플랙서시스템운용원","workSum":"지상파DMB방송 MUX시스템을 운용한다.","doWork":"MUX시스템(Multiplexer:개개의 신호를 받아 단일회선으로 보내거나 단일회선의 신호를 다시 본래의 신호로 분리하는 시스템)을 활용하여 DMB송출을 위한 각각의 채널을 설정하고 변경한다. DMB방송 관련 채널구성내역에 따라 각 채널들의 설정값을 확인한다. MUX 장비 및 신호의 상태를 모니터링하고 정상작동을 유지한다. 신규서비스 시행 시 채널대역에 따라 MUX 설정값을 수정한다. 정해진 채널대역폭에 따라 인코더를 설정 및 변경하고 신호품질을 모니터링한다. TPEG(Transport Protocol Expert Group:DMB 방송주파수를 이용해 자동차 내비게이션 단말기에 실시간 교통정보, 여행정보, 돌발상황정보 등을 보여주는 기술)데이터를 반영하여 설정한다. 수신장애 발생 시 운용지침에 따라 분석하고 조치한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"1360","dJobECdNm":"[1360]통신·방송송출 장비 기사","dJobJCd":"2250","dJobJCdNm":"[2250]통신 및 방송 송출 장비 기사","dJobICd":"J602","dJobICdNm":"[J602]텔레비전 방송업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005052:1', '{"dJobCd":"K000005052","dJobCdSeq":"1","dJobNm":"지상파DMB방송망운영원","workSum":"지상파DMB방송망을 운영·관리한다.","doWork":"지상파DMB 송중계소 및 DMBR(지상파 DMB 서비스 옥외 음영지역을 해소하는 중계기)의 송신기, 전력설비, 공조기, 소방설비 등 기반 설비를 현장에서 확인한다. 오동작, 불량원인을 파악하고 유지·보수·운영한다. 전계강도측정기를 사용하여 난시청지역에 대한 수신전계강도(한 지역에서 수신되는 전자계의 세기)를 측정하고 방송권역 내 전계강도기준에 적합한 양천구역을 파악한다. 주파수 혼간섭현상 발생 시 전파법 관련 규정에 준하여 혼간섭 해소방안을 마련한다. STL(Studio to Transmitter Link:방송국 제작스튜디오 또는 현장중계차에서 송신소까지의 방송프로그램 전송회선)을 구성하고 전송장비, 신호전송 에러 유무, 신호품질 등을 확인한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"1360","dJobECdNm":"[1360]통신·방송송출 장비 기사","dJobJCd":"2250","dJobJCdNm":"[2250]통신 및 방송 송출 장비 기사","dJobICd":"J602","dJobICdNm":"[J602]텔레비전 방송업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002622:1', '{"dJobCd":"K000002622","dJobCdSeq":"1","dJobNm":"지상파DMB송중계시스템운용원","workSum":"지상파DMB방송 송·중계시설을 운용한다.","doWork":"송·중계기 원격감시운용매뉴얼에 따라 감시대항항목에 대한 세부내용을 확인한다. 송·중계기 원격감시모니터 및 감시장비를 사용하여 송·중계기의 이상 유무를 확인한다. 송중계기 운용이력(운용데이터, 로그데이터 등)의 변동사항을 파악하여 방송사고를 예방한다. 송·중계기에 장애발생 시 장애원인을 파악하고 관련 업체, 부서와 협조하여 정보공유 및 부품교체, 송·중계기 안정화 테스트 등을 진행한다. 송·중계시설의 송신기출력, SFN(Single Frequency Network:단일방송망)을 포함한 송신기를 운용한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"1360","dJobECdNm":"[1360]통신·방송송출 장비 기사","dJobJCd":"2250","dJobJCdNm":"[2250]통신 및 방송 송출 장비 기사","dJobICd":"J602","dJobICdNm":"[J602]텔레비전 방송업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003348:1', '{"dJobCd":"K000003348","dJobCdSeq":"1","dJobNm":"케이블방송네트워크시스템운용원","workSum":"케이블방송 프로그램 제작을 위하여 네트워크 장비, 아카이브시스템, 네트워크 기반의 방송장비를 관리·운용한다.","doWork":"케이블방송네트워크 장비의 설계도서를 파악한다. 장비 추가구매 및 확장성을 위해 기존 장비와의 호환성 보장을 위한 장비스펙을 조사한다. 네트워크 장비의 안정적 운용을 위한 예방·보전활동을 수행한다. 아카이브시스템(방송콘텐츠관리시스템)의 특성에 따른 최적화된 스토리지를 구성·유지한다. 요청에 의해 영상파일을 검색·수정·삭제한다. 방송제작 포맷에 따른 네트워크기반 방송제작시스템을 구축하고 시스템을 유지·보수한다. 필요에 따라 미디어를 인제스트(방송영상콘텐츠를 디지털스트림의 형태로 변환해서 콘텐츠관리시스템에 등록), 트렌스코딩(단일환경을 목표로 제작된 음성, 데이터, 영상 등 멀티미디어콘텐츠를 다른 환경에서도 이용할 수 있도록 가공, 선별, 변환)을 한다. 네트워크, 아카이브시스템, 네트워크 기반 제작시스템에 장애발생 시 장애조치를 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"1360","dJobECdNm":"[1360]통신·방송송출 장비 기사","dJobJCd":"2250","dJobJCdNm":"[2250]통신 및 방송 송출 장비 기사","dJobICd":"J602","dJobICdNm":"[J602]텔레비전 방송업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005767:1', '{"dJobCd":"K000005767","dJobCdSeq":"1","dJobNm":"통신시설운용기술자","workSum":"통신시설의 유지관리, 운용보수 등의 계획을 수립하고, 통신시설 유지보수에 필요한 기술 및 유지보수 지도를 한다.","doWork":"통신설비운용에 따른 연간소요예산계획을 수립한다. 월중 작업 및 보수실적을 수합하여 정리·분석한다. 각종 장비의 주요 장애현황을 분석하고 대비책을 강구한다. 통신설비공사에 대한 하자보수 검사를 한다. 직무 및 안전교육실적을 정리한다. 장애발생에 대비하여 비상자재를 확보하고 장애 시 비상복구대책을 수립한다. 무선국 정기검사에 대비하여 시설물을 확인·점검하고 검사준비를 한다. 안전점검계획을 수립하고 시행한다. 통신 관련 직무교육계획을 수립하고 교안을 작성한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"방송통신기사, 방송통신산업기사","dJobECd":"1360","dJobECdNm":"[1360]통신·방송송출 장비 기사","dJobJCd":"2250","dJobJCdNm":"[2250]통신 및 방송 송출 장비 기사","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005991:1', '{"dJobCd":"K000005991","dJobCdSeq":"1","dJobNm":"통신장애처리원","workSum":"각종 부가통신망의 사용 중에 발생하는 잡음, 혼선, 작동중지 등의 장애를 복구한다.","doWork":"통신망의 사용 중에 발생할 수 있는 각종 장애현상에 관련된 자료를 수집·분석하여 대처방법을 정리한다. 통신서비스 이용 중에 발생하는 정보이송장애, 혼선, 단말기 조작불능 등에 관련된 기술적인 처리방법을 분석한다. 고객의 신고에 따라 장애현상을 듣고 대처방법을 설명한다. 주전산기에 연결된 컴퓨터를 조작하여 고객의 사용회선을 점검한다. 장애처리내용을 기록하여 데이터베이스화하고 통신장애신고가 잦은 고객들을 구분하여 해당 지역의 문제점을 분석하고 점검한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","connectJob":"인터넷장애처리원","certLic":"통신선로산업기사, 통신선로기능사, 통신기기기능사","dJobECd":"1360","dJobECdNm":"[1360]통신·방송송출 장비 기사","dJobJCd":"2250","dJobJCdNm":"[2250]통신 및 방송 송출 장비 기사","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006048:1', '{"dJobCd":"K000006048","dJobCdSeq":"1","dJobNm":"통신품질관리사무원","workSum":"통신상품의 전반적인 품질을 측정하여 관리한다.","doWork":"통화품질관리의 운영계획을 수립한다. 무선통신, 위성통신, 인터넷통신, 부가서비스, 정비(A/S)등에 대한 임시조사(Quick Survey)를 설계하고 조사·분석한다. 고객의 통화품질의 요구(Needs)를 조사한다. 영업상담품질을 측정한다. 지점 및 대리점의 신속, 정확, 친절에 관한 사항을 스펙(Spec)으로 하는 조사리스트를 작성하고 출구·전화·면접조사를 한다. 통화품질을 조사한다. 이엠디엠(EMDM)기기를 이용하여 수도권, 대도시, 고속도로 등을 이동하며 통화의 품질(전파의 세기)을 모니터링한다. 고객센터 상담품질을 측정한다. 고객센터로 걸려오는 전화응대 시의 시간, 해결도를 측정한다. 부가서비스, 빌딩 내 서비스, 지하철 등 차별화할 수 있는 부분의 품질을 측정한다. 고정망, 무선망, 신호망, 지능망의 트래픽을 분석하고 트래픽예측 시뮬레이션모델을 개발하여 장단기예측을 한다. 망요소(Network Element)별 성능을 분석한다. 전국망 서비스중단율을 분석하고 망요소별 장애원인을 분석하여 가용도를 향상시킨다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"통신품질관리원","connectJob":"무선통신품질관리사무원, 통화품질관리원, 통화품질관리사무원","certLic":"무선설비기사, 전파통신기사, 전파통신산업기사, 전파통신기능사","dJobECd":"1360","dJobECdNm":"[1360]통신·방송송출 장비 기사","dJobJCd":"2250","dJobJCdNm":"[2250]통신 및 방송 송출 장비 기사","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005060:1', '{"dJobCd":"K000005060","dJobCdSeq":"1","dJobNm":"항공무선통신사","workSum":"무선통신장비를 사용하여 관제소와 항공기 또는 기타 지방관제소 간에 각종 운항정보를 송·수신한다.","doWork":"각종 무선통신장비를 사용하여 기상, 항로 등의 자료를 운항 중인 항공기에 송신한다. 운항 중인 항공기로부터 위치, 고도, 운항상태, 기상상태, 연료의 잔유량 등과 같은 사항을 수신하여 해당 항공사나 관련기관에 전달한다. 항공사, 항공행정기관, 항공관계기관 등으로부터 항공기의 운항계획서, 항공기상자료, 항공고시보(기상 및 항로에 관련된 자료), 출발 및 도착시간, 항공행정업무 등 각종 사항을 수신하여 자료를 요구하는 업체 또는 개인에게 제공한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"무선설비기사, 무선설비산업기사, 무선설비기능사, 정보통신기사, 정보통신산업기사, 정보통신기능사, 전파통신기사, 전파통신산업기사, 전파통신기능사","dJobECd":"1360","dJobECdNm":"[1360]통신·방송송출 장비 기사","dJobJCd":"2250","dJobJCdNm":"[2250]통신 및 방송 송출 장비 기사","dJobICd":"H511/H512","dJobICdNm":"[H511]항공 여객 운송업 / [H512]항공 화물 운송업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005536:1', '{"dJobCd":"K000005536","dJobCdSeq":"1","dJobNm":"항행안전무선시설운영관리원","workSum":"항공기 안전운항을 지원하기 위해 운항에 이용되는 항법시설, 감시시설 등 항행안전무선시설의 성능을 확보하고 국내외 기술기준에 부합하는 항행안전 관련 정보를 제공한다.","doWork":"국내외 법, 시설의 운영절차, 시설의 동작원리 등을 파악하여 항공기 운항에 이용되는 항법시설, 감시시설 등 항행안전무선시설(계기착륙시설, 전방향표지시설, 전술항해표지시설, 무지향표지시설, 공항감시레이더시설, 항로감시레이더시설, 지상감시레이더시설, 정밀진입감시레이더시설, 자동종속감시방송시설, 다변측정감시시설, 지상기반정보정보시설, 위성기반정보시설 등)을 모니터링하는 등 운영한다. 항행안전시설을 정기적으로 점검하고 정비하는 등 관리한다. 정기적으로 검사를 수검하고 필요시 절차를 수정한다. 항행안전과 관련된 정보를 수집하여 항공기 등에 정보를 제공한다. 운영결과를 보고서로 작성한다. 항공통신, 항공항법, 항공감시, 항공교통관리 분야의 국내외 기술 동향 정보를 수집·파악·분석하여 보고서를 작성한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"무선설비기사, 무선설비산업기사, 무선설비기능사, 정보통신기사, 정보통신산업기사, 정보통신기능사, 전파통신기사, 전파통신산업기사, 전파통신기능사","dJobECd":"1360","dJobECdNm":"[1360]통신·방송송출 장비 기사","dJobJCd":"2250","dJobJCdNm":"[2250]통신 및 방송 송출 장비 기사","dJobICd":"H511/H512","dJobICdNm":"[H511]항공 여객 운송업 / [H512]항공 화물 운송업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002486:1', '{"dJobCd":"K000002486","dJobCdSeq":"1","dJobNm":"건축사","workSum":"건축물의 설계 및 공사 감리(監理)업무를 수행한다.","doWork":"건축물, 건축설비, 공작물 및 공간환경을 조사하고 건축계획을 수립한다. 도면, 구조계획서, 공사설계설명서 등 공사에 필요한 서류를 작성한다. 설계도서에서 의도한 바를 해설하고 조언한다. 건축물, 건축설비 또는 공작물이 설계도서의 내용대로 시공되는지 확인하고 품질관리, 공사관리 및 안전관리 등에 대하여 지도·감독(감리)한다. 건축물의 조사 또는 감정업무, 건축물의 유지관리 및 건설사업관리업무, 특별건축구역의 건축물에 대한 모니터링 및 보고서 작성업무를 수행하기도 한다. 건축주가 건축물의 건축 등을 하려는 경우 인가ㆍ허가ㆍ승인ㆍ신청 등 의 업무를 대행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내·외","physicalAct":"손사용|언어력|시각|","workFunc1":"종합","workFunc2":"협의","workFunc3":"관련없음","connectJob":"건축가, 건축설계기술자, 건축도면설계기술자","certLic":"건축사","dJobECd":"1401","dJobECdNm":"[1401]건축가","dJobJCd":"2311","dJobJCdNm":"[2311]건축가","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005783:1', '{"dJobCd":"K000005783","dJobCdSeq":"1","dJobNm":"건축설계사","workSum":"각종 건축물을 계획하고 설계한다.","doWork":"사업계획을 위한 계획서 및 계획도면을 작성하여 건축주에게 설명하고 건축주의 요구사항을 반영하여 설계계약을 체결한다. 설계업무를 수행하는 데 필요한 인원 및 기간을 산정한다. 계획할 대지와 주변의 환경을 조사하고 분석한다. 건축설계에 필요한 자료와 정보를 수집한다. 대지와 건물에 대한 수집정보를 분류하고 분석한다. 건축주의 건축목표와 프로젝트에 대한 요구조건을 평가·분석하며 우선순위를 협의한다. 설계목표와 계획의 원칙(설계조건)을 수립한다. 계획의 기초가 되는 개념을 설정한다. 설계개념에 따라 소요공간을 산정하고 설계의도를 구체화한다. 수행프로젝트에 관련된 다양한 법규와 기준, 지방자치단체의 조례, 기타 법규를 조사한다. 세부법규, 사업성, 개략공사비, 공사비내역, 자재, 시공성 등을 검토한다. 공간, 조형, 동선, 배치 및 평입단면을 계획한다. 설계도면과 설계설명서, 기본보고서, 시방서 등을 작성한다. 시공 중 공사도급계약서를 검토하고 제안 및 조언한다. 설계변경의 필요성을 판단하고 구체적인 내용을 검토 및 결정한다. 시공자가 작성한 제작, 설치 및 공사관련 도면의 적합성을 검토하고 승인한다. 시공에 있어서 품질, 안전, 공사진척 등을 감독하고 관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","similarNm":"건축가, 건축사, 건축설계기술자, 건축도면설계기술자","certLic":"건축사","dJobECd":"1401","dJobECdNm":"[1401]건축가","dJobJCd":"2311","dJobJCdNm":"[2311]건축가","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001712:1', '{"dJobCd":"K000001712","dJobCdSeq":"1","dJobNm":"문화재실측설계기술자","workSum":"국가유산 또는 전통건축, 등록국가유산을 보존하기 위해 실측조사, 간략한 지표조사, 간략한 고증을 하고 보수공사 설계업무를 담당한다.","doWork":"국가기관(자방자치단체포함) 등에서 관리하는 전통건축물과 같은 유형문화유산을 보수·복원하기 위하여 현장을 답사하여 측량 등을 통해 실측조사하고, 사진촬영 등을 통해 자료수집을 한다. 수집된 자료를 토대로 보수·복원·정비보고서, 시공 중 해체실측조사보고서를 작성한다. 공사용 설계도면 및 시방서, 내역서 등의 설계도서를 작성한다. 공사가 진행되면 시공 중 발생하는 문제점들을 해결하고 공사에 대한 조언을 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","connectJob":"한옥건축설계사","certLic":"건축사, 문화재수리기능자(실측설계, 실측설계사보)","dJobECd":"1401","dJobECdNm":"[1401]건축가","dJobJCd":"2311","dJobJCdNm":"[2311]건축가","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005374:1', '{"dJobCd":"K000005374","dJobCdSeq":"1","dJobNm":"건설구조기술자","workSum":"교량, 댐 등의 토목분야와 주택 및 상업용 빌딩 등 건축분야의 구조물에 발생하는 구조적 현상이나 구조물의 거동을 예측하고 실험하여 안전성 및 실용성을 확보할 수 있도록 이론과 실제를 연구한다.","doWork":"건축·토목의 구조공법의 개발을 위한 실험을 한다. 구조물의 부재실험을 통하여 구조의 안전성을 실험하고 문제에 대한 대처방안을 제시한다. 공법에 대한 시공실험을 통하여 실용성을 검증한다. 각 공법의 경제적인 측면, 환경적인 측면 등 타당성을 분석·검토한다. 기타 연구원(일반)들이 수행하는 일반적인 활동을 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"종합","workFunc2":"협의","workFunc3":"관련없음","similarNm":"구조연구기술자, 건설기술엔지니어, 건설구조연구원","connectJob":"건축구조연구원, 토목구조연구원","certLic":"건축구조기술사, 토목구조기술사","dJobECd":"1402","dJobECdNm":"[1402]건축공학 기술자","dJobJCd":"2312","dJobJCdNm":"[2312]건축공학 기술자","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007090:1', '{"dJobCd":"K000007090","dJobCdSeq":"1","dJobNm":"건설사업관리사","workSum":"건설공사 발주자의 입장에서 건설공사의 기본구상 및 타당성 조사·관리, 계약관리, 설계관리, 사업비관리, 공정관리, 품질관리, 안전관리, 환경관리, 준공 후 사후관리 등을 수행하여 건설공사를 원활히 진행·관리한다.","doWork":"건설공사 발주자와의 계약을 체결하고 과업착수준비, 건설사업관리 업무수행계획서 및 절차서 작성 및 운영, 작업분류체계 및 사업번호체계 관리, 사업정보관리시스템 운영, 클레임 사전분석 등을 수행한다. 설계 전 단계에서 건설기술용역업체 선정, 사업타당성조사보고서 및 기본계획보고서의 적정성 검토, 발주방식 결정지원, 총사업비 집행계획수립지원 등을 수행한다. 설계단계에서 설계 전 선정업무지원, 설계조정 및 연계성 검토, 설계의 경제성(VE)검토, 각종 인허가 및 관계기관협의지원, 시공사 선정계획수립 등을 수행한다. 구매조달단계에서 입찰 및 계약업무지원, 지급자재조달지원을 수행한다. 시공단계에서 시공성과확인, 사용자재의 적정성 검토, 시공계획 검토, 기술검토 및 교육, 공정관리, 안전관리, 환경관리, 설계변경관리, 기성검사, 준공검사, 하도급타당성검토 등을 수행한다. 시공후 단계에서 종합시운전계획의 검토 및 시운전 확인, 시설물유지관리지침서 검토, 시설물유지관리업체 선정, 시설물의 인수인계계획 검토 및 관련 업무를 지원한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"협의","workFunc3":"정밀작업","similarNm":"Construction Manager, CM, 건설사업관리기술인","dJobECd":"1402","dJobECdNm":"[1402]건축공학 기술자","dJobJCd":"2312","dJobJCdNm":"[2312]건축공학 기술자","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002669:1', '{"dJobCd":"K000002669","dJobCdSeq":"1","dJobNm":"건설코디네이터","workSum":"건설회사의 상품개발팀에 소속되어 건설프로젝트의 선정부터 입주에 이르는 모든 과정이 원활히 이루어지도록 참여한 전문가들의 의견을 조율하고 조언하며 프로젝트를 관리하는 일을 한다.","doWork":"건설사에서 프로젝트를 수주할 때 법적·기술적·상품기획적 측면에서 전반적 사업성을 검토한다. 적절한 공사도급가 및 분양가를 산출할 수 있도록 관련 부서에 정보를 제공한다. 프로젝트를 수주하면 주택시장분석을 통한 상품방향 설정의 적정성, 각종 인허가절차 및 기간의 적정성, 디자인의 시공 반영 등 다방면의 정보를 사업부서와 경영자에게 제공한다. 분양 시에는 홍보를 비롯한 여러 업무가 원활히 진행되도록 관련 부서를 조율한다. 분양이 마무리되면 주기적으로 현장을 방문하거나 설계회의에 참석하여 설계수정에 관여하기도 한다. 필요한 건설기자재에 대한 정보를 본사에 전달하는 등 현장과 본사 간의 연결고리 역할을 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"1402","dJobECdNm":"[1402]건축공학 기술자","dJobJCd":"2312","dJobJCdNm":"[2312]건축공학 기술자","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006038:1', '{"dJobCd":"K000006038","dJobCdSeq":"1","dJobNm":"건축감리원","workSum":"건축물의 시공 시 품질관리, 예산관리, 공정관리의 목표를 달성하기 위해 시공의 전반적인 과정을 확인·감독한다.","doWork":"감리방법, 감리방향 등을 수립한다. 설계도서와 시방서(도면으로 나타낼 수 없는 사항을 적은 규정문서)에 의거하여 시공이 이루어지는지 점검한다. 지정된 재료의 사용이나 요구품질 확보 여부를 확인하기 위하여 시험에 입회하며 측량된 결과를 확인한다. 문제점에 대하여 발주자에게 보고하고 시공자에게 시정을 요청한다. 공사진행 과정별 행정업무로 기초검사, 중간검사, 각종 감리보고서를 작성한다. 품질관리, 공사관리, 안전관리 등에 대해 교육 및 기술지도를 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"감독","workFunc3":"수동조작","similarNm":"감리원, 감리자, 건축감리기술자","connectJob":"컨스트럭션매니저(CM)","certLic":"건축구조기술사, 건축기계설비기술사, 건축시공기술사, 건축품질시험기술사, 건축사, 건축기사","dJobECd":"1402","dJobECdNm":"[1402]건축공학 기술자","dJobJCd":"2312","dJobJCdNm":"[2312]건축공학 기술자","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004367:1', '{"dJobCd":"K000004367","dJobCdSeq":"1","dJobNm":"건축견적원","workSum":"건축공사의 발주 또는 수주 등의 목적으로 공사비를 산출하는 업무를 수행한다.","doWork":"공사발주처로부터 시방서, 도면 및 단가설명서 등의 입찰도서를 접수하여 그 내역을 검토한다. 정보를 수집하여 공사입찰방법, 경쟁업체 등을 파악한다. 전산기준에 맞게 정확한 수량을 산출하고 이상 유무를 확인·수정한다. 각종 견적서를 취합하고, 공사의 입찰결과분석자료를 활용하여 입찰금액을 파악한다. 공사규모에 따른 적정한 인원구성을 산출하고 견적에 적용하여 전체적인 공사비를 산출한다. 입찰내역서, 협력업체 등 입찰 관련 서류를 작성한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"견적원, 적산원, 건축적산원","dJobECd":"1402","dJobECdNm":"[1402]건축공학 기술자","dJobJCd":"2312","dJobJCdNm":"[2312]건축공학 기술자","dJobICd":"F411/F412/F421","dJobICdNm":"[F411]건물 건설업 / [F412]토목 건설업 / [F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001673:1', '{"dJobCd":"K000001673","dJobCdSeq":"1","dJobNm":"건축공무기술자","workSum":"건축공사 기획 및 계약, 공사현장의 운영, 설계변경, 기성관리, 견적업무, 공사비 및 공사자원관리, 준공 후 사후관리 등 건축공사 수행을 위한 기술적, 관리적 업무를 한다.","doWork":"착공단계에서 사무실을 개설하고 공동도급회사 간 계약이해에 관련되는 상호약정사항을 협의하고 확정하며 착공 시 필요한 인허가신고업무 등 현장착공관리를 한다. 설계도서 간의 상호모순된 항목을 정정하고 현장여건과 상이한 항목을 수정보완하는 등 설계적정성 검토를 한다. 공사에 실제 투입되는 예정원가를 산출하고 도급변경에 따라 변경투입예정원가를 산출하며 관리한다. 실정보고를 통한 설계변경 시 수량 및 단가산출서, 내역서 등을 작성하고 계약금액조정 시 변경금액을 산출하는 등 계약을 관리한다. 효율적인 인력, 자재 및 장비관리와 적재적소에 자원이 전·출입될 수 있도록 현장자원을 관리한다. 하도급업체에 위탁할 때 필요한 입찰, 계약, 기성집행 등을 관리한다. 공정 및 원가에 대한 자료를 분석·작성하여 사업단위별 손익상태를 관리한다. 사업종료에 따른 정산, 완료보고, 사후관리 등 현장준공을 관리한다. 공사진행과 관련한 이해당사자, 발주처 및 사용자 등의 민원처리 및 예방 등 고객관리를 한다. 하자발생에 대한 기술적, 행정적 관리를 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"시각|","workEnv":"소음·진동|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"건설공무기술자","dJobECd":"1402","dJobECdNm":"[1402]건축공학 기술자","dJobJCd":"2312","dJobJCdNm":"[2312]건축공학 기술자","dJobICd":"F411/F412/F421","dJobICdNm":"[F411]건물 건설업 / [F412]토목 건설업 / [F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003658:1', '{"dJobCd":"K000003658","dJobCdSeq":"1","dJobNm":"건축구조설계기술자","workSum":"건축물의 공간 및 형태를 안전하고 경제적이며 시공가능한 방법으로 구축할 수 있는 기초 및 구조시스템, 주요 부재의 위치 및 크기를 설계한다.","doWork":"지질조사 내용을 분석하고 건물의 특성과 하중조건, 안정성, 시공성, 경제성을 검토한다. 건물용도와 공간형태에 적합한 경제적이고 안전하며 공간 이용효율성이 높은 구조시스템을 선정한다. 건물의 형태적 특성과 용도에 따라 구조계산을 한다. 요구조건을 충족하는 구조모듈(Module:시공 시 기준으로 삼는 치수)을 선택한다. 부재의 위치 및 크기를 건축기본계획에 상응하도록 협의하고 조정한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"시각|","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","similarNm":"건축구조기술자, 건축구조공학기술자","connectJob":"철골설계기술자","certLic":"건축구조기술사","dJobECd":"1402","dJobECdNm":"[1402]건축공학 기술자","dJobJCd":"2312","dJobJCdNm":"[2312]건축공학 기술자","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007097:1', '{"dJobCd":"K000007097","dJobCdSeq":"1","dJobNm":"건축시공기술자","workSum":"건축물 공사를 전체적으로 관리하고 감독하여 공사를 진행하며 시공에 필요한 기술적 지원을 한다.","doWork":"건축물 공사현장에 상주하며 공사기간, 시공방법, 건설기능공 및 인부의 투입규모, 건설기계 및 건설자재 투입량 등을 관리하고 감독한다. 공사가 설계에 따라 진행되고 있는지 감독한다. 현장을 관리하고 돌발상황에 대처한다. 건축기술공 및 인부들에게 기술적인 지원을 한다. 견적, 발주, 설계변경, 원가관리 등 현장 행정업무를 처리한다. 현장의 규모에 따라 안전사고 예방, 시공품질관리, 공정관리, 환경관리업무를 직접 수행하거나 관련 담당자에게 지시한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실외","workEnv":"소음·진동|","workFunc1":"수집","workFunc2":"감독","workFunc3":"관련없음","similarNm":"건축공정관리기사, 건축시공기사","certLic":"건축기사, 건축산업기사, 건축일반시공산업기사","dJobECd":"1402","dJobECdNm":"[1402]건축공학 기술자","dJobJCd":"2312","dJobJCdNm":"[2312]건축공학 기술자","dJobICd":"F411","dJobICdNm":"[F411]건물 건설업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005055:1', '{"dJobCd":"K000005055","dJobCdSeq":"1","dJobNm":"건축시공연구원","workSum":"건축공사의 시공관리기법·시공법·공정 및 품질관리 등에 관한 과학적 방법과 시공기준 및 규격을 연구·개발한다.","doWork":"시공에 관련된 각종 국내외 자료를 수집하여 비교·분석한다. 주거용 주택·상업용 건물·공공건물 등 각종 건축물의 기준과 규격, 설계에 대한 기법 및 시공법, 공업화 건설생산시스템, 건축물 방재계획 등 주거환경, 건설환경의 쾌적화 추구에 관한 연구업무를 수행한다. 기타 연구원(일반)들이 수행하는 일반적인 활동을 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"종합","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"1402","dJobECdNm":"[1402]건축공학 기술자","dJobJCd":"2312","dJobJCdNm":"[2312]건축공학 기술자","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;