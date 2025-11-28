INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003109:1', '{"dJobCd":"K000003109","dJobCdSeq":"1","dJobNm":"여신심사사무원","workSum":"사업성 검토, 재무적 타당성 분석, 기술검토 등의 사업분석을 실시하여 여신취급의 적정성 여부를 결정하며, 기업의 재무적·비재무적 요소에 대한 평가를 실시하여 여신심사 및 사후관리에 필요한 정보를 제공하고 관련 업무를 수행한다.","doWork":"회사의 대출기본방침 및 대출계획을 파악하여 여신심사 전 사전협의를 한다. 대출의뢰인(또는 기업)의 신용등급, 연간소득, 사업성, 재무상황, 기술적 타당성, 담보가치 및 조건, 여신취급 타당성 등을 분석하고 심사요청서를 검토한다. 대출자금용도와 이자납부계획 및 원리금상환계획서를 검토하여 실행가능성 여부를 심사한다. 여신취급의 타당성이 있는 경우 승인신청서를 접수하여 여신심사위원회에 상정한다. 경우에 따라 신청여신자금의 한도를 가감하거나 증대하기도 한다. 승인을 받으면 기업체신용평가를 한 후 승인장 및 관계서류를 해당 영업점에 발송한다. 여신이 지급된 후 해당 업체의 지속적인 사후관리를 한다. 여신심사 시 발생하는 문제점을 영업점에 지도한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0321","dJobECdNm":"[0321]은행 사무원","dJobJCd":"3203","dJobJCdNm":"[3203]은행 사무원","dJobICd":"K641","dJobICdNm":"[K641]은행 및 저축기관","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002982:1', '{"dJobCd":"K000002982","dJobCdSeq":"1","dJobNm":"여신제도기획원","workSum":"여신(금융기관에서 고객에게 돈을 빌려 주는 일)제도 개선, 여신상품 개발, 여신 업무절차의 개발·보완 등 여신 관련 업무를 총괄적으로 조정·통제하는 업무를 수행한다.","doWork":"여신 관련 금융제도, 자사 및 타사의 여신상품, 국내신용평가, 자사의 영업전략 등을 수집·분석하고 시장조사 및 여신기법 연구를 수행한다. 주택담보대출, 부동산담보대출, 인터넷대출 등 여신상품을 기획한다. 여신내규를 제·개정한다. 여신 관련 업무처리절차를 개발하고 전산부서와 협의하여 전산업무시스템을 개발·구축한다. 영업점에 개발된 전산업무시스템의 사용방법을 지도한다. 기존 여신제도의 문제점을 파악하여 제도개선을 추진하고 여신업무처리절차를 보완한다. 여신담당인력의 선발과 운용, 여신점포 설치 및 운영전략 수립, 고객개발전략 기획 업무를 수행한다. 기업여신업무를 수행하는 경우, 대출 및 투자 관련 자료수집, 현황분석 및 제도개선방안 수립을 통하여 대출·투자업무를 기획한다. 규모별·신용도별 보증실적관리와 현황분석을 통해 대출관리 및 지급보증업무를 수행한다. 고객에게 제공할 여신상품안내정보를 개발한다. 타 금융기관과 여신 관련 상품제휴 및 파생상품을 기획하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","connectJob":"여신금리기획원","dJobECd":"0321","dJobECdNm":"[0321]은행 사무원","dJobJCd":"3203","dJobJCdNm":"[3203]은행 사무원","dJobICd":"K641","dJobICdNm":"[K641]은행 및 저축기관","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002427:1', '{"dJobCd":"K000002427","dJobCdSeq":"1","dJobNm":"외자조달사무원","workSum":"외화자금 조달계획 및 전략을 수립하고 외국기관 투자가를 대상으로 한 마케팅 전개, 가격조건 협상, 환율 및 금리리스크 관리를 통해 외자를 조달하기 위한 제반 업무를 수행한다.","doWork":"국제금융시장의 자금을 조달·유치하기 위하여 외자조달 전략계획을 수립한다. 국내외 금융시장 동향분석, 각국 금융제도조사 등을 통해 채권발행전략을 수립하기도 한다. 외국기관 투자가를 대상으로 투자마케팅을 전개한다. 채권투자금액조건을 협상한다. 환율 및 금리리스크 등 환위험리스크를 관리한다. 최적의 외자조달의 수단을 연구·분석하여 결정한다. 마케팅전략을 수립하고 현장로드쇼(Road Show)를 개최하는 등 채권판촉활동을 한다. 가격조건을 협상하고 결정한다. 원리금 상환, 채권발행비 등 각종 수수료의 지급과 상환스케줄 및 색인(Index)관리 등 사후관리업무를 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0321","dJobECdNm":"[0321]은행 사무원","dJobJCd":"3203","dJobJCdNm":"[3203]은행 사무원","dJobICd":"K641","dJobICdNm":"[K641]은행 및 저축기관","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004765:1', '{"dJobCd":"K000004765","dJobCdSeq":"1","dJobNm":"외화대출사무원","workSum":"중소기업자로부터 외화대출 신청접수를 받아 신청인의 융자대상 여부, 융자금액 및 차주신용상태 등을 감안하여 대출을 결정하고 사후관리하는 업무를 수행한다.","doWork":"기업으로부터 외화대출신청서를 접수하고 대출상담을 한다. 제출한 신청서와 기업의 재무상태, 사업 및 생산성, 이자 및 원금상환계획서를 검토하고 융자대상 여부, 자금용도, 융자조건, 차주(채무자)의 신용상태 등을 파악하고 대출한도확인을 조회한다. 경우에 따라 사업장의 현장실사를 하기도 한다. 대출승인요청서를 작성하여 대출심사부에 승인요청을 한다. 여신승인이 결정되면 승인결과를 통지한다. 채권보존을 위하여 담보를 취득한 후 융자약정을 체결한다. 수탁외화대출을 받은 차주가 적색거래처(금융불량 거래처)로 규제된 경우 또는 대출금이 용도 외로 사용되는 경우에는 즉시 본부에 보고하고 대출금을 회수하는 등 사후관리를 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0321","dJobECdNm":"[0321]은행 사무원","dJobJCd":"3203","dJobJCdNm":"[3203]은행 사무원","dJobICd":"K641","dJobICdNm":"[K641]은행 및 저축기관","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006687:1', '{"dJobCd":"K000006687","dJobCdSeq":"1","dJobNm":"외환매매사무원","workSum":"외국통화를 매입 또는 매도하고, 해외에 있는 은행이 당행을 지급은행으로 지정하여 국내에 있는 수취인에게 보내오는 송금을 지급하며, 외화수표 매입(추심), 여행자수표 판매, 외국통화의 보유한도 내에서 외국통화를 보유, 현금수송, 보관하는 업무를 수행한다.","doWork":"주요 통화변동률을 주시하고 당일 환율매매기준율을 숙지한다. 고객으로부터 외국통화의 매입신청과 매도신청을 받는다. 계좌개설 여부를 확인하고 거래계좌 미보유 시 신규거래계좌를 개설한다. 매도 및 매입요청 금액에 따라 당일 환율매매기준율을 적용하여 매입 및 매도업무를 수행한다. 외국통화의 보유한도 내에서 외국통화의 보유, 현금수송, 보관업무를 담당한다. 해외에 있는 은행이 당행을 지급은행으로 지정하여 국내에 있는 수취인에게 보내오는 송금지급인 타발송금 업무와 국내에 있는 송금의뢰인의 신청에 따라 원화, 외화를 대가로 외국의 지급은행을 통하여 외국수취인에게 송금하는 당발송금업무를 담당한다. 외국통화의 관리와 외화수표의 매입, 여행자수표를 판매한다. 일일, 월별, 기간별 매도·매입 건수, 처리금액 등을 통계하여 전산프로그램상에 기록·보관한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"환전송금사무원","dJobECd":"0321","dJobECdNm":"[0321]은행 사무원","dJobJCd":"3203","dJobJCdNm":"[3203]은행 사무원","dJobICd":"K641","dJobICdNm":"[K641]은행 및 저축기관","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006544:1', '{"dJobCd":"K000006544","dJobCdSeq":"1","dJobNm":"외환사무관리자","workSum":"외환상품을 개발하고 외국환업무, 수출입업무, 외화대출 등 외환 전반을 총괄하는 업무를 수행한다.","doWork":"달러를 비롯해서 엔화, 마르크화 등 국제 금융시장에서 통용되는 외환과 파생상품시장의 동향을 파악한다. 현물환, 선물환, 외환스왑 등의 외환상품정보와 자료를 수집하고 연구한다. 국제수지와 외환거래통계를 분석한다. 기업 간 또는 국제 간의 외환거래 또는 금융거래에 있어 환위험을 분석하고 그 위험에 대해 관리를 한다. 환위험(Foreign Exchange Risk)에 노출되지 않도록 외환포지션(Foreign Exchange Position)을 수시로 확인한다. 외환상품에 대한 업무계획을 수립·시행한다. 외환 신상품을 개발한다. 외국환전문점의 신설, 폐지를 관리하고 대내외 외국환보고서를 작성한다. 국제금융정세에 따라 외국환 수수료율을 결정한다. 외환인력을 양성한다. 수출입업무와 무역금융 및 내국신용장, 외화대출업무를 지원한다. 외화수표 추심업무와 해외송금 및 국내 외화 타행이체업무를 지도한다. 외신업무를 총괄하고 계산 및 감사업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","connectJob":"외환담당자, 국제금융담당자, 외환자산운용관리자","dJobECd":"0321","dJobECdNm":"[0321]은행 사무원","dJobJCd":"3203","dJobJCdNm":"[3203]은행 사무원","dJobICd":"K641","dJobICdNm":"[K641]은행 및 저축기관","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005949:1', '{"dJobCd":"K000005949","dJobCdSeq":"1","dJobNm":"은행개인금융상담역","workSum":"은행에서 개인고객이 필요로 하는 자금수요에 맞추어 적기에 대출할 수 있도록 관련 채권보전절차를 거쳐 대출을 실시하며, 대출조건에 따라 원리금을 회수한다.","doWork":"대출을 요청하는 개인고객의 신용도 조사, 자금용도 적정성 조사, 담보제공 가능성 및 적정성 조사업무를 수행한다. 개인고객과 대출조건을 협의한다. 대출요청서류를 접수하고 심사요청서를 작성한다. 융자약정서 등 채권·대출 관련 서류를 작성하고 결재를 받는다. 승인조건을 전산시스템에 입력한다. 대출조건에 따른 원리금 회수업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","similarNm":"개인금융RM(Relationship Manager)","dJobECd":"0321","dJobECdNm":"[0321]은행 사무원","dJobJCd":"3203","dJobJCdNm":"[3203]은행 사무원","dJobICd":"K641","dJobICdNm":"[K641]은행 및 저축기관","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004144:1', '{"dJobCd":"K000004144","dJobCdSeq":"1","dJobNm":"은행기업금융상담보조역","workSum":"은행에서 기업금융고객상담역을 보조·지원하여 기업대출에 관련된 제반 실무, 원리금 회수업무, 채권보전 등 사후관리업무를 담당한다.","doWork":"기업고객의 경영상황을 지속적으로 파악 및 분석하기 위한 자료를 수집한다. 기업고객이 속한 산업의 동향 및 국내외 경제동향분석을 위한 자료를 수집한다. 대출조건 협상, 차입신청서 접수, 신용조사, 사업성 검토를 위한 전반적인 실무를 수행한다. 심사요청서를 관련 전산시스템에 입력한다. 대출(보증 등) 승인 후 승인조건을 전산시스템에 입력한다. 융자약정서 등 대출·채권보전 제반 서류를 검토한다. 대출원리금 상환 등 사후관리 실무업무를 담당한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","similarNm":"기업금융ARM(Assistant Relationship Manager)","connectJob":"중소기업금융을 전담하는 경우 중소기업금융AM, 특수금융을 전담하는 경우 특수금융AM","certLic":"공인회계사, 신용위험분석사(Credit Risk Analyst), 신용분석사, AICPA(American Institude of Certified Public Accountant)","dJobECd":"0321","dJobECdNm":"[0321]은행 사무원","dJobJCd":"3203","dJobJCdNm":"[3203]은행 사무원","dJobICd":"K649","dJobICdNm":"[K649]기타 금융업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004971:1', '{"dJobCd":"K000004971","dJobCdSeq":"1","dJobNm":"은행기업금융상담역","workSum":"은행에서 기업고객의 자금수요를 적기에 제공할 수 있도록 기업대출에 관련된 제반 실무를 진행한다.","doWork":"기업고객의 경영상황을 지속적으로 파악 및 분석한다. 국내외 경제동향 및 기업고객이 영위하는 산업의 동향을 분석한다. 기업고객의 대출조건(보증, 금액, 금리, 기간, 통화, 신용보강 등)을 협의하고 협상한다. 차입신청서 접수, 신용조사, 사업성 검토를 수행한다. 기업금융절차의 진행 여부를 판단하고 심사요청서를 작성한다. 기업금융심사역과 사전에 협의한다. 융자약정서 등 대출·채권보전 제반 서류를 검토하고 결재한다. 기업고객의 사업성 등에 대하여 사후관리한다. 신규기업고객을 섭외하여 거래처를 창출한다. 거래 중인 기업고객과 지속적인 관계를 유지하며 수시로 경제지표를 분석하여 은행과 기업고객과의 관계를 재정립한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","similarNm":"기업금융RM(Relationship Manager), 기업고객전담역, 기업고객상담역","connectJob":"중소기업금융을 전담하는 경우 중소기업금융RM, 특수금융을 전담하는 경우 특수금융RM","certLic":"공인회계사, 신용위험분석사(Credit Risk Analyst), 신용분석사, AICPA(American Institude of Certified Public Accountant)","dJobECd":"0321","dJobECdNm":"[0321]은행 사무원","dJobJCd":"3203","dJobJCdNm":"[3203]은행 사무원","dJobICd":"K649","dJobICdNm":"[K649]기타 금융업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003777:1', '{"dJobCd":"K000003777","dJobCdSeq":"1","dJobNm":"은행부실채권관리보조사무원","workSum":"부실발생(부도, 법정관리, 회생절차 등)한 고객(기업, 개인)의 회사정상화 및 채권회수를 위한 최적의 조건 도출, 정리계획안에 대한 이해 당사자의 이해관계를 조정하여 협의를 도출할 수 있도록 담당자를 보좌한다.","doWork":"법정관리 등 회생절차 관련 법규를 숙지한다. 유치권, 지상권, 양도담보권 등 담보물건에 관한 법규를 숙지한다. 기업회생 가능성 여부 판단을 위한 기업의 계량지표 및 비계량지표 분석을 위한 기초자료를 조사한다. 채권에 대한 조건변경승인신청서를 작성한다. 기업회생 불가판정을 받은 기업고객의 자산처분을 위한 시장가격조사 및 매입자 물색을 위한 명단을 작성한다. 자산처분에 따른 회계처리지식을 숙지한다. 부실발생에 따른 원리금 납부연기 또는 수납처리를 한다. 부실채권 관련 채권서류 정리 및 처분 시 매입자 앞으로 이관한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","certLic":"공인회계사, 신용위험분석사(Credit Risk Analyst), 신용분석사, AICPA(American Institude of Certified Public Accountant)","dJobECd":"0321","dJobECdNm":"[0321]은행 사무원","dJobJCd":"3203","dJobJCdNm":"[3203]은행 사무원","dJobICd":"K649","dJobICdNm":"[K649]기타 금융업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003139:1', '{"dJobCd":"K000003139","dJobCdSeq":"1","dJobNm":"은행상시감시원","workSum":"은행업무 중 사고취약부문 및 오류발생 개연성이 큰 특정거래에 대한 처리의 적부 등에 대하여 상시모니터링 업무를 수행한다.","doWork":"수신, 여신, 외국환 등 자금수반업무 처리절차에 대한 지식과 이해를 숙지한다. 상시모니터링 항목별 업무처리 적부 등을 분석한다. 이상항목 발견 시 보고 및 대처요령에 따라 처리한다. 일일보고서를 작성한다. 영업점에 방문하여 감사하는 임점감사 시에 감사자료를 제공한다. 사고개연성 취약부분에 대하여 상시적으로 모니터링하고 관련 부서와 협의한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","dJobECd":"0321","dJobECdNm":"[0321]은행 사무원","dJobJCd":"3203","dJobJCdNm":"[3203]은행 사무원","dJobICd":"K641","dJobICdNm":"[K641]은행 및 저축기관","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006288:1', '{"dJobCd":"K000006288","dJobCdSeq":"1","dJobNm":"전자금융사무원","workSum":"텔레뱅킹, PC뱅킹, 인터넷뱅킹 등 전자금융서비스 신청에 대한 접수 및 승인, 이용안내 등의 제반 업무를 수행한다.","doWork":"고객이 은행에 나오지 않고 전자매체(PC, 핸드폰, 태블릿PC, 전화기)를 통해 전자금융거래(텔레뱅킹, PC뱅킹, 인터넷뱅킹, 스쿨뱅킹 등)를 하기 위해 작성한 전자거래 가입신청서류를 접수한다. 당행에 개설한 계좌가 있는지를 확인하고 개설계좌가 없을 시 계좌개설을 요청하고 안내한다. 신청내용을 단말기로 전산등록하고 보안카드를 발급한다. 확인증을 교부하고 고객에게 이용을 안내한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"관련없음","dJobECd":"0321","dJobECdNm":"[0321]은행 사무원","dJobJCd":"3203","dJobJCdNm":"[3203]은행 사무원","dJobICd":"K641/K649","dJobICdNm":"[K641]은행 및 저축기관 / [K649]기타 금융업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005072:1', '{"dJobCd":"K000005072","dJobCdSeq":"1","dJobNm":"특수여신관리사무원","workSum":"채무자의 재산을 강제집행하여 채권을 회수하는 경매업무와 소송업무를 담당하며 보유여신의 건전성 분류 및 신용보증 사고발생에 따른 사후관리업무, 법정관리, 화의절차업무를 수행한다.","doWork":"여신고객관리부서로부터 여신특수관리대상 고객의 명단을 제공받는다. 특수관리대상 고객의 내용을 검토하여 회사의 특수관리규정에 따라 채권회수방법을 수립한다. 이자 및 원리금상환 연체고객에 대하여 독촉장을 발송하며 유선으로 또는 방문하여 채권회수 독촉을 한다. 행정적인 채권회수절차에 따라 내용증명을 발송한다. 가압류나 가처분의 강제집행보존절차를 실행한다. 정상적인 거래의 계속이 어렵거나 채권보전이 우려되는 고객에 대해 담보권 실행, 경매대행 의뢰업무, 소송업무를 진행한다. 보유여신의 건전성 분류를 실시하여 영업점별, 고객별 건전성 결과를 고객관리전산프로그램에 입력한다. 신용보증서 담보운용과 관련해 신용보증사고가 발생한 경우 채권보전을 위해 대위변제를 청구하고 수령한다. 특수채권을 발행하며 소멸시효완성 및 시효중단조치의 처리업무를 담당한다. 채무관계인 소유 은닉재산을 발견하기 위해 외부재산조사를 대행시키며 비업무용자산을 취득 후 처분·관리하는 업무를 수행한다. 법정관리와 화의절차에 관계된 업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0321","dJobECdNm":"[0321]은행 사무원","dJobJCd":"3203","dJobJCdNm":"[3203]은행 사무원","dJobICd":"K641/K649","dJobICdNm":"[K641]은행 및 저축기관 / [K649]기타 금융업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003830:1', '{"dJobCd":"K000003830","dJobCdSeq":"1","dJobNm":"프라이빗뱅커","workSum":"개인고액산가의 자산 및 수익증대를 목적으로 고객의 자산(부동산, 예금, 실물자산 등)을 종합적으로 관리하는 일을 한다.","doWork":"고객의 부동산관리, 연금이나 보험 등의 가입, 은퇴 후 재산상속 등을 컨설팅하고 이에 대한 설계를 한다. 고객들에게 예금, 적금, 펀드, 종신보험 등 각종 금융상품을 설명하고 가입권유 및 판매한다. 고객들이 소속 금융기관에서 환전을 하고, 그 금융기관이 발급하는 신용카드를 사용하도록 유도한다. 계약체결에 따른 계약서 작성 등은 관련 부서에 인계한다. 고객의 투자결과나 신금융상품 등의 정보를 수시로 분석·제공하여 고객과의 관계를 유지하도록 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"설득","workFunc3":"관련없음","similarNm":"PB(Private Banker), 프라잇뱅커","connectJob":"증권사에서 활동하는 경우 증권사PB(Private Banker)","certLic":"자산관리사FP","dJobECd":"0321","dJobECdNm":"[0321]은행 사무원","dJobJCd":"3203","dJobJCdNm":"[3203]은행 사무원","dJobICd":"K641","dJobICdNm":"[K641]은행 및 저축기관","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004392:1', '{"dJobCd":"K000004392","dJobCdSeq":"1","dJobNm":"해외여신사무원","workSum":"해외 거주자 및 비거주자의 해외여신에 관한 업무를 수행한다.","doWork":"잠재고객 및 주요고객을 상대로 마케팅전략을 세우고 융자 관련 상담을 한다. 지원대상 사업 및 기업체에 대한 사업성·재무분석 등을 검토하고 심사요청서를 작성한다. 적정성이 인정되면 융자약정을 체결하고 채권보전책을 강구한다. 이후 원리금납입기일 통지 및 수납, 차주사(채무자) 재무·경영활동 등 동향파악, 부실채권 회수방안수립 및 실행 등 사후관리를 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0321","dJobECdNm":"[0321]은행 사무원","dJobJCd":"3203","dJobJCdNm":"[3203]은행 사무원","dJobICd":"K641/K649","dJobICdNm":"[K641]은행 및 저축기관 / [K649]기타 금융업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003234:1', '{"dJobCd":"K000003234","dJobCdSeq":"1","dJobNm":"공시원","workSum":"투자자가 기업의 실체를 정확히 파악하여 합리적인 투자결정을 하도록 유도하고 동시에 증권시장을 통한 자원배분의 효율성을 기하기 위하여 상장(거래소시장)·등록(코스닥시장-협회중개시장)법인의 경영활동이나 사업내용을 공시한다.","doWork":"상장·등록법인의 경영활동이나 사업내용에 관한 중요사실(부도발생, 은행거래정지 또는 재개, 회사정리절차에 관한 사항, 재해발생으로 인한 손해, 유무상증자, 주식배당, 출자, 해외직접투자, 자본 및 기술도입, 신기술에 대한 특허권 취득, 최대주주 및 주요주주 변경, 사채발행, 담보제공, 의결권행사내용, 불성실 공시지정 등)이 발생하면 결정된 공시문안을 작성하고 관련 부서에 문안을 배부하고 증권거래소 전자공시시스템이나 증권시장지에 그 내용을 공시한다. 상장·등록법인에 관한 보도나 풍문 등에 대한 조회공시를 요구하고 당해 상장법인이 사실 여부를 직접 공시하도록 조치한다. 증권투자신탁회사 등의 의결권행사내용을 공시한다. 상장·등록법인이 기업내용 공시를 성실히 이행하지 않을 경우 불성실 공시 여부를 검토하여 지정공표하고 매매거래정지를 결정하고 금융감독위원회에 보고한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"서비스제공","workFunc3":"관련없음","similarNm":"간접공시원, 공시(IR, Ivestment Relations)담당원, 공시사무원","dJobECd":"0322","dJobECdNm":"[0322]증권 사무원","dJobJCd":"3204","dJobJCdNm":"[3204]증권 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004028:1', '{"dJobCd":"K000004028","dJobCdSeq":"1","dJobNm":"대용증권가격책정사무원","workSum":"신용거래보증금 및 위탁증거금의 납부에 있어 현금에 갈음할 수 있는 대용증권의 가격을 책정한다.","doWork":"정기적으로 시장부서로부터 시세를 통보받아 대용가격 개정준비작업을 한다. 시장지에 시세를 고지한다. 전산부서로부터 대용가격의 전산자료를 접수한다. 대용증권의 가격을 책정하여 품의하고 대용가격표를 작성하여 배부한다. 증권가격이 대용가격에 미달할 때는 수시로 개정 작업을 실시하여 대용가격을 조정하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0322","dJobECdNm":"[0322]증권 사무원","dJobJCd":"3204","dJobJCdNm":"[3204]증권 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004936:1', '{"dJobCd":"K000004936","dJobCdSeq":"1","dJobNm":"대용증권관리사무원","workSum":"선물시장에서 선물거래를 위한 증거금으로 대용증권(주식, 채권 등)을 사용할 경우 장부상 관리, 계좌이체, 담보관리(질권설정) 권리행사 등의 업무를 수행하여 선물시장 참가기관(선물거래소 및 선물회원)과 고객 등에게 편의를 제공한다.","doWork":"대용증권(선물거래증거금)의 계좌를 설정하고 관리한다. 고객 및 예탁자의 선물거래에 의해 산정된 증거금의 유지수준에 따른 대용증권 필요액을 관리한다. 고객, 예탁자, 거래소 등의 필요에 의해 대용증권을 인출하고 잔고 등을 관리한다. 주식배당금, 채권원리금 등 대용증권에서 파생된 권리를 행사(수령, 배분 및 원천징수, 납부 등)한다. 금선물거래의 만기 시 실물인수도 결제를 위한 금임차인의 계좌를 관리하며, 금임치, 금반환, 창고증권발행, 인수도(인수와 인도)결제 등의 업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"선물거래증거금관리사무원, 증권관리사무원","dJobECd":"0322","dJobECdNm":"[0322]증권 사무원","dJobJCd":"3204","dJobJCdNm":"[3204]증권 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004467:1', '{"dJobCd":"K000004467","dJobCdSeq":"1","dJobNm":"부실상장등록법인관리사무원","workSum":"부실상장(거래소시장)·등록(코스닥시장-협회중개시장)법인의 관리종목 지정사유 해소를 위한 자구노력을 촉구하고 투자자에 대한 주의를 환기하는 업무를 수행한다.","doWork":"부실상장·등록법인의 실태를 파악하고 상장폐지·등록취소기준 해당에 대한 우려를 사전에 예고한다. 관리종목기준에 해당된다고 판단되는 경우 사업보고서상의 지정요건을 확인하고, 공시사항에서 지정요건을 확인한다. 매매거래정지에 대한 사항을 기안하며 관리종목으로 지정하고 시장조치한다. 관리종목지정사유 및 유예기간종료일 변경사항을 기안한다. 관리종목지정해제조건에 해당하는 경우 사업보고서 및 공시사항에서 해제요건을 확인하고 관리종목지정해제를 기안하며 시장조치한다. 매매거래 등의 시장조치를 취하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0322","dJobECdNm":"[0322]증권 사무원","dJobJCd":"3204","dJobJCdNm":"[3204]증권 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004352:1', '{"dJobCd":"K000004352","dJobCdSeq":"1","dJobNm":"선물옵션시장운영원","workSum":"선물 및 옵션거래의 공정성과 효율성, 원활한 매매체결을 위해 선물시장을 운영한다.","doWork":"상품선물, 통화금리, 주가지수 등의 선물옵션상품 및 각 상품별 선물옵션종목에 대한 전문적 지식을 갖춘다. 해외선물옵션시장의 정보와 규정 등을 수집하며 사례를 연구한다. 세계 각국의 선물옵션시장과 연결된 통신망의 전산시스템이 정상적으로 작동되는지 확인한다. 장중 시장운영상황을 감시한다. 매매 관련 프로그램을 점검하고 보완조치하며 전산장애 발생 시에는 시정조치한다. 선물 및 옵션 매매기준가 및 정산가격을 확인한다. 선물 및 옵션을 신규상장 조치하고 착오매매가 있을 경우 정정승인 및 관련 서류를 징수한다. 시장운영일지의 작성 및 선물옵션시장 시설물을 관리한다. 선물옵션 매매담당자(선물거래사)의 등록 및 취소 등을 관리하고 매매 관련 문의사항에 대해 응대한다. 부정거래를 감시하며 방지하기 위한 규정을 수립하여 제안하고 시장운영상의 문제점을 보완한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"파생상품시장운영원","connectJob":"매매대상에 따라 선물시장운영원, 옵션시장운영원","dJobECd":"0322","dJobECdNm":"[0322]증권 사무원","dJobJCd":"3204","dJobJCdNm":"[3204]증권 사무원","dJobICd":"K641/K661","dJobICdNm":"[K641]은행 및 저축기관 / [K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001871:1', '{"dJobCd":"K000001871","dJobCdSeq":"1","dJobNm":"선물환사무원","workSum":"선물환거래를 상담하고 거래의 약정을 통해 계약을 체결하고 계약이행보증금을 인수한 후 사후관리하는 업무를 수행하다.","doWork":"국내외 선물환시장의 현황과 동향을 분석하여 파악한다. 국내외 선물환종목에 대한 전문적 지식을 배양한다. 최근의 선물환종목지수를 파악하고 환율변동, 금리 등의 금융정세와 세계경기지수 흐름을 주시한다. 선물환거래를 필요로 하는 고객을 대상으로 거래절차, 금액, 기간, 계약환율의 결정, 계약이행보증금 등에 관해 상담하고 고객에게 알맞은 선물환 종류를 제시(확정일 인도방식, 일정기간인도방식, 범위환율)한다. 선물환거래약정서, 채권보전상 필요서류 등 서류를 청구한다. 최초 거래 시 1회에 한하여 선물환거래에 관한 기본약정을 체결하고 선물환거래한도를 설정한다. 선물환율을 제시하고 선물환계약을 체결한다. 체결 시 계약이행을 보증하기 위하여 계약기간별로 차등하여 계약금액의 일정비율을 보증금으로 징수한다. 보증금을 원화로 징수할 경우(원화 또는 외화로 징수 가능), 계약시점의 대고객 전신환매도율을 적용하여 산출한다. 만기일에 선물환계약을 실행하거나 정산 또는 연장하는 업무를 담당한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0322","dJobECdNm":"[0322]증권 사무원","dJobJCd":"3204","dJobJCdNm":"[3204]증권 사무원","dJobICd":"K641/K661","dJobICdNm":"[K641]은행 및 저축기관 / [K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004123:1', '{"dJobCd":"K000004123","dJobCdSeq":"1","dJobNm":"유가증권매매제도기획원","workSum":"증권 및 선물옵션시장의 원활한 운영을 위하여 매매제도 개선과 업무규정의 개정업무를 수행한다.","doWork":"유가증권 매매자를 위하여 각종 매매제도를 개선하고 제도개선에 따른 성과를 분석한다. 증권거래법, 선물거래법 등 관련 법령의 개정의견을 마련하고 개정내용은 매매 관련 규정에 반영한다. 매매 관련 규정집을 발간한다. 외국증권시장, 선물옵션시장의 각종 매매제도를 분석하고 관련 법령 및 제도 등을 연구한다. 언론 및 관계기관 등에 매매 관련 제도의 설명자료 및 분석자료를 제공한다. 매매제도 해설자료를 발간하고 투자자의 매매 관련 문의사항에 답변한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"매매되는 상품에 따라 주식매매제도기획원, 채권매매제도기획원, 선물옵션매매제도기획원","dJobECd":"0322","dJobECdNm":"[0322]증권 사무원","dJobJCd":"3204","dJobJCdNm":"[3204]증권 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007241:1', '{"dJobCd":"K000007241","dJobCdSeq":"1","dJobNm":"유가증권발행사무원","workSum":"유가증권 발행회사로부터 등록발행 접수를 받아 유가증권의 발행 및 발행된 유가증권의 예탁의뢰업무를 수행한다.","doWork":"유가증권 발행사로부터 유가증권 발행의뢰문서를 접수받아 문서를 심사한다. 감독기관에 증권용지를 신청하여 수령한다. 증권용지를 가쇄(주권용지에 주권의 기재사항을 표시하는 것)하여 인지를 첨부하고 주주명기재 및 인장을 날인하여 심사 후 종목의 생성을 의뢰한다. 채권의 발행은 대부분 등록발행을 하므로 종목생성내역에 대해 심사하고 채권등록발행하며 등록부를 관리한다. 발행된 유가증권에 대해서는 채권예탁부서로 예탁접수를 의뢰한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"발행물의 종류에 따라 주식발행사무원, 채권발행사무원","dJobECd":"0322","dJobECdNm":"[0322]증권 사무원","dJobJCd":"3204","dJobJCdNm":"[3204]증권 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007172:1', '{"dJobCd":"K000007172","dJobCdSeq":"1","dJobNm":"유가증권보관사무원","workSum":"증권예탁 및 결제의 안전과 효율성을 증진하기 위하여 주식이나 채권 등의 유가증권을 안전하게 보관하며 병합, 분할, 명의개서 등으로 인한 증권의 입출고 및 반환 등의 업무를 수행한다.","doWork":"예탁유가증권, 보호예수증권, 증권용지 등을 수령 후 사고 여부를 확인한다. 유가증권을 종류별, 종목별로 혼합·입고·보관하고 입·출고대장에 기록한다. 예탁자가 보호예수를 의뢰한 유가증권을 마이크로필름을 이용하여 촬영한 후 계수기를 이용하여 계산한 후 보호예수용 봉투에 담아 금고에 보관한다. 유가증권의 병합, 분할, 감자, 명의개서 등의 업무수행을 위해 보관등록필증 등을 금고에서 출고하였다가 해당 업무가 처리되고 나면 재입고한다. 만기가 도래하면 출고의뢰서를 접수받고 유가증권을 전달한다. 증권거래업무가 종료되면 당일 발생된 증권입·출고표를 종류별·종목별로 분류집계·산출하고 일계표를 작성한다. 장기간 보관 중인 유가증권의 시세를 조사한다. 금고를 관리하며 출입을 통제한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"기록","workFunc2":"관련없음","workFunc3":"관련없음","similarNm":"유가증권보호예수원","connectJob":"보관하는 유가증권의 종류에 따라 주식보관사무원, 채권보관사무원","dJobECd":"0322","dJobECdNm":"[0322]증권 사무원","dJobJCd":"3204","dJobJCdNm":"[3204]증권 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006738:1', '{"dJobCd":"K000006738","dJobCdSeq":"1","dJobNm":"유상증자인수주선사무원","workSum":"주권상장법인과 협회등록법인 중 유상증자 가능업체를 발굴하여 자본금 확충을 위한 공모증자시 주식을 인수주선한다.","doWork":"고객인 증자예정 업체에 유리한 최적증자 시기를 결정한다. 고객과 협의하여 증자규모 및 증자방법(주주우선공모, 주주배정공모, 일반공무, 제3자배정 등)을 결정하고 인수계약을 체결한다. 유가증권을 분석하여 발행회사가 유가증권신고서를 감독기관에 제출할 때 해당 유가증권분석보고서를 협회에 제출한다. 증자를 신청하고 청약을 받아 발행회사에 납입하며, 발행실적보고서를 제출한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"협의","workFunc3":"단순작업","dJobECd":"0322","dJobECdNm":"[0322]증권 사무원","dJobJCd":"3204","dJobJCdNm":"[3204]증권 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006831:1', '{"dJobCd":"K000006831","dJobCdSeq":"1","dJobNm":"자산유동화증권발행주선사무원","workSum":"기업, 금융기관의 부실채권 처리, 신용보강, 자금조달 등을 목적으로 기업, 금융기관이 보유한 유동성이 없는 자산을 증권으로 전환하고 자본시장에서 현금화하는 자산유동화증권 발행·주선업무를 수행한다.","doWork":"자산보유자(기업, 금융기관 등), 유동화전문회사, 자산관리자 및 수탁기관 등과 협의하고, 기초자산의 완전매각, 신용보강, 재투자, 후순위채권 발행, 보증, 추가 현금적립 등 다양한 금융기법을 검토하여 자산유동화증권(ABS:Asset-Backed Securities) 발행방법을 기획하고 추진한다. 종류에 따라 CBO(Collateralized Bond Obligation:채권담보부증권, 투기등급의 고수입-고위험 채권을 담보로 발행), CLO(Collateralized Loan Obligation:대출채권담보부증권, 신용도가 낮은 기업들에 대한 은행의 대출채권을 묶어 이를 담보로 발행), MBS(Mortgage Backed Securities:주택저당담보부채권, 금융기관이 집을 담보로 대출해 주고 그 채권을 근거로 발행), Primary CBO(신규 발행되는 회사채를 자산으로 할 때), Secondary CBO(기 발행되어 유통되는 회사채를 대상으로 할 때) 등을 진행한다. 자산의 현금흐름을 파악하고 이를 자산의 소유자로부터 분리하여 특수목적회사(SPC:Special Purpose Company, 특정 목적을 위해 일시적으로 설립되는 서류상의 회사)에 양도한다. 양도한 자산을 담보로 특수목적회사가 증권을 발행하여 원소유자가 자금을 조달하도록 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"협의","workFunc3":"관련없음","similarNm":"자산담보채권발행주선사무원","dJobECd":"0322","dJobECdNm":"[0322]증권 사무원","dJobJCd":"3204","dJobJCdNm":"[3204]증권 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004239:1', '{"dJobCd":"K000004239","dJobCdSeq":"1","dJobNm":"주식결제사무원","workSum":"유가증권시장의 주식거래에 따른 증권과 대금의 청산 및 결제업무를 담당한다.","doWork":"각 증권사로부터 접수되어 체결된 매매체결자료를 전산적으로 가공하여 결제포지션을 구한다. 매매체결자료상에 정정사항이 발생한 경우 정정처리한다. 지정된 결제일까지 주식의 인도가 불가능할 때에는 인수측의 동의를 얻어 일정기간 결제를 유예시켜준다. 최종 확정된 결제포지션에 따라 주식 및 대금의 인수도(인수와 인도)를 처리한다. 증권거래에 따르는 제반 수수료와 세금을 참가자별로 배분하여 원천공제한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"주식결제원","dJobECd":"0322","dJobECdNm":"[0322]증권 사무원","dJobJCd":"3204","dJobJCdNm":"[3204]증권 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003754:1', '{"dJobCd":"K000003754","dJobCdSeq":"1","dJobNm":"주식권리관리사무원","workSum":"실질주주(예탁자의 고객)를 위해 의결권, 매수청구, 유·무상증자, 합병, 감자 등 회사의 주식 관련 권리행사업무를 수행한다.","doWork":"실질주주가 주주총회에 참석하지 못하는 경우 예탁자(증권예탁원)를 통해 온라인으로 각 안건에 대해 찬반을 표시하면 이를 취합하여 주주총회 당일 직접 참석하여 의결권을 행사한다. 발행회사가 주주에게 증권예탁원의 의결권 행사에 관한 사항을 통지하거나 공고하는 경우 주주총회 7일 전까지 예탁자에게 의결권행사요청서를 제출하면 주주의 의사표시(직접행사, 대리행사, 불행사)를 주주총회 5일 전까지 접수하여 의사표시주식수, 무의결권주식수, 외국인주식수를 차감한 주식 수를 초과하지 않은 범위 내에서 발행회사가 요청한 주식 수에 대해 의결권을 행사한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"기록","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"주식의결권행사사무원, 주식매수청구사무원","dJobECd":"0322","dJobECdNm":"[0322]증권 사무원","dJobJCd":"3204","dJobJCdNm":"[3204]증권 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005246:1', '{"dJobCd":"K000005246","dJobCdSeq":"1","dJobNm":"주식예탁사무원","workSum":"예탁자(증권사, 기관투자가)로부터 주권을 접수하여 예탁으로 수용하는 업무를 수행한다.","doWork":"예탁자로부터 주권을 접수하면 예탁대상 종목 여부, 예탁제한 여부, 계좌명과 계좌번호의 일치 여부, 종목명과 종목코드의 일치 여부, 매수 및 주식 수, 예탁일, 주권의 하자 여부 등을 심사한다. 심사가 끝나면 예탁내역을 입력하고 유가증권예탁서와 주권을 마이크로필름으로 촬영하며 위변조검사기와 시각 및 촉감을 통해 검사한다. 주권배면의 최종 명의인을 분류하고 OCR판독기를 통해 예탁자, 종목, 매수, 수량, 권종, 횟수, 번호 등 세부내역을 등록하고 주권과 등록내역을 체크한다. 주권의 안전한 보관을 위하여 실물보관부서에 인계한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"기록","workFunc2":"말하기신호","workFunc3":"단순작업","similarNm":"증권예탁결제원","dJobECd":"0322","dJobECdNm":"[0322]증권 사무원","dJobJCd":"3204","dJobJCdNm":"[3204]증권 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001801:1', '{"dJobCd":"K000001801","dJobCdSeq":"1","dJobNm":"주식인수주선사무원","workSum":"기업공개 예정인 기업을 발굴하여 증권거래소 또는 협회중개시장(코스닥시장)에 상장 또는 등록을 주선한다.","doWork":"정보네트워크를 이용하여 고객에게 가치 있는 정보(발행의향, 발행예정일, 재무상태, 경영상태 등)를 수집한다. 고객에게 유리한 최적 발행시기를 결정하고 주간사 유치를 위해 고객과 교섭한다. 발행회사와 인수계약을 맺고 유가증권을 분석한다. 기업의 본질가치(수익가치와 자산가치)와 상대가치 및 사업성을 감안하여 공모희망가액을 제시하고 수요량을 파악한다. 발행회사가 유가증권신고서를 감독기관에 제출할 때, 유가증권분석보고서를 작성하여 협회에 제출한다. 공모가액을 결정하고 인수주식을 배정한다. 일반인을 대상으로 청약을 받아 발행회사에 납입한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"협의","workFunc3":"단순작업","connectJob":"기업공개주선사무원, 등록주선사무원, 상장주선사무원","dJobECd":"0322","dJobECdNm":"[0322]증권 사무원","dJobJCd":"3204","dJobJCdNm":"[3204]증권 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005939:1', '{"dJobCd":"K000005939","dJobCdSeq":"1","dJobNm":"주식투자상담원","workSum":"주식에 대해 고객과의 투자상담을 통해 수탁주문을 받고 영업을 수행한다.","doWork":"고객에게 투자상담을 하기 위하여 국내외 증시동향을 체크하고 신문, 연구분석 자료, 정보네트워크 등을 통해 정보를 수집한다. 팀 회의를 통해 장세전망 및 매매전략을 수립한다. 동시호가(접수된 호가순서나 시간의 전후가 분명치 않아 매매처리과정에서 시간우선원칙을 배제시키고 가격과 수량우선원칙만을 적용하여 단일가격으로 매매를 체결시키는 방식)주문을 접수한다. 투자고객과 상담하고 매매수탁 및 주문을 입력하고 체결내역을 보고한다. 주요고객 및 고액자산에 대해 상담 및 관리를 한다. 투자유치 및 증권상품 판매를 위한 외부영업활동을 수행한다. 거래시간이 끝나면 시황분석 종목발굴 및 다음날의 투자전략을 수립한다. 고객매매체결 내역을 확인하고 통보한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"설득","workFunc3":"단순작업","similarNm":"주식브로커, 주식영업원, 주식투자상담사, 주식투자중개인, 종합투자상담사","certLic":"파생상품투자권유자문인력, 증권투자권유자문인력, 일읾투자사잔운용사","dJobECd":"0322","dJobECdNm":"[0322]증권 사무원","dJobJCd":"3204","dJobJCdNm":"[3204]증권 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004517:1', '{"dJobCd":"K000004517","dJobCdSeq":"1","dJobNm":"증권금융사무원","workSum":"유가증권과 관련된 모든 융자업무(증권금융업무)를 담당한다.","doWork":"증권회사에서 실행하는 신용대출, 주식담보대출, 예탁증권담보융자, 주식매도자금대출, 금융상품담보대출, 공사채를 담보로 하는 융자 등을 담당한다. 신용대출을 위해 고객과 신용약정체결을 하며 고객의 거래실적에 따라 금리를 결정한다. 또한 증권회사의 융자(인수업무를 위한 금융, 딜러임무를 위한 금융 등)를 담당한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0322","dJobECdNm":"[0322]증권 사무원","dJobJCd":"3204","dJobJCdNm":"[3204]증권 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002267:1', '{"dJobCd":"K000002267","dJobCdSeq":"1","dJobNm":"증권대행사무원","workSum":"명의개서업무를 중심으로 이에 준하는 업무(배당금 지불사무, 신주발행에 관한 사업, 주주총회의 소집통지, 그 결의보고의 취급사무 등 사업회사의 주식과가 행하는 업무)를 대행하여 수행한다.","doWork":"상장 혹은 등록예정법인, 기타 주식이나 채권발행회사와 명의개서대리인계약을 체결한다. 계약체결 후에 주주명부, 유가증권발행원부, 인감표, 예비증권 등에 관련된 사무를 처리하고 제장표를 명의개서대행사무원에게 인계한다. 발행회사의 유가증권발행 전용인장을 인계받아 관리한다. 명의개서와 관련한 제반 신고 및 청구(주주에 관한 제신고, 사고주권에 대한 신고, 질권의 등록 또는 말소신고, 증권의 신규발행 및 재발행 신고, 주권의 불소지신고 등) 관련 업무를 수행한다. 이를 위해 주주명부, 사채원부를 작성하고 관리하며, 질권의 등록 또는 말소, 신탁재산의 표시 또는 말소, 배당금 지급, 미교부주권의 압류 및 강제집행 등의 업무를 담당한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"기록","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"명의개서청구사무원","dJobECd":"0322","dJobECdNm":"[0322]증권 사무원","dJobJCd":"3204","dJobJCdNm":"[3204]증권 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001307:1', '{"dJobCd":"K000001307","dJobCdSeq":"1","dJobNm":"증권사고객분석기획자","workSum":"증권사에서 고객의 데이터를 분석·통합하여 고객을 적극적으로 관리하고 마케팅전략을 개발한다.","doWork":"CRM(Customer Relationship Management)을 수행하기 위하여 통합고객데이터베이스 개발전략을 기획하고 추진한다. 고객이해기준을 정의하며 CRM운영정책 및 운영절차를 수립한다. 분석CRM(여러 가지 채널을 통해 고객 관련 정보를 수집하고 분석하여 고객서비스 및 마케팅전략을 개선)성과를 측정하고 평가한다. 각 채널에 고객분석자료를 제공한다. 고객과의 접점(지점, 콜센터 등)에서 운용할 CRM전략을 수립하고 지점의 운영CRM(비즈니스의 구현을 위하여 채널별 프로세스를 통합하고 고객접촉이력을 관리하여 후선지원업무-Back Office를 통합)을 기획·관리·평가한다. 홈페이지, 이메일 등을 통한 CRM운영을 기획·관리·평가한다. 고객분석정보시스템을 관리한다. 고객영업정보를 관리하고 경영자료로 보고한다. 데이터 추출 및 활용, CRM정보 활용 등에 대한 교육업무를 수행하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"협의","workFunc3":"관련없음","similarNm":"증권사CRM기획운영자","connectJob":"전문분야에 따라 분석CRM기획자, 운영CRM기획자, 통합CRM전략기획자","dJobECd":"0322","dJobECdNm":"[0322]증권 사무원","dJobJCd":"3204","dJobJCdNm":"[3204]증권 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004244:1', '{"dJobCd":"K000004244","dJobCdSeq":"1","dJobNm":"증권사고객센터상담원","workSum":"증권사 고객센터에서 고객상담업무를 수행한다.","doWork":"고객의 전화를 받아 주문 및 시세, 계약체결, 잔고확인 등의 문의에 응대한다. 이체·대체업무를 처리한다. 금융상품 매매 및 종합금융상품 고객을 상담한다. HTS(home trading system) 이용 관련 문의에 대응한다. 전산장애 시 비상주문을 처리한다. 계좌개설안내, 지점안내, 사고등록 및 제변경업무 등 고객이 증권사서비스 이용 시 발생하는 제반 문의에 응대한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"증권사콜센터텔러","dJobECd":"0322","dJobECdNm":"[0322]증권 사무원","dJobJCd":"3204","dJobJCdNm":"[3204]증권 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002655:1', '{"dJobCd":"K000002655","dJobCdSeq":"1","dJobNm":"증권사고객센터운영자","workSum":"증권사의 고객센터를 운영·관리한다.","doWork":"증권사 고객센터의 운영전략을 수립한다. 직원관리(채용, 근태, 평가, 상담원 모니터링), 직원교육(교육프로그램 기획, CS관리, 업무규정 개선 및 관리)업무를 기획 및 운영한다. 위탁운영을 하는 경우 위탁운영사 및 인력파견업체와 계약을 체결하고 운영을 관리·감독한다. 고객센터업무시스템 및 ARS시스템을 관리한다. VOC시스템(콜센터에 접수되는 고객불만사항을 접수부터 처리가 완료될 때까지 진행상황을 실시간으로 관리하고 처리결과를 관서별로 지표화하여 관리·평가함으로써 고객의 체감서비스를 향상시키는 고객관리시스템)을 운용한다. 고객의 제안사항을 수렴하고 반영한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"증권사콜센터운영자","dJobECd":"0322","dJobECdNm":"[0322]증권 사무원","dJobJCd":"3204","dJobJCdNm":"[3204]증권 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003058:1', '{"dJobCd":"K000003058","dJobCdSeq":"1","dJobNm":"증권사고액자산고객영업기획자","workSum":"증권사에서 고액자산고객에 대한 영업활동을 기획하고 추진한다.","doWork":"증권사에서 PB(Pravate Banking)영업전략 및 프로세스를 기획한다. PB상품 및 서비스(부가서비스)를 기획하고 개발한다. 세무, 부동산, 법률, 포트폴리오 설계, 은퇴설계 등 고객에게 제공할 전문분야 컨설팅을 기획하고 지원한다. 전문분야 컨설팅 연계상품을 기획한다. PB영업환경 및 제도를 기획하고 관리한다. PB영업지원 자료를 개발하고 배포한다. PB센터의 인력운용, 영업목표 관리, 평가, 보상 등 제반 영업활동을 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"증권사PB영업기획자","dJobECd":"0322","dJobECdNm":"[0322]증권 사무원","dJobJCd":"3204","dJobJCdNm":"[3204]증권 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006460:1', '{"dJobCd":"K000006460","dJobCdSeq":"1","dJobNm":"증권사구조화금융운용원","workSum":"증권사에서 구조화금융(Structured Finance)을 운용한다.","doWork":"구조화금융(Structured Finance:기존의 정형화된 기법이나 과정으로 만족시킬 수 없는 특별한 금융 관련 수요에 부응하기 위해 기존 금융상품에 위험관리수단을 적절히 혼합한 맞춤형이나 주문형 상품을 제공하는 금융)업무를 수행하기 위하여 자산유동화증권의 발행 관련 인수주선 영업(유가증권을 발행함에 있어 증권회사 등이 이를 매출할 목적으로 그 유가증권의 전부 또는 일부를 취득하여 일반 대중에게 균일한 조건으로 취득을 청약한 것을 권유하는 업무), 실물펀드 관련 인수주선 영업, 기타 파생금융상품의 발행 관련 인수주선 영업을 수행한다. 부동산 및 프로젝트 금융업무를 수행하는 경우 프로젝트 자금조달 관련 자문 및 주선 영업활동, 프로젝트 금융자문 등 서비스용역 관련 업무, 부동산개발 컨설팅 관련 영업업무를 수행한다. 주식관련사채업무를 수행하는 경우 주식관련사채 발행 관련 인수주선 영업, 기타 주식 및 주식관련사채 발행 관련 인수주선 영업을 수행한다. 기업자금조달에 관련된 자문 및 주선 영업활동을 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","dJobECd":"0322","dJobECdNm":"[0322]증권 사무원","dJobJCd":"3204","dJobJCdNm":"[3204]증권 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003484:1', '{"dJobCd":"K000003484","dJobCdSeq":"1","dJobNm":"증권사법인영업원","workSum":"증권사에서 기관 및 법인을 대상으로 영업활동을 수행한다.","doWork":"법인고객(기관투자가 및 사업법인)의 매매거래를 유치한다. 비회원증권사를 대상으로 하는 위탁 및 중개매매를 유치한다. 주문을 접수 및 체결하고 매매를 보고한다. 법인고객을 대상으로 파생상품 및 관련 상품영업, 파생상품 영업에 부수되는 주식, 채권 및 파생상품 운용, 프로그램 매매와 관련한 각종 대내외 보고업무를 수행한다. 착오매매를 처리한다. 법인영업과 관련된 정보조사 및 관련 자료를 작성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"설득","workFunc3":"관련없음","dJobECd":"0322","dJobECdNm":"[0322]증권 사무원","dJobJCd":"3204","dJobJCdNm":"[3204]증권 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007316:1', '{"dJobCd":"K000007316","dJobCdSeq":"1","dJobNm":"증권사선물영업원","workSum":"증권사에서 선물영업활동을 수행한다.","doWork":"한국거래소 상장 장내파생상품에 대한 위탁영업, 외국인 투자자를 대상으로 한 국내선물 위탁영업, 해외선물 위탁영업을 한다. 선물 착오매매를 처리한다. 법인영업 관리업무 및 법인영업 관련 수도결제(거래소시장에서 매매거래된 주식 또는 채권이 증권거래소가 지정한 결제기구를 통해서 매수측은 대금을, 매도측은 증권을 수수하는 것)업무를 수행한다. FCM(Futures Commission Merchants:선물중개회사) 계좌개설업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","dJobECd":"0322","dJobECdNm":"[0322]증권 사무원","dJobJCd":"3204","dJobJCdNm":"[3204]증권 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004928:1', '{"dJobCd":"K000004928","dJobCdSeq":"1","dJobNm":"증권사영업지점상담원","workSum":"증권사의 영업지점에서 고객계좌업무, 매매주문, 투자상담 등 대고객업무를 수행한다.","doWork":"증권사영업지점에서 고객계좌의 개설 및 해지, 폐쇄업무, 고객카드 및 통장, 현금카드 관리업무, 고객 실명확인 및 전환신청 접수 및 처리업무, 고객정보 변경신청 접수 및 처리업무, 서비스 이용신청 접수 및 처리업무, 고객의 제확인서 및 증명서 발급업무, 고객계좌 원장(매매보고서 등) 관리업무, 유가증권 매매주문 접수 및 처리업무, 채권매매주문 접수 및 처리업무, 청약 및 고객 유가증권 권리행사 신청접수 및 처리업무, 고객예탁금 변동상황 관리업무, 대고객 투자상담 및 신규고객 투자안내업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","similarNm":"증권사영업점텔러","dJobECd":"0322","dJobECdNm":"[0322]증권 사무원","dJobJCd":"3204","dJobJCdNm":"[3204]증권 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003457:1', '{"dJobCd":"K000003457","dJobCdSeq":"1","dJobNm":"증권사온라인서비스기획운영자","workSum":"증권사의 온라인서비스를 기획·운영한다.","doWork":"증권시장의 온라인매체를 이용한 서비스환경을 분석하고 전략을 수립한다. 경쟁사의 동향을 분석한다. 증권사 온라인매체(고객에게 온라인으로 제공되는 서비스)를 관리하고 개선한다. 고객의 건의사항을 접수하고 반영한다. 제도개선 및 신상품 도입 시 온라인채널에 최적화되도록 기획하고 관리한다. 온라인비즈니스에 관련된 제휴사업을 관리한다. 신규매체(모바일서비스, 신규트레이딩채널 등)를 기획·개발하고 관리한다. 온라인매체에서 수행되는 프로모션을 기획·관리한다. 온라인서비스에 주문장애 및 분쟁이 발생하면 조정하고 손실보상업무를 수행한다. 온라인서비스에 장애가 발생하면 관련 담당자와 협의하여 처리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0322","dJobECdNm":"[0322]증권 사무원","dJobJCd":"3204","dJobJCdNm":"[3204]증권 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005152:1', '{"dJobCd":"K000005152","dJobCdSeq":"1","dJobNm":"증권사운영사무원","workSum":"증권사에서 각종 결제사무 및 계좌관리, 증권관리업무를 수행한다.","doWork":"외화자금 결제 및 계좌관리업무(외화자금 및 외화파생상품 결제업무, 외화계좌관리, 외화자금 수도결제업무, 외화증권 매매결제 및 권리행사 업무)를 수행한다. 증권관리업무(유가증권의 보관, 관리, 예탁, 보호예수 및 계좌대체, 유가증권의 입출고 관리, 배당금 및 채권원리금 관리, 유무상증자에 따른 신주의 청약 및 배정, 명의개서 및 관리행사, 부외자산 및 사고증권의 관리, 유가증권 대차업무, 실기주 청구, 결제불이행내역 통보·수신 및 조치, 대용증권관리, 매매거래에 따른 장내 수도결제)를 수행한다. OTC결제업무(장외파생상품 관련 결제 및 확인업무, 장외파생상품 평가 및 적정성 검증, 장외파생상품 발행 및 상환업무, 장외파생상품 서류업무, 장외파생상품 거래정정업무)를 수행한다. 채권 및 상품주식 관련 결제업무(상품채권 관련 결제 및 확인업무, 국채선물 정산지급 결제업무, 상품주식관리, 상품주식 회계마감)를 수행한다. 해외선물결제업무(가환전 한도관리, 해외선물거래 관련 결제 및 확인업무, 중개계좌관리, 국제증권거래소 및 코스피 결제업무)를 수행한다. 법인결제업무(국내 법인의 주식·선물(기관)결제, 비거주 외국법인의 주식(기관)결제, 비거주 외국법인 주식매매 체결내역보고, 국내외 법인계좌개설·계좌관리·입출금·청약·권리행사에 따른 법인계좌 관리업무)를 수행한다. 대외보고, 상임대리인업무, 실무인수도(통지문 생성, 결제불이행 관련 대납 등), 유가증권 담보관리업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0322","dJobECdNm":"[0322]증권 사무원","dJobJCd":"3204","dJobJCdNm":"[3204]증권 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001429:1', '{"dJobCd":"K000001429","dJobCdSeq":"1","dJobNm":"증권사장외파생금융상품영업원","workSum":"증권사에서 장외파생금융상품 영업활동을 수행한다.","doWork":"수요예측(Book Bilding:업을 공개할 때 공모가격 산정을 위해 주간사가 사전에 공모주식수요를 파악하여 공모가격을 결정하는 제도), 청약, 배정, 청약금예치 및 환불업무를 수행한다. 외부공시 관련 문서를 작성하고 검토한다. 상품설명서, 제안서, 인수계약서, 간이투자설명서 등을 발행하고 거래 관련 문서를 작성하여 파생결합증권, 파생결합사채 및 장외파생상품을 발행하고 공시한다. 파생결합증권, 파생결합사채 및 장외파생상품을 판매하거나 외부투자가(기관투자가)를 영입한다. 영업 관련 문서를 작성하고 체결한다. Back to Back 거래(같은 손익구조를 가진 외국계증권사 등 외부로부터 계약을 통하여 또는 유가증권으로 구입한 뒤 고객에게 판매하는 거래), 거래상대방 위험 및 한도 관리, Back to Back 거래결제를 위한 외환거래업무를 수행한다. 금지금 매매 및 중개업무를 수행하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","similarNm":"OTC영업원(Over The Counter derivatives)","dJobECd":"0322","dJobECdNm":"[0322]증권 사무원","dJobJCd":"3204","dJobJCdNm":"[3204]증권 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003632:1', '{"dJobCd":"K000003632","dJobCdSeq":"1","dJobNm":"증권사주식공개담당자","workSum":"증권사에서 기업의 주식공개에 관련된 제반 업무를 진행한다.","doWork":"IPO((Initial Public Offering:일정 규모의 기업이 상장절차 등을 밟기 위해 행하는 외부투자자들에 대한 첫 주식공매) 가능기업의 발굴 및 IPO 관련 인수주선(유가증권을 발행함에 있어 증권회사 등이 이를 매출할 목적으로 그 유가증권의 전부 또는 일부를 취득하여 일반 대중에게 균일한 조건으로 취득을 청약한 것을 권유하는 업무)영업을 한다. 주식발행 관련 인수주선영업을 한다. 주식관련사채 발행 관련 인수주선영업을 한다. 상장주식 대량매매 관련 영업을 한다. SPAC(Special Purpose Acquisition Company:특수인수목적회사, 기업 인수합병을 목적으로 페이퍼컴퍼니를 설립해 투자금을 모아 상장한 다음, 이를 바탕으로 비상장기업에 투자)의 설립 및 운용 관련 지원업무, SPAC의 상장업무, SPAC의 합병 관련 지원업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","similarNm":"IPO(Initial Public Offering)담당자","dJobECd":"0322","dJobECdNm":"[0322]증권 사무원","dJobJCd":"3204","dJobJCdNm":"[3204]증권 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005406:1', '{"dJobCd":"K000005406","dJobCdSeq":"1","dJobNm":"증권사주식인수주선사무원","workSum":"증권사에서 주식 및 주식관련사채의 인수주선업무를 수행한다.","doWork":"주식 및 주식관련사채 인수주선(유가증권을 발행함에 있어 증권회사 등이 이를 매출할 목적으로 그 유가증권의 전부 또는 일부를 취득하여 일반 대중에게 균일한 조건으로 취득을 청약한 것을 권유하는 업무)에 관련된 발행조건과 계약조건을 검토한다. 가격책정 및 시장성을 검토한다. 상장주식 대량매매를 실행한다. 수요예측(Book Building:기업을 공개할 때 공모가격 산정을 위해 주간사가 사전에 공모주식수요를 파악하여 공모가격을 결정) 및 배정업무를 한다. Equity Financing(자본경영, 부채금융과는 반대되는 말로 기업이 주식 등 소유지분을 매각하여 자금을 조달하는 경영)을 통한 기업의 자금조달 주선조건 등을 검토하고 판매전략을 수립 및 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","dJobECd":"0322","dJobECdNm":"[0322]증권 사무원","dJobJCd":"3204","dJobJCdNm":"[3204]증권 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004058:1', '{"dJobCd":"K000004058","dJobCdSeq":"1","dJobNm":"증권사지점영업전략기획자","workSum":"증권사 본사에 소속되어 영업지점의 영업전략을 기획·관리한다.","doWork":"시장의 상황, 영업환경의 변화, 경쟁사의 정보, 지점의 영업실적 등을 수집·분석하여 지점영업전략을 수립한다. 수립된 영업전략에 따라 영업목표를 설정하고 관리한다. 정기적으로 각 지점별 영업활동을 분석하고 평가한다. 지점별 영업인력을 기획하고 운용한다. 각 영업점별 목표, 지점장의 목표, 영업직원의 목표를 관리하고 평가한다. 영업지원 캠페인 활동, 지점 및 직원의 포상제도 등을 시행하고 관리한다. 지점장회의를 주관한다. 지점에서 수행할 새로운 사업 및 새로운 금융상품의 개발, 도입을 결정하고 영업이 가능하도록 제반 지원활동을 수행한다. 영업점 관련 제도를 개발·변경·관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","similarNm":"증권사리테일전략기획자","dJobECd":"0322","dJobECdNm":"[0322]증권 사무원","dJobJCd":"3204","dJobJCdNm":"[3204]증권 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005542:1', '{"dJobCd":"K000005542","dJobCdSeq":"1","dJobNm":"증권사지점영업지원담당자","workSum":"증권사영업지점의 영업활동을 지원한다.","doWork":"증권사지점영업원의 실적급, 성과급, 수익기여도를 집계한다. 전산에 지점관리자의 관리등록업무를 수행한다. 온라인을 통해 주식매매를 하는 시스템(HTS:Home Trading System)에 ID 등록 및 이용을 지원한다. 거래소시장업무(시장·거래원에게 정보제공업무, 자사주거래업무, 대량매매업무)를 수행한다. 지점의 투자설명회에 대한 업무를 지원한다. 영업 관련 사고 및 분쟁을 예방하는 활동을 한다. 영업제도 지원업무(신용공여 관련 예외업무, 고객별 합의수수료 관련 업무, 국내외 선물위탁증거금 적용기준 업무)를 수행한다. 지점 영업의 리스크관리(랩어카운트 운용리스크 관리, 미수제한 종목 관리, 신용융자 가능종목 관리)업무를 수행한다. 지점의 인원운용, 지점신설 및 임시영업소의 설치 등에 대한 지원업무를 수행한다. 고객의 요구, 불만, 고객만족도 등을 관리하고 평가 및 개선한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","dJobECd":"0322","dJobECdNm":"[0322]증권 사무원","dJobJCd":"3204","dJobJCdNm":"[3204]증권 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005519:1', '{"dJobCd":"K000005519","dJobCdSeq":"1","dJobNm":"증권사채권영업원","workSum":"증권사에서 채권, 양도성예금, 기업어음 등을 중개·주선한다.","doWork":"거래기관 관리 및 동향을 파악한다. 채권중개영업에 수반되는 채권 단기운용 및 헷지(Hedging, 자신의 이익을 가격변동위험으로부터 보호하고자 이미 보유하고 있거나 보유할 예정인 현물포지션에 대응하여 동일한 수량의 반대포지션을 선물시장에서 취하는 것)업무를 수행한다. 일일 채권시장의 동향을 분석한다. 거래법인의 자금조달·운용에 관한 자문 및 주선활동을 한다. 채권영업 관련 수도결제(거래소시장에서 매매거래된 주식 또는 채권이 증권거래소가 지정한 결제기구를 통해서 매수측은 대금을, 매도측은 증권을 수수하는 것)업무를 처리한다. CD(Certificate of Deposit:양도성예금증서)중개영업 관련 업무를 수행한다. CP(Commercial Paper:기업어음:기업이 자금조달을 목적으로 발행하는 어음형식의 단기채권)할인 및 매입·매출업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","connectJob":"해외 채권을 영업하는 경우 증권사채권해외영업원","dJobECd":"0322","dJobECdNm":"[0322]증권 사무원","dJobJCd":"3204","dJobJCdNm":"[3204]증권 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005810:1', '{"dJobCd":"K000005810","dJobCdSeq":"1","dJobNm":"증권사채권영업지원원","workSum":"증권사에서 채권영업, 상품운용에 관련된 결제업무를 수행하며 제반 영업활동을 지원한다.","doWork":"채권중개영업, 금융상품영업, 국내 및 해외 파생상품영업 관련 결제업무를 처리한다. 상품채권, 주식관련사채, 채권 관련 파생상품 운용 관련 결제업무를 처리한다. 외환거래, 외화자산 운용, 외화자금차입 관련 결제업무를 수행한다. 계좌개설, 입출금 등에 따른 고객계좌를 관리한다. 채권 관련 기획, 시장조사, 업계동향 파악 등 마케팅업무를 수행한다. 채권영업 및 운용 관련 기타 후선지원업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0322","dJobECdNm":"[0322]증권 사무원","dJobJCd":"3204","dJobJCdNm":"[3204]증권 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004108:1', '{"dJobCd":"K000004108","dJobCdSeq":"1","dJobNm":"증권사채권인수주선사무원","workSum":"증권사에서 채권 및 금리상품의 인수주선업무를 수행한다.","doWork":"채권(기업어음 및 기타 금리상품)의 인수주선(유가증권을 발행함에 있어 증권회사 등이 이를 매출할 목적으로 그 유가증권의 전부 또는 일부를 취득하여 일반 대중에게 균일한 조건으로 취득을 청약한 것을 권유하는 업무)에 관련된 발행조건과 계약조건을 검토한다. 가격책정 및 시장성을 검토한다. 인수한 채권의 판매전략을 수립 및 수행한다. 인수물 포지션의 운영 및 관리업무를 수행한다. 수요예측(Book Building : 기업을 공개할 때 공모가격 산정을 위해 주간사가 사전에 공모주식수요를 파악하여 공모가격을 결정) 및 배정업무를 한다. 차입경영(Debt Financing), 구조화금융(Structured Financing)을 통한 기업의 자금조달 주선조건 등을 검토하고 판매전략을 수립 및 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","dJobECd":"0322","dJobECdNm":"[0322]증권 사무원","dJobJCd":"3204","dJobJCdNm":"[3204]증권 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002627:1', '{"dJobCd":"K000002627","dJobCdSeq":"1","dJobNm":"증권사해외영업원","workSum":"증권사에서 해외기관투자가 및 해외사업법인을 대상으로 영업활동을 수행한다.","doWork":"해외기관투자가 및 해외사업법인의 매매거래를 유치한다. 해외법인영업에 관련된 정보를 조사하고 자료를 작성한다. 외국계 비회원증권사를 대상으로 위탁 및 중개매매를 유치한다. 해외기관 및 법인을 대상으로 국내선물옵션 위탁영업활동을 수행한다. 프로그램 매매와 관련한 각종 보고서를 작성한다. 해외기관의 주문을 접수하고 체결한다. 해외현지법인활동을 지원한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","dJobECd":"0322","dJobECdNm":"[0322]증권 사무원","dJobJCd":"3204","dJobJCdNm":"[3204]증권 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001237:1', '{"dJobCd":"K000001237","dJobCdSeq":"1","dJobNm":"증권수탁사무원","workSum":"증권회사에서 고객의 의뢰에 따라 증권거래를 할 수 있도록 계좌를 개설하고 변경, 해지, 입출금의 업무를 수행한다.","doWork":"고객의 의뢰에 따라 신규거래에 필요한 서류가 구비되었는지를 확인하고 증권거래를 할 수 있도록 계좌를 개설하고 카드를 발급한다. 신규상품개설에 따른 상담을 하며 기존계좌에 추가상품을 연결한다. 카드분실 시 인감을 변경하고 변경처리를 한다. 반송사고계좌는 전화로 연락하여 확인 후 해지처리한다. 불원계좌(잔고거래내역통보 거부)는 만기일 한 달 전에 재신청하도록 통보한다. 미수·미납계좌를 확인·통보한다. 선물의 추가증거금 발생을 통보한다. 신용계좌의 개설이나 선물계좌의 개설도 담당한다. 미관리신규계좌(고액입금계좌)는 영업원에게 통보한다. 당일 지점에서 주문된 주문지를 걷어 보관한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"계산","workFunc2":"말하기신호","workFunc3":"단순작업","dJobECd":"0322","dJobECdNm":"[0322]증권 사무원","dJobJCd":"3204","dJobJCdNm":"[3204]증권 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006976:1', '{"dJobCd":"K000006976","dJobCdSeq":"1","dJobNm":"증권지점사무총괄사무원","workSum":"증권 관련 회사의 영업점에 근무하면서 유가증권거래에 관한 일을 처리하는 종사원들이 효율적으로 일할 수 있도록 조언하고 사무를 총괄하는 업무를 수행한다.","doWork":"유가증권거래에 관한 고객계좌부의 차변과 대변의 기재사항을 검토한다. 증권이 규정된 절차와 지시 또는 고객의 계좌부에 기입되어 있는 지시에 따라 수불 또는 인수되었는지를 확인한다. 신규계좌개설 혹은 변경, 사고변경 관련 신청서 등 각종 서류를 결재하고 관리한다. 지점의 인장을 관리하고 경비처리를 관리한다. 본사나 정부관계기관, 증권감독위원회, 증권거래소 등에서 보내온 문서를 접수하고 응답한다. 증권사무종사원들이 효율적으로 일할 수 있도록 조언한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"감독","workFunc3":"관련없음","dJobECd":"0322","dJobECdNm":"[0322]증권 사무원","dJobJCd":"3204","dJobJCdNm":"[3204]증권 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002444:1', '{"dJobCd":"K000002444","dJobCdSeq":"1","dJobNm":"채권상환사무원","workSum":"예탁된 채권 등 기타 유가증권에서 파생하는 권리행사를 대행하는 업무를 수행한다.","doWork":"예탁채권의 발행일 및 만기일자를 확인하고 관리한다. 발행주체, 이자지급방법, 상환기간, 보증담보 유무, 지급이자율 방식 등 채권의 종류에 따라 이자지급일 및 원리금 상환일 전에 채권의 종류와 이자소득금액을 확정한다. 원리금 지급일에 채권의 원천징수액 상당액을 차감한 금액을 해당 부서에서 지급되도록 의뢰한다. 원천징수세액을 세무서에 납부하고 납부세액에 대한 원천징수영수증을 각 예탁자에게 발송한다. 기타 예탁된 채권에서 파생하는 제반 권리행사를 대행한다. 채권 수익률예측, 채권교체 등 채권투자전략을 세워 투자자에게 제공하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"계산","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"채권권리행사사무원","dJobECd":"0322","dJobECdNm":"[0322]증권 사무원","dJobJCd":"3204","dJobJCdNm":"[3204]증권 사무원","dJobICd":"K649","dJobICdNm":"[K649]기타 금융업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006594:1', '{"dJobCd":"K000006594","dJobCdSeq":"1","dJobNm":"채권인수주선사무원","workSum":"자금조달을 필요로 하는 기업체를 대상으로 주간사의 권리를 획득하고 기업상황에 맞는 회사채의 발행을 인수주선하는 업무를 수행한다.","doWork":"정보네트워크를 이용하여 고객에게 가치 있는 정보(발행의향, 발행예정일, 재무상태, 경영상태 등)를 수집한다. 주간사 유치를 위해 고객과 교섭하고 당사를 통한 발행의 이점에 대해 공감할 수 있도록 설득하여 인수계약을 맺는다. 주간사권리를 획득하면 사채발행절차 및 실행내용을 협의한다. 법령상의 사채발행적격기준표에 따라 발행회사의 안정성, 수익성, 성장성, 활동성 및 기타 필요한 사항을 분석하고 만기, 이자율을 결정하며 채권에 대한 분석보고서를 작성한다. 발행회사가 유가증권신고서를 감독기관에 제출할 때 해당 유가증권분석보고서를 협회에 제출한다. 채권상장을 신청하고 청약을 받아 납입하고 발행실적을 보고한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"협의","workFunc3":"단순작업","dJobECd":"0322","dJobECdNm":"[0322]증권 사무원","dJobJCd":"3204","dJobJCdNm":"[3204]증권 사무원","dJobICd":"K641/K661","dJobICdNm":"[K641]은행 및 저축기관 / [K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002597:1', '{"dJobCd":"K000002597","dJobCdSeq":"1","dJobNm":"채권장외결제사무원","workSum":"기관투자자 간에 장외거래되는 대량의 채권거래를 증권예탁원의 전산시스템과 한국은행의 전산시스템의 연계를 통하여 증권과 대금이 동시결제되는 방식으로 결제처리하는 업무를 수행한다.","doWork":"채권거래 쌍방이 거래내역 및 결제방법을 전산시스템을 통하여 예탁원에 통보하면 매매내역의 일치 여부를 확인하여 고유한 결제번호를 부여한다. 매도기관의 예탁계좌에 매도증권의 잔량이 충분하면 결제대상 처분을 제한한다. 매기기관의 이체와 동시에 예탁원 당좌계좌를 경유하여 매도기관 당좌계좌로 이체하여 줄 것을 한국은행에 의뢰한다. 매수기관은 한국은행전산망을 통하여 결제대금 이체의뢰내역을 조회한 후 예탁원 당좌계좌로 결제대금을 이체신청한다. 한국은행에서 결제대금을 이체처리하면, 동 이체결과를 통보받음과 동시에 매도기관 예탁계좌에서 매수기관 예탁계좌로 증권을 계좌대체처리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"단순작업","dJobECd":"0322","dJobECdNm":"[0322]증권 사무원","dJobJCd":"3204","dJobJCdNm":"[3204]증권 사무원","dJobICd":"K641/K661","dJobICdNm":"[K641]은행 및 저축기관 / [K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005829:1', '{"dJobCd":"K000005829","dJobCdSeq":"1","dJobNm":"투자신탁설정원","workSum":"신탁기금의 신규 또는 추가설정을 위한 인·허가 및 관련 업무를 수행한다.","doWork":"신규로 설정할 신탁기금의 주요내용에 관한 자료를 작성하고 관련 기관과 사전협의를 한다. 신탁약관·신탁재산운용계획서 및 수익증권발행계획서를 작성하여 수탁회사와 협의를 거쳐 관계기관에 신탁약관승인신청서 및 수익증권발행인가서를 제출한다. 관계기관 승인을 받으면 수탁회사와 신탁약관에 의해 신탁계약을 체결하고 신탁금납입문서를 작성하여 수탁회사에 신탁금을 납입한다. 신탁기금의 추가설정을 위하여 자금조달가능 여부를 확인하고 투자신탁추가설정문서를 작성하여 수탁회사에 신탁금을 납입한다. 관련 부서 및 각 지점에 신규나 추가기금설정 통보를 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"단순작업","dJobECd":"0322","dJobECdNm":"[0322]증권 사무원","dJobJCd":"3204","dJobJCdNm":"[3204]증권 사무원","dJobICd":"K641/K661","dJobICdNm":"[K641]은행 및 저축기관 / [K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006813:1', '{"dJobCd":"K000006813","dJobCdSeq":"1","dJobNm":"해외증권사무원","workSum":"국내기업이 해외에서 발행하거나 해외기업이 국내에서 발행하는 주식예탁증서의 발행 및 관리업무를 담당하며, 주식과 주식예탁증서의 상호전환, 유·무상 증자 및 배당금, 의결권행사 등 각종 권리행사를 대행한다.","doWork":"국내기업의 해외DR(Depositary Receipts:주식예탁증서) 발행 시 해외예탁기관을 대신하여 DR원주를 수령하고 보관 및 관리한다. 투자자가 해외예탁기관에 신청한 DR의 주식전환신청내역을 투자자의 국내대리인과 확인 후 해당 주식을 교부하고 그 내역을 해외예탁기관에 통보한다. 투자자의 국내대리인으로부터 주식의 DR로의 전환신청을 받고 해당 DR이 교부되도록 해외예탁기관에 통보한다. 유·무상 증자, 합병, 분할, 배당, 의결권 행사 등 주식에서 파생되는 각종 권리에 대해 해외예탁기관을 대신하여 제반 권리를 행사한다. 채권자가 전환권을 행사하여 전환대리인인 증권예탁원에 전환을 신청하면 전환청구서를 접수하고 해당 채권이 소멸된 것을 확인한 후 발행회사 및 명의개서 대리인에게 전환청구를 확인한다. 국내기업이 발행한 해외BW(Bond with Warrant:신주인수권부사채)의 신주인수권 행사를 대리한다. 발행회사를 대신하여 CB(전환사채), BW, EB(Exchangeable Bonds:교환사채) 등의 원금상환 및 이자지급을 대행하며, 풋옵션(Put Option), 콜옵션(Call Option) 행사를 비롯하여 원리금을 지급해야 할 경우 발행회사와 원리금 지급내역을 상호확인 후, 발행회사로부터 대금을 수령하여 채권자에게 지급한다. 주식연계채권(CB, BW)의 권리행사(전환·행사 청구된 주식의 발행과 교부업무)를 대리하며, 해외 EB의 채권자가 교환을 청구하면 발행회사와 교환청구내역을 상호확인한 후 채권자의 대리인에게 교환대상 유가증권을 교부한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0322","dJobECdNm":"[0322]증권 사무원","dJobJCd":"3204","dJobJCdNm":"[3204]증권 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001379:1', '{"dJobCd":"K000001379","dJobCdSeq":"1","dJobNm":"해외증권영업사무원","workSum":"증권영업의 국제화 및 외국자본의 국내자본시장 유치를 위하여 국제 간 증권거래 관련 업무를 수행한다.","doWork":"국제 간 증권거래 유치를 위한 투자안내 및 투자정보자료를 작성·제공한다. 외국기관 및 외국인 투자자에 대한 영업활동을 수행한다. 외국인 고객의 계좌 개설 및 해지를 담당하고, 외국인 고객의 증권카드를 보관한다. 외국인 투자자를 위한 유가증권 및 선물옵션에 대한 위탁매매를 담당한다. 해외발행 유가증권의 매매 및 위탁매매를 수행한다. 외국인 투자자에 대한 상임대리인 계약의 체결 및 해지, 외국인 투자등록신청, 위탁증거금면제신청 등을 한다. 외국인을 위한 국내외 세미나 및 투자설명회를 개최한다. 내국인 대상의 해외증권 위탁매매 및 해외시장에서의 유가증권 위탁매매 영업을 수행한다. 국내 외국인회사의 국내자금조달을 주선하고 사채발행을 유도한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"국제증권영업사무원","dJobECd":"0322","dJobECdNm":"[0322]증권 사무원","dJobJCd":"3204","dJobJCdNm":"[3204]증권 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006670:1', '{"dJobCd":"K000006670","dJobCdSeq":"1","dJobNm":"환매조건부채권결제사무원","workSum":"채권매도(또는 매수) 시에 일정기간 후 일정가격으로 동일채권을 다시 매수(또는 매도)할 것을 조건으로 하는 환매조건부채권거래에 수반하는 결제, 매입채권평가 등 제반 관리업무를 처리한다.","doWork":"환매조건부채권 매도자와 매수자로부터 매매자료를 접수하여 결제자료를 확정한 후 증권과 대금의 동시결제에 의한 개시결제 처리한다. 담보증권의 시장가치를 평가하여 증거금이 초과 또는 부족할 시 증거금을 추가납부 또는 반환하도록 일일단위로 정산처리한다. 거래일방의 불이행 시 상대방의 안전한 권리확보를 보장하기 위하여 현예탁계좌와 분리, 독립된 별도의 환매조건부채권 전용계좌를 통해 증권을 관리한다. 거래당사자를 대신하여 거래조건의 관리, 조세처리 등의 사무를 처리한다. 거래기간이 만료되면 증권은 매도자가 대금은 매수자가 안전하게 확보할 수 있도록 동시결제에 의한 환매결제 처리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"기록","workFunc2":"말하기신호","workFunc3":"단순작업","similarNm":"RePo(RP)결제사무원","dJobECd":"0322","dJobECdNm":"[0322]증권 사무원","dJobJCd":"3204","dJobJCdNm":"[3204]증권 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005142:1', '{"dJobCd":"K000005142","dJobCdSeq":"1","dJobNm":"수금사무원","workSum":"고객이 사용한 가스, 수도, 전기 등의 사용요금의 수금 및 미납에 따른 제반 업무를 수행한다.","doWork":"고객의 사용요금에 대한 청구서를 교부한다. 고객이 납기 내에 요금을 납부하도록 독려한다. 착오분이 생기면 확인하여 환불한다. 수금이 지연된 고객에게 단기안내장을 배부하고, 일정기간이 지나면 관련 부서에 조치를 취한다. 미납고객을 관리하며, 이들이 의무를 이행토록 설득하고 경우에 따라 법적으로 대응한다. 미납된 요금을 납부한 고객에 대해 전기·전력 재공급업무를 처리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"계산","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"수금원","dJobECd":"0325","dJobECdNm":"[0325]수금원 및 신용 추심원","dJobJCd":"3205","dJobJCdNm":"[3205]수금원 및 신용 추심원","dJobICd":"D351/D352/E360","dJobICdNm":"[D351]전기업 / [D352]연료용 가스 제조 및 배관공급업 / [E360]수도업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006404:1', '{"dJobCd":"K000006404","dJobCdSeq":"1","dJobNm":"채권추심연락원","workSum":"채권환수를 위해 채무자에게 고지하고, 관련 서류를 발송한다.","doWork":"법인사업자나 개인사업자가 상법상의 업무에 종사하면서 미수채권이 발생하여 의뢰한 경우, 채무자에 대한 채무관 련 자료 및 신상 관련 자료를 송부받는다. 채무종류별, 채무금액별, 지역별, 성별, 사업자 및 비사업자 등으로 구분하여 분류하고 명단을 관리한다. 채무자에게 전화 및 서류로 관련 내용을 고지하여 채권을 환수한다. 경우에 따라서는 거주지를 방문하여 채무변제독촉을 하기도 한다. 지속적으로 채무자가 채무관계를 이행하지 않을 경우 관련 기관에 신용거래불량자로 조치하도록 통보한다. 전화를 받거나 걸기도 하며, 관련 서류를 보내거나 받기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"설득","workFunc3":"관련없음","similarNm":"채권환수연락원","dJobECd":"0325","dJobECdNm":"[0325]수금원 및 신용 추심원","dJobJCd":"3205","dJobJCdNm":"[3205]수금원 및 신용 추심원","dJobICd":"N759","dJobICdNm":"[N759]기타 사업지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003528:1', '{"dJobCd":"K000003528","dJobCdSeq":"1","dJobNm":"채권추심원","workSum":"은행, 종금사, 카드사, 신용정보기관 등에서 채권자의 위임을 받아 추심(채무자가 빚을 갚지 않을 경우 받아내는 일)과 관련한 업무를 담당한다.","doWork":"채무관계인에 대하여 유선으로 상환을 독촉하거나 상환독촉장을 발송한다. 채무관계인에 대하여 거주를 확인하고 추적한다. 위임채권에 대하여 채무관계인으로부터 변제를 촉구하고 변제금을 수령한다. 변제가 불가능할 경우 법적 조치를 취한다. 채권추심에 관한 활동일지를 작성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"설득","workFunc3":"관련없음","similarNm":"신용추심원, 채권회수원, 채권환수원","certLic":"신용관리사","dJobECd":"0325","dJobECdNm":"[0325]수금원 및 신용 추심원","dJobJCd":"3205","dJobJCdNm":"[3205]수금원 및 신용 추심원","dJobICd":"N759","dJobICdNm":"[N759]기타 사업지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003025:1', '{"dJobCd":"K000003025","dJobCdSeq":"1","dJobNm":"채권환수원","workSum":"채권환수를 위해 채무자의 은닉부동산과 같은 재산관계내역을 파악한다.","doWork":"채무자의 재산관계내역을 파악하여 채권환수업무를 추진한다. 합법적인 채권환수를 위하여 관할기관으로부터 이해관계사실확인서를 승인받아 채무자의 주민등록부열람, 호적부열람, 부동산공부열람을 통하여 은닉재산을 파악한다. 채무자가 기업일 경우 기업의 각종 신용거래정보나 신용능력정보(재무재표, 계열기업체 현황, 자본금, 사채발행현황)를 파악하며, 사주 및 관련 직원의 은닉자산 등에 대한 총체적인 파악을 실시한다. 직접 주변인물을 탐문하거나 호적등부 등을 열람하여 은닉자산 유무에 대해서 조사한다. 은닉자산이 있을 경우, 환수를 설득하고 설득이 되지 않으면 가압류, 가처분설정, 강제경매, 민사소송 등의 방법을 취하도록 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"설득","workFunc3":"관련없음","similarNm":"채권추심원, 채권회수원","dJobECd":"0325","dJobECdNm":"[0325]수금원 및 신용 추심원","dJobJCd":"3205","dJobJCdNm":"[3205]수금원 및 신용 추심원","dJobICd":"N759","dJobICdNm":"[N759]기타 사업지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007274:1', '{"dJobCd":"K000007274","dJobCdSeq":"1","dJobNm":"신용상담사","workSum":"신용문제 진단, 재무관리, 채무조정 상담서비스를 통해 채무불이행을 감소시키며 교육 및 상담 등을 통해 개인신용 문제 발생을 예방하고 개인신용문제의 재발생을 방지한다.","doWork":"신용상담을 준비하고 고객신용 관련 정보를 수집한다. 가계의 부채, 자산, 소득, 지출을 분석하여 신용문제 유형을 진단한다. 채무조정, 개인회생, 개인파산 절차를 상담한다. 개별 금융회사 채무조정제도, 정책금융을 안내하고 저금리 대체금융, 복지지원을 연계한다. 가계의 재무관리, 신용관리, 그리고 부채관리에 대한 이해를 높여 신용문제 발생을 사전에 방지하고 이미 발생한 신용문제에서 신속하게 벗어나도록 하되 신용문제가 다시 발생하지 않도록 교육 및 지도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","certLic":"신용상담사","dJobECd":"0329","dJobECdNm":"[0329]기타 금융 사무원","dJobJCd":"3209","dJobJCdNm":"[3209]기타 금융 사무원","dJobICd":"N759","dJobICdNm":"[N759]기타 사업지원 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005868:1', '{"dJobCd":"K000005868","dJobCdSeq":"1","dJobNm":"유가증권상장등록원","workSum":"유가증권의 상장(거래소시장)·등록(코스닥시장-협회중개시장)을 통한 기업의 원활한 자금조달창구를 제공하기 위하여 주권상장·등록(신규상장·등록, 신주상장·등록, 변경상장·등록, 재상장·등록) 및 채권상장·등록과 관련한 제반 업무를 수행한다.","doWork":"처음으로 주권을 상장하는 신규상장·등록, 유·무상증자, 주식예탁증서발행, 주식배당, 합병, 전환사채·신주인수권부사채의 권리행사 등으로 인한 신주상장·등록, 주권의 종목(상호), 종류(우선주, 보통주), 액면금액, 수량(자본감소, 병합 및 분할 등)을 변경으로 새로 주권을 상장하는 변경상장·등록, 그 외 재상장·등록을 위한 기초자료를 접수한다. 상장·등록 관련 이사회 등의 결의사항을 공시하고 자료를 검토한다. 기준가격을 결정하고, 발행주식 수의 변경사항 등을 통보한다. 주권문안을 등록하고 상장·등록을 기안하며 상장·등록승인의 통보와 매매가격의 게시 등 시장조치를 취한다. 상장·등록법인의 사업내용이 변경되는 경우 기 분류된 업종을 변경하고 또한 상장·등록법인의 신고사항(주주총회의 소집 및 의안안내, 주주명부의 폐쇄일 안내, 주주총회 결과 재무내용 등 공표, 대표이사, 본점소재지 변경안내, 중간배당 공표)에 대해 처리한다. 채권(국채, 지방채, 금융채, 특수채, 통안채, 회사채 등)의 상장·등록은 상장·등록신청서 또는 의뢰서, 첨부서류를 접수받고 발행조건을 검토한다. 채권종목에 따라 상장·등록금액조정, 상장·등록심사, 상장·등록수수료 및 연부과금 징수 등의 제반 업무를 수행하며, 채권코드를 부여하고 상장·등록입력을 한다. 채권변경상장·등록업무 및 비상장·비등록채권에 대한 코드부여업무도 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"상장 및 등록되는 상품의 종류에 따라 주권상장등록원, 채권상장등록원","dJobECd":"0329","dJobECdNm":"[0329]기타 금융 사무원","dJobJCd":"3209","dJobJCdNm":"[3209]기타 금융 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001622:1', '{"dJobCd":"K000001622","dJobCdSeq":"1","dJobNm":"유가증권상장폐지사무원","workSum":"상장(거래소시장)·등록(코스닥시장-협회중개시장)된 유가증권이 상장폐지·등록취소기준에 해당되어 매매거래 대상으로서의 적격성을 상실한 경우 투자자를 보호하기 위하여 상장폐지·등록취소업무를 수행한다.","doWork":"당해 법인으로부터 주주총회 상장폐지·등록취소결의문과 상장폐지·등록취소신청서를 접수한다. 주권이 상장폐지·등록취소기준에 해당하는 경우 상장·등록위원회의 심의를 하고 관련 기관에 폐지·취소 승인신청을 한다. 상장폐지·등록취소 승인이 나면 결정사항을 공표하고 정리매매를 하고 상장폐지 또는 등록을 취소한다. 채권이 상장폐지·등록취소기준에 해당되어 상장·등록의 의미를 상실하거나 전액 중도상환되는 경우 상장을 폐지하거나 등록을 취소하고 통보한 후 연부과금을 반환한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"유가증권등록취소사무원","connectJob":"폐지되는 상품의 종류에 따라 주권폐지원, 채권폐지원","dJobECd":"0329","dJobECdNm":"[0329]기타 금융 사무원","dJobJCd":"3209","dJobJCdNm":"[3209]기타 금융 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001849:1', '{"dJobCd":"K000001849","dJobCdSeq":"1","dJobNm":"유가증권시장운영원","workSum":"유가증권시장의 공정성과 효율성, 주식 및 채권의 원활한 매매체결을 위해 주식시장, 채권시장 운영과 관련한 제반 업무를 수행한다.","doWork":"투자자의 보호를 위해 현행 주식 및 채권시장 관련 규정이 제대로 적용되고 있는지 검토한다. 매매거래 중단과 관련한 내용을 접수받고 매매거래 중단 등의 시장조치를 취하며 중단내용을 공시한다. 대용증권의 지정이 적정한지 검증하고 대용증권의 가격을 산출하고 시장조치 후 지정내용을 공시한다. 또한 주식시장과 관련해서는 신주인수권 담보가 관련 조사 후 담보가를 산출하고 시장조치 후 담보가를 공시한다. 시세증명요청 시 자료를 산출 의뢰하여 회신한다. 시장대리인에 대한 등록신청을 접수하고 시장출입증을 발부하며 시장대리인의 등록취소 및 교육도 수행한다. 대량매매신고서, 종목별 자사주신청서 등을 접수하고 신고내용을 검증하며 호가입력 여부를 확인한다. 채권시장과 관련해서는 신용등급내용을 접수하고 등급수정 및 공시한다. 의무호가제출을 관리하며 장종료 후 매수호가 충족 여부를 확인한다. 전담사지정신청서 접수 및 전담사 의무이행 실적을 평가하며 전담사를 지정하고 통보한다. 주식 및 채권시장에서 착오매매가 있을 경우 발생사실을 확인하고 원인을 파악하여 정정처리한 후 손익을 정산한다. 시장운용개선안을 검토하고 시장 내 시설물을 적정배치하고 시설물을 유지 관리한다. 매매체결시스템의 정상가동 여부를 수시로 점검하고 장애발생 시 발생사실 보고 및 호가접수 중지 등의 시장조치를 취한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0329","dJobECdNm":"[0329]기타 금융 사무원","dJobJCd":"3209","dJobJCdNm":"[3209]기타 금융 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004020:1', '{"dJobCd":"K000004020","dJobCdSeq":"1","dJobNm":"증권거래감리원","workSum":"유가증권시장에서 불공정거래를 조사하기 위하여 주식 및 선물옵션에 대한 감리를 실시한다.","doWork":"효율적인 증권시장을 구현하고 공정성, 투명성을 유지하고자 시장관리상 혹은 이상매매 혐의가 있다고 추정되는 경우에 감리를 실시한다. 증권거래감시원의 조회공시 및 추적조사의뢰에 따라 감리대상 및 방향을 설정한다. 비정상적인 거래상황 및 이상매매종목에 대해 추적조사를 실시한다. 주가 및 거래량이 정상적인 범위를 벗어나 불공정거래의 개연성이 높은 종목, 이상호가 종목, 풍문이나 보도가 있는 종목, 이상매매적출기준을 벗어나는 종목에 대하여 당해상장(거래소시장)·등록(코스닥시장-협회중개시장) 법인에 조회·공시한다. 매매자료를 정밀분석하고 감리자료를 징구하고 매매를 심리한다. 결과보고서를 작성하고 감리협의회의 회의 안건으로 올린다. 법령을 위반한 경우 금감위에 조사를 의뢰하거나 직접 조치를 취하는 등 결과를 처리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"감독","workFunc3":"관련없음","connectJob":"주식감리사무원, 선물옵션감리사무원","dJobECd":"0329","dJobECdNm":"[0329]기타 금융 사무원","dJobJCd":"3209","dJobJCdNm":"[3209]기타 금융 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005644:1', '{"dJobCd":"K000005644","dJobCdSeq":"1","dJobNm":"증권사투자은행법률자문역","workSum":"증권사에서 IB(Investment Bank)업무의 법률자문을 전문적으로 수행한다.","doWork":"IB(Investment Bank), 기업공개(IPO), 증자, 회사채 발행, 구조화금융(Structured Finance), 인수합병(M&A) 등을 주관하고 자문한다. 관련 계약서 등 모든 법률문서를 검토하고 자문하여 법률적 위험을 배제한다. IB업무에 사용되는 인장을 관리하고 날인한다. IB업무에 관련된 법률환경 변화를 모니터링한다. 대내외 정보보안등급을 지정하고 관리한다. 신규IB업무를 제안 및 기획한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","similarNm":"IB법률자문가","certLic":"변호사","dJobECd":"0329","dJobECdNm":"[0329]기타 금융 사무원","dJobJCd":"3209","dJobJCdNm":"[3209]기타 금융 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002136:1', '{"dJobCd":"K000002136","dJobCdSeq":"1","dJobNm":"증권상장심사원","workSum":"한국거래소에 소속되어 증권의 신규상장심사 및 주권의 재상장심사 관련 업무를 수행한다.","doWork":"증권의 신규상장심사 관련 서류를 검토하고 심사한다. 주권의 재상장심사 서류를 검토하고 심사한다. 증권의 상장요건, 절차, 폐지기준 관련 업무를 수행한다. 유가증권시장상장 및 공시위원회의 운영에 관련된 업무를 수행한다. 국내 비상장기업 및 해외기업의 상장유치에 관련된 업무를 수행한다. 증권의 상장안내 및 상담을 한다. 신규상장수수료를 산정한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0329","dJobECdNm":"[0329]기타 금융 사무원","dJobJCd":"3209","dJobJCdNm":"[3209]기타 금융 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007286:1', '{"dJobCd":"K000007286","dJobCdSeq":"1","dJobNm":"증권시장운영원","workSum":"한국거래소에 소속되어 주식시장 운영의 제반 업무를 수행한다.","doWork":"유가증권시장의 개폐, 정지 및 휴장업무를 수행한다. 증권 매매제도에 따라 증권의 매매체결 및 시세공표, 착오매매 정정, 경매업무를 수행한다. 유가증권시장의 조치(유가증권의 공정한 가격형성과 급격한 시세변동에 따른 투자자의 손실을 방지하기 위한 조치로서 배당, 유무상 증자에 대한 권리락 가격형성조치, 예납조치, 관리 및 감리종목 지정, 매매거래 정지 및 해제, 위탁증거금률 조정 등)에 대한 업무를 수행한다. 대용증권(증권매매거래에서 금전 대신에 위탁증거금 등으로 납입할 수 있는 유가증권) 지정 및 대용가격산정업무를 수행한다. 증권의 매매중단 및 시장조치업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0329","dJobECdNm":"[0329]기타 금융 사무원","dJobJCd":"3209","dJobJCdNm":"[3209]기타 금융 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007081:1', '{"dJobCd":"K000007081","dJobCdSeq":"1","dJobNm":"증권일반사무수탁사무원","workSum":"증권투자회사 등과의 위탁계약에 따라 수행하는 계산에 관한 사무, 증권투자회사의 운영에 관한 사무 등을 수행한다.","doWork":"증권투자회사의 설립, 금감위 등록 및 청산사무, 판매회사, 자사보관회사 등에 수수료 지급 및 제경비 지급업무, 이사회 및 주주총회의 소집에 관한 업무, 증권투자회사의 이사 및 감사의 업무수행의 보조 등을 담당한다. 증권투자회사 운용자산의 순자산가치(NAV:Net Asset Value) 및 신주발행가액의 산정, 대차대조표 및 손익계산서, 자산운용보고서, 금전배분계산서 등을 작성하여 제출한다. 증권투자회사의 매분기의 영업보고서 및 매년도의 사업보고서를 작성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0329","dJobECdNm":"[0329]기타 금융 사무원","dJobJCd":"3209","dJobJCdNm":"[3209]기타 금융 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006731:1', '{"dJobCd":"K000006731","dJobCdSeq":"1","dJobNm":"지로고객관리원","workSum":"각종 지로거래와 특수장표의 이용안내 및 승인, 지로업무 관련 조회 응답 등 지로이용고객 관련 업무를 수행한다.","doWork":"금융결제원 업무로서, 장표지로에 의해 자금을 수납하고자 하는 기관의 이용신청이 있을 경우, 거래신청서 및 구비서류를 접수하여 승인요건에 적합한지 확인한다. 요건에 적합할 경우 결재권자의 결재를 얻은 다음 승인결과를 전산등록하고 신청기관에 승인통지한다. 승인을 얻은 기관으로부터 사용장 견본을 넘겨받아 테스트하여 이상 유무를 점검한다. 전자지로에 의해 자금을 수납하거나 배금하고자 하는 기관의 이용신청이 있을 경우, 이용방법 및 요건 등을 안내하고 이용매체 작성의 적합성을 테스트한다. 테스트 결과 이상이 없을 경우 거래신청서 및 구비서류를 접수하여 승인요건에 적합한지 확인한다. 요건에 적합할 경우 승인결과를 전산등록하고 신청기관에 승인통지한다. 거래내용 변경 및 취소 등의 사항도 점검처리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"서비스제공","workFunc3":"관련없음","dJobECd":"0329","dJobECdNm":"[0329]기타 금융 사무원","dJobJCd":"3209","dJobJCdNm":"[3209]기타 금융 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001784:1', '{"dJobCd":"K000001784","dJobCdSeq":"1","dJobNm":"지로자료처리원","workSum":"지로 관련 자료의 접수, 전산처리 및 정정·집계, 결제자료 작성 등 지로자료처리에 관한 업무를 수행한다.","doWork":"금융결제원 업무로서, 장표지로의 수납은행이나 전자지로의 이체의뢰기관 및 은행이 지로센터에 지로 관련 자료를 제출하면 제출된 지로자료를 접수하고 이상 유무를 확인한다. 접수한 장표지로는 전산처리에 적합하도록 스테이플이나 이물질 등을 제거한다. 접수된 장표 및 전자지로자료를 지로처리시스템에 전산처리하거나 입력하여 계수 및 고객번호 등 정상처리확인자료를 작성·확인한다. 확인결과 착오처리되었거나 오류가 발생된 내역은 원시접수지로자료와 대조하고 해당 은행(또는 이체의뢰기관)과 협조하여 정정처리한 다음 지로차액결제자료 등 처리결과자료를 작성한다. 지로차액결제자료는 한국은행으로 보내 각 은행별 차감액을 청산하도록 한다. 기타 지로처리결과자료는 은행, 전자지로 이체의뢰기관, 장표지로 수납기관에 우편 또는 송달망을 통하여 발송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0329","dJobECdNm":"[0329]기타 금융 사무원","dJobJCd":"3209","dJobJCdNm":"[3209]기타 금융 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003780:1', '{"dJobCd":"K000003780","dJobCdSeq":"1","dJobNm":"지로제도기획원","workSum":"지로업무에 관한 사업추진계획을 수립하고 제규약을 정비하며 지로업무 이용촉진, 지로운영위원회 운영, 지로회비 산출 등 지로업무 전반에 걸친 기획업무를 수행한다.","doWork":"금융결제원 업무로서, 지로업무 관련 사업추진계획을 수립한다. 지로제도 개선사항을 검토하여 처리절차를 개선한다. 제규약 및 약관에 반영하고 지로제도 관련 업무질의나 민원사항을 접수·검토·회신한다. 지로업무 이용촉진 및 활성화를 위하여 지로업무 관련 홍보, 이용지역 및 수수료 조정, 이용기관 확대 등을 추진한다. 지로운영위원회의 회의개최, 위원교체 등과 관련된 사항을 준비하며 지로회비산출이나 지로통계자료의 대내외 활용을 위해 지로처리와 관련된 통계자료를 수집·분석한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0329","dJobECdNm":"[0329]기타 금융 사무원","dJobJCd":"3209","dJobJCdNm":"[3209]기타 금융 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005580:1', '{"dJobCd":"K000005580","dJobCdSeq":"1","dJobNm":"채권시장운영원","workSum":"한국거래소에 소속되어 채권시장 운영의 제반 업무를 수행한다.","doWork":"채무증권의 매매(환매조건부채권매매)의 상장 및 공시제도에 관한 업무를 수행한다. 채무증권의 매매체결 및 시세공표업무, 채무증권 경매업무, 채무증권시황 관련 업무, 채무증권 관리업무, 채무증권 상장수수료 및 연부과금 관련 업무, 채무증권 매매의 중단 관련 업무, 채무증권 대용증권 지정 및 대용가격 산정업무, 증권의 표준코드 관리업무, 채무증권상장법인의 기업내용공시 관련 업무, 채권지수 관리업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0329","dJobECdNm":"[0329]기타 금융 사무원","dJobJCd":"3209","dJobJCdNm":"[3209]기타 금융 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006728:1', '{"dJobCd":"K000006728","dJobCdSeq":"1","dJobNm":"카드론사무원","workSum":"신용카드 회원의 결제계좌에 카드론 약정금액만큼 한도를 부여해 수시로 인출 및 상환이 가능토록 제반 업무를 수행한다.","doWork":"신용카드 회원으로부터 카드론(카드대출) 요청 시에는 회원의 카드이용대금연체, 기존여신연체, 이용실적 등 고객신용도의 등급을 고려하여 대상 여부를 확인한다. 융자대상자 여부, 카드론 한도산출 여부, 채권보전방안, 금리 등을 감안하여 융자 여부를 결정한다. 카드론신청서, 연대보증인자격증빙서류 등 제반 서류를 청구하고 서류상의 대출자격을 심사·확인한다. 채권약정을 체결하고 한도약정등록 및 확인을 한다. 대출기간을 연장할 경우에는 적정성을 검토한 후 기간연장을 처리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"서비스제공","workFunc3":"관련없음","dJobECd":"0329","dJobECdNm":"[0329]기타 금융 사무원","dJobJCd":"3209","dJobJCdNm":"[3209]기타 금융 사무원","dJobICd":"K649","dJobICdNm":"[K649]기타 금융업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001327:1', '{"dJobCd":"K000001327","dJobCdSeq":"1","dJobNm":"카드발급사무원","workSum":"신용카드를 발급하고, 지점이나 개인에게 송달하는 업무를 수행한다.","doWork":"자동카드발급기를 이용하여 신용카드 회원의 성명, 회원번호, 유효기간 등의 세부사항을 확인하여 발급한다. 발급된 신용카드가 고객이 신청한 신용카드 종류와 동일한지를 확인한다. 발급된 신용카드에 부합하는 마케팅전단지 및 첨부서류 등을 갖추어 봉투에 넣는다. 발급된 신용카드를 인수받아 지역 및 지점별로 분류한다. 등기우편물발송의뢰서를 작성하여 전문송달업체에 송달한다. 발송건수를 기록·보관한다. 전문송달업체의 송달결과를 통보받아 기록·보관한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0329","dJobECdNm":"[0329]기타 금융 사무원","dJobJCd":"3209","dJobJCdNm":"[3209]기타 금융 사무원","dJobICd":"K649","dJobICdNm":"[K649]기타 금융업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001969:1', '{"dJobCd":"K000001969","dJobCdSeq":"1","dJobNm":"카드신청서심사사무원","workSum":"각 지점에서 보내온 가맹점가입신청서 및 카드발급신청서를 접수하고 회원자격을 심사하여 발급을 위한 기재사항을 전산으로 입력한다.","doWork":"가맹점가입신청서 및 카드발급신청서를 접수하여 기재하지 않은 사항이나 준비가 덜 된 사항을 점검하고 회원자격을 심사한다. 입회원장에 등록하고 신청인의 자격에 적합한 한도를 부여한다. 신용불량거래자, 타 금융권 연체현황 등을 전산으로 확인한다. 가맹점 신청의 경우는 점포의 자본금, 연간매출액, 종업원 수, 당기순이익 등을 검토하여 가맹점 승인기준에 적합한지 심사한다. 신청인과 직접 통화하여 신청내역을 확인하고 신용카드 발급을 최종 검수한다. 교체발급 및 회원등급변경신청서에 대한 신청서를 접수하여 회원등급을 구분·심사한다. 카드발급을 위한 제반 기재사항을 전산으로 입력한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0329","dJobECdNm":"[0329]기타 금융 사무원","dJobJCd":"3209","dJobJCdNm":"[3209]기타 금융 사무원","dJobICd":"K649","dJobICdNm":"[K649]기타 금융업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002615:1', '{"dJobCd":"K000002615","dJobCdSeq":"1","dJobNm":"카드정산사무원","workSum":"신용카드 가맹점의 이중청구 및 매출전표 관련하여 오류사항에 대한 정산업무를 수행한다.","doWork":"계약 체결된 가맹점에 대하여 정기적으로 기 계약내용 및 변경된 계약내용을 고지한다. 전표접수대행 등의 서비스업무를 수행한다. 이중청구사항에 관한 자료를 접수하여 이중청구 여부를 확인하고, 가맹점과 연락하여 가지급금으로 정리하며 관계장부를 정리한다. 매출전표 심사과정에서 확인된 불비전표를 해당 점포로 반송하고 반송매출전표수령증을 해당점에 청구하여 보관·관리한다. 가맹점 및 협력점의 카드한도대출 등 불법영업행위를 정기적으로 조사·확인하며, 불법영업행위 적발 시 계약을 해지하고 해당 기관에 통보하여 법적 제재를 요청한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0329","dJobECdNm":"[0329]기타 금융 사무원","dJobJCd":"3209","dJobJCdNm":"[3209]기타 금융 사무원","dJobICd":"K649","dJobICdNm":"[K649]기타 금융업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001747:1', '{"dJobCd":"K000001747","dJobCdSeq":"1","dJobNm":"카드제휴영업사무원","workSum":"신용카드 등의 카드와 서비스를 연계할 수 있는 제휴업체를 발굴하여 다기능 카드를 개발할 수 있도록 영업활동을 한다.","doWork":"신규 틈새시장의 제휴업체를 개발하여 제휴조건 및 공동마케팅 운영에 관해 협의한다. 제휴해당업체와 제휴약정을 체결하고 제휴카드 회원 수 및 취급고를 관리한다. 기존 업무처리지침을 변경할 경우 이를 준비한다. 제휴업체와 카드이용 관련 유지업무를 수행한다. 카드의 브랜드관리업무를 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"설득","workFunc3":"관련없음","dJobECd":"0329","dJobECdNm":"[0329]기타 금융 사무원","dJobJCd":"3209","dJobJCdNm":"[3209]기타 금융 사무원","dJobICd":"K649","dJobICdNm":"[K649]기타 금융업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005664:1', '{"dJobCd":"K000005664","dJobCdSeq":"1","dJobNm":"카드판촉사무원","workSum":"신용카드 등 각종 카드의 판촉자료를 수집·분석하여 업무추진목표를 세우고 각종 서비스를 제공하기 위한 제반 업무를 기획·총괄한다.","doWork":"개인회원, 기업회원, 가명점에 관한 대내외 정보를 수집·분석하여 달성할 지표를 설정한다. 각 지점의 특성을 고려하여 달성할 목표를 정하고 달성율을 분석하여 영업점의 업적을 평가한다. 목표달성을 추진하는 중 발생하는 문제점이나 원인을 분석하여 제도개선에 반영한다. 지역별 신규업체를 발굴하는 등 회원유치를 위한 활동을 지원한다. 제반 서비스 개선을 위한 사항을 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0329","dJobECdNm":"[0329]기타 금융 사무원","dJobJCd":"3209","dJobJCdNm":"[3209]기타 금융 사무원","dJobICd":"K649","dJobICdNm":"[K649]기타 금융업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001887:1', '{"dJobCd":"K000001887","dJobCdSeq":"1","dJobNm":"카드회원사후관리원","workSum":"신용카드회원의 사후관리를 위하여 연체자·한도초과자 관리, 반송우편물처리, 이용대금 회수업무를 수행한다.","doWork":"신용카드회원의 사후관리를 위하여 회원의 사용내역, 연체내역, 한도대출초과내역, 현금서비스 사용내역, 카드론내역 등의 연체정도에 따라 적절하게 채권의 순위를 정한다. 전산에서 추출된 명세표에 따라 거래정지카드일람표, 연체상황 등의 필요자료를 대조하여 결제대금지급 여부를 결정하고, 지급이 결정된 매출전표나 현금서비스신청서는 전산에 입력한다. 카드결제대금미납, 현금서비스대금미납 등 거래정지 기준에 따라 회원자료를 추출하여 거래정지 여부를 심사하여 결정한다. 전산에서 출력된 명세서에 따라 한도초과안내장을 발송하고 기준에 따라 거래정지한다. 각 지점에서 연체대금을 전금(선금) 받고, 회원 이용대금 및 연체내역을 받아 대조·확인 후 관련 부서에 수정 의뢰한다. 한도초과승인요청을 받으면 단말기로 조회하여 승인 여부 및 승인번호를 부여한다. 승인내용을 승인대장프로그램에 기록하고 가맹점에 승인·통보한다. 회원의 거주지변경, 연락처변경, 지정은행 및 계좌변경 등의 사후관리를 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"수동조작","dJobECd":"0329","dJobECdNm":"[0329]기타 금융 사무원","dJobJCd":"3209","dJobJCdNm":"[3209]기타 금융 사무원","dJobICd":"K649","dJobICdNm":"[K649]기타 금융업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006569:1', '{"dJobCd":"K000006569","dJobCdSeq":"1","dJobNm":"코스닥시장운영원","workSum":"한국거래소에 소속되어 코스닥시장 운영의 제반 업무를 수행한다.","doWork":"KSDAQ(Korea Securities Dealers Automated Quotation:전자거래시스템으로 운영되는 한국의 장외주식거래시장) 시장의 증권(주식 및 수익증권) 매매제도에 관한 업무를 수행한다. 증권의 매매체결 및 시세공표, 착오매매의 정정업무를 수행한다. 코스닥시장의 시황분석 및 중장기동향을 분석한다. 코스닥시장의 개폐, 정지 및 휴장에 관련된 업무를 수행한다. 대용증권의 지정 및 대용가격 산정에 관련된 업무를 수행한다. 증권의 매매중단에 관한 업무를 수행한다. 프로그램 매매거래의 보고접수 및 공표업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0329","dJobECdNm":"[0329]기타 금융 사무원","dJobJCd":"3209","dJobJCdNm":"[3209]기타 금융 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003339:1', '{"dJobCd":"K000003339","dJobCdSeq":"1","dJobNm":"파생상품시장운영원","workSum":"한국거래소에 소속되어 파생상품시장 운영의 제반 업무를 수행한다.","doWork":"파생상품시장의 개폐, 정지 및 휴장 관련 업무를 수행한다. 파생상품의 매매체결 및 시세공표업무, 파생상품의 착오매매의 정정업무, 파생상품거래의 중단 등 시장조치에 관한 업무를 수행한다. 파생상품시황 및 국내외 파생상품시장 동향을 분석한다. 해외거래소와의 파생상품 연계거래시장 운영업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"선물옵션시장운영원","dJobECd":"0329","dJobECdNm":"[0329]기타 금융 사무원","dJobJCd":"3209","dJobJCdNm":"[3209]기타 금융 사무원","dJobICd":"K641/K661","dJobICdNm":"[K641]은행 및 저축기관 / [K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002281:1', '{"dJobCd":"K000002281","dJobCdSeq":"1","dJobNm":"한국거래소시장감시원","workSum":"한국거래소에 소속되어 시장감시업무를 수행한다.","doWork":"시장감시 관련 제도, 시장감시시스템, 분쟁조정제도, 시장감시위원회의 업무 및 기준을 숙지한다. 시장의 상황에 따라 예방조치 요구, 시장경보제도 등 불공정거래 예방활동을 진행한다. 한국거래소 회원사의 불공정거래를 모니터링한다. 사이버 불공정거래를 감시한다. 불공정거래로 인한 피해투자자의 소송 등을 지원한다. 안정조작 및 시장조성을 감시한다. 내부자의 자기주식위탁매매, 상장법인의 임원 등의 특정증권 소유상황, 상장법인의 주식 등의 대량보유 등을 확인하고 보고한다. 상장법인의 풍문을 수집하고 분석한다. 분쟁이 발생하면 분쟁신청 접수 및 사실조사, 분쟁조정심의위원회의 운영, 합의권고 등 분쟁 관련 업무를 수행한다. 분쟁 관련 고객상담, 법률상담을 지원한다. 불공정거래 신고 및 포상제도를 운영한다. 투자 유의제도를 운영한다. 심리를 전문으로 하는 경우, 이상거래 혐의종목을 심리하고 심리결과에 따른 조치를 취하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0329","dJobECdNm":"[0329]기타 금융 사무원","dJobJCd":"3209","dJobJCdNm":"[3209]기타 금융 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006988:1', '{"dJobCd":"K000006988","dJobCdSeq":"1","dJobNm":"한국거래소청산결제사무원","workSum":"한국거래소에 소속되어 증권시장, 파생상품시장의 청산·결제업무를 수행한다.","doWork":"증권시장, 파생상품시장, 채권시장의 청산·결제제도 및 운영기준을 숙지한다. 파생상품 미결제약정의 관리업무, 파생상품시장의 일일정산업무, 결제 및 증거금관리업무, 손해배상공동기금 및 결제적립금 관련 업무, 증거금률 조정 및 청산·결제에 관련된 시장조치업무, 청산결제위원회의 운영업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0329","dJobECdNm":"[0329]기타 금융 사무원","dJobJCd":"3209","dJobJCdNm":"[3209]기타 금융 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005445:1', '{"dJobCd":"K000005445","dJobCdSeq":"1","dJobNm":"무형재산권관리원","workSum":"소설, 논문, 음악, 연극, 미술, 건축설계도서, 사진, 영상, 지도, 컴퓨터프로그램 등에 관한 저작권 및 특허권, 상표권 등의 무형재산권을 무형재산권자로부터 위탁받아 관리하고, 이를 제3의 이용자에게 중개, 계약체결, 임대료 징수 등의 업무를 수행한다.","doWork":"소설, 논문, 음악, 연극, 미술, 건축설계도서, 사진, 영상, 지도, 컴퓨터프로그램 등에 관한 저작권 및 특허권, 상표권 등의 무형재산권을 무형재산권자로부터 신탁 의뢰를 받아 신탁계약을 체결한다. 위탁받은 무형재산권의 리스트를 정리하고, 기존의 합법적 이용 현황을 조사한다. 무형재산권 이용희망자로부터 이용신청을 받으면, 이용허락 계약을 체결하고, 이용료를 징수한다. 이용자가 계약에 명시된 이용 분야, 이용 기간, 이용 분량, 이용 형태대로 이용하고 있는지를 조사확인한다. 위탁받은 무형재산권에 대한 불법이용 실태를 조사하거나 신고를 접수받아 불법이용자에게 손해배상을 청구한다. 합법적 이용자의 이용료와 불법이용에 따른 손해배상금을 무형재산권자에게 지급한다. 그 밖에 합법적 무형재산권 이용에 관한 홍보를 하고, 무형재산권에 관한 법률상담을 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"협의","workFunc3":"관련없음","similarNm":"무형재산권위탁관리자","connectJob":"지적재산권임대관리자, 저작권위탁관리자","certLic":"소프트웨어자산관리사(C-SAM)","dJobECd":"2220","dJobECdNm":"[2220]법률 사무원","dJobJCd":"3301","dJobJCdNm":"[3301]법률 관련 사무원","dJobICd":"K649","dJobICdNm":"[K649]기타 금융업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006640:1', '{"dJobCd":"K000006640","dJobCdSeq":"1","dJobNm":"법무사무원","workSum":"법무사의 지휘하에 사법기관에 제출한 서류를 소정 양식에 따라 작성하고 이를 제출하는 등 법무사의 업무를 지원한다.","doWork":"소유권이전등기, 가압류, 가처분 등 법무 관련 업무에 관련된 서류의 구비상태를 점검하고 세금 및 각종 비용을 계산한다. 법률에 의거하여 서류를 작성하고 관련 기관에 제출한다. 권리증 등 관련 서류를 관련 기관에서 회수한다. 의뢰인 또는 법률대리인과 협의하고 상담한다. 사건에 관한 법조문이나 판례를 찾고 분석한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"법무사사무원, 법률사무원","connectJob":"법무사사무장","dJobECd":"2220","dJobECdNm":"[2220]법률 사무원","dJobJCd":"3301","dJobJCdNm":"[3301]법률 관련 사무원","dJobICd":"M711","dJobICdNm":"[M711]법무관련 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003841:1', '{"dJobCd":"K000003841","dJobCdSeq":"1","dJobNm":"변호사사무원","workSum":"변호사의 지휘하에 소송사건, 비송사건 및 일반법률 사건의 자료를 수집, 조사, 분석하고 관련 서류를 작성하는 등 변호사의 업무를 지원한다.","doWork":"소송행위, 재판상 또는 재판 외의 화해, 소의 취하, 청구의 포기와 인낙, 대리인의 선임 및 각종 법률업무에 관련하여 자료를 수집한다. 법조문이나 판례 등을 조사하고 분석한다. 소송에 관련된 각종 법률서류를 작성한다. 재판에 따른 기록을 작성하고 검찰청과 법원에 각종 소송서류를 접수한다. 소송의 진행상황을 확인하고 의뢰받은 업무에 대한 수수료를 계산한다. 법률과 관련하여 의뢰인과 상담하여 법률 관련 정보를 제공한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"법률사무원","connectJob":"변호사사무장","dJobECd":"2220","dJobECdNm":"[2220]법률 사무원","dJobJCd":"3301","dJobJCdNm":"[3301]법률 관련 사무원","dJobICd":"M711","dJobICdNm":"[M711]법무관련 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007311:1', '{"dJobCd":"K000007311","dJobCdSeq":"1","dJobNm":"석유화학지식재산권관리자","workSum":"석유화학 관련 지식재산권의 법적 권리에 대한 기업의 이익을 극대화하기 위하여 지식재산권을 조사·분석하여 전략을 수립하고, 지식재산권의 출원 및 등록과 지식재산권관련 분쟁 발생 시 대응하는 업무를 수행한다.","doWork":"석유화학 관련 기술을 파악하고 검색범위를 설정하여 키워드를 추출하고 검색식을 수립하여 유사기술을 분석한다. 선행기술조사와 선행기술보고서를 작성하여 지식재산권의 가능성을 평가한다. 선행기술보고서와 지식재산권 평가서를 바탕으로 국내 및 해외에 지식재산권을 출원한다. 특허출원서를 작성하여 특허등록을 수행하며, 특허 관련 담당자의 업무를 감독한다. 미래시장 및 환경 분석을 통해 핵심·원천특허를 발굴하고, 특허 및 지식재산권 전략을 수립한다. 지식재산권 분쟁 발생 시 대응하며 지식재산권을 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"2220","dJobECdNm":"[2220]법률 사무원","dJobJCd":"3301","dJobJCdNm":"[3301]법률 관련 사무원","dJobICd":"C201/M","dJobICdNm":"[C201]기초 화학물질 제조업 / [M]전문, 과학 및 기술 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004959:1', '{"dJobCd":"K000004959","dJobCdSeq":"1","dJobNm":"소송사무원","workSum":"소송업무에 따른 소송승인 신청서나 보고서를 처리하는 업무와 경우에 따라서는 소송을 대리하기도 한다.","doWork":"각 지점으로부터 미 회수된 대여금 및 대출금의 채권추심소송을 위한 소송대리인 승인신청서를 접수한다. 소송의 타당성 여부나 소송대리인 보수지급 기준의 부합 여부 등을 검토한다. 소송의 타당성 여부가 결정되면 업체개요, 소송대상물의 내용, 제소의 필요성, 소송대리인 보수 산출 근거 등을 내용으로 하는 승인시안을 작성한다. 승인서를 관할 지점에 발송하고 서류는 편철보관한다. 지점으로부터 법적절차 대행요청서를 접수하여 관할 법원의 적부, 신청서류 완비 여부를 검토한다. 법무사무소나 변호사사무소에 위탁하여 신청서의 작성을 의뢰하고 확인한다. 소액재판 등 경우에 따라서는 직접 고소장을 관할 법원에 접수하고 경우에 따라서는 소송재판에 출두하여 소송을 대리하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"설득","workFunc3":"관련없음","dJobECd":"2220","dJobECdNm":"[2220]법률 사무원","dJobJCd":"3301","dJobJCdNm":"[3301]법률 관련 사무원","dJobICd":"K64/K649/K661","dJobICdNm":"[K64]금융업 / [K649]기타 금융업 / [K661]금융 지원 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003965:1', '{"dJobCd":"K000003965","dJobCdSeq":"1","dJobNm":"음반저작권관리사무원","workSum":"자사의 국내외 음반 및 비디오물의 저작권 및 가수의 보호 등에 관한 제반 사무관리 업무를 수행한다.","doWork":"자사가 소유권을 가진 국내외 음반에 대한 저작권을 보호하기 위하여 계약, 유지 및 침해에 대한 사항을 관리한다. 침해 여부를 확인하기 위하여 자료를 수집·검토하고, 침해사항에 대한 적절한 법적 대응을 변호사와 협의한다. 국내외 음반 및 가수 등을 홍보하기 위한 행정처리를 수행한다. 자사 소속의 가수의 관리를 위하여 인적관리 및 계약서관리 등을 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"2220","dJobECdNm":"[2220]법률 사무원","dJobJCd":"3301","dJobJCdNm":"[3301]법률 관련 사무원","dJobICd":"J592","dJobICdNm":"[J592]오디오물 출판 및 원판 녹음업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007746:1', '{"dJobCd":"K000007746","dJobCdSeq":"1","dJobNm":"음악저작권관리사무원","workSum":"회원사 및 창작자를 대리하여 저작권 계약, 징수, 분배, 저작권 침해 감시, 저작물 등록 및 관리 등 제반 사무관리 업무를 수행한다.","doWork":"국내외 음악 저작물을 등록하고 관리한다. 저작권 관련하여 국내외 관련 기관이나 단체, 창작자와 계약을 체결하고 계약정보를 관리한다. 저작권료를 징수하고 정산하여 관련 협회, 기관, 창작자에게 분배한다. 저작권 사용 요청을 검토하고 허가한다. 저작권 침해 여부를 확인하기 위하여 자료를 수집·검토하고 침해사항에 대한 법적 대응을 위해 법률전문가와 협업한다. 저작권 계약, 징수 등과 관련하여 홍보, 교육, 계도 등의 업무를 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"2220","dJobECdNm":"[2220]법률 사무원","dJobJCd":"3301","dJobJCdNm":"[3301]법률 관련 사무원","dJobICd":"S941/S949","dJobICdNm":"[S941]산업 및 전문가 단체 / [S949]기타 협회 및 단체","inqYear":"2025"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006178:1', '{"dJobCd":"K000006178","dJobCdSeq":"1","dJobNm":"저작권관리원","workSum":"라디오, 텔레비전, 영화제작 등에 사용되는 음악, 원작소설 등의 저작권을 조사·관리한다.","doWork":"출판물, 방송제작, 영화제작, 드라마제작 등에 어떤 저작물이 이용되는지 확인한다. 저작물이 저작권법에 의해 보호받고 있는지, 저작물의 이용방식이 저작권법상 문제가 없는지 확인한다. 저작권자(원작소설의 작가, 음악작품의 작곡가, 저작물의 저작자 등)를 조사하여 저작권의 사용을 알리고 이용하려는 방법에 대해 협의한다. 저작권료를 조정한다. 저작물의 이용이 저작권자에게 허락받은 범위를 벗어나지 않았는지 검토한다. 원작이나 음악의 무단사용에 따른 저작권 분쟁을 협의하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"협의","workFunc3":"관련없음","similarNm":"저작권관리사","connectJob":"음악저작권관리원, 미술저작권관리원, 어문저작권관리원, 영상저작권관리원, 컴퓨터프로그램저작권관리원, 캐릭터저작권관리원","certLic":"소프트웨어자산관리사(C-SAM)","dJobECd":"2220","dJobECdNm":"[2220]법률 사무원","dJobJCd":"3301","dJobJCdNm":"[3301]법률 관련 사무원","dJobICd":"N764","dJobICdNm":"[N764]무형재산권 임대업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006756:1', '{"dJobCd":"K000006756","dJobCdSeq":"1","dJobNm":"정밀화학지식재산권관리자","workSum":"정밀화학과 관련된 지식재산권의 법적 권리에 대한 기업의 이익을 극대화하기 위하여 지식재산권을 조사·분석하여 전략을 수립하고, 지식재산권의 출원 및 등록과 분쟁 발생 시 대응하는 업무를 수행한다.","doWork":"정밀화학과 관련한 지식재산권의 조사·분석을 실시하고 지식재산 사업성·진보성 분석을 통해 지식재산권 전략을 수립하며 지식재산권 보호 전략(로드맵)을 수립한다. 지식재산권 출원·등록 기준·절차를 설정하며 발명내용 검토·청구범위를 설정하여 지식재산권을 출원하고 등록한다. 지식재산권 분쟁이 있을 경우에는 분쟁조정·소송·청구 실행업무 등을 수행하며 지식재산권을 유지 및 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"2220","dJobECdNm":"[2220]법률 사무원","dJobJCd":"3301","dJobJCdNm":"[3301]법률 관련 사무원","dJobICd":"C203/C204","dJobICdNm":"[C203]비료, 농약 및 살균, 살충제 제조업 / [C204]기타 화학제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005216:1', '{"dJobCd":"K000005216","dJobCdSeq":"1","dJobNm":"특허사무원","workSum":"변리사의 업무지원을 위해 변리사의 지휘하에 특허 관련 서류를 작성하고 제출한다.","doWork":"특허신청 의뢰인과 상담하거나 상담에 참여한다. 특허 관련 정보를 탐색하고 조사한다. 특허 관련 법조문이나 판례 등을 조사한다. 특허출원 관련 서류를 작성한다. 특허신청서를 작성하고 접수한다. 특허 관련 서류의 내용을 검토하여 미비점을 파악한다. 특허 관련 번역을 하거나 외부번역사무소에 의뢰하고 관리한다. 특허 관련 도면을 그리기도 한다. 기업체나 기관에서 특허 관련 지원업무를 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"변리사무원","connectJob":"특허명세사, 특허엔지니어","certLic":"소프트웨어자산관리사(C-SAM)","dJobECd":"2220","dJobECdNm":"[2220]법률 사무원","dJobJCd":"3301","dJobJCdNm":"[3301]법률 관련 사무원","dJobICd":"M711","dJobICdNm":"[M711]법무관련 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002321:1', '{"dJobCd":"K000002321","dJobCdSeq":"1","dJobNm":"특허정보관리원","workSum":"새롭게 개발할 제품과 기술이 중복을 피해 성공적으로 특허출원이 될 수 있도록 특허 관련 DB를 관리하고 특허출원에 대한 준비를 한다.","doWork":"연구개발하려는 제품의 유사성 및 경쟁제품의 기술자료를 수집하고 국내외 특허정보를 분석한다. 출원된 특허를 산업별, 제품별, 기술별로 구분하여 관리한다. 특허내용을 분석하고 분석자료를 통해 연구진들이 향후 연구방향을 결정하고 특허내용을 참조할 수 있도록 한다. 새롭게 개발된 제품이나 기술에 대해 이미 기존에 특허가 출원되지 않았는지 특허DB를 검색하고 출원서류를 작성하여 특허출원을 준비한다. 특허출원 시 특허사무소나 변리사들과 협의하며 국내뿐만 아니라 해외특허를 출원하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"관련없음","dJobECd":"2220","dJobECdNm":"[2220]법률 사무원","dJobJCd":"3301","dJobJCdNm":"[3301]법률 관련 사무원","dJobICd":"M711","dJobICdNm":"[M711]법무관련 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;