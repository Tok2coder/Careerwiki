INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003294:1', '{"dJobCd":"K000003294","dJobCdSeq":"1","dJobNm":"식물원관리자","workSum":"식물원 운영을 총괄하고, 관련 종사원들의 활동을 감독·조정한다.","doWork":"식물원에서 서식하는 각종 식물의 종류 및 수량 등을 점검한다. 식물재배와 관람에 관한 계획을 조정한다. 관리, 회계, 조사 등에 종사하는 작업원들의 활동을 감독한다. 희귀식물에 대한 자료를 수집·정리하여 조사 및 연구를 지시한다. 대외적인 회의에서 기관을 대표하여 의견을 제시한다. 식물에 관한 조사·연구활동을 수행하기도 한다. 여가 및 관광명소로 운영하기 위한 계획을 시행하고, 행사 및 이벤트 계획 수립을 운영한다. 지역사회 연계, 국내외 식물원 및 수목원 네트워크 형성 및 교류한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"식물원장","dJobECd":"0136","dJobECdNm":"[0136]예술·디자인·방송 관리자","dJobJCd":"1340","dJobJCdNm":"[1340]문화·예술 관련 관리자","dJobICd":"R902","dJobICdNm":"[R902]도서관, 사적지 및 유사 여가관련 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002974:1', '{"dJobCd":"K000002974","dJobCdSeq":"1","dJobNm":"신문제작국장","workSum":"편집된 신문기사 및 광고를 지면에 인쇄하는 작업원들의 활동을 관리·감독한다.","doWork":"신문발행에 따른 제작방침 및 인쇄계획을 수립하여 관련 부서에 전달한다. 제작공정에 관한 전반적인 업무사항을 지휘·감독한다. 신문제작에 따른 생산공정, 안전사항, 인사 등에 관한 총체적인 관리업무를 수행한다. 각 지사 및 외주제작업체의 신문인쇄 활동을 지휘·총괄한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0136","dJobECdNm":"[0136]예술·디자인·방송 관리자","dJobJCd":"1340","dJobJCdNm":"[1340]문화·예술 관련 관리자","dJobICd":"J581","dJobICdNm":"[J581]서적, 잡지 및 기타 인쇄물 출판업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006348:1', '{"dJobCd":"K000006348","dJobCdSeq":"1","dJobNm":"연극제작자","workSum":"연극을 공연하기 위하여 제작비를 투자하며 작품, 배우, 연극연출가 등을 섭외하고 공연일정을 계획한다.","doWork":"새로운 작품의 원고를 검토하여 작품을 선정한다. 작품의 공연에 적합한 연극연출가를 선정하고 배우 섭외, 스태프 구성, 제작지원 등에 관한 사항을 협의한다. 작품의 연습 및 공연에 따른 운영예산과 제작계획을 수립한다. 공연내용을 검토하고 연극연출가와 협의하여 내용을 변경하거나 수정한다. 제작비의 손익을 고려하여 공연할 극장 및 공연기간을 결정한다. 연극제작발표회를 주관하기도 한다. 예매처 관리하고, 온, 오프라인 프로모션의 일정을 세운다. 유료인원 대비 초대인원의 비율을 계산해 객석 점유율을 확인한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0136","dJobECdNm":"[0136]예술·디자인·방송 관리자","dJobJCd":"1340","dJobJCdNm":"[1340]문화·예술 관련 관리자","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005995:1', '{"dJobCd":"K000005995","dJobCdSeq":"1","dJobNm":"영화배급관리자","workSum":"영화수입사 또는 영화제작사로부터 구입한 필름이 영화관에서 상영되기까지의 제반 업무(심의, 자막, 홍보, 배급)를 수행한다.","doWork":"영화 판권계약(1차 판권)에 의해 영화수입사 또는 제작사로부터 배급할 영화파일(하드디스크)을 수령한다. 영화자막 작업을 의뢰하고 영화심의를 받는다. 영화홍보회사에 예고편 제작, 포스터 제작, 영화홍보를 의뢰하고 관리한다. 극장의 규모, 지역, 관객 수 등을 고려하여 상영기간, 배급금액을 각 사업주와 협의하여 결정한다. 각 상영관에 영화필름과 영화데이터(CD, DVD)를 배급한다. 영화의 상영이 종료되면 TV방영, DVD제작, 해외배급 등 2차 판권계약을 한다. 영화를 기초로 만들어지는 저작물에 대한 계약 및 관리를 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","connectJob":"국내배급관리자, 해외배급관리자","dJobECd":"0136","dJobECdNm":"[0136]예술·디자인·방송 관리자","dJobJCd":"1340","dJobJCdNm":"[1340]문화·예술 관련 관리자","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005122:1', '{"dJobCd":"K000005122","dJobCdSeq":"1","dJobNm":"영화제작자","workSum":"영화 제작을 위해 시나리오, 영화감독 등을 선정하고, 제작비 투자 및 사용, 상영극장 섭외 등 제작 및 영화상영에 관한 업무 전반을 총괄한다.","doWork":"각종 소설 또는 대본(시나리오)을 검토하여 흥행에 성공할 수 있는 작품을 선정한다. 작품에 적합한 영화감독과 제작진을 선정하고 출연 배우, 제작일정 등을 협의한다. 일일 제작상황을 검토하고 촬영영상을 영화감독과 협의한다. 완성된 영화의 시사회를 개최하고 개봉일 및 극장상영 일정을 확정한다. 각 매체를 통한 영화의 홍보계획을 수립한다. 영화제작, 홍보, 상영에 필요한 제반 비용을 지원한다. 경우에 따라 영화감독이 제작자를 겸하기도 한다. 투자자에게 제작비를 투자받기도 한다. 영화의 협찬, PPL 관리, 해외 영화제 및 영업을 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"영화프로듀서","connectJob":"방송제작자","dJobECd":"0136","dJobECdNm":"[0136]예술·디자인·방송 관리자","dJobJCd":"1340","dJobJCdNm":"[1340]문화·예술 관련 관리자","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005985:1', '{"dJobCd":"K000005985","dJobCdSeq":"1","dJobNm":"자동차디자인관리자","workSum":"자동차디자인의 개발업무 전반을 관장하며, 자동차디자이너들을 지휘·감독한다.","doWork":"디자인기획을 위해 경쟁차종을 분석하고 모터쇼 등을 통해 국제적인 디자인 동향을 분석한다. 소비자의 구매경향을 분석하여 이미지맵을 제작하고 스타일링 포지셔닝 맵을 제작하고 분석하여 디자인 기획안을 수립한다. 내장과 외장에 쓰일 각종 재질의 색상, 질감 등을 고려하여 자동차의 차종과 크기, 색상 등 자동차 외장디자인을 결정한다. 자동차 내부의 색상, 재료, 부자재의 위치 등과 관련된 자동차 내장디자인을 결정한다. 디자인 후 시제품의 생산(엔진 등 제외)샘플을 검토한다. 디자인된 자동차의 내외장 형상에 자동차 내부의 엔진이나 기타 전기전자 장치가 적절하게 배치될 수 있도록 엔지니어부문과 디자인부문을 조율한다. 자동차디자인을 위한 각종 자료조사 및 기획 등의 업무를 관장한다. 자동차 내·외장디자이너, 자동차재료디자이너 등에게 업무를 지시하며, 일정을 조정하고 감독한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","certLic":"제품디자인기술사, 제품디자인기사, 제품디자인산업기사","dJobECd":"0136","dJobECdNm":"[0136]예술·디자인·방송 관리자","dJobJCd":"1340","dJobJCdNm":"[1340]문화·예술 관련 관리자","dJobICd":"M732","dJobICdNm":"[M732]전문 디자인업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004766:1', '{"dJobCd":"K000004766","dJobCdSeq":"1","dJobNm":"취재관리자","workSum":"방송국, 신문사, 잡지사 등에서 기사 취재 업무를 총괄하고, 취재기자들의 활동을 감독·조정한다.","doWork":"방송, 신문, 잡지 등에 보도할 기사를 취득하기 위해 공공기관, 단체 등의 동향 및 사회적 관심사를 분석한다. 취재기자에게 취재범위를 할당한다. 프로그램 신설, 특집보도 등을 위한 아이디어를 구상한다. 제작활동을 조정하고 보도할 내용의 순서를 협의하여 보도 우선권을 결정한다. 취재기자의 기사작성 및 편집활동을 지휘·감독한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"취재국장","dJobECd":"0136","dJobECdNm":"[0136]예술·디자인·방송 관리자","dJobJCd":"1340","dJobJCdNm":"[1340]문화·예술 관련 관리자","dJobICd":"J601/J602","dJobICdNm":"[J601]라디오 방송업 / [J602]텔레비전 방송업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004566:1', '{"dJobCd":"K000004566","dJobCdSeq":"1","dJobNm":"인터넷데이터센터관리자","workSum":"IDC(인터넷데이터센터)의 운영을 총괄하고, 직원들의 활동을 감독·조정한다.","doWork":"인터넷데이터센터(IDC:Internet Data Center, 기업의 전산시설을 위탁 관리하는 곳. 일명 서버호텔)의 네트워크 시설운용 및 유지보수 상황을 보고 받고 지시한다. 보안시스템의 운용상황 및 유지보수 상황을 감독한다. 고객 회선 개통 및 입주시설의 감시와 관리를 한다. 네트워크 트래픽 분석 보고에 따른 대책을 수립하여 지시한다. IDC센터 직원에 대한 교육을 실시한다. 견학, 상담, 컨설팅 등 방문자에 대한 응대를 한다. 부대시설에 대한 총괄적 관리를 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","certLic":"정보통신기사, 정보통신산업기사","dJobECd":"0137","dJobECdNm":"[0137]정보통신 관리자","dJobJCd":"1350","dJobJCdNm":"[1350]정보 통신 관련 관리자","dJobICd":"J631","dJobICdNm":"[J631]자료처리, 호스팅, 포털 및 기타 인터넷 정보매개 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001669:1', '{"dJobCd":"K000001669","dJobCdSeq":"1","dJobNm":"전보송수신관리자","workSum":"전보 송·수신 업무를 총괄하고, 관련 직원들의 활동을 감독·조정한다.","doWork":"인터넷, FAX, 핸드폰, 일반전화를 통해 전보가 접수될 수 있도록 기획하고 운영한다. 국내전보, 국제전보, 선물전보, 일반전보, 기업전보 등 전보상품을 개발하고 운영 및 관리한다. 전보배달 및 부가상품 협력업체를 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0137","dJobECdNm":"[0137]정보통신 관리자","dJobJCd":"1350","dJobJCdNm":"[1350]정보 통신 관련 관리자","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003270:1', '{"dJobCd":"K000003270","dJobCdSeq":"1","dJobNm":"전산부서관리자","workSum":"전산자료처리부서의 제반 업무를 계획·총괄하고, 관련 직원들의 활동을 지휘·감독한다.","doWork":"사업계획에 따라 구체적인 사업의 한계 영역과 우선 순위를 결정한다. 전산장비의 구입에 관한 사항을 협의한다. 경영주 또는 기술진의 특정 정보에 대한 요구사항을 검토한다. 컴퓨터체제의 작동시간 할당 등을 결정하기 위해 경영진과 협의한다. 프로젝트의 성격을 규정하고 상호 간의 협조를 증진시키기 위해 관련 부서장과 협의한다. 사업계획의 가능성에 대한 연구보고서를 검토한다. 조직체의 정책과 목표에 대하여 직원들에게 시달한다. 경영진에게 계획의 진척사항과 예정목표로부터의 미달에 관한 보고서를 작성·보고한다. 새로운 프로그램 검증과 운영체제를 도입하기 위하여 컴퓨터 운영계획을 조정한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0137","dJobECdNm":"[0137]정보통신 관리자","dJobJCd":"1350","dJobJCdNm":"[1350]정보 통신 관련 관리자","dJobICd":"J631","dJobICdNm":"[J631]자료처리, 호스팅, 포털 및 기타 인터넷 정보매개 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004562:1', '{"dJobCd":"K000004562","dJobCdSeq":"1","dJobNm":"전화국장","workSum":"구역 내의 전신·전화업무를 총괄한다.","doWork":"전화 가입, 전화번호 안내, 국제전화, 전화요금의 수납, 지역·시간·계절별 통화량조사, 기계 및 선로의 유지·보수 등 전화국의 제반 업무를 총괄한다. 운영방침을 결정하고 직원들을 감독한다. 다양한 업무의 부서를 조정한다. 직원의 복무배치, 새로운 장비의 도입·설치를 승인한다. 재무회계 및 기록의 정확성과 완전성을 판단하기 위해서 대차대조표를 확인한다. 전화국 운영에 필요한 일상적 업무를 관장한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0137","dJobECdNm":"[0137]정보통신 관리자","dJobJCd":"1350","dJobJCdNm":"[1350]정보 통신 관련 관리자","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005877:1', '{"dJobCd":"K000005877","dJobCdSeq":"1","dJobNm":"철도통신설비관리자","workSum":"통신시설의 유지·보수 및 공사의 시공감독과 기타 부대업무를 총괄하고, 소속 직원을 지휘·감독한다.","doWork":"통신선로 및 전송설비를 포함한 통신설비의 유지·보수 및 개량에 관한 계획을 수립하고 관리한다. 공사의 설계·시공감독 및 공정관리와 기타 부대업무를 수행한다. 통계의 작성과 도면·대장의 관리 및 기술지도를 한다. 사고·장애처리와 원인분석 및 통계자료 작성, 청원시설, 기술지도교육에 관한 업무를 한다. 통신설비의 기술업무를 총괄한다. 소속 직원을 지휘·감독한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내·외","workEnv":"위험내재|","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","certLic":"통신선로기사","dJobECd":"0137","dJobECdNm":"[0137]정보통신 관리자","dJobJCd":"1350","dJobJCdNm":"[1350]정보 통신 관련 관리자","dJobICd":"H491","dJobICdNm":"[H491]철도 운송업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006838:1', '{"dJobCd":"K000006838","dJobCdSeq":"1","dJobNm":"컴퓨터소프트웨어개발관리자","workSum":"컴퓨터소프트웨어를 개발하고 테스트 검증하는 전 과정을 관리한다.","doWork":"프로젝트 개발 요구사항을 접수하고 관리한다. 개발 범위, 개발 일정 및 프로세스 수립 등 소프트웨어개발 전 과정을 관리한다. 프로젝트 산출물 제작 관리 및 승인 업무를 수행한다.  진행상황을 모니터링하고 개발 과정 상 이슈를 관리한다. 품질 관리 정책 수립 및 품질 지표 수준을 정의하여 품질관리 체계를 구축한다. 소프트웨어 개발 품질을 검증한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"제어조작","dJobECd":"0137","dJobECdNm":"[0137]정보통신 관리자","dJobJCd":"1350","dJobJCdNm":"[1350]정보 통신 관련 관리자","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006839:1', '{"dJobCd":"K000006839","dJobCdSeq":"1","dJobNm":"컴퓨터운영관리자","workSum":"컴퓨터 및 네트워크를 운영하기 위해 관련 하드웨어·소프트웨어 등의 컴퓨터 시스템을 관리한다.","doWork":"컴퓨터 시스템에 대한 운영과 관리지침을 마련한다. 컴퓨터 정보 시스템을 안전하고 체계적으로 운영관리하고 사용자들에게 각종 서비스를 제공한다. 온도, 습도, 분진 등 외부환경을 확인하고 시스템 장비의 외부환경을 적정 수준으로 유지한다. 사용자에 대한 등록관리와 사용권한을 부여하여, 시스템 내의 정보를 외부로부터 보호하기 위해 기술적 장치를 마련하고 정기적으로 데이터를 백업한다. 시스템 운영상의 문제점이나 고장이 발생하면, 즉시 원인을 파악하여 시스템을 복구한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"제어조작","similarNm":"시스템관리자, 네트워크관리자, 컴퓨터시스템관리자, 홈페이지관리자, 웹서버관리자","dJobECd":"0137","dJobECdNm":"[0137]정보통신 관리자","dJobJCd":"1350","dJobJCdNm":"[1350]정보 통신 관련 관리자","dJobICd":"J620","dJobICdNm":"[J620]컴퓨터 프로그래밍, 시스템 통합 및 관리업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006840:1', '{"dJobCd":"K000006840","dJobCdSeq":"1","dJobNm":"컴퓨터하드웨어개발관리자","workSum":"컴퓨터하드웨어 시스템을 설계하고 설치 테스트하는 전 과정을 관리한다.","doWork":"컴퓨터 시스템, 주변 장치 및 액세서리 장치 등 컴퓨터하드웨어를 개발하기 위한 기술 및 서비스를 기획한다. 개발 요구사항의 타당성을 검토한다. 시스템 구성 설계와 설치 및 테스트 업무의 원활한 진행을 위한 개발환경을 조성한다. 대내외 활동 지원 및 일정 등을 조율한다. 개발에 따른 데이터를 관리하고 분석한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"제어조작","dJobECd":"0137","dJobECdNm":"[0137]정보통신 관리자","dJobJCd":"1350","dJobJCdNm":"[1350]정보 통신 관련 관리자","dJobICd":"C263","dJobICdNm":"[C263]컴퓨터 및 주변장치 제조업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007044:1', '{"dJobCd":"K000007044","dJobCdSeq":"1","dJobNm":"통신관리자","workSum":"정보통신 또는 전산 부서의 종사자들을 지휘·감독하고 경영주 또는 기술진의 특정한 정보 요구사항을 검토하여 프로젝트의 성격을 규정한다.","doWork":"정보통신 설계, 시공 및 시스템 유지보수, 성능개선, SI 설계 등 통신 관련 업무를 총괄한다. 지역 범위내의 통신량과 흐름을 지휘하고 관리하며, 통신설치, 운영 및 관리 서비스를 분석하고 평가하며 개선안을 낸다. 정보시스템 및 전산운영 부서와 사업체의 운영을 기획, 지시한다. 전자 자료처리와 컴퓨터시스템 운영 및 개발을 위한 기준을 수립하고 작업을 평가한다. 자료처리, 시스템 요건 및 명세사항을 사용자와 협의한다. 인력 채용, 훈련 및 업무수행을 감독한다. 새로운 프로그램 검증과 운영체제를 도입하기 위하여 컴퓨터 운영 계획 및 전산장비의 구입에 관한 사항을 협의하고 조정한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"제어조작","similarNm":"정보통신관리자","dJobECd":"0137","dJobECdNm":"[0137]정보통신 관리자","dJobJCd":"1350","dJobJCdNm":"[1350]정보 통신 관련 관리자","dJobICd":"J620","dJobICdNm":"[J620]컴퓨터 프로그래밍, 시스템 통합 및 관리업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002064:1', '{"dJobCd":"K000002064","dJobCdSeq":"1","dJobNm":"부동산관리자","workSum":"각종 부동산의 용지개발, 분양, 임대, 시설물관리 등의 업무에 관련된 계획을 수립하고, 종사원들의 활동을 지휘·감독하는 업무를 수행한다.","doWork":"주택재건축사업, 주택재개발사업, 도시환경정비사업 등을 시행하고자 하는 추진위원회나 조합 등 사업시행자의 업무를 대행·지원하는 업무를 관리한다. 부동산 개발을 위한 부동산 상품 기획, 용지구입, 인허가 절차 진행, 자금마련 등의 업무를 관리한다. 재개발, 재건축 등으로 건축된 주택 또는 아파트를 분양하거나 수금업무를 관리한다. 부동산 임대를 위해 적정 임대료 산정, 임차인 모집 및 계약, 기존 임차인에 대한 임대료 징수 업무를 관리한다. 부동산시설물에 대한 하자신고 접수, 수리 또는 보수를 위한 필요인력 선임 및 감독, 보수실태 관리 등의 업무를 한다. 부동산의 개발, 분양, 임대와 시설관리업무를 담당하는 종사원들로부터 업무진행상황을 보고 받으며, 종사원들의 활동을 지휘·감독한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","connectJob":"정비사업관리자, 부동산개발업관리자, 부동산분양관리자, 주택분양관리자, 부동산임대관리자, 부동산시설물관리자","dJobECd":"0139","dJobECdNm":"[0139]부동산·조사·인력알선 및 기타 전문서비스 관리자","dJobJCd":"1390","dJobJCdNm":"[1390]기타 전문 서비스 관리자","dJobICd":"L681","dJobICdNm":"[L681]부동산 임대 및 공급업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002744:1', '{"dJobCd":"K000002744","dJobCdSeq":"1","dJobNm":"연예인총괄관리자","workSum":"드라마나 영화, 광고물제작 등의 원활한 지원을 위해 출연자 혹은 보조출연자를 선별하여 관리하고 적합한 출연자나 보조출연자를 제공하는 등의 업무를 총괄 관리한다.","doWork":"방송제작, 영화제작, 광고물제작 등 제작사로부터 출연자나 보조출연자의 공급을 의뢰받는다. 제작사의 목적과 특성에 맞는 출연자나 보조출연자를 파악·선발하여 공급한다. 소속 연예인에 대한 계약, 일정관리, 노래·연기·춤 지도 및 교육 등의 업무를 총괄한다. 배우나 가수를 지망하는 연습생을 선발하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0139","dJobECdNm":"[0139]부동산·조사·인력알선 및 기타 전문서비스 관리자","dJobJCd":"1390","dJobJCdNm":"[1390]기타 전문 서비스 관리자","dJobICd":"M739","dJobICdNm":"[M739]그 외 기타 전문, 과학 및 기술 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005050:1', '{"dJobCd":"K000005050","dJobCdSeq":"1","dJobNm":"의상모델총괄관리자","workSum":"의상모델을 교육·관리하며, 패션쇼 진행을 총괄 관리한다.","doWork":"의상모델을 선발하여 교육한다. 의상모델에게 무대워킹, 무대화장법(메이크업), 무대머리모양손질법(무대헤어스타일링), 감정표현기법, 소품 치장법(액세서리 착용법) 등에 대한 총괄 지도를 한다. 의상디자이너나 의류전문회사의 행사 요청에 의해 행사시간, 행사장소, 행사목적, 행사규모에 맞는 진행 등 총괄 관장한다. 무대의 조명, 음악, 디자인, 효과 및 특수효과(꽃가루, 연무분사장치 : Fog Machine) 등에 대한 총괄 관리를 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0139","dJobECdNm":"[0139]부동산·조사·인력알선 및 기타 전문서비스 관리자","dJobJCd":"1390","dJobJCdNm":"[1390]기타 전문 서비스 관리자","dJobICd":"M739","dJobICdNm":"[M739]그 외 기타 전문, 과학 및 기술 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004876:1', '{"dJobCd":"K000004876","dJobCdSeq":"1","dJobNm":"인력파견관리자","workSum":"사용주의 요청에 따라 필요인력을 모집·공급·관리하고, 직무교육을 기획한다.","doWork":"사용주의 요청이 있을 시 면접을 통해 신규 파견자를 선발하거나 기존 직원의 파견 여부를 검토한다. 조건에 적합한 직원에 대하여 사용주와의 면접을 주선하고 임금 등의 계약 조건을 협상한다. 선발된 합격자들에게 계약 조건에 따라 설명하고 근로계약서, 파견통지서와 같은 서류를 작성하고 관리한다. 파견희망자를 수시로 모집하고 직원들의 자료를 관리한다. 파견근로자의 급여 관리를 하며 각종 교육을 실시하기도 한다. 사용주와 거래업체에 관한 자료를 수집하고 관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"협의","workFunc3":"관련없음","similarNm":"인력공급부서관리자, 인재파견부서관리자","certLic":"직업상담사(1급, 2급)","dJobECd":"0139","dJobECdNm":"[0139]부동산·조사·인력알선 및 기타 전문서비스 관리자","dJobJCd":"1390","dJobJCdNm":"[1390]기타 전문 서비스 관리자","dJobICd":"N751","dJobICdNm":"[N751]고용알선 및 인력공급업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004988:1', '{"dJobCd":"K000004988","dJobCdSeq":"1","dJobNm":"조사관리자","workSum":"마케팅 및 사회조사와 관련된 전반적인 업무를 관리한다.","doWork":"조사용역을 얻기 위한 영업활동을 수행한다. 조사의 목적, 범위, 방법, 기간 등 조사 관련 설계를 검증한다. 조사 설계상의 문제점에 대해 조언한다. 조사과정의 경과를 보고받고 관리한다. 조사결과의 신뢰도 및 검사의 적정성 여부를 검증한다. 직원들의 인사 및 근무상황을 점검하고 관리한다. 여론 및 시장 조사를 컴퓨터 프로그램과 통계 분석 기법을 활용해 결과를 분석한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0139","dJobECdNm":"[0139]부동산·조사·인력알선 및 기타 전문서비스 관리자","dJobJCd":"1390","dJobJCdNm":"[1390]기타 전문 서비스 관리자","dJobICd":"M714","dJobICdNm":"[M714]시장조사 및 여론조사업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001454:1', '{"dJobCd":"K000001454","dJobCdSeq":"1","dJobNm":"가스설비공사관리자","workSum":"가스 공급을 위한 배관 및 관련 설비를 설치·시공하는 현장 작업과 작업원의 활동을 관리·감독한다.","doWork":"설계도면, 기술서 등 공사 관련 자료를 수집·관리하며 공사현황을 파악한다. 공사에 따른 관공서 등의 인·허가사항을 처리한다. 공사와 관련된 기관과 업무협의를 하고 절차서를 작성·제출하여 공사허가를 받는다. 공사업체와 공사일정을 협의하고 공사진행 방향을 결정한다. 자재 반입 시 규격, 구조 등에 대한 육안검사를 하고 품질시험성과표를 확인하여 한국가스안전공사 또는 국가공인기관의 검사를 필한 자재인지를 확인한 후 반입한다. 도시가스사업법 및 가스사업자의 규정에 따라 시공한다. 관계법규와 가스사업자의 정해진 기술기준에 준하여 시공상태를 시험 및 검사한다. 공사에 따른 각종 서류를 작성하고 지원한다. 기공 및 준공에 따른 작업현황을 파악하여 관련 서류(품질시험성과표, 시공상태확인서, 현장시험성과표 등)를 작성하고 감리원에게 제출한다. 공사에 따른 공사인원관리, 자재관리, 공정관리를 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"웅크림|","workEnv":"대기환경미흡|","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","certLic":"가스산업기사, 토목산업기사","dJobECd":"0161","dJobECdNm":"[0161]건설·채굴 관리자","dJobJCd":"1411","dJobJCdNm":"[1411]건설 및 광업 관련 관리자","dJobICd":"F412","dJobICdNm":"[F412]토목 건설업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005066:1', '{"dJobCd":"K000005066","dJobCdSeq":"1","dJobNm":"공사현장관리자","workSum":"토목·건축·설비 등 건설공사의 시공 및 시공감독 업무를 수행하고, 공사현장작업원의 활동을 감독·조정한다.","doWork":"건설장비와 자재, 공사에 투입할 인원, 공사시간 등의 세부적인 공정을 계획한다. 공사계획에 맞추어 장비 및 자재가 투입되도록 주문한다. 공사여건이 변화되거나 공사지연을 방지하기 위하여 공정을 조절한다. 공사 진척상황, 예산집행 정산내역, 공사품질 등을 파악하고 관련 부서의 자료요청에 따라 보고한다. 공사발주업체 또는 하도급협력업체 담당자와 설계, 시공법, 공사비 등에 대하여 협의한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","similarNm":"공사현장소장","connectJob":"건설현장 규모에 따라 예산집행 및 계약 등 행정업무를 전적으로 담당하는 경우 현장공무기술자","certLic":"건축기술사, 건축기사, 토목기술사, 토목기사","dJobECd":"0161","dJobECdNm":"[0161]건설·채굴 관리자","dJobJCd":"1411","dJobJCdNm":"[1411]건설 및 광업 관련 관리자","dJobICd":"F411/F412","dJobICdNm":"[F411]건물 건설업 / [F412]토목 건설업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003071:1', '{"dJobCd":"K000003071","dJobCdSeq":"1","dJobNm":"광산관리자","workSum":"지하나 노천광산에서 광석을 채광하기 위한 굴진, 착암, 발파, 지주, 운반, 배수, 통기 등의 작업을 총괄 관리하고, 관련 종사원들의 활동을 감독·조정한다.","doWork":"광산에서 채광작업을 위한 지질학적 분석 자료를 검토한다. 생산계획을 수립하고 현장 기술자와 채광방법, 굴진방향과 규격을 협의·결정한다. 각 작업공정 및 작업장의 여건에 따라 작업량을 지시하고 장비와 인원을 배치한다. 갱내 혹은 갱외의 운반, 배수, 통기설비의 용량과 설치위치를 결정한다. 각 작업장을 순회하여 작업원들의 활동을 감독·조정하고 보안점검을 한다. 기존 광산의 탐광 및 신규 광산을 개발한다. 운반시설, 기계, 장비, 시설을 관리한다. 채광 및 출광의 품질을 관리한다. 채광기술 및 전반적인 운반계통의 합리화 방안을 연구·개선한다. 작업일지 및 보안일지를 작성하고 기타 보고서를 작성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"힘든 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","similarNm":"채광관리자","connectJob":"석탄광산에서 채탄작업을 감독하는 경우 채탄감독","certLic":"굴착기사, 광산보안기사, 화약류관리기사","dJobECd":"0161","dJobECdNm":"[0161]건설·채굴 관리자","dJobJCd":"1411","dJobJCdNm":"[1411]건설 및 광업 관련 관리자","dJobICd":"B051/B061/B062","dJobICdNm":"[B051]석탄 광업 / [B061]철 광업 / [B062]비철금속 광업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007448:1', '{"dJobCd":"K000007448","dJobCdSeq":"1","dJobNm":"광업안전보안관리자","workSum":"광업소의 안전한 작업활동을 지휘·감독하는 광업안전보안원을 교육하고, 전체 광업시설의 위험요소들을 점검·관리한다.","doWork":"광업소의 안전 및 보안에 관한 계획을 수립한다. 갱내 안전시설을 설치하거나 변경하고 운영한다. 보안 및 안전규정을 제정하거나 변경한다. 작업원들에게 안전교육을 실시한다. 공해 및 산업재해 방지계획을 수립하고 관리한다. 재해의 원인조사와 그 대책을 강구한다. 광업안전보안원을 지휘하고 감독한다. 시설과 재료를 정기적으로 검사하고 정비사항을 확인한다. 광산 내를 정기 또는 수시로 순시하여 보안점검을 한다. 광업안전보안원 및 기타 작업원들에게 보안상 필요한 지시를 하고 확인한다. 광업안전감독자 또는 광산안전보안원으로부터 통보받은 사항을 시정조치하고 결과를 통보한다. 보안일지 및 보고서를 확인하고 보안관계 중요사항을 기록하여 보존한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"10년 초과","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"대기환경미흡|다습|","workFunc1":"조정","workFunc2":"협의","workFunc3":"정밀작업","certLic":"광산보안산업기사, 광산보안기사","dJobECd":"0161","dJobECdNm":"[0161]건설·채굴 관리자","dJobJCd":"1411","dJobJCdNm":"[1411]건설 및 광업 관련 관리자","dJobICd":"B051/B061/B062","dJobICdNm":"[B051]석탄 광업 / [B061]철 광업 / [B062]비철금속 광업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002087:1', '{"dJobCd":"K000002087","dJobCdSeq":"1","dJobNm":"광업종합관리자","workSum":"석탄, 금속 및 비금속광물 채굴 및 채취, 소금채취업 등 광업 분야의 사업활동을 기획·지휘·조정한다.","doWork":"광업생산 정책을 수립·집행한다. 예산을 편성한다. 공급자, 고객, 정부기관 및 다른 업체와 교섭한다. 자원의 이용을 기획·통제한다. 종업원들에 대한 인사관리를 한다. 광업소의 안전 및 보안에 관한 계획을 수립한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"보통 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0161","dJobECdNm":"[0161]건설·채굴 관리자","dJobJCd":"1411","dJobJCdNm":"[1411]건설 및 광업 관련 관리자","dJobICd":"B051/B061/B062","dJobICdNm":"[B051]석탄 광업 / [B061]철 광업 / [B062]비철금속 광업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005307:1', '{"dJobCd":"K000005307","dJobCdSeq":"1","dJobNm":"선광관리자","workSum":"채취된 광물에서 유용광물을 추출하기 위하여 광물의 파쇄, 마쇄, 선별, 분리, 추출 등의 선광작업을 총괄 관리하고, 관련 종사원들의 활동을 감독·조정한다.","doWork":"채취된 광물의 양을 파악하여 선광계획과 인원계획을 수립한다. 가동인원을 파악하고 작업장별로 인원을 배치하고 작업량을 지시한다. 작업장을 순회하여 작업활동을 감독·조정하고 보안사항을 점검한다. 파쇄기, 마쇄기, 선광장비 등 선광장의 시설을 관리한다. 조업을 분석하고 선광 작업과정의 품질관리와 생산된 광물의 품질을 적정수준으로 유지한다. 선광기계, 장비, 시설의 위치를 결정한다. 작업 및 보안일지를 작성하고 기타 보고서를 작성한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"10년 초과","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","connectJob":"석탄을 선탄하는 작업원들을 감독하는 경우 석탄감독","certLic":"광산보안산업기사, 광산보안기사","dJobECd":"0161","dJobECdNm":"[0161]건설·채굴 관리자","dJobJCd":"1411","dJobJCdNm":"[1411]건설 및 광업 관련 관리자","dJobICd":"B051/B061/B062","dJobICdNm":"[B051]석탄 광업 / [B061]철 광업 / [B062]비철금속 광업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002210:1', '{"dJobCd":"K000002210","dJobCdSeq":"1","dJobNm":"연탄제조관리자","workSum":"연탄을 제조하기 위하여 석탄을 분쇄·혼합·성형하는 작업을 총괄 관리하고, 관련 종사원들의 활동을 감독·조정한다.","doWork":"연탄제조 공정 전반의 생산관리 및 품질관리를 한다. 규격이나 작업표준과의 차이를 확인하기 위하여 작업 도중이거나 완료된 제품을 검사한다. 불량품 발생 시, 원인을 찾아내도록 지시한다. 계획했던 생산량에 따라 수량을 조절한다. 기계와 장비를 설치하고 작동하는 작업원의 훈련을 지시한다. 생산시설의 유지보수와 자재의 구매 및 인사관리들을 총괄한다. 작업원의 채용 및 보건위생과 노사관계를 총괄한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"10년 초과","workStrong":"보통 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","dJobECd":"0161","dJobECdNm":"[0161]건설·채굴 관리자","dJobJCd":"1411","dJobJCdNm":"[1411]건설 및 광업 관련 관리자","dJobICd":"C191","dJobICdNm":"[C191]코크스 및 연탄 제조업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004124:1', '{"dJobCd":"K000004124","dJobCdSeq":"1","dJobNm":"철도토목관리자","workSum":"철로계통의 기능을 검사하고 정비·보수·유지하는 보선원의 활동을 감독·조정한다.","doWork":"선로에서 눈이나 기타 장애물을 제거하며 침목, 레일 등을 정비·보수하는 데 종사하는 작업원들의 작업지침과 작업계획을 수립한다. 차량의 탈선, 지반의 붕괴, 홍수 또는 산사태와 같은 비상상황에 대비해 비상대책을 수립한다. 비상시에 현장을 복구하기 위하여 보선장비와 작업원을 투입한다. 노선이 정상적으로 복구되었는지 확인하기 위하여 노선을 정기적으로 점검한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","certLic":"보선기능사","dJobECd":"0161","dJobECdNm":"[0161]건설·채굴 관리자","dJobJCd":"1411","dJobJCdNm":"[1411]건설 및 광업 관련 관리자","dJobICd":"H491","dJobICdNm":"[H491]철도 운송업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003918:1', '{"dJobCd":"K000003918","dJobCdSeq":"1","dJobNm":"토사석채취관리자","workSum":"석산, 강, 해안, 호수 등에서 골재, 모래, 석재 등을 채취하는 작업을 총괄 관리하고, 관련 종사원들의 활동을 감독·조정한다.","doWork":"토사석 채취에 관한 지식, 소요인원과 장소 등의 정보를 활용하여 세부적인 계획을 세운다. 토사석 채취에 필요한 장비와 도구를 파악하고 세부계획에 따라 장비와 자재가 투입되도록 제반 사항을 관리한다. 광산보안법을 숙지하고 작업원들에게 안전교육을 실시한다. 토사석 채취일정을 조절하고, 채취량을 파악하여 일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"조정","workFunc2":"감독","workFunc3":"단순작업","connectJob":"골재채취감독, 모래채취감독, 석재채취감독","dJobECd":"0161","dJobECdNm":"[0161]건설·채굴 관리자","dJobJCd":"1411","dJobJCdNm":"[1411]건설 및 광업 관련 관리자","dJobICd":"B071","dJobICdNm":"[B071]토사석 광업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006444:1', '{"dJobCd":"K000006444","dJobCdSeq":"1","dJobNm":"발전운영계획관리자","workSum":"발전소의 운영관리, 표준 및 품질관리, 유지·보수, 안전관리, 신·증설 및 보수공사 등 발전운영 업무를 총괄 관리한다.","doWork":"발전소에서 제출한 운영계획에 대하여 타당성, 경제성, 기술적 적합성 등을 검토·조정하여 사업계획을 입안하고 시행상태를 관리한다. 발전소별 신·증설 및 보수공사에 관한 기본계획을 입안하여 발전소에 통보하고 공사에 따른 기술, 인력 및 자재 등의 지원과 같은 공사관리를 총괄한다. 발전소별 물자관리부서의 수급계획 작성지침에 따라 작성된 물자수급계획을 검토한 후 소요자재를 판단하여 관련 부서에 통보한다. 구입의뢰, 견적서의 기술검토, 계약, 통관 및 입고과정 등 소요물자 조달관리를 한다. 발전소의 가능출력, 고장내역, 중요보수사항, 기기 시험계획 등 일일현황을 파악하여 보고하고 필요한 사항을 지원하는 발전소 운전관리업무를 수행한다. 전력수요 및 공급여건 변동에 대비한 경제적인 발전소 운용을 위하여 발전설비의 운용기술에 관한 신기술 개발 및 도입, 보급과 발전설비 수명연장 및 설비개선, 기타 신기술 개발에 관한 계획수립, 용역추진, 시행관리 등의 업무를 수행한다. 발전소의 설비용량, 이용률, 경력 등을 고려하여 발전 목표설정 및 실적관리를 한다. 발전소별 순회기술 점검계획을 입안하고 점검기준 등을 결정하며, 시행결과를 종합한다. 지방자치단체의 발전시설 점검요청에 따라 전국 자가발전도서에 대한 연간 순회점검계획을 작성하여 관할 사업소 및 행정관서에 통보한다. 사업품질보증계획서 작성 및 운영, 품질절차서 작성 및 운영, 품질 관련 서류검토 및 승인, 품질검사 및 품질지도, 품질요원의 교육계획 수립 및 시행 등 발전분야의 품질관리 업무를 수행한다. 발전설비 사고에 대한 원인분석을 통하여 예방대책을 수립한다. 기타 발전운영을 위한 계획 및 관리 업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","connectJob":"복합화력발전운영계획원, 수력발전운영계획원, 원자력발전운영계획원, 화력발전운영계획원, 태양열발전운영계획원, 태양광발전운영계획원, 풍력발전운영계획원, 조력발전운영계획원","certLic":"전기기사","dJobECd":"0162","dJobECdNm":"[0162]전기·가스·수도 관리자","dJobJCd":"1412","dJobJCdNm":"[1412]전기·가스 및 수도 관련 관리자","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003375:1', '{"dJobCd":"K000003375","dJobCdSeq":"1","dJobNm":"배전운영계획관리자","workSum":"수요자에 대한 전력공급 운영계획과 관련 설비의 품질관리 및 사고예방대책을 수립하며, 산하 사업소에 대한 지휘, 감독 및 지원업무를 총괄한다.","doWork":"배전설비를 신·증설하고, 운영 및 개선계획을 수립하기 위하여 배전방식 및 설비 기술을 개발한다. 배전기준을 제·개정 및 관리하며, 배전설비 기자재 개발, 배전손실 분석 및 대책 업무를 수행한다. 가공배전설비의 유지·보수계획과 배전전압 관리 및 개선대책을 수립한다. 배전지중화계획, 배전설비의 유지·보수계획 등을 수립한다. 지중배전시설 공사의 시행지도 및 공법개발, 기준 및 지침 운영관리, 전산개발 등의 업무를 수행한다. 전산화·자동화시스템 관리 및 운영, 품질관리 등 배전자동화를 위한 계획을 수립하고 시행한다. 배전분야의 신공법 개발, 배전선로 공가 및 임대 관련 업무를 총괄한다. 배전설비의 고장분석 및 예방대책을 수립하고 전기재해 및 안전 관련 제반 업무를 수행한다. 산하 사업소에 대한 지휘 감독 및 지원업무를 총괄한다. 기타 배전운영에 관한 제반 운영업무에 대한 계획을 수립하고 시행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","connectJob":"배전계획원, 배전운영원, 지중배전운영계획원, 배전기술계획원","certLic":"전기기사, 전기공사기사","dJobECd":"0162","dJobECdNm":"[0162]전기·가스·수도 관리자","dJobJCd":"1412","dJobJCdNm":"[1412]전기·가스 및 수도 관련 관리자","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003981:1', '{"dJobCd":"K000003981","dJobCdSeq":"1","dJobNm":"변전운영계획관리자","workSum":"변전소의 안정된 운영을 위하여 변전 관련 인력의 배치, 작업환경 조성, 작업자 직무교육 등에 대한 계획을 수립·시행하고 변전소 운영 업무를 총괄 관리한다.","doWork":"전력을 수용가의 전압에 맞도록 조절하는 변전소가 효율적·안정적으로 운영되도록 인력계획을 수립하여 배치·조절한다. 변전설비를 조작하는 작업자가 원활하게 작업할 수 있도록 업무용 비품조달, 쾌적한 작업환경 조성 등을 통하여 근무환경을 조성한다. 변전설비 관련 작업자의 직무향상을 위한 직무교육계획을 수립하고 계획에 따라 직무교육을 실시한다. 관할 변전소 변전설비의 효율적인 관리 및 운영을 위하여 변전설비현황, 변전소 단선결선도, 각종 도면의 변동사항을 파악하고 변전소의 전력량, 전압 등의 운전실적을 파악·분석하여 보고한다. 변전소의 안전사항을 점검·관리한다. 기타 변전운영 관련 업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","certLic":"전기기사, 전기공사기사","dJobECd":"0162","dJobECdNm":"[0162]전기·가스·수도 관리자","dJobJCd":"1412","dJobJCdNm":"[1412]전기·가스 및 수도 관련 관리자","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001731:1', '{"dJobCd":"K000001731","dJobCdSeq":"1","dJobNm":"용수관리종합상황실관리자","workSum":"수량·수질을 고려한 다목적댐 운영과 안정된 물(용수)공급 및 홍수피해 최소화를 위한 물 관리 업무를 총괄한다.","doWork":"저수지 운영계획 및 홍수대비 모의훈련계획을 수립한다. 홍수조절 및 효과에 대한 분석을 통하여 홍수피해의 최소화와 홍수조절능력 향상을 연구한다. 저수지의 운영계획을 수립하고 용수공급능력을 검토한다. 발전용 방류 수량을 결정하고 가뭄대책을 위한 지원업무를 수행한다. 물관리 기술개발 및 안정화를 위하여 물 관리시스템을 운영·관리한다. 댐 운영을 위한 신기술의 도입과 기술지원을 한다. 기상분석 및 예측을 통한 물 관리를 위하여 일일, 주간, 월별로 조사·분석한다. 효율적인 저수지 운영을 통한 홍수조절 및 수관리를 위한 기술을 검토한다. 수질, 수위, 방수량, 유입량, 기상자료 등을 검토·분석하여 효율적인 댐 운영을 위한 정보시스템을 운영한다. 안정적인 물 공급을 위한 댐 및 저수지 운영을 위한 제반 활동을 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","dJobECd":"0162","dJobECdNm":"[0162]전기·가스·수도 관리자","dJobJCd":"1412","dJobJCdNm":"[1412]전기·가스 및 수도 관련 관리자","dJobICd":"E360","dJobICdNm":"[E360]수도업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006880:1', '{"dJobCd":"K000006880","dJobCdSeq":"1","dJobNm":"중앙급전관리자","workSum":"발전 및 전력공급 계획에 따라 수요자에게 안정적이고 경제적으로 전력을 공급하기 위한 전력계통의 감시·제어·운영 업무를 총괄 관리하고, 관련 작업원의 활동을 감독·관리한다.","doWork":"전력계통 안정운용 및 계통조작을 지시한다. 주간 전력수급 및 제약발전 계획을 수립하여 원활한 운영이 이루어지도록 감독한다. 발전 및 송전제약을 검토하고 제약사항을 제거하여 적용하도록 지시한다. 송변전설비의 보수 및 정비에 따른 휴전작업의 승인여부를 최종적으로 결정한다. 계통전압 및 계통주파수 조정에 관한 사항을 관리한다. 급전종합자동화설비 운용 및 유지관리를 총괄한다. 계통보호설비의 운용 및 동작분석 통계를 관리한다. 전력계통 제정수 관리를 총괄한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","dJobECd":"0162","dJobECdNm":"[0162]전기·가스·수도 관리자","dJobJCd":"1412","dJobJCdNm":"[1412]전기·가스 및 수도 관련 관리자","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006256:1', '{"dJobCd":"K000006256","dJobCdSeq":"1","dJobNm":"가죽제품제조관리자","workSum":"벨트, 가죽가방, 의류 등의 품목을 완성하기 위하여 부분품을 재단하고 재봉하는 작업을 총괄 관리하고, 관련 종사원들의 활동을 감독·조정한다.","doWork":"주문된 품목별 생산량에 따라 작업계획을 수립한다. 작업계획에 따라 세부실행항목을 수립한다. 작업절차 및 방법을 결정하여 작업원에게 작업내용을 지시하고 작업배치를 한다. 주문품에 필요한 패턴을 준비한다. 가죽의 패턴·재단·봉제과정에 종사하는 작업자를 지도한다. 재단기를 조작하는 종사원을 훈련시킨다. 부분품을 합봉하기 위해 미싱을 하는 작업원을 감독한다. 작업상황을 관찰하며 작업내용을 점검한다. 완성품이나 부분품의 결점을 조사한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","certLic":"양복기능사, 양장기능사","dJobECd":"0163","dJobECdNm":"[0163]제조·생산 관리자","dJobJCd":"1413","dJobJCdNm":"[1413]제품 생산 관련 관리자","dJobICd":"C151","dJobICdNm":"[C151]가죽, 가방 및 유사제품 제조업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002139:1', '{"dJobCd":"K000002139","dJobCdSeq":"1","dJobNm":"고무제품제조관리자","workSum":"각종 고무제품(타이어, 신발, 장갑, 브이벨트, 호스, 위생용 고무제품, 공업용 부속품 등)의 제조 과정을 총괄 관리하고, 제조기기 및 장치를 조작하는 작업원들의 활동을 감독·조정한다.","doWork":"원료고무에 각종 첨가제를 혼합하여 배합고무를 만들고 성형·가황시켜 신발류, 호스, 벨트, 운동구, 구명장비, 공업용 부속품 등의 고무제품을 제조하는 작업원들의 활동을 감독·조정하기 위해 작업계획을 검토한다. 생산 및 세부 실행계획을 수립하여 소속반장에게 지시하고 이행 여부를 확인한다. 담당설비 및 환경상태를 점검한다. 이상 및 불량이 발생하면 시정을 지시하고 이를 확인한다. 소속 직원에 대한 수시관찰과 면담을 통해 애로 및 건의사항을 수렴·해결하고 보고한다. 노무관리교육을 한다. 작업원에 대한 직무교육계획을 수립·시행한다. 작업원에 대한 안전위생교육을 수립·시행한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","certLic":"화공기사, 화공산업기사","dJobECd":"0163","dJobECdNm":"[0163]제조·생산 관리자","dJobJCd":"1413","dJobJCdNm":"[1413]제품 생산 관련 관리자","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005839:1', '{"dJobCd":"K000005839","dJobCdSeq":"1","dJobNm":"금속가구제조관리자","workSum":"금속가구 제조를 위한 절단, 절곡, 용접, 도장, 조립, 주조 등의 작업을 총괄 관리하고, 관련 종사원들의 활동을 감독·조정한다.","doWork":"책상, 탁자, 의자, 칸막이, 캐비닛, 책장, 로커, 금고, 교구 등 금속가구를 생산하기 위하여 제품별, 공정별로 작업계획을 수립한다. 공정별로 작업자를 생산현장에 배치하고 작업지시를 내린다. 각종 기계, 공구의 성능 및 작업요령을 교육하고 안전사고에 대비한다. 작업공정에 필요한 자재 및 기술을 지원한다. 작업지시서대로 공정이 이루어지고 있는지 점검한다. 생산량을 파악하여 작업일지에 기록한다. 화재, 감전 등 작업장의 안전사고를 예방하고 대비한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|고온|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","certLic":"가구제작산업기사, 가구제작기능사","dJobECd":"0163","dJobECdNm":"[0163]제조·생산 관리자","dJobJCd":"1413","dJobJCdNm":"[1413]제품 생산 관련 관리자","dJobICd":"C320","dJobICdNm":"[C320]가구 제조업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002679:1', '{"dJobCd":"K000002679","dJobCdSeq":"1","dJobNm":"담배제조관리자","workSum":"잎담배를 가공처리하여 담배·여송연을 제조하고 포장하는 작업을 총괄 관리하고, 관련 종사원들의 활동을 감독·조정한다.","doWork":"생산량에 따른 원료의 수급량을 조절하고 생산 및 운영계획을 수립한다. 각 부서의 반장에게 작업계획을 지시한다. 작업과정과 생산품의 결함을 찾기 위하여 기계조작상태를 관찰하고 원료가공, 담배제조, 포장, 보관 및 출하 등 전 공정을 원활하게 진행시키기 위하여 각 부서의 감독 업무를 계획·조정한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","dJobECd":"0163","dJobECdNm":"[0163]제조·생산 관리자","dJobJCd":"1413","dJobJCdNm":"[1413]제품 생산 관련 관리자","dJobICd":"C120","dJobICdNm":"[C120]담배 제조업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003001:1', '{"dJobCd":"K000003001","dJobCdSeq":"1","dJobNm":"동물백신생산관리자","workSum":"동물백신 생산에 관해 기획 및 관리하고, 관련 종사원들을 감독·조정한다.","doWork":"GMP(Good Manufacturing Practice: 원자재의 구입으로부터 제조, 포장, 출하에 이르기까지의 생산공정 전반에 걸쳐 충분한 조직적 관리하에 의약품을 생산하는 체제를 확립하기 위한 필요 요건에 대한 규정) 관련 제품표준서, 제조관리기준서 등 서류를 작성하고 관리한다. 제조지시서 및 SOP(Standing Operating Procedure: 예규, 관리운용절차) 서류를 점검 및 관리한다. 병원체를 보관하고 관리한다. 생산공정을 점검하고 개발을 지휘한다. 팀장 및 팀원을 교육하고 관리한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","certLic":"수의사","dJobECd":"0163","dJobECdNm":"[0163]제조·생산 관리자","dJobJCd":"1413","dJobJCdNm":"[1413]제품 생산 관련 관리자","dJobICd":"C212","dJobICdNm":"[C212]의약품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001630:1', '{"dJobCd":"K000001630","dJobCdSeq":"1","dJobNm":"맥주양조책임자","workSum":"맥주 양조장(Brewery)에서 맥주를 제조하는 데 사용되는 원·부자재와 양조 장비 및 설비 등의 선정, 관리에서부터 맥주 제조공정을 거쳐 완성된 맥주가 좋은 품질로 소비자에게 판매될 때까지의 모든 공정을 책임진다.","doWork":"맥주의 원·부자재인 맥아, 홉, 효모, 물, 부가물 등과 양조 장비를 선정, 관리한다. 양조 장비에 맞는 맥주제조법을 개발하고 적용한다. 모든 양조 장비(분쇄기, 당화조, 여과조, 끓임조, 월풀조, 열교환기, 발효조, 숙성 및 저장조, 냉각수조, 온수조, 냉장설비, 폐수설비 등)를 설치하고 문제점을 파악한다. 꾸준한 공정개선을 통해 양조 효율도와 양조업무의 효율을 극대화한다. 품질유지를 위한 맥주양조사를 교육한다. 소비자들의 양조장 투어와 관련된 일을 담당하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"고온|다습|소음·진동|","workFunc1":"종합","workFunc2":"교육","workFunc3":"정밀작업","similarNm":"브루마스터, 맥주마이스터, 맥주양조기술자, 맥주양조사","certLic":"주류제조관리사","dJobECd":"0163","dJobECdNm":"[0163]제조·생산 관리자","dJobJCd":"1413","dJobJCdNm":"[1413]제품 생산 관련 관리자","dJobICd":"C111","dJobICdNm":"[C111]알코올음료 제조업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005488:1', '{"dJobCd":"K000005488","dJobCdSeq":"1","dJobNm":"목재가구제조관리자","workSum":"목재가구의 생산과정을 총괄 관리하고, 가구제조원의 업무를 분담·조정·감독한다.","doWork":"가구 주문량에 따라 생산계획을 세운다. 생산에 필요한 자재 및 소모품 등을 산정하여 구매한다. 생산계획에 따라 각 작업자를 작업장에 배치하고 업무를 지시한다. 작업자에 대한 안전교육을 실시한다. 작업 전 각종 기계장비의 이상 유무를 파악하고 이상 시에는 수리 및 보수작업을 지시한다. 목재를 성형, 절단, 가공, 포장하는 작업자의 업무량을 점검하여 생산계획량 달성에 차질이 없도록 작업을 감독한다. 작업원들의 업무수행에 따른 애로 및 건의사항을 수렴하여 작업장의 환경개선책 및 안전사고 대책을 수립한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","dJobECd":"0163","dJobECdNm":"[0163]제조·생산 관리자","dJobJCd":"1413","dJobJCdNm":"[1413]제품 생산 관련 관리자","dJobICd":"C320","dJobICdNm":"[C320]가구 제조업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002706:1', '{"dJobCd":"K000002706","dJobCdSeq":"1","dJobNm":"방사방적관리자","workSum":"섬유원료를 사용하여 실을 생산하는 과정을 총괄 관리하고, 관련 종사원들의 활동을 감독·조정한다.","doWork":"제품의 생산계획에 따라 제품별 방사량, 섬유종류, 품질, 혼섬율, 연수, 번수 등을 파악·계산한다. 수학공식과 도표를 사용하여 연신을 효과적으로 하기 위하여 규정된 실의 굵기와 연신 기어의 크기 등에 대한 드래프트(Draft)를 계산한다. 섬유의 기본 길이에 따라 연신 롤러의 간격을 결정한다. 명세서를 분석하여 실의 꼬임수를 결정한다. 생산계획에 따라 연신 롤러의 교체 일정을 수립하고 관련 부서에 교체를 지시한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","certLic":"의류기술사, 섬유기술사","dJobECd":"0163","dJobECdNm":"[0163]제조·생산 관리자","dJobJCd":"1413","dJobJCdNm":"[1413]제품 생산 관련 관리자","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003370:1', '{"dJobCd":"K000003370","dJobCdSeq":"1","dJobNm":"생산관리자(일반)","workSum":"사업체의 설비, 원자재, 종업원을 효율적으로 활용할 수 있도록 생산업무를 기획·조직·통제하고 생산정책을 수립한다.","doWork":"생산소요량, 공장의 생산능력, 생산인력 및 성과 등 생산정책에 관하여 총괄관리자 및 각 부서관리자와 협의하여 자금의 한계, 활용인력, 원자재, 판매 등의 생산계획을 수립한다. 수립된 생산계획에 따른 제반 활동을 지도하고 조정한다. 설비유지나 기계장비의 대체, 생산단가, 품질관리 등에 관해 의사결정을 한다. 직원의 신상관리, 포상, 근무평정, 인력계획 및 노사관계를 유지하기 위한 조직·인사·노무 관리업무를 총괄한다. 품질 및 생산 관리업무를 위하여 문제가 발생하면 원인을 분석하고 대책을 수립한다. 품질과 생산성을 향상시키기 위해 개선방향과 품질경향 분석을 지시하여 문제를 해결한다. 생산실적을 분석·검토하고 총괄관리자에게 생산계획과 실적을 보고한다. 생산업무에 대한 전반적인 문제를 조정하고 해결한다. ICT를 바탕으로 한 스마트팩토리가 도입된 경우, 생산관리시스템을 관리하고, 실행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","similarNm":"공장장","certLic":"품질관리기술사, 품질경영기사, 품질경영산업기사","dJobECd":"0163","dJobECdNm":"[0163]제조·생산 관리자","dJobJCd":"1413","dJobJCdNm":"[1413]제품 생산 관련 관리자","dJobICd":"C","dJobICdNm":"[C]제조업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003113:1', '{"dJobCd":"K000003113","dJobCdSeq":"1","dJobNm":"석유정제업관리자","workSum":"원유를 정제하여 각종 석유제품을 생산하기 위한 기술적 관리 업무를 수행한다.","doWork":"원유를 정제하여 화합물의 원제, LPG, 연료유, 윤활유 및 그리스(Grease:기계의 마찰 부분에 쓰는 끈적끈적한 윤활유) 등의 석유제품을 제조하기 위한 생산계획을 수립한다. 생산계획에 따른 생산관리 업무를 수행한다. 원자재 조달을 관리한다. 작업원(Operator)을 배치하고, 작업활동을 감독 및 조정한다. 공정 중간 및 최종제품에 대한 품질검사를 의뢰한다. 산업안전보건 및 환경 관련 규정의 준수를 위한 제반 활동을 수행한다. 최적의 공정조건을 수립하기 위한 제품품질과 공정조건의 비교분석을 실시하며, 제품수율과 에너지효율을 높이기 위한 공정개선업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","certLic":"화공기사","dJobECd":"0163","dJobECdNm":"[0163]제조·생산 관리자","dJobJCd":"1413","dJobJCdNm":"[1413]제품 생산 관련 관리자","dJobICd":"C192","dJobICdNm":"[C192]석유 정제품 제조업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005091:1', '{"dJobCd":"K000005091","dJobCdSeq":"1","dJobNm":"섬유제품제조관리자","workSum":"끈, 실 등의 수지에서 합성섬유를 압출하여 가정용 및 산업용 섬유제품을 제조·생산하는 작업을 관리·감독한다.","doWork":"섬유제품 생산계획을 수립하고, 장비, 인원 등 세부생산계획을 수립한다. 공정별 작업지시서를 작성하고 검토한다. 생산 및 관리에 필요한 인원의 선발, 교육, 투입 등에 관련된 업무를 총괄한다. 생산계획에 따른 공정별 인원을 조정한다. 제조기계의 안전 및 가동상태를 수시로 확인한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","certLic":"섬유기술사","dJobECd":"0163","dJobECdNm":"[0163]제조·생산 관리자","dJobJCd":"1413","dJobJCdNm":"[1413]제품 생산 관련 관리자","dJobICd":"C132","dJobICdNm":"[C132]직물직조 및 직물제품 제조업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005669:1', '{"dJobCd":"K000005669","dJobCdSeq":"1","dJobNm":"음반제조관리자","workSum":"CD, DVD, LP 등의 각종 음반을 제작·검사하는 업무를 관리하고, 관련 작업원의 활동을 감독·조정한다.","doWork":"CD, DVD, LP 등의 음반을 복사하는 설비를 관리하고 정상상태를 점검한다. 작업계획에 따른 일일 작업량을 산출한다. 카세트테이프복사원, 광디스크인쇄원, 광디스크프레싱원, 스탬프제작원을 배치 및 관리한다. 각종 자재의 출고사항을 관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","connectJob":"카세트테이프제작관리자, CD음반제작관리자, DVD음반제작관리자","dJobECd":"0163","dJobECdNm":"[0163]제조·생산 관리자","dJobJCd":"1413","dJobJCdNm":"[1413]제품 생산 관련 관리자","dJobICd":"J592","dJobICdNm":"[J592]오디오물 출판 및 원판 녹음업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003572:1', '{"dJobCd":"K000003572","dJobCdSeq":"1","dJobNm":"의류제조관리자","workSum":"의복을 수선·제조·개조하는 업무를 관리하고, 관련 작업원의 활동을 감독·조정한다.","doWork":"프레스를 사용한 열전사와 염색의 형태가 명세서와 일치하는지 검사한다. 원단 및 모피의 패턴·재단·봉제과정에 종사하는 작업자를 지도한다. 의류 형태의 기술적 부분이 형(패턴:Pattern)의 표준과 일치하도록 완성된 의류를 검사한다. 의복의 패턴을 개발하고 재단, 봉제, 완성, 포장하는 데 종사하는 작업원의 활동을 감독·조정한다. 작업지시서와 작업이 일치하는지 검사한다. 새로운 스타일의 의복을 제조하기 위해 작업원을 재배치한다. 고객이 의뢰한 수선과 교환을 검사·관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","certLic":"의류기사","dJobECd":"0163","dJobECdNm":"[0163]제조·생산 관리자","dJobJCd":"1413","dJobJCdNm":"[1413]제품 생산 관련 관리자","dJobICd":"C141/C142","dJobICdNm":"[C141]봉제의복 제조업 / [C142]모피제품 제조업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001795:1', '{"dJobCd":"K000001795","dJobCdSeq":"1","dJobNm":"의약품제조관리자","workSum":"각종 의약품(유기합성의약품, 천연물의약품, 바이오의약품 등) 제조를 위한 원료의약품 및 완제의약품의 생산업무를 관리하고, 관련 작업원의 활동을 감독·조정한다.","doWork":"각종 의약품의 생산량 계획에 따라 원료의 수급계획을 수립한다. 각 공정부서의 단위공정관리자에게 작업계획을 지시한다. 의약품 원료 및 부원료를 혼합·조립·건조·정립·재혼합·최종혼합하는 장치의 안전 및 가동상태를 확인한다. 작업과정과 생산품의 결함을 찾기 위하여 기계조작상태를 관찰한다. 배양·정제·분쇄·혼합·성형 등 전 공정을 원활하게 진행시키기 위하여 각 공정부서의 감독업무를 계획·조정한다. 생산량의 연간, 월간, 일간계획을 수립한다. 인원 배치를 단위공정관리자와 협의하여 설정한다. 제품의 종류 및 생산량에 따른 설비도입을 검토한다. 의약품에 대한 연구개발을 독려한다. 바이오의약품의 역가손실방지, 장기보관, 유통과정의 품질관리 등을 위한 검사를 실시한다. 보건위생상 위해요소가 없도록 제조소 시설에 대한 위생관리를 하여 교차오염 또는 외부오염 등을 방지한다. 종업원의 보건위생상태를 점검한다. 우수한 품질이 보장된 의약품 생산이 되도록 교육·감독을 한다. 제조관리기준서, 제품표준서 등에 의하여 정확히 제조되도록 관리한다. 작업장에서 국민보건에 유해한 물질이 유출되거나 방출되지 아니하도록 한다. 원료 및 자재의 입고부터 완제품의 출고에 이르기까지 필요한 시험검사 또는 검정을 한다. 제조단위별로 제조관리기록서와 품질관리기록서를 작성하고 보존한다. 제조과정 중 유기용매 등을 사용하는 경우에는 그 유기용매의 종류와 규격, 사용 목적, 사용량, 잔류량 등에 대한 기준을 설정하여 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","dJobECd":"0163","dJobECdNm":"[0163]제조·생산 관리자","dJobJCd":"1413","dJobJCdNm":"[1413]제품 생산 관련 관리자","dJobICd":"C211/C212","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업 / [C212]의약품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007052:1', '{"dJobCd":"K000007052","dJobCdSeq":"1","dJobNm":"정밀화학생산기획자","workSum":"기업의 경영목표를 실현하기 위해 생산에 필요한 각종 자원의 효율적 결합·배분을 통해 생산 활동을 전략적으로 계획한다.","doWork":"기업의 경영목표 실현을 위해 생산에 필요한 지식재산권 자료를 분석하고 시장 생산기술 동향을 조사 분석하여 기술변화를 예측하고 영향을 파악하여 대책을 수립한다. 법·규제 리스크 및 사업환경을 분석하여 생산성 개선을 위한 계획의 수립 및 성과목표를 설정하고 중장기 세부 생산시스템 전략을 수립한다. 조직·인력관리 방향과 목표를 설정하여 관리하고 성과평가를 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0163","dJobECdNm":"[0163]제조·생산 관리자","dJobJCd":"1413","dJobJCdNm":"[1413]제품 생산 관련 관리자","dJobICd":"C203/C204","dJobICdNm":"[C203]비료, 농약 및 살균, 살충제 제조업 / [C204]기타 화학제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002562:1', '{"dJobCd":"K000002562","dJobCdSeq":"1","dJobNm":"직조관리자","workSum":"옷감, 융단, 가구용 안감 등에 사용되는 무명, 삼베, 바인딩 등의 섬유제품에 대한 제조 업무를 관리하고, 관련 작업원의 활동을 감독·조정한다.","doWork":"직조기와 권취기의 설치·조정을 지시한다. 새로운 패턴을 짤 수 있도록 직조기 변경을 지시한다. 제품이 특정 품질수준에 이르는 것을 확인하기 위하여 공정과 완성된 제품을 검사한다. 제품에 따라 생산계획을 세우고 생산량 등 세부계획을 수립한다. 생산계획에 따라 천, 의류, 기타 다른 물품을 짜내기 위해 무늬교환에 관해 계획하고 편직기조정원에게 지시한다. 설치된 기계를 검사하고 작동오류가 발생하는 기계를 수선하고 조절하도록 지시한다. 기계와 장비를 설치하고 작동시키는 데 종사하는 작업원의 훈련을 지시한다. 주문규격이나 작업표준과 차이를 확인하기 위하여 작업도중이나 작업이 완료된 제품을 검사한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","similarNm":"편직감독","dJobECd":"0163","dJobECdNm":"[0163]제조·생산 관리자","dJobJCd":"1413","dJobJCdNm":"[1413]제품 생산 관련 관리자","dJobICd":"C132","dJobICdNm":"[C132]직물직조 및 직물제품 제조업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001697:1', '{"dJobCd":"K000001697","dJobCdSeq":"1","dJobNm":"콘크리트제조관리자","workSum":"레디믹스트 콘크리트(아직 굳지 않은 상태로 레미콘차량에 실어 그 속에서 뒤섞으며 건설현장으로 배달하는 콘크리트)를 생산하는 콘크리트 제조 공장을 운영·관리한다.","doWork":"회사의 경영방침에 따라 설정된 목표를 달성하기 위하여 종업원들에게 관련 내용을 전달한다. 영업·제조·관리부분별로 일일, 주간, 월간, 연간에 걸쳐 생산·운영·자금 등의 공장운영계획을 수립한다. 수립된 계획의 진행사항을 검토·분석하여 대책을 수립한다. 작업원을 적절한 위치에 배치한다. 공장의 순회 점검을 통하여 가동현황, 작업자 및 수송차량관계 등을 파악한다. 공장작업원의 고용·훈련·안전교육 등과 같은 인사기록사항을 작성하며 작업원의 애로사항 등 문제점을 해결한다. 공장 내의 복지시설을 관리하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","dJobECd":"0163","dJobECdNm":"[0163]제조·생산 관리자","dJobJCd":"1413","dJobJCdNm":"[1413]제품 생산 관련 관리자","dJobICd":"C233","dJobICdNm":"[C233]시멘트, 석회, 플라스터 및 그 제품 제조업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004641:1', '{"dJobCd":"K000004641","dJobCdSeq":"1","dJobNm":"편조물제조관리자","workSum":"양말, 장갑 등의 편조물 제조공정을 관리하고, 관련 작업원들의 활동을 감독·조정한다.","doWork":"편직공정에 관한 전반적인 지식 및 내용을 숙지한다. 연간, 월간, 일간생산계획을 수립하고 점검한다. 생산계획에 따라 작업지침을 만들고 이에 따라 작업원을 배치한다. 작업 장비의 이상 유무를 파악한다. 양말, 장갑, 타월 등의 편조물을 편조 및 건조하는 기계를 조작하는 작업원의 활동을 관리한다. 생산한 편조물과 표준규격의 차이점을 점검하여 필요하면 삽지 가이드를 조정하기 위하여 물품을 검토한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"단순작업","similarNm":"편조물제조반장","certLic":"섬유기술사","dJobECd":"0163","dJobECdNm":"[0163]제조·생산 관리자","dJobJCd":"1413","dJobJCdNm":"[1413]제품 생산 관련 관리자","dJobICd":"C133","dJobICdNm":"[C133]편조원단 제조업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005777:1', '{"dJobCd":"K000005777","dJobCdSeq":"1","dJobNm":"합성수지제품제조관리자","workSum":"합성수지 원료를 혼합·사출·압출·발포·조립해 판·필름·봉·관 등 각종 형태의 플라스틱제품을 제조하는 공정을 총괄하고, 관련 작업원들의 활동을 감독·조정한다.","doWork":"분말·입상·액상 등의 열경화성 또는 열가소성수지를 이용해 각종 플라스틱 제품을 제조하는 작업원의 활동을 감독한다. 고무·종이·폴리에틸렌·바니시·플라스틱·금속 등의 피복 재료로 전선이나 케이블을 연속 절연하는 기계를 조작하는 작업원의 활동을 감독한다. 생산계획에 의하여 원자재·인원 등을 각 공정의 소요시간에 알맞게 배치한다. 원자재의 종류 및 특성을 숙지하여 작업내용을 작업원에게 교육시킨다. 표준서와 제품이 일치하는지를 검사·확인한다. 기계의 이상 유무를 순회하여 확인한 후 적절한 조치를 취하도록 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","similarNm":"플라스틱제품제조관리자","dJobECd":"0163","dJobECdNm":"[0163]제조·생산 관리자","dJobJCd":"1413","dJobJCdNm":"[1413]제품 생산 관련 관리자","dJobICd":"C202","dJobICdNm":"[C202]합성고무 및 플라스틱 물질 제조업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004691:1', '{"dJobCd":"K000004691","dJobCdSeq":"1","dJobNm":"가금부화관리자","workSum":"가금(고기나 알의 생산을 목적으로 사육되는 조류)의 종란을 부화시키고 병아리의 선별·포장·수송을 하는 데 종사하는 작업원들의 활동을 감독·관리한다.","doWork":"고객의 주문, 시장성 예측, 부화량 등을 고려하여 부화계획을 설정한다. 부화장의 작업에 대한 정책과 실행을 계획하고 수행한다. 가금을 소유한 회사로부터 공급받아야 될 종란의 양을 설정하고 업체와 협의한다. 가금부화작업원에게 종란의 부화 및 분류, 예방접종, 부화된 병아리의 포장 및 수송, 부화장비 및 시설물의 유지와 같은 부화장 활동을 지시하고 조정한다. 부화기, 사료, 약품과 같은 장비 및 공급물을 구입한다. 부화량, 부화된 병아리의 판매 등 부화활동에 관련된 각종 장부 및 보고서를 작성한다. 상업적 사육자들에게 부화된 병아리를 판매하기 위하여 협의하고, 가금의 종류에 따른 위생관리에 대하여 알려준다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","connectJob":"메추리인공부화관리자, 병아리인공부화관리자, 오리인공부화관리자","dJobECd":"0169","dJobECdNm":"[0169]기타 건설·전기 및 제조 관리자","dJobJCd":"1490","dJobJCdNm":"[1490]기타 건설·전기 및 생산 관련 관리자","dJobICd":"A012","dJobICdNm":"[A012]축산업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004349:1', '{"dJobCd":"K000004349","dJobCdSeq":"1","dJobNm":"과수작물재배관리자","workSum":"각종 과수작물을 재배·관리·수확하는 업무를 관리하고, 관련 작업원의 활동을 관리·감독한다.","doWork":"재배할 과수의 종류와 양, 과수원의 면적, 과수작물재배원 등의 고용 인력을 결정한다. 과수묘목, 농기구와 농기계 등을 선택하여 구입한다. 과수 경작지식을 바탕으로 어떤 수종을 언제, 어떻게 심고, 발아시키며, 접목하고, 물을 주고, 나뭇가지를 치고, 수확할 것인가를 결정한다. 과수작물재배원에게 농기계를 사용하여 과수원을 갈고, 묘목을 심는 방법, 그리고 시비, 관수, 약제살포 등의 방법을 지시한다. 사다리, 전지가위 등 과실을 수확하는 데 필요한 도구 등을 준비하고 분배한다. 수확한 과일을 선별하고 포장하는 작업을 감독·조정한다. 수확된 과일을 판매하기 위하여 구매자와 협의한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"위험내재|다습|","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","connectJob":"과수를 분류하는 기준에 따라 과실작물재배관리자, 수실작물재배관리자, 재배하는 작물의 전문적인 품종에 따라 감귤재배관리자, 감재배관리자, 대추재배관리자, 밤재배관리자, 배재배관리자, 복숭아재배관리자, 사과재배관리자, 포도재배관리자","dJobECd":"0169","dJobECdNm":"[0169]기타 건설·전기 및 제조 관리자","dJobJCd":"1490","dJobJCdNm":"[1490]기타 건설·전기 및 생산 관련 관리자","dJobICd":"A011","dJobICdNm":"[A011]작물 재배업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006545:1', '{"dJobCd":"K000006545","dJobCdSeq":"1","dJobNm":"목재수확관리자","workSum":"목재수확작업장의 나무를 절단·운반·적재하는 업무를 관리하고, 관련 작업원의 활동을 감독·관리한다.","doWork":"목재수확작업장에서의 나무 베기, 나무 쓰러뜨리기, 운반법, 적재법 및 안전수칙 등에 대한 준수사항을 작업자에게 교육한다. 목재수확작업에 따른 사고를 미연에 방지하기 위하여 안전점검사항 및 안전시설을 점검·관리하고 산재예방을 위한 조치를 지시한다. 목재수확작업에 따른 각종 장비 및 인원을 산정하고 그에 따른 장비 및 노동력을 확보할 수 있도록 계획을 세운다. 수확된 목재를 공급하기 위한 시장을 확보하고 목재가격을 산정하여 판매한다. 사업진행에 따른 소요인부·수확기간·생산량 등의 작업내용을 기록부에 작성하고 보존한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실외","workEnv":"위험내재|","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","similarNm":"벌목관리자","dJobECd":"0169","dJobECdNm":"[0169]기타 건설·전기 및 제조 관리자","dJobJCd":"1490","dJobJCdNm":"[1490]기타 건설·전기 및 생산 관련 관리자","dJobICd":"A020","dJobICdNm":"[A020]임업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005517:1', '{"dJobCd":"K000005517","dJobCdSeq":"1","dJobNm":"산림관리자","workSum":"경제 또는 휴양의 목적으로 조성된 산림지역의 개발과 산림자원을 관리한다.","doWork":"관리하는 산림에 대한 조림계획, 벌채계획, 재조림계획을 수립한다. 산림지역의 임야지도를 작성한다. 장래 수목의 성장을 예측·측정하여 임목의 판매시기를 관리한다. 최소의 손실률과 재난율을 갖는 벌채, 임목제거 방법들을 조사·연구한다. 산림화재의 진화를 감독하며 화재예방계획을 수립하고 수행한다. 산림 내의 캠프장, 오락시설을 계획하고 전화선 또는 도로부설에 대한 관리를 한다. 산림에 관한 토양침식, 산림병해충 통제에 대한 대책을 세우는 등 산림보호에 관한 계획을 수립한다. 산림에 대한 각종 환경요인을 연구하여 환경보고서를 작성한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","dJobECd":"0169","dJobECdNm":"[0169]기타 건설·전기 및 제조 관리자","dJobJCd":"1490","dJobJCdNm":"[1490]기타 건설·전기 및 생산 관련 관리자","dJobICd":"A020","dJobICdNm":"[A020]임업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002445:1', '{"dJobCd":"K000002445","dJobCdSeq":"1","dJobNm":"수산종묘생산업자","workSum":"육상 또는 해상에 일정한 시설을 설치하여 수산종묘를 생산한다.","doWork":"어류, 해조류, 패류 등의 종묘생산 대상품목 및 시설방법, 규모 등에 대한 생산계획을 수립한다. 시설설치, 필요장비 및 기구의 조달, 인력 등에 대한 세부계획을 수립한다. 시설설계서 및 관련 서류를 작성하여 수산종묘생산업 허가를 받는다. 종묘를 배양·생산하기 위하여 사육용 실내수조 또는 옥외수조를 설치한다. 사육에 필요한 채묘(採苗)기 등의 각종 자재를 준비한다. 수산종묘관리기사 및 종사원들을 고용한다. 종묘생산용 어미를 구입하거나 또는 자체적으로 생산한다. 현미경, 수온계, 비중계, 광도계, 수조발전기, 양수기 등을 사용하여 채란, 수정, 부화, 사육관리 등 종묘 배양업무를 관리·감독한다. 품종에 따라 일정기간 배양한 후 채묘(採苗)기를 사용하여 채취한다. 종묘를 판매하기 위하여 구매자와 협의한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"수산종묘배양업자, 사상체배양업자, 포자배양업자","connectJob":"어류종묘생산업자, 패류종묘생산업자, 해조류종묘생산업자","dJobECd":"0169","dJobECdNm":"[0169]기타 건설·전기 및 제조 관리자","dJobJCd":"1490","dJobJCdNm":"[1490]기타 건설·전기 및 생산 관련 관리자","dJobICd":"A032","dJobICdNm":"[A032]양식어업 및 어업관련 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001987:1', '{"dJobCd":"K000001987","dJobCdSeq":"1","dJobNm":"시설작물재배관리자","workSum":"온·습도 등 환경을 통제할 수 있는 작물재배 시설을 이용하여 채소, 원예 및 기타 작물을 재배하는 작업원의 활동을 감독하고, 시설물을 관리한다.","doWork":"작물재배 시설의 내·외부를 관찰하여 자재나 시설물의 파손이나 노후 여부를 점검한다. 작물재배 시설에 파손이 있을 시, 정비하도록 지시한다. 시설물에서 재배할 작물의 품종을 선정하여 종자 채취 및 파종계획을 수립한다. 시설작물재배원에게 작업을 지시하고 관리한다. 작물의 품종에 따라 물주기, 거름주기, 온·습도 및 광량의 조절 등을 결정한다. 병충해 피해를 예방하기 위하여 병충해에 관한 지식을 응용하여 조사하고 약제를 조제·살포한다. 과도한 환경 변화에 따른 작물의 손상을 방지하기 위하여 환기, 난방 등을 통하여 응급조치를 한다. 상품성이 있을 정도로 성장한 작물은 수확·포장하도록 작업원들에게 지시한다. 판매를 위하여 구매자와 협의한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","connectJob":"시설물의 종류에 따라 온실재배관리자, 수경재배를 하는 경우 수경재배관리자","dJobECd":"0169","dJobECdNm":"[0169]기타 건설·전기 및 제조 관리자","dJobJCd":"1490","dJobJCdNm":"[1490]기타 건설·전기 및 생산 관련 관리자","dJobICd":"A011","dJobICdNm":"[A011]작물 재배업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004660:1', '{"dJobCd":"K000004660","dJobCdSeq":"1","dJobNm":"양식업관리자","workSum":"육상 또는 해상에서 양식시설을 설치하여 어류, 해조류, 패류 등을 양식하는 작업원의 활동을 감독하고 관리한다.","doWork":"해상에 부표, 로프, 닻 등을 이용하여 양식장을 만들거나 육상에 급·배수시설을 설치하여 양식장을 설치한다. 수산종묘를 구입한다. 양식장관리기사 및 양식장작업원을 고용한다. 양식물의 채취 및 판매계획을 수립한다. 양식장관리기사에게 지시하거나 또는 직접 양식장종사원을 지휘하여 먹이를 주기적으로 공급한다. 어장의 수질 및 영양상태를 수시로 파악하고 어장 바닥을 청소하도록 지시하여 양식장의 각종 어류, 해조류, 패류 등의 성장에 이상이 없도록 한다. 생산성 향상, 양식장의 산성화·노화를 방지하기 위하여 선박에 장치한 장비를 점검한다. 해상의 변화, 기상변화 상황을 수시로 파악하여 필요시 어장을 이동하거나 변화에 따른 시설물을 설치한다. 현미경, 수온계, 비중계 등을 사용하여 양식어장의 수온, 비중, 유속 등을 확인하여 적조현상 및 병충해상태를 확인한다. 병이 난 양식장의 생산물을 치료하고 적조현상을 해소시키기 위한 조치를 취한다. 일정기간 양식 후, 선박 및 채취기구를 사용하여 양식물을 채취한다. 판매를 위하여 구매자와 협의한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"양식원","connectJob":"양식하는 어류의 종류에 따라 가물치양식업자, 게양식업자, 광어양식업자, 메기양식업자, 미꾸라지양식업자, 새우양식업자, 송어양식업자, 잉어양식업자, 장어양식업자, 향어양식업자, 패류의 종류에 따라 굴양식업자, 조개양식업자, 진주조개양식업자, 해조류의 종류에 따라 김양식업자, 다시마양식업자, 미역양식업자","dJobECd":"0169","dJobECdNm":"[0169]기타 건설·전기 및 제조 관리자","dJobJCd":"1490","dJobJCdNm":"[1490]기타 건설·전기 및 생산 관련 관리자","dJobICd":"A032","dJobICdNm":"[A032]양식어업 및 어업관련 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007105:1', '{"dJobCd":"K000007105","dJobCdSeq":"1","dJobNm":"유기재배관리자","workSum":"유기농업의 환경분석, 생산계획 수립 등을 통해 유기재배를 준비하고, 토양 관리를 기초로 하여 유기농산물을 생산하는 업무를 수행하고, 지시·관리·감독한다.","doWork":"유기농업을 시작하기 위한 제반 환경의 분석 및 유기재배를 위한 생산계획을 수립하고, 지역 여건에 맞는 윤작체계를 결정한다. 유기재배에 적합한 토양을 조성하기 위하여 토양 검정, 퇴비제조, 토양 관리 등을 계획하고, 유기재배에 적합한 종자 종묘를 관리하며, 재배 작물에 맞게 생육단계별로 필요한 것과 생육진단에 따른 처방을 지시한다. 유기농산물에 적합한 수확시기, 수확 도구, 유기농자재 제조 관리 및 경영관리, 수확과정에서의 관행 및 타 인증 농산물과의 혼입 방지대책을 수립하고 이행한다. 유기농산물 유통경로 및 현황을 고려하여 계약 재배, 직거래, 전자상거래 등 적정 거래 방법을 선택하여 판매한다. 품목별 생산량, 출하량, 출하처 등에 대한 기록 양식을 마련하여 기록을 지시하고 관리·감독한다. 국내외 인증을 신청하여 획득하고, 규정 및 기준에 따라 인증사업자 준수사항을 관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","similarNm":"농부","certLic":"유기농업산업기사, 유기농업기사","dJobECd":"0169","dJobECdNm":"[0169]기타 건설·전기 및 제조 관리자","dJobJCd":"1490","dJobJCdNm":"[1490]기타 건설·전기 및 생산 관련 관리자","dJobICd":"A011","dJobICdNm":"[A011]작물 재배업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007110:1', '{"dJobCd":"K000007110","dJobCdSeq":"1","dJobNm":"종묘원관리자","workSum":"판매나 재식(栽植:종자 또는 식물을 심음)을 위하여 각종 나무, 꽃, 장식용 작물을 재배하는 종묘원을 관리한다.","doWork":"작물의 발아, 자라는 습성, 토양조건, 작물의 영양, 질병, 통제 필요조건 등을 응용하여 작물의 재배장소와 시장요구를 고려하여 재배할 작물의 형태나 양을 결정한다. 작물이 재배될 조건과 형태에 따라 종자와 작물의 영양물질, 질병예방약품을 선택하여 구입한다. 종묘장에 씨를 뿌려 재배, 유지 및 작물의 성장과 질병에 대해 통제한다. 시장에 출하하기 위하여 이식하거나 화분에 옮겨 심고, 나무나 꽃의 모양을 아름답게 다듬는 종묘원작업원들의 활동을 관리·감독한다. 종묘원 유지에 따른 회계와 작물의 매매 사항을 관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","similarNm":"양묘장관리자","dJobECd":"0169","dJobECdNm":"[0169]기타 건설·전기 및 제조 관리자","dJobJCd":"1490","dJobJCdNm":"[1490]기타 건설·전기 및 생산 관련 관리자","dJobICd":"A020","dJobICdNm":"[A020]임업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003792:1', '{"dJobCd":"K000003792","dJobCdSeq":"1","dJobNm":"채소작물재배관리자","workSum":"각종 채소작물의 재배 업무를 종합적으로 관리하고, 채소작물재배원 등 작업원들의 활동을 감독·조정한다.","doWork":"채소를 재배할 농지의 기후·토양조건, 시장상황 등을 감안하여 채소 품종을 선택한다. 품종과 농장의 면적을 고려하여 씨앗을 구입한다. 채소재배에 필요한 인력을 고용한다. 기자재를 점검하여 구입하거나 준비한다. 채소작물재배원이 땅갈기, 씨앗파종, 잡초제거, 비료주기, 기계관리, 수확 등을 하도록 작업방법을 지시하고 관리·감독한다. 수확한 채소를 종류와 등급별로 분류하도록 채소작물재배원에게 지시한다. 채소 판매를 위해 시장가격을 산정하여 구매자와 협의한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","connectJob":"과채작물재배관리자, 엽경채작물재배관리자, 근채작물재배관리자, 조미채소작물재배관리자","dJobECd":"0169","dJobECdNm":"[0169]기타 건설·전기 및 제조 관리자","dJobJCd":"1490","dJobJCdNm":"[1490]기타 건설·전기 및 생산 관련 관리자","dJobICd":"A011","dJobICdNm":"[A011]작물 재배업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001779:1', '{"dJobCd":"K000001779","dJobCdSeq":"1","dJobNm":"축산농장관리자","workSum":"소, 돼지, 말, 사슴, 토끼, 닭 등과 같은 가축 또는 가금을 식용이나 모피, 레저 등의 목적으로 번식·사육하는 업무를 관리하고, 관련 작업원들의 활동을 관리·감독한다.","doWork":"품종·혈통·특성에 따라 가축을 선택하고 사육한다. 목초지·방목지역을 선정하여 목초재배작업원에게 사료용 곡물 및 풀을 재배하도록 지시 및 관리한다. 가축의 먹이 조건을 감안하여 사료와 조사료를 선정·혼합하고 먹이를 먹인다. 가축에게 물, 소금 등을 공급하고 질병이나 상처의 징후를 관찰한다. 가벼운 질병이나 외부상처를 치료하고 전염병 예방접종을 한다. 수의사와 협의하여 질병이나 외상을 치료한다. 가축 새끼의 분만을 돕고 새끼를 보살핀다. 가축을 거세하거나 꼬리를 자르고 뿔을 자른다. 가축에 낙인, 문신, 꼬리표를 하여 표시한다. 우유를 짜거나 털을 자른다. 축사 및 장비를 소독한다. 가축이나 생산품을 판매하기 위하여 구매자와 협의한다. 양계사육사, 육우사육사 등의 작업원을 고용하고 감독한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|고온|다습|","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","connectJob":"양돈장관리자, 말목장관리자, 사슴농장관리자, 양목장관리자, 육우목장관리자, 젖소목장관리자, 토끼농장관리자, 양계농장관리자, 가금농장관리자, 염소목장관리자","dJobECd":"0169","dJobECdNm":"[0169]기타 건설·전기 및 제조 관리자","dJobJCd":"1490","dJobJCdNm":"[1490]기타 건설·전기 및 생산 관련 관리자","dJobICd":"A012","dJobICdNm":"[A012]축산업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006449:1', '{"dJobCd":"K000006449","dJobCdSeq":"1","dJobNm":"특용작물재배관리자","workSum":"유지, 약용, 전매, 섬유, 향료 등의 특용작물을 재배 및 판매하는 업무를 관리하고, 특용작물재배원 등을 관리·감독한다.","doWork":"기후·토양조건, 시장상황 등을 고려하여 경작가능한 특용작물을 선택한다. 품종과 농지의 면적에 따라 씨앗을 구입한다. 재배에 필요한 인력을 고용한다. 기자재를 점검하여 구입하거나 준비한다. 특용작물재배원이 땅갈기, 씨앗파종, 잡초제거, 비료주기, 기계관리, 수확 등을 하도록 작업방법을 지시하고 관리·감독한다. 수확한 작물의 종류와 등급별로 분류하도록 특용작물재배원에게 지시한다. 특용작물 판매를 위해 시장가격을 산정하여 구매자와 협의한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","connectJob":"섬유작물재배관리자, 약용작물재배관리자, 염료작물재배관리자, 유지작물재배관리자, 전매작물재배관리자, 향료작물재배관리자","dJobECd":"0169","dJobECdNm":"[0169]기타 건설·전기 및 제조 관리자","dJobJCd":"1490","dJobJCdNm":"[1490]기타 건설·전기 및 생산 관련 관리자","dJobICd":"A011","dJobICdNm":"[A011]작물 재배업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006589:1', '{"dJobCd":"K000006589","dJobCdSeq":"1","dJobNm":"화훼작물재배관리자","workSum":"꽃나무, 꽃 등 화훼작물의 재배·수확 업무를 관리하고, 화훼작물재배원의 활동을 감독·조정한다.","doWork":"식물재배에 따른 파종·수확 등에 대한 일정을 계획한다. 화훼작물재배원 등의 작업원을 배치하고 비료, 제초제, 살균제 등의 이용방법, 꽃 이식, 잡초제거, 품질 등급 산정, 포장 등에 관한 기술과 지식을 교육한다. 새로운 재배기술에 따른 작업방법을 계획한다. 온실이나 화분, 묘판 또는 피어있는 꽃을 관찰하여 잎의 결, 꽃의 크기 등의 상태를 확인한다. 습도나 온도 등의 변화를 살핀다. 작업일정을 수립하고 화훼작물재배원에게 작업량을 배당한다. 꽃재배에 필요한 각종 기구나 설비를 조사하여 수선하거나 재료의 공급을 감독한다. 화훼작물의 가격을 산정하고, 구매자와 판매 협의를 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","connectJob":"화훼작물을 분류하는 방법에 따라 구근작물재배관리자, 관엽식물재배관리자, 수경작물재배관리자, 초화작물재배관리자, 화목작물관리자, 재배 품종에 따라 난재배관리자, 다육식물재배관리자, 분재재배관리자, 선인장재배관리자, 자생식물재배관리자","dJobECd":"0169","dJobECdNm":"[0169]기타 건설·전기 및 제조 관리자","dJobJCd":"1490","dJobJCdNm":"[1490]기타 건설·전기 및 생산 관련 관리자","dJobICd":"A011","dJobICdNm":"[A011]작물 재배업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006323:1', '{"dJobCd":"K000006323","dJobCdSeq":"1","dJobNm":"광고판매관리자","workSum":"신문·잡지·서적과 같은 각종 출판물을 이용한 광고 판매에 대한 제반 업무를 기획·총괄하고, 관련 직원의 활동을 총괄 관리·감독한다.","doWork":"광고판매에 따른 구체적인 계획안을 수립한다. 수립된 계획에 따라 광고영업사무원에게 영업전략 및 작업량 등을 지시한다. 광고 판매를 위해 각종 사업체의 담당사무원과 협의한다. 광고요금 및 광고정책에 대한 정보를 제공한다. 광고영업사무원에게 판매전략을 교육시키고, 광고 판매실적을 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0151","dJobECdNm":"[0151]영업·판매 관리자","dJobJCd":"1511","dJobJCdNm":"[1511]영업 및 판매 관련 관리자","dJobICd":"M713","dJobICdNm":"[M713]광고업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004707:1', '{"dJobCd":"K000004707","dJobCdSeq":"1","dJobNm":"백화점운영부서관리자","workSum":"백화점에 입점한 각 매장들의 매출을 평가·관리한다.","doWork":"백화점 매출이나 기여도 등으로 입점한 매장에 대한 평가를 실시하고 관리한다. 백화점 매출을 제고하기 위해 수시로 행사를 기획하고 백화점 광고를 한다. 매장에서 이루어진 전표를 관리한다. 카드나 상품권 발행 및 회수에 대한 업무를 수행한다. 매장에 납품되는 물품에 대한 재고를 관리하는 작업원을 관리한다. 실적이 낮은 매장에 대한 계약 해지업무를 한다. 백화점의 매출 및 이미지 향상에 도움이 될 것으로 예상되는 매장을 신규로 선정하여 입점 업무를 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","certLic":"유통관리사","dJobECd":"0151","dJobECdNm":"[0151]영업·판매 관리자","dJobJCd":"1511","dJobJCdNm":"[1511]영업 및 판매 관련 관리자","dJobICd":"G471","dJobICdNm":"[G471]종합 소매업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002360:1', '{"dJobCd":"K000002360","dJobCdSeq":"1","dJobNm":"임대차량영업소장","workSum":"임대차량영업소의 업무를 총괄하여 관장한다.","doWork":"임대차량영업소에서 수행되는 승용차, 버스 및 기타 차량의 임대 업무를 총괄 관리한다. 임대차량영업소 직원의 복무상황을 관리하고 서비스교육을 실시한다. 월별 영업실적과 영업소인력의 실적을 본사에 보고한다. 장기 임대를 하는 대형 거래처에 대한 영업 관리를 한다. 고객을 방문하거나 고객의 내방을 받아 렌터카 내역을 소개하고 가격 등의 조건을 제시한다. 고객이 차량 임대에 동의하면 렌터카 임대차계약서를 작성한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0151","dJobECdNm":"[0151]영업·판매 관리자","dJobJCd":"1511","dJobJCdNm":"[1511]영업 및 판매 관련 관리자","dJobICd":"N761","dJobICdNm":"[N761]운송장비 임대업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005366:1', '{"dJobCd":"K000005366","dJobCdSeq":"1","dJobNm":"귀중품호송관리자","workSum":"귀중품의 안전한 호송 업무를 총괄 관리한다.","doWork":"각 거래처의 일일 수익금을 취합하여 은행으로 호송하는 업무를 전반적으로 관리한다. 호송차량 및 귀중품호송차량운전원, 귀중품호송경비원을 호송수요에 맞도록 적절히 배치를 한다. 귀중품을 수송할 경우 차량의 배분 및 수송일정을 결정한다. 중앙통제센터에서 GPS를 활용해 각 귀중품호송차량의 현재 위치와 이동경로를 파악하고 주기적인 교신을 통해 호송의 이상 유무를 확인 점검한다. 귀중품호송차량운전원에 대한 교통안전 관련 교육을 하고 안전사고 예방을 한다. 수송에 오류가 발생한 경우 직접 현장을 확인하고 수송하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0152","dJobECdNm":"[0152]운송 관리자","dJobJCd":"1512","dJobJCdNm":"[1512]운송 관련 관리자","dJobICd":"N753","dJobICdNm":"[N753]경비, 경호 및 탐정업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001460:1', '{"dJobCd":"K000001460","dJobCdSeq":"1","dJobNm":"도시철도신호제어설비관리자","workSum":"도시철도신호제어시설의 운용 및 조작, 유지·보수 및 공사 시공 등의 업무를 총괄 관리·감독한다.","doWork":"도시철도신호보안설비 및 기기의 유지관리에 관한 업무를 총괄한다. 예산, 운용물품 수급관리, 신호설비 유지관리, 공사설계 및 시공감독, 신호설비 부품의 기술개발 및 국산화 추진, 장애대책 강구 및 사고복구, 개량 개선, 연동검사 및 정밀검사, 기타 신호설비 운영에 관한 업무를 총괄한다. 소속 직원의 업무분장 및 교육, 근태관리 등의 업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"제어조작","connectJob":"도시철도통신설비관리자, 도시철도전기설비관리자","certLic":"철도신호기술사, 철도신호기사, 철도신호산업기사","dJobECd":"0152","dJobECdNm":"[0152]운송 관리자","dJobJCd":"1512","dJobJCdNm":"[1512]운송 관련 관리자","dJobICd":"H492","dJobICdNm":"[H492]육상 여객 운송업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003822:1', '{"dJobCd":"K000003822","dJobCdSeq":"1","dJobNm":"배송센터관리자","workSum":"배송센터의 운송관리 및 인력에 대한 총괄 관리를 한다.","doWork":"화물배송에 관련한 운송고객관리사무원, 화물차배차원, 화물차운전원을 포함한 운송 관련 인원의 수급 및 안전, 교육, 인사관리를 한다. 차량의 신규구매 및 배차 업무를 관장한다. 화물운송에 대한 대형고객의 불만사항, 서비스 개선사항을 관장한다. 화물배송의 입출고 관리를 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","certLic":"물류관리사","dJobECd":"0152","dJobECdNm":"[0152]운송 관리자","dJobJCd":"1512","dJobJCdNm":"[1512]운송 관련 관리자","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003015:1', '{"dJobCd":"K000003015","dJobCdSeq":"1","dJobNm":"역무자동화설비관리자","workSum":"역무자동화설비의 운용 및 정비 업무를 총괄하고 소속 직원을 지휘·감독하는 업무를 수행한다.","doWork":"역무자동화설비의 유지·보수 및 개량에 관한 계획을 수립한다. 역무자동화설비의 관리 및 중정비에 대한 기술업무를 수행한다. 역무자동화 공사의 설계·시공감독 및 공정관리와 기타 부대업무를 수행한다. 철도 정보제어실 운용과 자료의 관리, 운용통제 및 사고·장애의 처리와 원인분석 및 통계업무를 한다. 도면·대장의 관리 및 기술지도·개발 등의 업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0152","dJobECdNm":"[0152]운송 관리자","dJobJCd":"1512","dJobJCdNm":"[1512]운송 관련 관리자","dJobICd":"H491","dJobICdNm":"[H491]철도 운송업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005202:1', '{"dJobCd":"K000005202","dJobCdSeq":"1","dJobNm":"철도시설관리자","workSum":"철도의 궤도(선로), 토목구조물, 각종 보수, 운전장비 등 철도 및 지하철과 관련된 시설물을 유지·보수하는 소속 직원을 지휘·감독하는 업무를 수행한다.","doWork":"철도 및 지하철의 선로, 역사 주변의 교량·터널·방음벽 등 토목구조물에 대한 유지·보수계획을 수립한다. 궤도 보수 및 장비 운전에 종사하는 작업원들에 대한 작업지침 수립, 업무조정, 작업감독 등의 업무를 한다. 도보 또는 차량을 이용해 선로를 순회하며 복구된 시설물을 확인하고 점검한다. 사고 및 비상사태 발생 시 장비 및 인력을 조정하여 현장복구대책을 수립한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","certLic":"철도토목기사","dJobECd":"0152","dJobECdNm":"[0152]운송 관리자","dJobJCd":"1512","dJobJCdNm":"[1512]운송 관련 관리자","dJobICd":"H491","dJobICdNm":"[H491]철도 운송업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005251:1', '{"dJobCd":"K000005251","dJobCdSeq":"1","dJobNm":"철도신호제어설비관리자","workSum":"철도신호제어시설의 운용 및 조작, 유지·보수 및 공사 시공 등의 업무를 총괄 관리·감독한다.","doWork":"신호제어시설의 운용 및 조작과 유지·보수 등의 업무를 총괄 관리한다. 신호제어시설에 관한 공사의 시공감독을 감독한다. 기타 부대업무, 신호장 및 신호소 관리 및 소속 직원을 지휘·감독한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","certLic":"철도신호기술사, 철도신호기사, 철도신호산업기사","dJobECd":"0152","dJobECdNm":"[0152]운송 관리자","dJobJCd":"1512","dJobJCdNm":"[1512]운송 관련 관리자","dJobICd":"H491","dJobICdNm":"[H491]철도 운송업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004825:1', '{"dJobCd":"K000004825","dJobCdSeq":"1","dJobNm":"철도역장","workSum":"철도역의 열차운행, 여객 및 화물취급, 안전관리, 영업 등과 관련된 업무를 총괄 관리한다.","doWork":"열차운행, 수송, 영업, 매표, 안내 등 철도역의 제반 업무를 총괄 관리한다. 종사원의 업무를 조정·지시·감독한다. 안전관리를 위해 역 구내를 순찰하여 열차운행이나 여객 및 화물 수송에 문제가 있는지 점검한다. 철도역의 수입금을 관리한다. 승강기 등 철도역의 안전시설을 총괄 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0152","dJobECdNm":"[0152]운송 관리자","dJobJCd":"1512","dJobJCdNm":"[1512]운송 관련 관리자","dJobICd":"H491","dJobICdNm":"[H491]철도 운송업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004081:1', '{"dJobCd":"K000004081","dJobCdSeq":"1","dJobNm":"컨테이너부두운영관리자","workSum":"컨테이너터미널의 운영 업무를 총괄하고, 관련 종사원들의 활동을 조정·감독한다.","doWork":"본선작업(선박을 접안시킨 상태에서 선박으로부터 직접 화물을 내리거나, 선박에 싣는 작업) 상황을 감독한다. 야드 반입, 출입 작업상황을 확인하고 현장 순찰을 한다. 작업종료시간을 통제한다. 게이트 반입·출입정보처리센터를 운영하며 점검한다. 대 고객 불편신고사항을 처리한다. 운영요원의 안전, 직무, 정신교육을 실시한다. 화물의 보관 및 안전관리를 한다. 본선작업 상황에 따라 적정한 장비의 배치를 결정한다. 벌크화물(곡류, 광석 등과 같이 입자나 분말상태로 선창에 싣거나 또는 석유처럼 액체 상태로 용기에 넣지 않은 채 선박의 탱크에 싣는 화물) 작업 시 입회하여 안전감독을 한다. 위험물 작업의 안전 및 장치장 관리를 한다. 안전사고를 보고하고 처리한다. 본선작업 관련 서류를 심사하고 승인한다. 직원의 복무상황을 점검한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0152","dJobECdNm":"[0152]운송 관리자","dJobJCd":"1512","dJobJCdNm":"[1512]운송 관련 관리자","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002757:1', '{"dJobCd":"K000002757","dJobCdSeq":"1","dJobNm":"컨테이너화물집하장운영관리자","workSum":"컨테이너화물집하장(CFS:Container Freight Station)에서 화물의 반출 및 반입업무를 관리하고, 집하소의 설비와 인력을 총괄 관리한다.","doWork":"선사나 대리점이 선적할 화물을 화주로부터 인수하거나 양화된 화물을 화주에게 인도하기 위하여 지정한 장소인 컨테이너화물집하장(CFS:Container Freight Station)에 반출 및 반입되는 배정화물, 수출화물, 부두직통관 인출 작업을 확인한다. 직통관 인출 접수대장 및 수출입화물 반출입보고서, 반입사고 화물신고 등 작업상황을 확인한다. CFS 관련 종사원의 업무를 총괄하고, 안전교육을 실시한다. 이용업체의 관리대장을 확인한다. 화물유치활동을 한다. 장비를 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"CFS운영관리자","dJobECd":"0152","dJobECdNm":"[0152]운송 관리자","dJobJCd":"1512","dJobJCdNm":"[1512]운송 관련 관리자","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004120:1', '{"dJobCd":"K000004120","dJobCdSeq":"1","dJobNm":"경기장관리자","workSum":"육상경기장, 축구장, 농구장, 야구장, 경마장, 각종 실내경기장 등 경기장의 운영·유지·관리를 총괄하고, 관련 작업원의 활동을 감독·조정한다.","doWork":"경기장 운영에 필요한 인력, 장비, 예산 등에 대한 계획을 수립한다. 경기를 유치하기 위하여 경기일정, 예산 등에 대하여 경기 주최 부서와 협의·검토한다. 생활체육 프로그램 개발 및 운영에 대한 계획을 수립한다. 일반인들의 경기장 사용에 대한 사용 허가를 내린다. 경기장을 유지·보수·관리하는 작업원의 활동을 감독한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","connectJob":"경마장관리자, 실내경기장관리자, 야구장관리자, 육상경기장관리자, 축구장관리자, 경륜장관리자","dJobECd":"0141","dJobECdNm":"[0141]미용·여행∙숙박·스포츠 관리자","dJobJCd":"1521","dJobJCdNm":"[1521]숙박·여행·오락 및 스포츠 관련 관리자","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005859:1', '{"dJobCd":"K000005859","dJobCdSeq":"1","dJobNm":"경마중계소관리자","workSum":"비디오장치를 이용하여 경마경주를 중계하는 경마중계소를 관리한다.","doWork":"경마 시행정보에 따라 경마중계소의 업무계획을 수립한다. 마권의 구입, 승식, 환급과 기타 경마시행과정에 대하여 고객에게 홍보를 한다. 고객에 대한 마권 판매를 관장한다. 고객에 대한 배당금 계산 및 지급 업무를 관장한다. 경마중계소 직원들의 활동을 감독·조정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"장외발매소관리자","dJobECd":"0141","dJobECdNm":"[0141]미용·여행∙숙박·스포츠 관리자","dJobJCd":"1521","dJobJCdNm":"[1521]숙박·여행·오락 및 스포츠 관련 관리자","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001691:1', '{"dJobCd":"K000001691","dJobCdSeq":"1","dJobNm":"골프장코스관리자","workSum":"골프장 코스의 잔디를 관리하며 코스관리원의 활동을 조정 및 감독한다.","doWork":"잔디의 종류에 따른 토양 및 기후에 맞추어 잔디 관리계획을 세운다. 코스를 순찰하며 병충해 및 문제가 있는 코스에 대한 대책안을 구상한다. 잔디의 상태를 관찰하고 월별·일별 작업계획서를 작성한다. 잔디의 특성에 적합한 비료·영양제, 약품을 선택한다. 잔디관리원에게 제초, 시비, 시약, 이설, 수질관리, 배토 등의 작업을 지시하고 감독한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","similarNm":"그린키퍼, 골프장잔디관리자","dJobECd":"0141","dJobECdNm":"[0141]미용·여행∙숙박·스포츠 관리자","dJobJCd":"1521","dJobJCdNm":"[1521]숙박·여행·오락 및 스포츠 관련 관리자","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004580:1', '{"dJobCd":"K000004580","dJobCdSeq":"1","dJobNm":"도시민박운영자","workSum":"관광객 대상의 민박사업을 기획하거나 직접 민박을 운영한다.","doWork":"도시지역에 거주하고 있는 주택을 이용하여 외국인 관광객에게 한국의 가정문화를 체험할 수 있도록 숙식 등을 제공한다. 한국문화와 전통을 소개하기 위하여 관광, 식문화 체험, 동행 프로그램 등의 체험 프로그램을 소개한다. 투숙객을 위하여 내부 청소, 침구류 관리를 하며 내부 시설 및 구조에 대한 설명을 한다. 숙박객 성향에 맞춰 여행 동선을 짜주거나 조식을 제공하기도 한다. 예약을 위한 부킹 에이전시에 숙박시설을 등재하고 사진을 업로드하거나 예약 관리를 한다. SNS 등을 통하여 숙박시설을 홍보하기도 한다. 주변 역이나 공항까지 픽업 서비스를 제공하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"한옥체험운영자","dJobECd":"0141","dJobECdNm":"[0141]미용·여행∙숙박·스포츠 관리자","dJobJCd":"1521","dJobJCdNm":"[1521]숙박·여행·오락 및 스포츠 관련 관리자","dJobICd":"I551","dJobICdNm":"[I551]일반 및 생활 숙박시설 운영업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004452:1', '{"dJobCd":"K000004452","dJobCdSeq":"1","dJobNm":"스파매니저","workSum":"병원, 호텔, 피트니스 센터 등에 속한 스파시설(Spa, 물의 열, 부력 따위로 온몸의 혈액순환을 촉진하여 피부를 관리하고 몸의 스트레스를 해소할 수 있는 시설을 갖추어 놓은 가게)이나 스파체인점, 개인스파숍 등의 관리자로서 시설 및 고객을 관리한다.","doWork":"고객이 방문하면 상담을 통해 고객의 식생활, 운동습관, 생활환경 등을 확인하고, 고객에게 적합한 스파 프로그램을 계획한다. 피트니스 활동이나 식단 관련 컨설팅 프로그램을 함께 계획하기도 한다. 고객에게 피부유형에 맞는 피부관리 방법을 조언한다. 고객에게 올바른 스파문화와 요법을 알려준다. 사용하는 기기나 제품을 관리한다. 접수원, 테라피스트, 어시스턴트 등 직원들의 업무를 조정하고 관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workEnv":"고온|다습|","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","similarNm":"스파테라피스트","dJobECd":"0141","dJobECdNm":"[0141]미용·여행∙숙박·스포츠 관리자","dJobJCd":"1521","dJobJCdNm":"[1521]숙박·여행·오락 및 스포츠 관련 관리자","dJobICd":"S961","dJobICdNm":"[S961]미용, 욕탕 및 유사 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002190:1', '{"dJobCd":"K000002190","dJobCdSeq":"1","dJobNm":"운동시설관리자","workSum":"일반 대중의 체력단련과 특수운동의 기술연마를 위하여 제공되는 운동설비를 운영·유지·관리하는 업무를 총괄하고, 관련 종사원들의 활동을 감독·조정한다.","doWork":"정구장, 수영장, 골프장, 탁구장, 스케이트장, 스키장, 사격장, 골프연습장, 야구연습장, 태권도장, 권투도장, 유도장 등 운동시설의 개장시간, 운동설비의 사용, 요금의 결정과 기타 운영계획을 세운다. 고객에게 운동기술을 가르칠 직원을 면접하여 채용한다. 운동설비를 유지·보수·관리하는 작업원을 관리·감독한다. 고객에게 서비스를 제공하는 종업원들의 활동을 관리·감독한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","connectJob":"골프연습장관리원, 골프장관리원, 사격장관리자, 수영장관리자, 스케이트장관리원, 스키장관리자, 야구연습장관리자, 정구장관리자, 탁구장관리자, 경륜장관리자","dJobECd":"0141","dJobECdNm":"[0141]미용·여행∙숙박·스포츠 관리자","dJobJCd":"1521","dJobJCdNm":"[1521]숙박·여행·오락 및 스포츠 관련 관리자","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003795:1', '{"dJobCd":"K000003795","dJobCdSeq":"1","dJobNm":"유기장관리자","workSum":"일반 대중에게 오락서비스를 제공하기 위한 유기시설을 운영·유지·관리하는 업무를 총괄하고, 관련 종사원들의 활동을 감독·조정한다.","doWork":"당구장, 볼링장, 기원, 전자오락실, 댄스홀, 댄스교습소 등 유기장의 개장시간, 요금의 결정 및 기타 운영에 관한 계획을 세운다. 요금을 받거나 시설을 유지·보수·관리하는 작업원을 감독한다. 고객에게 서비스를 제공하는 종사원들의 활동을 감독한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","connectJob":"기원관리자, 당구장관리자, 댄스교습소관리자, 댄스홀관리자, 미니골프장관리자, 볼링장관리자, 전자오락실관리자, 낚시터관리자, 롤러스케이트장관리원","dJobECd":"0141","dJobECdNm":"[0141]미용·여행∙숙박·스포츠 관리자","dJobJCd":"1521","dJobJCdNm":"[1521]숙박·여행·오락 및 스포츠 관련 관리자","dJobICd":"R912","dJobICdNm":"[R912]유원지 및 기타 오락관련 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006219:1', '{"dJobCd":"K000006219","dJobCdSeq":"1","dJobNm":"유람선운영관리자","workSum":"유람선 운항과 관련 시설 운영을 총괄 관리하고, 관련 종사원들의 활동을 감독·조정한다.","doWork":"유람선의 운행일정, 승객 수 및 특성 등을 확인하여 필요 승선인원을 계획한다. 기상 환경, 승객 수, 행사계획 등에 따라 배선계획을 작성하도록 유람선운항사무원에게 지시한다. 유람선선장, 유람선승무원의 선내 안내방송 자료를 준비한다. 유람선선장 및 유람선승무원의 배선조정, 상담, 선원선발 등의 인사관리를 한다. 운영사무원 및 매표원의 인사관리를 한다. 유람선의 선착장 접안 시 운항사항 및 문제점을 점검한다. 장·단기 정기검사 등 선체관리를 계획하고 집행한다. 출입항 관리, 시간대별 승선인원 현황을 유관기관에 보고한다. 매표원에 대한 서비스교육을 실시한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","dJobECd":"0141","dJobECdNm":"[0141]미용·여행∙숙박·스포츠 관리자","dJobJCd":"1521","dJobJCdNm":"[1521]숙박·여행·오락 및 스포츠 관련 관리자","dJobICd":"H502","dJobICdNm":"[H502]내륙 수상 및 항만 내 운송업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006018:1', '{"dJobCd":"K000006018","dJobCdSeq":"1","dJobNm":"유원지관리자","workSum":"오락용 승차기구 시설을 갖춘 유원지에 대한 운영 및 관리를 총괄하고, 관련 종사원들의 활동을 조정한다.","doWork":"오락시설 이용, 동·하절기 개장시간, 행사개최 등 유원지 운영에 대한 계획을 수립한다. 고객안내, 오락시설의 조작 및 편의를 제공하는 종사원의 활동을 조정한다. 종사원에 대해 고객서비스 교육을 실시하고 감독한다. 상품매장, 식당 등 유원지에 입점한 매장의 계약 및 운영을 관리한다. 시설물 및 건물의 안전을 관리하며 유지·보수·관리하는 작업원의 활동을 감독한다. 유원지를 순찰하며 종사원들의 활동을 감독한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","dJobECd":"0141","dJobECdNm":"[0141]미용·여행∙숙박·스포츠 관리자","dJobJCd":"1521","dJobJCdNm":"[1521]숙박·여행·오락 및 스포츠 관련 관리자","dJobICd":"R912","dJobICdNm":"[R912]유원지 및 기타 오락관련 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005334:1', '{"dJobCd":"K000005334","dJobCdSeq":"1","dJobNm":"카지노관리자","workSum":"카지노의 운영 및 관리 업무를 총괄하고 종사원의 활동을 감독·조정한다.","doWork":"카지노의 영업준칙를 준수하기 위하여 카지노종사원을 지도하고 업무를 감독·조정한다. 카지노 내 칩의 유통상태를 점검한다. 시설물이 정상적으로 유지되도록 점검하고 관리한다. 고객들의 불만사항을 최종 처리한다. 입장이 불가한 고객을 선별한다. 영업활동을 분석하고 각종 영업정책을 수립한다. 컴프(Comp:고객의 게임실적에 따라 카지노사업자가 카지노 고객에게 무료로 숙식 및 교통 등의 서비스를 제공) 및 크레딧(게임하는 것을 조건으로 고객에게 칩으로 제공하는 신용대여) 관련 정책을 수립한다. 영업장 상황에 따라 게임룸이나 하우스룸 등의 운영 여부를 결정한다. 카지노 알선을 주선하는 알선업자에게 주는 수수료에 대한 기준을 설정하기도 한다. 게임 종목에 따른 피트(Pit: 테이블이 모여있는 공간)를 관리 및 운영하며 인력을 배치한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","similarNm":"카지노총지배인","connectJob":"담당 근무조의 전반적인 영업관리를 총괄하고 직원의 인사관리 담당업무를 하는 경우 쉬프트매니저","dJobECd":"0141","dJobECdNm":"[0141]미용·여행∙숙박·스포츠 관리자","dJobJCd":"1521","dJobJCdNm":"[1521]숙박·여행·오락 및 스포츠 관련 관리자","dJobICd":"R912","dJobICdNm":"[R912]유원지 및 기타 오락관련 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005023:1', '{"dJobCd":"K000005023","dJobCdSeq":"1","dJobNm":"케이블카운영관리자","workSum":"고객 및 화물을 이동시키는 케이블카의 운행 및 안전을 총괄 관리하고 관련 종사자들의 활동을 관리한다.","doWork":"케이블카의 운영 현황을 파악한다. 고객의 안전 및 서비스를 위해 종사원에 대한 업무조정, 근태관리, 서비스교육 등을 실시한다. 현장을 순회하며 주요 설비에 이상이 없는지 점검한다. 케이블카 이용요금 변경 등을 최종 결정하고 내부의 전체적인 운영을 지시한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","dJobECd":"0141","dJobECdNm":"[0141]미용·여행∙숙박·스포츠 관리자","dJobJCd":"1521","dJobJCdNm":"[1521]숙박·여행·오락 및 스포츠 관련 관리자","dJobICd":"H492","dJobICdNm":"[H492]육상 여객 운송업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005353:1', '{"dJobCd":"K000005353","dJobCdSeq":"1","dJobNm":"호텔객실관리지배인","workSum":"호텔 객실부의 운영을 계획·유지·관리하고, 객실정비 및 비품·집기 등을 관리·감독한다.","doWork":"호텔 객실부의 연간 운영계획을 수립한다. 객실부의 서비스 상태를 유지·관리한다. 객실부의 효율적인 운영을 위하여 적정인원 배치, 새로운 작업방법 도입 등을 연구·개선한다. 소속 종업원의 작업계획을 수립하고 원활히 운영되도록 지시한다. 종업원에게 효과적인 작업방법을 교육·훈련한다. 각종 비품, 도구 등이 기록장부와 일치하는지 주기적으로 확인한다. 객실정비상태 및 가용 객실상태를 확인한다. 객실관리부의 고객서비스를 관리한다. 객실관리부의 구조와 업무를 유지·개발한다. 객실의 청소 및 정비상태를 관리한다. 객실침구류, 직원 근무복 등의 세탁을 관리한다. 복도, 공공장소, 직원 공간의 청소상태를 관리한다. 객실청소 용역업체를 관리하기도 한다. 고객의 불편사항을 분석하고 해결한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"하우스키핑(Housekeeping)지배인","certLic":"호텔관리사","dJobECd":"0141","dJobECdNm":"[0141]미용·여행∙숙박·스포츠 관리자","dJobJCd":"1521","dJobJCdNm":"[1521]숙박·여행·오락 및 스포츠 관련 관리자","dJobICd":"I551","dJobICdNm":"[I551]일반 및 생활 숙박시설 운영업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005870:1', '{"dJobCd":"K000005870","dJobCdSeq":"1","dJobNm":"호텔레비뉴매니저","workSum":"호텔, 리조트 등에서 수익을 극대화하기 위해 객실 및 서비스의 예약률을 예측하고 시장상황에 따라 가격과 예약률을 탄력적으로 운영한다.","doWork":"고객의 정보(다양한 구매 시나리오, 과거 고객 데이터 등)를 분석하여 수요 창출에 가장 성공 확률이 높은 고객 집단을 파악한다. 고객의 행동 패턴을 분석하여 구매유도 방법 및 적정 가격을 도출한다. 현재 및 미래의 고객 수요(어느 가격대의 상품을 얼마나 많은 고객이 원하고 있으며 언제부터 예약하는지 등)를 예측한다. 경쟁사의 가격전략을 분석하고 차별화를 모색한다. 고객군에 따라 최적의 가격을 설정해서 상품화시킨다. 판매 및 공급방법을 매출 및 이익으로 최적화하는 방안을 모색한다. 레비뉴매니지먼트시스템(Revenue Management System:판매자가 일정 시간이 경과하면 가치가 사라지는 소멸성 자산을 한정된 수량만 가지고 있고, 판매자가 일정 세트의 가격 클래스를 가지고 있으며, 판매자가 가격을 일정기간 고정시킬 수 있고, 소비자가 사용 전에 예약하는 상품의 경우에 제한된 리소스로 최대의 수익을 내는 경영기법. 호텔, 렌터카, 열차 등에 응용됨)을 운용한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0141","dJobECdNm":"[0141]미용·여행∙숙박·스포츠 관리자","dJobJCd":"1521","dJobJCdNm":"[1521]숙박·여행·오락 및 스포츠 관련 관리자","dJobICd":"I551","dJobICdNm":"[I551]일반 및 생활 숙박시설 운영업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005476:1', '{"dJobCd":"K000005476","dJobCdSeq":"1","dJobNm":"호텔총지배인","workSum":"호텔의 숙박시설과 각종 부대시설에서 종사하는 종업원들의 업무를 감독·조정하고 제반 업무를 총괄 지휘한다.","doWork":"호텔의 효율적인 운영을 위하여 종업원의 업무를 관리하고 고객 접대서비스의 개선에 관하여 지시한다. 객실배정업무를 지휘한다. 광고, 선전, 홍보 등의 판촉활동을 관리한다. 재무 및 회계업무를 관리한다. 연회장, 식당, 바, 커피숍, 나이트클럽 등 부대시설의 운영계획을 관리한다. 단위사업장이나 업무수행 분야별로 자금을 분배하고 지출을 인가한다. 종업원의 채용을 계획한다. 대외적인 활동, 매출신장, 원가절감, 종업원의 사기 진작, 후생복리 등의 관리업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"GM(제너럴매니저)","certLic":"호텔경영사","dJobECd":"0141","dJobECdNm":"[0141]미용·여행∙숙박·스포츠 관리자","dJobJCd":"1521","dJobJCdNm":"[1521]숙박·여행·오락 및 스포츠 관련 관리자","dJobICd":"I551","dJobICdNm":"[I551]일반 및 생활 숙박시설 운영업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004323:1', '{"dJobCd":"K000004323","dJobCdSeq":"1","dJobNm":"호텔현관지배인","workSum":"호텔투숙객의 객실 배정·퇴실을 관장하고, 호텔현관종사원들의 업무를 지시·감독한다.","doWork":"호텔 투숙의 예약상황을 검토하여 예약처리지침을 전달한다. 고객의 예약여부를 확인하여 객실을 배정해 준다. 예약고객이 아닌 경우에는 여분 객실의 여부, 객실의 종류, 객실의 가격 등을 결정하여 객실을 배정한다. 호텔현관사무원의 근무인원을 안배하여 근무시간표를 작성한다. 현장에서 호텔현관사무원들의 업무내용을 수시로 확인하고 직원들이 숙지하여야 할 사항은 별도로 정리하여 부하직원들에게 알린다. 객실이 만실일 경우에는 예약현황을 수시로 점검하여 예약내용을 조정한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"프런트데스크지배인","certLic":"호텔관리사","dJobECd":"0141","dJobECdNm":"[0141]미용·여행∙숙박·스포츠 관리자","dJobJCd":"1521","dJobJCdNm":"[1521]숙박·여행·오락 및 스포츠 관련 관리자","dJobICd":"I551","dJobICdNm":"[I551]일반 및 생활 숙박시설 운영업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004537:1', '{"dJobCd":"K000004537","dJobCdSeq":"1","dJobNm":"외식업체매니저","workSum":"패밀리레스토랑, 패스트푸드점, 외국음식전문점 등 음식점의 운영과 영업, 종업원들을 총괄 관리한다.","doWork":"음식점의 매출을 증진시키기 위해 영업전략을 수립한다. 일일 또는 월간, 연간 매출을 분석한다. 직원의 근무스케줄을 조정하고 업무를 총괄 지휘한다. 서비스교육과 위생교육 등을 실시한다. 음식점의 홀 및 주방, 화장실 등의 청결상태를 점검한다. 고객과 문제가 생겼을 때 이를 해결한다. 고객의 불편사항을 파악하여 개선안을 수립한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"페밀리레스토랑매니저","connectJob":"외식업체점장","dJobECd":"0142","dJobECdNm":"[0142]음식서비스 관리자","dJobJCd":"1522","dJobJCdNm":"[1522]음식 서비스 관련 관리자","dJobICd":"I561","dJobICdNm":"[I561]음식점업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004458:1', '{"dJobCd":"K000004458","dJobCdSeq":"1","dJobNm":"유람선식당지배인","workSum":"유람선 승객의 편의와 식사를 위한 서비스를 지휘·감독하고, 식당의 위생 및 승객의 안전사항을 점검한다.","doWork":"유람선 승객 수, 특성, 주문메뉴 등을 미리 파악하여 식사준비를 계획한다. 주방의 조리 및 음식서비스를 총괄 관리하며, 주방종사원을 교육·훈련하는 업무를 관리·감독한다. 필요한 식자재를 관련 부서에 청구한다. 주방종사원에게 지시하여 외부에서 준비한 음식을 유람선 내부로 운반시킨다. 손님을 영접하고 안전한 승선을 돕는다. 유람선 내 좌석배치를 하고, 유람선 소개, 라이프재킷 착용방법, 관광포인트 등에 대해 안내한다. 주방종사원의 서비스 교육 및 업장의 고객관리를 총괄한다. 승객의 전망대 이동 시 안전을 점검하며, 이벤트 담당자에 의한 여흥을 주관한다. 하선 시 안전하선을 유도하고 환송인사를 한다. 고객의 불편사항을 처리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0142","dJobECdNm":"[0142]음식서비스 관리자","dJobJCd":"1522","dJobJCdNm":"[1522]음식 서비스 관련 관리자","dJobICd":"H502","dJobICdNm":"[H502]내륙 수상 및 항만 내 운송업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005241:1', '{"dJobCd":"K000005241","dJobCdSeq":"1","dJobNm":"호텔식음업장지배인","workSum":"호텔 식음업장의 운영과 영업을 총괄 관리하고, 종업원들의 활동을 관리·감독한다.","doWork":"호텔 식음업장의 매출을 증진시키기 위한 영업방안을 모색한다. 판매량과 고객취향 등을 파악하여 메뉴계획을 세운다. 월별 계절별 식·음료 이벤트를 계획하고 실시한다. 종업원에게 업장의 청결·위생, 기물관리를 지시한다. 식·음료부 직원들의 활동과 근무상황을 관리하고 서비스 교육을 실시한다. 일일 및 매월 매출을 분석한다. 업장의 고객관리를 총괄하고, 불편사항을 처리한다. 종업원 채용을 계획하고 실시한다. 각 업장지배인의 역할을 지도·감독하고 정기적으로 부서 영업회의를 주관한다. 관계부서와의 업무협조가 원활히 유지되도록 관리·감독한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","connectJob":"레스토랑지배인","dJobECd":"0142","dJobECdNm":"[0142]음식서비스 관리자","dJobJCd":"1522","dJobJCdNm":"[1522]음식 서비스 관련 관리자","dJobICd":"I551","dJobICdNm":"[I551]일반 및 생활 숙박시설 운영업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001614:1', '{"dJobCd":"K000001614","dJobCdSeq":"1","dJobNm":"공공폐수처리시설관리자","workSum":"산업단지 내 폐수배출업체에서 나오는 폐수를 정화하는 시설을 총괄 관리하고, 관련 작업원의 활동을 관리·감독한다.","doWork":"월·분기·연 단위로 산업폐수정화 작업계획을 수립한다. 화학처리 및 생물학적처리 등 산업폐수 정화업무를 수행하는 작업원의 활동을 감독하고 시정사항을 지시한다. 산업폐수 정화과정에 대한 환경법 규정 준수 여부를 확인·검사·예방·조치한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","certLic":"수질환경기사, 수질환경산업기사","dJobECd":"0143","dJobECdNm":"[0143]경비·청소 관리자","dJobJCd":"1530","dJobJCdNm":"[1530]환경·청소 및 경비 관련 관리자","dJobICd":"E370","dJobICdNm":"[E370]하수, 폐수 및 분뇨 처리업","inqYear":"2021","etc":"과거 폐수종말처리시설이 2017년 법령으로 공공폐수처리시설로 변경됨. 산업단지내 산업폐수를 정화처리하는 곳임. 수탁받아 정화처리하지 않고 산업단지내 배출폐수를 처리하고 있음. 정화처리를 위해 크게 화학적처리, 생물학적처리를 진행함. 자격은 수질환경기사, 산업기사가 필요함."}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001228:1', '{"dJobCd":"K000001228","dJobCdSeq":"1","dJobNm":"공동주택관리사무소장","workSum":"공동주택 및 그 부대시설의 운영관리, 유지보수 및 안전관리 등의 업무를 실시하고 이에 필요한 경비를 관리하며, 공동주택관리사무소의 운영과 직원을 지휘·감독한다.","doWork":"공동주택의 관리업무계획과 시행 실태를 확인·지도·감독한다. 공동주택의 관리현황 및 각종 시설물을 확인하고 안전상태를 점검한다. 보수가 필요한 시설물에 대한 보수계획을 수립한다. 보수 자재의 구매와 사용실태를 점검한다. 정기적으로 입주자 대표와 입주자들의 민원사항을 협의·조정하고 문제점을 해결한다. 직원들의 지도와 교육을 기획하고 시행한다. 관리비 및 공과금 납부 대행을 계획한다. 관리사무소 수입과 지출사항 등의 각종 회계업무를 수행하고 감독한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","similarNm":"공동주택관리소장","connectJob":"아파트관리사무소장, 연립주택관리사무소장, 빌딩관리사무소장, 상가건물관리사무소장, 오피스텔관리사무소장(다만 아파트 연립주택만 공동주택에 포함됨)","certLic":"주택관리사보, 주택관리사, 빌딩관리사","dJobECd":"0143","dJobECdNm":"[0143]경비·청소 관리자","dJobJCd":"1530","dJobJCdNm":"[1530]환경·청소 및 경비 관련 관리자","dJobICd":"L682","dJobICdNm":"[L682]부동산 관련 서비스업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002070:1', '{"dJobCd":"K000002070","dJobCdSeq":"1","dJobNm":"세탁소관리자","workSum":"세탁소의 운영을 총괄 관리하고, 세탁물의 접수·세탁·다림질하는 작업원의 활동을 감독·조정한다.","doWork":"고객으로부터 세탁물을 접수하여 종류별로 분류하여 작업을 할당한다. 세탁물을 세탁하고 다림질하는 작업원의 활동을 감독·조정한다. 세탁물과 기록표를 대조하여 고객에게 세탁물을 인계한다. 요금을 계산하고 장부에 기록한다. 세탁물의 사고를 방지하기 위하여 직원들에게 세탁기술에 관하여 조언한다. 사고가 발생한 세탁물에 대한 배상을 한다. 세탁방법 및 기계에 관련된 정보를 수집한다. 무인세탁소의 경우, 매장 및 세탁 기계 관리, 운영을 한다. 고객의 민원에 즉각적으로 대응한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|다습|소음·진동|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"수동조작","dJobECd":"0143","dJobECdNm":"[0143]경비·청소 관리자","dJobJCd":"1530","dJobJCdNm":"[1530]환경·청소 및 경비 관련 관리자","dJobICd":"S969","dJobICdNm":"[S969]그 외 기타 개인 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;