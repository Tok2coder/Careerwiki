INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001910:1', '{"dJobCd":"K000001910","dJobCdSeq":"1","dJobNm":"IT프로젝트매니저","workSum":"IT 프로젝트 목표를 성공적으로 달성하기 위하여 프로젝트를 기획하고 인적자원관리, 일정관리, 원가관리, 리스크관리, 품질관리 등의 프로젝트 이행을 관리·감독·통제한다.","doWork":"신규 프로젝트를 착수하기 위하여 프로젝트 환경분석, 타당성조사 및 비즈니스케이스 개발을 수행하고 프로젝트 성공에 필요한 기준을 수립한다. 다양한 프로젝트관리활동들을 식별, 정의, 통합 및 조정하여 이해관계자의 요구사항과 기대치를 파악하고 관리한다. 이해관계자를 식별하고, 효율적인 참여유도를 위한 관리전략을 개발한다. 요구와 기대사항을 이해하기 위해 지속적으로 의사소통을 유지하여 발생된 이슈를 처리하고 이해관계자를 효율적으로 관리한다. 프로젝트에 포함할 사항과 제외할 작업을 정의하고 통제한다. 프로젝트 수행을 위해 필요한 인적자원을 효과적이고 효율적인 프로세스를 통해 통제하고 관리한다. 단위활동들의 순서를 정하고 각 활동의 수행에 필요한 자원을 할당한다. 소요시간을 산출하여 프로젝트 전체일정을 수립하고 이를 주기적으로 평가, 조정 및 관리한다. 승인된 예산범위에서 프로젝트를 완료할 수 있도록 원가산정, 예산수립, 필요자금 조성 및 집행을 통해 진도상황을 모니터링하고 원가를 통제한다. 프로젝트 목표에 영향을 미칠 수 있는 리스크를 식별·평가·대응하고 통제한다. 프로젝트의 요구사항을 충족하기 위한 품질정책, 품질목표, 품질책임사항을 결정하고, 이를 준수할 수 있는 품질보증 및 통제를 계획하고 확립하는 데 요구되는 프로세스를 관리하고 수행한다. 프로젝트 수행조직이 품질윤리를 실천할 수 있도록 지휘하고 통제한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"프로젝트관리자, PM(Project Manager)","connectJob":"IT프로젝트관리자","dJobECd":"1320","dJobECdNm":"[1320]컴퓨터시스템 전문가","dJobJCd":"2221","dJobJCdNm":"[2221]컴퓨터 시스템 전문가","dJobICd":"C264/J582","dJobICdNm":"[C264]통신 및 방송 장비 제조업 / [J582]소프트웨어 개발 및 공급업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007410:1', '{"dJobCd":"K000007410","dJobCdSeq":"1","dJobNm":"데브옵스관리자","workSum":"데브옵스 팀(데브옵스 엔지니어가 활동)을 운영, 관리하고 관련 부서와 업무 조율 등을 수행한다.","doWork":"데브옵스 팀을 관리한다. 소프트웨어 개발 운영의 로드맵 및 비전을 수립하고 계획한다. Source Control, CI/CD, Code Review 등을 포괄하는 소프트웨어 개발 도구에 대한 정책을 수립한다. 일관성 있는 적용을 위해 운영 절차와 실무를 정의하고 문서화한다. 새로운 서비스를 제공 할 수 있도록 팀 내에서 변경 사항을 정리하여 의사결정 한다. 고객 응대계획을 수립하고 필요 시 대응한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"제어조작","similarNm":"데브옵스PM","connectJob":"데브옵스엔지니어","dJobECd":"1320","dJobECdNm":"[1320]컴퓨터시스템 전문가","dJobJCd":"2221","dJobJCdNm":"[2221]컴퓨터 시스템 전문가","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007411:1', '{"dJobCd":"K000007411","dJobCdSeq":"1","dJobNm":"데브옵스엔지니어","workSum":"서비스 및 시스템의 제공과 유지에 필요한 시스템을 설계·구축·운용하며, 서비스 효율성을 위한 자동화 시스템의 개발·운영 및 다양한 빌드/배포 환경에서 발생하는 IT 이슈에 대응한다.","doWork":"서비스 및 시스템을 기술적으로 지원한다. 서비스 성능 개선을 위한 인프라/애플리케이션을 모니터링하고 문제를 해결한다. 확장가능하고 유연한 CI/CD 서비스 인프라를 구성하고 이를 자동화하여 효율성과 안정성을 높인다. 다양한 써드파티 서비스 및 제품을 활용하여 최적화를 진행한다. 개발 제품의 소프트웨어 개발 라이프사이클(SDLC) 전 과정에 필요한 DevOps Tools를 관리한다. 이를 위해 다양한 기술을 효율적으로 결합해 최적의 개발/운영 환경을 만들고 개선한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"제어조작","similarNm":"DevOps엔지니어","connectJob":"데브옵스관리자","dJobECd":"1320","dJobECdNm":"[1320]컴퓨터시스템 전문가","dJobJCd":"2221","dJobJCdNm":"[2221]컴퓨터 시스템 전문가","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001302:1', '{"dJobCd":"K000001302","dJobCdSeq":"1","dJobNm":"스마트물류플랫폼설계자","workSum":"지능형물류서비스를 제공하기 위해 정보기술솔루션에 IoT와 인공지능(AI) 등 신기술을 융합하여 플랫폼을 설계하고 구축한다.","doWork":"스마트물류 플랫폼을 구성하는 하드웨어와 소프트웨어의 기능과 성능이 사용자의 요구사항에 부합하는가를 통합적으로 검증하고, 소프트웨어를 개발하고 테스트한다. 스마트물류 네트워크 구축, 플랫폼 IoT장비 구축, 스마트물류 소프트웨어, 스마트물류 데이터베이스구축을 위해 데이터를 측정, 수집, 저장, 가공, 분석 가능한 환경을 구축한다. 내외부환경·자원 검토를 바탕으로 플랫폼, IoT장비 도입환경분석, IoT장비 설치, 스마트물류 시스템과 연동하고 테스트한다. 스마트물류 처리 활동에 사용되는 설비를 위한 설계, 설치, 테스트 및 구축을 실행하기 위한 현장 실사, 기술규격, 설계서를 작성한다. 플랫폼서비스에 필요한 자원을 활용하여 최적화 알고리즘으로 스마트물류 서비스를 설계한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"협의","workFunc3":"정밀작업","certLic":"정보처리기능사, 정보통신산업기사, 정보보안산업기사","dJobECd":"1320","dJobECdNm":"[1320]컴퓨터시스템 전문가","dJobJCd":"2221","dJobJCdNm":"[2221]컴퓨터 시스템 전문가","dJobICd":"C264/J582","dJobICdNm":"[C264]통신 및 방송 장비 제조업 / [J582]소프트웨어 개발 및 공급업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005525:1', '{"dJobCd":"K000005525","dJobCdSeq":"1","dJobNm":"에이치씨아이컨설턴트","workSum":"인간과 컴퓨터의 상호작용을 토대로 사용자친화적이고 접근성이 확보된(HCI:Human Computer Interaction) 컴퓨터시스템 및 웹사이트 등을 개발하고 컨설팅한다.","doWork":"사용자친화적인 웹사이트와 컴퓨터부품 등을 개발하기 위해 문제점을 분석한다. 고객을 대상으로 사용자친화성을 평가하기 위해 심층인터뷰를 한다. 고객에게 개선된 사이트를 사용하게 하는 사용성테스트를 실시한다. 사이트를 사용한 다음 태도 및 상황적 인지 등을 평가한다. 인간과 컴퓨터의 상호작용이 원활한 사이트가 되게 하는 방안을 제시한다. 관련된 문헌조사를 실시한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"HCI(Human Computer Interaction)컨설턴트, 유저익스피리언스(UX:User Experience)컨설턴트, 유저인터페이스(UI:User Interface)컨설턴트","certLic":"서비스경험디자인기사","dJobECd":"1320","dJobECdNm":"[1320]컴퓨터시스템 전문가","dJobJCd":"2221","dJobJCdNm":"[2221]컴퓨터 시스템 전문가","dJobICd":"M715","dJobICdNm":"[M715]회사 본부 및 경영 컨설팅 서비스업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002332:1', '{"dJobCd":"K000002332","dJobCdSeq":"1","dJobNm":"유비쿼터스도시기술자","workSum":"유비쿼터스도시를 구현하기 위한 소프트웨어 및 하드웨어장비를 개발하고, 유비쿼터스도시 구축에 필요한 시스템을 구축하고 관련 설비를 시공하는 일을 관리·감독한다.","doWork":"유비쿼터스도시(U-City:Ubiquitous City, 시간과 장소에 구애받지 않고 언제 어디서나 인터넷 접속이 가능한 유비쿼터스 기술을 기반으로 하는 미래형 첨단도시)가 제공하는 서비스를 구축하기 위해 소프트웨어를 개발하거나 센서나 디지털단말기 등의 지능화설비를 개발·설계한다. 관련 시스템과 설비를 구축하고 시공하는 일을 관리·감독한다. 도시통합정보센터의 건축물을 설계 또는 시공관리하거나 센터에 설치될 정보통신 플랫폼을 설계하기도 한다. 도시통합정보센터와 유관기관, 정보수집센서 및 디지털단말기 사이의 정보통신네트워크를 위한 통신인프라를 설계하고 구축하는 일을 전문으로 하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"U-City기술자","dJobECd":"1320","dJobECdNm":"[1320]컴퓨터시스템 전문가","dJobJCd":"2221","dJobJCdNm":"[2221]컴퓨터 시스템 전문가","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006463:1', '{"dJobCd":"K000006463","dJobCdSeq":"1","dJobNm":"전산시스템분석원","workSum":"고객기업이 보유하고 있는 전산시스템 및 관련 자료를 분석·정리하고 전산자료처리가 가능한 프로그램을 개발하기 위한 방법을 연구한다.","doWork":"의뢰기관의 담당자와 협력하여 현재의 시스템의 사양 및 활용도에 대해 조사하여 보고서를 작성한다. 현재 전산시스템의 문제점 및 개선방향에 대하여 조사 및 분석한다. 향후 전산시스템 발전계획의 수립에 필요한 각종 자료를 보고서로 작성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"1320","dJobECdNm":"[1320]컴퓨터시스템 전문가","dJobJCd":"2221","dJobJCdNm":"[2221]컴퓨터 시스템 전문가","dJobICd":"J582/J620","dJobICdNm":"[J582]소프트웨어 개발 및 공급업 / [J620]컴퓨터 프로그래밍, 시스템 통합 및 관리업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005225:1', '{"dJobCd":"K000005225","dJobCdSeq":"1","dJobNm":"정보기술컨설턴트","workSum":"정보기술 관련 산업의 인적, 물적자원에 대한 효율적 배치와 운영에 대하여 조사·분석한다.","doWork":"제안서 작성 또는 자원(물적, 인적 자원) 등과 같은 영업지원활동을 수행한다. 수립된 계획에 따라 해당 영역에서 정해진 일정에 기초해서 프로젝트를 수행한다. 컨설팅방법론을 적용하여 계약에 관련된 자료수집, 분석, 문제확인 및 해결안 도출작업을 수행한다. 규모가 작은 프로젝트는 주도적으로 수행하고 문서화작업을 수행한다. 계약결과물 전달을 위한 프레젠테이션 자료개발을 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"1320","dJobECdNm":"[1320]컴퓨터시스템 전문가","dJobJCd":"2221","dJobJCdNm":"[2221]컴퓨터 시스템 전문가","dJobICd":"J582/J620","dJobICdNm":"[J582]소프트웨어 개발 및 공급업 / [J620]컴퓨터 프로그래밍, 시스템 통합 및 관리업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001718:1', '{"dJobCd":"K000001718","dJobCdSeq":"1","dJobNm":"정보보안감리기술자","workSum":"정보보안과 관련된 시스템 등의 적절성을 평가하고 조치한다.","doWork":"정보보호 관련 법 및 규정에 따라 보안검토기준을 수립한다. 정보보호 관리체계 내의 정보시스템 및 설비 등을 관리적, 기술적, 물리적 보안 요구사항에 따라 평가한다. 보안위협이 발견되었을 경우 보안위협을 제거하거나 보안대책에 필요한 요구사항을 도출한다. 도출된 보안대책 요구사항에 따라 보안대책서를 작성하여 보고한다. 정보보안에 위협이 될 수 있는 발생가능사건 등을 평가하고 정보보호정책, 표준, 지침, 절차에 따라 위험분석평가 등을 문서화한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","certLic":"정보시스템감리사","dJobECd":"1320","dJobECdNm":"[1320]컴퓨터시스템 전문가","dJobJCd":"2221","dJobJCdNm":"[2221]컴퓨터 시스템 전문가","dJobICd":"J602","dJobICdNm":"[J602]텔레비전 방송업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004565:1', '{"dJobCd":"K000004565","dJobCdSeq":"1","dJobNm":"정보보호컨설턴트","workSum":"조직의 정보보호의 수준과 취약점 및 핵심자원을 분석하고, 고객의 요구수준에 입각하여 최적의 해결책을 제안한다.","doWork":"컨설팅 대상 조직의 정보보호정책을 검토한다. 조직의 정보보호표준 및 절차, 모니터링과정을 평가한다. 각 조직원의 정보보호 관련 책임과 역할을 규명한다. 현재 조직의 네트워킹에 있어서 위험하고 취약한 부분을 파악한다. 도출된 문제를 해결한 수 있는 정보보호솔루션을 도입한다. 조직의 핵심정보를 보호할 수 있도록 조직 전체의 보안아키텍처를 설계한다. 컨설팅 대상 조직의 요구를 만족시키고, 사업목적과 절차에 부합하는 해결책을 수립하기 위해 대상 조직의 전산 관련 부서와 업무협조한다. 조직의 정보보호환경을 정기적으로 개정하도록 경영진에 권고한다. 정보보호동향 및 제품에 대하여 컨설팅 대상 조직의 운영자 및 관리자를 교육시킨다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"컴퓨터보안전문가, 정보보안컨설턴트, 보안컨설턴트, 컴퓨터시스템보안컨설턴트","connectJob":"정보보호프로그래머, 보안프로그램개발원","certLic":"정보관리기술사, 정보처리기사, 정보시스템감리사","dJobECd":"1320","dJobECdNm":"[1320]컴퓨터시스템 전문가","dJobJCd":"2221","dJobJCdNm":"[2221]컴퓨터 시스템 전문가","dJobICd":"J582/J620","dJobICdNm":"[J582]소프트웨어 개발 및 공급업 / [J620]컴퓨터 프로그래밍, 시스템 통합 및 관리업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002101:1', '{"dJobCd":"K000002101","dJobCdSeq":"1","dJobNm":"정보시스템감리원","workSum":"감리발주자 및 피감리인의 이해관계로부터 독립된 위치에서 정보시스템의 효율성 향상과 안전성 확보를 위하여 정보시스템의 구축 및 운영 등에 관한 사항을 종합적으로 점검하고, 문제점을 개선하도록 조언 및 권고한다.","doWork":"현행 정보기술의 아키텍처(Architecture)를 파악하고, 시스템의 설계원칙과 사양에 준거하여 정보시스템이 구축되었는지를 평가한다. 조직의 정보기술 및 비지니스시스템이 적절히 통제, 점검, 평가되고 있는가를 감리기준과 지침에 따라 평가한다. 정보시스템 부서의 관리, 계획, 조직과 관련된 제반 업무를 평가한다. 조직의 기술, 운영, 관리적 인프라 구축이 비즈니스 목표달성에 부응하는가를 확인하기 위해 효율성을 평가한다. 조직의 정보보호정책 및 업무를 평가함으로써 비인가사용, 노출, 수정, 손실 또는 파손으로부터 정보자산을 보호할 수 있는가를 평가한다. 유사시 비즈니스활동과 정보시스템 처리를 지속적으로 수행할 수 있도록 문서보호, 전파방법, 모의훈련 등이 실시되고 있는가를 평가한다. 비즈니스 응용시스템의 개발, 획득, 설치 및 유지보수활동을 위한 조직의 방법론과 절차를 평가함으로써 이들이 조직의 목표에 부응하는가를 확인한다. 시스템소프트웨어 및 유틸리티의 개발, 설치, 그리고 유지보수 등을 평가하여 조직의 정보시스템 처리 및 비즈니스에 요구되는 사항들을 효과적이고도 효율적으로 지원하며 조직의 전략에 지속적으로 부응하는가를 확인한다. 네트워크 인프라의 획득, 설치, 그리고 유지보수 등을 평가하여 이들이 조직의 정보시스템 처리 및 비즈니스에 요구되는 사항들을 효율적으로 지원하며 조직의 전략에 부응하는가를 확인한다. 정보자원의 무결성, 비밀성, 가용성을 확인하기 위해 논리적 접근통제에 대한 설계, 구현을 평가한다. 네트워크 및 전송되는 정보의 무결성, 비밀성, 가용성, 인가된 사용을 확인하기 위해 네트워크 인프라보안을 평가한다. 정보시스템의 운영과 관리가 내부관리지침에 준거하여, 체계적으로 관리되고 있는지를 확인·평가한다. 기업의 회계 관련 업무를 처리하는 데 있어서 정보처리절차와 데이터의 투명성 및 객관성을 검증한다. 조직의 전반적인 정보시스템의 구축, 운영 및 관리를 하는 데 있어서 제반 요소의 평가·분석된 자료를 조직운영진에 피드백하여 미비한 부분에 대해서 보완하도록 제안한다. 최근의 정보기술의 변화를 지속적으로 파악하여 전산 관련 감리 및 평가방법을 연구·개발한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"컴퓨터시스템감리기술자, 컴퓨터시스템감리사, 전산감리사, 정보시스템감리사","connectJob":"정보시스템감사사","certLic":"정보시스템감리사","dJobECd":"1320","dJobECdNm":"[1320]컴퓨터시스템 전문가","dJobJCd":"2221","dJobJCdNm":"[2221]컴퓨터 시스템 전문가","dJobICd":"J582/J620","dJobICdNm":"[J582]소프트웨어 개발 및 공급업 / [J620]컴퓨터 프로그래밍, 시스템 통합 및 관리업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004125:1', '{"dJobCd":"K000004125","dJobCdSeq":"1","dJobNm":"정보처리기술자","workSum":"향후 필요한 작업계획과 책임작업량을 충족하는 성능을 발휘할 수 있도록 전자정보처리시스템을 설계한다.","doWork":"자료처리 담당자 또는 프로젝트관리원과 협의하여 기존 시스템의 한계 및 성능, 그리고 미래에 필요한 시스템의 능력에 관한 자료를 수집한다. 자료를 분석하여 컴퓨터 및 보조장비의 종류를 선정하고 설계계획을 수립한다. 프로젝트 수행을 위해 기존 장비 및 시스템의 수정이 필요하면 정해진 면적에서 효율적으로 가동하도록 설계를 계획한다. 동력공급 조건과 형태에 관하여 기록한다. 시스템 제작을 하기도 한다. 시스템 설치장소의 먼지, 온도, 습도를 조절하기 위한 장비구입을 제안하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","certLic":"정보처리기사","dJobECd":"1320","dJobECdNm":"[1320]컴퓨터시스템 전문가","dJobJCd":"2221","dJobJCdNm":"[2221]컴퓨터 시스템 전문가","dJobICd":"J582/J620","dJobICdNm":"[J582]소프트웨어 개발 및 공급업 / [J620]컴퓨터 프로그래밍, 시스템 통합 및 관리업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007690:1', '{"dJobCd":"K000007690","dJobCdSeq":"1","dJobNm":"지능형교통체계설계자","workSum":"지능형교통체계 기본계획의 목표 및 목적을 반영하여 분야별 ITS 서비스, 서비스 구현 방안 및 추진 방향 등을 설정하고 현장시스템, 센터S/W, 센터H/W, 토목 및 정보통신(통신망 등) 설계 등을 수행한다.","doWork":"선정된 지능형교통체계 서비스의 구현을 위하여 국가 ITS 아키텍처를 기반으로 설계한다. 운영자, 관리자의 요구사항 분석을 통해 S/W 구현에 필요한 기능을 구분하고 기능 구현에 필요한 문서 및 기능 구현 난이도에 따른 예산과 산출물을 설계한다. 지능형교통체계의 센터시스템 및 현장시스템 구축을 위해 선정된 사업구상에 따라 사업의 예산내역을 토대로 규격서를 작성하고, 시스템 구성과 해당 서비스의 상세구현을 위하여 현장시스템 구축에 필요한 물량산출서, 예산내역서, 시방서, 규격서, 도면 등을 설계한다. 교통체계지능화 사업을 체계적으로 수행할 수 있도록 추진체계를 조직하고 효율적인 재원 조달 방안과 운영관리체계를 수립한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"협의","workFunc3":"정밀작업","certLic":"교통기술사, 도시계획기술사, 정보통신기술사, 교통기사, 정보통신기사, 도시계획기사, 정보처리기사, S/W기술자","dJobECd":"1320","dJobECdNm":"[1320]컴퓨터시스템 전문가","dJobJCd":"2221","dJobJCdNm":"[2221]컴퓨터 시스템 전문가","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2025"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001279:1', '{"dJobCd":"K000001279","dJobCdSeq":"1","dJobNm":"커넥티드카소프트웨어개발자","workSum":"자동차와 연결될 수 있는 모든 대상과의 양방향 통신을 통해 안전성, 편의성 향상 및 이동공간에서의 새로운 서비스 창출을 위한 HMI, 보안, 콘텐츠 소프트웨어를 개발한다.","doWork":"커넥티드카의 소프트웨어의 특성을 이해하고 운행환경 파악 및 분석 후 커넥티드카 운행에 필요한 동작 시나리오를 정의하고 기능, 기술에 대한 요구사항을 분석하고 작성한다. 커넥티드카 소프트웨어 요구사항을 바탕으로 커넥티드카 디바이스 개발 소프트웨어의 개발방법론을 결정하고 기능구현에 필요한 소프트웨어 기능 간의 구조를 설계한다. 커넥티드카 소프트웨어 요구사항과 아키텍처를 수용할 수 있는 커넥티드카 전용의 OS(운영체제)를 결정하고 커넥티드카 디바이스의 기능을 구현하기 위해 필요한 하드웨어와 응용소프트웨어를 연결할 수 있는 드라이버, 통신프로토콜과 같은 미들웨어를 설계한다. 커넥티드카가 V2X/텔레매틱스 무선통신을 통해 서비스 관련 데이터를 표준화된 규격으로 전송하기 위한 프로토콜을 설계한다. 커넥티드카 서비스 시나리오를 바탕으로 운전자와 탑승자의 자동차 인터페이스를 위해 HMI 개발환경을 구성하고 인공지능 관련 알고리즘을 응용하거나 차량 주변 사물과 연동하는 다양한 인터렉션을 구현한다. 커넥티드카에서 요구하는 기능을 구현하기 위해 외부통신정보 및 자기차량센서 신호를 받아 신호 처리 및 필요파라미터 예측을 수행하고 판단알고리즘을 구성하며 자가고장 진단이 가능한 애플리케이션에서 요구하는 기능을 구현한다. 커넥티드카 통신 및 시스템의 보안 요구사항을 바탕으로 소프트웨어를 개발하기 위해 보안 위협요소를 분석하고 설계하며, 통신 및 시스템의 보안성을 제공하기 위한 소프트웨어를 개발한다. 커넥티드카에 탑재되는 소프트웨어의 시험 범위를 정의하고 기능에 대한 시험 및 평가를 하여 잠재적 결함을 식별한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"임베디드기사, 정보처리산업기사, 정보처리기사","dJobECd":"1320","dJobECdNm":"[1320]컴퓨터시스템 전문가","dJobJCd":"2221","dJobJCdNm":"[2221]컴퓨터 시스템 전문가","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001599:1', '{"dJobCd":"K000001599","dJobCdSeq":"1","dJobNm":"커넥티드카콘텐츠·서비스개발자","workSum":"커넥티드카의 운전자와 탑승자에게 안전성, 편의성, 오락성과 관련된 서비스와 콘텐츠 제공에 필요한 요구사항을 분석하여 콘텐츠와 서비스를 기획·개발·운영한다.","doWork":"목표하는 커넥티드카 관련 콘텐츠·서비스의 아이디어와 컨셉을 도출하고 시나리오를 구성한다. 커넥티드카 관련 콘텐츠의 요구사항을 분석하여 디자인 가이드라인을 제작하고 UX 개발환경을 구축하여 UI/UX 컨셉과 지침에 따라 GUI 디자인을 개발한다. 개발 콘텐츠의 기술과 서비스 내용 분석을 기반으로 운영 플랫폼을 구축하기 위해 필요한 요소들을 구성한다. 무선통신 기술과 결합한 차량 서비스 제공을 위한 차량 관리 서비스, 차량 원격제어 서비스, 차량 공유 서비스를 운용한다. 커넥티드카 콘텐츠를 개발하기 위한 차량센서 및 다양한 외부정보 등의 처리를 통해 필요한 신호들을 생성한다. 커넥티드카 콘텐츠·서비스 보안 요구사항을 바탕으로 커넥티드카 콘텐츠 제작과 서비스 개발에 필요한 보안요소 기술을 분석·설계하고, 콘텐츠·서비스의 보안성을 제공하기 위한 소프트웨어를 개발한다. 카메라, 마이크, 3D 터치센서와 같은 다양한 차량 내 센서 디바이스로 사용자의 음성과 동작 행위의 의도를 파악하여 입력값을 도출하고, 차량 내외의 정보를 얻어내어 시스템에 전달한다. 커넥티드카에 제공되거나 자체 생성되는 콘텐츠·서비스를 사용자에게 제공하기 위해서 차량의 다양한 디바이스로 콘텐츠·서비스를 표출하는 기술을 개발한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"임베디드기사, 정보처리산업기사, 정보처리기사, 정보통신산업기사, 정보통신기사, 그린전동자동차기사, 자동차정비산업기사, 자동차정비기사, 시각디자인산업기사","dJobECd":"1320","dJobECdNm":"[1320]컴퓨터시스템 전문가","dJobJCd":"2221","dJobJCdNm":"[2221]컴퓨터 시스템 전문가","dJobICd":"J620","dJobICdNm":"[J620]컴퓨터 프로그래밍, 시스템 통합 및 관리업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005339:1', '{"dJobCd":"K000005339","dJobCdSeq":"1","dJobNm":"컴퓨터시스템엔지니어","workSum":"조직의 정보시스템 구축에 있어서 활용가능한 기술적·재정적 사항과 해당 업무과정을 종합적으로 검토하여 최적의 컴퓨터시스템을 설계하고 구축한다.","doWork":"전산화할 업무의 처리절차와 관련 데이터를 검토·분석한다. 분석된 업무의 처리절차와 관련 데이터를 정보시스템으로 이행하기 위한 정보기술의 하드웨어 및 소프트웨어 요소를 검토한다. 기존 시스템의 문제점과 고객의 요구사항을 분석하여, 구축해야 할 정보시스템의 성능, 기능 등에 관한 주요사항을 정의한다. 활용 가능한 정보기술에 대한 검토와 분석을 토대로 정보시스템에 대한 기본설계를 한다. 정보시스템의 기본설계 방향, 성능, 기능, 비용, 일정 등에 관하여 고객의 요구를 반영한다. 정보보호전문가와 협의하여, 구축하고자 하는 정보시스템에서의 보안관리체계와 방안을 설정한다. 기본설계에 입각해서 하드웨어 및 소프트웨어의 조달, 신규로 제작해야 할 소프트웨어의 개발 및 인터페이스의 방안에 대하여 세부적으로 설계한다. 시스템에서 사용해야 할 주요대상의 데이터베이스관리체계, 툴(Tool:개발도구) 등을 결정한다. 정보기술산업동향을 파악하여, 구축하고자 하는 정보시스템에 적합한 하드웨어 및 소프트웨어에 대해서 확정한다. 구축하고자 하는 시스템과 유관부서의 데이터 연관성을 검토하여 시스템의 데이터 통일성을 유지한다. 기업 내의 관련 부서 시스템과의 인터페이스 조건과 사양을 설정한다. 비즈니스 환경변화 및 발전을 감안하여 시스템의 구조를 유연성 있게 설계한다. 정보시스템에서의 위험관리, 재해대책, 자료보호 관리방안을 설정한다. 기존 정보환경이 기업 및 조직에서 필요로 하는 정보 및 기술을 효과적으로 지원할 수 있는지를 분석한다. 응용구조를 바탕으로 메인서버, 지역서버, 클라이언트·서버의 분산정도를 분석한다. 하드웨어 구성요소, 시스템 소프트웨어, 통신 및 네트워크 등에 대한 전반적인 기술 아키텍처(Architecture)의 사양을 설정한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"정밀작업","similarNm":"시스템설계가, 시스템엔지니어(S.E)","connectJob":"시스템분석가(S.A), 시스템통합(SI)전문가","certLic":"정보처리기사, 정보처리산업기사, 정보관리기술사, 컴퓨터시스템응용기술사, 전자계산기조직응용기사","dJobECd":"1320","dJobECdNm":"[1320]컴퓨터시스템 전문가","dJobJCd":"2221","dJobJCdNm":"[2221]컴퓨터 시스템 전문가","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004787:1', '{"dJobCd":"K000004787","dJobCdSeq":"1","dJobNm":"컴퓨터시스템연구원","workSum":"시스템의 수학적 모델을 공식화하고, 과학 및 공학적 문제를 해결하기 위해 아날로그 또는 하이브리드 컴퓨터시스템을 연구·개발한다.","doWork":"문제제안자와 협의하여 자료수집의 방법과 변수가의 결정방법 및 근원을 찾아낸다. 과학지식을 응용하여 문제에 관련된 물리적 모델과 문제에 관련된 도식표현 및 언어적인 표현을 검토·연구한다. 문제의 수학적 모델을 작성하고 문제해결에 요구되는 수학적인 단계를 지시하는 자료공정도를 그린다. 전압과 시간진법을 계산하여 수학적 등식을 얻는다. 구성성분들과 그들의 수치 간의 연결을 나타내는 컴퓨터회로 도면을 그린다. 기기나 장치의 입출력단자를 패치보드(Patch Board)에 결선한다. 플로터(Plotter), 기록장치, 디지털전압계, 오실로스코프, 디지털정보판독기 같은 출력장치에 나타난 변수를 관찰하여 문제를 해결한다. 문제제안자를 위한 문제의 단계적 해결을 묘사하는 기술보고서를 작성한다. 문제해결을 위한 새로운 기술을 개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1320","dJobECdNm":"[1320]컴퓨터시스템 전문가","dJobJCd":"2221","dJobJCdNm":"[2221]컴퓨터 시스템 전문가","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001539:1', '{"dJobCd":"K000001539","dJobCdSeq":"1","dJobNm":"컴퓨터시스템컨설턴트","workSum":"기업의 인적, 물적자원 및 제반조건과 관련된 자료를 수집분석하고 최신 기술적 활용자원(하드웨어, 소프트웨어) 등을 고려하여 해당 기업의 경영환경에 적합한 정보시스템 구축을 제시하고 추천한다.","doWork":"고객사의 사업 비전과 부합되는 최적의 정보시스템을 구축하는 데 요구되는 기술, 운영관리 측면에서 방안을 자문하고 제시한다. 고객의 비즈니스환경과 현재의 정보시스템과의 상관관계를 분석평가하고 비즈니스 프로세스와 모델을 분석하여 새로운 정보기술을 이행할 계획과 방안을 마련한다. 소프트웨어개발자, 컴퓨터프로그래머에게 명세사항에 대해 의사교환을 하고 분야간 변화에 조정 작업을 수행하며 기업운영 관련 방침과 절차의 개선을 제시한다. 각종 시스템의 절차계획을 수립하고 적용을 주도하며 시스템 자원의 성능향상 및 관련 하드웨어와 소프트웨어등 기술을 주도적으로 평가한다. 시스템 관리에 관한 방법 등을 구안하고 개선하며 각종 실행방안의 검증과 업무 분야 간의 통합 및 조정 등 기술적 지도력을 발휘한다. 분야에 따라 데이터베이스컨설턴트(데이터베이스시스템의 분석, 설계, 구축과 튜닝 등에 관련된 기술적 운영관리 측면에서 컨설팅서비를 제공한다), 네트워크컨설턴트(네트워크 시스템 분석, 설계, 구축과 운영관리 측면에서 컨설팅서비스를 제공한다), 웹컨설턴트(웹과 관련된 다양한 기술가 마케팅 기법들에 대한 지식을 활용하여 웹 구축 및 활용에 관한 컨설팅서비스를 제공한다), 응용시스템컨설트(ERP, CRM, RPS 등)의 구축 및 활용에 관한 컨설팅서비스를 제공한다)로서 직무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"자문","workFunc3":"관련없음","similarNm":"IT컨설턴트, 정보통신컨설턴트","connectJob":"네트워크컨설턴트, 데이터베이스컨설턴트, 정보보안컨설턴트, 웹컨설턴트, 응용시스템컨설턴트, 고객관계관리(CRM:Customer Relationship Management)컨설턴트, 전사적자원관리(ERP:Enterprise Resource Planning)컨설턴트, 지식관리시스템(KMS:Knowledge Management System)컨설턴트, RPA(Robotic Process Automation)컨설턴트","dJobECd":"1320","dJobECdNm":"[1320]컴퓨터시스템 전문가","dJobJCd":"2221","dJobJCdNm":"[2221]컴퓨터 시스템 전문가","dJobICd":"J620","dJobICdNm":"[J620]컴퓨터 프로그래밍, 시스템 통합 및 관리업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004684:1', '{"dJobCd":"K000004684","dJobCdSeq":"1","dJobNm":"클라우드시스템엔지니어","workSum":"클라우드 환경에서 인프라를 설계하고, 가상서버, 네트워크, 스토리지 등의 자원을 구성하여 인프라를 구축하고 이에 대한 유지보수 및 관리운영한다.","doWork":"클라우드 인프라스트럭쳐 서비스를 제공하기 위해 서비스의 품질·성능 목표 및 운영 정책과 SLA를 정의한다. 서비스 명세서 및 정책을 기반으로 기능, 비기능 요구사항, 컴플라이언스를 분석하여 요구사항 명세서를 작성하고 아키텍처를 설계한다. 클라우드 인프라스트럭쳐 서비스를 제공하기 위해 서버 가상화 소프트웨어를 결정하고, 물리 및 가상 서버 구조 및 스펙을 설계한다. 클라우드 스토리지 서비스를 제공하기 위한 물리, 가상 스토리지를 설계한다. 클라우드 네트워크 서비스를 제공하기 위한 물리, 가상 네트워크를 설계하고 보안을 적용한다. 클라우드 서버 서비스 설계에 따라 가상 서버 구축에 필요한 소프트웨어를 검토하고, 검토된 소프트웨어를 이용하여 클라우드 서버 서비스를 구현하고 테스트한다. 가상 스토리지 구축에 필요한 소프트웨어를 검토하고, 검토된 소프트웨어를 이용하여 클라우드 스토리지 서비스를 구현하고 테스트한다. 가상 네트워크 구축에 필요한 소프트웨어를 검토하고, 검토된 소프트웨어를 이용하여 클라우드 네트워크 서비스를 구현하고 테스트한다. CI(Continuous Integration)/CD(Continuous Delivery, Deployment) 설계서를 통해서 배포 환경을 구성하고 계획을 수립하여 배포한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"클라우드엔지니어, 클라우드운영엔지니어, 클라우드인프라엔지니어","connectJob":"클라우드보안엔지니어, 클라우드DB엔지니어, 클라우드네트워크엔지니어, 클라우드소프트웨어엔지니어","certLic":"정보처리산업기사, 정보처리기사, 정보관리기술사, 컴퓨터시스템응용기술사","dJobECd":"1320","dJobECdNm":"[1320]컴퓨터시스템 전문가","dJobJCd":"2221","dJobJCdNm":"[2221]컴퓨터 시스템 전문가","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001514:1', '{"dJobCd":"K000001514","dJobCdSeq":"1","dJobNm":"클라우드아키텍트","workSum":"클라우드 서비스 및 기술을 기반으로 비즈니스 요구사항을 분석하고 클라우드 도입구축운영을 위한 전체적인 시스템 아키텍처를 설계하고 솔루션을 제시한다.","doWork":"클라우드요구사항을 수집·분석하여 명세화한다. 클라우드 솔루션의 서버, 스토리지, 네트워크 구조 및 DR(Disaster Recovery)을 설계한다. 클라우드 환경에서 구축된 솔루션의 보안 요구사항을 분석하여 보안 설계 기준을 수립하고 보안 구조를 설계한다. 사용자 요구사항 분석과 클라우드 구조 설계를 참조하여 클라우드 서비스 카탈로그 및 컴포넌트를 선정하며, 내·외부 인터페이스의 설계 기준을 수립한다. 클라우드 서비스 비용을 최적화하기 위하여 클라우드 솔루션의 비용을 계획하고 비용 추적 방안 및 도구를 설계한다. 사용자의 정보시스템을 클라우드 서비스로 전환하기 위해 클라우드 시스템 구성요소를 설계한다. 새로운 솔루션의 안전한 운영과 이용자 서비스 제공을 위해 솔루션 배포 정책을 수립하고 배포 절차와 환경 설계, 테스트 방안을 수립한다. 클라우드 솔루션의 운영정책 및 장애처리 방안을 수립하고 모니터링 환경을 설계한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"관련없음","connectJob":"클라우드데이터아키텍트, 클라우드보안아키텍트, 클라우드DB아키텍트","certLic":"정보관리기술사, 컴퓨터시스템응용기술사","dJobECd":"1320","dJobECdNm":"[1320]컴퓨터시스템 전문가","dJobJCd":"2221","dJobJCdNm":"[2221]컴퓨터 시스템 전문가","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005179:1', '{"dJobCd":"K000005179","dJobCdSeq":"1","dJobNm":"탄소배출관리시스템개발원","workSum":"전사적 온실가스 인벤토리(Inventory)를 구축하며 이력관리와 탄소배출권거래 및 데이터검증이 가능한 시스템을 개발한다.","doWork":"국내외 탄소배출에 대한 가이드라인을 조사·분석하여 인벤토리 구축을 위한 기준을 수립한다. 인벤토리 구축을 위한 조직을 구성하고 조사양식에 대한 기준을 확립한다. 인벤토리 구축을 위해 온실가스 배출과 관련하여 기업 및 공공기관 내부에서 생산활동으로 인한 직·간접적인 탄소배출원을 규명하고 배출원별로 가장 합리적인 탄소배출량을 산정한다. 기업의 탄소배출 감축여력을 정량적으로 도출하는 시스템을 개발한다. 기업활동 전반에 대해 탄소배출에 따른 위험요소를 최소화시키거나 제거할 수 있도록 저탄소경영시스템을 개발한다. 탄소인벤토리시스템, 감축잠재량평가시스템, 저탄소경영시스템을 통합 관리하는 IT시스템을 구축한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"1320","dJobECdNm":"[1320]컴퓨터시스템 전문가","dJobJCd":"2221","dJobJCdNm":"[2221]컴퓨터 시스템 전문가","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006150:1', '{"dJobCd":"K000006150","dJobCdSeq":"1","dJobNm":"핀테크시스템엔지니어","workSum":"안정적인 핀테크서비스를 위한 인프라를 설계하고 구축·운영한다.","doWork":"리눅스(UNIX)기반 시스템을 구축하고 운영한다. 리눅스서버를 관리운영하고 서버환경 및 시스템에 대한 요구사항을 조율하고 반영한다. 시스템자동화를 위한 아키텍처를 설계한다. 시스템 운영자동화 로그를 분석한다. 오픈소스 및 서버스토리지를 구축하고 운영한다. 보안솔루션을 구축하고 각종 시스템 보안이슈에 대해 대처한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"관련없음","certLic":"정보관리기술사, 컴퓨터시스템응용기술사","dJobECd":"1320","dJobECdNm":"[1320]컴퓨터시스템 전문가","dJobJCd":"2221","dJobJCdNm":"[2221]컴퓨터 시스템 전문가","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004758:1', '{"dJobCd":"K000004758","dJobCdSeq":"1","dJobNm":"핀테크에반젤리스트","workSum":"핀테크서비스를 운영하는 고객사가 직면하는 기술적 문제를 관리하고 해결을 돕는다.","doWork":"다양한 핀테크서비스의 구조와 연동과정을 이해하고 고객사의 다양한 기술적 요청사항 및 이슈에 대응한다. 연동과정 및 기술적 질문에 대해 설명한다. 서비스를 쉽게 사용할 수 있도록 고객사의 상황과 니즈에 맞춰 가이드를 제공한다. 개발팀과 협업하여 연동 프로세스 최적화 작업을 진행하고 관련 문서를 관리한다. 서비스 개선이 필요한 문제들에 대하여 효율적으로 처리될 수 있도록 관리한다. 핀테크개발자 및 관련 기술전문가의 관심 및 지원을 유도한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"핀테크신기술전도사","dJobECd":"1320","dJobECdNm":"[1320]컴퓨터시스템 전문가","dJobJCd":"2221","dJobJCdNm":"[2221]컴퓨터 시스템 전문가","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005065:1', '{"dJobCd":"K000005065","dJobCdSeq":"1","dJobNm":"3D지도개발자","workSum":"도로 조사로 얻어진 자료를 데이터베이스에 입력하고 품질관리를 한 후 3D지도 데이터베이스를 배포한다.","doWork":"실측된 모든 자료를 데이터베이스에 입력한다. 객체를 추출하고 추출된 객체를 토대로 3D로 입체화한다. 내비게이션 업데이트 계획에 따라 3D지도 데이터베이스를 배포한다. 개발된 지도의 품질관리를 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"1331","dJobECdNm":"[1331]시스템 소프트웨어 개발자","dJobJCd":"2222","dJobJCdNm":"[2222]시스템 소프트웨어 개발자","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001233:1', '{"dJobCd":"K000001233","dJobCdSeq":"1","dJobNm":"IoT시스템엔지니어","workSum":"IoT 서비스를 제공하기 위해 구성요소 간 연동 프로토콜을 분석하여 유무선 네트워크를 통해 사물들을 유기적으로 연결하는 업무를 수행한다.","doWork":"IoT 서비스를 이해하여 연동 대상의 선정·파악 및 연동 프로토콜을 분석하여 연동 계획을 수립한다. 해당 IoT 시스템을 분석·설계하고 연동 규격을 작성하며, 연동 모듈의 개발 계획 수립 및 요구사항 파악 후 연동 모듈을 설계·개발한다. IoT 시스템 서비스와 외부 서비스의 연동 요구사항을 분석하고, 제시된 프로토콜을 활용하여 서비스 간 연계를 한다. 서버, 게이트웨이, 스마트 디바이스, 엣지 디바이스의 기술 규격과 요구사항을 분석하여, 서비스에 맞는 유무선 통신 방식을 선정하고 시스템을 구현한다. 연동의 시험 방식을 구체화하고, IoT 통합 테스트를 통한 시험 결과를 공유한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"시스템엔지니어(S.E)","certLic":"정보관리기술사, 기술지도사(정보처리 분야), 정보처리기사, 임베디드기사, 정보기기운용기능사","dJobECd":"1331","dJobECdNm":"[1331]시스템 소프트웨어 개발자","dJobJCd":"2222","dJobJCdNm":"[2222]시스템 소프트웨어 개발자","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001511:1', '{"dJobCd":"K000001511","dJobCdSeq":"1","dJobNm":"IoT시스템운영자","workSum":"IoT 서비스를 안정적으로 제공하기 위하여 운영·관리 계획을 수립하고, 응용서비스, 플랫폼, 네트워크, 디바이스, 연동, 보안에 대한 운영·관리와 운영 데이터 관제, 시스템 변경 관리 등의 업무를 수행한다.","doWork":"IoT 플랫폼에서 동작하는 응용 SW 제공을 위한 운영·관리 상세계획을 수립하고, 현황을 파악하여 개선 계획을 수립한다. IoT 응용서비스 구성과 성능을 관리하여 최적화 작업을 수행한다. IoT 플랫폼의 운영 현황을 파악하고, 기능 요소를 분석하여 개선하고 관리한다. IoT 네트워크의 구성관리, 성능관리, 장애관리를 하며, IoT 디바이스의 성능점검과 펌웨어 관리, 고장 수리를 한다. IoT 시스템의 연동 관리대상을 파악하고, 연동 프로토콜을 분석하여 연동 안정성을 확보한다. IoT 시스템에서 발생하는 데이터를 수집, 저장, 분석, 모니터링하고 품질을 관리한다. 보안 시스템을 점검하고, 취약점을 분석하여 보안 안정성을 확보한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"컴퓨터운영관리자","certLic":"무선설비기사, 방송통신기사,  임베디드기사, 전자계산기조직응용기사, 전파전자통신기사, 정보보안기사, 정보처리기사, 정보통신기사, 빅데이터분석기사, 네트워크관리사 1급(한국정보통신 자격협회)","dJobECd":"1331","dJobECdNm":"[1331]시스템 소프트웨어 개발자","dJobJCd":"2222","dJobJCdNm":"[2222]시스템 소프트웨어 개발자","dJobICd":"J620","dJobICdNm":"[J620]컴퓨터 프로그래밍, 시스템 통합 및 관리업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001275:1', '{"dJobCd":"K000001275","dJobCdSeq":"1","dJobNm":"IoT융합서비스기획자","workSum":"IoT(사물인터넷)을 적용하고자 하는 서비스 분야의 사물과 사물, 사물과 정보시스템을 융합하여 사람에게 다양한 편리와 안전을 제공하기 위한 지능형 서비스를 기획하는 업무를 수행한다.","doWork":"체계적인 IoT 융합서비스를 위한 환경분석과 비즈니스 모델 개발을 위한 비즈니스 모델 현황 및 정보를 수집·분석하여 기업 IoT 비즈니스 모델을 수립한다. IoT 환경분석과 비즈니스 모델을 기반으로 서비스 시나리오를 작성하고, IoT 서비스 및 디바이스의 모형 기능과 적용될 IoT 표준을 명세화 한다. IoT 디바이스의 개발과 공급 계획 수립과 IoT 플랫폼의 요구사항 분석 및 적용 방안을 수립한다. IoT 응용소프트웨어 개발을 위한 분석과 아키텍처 설계, 운영 시나리오와, IoT 데이터 명세화, IoT 데이터 수집·저장·활용 계획을 수립한다. IoT 보안 위협에 대응하기 위한 관리방안을 마련하고, IoT 마케팅 계획 수립과 IoT 서비스 관리·운영 및 유지보수를 위한 계획을 수립한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"IT시스템기획자","certLic":"정보처리기술사, 기술지도사(정보처리 분야), 정보처리기사, 임베디드기사, 데이터분석전문가, 데이터분석준전문가","dJobECd":"1331","dJobECdNm":"[1331]시스템 소프트웨어 개발자","dJobJCd":"2222","dJobJCdNm":"[2222]시스템 소프트웨어 개발자","dJobICd":"J620","dJobICdNm":"[J620]컴퓨터 프로그래밍, 시스템 통합 및 관리업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003275:1', '{"dJobCd":"K000003275","dJobCdSeq":"1","dJobNm":"공간정보융합서비스시스템개발자","workSum":"공간분석컨설팅, 항법장치, 게임, 가상현실, 위치검색서비스 등 정보가 융합된 다양한 서비스 시스템을 개밯한다.","doWork":"공공정책, 자동차항법장치, 가상현실, 게임, 부동산, 마케팅, 대중교통, 숙박, 관광, 안전 등 개발 분야의 공간정보융합서비스 관련자와 면담하여 개발할 서비스의 기능 및 요구사항을 파악한다. 관련분야의 특성을 분석하고 기술요건, 기능 외 성능, 보안, 품질, 제약사항 등을 분석하여 개발사양서(요구사항기술서)를 작성한다. 서비스에 필요한 공간자료의 종류와 유형을 분류하여 특성을 파악하고 효율적인 서비스를 위한 데이터모델(데이터관리, 물리적구조, 유지관리체계, 메타데이터, 레이어설계 등), 하드웨어 아키텍처, 소프트웨어 아키텍처, UI(지도의 이동 및 확대축소, 레이어가시화 및 중첩, 지점 및 객체정보조회, 분석 및 조작 등)를 설계하고 설계서를 작성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"전문 분야에 따라 공간정보UI개발자, 모바일공간정보서비스개발자, 웹공간정보서비스개발자","certLic":"컴퓨터시스템응용기술사, 공간정보융합기사, 공간정보융합산업기사","dJobECd":"1331","dJobECdNm":"[1331]시스템 소프트웨어 개발자","dJobJCd":"2222","dJobJCdNm":"[2222]시스템 소프트웨어 개발자","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003282:1', '{"dJobCd":"K000003282","dJobCdSeq":"1","dJobNm":"내비게이션도로조사후처리원","workSum":"취득된 도로데이터를 처리하여 개체를 추출한다.","doWork":"고정밀 도로데이터를 입력한다. 입력된 데이터에서 객체를 추축하고 흑백의 레이저 영상이미지를 생성한다. 생성된 이미지에서 차선, 표지판, 도로연석 등의 추출한 객체를 속성값으로 가공한다. 가공된 값을 데이터베이스 형식으로 변환하여 정밀지도를 완성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"1331","dJobECdNm":"[1331]시스템 소프트웨어 개발자","dJobJCd":"2222","dJobJCdNm":"[2222]시스템 소프트웨어 개발자","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004530:1', '{"dJobCd":"K000004530","dJobCdSeq":"1","dJobNm":"내비게이션항법지도개발자","workSum":"차량에서 사용되는 내비게이션지도를 개발한다.","doWork":"대한민국 표준전자지도 전도와 실사 실측한 자료를 비교·확인한다. 개발되는 내비게이션에 따라 주요 모듈 및 응용프로그램을 개발한다. 디스플레이, 안내, 검색, 사용자 인터페이스 등을 개발한다. 개발된 응용프로그램이 실제주행 시 작동하는지 테스트한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"1331","dJobECdNm":"[1331]시스템 소프트웨어 개발자","dJobJCd":"2222","dJobJCdNm":"[2222]시스템 소프트웨어 개발자","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001300:1', '{"dJobCd":"K000001300","dJobCdSeq":"1","dJobNm":"디지털트윈엔지니어","workSum":"디지털트윈(서비스) 설계 및 운영 정책을 수립하고, 기획 내용을 바탕으로 현실세계에 대응하는 가상세계를 구축하여 최적화된 연계 서비스를 구현한다.","doWork":"디지털트윈을 통해 해결하고자 하는 현실세계 문제를 명확히 하고, 디지털트윈의 대상과 목표를 설정한다. 디지털트윈 기획에 필요한 대내외 환경변수 및 구축을 위한 요구사항을 분석한다. 디지털트윈 구현을 위한 모델을 식별정의하고, 구현항목을 바탕으로 구현 체계와 인프라 계획을 수립한다. 구축하고자 하는 응용서비스 기능을 구체화하여 현실세계의 대상을 복제, 모델링하여 가상세계의 디지털트윈(모델)을 구현하고 검증한다. 현실(물리)객체와 가상객체 사이의 인터페이스와 동기화 설계에 따라 두 객체를 연동하고, 동기화 달성을 위한 상호작용을 구현한다. 디지털트윈 모델 구현 및 실증을 통해 물리객체와 가상객체 간 상호 연동 시 정해진 성능을 담보하고 오류를 최소화한다. 디지털트윈 모델 및 서비스의 통합, 성능, 안정성 테스트 수행을 위해 테스트 목표와 범위를 정의하고, 일정과 비용을 계획 및 수행한다. 디지털트윈(모델)의 품질 목표를 달성하기 위하여 품질관리 계획을 수립하고 수립한 계획에 따라 품질보증 활동을 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"정보처리기사, 임베디드기사, 빅데이터분석기사, 전자계산기조직응용기사, 정보관리기술사, 정보통신기술사, 컴퓨터시스템응용기술사, 전자응용기술사, 데이터아키텍처전문가, 데이터분석전문가","dJobECd":"1331","dJobECdNm":"[1331]시스템 소프트웨어 개발자","dJobJCd":"2222","dJobJCdNm":"[2222]시스템 소프트웨어 개발자","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005160:1', '{"dJobCd":"K000005160","dJobCdSeq":"1","dJobNm":"반도체장비시스템소프트웨어개발자","workSum":"반도체 FAB 및 장비 관련 국제표준, 고객 요구성능을 이해하고, 지정된 OS를 사용하여 장비제어를 위한 Main Controller, Common Library, GUI 등 시스템소프트웨어를 연구·개발한다.","doWork":"프로그래밍 언어(C, Basic 등), 컴파일러(Visual Basic, C++ 등), 데이터 구조, 처리 및 이해, 각종 알고리즘 및 데이터모델링기술을 기반으로 장비구성, 개별장치동작, Target Device, 소프트웨어알고리즘, 분산처리시스템, 통합환경 구축 관련 지식들을 습득하여 시스템소프트웨어를 연구·개발한다. 하드웨어를 동작하는 디바이스드라이버를 개발하고, 시스템을 통합·제어하는 시퀀스프로그램을 구현하는 등 각종 라이브러리를 개발한다. 그래픽환경에서의 User Interface를 구현하고, 사용자편의성을 고려하여 시스템 제어화면을 구성한다. 시스템 제어알고리즘을 설계하고, 장비시스템 구조를 이해하고, 라이브러리와 GUI를 연계하여 장비운용 및 흐름을 제어하는 Main Controller를 개발한다. 장비조립, 시험성능평가, 현장설치·평가·검증을 통해 소프트웨어설계 오류분석 및 개선을 지원한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 프로그램을 기반으로 다양한 부품 및 장치기술을 시험평가하고, 최적화하는 연구·개발활동을 단독 또는 공동으로 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"반도체장비연구원","connectJob":"반도체장비설계연구원, 반도체장비소프트웨어연구원","dJobECd":"1331","dJobECdNm":"[1331]시스템 소프트웨어 개발자","dJobJCd":"2222","dJobJCdNm":"[2222]시스템 소프트웨어 개발자","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006199:1', '{"dJobCd":"K000006199","dJobCdSeq":"1","dJobNm":"소형컴퓨터시스템연구원","workSum":"실시간 처리를 위주로 하는 소형디지털 컴퓨터시스템을 연구·개발한다.","doWork":"마이크로컴퓨터를 이용하여 입·출력프로그래밍의 기법, 데이터습득, 디지털 신호처리방법, 컴퓨터를 이용한 출력, 연산장치(마이크로프로세서)를 사용하여 마이크로컴퓨터의 설계, 컴퓨터의 실시간 신호처리기로의 응용, 제어시스템의 컴퓨터시스템 응용 등을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"임베디드시스템연구원","dJobECd":"1331","dJobECdNm":"[1331]시스템 소프트웨어 개발자","dJobJCd":"2222","dJobJCdNm":"[2222]시스템 소프트웨어 개발자","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004139:1', '{"dJobCd":"K000004139","dJobCdSeq":"1","dJobNm":"시스템소프트웨어엔지니어","workSum":"컴퓨터시스템의 동작, 제어 및 관리와 관련된 시스템소프트웨어를 개발한다.","doWork":"유닉스(Unix), 리눅스(Linux), 윈도우(Windows) 등과 같은 컴퓨터시스템의 운영체계를 설계하고 개발한다. FORTRAN, C, C++, JAVA 등과 같은 컴퓨터프로그램 언어의 컴파일러(Compiler:고급언어로 쓰인 프로그램을 그와 의미적으로 동등하며 컴퓨터에서 즉시 실행될 수 있는 형태의 목적프로그램으로 바꾸어주는 번역프로그램)를 설계하고 개발한다. 응용소프트웨어를 개발하기 위한 델파이(Delphi), 파워빌더(PowerBuilder) 등과 같은 개발용도구(TOOL)를 설계하고 개발한다. 네트워크시스템에서 운영되는 네트워크프로토콜 처리에 관련된 소프트웨어를 설계하고 개발한다. 정보보호에 필요한 방화벽, 인증, 인가 관련 소프트웨어를 설계하고 개발한다. 각종 산업용 제어시스템에서 운영되는 산업설비의 제어, 모니터링 및 관리용 유틸리티소프트웨어를 설계하고 개발한다. 컴퓨터시스템의 각종 주변장치의 제어 및 인터페이스에 관련된 소프트웨어를 설계하고 개발한다. 컴퓨터시스템에서 운용되는 각종 유틸리티소프트웨어를 설계하고 개발한다. 운영체계를 해당 컴퓨터 하드웨어시스템에 이식(Potting)시키고 기능과 성능을 종합적으로 평가한다. 개발된 시스템소프트웨어에 대한 단계별 과정을 기록하고, 사용자의 교육과 기술자문에 응한다. 지속적으로 컴퓨터의 하드웨어 및 소프트웨어에 대한 새로운 기술을 연구한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"시스템소프트웨어개발자, 시스템프로그래머","connectJob":"펌웨어프로그래머, 임베디드프로그래머","certLic":"정보처리기사, 전자계산기조직응용기사, 임베디드기사","dJobECd":"1331","dJobECdNm":"[1331]시스템 소프트웨어 개발자","dJobJCd":"2222","dJobJCdNm":"[2222]시스템 소프트웨어 개발자","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005098:1', '{"dJobCd":"K000005098","dJobCdSeq":"1","dJobNm":"신발생산관리전산시스템개발자","workSum":"효율적인 신발생산 및 재고관리를 위해 전산시스템을 개발한다.","doWork":"신발류의 효율적인 생산관리기법을 연구한다. 연구를 토대로 생산 및 재고관리에 사용될 전산알고리즘을 설계한다. 전사적자원관리시스템(ERP), 재고관리시스템 등을 개발한다. 신발전용 프로그램을 연구·개발한다. 신발의 유통에 관련된 소프트웨어를 개발한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"1331","dJobECdNm":"[1331]시스템 소프트웨어 개발자","dJobJCd":"2222","dJobJCdNm":"[2222]시스템 소프트웨어 개발자","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004549:1', '{"dJobCd":"K000004549","dJobCdSeq":"1","dJobNm":"이동통신단말미들웨어개발자","workSum":"이동통신단말 미들웨어(Middleware:안정적인 시스템 운용을 도와주는 중계소프트웨어) 및 애플리케이션 응용을 위한 기반소프트웨어를 개발하고 검증한다.","doWork":"이동통신단말의 기능, 요구조건, 제약사항(그래픽사양, 화면사양, 데이터통신서비스의 대역폭, 기타 단말기자원의 제약 등)을 분석한다. 개발 할 미들웨어(Middleware:안정적인 시스템 운용을 도와주는 중계소프트웨어로, 수많은 종류의 표준화되지 않은 하드웨어나 소프트웨어가 말썽없이 운용될 수 있도록 하는 프로그램)의 목표기능을 정의한다. 멀티미디어 코덱 및 라이브러리, 플래시기술, PC동기화기술, 표준지원 미들웨어, 응용패키지관리모듈, 보안모듈 및 보안정책, 2D 및 3D지원 라이브러리, 웹라이브러리, Telephony API(Telephony Application Programming Interface), 데이터베이스엔진, 입력기, 위치정보지원모듈, 콘텐츠관리모듈 등을 개발호스트시스템, 단말 시료 및 참조하드웨어, 하드웨어 디버깅(Debugging:오류 수정) 장비, 단말에뮬레이터(Emulator:어떤 하드웨어나 소프트웨어의 기능을 다른 종류의 하드웨어나 소프트웨어로 모방하여 실현시키기 위한 장치나 프로그램), 각종 기개발된 소스 등을 사용하여 개발하고 검증한다. 각종 미들웨어의 개발이 완료되면 소스코드, 기능명세서, 검증방법 및 세부설계사양서를 작성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"미들웨어전문가","dJobECd":"1331","dJobECdNm":"[1331]시스템 소프트웨어 개발자","dJobJCd":"2222","dJobJCdNm":"[2222]시스템 소프트웨어 개발자","dJobICd":"C264","dJobICdNm":"[C264]통신 및 방송 장비 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006291:1', '{"dJobCd":"K000006291","dJobCdSeq":"1","dJobNm":"이동통신단말소프트웨어개발관리자","workSum":"이동통신단말제품을 완성하기 위하여 이동통신단말 소프트웨어를 개발하고, 단말기 개발의 연속성을 지원하기 위하여 개발시스템을 관리한다.","doWork":"이동통신단말의 품질을 보증하기 위하여 시스템, 플랫폼, 미들웨어 등을 포괄하는 종합적인 테스트케이스를 구현한다. 발생가능한 모든 시나리오를 통해 기능 및 안정성을 검증한다. 효율적인 코드빌드를 위해 코드빌드시스템 및 코드관리시스템을 운용한다. 결함검출, 결함등록, 결함이력관리, 결함담당자지정, 결함해결 여부를 관리하는 코드결함관리시스템을 운용한다. 정적코드분석결과를 통해 소프트웨어의 특성을 파악하고 단말 최적화에 적용한다. 라이선스(License) 분석을 위하여 단말제품소프트웨어에 포함된 다양한 라이선스들의 준수 여부 및 양립성을 보장하고 특허권 침해요소를 사전에 파악한다. 휴대폰인증에 요구되는 기술문서를 작성한다. 휴대폰사용자매뉴얼을 작성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"1331","dJobECdNm":"[1331]시스템 소프트웨어 개발자","dJobJCd":"2222","dJobJCdNm":"[2222]시스템 소프트웨어 개발자","dJobICd":"C264","dJobICdNm":"[C264]통신 및 방송 장비 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004247:1', '{"dJobCd":"K000004247","dJobCdSeq":"1","dJobNm":"이동통신단말플랫폼응용개발자","workSum":"이동통신단말 플랫폼(단말기 운영체제)을 단말기에 적용하거나 응용소프트웨어를 개발한다.","doWork":"이동통신단말의 기능, 요구조건, 제약사항(그래픽사양, 화면사양, 데이터통신서비스의 대역폭, 기타 단말기자원의 제약 등)을 분석한다. 각종 이동통신단말기 플랫폼인 WIPI(Wireless Internet Platform for Interoperability:무선인터넷 표준으로 개발된 한국형 플랫폼), 안드로이드(Android:스마트폰에서 프로그램을 실행하도록 하는 모바일전용 운영체제), 아이폰(Iphone:애플사가 개발한 스마트폰. 터치스크린 기반의 아이팟, 휴대전화, 모바일 인터넷의 주요기능을 갖춘 모바일기기), BREW(Binary Runtime Environment for Wireless:코드분할다중접속방식의 이동통신기기용으로 개발된 플랫폼), 윈도우모바일 플랫폼 등이 단말에서 응용될 수 있도록 개발하고 검증한다. 플랫폼 응용소프트웨어의 소스코드, 기능명세서, 검증방법 및 세부설계사양서를 작성한다. 각종 플랫폼의 표준, 처리방식, 서비스구조, 응용인증절차, 새로운 기능 추가에 대한 지식을 숙지하고 다른 개발자들과 협의하여 소프트웨어를 안정시킨다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"1331","dJobECdNm":"[1331]시스템 소프트웨어 개발자","dJobJCd":"2222","dJobJCdNm":"[2222]시스템 소프트웨어 개발자","dJobICd":"C264","dJobICdNm":"[C264]통신 및 방송 장비 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007782:1', '{"dJobCd":"K000007782","dJobCdSeq":"1","dJobNm":"인공지능서비스개발자","workSum":"인공지능서비스를 개발하기 위하여 요건 분석, 상위설계, 상세설계, 애플리케이션 개발, 모델 인터페이스 개발, 서비스 이행, 자원구성, 안전성 검토 등의 업무를 한다.","doWork":"인공지능서비스의 목표, 요구사항, 성과평가 내용을 검토하여 실제 인공지능서비스를 구현에 필요한 인공지능서비스 플랫폼, 모델, 데이터, 인터페이스 개발 항목과 제약사항을 분석한다. 구현요건 분석 결과에 따라 인공지능서비스에 필요한 구성요소를 분석하여 인공지능서비스의 아키텍처, 인프라 및 애플리케이션을 설계한다. 인공지능서비스 상위설계에 따라 인공지능서비스 플랫폼, 모델, 데이터, 인터페이스를 정의하여 구성 요소별 적용방안을 설계한다. 비즈니스 로직을 구현하고 플랫폼, 모델을 연동하는 응용 소프트웨어를 개발한다. 인공지능서비스의 구현을 위하여 인공지능 모델을 애플리케이션에 적용한다. 인공지능서비스 구현을 위하여 사용자 인터페이스, 시스템 인터페이스와 같은 인공지능 인터페이스를 개발하고 테스트하여 사용성을 평가한다. 테스트 목표와 범위를 정의하고 이를 수행하기 위한 일정과 비용을 계획하여 통합, 성능, 신뢰성 테스트를 수행한다. 인공지능서비스를 실제 운영환경으로 이행하기 위한 계획을 수립하여 운영환경을 구축하고, 인수테스트를 통해 고객에게 제공한다. 인공지능서비스 설계 결과에 따른 필요자원 분석을 통해 인공지능서비스 구현을 위한 자원 선정과 자원을 확보한다. 인공지능서비스를 구현하는데 안전성을 위배하지 않도록 안전성 항목을 검토하고 결과서를 작성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"데이터분석전문가, 데이터분석준전문가, 데이터아키텍처전문가, 데이터아키텍처준전문가, 정보관리기술사, 정보처리기사, 컴퓨터시스템응용기술사, 빅데이터분석기사","dJobECd":"1331","dJobECdNm":"[1331]시스템 소프트웨어 개발자","dJobJCd":"2222","dJobJCdNm":"[2222]시스템 소프트웨어 개발자","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2025"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002420:1', '{"dJobCd":"K000002420","dJobCdSeq":"1","dJobNm":"임베디드소프트웨어개발자","workSum":"제품이나 솔루션에 내장되어 특정작업을 수행하는 임베디드소프트웨어를 설계 및 개발한다.","doWork":"개발발의를 받고 개발 타당성검토를 한다. 기획 및 연구부서에서 기획한 기능을 구현하기 위하여 관련 표준규격을 검토하고 하드웨어 설계결과물을 분석하여 소프트웨어 구성에 대해 결정한다. 프로그래밍 언어를 사용하여 프로그램을 코딩한다. 소프트웨어 모듈 간 통신이 프로토콜대로 동작하는지 테스트하여 검증한다. 하드웨어와 소프트웨어에 문제발생 시 수정계획을 수립하고 수정작업을 진행한다. 동작에 문제가 없을 경우 사용자매뉴얼, 업데이트 관련 자료 등을 문서화 작업한다. 최종 양산과정에서 실제 프로그램 검증을 하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"펌웨어소프트웨어개발자","certLic":"임베디드기사","dJobECd":"1331","dJobECdNm":"[1331]시스템 소프트웨어 개발자","dJobJCd":"2222","dJobJCdNm":"[2222]시스템 소프트웨어 개발자","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2018","etc":"자격/면허 추가"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001559:1', '{"dJobCd":"K000001559","dJobCdSeq":"1","dJobNm":"자율주행소프트웨어개발자","workSum":"자동차의 원활한 자율주행을 위하여 차량 센서, 인프라에서 수집한 데이터를 기반으로 인지하고 판단하여 자동차를 제어하는 소프트웨어를 개발한다.","doWork":"자율주행에 필요한 요구사항을 분석하여 아키텍처를 설계한다. 자율주행 자동차가 주변의 객체를 인식하기 위하여 라이다와 레이더, 카메라 등의 센서 데이터를 처리한다. 주행환경 파악을 위해 다중의 센서 데이터를 이용하여 향상된 객체 인식 성능을 구현한다. 운행을 위하여 GPS, 정밀지도, 카메라 등 센서를 사용하여 위치 측위 기능을 구현한다. 자율주행 자동차의 인지 확장을 위하여 다양한 무선 통신 방식으로 V2X Data를 수집한다. 자율주행 자동차와 탑승자, 주변 사람이 안전하게 상호작용하도록 다양한 자율주행 관련 정보를 표출되도록 HMI/UX로 구현한다. 자율주행 자동차가 목적지까지 원활한 운행을 할 수 있도록 경로 생성 알고리즘을 통하여 자동으로 경로를 생성한다. 자율주행 자동차가 최종 목적지에 도달하기 위해 주행 환경에 대한 분석 결과를 기반으로 시스템적으로 지역 경로를 생성한다. 자율주행 차량의 기능 동작 중 차량 일부에 결함 또는 고장이 발생했을 때, 소프트웨어 범주에서 사고를 최소화한다. 자율주행 자동차의 원활한 주행을 위하여 필요한 단위별 소프트웨어를 통합 관리하여 검증한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"자율주행소프트웨어프로그래머, 자율주행소프트웨어설계자","certLic":"그린전동자동차기사, 자동차정비산업기사, 자동차정비기사, 빅데이터분석기사, 정보처리산업기사, 정보처리기사, 정보통신산업기사, 정보통신기사","dJobECd":"1331","dJobECdNm":"[1331]시스템 소프트웨어 개발자","dJobJCd":"2222","dJobJCdNm":"[2222]시스템 소프트웨어 개발자","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001596:1', '{"dJobCd":"K000001596","dJobCdSeq":"1","dJobNm":"차량용 데이터 플랫폼·응용 개발자","workSum":"차량용 빅데이터를 효율적으로 취득 및 저장 후 가공, 분석하는 데이터 플랫폼 구축하고 구축 플랫폼을 기반으로 새로운 가치를 창출하는 데이터 응용 관련 하드웨어 및 소프트웨어를 개발한다.","doWork":"차량용 데이터의 특성을 이해하고 운행환경 파악 및 분석 후 차량 운행과 서비스에 필요한 유스케이스·시나리오를 정의하고 관련한 기능, 기술에 대한 솔루션을 개발하고 제공한다. 차량용 데이터 요구사항을 바탕으로 내부와 외부 데이터를 연계한 부품, 시스템 개발방법론을 결정하고 기능 구현에 필요한 데이터 라이프사이클(수집-저장-분석-활용) 간의 구조를 설계한다. 차량용 데이터의 요구사항과 아키텍처를 수용할 수 있는 전용 데이터 플랫폼을 구축하고 응용분야별 데이터 플랫폼를 활용한 ML/DL(머신러닝/딥러닝) 기반 차량용 소프트웨어 기술 개발을 수행한다. 차량용 데이터의 보안 요구사항을 바탕으로 데이터 플랫폼 및 부품·시스템을 개발하기 위해 보안 위협요소를 분석하고 설계하며, 데이터 통신 및 서비스의 보안성을 제공하기 위한 소프트웨어를 개발한다. 차량용 데이터 플랫폼 및 부품·시스템의 시험방법을 정의하고 기능에 대한 시험 및 평가를 하여 잠재적 결함을 식별한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"임베디드기사, 정보처리산업기사, 정보처리기사, 정보통신산업기사, 정보통신기사, 정보보안기사, 빅데이터분석기사, 국가공인데이터분석전문가/준전문가","dJobECd":"1331","dJobECdNm":"[1331]시스템 소프트웨어 개발자","dJobJCd":"2222","dJobJCdNm":"[2222]시스템 소프트웨어 개발자","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007807:1', '{"dJobCd":"K000007807","dJobCdSeq":"1","dJobNm":"차량용데이터플랫폼응용개발자","workSum":"차량용 빅데이터를 효율적으로 취득 및 저장한 후 가공, 분석하는 데이터 플랫폼 구축 및 구축된 데이터 플랫폼을 기반으로 새로운 가치를 창출하는 데이터 응용 분야 관련한 하드웨어 및 소프트웨어를 개발한다.","doWork":"차량용 데이터의 특성을 이해하고 운행환경 파악 및 분석 후 차량 운행과 서비스에 필요한 유스케이스·시나리오를 정의하고 관련한 기능, 기술에 대한 솔루션을 개발하고 제공한다. 차량용 데이터 요구사항을 바탕으로 내부와 외부 데이터를 연계한 부품, 시스템 개발방법론을 결정하고 기능 구현에 필요한 데이터 라이프사이클(수집-저장-분석-활용) 간의 구조를 설계한다. 차량용 데이터의 요구사항과 아키텍처를 수용할 수 있는 전용 데이터 플랫폼을 구축하고 응용분야별 데이터 플랫폼를 활용한 ML/DL(머신러닝/딥러닝) 기반 차량용 소프트웨어 기술 개발을 수행한다. 데이터 분석 및 빅데이터 구축을 위해서 차량의 개발에서 운영·폐차까지 데이터의 수집 및 분석 기술, 실차 및 시뮬레이션 등 해석 데이터를 활용한 최적설계 기술, 운행환경·사용목적별 차량 부품·시스템을 제어하기 위한 기술이 중요하며, 데이터 플랫폼의 아키텍처 설계 및 데이터 솔루션 개발을 위해서 외부 데이터 플랫폼과의 연계를 고려한 내부 플랫폼 설계 및 운용 기술, 분석용 빅데이터의 표준화를 통한 가공·축약 기술이 중요하며, 마지막으로 빅데이터 분석을 위한 AI소프트웨어 개발을 위해서 운행환경·사용목적별 AI모델 선정, AI모델에 대한 평가 및 최적화, AI성능 개선을 위한 기술이 중요하다. 차량용 데이터의 보안 요구사항을 바탕으로 데이터 플랫폼 및 부품·시스템을 개발하기 위해 보안 위협요소를 분석하고 설계하며, 데이터 통신 및 서비스의 보안성을 제공하기 위한 소프트웨어를 개발한다. 차량용 데이터 플랫폼 및 부품·시스템의 시험방법을 정의하고 기능에 대한 시험 및 평가를 하여 잠재적 결함을 식별한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"임베디드기사, 정보처리산업기사, 정보처리기사, 정보통신산업기사, 정보통신기사, 정보보안기사, 빅데이터분석기사, 데이터분석전문가, 데이터분석준전문가","dJobECd":"1331","dJobECdNm":"[1331]시스템 소프트웨어 개발자","dJobJCd":"2222","dJobJCdNm":"[2222]시스템 소프트웨어 개발자","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001557:1', '{"dJobCd":"K000001557","dJobCdSeq":"1","dJobNm":"클라우드플랫폼엔지니어","workSum":"클라우드 환경에서 애플리케이션과 서비스를 빠르고 효율적으로 개발, 배포, 확장할 수 있도록 개발환경, 프로그램과 서비스를 지원하는 기본 인프라 및 플랫폼, 워크플로우 및 도구를 설계, 구축하고 유지관리한다.","doWork":"PaaS를 제공하기 위해 서비스의 품질·성능 목표 및 운영 정책을 수립하고 서비스 수준 협약서를 작성한다. 서비스 명세서 및 정책을 기반으로 기능, 비기능 요구사항, 컴플라이언스를 분석하여 요구사항 명세서를 작성하고 아키텍처를 설계한다. PaaS 요구사항과 정책을 기반으로 PaaS 상세 기능을 도출하여 PaaS 기능과 프로비저닝, 외부시스템 연동 기능을 설계한다. PaaS 요구사항과 정책을 기반으로 PaaS 상세 기능을 도출하여] 사용자 및 관리자 인터페이스를 설계한다. PaaS 백엔드 설계에 따라 PaaS 기능과 프로비저닝, 외부시스템 연동 기능을 구현한다. PaaS 프론트엔드 설계서를 기반으로 필요한 개발도구를 이용하여 사용자 및 관리자 인터페이스를 개발한다. PaaS 배포 정책 및 CI/CD 설계서를 기준으로 배포 환경 구성과 배포 가이드를 작성하고, 배포 작업 계획을 수립하여 PaaS를 배포한다. PaaS 모니터링, 장애처리, 기능개선을 수행하고 운영 결과를 보고한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"클라우드엔지니어","certLic":"정보처리산업기사, 정보처리기사","dJobECd":"1331","dJobECdNm":"[1331]시스템 소프트웨어 개발자","dJobJCd":"2222","dJobJCdNm":"[2222]시스템 소프트웨어 개발자","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005286:1', '{"dJobCd":"K000005286","dJobCdSeq":"1","dJobNm":"항공기상정보지원전문가","workSum":"항공기상 전산처리시스템 및 관측장비를 개발·운영·관리한다.","doWork":"항공기상관측 및 정보화에 관한 운영계획을 수립·종합·조정한다. 항공기상 관측기술을 개발한다. 항공기상 전산처리시스템을 개발하고 운영한다. 항공기상 DB 및 서비스시스템을 개발하고 운영한다. 항공기상관측장비의 수급, 관리, 운영 및 검정·교정 관련 업무를 수행한다. 항공기상 통신망 및 통신장비를 운영하고 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"기상예보기술사, 기상기사, 기상감정기사","dJobECd":"1331","dJobECdNm":"[1331]시스템 소프트웨어 개발자","dJobJCd":"2222","dJobJCdNm":"[2222]시스템 소프트웨어 개발자","dJobICd":"O841","dJobICdNm":"[O841]입법 및 일반 정부 행정","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001230:1', '{"dJobCd":"K000001230","dJobCdSeq":"1","dJobNm":"RPA개발자","workSum":"인공지능기술과 자동화프로그램(Uipth 등)을 활용하여 업무공정을 단순화하는 RPA(Robotic Process Automation)머신을 설계, 구축 및 운영한다.","doWork":"기업의 RPA솔루션을 도입하고 구현하기 위하여 비즈니스 프로세스를 분석하고, 효과적인 도입을 위한 전략을 개발한다. 기업의 요구사항을 파악하고, 업무 프로세스를 분석한다. 자동화할 수 있는 작업을 검토하여 자동화공정을 설계한다. 인공지능기술 등을 활용하여 일상적인 작업을 로봇이나 소프트웨어 봇이 자동으로 수행할 수 있게 자동화 솔루션을 설계하고 개발한다. 개발한 자동화 솔루션을 테스트 및 모니터링한다. 운영 서버를 정기적으로 점검하고, 윈도우 및 응용소프트웨어(SQL, DBMS 등)를 관리한다. 구축한 RPA솔루션(관리봇, 운영봇 등)을 운영하고 시스템의 성능이 최적화로 유지할 수 있게 관리하고, 필요한 경우 유지보수한다. 사용자들이 자동화된 프로세스를 사용할 수 있게 교육을 하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"응용소프트웨어개발자, 로봇과정자동화개발자","certLic":"정보처리기사, 전자계산기조직응용기사","dJobECd":"1332","dJobECdNm":"[1332]응용 소프트웨어 개발자","dJobJCd":"2223","dJobJCdNm":"[2223]응용 소프트웨어 개발자","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007452:1', '{"dJobCd":"K000007452","dJobCdSeq":"1","dJobNm":"가상현실전문가","workSum":"이용자가 실제 세계와 유사한 느낌을 갖도록 컴퓨터로 3차원 가상현실시스템을 개발한다.","doWork":"사용자가 원하는 가상세계가 무엇인지 파악하거나 개발하고자 하는 시스템을 분석하여 개발방향을 설정한다. 신제품에 대한 기획안을 만든다. Visual Basic, C++ 등과 같은 컴퓨터프로그램 언어와 3차원 컴퓨터그래픽 제어기술을 활용하여 프로그래밍한다. 그래픽디자이너는 사물을 스케치하고 색 및 질감을 입혀 사용자가 실제의 느낌을 가질 수 있도록 가상현실시스템을 디자인한다. 사용장비에 따라 입력장치, 인터페이스장치, 입체디스플레이 자세추적장치 등을 제작한다. 제작된 3차원 가상현실소프트웨어에 오류는 없는지 테스트하고 수정작업을 거쳐 제품을 완성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"VR전문가, 인공현실전문가, 가상환경전문가, 가상세계기술전문가, 가상인식전문가","certLic":"정보처리기사, 시각디자인기사","dJobECd":"1332","dJobECdNm":"[1332]응용 소프트웨어 개발자","dJobJCd":"2223","dJobJCdNm":"[2223]응용 소프트웨어 개발자","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004702:1', '{"dJobCd":"K000004702","dJobCdSeq":"1","dJobNm":"가상훈련콘텐츠개발자","workSum":"현실과 유사한 가상환경을 통해 체험 및 실습, 훈련을 하는 가상훈련콘텐츠를 개발한다.","doWork":"개발하려는 가상훈련콘텐츠의 종류에 따라 가상훈련데이터를 수집하고 가상훈련절차에 따라 시나리오를 제작한다. 가상훈련콘텐츠에 필요한 캐릭터, 배경, 소품 등의 그래픽리소스를 제작하고 편집한다. 배경음악, 효과음 등의 사운드리소스를 수집하고 필요한 경우 제작한다. 360도 VR영상제작에 필요한 하드웨어 및 소프트웨어를 선정하고 VR이미지 및 영상을 촬영·편집한다. 가상훈련콘텐츠의 배경 및 객체의 모델링, 텍스처, 애니메이션을 구현한다. 가상훈련시스템과 연동될 수 있도록 연동프로그램을 제작한다. 개발된 가상훈련콘텐츠를 검증하기 위한 테스트 및 평가계획을 작성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"1332","dJobECdNm":"[1332]응용 소프트웨어 개발자","dJobJCd":"2223","dJobJCdNm":"[2223]응용 소프트웨어 개발자","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006655:1', '{"dJobCd":"K000006655","dJobCdSeq":"1","dJobNm":"게임그래픽프로그래머","workSum":"게임기획을 바탕으로 게임에 사용하는 시각적인 표현을 더욱 원활하게 할 수 있도록 프로그래밍한다.","doWork":"게임기획과 개발환경을 고려하여 적절한 그래픽적인 효과를 적용할 수 있는 프로그래밍 방향성을 정리한다. 담당자들과 협의를 통해 그래픽 구현에 필요한 각종 툴과 스크립트의 목록을 작성하고 작업스케줄을 구성한다. 게임의 방향성에 적합한 셰이더효과를 위하여 각종 셰이더기능을 이용하여 변환, 렌더링 등의 작업을 처리할 수 있도록 프로그램을 구성하며, 조명모델을 활용하여 음영을 현실적으로 구현한다. 이펙트기능의 효과적인 구현을 위하여 셰이더언어를 사용하여 코드를 작성하고 적용한다. 물리기반 렌더링으로 영상의 질을 향상시킨다. 영상을 후처리할 수 있도록 각종 필터를 코딩하고 적용한다. 구현한 셰이터툴과 스크립트를 적용하고 개량한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"게임프로그래밍전문가","dJobECd":"1332","dJobECdNm":"[1332]응용 소프트웨어 개발자","dJobJCd":"2223","dJobJCdNm":"[2223]응용 소프트웨어 개발자","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004583:1', '{"dJobCd":"K000004583","dJobCdSeq":"1","dJobNm":"게임서버프로그래머","workSum":"게임서버 컴퓨터에서 게임이 원활하게 운영되도록 게임서버시스템을 설계하고 네트워크프로그램 및 서버응용프로그램을 구현한다.","doWork":"게임기획을 바탕으로 유무선네트워크로 연동하는 게임의 서버시스템을 구상하고 서버시스템 구현에 필요한 정보를 수집·분석한다. 분석한 내용에 따라 서버시스템 구조를 설계한다. TCP/IP, UDP통신 등 데이터통신을 통해 프로세스 간 네트워크통신을 구현한다. 서버와 DB, 서버와 클라이언트 간의 데이터 전송구조를 설계하고 알고리즘을 작성한다. 작성한 알고리즘에 따라 게임서버리포팅 및 패치프로그램을 작성한다. 게임서버 테스트환경을 구축하고 테스트를 실시한다. 테스트 결과를 분석하여 튜닝하고 최종 서버응용 프로그램코드를 완성하여 게임서버 응용프로그램을 구현한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"게임프로그래밍전문가, 정보보안산업기사, 정보보안기사, 정보처리기사","dJobECd":"1332","dJobECdNm":"[1332]응용 소프트웨어 개발자","dJobJCd":"2223","dJobJCdNm":"[2223]응용 소프트웨어 개발자","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001785:1', '{"dJobCd":"K000001785","dJobCdSeq":"1","dJobNm":"게임클라이언트프로그래머","workSum":"게임플레이를 구현할 수 있도록 설정된 게임세계의 배경 위에서 서로 작용하는 캐릭터와 오브젝트들의 규칙과 이벤트를 컴퓨터프로그램으로 구현한다.","doWork":"게임기획과 개발환경을 바탕으로 게임플레이에 필요한 여러가지 상호작용을 프로그램으로 구현한다. 게임의 플레이를 프로그래밍할 수 있도록 사용자가 조작할 수 있는 입출력과 캐릭터 반응을 설계하고, 이에 대한 캐릭터(대상)의 동작과 반응을 구현한다. 게임배경 위에 등장하는 캐릭터와 다른 캐릭터, 또는 게임오브젝트 간의 상호작용을 기획하고, 이와 관련한 각종 아이템의 해체, 교체, 상호작용을 프로그램으로 구현한다. 플레이반응의 결과에 따른 보상과 캐릭터의 상태정보를 프로그램으로 구현한다. 게임의 무대가 되는 지형과 월드구조를 설계하고, 던전과 마을을 구현하며, 플레이에 대한 상호작용을 기획하여 적용한다. 캐릭터, 오브젝트의 행동과 관련한 물리적인 반응과 지형 내비게이션, 지형 오브젝트 등의 자료구조, 알고리즘을 구현하고 프로그램으로 제작한다. 게임기획에 따라 게임플레이에서 발생하는 여러 이벤트를 목록화하고 각각 설계를 진행한다. 캐릭터 내부의 인벤토리, 메뉴 등의 효과적용과 캐릭터, 오브젝트 간의 상호작용 이벤트를 구현하고 적용한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"게임로직프로그래머","certLic":"게임프로그래밍전문가","dJobECd":"1332","dJobECdNm":"[1332]응용 소프트웨어 개발자","dJobJCd":"2223","dJobJCdNm":"[2223]응용 소프트웨어 개발자","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007580:1', '{"dJobCd":"K000007580","dJobCdSeq":"1","dJobNm":"게임프로그래머","workSum":"게임프로그램의 구조를 설계하고 게임프로그래밍을 수행한다.","doWork":"게임기획자, 게임그래픽디자이너, 게임음악가 등으로부터 넘겨받을 자료를 기반으로 게임프로그램의 구조를 설계한다. 게임을 제작하기 위한 툴인 게임엔진을 개발한다. 영상을 컴퓨터 모니터에 출력하는 데 필요한 제반 함수들의 집단인 그래픽라이브러리를 제작한다. 그래픽 특수효과를 제작한다. 키보드, 마우스 등의 입력장치제어루틴을 제작한다. 그래픽파일이나 사운드파일이 정상적으로 게임 속에서 작동될 수 있도록 해 주는 프로그램을 작성한다. 게임을 테스트하여 에러를 수정하고 버그를 찾아낸다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"제어조작","connectJob":"온라인게임프로그래머, 네트워크게임프로그래머, 아케이드게임프로그래머","certLic":"게임프로그래밍전문가","dJobECd":"1332","dJobECdNm":"[1332]응용 소프트웨어 개발자","dJobJCd":"2223","dJobJCdNm":"[2223]응용 소프트웨어 개발자","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002484:1', '{"dJobCd":"K000002484","dJobCdSeq":"1","dJobNm":"경영정보시스템개발자","workSum":"기업의 경영관리에 필요한 정보를 분석하여 해당 사업장에 적합한 시스템솔루션을 구축한다.","doWork":"기업의 경영관리에 필요한 정보를 분석하여 해당 사업장에 적합한 시스템솔루션을 제시한다. 투자, 생산, 판매, 경리, 인사 등 경영관리에 필요한 각종 정보가 경영진이나 조직의 관리자에게 신속하게 전달되는 종합경영정보시스템(Management Information System)을 구축한다. 고객의 정보를 시스템화하여 고객관리를 돕거나, 제품생산공정에서 재료나 자원관리를 할 수 있는 시스템을 설계하고 구현한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"MIS개발자","dJobECd":"1332","dJobECdNm":"[1332]응용 소프트웨어 개발자","dJobJCd":"2223","dJobJCdNm":"[2223]응용 소프트웨어 개발자","dJobICd":"M715","dJobICdNm":"[M715]회사 본부 및 경영 컨설팅 서비스업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003130:1', '{"dJobCd":"K000003130","dJobCdSeq":"1","dJobNm":"고객관계관리시스템전문가","workSum":"고객을 효율적으로 관리하고 유지하기 위한 통합적 고객관계관리시스템을 설계하고 구축을 위한 솔루션을 제공한다.","doWork":"기존의 고객정보 수집·관리방법을 검토하여 효과적인 고객관리방안을 세운다. 고객관리데이터베이스시스템의 구축을 위해 사용자의 요구사항을 파악하고 고객의 정보를 분석하여 시스템을 설계한다. 설계안을 토대로 기업주에게 시스템의 솔루션 개념을 제안하고 자문한다. 시스템을 구축하기 위한 추진일정 및 자원계획을 편성한다. 단위시스템을 개발하고 관련된 시스템에 대한 인터페이스 과정을 통해 시스템을 구축한다. 구축한 시스템에 대해서는 기술적 문서화를 기록·유지토록 한다. 사용자에게 시스템의 운영 및 관리에 대한 교육과 기술적 자문을 한다. 최신 정보기술의 추세 및 동향을 분석하여 정보기술의 변화에 대비한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"CRM(Customer Relationship Management)전문가","certLic":"정보처리기사","dJobECd":"1332","dJobECdNm":"[1332]응용 소프트웨어 개발자","dJobJCd":"2223","dJobJCdNm":"[2223]응용 소프트웨어 개발자","dJobICd":"J620","dJobICdNm":"[J620]컴퓨터 프로그래밍, 시스템 통합 및 관리업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002341:1', '{"dJobCd":"K000002341","dJobCdSeq":"1","dJobNm":"네트워크통신게임개발원","workSum":"인터넷 및 온라인에 실현되는 네트워크게임을 개발한다.","doWork":"서비스기획이나 마케팅부서의 게임기획자의 요구나 비비에스서비스관리원 또는 콘텐츠관리원으로부터 받은 명세서에 따라 보드게임(고스톱, 바둑, 장기, 체스 등), FPS(First-Person Shooter), MMORPG(Massive Multiplayer Online Role Playing Game)와 같은 네트워크 게임을 개발한다. 명세서를 요구부서와 협의하여 조정하고 게임을 설계한다. 개발언어를 이용하여 모듈별 프로토콜(Protocol)을 적절히 개발한다. 시범서비스(α-Test)를 하고 보완하여 출시한다. 관련된 국내의 게임인프라(단위게임)를 모아 여러 이용자가 동시에 네트워크 게임이 가능하도록 한다. 대기실, 대화실 등 매치메이킹(Match Making)이 가능하도록 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"제어조작","connectJob":"네트워크게임인프라기획원","certLic":"게임프로그래밍전문가","dJobECd":"1332","dJobECdNm":"[1332]응용 소프트웨어 개발자","dJobJCd":"2223","dJobJCdNm":"[2223]응용 소프트웨어 개발자","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002079:1', '{"dJobCd":"K000002079","dJobCdSeq":"1","dJobNm":"디지털영상처리시스템개발자","workSum":"컴퓨터를 이용한 영상분석, 영상인식, 영상복원 및 영상통신 등에 관련된 시스템을 개발한다.","doWork":"디지털영상에 관한 신기술동향을 파악하고 연구한다. 카메라, 스캐너, 인터넷 등에서 디지털이미지를 획득한다. 여러가지로 분리되어 있는 영상을 목적에 맞게 개선하는 영상조작, 글자, 그림, 영상 등을 분석하는 영상분석, 물체를 모습 그대로 인식하는 영상인식, 손상된 영상을 복구하는 영상복원, 영상을 저장하거나 압축하여 위성이나 케이블, 네트워크 등으로 전송하는 영상통신에 관련된 시스템을 개발한다. 보안 관련 분야에서 영상인식시스템의 개발과 더불어 CCTV와의 연계를 추구하는 소프트웨어를 개발하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"정보처리기사, 정보통신기사, 전파통신기사, 방송통신기사, 전파전자기사","dJobECd":"1332","dJobECdNm":"[1332]응용 소프트웨어 개발자","dJobJCd":"2223","dJobJCdNm":"[2223]응용 소프트웨어 개발자","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006217:1', '{"dJobCd":"K000006217","dJobCdSeq":"1","dJobNm":"디지털음성처리전문가","workSum":"컴퓨터를 이용한 음성인식, 음성합성 및 음성신호처리 등에 관련된 시스템을 개발한다.","doWork":"음성처리시스템의 사양과 기능을 정하고 개발범위를 설정한다. 음성신호의 분석과 음성처리 알고리즘의 기법에 관한 소프트웨어를 분석·설계한다. 화자종속(정해진 사람의 목소리만을 인식)에 따른 음성신호의 특성을 분석하여 음성인식에 관련된 다양한 응용제품을 설계하고 개발한다. 음성합성 알고리즘을 적용하여 음성합성시스템에 관련된 다양한 응용제품을 설계하고 개발한다. 음성통신에 관련된 음성부호화, 압축과 복원, 전송 등에 관련된 하드웨어 및 소프트웨어를 설계하고 개발한다. 소프트웨어를 하드웨어에 이식·설치해서 시스템의 기능과 요구사항에 만족되는가를 종합적으로 시험·평가한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"정보처리기사","dJobECd":"1332","dJobECdNm":"[1332]응용 소프트웨어 개발자","dJobJCd":"2223","dJobJCdNm":"[2223]응용 소프트웨어 개발자","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006695:1', '{"dJobCd":"K000006695","dJobCdSeq":"1","dJobNm":"모바일프로그래머","workSum":"모바일기기에서 사용되는 프로그램을 개발하고 유지보수한다.","doWork":"PDA, 스마트폰 등 모바일기기들에서 사용되는 프로그램을 개발한다. Palm, Windows, iOS, Android, Bada, Symbian 등 사용되어질 모바일 운영체제에 맞는 개발툴을 사용한다. 소규모 개발의 경우 기획, 설계, 개발, 테스트 및 유지보수작업 등을 담당한다. 회사 또는 개인의 의뢰를 받아 개발하기도 하며, 모바일마켓에 등록하여 판매하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"제어조작","connectJob":"모바일게임개발전문가, 모바일콘텐츠개발자","certLic":"정보처리기사","dJobECd":"1332","dJobECdNm":"[1332]응용 소프트웨어 개발자","dJobJCd":"2223","dJobJCdNm":"[2223]응용 소프트웨어 개발자","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005085:1', '{"dJobCd":"K000005085","dJobCdSeq":"1","dJobNm":"반도체장비자동화소프트웨어개발자","workSum":"반도체장비 자동화, 통신국제표준, 고객 요구기준을 이해하고, 장비주요부, 유틸리티 및 진단분석장치의 운영정보를 호스트와 주고받기 위한 자동화소프트웨어를 연구·개발한다.","doWork":"반도체장비 구성장치의 사양서와 사용자매뉴얼, 주요부와 유틸리티장치의 Motion, 디지털, 아날로그 I/O(Input/Output)제어, 전기적 신호처리(Ethernet:Device Net 통신), 각 장치의 데이터, 전기시스템, 신호필터링 및 알고리즘을 이해하고 이해·응용한다. 장비주요부, 유틸리티 및 진단분석과 호스트 간 통신소프트웨어 사양을 결정하여 순서배치를 구성한다. 개별소프트웨어 코딩 및 입력작업을 진행하고, 시뮬레이션을 블록, 전체별로 진행한 다음, 디버깅, 수정작업 및 개선을 반복한다. 장비구성 및 운영에 필요한 반도체 장비통신표준을 이해하고, 일괄제어현황관리 소프트웨어(CIM:Computer Integrated Manufacturing)을 활용한다. 통신표준 제어프로토콜(SECS 1, 2, GEM, HSMS 등)을 이해하고, 장비운영 소프트웨어에 활용할 수 있으며, 장비제어 통신표준에 따라 반도체 제조공정과정과 결과를 소프트웨어로 표현하며, 생산과정에서 발생하는 불규칙한 데이터를 정형화하여 안정화된 양산분석 소프트웨어를 개발한다. 장비시험평가, 현장설치·평가·검증을 통해 자동화·통신소프트웨어설계 오류분석 및 개선을 지원한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 프로그램을 기반으로 다양한 부품 및 장치기술을 시험평가하고, 최적화하는 연구·개발활동을 단독 또는 공동으로 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"반도체장비연구원","connectJob":"반도체장비설계연구원, 반도체장비소프트웨어연구원, 반도체장비통신소트프웨어연구원","dJobECd":"1332","dJobECdNm":"[1332]응용 소프트웨어 개발자","dJobJCd":"2223","dJobJCdNm":"[2223]응용 소프트웨어 개발자","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005102:1', '{"dJobCd":"K000005102","dJobCdSeq":"1","dJobNm":"블록체인개발자","workSum":"블록체인 원리, 개념 및 방법을 적용하여 금융, 결제, 운송 등 각종 정보시스템을 연구하고 개발한다.","doWork":"블록체인 기반 기술을 연구하고 관련 애플리케이션을 개발한다. 블록체인 플랫폼을 연구·개발한다. API 및 인터페이스를 개발한다. 네트워크 내의 노드들의 상호검증을 통해 블록생성을 이끌어내는 프로세스와 알고리즘을 나타내는 컨센서스(합의) 엔진을 개발하고 연구한다. 블록체인 기반의 기술지원 및 프로젝트를 수행한다. 블록체인 기반의 다양한 정보시스템을 개발한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"1332","dJobECdNm":"[1332]응용 소프트웨어 개발자","dJobJCd":"2223","dJobJCdNm":"[2223]응용 소프트웨어 개발자","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006238:1', '{"dJobCd":"K000006238","dJobCdSeq":"1","dJobNm":"소프트웨어정의네트워크개발자","workSum":"소프트웨어정의네트워크 관련 데이터센터를 구축·운영·유지보수한다.","doWork":"라우터나 스위치 등 하드웨어에 의존하는 네트워크 체계에서 속도, 안정성, 에너지효율, 보안 등을 소프트웨어로 제어관리하기 위한 소프트웨어정의네트워크(SDN:Software Defined Networks)를 개발한다. 네트워크인프라의 규모 운영방식에 따라 데이터센터를 구축하고 운영한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"1332","dJobECdNm":"[1332]응용 소프트웨어 개발자","dJobJCd":"2223","dJobJCdNm":"[2223]응용 소프트웨어 개발자","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002221:1', '{"dJobCd":"K000002221","dJobCdSeq":"1","dJobNm":"수자원시스템연구원","workSum":"수자원의 개발 및 관리, 자연재해대응 등을 위한 수자원통합관리시스템 구축을 위한 전산프로그램을 개발한다.","doWork":"댐 정보처리와 수질감시체계를 통한 실시간자료를 수집하고 전산시스템을 구축한다. 지형정보시스템(GIS:Geographic Information System)을 이용한 공간적 수치자료의 처리 및 분석을 통하여 수자원연구에 응용한다. 하천유량 자동측정설비를 통한 강우유출모형, 최적 저수지 운영 및 유역물배분모형을 개발한다. 홍수 및 가뭄관리정보시스템을 구축하여 재해관리기술을 연구한다. 댐 유역 간 토사유실량을 비교·분석하여 수문순환해석기술을 개발한다. 기타 연구원(일반)들이 수행하는 일반적인 활동을 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"토목기사, 측량 및 지형공간정보기사","dJobECd":"1332","dJobECdNm":"[1332]응용 소프트웨어 개발자","dJobJCd":"2223","dJobJCdNm":"[2223]응용 소프트웨어 개발자","dJobICd":"E360","dJobICdNm":"[E360]수도업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002346:1', '{"dJobCd":"K000002346","dJobCdSeq":"1","dJobNm":"애플리케이션엔지니어","workSum":"고객의 요구에 적합한 애플리케이션을 개발하고 유지·관리한다.","doWork":"새로운 애플리케이션시스템 개발 혹은 기존 애플리케이션시스템의 개선을 위한 업무분석 및 설계업무에 참여한다. 애플리케이션의 성능을 검사하고 실행시간을 개선한다. 사용자와의 창구역할을 수행한다. 회사에서 추천하는 방법론에 기초하여 고객의 요구사항을 수집·분석하고 문제점 및 대책을 확인·지원한다. 새로운 애플리케이션시스템 개발이나 기존 애플리케이션시스템의 개선을 위해 문제점을 찾고 개선한다. 개발된 애플리케이션시스템에 필요한 사용자교육, 장비, 하드웨어, 소프트웨어의 설치 또는 전환작업을 주도한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"애플리케이션개발자, 애플리케이션개발자, 앱개발자","connectJob":"스마트폰애플리케이션개발자(앱개발자), 모바일콘텐츠개발자, 안드로이드앱개발자, IOS앱개발자","dJobECd":"1332","dJobECdNm":"[1332]응용 소프트웨어 개발자","dJobJCd":"2223","dJobJCdNm":"[2223]응용 소프트웨어 개발자","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002520:1', '{"dJobCd":"K000002520","dJobCdSeq":"1","dJobNm":"응용소프트웨어엔지니어","workSum":"각종 응용분야의 컴퓨터소프트웨어를 설계하고 개발한다.","doWork":"응용소프트웨어의 개발범위와 목표를 설정한다. 소프트웨어를 개발·완성시키기 위한 전체적인 개발계획과 자원조달계획을 편성한다. 응용시스템에 대한 정보보호의 방법과 계획을 설정한다. 소프트웨어의 세부적인 기능 및 사양에 관한 상세설계를 한다. 상세설계에 따라서 단위프로그램을 개발하고, 개발된 여러 프로그램들을 모아서 응용시스템으로 결합시킨다. 해당 컴퓨터시스템에 설치하고 기능 및 성능을 종합적으로 평가·분석한다. 패키지성의 개발소프트웨어에 대해서는 체계적인 버전관리를 한다. 테스트를 통해 버그를 수정한다. 응용소프트웨어에 대한 사용자의 운영교육과 기술을 지원한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"응용소프트웨어개발자","connectJob":"응용소프트웨어프로그래머, C프로그래머, 자바프로그래머","certLic":"정보처리기사, 전자계산기조직응용기사","dJobECd":"1332","dJobECdNm":"[1332]응용 소프트웨어 개발자","dJobJCd":"2223","dJobJCdNm":"[2223]응용 소프트웨어 개발자","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002565:1', '{"dJobCd":"K000002565","dJobCdSeq":"1","dJobNm":"이동통신단말애플리케이션개발자","workSum":"이동통신 단말의 각종 애플리케이션(게임 애플리케이션, PIMS(개인정보관리시스템:Personal Information Management System) 및 DB 애플리케이션, 브라우저, Location-Based 애플리케이션(위치기반 애플리케이션), 멀티미디어 애플리케이션, JAVA 애플리케이션, 메시징 및 이메일 애플리케이션 등)을 개발하고 검증한다.","doWork":"이동통신단말의 기능, 요구조건, 제약사항(그래픽전용 프로세서의 존재 유무, 화면사양, 데이터통신서비스의 대역폭, 기타단말기자원의 제약 등)을 분석하고 개발할 애플리케이션의 목표기능을 정의한다. 게임 애플리케이션을 개발하는 경우 단말의 실행메모리, 실행속도, 코드사이즈의 최적화를 고려하고 터치, 근접센서, 가속도센서 등을 활용한 게임 애플리케이션을 소프트웨어 에뮬레이터, 리소스 에디터, 이벤트 제너레이터, 컴파일러, 단말시료 및 참조하드웨어, 하드웨어 디버깅(Debugging:오류 수정)장비 등을 이용해 개발하고 검증한다. PIMS(개인정보관리시스템:Personal Information Management System) 및 DB 애플리케이션을 개발하는 경우 주소록, 폰북, 캘린더, 일정관리, 명함관리 등 개발할 기능을 정의하고 이동통신을 통한 데이터 동기화 및 전송기술, PC동기화에 의한 데이터 관리, 데이터와 웹서비스와의 연동기술을 응용하여 개발한다. 메모리 및 스토리지 사용의 최적화, 데이터의 상호배제 접근 및 무결성 처리방안, 사용자 편의성을 검증한다. 단말 브라우저를 개발하는 경우 이동통신망, 사업자표준, WAP 및 HTTP, 단말기 종류(피처폰, 스마트폰) 등을 고려하여 C, C++ 및 객체지향 프로그래밍, TCP/IP 데이터 통신처리 및 소켓 프로그래밍, 이동통신망에서 브라우저 처리 프로그래밍, 플랫폼의 시스템 콜 처리 및 시스템 수준 API(Application Programming Interface)와의 연동기술을 응용하여 개발하고 에뮬레이터, 망 연동을 통해 검증한다. Location-Based 애플리케이션(위치기반 애플리케이션)을 개발하는 경우 이동통신망에서의 데이터 서비스, GPS데이터 수신 및 위치인식 기술, GPS데이터와 맵 연동기술을 응용하여 개발하고 GPS통신을 통해 검증한다. 멀티미디어 애플리케이션을 개발하는 경우 멀티미디어 코덱, 이동통신 서비스가 가능한 멀티미디어의 응용특성 및 제약사항, 모바일 방송서비스의 특성 등을 고려하고 멀티미디어 코덱 API 및 멀티미디어 프레임웍, 멀티미디어 가속칩, VOD서비스 및 모바일 방송서비스 기술을 응용하여 개발한다. 에뮬레이터(Emulator:어떤 하드웨어나 소프트웨어의 기능을 다른 종류의 하드웨어나 소프트웨어로 모방하여 실현시키기 위한 장치나 프로그램) 및 망연동을 통해 검증한다. 각종 애플리케이션의 개발이 완료되면 소스코드, 기능명세서, 검증방법 및 세부설계사양서를 작성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"1332","dJobECdNm":"[1332]응용 소프트웨어 개발자","dJobJCd":"2223","dJobJCdNm":"[2223]응용 소프트웨어 개발자","dJobICd":"C264","dJobICdNm":"[C264]통신 및 방송 장비 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007785:1', '{"dJobCd":"K000007785","dJobCdSeq":"1","dJobNm":"인공지능모델개발자","workSum":"기획된 인공지능 서비스의 목적을 달성하기 위하여 모델 설계 및 검증, 학습 데이터 확보, 데이터 가공, 특징 추출, 품질 검증, 학습 등을 통해 최적화된 모델을 도출하고 성능을 개선한다.","doWork":"인공지능 서비스를 위한 모델링 목표를 설정하고 요구 사항을 분석하여 해결 가능한 인공지능 후보 모델을 도출한다. 도출된 후보 모델을 기반으로 세부적인 모델을 설계하고 검증한다. 인공지능 모델에 필요한 데이터 수집 방안을 계획하고 데이터를 수집한다. 확보된 데이터를 정제, 변환, 통합, 축소, 라벨링, 비식별화를 통해 데이터를 가공한다. 모델의 성능을 높이기 위하여 도메인 지식을 활용하여 객체의 특징을 발견하고 학습에 필요한 주요 특징을 선택한다. 데이터 품질 기준을 정의, 품질 검증 프로세스 수립을 통해 인공지능 품질을 개선한다. 인공지능 문제를 해결하기 위하여 준비된 모델을 학습시키고 그 결과를 검증한다. 인공지능 최적화를 위하여 평가기준을 결정하고, 모델 선정 기준을 결정한 뒤, 이해당사자의 피드백을 고려하여 최적의 모델을 선정한다. 선정된 모델의 구성요소, 배포를 관리하고 서비스에 적용된 모델의 성능을 관리하여 개선한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"데이터분석전문가, 데이터분석준전문가, 데이터아키텍처전문가, 데이터아키텍처준전문가, 정보관리기술사, 정보처리기사, 컴퓨터시스템응용기술사, 빅데이터분석기사","dJobECd":"1332","dJobECdNm":"[1332]응용 소프트웨어 개발자","dJobJCd":"2223","dJobJCdNm":"[2223]응용 소프트웨어 개발자","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2025"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001708:1', '{"dJobCd":"K000001708","dJobCdSeq":"1","dJobNm":"인공지능엔지니어","workSum":"기계 스스로 데이터를 기반으로 학습하여 인식, 추론, 판단, 분류, 예측할 수 있도록 최적의 학습모델(알고리즘)을 구현한다.","doWork":"인식, 추론, 판단, 분류, 예측 등 활용 목적에 맞춰 연관성 있는 데이터를 수집하고 연관성 등을 분석한다. 효율성을 높일 수 있는 방법론(알고리즘)을 활용하여 문제해결을 위한 학습모델을 구현하고 파이썬, Java 등을 활용하여 시스템으로 구현한다. 학습수준을 평가하는 등 정확도 개선을 위한 모델 최적화 작업을 한다. 실제 서비스 단계의 시스템을 구축하기도 한다. 자연어 처리를 통한 텍스트 분석 기술을 개발하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"제어조작","connectJob":"머신러닝엔지니어, 딥러닝엔지니어","dJobECd":"1332","dJobECdNm":"[1332]응용 소프트웨어 개발자","dJobJCd":"2223","dJobJCdNm":"[2223]응용 소프트웨어 개발자","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001496:1', '{"dJobCd":"K000001496","dJobCdSeq":"1","dJobNm":"인공지능연구원","workSum":"인간과 컴퓨터의 상호작용을 증진하는 데 필요한 지능형정보처리시스템을 연구·개발한다.","doWork":"신경망, 지식베이스시스템, 퍼지이론(Fuzzy Theory:애매하고 불분명한 상황에서 여러 문제들을 두뇌가 판단 결정하는 과정에 대하여 수학적으로 접근하려는 이론) 등에 관한 연구를 수행한다. 자연어처리, 패턴인식 등과 같은 시각정보처리, 음성정보처리에 관련된 소프트웨어를 연구한다. C, C++, 자바, 델파이, 파워빌더 등을 사용하여 시스템을 개발한다. 테스트를 통해 오류가 발견되면 수정 및 보완작업을 실시한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"1332","dJobECdNm":"[1332]응용 소프트웨어 개발자","dJobJCd":"2223","dJobJCdNm":"[2223]응용 소프트웨어 개발자","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004358:1', '{"dJobCd":"K000004358","dJobCdSeq":"1","dJobNm":"인공지능플랫폼설계개발전문가","workSum":"인공지능 플랫폼을 설계 및 개발한다.","doWork":"딥러닝, 기계학습 등 전문지식을 바탕으로 인공지능개발자들이 사용할 수 있는 인공지능 플랫폼을 설계하고 개발한다. 클라우드시스템을 활용하여 효율적인 플랫폼을 개발한다. 고객의 요구사항을 적용하기 위한 설계 및 테스트를 진행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"1332","dJobECdNm":"[1332]응용 소프트웨어 개발자","dJobJCd":"2223","dJobJCdNm":"[2223]응용 소프트웨어 개발자","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001319:1', '{"dJobCd":"K000001319","dJobCdSeq":"1","dJobNm":"증강현실전문가","workSum":"모니터나 스크린, 스마트폰의 액정 등의 화면을 통해 현실세계에 각종 정보 및 가상현실을 합성하는 증강현실시스템을 개발한다.","doWork":"원격의료진단, 제조공정관리 및 스마트폰애플리케이션 등 사용자가 원하는 정보에 따른 증강현실시스템을 파악하고 각종 정보를 수집한다. 개발방향을 설정한다. 신제품에 대한 기획안을 만든다. 시스템에 적용할 알고리즘을 개발한다. 개발된 알고리즘을 응용하고 영상처리기술을 기반으로 증강되어 나타나게 할 객체를 안정적이고 정확하게 표현해내는 시스템을 개발한다. 시스템이 개발되면 테스트, 통합, 통합프로그램의 최적화작업 등을 거쳐 시스템을 완성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"AR전문가, 혼합현실전문가","certLic":"컴퓨터그래픽스운용기능사, 시각디자인기사","dJobECd":"1332","dJobECdNm":"[1332]응용 소프트웨어 개발자","dJobJCd":"2223","dJobJCdNm":"[2223]응용 소프트웨어 개발자","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004744:1', '{"dJobCd":"K000004744","dJobCdSeq":"1","dJobNm":"지식관리시스템전문가","workSum":"개인 및 조직원이 소유하고 있는 지적자산을 조직 내에 축적·활용할 수 있도록 하는 지식관리시스템을 설계하고 구축에 관한 솔루션을 제공한다.","doWork":"기존의 유관시스템(전자문서관리시스템, 인트라넷, 데이터베이스관리시스템 등)을 분석하고, 지식관리시스템(KMS:Knowledge Management System) 구축을 위한 사용자의 요구사항을 파악한다. 내·외부 환경분석을 통하여 기본전략을 수립한다. 관련 정보 수집방안과 수집된 정보에 대한 효과적인 관리방안을 설정한다. 기본구조를 설계하고 어떤 정보기술을 도입할 것인지, 패키지를 사용할 것인지의 여부를 결정한다. 조직차원의 인프라와 통신네트워크, 하드웨어의 조달과 소프트웨어의 개발 등을 포함한 전체적인 추진일정 및 자원계획을 편성한다. 설계안을 토대로 기업주에게 시스템의 솔루션 개념을 제안하고 자문한다. 시스템의 사양을 정하고 세부적으로 시스템을 설계한다. 단위시스템을 개발하고 관련된 시스템에 대한 인터페이스 과정을 통해 시스템을 구축한다. 사용자에게 시스템의 운영 및 관리에 대한 교육과 기술적 자문을 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"KMS(Knowledge Management System)전문가","certLic":"정보처리기사","dJobECd":"1332","dJobECdNm":"[1332]응용 소프트웨어 개발자","dJobJCd":"2223","dJobJCdNm":"[2223]응용 소프트웨어 개발자","dJobICd":"J620","dJobICdNm":"[J620]컴퓨터 프로그래밍, 시스템 통합 및 관리업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007291:1', '{"dJobCd":"K000007291","dJobCdSeq":"1","dJobNm":"프로젝트게임엔진개발자","workSum":"게임 개발에 전반적인 영향을 미치는 핵심 도구와 같은 역할을 하는 소프트웨어를 내부 개발 프로젝트 구성원에게 제공하거나 툴 자체를 타 기업에 상업적인 목적성을 띄고 개발하여 제공한다.","doWork":"프로젝트 필요 유무에 따른 기능 구현 및 관련 리소스 최적화를 상시 진행한다. 게임 엔진에서 제공하는 기능들에 대한 가이드를 제공하며 구성원들이 원활하게 사용할 수 있도록 개선한다. 게임 개발에 도움이 되는 새로운 기능들을 구성원들 및 프로젝트의 특성에 맞게 개발하여 재배포한다. 개발언어를 적극 활용하여 개발하되 코드 리뷰 및 프로세스 개선 등을 진행하고 안정성 및 게임 제작의 생산성을 높이는 업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"게임프로그래밍전문가, 정보보안산업기사, 정보보안기사, 정보처리기사","dJobECd":"1332","dJobECdNm":"[1332]응용 소프트웨어 개발자","dJobJCd":"2223","dJobJCdNm":"[2223]응용 소프트웨어 개발자","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005790:1', '{"dJobCd":"K000005790","dJobCdSeq":"1","dJobNm":"휴대폰UI/UX소프트웨어개발자","workSum":"기획된 UI/UX를 구현하기 위해 휴대폰UI/UX소프트웨어를 개발하고 관리한다.","doWork":"기획된 휴대폰 콘셉트와 UI/UX를 바탕으로 디자인을 고려한 콘텐츠와 정보, 프레임과 태스크플로우를 설계한다. UI/UX설계산출물과 GUI디자인가이드를 바탕으로 UI/UX구현 표준을 수립하고 이를 개발한다. 편리한 휴대폰의 사용자인터페이스를 구현하기 위하여 분석된 사용자의 요구사항과 하드웨어 특성을 고려하고 UI/UX의 기능을 구현한다. 제품사양에 따른 UI/UX를 분석하여 개발을 위한 상세시나리오에 따라 UI/UX 상세기능을 개발한다. UI/UX를 검증하기 위하여 사용성테스트를 계획하고 수행한다. 수행한 자료와 정보를 분석하여 결과에 대해 보완점을 찾아 수정하여 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"1332","dJobECdNm":"[1332]응용 소프트웨어 개발자","dJobJCd":"2223","dJobJCdNm":"[2223]응용 소프트웨어 개발자","dJobICd":"C264","dJobICdNm":"[C264]통신 및 방송 장비 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004929:1', '{"dJobCd":"K000004929","dJobCdSeq":"1","dJobNm":"휴대폰응용소프트웨어개발자","workSum":"휴대폰 응용소프트웨어의 기능요구사항을 반영하여 응용소프트웨어를 개발하고 관리한다.","doWork":"휴대폰 응용소프트웨어의 기능을 정의하고, 제약사항과 선행기술을 분석한다. 응용소프트웨어 기능요구사항을 기반으로 응용소프트웨어의 구조와 기능, 데이터베이스를 설계한다. 관련된 응용소프트웨어의 상세설계서를 작성한다. 라이브러리 포팅, 단위모듈개발, 오류수정 등을 통해서 휴대폰에서 동작하는 응용소프트웨어를 개발한다. 개발된 응용소프트웨어를 테스트하여 성능을 검사한다. 필요한 인증획득에 필요한 자료와 시료를 준비하고 관련 테스트를 수행하여 인증을 획득한다. 요구사항기능서와 UI/UX설계 등을 기반으로 사용자설명서를 작성하고 응용소프트웨어의 버전을 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"1332","dJobECdNm":"[1332]응용 소프트웨어 개발자","dJobJCd":"2223","dJobJCdNm":"[2223]응용 소프트웨어 개발자","dJobICd":"C264","dJobICdNm":"[C264]통신 및 방송 장비 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007438:1', '{"dJobCd":"K000007438","dJobCdSeq":"1","dJobNm":"VR·AR게임기획자","workSum":"이용자가 실제 세계와 유사한 느낌을 갖도록 3차원 컴퓨터그래픽스, 3차원 오디오, 촉감(Haptic) 등의 기술을 이용해 가상현실시스템을 기획하고 세계관, 캐릭터 디자인, 스토리텔링, 메타버스 등의 연구를 통하여 콘텐츠를 개발한다.","doWork":"사용자가 원하는 게임이나 가상세계가 무엇인지 파악하고 개발하고자 하는 시스템을 분석하여 개발 방향 설정한다. 디자인, 개발, 사운드, 장치, 시나리오, 사업화 등 실감형 게임 제작을 총괄한다. VR·AR게임의 세계관, 캐릭터, 갈등 등을 이용하여 콘텐츠를 구체화하고 진행에 필요한 대사, 설명 등 시나리오를 기획한다. 콘텐츠에서 사용될 규칙들을 정의하여 프로그래머들이 시스템을 구축할 수 있도록 문서화한다. 그래픽디자이너가 모델링한 사물과 캐릭터, 음성과 배경음악, 효과음들을 3차원 가상공간에 배치하며 사용자가 체험할 VR 세계의 시나리오와 시스템에 적용하고 게임 난이도를 조정하는 밸런스디자인을 총괄한다. 제작된 3차원 가상현실 소프트웨어의 기획 의도와 다른 오류는 없는지 테스트하고 수정작업을 거쳐 제품을 최적화하는 과정을 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"제어조작","similarNm":"VR·AR게임프로듀서","connectJob":"가상현실전문가, 증강현실전문가","certLic":"게임기획전문가","dJobECd":"1333","dJobECdNm":"[1333]웹 개발자","dJobJCd":"2224","dJobJCdNm":"[2224]웹 개발자","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004290:1', '{"dJobCd":"K000004290","dJobCdSeq":"1","dJobNm":"게임QA전문가","workSum":"사용자의 게임플레이로 얻을 수 있는 만족도를 최대화할 수 있도록 제작 중이거나 완성한 게임을 분석하여 게임기획 내용을 적절하게 반영할 수 있도록 제안하고 수정한다.","doWork":"제작 중이거나 완성한 게임을 플레이하고 분석하여 게임의 시스템, 레벨 등의 콘텐츠가 적절하게 구성되었는지를 파악한다. 게임기획 내용을 바탕으로 시스템에 발생할 수 있는 문제점을 파악하고 목록화한다. 목록화한 문제점을 점검하여 실제문제가 발생했는지를 확인하고 보고하며, 개선점을 제시한다. 기획내용을 바탕으로 레벨디자인, 밸런스디자인에서의 방향성을 이해하고, 테스트를 위한 계획을 작성하여 실제 테스트를 진행한다. 레벨, 밸런스디자인의 문제점을 이해하고 개선사항을 정리하여 제작팀에 전달한다. 작성된 게임의 로그데이터의 내용을 이해하고, 구체적인 문제점을 파악하여 게임개발에 반영한다. 수정된 내용을 확인하여 적절하게 수정되고 적용되었는지 파악한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"게임QA, 게임품질전문가","connectJob":"모바일게임QA전문가","dJobECd":"1333","dJobECdNm":"[1333]웹 개발자","dJobJCd":"2224","dJobJCdNm":"[2224]웹 개발자","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003342:1', '{"dJobCd":"K000003342","dJobCdSeq":"1","dJobNm":"게임기획자","workSum":"컴퓨터게임의 아이템과 스토리, 캐릭터 등을 구성 및 기획하고 제작과정을 관리한다.","doWork":"게임시장과 게임사용자의 동향을 조사하고 적합한 게임아이템을 찾는다. 게임구현의 가능성과 사업을 분석하여 게임의 내용과 난이도, 대상연령층, 시스템 사양, 그래픽 수준 등을 포함한 기획안을 작성한다. 게임의 규칙 등 관련 세부사항을 결정한다. 스토리라인을 정하고 캐릭터의 일대기를 작성한다. 지형, 몬스터배치 및 디자인, 퀘스트(Quest:롤플레잉게임에서 주인공이 하달받는 임무) 등 게임을 구성하는 요소를 결정한다. 게임사용자가 게임 내의 정보를 쉽게 습득할 수 있는 인터페이스(Interface:서로 다른 시스템을 연결해주는 메뉴창, 설정창 등)를 제작한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"게임프로듀서","connectJob":"대상에 따라 컴퓨터게임기획자, 모바일게임기획자, 아케이드게임기획자, 네트워크게임기획자, 웹게임기획자, 게임레벨기획자","certLic":"게임기획전문가","dJobECd":"1333","dJobECdNm":"[1333]웹 개발자","dJobJCd":"2224","dJobJCdNm":"[2224]웹 개발자","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001443:1', '{"dJobCd":"K000001443","dJobCdSeq":"1","dJobNm":"게임레벨디자이너","workSum":"사용자가 게임플레이를 통해서 핵심욕구를 적절히 충족할 수 있도록 기획목표에 따라 게임의 레벨구조를 분석하고, 레벨의 내용과 요소를 설계하며, 게임밸런스를 기획한다.","doWork":"레벨디자인의 개발에 참고할 수 있도록, 관련된 게임이나 제작 중인 게임의 플레이를 통해서 레벨과 밸런스를 전체적으로 파악하고, 이를 바탕으로 플로우구조를 구성하고, 밸런스수치를 정리하여 해당 레벨기획의 장점과 단점을 분석하여 분석기획서를 작성한다. 게임목표와 방향성을 바탕으로 게임을 진행하는 무대가 되는 여러 레벨을 기획한다. 개발자들과의 협의를 통해서 레벨디자인목표를 설정하고 이를 바탕으로 적합한 넓이, 진행시간, 진행요소를 갖춘 레벨을 디자인한다. 디자인한 레벨에 각 레벨요소를 적절하게 배치하고, 이를 테스트하기 위한 가이드문서를 작성한다. 시스템디자인을 바탕으로 게임밸런스 구성에 필요한 요소의 상관관계를 이해하고 밸런스조정목표를 기획하여, 밸런스 구축을 위한 방향성을 결정하고 이를 테스트할 수 있는 시뮬레이터를 구성한다. 시뮬레이터를 바탕으로 경험치곡선 같은 파라미터의 편동관계를 이해하고 적절한 수치와 함수를 적용한다. 레벨디자인, 밸런스디자인의 목표를 달성하기 위하여 AI패턴과 구조를 기획하고 그에 따른 스테이지의 설계를 진행한다. 제작한 게임의 레벨과 밸런스의 테스트를 통해서 세부적인 레벨, 밸런스디자인을 완성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"제어조작","certLic":"게임기획전문가","dJobECd":"1333","dJobECdNm":"[1333]웹 개발자","dJobJCd":"2224","dJobJCdNm":"[2224]웹 개발자","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001760:1', '{"dJobCd":"K000001760","dJobCdSeq":"1","dJobNm":"게임시스템디자이너","workSum":"사용자의 게임플레이에 필요한 개발작업을 위하여 기획목표에 따라 게임시스템을 분석, 설계하고 구체적인 시스템 구성요소를 구현하며 게임플레이를 위한 화면과 조작기능을 기획한다.","doWork":"게임의 목표와 방향성을 바탕으로 적합한 게임시스템을 가진 콘텐츠를 선정하여, 그 시스템을 전체적으로 파악하고 순서도와 레이아웃, 다이어그램으로 구조를 분석하여 최적화하고 분석기획서를 작성한다. 시스템 분석을 바탕으로 게임제작에 필요한 규칙, 요소, 정보를 포함한 게임시스템을 구상하여 목표와 의도가 명시된 시스템기획서를 작성한다. 게임플레이에 필요한 시스템의 구성요소를 분석하고, 설계방향을 결정하여 다이어그램이나 규칙을 기획하고, 수식을 설계한다. 시스템 설계를 바탕으로 게임에 적용할 시스템 구성요소 내용을 작성하며, 각 요소의 특성을 기획하고 구체적인 수치를 산출한다. 시스템 구성요소 간의 상관관계를 구성하고 시스템 테이블 기준을 결정하며 구성요소별로 테이블 설계를 진행한다.게임플레이에 맞추어 UI의 방향성을 결정하고 화면구조도(레이아웃)를 작성하며 화면에 표시되는 정보배치와 상태, 속성의 상세기획을 진행한다. 게임플레이에 적합한 조작기준을 제안하고, 콘텐츠의 구체적인 조작방법을 구성한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"제어조작","certLic":"게임프로그램밍전문가","dJobECd":"1333","dJobECdNm":"[1333]웹 개발자","dJobJCd":"2224","dJobJCdNm":"[2224]웹 개발자","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2019","etc":"자격/면허 추가"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002027:1', '{"dJobCd":"K000002027","dJobCdSeq":"1","dJobNm":"게임운영자","workSum":"게임을 모니터링하면서 이용자 간의 분쟁시비를 가려주고 이용자들의 고충과 불만사항을 접수해 개발진에게 전달한다.","doWork":"게임과 관련한 고객의 요구사항을 접수하고 해결한다. 유저들의 게임을 분석하며 매출을 예상한다. 방학이나 특정일을 따져 오픈베타의 적정시기를 제안한다. 고객의 불편사항을 바탕으로 수정이 필요한 사항을 관련 부서에 전달한다. 유저들의 게임을 보면서 게임의 특성을 찾아내고 홍보전략에 대한 의견을 제시한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"게임관리자, 게임마스터, 게임매니저, GM","dJobECd":"1333","dJobECdNm":"[1333]웹 개발자","dJobJCd":"2224","dJobJCdNm":"[2224]웹 개발자","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002133:1', '{"dJobCd":"K000002133","dJobCdSeq":"1","dJobNm":"게임월드빌더","workSum":"기획내용을 바탕으로 사용자의 게임플레이에 필요한 레벨디자인 구조를 예술적인 형태로 재구성하고 꾸민다.","doWork":"게임의 방향성과 레벨디자인작업을 바탕으로 배경, 월드제작에 필요한 작업내용을 산출한다. 게임의 개발환경, 게임의 카메라 구성과 화면 구조와 같은 기술적인 사항을 고려하여 게임분위기에 어울리는 라이팅과 각종 효과를 기획한다. 게임에 필요한 타일과 텍스처, 오브젝트, 각종 프랍을 설계하여 제작한다. 게임레벨디자인 구조와 콘셉트디자인을 바탕으로 게임의 지도와 월드의 기본 방향성을 결정한다. 사용자의 시점과 플레이내용을 고려하여 월드디자인을 구성하고 배경그래픽요소를 배치하며, 라이팅과 각종 효과를 적용한다. 적용한 월드디자인을 분석하고 개량한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1333","dJobECdNm":"[1333]웹 개발자","dJobJCd":"2224","dJobJCdNm":"[2224]웹 개발자","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003998:1', '{"dJobCd":"K000003998","dJobCdSeq":"1","dJobNm":"게임콘셉트디자이너","workSum":"사용자가 수행하는 게임플레이의 기본적인 방향성을 설정하고, 게임플레이에 필요한 게임의 세계관과 캐릭터, 배경 등의 요소를 기획한다.","doWork":"게임의 방향성을 바탕으로 다양한 자료를 참고하여 게임의 무대가 되는 시간적 공간을 배경을 설정한다. 게임의 공간적 배경에 따라 게임에서 구현하는 자연·인공환경에 대한 기획서를 작성한다. 게임 내 세계에 대한 역사적 배경과 세계관 속의 규칙, 세계관 요소에 대한 개요를 작성하고, 이를 바탕으로 게임 내의 세계관을 구체화한다. 분위기와 규모를 결정하고, 이에 필요한 스토리타입을 분류하며, 주요 캐릭터와 사건, 요소를 목록화하고 스토리의 방향성을 구체화한다. 캐릭터와 오브젝트 같은 세계 요소의 목록을 작성하고 분류하며 각각의 관계를 설정하며, 이들의 역할과 배경설정을 기획한다. 게임세계관의 지역목록을 정리하고, 지역별 특성을 설정한다. 지역에 필요한 게임진행요소를 설정하고 연결관계를 구성한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"게임기획전문가","dJobECd":"1333","dJobECdNm":"[1333]웹 개발자","dJobJCd":"2224","dJobJCdNm":"[2224]웹 개발자","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2019","etc":"자격/면허 추가"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001330:1', '{"dJobCd":"K000001330","dJobCdSeq":"1","dJobNm":"멀티미디어분석가","workSum":"고객미팅을 통해 고객요구사항 및 일정 등을 검토하고 제작계획을 수립한다.","doWork":"멀티미디어 제작에 사용될 그래픽, 영상, 음향 등의 모듈제작에 참여하거나 통합하고 전체 테스트를 실시한다. 고객중심적 사고, 자료수집 및 분석, 개념화과정 등을 통해 창의적 개념을 추출한다. 고객사업의 특성 및 요구에 맞는 적절한 매체를 결정하고 표준안 및 시안을 제작하고 생산물의 품질을 점검·보완한다. 작업에 필요한 영상, 음향, 이벤트 등의 외주업체 수준 및 단가 등을 검토하여 추천안을 제시한다. 외주 업체와의 공동작업에 참여하거나 조정한다. 검토모임에 참가하고 제기된 문제점에 대한 개선안을 제시하거나 조정·통합한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"1333","dJobECdNm":"[1333]웹 개발자","dJobJCd":"2224","dJobJCdNm":"[2224]웹 개발자","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007075:1', '{"dJobCd":"K000007075","dJobCdSeq":"1","dJobNm":"메타버스게임기획자","workSum":"메타버스를 활용한 게임을 안정적으로 플레이할 수 있는 환경을 제공하기 위해 게임배급사의 운영에 필요한 요소를 정의하고 기획한다.","doWork":"메타버스를 활용한 게임 서비스를 안정적으로 제공하고, 효율적으로 인력을 운용할 수 있도록 운영 도구를 기획한다. 메타버스 서비스 구조 체계 및 서비스 기능들에 대해 정의한다. 운영 환경에서 지원이 필요한 사항에 대해서 개발부서와 소통하고, 게임 서비스에 필요한 요소를 배급사에게 제공한다. 아이템, 퀘스트 등 다양한 게임 콘텐츠 및 템플릿 기획·제작하고 3D 배경 레벨작업 및 오브젝트를 제작한다. 게임 콘텐츠의 내용을 분석하여 이용자 시점의 게임 인사이트를 제공하는 업무와 콘텐츠의 위험성을 사전에 감지하여 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","certLic":"게임프로그래밍전문가","dJobECd":"1333","dJobECdNm":"[1333]웹 개발자","dJobJCd":"2224","dJobJCdNm":"[2224]웹 개발자","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002323:1', '{"dJobCd":"K000002323","dJobCdSeq":"1","dJobNm":"애니메이션기획자","workSum":"애니메이션을 제작하기 위해 작품의 선정부터 제작, 홍보분야까지 전반적인 계획을 수립한다.","doWork":"애니메이션 제작을 위한 관련 자료를 조사하고 시장성이 있는지 검토한다. 주제선정을 위해 아이디어회의를 개최하고, 제작일정 및 상영 시기를 조율한다. 예산을 작성하고, 투자를 유치하며, 제작에 필요한 인력을 구성한다. 애니메이션 시나리오작가 및 애니메이션 감독 등과 협의하여 스토리를 조정한다. 마케팅 및 홍보와 관련하여 계획을 수립한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"1333","dJobECdNm":"[1333]웹 개발자","dJobJCd":"2224","dJobJCdNm":"[2224]웹 개발자","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007412:1', '{"dJobCd":"K000007412","dJobCdSeq":"1","dJobNm":"에이치티엠엘(HTML)코딩원","workSum":"웹디자인을 웹문서로 구현하기 위하여 HTML(Hypertext Markup Language:웹문서를 만들기 위하여 사용하는 기본적인 프로그래밍 언어의 한 종류) 코딩을 한다.","doWork":"구현할 홈페이지의 디자인, 구조, 기능 등을 파악한다. HTML(Hypertext Markup Language:웹문서를 만들기 위하여 사용하는 기본적인 프로그래밍 언어의 한 종류) 에디터를 사용하여 디자인을 웹문서로 구현하는 코딩작업을 한다. 홈페이지의 디자인 및 기능이 브라우저에서 이상없이 구현되는지 테스트하고 태그(Tag:문서의 글자크기, 글자색, 글자모양, 그래픽, 하이퍼링크 등을 정의하는 명령어)를 수정하여 완성한다. HTML 국제표준을 준수하여 다양한 웹브라우저에서 홈페이지가 정상적으로 작동되도록 한다. 웹접근성지침(Web Content Accessibility Guidelines:장애인도 이용 가능하도록 홈페이지 제작상 지켜야 할 제반 규정)을 준수한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"HTML코더, HTML퍼블리셔, 퍼블리셔, 웹코더","dJobECd":"1333","dJobECdNm":"[1333]웹 개발자","dJobJCd":"2224","dJobJCdNm":"[2224]웹 개발자","dJobICd":"J631","dJobICdNm":"[J631]자료처리, 호스팅, 포털 및 기타 인터넷 정보매개 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006438:1', '{"dJobCd":"K000006438","dJobCdSeq":"1","dJobNm":"엔(N)스크린서비스개발자","workSum":"N스크린서비스(하나의 콘텐츠를 스마트폰, PC, 스마트TV, 태블릿PC, 자동차 등 다양한 디지털 정보기기에서 공유할 수 있는 컴퓨팅·네트워크서비스)를 개발한다.","doWork":"UI(User Interface:휴대폰, 컴퓨터, 내비게이션 등 디지털기기를 작동시키는 명령어나 기법을 포함하는 사용자환경), UX(User eXperience:사용자가 어떤 시스템, 제품, 서비스를 직·간접적으로 이용하면서 느끼고 생각하게 되는 지각과 반응, 행동 등의 총체적 경험)를 설계하고 기능명세서를 작성한다. 설계된 인터페이스를 개발자(프론트앤드 엔지니어, 백앤드 엔지니어)에게 전달하여 개발한다. 개발된 인터페이스를 기능명세서에 따라 검증하고 수정·보완한다. 베타서비스의 장애 및 오류, 네트워크트래픽 대응능력, 고객만족도를 측정·조사·분석한다. 서비스 운영, 마케팅, 장애대응인력 등에게 서비스운영매뉴얼을 교육한다. 서비스 개시에 필요한 제반 업무를 진행하여 서비스를 개시한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"N스크린서비스개발자, 엔스크린서비스개발자","dJobECd":"1333","dJobECdNm":"[1333]웹 개발자","dJobJCd":"2224","dJobJCdNm":"[2224]웹 개발자","dJobICd":"J620","dJobICdNm":"[J620]컴퓨터 프로그래밍, 시스템 통합 및 관리업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004174:1', '{"dJobCd":"K000004174","dJobCdSeq":"1","dJobNm":"웹서비스기획원","workSum":"인터넷상의 서비스 구현을 위하여 웹 홈페이지의 내용에 대한 개발을 기획한다.","doWork":"각종 웹 페이지의 검색 및 자료 수집을 통한 기획을 한다. 푸시서비스(Push Service:클라이언트가 설치하여 클라이언트에게 뉴스나 정보를 선택적으로 제공하는 서비스)를 어떤 성격으로 어떻게 제공할 것인가를 기획한다. 홈페이지상의 메뉴인 뉴스, 스포츠, 웹진 등의 콘텐츠 업데이트(Update) 기획을 한다. 부가통신서비스상품의 일부분에 대해 개제할 내용을 기획한다. 웹페이지를 통한 회사홍보서비스 및 홍보를 기획한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"웹기획자","connectJob":"하는 일에 따라 키워드광고전문가, 키워드에디터, 웹사이트테스터, 커뮤니티운영자, 웹광고기획자, 검색기획자","certLic":"인터넷정보검색사","dJobECd":"1333","dJobECdNm":"[1333]웹 개발자","dJobJCd":"2224","dJobJCdNm":"[2224]웹 개발자","dJobICd":"J620","dJobICdNm":"[J620]컴퓨터 프로그래밍, 시스템 통합 및 관리업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003381:1', '{"dJobCd":"K000003381","dJobCdSeq":"1","dJobNm":"웹엔지니어","workSum":"웹서버의 구축 및 최적운영에 대해 기술적인 책임을 진다.","doWork":"컴퓨터시스템의 기반이 되는 하드웨어와 소프트웨어사양을 결정한다. 웹서버를 구축한다. 웹서버에 대한 상태를 점검하고, 튜닝(Tunning) 작업을 한다. 웹서버프로그램, 데이터베이스, 이메일서버 같은 웹서비스 프로그램 간의 연결 및 유지보수를 담당한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"프론트앤드개발자, 백엔드개발자, 풀스택개발자","certLic":"정보처리기사, 전자계산기조직응용기사","dJobECd":"1333","dJobECdNm":"[1333]웹 개발자","dJobJCd":"2224","dJobJCdNm":"[2224]웹 개발자","dJobICd":"J620","dJobICdNm":"[J620]컴퓨터 프로그래밍, 시스템 통합 및 관리업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007016:1', '{"dJobCd":"K000007016","dJobCdSeq":"1","dJobNm":"웹퍼블리셔","workSum":"웹기획자, 웹디자이너, 웹개발자와 협의하여 웹구현 가능성을  타진 및 조언하고 웹브라우저에서 볼 수 있도록 웹 표준, 웹 접근성, 크로스 브라우징, 시멘틱 마크업 원칙에 맞추어  HTML, CSS, Javascript, jQuery등을 활용하여 웹 화면을 구현한다.","doWork":"웹디자이너, 웹기획자 등과 기획서의 구현가능성, 웹디자인의 적절성 등에 대해 논의하고 조언한다. 웹디자이너가 디자인한 시안을 웹 문서화 언어인 HTML과 웹 페이지를 시각화하는 CSS를 사용하여 웹표준(국제표준화단체인 W3C가 지정한 표준안에 따라 목적과 방법에 맞게 웹페이지를 만드는 것), 웹접근성(장애를 가진 사람뿐만 아니라 장애를 가지지 않은 사람 모두가 정보와 기능에 동등하게 접근할 수 있도록 웹사이트를 제작하는 것), 크로스브라우징(Cross Browsing:어떤 웹브라우저를 써도 화면이 똑같이 나오고, 브라우저에 따라 입력과 사용에 문제가 생기지 않음), 시멘틱마크업(브라우저가 잘 이해할 수 있는 코드를 사용해 의미를 잘 전달하도록 웹문서를 작성하는 것)원칙에 맞추어 제작한다. Javascript, jQuery등을 사용하여 동적인 사이트를 구현하고 작업결과물을 웹프로그래머, 웹기획자 등에게 전달한다. 운영 중인 웹사이트를 점검하여 웹표준, 웹접근성 등에 부합하는지 검토하기도 한다. 필요시 웹디자인 업무도 하거나 데이터를 연결하고 다양한 JS프레임워크 사용, API 등을 사용해 웹퍼블리셔가 넘겨준 문서를 실제로 동작할 수 있도록 정리, 작업해주는 프론트엔드개발자의 역할도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"마크업개발자","connectJob":"프론트엔드개발자","certLic":"정보관리기술사, 정보처리기사, 정보처리산업기사, 웹디자인기능사","dJobECd":"1333","dJobECdNm":"[1333]웹 개발자","dJobJCd":"2224","dJobJCdNm":"[2224]웹 개발자","dJobICd":"J620","dJobICdNm":"[J620]컴퓨터 프로그래밍, 시스템 통합 및 관리업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005999:1', '{"dJobCd":"K000005999","dJobCdSeq":"1","dJobNm":"웹프로그래머","workSum":"웹상에서 각종 자료들을 보여줄 수 있도록 웹프로그래밍 언어를 이용하여 프로그램을 설계하고 작성한다.","doWork":"웹상에 올릴 자료의 성격과 형태에 대한 요구를 파악하고 분석한다. 프로그래밍언어(Php, Asp, Java, Jsp 등)를 이용하여 프로그램을 코딩한다. 웹상에서 테스트한 후 문제점을 확인하고 수정한다. 기존에 개발된 프로그램을 유지 및 보수한다. 웹디자이너와 업무를 협의한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"웹개발자","connectJob":"프로그램에 따라 JAVA프로그래머, JSP프로그래머, ASP프로그래머, PHP프로그래머, XML프로그래머, EJB프로그래머, Servlet프로그래머, Net프로그래머, HTML/DHTML프로그래머, GI/PERL프로그래머","certLic":"정보처리기사","dJobECd":"1333","dJobECdNm":"[1333]웹 개발자","dJobJCd":"2224","dJobJCdNm":"[2224]웹 개발자","dJobICd":"J620","dJobICdNm":"[J620]컴퓨터 프로그래밍, 시스템 통합 및 관리업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003824:1', '{"dJobCd":"K000003824","dJobCdSeq":"1","dJobNm":"웹프로듀서","workSum":"웹서비스 내용에 대한 기획, 웹사이트 구축 및 관리를 위한 기술적 검토, 웹페이지 운영 및 서비스 활성화 마련, 사용자의 요구 반영 등의 업무를 수행한다.","doWork":"웹사이트에서 제공할 구성내용을 기획한다. 웹사이트의 구축을 위해 웹엔지니어, 웹디자이너, 웹프로그래머 등과 업무를 협의한다. 웹사이트의 정보를 갱신한다. 웹사이트의 게시판과 전자우편을 통한 사용자의 요구와 불만사항을 처리한다. 사용자의 성향과 접속현황 등을 분석하여 웹사이트의 구조를 수정·보완하여 개편한다. 웹사이트의 구축을 외부업체에 발주할 시에 외부업체 개발자들과의 의사소통을 통해 사이트 구축목적이 달성될 수 있도록 지속적으로 작업과정과 결과물을 확인한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"웹피디(PD), 웹기획자","connectJob":"CD-ROM관련 일을 하는 경우 CD-ROM프로듀서","certLic":"정보처리기사","dJobECd":"1333","dJobECdNm":"[1333]웹 개발자","dJobJCd":"2224","dJobJCdNm":"[2224]웹 개발자","dJobICd":"J620","dJobICdNm":"[J620]컴퓨터 프로그래밍, 시스템 통합 및 관리업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002587:1', '{"dJobCd":"K000002587","dJobCdSeq":"1","dJobNm":"이스포츠맵제작자","workSum":"컴퓨터게임대회인 이스포츠(E-Sports)에 사용되는 경기 맵을 제작한다.","doWork":"방송국 등의 대회관계자와 맵에 대한 기본적인 방향을 정한다. 맵에서 주로 쓰일 전략이나 경기형태 등에 대해 논의한다. 맵 에디터를 이용하여 맵을 제작한다. 만들어진 맵을 선수들에게 보내어 맵테스트를 한다. 테스트에서 도출된 문제점을 보완한다. 각종 경기 등을 모니터링하며 경기의 흐름을 파악한다. 선수들, 관계자들과 대화를 통해 요구사항을 접수한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"제어조작","similarNm":"E-Sports맵디자이너, E-Sports맵제작자, 이스포츠맵디자이너","dJobECd":"1333","dJobECdNm":"[1333]웹 개발자","dJobJCd":"2224","dJobJCdNm":"[2224]웹 개발자","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001750:1', '{"dJobCd":"K000001750","dJobCdSeq":"1","dJobNm":"인터넷기획원","workSum":"인터넷상의 서비스의 구현을 위하여 웹사이트의 내용을 기획하고 개발한다.","doWork":"각종 웹페이지의 검색 및 자료수집을 통하여 시장조사를 한다. 웹페이지의 메뉴를 기획하고 수정한다. 뉴스나 정보를 어떤 성격으로 어떻게 제공할 것인가를 기획한다. 웹페이지 메뉴(뉴스, 스포츠, 웹진 등의 콘텐츠 등) 업데이트를 기획한다. 상품에 대한 내용물 게시를 기획한다. 웹페이지를 통한 회사홍보를 기획하기도 한다. 웹페이지의 데이터베이스를 관리한다. 회원의 개인정보를 관리하고 개인정보보호 책임자 임무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"웹기획원","connectJob":"전자상거래기획원","dJobECd":"1333","dJobECdNm":"[1333]웹 개발자","dJobJCd":"2224","dJobJCdNm":"[2224]웹 개발자","dJobICd":"J620","dJobICdNm":"[J620]컴퓨터 프로그래밍, 시스템 통합 및 관리업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001734:1', '{"dJobCd":"K000001734","dJobCdSeq":"1","dJobNm":"인터넷복권개발원","workSum":"인터넷복권(전자복권)의 개발계획을 수립하고 인터넷사이트를 통해 복권을 판매하고 관리하는 업무를 수행한다.","doWork":"국내외 인터넷복권(전자복권)제도 및 인터넷복권 상품자료와 정보를 수집하여 국내상황에 적절한 인터넷복권상품을 연구하고 개발한다. 인터넷복권의 도입을 추진하고 인터넷복권사이트를 기획·운영한다. 운영업체를 선정 및 계약하며 대외기관과 업무협의를 통해 발행승인을 추진한다. 신규판매기관을 섭외하고 복권번호를 배정한다. 실물을 관리하고 인터넷복권 판매대금의 결제를 관리한다. 공개된 인터넷통신망의 인터넷복권 보안 및 안전성을 위하여 시스템개발에 참여하고 제안한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"관련없음","workFunc3":"관련없음","similarNm":"전자복권개발자, 인터넷복권개발자, 전자복권개발원","dJobECd":"1333","dJobECdNm":"[1333]웹 개발자","dJobJCd":"2224","dJobJCdNm":"[2224]웹 개발자","dJobICd":"O842","dJobICdNm":"[O842]사회 및 산업정책 행정","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001609:1', '{"dJobCd":"K000001609","dJobCdSeq":"1","dJobNm":"인포그래픽정보기획자","workSum":"인포그래픽 제작을 위해 데이터를 수집하고 표현전략과 방향을 설정한다.","doWork":"대상이 누구인지 정의하고 전달하고자 하는 메시지를 명확하게 확립한다. 목표대상과 메시지에 따라 적합한 디자인 타입을 결정한다. 데이터 토픽에 적합한 흥미로운 데이터를 수집하고, 데이터가 인포그래픽의 목표와 주제의 근거를 제시하는지 체크하며 스토리형으로 데이터를 구성한다. 찾은 데이터들의 출처와 정확성을 점검한다. 설득력 있고 전문적인 원고를 제작한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"1333","dJobECdNm":"[1333]웹 개발자","dJobJCd":"2224","dJobJCdNm":"[2224]웹 개발자","dJobICd":"M732","dJobICdNm":"[M732]전문 디자인업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001477:1', '{"dJobCd":"K000001477","dJobCdSeq":"1","dJobNm":"최적검색엔지니어","workSum":"브랜드 인지도 상승 및 마케팅을 위해 홈페이지 또는 콘텐츠를 검색결과 페이지 상단에 위치할 수 있도록 작업한다.","doWork":"고객사의 브랜드 또는 웹사이트의 페이지가 검색엔진에 잘 노출될 수 있도록 웹사이트의 도메인을 관리한다. 홈페이지의 여러 도메인을 웹페이지의 하위 도메인으로 확장시켜 관리하여 높은 도메인 점수를 받아 검색결과의 상단에 노출될 수 있도록 한다. 사이트맵을 작성하여 검색엔진이 원활하게 크롤링, 인텍싱할 수 있도록 한다. 크롤러의 정보수집을 적절하게 제한하여 검색엔진의 평가에 부정적인 요소를 배제한다. 데이터에 기반하여 검색사용자가 주로 사용하면서 경쟁사와의 경쟁이 적은 키워드 및 트렌드에 맞춘 키워드를 발굴하여 제안한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"설득","workFunc3":"제어조작","similarNm":"SEO엔지니어","dJobECd":"1333","dJobECdNm":"[1333]웹 개발자","dJobJCd":"2224","dJobJCdNm":"[2224]웹 개발자","dJobICd":"J620","dJobICdNm":"[J620]컴퓨터 프로그래밍, 시스템 통합 및 관리업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002689:1', '{"dJobCd":"K000002689","dJobCdSeq":"1","dJobNm":"콘텐츠제공자관리원","workSum":"인터넷 및 각종 통신서비스 정보를 제공하기 위하여 정보제공자(IP:Information Provider) 및 콘텐츠제공자(CP:Contents Provider)를 선정하고 계약을 체결한다.","doWork":"인터넷(Internet)의 웹(Web) 서비스 및 각종 전문잡지 등을 통해 최신정보를 수집한다. 정보제공을 위한 정보제공자 또는 콘텐츠제공자로부터 제안서를 받아 전문분야별 지식에 따라 사업성 및 윤리적 전통성을 검토한다. 제안서가 채택되면 계약을 맺는다. 계약된 자료를 바탕으로 하여 게시판 자료실 등 기본적인 구조에 대한 항목(Directory)을 개발하고 게시판의 각 항목에 대한 기능을 규정하기도 한다. 게시판 제목전환 또는 성격의 변화가 생기면 정보제공자(IP)또는 콘텐츠제공자의 요구에 따라 메뉴를 수정한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"정보제공자관리원","dJobECd":"1333","dJobECdNm":"[1333]웹 개발자","dJobJCd":"2224","dJobJCdNm":"[2224]웹 개발자","dJobICd":"J631","dJobICdNm":"[J631]자료처리, 호스팅, 포털 및 기타 인터넷 정보매개 서비스업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003643:1', '{"dJobCd":"K000003643","dJobCdSeq":"1","dJobNm":"테크니컬아티스트","workSum":"게임기획과 게임환경을 바탕으로 게임그래픽에서의 기술적인 방향성을 결정하고, 이와 관련한 프로그래밍 작업을 구현하고 게임에 적용하여 개발역량을 향상시킨다.","doWork":"게임기획과 플랫폼 등의 게임환경을 바탕으로 리소스한계를 고려하여 그래픽작업에 필요한 기술적인 방향성을 기획하여 결정한다. 이 내용을 바탕으로 그래픽디자인을 위한 작업지침서를 제작하고 개발규약을 설정하고 배포하며 각종 툴을 활용하는 데 도움이 되는 지침을 제작한다. 게임엔진에 대한 이해를 바탕으로 렌더러와 셰이더와 같은 그래픽시스템을 기획하고 제작한다. 그래픽툴과 엔진에 대한 이해를 통해 그래픽과 애니메이션 기능향상을 위한 툴을 제작하고 개량한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"제어조작","connectJob":"TD(Technical Director)","dJobECd":"1333","dJobECdNm":"[1333]웹 개발자","dJobJCd":"2224","dJobJCdNm":"[2224]웹 개발자","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005026:1', '{"dJobCd":"K000005026","dJobCdSeq":"1","dJobNm":"소프트웨어테스터","workSum":"소프트웨어의 정식 출시에 앞서 프로그램을 테스트하여 문제점, 보완점 등을 평가한다.","doWork":"소프트웨어 개발회의에 참석하여 개발하고자 하는 소프트웨어에 대한 정보를 습득한다. 소비자 경향, 최근 소프트웨어 및 관련 기술 경향 등을 파악한다. 소프트웨어테스트 계획을 수립한다. 개발자가 만든 각 모듈(전체 소프트웨어를 구성하는 개개의 프로그램)에 여러가지 상황을 설정하여 테스트한다. 각 모듈의 문제점이나 보완점 등에 대한 리포트를 작성하고 개발자에게 통보한다. 각 모듈의 수정이 끝나면 각 모듈을 통합한 전체 소프트웨어에 대해 이전 버전의 소프트웨어에서 발견된 문제점의 개선 여부, 바이러스에 대한 내성 여부 등을 테스트한다. 자체 테스트가 끝나면, 제품의 성격에 따라 큰 규모의 사업체 관리자를 대상으로 하는 필드테스트나 개인을 대상으로 하는 베타테스트를 실시한다. 이상에서 발견된 문제점과 보완점을 취합하여 개발자에게 수정을 의뢰한다. 그밖에 제품출시 후에 발견되는 문제점을 보완하는 등의 유지보수업무를 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","connectJob":"베타테스터","dJobECd":"1339","dJobECdNm":"[1339]기타 컴퓨터 전문가 및 소프트웨어 전문가","dJobJCd":"2229","dJobJCdNm":"[2229]기타 컴퓨터 시스템 및 소프트웨어 전문가","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;