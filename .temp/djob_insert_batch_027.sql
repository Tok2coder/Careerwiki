INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004454:1', '{"dJobCd":"K000004454","dJobCdSeq":"1","dJobNm":"원목관리원","workSum":"수송선에서 원목야적장에 하역된 원목을 저장·보관·관리한다.","doWork":"하역된 원목의 양쪽에 철인을 찍어 검인표시를 한다. 검인한 원목을 출고 시까지 저장·관리하며 등급에 따라 원목 개수를 파악하고 입·출고 현황을 작업일지에 기록한다. 원목 보관 중에 원목이 굴러 내릴 위험이 있는 곳에 망치로 꺾쇠를 박거나 보조목을 박아 굴러내리는 것을 방지한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"웅크림|손사용|","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","dJobECd":"0283","dJobECdNm":"[0283]자재·구매·물류 사무원","dJobJCd":"3123","dJobJCdNm":"[3123]자재 관리 사무원","dJobICd":"C161","dJobICdNm":"[C161]제재 및 목재 가공업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004381:1', '{"dJobCd":"K000004381","dJobCdSeq":"1","dJobNm":"유람선식품구매사무원","workSum":"유람선 식당운영에 필요한 각종 식음료를 구매한다.","doWork":"유람선 주방장으로부터 필요물품, 수량 등의 요구를 받아 가격, 수량에 합당한 물품에 관한 시장조사를 한 후 구매한다. 필요시 전화로 소량을 주문하기도 한다. 배달 시 물품의 항목·수량을 확인하고 거래명세표를 받아 대금을 지급한다. 대금지급에 관한 전표를 작성한다. 선내에서 운영하는 자동판매기용 물품을 관리하기도 한다. 승객안내 등의 일을 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"계산","workFunc2":"서비스제공","workFunc3":"관련없음","dJobECd":"0283","dJobECdNm":"[0283]자재·구매·물류 사무원","dJobJCd":"3123","dJobJCdNm":"[3123]자재 관리 사무원","dJobICd":"H501","dJobICdNm":"[H501]해상 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003610:1', '{"dJobCd":"K000003610","dJobCdSeq":"1","dJobNm":"자재검수원","workSum":"제품생산에 필요한 원자재 및 부자재가 입고되면 입고된 제품의 합격 또는 불합격 여부를 판정한다.","doWork":"자재품목에 따라 검사표준 및 검사기준을 설정한다. 적합성 판정을 위해 육안, 저울, 기기, 시약 등으로 측정한다. 검수규정에 따라 입고된 원·부자재에서 견본을 채취하여 규정과 적합 여부를 판정한다. 검수결과를 기록하고 관련 부서에 통보한다. 결과표를 작성하여 보관한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"단순작업","similarNm":"원료검수원","connectJob":"창고검수원, 원단검수원, 부품검수원, 식자재검수원, 원자재검수원","dJobECd":"0283","dJobECdNm":"[0283]자재·구매·물류 사무원","dJobJCd":"3123","dJobJCdNm":"[3123]자재 관리 사무원","dJobICd":"H521","dJobICdNm":"[H521]보관 및 창고업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002274:1', '{"dJobCd":"K000002274","dJobCdSeq":"1","dJobNm":"자재관리사무원(일반)","workSum":"제품생산에 필요한 각종 자재를 생산부서에 효율적으로 지원·공급하기 위하여 소요계획을 수립하고 적정재고량을 유지·관리한다.","doWork":"제품생산에 필요한 각종 자재의 내역과 용도를 조사·분석하여 연간·월간·주간·일일 소요계획을 수립한다. 각 부서로부터 자재청구서 또는 자재지원의뢰서를 접수받고 소요량을 검토한다. 자재창고의 재고현황을 확인하고 자재의뢰부서로 제품을 보내도록 통보한다. 생산부서의 사양에 맞게 적시에 적정량이 공급되도록 제반 사항을 관리한다. 자재관리상태 및 보유자재현황을 파악하여 일지에 기록한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"단순작업","connectJob":"자재기록사무원, 자재보관사무원, 자재수급계획원, 자재공급사무원, 자재사무원, 건축토목자재수급계획원, 기계자동차부품수급계획원, 금속부품자재수급계획원, 섬유의류자재수급계획원, 전자컴퓨터자재수급계획원, 음식료품자재수급계획원","dJobECd":"0283","dJobECdNm":"[0283]자재·구매·물류 사무원","dJobJCd":"3123","dJobJCdNm":"[3123]자재 관리 사무원","dJobICd":"C","dJobICdNm":"[C]제조업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003922:1', '{"dJobCd":"K000003922","dJobCdSeq":"1","dJobNm":"자재관리원(일반)","workSum":"입고자재의 종류와 수량을 확인하고 입고작업을 관리한다.","doWork":"입고가 예상되는 원료의 종류와 수량을 확인한다. 원료가 입고되면 실량 및 공차를 계량하여 입고를 확인한다. 지정된 장소에 하차를 한다. 지정된 위치에 선입·선출이 용이하도록 적재방법과 기준에 따라 적재한다. 사용부서에서 출고의뢰 시 출고전표를 받고 원료를 출고한다. 자재의 입·출고량을 작업일지에 기록한다. 작업장 주위를 정리·정돈한다. 자재를 야적할 때는 천막으로 야적물을 덮고 끈으로 동여매어 유실을 방지하기도 한다. 자재를 야적할 때는 천막 등으로 덮고 안전표시 및 주변 환경에 따른 보호조치를 취한 후 유실 방지를 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"기록","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"자재수불원, 건축토목자재관리원, 건축토목자재수불원, 기계자동차부품자재수불원, 기계자동차부품자재관리원, 금속부품자재관리원, 금속부품자재수불원, 섬유의류자재수불원, 섬유수불원, 원단수불원, 섬유의류자재관리원, 섬유의류생산자재관리원, 섬유의류원자재관리원, 전자컴퓨터자재관리원, 전자컴퓨터자재수불원, 음식료품자재관리원, 음식료품자재수불원","dJobECd":"0283","dJobECdNm":"[0283]자재·구매·물류 사무원","dJobJCd":"3123","dJobJCdNm":"[3123]자재 관리 사무원","dJobICd":"C","dJobICdNm":"[C]제조업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006768:1', '{"dJobCd":"K000006768","dJobCdSeq":"1","dJobNm":"자재구매사무원","workSum":"제품의 생산에 소요되는 자재를 확보하기 위하여 구매정보를 파악하여 구매계획을 세우고 자재를 구매한다.","doWork":"자재 및 생산관련 부서로부터 자재청구서를 받아 실행예산, 납기 등의 자료를 검토하여 구매계획서를 작성한다. 자재수급을 위해 시황에 따라 변하는 물가, 시장단가, 소요물량 등의 자재정보를 수집·관리한다. 우량자재제조업체, 자재구입조건, 물량상태 등을 파악하여 자재구입 결정을 내린다. 자재제조업체의 판매자와 구입품목, 가격, 구입일시, 배달 등의 인도조건을 협의한다. 품의조건에 맞추어 자재구입품의서를 작성하고 납품업체와 구매계약서 및 관련서류를 작성·수령한다. 납품일정을 검토하여 적기에 반입될 수 있도록 독촉한다. 제조과정 또는 반입 시에는 수량이나 품질을 검수한다. 구입물품의 명세서, 계산서, 자재구매자금 지불의뢰서 등을 작성하여 관련 부서에 통보한다. 자재구매에 따른 입찰업무를 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"자재계획사무원, 구매사무원","connectJob":"건축토목구매사무원, 기계및부품구매사무원, 자동차부품구매사무원, 금속부품구매사무원, 섬유의류구매사무원, 섬유의류부자재구매원, 섬유의류자재발주원, 섬유의류구매발주원, 전자컴퓨터구매사무원, 전자부품자재구매사무원, 음식료품구매사무원, 음식료품자재구매사무원, 광산자재창고작업원","dJobECd":"0283","dJobECdNm":"[0283]자재·구매·물류 사무원","dJobJCd":"3123","dJobJCdNm":"[3123]자재 관리 사무원","dJobICd":"C","dJobICdNm":"[C]제조업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007049:1', '{"dJobCd":"K000007049","dJobCdSeq":"1","dJobNm":"정밀화학물류관리자","workSum":"정밀화학 제품의 효율적인 물적 유통을 위하여 물류의 이동, 보관, 선적 등에 드는 시간과 비용의 분석을 통해 합리적인 적정재고, 출하, 운송 등을 계획하고 관리한다.","doWork":"정밀화학 제품의 보관조건을 파악하고 보관시설의 규모와 적합성을 확인한다. 원부재료의 재고관리 계획을 수립하고 원부재료 출하 관리와 원부재료의 적정재고를 관리한다. 정밀화학 제품의 제품 재고관리 계획을 세우고 제품의 적정재고를 관리하며 반품 관리를 수행한다. 제품 출하 계획을 세우고 출하를 실시하며 제품 운송 계획을 세우고 운송을 실행한다. 물류운영원의 작업을 지시하고 감독한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0283","dJobECdNm":"[0283]자재·구매·물류 사무원","dJobJCd":"3123","dJobJCdNm":"[3123]자재 관리 사무원","dJobICd":"C203/C204","dJobICdNm":"[C203]비료, 농약 및 살균, 살충제 제조업 / [C204]기타 화학제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007050:1', '{"dJobCd":"K000007050","dJobCdSeq":"1","dJobNm":"정밀화학물류운영원","workSum":"정밀화학 제품 및 원부재료의 효율적인 관리를 위하여 감독자의 지시와 감독을 받아 물류운영과 관련된 업무를 수행하며 물류관리시스템을 운영하고 제품과 원부재료의 운송, 보관, 출하 등의 업무를 수행한다.","doWork":"정밀화학 제품의 보관과 입·출고 및 출하업무를 수행하며 제품의 재고를 파악한다. 원부재료의 보관과 입·출고 및 출하업무를 수행하며 제품의 재고를 파악한다. 물류 운영에 필요한 보관시설 유지를 위한 점검과 보관시설 이상 발생 시 작업시시서와 감독자의 지시에 따라 조치를 취한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0283","dJobECdNm":"[0283]자재·구매·물류 사무원","dJobJCd":"3123","dJobJCdNm":"[3123]자재 관리 사무원","dJobICd":"C203/C204","dJobICdNm":"[C203]비료, 농약 및 살균, 살충제 제조업 / [C204]기타 화학제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002225:1', '{"dJobCd":"K000002225","dJobCdSeq":"1","dJobNm":"제품관리사무원","workSum":"수요자의 요구에 따라 생산제품을 공급할 수 있도록 입고, 보관, 출하 등의 업무를 계획·관리한다.","doWork":"생산제품의 품목에 따라 보관계획을 세운다. 생산부서에서 생산된 제품의 수량을 파악한다. 실내나 실외에 입고 및 적치시키는 활동을 지시·확인하며 목록을 작성한다. 입고된 제품의 품질을 육안 검사한다. 출하계획에 따라 상차지시서를 발행한다. 상차된 제품을 확인하며 제품 중량이나 수량을 계근하도록 지시하고 계근전표를 작성한다. 입고·출하 등을 정리하여 재고현황을 파악한다. 수요자에게 출하에 따른 제반 사항을 통보한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"단순작업","dJobECd":"0283","dJobECdNm":"[0283]자재·구매·물류 사무원","dJobJCd":"3123","dJobJCdNm":"[3123]자재 관리 사무원","dJobICd":"H521","dJobICdNm":"[H521]보관 및 창고업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001625:1', '{"dJobCd":"K000001625","dJobCdSeq":"1","dJobNm":"제품출하사무원","workSum":"제품재고관리, 출하 관련 부두작업과 운송 및 협력작업에 대한 확인, 점검 및 진행을 관리하고, 제품수불, 통계관리 등 제품출하에 따른 전반적인 업무를 수행한다.","doWork":"공장가동현황 및 입고예정량, 창고 재고수준 및 출하량 등을 파악하고 입고장소의 발생여부를 확인한다. 품명별, 수준별 적치장소의 전산영역을 조정·관리한다. 입고완료된 제품의 위치입력을 실시하여 재고등록을 한다. 창고 내 구역 간 물량 불균형 해소를 위하여 대차 이적 작업량 파악 및 컴퓨터에 전산작업지시를 한다. 기중기 이적작업의 진행상태를 점검하고 작업완료를 확인한다. 이상이 있는 제품을 반납처리한다. 출하지시량을 확인하고 이상 여부를 파악·조치한다. 육송배차등록 및 차량작업 진행관리를 통제한다. 출하작업 진행사항 및 출고제품을 점검·보고한다. 각종 작업 실적목록과 송장확인 및 편철관리를 하고 일별·월별·연간 통계분석을 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0283","dJobECdNm":"[0283]자재·구매·물류 사무원","dJobJCd":"3123","dJobJCdNm":"[3123]자재 관리 사무원","dJobICd":"H521","dJobICdNm":"[H521]보관 및 창고업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004896:1', '{"dJobCd":"K000004896","dJobCdSeq":"1","dJobNm":"주화계수기조작원","workSum":"주화의 재료인 소전 및 주화의 수량을 계수하는 계수기를 조작한다.","doWork":"필요한 공구 및 작업용품을 준비한다. 소전(주화압인용 소재)과 주화의 수량을 확인하여 인수한다. 기계상의 특기(特技)사항이나 작업상의 지시사항, 전달사항을 확인한다. 기계의 일일점검, 먼지제거와 청소를 시행한다. 소전계수(셈하는 것)의 경우 제품별로 설정된 단위량을 정확히 셈하여 소전호퍼에 적제 후 슐러압인기에 분배한다. 작업 중 발견된 과부족 및 불량품은 교환한다. 작업이 종료되면 작업일지에 작업내용을 작성한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"기록","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"소전계수담당자","dJobECd":"0283","dJobECdNm":"[0283]자재·구매·물류 사무원","dJobJCd":"3123","dJobJCdNm":"[3123]자재 관리 사무원","dJobICd":"C331","dJobICdNm":"[C331]귀금속 및 장신용품 제조업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002648:1', '{"dJobCd":"K000002648","dJobCdSeq":"1","dJobNm":"창고관리자(일반)","workSum":"자재, 공구, 설비, 생산제품 및 기타 물품의 입고, 보관, 불출, 기록 등의 창고관리업무를 한다.","doWork":"구입된 자재나 생산제품을 창고에 입고시키기 위하여 청구서, 증빙서류 등을 확인하고 물류의 상태와 수량을 검수한다. 창고원장이나 기록일지에 입고된 물품의 명세를 기록하고 물품의 종류에 따라 창고 내의 적재위치를 선정한다. 각 부서로부터 청구서를 접수받고 창고종사원에게 불출을 지시한다. 정기적으로 재고조사를 실시하고 창고원장과 대조한다. 창고종사원에게 업무를 지시한다. 창고에서 발생한 제반 문제를 해결한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"계산","workFunc2":"말하기신호","workFunc3":"단순작업","connectJob":"물류입고원, 물류출고원, 창고입고원, 창고출고원, 입출고관리원, 입출관리원","dJobECd":"0283","dJobECdNm":"[0283]자재·구매·물류 사무원","dJobJCd":"3123","dJobJCdNm":"[3123]자재 관리 사무원","dJobICd":"H521","dJobICdNm":"[H521]보관 및 창고업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003866:1', '{"dJobCd":"K000003866","dJobCdSeq":"1","dJobNm":"컨테이너관리원","workSum":"수출입 관련 컨테이너에 대한 각종 관리업무를 수행한다.","doWork":"수입창구로부터 직통관 인출요청을 접수하여 컨테이너번호 확인 후 위치를 파악하여 야드트레일러를 배차한다. 검사 컨테이너의 경우 컨테이너화물집하장(CFS:Container Freight Station) 수납원으로부터 컨테이너를 접수하여 위치를 파악하고 구내 이적 후 검사 완료된 컨테이너를 컨테이너 야드(C/Y:Container Yard)에 반출한다. 수출창고관리원으로부터 선적 컨테이너를 접수하여 구내로 이적하고 검수작업사무원으로부터 입고화물 컨테이너를 접수하여 구내 이적한다. 검수작업사무원 또는 컨테이너화물집하장(CFS)수입사무원으로부터 반출계를 받으면 작업컨테이너를 반출한다. 보관기간이 오래된 컨테이너를 확인하여 통보한다. 작업이 완료되면 목적에 따라 수출 컨테이너 야드 또는 환적 컨테이너 야드에 반출한다. 일일컨테이너 수량과 검사 컨테이너 처리량을 파악하여 컨테이너화물집하장(CFS)수납원에게 통부한다. 컨테이너화물집하소(CFS:Container Freight Station)를 이용한 빈 컨테이너의 위치를 정리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실외","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"관련없음","certLic":"물류관리사","dJobECd":"0283","dJobECdNm":"[0283]자재·구매·물류 사무원","dJobJCd":"3123","dJobJCdNm":"[3123]자재 관리 사무원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006491:1', '{"dJobCd":"K000006491","dJobCdSeq":"1","dJobNm":"컨테이너화물집하소수납원","workSum":"컨테이너화물집하장(CFS:Container Freight Station)을 이용한 작업내역에 관한 자료를 정리하고 수납자료를 작성한다.","doWork":"직통관인출 및 입고화물 자료와 면장, 화물인도지시서 등을 대조하고 통관 유무, 입고화물 분할 등을 확인한다. 출고화물에 대한 면장을 정리하고 세금계산서를 발행한다. 일일수납현황을 확인하고 관련서류를 작성한다. 컨테이너화물집하장(CFS:Container Freight Station)의 이용현황을 정리한다. 비어있는 컨테이너를 파악하여 선사에 통보한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"CFS수납원","dJobECd":"0283","dJobECdNm":"[0283]자재·구매·물류 사무원","dJobJCd":"3123","dJobJCdNm":"[3123]자재 관리 사무원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005747:1', '{"dJobCd":"K000005747","dJobCdSeq":"1","dJobNm":"태양전지제조장비관리원","workSum":"태양전지 제조공정에 필요한 식각, 확산, 세정, 증착장비 등의 장비의 등록, 검사, 유지보수상태 등을 관리한다.","doWork":"수동장비의 자동장비 교체계획을 세운다. 새로운 장비에 대해서는 솔라셀공정장비연구원과 협력하여 장비공급업체로부터 장비 데모를 받고 평가한다. 장비유지 보수계획을 세워 태양전지제조장비유지보수원으로 하여금 정기적으로 장비를 보수하고 소모품을 교체하여 장비가동율을 관리한다. 장비별 부품목록을 작성하고 재고를 파악하여 적정재고를 유지시킨다. 부품이나 장비가 부족할 시 구매부서에 구매를 의뢰한다. 장비나 부품에 대한 비용을 절감하기 위해 새롭고 가격이 저렴한 부품대체재와 공급업체를 발굴하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","dJobECd":"0283","dJobECdNm":"[0283]자재·구매·물류 사무원","dJobJCd":"3123","dJobJCdNm":"[3123]자재 관리 사무원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001890:1', '{"dJobCd":"K000001890","dJobCdSeq":"1","dJobNm":"펄프야적장관리원","workSum":"펄프를 제조하는 데 사용할 목재 칩(Chip), 펄프용재 등의 원·부자재를 저장·관리하고 펄프제조공정으로 투입한다.","doWork":"목재 칩 수송차량을 목재 칩의 상태와 수종에 따라 지정된 야적장으로 유도하고 하역하도록 한다. 목재 칩 야적장의 배수상태와 야적상태 등을 확인하여 조치하고 기록한다. 적재된 펄프용재를 관리하고 수량을 파악하여 기록한다. 생산계획 및 공정관리자의 지시에 따라 컨베이어 설비를 제어실에서 조작하여 펄프제조공정으로 투입한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"조작운전","certLic":"펄프제지기능사","dJobECd":"0283","dJobECdNm":"[0283]자재·구매·물류 사무원","dJobJCd":"3123","dJobJCdNm":"[3123]자재 관리 사무원","dJobICd":"C171","dJobICdNm":"[C171]펄프, 종이 및 판지 제조업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002819:1', '{"dJobCd":"K000002819","dJobCdSeq":"1","dJobNm":"하역검수원","workSum":"적하목록에 따라 선박화물의 수량, 손상여부 등을 점검·기록한다.","doWork":"적하목록(Cargo Manifest:積荷目錄,선박 또는 항공기가 적재하고 있는 화물의 목록)을 검토하고 실제 화물의 수량과 비교하여 목록과 일치하는지 확인한다. 선적 시 목록과 화물의 수량을 대조하고 화물의 손상여부를 확인한다. 수량부족이나 화물손상이 있으면 검수표에 기록하고 이를 보고한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"시각|","workEnv":"다습|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"관련없음","certLic":"검수사","dJobECd":"0283","dJobECdNm":"[0283]자재·구매·물류 사무원","dJobJCd":"3123","dJobJCdNm":"[3123]자재 관리 사무원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006962:1', '{"dJobCd":"K000006962","dJobCdSeq":"1","dJobNm":"혈액관리사무원","workSum":"혈액원 또는 병원에서 혈액을 관리하고 제반 업무를 수행한다.","doWork":"의료기관에서 요구하는 혈액 및 혈액제재의 혈액형별 단위수량을 기록하고 재고를 확인한다. 청구서를 보고 혈액의 종류와 요구량을 확인하여 전혈 및 제재혈액을 공급한다. 다른 혈액원 또는 혈액원이 부설되어 있는 병원에 연락하여 전혈 및 성분제재의 수급조절을 위한 협조를 의뢰한다. 혈액형별 재고를 관리하고 각종 혈액 및 희귀혈액의 수급을 조정한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0283","dJobECdNm":"[0283]자재·구매·물류 사무원","dJobJCd":"3123","dJobJCdNm":"[3123]자재 관리 사무원","dJobICd":"Q869","dJobICdNm":"[Q869]기타 보건업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006056:1', '{"dJobCd":"K000006056","dJobCdSeq":"1","dJobNm":"호텔기물담당관리원","workSum":"호텔 내 모든 기물을 총괄 관리·감독하며, 행사 시 필요한 기물을 청결하게 유지한다.","doWork":"각 업장에서 필요로 하는 각종 장비, 도구를 관리하고 조달을 한다. 업장의 청결유지와 세제를 관리한다. 기물파손의 원인을 파악하여 기물파손을 최소화시킨다. 조리부 및 식음료부서의 각종 행사가 원만히 진행되도록 협조한다. 업장에서 나오는 각종 쓰레기를 분리수거하여 처리하는 일을 관리한다. 업장의 기물의 적정수량 유지, 식기세척기계의 정상가동 등을 관리한다. 기물보관창고의 청결을 유지한다. 경리부와 협조하여 기물 관련 예산을 신청한다. 업장에서 파손기물 수리를 신청할 때 시설부와 협조하여 수리·관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"Chief Steward","certLic":"호텔서비스사","dJobECd":"0283","dJobECdNm":"[0283]자재·구매·물류 사무원","dJobJCd":"3123","dJobJCdNm":"[3123]자재 관리 사무원","dJobICd":"I551","dJobICdNm":"[I551]일반 및 생활 숙박시설 운영업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005183:1', '{"dJobCd":"K000005183","dJobCdSeq":"1","dJobNm":"화물발송사무원","workSum":"화물운송장을 접수하고 화물발송을 조정·통제한다.","doWork":"화물운송장기록원으로부터 화물운송장을 확인·접수한다. 화물의 중량과 크기를 확인하여 수송방법을 결정한다. 화물에 송장번호 등이 기재된 명세표를 부착하고 화물을 선별하여 운송수단에 적재하도록 화물취급인부를 지휘·감독한다. 화물발송사항을 기록하고, 화물운송장을 화물열차차장, 화물차량운전기사, 화물담당승무원에게 인계한다. 화물수취사무원에게 전자문서교환(EDI) 등 통신수단을 사용하여 화물발송 사실과 화물의 도착예정시간 등을 통보한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"수출하는 화물에 대하여 관계법규에 따라 세관에 신고하는 경우 수출화물운송사무원","dJobECd":"0283","dJobECdNm":"[0283]자재·구매·물류 사무원","dJobJCd":"3123","dJobJCdNm":"[3123]자재 관리 사무원","dJobICd":"H","dJobICdNm":"[H]운수 및 창고업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006948:1', '{"dJobCd":"K000006948","dJobCdSeq":"1","dJobNm":"화물수취사무원","workSum":"각종 운송수단으로 운송된 화물을 확인하여 수취·보관·처리하며 화주에게 운송을 주선한다.","doWork":"화물발송사무원으로부터 화물의 도착시간과 운송수단을 통보받는다. 화물열차차장, 화물차운전기사, 화물담당승무원으로부터 화물운송장을 받아 도착화물의 송장번호와 상태 및 수량을 확인한다. 수취한 물품을 기록하고 화물취급인부에게 화물을 하역하고 선별하여 창고로 운반하도록 지시한다. 화물운송장을 확인하고 화주에게 전자문서교환(EDI) 등 통신수단을 사용하여 화물의 도착을 연락한다. 화주의 화물배달요구서를 접수하고 운송을 주선한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"수입한 화물에 대하여 관계법규에 따라 세관에 보고하는 경우 수입화물운송사무원","dJobECd":"0283","dJobECdNm":"[0283]자재·구매·물류 사무원","dJobJCd":"3123","dJobJCdNm":"[3123]자재 관리 사무원","dJobICd":"H","dJobICdNm":"[H]운수 및 창고업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006305:1', '{"dJobCd":"K000006305","dJobCdSeq":"1","dJobNm":"휴대폰구매관리원","workSum":"휴대폰 생산에 필요한 자재를 원활히 공급하기 위해 구매계획에 따라 가격을 결정하고 구매하여 납기를 관리한다.","doWork":"필요한 자재를 조사하여 휴대폰 생산에 필요한 자재의 규격과 수량을 파악한다. 생산계획과 자재 재고현황에 따라 필요한 자재구매계획을 수립한다. 구매계획에 따라 자재시장조사를 실행하고 적합한 자재의 가격과 납기, 적정 공급업체를 파악한다. 자재시장조사를 통해 공급이 중단된 자재, 국내외 자재를 파악하고 적정 공급업체를 분석한다. 분석결과를 바탕으로 자재 공급업체와 자재의 가격을 협상하고 최적의 공급업체를 선정한다. 원가관리정보에 따라서 원가목표가격을 설정하고, 자재시장동향을 파악하여 지속적인 원가절감활동을 한다. 자재구매계획에 따라 선정된 자재공급업체에 발주서를 발행하여 발주한다. 선정된 자재공급업체와의 납기일정을 협의를 통해 자재의 적정한 납기를 결정한다. 생산계획에 따라 자재가 적기에 입고될 수 있도록 지속적으로 확인하고 관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0283","dJobECdNm":"[0283]자재·구매·물류 사무원","dJobJCd":"3123","dJobJCdNm":"[3123]자재 관리 사무원","dJobICd":"C264","dJobICdNm":"[C264]통신 및 방송 장비 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003492:1', '{"dJobCd":"K000003492","dJobCdSeq":"1","dJobNm":"휴대폰출하관리사무원","workSum":"최종 휴대폰의 출하검사를 수행하여 합격한 제품을 보관하고 적기에 출하될 수 있도록 관리한다.","doWork":"품질관련 부서에서 정한 출하검사기준에 따라 완제품 시료를 추출한다. 추출된 시료에 대하여 규격검사와 외관검사, 성능검사와 초기수명검사를 포함한 출하검사를 수행한다. 출하검사에 합격한 제품은 완제품 보관창고로 이동한다. 출하검사 시 불합격한 제품에 대하여 식별이 용이하도록 표시하고 관리한다. 불합격한 제품에 대하여 부적합 원인을 분석하고 대책을 수립하기 위하여 생산유관부서와 부적합대책회의를 진행한다. 출하될 제품의 최적상태를 유지하기 위하여 제품의 보관위치와 창고환경을 설정한다. 출하할 품목과 수량, 입고일자와 출고일자, 저장위치 등의 정보를 인식하고 창고관리시스템에 기록한다. 제품보관의 안정성을 보장하기 위하여 창고의 보안과 안전, 환경에 대해 정기적으로 점검을 실시한다. 납품계획에 따라 포장이 완료된 제품은 출하검사성적서를 동봉하여 출하한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0283","dJobECdNm":"[0283]자재·구매·물류 사무원","dJobJCd":"3123","dJobJCdNm":"[3123]자재 관리 사무원","dJobICd":"C264","dJobICdNm":"[C264]통신 및 방송 장비 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002758:1', '{"dJobCd":"K000002758","dJobCdSeq":"1","dJobNm":"가구품질관리원","workSum":"원료를 반제품이나 완제품으로 가공하기 위한 품질표준을 개발하여 적용·수정한다.","doWork":"가구품질평가규격 및 안전규격에 대하여 숙지하고 제품의 검사, 시험, 평가를 위한 방법 및 절차를 개발한다. 샘플링절차를 고안한다. 제품 신뢰도를 기록·평가·보고하는 양식을 작성한다. 원료의 원가, 품질 등의 자료를 분석하여 최저의 비용으로 최고의 제품을 얻을 수 있도록 연구한다. 제품의 품질을 분석하여 사내규격과 비교하고 불량품에 대한 원인을 파악한 후 품질관리계획을 작성한다. 품질정보의 수집, 각종 공업표시허가 취득에 따른 사전 및 사후관리를 한다. 품질관리자료를 분석하여 작업자에게 교육한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"가구품질관리기사","certLic":"품질경영기술사, 품질경영기사, 품질경영산업기사, 경영지도사(생산관리), 가구제작기능사","dJobECd":"0284","dJobECdNm":"[0284]생산·품질 사무원","dJobJCd":"3124","dJobJCdNm":"[3124]생산 및 품질 관리 사무원","dJobICd":"C320","dJobICdNm":"[C320]가구 제조업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001965:1', '{"dJobCd":"K000001965","dJobCdSeq":"1","dJobNm":"가스생산사무원","workSum":"가스생산기지의 운영에 필요한 행정업무를 지원하고 설비를 관리한다.","doWork":"가스생산 관련 사업계획을 수립한다. 생산설비운영에 필요한 기준 및 운영방침을 수립한다. 가스의 수요와 공급에 따라 설비의 증설 및 감축에 대한 계획을 수립한다. 운영에 필요한 인력을 산출한다. 각종 설비의 교체시기를 판단한다. 설비보수에 따른 행정업무를 수행한다. 생산설비의 운전 및 업무일지를 관리하고 운전실적을 분석하여 관련 부서에 보고한다. 부서의 비품관리, 소방안전, 보안업무 등을 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0284","dJobECdNm":"[0284]생산·품질 사무원","dJobJCd":"3124","dJobJCdNm":"[3124]생산 및 품질 관리 사무원","dJobICd":"D352","dJobICdNm":"[D352]연료용 가스 제조 및 배관공급업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006118:1', '{"dJobCd":"K000006118","dJobCdSeq":"1","dJobNm":"계측기기관리원","workSum":"연간 생산계획에 의거 계측기기 수급계획을 세우고 계측기기의 상태를 점검하는 등 관리한다.","doWork":"연간 생산계획에 의거 총 필요량을 산출해 수급계획을 작성한다. 수급계획에 의거 투자품의서를 작성하며 수급상황을 점검한다. 계측기기의 효율적인 이용, 보전을 위한 방침을 설정하여 관리한다. 계측기기의 상태를 점검하여 수리가 필요한 부품이 있으면 정비부서에 수리의뢰를 한다. 기존 계측기기시스템의 성능 향상을 위한 업무를 수행하기도 한다. 자사에서 제작한 계측기기에 대한 기술지도를 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"전자기능사, 전기기능사","dJobECd":"0284","dJobECdNm":"[0284]생산·품질 사무원","dJobJCd":"3124","dJobJCdNm":"[3124]생산 및 품질 관리 사무원","dJobICd":"C/D","dJobICdNm":"[C]제조업 / [D]전기, 가스, 증기 및 공기조절 공급업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007051:1', '{"dJobCd":"K000007051","dJobCdSeq":"1","dJobNm":"고무제품제조생산관리자","workSum":"고객이 요구하는 고무제품을 제조하기 위하여 사양서 검토, 생산공정관리 등의 전반적인 제품제조 생산관리 업무를 수행하고 제품성형 담당자에게 해당 분야의 지식을 전달하고 업무를 감독한다.","doWork":"최적의 고무제품을 생산하기 위해 생산능력을 검토하고 공정검토를 수행한다. 고무제품성형 작업의 원가 절감을 위해 원가, 공정 및 품질비용을 분석하여 원가를 관리한다. 고무제품을 제조하기 위하여 도면과 원부재료 구성을 이해하고, 작업장의 안전 확보 및 환경오염을 방지하기 위해 위험요소를 파악하여 시설을 운영하고 사고 발생 시 적절한 대응 및 사후 대책을 수립한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0284","dJobECdNm":"[0284]생산·품질 사무원","dJobJCd":"3124","dJobJCdNm":"[3124]생산 및 품질 관리 사무원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007183:1', '{"dJobCd":"K000007183","dJobCdSeq":"1","dJobNm":"고무컴파운딩생산관리자","workSum":"고무제품에서 요구되는 특성을 만족시키기 위하여 제한된 권한 내에서 컴파운딩의 기본이론 및 컴파운딩 생산관리 실무지식을 사용하여 고무컴파운딩 조건설정, 공정설정, 설비점검, 등 전반적인 직무를 수행한다.","doWork":"시장 최적의 고무배합물을 제조하기 위하여 고무배합기를 선정하고 고무배합기의 CMB, FMB 운전조건을 설정하고 원료개량, 가공조건, 설비조건을 설정한다. 안정적인 고무배합물 제조를 위하여 배합설비와 주변 설비를 점검하여 유지 및 관리한다. 고무컴파운딩 공정 중 발생할 수 있는 사고를 예방하기 위하여 안전계획을 수립하고 안전과 환경을 관리하고 고무컴파운딩 작업원에게 안전 관련 교육을 실시한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0284","dJobECdNm":"[0284]생산·품질 사무원","dJobJCd":"3124","dJobJCdNm":"[3124]생산 및 품질 관리 사무원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007299:1', '{"dJobCd":"K000007299","dJobCdSeq":"1","dJobNm":"고무품질관리자","workSum":"고무배합 및 제품제조 분야의 기본이론 및 품질관리 실무지식을 사용하여 주어진 권한 내에서 고무배합물 및 완제품 품질관리 업무를 수행하고 품질검사원에게 지식을 전달하고 관리 감독한다.","doWork":"고무제품의 품질을 유지하기 위하여 원부재료와 고무배합물의 품질을 검사하고 통계적 품질분석을 통해 부적합 대책을 수립·개선한다. 고무제품의 품질관리 항목과 규격을 확인하고, 품질을 분석하여 품질분석 결과를 개선하고 관리한다. 고무배합물의 특성을 평가하기 위하여 배합된 고무의 미가교상태와 가교상태의 물성결과를 검토한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"품질경영기사","dJobECd":"0284","dJobECdNm":"[0284]생산·품질 사무원","dJobJCd":"3124","dJobJCdNm":"[3124]생산 및 품질 관리 사무원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007300:1', '{"dJobCd":"K000007300","dJobCdSeq":"1","dJobNm":"고무품질보증사무원","workSum":"고무 수요에 적합한 품질의 제품임을 확증하기 위하여 고무배합 및 제품제\n조 분야의 기본이론 및 품질보증 실무지식을 사용하여 고무배합 사후관리 등\n전반적인 품질보증 업무를 수행한다.","doWork":"고객의 품질요구 수준을 구현하기 위한 고무배합 설계개선과 공정개선을 실행한다. 고무제품의 품질을 유지하기 위하여 원부재료와 고무배합물의 품질을 검사하고 통계적 품질분석을 통해 부적합 대책을 수립·개선한다. 고무완제품의 품질관리 항목과 규격을 확인하고, 품질을 분석하여 품질분석 결과를 개선하고 관리한다. 공정의 안정성을 확보하기 위해 품질관리 기법을 활용하여 중점관리항목 선정, 관리도 작성, 공정능력 평가, 품질데이터 분석 업무를 수행한다. 품질목표 달성을 위해 품질경영 체계를 구축하고, 문서화하여 품질경영 시스템을 관리·운영한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"0284","dJobECdNm":"[0284]생산·품질 사무원","dJobJCd":"3124","dJobJCdNm":"[3124]생산 및 품질 관리 사무원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003591:1', '{"dJobCd":"K000003591","dJobCdSeq":"1","dJobNm":"공사발주사무원","workSum":"대리시공을 담당할 하도급업체들을 선정·계약하고, 공사진행에 따라 공사비 지불 등 제반 업무를 관리한다.","doWork":"각 공종의 공사를 대리시공할 업체들을 선정하기 위해 도급한도액의 적부여부, 관련공사의 실적, 관련 공사업면허 유무 등을 검토한다. 현장설명에 참여한 업체 중 견적을 제출받아 시공능력 및 견적의 적정성 등을 고려하여 하도급업체를 선정한다. 공사입찰이 되면 최종 선정된 하도급업체와 계약한다. 공사기간 및 설계도면을 참고하여 공사진행상황을 점검한다. 대리시공하는 공사의 문제점, 하자보수 등에 대하여 하도급 공사담당자와 협의한다. 하도급공사의 투입물량 및 공사실적을 파악하고 공사비 지불을 관련 부서에 의뢰한다. 하도급업체의 공사능력을 평가하고 기록카드를 작성·관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"하도급공사관리원","dJobECd":"0284","dJobECdNm":"[0284]생산·품질 사무원","dJobJCd":"3124","dJobJCdNm":"[3124]생산 및 품질 관리 사무원","dJobICd":"F411/F412/F421","dJobICdNm":"[F411]건물 건설업 / [F412]토목 건설업 / [F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004455:1', '{"dJobCd":"K000004455","dJobCdSeq":"1","dJobNm":"공정관리기술자(일반)","workSum":"생산시설에서 제조 또는 가공공정상의 기술적 유지관리 및 기술지도업무를 수행하고, 공정설계 및 개선업무를 한다.","doWork":"사업체의 생산여건 등을 고려하여 관련공정 간 가동계획을 검토·조정한다. 재고관리 수준을 설정하여 공장별 또는 공정별 소재처리 및 제품생산계획을 수립한다. 공정개선을 위해 기존 제조공정의 설비배치와 작업요건을 분석한다. 현재의 장비제조기술이나 제품화된 설비의 설명서 등을 검토하여 공정에 이용가능한 기계설비를 파악하고 관련된 기술자료를 분석한다. 경비, 가용면적, 기타 기술적·경제적 요소를 고려하여 공정을 설계하거나 기존의 공정을 개선한다. 새로운 공정이나 개선한 공정에 대한 설비의 운용, 가공기술, 공정의 특징, 공정에 영향을 주는 요소 등에 대하여 정보를 제공하고 기술지도를 한다. 공장의 원활한 가동 및 재고의 적정수준 관리를 위하여 수시로 재고 내용을 파악하여 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"균형감각|","workEnv":"소음·진동|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"공정기술자","connectJob":"가죽제품공정관리기사, 끈제조공정관리기사, 방적공정관리기사, 방직공정관리기사, 신발제조공정관리기사, 염색공정관리기사, 융단제조공정관리기사, 의복제조공정관리기사, 직물제조공정관리기사, 카펫제조공정관리기사, 편직물공정관리기사","certLic":"품질경영기사","dJobECd":"0284","dJobECdNm":"[0284]생산·품질 사무원","dJobJCd":"3124","dJobJCdNm":"[3124]생산 및 품질 관리 사무원","dJobICd":"C","dJobICdNm":"[C]제조업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001320:1', '{"dJobCd":"K000001320","dJobCdSeq":"1","dJobNm":"공정장비품질관리원","workSum":"공정장비의 품질확보와 품질보증을 위해 자재 및 제품 등을 시험·검사한다.","doWork":"공정장비의 품질보증을 위해 표준품질기준을 수립한다. 외주가공품 및 출하장비의 품질확보를 위해 품질관리업무지침을 바탕으로 규격과 재질, 성능, 성분 등의 확인을 위해 수입검사, 제품검사를 실시한다. 관련 보고서를 작성한다. 규격과 일치하는지를 확인하고 문제점이 발견되면 해당 부서에 통보하여 조치를 취하도록 한다. 분석결과, 조치사항 등을 일지에 기록하며 시험기구의 유지 및 관리업무를 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"감독","workFunc3":"관련없음","similarNm":"공정장비품질보증원","certLic":"품질관리기술사, 품질경영기사, 품질경영산업기사, 경영지도사(생산관리)","dJobECd":"0284","dJobECdNm":"[0284]생산·품질 사무원","dJobJCd":"3124","dJobJCdNm":"[3124]생산 및 품질 관리 사무원","dJobICd":"C292","dJobICdNm":"[C292]특수 목적용 기계 제조업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001510:1', '{"dJobCd":"K000001510","dJobCdSeq":"1","dJobNm":"나노소자품질관리자","workSum":"나노소자 개발 및 양상단계에서 발생할 수 있는 문제점을 예방하고 공정, 출하, 제품품질을 검사하여 품질을 관리한다.","doWork":"나노소자 모듈공정사양에 따라 조립생산, 공정유지 및 보수업무를 수행한다. 조립생산의 반복 공정작업을 수행하고 관리한다. 나노소자 공정으로부터 제작한 회로, 센서부, 구동부, 검출부 등을 부착하여 소자, 모듈을 조립 완성한다. 모듈공정의 작업성 및 품질개선을 수행한다. 모듈공정의 변경, 제거, 대체작업을 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"0284","dJobECdNm":"[0284]생산·품질 사무원","dJobJCd":"3124","dJobJCdNm":"[3124]생산 및 품질 관리 사무원","dJobICd":"C339","dJobICdNm":"[C339]그 외 기타 제품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001234:1', '{"dJobCd":"K000001234","dJobCdSeq":"1","dJobNm":"나노소재생산공정원","workSum":"나노소재를 생산하기 위하여 생산계획을 수립하고 공정을 운영·관리한다.","doWork":"나노소재 생산을 위한 작업표준서를 작성한다. 생산계획을 수립한다. 생산장비(수열합성장치, 전기화학적 합성장치, 전기선폭발장치, 플라스마장치 등) 가동계획을 수립한다. 생산장비, 부대시설 및 검사용 측정기기의 검·교정을 수행하고 유지보수계획을 수립한다. 생산계획에 따른 원재료(금속염 및 환원제, 금속분말, 금속판, 금속선 등) 조달계획을 수립하고 재고를 관리한다. 원재료 및 제품의 회수 및 폐기처리를 관리한다. 생산계획에 따른 인력수급계획을 수립한다. 수립된 생산계획에 따라 생산공정을 운용한다. 생산실적을 집계하고 분석한다. 제품의 개선방안을 수립한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"0284","dJobECdNm":"[0284]생산·품질 사무원","dJobJCd":"3124","dJobJCdNm":"[3124]생산 및 품질 관리 사무원","dJobICd":"C339","dJobICdNm":"[C339]그 외 기타 제품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001278:1', '{"dJobCd":"K000001278","dJobCdSeq":"1","dJobNm":"나노소재품질관리자","workSum":"생산된 나노소재의 시험결과를 판정하여 출하 여부를 결정하며 품질개선업무를 수행한다.","doWork":"나노소재 원·부자재 및 단위 공정 생산품의 샘플선정방법을 수립하고 품질관리인자를 도출한다. 품질에 영향을 주는 인자를 고려하여 검사공정을 선정한다. 측정방법을 확립하고 지속적으로 개선한다. 시험실, 시험장비, 시험기기, 측정기기를 점검하고 관리한다. 생산품의 품질을 측정·기록·관리한다. 원자재, 완제품의 시험결과를 분석·기록하고 판정한다. 원자재 및 부분품을 평가한다. 클레임 등 소비자의 요구를 취합·정리하여 관련 부서에 전달한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"0284","dJobECdNm":"[0284]생산·품질 사무원","dJobJCd":"3124","dJobJCdNm":"[3124]생산 및 품질 관리 사무원","dJobICd":"C339","dJobICdNm":"[C339]그 외 기타 제품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004415:1', '{"dJobCd":"K000004415","dJobCdSeq":"1","dJobNm":"담배품질관리기술자","workSum":"담배제품의 품질향상을 위하여 품질표준을 개발·적용·수정한다.","doWork":"담배제품의 품질이 설계품질기준에 충족하는지 검사한다. 품질에 있어서 문제점을 분석하고 진단한다. 동종기관 제품의 품질을 비교·분석한다. 불량률을 감소시키고 품질을 향상시키기 위해 ISO9000, 6시그마 등 품질관리기법을 적용한다. 품질관리 개선방법을 고안한다. 품질관리 개선에 관한 사업을 입안하고 실시한다. 품질정보의 수집, 각종 공업표시허가 취득에 따른 사전 및 사후관리를 한다. 근로자의 품질교육을 계획하고 실시한다. 품질관리를 위한 지침서를 작성한다. 기타 품질관리를 위한 행정업무를 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"담배품질보증기술자","certLic":"농산물품질관리사, 품질경영기술사, 품질경영기사, 품질경영산업기사, 경영지도사(생산관리)","dJobECd":"0284","dJobECdNm":"[0284]생산·품질 사무원","dJobJCd":"3124","dJobJCdNm":"[3124]생산 및 품질 관리 사무원","dJobICd":"C120","dJobICdNm":"[C120]담배 제조업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007166:1', '{"dJobCd":"K000007166","dJobCdSeq":"1","dJobNm":"데이터라벨링검수원","workSum":"업로드한 데이터 및 입력된 라벨 값이 프로젝트 매뉴얼(또는 가이드)에 일치하는지 점검 및 수정한다.","doWork":"프로젝트에 따라 매뉴얼을 숙지하고 목록에서 검수할 프로젝트를 선택한다. 작업자의 작업이 가이드 기준에 맞게 작업되었는지 검수한다. 오탈자, 첨자, 싱크 등을 점검한다. 클래스가 맞게 선택되었는지 확인한다. 이미지의 경우 물체가 기준에 맞게 바운딩 및 태깅되어 있는지 확인한다. 음성의 경우 맞춤법 규칙에 준수하여 검사한다. 작업이 잘못된 경우 작업파일을 수정사항을 포함하여 작업자에게 반려한다. 잘못된 작업을 반려하지 않고 직접 수정하기도 한다. 검사작업이 완료된 결과물을 제출한다. 예외 사항에 대해 프로젝트 담당자와 커뮤니케이션을 진행하며 프로젝트가 잘 수행되도록 보조한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","similarNm":"검수자","connectJob":"데이터라벨러","dJobECd":"0284","dJobECdNm":"[0284]생산·품질 사무원","dJobJCd":"3124","dJobJCdNm":"[3124]생산 및 품질 관리 사무원","dJobICd":"N759","dJobICdNm":"[N759]기타 사업지원 서비스업","inqYear":"2021","etc":"보류(데이터검수자 등과 통함 검토 필요)"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007423:1', '{"dJobCd":"K000007423","dJobCdSeq":"1","dJobNm":"바이오의약품생산관리자","workSum":"바이오의약품 생산관리, 바이오의약품 원료관리 등의 업무를 수행하고 생산 업무를 관리·감독하는 업무를 수행한다.","doWork":"주문량, 재고량, 생산능력 등을 고려한 제품별 생산량을 결정한다. 제품별 생산 우선순위를 결정하고 생산일정과 계획원료의 콜드체인을 관리한다. 제품표준서를 활용하여 원자재 주문량, 입하량, 입고량, 출고량, 필요한 장비 및 필요한 인력을 현황을 파악하고 원자재, 완제품, 반제품의 재고 및 안전, 환경관리 규정을 숙지하고 안전사고를 예방한다. 제품표준서에 따라 각 공정별 제조 소요시간, 공정 대기시간, 공정 청소시간, 품질검사 기간을 산출한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","dJobECd":"0284","dJobECdNm":"[0284]생산·품질 사무원","dJobJCd":"3124","dJobJCdNm":"[3124]생산 및 품질 관리 사무원","dJobICd":"C211","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007418:1', '{"dJobCd":"K000007418","dJobCdSeq":"1","dJobNm":"바이오의약품설비품질보증기술자","workSum":"제조 및 품질관리 기준의 준수 여부 검토 및 공정, 시험방법, 세척, 제조지원설비를 점검하고 컴퓨터시스템 밸리데이션 등의 업무를 수행한다.","doWork":"공정 밸리데이션의 위험성평가(RA) 및 공정, 시험방법, 세척, 제조지원 설비 및 컴퓨터시스템 밸리데이션 중 발생한 일탈을 처리하고 수행항목을 설정하여 계획서 및 결과보고서(PV Report)를 작성한다. 배지충전시험(Media Fill Test) 결과의 해석 및 판정, 시험방법 밸리데이션 대상 여부, 검체 채취 및 관련 장비를 점검한다. 세척 밸리데이션 수행 및 세척 전·후 유지시간, 제조지원 설비 밸리데이션과 운전변수의 관리수준을 설정한다. 컴퓨터시스템 밸리데이션 대상 장비의 분류, 공급자 평가계획서를 작성하고 공급자를 평가한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0284","dJobECdNm":"[0284]생산·품질 사무원","dJobJCd":"3124","dJobJCdNm":"[3124]생산 및 품질 관리 사무원","dJobICd":"C211","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007419:1', '{"dJobCd":"K000007419","dJobCdSeq":"1","dJobNm":"바이오의약품품질보증기술자","workSum":"품질시스템의 지속적인 개선업무 및 변경일탈관리, 실사, 문서관리 등의 업무를 수행한다.","doWork":"변경신청서 작성, 변경 영향평가, 변경결과보고서와 일탈발생보고서를 작성하고 일탈 원인을 조사 후 시정하고 예방조치(CAPA)를 한다. 공급업체 및 내부감사 계획을 수립하고, 허가 기관 및 외부업체와 실사와 수검을 준비하고 수검결과에 따라 시정 및 예방 조치를 한다. 제품표준서, 제조지시서, 시험규격서, 시험 방법서를 검토 및 관리한다. 품질 정책(Quality Policy) 및 SOP, 제조소 총람, 품질경영시스템(QMS) 문서를 작성, 배포, 폐기한다. 제품의 연간품질자료를 수집 및 통계 처리하고 연간품질평가 보고서 작성 및 개선계획을 수립한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"0284","dJobECdNm":"[0284]생산·품질 사무원","dJobJCd":"3124","dJobJCdNm":"[3124]생산 및 품질 관리 사무원","dJobICd":"C211","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007420:1', '{"dJobCd":"K000007420","dJobCdSeq":"1","dJobNm":"바이오의약품품질시험원","workSum":"바이오의약품 품질관리(QC), GMP 규정과 현장 지식을 활용하여 QC시험운영, 안정성 시험, 환경모니터링, 시험물질관리 등의 각종 실험 및 시험 업무를 수행한다.","doWork":"표준품, 시약, 시액을 제조하고 입고, 등록 및 보관 내역을 관리한다. 시험용 및 보관용 검사 대상물을 구분하고 관리안정성 시험 장비를 선정하고 관리한다. 생화학시험 수행, 미생물 시험 수행 후 시험기록을 작성하고 결과를 판단한다. 안정성 시험계획서 작성, 시험실시, 결과보고서를 작성하고, 이화학시험, 기기분석시험을 수행하고 시험기록을 작성한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"0284","dJobECdNm":"[0284]생산·품질 사무원","dJobJCd":"3124","dJobJCdNm":"[3124]생산 및 품질 관리 사무원","dJobICd":"C211","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007275:1', '{"dJobCd":"K000007275","dJobCdSeq":"1","dJobNm":"바이오의약품품질평가기술자","workSum":"바이오의약품의 품질평가를 위해 QC시험관리, QC시스템관리, 적격성평가, 불만제품회수 등의 업무를 수행한다.","doWork":"최신 허가사항 및 관련 공정서를 반영한 원자재 및 제품의 시험규격서 작성, 개정시험데이터, 계산식, 시험에 사용된 장비, 시약 적합성을 검토한다. 시험일지, 로그북 등 검토, 시험결과 판정, 배치별 시험경향 분석, 관리수준 설정 시험기준일탈(OOS) 처리 절차를 수립하고 적합여부를 판단한다. 시약, 고압가스 유해물질, 유해위험물질 취급 및 사용 시 안전사항을 관리한다. 시험규격서(원자재 제품), QC시스템관련 지침서(SOP), 개정 시험법, 시험장비 작동 및 관리지침서(SOP)를 작성하고 개정한다. 시험장비 연간유지보수 계획서, 설치적격성 평가 계획, 운전적격성 평가, 성능적격성평가를 계획하고 보고서를 작성한다. 불만사항에 대해 조사 후 보고서를 작성하고 시정 및 예방조치, 회수계획서를 허가기관에 신고한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"0284","dJobECdNm":"[0284]생산·품질 사무원","dJobJCd":"3124","dJobJCdNm":"[3124]생산 및 품질 관리 사무원","dJobICd":"C211","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007312:1', '{"dJobCd":"K000007312","dJobCdSeq":"1","dJobNm":"바이오화학제품품질관리자","workSum":"허가용 품질평가, GMP 문서 교육 관리, 화장품 기준서 관리, 화장품 GMP 관리, 화장품 품질 보증, 법규관리 등의 업무를 수행한다.","doWork":"제품품질 분석결과, 완제품의 품질결과에 대한 통계분석, 불량품 원인분석, 방지대책, 폐기대책을 수립한다. 공정단계별로 품질기준 파악, 품질분석 결과 기록, 품목별, 공정별 품질개선에 대한 자료를 작성 후 관리하고 보고한다. 전처리 방법과 시료 처리 시 안전사항 확인, 정량을 위한 검량곡선 작성, 규격 허용범위 및 품질불량 기준을 설정한다. 불량발생 메커니즘의 해석, 품목별, 공정별 불량의 종류 및 내용에 따른 분류불량유형 보고서를 작성한다. 제품표준서에 따라 완제품 기준 및 시험방법의 시험항목과 기준을 파악하고 시험결과에 따라 적합 유무를 판정하고 기록·관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"바이오화학제품제조기사, 바이오화학제품제조산업기사, 화학분석기사, 화학분석기능사","dJobECd":"0284","dJobECdNm":"[0284]생산·품질 사무원","dJobJCd":"3124","dJobJCdNm":"[3124]생산 및 품질 관리 사무원","dJobICd":"C211","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006945:1', '{"dJobCd":"K000006945","dJobCdSeq":"1","dJobNm":"바이오화학제품품질평가관리자","workSum":"허가용 품질평가, GMP 문서 교육관리, 기준서 관리, GMP 관리, 품질 보증, 법규관리 등의 업무를 수행한다.","doWork":"제제 특성을 고려하여 규격 항목 선정, 시험 진행, 적합 여부를 판단하고 허가용 규격설정 근거자료를 작성한다. 제품표준서 개정 및 이력 관리, 제품표준서, 품질관리기준서의 구성요소, 시험시설 및 시험기구의 점검방법, 시험검체 채취방법 및 관리사항을 결정한다. 품질관리기준서의 변경사항 발생 시 변경이력을 유지·관리하고, 제조위생관리기준서의 구성요소를 결정하며, CGMP 규정에 따라 조직을 구성한다. 생산시설의 설계 기준 요건을 파악하고 제조 및 품질관리에 필요한 시설, 장비를 파악 및 유지 관리한다. 검체 채취 규정에 따라 시험용 검체 및 보관용 검체의 채취 절차를 점검 및 보관관리하며, 평가표에 따라 적합여부를 판정한다. 불량품 관리 규정에 따라 불량품 처리절차서를 작성하고 불량품에 대하여 제품회수, 재작업, 폐기 등을 처리 및 기록·관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"0284","dJobECdNm":"[0284]생산·품질 사무원","dJobJCd":"3124","dJobJCdNm":"[3124]생산 및 품질 관리 사무원","dJobICd":"C211","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006454:1', '{"dJobCd":"K000006454","dJobCdSeq":"1","dJobNm":"반도체장비품질관리기술자","workSum":"반도체 장비 개발 및 생산과정에서 필요한 다양한 소재, 부품, 장치 등의 수입검사, 규격검사, 성능검사, 신뢰성평가, 내부품질보증, 출하검사 및 고객품질 보증업무를 수행한다.","doWork":"반도체 장비 소재, 부품, 장치의 수입·출하 품질관리 업무표준, 검사 및 평가기준계획서를 작성하고, 수입·출하 품질검사를 통해 합격, 불합격 판정을 관리하며, 보완, 검증작업을 지원한다. 수입물품에 대한 품질검수 및 양품판정에 있어 통계적 관리기법을 활용하여 관리하고, 내부 관계자 및 제조업체와 협업하여 품질향상을 위한 개선방안을 도출한다. 반도체장비 시험평가과정에서 품질기술을 지원하고, 품질신뢰성 문제를 도출, 개선작업을 지원한다. 반도체장비 소재, 부품, 장치 등의 품질보증계획서를 작성하고, 보증작업을 진행하며, 표준화하여 관리한다. 품질평가 및 보증을 위해 계측설비를 운영, 시험, 보완, 검증한 다음 표준화하여 관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"반도체장비기술자, 반도체장비품질관리자","dJobECd":"0284","dJobECdNm":"[0284]생산·품질 사무원","dJobJCd":"3124","dJobJCdNm":"[3124]생산 및 품질 관리 사무원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005450:1', '{"dJobCd":"K000005450","dJobCdSeq":"1","dJobNm":"반도체재료생산관리기술자","workSum":"반도체 공정기술 및 고객 요구성능을 이해하고, 재료개발·생산계획에 따라 원료, 부품, 장치 및 장비를 선정하고, 생산공정관리기법을 활용하여 납기, 생산성 향상을 지원한다.","doWork":"반도체 재료개발, 생산을 위한 원료, 부품, 장치 및 장비를 선정하여 시험평가, 보완, 검증작업을 반복수행한다. 생산공정장비별 최대 생산능력을 계산하고, 생산공정도 기준으로 장비배치에 따른 시간당 생산량을 계산하여 일일, 주간, 월간 실제 생산량을 산출하여 생산계획서를 작성·공유한다. 영업담당자 요구생산량을 기준하여 원료, 에너지, 인력, 설비 등 소요자원 수급계획을 수립·공유한다. 생산주변 환경변화에 대응하기 위한 생산지수를 산정·반영하며, 적정재고수준을 영업·구매담당자와 합의, 유지 관리한다. 생산작업절차서를 작성하고, 작업절차에 다른 장비운전표준서를 작성하며, 재료품질 확보를 위해 생산공정을 실시간 또는 주기적으로 관찰·대응한다. 생산장비의 주기적인 점검을 통해 최대의 가동시간을 확보·유지하며, 장비사용설명서 이해를 기반으로 안정적인 장비운영표준을 확보하며, 이상상황 발생에 따른 대응계획을 수립·공유한다. 국내 소방 및 산업안전 관련 법규에 의거 생산장비를 관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"반도체 재료기술자","dJobECd":"0284","dJobECdNm":"[0284]생산·품질 사무원","dJobJCd":"3124","dJobJCdNm":"[3124]생산 및 품질 관리 사무원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001963:1', '{"dJobCd":"K000001963","dJobCdSeq":"1","dJobNm":"반도체재료품질관리기술자","workSum":"반도체 공정기술 및 고객의 요구성능을 이해하고, 재료개발·생산을 위한 원료선정, 제조사양, 취급방법, 품질요구수준 등을 결정하고, 평가, 개선, 유지관리업무를 수행한다.","doWork":"반도체 공정 및 고객 요구성능을 만족시킬 수 있는 재료품질 요구수준을 정의하고, 재료생산에 필요한 원료선정, 제조사양 결정을 지원한다. 원료의 수입, 재료의 생산, 출하 관련 품질관리업무표준, 검사 및 평가기준계획서를 작성한다. 원료의 수입, 제료의 출하품질검사를 통해 합격, 불합격 판정을 관리하며, 보완, 검증작업을 지원한다. 수입원료에 대한 품질검수 및 양품판정에 있어 통계적 관리기법을 활용하여 관리하고, 내부관계자 및 제조업체와 협업하여 품질향상을 위한 개선방안을 도출한다. 반도체재료 성능평가과정에서 품질기술을 지원하고, 품질신뢰성 문제를 도출, 개선작업을 지원한다. 반도체재료의 출하 시 품질보증계획서를 작성하고, 보증작업을 진행하며, 표준화하여 관리한다. 품질평가 및 보증을 위해 계측설비를 운영, 시험, 보완, 검증한 다음, 표준화하여 관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0284","dJobECdNm":"[0284]생산·품질 사무원","dJobJCd":"3124","dJobJCdNm":"[3124]생산 및 품질 관리 사무원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004681:1', '{"dJobCd":"K000004681","dJobCdSeq":"1","dJobNm":"방사성폐기물처리장품질관리원","workSum":"방사성폐기물관리, 처분시설 운영, 설비, 기자재의 검사를 통해 방사성폐기물처분시설의 안정적인 운영을 위한 품질보증체계를 수립하고 운영한다.","doWork":"예비검사, 운반, 저장 및 처리, 인수검사, 처분검사 각 단계별 방사성폐기물관리 품질검사계획을 수립하고 운영한다. 정기적으로 방사성폐기물처리장의 운영·정비시험을 통해 문제점을 파악하고 시정을 위해 관련 부서에 통지한다. 방사성폐기물처리장에서 사용되는 각종 기자재의 품질검사를 관리·감독한다. 폐기물 처리 이력을 위해 QR코드, 정보처리시스템을 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"방사성폐기물처리장품질보증원","certLic":"기계기사, 전기기사, 토목기사, 건축기사","dJobECd":"0284","dJobECdNm":"[0284]생산·품질 사무원","dJobJCd":"3124","dJobJCdNm":"[3124]생산 및 품질 관리 사무원","dJobICd":"E382","dJobICdNm":"[E382]폐기물 처리업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005690:1', '{"dJobCd":"K000005690","dJobCdSeq":"1","dJobNm":"배전계획원","workSum":"전력수요자에게 전력을 공급하기 위하여 배전설비에 대한 신·증설계획을 수립하고 공사관리, 기기의 수급계획 등의 업무를 수행한다.","doWork":"전력수요에 대한 동향을 수집·분석·검토하여 적정한 배전설비의 수급 관련 투자계획을 수립한다. 배전설비의 신·증설 또는 개·보수공사에 따른 운영계획, 자재의 수급계획, 공정계획 등의 관련 서류를 작성한다. 배전선로의 운전실태를 분석하여 대책을 수립한다. 신·증설 또는 개·보수공사에 필요한 주요 자재의 구매규격서를 작성하고, 제작업체 및 납품업체의 제품규격과 비교하여 구입여부에 관한 보고서를 작성한다. 선로증설에 따른 통신선로의 유도장애, 환경평가 등에 관한 자료를 입수하여 문제점을 파악하고 개선책을 연구한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"협의","workFunc3":"관련없음","connectJob":"배전설비의 신·증설 및 개·보수공사를 위한 도면설계 및 공사감독일 경우 배전설계원","certLic":"전기산업기사, 전기공사산업기사","dJobECd":"0284","dJobECdNm":"[0284]생산·품질 사무원","dJobJCd":"3124","dJobJCdNm":"[3124]생산 및 품질 관리 사무원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005749:1', '{"dJobCd":"K000005749","dJobCdSeq":"1","dJobNm":"생산계획사무원","workSum":"제조부문의 일별·주간별 생산계획을 수립하고 생산량 등을 관리한다.","doWork":"제품별 일일 또는 주간 세부생산계획을 수립한다. 생산계획에 의거하여 소요자재의 종류와 수량을 파악하고 구매부서에 요구한다. 생산계획 일정을 조정한다. 구매를 요청한 자재를 수령한다. 제품별 생산실적을 취합한다. 제품에 대한 불만사항이 있으면 원인을 분석하고 처리한다. 생산과 관련된 기타 행정업무를 수행한다. 생산직근로자의 근태 등 노무업무를 수행하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"생산조정계획사무원, 생산일정계획사무원","dJobECd":"0284","dJobECdNm":"[0284]생산·품질 사무원","dJobJCd":"3124","dJobJCdNm":"[3124]생산 및 품질 관리 사무원","dJobICd":"C","dJobICdNm":"[C]제조업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004843:1', '{"dJobCd":"K000004843","dJobCdSeq":"1","dJobNm":"생산공정관리사무원","workSum":"생산관리자를 보조하여 인사·노무, 교육·후생, 문서관리 등의 업무를 한다.","doWork":"생산계획서 및 생산관리자의 지시사항을 숙지하고 공정관리를 위한 세부사항을 점검한다. 작업원의 근태, 급여, 직무환경관리, 포상계획과 휴·복직관리 등에 따른 보고서를 수집·검토하여 인사·노무관리에 관한 보고서를 작성하여 보고한다. 직무교육 및 연수원교육 등 작업원에 대한 교육, 후생 등에 대한 계획을 수립한다. 표준문서, 비품, 소모품 등을 관리하고 수리 의뢰한다. 공장의 보안관리 및 각종 공장행사 지원업무를 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"서비스제공","workFunc3":"관련없음","similarNm":"공정사무원, 생산관리원, 생산관리사무원","dJobECd":"0284","dJobECdNm":"[0284]생산·품질 사무원","dJobJCd":"3124","dJobJCdNm":"[3124]생산 및 품질 관리 사무원","dJobICd":"C","dJobICdNm":"[C]제조업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006604:1', '{"dJobCd":"K000006604","dJobCdSeq":"1","dJobNm":"생산관리기술자","workSum":"제조부문의 작업이 원활히 수행될 수 있도록 생산계획을 수립하고 생산일정 등을 관리한다.","doWork":"생산제품의 종류 및 수량 등에 대한 중단기 생산계획을 수립한다. 제품별 월간, 연간 세부생산계획을 수립한다. 생산계획에 의거하여 자재소요계획을 수립한다. 제품별 생산실적을 취합한다. 각 설비별 제조원가 및 제조계획을 작성하여 종합·검토·조정하고 관계부서에 통보한다. 제조작업의 표준을 설정하고 작업자에 대한 교육훈련계획을 수립·실시한다. 불량률, 가동률 등 제조통계를 정기적으로 관리한다. 생산실적을 보고한다. 제품표준서, 제조관리기준서 등 서류를 작성·관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"조정","workFunc2":"협의","workFunc3":"제어조작","connectJob":"솔라셀생산관리원","certLic":"품질관리기술사, 품질경영기사, 품질경영산업기사, 경영지도사(생산관리)","dJobECd":"0284","dJobECdNm":"[0284]생산·품질 사무원","dJobJCd":"3124","dJobJCdNm":"[3124]생산 및 품질 관리 사무원","dJobICd":"C","dJobICdNm":"[C]제조업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006946:1', '{"dJobCd":"K000006946","dJobCdSeq":"1","dJobNm":"석유화학생산관리자","workSum":"생산목표를 효과적으로 달성하기 위한 인적, 물적 자원의 효율적 배분·결합을 통해 생산목표 수립과 집행, 생산실적을 관리한다.","doWork":"공정·품목별 생산계획 수립을 위해 일별·월별 생산실적을 파악하고 유틸리티 사용실적을 분석한다. 원부자재 수급계획을 수립하기 위해 제품별 제조원가를 계산하고 원가절감 방안을 도출한다. 공정별·제품별 시간당 생산 가능량을 파악하기 위해 제품별 최적 생산목표를 수립한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0284","dJobECdNm":"[0284]생산·품질 사무원","dJobJCd":"3124","dJobJCdNm":"[3124]생산 및 품질 관리 사무원","dJobICd":"C201","dJobICdNm":"[C201]기초 화학물질 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006947:1', '{"dJobCd":"K000006947","dJobCdSeq":"1","dJobNm":"석유화학품질관리자","workSum":"석유화학 제품의 통계적 품질관리 기법을 활용하여 제품품질 판정, 제품 부적합관리, 품질규격 관리, 품질개선 업무를 수행한다.","doWork":"제품품질의 문제점을 파악하고 개선계획을 수립·실행하고 결과를 분석해서 측정 데이터의 신뢰성 여부를 확인한다. 제품품질의 분석오차를 점검하고 적합·부적합 판정을 한다. 부적합 유형별로 원인을 분석하고 처리방안을 결정하여 재발방지대책을 수립한다. 품질규격의 적합성을 판단하기 위해 고객 요구품질과 비교·분석하고 MSDS 관리를 확인하고 품질규격을 확정한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0284","dJobECdNm":"[0284]생산·품질 사무원","dJobJCd":"3124","dJobJCdNm":"[3124]생산 및 품질 관리 사무원","dJobICd":"C201","dJobICdNm":"[C201]기초 화학물질 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006968:1', '{"dJobCd":"K000006968","dJobCdSeq":"1","dJobNm":"석유화학품질보증평가기술자","workSum":"제품품질의 만족도를 보증하기 위하여 품질경영 시스템을 활용하여 납입사양서 관리, 4M 변경관리, 제품인증 시스템 관리, 성적서 관리 등을 수행한다.","doWork":"납입사양서 항목을 먼저 파악하고 고객 요구품질 수준을 결정하고 작성한다. 4M 변경항목을 파악하고 4M 변경 의뢰, 4M 변경품질 확인, 4M 변경 내·외부 승인, 4M 변경 관련 문서를 작성하고 관리한다. 품질경영시스템 인증을 위한 준비와 품질경영시스템 구축 방안을 모색하고 품질경영시스템 인증을 유지한다. 고객요구제품 인증 항목을 파악하고 인증요구항목의 적합성 여부를 검토한다. 품질경영시스템의 인증절차를 수행하고, 성적서 항목을 파악 후 성적서 작성책임자의 결재를 받고 성적서의 이력 관리업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0284","dJobECdNm":"[0284]생산·품질 사무원","dJobJCd":"3124","dJobJCdNm":"[3124]생산 및 품질 관리 사무원","dJobICd":"C201","dJobICdNm":"[C201]기초 화학물질 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005331:1', '{"dJobCd":"K000005331","dJobCdSeq":"1","dJobNm":"섬유생산일보작성원","workSum":"실이나 직물을 제조하는 공정의 일일생산량을 집계하여 기록표에 기록한다.","doWork":"정방 또는 직조공정에서 생산량을 기록한 기록표를 수집하여 집계한다. 기계의 기록표를 참고하여 운전가동률을 계산한다. 제품입고대장을 참고하여 입고전표를 작성한다. 경사·위사의 끊어진 정도나 직기별의 결점, 혹은 직물의 결점 등 제품의 결점을 수집·조사하여 기록표에 기록한다. 제품의 월간 입고량을 조사한다. 기계의 자동화율 및 작업인원을 조사·계산하여 상급자에게 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"단순작업","dJobECd":"0284","dJobECdNm":"[0284]생산·품질 사무원","dJobJCd":"3124","dJobJCdNm":"[3124]생산 및 품질 관리 사무원","dJobICd":"C131/C132","dJobICdNm":"[C131]방적 및 가공사 제조업 / [C132]직물직조 및 직물제품 제조업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001446:1', '{"dJobCd":"K000001446","dJobCdSeq":"1","dJobNm":"신발생산관리자","workSum":"확정된 견본과 신발규격서에 근거한 공정분석결과를 토대로 가용설비 및 가용인원을 분석하고 장비일정 및 자재일정을 감안하여 생산계획을 수립하고 집행한다.","doWork":"확정된 견본과 신발규격서를 통해 완제품의 유형을 파악한다. 신발유형에 근거한 공정분석을 한다. 가용설비 및 가용인원을 배치하고 장비일정 및 자재일정을 감안하여 생산계획을 수립한다. 고객과 정한 납기일을 고려하여 생산계획을 집행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"협의","workFunc3":"관련없음","similarNm":"생산계획사무원, 생산관리사무원, 생산관리기술자","dJobECd":"0284","dJobECdNm":"[0284]생산·품질 사무원","dJobJCd":"3124","dJobJCdNm":"[3124]생산 및 품질 관리 사무원","dJobICd":"C152","dJobICdNm":"[C152]신발 및 신발 부분품 제조업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003148:1', '{"dJobCd":"K000003148","dJobCdSeq":"1","dJobNm":"신발품질관리원","workSum":"신발 모든 공정의 품질기준을 관리하고, 제품규격에 따라 신발부분품 및 완제품의 결함을 검사한다.","doWork":"신발 모든 공정의 품질기준을 관리하고, 신발 각 부분의 접착 및 성형이 잘 되었는지 확인한다. 고르지 않거나 끊어진 바느질, 안감주름이나 지나친 접착, 오물 등의 결함을 찾아내기 위하여 신발과 각 부분품을 검사한다. 분필을 사용하여 심하게 손상된 부분이나 결함을 표시하고 수선지시서를 부착하여 해당 부서로 보낸다. 약품으로 오물을 닦아내기도 한다. 칼이나 가위, 바느질기계 등을 사용하여 결함이 있는 부분을 수선하기도 한다. 품질확보를 위한 예방에 관한 업무를 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"신발품질사무원, 신발품질관리기술자","connectJob":"신발중간검사원, 신발최종검사원, 품질관리자","certLic":"품질경영산업기사","dJobECd":"0284","dJobECdNm":"[0284]생산·품질 사무원","dJobJCd":"3124","dJobJCdNm":"[3124]생산 및 품질 관리 사무원","dJobICd":"C152","dJobICdNm":"[C152]신발 및 신발 부분품 제조업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005537:1', '{"dJobCd":"K000005537","dJobCdSeq":"1","dJobNm":"엘이디(LED)조명품질관리원","workSum":"엘이디(LED)조명제품의 품질관리계획과 기준을 수립하고 제품의 품질을 관리한다.","doWork":"LED조명제품의 품질관리를 위해 샘플제작, 금형 및 생산품의 품질관리계획과 기준을 수립한다. 품질기준에 따라 조명제품 제조에 필요한 원자재와 중간재가 품질기준에 적합한지 샘플검사를 통해 점검한다. 완제품에 대한 검사를 실시하여 품질기준을 만족하지 않을 경우 원인을 분석하여 조치를 취한다. 품질개선 관리활동을 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"협의","workFunc3":"관련없음","similarNm":"LED품질보증원","certLic":"품질관리기술사, 품질경영기사, 품질경영산업기사, 경영지도사(생산관리)","dJobECd":"0284","dJobECdNm":"[0284]생산·품질 사무원","dJobJCd":"3124","dJobJCdNm":"[3124]생산 및 품질 관리 사무원","dJobICd":"C284","dJobICdNm":"[C284]전구 및 조명장치 제조업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001298:1', '{"dJobCd":"K000001298","dJobCdSeq":"1","dJobNm":"원자력품질관리원","workSum":"원자력발전소 건설 시 원자력설비의 구조물, 계통, 기기 등에 대해 요구되는 품질에 적합한지 각종 검사장비를 사용하여 측정·검사한다.","doWork":"원자력설비의 구조물, 계통, 기기 등의 검사 및 시험계획을 수립한다. 수립된 계획에 따라 관련 장비의 준비, 설치를 포함한 시험준비를 한다. 절차서에 따라 볼트조임상태, 도장상태 및 도막두께, 배관의 압력상태, 충격, 치수, 전기절연상태 등에 대한 시험검사를 한다. 검사 결과를 보고서로 작성하여 제출한다. 결과서를 검토하여 인증을 위한 시험 및 검사결과의 타당성이나 합격여부를 평가한다. 원자력품질을 시험·검사하기 위한 관리자를 훈련시키고 자격을 인증하는 데 사용되는 특정프로그램의 적합성을 평가하는 업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"원자력발전기술사, 원자력기사, 품질관리기술사, 품질경영기사, 품질경영산업기사, 경영지도사(생산관리)","dJobECd":"0284","dJobECdNm":"[0284]생산·품질 사무원","dJobJCd":"3124","dJobJCdNm":"[3124]생산 및 품질 관리 사무원","dJobICd":"M729","dJobICdNm":"[M729]기타 과학기술 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004786:1', '{"dJobCd":"K000004786","dJobCdSeq":"1","dJobNm":"원자재품질분석원","workSum":"원자재의 품질을 확인하기 위해 샘플을 채취하여 물리적, 화학적, 열·전기적 특성 및 구성 등을 시험·분석한다.","doWork":"제품을 제조하는 데 필요한 원료의 샘플을 받아 제조할 제품에 필요한 특성과 구성 등을 시험기기와 분석장비를 이용하여 시험·분석한다. 유해물질, 필요성분의 함량, 물성 등이 제품의 제조에 적합한지 확인한다. 분석보고서를 작성하고 분석결과에 따라 원재료의 가공, 배합이나 제조방식의 변경 등이 가능하도록 관리자에게 통보한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"0284","dJobECdNm":"[0284]생산·품질 사무원","dJobJCd":"3124","dJobJCdNm":"[3124]생산 및 품질 관리 사무원","dJobICd":"C","dJobICdNm":"[C]제조업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006969:1', '{"dJobCd":"K000006969","dJobCdSeq":"1","dJobNm":"의약품기초품질관리원","workSum":"의약품 품질의 안정성을 확보하기 위하여 기준 및 시험방법 관리, 분석장비 관리, 표준품·검체·시약을 관리한다.","doWork":"환경모니터링을 위한 낙하균, 부유균의 기준 및 시험방법 파악 및 시험을 실시하고 시험기록서 및 시험성적서를 작성한다. 실험에 필요한 시약, 주의사항, 라벨 표시사항, 시약의 보관 장소 등을 확인한다. 분석 시료의 적합한 전처리 방법 및 분석시험에 필요한 시약과 용매를 확인하고 이화학 분석 장비의 조작 및 기초 실험을 수행하여 실험결과를 도출한다. 크로마토그라피 장비의 칼럼과 이동상의 조건을 확인하고 기본적인 조작을 수행한다. 분석 장비 검·교정 및 장비의 비정상에 대해 조치한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"0284","dJobECdNm":"[0284]생산·품질 사무원","dJobJCd":"3124","dJobJCdNm":"[3124]생산 및 품질 관리 사무원","dJobICd":"C211","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006970:1', '{"dJobCd":"K000006970","dJobCdSeq":"1","dJobNm":"의약품생산관리자","workSum":"의약품 생산 활동의 생산계획, 작업계획, 공급망 생산운영, 재고관리, 발주관리 등의 업무를 수행하고 생산 담당자의 업무를 관리감독한다.","doWork":"판매계획과 재고량에 따라 제품별 주간 및 월간 생산량을 결정하고 원자재 재고량에 따라 제품별 필요한 원자재를 구매 요청한다. 제품표준서를 활용하여 생산량에 따른 제품별 필요한 원자재의 종류, 필요한 장비 및 필요한 인력을 파악한다. 제품표준서에 따라 각 공정별 제조 소요시간, 공정 대기시간, 공정 청소시간, 품질검사 기간을 산출한다. 생산제품별 재고량에 따라 제조 우선순위를 결정하고, 주간 또는 월간 제조 일정을 계획하고 제조 일정계획에 따라 제품별 제조지시서 발행을 요청한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","dJobECd":"0284","dJobECdNm":"[0284]생산·품질 사무원","dJobJCd":"3124","dJobJCdNm":"[3124]생산 및 품질 관리 사무원","dJobICd":"C211","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007066:1', '{"dJobCd":"K000007066","dJobCdSeq":"1","dJobNm":"의약품품질관리기술자","workSum":"의약품 품질의 안정성을 확보하기 위하여 반제품 품질평가, 완제품 품질평가, 미생물 품질평가 업무를 수행한다.","doWork":"의약품 특성에 따른 안정성 시험계획 수립, 평가수행, 적합성 여부 판단, 안정성 평가보고서를 작성한다. 의약품의 허가 또는 변경을 위한 비교붕해 및 비교용출 시험계획 수립, 시험수행, 의약품동등성 시험결과보고서를 작성한다. 시험방법 밸리데이션 프로토콜(계획서) 작성, 밸리데이션 수행, 적합성 여부 판단 후 시험방법 밸리데이션 결과보고서를 작성한다. 분석시료분석계획에 따른 분석시료 채취, 제조 및 분석시료와 표준시료의 오차 등 시험결과의 분석, 종합, 최종 판정결과를 근거로 종합적 검증 및 결과보고서를 작성한다. 시험규격서(원자재 제품), QC시스템관련 지침서(SOP), 시험장비 및 작동관리 지침서 등을 작성, 개정 및 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"0284","dJobECdNm":"[0284]생산·품질 사무원","dJobJCd":"3124","dJobJCdNm":"[3124]생산 및 품질 관리 사무원","dJobICd":"C211","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007067:1', '{"dJobCd":"K000007067","dJobCdSeq":"1","dJobNm":"의약품품질기록관리자","workSum":"의약품 품질의 안정성을 확보하기 위하여 원료 품질검사, 포장재 품질검사, 원부자재 성적서 발행 등의 업무를 수행한다.","doWork":"원료 검체 채취 및 원료시험, 원료규격에 적합한 미생물시험 실시, 시험기록 및 시험성적서를 작성한다. 안정성시험의 시험방법을 파악하고, 시험을 실시하여 시험성적서와 결과보고서를 작성한다. 분석 장비별 검·교정 계획서를 작성하고, 검·교정보고서, 적격성 평가 내용, 응급조치사항 등의 관리이력 및 사용이력을 기록한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"0284","dJobECdNm":"[0284]생산·품질 사무원","dJobJCd":"3124","dJobJCdNm":"[3124]생산 및 품질 관리 사무원","dJobICd":"C211","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007428:1', '{"dJobCd":"K000007428","dJobCdSeq":"1","dJobNm":"의약품품질보증기술자","workSum":"의약품의 안정성과 효과성 등을 확보하기 위해 연간품질평가, 변경관리, 자율점검, 불만처리ㆍ제품회수, 안정성시험 등을 관리한다.","doWork":"제품표준서 개정, 이력 관리와 공정과 시험방법의 변경관리기록, 안정성 평가의 결과, 반품, 회수에 대한 기록, 시정예방조치에 대한 기록등을 확인하고 평가한다. 불만발생 시 내용 조사 및 원인 규명, 재발방지대책을 마련한다. <BR/>변경사항이 발생한 경우 품질위험관리(QRM,Quality Risk Management)를 통해 제품의 품질 또는 공정의 재현성에 미치는 영향과  위험요인을 예측하고 대처한다. 연간품질평가, 제조기록서 및 품질관리기록서의 데이터를 이용하여 표준제조공정의 적절성을 평가한다. 공정밸리데이션 수행 시 제품의 품질에 영향을 미치는 제조방법의 중요한 주요공정 선택, 검체 채취방법을 결정하고, 도출된 공정밸리데이션 통계데이터의 적합성 여부를 판단하여 결과보고서를 작성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"의약품 QA기술자","dJobECd":"0284","dJobECdNm":"[0284]생산·품질 사무원","dJobJCd":"3124","dJobJCdNm":"[3124]생산 및 품질 관리 사무원","dJobICd":"C211","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004382:1', '{"dJobCd":"K000004382","dJobCdSeq":"1","dJobNm":"전력품질관리원","workSum":"발전소의 운영 및 유지, 보수의 안전성과 신뢰성을 확보하고 설계, 시공, 운전 등의 전 과정에 걸친 품질관리 및 보증계획을 수립한다.","doWork":"발전소의 주요계통, 기기의 정기점검 및 주기점검절차서를 검토하여 품질관리방안계획을 수립한다. 전력설비의 설계, 건설, 운전에 관련된 계약서, 설계서, 제작도면, 규정 등을 검토하여 점검시행계획을 수립한다. 전력설비의 설계용역 공급계약자, 기기의 공급계약자, 시공계약자, 보수업체 등의 품질보증계획 및 관련 절차서가 품질보증기본방침 및 요건에 적합한지 여부를 검토한다. 품질관리세부지침에 따른 각 기자재 및 정비적격업체의 품질을 확인하여 부적합 사항을 처리한다. 품질감사 및 품질교육을 시행한다. 계약관계자료와 현장시험자료를 검토한다. 동위원소취급규정, 발전이론, 비파괴 및 용접에 관한 지식, 기계설치이론 등을 활용하여 점검·확인한다. 각 기기의 품질관리이론을 정리하여 지침서를 작성하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"전력품질보증원","connectJob":"담당하는 전문분야에 따라 수력발전품질관리원, 배전품질관리원, 송변전품질관리원, 열병합품질관리원, 원자력발전품질관리원, 화력발전품질관리원","certLic":"전기기사, 일반기계기사, 원자력기사, 품질관리기술사, 품질경영기사, 품질경영산업기사, 경영지도사(생산관리)","dJobECd":"0284","dJobECdNm":"[0284]생산·품질 사무원","dJobJCd":"3124","dJobJCdNm":"[3124]생산 및 품질 관리 사무원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007429:1', '{"dJobCd":"K000007429","dJobCdSeq":"1","dJobNm":"정밀화학생산관리자","workSum":"기업의 생산목표를 효과적으로 달성하기 위해 인적, 물적 자원의 효율적 배분·결합을 통해 생산과 관련된 계획수립과 집행, 생산실적을 관리한다.","doWork":"생산량 계획과 생산 우선순위의 결정, 생산능력을 파악하여 생산 일정을 계획한다. 생산요소자원 계획을 수립하고 제품 및 원부자재의 재고를 파악한다. 재고 파악 후 부족한 원부자재는 요청하여 원부자재 수급관리를 한다. 생산설비 및 적정인원을 배치하고 작업자에 대한 업무지시와 작업을 관리한다. 생산설비 이상 유무 및 제조원가를 관리하며 생산설비 운영관리 및 작업자의 생산성 관리를 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0284","dJobECdNm":"[0284]생산·품질 사무원","dJobJCd":"3124","dJobJCdNm":"[3124]생산 및 품질 관리 사무원","dJobICd":"C203/C204","dJobICdNm":"[C203]비료, 농약 및 살균, 살충제 제조업 / [C204]기타 화학제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007430:1', '{"dJobCd":"K000007430","dJobCdSeq":"1","dJobNm":"정밀화학품질관리자","workSum":"정밀화학 제품 소비자 수요에 적합한 품질의 제품을 제공하기 위하여 품질관리시스템을 통해 품질규격 관리, 제품품질 개선 및 부적합품 대책 수립 등을 수행한다.","doWork":"품질관리 시스템을 통해 품질관리 체계를 수립하고 규격 품질을 제정한다. 품질검사자가 검사한 품질검사 결과를 분석하여 품질 개선방안을 수립하고 품질개선을 실행한다. 성능 품질을 제정하고 부적합품에 대한 대책을 수립한다. 품질검사 시험방법의 유효성을 관리하고 시험결과를 검토하여 판정한다. 시험기준 일탈을 관리하고 품질개선 요소를 파악한다. 부적합품의 원인파악과 처리방법을 결정하고 재발방지를 위한 대책을 수립한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"0284","dJobECdNm":"[0284]생산·품질 사무원","dJobJCd":"3124","dJobJCdNm":"[3124]생산 및 품질 관리 사무원","dJobICd":"C203/C204","dJobICdNm":"[C203]비료, 농약 및 살균, 살충제 제조업 / [C204]기타 화학제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007431:1', '{"dJobCd":"K000007431","dJobCdSeq":"1","dJobNm":"정밀화학품질보증사무원","workSum":"기업의 정밀화학 생산제품이 소비자 수요에 적합한 품질의 제품임을 보증하기 위하여 품질보증 체계를 수립, 품질조사를 분석, 고객불만 대응 등을 수행한다.","doWork":"정밀화학 제품의 품질방침 및 목표를 수립하고 품질보증 계획을 수립한다. 품질매뉴얼을 문서화하고 품질절차서를 작성하며 품질보증 문서 및 기록을 관리한다. 고객의 품질만족도를 조사하여 고객불만을 분석한 후 개선점을 찾아 개선하고 예방조치계획을 수립하여 시행한다. 품질보증과 관련한 비용을 분석하여 개발되는 정밀화학 제품의 품질 목표를 설정하고 검사절차를 규정한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"0284","dJobECdNm":"[0284]생산·품질 사무원","dJobJCd":"3124","dJobJCdNm":"[3124]생산 및 품질 관리 사무원","dJobICd":"C203/C204","dJobICdNm":"[C203]비료, 농약 및 살균, 살충제 제조업 / [C204]기타 화학제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005803:1', '{"dJobCd":"K000005803","dJobCdSeq":"1","dJobNm":"출판물검수원","workSum":"서적, 신문, 잡지, 안내책자와 같은 출판물의 인쇄상태, 제본상태, 인쇄내용 등을 검사한다.","doWork":"인쇄물의 제본공정별로 견본을 수집한다. 인쇄물의 절단상태, 스테이플, 엮음상태, 장합상태 등 외형을 관찰한다. 낙장(일부의 접장이 부족한 대로 제책되는 것), 난장(페이지 순서가 흐트러져 있는 것), 더러움(인쇄물의 오염), 거꿀싸기(제책에서 표지와 속장의 아래위를 거꾸로 싼 것), 겹붙음(인쇄물이 서로 달라붙음), 겹인쇄(밀림 때문에 망점, 화선이 이중으로 된 것), 겹장(장합 때 같은 접장을 두개 이상 겹쳐 넣은 것), 귀접힘(양장일 때 인쇄지의 귀가 접힌 채로 재단된 것) 등의 결함사항 또는 결함이 생기는 공정에 대하여 관련작업원에게 통보한다. 컨베이어, 적재대, 검사대 등에서 결함이 있는 모든 인쇄물과 완본 인쇄물을 구별하여 수량과 결함원인을 기록한다. 결함상태에 따라 낱장갈이, 표지갈이 등 적절한 조치를 취한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0284","dJobECdNm":"[0284]생산·품질 사무원","dJobJCd":"3124","dJobJCdNm":"[3124]생산 및 품질 관리 사무원","dJobICd":"J581","dJobICdNm":"[J581]서적, 잡지 및 기타 인쇄물 출판업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003973:1', '{"dJobCd":"K000003973","dJobCdSeq":"1","dJobNm":"컨테이너검사반장","workSum":"컨테이너검수원을 지휘하여 본선, 게이트 등 화물인수장소에서 검수작업을 관리·감독한다.","doWork":"본선작업(선박을 접안시킨 상태에서 선박으로부터 직접 화물을 내리거나, 선박에 싣는 작업)을 위해 본선 적부도(Stowage Plan:본선의 선창에 화물이 적재된 상태를 나타낸 도면)와 적하목록(Cargo Manifest:積荷目錄, 선박 또는 항공기가 적재하고 있는 화물의 목록)을 대조·확인한다. 작업일지를 작성하고 검수원들에게 검수작업을 지시한다. 컨테이너검수원이 작성한 검수표와 적하목록을 대조한다. 상이할 경우 하선·적재결과 이상보고서를 작성한다. 검사결과 이상보고서를 세관 및 선사에 송부한다. 컨테이너파손보고서(Container Damage Report)를 작성하여 항해사와 협의하여 서명을 받는다. 냉동컨테이너의 리스트를 작성하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","dJobECd":"0284","dJobECdNm":"[0284]생산·품질 사무원","dJobJCd":"3124","dJobJCdNm":"[3124]생산 및 품질 관리 사무원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004014:1', '{"dJobCd":"K000004014","dJobCdSeq":"1","dJobNm":"탄소나노튜브품질관리원","workSum":"합성된 탄소나노튜브(CNT)의 결정성, 직경, 금속성, 분체저항, 화학적 조정시험을 통해 품질을 검사한다.","doWork":"합성된 탄소나노튜브의 시료를 채취하여 결정성, 직경, 금속성, 분체저항, 화학적 조정시험을 통해 품질을 검사한다. 니켈, 구리, 코발트, 몰리브덴, 철 등 탄소나노튜브의 잔존금속촉매 불순물의 잔존량검사를 통해 품질검사와 독성검사를 실시한다. 검사분석을 통해 측정된 검사값이 표준품질에 미달할 경우 원·부자재나 제조공정상의 문제점을 분석하여 품질 이상의 원인을 파악하고 조치를 취한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"품질관리기술사, 품질경영기사, 품질경영산업기사, 경영지도사(생산관리)","dJobECd":"0284","dJobECdNm":"[0284]생산·품질 사무원","dJobJCd":"3124","dJobJCdNm":"[3124]생산 및 품질 관리 사무원","dJobICd":"C239","dJobICdNm":"[C239]기타 비금속 광물제품 제조업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003540:1', '{"dJobCd":"K000003540","dJobCdSeq":"1","dJobNm":"품질관리사무원(일반)","workSum":"자재의 구매에서부터 제품의 생산에 이르기까지 전 과정에 걸쳐 제품규격의 표준화 달성, 품질개선, 생산성 향상을 위한 계획수립, 운영, 관리 및 감독을 한다.","doWork":"소비자의 수요에 적합한 품질의 제품을 경제적인 수준으로 생산할 수 있도록 품질 설계을 한다. 작업표준을 개발하고 제조를 실시한다. 제품의 품질이 정해진 수준을 만족하는지 검사한다. 제조공정의 표준화, 안전화를 기초로 목적에 맞는 품질의 신뢰구간을 결정하고, 통계학을 활용해서 품질을 장기적으로 안정화시킨다. 품질에 산포(散布)가 발생했을 때는 공정을 개선한다. 제품품질에 대한 소비자의 만족도나 새로운 품질 요구사항을 파악하여 품질관리에 반영한다. 생산공정을 지도하고 감독한다. 외주업체의 품질을 관리하기도 한다. 품질인증 신청, 관리, 문서작업화 등 품질보증업무를 하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"품질관리원, QC원, QA원","connectJob":"자동차품질관리사무원, 식품품질관리사무원, 화학제품품질관리사무원, 금속제품품질관리사무원 전기제품품질관리사무원, 전자제품품질관리사무원, 정보통신제품품질관리사무원, 항공기품질관리사무원, 조선품질관리사무원, 섬유제품품질관리사무원 등, 품질보증사무원","certLic":"품질관리기술사, 품질경영기사, 품질경영산업기사, 경영지도사(생산관리)","dJobECd":"0284","dJobECdNm":"[0284]생산·품질 사무원","dJobJCd":"3124","dJobJCdNm":"[3124]생산 및 품질 관리 사무원","dJobICd":"M739","dJobICdNm":"[M739]그 외 기타 전문, 과학 및 기술 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007193:1', '{"dJobCd":"K000007193","dJobCdSeq":"1","dJobNm":"품질보증사무원(일반)","workSum":"제품의 품질을 보증하기위하여 신뢰성, 인증시험을 주관하고 협력사 제품 품질을 관리하며, 개발품질의 규격을 설정하고, 국내외 해외규격관리를 한다.","doWork":"양산전 제품의 성능을 검사하기 위한 인증시험, 양상 이후 검사하는 신뢰성 시험 업무를 한다. 고객 크레임 대응, 고객사 심사 응대, 외주협력사 공장심사 등을 한다. 개발되는 제품의 품질 목표를 설정하고 검사스텍을 규정한다. ISO, 화평법, 화관법 등 국내외 품질규격의 인증 및 개정을 위한 준비, 심사응대, 심사 및 개정관리 업무를 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"QA원, 품질보증원","connectJob":"자동차품질보증사무원, 식품품질보증사무원, 화학제품품질보증사무원, 금속제품품질보증사무원 전기제품품질보증사무원, 전자제품품질보증사무원, 정보통신제품품질보증사무원, 항공기품질보증사무원, 조선품질보증사무원, 섬유제품품질보증사무원 등 품질보증사무원","certLic":"품질관리기술사, 품질경영기사, 품질경영산업기사, 경영지도사(생산관리)","dJobECd":"0284","dJobECdNm":"[0284]생산·품질 사무원","dJobJCd":"3124","dJobJCdNm":"[3124]생산 및 품질 관리 사무원","dJobICd":"C","dJobICdNm":"[C]제조업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005101:1', '{"dJobCd":"K000005101","dJobCdSeq":"1","dJobNm":"풍력타워품질검사원","workSum":"제조된 풍력타워(Wind Tower)의 품질을 관리하기 위해 품질관리계획을 수립하고 수행한다.","doWork":"제조된 풍력타워(Wind Tower)의 품질을 관리하기 위해 품질관리계획을 수립한다. 편평도, 벤딩상태, 페인트 도막두께 등을 측정·점검하고 용접부위의 품질상태를 점검하기 위해 비파괴검사를 실시한다. 결함이 발견되면 원인을 분석하여 생산공정에 통보한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"관련없음","similarNm":"윈드타워품질검사원","dJobECd":"0284","dJobECdNm":"[0284]생산·품질 사무원","dJobJCd":"3124","dJobJCdNm":"[3124]생산 및 품질 관리 사무원","dJobICd":"C291","dJobICdNm":"[C291]일반 목적용 기계 제조업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007436:1', '{"dJobCd":"K000007436","dJobCdSeq":"1","dJobNm":"플라스틱품질관리자","workSum":"플라스틱 품질관리의 기본이론 및 현장 실무지식을 사용하여 주어진 권한 내에서 전반적인 품질관리 업무를 수행하고 품질검사 담당자에게 관련 지식을 전달하고 업무를 감독한다.","doWork":"플라스틱제품의 표준을 확인하여 검사한 후 성적서를 작성하고 분석  관리하며 성형품의 품질안정성을 확보한다. 플라스틱의 품질관리 기준 확인, 품질 분석, 사출성형품 검사, 통계적 품질관리 적용 등의 업무를 수행한다. 플라스틱 원부재료의 입고검사, 성형품 평가, 부적합 대책 요구, 통계적 품질관리를 통하여 성형품의 품질을 보증한다. 플라스틱제품의 품질을 관리하여 수준 이상으로 유지하기 위해 통계적 데이터 해석, 불량원인 분석, 품질개선기법 운영, 품질인증제도를 운영한다. 품질개선안을 도출하며, 개선계획을 수립하여 실행하고, 개선효과를 분석한다. 플라스틱의 물리화학생화학적 특성 품질규격과 성능 품질규격을 제정하고 품질규격 시험·평가방법을 제정하고 품질규격과 시험·평가방법을 관리한다. 부적합품처리 계획을 수립하고, 원인 분석을 토대로 처리방안을 결정하며 재발 방지대책을 수립한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"0284","dJobECdNm":"[0284]생산·품질 사무원","dJobJCd":"3124","dJobJCdNm":"[3124]생산 및 품질 관리 사무원","dJobICd":"C/C222","dJobICdNm":"[C]제조업 / [C222]플라스틱제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007107:1', '{"dJobCd":"K000007107","dJobCdSeq":"1","dJobNm":"플라스틱품질보증사무원","workSum":"플라스틱 품질관리 이론 및 현장 실무지식을 사용하여 주어진 권한 내에서 플라스틱 품질의 부적합 대책을 수립하는 등 전반적인 품질보증 업무를 수행한다.","doWork":"플라스틱제품과 플라스틱 성형품, 플라스틱 사출성형의 부적합 유형을 파악하여 부적합을 사전에 방지한다. 발생한 부적합 내용과 발생 원인을 파악하여 부적합 방지대책을 수립한다. 플라스틱 공정의 안정성을 확보하기 위해 품질관리 기법을 활용하여 중점관리항목 선정, 관리도 작성, 공정능력 평가, 품질데이터 분석 업무를 수행한다. 품질목표 달성을 위해 품질경영 체계를 구축하고, 문서화하여 품질경영 시스템을 운영한다. 고객이 요구하는 제품·기술서비스의 품질을 충족시키기 위해 업무 단계별 품질보증업무를 파악, 분석하여 프로세스를 정립, 운영하고 이에 대한 유효성을 평가한다. 플라스틱 생산 제품의 불량률을 최소화하기 위해 부적합품처리 계획을 수립하고, 원인 분석을 토대로 처리방안을 결정하며 재발 방지대책을 수립한다. 플라스틱 품질과 관련된 고객의 불만사항을 해소하기 위해 고객 불만사항 파악, 시정조치 및 예방조치 업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"품질경영산업기사, 품질경영기사","dJobECd":"0284","dJobECdNm":"[0284]생산·품질 사무원","dJobJCd":"3124","dJobJCdNm":"[3124]생산 및 품질 관리 사무원","dJobICd":"C222","dJobICdNm":"[C222]플라스틱제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005653:1', '{"dJobCd":"K000005653","dJobCdSeq":"1","dJobNm":"할랄제품모니터링요원","workSum":"할랄제품의 제조과정을 점검하고 할랄제품 적합성을 확인한다.","doWork":"할랄제품의 생산공정과 평가기준을 바탕으로 할랄무결성 여부를 점검한다. 재료구입 및 재료보관, 가공, 제조공정, 완제품의 품질관리업무 등 전 공정에서 할랄표준에 위배되는 작업의 유무를 점검하고 표준관리에 반영한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"할랄심사원","dJobECd":"0284","dJobECdNm":"[0284]생산·품질 사무원","dJobJCd":"3124","dJobJCdNm":"[3124]생산 및 품질 관리 사무원","dJobICd":"M739","dJobICdNm":"[M739]그 외 기타 전문, 과학 및 기술 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006135:1', '{"dJobCd":"K000006135","dJobCdSeq":"1","dJobNm":"합판품질관리원","workSum":"합판제조과정 또는 제조된 합판에 대해 품질검사를 실시하여 시정을 지시한다.","doWork":"합판제조작업표준서에 명시된 표준작업이 이행되지 않았거나 잘못된 작업을 파악하여 각 공정별로 시정하도록 지시한다. 접착상태, 표면처리, 보수작업 등 각종 공정에 대해 품질개선방안을 분석하여 관련 부서에 통보하여 개선하도록 한다. 품질개선활동을 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"합판품질보증원","connectJob":"제품종류에 따라 파티클보드품질관리원, 하드보드품질관리원","certLic":"품질관리기술사, 품질경영기사, 품질경영산업기사, 경영지도사(생산관리)","dJobECd":"0284","dJobECdNm":"[0284]생산·품질 사무원","dJobJCd":"3124","dJobJCdNm":"[3124]생산 및 품질 관리 사무원","dJobICd":"C162","dJobICdNm":"[C162]나무제품 제조업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006786:1', '{"dJobCd":"K000006786","dJobCdSeq":"1","dJobNm":"해양플랜트품질관리자","workSum":"해양플랜트 공사에 투입되는 기자재의 품질을 관리한다.","doWork":"해양플랜트 공사에 납입되는 자재가 적합한 품질인지 확인하고 재료별 특성에 따라 감독 및 관리한다. 납입된 밸브, 배관, 압력용기 등이 요구된 규격사항에 적합한지 확인한다. 자재의 용접상태가 규격사항에 적합한지 비파괴검사 등을 통해 확인한다. 자재의 표면처리가 요구된 규격사항에 적합한지 검사한다. 품질검사 및 관리내역의 보고서를 작성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"협의","workFunc3":"정밀작업","dJobECd":"0284","dJobECdNm":"[0284]생산·품질 사무원","dJobJCd":"3124","dJobJCdNm":"[3124]생산 및 품질 관리 사무원","dJobICd":"F412","dJobICdNm":"[F412]토목 건설업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005423:1', '{"dJobCd":"K000005423","dJobCdSeq":"1","dJobNm":"휴대폰공정관리기술자","workSum":"휴대폰의 생산성을 검토하고 공정설계와 공정기술교육, 생산성 개선을 수행한다.","doWork":"휴대폰의 생산수준을 검토하기 위하여 제품의 구조와 특성을 파악한다. 휴대폰의 생산 관련 자료를 근거로 생산가능성을 검토한다. 설비와 공정도를 고려하여 생산설비 호환성과 제반 문제점들을 파악한다. 작업지시서를 통하여 공정별 작업자수와 작업순서, 작업시간 등을 검토하여 생산성을 파악한다. 생산하고자 하는 휴대폰의 제조규격과 검토한 생산성이 반영된 공정을 설계한다. 효율적인 생산을 위하여 제품생산 단계별 절차를 검토하여 제조공정도를 작성한다. 제조공정도를 근거로 각 공정단계에서의 생산설비와 필요인력을 파악하여 생산라인에 배치한다. 작성된 제조공정도와 생산설비, 인력배치를 통하여 작업표준을 확립한다. 교육훈련계획에 따라 공정별 작업자들을 대상으로 교육훈련을 실시하고 평가한다. 공정단계별 소요시간과 생산수율을 관리하는 데이터를 분석한다. 생산수율과 생산능력을 고려하여 공정개선목표를 설정하고 공정단계별 데이터를 분석하여 문제점을 파악하고 대책을 수립한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"조정","workFunc2":"협의","workFunc3":"제어조작","dJobECd":"0284","dJobECdNm":"[0284]생산·품질 사무원","dJobJCd":"3124","dJobJCdNm":"[3124]생산 및 품질 관리 사무원","dJobICd":"C264","dJobICdNm":"[C264]통신 및 방송 장비 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004097:1', '{"dJobCd":"K000004097","dJobCdSeq":"1","dJobNm":"휴대폰생산관리기술자","workSum":"휴대폰의 생산정보를 기반으로 생산계획을 수립하고 생산실적을 관리한다.","doWork":"판매계획을 기반으로 재고수량을 반영하여 생산하고자 하는 휴대폰의 생산량을 결정한다. 결정된 생산량을 토대로 생산라인, 작업자, 원자재 수급현황을 고려하여 생산계획서를 작성한다. 수립된 생산계획서를 기반으로 영업, 관리, 구매, 개발 등 유관부서와 생산일정을 협의하여 최종 생산계획을 수립한다. 생산관리프로그램을 통해 휴대폰의 생산라인별 월간·주간·일간 생산실적자료를 확인하고 생산계획서와 비교하여 생산진도를 확인한다. 생산실적이 목표에 미달되었을 경우 유관부서와의 협의를 통해 대책방안을 수립한다. 대책방안을 토대로 각 부서별로 생산실적이 달성되도록 조치를 취한다. 생산과정에서 투입되는 요소에 따른 생산요소의 변동을 분석한다. 생산과정에서 수율저하에 따른 원인을 신속하게 파악하여 이를 개선한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"조정","workFunc2":"협의","workFunc3":"제어조작","dJobECd":"0284","dJobECdNm":"[0284]생산·품질 사무원","dJobJCd":"3124","dJobJCdNm":"[3124]생산 및 품질 관리 사무원","dJobICd":"C264","dJobICdNm":"[C264]통신 및 방송 장비 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006784:1', '{"dJobCd":"K000006784","dJobCdSeq":"1","dJobNm":"휴대폰생산기술자","workSum":"휴대폰의 생산수량과 납기를 만족시키기 위해 생산기술과 자재수급을 파악하고 인력계획을 수립하여 생산비용을 산출한다.","doWork":"휴대폰 생산의 효율성을 높이기 위하여 생산설비계획과 치공구사용계획을 수립한다. 작업지시서 작성에 필요한 시제품과 제품도면, 시험절차서와 설비현황자료를 수집한다. 수집된 자료와 공정별 소요시간을 기반으로 최적화된 작업방법과 검사방법을 수립한다. 작업자가 쉽게 이해할 수 있도록 상세하고 명확하게 작업지시서를 작성한다. 개발부서에서 이관된 시험절차서를 토대로 생산공정별 필요 치공구를 파악한다. 보유하고 있는 치공구에 대하여 수량을 파악하고 상태를 점검한다. 필요한 치공구에 대하여 구매계획을 수립한다. 생산효율을 높이기 위하여 치공구 사용방법을 작업지시서에 반영한다. 휴대폰의 목표기술을 검토하여 생산공정을 설계한다. 생산공정자료를 바탕으로 공정계획도를 작성한다. 승인된 공정계획도를 바탕으로 생산라인배치를 설정한다. 공정계획도와 생산설비계획서, 작업지시서를 기반으로 작업표준서를 작성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"0284","dJobECdNm":"[0284]생산·품질 사무원","dJobJCd":"3124","dJobJCdNm":"[3124]생산 및 품질 관리 사무원","dJobICd":"C264","dJobICdNm":"[C264]통신 및 방송 장비 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005400:1', '{"dJobCd":"K000005400","dJobCdSeq":"1","dJobNm":"휴대폰품질관리기술자","workSum":"휴대폰의 목표품질을 확보하고 달성하기 위해 품질계획을 수립하고 이를 관리한다.","doWork":"생산하고자 하는 휴대폰의 품질을 확보하기 위하여 품질계획을 수립한다. 휴대폰과 관련된 자재 수입검사와 신뢰성 시험, 제품인증관리와 품질규격 부적합을 관리한다. 제품승인원을 기반으로 품질관리계획서와 품질공정도를 작성한다. 생산계획에 따라 휴대폰품질검사기준에 대한 검증과 모니터링, 측정과 검사활동, 제품합격 판정기준을 수립한다. 검사규격서에 따라 입고된 자재에 대하여 외관, 성능, 신뢰성 검사를 수행한다. 검사 중 부적합품이 발생할 경우 부적합보고서를 작성하여 생산유관부서에 통보한다. 시험절차에 따라 특정 조건하에서 기계적, 전기적, 시각적 규격을 유지할 수 있는 부품과 제품의 성능과 신뢰성에 대한 시험을 수행한다. 측정된 시험데이터를 기준으로 제품에 대한 불량 여부를 판정한다. 국가나 국제규격 적합 여부를 공인시험기관에 의뢰하여 인증서를 취득한다. 취득한 인증서에 대하여 제품인증관리기준에 의해 사후관리검사를 실시한다. 사후관리검사 후 발생한 부적합품에 대하여 부적합관리규정에 따라 처리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"조정","workFunc2":"협의","workFunc3":"제어조작","dJobECd":"0284","dJobECdNm":"[0284]생산·품질 사무원","dJobJCd":"3124","dJobJCdNm":"[3124]생산 및 품질 관리 사무원","dJobICd":"C264","dJobICdNm":"[C264]통신 및 방송 장비 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004093:1', '{"dJobCd":"K000004093","dJobCdSeq":"1","dJobNm":"휴대폰품질보증기술자","workSum":"휴대폰에서 요구되는 품질이 충족되도록 신뢰성 있는 품질시스템을 구축하고 문서화하여 품질혁신활동을 수행한다.","doWork":"양질의 제품생산에 필요한 품질방침과 품질목표를 수립한다. 품질매뉴얼에 따라 생산 관련 조직과 단위 생산공정에 관한 품질절차서를 작성하고 품질보증프로세스를 규정한다. 품질개선활동과 달성된 결과를 기반으로 표준화된 문서를 작성한다. 품질혁신활동을 활성화하기 위하여 품질제안활동과 분임조활동을 지원한다. 품질혁신활동을 통하여 발견된 부적합은 시정조치하고, 잠재적인 문제점은 예방조치한다. 외부업체 품질을 실사하기 위하여 품질실사일정을 수립하고 실행한다. 내부품질을 실사하기 위하여 품질실사일정을 수립하고 실행한다. 고객사의 품질실사에 대응하기 위하여 실사일정을 확인하고 준비한다. 실사결과를 바탕으로 품질실사 실행과 점검결과를 작성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0284","dJobECdNm":"[0284]생산·품질 사무원","dJobJCd":"3124","dJobJCdNm":"[3124]생산 및 품질 관리 사무원","dJobICd":"C264","dJobICdNm":"[C264]통신 및 방송 장비 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005138:1', '{"dJobCd":"K000005138","dJobCdSeq":"1","dJobNm":"관세사무원","workSum":"관세사의 지휘하에 수출 및 수입통관, 환급 등 관련 서류를 작성하고 신청한다.","doWork":"수출입대상 품목을 분류하고 세액을 산출한다. 수출 및 수입통관 관련 문서를 검토하고 컴퓨터에 입력하여 신고한다. 환급요건을 확인하고 신청서류를 작성하여 신청한다. 통관검사에 입회한다. 수출입에 관련된 세금을 납부하고 수출입신고필증을 통보한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"관세행정사무원, 원산지관리사무원","certLic":"무역영어","dJobECd":"0281","dJobECdNm":"[0281]무역 사무원","dJobJCd":"3125","dJobJCdNm":"[3125]무역 사무원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003267:1', '{"dJobCd":"K000003267","dJobCdSeq":"1","dJobNm":"무역사무원(일반)","workSum":"무역절차의 흐름을 파악하여 원재료 및 상품의 수출입에 관련하여 수출입사전준비, 수출입위험관리, 수출입계약, 수출입운송보험, 수출입마케팅, 수출입통관, 수출입대금결제 등의 업무를 한다.","doWork":"국내외 규범에 따라 수출입계획 수립, 수출입요건 구분, 거래당사자 구분, 수출입프로세스 정립, 수출입서식준비 등 수출입계획을 수립한다. 결제방식별 수출입위험관리방안을 마련하기 위해 환위험분석, 환위험관리, 무역보험 가입, 보증서 활용 등 위험관리 방안을 마련한다. 수출입 계약을 위한 초안준비, 계약체결 방법, 계약서 작성 및 검토 등을 비롯하여 계약체결 이후 계약의 이행과 종료에 관한 전반적 과정을 다룬다. 운송계획의 수립, 운송서류 구분, 운송계약 체결, 운송비 책정, 적하보험 가입 등을 한다. 수출시장을 개척하기 위하여 해외시장조사, 해외시장 진출전략 수립, 바이어신용조사, 수출원가 계산 등을 하고 수출협상을 한다. 국내외 시장수요조사를 하여 해외공급자를 발굴하고 수입할 물품을 확보한다. 적법한 절차에 따라 수출물품의 신속한 통관을 위하여 서류검토, FTA검토, 관세환급, 사후관리 등의 통관계획을 수립하고 진행한다. 적법한 절차에 따라 수입통관을 위해 서류작성, 관세납부, 사후관리 등의 계획을 수립하고 진행한다. 국외로부터 신속한 물품의 확보를 위해 송금, 추심, 신용장 결제 등의 수출입 대금결제를 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"국제무역사무원","connectJob":"수입무역사무원, 수출무역사무원, 관세사무원, 통관사무원, 원산지사무원","certLic":"관세사, 원산지관리사","dJobECd":"0281","dJobECdNm":"[0281]무역 사무원","dJobJCd":"3125","dJobJCdNm":"[3125]무역 사무원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004983:1', '{"dJobCd":"K000004983","dJobCdSeq":"1","dJobNm":"원산지관리사","workSum":"제조·수출기업의 FTA 활용을 위해 물품의 원산지 충족여부 확인 및 관리, 원산지증빙서류(원산지확인서, 원산지증명서 등) 발급 등을 담당하며 FTA 및 원산지에 대한 연구, 교육 및 컨설팅 서비스 제공 등을 통해 FTA를 활용하는 업체의 원활한 FTA 이행을 지원한다.","doWork":"FTA 특혜관세 혜택을 받기 위한 FTA 활용전략을 수립한다., 제품의 원산지 충족여부를 확인하고 증명한다. FTA 특혜관세 혜택을 위한 전략적 수출지역 선정하거나 FTA 체약국별 원가개선 효과분석 등을 통해 글로벌 생산·조달 네트워크를 구축한다. 생산 제품과 소요 재료의 품목분류(HS Code)를 확인하여 FTA별 원산지결정기준을 확인하고, 해당 기준을 적용하여 제품의 원산지 충족여부를 판정한 후 원산지증빙서류(원산지증명서, 원산지확인서 등)를 발급한다. 자재명세서, 생산공정 등 원산지 판정과 원산지증빙서류 발급에 필요한 기초 자료를 관리하고, FTA 체약상대국의 원산지검증 대응을 위해 자료제출 등 사후관리 업무를 수행한다. FTA 활용(예정) 제조·수출기업, 물류기업 등에게 FTA 특혜관세 혜택 및 활용에 대한 교육 및 컨설팅 등 서비스를 제공한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"협의","workFunc3":"관련없음","connectJob":"원산지컨설턴트, 원산지실무사무원","certLic":"원산지관리사, 무역영어","dJobECd":"0281","dJobECdNm":"[0281]무역 사무원","dJobJCd":"3125","dJobJCdNm":"[3125]무역 사무원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003539:1', '{"dJobCd":"K000003539","dJobCdSeq":"1","dJobNm":"종합무역중개인","workSum":"무역과 관련된 수출절차, 수입절차, 수출입 관련제도 등에 대한 제반 사항 및 절차를 관리 또는 대행한다.","doWork":"수출업무와 관련된 무역업신고, 거래처 발굴, 신용조회, 계약체결, 물품확보, 대금회수 등의 절차에 대한 정보를 수집 또는 제공하고 구비서류를 준비한다. 수입업무와 관련된 수입승인, 수입결제방법, 대금결제, 수입통관 등의 절차를 숙지하고 관련 구비서류를 준비한다. 기타 무역특혜제도의 적용 유무, 관세환급, 수출입 대행, 원산지표시제도 등에 대한 제반 지식을 바탕으로 제반 업무를 대행 또는 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"무역업자","connectJob":"무역컨설턴트","certLic":"무역영어","dJobECd":"0281","dJobECdNm":"[0281]무역 사무원","dJobJCd":"3125","dJobJCdNm":"[3125]무역 사무원","dJobICd":"G461","dJobICdNm":"[G461]상품 중개업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003293:1', '{"dJobCd":"K000003293","dJobCdSeq":"1","dJobNm":"통관사무원","workSum":"시설재, 원자재, 제품 등의 수출·입 통관을 위해 통관계획을 입안하고 통관진행에 따른 제반 업무와 사후관리업무를 수행한다.","doWork":"수출·입에 필요한 각종 통관서류를 작성하여 해당 부서에 통보한다. 관세청, 세관에 관련된 제반 문제를 해결한다. 통관에 필요한 관세 및 비용을 산출하여 자금부서에 소요자금을 요청한다. 감정부서에 감정을 의뢰·입회하고 감정보고서를 확인한다. 선적서류를 분류·정리하고 해당 부서에 전달한다. 기타 통관에 관련된 사후 제반 문제를 관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"수행하는 업무의 전문분야에 따라 수입통관사무원, 수출통관사무원","dJobECd":"0281","dJobECdNm":"[0281]무역 사무원","dJobJCd":"3125","dJobJCdNm":"[3125]무역 사무원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002399:1', '{"dJobCd":"K000002399","dJobCdSeq":"1","dJobNm":"가스수송사무원","workSum":"가스도입계획에 따라 가스가 원활히 도입될 수 있도록 관리업무를 수행한다.","doWork":"가스도입계획에 따라 가스가 도입될 수 있도록 가스수송계획을 수립한다. 도입할 가스의 규모를 근거로 수송운임을 산출한다. 선박회사와 수송비용 및 제반 비용에 대해 협상한다. 선박회사와 운임, 보험, 지불방법 등의 수송계약을 체결한다. 수송일정에 따라 선박운항에 대해 관리한다. 수송과 관련된 시장상황을 조사하기 위해 자료를 수집·분석한다. 선박 및 항만 관련 행정업무를 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"D352","dJobICdNm":"[D352]연료용 가스 제조 및 배관공급업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002227:1', '{"dJobCd":"K000002227","dJobCdSeq":"1","dJobNm":"계류장관리원","workSum":"계류장에서 지상조업을 실시하는 작업원들의 활동을 감독·조정한다.","doWork":"항공기 운항의 지연을 방지하기 위하여 정비, 항공유의 급유, 기내식탑재, 화물탑재 등의 지상조업상황을 계류장통제원으로부터 보고를 받아 운항 대기시간 및 작업 진행시간을 검토한다. 소속항공사와 협의하여 계류장의 사용계획을 수립한다. 각 항공기의 지상 작업시간을 검토하여 지연원인을 분석하고 대책을 수립한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"10년 초과","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"계산","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006551:1', '{"dJobCd":"K000006551","dJobCdSeq":"1","dJobNm":"계류장통제원","workSum":"항공기의 청소, 정비, 기내용품의 탑재 등을 실시하는 계류장을 통제하는 업무를 한다.","doWork":"각 항공사로부터 접수된 항공기의 지상작업을 지원하기 위하여 계류장의 사용여부를 통보한다. 각 항공기의 지상 작업시간을 확인한다. 작업상태를 점검한 계류장으로 유도되는 항공기의 수 및 항공사 등을 확인한다. 항공기유도원에게 작업할 장소를 지시한다. 항공기가 정지점(Spot)에 정지하면 관련 서류를 검토하여 청소, 항공유의 급유, 기내식의 탑재 등을 지시한다. 작업이 완료되면 관련 서류를 정리하여 계류장관리원에게 인계한다. 항공기의 수량, 소속 항공사, 작업시간 등을 정리하여 보고서를 작성한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"대기환경미흡|소음·진동|","workFunc1":"계산","workFunc2":"감독","workFunc3":"유지","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004649:1', '{"dJobCd":"K000004649","dJobCdSeq":"1","dJobNm":"교통정보접수원","workSum":"교통정보를 수집하고 컴퓨터에 입력하며 민원을 처리한다.","doWork":"정체구간, 사고지역 등의 교통정보를 CCTV 및 전화로 수집하여 컴퓨터로 교통정보를 입력한다. 입력된 교통정보를 종합하여 교통관련 민원서비스를 실시한다. 전화나 인터넷을 통한 교통정보 문의사항에 대하여 상세한 교통정보서비스를 제공한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"O842","dJobICdNm":"[O842]사회 및 산업정책 행정","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003332:1', '{"dJobCd":"K000003332","dJobCdSeq":"1","dJobNm":"기관차배차원","workSum":"기관차와 각종 대차가 원활히 운행될 수 있도록 배차계획을 수립하여 배차하고, 운행상황을 기록·보고한다.","doWork":"관련 부서와 수시로 협의하고 총 물동량 및 철도수송능력 등을 파악하여 철도수송을 위한 배차계획을 수립한다. 물량을 수송하기 위하여 배치된 기관차 및 각종 대차가 운행될 수 있도록 운행조정설비를 사용하여 운행진로를 제어한다. 기관차 및 각종 대차의 운행 경위를 기관차 내부에 설치된 작업지시장치를 사용하여 작업지시사항을 통보한다. 기관차의 원활한 운행을 위해 열차정리를 한다. 운행조정설비 및 부대설비의 작동상태 이상 여부를 점검하고 이상 시 수리 의뢰를 한다. 기관차별 수송경로, 운행시간, 당일 수송실적 등의 각종 통계와 기관 및 설비, 장비의 이상 등 특기사항을 기록·보고하고 다음 근무자에게 인계한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"감독","workFunc3":"관련없음","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H491","dJobICdNm":"[H491]철도 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006080:1', '{"dJobCd":"K000006080","dJobCdSeq":"1","dJobNm":"도선상황실운영원","workSum":"도선업무를 수행할 도선사를 배정하고, 사고 등 도선사가 업무수행 중에 발생하는 각종 상황에 대응한다.","doWork":"선박접안에 따라 선사대리점으로부터 도선요청을 접수받는다. 도선순번제도 또는 도선업무의 특별사정(지속적으로 이동 중인 상황)을 고려하고 도선사 등급과 선박의 규모 등을 고려하여 적절한 도선사를 배정한다. 도선사에게 유선 또는 무선으로 도선 배정사실, 선박의 명칭, 위치, 규모 등을 통보한다. 배정된 도선사에 대한 내용을 선사대리점에 알려준다. 도선에 대한 주문의 취소 등 도선에 대한 상황변화를 도선사에 통보한다. 도선 중의 각종 사고상황을 도선사로부터 접수하고 도선사의 승하선을 결정한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002972:1', '{"dJobCd":"K000002972","dJobCdSeq":"1","dJobNm":"라싱작업관리원","workSum":"선박라싱(Lashing:선체동요로 인한 컨테이너의 추락을 방지하기 위한 고정)작업을 총괄 지휘한다.","doWork":"선박의 입항예정을 컨테이너 터미널이나 선사로부터 통보받고 본선적부도를 사전에 접수받아 작업을 계획한다. 항운노조원 등에게 작업수요인원을 요청한다. 본선입항 시 승선하여 작업내용을 확인하고 대조한다. 라싱작업원에 대한 안전조치를 취하고 안전교육을 실시한다. 컨테이너인 경우 양화될 화물의 라싱콘과 라싱바 등을 제거하고 일반화물인 경우 라싱로프 등을 제거하도록 지시한다. 화물의 양화가 끝나고 다시 화물의 적화가 완료되면 적화된 화물을 라싱도구를 이용하여 고정작업을 하도록 작업자 등에게 지시한다. 화물 양화 시 라싱도구들이 완전히 제거되었는지 그리고 선적화물의 고정작업이 완료되었는지 확인한다. 작업이 끝나면 작업원의 하선을 확인한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"감독","workFunc3":"관련없음","similarNm":"쇼링작업관리원, 고박작업관리원, 라이싱작업관리원","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H501/H502","dJobICdNm":"[H501]해상 운송업 / [H502]내륙 수상 및 항만 내 운송업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002510:1', '{"dJobCd":"K000002510","dJobCdSeq":"1","dJobNm":"바이오물류운영원","workSum":"임상용 샘플(혈액 및 기타 전염성 물질을 포함), 의약품원료, 완제의약품, 이식용 생채조직, 검체(혈액, 수액, 흉수, 복수, 관절액, 농(膿), 분비액, 담, 인두점액, 요(尿), 담즙 등), 기타 임상용 물품 및 임상소모품 등을 수거 및 배송하는 업무를 수행한다.","doWork":"바이오물류 고객(병원, 의학연구소, 의학실험실, 제약회사, 임상시험센터 등)과 면담하여 물류계약을 체결한다. 이송할 물품의 종류, 수량, 중량, 부피, 포장방법, 유지할 온도, 이동거리, 지역, 국가, 발송인, 수취인, 물류횟수, 이동 중 약품투약, 포장파손 시 조치방법 등을 파악한다. 운송계획을 수립하고 이동경로와 일정을 관리한다. 각 운송에 필요한 국가별 인허가 및 서류업무를 처리한다. 물품종류에 따라 냉동, 냉장, 극저온냉동, 액체질소포장, 드라이아이스포장 등의 적절한 포장재(용기)를 선택한다. 고객에게 포장용기를 제공하고 포장방법을 안내하기도 한다. 운송 중 온도를 모니터링하며 필요시 냉매를 보충하기도 한다. 물품이 이동하는 국가별로 통관 및 검역관련 업무를 지원한다. 물품의 접수, 보관, 불출 등 모든 이동데이터를 기록하고 온라인시스템에 입력한다. 물류과정에서 항공기 결항, 자연재해, 물류지연, 포장파손 등의 사고가 발생하면 고객에게 연락하고 물류조직의 지원을 요청하여 문제를 해결한다. 반송물품을 배송하거나 경우에 따라서 적법하게 파기하는 조치를 취하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"언어력|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"수동조작","dJobECd":"0282","dJobECdNm":"[0282]운송 사무원","dJobJCd":"3126","dJobJCdNm":"[3126]운송 사무원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;