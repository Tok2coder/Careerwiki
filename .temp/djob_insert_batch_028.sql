INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003231:1', '{"dJobCd":"K000003231","dJobCdSeq":"1","dJobNm":"방사성폐기물운송사무원","workSum":"원자력발전소 등에서 임시저장 중인 방사성폐기물을 육상이나 해상운송을 통해 방사능폐기물처리장으로 운반하기 위한 계획을 수립하고 관련 장비를 관리한다.","doWork":"원자력발전소 등 발생지에 보관되어 있는 방사성폐기물을 방사성폐기 처분시설로 운반하기 위한 운반계획을 수립한다. 방사성폐기물의 운반경로를 사전에 점검하고 인수예정을 통보한다. 안전을 위해 유관기관 및 관련 부서에 협조를 요청한다. 운송과정을 감독하고 도착한 방사능폐기물의 운반검사결과를 확인·보고한다. 해상운송용 선박, 운반트럭, 지게차, 운반용기의 점검과 유지·보수계획을 수립하여 시행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"협의","workFunc3":"관련없음","certLic":"방사성동위원소취급일반면허, 방사선취급감독자면허, 원자력기사","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"E382","dJobICdNm":"[E382]폐기물 처리업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003996:1', '{"dJobCd":"K000003996","dJobCdSeq":"1","dJobNm":"버스배차원","workSum":"버스의 원활한 운행을 위하여 소속회사의 차량 및 운전기사를 배치·관리한다.","doWork":"시외버스 및 고속버스, 시내버스, 마을버스 등 규정된 배차기준에 따라 노선 및 차량의 운행시간표를 작성한다. 운행시간표에 따른 버스운전원의 승무배차표를 작성한다. 버스운전원의 승무순서, 승무시간 및 승무차량을 확인하여 기록한다. 버스운전원의 요청 또는 비상사태 발생 시 운전원 대체를 위하여 계획표를 조정한다. 명절 등 특정기간 동안의 특별수송계획을 수립한다. 교통상황, 노선상황 및 도로상태를 파악하여 배차간격 및 운행시간을 조정하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"버스 종류에 따라 고속버스배차원, 시내버스배차원, 시외버스배차원, 전세버스배차원","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H492","dJobICdNm":"[H492]육상 여객 운송업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002946:1', '{"dJobCd":"K000002946","dJobCdSeq":"1","dJobNm":"버스터미널배차원","workSum":"버스터미널을 이용하는 운송회사별 배차계획을 총괄하고 차량배차계획을 수립한다.","doWork":"버스터미널 전체의 차량운행 허가대수, 운송회사별·노선별 차량대수 및 횟수, 예비차량 등에 관한 법률적 규정, 승객현황, 기타 제반 사항을 고려하여 월별 정기차 배차계획표 및 운행시간표를 수립한다. 특별수송기간 또는 상황에 따라 예비차량을 적절하게 투입한다. 각 운송회사와 배차 관련 사항을 협의한다. 터미널 이용승객현황 등에 따른 매표창구의 개폐를 조정·통제한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003156:1', '{"dJobCd":"K000003156","dJobCdSeq":"1","dJobNm":"버스터미널운행관리원","workSum":"버스터미널 이용 시 차량의 소통, 사고방지를 위하여 차량 및 승객을 안전하게 유도한다.","doWork":"버스터미널을 이용하는 차량의 출입을 안전하게 유도하여 터미널 내에서 차량소통을 원활하게 한다. 터미널을 이용하는 승객이 차량에 의해 사고를 당하지 않도록 안전하게 안내한다. 교통혼잡을 피하기 위하여 터미널 내부로 진입하는 일반차량의 출입을 통제한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"약간의 시범정도","workStrong":"가벼운 작업","workPlace":"실외","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"고속버스터미널관리사무원","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004781:1', '{"dJobCd":"K000004781","dJobCdSeq":"1","dJobNm":"복합운송주선인","workSum":"화주의 대리인으로서 적절한 운송수단을 선택하여 운송에 따르는 일체의 부대업무를 처리하고, 복합 운송시스템하에서는 컨테이너 등을 취급할 수 있는 장소와 운송설비를 갖추고 집화·분배·혼재업무를 수행한다.","doWork":"화주로부터 화물운송을 위탁받는다. 해상·항공·철도·도로운송의 소요비용과 시간, 신뢰성, 경제성을 고려하여 가장 적절한 운송경로를 선정한다. 운송수단, 화물의 포장형태 및 목적국의 각종 운송규칙을 제공하여 운송서류 작성을 도와준다. 운송계약 체결 시 특정 운송수단을 예약하기 위하여 특정화주의 대리인으로서 자신의 명의로 운송계약을 체결한다. 선하증권과 항공운송장, 통관서류 등의 서류들을 직접 작성하거나 화주의 작성을 도와준다. 국내의 포워더는 해상 또는 항공혼재 화물적하목록을 작성하여 전자문서교환(EDI:Electronic Data Interchange)을 통하여 세관에 제출한다. 화주를 대신해 관세사를 통하여 통관수속을 한다. 효과적인 화물의 포장방법, 운송수단 등을 직접 수행하거나 전문회사에 의뢰한다. 화물의 통합 또는 분배업무를 수행하기 위하여 창고회사에 의뢰한다. 화주를 대신해서 화물보험에 관계되는 보험형태와 보험금액, 보험조건 등을 수배한다. 운송과정에서 화물의 안전과 원활한 흐름을 도모하기 위하여 화물관리업무를 수행한다. 대량으로 수입되는 화물을 일괄처리한 후 각지에 흩어져 있는 수하인에게 배송·인도하는 분배업무를 수행한다. 시장조사를 통해 거래처를 발굴하고 거래선을 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|","workFunc1":"수집","workFunc2":"협의","workFunc3":"단순작업","similarNm":"국제물류주선원","connectJob":"포워딩영업관리원, 포워딩영업원, 포워딩사무원, 항공운송영업원, 해상운송영업원","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003881:1', '{"dJobCd":"K000003881","dJobCdSeq":"1","dJobNm":"부두화물장치료계산원","workSum":"선박회사로부터 항만시설사용료를 받기 위하여 부두설비의 사용료, 체선료 등을 계산한다.","doWork":"선박의 규모, 화물의 종류 등을 확인하여 체선요금표와 비교한다. 화물 하역 또는 적재에 사용한 부두설비의 사용내역 및 사용시간 등을 확인하고 사용료를 계산한다. 체선비용과 부두설비의 사용료를 검토·합산하여 요금을 산정한다. 선박회사의 문의사항을 처리하고 관련 자료를 정리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"계산","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001361:1', '{"dJobCd":"K000001361","dJobCdSeq":"1","dJobNm":"분실물조사원","workSum":"각종 운송화물의 손실 및 분실의 원인을 조사·분석·추적하여 분실물을 추적(확인)하고 보상대책을 수립한다.","doWork":"승객으로부터 화물 분실신고를 받고 분실한 화물의 종류 및 수량을 확인한다. 승객이 이용한 철도, 항공기, 선박 등 각종 운송수단의 운행경로 및 화물의 이동상황을 파악하여 분실물을 추적한다. 분실된 원인이 무엇이고 그 책임은 누구에게 있는지 조사한다. 운송된 화물의 수량을 파악하여 변질되거나 이상이 발생한 수량을 확인하고 원인을 분석한다. 파손 또는 분실된 화물의 보상계획을 수립하여 관계부서에 의뢰한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002116:1', '{"dJobCd":"K000002116","dJobCdSeq":"1","dJobNm":"선박관리사무원","workSum":"선박의 안전운항과 차질 없는 운항일정을 위하여 선박의 정비 관련 업무를 수행한다.","doWork":"선박정비 및 정비용 자재의 보급기준과 보급계획을 수립한다. 선박의 기기 성능, 점검개소, 점검기준과 신뢰성 등을 파악하고 관리수준을 정한다. 선박의 안전 및 경제운항을 위한 신기술을 조사하고 도입을 검토한다. 정비 및 작동 관련 사고사례를 조사하고 기술정보를 조사하여 교육을 실시한다. 해상오염방지를 위하여 국제기준을 파악하고 정비 관련 교육, 훈련절차 등의 계획을 수립한다. 연료유, 윤활유의 수급을 관리한다. 선박의 건조, 도입, 정비 관련 자료를 기관·선체·기계부문으로 나누어 작성하고 유지한다. 정비 관련 업무에 관한 시스템을 개발하고 개발된 시스템을 개선한다. 관련 정비반을 운영한다. 선박무선국허가를 신청하며 선박의 항해통신장비의 정비를 실시한다. 선박의 무선국 검사의 수검계획을 수립하고 집행한다. 선박의 정비와 관련된 기관에 대한 연락과 업무를 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H501/H502","dJobICdNm":"[H501]해상 운송업 / [H502]내륙 수상 및 항만 내 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004652:1', '{"dJobCd":"K000004652","dJobCdSeq":"1","dJobNm":"선박운항관리원","workSum":"선박의 운항계획, 배선계획 등을 수립하기 위하여 선박의 상태, 하역상황, 운항비용, 하역비 등을 검토·분석한다.","doWork":"출항목적지, 화물의 종류 및 수량 등을 확인하여 선박의 규모 및 출항항로 등을 감안한 수익성과 경제성을 검토한다. 기항 항만의 하역비, 선박입항료 등의 부대비용 등을 검토하여 운항비용을 산출하고 관련 자료를 정리한다. 화물의 하역 또는 선적상황을 확인하여 출항일정에 맞도록 조정한다. 타 회사직원들과 화물의 취급, 보관, 수송 등과 같은 유통상의 문제를 협의한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"선박운항관리사, 선박운항관리사무원","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H501/H502","dJobICdNm":"[H501]해상 운송업 / [H502]내륙 수상 및 항만 내 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006668:1', '{"dJobCd":"K000006668","dJobCdSeq":"1","dJobNm":"선석플래너","workSum":"선사의 요구에 따라 입출항 스케줄을 감안하여 선박이 접안될 선석 위치를 배정하고 화물의 종류와 특성에 따른 하역순서를 결정한다.","doWork":"신규 이용선사 또는 항로상의 최초 선석 정기이용 요청공문을 해당 선사로부터 접수받고 전체적인 접안처리능력과 입항스케줄 및 기존 선박의 입항스케줄 중복 여부를 검토하고 가능여부를 선사에 통보한다. 신규 이용선박의 정기스케줄을 주간입항계획서(Weekly Calling Shcedule)에 신규로 등록한 후 선사에 통보한다. 선사별 월간입항계획을 접수한다. 접수된 각 선사의 월간 입항계획을 항로, 선박별 특성, 화물양과 특성을 고려한 후 선석별로 선박을 가배정하고 월간입항계획서(Monthly Calling Schedule)을 수립한다. 승인된 선박별 월간입항스케줄과 가배정된 선석을 전산 입력한다. 월간 예상하역물량을 산정한다. 선박입항예정시간, 선석요청시간, 작업예정물량, 중량물, 벌크화물, 특수화물(Over Height, Over Wide, Over Large 등)의 작업 여부, 작업상 특이사항(접안측면, 적재상태, 갑판적 컨테이너 높이 등)과 같은 내용이 포함된 선석신청서를 접수한다. 선박의 스케줄, 특성, 작업 관련 정보와 컨테이너 크레인 가동사항 등을 종합판단하여 선박의 일일선석배정표(Daily Calling Schedule)를 작성 배정한다. 컨테이너 크레인(Container Crane) 배정시간을 조정하고 작업을 지시한다. 선석배정 이후 선박의 입항시간 또는 작업예정물량 등의 변동이 발생되면 선사로부터 변경된 선석신청서를 재접수하여 선석을 다시 배정한다. 당일 접안선박의 본선작업 진행사항을 수시로 파악하여 본선작업 지연으로 인하여 다음 접안예정 선박의 선석스케줄 지연이 예상될 때는 컨테이너 크레인의 대수와 사용시간 또는 선석 배정스케줄을 재조정한다. 정박일지(Berthing Log)를 기록한다. 선석점유율 및 체선 관련 자료를 참고로 선석관리와 통계관리를 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H501","dJobICdNm":"[H501]해상 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003609:1', '{"dJobCd":"K000003609","dJobCdSeq":"1","dJobNm":"선적서류사무원","workSum":"해상화물운송에 필요한 선적서류를 작성한다.","doWork":"하송인으로부터 하송인의 명세, 화물의 명세, 목적지, 선적일정 등이 기재된 선적요구서를 접수한다. 선적요구서에 따라 요금정산표를 작성한다. 정산표를 화주에게 발급하고 세금계산서를 작성 발송한다. 선적화물의 이상 유무를 점검하도록 검수원에게 지시한다. 선적요구서를 기반으로 선적작업서류를 작성한다. 선적서류를 양적화플래너에게 전달하여 해당 화물을 선적하도록 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H501/H502","dJobICdNm":"[H501]해상 운송업 / [H502]내륙 수상 및 항만 내 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004351:1', '{"dJobCd":"K000004351","dJobCdSeq":"1","dJobNm":"수출입화물감정원","workSum":"화물, 선박, 운송기기, 해운과 관련된 수량, 용적, 중량, 상태, 품질, 손상 및 손해에 대한 조사, 검사, 사정, 입증 등의 업무를 하고 증명서를 발급한다.","doWork":"화물의 종류와 규모, 계약서류 등을 확인하고 관련 보험법을 참조하여 파손, 분실, 사고, 해상오염 등 발생할 수 있는 여러 현상을 검토한다. 화물의 파손과 파손원인, 선체·기관 및 기타 의장의 현상검사와 선내연료유, 위험화물의 적재 및 취급, 중량화물 및 철강제품의 상태, 원유 및 각종 석유화학제품의 성분, 각종 저장탱크의 용량, 수출입화물, 컨테이너, 철강원료 및 고철, 선박적부검사, 해상오염과 손해 등을 감정한다. 카메라, 온도계, 가스측정기 및 기타 감정기구를 사용하여 유압, 온도, 잔유가스량 등을 분석한다. 검사·감정한 내용을 토대로 감정한 자료를 정리하여 보고자료를 작성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"시각|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"Surveyor, Marine Surveyor","certLic":"감정사","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001766:1', '{"dJobCd":"K000001766","dJobCdSeq":"1","dJobNm":"수출입화물검량원","workSum":"선적화물의 용적 또는 증량을 이해당사자가 아닌 제3자적 위치에서 공정하게 검측·계산하고 이를 증명한다.","doWork":"선적 및 양화하물을 저울, 자 등의 계량기로 측정하며 수치를 확인하여 계산하고 적하목록 및 인보이스와 대조하여 중량 및 용적을 검측하여 과부족 여부를 증명한다. 산화물(광석, 비료, 양곡 등)의 적·양화물에 대한 실중량을 선박에 표시된 홀수를 이용하여 산출하고 증명한다. 액체화물(석유류, 화학 액체류 등)의 본선유조와 이를 수급하는 육상저장탱크의 액체용량을 측정하여 각 유조의 유량크기(Scale)에 의거 정확한 용량을 산출·증명한다. 컨테이너 용기를 이용하여 수출되는 화물이 용기에 적입하기 전 컨테이너 용기 등의 수밀여부 등 상태를 검사한다. 양곡류, 광석, 철재류 등의 실양하중량을 계근대에 입회하여 측정한 후 합산하여 총량을 산출하고 증명한다. 수출업자가 제시하는 Packing List를 기준하여 양이 일치하는지 확인한다. 화물의 선적에 앞서 선임, 하역비 등 물류비의 계산근거 및 선창이나 보관창고의 적부계획에 근거가 되는 용적을 측정하고 증명한다. 각종 육상탱크, 유조차, 선박탱크의 용량표를 작성한다. 시료, 실험시설 운영 등의 업무를 수행한다. 측정·산출·증명결과를 보고서로 작성하여 제출한다. 국외적인 분쟁, 손해 등이 발생 시에는 검량보고서를 작성한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"검량원, 물류검량원, 자재검량원","certLic":"검량사","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002986:1', '{"dJobCd":"K000002986","dJobCdSeq":"1","dJobNm":"수출입화물검수관리원","workSum":"화물의 양적하, 본선의 수출입화물에 대한 수량검수 등 본선검수작업을 총괄하고 컨테이너검수원의 작업을 조정·감독한다.","doWork":"본선작업 시 적재 컨테이너의 본선 내의 위치를 표시해 놓은 본선적부도와 적하목록을 대조하고, 검수원이 작성한 검수표와 적하목록을 대조하여 확인한다. 검수결과 문제가 발생하면 선박회사 및 세관에 통보한다. 검수원의 작업을 총괄한다. 작업일지 및 파손보고서 등의 검수서류를 작성 또는 검토하여 선박회사에 제출한다. 컨테이너파손보고서를 작성하고 항해사에게 알린다. 냉동컨테이너와 같이 특별하게 취급해야 할 컨테이너 목록을 작성한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실외","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","similarNm":"치프체커(Chief Checker), 수석검수사, 선임검수사","certLic":"검수사","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007012:1', '{"dJobCd":"K000007012","dJobCdSeq":"1","dJobNm":"수출입화물검수사","workSum":"수출입화물이 송하주로부터 수하주에게 인도되기까지 선적, 양하, 환적 등 모든 화물의 정확한 개수를 계산하고 상태의 확인 및 수도의 증명 등을 거쳐 검수표를 작성한다.","doWork":"본선적부도(Stowage Plan:본선의 선창에 화물이 적재된 상태를 나타낸 도면)를 가지고 실제 컨테이너 적양하 위치를 확인한다. 양화화물 위에 타 화물 적재 유무를 확인한다. 냉동화물에 플러그가 꽂혀 있는지 확인하고 온도측정기를 확인한다. 적부도상의 화물이 틀릴 경우 수석검수원에게 보고한다. 육상의 야드 근무 시에는 컨테이너 번호, 봉인번호를 확인하여 검수표에 기록한다. 미봉인 발견 시 터미널과 화주 등에 보고하여 세관직원 입회하에 재봉인한다. 컨테이너 파손상태를 확인한다. 수입화물의 경우 적화목록에 따라 하역회사 입회하에 봉인을 열고 확인절차에 따라 화물상태의 이상 유무를 파악하여 검수표를 작성한다. 손상이나 수량부족 등 이상이 있을 경우 세관과 선박회사에 보고한다. 수출화물의 경우 수출화물의 수량과 포장상태 및 이상 유무 또는 혼적화물을 파악하여 보고하고 사실증명을 검수표로 작성하여 보관한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"시각|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"검수사, 물류검수사, 자동차검수사, 컨테이너검수사, Checker, Tally Man","certLic":"검수사","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002138:1', '{"dJobCd":"K000002138","dJobCdSeq":"1","dJobNm":"수출입화물검수운영사무원","workSum":"검수작업을 의뢰받아 작업준비를 하고 검수작업결과를 정리하여 적절한 조치를 취한다.","doWork":"본선작업(선박을 접안시킨 상태에서 선박으로부터 직접 화물을 내리거나 선박에 싣는 작업) 전에 선박회사로부터 모선별 작업계획 및 관계서류를 입수하여 검토한 후 검수관리사무원(여행알선·운수서비스)에게 작업준비를 통보한다. 작업 중 발생되는 특수상황이 있을 경우 선사와 연락을 취해 해결한다. 검수작업 완료 후 컨테이너검수원(여행알선·운수서비스)들에 의해 작성된 컨테이너파손보고서(Container Damage Report) 등 관련 서류를 전달받아 최종 검토하여 세관, 선박회사, 하역회사 등에 필요한 서류를 전달한다. 작업보고서의 미처리 내용을 파악하여 조치를 취하고 모선당 서류를 정리하여 청구내역서를 작성한 후 선박회사에 제출한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006295:1', '{"dJobCd":"K000006295","dJobCdSeq":"1","dJobNm":"수출입화물검수작업사무원","workSum":"원활한 검수작업을 위해 검수작업 내용을 파악한 후 작업량에 맞는 컨테이너검수원을 배치하고 안전사고를 방지한다.","doWork":"모선입항과 동시에 이루어지는 검수업무 전반에 대하여 선적 및 양하화물에 따라 적절한 현장 근무인원을 배치한다. 선박이 입항하는 시간 및 출항하는 시간을 선박회사 및 선박대리점으로부터 파악하고, 현장 근무인원을 파악하여 승선 및 용역허가서를 작성하여 세관에 제출한다. 현장에서 발생할 수 있는 안전사고를 방지하기 위하여 교육을 하고 순찰한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"검수사","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001928:1', '{"dJobCd":"K000001928","dJobCdSeq":"1","dJobNm":"승무계획교번원","workSum":"컴퓨터교번시스템을 이용하여 해당 지역의 기관차기관사의 승무계획표를 작성하고 통보한다.","doWork":"담당하는 지역의 기관차기관사의 열차운행계획을 세우기 위해 컴퓨터교번시스템을 이용하여 월별 열차운행계획표(사업다이아)를 작성한다. 기관차기관사의 경력 및 전문성 등을 고려하여 승무조를 편성한 후 운행열차번호, 운행일시 및 운행구간이 정해지는 조별 다이아를 작성한다. 여러 개의 운행안을 작성하고 교번심의를 통해 최적안을 선택한다. 결정된 계획표를 열차승무운용원에게 전달한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H491","dJobICdNm":"[H491]철도 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005187:1', '{"dJobCd":"K000005187","dJobCdSeq":"1","dJobNm":"여객서비스조사원","workSum":"승객에 대한 서비스 향상과 안전운행을 위하여 직원들의 업무와 활동에 관한 정보를 수집·정리한다.","doWork":"항공기, 철도, 버스 및 기타 운송관계업에 종사하고 있는 직원들의 품행, 승객에 대한 서비스, 회사의 사규와 계획의 준수상태 등을 확인하기 위하여 업무나 역할을 수행하고 있는 현장을 점검·기록한다. 승객의 승·하차 및 화물의 적재와 하역에 소요되는 시간, 승객의 질서유지상태, 차량 및 항공기 내의 청결상태 등을 점검·기록한다. 승객으로부터 접수된 불평 및 불만에 대한 사실여부를 조사하고 보고 또는 시정 조치한다. 접수된 서비스에 대한 불평 및 불만의 조치사항을 해당 직원 또는 관계부서에 통보한다. 서비스의 개선에 대한 제안을 작성하여 관계부서에 보고한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"감독","workFunc3":"관련없음","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H","dJobICdNm":"[H]운수 및 창고업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006293:1', '{"dJobCd":"K000006293","dJobCdSeq":"1","dJobNm":"역무원","workSum":"역사 내에서 승차표를 발매 및 개·집표하며, 고객의 편의를 위해 안내한다.","doWork":"고객의 요청에 따라 목적지를 확인하여 승차권을 발매한다. 고객이 승강장에 들어갈 때나 나갈 때 안내 또는 감시한다. 위치를 안내하고, 민원발생 시 처리한다. 운수수입금을 집계하고, 역무자동화기기를 관리한다. 역사주변을 순회하며 역사시설물 및 임대시설물 등을 점검하고, 선로의 보수상태, 운전보완장치의 작동상태를 점검하여 보수를 의뢰한다. 역내 비품수급을 관리하고, 각종 현황을 정리하여 일지를 작성한다. 유실물을 보관하여 돌려주거나 유실물처리상황을 감독한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"계산","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"철도역무원, 지하철역무원","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H491","dJobICdNm":"[H491]철도 운송업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003848:1', '{"dJobCd":"K000003848","dJobCdSeq":"1","dJobNm":"열차승무운용원","workSum":"기관차기관사의 승무계획표를 승무원에게 통보·변경하고, 기관사의 근무상태를 감독한다.","doWork":"차량운행계획표에 따라 해당 기관차기관사에게 운행열차번호, 운행일시 및 운행구간 등을 통보한다. 열차운행을 준비하는 기관차기관사의 승무가 적합한지 컨디션 및 음주여부를 확인하고, 승무일지를 출력해 준다. 시간표 및 주의사항 등을 전달하고 승무여부를 확인한다. 도착 승무원에게 열차 주행거리, 도착시간, 열차 차량입고 등의 내용을 보고받아 기록한다. 승무원의 휴가 및 교육현황을 등록하고 근무상황을 관리한다. 근무변경 요청 시 전체 승무원의 스케줄을 확인하여 가능한 승무원에게 연락 및 대체한다. 임시열차의 운행계획을 작성하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"감독","workFunc3":"관련없음","similarNm":"교번운용원","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H491","dJobICdNm":"[H491]철도 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004939:1', '{"dJobCd":"K000004939","dJobCdSeq":"1","dJobNm":"열차승무지도원","workSum":"기관차기관사의 운전업무를 지원하고 관계 규정 및 운전업무 전반에 걸쳐 지도·교육한다.","doWork":"담당 기관차기관사의 열차 운행현황을 파악하여 운행속도 및 지연상황 등을 분석한다. 철도사고에 대한 통계자료를 수집하여 문제점을 파악하고 사고예방을 위한 교육계획을 수립하고 안전교육을 실시한다. 신기술이나 새로 도입된 방식의 열차시스템에 대하여 교육하고, 담당 기관사와 필요시 면담한다. 여러 상황에서의 열차운전에 필요한 차량의 운전방법, 신호방식, 주의사항 등을 해당 승무원에게 알린다. 대수송계획을 수립한다. 기관사의 운행사고 발생 시 현장에 지원을 나가거나 사고수습을 위한 종합안전대책을 수립하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","certLic":"철도기관사운전면허","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H491","dJobICdNm":"[H491]철도 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002754:1', '{"dJobCd":"K000002754","dJobCdSeq":"1","dJobNm":"열차여객관리원","workSum":"열차여객의 수송을 통제하고 고객안내센터, 각 역에서의 비상사태 발생 시 조치를 취하고 각 역의 영업상태를 총괄한다.","doWork":"역무소의 영업준비사항을 보고받아 여객수송에 이상이 없는지 확인한다. 영업지연이나 여객수송에 차질이 생길 경우 인근역에 연락하여 열차운행을 조정한다. 승객의 유동상태를 파악하여 수송을 조정하거나 승차권발매를 제한한다. 안내방송을 지시하고 열차 및 지하철 전 노선의 열차운행정보를 파악하여 타 기관 및 열차기관사와 정보를 주고받는다. 이용안내센터를 운용하여 고객의 불만사항을 접수하고 문의에 응대한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H491","dJobICdNm":"[H491]철도 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001860:1', '{"dJobCd":"K000001860","dJobCdSeq":"1","dJobNm":"열차운전계획원","workSum":"원활한 열차운행을 위하여 열차운행횟수, 간격 및 시간 등 열차의 기본운전계획을 수립 및 변경한다.","doWork":"열차운행노선에 대하여 선로, 열차 수, 각종 설비조건 등을 반영하여 주간운전 및 운행노선의 소요시간을 산정한다. 수송인원 및 보유차량, 시간 및 주간 수요현황을 고려하여 운행노선을 편성한다. 운행시간 간격 및 열차의 횟수를 결정하여 열차운행다이아, 운전시각표를 작성하고 협의한다. 승무원 증원 및 전동차 증차에 대한 계획을 수립한다. 신설노선 및 연장노선, 임시열차 운행계획을 수립한다. 기존노선을 검토하고 필요시 변경한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H491","dJobICdNm":"[H491]철도 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005852:1', '{"dJobCd":"K000005852","dJobCdSeq":"1","dJobNm":"열차운행계획원","workSum":"열차의 운행시간, 노선, 승무원의 배정 등 열차운행의 기본계획을 수립한다.","doWork":"열차운행기본계획을 수립하기 위하여 열차의 운행간격, 시간, 차량수를 평일과 휴일 및 노선별로 배치하여 운행일정표를 작성한다. 운행일정표를 기초로 각 역별 운행시간표를 작성한다. 열차운행인력의 충원계획을 세우기 위하여 운행일정표와 승무원의 근무조건 등을 분석한다. 승무원의 승무시간을 고려하여 시운전교육 또는 직무교육계획을 수립한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"관련없음","workFunc3":"관련없음","similarNm":"열차운행계획사무원","connectJob":"열차 운행일정표만을 작성하는 경우 열차일정표작성원","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H491","dJobICdNm":"[H491]철도 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007018:1', '{"dJobCd":"K000007018","dJobCdSeq":"1","dJobNm":"열차운행관리원","workSum":"열차운행 시 해당 구역 내에서 발생하는 사고의 처리업무와 전철기(전기선로전환기)관리 등의 업무를 수행한다.","doWork":"열차운행 관리업무를 한다. 지연열차 운행사항을 파악하고 구내업무일지에 지연사항을 기록·처리한다. 본사사령실에서 내린 명령에 의거 작업열차의 운전을 관리한다. 열차운행 시 각종 신호(진행, 주의, 정지 등)를 조작판에서 조작하는 신호조작업무를 수행한다. 역과 역, 역과 열차, 역과 사령실 간의 무선교신 및 폐색기에 있는 각종 버튼을 조작하여 신호의 조건을 맞춰준다. 열차통과 시 이상 유무를 감시한다. 환경미화 등의 작업을 수행하기도 한다. 열차를 움직이는 신호취급의 성질상 고도의 주의력과 책임감이 요구된다. 운전용품의 정리정돈 및 관리업무를 수행한다. 전철기 청소를 하고 급유관리를 행한다. 전철기 및 신호보안장치를 기능적으로 점검한다. 점검사항을 구내업무일지에 기재하고 특이사항 발견 시에는 종합사령실에 보고하고 관련 부서에 통보한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"대기환경미흡|","workFunc1":"기록","workFunc2":"말하기신호","workFunc3":"유지","connectJob":"철도운송사무통제관","certLic":"철도운송산업기사","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H491","dJobICdNm":"[H491]철도 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004300:1', '{"dJobCd":"K000004300","dJobCdSeq":"1","dJobNm":"열차차량정비관리원","workSum":"열차차량정비계획 및 검수를 위해 창고에 들어온 차량의 검수공정, 기간 등의 정비계획을 수립하고 관리한다.","doWork":"전기기관차, 디젤기관차, 전동차 등의 정기 및 비정기 검사계획을 수립한다. 정비원의 인원관리 및 안전관리에 대해 교육한다. 검수를 위해 입창된 차량을 확인하고 차량품질검사원과 차량을 검수한다. 검수결과를 토대로 정비공정을 수립한다. 윤축조, 축상장치정비 등의 대차정비, 도어엔진, 냉난방장치 등의 차체정비, 제련정비, 전자기기, 회전기, 기관장치 등 담당 분야의 정비에 필요한 물품, 정비기간 등을 고려하여 열차차량정비원의 업무를 할당한다. 차량정비원의 활동을 감독·총괄한다. 정비장비 및 설비의 운용상태를 파악하여 관리한다. 열차 부품조달을 확인하고 주요 물품재고 및 물품수급계획을 지시한다. 열차운용 및 정비기술을 교육하고 조언한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|시각|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"열차차량정비기술원, 열차차량정비계획원","certLic":"철도차량정비산업기사","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H491","dJobICdNm":"[H491]철도 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005702:1', '{"dJobCd":"K000005702","dJobCdSeq":"1","dJobNm":"열차화물사무원","workSum":"광석, 자동차, 곡물, 시멘트 등 열차화물의 적재 및 하역작업을 관리·감독한다.","doWork":"화물운송장 및 적하기록을 확인하여 화물의 품목, 개수 및 무게 등을 파악한다. 화물의 최적 적재량, 화물의 폭 및 높이 등을 계산하고 적하순서를 결정한다. 화물작업원의 작업을 할당하고 감독한다. 적재된 화물의 경우 품목 및 화차 수 등을 기록하여 화물운송장을 발행한다. 하역하는 화물의 경우 화물운송장을 확인하여 화물의 손실여부를 파악하고 그 결과를 관련 부서에 통보한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"계산","workFunc2":"감독","workFunc3":"관련없음","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H491","dJobICdNm":"[H491]철도 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001365:1', '{"dJobCd":"K000001365","dJobCdSeq":"1","dJobNm":"예인선파송원","workSum":"항구로 입항 또는 출항하는 선박의 이접안을 돕고 바지선이나 해상크레인 등을 이동시키기 위하여 예인선을 파송한다.","doWork":"고객의 통신 또는 서면요청을 접수하고 검토하여 선박의 종류, 규모 및 접안할 선석 등을 확인한다. 선박의 규모에 따라 예인선의 규모 및 장비를 결정한다. 대기 중인 예인선을 확인하고 예인선선장에게 연락한다. 항구관리실에 연락하여 선박의 예인허가, 정박지 및 계류지역에 대한 허가를 얻는다. 기상정보 및 항해도표를 검토하고 요청된 예인서비스를 수행하기 위하여 필요한 시간 및 요금을 계산하여 통보한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H501","dJobICdNm":"[H501]해상 운송업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003016:1', '{"dJobCd":"K000003016","dJobCdSeq":"1","dJobNm":"우편원","workSum":"우편물의 접수, 구분, 발착 및 운송 등과 관련된 업무를 수행한다.","doWork":"우체국 우편창구에서 고객으로부터 우편물을 접수하고 기록한다. 우편물을 주소지 등 분류기준에 따라 구분하고 집중국으로 발송한다. 우편집중국이나 우편물류센터에서는 우편물을 인수하여 총괄국 내에 분배하는 등 집배원이 우편배달업무를 원활히 할 수 있도록 우편물의 구분 등의 지원업무를 한다. 전화나 인터넷으로 접수하고 방문하여 소포업무를 처리하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"손사용|","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"수동조작","connectJob":"우편물운송사무원, 우편운용원, 우편물민원사무원, 우편물 발송원, 소포우편물접수원, 국제우편물조사원","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"J611","dJobICdNm":"[J611]공영 우편업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002448:1', '{"dJobCd":"K000002448","dJobCdSeq":"1","dJobNm":"운송고객관리사무원","workSum":"고객으로부터 전화를 받아 배송을 하며, 화물의 손실 및 분실의 원인을 조사·분석하여 분실물을 추적하고 보상대책을 수립한다.","doWork":"고객으로부터 전화, 인터넷을 통해 주문을 받는다. 고객의 전화번호, 주소, 화물의 종류 및 수량, 수송지 주소를 확인하여 전산입력을 한다. 용달화물차운전기사에게 배송을 지시한다. 고객으로부터 손실 및 분실신고를 받고 화물의 내역을 전산출력하여 전표번호를 확인 후 화물의 배송경로를 추적하고 배송이상의 유무를 확인한다. 파손 또는 분실된 화물의 보상계획을 수립하여 관계부서에 의뢰한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","certLic":"물류관리사","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001681:1', '{"dJobCd":"K000001681","dJobCdSeq":"1","dJobNm":"운행분석원","workSum":"버스, 택시, 화물차량 등의 업무능률을 향상시키고 경제적으로 운행하기 위하여 운행시간과 속도, 운행대기시간 등을 조사·분석한다.","doWork":"운행을 완료하고 복귀한 차량의 운행확인서를 회수하고 지정운행시간과 실제운행시간, 지연운행과 대기사유, 승무원의 사용경비 등을 점검·파악한다. 차량의 타코그래프(Tacho Graph:운행속도 및 주행거리를 기록하는 장치)를 회수하여 정체·정속·과속 여부를 점검한다. 차량별 운행사고, 운행시간 등을 계산한다. 승무원별 운전시간, 사고, 경비 등을 계산한다. 조사·분석한 자료를 기준으로 운행노선의 시간, 경비, 속도 등을 검토하여 보고자료를 작성한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"협의","workFunc3":"수동조작","similarNm":"운행분석사무원","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H492/H493","dJobICdNm":"[H492]육상 여객 운송업 / [H493]도로 화물 운송업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006102:1', '{"dJobCd":"K000006102","dJobCdSeq":"1","dJobNm":"유람선운항사무원","workSum":"운항에 필요한 배선계획을 수립하고 인원을 배치하며 선박을 관리한다.","doWork":"유람선운영관리자의 지시에 따라 배선계획을 수립한다. 선박성능저하, 기상 등 특이사항과 매표원 및 홍보사무원으로부터 전달받은 날짜별 예약상황을 집계·정리하여 배선계획에 반영한다. 유람선선장, 기관장에 대한 인사, 기능, 경력에 관한 자료를 검토하여 선박을 배정한다. 승무원의 기능을 파악하여 적절하게 할당하고 각 지점의 매표소에 전달한다. 인원이 부족할 경우 조달방법을 강구하여 실행한다. 유람선선장으로부터 선박에 필요한 각종 물품, 기계부품 등의 선용품에 대한 의뢰를 받아 정기구매를 한다. 선원의 보험 및 각종 증명서 관련 업무를 한다. 선박정기검사증서 등 문서를 작성 및 관리한다. 선박검사계획을 유람선운영관리자와 협의하여 수립한다. 검사 시에는 검사관과 동행하여 검사를 주관한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H501/H502","dJobICdNm":"[H501]해상 운송업 / [H502]내륙 수상 및 항만 내 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006361:1', '{"dJobCd":"K000006361","dJobCdSeq":"1","dJobNm":"인쇄물우송관리원","workSum":"신문, 정기간행물, 책자 등 각종 인쇄물을 우송하거나 배달하기 위한 제반 업무를 수행하는 작업원들의 활동을 감독·조정한다.","doWork":"각종 인쇄물을 배달 및 우송하기 위한 세부작업계획과 목록을 작성한다. 작성된 작업계획과 목록을 인쇄물우송원에게 전달하고 세부작업을 지시한다. 우송할 지역의 우송명부에 우송할 내역을 기록한다. 수화물요금, 우편요금 리스트, 운송수단의 운행시간표 등을 파악하여 보관한다. 수송업무를 수행하는 데 필요한 인력, 재료, 소요시간 등을 산출한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H493","dJobICdNm":"[H493]도로 화물 운송업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001402:1', '{"dJobCd":"K000001402","dJobCdSeq":"1","dJobNm":"전동차검수사령원","workSum":"운행 중인 전동차에 고장이 발생 시 신속하고 안전하게 처리를 한다.","doWork":"전동차의 돌발고장 발생 시 기관사가 고장을 조치할 수 있도록 무선으로 내용을 파악하여 구체적으로 대처방법을 지시한다. 열차운행에 지장이 적게 미치는 전동차 고장은 각 차량사무소에 파견되어 있는 기동검수원을 출동시켜 해결한다. 각 차량사무소 예비차량 및 고장차량, 고장차량 수리여부를 파악하여 전동차 본선운행에 지장이 없도록 한다. 차량고장 접수 및 조치사항을 정리하고 고장속보를 작성한다. 특수상황 발생 시 현장에 출동하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","similarNm":"검수사령원","certLic":"철도차량기사, 철도차량산업기사","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H492","dJobICdNm":"[H492]육상 여객 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001419:1', '{"dJobCd":"K000001419","dJobCdSeq":"1","dJobNm":"전동차설비사령원","workSum":"원활한 열차운행을 위하여 종합사령실에서 선로의 장애여부를 파악하고 장애발생 시 관련 부서에 통보하여 복구하도록 조치한다.","doWork":"레일균열, 토목구조물장애 및 기타 선로장애상황이 발생하면 이를 접수하여 서행운전을 무선상으로 승무원에게 지시한다. 긴급복구할 상황이 접수될 경우 관계부서로 통보하며 인력과 장비동원의 협조요청을 한다. 선로차단공사 시행 시 운전사령원에게 통보하여 안전운행을 하도록 한다. 보선 모터카(트로리)의 출·입고를 모니터와 상황판을 통하여 확인하고 운행현황을 파악한다. 보선 분소간 모터카 운행을 조정한다. 철도장비사무소 인원 및 작업사항을 파악하고 조정한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","certLic":"전기기사, 전기산업기사, 전자기사, 전자산업기사, 정보처리기사, 정보처리산업기사","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H492","dJobICdNm":"[H492]육상 여객 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003406:1', '{"dJobCd":"K000003406","dJobCdSeq":"1","dJobNm":"전동차승무원운용사무원","workSum":"전동차승무원의 직무적성 및 직무능력에 따라 전동차승무원승무다이아(승무계획표)를 작성하고 전동차승무원의 운용실적을 관리·감독한다.","doWork":"지하철 각 호선별 운전계획다이아(Diagram:열차운행시간표)를 토대로 전동차승무원승무다이아(승무계획표)를 작성한다. 비상시 대비 운전계획다이아에 따라 전동차승무원근무다이아 및 인력운용계획을 수립한다. 전동차승무원승무다이아 및 인력운용계획에 따른 전동차승무원의 운용실적을 관리·감독한다. 열차의 안전운행을 위해 전동차승무원의 직무적성 및 직무능력을 검사하여 전동차승무원운용계획에 참조한다. 전동차승무원의 고충사항을 파악하고 해소하는 업무를 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H492","dJobICdNm":"[H492]육상 여객 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002219:1', '{"dJobCd":"K000002219","dJobCdSeq":"1","dJobNm":"전동차여객사령원","workSum":"여객수송 통제 및 제한 지시를 하며, 지하철 이용안내, 이용불편신고센터 운영전반을 관장하며, 역시설물 파손, 승객부상 등이 발생하면 조치를 취한다.","doWork":"영업준비상태를 역무소에서 수합하여 보고를 받는다. 영업준비가 지연되는 역에 대해서는 역무소 및 인근역에 확인을 지시하고 여객수송에 차질을 초래할 경우 보고를 한다. 사고발생 시 승차권 발매제한을 지시하고 상황이 수습되면 발매재개를 지시한다. 승객의 유동상태를 파악하여 수송을 조정한다. 승객유도 및 안내방송을 지시한다. 일제방송을 지시한다. 열차지연 등으로 승객이 요금반환요구 시 규정에 의거 반환지시를 내린다. 해당 역에서 단체승객에 대하여 보고를 받은 후 도착역에 통보한다. 단체승객수송을 위해 임시열차운행이 필요하다고 판단될 때에는 운전사령원과 협조하여 임시열차운행을 한다. 각 역, 철도청, 자동요금징수장치(AFC:Automatic Fare Collection System) 통제실로부터 승차권 판매실적, 반환실적을 취합하여 기록·유지한다. 열차지연, 화재발생, 독가스살포 등의 긴급사태 발생 시 중앙통제방송을 실시한다. 지하철이용안내센터를 운영하고 안내실적을 분석한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H492","dJobICdNm":"[H492]육상 여객 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002629:1', '{"dJobCd":"K000002629","dJobCdSeq":"1","dJobNm":"전동차역무사무원","workSum":"역사시설물을 순회점검하고 보수시행을 관리·감독하며 발매기, 개·집표기 관리 등 역무업무를 총괄 지도한다.","doWork":"역사운영업무를 총괄한다. 소속 직원의 인사관리를 하며 각종 지시사항을 전달하고 교육한다. 지시공문을 처리하고 일일 결산업무를 점검 총괄한다. 자동요금징수장치(AFC:Automatic Fare Collection) 장비상황, 승차용지 롤지 등 필요자재 수급관리를 총괄한다. 역사 시설물 유지·관리업무를 총괄한다. 제반 시설물을 순회점검하고 이상발견 시 조치업무를 총괄한다. 청소상태를 점검하고 독려한다. 역무업무 지도감독을 총괄한다. 주간·월간 안전점검계획 및 수행을 총괄 지시한다. 안전회의를 소집하여 직원들에게 안전대책수립을 지시한다. 개·집표기 및 발매업무를 총괄 감독하여 승객의 불편함을 제거한다. 매표업무, 발권기업무, 구내업무, 수입금관리업무 등을 지시 감독한다. 잡상인 단속업무를 지휘한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H492","dJobICdNm":"[H492]육상 여객 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005649:1', '{"dJobCd":"K000005649","dJobCdSeq":"1","dJobNm":"전동차운수계획사무원","workSum":"수송수요와 수송능력을 분석하여 중·단기수송계획과 전동차 증차계획을 수립하고 승객유치 및 수송수요 증대방안을 수립한다.","doWork":"수송수요를 예측분석하고 중·단기수송계획을 수립한다. 수송실적을 분석하고 수송통계시스템(UTPS)를 운영하여 일·월·년간 수송수와 호선별 수송수요를 예측하고 수송능력을 분석하여 중·단기수송계획을 수립한다. 지하철 운영개선을 위한 설문조사를 실시하여 승객유치 및 수송수요 증대대책을 기획한다. 수송목표를 설정하고 타 운송기구 연계수송계획을 수립한다. 역별로 수송목표를 부여하여 수송계획서를 작성하고, 분기별로 역단위 수송목표관리실적을 평가한다. 역무자동화기기 운영계획 및 기능배치계획을 한다. 수송통계시스템 운영계획을 확정하고 수송능력분석 및 전동차 증차계획을 한다. 역주변 문화권 정보를 수집·관리·분석한다. 역명칭 제정변경 및 무임승차 대책수립을 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H492","dJobICdNm":"[H492]육상 여객 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006356:1', '{"dJobCd":"K000006356","dJobCdSeq":"1","dJobNm":"전동차운수관리사무원","workSum":"지하철이용승객의 편의를 위하여 역사홍보 및 시설관리 등 역무전반에 관한 사항을 관리한다.","doWork":"사고처리 및 여객안전사고 방지를 위해 질서캠페인을 실시하고 실적을 수합하여 보고한다. 운수영업선전 및 자체홍보와 안내방송을 지도한다. 역무지도 관련 민원처리업무를 지시·감독한다. 지하철 고객불편신고전화를 운영한다. 역무원 미담사례를 발굴하여 관리한다. 정기권 지정학교에 관한 사항과 승차권 위탁판매 수수료 징수업무를 관리한다. 역사 내 각종 편의시설물 유지관리 및 기능유지를 관리한다. 역 구내청소용역 계약을 하고 비품수급관리를 한다. 유실물센터를 운영하고 역 구내식당 운영을 지도한다. 공중전화, 전기사용료, 식당전기료 및 식당수도료 징수 및 에너지절약에 관한 업무를 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"감독","workFunc3":"관련없음","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H492","dJobICdNm":"[H492]육상 여객 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002188:1', '{"dJobCd":"K000002188","dJobCdSeq":"1","dJobNm":"전동차운수사령원","workSum":"열차운행통제 및 열차감시를 하여 열차의 안전운행을 도모한다.","doWork":"열차운행 혼란 시 운전정리를 하며 입출고열차를 감시한다. 신호기 및 전철기(전기선로전환기)의 동작상태를 확인한다. 상황에 따라 중앙집중제어를 하며 열차운행표에 의한 정보를 입력시키는 동시에 컴퓨터의 정상적 동작상태를 확인하고 감시한다. 대형감시판 및 모니터를 통해 열차운행을 감시한다. 열차종합제어(TTC:Total Traffic Control)장치를 취급한다. 주전산기의 제어정보출력을 확인하고 정보를 조작하며 라인프린터로 출력되는 정보를 기록·관리한다. 각 분야의 야간작업을 확인하고 긴급연락을 취한다. 신호 및 전철기를 모니터상으로 확인하고 입력정보를 조정하고 전철기를 확인한다. 급·단전 이상 유무를 확인한다. 입출고열차의 차량상태를 확인한다. 사고열차와 지연열차에 대한 회복운전을 지시한다. 열차를 모니터를 통해 감시하고 열차간격을 조정한다. 임시열차를 운행하고 전동차 운행변경에 관계한다. 운행지장에 대한 회복조치를 취한다. 수시로 열차의 운행상태를 확인한다. 열차에 직접 승차하여 운전현장을 파악하고 장애요소를 확인한다. 야간작업을 승인한다. 무전기 녹음장치를 확인 관리한다. 임시열차운영계획표(다이아) 입력 작성 및 운행정리사항을 기록한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H492","dJobICdNm":"[H492]육상 여객 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006512:1', '{"dJobCd":"K000006512","dJobCdSeq":"1","dJobNm":"전동차운전계획사무원","workSum":"열차기본운전계획에 따라 열차다이아(Diagrma:운행표), 운전시각표, 전동차운행표 등을 작성하고, 열차운행계획의 수립 및 개정업무를 한다.","doWork":"기존노선에 대하여 선로조건, 전동차 성능, 신호장치 조건, 전기설비 조건 등을 반영하여 주간운전 시·분 산정 및 운행노선 소요운전 시·분을 산정하고 승무원 증원 및 전동차증차계획의 기본자료를 작성한다. 신설노선 및 연장노선 운전계획을 수립한다. 수송수요 및 보유차량을 고려하여 운행노선의 편성량, 운행시간 간격, 열차회수를 결정한다. 열차운행다이아(열차의 시간대별 위치를 알 수 있는 그래프) 및 전동차운행표를 작성한다. 임시열차운행계획을 수립한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"관련없음","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H492","dJobICdNm":"[H492]육상 여객 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005693:1', '{"dJobCd":"K000005693","dJobCdSeq":"1","dJobNm":"차량사고처리원","workSum":"회사에 소속되어 있는 영업택시, 버스 및 화물차와 관련한 사고발생 시 원인을 확인하고 사고를 처리한다.","doWork":"사고발생시 보고를 받고 사고발생을 접수한다. 경미한 사고인 경우 사고차량번호, 운전기사, 사고원인 및 사고범위 등 현장상황에 대한 운전기사의 설명을 듣고 사고처리방법을 제시한다. 운전기사가 촬영한 사진 및 약도를 확인하고, 가해자 및 피해자와 면담하여 과실을 규명한다. 경찰서 및 보험회사와 협의하여 보험 및 보상에 필요한 서류자료를 준비·작성하여 이관한다. 대형사고의 경우 사고현장에 출동하여 사고상황을 파악한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"시각|","workFunc1":"수집","workFunc2":"협의","workFunc3":"관련없음","similarNm":"차량사고처리사무원","connectJob":"버스사고처리원, 택시사고처리원, 화물차사고처리원","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H492","dJobICdNm":"[H492]육상 여객 운송업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001711:1', '{"dJobCd":"K000001711","dJobCdSeq":"1","dJobNm":"철도역무원","workSum":"철도역에서 교통카드 판매충전, 역무자동화기기 관리, 운수수입금 관리, 고객응대 및 서비스 등의 역무업무를 수행한다.","doWork":"승차권의 예약 및 발매을 한다. 역 수입금 및 발매기 정산업무를 한다. 승차권류의 수령 및 불출업무를 한다. 열차시각표 안내, 철도이용객 승·하차 안내, 자동발매기 및 각종 고객 편의시설 안내, 장애인, 노약자, 각종 고객 문의사항 등을 안내한다. 여객 및 화물열차의 조성을 위한 연결, 분리, 전호(수신호 및 무선전호), 열차조성계획 수립 및 시행 등의 업무를 한다. 국내외 여행상품 판촉 및 안내, 여행상품 판매시스템을 활용 판매 및 실적 점검, 단체고객 유치 및 고객 DB관리, 대외기관 방문홍보 및 여행업계와 교류 등의 업무를 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"철도역무원, 지하철역무원","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H491","dJobICdNm":"[H491]철도 운송업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003032:1', '{"dJobCd":"K000003032","dJobCdSeq":"1","dJobNm":"컨테이너게이트관리원","workSum":"컨테이너터미널에 반출입되는 컨테이너를 관리 및 통제한다.","doWork":"컨테이너의 반출입 전산자료를 확인하여 오류를 파악하고 수정한다. 컨테이너터미널의 게이트를 통과하는 컨테이너 및 차량의 번호를 PDA에 입력한다. 반출입 차량을 통제하고 차량이 많을 시 원활한 소통을 유도한다. 위험물컨테이너, 손상된 컨테이너 등은 코드 및 담당자를 확인한 후 반출입을 허가한다. 반출허용기간을 초과한 컨테이너를 파악하여 반출을 촉구한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"가벼운 작업","workPlace":"실외","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005311:1', '{"dJobCd":"K000005311","dJobCdSeq":"1","dJobNm":"컨테이너부두상황실통제원","workSum":"컨테이너터미널의 상황실(C/C:Control Center)에서 플래너가 계획한 양적하작업을 통제한다.","doWork":"당일 작업해야 할 작업량을 파악하고 반입컨테이너의 목록을 접수한다. 야드의 상황에 따라 운송업자, 선사와 협의하여 게이트 반출입을 통제한다. 컨테이너작업현황을 컴퓨터를 통해 모니터링한다. 계획된 업무의 수행여부를 파악하고 차질이 있을 경우 대안을 마련한다. 선박화물양적하작업관리자, 선박화물양적하작업사무원, 게이트관리원과 유무선으로 연락하며 작업을 지시하고 상황을 전달한다. 장비배차를 의뢰하고 작업변동상황을 확인하여 장치위치를 수정한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004514:1', '{"dJobCd":"K000004514","dJobCdSeq":"1","dJobNm":"컨테이너부두운영사무원","workSum":"컨테이너부두에 대한 마케팅전략 수립, 선사와의 터미널 이용계약 체결 등 터미널운영에 필요한 제반 사항을 수행한다.","doWork":"경쟁터미널(부두) 및 해외선진터미널 자료를 수집하여 항구 마케팅전략을 수립한다. 항구에 기항하는 선사의 실태 및 경쟁터미널의 실태를 파악하여 대응전략을 수립한다. 신규물량을 유치한다. 대형선사와의 터미널 이용에 따른 제반 계약을 체결한다. 선사의 요구를 수렴하여 터미널 운영기법의 현대화 추진에 참여한다. 터미널 운영의 각종 신기법 및 시스템을 기획하고 제언한다. 설문지, 인터넷, 전화, 직접방문 등을 활용하여 고객의 요구사항을 접수하여 해소방안을 강구하거나 외부 요구사항 및 자체 개선사항을 취합·검토하여 합리적인 하역요율이 달성되도록 운영한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"협의","workFunc3":"관련없음","similarNm":"국제컨테이너부두마케터","certLic":"물류관리사","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006334:1', '{"dJobCd":"K000006334","dJobCdSeq":"1","dJobNm":"컨테이너부두운영정보관리원","workSum":"모선입출항정보, 컨테이너의 종류, 컨테이너 크레인의 가동시간 등 컨테이너부두 운영에 필요한 각종 정보를 입력하고 관리한다.","doWork":"컨테이너부두의 월별, 선석(船席:Berth,선박이 계류하는 선창)별 모선입출항정보를 입력하고 일일선석배정표를 발행한다. 모선별로 코드, 재원, 선창구조, 양하지코드를 관리한다. 선적취소 및 모선이 변경된 컨테이너를 파악한다. 컨테이너 번호, 컨테이너 종류에 관한 정보를 입력하고 관리한다. 컨테이너부두의 반입·반출물량을 파악한다. 모선별로 컨테이너 크레인의 가동시간과 가동시간별 컨테이너 처리갯수를 입력하고 가동중단시간을 계산하여 크레인별 작업능률을 분석·관리한다. 부두별 선석점유율 통계를 관리한다. 일일 체선현황, 장치현황, 반입·반출현황을 작성하여 보고한다. 선박작업일지(Vessel Operation Log)를 작성하고 관리한다. 직통관, 보세운송처리실적, 일반잡화작업처리실적, 월간 처리실적을 관리한다. 신규 선사의 입항스케줄을 조정하거나 선사 및 대리점 관련 정보를 수집하여 분석하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"관련없음","certLic":"물류관리사","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001758:1', '{"dJobCd":"K000001758","dJobCdSeq":"1","dJobNm":"컨테이너부두정보화기획원","workSum":"컨테이너부두 운영부서에서 양하적계획을 수립하고 전산처리한다.","doWork":"컨테이너부두의 양적하계획(먼저 내리는 화물이 가장 윗쪽에 선적되도록 계획함)을 수립한다. 자사의 월간 선석운영계획, 일일 선석운영계획, 양하적작업계획, 선적작업계획, 야드운영계획, 야드장치계획을 관리한다. 통관, 보세운송, 터미널이용요금 정산 등 컨테이너 운영내역을 전산화하고 통계처리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"관련없음","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002988:1', '{"dJobCd":"K000002988","dJobCdSeq":"1","dJobNm":"컨테이너작업정산사무원","workSum":"컨테이너부두 사용에 대한 요금을 계산한다.","doWork":"본선작업(선박을 접안시킨 상태에서 선박으로부터 직접 화물을 내리거나, 선박에 싣는 작업)관련 서류를 접수한다. 모선별 양하·적하컨테이너의 수량을 확인하고 수정한다. 모선별 할증요금, 경과보관, 반송(Return), 재조작, 구내 이적 컨테이너에 관한 자료를 전산에 입력하고 컨테이너부두 사용요금 청구자료를 발행한다. 일반화물작업과 관련된 서류를 접수하고 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"계산","workFunc2":"서비스제공","workFunc3":"관련없음","certLic":"물류관리사","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005337:1', '{"dJobCd":"K000005337","dJobCdSeq":"1","dJobNm":"컨테이너장비배차원","workSum":"컨테이너의 양적하 및 컨테이너 야드(CY:Container Yard) 장치에 필요한 모든 장비운영을 통제한다.","doWork":"갠트리크레인, 트랜스퍼크레인, 리치스태커, 야드트랙터, 엠티핸들러 등의 컨테이너터미널 장비의 사용요청에 따른 계획을 수립한다. 배차지시서를 작성하고 운전기록부를 관리한다. 장비의 사용현황을 정리하고 장비점검 및 예방정비를 한다. 장비배차 및 작업통계를 유지하고, 장비조작원의 업무상황을 파악한다. 장비조작원의 안전교육을 실시한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002373:1', '{"dJobCd":"K000002373","dJobCdSeq":"1","dJobNm":"컨테이너플래너","workSum":"선사의 요구에 따라 입항스케줄, 접안위치를 배정하고 화물의 양적하작업순서, 부두장치계획을 작성한다.","doWork":"선석신청서를 접수받아 선박의 스케줄, 특성, 작업관련 정보와 컨테이너크레인 가동상황 등을 파악하여 선적배정표를 작성한다. 선석을 배정하고 컨테이너기중기 배정시간을 조정한다. 선박의 입항시간 또는 작업예정물량의 변동 등이 발생되면 선석배정스케줄을 재조정한다. 양적하작업계획을 수립한다. 모선입항계획을 확인하고 선석이 확정된 선박에 대하여 선석예정물량표를 작성한다. 야드상황을 감안한 본선하역작업이 될 수 있도록 모선별 세부장치계획을 수립한다. 선박점유율 및 체선 관련 자료에 대한 통계를 관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006921:1', '{"dJobCd":"K000006921","dJobCdSeq":"1","dJobNm":"컨테이너화물집하장검수원","workSum":"컨테이너화물집하장(CFS:Container Freight Station)에 배정된 화물의 종류, 수량 등 화물의 상태 및 이상 유무를 검수한다.","doWork":"컨테이너화물집하장(CFS:Container Freight Station)에 장치되는 화물의 적입·적하목록, 컨테이너번호 및 봉인번호를 확인한다. 포장상태, 제품의 파손 및 수량 등을 확인한다. 파손된 화물의 수량 및 분실량 등을 확인하여 선박회사 및 세관에 통보한다. 검수결과에 따른 검수표를 작성하고, 관련서류를 작성하여 발급한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"체커(Checker), CFS검수원","certLic":"검수사","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004695:1', '{"dJobCd":"K000004695","dJobCdSeq":"1","dJobNm":"컨테이너화물집하장수입사무원","workSum":"컨테이너화물집하장(CFS:Container Freight Station)에 입고된 수입화물, 환적화물, 직통관인출 및 보세운송화물을 관리한다.","doWork":"화주 및 선사로부터 적하목록을 접수한 후 전산상의 관련 서류를 확인하고 수입면장과 화물인도지시서(D/O:Delivery Order)를 전자문서(EDI:Electronic Data Interchange)에 입력한다. 작업관리대장을 정리하며 작업종류, 작업시기 및 유의사항을 컨테이너화물집하장(CFS:Container Freight Station)에 통보하고 작업진행사항 및 변동사항을 협의한다. 전자문서(EDI)에 반출입계를 작성하고 직통관 인출 및 보세운송 적출작업을 지시한다. 환적(T/S:Transhipment)작업 시에는 화주 및 선사로부터 적하목록을 접수한다. 작업 시 필요한 톤수와 수량을 확인하고 적하목록 및 관련 서류를 수입창고관리원에게 전달하고 출고작업을 지시한다. 관리대장을 기재하고 전자문서(EDI)에 반출입계를 작성한다. 컨테이너화물조작장 작업과 이용에 관한 문의에 답변한다. 타 부두 이용 화물을 자사 부두로 유치하기 위한 홍보활동을 하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"관련없음","similarNm":"CFS수입사무원","certLic":"보세사","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004497:1', '{"dJobCd":"K000004497","dJobCdSeq":"1","dJobNm":"컨테이너화물집하장수출사무원","workSum":"컨테이너화물집하장(CFS:Container Freight Station)으로 입고되는 수출화물의 반입부터 반출에 이르는 제반 절차를 관리한다.","doWork":"화주 및 운송업자 등으로부터 도착된 화물에 대해 반입확인을 하고 전산상에 입력하여 세관에 전송한다. 화물에 대한 수출면장과 포장명세서(Packing List)를 접수하여 컨테이너화물집하장(CFS:Container Freight Station)에서의 작업을 협의한다. 화물에 대한 정보를 컨테이너화물집하장(CFS)수출창고관리원 및 컨테이너관리원에 전달한다. 선적스케줄이 변경된 화물에 대한 정보를 입력한다. 입고된 화물에 대한 자료와 적재순서에 따른 화물출고자료를 반출입대장에 기재한다. 선사에서 발행한 컨테이너내적치표(CLP:Container Load Plan)를 확인하고 전산상에 입력한다. 반출주문에 따라 검수회사의 입회하에 빈 컨테이너에 화물을 채우는 작업(적입작업:Vanning or Stuffing)을 한 후 관련 서류를 작성한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"관련없음","similarNm":"CFS수출사무원","certLic":"보세사","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006111:1', '{"dJobCd":"K000006111","dJobCdSeq":"1","dJobNm":"탑승수속사무원","workSum":"공항에서 출국 예정인 승객의 신분을 확인하고 탑승권을 교부한다.","doWork":"항공기의 시간별 예약 및 운항상황을 확인한다. 항공기 탑승을 원하는 승객의 항공권 및 여권을 통해 시간, 기간, 목적지를 확인하고 좌석을 결정하여 탑승권을 교부한다. 승객의 수하물 포장상태, 내용 등을 확인하고 무게를 측정하여 자료를 입력한다. 초과중량에 대하여 요금을 계산하고 수하물보관표를 발행한다. 승객에게 탑승방법 및 시간을 안내한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"단순작업","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H511","dJobICdNm":"[H511]항공 여객 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004285:1', '{"dJobCd":"K000004285","dJobCdSeq":"1","dJobNm":"택시배차원","workSum":"택시운전기사를 파악하여 택시차량을 배차하고 운행을 통제한다.","doWork":"택시운전기사 성격 및 차량현황을 파악하여 주·야간운행계획을 수립한다. 신입 택시운전기사가 들어오거나 택시운전기사의 요청이 있을 시 배차를 조정한다. 배차한 차량 및 택시운전기사의 탑승여부를 확인하고 기록한다. 미터기 및 내비게이션 시스템, 디지털 운행기록계, 한국교통안전공단이 운영하는 택시운행정보관리 시스템 등을 이용하여 택시운전기사의 운행상황을 파악하고 운송수입금을 확인한다. 차량의 이상 유무, 예비운전기사 등을 파악하여 배차를 조정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H492","dJobICdNm":"[H492]육상 여객 운송업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002009:1', '{"dJobCd":"K000002009","dJobCdSeq":"1","dJobNm":"특수화물취급원","workSum":"특수화물(컨테이너화물이 아닌 각종 화물)에 대한 하역을 실행한다.","doWork":"특수화물(벌크화물, 냉동·냉장화물, 생·동·식물화물, 위험물 등 특별한 운송장비 또는 취급이 필요한 화물)작업요청서를 접수하여 내용을 확인한다. 하역작업 가능시간을 확인하고 통보한다. 특수화물 취급방법에 따라 적절한 하역장비와 인원을 배치한다. 하역현장을 점검한다. 컨테이너 야드 차량의 상차작업을 확인한다. 작업완료 후 수입면장(Import Permits:輸入免狀)을 작성한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003208:1', '{"dJobCd":"K000003208","dJobCdSeq":"1","dJobNm":"플라이트마스터","workSum":"항공화물의 적재 및 하역업무를 총괄하고, 관련 종사자들의 작업을 감독한다.","doWork":"탑재계획표를 통해 적재 및 하역할 화물을 확인한다. 화물의 수량 및 번호를 확인하여 화물의 적재 및 하역작업을 지시한다. 여객기 탑승자의 목록과 탑재된 수하물번호를 비교하고, 탑승하지 않은 승객의 수하물을 하역하도록 지시한다. 관련 종사자들의 업무를 통제·감독한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workEnv":"위험내재|고온|저온|다습|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","similarNm":"FM감독, FM매니저","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H511/H512","dJobICdNm":"[H511]항공 여객 운송업 / [H512]항공 화물 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004593:1', '{"dJobCd":"K000004593","dJobCdSeq":"1","dJobNm":"항공운항계획관리원","workSum":"항공기의 운항계획에 따라 운항규정, 항공법 등의 제반 규정에 의거하여 승무원들의 개인비행계획을 작성·관리한다.","doWork":"기종별로 항공기의 운항계획에 따라 승무원의 배치현황판을 작성한다. 승무원들의 교육 및 훈련계획, 건강상태 등을 파악하여 비행이 불가능한 시간 및 기간을 파악한다. 승무원들의 운항경험을 고려하여 장거리·중거리·단거리항로의 비행계획을 수립한다. 항공법, 운항규정 등의 제반 규정을 검토하여 개인의 비행계획을 작성한다. 비행계획표를 게시판에 게시하고 개인에게 통보한다. 항공기의 정비, 보수, 승무원의 개인사정 등에 따라 비행계획을 조정한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"계산","workFunc2":"협의","workFunc3":"관련없음","similarNm":"비행계획관리원","connectJob":"승무원들의 비행시간을 전문으로 관리하는 경우 운항시간관리원","certLic":"항공운항관리사","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H511/H512","dJobICdNm":"[H511]항공 여객 운송업 / [H512]항공 화물 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003861:1', '{"dJobCd":"K000003861","dJobCdSeq":"1","dJobNm":"항공운항관리원","workSum":"비행의 안전성, 경제성, 신속성 및 쾌적성을 달성하기 위하여 비행의 잠재적 위험을 판단하고 안전성 확보를 위한 업무를 수행한다.","doWork":"항공노선에 따라 최소 연료탑재 기준, 비행거리, 정비제한, 항공기의 기종을 종합하여 비행안전을 확보할 수 있는 연료량을 계산한다. 항공기에 탑재할 화물의 종류 및 수량, 승객인원 등을 파악하여 최대허용 이륙중량 및 착륙중량을 산출한다. 운항거리 및 기상상태 등을 고려하여 급유량을 결정한다. 운항노선, 사용기종, 출발시간, 영공 통과시간, 운항고도, 비행속도, 도착지, 운항예정시간, 비상호출신호, 기장성명, 항공기번호 등을 정리하여 비행계획서를 작성한다. 비행기의 출발을 승인하는 운항허가서를 준비하고 서명한다. 만약, 항공기 또는 승객의 안전을 위협하는 상황이 판단되면 그 비행을 지연 또는 취소한다. 기장에게 비행계획을 설명하고 관련내용을 협의한다. 기장 및 부기장이 작성한 비행일지를 검토하여 문제점을 확인하고 해결방안을 분석한다. 비상상황이 발생하면 운항규정에 규정된 절차에 따라 초동조치한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"계산","workFunc2":"협의","workFunc3":"수동조작","similarNm":"항공운항관리사","certLic":"항공운항관리사","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H511/H512","dJobICdNm":"[H511]항공 여객 운송업 / [H512]항공 화물 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004080:1', '{"dJobCd":"K000004080","dJobCdSeq":"1","dJobNm":"항공운항통제사무원","workSum":"항공기 운항에 필요한 사항을 통제하고, 기상변화, 항공기의 성능저하, 활주로 이상 등으로 정상적인 운항을 할 수 없을 경우에 임시운항계획을 수립하여 추진한다.","doWork":"기상상태, 활주로의 이상 등의 운항저해요인을 파악하고 운항시간의 연기 및 착륙장소의 현황을 검토한다. 기상변화, 항공기의 비상사태발생 등으로 인한 착륙이 불가능할 경우 상황을 파악하여 회항 또는 선회를 기장에게 지시한다. 예약승객의 증가로 인하여 항공기의 증편이 요구될 때 승무원의 대기현황, 예비항공기의 대기현황, 공항의 기상상황 등을 검토하여 임시여객기를 준비한다. 항공노선, 운항시간, 기종의 변경 등에 관한 자료를 정리하여 관계당국에 허가를 신청한다. 기상의 악화, 항공기의 성능저하 등의 비상사태로 인하여 착륙이 불가능할 경우 항공교통관제사와 협의하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"협의","workFunc3":"관련없음","similarNm":"운항통제사무원","certLic":"항공교통관제사","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H511/H512","dJobICdNm":"[H511]항공 여객 운송업 / [H512]항공 화물 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006412:1', '{"dJobCd":"K000006412","dJobCdSeq":"1","dJobNm":"항공화물물류센터운송사무원","workSum":"항공화물 물류센터(포워더물류센터)에서 항공화물운송에 관련된 제반 사무를 한다.","doWork":"포워더물류센터의 물류스케줄을 확인하여 일일업무를 파악한다. 선적서류(항공운송장:Air Waybill)를 수취하고 서류를 분류한다. 항공운임을 표기 및 수정한다. 납품목록(Delivery List)을 작성한다. 선적서류를 보세운송업체에 전달한다. 일일업무를 마감한다. 항공사로부터 부적합화물(사고화물) 통보를 받으면 관련 서류를 작성하고 항공사보류장으로 이동하여 보수작업 및 사진촬영을 한다. 적하목록을 정정한다. 파손(Demage)협정(짐받이대(SKID)풀림, 흘러내림, 찍힘, 터짐 등)에 따라 처리하고 보류장 담당자의 확인을 받는다. 보세, 통관진행 시 사고화물이 발생하면 현장으로 이동하여 사고처리하고 클레임(Claim)을 접수한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workEnv":"소음·진동|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"관련없음","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003114:1', '{"dJobCd":"K000003114","dJobCdSeq":"1","dJobNm":"항공화물지상조업통제원","workSum":"지상조업사에 소속되어 지상조업활동을 통제·관리·운영한다.","doWork":"조업사의 종합통제센터를 운영하며 항공기 지상조업을 전체적으로 통제한다. 항공기의 운행정보 및 조업정보를 관리하고 조업현장에 전파한다. 조업단위별 진행상황 및 특이사항을 모니터링하고 문제가 발생하면 대응조치를 한다. 비상조업대책을 수립하고 관리한다. 외항사업무 및 조업절차를 관리한다. 지점공항과 운영을 연계한다. 램프(RAMP:여객의 탑승·하기, 화물의 적재, 항공기의 정비점검, 연료보급 등을 위해 설치된 비행장의 일정지역으로 터미널빌딩 및 정비지구에 인접한 지역)화물 조업운영계획 및 안전품질, 생산성 관리계획을 수립하고 운영한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"감독","workFunc3":"단순작업","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001356:1', '{"dJobCd":"K000001356","dJobCdSeq":"1","dJobNm":"항공화물탑재관리사","workSum":"항공기의 허용중량 범위에서 화물을 최대한 탑재할 수 있도록 화물 및 승객수하물의 탑재위치를 조정한다.","doWork":"항공기의 운항계획을 검토하여 운행시간, 기종, 항로 등을 파악하고 변동사항을 점검한다. 적재된 화물편중으로 인한 운항항공기의 추락을 예방하기 위해 항공기에 탑재할 화물 및 승객수화물의 특성을 파악하고 무게를 산정한다. 항공기의 중량, 공간 및 균형을 고려하여 항공화물을 담기 위한 컨테이너 또는 팔레트 등의 항공화물탑재용기(ULD:Unit Load Device)를 선택하고 탑재계획을 수립한다. 탑재수량 및 위치를 결정하고, 플라이트마스터에게 관련 자료를 전달하고, 탑재작업의 진행상황을 확인한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","similarNm":"항공로드마스터","connectJob":"취급대상에 따라 화물로드마스터, 여객로드마스터","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H511/H512","dJobICdNm":"[H511]항공 여객 운송업 / [H512]항공 화물 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002636:1', '{"dJobCd":"K000002636","dJobCdSeq":"1","dJobNm":"항공화물탑재용기관리원","workSum":"항공화물터미널에서 단위탑재용기(ULD)의 공급·수급·관리업무를 수행한다.","doWork":"단위탑재용기 운영 및 재고관리시스템(ULD Movement & Inventory Control System)을 운용한다. 단위탑재용기(ULD:Unit Load Device) 관련 정보통신기술 자동화설비를 관리하고 운영한다. 단위탑재용기의 공급·수급스케줄을 확인한다. 단위탑재용기의 사용연한을 관리한다. 단위탑재용기 및 보조장치(Pallet에 적재하거나 단위탑재용기의 수송 등에 이용하는 지그, 고가이동활차(Dolly) 등의 기재), 포장용품 등을 관리하고 공급(구매)한다. 국제항공운송협회(IATA:International Air Transport Association)의 단위탑재용기 사용자그룹 사이에서 발생하는 단위탑재용기 거래를 관리한다. 지점(각 공항)에서 망실된 단위탑재용기의 회수업무를 수행한다. 단위탑재용기의 수리 및 폐기 업무를 진행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"감독","workFunc3":"단순작업","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003136:1', '{"dJobCd":"K000003136","dJobCdSeq":"1","dJobNm":"항공화물터미널수입화물운영원","workSum":"항공화물터미널에서 수입화물 운영업무를 수행한다.","doWork":"운항 중인 항공기(IN-FLIGHT)의 일일 물동량을 파악한다. 화물기의 중량차이(WT Difference) 확인 및 점검내역을 화물운송계약에 의해 운송이 시작되는 최초 출발지점(Origin)에 송부한다. 수입화물의 단위탑재용기(ULD:Unit Load Device)의 인수인계를 감독한다. 타 항공사 장치장 간 이동입고현황을 점검한다. 화물해체작업(Break Down) 현황을 관리·감독한다. 특별화물의 취급을 관리·감독한다. Damage(수송 중 화물의 외포장 및 내용품의 전부 또는 일부가 손상된 상태를 말하며 파손, 오손, 동물의 사상, 식물의 고사, 부패, 변질, 내용품의 등으로 인한 화물의 가치 및 효용성이 감소되는 것) 관련 업무를 수행한다. 하기·보세운송 관련 업무를 수행한다. 조업사 및 협력사의 활동을 관리한다. 수입화물 관련 검역원, 관세청 등 관계기관 관련 업무를 수행한다. 수입관련 수하물사고보고서(Irregularity Report:화물 또는 운송서류의 사고발생 시 출발지의 제1운송인에게 보내지는 서류)를 관리한다. 클레임(Claim) 관련 업무, 운송료 및 기타 수입금 관련 업무를 수행한다. 수송실적 통계자료를 작성하고 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workEnv":"소음·진동|","workFunc1":"분석","workFunc2":"감독","workFunc3":"관련없음","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001564:1', '{"dJobCd":"K000001564","dJobCdSeq":"1","dJobNm":"항공화물터미널수출화물운영원","workSum":"항공화물터미널에서 수출화물 운영업무를 수행한다.","doWork":"항공운송장(Air Waybill:송하인과 항공사 간에 화물운송 계약체결을 증명하는 서류. Air Consignment Note라고도 함)을 작성한다. 적하목록을 작성한다. 우편물의 항공수송에 필요한 운송장(Air Mail Delivery Bill)을 작성하기도 한다. 기장통보서(NOTOC:NOtification TO Captain,화물의 출발지 공항에서 항공기 기장에게 탑재된 화물 중 특수화물의 내용을 통보하는 서류)를 작성한다. CCA(Cargo Charges Correction Advice:운임의 오적용, 계산착오, 지불수단의 변경 등 운송장상의 기재사항을 변경하는 경우에 항공사가 작성하는 서류)업무를 수행한다. 수하물사고보고서(Irregularity Report:화물 또는 운송서류의 사고발생 시 출발지의 제1운송인에게 보내는 서류) 및 클레임 관련 업무를 수행한다. 수출화물의 대 세관·법무 관련 업무, 장치장관리 및 보안업무, 특수화물 관련 업무, 화물의 중량점검, 조업사관리 및 조업료심사, 창고료 정산업무를 수행한다. 수출화물 조업시간을 관리하고 통제한다. 수출수송실적 통계자료를 작성하고 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workEnv":"소음·진동|","workFunc1":"분석","workFunc2":"감독","workFunc3":"관련없음","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001339:1', '{"dJobCd":"K000001339","dJobCdSeq":"1","dJobNm":"항공화물터미널지상안전관리원","workSum":"램프(RAMP:여객의 탑승·하기, 화물의 적재, 항공기의 정비점검, 연료보급 등을 위해 설치된 비행장의 일정지역으로 터미널빌딩 및 정비지구에 인접한 지역)의 안전을 종합적으로 통제한다.","doWork":"RAMP(여객의 탑승·하기, 화물의 적재, 항공기의 정비점검, 연료보급 등을 위해 설치된 비행장의 일정지역으로 터미널빌딩 및 정비지구에 인접한 지역)의 안전점검 활동을 수행한다. 화물기의 탑재, 하기의 사전 준비상태를 점검한다. 단위탑재용기(ULD:Unit Load Device)의 작업상태 점검 및 탑재, 하기작업을 감독한다. 특수화물(벌크화물, 냉동·냉장화물, 생·동·식물화물, 위험물 등 특별한 운송장비 또는 취급이 필요한 화물)의 작업상태를 점검한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"감독","workFunc3":"단순작업","certLic":"산업안전지도사","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005927:1', '{"dJobCd":"K000005927","dJobCdSeq":"1","dJobNm":"항공화물터미널허브운영원","workSum":"항공화물터미널에서 허브(HUB:Distribution Center, 도착화물의 분류해체작업 및 개별화물을 최종목적지로 재발송하는 곳)의 운영업무를 수행한다.","doWork":"운항 중인 항공기(IN-FLIGHT)별로 수하물사고보고서(Irregularity Report:화물 또는 운송서류의 사고발생 시 출발지의 제1운송인에게 보내지는 서류)를 정리한다. 항공기에서 항공기로 환적하는 화물의 처리업무를 수행한다. TRM(Transfer Manifest:항공화물에서 최종 목적지가 아닌 중간지점에 내렸을 때 한 항공사가 다른 항공사로 화물운송에 대한 증명으로 주고받는 화물의 적하목록) 관련 업무를 수행한다. HAWB(House Air WayBill:주선업자가 자기의 운송약관에 근거하여 하주와 운송계약을 체결할 때 발행하는 운송장으로서 하나의 HAWB는 혼재되어 있는 각각의 화물에 대한 번호를 부여함)데이터를 모니터링한다. 통과화물 관련 승객에 대한 서비스를 제공한다. 운항편을 정리한다. 특별화물 및 위험화물의 환적을 모니터링한다. 통과화물 조업사의 업무활동을 관리한다. 통과화물 실적데이터를 관리한다. 통과화물의 중량을 점검한다. 통과화물 조업료를 심사한다. 보세운송 또는 환적(Air & Sea) 관련 업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workEnv":"소음·진동|","workFunc1":"분석","workFunc2":"감독","workFunc3":"관련없음","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003412:1', '{"dJobCd":"K000003412","dJobCdSeq":"1","dJobNm":"해운대리점운영사무원","workSum":"외국인을 포함한 해상여객운송사업 또는 해상화물운송사업을 영위하는 자의 위탁을 받아, 선박에 의해 수송되는 화물의 접수, 장치, 선적 등에 관련된 거래의 대리업무를 수행한다.","doWork":"항만청, 세관, 법무부, 검역소, 경찰서 등에 입항예보서를 제출한다. 항만청 선석회의에 참석하여 선석(Berth:船席, 항내에서 선박을 계선시키는 시설을 갖춘 접안장소)을 확보한다. 본선검역을 의뢰하고 실시한다. 화주에게 본선 입항시간 및 하역 관련 일정을 통보한다. 하역회사 및 하역관계자와 하역계획 등을 협의한다. 도선, 예선, 줄잡이, 검수, 검정 등 용역 관련 업체를 수배한다. 본선 접안 시 항만청, 세관, 법무부에 입항수속을 한다. 하역작업 적부도(STOWAGE PLAN:본선의 선창에 화물이 적재된 상태를 나타낸 도면), 본선선장의 요구사항 및 항만의 특수사정 등 본선의 정박 중의 제반 사항에 대하여 선장과 협의한다. 본선 하역작업 감독 및 작업 진척상황을 체크하여 총대리점에 보고한다. 양하 및 선적서류(S/O, M/F, B/L 등)를 작성한다. 본선 요구사항(급수, 급유, 선용품 등)을 처리한다. 선원의 치료, 선원사무 및 선박수리에 대한 수배업무를 수행한다. 항만청, 세관, 법무부에 본선 출항수속을 한다. 본선 출항 후 상황을 총대리점에 통보한다. 본선입항 후 출항 시까지 발생한 모든 비용을 정산하고 청구 및 지불한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"관련없음","similarNm":"해운수탁대리점운영사무원, 지방해운대리점운영사무원","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001362:1', '{"dJobCd":"K000001362","dJobCdSeq":"1","dJobNm":"화물선운항기획원","workSum":"화물선운항 관련 각종 자료의 분석을 통하여 선대를 개편하고 항로를 개척·수정하며 전반적 운항대책을 수립하고 운항관리를 한다.","doWork":"선대개편 및 신규항로개설, 컨테이너 운항스케줄 조정 등 운항계획을 수립하고 조정한다. 용선 선박운항의 적합성을 검토한다. 운항관련 제반 기준을 설정하고 운항관리절차를 개발한다. 선박의 운항사고 예방대책을 수립한다. 사고 시 사고속보를 작성하여 배포하고 사고조사분석 및 재발방지대책을 수립한다. 해난심판서류를 작성한다. 운항사고 실적 및 타 선사의 사고사례를 분석한다. 해사 관련 국제협약 및 국내법을 연구 검토한다. 선박의 항해, 운용에 관한 신기술을 조사 연구하고 해양오염방지 및 예방업무를 한다. 항만국통제검사의 동향을 조사하고 선박운항실적을 종합관리한다. 일일 선박현황 및 기상정보를 수집하여 전달한다. 국내외 운항대리점, 운하통항대리점, 및 국내외 항만용역업체와 계약을 체결한다. 정기적으로 선박운항비를 계산하고 경제적 선박운항이 되도록 운항비용 절감계획을 수립하고 종합적 운항관리를 수행한다. 선박통신운영의 전반적인 관리를 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H501/H502","dJobICdNm":"[H501]해상 운송업 / [H502]내륙 수상 및 항만 내 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003907:1', '{"dJobCd":"K000003907","dJobCdSeq":"1","dJobNm":"화물선운항사무원","workSum":"화물선의 스케줄, 화물선적, 해난사고 등 운항 전반에 관한 업무를 수행한다.","doWork":"화물선의 스케줄 및 화물선적을 관리한다. 화물의 안전수송을 관리하고 운항실적을 분석한다. 속구류, 해도, 라싱장비의 지원방침을 수립한다. 화물의 적양하 및 안전수송, 선박의 안전항해 및 항로, 항해통신장비, 갑판기기, 현장 해기지도, 승조원의 기강 및 복무상황관리 등의 안전운항상태를 점검하고 관리한다. 화물선의 해난사고를 조사·처리하며 현장지원을 한다. 항만정보를 수집하여 관리한다. 선박의 연료유 구매량의 적정성을 검토한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H501/H502","dJobICdNm":"[H501]해상 운송업 / [H502]내륙 수상 및 항만 내 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003917:1', '{"dJobCd":"K000003917","dJobCdSeq":"1","dJobNm":"화물운송료계산원","workSum":"화물을 접수하여 운송료를 계산하고 행선지별로 분류한다.","doWork":"고객이나 화주로부터 접수한 화물의 중량을 측정하고 목적지와 중량별로 정해진 요금표를 참조하여 운송료를 계산한다. 추가 부대비용을 계산한다. 영수증과 제반 비용의 계산서를 고객이나 화주에게 발행한다. 화물의 운송료를 받고 목적지별로 분류하여 포장하거나 운송수단에 보관한다. 도착된 화물을 목적지별로 분류하고 수취인이 제시하는 송장과 신분증을 확인하여 화물을 반출한다. 화물포장의 불량여부와 손상여부를 검사하고 조치를 취한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"계산","workFunc2":"서비스제공","workFunc3":"관련없음","connectJob":"화물운송수단의 종류에 따라 선박화물운송료계산원, 자동차화물운송료계산원, 철도화물운송료계산원, 항공화물운송료계산원","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H501/H502","dJobICdNm":"[H501]해상 운송업 / [H502]내륙 수상 및 항만 내 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003436:1', '{"dJobCd":"K000003436","dJobCdSeq":"1","dJobNm":"화물운송장기록원","workSum":"철도, 화물차량 및 기타 운송수단을 이용하여 수송될 화물을 화주로부터 접수하고 화물운송장을 작성한다.","doWork":"수송 의뢰된 화물의 수량 및 무게를 계산하고 포장상태를 확인한다. 운송료의 산정표를 기준으로 거리, 무게 및 수량에 따른 운송료를 계산하여 징수한다. 화물도착지, 화물수취인, 화물의 종류 및 수량, 무게 등을 화물운송장에 기록한다. 수송 의뢰한 화물을 창고 또는 적재장소로 옮겨 쌓도록 화물취급인부에게 지시한다. 화물발송접수증을 화주에게 발행하고 화물운송장을 화물발송사무원에게 접수한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"계산","workFunc2":"감독","workFunc3":"관련없음","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H","dJobICdNm":"[H]운수 및 창고업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003714:1', '{"dJobCd":"K000003714","dJobCdSeq":"1","dJobNm":"화물차배차원","workSum":"화물의 종류와 규모, 화물차운전원, 운송지역 등을 고려하여 차량을 배차하고 운행을 통제한다.","doWork":"화물의 종류와 규모, 운송지역을 확인하여 화물의 규모에 맞는 차량을 점검한다. 운행거리 및 시간 등을 확인하여 운송비용을 계산하고 관련서류를 정리하여 화물차운전기사에게 발급한다. 배차계획표를 작성하고 공지한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H493","dJobICdNm":"[H493]도로 화물 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002135:1', '{"dJobCd":"K000002135","dJobCdSeq":"1","dJobNm":"화물트럭터미널관리원","workSum":"비정기노선 화물차량과 운송화물의 주차 및 적하를 관리한다.","doWork":"터미널에 도착하는 차량을 운행지방별로 주차지역을 선정해 주고 주차요금을 징수한다. 각 지방별로 운송될 화물의 적재지역을 선정해 준다. 운행지방별 차량상황과 운송화물에 관련된 업무를 수행한다. 화물의 차량적재 및 하역작업을 지휘·감독한다. 터미널시설의 보수나 정비의 필요성을 검사·기록한다. 주차승무원에게 안전과 청결기준을 교육한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H493","dJobICdNm":"[H493]도로 화물 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006621:1', '{"dJobCd":"K000006621","dJobCdSeq":"1","dJobNm":"공동주택관리사무원","workSum":"공동주택 및 그 부대시설의 운영관리, 유지보수 및 안전관리 등을 위한 서무 및 회계업무를 수행한다.","doWork":"주택 입주자들이 입주 시 필요한 문서를 입주자들에게 제공하고 작성된 문서를 정리·보관한다. 자동차 스티커와 같은 필요물품을 입주자들에게 제공한다. 입주현황을 기재하고 정리한다. 공동주택 내 공고문을 작성하여 부착한다. 공과금 납부를 대행하고 관리비 접수 등의 회계업무를 수행한다. 민원접수사항을 확인하여 각 담당자에게 알린다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"공동주택관리소사무원","connectJob":"아파트관리사무원, 연립주택관리사무원, 빌딩관리사무원, 상가건물관리사무원, 오피스텔관리사무원(다만 아파트 연립주택만 공동주택에 포함됨)","certLic":"주택관리사보","dJobECd":"0263","dJobECdNm":"[0263]총무 사무원 및 대학 행정조교","dJobJCd":"3127","dJobJCdNm":"[3127]총무 사무원 및 대학 행정조교","dJobICd":"L682","dJobICdNm":"[L682]부동산 관련 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005402:1', '{"dJobCd":"K000005402","dJobCdSeq":"1","dJobNm":"교무관","workSum":"천도교 교당의 관리·운영, 지방교구의 지원 등 서무, 총무업무를 수행한다.","doWork":"서무 및 인사, 포상, 당직에 관한 사항을 수행한다. 교구 설폐(設廢) 관련 업무 및 교보(敎譜:교인등록부), 교빙(교인증빙서)을 작성·발급· 관리한다. 대내외 자선, 섭외와 강연, 공연에 관한 제반 관리업무를 수행한다. 인장관리, 재산관리, 물품의 처리 및 취급, 영선에 관한 업무를 수행한다. 기타 천도교 교당의 총괄 관리업무를 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"교무","dJobECd":"0263","dJobECdNm":"[0263]총무 사무원 및 대학 행정조교","dJobJCd":"3127","dJobJCdNm":"[3127]총무 사무원 및 대학 행정조교","dJobICd":"S949","dJobICdNm":"[S949]기타 협회 및 단체","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004198:1', '{"dJobCd":"K000004198","dJobCdSeq":"1","dJobNm":"교육행정사무원","workSum":"학교의 행정부서에서 교육행정업무를 계획하고 수행한다.","doWork":"직원의 신규임용, 승진, 퇴직, 휴가 등의 인사관리업무를 담당한다. 학생 편입학, 수업편성, 복학 및 휴학, 성적처리, 증명서 발급, 취업 등 학적업무 등을 담당한다. 학교 내 필요한 물품을 구매한다. 교내 각종 시설 공사를 발주한다. 등록금 수납 및 세금업무, 장학금 지급업무, 전반적인 예산을 조정·통제·결산하는 업무를 수행한다. 그 외 학교생활 전반에 관한 교원 및 학생들의 의견을 수렴하여 처리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"학교행정사무원, 학교교무사무원, 교무사무원, 학적사무원, 학교서무사무원","dJobECd":"0263","dJobECdNm":"[0263]총무 사무원 및 대학 행정조교","dJobJCd":"3127","dJobJCdNm":"[3127]총무 사무원 및 대학 행정조교","dJobICd":"P851/P852/P853","dJobICdNm":"[P851]초등 교육기관 / [P852]중등 교육기관 / [P853]고등 교육기관","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006799:1', '{"dJobCd":"K000006799","dJobCdSeq":"1","dJobNm":"극장시설관리사무원","workSum":"극장운영업과 관련된 사업내역을 관리하고 운영하는 업무를 수행한다.","doWork":"극장을 찾아온 손님들의 편의를 제공하기 위한 부대시설을 운영·관리한다. 극장 내에서 제공할 수 있는 다양한 서비스를 제공한다. 음료수와 과자를 파는 식품편의점, 게임방, 식당 등의 운영 및 관리업무를 한다. 고객에게 부대시설 이용에 대해 안내하고, 문의사항에 응대하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"계산","workFunc2":"설득","workFunc3":"관련없음","dJobECd":"0263","dJobECdNm":"[0263]총무 사무원 및 대학 행정조교","dJobJCd":"3127","dJobJCdNm":"[3127]총무 사무원 및 대학 행정조교","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005289:1', '{"dJobCd":"K000005289","dJobCdSeq":"1","dJobNm":"기숙사사감","workSum":"기숙사에서 입사생들의 생활 전반을 관리하며 야간순회를 돌거나 기숙사의 보안과 시설 등을 관리한다.","doWork":"입사생에게 기숙사 규정을 설명한다. 학교 및 단체생활에 잘 적응할 수 있도록 조언하고 지도한다. 기숙사 생활과 관련된 사회활동이나 오락활동을 계획하고 실시한다. 기숙사의 보안을 점검하고 시설을 관리한다. 보안 및 안전을 위해 야간에 순회를 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"감독","workFunc3":"관련없음","certLic":"준교사, 중등학교전문상담교사, 사회복지사, 간호사","dJobECd":"0263","dJobECdNm":"[0263]총무 사무원 및 대학 행정조교","dJobJCd":"3127","dJobJCdNm":"[3127]총무 사무원 및 대학 행정조교","dJobICd":"I559/P85","dJobICdNm":"[I559]기타 숙박업 / [P85]교육 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006989:1', '{"dJobCd":"K000006989","dJobCdSeq":"1","dJobNm":"기업컨시어지","workSum":"기업 임직원에게 업무 및 생활에 필요한 개인비서 서비스를 제공한다.","doWork":"고객과 상담하여 고객의 요구사항, 제공할 서비스의 종류와 목적을 파악한다. 협력업체, 해외지사, 각종 서비스정보 등 준비된 자원을 활용하여 고객이 요청하는 서비스를 기획한다. 국내외 출장준비, 비즈니스 미팅, 워크숍, 고객의전, 여행, 골프, 이벤트, 공연, 쇼핑 등 정형화된 서비스(협력업체 및 사전에 준비된 정보가 있는 서비스)를 제공한다. 고객이 요구하는 특별한 서비스에 대한 수행방법을 개별적으로 고안한다. 기획안을 작성하여 고객에게 검토를 받고 예산, 서비스의 추가 및 삭제 등을 협의하여 서비스 계약을 체결한다. 서비스 수행일정에 따라 고객 및 서비스제공자(해외지사, 협력사 등)와 연락을 유지하면서 서비스 품질과 고객의 만족도를 관리하고 문제발생 시 대응한다. 서비스가 종료되면 고객으로부터 평가를 받는다. 고객과의 관계유지에 필요한 활동을 하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"언어력|","workFunc1":"수집","workFunc2":"서비스제공","workFunc3":"관련없음","dJobECd":"0263","dJobECdNm":"[0263]총무 사무원 및 대학 행정조교","dJobJCd":"3127","dJobJCdNm":"[3127]총무 사무원 및 대학 행정조교","dJobICd":"N759","dJobICdNm":"[N759]기타 사업지원 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002368:1', '{"dJobCd":"K000002368","dJobCdSeq":"1","dJobNm":"기업행정사무원","workSum":"사업체의 운영에 필요한 각종 행정·경영보조업무를 수행한다.","doWork":"각종 행정서류서식을 숙지한다. 문서의 수발 및 관리업무를 수행한다. 4대 사회보험관리, 급여관리, 비품 및 차량의 관리, 각종 사내행사를 계획·준비·집행하는 업무를 수행한다. 청사관리를 한다. 회사와 관련이 있는 협회, 조합, 단체에 관한 업무를 수행하기도 한다. 비서업무와 회계업무를 수행하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0263","dJobECdNm":"[0263]총무 사무원 및 대학 행정조교","dJobJCd":"3127","dJobJCdNm":"[3127]총무 사무원 및 대학 행정조교","dJobICd":"ALL","dJobICdNm":"[ALL]전체","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004284:1', '{"dJobCd":"K000004284","dJobCdSeq":"1","dJobNm":"대학교무사무원","workSum":"대학의 교원 및 학생선발에 관한 업무와 수업에 관한 업무, 취업, 장학지도업무, 연구지원업무를 담당한다.","doWork":"대학의 교원채용, 승진 등의 인사업무를 관리한다. 교직과정을 편성·운영한다. 교내 학술연구비를 지원하고 연구업적 평가업무를 수행한다. 입학 및 편입시험 등 학생의 선발에서 수업편성, 복학·휴학 및 성적처리, 증명서 발급 등 대학의 기본업무인 학적업무를 담당한다. 학교생활전반에 관한 학생들의 요구사항을 수렴하여 처리한다. 축제, 사회봉사, 학회활동 등 학생자치활동을 지원하며 학생회에서 주관하는 각종 교내외 집회 및 행사를 관리한다. 장학생 선발 및 장학금 지급업무와 취업에 관련된 행정업무를 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"입학관리사무원, 대학행정조교","dJobECd":"0263","dJobECdNm":"[0263]총무 사무원 및 대학 행정조교","dJobJCd":"3127","dJobJCdNm":"[3127]총무 사무원 및 대학 행정조교","dJobICd":"P853","dJobICdNm":"[P853]고등 교육기관","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005293:1', '{"dJobCd":"K000005293","dJobCdSeq":"1","dJobNm":"대학총무사무원","workSum":"대학에서 일반행정업무를 처리하고 각종 물품구매 및 시설관리와 경리업무를 담당한다.","doWork":"각종 문서의 기안, 결재와 문서보존 및 폐기와 같은 문서처리를 한다. 직원의 신규임용, 승진, 퇴진, 휴가 등의 인사관리업무와 교육용·사무용 물품구매 및 실험실습기자재를 구입한다. 교내에서 시행되는 각종 시설공사를 발주한다. 예비군 교육훈련 업무를 담당한다. 등록금 수납 및 세무업무, 결산업무를 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0263","dJobECdNm":"[0263]총무 사무원 및 대학 행정조교","dJobJCd":"3127","dJobJCdNm":"[3127]총무 사무원 및 대학 행정조교","dJobICd":"P853","dJobICdNm":"[P853]고등 교육기관","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006245:1', '{"dJobCd":"K000006245","dJobCdSeq":"1","dJobNm":"도우미학원사무원","workSum":"도우미에 관심 있는 지망생들의 전화에 응대하거나 방문자들에게 직업에 대한 홍보와 설명을 담당하며 교육생들의 인원을 관리한다.","doWork":"관심 있는 지망생들의 전화 및 방문 시 도우미의 역할 및 장점 등 학원을 홍보하며 진로방향 등 관련 정보를 제공하고 상담한다. 방문상담자는 상담 시 외모, 성격을 파악하여 1차적으로 합격여부를 파악한다. 전화상담자는 방문하도록 유도한다. 학원생의 출석체크를 통하여 근태여부를 파악하고 인원관리를 하며 고충상담을 통하여 문제점을 해결한다. 학원생들의 학원수납을 관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"비교","workFunc2":"설득","workFunc3":"관련없음","dJobECd":"0263","dJobECdNm":"[0263]총무 사무원 및 대학 행정조교","dJobJCd":"3127","dJobJCdNm":"[3127]총무 사무원 및 대학 행정조교","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002187:1', '{"dJobCd":"K000002187","dJobCdSeq":"1","dJobNm":"독서실총무","workSum":"이용자 출입관리 등 독서실을 관리하여 면학여건을 조성한다.","doWork":"독서실을 처음 이용하는 고객에게 사용요금 및 주의사항을 설명하고 자리를 배정한다. 이용자의 출입을 관리하고 외부인의 출입을 통제한다. 소란, 음주, 고성, 도난사고 등 질서를 위반하는 행위를 제지하여 면학여건을 조성한다. 냉난방, 실내조명을 관리한다. 간단한 실내청소를 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"시범후 30일 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"고시원총무","dJobECd":"0263","dJobECdNm":"[0263]총무 사무원 및 대학 행정조교","dJobJCd":"3127","dJobJCdNm":"[3127]총무 사무원 및 대학 행정조교","dJobICd":"R902","dJobICdNm":"[R902]도서관, 사적지 및 유사 여가관련 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004839:1', '{"dJobCd":"K000004839","dJobCdSeq":"1","dJobNm":"병원사무장","workSum":"병원의 효율적인 운영과 관리를 위하여 인사, 구매, 재무 및 기타 사무업무를 관장하고 사무원을 관리·감독한다.","doWork":"병원의 진료활동에 필요한 의약품과 의료기구의 재고현황을 파악하고 각 부서에서 의뢰한 구매청구에 따라 구매계획을 수립·실시하거나 감독한다. 환자를 치료하거나 보조하는 직원들의 채용, 배치, 임금 등에 관한 업무를 수행한다. 병원시설의 유지나 청소, 취사업무 등에 종사하는 사람들을 고용·감독한다. 정부부처 등 관계기관으로부터 발송되어온 공문을 처리하고 그 결과를 병원관리자에게 보고한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","certLic":"병원행정사","dJobECd":"0263","dJobECdNm":"[0263]총무 사무원 및 대학 행정조교","dJobJCd":"3127","dJobJCdNm":"[3127]총무 사무원 및 대학 행정조교","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001863:1', '{"dJobCd":"K000001863","dJobCdSeq":"1","dJobNm":"병원행정사무원","workSum":"병원의 외래업무, 입·퇴원 원무관리, 진료관리, 경영기획, 경영평가 등 병원의 전반적 행정사무업무를 수행한다.","doWork":"환자의 외래 및 입·퇴원 원무관리를 한다. 진료비 관리업무를 한다. 진료비 심사청구업무를 한다. 병원환자 및 보호자 등 고객관리업무를 한다. 기타 병원 경영기획 및 평가, 인적자원관리, 급여관리, 재고관리 등 병원행정과 관련된 사무업무를 한다. 보험급여 유형에 따라 진료비 지불 보증 업무를 한다. 건강보험심사평가원에 건강보험 급여 지원 관련 사실 의뢰 업무를 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"원무행정사무원, 원무사무원, 병원원무원, 병원사무원","certLic":"병원행정사","dJobECd":"0263","dJobECdNm":"[0263]총무 사무원 및 대학 행정조교","dJobJCd":"3127","dJobJCdNm":"[3127]총무 사무원 및 대학 행정조교","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004857:1', '{"dJobCd":"K000004857","dJobCdSeq":"1","dJobNm":"부동산시설물관리원","workSum":"시공, 임대, 분양한 부동산 시설물의 수리 또는 보수를 위하여 시설물에 대한 하자신고를 접수받아 보수에 필요한 인원을 산정하고 선임하며 보수실태를 점검한다.","doWork":"고장 또는 보수가 필요한 시설에 대한 신고를 접수하고 하자내용을 검토하여 적임자를 선정하고, 적정 인원을 배치한다. 보수작업 진행상황을 확인하고 보수결과를 점검한다. 보수에 필요한 자재를 보충하고, 보수와 시설유지에 필요한 자재재고를 확보하기 위하여 소요자재를 청구, 수령 및 구매한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"빌딩시설물관리원, 건물하자관리원","dJobECd":"0263","dJobECdNm":"[0263]총무 사무원 및 대학 행정조교","dJobJCd":"3127","dJobJCdNm":"[3127]총무 사무원 및 대학 행정조교","dJobICd":"L682","dJobICdNm":"[L682]부동산 관련 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006347:1', '{"dJobCd":"K000006347","dJobCdSeq":"1","dJobNm":"신재생에너지사업지원사무원","workSum":"신재생에너지사업 추진에 필요한 제반 지원사무를 수행한다.","doWork":"신재생에너지사업자가 신재생에너지사업을 추진함에 있어 사업인허가, 토지구매, 시설설치 인허가 등에 관련한 제반 공무업무를 수행한다. 사업을 위한 행정절차를 파악하여 관련 서류를 작성 및 제출한다. 신·재생에너지설비를 제조하는 업체와의 계약, 공사 일정관리 등의 업무도 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0263","dJobECdNm":"[0263]총무 사무원 및 대학 행정조교","dJobJCd":"3127","dJobJCdNm":"[3127]총무 사무원 및 대학 행정조교","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002770:1', '{"dJobCd":"K000002770","dJobCdSeq":"1","dJobNm":"예비군지휘관","workSum":"지휘계통에 따라 동원되거나 소집된 예비군 대원을 지휘·통솔한다.","doWork":"소속 예비군의 훈련일정을 부여·조정하고 훈련통지서를 교부한다. 예비군 훈련 시 훈련교관 임무를 수행한다. 소속 부대 관할지역의 전·평시 향토방위 작전계획을 수립하고 전시 향토방위 임무를 수행한다. 소속 부대의 비밀문서, 관련 전산자료 및 저장매체의 관리 및 보안을 유지한다. 소속 행정병(상근예비역)의 교육 및 인사관리업무를 수행한다. 향토방위 관련 물자를 관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"10년 초과","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"교육","workFunc3":"관련없음","similarNm":"예비군중대장, 예비군동대장","connectJob":"지역예비군지휘관, 직장예비군지휘관, 대학예비군지휘관","dJobECd":"0263","dJobECdNm":"[0263]총무 사무원 및 대학 행정조교","dJobJCd":"3127","dJobJCdNm":"[3127]총무 사무원 및 대학 행정조교","dJobICd":"O843","dJobICdNm":"[O843]외무 및 국방 행정","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002471:1', '{"dJobCd":"K000002471","dJobCdSeq":"1","dJobNm":"이동헌혈반사무원","workSum":"헌혈버스 등 이동헌혈반의 채혈계획을 수립한다.","doWork":"기업체, 공장, 학교, 교회, 군부대 및 기타 지역사회 등을 방문하여 단체헌혈에 대해 홍보·계몽하고 헌혈계획 및 헌혈반의 방문일정을 협의한다. 잠정적인 주간 및 일일 헌혈일정을 계획하거나 변경하고 이를 이동헌혈반, 헌혈단체 또는 체혈혈액원에 통보하여 채혈업무를 조정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"설득","workFunc3":"관련없음","dJobECd":"0263","dJobECdNm":"[0263]총무 사무원 및 대학 행정조교","dJobJCd":"3127","dJobJCdNm":"[3127]총무 사무원 및 대학 행정조교","dJobICd":"Q869","dJobICdNm":"[Q869]기타 보건업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007517:1', '{"dJobCd":"K000007517","dJobCdSeq":"1","dJobNm":"총무사무원","workSum":"자산의 매입과 처분, 행사진행, 사무환경개선 등 물적자원의 활용방안을 검토하고 적용한다.","doWork":"집기비품 등 고정자산에 대한 구매, 관리, 폐기에 대한 전반적인 업무를 한다. 조직개편 등에 따른 부서배치 변경안을 마련하고, 실행 및 후속조치에 대한 업무를 수행한다. 월례조회, 체육대회 등 각종 행사의 기획, 진행, 정산 등의 제반 업무를 수행한다. 법인차량, 사무기기, 소모품 등의 관리에 대한 제반 업무를 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"총무, 서무사무원","dJobECd":"0263","dJobECdNm":"[0263]총무 사무원 및 대학 행정조교","dJobJCd":"3127","dJobJCdNm":"[3127]총무 사무원 및 대학 행정조교","dJobICd":"ALL","dJobICdNm":"[ALL]전체","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002502:1', '{"dJobCd":"K000002502","dJobCdSeq":"1","dJobNm":"헌혈자관리원","workSum":"혈액 수급을 위하여 헌혈자원을 확보하고 등록·관리한다.","doWork":"헌혈등록체제를 관리하고 혈액형별, 지역별, 단체별 등으로 분류하여 헌혈자의 등록현황을 기록한다. 부적격 혈액을 등록한다. 일정한 주기로 혈액의 수요에 맞추고 헌혈을 위한 날짜, 시간, 장소 등을 지정하여 개인 또는 단체에게 헌혈을 요청한다. 헌혈자에게 교부된 헌혈증서를 전산으로 관리한다. 헌혈증서를 가진 사람이 유사시 무상으로 수혈을 받을 수 있도록 한다. 헌혈증서의 기부에 대한 사항 및 헌혈환급예치금 납부업무를 처리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"헌혈등록관리원","dJobECd":"0263","dJobECdNm":"[0263]총무 사무원 및 대학 행정조교","dJobJCd":"3127","dJobJCdNm":"[3127]총무 사무원 및 대학 행정조교","dJobICd":"Q869","dJobICdNm":"[Q869]기타 보건업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001459:1', '{"dJobCd":"K000001459","dJobCdSeq":"1","dJobNm":"협회사무원","workSum":"회원에게 사업경영의 이익을 도모하기 위하여 회의 및 행사주관, 회원을 대표한 대외섭외, 홍보활동, 기술정보지 및 회원명부 발간·편집 등의 업무를 수행한다.","doWork":"신규 및 기존회원의 등록을 받는다. 등록회원의 생산능력, 생산실적, 생산품목 등을 통보받아 정리한다. 회비를 수납하고 연·월간 사업계획에 맞추어 예산을 편성·집행한다. 임원구성, 법규의 개·제정, 정보교환, 사업심의 등을 위한 협의회와 기타 행사일정을 수립하여 회원에게 통보한다. 각종 행사에 따른 회의자료와 행사장소를 준비한다. 기술정보지, 회원명부, 홍보자료 등을 편집·출판·보급한다. 협회와 회원을 대표하여 정부기관, 기업체, 타 단체와 관련된 공무를 처리·관리한다. 회의결과, 개·제정법규, 사업계획 및 정산내용 등을 회원에게 통보한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"회원단체사무원","dJobECd":"0263","dJobECdNm":"[0263]총무 사무원 및 대학 행정조교","dJobJCd":"3127","dJobJCdNm":"[3127]총무 사무원 및 대학 행정조교","dJobICd":"S941/S942/S949","dJobICdNm":"[S941]산업 및 전문가 단체 / [S942]노동조합 / [S949]기타 협회 및 단체","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007306:1', '{"dJobCd":"K000007306","dJobCdSeq":"1","dJobNm":"IR담당자","workSum":"기업이 자본시장에서 정당한 평가를 받기 위해 개인, 기업 투자자 및 언론을 대상으로 기업의 현황에 대한 정보를 제공하고 기업을 홍보하며 이들과 상호소통한다.","doWork":"기관투자자와 개인투자자를 대상으로 기업설명회, 컨퍼런스 콜, NDR(Non deal Roadshow)등을 개최하고 운영 한다. IPO(주식공개상장, Initial Public offering) 준비 및 실행업무를 한다. IR 전략방향 및 실행계획을 수립한다. 수시공시와 정시공시 등 공시업무를 담당한다. 회사의 가치에 영향을 주는 거시지표 및 주식동향을 파악하여 분기보고서, 사업보고서, 대주주의 지분변동 등 각종 보고서를 작성한다. 주주총회나 이사회 준비업무를 한다. 연기금 등 투자자를 관리한다. 상법, 시장자본법, 공정거래법 등 관련 법규 및 규정 등의 동향을 파악한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"IR(IInvestor Relations), 주식담당자","dJobECd":"0271","dJobECdNm":"[0271]회계 사무원","dJobJCd":"3131","dJobJCdNm":"[3131]회계 사무원","dJobICd":"C/K","dJobICdNm":"[C]제조업 / [K]금융 및 보험업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006120:1', '{"dJobCd":"K000006120","dJobCdSeq":"1","dJobNm":"광고물제작회계사무원","workSum":"광고물의 실제 제작에 소요되는 비용을 산출하여 자금집행서를 작성한다.","doWork":"광고제작에 소요되는 원가를 산정한다. 최종 원가내역을 상업용 영상물 제작감독과 협의하여 산출하고 그 내역을 집행할 수 있도록 자금집행서를 작성한다. 의뢰인과 추가적인 자금 소요견적에 대한 협상을 하며, 이에 따라 결정된 채권을 환수한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내·외","physicalAct":"시각|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0271","dJobECdNm":"[0271]회계 사무원","dJobJCd":"3131","dJobJCdNm":"[3131]회계 사무원","dJobICd":"M713","dJobICdNm":"[M713]광고업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;