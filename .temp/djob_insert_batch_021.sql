INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007404:1', '{"dJobCd":"K000007404","dJobCdSeq":"1","dJobNm":"영화홍보마케터","workSum":"영화의 콘셉트에 따라 관객의 호기심을 유발할 수 있는 커뮤니케이션과 마케팅 전략을 수립한다.","doWork":"영화 마케팅 전략을 수립하고 운영한다. 마케팅 스케쥴 및 예산, 대행사를 관리한다. 마케팅 컨셉이 확정되면 홍보대행사, 온라인 대행사, 광고대행사와 논의하고 논의내용을 제작사와 공유한다. 온·오프라인 광고 매체를 관리한다. 크리에이티브를 기획 및 제작하고 카피라이팅 작업을 한다. 홍보 매체전략을 수립하고 언론사 보도자료와 콘텐츠를 관리한다. 시사회, 프로모션, 이벤트 등 마케팅 관련 스케쥴을 기획하고 운영한다. 스텝시사회, 개봉 무대인사 등 각종 홍보행사를 진행하고 SNS를 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"영화마케터","dJobECd":"0241","dJobECdNm":"[0241]광고·홍보 전문가","dJobJCd":"2733","dJobJCdNm":"[2733]광고 및 홍보 전문가","dJobICd":"M713/R901","dJobICdNm":"[M713]광고업 / [R901]창작 및 예술관련 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002156:1', '{"dJobCd":"K000002156","dJobCdSeq":"1","dJobNm":"옥외광고매체기획원","workSum":"광고수용자가 많은 공간(공항, 지하철, 상가, 고속도로, 도로, 도심의 건물 등)을 확보하며, 그 공간에 적합한 광고매체를 기획한다.","doWork":"공항, 지하철, 상가, 고속도로, 도로, 도심의 건물 등 광고수용자가 많은 공간을 광고매체로 사용하기 위해 관급공사 등의 입찰에 참여한다. 건물주와 만나서 광고이용에 관한 협의를 하는 등의 영업활동을 한다. 개발된 매체에 실린 광고물에 대한 관리를 한다. 광고주가 제공한 광고물에 대한 관련 심의를 유관기관에 신고하여 얻는다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0241","dJobECdNm":"[0241]광고·홍보 전문가","dJobJCd":"2733","dJobJCdNm":"[2733]광고 및 홍보 전문가","dJobICd":"M713","dJobICdNm":"[M713]광고업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002680:1', '{"dJobCd":"K000002680","dJobCdSeq":"1","dJobNm":"온라인평판관리원","workSum":"온라인에서 고객의 평판을 관리하고 긍정적인 평판을 유도하는 일을 한다.","doWork":"고객과 전화, 면담, 이메일 등을 통해 보안유지, 성과사례, 예상비용, 평판관리 방법 및 절차 등을 상담한다. 계약서를 작성한다. 온라인에서의 상품, 서비스, 정치적 활동, 게시물, 보도자료 등을 수집·관리하고 모니터링한다. 부정적인 평판의 정도, 유형, 이유, 게시자, 사실관계, 전후관계 등을 파악하고 분석하여 대응방안을 기획한다. 고객에게 대응방안을 설명하고 평판관리를 위하여 고객 스스로 취할 행동을 제안한다. 댓글게시, 보도자료 작성 및 배포, 악성 내용 생산자에 대한 법적조치, 게시물 삭제, 포털사이트 검색순위 높이기, 부정적 평판에 대한 대응게시물 게재 등의 방법으로 온라인상의 악성 내용을 해결하고 긍정적인 평판을 유도한다. 평판관리 전후의 변화를 분석하고 보고서를 작성한다. 지속적인 모니터링을 통해 평판을 유지·관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"온라인평판관리자, 사이버평판관리자","connectJob":"디지털장의사","certLic":"정보관리기술사, 정보처리기사, 정보처리산업기사","dJobECd":"0241","dJobECdNm":"[0241]광고·홍보 전문가","dJobJCd":"2733","dJobJCdNm":"[2733]광고 및 홍보 전문가","dJobICd":"M715","dJobICdNm":"[M715]회사 본부 및 경영 컨설팅 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007405:1', '{"dJobCd":"K000007405","dJobCdSeq":"1","dJobNm":"웹마케터","workSum":"웹에서 고객과 양방향 소통을 통해 전자상거래를 활성화하기 위한 마케팅을 기획하고 실행한다.","doWork":"회원의 구매 성향을 분석한다. 상품전 및 이벤트를 기획한다. 상품의 전자상거래 가능 여부를 판단한다. 각 상품마케팅에 적절한 예산을 편성한다. 상품 구매 선상에 근접해 있는 회원에게 상품을 광고한다. 상품 판매결과를 분석하고 경영자에게 보고한다. 기업 홍보를 기획하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"설득","workFunc3":"관련없음","dJobECd":"0241","dJobECdNm":"[0241]광고·홍보 전문가","dJobJCd":"2733","dJobJCdNm":"[2733]광고 및 홍보 전문가","dJobICd":"G479","dJobICdNm":"[G479]무점포 소매업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007406:1', '{"dJobCd":"K000007406","dJobCdSeq":"1","dJobNm":"이스포츠마케터","workSum":"이스포츠 대회 기획 및 운영을 통해 게임을 홍보한다.","doWork":"이스포츠 대회 운영 시스템을 개발하고 홍보 이벤트를 기획한다. 사업 팀, 디자인팀, 운영 팀, 게임 개발팀과의 협업을 통해 리그 방식을 결정하고 스폰서사를 유치한다. 방송사와 협의를 통해 방송 리그를 기획하여 방송을 통한 홍보 효과를 극대화한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","connectJob":"게임마케터","dJobECd":"0241","dJobECdNm":"[0241]광고·홍보 전문가","dJobJCd":"2733","dJobJCdNm":"[2733]광고 및 홍보 전문가","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002418:1', '{"dJobCd":"K000002418","dJobCdSeq":"1","dJobNm":"컴퓨터애니메이션마케터","workSum":"개발된 컴퓨터애니메이션의 홍보전략을 세우고 소비자에게 애니메이션을 홍보한다.","doWork":"관련 업계 및 경쟁사의 자료를 수집하여 마케팅 동향을 파악한다. 소비자 조사를 통해 고객의 의견을 반영한 마케팅전략을 수립한다. 홍보계획과 예산계획을 수립한다. 대외홍보를 위해 언론은 물론 각종 영상물, 정보서비스, 기념행사 등을 통해 자사 애니메이션을 홍보한다. 유통사 등과 판매전략, 수출업무 등에 대한 논의를 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0241","dJobECdNm":"[0241]광고·홍보 전문가","dJobJCd":"2733","dJobJCdNm":"[2733]광고 및 홍보 전문가","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006373:1', '{"dJobCd":"K000006373","dJobCdSeq":"1","dJobNm":"크라우드펀딩마케터","workSum":"크라우드펀딩 프로젝트를 홍보하여 기업 및 사업 프로젝트 자금을 성공적으로 유치하도록 돕는다.","doWork":"크라우드펀딩 진행이 확정된 펀딩프로젝트의 자금을 성공적으로 조달할 수 있도록 마케팅전략을 수립한다. 펀딩에 관심이 높은 투자자를 선정하고 이들에게 펀딩프로젝트를 홍보할 수 있는 채널과 방식을 찾는다. 펀딩 시작 전, 펀딩 진행 중, 펀딩 종료 단계별로 적절히 홍보를 한다. 이미지, 카드뉴스, 동영상 등 대중투자자들이 이해하기 쉬운 방식으로 펀딩 소개자료를 제작하고 SNS, 이메일, 온라인 광고 등을 통해 투자자들의 펀딩참여를 유도한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"설득","workFunc3":"관련없음","dJobECd":"0241","dJobECdNm":"[0241]광고·홍보 전문가","dJobJCd":"2733","dJobJCdNm":"[2733]광고 및 홍보 전문가","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007413:1', '{"dJobCd":"K000007413","dJobCdSeq":"1","dJobNm":"퍼포먼스마케터","workSum":"데이터를 수집하고 분석하여 소비자의 행동별 맞춤 타깃팅 광고를 운영한다.","doWork":"웹사이트, 페이스북, 구글Ads, 인스타그램, 네이버 등에서 채널을 운영한다. 다양한 채널을 조사하고 활용해 성과를 개선한다. 온라인 사이트의 각 카테고리별 운영하는 마케팅 캠페인들의 홍보 데이터를 분석하고 프로세스를 최적화한다. 온라인 마케팅 지표들을 기반으로 마케팅 캠페인의 문제점과 개선점을 도출한다. 광고 서비스의 특징에 따라 소비자의 행동을 정의하고 실시된 캠페인의 효과를 데이터로 검증한다. 데이터를 기반으로 캠페인의 개선방안 등을 결정한다. 반복적인 최적화 작업을 통해 최소의 비용으로 최대의 효율을 거둘 수 있도록 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","connectJob":"그로스해커","dJobECd":"0241","dJobECdNm":"[0241]광고·홍보 전문가","dJobJCd":"2733","dJobJCdNm":"[2733]광고 및 홍보 전문가","dJobICd":"M713","dJobICdNm":"[M713]광고업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003573:1', '{"dJobCd":"K000003573","dJobCdSeq":"1","dJobNm":"프레젠테이션기획자","workSum":"고객의 의뢰에 따라 청중에게 전달한 내용을 체계적으로 정리하고 시각적인 표현기법으로 청중을 이해시키고 설득할 수 있도록 프레젠테이션을 기획하고 제작하며 관련 교육 및 컨설팅을 한다.","doWork":"기획할 프레젠테이션의 목적과 성격, 발표시간 및 분량 등을 고객과 협의한다. 제공받은 자료를 토대로 내용을 정리하여 프레젠테이션 틀을 잡기 위한 스토리보드 작업과 제작전략을 구상한다. 전체적인 틀이 기획되면 구체적으로 각각의 슬라이드를 어떤 콘셉트와 디자인으로 제작할 것인지 스토리보드에 구체적으로 그려 넣어 시안을 작성한다. 기초안에 대해 고객과 협의한 후 수정·보완한다. 이를 토대로 슬라이드를 제작하고, 애니메이션이나 내레이션 등을 넣는다. 고객 앞에서 시연을 하고, 수정을 거쳐 최종 완성한다. PT 제작 및 활용에 대해 교육 및 컨설팅을 하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"언어력|시각|","workFunc1":"분석","workFunc2":"설득","workFunc3":"제어조작","similarNm":"PT컨설턴트, PT기획자","dJobECd":"0241","dJobECdNm":"[0241]광고·홍보 전문가","dJobJCd":"2733","dJobJCdNm":"[2733]광고 및 홍보 전문가","dJobICd":"M715","dJobICdNm":"[M715]회사 본부 및 경영 컨설팅 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007132:1', '{"dJobCd":"K000007132","dJobCdSeq":"1","dJobNm":"해외전시행사마케팅전문가","workSum":"해외에서 열리는 전시회 참가를 위해 업체를 모집하고 관련 업무수행을 통해 참가업체들의 전시회 참가를 촉진·지원한다.","doWork":"해외에서 열리는 전시회 일정 및 장소에 대한 정보를 수집한다. 참가할 전시회를 결정하고 예산 등을 포함한 기본 참가계획을 수립한다. 참가전시회와 관련된 업체를 대상으로 영업활동 및 홍보활동을 한다. 전시회 참가에 필요한 협력업체(운송, 설치, 통역 등)를 선정하고 계약한다. 참가전시회의 주최자와 협조체계를 구축한다. 전시회 참가등록을 대행한다. 현지에서 전시와 관련된 업무를 수행한다. 결과보고서를 작성한다. 해외 전시회의 국내 에이전트 자격을 확보하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"조정","workFunc2":"설득","workFunc3":"관련없음","certLic":"컨벤션기획사","dJobECd":"0241","dJobECdNm":"[0241]광고·홍보 전문가","dJobJCd":"2733","dJobJCdNm":"[2733]광고 및 홍보 전문가","dJobICd":"N759","dJobICdNm":"[N759]기타 사업지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003685:1', '{"dJobCd":"K000003685","dJobCdSeq":"1","dJobNm":"홍보기획원","workSum":"고객 혹은 자사의 대외홍보를 위해 홍보물, 매체, 비용 등의 제반 사항을 분석하고 기획한다.","doWork":"홍보의 목적, 대상, 전개방법, 비용 등이 담긴 홍보기획서를 작성하여 홍보계획을 수립한다. 홍보계획에 따라 사내 화보제작팀, 영상제작팀, 미디어관리팀, 마케팅팀 등과 상의하여 기업소개 자료, 언론보도 자료, 영상홍보물 제작, 미디어 광고지면 구매, 방송인터뷰 및 간담회 등을 기획한다. 기획된 내용들이 실행되고 있는지 모니터링하며 실행이 잘 안 되는 부분이 있으면 관련 부서와 함께 기획서를 검토하고 개선방안을 협의한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"광고홍보기획원, 홍보기획자","dJobECd":"0241","dJobECdNm":"[0241]광고·홍보 전문가","dJobJCd":"2733","dJobJCdNm":"[2733]광고 및 홍보 전문가","dJobICd":"M715","dJobICdNm":"[M715]회사 본부 및 경영 컨설팅 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001568:1', '{"dJobCd":"K000001568","dJobCdSeq":"1","dJobNm":"부동산정보분석사","workSum":"아파트, 토지, 빌라 등 각종 부동산 시세 등의 정보를 수집·분석하여 고객에게 알려준다.","doWork":"부동산 매물정보 및 사용자 행동이력 데이터, 부동산 시장정보를 분석하여 고객이 원하는 매물정보를 제공한다. 매물 시세정보와 지역 부동산정보 등을 정량적으로 데이터화하고 분석 알고리즘을 통해 분석된 자료를 고객에게 제공하여 맞춤형 부동산을 추천할 수 있도록 한다. 대용량의 부동산 데이터를 실시간으로 갱신하여 제공한다. 통계정보, 주거정보, 과세정보, 교통정보, 도시계획 등 다양한 부동산정보를 융합하고 분석하여 제공한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"부동산시세분석사, 부동산데이터분석가","dJobECd":"0242","dJobECdNm":"[0242]조사 전문가","dJobJCd":"2734","dJobJCdNm":"[2734]조사 전문가","dJobICd":"L682","dJobICdNm":"[L682]부동산 관련 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005258:1', '{"dJobCd":"K000005258","dJobCdSeq":"1","dJobNm":"사회조사연구원","workSum":"사회조사를 위한 준비와 실제 조사를 설계하고 결과를 분석한다.","doWork":"고객이 의뢰한 조사의 수용가능 여부를 판단한다. 조사에 대한 목적, 대상, 표본크기, 범위, 기간, 방법 등에 대하여 팀원과 협의한다. 판단을 통해 실사가이드를 제작한다. 설문지를 설계한다. 면접원들에게 조사의 성격 및 방법 등을 교육한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"사회조사전문가, 사회조사분석가","certLic":"사회조사분석사(1급, 2급)","dJobECd":"0242","dJobECdNm":"[0242]조사 전문가","dJobJCd":"2734","dJobJCdNm":"[2734]조사 전문가","dJobICd":"M714","dJobICdNm":"[M714]시장조사 및 여론조사업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005382:1', '{"dJobCd":"K000005382","dJobCdSeq":"1","dJobNm":"소비자분석연구원","workSum":"상품과 소비자 구매행태의 변화를 분석하여 소비재 시장현황과 트렌드를 연구한다.","doWork":"소비자행태연구의 일환으로 소비자 행동과 태도의 변화에 대한 연구를 실시한다. 사안에 따라 설문조사계획안을 수립하고 실행한다. 성별, 연령별, 경제력별, 학력별, 거주지별 주요 소비자군의 행동변화 등에 대한 자료를 수집한다. 사회·경제적, 문화적, 정치적 상황 등의 변화 및 기술의 발달이 소비자의 행동에 미치는 영향을 분석한다. 소비자의 구매패턴에 대한 연구를 실시한다. 소비자반응모델, 소비자행동모델, 수요예측모델 등에 대한 연구를 실시하고 개발한다. 각종 통계학적, 심리학적, 경영학적, 사회학적 이론과 기법을 이용하기도 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"마케팅연구원","connectJob":"마케팅조사연구원","certLic":"소비자전문상담사(1급, 2급)","dJobECd":"0242","dJobECdNm":"[0242]조사 전문가","dJobJCd":"2734","dJobJCdNm":"[2734]조사 전문가","dJobICd":"M714","dJobICdNm":"[M714]시장조사 및 여론조사업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003433:1', '{"dJobCd":"K000003433","dJobCdSeq":"1","dJobNm":"시장조사분석가","workSum":"마케팅계획 수립 등을 위해 시장규모, 미래현황, 유통채널, 소비자, 경쟁업체 등에 관한 조사를 수행하고 분석·평가한다.","doWork":"해당 기업의 마케팅팀과 미팅을 통해 신제품 개발, 디자인, 수요예측, 시장점유율, 제품관리, 광고효과 등 시장전략 수립에 대한 내용을 청취하여 전략수립을 위한 시장조사 방식을 협의한다. 정량적인 데이터를 사용하여 정성적인 분석을 한다. 정량분석을 위한 조사계획(조사대상, 조사범위, 조사숫자, 조사방법 등)을 수립한다. 전화설문, 면대면 인터뷰, 심층토론(Focus Group Interview), 문서설문, 인터넷 설문 등을 통해 자료를 수집한다. 설문조사에서 수집된 내용과 자료를 코딩하여 전산처리할 수 있도록 지시한다. 조사된 내용과 자료를 통계분석프로그램을 사용하여 분석하고 보고서를 작성한다. 작성된 보고서를 토대로 해당 기업에 조사내용을 발표(프레전테이션)한다. 다음단계의 시장조사계획을 수립한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"시장조사전문가, 시장분석연구원","certLic":"사회조사분석사(1급, 2급)","dJobECd":"0242","dJobECdNm":"[0242]조사 전문가","dJobJCd":"2734","dJobJCdNm":"[2734]조사 전문가","dJobICd":"M714","dJobICdNm":"[M714]시장조사 및 여론조사업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003471:1', '{"dJobCd":"K000003471","dJobCdSeq":"1","dJobNm":"여론조사분석가","workSum":"정당이나 기타 공공단체를 비롯한 각 단체들이 국민의식의 변화에 대한 정보나 유권자 의식정보, 투표행태정보, 단체에 대한 이미지나 이용행태 등 각 단체들이 원하는 여론조사자료를 설문법 등을 통하여 수집·분석하여 제공한다.","doWork":"의뢰인과 용역의 특성 등에 관한 자료를 검토하여 그 특성을 반영할 수 있는 조사계획안을 수립한다. 구체적인 조사방식(개별방문, 가정방문, 전화, 우편 등)과 조사규모(표본의 수), 조사계획(조사기간 등)을 의뢰인에게 설명하고 확정한다. 확정된 시장조사회사의 정량분석팀과 미팅을 통해 계획안에 있는 구체적인 내용들을 설명하고 필드매니저(설문조사원들을 감독하고 설문을 수행하는 관리자)에게 조사대상, 조사방법, 설문내용 등에 대해 주지시킨다. 현장설문조사가 진행되는 동안 진척사항을 모니터링 하며 모든 조사가 원활히 진행될 수 있도록 지시 감독하며 협의한다. 설문조사가 완성되면 코딩 후 통계프로그램을 통해 분석을 하고 보고서를 작성한다. 작성된 리포트를 의뢰인에게 제출하며 분석내용을 발표한다. 정치 관련 여론조사의 경우 유권자의 투표행태, 정치의식과 정치인식 등에 대한 조사연구를 주로 하며, 시청률이나 브랜드 인지도 등에 대한 조사를 수행하기도 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"여론조사연구원","certLic":"사회조사분석사(1급, 2급)","dJobECd":"0242","dJobECdNm":"[0242]조사 전문가","dJobJCd":"2734","dJobJCdNm":"[2734]조사 전문가","dJobICd":"M714","dJobICdNm":"[M714]시장조사 및 여론조사업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004539:1', '{"dJobCd":"K000004539","dJobCdSeq":"1","dJobNm":"인터넷이용자정보분석원","workSum":"인터넷 사용자의 인적사항 및 접속패턴에 관한 통계를 수집·분석하여 각 요구 부서에 전달한다.","doWork":"인터넷 가입자 개인별 연령, 직업, 거주지역 등 가입자현황에 관한 통계를 파악하고 가입기간, 이용시간에 관한 통계를 추출한다. 로그 데이터에 의한 접속패턴에 관한 통계자료를 파악하고 각 메뉴별 사용시각 및 사용자 수, 접속횟수 등의 서비스 이용통계에 관한 각종 통계자료를 수집한다. 수집된 자료를 통계패키지프로그램을 이용하여 용도별로 분석하여 각 부서의 요구에 따라 전달한다. 사내 정보시스템을 구축하고 업무에 필요한 각종 통계자료를 제공한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0242","dJobECdNm":"[0242]조사 전문가","dJobJCd":"2734","dJobJCdNm":"[2734]조사 전문가","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003894:1', '{"dJobCd":"K000003894","dJobCdSeq":"1","dJobNm":"임상통계전문가","workSum":"임상실험을 통계학적으로 입증한다.","doWork":"임상실험 결과를 통계학적 이론과 기법을 활용하여 분석함으로써 약의 효과성과 안전성을 객관적으로 입증한다. 통계학적 분석을 활용해 신약개발을 위한 기초자료를 제공한다. 기타 통계분석을 위해 자료를 수집·정리한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"0242","dJobECdNm":"[0242]조사 전문가","dJobJCd":"2734","dJobJCdNm":"[2734]조사 전문가","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001961:1', '{"dJobCd":"K000001961","dJobCdSeq":"1","dJobNm":"정성조사진행자","workSum":"제품에 대한 소비자의 인식 등 정성적인 정보를 파악하기 위해 좌담회(FGI)나 심층면접 등을 계획하고 진행한다.","doWork":"의뢰인과 상담을 통해 조사목적, 조사대상, 예산 등을 확인한다. 조사집단의 특성, 규모, 조사방법, 장소, 시간, 날짜 등 조사계획을 수립하고 의뢰인과 협의한다. 질문 가이드라인을 설정한다. 적격자 선별기준을 설정하고 조사사무원에게 좌담회, 심층면접 참석자 선정을 지시한다. 투사기법 등 심리기법과 관련 기법을 사용하여 제품에 대한 인식, 선호도, 사용습관 등을 질문하고 좌담회나 심층면접을 진행한다. 참석자들의 담론을 분석하여 제품의 인식 및 행태를 분석한다. 결과를 정리하여 보고서로 작성하고 의뢰인에게 제공한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"모더레이터(Moderator)","dJobECd":"0242","dJobECdNm":"[0242]조사 전문가","dJobJCd":"2734","dJobJCdNm":"[2734]조사 전문가","dJobICd":"M714","dJobICdNm":"[M714]시장조사 및 여론조사업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003453:1', '{"dJobCd":"K000003453","dJobCdSeq":"1","dJobNm":"조사자료분석원","workSum":"데이터 처리가 끝난 자료를 통계프로그램을 이용하여 분석한다.","doWork":"처리된 데이터의 성격과 종류를 파악한다. 알맞은 통계분석방법(회귀분석, 분산분석, 요인분석 등)을 선택한다. 통계프로그램을 이용하여 코딩된 데이터를 분석한다. 논리적 오류나 분석오류를 찾아내고 교정한다. 분석된 데이터를 관련 연구원에게 보고서 형태로 제공한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"사회조사분석사(1급, 2급)","dJobECd":"0242","dJobECdNm":"[0242]조사 전문가","dJobJCd":"2734","dJobJCdNm":"[2734]조사 전문가","dJobICd":"M714","dJobICdNm":"[M714]시장조사 및 여론조사업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004522:1', '{"dJobCd":"K000004522","dJobCdSeq":"1","dJobNm":"통계컨설턴트","workSum":"연구나 사업계획 수립에 요구되는 통계기법이나 표본 수 등에 대해 조언하고 통계자료를 분석하고 모델링한다.","doWork":"연구기획이나 사업계획 수립 시 통계기법, 표본 등에 대해 조언한다. 통계자료를 적정한 방법론을 사용하여 분석하고 모델이나 룰을 수립한다. 새로운 통계패키지의 기능에 대해 연구하고 새로운 기능 추가 시 분석한다. 통계에 대한 문의에 답변하고 조언한다. 소비자의 요구에 적합한 통계패키지를 추천하고 문제해결방안을 제시한다. 통계패키지 사용법, 통계이론과 기법 등에 대해 교육을 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","dJobECd":"0242","dJobECdNm":"[0242]조사 전문가","dJobJCd":"2734","dJobJCdNm":"[2734]조사 전문가","dJobICd":"M714","dJobICdNm":"[M714]시장조사 및 여론조사업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006255:1', '{"dJobCd":"K000006255","dJobCdSeq":"1","dJobNm":"통신고객정보분석원","workSum":"무선, 유선, 인터넷 등 통신이용고객의 인적사항 및 접속패턴에 관한 통계를 수집·분석하여 각 부서에 전달한다.","doWork":"가입자 개인별 연령, 직업, 지역에 관한 통계를 파악하고, 가입기간, 가입자현황, 가입기간에 관한 통계를 추출한다. 로그 데이터를 분석하여 접속패턴에 관한 통계자료를 파악하고 메뉴별 사용시각 및 사용자 수, 접속횟수 등의 서비스 이용통계에 관한 각종 통계자료를 개발한다. 통계패키지프로그램을 이용하여 용도별로 수치를 분석하여 각 부서의 요구에 따라 전달한다. 업무에 필요한 각종 통계자료를 제공하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0242","dJobECdNm":"[0242]조사 전문가","dJobJCd":"2734","dJobJCdNm":"[2734]조사 전문가","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004989:1', '{"dJobCd":"K000004989","dJobCdSeq":"1","dJobNm":"해외시장조사연구원","workSum":"언어, 지리, 네트워크 부재 등으로 수출, 투자, 합자하고자 하는 국가에 대한 정보가 부족한 기업체를 위하여 지사 혹은 시장조사업체 소속으로서 해외시장정보를 조사하여 제공한다.","doWork":"시장조사를 위해 현지에 있는 연구원과 정기적으로 소통한다. 시장조사보고서 작성을 위한 템플릿(Template:시장조사 보고서에 포함될 내용을 모두 담은 보고서 양식)을 개발하고 이것에 대해 현지 연구원을 교육(Debriefing)한다. 현지에서 조사된 연구보고서를 검토하고 필요하거나 부족한 부분은 다시 재조사 요청을 한다. 해외시장조사 뿐만 아니라 기업체가 원하는 경우 각 국가별 수입업체 및 고객리스트 발굴, 파트너 발굴을 위한 출장, 서신이나 전화를 통한 미팅주선, 고객기업체 현지출장 수행 등의 서비스를 제공하기도 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0242","dJobECdNm":"[0242]조사 전문가","dJobJCd":"2734","dJobJCdNm":"[2734]조사 전문가","dJobICd":"M714","dJobICdNm":"[M714]시장조사 및 여론조사업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004100:1', '{"dJobCd":"K000004100","dJobCdSeq":"1","dJobNm":"국제회의기획자","workSum":"행사 주최측으로부터 각종 회의 및 전시회 등 국제회의 유치권을 위임받아 국제회의 운영·관리를 위한 기획 및 진행, 홍보업무를 수행하고 관리한다.","doWork":"개최될 정부 관련 회의, 학술회의, 산업박람회, 전시회 등 각종 국제회의 및 이벤트 행사를 직접 혹은 행사 주최측을 대행하여 유치하기 위한 각종 서류 및 세부진행설계서를 제출한다. 유치권 계약을 체결한다. 효과적인 국제회의 및 이벤트 행사가 이루어질 수 있도록 조직운영회와 사무국을 구성한다. 기획, 참가자 등록업무, 숙박, 행정, 관광, 전시회 등 사교행사 등 국제회의 관련 준비를 진행한다. 국제회의 진행을 위해 통역사 및 관련 종사자를 섭외하고 운영한다. 개최할 국제회의를 국내외 참가자 및 관련 기관 등에 홍보한다. 국제회의가 종료되면 비디오·결산보고서 및 결과보고서 등을 제출한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"국제회의전문기획자, 국제회의기획진행자, 회의기획자, 국제회의전문가, PCO(Professional Convention Organizer)","certLic":"컨벤션기획사(1급, 2급)","dJobECd":"0244","dJobECdNm":"[0244]행사 기획자","dJobJCd":"2735","dJobJCdNm":"[2735]행사 기획자","dJobICd":"N759","dJobICdNm":"[N759]기타 사업지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004980:1', '{"dJobCd":"K000004980","dJobCdSeq":"1","dJobNm":"전시기획자","workSum":"전시회의 개최 여부를 판단하고 전시와 관련된 모든 업무를 관리·감독한다.","doWork":"전시회의 주제를 정하기 위하여 정보를 수집하고 개최여부를 판단한다. 기본계획을 수립한다. 전시장을 임대한다. 전시주제와 관련된 유관기관과 협의(후원, 지원)한다. 참가예상업체의 데이터베이스를 정리한다. 한글 및 외국어 소책자 및 참가신청서를 제작하고 배포한다. 참가예상업체를 대상으로 마케팅 관련 회의나 설명회를 개최한다. 시설, 인력 등 행사에 필요한 업체를 선정하고 계약한다. 전시에 필요한 물품을 구매한다. 전시회 운영을 총괄한다. 마감된 전시회에 대한 결과보고서를 작성하고 평가회의를 개최한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"컨벤션기획자, 행사전시회기획자","connectJob":"컨벤션미팅플래너(Meeting Planner), 컨벤션코디네이터","certLic":"컨벤션기획사(1급, 2급)","dJobECd":"0244","dJobECdNm":"[0244]행사 기획자","dJobJCd":"2735","dJobJCdNm":"[2735]행사 기획자","dJobICd":"N759","dJobICdNm":"[N759]기타 사업지원 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006298:1', '{"dJobCd":"K000006298","dJobCdSeq":"1","dJobNm":"파티플래너","workSum":"파티 진행을 위하여 기획, 운영, 연출, 홍보 등 파티 전반을 총괄한다.","doWork":"제안서를 작성하여 제출한다. 파티의 주제 및 구성을 의뢰인과 협의한다. 파티일정 및 장소, 출연자, 예산 등의 세부계획을 세운다. 파티에 필요한 장식 등의 물품과 장비를 제작하고 대여해 줄 업체를 선정한다. 조명·음향·무대 등과 같은 특수효과와 음식, 파티장 장식 등의 세부계획을 세운다. 댄스팀, 연주팀과 같은 공연팀을 섭외한다. 직접 파티장의 장식(디스플레이)에 필요한 소품을 구입한다. 초청대상자의 참석여부를 확인한다. 파티 당일 사전 준비사항을 점검한다. 파티를 진행하며, 유사시에 조치를 취한다. 파티가 끝난 후 마무리한다. 초청자 리스트 등 파티 진행의 결과를 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"협의","workFunc3":"수동조작","connectJob":"파티매니저, 파티마케터, 미팅플래너","dJobECd":"0244","dJobECdNm":"[0244]행사 기획자","dJobJCd":"2735","dJobJCdNm":"[2735]행사 기획자","dJobICd":"N759","dJobICdNm":"[N759]기타 사업지원 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002642:1', '{"dJobCd":"K000002642","dJobCdSeq":"1","dJobNm":"판촉매체기획원","workSum":"광고와 관련된 보조적인 판매활동을 위한 매체, 디스플레이, 쇼, 전람회 등의 판촉활동을 기획한다.","doWork":"광고제품에 대한 유통과정·판매자(Inner)행동·판촉(Sales Promotion)활동 및 구매시점에서의 소비자 행동을 분석한다. 분석결과를 토대로 시장기회를 발견하여 판촉매체를 검토·설정한다. 판촉과제를 설정하고 그에 대한 목표와 예산을 설정한다. 판촉전개 수단(Vehicle, Media, Tool)으로 공용미디어(교통광고, 옥외광고, 애드시네, 쇼윈도 등), 거래선 전용미디어(포스터, 리플릿, 팸플릿, 카탈로그, 비디오디스크, 쇼룸 등), 인적수단(시범자, 강사, 컨설턴트 등), 물적수단(샘플, 경품, 초대권, 쿠폰, 트레이딩 스탬프, 디스플레이, 매뉴얼 등) 및 이벤트미디어(스포츠대회, 콘서트, 사인회, 전람회 등) 등을 선정한다. 판촉전개 시책의 실시일정 계획과 효과측정 계획을 세운다. 판촉전략사양서와 실시계획사양서를 작성하여 실시 후 효과를 측정·평가하고 사례를 정리·보관한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"판촉기획자, 프로모션기획자","dJobECd":"0244","dJobECdNm":"[0244]행사 기획자","dJobJCd":"2735","dJobJCdNm":"[2735]행사 기획자","dJobICd":"M713","dJobICdNm":"[M713]광고업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002366:1', '{"dJobCd":"K000002366","dJobCdSeq":"1","dJobNm":"해외전시행사기획원","workSum":"해외에서 개최되는 국제전시행사의 참가에 관한 업무를 기획하고 관리한다.","doWork":"전시회에 참가할 국가, 주제 및 방향설정, 예산편성 등 참가계획을 수립한다. 건축, 전시, 각종 문화행사 등이 조화롭게 진행되도록 홍보한다. 전시부스의 시공을 관리한다. 전시물 제작과 운영에 필요한 인력을 수급한다. 전시기간 중 전시행사와 관련한 각종 기념품을 제작·판매한다. 행사 후 이에 행사전반에 대한 종합적인 보고서를 작성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"행사전시회기획자","dJobECd":"0244","dJobECdNm":"[0244]행사 기획자","dJobJCd":"2735","dJobJCdNm":"[2735]행사 기획자","dJobICd":"N759","dJobICdNm":"[N759]기타 사업지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004998:1', '{"dJobCd":"K000004998","dJobCdSeq":"1","dJobNm":"행사연출가","workSum":"각종 행사를 기획·준비하고 예산, 일정에 맞추어 행사를 개최한다.","doWork":"각종 박람회 및 전시회, 문화행사, 판촉행사, 지역축제 등 의뢰받은 행사를 기획하기 위해 행사의 목적 및 특성을 파악한다. 설문조사, 관련 자료 및 데이터 등의 정보를 수집하여 시장조사를 한다. 행사의 전체적인 틀 및 세부기획안을 작성하고 행사기간, 장소, 예산 및 계획일정 등에 대하여 고객과 협의한다. 행사진행자 및 출연자를 섭외한다. 행사준비 및 연습 등을 총괄하고 관련 인력의 활동을 지시·감독한다. 행사 개최 시 진행사항을 확인하고 행사업무를 조정한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"이벤트연출가, 행사기획자","connectJob":"이벤트기획자, 이벤트대리인, 공연대리인, 패션쇼대리인, 판촉행사대리인, 판촉행사기획자, 패션쇼기획자, 패션쇼연출자(패션쇼PD) 공연장에 소속된 경우 하우스매니저","dJobECd":"0244","dJobECdNm":"[0244]행사 기획자","dJobJCd":"2735","dJobJCdNm":"[2735]행사 기획자","dJobICd":"N759","dJobICdNm":"[N759]기타 사업지원 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007514:1', '{"dJobCd":"K000007514","dJobCdSeq":"1","dJobNm":"감정평가사","workSum":"토지, 건물, 저작권, 산업재산권, 어업권, 양식업권, 광업권, 공장재단, 광업재단, 입목, 자동차, 건설기계, 선박, 항공기 등 부동산, 동산, 유·무형자산 등의 경제적 가치를 판정하여 그 결과를 가액(價額)으로 표시하는 감정평가 업무를 수행한다.","doWork":"대상물의 감정평가목적을 감안하여 조건, 목록 등 감정평가의 기본적 사항을 책정하고 이에 따라 감정평가계획을 세운다. 부동산 및 동산 등 감정평가 대상의 내용, 성능, 구조 등 가치에 미치는 제반 요인을 확인하고 이를 정리한다. 현장조사와 각종 손익계산서, 대차대조표 등의 자료를 검토하고 감정평가서를 작성 한 후 법인 내 동료 감정평가사의 심사를 받고 감정평가서를 의뢰인에게 제출한다. 감정평가업무 수행 시, 자신의 전문분야가 아니거나 난해한 부분이 있을 시에는 관련 전문가에게 자문하기도 한다. 감정평가 대상에 따라 지가공시를 위한 표준지 공시지가 조사·평가, 공익사업을 위한 보상감정평가, 기업체의 자산감정평가, 대출을 위한 담보물 감정평가, 법원 경매물건 감정평가 등을 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"부동산감정평가사, 부동산감정사, 토지평가사, 공인감정사","certLic":"감정평가사","dJobECd":"0234","dJobECdNm":"[0234]감정 전문가","dJobJCd":"2741","dJobJCdNm":"[2741]감정 관련 전문가","dJobICd":"L682","dJobICdNm":"[L682]부동산 관련 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004043:1', '{"dJobCd":"K000004043","dJobCdSeq":"1","dJobNm":"국가유산감정사","workSum":"공항 및 부두에서 해외반출 국가유산의 해당 여부를 판별하기 위해 국가유산을 감정한다.","doWork":"국가유산으로 의심되는 물품을 감정하여 해외반출 대상품목 여부를 판별한다. 감정되지 않은 물품 신고가 들어올 경우 출국장에 가서 직접 감정한다. 문헌정보를 참고하거나 여러 감정위원과 협의하여 물품을 감정한다. 감정물품목록, 물품소지자의 신상명세, 물품감정결과 등 감정내용과 관련하여 보고서를 작성한다. 시·도 및 기타 국가유산 지정을 위해 감정하거나 압수국가유산 평가를 위해 감정하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"국가유산전문위원, 국가유산감정위원, 국가유산감정평가사","dJobECd":"0234","dJobECdNm":"[0234]감정 전문가","dJobJCd":"2741","dJobJCdNm":"[2741]감정 관련 전문가","dJobICd":"M739/R902","dJobICdNm":"[M739]그 외 기타 전문, 과학 및 기술 서비스업 / [R902]도서관, 사적지 및 유사 여가관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003727:1', '{"dJobCd":"K000003727","dJobCdSeq":"1","dJobNm":"귀금속품위감정가","workSum":"고객의 의뢰를 받아 귀금속 의뢰품을 감정한다.","doWork":"의뢰받은 귀금속을 감정하기 위해 감정장비의 작동 상태 및 이상 유무를 확인한다. 전자저울, 비커, 증류수, 비중표 등을 통해 의뢰품의 중량 및 비중을 검사한다. 시금석 표면상태를 점검하고 검사한다. X-ray 형광분석기를 통해 표면상태를 점검하여 감정의 적정 여부를 점검한다. 분석된 자료를 바탕으로 귀금속 품위감정 성적서를 발급한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|시각|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"귀금속감정가","certLic":"귀금속가공기능사, 보석가공기능사, 화학분석기사","dJobECd":"0234","dJobECdNm":"[0234]감정 전문가","dJobJCd":"2741","dJobJCdNm":"[2741]감정 관련 전문가","dJobICd":"N759","dJobICdNm":"[N759]기타 사업지원 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007744:1', '{"dJobCd":"K000007744","dJobCdSeq":"1","dJobNm":"명품감정사","workSum":"국내외 명품 및 패션 브랜드의 상태, 진위를 검수, 감정하고 시장 가격을 산정한다.","doWork":"명품 및 패션 브랜드 제품(가방, 시계, 주얼리, 의류, 신발, 잡화, 악세서리 등)의 가죽, 금속, 원단, 구성품 등을 육안 및 현미경, 엑스레이, 성분분석기 등의 장비로 상태와 동일성을 검사하고 진위를 판단한다. 제품의 시장수요, 브랜드 인기, 희소성 등을 분석하여 적정한 가격을 산출한다. 감정한 자료를 기반으로 보증서 및 소견서를 작성하고 발급한다. 명품의 특성상 제품에 대한 데이터 베이스가 부족할 경우 국내외 자문기관과 협업한다. 명품 브랜드 시장 동향 및 가격 변동 사항을 파악한다. 명품에 관한 법적 분쟁이나 사건의 조사에 대해 전문가로서 의견을 제시한다. 명품 감정 관련 교육 및 컨설팅 업무를 수행하다. 명품 관련 상품관리를 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"명품감별사, 명품검수자","dJobECd":"0234","dJobECdNm":"[0234]감정 전문가","dJobJCd":"2741","dJobJCdNm":"[2741]감정 관련 전문가","dJobICd":"G478/M716","dJobICdNm":"[G478]기타 상품 전문 소매업 / [M716]기타 전문 서비스업","inqYear":"2025"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002446:1', '{"dJobCd":"K000002446","dJobCdSeq":"1","dJobNm":"문서감정사","workSum":"문서 작성에 사용된 문자, 기호, 인영, 잉크 등을 분석하여 그 문서의 위조, 변조, 작성시기 등을 식별한다.","doWork":"문서감정 요청 분야, 감정 완료일자 등을 의뢰인과 협의한다. 요청된 분야의 감정을 위해 관련 자료를 수집하고 분석한다. 입체현미경, 자외선 감식기, 적외선 현미경, 문서감식기 및 화학약품 등을 사용하여 문서 작성에 사용된 문자, 기호, 인영(도장을 찍은 형적), 잉크의 크기, 모양, 두께, 연결상태 등을 파악한다. 워드문서의 폰트의 동일성 여부파악 및 잠재지문의 현출작업을 수행한다. 진본과 비교하거나 역사적 사실, 물리적 특성, 개인적 특성 등을 토대로 진위여부, 작성연도 등을 파악한다. 감정 목적, 방법, 결과 등을 담은 감정결과서를 작성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"0234","dJobECdNm":"[0234]감정 전문가","dJobJCd":"2741","dJobJCdNm":"[2741]감정 관련 전문가","dJobICd":"M739","dJobICdNm":"[M739]그 외 기타 전문, 과학 및 기술 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004551:1', '{"dJobCd":"K000004551","dJobCdSeq":"1","dJobNm":"미술품감정사","workSum":"서화, 골동품 등의 고대·근대·현대 미술품의 진위여부를 감정하고 시장적 가치를 평가한다.","doWork":"감정의뢰기관을 통해 미술품 등의 감정대상물에 대한 사전정보를 받고 감정에 필요한 자료를 수집한다. 돋보기 등 감정에 필요한 도구를 사용하여 감정대상물 진위여부를 감정한다. 감정대상물의 보존상태, 제작시기, 작가의 명성 등을 고려하여 시장가치를 매긴다. 진위 여부와 시장적 가치를 타 감정위원과 함께 협의한다. 감정에 대한 결과와 결과에 따른 의견서를 작성하고 서명한다. 감정에 대하여 더 많은 조사와 의견수렴이 필요할 경우는 감정을 연기·보류하고 자료수집과 재검정을 실시한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"예술품감정위원, 미술품감정원","connectJob":"고미술감정원, 근대미술감정원, 골동품감정사, 기술품감정사","dJobECd":"0234","dJobECdNm":"[0234]감정 전문가","dJobJCd":"2741","dJobJCdNm":"[2741]감정 관련 전문가","dJobICd":"M739","dJobICdNm":"[M739]그 외 기타 전문, 과학 및 기술 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001722:1', '{"dJobCd":"K000001722","dJobCdSeq":"1","dJobNm":"범죄문서감정관","workSum":"문서, 유가증권, 신분증, 화폐 등의 진위여부를 판별하고 조작에 사용된 기법, 방법을 조사·연구한다.","doWork":"의뢰된 문서를 통해서 사건경위, 감정 분야 등을 파악하고 의뢰인과 협의한다. 감정을 위해 관련된 자료를 수집하고 분석한다. 입체현미경, 자외선 감식기, 적외선 현미경, 마이크로스코프 등 관련 기기나 장비를 준비한다. 적절한 기기나 장비를 사용하여 문서, 유가증권, 화폐 등의 문자, 기호, 인영, 잉크의 크기, 모양, 두께, 연결상태, 인쇄방법, 색 등을 파악한다. 진본과 비교하거나 역사적 사실, 물리적 특성, 개인적 특성 등을 토대로 진위여부를 결정하고 조작된 기법 및 방법 등을 조사한다. 지문(사람의 십지지문)의 동일여부 감정과 문서나 물건에 유류된 잠재지문(눈에 보이지 않는 지문)을 현출하는 업무도 수행한다. 새로운 감정기법의 연구 및 개발 업무를 수행한다. 감정사항, 감정방법, 감정결과, 감정의견 등을 담은 감정결과서를 작성한다. 법적 절차에 따라 감정결과에 대해서 법정에서 증언하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"0234","dJobECdNm":"[0234]감정 전문가","dJobJCd":"2741","dJobJCdNm":"[2741]감정 관련 전문가","dJobICd":"O844","dJobICdNm":"[O844]사법 및 공공질서 행정","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005053:1', '{"dJobCd":"K000005053","dJobCdSeq":"1","dJobNm":"보석감정사","workSum":"다이아몬드, 유색보석 (루비, 사파이어, 에메랄드, 진주, 비취 등) 의 진위여부를 감별하고, 보석의 품질, 가치를 평가(감정)하고 감정서를 발행한다.","doWork":"유색보석의 경우 보석의 색상, 투명도, 특수효과, 광택, 굴절 등 보석의 외관을 검사한다. 저울이나 게이지를 사용하여 보석의 중량과 치수를 측정한다. 보석학 지식과 보석감별용 기구를 사용한 기초(1차)감별 후 정밀분석기구를 사용하여 최종적으로 보석종과 변종 및 처리 여부를 확인한다. 다이아몬드의 외관, 비중, 확대검사를 통한 기초 감별과 저울, 게이지 또는 3D 스캔 장비를 사용하여 다이아몬드의 중량과 치수를 측정한다. 기초 감별을 거친 후 정밀분석기구(FT-IR, RAMAN 분광기 등)를 사용하여 천연·합성·유사다이아몬드를 감별한다. 귀금속의 외관 및 각인을 확인하여 종류를 파악한다. 비파괴 분석장비인 X선 성분분석기 등을 사용하여 귀금속의 순도를 측정한다. 보석의 가치에 영향을 미치는 결함 또는 제반 특성을 찾아내기 위해 보석의 표면과 내부구조를 검사한다. 감별과 감정 결과를 종합하여 감정서를 작성하고 발급한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"보석감정인, 보석감별사","connectJob":"다이아몬드감정사","certLic":"귀금속가공기능사, 보석가공기능사, 귀금속가공산업기사, 보석감정기능사, 보석감정산업기사","dJobECd":"0234","dJobECdNm":"[0234]감정 전문가","dJobJCd":"2741","dJobJCdNm":"[2741]감정 관련 전문가","dJobICd":"N759","dJobICdNm":"[N759]기타 사업지원 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003398:1', '{"dJobCd":"K000003398","dJobCdSeq":"1","dJobNm":"위조주화감정연구원","workSum":"유통주화, 기념주화 및 메달 등의 위조 및 변조품에 대한 진위를 감정하고 위변조 방지대책을 연구한다.","doWork":"국내외 주화제품(기념주화, 메달 포함)의 감정을 위하여 금속소재의 성분, 규격 및 위변조 방지방법 등을 분석하고 적정 진위감정 방법을 수립한다. 감정 의뢰품에 대한 무게, 지름, 두께, 테두리 형상 등을 측정한다. 정밀성분분석기를 이용하여 금속성분을 분석하여 위변조 방지요소 적용 여부를 확인한다. 의뢰품이 진품의 제조 공차 범위 내에 포함되었는가를 확인한다. 위변조 방법, 제조장비 등을 종합적으로 분석한 후 진위를 감별한다. 위변조 방법을 분석하여 향후 주화 신제품 제조 시 적용할 수 있는 위변조 방지 기술방법을 연구한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"금속기사","dJobECd":"0234","dJobECdNm":"[0234]감정 전문가","dJobJCd":"2741","dJobJCdNm":"[2741]감정 관련 전문가","dJobICd":"M739","dJobICdNm":"[M739]그 외 기타 전문, 과학 및 기술 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002326:1', '{"dJobCd":"K000002326","dJobCdSeq":"1","dJobNm":"위폐감정사","workSum":"지폐, 유가증권, 우표, 여권 등에 대한 위·변조 진위를 감정한다.","doWork":"감정 의뢰품에 대하여 접수를 받는다. 육안검사를 통하여 필요한 검사장비 및 방법을 선택한다. 감정 의뢰품에 대한 진위를 판별하기 위하여 확대경, 현미경, 자외선램프, 적외선 등 각종 광학장비와 화학반응 실험장비를 준비한다. 감정 의뢰품에 대하여 원료, 은화, 은사, 형광특성, 내·외부 처리제 및 기타 특수요소 등에 광학적, 화학적 및 물리적 특성을 종합하여 위·변조 여부를 규명한다. 분석한 결과자료를 근거로 제조과정을 식별한다. 감정의뢰기관에 감정 여부를 보고한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"위폐감식전문가, 위폐감식원","dJobECd":"0234","dJobECdNm":"[0234]감정 전문가","dJobJCd":"2741","dJobJCdNm":"[2741]감정 관련 전문가","dJobICd":"K641/O841","dJobICdNm":"[K641]은행 및 저축기관 / [O841]입법 및 일반 정부 행정","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007022:1', '{"dJobCd":"K000007022","dJobCdSeq":"1","dJobNm":"음식료품감정사","workSum":"음식물, 주류 등의 품질 및 특성을 관능으로 감정하고 평가한다.","doWork":"신제품을 개발하기 위해 배합된 원료의 특성과 성분을 시험·분석한다. 기존 제품을 시험하고 조직, 맛, 색, 영양 등을 기록·분석하여 각 제품의 개선방법을 연구한다. 음식료품의 개발 및 개선을 위하여 기존 문헌에서 음식료품의 개선 또는 개발을 위해 필요한 조리법, 실험법 등을 연구하고 정리한다. 각 제조공정에서 채취한 견본을 분석하여 크기, 맛, 조직, 입자, 중량 등의 상태를 기록하고 개선점을 연구한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"식품기술사, 식품기사, 식품산업기사","dJobECd":"0234","dJobECdNm":"[0234]감정 전문가","dJobJCd":"2741","dJobJCdNm":"[2741]감정 관련 전문가","dJobICd":"C10","dJobICdNm":"[C10]식료품 제조업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002186:1', '{"dJobCd":"K000002186","dJobCdSeq":"1","dJobNm":"조향사","workSum":"다양한 향료를 조합하여 제품의 이미지에 맞게 향을 개발한다.","doWork":"향이 사용될 제품의 특성을 고려하여 콘셉트를 설정한다. 향료를 준비하고 계량용기를 사용하여 중량을 측정하고 향료를 배합한다. 알코올을 첨가하여 향을 부드럽게 한다. 블로터스트립(향을 맡는 종이)을 사용하여 배합된 향료의 향을 맡아보고 추가 향료를 조합한다. 제품의 사용여부를 결정하기 위해 개발된 향으로 품평회를 개최하기도 한다. 향료회사에서 제공받은 여러 가지 향들을 제품에 사용하기 위해 평가하기도 한다. 새로운 향을 개발하거나 식품 등에 향을 첨가하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"향수를 만드는 향수디자이너(Perfume Designer), 화장품이나 생활용품에 향을 입히는 퍼퓨머(Perfumer), 식품의 향을 개발하는 플래버리스트(Flavorist)","dJobECd":"0234","dJobECdNm":"[0234]감정 전문가","dJobJCd":"2741","dJobJCdNm":"[2741]감정 관련 전문가","dJobICd":"C204","dJobICdNm":"[C204]기타 화학제품 제조업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001272:1', '{"dJobCd":"K000001272","dJobCdSeq":"1","dJobNm":"커피향미감정평가사","workSum":"커피의 수입, 커피 로스팅, 커피음료 제조회사, 커피 프랜차이즈 기업, 커피숍 등에서 생두, 원두, 가루커피 등의 품질을 평가하고, 커피의 맛과 질을 평가하여 커피의 품질관리와 관련된 업무를 수행한다.","doWork":"커피에 대한 지식(커피재배, 가공, 운반, 수출입 관련 업무, 로스팅, 그라인딩, 추출방법 등) 및 커피 감별 및 평가기준을 숙지한다. 커핑(Cuping:커피를 마시면서 맛과 질을 평가하는 행위)하기 전, 미각, 후각에 영향을 주는 자극적인 음식의 섭취 및 흡연을 하지 않은 상태에서 평가준비를 한다. 생두의 외관을 관찰하여 평가한다. 로스팅된 콩(원두)의 상태를 확인한다. 원두를 분쇄한 후 향기를 평가한다. 감별 및 평가기준에 따라 감정할 커피를 준비한다. 커피를 마시면서 커피의 향미에 영향을 주는 다양한 요소(짠맛, 단맛, 신맛, 향기, 유기산 등)를 분별하고 각 요소의 종류, 강도, 등급 등을 평가한다. 평가결과를 기록한다. 커피의 품질향상, 품질관리, 개발과정에 참여하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"커피감별사, Q-grader","dJobECd":"0234","dJobECdNm":"[0234]감정 전문가","dJobJCd":"2741","dJobJCdNm":"[2741]감정 관련 전문가","dJobICd":"M729","dJobICdNm":"[M729]기타 과학기술 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002568:1', '{"dJobCd":"K000002568","dJobCdSeq":"1","dJobNm":"수입업자","workSum":"일정한 이익확보를 목적으로 상품을 구매하여 도소매업체에 재판매한다.","doWork":"수요와 재고에 관한 정보를 토대로 구입할 상품의 수량과 종류를 결정한다. 시장동향을 파악하고, 각종 무역전시회나 상품전시회에 참석해 업계 흐름을 파악한다. 사업체의 요구조건에 가장 적합한 상품을 선정한다. 제품 공급자를 접촉해 구매비용, 인도일자 및 계약조건 등을 협의한다. 납품상태, 입금, 선적 등 상품인도 과정을 관리한다. 제품 공급자와 지속적인 관계를 유지한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"설득","workFunc3":"관련없음","similarNm":"구매인, 오파상, 해외영업원, 바이어","dJobECd":"6122","dJobECdNm":"[6122]해외 영업원","dJobJCd":"2742","dJobJCdNm":"[2742]해외 영업원","dJobICd":"G461","dJobICdNm":"[G461]상품 중개업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007560:1', '{"dJobCd":"K000007560","dJobCdSeq":"1","dJobNm":"해외영업원","workSum":"해외 수입업자에게 상품을 판매하기 위하여 해외 영업활동을 한다.","doWork":"자사 제품의 수출과 필요한 제품을 수입하기 위하여 해외 거래선을 개발한다. 구매자와 접촉, 자사제품 소개, 상담, 계약체결, 수출품 의뢰, 출하부서와 외자부서에 선적의뢰서 발송, 클레임 처리 등의 업무를 수행한다. 해외정보 확보를 위한 시장조사, 해외시장 동향을 분석하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"설득","workFunc3":"관련없음","connectJob":"영어무역영업원, 영어수출입영업원, 영어해외영업원, 일어무역영업원, 일어수출입영업원, 일어해외영업원, 중국어무역영업원, 중국어수출입영업원, 중국어해외영업원, 독일어무역영업원, 독일어무역수출입영업원, 독일어해외영업원, 프랑스어무역영업원, 프랑스어수출입영업원, 프랑스어해외영업원, 스페인어무역영업원, 스페인어수출입영업원, 스페인어해외영업원, 포르투갈어무역영업원, 포르투갈어수출입영업원, 포르투갈어해외영업원, 러시아어무역영업원, 러시아어수출입영업원, 러시아어해외영업원, 동남아어무역영업원, 동남아어수출입영업원, 동남아어해외영업원, 인도네시아어무역영업원, 인도네시아어해외영업원, 말레이시아무역영업원, 말레이시아해외영업원, 베트남어무역영업원, 베트남어해외영업원, 캄보디아무역영업원, 캄보디아해외영업원, 필리핀무역영업원, 필리핀해외영업원, 아랍어무역영업원, 아랍어수출입영업원, 아랍어해외영업원","dJobECd":"6122","dJobECdNm":"[6122]해외 영업원","dJobJCd":"2742","dJobJCdNm":"[2742]해외 영업원","dJobICd":"G461","dJobICdNm":"[G461]상품 중개업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005037:1', '{"dJobCd":"K000005037","dJobCdSeq":"1","dJobNm":"기술영업원(일반)","workSum":"기술적 전문성을 바탕으로 기술 제품 및 서비스 고객을 발굴·관리하고 고객의 요구를 분석하여 최적의 도입 솔루션을 제안하여 제품 또는 서비스를 판매하며 설계, 설치, 유지보수 등 기술적 지도와 서비스를 제공한다.","doWork":"신규거래처를 발굴하고 기존 고객을 관리한다. 고객의 기술적 요구를 분석하고 최적의 제품 및 솔루션을 제안한다. 제품의 기능과 기술적 장점을 설명하며, 고객에게 데모 및 프레젠테이션을 진행한다. 제품 및 서비스의 가격을 산정하고, 고객과 계약 조건을 협상한다.  고객이 제품을 사용하는 과정에서 발생하는 기술적 문제를 해결하고 유지보수 지원한다. 산업 동향을 조사하고 경쟁사의 제품과 비교하여 자사 제품의 경쟁력을 강화한다. 고객의 요구를 반영하여 제품 개선 및 새로운 기술 개발을 지원한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"언어력|","workFunc1":"조정","workFunc2":"설득","workFunc3":"정밀작업","connectJob":"네트워크기술영업원, 멀티미디어시스템기술영업원, 통신기기기술영업원, 반도체장비기술영업원, 계측장비기술영업원, 통신부품기술영업원, 전자부품기술영업원, 전자저울기술영업원, 반도체기술영업원, PCB기술영업원, CCTV시스템기술영업원, GPS기술영업원, 계측기기술영업원, 교환기기술영업원, 네트워크장비기술영업원, 영상기기기술영업원, 휴대폰부품기술영업원, SMPS기술영업원, 컴퓨터하드디스크기술영업원, 컴퓨터소프트웨어기술영업원, 전산장비기술영업원, SI기술영업원, 전산기술영업원, 웹개발기술영업원, 모바일솔루션기술영업원, 데이터복구기술영업원, 보안솔루션기술영업원, 인터넷솔루션기술영업원, ERP프로그램기술영업원, IT솔루션기술영업원, KMS기술영업원, 초음파기기술영업원, X-ray기기술영업원, MRI기술영업원, 산소호흡기기술영업원, 심전도기기술영업원, 수술대기술영업원, 의료장비영업원, 물리치료장비영업원, 안과용장비영업원, 수입의료장비영업원, 펌프기술영업원, 공작기계기술영업원, 건설기계기술영업원, 모터기술영업원, 기계부품기술영업원, 공기압축기기술영업원, 자동화기기기술영업원, 식품포장기계기술영업원, 플랜트설비기술영업원, 철강재영업원, 지게차영업원, 환경설비기술영업원, 절삭공구기술영업원, 조선기자재기술영업원, 자동화설비기술영업원, 유압기계기술영업원, 레이저절단기계기술영업원, 금형기계기술영업원, 산업용보일러기술영업원, 산업용모터기술영업원, 산업용펌프기술영업원, 건설장비기술영업원, 농업용트랙터기술영업원, 경운기기술영업원, 탈곡기기술영업원, 엔진기술영업원, 엑셀기술영업원, 가속기기술영업원, 트랜스미션기술영업원, 변속기기술영업원, 자동차부품기술영업원, 화학원료기술영업원, 화학물기술영업, 화학제품기술영업원, 태양전지기술영업원, 태양잉곳기술영업원, 태양웨이퍼기술영업원, 태양광모듈기술영업원, 태양광발전기술영업원, 집광채광시스템기술영업원, 태양광발전시스템기술영업원, 태양열온수기영업원, 풍력발전시스템기술영업원, 연료전지기술영업원, 지열냉난방설비공사기술영업원, 태양광조명기술영업원, LED기술영업원, 지열시스템기술영업원, 친환경소재기술영업원, ITS기술영업원, U-city기술영업원, RFID기술영업원, USN기술영업원, 그린빌딩시스템(GBS)기술영업원, ESCO기술영업원, GIS기술영업원, 바이오플랜트기술영업원, 의료기기기술영업원, 의료장비기술영업원, 초음파기술영업원, 전산시스템기술영업원, 홈페이지제작영업원, 웹사이트구축영업원, 폐기물처리영업원, 산업폐수영업원","certLic":"유통관리사","dJobECd":"6121","dJobECdNm":"[6121]기술 영업원","dJobJCd":"2743","dJobJCdNm":"[2743]기술 영업원","dJobICd":"ALL","dJobICdNm":"[ALL]전체","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005791:1', '{"dJobCd":"K000005791","dJobCdSeq":"1","dJobNm":"디자인영업원","workSum":"거래처를 방문하여 디자인 의뢰를 상담하고 새로운 거래처를 개척하기 위해 전략을 세운다.","doWork":"회사의 계획이나 방침에 따라 영업전략을 수립한다. 거래처를 방문하여 새로운 디자인 패턴, 향후 유행할 디자인에 대해서 샘플이나 카탈로그를 통해 설명하고 고객의 질문에 대해 답변한다. 디자인 형태, 디자인 소재, 디자인 완료 기간, 소요비용 등 디자인 용역에 대해 고객과 협의한다. 협의 내용에 대해 관련 부서장에게 보고하고 디자이너를 포함하여 담당자와 디자인 기간, 일정 등을 협의한다. 디자인 용역이 완료되는 시점까지 고객이 요구하는 사항을 확인하고 디자이너에게 요구사항을 전달하여 협의한다. 새로운 거래처를 개척하기 위하여 고객에 대한 정보를 수집한다. 새로운 디자인 동향에 대해 교육을 받거나 파악한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실외","physicalAct":"언어력|","workFunc1":"조정","workFunc2":"설득","workFunc3":"정밀작업","dJobECd":"6121","dJobECdNm":"[6121]기술 영업원","dJobJCd":"2743","dJobJCdNm":"[2743]기술 영업원","dJobICd":"M732","dJobICdNm":"[M732]전문 디자인업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002577:1', '{"dJobCd":"K000002577","dJobCdSeq":"1","dJobNm":"모바일고객지원엔지니어","workSum":"모바일기기 소프트웨어 관리 솔루션을 홍보하고 사용법을 교육하며, 기술적 문제에 대한 해결책 등을 컨설팅 한다.","doWork":"계약 후에 해당 업체의 개발자가 모바일기기를 개발하는데 자사의 제품을 원활히 사용할 수 있도록 개발과정에서 발생할 수 있는 문제점이나 사용방법, 제품의 구성 등에 대한 정보를 제공하여 모바일 기기를 상품화할 수 있도록 돕는다. 개발과정에서 제품에 문제가 발생하면 원인을 분석하여 연구개발자나 제조부서에 알려 수정하게 하도록 한다. 모바일기기에 사용될 소프트웨어를 기획한다. 개발 단계 시의 고려사항, 개발기간 등에 대한 컨설팅 업무를 한다. 모바일 기기 출시 이후에 발생하는 문제에 대해서도 기술적으로 지원한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"설득","workFunc3":"정밀작업","similarNm":"모바일커스터머엔지니어(Mobile Customer Engineer), 디바이스애플리케이션엔지니어(Device Application Engineer)","dJobECd":"6121","dJobECdNm":"[6121]기술 영업원","dJobJCd":"2743","dJobJCdNm":"[2743]기술 영업원","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003378:1', '{"dJobCd":"K000003378","dJobCdSeq":"1","dJobNm":"모바일커스터머서포트엔지니어","workSum":"모바일 기기의 개발을 기술적으로 지원한다.","doWork":"계약 후에 해당 업체의 개발자가 모바일기기를 개발하는데 자사의 제품을 원활히 사용할 수 있도록 개발과정에서 발생할 수 있는 문제점이나 사용방법, 제품의 구성 등에 대한 정보를 제공하여 모바일 기기를 성공적으로 상품화할 수 있도록 돕는다. 개발과정에서 제품에 문제가 발생하면 원인을 분석하여 연구개발자나 제조부서에 알려 수정하게 하여 다음 버전의 제품에는 문제점이 발생하지 않도록 한다. 모바일기기에 사용될 소프트웨어를 기획하거나 개발 단계 시의 고려사항, 개발기간 등에 대한 컨설팅 업무를 한다. 휴대폰 출시 이후에 발생하는 문제에 대해서도 기술적으로 지원한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"조정","workFunc2":"설득","workFunc3":"정밀작업","dJobECd":"6121","dJobECdNm":"[6121]기술 영업원","dJobJCd":"2743","dJobJCdNm":"[2743]기술 영업원","dJobICd":"J620","dJobICdNm":"[J620]컴퓨터 프로그래밍, 시스템 통합 및 관리업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003638:1', '{"dJobCd":"K000003638","dJobCdSeq":"1","dJobNm":"부가가치통신망영업원","workSum":"부가가치통신망(VAN:Value Added Network) 사업의 영업을 추진하고 이용기관을 관리하며 단말기 및 대리점 관리, 헬프데스크 운용에 관한 업무를 수행한다.","doWork":"단말기 매매 및 설치 등 단말기 영업을 수행한다. 단말기 판매 대리점 계약체결과 관련된 사항을 검토하여 체결된 내역을 시스템에 등록한다. 대리점에 대한 제재 기준을 점검하는 등 대리점 관리업무를 수행한다. 카드 가맹점 및 자금관리서비스(CMS:Cash Management Service)·지로EDI(Electronic Data Interchange)서비스 이용기관의 승인과 관련한 신청서 및 구비서류를 접수한다. 승인된 내역을 시스템에 등록하는 등 가맹점 및 이용기관 관리업무를 수행한다. 직불·신용카드 부가가치통신망(VAN:Value Added Network), 은행 POS단말기(판매시점관리 단말기) 보급, EDI(주문서, 납품서, 청구서 등 무역에 필요한 각종 서류를 표준화된 양식을 통해 전자적 신호로 바꿔 컴퓨터통신망을 이용하여 거래처에 전송하는 시스템) 등 다수의 고객을 대상으로 부가가치통신망 영업을 한다. 수익사업 홍보를 검토·추진한다. 가맹점, 대리점, 이용기관 등으로부터의 이용문의, 장애신고, 불만사항신고 등에 대한 처리를 위하여 헬프데스크를 운영·관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"설득","workFunc3":"정밀작업","similarNm":"VAN영업원","dJobECd":"6121","dJobECdNm":"[6121]기술 영업원","dJobJCd":"2743","dJobJCdNm":"[2743]기술 영업원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005671:1', '{"dJobCd":"K000005671","dJobCdSeq":"1","dJobNm":"사무용기기기술영업원","workSum":"복사기, 복합기, 프린터, 프로젝터 등을 소비자에게 판매하고 수리한다.","doWork":"제조사에서 물품을 수령하여 소비자를 방문하여 복사기, 복합기, 프린터, 프로젝터 등을 판매한다. 기기에 관련된 토너, 드럼, 용지 등 소모품을 판매한다. 판매에 관련된 서류를 작성한다. 상품에 대한 특성과 신기술을 숙지하여 소비자의 물품 구매에 도움을 준다. 고객을 관리하여 소모품이나 관련 물품의 추가적인 판매에 도움을 준다. 소모품이나 고장으로 인한 단순 부품은 직접 교체하며 복잡한 고장은 수리공장에 입고시킨다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"설득","workFunc3":"정밀작업","similarNm":"사무기기기술영업원","dJobECd":"6121","dJobECdNm":"[6121]기술 영업원","dJobJCd":"2743","dJobJCdNm":"[2743]기술 영업원","dJobICd":"G465","dJobICdNm":"[G465]기계장비 및 관련 물품 도매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007687:1', '{"dJobCd":"K000007687","dJobCdSeq":"1","dJobNm":"전력수요관리중개자","workSum":"전력 사용을 안정적으로 유지하고 효율성을 높이면서 전력계통 위기 시 국가 전력망을 지원하기 위해 전력수요반응(DR) 프로그램 참여 전력소비자를 발굴하고 소비자의 전력소비량을 분석하여 최적의 에너지 효율관리 방안을 제안하는 등 소비자와 전력시장 간의  거래를 중개한다．","doWork":"전력수요반응프로그램(DR, Demand Response)을 홍보하고 전력거래 참여자(기업, 공장, 빌딩, 일반소비자 등)를 발굴하며 이들의 참여를 유도한다. 고객의 소비패턴 분석과 DR운영프로그램인 DRMS(Demand Response Management System) 등에서 수집한 자료 토대로 소비자의 전력 사용 데이터를 분석하여 전력거래소의 요청에 따라 소비자의 사용 전기를 감축하고 효율적 관리 방법을 제안한다. 전력거래 회사와 소비자 사이에서 원활한 소통을 도우며, 소비자가 수요 반응 프로그램에서 얻은 혜택을 관리하고 프로그램 시행과 관련된 최신 정보를 전력수요관리 참여자에게 제공한다. 고객관리를 통해 기존 수요처를 유지하고 대내외 영업 파트너를 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"언어력|","workFunc1":"수집","workFunc2":"설득","workFunc3":"관련없음","similarNm":"전력수요관리(DR)컨설턴트, 전력수요관리(DR)매니저","connectJob":"전력거래중개자","certLic":"전기기사, 신재생에너지발전기사, 정보처리기사","dJobECd":"6121","dJobECdNm":"[6121]기술 영업원","dJobJCd":"2743","dJobJCdNm":"[2743]기술 영업원","dJobICd":"M729","dJobICdNm":"[M729]기타 과학기술 서비스업","inqYear":"2025"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006304:1', '{"dJobCd":"K000006304","dJobCdSeq":"1","dJobNm":"제약영업원","workSum":"병원, 약국 등 거래처를 방문하여 제품을 상담하고, 주문을 받아 거래를 성사시키는 업무를 한다.","doWork":"회사의 계획이나 방침에 따라 영업전략을 수립한다. 거래처 방문계획을 세우고, 활동 후에는 영업소장에게 제출할 활동보고서를 작성한다. 계약이 완료되면 계약서를 영업소에 제출하여 성과로 평가받는다. 담당 지역의 거래처를 방문하여 제약품에 대한 상담을 하고, 재고를 파악하여 주문을 받는다. 새로운 거래처를 개척하기 위하여 고객에 대한 정보를 수집하고, 방문하여 샘플이나 카탈로그를 통해 제품을 설명한다. 신제품 및 제약업체 동향을 교육 등을 통해 파악한다. 제약품의 도매 상거래를 관리한다. 건강보조 기능성식품 등 식품으로 허가가 된 제품을 영업하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"언어력|","workFunc1":"조정","workFunc2":"설득","workFunc3":"정밀작업","similarNm":"의약품영업원, OTC영업원(일반의약품영업원), ETC영업원(전문의약품영업원), MR(Medical Representiative, 의약정보담당자)","connectJob":"의약품판매원, 약국의약품영업원, 병원의약품영업원, 치과재료영업원, 임플란트영업원, 진단시약영업원, 동물병원의약품영업원, 약국의약품루트영업원, 드링크제영업원, 의료기기영업원","dJobECd":"6121","dJobECdNm":"[6121]기술 영업원","dJobJCd":"2743","dJobJCdNm":"[2743]기술 영업원","dJobICd":"G464","dJobICdNm":"[G464]생활용품 도매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002428:1', '{"dJobCd":"K000002428","dJobCdSeq":"1","dJobNm":"집광채광시스템영업원","workSum":"태양광을 실내조명으로 사용할 수 있는 집광채광시스템의 홍보 및 영업을 한다.","doWork":"실내활동 공간의 유형과 용도에 따라 필요한 조도 기준을 확인하고 이에 적합한 집광채광시스템을 제안한다. 설계사무소, 건설회사, 건축주 등을 대상으로 건물의 신축, 개축, 개조 시에 집광채광시스템의 도입에 따른 온실가스 저감과 에너지 절약에 따른 투자회수기간 등의 경제성을 계산하여 제시한다. 계약서를 작성하고 계약을 체결한다. 일반보조금 지급 등과 같은 신재생에너지 도입에 따른 보조금의 신청 등에 필요한 서류 작성을 보조하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"설득","workFunc3":"정밀작업","dJobECd":"6121","dJobECdNm":"[6121]기술 영업원","dJobJCd":"2743","dJobJCdNm":"[2743]기술 영업원","dJobICd":"C291","dJobICdNm":"[C291]일반 목적용 기계 제조업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006007:1', '{"dJobCd":"K000006007","dJobCdSeq":"1","dJobNm":"컴퓨터기술영업원","workSum":"컴퓨터, 모니터, 소프트웨어를 제조사나 유통업체로부터 구입하여 소매업체에 대량으로 판매한다.","doWork":"컴퓨터 본체 전체 또는 부품별로 나누어 판매한다. 판매량과 재고량을 조사하여 물품 주문을 한다. 하자가 있는 불량품을 소매업체로부터 받아 제조사나 유통업체에 반품한다. 물품의 수요와 신제품의 출고를 파악하여 가격을 적정하게 조정하여 재고를 줄인다. 물품을 종류에 맞게 진열대에 비치하고 전시한다. 제품별 특성을 파악하여 고객이 원하는 제품을 권하거나 선택에 도움을 준다. 제품이 정상적으로 작동하는지 확인한다. 부품별로 판매하는 경우에 조립하여 작동 여부를 검사한다. 소프트웨어의 경우에는 컴퓨터 설치사양을 확인하여 판매한다. 컴퓨터를 대량으로 구입·개선하려는 PC방, 컴퓨터 학원, 학교 등에 납품하고 설치를 지원하기도 한다. 소프트웨어를 판매하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"설득","workFunc3":"정밀작업","dJobECd":"6121","dJobECdNm":"[6121]기술 영업원","dJobJCd":"2743","dJobJCdNm":"[2743]기술 영업원","dJobICd":"G465","dJobICdNm":"[G465]기계장비 및 관련 물품 도매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006087:1', '{"dJobCd":"K000006087","dJobCdSeq":"1","dJobNm":"휴대폰기술영업원","workSum":"시장과 기술의 현황을 분석하여 사업적, 기술적 협의를 통해 고객과 계약하고 이를 관리한다.","doWork":"시장의 요구와 환경 변화, 기업 내부와 외부의 기술 현황을 파악하고 분석한다. 분석된 시장 현황 정보를 기반으로 시장을 구체화하고 목표시장을 설정한다. 설정된 목표시장에서의 영업 목표를 달성하기 위한 세부 계획을 수립한다. 휴대폰과 관련된 고객 수요를 파악하여 구체적인 고객을 정의하고 고객의 만족을 높일 수 있는 사업 기회를 발굴한다. 제품의 원가와 경쟁제품 판매가격을 분석하여 판매가격정책을 수립한다. 휴대폰과 관련된 제품과 서비스에 대해 가격을 산출하고, 제안서와 성능 테스트 등의 정보를 제공하여 고객이 구매를 결정하도록 제안한다. 고객과 가격 및 관련 비즈니스 사항을 협의하여 상호 만족하도록 합의를 도출한다. 합의된 내용을 바탕으로 계약서를 작성하여 계약을 수행한다. 후속 사업 기회를 발굴하기 위하여 고객과 지속적인 관계를 유지한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"설득","workFunc3":"정밀작업","dJobECd":"6121","dJobECdNm":"[6121]기술 영업원","dJobJCd":"2743","dJobJCdNm":"[2743]기술 영업원","dJobICd":"C264","dJobICdNm":"[C264]통신 및 방송 장비 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001406:1', '{"dJobCd":"K000001406","dJobCdSeq":"1","dJobNm":"골동품경매사","workSum":"골동품 출품을 의뢰받아 인터넷 또는 모임 장소에서 입찰품목을 설명하고 경매를 진행한다.","doWork":"골동품 경매를 위해 인터넷 또는 방문을 통하여 출품 접수를 받는다. 골동품의 진위 여부를 확인한다. 경매 일시와 장소를 결정한다. 경매할 품목의 순위를 조정한다. 골동품의 입찰품목을 설명한다. 최초 입찰금을 제시하고 입찰가격을 설정한다. 경매를 진행하면서 경쟁 입찰을 유도하고 최종적으로 최고가 입찰가격을 제시한 소비자에게 낙찰결과를 선언한다. 인터넷을 통하여 경매물품을 등록하고 경매낙찰시간을 제시하여 최종시간 경과 후 최고 입찰가격 제시자에게 낙찰결과를 이메일 또는 통신매체를 통하여 통보한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"시각|","workFunc1":"분석","workFunc2":"설득","workFunc3":"관련없음","dJobECd":"6125","dJobECdNm":"[6125]상품 중개인 및 경매사","dJobJCd":"2744","dJobJCdNm":"[2744]상품 중개인 및 경매사","dJobICd":"G461","dJobICdNm":"[G461]상품 중개업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007106:1', '{"dJobCd":"K000007106","dJobCdSeq":"1","dJobNm":"농수산물경매사","workSum":"공영 도매시장에서 농산물과 수산물을 입찰자에게 경매한다.","doWork":"경매 일시와 장소를 조정하고 경매할 품목의 우선순위를 조정한다. 상품의 선호도, 품질, 타 도매시장의 경락가격 및 물량 등을 파악한다. 시장 내의 물량 재고량, 소비자의 소비성향 등 다양한 정보를 수집한다. 구매자의 동향을 면밀하게 관찰하여 경쟁 입찰을 자극하고 수지식, 기록식, 서면입찰식, 전자식 등으로 경매를 진행한다. 상품의 경매를 마감시키고, 최고가 입찰가격을 제시한 고객에게 낙찰결과를 선언하여 알린다. 경매가 끝난 후에 상품의 입찰을 의뢰한 쪽과 입찰자를 관리하고 문제점을 파악한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"손사용|시각|","workFunc1":"분석","workFunc2":"설득","workFunc3":"관련없음","connectJob":"경매하는 품목에 따라 가축경매사, 양곡경매사, 화훼경매사, 산지경매사, 수산물경매사, 약용작물경매사, 청과물경매사, 농산물경매사","certLic":"경매사(약용), 경매사(양곡), 경매사(축산), 경매사(청과), 경매사(화훼), 경매사(수산), 산지경매사","dJobECd":"6125","dJobECdNm":"[6125]상품 중개인 및 경매사","dJobJCd":"2744","dJobJCdNm":"[2744]상품 중개인 및 경매사","dJobICd":"G461","dJobICdNm":"[G461]상품 중개업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002738:1', '{"dJobCd":"K000002738","dJobCdSeq":"1","dJobNm":"미술품경매사","workSum":"미술품 출품을 의뢰받아 인터넷 또는 모임 장소에서 입찰품목을 설명하고 경매를 진행한다.","doWork":"미술품 경매를 위해 인터넷 또는 방문을 통하여 출품 접수를 받는다. 미술품의 진위 여부를 확인한다. 경매 일시와 장소를 결정한다. 경매할 품목의 순위를 조정한다. 미술품의 입찰품목을 설명한다. 최초 입찰금을 제시하고 입찰가격을 설정한다. 경매를 진행하면서 경쟁 입찰을 유도하고 최종적으로 최고가 입찰가격을 제시한 소비자에게 낙찰결과를 선언한다. 인터넷을 통하여 경매물품을 등록하고 경매낙찰시간을 제시하여 최종시간 경과 후 최고 입찰가격 제시자에게 낙찰결과를 이메일 또는 통신매체를 통하여 통보한다. 경매품의 이력, 소장경위 등 작가 및 작품의 조사 및 국낸외 미술품동향 등을 조사하기도 한다. 미술품 실측 및 촬영, 도록제작 및 교정, 원고작성 등을 하기도 한다. 작품 설치, 미술품 가치평가 및 진위 의뢰, 영업(작품 수급 및 판매, 고객응대, 전시장 관리 등) 등을 하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"청각|시각|","workFunc1":"분석","workFunc2":"설득","workFunc3":"관련없음","similarNm":"미술품스페셜리스트","connectJob":"예술품경매사","dJobECd":"6125","dJobECdNm":"[6125]상품 중개인 및 경매사","dJobJCd":"2744","dJobJCdNm":"[2744]상품 중개인 및 경매사","dJobICd":"G461","dJobICdNm":"[G461]상품 중개업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004659:1', '{"dJobCd":"K000004659","dJobCdSeq":"1","dJobNm":"상품중개인","workSum":"각종 상품의 등급, 무게, 수량 등을 파악하여 공급자와 수요자 간의 거래가 이루어질 수 있도록 중개한다.","doWork":"각종 자료, 경험을 통해 상품의 품질, 가격 등에 관한 시장정보를 분석한다. 상품 샘플을 검사하여 등급 및 품질을 결정한다. 제조자 혹은 생산자와 거래조건에 관해 면담하고 공장이나 재배지를 방문하여 구매한다. 상품인도 계획을 세운다. 상품대금을 지불하며 관련 서류를 작성·수령한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"설득","workFunc3":"관련없음","connectJob":"농산물중개인, 청과물중개인, 예술품중개인","dJobECd":"6125","dJobECdNm":"[6125]상품 중개인 및 경매사","dJobJCd":"2744","dJobJCdNm":"[2744]상품 중개인 및 경매사","dJobICd":"G461","dJobICdNm":"[G461]상품 중개업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002170:1', '{"dJobCd":"K000002170","dJobCdSeq":"1","dJobNm":"선박매매중개인","workSum":"선박을 판매하고자 하는 매도인과 선박을 구입하고자 하는 구매인 사이에서 선박매매를 중개한다.","doWork":"선주로부터 매매의뢰를 받고 매매선가, 매매조건, 요구선종 등을 확인한다. 세계중고선 시장, 선박매매중개인 네트워크, 온라인 선박정보시스템 등에 매매의사를 공개하고 다양한 방법으로 매매 가능한 선박을 물색한다. 적정한 매매대상 선박을 선정하고 매매대상 선박의 선주에게 매선의사를 확인한다. 매매대상 선박의 본선명세, 선급검사증명서, 용적도면 등 상세한 자료를 확보하고 검토한다. 매매대상 선박의 매각/도입 예상선가, 향후 폐선가격, 영업수익, 채산성, 금융비용, 고정비 등을 고려하여 경제성을 평가한다. 필요한 경우 선박의 경제성을 높이는 금융방안을 제안하여 매매를 유도하기도 한다. 매도, 매수자의 합의에 따라 선박검선을 진행한다. 매도, 매수자 사이에서 선박매매 협상을 진행한다. 매매가 결정되면 계약서를 작성하고 관련 서류를 구비한다. 잔금 지불과 함께 선박인도를 진행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"조정","workFunc2":"설득","workFunc3":"관련없음","similarNm":"선박딜러, Sale & Purchase Broker, S&P Broker","dJobECd":"6125","dJobECdNm":"[6125]상품 중개인 및 경매사","dJobJCd":"2744","dJobJCdNm":"[2744]상품 중개인 및 경매사","dJobICd":"G461","dJobICdNm":"[G461]상품 중개업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005422:1', '{"dJobCd":"K000005422","dJobCdSeq":"1","dJobNm":"용선중개인","workSum":"선박을 이용한 화물운송 과정에서 선주와 화주(혹은 선주) 간의 용선계약을 중개한다.","doWork":"국내외의 선주(선사), 화주, 용선중개인들과의 채널(Channel)을 구축하고 관리한다. 채널을 통해 화물이 필요한 선주(선사)와 선박이 필요한 화주에 대한 정보를 찾거나, 선주와 화주로부터 직접 의뢰를 받는다. 선주와 화주에 대한 정보를 바탕으로 서로가 원하는 선박의 종류, 화물종류, 선적일, 화물량, 용선료 등의 조건을 비교한다. 여러 조건을 서로 최적으로 충족시킬 수 있는 선주와 화주를 선택한다. 양측에 팩스, 전자메일(E-mail), 전화 등을 이용해 용선계약을 제의한다. 선주측과 화주측이 제의를 받아들이면, 용선계약서(C/P)의 구체적인 조항에 대해 협의한다. 양측 중간에서 최종적인 용선계약이 이루어질 수 있도록 협상을 중개한다. 선주와 화주 간의 용선계약을 중개하고, 선박을 가지고 있는 선주와 선박을 필요로 하는 선주 간의 용선계약을 중개한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"조정","workFunc2":"설득","workFunc3":"관련없음","dJobECd":"6125","dJobECdNm":"[6125]상품 중개인 및 경매사","dJobJCd":"2744","dJobJCdNm":"[2744]상품 중개인 및 경매사","dJobICd":"G461","dJobICdNm":"[G461]상품 중개업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006734:1', '{"dJobCd":"K000006734","dJobCdSeq":"1","dJobNm":"회원권중개인","workSum":"골프, 콘도, 스포츠 회원권의 매수 및 매도를 위해 매도인과 매수인에게 회원권 시세 등의 정보를 제공하고 거래가 이루어지도록 중개한다.","doWork":"인터넷사이트, 잡지 등을 통해 회원권의 시세와 이용 정보를 수집한다. 회원권협회 회원사들 간에 서로의 매물정보와 시세정보를 공유함으로써 실제 거래가를 산정한다. 회원권 매수인과 매도인에게 회원권의 시세, 세금 감세 등 관련 정보를 제공하여 거래를 유도한다. 회원권의 시세 및 관련 분야의 동향을 상시적으로 수집하여 고객에게 전달하며 회원들을 관리한다. 거래가 성사된 후 매수 및 매도에 따른 법적·행정적 절차를 대행하기도 한다. 회원권과 관련한 정보를 신문, 잡지, 인터넷 등에 기고하거나 제공한다. 신규회원을 모집하여 관리하며 각종 홍보물을 제공한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"언어력|","workFunc1":"수집","workFunc2":"설득","workFunc3":"관련없음","similarNm":"회원권딜러","connectJob":"골프회원권딜러, 회원권분양영업원","dJobECd":"6125","dJobECdNm":"[6125]상품 중개인 및 경매사","dJobJCd":"2744","dJobJCdNm":"[2744]상품 중개인 및 경매사","dJobICd":"G461","dJobICdNm":"[G461]상품 중개업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005486:1', '{"dJobCd":"K000005486","dJobCdSeq":"1","dJobNm":"부동산경매인","workSum":"고객으로부터 의뢰를 받아 법원 경매나 국가, 지방자치단체 및 공법인에 의해 시행되는 공매 등 부동산경매 시장에 나온 경매 물건에 대해서 권리분석과 현장확인 업무를 하고 의뢰인의 경매 참여를 지원한다.","doWork":"고객으로부터 부동산경매에 의한 매입 의뢰를 받으면, 법원 경매나 국가 및 지방자치단체 및 공법인에 의해 시행되는 공매 등 부동산경매 물건을 검색한다. 주변 아파트 시세 등의 시장조사를 하고, 해당 경매 물건에 대한 등기부 등본 확인, 관리비 납부 상황 확인, 세입자나 집주인 존재에 대한 세대 열람 등의 현장 확인을 한다. 근저당, 가압류 등의 법적 권리분석을 한다. 법원에 고객과 동행하여 고객이 경매입찰서를 작성하는 것을 돕고 예상 낙찰가격을 자문한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"설득","workFunc3":"관련없음","similarNm":"부동산경매사","connectJob":"법원부동산경매원, 법원경매인, 부동산경매상담원, 부동산경매컨설턴트, 부동산공매컨설턴트","certLic":"공인중개사, 법무사, 변호사","dJobECd":"6110","dJobECdNm":"[6110]부동산 컨설턴트 및 중개인","dJobJCd":"2745","dJobJCdNm":"[2745]부동산 컨설턴트 및 중개사","dJobICd":"L682","dJobICdNm":"[L682]부동산 관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004368:1', '{"dJobCd":"K000004368","dJobCdSeq":"1","dJobNm":"부동산신탁관리원","workSum":"소유자의 편익이나 관리효율 극대화를 위해 부동산을 관리·처분하거나, 최유효시설로 개발하는 업무를 대행한다.","doWork":"부동산 소유주로부터 신탁청약을 접수하고, 신탁에 따른 내용을 설명한다. 신탁부동산에 대한 물건, 환경, 법적규제, 이용상황, 인근의 임대료 등을 조사하고 신탁계약을 체결한다. 신탁부동산의 종합관리계획을 작성하고, 소유권이전 및 신탁등기를 한다. 신탁물건을 유지·관리하기 위하여 관련 보험가입, 임차인모집, 임대보증금운용, 제세공과금의 납부, 건물의 유지·보수 등의 결산보고서를 작성한다. 신탁부동산의 운용에 따른 수익금을 배당한다. 부동산을 신탁받아 처분하는 업무를 수행하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","connectJob":"부동산처분신탁관리원","dJobECd":"6110","dJobECdNm":"[6110]부동산 컨설턴트 및 중개인","dJobJCd":"2745","dJobJCdNm":"[2745]부동산 컨설턴트 및 중개사","dJobICd":"L682","dJobICdNm":"[L682]부동산 관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007536:1', '{"dJobCd":"K000007536","dJobCdSeq":"1","dJobNm":"부동산중개인","workSum":"부동산 중개대상물에 대하여 거래당사자 간의 매매·교환·임대차 및 권리의 득실변경에 관한 행위를 알선·중개하고 일정한 보수를 받는다.","doWork":"토지, 건축물 그 밖의 토지의 정착물, 입목, 공장, 공장재단·광업재단(공장이나 광업에 속하는 기업재산으로서 소유권과 저당권의 목적물) 등 각종 중개대상물에 대한 다양한 정보를 수집한다. 중개대상물의 지번, 대지, 건평, 매도희망액 등을 파악하여 정리한다. 매입을 희망하는 고객과 상담하여 매입희망 물건의 종류와 매입금액 등을 파악하고 적절한 매물을 추천한다. 양 거래당사자(매도·매수인) 간에 부동산 거래계약이 성립하도록 권리분석, 자료제공, 시장조사, 현장안내, 거래조건의 흥정·교섭 등을 진행한다. 계약이 합의되면 매매계약서에 매매대상물의 지번, 평수, 가옥구조, 매매가액, 계약금액, 중도금액, 지불일시, 잔금지불일시 등을 결정·기재한다. 양도일시, 매매조건과 단서조항을 기재하고, 계약일시와 매도·매수인 및 중개인의 인적사항을 기재하고 서명·날인하여 계약을 완료한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"아주 가벼운 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"설득","workFunc3":"관련없음","similarNm":"공인중개사","certLic":"공인중개사","dJobECd":"6110","dJobECdNm":"[6110]부동산 컨설턴트 및 중개인","dJobJCd":"2745","dJobJCdNm":"[2745]부동산 컨설턴트 및 중개사","dJobICd":"L682","dJobICdNm":"[L682]부동산 관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003749:1', '{"dJobCd":"K000003749","dJobCdSeq":"1","dJobNm":"부동산컨설턴트","workSum":"부동산에 관련된 정보를 수집·분석하여 개인 및 기업체에게 부동산정보를 제공한다.","doWork":"토지나 건물의 최적의 활용방안을 분석하기 위하여 각종 자료를 수집·분석한다. 부동산의 보유, 매매, 개발의 타당성을 검토한다. 개발 시 최적시설·최적규모를 판정하여 투자수익성을 분석한다. 관련 지역 부동산의 시세나 임대료 등의 가격을 조사한다. 시설물의 설치에 따른 각종 자료를 수집하여 지역의 상권분석을 한다. 부동산세무나 관련 법규, 인허가 등에 관하여 상담자에게 자문한다. 각종 자료를 조사·분석하여 부동산의 분양전략이나, 새로운 형태의 부동산 상품을 개발한다. 해외의 각종 자료를 수집하여 해외부동산의 실태를 조사하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"자문","workFunc3":"관련없음","similarNm":"부동산상담원","connectJob":"주택상담원, 재건축상담원","certLic":"공인중개사","dJobECd":"6110","dJobECdNm":"[6110]부동산 컨설턴트 및 중개인","dJobJCd":"2745","dJobJCdNm":"[2745]부동산 컨설턴트 및 중개사","dJobICd":"L682","dJobICdNm":"[L682]부동산 관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001749:1', '{"dJobCd":"K000001749","dJobCdSeq":"1","dJobNm":"주택임대관리사","workSum":"임대 목적으로 제공하는 주택의 임대인(소유주)을 대신하여 시설의 운영관리, 유지보수, 민원처리, 월세징수, 세금납부 등 주택임대관리 업무를 수행한다.","doWork":"임차인을 모집한다. 월세징수, 세금납부 등을 대리한다. 임차인의 유지보수 요구 등 민원을 처리하고, 분쟁으로 인한 법적 처리를 한다. 시장분석 및 적정가치평가, 사업진행방향 도출, 적정 상품구성 및 시장전망, 기업보유 부동산에 대한 최적 개발방안 및 수익성 분석 등 임대자문 컨설팅을 한다. 시설의 보수가 필요한 경우 업자를 수배하고 견적을 비교하며 공사진행 시 확인 등의 업무를 한다. 매각·매입 대행서비스를 수행하기도 한다. 연체자를 대상으로 납부를 요청하며 관련하여 행정 절차를 밟기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"언어력|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","certLic":"공인중개사, 주택관리사","dJobECd":"6110","dJobECdNm":"[6110]부동산 컨설턴트 및 중개인","dJobJCd":"2745","dJobJCdNm":"[2745]부동산 컨설턴트 및 중개사","dJobICd":"L681","dJobICdNm":"[L681]부동산 임대 및 공급업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006166:1', '{"dJobCd":"K000006166","dJobCdSeq":"1","dJobNm":"아트컨설턴트","workSum":"고객에게 주택이나 사무실 등의 공간에 어울리는 그림, 조각 등의 미술작품을 제안하고, 미술품을 설치·관리한다.","doWork":"고객과의 상담을 통해 고객의 취향이나 분위기, 가용예산 등을 파악한다. 미술품이 설치될 공간을 직접 방문하여 전체적인 이미지에 맞는 미술품을 선정하고 고객에게 제시한다. 설치될 미술품을 컴퓨터시뮬레이션을 활용하여 가상공간에 배치하여 고객에게 제시하고, 고객의 최종 승낙을 받는다. 적합한 미술품을 보유하고 있지 않은 경우 적합한 미술품 소장자를 물색하여 미술품을 임대하기도 한다. 최종 선택된 미술품을 공간에 설치하거나 설치를 감독한다. 미술품을 판매하거나 임대한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"시각|","workFunc1":"분석","workFunc2":"설득","workFunc3":"관련없음","dJobECd":"6129","dJobECdNm":"[6129]기타 기술 영업·중개 종사원","dJobJCd":"2749","dJobJCdNm":"[2749]기타 기술 영업 및 중개 관련 종사원","dJobICd":"G461","dJobICdNm":"[G461]상품 중개업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001235:1', '{"dJobCd":"K000001235","dJobCdSeq":"1","dJobNm":"각색작가","workSum":"원천 콘텐츠를 2차 저작물의 특성에 맞춰 형태를 재구성한다.","doWork":"원천 콘텐츠의 기획의도, 등장인물, 줄거리 등의 시놉시스와 트리트먼트(treatment: 시놉시스를 발전시켜 장면(scene)별로 구체적 묘사하는 글) 단계를 거쳐 시나리오를 작성한다. 줄글 형태의 원작 또는 시나리오를 바탕으로, 스토리보드의 형태의 그림 콘티를 제작한다. 그림 콘티 제작 과정에서 식자(말풍선에 대사를 넣는 일) 작업을 하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"콘티작가, 시나리오작가","dJobECd":"4111","dJobECdNm":"[4111]작가","dJobJCd":"2811","dJobJCdNm":"[2811]작가","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004217:1', '{"dJobCd":"K000004217","dJobCdSeq":"1","dJobNm":"게임시나리오작가","workSum":"게임 개발을 위하여 게임 세계관과 캐릭터를 활용한 스토리텔링을 구상하여 시나리오와 스토리보드를 작성하고, 스크립트를 제작한다.","doWork":"게임의 방향성과 관련하여 게임의 전반적인 개념과 흐름을 이해한다. 게임 세계관과 시스템, 월드 구조에 대한 이해를 바탕으로 상호 작용하는 스토리텔링을 창작하여 게임플레이와 이벤트로 나누어 구성한 스토리 플로우 문서를 작성한다. 스토리 플로우를 바탕으로 필요한 캐릭터와 배경을 포함한 스토리 요소의 수량을 기획한다. 세부적인 게임스토리 창출을 위하여 캐릭터 설정, 주제설정, 소재탐구, 게임벤치마킹 등 게임의 전반적인 기획을 수행한다. 전체 게임 시간, 게임 주제, 게임의 방법 등을 고려하여 스토리보드 및 콘티를 구성한다. 스토리보드를 작성하고, 세부적인 스토리뿐만 아니라 대사, 대화 등 전체적인 스토리를 창작하여 이야기를 구성한다. 스토리 요소에 대한 역할과 특징을 구성하며, 실제 게임에 적용할 수 있는 텍스트 자원과 스크립트를 제작한다. 게임 시나리오의 구조 및 제작 방법을 구체적으로 시각화하며, 게임 화면에서의 캐릭터와 요소의 위치, 동선이 포함된 화면 구조, 카메라 움직임, 캐릭터의 연기 등을 글과 그림으로 표현한다. 스토리 이벤트 시간에 따른 스토리보드를 완성하고 확인하며 분석한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"게임시나리오라이터","certLic":"게임기획전문가","dJobECd":"4111","dJobECdNm":"[4111]작가","dJobJCd":"2811","dJobJCdNm":"[2811]작가","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006450:1', '{"dJobCd":"K000006450","dJobCdSeq":"1","dJobNm":"광고문안작성원","workSum":"광고물의 목적, 개념 등을 소비자에게 효과적으로 전달할 수 있도록 언어적 표현 전략을 구상·수립하여 광고문안을 작성한다.","doWork":"광고물의 목적(이미지 제고, 판매 신장 등)을 파악하고 전략회의를 통해서 개념을 정교화한다. 광고기획자, 광고그래픽디자이너(AD) 등과 광고제작에 대한 전략을 구상하고 협의한다. 상품 및 용역에 대한 시장조사, 광고대상자 성향조사, 광고 경향조사 자료 등을 분석하여 광고 표현전략을 수립한다. 광고전략에 따라 광고문안을 작성한다. 작성된 문안에 대하여 적합성 여부를 광고기획자, 광고그래픽디자이너, 광고주 등과 협의한다. 협의 후 지적된 문제점을 수정하고 반영한다. 광고 제작에 광고문안이 적절히 반영되고 있는지를 모니터링하고 조언한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"카피라이터","connectJob":"스토리텔러","dJobECd":"4111","dJobECdNm":"[4111]작가","dJobJCd":"2811","dJobJCdNm":"[2811]작가","dJobICd":"M713","dJobICdNm":"[M713]광고업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001937:1', '{"dJobCd":"K000001937","dJobCdSeq":"1","dJobNm":"구성작가","workSum":"텔레비전, 라디오, 인터넷 등의 오락프로그램, 교양물 등의 비드라마용 방송프로그램의 진행 원고를 작성한다.","doWork":"텔레비전의 오락물, 교양물 프로그램, 라디오프로그램 등의 방송내용 기획과 방향을 방송프로듀서(방송연출가)와 협의한다. 원고작성을 위하여 자료를 수집하고 정리한다. 인터넷 게시판, 메일, 우편물 등을 확인하여 사연을 정리한다. 수집한 자료를 기초로 프로그램의 성격에 맞춰 원고를 작성한다. 방송 중에는 프로그램 진행자의 순조로운 진행을 돕고, 원고를 수정한다. 방송출연자를 섭외하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"방송작가","connectJob":"경력에 따라 담당하는 경우 메인구성작가, 서브구성작가, 보조작가","dJobECd":"4111","dJobECdNm":"[4111]작가","dJobJCd":"2811","dJobJCdNm":"[2811]작가","dJobICd":"J601/J602","dJobICdNm":"[J601]라디오 방송업 / [J602]텔레비전 방송업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002034:1', '{"dJobCd":"K000002034","dJobCdSeq":"1","dJobNm":"극작가","workSum":"연극을 상연하기 위한 대본(극본, 희곡)을 쓴다.","doWork":"작품의 주제를 정하고 줄거리를 구상한다. 연극을 전개할 인물, 사건, 배경을 구상하고 해설(극의 무대장치, 인물, 배경을 설명하는 글), 지문(배경, 효과, 조명, 등장인물의 행동, 표정, 심리 등을 지시 또는 설명하는 글), 대사(대화對話, 독백獨白, 방백傍白 등 등장인물이 하는 말)을 쓴다. 연극의 전개에 따라 막(幕, Act)과 장(場, Scene)을 구분한다. 인물의 표정, 음향, 조명 등에 대하여 연극연출가와 협의하기도 한다. 자기가 쓴 각본을 직접 연출하기도 하고 소설 등의 작품을 각색하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"희곡작가, 희극작가","dJobECd":"4111","dJobECdNm":"[4111]작가","dJobJCd":"2811","dJobJCdNm":"[2811]작가","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003424:1', '{"dJobCd":"K000003424","dJobCdSeq":"1","dJobNm":"네이미스트","workSum":"시장 상황과 유행을 고려하여 기업명이나 상표, 도메인, 인명 등의 이름을 짓는다.","doWork":"이름을 만들고자 하는 제품의 특징과 수요층을 파악한다. 제품에 어울릴만한 이름의 안을 만든다. 다른 네이미스트와 함께 2~3개의 후보작을 고른다. 후보작들과 같은 이름으로 등록되지는 않았는지 등록 여부를 확인한다. 의뢰자와 협의를 통해 최종 이름을 결정한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"4111","dJobECdNm":"[4111]작가","dJobJCd":"2811","dJobJCdNm":"[2811]작가","dJobICd":"M713","dJobICdNm":"[M713]광고업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003616:1', '{"dJobCd":"K000003616","dJobCdSeq":"1","dJobNm":"다큐작가","workSum":"다큐멘터리의 구성대본을 작성한다.","doWork":"다큐멘터리 프로그램 기획회의에 참여하여 프로그램 기획안(타이틀, 방송시간, 형식, 방송체널, 희망방송일시, 기획의도, 제작방향, 구성내용, 예상 아이템)을 작성한다. 자료조사를 바탕으로 아이템을 제안·선정한다. 취재 및 섭외를 통해 사실관계를 확인하며 어떤 영상을 찍을 수 있고 어떤 상황이 연출될 것인지 구상·확인한다. 촬영구성안을 작성하여 프로듀서와 카메라감독에게 제시한다. 촬영구성안을 토대로 촬영이 진행되면, 촬영된 내용을 프리뷰하고 프리뷰노트(촬영된 화면에서 영상과 현장음을 적은 노트)를 작성하며 내용을 검토하고 프로듀서와 카메라감독에게 제작방향을 조언한다. 프리뷰노트를 기초로 편집구성안(편집콘티)을 작성하여 프로듀서에게 제시한다. 편집구성안을 토대로 프로듀서가 가편집본을 제작하면 프로듀서와 함께 Final Cutting(작가가 편집에 대한 자신의 의견을 개진하고 구성의 틀을 협의하는 일)을 진행한다. 시사(Chief Producer와 함께 프로그램을 보면서 평가하는 과정)와 종합편집(영상에 필요한 효과나 자막, 컴퓨터 그래픽 등을 넣어 방송 가능한 영상으로 마무리하는 작업) 과정을 거쳐 완성된 영상을 보면서 내레이션 원고(Narration:장면 밖에서 들려오는 목소리. 내레이터가 더빙하도록 커트, 신, 시간이 표기된 원고)를 작성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"청각|언어력|시각|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"4111","dJobECdNm":"[4111]작가","dJobJCd":"2811","dJobJCdNm":"[2811]작가","dJobICd":"J602","dJobICdNm":"[J602]텔레비전 방송업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006902:1', '{"dJobCd":"K000006902","dJobCdSeq":"1","dJobNm":"대본작가","workSum":"영화 및 드라마 또는 애니메이션을 제작하기 위하여 창작글을 쓰거나 문학작품의 내용을 각색하여 시나리오(대본)를 쓴다.","doWork":"시나리오(대본)를 쓰기 위해 주제, 등장인물 및 이야기를 구상한다. 인물의 성격 및 스토리에 포함될 사건을 결정하고 전반적인 시놉시스(시나리오 또는 대본 전체를 요약한 개요 혹은 줄거리)를 그린다. 각 장면의 특징에 따라 인물의 표정, 동작, 음향, 조명 등을 구성하고 설정된 주제 및 줄거리에 맞게 대본을 작성한다. 문학작품, 희곡 등을 선정하여 시나리오(대본) 형태로 재작성한다. 영화제작자, 방송프로듀서(방송연출가) 등과 함께 작품의 내용을 협의하고 수정한다. 다른 대본작가가 쓴 시나리오를 다시 재구성(윤색)하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"시나리오작가, 방송작가","connectJob":"전문 분야에 따라 영화시나리오작가, 만화스토리작가","dJobECd":"4111","dJobECdNm":"[4111]작가","dJobJCd":"2811","dJobJCdNm":"[2811]작가","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002802:1', '{"dJobCd":"K000002802","dJobCdSeq":"1","dJobNm":"도움말메뉴제작자","workSum":"기술적인 주제에 대해 사용자의 이해를 돕고자 사용자 매뉴얼을 작성하고 그 내용을 컴퓨터상에서 도움말 메뉴 등으로 구현한다.","doWork":"기획팀, 마케팅팀, 품질관리팀의 관계자들과 출시 제품의 도움말 기능의 기획, 품질, 홍보 등에 대하여 협의한다. 기술적인 주제와 관련된 내부문서나 제품설명서 등을 알기 쉽게 작성하고 정리한다. 컴퓨터 화면상에서의 글의 위치를 결정하고 표현될 그래픽 등을 선정한다. 컴퓨터 화면에서 구현하기 위해 컴파일링을 하거나 HTML, PDF파일 등으로 바꾼다. 컴퓨터 화면에서 구현되는지 시험한다. 도움말 기능 등을 제품에 탑재하여 품질평가를 실시하고 문제가 있을 경우 수정한다. 기술적인 내용을 한글 또는 영어로 번역하거나 번역을 의뢰하고 관리한다. 관련 잡지에 기고를 하거나 강의 교재 등을 제작하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"테크니컬라이터","dJobECd":"4111","dJobECdNm":"[4111]작가","dJobJCd":"2811","dJobJCdNm":"[2811]작가","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005916:1', '{"dJobCd":"K000005916","dJobCdSeq":"1","dJobNm":"드라마작가","workSum":"방송드라마 대본을 집필한다.","doWork":"작품을 통해서 전달하고자 하는 주제 및 소재를 설정한다. 문헌조사나 인터뷰 등의 자료조사를 통해 주제 및 극의 초점을 구체적으로 다듬는다. 극의 사건과 갈등을 표현할 등장인물을 창조하고 시간적·공간적 환경을 구체적으로 설정한다. 인물, 사건, 환경을 구성하여 스토리(한 작품의 서술요소를 구성하는 일련의 사건들)를 창작한다. 스토리를 플롯(Plot:극작품의 복잡화를 구성하는 극행동들의 집합, 음모, 계획, 책략) 형태로 구성한다. 플롯으로 짜인 스토리를 분해하여 시퀀스(Sequence :같은 생각들이 연속적으로 모여진 몇 개의 장면들의 집합. 한 편의 드라마는 몇 개의 시퀀스가 모여서 완성됨)로 나누고, 다시 신(Scene :장면)으로 세분화하고 극의 전개 순서대로 배열한다. 장면마다 그 특징과 내용을 간략히 표시하여 대본을 완성한다. 시놉시스(드라마의 제목, 주제, 기획 및 집필의도, 등장인물, 줄거리를 요약한 드라마의 설계도)를 작성한다. 대본 작업 전에 소재를 찾기 위해 헌팅(촬영장소 답사)에 참여하거나 헌팅사진을 받아 참고하기도 한다. 배역캐스팅에 관여하기도 한다. 미리 작성된 시놉시스를 드라마프로듀서(PD)에게 제출하거나, 드라마프로듀서로부터 집필의뢰를 받기도 한다. 드라마촬영을 시작하면서 다음 회 대본을 작성하거나 여러 상황에 따라 대본을 수정하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"청각|언어력|시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"드라마작가를 보조하는 경우 드라마보조작가","dJobECd":"4111","dJobECdNm":"[4111]작가","dJobJCd":"2811","dJobJCdNm":"[2811]작가","dJobICd":"J602","dJobICdNm":"[J602]텔레비전 방송업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006639:1', '{"dJobCd":"K000006639","dJobCdSeq":"1","dJobNm":"라디오작가","workSum":"라디오 프로그램의 구성대본을 작성한다.","doWork":"라디오 편성에 따른 방송 운행표(라디오 프로그램의 시작과 종료시각, 광고의 길이와 내용, 캠페인의 내용과 시간, 시각고지 등이 표시된 표)를 확인하고 프로그램의 편성의도를 파악한다. 라디오프로듀서와 함께 기획회의를 진행하여 코너, 큐시트, 패널, 청취자 참여 등을 기획하고 프로그램 기획안(타이틀, 방송시간, 형식, 방송채널, 희망방송일시, 기획의도, 제작방향, 구성내용, 예상 아이템)을 작성한다. 기획안이 승인되어 프로그램 제작이 확정되면 프로그램을 구체적으로 구현하기 위한 자료조사를 하고 관련 프로그램을 모니터한다. 청취자 참여, 콩트, 음악코너, 경제코너 등 다양한 코너를 기획한다. 오프닝, 음악, 코너, 클로징 등을 순서대로 배치하여 프로그램 구성을 한다. 라디오 프로듀서와 함께 프로그램의 시그널, 타이틀, 로고, 큐시트를 만든다. 출연자를 섭외한다. 방송원고를 작성한다. 방송이 시작되면 스튜디오 밖에서 청취자 전화연결 등 방송진행을 보조한다. 라디오 방송의 종류에 따라 음악 토크 프로그램, 라디오 시사정보 프로그램, 편지쇼 프로그램, 라디오 공개방송, 라디오 다큐멘터리, 라디오 드라마 등의 구성대본을 작성하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"청각|언어력|시각|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"4111","dJobECdNm":"[4111]작가","dJobJCd":"2811","dJobJCdNm":"[2811]작가","dJobICd":"J601","dJobICdNm":"[J601]라디오 방송업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001541:1', '{"dJobCd":"K000001541","dJobCdSeq":"1","dJobNm":"만화스토리작가","workSum":"만화·웹툰의 주제 및 이야기를 창작하고 이를 만화 시나리오나 콘티로 작성한다.","doWork":"만화·웹툰으로 창작할 소재를 찾고 장르를 구분하여 주제를 정하는 등 아이디어를 구상한다. 웹툰의 기획의도, 캐릭터 및 배경을 설정하여 시놉시스(시나리오 또는 대본 전체를 요약한 개요 혹은 줄거리) 및 트리트먼트(treatment: 시놉시스를 발전시켜 장면(scene)별로 구체적 묘사하는 글)를 작성한다. 줄거리를 토대로 컷 연출을 구성하고 지문과 대사를 작성하여 만화 시나리오를 완성한다. 스토리작가에 따라서는 구획된 공간에 러프 스케치로 그림과 대사를 넣고 컷을 연출하여 콘티를 작성하기도 한다. 그림작가와 협업하여 완성한 만화·웹툰을 웹툰 전문 플랫폼이나 기타 정보통신망에 연재하거나, 만화책으로 출판한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"웹툰스토리작가","dJobECd":"4111","dJobECdNm":"[4111]작가","dJobJCd":"2811","dJobJCdNm":"[2811]작가","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002941:1', '{"dJobCd":"K000002941","dJobCdSeq":"1","dJobNm":"메디컬라이터","workSum":"임상 데이터 혹은 의약학 데이터를 독자 혹은 대상에게 각각에 알맞은 형태나 방법으로 전달하기 위해 자료를 수집, 번역, 분석, 작성, 가공, 편집한다.","doWork":"광고나 방송, 출판, 논문 등에 관련된 의약학 관련 자료 수집 및 작성을 위해 시장조사, 전문가 인터뷰 등을 한다. 수집된 정보를 목적, 대상에 맞춰 작성한다. 작성 결과를 의뢰자 등과 협의하여 수정한다. 환자 및 제약사 영업사원을 대상으로 교육한다. 각종 의약학 세미나 및 좌담회를 진행한다. CRO(임상시험업체)에서 근무할 경우 임상시험 프로토콜(임상시험 방법을 일목요연하게 정리한 문서)을 작성하고 임상시험 결과를 정리해 보고서를 작성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"Medical Writer","certLic":"약사","dJobECd":"4111","dJobECdNm":"[4111]작가","dJobJCd":"2811","dJobJCdNm":"[2811]작가","dJobICd":"C212/M713","dJobICdNm":"[C212]의약품 제조업 / [M713]광고업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007572:1', '{"dJobCd":"K000007572","dJobCdSeq":"1","dJobNm":"소설가","workSum":"등장인물, 사건, 배경 등을 구상하고 주제를 결정하여 일정 형식의 소설을 저술한다.","doWork":"소설의 줄거리나 등장인물 등을 결정하고 역사적 배경이나 사건현장을 조사·분석한다. 역사적 사실, 가상의 세계 등을 검토하여 소설의 내용에 적합하도록 정리한다. 등장인물의 성격, 줄거리의 전개, 심리묘사, 역사적 배경 등을 구상하여 작품을 저술한다. 각 신문사, 출판사, 문예지, 문학상, 인터넷을 통해 등단한다. 신문·잡지 등의 정기간행물에 연재하기도 한다. 역사, 추리, 무협, 애정, 전쟁, 과학 등의 한 분야를 전문으로 하기도 한다. 저술물에 대한 인세, 원고료, 저작권료를 계약한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"공상과학소설가, 역사소설가, 추리소설가, 애정소설가, 공포소설가, 호러소설가","dJobECd":"4111","dJobECdNm":"[4111]작가","dJobJCd":"2811","dJobJCdNm":"[2811]작가","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003440:1', '{"dJobCd":"K000003440","dJobCdSeq":"1","dJobNm":"수필가","workSum":"특정한 현상이나 사물에 관한 느낌을 자유로운 문장형식으로 집필한다.","doWork":"자연현상이나 사물, 현상을 보고 느낀 감정을 자유로운 문장형식으로 기록한다. 작가 자신의 경험을 바탕으로 자신의 정서를 표현하여 전달한다. 각 신문사, 출판사, 문예지, 문학상, 인터넷을 통해 등단한다. 각종 문예지에 기고하거나 수필집을 발간한다. 표현하는 주제에 따라 가벼운 주제를 다루는 경수필, 사회적 문제 등의 무거운 주제를 다루는 중수필을 집필한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"4111","dJobECdNm":"[4111]작가","dJobJCd":"2811","dJobJCdNm":"[2811]작가","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002623:1', '{"dJobCd":"K000002623","dJobCdSeq":"1","dJobNm":"시인","workSum":"자신의 생각과 느낌을 함축적인 시어로 표현한다.","doWork":"자연, 인생 등 여러 현상을 작가의 주관적이고 독특한 시각으로 관찰하여 시적 어구로 기록하여 전달한다. 각 신문사, 출판사, 문예지, 문학상, 인터넷을 통해 등단한다. 각종 문예지에 기고하거나 창작시집을 발간한다. 시 낭송회에 참석하기도 한다. 저술물에 대한 인세, 원고료, 저작권료를 계약한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"산문가","dJobECd":"4111","dJobECdNm":"[4111]작가","dJobJCd":"2811","dJobJCdNm":"[2811]작가","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004527:1', '{"dJobCd":"K000004527","dJobCdSeq":"1","dJobNm":"애니메이션시나리오작가","workSum":"애니메이션을 제작하기 위하여 대본(시나리오)을 작성한다.","doWork":"애니메이션기획자의 기획의도를 파악하여, 작품에 대한 착상을 한다. 표현하고자 하는 주제와 등장인물의 성격 등을 결정하고 전체적인 내용전개를 구상한다. 결정된 내용에 따라 스토리보드 및 콘티를 구성한다. 대본의 현실적인 묘사를 위하여 관련 인물을 연구한다. 각 장면의 특징에 따라 인물의 표정, 동작, 음향, 조명 등을 구상한다. 관련 자료의 준비가 완료되면 설정된 주제 및 줄거리에 맞게 대본을 작성한다. 착상을 얻기 위해 다양한 자료를 폭넓게 수집한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"애니메이션각본작가, 애니메이션스토리작가","dJobECd":"4111","dJobECdNm":"[4111]작가","dJobJCd":"2811","dJobJCdNm":"[2811]작가","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003067:1', '{"dJobCd":"K000003067","dJobCdSeq":"1","dJobNm":"여행작가","workSum":"국내외 여행 및 여행지에 관한 글과 사진으로 책을 엮거나 여행에 관한 글을 기고한다.","doWork":"국내외 여행지의 다양한 콘텐츠를 소개한다. 정보 소개 목적의 가이드북의 경우 출판사와 취재 계획을 세운다. 취재 계획에 따라 여행지에서 직접 조사하여 정보를 수집하고 필요한 경우 사진을 찍어 기록한다. 수집된 정보 및 사진에 대한 설명을 엮어 가이드북 원고를 작성한다. 여행지에서 보고 느꼈던 것을 기록하고 이를 통해 새로운 여행지나 명소들을 소개하는 콘텐츠를 생산한다. 생산한 여행 관련 콘텐츠를 신문, 잡지 등에 기고하거나 여행에세이 등의 여행서적으로 엮기도 한다. 글보다는 이미지 중심인 사진집으로 여행지를 소개하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"여행에세이스트, 여행정보작가","dJobECd":"4111","dJobECdNm":"[4111]작가","dJobJCd":"2811","dJobJCdNm":"[2811]작가","dJobICd":"J581","dJobICdNm":"[J581]서적, 잡지 및 기타 인쇄물 출판업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007026:1', '{"dJobCd":"K000007026","dJobCdSeq":"1","dJobNm":"연설문작성가","workSum":"정치인, 기업인, 특정 개인이나 조직의 인사말, 연설문, 축사, 칼럼, 인터뷰 등의 말씀자료 초안과 수정본을 작성하고 최종본을 정리한다.","doWork":"주어진 맥락과 사회적 배경을 조사해 개인이나 조직의 말과 글을 작성하고 조언한다. 회사에서는 신년사, 창립기념사, 환영사, 칼럼, 사과문 등이 그 대상이고, 정부기관에서는 취임사, 담화문 등 주요행사 말씀을 쓴다. 특별한 경우 명사(개인)의 요청을 받아 서신, 주례사, 자서전 등을 작성한다. 이외에 강연, 칼럼, 저술, 방송출연 등의 방법으로 대중을 상대로 올바른 글쓰기를 알리고 지도하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"연설비서","dJobECd":"4111","dJobECdNm":"[4111]작가","dJobJCd":"2811","dJobJCdNm":"[2811]작가","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007204:1', '{"dJobCd":"K000007204","dJobCdSeq":"1","dJobNm":"예능작가","workSum":"예능 프로그램의 구성대본을 작성한다.","doWork":"예능프로그램 기획회의에 참여하여 프로그램 기획안(타이틀, 방송시간, 형식, 방송채널, 희망방송일시, 기획의도, 제작방향, 구성내용, 예상 아이템)을 작성한다. 자료조사를 바탕으로 아이템을 제안·선정한다. 취재 및 섭외를 통해 출연자를 확정한다. 진행자 및 출연자의 몸짓, 말투, 대화방식, 장점 등을 연구하고 시청자의 요구, 프로그램의 특성 등을 고려하여 대본을 작성한다. 여러 예능작가들과 공동으로 작업하기도 한다. 담당하는 프로그램에 따라 코미디 프로그램, 시트콤, 토크쇼, 퀴즈쇼, 가요쇼 등의 대본을 전문으로 작성한다. 프로그램에 따라 방송제작 현장에서 즉흥적으로 대본을 작성하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"청각|언어력|시각|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"4111","dJobECdNm":"[4111]작가","dJobJCd":"2811","dJobJCdNm":"[2811]작가","dJobICd":"J602","dJobICdNm":"[J602]텔레비전 방송업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001536:1', '{"dJobCd":"K000001536","dJobCdSeq":"1","dJobNm":"웹툰작가","workSum":"웹툰의 주제 및 이야기를 창작하고 이를 그림으로 그린다.","doWork":"웹툰(정보통신망을 통하여 유통하기 위하여 정보통신망에서 제작된 만화)으로 그릴 소재를 찾고 장르를 구분하여 주제를 정하는 등 아이디어를 구상한다. 웹툰의 캐릭터 및 배경을 설정하여 시놉시스(시나리오 또는 대본 전체를 요약한 개요 혹은 줄거리)를 작성한다. 줄거리를 구성하고 지문과 대사를 작성하여 시나리오를 완성한다. 구획된 공간에 그림과 대사를 넣고 컷을 연출하여 콘티를 제작한다. 컴퓨터에 연결된 디지털 태블릿에 스케치한 후 세부 그림을 그리고 채색하여 배경 및 만화적 효과(효과음, 배경 효과, 빛 효과, 집중선 효과 등)를 넣어 완성한다. 대부분 창작 과정에서 컴퓨터 또는 모바일 디바이스에서 세로로 감상하는 스크롤 뷰(scroll view)에 적합한 연출을 고려하며, 일부는 전통적인 페이지 뷰(page view) 연출도 활용한다. 완성한 작품을 웹툰 연재 전문 플랫폼이나 기타 정보통신망에 연재한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"만화가","dJobECd":"4111","dJobECdNm":"[4111]작가","dJobJCd":"2811","dJobJCdNm":"[2811]작가","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006743:1', '{"dJobCd":"K000006743","dJobCdSeq":"1","dJobNm":"인터넷소설가","workSum":"이모티콘과 통신어체를 사용하여 소설을 쓰고, 이를 인터넷상의 공간에 연재한다.","doWork":"인터넷상의 공간에 소설을 올리기 위하여 줄거리를 구상한다. 역사적 배경이나 사건현장을 조사·분석한다. 결정된 줄거리를 토대로 이모티콘, 통신어체 등을 사용하여 인터넷상의 공간에 글을 올린다. 현실적인 묘사를 위하여 현장을 답사하고 관련 인물을 연구한다. 독자의 반응을 살펴 내용상의 오류, 잘못된 표현 등을 수정하고, 다음 연재에 참고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"웹소설작가","dJobECd":"4111","dJobECdNm":"[4111]작가","dJobJCd":"2811","dJobJCdNm":"[2811]작가","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006243:1', '{"dJobCd":"K000006243","dJobCdSeq":"1","dJobNm":"작사가","workSum":"각종 음악 작품을 위해 가사를 작사한다.","doWork":"작곡된 음악을 듣고 분위기나 주제에 알맞은 가사를 구상하거나 일정한 형식에 맞도록 가사를 구성한다. 음악의 종류(가요, 동요, 영화음악)에 따라 가사의 분위기, 언어의 배열 등을 음율법, 가창법 등을 고려하여 구상한다. 정리된 가사를 작곡가와 협의하여 수정하기도 하며 행사음악이나 사가(회사음악), 종교음악, 창작가곡 등을 작사하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"4111","dJobECdNm":"[4111]작가","dJobJCd":"2811","dJobJCdNm":"[2811]작가","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005005:1', '{"dJobCd":"K000005005","dJobCdSeq":"1","dJobNm":"전기작가","workSum":"대상인물의 삶에 관련된 자료를 조사하거나 직접 청취하여 재구성한 전기(인물이 실제 겪은 사실을 바탕으로 기록한 글)를 집필한다.","doWork":"일기, 편지, 개인서류 등 대상인물이 관계된 사건의 기록이나 보도기사 및 관련 자료를 수집한다. 역사적 환경에 의거하거나 다른 여러 방법을 적용하여 대상인물이 관계한 사건에서 활약상이나 성격 등을 연구·분석한다. 자료의 분석이 완료되면 시대의 흐름에 따라 글을 배열하고 대상인물의 특징을 극적으로 묘사한다. 생존 인물과 관련된 글을 집필할 경우에는 직접 인터뷰를 하고 작성한다. 자신의 일생을 쓰는 경우 자서전, 일생 중 한 부분을 쓰는 경우 회고록, 비평적 전기를 쓰는 경우 평전으로 부르기도 한다. 대상인물의 의뢰에 의해 집필하는 경우 집필료를 계약하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"집필하는 전기의 종류에 따라 자서전작가, 회고록작가, 평전작가, 열전작가","dJobECd":"4111","dJobECdNm":"[4111]작가","dJobJCd":"2811","dJobJCdNm":"[2811]작가","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004610:1', '{"dJobCd":"K000004610","dJobCdSeq":"1","dJobNm":"콘티라이터","workSum":"시나리오나 대본 등의 글로 쓰인 이야기를 영화나 드라마, 애니메이션 제작을 위해 그림으로 나타낸다.","doWork":"영화, 드라마 및 애니메이션에 등장하는 인물 및 캐릭터의 성격, 연출방향 등을 파악하기 위해 영화감독, 방송프로듀서(방송연출가) 및 컴퓨터애니메이션감독 등과 협의한다. 시나리오(대본)를 분석하여 이야기의 전개 순서 및 배정 시간을 구분한다. 콘티지에 주요 장면을 대략적으로 그린다. 효과, 음악, 조명, 카메라앵글, 시간이나 기타 유의사항을 그림과 함께 기술한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"콘티작가","connectJob":"전문 분야에 따라 영화콘티작가, 방송콘티작가, 애니메이션콘티작가","dJobECd":"4111","dJobECdNm":"[4111]작가","dJobJCd":"2811","dJobJCdNm":"[2811]작가","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001591:1', '{"dJobCd":"K000001591","dJobCdSeq":"1","dJobNm":"프로그램매뉴얼제작자","workSum":"사용자에게 편리한 프로그램 이용과 기업 자체 인력의 기술 개발 및 교육을 위한 기술보고서를 작성한다.","doWork":"사용자가 프로그램을 사용하는데 참조하도록 사용법에 관한 교육용 매뉴얼을 알기 쉽게 작성한다. 기업 자체인력의 기술 개발 및 교육을 위해 내부용 기술보고서를 작성한다. 개발 과정 전체에 대한 기술 백서를 작성한다. 매뉴얼상의 도표 및 글의 위치를 결정한다. 기타 작성한 매뉴얼에 대한 외국어 번역을 관리하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"테크니컬라이터(Technical Writer)","certLic":"정보처리기사, 전자계산기조직응용기사","dJobECd":"4111","dJobECdNm":"[4111]작가","dJobJCd":"2811","dJobJCdNm":"[2811]작가","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003588:1', '{"dJobCd":"K000003588","dJobCdSeq":"1","dJobNm":"화면해설방송작가","workSum":"시각장애인이 영상물을 이용할 수 있도록 영상물 내용 중에 소리 없이 화면으로만 진행되는 부분(배경, 행동, 표정, 자막, 그래픽 등)을 시각적으로 설명하는 대본을 작성한다.","doWork":"DVS(Descriptive Video Service:시각장애인을 위한 각종 영상물의 정보접근성 보장수단으로 소리 없이 화면으로만 진행되는 부분(배경, 행동, 표정, 자막, 그래픽 등)을 시각적으로 설명하여 시각장애인이 비시각장애인과 동등하게 영상물을 접할 수 있도록 지원하는 서비스)를 구현하기 위하여 화면해설에 적합한 영상물을 선정한다. 원 영상물을 먼저 감상한 후 시각적 요소들에 대한 분량이나 표현법을 구상한다. 원 영상물의 영상을 보지 않는 상태에서 대화와 사운드 효과만 시청한 후 원본 시나리오와 함께 다시 시청하여 시각장애인의 입장에서 화면해설이 필요한 부분을 파악한다. 원 영상물의 내용, 줄거리, 등장인물의 특징을 파악하고 인물들의 이름이나 관계 등을 이해한다. 등장인물의 표정, 몸짓, 배경, 기타 중요한 시각적 요소들을 원 영상물의 내용을 훼손하지 않는 범위 내에서 제시한다. 실제 영상으로 보이는 액션, 배경, 몸짓, 자막과 그래픽 같은 시각적 요소들을 구체화하여 대본을 작성한다. 원 영상물의 대상 연령층을 고려하여 적절한 용어를 선택한다. 전문용어나 난해한 그래픽에 대하여 부연설명을 한다. 대본 작성이 완료되면 오·탈자 등을 교정한다. 화면과 해설을 비교하여 분량(또는 길이)의 일치 정도를 점검한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"청각|손사용|언어력|시각|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"4111","dJobECdNm":"[4111]작가","dJobJCd":"2811","dJobJCdNm":"[2811]작가","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004148:1', '{"dJobCd":"K000004148","dJobCdSeq":"1","dJobNm":"만화에이전트","workSum":"만화가, 만화스토리작가, 만화시나리오작가 등과 에이전시 계약을 체결하여 저작권, 저작물 및 라이센싱에 관련된 제반 업무를 대리한다.","doWork":"창작자(만화가, 만화스토리작가, 만화시나리오작가 등)와 에이전시 계약을 체결한다. 만화, 스토리, 캐릭터 등의 각종 저작물에 대한 마케팅 전략을 수립하고 마케팅 활동을 전개한다. 광고, 출판 등 창작물 사용·이용자와 창작자 사이에서 온라인 광고대행, 광고 및 영화의 스토리 컨설팅, 기업 블로그 운영 및 콘텐츠 제작, 광고·홍보만화 제작, 디지털 콘텐츠 유통 등과 같은 다양한 비즈니스를 대행한다. 각종 사업이 원활히 진행되도록 조언하고 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"4113","dJobECdNm":"[4113]출판물 전문가","dJobJCd":"2812","dJobJCdNm":"[2812]출판물 전문가","dJobICd":"J581","dJobICdNm":"[J581]서적, 잡지 및 기타 인쇄물 출판업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001329:1', '{"dJobCd":"K000001329","dJobCdSeq":"1","dJobNm":"만화출판기획자","workSum":"시장을 조사하고 트렌드 등을 분석하여 만화출판을 기획하고 관리한다.","doWork":"만화작품 제작 및 유통환경에 대한 조사 및 정보를 수집하여 만화 발표 매체, 연재의 유무 등 다양하게 출판되는 만화시장에 대한 시장조사를 하고 수집된 정보를 분류해 트렌드를 분석한다. 만화시장의 요구, 창작방법, 매체전략(웹툰, 단행본, 연재물 등)을 고려하여 만화작품 기획서를 작성하고 제작 및 제작비 관련 인원과 협의한다. 만화캐릭터, 게임, 애니메이션 등 콘텐츠의 활용방안(마케팅)에 대한 전략을 수립한다. 만화작품 기획서가 완성되면 발표하고 제작비 조달, 제작진 섭외, 계약, 저작권 관련 업무를 진행한다. 만화제작이 진행되면 신문연재, 웹툰 연재, 단행본 발행 등의 방법으로 발표하는 제반 업무를 진행한다. 독자의 의견을 작가에게 전달하여 작품에 반영하도록 조언하여 상업적으로 성공하는데 기여한다. 해외 만화의 수입(출판), 국내 만화의 해외 수출(출판) 관련 업무를 직접 진행하거나 의뢰하기도 한다. 출판인세를 정산하고 지급한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"만화편집기자","dJobECd":"4113","dJobECdNm":"[4113]출판물 전문가","dJobJCd":"2812","dJobJCdNm":"[2812]출판물 전문가","dJobICd":"J581","dJobICdNm":"[J581]서적, 잡지 및 기타 인쇄물 출판업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004265:1', '{"dJobCd":"K000004265","dJobCdSeq":"1","dJobNm":"영문에디터","workSum":"영어로 작성된 문서나 논문, 계약서 등을 읽고 맞춤법, 문법 등 적절성을 검토하며, 필요시 수정한다.","doWork":"단어 오류를 검토하여 적절한 단어를 추천하고 문법적 오류를 수정한다. 오탈자 및 문장 부호 등을 교정한다. 문법과 문맥에 맞게 적절한 어휘를 선택하고 언어의 통일성을 고려하여 원고를 수정한다. 수정된 원고를 2차 이중 교정하여 오류를 확인한다. 필요시 의뢰인과 대면하여 내용을 각색하거나 표현이나 문장 구조, 글의 구성 등을 재배치한다. 영문 자료의 번역작업 또는 요약작업을 수행하기도 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"언어력|시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"영문교정전문가","connectJob":"일문에디터, 중문에디터","dJobECd":"4113","dJobECdNm":"[4113]출판물 전문가","dJobJCd":"2812","dJobJCdNm":"[2812]출판물 전문가","dJobICd":"J581","dJobICdNm":"[J581]서적, 잡지 및 기타 인쇄물 출판업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006949:1', '{"dJobCd":"K000006949","dJobCdSeq":"1","dJobNm":"웹소설기획자","workSum":"웹 소설 콘텐츠를 검토하고 IP를 관리하고 소비자의 특성 및 시장환경에 맞춰 웹소설 콘텐츠를 기획하며 글로벌서비스를 위해 로컬라이징을 한다.","doWork":"웹소설의 내용적 방향성을 기획한다. 특정 콘텐츠 장르에 특성화한 연재 플랫폼과 그 독자층을 집필 이전의 기획 단계부터 고려하며, 나아가 만화·웹툰, 영화, 드라마에 이르는 2차 저작물로 확장될 수 있는 스토리콘텐츠를 기획한다. 웹소설 창작 플랫폼에 업로드되는 원고를 파악하고 이들 가운데 상업성 있는 콘텐츠를 선별하고, 원천 IP를 발굴한다. 발굴된 웹소설 작가와 계약하고 담당PD와 매칭한다. 작가의 원고 집필상황 및 마감일정을 관리하고 원고의 수정 및 교정 작업과 표지 발주 등을 진행한다. 완성된 원고의 연재 플랫폼을 확정하고 홍보를 위한 판촉활동을 기획하고 조율한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"웹소설PD","connectJob":"웹소설편집자, 웹소설제작자","dJobECd":"4113","dJobECdNm":"[4113]출판물 전문가","dJobJCd":"2812","dJobJCdNm":"[2812]출판물 전문가","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002654:1', '{"dJobCd":"K000002654","dJobCdSeq":"1","dJobNm":"웹툰PD","workSum":"웹툰(Webtoon:인터넷을 매개로 배포하는 만화) 콘텐츠의 발굴, 제작, 유통, 관리, 홍보, 서비스 제공, 저작권 관리 등 작품 프로듀싱의 제반 과정을 기획·관리한다.","doWork":"웹툰 작품 및 작가, 만화콘텐츠 구매 유형, 독자층, 국내외 유행, 목표 시장, 신규 작품의 타당성, 온라인 유통구조 및 현황, 저작권 및 계약관계 등 웹툰 시장을 분석한다. 웹툰작가, 스토리작가 등 작가들을 섭외하여 작품을 제작하거나 공모전 등을 통해 제작되는 작품을 다양한 방법으로 확보하고 제작 또는 서비스할 작품을 선정한다. 그림작가, 스토리작가, 어시스턴트 등을 섭외하고 일정, 예산, 계약 등을 조정하여 제작을 진행한다. 작품을 연재할 준비가 되기 전 서비스할 플랫폼을 선정한다. 홍보용 콘텐츠 편집, 독자 관리, 웹 환경과 기술을 고려한 서비스의 개선, 이벤트 등 다양한 웹툰 서비스 업무를 기획·진행한다. 작품에 대한 독자의 호응도 등 시장의 반응을 작가에 전달하고 의견을 제시하여 연재에 반영하기도 한다. 작가와 매니지먼트 계약을 체결하고 영상, 공연, 캐릭터 상품 등 다른 콘텐츠로 확장될 수 있도록 콘텐츠의 재사용에 대한 사항을 관리하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"웹툰기획자","dJobECd":"4113","dJobECdNm":"[4113]출판물 전문가","dJobJCd":"2812","dJobJCdNm":"[2812]출판물 전문가","dJobICd":"J581","dJobICdNm":"[J581]서적, 잡지 및 기타 인쇄물 출판업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;