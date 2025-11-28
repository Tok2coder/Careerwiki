INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003456:1', '{"dJobCd":"K000003456","dJobCdSeq":"1","dJobNm":"휴대폰특허관리원","workSum":"휴대폰과 관련된 특허 관련 법이나 제도를 검토하고 내용을 분석하여 특허를 출원하고 관리한다.","doWork":"휴대폰 개발이나 생산과 관련된 발명특허, 실용신안, 의장등록 자료를 수집한다. 휴대폰의 기술, 개발, 생산에 대한 라이선스 정책을 조사하여 관련된 지식재산권을 검토한다. 검토된 특허자료를 기반으로 특허 조사의 대상을 선정한다. 특허명세서를 작성하고 특허명세서의 특허청구 범위를 설정하여 특허를 출원한다. 출원된 특허는 분류기준을 선정하고 특허시스템에 등록한다. 등록된 특허는 규정에 따라 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"2220","dJobECdNm":"[2220]법률 사무원","dJobJCd":"3301","dJobJCdNm":"[3301]법률 관련 사무원","dJobICd":"C264","dJobICdNm":"[C264]통신 및 방송 장비 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007553:1', '{"dJobCd":"K000007553","dJobCdSeq":"1","dJobNm":"감사사무원","workSum":"감독기관의 감독규정 및 관련 법규, 회사사규 및 윤리기준을 근간으로 감사실시계획을 세우고 감사를 실시한다.","doWork":"회사 감사기관의 감사지침에 따라 부서별 감사계획, 연간 감사계획을 수립한다. 감사실시계획에 따라 해당 부서에 감사실시계획(일시, 기간, 감사내용, 자료제출 요청)을 통보한다. 재무·준법·업무·경영·IT부문 등의 기능에 대하여 일상·종합·특별감사를 실시한다. 직무수행에 필요한 정보에 대한 자료제출 요구를 한다. 증빙서류 등 관계서류의 제출을 요구한다. 회계관계 거래처에 대한 조사자료를 청구한다. 관계자의 출석 및 답변을 요구한다. 창고, 금고, 장부 및 물품을 봉인한다. 감사실시 결과에 대한 평가 및 내부보고를 실행한다. 감사결과 처리 및 대책을 위한 사후관리를 실시한다. 업무현황, 관계법령 및 내규, 기타 관계자료를 수집한다. 컴플라이언스 규정(내부통제 및 위험관리로서 준법감시인제도, 내부감시) 및 지침을 작성하고 컴플라이언스 관련 제반 업무를 관리한다. e-감사시스템을 통하여 실시간으로 자료를 추출하며 사전에 설정된 위험요인을 예방 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"컴플라어언스사무원, 준법감시원","dJobECd":"0264","dJobECdNm":"[0264]감사 사무원","dJobJCd":"3302","dJobJCdNm":"[3302]감사 사무원","dJobICd":"ALL","dJobICdNm":"[ALL]전체","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002425:1', '{"dJobCd":"K000002425","dJobCdSeq":"1","dJobNm":"보험사감독원","workSum":"보험관련 사업자의 회계, 세무, 계리, 법률, 재산운용 등에 관하여 관리·감독하는 업무를 수행한다.","doWork":"보험회사, 소속 대리점, 손해사정업자 등에 대한 감사를 실시하고 결과에 대한 조치와 사후관리를 한다. 보험사업에 관련된 감사 관련 자료를 수집·분석·보고한다. 보험료나 제지급금의 횡령, 유용에 관한 감사를 실시한다. 보험사업에 관련된 임원의 비위에 관하여 조사하여 조치를 취하고 사후관리를 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","dJobECd":"0264","dJobECdNm":"[0264]감사 사무원","dJobJCd":"3302","dJobJCdNm":"[3302]감사 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007399:1', '{"dJobCd":"K000007399","dJobCdSeq":"1","dJobNm":"은행검사","workSum":"은행의 검사부서에서 검사기획, 상시감사, 경영감사, 감찰 등을 수행한다.","doWork":"감사규정, 제도 등 일반, 특별 감사업무 전반을 기획하고 검사결과 지적사항에 대한 사후관리 및 대외기관 관련 업무, 금융사고 관련 업무를 총괄하는 등 검사기획업무를 한다. 영업점 일상거래 중 사고 취약거래와 오류발생 개연성이 있는 거래에 대하여 실시간으로 점검하고 감사를 통해 업무 취급의 규정준수여부와 사고 취약부분을 점검하여 지도 및 시정조치하고 사고와 부실여신 발생을 예방하는 상시감사를 한다. 감사대상 부점에 입점하여 법무감사를 통해 사고예방과 자산의 건전성제고를 유도하는 등 업무전반에 검사를 실시하는 경영감사를 한다. 자율사정기능 및 상시 체제 강화 등 은행의 경쟁력 강화와 건전한 직장풍토를 조성을 위해 감찰업무를 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"감독","workFunc3":"관련없음","dJobECd":"0264","dJobECdNm":"[0264]감사 사무원","dJobJCd":"3302","dJobJCdNm":"[3302]감사 사무원","dJobICd":"K641","dJobICdNm":"[K641]은행 및 저축기관","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007398:1', '{"dJobCd":"K000007398","dJobCdSeq":"1","dJobNm":"준법감시원","workSum":"준법감시 부서에서 준법감시인의 업무를 지원하는 등 준법감시 관련 활동을 한다.","doWork":"임직원의 내부 통제기준의 준수여부에 대해 점검 및 조사한다. 정관, 규정의 제개정, 이사회 등 각종 위원회의 부의사항(감사위원회 제외), 새로운 업무의 개발 및 추진 등 주요 업무에 대한 법규 준수 측면에서 사전 검토한다. 임직원의 윤리강령의 제정 및 개정하고 운영한다. 신용평가의 공정성 및 신뢰성 확보를 위한 업무 전반에 대한 상시 감시감독시스템을 구축하고 운영한다. 내부통제기준 준수 매뉴얼을 작성하여 배포한다. 법규준수 관련 임직원을 교육한다. 이사회, 감사, 기타 주요 회의에 참석하여 의견을 진술한다. 혐의거래보고제도(불법재산이거나 금융거래 상대방이 자금세탁행위를 하고 있거나 분할거래를 하고 있다고 의심되는 합당한 근거가 있는 경우, 그 사실을 금융정보분석원(KoFIU)에 보고해야 할 의무)에 관련된 업무를 수행한다. 기타 금융관련 법무관련 업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"감독","workFunc3":"관련없음","similarNm":"준법감시담당자, 컴플라이언스담당자","connectJob":"준법지원인, 자금세탁담당자, 검사","certLic":"변호사, 공인회계사","dJobECd":"0264","dJobECdNm":"[0264]감사 사무원","dJobJCd":"3302","dJobJCdNm":"[3302]감사 사무원","dJobICd":"ALL","dJobICdNm":"[ALL]전체","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004113:1', '{"dJobCd":"K000004113","dJobCdSeq":"1","dJobNm":"증권거래감시원","workSum":"주식 및 선물옵션시장에서의 불공정매매를 예방·적출하고, 풍문수집·분석 및 상장(거래소시장)·등록(코스닥시장-협회중개시장)법인의 지분관리를 통하여 공정한 가격형성 및 시장의 건전성을 제고한다.","doWork":"주식 및 선물옵션시장에서의 매매거래 감시기준 및 계획을 수립하고 매매양태 및 매매통계량을 분석한다. 주가감시를 통해 이상매매를 적발하고 풍문 및 보도종목을 분석한다. 추적조사대상종목을 선정하고 조회공시 및 추적조사를 의뢰한다. 이외 소수지점매매집중종목, 전환사채 이상매매종목, 허수성 호가종목, 종가급변종목, 저가주의 주가급변종목, 우선주 주가급변종목 등에 대한 추적조사를 의뢰하고, 감리종목, 감리지정 우려종목을 지정 및 해제하고 공표한다. 상장·등록회사 임직원 주식담당자에 대한 교육을 실시한다. 선물옵션시장에서 이상매매를 적출하고 추적조사를 의뢰하며 프로그램매매 현황집계 및 공표, 동향분석을 수행한다. 프로그램매매 보고책임자에 대한 교육을 실시한다. 상장·등록법인의 지분변동을 주시하고 내부자 인적사항을 관리하거나 상장·등록법인 관련 풍문을 수집·분석하여 시장조치를 취하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"주가감시원, 선물옵션감시원","dJobECd":"0264","dJobECdNm":"[0264]감사 사무원","dJobJCd":"3302","dJobJCdNm":"[3302]감사 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001989:1', '{"dJobCd":"K000001989","dJobCdSeq":"1","dJobNm":"교통사고통계원","workSum":"교통사고 통계자료를 분석하여 교통안전대책수립에 필요한 기초자료를 제공한다.","doWork":"교통사고 및 관련 통계자료를 수집하여 데이터베이스화한다. 통계분석프로그램을 이용하여 교통사고 특성에 따른 자료의 분류 및 분석 작업을 수행한다. 도로교통사고 통계에 관한 정보관리체계를 구축·운영한다. 교통사고 통계분석 및 GIS 분석정보를 제공하여 교통안전활동을 지원한다. 보고서 발간 및 교통사고통계 분석정보서비스 및 보고서를 발간하여 관련 기관, 학계, 지방자치단체, 연구소 등에 제공한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0293","dJobECdNm":"[0293]통계 사무원","dJobJCd":"3910","dJobJCdNm":"[3910]통계 관련 사무원","dJobICd":"O842","dJobICdNm":"[O842]사회 및 산업정책 행정","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004210:1', '{"dJobCd":"K000004210","dJobCdSeq":"1","dJobNm":"보험통계담당원","workSum":"보험료수납현황, 체납입현황, 보험금지급현황 등 보험 관련 통계자료를 파악하여 요청부서에 통보한다.","doWork":"전산자료를 통해 지역별, 지점별, 영업소별, 상품별, 월별 보험료수납현황, 체납입현황, 계약해지현황, 보험금지급실적 등을 파악하여 통계자료를 만들어 관련 부서에 통보한다. 문제점의 발견 시 개선대책을 수립하도록 한다. 신상품개발 시 관련 자료로 활용하도록 해당 부서에 자료를 넘겨 도움을 준다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"보험통계사무원","connectJob":"담당하는 통계의 종류에 따라 생명보험통계담당원, 교육보험통계담당원, 손해보험통계담당원, 개인보험통계담당원, 법인보험통계담당원","dJobECd":"0293","dJobECdNm":"[0293]통계 사무원","dJobJCd":"3910","dJobJCdNm":"[3910]통계 관련 사무원","dJobICd":"K651","dJobICdNm":"[K651]보험업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004040:1', '{"dJobCd":"K000004040","dJobCdSeq":"1","dJobNm":"설문조사원","workSum":"조사감독원(수퍼바이저)의 지시에 따라 응답자를 방문하여 설문지에 설문내용을 기록한다.","doWork":"조사감독원(슈퍼바이저)의 지시에 따라 조사대상자 혹은 조사집단을 직접 방문하거나 전화로 조사를 수행한다. 전화조사의 경우, 선정기준에 적합한 사람을 찾아 조사연구원이 작성한 설문지를 읽어주면서 완성한다. 면접조사의 경우, 선정기준에 맞는 사람을 만나 설문지를 읽어주거나 읽게 하고, 보기카드를 제시하거나, 특정상품, 특정인쇄물 등을 보여주면서 설문지를 완성한다. 최종적으로 완성된 설문지를 조사감독원(슈퍼바이저)에게 제출한다. 재조사를 하도록 지시를 받았을 경우 다시 유사한 방법으로 새로운 설문지를 완성한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"전화설문조사원, 면접조사원, 설문면접원, 여론조사원","dJobECd":"0293","dJobECdNm":"[0293]통계 사무원","dJobJCd":"3910","dJobJCdNm":"[3910]통계 관련 사무원","dJobICd":"M714","dJobICdNm":"[M714]시장조사 및 여론조사업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005250:1', '{"dJobCd":"K000005250","dJobCdSeq":"1","dJobNm":"시장조사현장관리자","workSum":"센서스, 여론조사, 시장조사, 좌담회에서 피면접자의 선정 등에 있어 필드조사가 오류 없이 진행될 수 있도록 설문조사원을 관리·감독한다.","doWork":"센서스, 여론조사, 시장조사, 정성조사에서 조사연구원의 지도에 따라 피면접자 혹은 집단의 세부적인 선정을 한다. 조사대상 집단 혹은 대상자 표본틀을 유지하기 위해서 설문조사원을 교육하고 지도·감독한다. 설문조사의 경우 설문대상자의 표본적절성 여부, 조사내용 정확성 여부를 확인한다. 설문조사한 내용을 취합하여 검증사무원에게 검토하고 검증하도록 한다. 부정확할 경우 재조사 실시를 지시한다. 여론조사분석원, 시장조사분석원, 센서스담당자로부터 지시 받은 표본틀 유지상황을 수시로 점검하여 보고한다. 조사가 끝난 후 부호화(코딩)담당자에게 설문지의 부호화를 지시하고, 자료입력원에게 부호화된 자료를 컴퓨터에 입력하도록 한다. 좌담회의 경우, 정성조사분석가로부터 피좌담회 참석요구자들의 성별, 연령, 직업 등의 사항을 전달받아 적합한 대상자를 선정한다. 좌담회에 참석한 사람들의 대화내용을 속기사에게 기록하여 일반문장으로 만들어서 정성조사분석가(정성조사연구원)에게 제출하도록 한다. 참석자들의 대화내용을 녹음하거나 비디오에 담기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"감독","workFunc3":"관련없음","similarNm":"면접원슈퍼바이저, 면접원감독원, 시장조사필드매니저","connectJob":"시장조사원, 여론조사슈퍼바이저, 사회조사슈퍼바이저, 통계조사슈퍼바이저, 조사감독자","dJobECd":"0293","dJobECdNm":"[0293]통계 사무원","dJobJCd":"3910","dJobJCdNm":"[3910]통계 관련 사무원","dJobICd":"M714","dJobICdNm":"[M714]시장조사 및 여론조사업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001725:1', '{"dJobCd":"K000001725","dJobCdSeq":"1","dJobNm":"시청률조사원","workSum":"텔레비전 프로그램의 시청률을 조사한다.","doWork":"특정 텔레비전 프로그램의 시청률을 조사하기 위해 일정 수의 가정을 표본으로 산정하여 입력기와 특별한 리모콘을 설치하고 사용방법을 설명한다. 리모콘의 작동으로 가구별 시청자, 시청시간 및 프로그램 등의 정보가 입력기에 기록되고 자료가 심야시간에 전화선을 통하여 주컴퓨터에 입력되면 결과처리 프로그램을 작동하여 출력한다. 결과물을 광고회사 담당자나 방송사의 관계자 등에게 전달한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"관련없음","dJobECd":"0293","dJobECdNm":"[0293]통계 사무원","dJobJCd":"3910","dJobJCdNm":"[3910]통계 관련 사무원","dJobICd":"M714","dJobICdNm":"[M714]시장조사 및 여론조사업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006661:1', '{"dJobCd":"K000006661","dJobCdSeq":"1","dJobNm":"조사자료검증원","workSum":"조사자료의 정확도를 높이기 위해 센서스, 여론조사, 시장조사 등에서 수집된 자료가 적절한지 여부를 검증하는 일을 한다.","doWork":"센서스, 여론조사, 시장조사 등의 조사계획에 따라 수집된 자료가 적절히 수집되었는지에 대해 검토·확인한다. 설문대상자와의 전화통화 등을 통해 설문대상이 본인이었는지를 조사한다. 부적절히 조사된 것이라고 판단되면 표기하여 면접원감독원에게 보고하여 재조사하도록 조치한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"관련없음","dJobECd":"0293","dJobECdNm":"[0293]통계 사무원","dJobJCd":"3910","dJobJCdNm":"[3910]통계 관련 사무원","dJobICd":"M714","dJobICdNm":"[M714]시장조사 및 여론조사업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002477:1', '{"dJobCd":"K000002477","dJobCdSeq":"1","dJobNm":"조사자료처리원","workSum":"검증이 끝난 자료를 부호화하여 분석원에게 제공한다.","doWork":"검증이 통과된 데이터를 단답형과 단순 숫자데이터로 구분한다. 문장으로 이루어진 데이터를 해석하여 알맞은 코드를 부여한다. 객관식 데이터를 코딩한다. 코딩된 데이터를 원자료와 비교한다. 펀치를 통해 입력한다. 데이터를 파악할 수 있는 형태의 파일로 데이터분석원에게 제공한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"단순작업","connectJob":"데이터코딩요원, 데이터입력원, 데이터검증원","dJobECd":"0293","dJobECdNm":"[0293]통계 사무원","dJobJCd":"3910","dJobJCdNm":"[3910]통계 관련 사무원","dJobICd":"M714","dJobICdNm":"[M714]시장조사 및 여론조사업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006082:1', '{"dJobCd":"K000006082","dJobCdSeq":"1","dJobNm":"증권시장통계작성원","workSum":"증권시장참가자의 투자편의와 학계의 시장분석에 도움을 주기 위하여 각종 통계데이터를 수집·정리·발표한다.","doWork":"증권 관련 통계자료의 제출을 의뢰하고 접수한다. 항목별로 조정하여 주식, 채권, 선물옵션거래 실적, 주가지수, 주식분포상황, 상장·등록증권통계, 해외증권시장통계, 상장·등록법인 결산실적분석 등의 내용을 수집하여 연월일별로 작성한다. 작성된 자료는 인터넷이나 증권시장지를 통해 공표한다. 시장참가자의 관련 항목에 대한 질의에 답변한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0293","dJobECdNm":"[0293]통계 사무원","dJobJCd":"3910","dJobJCdNm":"[3910]통계 관련 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007550:1', '{"dJobCd":"K000007550","dJobCdSeq":"1","dJobNm":"통계사무원","workSum":"각종 통계데이터를 수집하여 체계적으로 정리하고, 기본적인 통계처리업무를 수행한다.","doWork":"통계조사계획에 따라 작성된 설문지를 검토한다. 통계조사원에게 조사방법과 유의사항에 대해 교육한다. 계획과 절차에 따라 조사가 진행되도록 지원한다. 조사된 내용을 자료입력원에게 입력하도록 지시하거나 직접 입력한다. 통계소프트웨어(SPSS: Statistical Package for Social Science, SAS:Statistical Analysis Aystem 등)를 사용하여 기본적인 통계처리를 한다. 조사결과를 작성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"관련없음","connectJob":"통계자료집계사무원, 통계조사사무원, 인구조사원, 통계기획사무원","dJobECd":"0293","dJobECdNm":"[0293]통계 사무원","dJobJCd":"3910","dJobJCdNm":"[3910]통계 관련 사무원","dJobICd":"M702/M739","dJobICdNm":"[M702]인문 및 사회과학 연구개발업 / [M739]그 외 기타 전문, 과학 및 기술 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002381:1', '{"dJobCd":"K000002381","dJobCdSeq":"1","dJobNm":"통계자료전산처리원","workSum":"센서스, 여론조사, 시장조사에서 실시된 각종 설문지를 통계적으로 처리하는 업무를 수행한다.","doWork":"각종 통계용 소프트웨어(SPSS, SAS 등)를 사용하여 관련 전산데이터를 자료입력원으로부터 넘겨받아 기본적인 통계처리를 한다. 각 자료와 프로젝트 내용을 보고 가장 적합한 통계소프트웨어를 선정한다. 시장조사분석가, 여론조사분석가 등과 협의하여 통계자료를 어디까지 분석할 것인지를 협의하여 요청이 있을 시 추가적인 통계분석을 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"관련없음","similarNm":"통계조사전산원, 통계조사전산연구원","dJobECd":"0293","dJobECdNm":"[0293]통계 사무원","dJobJCd":"3910","dJobJCdNm":"[3910]통계 관련 사무원","dJobICd":"M714","dJobICdNm":"[M714]시장조사 및 여론조사업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004410:1', '{"dJobCd":"K000004410","dJobCdSeq":"1","dJobNm":"통신서비스수요조사원","workSum":"통신서비스와 신종서비스 등 현재 및 장래 수요를 파악하기 위하여 각종 기초자료를 수집·분석한다.","doWork":"관할구역 내의 재개발계획, 도시개발계획 및 가구 수 등을 파악하여 통신서비스의 수요예상량 및 신종서비스의 잠재수요량을 예측한다. 신종서비스를 수요자에게 공급하기 위하여 이용고객의 성향을 조사·분석한다. 도시개발계획에 따른 공중전화 및 전용회선의 수요량을 예측한다. 전화교환시설의 신·증설을 위한 개황조사 및 선로의 보수를 위한 현장조사를 실시한다. 공중전화의 설치요청에 대하여 설치장소의 적정여부를 확인하기 위하여 현장을 확인한다. 조사·분석한 자료를 정리하여 보고자료를 작성한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"서비스제공","workFunc3":"수동조작","similarNm":"전화서비스수요조사원","dJobECd":"0293","dJobECdNm":"[0293]통계 사무원","dJobJCd":"3910","dJobJCdNm":"[3910]통계 관련 사무원","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002296:1', '{"dJobCd":"K000002296","dJobCdSeq":"1","dJobNm":"여행사대리점영업원","workSum":"여행사 대리점에게 영업 목표를 부여, 관리하며, 고객 마케팅을 통해 대리점을 지원한다.","doWork":"기존 그리고 신규 여행 관련 유통 채널에 대한 인사이트(종합적 통찰력)를 가지고 대리점의 고객 판매 마케팅을 기획·실행한다. 데이터 기반으로 영업 목표와 실적을 관리하며, 대리점이 지속 발전 가능하도록 프로모션을 기획하여, 매출 발생을 지원한다. 여행 관련 채널 생성, 신규 시장 진입 그리고 기존 시장 강화를 통해 영업 매출 확대에 기여한다. 대리점 입지 분석, 매장 관리, 직원 관리 등의 컨설팅을 수행하여, 대리점 대표 및 직원의 역량 향상과 대리점 경쟁력 강화를 위해 교육을 지원한다. 대리점과의 커뮤니케이션을 통해 업무 분쟁 문제 발생 시 중간에서 해결한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"여행 관련 제휴사 영업원","dJobECd":"5212","dJobECdNm":"[5212]여행 사무원","dJobJCd":"3921","dJobJCdNm":"[3921]여행 사무원","dJobICd":"N752","dJobICdNm":"[N752]여행사 및 기타 여행보조 서비스업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004331:1', '{"dJobCd":"K000004331","dJobCdSeq":"1","dJobNm":"여행상품상담원","workSum":"고객에게 여행상품을 추천 및 판매하고, 여행일정을 계획한다.","doWork":"고객의 요구에 맞는 여행상품을 추천하고, 상품별 비용 등 각종 자료를 제시한다. 숙박시설 예약, 교통편 예약 등 여행에 따르는 대행 업무를 준비하고 여행일정을 계획한다. 행선지, 교통편, 여행일정, 경비, 숙박시설을 고객과 협의·결정한다. 단체여행을 계획하고 명시하여 판매한다. 여행 출발 전 여행지에 관한 자료를 고객에게 제공한다. 여행경비를 계산하거나 단체여행의 비용을 견적한다. 고객 운송수단 및 숙박시설을 예약한다. 출발 전 여행자계약서를 작성하고, 여행경비 입금에 대한 확인 작업을 한다. 수송이나 관광지 출입을 위한 표를 구입하고 요금을 수급한다. 여행상품에 관한 고객 불만사항을 해결한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"여행상담원","dJobECd":"5212","dJobECdNm":"[5212]여행 사무원","dJobJCd":"3921","dJobJCdNm":"[3921]여행 사무원","dJobICd":"N752","dJobICdNm":"[N752]여행사 및 기타 여행보조 서비스업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005182:1', '{"dJobCd":"K000005182","dJobCdSeq":"1","dJobNm":"여행영업기획관리원","workSum":"전사 여행상품 매출 확대를 위해 대리점, 제휴, 직판 영업을 기획하고 관리한다.","doWork":"영업 실적 데이터를 취합하여 보고서를 작성하며, 영업정책 보고서 및 기획서를 작성한다. 영업 환경 파악을 통해 현장 문제에 대한 의사결정을 수행하며, 여러 관련자들의 이해관계를 근거하여 영업정책을 수립한다. 수립된 영업정책을 운영하며, 이를 지원하는 영업 시스템을 관리 및 개선한다. 영업정책 전파 보고서를 작성하고, 공감대를 형성한다. 영업정책을 준수하는 범위 내에서 프로모션 시행의 적정성을 판단한다. 영업 조직의 평가 지표를 설정하며, 영업 실적을 관리한다. 대리점, 제휴, 직판 영업별 전략을 수립하고, 각 영업의 실적 지표를 설정하고 관리한다. 영업원 및 대리점 임직원의 업무역량향상을 위한 교육지원을 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"여행사 대리점 영업원","connectJob":"여행사 대리점 영업원","dJobECd":"5212","dJobECdNm":"[5212]여행 사무원","dJobJCd":"3921","dJobJCdNm":"[3921]여행 사무원","dJobICd":"N752","dJobICdNm":"[N752]여행사 및 기타 여행보조 서비스업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001305:1', '{"dJobCd":"K000001305","dJobCdSeq":"1","dJobNm":"여행제휴사영업원","workSum":"여행 관련 제휴사(홈쇼핑, 카드사, 인터넷 쇼핑몰 등)의 확대를 통해 여행상품 판매 실적 증대 관련 영업을 수행한다.","doWork":"시장상황, 고객 반응을 고려한 상품가 책정, 타사 대비 경쟁력 있는 상품 조달을 통해 적합한 상품을 적절한 시기에 적절한 채널에 공급한다. 고객 니즈 파악을 통한 판매 계획을 수립하며, 채널별 특성에 따른 최적의 상품을 선정하고 제안한다. 조직 내외부 간 채널 마케팅 관련 협상 및 조정을 하며, 제휴사 특성을 반영한 프로모션을 진행한다. 고객을 관리 하는 등 채널 확대를 위한 활동을 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"여행사 대리점 영업원","dJobECd":"5212","dJobECdNm":"[5212]여행 사무원","dJobJCd":"3921","dJobJCdNm":"[3921]여행 사무원","dJobICd":"N752","dJobICdNm":"[N752]여행사 및 기타 여행보조 서비스업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007231:1', '{"dJobCd":"K000007231","dJobCdSeq":"1","dJobNm":"여행콜센터상담원","workSum":"여행사 콜센터에서 고객에게 여행상품을 상담, 판매 또는 판매를 확정한다.","doWork":"고객의 여행 관련 질문에 대해 상담하며, 상품별 비용 등 각종 자료를 제시한다. 상담한 내용을 바탕으로 기존 패키지 및 사전 구성된 단체 여행상품을 판매한다. 홈쇼핑 등으로 판매한 상품에 대해 판매 확정 전화 상담을 진행하며, 여행에 대해 추가 정보를 제공한다. 고객이 여행상품 구매를 주저하거나, 취소하려고 할 때, 여행상품 구매를 확정하도록 설득한다. 그리고 여행 관련 불만이 있는 고객의 전화를 받는 경우, 고객 불만을 응대하며 불만해소 관련 부서의 도움을 받아 고객 불만 사항을 해결하도록 지원한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"설득","workFunc3":"관련없음","similarNm":"여행상담원","dJobECd":"5212","dJobECdNm":"[5212]여행 사무원","dJobJCd":"3921","dJobJCdNm":"[3921]여행 사무원","dJobICd":"N752","dJobICdNm":"[N752]여행사 및 기타 여행보조 서비스업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001775:1', '{"dJobCd":"K000001775","dJobCdSeq":"1","dJobNm":"경기장통신원","workSum":"투표위원의 지시에 따라 마권 또는 경주권(승자투표권)의 발매에 관련된 각종 현황을 각각의 발매소에 연락한다.","doWork":"경주가 시작되기 전에 마이크, 전화기, 매표시작표시기 등 각종 기기를 점검한다. 예상지의 매 경기예상을 종합하여 종합예상서를 작성한다. 전 주와 같은 요일과 대비하여 경주별 총 입장인원과 총매출액을 관계위원에게 통보한다. 매표시작, 마필취소, 경륜용자전거취소, 선수변경 등의 사항을 안내방송한다. 매표시작표시기가 소등되면 매표마감을 알리는 벨을 누른다. 매표종료 후 각 투표장으로부터 발매기의 이상 유무를 보고 받고 전산실에 통보한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"서비스제공","workFunc3":"관련없음","connectJob":"경기장에 따라 경마장통신원, 경륜장통신원","dJobECd":"0291","dJobECdNm":"[0291]안내·접수원 및 전화교환원","dJobJCd":"3922","dJobJCdNm":"[3922]안내·접수원 및 전화교환원","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001450:1', '{"dJobCd":"K000001450","dJobCdSeq":"1","dJobNm":"고객전자메일접수원","workSum":"전자문서(EDI), 이메일, 게시판을 통해 접수된 이용에 대한 각종 통신 관련 문의사항을 읽고 안내한다.","doWork":"전자메일, 전자문서, 게시판으로 접수된 이용자의 통신서비스 관련 문의사항을 읽고 문의내용을 파악한다. 데이터베이스(DB：Data Base), 정보제공자(IP), 채팅, 커뮤니티 등 인터넷통신과 관련한 각종 서비스의 이용방법에 대한 문의에 답변서를 작성하여 발송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"관련없음","similarNm":"고객전자문서접수원","dJobECd":"0291","dJobECdNm":"[0291]안내·접수원 및 전화교환원","dJobJCd":"3922","dJobJCdNm":"[3922]안내·접수원 및 전화교환원","dJobICd":"J631","dJobICdNm":"[J631]자료처리, 호스팅, 포털 및 기타 인터넷 정보매개 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002973:1', '{"dJobCd":"K000002973","dJobCdSeq":"1","dJobNm":"공항의전원","workSum":"「공항에서의 귀빈예우에 관한 규칙」 등 관련 규정에 따른 귀빈 대상자 출·입국 시 의전 서비스를 제공한다.","doWork":"관련 규정에 따른 내·외국 의전 대상자의 귀빈실 이용 접수를 받고 귀빈실 이용 시 행사장 주차장 이용 조치 및 음료 제공 서비스 등을 제공한다. 귀빈의 출·입국 수속을 수행하며 필요시 원활한 출·입국 의전을 위해 관계 기관 사전 협조를 구한다. 국내에서 실시하는 국제 행사에 참여하는 외국 귀빈의 출·입국 시에도 절차에 따라 의전을 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"수집","workFunc2":"서비스제공","workFunc3":"관련없음","similarNm":"공항귀빈실 직원","dJobECd":"0291","dJobECdNm":"[0291]안내·접수원 및 전화교환원","dJobJCd":"3922","dJobJCdNm":"[3922]안내·접수원 및 전화교환원","dJobICd":"H511","dJobICdNm":"[H511]항공 여객 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007356:1', '{"dJobCd":"K000007356","dJobCdSeq":"1","dJobNm":"방문안내원","workSum":"방문객을 안내하고 방문객의 문의사항에 응대한다.","doWork":"외부인의 사내 무단출입을 통제하고 문제가 발생할 경우 신속하게 조치한다. 허가된 외부인이 출입할 경우, 출입인의 인적사항을 기재하고 방문자용 출입카드를 발급하고 추후 회수한다. 방문객을 사무실·공장 등으로 안내한다. 제품의 생산과정 및 특징, 공장규모 등에 대해 설명하고 질문에 대답한다. 임직원 접견을 목적으로 방문한 경우 해당 임직원의 접견의사를 확인한 후 안내한다. 방문객에게 산업체의 홍보물을 나누어 준다. 우편물을 수령하여 배분하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"관련없음","connectJob":"사업체에 따라 병원안내원, 기업안내원, 화랑안내원, 박물관안내원, 데스크안내원, 헬프데스크안내원, 로비데스크안내원, 백화점안내원, 백화점안내데스크원, 건물안내원, 빌딩안내원, 마트안내도우미, 쇼핑몰안내원, 청와대안내원","dJobECd":"0291","dJobECdNm":"[0291]안내·접수원 및 전화교환원","dJobJCd":"3922","dJobJCdNm":"[3922]안내·접수원 및 전화교환원","dJobICd":"C/G/J","dJobICdNm":"[C]제조업 / [G]도매 및 소매업 / [J]정보통신업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002808:1', '{"dJobCd":"K000002808","dJobCdSeq":"1","dJobNm":"방송국견학안내원","workSum":"방송국을 방문한 사람들에게 방송국 및 방송국 견학홀을 안내 및 설명한다.","doWork":"견학단이나 개인 방문자를 안내하여 방송제작현장을 안내하거나 견학홀 내의 한 코너를 담당하여 방문자에게 담당코너에 대한 설명을 한다. 스튜디오의 방송카메라, 조명, 마이크 등의 방송기자재나 조정실의 녹화과정, 편집, 방송과정 등 방송국시설을 안내·설명한다. 방문객들의 불만사항을 접수 및 보고한다. 단체 방문일 경우 방문 후에 우편이나 이메일을 통해 감사인사 등의 사후관리를 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"방송국견학해설원","dJobECd":"0291","dJobECdNm":"[0291]안내·접수원 및 전화교환원","dJobJCd":"3922","dJobJCdNm":"[3922]안내·접수원 및 전화교환원","dJobICd":"J602","dJobICdNm":"[J602]텔레비전 방송업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004259:1', '{"dJobCd":"K000004259","dJobCdSeq":"1","dJobNm":"방송안내원","workSum":"열차역, 공항, 유원지, 백화점 등 공공장소에서 안내방송을 한다.","doWork":"방송안내 원고를 작성하거나 작성된 원고를 확인한다. 방송시간을 확인한다. 방송장비를 조작하여 안내방송을 한다. 방송원고에 따라 시설이용 안내, 주의사항 및 안전지도, 운영안내(개점, 폐점, 시간, 목적지, 도착지 등), 광고·홍보, 판매촉진, 해설 및 소개 등의 내용을 방송한다. 긴급방송(화재, 대피, 미아찾기, 대중통솔 등)을 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"시범후 30일 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"열차방송안내원, 비행기방송안내원, 시설방송안내원, 미아방송안내원, 병원방송안내원, 백화점방송안내원, 공항방송안내원","dJobECd":"0291","dJobECdNm":"[0291]안내·접수원 및 전화교환원","dJobJCd":"3922","dJobJCdNm":"[3922]안내·접수원 및 전화교환원","dJobICd":"R912","dJobICdNm":"[R912]유원지 및 기타 오락관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006889:1', '{"dJobCd":"K000006889","dJobCdSeq":"1","dJobNm":"산업체안내원","workSum":"산업체에서 방문객을 안내하고 관련 시설 등에 대해 설명한다.","doWork":"방문객이 방문하면 공장이나 연구소 등 산업체의 각종 시설로 인솔하여 안내한다. 각종 생산과정과 제품, 공장규모 등에 대해 설명한다. 방문객의 질문에 답변한다. 방문객에게 산업체의 홍보물을 나누어주기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"청각|언어력|시각|","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"관련없음","connectJob":"공장견학안내원, 산업시찰안내원","dJobECd":"0291","dJobECdNm":"[0291]안내·접수원 및 전화교환원","dJobJCd":"3922","dJobJCdNm":"[3922]안내·접수원 및 전화교환원","dJobICd":"C","dJobICdNm":"[C]제조업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001431:1', '{"dJobCd":"K000001431","dJobCdSeq":"1","dJobNm":"숙박업소전화교환원","workSum":"고객의 불만사항 등을 전화상으로 접수하고 투숙한 고객의 전화를 연결한다.","doWork":"고객에게 전화상으로 의견사항을 접수받고 전달한다. 전화상으로 접수된 고객 불편사항을 처리하고 고객이 원하는 서비스를 지원한다. 전화교환기나 그에 부수된 기기를 조작하여 통화자의 요청에 의해 숙박업소 외부와 내부의 구내전화, 숙박업소 내부에서 내부로 전화를 연결시켜 숙박업소에 투숙한 고객에게 서비스한다. 또한 고객이 요청할 경우 모닝콜(Morning Call) 기계를 조작하거나 직접 모닝콜업무를 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"숙박시설전화교환원","dJobECd":"0291","dJobECdNm":"[0291]안내·접수원 및 전화교환원","dJobJCd":"3922","dJobJCdNm":"[3922]안내·접수원 및 전화교환원","dJobICd":"I551","dJobICdNm":"[I551]일반 및 생활 숙박시설 운영업","inqYear":"2021","etc":"500객식 이상의 대형 호텔에는 존재하며 작은 호텔 등에서는 프론터나 예약부서와 통합되는 추세임."}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005000:1', '{"dJobCd":"K000005000","dJobCdSeq":"1","dJobNm":"예약접수원","workSum":"예약접수시스템을 사용하여 고객의 예약을 접수하고 고객의 문의에 응대한다.","doWork":"예약시스템(예약, 일정 등에 대한 정보가 실시간으로 유지되는 시스템) 또는 예약장부를 확인하여 제공할 상품 또는 서비스의 수량, 일정, 기존 예약상황, 가격 등 예약정보를 확인한다. 고객이 예약을 원하는 서비스에 대해 안내하고 문의에 응대한다. 예약자의 인적사항을 확인한다. 예약시스템에 예약내용을 입력한다. 예약상황을 관리자에게 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"시설예약접수원, 음식점예약사무원, 예식예약원, 예식장예약원, 예식접수원, 골프장예약접수원, 스포츠센터예약접수원, 렌트카예약접수원, 대리운전예약접수원, 영화관좌석접수원, 공연예약접수원, 뮤지컬예약접수원, 연극예약접수원, 콘서트예약접수원","dJobECd":"0291","dJobECdNm":"[0291]안내·접수원 및 전화교환원","dJobJCd":"3922","dJobJCdNm":"[3922]안내·접수원 및 전화교환원","dJobICd":"N752","dJobICdNm":"[N752]여행사 및 기타 여행보조 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001790:1', '{"dJobCd":"K000001790","dJobCdSeq":"1","dJobNm":"입국안내원","workSum":"공항 내 안내데스크 내방 고객 대상으로 출·입국 절차, 시설물 위치, 교통 문의 등 각종 안내 업무를 수행한다.","doWork":"공항 출·입국장(면세구역 포함) 내 설치 된 안내데스크에서 내방하는 내·외국인 고객(출·입국 승객, 마중객, 배웅객 등 포함)들을 대상으로 출·입국 절차 안내, 항공사 안내, 공항 내 기관(법무부, 세관, 검역 등) 업무 안내, 시설 안내, 교통 안내 등 각종 안내 업무를 수행한다. 고객 요청 방송 송출이 필요한 경우 방송접수 등을 수행하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"관련없음","similarNm":"공항안내데스크직원","dJobECd":"0291","dJobECdNm":"[0291]안내·접수원 및 전화교환원","dJobJCd":"3922","dJobJCdNm":"[3922]안내·접수원 및 전화교환원","dJobICd":"H511/H512","dJobICdNm":"[H511]항공 여객 운송업 / [H512]항공 화물 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005820:1', '{"dJobCd":"K000005820","dJobCdSeq":"1","dJobNm":"전화번호안내원","workSum":"컴퓨터에 연결된 단말기를 조작하여 고객이 문의하는 전화번호를 안내한다.","doWork":"단말기를 가동하고 안내대의 고유번호를 입력한다. 헤드폰을 쓰고 단말기를 사용하여 통합정보안내시스템에 연결한다. 호출신호를 확인하여 응답하고, 문의사항을 청취한다. 안내할 전화번호를 검색하여 안내한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"관련없음","similarNm":"114전화안내원","connectJob":"전화교환원, 구내전화교환원","dJobECd":"0291","dJobECdNm":"[0291]안내·접수원 및 전화교환원","dJobJCd":"3922","dJobJCdNm":"[3922]안내·접수원 및 전화교환원","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002579:1', '{"dJobCd":"K000002579","dJobCdSeq":"1","dJobNm":"진료접수계원","workSum":"병원의 접수창구에서 환자의 방문을 접수하고 진료를 예약한다.","doWork":"병원의 접수창구에서 환자를 맞이한다. 초진환자의 인적사항, 진찰과목을 확인하여 진료카드를 발급한다. 예약환자의 경우 진찰과목을 확인하고 대기실로 안내한다. 환자의 기록을 정리한다. 환자나 방문객을 접대하고 약속시간을 마련한다. 계산서를 작성하거나 발송하기도 한다. 의사의 지시에 따라 환자에게 처방전을 출력하여 발급한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"병원접수원","dJobECd":"0291","dJobECdNm":"[0291]안내·접수원 및 전화교환원","dJobJCd":"3922","dJobJCdNm":"[3922]안내·접수원 및 전화교환원","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002487:1', '{"dJobCd":"K000002487","dJobCdSeq":"1","dJobNm":"항공기탑승안내원","workSum":"입국수속을 마치고 항공기에 탑승하고자 하는 승객들의 탑승을 안내한다.","doWork":"탑승준비가 완료된 해당 항공기의 출발시간 및 운항노선, 탑승구 번호를 확인하고 방송실에 탑승안내방송을 요청한다. 탑승하는 승객의 여권, 탑승권과 승객 일치 여부를 확인한 후 기내탑승을 안내한다. 탑승수속이 결여되었거나 보안문제가 있는 승객을 구분하여 해당 수속을 밟도록 안내한다. 승객 탑승이 완료되면 인원을 확인하여 소속 항공사에 통보한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"탑승수속안내원","dJobECd":"0291","dJobECdNm":"[0291]안내·접수원 및 전화교환원","dJobJCd":"3922","dJobJCdNm":"[3922]안내·접수원 및 전화교환원","dJobICd":"H511","dJobICdNm":"[H511]항공 여객 운송업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004267:1', '{"dJobCd":"K000004267","dJobCdSeq":"1","dJobNm":"호텔고객지원사무원","workSum":"호텔고객을 영접·보좌하고 객실고객이 필요로 하는 서비스를 제공한다.","doWork":"객실고객에게 호텔시설 이용정보를 제공한다. 고객의 요청에 따라 비행기 등 교통편을 예약하고 수속업무를 대행한다. 극장티켓, 식당과 관광지, 투어링 버스 등의 예약서비스를 제공한다. 쇼핑지에 대한 정보를 제공한다. 투숙고객의 요청에 따라 재등록을 지원한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"귀빈에게 서비스를 제공하는 경우 GRO(Guest Relation Officer), 컨시어지","certLic":"호텔서비스사","dJobECd":"0291","dJobECdNm":"[0291]안내·접수원 및 전화교환원","dJobJCd":"3922","dJobJCdNm":"[3922]안내·접수원 및 전화교환원","dJobICd":"I551","dJobICdNm":"[I551]일반 및 생활 숙박시설 운영업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004750:1', '{"dJobCd":"K000004750","dJobCdSeq":"1","dJobNm":"호텔식음료주문접수원","workSum":"투숙 중인 고객에게 메뉴를 설명하고 고객으로부터 주문을 받아 각 업장에 전달한다.","doWork":"객실에 투숙 중인 고객으로부터 인터폰을 받아 식·음료 주문을 접수한다. 식·음료 주문접수 시에는 메뉴와 음료리스트를 숙지하여 주의 깊게 고객의 주문을 받으며 적당한 메뉴를 추천한다. 접수된 식·음료주문서를 호텔룸서비스웨이터에게 건네준다. 호텔 내의 각 영업장과 각 업장의 메뉴, 레시피, 음식특성, 서비스 제공시간을 숙지하고 고객에게 안내한다. 연회프로그램에 관한 투숙고객의 문의에 대해 설명하고 안내한다. 계산서를 작성하여 담당웨이터에게 건네준다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"식음료오더테이커, 호텔오더테이커","certLic":"호텔서비스사","dJobECd":"0291","dJobECdNm":"[0291]안내·접수원 및 전화교환원","dJobJCd":"3922","dJobJCdNm":"[3922]안내·접수원 및 전화교환원","dJobICd":"I551","dJobICdNm":"[I551]일반 및 생활 숙박시설 운영업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004401:1', '{"dJobCd":"K000004401","dJobCdSeq":"1","dJobNm":"호텔예약사무원","workSum":"호텔의 각종 예약에 관한 업무를 수행하고 호텔예약고객을 관리한다.","doWork":"컴퓨터를 확인하여 호텔의 각종 부대시설의 예약현황을 파악한다. 밤사이 전화, 팩스, 전자우편, 인터넷 등으로 들어 온 예약하고자 하는 내용을 확인하여 예약을 완료하고 예약내용을 통보한다. 근무시간 중에 들어오는 예약에 대해 객실의 단가와 매출액을 고려하여 객실을 판매·접수하고 예약내용을 확인한다. 예약고객을 사전에 확인하고 접수결과를 회신한다. 결과를 객실·현관부서에 통보한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"호텔예약접수원(book keeper)","connectJob":"콘도예약접수사무원, 숙박시설접수사무원","certLic":"호텔서비스사, 호텔관리사","dJobECd":"0291","dJobECdNm":"[0291]안내·접수원 및 전화교환원","dJobJCd":"3922","dJobJCdNm":"[3922]안내·접수원 및 전화교환원","dJobICd":"I551","dJobICdNm":"[I551]일반 및 생활 숙박시설 운영업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001683:1', '{"dJobCd":"K000001683","dJobCdSeq":"1","dJobNm":"호텔현관사무원","workSum":"고객에게 객실을 배정하고 객실과 관련된 서비스를 제공한다.","doWork":"고객의 예약여부를 확인하고, 예약하지 않은 고객에게는 객실형태 등의 정보를 제공한다. 프론트데스크 시스템에 숙박등록(고객의 주소, 성명, 직업, 여권번호, 체재기간, 객실종류, 객실요금, 객실번호, 서명 등)을 하고, 객실을 배정한다. 고객에게 이용안내서를 교부하기도 한다. 호텔벨맨에게 객실열쇠를 건네주고 특이사항을 지시한다. 고객에게 온 메모 및 전달사항 등이 있으면 기록하고 고객에게 전달한다. 고객에게 호텔이용방법, 관광지안내, 식당안내, 쇼핑, 항공기티켓확인 등에 대한 정보를 제공한다. 고객의 필요에 따라 환전을 해주거나 고객의 귀중품을 보관해준다. 객실열쇠를 관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"프런트클럭, 프런트데스크사무원, 호텔프런트사무원","connectJob":"콘도프런트사무원","certLic":"호텔서비스사","dJobECd":"0291","dJobECdNm":"[0291]안내·접수원 및 전화교환원","dJobJCd":"3922","dJobJCdNm":"[3922]안내·접수원 및 전화교환원","dJobICd":"I551","dJobICdNm":"[I551]일반 및 생활 숙박시설 운영업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002749:1', '{"dJobCd":"K000002749","dJobCdSeq":"1","dJobNm":"게임물모니터요원","workSum":"불법게임물의 유해성을 조기에 차단하기 위해 게임물의 등급적정성 등 불법 여부를 모니터링한다.","doWork":"국내 유통되고 있는 게임물을 확인한다. 모니터링 지침을 숙지하고 지침과 비교하여 게임물의 위법성을 모니터링한다. ‘게임산업진흥에 관한 법률’을 위반하는 등급부적정게임물, 불법게임물 등이 위법사항에 해당될 것으로 판단될 경우 증거자료를 확보한다. 관계기관(게임물관리위원회)에 조사를 의뢰한다. 관계기관(게임물관리위원회)에서 위법사항으로 판단되면 행정조치를 시행한다. 모니터링 결과에 대하여 사례를 분석하고 사례집을 발간하며, 관련된 정보를 안내한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","dJobECd":"0292","dJobECdNm":"[0292]고객 상담원 및 모니터 요원","dJobJCd":"3991","dJobJCdNm":"[3991]고객 상담 및 모니터 요원","dJobICd":"O842","dJobICdNm":"[O842]사회 및 산업정책 행정","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003341:1', '{"dJobCd":"K000003341","dJobCdSeq":"1","dJobNm":"고객서비스만족도조사원","workSum":"고객의 요청에 의해 수행된 서비스에 대해 만족도를 조사한다.","doWork":"전자제품수리, 자동차보험 관련 업무, 은행 관련 업무 등 고객의 요청에 의해 수행된 유·무형 서비스에 대해 그 서비스가 완료된 후 서비스를 제공받은 고객을 대상으로 서비스비용, 응대시간, 서비스요원의 전문성과 친절성에 대한 만족도를 조사한다. 주로 서비스가 완료된 후 전화로 고객담당 마케팅부서에서 작성한 설문조사표를 보고 만족도조사를 수행한다. 고객이 만족도점수를 불러주고 의견을 제시하면 이를 기록·정리한다. 만족도 조사결과를 고객마케팅 담당 부서장에 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"고객고충처리상담원","certLic":"소비자전문상담사(1급, 2급)","dJobECd":"0292","dJobECdNm":"[0292]고객 상담원 및 모니터 요원","dJobJCd":"3991","dJobJCdNm":"[3991]고객 상담 및 모니터 요원","dJobICd":"M714","dJobICdNm":"[M714]시장조사 및 여론조사업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002618:1', '{"dJobCd":"K000002618","dJobCdSeq":"1","dJobNm":"귀농어귀촌상담사","workSum":"농어촌에 정착하려는 귀농어귀촌 희망자에게 안정적 정착을 위한 상담 및 지원서비스를 제공한다.","doWork":"귀농어귀촌 희망자의 질문을 듣고 답변사항, 요구정보 등을 파악한다. 희망자의 질문에 따라 사후주거, 일자리, 재무 등 귀농귀촌준비에서 실행에 이르기까지 필요한 정보를 제공하고 상담한다. 농업에 종사하려는 귀농자에게 지역적 환경, 농사에 적합한 품종, 농산물재배기술정보 수집방법, 지역주민과의 네트워크 형성방법, 농산물가공과 유통 및 판매에 대한 정보를 제공하고 상담한다. 관련 내용 중 보다 전문성을 요하는 경우 전문가와 연계해준다. 필요시 이들을 대상으로 교육을 하거나 각종 박람회 등을 지원하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"귀농귀촌상담사, 귀어귀촌상담사","dJobECd":"0292","dJobECdNm":"[0292]고객 상담원 및 모니터 요원","dJobJCd":"3991","dJobJCdNm":"[3991]고객 상담 및 모니터 요원","dJobICd":"O842","dJobICdNm":"[O842]사회 및 산업정책 행정","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004774:1', '{"dJobCd":"K000004774","dJobCdSeq":"1","dJobNm":"모니터요원(일반)","workSum":"방송프로그램, 제품, 홈페이지, 단체 등 모니터할 대상에 대하여 시청자나 소비자의 반응, 상품성, 서비스 수준 등을 살피고 문제점이나 제안사항을 파악해서 소견서를 작성한다.","doWork":"모니터할 대상에 대하여 설명을 듣거나 기초자료를 수집한다. 화면이나 라디오로 방송프로그램의 문제점 등을 모니터링한다. 출시 전의 제품을 직접 사용하거나 웹사이트 등을 직접 이용한 후 상품성을 평가하거나 문제점, 제안점 등을 제시한다. 매장을 직접 방문하여 진열된 제품에 대해 소비자의 반응, 진열상태, 서비스 수준 등을 파악한다. 모니터링한 제품에 대해 동향, 문제점, 개선점 등을 포함한 소견서를 작성한다. 제품의 반응이나 문제점 등을 파악하기 위해 설문조사나 시장조사를 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"청각|시각|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"모니터원","connectJob":"신문모니터요원, 잡지모니터요원, 웹사이트모니터요원, 기업모니터요원, 백화점모니터요원, 방송모니터요원","dJobECd":"0292","dJobECdNm":"[0292]고객 상담원 및 모니터 요원","dJobJCd":"3991","dJobJCdNm":"[3991]고객 상담 및 모니터 요원","dJobICd":"J602/M714","dJobICdNm":"[J602]텔레비전 방송업 / [M714]시장조사 및 여론조사업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004713:1', '{"dJobCd":"K000004713","dJobCdSeq":"1","dJobNm":"미스터리쇼퍼","workSum":"각종 매장을 방문하여 직원의 친절도, 상품지식, 청결상태 등을 고객의 입장에서 객관적으로 평가하는 일을 한다.","doWork":"평가 대상 매장의 특성과 점검해야 할 사항들을 확인한다. 해당 매장의 위치와 교통편, 직원 수, 판매상품, 기업의 서비스 정책 등을 파악한다. 매장을 방문하여 평가표의 항목에 따라 매장직원들의 서비스, 상품지식, 청결상태 등을 점검한다. 매장의 특성에 따라 동반자와 함께 방문하기도 한다. 신분노출에 주의하여 구체적인 가상시나리오에 맞게 상황을 준비한다. 사진을 찍거나 녹음 및 메모하기도 한다. 매장방문 후 결과보고서를 작성하여 제출한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"단순작업","similarNm":"MysteryShopper","dJobECd":"0292","dJobECdNm":"[0292]고객 상담원 및 모니터 요원","dJobJCd":"3991","dJobJCdNm":"[3991]고객 상담 및 모니터 요원","dJobICd":"M714","dJobICdNm":"[M714]시장조사 및 여론조사업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002473:1', '{"dJobCd":"K000002473","dJobCdSeq":"1","dJobNm":"방송모니터요원","workSum":"라디오 및 텔레비전 프로그램을 청취 또는 시청하면서 심의기준에 저촉되는 사항을 보고한다.","doWork":"방송심의기준 및 모니터링 요령을 파악한다. 정해진 시간대의 프로그램을 시청 또는 청취하여 프로그램의 내용에 대한 전반적인 내용과 심의일지를 작성한다. 심의기준에 위반된다고 판단되는 내용은 녹취 또는 녹화한다. 심의일지를 방송위원회에 제출하고 관련 회의에 참석한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"시범후 30일 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"방송심의원","dJobECd":"0292","dJobECdNm":"[0292]고객 상담원 및 모니터 요원","dJobJCd":"3991","dJobJCdNm":"[3991]고객 상담 및 모니터 요원","dJobICd":"J602","dJobICdNm":"[J602]텔레비전 방송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001694:1', '{"dJobCd":"K000001694","dJobCdSeq":"1","dJobNm":"병원코디네이터","workSum":"의료현장에서 근무 분위기 조성과 차별화된 서비스 제공으로 환자에게 신뢰감을 주고, 원내 이미지 개선을 위한 홍보 및 마케팅을 기획한다.","doWork":"전화, 메일 등으로 상담을 하고, 환자의 예약관리 및 사후관리를 한다. 내방객의 방문목적을 확인하고, 초진의 경우 문진항목 설문지를 작성하도록 안내한다. 진료를 마친 환자에게 치료에 대한 설명과 주의점, 처방전 등을 안내한다. 환자의 추후 내방에 관한 예약관리를 하며, 수납을 담당하기도 한다. 병원 분위기 연출을 위해 실내외 환경을 조성한다. 병원 이미지 및 경영 개선을 위한 기획안을 작성하고 홍보·마케팅을 한다. 병원 서비스 품질을 향상시키기 위한 직원 서비스 관리 및 교육을 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"병원서비스코디네이터, 의료코디네이터","connectJob":"의료관광코디네이터","certLic":"간호사, 간호조무사","dJobECd":"0292","dJobECdNm":"[0292]고객 상담원 및 모니터 요원","dJobJCd":"3991","dJobJCdNm":"[3991]고객 상담 및 모니터 요원","dJobICd":"Q861/Q862","dJobICdNm":"[Q861]병원 / [Q862]의원","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006057:1', '{"dJobCd":"K000006057","dJobCdSeq":"1","dJobNm":"사회보장보험민원상담원","workSum":"사회보장보험과 관련한 각종 질의에 대응하고 제도상담 및 안내를 한다.","doWork":"보험가입 이력 및 보험료 수납내역에 대해 안내한다. 보험료율 및 보험료에 대한 의문사항과 불만사항을 접수하고 응대하며 해석한다. 민원인의 요청 시 정기고지서를 재발급해준다. 자격, 보험료, 급여 관련 제신청, 신고서를 접수한다. 사회보장보험과 관련된 전화민원에 응대하고 보험제도에 대해 상담 및 안내를 한다. 각종 신청서를 접수하고 처리한다. 시정사항이 요구되는 특별한 민원의 경우 해당 부서에 민원내용을 통보한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0292","dJobECdNm":"[0292]고객 상담원 및 모니터 요원","dJobJCd":"3991","dJobJCdNm":"[3991]고객 상담 및 모니터 요원","dJobICd":"K651","dJobICdNm":"[K651]보험업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002039:1', '{"dJobCd":"K000002039","dJobCdSeq":"1","dJobNm":"인터넷통신상담원","workSum":"초고속통신망 이용고객의 이용관련 문의에 대하여 설명 및 상담한다.","doWork":"인터넷 관련 접속장애와 각종 통신 관련 프로그램설치법 및 하드웨어상의 문제를 고객으로부터 온라인상 또는 전화로 받아 기본지식을 이용하여 설명한다. 매뉴얼을 참조하여 설명한다. 설명이 어려운 경우에는 인터넷 관련 부서에 연락하여 담당자와 상의하도록 조치한다. 상담이 끝나면 상담내용을 씨티아이(CTI：Computer Telephone Integration)시스템에 메모를 한다. 상담고객의 수가 많은 경우에는 고객이 원하는 시간을 씨티아이시스템상에서 예약받고 예약되어진 시간에 전화를 걸어 상담을 하기도 한다. 가입희망고객에게 상품설명 및 요금설계를 하기도 한다. 해지요청고객에게 해지방어상담을 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"관련없음","connectJob":"인터넷업체상담원, 통신업체상담원","dJobECd":"0292","dJobECdNm":"[0292]고객 상담원 및 모니터 요원","dJobJCd":"3991","dJobJCdNm":"[3991]고객 상담 및 모니터 요원","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007684:1', '{"dJobCd":"K000007684","dJobCdSeq":"1","dJobNm":"전기차충전고객상담원","workSum":"전기차 충전 서비스의 원활한 제공을 위해 충전 방법, 충전소 위치, 충전기 동작 상태 확인 및 조치, 결제 및 로밍 등 전기차 사용 고객의 요구 사항에 응대하고 관련 사항을 안내한다.","doWork":"전기차의 충전절차, 충전기의 정상적 동작, 결제 시스템, 타 충전업체와의 로밍시스템 등을 전체적으로 이해하고 충전소 위치, 충전 방법, 요금제 등 전기차 충전과 관련된 다양한 문의를 전화, 이메일, 채팅 등을 통해 응대한다. 전기자동차 충전 고객의 요구 사항에 즉각적으로 대응하기 위해 충전기관리자 시스템에서 제공되는 충전기의 동작상태를 파악하는 등 전송되는 실시간 통신 데이터를 확인하고 분석한다. 이상이 발생하면 조치를 취하거나 관련 부서에 통보한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"전기차충전콜센터상담원","dJobECd":"0292","dJobECdNm":"[0292]고객 상담원 및 모니터 요원","dJobJCd":"3991","dJobJCdNm":"[3991]고객 상담 및 모니터 요원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2025"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005764:1', '{"dJobCd":"K000005764","dJobCdSeq":"1","dJobNm":"카드관리상담원","workSum":"신용카드 등 각종 카드회원의 다양한 요청사항을 접수하여 처리하는 제반 업무를 수행한다.","doWork":"전화 또는 회원의 내사를 통하여 요청사항을 접수한다. 신고된 접수내용은 유형별로 분류하여 회원정보사항 및 결재일자, 대금청구지, 청구내역, 도난 및 분실신고, 승인거래정지문의 등에 관련한 내용을 상담하며 단말기를 조작하여 등록·관리한다. 지점에서 송부된 회원관리점 변경신청서를 접수하고 단말기를 조작하여 관리점을 변경한다. 변경한 내용은 회원관리점 변경접수항목에 입력한다. 지점에서 송부한 불량거래 정보내용 및 발생해지요청을 접수하고 검토한 후, 회원번호, 연체 유무 등을 확인하여 단말기에 입력하여 해지한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0292","dJobECdNm":"[0292]고객 상담원 및 모니터 요원","dJobJCd":"3991","dJobJCdNm":"[3991]고객 상담 및 모니터 요원","dJobICd":"K641","dJobICdNm":"[K641]은행 및 저축기관","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004177:1', '{"dJobCd":"K000004177","dJobCdSeq":"1","dJobNm":"컨텍센터상담원","workSum":"컨텍센터에서 전화와 인터넷으로 접수된 고객서비스 안내, 텔레뱅킹, 고객상담, 텔레마케팅 등을 수행한다.","doWork":"고객요청사항에 대해서 지침서에 따라 응답한다. 전문적인 답변을 위해 전화를 담당자에게 연결한다. 고객의 불만사항을 온라인에서 처리한다. 시스템 오류 등에 대해 처치방안을 설명해 준다. 업무결과를 기록하는 등 일지를 작성한다. 업무를 교대할 때 업무 인수인계를 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"전화고객상담원","connectJob":"콜센터매니저, 인바운드텔레마케터, 학원상담원, 유학상담원, 이민상담원, 학습지상담원, 학습매니저, 교육코디네이터, 학원코디네이터, 금융고객상담원, 보험고객상담원, 국민연금상담원, 건강보험상담원, 고용보험상담원, 산재보험상담원, 부동산상담원, 여행사상담원, 항공사상담원, 예식상담원, 놀이시설상담원, 스포츠센터상담원, 홈쇼핑상담원, 인터넷쇼핑몰상담원, 택배상담원, 운송상담원, 백화점상담원, 대형마트상담원, AS상담원, 고장상담원, 가전고장상담원, 소비자상담원, 고장문의상담원, 무선통신고객상담원, 초고속통신고객상담원, 의료고객상담원, 민원고객상담원","dJobECd":"0292","dJobECdNm":"[0292]고객 상담원 및 모니터 요원","dJobJCd":"3991","dJobJCdNm":"[3991]고객 상담 및 모니터 요원","dJobICd":"N759","dJobICdNm":"[N759]기타 사업지원 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006279:1', '{"dJobCd":"K000006279","dJobCdSeq":"1","dJobNm":"컴퓨터고장상담원","workSum":"전화를 통하여 컴퓨터고장 등에 대한 고객의 문의에 답변하고, 고장수리요청을 접수한다.","doWork":"전화, 모바일기기톡 등 고객의 요청에 고장문의에 대해 조치사항 등을 자세히 답변을 해준다. 고객과의 상담 시 전화로 해결할 수 없는 사항에 대해서는 관련 사항을 접수하여 컴퓨터수리원이 방문수리를 하도록 처리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"컴퓨터고객센터요원, 컴퓨터고장상담원","dJobECd":"0292","dJobECdNm":"[0292]고객 상담원 및 모니터 요원","dJobJCd":"3991","dJobJCdNm":"[3991]고객 상담 및 모니터 요원","dJobICd":"S951","dJobICdNm":"[S951]컴퓨터 및 통신장비 수리업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005295:1', '{"dJobCd":"K000005295","dJobCdSeq":"1","dJobNm":"통신서비스요금상담원","workSum":"통신서비스 이용자의 전화요금의 문의내용을 확인한다.","doWork":"전화문의에 응대를 한다. 가입자의 인적사항에 따라 컴퓨터상 요금의 청구내역을 확인한다. 해당 이용자의 요금부과에 부당성의 이의제기가 있으면 처리기준에 따라 매출취소 및 환불을 한다. 적용이 되지 않는 경우는 상황을 서면으로 작성을 하여 관리자에게 전달한다. 요금체계 및 사용내역에 대하여 설명하거나 고객이 불편에 의해 해지를 요구할 경우 해지방어 안내를 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"관련없음","connectJob":"무선통신요금상담원, 가입상담원","dJobECd":"0292","dJobECdNm":"[0292]고객 상담원 및 모니터 요원","dJobJCd":"3991","dJobJCdNm":"[3991]고객 상담 및 모니터 요원","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003232:1', '{"dJobCd":"K000003232","dJobCdSeq":"1","dJobNm":"행정민원상담사무원","workSum":"민원인에게 행정서류 작성법을 알려주고, 작성된 민원서류를 검토하여 미비점과 보완점을 조언한다.","doWork":"행정서류를 신청한 민원인과 신청에 대해 면담한다. 구비서류와 신청양식의 기록요령을 설명한다. 작성서류를 검토하여 보완사항을 알려준다. 행정서류를 발급하는 장소 등을 알려준다. 전화로 행정서류 발급과 관련된 민원을 처리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"시범후 30일 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"관련없음","similarNm":"민원상담사무원, 민원상담원","dJobECd":"0292","dJobECdNm":"[0292]고객 상담원 및 모니터 요원","dJobJCd":"3991","dJobJCdNm":"[3991]고객 상담 및 모니터 요원","dJobICd":"O841","dJobICdNm":"[O841]입법 및 일반 정부 행정","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004225:1', '{"dJobCd":"K000004225","dJobCdSeq":"1","dJobNm":"회원관리원","workSum":"오락시설이나 특정 강습에 참가하려는 참가자를 모집하고 각종 회원관리업무를 수행한다.","doWork":"각종 강습회의 기간, 장소, 회비에 관한 내용을 계획하고 회원에게 통보한다. 회원을 모집하기 위하여 팸플릿, 광고전단 등을 이용하여 광고나 홍보를 한다. 회원을 대상으로 한 이벤트 개최, 문화강좌, 회원의 탈퇴 및 명의변경(회원증 양도), 회원증 재발급, 취득세 관련 세무업무, 회원 건의사항 처리 등의 회원관리업무를 수행 또는 지원한다. 회의소식을 회원들에게 전달한다. 강습회의 강사를 섭외하기도 한다. 회원모집 및 기타 스포츠센터운영에 관련한 상담에 응하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"설득","workFunc3":"관련없음","dJobECd":"0292","dJobECdNm":"[0292]고객 상담원 및 모니터 요원","dJobJCd":"3991","dJobJCdNm":"[3991]고객 상담 및 모니터 요원","dJobICd":"R911/R912","dJobICdNm":"[R911]스포츠 서비스업 / [R912]유원지 및 기타 오락관련 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001285:1', '{"dJobCd":"K000001285","dJobCdSeq":"1","dJobNm":"건설도서관리자","workSum":"건설공사도면 및 문서 등의 건설관련 자료들을 유지·관리하는 사무원과 도서관리시스템을 관리·담당하는 사무원의 활동을 관리·감독한다.","doWork":"건설관련 자료에 대한 조사, 수집, 분석 및 도서관리시스템에 대한 계획을 수립한다. 기존 자료의 상태를 검사하고 건설관련 기술정보 및 도서자료에 대하여 가치를 검토하여 영구보존할 자료를 선정한다. 각종 건설도서를 NAS, FTP 등으로 구축하거나 웹하드 등에 보관하기 위하여 자료를 수집·조사·분석하는 사무원의 활동을 관리·감독한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","similarNm":"공사도서관리자","dJobECd":"0299","dJobECdNm":"[0299]기타 사무원","dJobJCd":"3999","dJobJCdNm":"[3999]기타 사무원","dJobICd":"F411/F412/F421","dJobICdNm":"[F411]건물 건설업 / [F412]토목 건설업 / [F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004823:1', '{"dJobCd":"K000004823","dJobCdSeq":"1","dJobNm":"건설자료관리사무원","workSum":"건설공사도면 및 문서 등의 건설 관련 자료들을 대상으로 영구 또는 반영구 보존자료로 제작을 의뢰하고 관리하는 일을 한다.","doWork":"입찰결과 낙찰된 공사 관련 문서 및 도면, 시공한 준공정산서, 준공도면 및 관련 문서, 기타 자산가치로 영구보존할 문서 등으로 분류한다. 보관매체를 결정하여 건설자료관리자에게 보고한다. 결정에 따라 전문업자에게 제작을 의뢰하고 제작된 제품의 품질상태를 검사한다. 각종 자료 중 도면은 건축, 기계, 토목, 전기 등의 순서로 분류하고 문서는 규정된 표준문서분류체계에 의해 분류하여 정리·보관한다. 도면관리프로그램을 통해 도면파일을 분류하고 접근, 수정, 배포 등의 권한을 관리한다. 각종 건설 관련 기술자료, 도서, 문서 등의 자료들을 정리·분류하고 웹하드, 서버 등에 보관하고 관리한다. 보존기간에 맞춰 파기할 자료의 목록을 관리자에게 보고 후 파기한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"단순작업","similarNm":"공사자료관리사무원","dJobECd":"0299","dJobECdNm":"[0299]기타 사무원","dJobJCd":"3999","dJobJCdNm":"[3999]기타 사무원","dJobICd":"F411/F412/F421","dJobICdNm":"[F411]건물 건설업 / [F412]토목 건설업 / [F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004192:1', '{"dJobCd":"K000004192","dJobCdSeq":"1","dJobNm":"건설자료구축사무원","workSum":"건설공사도면, 문서 및 자료를 수집하여 필요로 하는 관련 사무원 및 기술자에게 정보를 제공하기 위하여 자료를 정리·입력한다.","doWork":"건설 관련 기술동향이나 토목기술 등을 일간지, 정기간행물 및 건설전문지 등에서 자료를 수집·분석·가공하여 입력한다. 구축된 자료나 정보를 관련 기술자나 사무원이 원활하게 사용하기 위하여 시스템을 운영한다. 새로운 자료를 추가하고 불필요한 자료를 삭제하여 자료의 효율성을 높인다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"단순작업","dJobECd":"0299","dJobECdNm":"[0299]기타 사무원","dJobJCd":"3999","dJobJCdNm":"[3999]기타 사무원","dJobICd":"F411/F412/F421","dJobICdNm":"[F411]건물 건설업 / [F412]토목 건설업 / [F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004425:1', '{"dJobCd":"K000004425","dJobCdSeq":"1","dJobNm":"경기예상지발행원","workSum":"경마 또는 경륜고객에게 경기정보와 우승후보를 알려주는 예상지를 발행한다.","doWork":"경마의 경우 출주마의 출전번호, 마명, 조교사, 기수명, 전적 및 질병기록 등을 경륜의 경우 출주자전거의 기아배수, 선수명, 나이, 성별, 우승경력, 입상전법 등의 정보를 수집·조사하여 우승후보를 예측한다. 마권 또는 경주권(승자투표권)의 구입, 승식, 환급과 관련된 자료를 수집하여 원고를 작성한다. 준비된 원고로 예상지를 인쇄하여 고객에게 배포한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"관련없음","connectJob":"경륜예상지발행원, 경마예상지발행원","dJobECd":"0299","dJobECdNm":"[0299]기타 사무원","dJobJCd":"3999","dJobJCdNm":"[3999]기타 사무원","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005197:1', '{"dJobCd":"K000005197","dJobCdSeq":"1","dJobNm":"광고지면사무원","workSum":"신문, 잡지 등의 각종 출판물에 게재할 광고를 광고의뢰서의 주문내용에 맞게 배치하기 위하여 출판물의 지면을 관리한다.","doWork":"광고할 내용을 파악하기 위하여 고객의 광고의뢰서를 검토한다. 광고의 형식에 따라 기사광고, 삽화광고, 의장광고, 안내광고를 구분하고 적절한 게재위치(제자하, 제자옆, 기사중, 돌출, 박스 등)를 선정한다. 광고의 배치를 위하여 컴퓨터의 화면이나 견본종이 위에 그린다. 같은 지면에 경쟁적인 동종의 광고를 피하고 균형을 유지하여 광고를 배열한다. 구인광고 등과 같은 간단한 광고문안을 작성하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"관련없음","dJobECd":"0299","dJobECdNm":"[0299]기타 사무원","dJobJCd":"3999","dJobJCdNm":"[3999]기타 사무원","dJobICd":"J581","dJobICdNm":"[J581]서적, 잡지 및 기타 인쇄물 출판업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003241:1', '{"dJobCd":"K000003241","dJobCdSeq":"1","dJobNm":"도서출납원","workSum":"출납도서를 서가에 배열하고 도서가 훼손되지 않도록 정돈·관리한다.","doWork":"대출담당사서로부터 받은 대출신청서를 보고 서가에서 도서를 인출한다. 반납도서와 신규도서를 분류하여 청구기호 순으로 서가에 배열한다. 도서의 소재를 파악하고 잘못 배열된 도서를 확인하여 재배열한다. 훼손된 도서를 분류하여 간이제본기를 사용하여 제본한다. 도서의 훼손을 방지하기 위하여 온도 및 습도를 점검·조절하고 먼지를 제거한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"서비스제공","workFunc3":"단순작업","connectJob":"도서정리사무원","dJobECd":"0299","dJobECdNm":"[0299]기타 사무원","dJobJCd":"3999","dJobJCdNm":"[3999]기타 사무원","dJobICd":"R902","dJobICdNm":"[R902]도서관, 사적지 및 유사 여가관련 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006573:1', '{"dJobCd":"K000006573","dJobCdSeq":"1","dJobNm":"디지털장의사","workSum":"의뢰에 따라 개인이 원하지 않는 인터넷 게시물, 사진, 영상 등을 분석하고 삭제를 요청하고 삭제여부를 모니터링한다.","doWork":"온라인정보 삭제를 요청하는 의뢰인 상담하고 계약을 체결한다. 의뢰인의 고충, 유출경위 등을 파악하고 삭제를 원하는 데이터의 종류, ID, 타인의 도용사례 등을 확인한다. 데이터검색프로그램을 사용하거나, 키워드 검색, 유출사이트 가입 등의 방법으로 온라인상에 유출된 정보(얼굴, 음성, 주민번호, 주소, 전화번호, 학교, 이름, 동영상, 사진, 비방게시물 등)를 수집한다. 데이터의 출처 표기, 부정적·긍정적 분류, 삭제 가능 여부 확인 등의 작업을 수행하고 보고서를 작성한다. 삭제할 데이터가 게시된 사이트의 관리자에게 삭제를 요청하고 삭제결과를 모니터링한다. 삭제기록 및 작업내역을 분석하여 보고서를 작성하고 의뢰인에게 제출한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"서비스제공","workFunc3":"제어조작","dJobECd":"0299","dJobECdNm":"[0299]기타 사무원","dJobJCd":"3999","dJobJCdNm":"[3999]기타 사무원","dJobICd":"J639","dJobICdNm":"[J639]기타 정보 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004235:1', '{"dJobCd":"K000004235","dJobCdSeq":"1","dJobNm":"마이크로필름편집원","workSum":"문서, 도면, 자료 등 대량의 기록물을 정리, 보관 및 정보관리 등의 도구로 이용하기 위하여 마이크로 사진상을 가진 필름용 카메라로 촬영하기 전 또는 촬영한 후 편집한다.","doWork":"의뢰한 각종 도면·문서·자료를 인수받아 롤(Roll:한통의 필름에 들어갈 수 있는 자료의 분량)별로 도서를 촬영하기 쉽도록 순서를 나열하고 롤번호(Roll Number)를 부여하여 순서가 뒤바뀌지 않도록 편집을 한다. 촬영이 끝나면 롤형필름을 촬영순서대로 편집기에 내장하여 연결시키고 알맞는 규격의 편집용 카드를 기계에 내장한다. 편집기의 기능부를 조절하고 전원스위치를 넣는다. 애퍼츄어카드(Aperture Card)의 경우 편집카드에 한장씩 잘려서 부착된 필름을 리더기를 이용하여 리스트와 대조하고 프로젝트별로 카드를 분류한다. 분류카드를 복제하여 보관하고, 카드와 목록은 의뢰자에게 전해준다. 현상된 롤형마이크로필름을 목록내용과 비교·검토하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"기록","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"도서필름편집원","dJobECd":"0299","dJobECdNm":"[0299]기타 사무원","dJobJCd":"3999","dJobJCdNm":"[3999]기타 사무원","dJobICd":"C182","dJobICdNm":"[C182]기록매체 복제업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002999:1', '{"dJobCd":"K000002999","dJobCdSeq":"1","dJobNm":"부동산중개보조원","workSum":"중개대상물에 대한 현장안내 및 일반서무 등 중개업자의 중개업무와 관련된 업무를 지원한다.","doWork":"중개대상물에 대해 현장안내업무를 한다. 중개업소에서 필요한 일반서무업무를 한다. 기타 부동산중개업자, 부동산중개인만이 할 수 있는 법적 업무 외의 기타업무를 한다. 온라인, 오프라인을 통해 매물임장(현장조사)을 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"단순작업","similarNm":"중개보조원","dJobECd":"0299","dJobECdNm":"[0299]기타 사무원","dJobJCd":"3999","dJobJCdNm":"[3999]기타 사무원","dJobICd":"L682","dJobICdNm":"[L682]부동산 관련 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003502:1', '{"dJobCd":"K000003502","dJobCdSeq":"1","dJobNm":"수필속기사","workSum":"법원, 의회, 주주총회 등에서 발언내용을 속기용 기호를 이용하여 받아쓰고 평상문자로 번역하여 문서로 작성한다.","doWork":"속기대상 분야의 전문용어에 대해서 학습한다. 단독 또는 공동으로 발언자의 말을 들으며 정확하게 발언내용을 수기부호로 수기 또는 속기타자기로 기록한다. 발언내용이 담겨진 녹음테이프나 공동작업자가 있을 경우 서로의 번역문을 대조하여 속기내용을 다시 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"청각|손사용|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"0299","dJobECdNm":"[0299]기타 사무원","dJobJCd":"3999","dJobJCdNm":"[3999]기타 사무원","dJobICd":"N759","dJobICdNm":"[N759]기타 사업지원 서비스업","inqYear":"2021","etc":"컴퓨터속기 확산으로 수필속기 소멸에 따라 컴퓨터속기사로 통합"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002058:1', '{"dJobCd":"K000002058","dJobCdSeq":"1","dJobNm":"전당포관리자","workSum":"담보물로 제공된 재화(귀금속, 명품, IT기기 등 주로 유체동산)의 가치를 평가하고 그 물건을 담보로 돈을 빌려준다.","doWork":"담보가 될 물품의 상태 및 가치를 측정한다. 즉시 측정하기 어려운 담보물은 관계자에게 유선상으로 가치를 확인한다. 담보가치에 따라 돈을 빌려주고 전당표를 발행하며 대부금을 기록한다. 담보물을 회수해 갈 때 이자를 계산하고 빌려준 대금을 이자와 함께 받는다. 일정기간 내에 찾아가지 않는 담보물은 법률 및 계약 사항에 따라 매각한다. 고객의 신분을 검토하거나 도난물품과 관계된 법정소송에서 증언하기도 한다. 신변의 보호를 위하여 보안 및 안전장치를 운용한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"조정","workFunc2":"설득","workFunc3":"관련없음","dJobECd":"0299","dJobECdNm":"[0299]기타 사무원","dJobJCd":"3999","dJobJCdNm":"[3999]기타 사무원","dJobICd":"K649","dJobICdNm":"[K649]기타 금융업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003439:1', '{"dJobCd":"K000003439","dJobCdSeq":"1","dJobNm":"점자교정사","workSum":"점자로 출력된 자료나 점자 파일을 원본 자료와 대조하여 오기, 누락, 첨가 등 오류를 수정하고, 한국 점자 규정과 한글맞춤법에 의거하여 교정한다.","doWork":"원본 자료와 점역본을 대조하기 위하여 비시각장애인과 함께 어문출판물 또는 인쇄물을 낭독하면서 동시에 확인한다. 점역본의 오자 및 누락된 내용을 표준교정부호를 사용하여 표시한 후 수정하도록 하거나, 점자정보단말기 및 점자편집프로그램을 이용하여 잘못된 내용을 바로 수정한다. 점자를 묵자(일반 글자)로 옮기기도 한다. 점자촉지도, 점자안내판 등의 편의시설을 점검한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"점역교정사, 점자교정원","dJobECd":"0299","dJobECdNm":"[0299]기타 사무원","dJobJCd":"3999","dJobJCdNm":"[3999]기타 사무원","dJobICd":"J581","dJobICdNm":"[J581]서적, 잡지 및 기타 인쇄물 출판업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007453:1', '{"dJobCd":"K000007453","dJobCdSeq":"1","dJobNm":"취업알선원","workSum":"구인 및 구직자를 대상으로 구인 및 구직 신청을 접수하고 취업을 알선하며 취업 관련 사항을 안내한다.","doWork":"구인 및 구직 신청을 접수하고 전산프로그램에 해당 내용을 입력한다. 취업과 관련한 현황에 대해 설명한다. 실업급여, 고용보험 등 각종 실업과 취업에 관련된 정부 지원 제도와 정책에 대해 설명한다. 기타 취업 관련 질의에 응답한다. 구인자와 구직자를 매칭하여 구직자를 알선한다. 취업 후 사후 관리를 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"취업상담원, 직업소개원, 직업안내원","certLic":"직업상담사(1급, 2급)","dJobECd":"0299","dJobECdNm":"[0299]기타 사무원","dJobJCd":"3999","dJobJCdNm":"[3999]기타 사무원","dJobICd":"N751","dJobICdNm":"[N751]고용알선 및 인력공급업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001545:1', '{"dJobCd":"K000001545","dJobCdSeq":"1","dJobNm":"컴퓨터속기사","workSum":"법원, 기업의 주주총회 및 이사회, 국회, 지방의회, 자막방송 등에서 회의 및 발언내용을 속기용 자판으로 기록한다.","doWork":"속기대상 분야의 관련 용어에 대해 미리 파악한다. 발언내용을 정확히 듣고 타이핑하여 기록한다. 속기록이 끝나면 컴퓨터에 저장된 문서를 수정·편집한다. 완성된 내용을 파일형태나 문서로 제출한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"청각|손사용|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"한글속기(1급, 2급, 3급)","dJobECd":"0299","dJobECdNm":"[0299]기타 사무원","dJobJCd":"3999","dJobJCdNm":"[3999]기타 사무원","dJobICd":"N759","dJobICdNm":"[N759]기타 사업지원 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003145:1', '{"dJobCd":"K000003145","dJobCdSeq":"1","dJobNm":"편집보조원","workSum":"신문, 서적 등의 인쇄, 출판을 위한 인쇄자료를 준비하고 편집업무를 수행한다.","doWork":"원고 또는 사본을 읽고 철자, 구두점, 문법 및 주문사항과 비교하여 잘못된 곳을 교정한다. 출판양식과 편집방침을 준수하기 위하여 사본을 다시 쓰거나 교정하고 표준부호를 사용하여 표시한다. 지면이나 주제에 맞추어 사건 및 도해 자료, 사진 등을 선정한다. 편집 또는 출판 담당자의 지시에 따라 기사, 삽화 등의 지면 위치를 조정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"단순작업","similarNm":"맥편집원, DTP편집원","connectJob":"전자출판편집원, 자료편집사무원, 교열원, 잡지편집사무원","dJobECd":"0299","dJobECdNm":"[0299]기타 사무원","dJobJCd":"3999","dJobJCdNm":"[3999]기타 사무원","dJobICd":"J581","dJobICdNm":"[J581]서적, 잡지 및 기타 인쇄물 출판업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002394:1', '{"dJobCd":"K000002394","dJobCdSeq":"1","dJobNm":"편집자료관리원","workSum":"자사 및 타사의 신문 기사, 광고, 삽화 및 관련 자료를 목적과 종류에 따라 수집·편집·보관한다.","doWork":"자사 및 타사의 신문 기사 및 정보, 기사 관련 자료, 자사 신문의 원본사진 및 기타 책자 등의 자료를 수집한다. 수집된 자료 및 정보를 분류목적 및 방법에 따라 사용하기 편리하게 편집하여 보관한다. 자료에 대한 정보를 쉽게 이용할 수 있도록 PDF 또는 디지털파일  등의 전자문서로 정리하여 웹서버 등에 보관한다. 자료요구 시 검색이 가능하도록 자료에 관한 사항을 정리하고 관리한다. 정해진 기간이나 지시에 따라 오래되거나 필요 없는 자료를 폐기처분한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"단순작업","dJobECd":"0299","dJobECdNm":"[0299]기타 사무원","dJobJCd":"3999","dJobJCdNm":"[3999]기타 사무원","dJobICd":"J581","dJobICdNm":"[J581]서적, 잡지 및 기타 인쇄물 출판업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005177:1', '{"dJobCd":"K000005177","dJobCdSeq":"1","dJobNm":"폐차대행원","workSum":"소비자로부터 전화 또는 인터넷으로 폐차신청을 받고 이와 관련된 원부조회, 견인, 현금지급, 말소신청의 업무를 대행한다.","doWork":"전화 또는 인터넷을 통하여 폐차신청을 받는다. 해당 차량에 대한 차량위치, 차종, 차량번호 등에 관한 정보를 입수한 후 압류 및 저당 여부를 확인한다. 관련된 문제를 해결해 주기도 하며, 이상이 없는 차량을 견인하고 폐차에 관련된 구비서류를 접수한다. 견인완료 후 차주에게 차량에 대한 대금을 지급한다. 말소등록을 완료한 후 차주에게 말소증명서를 송부한다. 보험해지 및 승계에 관련된 업무를 처리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0299","dJobECdNm":"[0299]기타 사무원","dJobJCd":"3999","dJobJCdNm":"[3999]기타 사무원","dJobICd":"G451","dJobICdNm":"[G451]자동차 판매업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007407:1', '{"dJobCd":"K000007407","dJobCdSeq":"1","dJobNm":"해외취업관리자","workSum":"내국인이 해외에서 일자리를 가질 수 있도록 구인처를 탐색, 발굴하고 알선하며 해외취업 이후 사후관리까지의 전반적인 과정을 운영, 관리 및 지원한다.","doWork":"해외취업 정보 수집을 계획하고 정보 채널을 확보하며 필요한 정보를 분석하여 데이터베이스를 구축한다. 해외취업 사업 타당성을 검토하고 사업 전략 및 실행 계획을 수립하여 구체적인 사업 계획서를 작성한다. 해외취업을 희망하는 구직자에게 검증된 구인처를 제공하기 위한 발굴전략을 수립하고 수행한다. 해외취업을 희망하는 구직자 모집전략을 수립하여 희망구직자를 모집한 뒤 지원대상을 선발하고 그들에 대한 데이터베이스를 구축한다. 해외취업을 희망하는 구직자를 위해 컨설팅계획을 수립하여 구직자의 역량을 진단하고 경력개발계획을 수립한다. 구직자 해외취업을 위하여 교육훈련 계획 수립, 과정 설계, 운영 후 이를 모니터링하고 평가한다. 해외취업관련 정보를 토대로 알선계획을 수립하여 해외취업을 원하는 구직자를 해외구인처에 소개하고 해외구인처가 필요한 인재를 채용할 수 있도록 과정을 관리하고 지원한다. 해외취업자 출국 전 사전교육을 운영하고, 출국 전 체크리스트를 작성하여 그에 따라 필요한 사항을 지원하며, 해외취업자의 현지 연락체계를 구축한다. 고용계약의 이행여부 확인 및 취업만족도 조사를 기초로, 해외취업 사례관리와 해외취업자의 근로코칭을 실시한다. 구직자의 해외취업을 효율적으로 지원하는데 필요한 정부지원제도를 활용하고, 재무 관리 및 홍보를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0299","dJobECdNm":"[0299]기타 사무원","dJobJCd":"3999","dJobJCdNm":"[3999]기타 사무원","dJobICd":"N751","dJobICdNm":"[N751]고용알선 및 인력공급업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007524:1', '{"dJobCd":"K000007524","dJobCdSeq":"1","dJobNm":"행정사","workSum":"관련 법령에 따라 의뢰인의 위임을 받아 행정기관에 제출하는 서류와 권리·의무 또는 사실증명에 관한 타인의 문서를 작성하고 행정 관계 법령에 대한 상담과 자문 업무를 수행한다.","doWork":"관련 법령에 따라 의뢰인의 위임을 받아 각종 계약서, 사업계획서, 정관, 답변서, 보고서, 청원서, 진정서, 의견서, 건의문, 청구서, 호소문, 추천서, 이력서, 권리·의무 또는 사실증명에 관한 타인의 문서 등을 작성한다. 국회사무처, 헌법재판소사무처, 중앙선거관리위원회사무처, 각급선거관리위원회사무처, 노동위원회, 노동청, 근로복지공단, 고위공직자범죄수사처, 세관, 경찰서, 국방부, 해양안전심판원 등의 행정기관에 제출하는 청원서, 진정서, 진술서, 확인서, 의견서, 이의신청서, 행정심판청구서 등을 작성한다. 사실확인증명서와 이해관계사실확인서를 발급한다. 인가, 허가, 인증, 고충민원 등의 대리업무를 수행한다. 행정관계 법령과 행정에 대한 상담과 자문 업무를 수행한다. 외국어 번역 업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"행정대리인","connectJob":"일반행정사, 기술행정사, 외국어번역행정사","certLic":"행정사","dJobECd":"0299","dJobECdNm":"[0299]기타 사무원","dJobJCd":"3999","dJobJCdNm":"[3999]기타 사무원","dJobICd":"M711","dJobICdNm":"[M711]법무관련 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006086:1', '{"dJobCd":"K000006086","dJobCdSeq":"1","dJobNm":"거짓말탐지검사관","workSum":"거짓말탐지기와 표준화된 기법을 사용하여 용의자나 피해자, 증인을 조사하고 진술의 거짓 여부를 판별한다.","doWork":"경찰이나 법원에서 사건을 의뢰받고 사건의 경위, 관련 대상자 신상 등을 파악한다. 사건 당사자와의 면담을 통해서 사건의 경위를 확인하고 질문 등을 최종적으로 결정한다. 용의자, 목격자 등 대상자에게 거짓말탐지기를 부착하고, 질문을 한다. 진술 시 호흡, 피부전기반사, 혈압, 맥박 등의 변화를 측정하고, 기록을 토대로 개인의 반응을 해석하고 진단한다. 사건의 목적, 조사방법, 조사결과, 조사자의 의견 등이 포함된 결과통보서를 작성한다. 거짓말감정 결과의 설명을 위해서 법원에 출두한다. 거짓말탐지기법, 방법론, 사용방법 등에 대해 강의를 하기도 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"수동조작","dJobECd":"2401","dJobECdNm":"[2401]경찰관 및 수사관","dJobJCd":"4111","dJobJCdNm":"[4111]경찰관 및 수사관","dJobICd":"O844","dJobICdNm":"[O844]사법 및 공공질서 행정","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007175:1', '{"dJobCd":"K000007175","dJobCdSeq":"1","dJobNm":"검시조사관","workSum":"생물학·해부학·병리학 등 전문 지식을 바탕으로 변사자 및 그 주변 환경을 종합적으로 조사하여 범죄 관련 여부를 판단한다.","doWork":"살인·변사 사건 현장에 임장하여 변사자의 신원 파악부터 사망 기전, 원인, 시간, 범죄와의 연관성 등을 조사한다. 조사 결과를 보고서로 작성하여 사건수사팀에 제공한다. 검안의(檢案醫)·부검의(剖檢醫)에게 변사자 검시자료를 통보하여 정확한 사인 규명을 위해 협력한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","certLic":"임상병리사, 간호사","dJobECd":"2401","dJobECdNm":"[2401]경찰관 및 수사관","dJobJCd":"4111","dJobJCdNm":"[4111]경찰관 및 수사관","dJobICd":"O844","dJobICdNm":"[O844]사법 및 공공질서 행정","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003264:1', '{"dJobCd":"K000003264","dJobCdSeq":"1","dJobNm":"검찰수사관","workSum":"검사를 보조하여 피의자를 신문하고, 벌금집행, 수사, 압수수색, 사건수리, 형의집행 등을 한다.","doWork":"각종 사건 사고를 수사한다(마약, 강력, 방화, 실화, 조직폭력, 사행행위, 특수, 공안, 외사, 증권, 금융, 지적재산권, 조세, 관세, 공정거래, 부동산, 의약, 식품, 환경, 소년, 보호관찰, 교육, 국가유산, 가정폭력, 피해자지원 등에 관한 사항). 검사장이 명하는 범죄사건, 고소, 고발, 진정사건 및 이와 관련된 사건을 수사한다. 사건, 진정내사사건, 영장접수, 압수금품에 관해 접수·처리한다. 범죄정보를 수집하고, 공안업무를 지원한다. 수사를 지휘하고, 검찰사무보고를 한다. 공판, 형집행 및 보호처분, 가납재판 집행, 수형인명부 작성 및 수형 통지, 판결원본 및 사건기록의 보존·관리에 관한 사항을 처리한다. 마약범죄를 수사하고, 마약, 향정신성 의약품 및 마약의 유통을 단속한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"검찰마약수사관","dJobECd":"2401","dJobECdNm":"[2401]경찰관 및 수사관","dJobJCd":"4111","dJobJCdNm":"[4111]경찰관 및 수사관","dJobICd":"O844","dJobICdNm":"[O844]사법 및 공공질서 행정","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007521:1', '{"dJobCd":"K000007521","dJobCdSeq":"1","dJobNm":"경찰관","workSum":"사회 안정과 민생 치안을 위해 법률과 질서를 유지하고 위험으로부터 인명과 재산을 보호하며 범죄를 예방하고 범죄자를 진압한다.","doWork":"각종 안전사고, 교통사고를 예방하기 위해 사고의 원인이 되는 위반 행위를 지도하고 단속한다. 비행 청소년의 선도, 청소년 유해 업소와 기초질서 위반자 등을 단속하고, 여성 및 어린이 범죄 단속, 마약 사범 검거, 불법체류 및 불법취업 단속, 컴퓨터 범죄 단속, 환경사범 단속 및 국제조직범죄와 연계된 각종 밀수범죄 단속 등을 한다. 각종 안내 및 주민 신고접수, 고소 및 고발 등의 민원상담도 한다. 특수경찰관의 경우는 테러 및 폭력시위 진압, 해양경비, 각종 사이버범죄 단속, 마약사범 검거, 밀수범죄 단속, 환경사범 단속, 외국인범죄 단속, 불법체류·불법취업 등 출입국사범 단속, 경제 및 환경사범 단속 등의 업무를 수행한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|고온|저온|다습|소음·진동|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"수동조작","connectJob":"과학수사관, 사이버수사관, 철도경찰관, 경찰특공대, 생활안전경찰관, 수사경찰관, 여성청소년경찰관, 정보경찰관, 보안경찰관, 도로교통경찰관, 외사경찰","dJobECd":"2401","dJobECdNm":"[2401]경찰관 및 수사관","dJobJCd":"4111","dJobJCdNm":"[4111]경찰관 및 수사관","dJobICd":"O844","dJobICdNm":"[O844]사법 및 공공질서 행정","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001924:1', '{"dJobCd":"K000001924","dJobCdSeq":"1","dJobNm":"국가산업보안전문가","workSum":"국내의 첨단기술을 보호하기 위하여 정보를 수집하고 정보유출을 방지한다.","doWork":"첨단기술을 보유한 기업체·연구소를 대상으로 정보수집 활동을 한다. 산업스파이를 적발하고 기밀유출에 관한 신고를 받는다. 산업보안 관련 정책 및 제도를 연구한다. 산업보안에 대한 의식을 고취시키기 위하여 보안교육을 실시한다. 해외사례를 수집하여 정보를 제공한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"협의","workFunc3":"관련없음","similarNm":"산업보안전문가","dJobECd":"2401","dJobECdNm":"[2401]경찰관 및 수사관","dJobJCd":"4111","dJobJCdNm":"[4111]경찰관 및 수사관","dJobICd":"O844","dJobICdNm":"[O844]사법 및 공공질서 행정","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003578:1', '{"dJobCd":"K000003578","dJobCdSeq":"1","dJobNm":"국제범죄전문가","workSum":"국제범죄의 예방 및 해결을 위해 정보를 수집하고 대처방안을 마련한다.","doWork":"마약, 위조화폐, 밀수, 밀입국 등에 대한 정보를 수집하고 검증한다. 수사가 필요할 경우 수사권을 가진 검찰 및 경찰에게 수사를 의뢰한다. 수사를 지원한다. 국제범죄조직의 국내 불법행위 관련 정보를 수집한다. 국제범죄조직의 활동을 제한한다. 각국 정보수사 기관과 정보를 교환한다. 경찰, 세관 등 유관기관에 국제범죄 대응활동을 교육한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"2401","dJobECdNm":"[2401]경찰관 및 수사관","dJobJCd":"4111","dJobJCdNm":"[4111]경찰관 및 수사관","dJobICd":"O844","dJobICdNm":"[O844]사법 및 공공질서 행정","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005010:1', '{"dJobCd":"K000005010","dJobCdSeq":"1","dJobNm":"몽타주제작전문가","workSum":"목격자의 진술을 토대로 사건 용의자의 얼굴을 제작한다.","doWork":"목격자와의 인터뷰를 통해 목격자의 심리상태를 파악한다. 목격자가 불안해하지 않도록 대화를 통해 친밀도를 높인다. 목격자에게 컴퓨터 화면을 이용해 얼굴을 이루는 코, 입, 눈, 머리 모양 등을 보여주며 몽타주를 작성한다. 완성된 얼굴모양을 목격자에게 보여주어 확인·수정한다. 최종 작성된 몽타주를 수사 담당 부서에 보낸다. 범인이 체포되었을 경우 작성된 몽타주와 비교하여 기록에 남긴다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"조작운전","similarNm":"몽타주제작자","dJobECd":"2401","dJobECdNm":"[2401]경찰관 및 수사관","dJobJCd":"4111","dJobJCdNm":"[4111]경찰관 및 수사관","dJobICd":"O844","dJobICdNm":"[O844]사법 및 공공질서 행정","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001334:1', '{"dJobCd":"K000001334","dJobCdSeq":"1","dJobNm":"범죄심리분석관","workSum":"심리적 외상, 정신적 충격 등 망각으로 사건 내용을 기억하지 목하는 목격자, 피해자 등을 대상으로 최면을 통해서 심리적 환경을 재구성하여 범죄해결에 필요한 증거, 단서 등을 밝힌다.","doWork":"분석 의뢰된 내용에 대해 사건경위, 사건 대상자의 상태 등을 파악하고 사건 의뢰자와 협의한다. 최면대상자와의 면담을 통해서 사건 경위 등에 대해서 다시 파악한다. 최면에 대해서 대상자에게 설명하고 최면을 건다. 최면과정을 비디오테이프 등으로 녹음·녹화한다. 최면대상자의 최면 능력, 최면 방법, 최면 결과, 담당자의 소견 등이 포함된 결과보고서를 작성한다. 최면과 관련하여 법정에서 증언을 한다. 경찰, 검찰 등 최면 관련 담당자들을 대상으로 강의를 하기도 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"범죄심리분석자, 범죄심리분석요원, 프로파일러","connectJob":"범죄심리학자","dJobECd":"2401","dJobECdNm":"[2401]경찰관 및 수사관","dJobJCd":"4111","dJobJCdNm":"[4111]경찰관 및 수사관","dJobICd":"O844","dJobICdNm":"[O844]사법 및 공공질서 행정","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006064:1', '{"dJobCd":"K000006064","dJobCdSeq":"1","dJobNm":"범죄영상분석가","workSum":"범죄에 연루된 영상물을 영상기기로 조작하고 분석함으로써 동일인 여부, 영상물조작 여부 등을 확인하고 영상물을 복원하거나 범죄자 체형 등을 재현한다.","doWork":"범죄에 연루된 영상물을 의뢰받고 사건의 경위, 요구사항 등을 파악한다. 수사관과 내용을 협의하거나 용의자를 촬영한다. 비디오계측시스템 등 영상기기를 사용하여 영상물을 복원하거나 선명도를 높여 차량번호 등 증거를 확보한다. 영상에 나타난 인물이 범인과 동일인인지 확인하기 위해 용의자를 촬영하고 영상기기 분석을 통해서 판단한다. 사고현장의 환경, 피해자 및 피의자의 위치 등을 포착하여 3차원으로 재구성한다. 분석된 자료를 토대로 사건의뢰 항목, 분석방법, 분석결과 등이 포함된 최종 결과보고서를 작성한다. 법적절차에 따라서 분석결과를 법정에서 증언한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"2401","dJobECdNm":"[2401]경찰관 및 수사관","dJobJCd":"4111","dJobJCdNm":"[4111]경찰관 및 수사관","dJobICd":"O844","dJobICdNm":"[O844]사법 및 공공질서 행정","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003548:1', '{"dJobCd":"K000003548","dJobCdSeq":"1","dJobNm":"사이버수사요원","workSum":"사이버 범죄를 포착하고 수사한다.","doWork":"해킹범죄에 대한 수사 및 바이러스, 웜 등 악성프로그램 유포범죄와 개인정보 수집, 피싱범죄 등 각종 사이버 범죄를 수사한다. 사기, 저작권법 위반, 주민등록법 위반 등 사이버 범죄를 수사한다. 사이버 범죄 예방을 위한 보안교육과 홍보업무 등 범죄 예방활동을 통해 국민 치안에 기여한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"협의","workFunc3":"정밀작업","similarNm":"사이버경찰관","dJobECd":"2401","dJobECdNm":"[2401]경찰관 및 수사관","dJobJCd":"4111","dJobJCdNm":"[4111]경찰관 및 수사관","dJobICd":"O844","dJobICdNm":"[O844]사법 및 공공질서 행정","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006231:1', '{"dJobCd":"K000006231","dJobCdSeq":"1","dJobNm":"피해자심리전문요원","workSum":"강력사건이 발생했을 때 현장에 출동해 피해자가 심리적 안정을 취하도록 지원한다.","doWork":"살인, 강도, 인질, 성폭력, 가정폭력, 학교폭력 등 사건이 발생하게 되면 피해자를 상담하고 상태를 분석한다. 피해자가 심리적 안정을 취하도록 한다. 전화, 방문상담, 심리검사 등을 통해 피해자의 치유를 돕는다. 지원이 필요하다고 판단이 되면 담당 형사가 각 지방경찰청 소속의 CARE(Crisis-intervention, Assistance, REsponse)팀으로 지원하도록 요청한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","dJobECd":"2401","dJobECdNm":"[2401]경찰관 및 수사관","dJobJCd":"4111","dJobJCdNm":"[4111]경찰관 및 수사관","dJobICd":"O844","dJobICdNm":"[O844]사법 및 공공질서 행정","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007540:1', '{"dJobCd":"K000007540","dJobCdSeq":"1","dJobNm":"해양경찰관","workSum":"바닷가 및 바다에서 일어나는 위험과 범법행위로부터 국민의 인명과 재산을 보호하며, 법률을 위반한 사람을 체포한다.","doWork":"함정을 타고 해역을 순항하며 해상에서의 조난사고를 예방한다. 외국선박을 감시하고 영해를 침범한 어선을 검색한다. 해난구조 헬기 등을 이용하여 악천후 상태에서 해상사고를 방지한다. 인명을 구조하고 재산을 지킨다. 선박 항해상의 모든 위험과 장해를 제거하고, 원활한 해상교통을 확보하여 안전사고를 예방한다. 바다 위에서 일어나는 해상범죄(강도, 절도, 밀입국, 밀수, 불법어업 등)을 단속하고 해상치안 질서를 유지한다. 선박 간의 충돌로 인해 발생한 해양오염을 방지하기 위한 조사 및 실험 업무를 수행한다. 해양오염 방지를 위해 유조선 등의 안전항로 준수 여부를 단속한다. 해상에서의 안전사고 예방을 위한 홍보활동을 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|손사용|","workEnv":"대기환경미흡|위험내재|고온|저온|다습|소음·진동|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"조작운전","similarNm":"해양경찰","connectJob":"해양경비통신경찰관, 해양안전경찰관, 해양오염관리경찰관, 해양정보경찰관, 해양수사경찰관, 해양경찰특공대","certLic":"항해사, 수상구조사","dJobECd":"2401","dJobECdNm":"[2401]경찰관 및 수사관","dJobJCd":"4111","dJobJCdNm":"[4111]경찰관 및 수사관","dJobICd":"O844","dJobICdNm":"[O844]사법 및 공공질서 행정","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002392:1', '{"dJobCd":"K000002392","dJobCdSeq":"1","dJobNm":"형사","workSum":"형사과, 수사과 등에서 정보수집, 용의자의 위치 추적, 검거 등의 전문적인 수사활동을 한다.","doWork":"고소, 고발, 신고, 첩보입수 등으로 수사단서를 파악한다. 피의자조사, 증거조사, 탐문수사를 한다. 용의자의 위치를 파악해 검거한다. 검거한 용의자를 취조한다. 범죄 사실이 밝혀지면 검찰에 구속영장 발부를 신청한다. 구속 수감된 용의자와 관련 사건자료를 검찰에 송치한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|고온|저온|다습|소음·진동|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"경찰관","dJobECd":"2401","dJobECdNm":"[2401]경찰관 및 수사관","dJobJCd":"4111","dJobJCdNm":"[4111]경찰관 및 수사관","dJobICd":"O844","dJobICdNm":"[O844]사법 및 공공질서 행정","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005746:1', '{"dJobCd":"K000005746","dJobCdSeq":"1","dJobNm":"가스생산기지소방대원","workSum":"가스 생산기지의 화재위험을 점검·예방하고 화재발생 시 초기에 화재진압을 한다.","doWork":"가스 생산기지 내의 화재감시용 모니터와 센서를 통해 제공되는 정보를 감시하여 화재 징후 및 이상 현상을 감시한다. 화재경보기, 소화장비 및 소방차의 작동상태를 점검하고 수리·교체한다. 가스누출, 배관용접 등 위험작업 시 현장에 출동하여 대비한다. 화재예방을 위해 순찰한다. 화재 진압 및 예방을 위한 직무교육을 실시한다. 기타 제반 소방업무를 수행한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|","workEnv":"대기환경미흡|위험내재|고온|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"유지","dJobECd":"2402","dJobECdNm":"[2402]소방관","dJobJCd":"4112","dJobJCdNm":"[4112]소방관","dJobICd":"D352","dJobICdNm":"[D352]연료용 가스 제조 및 배관공급업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002593:1', '{"dJobCd":"K000002593","dJobCdSeq":"1","dJobNm":"가스생산기지소방대장","workSum":"가스 생산기지의 화재위험을 점검·예방하고 화재발생 시 피해를 최소화하기 위하여 가스생산기지소방원의 활동을 관리·감독한다.","doWork":"생산기지 내의 소화기, 소화전 등 소화시설과 장비를 점검한다. 화재 취약지역에 대한 일일점검을 실시한다. 자체 소방계획을 수립한다. 직원들에게 소방교육을 실시한다. 자체 소방훈련 계획을 점검하고 실시한다. 화재발생 시 진화나 인명구조작업을 지휘한다. 기타 소방 관련 업무를 수행한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|","workEnv":"대기환경미흡|위험내재|고온|","workFunc1":"조정","workFunc2":"감독","workFunc3":"유지","dJobECd":"2402","dJobECdNm":"[2402]소방관","dJobJCd":"4112","dJobJCdNm":"[4112]소방관","dJobICd":"D352","dJobICdNm":"[D352]연료용 가스 제조 및 배관공급업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006390:1', '{"dJobCd":"K000006390","dJobCdSeq":"1","dJobNm":"산불진화대원","workSum":"산림에 발생한 산불을 진화하기 위하여 산불이 발생한 곳에 파견되어 혼자 또는 작업조원으로서 산불현장 통합지휘본부의 지시에 따라 진화작업을 한다.","doWork":"평준지, 험준지, 암석지, 고산지 등 산림에서 발생한 산불 대응 및 진화를 위하여 산불의 선단, 측변, 인명 및 재산피해 우려지역에서 도끼, 기계톱, 삽, 수동 및 동력 이동식 소화펌프를 사용하여 산불을 억제하거나 진압하기 위하여 바람 방향에 따라 나무나 풀 등을 베고 청소하여 불길이 번지지 못하도록 한다. 접근이 어려운 산불 발생지역의 경우 헬기를 이용하여 진화 또는 인명구조 작업을 한다. 주불 진화 후 남아 있는 잔불진화 및 뒷불 감시활동을 위하여 진화선 및 산불이 재발할 수 있는 고열 지역을 감시한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 힘든 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|고온|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"산림소방원, 산불재난특수진화대원, 산림예방전문진화대원","dJobECd":"2402","dJobECdNm":"[2402]소방관","dJobJCd":"4112","dJobJCdNm":"[4112]소방관","dJobICd":"O844","dJobICdNm":"[O844]사법 및 공공질서 행정","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007495:1', '{"dJobCd":"K000007495","dJobCdSeq":"1","dJobNm":"소방관","workSum":"화재를 사전에 예방하거나 진압하고 태풍, 홍수, 건물붕괴, 가스폭발 등 각종 재난발생 시 출동하여 인명을 구조하고 재산을 보호한다.","doWork":"사내 각 지역별로 방화 순찰을 실시하여 화재위험요인을 단속하고, 위험물 저장 및 취급에 따른 방화계몽을 지도한다. 소방시설을 점검·정비·확인하고, 건축물에 대한 안전도 검사 등의 화재예방활동을 한다. 위험물의 저장·취급 안전과 사고예방활동을 한다. 가스공급시설 등 위험물시설의 안전원을 지도·감독한다. 화재발생 시를 대비하여 화재의 진화작업요령과 인명구조작업, 화재진압장비 취급방법 등의 소방훈련을 하고, 재난대비 수습훈련을 한다. 화재발생 시 소방차와 함께 긴급 출동하여 인적·물적 피해를 최소화하기 위한 화재진압활동을 수행한다. 화재발생 원인을 감식하고, 피해상황 및 금액을 조사·보고한다. 각종 소방장비 및 소방차량, 소화기구 등을 점검하고, 기능 및 상태를 확인·관리한다. 구급기자재, 약품 등을 관리·운영한다. 기타 재해방지를 위한 제방 소방업무를 수행한다. 지휘차, 펌프차, 순찰차, 구급차 등의 소방차량을 점검하고, 출동지시에 따라 운전하며, 운행 후 소방차량 운행일지를 작성한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|손사용|시각|","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"소방원","connectJob":"화재진압소방관, 구조구급소방관, 화재조사소방관, 안전교육소방관, 검사지도소방관, 위험물안전소방관","dJobECd":"2402","dJobECdNm":"[2402]소방관","dJobJCd":"4112","dJobJCdNm":"[4112]소방관","dJobICd":"O844","dJobICdNm":"[O844]사법 및 공공질서 행정","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004919:1', '{"dJobCd":"K000004919","dJobCdSeq":"1","dJobNm":"화재감식전문가","workSum":"화재현장에 출동하여 화재의 원인을 조사한다.","doWork":"화재현장의 형태나 모습 그리고 목격자나 피해자의 진술을 통해서 범죄와의 연관성을 파악한다. 일치성 여부를 검사한다. 현장사진을 촬영한다. 발화점을 발굴하여 범죄 여부를 판단한다. 화재현장의 복원작업을 한다. 발화원인을 조사한다. 화재감식과 관련된 자료를 조사하고 연구한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"화재조사관, 화재조사요원","certLic":"화재감식평가기사, 화재감식평가산업기사","dJobECd":"2402","dJobECdNm":"[2402]소방관","dJobJCd":"4112","dJobJCdNm":"[4112]소방관","dJobICd":"O844","dJobICdNm":"[O844]사법 및 공공질서 행정","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007570:1', '{"dJobCd":"K000007570","dJobCdSeq":"1","dJobNm":"교도관","workSum":"교도소, 구치소, 보호감호소와 같은 교정시설에서 수용자를 관리·감독하고, 교정·교화하며, 교정행정 전반에 대한 정책방향 설정 및 이를 구체화하기 위한 제도 시행 등의 기획업무를 한다.","doWork":"수용자의 입·출소 및 의식주 등에 대한 관리를 한다. 수용기관 내의 안전유지를 위한 계호업무를 한다. 수용기관 내 범죄발생에 대한 사법경찰권을 행사한다. 수용자의 근로의식 함양 및 바람직한 교화를 위한 지속적인 상담과 성공적인 사회복귀를 위해 직업훈련 등 각종 교정·교화 프로그램을 운영한다. 검찰 및 법정출두 수용자 및 수용기관 간 이송 대상수용자의 호송업무를 수행한다. 교정기관 외곽방위를 위해 설치된 경비교도의 복무, 규율에 관한 사항을 관리하며, 교정기관 내 각종 물품 및 기자재 계구, 무기 관리 등의 업무를 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"감독","workFunc3":"관련없음","connectJob":"보호관찰관, 분류심사원, 수형자분류사, 교화사, 교회사(敎誨師)","dJobECd":"2403","dJobECdNm":"[2403]교도관 및 소년원학교 교사","dJobJCd":"4113","dJobJCdNm":"[4113]소년원 학교 교사 및 교도관","dJobICd":"O844","dJobICdNm":"[O844]사법 및 공공질서 행정","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001982:1', '{"dJobCd":"K000001982","dJobCdSeq":"1","dJobNm":"소년원교사","workSum":"보호처분에 의하여 송치된 보호소년 및 위탁소년 등을 수용·보호하고 이들의 교정교육을 한다.","doWork":"위탁한 소년을 수용·보호하고 이들의 분류심사, 인성교육, 상담조사 및 일반 중·고등학교 부적응 학생 등에 대한 특별교육 및 청소년 적성검사실을 운영한다. 교과교육, 직업훈련, 인성교육, 치료재활교육 등 교정·교화교육을 진행한다. 수용자의 사회복귀를 위해 교육을 실시하고 사회정착을 지원한다. 주간 교육 후 야간에 감호 및 생활지도를 위해 근무한다. 지역사회와 연계하여 오락 및 교육활동을 진행하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"교육","workFunc3":"관련없음","similarNm":"소년원학교교사","connectJob":"보호관찰관","certLic":"정교사(2급), 정신건강임상심리사, 사회복지사, 간호사","dJobECd":"2403","dJobECdNm":"[2403]교도관 및 소년원학교 교사","dJobJCd":"4113","dJobJCdNm":"[4113]소년원 학교 교사 및 교도관","dJobICd":"O844","dJobICdNm":"[O844]사법 및 공공질서 행정","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007549:1', '{"dJobCd":"K000007549","dJobCdSeq":"1","dJobNm":"경호원","workSum":"정부기관 및 민간기관에서 국가재산의 보호 및 국민의 신체, 생명, 재산(물적, 시설, 정보 등)을 보호하고 국민의 생활안전과 법질서 유지 및 사회공공안녕을 위해 경호활동을 수행한다.","doWork":"경호행정계획, 지휘작전계획, 정보수집계획, 보안수립계획, 인원장비운용계획, 수행경호계획, 경호경비수립계획, 인질·납치협상계획, 경호운전계획, 경호컨설팅, 경호조사 등 경호기획을 수립한다. 인적·물적 위해요소, 위해유형 및 유해수준 등을 확인한다. 위해시설을 확인하고 유해물질, 유해인물, 유해환경지형, 범죄성 여부 등을 확인하는 등 경호조사를 한다. 경호관계법 등을 적용하여 유관기관에 협조를 구하거나 고객과의 상담, 계약체결, 경호원 선발, 직무교육 실시, 현장 배치 등 경호행정에 관한 업무를 처리한다. 수행경호, 의전비서 등 경호업무를 수행한다. 국가 및 민간의 주요시설, 기계, 물품 등을 경호하고 경비한다. 주차유도관리, 출동순찰경비, 교도경비 등 경호경비를 한다. 통신장비, 감지·탐지장비, 방호장비, 호송·수송장비, 호신장비 등을 배치·지급하며 회수한다. 방어운전, 긴급피난운전, 미행추적 이탈운전 등을 한다. 인질석방, 납치석방, 공갈협박 위해 감소 및 손실 축소 등에 대해 협상한다. 인원, 시설, 문서, 정보통신, 산업정보 등의 경호보안 업무를 한다. 안전진단, 취약요소에 대한 대응기술 자문 등 경호에 대해 자문한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|손사용|시각|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"수행경호원, 보디가드","certLic":"신변보호사","dJobECd":"5411","dJobECdNm":"[5411]경호원","dJobJCd":"4121","dJobJCdNm":"[4121]경호원","dJobICd":"N753","dJobICdNm":"[N753]경비, 경호 및 탐정업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001631:1', '{"dJobCd":"K000001631","dJobCdSeq":"1","dJobNm":"경호책임자","workSum":"경호 대상의 안전을 확보하기 위해 경호계획을 수립하고 경호 임무에 투입된 경호원과 경호장비 운용 등을 지휘하며 통제한다.","doWork":"경호 대상을 위험으로부터 보호하기 위해 경호대상자와 관련된 행사의 기본계획 및 시설 현황 등을 검토, 조사하여 위험요소를 점검한다. 행사와 관련된 기관 및 부서와 경호에 필요사항을 협의한다. 경호원의 선발 및 배치, 인력과 장비의 운영, 위험사항 시 대처방안 등의 경호계획을 수립하고 돌발상황에 대비하여 예행연습을 실시한다. 경호현황을 가장 잘 파악할 수 있는 장소를 선정하여 현장을 관찰하고 경호원과 경호장비의 운용 등을 지휘하며 통제한다. 위험발생 시 대처방안에 따른 신속한 조치가 이루어지도록 지시한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workEnv":"위험내재|","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","certLic":"일반경비지도사","dJobECd":"5411","dJobECdNm":"[5411]경호원","dJobJCd":"4121","dJobJCdNm":"[4121]경호원","dJobICd":"N753","dJobICdNm":"[N753]경비, 경호 및 탐정업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002286:1', '{"dJobCd":"K000002286","dJobCdSeq":"1","dJobNm":"현금호송원","workSum":"지점의 자금관리 업무의 효율화를 기하기 위해 자금운송을 대행한다.","doWork":"안전복과 안전무기를 착용하고 안전 차량을 이용하여 매일 일정한 시간에 은행 각 지점의 자금을 은행 간 또는 관련 기관에 수송한다. 일정 시간 외의 자금수송 여부는 전화로 접수하여 수송상황표에 기록한다. 자금 영수증에 수송액을 기입하고 출장부에 인원과 차량을 배정한다. 지점으로 출장하여 자금 영수금액을 확인하고 현금을 수령한다. 수령한 자금을 관련 부서에 인계하고 영수증을 받는다. 지점에서 자금요청이 있으면 관련 부서로부터 자금을 인수하여 신청점에 인계한다. 항상 수송 안전에 주의를 기한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"단순작업","similarNm":"현금수송원","dJobECd":"5411","dJobECdNm":"[5411]경호원","dJobJCd":"4121","dJobJCdNm":"[4121]경호원","dJobICd":"N753","dJobICdNm":"[N753]경비, 경호 및 탐정업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001780:1', '{"dJobCd":"K000001780","dJobCdSeq":"1","dJobNm":"호송사무소장","workSum":"부서원의 교육 및 안전한 호송 등 호송업무 및 호송사무소의 전반적인 관리업무를 한다.","doWork":"호송사무소 부서원의 복무상황, 작업, 인사관리를 한다. 부서원의 안전교육을 하고 귀중품 호송원의 안전을 관리한다. 본사로부터 호송스케줄을 받아 부서원에게 숙지시킨다. 사무소 건물을 관리한다. 건물 내 금고의 개폐를 관리한다. 보관 귀중품의 양과 상태를 관리한다. 호송차량의 상태를 파악하고 배차한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","dJobECd":"5411","dJobECdNm":"[5411]경호원","dJobJCd":"4121","dJobJCdNm":"[4121]경호원","dJobICd":"N753","dJobICdNm":"[N753]경비, 경호 및 탐정업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003290:1', '{"dJobCd":"K000003290","dJobCdSeq":"1","dJobNm":"호송사무원","workSum":"호송업무를 수행하도록 수송 장부를 관리하고 호송관리자의 지시사항을 전달한다.","doWork":"호송경비관리자로부터 당일 업무를 지시받아 호송원에게 전달하고 세부사항에 대해 교육한다. 귀중품 인수인계 수송 장부를 관리하고 정리하여 관리자에게 보고한다. 호송차량 운행 시 호송원과 상호연락을 취하고 연락시간을 기록한다. 창고로부터 호송 시에는 귀중품의 상하차를 돕기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"웅크림|","workFunc1":"기록","workFunc2":"말하기신호","workFunc3":"단순작업","dJobECd":"5411","dJobECdNm":"[5411]경호원","dJobJCd":"4121","dJobJCdNm":"[4121]경호원","dJobICd":"N753","dJobICdNm":"[N753]경비, 경호 및 탐정업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004409:1', '{"dJobCd":"K000004409","dJobCdSeq":"1","dJobNm":"청원경찰(일반)","workSum":"국가기관, 지방자치단체 및 공공단체 등 국가중요시설이나 사업장 등을 보호하기 위해 경호등 경찰관직무집행법에 따른 예방경찰권 직무를 수행한다.","doWork":"시도 경찰청장에게 경찰관직무집행법에 따른 권한을 승인을 받아 국가기관, 지방자체단체, 정부청사 등 국가중요시설 등을 보호 및 경호한다. 경비구역 내 배치되어 있는 물품 및 신체에 대하여 보안 검색한다. 보안 검색을 위한 보조수단으로 보안장비를 활용하고, 필요시 촉수 검색을 시행하기도 한다. 거수자 특이동향을 파악하고 범죄예방 업무를 한다. 집회 및 시위와 악성민원을 대응하고, 기관 내 질서유지 업무를 한다. 차량 검색 및 출입통제를 한다. 입주부터 및 기관 특성에 따른 주요인사 의전과 신변의 보호인 경호업무를 한다. 비상상황 발생 시 초동대응하고, 유관기관 등에 통보하여 협조 요청한다.\n전시 상황에서 시도 경찰청장 작전지휘관의 지휘에 따라 통합방위작전을 수행하고, 국가중요시설을 방호하며 경계 업무를 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"공공안전관","dJobECd":"5412","dJobECdNm":"[5412]청원경찰","dJobJCd":"4122","dJobJCdNm":"[4122]청원경찰","dJobICd":"O84","dJobICdNm":"[O84]공공행정, 국방 및 사회보장 행정","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;