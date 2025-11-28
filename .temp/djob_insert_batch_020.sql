INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001658:1', '{"dJobCd":"K000001658","dJobCdSeq":"1","dJobNm":"증권사주식운용원","workSum":"증권사에서 주식을 투자자의 이익을 위하여 정해진 투자목적에 맞게 운용한다.","doWork":"상품주식의 운용전략을 수립하고 운용한다. 해외증시 상장주식을 운용한다. 상장워런트(특정 주식을 미리 정한 가격에 살 수 있는 권리증서로, 만기에 특정종목의 주가나 주가지수를 미리 정한 가격에 사고 팔 수 있는 권리가 부여된 상품으로 옵션과 유사)를 운용한다. 주식 관련 파생상품(주가지수선물·옵션, 개별주식선물·옵션, 외화자산 환율헷지 목적의 통화선물)을 운용한다. 투자조합, 펀드 등 간접투자를 운용한다. 투자대상을 분석하고 투자를 실행한다. 상장공모 관련 수요예측(Book Bidding:기업을 공개할 때 공모가격 산정을 위해 주간사가 사전에 공모주식 수요를 파악하여 공모가격을 결정하는 제도)을 한다. 투자를 회수한다. 장외파생상품 투자를 운용한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","similarNm":"증권사자산운용원","dJobECd":"0312","dJobECdNm":"[0312]자산 운용가","dJobJCd":"2722","dJobJCdNm":"[2722]자산 운용가","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003376:1', '{"dJobCd":"K000003376","dJobCdSeq":"1","dJobNm":"증권사파생상품운용원","workSum":"증권사에서 파생상품을 투자자의 이익을 위하여 정해진 투자목적에 맞게 운용한다.","doWork":"파생상품(국공채, 통화, 주식 등 기초자산의 가격이나 자산가치지수의 변동에 의해 그 가치가 결정되는 금융계약. 선물, 옵션, 스왑) 운용 원칙 및 계획을 수립한다. 차익거래, 스프레드거래(원·달러, 현·선물 및 채권 현·선물)를 운용한다. 장내외 파생상품을 운용한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","dJobECd":"0312","dJobECdNm":"[0312]자산 운용가","dJobJCd":"2722","dJobJCdNm":"[2722]자산 운용가","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001720:1', '{"dJobCd":"K000001720","dJobCdSeq":"1","dJobNm":"증권투자자문가","workSum":"개인투자자나 기관투자가에 대하여 투자에 관한 지식, 판단, 자산운용 등에 관한 조언을 해준다.","doWork":"투자고객과 투자자문계약 또는 일임매매계약을 체결한다. 투자고객과 상담하여 투자성향, 과거 투자성과 및 자산규모, 투자하려는 자금의 성격과 기간 등을 파악한다. 고객의 투자성향에 맞는 투자전략 포트폴리오를 제시하여 최적의 수익을 발생할 수 있도록 조언한다. 증권시황을 분석하여 최대수익을 발생시킬 수 있는 매수, 매입시점을 예측하여 조언한다. 고객특성에 적정한 유가증권의 가치 또는 유가증권의 투자판단에 관하여 투자조언을 한다. 증권시장정보를 제공하고 유가증권의 평가를 통해 포트폴리오 구성과 운용에 대하여 조언한다. 투자자문만을 하는 경우에는 최종적인 매매의사 결정은 고객의 자기판단과 책임하에 행하도록 한다. 투자일임을 하는 경우에는 계약자로부터 자산운용에 관하여 포괄적인 위임을 받은 후 그 범위 내에서 포트폴리오를 관리·운용한다. 투자일임실적보고서를 작성하여 정기적으로 운용결과를 보고한다. 증권매매 및 계좌관리업무, 일임매매업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"자문","workFunc3":"관련없음","similarNm":"증권투자컨설턴트, 증권투자전문가","connectJob":"일임매매를 하는 경우 일임매매투자자문가","dJobECd":"0312","dJobECdNm":"[0312]자산 운용가","dJobJCd":"2722","dJobJCdNm":"[2722]자산 운용가","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003803:1', '{"dJobCd":"K000003803","dJobCdSeq":"1","dJobNm":"파생상품자산운용가","workSum":"파생상품시장에서 회사의 자산이나 고객이 투자를 위탁한 자산을 운용한다.","doWork":"우리나라를 비롯한 미국, 유럽 등의 세계경제지표 및 동향을 분석하고, 외국과 우리나라 지표와의 상관계수를 확인한다. 시장의 자금흐름을 분석하기 위해 고객예탁금 및 펀드유입자금을 확인하고 매매주체별 거래동향을 분석한다. 전략적 매매를 위해 팀별 또는 개인별로 매매시나리오를 구상한다. 온라인에서 파생상품시장에서 거래되는 통화선물, 금리선물, 금이나 농산물 등의 상품선물, 주가지수선물, 옵션 등의 파생상품을 매입하거나 매도하는 투자행위를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"선물옵션자산운용가","dJobECd":"0312","dJobECdNm":"[0312]자산 운용가","dJobJCd":"2722","dJobJCdNm":"[2722]자산 운용가","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003266:1', '{"dJobCd":"K000003266","dJobCdSeq":"1","dJobNm":"펀드매니저","workSum":"수익증권이나 뮤추얼펀드와 같은 간접 투자상품을 개발하여 투자고객들에게 판매하고, 투자신탁의 재산을 운용하거나 또는 기관투자가의 펀드를 관리·운용한다.","doWork":"수익증권이나 뮤추얼펀드와 같은 간접투자상품을 개발해서 투자고객들에게 판매한다. 자금사정의 변화 및 주식시장의 변동에 따라 포트폴리오를 조정하여 최대 이익을 얻도록 투자계획을 세운다. 증권시장이 개장되면 주가의 변화 및 금리상황을 지켜보며 매매거래를 시작한다. 장이 끝날 때까지 계속해서 올라오는 공시와 뉴스 속보들을 참고하여 증권을 매매한다. 투자설명회에 참석하거나 기업탐방 등을 통해 정보를 수집·가공한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","connectJob":"주식펀드매니저, 채권펀드매니저, 단기채권형펀드매니저, 파생상품펀드매니저, 부동산펀드매니저","dJobECd":"0312","dJobECdNm":"[0312]자산 운용가","dJobJCd":"2722","dJobJCdNm":"[2722]자산 운용가","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003138:1', '{"dJobCd":"K000003138","dJobCdSeq":"1","dJobNm":"녹색금융컨설턴트","workSum":"환경개선상품과 서비스에 자금을 제공하여 저탄소 녹색성장을 지원하는 녹색투자금융, 녹색보험, 녹색자산관리, 녹색소매금융에 대한 컨설팅업무를 수행한다.","doWork":"경제활동 전반에 걸쳐 자원 및 에너지 효율을 높이고 환경을 개선하는 상품 및 서비스의 생산에 자금을 제공하여 국가 전체의 녹색성장을 이룰 수 있도록 유도하는 녹색금융(녹색펀드, 녹색예금, 녹색채권 등)을 개발하거나 소개한다. 친환경시설에 투자하는 기업이나 하이브리드자동차를 구입하는 개인에게 혜택을 주는 것처럼 기업과 개인의 생산·소비활동이 친환경적으로 이루어질 수 있도록 녹색금융상품을 개발한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","dJobECd":"0313","dJobECdNm":"[0313]보험·금융상품 개발자","dJobJCd":"2723","dJobJCdNm":"[2723]보험 및 금융 상품 개발자","dJobICd":"K649","dJobICdNm":"[K649]기타 금융업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006723:1', '{"dJobCd":"K000006723","dJobCdSeq":"1","dJobNm":"보험계리사","workSum":"보험회사의 전반적인 위험을 분석·평가·진단하며 보험상품 개발에 대한 인·허가업무와 보험료 및 책임준비금 등을 산출한다.","doWork":"국내외 보험상품 관련 제도를 조사하고, 소비자심리 및 보험료에 영향을 미치는 요인을 분석한다. 분석결과를 토대로 국내 사회환경과 경제실정에 맞는 보험상품을 개발한다. 수학, 통계학, 재무이론, 확률 등의 지식을 적용해 적절한 보험료와 책임준비금을 산출한다. 보험약관에 의한 대출금을 계산하고 각종 적립금이나 준비금 등을 평가하여 보험사업 전반에 걸친 수리 및 통계분석업무를 한다. 사망률, 재해율, 질병, 장애, 퇴직률 등을 평가하고 각종 통계를 분석한다. 보험회사의 투자, 경영, 재무 관련 위험성을 분석·평가·진단하여 보험회사의 손익을 계산한다. 각종 통계자료의 분석을 통해 경영지표를 수립·제시한다. 기타 보험수리와 관련된 업무를 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"보험계리인, 보험상품개발자","certLic":"보험계리사","dJobECd":"0313","dJobECdNm":"[0313]보험·금융상품 개발자","dJobJCd":"2723","dJobJCdNm":"[2723]보험 및 금융 상품 개발자","dJobICd":"K662","dJobICdNm":"[K662]보험 및 연금관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004507:1', '{"dJobCd":"K000004507","dJobCdSeq":"1","dJobNm":"보험동향분석원","workSum":"국내외 보험시장의 동향을 조사·분석하여 보험수요 및 보험수요자동향을 분석·전망한다.","doWork":"정부통계자료, 기관보고서, 언론보도, 학계보고서 및 논문 등 각종 자료를 수집하여 국내외 경제 금융동향과 보험산업에 대한 영향을 분석한다. 국내 보험산업 전반의 동향을 분석 및 전망한다. 해외 보험산업에 대한 조사와 분석을 실시한다. 국내외 보험사의 동향이나 경제 관련 주요 통계자료들을 수집·관리한다. 보험가입자의 사회경제적 요인, 가입성향 등 수요자 동향에 관한 조사를 실시한다. 국내외 정부, 국제기구, 민간조사기구 등과 협의하여 필요한 자료를 수집하고 주요 거래국과 거래업체의 동향과 정보를 수집·분석한다. 조사결과를 토대로 연구보고서를 작성한다. 보험수요 예측모델을 개발한다. 보험가입성향 등 수요자동향에 관해 조사·분석한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","connectJob":"분석하는 보험상품의 종류에 따라 생명보험동향분석원, 교육보험동향분석원, 손해보험동향분석원","dJobECd":"0313","dJobECdNm":"[0313]보험·금융상품 개발자","dJobJCd":"2723","dJobJCdNm":"[2723]보험 및 금융 상품 개발자","dJobICd":"K651","dJobICdNm":"[K651]보험업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007519:1', '{"dJobCd":"K000007519","dJobCdSeq":"1","dJobNm":"보험상품개발자","workSum":"새로운 보험상품에 대한 아이디어를 고안하여 신상품을 기획·개발한다.","doWork":"보험상품의 판매동향, 수요도, 시장성, 금리전망 등을 조사하여 신상품 개발에 관한 아이디어를 수집·고안하고 신상품을 기획·개발한다. 관련 기관의 심의에 필요한 자료를 작성하여 신청한다. 다른 보험회사의 보험상품 판매실적, 수요도, 자사의 기존 상품의 시장성 등을 고려하여 보완이 필요한 기존상품에 대해 기초자료를 수집하고 대책을 마련한다. 해외의 보험상품정보와 국내외 경제동향을 분석하여 신상품 개발에 참고한다. 상품개발 후에는 소비자의 수요도와 반응 등을 조사하여 판매전략과 추후 상품개발에 참고한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"보험상품개발자, 보험상품기획원","certLic":"보험계리사","dJobECd":"0313","dJobECdNm":"[0313]보험·금융상품 개발자","dJobJCd":"2723","dJobJCdNm":"[2723]보험 및 금융 상품 개발자","dJobICd":"K651","dJobICdNm":"[K651]보험업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001956:1', '{"dJobCd":"K000001956","dJobCdSeq":"1","dJobNm":"보험시장분석원","workSum":"국내외 경제동향 및 보험시장을 조사·분석하여 보험상품 판매증가를 위한 전략을 수립한다.","doWork":"국내외 경제동향을 조사·분석하여 보험시장의 구조와 변화를 분석한다. 새로운 보험 관련 제도를 분석하여 보험시장 및 보험판매의 변화를 예측하고 대응책을 마련한다. 보험상품에 대한 인식 및 수요자성향 등을 분석하여 시장에 적합한 상품판매전략을 수립하고 보험시장 개발방안을 수립한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0313","dJobECdNm":"[0313]보험·금융상품 개발자","dJobJCd":"2723","dJobJCdNm":"[2723]보험 및 금융 상품 개발자","dJobICd":"K651","dJobICdNm":"[K651]보험업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007013:1', '{"dJobCd":"K000007013","dJobCdSeq":"1","dJobNm":"수신상품개발원","workSum":"수신상품(금융기관이 거래관계에 있는 다른 금융기관이나 고객으로부터 받는 신용·예금취급, 채권발행 등)을 개발하고, 수신 관련 제도 개선, 대고객 홍보기획 등의 업무를 수행한다.","doWork":"국내외 금융수신상품의 정보와 자료를 수집·분석한다. 가계, 기업 등 시중의 자금흐름 동향을 분석한다. 정부의 금리정책변화를 예측하고 금리정책을 고려하여 일반예금상품, 적금상품, 저축성보험상품, 머니마켓펀드(MMF), 어음관리계좌(CMA), 산업금융채권, 예수금상품, 타금융기관과의 수신 관련 상품제휴, 파생상품 등 각종 수신상품을 기획·개발한다. 예수금(금융기관이 일반 대중 또는 기업, 공공기관 등 불특정 다수로부터 일정한 이자지급 등의 조건으로 보관·위탁을 받아 운용할 수 있는 자금-요구불예금, 저축성예금) 관련 제도의 개선과 예수금 홍보업무, 예수금업무의 전산업무시스템을 기획한다. 자사(당행)의 매출전략을 수립하고 관리한다. 특수은행의 경우 금융채권(특별법에 의해 설립된 금융기관이 장기융자를 위한 자금을 흡수할 목적으로 발행하는 채권으로 산업은행의 산업금융채권, 장기신용은행의 장기신용채권, 중소기업은행의 중소기업금융채권이 있음)의 상장, 등록업무를 수행하기도 한다. 채권시장 제도연구와 예금자보험 관련 업무를 수행하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0313","dJobECdNm":"[0313]보험·금융상품 개발자","dJobJCd":"2723","dJobJCdNm":"[2723]보험 및 금융 상품 개발자","dJobICd":"K641","dJobICdNm":"[K641]은행 및 저축기관","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007055:1', '{"dJobCd":"K000007055","dJobCdSeq":"1","dJobNm":"은행개인금융상품개발자","workSum":"은행에서 금융고객의 요구에 부합하는 상품개발전략을 수립·시행하고 고객편의를 제고할 수 있는 제도개선 및 수신 관련 대고객 홍보업무를 기획하며, 개인금융업무 전산화를 주관하는 업무를 수행한다.","doWork":"금융시장의 변화 트렌드를 분석한다. 개인고객(성별, 연령별, 거주지별, 직업별 등)의 성향을 분석한다. 대출상품의 조건(금리, 기간 등) 분석을 통한 개인금융상품 조건을 결정한다. 신상품 개발 및 기존상품 존속여부를 결정한다. 수신금리 및 수수료의 기획, 수신 관련 규정 및 제도의 개선, 상품성 분석업무를 수행한다. 개인금융서비스 제도개선 및 관련 내규를 제·개정한다. 대고객 홍보업무전략을 수립하고 시행한다. 개인금융업무 전산화 추진 및 사후관리업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","similarNm":"PFC(Personal Finance Consultant), 개인금융PM(Product Manager, Project Manager)","dJobECd":"0313","dJobECdNm":"[0313]보험·금융상품 개발자","dJobJCd":"2723","dJobJCdNm":"[2723]보험 및 금융 상품 개발자","dJobICd":"K641","dJobICdNm":"[K641]은행 및 저축기관","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003515:1', '{"dJobCd":"K000003515","dJobCdSeq":"1","dJobNm":"은행기업금융상품개발자","workSum":"은행에서 기업고객이 필요한 자금이 적기에 공급될 수 있도록 기업금융상품을 개발한다.","doWork":"금융시장의 변화 추이를 조사·분석한다. 경쟁 금융회사의 상품을 조사·분석한다. 기업고객의 자금수요 및 성격(기간, 금리, 조건 등)을 분석한다. 조달자금(기업이 필요한 자금)과 대출상품의 조건이 어울리는지 분석한다. 대출, 보증 등 기업금융상품을 개발하고 개선한다. 상품별 금리·수수료 결정, 상품 관련 규정을 관리한다. 상품의 내규를 제·개정한다. 자사(당행)의 기업금융상품의 수요추이를 분석한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","similarNm":"기업금융PM(Project Manager, Product Manager)","connectJob":"중소기업금융을 전담하는 경우 중소기업금융PM, 특수금융을 전담하는 경우 특수금융PM","dJobECd":"0313","dJobECdNm":"[0313]보험·금융상품 개발자","dJobJCd":"2723","dJobJCdNm":"[2723]보험 및 금융 상품 개발자","dJobICd":"K641","dJobICdNm":"[K641]은행 및 저축기관","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004464:1', '{"dJobCd":"K000004464","dJobCdSeq":"1","dJobNm":"인터넷금융상품개발원","workSum":"인터넷비즈니스(E-business) 등 신사업 관련 신상품 및 서비스를 개발·운용하는 업무를 수행한다.","doWork":"국내외 인터넷금융상품의 정보와 자료를 수집·분석한다. 인터넷 사업정책을 수립한다. 수익성을 검토하여 인터넷뱅킹상품 및 서비스 개발을 기획한다. 인터넷뱅킹을 통한 예금, 적금, 보험, 펀드, 세금납부 등 각종 인터넷금융상품을 개발한다. 온라인상의 인터넷상품에 대한 보안시스템을 협의하고 문제점을 보안한다. 인터넷상품의 거래수수료 및 금리 등을 개발·연구한다. 인터넷뱅킹을 위한 전략적 제휴의 추진을 심사·평가하고 양해각서 및 계약서를 작성한다. 제휴업체와의 업무를 조정하는 등 제휴관계를 관리한다. 인터넷상품의 판매를 위한 장기적 모델을 개발한다. 제휴관계의 성과를 분석하고 제휴결과를 평가한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0313","dJobECdNm":"[0313]보험·금융상품 개발자","dJobJCd":"2723","dJobJCdNm":"[2723]보험 및 금융 상품 개발자","dJobICd":"K641","dJobICdNm":"[K641]은행 및 저축기관","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006910:1', '{"dJobCd":"K000006910","dJobCdSeq":"1","dJobNm":"증권사금융상품기획개발자","workSum":"증권사에서 각종 금융상품전략을 수립하고 관리·지원한다.","doWork":"증권사에서 취급하는 각종 금융상품의 판매전략을 수립한다. 시장 및 경쟁사의 동향을 파악한다. 자사의 중점추진상품을 선정한다. 금융상품 및 중점추진상품 교육프로그램을 기획하고 보급한다. 금융상품의 리밸런싱(Rebalancing:자산배분 비중을 유지하는 것) 업무를 수행한다. 기존의 판매상품에 대한 모니터링 및 개선책을 수립한다. 집합투자상품, 복합금융상품, 파생 관련 상품을 기획 및 개발하고 대내외 상품 관련 업무를 수행한다. 상품관리, 손익관리, 위험관리, 성과분석, 성과평가, 사후관리, 제도 도입·변경에 관한 업무를 수행한다. 온라인상품에 대한 영업전략을 수립하고 컨텐츠 기획, 프로모션, 사후관리업무를 수행하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","dJobECd":"0313","dJobECdNm":"[0313]보험·금융상품 개발자","dJobJCd":"2723","dJobJCdNm":"[2723]보험 및 금융 상품 개발자","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003464:1', '{"dJobCd":"K000003464","dJobCdSeq":"1","dJobNm":"카드상품개발자","workSum":"신용카드 등 각종 카드상품의 개발에 관련된 제반 업무를 수행한다.","doWork":"카드상품의 경쟁력을 높이기 위한 전략을 수립한다. 기존 카드상품의 문제점과 개선사항을 파악하기 위하여 소비자 요구 및 소비패턴을 조사한다. 관련 자료를 수집·분석하고 시행사항을 결정하여 각 부서나 지점에 통보한다. 신상품개발전략을 수립하고, 개발된 상품의 시행을 주관한다. 제휴서비스를 제공하기 위해 관련 기관과 협의한다. 전산개발, 디자인, 홍보 등 카드개발과 관련된 부서와 협의한다. 카드상품을 개발한 이후의 사후관리업무를 담당한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0313","dJobECdNm":"[0313]보험·금융상품 개발자","dJobJCd":"2723","dJobJCdNm":"[2723]보험 및 금융 상품 개발자","dJobICd":"K649","dJobICdNm":"[K649]기타 금융업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003326:1', '{"dJobCd":"K000003326","dJobCdSeq":"1","dJobNm":"크라우드펀딩기획자","workSum":"자금이 필요한 기업 또는 사업계획을 보유한 기업이 자금을 유치하고 대중투자자가 기업과 사업계획에 투자할 수 있도록 크라우드펀딩을 기획한다.","doWork":"투자형 크라우드펀딩을 기획하는 경우 기업이 대중으로부터 자금을 유치하기 위해 결정해야 하는 기업가치와 근거, 발행증권의 종류, 성장플랜과 회수방식 등 객관적 정보의 타당성을 검토한다. 기업의 탄생부터 성장과정, 핵심경쟁력과 미래가치를 표현하는 스토리 요소를 개발한다. 대중에게 신뢰와 투자매력을 전달할 수 있도록 기획한다. 후원형 크라우드펀딩을 기획하는 경우 펀딩을 진행하는 기업이 자금이 왜 필요하고 어떻게 쓰이며 어떤 사회적 이익을 창출하는지를 스토리로 기획한다. 투자자(후원자)가 느끼는 만족도와 참여도를 고려해서 보상방법을 구성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0313","dJobECdNm":"[0313]보험·금융상품 개발자","dJobJCd":"2723","dJobJCdNm":"[2723]보험 및 금융 상품 개발자","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003720:1', '{"dJobCd":"K000003720","dJobCdSeq":"1","dJobNm":"투자신탁상품개발원","workSum":"투자신탁상품(투자자들로부터 모은 자금으로 주식, 채권 등의 유가증권 및 현금성 투자상품 등에 분산하여 투자하고 그 투자수익을 투자자들에게 배당해 주는 공동투자상품)의 개발에 관련된 제반 업무를 수행한다.","doWork":"투자신탁상품에 대한 정보와 자료를 수집·분석한다. 고객의 요구에 맞는 투자신탁상품을 기획·개발한다. 기존 상품 및 시장, 고객에 대한 조사를 실시한다. 외국의 신상품에 대한 조사 및 업계동향 파악을 한다. 신상품에 대한 상품모델을 개발하고 수익률과 수익성 등을 검토한다. 고객의 요구와 수익률을 고려하여 주식과 등급별 채권의 비율조정 등을 통한 투자신탁 관련 금융상품 및 서비스를 개발한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"수익증권상품개발원","connectJob":"주식과 채권의 비율에 따라 주식형투신상품개발원, 채권형투신상품개발원, 혼합형투신상품개발원, 단기채권형상품개발원","dJobECd":"0313","dJobECdNm":"[0313]보험·금융상품 개발자","dJobJCd":"2723","dJobJCdNm":"[2723]보험 및 금융 상품 개발자","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002901:1', '{"dJobCd":"K000002901","dJobCdSeq":"1","dJobNm":"파생금융상품개발원","workSum":"외환, 예금, 채권, 주식 등과 같은 기초자산으로부터 파생금융상품(Financial Derivatives:손실위험을 회피하거나 최소화하여 수익을 확보하도록 거래자에 맞게 각종 금융상품을 결합한 금융상품)을 개발한다.","doWork":"고객들의 위험선호도나 자금운용계획, 시장전망 등에 따라 파생금융상품의 수요를 분석한다. 주가와 연계된 증권, 금리, 외환, 실물 등의 다양한 기초자산에 연동되어 수익이 결정되는 증권 등 다양한 파생상품을 개발한다. 파생상품을 판매하는 담당자들에게 개발상품에 대한 이해를 돕도록 설명하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"관련없음","dJobECd":"0313","dJobECdNm":"[0313]보험·금융상품 개발자","dJobJCd":"2723","dJobJCdNm":"[2723]보험 및 금융 상품 개발자","dJobICd":"K641","dJobICdNm":"[K641]은행 및 저축기관","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003635:1', '{"dJobCd":"K000003635","dJobCdSeq":"1","dJobNm":"금융매매담당원","workSum":"투자할 종목이 선정되면 해당 종목에 대해 매매할 타이밍을 결정하여 매수·매도한다.","doWork":"딜링룸(Dealing Room:매매전용사무실)에서 뉴스, 방송 등 각종 통신매체 및 자료를 이용하여 세계금융정보를 분석하고 파악한다. 동료들로부터 금융정보를 수집하여 분석하고 파악한다. 수집한 각종 루머(Rumor)들을 즉각 분석하여 시장에 미치는 영향을 판단한 후 거래를 실행한다. 매매에 유용한 신문, 일일보고자료, 조사부서의 자료 등을 검토하고 전일의 국내외 시장동향, 시장주도종목 등을 분석한다. 자금운용부서로부터 자금운용에 대한 포지션(Position:1인당 할당된 거래액)을 할당받는다. 매매타이밍을 결정하고 매매주문시스템을 이용하여 매수 또는 매도주문을 낸다. 매매가 이루어지면 체결결과를 보고한다. 거래가 마감되면 거래금액, 거래량, 이익률 및 손실률 등 금일 거래내용을 종합통계하고 전산으로 기록한다. 정보네트워크를 통해 관심종목조회, 조사부서에의 문의 등을 통해 다음날의 매매전략을 세운다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"트레이더","dJobECd":"0314","dJobECdNm":"[0314]증권·외환 딜러","dJobJCd":"2724","dJobJCdNm":"[2724]증권 및 외환 딜러","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005135:1', '{"dJobCd":"K000005135","dJobCdSeq":"1","dJobNm":"법인유가증권거래중개인","workSum":"기관투자가 및 법인투자가에 대한 증권거래 관련 영업활동을 한다.","doWork":"기관 및 법인에 관한 마케팅업무를 추진하고 영업대책을 수립한다. 기관 및 법인에 관한 자료를 조사·분석한다. 금융정기간행물, 기업의 주식 및 채권보고서, 시장조사 등 여러 투자정보를 검토·분석한다. 고객에게 투자정보를 제공하고 자문한다. 기관투자가의 유가증권 매매를 중개 또는 대리하고 매매결과를 통보한다. 기관투자가의 단기자금거래를 알선하고 관리한다. 선물옵션 관련 매매 및 프로그램 주문과 관련 업무를 수행한다. 유가증권 대차업무, 거래에 따른 수도결제(매매 체결된 고객의 체결사항을 증권예탁원과 증권사 간에 주식과 매매대금을 결제 정산하는 것, 당일결제 또는 익일결제 되는 것) 및 기타 부수업무를 수행한다. 기업탐방 및 시황설명회를 개최한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"법인브로커, 법인주식영업원, 증권중개인","dJobECd":"0314","dJobECdNm":"[0314]증권·외환 딜러","dJobJCd":"2724","dJobJCdNm":"[2724]증권 및 외환 딜러","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003785:1', '{"dJobCd":"K000003785","dJobCdSeq":"1","dJobNm":"선물거래중개인","workSum":"국내외 선물시장에서 투자고객에게 선물거래의 매매위탁을 권유하고 고객을 위하여 선물거래 관련 사항을 상담하며 거래를 중개한다.","doWork":"원자재나 상품가격의 변동에 따른 위험을 줄이거나 매매이익을 목적으로 선물시장에서 거래되는 통화선물 및 옵션, 금리선물, 상품선물(금, 농산물), 옵션, 주가지수선물 등의 선물상품을 매입 또는 매도하고자 하는 투자자를 대상으로 위탁을 권유한다. 투자고객의 의사표시에 의하여 선물상품의 거래를 성립시킬 수 있는 권리를 부여받아 거래를 대행한다. 투자자의 실명확인과 계좌개설신청서를 작성토록 한다. 미래의 일정한 시기에 미리 정해둔 가격으로 상품을 수수할 것을 약정하는 선물거래를 고객으로부터 주문받아 내용을 확인한 다음 전산을 통해 고객고유번호와 함께 지정된 주문양식에 맞추어 즉시 주문을 입력한다. 매매체결이 이루어지면 거래를 확인하고 거래내역서를 송부한다. 증거금정산업무를 처리하고 인수도(인수와 인도)절차를 처리한다. 특정상품을 특정한 가격에 사거나 팔 수 있는 권리매매(옵션거래)를 중개한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"파생상품거래중개인, 파생상품브로커, 금융선물거래중개인","certLic":"파생상품투자상담사","dJobECd":"0314","dJobECdNm":"[0314]증권·외환 딜러","dJobJCd":"2724","dJobJCdNm":"[2724]증권 및 외환 딜러","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005959:1', '{"dJobCd":"K000005959","dJobCdSeq":"1","dJobNm":"외환딜러","workSum":"외환시장의 추이를 분석하고, 외환의 현물 및 선물을 매매하는 업무를 수행한다.","doWork":"세계 정세 변화와 경제지표 및 금융 관련 정보를 수집하고 국제외환거래소 등의 국제금융시장에서 거래되는 외환의 시장추이를 분석한다. 외환시장이 열리면 금융결제원 자금중개실에서 컴퓨터 모니터로 띄워주는 주요 통화의 시세를 보면서 매수 또는 매도주문을 낸다. 국제금융시장에서 통용되는 외환과 파생상품을 가장 싼 시점에 사들여서 가장 비쌀 때 팔아 그 차액을 많이 남겨 은행이나 기업에 최대의 이익을 창출한다. 시시각각 변하는 외환거래상황과 환율변동에 주시하고, 수시로 고객이나 외국의 외환딜러들과 정보를 교환한다. 분석과 정보교환을 통해 환율변화를 예측하고, 환율변화에 따른 손실발생 방지 및 환차익을 남기기 위해 매매시점을 포착한 후 외환과 외환선물상품을 매매한다. 매매체결내역을 확인하고 통보한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"외환중개인, 외환전문역","dJobECd":"0314","dJobECdNm":"[0314]증권·외환 딜러","dJobJCd":"2724","dJobJCdNm":"[2724]증권 및 외환 딜러","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002124:1', '{"dJobCd":"K000002124","dJobCdSeq":"1","dJobNm":"유가증권대차거래중개인","workSum":"유가증권을 필요로 하는 차입자와 유가증권 대여자 간의 대차거래를 계좌대체방식으로 중개하는 업무를 수행한다.","doWork":"유가증권의 차입자와 대여자 간의 대차거래를 주선하여 차입자와 대여자 간 대차거래 조건 등이 일치하면 대차유가증권을 체결하고 인도한다. 대차기간 종료나 상환 시에는 동종, 동량의 차입증권이 상환되도록 관련 업무를 처리한다. 차입자는 대차거래를 위해 담보를 제공하는데 시장가격의 변동에 따른 대차증권 및 담보의 가치가 변동하므로 적정담보가 유지되도록 일일정산하여 담보가 부족한 때에는 추가담보를 요청한다. 차입자가 차입한 유가증권으로 인한 배당금, 이자 및 유·무상으로 발행되는 유가증권을 대여자에게 보상하도록 권리조치를 취한다. 차입자가 대차거래 종료 때까지 대차증권을 상환하지 못할 경우 차입자가 제공한 담보를 처분하여 대여자에게 대이행하거나 담보처분가액이 부족한 경우 차입자에 대한 구상권을 행사하기 위한 업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0314","dJobECdNm":"[0314]증권·외환 딜러","dJobJCd":"2724","dJobJCdNm":"[2724]증권 및 외환 딜러","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004861:1', '{"dJobCd":"K000004861","dJobCdSeq":"1","dJobNm":"증권사채권중개인","workSum":"증권사에서 채권상품을 전문적으로 중개하고 중개수수료를 받는다.","doWork":"상품채권, 주식 관련사채, CD(Certificate of Deposit:양도성예금증서), CO의 매매운용업무를 수행한다. 상품채권의 위험관리 및 운용성과를 분석한다. 채권시장을 조사 및 분석한다. 국채전문딜러(PD:Primary Dealer, 채권딜러 중에서 국채를 독점적으로 인수할 수 있는 권리를 지닌 금융기관) 업무를 수행한다. 채권전문딜러업무를 수행한다. 소매전문딜러업무를 수행한다. 지급준비자산을 운용 및 관리한다. 수신상품(CMA:Cash Management Account, 고객이 맡긴 예금을 어음이나 채권에 투자하여 그 수익을 고객에게 돌려주는 실적배당 금융상품) 자산의 편출입을 관리한다. 외환딜링 및 FX파생상품(Foreign Exchange)을 거래한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"채권딜러","connectJob":"국채전문딜러","dJobECd":"0314","dJobECdNm":"[0314]증권·외환 딜러","dJobJCd":"2724","dJobJCdNm":"[2724]증권 및 외환 딜러","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005710:1', '{"dJobCd":"K000005710","dJobCdSeq":"1","dJobNm":"증권사회사채영업원","workSum":"증권사에서 회사채 관련 인수주선업무를 수행한다.","doWork":"회사채(주식회사가 설비자금이나 운용자금을 마련하기 위해 일반을 대상으로 자금을 집단적 대중적으로 조달하고 회사가 채무자임을 표시해 발행하는 유가증권) 발행가능 기업을 발굴한다. 회사채 발행 관련 인수주선(유가증권을 발행하는 데 있어 증권회사 등이 이를 매출할 목적으로 그 유가증권의 전부 또는 일부를 취득하여 일반 대중에게 균일한 조건으로 취득을 청약한 것을 권유하는 업무)영업을 한다. 기존 거래기업의 회사채 발행 관련 인수주선영업을 한다. CP(양도성예금증서) 등 기타 금리상품의 인수주선영업을 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0314","dJobECdNm":"[0314]증권·외환 딜러","dJobJCd":"2724","dJobJCdNm":"[2724]증권 및 외환 딜러","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003621:1', '{"dJobCd":"K000003621","dJobCdSeq":"1","dJobNm":"채권매매중개인","workSum":"각종 채권 및 단기상품(CD:양도성예금증서, CP:기업어음, 수익증권)을 매매중개하는 업무를 수행한다.","doWork":"채권 매매 전산시스템을 활용하여 국내외 각종 채권의 시장동향을 파악하고 채권 및 단기상품(CD:양도성예금증서, CP:기업어음, 수익증권)의 매수 또는 매도를 예측(가격, 시기 등)하여 고객에게 제안한다. 장내채권시장(증권거래소에서 거래되는 일반채권시장으로 공식시장) 및 장외채권시장(증권거래소 밖에서 유가증권 매매가 이루어지는 비공식시장)의 동향을 조사·분석한다. 채권금리동향, 금융 관련 뉴스, 정책방향, 기관별 투자성향 등 각종 정보를 분석하여 상품채권의 운용방침을 수립한다. 고객에게 정보를 제공 및 협의하여 매매할 채권상품을 선정한 후 매수·매도하고 매매결과를 통보한다. 채권 중개매매에 따른 성과를 분석한다. 수도결제(매매체결된 고객의 체결사항을 증권예탁원과 증권사 간에 주식과 매매대금을 결제 정산하는 것, 당일결제 또는 익일결제 되는 것) 시 동시결제방식(매매약정과 동시에 결재되는 것)에 따라 채권매입대금과 채권의 수령을 동시에 처리한다. 채권수령의 경우 예탁원의 고유계좌를 이용하여 매매를 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"채권브로커, 채권영업원","connectJob":"취급하는 채권의 종류에 따라 수익증권매매중개인, 어음매매중개인","dJobECd":"0314","dJobECdNm":"[0314]증권·외환 딜러","dJobJCd":"2724","dJobJCdNm":"[2724]증권 및 외환 딜러","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006575:1', '{"dJobCd":"K000006575","dJobCdSeq":"1","dJobNm":"투자신탁상품매매중개인","workSum":"주식형, 채권형, 혼합형 수익증권을 판매 및 환매하고 관리한다.","doWork":"국내외 투자상품에 대한 정보와 자료를 수집·분석하여 최적수익상품을 선정한다. 선정한 투자상품의 시장동향을 실시간으로 분석하여 고객에게 정보를 제공하고 투자를 제안한다. 주식, 채권 등의 유가증권 및 현금성 투자상품 등의 공동투자상품에 분산하여 투자하도록 유도한다. 그 투자수익(보상)을 투자자들에게 환산하여 제공한다. 투자신탁을 비롯한 금융상품의 판매영업을 기획하고 실적을 분석하고 판매전략을 수립한다. 투자자의 기호를 파악하여 법인, 기관투자가 및 개인에게 금융상품을 판매한다. 고객정보를 수집하고 관리한다. 투자신탁재산과 신탁형 증권저축으로 조달한 자금을 운용하기 위해 발행시장에서 유가증권을 인수하거나 유통시장에서 기관투자가로서 유가증권의 매매업무를 수행한다. 투자신탁금융상품의 모집 및 매출, 매각, 환매, 이익분배금 및 상환금 지급 등 투자신탁 관련 제반 업무를 수행한다. 투자신탁회사(운용사)와 위탁판매를 협의한다. 자산종합관리계좌(Wrap Account)개발 및 운영방안을 수립하고 추진한다. 자산운용모델 및 관리시스템을 개발하고 유지 및 개선을 위한 업무를 수행한다. 주식 및 채권의 비율에 따라 주식형투자신탁상품, 채권형투자신탁상품, 혼합형투자신탁상품, MMF(Money Market Fund)상품을 판매하여 투자를 유도한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"투자신탁상품영업원","connectJob":"판매되는 투자신탁상품의 주식 및 채권의 비율에 따라 주식형투자신탁상품매매중개인, 채권형투자신탁상품매매중개인, 혼합형투자신탁상품매매중개인, MMF(Money Market Fund)매매중개인","dJobECd":"0314","dJobECdNm":"[0314]증권·외환 딜러","dJobJCd":"2724","dJobJCdNm":"[2724]증권 및 외환 딜러","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006472:1', '{"dJobCd":"K000006472","dJobCdSeq":"1","dJobNm":"파생상품중개인","workSum":"투자고객에게 파생상품거래의 매매위탁을 권유하여 거래를 중개한다.","doWork":"통화선물, 금리선물, 상품선물, 주가지수선물, 옵션 등의 파생상품을 매입 또는 매도하고자 하는 투자자를 대상으로 상담하고 매매 위탁을 권유한다. 투자를 원하는 고객을 대신하여 거래를 성사시킨다. 고객으로부터 선물 및 옵션거래를 주문받아 매매상대방을 찾아 계약을 체결한다. 매매가 체결되면 거래를 확인하고 거래내역서를 송부한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"파생상품브로커, 선물옵션중개인","dJobECd":"0314","dJobECdNm":"[0314]증권·외환 딜러","dJobJCd":"2724","dJobJCdNm":"[2724]증권 및 외환 딜러","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007561:1', '{"dJobCd":"K000007561","dJobCdSeq":"1","dJobNm":"손해사정사","workSum":"각종 보험사고 시 보험금심사원이 조사한 보상청구에 대해 심사하고, 사고원인을 조사하여 적정한 보험금을 산출하며 지급을 허가한다.","doWork":"사고통보를 접수하면 손해발생사실을 확인하고, 보험약관 및 관계법규 적용의 적정여부를 판단한다. 사고특성에 따라 분야별 보험금심사원을 선정한다. 사고원인, 손해정도, 손해액 산정업무를 보험금심사원에게 위임하거나, 함께 조사한다. 조사내용을 분석·정리하여 손해액이나 보험금의 적정가격을 결정한다. 보상범위를 결정하기 위하여 보상금심사원의 보고서를 조사하고 유사한 보험클레임이나 판례, 사례들을 검토한다. 보상청구의 타당성 여부와 협상이 관례 및 절차에 따라 이루어졌는지 확인한다. 보험금 청구의 적정성을 심사하기 위해 변호사, 의사 등 전문가에게 자문을 구하기도 한다. 손해사정서를 작성하여 보험회사 등에 제출한다. 의견을 진술하거나 손해사정서 내용을 보험회사와 보험계약자 등에게 설명한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"보험산정인, 보험사정인, 손해사정인, 해상보험사정인","connectJob":"업무영역에 따라 재물손해사정사, 차량손해사정사, 신체손해사정사, 농업재해보험손해사정사","certLic":"손해사정사, 손해평가사","dJobECd":"0315","dJobECdNm":"[0315]손해사정사","dJobJCd":"2725","dJobJCdNm":"[2725]손해 사정사","dJobICd":"K662","dJobICdNm":"[K662]보험 및 연금관련 서비스업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001839:1', '{"dJobCd":"K000001839","dJobCdSeq":"1","dJobNm":"금융공동망제도기획원","workSum":"금융공동망 제규약 정비, 전자금융 관련 표준화추진, 전자금융위원회 등 금융공동망 전반에 걸친 기획업무를 담당한다.","doWork":"금융결제원 업무로서 금융공동망업무 관련 사업추진계획을 수립한다. 효율적 금융공동망제도운영을 위한 금융공동망제도의 개선사항을 검토하여 처리절차를 개선한다. 타행환공동망, 현금자동인출기(CD)공동망, 자동응답서비스(ARS)공동망, 직불카드공동망, 대량자금이체(CMS)공동망, 지로공동망, 신용정보공동망 등에 관련된 규약을 반영하고 금융공동망제도 관련 업무질의나 민원사항을 접수하여 검토하고 회신한다. 금융정보망의 안정성 확보를 위하여 금융정보망 백업센터 구축, 공동암호체계 및 표준화를 추진한다. 금융기관 공동전산업무의 하부구조 기반강화를 위하여 금융정보네트워크 확장, 지급결제시스템 확충을 추진한다. 새로운 금융서비스 창출을 위하여 금융공동망시스템과 관련된 사항을 조사·분석한다. 금융공동망업무 관련 홍보, 이용서비스 및 수수료를 조정한다. 전자금융위원회·전산위원회 등의 회의를 개최한다. 금융공동망 회비를 산출한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"수동조작","dJobECd":"0319","dJobECdNm":"[0319]기타 금융·보험 전문가","dJobJCd":"2729","dJobJCdNm":"[2729]기타 금융 및 보험 관련 전문가","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005367:1', '{"dJobCd":"K000005367","dJobCdSeq":"1","dJobNm":"금융기관감독원","workSum":"금융회사 및 자본시장 등에 관하여 검사·감독하며, 금융소비자를 보호하고 분쟁을 조정한다.","doWork":"은행, 비은행, 증권사, 보험사, 금융지주회사 등의 인허가 및 경영건전성을 감독한다. 금융회사의 영업활동 및 자산, 부채상황을 파악하여 금융회사의 경영성과와 능력을 평가한다. 금융회사가 관계법규 등을 준수하는지 확인한다. 유가증권발행시장과 유통시장의 건전한 발전을 위해 발행회사의 경영상황 및 발행유가증권에 대한 공정고시 여부를 감독한다. 기업회계기준 등 회계제도를 정비하고 외부감사제도를 보완하기 위해 회계감리제도를 시행한다. 소비자가 금융회사를 이용하면서 겪는 불편한 점을 상담하고 처리한다. 금융회사와 민원인의 분쟁을 조정한다. 금융소비자들을 대상으로 금융 관련 교육 및 홍보를 실시한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","similarNm":"금융기관검열관, 금융기관감사원, 금융감독원","dJobECd":"0319","dJobECdNm":"[0319]기타 금융·보험 전문가","dJobJCd":"2729","dJobJCdNm":"[2729]기타 금융 및 보험 관련 전문가","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001606:1', '{"dJobCd":"K000001606","dJobCdSeq":"1","dJobNm":"금융리스크매니저","workSum":"국내외 주식, 선물옵션, 채권, 자금, 외환시장 등에서 시장위험을 인식하여 분석하고 통제하는 일을 수행한다.","doWork":"수학, 통계학, (금융)보험학, 경제학, 경영학 등 관련 지식 및 경제동향, 산업전반에 대한 이해를 바탕으로 시장의 흐름을 파악하고 분석한다. 경제, 금융, 시황에 대한 전문가분석정보를 지속적으로 수집하고 분석한다. 주식, 선물, 채권, 자금, 외환 등 금융 관련 시장에서 시장의 리스크를 파악한다. 리스크의 강도, 확률, 발생시기, 변화가능성을 추론하고 전략적 리스크 지도(Strategic Risk Map:기업이 직면하는 위협에 대한 가상의 지도), 리스크 계량화, 리스크에 대한 잠재적 상승경향분석을 통해 리스크를 완화할 수 있는 방안을 도출한다. 보고서를 작성하고 자본의 의사결정에 참고자료로 제시한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0319","dJobECdNm":"[0319]기타 금융·보험 전문가","dJobJCd":"2729","dJobJCdNm":"[2729]기타 금융 및 보험 관련 전문가","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007273:1', '{"dJobCd":"K000007273","dJobCdSeq":"1","dJobNm":"금융소비자보호전문가","workSum":"금융소비자의 안전한 금융거래를 위해 금융회사의 금융상품 설계 및 판매 등에 필요한 절차와 기준을 수립하고, 금융상품에 대한 분쟁 발생시 중재·해결한다.","doWork":"금융소비자의 안전한 금융거래를 위해 금융소비자보호에 관한 법규와 감독기준에 맞도록 금융회사의 규정 및 제도를 기획 및 개선하고 필요한 절차와 기준을 수립한다. 금융상품의 설명서, 계약서류 등을 사전심의한다. 금융소비자보호법 준수를 위하여 정기적으로 현안을 파악하고 대응 실무 협의체를 운영한다. 금융상품에 대하여 고객과 회사 사이에 발생하는 분쟁을 중재·해결한다. 발생한 민원내용을 분석하고 조치 사항에 대해 관리·감독한다. 금융소비자보호 표준내부통제기준 준수여부에 대하여 점검·평가한다. 금융소비자보호 관련 교육프로그램을 개발하고 운영업무를 총괄한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"금융소비자보호총괄책임자(COO)","dJobECd":"0319","dJobECdNm":"[0319]기타 금융·보험 전문가","dJobJCd":"2729","dJobJCdNm":"[2729]기타 금융 및 보험 관련 전문가","dJobICd":"K","dJobICdNm":"[K]금융 및 보험업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002675:1', '{"dJobCd":"K000002675","dJobCdSeq":"1","dJobNm":"외환기획원","workSum":"외환업무 추진방향 및 목표이익 계획을 설정하고 영업환경 변화 및 외규변경에 따른 제도개선, 신규업무 개발을 주관하여 효율적인 고객서비스를 제공할 수 있도록 기반을 구축한다.","doWork":"국내 예금은행, 개발기관, 외은지점, 종금사 등 국내 외국환은행의 외환규모의 변화추이를 분석한다. 국제외환시장의 동향과 국내 외화자금수요를 연구·분석하여 국내외환시장에 미치는 영향을 예측하고 외환계획에 적용한다. 부실외화자산정리, 중장기외화차입 등의 계획을 설정한다. 환위험을 분석하고 그 위험에 대한 관리를 한다. 외환재무구조개선을 위하여 외국환업무의 추진계획을 수립하고 관련 내규를 제정 또는 개정한다. 영업점 마케팅계획을 수립하고 외화 관련 상품을 연구하여 신상품 및 신규업무를 개발한다. 무역어음 운용방안을 수립하고 자금운용현황을 파악하여 대책을 마련하는 등 무역어음을 총괄한다. 부문별, 영업점별 실적을 집계 및 관리한다. 외부자금의 집행과 회수상황을 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0319","dJobECdNm":"[0319]기타 금융·보험 전문가","dJobJCd":"2729","dJobJCdNm":"[2729]기타 금융 및 보험 관련 전문가","dJobICd":"K641","dJobICdNm":"[K641]은행 및 저축기관","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005894:1', '{"dJobCd":"K000005894","dJobCdSeq":"1","dJobNm":"위험평가사정원","workSum":"심사확인된 청약서에 대해 위험평가기준표에 의거 해당 계약을 사정하여 계약심사를 한다.","doWork":"심사확인이 완료된 청약서를 인수하여 위험평가기준표에 따라 해당 계약을 사정한다. 과거병력, 타사보험가입 연혁, 과거보험보상 연혁, 보험범죄 연혁 등 병력 및 보험 과거력에 대하여 이상 여부를 사정한다. 과도한 보상연혁이나 상습적인 보상연혁, 특별한 질병치료연혁이 발견된 경우에는 청약에 대한 승인을 거절한다. 사정 여부에 따라 보험대상자(피보험자)의 위험을 선택하고 적절한 위험집단으로 분류하여 보험료 및 가입조건을 결정한다. 사정심사 후 청약승인과 청약거절을 분류하여 해당 부서에 통보한다. 사정기준에 부적합한 것은 반송처리하고 미비된 사정분은 보완을 지시한다. 사정이 완료된 것은 결재를 득하여 발권담당부서에 인계한다. 신계약위험평가사정에 관련된 부수업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"심사분야에 따라 생명보험언더라이터, 손해보험언더라이터","dJobECd":"0319","dJobECdNm":"[0319]기타 금융·보험 전문가","dJobJCd":"2729","dJobJCdNm":"[2729]기타 금융 및 보험 관련 전문가","dJobICd":"K651","dJobICdNm":"[K651]보험업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003889:1', '{"dJobCd":"K000003889","dJobCdSeq":"1","dJobNm":"유가증권상장등록심사원","workSum":"상장·등록을 신청한 기업이나 기관이 발행한 주식이나 채권이 유가증권시장(한국거래소, 코스닥)에서 매매거래될 수 있는지 상장·등록심사를 한다.","doWork":"상장·등록신청 기업에서 제출한 예비상장·등록심사청구서 및 관련 서류를 확인하고 상장·등록요건을 갖추었는지 점검한다. 유가증권 상장규정 15조에 의거하여 심사기업에 대한 충분한 분석과 분석내용의 보고서 반영 여부 등을 검토하고 심사결과보고서를 작성하여 상장·등록 위원회에 심의하고 심사결과를 통보한다. 주권의 신규상장·등록, 증권투자회사주권신규상장·등록, 수익증권신규상장·등록, 재상장·재등록 등을 위한 신청서 및 관련 서류를 확인하고 상장·등록요건 충족 여부를 검토하여 신청회사 및 관계기관 등에 상장·등록을 통보한다. 국제적으로 표준화된 유가증권의 코드를 부여하고 관리한다. 상장·등록심사에 대한 연구 및 교육을 담당한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"거래소시장 또는 협회중개시장(코스닥시장)에 따라 상장심사원, 등록심사원","dJobECd":"0319","dJobECdNm":"[0319]기타 금융·보험 전문가","dJobJCd":"2729","dJobJCdNm":"[2729]기타 금융 및 보험 관련 전문가","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004363:1', '{"dJobCd":"K000004363","dJobCdSeq":"1","dJobNm":"증권거래감리제도기획원","workSum":"증권거래감리제도에 대한 입안 및 개선, 불공정거래조사를 위한 감리시스템을 구축한다.","doWork":"해외 여러 국가의 증권거래감리제도에 대한 정보와 사례를 수집하여 장단점을 분석하고 국내 증권거래감리제도기획에 참고한다. 감리제도 및 관련 규정에 대해 조사·연구하며, 제도의 문제점 및 개선방안을 검토한다. 불공정증권거래를 사전에 방지하고 공정한 증권거래를 형성하기 위하여 감리종목 선정기준을 연구·기획한다. 관계기관과의 협의를 통해 감리규정을 개정하고 회원사 및 관계기관에 통보한다. 세미나 및 교육을 통해 새로운 감리제도 및 법령에 대해 교육한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0319","dJobECdNm":"[0319]기타 금융·보험 전문가","dJobJCd":"2729","dJobJCdNm":"[2729]기타 금융 및 보험 관련 전문가","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004732:1', '{"dJobCd":"K000004732","dJobCdSeq":"1","dJobNm":"증권사리스크관리역","workSum":"증권사에서 발생하는 금융리스크를 사전에 점검하거나 실시간 감시한다.","doWork":"리스크 측정 및 평가업무(리스크의 측정 및 보고, 측정의 적정성 평가 및 각종 가정모델 검증, 리스크관리시스템 운영, 리스크 검토)를 수행한다. 한도관리업무(리스크 한도 배정 및 분석, 리스크 한도 모니터링 및 보고, 한도 위반에 대한 보고 및 사후조치)를 수행한다. 리스크 관련 규정을 제·개정 및 관리한다. 리스크 관련 규정의 위반에 대한 보고 및 사후조치를 한다. 경영실태평가 및 계량지표(영업자기자본비율, 자산부채비율, 기타 자기자본비율 등 재무비율)를 산출하고 보고한다. 리스크관리위원회에 리스크 관련 정책의 집행, 위원회의 심의 의결사항에 대한 집행 및 결과, 리스크관리 현황을 보고한다. 자산운영에 대한 포트폴리오 관리, 파생상품 운용 및 중개에 대한 적정증거금의 관리 및 통제, 일일 금융자산변동에 대한 감시 및 최적화, 보유채권에 대한 채권등급 감시, 투자 및 예탁자산의 운영 및 중개에서 발생하는 금융리스크를 사전에 점검하고 실시간 감시한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","dJobECd":"0319","dJobECdNm":"[0319]기타 금융·보험 전문가","dJobJCd":"2729","dJobJCdNm":"[2729]기타 금융 및 보험 관련 전문가","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001772:1', '{"dJobCd":"K000001772","dJobCdSeq":"1","dJobNm":"크라우드펀딩딜매니저","workSum":"크라우드펀딩에 적합한 기업 및 사업을 발굴하여 크라우드펀딩에 참여하도록 권유한다.","doWork":"스타트업 기업 또는 유망한 사업프로젝트를 조사하고 발굴한다. 관계자와 면담하여 크라우드펀딩(자금을 필요로 하는 수요자가 온라인플랫폼 등을 통해 불특정 다수 대중에게 자금을 모으는 방식)을 설명한다. 기업 및 프로젝트의 사업적 특성, 필요자금, 자금조달방식 등을 분석하여 지분형(증권형), 채권형 등 적절한 크라우드펀딩 방식을 추천한다. 기업이 크라우드펀딩에 참여하도록 권유하며 펀딩에 필요한 제도적인 절차를 돕는다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"설득","workFunc3":"관련없음","dJobECd":"0319","dJobECdNm":"[0319]기타 금융·보험 전문가","dJobJCd":"2729","dJobJCdNm":"[2729]기타 금융 및 보험 관련 전문가","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006171:1', '{"dJobCd":"K000006171","dJobCdSeq":"1","dJobNm":"크라우드펀딩운영자","workSum":"금융감독원 등 유관기관에 크라우드펀딩을 등록하고 펀딩을 관리·운영한다.","doWork":"크라우드펀딩을 진행하는 기업이 유관기관에 제출해야 하는 자료를 안내하고 수합한다. 자료의 사실관계를 확인하고 유관기관에 제출한다. 기업과 상의하여 사업모델, 자금조달의 이유와 성장목표, 투자금 회수전략을 수립하고 온라인에 공개할 기업소개 자료를 작성한다. 펀딩을 진행하기 전 투자자보호에 문제가 없는지 확인하고 신뢰성 있는 투자자 보호장치를 설정한다. 펀딩을 개시하고 투자자의 펀딩 참여 추세를 분석한다. 기업과 투자자가 최대의 이익을 실현하며, 민원이 발생하지 않도록 관리한다. 진행 중인 펀딩에 사실관계의 변경이 생겼을 경우 기존 투자자에게 즉시 이를 공지하고, 게재사항을 수정하여 투자자들이 변경사항에 대한 분명한 인지를 가지고 투자하도록 돕는다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0319","dJobECdNm":"[0319]기타 금융·보험 전문가","dJobJCd":"2729","dJobJCdNm":"[2729]기타 금융 및 보험 관련 전문가","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007414:1', '{"dJobCd":"K000007414","dJobCdSeq":"1","dJobNm":"간편결제사업기획운영자","workSum":"간편결제 서비스를 기획하고 운영한다.","doWork":"온·오프라인 간편결제 서비스 사업을 기획하고 운영한다. 신규 결제서비스 모델을 기획하고 구축한다. 신용카드사, VAN사, 교통사업자와의 제휴사업을 기획·구축·운영·마케팅한다. 사업목표를 설정하고 상세기획방향 수립하여 프로젝트가 원활하게 실행 및 운영되도록 한다. 데이터 기반의 고객 서비스를 개선하고 지표를 관리한다. 업체 동향을 파악하고 리스크에 대응한다. 금융결제원이나 금융정보분석원 등의 기준이나 요구에 맞춰 서비스를 조정하며 모니터링한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0243","dJobECdNm":"[0243]상품 기획자","dJobJCd":"2731","dJobJCdNm":"[2731]상품 기획 전문가","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007415:1', '{"dJobCd":"K000007415","dJobCdSeq":"1","dJobNm":"게임플랫폼사업기획자","workSum":"게임플랫폼 서비스를 기획하고 프로젝트를 관리한다.","doWork":"게임플랫폼 PaaS 서비스의 사업 정책을 수립하고 상품화 및 마케팅을 기획한다. 대외 서비스 및 기관과 사업 제휴를 진행한다. 국내/외 서비스 조사 및 분석을 통한 서비스 지표를 관리한다. 서비스의 지속적인 개선 및 플랫폼 유지보수를 위한 업무 분장 및 일정관리를 한다. 게임 서비스 운영 및 퍼블리싱을 위한 IT 서비스 및 이슈 및 리스크를 관리한다. 사업, 운영, 개발 등 유관부서와의 원활한 커뮤니케이션을 통해 협업을 조율한다. 프로젝트에 대한 이슈를 사전에 인지하고, 문제해결을 위한 대안을 제시한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0243","dJobECdNm":"[0243]상품 기획자","dJobJCd":"2731","dJobJCdNm":"[2731]상품 기획 전문가","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004435:1', '{"dJobCd":"K000004435","dJobCdSeq":"1","dJobNm":"공간정보융합서비스기획자","workSum":"공공정책, 자동차항법장치, 가상현실, 게임, 부동산, 마케팅, 대중교통, 숙박, 관광, 안전 등 다양한 공간정보융합서비스를 기획한다.","doWork":"개발하는 공간정보서비스의 목표서비스를 정의하고 외부환경, 경쟁사, 국내외 시장수요 및 고객의 요구 등을 분석하여 시장분석보고서를 작성한다. 새로운 공간정보서비스를 발굴하고 서비스모델, 아키텍처, 비용, 수익, 편익, 개발계획 등을 고려하여 서비스기획보고서를 작성한다. 공간정보의 생산, 가공, 유통에 관련된 제품이나 서비스를 기획하기도 한다. 공간빅데이터를 발굴하고 사업성을 검토한다. 공간정보 서비스 및 제품에 따라 관련 법률, 표준, 정책을 검토하고 적용 및 인증에 대응한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","certLic":"공간정보융합기사, 공간정보융합산업기사","dJobECd":"0243","dJobECdNm":"[0243]상품 기획자","dJobJCd":"2731","dJobJCdNm":"[2731]상품 기획 전문가","dJobICd":"J639","dJobICdNm":"[J639]기타 정보 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002459:1', '{"dJobCd":"K000002459","dJobCdSeq":"1","dJobNm":"디지털음원기획자","workSum":"디지털음원의 유통 및 마케팅을 위한 기획을 하고 음원유통계약을 체결하며 각종 판촉 관련 업무를 수행한다.","doWork":"음원제작사로부터 신규음원의 참여 아티스트, 제작일정, 콘셉트 등의 정보를 받아 유통 및 마케팅기획안을 만든다. 기획안을 제작사와 협의하고 음원유통계약을 체결한다. 음원배포, 뮤직비디오, 이벤트, 홍보, 공연, 방송출연 등 각종 프로모션 방법과 일정을 고안하고 실현한다. 계약에 의해 유통사가 가지는 저작인접권(저작권에 인접한, 저작권과 유사한 권리로서 저작물을 일반인이 향유할 수 있도록 매개하는 자에게 부여한 권리)을 보호하기 위한 모니터링업무를 수행한다. 음원라이선스 계약(License Agreement:저작권, 특허권, 상표권 등 무형의 재산권의 보유자가 그 저작물이나 표시 등에 대해서 그것의 사용을 허락하는 계약)을 체결하거나 재판매한다. 음원의 방송심의과정에 관여하여 필요한 조치를 취한다. 공연 및 행사에 관여하여 각종 판촉활동을 한다. 담당하는 음원의 순위를 확인하고 필요에 따라 마케팅전략을 수정한다. 해외영업활동을 하기도 한다. 마케팅전략을 수립하기 위해 사회·문화적 유행을 파악하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"청각|","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0243","dJobECdNm":"[0243]상품 기획자","dJobJCd":"2731","dJobJCdNm":"[2731]상품 기획 전문가","dJobICd":"J639","dJobICdNm":"[J639]기타 정보 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001247:1', '{"dJobCd":"K000001247","dJobCdSeq":"1","dJobNm":"머천다이저","workSum":"소비자의 구매 패턴과 소비유형을 파악하여 시장성 있는 상품을 선정·소싱(구매)한다.","doWork":"소비자의 구매패턴과 소비유형을 파악하여 시장성을 가질 수 있는 물품을 선택한다. 시장성 있는 물품선택 시 판매가능성을 분석하고 물품을 선정한다. 선정된 물품을 생산하는 제조업체와 일정량의 물량공급계약을 체결한다. 판매하기로 약속된 물량을 전산시스템에 입력하여 한정된 물량을 초과하여 판매되는 것을 막는다. 국내시장뿐 아니라 외국 수입업자를 대신해 해당 물품의 생산처 선정부터 주문, 선적까지 맡아서 처리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"엠디(MD), 상품기획자","connectJob":"의류머천다이저, 쇼핑몰머천다이저, 유아용품머천다이저, 식품머천다이저, 전자제품머천다이저, 리테일머천다이저, 소비재머천다이저, 비주얼머천다이저, 홈쇼핑머천다이저, 브랜드매니저","dJobECd":"0243","dJobECdNm":"[0243]상품 기획자","dJobJCd":"2731","dJobJCdNm":"[2731]상품 기획 전문가","dJobICd":"G471","dJobICdNm":"[G471]종합 소매업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007076:1', '{"dJobCd":"K000007076","dJobCdSeq":"1","dJobNm":"모바일상거래기획원","workSum":"무선인터넷을 통한 전자상거래의 비즈니스모델을 기획하고 추진한다.","doWork":"무선인터넷을 통해 제공 가능한 전자상거래기술 및 기존의 서비스를 분석한다. 무선인터넷 시장의 동향 및 고객의 성향을 설문조사 등을 통해 주기적으로 파악한다. 쇼핑, 예약, 복권 등 모바일 전자상거래의 신규 비즈니스모델을 개발하고 추진한다. 무선인터넷 기기별 특성에 맞는 서비스 구축을 기획하고 콘텐츠제공자(CP)를 유치하거나 서비스 연계를 기획한다. 기획한 서비스에 대한 사업타당성평가를 실시하고 신규 비즈니스모델의 개발에 참고로 한다. 전자화폐, 소액결제를 기획하고 추진하기도 한다. 모바일 마케팅을 실시한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","certLic":"전자상거래운용사, 전자상거래관리사(1급, 2급)","dJobECd":"0243","dJobECdNm":"[0243]상품 기획자","dJobJCd":"2731","dJobJCdNm":"[2731]상품 기획 전문가","dJobICd":"G479","dJobICdNm":"[G479]무점포 소매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007077:1', '{"dJobCd":"K000007077","dJobCdSeq":"1","dJobNm":"무선인터넷서비스기획원","workSum":"무선인터넷서비스를 활용한 비즈니스모델을 기획하고 구현한다.","doWork":"상품정보와 상품별 소비자의 요구, 시장, 고객 정보에 대한 분석을 통하여 무선인터넷 콘텐츠 제공을 위한 비즈니스 모델링을 구현하고 사업타당성을 검토한다. PDA, 차량장착단말기(VMT:Vehicle Mounted Terminal), 스마트폰 등의 무선인터넷 플랫폼을 검토하고 새로운 솔루션(Solution)을 이용한 비즈니스모델을 구축한다. 요금, 브랜드 홍보에 관련된 사항을 결정하고 사업추진을 준비한다. 커뮤니티, 위치정보, 채팅, 메신저, 온라인 문자메시지, 멀티미디어 콘텐츠(VOD, AOD), 엔터테인먼트 등의 콘텐츠를 기획한다. 국내외 무선인터넷 관련 콘텐츠제공업체(CP업체)에 개발을 의뢰하며 및 콘텐츠 제공방법·가격 등을 기획하고 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0243","dJobECdNm":"[0243]상품 기획자","dJobJCd":"2731","dJobJCdNm":"[2731]상품 기획 전문가","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004305:1', '{"dJobCd":"K000004305","dJobCdSeq":"1","dJobNm":"문화상품기획자","workSum":"상품으로서의 문화를 기획하고 판매하는 일을 한다.","doWork":"공연예술단체의 경영 및 마케팅 활성화를 비롯해 기업의 문화경영, 도시와 지역의 문화경쟁력 강화를 위한 프로그램 기획, 문화예술 교육프로그램 개발 등을 수행한다. 공연전문업체에서 일하는 경우, 공연의 마케팅전략을 기획한다. 인기가 있는 해외 영화나 드라마, 공연, 전시작품을 한국에 들여와 관객에게 소개한다. 우리나라 드라마 등을 외국에 수출하는 업무를 하기도 한다. 기업의 마케팅부서나 홍보부서에 근무하는 경우, 상품판매율을 높이거나 기업이미지를 개선하기 위해 문화를 활용한 전략과 계획을 세운다. 기업이미지 제고를 위해 기업이 공연이나 전시를 후원하도록 한다. 소비자의 다양한 라이프스타일을 분석해 문화를 통해 소비자의 감성을 자극하는 마케팅전략을 세운다. 문화마케팅 전문업체에서 근무하는 경우, 문화예술을 교육상품으로 만드는 일을 한다. 배우와 극작가들을 통해 교육 참여자들의 발표력이나 말하기 능력을 개발하거나 화가를 초청해 비주얼 및 창의력을 개발할 수 있도록 돕는 등 문화예술을 교육상품으로 만드는 일을 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|시각|","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"문화마케터","dJobECd":"0243","dJobECdNm":"[0243]상품 기획자","dJobJCd":"2731","dJobJCdNm":"[2731]상품 기획 전문가","dJobICd":"C/M","dJobICdNm":"[C]제조업 / [M]전문, 과학 및 기술 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007045:1', '{"dJobCd":"K000007045","dJobCdSeq":"1","dJobNm":"방송콘텐츠기획판매자","workSum":"방송콘텐츠를 국내외 방송콘텐츠 시장에 유통시키기 위한 마케팅전략을 기획하고 판매계약을 체결한다.","doWork":"해외 방송콘텐츠마켓에 참가하여 국제적인 방송콘텐츠의 동향을 파악하고 자사의 콘텐츠를 홍보 및 판매한다. 해외 방송콘텐츠 시장조사를 한다. 판매대상 국가의 사회·문화적 경향, 방송편성 등을 파악하고 마케팅전략을 수립한다. 자사의 방송콘텐츠(드라마, 다큐멘터리, 쇼프로그램, 스포츠 중계 등)를 시청하고 시청률, 시나리오, 출연배우 등 관련 자료를 수집하여 마케팅자료로 정리한다. 해외방송국 또는 수입업자와 가격 및 구매조건을 협의하고 판매계약을 체결한다. 수출용으로 소재를 가공(외국어 대본 작성, 해당 국가 언어로 더빙할 수 있도록 대사제거, 문화적 차이로 인해 문제의 소지가 있는 장면의 조정 등)한다. 불법유통에 대한 시정요청 조치 등을 취하여 콘텐츠 구매자의 권리를 보호한다. 불법콘텐츠가 유통되는 시장에서는 합법적인 거래선을 개발한다. 다양한 방송콘텐츠 매체와 국가별 유통구조(공중파TV, IPTV, 다운로드서비스, 스트리밍서비스, 2차 전송 등)에 대하여 이해하고 계약 관련 업무에 혼돈이 없도록 주의한다. 콘텐츠 홍보를 위해 배우와 함께 해외 비즈니스 투어를 하기도 한다. 자사의 방송콘텐츠제작진에게 해외시청자의 의견을 전달하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"청각|언어력|시각|","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0243","dJobECdNm":"[0243]상품 기획자","dJobJCd":"2731","dJobJCdNm":"[2731]상품 기획 전문가","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005041:1', '{"dJobCd":"K000005041","dJobCdSeq":"1","dJobNm":"부동산개발자","workSum":"사업대상부지의 입지여건, 주변수요 등을 분석하여 적합한 부동산상품을 기획하고, 이를 위한 용지구입, 인허가절차 진행, 자금마련, 건축, 마케팅, 분양, 입주, 정산, 사후관리까지의 총괄적인 업무를 수행한다.","doWork":"사업대상지의 인근생활권, 부지여건, 교통접근성, 편익시설 등을 분석한다. 사업대상지 인근의 인구 및 주택특성, 유동인구, 업종분포, 관공서 및 산업·상업·업무·문화시설의 현황을 분석한다. 사업대상지가 속한 지역의 도시개발계획, 교통시설계획 등을 분석하고, 국토의 계획 및 이용에 관한 법, 건축법, 세법 등 각종 법규를 검토한다. 입지분석 등을 위해 설문조사를 시행하거나 전문가 자문을 받기도 한다. 국내외의 유사 개발사례를 수집하여 분석하기도 한다. 개발환경 분석, 경쟁구조 분석, 마케팅조사, 유사사례 분석 등을 통해 도출된 전략적 시사점을 바탕으로 부동산의 용도, 규모 등 개발방향을 수립한다. 개발에 필요한 소요자금 산출, 자금조달 및 출자계획 수립, 자금수지 분석을 한다. 사업수행 및 사업성 제고를 위하여 체계적인 공간 판매전략을 수립하고 이를 실현하기 위하여 행정절차(인허가)를 진행한다. 개발한 부동산 시설의 성격 및 특성, 운영주체의 관리운영 능력, 입점상인의 특성 등을 종합적으로 분석하여 관리운영시스템을 구축한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"부동산디벨로퍼(Developer), 부동산시행자","certLic":"변호사, 공인회계사, 감정평가사, 공인중개사","dJobECd":"0243","dJobECdNm":"[0243]상품 기획자","dJobJCd":"2731","dJobJCdNm":"[2731]상품 기획 전문가","dJobICd":"L681","dJobICdNm":"[L681]부동산 임대 및 공급업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005021:1', '{"dJobCd":"K000005021","dJobCdSeq":"1","dJobNm":"브랜드개발자","workSum":"소비자의 기호에 맞추어 상품의 시장경쟁력을 높일 수 있는 상품명이나 회사명을 제작한다.","doWork":"의뢰가 들어오면 조건에 맞게 금액을 책정하고 작업팀을 구성한다. 의뢰회사의 마케팅전략, 광고전략, 경쟁사에 대한 전략 등의 자료를 수집분석하여 상품 또는 회사의 특성 등을 파악·분석한다. 폭넓게 관련 자료를 취합하기 위하여 시장조사를 한다. 상품의 종류와 성격에 따라 작명할 언어를 결정하고 발상을 하여 작명한다. 브랜드의 속성, 다른 상표와의 차별성, 상표전략과의 적합성, 기업로고 디자인의 적합성 등을 종합적으로 고려하여 최종적으로 작명을 선정한다. 변리사를 통하여 특허청에 상표등록을 하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"브랜드메이커","dJobECd":"0243","dJobECdNm":"[0243]상품 기획자","dJobJCd":"2731","dJobJCdNm":"[2731]상품 기획 전문가","dJobICd":"M713","dJobICdNm":"[M713]광고업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007046:1', '{"dJobCd":"K000007046","dJobCdSeq":"1","dJobNm":"사물인터넷사업기획자","workSum":"사물인터넷서비스 및 사업을 기획한다.","doWork":"사회 분야의 안전, 복지, 교통, 환경 등에서의 문제점을 점검하고 사물인터넷기술을 활용한 해결방안을 찾는다. 스마트공장, 스마트빌딩, 스마트홈, 휴대용 통신기기 등 다양한 용도에 따라 사용목적에 맞는 서비스 및 제품을 기획한다. 센서, 무선망, 플랫폼 등 필요한 기술요소를 점검하고 구축한다. 서비스 기획에 따라 사전연구와 제품개발, 보안 문제 등 다각도에 대한 문제점을 점검한다. 시제품이 개발되면 제품테스트를 통해 제품의 구동여부를 확인한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"0243","dJobECdNm":"[0243]상품 기획자","dJobJCd":"2731","dJobJCdNm":"[2731]상품 기획 전문가","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007215:1', '{"dJobCd":"K000007215","dJobCdSeq":"1","dJobNm":"상품·공간스토리텔러","workSum":"제품 및 서비스가 판매될 수 있도록 고객의 감성을 자극할 만한 다양한 스토리를 발굴하고 스토리를 기획하고 제작한다.","doWork":"제품 및 서비스와 연관된 스토리를 발굴한다. 제품의 이미지 강화전략, 차별화 전략 및 가격전략 등을 수립해 제품에 담긴 감성과 이야기를 발굴한다. 상품스토리텔러의 경우, 제품의 이미지 강화전략, 차별화 전략 및 가격 전략을 수립해 제품에 담긴 감성 요소를 끌어내고, 이를 기초로 이야기를 만들어 고객이 상품을 구매하는 데 긍정적인 영향을 끼치는 일을 한다. 공간스토리텔러의 경우, 특정 공간을 효과적으로 알리려는 목적으로 관련 스토리를 만들고 이를 전달, 확산시켜 사람들의 공감을 이끌어낸다. 발굴한 스토리를 전략적으로 관리하고 마케팅해서 스토리를 보고 만질 수 있는 것으로 상세하게 표현한다. 고객에게 스토리를 소개하고 계약을 체결하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"제품스토리텔러, 스토리텔러","connectJob":"상품스토리텔러, 공간스토리텔러","dJobECd":"0243","dJobECdNm":"[0243]상품 기획자","dJobJCd":"2731","dJobJCdNm":"[2731]상품 기획 전문가","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002161:1', '{"dJobCd":"K000002161","dJobCdSeq":"1","dJobNm":"생태어메니티전문가","workSum":"농·산·어촌지역 주민들이 자기 지역의 어메니티(Amenity, 사람들에게 휴향적, 심미적 가치를 제공해주는 농산어촌에 존재하는 특징적 모습을 총칭)자원을 활용하여 지역개발을 하도록 업무지원과 컨설팅을 한다.","doWork":"지역활성화를 위한 종합계획을 수립한다. 농·산·어촌의 어메니티자원을 브랜드화하고 관광 및 체험프로그램을 개발한다. 농촌체험마을, 농촌전통테마마을, 자연생태마을, 팜스테이 등 농촌관광사업에 대해 컨설팅한다. 농촌관광사업을 운영할 수 있도록 지역주민들을 교육한다. 생태어메니티사업을 이끌어갈 지역리더들을 양성하는 교육을 한다. NGO단체 소속 직원으로서 농·산·어촌지역의 활성화를 위한 다양한 비영리사업을 수행한다. 중앙정부나 지방자치단체의 연구직 공무원 또는 지역개발연구소의 연구원으로서 농·산·어촌의 어메니티 관련 정책개발 및 제도적 지원업무를 수행한다. 중앙정부나 지방자치단체의 연구직 공무원 또는 지역개발연구소의 연구원으로서 농·산·어촌의 어메니티 관련 정책개발 및 제도적 지원업무를 수행하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"그린어메니티전문가, 농촌어메니티전문가","dJobECd":"0243","dJobECdNm":"[0243]상품 기획자","dJobJCd":"2731","dJobJCdNm":"[2731]상품 기획 전문가","dJobICd":"M715","dJobICdNm":"[M715]회사 본부 및 경영 컨설팅 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002925:1', '{"dJobCd":"K000002925","dJobCdSeq":"1","dJobNm":"소셜커머스거래품질관리자","workSum":"영업사원들이 수주한 딜(Deal)을 내부기준에 맡게 선정하고, 판매율, 고객 피드백 등에 대한 자료분석을 통해 영업방침을 설정한다.","doWork":"회사의 전략과 과제, 판매량, 고객 피드백 등을 확인하고, 이를 바탕으로 영업전략을 세운다. 영업사원들이 수주해온 딜(Deal)을 회사의 가치 및 분석된 자료를 바탕으로 판매 가능한 딜(Deal)과 변경해야 할 딜(Deal), 폐기해야 할 딜(Deal)을 구분하여 선정한다. 판매실적 자료, 고객들의 피드백 등을 바탕으로 판매결과를 분석하고 이를 바탕으로 향후 영업방침을 설정한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"Deal Quality Assurance Manager","dJobECd":"0243","dJobECdNm":"[0243]상품 기획자","dJobJCd":"2731","dJobJCdNm":"[2731]상품 기획 전문가","dJobICd":"G479","dJobICdNm":"[G479]무점포 소매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001616:1', '{"dJobCd":"K000001616","dJobCdSeq":"1","dJobNm":"스마트헬스케어서비스기획자","workSum":"스마트헬스케어서비스(건강측정기 등 액세서리나 웨어러블기기를 활용하여 개인이 스스로 운동량, 심전도, 심장박동 등을 체크해 건강을 관리할 수 있는 서비스)를 기획·개발한다.","doWork":"사용자 조사를 실시하여 성인, 어린이, 남녀 등 이용자의 형태, 특성, 요구사항 등을 파악하고 분석한다. 비만관리, 성인병 예방, 건강증진 프로그램 등 제공할 서비스의 목표와 기능을 정의한다. 서비스콘텐츠(다이어트 식단, 영양가이드, 식습관 평가 및 섭취량 조절, 식단평가, 운동량 평가, 운동방법 지도 등)를 기획한다. 고객의 건강상태를 평가하고 서비스를 제공하기 위한 지표를 개발한다. 서비스 알고리즘(사용자로부터 수집된 건강정보를 분석·평가하여 적절한 헬스케어서비스를 제공하도록 구조화한 체계)을 개발한다. 서비스 사용자환경(UI, UX)을 기획한다. 각 분야의 디바이스개발자, 어플리케이션개발자에게 의뢰하여 서비스를 구현한다. 베타서비스를 테스트하고 검증·보완한다. 서비스가 실시되면 서비스의 품질을 평가하고 오류를 수정·보완한다. 새로운 콘텐츠를 업데이트한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"U-헬스케어서비스기획자","dJobECd":"0243","dJobECdNm":"[0243]상품 기획자","dJobJCd":"2731","dJobJCdNm":"[2731]상품 기획 전문가","dJobICd":"C271","dJobICdNm":"[C271]의료용 기기 제조업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004369:1', '{"dJobCd":"K000004369","dJobCdSeq":"1","dJobNm":"실버로봇서비스기획자","workSum":"노인들이 필요로 하는 다양한 서비스가 실버로봇(노인서비스 로봇)을 통해 구현될 수 있도록 상품, 서비스 콘텐츠를 기획한다.","doWork":"노인들이 필요로 하는 실버서비스를 연령대, 성별, 경제력, 건강상태, 주거상태 등 분야별로 조사한다. 실버로봇을 개발하여 판매하고자 하는 고객과의 미팅을 통해 판매대상 및 서비스 범주를 결정한다. 결정된 실버서비스 범주 안에서 더 자세한 서비스 콘텐츠를 기획한다. 필요시 실버로봇에서 사용자의 건강을 검진할 수 있는 외부기기나 통신망과의 연결을 모색한다. 서비스콘텐츠가 기획되면 이러한 콘텐츠나 실버서비스를 이용할 수 있는 메뉴를 개발한다. 로봇의 사용방법, 메뉴의 폰트나 화면의 색상 같은 디자인 등이 노인들에게 적합하도록 설계한다. 설계된 스토리보드를 프로그램개발자, 로봇엔지니어, 당뇨모니터링 담당자와 같은 실버서비스 제공자들에게 설명하여 고객과 사용자가 원하는 실버서비스가 로봇을 통해 구현되도록 한다. 실버로봇테스트나 시범사업을 통해 실버서비스가 현실적으로 구현가능하고 노인들이 꼭 필요로 하는 것인지 검증하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"돌봄로봇서비스기획자, 돌봄로봇사업프로젝터매니저, 돌봄로봇프로덕트매니저","dJobECd":"0243","dJobECdNm":"[0243]상품 기획자","dJobJCd":"2731","dJobJCdNm":"[2731]상품 기획 전문가","dJobICd":"C292/M701","dJobICdNm":"[C292]특수 목적용 기계 제조업 / [M701]자연과학 및 공학 연구개발업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006765:1', '{"dJobCd":"K000006765","dJobCdSeq":"1","dJobNm":"웹머천다이저","workSum":"웹에서 상품판매를 위한 상품 기획 및 상품 선정을 하고, 협력사와 가격협상을 하는 등 상품판매를 총괄한다.","doWork":"상품아이템을 기획한다. 상품군 단위로 구매처를 확보한다. 상품의 구매가격을 협상하고, 수량을 결정한다. 상품을 디지털 카메라로 촬영한다. 웹에 등록하는 과정에서 기본 이미지를 편집한다. 상품에 대한 기본정보를 수록한다. 상품의 판매현황을 분석한다. 상품군의 시장동향을 파악한다. 협력업체를 관리한다. 상품에 대한 고객의 불만사항을 처리하기 위해 배송현황을 점검한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"제어조작","similarNm":"웹엠디(MD)","certLic":"전자상거래운용사","dJobECd":"0243","dJobECdNm":"[0243]상품 기획자","dJobJCd":"2731","dJobJCdNm":"[2731]상품 기획 전문가","dJobICd":"G479","dJobICdNm":"[G479]무점포 소매업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006445:1', '{"dJobCd":"K000006445","dJobCdSeq":"1","dJobNm":"웹호스팅기획자","workSum":"웹호스팅 서비스에 대한 사업계획 및 추진계획을 수립하고 관련 상품을 개발하여 서비스를 제공한다.","doWork":"독자적으로 웹서버(Web Sever)를 운영할 수 없는 고객을 위하여 고객의 홈페이지를 대신 운영하는 웹호스팅 서비스에 대한 계획을 세우고 사업계획 및 추진계획을 수립한다. 계획에 따라 서비스별로 설계하여 상품을 개발한다. 개발된 기능이 원활히 작동되는지 확인하기 위하여 검사한다. 상품에 이상이 없을 때 서비스를 개시한다. 도메인 등록을 대행하고 전자우편 계정을 발급하며 FTP계정과 각종 데이터베이스를 제공한다. 게시판과 방명록, 웹 프로그램 등을 지원한다. 기업(기관)을 대상으로 인터넷 전용선 서비스와 자체 웹(Web)서버를 구축해 주기도 한다. 고객이 인터넷을 잘 사용하도록 고객의 욕구를 만족시켜주는 고객지원업무를 실시한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0243","dJobECdNm":"[0243]상품 기획자","dJobJCd":"2731","dJobJCdNm":"[2731]상품 기획 전문가","dJobICd":"J631","dJobICdNm":"[J631]자료처리, 호스팅, 포털 및 기타 인터넷 정보매개 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001440:1', '{"dJobCd":"K000001440","dJobCdSeq":"1","dJobNm":"위성방송상품개발원","workSum":"고객에게 보다 나은 서비스를 제공하기 위하여 위성방송서비스 상품에 대한 신규 및 부가서비스를 개발·보급한다.","doWork":"인공위성을 통한 디지털방송시스템(Digital Broadcasting System)사업을 준비한다. 사업추진계획서를 작성하고 방송법인 컨소시엄을 구성한다. 방송제작 시설계획을 수립한다. 방송제작 시설 투자사업을 계획하고 방송장비 규격안을 작성한다. 방송시설 공사를 집행하고 프로그램 제작계획을 수립한다. 위성방송사업과 관련된 정부관계부처와 연락을 한다. 위성방송 시험방송계획을 수립한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","certLic":"방송통신기사","dJobECd":"0243","dJobECdNm":"[0243]상품 기획자","dJobJCd":"2731","dJobJCdNm":"[2731]상품 기획 전문가","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007118:1', '{"dJobCd":"K000007118","dJobCdSeq":"1","dJobNm":"음악머천다이저","workSum":"팬덤 등 소비자 시장 동향을 고려하여 아티스트별 굿즈를 기획하고 판매전략을 수립한다.","doWork":"팸덤 내 소비자의 소비행태를 분석하고 시장을 조사한다. 시장조사 결과를 바탕으로 아티스트의 브랜드 전략을 바탕으로 굿즈 등의 상품을 기획한다. 음악과 음원 저작권을 고려하여 저작권을 보호하고 상품을 발굴·제작한다. 기획한 상품을 판매하며 상품의 필요와 특성에 따라 팝업스토어 등의 프로모션을 진행하기도 한다. 상품의 재고를 관리하고 새로운 상품의 기획을 위해 판매현황을 분석한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"음악MD, 굿즈기획자","certLic":"컴퓨터그래픽스운용기능사","dJobECd":"0243","dJobECdNm":"[0243]상품 기획자","dJobJCd":"2731","dJobJCdNm":"[2731]상품 기획 전문가","dJobICd":"J592/M732","dJobICdNm":"[J592]오디오물 출판 및 원판 녹음업 / [M732]전문 디자인업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003216:1', '{"dJobCd":"K000003216","dJobCdSeq":"1","dJobNm":"의류상품기획자","workSum":"소비자의 구매패턴과 소비유형을 파악하여 시장성 있는 의류상품을 기획하고, 생산과정의 제반 업무를 조정한다.","doWork":"의류상품에 대한 현재의 판매수준, 소비자 평가 등에 관한 정보를 수집·분석하고, 소비자의 현재 또는 장래 취향을 예측하여 의류상품을 기획한다. 신제품 개발회의를 주관하여 자사의 매출현황, 상품의 시장규모, 경쟁제품, 소비자의 구매유형 등을 고려하여 생산할 신제품을 결정한다. 수시로 디자이너, 개발자 및 제조업체와 협의한다. 생산수량과 소비자가격 등을 결정하여 최종 생산품목을 결정한다. 제조업체와 생산계약을 체결한다. 생산제품의 시장반응을 조사·분석하고 제품의 개선점을 도출하여 적용한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0243","dJobECdNm":"[0243]상품 기획자","dJobJCd":"2731","dJobJCdNm":"[2731]상품 기획 전문가","dJobICd":"C","dJobICdNm":"[C]제조업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007783:1', '{"dJobCd":"K000007783","dJobCdSeq":"1","dJobNm":"인공지능서비스기획자","workSum":"인공지능 서비스를 기획하기 위하여 인공지능 서비스 목표 수립, 모델 기획, 시나리오 기획, 서비스 활용 기획, 서비스 실행 기획, 서비스 평가 기획, 서비스 요건 정의 등의 업무를 수행한다.","doWork":"서비스 대상 고객을 확인하고, 인공지능 서비스의 목표를 설정한 후 관련된 법·윤리 사항을 고려하여 목표를 정한다. 요구사항 분석 결과에 따라 인공지능 서비스에 필요한 구성요소를 분석하여 데이터를 정의하고 샘플을 확보하여 인공지능 서비스 모델을 선정 및 검증한다. 인공지능 서비스 요소들의 기능적 상호작용에 대한 흐름을 체계화하고 타당성을 검증하여 시나리오를 확정한다. 인공지능 서비스 적용 범위를 확대하기 위하여 인공지능 서비스 활용방안을 분석하고 비즈니스 모델을 기획하여 자산화 계획을 수립한다. 인공지능 서비스 실행을 위한 조직, 인프라, 일정, 소요 예산을 계획하고 위험에 대응하기 위한 계획을 수립한다. 인공지능 서비스의 실효성을 위한 평가 기준과 평가 방법을 마련하여 성과평가를 실행할 수 있도록 기획한다. 수립된 인공지능 서비스 목표 달성을 위해 기술·시장 환경을 분석한 뒤 서비스 요건을 명확화하고 필요 자원을 정의한다. 인공지능 서비스에서 발생하는 데이터를 정의하고, 확보, 정제, 가공하여 최종 데이터의 품질 검증을 계획한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"데이터분석전문가, 데이터분석준전문가, 데이터아키텍처전문가, 데이터아키텍처준전문가, 정보관리기술사, 정보처리기사, 컴퓨터시스템응용기술사, 빅데이터분석기사","dJobECd":"0243","dJobECdNm":"[0243]상품 기획자","dJobJCd":"2731","dJobJCdNm":"[2731]상품 기획 전문가","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2025"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006928:1', '{"dJobCd":"K000006928","dJobCdSeq":"1","dJobNm":"제품개발관리자(Product Owner)","workSum":"제품 및 서비스의 개발개선을 위해 목표설정, 고객요구사항 구안, 일정계획 수립, 사업 우선순위 결정을 비롯하여 개발자, 디자이너 등과 협업소통을 하고 업무 조율 및 조정 등을 수행 한다.","doWork":"비즈니스 목표 달성을 위한 디자이너, 개발자 등과 논의하여 공동목표 설정 및 요건을 정의하고 업무추진에서 우선순위를 결정한다. 고객을 대변하면서 사업적 가치를 창출할 수 있는 가설을 설정한다. 가설 검증 방법을 구안 및 계획하고 개발 및 디자인 요구사항을 정의한다. 성공지표 및 세부 지표 등을 검토하고 데이터를 분석한다. 목표달성을 위한 일정계획을 수립한다. 사용성 테스트를 진행하고 고객 피드백을 정리하고 개발팀과 공유한다. 이해관계자 및 다양한 부서와의 협업과 소통을 하며 업무를 조정조율한다. 이슈와 위협요소를 관리하고 문제발생 시 내용분석과 문제 해결 방법을 결정한다. 제품개발 이후 고객의 사용 과정을 관찰하고 고객 및 유관 부서와의 소통을 통해 개발 백로그를 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"PO(Product Owner), 프로덕트매니저, 사업기획자, 상품기획자, 제품기획자","dJobECd":"0243","dJobECdNm":"[0243]상품 기획자","dJobJCd":"2731","dJobJCdNm":"[2731]상품 기획 전문가","dJobICd":"ALL","dJobICdNm":"[ALL]전체","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005776:1', '{"dJobCd":"K000005776","dJobCdSeq":"1","dJobNm":"제품기획자(일반)","workSum":"회사의 중장기 경영전략에 따라 도출된 제품의 개발계획에 따라 신제품 개발계획을 수립하고 개발에 필요한 사항을 관련 부서와 협의·조율하여 제품을 개발한다.","doWork":"장단기 개발계획과 자체계획에 의해 최신 기술정보 및 시장정보를 수집·분석한다. 분석결과와 실험결과를 종합하여 사전원가계산, 경제성, 시장성, 작업성, 원자재 수급사정, 양산성, 투자비 등을 고려하여 개발타당성을 검토한다. 개발방안이 확정되면 제품구성, 공정, 처방, 배합, 가공방법 등 제품개발에 필요한 구체적인 사항과 개발일정을 관련 부서와 협의·확정한다. 승인된 개발일정계획을 관련 부서에 통보하고 계획에 따라 진행하도록 한다. 개발이 완료되어 양산체계를 갖추면 관련 제조부서에 제반 관련 규격을 작성·배부하고 제조에 필요한 제반 서류작성을 의뢰한다. 판매원교육과 시장분석, 소비자불만에 대한 대책수립, 판매지원업무를 수행한다. 개발 도중 모집 혹은 작성된 제반 관계 자료를 취합·정리하고 기술축적 및 개발에 활용한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"상품개발담당자, 친환경제품기획자","connectJob":"자동차제품기획자, 기계제품기획자, 전기제품기획자, 전자제품기획자, 화학제품기획자, 통신제품기획자, 섬유제품기획자, 식품기획자 등","dJobECd":"0243","dJobECdNm":"[0243]상품 기획자","dJobJCd":"2731","dJobJCdNm":"[2731]상품 기획 전문가","dJobICd":"C","dJobICdNm":"[C]제조업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004985:1', '{"dJobCd":"K000004985","dJobCdSeq":"1","dJobNm":"카테고리매니저","workSum":"온라인쇼핑몰에서 담당 상품군을 알리기 위한 마케팅을 하고, 판매자와 구매자를 효율적으로 연결하고 관리한다.","doWork":"온라인쇼핑몰의 담당 상품군을 운영하면서 구매자가 쉽게 온라인에서 신규상품을 살펴볼 수 있도록 관련 정보를 수집하여 제공한다. 신규업체 입점, 신상품 런칭 진행을 위해 판매자와 상담 및 진행업무를 총괄한다. 매출을 올리기 위하여 관련 정보를 제공하고, 이벤트를 기획한다. 담당 상품군을 이해하기 위해 관련 서적을 읽거나 시장조사를 한다. 새로운 상품, 소비자의 기대수요가 높은 상품 등을 검토하여 매출전략을 세운다. 매출집계를 확인하고 경쟁력을 잃은 부분을 분석하여 대책을 마련한다. 경쟁업체를 분석하여 전략을 세운다. 판매자 및 구매자의 불만사항을 처리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"CM(Category Manager)","connectJob":"머천다이저(MD)","dJobECd":"0243","dJobECdNm":"[0243]상품 기획자","dJobJCd":"2731","dJobJCdNm":"[2731]상품 기획 전문가","dJobICd":"G479","dJobICdNm":"[G479]무점포 소매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002288:1', '{"dJobCd":"K000002288","dJobCdSeq":"1","dJobNm":"캐릭터머천다이저","workSum":"소비자시장의 동향을 고려하여 캐릭터를 기획하고 상품화를 위한 기획 및 판매전략을 수립한다.","doWork":"소비자의 캐릭터 선호도 및 구매유형 등의 시장동향을 파악하여 디자인된 캐릭터의 성공가능성을 판단하고, 수시로 디자이너 및 제작업체와 협의한다. 라이선스, 유통사, 파트너를 선정한다. 완구, 교육, 출판, 모바일, 게임, 애니메이션, 방송, 온라인 등의 비즈니스 모델을 선정한다. 상품을 기획한다. 판매전략을 수립하고 판매처를 선택한다. 캐릭터를 개발·제작하는 일을 수행하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"언어력|시각|","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"캐릭터MD","certLic":"컴퓨터그래픽스운용기능사","dJobECd":"0243","dJobECdNm":"[0243]상품 기획자","dJobJCd":"2731","dJobJCdNm":"[2731]상품 기획 전문가","dJobICd":"J591/M732","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업 / [M732]전문 디자인업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007119:1', '{"dJobCd":"K000007119","dJobCdSeq":"1","dJobNm":"클라우드서비스기획자","workSum":"클라우드서비스 사용자를 위한 제반 플랫폼 및 서비스를 기획한다.","doWork":"조직·프로젝트 관리, 빌링·결제 등 클라우드 프레임워크를 기획한다. 결제, 포인트, 정산 플랫폼을 설계하고 프로젝트 진행을 관리한다. 매출 및 결산지원과 재무지표를 관리한다. 서비스 운영 프로세스 및 정책을 수립하고 개선작업을 수행한다. RDS, SMS, Email, Push, DNS 등 서비스를 기획한다. 사용자 프론트 및 백엔드 서비스를 기획한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"클라우드플랫폼기획자","dJobECd":"0243","dJobECdNm":"[0243]상품 기획자","dJobJCd":"2731","dJobJCdNm":"[2731]상품 기획 전문가","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007120:1', '{"dJobCd":"K000007120","dJobCdSeq":"1","dJobNm":"패션기술디자이너","workSum":"의류 제작에 있어 각 스타일의 핏, 패턴, 수정, 봉제, 디테일 작업방식 그리고 품질을 결정하고 지시하는 업무를 한다.","doWork":"디자인팀, 상품기획자(MD)와 파트너로 일하며 종합작업지시서(Technical Package)로 의사소통을 한다. 제품제작과 개발단계에서 필요한 창의적인 업무, 수정, 최종 Tech Pack 확정 등 생산의 시작에서부터 전체 공정을 총괄하고 의사 결정한다. 각각의 업체와 Tech Pack에 지시된 의류사양들이 정확히 반영되어 생산이 될 수 있도록 지시하고 조정한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|시각|","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"테크니컬디자이너(Technical Designer)","dJobECd":"0243","dJobECdNm":"[0243]상품 기획자","dJobJCd":"2731","dJobJCdNm":"[2731]상품 기획 전문가","dJobICd":"C","dJobICdNm":"[C]제조업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007433:1', '{"dJobCd":"K000007433","dJobCdSeq":"1","dJobNm":"프로덕트매니저(일반)","workSum":"상품의 비전, 전략, 추진 로드맵을 수립하고 개발, 영업, 마케팅 등 유관부서와 소통 및 협의 등을 이끌며 차별적인 상품을 개발개선출시 하는 등 제품개발개선을 총괄관리한다.","doWork":"상품의 비전, 전략, 추진로드맵을 수립한다. 시장 및 고객 요구사항을 수집, 분석하여 우선순위화 한다. 분석 도구 등을 사용하여 사용자 또는 구매자의 니즈를 분석하여 상품 기획 및 전략에 반영하다. 데이터 분석 등을 통해 프로젝트 추진과정에서 개선 및 개발 내용의 우선순위 및 핵심기능을 결정한다. 사업 또는 상품계획이 개발, 세일즈, 마케팅 등 유관부서와 소통 및 협의를 통해 효과적 및 효율적으로 실현되도록 이들과 소통하며 조정, 조율 한다. 최종 출품을 위해 테스트 등을 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"PO(Product Owner), 사업기획자, 상품기획자, Product Manager, 서비스기획자","dJobECd":"0243","dJobECdNm":"[0243]상품 기획자","dJobJCd":"2731","dJobJCdNm":"[2731]상품 기획 전문가","dJobICd":"ALL","dJobICdNm":"[ALL]전체","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007121:1', '{"dJobCd":"K000007121","dJobCdSeq":"1","dJobNm":"해외마케터(일반)","workSum":"상품 및 관련 시장 전반에 대한 이해를 바탕으로 해외공급거래선 관리, 구매관리, 상품개발 및 수출입 등 해외마케팅 활동 전반에 대한 역할을 수행한다.","doWork":"신상품개발을 위해 해외 전시회 참관 및 공급업체 방문 등으로 우량의 해외업체를 발굴한다. 중장기 신상품 개발 계획을 수립하고 이에 따르는 프로세스를 진행한다. 정기 방문으로 해외업체의 실태를 파악하며, 수시로 유선매체 및 e메일을 통해 해외공급업체를 관리한다. 상품 개발 과정의 검수, 가격 및 이익율 책정, 발주계획 수립, 납기 관리, 발주 확정 등 구매전반의 실무업무를 진행한다. PB상품의 포장 디자인 기획 및 홍보 등 사후관리까지의 업무 전반을 담당한다. 상품 통관업무 및 제반 인증업무와 홍보 및 광고물 제작, 상품교육 등의 업무를 담당한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","connectJob":"게임해외마케터, 해외상품관리자","dJobECd":"0243","dJobECdNm":"[0243]상품 기획자","dJobJCd":"2731","dJobJCdNm":"[2731]상품 기획 전문가","dJobICd":"ALL","dJobICdNm":"[ALL]전체","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007122:1', '{"dJobCd":"K000007122","dJobCdSeq":"1","dJobNm":"화장품브랜드매니저","workSum":"화장품 브랜드 비즈니스 전략 수립, 상품개발, 원가관리, 예산관리, 세일즈방향성 수립 등을 총괄한다.","doWork":"화장품 브랜드 기획과 브랜드의 철학을 담은 제품 및 서비스를 기획, 개발한다. 리서치나 트렌드 세미나, 국내외 시장 조사를 통해 매년 방향성을 점검하고 구체적인 BI, 상품(패키지), 마케팅 커뮤니케이션, 프로모션 등 목표를 세운다. 브랜드 운영에 맞는 상품 포트폴리오를 세우고, 시장에 출시할 일정에 맞춰서 제품을 개발해 마케팅과 세일즈할 수 있도록 지원한다. 유관부서 및 협력사와 지속적으로 커뮤니케이션하여 용기 디자인, 원가 경쟁력 등을 점검한다. 브랜드의 기획, 홍보, 마케팅의 정량적, 정성적인 결과를 검토하고 방향성에 반영한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0243","dJobECdNm":"[0243]상품 기획자","dJobJCd":"2731","dJobJCdNm":"[2731]상품 기획 전문가","dJobICd":"C204","dJobICdNm":"[C204]기타 화학제품 제조업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007123:1', '{"dJobCd":"K000007123","dJobCdSeq":"1","dJobNm":"화장품상품기획자","workSum":"새로운 화장품을 개발하거나 기존기능을 개선하기 위해 기획업무를 하고 제품이 개발될 때까지 관리한다.","doWork":"시장조사 및 트렌드 분석을 통해 기초와 색조 등 화장품 상품을 기획한다. 신규 브랜드의 기획을 제안한다. 신제품의 기획 및 개발업무를 수행한다. 개발 및 런칭 계획을 수립한다. 업체 관리 및 신규업체를 관리한다. 개발 부서 및 거래업체와 소통하여 원활한 상품이 출시되도록 관리한다. 판매 채널별 전략 및 제품 운영 계획을 수립한다. 제품의 전반적은 마케팅 계획을 수립하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"화장품상품개발자","dJobECd":"0243","dJobECdNm":"[0243]상품 기획자","dJobJCd":"2731","dJobJCdNm":"[2731]상품 기획 전문가","dJobICd":"C204","dJobICdNm":"[C204]기타 화학제품 제조업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001938:1', '{"dJobCd":"K000001938","dJobCdSeq":"1","dJobNm":"휴대폰UI/UX기획자","workSum":"편리한 사용자의 니즈와 목표를 검토하고 사용자 요구사항을 반영한 UI/UX의 기능과 콘텐츠를 기획한다.","doWork":"휴대폰의 편리한 사용자 인터페이스를 제공하기 위하여 사용자의 요구사항을 분석한다. 하드웨어 특성을 고려한 UI/UX의 기능을 분석하여 UI/UX 디자인을 검토한다. 검토한 UI/UX의 기능을 바탕으로 UI/UX 디자인을 기획한다. 서비스 시나리오와 제품사양을 기준으로 사용자에게 최대한의 사용자 경험을 제공하기 위해 사용 환경과 사용자 요구사항의 UI/UX 기능을 분석한다. 인간공학적인 사용성과 편리성을 고려하여 UI/UX를 설계한다. 체계적인 방법으로 제품과 서비스를 이용하는 사용자를 정의하고 목표 사용자, 사용자의 니즈(Needs)와 목표, 이용행태에 관한 계획을 수립하여 자료를 수집한다. 시장의 사용자 니즈를 반영하여 UI/UX를 개발하기 위해 UI/UX에 관련된 트렌드, 경쟁환경과 내부역량을 분석한다. UI/UX 분석결과를 바탕으로 UI/UX 콘셉트를 도출하고 기능과 콘텐츠를 기획한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","certLic":"서비스경험디자인기사","dJobECd":"0243","dJobECdNm":"[0243]상품 기획자","dJobJCd":"2731","dJobJCdNm":"[2731]상품 기획 전문가","dJobICd":"C264","dJobICdNm":"[C264]통신 및 방송 장비 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003933:1', '{"dJobCd":"K000003933","dJobCdSeq":"1","dJobNm":"휴대폰상품기획자","workSum":"휴대폰의 시장, 기술, 제품동향을 분석하고 차별화와 수익성을 반영한 기획안을 작성하여 실행전략을 수립한다.","doWork":"휴대폰과 관련된 사회적·문화적인 동향, 고객의 요구사항, 디자인동향 등을 검토한다. 휴대폰의 시장규모와 성장성, 수요량와 공급량, 시장점유율, 목표시장에 대해 분석한다. 휴대폰의 기술동향과 경쟁사동향, 인증규제와 특허에 대해 자료를 수집하고 분석한다. 자사의 인적·물적 자원과 보유기술력, 자금상황 등을 파악한다. 국내외 경쟁력을 확보하기 위하여 기존 출시제품의 특징과 자사 브랜드 가치를 분석하여 차별화 요소를 파악한다. 디자인 콘셉트, 제품 콘셉트와 경쟁력, 제품화 타당성을 분석한다. 휴대폰의 제품화를 위한 출시일정과 자원배치, 예산 등을 수립하고 제품원가와 수익성을 분석한다. 종합적인 자료를 기반으로 기획안 초안을 만들고, 최근 이슈와 위험요소를 분석하여 각 부서의 요구사항을 반영한 후 최종 기획안을 작성한다. 휴대폰을 개발하기 위해 연구개발, 디자인, 마케팅 등 관련 부서의 협의하고 조정하다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0243","dJobECdNm":"[0243]상품 기획자","dJobJCd":"2731","dJobJCdNm":"[2731]상품 기획 전문가","dJobICd":"C264","dJobICdNm":"[C264]통신 및 방송 장비 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007144:1', '{"dJobCd":"K000007144","dJobCdSeq":"1","dJobNm":"관광두레PD","workSum":"지역관광 활성화를 위해 지역주민들의 관광사업 공동체인 관광두레의 수요를 파악하고 사업계획 수립 등을 돕는다.","doWork":"지역주민의 수요를 파악하고 차별성 있고 잠재력 및 발전 가능성이 높은 예비 주민 사업체를 선별 발굴한다. 사업계획 수립을 지원한다. 주민과 함께 관광사업을 꾸려가기 위하여 주민 조직을 발굴하고 서로 연계해 준다. 사업모델을 제안하고 지원한다. 지역 관광객 유치를 위한 홍보 및 관광 콘텐츠를 기획한다. 지역관광 활성화를 위해 지역 자원을 발굴, 육성할 수 있도록 지원한다. 색다른 지역 관광상품을 제안하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"5211","dJobECdNm":"[5211]여행상품 개발자","dJobJCd":"2732","dJobJCdNm":"[2732]여행 상품 개발자","dJobICd":"N752","dJobICdNm":"[N752]여행사 및 기타 여행보조 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003347:1', '{"dJobCd":"K000003347","dJobCdSeq":"1","dJobNm":"국내여행MD","workSum":"국내 관광상품을 기획 및 개발하며, 고객에게 상품 추천 업무를 수행한다.","doWork":"새로운 여행지 개발을 위해 정보를 수집한다. 수집된 정보를 토대로 개발가능성과 시장성 등을 판단하여 여행상품 개발 여부를 결정한다. 국내의 항공, 육로 및 해상 교통편, 요금, 관광명소의 위치, 숙박시설 등에 관한 제반 자료를 토대로 관광 코스와 일정을 기획하고 예상경비를 산출한다. 기획된 코스를 답사하고 문제점을 보완하여 관광 코스를 확정 짓고 최종 경비를 산출한다. 그들의 요구사항을 파악하여 여행상품을 추천한다. 상품의 특성, 장점 등을 소개하여 여행상품을 추천한다. 여행을 마친 고객에 대한 사후관리를 통하여 신상품을 개발하고, 기존상품을 보완한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"국내여행상품개발자, 국내여행상품수배기획자","dJobECd":"5211","dJobECdNm":"[5211]여행상품 개발자","dJobJCd":"2732","dJobJCdNm":"[2732]여행 상품 개발자","dJobICd":"N752","dJobICdNm":"[N752]여행사 및 기타 여행보조 서비스업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001345:1', '{"dJobCd":"K000001345","dJobCdSeq":"1","dJobNm":"농촌관광플래너","workSum":"농촌의 자연, 사회·문화, 그리고 인적 자원을 활용하여 농촌체험 및 농촌여행 상품을 기획, 개발하고 안내하며 체험시설 등을 운영한다.","doWork":"농촌체험 및 여행상품에 대한 시장조사와 상품성 검토, 자원관리, S.T.P전략 및 마케팅믹스를 한다. 농촌체험 및 여행상품을 기획 및 개발한다. 농촌체험시설 및 관광시설을 안내한다. 체험 등 관련 시설을 운영하기 위한 계획을 수립한다. 시설 운영과정에서 안전관리, 홍보고객관리, 서비스품질 관리 등을 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","connectJob":"농촌관광해설사, 농촌체험해설사, 팜파티지도사, 농촌체험휴양마을운영자, 농촌체험사무장","certLic":"국내여행안내사, 관광통역안내사, 농어촌개발컨설턴트, 농어촌퍼실리테이터","dJobECd":"5211","dJobECdNm":"[5211]여행상품 개발자","dJobJCd":"2732","dJobJCdNm":"[2732]여행 상품 개발자","dJobICd":"N752","dJobICdNm":"[N752]여행사 및 기타 여행보조 서비스업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002336:1', '{"dJobCd":"K000002336","dJobCdSeq":"1","dJobNm":"럭셔리여행개발자","workSum":"해외 바이어 등 소수의 고객을 대상으로 고급스러운 여행을 제안하고 안내한다.","doWork":"기업체의 외국인 바이어, 외국인 VIP 고객 등을 대상으로 기획된 여행지를 안내하고 한국의 문화콘텐츠를 소개한다. 개인 또는 소수 단체를 전담으로 안내하고 전문성 있는 안내를 제공한다. 고객이 원하는 미술관 및 박물관 등의 문화·예술 시설, DMZ, 전쟁기념관 등의 안보 관광 콘텐츠와 같은 여행지 또는 전통문화 체험 시설을 안내하고 해당 시설에 대한 정보를 제공한다. 지방 축제방문, 김치나 된장 담그기 등 보통의 여행자들이 경험하지 못하는 특색 있는 여행을 안내하거나 국제행사 등의 여행을 안내하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"언어력|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"VIP의전가이드, 럭셔리VIP관광안내원","certLic":"관광통역안내사(러시아어), 관광통역안내사(말레이/인도네시아어), 관광통역안내사(베트남어), 관광통역안내사(독어), 관광통역안내사(불어), 관광통역안내사(스페인어), 관광통역안내사(아랍어), 관광통역안내사(영어), 관광통역안내사(이탈리아어), 관광통역안내사(일본어), 관광통역안내사(중국어), 관광통역안내사(태국어)","dJobECd":"5211","dJobECdNm":"[5211]여행상품 개발자","dJobJCd":"2732","dJobJCdNm":"[2732]여행 상품 개발자","dJobICd":"N752","dJobICdNm":"[N752]여행사 및 기타 여행보조 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006772:1', '{"dJobCd":"K000006772","dJobCdSeq":"1","dJobNm":"여행컨설턴트","workSum":"고객의 요구사항을 듣고 맞춤형 자유여행을 컨설팅하고 기획한다.","doWork":"패키지여행이 아닌 자유여행을 가고자 하는 고객의 맞춤형 여행을 기획한다. 고객과 상담을 통해 여행 목적과 평소의 생활습관, 여행 경비 등을 파악한다. 파악된 고객의 여행 콘셉트에 맞춰 항공 및 숙소, 관광지 및 레스토랑 등을 안내하고 가이드 여부 등 여행에 필요한 모든 것을 계획하고 정보를 제공한다. 출장을 통해 숙소, 식당, 관광지 및 마사지숍, 활동시설(액티비티 시설) 등을 방문하여 추천지를 점검하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","dJobECd":"5211","dJobECdNm":"[5211]여행상품 개발자","dJobJCd":"2732","dJobJCdNm":"[2732]여행 상품 개발자","dJobICd":"N752","dJobICdNm":"[N752]여행사 및 기타 여행보조 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001492:1', '{"dJobCd":"K000001492","dJobCdSeq":"1","dJobNm":"지역별여행상품운영원","workSum":"여행지의 관광시설 등을 예약하는 일을 한다.","doWork":"여행지의 여행사에 소속되어 국내의 여행사로부터 현지의 여행지 예약을 의뢰받으면 여행상품의 구성요소 중 항공권을 제외한 숙박, 교통, 음식 등을 사전에 확보하여 예약 업무를 수행한다. 여행사를 대상으로 영업활동을 한다. 국내의 아웃바운드 여행사를 대신하여 현지의 인바운드 여행사와 연락하여 업무가 원활히 진행되도록 지원한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"투어오퍼레이터(Tour Operator), 랜드오퍼레이터(Land Operator)","dJobECd":"5211","dJobECdNm":"[5211]여행상품 개발자","dJobJCd":"2732","dJobJCdNm":"[2732]여행 상품 개발자","dJobICd":"N752","dJobICdNm":"[N752]여행사 및 기타 여행보조 서비스업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003302:1', '{"dJobCd":"K000003302","dJobCdSeq":"1","dJobNm":"철도여행상품개발원","workSum":"철도와 관련된 여행상품을 개발·홍보하고 여객을 유치한다.","doWork":"철도여객을 유치하기 위해 시장조사를 통해 영업전략을 수립한다. 연계 가능한 여행사와 협력하여 철도 관련 여행상품을 개발한다. 단체여행단을 모집하는 모집원의 영업활동을 지원하기 위해 팸플릿 및 플랫카드 제작 등의 관련 업무를 담당한다. 단체여행객 모집원의 영업 실적을 관리한다. 특정 계약을 통해 철도이용할인 혜택을 제공하는 계약수송을 유치하기 위해 기업체 및 단체에 방문한다. 고객의 방문이나 전화문의에 응대한다. 역 내에서 판매활동을 하거나 광고활동을 할 수 있는 업체를 유치하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"철도여행상품기획원","connectJob":"여행상품영업원","dJobECd":"5211","dJobECdNm":"[5211]여행상품 개발자","dJobJCd":"2732","dJobJCdNm":"[2732]여행 상품 개발자","dJobICd":"H491","dJobICdNm":"[H491]철도 운송업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006917:1', '{"dJobCd":"K000006917","dJobCdSeq":"1","dJobNm":"해외여행MD","workSum":"해외여행상품을 기획 및 개발하고, 고객에게 상품 추천 업무를 수행한다.","doWork":"새로운 해외 여행지 개발을 위해 인터넷이나 여행 동호회, 현지 여행사, 직접 방문 등을 통해 정보를 수집한다. 수집된 정보를 토대로 개발가능성과 시장성 등을 종합적으로 판단하여 개발 여부를 결정한다. 여행개발 예정지의 항공, 숙박, 관광지 등의 관광자원을 파악한다. 여행에 들어갈 총비용을 산출하고, 일정표를 만든다. 현지의 협력업체를 섭외하고 계약을 맺는다. 항공권 예약, 여권발급, 환전 등 여행에 필요한 기타 업무를 대행하기도 한다. 고객의 요구사항에 맞춰 여행상품을 추천하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"해외여행상품개발자, 해외여행상품수배기획자","dJobECd":"5211","dJobECdNm":"[5211]여행상품 개발자","dJobJCd":"2732","dJobJCdNm":"[2732]여행 상품 개발자","dJobICd":"N752","dJobICdNm":"[N752]여행사 및 기타 여행보조 서비스업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003179:1', '{"dJobCd":"K000003179","dJobCdSeq":"1","dJobNm":"간접광고마케터","workSum":"PPL(Product PLacement:텔레비전 드라마나 예능프로그램 속에 제품을 등장시키는 광고기법)을 기획하고 진행한다.","doWork":"광고주와 상담하여 홍보할 제품, 이미지, 장소, 브랜드 등을 확인하고 원하는 프로그램이나 노출방법을 파악한다. 광고주의 마케팅 요구와 드라마나 예능프로그램 시놉시스를 검토하여 적절한 간접광고 방법을 고안하고 광고기획서를 작성한다. 광고주와 제작사 또는 매체 사이에서 노출방법, 횟수 또는 기간, 단가 등을 협의하고 광고계약을 체결한다. 작가, PD, 소품팀, 연출팀, PPL 담당자 등 제작 관련 인원과 협의하여 광고아이템이 자연스럽게 노출되고 광고효과가 높은 장면, 장소, 소품, 스토리, 방영차수, 노출방식 등 세부사항을 결정하고 진행한다. 광고아이템이 노출된 방송자료나 화면을 촬영하여 광고주에게 보고한다. 제작사나 매체에 소속되어 광고주에게 협찬이나 간접광고를 제안하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"PPL마케터, 광고PD","dJobECd":"0241","dJobECdNm":"[0241]광고·홍보 전문가","dJobJCd":"2733","dJobJCdNm":"[2733]광고 및 홍보 전문가","dJobICd":"M713","dJobICdNm":"[M713]광고업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005628:1', '{"dJobCd":"K000005628","dJobCdSeq":"1","dJobNm":"검색광고판매매니저","workSum":"인터넷 포털 내의 검색광고를 판매하기 위해 대행사를 선정하고 총괄적으로 관리한다.","doWork":"검색광고 판매대행사에 대한 데이터베이스를 작성한다. 선정된 검색광고 판매대행사의 조직 및 영업망 구축을 지원한다. 판매할 광고아이템에 대한 정보를 수집한다. 판매할 광고상품의 종류와 단가를 선정한다. 관리하고 있는 판매대행사의 매출증감에 대해 요인을 분석한다. 통신판매원을 교육한다. 새로운 검색광고 형태를 개발한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"검색광고세일즈매니저","dJobECd":"0241","dJobECdNm":"[0241]광고·홍보 전문가","dJobJCd":"2733","dJobJCdNm":"[2733]광고 및 홍보 전문가","dJobICd":"J631","dJobICdNm":"[J631]자료처리, 호스팅, 포털 및 기타 인터넷 정보매개 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003295:1', '{"dJobCd":"K000003295","dJobCdSeq":"1","dJobNm":"게임마케터","workSum":"게임시장의 동향과 게임이용자들의 성향 등을 파악하여 게임의 홍보전략을 수립하고 소비자에게 게임을 홍보한다.","doWork":"관련 업계 및 경쟁사의 자료를 수집하여 마케팅 동향을 파악한다. 자사의 게임과 차별성에 대해 분석한다. 광고, 방송, 이벤트 등을 통한 홍보계획을 수립한다. 게임이용자들을 위한 이벤트나 행사를 계획하고 준비한다. 게임유통판매업체(게임퍼블리셔)와 판매전략을 수립한다. 해외시장 관련 마케팅을 한다. 마케팅 지표를 관리하고 분석한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","connectJob":"게임해외마케터","dJobECd":"0241","dJobECdNm":"[0241]광고·홍보 전문가","dJobJCd":"2733","dJobJCdNm":"[2733]광고 및 홍보 전문가","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003340:1', '{"dJobCd":"K000003340","dJobCdSeq":"1","dJobNm":"광고기획자","workSum":"광고대행사에서 고객(광고주)을 위한 광고물의 제작을 기획하고, 광고물의 제작 일정 및 방향을 조정하며 광고주를 관리한다.","doWork":"고객(광고주)에게 자신이 소속된 광고대행사를 홍보하고 광고대행계약을 체결한다. 광고대행사와 광고주 간의 연락을 담당한다. 광고제작의 진행을 위해 광고주와 지속적으로 의견을 교환한다. 광고회사의 제작상황을 광고주에게 전달하고, 광고주의 의견을 광고회사에 설명한다. 광고주의 광고나 머천다이징 문제를 분석하고 그에 대한 해결방안을 제시하거나 대행사의 광고기획이나 제작물을 광고주에 제시하여 승인을 받는 일, 광고주의 의견을 대행사에 전달하는 일 등을 담당한다. 사안에 따라 효과적인 광고기획안을 광고주에게 제출하거나 부가적인 설명을 하며, 필요에 따라 광고설명회를 공개나 비공개로 개최한다. 경영과 광고에 관한 지식과 광고대행사의 기능들을 종합적으로 활용한다. 광고할 상품이나 용역에 관한 자료를 조사하여 분석하고, 광고마케터와 광고제작팀의 협조를 얻어 광고표현전략과 마케팅전략 수립을 위한 회의를 개최한다. 마케터, 매체기획자 등과 같은 광고제작팀과 협의하여 광고기획서를 수정·보완하고 광고주의 의사결정자와 협의하여 광고의 제작방향을 총괄적으로 결정한다. 광고기획서에 따라 제작과정의 예산시행을 검토하고 제작 전반에 대한 사항을 관장한다. 광고제작에 소요되는 예산을 수립·조정한다. 제작된 광고를 검토·평가하고 광고의 실시계획에 따라 광고를 시행한다. 상황에 따라 광고표현물을 다시 제작하기도한다. 시행된 광고의 효과에 대해 종합적으로 조사·분석·정리하여 광고주에게 보고하고, 자체 보관용 자료로 정리하기도 한다. 광고물이 완성되면 화면의 구성, 상품의 광고효과 등을 확인하고 시사회를 거쳐 광고주의 최종 승인을 얻기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"광고제작자","connectJob":"광고대행사와 광고주 사이의 연락 및 기획업무를 담당하는 경우 AE(Account Executive), 광고전략을 수립하여 광고주의 브랜드를 관리하는 경우 AP(Account Planner), 광고의 콘셉트를 추출하고 스토리보드를 구성하는 경우 CM플래너(Commercial Message Planner)","dJobECd":"0241","dJobECdNm":"[0241]광고·홍보 전문가","dJobJCd":"2733","dJobJCdNm":"[2733]광고 및 홍보 전문가","dJobICd":"M713","dJobICdNm":"[M713]광고업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006387:1', '{"dJobCd":"K000006387","dJobCdSeq":"1","dJobNm":"광고마케터","workSum":"광고대행사에서 고객을 위해 시장상황을 분석하고 시장전략을 수립하며, 마케팅 분야의 정책·전략결정에 합리적이고 타당한 근거자료를 제공하기 위하여 마케팅환경과 시장환경의 적응에 필요한 사항을 수집·분석·평가한다.","doWork":"광고물 제작, 제품이나 회사 이미지의 효율적 관리, 효율적인 상품의 판매 등을 위한 시장전략을 수립한다. 광고할 상품이나 용역에 관한 자료를 조사하여 분석하고, 광고주와 협의하여 마케팅기획서를 작성한다. 광고주담당자, 매체기획원과 협의하여 광고기획서를 수정·보완하고 광고주측의 의사결정자와 협의하여 광고노출, 광고전략, 기업이미지관리, 마케팅전략, 시장전략 등을 수립한다. 제작된 광고를 정성적·정량적으로 검토·평가하고 실시된 광고의 효과를 조사·분석하여 정리한다. 의뢰인 기업의 마케팅현황을 파악하고, 현재의 마케팅환경과 문제점을 파악한다. 시장환경분석을 통한 유통판매전략, 판매촉진전략, 가격전략, 제품전략 등을 수립한다. 시장조사에 필요한 자료를 수집한다. 기업현황과 수집자료를 토대로 시장조사계획을 수립한다. 시장조사에 필요한 설문조사를 실시하거나, 시장환경을 연구하기도 한다. 시장조사에 필요한 설문지를 작성하기도 하며, 설문조사 전반(조사, 조사계획, 질문지작성, 조사결과분석, 결론도출)을 관장하기도 한다. 분석계획에 의해 프로그램을 작성하여 전산처리를 의뢰하기도 하며, 조사된 내용과 자료를 분석하여 보고서를 작성하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","connectJob":"광고시장분석가, 광고회사에서 광고물을 광고주나 예상고객에게 제시하고 설명하는 경우 광고프레젠터","dJobECd":"0241","dJobECdNm":"[0241]광고·홍보 전문가","dJobJCd":"2733","dJobJCdNm":"[2733]광고 및 홍보 전문가","dJobICd":"M713","dJobICdNm":"[M713]광고업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002532:1', '{"dJobCd":"K000002532","dJobCdSeq":"1","dJobNm":"광고매체기획원","workSum":"광고를 수용자에게 효율적으로 전달하기 위하여 어떠한 매체를 이용하는 것이 가장 효과적인가를 파악하여 각종 매체전략(Media Plan)을 수립하고 국내외의 매체정보를 수집·분석한다.","doWork":"방송광고(TV, 라디오, CATV)의 경우 광고목표를 달성하기 위해 주요대상에 대한 광고도달빈도(Frequency), 도달범위(Reach)를 산출하고 예측하며, 이를 위해 시청률 및 청취율을 점검한다. 주요 고객층의 생활환경과 생활시간대에 대하여 조사·연구한다. 경쟁사의 방송광고 비용지출 규모와 방송광고 시간대 등을 파악한다. 방송매체의 특징과 광고주의 의도, 소비자의 미디어노출상황 등을 고려하여 보고서를 작성한다. 지면광고(신문, 잡지, 포스트 등)나 옥외광고(옥외광고판, 전광판 등)의 경우 매체의 특성을 파악하고, 수용자(광고를 보는 사람)의 특성을 분석하며, 신문발행부수 및 구독률을 조사한다. 인터넷광고의 경우 노출빈도, 클릭수, 수용자의 방문특성 등을 분석한다. 제품의 특징과 소비자의 행동에 관한 실증적인 연구결과를 바탕으로 계절적 요인, 상품주기, 구매회전율 및 빈도 등을 고려하여 매체계획을 세운다. 인구통계적인 요소, 사회심리적인 요소 및 제품의 사용요소 등에 따라 매체의 목표대상층(Target)을 선정한다. 상품의 성격, 시장의 성격, 매체의 성격, 표현(메시지)의 적합성, 가용성, 광고비용의 규모 및 효율성, 경쟁사의 매체활동 및 지역성 등을 고려한 광고매체 선택을 광고주담당자, 광고매체구매원, 방송광고매체구매원과 협의한다. 광고동향통계, 매체효율평가모델, 매체전략모델, 매체정보분석모델 등을 활용하여 시청률, 청취율, 구독률, 노출도 등 수용자의 미디어 이용행태를 분석하여 종합보고서를 작성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"미디어플래너(Media Planner), 매체담당자","dJobECd":"0241","dJobECdNm":"[0241]광고·홍보 전문가","dJobJCd":"2733","dJobJCdNm":"[2733]광고 및 홍보 전문가","dJobICd":"M713","dJobICdNm":"[M713]광고업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006747:1', '{"dJobCd":"K000006747","dJobCdSeq":"1","dJobNm":"광고영상연출기획원","workSum":"광고물 제작을 직접 수행하는 상업용영상물제작감독과 의견교환을 하면서 광고기획사 혹은 광고기획자들의 아이디어를 표현하는 데 필요한 제반 작업을 지휘·감독·조정하고, 최종적으로 광고제작물의 완성에 대한 책임을 진다.","doWork":"광고물의 제작 전반에 관련된 사항 및 지식과 업무진행의 흐름을 파악한 후 광고표현 전략을 달성하기 위하여 실제로 광고물을 제작하는 광고물제작회사나 광고제작연출감독 등과 업무진행을 협의하고 문제점을 조정한다. 선정된 광고제작연출감독이나 담당회사(프로덕션)와 광고물의 사전제작에 대한 업무 전반을 협의·관장한다. 사전제작이 끝난 후, 제작물의 완성도를 높이고, 원하는 용도로 사용할 수 있도록 제작물을 보강하는 업무를 수행하는 사후제작사(Post-production)의 각종 작업(효과음 삽입, 컴퓨터그래픽처리, 색보정 등)을 지휘·감독·조정한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0241","dJobECdNm":"[0241]광고·홍보 전문가","dJobJCd":"2733","dJobJCdNm":"[2733]광고 및 홍보 전문가","dJobICd":"M713","dJobICdNm":"[M713]광고업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005438:1', '{"dJobCd":"K000005438","dJobCdSeq":"1","dJobNm":"국제의료마케터","workSum":"외국의 환자를 국내에 유치하기 위한 마케팅 활동을 한다.","doWork":"외국인 환자를 유치하기 위해 국가별 선호하는 한국 의료기술을 파악하고 국내 병원이 보유한 의료기술을 상품으로 기획하고 마케팅전략을 수립한다. 외국 환자들이 우리나라에서 의료서비스를 받을 수 있도록 광고 및 홍보를 담당한다. 의료비, 의료사고로 인한 분쟁이 발생 시 협의하여 대처 및 사후관리한다. 유치업자의 윤리·직업적 의무 등의 문제를 해결한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"병원국제마케터","certLic":"국제의료관광코디네이터","dJobECd":"0241","dJobECdNm":"[0241]광고·홍보 전문가","dJobJCd":"2733","dJobJCdNm":"[2733]광고 및 홍보 전문가","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007021:1', '{"dJobCd":"K000007021","dJobCdSeq":"1","dJobNm":"그로스매니저","workSum":"기업의 성장 계획을 입안, 실행 및 운영하고 개발, 마케팅 등 타 부서 관계자와 협의 조정하여 수익채널을 극대화한다.","doWork":"데이터를 기반으로 서비스의 사용자 획득, 콘텐츠 소비촉진, 콘텐츠 확산 등의 핵심 지표들을 향상시킬 수 있는 성장 전략을 수립한다. 데이터를 기반으로 끊임없는 가설수립, 실험, 가설검증, 인사이트 도출을 통해 서비스의 핵심지표를 향상시킨다. 앱·웹 데이터 분석 툴을 활용하여 퍼널간 유저 행동 분석을 통한 인사이트 도출 및 개선 방향을 제안한다. 데이터를 기반으로 A/B 테스트를 설계, 진행 및 결과를 분석한다. 서비스 문제 해결을 위한 가설을 검증 및 개선한다. 그로스 유닛(Growth Unit) 팀원과 그로스 관련 전반에 대한 업무 협업을 진행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0241","dJobECdNm":"[0241]광고·홍보 전문가","dJobJCd":"2733","dJobJCdNm":"[2733]광고 및 홍보 전문가","dJobICd":"N759","dJobICdNm":"[N759]기타 사업지원 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007365:1', '{"dJobCd":"K000007365","dJobCdSeq":"1","dJobNm":"그로스해커","workSum":"데이터를 기반으로 마케팅과 운영 전반에 대한 성과를 분석하고 새로운 목표를 설정한다.","doWork":"서비스의 핵심 지표 개선을 위해 애로사항 및 가설 수립을 위해 사용할 데이터가 있는지 검토한다. 개선을 위한 가설 수립을 위해 데이터가 있는 경우 데이터에 근거하여 가설을 설정한다. 가설 검증을 위해 세그먼트를 활용하여 데이터를 세분화하고 분석·트래킹 툴을 통해 데이터를 분석하고 마케팅 지표를 관리한다. 필요한 경우 외부적 요소들을 확인하여 A/B 테스트를 진행한다. 분석결과가 가설과 일치하는지 결론을 도출하고 서비스에 반영한다. 결론에서 확인된 인사이트는 문서화하고 지속적으로 모니터링한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","connectJob":"그로스매니저, 퍼포먼스마케터","dJobECd":"0241","dJobECdNm":"[0241]광고·홍보 전문가","dJobJCd":"2733","dJobJCdNm":"[2733]광고 및 홍보 전문가","dJobICd":"M713","dJobICdNm":"[M713]광고업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003152:1', '{"dJobCd":"K000003152","dJobCdSeq":"1","dJobNm":"도시마케터","workSum":"도시상품 가치를 높이기 위하여 지역의 공공과 민간과의 협력을 통해 기업, 주민, 관광객이 선호하는 이미지, 제도, 시설을 구안하고 홍보 및 마케팅전략을 수립하여 실행한다.","doWork":"도시브랜드의 가치를 높이고 특화상품으로 개발할 수 있는 아이템을 도출하고 홍보 및 마케팅전략을 수립한다. 온·오프라인 채널을 활용하여 도시 관광자원에 대한 마케팅전략을 수립하고 실행한다. 도시의 가치를 높이기 위한 행사의 잠재적 수요와 가치를 평가하고 행사유치를 위한 계획 및 홍보전략을 수립한다. 도시개발을 위한 공공 및 민간자본을 유치하기 위해 관광자원을 도출하고 개발을 위한 전략을 수립하며 관계자에게 제안한다. 특정도시를 명소화하고 지역경제를 활성화하기 위한 컨설팅을 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0241","dJobECdNm":"[0241]광고·홍보 전문가","dJobJCd":"2733","dJobJCdNm":"[2733]광고 및 홍보 전문가","dJobICd":"M713/O841","dJobICdNm":"[M713]광고업 / [O841]입법 및 일반 정부 행정","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004663:1', '{"dJobCd":"K000004663","dJobCdSeq":"1","dJobNm":"디지털광고게시판기획자","workSum":"디지털 정보 디스플레이(DID:Digital Information Display)를 이용한 광고 게시판(Digital Signage)을 기획·개발한다.","doWork":"고객과 상담하여 광고·홍보목적, 요구사항 등을 파악한다. 설치환경, 표출될 콘텐츠의 내용, 요구되는 기능에 따라 방수, 내한, 내열, 내구성, 시안성, 조작성, 화면크기, 디스플레이 방법과 종류, 프레임, 통신장치 및 다양한 부가기능(음성인식, 블루투스, 모션인식, 터치기술, 스피커 등)을 기획한다. 콘텐츠(사용자 환경, 화면, 애니메이션, 플래시, 영상, 동작, 부가기능의 구현 등)를 기획한다. 기획안을 작성하여 고객과 상담하여 수정·확정한다. 기획에 따라 하드웨어와 콘텐츠의 제작을 의뢰한다. 하드웨어와 콘텐츠가 제작되면 시제품을 제작하고 운영프로그램(네트워크에 연결하여 광고내용을 원격으로 제어할 수 있는 프로그램 등)을 설치한다. 시제품을 테스트하고 수정·보완한다. 현장에서 설치를 지휘·감독하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"협의","workFunc3":"정밀작업","similarNm":"디지털사이니지기획자, 스마트사이니지기획자","dJobECd":"0241","dJobECdNm":"[0241]광고·홍보 전문가","dJobJCd":"2733","dJobJCdNm":"[2733]광고 및 홍보 전문가","dJobICd":"M713","dJobICdNm":"[M713]광고업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007397:1', '{"dJobCd":"K000007397","dJobCdSeq":"1","dJobNm":"브랜드마케터","workSum":"고객 및 시장분석을 통해 전략수립 및 홍보마케팅 등을 통해 기업, 제품 등의 브랜드를 제고한다.","doWork":"브랜드의 프로모션 전략, 진출 국가 전략 및 고객 전략 등 대응 전략을 수립한다. 브랜드의 매출액과 영업이익 관점에서 실직 관리 업무를 진행한다. 브랜드의 단기, 중기, 장기 방향성에 따라 마케팅 전략을 수립한다. 트렌드에 따라 다양한 미디어 매체를 통해 브랜드 광고 홍보 전략을 실행한다. 상품 육성 및 상품 라인 구성 운영 등 시장 상황에 따라 상품을 다각도로 분석하고 개선한다. 소비자의 구매 패턴을 분석하여 브랜드 커뮤니케이션 방향성을 설계한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0241","dJobECdNm":"[0241]광고·홍보 전문가","dJobJCd":"2733","dJobJCdNm":"[2733]광고 및 홍보 전문가","dJobICd":"M713","dJobICdNm":"[M713]광고업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002314:1', '{"dJobCd":"K000002314","dJobCdSeq":"1","dJobNm":"소셜네트워크서비스마케터","workSum":"인터넷, SNS(블로그, 트위터, 미투데이, 페이스북 등), 휴대폰 등 디지털 매체를 활용하여 마케팅업무를 수행한다.","doWork":"새로운 상품이나 브랜드의 특성 등을 분석하여 마케팅전략을 수립한다. 스마트폰, 태블릿PC, 블로그 등 다양한 디지털 기술을 응용한 매체를 통해 마케팅을 한다. 효율적으로 고객들과 소통할 수 있도록 기획하며 각종 프로모션, 캠페인을 진행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"SNS마케터","dJobECd":"0241","dJobECdNm":"[0241]광고·홍보 전문가","dJobJCd":"2733","dJobJCdNm":"[2733]광고 및 홍보 전문가","dJobICd":"M713","dJobICdNm":"[M713]광고업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007079:1', '{"dJobCd":"K000007079","dJobCdSeq":"1","dJobNm":"소셜미디어전문가","workSum":"기업의 소셜미디어 계정을 기획·운영하며 소셜콘텐츠 기획 및 관리, 소셜마케팅, 소셜데이터 분석, 소셜위기관리 등 소셜미디어 관련 업무를 수행한다.","doWork":"소셜미디어(Facebook, Twitter, Youtube, Blog, LinkedIn 등) 계정을 생성한다. 자사 및 경쟁사의 상품, 서비스 등에 대한 시장조사, 수요조사 등을 실시하고 소셜미디어를 활용한 마케팅전략(대상 및 방법)을 기획한다. 고객과의 커뮤니케이션, 이벤트 및 프로모션, 포스팅, 소셜커뮤니티 관리, 다양한 소셜미디어콘텐츠(체험후기, 동영상, 게시물, 이미지, 정보, 뉴스 등)를 기획 및 제작하고 소셜미디어를 활용하여 소통·전파한다. 소셜데이터 분석을 위한 기초자료를 수집하고 관리하며, 사안별로 적절한 소셜데이터 분석방법을 결정한다. 이슈 키워드를 추출하고 산업분야별 인사이트를 통해 데이터로부터 의미를 파악하며, 데이터분석툴(R-Studio, Hadoop, Sass 등), 분석서비스(Hootwuite, Radian6, Klout 등)을 활용하여 분석하고 보고서를 작성한다. SNS모니터링 업무를 수행하는 경우 산업분야별로 핵심 키워드를 도출하고, 시장현황 파악, 고객과의 소셜네트워킹 업무를 수행한다. 소셜미디어 위기관리(소셜미디어상에서의 부정적인 소문의 전파, 온라인 악용, 사이버폭력 등에 대한 관리 및 조치) 업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"소셜미디어관리사, 소셜미디어매니저, 소셜미디어컨설턴트","connectJob":"블로그운영자, 카페운영자, 페이스북운영자","dJobECd":"0241","dJobECdNm":"[0241]광고·홍보 전문가","dJobJCd":"2733","dJobJCdNm":"[2733]광고 및 홍보 전문가","dJobICd":"J631","dJobICdNm":"[J631]자료처리, 호스팅, 포털 및 기타 인터넷 정보매개 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001996:1', '{"dJobCd":"K000001996","dJobCdSeq":"1","dJobNm":"스포츠마케터","workSum":"스포츠팀 및 기업이 스포츠마케팅을 통해 인지도 향상 및 이미지 개선을 할 수 있도록 스포츠와 관련된 각종 행사지원, 선수지원, 스포츠용품 판매 등을 대행한다.","doWork":"소비자의 의식과 행태를 분석한다. 각 매체(TV, 라디오, 신문, 잡지, 옥외광고, 전광판, 포스트 등)를 통해 스포츠와 관련된 홍보 및 마케팅을 한다. 각종 스포츠의 개최, 후원, 진행 등의 방법으로 선수명, 스포츠팀명, 기업명 혹은 단체명, 상품명 등이 유료광고 이외의 방법으로 수용자에게 노출될 수 있도록 하여 대중적 인지도를 상승시키거나 유지시켜 이를 통해 수익(TV중계권, 스폰서십(Sponsorship)유치, 관련 상품 판매 등)을 올릴 수 있도록 기획한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","certLic":"스포츠경영관리사","dJobECd":"0241","dJobECdNm":"[0241]광고·홍보 전문가","dJobJCd":"2733","dJobJCdNm":"[2733]광고 및 홍보 전문가","dJobICd":"M715","dJobICdNm":"[M715]회사 본부 및 경영 컨설팅 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;