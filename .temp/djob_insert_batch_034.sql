INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002693:1', '{"dJobCd":"K000002693","dJobCdSeq":"1","dJobNm":"매표원","workSum":"극장, 고궁, 유원지, 경기장 등을 이용하는 고객에게 입장권을 판매한다.","doWork":"이용정원이나 예약상황을 검토한다. 고객의 요구에 따라 매표수를 확인하고 시간이나 좌석번호 등을 표에 기록하거나 단말기로 입력하여 출력 및 판매한다. 대금을 받고 거스름돈을 계산하여 지급한다. 담당 업무시간 내에 발생한 매표내역을 정산하여 탑승 및 입장률을 계산한다. 판매대금을 정산하고, 책임자 및 관련 부서에 보고한다. 전화예매를 받기도 하며, 고객의 질문에 응대하기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"시범후 30일 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"계산","workFunc2":"서비스제공","workFunc3":"관련없음","similarNm":"입장권판매원","connectJob":"담당 분야에 따라 경기장입장권판매원, 고궁입장권판매원, 극장표매표원","dJobECd":"6162","dJobECdNm":"[6162]매표원 및 복권 판매원","dJobJCd":"5213","dJobJCdNm":"[5213]매표원 및 복권 판매원","dJobICd":"N752","dJobICdNm":"[N752]여행사 및 기타 여행보조 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004730:1', '{"dJobCd":"K000004730","dJobCdSeq":"1","dJobNm":"상품권판매대행사무원","workSum":"영업점에서 복권, 고속도로카드, 문화상품권을 비롯한 각종 상품권의 판매를 대행하는 업무를 한다.","doWork":"문화상품권을 비롯한 각종 상품권의 판매를 대행하고 회수상품권을 처리한다. 잔량을 확인하고 정사표(구분하여 분류한 표)를 결재하며 재고를 관리한다. 복권의 판매대행 업무 및 당첨자에 대한 당첨금 지급대행 업무를 수행하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"시범후 30일 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"관련없음","similarNm":"상품권판매원","connectJob":"복권판매원","dJobECd":"6162","dJobECdNm":"[6162]매표원 및 복권 판매원","dJobJCd":"5213","dJobJCdNm":"[5213]매표원 및 복권 판매원","dJobICd":"N759","dJobICdNm":"[N759]기타 사업지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005198:1', '{"dJobCd":"K000005198","dJobCdSeq":"1","dJobNm":"운송매표원","workSum":"버스, 여객선 등의 좌석 여부를 확인하여 승객에게 승차권을 발매한다.","doWork":"버스, 유람선 등의 매표소에서 고객이 원하는 행선지, 시간, 승차권 매수 및 좌석 등을 조회하여 고객에게 좌석 유무를 답변한다. 고객의 질문에 응대하고, 정보 및 사고와 관련하여 안내한다. 승차권을 발권하고 매표대금을 계산한다. 당일 매표현황을 집계하여 집계내용 및 금액을 매표관리부서에 전달한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"시범후 30일 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"계산","workFunc2":"서비스제공","workFunc3":"관련없음","connectJob":"운송수단에 따라 버스매표원, 유람선매표원, 여객선매표원, 케이블카매표원, 기차표판매원","dJobECd":"6162","dJobECdNm":"[6162]매표원 및 복권 판매원","dJobJCd":"5213","dJobJCdNm":"[5213]매표원 및 복권 판매원","dJobICd":"H529/R912","dJobICdNm":"[H529]기타 운송관련 서비스업 / [R912]유원지 및 기타 오락관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003660:1', '{"dJobCd":"K000003660","dJobCdSeq":"1","dJobNm":"항공권예약발권사무원","workSum":"항공권을 구입하거나 발권하고자 하는 승객에게 항공권을 예약·발권한다.","doWork":"항공권을 구입하거나 발권, 재발권, 예약하고자 하는 승객을 위해 목적지, 항공기의 운항상황, 탑승시간, 좌석등급 등을 조회하여 발권 가능 여부를 알려준다. 요금을 계산하고 항공권을 발급한다. 항공권 시간 변경이나 기한연장, 노선변경 등에 대한 문의에 응대하고 요청사항을 처리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"계산","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"항공권발권사무원","dJobECd":"6162","dJobECdNm":"[6162]매표원 및 복권 판매원","dJobJCd":"5213","dJobJCdNm":"[5213]매표원 및 복권 판매원","dJobICd":"H511","dJobICdNm":"[H511]항공 여객 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001880:1', '{"dJobCd":"K000001880","dJobCdSeq":"1","dJobNm":"계산대수납원","workSum":"슈퍼 및 상점 등에서 현금등록기를 이용하여 판매 대금을 계산한다.","doWork":"현금등록기(출납기)에 거스름돈을 위한 준비금액을 확인한다. 고객이 구입한 상품의 수량과 금액을 바코드 스캐너를 사용하여 계산·기록한다. 바코드가 표시되지 않은 상품의 경우 상품코드를 찾아 계산한다. 고객에게 계산금액을 알리고 현금 및 카드로 상품금액을 받는다. 각종 프로모션(할인카드, 포인트카드, 상품권, 모바일상품권 등) 관련 계산을 한다. 고객에게 영수증을 출력해준다. 판매금액을 정산하고 업무를 종료한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"시범후 30일 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"계산","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"계산원, 카운터(Counter), 캐셔(Cashier)","connectJob":"매장계산원, 매장수납원, 마트계산원, 마트수납원, 매장텔러","dJobECd":"6161","dJobECdNm":"[6161]매장 계산원 및 요금 정산원","dJobJCd":"5214","dJobJCdNm":"[5214]매장 계산원 및 요금 정산원","dJobICd":"G471","dJobICdNm":"[G471]종합 소매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002439:1', '{"dJobCd":"K000002439","dJobCdSeq":"1","dJobNm":"주차요금정산원","workSum":"주차장 주차요금을 징수한다.","doWork":"차량 출차 시 주차장 출구 정산소에서 고객으로부터 주차권을 받아 주차료를 정산한다. 고객으로부터 주차료를 받고 거스름돈과 영수증을 지급한다. 출입통제시설(차단기)을 작동하여 차량의 출차를 돕는다. 담당 업무시간 내 발생한 매출액을 정산하고, 이를 책임자에게 보고한다. 주차정기권을 판매하기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"시범후 30일 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"계산","workFunc2":"서비스제공","workFunc3":"관련없음","dJobECd":"6161","dJobECdNm":"[6161]매장 계산원 및 요금 정산원","dJobJCd":"5214","dJobJCdNm":"[5214]매장 계산원 및 요금 정산원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005605:1', '{"dJobCd":"K000005605","dJobCdSeq":"1","dJobNm":"차량통행료징수원","workSum":"유료로 운영되는 고속도로, 터널, 교량 등의 차량통행요금을 징수한다.","doWork":"통행료 징수방식에 따라 진입차량에 차종별, 행선지별로 요금을 받고 통행권을 발행하거나, 진출차량의 통행권을 회수하여 이용거리에 따른 통행료를 징수한다. 부정운행차량을 단속하고 계도한다. 도로진입 차량 대수를 확인하여 차량진입로를 넓히거나 좁힌다. 유로통행터널의 진입구에 투입하는 동전을 관리하며, 동전교환업무를 수행하기도 한다. 적재중량을 초과한 차량의 도로진입을 통제하기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"시범후 30일 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"대기환경미흡|소음·진동|","workFunc1":"계산","workFunc2":"서비스제공","workFunc3":"관련없음","similarNm":"톨게이트정산원, 통행료정산원, 통행료징수원, 톨비정산원","dJobECd":"6161","dJobECdNm":"[6161]매장 계산원 및 요금 정산원","dJobJCd":"5214","dJobJCdNm":"[5214]매장 계산원 및 요금 정산원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006228:1', '{"dJobCd":"K000006228","dJobCdSeq":"1","dJobNm":"통신요금미납관리원","workSum":"고객의 통신요금 연체를 안내하여 납부를 유도하고 이용정지, 계약해지 등 통신요금미납자 관리를 한다.","doWork":"체납자의 전화응대를 한다. 체납사항에 대한 확인을 한다. 전산 파일에서 체납자 리스트를 만들어 전화를 걸어 납부를 독촉한다. 체납, 이용정지, 직권해지에 관한 안내문건을 발송한다. 체납안내프로그램에 등록하여 이용정지를 안내하고 연체가 일정기간 이상 계속될 경우 이용정지를 운용시스템에 입력한다. 이용정지 후 연체가 지속되면 의견진술을 하여 직권해지를 한다. 직권해지 후 부실채권에 대한 납입을 독촉하고 신용평가회사에 이관한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"관련없음","dJobECd":"6161","dJobECdNm":"[6161]매장 계산원 및 요금 정산원","dJobJCd":"5214","dJobJCdNm":"[5214]매장 계산원 및 요금 정산원","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005042:1', '{"dJobCd":"K000005042","dJobCdSeq":"1","dJobNm":"리스사무원","workSum":"기업에 설비자금을 대여하기 위하여 리스(Lease)에 대한 상담, 심사, 계약을 하고 리스물건의 조달을 설비제조업체에 의뢰하는 업무를 수행한다.","doWork":"전화, 방문을 통해 고객으로부터 자동차, 의료기기, 항공기, 일반설비 등의 리스(Lease) 주문을 받는다. 잠재 수요 개발을 위해 마케팅을 한다. 단기리스, 장기리스 , 총리스, 순리스, 메인티넌스리스(판매, 보수, 관리를 포함한 리스), 전대리스(轉貸리스:Sublease)등의 리스 형태에 따라 고객과 상담한다. 설비리스의 경우 해당 기업의 신용도를 검토하고 적격업체 여부를 심사한다. 적격업체 자격심사 승인 후 기업이 설비의 종류, 규격, 가격 등을 결정한 후 공개입찰 시 리스조건을 결정하여 입찰에 응한다. 기업의 담보비율에 의한 신용도와 리스물건의 조달기간을 고려하여 리스조건을 조정하고 계약한다. 설비제조회사에 리스물건을 발주하고, 물건이 수요자에게 인도되기 전에 리스 자사표지를 부착하고 사진을 촬영하는 검수를 한다. 물적담보, 신용보증서, 보증보험 등 수요자의 근저당 설정담보를 확보하여 직접 보관하거나 보증기관에 보관을 의뢰한다. 수요자가 제3자에게 설비의 사용권을 승계할 경우 관련 서류를 변경, 작성한다. 수요자의 재정 및 영업상태를 점검한다. 국내 산업동향 등 리스에 관련된 정보를 조사·수집한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"협의","workFunc3":"관련없음","connectJob":"리스를 이용하여 기계설비를 수출하거나 해외현지법인에서 리스사무를 할 경우 국제리스사무원, 리스물건의 금액에 따라 소액리스사무원","dJobECd":"6154","dJobECdNm":"[6154]상품 대여원","dJobJCd":"5220","dJobJCdNm":"[5220]상품 대여원","dJobICd":"N763","dJobICdNm":"[N763]산업용 기계 및 장비 임대업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006875:1', '{"dJobCd":"K000006875","dJobCdSeq":"1","dJobNm":"영상물대여원","workSum":"도서 및 비디오물을 고객에게 대여한다.","doWork":"도서 및 비디오물의 관련 자료를 수집하고, 수요를 파악하여 구입한다. 장르별, 등급별, 대여순위 등으로 진열장에 정리한다. 고객이 원하는 도서와 비디오물을 진열장에서 찾아주거나 안내한다. 상품의 내용, 인기순위 등의 정보를 제공하여 선택을 돕는다. 대여 상품명, 고객명, 연락처, 대여일 등을 장부나 컴퓨터에 기록한다. 수시로 수거함을 확인하여 반납물품을 수거 및 정리한다. 보유 상품의 목록을 작성·정리하고, 없는 품목을 점검한다. 수시로 대여 상황 및 연체 목록을 점검하며, 연체 고객에게는 반납을 독촉한다. 진열장의 상태를 수시로 확인하여 정리하고, 먼지를 제거하는 등 청결을 유지한다. 신규고객의 방문 시 주소, 성명 등의 고객정보를 장부나 컴퓨터에 입력하여 관리한다. 고객의 요청에 따라 도서 및 비디오물을 배달하기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"시범후 30일 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"단순작업","connectJob":"도서대여원, 비디오물대여원, 의류대여원, 개인용품대여원, 가정용품대여원, 가전제품대여원, 정수기대여원, 비데대여원","dJobECd":"6154","dJobECdNm":"[6154]상품 대여원","dJobJCd":"5220","dJobJCdNm":"[5220]상품 대여원","dJobICd":"N762","dJobICdNm":"[N762]개인 및 가정용품 임대업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001955:1', '{"dJobCd":"K000001955","dJobCdSeq":"1","dJobNm":"오락장비대여원","workSum":"유원지, 공원, 해수욕장, 수영장, 스케이트장, 볼링장, 스키장 등에서 고객에게 놀이용 장비와 비품을 대여한다.","doWork":"고객이 선택하거나 고객의 신장, 몸무게에 적합한 장비와 비품을 제공한다. 고객에게 영수증 또는 번호표를 지급하고 관리한다. 장비와 비품을 크기나 종류별로 구분하여 보관하고 수량을 기록한다. 손상된 장비와 비품을 보수하거나 새로 구입하도록 의뢰한다. 고객에게 장비의 사용법을 설명하기도 한다. 고객의 물품을 보관하기도 한다. 장비나 비품을 판매하기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"시범후 30일 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"단순작업","connectJob":"보트대여원, 볼링화대여원, 스케이트대여원, 스키대여원, 자전거대여원, 탈의실관리원, 해수욕용품대여원, 장난감대여원","dJobECd":"6154","dJobECdNm":"[6154]상품 대여원","dJobJCd":"5220","dJobJCdNm":"[5220]상품 대여원","dJobICd":"N762","dJobICdNm":"[N762]개인 및 가정용품 임대업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006986:1', '{"dJobCd":"K000006986","dJobCdSeq":"1","dJobNm":"차량임대사무원","workSum":"승용차, 버스 및 기타 차량의 임대를 원하는 고객에게 차량을 소개하고 임대계약을 체결한다.","doWork":"전화, 또는 인터넷상에서 차량예약을 관리한다. 차량 임대에 대한 고객의 방문 또는 전화문의에 응대한다. 방문한 고객의 운전면허증을 확인하고 인적사항을 기재한다. 차종별 임대료, 차종 등을 소개하고 임대일정을 상담한다. 임대차량의 종류, 일정, 임대조건이 포함된 계약서를 전산입력하고 출력하고 서명을 받는다. 차량의 외관상태를 확인한 후 차량열쇠를 전달한다. 고객이 원할 경우 운전기사를 소개하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"설득","workFunc3":"관련없음","similarNm":"임대차량계약원, 렌터카임대사무원, 자동차대여원, 렌터카담당원","connectJob":"승용차임대사무원, 버스임대사무원, 화물자동차임대사무원, 항공기임대사무원, 선박임대사무원, 모터사이클임대사무원, 컨테이너임대사무원, 중장비대여원, 농업용기계대여원","dJobECd":"6154","dJobECdNm":"[6154]상품 대여원","dJobJCd":"5220","dJobJCdNm":"[5220]상품 대여원","dJobICd":"N761","dJobICdNm":"[N761]운송장비 임대업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003819:1', '{"dJobCd":"K000003819","dJobCdSeq":"1","dJobNm":"통신기기개통사무원","workSum":"통신기기 판매대리점에서 통신기기 개통과 요금수납 업무를 한다.","doWork":"고객에게 가입신청서 작성을 요청한다. 가입신청서 작성에 대하여 조언한다. 작성된 가입신청서를 검토하여 미비점을 재작성하거나 요청한다. 가입신청서 내용을 토대로 전산에 입력한다. 고객이 원하는 전화번호를 발급한다. 통신기기 사용액에 대한 수납을 대행한다. 기타 관련 사무업무를 수행한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"서비스제공","workFunc3":"제어조작","dJobECd":"6152","dJobECdNm":"[6152]통신 기기·서비스 판매원","dJobJCd":"5311","dJobJCdNm":"[5311]단말기 및 통신 서비스 판매원","dJobICd":"G473","dJobICdNm":"[G473]가전제품 및 정보통신장비 소매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002086:1', '{"dJobCd":"K000002086","dJobCdSeq":"1","dJobNm":"통신기기판매원","workSum":"통신기기를 소비자에게 판매한다.","doWork":"유·무선 전화기, 휴대용 전화기, 팩스 등을 제조사로부터 구입하여 소비자에게 판매한다. 소비자가 원하는 물품을 파악하여 구매하는 데에 도움을 준다. 재고량을 확인하고 수요가 많은 물품을 파악하여 주문·구입한다. 전화기에 관련된 물품을 판매하기도 한다. 제품별 특성에 관한 지식을 갖추어 소비자의 구매에 도움을 준다. 납품된 물품을 진열장에 진열한다. 휴대용 전화기의 경우 이동통신사를 대행하여 가입신청이나 해지 등 관련 업무를 대신한다. 가입신청서와 첨부서류를 확인하고 이동통신사에 팩스로 송신한다. 사용료 납부를 대행하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"설득","workFunc3":"단순작업","connectJob":"핸드폰가입서비스판매원, 인터넷가입서비스판매원, 휴대폰(스마트폰)판매원, IPTV서비스판매원","dJobECd":"6152","dJobECdNm":"[6152]통신 기기·서비스 판매원","dJobJCd":"5311","dJobJCdNm":"[5311]단말기 및 통신 서비스 판매원","dJobICd":"G473","dJobICdNm":"[G473]가전제품 및 정보통신장비 소매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006507:1', '{"dJobCd":"K000006507","dJobCdSeq":"1","dJobNm":"인터넷쇼핑몰운영자","workSum":"인터넷쇼핑몰의 운영, 마케팅, 고객관리 등의 전반적인 업무를 관리한다.","doWork":"시장조사를 통해 고객의 요구사항을 분석한다. 상품들을 결정하고 섭외한다. 상품의 가격을 결정한다. 준비된 상품들을 고객들이 구매할 수 있도록 사이트에 올리고 홍보한다. 등록된 상품정보를 수시로 점검·수정한다. 판매된 상품을 고객에게 배송한다. 게시판이나 이메일, 전화로 접수된 문의사항에 대하여 답변을 제공한다. 불량이거나 반송된 상품을 환불·교환해준다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"유지","similarNm":"몰마스터, 인터넷쇼핑몰판매원, 인터넷쇼핑몰관리인","connectJob":"온라인쇼핑몰판매원, 전자상거래판매원, 통신판매원","certLic":"전자상거래관리사, 전자상거래운용사","dJobECd":"6153","dJobECdNm":"[6153]온라인 판매원","dJobJCd":"5312","dJobJCdNm":"[5312]온라인 쇼핑 판매원","dJobICd":"G479","dJobICdNm":"[G479]무점포 소매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007451:1', '{"dJobCd":"K000007451","dJobCdSeq":"1","dJobNm":"텔레마케터","workSum":"전화나 컴퓨터를 이용하여 상품이나 서비스를 홍보하고 판매한다.","doWork":"판매하려는 상품이나 서비스에 대한 지식과 상담기법을 습득한다. 컴퓨터나 전화번호부를 이용하여 대상 소비자 리스트를 작성한다. 소비자들에게 전화나 이메일을 이용하여 상품 및 서비스에 대한 장점과 효과를 설명한다. 제품이나 서비스 구매를 원하는 소비자의 구매요구를 접수한다. 기간별 판매현황을 작성하고 소비자 불만 사항을 기록하여 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"설득","workFunc3":"관련없음","similarNm":"통신판매원, TM","connectJob":"업무형태에 따라, 고객의 문의나 상담에 응대하는 인바운드(In-bound)텔레마케터, 고객에게 직접 전화를 걸어 각종 제품판매, 통신서비스 가입 등을 권유하고 정보를 제공하는 아웃바운드(Out-bound)텔레마케터로 구분/콜센터텔레마케터, 학원텔레마케터, 학습지텔레마케터, 유학텔레마케터, 금융텔레마케터, 보험텔레마케터, 대출텔레마케터, 부동산텔레마케터, 쇼핑몰텔레마케터, 백화점텔레마케터, 마트텔레마케터, 인터넷텔레마케터, 통신텔레마케터","certLic":"텔레마케팅관리사","dJobECd":"6130","dJobECdNm":"[6130]텔레마케터","dJobJCd":"5313","dJobJCdNm":"[5313]텔레마케터","dJobICd":"N759","dJobICdNm":"[N759]기타 사업지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007513:1', '{"dJobCd":"K000007513","dJobCdSeq":"1","dJobNm":"방문판매원","workSum":"기업체에 소속되거나 혹은 개인적으로 소비자의 집을 방문하여 제품을 판매한다.","doWork":"신문이나 기업체정보, 각종 인명자료를 조사 및 정리하여 판매소비자를 선정한다. 선정된 소비자를 직접 방문하여 제품의 견본이나 설명서 등을 사용하여 판매할 품목을 설명한다. 가격과 거래조건을 협의하여 판매계약서를 작성한다. 제품의 생산이나 필요시기를 확인하여 납품일자를 결정한다. 판매한 제품에 대한 판매일지를 작성한다. 일정 기간 동안의 애프터서비스 관련 업무를 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"설득","workFunc3":"단순작업","connectJob":"다단계판매원, 판매외무원, 화장품방문판매원, 정수기방문판매원, 방문아동도서판매원, 방문아동교구판매원","dJobECd":"6156","dJobECdNm":"[6156]방문 판매원","dJobJCd":"5321","dJobJCdNm":"[5321]방문 판매원","dJobICd":"G479","dJobICdNm":"[G479]무점포 소매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006716:1', '{"dJobCd":"K000006716","dJobCdSeq":"1","dJobNm":"노점판매원","workSum":"정해진 상점 없이 노상에서 청과류, 잡화, 간식 등을 진열하고 판매한다.","doWork":"판매할 물품을 결정하여 도매 또는 직거래를 통하여 물품을 구매한다. 판매하고자 하는 물품의 성격을 파악하고 소비자의 수요가 많은 지역을 결정하고 관련 기관의 허가를 받는다. 지정된 장소에 물품을 진열하거나 포장하여 소비자의 수요를 돕는다. 부패의 가능성이 있는 생선류 및 손상이 쉽게 되는 청과류는 신선도를 유지하기 위한 설비를 갖춘 이동수단(차량, 손수레)을 이용하여 직접 소비자에게 판매하거나 배달한다. 계절에 따라 판매 물품을 변경하여 판매하기도 하며 행사장소나 공원 등지에서 물품 판매를 하기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"약간의 시범정도","workStrong":"가벼운 작업","workPlace":"실외","workFunc1":"비교","workFunc2":"설득","workFunc3":"관련없음","similarNm":"노점상","connectJob":"신문가두판매원, 노점생선판매원, 노점채소판매원, 이동판매원, 열차객실판매원, 열차판매원, 노점차량판매원","dJobECd":"6155","dJobECdNm":"[6155]노점 및 이동 판매원","dJobJCd":"5322","dJobJCdNm":"[5322]노점 및 이동 판매원","dJobICd":"G479","dJobICdNm":"[G479]무점포 소매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005759:1', '{"dJobCd":"K000005759","dJobCdSeq":"1","dJobNm":"가두헌혈권장원","workSum":"길거리나 광장 등에서 행인에게 헌혈을 권장한다.","doWork":"헌혈업무 및 대인관계예절에 대해 교육을 받는다. 체혈팀장으로부터 그 날의 헌혈 장소, 대상 및 홍보 시 주의사항 등을 듣고 숙지한다. 현장에 도착해서 사람들이 가장 많이 지나다니거나 주의를 환기시킬 수 있는 장소를 선정하여 자리를 잡는다. 지나가는 행인들에게 헌혈을 권장한다. 헌혈을 희망하는 대상자를 체혈장소로 데리고 와서 체혈 담당 간호사에게 인계한다. 하루의 헌혈권장 업무가 끝난 후 체혈팀장에게 헌혈권장 과정에서 발생한 문제점을 보고한다. 군부대 및 단체를 대상으로 한 헌혈이 이루어지는 경우 헌혈대상자에게 지급되는 급·배식을 보조하기도 한다. 고정된 헌혈장소인 헌혈카페 인근에서 헌혈을 권장하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"시범후 30일 이하","workStrong":"가벼운 작업","workPlace":"실외","workFunc1":"관련없음","workFunc2":"설득","workFunc3":"관련없음","dJobECd":"6171","dJobECdNm":"[6171]홍보 도우미 및 판촉원","dJobJCd":"5323","dJobJCdNm":"[5323]홍보 도우미 및 판촉원","dJobICd":"Q869","dJobICdNm":"[Q869]기타 보건업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004987:1', '{"dJobCd":"K000004987","dJobCdSeq":"1","dJobNm":"내레이터모델","workSum":"전시회, 판촉행사, 신제품설명회, 박람회, 경기장 및 국제회의 등 행사장에서 행사진행에 필요한 서비스를 하거나 상품이나 기업 설명을 한다.","doWork":"걸음걸이(Walking), 화장술(Make-up), 자세(Pose), 화법(내레이션기술), 사진촬영자세, 문장인용 및 문장작성 등 행사의 진행도움에 필요한 다양한 교육을 사전에 받는다. 행사도우미관리자의 지시사항에 따라 진행내용을 숙지한다. 행사에 필요한 유니폼 및 장식물을 받아 전시회, 판촉행사, 신제품 설명회 등 각종 행사모임에서 상품, 기업 및 행사주최 측의 이미지 등을 설명한다. 식순에 따라 행사참석자를 안내하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"서비스제공","workFunc3":"관련없음","similarNm":"나레이터모델, 행사도우미, 안내모델","connectJob":"상품홍보원, 의전도우미, 엑스포도우미, 캠페니언","dJobECd":"6171","dJobECdNm":"[6171]홍보 도우미 및 판촉원","dJobJCd":"5323","dJobJCdNm":"[5323]홍보 도우미 및 판촉원","dJobICd":"N759","dJobICdNm":"[N759]기타 사업지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004053:1', '{"dJobCd":"K000004053","dJobCdSeq":"1","dJobNm":"레이싱모델","workSum":"전속계약을 맺은 레이싱팀이나 후원업체의 홍보를 위해 사진촬영에 응하고, 소속팀의 선수를 응원한다.","doWork":"레이싱경기장에서 후원업체나 소속 레이싱팀의 로고가 새겨진 레이싱복을 입고 사진촬영에 응한다. 혼자 또는 차량과 함께 사진기자 및 관람객에게 포즈를 취한다. 차량 옆에 서서 포즈를 취한 채 레이서와 함께 사진촬영을 한다. 경기 직전 경주로에 나가 표지판을 들어 경기시작 시간을 알린다. 소속팀의 홍보부스에서 관람객이나 사진기자의 촬영에 응한다. 시상식에서 꽃다발을 전달하거나 함께 사진촬영을 한다. 신차발표회나 모터쇼 등의 자동차 관련 행사에서 활동하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"비교","workFunc2":"오락제공","workFunc3":"관련없음","similarNm":"레이싱걸","dJobECd":"6171","dJobECdNm":"[6171]홍보 도우미 및 판촉원","dJobJCd":"5323","dJobJCdNm":"[5323]홍보 도우미 및 판촉원","dJobICd":"N759","dJobICdNm":"[N759]기타 사업지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001739:1', '{"dJobCd":"K000001739","dJobCdSeq":"1","dJobNm":"헌혈홍보원","workSum":"개인 및 단체를 상대로 헌혈을 홍보·권장한다.","doWork":"가능성 있는 개인이나 단체를 방문하여 헌혈계획을 알리고 헌혈을 권장한다. 헌혈을 유도하기 위하여 유인물, 해설책자 등 각종 홍보물을 배포하고 홍보용 영화 또는 비디오를 상영한다. 헌혈계획 및 권장활동에 관한 보고서를 작성한다. 혈액원 헌혈자기록에서 희귀혈액형 보유자를 찾아내어 헌혈을 권장하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"기록","workFunc2":"설득","workFunc3":"단순작업","dJobECd":"6171","dJobECdNm":"[6171]홍보 도우미 및 판촉원","dJobJCd":"5323","dJobJCdNm":"[5323]홍보 도우미 및 판촉원","dJobICd":"Q869","dJobICdNm":"[Q869]기타 보건업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005444:1', '{"dJobCd":"K000005444","dJobCdSeq":"1","dJobNm":"홍보판촉원","workSum":"소비자와 면대면으로 기업의 상품이나 서비스를 홍보하고 판매를 촉진하는 활동을 한다.","doWork":"홍보할 상품 또는 서비스에 대한 내용을 사전에 숙지한다. 거리, 상점 또는 각종 행사장에서 해당 기업의 상품을 홍보하기 위해 소비자에게 직접 제품이나 서비스를 설명한다. 고객 앞에서 제품을 시연하거나 시음하도록 유도한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"약간의 시범정도","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"관련없음","workFunc2":"서비스제공","workFunc3":"관련없음","connectJob":"제품홍보원, 서비스홍보원, 홍보프로모터, 백화점판촉원, 할인점판촉원, 마트판촉원, 시식판촉원, 시음판촉원, 순회판촉원, 특판판촉원, 주부판촉원","dJobECd":"6171","dJobECdNm":"[6171]홍보 도우미 및 판촉원","dJobJCd":"5323","dJobJCdNm":"[5323]홍보 도우미 및 판촉원","dJobICd":"M713","dJobICdNm":"[M713]광고업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007484:1', '{"dJobCd":"K000007484","dJobCdSeq":"1","dJobNm":"곡식작물재배원","workSum":"개인 또는 대단위 논에서 벼농사용 농기구를 사용하거나 농기계를 운전하여 땅을 갈고, 정지하여 씨를 뿌리고, 시비, 중경제초, 약제살포, 수확, 탈곡 등의 일을 한다.","doWork":"농기구를 사용하거나 경운기, 트랙터를 운전하여 논을 갈고, 고른다. 씨를 준비하여 소독하고 발아시키기 위하여 물에 일정 기간 담가둔다. 씨를 준비된 모판에 뿌리거나 흙으로 덮어준다. 모가 자라면 모판을 분리하여 이양기로 모를 심는다. 작물의 생육상태에 따라 물을 조정한다. 작물의 성장을 관찰하고 병충해 예방이 필요하면 약제를 살포하여 병충해를 방제한다. 콤바인이나 낫을 이용하여 작물을 수확한다. 수확된 벼를 일정 함수율(含水率:재료에 포함된 수분량의 비율을 재료의 질량을 기준으로 나타낸 백분율)까지 건조시켜 가마니 또는 규격용기에 넣어 포장하고 저장한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"힘든 작업","workPlace":"실외","physicalAct":"웅크림|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"식량작물생산종사원, 농부","connectJob":"미곡작물재배원, 맥작물재배원, 잡곡작물재배원, 두작물배재원, 친환경작물재배원","dJobECd":"9011","dJobECdNm":"[9011]곡식작물 재배원","dJobJCd":"6111","dJobJCdNm":"[6111]곡식작물 재배원","dJobICd":"A011","dJobICdNm":"[A011]작물 재배업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007256:1', '{"dJobCd":"K000007256","dJobCdSeq":"1","dJobNm":"유기재배원","workSum":"유기재배종사자의 관리·감독을 받아 생육관리, 토양 관리, 잡초관리, 병해·충해관리, 수확관리를 하고, 영농일지를 작성하여 보고하는 일을 수행한다.","doWork":"작물 파종·정식 전에 토양 상태에 따라 유기재배에서 사용 가능한 밑거름을 정해진 양만큼 사용한다. 화학 제초제를 사용하지 않고 물리적 방법 및 생태적 원리에 따라 잡초를 관리한다. 발생 가능한 병해·충해를 사전 예방하고, 발병한 병해·충해에 대해 적절한 진단과 방제를 수행한다. 수확한 유기농산물을 일반 농산물과 구분하여 저장하고, 일반 농산물과의 혼입 방지를 위해 표시하여 구분한다. 품목별로 적정 온도에서 저장·관리하며, 유기농산물의 품질 유지를 위하여 허용물질을 사용한다. 유기농산물 특성에 따라 농산물을 선별하고, 유기농산물 유통 형태 및 포장 방법별로 인증품 표시기준에 맞는 인증 표시를 한다. 영농일지 양식에 따라 재배포장의 재배 사항과 농자재 사용 내용을 기록하며, 농산물의 생산량 및 출하처별 판매량과 유기농업자재 등의 구매, 사용, 보관에 관한 사항을 기록한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"힘든 작업","workPlace":"실외","physicalAct":"웅크림|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"농부","certLic":"유기농업기능사","dJobECd":"9011","dJobECdNm":"[9011]곡식작물 재배원","dJobJCd":"6111","dJobJCdNm":"[6111]곡식작물 재배원","dJobICd":"A011","dJobICdNm":"[A011]작물 재배업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005540:1', '{"dJobCd":"K000005540","dJobCdSeq":"1","dJobNm":"버섯검사원","workSum":"버섯의 상품가치나 종류에 따라 분류하고 검사한다.","doWork":"재배한 버섯이나 산림에서 채취한 버섯을 종류별로 분류한다. 분류된 버섯의 이물질을 제거하며 버섯갓의 직경 및 두께, 크기, 건조상태, 빛깔, 비중 등에 따라 버섯을 선별하고 등급을 결정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"수동조작","connectJob":"느타리버섯검사원, 목이버섯검사원, 양송이버섯검사원, 표고버섯검사원","dJobECd":"9012","dJobECdNm":"[9012]채소·특용작물 재배원","dJobJCd":"6112","dJobJCdNm":"[6112]채소 및 특용작물 재배원","dJobICd":"A011","dJobICdNm":"[A011]작물 재배업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007278:1', '{"dJobCd":"K000007278","dJobCdSeq":"1","dJobNm":"버섯유통원","workSum":"버섯의 상품가치와 종류에 따라 분류하고 검사하여 유통한다.","doWork":"재배한 버섯이나 산림에서 채취한 버섯을 종류와 보관방법에 따라 분류한다. 분류된 버섯의 이물질을 제거하며 버섯갓의 직경 및 두께, 크기, 건조상태, 빛깔, 비중 등에 따라 버섯을 선별하고 등급을 결정한다. 분류된 버섯의 인증(유기농, 무농약 등)사항, 재배이력 및 원산지의 정보를 점검하며, 냉장으로 저장 또는 유통한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"손사용|시각|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"버섯경매사, 버섯유통업자","connectJob":"신선식품유통업자","certLic":"유기농업기능사, 유기농업기사, 유통관리사","dJobECd":"9012","dJobECdNm":"[9012]채소·특용작물 재배원","dJobJCd":"6112","dJobJCdNm":"[6112]채소 및 특용작물 재배원","dJobICd":"A011","dJobICdNm":"[A011]작물 재배업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005236:1', '{"dJobCd":"K000005236","dJobCdSeq":"1","dJobNm":"버섯재배자","workSum":"버섯을 재배하기 위하여 나무 또는 톱밥배지에 종균을 접종 및 배양으로 적정 재배환경조건을 조절하고 버섯을 생산하고 수확한다.","doWork":"재배하고자 하는 버섯의 종류에 따라 원목, 톱밥배지, 퇴비를 구입한다. 버섯 종균의 발육이 용이한 적정 함수율을 갖도록 원목을 음지에서 건조시킨다. 원목재배는 나무의 규격을 정하고 지역 특성에 알맞은 종균을 확보하며 전기드릴 등을 사용하여 원목에 구멍을 뚫고 종균을 구멍 속에 넣어 접종하여 관리한다. 원목재배는 버섯나무를 일정 기간 눕히거나 세우는 일정을 정하여 시행하고 배양상태를 파악한다. 톱밥재배는 재배할 버섯종류에 따라 적합한 톱밥의 구입, 미강, 밀기울의 영양원 구입한다. 톱밥재배용 원재료를 적정한 수분공급으로 혼합, 입봉 또는 입병, 살균 및 냉각하고 적절한 버섯종균을 접종하여 일정기간 배양한다. 원목 및 톱밥재배시 균사의 성장을 촉진시키기 위하여 수시로 살수하여 적정한 수분관리를 한다. 재배자 여건에 따라 접종된 원목 또는 배양된 톱밥배지를 전문업체로부터 구입한다. 버섯재배 장소의 청결유지를 위한 에초작업 및 주변 청소와 잡균의 방제를 위하여 배양실, 재배실, 재배지 등을 소독한다. 버섯의 종류에 따라 적당한 방법에 맞추어 버섯을 수확한다. 채취한 버섯을 선별한다. 버섯의 수확시기를 확정하고, 버섯을 검사하고 판매를 관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"시각|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"원목재배자, 톱밥재배자","connectJob":"표고 원목재배자, 표고 톱밥재배자","certLic":"버섯종균기능사, 버섯산업기사, 종자관리사","dJobECd":"9012","dJobECdNm":"[9012]채소·특용작물 재배원","dJobJCd":"6112","dJobJCdNm":"[6112]채소 및 특용작물 재배원","dJobICd":"A011","dJobICdNm":"[A011]작물 재배업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001676:1', '{"dJobCd":"K000001676","dJobCdSeq":"1","dJobNm":"버섯종균제조원","workSum":"버섯을 재배하기 위한 종자인 버섯종균을 제조 및 생산하여 재배자에게 판매, 공급한다.","doWork":"버섯종균 종류에 따라 톱밥, 면실피, 미강 등 관련을 선택한다. 버섯종균에 사용되는 적정 원재료 선택, 구입과 적합한 배합비율로 혼합한다. 종균 제조용 원재료를 적정한 수분공급으로 혼합, 입봉 또는 입병과 살균 및 냉각하고 적절한 버섯종균을 접종하여 일정기간 배양한다. 종균용 톱밥배지의 충전도, 종균저장기간, 종균제조기간에 따라 배지의 수분함량을 조절한다. 초자병에 자동주입기를 사용하여 일정량의 배지를 넣고 산소공급을 원활하게 해주기 위하여 배지 중앙에 압봉으로 구멍을 뚫어 준다. 고압멸균기로 고온 처리하여 멸균시키고 급냉 시킨다. 살균된 배지에 잡균의 오염을 방지하기 위하여 알코올램프, 핀셋, 수갑, 마스크, 가운, 위생모 등을 착용하고 무균접종실에서 균사를 배지 중앙에 접종한다. 접종이 완료된 배지를 소독 처리된 항온실에서 잡균을 검사하고 균사를 발육시켜 종균을 생산한다. 선별된 종균을 일정크기의 박스에 담아 포장하고, 포장지에는 종자산업법에 제시한 품종명, 제배시 주의사항 등의 품질표시를 작성하여 출하한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"손사용|시각|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"감독","workFunc3":"조작운전","similarNm":"종자업자","connectJob":"버섯종균업자","certLic":"종자관리사, 버섯종균기능사, 버섯산업기사","dJobECd":"9012","dJobECdNm":"[9012]채소·특용작물 재배원","dJobJCd":"6112","dJobJCdNm":"[6112]채소 및 특용작물 재배원","dJobICd":"A011","dJobICdNm":"[A011]작물 재배업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004183:1', '{"dJobCd":"K000004183","dJobCdSeq":"1","dJobNm":"시설작물재배원","workSum":"온실 등의 작물재배 시설에서 채소류나 화훼류 등을 재배하기 위한 제반 작업을 한다.","doWork":"온실 등의 시설물에 공간을 배정하고 재배 계획을 짠다. 종자를 심고, 나무껍질이나 자갈, 모래, 흙 등의 재료에 묘목을 이식하여 종자와 묘목을 번식시킨다. 표준에 미달된 작물을 제거하기 위하여 작물의 배치 위치를 정한다. 영양과 형태를 조절하는 장치를 감시하여 습기, 환기, 이산화탄소의 상태를 조절하고, 제초제, 방부제, 살충제 등을 조제한다. 재료와 공급품을 구입하기 위하여 시설작물재배관리자와 협의한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|고온|다습|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"시설작물재배자","connectJob":"온실재배원, 양액재배원","dJobECd":"9012","dJobECdNm":"[9012]채소·특용작물 재배원","dJobJCd":"6112","dJobJCdNm":"[6112]채소 및 특용작물 재배원","dJobICd":"A011","dJobICdNm":"[A011]작물 재배업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007383:1', '{"dJobCd":"K000007383","dJobCdSeq":"1","dJobNm":"식물공장재배원","workSum":"식물공장에서 채소, 특용작물 등 작물체를 파종, 이식, 정식, 수확하는 업무를 수행한다.","doWork":"새싹보리 등의 새싹채소 및 유채, 배추, 콜라비 등 각종 채소류를 재배한다. 종자저장고에서 종자를 받아 종자를 세척한다. 세척한 종자를 물에 불리고 싹이 트면 자동재배기로 옮긴다. 자동재배기에서 새싹을 키우고 식물의 성장에 따라 더 넓은 재배판으로 재배식물을 옮긴다. 새싹채소의 색을 달리하기 위해 광원이 없는 재배베드에서 재배하기도 한다. 재배가 끝난 식물은 수확하여 세척한다. 세척을 마친 식물을 전처리 가공공장으로 이동시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"시범후 30일 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","dJobECd":"9012","dJobECdNm":"[9012]채소·특용작물 재배원","dJobJCd":"6112","dJobJCdNm":"[6112]채소 및 특용작물 재배원","dJobICd":"A011","dJobICdNm":"[A011]작물 재배업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006999:1', '{"dJobCd":"K000006999","dJobCdSeq":"1","dJobNm":"채소작물재배원","workSum":"각종 채소를 파종하고 재배하여 수확·판매한다.","doWork":"채소재배 농지를 경운기, 트랙터 및 기타 농기구로 갈고 준비된 채소 씨앗을 파종한다. 작물의 성장을 촉진하기 위하여 비료를 주고 제초작업을 한다. 병충해의 피해를 예방하기 위하여 병충해 발생상황을 조사하고 병해충의 종류에 따라 살균제, 살충제를 피해 지역에 뿌린다. 관수시설을 이용하여 밭에 물을 주고 괭이나 호미 등을 사용하여 잡초를 뽑고 작물의 간격을 조정한다. 성숙한 채소를 확인하고 채소를 뽑거나 잘라 수확한다. 수확한 채소를 분류하고 다발로 묶는다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실외","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"채소작물재배자, 농부","connectJob":"과채작물재배원, 엽경채작물재배원, 근채작물재배원, 조미채소작물재배원","dJobECd":"9012","dJobECdNm":"[9012]채소·특용작물 재배원","dJobJCd":"6112","dJobJCdNm":"[6112]채소 및 특용작물 재배원","dJobICd":"A011","dJobICdNm":"[A011]작물 재배업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003713:1', '{"dJobCd":"K000003713","dJobCdSeq":"1","dJobNm":"채소작물종자생산원","workSum":"주요 농산물의 우량종자를 생산하여 농가에 보급하기 위하여 주요 작물을 재배한다.","doWork":"퇴비를 투입하고 트랙터를 운전하여 밭을 갈고, 관리기를 이용하여 종자파종에 적당한 형태로 이랑을 만든다. 이앙기나 파종기를 운전하여 씨앗이나 종묘를 이양한다. 성장단계에 맞추어 비료를 시비하고 병충해 방제를 위하여 농약살포기를 사용하여 농약을 살포한다. 콤바인이나 수작업으로 재배된 농산물을 수확한다. 수확한 농산물을 운반하여 건조기에 넣어 건조한다. 건조된 농산물을 일정한 크기나 모양으로 정선한다. 정선이 완료된 농산물의 견본을 채취하여 검사를 의뢰한다. 검사한 종자를 종자공급소에 공급한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"조작운전","connectJob":"전답작물종자생산원, 화훼작물종자생산원","dJobECd":"9012","dJobECdNm":"[9012]채소·특용작물 재배원","dJobJCd":"6112","dJobJCdNm":"[6112]채소 및 특용작물 재배원","dJobICd":"A011","dJobICdNm":"[A011]작물 재배업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007362:1', '{"dJobCd":"K000007362","dJobCdSeq":"1","dJobNm":"특용작물재배자","workSum":"작물의 성장특성과 토양, 기후, 시장조건 등에 관한 지식을 응용하여 약용작물, 유지작물, 기호작물, 향신작물, 특용작물, 산업용원료작물 등을 심고 재배하며 수확한다.","doWork":"재배할 작물의 종류와 양 및 재배면적을 결정한다. 식물재배 지식을 이용하여 재배방법을 결정한다. 작물재배지에 퇴비나 비료, 토양 살충제 등을 뿌리고 쟁기나 경운기 등의 장비로 토양을 갈고 땅을 고른다. 재배방법에 따라 작물을 파종하고 물을 준다. 필요한 농약을 뿌려 주고 간인·중경 작업을 한다. 재배하는 작물의 성장이 완료되면 적당한 방법에 따라 수확하고 선별하여 포장한다. 수확물의 판매를 위하여 구매자와 협의한다. 작물의 동해를 방지하기 위하여 짚이나 퇴비 등으로 덮어 주기도 한다. 종자를 저장하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"손사용|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"공업용원료작물재배자, 기호작물재배자, 섬유작물재배자, 약용작물재배자, 유지작물재배자, 향신작물재배자","dJobECd":"9012","dJobECdNm":"[9012]채소·특용작물 재배원","dJobJCd":"6112","dJobJCdNm":"[6112]채소 및 특용작물 재배원","dJobICd":"A011","dJobICdNm":"[A011]작물 재배업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007486:1', '{"dJobCd":"K000007486","dJobCdSeq":"1","dJobNm":"과수작물재배원","workSum":"각종 과수작물을 심고 경작하며 수확하여 포장한다.","doWork":"삽, 호미, 탬퍼스, 가지치기 갈구리, 전단기 등과 같은 도구를 이용하여 땅을 갈고, 묘목을 심는다. 과수종류, 재식거리(栽植距離:작물을 파종하거나 이식할 때 작물 간의 심는 거리), 현재의 수형에 따라 전정가위나 톱을 사용하여 나무의 모양을 다듬는다. 병충해를 방제하기 위하여 처방된 제초제나 살균제 또는 살충제를 뿌린다. 과일과 열매의 질을 높이기 위하여 솎아 준다. 관수시설을 이용하여 물을 주고, 망치나 톱과 같은 수동식 기구를 사용하여 울타리나 저장창고 등을 수선한다. 당분을 유지하고 병충해로부터 피해를 막기 위하여 봉지를 씌운다. 과일 수량의 과다로 나무가 찢어지거나 부러지는 것을 방지하기 위하여 지주목을 세워 받쳐 준다. 수확 적기를 판별하여 과실을 수확한다. 수확한 과일을 등급별로 분류하여 저장하거나 포장하여 출하한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"과수작물재배자, 과실작물재배원","connectJob":"감귤재배원, 감재배원, 대추농장작업원, 밤재배원, 배재배원, 복숭아재배원, 사과재배원, 포도재배원","dJobECd":"9013","dJobECdNm":"[9013]과수작물 재배원","dJobJCd":"6113","dJobJCdNm":"[6113]과수작물 재배원","dJobICd":"A011","dJobICdNm":"[A011]작물 재배업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005569:1', '{"dJobCd":"K000005569","dJobCdSeq":"1","dJobNm":"과수접목사","workSum":"일시에 많은 양의 접목과 높은 활착률을 얻기 위하여 과수목을 접목하여 번식시킨다.","doWork":"접목 가능한 나무를 파악하고 접목할 대목과 접수를 준비한다. 대목과 접수를 접목할 수 있도록 접목용 칼을 사용하여 조제한다. 대목에 접수의 형성층을 맞추고, 접목용 비닐테이프로 견고하게 동여맨다. 접수의 절단면에서 수분 증발을 막기 위하여 수분 증발 억제제를 도포한다. 접목된 접수에서 새싹이 나오는 것을 확인하고 동여맨 테이프를 제거한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","dJobECd":"9013","dJobECdNm":"[9013]과수작물 재배원","dJobJCd":"6113","dJobJCdNm":"[6113]과수작물 재배원","dJobICd":"A011","dJobICdNm":"[A011]작물 재배업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005728:1', '{"dJobCd":"K000005728","dJobCdSeq":"1","dJobNm":"뽕밭관리원","workSum":"누에 사료인 양질의 뽕잎을 생산하기 위하여 뽕밭을 조성하고 관리한다.","doWork":"트랙터 및 경운기를 사용하여 뽕밭 골을 갈아주고 춘비, 추비로 화학비료를 주고, 추·동절기에는 유기질 비료인 퇴비류를 밭골에 넣는다. 제초작업이나 병충해 방제를 위하여 누에사육기를 피하여 제초제나 병충해 방제 농약을 살포한다. 노후화된 뽕나무를 교체하기 위하여 묘목을 육성한다. 수령이 오래된 뽕나무를 캐내고 새로운 뽕나무를 심는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"위험내재|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"9013","dJobECdNm":"[9013]과수작물 재배원","dJobJCd":"6113","dJobJCdNm":"[6113]과수작물 재배원","dJobICd":"A011","dJobICdNm":"[A011]작물 재배업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004933:1', '{"dJobCd":"K000004933","dJobCdSeq":"1","dJobNm":"눈접합원","workSum":"묘목의 우량적 특성을 살리기 위하여 눈접용 대목으로 키워진 우량품종의 눈을 접합한다.","doWork":"눈접하고자 하는 나무를 선정한다. 대목용 나무에 칼로 T자 모양으로 절개하고 절개 지점을 칼로 벌린다. 접가지에서 떼어낸 눈을 절개 지점에 삽입하고 눈접이 용이하도록 끈으로 묶는다. 눈접한 나무의 활착상태를 관찰한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","dJobECd":"9014","dJobECdNm":"[9014]원예작물 재배원","dJobJCd":"6121","dJobJCdNm":"[6121]원예작물 재배원","dJobICd":"A020","dJobICdNm":"[A020]임업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006586:1', '{"dJobCd":"K000006586","dJobCdSeq":"1","dJobNm":"석부원","workSum":"돌(石)에 식물을 심거나 붙이고 끼워 아름답고 조화롭게 꾸민다.","doWork":"석부작(石附昨:돌에 바닷가 벼랑 등지에서 서식하는 풍란과 나도풍란 또는 나무, 초목 등 여러 형태의 것을 붙여서 만든 것)을 작품으로 또는 자연의 형태로 만드는 대상이 위치할 장소에 따라 조화를 구상하고 설계한다. 구상된 설계에 따라 돌을 붙이거나 깨서 가공하고 마당, 수반, 화분 등의 설치할 위치에 놓아 골격을 세운다. 전체적인 조화가 이루어지도록 돌에 나무, 풀, 이끼 등의 순서로 심고 끼우고 붙여 설계한 작품을 만든다. 작업이 완료되면 흙이 흘러내리지 않도록 이끼로 정지작업을 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|시각|","workEnv":"위험내재|고온|소음·진동|","workFunc1":"조정","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"분경원, 목부원","dJobECd":"9014","dJobECdNm":"[9014]원예작물 재배원","dJobJCd":"6121","dJobJCdNm":"[6121]원예작물 재배원","dJobICd":"A011","dJobICdNm":"[A011]작물 재배업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001543:1', '{"dJobCd":"K000001543","dJobCdSeq":"1","dJobNm":"식물번식가","workSum":"난초와 같은 식물을 환경통제와 식물재배에 대한 지식을 응용하여 번식시킨다.","doWork":"번식시킬 식물의 품종과 형태, 숫자를 확인하고 영양체 형태와 환경을 통제한다. 식물의 종류에 따라 재료를 선택하고 번식용 상토를 혼합하며 독, 화분, 쟁반 등과 같은 용기를 준비한다. 모식물에서 잎과 줄기 혹은 근경을 자르고 잘라낸 것을 번식용 상토 안에 놓는다. 땅에 있는 모식물 줄기를 구부려 덮고 줄기를 말뚝이나 바위로 고정시킨다. 칼을 이용해서 모식물 줄기에 상처를 내고 조약돌을 상처 부위에 삽입하고 이끼로 덮고 천 등으로 동여맨다. 분열조직과 종자를 번식용 상토에 심는다. 온도와 습도 상태를 확인하기 위하여 재배지역을 감시하고 각종 환경을 조절한다. 변화된 성장특성을 촉진하기 위하여 발육 중인 식물에 접을 붙이거나 분리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"난초이식자","dJobECd":"9014","dJobECdNm":"[9014]원예작물 재배원","dJobJCd":"6121","dJobJCdNm":"[6121]원예작물 재배원","dJobICd":"A011","dJobICdNm":"[A011]작물 재배업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007037:1', '{"dJobCd":"K000007037","dJobCdSeq":"1","dJobNm":"식물원관리원","workSum":"전시용 열대, 아열대식물 및 희귀품종을 보존·배양하고 전시용 식물을 관리한다.","doWork":"선인장 및 다엽식물, 난 및 양치류, 열대 및 아열대 수생식물별로 온실의 습도와 온도를 조절한다. 희귀 종자를 파종하고 생육시키는 배양실을 관리한다. 각 식물의 생육상태를 관찰하여 병이나 환경적응이 불량한 품종을 분류하고 격리실로 옮겨 관리한다. 꽃이 피는 시기를 확인하여 품종별로 옮겨 심는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|","workEnv":"다습|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"온실관리원","dJobECd":"9014","dJobECdNm":"[9014]원예작물 재배원","dJobJCd":"6121","dJobJCdNm":"[6121]원예작물 재배원","dJobICd":"R912","dJobICdNm":"[R912]유원지 및 기타 오락관련 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004626:1', '{"dJobCd":"K000004626","dJobCdSeq":"1","dJobNm":"양묘작업원","workSum":"형질이 우수한 조림용 나무를 육종하기 위하여 씨를 뿌리거나 종묘를 심고, 묘목을 굴취(분뜨기)하고, 분류하여 정리·포장한다.","doWork":"묘포장(苗圃場:형질이 우수한 조림용 묘목을 키우는 장소)을 갈고 흙을 부수며 고랑을 파고 관수시설을 설치하여 묘상을 만든다. 육종하고자 하는 모종의 종류에 따라 묘상의 간격을 내고, 모종을 뿌리거나 일정 간격으로 심는다. 비닐을 씌우거나 제초제, 물, 비료를 뿌린다. 육종된 묘목을 삽이나 굴취(掘取:분뜨기)기구로 뽑는다. 묘목의 흙을 털어 수목지의 묘상으로 옮겨 심는다. 파종묘가 적은 것은 다음 해에 이식하기 위하여 가식하고 굴취된 묘목은 옮겨심기 편하게 긴 뿌리를 자른다. 수목지 묘상에서 굴취된 묘목의 뿌리구조, 가지발육상태, 잎의 상태 등을 묘목기준표와 비교하여 분리한다. 기준 이하의 묘목은 버리거나 가식하고, 우량한 묘목을 조림지에 식재하기 위하여 포장한다. 식재계획이 장기화될 우려가 있을 때에는 묘목뿌리의 건조를 막기 위하여 묘목을 비스듬히 세우고 흙으로 덮어준다. 묘목을 조림지로 운반하기 편리하도록 일정 수량씩 다발로 묶어 포장한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실외","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"묘목굴취원, 묘목분류원, 묘목운반원, 묘목포장원, 묘상작업원","dJobECd":"9014","dJobECdNm":"[9014]원예작물 재배원","dJobJCd":"6121","dJobJCdNm":"[6121]원예작물 재배원","dJobICd":"A020","dJobICdNm":"[A020]임업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005555:1', '{"dJobCd":"K000005555","dJobCdSeq":"1","dJobNm":"양묘재배자","workSum":"건강하고 우량한 묘목을 생산하기 위하여 모수를 선정하고 종자채취, 저장, 발아촉진처리, 파종, 이식, 접목, 삽목, 가식, 육묘관리 등의 업무를 수행한다.","doWork":"우량수종을 선택하여 모수로부터 종자를 채취하고 종자의 특성에 따라 탈각(껍질을 벗김) 한다. 수선법, 풍선법, 사선법, 입선법이나 기계를 이용하여 종자를 정선하고 발아율, 순도, 효율에 따라 종자의 품질을 감정·조사한다. 종자의 특성에 따라 건조저장, 밀봉저장, 보호저장, 노천저장 등의 방법으로 종자를 저장한다. 침수법, 약품처리법, 노천매장법, 흡수촉진법, 온상매장법, 저온처리법 등의 적합한 방법으로 처리하여 종자의 발아를 촉진시킨다. 양묘할 포지를 선정하여 경운, 로터리, 시비, 정지, 간인, 중경 및 토양을 소독하고 묘목굴취, 선묘, 가식, 파종, 이식, 삽목, 접목 등의 작업절차에 따라 양묘를 재배한다. 제초작업, 약제살포, 관수, 시비, 해가림 및 월동시설을 관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실외","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"9014","dJobECdNm":"[9014]원예작물 재배원","dJobJCd":"6121","dJobJCdNm":"[6121]원예작물 재배원","dJobICd":"A020","dJobICdNm":"[A020]임업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005017:1', '{"dJobCd":"K000005017","dJobCdSeq":"1","dJobNm":"작물육종보조원","workSum":"작물의 육종을 연구하는 연구원을 보조하여, 지시에 따라 작물의 교배, 연구준비 및 시설물 설치 등의 제반 업무를 수행한다.","doWork":"작물육종을 연구하는 연구원의 지시 내용을 숙지하고 작업할 내용 및 순서를 정한다. 육종활동에 필요한 흙토양 성분을 조성하기 위하여 작물의 특성에 따라 토양성분을 혼합하고 객토(농경지를 개량하기 위하여 성질이 다른 흙을 다른 곳에서 가져다 논밭에 섞는 일 또는 그 흙)한다. 비닐하우스 시설을 설치하기 전 트랙터를 운전하여 토지의 정지(整地:관개에 대비하여 흙을 이동시켜, 수평 또는 균일 경사의 지표면을 조성하는 것)작업을 한다. 정지작업이 다된 농지에 하우스시설을 설치하거나 정비한다. 육종연구가 완료된 작물을 폐기 처분하기 위하여 땅을 파서 메우거나 태워버린다. 종자를 생산하기 위하여 작물육종을 연구하는 연구원의 지시에 따라 교배방법, 교배종 등을 숙지하고 붓, 핀셋, 비닐봉지를 이용하여 교배하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|고온|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"조작운전","connectJob":"종묘재배원, 교배원","dJobECd":"9014","dJobECdNm":"[9014]원예작물 재배원","dJobJCd":"6121","dJobJCdNm":"[6121]원예작물 재배원","dJobICd":"A011","dJobICdNm":"[A011]작물 재배업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004519:1', '{"dJobCd":"K000004519","dJobCdSeq":"1","dJobNm":"화훼작물재배원","workSum":"관상 또는 장식 목적으로 재배하는 화훼작물을 심어 번식시키고 육성하여 수확한다.","doWork":"재배절차와 화훼작물재배관리자의 지시에 따라 재배지에 배양토를 준비하고 종자를 뿌리거나 접지한다. 꽃잎의 구조, 개화정도, 토양조건 등을 관찰하여 영양과 습기의 필요성을 판단한다. 관개장치에 들어올 영양의 양과 빈도를 통제하는 장치를 설치한다. 잡초나 해충을 제거하기 위하여 제초제, 살충제, 살균제 등을 살포한다. 꽃의 성장에 따라 이식하기, 솎아주기 및 거름주기를 한다. 작물특성에 따라 알맞은 기술을 이용하여 수확하고 선별하여 보관한다. 판매를 위하여 꽃이 떨어지지 않게 운반한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"웅크림|","workEnv":"고온|저온|다습|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"구근작물재배원, 관엽식물재배원, 숙근작물재배원, 초화작물재배원, 화목작물재배원, 난재배원, 다육식물재배원, 분재재배원, 선인장재배원, 자생식물재배원, 꽃채취원","dJobECd":"9014","dJobECdNm":"[9014]원예작물 재배원","dJobJCd":"6121","dJobJCdNm":"[6121]원예작물 재배원","dJobICd":"A011","dJobICdNm":"[A011]작물 재배업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002324:1', '{"dJobCd":"K000002324","dJobCdSeq":"1","dJobNm":"골프장코스관리사","workSum":"골프장 코스의 관리계획을 세우고, 관련 종사원의 활동을 조정 및 감독한다.","doWork":"골프경기가 진행될 수 있도록 골프장 코스를 종합적으로 관리·유지한다. 코스의 중장기 관리계획을 수립한다. Green, Tee, Fairway, Rough 등의 잔디를 예초, 시비, 시약, 갱신, 배토, 보식(교체) 등을 통해 관리한다. 조경(골프장 내 수목, 관목, 조경물)을 전정, 시비, 시약, 보수 등의 작업을 통해 관리한다. 시설(스프링클러, 연못, 벙커, 카트 도로 등)을 유지·보수·관리한다. 장비를 유지·관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실외","workFunc1":"조정","workFunc2":"협의","workFunc3":"제어조작","similarNm":"코스관리원","certLic":"조경기사, 식물보호기사","dJobECd":"9015","dJobECdNm":"[9015]조경원","dJobJCd":"6122","dJobJCdNm":"[6122]조경원","dJobICd":"N743","dJobICdNm":"[N743]조경 관리 및 유지 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006156:1', '{"dJobCd":"K000006156","dJobCdSeq":"1","dJobNm":"국가유산수리조경공","workSum":"옛 정원이나 가로에 나무를 심고 가꾸는 업무를 수행하거나 역사적, 예술적, 학술적 가치가 있는 노거수나 수목을 집중관리·치유하는 업무를 수행한다.","doWork":"조경지의 조경을 위해 조경시설물을 설치한다. 장소나 역사성이 있는 나무를 선정하여 근원 직경보다 크게 괭이나 삽을 이용(굴취)한다. 뿌리에 붙어 있는 흙이 떨어지지 않게 뿌리분 둘레를 돌아가면서 새끼를 사용하여 원형이나 원뿔형으로 감고 나무를 눕히고 아랫부분을 새끼로 엇갈려 분이 쳐지지 않게 감아 돌린다(분 만들기). 나무를 식재할 장소로 옮긴(운반) 후, 분의 크기보다 약간 크게 구덩이를 판다(식혈). 수형이 바르고 미관상 아름다운 곳을 앞으로 오게 하여 나무를 구덩이에 넣고 흙을 덮는다(식재). 나무가 바람에 쓰러지지 않게 지주목을 세워준다(지주목 설치). 식재한 나무주위에 멀칭을 해거나 기타 부자재를 설치하여 조경작업을 마무리한다(뒷정리). 전정, 병충해 방제, 비료주기 등의 작업을 수행한다(관리). 정원에 꽃을 심어 배치하고 가꾼다(초화류, 지피식물 식재). 개인주택을 방문하여 정원의 조경을 관리한다(조경지 관리).","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"힘든 작업","workPlace":"실외","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"정원사, 조경공, 조경원, 조경종사원, 동산바치","connectJob":"조경식재공(수목, 잔디, 초화류 등), 조경시설물공(기반조성, 정자, 연지, 화계, 포장, 조산, 괴석 설치, 조경지관리 등), 실내조경사, 식물보호공","certLic":"국가유산수리기능자(조경, 식물보호공)","dJobECd":"9015","dJobECdNm":"[9015]조경원","dJobJCd":"6122","dJobJCdNm":"[6122]조경원","dJobICd":"F412/N743","dJobICdNm":"[F412]토목 건설업 / [N743]조경 관리 및 유지 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006877:1', '{"dJobCd":"K000006877","dJobCdSeq":"1","dJobNm":"사업체조경관리원","workSum":"녹지대의 조경수목, 잔디, 조경시설물 등 제반 경관시설을 효율적으로 유지관리하기 위해 작업방법 등 계획을 수립하고 녹화관리 작업의 감독 및 녹지대 순회점검 등 제반 관리업무를 한다.","doWork":"녹화관리 작업실적 및 관련 자료를 분석하여 작업별 인원, 자재, 장비의 합리적 운용을 위한 개선방법을 강구하여 효율적인 조경이 되도록 설계한다. 지역 특성에 따라 작업종별 물량, 작업주기를 고려하여 작업인원, 장비, 수목 등을 효율적으로 운용할 수 있도록 작업계획을 수립한다. 작업표준서에 준하여 효율적인 작업이 이루어지도록 작업원을 관리·감독한다. 반입자재 검수, 작업완료 확인과 안전, 환경관리 등 제반 녹화 관리작업을 감독한다. 주요시설, 건물, 도로변 녹지대 및 취약지역을 정기적으로 순회 점검하여 수목, 잔디, 조경시설물 등의 녹지대 이상 유무를 확인·기록한다. 병충해에 대해서 조사·연구한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"감독","workFunc3":"수동조작","dJobECd":"9015","dJobECdNm":"[9015]조경원","dJobJCd":"6122","dJobJCdNm":"[6122]조경원","dJobICd":"N743","dJobICdNm":"[N743]조경 관리 및 유지 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005744:1', '{"dJobCd":"K000005744","dJobCdSeq":"1","dJobNm":"수목관리원","workSum":"정원, 공원, 도로 주변의 관목을 가지치기하고 전정가위로 나무의 모양을 아름답게 만들고 관리한다.","doWork":"성장을 촉진하기 위해 죽었거나 원치 않는 큰 가지를 자르고 나무를 다듬는다. 나무의 병충해 침입을 조사한다. 해충과 질병을 막기 위해 수동 및 기계식 분무기를 이용하여 관목과 나무에 농약을 분무한다. 성장을 촉진하기 위해 비료를 뿌린다. 나무의 성장특성을 조절하기 위하여 나무꼭대기를 덮거나 나뭇가지가 서로 겹치고 부딪히는 것을 방지하기 위해 다용도 줄을 사용하여 작업한다. 덤불과 잡초를 제거하기 위하여 제초제를 치거나 벌초기계를 사용하여 제거한다. 정원이나 공원에 나무를 심기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실외","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"수동조작","connectJob":"정원사","dJobECd":"9015","dJobECdNm":"[9015]조경원","dJobJCd":"6122","dJobJCdNm":"[6122]조경원","dJobICd":"N743","dJobICdNm":"[N743]조경 관리 및 유지 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005670:1', '{"dJobCd":"K000005670","dJobCdSeq":"1","dJobNm":"수목전지원","workSum":"정원의 나무나 가로수 등에서 죽은 나무나 과도한 가지를 톱이나 갈고리, 전정가위, 수동가위 등을 사용하여 잘라낸다.","doWork":"나무의 형상을 향상시켜 상품적 가치를 높이기 위하여 나무에 오르는 벨트, 사다리 등을 이용하여 나무에 올라가 죽은 가지 또는 주된 가지를 남기고 생지의 일부를 쳐준다. 강설량이 많은 지역은 나뭇가지가 눈에 의해 부러지는 것을 방지하기 위하여 가지치기를 한다. 풍해의 위험이 있는 해변가는 바람이 잘 통하도록 가지치기를 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"가지치기원","dJobECd":"9015","dJobECdNm":"[9015]조경원","dJobJCd":"6122","dJobJCdNm":"[6122]조경원","dJobICd":"N743","dJobICdNm":"[N743]조경 관리 및 유지 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002931:1', '{"dJobCd":"K000002931","dJobCdSeq":"1","dJobNm":"잔디관리사","workSum":"골프장, 축구장, 야구장, 공원, 유적지 및 기타 시설의 잔디밭을 관리한다.","doWork":"잔디밭을 유지·관리한다. 기계(갱모아, 로타리모아, 예초기 등)를 이용하여 예초 한다. 살포기, 동분기 등을 이용하여 비료, 농약, 토양개량제 등을 살포하는 시비·시약 작업을 한다. 연작으로 인한 장해를 개선하고자 코어링, 버티컷, 슬라이싱, 배토 작업 등을 주기적으로 실시하는 갱신 작업을 한다. 스프링클러를 이용하여 시기별로 물을 관리하는 관수 작업을 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"웅크림|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","dJobECd":"9015","dJobECdNm":"[9015]조경원","dJobJCd":"6122","dJobJCdNm":"[6122]조경원","dJobICd":"N743","dJobICdNm":"[N743]조경 관리 및 유지 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003277:1', '{"dJobCd":"K000003277","dJobCdSeq":"1","dJobNm":"조경사","workSum":"가로나 정원에 나무를 심고 가꾸며 조경시공기술자의 지시에 따라 장비나 나무를 운반하고 구멍을 파는 등의 업무를 수행한다.","doWork":"옮겨 심을 나무를 선정하고 근원 직경보다 크게 괭이나 삽을 이용하여 터파기를 한 후, 분의 크기에 따라 뿌리를 전정(가지치기)하여 뿌리돌림을 한다. 뿌리에 붙어 있는 흙이 떨어지지 않게 뿌리분 둘레를 돌아가면서 새끼를 사용하여 원형으로 감고 나무를 눕히고 아랫부분을 새끼로 엇갈려 분이 쳐지지 않게 감아 돌린다. 나무를 식재할 장소로 옮긴 후, 분의 크기보다 약간 크게 구덩이를 판다. 수형이 바르고 미관상 아름다운 곳을 앞으로 오게 하여 나무를 구덩이에 넣고 흙을 덮는다. 나무가 바람에 쓰러지지 않게 지주목을 세워준다. 식재한 나무 주위에 잔디를 심거나 기타 부자재를 설치하여 조경작업을 마무리한다. 전정, 병충해 방제, 비료주기 등의 작업을 수행한다. 정원에 꽃을 심어 배치하고 가꾼다. 개인주택을 방문하여 정원의 조경을 관리하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"힘든 작업","workPlace":"실외","physicalAct":"웅크림|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"정원사, 조경공, 조경원, 조경종사원","connectJob":"수목식재원, 잔디식재원, 실내조경사, 식물보호조경공","certLic":"문화재수리기술자(식물보호), 문화재수리기능자(식물보호공), 분재관리사","dJobECd":"9015","dJobECdNm":"[9015]조경원","dJobJCd":"6122","dJobJCdNm":"[6122]조경원","dJobICd":"F412","dJobICdNm":"[F412]토목 건설업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007373:1', '{"dJobCd":"K000007373","dJobCdSeq":"1","dJobNm":"조경시설물설치원","workSum":"공원, 정원, 도로주변, 학교, 레크리에이션센터, 관광지 등의 생활공간에 환경개선과 위락시설을 위하여 인조석·자연석·놀이시설 등 각종 시설물을 설치한다.","doWork":"조경시설물을 설치할 장소의 지반을 조사한다. 설치물에 따라 지반에 기초작업을 한다. 제작된 벤치, 휴지통, 안내판 등의 시설물을 도면이나 조경시공기술자의 지시에 따라 설치하고 콘크리트 등으로 고정시킨다. 강이나 하천에서 채취되거나 자연석 형태로 가공된 자연석 및 인조석을 설치장소로 운반한다. 형태 및 무늬를 고려하여 자연석을 선별하여 주위 경관과 조화를 이루도록 배치한다. 설치한 자연석의 안전을 위하여 자연석 사이에 작은돌을 넣어 고정시킨다. 조합놀이대, 미끄럼대, 그네 등 놀이시설물을 매끈하고 안전하게 설치하기 위하여 부분품을 조립·용접하고 면모서리, 구석모서리, 돌출부 등을 둥글게 처리한다. 목재나 철재부분은 녹방지 및 내구성을 위하여 도장한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실외","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"조경물설치원, 조경시공원, 조경공","connectJob":"하는 일에 따라 조경물유지보수원, 조형물설치원, 석상설치원, 벤치설치원, 놀이시설물설치원, 인조석설치원, 자연석설치원","dJobECd":"9015","dJobECdNm":"[9015]조경원","dJobJCd":"6122","dJobJCdNm":"[6122]조경원","dJobICd":"F412","dJobICdNm":"[F412]토목 건설업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004735:1', '{"dJobCd":"K000004735","dJobCdSeq":"1","dJobNm":"낙농장작업원","workSum":"낙농장에서 젖소를 사육하고 우유를 생산하기 위한 제반 작업을 수행한다.","doWork":"송아지, 육성우, 성우의 사료급여량을 확인하고 사일로(Silo)나 창고에서 무게를 계량하여 손수레에 실어 축사로 운반하고 먹이통에 공급한다. 급수통을 관찰하여 충분한 양의 물을 공급한다. 손수레, 삽, 트랙터, 경운기 등을 사용하여 축사 내의 소똥을 청소한다. 운동장 또는 방목지로 소를 몰아 방목시킨다. 축사 내 또는 방목지에서 젖소를 관찰하여 발정, 상처, 질병 등이 발견되면 젖소사육사에게 알린다. 분만예정우, 발정우, 직장검사를 해야 할 젖소를 소무리에서 골라낸다. 분만 예정일 전에 어미소를 분만실로 옮기고 볏짚, 왕겨, 톱밥 등의 깔짚을 깔아준다. 분만 시 분만을 돕고 산후관리를 한다. 사료를 경운기나 운반용구에 실어 사일로(Silo)나 창고로 운반하여 저장한다. 낙농장의 시설물을 보수하고 장비를 점검하고 관리한다. 손이나 착유기를 사용하여 우유를 짠다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","dJobECd":"9021","dJobECdNm":"[9021]낙농 종사원","dJobJCd":"6131","dJobJCdNm":"[6131]낙농업 관련 종사원","dJobICd":"A012","dJobICdNm":"[A012]축산업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001899:1', '{"dJobCd":"K000001899","dJobCdSeq":"1","dJobNm":"젖소사육사","workSum":"우유를 생산하기 위하여 젖소를 번식하고 사육한다.","doWork":"최대의 우유생산에 필요한 사료급여량을 결정하기 위하여 사료 및 우유생산 기록을 검토한다. 젖소를 관찰하여 분만 징후가 있는 소는 분만실로 이동하여 관리한다. 정상분만을 유도하고 난산일 경우에는 수의사의 조치를 받는다. 분만 즉시 외부생식기를 소독하여 오염을 방지하고, 초유를 짜서 송아지에게 공급한다. 분만 당일 암수 구분, 일련번호를 주고 카드를 작성하여 개체관리를 한다. 송아지의 육성 단계별로 포유량 및 사료급여량을 조절한다. 전염병 및 질병을 방지하기 위한 예방접종을 실시한다. 개체별 능력파악을 위하여 산유량, 사료섭취량, 번식 및 질병 등의 기록을 관리한다. 병든 소를 분리하여 관리하고 치료한다. 사료급여, 방목, 축사 내 장비 및 시설관리, 착유, 송아지 뿔 제거, 유방털 제거, 방역, 송아지 산후관리 등의 작업을 종사원들에게 분담하고 감독한다. 낙농기계 및 장비, 시설을 관리하고 개선한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"9021","dJobECdNm":"[9021]낙농 종사원","dJobJCd":"6131","dJobJCdNm":"[6131]낙농업 관련 종사원","dJobICd":"A012","dJobICdNm":"[A012]축산업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002720:1', '{"dJobCd":"K000002720","dJobCdSeq":"1","dJobNm":"착유사","workSum":"착유기를 조작하여 젖소에서 우유를 짠다.","doWork":"젖소를 착유실의 기둥에 고정하고, 세척기의 온수호스를 사용하여 온수를 유방에 골고루 뿌려 완전히 세척한다. 세균이 젖꼭지 구멍으로 침투하지 않도록 소독된 수건으로 유방 전체를 깨끗이 닦고 문지른다. 착유기의 유두컵을 장착하기 전에 유방염 조기발견 또는 유두구멍의 손상을 막기 위하여 손으로 젖을 짜 보아 정상 여부를 확인한다. 착유기를 가동하고 유두컵을 젖꼭지에 부착하고 공기가 새지 않나 검사한다. 맥동기의 맥동수가 정상인지 확인하고 적당량의 우유가 채취되면 공기를 차단하고 유두컵을 떼어 낸다. 착유 후 유두 침지를 소독하여 유방염균의 침입을 막는다. 채취된 우유를 펌프를 사용하여 냉각 저장탱크로 옮겨 보관한다. 유두컵을 살균용액에 담가 살균하고, 착유기 내에 있는 우유 잔여량을 모두 씻어내고 공기로 건조한다. 착유기구 및 우유탱크를 세척하고 소독한다. 착유실 내를 청소한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"착유기조작원","dJobECd":"9021","dJobECdNm":"[9021]낙농 종사원","dJobJCd":"6131","dJobJCdNm":"[6131]낙농업 관련 종사원","dJobICd":"A012","dJobICdNm":"[A012]축산업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004545:1', '{"dJobCd":"K000004545","dJobCdSeq":"1","dJobNm":"돼지사육사","workSum":"식용의 고기를 얻기 위하여 돼지를 번식하고 사육한다.","doWork":"분만 전 모돈을 임신사에서 분만사로 들여와 지정된 축사에 넣고 관찰한다. 분만을 원활히 하기 위하여 모돈의 사료급여량을 조절한다. 난로, 온풍기 등으로 축사 내의 온도를 적당하게 유지한다. 분만 시 안정할 수 있도록 보온매트 등을 깔아주고, 소독기구, 탯줄절단기구 등의 분만에 필요한 기구를 준비한다. 분만하면 헝겊 등으로 새끼를 닦아주고 탯줄, 송곳니, 꼬리를 자르고 보온상자에 넣는다. 새끼에게 모돈의 젖을 정하여 주고, 사료에 적응할 수 있는 훈련을 시킨다. 일정 기간 사료적응 훈련이 끝나면 육성사로 보내 체중이나 암수를 분류하여 육성한다. 주기적으로 사료를 공급하고 병든 돼지나 체중 미달 돼지는 분류하여 치료하고 사육한다. 돈콜레라, 돼지단독 등의 질병을 예방하기 위하여 예방접종을 한다. 분만 후 모돈의 발정 징후를 관찰하고 모돈의 체중 및 품종을 고려하여 교배시킨다. 재발정 여부를 확인하여 임신된 모돈은 임신사로 보낸다. 임신 기일에 따라 사료급여량을 조절하고 질병예방을 위하여 백신을 접종한다. 일정 기간 후 유방의 발육상태 확인 또는 임신 감정기를 사용하여 불임돈을 구별한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"모돈사육사","dJobECd":"9022","dJobECdNm":"[9022]가축 사육 종사원","dJobJCd":"6132","dJobJCdNm":"[6132]가축 사육 종사원","dJobICd":"A012","dJobICdNm":"[A012]축산업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005319:1', '{"dJobCd":"K000005319","dJobCdSeq":"1","dJobNm":"목초재배작업원","workSum":"초식가축에게 풀을 공급하기 위하여 목초지를 재배하고 관리한다.","doWork":"목초지관리원의 지시를 받아 파종을 하기 위하여 목초지를 갈고 석회를 뿌린다. 파종준비가 끝난 목초지에 지시한 씨를 뿌린다. 사료의 가치 및 생산량을 증대하기 위하여 파종한 후나 풀을 베어낸 후에 지시된 양의 비료를 뿌린다. 가을에 조성된 초지의 겨울나기를 돕기 위하여 롤러(Roller) 등을 이용하여 월동 전에 눌러준다. 봄에 땅이 녹기 시작할 때 서릿발 피해를 막기 위하여 롤러로 눌러준다. 목초지를 관찰하여 병해·해충 등의 상태를 확인하고 목초지관리원에게 보고한다. 잡초를 제거하고 목초재배지에 빈 곳이 생기면 수시로 파종을 하여 잡초의 발생과 수량의 감소를 막는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"웅크림|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"목초재배자, 농부","dJobECd":"9022","dJobECdNm":"[9022]가축 사육 종사원","dJobJCd":"6132","dJobJCdNm":"[6132]가축 사육 종사원","dJobICd":"A011","dJobICdNm":"[A011]작물 재배업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001912:1', '{"dJobCd":"K000001912","dJobCdSeq":"1","dJobNm":"목초지관리원","workSum":"초식가축에게 조사료로 풀을 공급하기 위하여 목초재배작업원을 관리·감독하여 목초를 재배하고 관리한다.","doWork":"목초의 품종별 재배특성, 기후 및 시장조건, 인력 및 기계장비에 따라 파종시기, 비료주기, 수확기 등의 작업일정을 계획한다. 농기계 또는 수동으로 목초지를 갈고 품종을 선택하여 파종한다. 겨울철에 얼어 죽거나 봄철 땅이 녹기 전 재해로부터 보호하기 위하여 목초를 롤러 등으로 눌러주도록 목초재배작업원에게 지시한다. 사료가치 및 식물의 생장균형을 유지하기 위하여 목초에서 이삭이 나오기 직전에 지상에서 일정 길이를 남기고 풀을 베고 비료를 준다. 목초의 잎 끝이 황색이나 갈색으로 변하기 전에 같은 방법으로 베어주고 비료를 준다. 목초를 베어내는 횟수는 목초의 재생기간을 고려하여 선정하고 사료의 가치를 높이기 위하여 질소 및 알칼리 비료를 준다. 목초지를 관찰하여 병해, 충해나 잡초를 확인하여 적절한 구제방법을 선택하여 제거한다. 가축에 공급하고 남은 풀은 건조시켜 건초로 저장한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","dJobECd":"9022","dJobECdNm":"[9022]가축 사육 종사원","dJobJCd":"6132","dJobJCdNm":"[6132]가축 사육 종사원","dJobICd":"A011","dJobICdNm":"[A011]작물 재배업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006821:1', '{"dJobCd":"K000006821","dJobCdSeq":"1","dJobNm":"반려동물생산자","workSum":"해당 반려동물의 종의 표준에 대한 전문성 및 번식지식과 번식윤리를 가지고 해당 반려동물을 번식시킨다.","doWork":"반려동물을 정기적으로 운동시키고 건강을 관리해서 최상의 상태를 유지하도록 한다. 반려동물을 해당 스탠다드에 부합하도록 번식한다. 태어난 반려동물에게 건강검진을 하고 질병이 생겼을 경우 치료한다. 부모를 기록하고 혈통을 관리한다. 반려동물을 분양희망자에게 분양한다. 분양희망자에게 반려동물 사육에 대해 설명한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"손사용|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"동물생산업자","dJobECd":"9022","dJobECdNm":"[9022]가축 사육 종사원","dJobJCd":"6132","dJobJCdNm":"[6132]가축 사육 종사원","dJobICd":"S969","dJobICdNm":"[S969]그 외 기타 개인 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005228:1', '{"dJobCd":"K000005228","dJobCdSeq":"1","dJobNm":"승용조랑말관리원","workSum":"유원지, 공원, 관광농원, 관광지 등에서 고객이 조랑말을 타는 것을 돕고 조랑말을 관리한다.","doWork":"고객에게 조랑말을 타는 것을 권한다. 안전하게 조랑말을 타는 방법을 설명하고 고객이 타고 내리는 것을 돕는다. 말을 탄 고객을 위하여 말을 일정 코스로 유도한다. 조랑말에 마구를 채워 안장을 얹고 먹이를 주며 질병이 발생하지 않도록 목욕을 시키거나 축사를 청소한다. 조랑말을 탄 고객에게 요금을 받거나 사진을 찍어주기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실외","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"단순작업","dJobECd":"9022","dJobECdNm":"[9022]가축 사육 종사원","dJobJCd":"6132","dJobJCdNm":"[6132]가축 사육 종사원","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002659:1', '{"dJobCd":"K000002659","dJobCdSeq":"1","dJobNm":"양계장작업원","workSum":"알이나 고기를 생산하기 위하여 닭을 사육하는 양계장에서 사료공급, 계사관리, 소독, 청소 등을 한다.","doWork":"부화장에서 수송해 온 병아리를 일정 마리씩 육추실에 넣는다. 지시된 양의 사료와 물을 공급한다. 닭의 상태를 관찰하여 병들었거나 죽은 닭은 무리에서 제거한다. 주기적으로 닭의 똥을 치운다. 일정 시간마다 알을 걷고 분류하며, 수량을 기록한다. 전염병 또는 질병 예방을 위하여 지시된 약품을 사용하여 계사, 장비, 시설물을 소독한다. 계사 내의 온도, 환기, 습도상태를 기록한다. 알이나 성장한 닭을 포장하여 수송차에 적재한다. 계사를 자동화하여 자동으로 물, 먹이를 공급하고 똥을 치우는 계사를 관리하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","connectJob":"육종양계장작업원, 종계장작업원, 채란양계장작업원","dJobECd":"9022","dJobECdNm":"[9022]가축 사육 종사원","dJobJCd":"6132","dJobJCdNm":"[6132]가축 사육 종사원","dJobICd":"A012","dJobICdNm":"[A012]축산업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005218:1', '{"dJobCd":"K000005218","dJobCdSeq":"1","dJobNm":"양돈장작업원","workSum":"양돈장에서 돼지의 사육, 번식을 도우며, 양돈장 및 관련 시설을 청소한다.","doWork":"가축의 행동을 관찰, 판단, 문제 개선을 통해 사육, 번식 업무를 수행한다. 매일 농장 내 밝기, 사료, 물, 공기, 사육 공간, 건강상태 등 돼지 행동을 관찰하여 최적의 사육환경을 제공한다. 사육구간별 발생할 수 있는 위험요소들을 사전에 확인하고 적절한 조치를 취한다. 사료급여 및 섭취량 확인, 돈사청소, 실내 온도 및 환기량 유지, 질병 차단 및 사육환경개선, 모돈 및 자돈 관리 등 세부 업무를 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","dJobECd":"9022","dJobECdNm":"[9022]가축 사육 종사원","dJobJCd":"6132","dJobJCdNm":"[6132]가축 사육 종사원","dJobICd":"A012","dJobICdNm":"[A012]축산업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005070:1', '{"dJobCd":"K000005070","dJobCdSeq":"1","dJobNm":"양사육사","workSum":"양모 및 고기를 생산하기 위하여 양을 번식하고 사육한다.","doWork":"분만된 양이 스스로 젖을 먹을 수 있을 때까지 돌본다. 일정 기간이 지나면 꼬리를 잘라주고 수컷은 거세한다. 젖을 뗀 후 질 좋은 풀 및 사료를 공급한다. 방목시기에는 양들을 목초지로 몰아 먹이를 공급하고, 겨울철에는 건초 및 보조사료를 급여한다. 건강하게 발육시키기 위하여 무기물 사료인 칼슘, 인 등을 공급한다. 발정기를 관찰하여 자연교배시키고 임신 후, 일정 기간이 지나면 충분한 영양분을 공급한다. 분만 전에는 예방주사 및 구충제를 투여한다. 양모가 가장 좋은 시기에 털깎기를 한다. 양들을 검사하여 무리로부터 이탈하지 않도록 하고 질병 및 상처의 징후를 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"9022","dJobECdNm":"[9022]가축 사육 종사원","dJobJCd":"6132","dJobJCdNm":"[6132]가축 사육 종사원","dJobICd":"A012","dJobICdNm":"[A012]축산업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002798:1', '{"dJobCd":"K000002798","dJobCdSeq":"1","dJobNm":"오리사육사","workSum":"식용의 고기나 털을 얻기 위하여 오리를 번식하고 사육한다.","doWork":"육성률, 품종이 좋은 오리를 구입하거나 종란을 부화기로 부화한다. 육추실에 일정 수씩 새끼오리를 넣고, 육성 단계별로 온도, 습도, 환기를 적당하게 조절한다. 새끼오리의 사료 적응을 위하여 달걀 노른자를 익혀 소화하기 쉬운 사료에 혼합하여 사료를 준다. 물은 항상 먹을 수 있도록 충분히 공급한다. 육성단계에 적당한 배합사료를 공급한다. 전염병이나 질병을 예방하기 위하여 육추실 및 우리를 깨끗이 청소하고 소독한다. 육추실 내의 오리를 관찰하여 죽거나 병든 오리는 분류하여 제거한다. 육성률, 사료급여량, 부화량 등을 기록한다. 경제적 형질을 높이기 위하여 순수 혈통을 유지하거나 다른 품종을 교잡하기도 한다. 종란을 생산하기 위하여 종란 생산용 오리는 따로 분류하여 사육하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"대기환경미흡|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"9022","dJobECdNm":"[9022]가축 사육 종사원","dJobJCd":"6132","dJobJCdNm":"[6132]가축 사육 종사원","dJobICd":"A012","dJobICdNm":"[A012]축산업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004777:1', '{"dJobCd":"K000004777","dJobCdSeq":"1","dJobNm":"육계사육사","workSum":"양계장에서 고기를 얻기 위하여 병아리를 구입하고 닭을 사육한다.","doWork":"발육이 빠르고 건강하며 육질이 우수한 품종의 병아리를 구입한다. 육성 단계별로 사료급여량, 보온, 보습 등을 감안하여 육성 계획을 세운다. 육추실에 병아리를 일정 수씩 넣고 온도를 적절하게 유지한다. 물에 갠 사료를 뿌려주어 사료 적응훈련을 시킨다. 물을 충분히 공급하고 평판급여기, 자동급여기를 성장 속도에 맞추어 사료량을 조절하여 공급한다. 육추실에서 일정 기간 성장하면 계사에 나누어 넣어 사육한다. 단기비육을 위하여 고열량, 고단백, 고비타민, 무기물 사료를 충분히 공급하고, 활동을 최소로 할 수 있도록 한다. 계사 내의 온도를 관찰하여 항상 체온유지 적온으로 맞추어 사료의 낭비를 막는다. 닭을 관찰하여 병들었거나 죽은 것은 제거한다. 질병예방을 위하여 예방접종을 하거나, 출하 후 계사 내부 및 각종 기구(모이통, 물통 등)를 세척·소독한다. 도태, 폐사 수, 사료급여량, 연료소비, 예방접종 등을 기록하여 사육일지를 작성한다. 일정 기간 육성되면 출하하기 위하여 모이통을 치우고 닭을 안정시킨다. 사육주기에 따라 입추 수, 출하 수를 조정한다. 종란을 구입하여 부화하기도 하며, 육성된 닭을 판매한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"9022","dJobECdNm":"[9022]가축 사육 종사원","dJobJCd":"6132","dJobJCdNm":"[6132]가축 사육 종사원","dJobICd":"A012","dJobICdNm":"[A012]축산업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004243:1', '{"dJobCd":"K000004243","dJobCdSeq":"1","dJobNm":"육우목장작업원","workSum":"식용의 고기와 가죽을 얻기 위하여 소를 사육·번식하는 육우목장에서 육우사육사를 보조한다.","doWork":"체중별 사료급여표를 확인하고, 사일로(Silo) 또는 창고에서 손수레에 사료를 실어 우사로 운반한다. 삽, 양동이를 사용하여 먹이통에 공급한다. 급수통을 확인하여 물을 충분히 먹을 수 있도록 한다. 절단기를 사용하여 조사료(곡초, 옥수수대, 생초 등)를 적당한 크기로 잘라 공급한다. 방목장, 축사 내에서 소를 관찰하여 병들거나 발정한 소를 확인하고 육우사육사에게 알린다. 삽, 손수레, 트랙터를 사용하여 우분을 청소한다. 지시된 약품을 사용하여 분무기로 축사 및 시설물을 방역한다. 병든 소를 치료할 때 소를 기둥에 묶고 작업을 보조한다. 축사에 소를 몰아넣고 출하 시 트럭에 싣는다. 농장의 시설물 및 장비를 보수·세척하고 축사 주변을 정리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"단순작업","dJobECd":"9022","dJobECdNm":"[9022]가축 사육 종사원","dJobJCd":"6132","dJobJCdNm":"[6132]가축 사육 종사원","dJobICd":"A012","dJobICdNm":"[A012]축산업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005231:1', '{"dJobCd":"K000005231","dJobCdSeq":"1","dJobNm":"육우사육사","workSum":"식용의 고기와 가죽을 얻기 위하여 육용 소를 번식하고 사육한다.","doWork":"단기비육을 위하여 일당 증체량 및 사료섭취량 기록을 확인하고 체중별 또는 개월별로 사료급여량을 결정한다. 생후 일정 기간까지 사료 적응훈련을 위하여 제한급식을 한다. 단기비육을 위하여 생후 일정 기간이 지나면 무제한 사료를 공급한다. 조사료 및 물은 항상 먹을 수 있도록 공급한다. 소를 관찰하여 질병 및 건강상태를 확인하고 가벼운 상처는 치료하고, 심한 상처는 수의사에게 알려 조치한다. 이표장착기기로 이표작업을 하여 소를 개별 관리한다. 일정 주기별로 예방접종 및 구충제를 투여한다. 축사 내 소의 외상, 털색깔, 사료섭취량 등을 확인하여 병든 소를 선별·분리·관리한다. 사료급여, 분뇨청소, 곡초 절단, 방목장 및 축사청소, 방역 등의 작업을 종사원들에게 분담하고 감독한다. 사료급여량, 병든 소의 발생 여부, 치료상태, 건강상태 등을 파악하여 작업일지에 작성한다. 농장의 시설물과 장비를 관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"9022","dJobECdNm":"[9022]가축 사육 종사원","dJobJCd":"6132","dJobJCdNm":"[6132]가축 사육 종사원","dJobICd":"A012","dJobICdNm":"[A012]축산업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006944:1', '{"dJobCd":"K000006944","dJobCdSeq":"1","dJobNm":"자급사료생산관리자","workSum":"초식가축에게 청초, 건초, 사일리지(Silage) 등의 자급 사료를 공급하기 위하여 목초, 옥수수, 호맥 등 사료작물을 재배하고 관리한다.","doWork":"자급사료 수급계획, 품종, 토지, 장비 등에 의거하여 자급사료 재배지를 만든다. 필요한 토양 성분을 분석·의뢰하고 필요한 품종을 선택하며 종사원을 지휘·감독하여 퇴비살포, 경운, 비료주기, 쇄토, 정지, 파종, 생유관리, 수확작업을 한다. 국내의 문헌을 참고하여 생초, 건초, 사일리지를 최고 영양상태에서 수확할 수 있는 방안 및 자급사료 저장 중 일어나는 손실을 최소화하는 방안을 강구한다. 농기구의 효율적인 이용 계획을 수립한다. 부존자원, 볏짚, 산야초, 무잎, 가축분 등의 사료화 방안을 연구한다. 유휴지를 활용하여 자급사료 증산방안을 계획한다. 초지의 조성 및 갱신계획을 수립한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","certLic":"품질관리기술사, 품질경영기사, 품질경영산업기사","dJobECd":"9022","dJobECdNm":"[9022]가축 사육 종사원","dJobJCd":"6132","dJobJCdNm":"[6132]가축 사육 종사원","dJobICd":"A012","dJobICdNm":"[A012]축산업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002414:1', '{"dJobCd":"K000002414","dJobCdSeq":"1","dJobNm":"자급사료생산작업원","workSum":"청초, 건초, 사일리지(Silage) 등 자급사료를 생산하기 위하여 사료재배지를 관리한다.","doWork":"자급사료 생산이용계획에 의한 자급재배지를 만든다. 잡석을 제거하고 제초제를 살포한다. 재배지를 경운기, 트랙터, 기타 장비를 사용하여 갈고 김을 매거나 땅을 고른다. 자급사료생산관리자의 지시에 따라 선택된 품종을 파종한다. 사료재배지를 관찰하여 이상이 있으면 관리자에게 보고한다. 청초를 베어 목장에 공급하고 필요한 시기에 방목을 한다. 수확한 사료작물을 건초 및 사일리지로 만들기 위하여 절단하여 저장창고 또는 사일로로 운반·저장·관리한다. 토질을 개선하기 위하여 토지개량제(석회)나 퇴비를 뿌린다. 사료재배지의 시설물을 관리하고 농기구를 세척·정비한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","dJobECd":"9022","dJobECdNm":"[9022]가축 사육 종사원","dJobJCd":"6132","dJobJCdNm":"[6132]가축 사육 종사원","dJobICd":"A012","dJobICdNm":"[A012]축산업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006101:1', '{"dJobCd":"K000006101","dJobCdSeq":"1","dJobNm":"종계사육사","workSum":"양계를 위하여 종계를 번식하고 사육한다.","doWork":"품종 및 크기별로 종계를 분류한다. 사료, 물을 공급하거나 급여량을 작업원에게 지시한다. 계사 내의 환경상태, 종계의 상태를 점검한다. 육성률, 사료급여량, 초산일, 부화율 등을 기록한다. 전염병이나 질병을 예방하기 위하여 방역 및 예방접종을 한다. 경제적 형질을 높이기 위하여 순수혈통을 유지·관리하고 서로 다른 품종 간의 교잡을 한다. 매일 발생되는 도태된 종계 및 종란의 숫자를 파악하고 계사 내의 온도를 관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"9022","dJobECdNm":"[9022]가축 사육 종사원","dJobJCd":"6132","dJobJCdNm":"[6132]가축 사육 종사원","dJobICd":"A012","dJobICdNm":"[A012]축산업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001723:1', '{"dJobCd":"K000001723","dJobCdSeq":"1","dJobNm":"종돈사육사","workSum":"우량품종의 돼지로 개량하기 위하여 종돈을 관리하고 사육한다.","doWork":"암수의 분만 수, 수태율, 육성률, 생시체중(生時體重:태어났을 때의 몸무게), 사료요구율, 지방두께 등의 번식성적을 기록한다. 번식성적 기록표에 의하여 암퇘지의 취약점을 보완할 수 있는 수퇘지를 선택하여 계획적으로 인공수정을 한다. 새끼를 분만하면 분만 수, 성별, 생시체중, 분만 횟수 등의 분만기록표를 작성하고 귀표를 붙인다. 유두 및 외모에 이상이 있는 불량 돼지를 분류하고 일정 기간 사육한 후 사료요구율, 등지방함량, 증체량(增體量:일정한 기간에 가축의 몸무게가 늘어난 양)을 검사한다. 모돈의 취약점을 보완할 수 있는지 확인하고 종돈의 선발 여부를 결정한다. 번식 성적을 토대로 하여 모돈 선발지수를 작성하고 모돈의 도태 여부를 결정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"9022","dJobECdNm":"[9022]가축 사육 종사원","dJobJCd":"6132","dJobJCdNm":"[6132]가축 사육 종사원","dJobICd":"A012","dJobICdNm":"[A012]축산업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002804:1', '{"dJobCd":"K000002804","dJobCdSeq":"1","dJobNm":"채란양계사육사","workSum":"계란을 생산하기 위하여 닭을 사육한다.","doWork":"산란능력이 우수한 품종의 채란용 육성닭을 구입한다. 구입된 육성닭을 일정 수씩 계사에 옮기고 일정한 시간마다 사료를 공급하거나 자동급여기를 사용하여 사료를 급여한다. 물은 항상 먹을 수 있도록 급수통에 공급하고 계사 내의 닭을 관찰하여 병들었거나 죽은 것은 제거한다. 일정 주기로 계사 내를 순회하여 생산된 알을 수집한다. 산란율, 사료요구율 등을 기록하여 암탉의 도태를 결정한다. 계분을 제거하여 발효장으로 운반하여 발효시킨다. 계사, 자동급여기, 급수기, 보온장비 등의 양계장 시설을 보수하고 관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|","workEnv":"대기환경미흡|소음·진동|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"9022","dJobECdNm":"[9022]가축 사육 종사원","dJobJCd":"6132","dJobJCdNm":"[6132]가축 사육 종사원","dJobICd":"A012","dJobICdNm":"[A012]축산업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003876:1', '{"dJobCd":"K000003876","dJobCdSeq":"1","dJobNm":"토끼사육사","workSum":"고기를 얻기 위하여 토끼를 번식하고 사육한다.","doWork":"사육용 토끼를 준비한다. 번식지의 자연환경과 유사한 사육장을 설치한다. 토끼의 사육 및 번식을 위하여 먹이와 물을 주기적으로 공급한다. 난로 또는 보온장비를 사용하여 사육에 적합한 온도, 습도를 유지한다. 가벼운 질병 및 상처를 치료하고 번식을 위하여 발정징후가 나타나면 암수를 짝을 지워 준다. 전염병을 예방하기 위하여 축사를 방역하거나 청결히 하고 필요시 예방 접종을 한다. 새끼의 분만을 돕고 새끼를 돌본다. 최고의 성숙기에 출하한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"9022","dJobECdNm":"[9022]가축 사육 종사원","dJobJCd":"6132","dJobJCdNm":"[6132]가축 사육 종사원","dJobICd":"A012","dJobICdNm":"[A012]축산업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005535:1', '{"dJobCd":"K000005535","dJobCdSeq":"1","dJobNm":"가금부화작업원","workSum":"부화기에 알을 넣고 관리함으로써 닭, 오리 등의 가금을 부화한다.","doWork":"부화 전 종란을 크기별로 분류하고 검사하여 불량품을 제거한다. 종란을 부화기(발육기)의 배열판에 배열한다. 부화기의 각종 조절장치를 이용하여 온도, 습도, 환기 등의 조건을 조정한다. 부화기에 입란(알을 넣기) 후, 일주일이 지나면 입란을 검사하여 수정 여부를 확인하고 무수정란을 제거한다. 주기적으로 종란을 굴려주고 입란 후, 일정 기간이 지나면 발생지로 옮겨준다. 알에서 나오면 적당한 장소로 새끼를 옮기고 성별이나 등급을 확인할 수 있도록 준비한다. 세균오염을 방지하기 위하여 주기적으로 부화실 내를 소독하고 청소한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"수동조작","connectJob":"메추리인공부화장작업원, 병아리인공부화장작업원, 오리인공부화장작업원","dJobECd":"9029","dJobECdNm":"[9029]기타 사육 종사원","dJobJCd":"6139","dJobJCdNm":"[6139]기타 사육 관련 종사원","dJobICd":"A012","dJobICdNm":"[A012]축산업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005491:1', '{"dJobCd":"K000005491","dJobCdSeq":"1","dJobNm":"가금인공부화장관리원","workSum":"가금(고기나 알의 생산을 목적으로 사육되는 조류)의 종란을 부화하고, 부화된 병아리의 등급을 결정하여 암수를 구별하는 가금부화장을 관리한다.","doWork":"고객의 주문, 시장성 예측, 부화능력 등을 고려하여 부화 계획을 설정한다. 부화장의 작업에 대한 정책과 실행을 계획하고 수행한다. 가금을 소유한 회사로부터 공급 받아야 될 종란의 양을 설정하고 업체와 협의한다. 가금부화작업원에게 종란의 부화 및 분류, 예방접종, 부화된 병아리의 포장 및 수송, 부화장비 및 시설물의 유지와 같은 부화장 활동을 지시하고 조정한다. 부화기, 사료, 약과 같은 장비 및 공급물을 구입한다. 부화량, 부화된 병아리의 판매 등 부화 활동에 관련된 각종 장부 및 보고서를 작성한다. 사육업자와 부화된 병아리의 판매를 협의하고, 가금의 종류에 따라 따라야 할 위생관리에 대하여 알려준다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","connectJob":"메추리인공부화장관리원, 병아리인공부화장관리원, 오리인공부화장관리원","dJobECd":"9029","dJobECdNm":"[9029]기타 사육 종사원","dJobJCd":"6139","dJobJCdNm":"[6139]기타 사육 관련 종사원","dJobICd":"A012","dJobICdNm":"[A012]축산업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005591:1', '{"dJobCd":"K000005591","dJobCdSeq":"1","dJobNm":"곤충양식자","workSum":"식용 또는 낚시미끼, 물고기 및 동물의 먹이로 사용하기 위하여 각종 곤충을 양식한다.","doWork":"벌레의 특성에 적절한 성장매개물을 만들기 위하여 모래, 흙, 유기물 및 기타 영양소를 혼합한다. 혼합된 매개물을 양식통에 넣고, 물을 적당량 부어 일정 습도를 유지한다. 양식통에 성숙한 벌레를 집어넣고, 번식 및 양식을 위하여 매개물 위에 조제한 사료를 뿌려주고 가마니 또는 마대로 싸거나 덮어준다. 벌레의 최적 성장조건을 유지하기 위하여 주기적으로 온도, 습도를 검사하고 먹이를 주거나 물을 뿌려준다. 최대의 성장시기에 맞추어 벌레를 분류해 내기 위하여 체 또는 그물에 매개물을 삽으로 퍼 넣고 흔들어 분류한다. 판매용기에 분류한 일정량의 벌레를 담고 보존에 필요한 먹이를 넣고 포장한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"9029","dJobECdNm":"[9029]기타 사육 종사원","dJobJCd":"6139","dJobJCdNm":"[6139]기타 사육 관련 종사원","dJobICd":"A012","dJobICdNm":"[A012]축산업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005433:1', '{"dJobCd":"K000005433","dJobCdSeq":"1","dJobNm":"관상용조류사육사","workSum":"십자매, 잉꼬, 앵무새, 카나리아 등의 관상용 조류를 번식하고 사육한다.","doWork":"품종에 따라 새를 분류하여 적정 마리씩 새장에 넣는다. 모이통, 급수기, 둥지를 새장에 설치하고, 바닥에 모래 또는 흙을 깔아준다. 새의 종류에 따라 좁쌀, 벌레, 야채 등의 먹이를 공급해주고 주기적으로 물을 갈아준다. 벼룩, 빈대, 파리 등을 방제하기 위하여 소독제를 살포한다. 설사, 폐렴 등의 질병을 관찰하여 치료한다. 산란기에는 암수를 교배하도록 한다. 새끼 부화를 관찰하고 안정하도록 조치한다. 혈통, 사육일지를 기록한다. 새를 판매하기 위하여 구매자와 협의하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"고온|소음·진동|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"9029","dJobECdNm":"[9029]기타 사육 종사원","dJobJCd":"6139","dJobJCdNm":"[6139]기타 사육 관련 종사원","dJobICd":"A012","dJobICdNm":"[A012]축산업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002150:1', '{"dJobCd":"K000002150","dJobCdSeq":"1","dJobNm":"동물사육사","workSum":"동물원, 곡마단 등에서 호랑이, 코끼리, 원숭이, 새 등의 동물을 사육하고 관리한다.","doWork":"동물 사육장의 배설물을 치우고 물이나 소독약을 이용해 청소하여 청결상태를 유지한다. 동물의 습성을 파악하여 동물에 따라 일정한 간격으로 급식 및 급수한다. 동물의 변이나 움직임, 울음소리 등을 관찰하여 건강 상태를 파악한다. 이상이 있을 시 수의사에게 보고하며, 진료를 보조해 수의사를 도와준다. 동물 관람객의 행동을 감시하고, 질문이 있을 경우 동물에 대하여 설명해 준다. 동물시설물을 관리하거나 사파리 내의 동물에 대한 방사, 입사를 관리하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"수동조작","similarNm":"동물원사육사","connectJob":"육식동물사육사, 초식동물사육사, 포육사","dJobECd":"9029","dJobECdNm":"[9029]기타 사육 종사원","dJobJCd":"6139","dJobJCdNm":"[6139]기타 사육 관련 종사원","dJobICd":"R912","dJobICdNm":"[R912]유원지 및 기타 오락관련 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003161:1', '{"dJobCd":"K000003161","dJobCdSeq":"1","dJobNm":"말관리사","workSum":"조교사, 기수 또는 교관을 보조하여 경주용 또는 승마용 말을 사육·관리한다.","doWork":"마분 제거, 톱밥 또는 건초 교체 등 마방 청결을 위하여 마방을 관리하고, 마필에게 물과 먹이를 준다. 조교사 및 승마(경마)교관의 지시에 따라 마사 지역 내에서 말을 운동 및 훈련시킨다. 출주 및 승마 시 필요한 안장, 고삐 등의 장구를 채우기 위해 장안소로 출주 마필을 인도한다. 마필을 세척하고 솔로 닦는 수장작업을 한다. 마필의 상태를 파악하여 조교사에게 알리거나 조교사의 지시에 따라 마필수의위원에게 인도한다. 마필 장제를 위해 장제실에 의뢰하고 장제사를 보조한다. 창고 및 승마장 또는 경마장의 주변 환경을 정리한다. 각종 관련 장구를 손질한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"웅크림|","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"교육","workFunc3":"수동조작","certLic":"말조련사","dJobECd":"9029","dJobECdNm":"[9029]기타 사육 종사원","dJobJCd":"6139","dJobJCdNm":"[6139]기타 사육 관련 종사원","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002257:1', '{"dJobCd":"K000002257","dJobCdSeq":"1","dJobNm":"메추리사육사","workSum":"식용으로 알과 고기를 생산하기 위하여 메추리를 번식하고 사육한다.","doWork":"부화된 새끼들을 온도, 습도 및 환기가 적절하게 유지된 육추실에 일정 수씩 넣는다. 사료 적응훈련을 위해 일정 기간 동안 물에 사료를 개어주거나 새끼들을 위한 사료를 조제하여 물과 함께 공급한다. 일정 기간이 지나면 목 부분의 색깔을 관찰하여 암수를 구별한다. 산란실에 옮기기 전까지 건강하게 성장시키기 위하여 사료와 물을 충분히 공급하고 필요에 따라 영양제, 어분 등을 사료에 혼합하여 공급한다. 한 마리씩 산란실로 옮기면서 수컷이나 중성인 메추리를 분류하여 따로 사육한다. 전등 또는 난로, 환풍기 등을 사용하여 사육에 적당한 온도, 환기상태를 유지한다. 일정 시간마다 알을 걷고 파란(깨진 계란)을 골라낸다. 종란을 생산하기 위하여 건강한 암수를 일정 비율로 함께 사육한다. 일정 기간이 지나 산란능력이 떨어지면 폐조 처리시켜 고기로 이용한다. 전염병 또는 질병 예방을 위하여 주기적으로 육추실(育雛室:병아리를 기르는 방), 산란실, 장비, 시설물 등을 깨끗이 청소하고 소독한다. 부화기를 사용하여 종란을 부화하기도 한다. 알 및 고기를 판매하기 위하여 포장을 하기도 하며, 구매자와 협의하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"9029","dJobECdNm":"[9029]기타 사육 종사원","dJobJCd":"6139","dJobJCdNm":"[6139]기타 사육 관련 종사원","dJobICd":"A012","dJobICdNm":"[A012]축산업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001797:1', '{"dJobCd":"K000001797","dJobCdSeq":"1","dJobNm":"병아리감별사","workSum":"부화장에서 부화 직후 산란용 병아리의 성별을 감별한다.","doWork":"산란용 병아리를 부화 직후 감별대에 올려놓는다. 병아리를 잡는 법, 항문 까는 법, 항문돌기 형태 등의 감별기법을 확인한다. 병아리를 잡아 항문을 까고 비벼서 광택과 돌기의 형태를 구분하여 암수 성별을 식별하고 감별한다. 감별이 끝난 병아리를 분류하여 상자에 넣는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"관련없음","dJobECd":"9029","dJobECdNm":"[9029]기타 사육 종사원","dJobJCd":"6139","dJobJCdNm":"[6139]기타 사육 관련 종사원","dJobICd":"A012","dJobICdNm":"[A012]축산업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005414:1', '{"dJobCd":"K000005414","dJobCdSeq":"1","dJobNm":"사슴사육사","workSum":"낙용, 녹각, 녹혈 또는 녹육을 얻기 위하여 사슴을 번식하고 사육한다.","doWork":"햇쑥, 칡잎, 아카시아잎, 갈잎 등의 야생초를 채취하여 일정 기간 음지에서 건조시키고 이물질을 제거한다. 계절에 따라 녹사료(야생초)와 배합사료의 배합비율을 조정하여 일일 급여량 및 횟수를 정하여 급여한다. 급수통을 수시로 확인하고 물을 채워 넣는다. 사슴과 자주 접하여 질병이나 상처의 징후를 관찰한다. 가벼운 질병 및 외상을 치료하고 심한 질병 및 상처, 분만에 이상이 있을 때 수의사에게 치료를 요청하고 녹용을 절단한다. 절각작업을 돕기 위하여 사슴을 고정한다. 질병 예방을 위하여 주기적으로 소독제를 사용하여 사육장, 녹사, 기타 부대시설을 방역한다. 낙각시기, 절각예정, 교미일자, 분만일 등의 사육일지를 기록한다. 발정기에 종록을 분리 사육하고 분만 후 새끼를 돌본다. 사육장의 철망, 녹사 등을 보수한다. 겨울철 사료급여를 위하여 건초를 준비한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"웅크림|","workEnv":"위험내재|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"9029","dJobECdNm":"[9029]기타 사육 종사원","dJobJCd":"6139","dJobJCdNm":"[6139]기타 사육 관련 종사원","dJobICd":"A012","dJobICdNm":"[A012]축산업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005906:1', '{"dJobCd":"K000005906","dJobCdSeq":"1","dJobNm":"수렵장관리원","workSum":"꿩, 메추리, 멧돼지, 고라니 등의 수렵동물을 번식·사육·방사하는 수렵장을 관리한다.","doWork":"수렵동물의 번식 및 사육관리 계획을 수립하고 이행한다. 먹이 및 사료 공급, 알의 수집 및 부화, 울타리 및 사육장 청소, 건물 및 장비관리 등의 수렵장 운영계획을 세운다. 수렵장작업원들에게 작업을 분담하고 감독한다. 사육하는 수렵동물의 품종, 수량, 풀어놓는 장소 등을 기록한다. 수렵장 운영에 필요한 인원을 채용한다. 수렵동물의 먹이를 위한 식물의 경작지를 조성하고 관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"감독","workFunc3":"수동조작","dJobECd":"9029","dJobECdNm":"[9029]기타 사육 종사원","dJobJCd":"6139","dJobJCdNm":"[6139]기타 사육 관련 종사원","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003634:1', '{"dJobCd":"K000003634","dJobCdSeq":"1","dJobNm":"수렵장작업원","workSum":"수렵을 위한 동물 및 조류를 번식·사육·방사하고 수렵활동을 보조한다.","doWork":"수렵장에서 야생의 알을 수집하고 부화기를 사용하여 부화한다. 새장, 우리, 수렵장의 시설 및 장비를 수선하고 관리한다. 사육된 수렵동물을 수렵장으로 운반하여 방사한다. 엽총 등을 관리하고 엽견(사냥견)을 사육한다. 수렵인을 안내하여 수렵활동을 보조한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실외","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","dJobECd":"9029","dJobECdNm":"[9029]기타 사육 종사원","dJobJCd":"6139","dJobJCdNm":"[6139]기타 사육 관련 종사원","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006035:1', '{"dJobCd":"K000006035","dJobCdSeq":"1","dJobNm":"실험동물사육원","workSum":"실험에 사용할 개, 토끼, 다람쥐, 고양이, 쥐, 등을 번식하고 사육한다.","doWork":"정해진 시간에 먹이와 물을 준다. 사육장을 청소한다. 동물을 관찰하여 병이나 상처의 징후를 조사한다. 가벼운 질병이나 상처를 치료한다. 예방접종 또는 심한 질병 및 상처를 치료하기 위하여 수의사에게 알린다. 동물의 분만을 돕고 먹이를 조리한다. 동물들을 번식시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"수동조작","dJobECd":"9029","dJobECdNm":"[9029]기타 사육 종사원","dJobJCd":"6139","dJobJCdNm":"[6139]기타 사육 관련 종사원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006204:1', '{"dJobCd":"K000006204","dJobCdSeq":"1","dJobNm":"야생동물재활사","workSum":"조난 및 부상 당한 야생동물을 구조하고 재활훈련을 실시하여 야생으로 복귀시키며 야생생태계를 보호한다.","doWork":"마취총, 포획망, 그물, 운반장비 등을 이용하여 조난당한 야생동물을 구조한다. 부상 당한 동물의 경우 구조센터로 응급 이송한다. 구조된 동물의 상태에 따라 적합한 서식환경 및 먹이를 제공하고 다시 야생에 적응할 수 있도록 돕는다. 개체별 생태와 특성에 따라 재활훈련 및 야생적응 훈련을 실시하고 내용을 기록한다. 동물의 생태, 서식환경, 계절, 장소, 야생 적응상태 등을 고려하여 방사한다. 필요에 따라 개체인식표를 활용하여 야생으로 복귀한 야생동물 추적 및 야생적응상태를 모니터링한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"교육","workFunc3":"관련없음","similarNm":"야생동물재활관리사","dJobECd":"9029","dJobECdNm":"[9029]기타 사육 종사원","dJobJCd":"6139","dJobJCdNm":"[6139]기타 사육 관련 종사원","dJobICd":"A012","dJobICdNm":"[A012]축산업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005892:1', '{"dJobCd":"K000005892","dJobCdSeq":"1","dJobNm":"양봉원","workSum":"꿀, 로열젤리, 화분 및 밀납 등을 생산하기 위하여 벌을 기르고 번식한다.","doWork":"계절, 지리적 조건, 기후조건 등을 감안하여 이동계획을 세운다. 수동공구를 사용하여 벌통을 조립한다. 벌통의 벌집에 벌을 끌어들인다. 벌떼를 가두기 위하여 벌통 입구에 망사를 두른다. 꿀, 로열젤리, 화분, 밀납의 채취 및 농작물의 인공수분을 위하여 과수원, 아카시아나무, 유채꽃, 밤꽃 등이 밀집한 들판에 벌통을 설치하고 벌통에서 망사를 풀어 벌떼를 내보낸다. 일정 기간이 지난 후 벌통에서 벌집을 분리하여 빗자루로 벌을 털어내고 기존 벌집보다 큰 벌집을 잘라낸다. 분리된 벌집을 원심분리기에 고정하고 원심분리기를 회전시켜 꿀을 분리한다. 부저병 등의 꿀벌의 질병을 예방하기 위하여 벌집을 소독한다. 벌통은 소독용 약제로 훈증하여 진드기를 소독한다. 꽃이 개화되는 지역을 따라 벌통을 이동하고 벌통 및 기타 양봉장비를 관리·보수한다. 겨울철에는 양식을 확인하여 설탕물을 주고 볏짚, 스티로폼 등으로 벌통을 덮어 보온한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"양봉가, 양봉인","connectJob":"한봉원","dJobECd":"9029","dJobECdNm":"[9029]기타 사육 종사원","dJobJCd":"6139","dJobJCdNm":"[6139]기타 사육 관련 종사원","dJobICd":"A012","dJobICdNm":"[A012]축산업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001853:1', '{"dJobCd":"K000001853","dJobCdSeq":"1","dJobNm":"양잠작업원","workSum":"누에를 사육하기 위하여 잠실과 잠구를 소독하고, 우량형질의 종자를 받아 누에를 기르고, 고치를 따고, 견면을 제거하고 분류하여 판매한다.","doWork":"잠실의 먼지를 털고, 각종 오물을 청소한다. 잠구류를 잠실에 넣고 소독약을 골고루 살포하며 소독약제가 잠실 외부로 빠져나가지 못하도록 잠실을 밀폐하고 잠실을 가열하여 훈증 소독한다. 냉장 처리된 누에씨(소잠)를 필요한 만큼 구입한다. 알에서 개미누에로 만들기 위하여 소잠의 종류에 따라 부화조건을 조절한다. 누에의 나이에 알맞은 뽕을 선정하여 따고 누에가 먹기 좋은 크기로 뽕잎을 썰어 깔아준다. 뽕잎이 시들거나 뜨는 것을 방지하기 위하여 비닐 등으로 덮어 공기가 통하지 못하도록 하고 수시로 뽕잎을 뒤집어 준다. 누에의 크기에 따라 뽕잎을 주는 양과 횟수를 조절한다. 뽕찌꺼기, 누에똥 등의 불순물이 쌓이면 잠망을 올려놓고 뽕을 주어 누에가 잠망 위로 올라오면 잠망을 교체한다. 누에의 크기에 따라 누에자리를 넓혀 준다. 형질이 나쁜 누에는 골라서 버린다. 누에의 꼬리부분이 노랗게 변하고 주둥이가 뾰족해지고 먹이를 먹지 않으면 회전섶을 올려놓는다. 누에가 집을 짓는 것을 확인하고 집을 완성하면 회전섶에서 누에를 분리한다. 견면의 필요 없는 부분을 제거하고 고치상태를 보아 우량품과 불량품을 선별한다. 선별된 고치를 계량하여 수매한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"9029","dJobECdNm":"[9029]기타 사육 종사원","dJobJCd":"6139","dJobJCdNm":"[6139]기타 사육 관련 종사원","dJobICd":"A012","dJobICdNm":"[A012]축산업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005962:1', '{"dJobCd":"K000005962","dJobCdSeq":"1","dJobNm":"인공수정사","workSum":"가축이나 가금의 품종계량 및 번식을 위하여 발정기 암컷의 질에 채취된 정액을 주입하여 인공으로 수정한다.","doWork":"가축의 상태를 육안으로 관찰하여 발정기를 확인한다. 인공수정 전에 손을 직장에 넣어 난소 및 여포의 상태를 확인하여 수정에 적당한 시기를 확인한다. 정액이 보관되어 있는 액체 질소 통에서 선정된 정액을 꺼내 온수에 용해하여 정액주입기에 넣는다. 비누, 물 등을 사용하여 암컷의 성기를 깨끗이 닦고 정액주입기를 집어넣어 인공수정한다. 인공수정 후 발정주기를 관찰하여 수태 여부를 확인한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"가축인공수정사","connectJob":"닭인공수정사, 돼지인공수정사, 소인공수정사","certLic":"가축인공수정사","dJobECd":"9029","dJobECdNm":"[9029]기타 사육 종사원","dJobJCd":"6139","dJobJCdNm":"[6139]기타 사육 관련 종사원","dJobICd":"A012","dJobICdNm":"[A012]축산업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004617:1', '{"dJobCd":"K000004617","dJobCdSeq":"1","dJobNm":"잠종보호원","workSum":"채종한 잠종을 보호고에 넣어 일정 기간 냉장 보호하여 월동시킨 후 필요에 따라 사용할 수 있도록 보관한다.","doWork":"산란한 누에알을 일정 온도의 잠실에 일정 기간 잠박에 펼쳐 보호한다. 품종별로 잠종을 정리하여 잠종상자에 넣어 잠실이나 잠종보호고에 보관한다. 누에씨를 일정 기간 자연온도 상태로 방치한 후 누에씨를 씻어 음지에서 말려 잠종보호고에 보관한다. 누에치기에 적당한 시기가 되면 잠종의 품종이나 수량을 확인하여 포장하고 잠종 배부준비를 한다. 잠종을 인수·인계한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|","workEnv":"저온|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"-","connectJob":"-","certLic":"-","dJobECd":"9029","dJobECdNm":"[9029]기타 사육 종사원","dJobJCd":"6139","dJobJCdNm":"[6139]기타 사육 관련 종사원","dJobICd":"A012","dJobICdNm":"[A012]축산업","inqYear":"2017","etc":"잠종 생산원 직업으로 통합"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003022:1', '{"dJobCd":"K000003022","dJobCdSeq":"1","dJobNm":"잠종생산원","workSum":"고유한 성상과 형질을 보존하고 있는 우량한 잠종을 생산하고 농가에 보급한다.","doWork":"우량한 잠종의 고유한 성상과 형질을 보존하고 있는 원원잠종을 관리한다. 우량한 잠종 간의 교잡을 통하여 우량한 잠종을 생산한다. 씨고치를 준비하여 작업대에 올려놓고 우량한 상태의 씨고치를 골라 나방이 고치를 쉽게 뚫고 나올 수 있도록 고치의 일부를 잘라준다. 도태 등 불량한 고치를 골라내고 번데기의 암수를 감별한 후, 품종별, 성별에 따라 격리시켜 보호한다. 수나방이 암나방보다 먼저 나오게 되므로 암수나방 이동 시에 나오게끔 조절하고 필요시 꺼내어 암나방과 교미시킨다. 다른 품종과의 혼합을 방지하기 위하여 품종에 따라 서로 다른 색상을 칠하여 구분한다. 교배형식에 따라 품별로 교미시켜 우량한 잠종을 생산하고 생산된 잠종은 검사 후 정리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"9029","dJobECdNm":"[9029]기타 사육 종사원","dJobJCd":"6139","dJobJCdNm":"[6139]기타 사육 관련 종사원","dJobICd":"A012","dJobICdNm":"[A012]축산업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003692:1', '{"dJobCd":"K000003692","dJobCdSeq":"1","dJobNm":"장제사","workSum":"말의 용도, 말굽 형태, 말굽 질환 등에 따라 편자를 제작하거나 편자를 선정하여 말굽에 장착한다.","doWork":"말의 소유주나 조련사로부터 의뢰받은 말의 지세(肢勢), 굽 형태, 편자상태를 점검한다. 말의 굽 상태 등을 고려하여 편자를 제작하거나 기성 편자들 중에 한 세트를 선택한다. 편자를 장착하기 위해 말굽을 깎고 편자를 수정·접합하고, 수정, 접합된 편자를 장제못과 못망치를 사용하여 말굽에 편자를 고정시킨다. 때에 따라 말굽에 질환이 있을 경우 수의사와 협의하여 치료장제를 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"장제사(1급, 2급, 3급)","dJobECd":"9029","dJobECdNm":"[9029]기타 사육 종사원","dJobJCd":"6139","dJobJCdNm":"[6139]기타 사육 관련 종사원","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001755:1', '{"dJobCd":"K000001755","dJobCdSeq":"1","dJobNm":"목재등급평가사","workSum":"일반용재, 구조용재, 수장용재 등 각종 제재목의 품질을 검사하고 등급을 평가한다.","doWork":"검사할 목재의 종류 및 수종(침엽수, 활엽수 등)을 토대로 검사기준을 확인한다. 육안 또는 측정자를 사용하여 옹이, 옹이구멍, 둥근모, 할렬(재면의 갈라짐, 터짐), 윤활, 굽음, 표준치수, 평균연륜폭, 섬유주행경사, 기타 결점을 검사한다. 함수율측정기, 다이얼게이지 등을 사용하여 함수율, 휨탄성계수를 측정한다. 구조용재(건물의 구조재로 사용되는 목재), 일반용재(설계 값이 필요하지 않은 일반적인 용도에 사용되는 제재목 또는 포장용 목재 및 데크용 목재), 수장용재(건축물 안에 사용되는 목재) 등 관련 품질규정에 따라 검사결과를 기록하고 등급을 구분한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"시각|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"목재등급평가사","dJobECd":"9031","dJobECdNm":"[9031]조림∙산림경영인 및 벌목원","dJobJCd":"6201","dJobJCdNm":"[6201]조림·산림경영인 및 벌목원","dJobICd":"A020","dJobICdNm":"[A020]임업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007384:1', '{"dJobCd":"K000007384","dJobCdSeq":"1","dJobNm":"목재수확계획원","workSum":"목재수확을 위한 도로건설, 목재수확기계설치, 장비 및 구조물 등 벌목 및 목재운반계획을 수립하고 실행한다.","doWork":"목재수확작업이 행해지는 산림지역을 측량하고 지형적인 특성을 나타내는 지도를 작성한다. 목재적재기 종류와 목재적재구역을 결정하고 목재 취급방법과 사용기구를 결정한다. 목재수확지역에서 적재지역이나 보관구역까지 운반하는 데 이용되는 도로(작업로, 운반로)건설을 계획하고 설계한다. 각 목재수확지역으로부터 목재를 안전하고 효과적으로 운반할 수 있도록 필요한 준비를 계획한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"9031","dJobECdNm":"[9031]조림∙산림경영인 및 벌목원","dJobJCd":"6201","dJobJCdNm":"[6201]조림·산림경영인 및 벌목원","dJobICd":"A020","dJobICdNm":"[A020]임업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006656:1', '{"dJobCd":"K000006656","dJobCdSeq":"1","dJobNm":"목재수확조사원","workSum":"목재수확작업에 따른 각종 법규 및 안전관리의 준수 여부와 목재수확작업 후 산림지역 내의 산림손실을 방지하기 위하여 목재수확작업의 전 과정을 조사하고 감시한다.","doWork":"산림지역 내의 수목을 벌채해도 산림에 피해가 없는지 현장을 답사하여 조사하고 보고서를 작성한다. 목재수확 후 산림보호를 위한 처리작업, 목재수확현장의 위생상태, 목재수확지정구역, 안전수칙의 준수 여부를 알아보기 위하여 목재수확구역을 조사한다. 목재수확허가 시의 계약조항, 화재예방, 안전규제법에 따라 작업이 행해지는지 조사하고 위반사항이 발견되면 시정하도록 통보하고 수정 여부를 확인한다. 목재수확작업에 대한 방법, 능률, 진척상황에 대한 보고서를 작성한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|시각|","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"벌목감시원","dJobECd":"9031","dJobECdNm":"[9031]조림∙산림경영인 및 벌목원","dJobJCd":"6201","dJobJCdNm":"[6201]조림·산림경영인 및 벌목원","dJobICd":"A020","dJobICdNm":"[A020]임업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003858:1', '{"dJobCd":"K000003858","dJobCdSeq":"1","dJobNm":"목재측정원","workSum":"원목이나 펄프용 목재의 시장공급 가능량을 측정하기 위하여 목재의 크기와 적하를 측정한다.","doWork":"측정자, 줄자 및 기타 측정장치 등으로 각 원목의 크기와 펄프용 목재의 전체 적하를 측정한다. 원목이나 펄프용 목재에서 부패 및 기타 결함을 조사하고, 총부피에서 견적된 폐물을 빼고 결과를 기록한다. 선적인에게 반송을 위하여 표준 이하나 특별한 등급의 원목을 확인하고 분류한다. 하역 전·후 나무의 부피를 측정, 부피 데이터와 공급자를 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"시각|","workFunc1":"계산","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"통나무측정원","connectJob":"갑판측정원, 연못측정원, 하역지측정원, 펄프용목재측정원","dJobECd":"9031","dJobECdNm":"[9031]조림∙산림경영인 및 벌목원","dJobJCd":"6201","dJobJCdNm":"[6201]조림·산림경영인 및 벌목원","dJobICd":"A020","dJobICdNm":"[A020]임업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003568:1', '{"dJobCd":"K000003568","dJobCdSeq":"1","dJobNm":"무육관리원","workSum":"식재된 수목을 우량한 형질의 임목으로 키우기 위하여 산림 내의 수목에 비료를 주고, 풀베기, 솎아베기, 덩쿨제거, 가지치기 등의 작업계획을 수립하고 작업원을 동원하여 실행한다.","doWork":"산림 내의 임목을 경제성 있는 양질의 목재로 육성하기 위하여 작업계획을 수립한다. 작업원을 동원하여 벌채하기 전까지 산지에서 비료를 주고, 임목 주위의 풀을 베고, 솎아주고, 덩쿨을 제거하고, 임목의 원활한 생장을 위하여 가지를 친다. 작업 후 결과를 조사·분석한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"수동조작","dJobECd":"9031","dJobECdNm":"[9031]조림∙산림경영인 및 벌목원","dJobJCd":"6201","dJobJCdNm":"[6201]조림·산림경영인 및 벌목원","dJobICd":"A020","dJobICdNm":"[A020]임업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001452:1', '{"dJobCd":"K000001452","dJobCdSeq":"1","dJobNm":"벌목원","workSum":"나무를 각종 동력톱이나 도끼 등의 벌목도구를 사용하여 벌목한다.","doWork":"입목상태의 원목을 관찰하여 비틀림, 부패부분, 가지 등의 특성에 따라 자를 위치를 결정한다. 나무를 쓰러뜨릴 방향을 결정하고 톱과 도끼 등을 사용하여 나무를 자른다. 넘어진 나무의 가지를 도끼, 기계톱 등을 사용하여 정리한다. 나무를 규정된 크기로 절단한다. 원목조재에 필요한 톱, 낫, 도끼 등을 손질하고 수리한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"힘든 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"벌목공, 벌목부, 목재수확원","connectJob":"벌목노무자","certLic":"산림기능사","dJobECd":"9031","dJobECdNm":"[9031]조림∙산림경영인 및 벌목원","dJobJCd":"6201","dJobJCdNm":"[6201]조림·산림경영인 및 벌목원","dJobICd":"A020","dJobICdNm":"[A020]임업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005779:1', '{"dJobCd":"K000005779","dJobCdSeq":"1","dJobNm":"벌초원","workSum":"산림 내 임목의 성장을 촉진하고 파종했거나 식재된 묘목이 잡초, 관목, 덩쿨 등으로 피해 입는 것을 방지하기 위하여 주위를 벌초한다.","doWork":"통풍이 잘되고 일조 시간이 많아져서 동화작용 및 증산작용이 촉진되어 치묘가 건전하게 생육될 수 있도록 낫이나 동력식 기계를 사용하여 묘목 주위의 잡목 및 풀을 깎아준다. 우량목 생산을 위하여 죽어 넘어진 나무를 제거한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","dJobECd":"9031","dJobECdNm":"[9031]조림∙산림경영인 및 벌목원","dJobJCd":"6201","dJobJCdNm":"[6201]조림·산림경영인 및 벌목원","dJobICd":"A020","dJobICdNm":"[A020]임업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;