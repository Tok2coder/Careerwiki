INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007786:1', '{"dJobCd":"K000007786","dJobCdSeq":"1","dJobNm":"고객경험매니저","workSum":"기업의 제품 및 서비스 이용 과정에서 고객이 겪는 경험을 최적화하기 위해 고객 경험 분석 및 개선, 고객 여정 관리, 고객경험 전략 설계, 고객 불만 해결 및 대응, 브랜드 이미지 및 충성도 강화 등의 업무를 한다.","doWork":"고객 피드백을 수집하고, 데이터를 분석하여 서비스의 문제점을 개선한다. 고객이 브랜드를 처음 접하고 구매 및 이용하는 과정에서 긍정적인 경험을 할 수 있도록 고객여정 관리를 설계하고 개발한다. 제품팀, 개발팀, 마케팅팀과 협력하여 고객 경험을 개선하는 전략을 수립한다. 고객의 불만 사항을 분석하고, 이를 해결하기 위한 프로세스를 구축한다. 고객이 브랜드에 대한 긍정적인 인식을 가질 수 있도록 지속적인 경험 개선을 추진한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"CX매니저","certLic":"서비스경험디자인기사","dJobECd":"0261","dJobECdNm":"[0261]기획·마케팅 사무원","dJobJCd":"3121","dJobJCdNm":"[3121]기획 및 마케팅 사무원","dJobICd":"N759","dJobICdNm":"[N759]기타 사업지원 서비스업","inqYear":"2025"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005704:1', '{"dJobCd":"K000005704","dJobCdSeq":"1","dJobNm":"공사입찰기술사무원","workSum":"건설공사의 수주입찰서류를 작성·접수하고, 공사계약을 위한 서류를 준비한다.","doWork":"건설공사견적사무원에게 입찰용 견적서를 전달받아 접수하고 검토한다. 입찰에 필요한 서류를 준비하여 발주처에 등록한다. 발주처로부터 입찰공문을 접수하고 계약에 필요한 각종 서류를 준비한다. 입찰과 계약이 이루어진 공사의 내용을 작성하여 관련 부서에 통보한다. 시공부서에서 의뢰한 공사설계의 변경요청이나 공사대금 납부 등에 대해 발주처 담당자와 협의한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"공사계약사무원, 입찰사무원","dJobECd":"0261","dJobECdNm":"[0261]기획·마케팅 사무원","dJobJCd":"3121","dJobJCdNm":"[3121]기획 및 마케팅 사무원","dJobICd":"F411/F412/F421","dJobICdNm":"[F411]건물 건설업 / [F412]토목 건설업 / [F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006236:1', '{"dJobCd":"K000006236","dJobCdSeq":"1","dJobNm":"공유사무실매니저","workSum":"기업이 입주한 공유사무실(코워킹 스페이스)을 운영·관리하고 입주기업 간의 커뮤니티 형성을 지원하는 이벤트를 기획하고 운영한다.","doWork":"공유사무실 및 제공서비스의 계약, 운영 및 관리를 한다. 공유사무실의 스태프를 관리한다. 공유사무실을 둘러보고 시설의 고장부터 입주기업이 불편한 점이 없는지 확인한다. 공유사무실 입주자를 위한 안내, 상담 및 입주를 위한 영업 및 마케팅 활동을 한다. 입주기업 간의 커뮤니티 형성을 위한 이벤트를 기획하고 운영한다. 지점을 투어하여 지점매니저 등과 정보를 교환·공유한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"설득","workFunc3":"관련없음","similarNm":"커뮤니티매니저","certLic":"빌딩관리사","dJobECd":"0261","dJobECdNm":"[0261]기획·마케팅 사무원","dJobJCd":"3121","dJobJCdNm":"[3121]기획 및 마케팅 사무원","dJobICd":"N759","dJobICdNm":"[N759]기타 사업지원 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005568:1', '{"dJobCd":"K000005568","dJobCdSeq":"1","dJobNm":"공정장비기획사무원","workSum":"제품의 제조장비와 제작 공정기술을 파악하여 제품제조에 사용되는 공정장비의 개발을 기획한다.","doWork":"제조하고자 하는 제품의 공정, 기술 등의 이론을 바탕으로 제조장비와 공정기술을 파악한다. 관련 산업의 시장·기술변화와 공정장비의 투자·개발동향, 관련 장비의 시장점유율 및 수요, 관련 규제사항 등 공정장비의 기술적·산업적 특성을 조사·분석한다. 분석된 내용을 바탕으로 시장성이 높은 공정장비를 선정하고 개발 순위를 제시한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0261","dJobECdNm":"[0261]기획·마케팅 사무원","dJobJCd":"3121","dJobJCdNm":"[3121]기획 및 마케팅 사무원","dJobICd":"C292","dJobICdNm":"[C292]특수 목적용 기계 제조업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003491:1', '{"dJobCd":"K000003491","dJobCdSeq":"1","dJobNm":"국제개발협력기획자","workSum":"국가·지방자치단체 또는 공공기관이 개발도상국의 발전과 복지증진을 위하여 지원하는 사업을 관리하는 것으로서 사업개발 전략수립, 사업개발기획, PDM(사업설계모형)수립, 총괄운영관리, 프로젝트집행, 프로젝트 성과 및 평가 등을 수행한다.","doWork":"협력대상국의 정책, 제도, 법령, 현지여건을 토대로 개발환경을 검토하고 자국의 협력환경 분석에 의한 비교우위를 도출하여 협력대상국의 경제·사회개발을 촉진하기 위한 종합적 협력대상국 지원전략을 수립한다. 협력대상국의 개발전략에 부합하는 사업을 발굴하여, 사업추진이 확정되도록 행정조치 지원, 타당성조사 및 심사 후, 협력대상국 정부와의 협의를 통하여 지원 대상 사업을 선정한다. 사업이 달성하려고 하는 목표와 수단의 설정, 필요한 가정의 분석으로 리스크를 식별하고, 달성정도 평가를 위한 지표 수립을 통하여 공적개발원조사업의 논리모형을 구성한다. 양국간 실시하기로 합의된 사업의 실행을 위한 사업집행계획의 수립과 사업 발주, 사업의 작업과 변경 통제, 단계 및 프로젝트 종료 및 다음 프로젝트를 위한 경험적 지식의 축적이행을 관리한다. 사업집행계획에 따라 협력대상국 및 유관기간에 인적·물적 자원을 개별 또는 상호연계로 제공하여 전문인력 파견, 초청연수, 건축지원 및 기자재지원 등의 프로젝트를 추진 및 운영한다. 개발협력 사업에서 설정된 목표가 달성되 도록 하기 위해 필요한 지표들을 도출하고, 지표의 추적조사 및 분석을 통해 기 설정한 목표의 달성 여부를 지속적으로 점검한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0261","dJobECdNm":"[0261]기획·마케팅 사무원","dJobJCd":"3121","dJobJCdNm":"[3121]기획 및 마케팅 사무원","dJobICd":"S949/U990","dJobICdNm":"[S949]기타 협회 및 단체 / [U990]국제 및 외국기관","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003743:1', '{"dJobCd":"K000003743","dJobCdSeq":"1","dJobNm":"국제통신망발전계획원","workSum":"국제통신망의 중장기계획을 수립하고 국제전송로의 중장기 수요를 예측하여 공급계획을 수립한다.","doWork":"국제교환시설, 국제위성통신시설, 국제전송시설, 국제해저통신시설 등의 건설계획을 수립한다. 국제망관리, 교환, 전송, 위성, 해저케이블, 전원 등의 분야별 세부사업추진을 계획한다. 국제전송로 회선의 수요를 조사하여 국가별 사업자별 국제전송로를 확보하고 배정계획을 수립한다. 국제전송시설계획을 수립하고 국제해저케이블 및 통신망복구를 계획한다. 국제위성통신시설을 국제주파수등록위원회에 등록하고 무선국허가를 신청한다. 국제위성이동통신, 휴대통신, 해저케이블시설 설비투자사업을 실시한다. 국제회선을 영구임대하여 판매하고 구매관리를 한다. 회선의 판매가격을 산정한다. 국제회선 임대처의 용도와 적정성을 분석하고 사용승인을 검토한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","certLic":"정보통신기술사, 정보통신기사, 정보통신산업기사","dJobECd":"0261","dJobECdNm":"[0261]기획·마케팅 사무원","dJobJCd":"3121","dJobJCdNm":"[3121]기획 및 마케팅 사무원","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004948:1', '{"dJobCd":"K000004948","dJobCdSeq":"1","dJobNm":"금융영업점이익관리사무원","workSum":"영업점 이익계획 수립, 매월 이익관리, 간이경영평가, 경영평가에 대한 손익분석업무를 수행한다.","doWork":"금융기관(일반은행, 특수은행, 비은행예금취급기관, 보험사, 증권사, 카드사 등)의 각 지역점 및 영업점의 연간 이익목표 및 이익계획을 수립하고 그에 따른 월간 이익계획을 수립한다. 각 부문별 이익계획을 수립한다. 매월 간이결산을 실시·보고하고 손익분석회의 등을 통해 각 부문별 손익 및 업무실적을 평가한다. 이익목표달성 미달 시 사업진행의 문제점을 도출하고, 분석하여 사업계획 및 이익계획을 수정 보강하여 재수립한다. 1/4, 3/4분기에 간이경영평가를 하여 손익분석을 하기도 한다. 상반기, 하반기, 연간 정기경영평가를 하여 손익분석을 한다. 지점관리사무원과 구분하여 이익계획수립 및 이익 관련 통계업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"협의","workFunc3":"관련없음","similarNm":"영업실적정리사무원","dJobECd":"0261","dJobECdNm":"[0261]기획·마케팅 사무원","dJobJCd":"3121","dJobJCdNm":"[3121]기획 및 마케팅 사무원","dJobICd":"K641/K649","dJobICdNm":"[K641]은행 및 저축기관 / [K649]기타 금융업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004071:1', '{"dJobCd":"K000004071","dJobCdSeq":"1","dJobNm":"기업재난관리자","workSum":"기업 차원에서 발생한 재난에 대응 및 2차 피해방지 활동과 실무자 활동, 재해경감활동계획 수립을 위한 컨설턴트 활동, 재해경감 우수기업 인증평가 활동을 수행한다.","doWork":"기업을 분석하여 목표와 목적을 명확히 하고 재난관리정책과 법적 요구사항을 정립한다. 기업의 핵심 업무를 파악하기 위한 업무영향분석(BIA)을 수행한다. 기업의 위험을 식별·분석하고 물리적·기술적·시설적·경영적 취약성 평가와 발생 빈도, 영향의 크기 분석을 통해 핵심리스크를 산정한다. 기업의 주요 위험에 대한 시나리오를 작성하고 운영한다. 기업의 재난(사고)대응 체계와 사업연속성 확보계획을 수립한다. 수립된 재난(사고)대응체계와 사업연속성 확보계획에 대한 모의훈련을 계획, 수행 및 평가한다. 기업의 재해경감활동 및 사업연속성 절차에 관한 모니터링 및 평가, 내부감사를 수행한다. 기업의 재해경감활동에 관한 지속적 개선과 문화 확산에 관한 업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"기업재난관리사","connectJob":"기업재난관리사(실무), 기업재난관리사(대행), 기업재난관리사(인증)","certLic":"기업재난관리사(실무분야, 대행분야, 인증분야)","dJobECd":"0261","dJobECdNm":"[0261]기획·마케팅 사무원","dJobJCd":"3121","dJobJCdNm":"[3121]기획 및 마케팅 사무원","dJobICd":"M715","dJobICdNm":"[M715]회사 본부 및 경영 컨설팅 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002576:1', '{"dJobCd":"K000002576","dJobCdSeq":"1","dJobNm":"기획사무원(일반)","workSum":"기존 혹은 신규사업의 타당성을 검토하여 사업을 기획하고, 사업진행에 필요한 마케팅전략을 기획·수립한다.","doWork":"기존에 진행되고 있거나 신규로 추진되는 사업의 방향을 검토하여 기획안을 작성한다. 시장조사 및 관련 자료를 분석하고, 검토결과를 보고한다. 일정조정, 자원배분 등 사업진행에 필요한 핵심요소의 진행상황을 모니터링하여 개선책을 검토한다. 관련 자료의 분석결과를 보고한다. 실무자에게 최종 기획안의 요구사항을 설명하고, 효과적인 사업수행을 위해 필요한 요소들을 전달한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","connectJob":"경영기획사무원, 판매기획사무원, 판촉기획사무원, 영업기획사무원, 홍보기획사무원, 사업기획사무원, 전략기획원, 신재생에너지사업을 기획하는 경우 신재생에너지사업개발원","dJobECd":"0261","dJobECdNm":"[0261]기획·마케팅 사무원","dJobJCd":"3121","dJobJCdNm":"[3121]기획 및 마케팅 사무원","dJobICd":"ALL","dJobICdNm":"[ALL]전체","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005876:1', '{"dJobCd":"K000005876","dJobCdSeq":"1","dJobNm":"대외협력사무원","workSum":"해외의 동종기관 및 관련 국제기구와의 과학기술협력 증진을 위해 인력 및 정보를 교류하고 기관 간 협력약정을 체결한다.","doWork":"대외협력을 위한 단기·중기·장기계획을 수립한다. 해외 동종기관 및 국제기구담당자와 사업에 대해 협의한다. 선진 연구자의 초청과 국제학술행사 등을 기획·실시한다. 연구업무수행에 관련된 행정업무를 수행한다. 외국 연구원들의 기관 방문 시 안내한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"언어력|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0261","dJobECdNm":"[0261]기획·마케팅 사무원","dJobJCd":"3121","dJobJCdNm":"[3121]기획 및 마케팅 사무원","dJobICd":"ALL","dJobICdNm":"[ALL]전체","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006633:1', '{"dJobCd":"K000006633","dJobCdSeq":"1","dJobNm":"대학기획사무원","workSum":"대학의 장·단기를 기획하고 예산을 조정, 통제하며 모든 사업의 검수 평가업무를 담당한다.","doWork":"대학의 장·단기발전계획을 수립한다. 조직개편, 학사개편, 학내 제규정 제정 및 개폐업무, 대학평가 관련 업무를 관장한다. 국고보조금 관리업무와 각종 통계연보 및 행정편람을 발간한다. 교육개혁 추진업무를 수행하기도 한다. 예산편성, 지원, 조정, 통제업무를 수행한다. 모든 사업의 검수평가를 담당한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"협의","workFunc3":"관련없음","connectJob":"산학협력사무원","dJobECd":"0261","dJobECdNm":"[0261]기획·마케팅 사무원","dJobJCd":"3121","dJobJCdNm":"[3121]기획 및 마케팅 사무원","dJobICd":"P853","dJobICdNm":"[P853]고등 교육기관","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003162:1', '{"dJobCd":"K000003162","dJobCdSeq":"1","dJobNm":"도로영업기획관리자","workSum":"도로영업 및 유료도로 통행료에 관한 장·단기 기본계획을 수립하고 제도개선에 관한 연구를 수행한다.","doWork":"도로영업시설의 현대화 및 전문화 추진을 위해 영업제도를 검토한다. 도로영업시설 관리방안을 연구하며 제도개선에 대한 조사자료를 검토·평가하여 개선방안을 모색한다. 유료도로 및 무료도로의 유료화제도에 관한 자료를 조사하고 연구한다. 이용객의 편익 및 정부시책을 고려하여 통행료 등의 요금을 조정·책정한다. 도로영업에 대한 예산집행계획을 수립한다. 영업소 근무환경 개선 등에 관한 연구를 수행한다. 기타 부대사업에 대한 장·단기 기본계획 수립, 제도개선 연구, 예산집행계획 수립, 이용도 조사 등을 수행한다. 하이패스 통행로(무인영업소 등)의 설치, 지점 선정을 위해 여론을 수렴하고 분석하여 기획의 기초자료로 활용한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"도로교통감독관","dJobECd":"0261","dJobECdNm":"[0261]기획·마케팅 사무원","dJobJCd":"3121","dJobJCdNm":"[3121]기획 및 마케팅 사무원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005116:1', '{"dJobCd":"K000005116","dJobCdSeq":"1","dJobNm":"마케팅사무원","workSum":"사업진행에 필요한 마케팅전략을 기획·수립하고, 성과를 분석하여 운영계획을 수립한다.","doWork":"마케팅 활동을 위한 중장기 운영계획을 수립하고, 해당 사업 전반에 미치는 효과를 분석한다. 필요한 마케팅 요소를 사전에 파악하여, 사업 진행에 요구되는 전사적인 마케팅 협력을 유도한다. 시장, 매출, 상품, 가격, 고객정보 등을 분석하여 현장진행 대응을 위한 참고자료로 제시한다. 경쟁사동향, 소비동향, 소비자특성, 관련 산업 발전방향 등의 시장환경을 분석한다. 마케팅매체, 지역 및 대상 등을 결정한다. 지역별, 지점별 판매력을 분석하고 판매촉진 활동을 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"협의","workFunc3":"관련없음","connectJob":"마케팅기획원, 마케팅기획사무원, 국내마케팅사무원, 국내판매담당사무원, 국내판매마케팅사무원, 국내판매기획사무원, 국내판매관리사무원, 해외마케팅사무원, 해외판매담당사무원, 해외판매마케팅사무원, 해외판매기획사무원, 해외판매관리사무원","dJobECd":"0261","dJobECdNm":"[0261]기획·마케팅 사무원","dJobJCd":"3121","dJobJCdNm":"[3121]기획 및 마케팅 사무원","dJobICd":"ALL","dJobICdNm":"[ALL]전체","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003320:1', '{"dJobCd":"K000003320","dJobCdSeq":"1","dJobNm":"무선통신대리점관리사무원","workSum":"무선통신단말기 판매대리점의 개설, 지원 및 관리, 폐지 등에 관해 검토하고 처리업무를 한다.","doWork":"지점의 신청을 받아 면담하고 입지를 선정한다. 동선을 측정하고, 인근 대리점과의 거리와 대리점의 위치를 확인한다. 신청자의 재정 상태를 고려하여 승인여부를 결정한다. 승인된 지점에 전산코드(대리점 코드:고객관리시스템에서 가입, 해지, 명의변경, 코드관리를 할 수 있도록 부여하는 코드)를 부여한다. 관련 부서에 대리점 개설을 통보한다. 직영 대리점을 운영하는 경우 직접 대리점을 발굴하기도 한다. 투자대리점의 요구에 따라 실내장식 비용 등 육성대여금을 지불한다. 유니폼, 명함, 간판 등을 지원한다. 대리점이 부도 등의 이유로 해지를 요청할 경우, 지점해지신청서를 작성하고 동의서를 받아 해지승인을 하고 전산코드를 삭제한다. 대리점을 대상으로 고객서비스 교육을 기획한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0261","dJobECdNm":"[0261]기획·마케팅 사무원","dJobJCd":"3121","dJobJCdNm":"[3121]기획 및 마케팅 사무원","dJobICd":"G473","dJobICdNm":"[G473]가전제품 및 정보통신장비 소매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005904:1', '{"dJobCd":"K000005904","dJobCdSeq":"1","dJobNm":"발전환경입지계획원","workSum":"발전소 주변의 환경보전 및 유지를 위한 기본계획 및 정책을 수립하고 입지선정, 환경피해에 대한 종합적 방지 및 대책을 위한 환경 관련 각종 기술업무를 수행한다.","doWork":"발전소의 입지, 설비 및 환경조건에 대한 자료를 조사·정리한다. 발전소 후보입지 조사계획을 수립 및 시행한다. 각 발전소의 배출가스, 소음, 분진, 폐수 등에 의한 지역 환경오염과 민원발생 가능성을 예측하고 입지 및 환경조건의 변화를 고려한 발전소별 환경대책의 방향을 예측·평가한다. 환경오염방지설비의 개선, 환경피해 연구보상, 주민이주, 피해지역의 지역 또는 지상권의 설정과 같은 발전소 주변지역의 보상 관련 기본계획수립 및 처리 관련 업무를 수행한다. 발전소별 환경피해 진정 및 처리현황을 파악·분석하고 연간 환경피해보상계획을 수립·조정한다. 진정내용을 조사·정리하여 처리계획을 검토·보고하고 관련 실적 및 서류를 관리한다. 발전소 인근주민에 대한 환경대책을 수립하기 위하여 여론조사, 주민의식조사 등을 시행하고 자료를 분석하여 대책을 수립한다. 발전소 환경개선 및 오염방지 등에 대한 홍보 및 지역지원을 위한 방안을 제시한다. 발전소 인근 주민의 생활환경개선을 위한 온·배수를 이용한 양식기술의 개발, 종묘 생산기술, 원예작물 재배기술, 산업폐기물 이용기술의 개발을 위한 용역시행 등의 계획을 수립·관리하고 보급하기 위한 중·장기 대책을 수립·시행한다. 환경 관련 정보관리 및 국제협력을 위한 제반 업무를 수행한다. 환경방사능 관련 업무를 포함한 발전소 주변의 환경영향조사 및 환경보전대책을 수립한다. 환경에 영항을 미치는 배출폐기물을 종합관리하고 폐기물 활용 및 감량화를 위한 계획을 수립하고 시행한다. 기타 환경 관련 업무를 처리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","connectJob":"발전소 주변의 환경관련 업무를 수행하는 전문분야에 따라 발전환경보전계획원, 자원활용계획원, 보상관리계획원, 입지기술원","dJobECd":"0261","dJobECdNm":"[0261]기획·마케팅 사무원","dJobJCd":"3121","dJobJCdNm":"[3121]기획 및 마케팅 사무원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002596:1', '{"dJobCd":"K000002596","dJobCdSeq":"1","dJobNm":"방재전문가","workSum":"재해발생 시 피해를 최소화하기 위한 대책을 마련하며 교육과 훈련, 재난발생 양상분석, 재난발생 원인규명 등의 활동을 한다.","doWork":"각종 재난에 대응하는 계획을 수립하고 재난대응 행동매뉴얼을 작성한다. 교육과 훈련의 실시, 재난발생 양상분석, 재난발생 원인규명 등의 활동을 한다. 평상시에는 위기관리계획 등을 세워 안전점검 등 예방활동을 하며, 국가위기 및 재난상황에 대비한다. 재난발생 시, 피해 현장대응 및 상황관리활동과 복구지원업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"기업재난관리사, 방재기사","dJobECd":"0261","dJobECdNm":"[0261]기획·마케팅 사무원","dJobJCd":"3121","dJobJCdNm":"[3121]기획 및 마케팅 사무원","dJobICd":"M715","dJobICdNm":"[M715]회사 본부 및 경영 컨설팅 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004006:1', '{"dJobCd":"K000004006","dJobCdSeq":"1","dJobNm":"백화점매장관리원","workSum":"백화점에서 상품을 판매하며 판매에 관련한 전반적인 사항을 관리한다.","doWork":"백화점에서 상품판매에 관련된 전반적인 사항을 처리·관리한다. 해당 매장에서 일하는 직원의 월급, 복지, 복무사항 등에 대한 전반적인 것을 관리한다. 매장에서 주기적으로 물품을 구입하는 고객을 관리하고 물품주문, 납품 등을 효과적으로 관리하여 매출을 높인다. 백화점에서 이루어지는 기획상품에 대한 참여계획을 수립한다. 업체로부터 납품받은 물품의 수량과 품질을 확인하며 판매계획을 수립한다. 물품업체와 전산망으로 물품을 주문하고 반품·교환처리한다. 세금 및 백화점과의 수익을 계산한다. 백화점상품판매원의 업무를 수행하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"감독","workFunc3":"단순작업","similarNm":"샵마스터","certLic":"유통관리사","dJobECd":"0261","dJobECdNm":"[0261]기획·마케팅 사무원","dJobJCd":"3121","dJobJCdNm":"[3121]기획 및 마케팅 사무원","dJobICd":"G471","dJobICdNm":"[G471]종합 소매업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007305:1', '{"dJobCd":"K000007305","dJobCdSeq":"1","dJobNm":"백화점영업관리원","workSum":"백화점에 입점한 각 매장들의 매출을 평가·관리한다.","doWork":"백화점 매출이나 기여도 등으로 입점한 매장에 대한 평가를 실시하고 관리한다. 백화점 매출을 제고하기 위해 수시로 행사를 기획하고 백화점 광고를 한다. 매장에서 이루어진 전표를 관리한다. 카드나 상품권 발행 및 회수에 대한 업무를 수행한다. 매장에 납품되는 물품에 대한 재고를 관리하는 작업원을 관리한다. 실적이 낮은 매장에 대한 계약 해지업무를 한다. 백화점의 매출 및 이미지 향상에 도움이 될 것으로 예상되는 매장을 신규로 선정하여 입점 업무를 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","certLic":"유통관리사","dJobECd":"0261","dJobECdNm":"[0261]기획·마케팅 사무원","dJobJCd":"3121","dJobJCdNm":"[3121]기획 및 마케팅 사무원","dJobICd":"G471","dJobICdNm":"[G471]종합 소매업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003804:1', '{"dJobCd":"K000003804","dJobCdSeq":"1","dJobNm":"부가가치통신망기획사무원","workSum":"부가가치통신망(VAN:Value Added Network) 업무에 관한 사업추진계획을 수립하고 제 규약을 정비하며 신규업무 발굴추진 및 단말기 수급관리 등 부가가치통신망 업무 전반에 걸친 기획업무를 수행한다.","doWork":"금융결제원 업무로서 부가가치통신망(VAN:Value Added Network)업무 관련 사업추진계획을 수립하여 추진한다. 효율적인 부가가치통신망 운영을 위한 부가가치통신망 업무의 개선사항을 검토하여 처리절차를 개선하고 제 규약 및 계약서에 반영한다. 부가가치통신망 업무 확대를 위하여 시스템통합(SI) 사업추진 및 신규업무 발굴 등을 검토·추진한다. 단말기 수급관리를 위하여 부가가치통신망 서비스를 구현할 단말기의 개발 및 제조, 공급을 검토·추진한다. 부가가치통신망 자료의 대내외 활용 등을 위하여 부가가치통신망 업무처리와 관련된 통계자료를 수집·관리·분석한다. 이용요금이나 이용수수료 등의 정산업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"VAN기획사무원","dJobECd":"0261","dJobECdNm":"[0261]기획·마케팅 사무원","dJobJCd":"3121","dJobJCdNm":"[3121]기획 및 마케팅 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007096:1', '{"dJobCd":"K000007096","dJobCdSeq":"1","dJobNm":"부동산분양사무원","workSum":"주택단지, 아파트 등의 주택을 비롯하여 상가, 오피스텔, 택지 등의 부동산 분양을 촉진시키기 위하여 분양계획을 수립·보고하고, 분양 관련 업무를 수행한다.","doWork":"건축물에 대한 구매 시장조사를 한다. 조사된 각종 자료를 기초로 건축물의 내부자재, 수요에 맞는 평형 등을 파악하여 계획을 수립한다. 분양조건 및 공급가격을 분석하여 결정한다. 분양내역 및 조건, 자사상품 구매 시 이익 등을 파악하여 사전 홍보계획을 수립한다. 홍보 팸플릿을 배포하고, 신문, 잡지 등을 통하여 분양홍보를 실시한다. 견본주택 개관 및 폐관을 위한 계획을 수립하고, 절차에 따라 준비한다. 분양기간 중 매일 분양신청현황을 파악하여 보고한다. 고객과 계약조건에 따라 공급계약을 체결한다. 공급 후 대금징수결정고지서 발급 및 수입금 징수, 선수금 수납 및 조정, 소유권 이전업무 등을 한다. 고객과 융자금에 대한 제반 문제를 상담하고, 융자금 대부에 대한 문제를 해결한다. 명의변경에 따른 계약서 작성업무 및 등기신청을 접수받기도 한다. 분양에 따른 사후관리를 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"설득","workFunc3":"관련없음","connectJob":"주택분양사무원, 상가분양사무원, 택지분양사무원, 기획분양사무원, 분양마케팅사무원, 분양상담사, 분양홍보사무원, 임대사무원, 임대관리사무원, 납골당분양사무원, 리조트분양영업원, 콘도분양영업원, 상가분양영업원","dJobECd":"0261","dJobECdNm":"[0261]기획·마케팅 사무원","dJobJCd":"3121","dJobJCdNm":"[3121]기획 및 마케팅 사무원","dJobICd":"L681","dJobICdNm":"[L681]부동산 임대 및 공급업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006495:1', '{"dJobCd":"K000006495","dJobCdSeq":"1","dJobNm":"부동산임대사무원","workSum":"적정 임대료를 산정하여 모집한 임차인과 임대차계약을 체결하고 기존 임차인에 대한 임대료 징수업무를 함으로써 부동산 소유주에게 최적의 임대수익이 발생되도록 한다.","doWork":"부동산 소유주의 의뢰를 받아, 주변의 평당 임대료, 공실율, 임대료 전망, 임대형태 및 조건 등 임대시장을 분석하여 적정 보증금 및 임대료를 산정하고, 임대전략을 수립한다. 임차인 모집을 위한 홍보를 실시한다. 임차인이 모집되면 임차인의 신용도를 체크하여 임대계약을 체결한다. 기존 임차인에 대한 재계약 및 계약해지업무도 수행한다. 공실률이 최소화되도록 전체 임대스케줄을 관리한다. 임차인들에 대한 임대료 부과 및 징수업무를 하고, 임대료의 회계 및 결산업무를 수행한다. 임차인의 만족도조사를 실시하거나 주변 빌딩의 사례 등을 조사하여 임차인이 최적의 시설을 사용할 수 있도록 관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"임대사무원","dJobECd":"0261","dJobECdNm":"[0261]기획·마케팅 사무원","dJobJCd":"3121","dJobJCdNm":"[3121]기획 및 마케팅 사무원","dJobICd":"L681","dJobICdNm":"[L681]부동산 임대 및 공급업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001632:1', '{"dJobCd":"K000001632","dJobCdSeq":"1","dJobNm":"부동산정비사업관리자","workSum":"주택재건축사업, 주택재개발사업, 도시환경정비사업 등을 시행하고자 하는 추진위원회나 조합 등 사업시행자의 업무를 대행·지원하고, 자문하는 일을 한다.","doWork":"사업시행자로부터 위탁을 받아, 조합설립의 동의 및 정비사업의 동의에 관한 업무, 조합설립인가의 신청에 관한 업무, 사업성검토 및 정비사업의 시행계획서 작성, 설계자 및 시공사 선정에 관한 업무, 사업시행인가의 신청에 관한 업무, 분양 및 관리처분계획의 수립에 관한 업무를 대행하거나 자문하는 일을 한다. 설계도서의 검토 및 공사비 변동내역을 검토한다. 그밖에 조합업무 중 조합이 요청하는 업무를 지원한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"재건축정비사업자, 재개발정비사업자, 도시환경정비사업자","certLic":"공인중개사","dJobECd":"0261","dJobECdNm":"[0261]기획·마케팅 사무원","dJobJCd":"3121","dJobJCdNm":"[3121]기획 및 마케팅 사무원","dJobICd":"L681","dJobICdNm":"[L681]부동산 임대 및 공급업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003011:1', '{"dJobCd":"K000003011","dJobCdSeq":"1","dJobNm":"블로거","workSum":"인터넷상에서 블로그(Blog, Vlog)를 개설하고 운영하며 글, 그림, 음악, 동영상 등 다양한 콘텐츠를 생산하고 공유한다.","doWork":"인터넷상에서 블로그 계정을 생성하고 블로그를 개설한다. 블로그의 주제를 정하고 레이아웃(블로그 정보, 소개글, 메뉴, 카테고리, 디자인, 스타일 등)을 설정한다. 다양한 주제에 대해 글, 그림, 사진, 음악, 동영상, 웹링크 등을 활용하여 콘텐츠를 작성한다. 작성된 콘텐츠를 블로그에 게시하여 공유한다. 댓글이나 공감, 이웃맺기 등의 기능을 활용하여 블로그 방문자와 소통하며 정보를 공유·확산한다. 방문자 통계, 페이지뷰, 검색엔진최적화 등의 방법으로 블로그를 운영·관리한다. 전문분야의 지식과 경험을 바탕으로 기업, 기관, 상품, 서비스, 홍보물 등에 대한 콘텐츠를 생산하거나 체험후기, 배너광고 등 상업적 콘텐츠를 블로그에 게시하기도 한다. 블로그 플랫폼을 활용한 다양한 마케팅 활동을 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"파워블로거, 전문블로거","dJobECd":"0261","dJobECdNm":"[0261]기획·마케팅 사무원","dJobJCd":"3121","dJobJCdNm":"[3121]기획 및 마케팅 사무원","dJobICd":"N759","dJobICdNm":"[N759]기타 사업지원 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004055:1', '{"dJobCd":"K000004055","dJobCdSeq":"1","dJobNm":"산업기계장비임대사무원","workSum":"제조생산용 기계장비, 건설 및 토목공사용 기계장비, 연구·실험기기, 의료기기 등의 산업용 기계 및 장비에 대한 임대영업, 계약 등에 관한 업무를 수행한다.","doWork":"산업설비를 필요로 하는 신규설립업체와 시설확장업체를 조사한다. 대상업체에 임대설비의 경제성과 장점 등을 홍보한다. 사업체에서 산업설비의 임대요청을 접수하고 대상 설비의 품명, 기종, 제작회사 및 가격 등을 확인한다. 설비의 임대조건을 결정하고 대상 설비임대에 따른 이자율을 책정한다. 임대를 요구한 사업체의 재무구조, 사업전망 등의 자료를 수집하고, 대상 사업체의 신용을 심사하는 데 필요한 관련 서류를 요청한다. 임대조건, 담보조건 등을 결정하고 임대계약을 체결한다. 임대계약에 따라 임대설비를 구매 주문하고, 수입설비의 경우 수입허가를 얻어 통관절차를 수행한다. 임대설비 구입에 따른 물건대금, 통관, 운반 등에 수반되는 제반 비용을 지급한다. 구입설비를 인도하고 임대변경(확정) 계약을 체결하여 계약내용에 따라 임대료를 수납한다. 임대기한이 만료되면 임대물을 회수한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"설득","workFunc3":"관련없음","similarNm":"임대계약사무원","connectJob":"담당업무에 따라 임대료수납원, 임대상담원, 임대심사원, 임대하는 기계류의 종류나 산업에 따라 광업장비임대사무원, 농업용장비임대사무원, 중장비임대사무원, 공작기계임대사무원, 사무용기기임대사무원, 영화촬영장비임대사무원","dJobECd":"0261","dJobECdNm":"[0261]기획·마케팅 사무원","dJobJCd":"3121","dJobJCdNm":"[3121]기획 및 마케팅 사무원","dJobICd":"N763","dJobICdNm":"[N763]산업용 기계 및 장비 임대업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005983:1', '{"dJobCd":"K000005983","dJobCdSeq":"1","dJobNm":"수도용수판매관리원","workSum":"용수공급을 위한 판매계획을 수립하고 용수사용계약 체결 및 요금산정업무를 수행한다.","doWork":"상수도요금(계량기 구경별 기본요금 및 가정용, 대중목욕탕용, 업무용, 영업용 업종에 따른 누진체계로 부과), 하수도요금, 물이용 부담금 등 산출규정에 따라 수도요금을 산출한다. 공급된 용수의 양을 확인하고 요금고지서를 발부하여 요금을 징수한다. 용수의 공급량 및 판매실적을 관리한다. 건물 또는 토지의 매매 등으로 수도사용자의 변동이 있는 때에는 새로운 급수사용자에게 요금이 승계되도록 한다. 미납요금에 따른 단수조치를 취하거나 누수로 인하여 사용량이 과도하게 검량된 경우 평균 사용량을 고려하여 누수량을 상계하기도 한다. 사용고객의 문의에 응대하고 불편사항을 접수하여 처리하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0261","dJobECdNm":"[0261]기획·마케팅 사무원","dJobJCd":"3121","dJobJCdNm":"[3121]기획 및 마케팅 사무원","dJobICd":"E360","dJobICdNm":"[E360]수도업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007279:1', '{"dJobCd":"K000007279","dJobCdSeq":"1","dJobNm":"신문판매지국관리원","workSum":"신문을 수요자에게 판매·보급하는 지국(支局)을 관리하기 위한 제반 업무를 수행한다.","doWork":"신문의 배달과 분배를 예정하고 분배량과 반환량에 따라 발주량을 조절한다. 신문판매실적을 평가하고 판매촉진계획과 훈련교육을 통하여 판매상인 및 배달사원을 돕는다. 신문이 신속하고 정확하게 배달되는지 확인하기 위하여 판매노선의 배달상태를 점검한다. 판매상인·배달사원에게 보급지시 및 판매변경사항 등을 전달하거나 설명한다. 신문보급소의 판매상의 불만이나 애로사항을 조사·조정한다. 보급계획을 세우는 데 필요한 판매통계를 분석한다. 체납된 계산서를 검토하여 체납액을 징수한다. 신규배달사원 교육을 위하여 판매노선기록부를 제작하고 변경사항을 수시로 기록한다. 지국에서 이루어지는 광고지 관련 업무를 수행하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"감독","workFunc3":"관련없음","similarNm":"신문보급판매대리인","dJobECd":"0261","dJobECdNm":"[0261]기획·마케팅 사무원","dJobJCd":"3121","dJobJCdNm":"[3121]기획 및 마케팅 사무원","dJobICd":"J581","dJobICdNm":"[J581]서적, 잡지 및 기타 인쇄물 출판업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003739:1', '{"dJobCd":"K000003739","dJobCdSeq":"1","dJobNm":"신재생에너지사업관리자","workSum":"신·재생에너지 사업을 개발 및 운영한다.","doWork":"태양광, 태양열, 바이오, 풍력, (소)수력, 해양, 폐기물, 지열, 연료전지, 석탄액화가스화 및 중질잔사유가스화, 수소에너지 등의 신·재생에너지를 이용한 발전소를 개발 및 운영하여 생산한 전기를 한국전력거래소나 한국전력공사에 판매하는 사업을 한다. 신·재생에너지 사업의 시장분석, 사업성 및 타당성 조사, 신·재생에너지 산업의 사업구조 및 금융구조 등을 분석한다. 기초지자체로부터 발전소 부지에 대한 개발행위 허가의 가능 여부를 확인한 후, 사업부지를 확보한다. 발전용량에 따라 광역지자체나 산업통상자원부로부터 발전사업 허가를 신청하여 취득한다. 발전소 건설 시, 자금조달이나 사업부지 인근의 주민과의 관계, 환경훼손 등의 문제를 해결하기 위한 활동을 하기도 한다. 발전소가 완공되면 한국전력거래소 및 한국전력공사에 신청하여 계통연계를 하고 발전사업을 개시한다. 발전소운전원의 채용이나 에너지관리공단으로부터 발전차액 대상설비 설치확인 등 발전소 운영을 위한 제반 업무를 발전소 직원들에게 지시하고 관리·감독한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0261","dJobECdNm":"[0261]기획·마케팅 사무원","dJobJCd":"3121","dJobJCdNm":"[3121]기획 및 마케팅 사무원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001295:1', '{"dJobCd":"K000001295","dJobCdSeq":"1","dJobNm":"에스코(ESCO)사업관리사무원","workSum":"에스기업(ESCO:Energy Service Company)이 에너지 사용자를 대신해 에너지 절약시설에 기술과 자금을 투자하고 이에 따른 에너지 절감액으로 투자비를 회수하는 사업을 기획하고 추진한다.","doWork":"에스코기업(ESCO, Energy Service Company:에너지 사용자를 대신해 에너지 절약시설에 투자하고 이에 따른 에너지 절감액으로 투자비를 회수하는 기업) 고객을 위한 예비조사와 상담을 한다. 상담 후 간이제안서를 준비하고 고객이 사업성 여부에 대한 결정을 내리도록 도와준다. 고객이 사업을 계속 진행하고 싶어 하면 사업에 대한 정밀진단을 하여 사업제안서를 제출한다. 사업화가 결정되면 에스코 성과계약에 대한 세부내용을 준비하여 시설공사에 들어갈 수 있도록 한다. 시설가동 후 에너지 절감에 따른 성과배분을 고객에게 돌려줄 수 있도록 조치한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0261","dJobECdNm":"[0261]기획·마케팅 사무원","dJobJCd":"3121","dJobJCdNm":"[3121]기획 및 마케팅 사무원","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002600:1', '{"dJobCd":"K000002600","dJobCdSeq":"1","dJobNm":"연구관리사무원","workSum":"연구의 효과적인 수행과 연구결과물의 효율적 사용을 위하여 연구사업협약, 연구수행관리, 연구성과관리, 기술이전에 관한 업무를 수행한다.","doWork":"연구사업을 효과적으로 수행하기 위해 정부, 기업, 학교와 협약체결을 준비하고 진행한다. 논문, 산업재산권, 특허권 등 연구성과물을 관리한다. 산업체 등 기술수요자에게 연구방법, 기술, 성과물 등을 이전하기 위한 행정업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0261","dJobECdNm":"[0261]기획·마케팅 사무원","dJobJCd":"3121","dJobJCdNm":"[3121]기획 및 마케팅 사무원","dJobICd":"M701/M702","dJobICdNm":"[M701]자연과학 및 공학 연구개발업 / [M702]인문 및 사회과학 연구개발업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003673:1', '{"dJobCd":"K000003673","dJobCdSeq":"1","dJobNm":"연구기획사무원","workSum":"연구업무의 효율적 수행을 위해 연구소의 발전계획 수립, 연구사업 진행, 관리, 평가 등 연구 관련 기획 및 지원업무를 한다.","doWork":"년 또는 분기 단위별로 연구예산을 수립하고 조정한다. 연구의 진행 및 일정을 관리한다. 연구원의 인사 및 평가계획을 수립한다. 연구소의 장기발전계획을 수립한다. 연구원 교육 및 훈련프로그램을 계획하고 실행한다. 연구논문 및 특허 등 연구성과를 관리한다. 대외기관과 협력하거나 연구결과를 대내외로 홍보한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0261","dJobECdNm":"[0261]기획·마케팅 사무원","dJobJCd":"3121","dJobJCdNm":"[3121]기획 및 마케팅 사무원","dJobICd":"M701/M702","dJobICdNm":"[M701]자연과학 및 공학 연구개발업 / [M702]인문 및 사회과학 연구개발업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003787:1', '{"dJobCd":"K000003787","dJobCdSeq":"1","dJobNm":"영업지원사무원","workSum":"기업의 영업생산성을 증대할 목적으로 현장영업원의 영업활동에 관련된 제반 관리업무(유통, 실적, 전산, 서류, 통계, 결산 등)를 수행한다.","doWork":"영업전략을 수립하거나 수립된 영업전략에 따른 영업지침을 현장영업원에게 전달한다. 영업활동에 수반되는 서류작성, 통계작성, 영업문서작성, 영업결산, 실적결산 등의 업무를 수행한다. 제품 및 서비스의 판매에 따른 유통지원, 전산처리, 매출정산 등 후선지원업무를 수행한다. 영업을 촉진하기 위한 프로모션, 홍보, 교육, 운영관리(매장 등에 대한)업무를 수행하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"영업관리사무원","connectJob":"외근영업지원사무원, 영업서류지원사무원, 영업통계작성원, 영업서무사무원, 영업문서작성원, 영업결산사무원, 판매관리사무원, 판매지원사무원, 판매실적정리사무원, 판매결산사무원","dJobECd":"0261","dJobECdNm":"[0261]기획·마케팅 사무원","dJobJCd":"3121","dJobJCdNm":"[3121]기획 및 마케팅 사무원","dJobICd":"ALL","dJobICdNm":"[ALL]전체","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004853:1', '{"dJobCd":"K000004853","dJobCdSeq":"1","dJobNm":"영화배급원","workSum":"영화제작사를 대리하여 영화데이터를 극장(영화상영사)에 배급·판매하거나 부가판권에 대한 관리 및 계약업무를 수행한다.","doWork":"영화배급관리자의 지시를 받아 세관의 통관절차에 따라 외화를 수입하고 관리한다. 영상데이터를 운반·관리한다. 상영 허가 및 등급 결정을 위하여 심의를 의뢰한다. 예고편 제작, 포스터 제작, 자막작업을 의뢰하고 관리한다. VOD, 케이블 TV, 공중파 등 2차 저작물인 부가판권을 관리하고 계약을 진행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0261","dJobECdNm":"[0261]기획·마케팅 사무원","dJobJCd":"3121","dJobJCdNm":"[3121]기획 및 마케팅 사무원","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005577:1', '{"dJobCd":"K000005577","dJobCdSeq":"1","dJobNm":"영화상영기획원","workSum":"극장에 상영할 프로그램을 선정하고 거래처와 계약을 체결하며, 영화상영과 관련된 업무를 수행한다.","doWork":"각종 영화시사회에 참석하여 상영프로그램을 선정한다. 극장에서 상영할 영화를 선정하고 월별, 연별 상영프로그램을 계획한다. 영화배급처와 협의 또는 계약하에 영화상영계약을 체결하며, 극장에서 상영과 관련된 모든 업무를 계획 및 관리한다. 상영 중인 영화의 인기도와 극장수입을 분석하여 영화상영기간을 결정한다. 상영할 영화에 대한 간판 등의 홍보물을 외부에 의뢰하고, 텔레비전, 지하철 등 기타 광고매체를 이용하여 상영할 영화에 대한 홍보업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"시각|","workFunc1":"수집","workFunc2":"협의","workFunc3":"관련없음","similarNm":"극장프로그래머","dJobECd":"0261","dJobECdNm":"[0261]기획·마케팅 사무원","dJobJCd":"3121","dJobJCdNm":"[3121]기획 및 마케팅 사무원","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005901:1', '{"dJobCd":"K000005901","dJobCdSeq":"1","dJobNm":"용지조사원","workSum":"주택, 공장부지, 상가부지의 조성에 적합한 용지를 물색하고 조사하여 용지매입에 따른 제반 자료를 수집·분석한다.","doWork":"시중의 부동산중개사무소 또는 일간지와 관련 정보지를 통해 용지매입정보와 자료를 수집·분석한다. 분석결과 매입에 적합한 용지로 판단되면 해당 용지의 현장을 답사하고, 용지주변의 상황을 조사한다. 조사 및 수집·분석된 자료를 정리하고 필요한 부분을 보완한다. 조사용지에 대한 매입적격성 여부를 분석하여 보고서를 작성한다. 필요에 따라 특정용지에 대한 소유주의 인적사항이나 사업현황 및 전망 등에 대한 조사보고서를 작성하여 보고한다. 수시로 부동산 경기동향과 지역별 지가조사를 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"설득","workFunc3":"관련없음","connectJob":"부동산감정평가사무원","dJobECd":"0261","dJobECdNm":"[0261]기획·마케팅 사무원","dJobJCd":"3121","dJobJCdNm":"[3121]기획 및 마케팅 사무원","dJobICd":"L681","dJobICdNm":"[L681]부동산 임대 및 공급업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004272:1', '{"dJobCd":"K000004272","dJobCdSeq":"1","dJobNm":"이스포츠경기단체사무원","workSum":"e스포츠 경기단체에서 e스포츠 종목선정, 대회운영, 경기규정 및 제도, 선수등록 및 관리에 대한 제반 사무 및 행정업무를 수행한다.","doWork":"e스포츠 관련 위원회를 기획하고 운영한다. 위원회의 의결에 따라 e스포츠대회의 운영기준을 정하고 선수등록 및 랭킹시스템을 운영한다. e스포츠 경기 및 관련 행사일정을 수립하고 추진한다. 경기규정 및 제도를 운영한다. 참가선수의 대진표를 작성하고 선수등록, 랭킹, 경기결과를 기록하고 관리한다. 해외의 e스포츠협회와 교류·협력하며 국제e스포츠 표준화 및 세계e스포츠대회 관련 업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0261","dJobECdNm":"[0261]기획·마케팅 사무원","dJobJCd":"3121","dJobJCdNm":"[3121]기획 및 마케팅 사무원","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001818:1', '{"dJobCd":"K000001818","dJobCdSeq":"1","dJobNm":"인터넷부동산정보제공원","workSum":"부동산정보서비스 제공을 위한 웹사이트의 구축 및 제공업무와 온라인 주택청약 관련 업무를 한다.","doWork":"부동산정보 제공을 위한 인터넷 온라인 종합정보서비스시스템을 설계·구축하고 사후관리를 한다. 일반 부동산정보서비스회사의 정보, 자료와 은행 등 금융회사의 부동산 대출통계 등 부동산정보 및 자료를 실시간으로 인터넷 온라인상으로 제공한다. 온라인 부동산정보서비스의 마케팅을 추진하고 데이터베이스를 구축한다. 서비스개발계획 및 제공효과를 분석한다. 우량콘텐츠 제공업체를 발굴하고 섭외한다. 주택청약과 관련한 온라인서비스를 수행한다. 주택당첨자를 추첨하며 당첨자추첨프로그램을 개발한다. 온라인 주택청약서비스를 개선하고 대내·외에 홍보한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0261","dJobECdNm":"[0261]기획·마케팅 사무원","dJobJCd":"3121","dJobJCdNm":"[3121]기획 및 마케팅 사무원","dJobICd":"K641","dJobICdNm":"[K641]은행 및 저축기관","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007685:1', '{"dJobCd":"K000007685","dJobCdSeq":"1","dJobNm":"전기차충전소운영관리자","workSum":"전기차 충전서비스가 원활히 운영될 수 있도록 충전소 및 충전기를 운영하고 관리한다.","doWork":"전기차충전기를 관리시스템에 등록하고 운영상태를 확인한다. 타 충전 사업자와의 로밍서비스 관리와 정산 절차 수행, 계약협상 및 관리, 정부 및 기타 기관과 협업 등 전기차충전 네트워크 관리를 한다. 전기차 충전소에 설치된 안내 및 표지판 관리를 하고 각종 홍보 및 광고를 기획하고 운영한다. 전기차 충전기의 동작상태와 고장 및 비정상적 동작을 파악하고 조치한다. 서비스 플랫폼을 비롯한 전기충전인프라 점검 및 개선, 사용자 경험 개선 등을 계획, 분석하고 실행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"협의","workFunc3":"관련없음","similarNm":"전기차충전사업운영매니저","dJobECd":"0261","dJobECdNm":"[0261]기획·마케팅 사무원","dJobJCd":"3121","dJobJCdNm":"[3121]기획 및 마케팅 사무원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2025"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007686:1', '{"dJobCd":"K000007686","dJobCdSeq":"1","dJobNm":"전기차충전플랫폼운영관리자","workSum":"전기차 충전서비스가 원활히 운영될 수 있도록 전기차 충전플랫폼을 운영하고 관리한다.","doWork":"전기차 충전서비스에 필요한 결제시스템, 충전 사업자 간 로밍서비스, CSMS(충전소 관리 시스템) 등을 운영·관리한다. 충전시설에서 발생하는 충전이력 분석·관리, 충전요금 정산을 수행한다. 전기차 충전서비스 플랫폼 관련으로 정부 및 기타 기관과 협업 등을 추진하고 플랫폼의 개선, 사용자 경험 개선 등을 계획하고 실행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","certLic":"정보처리기사, 정보처리산업기사","dJobECd":"0261","dJobECdNm":"[0261]기획·마케팅 사무원","dJobJCd":"3121","dJobJCdNm":"[3121]기획 및 마케팅 사무원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2025"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003242:1', '{"dJobCd":"K000003242","dJobCdSeq":"1","dJobNm":"전력거래사무원","workSum":"전력시장을 통한 전력거래를 위해 입찰, 정산, 계량 등의 업무를 수행한다.","doWork":"표준발전기 공사비와 연료비 단가 등에 따른 발전비용을 산정하여 전력시장운용자에게 제출한다. 발전가능 용량에 따라 공급가능 발전용량을 입찰하고 시장가격에 따른 발전량을 낙찰받아 발전기획사무원에게 통보한다. 전력계통운영자로부터의 급전지시에 따른 전력공급량을 확인하고 전력시장운용자의 정산용량과 비교하여 이상여부를 확인한다. 정산일에 맞춰 공급된 전력량과 공급가에 따른 공급비용을 계산하여 발전대금을 청구한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"계산","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0261","dJobECdNm":"[0261]기획·마케팅 사무원","dJobJCd":"3121","dJobJCdNm":"[3121]기획 및 마케팅 사무원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003190:1', '{"dJobCd":"K000003190","dJobCdSeq":"1","dJobNm":"전력수급기획사무원","workSum":"전력시장에 참여하고 있는 발전사업자로부터 공급받는 전기에너지의 계통한계가격을 결정하고 전력운영계획을 수립한다.","doWork":"전력시장에 참여하고 있는 발전사업자로부터 전기에너지 공급계획을 미리 제출받아 시간대별 수요를 예측하여 각 발전기의 변동비와 가용용량, 기술적 특성을 이용하여 계통한계가격을 결정하고 발전계획을 수립한다. 입찰을 통해 시장가격에 따른 발전사업자를 선정하고 전기에너지의 소비특성을 검토하여 실시간 전력의 불균형이 생기지 않도록 총 발전용량에 비해 소비가 많을 경우 소비를 제한하기 위해 전력운영계획을 수립한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"전력시장운영사무원","dJobECd":"0261","dJobECdNm":"[0261]기획·마케팅 사무원","dJobJCd":"3121","dJobJCdNm":"[3121]기획 및 마케팅 사무원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002442:1', '{"dJobCd":"K000002442","dJobCdSeq":"1","dJobNm":"전력수요개발원","workSum":"효율적인 전력수요관리를 위한 정책 및 계획을 수립하고 전력부하관리 및 전력기기 보급에 관련된 업무를 수행한다.","doWork":"수용가(소비자)에 안정적이고 효율적인 전력공급을 위한 수요관리 정책 및 계획을 수립한다. 전력수요관리를 위한 제도의 설정 및 운영을 한다. 단기전력 수급에 대한 대책을 수립하고 시행한다. 전기기기 보급 및 부하형태에 대한 조사·분석을 통하여 효율적인 고객의 전력사용을 위한 방안을 제시한다. 축열식 냉·난방기기 등 부하관리용 기기를 개발하고 보급한다. 고객의 전기이용에 대한 효율성 향상을 위하여 고효율 기기 보급을 위한 방안을 수립한다. 효율적인 전기이용을 위한 기술개발을 하며, 고객상담 및 홍보를 통하여 보급한다. 기타 전력수요관리를 위한 수요개발업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0261","dJobECdNm":"[0261]기획·마케팅 사무원","dJobJCd":"3121","dJobJCdNm":"[3121]기획 및 마케팅 사무원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004990:1', '{"dJobCd":"K000004990","dJobCdSeq":"1","dJobNm":"전력영업사무원","workSum":"수요자의 신·증설 전력공급신청에 따른 승인 및 송전 관련 업무를 수행한다.","doWork":"전력공급에 관한 기본계획을 검토하고, 신규고객에 대한 전기공급방안을 수립한다. 민원상담사무원으로부터 접수된 신규고객의 전력공급신청서를 검토하여 승인여부를 판단하고 공급방안을 결정한다. 전력공급에 대한 신규고객의 승인이 결정되면, 공사비를 청구하고 납부를 확인한다. 배전 관련 부서에 신규전력공급에 따른 외선공사를 의뢰하고, 공사 준공을 확인한다. 내선 관련 부서에 신규고객에 전력을 공급하도록 송전의뢰를 한다. 송전이 완료되면 고객에게 통보하고 관련 서류를 정리·보관한다. 불법건축물 단전, 전주광고대행 등 부대업무를 수행하며, 지장전주 이설업무를 처리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"서비스제공","workFunc3":"관련없음","dJobECd":"0261","dJobECdNm":"[0261]기획·마케팅 사무원","dJobJCd":"3121","dJobJCdNm":"[3121]기획 및 마케팅 사무원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002885:1', '{"dJobCd":"K000002885","dJobCdSeq":"1","dJobNm":"전시장관리원","workSum":"전시장의 임대와 관련된 계약 등의 업무를 하며 전시와 관련된 업체선정 업무를 관리한다.","doWork":"전시장의 연간 전시가능일수를 계산한다. 전시기획업체에 대한 영업활동을 한다. 기존 전시회 외에 새롭게 계약된 전시회의 일정을 조정하고 전시장을 배정한다. 확정된 전시장 요율을 적용하여 전시장 임대단가를 확정하여 계약한다. 장치, 인력, 경비, 청소 등 전시장 등록업체와의 계약을 관리한다. 장치업체나 철거업체에게 물품반입증과 반출증을 발급한다. 각종 전시에 필요한 부대요금(전기, 청소, 냉·난방비)을 계산한다. 전시가 끝난 후 결과보고서 및 정산서를 작성한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0261","dJobECdNm":"[0261]기획·마케팅 사무원","dJobJCd":"3121","dJobJCdNm":"[3121]기획 및 마케팅 사무원","dJobICd":"N759","dJobICdNm":"[N759]기타 사업지원 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005619:1', '{"dJobCd":"K000005619","dJobCdSeq":"1","dJobNm":"주택분양성조사원","workSum":"주택단지 및 아파트단지의 재개발, 재건축을 포함한 건설계획을 수립하기 위한 각종 정보를 수집하여 주택분양의 사업타당성을 조사·분석한다.","doWork":"주택단지 및 아파트단지의 건설계획을 수립하기 위하여 토지소유주로부터 의뢰받거나 재개발 또는 재건축이 가능할 것 같은 지역을 물색한다. 의뢰받거나 물색된 지역의 주변 분양가나 매매가, 분양율, 교통여건, 인구증가율, 학군, 경제성장률 등의 정보를 부동산소개업자, 군·시청 등을 통하여 수집한다. 수집된 자료를 기초로 사업성을 분석하여 보고서를 작성한다. 주변여건과 비교하여 소비자 성향에 맞는 평형 및 배치 여부, 사업계획에 따른 승인업무, 고도제한·개발제한 등의 법적 인·허가 문제점 및 입주자 모집 여건과 적정분양가의 타당성 여부를 검토하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0261","dJobECdNm":"[0261]기획·마케팅 사무원","dJobJCd":"3121","dJobJCdNm":"[3121]기획 및 마케팅 사무원","dJobICd":"F411","dJobICdNm":"[F411]건물 건설업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004714:1', '{"dJobCd":"K000004714","dJobCdSeq":"1","dJobNm":"주택용지매입사무원","workSum":"회사 자체에서 공동주택·아파트 등의 건축물을 건설하기 적합한 용지를 물색·조사하여 수익성 평가를 통해 주택용지 매입 계약을 추진한다.","doWork":"부동산업 및 중개업자, 토지소유자, 일간지, 부동산정보지, 택지개발 관련 기관의 토지공급안내문 등 용지매입에 대한 정보와 자료를 수집한다. 토지의 사업성을 분석·평가하고 분석결과 매입에 적합한 용지로 판단되면 해당 용지에 대한 현장을 답사하고 용지 주변의 상황, 각종 인·허가사항, 대상지의 소재지 시·군의 각종 자료(인구증가율, 주택보급율, 세대수증가율 등) 등을 조사한다. 조사·수집·분석된 자료를 정리하고 필요한 부분에 대하여 보완조사·분석·평가한다. 조사용지에 대한 매입 적격성 여부를 분석하여 구입품의서 및 종합적인 보고서를 작성하여 결재를 받는다. 토지소유주의 인적사항을 조사하고 기조사된 각종 자료를 토대로 토지소유주와 가격에 대한 협의를 하여 개발 시 적정이윤이 가능한 가격에 결정한다. 품의서·전표를 작성하여 경리 부서에 토지구입가격에 대한 지불을 의뢰한다. 매입계약 체결 후 정해진 납기에 중도금, 잔금 등의 납부 및 매입에 따른 세금을 납부한다. 부동산 경기 동향과 지역별 지가조사를 실시하여 변동사항을 체크한다. 토지소유권 이전 후 사업가능시기에 사업계획담당자에게 이관하고 매매계약체결 후 토지명도, 사용할 시기 등의 문제가 발생하면 토지공급자와 협의하여 문제점을 해결한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"설득","workFunc3":"관련없음","dJobECd":"0261","dJobECdNm":"[0261]기획·마케팅 사무원","dJobJCd":"3121","dJobJCdNm":"[3121]기획 및 마케팅 사무원","dJobICd":"F411","dJobICdNm":"[F411]건물 건설업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002813:1', '{"dJobCd":"K000002813","dJobCdSeq":"1","dJobNm":"주택청약사무원","workSum":"주택청약을 위한 주택원가산정, 주택분양가 책정 등의 기획업무를 하고 제반 청약업무를 수행한다.","doWork":"부동산 관련 정책의 제도개선과 건설업체에 대한 종합적인 지원서비스를 제공한다. 주택청약을 위한 주택원가산정, 주택분양가 책정 등의 기획업무를 한다. 주택청약 접수방안을 수립하고 시행한다. 주택분양을 위한 광고홍보 계획을 수립하고 시행한다. 판매촉진을 위한 고객 데이터베이스를 관리하고, DM을 발송한다. 분양계약처리 및 계약 후 대금납부처리 등 사후관리업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0261","dJobECdNm":"[0261]기획·마케팅 사무원","dJobJCd":"3121","dJobJCdNm":"[3121]기획 및 마케팅 사무원","dJobICd":"F411","dJobICdNm":"[F411]건물 건설업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003926:1', '{"dJobCd":"K000003926","dJobCdSeq":"1","dJobNm":"증권정보제공원","workSum":"증권시장 관련 각종 통계자료, 연구분석자료, 홍보자료를 발간·배포하여 정책수립, 투자, 연구활동의 자료로 제공하고, 관련 정보를 인터넷에 게재한다.","doWork":"증권시장에 관한 각종 통계자료를 종합·정리하여 책자로 발간하거나 인터넷 등에 게재한다. 조사분석팀에서 분석한 내용이나 홍보내용을 편집하고 원고교정 및 검수과정을 거쳐 국문 혹은 영문으로 간행물을 제작하여 배포한다. 그 외 기타 증권 관련 자료를 책자로 제작하거나 인터넷에 게재한다. 매일의 증권시장 뉴스 및 공시내역을 게재하여 투자편의를 위한 정보로 제공한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"단순작업","dJobECd":"0261","dJobECdNm":"[0261]기획·마케팅 사무원","dJobJCd":"3121","dJobJCdNm":"[3121]기획 및 마케팅 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006708:1', '{"dJobCd":"K000006708","dJobCdSeq":"1","dJobNm":"키워드에디터","workSum":"광고주의 웹사이트와 연관성이 높은 특정 키워드를 개발한다.","doWork":"광고주의 웹사이트 특성을 분석한다. 웹사이트 특성과 적합한 키워드들을 도출한다. 도출된 키워드를 정리해 광고주에게 키워드를 제안한다. 광고주의 웹사이트가 정보로 검색되도록 지원한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"설득","workFunc3":"단순작업","dJobECd":"0261","dJobECdNm":"[0261]기획·마케팅 사무원","dJobJCd":"3121","dJobJCdNm":"[3121]기획 및 마케팅 사무원","dJobICd":"M713","dJobICdNm":"[M713]광고업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005726:1', '{"dJobCd":"K000005726","dJobCdSeq":"1","dJobNm":"태양광발전기획원","workSum":"태양광발전설비의 입지타당성과 사업성을 평가하여 태양광발전설비의 설치를 기획한다.","doWork":"경제성이 높은 태양광발전설비의 입지를 선정하기 위해 일사량, 기후(온도, 바람 등), 계통연계조건, 공사여건 등의 입지조건을 분석하기 위해 관련 자료와 현장조사를 실시한다. 분석된 자료를 바탕으로 평균발전량과 전기판매량을 계산하여 발전수입을 산출한다. 태양광발전설비의 건설과 운영에 필요한 비용에 대비한 경제성을 분석하여 태양광발전설비의 설치타당성과 사업성을 평가·기획한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0261","dJobECdNm":"[0261]기획·마케팅 사무원","dJobJCd":"3121","dJobJCdNm":"[3121]기획 및 마케팅 사무원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002773:1', '{"dJobCd":"K000002773","dJobCdSeq":"1","dJobNm":"통신고객서비스기획원","workSum":"통신사에서 고객만족도를 높이기 위하여 고객서비스를 기획한다.","doWork":"고객만족관리지표를 개발한다. ISO9002(품질시스템 인증) 유지 및 확산 관련 업무를 한다. 서비스 소비자만족도지표를 관리한다. 시장조사전문업체에 고객만족도조사를 의뢰한다. 고객센터, 고객지원(A/S)센터, 직통고객전화, 초고속인터넷, 고객대표자 등의 고객불만채널을 관리한다. 고객만족도를 조사하고 고객불만 피드백체계의 구축, 운영에 대하여 기획한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0261","dJobECdNm":"[0261]기획·마케팅 사무원","dJobJCd":"3121","dJobJCdNm":"[3121]기획 및 마케팅 사무원","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003274:1', '{"dJobCd":"K000003274","dJobCdSeq":"1","dJobNm":"홍보사무원","workSum":"사업체의 홍보 및 광고안을 기획하고 신문, 방송, SNS, 유튜브 등에 홍보한다.","doWork":"홍보환경을 조사하고 관련 정보를 수집한다. 기관의 비전, 목표 등을 고려하여 홍보대상별 목표 설정 및 효과적인 매체를 선정하는 등 홍보 전략 및 계획을 수립한다. 정기간행물이나 홍보자료 등을 발간한다. 시청각 자료를 제작하거나 외부에 의뢰한다. 외부 방문객을 대상으로 홍보비디오를 상영하거나 사업에 대해서 설명한다. 기자재, 세미나실, 전시장 등을 관리한다. 신문, 방송 등 대외기관에 사업성과 관련 보도자료나 해명자료를 작성하고 배포한다. 전략적으로 조직의 이미지를 제고하기 위하여 사회공헌활동을 기획하고 실행한다. 조직문화를 전파하기 위해 현황파악, 계획수립, 활동, 평가 등의 업무를 한다. 조직에 부정적인 영향을 미치는 사건을 사전에 예방하고 발생 시 위기로 전대되는 것을 억제하거나 그로 인한 피해를 최소화하기 위해 위기관리 업무를 한다. 홍보활동을 평가한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"제품홍보사무원, PR사무원, PR전문가, 온라인평판관리자","connectJob":"SNS전문가","dJobECd":"0261","dJobECdNm":"[0261]기획·마케팅 사무원","dJobJCd":"3121","dJobJCdNm":"[3121]기획 및 마케팅 사무원","dJobICd":"ALL","dJobICdNm":"[ALL]전체","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001394:1', '{"dJobCd":"K000001394","dJobCdSeq":"1","dJobNm":"가스안전교육사무원","workSum":"가스 관련 종사자들의 안전교육계획을 수립·추진하고, 교육프로그램을 운영·관리하며, 교육성과를 분석한다.","doWork":"교육수요를 조사하고 안전교육의 시행계획을 수립한다. 안전교육운영 기본지침을 시달하고 관리·감독한다. 기초부, 설비부, 안전관리부 등으로 나누어 교육프로그램을 개발하고 관련 교재개발 및 교재관리를 한다. 초·중등교원 및 순회교육 기본계획 수립, 주문형 위탁교육계획, 공무원 교육계획 수립 및 실시를 한다. 교육생을 지도·관리하고 시험을 실시한 후 평가 및 교육이수에 관한 사항을 관리한다. 교육만족도 및 추가적으로 필요한 교육 등에 대한 설문조사를 실시하고 실적분석 및 통계관리를 한다. 안전교육제도 연구 및 개선에 관한 사항, 안전교육관련 규정의 제·개정업무를 담당한다. LPG자동차 운전자의 법정교육을 온라인과 오프라인으로 진행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"교육","workFunc3":"관련없음","certLic":"가스기술사, 가스기사, 산업기사, 가스기능사, 산업안전지도사","dJobECd":"0262","dJobECdNm":"[0262]인사·교육·훈련 사무원","dJobJCd":"3122","dJobJCdNm":"[3122]인사 및 교육·훈련 사무원","dJobICd":"D352","dJobICdNm":"[D352]연료용 가스 제조 및 배관공급업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002421:1', '{"dJobCd":"K000002421","dJobCdSeq":"1","dJobNm":"교육훈련사무원","workSum":"경영목표를 달성하거나 근로자의 능력을 개발하기 위해 교육훈련 프로그램을 기획하고 교육과정을 진행한다.","doWork":"근로자의 교육 및 훈련 요구를 파악하기 위해서 설문지를 작성하고 설문을 실시한다. 대상 선정 등 교육 및 훈련과정의 일정계획을 수립한다. 교육 및 훈련프로그램 개발과 관련하여 외주관리를 한다. 강의실 점검, 교육준비 등 교육 및 훈련프로그램을 진행한다. 교육 및 훈련과정을 평가하고 개선점을 찾는다. 교육 및 훈련과 관련된 예산 및 행정업무를 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"교육훈련기획사무원, 교육훈련운영사무원, 교육기획사무원, 훈련담당사무원, HRD사무원","dJobECd":"0262","dJobECdNm":"[0262]인사·교육·훈련 사무원","dJobJCd":"3122","dJobJCdNm":"[3122]인사 및 교육·훈련 사무원","dJobICd":"ALL","dJobICdNm":"[ALL]전체","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002096:1', '{"dJobCd":"K000002096","dJobCdSeq":"1","dJobNm":"노무사무원","workSum":"노무사의 지휘하에 노사를 대리하여 관계기관에 행하는 신고, 보고, 신청, 진술, 청구에 관한 서류작성 등 노무사의 업무를 지원한다.","doWork":"고객의 요구를 파악하고 적절한 업무수행을 위해 노무와 관련하여 고객과 상담한다. 노무 관련 법조문이나 판례를 검색하고 조사한다. 노무대상자를 면담하고 관련 자료를 수집한다. 노사를 대리하여 신고에 필요한 각종 서류를 작성하고 변경하며 신고한다. 사업 또는 사업자의 인사, 노무, 노사관계 등을 분석하고 이를 토대로 개선방안을 수립한다. 산재 등 노무 관련 사항에 대해 노사를 대상으로 교육한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"노무관리사무원","connectJob":"노무사사무장","dJobECd":"0262","dJobECdNm":"[0262]인사·교육·훈련 사무원","dJobJCd":"3122","dJobJCdNm":"[3122]인사 및 교육·훈련 사무원","dJobICd":"ALL","dJobICdNm":"[ALL]전체","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006585:1', '{"dJobCd":"K000006585","dJobCdSeq":"1","dJobNm":"마권투표관리원","workSum":"경마, 경륜, 경정 등 경기장의 발매소에서 마권 또는 경주권을 발매하는 투표종사원들의 활동을 감독·조정한다.","doWork":"마권 또는 경주권의 발매 및 배당금 환급업무를 수행하는 투표종사원의 활동을 감독하고 지시한다. 투표종사원을 교육하고 투표소에 배치시킨다. 발권기계의 수치와 판매금액의 시제가 일치하는지 확인한다. 매표기 및 기타 설비를 유지·관리한다. 고객의 불만사항을 처리하고 문제를 해결한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"감독","workFunc3":"관련없음","similarNm":"투표위원","dJobECd":"0262","dJobECdNm":"[0262]인사·교육·훈련 사무원","dJobJCd":"3122","dJobJCdNm":"[3122]인사 및 교육·훈련 사무원","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003735:1', '{"dJobCd":"K000003735","dJobCdSeq":"1","dJobNm":"인사사무원","workSum":"인적자원의 채용, 교육, 평가, 보상, 입·퇴사 등 인사관리를 한다.","doWork":"필요한 인력에 대해 채용공고를 내고, 면접전형을 진행한다. 채용이 확정되면 근로조건을 협의하고 현업부서에 배치한다. 효율적인 인적자원관리를 위해 직무조사, 직무분석 등을 수행한다. 인사평가 대상을 확정·시행하여 개인별 예정등급을 인사위원회에 상정한다. 조직개편, 전보 등 인사위원회의 결정사항을 정리하고 결재를 받아 공고 및 시행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"인사관리사무원","connectJob":"복리후생사무원","dJobECd":"0262","dJobECdNm":"[0262]인사·교육·훈련 사무원","dJobJCd":"3122","dJobJCdNm":"[3122]인사 및 교육·훈련 사무원","dJobICd":"ALL","dJobICdNm":"[ALL]전체","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001226:1', '{"dJobCd":"K000001226","dJobCdSeq":"1","dJobNm":"조직문화매니저","workSum":"구성원의 조직문화를 이해하고 업무에 몰입할 수 있도록 기업의 조직문화의 현상을 진단분석하고 조직문화 개선활동 프로그램을 기획하고 운영한다.","doWork":"진단분석 도구를 활용하고 구성원의 의견을 반영하여 기업의 조직문화의 현상을 진단분석한다. 진단 결과를 토대로 조직문화 개선 방안을 마련한다. 핵심가치 및 비전, 일하는 방식 등을 내재화하고 조직문화 개선활동 프로그램을 개발, 기획, 운영 및 평가한다. 조직문화 지표를 개발개선하며 관리한다. 사내외 조직문화 활동을 지원한다. 신규직원이 빠르게 조직문화에 적응하도록 돕는 온보딩과 관련한 업무를 한다. 조직 내 변화관리자(Change Agent)를 양성하고 관리한다. 조직문화 개선(Intervention)을 위한 구체 활동을 설계하고 실행한다. 조직변화 워크숍에서 퍼실리테이터(Facilitator)로서 구성원 간의 소통을 촉진반영정리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"조직개발담당자, 조직문화담당자","dJobECd":"0262","dJobECdNm":"[0262]인사·교육·훈련 사무원","dJobJCd":"3122","dJobJCdNm":"[3122]인사 및 교육·훈련 사무원","dJobICd":"ALL","dJobICdNm":"[ALL]전체","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007290:1', '{"dJobCd":"K000007290","dJobCdSeq":"1","dJobNm":"증권교육담당원","workSum":"증권 및 선물옵션시장과 관련한 교육자료를 마련하고 교육을 실시한다.","doWork":"증권 관련 기관의 임직원, 투자자 등 교육대상별로 별도의 강의안 및 교재를 작성한다. 증권 관련 기관의 임직원, 기관투자자를 대상으로 새로운 업무기법이나 투자기법, 신상품 등에 대한 교육을 실시한다. 일반투자자들을 대상으로 주로 주식, 채권, 파생상품이나 관련 시장의 이해를 돕기 위한 교육이나 거래를 위한 전산시스템 이용법 등 다양한 교육을 실시한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"조정","workFunc2":"교육","workFunc3":"관련없음","dJobECd":"0262","dJobECdNm":"[0262]인사·교육·훈련 사무원","dJobJCd":"3122","dJobJCdNm":"[3122]인사 및 교육·훈련 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003786:1', '{"dJobCd":"K000003786","dJobCdSeq":"1","dJobNm":"캐디관리원","workSum":"골프장 캐디의 근무시간을 조정해 배치하고 관리 및 감독한다.","doWork":"골프장 예약현황을 참고하여 골프장을 이용하는 고객에게 순번제로 캐디를 배치한다. 캐디의 근무수칙을 확립하고 캐디의 출근, 근무태도, 복장 등을 점검한다. 캐디를 대상으로 고객에 대한 서비스 및 예절에 관해 교육한다. 캐디와 고객과의 문제발생 시 해결책을 모색한다. 고객의 명부와 고객 수에 따라 캐디의 일급 또는 주급을 지급하기도 한다. 골프경기진행을 돕기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"감독","workFunc3":"관련없음","similarNm":"캐디마스터","dJobECd":"0262","dJobECdNm":"[0262]인사·교육·훈련 사무원","dJobJCd":"3122","dJobJCdNm":"[3122]인사 및 교육·훈련 사무원","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002478:1', '{"dJobCd":"K000002478","dJobCdSeq":"1","dJobNm":"해무감독","workSum":"육상관리직으로 승선하는 선원의 채용, 교육, 훈련, 승선배치 등의 인사 및 행정업무를 수행한다.","doWork":"선원의 채용을 기획한다. 면접을 보고 선원을 채용한다. 선원 교육·훈련프로그램을 기획한다. 선상 안전 등과 관련하여 선원을 교육 및 훈련시킨다. 선원의 승선과 관련한 배치를 한다. 선박의 보험과 관련된 업무를 하기도 한다. 연차검사, SSAS TEST 등의 내외부 수검지원 업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"언어력|시각|","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"선박관리전문가, 해사감독","certLic":"해기사(항해사, 기관사), 선박안전관리사","dJobECd":"0262","dJobECdNm":"[0262]인사·교육·훈련 사무원","dJobJCd":"3122","dJobJCdNm":"[3122]인사 및 교육·훈련 사무원","dJobICd":"H501","dJobICdNm":"[H501]해상 운송업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003379:1', '{"dJobCd":"K000003379","dJobCdSeq":"1","dJobNm":"해외건설인력선발사무원","workSum":"해외사업장이나 건설현장에 필요한 인력수급을 위하여 해외현장 요청에 부합된 인력을 선발한다.","doWork":"각 해외사업장이나 건설현장 등으로부터 인력소요계획서를 접수받고 선발대상인원을 산출한다. 모집인원, 근로조건, 모집자의 사업현황 등 관련 서류를 첨부하여 담당 관공서에 신고한다. 알선된 인원에게 면담 및 선발시험을 통하여 해외취업자를 선발한다. 합격자에게 취업수속에 필요한 서류를 접수받고 출국교육을 통하여 직무 및 해당 국가의 문화, 준비사항 등을 교육시킨다. 선발인력과 근로조건에 따른 제반 문제를 계약한다. 매 분기마다 국외취업근로자의 송출실적을 직업안정기관에 신고한다. 재취업자와 근로계약을 체결하여 선발하기도 하고 하도급업체의 추천에 의해 선발하기도 한다. 해외에서의 현지인 채용과 제3국 인력채용을 관리하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"교육","workFunc3":"관련없음","dJobECd":"0262","dJobECdNm":"[0262]인사·교육·훈련 사무원","dJobJCd":"3122","dJobJCdNm":"[3122]인사 및 교육·훈련 사무원","dJobICd":"N751","dJobICdNm":"[N751]고용알선 및 인력공급업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005056:1', '{"dJobCd":"K000005056","dJobCdSeq":"1","dJobNm":"해외건설인력송출사무원","workSum":"해외현장에서 필요한 기능인력을 송출하기 위하여 비자발급·항공권 발급 등의 업무를 수행한다.","doWork":"비자신청 시 나라별로 필요한 서류를 신청하고 발급받는다. 항공권 예약 시 출장일시, 기간, 출장지역을 파악한 후 항공권을 예약·발급한다. 항공료를 월별로 취합·정산하여 관련 부서로 통보한다. 출장자의 출국 및 귀국일정을 관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"교육","workFunc3":"관련없음","connectJob":"송출에 따른 업무를 전문적으로 담당할 경우 해외인력비자사무원, 해외인력여권사무원, 해외인력항공권사무원","dJobECd":"0262","dJobECdNm":"[0262]인사·교육·훈련 사무원","dJobJCd":"3122","dJobJCdNm":"[3122]인사 및 교육·훈련 사무원","dJobICd":"N751","dJobICdNm":"[N751]고용알선 및 인력공급업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001661:1', '{"dJobCd":"K000001661","dJobCdSeq":"1","dJobNm":"행사도우미관리원","workSum":"각종 행사(전시회, 신제품발표회, 국제회의, 스포츠경기 등)에서 활동하는 행사도우미들을 관리하고 인력투입에 대한 계약을 한다.","doWork":"행사진행에 필요한 도우미를 필요로 하는 업체와 상담한다. 고객의 요구조건(인원, 기간, 외국어 능력 등)에 적합한 인원을 선정하여 행사 내용 및 진행에 대하여 교육시킨다. 비용을 산정하여 고객과 계약한다. 행사가 원활히 진행될 수 있도록 도우미들의 출·퇴근, 업무 등을 관리한다. 행사에 필요한 물품(유니폼, 액세서리 등)을 점검한다. 도우미 명단을 작성·관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","similarNm":"도우미매니저","dJobECd":"0262","dJobECdNm":"[0262]인사·교육·훈련 사무원","dJobJCd":"3122","dJobJCdNm":"[3122]인사 및 교육·훈련 사무원","dJobICd":"N759","dJobICdNm":"[N759]기타 사업지원 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004913:1', '{"dJobCd":"K000004913","dJobCdSeq":"1","dJobNm":"호송경비관리원","workSum":"호송경비업무를 수행하기 위하여 호송경비원에 대한 근태 및 안전 등을 포함하는 총괄 관리를 한다.","doWork":"호송경비 관련 통합 감찰을 한다. 귀중품호송경비원의 복장, 경비장비를 감찰하고 건강상태를 파악한다. 호송차량의 안전상태, 호송금고의 잠금장치의 작동 이상을 확인한다. 일일 순찰을 하며 예방 개선사항을 지시하고 평가를 한다. 평가에 따라 근무개선이 필요한 경우 교육을 지시한다. 귀중품호송경비원의 일일 안전교육을 한다. 호송경비원의 군부대 입소훈련에 관한 계획을 수립한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내·외","workFunc1":"비교","workFunc2":"교육","workFunc3":"관련없음","certLic":"일반경비지도사","dJobECd":"0262","dJobECdNm":"[0262]인사·교육·훈련 사무원","dJobJCd":"3122","dJobJCdNm":"[3122]인사 및 교육·훈련 사무원","dJobICd":"N753","dJobICdNm":"[N753]경비, 경호 및 탐정업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002561:1', '{"dJobCd":"K000002561","dJobCdSeq":"1","dJobNm":"가스도입사무원","workSum":"가스의 안정적 공급을 위한 도입관련 계획을 수립하고 계약을 체결한다.","doWork":"가스수급계획을 수립한다. 가스에 대한 국가별 가격과 물량을 파악한다. 도입가능성을 파악한다. 경제성 검토와 함께 구매방법(경쟁, 수의계약)을 결정한다. 판매자와 접촉하여 협상을 통해 주요조건을 협의하고 확정한다. 가격을 확정 후 정부에 승인을 요청한다. 정부의 승인 후 계약을 체결한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"감독","workFunc3":"관련없음","dJobECd":"0283","dJobECdNm":"[0283]자재·구매·물류 사무원","dJobJCd":"3123","dJobJCdNm":"[3123]자재 관리 사무원","dJobICd":"D352","dJobICdNm":"[D352]연료용 가스 제조 및 배관공급업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006717:1', '{"dJobCd":"K000006717","dJobCdSeq":"1","dJobNm":"가스입출하관리원","workSum":"관로나 해상을 통한 가스의 입하량과 출하량을 확인·관리한다.","doWork":"가스의 입하계획서를 접수한다. 실제 입하된 가스의 양을 확인한다. 관로 및 해상을 통해 출하되는 가스의 양을 기록한다. 출하요청서를 접수한다. 차량으로 출하 시 적재차량과 공차를 측정하여 정확한 출고량을 확인한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내·외","workFunc1":"계산","workFunc2":"말하기신호","workFunc3":"투입인출","dJobECd":"0283","dJobECdNm":"[0283]자재·구매·물류 사무원","dJobJCd":"3123","dJobJCdNm":"[3123]자재 관리 사무원","dJobICd":"D352","dJobICdNm":"[D352]연료용 가스 제조 및 배관공급업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005587:1', '{"dJobCd":"K000005587","dJobCdSeq":"1","dJobNm":"가축수매사무원","workSum":"도축할 소, 돼지 등을 수매하기 위해 시장조사, 수량결정, 수매계약 등의 업무를 한다.","doWork":"도축할 소, 돼지 등을 수매하기 위해 가격 등 시장조사를 한다. 수매할 소, 돼지 등의 수량을 결정한다. 가축농가와 수매계약을 체결한다. 수매입찰서류를 작성한다. 소, 돼지 등을 직접 시장에서 수매한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"농산물수매사무원, 수산물수매사무원, 해양폐기물수매사무원","dJobECd":"0283","dJobECdNm":"[0283]자재·구매·물류 사무원","dJobJCd":"3123","dJobJCdNm":"[3123]자재 관리 사무원","dJobICd":"C101","dJobICdNm":"[C101]도축, 육류 가공 및 저장 처리업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004544:1', '{"dJobCd":"K000004544","dJobCdSeq":"1","dJobNm":"건설자재관리사무원","workSum":"건설공사현장에서 필요한 각종 자재를 효율적으로 지원·공급하기 위하여 소요계획을 수립하고 적정재고량을 유지·관리한다.","doWork":"현장에서 필요한 각종 자재의 내역과 용도를 조사·분석하여 연간·월간·주간·일일 소요계획을 수립한다. 각 부서로부터 자재청구서 또는 자재지원의뢰서를 접수받고 소비량을 검토한다. 자재가 효율적으로 이용될수 있도록 정기적으로 재고조사를 하여 수량 및 관리상태 등의 현황을 파악하고 재물조사일람표를 작성한다. 잉여자재는 현장 간 전용을 유도하고, 경제성이 없는 자재는 폐기 및 매각을 통하여 적정 재고량을 유지한다. 필요자재의 재고가 없을 시 자재구매사무원에게 구매의뢰서를 접수한다. 현장자재관리자가 원활히 업무를 수행할 수 있도록 교육을 실시하고, 업무수행상 애로점을 해결한다. 각 현장의 사양에 맞추어 적시에 적정량이 공급되도록 제반 사항을 관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"관련없음","dJobECd":"0283","dJobECdNm":"[0283]자재·구매·물류 사무원","dJobJCd":"3123","dJobJCdNm":"[3123]자재 관리 사무원","dJobICd":"F411/F412/F421","dJobICdNm":"[F411]건물 건설업 / [F412]토목 건설업 / [F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001947:1', '{"dJobCd":"K000001947","dJobCdSeq":"1","dJobNm":"건설장비관리사무원","workSum":"건설공사에 사용되는 중장비, 차량, 기기류 등 장비의 등록, 검사, 보험, 임대차업무를 수행한다.","doWork":"신규 구입장비 및 해외 전입장비를 관할관청에 제증빙서류 및 등록신청서를 작성하여 등록신청한다. 장비소재지 해당 검사소에 신규 검사신청하여 검사일자 협의 후 수검한다. 검사결과를 관할관청에 통보하고, 이상이 없을 시 번호판과 등록증을 수령하여 보관·유지한다. 운영장비의 정기검사, 구조변경검사, 수시검사를 신청·수검하고 등록증에 확인을 받는다. 차량책임보험, 차량종합보험, 건설기계종합보험, 선박보험 등 해당 보험에 가입하며, 가입 후 보험료 납부 및 보험기간의 현황을 유지·관리한다. 유휴장비 및 현장가동계획이 없는 장비는 임차업체와 사용료, 사용기간, 수리비, 운반비 등 계약조건을 협의 후 임대차계약을 체결하고, 장비를 이동·투입한다. 임대차 계약내용에 따라 장비사용료를 산정하고, 세금계산서를 발행한다. 결재일이 도래하면 임대사용료를 수금한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"협의","workFunc3":"관련없음","connectJob":"중장비의 대여에 따른 계약 및 사용료 부과 업무만을 전담하는 경우 중장비대여사무원","dJobECd":"0283","dJobECdNm":"[0283]자재·구매·물류 사무원","dJobJCd":"3123","dJobJCdNm":"[3123]자재 관리 사무원","dJobICd":"F426","dJobICdNm":"[F426]건설장비 운영업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005464:1', '{"dJobCd":"K000005464","dJobCdSeq":"1","dJobNm":"건설장비운영사무원","workSum":"건설중장비, 차량, 중기류 등의 건설용 기계와 장비를 사용·관리하기 위하여 공사현장 간 또는 국내외 간의 중기전용계획을 수립·추진한다.","doWork":"각 현장의 장비소요계획을 접수·분석하여 장비소요계획 및 운영계획을 수립한다. 국내외에서 진행 중인 공사의 완공시기와 가동 중인 장비의 종류, 수량, 가동상태 등을 현장별로 파악하여 컴퓨터에 입력시킨다. 현장소요시기에 장비요청을 받아 전용, 임차 및 구입여부를 검토한다. 장비구입에 따른 구입품의서를 작성하고 관련 부서에 구입을 의뢰한다. 수리비 과투자 예상장비, 비경제성 및 불용장비는 원매자 물색·계약한 후 장비매각품의서를 작성하여 장비를 출고한다. 장비의 현장투입 및 철수 시 이동절차, 방법, 시기를 현장담당자와 협의하여 결정한다. 해외공사부서와 협의하여 장비를 전·출입한다. 장비의 구입, 매각 및 해외 전·출입현황을 작성·유지한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0283","dJobECdNm":"[0283]자재·구매·물류 사무원","dJobJCd":"3123","dJobJCdNm":"[3123]자재 관리 사무원","dJobICd":"F426","dJobICdNm":"[F426]건설장비 운영업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003285:1', '{"dJobCd":"K000003285","dJobCdSeq":"1","dJobNm":"계근원","workSum":"제품생산에 필요한 목재 칩, 폐지, 고지 등의 원·부자재가 입고되면 화물의 중량, 종류, 용적 등을 계산·증명한다.","doWork":"원·부자재를 실은 화물차량이 들어오면 계근기에 차량을 정위치시킨다. 적재한 화물과 차량의 중량을 측정하고 화물의 규격, 중량, 장소, 일시, 상표, 의뢰인 및 수행자 등의 내용을 기록하여 전표를 발행한다. 화물을 창고 및 저장소 등의 적재장소에 하역하고 돌아오는 빈 화물차량의 무게를 계근하여 발행한 전표에 기록한다. 작업내용을 작업일지에 기록한다. 계근기에 이상이 발생하면, 수리관련 부서에 보수를 의뢰한다. 무인자동계근대의 경우에는 계근, 입출고기록, 전표발행 및 작업일지기록이 자동으로 이루어지기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"계산","workFunc2":"관련없음","workFunc3":"관련없음","dJobECd":"0283","dJobECdNm":"[0283]자재·구매·물류 사무원","dJobJCd":"3123","dJobJCdNm":"[3123]자재 관리 사무원","dJobICd":"C171","dJobICdNm":"[C171]펄프, 종이 및 판지 제조업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001269:1', '{"dJobCd":"K000001269","dJobCdSeq":"1","dJobNm":"곡물창고관리원","workSum":"저장창고로 입고되는 맥아, 백미, 보리 등 곡물을 분류하고 재고량을 점검한다.","doWork":"입고된 곡물의 등급을 분류하고 작업일지에 기록한다. 곡물포장용기에 표기된 곡물의 생산지, 품종, 등급에 따라 저장창고에 운반하도록 작업원들을 지시한다. 저장상태를 점검하고 출고되는 곡물의 수량을 확인한다. 저장창고에 저장된 곡물의 수량을 수시로 점검하고 부족한 곡물의 수량을 계산한다. 저장된 곡물이 서로 엉겨붙지 않도록 정해진 기준에 따라 팬(Fan)을 가동시켜 공기순환을 시켜주기도 한다. 컨베이어(Conveyor) 및 승강기(Elevator) 등 관련 이송설비를 점검하여 작동상태가 불량할 경우 설비팀에 의뢰하여 수리하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","dJobECd":"0283","dJobECdNm":"[0283]자재·구매·물류 사무원","dJobJCd":"3123","dJobJCdNm":"[3123]자재 관리 사무원","dJobICd":"C106","dJobICdNm":"[C106]곡물가공품, 전분 및 전분제품 제조업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006549:1', '{"dJobCd":"K000006549","dJobCdSeq":"1","dJobNm":"광물출하원","workSum":"각 광업소에서 채광, 채탄 및 채취한 광석, 석탄, 모래, 골재, 석재 등의 생산량을 집계하여 출하계획을 세우고, 출하할 광물의 용적, 중량, 수량을 계산·증명한다.","doWork":"광업소의 생산량을 확인하고 생산일지를 작성한다. 생산량에 대한 구매업체를 파악하고 지역별·업체별 출하계획을 세운다. 출하계획에 따라 출하량을 배정한다. 열차, 트럭, 배 등의 수송수단 및 수송로에 따라 배차, 출발시간, 선적, 1회 수송량 등을 결정한다. 선적을 지시·확인한다. 출하광물의 용적, 중량, 수량을 계산하고 출하일지에 기록한다. 출하에 따른 제반 서류를 구매업체에 송부한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"단순작업","connectJob":"출하하는 광물의 종류에 따라 골재출하원, 광석출하원, 모래출하원, 석재출하원, 석탄출하원, 물류출하원, 창고출하원","dJobECd":"0283","dJobECdNm":"[0283]자재·구매·물류 사무원","dJobJCd":"3123","dJobJCdNm":"[3123]자재 관리 사무원","dJobICd":"B051/B061/B062","dJobICdNm":"[B051]석탄 광업 / [B061]철 광업 / [B062]비철금속 광업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004250:1', '{"dJobCd":"K000004250","dJobCdSeq":"1","dJobNm":"광산자재관리사무원","workSum":"광산 내에서 필요한 각종 자재 및 광산장비 부품의 입고, 보관, 불출 등과 같은 창고관리업무를 수행한다.","doWork":"구입되거나 현장에서 반납되어온 자재를 창고에 입고시키기 위하여 증빙서류를 확인하고 물품의 상태 및 수량을 검수한다. 자재기록일지에 입고된 자재의 명세를 기록하고 물품에 따라 창고 내의 적재위치를 선정한다. 각 부서로부터 자재청구서를 접수받고 광산자재창고종사원에게 불출을 지시한다. 정기적으로 자재를 점검하고 자재기록일지와 대조한다. 창고주위를 순찰한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"광업자재구매사무원","dJobECd":"0283","dJobECdNm":"[0283]자재·구매·물류 사무원","dJobJCd":"3123","dJobJCdNm":"[3123]자재 관리 사무원","dJobICd":"B051/B061/B062","dJobICdNm":"[B051]석탄 광업 / [B061]철 광업 / [B062]비철금속 광업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002989:1', '{"dJobCd":"K000002989","dJobCdSeq":"1","dJobNm":"기내식공급계획사무원","workSum":"항공기에 탑승하는 승객에게 서비스되는 기내식의 메뉴를 선정·계획한다.","doWork":"운항계획을 접수하여 운항소요시간, 승객분포, 항공노선 등을 분석한다. 탑승객의 국적을 검토하여 기내식의 메뉴를 선정하고 가격 및 재료명세표를 확인한다. 기내식의 조견표를 작성하여 객실승무원에게 인계하고 기내식에 대한 의견을 청취한다. 전문서적을 참조하고 각종 요리전시회 및 전문음식점을 견학하여 메뉴의 선정을 검토한다. 조리한 기내식을 시식하여 평가하기도 하며 제조방법이나 영양상태를 검토하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"계산","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0283","dJobECdNm":"[0283]자재·구매·물류 사무원","dJobJCd":"3123","dJobJCdNm":"[3123]자재 관리 사무원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002279:1', '{"dJobCd":"K000002279","dJobCdSeq":"1","dJobNm":"기내용품관리원","workSum":"기내의 서비스에 필요한 각종 기내용품 및 기내식의 탑재량을 산정하고 탑재명세서를 작성한다.","doWork":"항공기의 운항계획을 검토하여 출발시간, 도착시간, 운송소요시간, 기종, 항로 등을 파악하고 변동사항을 점검한다. 승객 수, 항로거리, 기내공간을 파악하여 각종 용품의 탑재량을 산정한다. 기내용품의 무게를 산출하고 운반용기(Carry Box) 내 용품의 위치와 수량을 결정한다. 항공기의 중량 및 균형을 고려하여 운반용기의 기내 탑재위치를 결정한다. 탑재물품의 수량 및 위치를 정리한 자료를 객실보급반장에게 설명하고 탑재를 지시한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"계산","workFunc2":"감독","workFunc3":"관련없음","dJobECd":"0283","dJobECdNm":"[0283]자재·구매·물류 사무원","dJobJCd":"3123","dJobJCdNm":"[3123]자재 관리 사무원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002384:1', '{"dJobCd":"K000002384","dJobCdSeq":"1","dJobNm":"기내용품탑재관리원","workSum":"항공기에서 사용될 기내용품을 주문받고 재고를 관리한다.","doWork":"모포, 베개, 헤드폰, 기내지 등 요청된 기내용품의 주문량을 파악한다. 항공기의 종류 및 탑재할 용품의 목록별 수량을 검토하여 재고를 파악한다. 운송을 지시하고, 탑재작업을 확인한다. 재고부족 시 관련 업체에 주문한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","dJobECd":"0283","dJobECdNm":"[0283]자재·구매·물류 사무원","dJobJCd":"3123","dJobJCdNm":"[3123]자재 관리 사무원","dJobICd":"H511/H512","dJobICdNm":"[H511]항공 여객 운송업 / [H512]항공 화물 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002051:1', '{"dJobCd":"K000002051","dJobCdSeq":"1","dJobNm":"냉동창고관리원","workSum":"수산물, 육류 및 기타 상온에서 부패될 수 있는 물품을 저장·보관하기 위하여 냉동설비가 장치된 창고를 관리한다.","doWork":"창고에 반입되는 물품을 분류하여 수량 및 종류를 확인하고 반입서류를 작성한다. 입고한 물품의 종류에 따라 냉동창고의 저장온도를 조절하기 위하여 온도계를 확인하고 냉동스위치를 조작한다. 수시로 가스압력계와 온도계를 점검하여 일지에 기록하고 이상현상이 발생될 경우에는 냉동설비를 유지·관리하는 작업원에게 연락한다. 출고되는 물품의 종류 및 수량을 확인하고 반출서류를 점검한다. 창고에 저장된 물품을 점검하여 변질물품의 수량 및 종류를 파악한다. 보관물품의 품명, 수량 및 입고일이 기록된 명세표(푯말)를 물품의 상단 또는 창고의 입구에 부착한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"저온|다습|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"유지","dJobECd":"0283","dJobECdNm":"[0283]자재·구매·물류 사무원","dJobJCd":"3123","dJobJCdNm":"[3123]자재 관리 사무원","dJobICd":"H521","dJobICdNm":"[H521]보관 및 창고업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006312:1', '{"dJobCd":"K000006312","dJobCdSeq":"1","dJobNm":"냉동컨테이너관리원","workSum":"냉동컨테이너 화물이 지정된 온도로 유지될 수 있도록 관리한다.","doWork":"컨테이너 장치장 및 장치재고를 파악한다. 냉동컨테이너 작업량을 확인하여 화물의 상하차작업을 지시한다. 전원공급케이블의 적출작업 및 전원차단을 통해 지정된 온도의 냉동상태를 확인·기록한다. 냉동컨테이너 모니터링청구서를 작성하고, 냉동스탠드를 유지·보수하고 관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"수동조작","certLic":"공조냉동기계기능사","dJobECd":"0283","dJobECdNm":"[0283]자재·구매·물류 사무원","dJobJCd":"3123","dJobJCdNm":"[3123]자재 관리 사무원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003978:1', '{"dJobCd":"K000003978","dJobCdSeq":"1","dJobNm":"레미콘출하사무원","workSum":"콘크리트제조공장에서 제조된 콘크리트제품을 공급지에 출하하기 위하여 레미콘트럭을 배차한다.","doWork":"영업부로부터 익일 물량에 대한 주문서를 받는다. 받은 주문서에 따라 현장에 요구되는 총 물량, 각 공급지의 거리·시간 등을 계산하여 공급지에 공급되도록 물량공급계획을 수립한다. 수립된 계획에 따라 콘크리트제조반장에게 물량요구서를 제출한다. 운전원의 불이익이 없는 공평한 배차가 되도록 레미콘트럭의 배차계획과 간격을 정하여 인원을 배치한다. 레미콘차량운전원에게 공급지를 알려주고 주문송장을 발부한다. 레미콘을 공급후회차하여 받아온 인수장을 보관·처리한다. 레미콘차량운전원의 인원관리, 사고처리 및 차량관리 등을 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"관련없음","workFunc3":"관련없음","dJobECd":"0283","dJobECdNm":"[0283]자재·구매·물류 사무원","dJobJCd":"3123","dJobJCdNm":"[3123]자재 관리 사무원","dJobICd":"C233","dJobICdNm":"[C233]시멘트, 석회, 플라스터 및 그 제품 제조업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003243:1', '{"dJobCd":"K000003243","dJobCdSeq":"1","dJobNm":"목재칩검수원","workSum":"펄프의 원료인 목재 칩이 규정된 기준과 일치하는지 확인·검사하는 일을 한다.","doWork":"목재 칩에 대한 규격품의서를 확인한다. 계근된 목재 칩 중에서 무작위로 표본을 채집한다. 표본에 포함된 이물질의 삽입여부, 규격을 육안 검사하여 이상 여부를 확인한다. 규격에 합격한 제품은 다음 공정으로 보내고, 특별히 분석을 요하는 제품은 목재칩분석원에게 정밀분석을 의뢰한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","certLic":"펄프제지기능사","dJobECd":"0283","dJobECdNm":"[0283]자재·구매·물류 사무원","dJobJCd":"3123","dJobJCdNm":"[3123]자재 관리 사무원","dJobICd":"C171","dJobICdNm":"[C171]펄프, 종이 및 판지 제조업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002383:1', '{"dJobCd":"K000002383","dJobCdSeq":"1","dJobNm":"물류관리사무원","workSum":"입고된 상품을 검수하고, 적정 재고상태를 유지하여 상품의 입출고가 정상적으로 이루어지도록 관리한다.","doWork":"상품이 입고될 때 발주서와 거래명세표를 입고물품과 대조하여 수량이나 불량상태 등을 검수한다. 반품되어 들어온 상품의 상태와 요구내역을 확인한 후 입고한다. 출고 지시된 상품은 송장처리를 완료하고 출고한다. 상품을 반출할 경우, 반출명세표의 상품량, 수량, 옵션 등을 확인하고 처리한다. 물류센터 및 창고 내의 적정재고 유지를 위해 상품의 수급을 수시로 확인하고, 상품별 재고수준을 파악한다. 물류시스템을 운영하기 위한 장치 및 기기를 정상적으로 운영한다. 배송과 관련된 각종 소모성 자재를 도입하고 관리한다. 물류센터운영요원을 대상으로 입출고, 배송 관련 작업지식과 안전사항을 교육한다. 물류센터의 안전시설물이 정상으로 작동하는지 수시로 확인하여 재해로 인한 인적·물적 손실을 사전에 방지한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"물류사무원, 유통사무원","connectJob":"물류관리전문가","certLic":"물류관리사, 유통관리사","dJobECd":"0283","dJobECdNm":"[0283]자재·구매·물류 사무원","dJobJCd":"3123","dJobJCdNm":"[3123]자재 관리 사무원","dJobICd":"H521","dJobICdNm":"[H521]보관 및 창고업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001733:1', '{"dJobCd":"K000001733","dJobCdSeq":"1","dJobNm":"반도체장비구매관리자","workSum":"반도체 장비를 개발 또는 생산하기 위해 필요한 소재, 부품, 장치 제조업체 평가·선정, 구매발주, 납기관리, 재고관리 등의 업무를 수행한다.","doWork":"반도체 장비 관련 소재, 부품, 장치 제조업체의 평가·선정은 구매물품에 요구되는 소요량 및 납기를 산정한 후, 제조업체의 인력, 품질, 생산능력, 가격, 납기, 재무상태 등 제반 역량을 분석하여 최적의 제조업체를 선정한다. 구매발주물품에 대한 전체 과정을 도표를 활용하여 일정계획을 수립, 관리하며, 구매물품에 대한 사양 및 평가항목을 파악하여 제조업체와 제작과정에 대해 협의한다. 물품납기 및 품질 문제발생 시 설계연구원, 기구·전장조립기술자와 상담을 통해 해당 프로젝트 일정에 반영한다. 장비생산에 필요한 적정재고를 산정하고 관리하며, 물품납기에 필요한 제조업체의 생산관리현황을 세밀하게 파악하고, 재고관리프로그램 운영을 통해 재고유지비용을 고려하여 안전재고를 관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"반도체구매관리자","dJobECd":"0283","dJobECdNm":"[0283]자재·구매·물류 사무원","dJobJCd":"3123","dJobJCdNm":"[3123]자재 관리 사무원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006869:1', '{"dJobCd":"K000006869","dJobCdSeq":"1","dJobNm":"반도체재료구매관리기술자","workSum":"반도체 재료의 개발 또는 생산을 위해 필요한 소재, 부품, 장치 제조업체 평가·선정, 구매발주, 납기관리, 재고관리 등의 업무를 수행한다.","doWork":"반도체 소재, 부품, 장치 제조업체 대상으로 구매물품에 요구되는 소요량 및 납기를 산정한다. 소재, 부품, 장치 제조업체의 인력, 품질, 생산능력, 가격, 납기, 재무상태 등 제반 역량을 분석하여 최적의 제조업체를 선정한다. 구매발주물품에 대한 전체 과정을 도표를 활용하여 일정계획을 수립, 관리하며, 구매물품에 대한 사양 및 평가항목을 파악하여 제조업체와 제작과정에 대해 협의하고, 물품납기 및 품질 문제발생 시 소재개발 및 공정평가연구원과 상담을 통해 해당 프로젝트 일정에 반영한다. 재료생산에 필요한 적정재고를 산정하고 관리하며, 물품 납기에 필요한 제조업체의 생산관리현황을 세밀하게 파악하고, 재고관리프로그램 운영을 통해 재고유지비용을 고려하여 안전재고를 관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"손사용|언어력|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"반도체 재료기술자","dJobECd":"0283","dJobECdNm":"[0283]자재·구매·물류 사무원","dJobJCd":"3123","dJobJCdNm":"[3123]자재 관리 사무원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005935:1', '{"dJobCd":"K000005935","dJobCdSeq":"1","dJobNm":"발전연료관리원","workSum":"전력을 생산하기 위하여 사용하는 석탄, 천연가스, 발전유, 우라늄 등의 발전연료의 구입, 수송, 배급, 품질관리 등의 업무를 수행한다.","doWork":"발전소별 또는 발전연료별로 연간 연료사용량을 파악한다. 연간 발전예정 전력량에 따른 구입연료량을 산출한다. 연료수급계획을 세우고 연료구입에 따른 예산을 편성하여 관계부서와 협의한다. 연료구입절차에 맞추어 수송계획을 세운다. 구입연료의 품질을 연료분석원에게 의뢰하여 분석하고 분석결과를 계약조건과 비교하여 판정한다. 발전연료첨가제와 보조연료의 구매관리업무를 수행한다. 수시로 연료탱크를 점검하여 재고량을 파악한다. 원자력발전계획에 따른 핵연료의 소요량산정, 핵연료의 확보 및 구매계약의 체결, 핵주기비의 분석평가, 핵연료의 구산화 지원 등의 업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"핵연료를 관리하는 경우 핵연료관리원","dJobECd":"0283","dJobECdNm":"[0283]자재·구매·물류 사무원","dJobJCd":"3123","dJobJCdNm":"[3123]자재 관리 사무원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001417:1', '{"dJobCd":"K000001417","dJobCdSeq":"1","dJobNm":"방송기자재배정원","workSum":"라디오와 텔레비전 방송의 프로그램 제작을 위해 방송기자재를 배정 및 조정한다.","doWork":"방송일정, 방송규모, 프로그램 편성현황에 따라 방송제작에 필요한 기자재운용계획을 수립한다. 스포츠중계, 현장중계, 스튜디오, 녹화방송, 생방송 등에 적합한 카메라, 중계차, 스튜디오, 각종 기자재의 사용일정을 확인하고 배정한다. 파손된 방송기자재의 수량과 상태를 확인하고 방송기기정비원에게 수리를 의뢰하거나 신규 기자재의 도입을 검토한다. 검토의견을 정리하여 보고서를 작성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0283","dJobECdNm":"[0283]자재·구매·물류 사무원","dJobJCd":"3123","dJobJCdNm":"[3123]자재 관리 사무원","dJobICd":"J602","dJobICdNm":"[J602]텔레비전 방송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004637:1', '{"dJobCd":"K000004637","dJobCdSeq":"1","dJobNm":"본선컨테이너관리원","workSum":"본선작업(선박을 접안시킨 상태에서 선박으로부터 직접 화물을 내리거나, 선박에 싣는 작업)을 위한 컨테이너의 관리를 한다.","doWork":"모선별 작업내용을 검토하고 운영계획원으로부터 각종 본선적부도(Stowage Plan:본선의 선창에 화물이 적재된 상태를 나타낸 도면)와 작업지시서 등 양하서류를 접수하고 서류의 내용을 검토하고 복사하여 배부한다. 작업서류 내용과 실작업 컨테이너 수를 확인한다. 화물의 본선 위치변경, 규격 등 작업내용이 상이한 사항을 정정한다. 양적하된 컨테이너 수, 규격, 내용을 점검하고 위치를 전산으로 입력한다. 추가 또는 선적취소를 전산처리한다. 작업상황보고서 및 컨테이너 리스트를 작성한다. 선사와 작업변경 및 선박스케줄 변경 등 필요사항을 협의한다. 작업종료 후 선박화물양적하작업사무원이 제출하는 서류 및 작업수량의 내용을 확인하고 작업현황보고서를 작성한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"관련없음","dJobECd":"0283","dJobECdNm":"[0283]자재·구매·물류 사무원","dJobJCd":"3123","dJobJCdNm":"[3123]자재 관리 사무원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004251:1', '{"dJobCd":"K000004251","dJobCdSeq":"1","dJobNm":"부두장비관리사무원","workSum":"컨테이너터미널 및 일반부두의 하역작업에 필요한 각종 장비에 관한 정비 및 인원관리를 한다.","doWork":"컨테이너크레인, 트랜스퍼크레인, 스트래들케리어 야드트랙터, 엠프티핸들러, 리치스태커 기중기 등의 장비를 일일 점검하고 상태를 확인한다. 장비들의 예방정비를 실시한다. 고장장비를 접수받아 정비사에게 정비를 지시하고 외부회사에 의뢰한다. 교체품과 예비품을 구매한다. 장비기사의 안전사용을 감독한다. 장비기사와 정비사의 근태를 관리하고 보고한다. 안전사고 시 사고보고서를 작성하여 보고한다. 일일가동 장비현황을 파악하여 보고한다. 연료사용 등의 현황을 파악하고 보고한다. 장비기사와 정비사의 이력사항을 유지하고 적절한 배치에 관여한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"기록","workFunc2":"감독","workFunc3":"관련없음","dJobECd":"0283","dJobECdNm":"[0283]자재·구매·물류 사무원","dJobJCd":"3123","dJobJCdNm":"[3123]자재 관리 사무원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007054:1', '{"dJobCd":"K000007054","dJobCdSeq":"1","dJobNm":"석유화학물류지원기술자","workSum":"물류의 이동, 보관, 선적 등에 드는 시간과 비용의 분석을 통해 합리적인 적정재고, 출하, 운송 등을 계획하고 관리한다.","doWork":"물류의 통관·검정·하역업무를 지원하고 재고 오차와 계량설비를 점검한다. 실시간 재고량의 파악과 적정재고를 관리하기 위해 입·출하에 따른 재고량을 추정하고, 보관시설 운용 계획과 보관시설 상태를 점검하고 기록한다. 제품별·거래처별 운송방법을 파악하고 운송업체와 운송방법을 결정한다. 반품 제품 확인 후 부적합 내역을 작성하고 적합한 반품처리방법을 검토하고 반품을 처리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0283","dJobECdNm":"[0283]자재·구매·물류 사무원","dJobJCd":"3123","dJobJCdNm":"[3123]자재 관리 사무원","dJobICd":"C201","dJobICdNm":"[C201]기초 화학물질 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007048:1', '{"dJobCd":"K000007048","dJobCdSeq":"1","dJobNm":"석유화학재고관리원","workSum":"효율적인 물적유통을 위해 보관시설 등을 활용하여 원부재료 및 제품의 입고, 저장, 출고 및 반품 처리와 관련된 현장 업무를 수행한다.","doWork":"품질규격, 입고·출고 물량을 파악하고 시험성적서 확인을 통해 부적합 여부 및 검사결과를 통보한다. 제품의 종류·물량을 확인하고 보관시설의 저장 공간을 결정하며, 보관시설 운전변수 조절 및 입고방법과 출고방법을 결정한다. 출하제품을 계량, 원부재료별 보관조건, 보관시설 현황과 최대·최저 재고 용량을 파악한다. 출하 후 설비 상태를 점검하고 출하시설 내 운전업무를 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"0283","dJobECdNm":"[0283]자재·구매·물류 사무원","dJobJCd":"3123","dJobJCdNm":"[3123]자재 관리 사무원","dJobICd":"C201","dJobICdNm":"[C201]기초 화학물질 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005107:1', '{"dJobCd":"K000005107","dJobCdSeq":"1","dJobNm":"선박화물양적하작업관리자","workSum":"화물의 본선작업 상황에 맞게 컨테이너 선적 및 하역계획을 수립하고 관련 종사자들의 작업을 조정·감독한다.","doWork":"화물의 양적하 서류내용을 검토하고 컨테이너화물 및 각종 특수화물에 대한 작업계획을 수립한다. 사고예방을 위하여 선박화물양적하작업사무원 및 장비조작원에 대한 안전사항을 확인·교육한다. 해당 모선의 작업상태를 파악하고 본선선체 및 각종 선상설비, 특수화물의 손상여부를 확인한다. 본선작업 설정에 맞도록 인원을 배치하여 작업을 진행·통제하고 관련 종사자들의 작업을 총괄 지휘한다. 작업 중에 발생하는 사고에 대하여 조치를 취한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실외","workEnv":"위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","similarNm":"포맨","dJobECd":"0283","dJobECdNm":"[0283]자재·구매·물류 사무원","dJobJCd":"3123","dJobJCdNm":"[3123]자재 관리 사무원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005369:1', '{"dJobCd":"K000005369","dJobCdSeq":"1","dJobNm":"선박화물양적하작업사무원","workSum":"선박화물양적하작업관리자의 지시에 따라 컨테이너 화물의 양적하작업을 지휘한다.","doWork":"본선 작업내용을 검토·확인한 후 작업장의 안전사항을 점검한다. 화물을 일반화물, 특수화물을 분류하여 양적하하도록 장비조작원들에게 작업을 지시한다. 손상된 화물은 조치를 취한 후 작업을 진행한다. 해당 장비조작원 및 터미널상황실통제원과 무선으로 연락을 취하며 작업상황을 주고받으며 작업한다. 선박화물양적하작업관리자에게 작업상황에 대해 보고하고, 작업 종료 후 작업내용을 확인하고 작업일지를 작성한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","similarNm":"언더맨","dJobECd":"0283","dJobECdNm":"[0283]자재·구매·물류 사무원","dJobJCd":"3123","dJobJCdNm":"[3123]자재 관리 사무원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001888:1', '{"dJobCd":"K000001888","dJobCdSeq":"1","dJobNm":"소품관리원","workSum":"연극, 영화, 텔레비전 프로그램 등의 제작이나 유원지, 오락시설의 행사를 실시하는 데 사용되는 소품을 관리한다.","doWork":"소품실에서 보유하고 있는 의상, 가구, 도구 등 소품의 목록을 정리하고 보관위치를 확인한다. 소품의 반출요구서를 확인하고 필요한 소품을 반출한다. 반입되는 소품을 확인하여 파손상태를 점검하고 일지에 기록한다. 신규 제작된 소품목록을 정리하여 컴퓨터에 입력하고 소품에 소품번호를 부여한다. 구입 또는 제작하려는 소품목록을 정리하여 구매요구서를 작성한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"단순작업","similarNm":"소품도구관리원","dJobECd":"0283","dJobECdNm":"[0283]자재·구매·물류 사무원","dJobJCd":"3123","dJobJCdNm":"[3123]자재 관리 사무원","dJobICd":"J602/R901","dJobICdNm":"[J602]텔레비전 방송업 / [R901]창작 및 예술관련 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003628:1', '{"dJobCd":"K000003628","dJobCdSeq":"1","dJobNm":"수도계량기관리원","workSum":"수도계량기의 관리계획을 수립하고 계량기의 관리실태를 점검하고 지도한다.","doWork":"수도계량기의 관리, 점검, 교체계획을 수립하고 조정한다. 자체 및 수용가의 수도계량기 현황을 파악하여 관리한다. 계량기를 교체하거나 정비하기 위하여 계량기의 이력을 기록하고 유지·관리한다. 수도계량기를 신설하거나 교체하기 위하여 기술검토를 한다. 계량기의 관리방향에 관한 제도를 검토한다. 계량기의 관리지침서를 개정·보완하기 위한 자료를 검토한다. 개정·보완된 지침서를 사용자에게 인지시킨다. 겨울철 한파에 의한 수도계량기 동파방지계획을 세우고 동파방지 안내 및 조치요령에 대한 홍보, 계량기 보온자재를 배포하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0283","dJobECdNm":"[0283]자재·구매·물류 사무원","dJobJCd":"3123","dJobJCdNm":"[3123]자재 관리 사무원","dJobICd":"E360","dJobICdNm":"[E360]수도업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007108:1', '{"dJobCd":"K000007108","dJobCdSeq":"1","dJobNm":"수입창고관리원","workSum":"수입된 화물을 창고에 반입·보관하고 서류처리한 후 반출 시 화물의 상태 이상 유무를 확인하여 반출한다.","doWork":"구내에 이적된 컨테이너의 위치를 확인하고 세관원 요청 시 샘플채취 및 검사에 입회를 한다. 검사완료된 컨테이너의 반입을 통보한다. 검수작업사무원으로부터 입고화물에 대한 적화목록, 혼재화물 적화목록, 반입지시서를 접수하여 컨테이너관리원에 통보 후 도착지의 위치를 선정한다. 화물별로 치장한 후에 화물명세서를 부착한다. 화주의 요청에 따라 통관 유무를 확인하여 출고를 한다. 출고 후에 작업보고서를 작성하고 작업이 이루어진 빈 컨테이너를 처리한다. 직통관인출의 경우 컨테이너화물집하장(CFS)수입사무원으로부터 작업을 접수하고 컨테이너의 도착 유무, 위치를 파악하고 화물의 상태 및 이상 유무를 확인하여 출문증을 확인하여 작업을 시작한다. 작업이 이루어진 빈 컨테이너를 처리하고 작업보고서를 작성한다. 특수화물의 경우에는 장비기사와 협의하여 작업한다. 작업이 종료되면 화물별, 컨테이너 크기별 일일 작업량을 정리하여 컨테이너화물집하장(CFS)수입사무원에게 전달한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"보세창고관리원","certLic":"검수사","dJobECd":"0283","dJobECdNm":"[0283]자재·구매·물류 사무원","dJobJCd":"3123","dJobJCdNm":"[3123]자재 관리 사무원","dJobICd":"H521","dJobICdNm":"[H521]보관 및 창고업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006127:1', '{"dJobCd":"K000006127","dJobCdSeq":"1","dJobNm":"수출창고관리원","workSum":"수출화물을 창고에 반입·보관하고 선박의 스케줄에 따라 반출한다.","doWork":"화물집하소화물 창고입고 시 선적예정 화물 창고에 입고한다. 입고화물에 대한 이상 유무를 확인·검수한다. 야드(Yard)장치화물에 대한 위치를 선정하고 검수한다. 창고입고화물에 대한 위치를 선정한다. 입고화물에 대한 자료대장을 정리한다. 수출화물 컨테이너 적입 시 화주 및 선사의 요청 시 선적스케줄에 따른 컨테이너를 적입한다. 적입 시 화물의 이상 유무를 확인·검수한다. 적입화물에 대한 자료를 정리한다. 환적(T/S:TranShipment,한 선박에서 다른 선박으로 화물을 옮겨 싣는 것)화물 입출고 시 화주의 요청에 따라 컨테이너화물집하장(CFS)수입사무원의 지시를 받아 환적작업을 한다. 세관신고서 및 수입적하목록을 확인한다. 작업후 검수원에게 요청하여 봉인(Seal)한다. 이고화물(다른 창고의 화물) 작업지시를 받아 입고 유무를 확인하고 컨테이너화물집하장(CFS)수출사무원의 지시와 수납을 확인하여 검수 후 이고화물을 출고한다. 출고작업을 확인하여 포장오더를 작성한다. 자료를 확인하여 수출창구에 제출한다. 작업이 끝나면 선사별, 컨테이너 사이즈별 일일 작업량을 정리하여 컨테이너화물집하장(CFS)수출사무원에게 제출한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"관련없음","certLic":"검수사","dJobECd":"0283","dJobECdNm":"[0283]자재·구매·물류 사무원","dJobJCd":"3123","dJobJCdNm":"[3123]자재 관리 사무원","dJobICd":"H521","dJobICdNm":"[H521]보관 및 창고업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002031:1', '{"dJobCd":"K000002031","dJobCdSeq":"1","dJobNm":"신발자재구매관리자","workSum":"확정된 견본신발과 제품규격서에 따라 자재의 특성을 파악하고, 신발채산서에 근거하여 자재를 구매하고 관리한다.","doWork":"제품규격서의 일반내용, 채산서의 주요내역, 채산의 산출방법을 숙지하고, 공정을 분석한다. 확정된 견본신발과 제품규격서와 신발채산서에 근거하여 자재를 구매하고 관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"신발자재구매사무원","dJobECd":"0283","dJobECdNm":"[0283]자재·구매·물류 사무원","dJobJCd":"3123","dJobJCdNm":"[3123]자재 관리 사무원","dJobICd":"C152","dJobICdNm":"[C152]신발 및 신발 부분품 제조업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003480:1', '{"dJobCd":"K000003480","dJobCdSeq":"1","dJobNm":"야드크레인사무원","workSum":"컨테이너 야드에 반입될 화물을 작업계획에 따라 트랜스퍼크레인 등에 할당하고 컨테이너를 야드에 장치한다.","doWork":"각 모선별 반입 컨테이너의 작업계획을 접수한다. 당일 재고 및 당일 작업량을 파악한다. 트랜스퍼크레인, RMGC(Rail Mounted Gantry Crane), 야드트레일러 등의 장비배차를 의뢰한다. 배차장비의 무선주파수를 선정하고 지정한다. 작업상황 변화에 따라 컨테이너 장치위치를 다시 부여하고 수정한다. 컨테이너에 상이한 번호가 있을 경우 수정한다. 작업상황에 따라 야드트레일러 등의 장비배차를 조절한다. 야드작업 일지와 작업통계 등을 작성하여 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","dJobECd":"0283","dJobECdNm":"[0283]자재·구매·물류 사무원","dJobJCd":"3123","dJobJCdNm":"[3123]자재 관리 사무원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002137:1', '{"dJobCd":"K000002137","dJobCdSeq":"1","dJobNm":"양적화플래너","workSum":"화물의 양적화를 하기 위해 작업순서를 결정하고 본선적부도와 야드 적재계획을 작성하여 작업지시를 한다.","doWork":"양화 및 적화정보를 화주나 선사로부터 메일 또는 전자문서교환 등으로 접수한다. 양화 및 적화프로파일을 검토하여 선사나 화주와 일정을 협의 조정한다. 양적화 컨테이너의 정보를 데이터베이스에 입력한다. 양화플래닝시스템에서 본선작업의 양화플래닝을 실시한다. 양화순서를 확인하고 특별사항이 있는지 확인후 수정한다. 양하순서내역을 출력하여 냉동, 특수화물, 위험물, 환적화물, 라인별 컨테이너 개수 등을 검토하여 수정한다. 양화베이플랜을 작성한다. 최종 검토 확인된 양화베이플랜, 작업순서, 작업내역을 출력한다. 양화작업서류를 정리하여 통제센터의 터미널운영요원에게 전달한다. 적화플래닝시스템에서 본선작업의 적화플래닝을 실시한다. 적화순서를 확인하고 특별사항이 있는지 확인 후 수정한다. 적화순서내역을 출력하여 냉동, 특수화물, 위험물, 환적화물의 개수 등을 검토하여 수정한다. 적화베이플랜을 작성한다. 최종 검토 확인된 적화베이플랜, 작업순서, 작업내역을 출력한다. 적하작업서류를 정리하여 통제센터의 터미널운영요원에게 전달한다. 본선작업이 시행되고 작업현장에서 병목현상이나 작업애로 등이 나타나면 선사 등과 협의하여 베이플랜을 수정 후 통제센터의 터미널운영요원에게 다시 전달한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"본선플래너","connectJob":"컨테이너 야드에 적재를 위하여 컨테이너 로딩리스트를 검토하고 적재플랜을 작성하는 경우 야드운영플래너, 컨테이너의 야드 반입계획을 수립하고 야드장치계획표(Yard Assign DeckingPlan)를 작성하는 경우 야드장치플래너","certLic":"항해사","dJobECd":"0283","dJobECdNm":"[0283]자재·구매·물류 사무원","dJobJCd":"3123","dJobJCdNm":"[3123]자재 관리 사무원","dJobICd":"H501","dJobICdNm":"[H501]해상 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003050:1', '{"dJobCd":"K000003050","dJobCdSeq":"1","dJobNm":"외주관리원","workSum":"외주를 효과적으로 이행하기 위하여 발주과정, 제품수령, 대금결제 등 외주관리업무를 담당한다.","doWork":"외주(자기회사의 설비나 종업원을 사용하지 않고 외부의 생산자에게 반제품 또는 부품을 제작시키는 일)할 품목, 단가, 원자재 지급여부, 외주납기 등을 결정하여 외주관리계획을 수립한다. 외주거래처를 파악하고 입찰을 진행하거나 외주생산계약을 체결한다. 외주거래처를 지도·감독한다. 제품의 수령, 품질검사, 대금지급 등의 업무를 수행한다. 외주거래처와 관계를 유지한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"협의","workFunc3":"관련없음","similarNm":"건축토목외주관리원, 기계자동차부품외주관리원, 금속부품외주관리원, 섬유의류외주관리원, 전자컴퓨터외주관리원, 음식료품외주관리원","dJobECd":"0283","dJobECdNm":"[0283]자재·구매·물류 사무원","dJobJCd":"3123","dJobJCdNm":"[3123]자재 관리 사무원","dJobICd":"M739","dJobICdNm":"[M739]그 외 기타 전문, 과학 및 기술 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;