INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005996:1', '{"dJobCd":"K000005996","dJobCdSeq":"1","dJobNm":"방송제작비관리원","workSum":"라디오 또는 텔레비전 프로그램의 제작에 소요되는 비용을 책정하고 집행과정을 기록·관리한다.","doWork":"프로그램제작에 따른 표준제작비를 검토하고 소요되는 제작비의 집행한도액을 책정한다. 원고료(메인작가, 보조작가), 연출료(PD, AD), 출연료(진행자, 패널, 코디, 분장, 의상, 성우), 미술 및 효과(세트비, 임대료, 소품비, 작곡 및 선곡료, 특수효과료), 제작기술료(종합편집료, 타이틀제작료, 녹음, 믹싱료, 특수장비사용료, 조명료, 가편집료, 테이프구입료), 야외진행비(사전기획비, 현장답사비, 출장비, 현장진행비, 사후제작비) 등을 산정하여 담당PD, 제작사, 방영처 등에 통지한다. 산출한 제작비 내역을 기록·관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"계산","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0271","dJobECdNm":"[0271]회계 사무원","dJobJCd":"3131","dJobJCdNm":"[3131]회계 사무원","dJobICd":"J601/J602","dJobICdNm":"[J601]라디오 방송업 / [J602]텔레비전 방송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006091:1', '{"dJobCd":"K000006091","dJobCdSeq":"1","dJobNm":"병원수가원","workSum":"병원 전반의 진료수가를 제정 및 개정하여 관련 부서에 통보하고 진료비 사정을 관리한다.","doWork":"환자에게 제공된 의료행위에 대하여 행위별수가(임상 각 과에서 새로이 시행하는 시술에 관하여 의료행위의 난이도, 전문적 지식이 필요한 정도를 고려하여 원가를 산출) 또는 포괄수가(일정한 질병군을 정해서 해당 질병에 대하여 질병을 치료하는 데 사용된 인력, 의료행위, 약품의 종류와 양을 고려하여 일정액을 포괄적으로 지정)의 적용 항목을 구분한다. 건강보험이 적용되지 않는 비급여수가를 산정한다. 행위별수가, 포괄수가, 비급여수가를 계산하여 청구된 보험급여를 사정하고 기록·관리하며 계산서를 발급한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"계산","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0271","dJobECdNm":"[0271]회계 사무원","dJobJCd":"3131","dJobJCdNm":"[3131]회계 사무원","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002522:1', '{"dJobCd":"K000002522","dJobCdSeq":"1","dJobNm":"세무사무원","workSum":"세무사의 지휘하에 세무에 관한 서류를 작성·검토·신고·신청하는 등 세무사의 업무를 지원한다.","doWork":"일정 과세기간 중 접수한 매출 및 기타 세무자료를 취합하여 기재사항을 검토하고 보완한다. 현금출납장 및 보조장과 대조하여 세금계산서가 완비되었는지, 금액이 정확한지 확인한다. 세금계산서를 공제액과 환급세액을 계산하여 차감확인 후 세무서에 신고한다. 매월 원천징수 금액, 부가가치세, 소득세 등을 신고한다. 재무제표 참조 후 법인세법에 의한 세무조정사항을 정리한다. 과세표준액을 산정하며 각종 세법에 따라 세금을 계산한다. 법인의 소득과 세금산출의 장부를 작성한다. 세무조사를 준비하여 조사받고 필요시 보정자료(세무신고서류의 흠결을 수정하거나 보충하는 자료)를 작성한다. 개인이나 기업체의 세무관계를 상담한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"세무사사무장","certLic":"재경관리사, 회계관리, AT(Accounting Technician) 세무회계,","dJobECd":"0271","dJobECdNm":"[0271]회계 사무원","dJobJCd":"3131","dJobJCdNm":"[3131]회계 사무원","dJobICd":"M712","dJobICdNm":"[M712]회계 및 세무관련 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001875:1', '{"dJobCd":"K000001875","dJobCdSeq":"1","dJobNm":"신발원가전문가","workSum":"확정된 신발 견본을 바탕으로 신발채산에 근거하여 자재비를 산정하고, 신발규격에 근거하여 노무비와 제경비를 계산하여 신발 한 족당 사용되는 신발원가서를 작성한다.","doWork":"신발채산에 근거하여 자재 부품별 족당 자재비를 산정한다. 신발규격에 근거하여 재단, 재봉, 창제작, 제조준비, 제화의 부품별, 완제품 제작에 필요한 시간, 족수, 지출비용 등 노무비와 제경비를 계산하여 신발 한 족 당 사용되는 신발원가서를 작성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"가격전문가, Cost분석가","connectJob":"규격채산IE","certLic":"원가분석사","dJobECd":"0271","dJobECdNm":"[0271]회계 사무원","dJobJCd":"3131","dJobJCdNm":"[3131]회계 사무원","dJobICd":"C152","dJobICdNm":"[C152]신발 및 신발 부분품 제조업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005185:1', '{"dJobCd":"K000005185","dJobCdSeq":"1","dJobNm":"용역계약관리원","workSum":"용역계약을 체결하고 계약의 이행을 관리한다.","doWork":"용역계약 공고문를 작성한다. 사업공고, 서류징구, 계약안내 등 계약 체결절차를 진행한다. 계약서류를 검토하고 계약을 체결한다. 계약서, 유의서, 용역계약일반조건, 용역계약특수조건, 과업내용서 및 산출내역서 등 계약관련 문서를 유지한다. 계약보증금, 이행보증, 계약이행상황의 감독, 지체상금, 계약기간의 연장, 계약목적물의 검사 및 인수, 계약의 해지 등 계약이행에 관련된 업무를 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0271","dJobECdNm":"[0271]회계 사무원","dJobJCd":"3131","dJobJCdNm":"[3131]회계 사무원","dJobICd":"N759","dJobICdNm":"[N759]기타 사업지원 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002861:1', '{"dJobCd":"K000002861","dJobCdSeq":"1","dJobNm":"원가관리사무원","workSum":"경영합리화를 위해 원가회계와 원가통제 및 절감업무를 수행한다.","doWork":"직접 재료비, 직접 노무비 등 과거의 자료를 기초로 표준원가를 정한다. 원가회계업무를 수행하는 경우 외부이용자를 위한 재무제표를 작성한다. 내부이용자를 위해 경영계획을 수립·통제한다. 특별한 의사결정과 경영자 성과평가에 필요한 원가정보를 제공할 목적으로 생산·영업활동에 관한 원가자료를 확인하고 분류·집계한다. 원가통제(원가계획의 달성을 목적으로 시행)업무를 수행하는 경우, 원가관리구분을 정하고 원가관리책임자를 정한다. 각 원가관리책임자에게 관리가능비용에 대하여 달성할 수 있는 표준치를 제시한다. 표준원가와 실제원가를 비교하여 문제점과 개선책을 개발한다. 원가책임 구분에 따라 원가절감실적을 평가한다. 지속적으로 표준원가와 실제원가의 차이를 줄여서 원가절감 목표를 달성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"중고자동차가격산정사, 자동차원가사무원","certLic":"원가분석사","dJobECd":"0271","dJobECdNm":"[0271]회계 사무원","dJobJCd":"3131","dJobJCdNm":"[3131]회계 사무원","dJobICd":"C","dJobICdNm":"[C]제조업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003357:1', '{"dJobCd":"K000003357","dJobCdSeq":"1","dJobNm":"재무관리사무원","workSum":"기업이 필요로 하는 자본의 조달 및 운용에 대한 계획을 수립하고, 자금의 계획 및 관리, 이익의 관리, 예산통제에 관한 업무를 수행한다.","doWork":"소속 기업의 필요 자본량을 산정한다. 주식, 사채 등 자본조달 관련 업무를 수행한다. 현금수지나 보관 등 집행적 재무활동을 수행한다. 이익관리, 예산관리, 원가관리, 경영분석 등 재무관리에 수반되는 업무를 수행한다. 재무계획(이익계획 및 자금계획), 재무조직(재무관리조직), 재무통제(경영분석, 경영비교, 예산차이 분석) 관련 업무를 수행한다. 기업의 유동성(기업의 지불능력)을 분석하고 보고한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"재무사무원, 자금사무원, 자금운용사무원","connectJob":"IR(IInvestor Relations)담당원, IPO(Initial public Offering)담당원","certLic":"재경관리사, 회계관리, AT(Accounting Technician)","dJobECd":"0271","dJobECdNm":"[0271]회계 사무원","dJobJCd":"3131","dJobJCdNm":"[3131]회계 사무원","dJobICd":"M712","dJobICdNm":"[M712]회계 및 세무관련 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007487:1', '{"dJobCd":"K000007487","dJobCdSeq":"1","dJobNm":"회계사무원","workSum":"기업 또는 회계사무소에서 사업체의 재무 거래에 대해서 분기, 전기, 결산 등의 업무를 수행한다.","doWork":"발생한 거래 즉 자산, 부채, 자본의 증감 및 손익의 발생에 따라 차변계정과목과 대변계정과목을 나눈다. 이를 장부에 옮겨 적으며 숫자 또는 계산이 정확한지 확인하고 정산한다. 기업이 일정기간 동안 사업을 계획하고 실행해온 과정에서 발생한 오류나 문제점을 찾는다. 세무서에 세금을 납부하거나 주주들에게 회사의 이익을 돌려주는 등의 업무를 위해 장부를 정리하고 결산서를 작성한다. 대차대조표, 손익계산서 등의 재무제표 분석으로 기업의 경영성과 및 재무상태를 판단하고 그 적부를 진단한다. 기업의 수익성, 유동성, 생산성, 성장성 등을 파악하여 자금조달결정, 투자결정, 배당결정의 기초자료를 제공한다. 세법에서 규정하고 있는 각종 세금과 관련된 과표와 세액을 계산·신고하고 납부한다. 고객과 회계 및 세무와 관련하여 상담한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"제어조작","connectJob":"회계사사무장, 결산회계사무원, 부기원, 법인결산원, 법인회계결산원","certLic":"전산회계운용사(1급, 2급, 3급), 재경관리사, 회계관리, AT(Accounting Technician)","dJobECd":"0271","dJobECdNm":"[0271]회계 사무원","dJobJCd":"3131","dJobJCdNm":"[3131]회계 사무원","dJobICd":"M712","dJobICdNm":"[M712]회계 및 세무관련 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007466:1', '{"dJobCd":"K000007466","dJobCdSeq":"1","dJobNm":"경리사무원","workSum":"회사 경영에 필요한 재무정보를 제공하기 위하여 현금, 채권, 채무 등의 증감을 기록, 계산, 정리하는 업무를 수행한다.","doWork":"정해진 절차에 따라 매뉴얼이나 전산시스템을 사용하여 청구서, 송장, 계산서 및 기타 경리서류를 작성하여 발행한다. 재무기록 및 수취계정, 지불계정과 같은 거래를 정해진 방식에 따라 처리·대조하고, 원장이나 전산시스템에 자료를 입력한다. 직원의 임금 및 수당을 계산·지급하고, 퇴직금 계산, 연말정산, 기타 일반경비와 관련하여 증빙서류를 정리한다. 통장과 현금의 관리, 보고 등의 업무를 수행한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"경리","connectJob":"무역경리사무원, 운수경리사무원, 건설경리사무원, 제조경리사무원, 회계경리사무원, 세무경리사무원, 사무소경리사무원, 일반사업체경리사무원, 아파트경리사무원, 빌딩경리사무원, 단순경리사무원","certLic":"전산회계운용사(1급, 2급, 3급)","dJobECd":"0272","dJobECdNm":"[0272]경리 사무원","dJobJCd":"3132","dJobJCdNm":"[3132]경리 사무원","dJobICd":"ALL","dJobICdNm":"[ALL]전체","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004578:1', '{"dJobCd":"K000004578","dJobCdSeq":"1","dJobNm":"도선사무원","workSum":"도선사들로부터 도선선표를 받아 도선료를 계산한다.","doWork":"도선사들이 선장으로부터 받아 전송된 도선선박의 선명, 구간이동시간, 톤수(홀수) 등의 내역이 있는 도선확인서를 전산 입력한다. 거리 및 시간, 톤수에 따른 도선선료를 컴퓨터상으로 계산된 결과를 인쇄하여 각 선사대리점에 요금을 청구한다. 청구내역에 따라 수금하고 수금한다. 일정기간 동안의 도선실적을 입력하여 도선사에게 전달한다. 도선실적에 따라 비용을 도선사에게 지급한다. 도선사의 매출실적자료 등을 관계기관에 보고하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"계산","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"도선료계산원","dJobECd":"0272","dJobECdNm":"[0272]경리 사무원","dJobJCd":"3132","dJobJCdNm":"[3132]경리 사무원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006971:1', '{"dJobCd":"K000006971","dJobCdSeq":"1","dJobNm":"버스표매표사무원","workSum":"버스매표원으로부터 취합된 버스승차권 판매금액을 정산하는 업무를 수행한다.","doWork":"매표원의 당일 매표 집계현황을 취합한다. 일일 판매승차권과 원표 및 매표용 시스템의 기록을 비교·확인하고 판매금액을 정산·처리한다. 각 운행운수 회사별·노선별로 판매된 버스승차권을 컴퓨터시스템에 입력하여 지급액을 계산한다. 운수회사별 이용승객수와 수익금을 분배, 정산한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0272","dJobECdNm":"[0272]경리 사무원","dJobJCd":"3132","dJobJCdNm":"[3132]경리 사무원","dJobICd":"H492","dJobICdNm":"[H492]육상 여객 운송업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001866:1', '{"dJobCd":"K000001866","dJobCdSeq":"1","dJobNm":"수금관리사무원","workSum":"가스, 수도, 전기의 수용가 이동사항, 수금실적, 계량기 신·증설사항 등을 관리한다.","doWork":"검침기록을 기준으로 요금을 계산하고, 수용가에 요금납부고지서를 발행한다. 수용가의 명의변경 또는 이동사항을 통고표에 작성하여 컴퓨터에 정정하여 입력한다. 컴퓨터를 이용하여 수금실적을 관리한다. 오검침 수용가의 기록이나 입력사항을 정정한다. 전기·가스수용가의 시설을 신·증설 또는 폐지하기 위하여 계획서를 작성하고 관계작업원에게 전달한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0272","dJobECdNm":"[0272]경리 사무원","dJobJCd":"3132","dJobJCdNm":"[3132]경리 사무원","dJobICd":"D351/D352/E360","dJobICdNm":"[D351]전기업 / [D352]연료용 가스 제조 및 배관공급업 / [E360]수도업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003167:1', '{"dJobCd":"K000003167","dJobCdSeq":"1","dJobNm":"시내버스입금원","workSum":"운행을 마친 시내버스가 입고되면 수입금을 확인하여 입금한다.","doWork":"시내버스운전자의 일일 또는 일회 운행이 끝나면 현금으로 지급된 버스요금을 계산한다. 운전기사가 가져온 단말기팩을 취합하고 집계컴퓨터로 자동 정리된 금액을 확인한다. 총 수입금을 확인하여 회계부서로 입금한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"계산","workFunc2":"말하기신호","workFunc3":"단순작업","dJobECd":"0272","dJobECdNm":"[0272]경리 사무원","dJobJCd":"3132","dJobJCdNm":"[3132]경리 사무원","dJobICd":"H492","dJobICdNm":"[H492]육상 여객 운송업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003354:1', '{"dJobCd":"K000003354","dJobCdSeq":"1","dJobNm":"요금사무원","workSum":"수용가가 사용한 가스, 수도, 전기, 열의 양에 따라 요금을 청구하는 업무를 수행한다.","doWork":"검침자료를 검토한 후 전산상에 나타난 문제점이 없는가를 검사한다. 검침상 문제점이 발견되면 수용가와 문제에 대한 원인을 파악하고, 문제점 발견 시 관련 부서에 해결하도록 연락한다. 고객의 사용량에 따른 정확한 요금청구를 하기 위하여 계산한다. 문제가 있는 수용가의 계량기에 나타난 사용량은 수작업을 통하여 합리적이고 공정한 요금이 청구되도록 조정한다. 청구서 발행을 위하여 전산장치를 조정한다. 기타 요금관련 업무를 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"계산","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0272","dJobECdNm":"[0272]경리 사무원","dJobJCd":"3132","dJobJCdNm":"[3132]경리 사무원","dJobICd":"D351/D352/E360","dJobICdNm":"[D351]전기업 / [D352]연료용 가스 제조 및 배관공급업 / [E360]수도업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002833:1', '{"dJobCd":"K000002833","dJobCdSeq":"1","dJobNm":"전화국수납원","workSum":"전화국에서 전화요금과 전화청약, 설비변경 등에 따른 대금을 수취하고 체납자에 대한 납부를 독려한다.","doWork":"수취금액을 검사하고 현금을 징수하며 영수증을 발행한다. 고지서를 정리하거나 전자계산소에서 넘어온 체납자 명단에 의거하여 체납자를 색출하여 장부에 기재하고 전화 또는 직접 방문하여 납부를 독려한다. 금액과 지불금액을 기록하고 장부와 현금을 맞춘다. 가입자의 요구에 따라 청구서를 재발급하기도 한다. 금전등록기를 사용하기도 한다. 장기체납자에 대한 신용불량 등록 및 소송관리를 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"계산","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0272","dJobECdNm":"[0272]경리 사무원","dJobJCd":"3132","dJobJCdNm":"[3132]경리 사무원","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005554:1', '{"dJobCd":"K000005554","dJobCdSeq":"1","dJobNm":"카지노출납원","workSum":"카지노의 게임운영을 위해 칩을 공급하고 회수하며 회계업무를 수행한다.","doWork":"카운트 룸을 운영하며 카지노에서 사용되는 칩을 공급하고 회수한다. 게임테이블에 장착되어 있는 드롭박스의 드롭(현금, 수표, 여행자수표 등의 내용물)을 정해진 시간에 회수한다. 각 테이블별로 회수된 드롭박스의 드롭을 계산 및 정리하고, 칩, 현금, 수표 등을 보관한다. 칩을 현금으로 교환하여 고객에게 지급한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"계산","workFunc2":"서비스제공","workFunc3":"단순작업","similarNm":"카지노캐셔","dJobECd":"0272","dJobECdNm":"[0272]경리 사무원","dJobJCd":"3132","dJobJCdNm":"[3132]경리 사무원","dJobICd":"R912","dJobICdNm":"[R912]유원지 및 기타 오락관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007478:1', '{"dJobCd":"K000007478","dJobCdSeq":"1","dJobNm":"비서","workSum":"임원급의 직속상사에게 직속되어 있으면서 상사의 업무효율성을 기하기 위한 일정예약, 정보수집 및 전달, 문서작성 지원업무를 한다.","doWork":"단순보조 비서업무를 수행하는 경우 업무 시작 전·후와 수시로 직속상사의 주변환경을 정리·정돈한다, 전화나 문서로 직속상사의 연락사항을 전달한다. 사내·외로부터 접수된 문서를 전달한다. 전화를 수신하여 직속상사에게 연결하며, 부재 중이면 메모를 해두었다가 전달한다. 회의소집 연락을 취하고 회의진행에 필요한 사항을 준비한다. 내방객을 접대하며 부재 시에는 내방객에 대한 성명, 용건 및 기타사항을 기록하고 보고한다. 업무에 필요한 자료를 수집·기록한다. 서신, 문서, 보고서를 작성하고, 차후에 필요한 자료를 쉽게 사용할 수 있도록 정리·분류하여 보관한다. 전문비서업무를 수행하는 경우 누적된 정보를 분석해 직속상사가 의사결정을 하는 데 도움을 준다. 직속상사 주변 환경에 대한 정보를 수집해 직속상사가 유리한 판단을 하도록 지원을 한다. 직속상사의 부재 시 업무의 연속성을 유지해 단기적인 판단을 하여 업무의 진행에 차질이 없도록 지원한다. 상사의 업무과중으로 인해 누락된 정보 및 자료를 찾아 업무의 완성도를 높이도록 보좌한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"일반비서, 전문비서, 의회의원비서관, 시도의원비서관, 관리비서, 수행비서, 개인비서, 부속실비서","certLic":"비서(1급, 2급, 3급)","dJobECd":"0294","dJobECdNm":"[0294]비서","dJobJCd":"3141","dJobJCdNm":"[3141]비서","dJobICd":"ALL","dJobICdNm":"[ALL]전체","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004796:1', '{"dJobCd":"K000004796","dJobCdSeq":"1","dJobNm":"경마발주보조원","workSum":"경주마(출주마)의 발주(發走)를 위해 발주위원의 지시를 받아 제반 업무를 보조한다.","doWork":"발주위원의 신호에 따라 경기에 출전하는 경주마의 발주기 진입을 유인하고 보조한다. 착순판정원이 경기시작을 알 수 있도록 발주기 전방에서 발주기를 통과한 말이 황색기 앞을 통과할 때 황색기를 내린다. 발주위원의 재발주 신호가 있으면 백색기를 흔들어 경주 중인 경마기수에게 경주무효를 알린다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"가벼운 작업","workPlace":"실외","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"단순작업","dJobECd":"0295","dJobECdNm":"[0295]전산자료 입력원 및 사무 보조원","dJobJCd":"3142","dJobJCdNm":"[3142]전산 자료 입력원 및 사무 보조원","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003979:1', '{"dJobCd":"K000003979","dJobCdSeq":"1","dJobNm":"경마재결보조원","workSum":"경마에 관련된 제반 업무를 수행하고 재결위원의 업무를 보조한다.","doWork":"출마표와 착순심판통지에 의거하여 경주명, 날짜, 등위, 날씨, 거리, 경주기록, 기수명, 부담중량, 마체중량 등의 기록을 전산에 입력한다. 재결내용을 방송한다. 제재와 관련된 서류를 작성하고 관련자에게 통보한다. 기타 재결위원이 지시하는 기타 업무를 수행한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"기록","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0295","dJobECdNm":"[0295]전산자료 입력원 및 사무 보조원","dJobJCd":"3142","dJobJCdNm":"[3142]전산 자료 입력원 및 사무 보조원","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007194:1', '{"dJobCd":"K000007194","dJobCdSeq":"1","dJobNm":"데이터라벨러","workSum":"자율주행, 자연어 인식 등 인공지능 프로그램 개발을 위해 인공지능이 학습 데이터를 쉽게 인식할 수 있도록 텍스트, 사진 이미지, 동영상, 사운드 등의 파일에 등장하는 사물, 동식물, 특정 단어 등에 라벨(정보 표식)을 수집하고 입력하여 가공한다.","doWork":"작업 전 프로젝트 가이드를 숙지한다. 조건에 부합하는 이미지, 영상을 촬영하거나 음성 또는 사운드를 녹음하여 업로드한다. 또는 상황별 적절한 Q&A 데이터셋을 생성한다. 이미지에서 정해진 대상으로 마우스로 드래그하여 박스를 그린다. 대상에 특정 부위에 점을 찍는 직업은 스켈레턴 추출작업을 한다. 사진 속 사람의 얼굴 표정을 보고 감정을 추론해 태깅하거나 이미지를 글로 상세히 묘사하는 작업을 한다. 화자가 특정 동작이나 대사를 말할 때 해당 구간 선택, 고객사에서 필요한 데이터에 따라 영상의 구간을 선택해 추출한다. 구간 추출 후에는 감정을 태깅하거나 대사를 받아쓰는 직업을 한다. 주어진 시나리오에 맞는 Q&A 대화 만들거나 제시된 지문 읽고 질문 만드는 작업을 한다. 주어진 문장을 읽고 의미가 같은지 다른지 태깅하는 작업, 주어진 지문을 읽고 핵심 내용을 요약하는 작업, 문장을 읽고 느껴지는 감정을 태깅하는 작업을 한다. 주어진 음성을 듣고 들리는 대로 받아쓰는 작업을 한다. 기준음성과 비교 대상음성을 듣고 화자가 같은지 다른지를 태깅하는 작업을 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"시범후 30일 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","similarNm":"데이터레이블러","connectJob":"데이터라벨링검수원","dJobECd":"0295","dJobECdNm":"[0295]전산자료 입력원 및 사무 보조원","dJobJCd":"3142","dJobJCdNm":"[3142]전산 자료 입력원 및 사무 보조원","dJobICd":"N759","dJobICdNm":"[N759]기타 사업지원 서비스업","inqYear":"2021","etc":"보류(데이터검수자 등과 통함 검토 필요)"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005204:1', '{"dJobCd":"K000005204","dJobCdSeq":"1","dJobNm":"도서관도우미","workSum":"학교 도서실이나 도서관에서 도서 대여 반납, 이용자등록 및 대출증발급 등 사서업무를 보조하는 등 이용자의 도서관 이용을 돕는다.","doWork":"학교 도서실이나 도서관에서 컴퓨터를 이용한 도서 대여와 반납, 이용자등록 및 대출증발급, 도서정리, 파손된 도서처리 등의 업무를 한다. 학생들의 독서활동과 독서지도를 한다. 그 밖에 도서실 청소 등 주변환경을 정리하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"단순작업","similarNm":"사서도우미, 사서보조원","certLic":"사서, 사서교사","dJobECd":"0295","dJobECdNm":"[0295]전산자료 입력원 및 사무 보조원","dJobJCd":"3142","dJobJCdNm":"[3142]전산 자료 입력원 및 사무 보조원","dJobICd":"R902","dJobICdNm":"[R902]도서관, 사적지 및 유사 여가관련 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003505:1', '{"dJobCd":"K000003505","dJobCdSeq":"1","dJobNm":"디엠(DM)발송원","workSum":"홍보나 상품 광고를 위하여 대상 고객에게 우편물을 발송하는 일을 한다.","doWork":"광고물, 홍보물, 정기간행물, 지로, 화물택배, 청첩장 등 각종 대량우편물을 고객에게 발송하기 위하여 대상 고객명단 파일을 수령하거나 직접 고객명단을 입력한다. 고객이 제작의뢰한 봉투나 내용물의 재질이나 형태를 확인한다. 고객 명단과 주소를 봉투(우편봉투 및 비닐봉투)나 우편엽서에 디엠(DM)발송용 프로그램 또는 라벨링프로그램을 사용하여 인쇄한다. 우편물을 우체국에 접수한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"시범후 30일 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"기록","workFunc2":"관련없음","workFunc3":"단순작업","similarNm":"DM발송원, Direct Mail 발송원","dJobECd":"0295","dJobECdNm":"[0295]전산자료 입력원 및 사무 보조원","dJobJCd":"3142","dJobJCdNm":"[3142]전산 자료 입력원 및 사무 보조원","dJobICd":"N759","dJobICdNm":"[N759]기타 사업지원 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006012:1', '{"dJobCd":"K000006012","dJobCdSeq":"1","dJobNm":"사무보조원(일반)","workSum":"사무실에서 문서작성 등 사무업무를 보조한다.","doWork":"서류를 정리하고 문서를 수발한다. 근태 및 작업일지 등의 자료를 집계한다. 문서 및 기타 서류를 작성한다. 자료를 관리하고 필요할 경우 이를 복사한다. 입력할 자료를 순서대로 정리하고 키보드를 조작하여 입력한다. 입력이 완료되면 검토하고 파일로 저장한다. 전화받기, 방문객 안내, 문서수발 등 간단한 고객업무를 수행한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"시범후 30일 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"기록","workFunc2":"서비스제공","workFunc3":"단순작업","connectJob":"자료입력원, 문서수발원, 서류정리원, 업무보조원, 공공사무보조원, 공공인턴, 실험보조원, 문서작성원","dJobECd":"0295","dJobECdNm":"[0295]전산자료 입력원 및 사무 보조원","dJobJCd":"3142","dJobJCdNm":"[3142]전산 자료 입력원 및 사무 보조원","dJobICd":"N759","dJobICdNm":"[N759]기타 사업지원 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001637:1', '{"dJobCd":"K000001637","dJobCdSeq":"1","dJobNm":"약국처방전산입력원","workSum":"약국에서 처방전의 내용을 컴퓨터에 입력하는 등 약사의 업무를 보조한다.","doWork":"처방전을 수령하고 처방전에 기입된 주민등록번호, 처방내용, 처방병원 등을 컴퓨터에 입력한다. 처방전을 약사에게 전달한다. 약사의 업무 중 단순 작업을 약사의 지시 및 관리감독 하에 수행한다. 의약품 조제 및 판매대급을 수납하고 영수증을 발급한다. 약국의 청결 유지 및 약품을 진열, 관리하기도 한다. 경리 등 기타 약국 내 사무업무를 수행하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"시범후 30일 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"기록","workFunc2":"서비스제공","workFunc3":"관련없음","similarNm":"처방전입력원, 약국전산원, 약국보조원","certLic":"워드프로세서","dJobECd":"0295","dJobECdNm":"[0295]전산자료 입력원 및 사무 보조원","dJobJCd":"3142","dJobJCdNm":"[3142]전산 자료 입력원 및 사무 보조원","dJobICd":"G478","dJobICdNm":"[G478]기타 상품 전문 소매업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004142:1', '{"dJobCd":"K000004142","dJobCdSeq":"1","dJobNm":"영화자막제작원","workSum":"번역된 영화대사를 영화필름에 표시한다.","doWork":"번역된 영화대본, 영화필름을 수령한다. 스포팅(Spotting) 프로그램을 사용하여 번역된 대본의 각각의 대사가 영화의 장면 및 사운드와 일치하도록 한다. 자막의 위치, 크기, 글씨체 등을 선택하고 자막프로그램(Subtitle program)에 입력한다. 레이저 자막제작기계를 사용하여 필름의 표면에 자막을 만든다. 자막이 만들어진 필름을 세척하여 이물질을 제거한다. 필름과 자막의 완성도를 검사하고 이상이 없으면 출고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"0295","dJobECdNm":"[0295]전산자료 입력원 및 사무 보조원","dJobJCd":"3142","dJobJCdNm":"[3142]전산 자료 입력원 및 사무 보조원","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2021","etc":"디지털화로 인해 필름에 영화제막 제작을 하는 필름현상소의 소멸로 사라진 직업."}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004864:1', '{"dJobCd":"K000004864","dJobCdSeq":"1","dJobNm":"우정실무원","workSum":"우편업무 사업을 원활히 추진하기 위하여 집중국 및 우체국의 과별 업무를 보조한다.","doWork":"우편물 상·하차, 우편물 팰릿(pallet) 적재 및 운반, 우편물 구분, 소포 구분 등의 우편 업무를 보조한다. 순로구분기를 운용한다. 기타 우편집중국과 총괄우체국 및 관내 우체국의 과별 업무를 보조한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","connectJob":"계리원, 우편원, 집배원, 우체국택배원","dJobECd":"0295","dJobECdNm":"[0295]전산자료 입력원 및 사무 보조원","dJobJCd":"3142","dJobJCdNm":"[3142]전산 자료 입력원 및 사무 보조원","dJobICd":"J611","dJobICdNm":"[J611]공영 우편업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002826:1', '{"dJobCd":"K000002826","dJobCdSeq":"1","dJobNm":"의무기록보조원","workSum":"의무기록차트의 대출 및 반출 등 의무기록차트를 관리한다.","doWork":"신규 의무기록차트 및 전자의무기록을 기준에 따라 분류하고 배열한다. 요청된 의무기록차트를 배송하고 확인한다. 바코드리더기를 사용하여 의무기록차트의 대출과 반납을 관리한다. 의료정보를 광디스크에 저장하기 위해 편집한다. 기타 보건의료정보관리사의 업무를 보조한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"단순작업","certLic":"의무기록사","dJobECd":"0295","dJobECdNm":"[0295]전산자료 입력원 및 사무 보조원","dJobJCd":"3142","dJobJCdNm":"[3142]전산 자료 입력원 및 사무 보조원","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006722:1', '{"dJobCd":"K000006722","dJobCdSeq":"1","dJobNm":"전화번호전산기관리원","workSum":"신설, 해지, 이전 등 변동되는 자료를 전화번호안내시스템(Electronic Directory Assistance)에 입력하고 관리한다.","doWork":"신설, 해지, 이전 등 변동되는 자료를 정리하고 전화번호를 확인한다. 컴퓨터의 출력자료를 검토하여 변동된 자료와 비교하고 중복되는 번호에 세부적인 관리번호를 부여한다. 전화번호안내시스템(가입자가 문의한 정보를 담당자가 키보드를 통해 입력하면 컴퓨터가 번호를 검색하여 음성회답장치에서 직접, 때로는 담당자를 통해 회답을 하는 전자식번호안내시스템)에 연결된 단말기를 조작하여 변동자료를 입력한다. 입력이 완료되면 시스템을 시험가동하여 변동자료의 입력여부를 확인한다. 시스템의 가동 중에 발생하는 각종 장애원인을 확인·검사한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"관련없음","certLic":"통신기기기능사","dJobECd":"0295","dJobECdNm":"[0295]전산자료 입력원 및 사무 보조원","dJobJCd":"3142","dJobJCdNm":"[3142]전산 자료 입력원 및 사무 보조원","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002220:1', '{"dJobCd":"K000002220","dJobCdSeq":"1","dJobNm":"점역사","workSum":"컴퓨터 및 컴퓨터프로그램을 활용하여 출판물의 문자, 기호, 수식, 그림, 도표, 그래프, 악보 등을 한국 점자 규정에 맞게 점자로 변환한다.","doWork":"문자, 기호, 수식, 그림, 도표, 그래프 악보 등이 포함된 어문 자료, 이공학 자료 및 악보 등 자료 유형에 따라 점역방식 및 점역전환프로그램을 선정한다. 출판물의 문자 등을 원본 그대로 점자로 입력하거나, 스캐너를 사용하여 입력한 후 원본과 대조하여 오탈자를 수정하여 점자로 변환한다. 점역교정사에게 의뢰하여 한국 점자 규정에 맞게 교정하도록 한다. 교정을 마친 자료는 인쇄를 위해 점자인쇄원에게 전달한다. 그림, 지도, 그래프 등은 시각장애인이 이해할 수 있도록 글로 풀이해 설명한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"0295","dJobECdNm":"[0295]전산자료 입력원 및 사무 보조원","dJobJCd":"3142","dJobJCdNm":"[3142]전산 자료 입력원 및 사무 보조원","dJobICd":"M739","dJobICdNm":"[M739]그 외 기타 전문, 과학 및 기술 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006100:1', '{"dJobCd":"K000006100","dJobCdSeq":"1","dJobNm":"정보검색원","workSum":"금융, 경제, 통계, 기술 등의 각종 자료를 검색하여 수정·평가·분석한다.","doWork":"금융, 경제, 통계, 기술 등 정보수요자의 요구를 정확하게 파악하고, 자료가 수록되어 있는 데이터베이스시스템과의 온라인 연결상태를 점검한다. 검색에 필요한 방법과 절차를 확인하고, 필요한 정보를 검색하여 복사한다. 복사한 자료를 평가·분석하여 수요자의 요구에 맞게 수정한다. 수정한 자료를 정리하여 일정한 양식으로 출력한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","connectJob":"인터넷정보검색사","certLic":"인터넷정보관리사, 정보처리산업기사, 정보처리기능사","dJobECd":"0295","dJobECdNm":"[0295]전산자료 입력원 및 사무 보조원","dJobJCd":"3142","dJobJCdNm":"[3142]전산 자료 입력원 및 사무 보조원","dJobICd":"J639","dJobICdNm":"[J639]기타 정보 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004150:1', '{"dJobCd":"K000004150","dJobCdSeq":"1","dJobNm":"정보제공자","workSum":"이용자가 필요로 하는 각종 정보를 수집·가공·처리하여 제공하는 업무를 수행한다.","doWork":"서비스할 정보를 다각적으로 분석하여 적합한 아이템을 선정한다. 고객의 요구사항을 정확히 조사·분석하고 서비스할 내용을 기획한다. 다양한 자료와 정보를 수집하고 이를 체계적으로 분류해서 데이터베이스화한다. 고객의 요청이 있을 경우 자료를 스캔받거나 파일로 변환하여 메일로 발송하여 준다. 최신의 정보와 정확한 정보서비스를 위하여 지속적인 정보의 업데이트를 유지·관리한다. 인터넷상에서 운영되는 각종 멀티미디어의 정보(각종 수치, 문자, 음성, 그림, 동영상 등)를 수집하고 이를 가치 있는 정보로 재가공한다. 멀티미디어의 기술을 확보하여 게임, 음악, 영화, 교육 등에 사용되는 다양한 디지털콘텐츠 소재를 디자인하고 제작한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"IP(Information Provider), CP(Contents Provider)","certLic":"멀티미디어콘텐츠제작전문가, 정보처리기사","dJobECd":"0295","dJobECdNm":"[0295]전산자료 입력원 및 사무 보조원","dJobJCd":"3142","dJobJCdNm":"[3142]전산 자료 입력원 및 사무 보조원","dJobICd":"J639","dJobICdNm":"[J639]기타 정보 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004023:1', '{"dJobCd":"K000004023","dJobCdSeq":"1","dJobNm":"조사자료입력원","workSum":"센서스, 여론조사, 시장조사 등에서 수집된 자료를 통계분석하기 위하여 부호화한 내용을 컴퓨터에 전산자료로 입력한다.","doWork":"센서스, 여론조사, 시장조사 등에서 수집된 자료를 일정한 규칙하에서 부호화하고 대상 고객 내용을 정리하여 추후에 통계작업에 사용될 수 있도록 한다. 개방형 설문의 경우, 내용과 응답자의 응답을 비교하여 적절한 부호를 부여하기도 한다. 때에 따라서 여론조사분석원이나 시장조사분석원의 자문을 구하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"기록","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"부호화사무원, 코딩원, 펀칭원, 전산입력원, 데이터입력원","dJobECd":"0295","dJobECdNm":"[0295]전산자료 입력원 및 사무 보조원","dJobJCd":"3142","dJobJCdNm":"[3142]전산 자료 입력원 및 사무 보조원","dJobICd":"M714","dJobICdNm":"[M714]시장조사 및 여론조사업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002311:1', '{"dJobCd":"K000002311","dJobCdSeq":"1","dJobNm":"카드발급기조작원","workSum":"신용카드 등 각종 카드의 회원심사가 완료된 카드발급 대상자의 전산명단을 확인하고 발급기로 카드를 제작한다.","doWork":"관련 부서에서 심사완료된 카드발급신청서와 재발급리스트를 대조하여 순서별로 카드발급신청서를 분류한다. 규격크기의 사진 또는 스캐닝 자료를 이미지파일로 전환하고 발급서버에 보관한다. 카드를 카드자동발급기에 투입하여 제작한다. 발급에 착오가 있는 카드는 선별하여 재발급한다. 생성된 카드를 봉입하고 특송업체에 전달하거나 관리지점으로 송부한다. 카드상품별 공카드의 재고를 관리한다. 카드발급기 및 카드발급프로그램을 작성하고 운용한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"0295","dJobECdNm":"[0295]전산자료 입력원 및 사무 보조원","dJobJCd":"3142","dJobJCdNm":"[3142]전산 자료 입력원 및 사무 보조원","dJobICd":"K641","dJobICdNm":"[K641]은행 및 저축기관","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002588:1', '{"dJobCd":"K000002588","dJobCdSeq":"1","dJobNm":"계리원","workSum":"우체국 금융업무, 현업창구(회계)업무, 현금수납 등 각종 계산관리업무 및 우편통계 관련 업무를 한다.","doWork":"개인 또는 법인·단체가 우편대체 계좌를 이용하고자 할 경우 실명을 확인한다. 통장을 발행하는 우편대체 가입업무와 공익단체 또는 법인임을 증명하는 관련 증빙서류를 조회하여 통장을 발행하는 공익계좌 개설업무를 포함하는 계좌 개설업무를 수행한다. 가입자가 요청할 경우 가입국, 주민번호, 사업자번호, 상호, 주소 등을 변경한다. 가입자의 탈퇴요청에 따라 계좌의 잔고가 없는 상태에서 탈퇴신청서를 작성하고 실명확인 및 인감을 대조하여 가입원부와 서류결재를 통하여 통장을 폐기하는 계좌탈퇴업무를 수행한다. 납입, 지급, 이체잔고확인 등의 업무를 수행한다. 자기앞수표 발행 및 지급하는 업무를 하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"대기환경미흡|","workFunc1":"계산","workFunc2":"서비스제공","workFunc3":"수동조작","similarNm":"우편계리원","connectJob":"국제환담당사무원, 우편대체담당사무원, 우편환사무원","certLic":"정보처리기능사, 전자계산기기능사, 전산회계운용사 3급","dJobECd":"0324","dJobECdNm":"[0324]출납창구 사무원","dJobJCd":"3201","dJobJCdNm":"[3201]출납 창구 사무원","dJobICd":"J611","dJobICdNm":"[J611]공영 우편업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007331:1', '{"dJobCd":"K000007331","dJobCdSeq":"1","dJobNm":"보험료수납원","workSum":"보험계약자가 보험자에게 납입하는 보험료를 수납한다.","doWork":"보험료 수납과 관련한 제도 및 규정, 회사방침 등을 숙지하여 관련 업무를 수행한다. 보험료를 지급하기 위해 지점에 방문한 보험계약자에게 보험료를 받는다. 자동이체, 카드수납, 무통장입금 등 금융기관을 통해 수납된 보험료와 보험모집인을 통해 수납된 보험료를 정산하여 보고한다. 보험료납입영수증을 발급한다. 전산프로그램을 통해 미납된 보험료와 계약자를 파악한다. 효율적인 보험료 수납을 위한 개선안을 제안하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"계산","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0324","dJobECdNm":"[0324]출납창구 사무원","dJobJCd":"3201","dJobJCdNm":"[3201]출납 창구 사무원","dJobICd":"K651","dJobICdNm":"[K651]보험업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006189:1', '{"dJobCd":"K000006189","dJobCdSeq":"1","dJobNm":"환전원","workSum":"경륜장, 경마장, 카지노 등의 오락시설에서 고액권, 수표, 외화를 소액권, 현금, 원화로 교환해 준다.","doWork":"당일 환전액을 예상하여 관련 부서에서 현금을 수령한다. 고객이 제시한 외화 또는 수표의 매입증명서, 권면금액, 발행일자, 날인상태, 신분증 등을 확인하고 현금으로 교환하여 준다. 환전금액을 계산하여 관련 부서에 입금하고 입금증을 받는다. 외화를 원화로 교환하거나 원화를 외화로 재환전해주는 외화환전업무를 전문으로 담당하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"계산","workFunc2":"말하기신호","workFunc3":"단순작업","similarNm":"환전사무원","connectJob":"종사분야에 따라 경륜장환전원, 경마장환전원, 카지노잔돈교환원, 오락실환전원, 사설외환원","dJobECd":"0324","dJobECdNm":"[0324]출납창구 사무원","dJobJCd":"3201","dJobJCdNm":"[3201]출납 창구 사무원","dJobICd":"R912","dJobICdNm":"[R912]유원지 및 기타 오락관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001592:1', '{"dJobCd":"K000001592","dJobCdSeq":"1","dJobNm":"병원보험사무원","workSum":"의료보험, 산재보험, 의료보호 및 의료봉사 적용대상 환자의 진료수가를 계산하여 계산서를 작성·발급한다.","doWork":"환자의 수급자를 확인·접수한다. 환자의 이름, 보험주, 보험번호 및 의사의 진단자료 등을 보험분류양식에 따라 작성한다. 환자의 진료수가 적용액을 확인·산정하여 계산서를 발급한다. 의료보험기관에서 지불되는 금액을 계산한다. 의료보호 대상 환자에게 의료비를 지불하는 정부 및 복지기관을 위하여 진료비용 관련 서류를 작성한다. 보험의 적용범위에 관하여 환자의 문의에 답변한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"계산","workFunc2":"서비스제공","workFunc3":"관련없음","certLic":"보험심사평가사","dJobECd":"0323","dJobECdNm":"[0323]보험 심사원 및 사무원","dJobJCd":"3202","dJobJCdNm":"[3202]보험 심사원 및 사무원","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006526:1', '{"dJobCd":"K000006526","dJobCdSeq":"1","dJobNm":"보증보험구상사무원","workSum":"피보험자에게 보증보험에 따른 보험금을 지급할 사유가 발생하면 보험계약자와 연대보증인에 대한 구상권을 행사하여 구상채권(보증기금이 채무관계자에 대하여 법령 또는 계약에 따라 청구할 수 있는 모든 채권)을 회수한다.","doWork":"보험사고가 접수되면 보험사고발생보고서를 작성한다. 계약자와 연대보증인의 소재지와 소유재산을 추적하여 조사결과를 기재한다. 계약자와 연대보증인에게 채무상환내용증명을 발송한다. 계약자 및 보증인에게 공지한 채무상환 기일 내에 채무변제가 이루어지지 않으면 구상권청구소송을 진행한다. 담보여력에 따라 가압류 여부를 판단하고 가압류의 신청 및 유보, 공탁 등의 법적 조치를 결정한다. 결정사항에 따라 근저당물건에 대한 감정을 실시하여 임의경매를 실시하거나, 채무자 관할법원에 지급명령을 제소한다. 조치결과를 정리하여 관련 장부에 기재하고 컴퓨터에 입력한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"전문분야에 따라 신용보증보험구상사무원, 할부판매보증보험구상사무원","dJobECd":"0323","dJobECdNm":"[0323]보험 심사원 및 사무원","dJobJCd":"3202","dJobJCdNm":"[3202]보험 심사원 및 사무원","dJobICd":"K651","dJobICdNm":"[K651]보험업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006965:1', '{"dJobCd":"K000006965","dJobCdSeq":"1","dJobNm":"보험계약심사원","workSum":"보험계약관계자의 위험요소를 평가하여 위험에 따른 비용(보험료)을 산출하는 계약심사업무를 수행한다.","doWork":"보험제도의 정상적인 운용과 보험계약자 간의 공평성을 유지하기 위해 청약서상의 고지의무 내용이나 진단결과 등을 토대로 보험계약자의 각종 위험요소를 종합적으로 판단한다. 각종 위험요소를 검토하여 보험계약을 최종적으로 받아들이는 심사단계과정을 수행한다. 회사가 부담하는 비용과 요율 등을 결정하여 회사의 위험부담이 너무 크다고 판단되는 계약은 인수를 거절하는 등 인수기준을 반영하여 손익분석을 한다. 대인보험일 경우 건강상태, 생활환경, 병력 등을 조사하여 청약서상의 고지사항에 대하여 사실 여부를 확인한다. 대물보험인 경우 기계 및 건물에 대하여 과거 재해 여부, 위험정도 등을 조사하여 청약서상의 고지사항에 대하여 사실 여부를 확인한다. 보험계약자, 피보험자 또는 가족을 직접 면담하여 위험정도를 확인하기도 한다. 병원 및 관련 기관의 자료를 검토하여 사실 여부를 확인하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"보험심사자","connectJob":"심사하는 보험상품에 따라 생명보험계약심사원, 자동차보험계약심사원, 화재특종보험계약심사원, 해상보험계약심사원","dJobECd":"0323","dJobECdNm":"[0323]보험 심사원 및 사무원","dJobJCd":"3202","dJobJCdNm":"[3202]보험 심사원 및 사무원","dJobICd":"K651","dJobICdNm":"[K651]보험업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002717:1', '{"dJobCd":"K000002717","dJobCdSeq":"1","dJobNm":"보험고객불만처리사무원","workSum":"보험 관련 고객의 불만을 접수하고 처리한다.","doWork":"보험 관련 고객의 불만을 접수한다. 고객의 불만사항을 정기적으로 분석하고 대응책을 마련한다. 고객센터를 방문한 고객의 불만사항을 처리하고 처리한 결과를 고객에게 통보한다. 고객불만 관련 시스템을 기획하고 관련 사항을 구성하며 운영한다. 고객의 불만사항을 처리하는 데 필요한 행정업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"서비스제공","workFunc3":"관련없음","certLic":"소비자전문상담사(1급, 2급)","dJobECd":"0323","dJobECdNm":"[0323]보험 심사원 및 사무원","dJobJCd":"3202","dJobJCdNm":"[3202]보험 심사원 및 사무원","dJobICd":"K651","dJobICdNm":"[K651]보험업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005082:1', '{"dJobCd":"K000005082","dJobCdSeq":"1","dJobNm":"보험금관리원","workSum":"보험금 지급에 관한 예산관리를 담당하며 고객에게 보험금이 착오 없이 지급되도록 하는 데 관련된 업무를 수행한다.","doWork":"보험금 관련 예산을 관리하고 보험금의 집행을 관리한다. 보험계약자의 사망, 질병 등으로 보험금 지급사유가 발생할 시 보험금 지급의 적합성 여부를 분석하여 판단한다. 보험금 지급계획을 세우며 보험금 지급 집행실적을 분석하여 통계치를 전산시스템에 저장한다. 보험금지급조서를 비교 대조하여 보험금이 착오 없이 지급되도록 분석·관리한다. 보험금 지급의 착오발생 시 정정조서를 작성한 후 추가 또는 삭감된 보험금 지급오류를 정정하는 업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"관리하는 보험금에 따라 생명보험금관리원, 손해보험금관리원","dJobECd":"0323","dJobECdNm":"[0323]보험 심사원 및 사무원","dJobJCd":"3202","dJobJCdNm":"[3202]보험 심사원 및 사무원","dJobICd":"K651","dJobICdNm":"[K651]보험업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002512:1', '{"dJobCd":"K000002512","dJobCdSeq":"1","dJobNm":"보험금심사원","workSum":"보험금 지급을 결정하기 위해 피보험자 면담, 사고현장 조사 등의 조사 및 보험금 심사업무를 수행한다.","doWork":"보험사고조사기법에 대한 지식을 숙지하고 사고가 자연적 사고인지 인위적 사고인지를 판단하기 위해 사고의 발생시기와 정도를 파악하여 보험금 지급이 적절히 될 수 있도록 조사한다. 보험사고 및 보험범죄의 특성과 유형을 분석하고 과거 유사한 보험사고 및 보험범죄가 발생하여 보험금이 지급되었는지 조사한다. 생명보험 및 종신보험의 경우 피보험자의 장해정도와 원인 또는 사망시기와 원인 등을 조사하여 보험금지급에 반영한다. 손해보험의 경우 건물 및 기계의 파손원인과 정도 등을 조사하여 보험금 지급 여부를 심사한다. 병원, 경찰 등 관련 기관을 방문하여 조사하기도 하며 검찰수사사례를 분석하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"보험사고조사원, 보험보상심사원","dJobECd":"0323","dJobECdNm":"[0323]보험 심사원 및 사무원","dJobJCd":"3202","dJobJCdNm":"[3202]보험 심사원 및 사무원","dJobICd":"K651","dJobICdNm":"[K651]보험업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003036:1', '{"dJobCd":"K000003036","dJobCdSeq":"1","dJobNm":"보험금지급관리원","workSum":"보험금 지급시스템을 유지·관리하기 위해 만기·중도·해약시스템을 관리하고 휴면보험금, 채권가압류계약 등을 관리한다.","doWork":"새로운 보험상품의 추가를 위한 지급시스템을 구축한다. 기존 상품의 만기·중도·해약환급금 및 이자계산에 이상이 없는지 확인한다. 제 지급 관련 증명서를 발급한다. 휴면보험금의 지급업무를 수행한다. 휴면계약자의 주소를 최근 주소로 갱신하고 수정한다. 휴면보험금안내문을 정기적으로 발행한다. 실효계약의 관리업무와 병행하여 신규발행억제책을 수립한다. 채권가압류계약을 관리한다. 법원결정문을 접수하여 심사하고, 이를 전산에 반영하여 안내문으로 발송한다. 지급결정문을 접수하여 지급한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"보험지급관리담당원","dJobECd":"0323","dJobECdNm":"[0323]보험 심사원 및 사무원","dJobJCd":"3202","dJobJCdNm":"[3202]보험 심사원 및 사무원","dJobICd":"K651","dJobICdNm":"[K651]보험업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004292:1', '{"dJobCd":"K000004292","dJobCdSeq":"1","dJobNm":"보험금지급원","workSum":"보험금의 만기지급, 중도지급, 중도해약, 보험사고 등 보험금이 지급되어야 할 사유가 발생했을 때 보험금수령인에게 보험금을 지급한다.","doWork":"보험금청구서와 보험증권, 사고통지서, 손해감정서 등을 접수하여 계약사항과 보험약관 등을 종합적으로 검토한 후 보험금 지급 관련 서류를 작성한다. 조사가 필요한 건은 보험금 심사부서에 조사 및 심사를 의뢰한다. 보험금 지급이 결정된 건은 피보험자의 상해 및 장해정도, 건강상태, 건물 및 선박, 자동차의 파손정도, 화재손실정도 등을 고려하여 전산프로그램으로 계산된 보험금을 보험금 수령인에게 지급한다. 보험계약서상 지급하기로 약정한 금액을 지급한다. 보험금 지급과 관련하여 고객의 질의사항에 답변하거나 상담해주기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0323","dJobECdNm":"[0323]보험 심사원 및 사무원","dJobJCd":"3202","dJobJCdNm":"[3202]보험 심사원 및 사무원","dJobICd":"K651","dJobICdNm":"[K651]보험업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005919:1', '{"dJobCd":"K000005919","dJobCdSeq":"1","dJobNm":"보험보유계약관리원","workSum":"보유계약 증감현황을 조사·분석하고 보험계약자의 요청에 따라 계약사항 변경업무를 한다.","doWork":"보유계약 증감현황을 조사하여 보험상품별·유형별로 증감상황을 분석한다. 계약고가 과다하게 감소한 영업점에 대하여 원인을 파악하고 대책을 수립한다. 보험계약자가 계약사항의 일부를 변경하고자 할 경우 계약변경신청서류를 접수·심사하고 전산처리를 확인하여 추징금과 환급금을 정산하여 통보한다. 계약변경에 따른 보험증권의 내용을 정정한다. 보험료 납입기한이 경과하여 계약이 실효된 보험을 영업점이나 계약자의 요청에 따라 심사하여 보유계약으로 전환할지 여부를 결정한다. 계약실효심사가 완료되면 영수증을 발급하여 수납할 수 있도록 영업점에 발송한다. 우수고객을 차별화하여 관리하고 고객에게 발송할 안내장을 작성·관리하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0323","dJobECdNm":"[0323]보험 심사원 및 사무원","dJobJCd":"3202","dJobJCdNm":"[3202]보험 심사원 및 사무원","dJobICd":"K651","dJobICdNm":"[K651]보험업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004389:1', '{"dJobCd":"K000004389","dJobCdSeq":"1","dJobNm":"보험사무지원사무원","workSum":"보험체결 및 심사 등 본사와 지점 간의 업무를 지원한다.","doWork":"지점을 방문한 고객을 안내한다. 보험계약 체결사항을 컴퓨터에 입력한다. 본사의 지침이나 행정사항을 보험모집인에게 알려준다. 청약서를 스캔하여 본사에 송부한다. 전산상의 보험실적을 집계하여 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"아주 가벼운 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0323","dJobECdNm":"[0323]보험 심사원 및 사무원","dJobJCd":"3202","dJobJCdNm":"[3202]보험 심사원 및 사무원","dJobICd":"K651/K662","dJobICdNm":"[K651]보험업 / [K662]보험 및 연금관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004090:1', '{"dJobCd":"K000004090","dJobCdSeq":"1","dJobNm":"보험신계약담당원","workSum":"신규 보험가입자의 보험청약(계약)서류를 접수하고 계약서 기재내용을 항목별로 확인·심사하여 착오된 부분을 정정처리한다.","doWork":"신규 보험계약을 체결함에 있어 계약 관련 서류(청약서, 고지의무사항, 신용정보조회 동의서)를 접수한다. 지역별·지점별로 분류하고 기재내용을 항목별로 확인·심사하여 청약이 제대로 체결되었는지 확인한다. 확인된 청약내용을 심사위원회에 상정하여 승인을 받아내기도 한다. 심사완료된 청약서에 증권번호를 부여하고 보험증권 등 서류를 지역별, 지점별로 취합하여 통보하고 보존·관리한다. 전산프로그램에 청약(계약)서류 기재내용을 입력하고 원본과 확인·대조하여 착오된 부분은 정정처리한다. 승인되지 않은 청약서나 재발송서류를 지역별, 지점별로 반송처리한다. 그 외 신계약 보험상품의 심사·조사와 관련한 업무를 담당한다. 상담희망고객이 방문하면 보험의 효용과 혜택을 설명하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"보험상품의 종류에 따라 생명보험신계약담당원, 교육보험신계약담당원, 자동차보험신계약담당원, 화재특종보험신계약담당원, 해상보험신계약담당원, 보증보험신계약담당원, 보험계약자에 따라 개인보험신계약담당원, 법인보험신계약담당원","dJobECd":"0323","dJobECdNm":"[0323]보험 심사원 및 사무원","dJobJCd":"3202","dJobJCdNm":"[3202]보험 심사원 및 사무원","dJobICd":"K651","dJobICdNm":"[K651]보험업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006469:1', '{"dJobCd":"K000006469","dJobCdSeq":"1","dJobNm":"보험영업기획원","workSum":"보험상품 영업을 위한 계획을 수립하고 영업조직을 체계적으로 육성·관리한다.","doWork":"조직별, 상품별, 대상별 보험영업실태에 따라 향후 영업대책과 세부계획을 수립한다. 기존의 계약자가 계약을 유지할 수 있는 방안을 강구한다. 신상품이 출시되면 판매전략을 수립하여 각 조직에 통보한다. 조직별 세부판매전략의 추진상황을 점검하고 결과를 분석하여 미흡한 조직에 대한 개선책을 마련한다. 적정한 점포망을 구축하기 위하여 각종 실적에 대한 자료를 수집·분석하여 영업구역을 조정한다. 영업조직을 체계적으로 육성하고 관리하기 위하여 실적과 효율성 등을 파악하고 대책을 수립한다. 보험모집인들의 실적을 파악하여 능률을 올릴 수 있는 방안을 수립한다. 보험모집인들의 수입, 이전직률, 전업화율 등에 대한 자료를 토대로 장기근속을 위한 대책을 수립한다. 영업조직원들의 애로사항을 파악하여 시정하는 등 기타 조직운영의 효율성을 도모하는 업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0323","dJobECdNm":"[0323]보험 심사원 및 사무원","dJobJCd":"3202","dJobJCdNm":"[3202]보험 심사원 및 사무원","dJobICd":"K651","dJobICdNm":"[K651]보험업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006037:1', '{"dJobCd":"K000006037","dJobCdSeq":"1","dJobNm":"보험영업실적분석원","workSum":"신계약, 수납, 보험금지급, 대출 부문 등 보험영업실적을 기관별로 파악·분석하여 그 분석결과를 회사 경영기획자료로 활용하도록 관련 부서에 제공한다.","doWork":"신계약 실적자료를 기관별로 취합·집계하여 현재실적과 누계실적을 파악하고 목표대비 달성율을 산정한다. 지역별, 지점별, 영업소별 실적을 비교하여 순위를 산출한다. 타 회사와의 시장점유율 대비 실적과 시장점유율을 산정한다. 보험상품별 판매량과 비율을 산출하고 월별·분기별·연도별 보험료수납, 보험금지급, 대출 등에 대한 실적을 파악한다. 실적에 대한 분석결과를 경영기획자료로 활용할 수 있도록 관련 부서에 통보한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"언더라이터, 보험계약적부확인요원","dJobECd":"0323","dJobECdNm":"[0323]보험 심사원 및 사무원","dJobJCd":"3202","dJobJCdNm":"[3202]보험 심사원 및 사무원","dJobICd":"K651","dJobICdNm":"[K651]보험업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007446:1', '{"dJobCd":"K000007446","dJobCdSeq":"1","dJobNm":"보험영업지원사무원","workSum":"지역별 시장성을 고려하여 신규 보험영업지점 및 영업소의 설치여건과 타당성을 검토하고 신규 개설·배치를 지원한다.","doWork":"회사의 지점 및 영업소 관리규정이나 시행규칙에 따라 영업점 설치계획을 수립한다. 보험영업점에 대한 입지선정, 건물임대, 사무용품배치, 영업점관리요원 배치 및 양성, 영업점 설립인가 등 영업지원과 관련된 시스템을 기획·관리한다. 보험모집인의 인사관리, 수당지급 및 교육훈련방침 수립 등 영업일선에서 근무하는 사람들을 양성하고 지원하는 업무를 수행한다. 기타 영업지원과 관련되는 업무를 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0323","dJobECdNm":"[0323]보험 심사원 및 사무원","dJobJCd":"3202","dJobJCdNm":"[3202]보험 심사원 및 사무원","dJobICd":"K651","dJobICdNm":"[K651]보험업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007396:1', '{"dJobCd":"K000007396","dJobCdSeq":"1","dJobNm":"사회보장보험가입자관리원","workSum":"고용보험, 산재보험 피보험자 및 국민건강보험, 국민연금 등의 사회보장보험가입자를 관리하기 위하여 사업장별 가입자의 취득·상실·변동사항을 파악하여 관리한다.","doWork":"피보험자 및 가입자의 가입, 탈퇴, 이직, 상실 등의 자격변동에 대하여 자격취득·상실확인서 및 신고서를 접수한다. 접수내용을 확인하여 전산에 입력하고 기록·보존한다. 원천공제납부 예외자(군입대자)와 외국인사업장 가입자, 특수직종근로자에 대한 신고서를 접수하여 확인한다. 성명, 주민등록번호, 국민연금번호를 확인하여 대상자 및 오류자를 정리하고 현황을 파악한다. 사업장 실태를 파악하여 누락 여부를 확인한다. 외국인 등에 대한 자격관리 및 부과자료를 조사·입력한다. 보험료 부과·조정현황을 파악하고 통계를 관리한다. 자격취득자에게 가입자증서를 발급한다. 고용보험의 경우, 이직확인서를 접수하고 기재내용의 적정성에 대해 세밀하게 검토한다. 국민연금의 경우, 표준보수·소득월액 정기결정대상자를 통지하고 지역가입자 및 임의계속가입자의 가입·탈퇴신청에 대한 관리를 한다. 기타 가입자자격관리업무에 대한 민원을 처리한다. 건강보험의 경우, 보험가입자로부터 피부양자신고서를 접수하여 신고서의 기재사항을 확인하고 조회한다. 신고서 조회결과에 따라 보험카드를 발행하여 교부하거나 회수한다. 가입자의 요청에 따라 자격취득이나 상실확인서를 발급한다. 보험카드의 기재사항 중 변경사유가 발생하면 변경내용을 조회하여 보험카드를 재발행하며, 피부양자의 거주지가 멀리 떨어진 곳일 경우에는 원격지보험카드를 발행하여 교부하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"대상에 따라 건강보험가입자관리원, 국민연금가입자관리원, 고용보험가입자관리원, 산재보험가입자관리원","dJobECd":"0323","dJobECdNm":"[0323]보험 심사원 및 사무원","dJobJCd":"3202","dJobJCdNm":"[3202]보험 심사원 및 사무원","dJobICd":"K651","dJobICdNm":"[K651]보험업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001847:1', '{"dJobCd":"K000001847","dJobCdSeq":"1","dJobNm":"사회보장보험급여심사원","workSum":"사회보장보험에 대한 보험금 지급 여부를 심사한다.","doWork":"산재보험의 경우, 요양승인이나 요양기간 연장승인신청서의 접수내용을 확인하여 요양급여심의회의 상정 여부를 검토한다. 상정할 심의안건을 작성하고 급여심의회 개최를 준비한다. 급여심의회 결과에 따라 가결건은 결정서 및 결정내역을 송부하고, 부결건은 부결문을 작성하여 신청인과 해당 기관 및 진료기관에 통보한다. 요양비 및 요양일시금청구서를 확인하여 요양비지급 세부기준에 의한 요건을 심사한다. 요양비지급 결정에 따라 요양비지급의뢰서를 작성하여 의료보험공단에 통보를 한다. 요양 및 기간연장승인에 대한 서신 및 전화민원을 처리하기도 한다. 장애급여 또는 유족보상청구서를 접수한다. 접수내용과 관련 자료를 비교·검토하여 재해보상급여심의회 상정안건을 작성한다. 유족보상금, 장애급여 및 재해부조금의 지급 여부, 지급대상, 지급금액을 결정한다. 심의결과를 통보하고 지급증서를 교부한다. 건강보험의 경우, 의료보험 요양취급기관으로부터 청구된 진료비명세서의 타당성이나 적정 진료비의 청구 여부를 심사한다. 진료비의 심사과정에서 이상 또는 착오를 발생시킨 요양취급기관이 발견되면 해당 기관에 대한 현지 확인심사를 실시한다. 심사결과에 따라 환수할 부당 청구금액을 집계하고 심사결과를 관할관청에 보고한다. 부당 청구금액을 환수하고 관할관청에 행정처분을 의뢰한다. 요양취급기관으로부터 진료비심사에 대한 이의신청이 접수되면 진료기록부 등의 재심사에 필요한 자료제출을 요청한다. 제출한 자료분석과 재심사를 실시하여 재심사환급금을 결정한다. 이의신청기관에 재심결과를 통보한다. 고용보험의 경우, 구직급여를 받고자 하는 사람으로부터 신청서를 접수받고 수급자격(이직확인, 구직신청, 피보험단위기간 충족)을 갖추었는지 확인한다. 수급자격 인정신청자에게 근로의사 및 능력이 없다고 판단될 경우 수급자격이 없음을 설명하고 근로의 의사 및 능력이 회복되고 수급기간 내에 있다면 재신청하여 수급자격을 인정받을 수 있다는 사실을 안내한다. 이의가 있는 경우에는 심사청구절차를 안내해준다. 수급자격 인정신청자에 대해 수급자격을 인정한 경우에는 수급자격증을 교부한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"감독","workFunc3":"관련없음","connectJob":"담당업무에 따라 건강보험급여심사원, 국민연금급여심사원, 고용보험급여심사원, 산재보험급여심사원","dJobECd":"0323","dJobECdNm":"[0323]보험 심사원 및 사무원","dJobJCd":"3202","dJobJCdNm":"[3202]보험 심사원 및 사무원","dJobICd":"K651","dJobICdNm":"[K651]보험업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005614:1', '{"dJobCd":"K000005614","dJobCdSeq":"1","dJobNm":"사회보장보험급여원","workSum":"국민연금 및 건강보험·고용보험급여(구직급여)를 대상자에게 지급하고 관리한다.","doWork":"건강보험의 급여 지급 및 관리를 위해 현금급여비(요양비, 출산비, 장제비, 장애인보장구 등)의 지급 및 환수를 결정한다. 본인부담환급금 및 본인부담액보상금의 지급 및 환수를 결정한다. 보험재정간 급여비를 정산하고 개인별 급여내역을 관리한다. 국민연금급여의 지급계획을 수립하고 지급 및 정산을 한다. 위탁금융기관의 관리와 구상금(보험계약자를 대신해서 피해액 등을 변제하고 그에 대한 변제금을 계약자 및 보증인에게 청구하는 금액), 부당이득환수금의 결정 및 관리를 한다. 급여반환통보서 및 과오납기여금환부청구서(과납 및 오납된 기여금의 환급를 청구하고자 할때 사용하는 서식)를 접수한다. 승인서를 작성하여 해당 기관에 통보한다. 환수금수납 후 영수증을 접수하여 정리한다. 고용보험의 경우, 구직급여대상자에게 급여기초임금일액을 산정하여 소정급여일수만큼 급여를 지급한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"담당업무에 따라 건강보험급여원, 국민연금급여원, 고용보험급여심사원, 산재보험급여원","dJobECd":"0323","dJobECdNm":"[0323]보험 심사원 및 사무원","dJobJCd":"3202","dJobJCdNm":"[3202]보험 심사원 및 사무원","dJobICd":"K651","dJobICdNm":"[K651]보험업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006496:1', '{"dJobCd":"K000006496","dJobCdSeq":"1","dJobNm":"사회보장보험료부과원","workSum":"국민건강보험 및 국민연금 등에 대한 월 보험료·연금액을 부과하고 고지한다.","doWork":"지역 및 직장가입자에 대한 납세소득신고에 기준한 보험요율을 적용하여 건강보험료 및 연금액을 부과 및 고지한다. 보험료 부과액을 정산하여 감면·조정을 하고 관련 민원을 처리한다. 가입자의 소득 및 보수변동에 따라 지역 및 직장가입자의 보험료를 조정하고 현황에 대한 통계관리를 한다. 사업장별로 가입신고 및 탈퇴, 사업장변경, 휴·폐업 등의 신고의무를 지도(계도)점검하고 오류가 없는지 파악한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"담당업무에 따라 건강보험료부과원, 국민연금부과원, 고용보험료부과원","dJobECd":"0323","dJobECdNm":"[0323]보험 심사원 및 사무원","dJobJCd":"3202","dJobJCdNm":"[3202]보험 심사원 및 사무원","dJobICd":"K651","dJobICdNm":"[K651]보험업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004935:1', '{"dJobCd":"K000004935","dJobCdSeq":"1","dJobNm":"사회보장보험료징수원","workSum":"원활한 사회보장제도 실시를 위해 고용보험 및 산재보험 대상 사업자들로부터 보험료를 징수하고 관리한다.","doWork":"국세청으로부터 정기적으로 고용보험 및 산재보험에 가입한 지역별 사업장목록을 전달받는다. 징수대상 여부를 다시 확인하고 전산정보에 등록한다. 사업주에게 보험료 신고를 받고 위탁금융기관으로부터 납부내역을 통보받는다. 보험료의 증감내역에 따른 정산을 실시한다. 징수사항을 전산처리하고 미납금에 대한 가산금을 고지한다. 정부가 부과하는 보험료를 위탁금융기관을 통해 징수하고 징수내용을 전산처리한다. 납부내역을 관리하여 미납업체에게 독촉장을 발송한다. 이후에도 보험료를 납부하지 않은 경우, 압류예고통지를 한다. 최종적으로 보험료를 미납한 사업장에 대해 압류를 실시하고 압류할 재산이 없는 경우, 결손처분한다. 보험징수의 현황통계표를 작성하고 관리한다. 기업체의 보험료 적정납부실태를 확인·지도한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"비교","workFunc2":"설득","workFunc3":"관련없음","connectJob":"담당업무에 따라 건강보험징수원, 국민연금징수원, 고용보험징수원","dJobECd":"0323","dJobECdNm":"[0323]보험 심사원 및 사무원","dJobJCd":"3202","dJobJCdNm":"[3202]보험 심사원 및 사무원","dJobICd":"K651","dJobICdNm":"[K651]보험업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006483:1', '{"dJobCd":"K000006483","dJobCdSeq":"1","dJobNm":"사회보장사업장자격관리원","workSum":"사회보장보험(국민건강보험, 국민연금, 고용보험, 산재보험) 대상 사업장의 자격관리를 위하여 사업장 신규가입·탈퇴·변동현황을 파악하여 처리한다.","doWork":"국민건강보험, 국민연금, 고용 및 산재보험의 자격대상이 되는 사업장의 편입·휴업·폐업신고서를 접수한다. 미신고 사업장을 발굴하고, 사회보장보험에 가입하도록 가입요청공문서를 보낸다. 접수된 신고서를 확인하여 전산에 입력하고 보존한다. 탈퇴사업장의 신고서를 접수하고, 휴·폐업사실을 조사한다. 대상별로 관리대장을 관리한다. 사업장의 가입자 자격변동사항을 확인하여 전산처리한다. 정기적으로 해당 지역 사업장의 가입, 휴업, 폐업 등의 통계를 조사하여 현황을 파악하고 기록·보관하며 관련 부서에 전달한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"대상에 따라 건강보험사업장자격관리원, 국민연금사업장자격관리원, 고용보험사업장자격관리원, 산재보험사업장자격관리원","dJobECd":"0323","dJobECdNm":"[0323]보험 심사원 및 사무원","dJobJCd":"3202","dJobJCdNm":"[3202]보험 심사원 및 사무원","dJobICd":"K651","dJobICdNm":"[K651]보험업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001494:1', '{"dJobCd":"K000001494","dJobCdSeq":"1","dJobNm":"산재보험사후보상관리원","workSum":"산재보험가입자의 급여사후 관련 통보서·신고서 등의 자료를 관리하고 적용대상을 확인한다.","doWork":"산재보험가입자의 급여사후 관련 통보서 및 신고서를 접수하고 근로자의 재해를 확인한다. 재해근로자의 급여사후 관련 적용대상을 확인한다. 수급권자에게 급여청구안내를 해주는 등 사후관리를 한다. 급여 관련 문의에 대한 회신을 해주고 전산통계를 관리한다. 급여사후 관련 결정변경내역 및 결정유예자를 관리한다. 보험급여 사후관리에 관한 사항(사후조사, 사후관리건 발췌 및 기관통보 등)을 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0323","dJobECdNm":"[0323]보험 심사원 및 사무원","dJobJCd":"3202","dJobJCdNm":"[3202]보험 심사원 및 사무원","dJobICd":"K651","dJobICdNm":"[K651]보험업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001645:1', '{"dJobCd":"K000001645","dJobCdSeq":"1","dJobNm":"송무담당원","workSum":"사고가 발생하여 피보험자가 보험금 지급을 접수하면 손해상황을 확인하고 적정한 지불보험금을 산출한다.","doWork":"보험사고의 통보를 접수하면 보험계약사항과 손해청취보고서에 따른 사고내용을 파악한다. 피보험자가 청약 시 고지한 내용을 확인한다. 부보(Cover:보험의 보장 내용) 여부, 계약유지사항, 부보조건 등 청약사항과 보험사고에 관련된 사항을 확인하여 보상 여부를 판단한다. 피보험자의 사고내용사실확인원 및 사고처리내용원 등 보험사고와 관련한 증빙서류 제출을 통보한다. 증빙서류를 확인하여 보상해야 할 보험사고로 판단되면 손해처리접수대장에 사고사항을 기재하여 보고서를 작성한다. 손해액수가 큰 대형사고의 경우에는 별도의 보고서를 작성한다. 손해통보접수 시에 확인한 손해정도나, 현장조사 가능 여부와 기타 여건에 따라 현장조사자를 선정한다. 사고의 특성에 따라 전문적인 손해사정인과 기타 전문가의 조사가 필요한 것은 적임자를 선정하여 조사를 의뢰하고 실질손해액과 가액을 조사한다. 보험금이 결정되면 피보험자에게 결정내용을 통지하고 규정된 기일 내에 보험금을 지급하도록 조치한다. 보험사에 따른 보험금지급계약이 재보험처리(보험회사가 인수한 계약의 일부를 다른 보험회사에 인수시키는 것)된 경우에는 재보험특약서에 지정된 기일까지 재보험금의 지급청구를 한다. 보험금 지급 후에는 잔존 보험금액의 유무에 따라 관련 부서에 지급보험금통보와 배서조치를 하고, 특히 도난사고 등은 경찰서에 업무협조요청을 한다. 현장조사 결과, 적용요율에 착오가 발견되면 차액을 추징하고, 환급보험료의 발생에 대한 업무처리와 잔존물 발생 시 매각에 따른 업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"보험료산출사무원, 손해보험료산출사무원","dJobECd":"0323","dJobECdNm":"[0323]보험 심사원 및 사무원","dJobJCd":"3202","dJobJCdNm":"[3202]보험 심사원 및 사무원","dJobICd":"K651","dJobICdNm":"[K651]보험업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003372:1', '{"dJobCd":"K000003372","dJobCdSeq":"1","dJobNm":"재보험사무원","workSum":"신규가입된 보험을 재보험협약에 따라 국내외 신계약 가입과 유지계약에 대한 재보험료의 계산·지급과 재보험금의 청구업무를 수행한다.","doWork":"재보험(보험사가 다른 보험사에 보험을 일부 추가로 가입하는 것)의 수지개선을 도모하고 위험을 분산하기 위하여 재보험협약을 관리한다. 인수한 신계약을 협약서에 따라 국내외에 출재(국내보험사가 해외재보험사에 보험을 가입)하거나 수재(해외보험사의 재보험을 받는 것) 관련 업무를 한다. 유지되고 있는 재보험계약에 대한 재보험료를 계산·지급하여 재보험을 유지한다. 보험계약의 변경사항이 발생한 계약은 변경내역에 따라 환수(또는 환급)보험료를 계산하여 수취(또는 지급)토록 한다. 재보험금의 지급사유가 발생한 재보험계약은 재보험금을 청구하여 수취한다. 외국과의 재보험거래를 다변화하기 위하여 해외시장조사를 계속하고 협약체결을 추진한다. 외국재보험사와의 출재분(고객의 보험료 중에서 외국보험회사에 가입하는 비율)과 보유분(고객의 보험료 중에서 외국보험회사에 가입하고 남는 비율)의 적절한 관리를 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"재보험종류에 따라 재재보험사무원, 단체재보험사무원,재보험의 출재나 유치에 따라 재보험수재사무원, 재보험출재사무원","dJobECd":"0323","dJobECdNm":"[0323]보험 심사원 및 사무원","dJobJCd":"3202","dJobJCdNm":"[3202]보험 심사원 및 사무원","dJobICd":"K652","dJobICdNm":"[K652]재 보험업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003872:1', '{"dJobCd":"K000003872","dJobCdSeq":"1","dJobNm":"결산사무원","workSum":"영업일 거래마감 후 대체입출금 금액의 일치 여부, 출납일계표와의 현금입출금액 및 당일 잔액의 일치 여부를 확인한 후 당일 계산을 마감하고 전표관리, 매월 결산 총괄업무를 수행한다.","doWork":"영업시간 마감 전에 각 계에서 거래가 완료되어 보관 중인 전표를 수합하고 내용 및 형식을 점검하여 오류 및 미비사항을 검토한다. 수합된 전표는 현금전표와 대체전표로 분류한다. 현금전표는 입금표와 출금표로 재분류하며 대체전표는 대·차변금액의 일치 여부를 검산하여 과목별로 분류한 전표를 집계한다. 각 전표의 금액을 전표총괄표에 기재하여 일일마감을 하고 손익분류표에 의거, 손실금 및 이익금을 각 항목별로 산출한다. 월말마감 및 원장을 마감하여 확인하고 이월한다. 각 계정과목별로 과거의 증감실적을 감안하여 가결산을 추계하여 손익을 예상한다. 장부기록의 정리, 미결산계정의 정리, 미달환(해외의 예치환거래은행에 개설되어 있는 외화예치금계정은 거리가 멀리 떨어져 있어서 대·차기사항이 외국환은행의 그것과 일치하지 않는 경우)의 정리, 손익계정의 보증, 자산상각 등 결산 사전준비를 관계규정에 의거 실시하고 본결산업무를 수행한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"계산","workFunc2":"설득","workFunc3":"단순작업","dJobECd":"0321","dJobECdNm":"[0321]은행 사무원","dJobJCd":"3203","dJobJCdNm":"[3203]은행 사무원","dJobICd":"K641","dJobICdNm":"[K641]은행 및 저축기관","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004543:1', '{"dJobCd":"K000004543","dJobCdSeq":"1","dJobNm":"공과금담당원","workSum":"업무대행계약에 따라 제세공과금을 수납하기 위하여 국고, 시공금, 전화요금 등의 수납 및 관리업무를 수행한다.","doWork":"공과금 수납업무가 씨디기(CD기), 공과금수납기 등 자동화기기를 통하여 자동화되어 있으나 예외적으로 국고금수납자로부터 국고금수납고지서를 받아 국고자금을 수납하고 영수증을 교부한다. 당일의 국고수납금을 국고수납점 앞으로 전금(선금)처리하고 영수필통지서는 각 해당 세입관서 앞으로 송부한다. 기타 시공금(시세, 오물세, 수도세, 시청료, 전기료) 등의 공과금을 수납하여 영수증을 교부한다. 수납한 공과금을 수납코드에 맞추어 입력한다. 수납금액을 관계기관의 예금구좌 또는 자기앞수표로 송금처리한다. 공과금 수납·시공금집계표를 분류하여 보관한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"계산","workFunc2":"서비스제공","workFunc3":"수동조작","similarNm":"창구출납사무원","dJobECd":"0321","dJobECdNm":"[0321]은행 사무원","dJobJCd":"3203","dJobJCdNm":"[3203]은행 사무원","dJobICd":"K641","dJobICdNm":"[K641]은행 및 저축기관","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005657:1', '{"dJobCd":"K000005657","dJobCdSeq":"1","dJobNm":"교환어음처리원","workSum":"어음(수표 포함)교환 시 입회하여 교환어음 관련 자료를 접수·배부하고, 교환어음 관련 자료를 집계·확인하여 결제자료를 작성하는 업무를 수행한다.","doWork":"금융결제원 업무로서, 각 은행 간의 수교환, 야간교환, 혼입교환, 내국신용장어음교환 등 각종 어음교환을 위하여 어음교환 담당자들(은행, 금융기관, 기업체 등의 직원)이 어음교환소에 배석하면 입회하여 제출된 교환어음 관련 자료를 접수하고 이상 유무를 확인한다. 접수한 교환어음 관련 자료를 전산처리 및 집계하여 계수를 확인한다. 계수착오분은 해당 은행과 협조하여 정정처리한 다음 어음교환차액결제자료 등 교환어음처리결과 자료를 작성한다. 어음교환차액결제자료는 한국은행으로 보내 각 은행별 차감액을 청산하도록 하며, 기타 교환어음처리 결과자료는 어음교환 입회 시 해당 은행에 배포한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0321","dJobECdNm":"[0321]은행 사무원","dJobJCd":"3203","dJobJCdNm":"[3203]은행 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002839:1', '{"dJobCd":"K000002839","dJobCdSeq":"1","dJobNm":"국민주택기금관리원","workSum":"국민주택기금의 경영전략계획을 세우고 기금조성과 관리, 효율적인 운영에 대해 총괄하는 업무를 수행한다.","doWork":"정부기관으로부터 조성되어 위탁된 국민주택기금의 집행 및 사후관리 등 운용계획을 세운다. 효율적인 기금운용 및 집행을 위한 정책제안을 한다. 임대주택 대출관리업무, 국민주택채권업무, 청약저축통계자료를 작성하며 예탁금과 예금잔액증명서업무 등 기금운용 관련 업무를 수행한다. 기금의 효율적인 운용을 위하여 기금대출제도에 관한 조사연구를 수행하고 기금대출의 심사 및 한도를 관리한다. 기금대출의 횡령 및 부도를 방지하기 위하여 대출사례 등을 보고하고 기금대출제도 개선방안을 제안한다. 기금대출 후 사후관리를 하며 채권회수를 수행한다. 대환업무(기존 채무와 상계하는 것) 실시상의 영업점 추진사항, 유의사항 등 원활한 대환시행을 위한 영업점 창구업무를 지도·관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0321","dJobECdNm":"[0321]은행 사무원","dJobJCd":"3203","dJobJCdNm":"[3203]은행 사무원","dJobICd":"K641","dJobICdNm":"[K641]은행 및 저축기관","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004505:1', '{"dJobCd":"K000004505","dJobCdSeq":"1","dJobNm":"국제증권예탁결제사무원","workSum":"국내투자자의 외화증권투자를 위해 외국에 보관기관을 지정하고 외화증권과 외화자금의 매매거래를 결제하며 취득한 외화증권의 보관 및 동 증권에서 파생되는 권리의 행사, 조세 관련 업무 등을 처리하며, 외국인 보유의 국내증권을 예탁하는 업무를 수행한다.","doWork":"증권회사 등 기관투자자가 증권예탁원에 외화증권계좌를 개설하면 동 계좌를 통해 집중 예탁된 일반투자자 또는 예탁자 자기보유분 외화증권을 관리한다. 일반투자자가 국내증권회사를 통하여 외국증권시장에서 매매거래한 외화증권 및 동 대금의 결제업무를 수행한다. 증권예탁원이 지정한 외국보관기관에 보관된 외화증권의 제반 권리행사업무(원리금, 수익금 및 배당금의 수령, 유무상 증자 등)를 처리한다. 외화증권에서 발생한 소득에 대한 소득발생국가 및 국내에서의 원천징수업무를 처리한다. 외국인 보유의 국내증권을 예탁하고 국내 외국인 투자자의 매매에 따른 결제 및 잔고처리, 권리행사 등의 정보를 제공한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0321","dJobECdNm":"[0321]은행 사무원","dJobJCd":"3203","dJobJCdNm":"[3203]은행 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001407:1', '{"dJobCd":"K000001407","dJobCdSeq":"1","dJobNm":"국제투자신탁사무원","workSum":"국제투자신탁시장을 개척하고 신상품을 개발하며 국제투자신탁 수익증권의 발행 및 매매에 관련된 업무를 수행한다.","doWork":"해외투자시장 개척을 위하여 국제경제, 산업, 금융시장 및 국제투자신탁동향을 파악하고 각국의 성장산업을 조사·분석하여 투자시장을 선정한다. 투자시장과 투자종목을 선정하고 투자금액, 투자기간, 투자계획을 수립한다. 투자위험을 분산하기 위하여 여러 나라에 분산투자한다. 해외 투자자의 국내유치를 위하여 국제투자신탁마케팅계획을 수립하여 실시한다. 국제업무 영역확대 및 해외시장 진출방향을 모색한다. 국제투자신탁의 해외시장동향과 국내증시동향 등을 조사하여 신상품의 개발가능성을 검토하고 관련 기관과 협의를 통하여 신상품을 개발한다. 영문홍보책자를 발간하여 외국의 금융이나 증권기관 및 고객에게 배포하여 국제투자신탁을 소개한다. 국제투자신탁의 신규나 추가설정을 위한 계약을 체결한다. 국제투자신탁 수익증권의 발행 및 매매에 관한 업무를 수행한다. 효율적인 재산운용을 위해 국제투신 펀드별로 투자자문위원회를 정기적으로 개최하고 외국인들의 의견을 신탁재산운용에 반영한다. 해외 주요증권기관들과 정보교환을 통해 효율적 정보를 수집한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0321","dJobECdNm":"[0321]은행 사무원","dJobJCd":"3203","dJobJCdNm":"[3203]은행 사무원","dJobICd":"K641/K661","dJobICdNm":"[K641]은행 및 저축기관 / [K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001977:1', '{"dJobCd":"K000001977","dJobCdSeq":"1","dJobNm":"금고담당은행사무원","workSum":"시, 도, 학교, 법원 등 공공기관의 금고를 담당하며, 금고의 수납, 지급, 마감업무를 수행한다.","doWork":"금고 경리계에서 발행된 지급명령서를 접수하여 지출관의 서명과 인감을 확인한다. 지급명령서에 출납필인과 취급자인을 날인하여 지급장에 기재 후 별도 보관한다. 당일 수입한 총시세와 지급한 세출을 집계하여 세입세출일계표를 작성하고, 금고수입일계전·수입집계표·시공과금수납기입장 등과 함께 책임자 결재에 회부한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"계산","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"담당 기관에 따라 시금고담당원, 도금고담당원, 교육금고담당원, 법원금고담당원","dJobECd":"0321","dJobECdNm":"[0321]은행 사무원","dJobJCd":"3203","dJobJCdNm":"[3203]은행 사무원","dJobICd":"K641","dJobICdNm":"[K641]은행 및 저축기관","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006427:1', '{"dJobCd":"K000006427","dJobCdSeq":"1","dJobNm":"금융고객관리사무원","workSum":"고객정보를 분석하여 신규고객을 유치하거나 기존고객을 관리한다.","doWork":"고객을 유치하기 위해 마케팅 프로모션을 기획한다. 기존 고객의 특성을 분석하여 프로모션의 테마를 개발하고 거래를 심화할 수 있는 전략을 추진한다. 국내외 시장을 조사·연구하여 신규고객시장을 분석하고 신규고객 유치방법을 개발한다. 최적의 회원 효율화 방안을 발굴한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"협의","workFunc3":"관련없음","similarNm":"CRM(Customer Relationship Management)담당원","dJobECd":"0321","dJobECdNm":"[0321]은행 사무원","dJobJCd":"3203","dJobJCdNm":"[3203]은행 사무원","dJobICd":"K","dJobICdNm":"[K]금융 및 보험업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003361:1', '{"dJobCd":"K000003361","dJobCdSeq":"1","dJobNm":"금융기관지점관리사무원","workSum":"지역사업부의 관할하에 있는 지점 및 점포의 운영과 실적을 관리하며 영업점교육을 실시하는 업무를 수행한다.","doWork":"금융기관(일반은행, 특수은행, 비은행예금취급기관, 보험사, 증권사, 카드사 등) 각 지점의 직무별 직원 및 정원을 관리한다. 각 지점별 지점운영평가를 실시하여 지점의 판매실적등급을 사내에 공시한다. 우수지점 및 우수사원을 선정하여 공시하며 포상제도에 따라 포상한다. 지점의 월별 실적을 분석하여 판촉계획을 세우고 지도한다. 영업전략에 대한 지점별 교육계획을 수립하고 실시한다. 영업점의 민원사항을 접수하고 개선방안을 마련하여 조치한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0321","dJobECdNm":"[0321]은행 사무원","dJobJCd":"3203","dJobJCdNm":"[3203]은행 사무원","dJobICd":"K","dJobICdNm":"[K]금융 및 보험업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002340:1', '{"dJobCd":"K000002340","dJobCdSeq":"1","dJobNm":"금융대출감정사무원","workSum":"연체 시의 대출금 회수를 위한 대출담보물의 가격을 감정하기 위해 현황을 조사하고 평가한다.","doWork":"창구사무원이나 관계부서로부터 담보물감정의뢰서를 접수한다. 자체처리가 가능한 물건은 감정업무처리일지에 기입하고, 부적격한 물건은 의뢰부서로 반송문서를 작성하여 반송한다. 도면에 의해 개략적인 위치와 지가를 사전검토하고 현장답사일정을 결정한다. 현장에 가서 실측을 하고 입지조건, 토지의 고저, 배수로, 도로상황, 수요 및 장래성, 유입 시 처분 및 관리방법 등을 조사한다. 공부열람 및 현장조사결과와 전국 토지시가조사표 금액 및 가격도면에 의거하여 감정표, 위치도, 지적 및 건물개황도를 작성하고 감정평가서 소정의 제장표 작성을 완료한다. 작성완료된 감정평가서제장표를 편철하고 감정서 검산절차를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0321","dJobECdNm":"[0321]은행 사무원","dJobJCd":"3203","dJobJCdNm":"[3203]은행 사무원","dJobICd":"K641/K649/K661","dJobICdNm":"[K641]은행 및 저축기관 / [K649]기타 금융업 / [K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004394:1', '{"dJobCd":"K000004394","dJobCdSeq":"1","dJobNm":"금융위험모니터링원","workSum":"은행 및 증권사의 자산운용과 영업행위과정에서 발생가능한 각종 위험을 모니터링한다.","doWork":"은행 및 증권사에서 운용 중인 고유자산현황을 파악하고 발생가능한 각종 위험을 모니터링한다. 모니터링한 사항을 보고서로 작성하여 보고한다. 영업행위과정에서 발생가능한 각종 위험을 조사하여 시장위험관리사무원에게 제공하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"감독","workFunc3":"관련없음","similarNm":"리스크모니터링원","dJobECd":"0321","dJobECdNm":"[0321]은행 사무원","dJobJCd":"3203","dJobJCdNm":"[3203]은행 사무원","dJobICd":"K641/K649","dJobICdNm":"[K641]은행 및 저축기관 / [K649]기타 금융업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003225:1', '{"dJobCd":"K000003225","dJobCdSeq":"1","dJobNm":"단기상품예탁관리사무원","workSum":"예탁자로부터 양도성예금증서(CD), 신종기업어음(CP), 환매조건부채권(RP), 은행인수어음(BA), 수익증권 등 단기상품을 예탁받아 관리한다.","doWork":"고객으로부터 양도성예금증서(CD), 신종기업어음(CP), 환매조건부채권(RP), 은행인수어음(BA), 수익증권 등 단기상품의 예탁을 의뢰받는다. 단기상품의 하자, 위조 및 이상 유무를 확인하여 접수하고 예탁증명서를 발급한다. 접수받은 단기상품의 각 종목 파일을 구성하여 상품관리 파일프로그램에 입력 및 기록한다. 위조유가증권의 감별 및 마이크로촬영 등을 실시한다. 이상 유무를 확인한 후 금고관리부서로 이관한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0321","dJobECdNm":"[0321]은행 사무원","dJobJCd":"3203","dJobJCdNm":"[3203]은행 사무원","dJobICd":"K641/K649/K661","dJobICdNm":"[K641]은행 및 저축기관 / [K649]기타 금융업 / [K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006778:1', '{"dJobCd":"K000006778","dJobCdSeq":"1","dJobNm":"담보물감정사무원","workSum":"연체금 회수 목적인 담보물에 대한 가격을 감정하기 위하여 현황을 조사·평가하는 업무를 수행한다.","doWork":"여신사무원 또는 관계부서로부터 감정의뢰서를 접수하여 자체처리 가능한 물건은 감정업무처리일지에 기입하고, 부적격한 물건은 의뢰부서로 반송문서를 작성하여 반송한다. 관계공문서(건물등기부등본, 건축물대장, 도시계획확인원 등)를 발부받아 지번, 평수, 권리권 등을 확인한다. 1차로 관계공문서를 기준으로 탁상감정가격을 산정하거나 제휴업체에 탁상감정을 의뢰하여 탁상감정가를 추정한다. 도면에 의해 개략적인 위치와 지가를 사전검토하여 현장실사일정을 결정하고 권리자에게 실사일정을 통보한다. 필요장비(신분증, 카메라, 실측자 등)를 준비하여 현장에 출장을 가서 실측을 하고 입지조건, 토지의 고저, 배수로, 도로상황, 수요 및 장래성, 유입 시 처분 및 관리방법 등을 조사한다. 공부열람 및 현장조사결과와 전국토지시가조사표 금액 및 가격도면에 의거하여 감정표, 위치도, 지적 및 건물개황도를 작성하고 전산으로 감정평가서 작성을 완료한다. 작성 완료된 감정평가서를 출력하여 날인·서명하고 편철(정리하여 잘 묶음)한다. 동료 감정사무원과의 교차감정을 통하여 감정서의 최종 검산절차를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0321","dJobECdNm":"[0321]은행 사무원","dJobJCd":"3203","dJobJCdNm":"[3203]은행 사무원","dJobICd":"K641/K649/K661","dJobICdNm":"[K641]은행 및 저축기관 / [K649]기타 금융업 / [K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002063:1', '{"dJobCd":"K000002063","dJobCdSeq":"1","dJobNm":"명의개서대행사무원","workSum":"발행회사와의 위탁계약에 따라 유가증권의 명의개서업무를 수행한다.","doWork":"위탁회사(명의개서를 청구한 회사)와의 계약에 의해 주주명부, 실질주주명부 또는 사채원부의 작성 및 관리업무, 증권의 명의개서·질권의 등록 또는 말소 및 신탁재산의 표시 또는 말소 관련 업무, 명의개서에 관한 제청구 및 신고의 처리 관련 업무, 명의개서에 관한 통계, 통지 및 최고(공시최고) 업무를 수행한다. 증권발행대행업무를 수행하는 경우 증권용지의 신청·수령 및 가쇄, 예비증권의 보관, 증권의 발행과 관련된 제통지 및 최고, 증권의 발행 및 교부, 회수된 증권의 폐기 관련 업무를 수행한다. 주식배당금 및 사채원리금 지급대행업무를 수행하는 경우 주식배당금 및 사채원리금의 계산, 주식배당금 및 사채원리금의 지급대장 작성, 통지서 및 영수증의 작성 및 발송, 주식배당금 및 사채원리금의 지급업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0321","dJobECdNm":"[0321]은행 사무원","dJobJCd":"3203","dJobJCdNm":"[3203]은행 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004717:1', '{"dJobCd":"K000004717","dJobCdSeq":"1","dJobNm":"무역금융사무원","workSum":"은행에서 기업고객의 기업금융거래와 연관된 외환거래 및 기업의 영업활동에 수반되는 외환거래업무를 담당한다.","doWork":"외환거래의 법적 적정성 여부를 판단한다. 외환거래 관련 서류를 심사 및 작성한다. 외환거래에 수반되는 전반적인 운영업무를 진행한다. 외환거래대금 및 수수료를 수령한다. 미달환(해외의 예치환 거래은행에 개설되어 있는 외화예치금계정은 거리가 멀리 떨어져 있어서 대·차기사항이 외국환은행의 그것과 일치하지 않는 경우)을 수시로 점검한다. 무역외거래의 경우 신고를 수리하고 사후관리업무를 수행한다. 무역업무자동화를 관리한다. 수출입금융 관련 환거래은행 앞으로 신용공여업무(신용장 확인, 보증, 인수 및 Risk Participation)를 수행한다. 국내 거주자의 해외투자사업에 대한 신고수리업무를 수행한다. 외국인투자의 신고수리업무를 수행한다. 기업금융과 연관된 외환거래의 경우 매 건별로 기업금융 승인 여부를 확인한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"은행무역금융담당자","dJobECd":"0321","dJobECdNm":"[0321]은행 사무원","dJobJCd":"3203","dJobJCdNm":"[3203]은행 사무원","dJobICd":"K641","dJobICdNm":"[K641]은행 및 저축기관","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004138:1', '{"dJobCd":"K000004138","dJobCdSeq":"1","dJobNm":"벤처자금대출원","workSum":"성장잠재력과 기술력을 보유한 우량 벤처기업이나 중소기업에 대한 발굴, 사업성 심사, 투자실행 등 투자펀드업무를 기획·관리한다.","doWork":"대출요청서 및 사업계획서를 수령하여 기본사항을 검토한다. 경영자 및 주요 경영인력과 면담하여 경영마인드를 검증한다. 투자사업의 사업성, 시장성, 기술성, 재무분석, 수익성 등을 파악하여 투자적격업체를 인지, 심사한다. 벤처기업가치를 측정·산정하고 현장실사를 실시하여 서류상의 생산현장 일치 여부를 확인한다. 투자형식 및 조건을 검토하여 경영자측과 협상·결정 후 투자를 실행한다. 검토 및 협의결정기준에 의하여 운영자금, 시설자금, 연구지원자금 등으로 구분하여 규모와 지급시기를 결정한다. 투자계약서를 작성하고 주금납입, 주주등재 등의 부수업무를 수행한다. 회계 및 업무감사, 사후관리기록부 작성 등 지속적인 사후관리를 한다. 투자자금회수전략을 수립한다. 업종별 동향파악 및 산업 관련 자료를 수집하고 투자설명회를 개최하는 등 투자마케팅업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"협의","workFunc3":"관련없음","similarNm":"Venture Capital 담당원","connectJob":"투자심사역","dJobECd":"0321","dJobECdNm":"[0321]은행 사무원","dJobJCd":"3203","dJobJCdNm":"[3203]은행 사무원","dJobICd":"K641","dJobICdNm":"[K641]은행 및 저축기관","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006125:1', '{"dJobCd":"K000006125","dJobCdSeq":"1","dJobNm":"복권사무원","workSum":"복권상품과 제도를 개발하고 복권발행을 기획·관리하며 관련 마케팅업무를 수행한다.","doWork":"국내외 복권제도 및 상품자료와 정보를 수집하여 국내상황에 적절한 상품을 연구·개발한다. 복권사업의 예산계획을 수립·집행한다. 복권제도의 조사·연구를 통해 복권상품 및 제도를 개발한다. 각종 복권의 연간발행계획을 수립한다. 판매전략 수립, 점포영업지도, 시장조사 등 마케팅전략을 수립한다. 판매촉진을 위한 섭외와 판매업체 및 판매인을 관리하며 복권수급업무를 담당한다. ‘복권 및 복권기금법’에 따라 복권의 회계 및 결산업무를 수행한다. 복권판매 실적, 복권수익금, 복권운용수익금 등의 복권기금의 집행실적을 통계하며 관리한다. 도박성, 사행성 위주의 복권사업을 건전한 사업으로 변화시키고자 홍보마케팅을 수립한다. 로또복권, 연금복권 등을 개발하는 업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0321","dJobECdNm":"[0321]은행 사무원","dJobJCd":"3203","dJobJCdNm":"[3203]은행 사무원","dJobICd":"O842","dJobICdNm":"[O842]사회 및 산업정책 행정","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004817:1', '{"dJobCd":"K000004817","dJobCdSeq":"1","dJobNm":"부도관리사무원","workSum":"부도어음과 부도수표의 집중관리, 어음(수표포함, 이하동일) 거래정지정보의 작성 및 제공, 미결제어음 및 부도어음 통보시각 조정, 부도거래자의 제재조치에 관한 업무를 수행한다.","doWork":"금융결제원 업무로서, 각 은행으로부터 전송받거나 서면으로 제출받은 부도어음신고내역과 부도어음대금입금내역 등을 부도관리시스템에 입력하여 정상처리 유무를 확인하고 해당 은행에 확인하여 정정한다. 정정작업이 완료되면 부도정보 집중관리시스템인 부도관리시스템에 거래정지자내역과 부도어음대금 입금자내역 등 부도정보를 확정·등록한다. 거래정지자에 대해서는 일정기간 어음거래를 중지하고, 기타 부도정보에 대해서는 어음거래 시 참고하도록 각 은행에 부도정보를 제공한다. 한편, 각 은행의 부도업무 수행 소홀이나 어음교환업무규약 위반에 대한 제재를 위해 제재금내역을 작성·부과한다. 어음발행자의 귀책사유로 부도를 발생시킨 어음부도자에 대한 제재를 위해 과태금내역을 작성·부과한다. 은행으로부터 미결제어음 및 부도어음 통보시각에 대하여 조정요청이 있을 경우 이를 접수하여 결재권자의 승인을 얻고, 동 시각이 조정될 경우 조정사유 및 시각을 각 은행에 유선통지 및 전산등록하여 그 조정시각까지 어음 최종소지인의 자금인출을 정지하도록 한다. 기타 참가은행으로부터 부도취소·정정요청, 부도 관련 문의 등이 있을 경우 접수·처리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0321","dJobECdNm":"[0321]은행 사무원","dJobJCd":"3203","dJobJCdNm":"[3203]은행 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004317:1', '{"dJobCd":"K000004317","dJobCdSeq":"1","dJobNm":"부실채권관리사무원","workSum":"부실발생(부도, 법정관리, 회생절차 등)한 고객의 회사정상화 및 채권회수를 위한 최적의 조건을 도출하고 정리계획안에 대한 이해당사자의 이해관계를 조정하는 업무를 수행한다.","doWork":"부실채권의 범위를 규정하고 여러 형태의 대규모 금융여신에 대한 이자 및 원리금상환이 불가능한 규모가 큰 부실채권이 발생하여 채무기업의 정상회생이 불가능한 경우 내부회의를 개최하여 금융관리대상선정, 구조조정방안, 법정관리, 3자인수, 추가 금융지원 등 채권회수관리방법에 대하여 논의한다. 채권회수관리방법이 결정되면 부실기업체 채권 및 담보내용을 정리하고 법원 앞으로 채권신고를 한다. 기업정상화 가능성을 검토하고 정리계획안을 협의한다. 관계인집회에 참석하여 채권자의견을 조정하고 정리계획안을 마련하여 기업정상화 금융승인신청서를 작성한다. 변경사항이 있는 경우 조건변경승인신청서를 작성하고 변경약정을 체결한 후 전산원부를 수정한다. 국제부실자산 매각업무도 수행한다. 채무회사의 재무건전성이 향상되면 단계적으로 관리방법을 해제하여 채무회사의 정상적인 기업회생을 위하여 조치하고 관리한다. 대출 관련 사전·사후관리시스템의 비효율성 및 문제점을 발굴하여 보완 및 수정안을 수립한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0321","dJobECdNm":"[0321]은행 사무원","dJobJCd":"3203","dJobJCdNm":"[3203]은행 사무원","dJobICd":"K641/K661","dJobICdNm":"[K641]은행 및 저축기관 / [K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001490:1', '{"dJobCd":"K000001490","dJobCdSeq":"1","dJobNm":"사업자금대출원","workSum":"사업자금(PF:Project Finance) 적용 대상사업(SOC:민영화, 구조조정사업 등) 개발, 사업성 검토, 관련 금융기법 및 조건의 연구·개발을 실시하여 국내외 금융기관의 금융지원 참여를 유도하며, 거액이 투자되는 프로젝트에 대한 자금조달의 다양화를 추진하는 일을 수행한다.","doWork":"금융대출대상사업에 대한 정보수집 및 예비사업성 검토, 재원조달방안 수립, 사업리스크 관리방안 제시 등 금융자문을 실시한다. 대출요청서와 사업계획서를 수렴하여 기본사항을 검토한다. 경영자 및 주요 경영인력과 면담하여 경영마인드를 검증한다. 해당 사업의 사업성, 시장성, 기술성, 재무분석, 수익성 등을 파악하여 금융대출적격업체를 심사한다. 창업회사인 경우 보유기술력, 상업성, 시장성의 기준을 중점심사한다. 기업가치를 측정·산정하고 현장실사를 실시하여 서류상의 생산현장 일치 여부를 확인한다. 대출방법 및 조건을 경영자측과 협상, 결정 후 금융대출을 실행한다. 검토 및 협의결정기준에 의하여 운영자금, 시설자금, 연구지원자금, 공사부지매입대금 등으로 구분하여 규모와 지급시기를 결정한다. 회계 및 업무감사, 사후관리기록부 작성 등 지속적인 사후관리를 하고 대출자금 회수전략을 수립한다. 승인신청서를 작성한 후 융자약정을 체결함과 동시에 담보설정 등 채권보전책을 강구한다. 원리금납입기일 통지 및 수납, 차주사(채무자)재무, 경영활동의 동향파악 등 사후관리를 한다. 인프라펀드(Infra Fund)설립기본안을 작성하고 설립을 위한 제반 행정절차를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"협의","workFunc3":"관련없음","similarNm":"Project Finance 담당원","dJobECd":"0321","dJobECdNm":"[0321]은행 사무원","dJobJCd":"3203","dJobJCdNm":"[3203]은행 사무원","dJobICd":"K641","dJobICdNm":"[K641]은행 및 저축기관","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004378:1', '{"dJobCd":"K000004378","dJobCdSeq":"1","dJobNm":"산업설비여신자금대출원","workSum":"시설사업(선박, 항공기 또는 기타 산업설비) 관련 자금소요 파악 및 현금흐름(Cash Flow) 분석을 통해 최적의 금융구조를 개발하고 각종 통제장치의 마련 및 상황변화에 따른 대안을 강구하는 일을 수행한다.","doWork":"잠재차주 및 주요고객(항공 및 해상운송, 정유, 제약, 화학플랜트사업체 등)을 대상으로 여신마케팅전략을 수립하여 마케팅을 실시한다. 대상사업에 대한 정보수집 및 금융구조 수립, 분석 등 금융자문을 한다. 대출요청서와 사업계획서를 수렴하여 기본사항을 검토한다. 경영자 및 주요 경영인력과 면담하여 경영마인드를 검증한다. 해당 사업의 사업성, 시장성, 기술성, 재무분석, 유동성, 수익성 등을 파악하여 산업설비 대출적격업체를 심사한다. 기업가치를 측정·산정하고 현장실사를 실시하여 서류상의 생산설비현장 일치 여부를 확인한다. 대출방법 및 조건(대출금의 규모와 지급시기)을 경영자측과 협상하여 결정한 후 심사요청서를 작성한다. 승인신청서를 작성한 후 대출약정을 체결함과 동시에 담보설정 등 채권보전책을 강구한다. 심사결정승인 후 산업설비자금을 대출한다. 회계 및 업무감사, 사후관리기록부 작성 등 지속적인 사후관리를 하고 대출자금회수전략을 수립한다. 원리금납입기일 통지 및 수납, 차주사(채무자) 재무, 경영활동의 동향파악 등 사후관리를 한다. 지원대상 사업과 기업체에 대한 사업성, 재무분석 등 적절성을 검토하고 심사요청서를 작성한다. 융자약정을 체결하고 채권보전책을 강구한다. 자금인출, 원리금납입기일 통지 및 수납, 차주사 동향파악, 조기경보체제 구축과 같은 사후관리를 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"협의","workFunc3":"관련없음","similarNm":"Lease Finance 담당원","dJobECd":"0321","dJobECdNm":"[0321]은행 사무원","dJobJCd":"3203","dJobJCdNm":"[3203]은행 사무원","dJobICd":"K641","dJobICdNm":"[K641]은행 및 저축기관","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007163:1', '{"dJobCd":"K000007163","dJobCdSeq":"1","dJobNm":"수신금리기획원","workSum":"수신금리 운영방향, 수신금리결정, 비용률 관리 등을 통해 저비용 재원조달을 도모하는 업무를 수행한다.","doWork":"중앙은행의 금리변동정책, 정부의 금융경제정책 등을 기반으로 수신금리의 변동상황을 주시하고 예측한다. 자금수급여건 및 타 은행의 금리운용사례를 고려한 수신금리 운용방향을 수립·시행한다. 자금시장 및 자금흐름 분석, 금융정책변화에 따른 수신금리 관련 대응방안 연구, 금융시장의 환경분석을 수행한다. 여신금리, 신규예금상품, 여신처의 확보 및 수익성을 고려하여 수신금리의 이율을 조정한다. 정기예금상품, 일반예금상품, 산업금융채권 발행금리, 단기수신상품 및 예금상품 등의 수신금리를 결정한다. 자금조달비용률을 산출하고 분석·관리한다. 결정된 수신금리를 영업점에서 적용·사용하도록 지도한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0321","dJobECdNm":"[0321]은행 사무원","dJobJCd":"3203","dJobJCdNm":"[3203]은행 사무원","dJobICd":"K641","dJobICdNm":"[K641]은행 및 저축기관","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003618:1', '{"dJobCd":"K000003618","dJobCdSeq":"1","dJobNm":"수신사무관리자","workSum":"고객의 요구에 맞는 수익성 높은 수신상품을 개발하고 제도를 개선하는 등 수신 관련 업무를 총괄한다.","doWork":"새로운 수신상품 및 서비스를 개발한다. 수신상품가격, 수수료결정 및 고금리운영업무를 담당한다. 제도와 업무처리절차를 개선한다. 수신고객의 신용정보를 교환하고 관리한다. 수신금융 관련 통계자료를 작성한다. 정책상품을 공동으로 개발한다. 인터넷 판매업무를 지원한다. 고객의 민원접수와 처리를 지원한다. 상품 및 서비스에 관해 상담한다. 세금과 금융실명제 관련 업무를 총괄한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0321","dJobECdNm":"[0321]은행 사무원","dJobJCd":"3203","dJobJCdNm":"[3203]은행 사무원","dJobICd":"K641","dJobICdNm":"[K641]은행 및 저축기관","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005798:1', '{"dJobCd":"K000005798","dJobCdSeq":"1","dJobNm":"수신사무원","workSum":"고객(개인, 기업)의 수신상담, 예수금 및 채권 등의 통장(증서) 발행·해지·상환, 입출금 등 창구일선업무를 수행하고 주요 증서류관리, 전자금융업무관리, 시재관리, 일일마감 등의 업무를 수행한다.","doWork":"수신상품에 대한 전반적인 업무를 숙지한다. 고객과 상품상담을 한다. 금융실명거래에 의거하여 고객등록 및 관련 제반 서류를 검토한다. 통장, 채권, 증서, 수표 등의 신규발행업무와 해지(상환)업무를 수행한다. 금융거래에 수반되는 현금 또는 수표입출금업무를 수행한다. 자동이체 등 전자금융업무를 수행한다. 현금잔액확인, 중요증서류 잔고확인업무를 수행한다. 금융정보원 기준에 따른 거액창구거래 신고업무를 수행한다. 위폐감별, 일일마감 업무를 수행한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"서비스제공","workFunc3":"수동조작","similarNm":"창구출납사무원, 수신담당사무원, 은행창구사무원,","dJobECd":"0321","dJobECdNm":"[0321]은행 사무원","dJobJCd":"3203","dJobJCdNm":"[3203]은행 사무원","dJobICd":"K641","dJobICdNm":"[K641]은행 및 저축기관","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003432:1', '{"dJobCd":"K000003432","dJobCdSeq":"1","dJobNm":"수신제도기획원","workSum":"수신 관련 각종 금융제도 및 상품연구, 산업금융채권 국내신용평가, 영업전략 수립을 통해 수신제도를 기획한다.","doWork":"산업금융채권 및 예수금 상품개발, 타 금융기관과의 수신 관련 상품제휴, 파생상품을 개발한다. 수신전문인력 선발·운용, 수신점포 설치 및 운영전략 수립, 고객개발전략 수립, 고객에 대한 정보제공 등의 업무를 수행한다. 채권 및 예수금 관련 내규를 제정하고 개정한다. 개발된 수신제도를 영업점에서 적용·사용하도록 지도한다. 신용카드사와 약정을 체결하여 카드업무를 담당하고 인터넷뱅킹업무 기획, 전산개발요건을 정의한다. PC, 폰뱅킹 및 현금카드 관련 내규제정, 운용지침을 수립한다. 고객의 이용편의나 전화사기(보이스피싱) 방지를 고려하여 현금자동입출금기(ATM) 이용한도를 조정하고 기획한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0321","dJobECdNm":"[0321]은행 사무원","dJobJCd":"3203","dJobJCdNm":"[3203]은행 사무원","dJobICd":"K641","dJobICdNm":"[K641]은행 및 저축기관","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001404:1', '{"dJobCd":"K000001404","dJobCdSeq":"1","dJobNm":"수신총괄사무원","workSum":"은행 및 전체 지점별 수신계획을 수립하고 수신유치현황을 관리하는 등 수신 관련 업무를 총괄 지원한다.","doWork":"중장기수신금융업무계획을 수립한다. 수신영업전략회의 및 자금조달전략회의 등을 개최한다. 수신업무와 관련된 각종 보고서를 작성한다. 영업점 마케팅전략을 수립한다. 영업점 교육훈련을 지원한다. 창구업무 및 텔레마케터 교육자료를 지원한다. 은행 전체 및 부점별 수신유치 계획을 세운다. 수신유치실적을 평가하며 부점별 수신실적을 관리한다. 개인별 수신실적을 평가하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0321","dJobECdNm":"[0321]은행 사무원","dJobJCd":"3203","dJobJCdNm":"[3203]은행 사무원","dJobICd":"K641","dJobICdNm":"[K641]은행 및 저축기관","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006866:1', '{"dJobCd":"K000006866","dJobCdSeq":"1","dJobNm":"수입업무금융사무원","workSum":"수입신용장의 개설 및 선적서류인도, 수입어음의 결재 및 외화보증서 발급, 신용장 개설일로부터 인도 시까지 발생하는 미결처리업무, 미달환(해외의 예치환 거래은행에 개설되어 있는 외화예치금계정은 거리가 멀리 떨어져 있어서 대·차기사항이 외국환은행의 그것과 일치하지 않는 경우) 정리업무 등 수입무역에 관련된 금융사무를 수행한다.","doWork":"수·출입 무역회사 등 개설의뢰인의 신용장개설신청서를 접수하여 과거수출실적, 세금납부 여부 등을 심사한다. 과거수출실적을 근거로 일정한 산식에 따라 산정된 원자재금융한도, 생산자금한도 등 무역금융한도 범위 내에서 신용장을 개설해준다. 신용장 개설에 필요사항을 기록하고 신용장 개설수수료, 전신료 등의 수수료를 수납하고 통지은행 앞으로 개설통지를 한다. 선적서류를 접수하여 신용장 조건과 일치 여부를 확인하여 선적서류 수도부(수취부)에 기입한다. 의뢰인에게 전화나 우편으로 선적서류 도착통지 및 수입어음 결제대금을 결제하도록 통지한다. 선적서류수취증을 요구하여 인감대조 및 선적서류접수대장에 기입한 후 선하증권(B/L:Bill of Lading)에 책임자의 배서를 받아 선적서류를 인도한다. 일람불어음(Sight Bill:요구출급어음)의 결재는 선적서류 도착일로부터 일정일 이내에 지불요청하면 결재하도록 한다. 기한부어음은 선적서류 원본도착일에 어음을 인수하며 만기일을 확정하여 수입대금을 결재한다. 사후관리로서 미달환명세표를 인수받아 검토하고 발생요인에 따라 손익금처리 등을 통해 처리한다. 수입무역에 관련한 관계서류를 발급하고 수입무역자격 및 수입상품을 검토 승인하여 수입무역자의 행정적 사무처리를 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"서비스제공","workFunc3":"관련없음","similarNm":"무역사무원, 국제무역사무원","dJobECd":"0321","dJobECdNm":"[0321]은행 사무원","dJobJCd":"3203","dJobJCdNm":"[3203]은행 사무원","dJobICd":"K641","dJobICdNm":"[K641]은행 및 저축기관","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002076:1', '{"dJobCd":"K000002076","dJobCdSeq":"1","dJobNm":"수출업무금융사무원","workSum":"수출환어음 매입 및 사후관리, 신용장 통지 및 신용장 양도 등 수출무역에 관련된 금융사무를 수행한다.","doWork":"화환어음(환어음이 첨부되지 않은 선적서류)의 매입 및 추심 등 수출거래약정 및 체결, 수출신용장의 통지 및 확인, 신용장의 양도, 수출환어음매입, 수출환어음추심(Collection:수금) 등의 업무를 수행한다. 수출환어음을 매입하기 위하여 수혜자로부터 선적서류 및 관계서류를 접수하여 선적서류송부장에 접수처리하고 관계대장에 기장한다. 선적서류송부장의 내용을 검토하고 수수료의 청구 여부 및 어음기일 등을 확인하고 일람불(어음 제출 시 돈을 지급하는 어음)신용장과 기한부신용장으로 구분한다. 수출환어음매입신청서를 포함한 서류를 확인·검토하고 신용장, 환어음 등의 서류를 심사한다. 매입 및 추심방법을 결정하고 선적서류는 개설은행 또는 지급은행 앞으로 송부하여 매입대금을 추심한다. 상대은행으로부터 신용조회가 도착되면 네고(Nego)기입장에 기재하고 매입사무에 수반된 모든 보고서를 작성·발송·관리한다. 수출환어음 매입 후 사후관리를 위하여 기한부매입어음의 기입장에 매입명세서를 기록하고 어음의 인수 여부 및 만기일을 관리한다. 신용장이 당행 앞으로 도착되면 개설은행의 서명을 대조하고 신용장 내용을 검토하여 수출신용장 도착통지기입장에 기입한다. 수출신용장 수혜자를 확인하고 수출신용장수령증을 청구한다. 양도통지서를 통지은행 또는 개설은행 앞으로 발송한다. 수출무역에 관련한 관계서류를 발급한다. 수출무역자격 및 수출품목을 검토·승인하여 수출무역자의 행정적 사무처리를 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"서비스제공","workFunc3":"관련없음","similarNm":"무역사무원, 국제무역사무원","dJobECd":"0321","dJobECdNm":"[0321]은행 사무원","dJobJCd":"3203","dJobJCdNm":"[3203]은행 사무원","dJobICd":"K641","dJobICdNm":"[K641]은행 및 저축기관","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006882:1', '{"dJobCd":"K000006882","dJobCdSeq":"1","dJobNm":"시장위험관리사무원","workSum":"국내외 주식, 선물옵션, 채권, 자금, 외환시장 등에서 예상변화율과 시장가격이 기대했던 방향과 반대로 움직일 경우 손실이 발생할 수 있는데 이와 같은 시장위험을 분석·통제하여 관리하는 업무를 수행한다.","doWork":"한국은행 및 각 경제연구소발간 경제동향, 경제지표, 환율동향예측자료를 참고하여 금융시장 동향을 분석한다. 주식, 선물옵션, 채권, 자금, 외환시장 등에서 시시각각 변화하는 시장위험을 자산운용부서에 대한 모니터링을 통해 인식한다. 리스크모니터링원(금융)으로부터 영업행위 과정에서 발생가능한 각종 위험을 보고받기도 한다. 재무관리이론에 따라 예측되는 위험의 종류를 유형별로 구분한다. 위험요인에 대한 우선순위를 설정한다. 선정된 위험에 대하여 영향을 미치는 변수의 동향, 이자율, 환율의 변화방향, 물가상승률, 기타 경제지표에 대한 정보를 수집·분석하여 장기적인 회사 재무위험 영향을 평가한다. 시장정보 및 회사의 재무상태를 바탕으로 단기(3개월 이내), 중기(1년 이내), 장기(1년 이상)의 재무위험관리정책을 수립한다. 시장의 지표가 중요한 변화를 보일 때 즉시 기존의 위험관리정책에 대하여 재검토한다. 시장위험(손실발생가능상황)이 인식되면 위험측정을 통해 손실발생정도를 예측하고 전체적인 위험평가 및 분석을 수행한다. 현금보유고를 파악하여 자금수지예상계획에 의해 추정된 미래시점별 현금보유액과 회사경영특성을 반영하여 각 시점별 적정현금보유수준을 결정한다. 적정현금보유액의 과부족이 발생할 경우 이를 해결하기 위한 방안을 수립한다. 환차손리스크를 관리하고 부채비율을 관리한다. 파생상품의 계약내용과 관련 위험을 분석하여 대비책을 수립한다. 감독기관(금융감독원)의 규정과 영업용순자본비율(영업용순자본을 총위험으로 나눠 백분율로 표시)을 감안하여 회사의 위험자본을 부서별, 상품별로 배분한 후 이의 적정운용을 통제한다. 금융상품 신상품의 승인을 위해서 혹은 당사가 판매하는 금융상품에 대하여 위험관리를 수행한다. 리스크매니지먼트시스템 및 현재가치의 계산 또는 위험분석을 할 수 있는 애플리케이션프로그램을 활용한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"감독","workFunc3":"관련없음","similarNm":"시장리스크관리사무원","connectJob":"금융상품의 위험관리를 전담하는 경우 금융상품위험관리원","dJobECd":"0321","dJobECdNm":"[0321]은행 사무원","dJobJCd":"3203","dJobJCdNm":"[3203]은행 사무원","dJobICd":"K641/K649/K661","dJobICdNm":"[K641]은행 및 저축기관 / [K649]기타 금융업 / [K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002614:1', '{"dJobCd":"K000002614","dJobCdSeq":"1","dJobNm":"신용위험관리사무원","workSum":"회사의 제반 거래 및 투자에 있어 거래상대방이 계약대로 거래를 이행하지 않을 경우 발생할 수 있는 손실을 방지하기 위하여 신용위험을 측정·통제·관리하는 업무를 수행한다.","doWork":"국내외 투자상품에 대한 정보와 신용정보를 수집·분석·종합한다. 투자상품에 대한 이해를 바탕으로 회사의 거래유형에 따른 필요한 투자상품을 선정한다. 관련 부서로부터 거래종목별, 건별로 신용심사의뢰를 접수한다. 주식이나 채권, 기업어음(CP:Commercial Paper)에 대한 신용위험을 관리하기 위하여 종목 매입 전에 기업신용조사 및 심사를 하여 거래승인 여부, 거래처별 거래한도부여 등을 결정한다. 회사의 위험을 분산(Hedge)하기 위하여 소요되는 투자상품의 규모를 산정한다. 기업공개나 유가증권인수(Underwriting)에 따른 위험을 관리한다. 주식이나 채권발행을 원하는 업체에 대한 신용등급이나 재무제표를 검토한다. 유가증권담보대출 시에도 신용위험을 관리한다. 심사가 이루어지면 신용보고서를 작성하고 승인 여부를 결정하여 해당 부서에 결과를 통보한다. 투자가 이루어지고 난 후에도 기업공개종목이나 채권의 부실화를 막기 위한 방안을 강구하여 대처한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"감독","workFunc3":"관련없음","similarNm":"신용리스크관리사무원","dJobECd":"0321","dJobECdNm":"[0321]은행 사무원","dJobJCd":"3203","dJobJCdNm":"[3203]은행 사무원","dJobICd":"K641/K649/K661","dJobICdNm":"[K641]은행 및 저축기관 / [K649]기타 금융업 / [K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002699:1', '{"dJobCd":"K000002699","dJobCdSeq":"1","dJobNm":"신용조사담당원","workSum":"불량채권의 발생을 방지하기 위하여 신용조사 대상업체에 대한 신용조사와 사업성 검토업무를 수행하여 여신집행의 기초자료로 제공한다.","doWork":"신용기간 연장이나 대출 관련 위험도를 판단하기 위해 신용자료 및 재무제표를 분석한다. 고객의 재무상태를 판단하기 위해 컴퓨터프로그램 등을 이용하여 재정비율을 산출하고 대출의 수익성을 분석한다. 고객기록을 평가하고 수입, 저축자료, 지불내역 및 구매활동에 기초해 지급계획을 추천한다. 신용분석, 대출청구내용 요약을 포함한 대출신청서를 작성하고 승인을 받기 위하여 대출위원회에 제출한다. 신용정보를 교환하기 위해 신용협회 및 기타 기업대표들과 협의한다. 수금불량계좌를 파악하고 선별하기 위해 개인이나 거래고객 서류철을 검토한다. 고객불만을 해결하고 금융 및 신용거래를 확인하며, 필요시 거래를 조정하기 위해 고객과 상의한다. 신용조사의뢰서를 접수하고 관계서류의 내용을 검토하여 조사대상업체의 개략적 상황을 분석한 후 문제점 및 중점조사할 내용을 파악한다. 조사대상사업체를 방문하여 면접 및 실사 등을 통해 업체의 전반적 현황을 파악·확인하고 결과를 종합·분석하여 신용조사서와 신용조사카드를 작성·보관한다. 조사된 각종 자료를 동 업체나 기타 지수와 비교하여 신용분석을 한다. 각종 조사자료(업체형태 및 개요, 조업현황 및 전망, 담보능력, 대금지불능력, 재무상태, 은행거래상황, 동 업계의 전망, 업체의 상도덕성 등)를 기술하고 신용평가를 실시하여 신용조사를 의뢰한 부서에 회보한다. 신용조사를 필한 업체에 대해 수시 또는 정기적으로 실태조사를 실시하여 변동사항을 수정·보완하고 신용조사업무 수행에 필요한 자료를 수집한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"신용조사원","dJobECd":"0321","dJobECdNm":"[0321]은행 사무원","dJobJCd":"3203","dJobJCdNm":"[3203]은행 사무원","dJobICd":"K641/K649","dJobICdNm":"[K641]은행 및 저축기관 / [K649]기타 금융업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002556:1', '{"dJobCd":"K000002556","dJobCdSeq":"1","dJobNm":"신용카드고객데이터분석원","workSum":"신용카드고객의 데이터를 분석·통합하여 고객을 적극적으로 관리하고 마케팅전략을 개발한다.","doWork":"CRM(Customer Relationship Management)을 수행하기 위하여 통합고객데이터베이스 개발전략을 기획하고 추진한다. 고객이해기준을 정의하며 CRM운영정책 및 운영절차를 수립한다. 분석CRM(여러 가지 채널을 통해 고객 관련 정보를 수집하고 분석하여 고객서비스 및 마케팅전략을 개선)성과를 측정하고 평가한다. 각 채널에 고객분석자료를 제공한다. 고객과의 접점(콜센터 등)에서 운용할 CRM전략을 수립하고 기획·관리·평가한다. 홈페이지, 이메일 등을 통한 CRM운영을 기획·관리·평가한다. 고객분석정보시스템을 관리한다. 고객영업정보를 관리하고 경영자료로 보고한다. 데이터 추출 및 활용, CRM정보 활용 등에 대한 교육업무를 수행하기도 한다. 분석기법에 따라 SAS(Statistical Analysis System:통계패키지) 프로그램을 사용하거나 데이터마이닝기법을 활용하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","dJobECd":"0321","dJobECdNm":"[0321]은행 사무원","dJobJCd":"3203","dJobJCdNm":"[3203]은행 사무원","dJobICd":"K649","dJobICdNm":"[K649]기타 금융업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001612:1', '{"dJobCd":"K000001612","dJobCdSeq":"1","dJobNm":"신용카드신사업기획원","workSum":"신용카드사업을 기반으로 하여 다양한 연계사업을 기획하고 추진한다.","doWork":"신용카드와 연계될 수 있는 다양한 사업분야를 조사하고 검토한다. 문화(연극, 영화 티켓 등), 보험가입, 통신판매, 여행사업, 모바일부분, 현금서비스, 리볼빙제도 등 다양한 사업 분야의 수익성, 시장성, 상품성, 기술적 실현가능성, 마케팅, 제휴할 상대기업의 현황 등을 검토하고 기획서를 작성한다. 관련자와 회의를 통해 기획의 추진이 확정되면 세부적인 추진일정을 수립하고 사업의 도입에 따르는 제반 절차를 진행한다. 사업을 평가하고 수정전략을 기획한다. 해외사업진출 등 새로운 사업을 담당하여 추진하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","dJobECd":"0321","dJobECdNm":"[0321]은행 사무원","dJobJCd":"3203","dJobJCdNm":"[3203]은행 사무원","dJobICd":"K649","dJobICdNm":"[K649]기타 금융업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006467:1', '{"dJobCd":"K000006467","dJobCdSeq":"1","dJobNm":"신용평가기획원","workSum":"기업의 신용상태을 파악하고 예측할 수 있는 기업신용평가모델을 개발·운영하며 금융기관 간 신용정보의 공유를 위한 시스템의 개발 및 관리업무를 수행한다.","doWork":"정기적으로 각 산업별로 기업체신용평가실시를 기획한다. 기업의 재무담당 및 관련자들에게 기업평가를 위한 자료제출을 요청한다. 평가할 기업정보 및 자료를 분석하여 기업평가시스템에 의한 분야별 평가를 실시하고 기업의 신용등급을 결정한다. 기업체평가결과를 금융기관 및 관련 기관에 제공하며 경우에 따라서는 공개적으로 공지하기도 한다. 평가업무에 대한 전문가의 자문을 구하며 기업의 애로사항을 처리한다. 이를 바탕으로 신용평가모델을 개발한다. 기업정보를 관리하는 업무절차를 개선하여 기업정보시스템을 개발한다. 현장실사를 통한 평가를 실시하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0321","dJobECdNm":"[0321]은행 사무원","dJobJCd":"3203","dJobJCdNm":"[3203]은행 사무원","dJobICd":"N759","dJobICdNm":"[N759]기타 사업지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005915:1', '{"dJobCd":"K000005915","dJobCdSeq":"1","dJobNm":"신탁기획원","workSum":"신탁업무 추진방향을 설정하고 신탁제도 개선, 내규정비를 추진하며, 장단기 자금수급계획의 수립을 통하여 조달 및 운용부문에 대한 조정·통제업무를 수행한다.","doWork":"신탁에 관련한 금융제도 및 국내 신탁상품에 대한 자료를 수집·분석한다. 적립식목적신탁, 개발신탁, 가계금전신탁, 연금신탁, 기업금전 신탁 등의 상품을 개발하고 배당률 등을 산정한다. 영업점 관련 대고객 편의제고를 위한 신탁업무를 개선하고 신탁업무를 기획한다. 신탁외규 변경, 신상품 개발, 제도개선사항 내규반영, 금리결정업무를 수행한다. 장단기신탁대출의 운용계획을 수립한다. 수신율이 저조하거나 수신전망의 하락이 예측되는 신탁상품은 실적검토 후 페지한다. 신탁대출한도 및 대출자산건전성을 관리하여 신탁자금의 수급계획을 세운다. 개선된 신탁제도에 대해 영업점에 알리고 지도한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0321","dJobECdNm":"[0321]은행 사무원","dJobJCd":"3203","dJobJCdNm":"[3203]은행 사무원","dJobICd":"K641/K642","dJobICdNm":"[K641]은행 및 저축기관 / [K642]신탁업 및 집합투자업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005168:1', '{"dJobCd":"K000005168","dJobCdSeq":"1","dJobNm":"신탁대출사무원","workSum":"고객으로부터 융자신청을 받아 융자조건 등을 협의하고 융자의 타당성을 심사한 후 담보취득을 통해 대출품의 및 실행을 결정하고, 대출 취급 이후에 채권보전을 위한 각종 조치사항 등 사후관리업무를 수행한다.","doWork":"고객으로부터 융자신청을 받아 융자조건 등을 협의하고 차입신청서를 접수한다. 고객의 신용등급을 확인하여 융자의 타당성을 검토한다. 담보를 취득하여 담보내용을 평가하고 연대보증인을 세워 신용조사를 진행한다. 적정 대출금액을 산정한 후 대출승인신청서를 작성하여 대출심사부에 대출승인요청을 한다. 대출승인이 결정되면 대출금리를 고지하고 융자약정서를 체결한다. 근질권설정, 저당권설정 등 채권보전을 위하여 등기행정을 실시한다. 대출취급에 대한 품의를 하고 결재를 완료한다. 채권서류관리, 채무관계자 변동관리, 담보물관리, 연체관리 등 사후관리를 한다. 차주(채무자)로부터 기간연장, 금리변경, 담보 및 보증인 교체 등 여신거래조건의 변경을 요청받은 경우 제규정 부합 여부 등을 검토한 후 거래조건을 변경처리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"서비스제공","workFunc3":"관련없음","dJobECd":"0321","dJobECdNm":"[0321]은행 사무원","dJobJCd":"3203","dJobJCdNm":"[3203]은행 사무원","dJobICd":"K641/K642","dJobICdNm":"[K641]은행 및 저축기관 / [K642]신탁업 및 집합투자업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001363:1', '{"dJobCd":"K000001363","dJobCdSeq":"1","dJobNm":"어음교환제도기획원","workSum":"어음교환제도에 대한 사업추진계획 수립, 제규약 정비 및 업무지도, 지방어음교환소 개폐, 어음교환심사위원회운영, 어음교환회비 산출 등 어음교환업무 전반에 걸친 기획업무를 담당한다.","doWork":"금융결제원 업무로서, 어음교환업무 관련 사업추진계획을 수립한다. 효율적 어음교환제도운영을 위해 전자정보교환제도를 도입하고 어음교환제도의 개선사항을 검토하여 처리절차를 개선한다. 어음교환제도 관련 질의나 민원사항을 접수·검토·회신한다. 원활한 어음교환업무수행을 위해 지방어음교환소 및 은행에 대한 업무지도를 한다. 교환소의 지정·설치·폐지, 교환소 간 상호교환 실시, 교환참가지역 조정에 관한 사항을 검토·추진한다. 금융정보화추진분과위원회 은행소위원회 회의개최, 위원 교체 등과 관련된 사항을 준비한다. 어음교환회비 산출이나 어음교환 통계자료의 대내외 활용을 위해 어음교환과 관련된 통계자료를 수집·관리·분석한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0321","dJobECdNm":"[0321]은행 사무원","dJobJCd":"3203","dJobJCdNm":"[3203]은행 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003983:1', '{"dJobCd":"K000003983","dJobCdSeq":"1","dJobNm":"여수신총괄사무원","workSum":"영업추진전략을 수립하여 영업점별 목표를 부여·관리하고, 효율적인 마케팅 추진을 위한 제반 지원기능으로 업무개선, 계수관리 및 마케팅 관련 자료를 제공하며 영업점 단위별 여신 관련 지원업무를 총괄적으로 수행한다.","doWork":"중앙은행의 여신 및 수신금리정책 동향을 주시하고 관계기관의 금융정책결과를 연구·분석하여 연간 또는 분기별 여신 및 수신사업계획 및 세부업무추진계획을 수립한다. 회사의 여신 및 수신영업기반을 파악하여 영업점당 여신 및 수신목표를 부여하고 달성도를 점검한다. 관련 업무개선을 위해 대외기관 사례수집과 현황분석을 통해 개선방안을 수립·전파·교육시킨다. 결산지침 직원교육, 차이분석, 손익보정을 처리한다. 통합계수관리시스템을 구축하여 주기적인 자료를 갱신한다. 국내외 여신 및 수신금융 관련 학술회, 세미나 등에 참석하여 금융정보를 수집한다. 회사의 여신 및 수신정책 등 금융정책을 발표하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0321","dJobECdNm":"[0321]은행 사무원","dJobJCd":"3203","dJobJCdNm":"[3203]은행 사무원","dJobICd":"K641","dJobICdNm":"[K641]은행 및 저축기관","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003076:1', '{"dJobCd":"K000003076","dJobCdSeq":"1","dJobNm":"여신금리기획원","workSum":"여신금리변경에 따른 은행전체의 자금수급 변동 및 손익에 미치는 효과를 분석하고, 시장상황 변동 및 타행금리 수준을 파악하여 경쟁력 있는 여신금리수준을 결정하는 업무를 수행한다.","doWork":"중앙은행의 여신금리정책동향을 파악·예측한다. 여신금리 정책결과를 분석한다. 연구결과를 기반으로 여신금리를 기획·조종한다. 시장금리동향 분석, 자금별 여신금리차별 운용실적 파악, 금리효과 측정을 통해 여신금리를 분석한 후 기준금리를 결정·고시한다. 자금별 여신금리차별의 적용기준을 결정한다. 여신처의 유동성 및 자금흐름동향을 분석한다. 수수료율 변화에 따른 수익을 측정하여 적정수수료율을 결정한다. 결정된 금리와 수수료율을 영업점에서 적용토록 지도한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0321","dJobECdNm":"[0321]은행 사무원","dJobJCd":"3203","dJobJCdNm":"[3203]은행 사무원","dJobICd":"K641","dJobICdNm":"[K641]은행 및 저축기관","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005987:1', '{"dJobCd":"K000005987","dJobCdSeq":"1","dJobNm":"여신사무원","workSum":"금융기관에서 고객에게 돈을 빌려주기 위해 자금수요자의 요청에 따라 채권보전절차를 거쳐 급부·대출하고, 대출기간이 끝나면 자금회수 업무를 수행한다.","doWork":"차용신청서 또는 차용 및 보증신청서를 접수하여 개인이나 법인으로 분류하고, 담보내용, 서류, 거래실적, 자금용도, 상환자원 등을 조사·검토한다. 신용조사 및 담보물 감정결과를 검토하여 급부 여부를 결정한다. 승인된 신청서에 대하여 담보종류에 따라 근저당권, 지상권, 질권을 설정하고 보험에 가입하게 하거나 필요한 경우에는 공증을 받는 등 채권보전절차를 받는다. 채권보전절차가 완료되면 관계서류를 소정절차에 따라 정비한다. 대출금지급계산서를 작성하여 결재를 받고 대전을 예금주의 예금구좌에 입금시킨다. 급부금에 대하여 만기일에 회수 및 회수된 채권의 담보권해지에 관련된 사무를 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"계산","workFunc2":"서비스제공","workFunc3":"관련없음","similarNm":"대부사무원, 여신담당사무원","connectJob":"대출담당사무원","dJobECd":"0321","dJobECdNm":"[0321]은행 사무원","dJobJCd":"3203","dJobJCdNm":"[3203]은행 사무원","dJobICd":"K641","dJobICdNm":"[K641]은행 및 저축기관","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006707:1', '{"dJobCd":"K000006707","dJobCdSeq":"1","dJobNm":"여신사후관리사무원","workSum":"연체대출금에 대한 채권회수, 우량고객에 대한 일상적인 관계형성, 관리대상기업에 대한 특별감리 등 여신사후 관리업무를 수행한다.","doWork":"대출신용기준 및 이자납부기준에 따라 고객리스트를 확정하여 고객관리 전산프로그램에 등록·관리하고, 우량고객, 연체고객, 상습연체고객을 관리한다. 특별약정을 체결한 기업에 대해 약정이행상황을 점검한다. 지점에서 발송된 불량거래처 사유발생이나 부도발생 상황보고를 접수한다. 부실징후대상기업에 대해 대책을 강구하며 대출원리금 상환, 여신기일, 조건변경, 기간연장과 같은 대출금 관리업무를 한다. 정상여신고객이 여신거래 도중 임의상환하는 경우 금리감면, 거래조건 완화의 조치를 취하며 부실거래 고객에게는 독촉장발송, 원리금상환 등의 적정한 여신제재를 한다. 취득담보물에 대한 멸실, 훼손, 가치변동이 발생하거나 담보물 재감정기일이 도래하는 등 기존 담보물에 대한 가치산정 또는 보존대책을 실시하는 채권보존업무를 수행한다. 재산압류 및 해제관계문서를 접수하여 일선 영업점에 이첩하고 사후관리 관계보고서를 집계하여 보고한다. 여신관리 문제점을 개선하기 위하여 문제점 개선방안 및 여신사후관리방법을 개발하여 품의한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0321","dJobECdNm":"[0321]은행 사무원","dJobJCd":"3203","dJobJCdNm":"[3203]은행 사무원","dJobICd":"K641","dJobICdNm":"[K641]은행 및 저축기관","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;