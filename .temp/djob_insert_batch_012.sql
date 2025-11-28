INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005988:1', '{"dJobCd":"K000005988","dJobCdSeq":"1","dJobNm":"반도체이온주입공정기술자","workSum":"반도체 품질수율 및 생산성 향상을 위해 소자제조 및 장비기술자와 협의하여 이온주입 공정기술을 평가·개선·인증·유지 관리한다.","doWork":"반도체소자 제조, 공정, 장비기술자와 협력하여 이온주입공정 목표를 정의하고, 반도체소자 생산기술에 응용한다. 이온주입 관련 소재, 부품, 시설, 장치, 장비, 공정 기술지식을 기반으로 제조, 공정, 장비기술자와 협력하여 제품생산 순서도를 결정·검증·개선·유지 관리한다. 이온주입 관련 핵심 소재, 부품, 장비를 설치·평가·개선·인증·생산·유지 관리하며, 모든 정보 및 기술을 문서화하여 공유한다. 국내외 이온주입 관련 소재·부품·장비업체로부터 획득한 정보 및 제품을 정기적으로 시험평가·인증·응용하여 원가절감 및 개조개선활동을 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체공정기술자","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004348:1', '{"dJobCd":"K000004348","dJobCdSeq":"1","dJobNm":"반도체이온주입공정연구원","workSum":"반도체 기술로드맵 및 고객 요구성능을 이해·응용하여 소자공정연구원과 함께 차세대 소자배선구조 형성을 위한 이온주입공정을 연구·개발한다.","doWork":"반도체소자공정연구원과 공동으로 이온주입공정 목표를 수립하고, 관련 연구·개발활동을 수행한다. 소자공정연구원을 중심으로 사진현상, 식각, 확산, 박막, 세정 및 연마 공정연구원과 긴밀한 공동 연구를 통해 최적의 이온주입 공정특성을 보유한 소자회로 배선구조 및 특성을 개발한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 다양한 소재, 부품, 공정 및 장비기술을 시험평가하고, 최적화하는 연구·개발활동을 단독 또는 공동으로 수행한다. 이온주입 공정개발과정에는 반도체 생산라인 이관 시 최고의 품질 및 생산성을 고려한 소재, 부품, 공정 및 장비기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체공정연구원","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006878:1', '{"dJobCd":"K000006878","dJobCdSeq":"1","dJobNm":"반도체이온주입장비공정연구원","workSum":"반도체 기술로드맵 및 고객 요구성능을 이해하고, 기구 및 소프트웨어설계연구원과 함께 이온주입장비를 기획, 기초 및 생산 성능평가를 수행하여 최적의 공정·장비기술을 개발한다.","doWork":"반도체장비 기구·소프트웨어설계연구원과 함께 이온화, 가속, 주입량, 이온분산, 공정 모듈 각각의 목표성능을 정의하고, 전체 및 세부구성을 기획한다. 시험장비의 설치 후, 핵심요소기술 중심으로 단독 또는 종합적으로 기초 공정성능평가를 진행한다. 기초평가를 통해 개선이 필요한 부품 및 장치를 선정하여 담당 기구설계연구원에게 신규부품 및 장치개발을 요청한다. 이러한 과정을 반복 진행하여 고객이 요구하는 공정·장비성능목표를 만족하는 이온주입장비를 개발한다. 이온주입장비의 기획, 제작 및 시험평가 결과를 고객과 지속·공유하여 고객사 생산라인에서 공정 및 장비 신뢰성 평가계약을 유도한다. 고객과 계약에 따라 종합품질 및 생산성 검증평가를 실시하여 이온주입장비 인증을 획득한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 다양한 재료, 부품, 장치, 장비 및 공정기술을 시험평가하고, 최적화하는 연구·개발활동을 단독 또는 공동으로 수행한다. 이온주입장비 개발과정에는 경쟁사 대비 비교우위, 반도체 생산라인 기준 공정 및 장비 신뢰성 목표달성을 고려한 재료, 부품, 장치, 장비 및 공정기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체공정연구원","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006522:1', '{"dJobCd":"K000006522","dJobCdSeq":"1","dJobNm":"반도체이온주입장비부분품연구원","workSum":"반도체 기술로드맵 및 고객 요구성능을 이해하고, 이온주입장비에 필요한 부분품을 설계, 기초 및 양산평가를 수행하여 최적의 부분품을 연구·개발한다.","doWork":"반도체 이온주입장비의 기구설계, 소프트웨어설계 및 공정연구원과 공동으로 구상한 기초설계를 기준으로 부분품 기능을 정의하고, 상세사양을 결정한 다음, 최적의 재료, 부품 등을 선정한다. 상세사양 기준으로 선정된 재료, 부품들 중에서 유체, 진동, 열 역학 해석이 필요한 부품들을 분류하고, 각 부품특성에 적합한 해석프로그램을 선정하여 실행한다. 각 부품별 해석결과를 바탕으로 부품 적합성 여부를 판단하며, 부품 재선정 및 해석작업을 반복하여 최종 부분품 사양을 결정한다. 최종 사양을 기준으로 이온주입장비의 기구 및 유틸리티를 고려한 상세설계를 진행하여 도면을 작성한다. 부분품의 조립, 시험성능평가 및 장비회사 현장평가를 통해 발견되는 기구설계 오류분석으로 부분품 설계개선을 지원한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 다양한 재료, 부품기술을 시험평가하고, 최적화하는 연구·개발활동을 단독 또는 공동으로 수행한다. 반도체이온주입장비의 부분품 개발과정에는 부품 조립의 편이성, 제조원가 절감, 공정 및 장비 신뢰성을 보증하는 재료, 부품기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체부품연구원","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002790:1', '{"dJobCd":"K000002790","dJobCdSeq":"1","dJobNm":"반도체장비보드개발자","workSum":"반도체 검사장비의 소자검사 국제표준 및 고객 요구성능을 이해하고, 검사장비에 적합한 부품을 선정하여 회로를 구현하는 보드를 설계한다.","doWork":"반도체 검사장비의 수동 및 능동소자에 대한 사양 및 특성을 파악하고, 적합한 커넥터 및 케이블 사양 및 특성을 근거로 부품을 선정한다. 보드의 전체 및 부품별 입출력 포트를 정의하고, 전체 소비전력을 계산하며, 보드 부품에 대한 레이아웃을 구성하고, 기능별 시뮬레이션을 진행하며, 선정된 부품들을 배치한 다음, 회로를 설계한다. FPGA 소자 특성을 파악하고, 기능별 입출력 핀을 정의한다. FPGA 로직에 사용되는 소자들을 구성하는 전자회로 분석 및 설계를 진행한다. 소스 코딩에 대한 컴파일을 진행한 다음, 완성 FPGA 로직에 대해 다양한 환경에서 시뮬레이션을 진행하여 검증한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 다양한 보드설계 및 검사장비기술을 시험평가하고, 최적화하는 연구·개발활동을 단독 또는 공동으로 수행한다. 보드설계 개발과정에는 검사장비 응용에 따른 최고의 품질 및 생산성 구현을 위한 보드설계 및 소자검사 장비기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체설계연구원","connectJob":"반도체장비보드로직설계연구원","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001714:1', '{"dJobCd":"K000001714","dJobCdSeq":"1","dJobNm":"반도체제품기획관리자","workSum":"반도체 시장변화 및 고객지원을 위해 소자개발비용 산정, 고객 수요분석, 제품성능 분석, 개발목표·일정, 인적·물적 자원운영 등 제반 계획을 수립하여 진행한다.","doWork":"IT기기 고객 요구사항과 진입 시장의 규모를 조사하고, 내부 조사자료, 외부 시장조사기관 분석자료, 공개정보를 통해 개발대상 제품에 대한 시장동향을 분석한 다음, 관련 보고서를 작성·공유한다. 학회, 세미나, 전시회, 논문, 특허 등의 정보를 통해 개발대상 제품의 기술동향을 수집·분석하며, 주요 경쟁사를 조사하고, 경쟁사 제품 성능지침서에 대한 분석을 통해 제품의 핵심기능 및 장단점을 조사하고, 특허 분석을 통해 특허 침해 위험을 분석한다. 시장 및 분석결과에 따라 개발대상 제품의 기능을 정의하고, 개발 가능 여부를 판단하며, 회로설계 연구원과 협의를 통해 개발대상 제품의 기능목표를 수립하고, 관련 명세서를 작성하고, 반도체소자공정연구원과 협의를 통해 개발대상 제품의 품질목표를 수립하고, 관련 명세서를 작성한다. 개발대상 제품 전체개발 기간과 각 단계별 세부 추진일정을 수립하고, 소자공정에 따라 제품 크기를 예측, 생산비용을 계산하며, 개발 단계별 소요 인력, 장비, 도입 IP에 따른 개발 비용을 산출하고, 개발대상 제품의 공정수율을 예측하고, 개발비용 결과와 비교하여 손익분기점을 추정할 수 있다. 개발 전반에 필요한 기술, 인적·물적 자원에 대해 개략적으로 계획을 수립하고, 자사의 보유 기술, 개발환경 분석을 통한 자체 개발역량을 분석하며, 개발 관련 단위기능의 업무를 수행할 수 있는 협력업체를 발굴하고, 협업할 수 있는 기준을 조사하고, 활용 가능한 자원의 운용을 포함한 개발일정을 수립하고, 주요 단계별 점검 계획, 소요비용, 중요 산출물에 따른 부서 간 협업계획을 수립·수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"반도체상품기획 관리자","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003852:1', '{"dJobCd":"K000003852","dJobCdSeq":"1","dJobNm":"반도체칩몰딩공정기술자","workSum":"반도체 품질수율 및 생산성 향상을 위해 조립 및 장비기술자와 협의하여 칩몰딩 공정기술을 평가·개선·인증·유지 관리한다.","doWork":"반도체 조립, 장비기술자와 협력하여 칩몰딩공정 목표를 정의하고, 반도체조립 생산기술에 응용한다. 칩몰딩 관련 소재, 부품, 시설, 장치, 장비, 공정 기술지식을 기반으로 제조, 공정, 장비기술자와 협력하여 제품생산 순서도를 결정·검증·개선·유지 관리한다. 칩몰딩 관련 핵심 소재, 부품, 장비를 설치·평가·개선·인증·유지 관리하며, 모든 정보 및 기술을 문서화하여 공유한다. 국내외 칩몰딩 관련 소재·부품·장비업체로부터 획득한 정보 및 제품을 정기적으로 시험평가·인증·응용하여 원가절감 및 개조개선활동을 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체공정기술자","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003550:1', '{"dJobCd":"K000003550","dJobCdSeq":"1","dJobNm":"반도체칩몰딩공정연구원","workSum":"반도체 조립기술로드맵 및 고객 요구성능을 이해·응용하여 소자공정연구원과 함께 최적의 칩몰딩공정을 연구·개발하여 반도체 조립기술개발을 지원한다.","doWork":"반도체 조립설계 및 소자공정연구원과 칩몰딩공정 목표를 수립하고, 관련 연구·개발활동을 수행한다. 연삭, 절단. 접합, 본딩공정연구원과 긴밀한 협력을 통해 최적의 칩몰딩공정 특성을 보유한 조립기술 및 소자를 개발한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 다양한 칩몰딩 소재, 공정 및 장비기술을 시험평가하고, 최적화하는 연구·개발활동을 단독 또는 공동으로 수행한다. 칩몰딩공정 개발과정에는 반도체 조립라인 이관 시 최고의 품질 및 생산성을 고려한 소재, 공정 및 장비기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체조립연구원","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001313:1', '{"dJobCd":"K000001313","dJobCdSeq":"1","dJobNm":"반도체칩몰딩장비공정연구원","workSum":"반도체 조립기술로드맵 및 고객 요구성능을 이해하고, 기구 및 소프트웨어설계연구원과 함께 칩몰딩장비를 기획, 기초 및 생산 성능평가를 수행하여 최적의 공정·장비기술을 개발한다.","doWork":"반도체장비 기구설계연구원과 함께 이송, 접합 모듈 각각의 목표성능을 정의하고, 전체 및 세부구성을 기획한다. 시험장비의 설치 후, 핵심요소기술 중심으로 단독 또는 종합적으로 기초 공정성능평가를 진행한다. 기초평가를 통해 개선이 필요한 부품 및 장치를 선정하여 담당 기구설계연구원에게 신규부품 및 장치개발을 요청한다. 이러한 과정을 반복 진행하여 고객이 요구하는 공정·장비성능목표를 만족하는 칩몰딩장비를 개발한다. 칩몰딩장비의 기획, 제작 및 시험평가 결과를 고객과 지속·공유하여 고객사 생산라인에서 공정 및 장비 신뢰성 평가계약을 유도한다. 고객과 계약에 따라 종합품질 및 생산성 검증평가를 실시하여 칩몰딩장비 인증을 획득한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 다양한 몰딩 소재, 부품, 장치, 장비 및 공정기술을 시험평가하고, 최적화하는 연구·개발활동을 단독 또는 공동으로 수행한다. 칩몰딩장비 개발과정에는 경쟁사 대비 비교우위, 반도체 생산라인 기준 공정 및 장비 신뢰성 목표달성을 고려한 소재, 부품, 장치, 장비 및 공정기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체공정연구원","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005697:1', '{"dJobCd":"K000005697","dJobCdSeq":"1","dJobNm":"반도체칩몰딩장비부분품연구원","workSum":"반도체 조립기술로드맵 및 고객 요구성능을 이해하고, 칩몰딩장비에 필요한 부분품을 설계, 기초 및 양산평가를 수행하여 최적의 부분품을 연구·개발한다.","doWork":"반도체 칩몰딩장비의 기구설계 및 공정연구원과 공동으로 구상한 기초설계를 기준으로 부분품 기능을 정의하고, 상세사양을 결정한 다음, 최적의 재료, 부품 등을 선정한다. 상세사양 기준으로 선정된 재료, 부품들 중에서 유체, 진동 및 열 역학 해석이 필요한 부품들을 분류하고, 각 부품특성에 적합한 해석프로그램을 선정하여 실행한다. 각 부품별 해석결과를 바탕으로 부품 적합성 여부를 판단하며, 부품 재선정 및 해석작업을 반복하여 최종 부분품 사양을 결정한다. 최종 사양을 기준으로 칩몰딩장비의 기구 및 유틸리티를 고려한 상세설계를 진행하여 도면을 작성한다. 부분품의 조립, 시험성능평가 및 장비회사 현장평가를 통해 발견되는 기구설계 오류분석으로 부분품 설계개선을 지원한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 다양한 재료, 부품기술을 시험평가하고, 최적화하는 연구·개발활동을 단독 또는 공동으로 수행한다. 칩몰딩장비의 부분품 개발과정에는 부품 조립의 편이성, 제조원가 절감, 공정 및 장비 신뢰성을 보증하는 재료, 부품기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체부품연구원","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002938:1', '{"dJobCd":"K000002938","dJobCdSeq":"1","dJobNm":"반도체칩본딩공정기술자","workSum":"반도체 품질수율 및 생산성 향상을 위해 조립 및 장비기술자와 협의하여 칩본딩 공정기술을 평가·개선·인증·유지 관리한다.","doWork":"반도체 조립, 장비기술자와 협력하여 칩본딩공정 목표를 정의하고, 반도체조립 생산기술에 응용한다. 칩본딩 관련 소재, 부품, 시설, 장치, 장비, 공정 기술지식을 기반으로 제품생산 순서도를 결정·검증·개선·유지 관리한다. 칩본딩 관련 핵심 소재, 부품, 장비를 설치·평가·개선·인증·생산·유지 관리하며, 모든 정보 및 기술을 문서화하여 공유한다. 국내외 칩접합 관련 소재·부품·장비업체로부터 획득한 정보 및 제품을 정기적으로 시험평가·인증·응용하여 원가절감 및 개조개선활동을 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체 공정기술자","connectJob":"반도체와이어본딩공정기술자, 반도체플립칩공정기술자","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003672:1', '{"dJobCd":"K000003672","dJobCdSeq":"1","dJobNm":"반도체칩본딩공정연구원","workSum":"반도체 조립기술로드맵 및 고객 요구성능을 이해·응용하여 소자공정연구원과 함께 최적의 칩본딩공정을 연구·개발하여 반도체 조립기술개발을 지원한다.","doWork":"반도체 조립설계 및 소자공정연구원과 칩접합공정 목표를 수립하고, 관련 연구·개발활동을 수행한다. 연삭, 절단, 접합, 몰딩공정연구원과 긴밀한 협력을 통해 칩 본딩 공정특성을 보유한 조립기술 및 소자를 개발한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 다양한 칩본딩 소재, 부품, 공정 및 장비기술을 시험평가하고, 최적화하는 연구·개발활동을 단독 또는 공동으로 수행한다. 칩본딩 공정개발과정에는 반도체 조립라인 이관 시 최고의 품질 및 생산성을 고려한 소재, 부품, 공정 및 장비기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체조립연구원","connectJob":"반도체와이어본딩공정연구원, 반도체플립칩공정연구원","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004211:1', '{"dJobCd":"K000004211","dJobCdSeq":"1","dJobNm":"반도체칩본딩장비공정연구원","workSum":"반도체 조립기술로드맵 및 고객 요구성능을 이해하고, 기구 및 소프트웨어설계연구원과 함께 칩본딩장비를 기획, 기초 및 생산 성능평가를 수행하여 최적의 공정·장비기술을 개발한다.","doWork":"반도체장비 기구설계연구원과 함께 이송, 본딩 모듈 각각의 목표성능을 정의하고, 전체 및 세부구성을 기획한다. 시험장비의 설치 후, 핵심요소기술 중심으로 단독 또는 종합적으로 기초 공정성능평가를 진행한다. 기초평가를 통해 개선이 필요한 부품 및 장치를 선정하여 담당 기구설계연구원에게 신규부품 및 장치개발을 요청한다. 이러한 과정을 반복 진행하여 고객이 요구하는 공정·장비성능목표를 만족하는 칩본딩장비를 개발한다. 칩본딩장비의 기획, 제작 및 시험평가 결과를 고객과 지속·공유하여 고객사 생산라인에서 공정 및 장비 신뢰성 평가계약을 유도한다. 고객과 계약에 따라 종합품질 및 생산성 검증평가를 실시하여 칩본딩장비 인증을 획득한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 다양한 본딩 소재, 부품, 장치, 장비 및 공정기술을 시험평가하고, 최적화하는 연구·개발활동을 단독 또는 공동으로 수행한다. 칩본딩장비 개발과정에는 경쟁사 대비 비교우위, 반도체 생산라인 기준 공정 및 장비 신뢰성 목표달성을 고려한 소재, 부품, 장치, 장비 및 공정기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체공정연구원","connectJob":"반도체와이어본딩장비공정연구원, 반도체플립칩본딩장비공정연구원","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005487:1', '{"dJobCd":"K000005487","dJobCdSeq":"1","dJobNm":"반도체칩본딩장비부분품연구원","workSum":"반도체 조립기술로드맵 및 고객 요구성능을 이해하고, 칩본딩장비에 필요한 부분품을 설계, 기초 및 양산평가를 수행하여 최적의 부분품을 연구·개발한다.","doWork":"반도체 칩본딩장비의 기구설계 및 공정연구원과 공동으로 구상한 기초설계를 기준으로 부분품 기능을 정의하고, 상세사양을 결정한 다음, 최적의 재료, 부품 등을 선정한다. 상세사양 기준으로 선정된 재료, 부품들 중에서 유체, 진동 및 열 역학 해석이 필요한 부품들을 분류하고, 각 부품특성에 적합한 해석프로그램을 선정하여 실행한다. 각 부품별 해석결과를 바탕으로 부품 적합성 여부를 판단하며, 부품 재선정 및 해석작업을 반복하여 최종 부분품 사양을 결정한다. 최종 사양을 기준으로 칩본딩장비의 기구 및 유틸리티를 고려한 상세설계를 진행하여 도면을 작성한다. 부분품의 조립, 시험성능평가 및 장비회사 현장평가를 통해 발견되는 기구설계 오류분석으로 부분품 설계개선을 지원한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 다양한 재료, 부품기술을 시험평가하고, 최적화하는 연구·개발활동을 단독 또는 공동으로 수행한다. 칩본딩장비의 부분품 개발과정에는 부품 조립의 편이성, 제조원가 절감, 공정 및 장비 신뢰성을 보증하는 재료, 부품기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체부품연구원","connectJob":"반도체와이어본딩부분품연구원, 반도체플립칩본딩부분품연구원","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003040:1', '{"dJobCd":"K000003040","dJobCdSeq":"1","dJobNm":"반도체칩절단공정기술자","workSum":"반도체 품질수율 및 생산성 향상을 위해 조립 및 장비기술자와 협의하여 칩절단 공정기술을 평가·개선·인증·유지 관리한다.","doWork":"반도체 조립, 장비기술자와 협력하여 칩절단공정 목표를 정의하고, 반도체조립 생산기술에 응용한다. 칩절단 관련 소재, 부품, 시설, 장치, 장비, 공정 기술지식을 기반으로 제품생산 순서도를 결정·검증·개선·유지 관리한다. 칩절단 관련 핵심 소재, 부품, 장비를 설치·평가·개선·인증·생산·유지 관리하며, 모든 정보 및 기술을 문서화하여 공유한다. 국내외 칩절단 관련 소재·부품·장비업체로부터 획득한 정보 및 제품을 정기적으로 시험평가·인증·응용하여 원가절감 및 개조개선활동을 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체공정기술자","connectJob":"반도체다이싱공정기술자, 반도체쏘잉공정기술자","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001770:1', '{"dJobCd":"K000001770","dJobCdSeq":"1","dJobNm":"반도체칩절단공정연구원","workSum":"반도체 조립기술로드맵 및 고객 요구성능을 이해·응용하여 소자공정연구원과 함께 칩절단 선폭 및 손실이 발생하지 않는 절단공정을 연구·개발하여 반도체 조립기술개발을 지원한다.","doWork":"반도체 조립설계 및 소자공정연구원과 칩 절단공정 목표를 수립하고, 관련 연구·개발활동을 수행한다. 연삭, 접합, 본딩, 몰딩공정연구원과 긴밀한 협력을 통해 칩절단 공정특성을 보유한 조립기술 및 소자를 개발한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 다양한 칩절단 소재, 부품, 공정 및 장비기술을 시험평가하고, 최적화하는 연구·개발활동을 단독 또는 공동으로 수행한다. 칩절단 공정개발과정에는 반도체 조립라인 이관 시 최고의 품질 및 생산성을 고려한 소재, 부품, 공정 및 장비기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체조립연구원","connectJob":"반도체다이싱공정연구원, 반도체쏘잉공정연구원","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001979:1', '{"dJobCd":"K000001979","dJobCdSeq":"1","dJobNm":"반도체칩절단장비공정연구원","workSum":"반도체 조립기술로드맵 및 고객 요구성능을 이해하고, 기구 및 소프트웨어설계연구원과 함께 칩절단장비를 기획, 기초 및 생산 성능평가를 수행하여 최적의 공정·장비기술을 개발한다.","doWork":"반도체장비 기구설계연구원과 함께 이송, 절단, 후세정 모듈 각각의 목표성능을 정의하고, 전체 및 세부구성을 기획한다. 시험장비의 설치 후, 핵심요소기술 중심으로 단독 또는 종합적으로 기초 공정성능평가를 진행한다. 기초평가를 통해 개선이 필요한 부품 및 장치를 선정하여 담당 기구설계연구원에게 신규부품 및 장치개발을 요청한다. 이러한 과정을 반복 진행하여 고객이 요구하는 공정·장비성능목표를 만족하는 칩절단장비를 개발한다. 칩절단장비의 기획, 제작 및 시험평가 결과를 고객과 지속·공유하여 고객사 생산라인에서 공정 및 장비 신뢰성 평가계약을 유도한다. 고객과 계약에 따라 종합품질 및 생산성 검증평가를 실시하여 칩절단장비 인증을 획득한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 다양한 절단 소재, 부품, 장치, 장비 및 공정기술을 시험평가하고, 최적화하는 연구·개발활동을 단독 또는 공동으로 수행한다. 칩절단장비 개발과정에는 경쟁사 대비 비교우위, 반도체 생산라인 기준 공정 및 장비 신뢰성 목표달성을 고려한 소재, 부품, 장치, 장비 및 공정기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체공정연구원","connectJob":"반도체칩다이싱장비공정연구원, 반도체칩쏘잉장비공정연구원","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002015:1', '{"dJobCd":"K000002015","dJobCdSeq":"1","dJobNm":"반도체칩절단장비부분품연구원","workSum":"반도체 조립기술로드맵 및 고객 요구성능을 이해하고, 칩절단장비에 필요한 부분품을 설계, 기초 및 양산평가를 수행하여 최적의 부분품을 연구·개발한다.","doWork":"반도체 칩절단장비의 기구설계 및 공정연구원과 공동으로 구상한 기초설계를 기준으로 부분품 기능을 정의하고, 상세사양을 결정한 다음, 최적의 재료, 부품 등을 선정한다. 상세사양 기준으로 선정된 재료, 부품들 중에서 유체, 진동, 열 및 광 역학 해석이 필요한 부품들을 분류하고, 각 부품특성에 적합한 해석프로그램을 선정하여 실행한다. 각 부품별 해석결과를 바탕으로 부품 적합성 여부를 판단하며, 부품 재선정 및 해석작업을 반복하여 최종 부분품 사양을 결정한다. 최종 사양을 기준으로 칩절단장비의 기구 및 유틸리티를 고려한 상세설계를 진행하여 도면을 작성한다. 부분품의 조립, 시험성능평가 및 장비회사 현장평가를 통해 발견되는 기구설계 오류분석으로 부분품 설계개선을 지원한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 다양한 재료, 부품기술을 시험평가하고, 최적화하는 연구·개발활동을 단독 또는 공동으로 수행한다. 칩절단장비의 부분품 개발과정에는 부품 조립의 편이성, 제조원가 절감, 공정 및 장비 신뢰성을 보증하는 재료, 부품기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체부품연구원","connectJob":"반도체칩다이싱장비부분품연구원, 반도체칩쏘잉장비부분품연구원","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003421:1', '{"dJobCd":"K000003421","dJobCdSeq":"1","dJobNm":"반도체칩접합공정기술자","workSum":"반도체 품질수율 및 생산성 향상을 위해 조립 및 장비기술자와 협의하여 칩접합 공정기술을 평가·개선·인증·유지 관리한다.","doWork":"반도체 조립, 장비기술자와 협력하여 칩접합공정 목표를 정의하고, 반도체조립 생산기술에 응용한다. 칩접합 관련 소재, 부품, 시설, 장치, 장비, 공정 기술지식을 기반으로 제품생산 순서도를 결정·검증·개선·유지 관리한다. 칩접합 관련 핵심 소재, 부품, 장비를 설치·평가·개선·인증·생산·유지 관리하며, 모든 정보 및 기술을 문서화하여 공유한다. 국내외 칩접합 관련 소재·부품·장비업체로부터 획득한 정보 및 제품을 정기적으로 시험평가·인증·응용하여 원가절감 및 개조개선활동을 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체공정기술자","connectJob":"반도체Attach공정기술자","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002924:1', '{"dJobCd":"K000002924","dJobCdSeq":"1","dJobNm":"반도체칩접합공정연구원","workSum":"반도체 조립기술로드맵 및 고객 요구성능을 이해·응용하여 소자공정연구원과 함께 최적의 칩접합공정을 연구·개발하여 반도체 조립기술개발을 지원한다.","doWork":"반도체 조립설계 및 소자공정연구원과 칩접합공정 목표를 수립하고, 관련 연구·개발활동을 수행한다. 연삭, 절단, 본딩, 몰딩공정연구원과 긴밀한 협력을 통해 칩접합 공정특성을 보유한 조립기술 및 소자를 개발한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 다양한 칩접합소재, 부품, 공정 및 장비기술을 시험평가하고, 최적화하는 연구·개발활동을 단독 또는 공동으로 수행한다. 칩접합 공정개발과정에는 반도체 조립라인 이관 시 최고의 품질 및 생산성을 고려한 소재, 부품, 공정 및 장비기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체조립연구원","connectJob":"반도체Attach공정연구원","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005652:1', '{"dJobCd":"K000005652","dJobCdSeq":"1","dJobNm":"반도체칩접합장비공정연구원","workSum":"반도체 조립기술로드맵 및 고객 요구성능을 이해하고, 기구 및 소프트웨어설계연구원과 함께 칩접합장비를 기획, 기초 및 생산 성능평가를 수행하여 최적의 공정·장비기술을 개발한다.","doWork":"반도체장비 기구설계연구원과 함께 이송, 접합 모듈 각각의 목표성능을 정의하고, 전체 및 세부구성을 기획한다. 시험장비의 설치 후, 핵심요소기술 중심으로 단독 또는 종합적으로 기초 공정성능평가를 진행한다. 기초평가를 통해 개선이 필요한 부품 및 장치를 선정하여 담당 기구설계연구원에게 신규부품 및 장치개발을 요청한다. 이러한 과정을 반복 진행하여 고객이 요구하는 공정·장비성능목표를 만족하는 칩접합장비를 개발한다. 칩접합장비의 기획, 제작 및 시험평가 결과를 고객과 지속·공유하여 고객사 생산라인에서 공정 및 장비 신뢰성 평가계약을 유도한다. 고객과 계약에 따라 종합품질 및 생산성 검증평가를 실시하여 칩접합장비 인증을 획득한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 다양한 접합 소재, 부품, 장치, 장비 및 공정기술을 시험평가하고, 최적화하는 연구·개발활동을 단독 또는 공동으로 수행한다. 칩접합장비 개발과정에는 경쟁사 대비 비교우위, 반도체 생산라인 기준 공정 및 장비 신뢰성 목표달성을 고려한 소재, 부품, 장치, 장비 및 공정기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체공정연구원","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003188:1', '{"dJobCd":"K000003188","dJobCdSeq":"1","dJobNm":"반도체칩접합장비부분품연구원","workSum":"반도체 조립기술로드맵 및 고객 요구성능을 이해하고, 칩접합장비에 필요한 부분품을 설계, 기초 및 양산평가를 수행하여 최적의 부분품을 연구·개발한다.","doWork":"반도체 칩접합장비의 기구설계 및 공정연구원과 공동으로 구상한 기초설계를 기준으로 부분품 기능을 정의하고, 상세사양을 결정한 다음, 최적의 재료, 부품 등을 선정한다. 상세사양 기준으로 선정된 재료, 부품들 중에서 유체, 진동 및 열 역학 해석이 필요한 부품들을 분류하고, 각 부품특성에 적합한 해석프로그램을 선정하여 실행한다. 각 부품별 해석결과를 바탕으로 부품 적합성 여부를 판단하며, 부품 재선정 및 해석작업을 반복하여 최종 부분품 사양을 결정한다. 최종 사양을 기준으로 칩접합장비의 기구 및 유틸리티를 고려한 상세설계를 진행하여 도면을 작성한다. 부분품의 조립, 시험성능평가 및 장비회사 현장평가를 통해 발견되는 기구설계 오류분석으로 부분품 설계개선을 지원한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 다양한 재료, 부품기술을 시험평가하고, 최적화하는 연구·개발활동을 단독 또는 공동으로 수행한다. 칩접합장비의 부분품 개발과정에는 부품 조립의 편이성, 제조원가 절감, 공정 및 장비 신뢰성을 보증하는 재료, 부품기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체부품연구원","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006924:1', '{"dJobCd":"K000006924","dJobCdSeq":"1","dJobNm":"반도체패키지제품설계기술자","workSum":"반도체 조립기술로드맵 및 고객 요구성능을 이해하고, 반도체소자를 외부환경으로부터 보호하고, 전력공급, 신호전달 등의 기능을 부여하기 위한 반도체 패키지제품을 설계한다.","doWork":"반도체 능동소자의 전기적 매개변수를 분석하고, 수동소자의 값을 최적화한다. 신호연결과 전도체의 기생성분을 분석, 최적화하며, 신호·전력 무결성, 전자파 간섭 등 신호의 왜곡 및 지연 등을 고려하여 해석한다. 신호라인과 접지신호의 피드백 루프를 고려하여 회로 기판을 설계하여 접지면의 임피던스를 최소화하는 설계를 한다. 시뮬레이션에 필요한 패키지 소재의 전기·기계적 물성값을 설정하며, 시뮬레이션 툴을 사용하여 제품사양서에 따라 전자파를 해석한다. 신호·전력 무결성, 신호왜곡·지연 등에 대한 시뮬레이션을 수행하여 결과를 도출하며, 시뮬레이션 출력결과를 기술적으로 분석 후 패키지 설계에 반영한다. 다양한 패키지 형태 및 구조를 구분하여 설계하며, 패키지 형태에 따라 재료, 비용, 크기, 신호 핀의 숫자 등을 고려하여 설계한다. 신호연결에 수반되는 저항, 인덕턴스, 커패시턴스 기생성분을 고려하여 설계하며, 열 변형 및 응력, 전기·기계적 특성의 패키지 신뢰성을 고려하여 설계한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 다양한 패키지제품 설계기술을 시험평가하고, 최적화하는 연구·개발활동을 단독 또는 공동으로 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|언어력|시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체설계연구원","certLic":"반도체설계산업기사","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001966:1', '{"dJobCd":"K000001966","dJobCdSeq":"1","dJobNm":"반도체화학기상증착공정기술자","workSum":"반도체 품질수율 및 생산성 향상을 위해 소자제조 및 장비기술자와 협의하여 화학기상증착 공정기술을 평가·개선·인증·유지 관리한다.","doWork":"반도체소자 제조, 공정, 장비기술자와 협력하여 화학기상증착공정 목표를 정의하고, 반도체소자 생산기술에 응용한다. 화학기상증착 관련 소재, 부품, 시설, 장치, 장비, 공정 기술지식을 기반으로 제조, 공정, 장비기술자와 협력하여 제품생산 순서도를 결정·검증·개선·유지 관리한다. 화학기상증착 관련 핵심 소재, 부품, 장비를 설치·평가·개선·인증·생산·유지 관리하며, 모든 정보 및 기술을 문서화하여 공유한다. 국내외 화학기상증착 관련 소재·부품·장비업체로부터 획득한 정보 및 제품을 정기적으로 시험평가·인증·응용하여 원가절감 및 개조개선활동을 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체공정기술자","connectJob":"반도체스퍼터링공정기술자, 반도체원자층증착공정기술자","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001388:1', '{"dJobCd":"K000001388","dJobCdSeq":"1","dJobNm":"반도체화학기상증착공정연구원","workSum":"반도체 기술로드맵 및 고객 요구성능을 이해·응용하여 소자공정연구원과 함께 차세대 소자배선구조 형성을 위한 화학기상증착공정을 연구·개발한다.","doWork":"반도체소자공정연구원과 공동으로 화학기상증착공정 목표를 수립하고, 관련 연구·개발활동을 수행한다. 소자공정연구원을 중심으로 사진현상, 식각, 이온주입, 확산, 세정 및 연마공정연구원과 긴밀한 공동 연구를 통해 최적의 화학기상증착 공정특성을 보유한 소자회로 배선구조 및 특성을 개발한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 다양한 소재, 부품, 공정 및 장비기술을 시험평가하고, 최적화하는 연구·개발활동을 단독 또는 공동으로 수행한다. 화학기상증착 공정개발과정에는 반도체 생산라인 이관 시 최고의 품질 및 생산성을 고려한 소재, 부품, 공정 및 장비기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체공정연구원","connectJob":"반도체스퍼터공정연구원, 반도체원자층증착공정연구원","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005967:1', '{"dJobCd":"K000005967","dJobCdSeq":"1","dJobNm":"반도체화학기상증착장비공정연구원","workSum":"반도체 기술로드맵 및 고객 요구성능을 이해하고, 기구 및 소프트웨어설계연구원과 함께 화학기상증착장비를 기획, 기초 및 생산 성능평가를 수행하여 최적의 공정·장비기술을 개발한다.","doWork":"반도체장비 기구·소프트웨어설계연구원과 함께 이송, 공정, 냉각 모듈 각각의 목표성능을 정의하고, 전체 및 세부구성을 기획한다. 시험장비의 설치 후, 핵심요소기술 중심으로 단독 또는 종합적으로 기초 공정성능평가를 진행한다. 기초평가를 통해 개선이 필요한 부품 및 장치를 선정하여 담당 기구설계연구원에게 신규부품 및 장치개발을 요청한다. 이러한 과정을 반복 진행하여 고객이 요구하는 공정·장비성능목표를 만족하는 화학기상증착장비를 개발한다. 화학기상증착장비의 기획, 제작 및 시험평가 결과를 고객과 지속·공유하여 고객사 생산라인에서 공정 및 장비 신뢰성 평가계약을 유도한다. 고객과 계약에 따라 종합품질 및 생산성 검증평가를 실시하여 화학기상증착장비 인증을 획득한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 다양한 재료, 부품, 장치, 장비 및 공정기술을 시험평가하고, 최적화하는 연구·개발활동을 단독 또는 공동으로 수행한다. 화학기상증착장비 개발과정에는 경쟁사 대비 비교우위, 반도체 생산라인 기준 공정 및 장비 신뢰성 목표달성을 고려한 재료, 부품, 장치, 장비 및 공정기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체공정연구원","connectJob":"반도체스퍼터링장비공정연구원, 반도체원자층증착장비공정연구원","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003187:1', '{"dJobCd":"K000003187","dJobCdSeq":"1","dJobNm":"반도체화학기상증착장비부분품연구원","workSum":"반도체 기술로드맵 및 고객 요구성능을 이해하고, 화학기상증착장비에 필요한 부분품을 설계, 기초 및 양산평가를 수행하여 최적의 부분품을 연구·개발한다.","doWork":"반도체 화학기상증착장비의 기구설계, 소프트웨어설계 및 공정연구원과 공동으로 구상한 기초설계를 기준으로 부분품 기능을 정의하고, 상세사양을 결정한 다음, 최적의 재료, 부품 등을 선정한다. 상세사양 기준으로 선정된 재료, 부품들 중에서 유체, 진동, 열 및 광 역학 해석이 필요한 부품들을 분류하고, 각 부품특성에 적합한 해석프로그램을 선정하여 실행한다. 각 부품별 해석결과를 바탕으로 부품 적합성 여부를 판단하며, 부품 재선정 및 해석작업을 반복하여 최종 부분품 사양을 결정한다. 최종 사양을 기준으로 화학기상증착장비의 기구 및 유틸리티를 고려한 상세설계를 진행하여 도면을 작성한다. 부분품의 조립, 시험성능평가 및 장비회사 현장평가를 통해 발견되는 기구설계 오류분석으로 부분품 설계개선을 지원한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 다양한 재료, 부품기술을 시험평가하고, 최적화하는 연구·개발활동을 단독 또는 공동으로 수행한다. 반도체화학기상증착장비의 부분품 개발과정에는 부품 조립의 편이성, 제조원가 절감, 공정 및 장비 신뢰성을 보증하는 재료, 부품기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체부품연구원","connectJob":"반도체스퍼터링증착장비부분품설계연구원, 반도체원자층증착장비부분품설계연구원","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005252:1', '{"dJobCd":"K000005252","dJobCdSeq":"1","dJobNm":"반도체화학적기계적연마공정기술자","workSum":"반도체 품질수율 및 생산성 향상을 위해 소자제조 및 장비기술자와 협의하여 화학적기계적연마 공정기술을 평가·개선·인증·유지 관리한다.","doWork":"반도체소자 제조, 공정, 장비기술자와 협력하여 화학적기계적연마공정 목표를 정의하고, 반도체소자 생산기술에 응용한다. 화학적기계적연마 관련 소재, 부품, 시설, 장치, 장비, 공정 기술지식을 기반으로 제조, 공정, 장비기술자와 협력하여 제품생산 순서도를 결정·검증·개선·유지 관리한다. 화학적기계적연마 관련 핵심 소재, 부품, 장비를 설치·평가·개선·인증·생산·유지 관리하며, 모든 정보 및 기술을 문서화하여 공유한다. 국내외 화학적기계적연마 관련 소재·부품·장비업체로부터 획득한 정보 및 제품을 정기적으로 시험평가·인증·응용하여 원가절감 및 개조개선활동을 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체공정기술자","connectJob":"반도체CMP공정기술자","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005416:1', '{"dJobCd":"K000005416","dJobCdSeq":"1","dJobNm":"반도체화학적기계적연마공정연구원","workSum":"반도체 기술로드맵 및 고객 요구성능을 이해·응용하여 소자공정연구원과 함께 차세대 소자배선구조 형성을 위한 화학적기계적연마공정을 연구·개발한다.","doWork":"반도체소자공정연구원과 공동으로 화학적기계적연마공정 목표를 수립하고, 관련 연구·개발활동을 수행한다. 소자공정연구원을 중심으로 사진현상, 식각, 이온주입, 박막, 확산 및 세정공정연구원과 긴밀한 공동 연구를 통해 최적의 화학적기계적연마 공정특성을 보유한 소자회로 배선구조 및 특성을 개발한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 다양한 소재, 부품, 공정 및 장비기술을 시험평가하고, 최적화하는 연구·개발활동을 단독 또는 공동으로 수행한다. 화학적기계적연마 공정개발과정에는 반도체 생산라인 이관 시 최고의 품질 및 생산성을 고려한 소재, 부품, 공정 및 장비기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체공정연구원","connectJob":"반도체CMP공정연구원","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004098:1', '{"dJobCd":"K000004098","dJobCdSeq":"1","dJobNm":"반도체화학적기계적연마장비공정연구원","workSum":"반도체 기술로드맵 및 고객 요구성능을 이해하고, 기구 및 소프트웨어설계연구원과 함께 화학적기계적연마장비를 기획, 기초, 생산 성능평가를 수행하여 최적의 공정·장비기술을 개발한다.","doWork":"반도체장비 기구·소프트웨어설계연구원과 함께 이송, 연마공정, 후세정 모듈 각각의 목표성능을 정의하고, 전체 및 세부구성을 기획한다. 시험장비의 설치 후, 핵심요소기술 중심으로 단독 또는 종합적으로 기초 공정성능평가를 진행한다. 기초평가를 통해 개선이 필요한 부품 및 장치를 선정하여 담당 기구설계연구원에게 신규부품 및 장치개발을 요청한다. 이러한 과정을 반복 진행하여 고객이 요구하는 공정·장비성능목표를 만족하는 화학적기계적연마장비를 개발한다. 연마장비의 기획, 제작 및 시험평가 결과를 고객과 지속·공유하여 고객사 생산라인에서 공정 및 장비 신뢰성 평가계약을 유도한다. 고객과 계약에 따라 종합품질 및 생산성 검증평가를 실시하여 화학적기계적연마장비 인증을 획득한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 다양한 재료, 부품, 장치, 장비 및 공정기술을 시험평가하고, 최적화하는 연구·개발활동을 단독 또는 공동으로 수행한다. 화학적기계적연마장비 개발과정에는 경쟁사 대비 비교우위, 반도체 생산라인 기준 공정 및 장비 신뢰성 목표달성을 고려한 재료, 부품, 장치, 장비 및 공정기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체공정연구원","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007039:1', '{"dJobCd":"K000007039","dJobCdSeq":"1","dJobNm":"반도체화학적기계적연마장비부분품연구원","workSum":"반도체 기술로드맵 및 고객 요구성능을 이해하고, 화학적기계적연마장비에 필요한 부분품을 설계, 기초 및 양산평가를 수행하여 최적의 부분품을 연구·개발한다.","doWork":"반도체 화학적기계적연마장비의 기구설계, 소프트웨어설계 및 공정연구원과 공동으로 구상한 기초설계를 기준으로 부분품 기능을 정의하고, 상세사양을 결정한 다음, 최적의 재료, 부품 등을 선정한다. 상세사양 기준으로 선정된 재료, 부품들 중에서 유체, 진동, 열 및 광 역학 해석이 필요한 부품들을 분류하고, 각 부품특성에 적합한 해석프로그램을 선정하여 실행한다. 각 부품별 해석결과를 바탕으로 부품 적합성 여부를 판단하며, 부품 재선정 및 해석작업을 반복하여 최종 부분품 사양을 결정한다. 최종 사양을 기준으로 화학적기계적연마장비의 기구 및 유틸리티를 고려한 상세설계를 진행하여 도면을 작성한다. 부분품의 조립, 시험성능평가 및 장비회사 현장평가를 통해 발견되는 기구설계 오류분석으로 부분품 설계개선을 지원한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 다양한 재료, 부품기술을 시험평가하고, 최적화하는 연구·개발활동을 단독 또는 공동으로 수행한다. 반도체화학적기계적연마장비의 부분품 개발과정에는 부품 조립의 편이성, 제조원가 절감, 공정 및 장비 신뢰성을 보증하는 재료, 부품기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체부품연구원","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006796:1', '{"dJobCd":"K000006796","dJobCdSeq":"1","dJobNm":"반도체확산공정기술자","workSum":"반도체 품질수율 및 생산성 향상을 위해 소자제조 및 장비기술자와 협의하여 확산 공정기술을 평가·개선·인증·유지 관리한다.","doWork":"반도체소자 제조, 공정, 장비기술자와 협력하여 확산공정 목표를 정의하고, 반도체소자 생산기술에 응용한다. 확산 관련 소재, 부품, 시설, 장치, 장비, 공정 기술지식을 기반으로 제조, 공정, 장비기술자와 협력하여 제품생산 순서도를 결정·검증·개선·유지 관리한다. 확산 관련 핵심 소재, 부품, 장비를 설치·평가·개선·인증·생산·유지 관리하며, 모든 정보 및 기술을 문서화하여 공유한다. 국내외 확산 관련 소재·부품·장비업체로부터 획득한 정보 및 제품을 정기적으로 시험평가·인증·응용하여 원가절감 및 개조개선활동을 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체공정기술자","connectJob":"반도체열처리공정기술자, 반도체열산화막공정기술자, 반도체RTP공정기술자, 반도체Furnace공정기술자","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004521:1', '{"dJobCd":"K000004521","dJobCdSeq":"1","dJobNm":"반도체확산공정연구원","workSum":"반도체 기술로드맵 및 고객 요구성능을 이해·응용하여 소자공정연구원과 함께 차세대 소자배선구조 형성을 위한 확산공정을 연구·개발한다.","doWork":"반도체소자공정연구원과 공동으로 확산공정 목표를 수립하고, 관련 연구·개발활동을 수행한다. 소자공정연구원을 중심으로 사진현상, 식각, 이온주입, 박막, 세정 및 연마공정연구원과 긴밀한 공동 연구를 통해 최적의 확산 공정특성을 보유한 소자회로 배선구조 및 특성을 개발한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 다양한 소재, 부품, 공정 및 장비기술을 시험평가하고, 최적화하는 연구·개발활동을 단독 또는 공동으로 수행한다. 확산 공정개발과정에는 반도체 생산라인 이관 시 최고의 품질 및 생산성을 고려한 소재, 부품, 공정 및 장비기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체공정연구원","connectJob":"반도체열처리공정연구원, 반도체열산화막공정연구원, 반도체RTP공정연구원, 반도체Furnace공정연구원","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003000:1', '{"dJobCd":"K000003000","dJobCdSeq":"1","dJobNm":"반도체확산장비공정연구원","workSum":"반도체 기술로드맵 및 고객 요구성능을 이해하고, 기구 및 소프트웨어설계연구원과 함께 확산장비를 기획, 기초 및 생산 성능평가를 수행하여 최적의 공정·장비기술을 개발한다.","doWork":"반도체장비 기구·소프트웨어설계연구원과 함께 공정가스, 웨이퍼 보트, 공정 튜브, 가열 장치부 각각의 목표성능을 정의하고, 전체 및 세부구성을 기획한다. 시험장비의 설치 후, 핵심요소기술 중심으로 단독 또는 종합적으로 기초 공정성능평가를 진행한다. 기초평가를 통해 개선이 필요한 부품 및 장치를 선정하여 담당 기구설계연구원에게 신규부품 및 장치개발을 요청한다. 이러한 과정을 반복 진행하여 고객이 요구하는 공정·장비성능목표를 만족하는 확산장비를 개발한다. 확산장비의 기획, 제작 및 시험평가 결과를 고객과 지속·공유하여 고객사 생산라인에서 공정 및 장비 신뢰성 평가계약을 유도한다. 고객과 계약에 따라 종합품질 및 생산성 검증평가를 실시하여 확산장비 인증을 획득한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 다양한 재료, 부품, 장치, 장비 및 공정기술을 시험평가하고, 최적화하는 연구·개발활동을 단독 또는 공동으로 수행한다. 확산장비 개발과정에는 경쟁사 대비 비교우위, 반도체 생산라인 기준 공정 및 장비 신뢰성 목표달성을 고려한 재료, 부품, 장치, 장비 및 공정기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체공정연구원","connectJob":"반도체열처리장비공정연구원, 반도체열산화막장비공정연구원, 반도체RTP장비공정연구원, 반도체Furnace장비공정연구원","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003690:1', '{"dJobCd":"K000003690","dJobCdSeq":"1","dJobNm":"반도체확산장비부분품연구원","workSum":"반도체 기술로드맵 및 고객 요구성능을 이해하고, 확산장비에 필요한 부분품을 설계, 기초 및 양산평가를 수행하여 최적의 부분품을 연구·개발한다.","doWork":"반도체 확산장비의 기구설계, 소프트웨어설계 및 공정연구원과 공동으로 구상한 기초설계를 기준으로 부분품 기능을 정의하고, 상세사양을 결정한 다음, 최적의 재료, 부품 등을 선정한다. 상세사양 기준으로 선정된 재료, 부품 중 유체, 진동, 열 역학 해석이 필요한 부품들을 분류하고, 각 부품특성에 적합한 해석프로그램을 선정하여 실행한다. 각 부품별 해석결과를 바탕으로 부품 적합성 여부를 판단하며, 부품 재선정 및 해석작업을 반복하여 최종 부분품 사양을 결정한다. 최종 사양을 기준으로 확산장비의 기구 및 유틸리티를 고려한 상세설계를 진행하여 도면을 작성한다. 부분품의 조립, 시험성능평가 및 장비회사 현장평가를 통해 발견되는 기구설계 오류분석으로 부분품 설계개선을 지원한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 다양한 재료, 부품기술을 시험평가하고, 최적화하는 연구·개발활동을 단독 또는 공동으로 수행한다. 반도체확산장비의 부분품 개발과정에는 부품 조립의 편이성, 제조원가 절감, 공정 및 장비 신뢰성을 보증하는 재료, 부품기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체부품연구원","connectJob":"반도체열처리장비부분품설계연구원, 반도체열산화막장비부분품설계연구원, 반도체Furnace장비부분품설계연구원","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004366:1', '{"dJobCd":"K000004366","dJobCdSeq":"1","dJobNm":"법의영상분석연구원","workSum":"증거확보를 목적으로 CCTV 등 영상물의 특성을 분석 또는 복원하여 감정하고 관련 보고서를 작성한다.","doWork":"법원, 법무법인, 공공기관 등에서 영상 관련 시비가 있을 경우 법적 증거효력을 갖추기 위하여 감정 및 해독 의뢰를 받는다. CCTV, 블랙박스 등의 영상을 이용하여 사건현장의 재구성이 필요한 경우 2차원 영상에 기록된 장면을 소실선과 소실점을 이용하여 3차원으로 시뮬레이션하여 피사체의 크기, 길이, 형태 등을 파악하여 현장을 재구성한다. 화질 개선이 필요한 경우 저조도, 노이즈, 압축 등 화질 저해요소를 영상개선 기법을 통해 피사체를 판독한다. 이미지 합성, 수정, 조작 등 사건의 진실을 왜곡하는 요소를 위변조 프로그램을 이용하여 감정한다. 교통사고의 판독이나 항공사진을 판독하기도 한다. 감정한 내용을 보고서로 작성하고 필요시 법원 등에서 진술하기도 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"정밀작업","similarNm":"영상분석감정원","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"M711","dJobICdNm":"[M711]법무관련 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001322:1', '{"dJobCd":"K000001322","dJobCdSeq":"1","dJobNm":"비디오기기기술자","workSum":"전자기술 전반에 관한 지식을 활용하여 비디오기기를 설계하고 생산공정에 대해 생산성 및 품질향상을 위한 작업설계와 기술적인 사항을 지원하며 시스템을 개선·관리·보존·유지한다.","doWork":"새로운 모델의 비디오제품을 생산하기 위해 계측기기를 사용하여 시작품에 대하여 시험측정한다. 설비, 계측기기, 신호기 등 생산공정을 기획한다. 생산현장의 문제점을 파악하여 개선하고 기술적인 사항을 지원한다. 불량자재에 대해 원인을 분석하고 생산성 증가를 위해 공정을 개선하며 설계에 대한 문제점을 파악하여 조치한다. 생산에 필요한 장비나 설비 등을 설계하여 제작하기도 한다. 생산라인에 비디오 송신호를 발생시켜 공급하며 신호분석기를 사용하여 송신호가 올바른지 점검한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"전자기사","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C265","dJobICdNm":"[C265]영상 및 음향기기 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003555:1', '{"dJobCd":"K000003555","dJobCdSeq":"1","dJobNm":"생체인식전문가","workSum":"지문, 홍채, 땀샘구조, 혈관 등 개인의 독특한 생체정보영상을 추출·처리·인식하여 정보화시키고 식별시스템을 구현한다.","doWork":"디지털카메라, 스캐너 등의 영상획득장치를 통해 생체정보(지문, 얼굴, 홍채, 정맥 등)이미지를 획득한다. 영상획득과정을 통해 얻은 디지털 영상을 영상교정작업(대비도 개선, 잡음 제거 등)하여 개선한다. 입력영상 중에서 필요한 것과 필요하지 않은 것을 구분하여 추출할 수 있도록 영상분할을 한다. 분할된 영상데이터를 컴퓨터에서 처리하기 적당한 형태로 바꾸고, 윤곽선 및 영역을 표현하고, 처리 시 고려하고자 하는 특징을 추출한다. 개인식별시스템개발자는 모든 사용자의 관련된 생체특징을 시스템 데이터베이스에 등록시키고, 시스템 데이터베이스에 등록된 해당 사람을 식별하는 프로그램 등을 개발하고 리더기나 지문인식기와 같은 하드웨어부분을 개발하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","similarNm":"생체인식시스템개발자","connectJob":"지문인식전문가, 얼굴인식전문가, 서명인식전문가, 손구조인식전문가, 제스처인식전문가, 홍채인식전문가, 정맥인식전문가","certLic":"정보처리기사, 정보통신기사, 전파통신기사, 방송통신기사, 전파전자기사","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002201:1', '{"dJobCd":"K000002201","dJobCdSeq":"1","dJobNm":"센서개발자","workSum":"자동차, 가전제품, 전자제품 등에 사용되는 각종 센서(Sensor)를 연구·개발한다.","doWork":"각종 반도체소자의 특성과 구조를 연구·분석한다. 열, 빛, 습기, 압력 등을 가하였을 때 발생하는 물리적·화학적 특성 등을 연구하여 온도센서, 습도센서, 초음파센서, 가속도센서, 적외선센서, 바이오센서, 이미지센서 등을 개발한다. 인텔리전트센서(Intelligent Sensor) 등 정보나 수치를 스스로 계산·판단·처리하는 보다 높은 기능의 센서를 개발하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"센서개발원, 센서기술자, 센서개발기술자","certLic":"전자기사, 전기기사","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C272","dJobICdNm":"[C272]측정, 시험, 항해, 제어 및 기타 정밀기기 제조업; 광학기기 제외","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005827:1', '{"dJobCd":"K000005827","dJobCdSeq":"1","dJobNm":"수정진동자개발자","workSum":"휴대용 전화기, 무전기 및 각종 통신장비, 시계, 컴퓨터 등에 사용되는 수정진동자 및 발진기(진동을 발생시키는 장치)를 연구·개발한다.","doWork":"수정의 절단, 가공기술 등을 개발하고 고선명 텔레비전, 통신시스템, 위성통신, 블루투스, 컴퓨터, 시계 등에 사용되는 초고주파 수정진동자를 연구한다. 수정을 결정축에 대해 특정한 조각으로 절단하여 만든 얇은 조각의 양면에 도체 전극을 부착하고 전압을 걸어 진동이 발생하는 시험을 한다. 오실로스코프(Oscilloscope:진동현상을 눈으로 볼 수 있도록 기록 또는 표시하는 장치), 측정프로그램(시뮬레이터) 등 측정기법을 사용하여 각종 제품이 요구하는 특성에 부합하는 발진기 모듈을 개발하고 시험한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"수정진동자개발원, 수정진동자기술자, 수정진동자개발기술자","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004224:1', '{"dJobCd":"K000004224","dJobCdSeq":"1","dJobNm":"시스템반도체소자공정연구원","workSum":"시스템반도체 소자회로설계를 반영하는 Photo Mask 제조공정, 소자회로 성능 목표를 구현하기 위한 다양한 회로배선구조의 소자제조공정을 연구·개발한다.","doWork":"시스템반도체소자 회로설계 사양에 따라 다양한 재료와 배선선폭을 가지는 Photo Mask를 사진현상공정연구원과 함께 연구·개발한다. 고객이 요구하는 소자회로 성능 목표를 기준으로 사진현상, 식각, 이온주입, 확산, 화학기상증착, 금속막증착, 세정, 연마 및 계측검사 공정을 조합한 소자제조공정(Process Integration)을 단위공정연구원과 공동으로 연구·개발한다. Logic 소자의 Isolation, Gate, Multi Interconnect 등 회로배선을 다양한 소재, 구조를 이용하여 연구·개발한다. 이후 소자 조립 및 검사 공정을 통해 전기적, 구조적 특성의 유효성 여부를 검증한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체소자공정연구원","connectJob":"AP소자공정연구원, Modem소자공정연구원, DDI소자공정연구원, CIS소자공정연구원, Logic소자공정연구원, ASIC소자공정연구원 등","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006345:1', '{"dJobCd":"K000006345","dJobCdSeq":"1","dJobNm":"시스템반도체소자연구원","workSum":"MPU, Modem, DDI, CIS, Logic, ASIC, Sensor, 차세대 요소기술 응용, 차세대 상용화기술 응용 시스템반도체소자 등 소자회로설계를 지원하고, 전기적 특성 관점에서 연구·개발한다.","doWork":"시스템반도체소자 회로설계연구원과 함께 고객이 요구하는 소자회로 성능 사양에 적합한 회로설계를 지원한다. 제품별 소자회로의 전기적 특성 목표를 사진현상, 식각, 확산 및 박막 등 단위공정연구원에게 제안한다. 시스템반도체소자의 특성평가, 실장평가, 환경시험, 수명시험, 내성시험과 같은 불량분석업무를 통해 제품 신뢰도를 검사한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체소자연구원","connectJob":"MPU소자연구원, Modem소자연구원, DDI소자연구원, CIS소자연구원, Logic소자연구원, ASIC소자연구원, Sensor소자연구원, 차세대요소기술반도체소자연구원, 차세대상용화기술반도체소자연구원 등","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003964:1', '{"dJobCd":"K000003964","dJobCdSeq":"1","dJobNm":"시스템반도체제조기술자","workSum":"MPU, Modem, Logic, ASIC, Sensor, 요소 및 상용화 기술 응용 시스템반도체 제조를 위한 생산관리, 제조공정, 시설·장비운영, 검사, 불량분석 및 문제해결 등의 업무를 지원·관리한다.","doWork":"CPU, GPU 및 AP소자와 같은 MPU(Micro Processor Unit)소자, Modem, Connectivity 및 NFC소자와 같은 통신소자, 디스플레이용 DDI소자, 카메라용 CIS소자, 지문인식 등 각종 MEMS소자, Logic, ASIC소자 등 시스템반도체의 소자기술, 제조공정, 생산장비, 품질검사 및 관리 지식을 활용하여 시스템반도체 생산 관련 직무전체를 총괄, 지원 및 관리한다. 시스템반도체 공정기술자, 장비기술자, 제조원과 공동으로 생산, 검사 및 품질관리업무를 수행한다. 시스템반도체소자 품질수율 및 생산성 향상을 위해 사진현상, 식각, 확산, 박막, 세정, 연마, 조립 및 검사 공정·장비기술자와 공동으로 문제점 도출, 원인분석, 개선 작업을 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"시스템반도체기술자","connectJob":"시스템반도체공정기술자, 시스템반도체장비기술자, 시스템반도체제조반장 등","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002325:1', '{"dJobCd":"K000002325","dJobCdSeq":"1","dJobNm":"알에프아이디시스템개발자","workSum":"RFID(Radio Frequency Identification) 기술을 응용하여 새로운 제품을 설계하거나, RFID 기술을 기반으로 다양한 정보를 신속하게 수집할 수 있도록 정보서비스를 기획하고 개발한다.","doWork":"각종 RFID 신기술을 취합하고 이를 정리한다. 취합된 자료를 바탕으로 C, Visual C, 델파이 등 프로그래밍언어를 사용하여 소프트웨어를 설계한다. RFID 태그, RFID 판독기 및 안테나 등의 하드웨어를 설계하거나 기존 제품을 개선한다. 회로가 구현된 반도체 웨이퍼에서 칩 소자를 분리한 후, 각종 RFID 안테나 시트, 또는 PCB 등의 회로 기판과 결합하여 시제품을 완성한다. 표준규격시험, 무선성능, 상호운용성, 실증시험 등 각종 시험을 통해 보완점을 찾아 수정하고 기록한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"RFID시스템개발자, 전자태그시스템개발자","connectJob":"USN(Ubiquitous Sensor Network)시스템개발자, RF엔지니어, 안테나엔지니어","certLic":"무선설비기사, 정보처리기사, 전파통신기사, RFID관리사","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002633:1', '{"dJobCd":"K000002633","dJobCdSeq":"1","dJobNm":"가정용전기기구검사원","workSum":"냉장고, 세탁기, 에어콘 등 제조된 가정용 전자·전기제품을 일정 시간 가동시켜 성능 및 외관검사를 실시하고 관련 설비를 유지·관리·보수한다.","doWork":"조립 완료된 가정용 전기기구를 샘플링 기법을 사용하여 골라내어 검사하거나, 필요시 전체 제품에 대해 검사한다. 온도측정계측기기, 내전압절연저항기 등과 같은 검사기기를 측정대상 가정용 검사기구에 연결하고 실제 사용하는 것과 같은 상황을 설정하여 온도, 소음 등의 검사를 실시한다. 검사 후 검사대상제품의 문제점 또는 합격 여부를 내려 불합격된 제품에 대해서는 품질관리기술자와 협의하거나 해당 공정에 통보한다. 자동온도검사기, 제상검사기 등 계측기기를 관리하고 검사실시결과 및 검사실시현황을 관리하고 자료화한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"전자기기기능장, 전자산업기사, 전기산업기사, 전기기능사, 전자기능사","dJobECd":"1533","dJobECdNm":"[1533]전기·전자공학 시험원","dJobJCd":"2343","dJobJCdNm":"[2343]전기 및 전자공학 시험원","dJobICd":"C285","dJobICdNm":"[C285]가정용 기기 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002827:1', '{"dJobCd":"K000002827","dJobCdSeq":"1","dJobNm":"건전지품질검사원","workSum":"각종 검사기구들을 사용해서 건전지 제조에 사용되는 원료·부품 및 완제품 건전지의 기계·전기·화학적 특성을 검사한다.","doWork":"입도검사기·정량정성 분석기 등의 시험기구를 사용해서 건전지 원료의 품질을 검사한다. 완성된 알카라인전지를 시험용 선반 위에 고정하고 단자를 시험용 장치에 연결한다. 지정된 시간간격에 따라 고정 저항기로 전지를 방전시킨다. 시험장치의 계기를 읽고 전압을 기록한다. 외피수명을 측정하기 위해서 일정시간 동안 전지에 시험장치를 연결하고 결과를 기록한다. 시험결과를 바탕으로 보고서를 작성하기도 하고 개선방안을 관련부서에 제안하기도 한다. 새로운 화합물을 검사하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"건전지품질보증원","dJobECd":"1533","dJobECdNm":"[1533]전기·전자공학 시험원","dJobJCd":"2343","dJobJCdNm":"[2343]전기 및 전자공학 시험원","dJobICd":"C282","dJobICdNm":"[C282]일차전지 및 축전지 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005520:1', '{"dJobCd":"K000005520","dJobCdSeq":"1","dJobNm":"계측기기검사원","workSum":"교정검사설비 및 표준기를 사용하여 의뢰된 계측기기를 표준기 또는 검사설비를 사용하여 검사하거나 교정한다.","doWork":"작업표준에 의하여 검사기준서 및 검사표준서를 준비하고 숙지한다. 검사에 필요한 도구 및 장비를 준비하여 이상 유무를 확인한다. 전압계, 전류계, 지시계, 오실로스코프(Oscilloscope) 등 교정검사가 의뢰된 기기와 교정검사신청서를 확인하고 교정검사관리대장을 작성한다. 교정검사설비(교정용표준기:압력조절기, 저항기, 항온조, 압력계 등)를 사용하여 검사의뢰 계측기기와 교정용 표준기를 연결하고 허용오차 또는 편차를 측정한다. 허용오차 또는 편차에 따라 계측기기의 적부를 판단한다. 교정할 경우는 표준기의 편차만큼 조정기 등을 돌려 조정한다. 검사 및 교정 후 교정검사성적서를 관리책임자의 확인을 근거로 발행한다. 교정검사 외에 계측정보의 수집, 계측기술의 연구·개발계획수립, 교정검사절차표준화, 계측기기 관리업무도 수행한다. 교정된 계측기기의 내용을 기록하고 의뢰공정으로 돌려보낸다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"계측기기시험원, 계측기교정원","certLic":"정밀측정산업기사","dJobECd":"1533","dJobECdNm":"[1533]전기·전자공학 시험원","dJobJCd":"2343","dJobJCdNm":"[2343]전기 및 전자공학 시험원","dJobICd":"C272","dJobICdNm":"[C272]측정, 시험, 항해, 제어 및 기타 정밀기기 제조업; 광학기기 제외","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005910:1', '{"dJobCd":"K000005910","dJobCdSeq":"1","dJobNm":"고압케이블시험원","workSum":"고압케이블의 구조 및 전기적인 검사, 시험을 한다.","doWork":"작업지시서에 따라 시험, 검사할 고압케이블의 수량과 외관을 확인한다. 구조 검사를 위한 시료를 채취하여 구조 검사를 실시한다. 전기적인 시험을 위하여 케이블의 시단과 종단의 일정 길이를 벗긴 후 도체저항 측정, 절연저항 측정, 내전압 시험을 한다. 차폐된 공간 (쉴드룸)에서 유단말기를 활용하여 부분방전 시험과 케이블의 신뢰성 확인을 위한 임펄스 시험, 수단말기를 활용한 교류파괴 시험 등 전기적인 시험을 진행한다. 결과를 기록하고 합부 판정을 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"힘든 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"전선품질검사원","dJobECd":"1533","dJobECdNm":"[1533]전기·전자공학 시험원","dJobJCd":"2343","dJobJCdNm":"[2343]전기 및 전자공학 시험원","dJobICd":"C283","dJobICdNm":"[C283]절연선 및 케이블 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006914:1', '{"dJobCd":"K000006914","dJobCdSeq":"1","dJobNm":"광원구동회로부품시험원","workSum":"회로부품이 생산공정에 투입되기 전에 사전 시험을 실시하고 시험결과가 합의된 스펙에 부합되는지 평가한다.","doWork":"다양한 회로부품의 전기적, 기구적 특성이 약속된 스펙에 부합하는지를 판별한다. 신뢰성 시험과 전기적 시험 등을 의뢰하여 실제 제품에서 요구되는 환경에서 내구성이 있는지 검사하고 승인한다. 양산을 위해 구매과정에서 샘플을 검사하고 입고승인을 한다. 부품특성이 일관성이 떨어지거나 불량이 날 경우 해당부품 메이커와 협의하여 그 특성의 개선을 요구하거나, 설계자와 협의하여 해결한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"전자응용기술사, 전자기사, 전자산업기사","dJobECd":"1533","dJobECdNm":"[1533]전기·전자공학 시험원","dJobJCd":"2343","dJobJCdNm":"[2343]전기 및 전자공학 시험원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005514:1', '{"dJobCd":"K000005514","dJobCdSeq":"1","dJobNm":"광원구동회로품질관리사","workSum":"광원구동회로가 출하되기 전부터 보증 운영기간 내에 발생하는 회로에 대해 품질관리를 한다.","doWork":"조명제품 기업에 구동회로를 납품하기 전에 특성을 측정하여 최종 품질을 승인한다. 보증기간 내에 구동회로 운영 시 발생하는 품질문제에 대응한다. 파악된 품질문제를 설계자나 제조원 등 관련 부서와 공유한다. 품질문제를 해결하기 위한 재설계, 공정개선, 부품 개선활동을 진행하여 재발을 방지한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"광원구동회로품질보증원","certLic":"전자응용기술사, 전자기사, 전자산업기사","dJobECd":"1533","dJobECdNm":"[1533]전기·전자공학 시험원","dJobJCd":"2343","dJobJCdNm":"[2343]전기 및 전자공학 시험원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004608:1', '{"dJobCd":"K000004608","dJobCdSeq":"1","dJobNm":"리튬이온이차전지품질검사원","workSum":"각종 검사기구로 리튬이온2차전지에 사용되는 원료, 부품 및 완제품의 검사를 수행한다.","doWork":"리튬이온2차전지의 원료와 부품 입고 시 검수를 실시한다. 제품 제조 완료 시 전지검사장비를 사용하여 각종 수치를 얻어내고 기록한다. 불량품 발생 시 선별적재하고 원인을 분석하기 위해 각 생산라인에 보고한다. 전지시험기(충방전시스템)를 이용하여 소용량과 고용량의 측정을 달리한다. 환경시험기를 이용해 주변온도 성능시험을 한다. 진동시험기를 이용해 내구성시험을 한다. 디지털 레코더를 이용해 휴대용기기의 소모전력을 측정하며, 레코더를 이용해 전지전압을 측정하며, 디지털전력계를 이용해 기기의 사용전력을 측정한다. IR 테스터를 이용해 전지의 내부저항 측정을 하며, 디지털 파워 서플라이를 이용해 DC전력인가와 AC입력특성 시험을 한다. 절연측정기를 이용해 절연저항 측정을 하며, 고압충격기를 이용해 내전압시험을 한다. 각종 검사내용을 컴퓨터에 입력을 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"소음·진동|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"화학분석기능사","dJobECd":"1533","dJobECdNm":"[1533]전기·전자공학 시험원","dJobJCd":"2343","dJobJCdNm":"[2343]전기 및 전자공학 시험원","dJobICd":"C282","dJobICdNm":"[C282]일차전지 및 축전지 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001569:1', '{"dJobCd":"K000001569","dJobCdSeq":"1","dJobNm":"반도체장비성능평가기술자","workSum":"반도체장비의 기구장치, 전기장치, 주변장치, 배관부품 및 응용 공정기술을 이해하고, 장비 단위동작, 전장배선, 세부동작 및 전체완성 성능 평가, 보완, 검증 작업을 수행한다.","doWork":"반도체장비의 기구장치, 전기장치, 주변장치 및 배관부품의 조립상태를 확인하고, 도면에 기준하여 각 장치를 설치한 다음, 전원을 공급한다. 기구장치, 주변장치 및 배관부에 가스, 초순수 및 화학약품 등 유체를 공급하여 조립 신뢰성을 확인, 보완작업을 수행한다. 로봇·모터 등 기구장치, 전기장치, 유체공급장치의 단위동작 성능을 평가, 교정, 검증 작업을 수행한다. Main 및 Control PC에 소프트웨어 프로그램을 설치한 다음, 프로그램의 정상 실행 여부를 평가, 수정한다. 주요 장치부에 대한 시스템 입출력 특성 점검을 통해 교정 및 수정 작업을 실시하고, 문제발생에 따라 보완계획을 수립하여 조치한다. 각 장치부의 제어기, 센서, 밸브, 스위치 및 레귤레이터 등 주요 제어부품의 성능을 평가하고, 보완한다. 반도체장비 및 공정 신뢰성 평가를 위해 공정대상 기판, 각종 화학약품, 광학부품 및 검사보드의 구성, 동작 및 특성을 이해한다. 장비 주요 기구부에 기판 또는 유체를 공급하여 하드웨어 및 소프트웨어 신뢰성 평가를 실시하고, 보완한다. 각 배관부와 연결된 유체공급장치, 펌프, 가스 캐비닛, 스크러버 등 주변 장치의 성능 평가를 실시하고, 보완한다. 반도체장비 전체 운영 소프트웨어 프로그램을 이용하여 고객 요구수준을 만족할 수 있도록 장비 신뢰성 평가, 보완, 검증 작업을 반복 수행한다. 반도체 기술로드맵 및 고객 요구 수준에 적합한 단위공정 신뢰성 평가를 실시하고, 보완, 검증 작업을 반복 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"반도체 장비기술자","dJobECd":"1533","dJobECdNm":"[1533]전기·전자공학 시험원","dJobJCd":"2343","dJobJCdNm":"[2343]전기 및 전자공학 시험원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002465:1', '{"dJobCd":"K000002465","dJobCdSeq":"1","dJobNm":"발전전기공무기술원","workSum":"발전소의 원활한 운영을 위하여 발전전기설비의 유지·정비를 위한 제반 기술공무를 수행한다.","doWork":"발전소의 원활한 가동 및 정지를 위하여 발전기, 전동기, 차단기류, 보호장치, 조명설비, 배전설비 및 관련 발전전기설비를 유지·정비한다. 발전전기설비의 유지·보수를 위하여 관련 정비업체의 설계도면, 기술절차서, 작업사항 등을 제시하고 규정대로 작업을 수행하는지 관리·감독한다. 발전전기설비의 유지를 위하여 도면 및 각종 절차서 등의 기술자료를 체계적으로 관리한다. 발전소의 효율적인 운영을 위하여 운전절차, 정비 등에 따른 품질관리 및 안전관리를 한다. 발전기계설비의 유지·정비를 위한 예비자재 관리와 공구 및 계측기의 품질관리를 한다. 설비의 수명예측, 고장원인 예측 등을 통한 예산수립과 정비 및 안전관리절차서를 개발하고 발간하여 효율적인 유지·관리가 되도록 한다. 발전소 내의 효율적인 에너지관리를 위하여 소비전력에 대한 관리업무를 한다. 발전전기설비의 효율적 운영을 위하여 발전설비를 운전하는 작업자에 대한 직무교육계획을 수립하고 실시한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"발전전기설비공무기술원","certLic":"전기기사, 전기공사기사, 일반기계기사, 산업안전기사, 정보처리기사","dJobECd":"1533","dJobECdNm":"[1533]전기·전자공학 시험원","dJobJCd":"2343","dJobJCdNm":"[2343]전기 및 전자공학 시험원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004863:1', '{"dJobCd":"K000004863","dJobCdSeq":"1","dJobNm":"발전제어공무기술원","workSum":"발전소의 원활한 운영을 위하여 발전제어설비의 유지·정비를 위한 제반 기술공무를 수행한다.","doWork":"발전소의 원활한 가동과 유지를 위하여 발전제어설비를 유지·정비하고 설비개선을 위한 제반 작업을 한다. 제어설비의 운전조작을 위한 사용설명서 및 매뉴얼을 제작하고 교육한다. 발전제어설비의 고장발생 시 신속히 상위 부서에 보고하고 해결하며 재발방지를 위한 고장사항관리를 한다. 도면 및 각종 절차서 등의 기술자료를 체계적으로 관리하고 기술점검에 대한 사항을 보고한다. 발전설비에 대한 법정검사에 대한 대관업무를 한다. 발전제어설비에 대한 수명관리, 사고예방, 정비계획 수립 등을 위하여 발전제어설비에 대한 기기대장 관리를 한다. 기타 발전제어설비의 효율적 운영과 유지·관리를 위한 제반 업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"발전제어설비공무기술원","certLic":"발송배전기술사, 전기기사","dJobECd":"1533","dJobECdNm":"[1533]전기·전자공학 시험원","dJobJCd":"2343","dJobJCdNm":"[2343]전기 및 전자공학 시험원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007742:1', '{"dJobCd":"K000007742","dJobCdSeq":"1","dJobNm":"사용후배터리평가사","workSum":"배터리로 구동되는 장비 및 장치(소형가전, 전동킥보드, 전기자전거, 지게차, 전동카트, 전기자동차, 에너지저장장치) 등에서 회수된 사용후 이차전지 배터리의 성능 상태를 측정하고 재사용 또는 재활용 여부를 평가하며, 배터리의 수명과 안전성을 유지하기 위한 진단, 관리, 화재 예방 등의 업무를 수행한다.","doWork":"사용후 배터리의 외관 손상, 변형, 누액, 이상 발열 등 외관 기본 상태를 사전 점검한다. 진단장비 및 계측기를 활용하여 셀(Cell), 모듈(Module), 팩(Pack)의 전압, 내부저항, 잔존용량(SOH), 충전상태(SOC) 등을 측정한다. 측정 데이터를 기반으로 배터리의 성능을 분석하고 등급 분류(Grade 분류)를 한다. 평가 결과에 따라 재제조, 재사용 또는 재활용 등의 적절한 처리 방향을 제안한다. 배터리 상태 및 진단 결과를 데이터베이스에 기록하고, 성능 보고서를 작성한다. 작업장 내 배터리 보관환경(온도, 습도, 진동 등)을 관리하며, 안전보호장치(열 감지 센서, 연기 센서, 리튬배터리용 소화기 등)를 활용해 예방 조치를 수행한다. 정기적인 배터리 진단 계획을 수립하고, 필요한 경우 재진단을 시행하거나 수명 예측을 수행한다. 관련 장비 유지보수 및 성능교정을 시행하며, 고객 또는 협력사에 기술 자문을 제공하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"청각|손사용|시각|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"중고배터리진단사, 사용전지평가원","connectJob":"리튬이온이차전지품질검사원","dJobECd":"1533","dJobECdNm":"[1533]전기·전자공학 시험원","dJobJCd":"2343","dJobJCdNm":"[2343]전기 및 전자공학 시험원","dJobICd":"C282/E383/M721","dJobICdNm":"[C282]일차전지 및 축전지 제조업 / [E383]해체, 선별 및 원료 재생업  / [M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2025"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002249:1', '{"dJobCd":"K000002249","dJobCdSeq":"1","dJobNm":"송풍기성능시험원","workSum":"생산된 송풍기의 전압, 정압, 공기량, 축동력, 전압효율, 소음, 운전상태 등을 시험한다.","doWork":"조립공정이 완료된 송풍기를 검사하기 위해 검사기록지를 준비하거나 컴퓨터 프로그램을 준비한다. 관련된 규정(KS B 6311)에 의거하여 성능시험을 하며 풍량, 압력, 축동력, 효율, 회전수 등을 그래프로 표시하여 기록한다. 그래프 횡축에 풍량을 표시하고 종축에 압력, 축동력, 회전수 등을 표시한다. 성능 특성 곡선상에서 송풍기의 성능 및 풍량조절 시 예상이 되는 성능을 발견한다. 합격된 송풍기는 합격증을 붙이고 제품출하를 위해 대기를 시킨다. 불량품은 관련 부서와 협의를 하여 시정조치를 취한다. 시험기록지를 작성하고 검사일지를 관리하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"송풍기시험원","connectJob":"송풍기 크기에 따라 팬성능시험원, 블로워성능시험원","dJobECd":"1533","dJobECdNm":"[1533]전기·전자공학 시험원","dJobJCd":"2343","dJobJCdNm":"[2343]전기 및 전자공학 시험원","dJobICd":"C291","dJobICdNm":"[C291]일반 목적용 기계 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003317:1', '{"dJobCd":"K000003317","dJobCdSeq":"1","dJobNm":"엘이디조명기구품질검사원","workSum":"엘이디(LED)조명기구의 생산과정에서 품질을 시험·검사한다.","doWork":"엘이디(LED)조명기구가 생산규격에 맞게 생산되었는지 검사하기 위하여 생산제품을 샘플링하여 제품의 소비전력(W), 조명효율(lm·W), 색온도, 연색지수 등 전기적·광학적 특성을 시험장비를 통해 검사한다. 기구적인 특성이 반영된 시방서에 따라 조립 및 체결 상태가 적절하게 생산되었는지 검사한다. 제품의 이상이 있을 경우 원인을 분석하고 조치를 취한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"LED조명기구품질검사원, LED등기구품질검사원, 엘이디등기구품질검사원","dJobECd":"1533","dJobECdNm":"[1533]전기·전자공학 시험원","dJobJCd":"2343","dJobJCdNm":"[2343]전기 및 전자공학 시험원","dJobICd":"C284","dJobICdNm":"[C284]전구 및 조명장치 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002877:1', '{"dJobCd":"K000002877","dJobCdSeq":"1","dJobNm":"연료전지스택품질검사원","workSum":"조립과 컨디셔닝이 완료된 스택(STACK)을 성능평가분석 장비와 연결시켜 스택의 정상작동 여부를 시험한다.","doWork":"조립과 컨디셔닝이 완료된 스택을 성능평가분석 장비와 연결시켜 스택으로 연료(수소, CO2, 공기, 질소 등)를 공급·제어하여 연료전지의 전압, 전류, 온도, 전자부하, 내구성시험, 프로토콜 시험 등을 통해 스택의 품질수준을 점검한다. 이상발생 시 그 원인을 분석하여 제조공정상에서 수정이 가능하도록 협력한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","similarNm":"스택성능시험원, Stack성능시험원, 스택품질검사원","dJobECd":"1533","dJobECdNm":"[1533]전기·전자공학 시험원","dJobJCd":"2343","dJobJCdNm":"[2343]전기 및 전자공학 시험원","dJobICd":"C282","dJobICdNm":"[C282]일차전지 및 축전지 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006096:1', '{"dJobCd":"K000006096","dJobCdSeq":"1","dJobNm":"자동차검사기기검사원","workSum":"자동차검사소, 자동차제작사, 자동차정비업체 및 시·도 환경단속기관에서 사용하고 있는 안전도 측정기기 및 환경 측정기기의 올바른 정도 유지를 위하여 주기적으로 안전도를 검사한다.","doWork":"자동차 안전도 측정기기인 사이드 슬립 측정기, 제동 시험기, 속도계 시험기, 전도등 시험기와 환경 측정기기인 소음 측정기, 매연 측정기, 일산화탄소·탄화수소·공기과잉률 측정기를 검사한다. 검사기기 고장 시 이를 수리한다. 검사자료를 보관 및 관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"수동조작","dJobECd":"1533","dJobECdNm":"[1533]전기·전자공학 시험원","dJobJCd":"2343","dJobJCdNm":"[2343]전기 및 전자공학 시험원","dJobICd":"M729","dJobICdNm":"[M729]기타 과학기술 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004400:1', '{"dJobCd":"K000004400","dJobCdSeq":"1","dJobNm":"저압전선시험원","workSum":"전선의 품질을 검사하기 위하여 외관 및 구조 검사, 도체 저항, 절연 저항과 내전압 시험 등을 수행한다.","doWork":"작업지시서에 따라 시험, 검사할 제품의 수량과 외관을 확인한다. 구조 검사를 위한 시료를 채취하여 구조 검사를 실시한다. 전기적인 시험을 위하여 케이블의 시단과 종단의 일정 길이를 벗긴 후 도체저항 측정, 절연저항 측정, 내전압 시험 등 전기적인 시험을 진행한 후 결과를 기록하고 합부 판정을 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"전선품질시험원","dJobECd":"1533","dJobECdNm":"[1533]전기·전자공학 시험원","dJobJCd":"2343","dJobJCdNm":"[2343]전기 및 전자공학 시험원","dJobICd":"C283","dJobICdNm":"[C283]절연선 및 케이블 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006039:1', '{"dJobCd":"K000006039","dJobCdSeq":"1","dJobNm":"전기자동차전장품개발시험원","workSum":"전기자동차의 파워컨트롤유닛(PCU), 릴레이(EV-Relay) 등 주요 전장품의 성능, 환경 및 내구성 시험을 계획하고 시험장비를 이용하여 시험한다.","doWork":"파워컨트롤유닛(PCU)의 경우 구동모터를 동작하기 위한 인버터의 신뢰성을 보장하기 위해 최대정격, 가용온도, 분당회전수(RPM) 제어 등에 대해 시험을 한다. 릴레이는 거친 작동환경에서 안전한 가동을 하는지, 전기기계적으로 견고성을 유지하는지, 오랜기간 사용가능한지 등을 검사한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"그린전동자동차기사","dJobECd":"1533","dJobECdNm":"[1533]전기·전자공학 시험원","dJobJCd":"2343","dJobJCdNm":"[2343]전기 및 전자공학 시험원","dJobICd":"C303","dJobICdNm":"[C303]자동차 신품 부품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007035:1', '{"dJobCd":"K000007035","dJobCdSeq":"1","dJobNm":"전기장비검사원","workSum":"작업표준 및 검사기준에 따라 각종 시험기기 및 계측기기를 사용하여 전동기, 변압기, 전기공급 및 제어장치 등의 조립상태와 성능을 검사·시험한다.","doWork":"작업표준 및 검사기준에 따라 공정관리기록표와 관련 도면을 준비하고 점검한다. 각각의 제품에 따라 전압측정계측기기, 내전압절연저항기 등과 같은 검사기기로 외관상태, 전압, 부하, 출력, 소음 등의 검사를 실시한다. 검사 후 검사대상제품의 문제점이 있을 시 원인을 분석한다. 전기안전기준에 따라 제품의 불량 여부를 판정하고 불량부분을 기록하여 보고한다. 검사결과의 품질관리리스트를 작성한다. 불량제품을 표기하여 분리하고 재가공부서로 이송한다. 이상이 없는 제품에 검사필증을 부착하고 시험성적표 등을 첨부한다. 출하를 위하여 적재보관소로 이송한다. 검사장비 및 검사설비장치를 정돈하고 주위를 정리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"전기기기검사원, 전기기기시험원, 전기장비시험원, 전기장비품질검사원, 전기기기품질검사원, 전기장비품질시험원, 전기기기품질시험원","certLic":"전기산업기사, 전기기사","dJobECd":"1533","dJobECdNm":"[1533]전기·전자공학 시험원","dJobJCd":"2343","dJobJCdNm":"[2343]전기 및 전자공학 시험원","dJobICd":"C281","dJobICdNm":"[C281]전동기, 발전기 및 전기 변환ㆍ 공급ㆍ제어 장치 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005575:1', '{"dJobCd":"K000005575","dJobCdSeq":"1","dJobNm":"전자의료장비품질검사원","workSum":"조립된 의료장비의 조립상태 및 기능의 결함을 확인하기 위하여 각종 계측기기를 사용하여 성능, 안전성, 외관 등을 검사한다.","doWork":"작업표준에 의하여 제품에 따른 검사항목을 확인하고 그에 따른 검사기준서 및 검사표준서를 준비하고 숙지한다. 검사에 필요한 전기전자계측기기, 방사선·전자파계측기기 등의 계측기기 및 시험기기를 준비하고 이상 유무를 점검한다. 검사된 각 단위별 조립완료 부품을 하나의 시스템으로 구성하여 실제 사용했을 때와 같은 환경을 구축한다. 의료기기의 성능 및 품질검증에 필요한 시험규격에 맞춰 전기전자 계측기기를 사용하여 누설전류시험, 내전압시험, 전지저항시험 등의 전기·기계적 안전성을 검사한다. 방사선계측기나 전자파계측기 등을 사용하여 의료기기 촬영 시 발생하는 방사선양, 초음파출력량, 전자파 장해정도, 스캐너 주사성능 등과 같은 측정 시험검사를 한다. 도금이나 도장, 각 부분별 장치의 위치 등의 외관검사를 한다. 검사가 완료된 의료장비의 경우 수량을 기록하고 포장공정으로 이송시키고 각종 검사시험치가 제품의 규격치 및 성능에 부합하지 않은 경우 수리공정 또는 조립공정파트에 업무를 이관한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"전자의료기기품질검사원, 전자의료기기시험원","connectJob":"기기의 종류에 따라 초음파의료기검사원, 뇌파기검사원, 심전도기검사원, 마취기검사원, 심장세동제거기검사원, 투석기검사원, MRI검사원, CT스캐너검사원, X-Ray검사원, 전자혈압측정계검사원, 전자당뇨측정계검사원, 광학기계검사원","certLic":"전기기능사, 전기산업기사, 전자산업기사, 전자기능사","dJobECd":"1533","dJobECdNm":"[1533]전기·전자공학 시험원","dJobJCd":"2343","dJobJCdNm":"[2343]전기 및 전자공학 시험원","dJobICd":"C271","dJobICdNm":"[C271]의료용 기기 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003195:1', '{"dJobCd":"K000003195","dJobCdSeq":"1","dJobNm":"조명검사원","workSum":"육안, 각종 도구 및 전등 검사기구를 사용해서 전구의 구조, 외관, 전압, 전류, 광속 등을 검사한다.","doWork":"육안으로 완성된 전구의 외관을 검사하여 이상 여부를 확인한다. 버니어 캘리퍼스(Vernier Calipers:현장용 정밀측정구의 일종) 등의 기구로 표본 전구의 치수를 측정한다. 칼 등의 도구로 과잉의 땜납을 제거한다. 접착강도시험기와 온도상승시험기 등으로 유리구와 베이스의 접착강도와 점등 시 베이스의 온도를 검사한다. 시험할 전등을 구형광속기(적분구) 내부에 장착한다. 구형광속기를 닫고 점등스위치를 올려서 전구의 광속과 광속의 일정성 등을 시험·검사한다. 신뢰성수명시험기를 사용해서 전구의 수명을 검사한다. 전압·전류기를 사용해서 전구의 전기적 특성을 검사하고 전구특성시험기를 사용해서 전구의 내구성을 시험한다. 기준 미달의 불량품이나 문제점이 발견될 경우 불량의 원인을 분석하고 관련 부서나 생산라인에 통보하고 시정 여부를 확인한다. 개선 및 불량사항에 대해서 관련 제품개발부서에 통보하고 개선을 건의한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"위험내재|소음·진동|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"전등시험원, 조명등검사원, 조명등시험원, 조명등품질검사원, 조명등품질시험원","connectJob":"백열등검사원, 수은등검사원, 형광등검사원","certLic":"품질경영산업기사","dJobECd":"1533","dJobECdNm":"[1533]전기·전자공학 시험원","dJobJCd":"2343","dJobJCdNm":"[2343]전기 및 전자공학 시험원","dJobICd":"C284","dJobICdNm":"[C284]전구 및 조명장치 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002309:1', '{"dJobCd":"K000002309","dJobCdSeq":"1","dJobNm":"철도차량전기검사원","workSum":"명세서와 도면에 따라 철도차량의 각종 기기 및 배전반 등의 배선 및 결선상태를 검사한다.","doWork":"작업지시서 및 검사절차서를 보고 검사방법을 숙지한다. 전기기계 도면과 전기·전자도면을 파악하여 전기배선의 위치와 구조를 확인한다. 작업에 필요한 측정장비(절연저항측정기, 접지저항측정기, 클램프메타(Clamp Meter:회로를 절단하지 않고도 회로 전류를 알 수 있는 변류기 내장형의 전류계), 만능회로측정기)를 준비한다. 규정된 전기·전자장치의 작동상태 및 규정된 조립의 측정값을 확인·검사한다. 각 기기의 통전시험을 통하여 문제가 없는지 확인한다. 측정하고자 하는 배선의 양끝을 측정기에 접속시킨다. 벨의 울림으로 단락 여부를 판정한다. 절연시험기를 사용하여 대지와의 절연저항을 측정한다. 명세서에 의거 절연저항의 이상 여부를 판정하고 불량부분은 그 원인을 추적하여 보수한다. 시험하고자 하는 기기를 내전압시험기에 연결한다. 내압시험기를 작동하여 회로의 내압시험을 한다. 검사결과를 기록양식에 기재한다. 고장부위를 찾아주는 통합점검시스템을 사용하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|손사용|","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"철도차량배선검사원, 철도차량전기장치검사원, 철도차량전기기기검사원","certLic":"철도차량정비기능장, 철도차량기능사, 전기철도산업기사, 전기철도기능사","dJobECd":"1533","dJobECdNm":"[1533]전기·전자공학 시험원","dJobJCd":"2343","dJobJCdNm":"[2343]전기 및 전자공학 시험원","dJobICd":"C312","dJobICdNm":"[C312]철도장비 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006310:1', '{"dJobCd":"K000006310","dJobCdSeq":"1","dJobNm":"축전지검사원","workSum":"각종 검사기구들을 사용해서 완제품 축전지를 테스트하고, 축전지 제조에 사용되는 원료 및 부품을 검사·시험한다.","doWork":"성분분석기, 마이크로미터 등 검사기구를 사용해서 연괴, 황산, 격리막, 합성수지 등의 축전지 원료의 외관·치수 및 성분을 검사한다. 잘못된 부품을 불합격시키고 검사보고서를 작성한다. 규정된 작업방법에 따라 축전지를 분해하여 그리드(격자), 납 부품의 순도를 측정하고 전해액의 농도 및 용량을 검사한다. 저온상태와 수중에서 축전지의 성능을 시험하기 위해 축전지를 냉장고나 물탱크에 넣는다. 전류량이 일정률로 흐르는가를 판단하기 위해서 축전지를 충·방전시키는 설비에 연결한다. 테스트에 합격한 완성품에 합격증과 인쇄물을 붙이고 포장을 하여 출하준비를 한다. 제조상의 결함을 발견하고 품질 개선방안에 대한 보고서를 작성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"축전지품질관리원, 축전지시험원, 축전지품질검사원, 축전지품질시험원","certLic":"품질경영산업기사","dJobECd":"1533","dJobECdNm":"[1533]전기·전자공학 시험원","dJobJCd":"2343","dJobJCdNm":"[2343]전기 및 전자공학 시험원","dJobICd":"C282","dJobICdNm":"[C282]일차전지 및 축전지 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005673:1', '{"dJobCd":"K000005673","dJobCdSeq":"1","dJobNm":"컴퓨터시제작원","workSum":"신개발 제품 또는 기존 제품의 변경 시 설계도면 및 부품목록표 등이 생산에 적합한 지 시제품을 조립하여 타당성을 검사한다.","doWork":"설계부서에서 작성된 신제품 혹은 설계변경제품의 시제작용 설계도면과 부품목록표를 확인하고 제품의 구조와 부품의 누락 여부를 점검한다. 부품목록표에 표시된 시제작용 부품을 사용하여 조립한다. 시제작 시 발생되는 문제점을 분석·보고한다. 작업성에 대한 문제점을 정리하여 기술자료화하고 공정도를 작성한다. 제조부서에서 합리적인 생산활동을 수행할 수 있도록 제품별 공정도, 시제작품 조립내용, 제조작업조건, 부품목록표, 명세서 등을 검토한 후 작업표준을 작성하여 제조부서에 배포한다. 양산(量産)시작 및 양산상의 문제점을 조사·분석하여 작업표준을 수정·보완하고 담당기사의 확인을 받은 후 현장적용토록 조치한다. 기술자료, 공정도, 작업지도서 등을 참고하여 양산시작 시 기술지도를 한다. 양산 시 발생되는 문제점을 조사·분석한 후 대책을 수립한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"전자계산기제어산업기사","dJobECd":"1533","dJobECdNm":"[1533]전기·전자공학 시험원","dJobJCd":"2343","dJobJCdNm":"[2343]전기 및 전자공학 시험원","dJobICd":"C263","dJobICdNm":"[C263]컴퓨터 및 주변장치 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002719:1', '{"dJobCd":"K000002719","dJobCdSeq":"1","dJobNm":"항공기전자통신검사원","workSum":"항공기의 무선통신 장비, 항법장비, 레이더 등의 장치와 디스플레이 상태를 검사한다.","doWork":"작업지시서 내용에 따라 정기점검인 경우 점검해야 할 항목, 비행 중 이상이 발생한 항공기의 경우에는 결함 부위를 확인한다. 정기점검인 경우 정해진 순서에 따라서 테스트를 하고, 결함이 있는 항공기의 경우에는 결함 발생 계통을 작동시켜 고장이 나거나 이상이 있는 결함 부분을 테스트한다. 이상과 원인이 발견되면, 발견한 결함사항을 수정하기 위하여 관련 서류를 작성한다. 부품을 교환할 경우, 작업공정이 기술도면이나 작업지시서의 절차대로 실시되는지 확인한다. 작업이 완료되면, 작업결과가 정해진 감항성(Airworthiness:항공기가 비행에 적합한지에 대한 안전성 및 신뢰성)과 일치하는지 확인한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"항공기전자통신장비검사원, 항공기전자통신기기검사원","certLic":"항공정비사, 항공전기·전자정비기능사","dJobECd":"1533","dJobECdNm":"[1533]전기·전자공학 시험원","dJobJCd":"2343","dJobJCdNm":"[2343]전기 및 전자공학 시험원","dJobICd":"C313","dJobICdNm":"[C313]항공기, 우주선 및 부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001533:1', '{"dJobCd":"K000001533","dJobCdSeq":"1","dJobNm":"CAM프로그래머","workSum":"가공하고자 하는 제품(부품)을 완성하기 위하여 모델링 데이터를 이용하여 최적의 가공조건을 설정, NC 데이터(Program)를 생성한다.","doWork":"작업계획수립, 작업 관련 정보수집, 시간계획, 공정작업내용을 계획·점검한다. 기계가공작업에 있어서 전체적인 조립관계를 고려하여 작업계획을 수립하고 작업도구 사용을 결정하기 위한 도면을 해독한다. CNC 선반 장비의 조작법을 익히고 절삭공구를 사용하여 부품의 제작과 측정을 한다. 도면을 보고 작업공정을 설정하고 G 코드와 보조기능을 이용해서 그리고 CAM 시스템에서 CNC 선반 프로그램을 작성한다. CNC 밀링(머시닝센터) 장비의 조작법을 익히고 절삭공구를 사용하여 부품의 제작과 측정한다. 도면을 보고 작업공정을 설정하고 수동으로 그리고 CAM 시스템에서 윤곽과 구멍 가공 공정에 대한 CNC 밀링(머시닝센터) 가공 프로그램을 작성한다. 도면을 보고 작업공정을 설정하고 CAM 시스템에서 CNC 복합 가공 프로그램을 작성하고, CNC 밀링 작업공정을 설정하고 CAM 시스템에서 5축 가공 프로그램을 작성한다. 도면을 보고 작업공정을 설정하고 CAM 시스템에서 CNC 방전 가공 프로그램을 작성하고 도면을 검토하여 작업요구사항 결정, 가공조건 설정, 시작점 홀 가공 등을 설정하여 CAM 시스템에서 와이어컷 프로그램을 작성한다. CAM 작업에 있어서 안전수칙을 확인하여 준수한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"금형프로그래머","connectJob":"프레스금형설계기술자, 플라스틱금형설계기술자, 주조금형설계기술자, 사출금형설계기술자, 금형CAE기술자","certLic":"사출금형설계기사, 프레스금형설계기사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"C243","dJobICdNm":"[C243]금속 주조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001563:1', '{"dJobCd":"K000001563","dJobCdSeq":"1","dJobNm":"DP운항사","workSum":"특수선박과 해양플랜트 지원 선박에 설치되어 운항시 선박의 유지를 자동적으로 유지하도록 기능하는 해양플랜트 동적위치제어시스템(Dynamic Positioning System)을 운용하고 관리한다.","doWork":"해양플랜트구조물 또는 해양지원선박 등이 해양에서 정밀작업을 수행하기 위한 동적위치제어시스템을 운용하는 역할을 수행한다. 동적위치제어시스템의 운용을 통하여 수행되는 작업이 안전하게 진행될 수 있도록 총괄하여 감독한다. 동적위치제어시스템의 고장발생 시 진행 중인 작업이 안전하게 중단될 수 있도록 비상대응을 수행한다. 동적위치제어시스템의 정상작동을 위하여 시스템의 구성요소를 점검하고 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내·외","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","certLic":"Dynamic Positioning Operator Certificate (NI)","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007821:1', '{"dJobCd":"K000007821","dJobCdSeq":"1","dJobNm":"OLED조명개발자","workSum":"OLED조명 제품을 개발하기 위하여 개발환경 분석 및 개발계획을 수립하고, 기구와 회로를 개발하여 시제품 제작, 시험분석, 개발제품인증, 양산이관을 수행한다.","doWork":"고객의 요구와 성능을 충족하는 OLED 조명제품을 개발하기 위하여 OLED 조명제품의 시장, 기술 및 지식재산권 분석을 바탕으로 개발타당성을 검토한다. 시장, 고객의 다양한 요구조건에 맞는 제품을 개발하기 위하여 패널규격과 배광특성을 분석하고 응용분야에 따라 핵심기능이 포함된 개발계획을 수립한다. OLED 조명의 성능과 제품의 완성도를 고려하여 발광부의 물리적 특성과 광학적 성능을 향상시키고 기구의 활용도를 높일 수 있도록 설계한다. OLED 조명의 특성과 요구사항에 부합하도록 전기적, 광학적, 열적 특성 및 수명을 고려하여 회로를 설계, 검증, 개선한다. 시제품의 성능 이상 유무를 확인하기 위하여 제품의 회로부와 기구부의 양산용 부품을 적용하여 시제품을 제작하고 검증한다. 개발제품이 수요자 요구에 적합한가를 확인하기 위하여 시험분석 계획에 따라 다양한 환경에서 제품을 성능을 시험하고 분석한다. 개발된 조명제품의 판매를 위하여 안전, 효율 및 환경에 적합한 인증을 획득하고, 규정 및 기준에 따라 사후관리한다. 양산 품질을 확보하기 위하여 각 단계에서 필요로 하는 양산문서를 작성하고 양산을 지원하며 문제점을 개선한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"C284","dJobICdNm":"[C284]전구 및 조명장치 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002767:1', '{"dJobCd":"K000002767","dJobCdSeq":"1","dJobNm":"가스계량설비연구원","workSum":"수요자에게 공급한 가스를 정확하게 측정하기 위한 가스계량설비 및 측정방법, 지능형 가스계량기를 연구·개발한다.","doWork":"각종 가스계량설비(수요처에 공급되는 가스의 유량을 측정하기 위한 설비)와 계측설비를 정확히 측정·검사하는 교정검사설비를 연구·개발 한다. 가스계량설비의 설치조건(초저온, 초고온, 빗물과 직사광선 등), 가스배관망 내부의 가스상태에 따른 영향 등을 분석한다. 기존에 설치된 가스배관망을 해석하여 가스공급에 최적화된 배관망의 배치, 최적위치의 공급기지 및 공급압력 등에 대한 연구를 한다. 공급관리소 계량설비의 이상 및 장애요인을 분석하여 설비개선을 위한 연구를 한다. 원격으로 검침하고 가스를 차단하는 지능형 가스계량기(Smart Gas Meter)를 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workEnv":"대기환경미흡|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"가스산업기사, 가스기사, 가스기술사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"D352","dJobICdNm":"[D352]연료용 가스 제조 및 배관공급업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006489:1', '{"dJobCd":"K000006489","dJobCdSeq":"1","dJobNm":"가스기기안전성연구원","workSum":"가스기기의 효율성과 안전성 확보를 위한 각종 시험을 실시하고 각종 연소기기의 성능 및 안정성을 연구한다.","doWork":"보일러, 야외용 연소기, 렌지류, 오븐 등 다양한 가스이용기기의 제반 기술을 연구한다. 가스연소기에 대한 CE마킹(Communaute Europeenne Marking:환경 및 소비자보호와 관련해 EU이사회 지침의 요구사항을 모두 만족한다는 의미의 통합규격인증마크), KS(한국산업규격)인증시험을 실시한다. 열병합시스템(가스를 연료로 하여 전력 및 열에너지를 동시에 얻을 수 있는 가스엔진, 가스터빈 등), 가스를 이용한 냉·난방을 겸할 수 있는 흡수식 냉온수기, 연료전지 시스템(천연가스를 개질(改質)하여 제조된 수소와 공기 중의 산소 사이의 전기화학적 반응을 이용하여 직접 전력에너지를 얻는 기술) 및 연계 제어기술 등을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"가스산업기사, 가스기사, 가스기술사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"D352","dJobICdNm":"[D352]연료용 가스 제조 및 배관공급업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002894:1', '{"dJobCd":"K000002894","dJobCdSeq":"1","dJobNm":"가스설비안전성연구원","workSum":"가스를 생산·공급하는 장치 및 설비의 안전성을 분석하고 안전성 향상을 위한 기술을 연구·개발한다.","doWork":"가스생산기지의 하역설비, 저장설비, 액화설비, 공급설비 등 생산설비에 대한 안전기술을 연구한다. 가스공급관리소의 가스필터, 가스히터, 방산탑 등 공급설비의 안전기술을 연구한다. 가스생산 및 공급설비의 위험범위와 위험수준을 측정·평가하여 안전관리방안과 대책을 수립한다. 소음, 방진, 내진 등으로부터 설비를 보호하고 안전성을 확보하는 기술을 연구·개발한다. 집중감시기술(U-IT 접목 가스안전관리기술, 가스설비시스템 통합기술, U기반 안전인프라기술 등)을 연구·개발한다. 비파괴평가방법에 따른 진단·검사의 신뢰성평가 연구, 위험도 등급별 안전관리기술표준화 연구 등을 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workEnv":"대기환경미흡|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"가스산업기사, 가스기사, 가스기술사, 기계설계산업기사, 기계기술사, 일반기계기사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"D352","dJobICdNm":"[D352]연료용 가스 제조 및 배관공급업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002215:1', '{"dJobCd":"K000002215","dJobCdSeq":"1","dJobNm":"건축설비설계기술자","workSum":"건축구조물의 기계설비를 구성하기 위하여 기본계획을 수립하고 설계도를 작성한다.","doWork":"건축구조물의 설비설계에 필요한 기후조건, 건물주의 요구사항 등 기초적인 자료를 조사·검토한다. 건축, 소방, 설비 등의 관련 법규 및 경제성을 검토한다. 설비, 설계에 대한 개략적인 시스템을 구상하고, 주요기기의 용량을 산정하여 기본계획을 수립한다. 태양열, 환기조건, 전열기, 인체에 미치는 영향, 환경 및 환기부하를 계산하여 각 시스템의 흐름도를 작성하고 주요기기의 용량, 위치 등을 고려하여 기본설계를 한다. 기계설비의 상세설계를 위한 부하와 기기용량을 분석하고 수치로 산출하여 배관, 수송관의 평면도, 단면도, 상세도 및 공사시방서를 작성한다. 시공 시 발생하는 문제점을 해결하고 기술을 지원한다. 시공 전이나 시공 후에 기계설비에 대해 감독하고 감리하는 업무를 수행하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"감독","workFunc3":"설치","connectJob":"위생설비설계기술자, 소화설비설계기술자","certLic":"건축설비산업기사, 건축설비기사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"F422/M721","dJobICdNm":"[F422]건물설비 설치 공사업 / [M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003552:1', '{"dJobCd":"K000003552","dJobCdSeq":"1","dJobNm":"고도물처리플랜트기술자","workSum":"수자원의 취수, 공급, 재생과 관련된 송·배관시스템과 수처리플랜트를 설계하고 설비의 제작, 시공을 관리·감독한다.","doWork":"수자원의 취수, 공급, 재생과 관련된 송·배관시스템과 처리설비와 부분품의 용량, 재질 등을 플랜트의 규모와 용도에 맞게 설계하고 결정한다. 건설과정에서 플랜트 내의 각종 설비 등이 안전하게 제작되고 설치될 수 있도록 관리·감독한다. 플랜트의 운전과정에서 발생하는 기술적 문제를 해결한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"종합","workFunc2":"감독","workFunc3":"설치","certLic":"기계설계산업기사, 기계기술사, 일반기계기사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001803:1', '{"dJobCd":"K000001803","dJobCdSeq":"1","dJobNm":"고속철도차량설계연구원","workSum":"고속철도차량을 제조하기 위하여 구조, 배관, 의장, 대차, 전장 등을 연구하고 설계한다.","doWork":"고속전철의 구조, 배관, 의장, 대차, 전장, 객실, 주행성능예측 소프트웨어, 제동장치기술, 대차 및 현가장치, 동력객차의 충돌안전도, 내장부품용 복합재료의 인장·피로특성, 각종 구조물의 구조해석 등을 연구한다. 연구결과를 설계에 적용하고 설계도면을 제작한다. 주행에 따른 이선현상 모의시뮬레이터, 주행성능예측 소프트웨어모듈을 개발·운용한다. 시운전을 실시하여 차체진동 특성평가, 고속철도부하, 배전계통의 시스템 안정도 등을 평가한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","certLic":"철도차량산업기사, 철도차량기사, 철도차량기술사, 전기철도산업기사, 전기철도기사, 전기철도기술사, 기계설계산업기사, 기계기술사, 일반기계기사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"C312","dJobICdNm":"[C312]철도장비 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002874:1', '{"dJobCd":"K000002874","dJobCdSeq":"1","dJobNm":"고속철도차량성능연구원","workSum":"제조 및 개발된 새로운 고속철도차량시스템의 성능 및 안정성을 시험 및 검증하여 평가한다.","doWork":"외국의 각종 성능시험사례 및 시험규격 등에 대한 분석 및 검토결과를 바탕으로 시험계획을 수립하고 시험절차서를 작성한다. 고속철도차량 각 분야의 시험수행방법을 개발한다. 각종 시험장비를 확보한다. 시험자료수집 및 분석체계를 고려하여 설계검토, 차량제작단계검토, 시운전평가 등의 3단계로 고속철도차량시스템에 대한 종합적인 성능시험 및 평가를 한다. 설계검토는 기본설계와 상세설계를 검토한다. 최초 생산된 부품의 형식시험과 양산품의 공장시험을 한다. 조정시험, 설계성능입증시험, 인수시험, 종합시운전으로 구분하여 시험항목에 대한 시험, 검사를 한다. 검사결과 문제발생 시 시정을 요청한다. 시험결과를 기록하여 보관한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"철도차량기사, 철도차량산업기사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"C312","dJobICdNm":"[C312]철도장비 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002335:1', '{"dJobCd":"K000002335","dJobCdSeq":"1","dJobNm":"공장자동화컨설턴트","workSum":"기업체의 의뢰를 받아 최적의 방법으로 공장의 생산설비를 자동화하기 위하여 최신 제조기술, 자동화기술 등을 자문한다.","doWork":"진단, 지도를 의뢰한 기업체의 생산현장을 조사·파악하여 공정분석 및 타당성을 검토하고 생산전략 및 공장자동화(FA)계획을 수립·지도한다. 공장자동화를 위해 업체의 담당자 및 경영진과 함께 공장내부디자인 제고, 국내외 공장자동화시스템 설비업체들의 장단점 분석, 공장자동화 시스템을 사용하고 있는 다른 업체 벤치마킹을 통해 가장 적합한 자동화시스템의 선정을 위한 스펙(Specification)을 수립한다. 스펙과 계획이 수립되면 경영진과 함께 공장자동화시스템을 개발·설치할 업체를 선정하기 위한 제안요청서를 작성하고 공장자동화시스템 설비업체를 선정한다. 설비업체가 선정되면 공장자동화시스템 설비가 잘 설치되는지 감독하며 생산설비를 시험·운용하고 가동상태를 점검·확인한다. 향후 생산확장을 위한 공장자동화계획을 수립하며 생산라인의 작업자들이 새로운 자동화설비에 적응할 수 있도록 교육하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","certLic":"경영지도사(생산관리), 생산자동화산업기사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"M715","dJobICdNm":"[M715]회사 본부 및 경영 컨설팅 서비스업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005149:1', '{"dJobCd":"K000005149","dJobCdSeq":"1","dJobNm":"공정장비설계기술자","workSum":"제품제조에 사용되는 공정장비를 설계·개발한다.","doWork":"제품의 제조공정을 이해하고 공정장비개발을 위해 필요한 기능을 파악한다. 성능향상, 원가절감 등의 기존 장비와의 차별적인 특성을 구현하기 위한 장비의 설계구성을 기획한다. 이를 바탕으로 적용가능한 자재와 기술을 파악하여 기능, 기구, 제어, 운용 등의 방법을 결정하고 캐드(CAD)나 3D설계프로그램(3D Design Program) 등을 이용하여 공정장비의 치수, 재질, 가공, 조립을 고려한 시제품의 도면을 설계한다. 시제품의 제작과 운영에서 발견된 수정사항을 적용한 양산도면을 설계한다. 공정장비가 제작될 수 있도록 부품의 제작에 필요한 형상치수, 재질, 가공법을 기술한 자재명세서(BOM:Bill Of Material)를 구성하고 자재의 가공을 지원하며, 장비표준화를 위한 표준화문서를 작성한다. 고객에게 납품한 장비의 문제점 개선 및 지원업무를 수행하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","certLic":"기계설계산업기사, 일반기계기사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"C292","dJobICdNm":"[C292]특수 목적용 기계 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005832:1', '{"dJobCd":"K000005832","dJobCdSeq":"1","dJobNm":"공정장비운영원","workSum":"공정장비의 설치를 지원하고 정비 및 유지보수 등의 기술지원업무를 수행한다.","doWork":"공정장비의 설치를 지원하기 위해 설치장소의 도면과 장비의 배치도를 확인한다. 설치장소의 전기, 공조, 배관설비 등의 공정장비가 운영조건에 적절한지 검토항목을 점검하여 이상이 발견되면 수정을 요청한다. 공정장비의 설치과정에서 문제점이 없는지 감독한다. 설치 후 시운전을 통해 기능점검을 실시하여 정상설치를 확인한다. 설치가 완료된 공정장비의 정기적인 정비, 운영상태 점검, 유지보수 등의 기술지원업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"기술지원엔지니어","certLic":"생산자동화산업기사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"C292","dJobICdNm":"[C292]특수 목적용 기계 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002256:1', '{"dJobCd":"K000002256","dJobCdSeq":"1","dJobNm":"관로기계설비설계원","workSum":"가스공급망에 사용되는 각종 기계설비의 설계도를 작성하고 관로공사를 기술지원·감독한다.","doWork":"가스공급 관로기계설비 설치 대상지역을 조사하고 관련 자료를 수집한다. 공급관리소와 수용가 사이를 연결하는 주배관, 히터, 차단밸브, 소음기, 감압밸브, 안전밸브 등의 설치위치를 설계한다. 용량 및 목적에 맞는 설비규모를 산정하고 설계한다. 공사에 필요한 자재를 발주하고 공급한다. 관로기계설비의 개선을 위한 자료를 수집하고 분석한다. 문제발생 시 신속한 대처를 위하여 각종 설계도, 기술서, 시방서 등의 문서를 관리한다. 관로공사를 관리·감독한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"종합","workFunc2":"감독","workFunc3":"정밀작업","certLic":"가스산업기사, 가스기사, 가스기술사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"F412","dJobICdNm":"[F412]토목 건설업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001353:1', '{"dJobCd":"K000001353","dJobCdSeq":"1","dJobNm":"광학용품기술자","workSum":"렌즈, 현미경, 쌍안경 등 광학용품을 연구·설계·개발하고 제품 제조공정에서 품질을 관리한다.","doWork":"렌즈, 현미경, 쌍안경 등의 개발을 위하여 광학용품관련 각종 국내외 기술정보, 시장정보를 수집분석하고 연구한다. 렌즈, 광학부품, 광학기구, 가공설비 등을 개발하기 위한 계획안을 수립한다. 계획안에 따라 렌즈, 부품, 기구 등을 설계한다. 시제품 및 관련부품을 개발한다. 제품생산에 필요한 외주부품을 주문한다. 부분품 및 완제품을 시험하고 평가한다. 대량생산을 위해 생산라인, 생산공정 등을 연구·설계한다. 제품설계와 생산제품을 비교·검토하고 품질을 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"광학기사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"C273","dJobICdNm":"[C273]사진장비 및 광학기기 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005454:1', '{"dJobCd":"K000005454","dJobCdSeq":"1","dJobNm":"국방과학연구원","workSum":"국가방위에 필요한 병기·장비 및 물자에 대한 기술적 조사, 연구, 개발, 시험을 수행한다.","doWork":"병기, 장비 및 군용물자에 관한 기술적 조사, 연구, 개발과 이와 관련된 계통공학, 인간공학 관련 과학기술을 조사·연구한다. 병기, 장비와 그 밖의 군용물자의 제식(制式) 및 규격을 조사·연구한다. 병기 및 장비의 시험제작을 위한 설계 및 설명서의 작성, 검토와 시험제작품의 기술시험을 한다. 각종 병기 및 장비의 성능시험을 한다. 병기, 장비와 그 밖의 군용물자와 전략자원에 관한 기술정보사업을 추진한다. 병기, 장비와 그 밖의 군용물자에 관한 연구위탁, 연구보조 또는 지원업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006143:1', '{"dJobCd":"K000006143","dJobCdSeq":"1","dJobNm":"금형설계원","workSum":"금형을 컴퓨터로 설계하고 모의실험(시뮬레이션)을 한다.","doWork":"도면을 보고 설계할 금형의 특성을 파악한다. 금형의 형태, 분할방법, 제작절차 및 수량 등을 검토하고 결정한다. 성형방법, 가공기계를 고려하여 금형세트를 결정한다. 금형의 크기와 치수를 표시한 금형세트의 축적도를 2차원과 3차원으로 설계한다. 제작된 금형모형을 도면과 비교하여 치수와 모양 등의 정확도를 확인·검사한다. 금형세트를 생산기계에 설치하여 시험생산하고 이상 여부를 확인한다. 컴퓨터프로그램을 통한 모의실험(시뮬레이션)을 통해 문제점을 파악하고, 설계를 수정 보완하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"프레스금형설계기술자, 플라스틱금형설계기술자, 주조금형설계기술자, 사출금형설계기술자, 금형CAE기술자","certLic":"사출금형기사, 프레스금형기사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"C243/C259","dJobICdNm":"[C243]금속 주조업 / [C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003185:1', '{"dJobCd":"K000003185","dJobCdSeq":"1","dJobNm":"기계공학기술자(일반)","workSum":"기계분야의 장·단기 기술정책을 입안하고 생산·설비관리기술의 향상을 위한 연구와 산업표준화 및 사내기술규격표준 등을 조정·보완하며 각 기계설비의 건설·시설공사에 대한 설계서 작성 및 관리업무 등을 수행한다.","doWork":"기계분야에 대한 각종 과학기술정보 및 자료를 수집·분석하여 산업표준화 및 사내기술규격표준, 기술정책을 입안하고 생산·설비관리기술 향상을 위해 연구한다. 기계부문의 설비, 건설, 정비계획 등 각종 기술적 조정업무를 수행하고 기존 설비시설의 용량, 규격, 형식 등을 검토한다. 확장·증설하는 설비와 기존설비와의 상관관계를 종합적으로 판단하여 기술 및 설비관리제도를 설정하고 설비의 개선방안을 연구한다. 기술용역의 범위, 제출자료, 훈련계획 등 기술용역계약에 포함되는 제반 기술사항의 작성·검토업무를 총괄하며 확장설비건설을 위한 용역의 범위조정, 건설요원의 소요판단 및 조정, 구입사양서 검토 및 조정 등 각종 기술적 지원업무를 수행한다. 각종 도면을 검사하고 관련 내용을 확정하여 용역설계 시 용역발주를 위한 과업지시서의 작성 및 설계자료의 검토·보완업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"기계기술자","connectJob":"자동차부품설계기술자, 건설기계설계기술자, 농업기계설계기술자, 제조용기계설계기술자, 사무용기계기술자, 엔진기계기술자, 농업용기계(설계)공학기술자, 광업용기계(설계)공학기술자, 섬유기계(설계)공학기술자, 식품기계(설계)공학기술자, 공작기계(설계)공학기술자, 유압기계설계기술자, 엘리베이터(설계)공학기술자, 로봇공학기술자, 수치해석전문가, CAE기술자, 반도체기계설계기술자, 광학기계설계기술자, 인쇄기계설계기술자","certLic":"건설기계설비기사, 공조냉동기계기사, 농업기계기사, 설비보전기사, 일반기계기사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005921:1', '{"dJobCd":"K000005921","dJobCdSeq":"1","dJobNm":"냉동공조설계원","workSum":"냉동공조시스템을 구성하기 위하여 기본계획을 수립하고, 부하계산 등을 통하여 설계도서를 작성하고 검증한다.","doWork":"기본설계, 부하계산, 장비용량계산설계도서 등을 확인하고 설계의 적합성을 검토한다. 현장조사, 법규검토, 인증제도검토, 예정가격분석을 통해 요구사항에 적합한 기본계획을 수립한다. 설계사양을 정의하고 시스템을 검토하여 냉동공조시스템과 레이아웃을 생성하는 기본설계를 한다. 공학적 계산식을 활용하여 열원장비, 공조장비, 반송기기 등에 대한 용량을 산정하고 요구사항에 적합한 장비 및 부품을 선정한다. 설계도서에 따라 소요되는 재료비 및 노무비를 계산하여 공사원가를 산출한다. 구조체의 열전달, 실내외 온도·습도 조건 등을 고려하여 취득열량 및 손실열량을 계산하고 냉·난방부하를 산출한다. 요구사항과 현장조사자료를 바탕으로 냉동공조설비에 적용할 설계도서, 시방서, 매뉴얼 등을 작성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"공기조화설비설계기술자, 냉난방설비설계기술자","certLic":"공조냉동산업기사, 공조냉동기사, 공조냉동기술사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"D353","dJobICdNm":"[D353]증기, 냉·온수 및 공기조절 공급업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005073:1', '{"dJobCd":"K000005073","dJobCdSeq":"1","dJobNm":"농업기계화연구원","workSum":"농업기계의 기반기술을 연구·개발하고 농작업의 효율성 향상을 도모한다.","doWork":"에너지절감용 농업기계, 농업기계구조 및 내구성 향상기술, 기존 농업기계의 용도제고 등을 연구한다. 농경지에서 사용되는 파종관리기계, 수확기계, 시설원예기계, 축산기계, 정밀농업기계 등의 농기계를 개발·개량하기 위한 연구를 한다. 고품질의 농산물을 건조·저장·가공하여 유통하기 위한 조제가공기계, 건조기계, 선별포장기계, 저장·유통기계 등에 대한 기술개발 및 실용화를 위한 연구를 한다. 농업기계의 보급, 이용, 기술훈련, 사후관리, 안전관리에 대한 연구를 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|","workFunc1":"종합","workFunc2":"자문","workFunc3":"정밀작업","connectJob":"농업생산기계연구원, 농산가공기계연구원","certLic":"농업기계기사, 농업기계산업기사, 기계기술사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003350:1', '{"dJobCd":"K000003350","dJobCdSeq":"1","dJobNm":"대기오염저감설비개발자","workSum":"산업활동에서 발생하는 대기오염의 저감을 위한 설비 및 기술을 연구·개발한다.","doWork":"산업체에서 발생하는 휘발성유기화합물(VOCs), 악취물질 및 공정발생폐가스를 저감하기 위한 공정, 필터, 화학반응, 연소 등에 대한 기술을 연구·개발한다. 화석연료 등을 연소시켜 에너지로 전화하는 과정에서 발생하는 대기오염물질의 저감을 위한 탈질장비, 염소산화물을 함유한 플라스틱제품의 소각 시 발생하는 다이옥신을 제거하기 위한 제거설비, 연료의 연소과정에서 발생하는 황산화물(Sox) 제거설비 등 대기오염저감설비를 연구·개발한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"산업기계설비기술사, 기계기술사, 일반기계기사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"C291","dJobICdNm":"[C291]일반 목적용 기계 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001607:1', '{"dJobCd":"K000001607","dJobCdSeq":"1","dJobNm":"드론개발자","workSum":"드론의 기체, 부품, 응용장치, 소프트웨어 등을 연구·개발한다.","doWork":"드론기체, 모터, 통신기기, 비행제어장치, 조종장치 등을 연구·개발한다. 드론의 비행을 제어하는 소프트웨어(좌표인식, 지도연동, 자율비행, 지상통제소프트웨어 등)를 개발한다. 군사, 촬영, 스포츠, 관측, 감시, 정보통신, 광고, 배달 등 다양한 응용분야에서 임무를 수행하는 데 필요한 응용장치(영상장치, 애플리케이션, 센서, 액추에이터, 액세서리, 시뮬레이션 장치 등)를 연구·개발한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"C313","dJobICdNm":"[C313]항공기, 우주선 및 부품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006994:1', '{"dJobCd":"K000006994","dJobCdSeq":"1","dJobNm":"로켓터보펌프시험원","workSum":"액체로켓엔진에 연료와 산화제를 고압으로 공급하는 터보펌프의 안전성과 성능을 시험·분석한다.","doWork":"펌프시험기를 이용해 터보펌프(액체로켓엔진에 연료와 산화제를 고압으로 공급하는 핵심부품으로서 고온, 고압, 극저온, 고속회전 등 극심한 조건이 필요)의 성능시험을 한다. 터빈시험기를 이용해 터빈성능시험을 한다. 터보펌프조립체시험기를 이용해 터보펌프조립체 성능시험을 한다. 인듀서·펌프캐비데이션에 대해 특성시험을 한다. 각 시험의 결과를 분석하고 컴퓨터프로그램에 기록한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"C313","dJobICdNm":"[C313]항공기, 우주선 및 부품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003750:1', '{"dJobCd":"K000003750","dJobCdSeq":"1","dJobNm":"매립가스플랜트설비기술자","workSum":"매립가스플랜트의 가스정 착공 및 배관작업을 하고, 전력생산을 위한 각종 설비와 기계를 설치한다.","doWork":"매립지의 폐기물을 일정한 깊이로 파낸 후 골재를 포설한다. 가스정을 수평으로 배관한 후 공기가 유입되지 않도록 복토를 한다. 매립이 완료된 후 수직으로 가스정을 설치한다. 가스정 주변의 상부에서 가스가 외부로 누출되거나 공기가 외부에서 침투되지 않도록 기밀성을 유지하고 가스의 포집이 용이하도록 처리한다. 수직 및 수평가스정을 서로 연결하고 포집설비(포집:Station)에 가스가 이송, 저장되게 한다. 가스조절이 가능하도록 각종 설비와 모니터링시스템을 설치한다. 가스전처리시설, 각종 기계장치 및 제어기기를 설치한다. 발전기 및 전력송출장치를 설치한 후 각각을 연결해서 시험가동한다. 발전설비효율을 향상하기 위해 기기공급사와 협의한다. 악취원인이 되는 노후설비를 교체하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"설치","certLic":"설비보전기사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"F412","dJobICdNm":"[F412]토목 건설업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002129:1', '{"dJobCd":"K000002129","dJobCdSeq":"1","dJobNm":"모노레일기술자","workSum":"모노레일 관련 기술 및 장비를 연구·설계하고, 제작을 위한 실험 및 기술을 관리한다.","doWork":"국내외의 각종 자료와 정보를 이용하여 모노레일시스템(선형차, 차축, 림, 프레임, 현가장치, 제동장치)을 연구한다. 컴퓨터 시뮬레이션프로그램을 통하여 실험을 실시하고 측정값을 기록한다. 속도성능프로그램을 사용하여 속도성능을 계산한다. 캐드(CAD)를 사용하여 모노레일시스템설계를 해석한다. 선형차를 제작하여 모의시험을 실시한다. 시험선로(레일)에서의 모노레일 시운전에 승차하여 속도성능을 확인하고 모노레일의 안전성능(차량진동, 현가장치, 승차감, 제동장치)을 입증한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"손사용|","workFunc1":"종합","workFunc2":"감독","workFunc3":"정밀작업","certLic":"기계기술사, 기계설계산업기사, 일반기계기사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"C319","dJobICdNm":"[C319]그 외 기타 운송장비 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004172:1', '{"dJobCd":"K000004172","dJobCdSeq":"1","dJobNm":"모터사이클설계기술자","workSum":"모터사이클의 기본설계 및 생산도면을 설계한다.","doWork":"모터사이클의 시장성, 진보성, 상품성, 경제성, 실용성, 시제품, 양산품의 기준에 적합한 제품의 개념을 수립한다. 기본 레이아웃, 부분품 계획, 시작설계 및 양산설계, 개선사양변경설계 등을 고려하여 설계계획을 수립한다. 모터사이클의 유형에 따른 구조적 특징, 부분품, 관련 기술을 분석한다. 안전성, 성능 및 경제성 등을 고려하여 기본 및 생산도면을 설계한다. 부품의 적합성, 시제품의 성능, 내구성을 시험하고 개선안을 도출하여 설계에 반영한다. 가격경쟁력, 재료의 선택, 가공방법, 재질의 특성 등을 고려하여 생산성을 분석한다. 품질사양, 성능사양, 관련 규격 등을 확정한다. 원재료 및 부자재 리스트(Bill of Material)를 작성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"C301","dJobICdNm":"[C301]자동차용 엔진 및 자동차 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006609:1', '{"dJobCd":"K000006609","dJobCdSeq":"1","dJobNm":"바이오가스플랜트발전시스템기술자","workSum":"바이오가스발전플랜트의 각종 기계제어시스템을 설치한다.","doWork":"바이오가스로부터 전력을 생산하기 위해 바이오가스플랜트에 보일러, 터빈발전기, 콘트롤러 등을 설치한다. 바이오가스의 생산 및 저장, 정제, 발전을 위한 각종 시설을 설치한 후 전기공사를 통해 각각의 기능을 연결한다. 혐기성 소화조, 폐수정화시설, 발전기 등을 모니터링하고 원격제어하기 위해 원격모니터링 제어시스템을 설치한다. 시험가동을 통해서 정상적인 작동 여부를 체크하고 이상이 있는 부품과 연결부위를 정비·교체한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"설치","certLic":"설비보전기사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"F412","dJobICdNm":"[F412]토목 건설업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006627:1', '{"dJobCd":"K000006627","dJobCdSeq":"1","dJobNm":"바이오가스플랜트설계기술자","workSum":"바이오가스발전플랜트의 각종 기계제어시스템을 설계하고 개발한다.","doWork":"저류조, 혐기소화조, 가스저장조, 토양악취저감시스템, 열병합발전시스템 등 바이오가스플랜트시설의 시스템을 연구하고 기본설계를 한다. 펌프, 밸브, 압축기, 터빈, 냉동기 등 바이오가스플랜트의 핵심기계를 설계하고 시제품을 개발한다. 바이오가스플랜트에서 발생하는 누설, 화재 및 폭발 등 사고로부터 인명과 설비를 안전하게 보호하기 위한 안전설계기술과 신뢰성 향상기술을 연구한다. 플랜트의 수명연장, 신뢰성 확보를 위한 위험요소 및 고장예측기술과 신뢰성평가기술을 연구한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"설비보전기사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"F412","dJobICdNm":"[F412]토목 건설업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006915:1', '{"dJobCd":"K000006915","dJobCdSeq":"1","dJobNm":"반도체장비기구개발자","workSum":"반도체공정기술로드맵 및 고객 요구성능을 이해하고, 재료, 부품, 부분품, 장치를 이용한 구상설계, 상세설계, 부품역학 해석 및 검증을 통해 반도체장비의 기구장치를 연구·개발한다.","doWork":"장비공정연구원과 공동으로 구상한 기초설계를 기준으로 장비의 주요 기능을 정의하고, 각 장치 및 모듈별 상세사양을 결정한 다음, 최적의 재료, 부품, 부분품, 장치 등을 선정한다. 상세사양 기준으로 선정된 재료, 부품, 부분품 및 장치들 중에서 유체, 진동, 열 및 광역학해석이 필요한 부품들을 분류하고, 각 부품특성에 적합한 해석프로그램을 선정하여 실행한다. 각 부품별 해석결과를 바탕으로 부품적합성 여부를 판단하며, 부품재선정 및 해석작업을 반복하여 최종사양을 결정한다. 최종사양을 기준으로 기구 및 유틸리티 관련 부품에 대한 상세설계를 진행하여 도면을 작성한다. 장비의 조립, 시험성능평가 및 고객사 현장평가를 통해 발견되는 기구설계 오류분석으로 설계개선을 지원한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 다양한 재료, 부품, 부분품, 장치 및 장비기술을 시험평가하고, 최적화하는 연구·개발활동을 단독 또는 공동으로 수행한다. 반도체장비 개발과정에는 장비조립의 편이성, 제조원가 절감, 공정 및 장비 신뢰성을 보증하는 재료, 부품, 부분품, 장치 및 장비기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체장비연구원","connectJob":"반도체장비설계연구원","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002295:1', '{"dJobCd":"K000002295","dJobCdSeq":"1","dJobNm":"발사체기술연구원","workSum":"우주발사체를 연구·개발하고 각종 시험(재료시험, 단분리시험, 조립모델시험 등)을 수행한다.","doWork":"발사체의 시스템 설계, 시험 및 평가관리, 발사체시스템 체계(기계, 전기, 지상)통합 및 발사시험 운용 등을 연구한다. 발사체의 구조, 전자, 제어시스템, 유도조정컴퓨터의 설계 및 개발을 한다. 발사체 파이로테크닉장치, 추력기 관련 기술개발을 수행한다. 외형설계, 공력 분석 및 풍동시험, 단분리시험, 노즈페어링분리시험, 구조조립시험, 물성치시편시험을 한다. 열환경 설계 및 열 제어부를 개발하고 발사체의 경량화 및 고성능화를 위한 첨단소재를 연구·분석한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"청각|손사용|시각|","workFunc1":"종합","workFunc2":"교육","workFunc3":"정밀작업","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"C313","dJobICdNm":"[C313]항공기, 우주선 및 부품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003013:1', '{"dJobCd":"K000003013","dJobCdSeq":"1","dJobNm":"발사체추진기관시험원","workSum":"우주발사체의 고성능 액체로켓 엔진성능 및 안전성을 평가한다.","doWork":"액체로켓엔진의 개발을 위한 지상연소시험을 통해 시험데이터의 계측을 한다. 고연소효율 분사기개발을 위한 수류시험과 광계측시험을 한다. 데이터수집 및 분석기능을 갖춘 시스템을 이용해 획득된 데이터를 프로그램에 측정·저장한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"청각|손사용|시각|","workFunc1":"분석","workFunc2":"교육","workFunc3":"정밀작업","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"C313","dJobICdNm":"[C313]항공기, 우주선 및 부품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002422:1', '{"dJobCd":"K000002422","dJobCdSeq":"1","dJobNm":"발사체추진기관연구원","workSum":"우주발사체의 추진기관을 연구·개발하고 각종 시험을 수행한다.","doWork":"발사체의 추진기관(액체엔진, 연소기, 가스발생기, 터보펌프 등)을 설계하고 개발하기 위한 연구를 한다. 축소형 엔진과 주 엔진의 상관관계 연구 및 표준시험절차를 수립한다. 추진기관의 극저온추진체공급계 및 제어부품의 설계 및 개발을 위한 연구를 한다. 고성능 다단연소사이클엔진 개발을 위한 요소기술과 터보펌프방식 액체엔진 성능향상연구를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"균형감각|청각|손사용|시각|","workFunc1":"종합","workFunc2":"교육","workFunc3":"정밀작업","certLic":"항공엔진기술사","dJobECd":"1511","dJobECdNm":"[1511]기계공학 기술자 및 연구원","dJobJCd":"2351","dJobJCdNm":"[2351]기계공학 기술자 및 연구원","dJobICd":"C313","dJobICdNm":"[C313]항공기, 우주선 및 부품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;