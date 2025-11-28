INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006923:1', '{"dJobCd":"K000006923","dJobCdSeq":"1","dJobNm":"긴급출동요원","workSum":"담당 구역을 순찰하고 침입 여부를 확인하는 등 고객의 보안서비스를 점검한다.","doWork":"담당 구역 내 고객의 위치와 보안서비스 내용 등을 파악한다. 고객을 방문하여 고객의 보안요구 사항을 청취하여 현장에서 조치를 취하거나 회사에 전달한다. 순찰활동을 실시하며, 침입, 화재, 비상통보, 가스누출, 보안기기의 고장 등이 발생할 경우 무인경비관제원의 지시를 받고 출동한다. 이상의 내용을 판단하여 정상화하고 사고확대방지, 재발방지, 원상복구 등의 조치를 하여 보고한다. 도난, 화재 등으로 인한 피해를 미연에 방지하기 위하여 건물의 내외부를 순찰하여 안전을 확인한다. 업무시간 후에 발생하는 외부인의 침입, 내부의 재해원인을 신속히 발견하며 잔류자의 확인, 최종 퇴실자의 점검미비사항, 불완전한 설비 등의 문제점에 관한 대처보고서를 작성한다. 긴급출동 차량을 운행하고 무선으로 보안기지국과 통신한다. 설치된 보안감지기기의 작동 및 운영요령에 대해서 사용자에게 취급설명을 한다. 범죄발생 시 출동한 경찰의 범인검거를 돕기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실외","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"단순작업","similarNm":"긴급대처요원, 무인기계경비출동대원, 무인경비순찰대원, 보안CS(Customer Service)요원, 무인기계경비원","certLic":"기계경비지도사","dJobECd":"5413","dJobECdNm":"[5413]시설·특수 경비원","dJobJCd":"4123","dJobJCdNm":"[4123]시설 및 특수 경비원","dJobICd":"N753","dJobICdNm":"[N753]경비, 경호 및 탐정업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002704:1', '{"dJobCd":"K000002704","dJobCdSeq":"1","dJobNm":"무인기계경비원","workSum":"고객의 매장이나 집, 공장 등에 설치된 자산 센서, 제어 장치 등을 유지·관리하기 위해 순찰하고, 센서에 외부침입자가 감지되면 출동하여 점검한다.","doWork":"고객의 매장이나 집, 공장 등의 자산 센서 및 제어 장치 등을 유지·관리한다. 설치기기에 대한 특징과 사용법을 고객에게 설명한다. 현장을 정기적으로 순찰하고, 보안장치를 점검하여 이상 유무를 기록한다. 센서에 외부침입자가 감지되어 회사의 관제실로 보고되면, 관제실의 지령을 받아 출동하여 보안상황을 점검한다. 도난사실 여부에 따라 고객에게 통보하거나 상황에 따라 경찰지원을 요청한다. 사용 장비 및 기기를 점검하고, 출동차량을 정리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실외","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"단순작업","similarNm":"무인경비원","certLic":"기계경비지도사","dJobECd":"5413","dJobECdNm":"[5413]시설·특수 경비원","dJobJCd":"4123","dJobJCdNm":"[4123]시설 및 특수 경비원","dJobICd":"N753","dJobICdNm":"[N753]경비, 경호 및 탐정업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007043:1', '{"dJobCd":"K000007043","dJobCdSeq":"1","dJobNm":"CCTV통합관제요원","workSum":"CCTV 통합관제센터 등 스마트시티통합관제센터에서 CCTV 등 모니터링 장비를 실시간으로 감시하고 경찰관, 소방관, 보호감찰관 등 유관 기관과 업무 협조를 통해 각종 사건 사고의 예방과 지원 및 사후 조치를 한다.","doWork":"방범용 CCTV 등 모니터링 장비를 24시간 실시간 감시한다. 범죄, 안전, 환경오염, 재난·재해, 어린이 보호(스쿨존) 등 각종 사건발생이 의심될 경우 조치사항을 파악하여 보고한다. 내·외부 위협사항을 모니터링 및 분석한다. 비상벨 호출 시 대응하고 경찰관, 소방관 출동을 요청한다. 사고예방을 위한 계도 방송(청소년 음주, 흡연 등)을 요청한다. CCTV 등 시설물 고장 및 오작동 여부 확인하고 통보한다. 유관기관 등에서 추적자 동선파악 등의 요청이 올 경우 관련된 전반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"청각|시각|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"스마트통합관제사","connectJob":"스마트시티통합관제요원, 위치추적관제요원, CCTV관제요원","dJobECd":"5419","dJobECdNm":"[5419]기타 경호·보안 종사원","dJobJCd":"4129","dJobJCdNm":"[4129]기타 경호 및 보안 관련 종사원","dJobICd":"N753","dJobICdNm":"[N753]경비, 경호 및 탐정업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006588:1', '{"dJobCd":"K000006588","dJobCdSeq":"1","dJobNm":"가스관로순찰원","workSum":"가스누출, 가스관 파괴 등의 사고를 방지하고 예방하기 위하여 가스 배관망을 순찰·점검한다.","doWork":"가스 배관망의 위치와 경로를 파악한다. 도보 또는 차량을 이용하여 관로를 순찰하며 가스누설 및 배관의 이상 유무를 감시하고 점검한다. 관로의 이상이나 관로 주변의 위험요인들에 대한 사항을 관로관리원에게 보고한다. 각종 공사로부터 관로를 보호하기 위한 장비를 설치한다. 관로를 순찰하며 발견된 주요사항 및 조치내용을 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"단순작업","dJobECd":"5419","dJobECdNm":"[5419]기타 경호·보안 종사원","dJobJCd":"4129","dJobJCdNm":"[4129]기타 경호 및 보안 관련 종사원","dJobICd":"D352","dJobICdNm":"[D352]연료용 가스 제조 및 배관공급업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004952:1', '{"dJobCd":"K000004952","dJobCdSeq":"1","dJobNm":"경비보안시스템기술자","workSum":"경비보안시스템의 배치설계와 시스템을 설치하며 운영 및 유지보수 관리를 한다.","doWork":"보안이 필요한 시설물을 특징과 보안취약지점을 고려하여 각종 감지센서와 영상보안, 출입보안, 검색장비 등의 보안기기의 배치설계를 한다. 보안시스템의 구성도에 따라 보안기기설치 공사 시 설치상태를 관리하며 정상작동 여부를 확인한다. 보안기기의 운영사항을 고객에게 교육하며 주의사항을 설명한다. 설치된 보안시스템을 점검하여 고장을 예방하며 이상이 발생했을 때 보안기기를 점검하고 이상이 있을 경우 수리·교체 등을 통해 현장에서 조치한다. 보안기기제조업체의 기술자와 함께 시스템을 점검하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"기계경비지도사","dJobECd":"5419","dJobECdNm":"[5419]기타 경호·보안 종사원","dJobJCd":"4129","dJobJCdNm":"[4129]기타 경호 및 보안 관련 종사원","dJobICd":"N753","dJobICdNm":"[N753]경비, 경호 및 탐정업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003596:1', '{"dJobCd":"K000003596","dJobCdSeq":"1","dJobNm":"공항보안검색원","workSum":"비행 중의 사고를 방지하기 위해 출국하는 여행객의 가방 및 소지품을 검색한다.","doWork":"공항의 출국장에서 소지하고 있는 가방이나 물품을 검색대에 올려놓도록 여행객에게 요청한다. 엑스레이(X-ray)를 이용한 검색 장비를 조작하여 검색대에 통과되는 물건을 모니터를 통해 확인한다. 여행객에게 검색대를 통과하도록 요청하고, 금속탐지기를 이용하여 여행객의 신체를 검색한다. 공항 내 보안구역에 방문하는 외부인의 신원 및 출입 이유를 파악하고 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","connectJob":"항만보안검색원","dJobECd":"5419","dJobECdNm":"[5419]기타 경호·보안 종사원","dJobJCd":"4129","dJobJCdNm":"[4129]기타 경호 및 보안 관련 종사원","dJobICd":"H511","dJobICdNm":"[H511]항공 여객 운송업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005792:1', '{"dJobCd":"K000005792","dJobCdSeq":"1","dJobNm":"무인경비관제원","workSum":"무인경비 관제실(상황실)에서 고객의 보안상태를 감시하며, 방범기기의 이상 신호를 분석하여 긴급출동요원에게 조치를 지시하는 등 보안사고를 관리한다.","doWork":"문제가 발생한 계약처를 확인·관리한다. 긴급출동요원의 순찰 및 근무상태를 점검·관리하고 근무자를 조정하며 근무상황을 보고 받아 요원 체크리스트(Checklist)를 작성한다. 침입, 차량 및 일반사고에 관하여 종합적인 보고를 받고 분석하여 대책을 수립한다. 대처요원의 운용계획을 수립하고 근무 교대 시간을 조정·검토한다. 고객의 정보사항 및 특수요건에 관한 상황자료를 컴퓨터에 입력·관리한다. 비상연락망 및 계약처의 도면을 준비·관리한다. 긴급 대처를 위한 약도·지름길 등을 고객의 카드철에 기록한다. 보안 상황판을 관찰하여 오류 지역을 집중 관리한다. 고객의 요청이 있거나 무인경비 시스템의 경보신호가 발생 시 긴급출동요원을 출동시킨다. 경보상황을 분석하여 경찰서나 소방서 등 유관기관에 출동을 요청하기도 한다. 사고 발생을 접수·분석하고 사고 상황 및 출동 상황이 포함된 처리 결과 보고서를 작성한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"단순작업","similarNm":"무인경비상황실요원, 기계경비관제원","certLic":"기계경비지도사","dJobECd":"5419","dJobECdNm":"[5419]기타 경호·보안 종사원","dJobJCd":"4129","dJobJCdNm":"[4129]기타 경호 및 보안 관련 종사원","dJobICd":"N753","dJobICdNm":"[N753]경비, 경호 및 탐정업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002255:1', '{"dJobCd":"K000002255","dJobCdSeq":"1","dJobNm":"민간조사원","workSum":"일상생활에서 일어나는 여러 가지 민형사상의 사건사고 중에서 공권력이 미치지 않는 부분에 대해 법률이 허용하는 범위에서 조사한다.","doWork":"의뢰인과 조사의뢰에 대해 협의하고 계약을 체결한다. 요청 조사에 대해 각종 자료를 수집하여 분석한다. 각종 위법행위사고의 피해 확인, 원인책임 조사, 행방불명자분실자산의 소재 파악, 소송증거 수집, 기업리스크 조사 등을 수행한다. 변호사가 수임한 사건의 경우 해당 변호사로부터 의뢰받은 사건의 자료를 수집한다. 업무 수행 후 최종 보고서 등 관련 서류를 작성한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"시각|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"공인탐정, 민간조사사, 생활정보지원탐생사, 사설정보관리사","dJobECd":"5419","dJobECdNm":"[5419]기타 경호·보안 종사원","dJobJCd":"4129","dJobJCdNm":"[4129]기타 경호 및 보안 관련 종사원","dJobICd":"N753","dJobICdNm":"[N753]경비, 경호 및 탐정업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003213:1', '{"dJobCd":"K000003213","dJobCdSeq":"1","dJobNm":"보안순찰원","workSum":"회사의 재산과 인원을 화재·도난·파손 및 불법침입 등으로부터 보호하기 위하여 제반 경계업무를 수행한다.","doWork":"건물이나 산업체의 작업현장 등을 정기적으로 순찰하고 출입구·창문 및 보안장치를 점검·확인하여 이상 유무를 기록한다. 출입금지구역 및 금연구역, 휴대금지물품 등을 통제하고 규칙 위반자를 경고·추방한다. 장비·기계, 방화설비·소화기구, 화재위험성물질·방호시설 등을 점검하고 기록한다. 퇴청자들을 살펴 회사 재산의 도난을 막는다. 화재발생, 무단출입 등 긴급사태 발생 시 경보를 울리고 구급환자를 보호하며 경찰 및 소방서에 연락하고 인접 경비 기구와 협조하여 현행범을 체포한다. 상황실에 지시를 받아 이상 지역을 점거하며, 경비견을 데리고 순찰하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"단순작업","connectJob":"상주안전요원, 안전순찰요원, 학교보안관, 지하철안전보안관","dJobECd":"5419","dJobECdNm":"[5419]기타 경호·보안 종사원","dJobJCd":"4129","dJobJCdNm":"[4129]기타 경호 및 보안 관련 종사원","dJobICd":"N753","dJobICdNm":"[N753]경비, 경호 및 탐정업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005524:1', '{"dJobCd":"K000005524","dJobCdSeq":"1","dJobNm":"인명구조원","workSum":"수영장, 해수욕장, 스키장, 경기장 등에서 안전사고를 방지하기 위하여 관련 장소를 순찰하고 사고발생 시 구조 및 응급조치를 한다.","doWork":"장내를 순찰하거나 관망대에서 안전사고 여부를 관찰한다. 안전에 위배되는 사항을 적발하여 경고하거나 제재를 가한다. 안전사고가 발생하면 구조 후 응급조치 심폐소생술(CPR) 또는 구급약품 등을 사용하여 응급조치를 한다. 운반 장비를 사용하여 부상자를 구급실로 운반한다. 의사나 간호사에게 사고 당시의 상황과 응급조치 내용을 설명한다. 시설물의 안전상태를 점검하고 미비점을 관리부서나 시설부서에 통보하여 보수하도록 의뢰한다. 고객을 안내하고 주변의 비품을 정리·관리하기도 한다. 안전교육 프로그램을 개발하고 운영하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"시각|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"라이프가드(Life Guard), 수상안전요원, 수상구조사","connectJob":"수학여행안전요원","certLic":"수상구조사","dJobECd":"5419","dJobECdNm":"[5419]기타 경호·보안 종사원","dJobJCd":"4129","dJobJCdNm":"[4129]기타 경호 및 보안 관련 종사원","dJobICd":"R911/R912","dJobICdNm":"[R911]스포츠 서비스업 / [R912]유원지 및 기타 오락관련 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005034:1', '{"dJobCd":"K000005034","dJobCdSeq":"1","dJobNm":"자동보관함관리인","workSum":"자동보관함의 이용 사항을 점검하고 관리·운영한다.","doWork":"자동보관함의 보호 및 관리 업무를 수행한다. 매일 자동보관함의 파손 여부와 동작 여부를 파악하고 고장 내역을 보고한 후 조치한다. 주인 없이 장기간 보관된 물품은 따로 정리하여 보관 후 주인이 나타나지 않을 시 임의로 처리한다. 자동보관함이 설치되어 있는 역이나 건물 관리인이 보관료를 수금할 때 입회하여 금액을 확인한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"시범후 30일 이하","workStrong":"가벼운 작업","workPlace":"실외","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","similarNm":"무인보관함관리원","dJobECd":"5419","dJobECdNm":"[5419]기타 경호·보안 종사원","dJobJCd":"4129","dJobJCdNm":"[4129]기타 경호 및 보안 관련 종사원","dJobICd":"S969","dJobICdNm":"[S969]그 외 기타 개인 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005786:1', '{"dJobCd":"K000005786","dJobCdSeq":"1","dJobNm":"카지노감시운영원","workSum":"카지노 보안실(모니터룸)에서 감시카메라를 통해 영업장을 감시한다.","doWork":"게임테이블, 케이지, 카운터룸 등 카지노 영업장 내에 설치되어 있는 감시카메라(CCTV:폐쇄 회로 텔레비전)로 각 영업장을 녹화한다. 감시카메라를 통해 고객을 감시하고 카지노종사원의 업무 및 회사의 자산을 감시하여 위반사항을 관찰, 기록 및 보고한다. 녹화장비를 점검하고 녹화물을 정리·관리한다. 필요시 증거물로 녹화물을 제공한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"서베일런스","dJobECd":"5419","dJobECdNm":"[5419]기타 경호·보안 종사원","dJobJCd":"4129","dJobJCdNm":"[4129]기타 경호 및 보안 관련 종사원","dJobICd":"R912","dJobICdNm":"[R912]유원지 및 기타 오락관련 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005262:1', '{"dJobCd":"K000005262","dJobCdSeq":"1","dJobNm":"카지노안전관리원","workSum":"카지노 영업장의 원활한 운영을 위해 고객의 출입을 통제하며, 고객 및 카지노종사자의 안전을 보호한다.","doWork":"카지노에 입장하는 고객들을 통제하고 물품을 점검하여 금지목록을 접수·보관한다. 고객의 신원을 확인하고 입장금지 고객의 출입을 통제한다. 영업장 내외를 순찰하며 고객 및 카지노종사자의 안전을 보호하고 감시한다. 영업장 내의 질서를 유지한다. 영업행위를 방해하거나 방해할 우려가 있는 사람을 강제 퇴장시킨다. 영업장의 고액 칩을 운반하거나 현금이동 시 경호업무를 수행하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"시범후 30일 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"카지노섭외담당원","dJobECd":"5419","dJobECdNm":"[5419]기타 경호·보안 종사원","dJobJCd":"4129","dJobJCdNm":"[4129]기타 경호 및 보안 관련 종사원","dJobICd":"R912","dJobICdNm":"[R912]유원지 및 기타 오락관련 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007395:1', '{"dJobCd":"K000007395","dJobCdSeq":"1","dJobNm":"간병인","workSum":"병원 및 가정 등에서 요양이 필요하거나 거동이 불편한 환자의 활동을 보살피고 돕는다.","doWork":"거동이 불편한 환자나 노인, 장애인을 대상으로 목욕하기, 옷 입히기, 식사 돕기, 약물 투여 돕기, 배설 활동 보조하기 등의 서비스를 수행한다. 환자의 체위를 변경시키고 운동을 보조한다. 간병대상인의 주거환경을 청소하고 병실청소 및 침대시트 교체, 습도조절 등 주변 위생을 관리한다. 환자의 상태를 관찰하고 이상 시 보고한다. 간단한 재활훈련(산책, 병원동행, 보행훈련 등)을 수행한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"단순작업","connectJob":"노인도우미, 환자도우미, 장애인도우미","dJobECd":"5501","dJobECdNm":"[5501]요양 보호사 및 간병인","dJobJCd":"4211","dJobJCdNm":"[4211]돌봄 서비스 종사원","dJobICd":"S969","dJobICdNm":"[S969]그 외 기타 개인 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005616:1', '{"dJobCd":"K000005616","dJobCdSeq":"1","dJobNm":"요양보호사","workSum":"노인의료복지시설(노인요양시설, 노인요양공동생활가정)이나 재가노인복지시설(방문요양서비스, 주야간보호서비스, 단기보호서비스, 방문목요서비스 제공시설)에서 의사 또는 간호사의 지시에 따라 장기요양급여 수급자 등에게 신체적, 정신적, 심리적, 정서적 및 사회적 보살핌을 제공한다.","doWork":"의사, 간호사 및 가족들로부터 요양보호대상자에 대한 정보를 수집하여 요양보호서비스 계획을 세운다. 요양보호대상자에게 신체활동을 지원하는 서비스를 제공한다(세면도움, 구강관리, 머리감기기, 몸단장, 옷갈아입히기, 목욕도움, 식사도움, 체위변경, 이동도움. 신체적 기능유지 및 증진, 화장실 이용돕기 등). 청소 및 주변정돈, 세탁 등 일상생활을 지원하는 서비스를 제공한다. 외출 시 동행하거나 일상업무를 대행하는 개인활동 지원서비스를 한다. 말벗을 비롯하여 생활상담을 제공하고 의사소통에 도움을 주는 등 정서적 지원서비스를 한다. 가정 등에 방문하여 목욕서비스를 제공한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"단순작업","similarNm":"노인요양보호사, 재가요양보호사","certLic":"요양보호사","dJobECd":"5501","dJobECdNm":"[5501]요양 보호사 및 간병인","dJobJCd":"4211","dJobJCdNm":"[4211]돌봄 서비스 종사원","dJobICd":"Q871/Q872","dJobICdNm":"[Q871]거주 복지시설 운영업 / [Q872]비거주 복지시설 운영업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004526:1', '{"dJobCd":"K000004526","dJobCdSeq":"1","dJobNm":"놀이시터","workSum":"바쁜 부모를 대신해 10세 이하 아이를 대상으로 가정을 방문하여 책을 읽어주거나 색종이 접기 등 함께 놀이를 한다.","doWork":"부모와의 상담을 통해 부모와 아이가 원하는 활동, 원치 않는 활동, 주의해야 할 사항 등을 파악한다. 부모를 대신해서 아이가 원하는 책을 읽어주거나 블록놀이, 색칠놀이, 색종이 접기 등 상황에 맞춰 다양한 활동을 한다. 부모가 돌아오면 아이의 일과와 특이사항을 보고하고 부모에게 아이를 인계한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"시범후 30일 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","similarNm":"놀이선생님, 놀이쌤, 플레이튜터","dJobECd":"2153","dJobECdNm":"[2153]교사보조 및 보육보조 서비스 종사원","dJobJCd":"4212","dJobJCdNm":"[4212]보육 및 교사 보조 서비스 종사원","dJobICd":"S969","dJobICdNm":"[S969]그 외 기타 개인 서비스업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004628:1', '{"dJobCd":"K000004628","dJobCdSeq":"1","dJobNm":"보육교사보조원","workSum":"공공 및 사설 아동수용시설에 기거하는 아이들을 보살핀다.","doWork":"위탁된 영유아를 연령이나 발달단계에 따라 영아반 및 유아반에 배치한다. 일일, 월간, 그리고 연간 세부 보육 및 교육계획을 세운다. 유아의 정서 및 지능발달을 위하여 그림책, 장난감, 악기, 미끄럼틀, 그네 등의 놀이기구를 준비하고 자유놀이와 집단유희를 지도한다. 일정한 시간에 영유아에게 우유나 음식을 먹인다. 취침, 목욕, 용변 등을 보살피고 생활습관을 가르친다. 수면 및 휴식시간을 조절하고 영유아들의 건강을 살핀다. 관찰 및 지도의 경과에 대해 보육일지에 기록한다. 유아들의 현장학습을 준비하고 인솔한다. 비품을 관리하고 정리·정돈한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"교육","workFunc3":"단순작업","similarNm":"보육교사보조교사, 보조보육교사","dJobECd":"2153","dJobECdNm":"[2153]교사보조 및 보육보조 서비스 종사원","dJobJCd":"4212","dJobJCdNm":"[4212]보육 및 교사 보조 서비스 종사원","dJobICd":"Q872","dJobICdNm":"[Q872]비거주 복지시설 운영업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003483:1', '{"dJobCd":"K000003483","dJobCdSeq":"1","dJobNm":"모낭분리사","workSum":"모발 이식수술에서 시술자의 모발을 분리하고 식모기에 모근을 씌우는 등 모발이식 수술을 지원한다.","doWork":"의사가 절개하여 채취한 시술자의 모발에서 모낭을 육안, 입체현미경 등을 통해 칼로 분리한다. 고무장갑을 끼고 분리된 모낭(모근)을 핀셋으로 집어 모근기(모근을 심는 기계)에 씌워 의사에게 전달한다. 기타 모발이식 수술과 관련된 지원 업무를 수행한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"모낭관리사","connectJob":"간호조무사","dJobECd":"3079","dJobECdNm":"[3079]기타 보건·의료 종사원","dJobJCd":"4219","dJobJCdNm":"[4219]기타 돌봄 및 보건 서비스 종사원","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005340:1', '{"dJobCd":"K000005340","dJobCdSeq":"1","dJobNm":"병원보조원","workSum":"의사, 간호사, 약사, 수의사 등의 효율적인 업무 수행을 지원하기 위해 물품정리, 주변정리, 치료기구나 장비 소독 등의 업무를 수행한다.","doWork":"간호에 사용할 물품을 확인하여 보충한다. 청소 등 적절한 간호환경 유지를 위해 주변을 정리한다. 치료에 사용된 기구나 장비 등을 소독하고 정리한다. 환자의 옷을 갈아입히거나 환자가 활동할 수 있도록 돕는다. 검체(시험, 검사, 분석 따위에 쓰는 물질이나 생물)를 배달하거나 의무기록카드를 전달한다. 치료를 위해 동물을 목욕시키고, 솔질하며, 털이나 발톱을 다듬는다. 동물의 상처에 붕대를 갈아주고 처방된 약을 발라준다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"시범후 30일 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"단순작업","dJobECd":"3079","dJobECdNm":"[3079]기타 보건·의료 종사원","dJobJCd":"4219","dJobJCdNm":"[4219]기타 돌봄 및 보건 서비스 종사원","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006642:1', '{"dJobCd":"K000006642","dJobCdSeq":"1","dJobNm":"산후관리사","workSum":"출산 후 산모의 가정에서 식사, 빨래, 청소 등 생활활동을 지원하고 산모를 간호하며 신생아를 돌본다.","doWork":"방문 가정의 환경이나 산모나 신생아의 건강상태를 파악한다. 산모의 식사나 간식을 만들어 제공한다. 빨래, 청소 등 가정생활을 지원한다. 산모의 좌훈, 좌욕 등을 지원한다. 신생아의 분유를 만들어 먹이거나 산모의 모유수유를 지원한다. 가슴, 복부, 손, 발 등 산모의 신체를 마사지한다. 신생아를 목욕시키거나 낮잠 등 신생아의 수면활동을 지원한다. 예방접종 등 신생아의 건강 등에 관한 정보를 제공한다. 신생아를 목욕시키거나 젖병 등 관련 기구 등을 소독, 세척한다. 산모나 신생아의 건강에 이상이 생길 경우 가족 관계자나 의료기관에 알린다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"약간의 시범정도","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"단순작업","similarNm":"산모관리사, 산모도우미","dJobECd":"3079","dJobECdNm":"[3079]기타 보건·의료 종사원","dJobJCd":"4219","dJobJCdNm":"[4219]기타 돌봄 및 보건 서비스 종사원","dJobICd":"S969","dJobICdNm":"[S969]그 외 기타 개인 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003310:1', '{"dJobCd":"K000003310","dJobCdSeq":"1","dJobNm":"정신질환치료보조원","workSum":"의사와 간호사의 지시에 따라 정신 질환자를 보살핀다.","doWork":"스스로 이동하기 어려운 환자들을 샤워장으로 데리고 가서 목욕시키고, 옷을 갈아입히며, 몸단장을 도와준다. 환자에게 검사 또는 치료일정을 알리고 진료 시 동행한다. 처방된 약의 복용을 돕는다. 환자가 병원생활에 익숙해지도록 돕고, 치료활동을 위한 운동, 연극, 친목 및 레크리에이션, 생활요법, 직업요법, 회화요법 활동에 참가하도록 유도한다. 환자에게 음식을 먹여주거나 스스로 먹을 수 있도록 도움을 주며 음식을 거절할 경우 원인을 조사하여 기록한다. 환자를 관찰하여 이상한 행동이나 자해행위를 하는 경우 이를 저지하거나 진정시킨다. 병실, 병실가구, 벽, 바닥 등을 청소하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"단순작업","similarNm":"정신병환자보호사, 병동보호사, 환자관리보호사","dJobECd":"3079","dJobECdNm":"[3079]기타 보건·의료 종사원","dJobJCd":"4219","dJobJCdNm":"[4219]기타 돌봄 및 보건 서비스 종사원","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005206:1', '{"dJobCd":"K000005206","dJobCdSeq":"1","dJobNm":"환자이송원","workSum":"병원에서 간호사의 감독하에 대차, 휠체어 등을 이용하여 환자를 수술실, 진료실, 검사실에 이송한다.","doWork":"이동시킬 환자의 병실, 성명, 운반장소 등을 확인한다. 의사 또는 간호사의 지시를 준수하면서 병실에서 환자를 대차에 싣거나 휠체어를 밀어서 검사실, 수술실, 진료실 등으로 이송한다. 검사, 수술, 진료가 완료되면 다시 환자를 병실로 안전하게 이송한다. 기타 간호사나 의사가 지시하는 업무를 수행한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"시범후 30일 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|손사용|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","similarNm":"오더리(Ordree)","dJobECd":"3079","dJobECdNm":"[3079]기타 보건·의료 종사원","dJobJCd":"4219","dJobJCdNm":"[4219]기타 돌봄 및 보건 서비스 종사원","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007569:1', '{"dJobCd":"K000007569","dJobCdSeq":"1","dJobNm":"이용사","workSum":"주로 남성 고객의 머리카락을 자르고 면도 등의 이용 서비스를 제공한다.","doWork":"고객의 얼굴 형태나 머리 형태에 따라 적합한 머리모양을 권하고 고객의 요구사항을 반영하여 머리모양을 결정한다. 가위, 빗 등의 이용기구를 사용하여 고객의 머리카락을 자르고 다듬어 원하는 머리형태로 만든다. 샴푸, 린스 등을 사용하여 고객의 머리를 감기고 드라이어를 사용하여 물기를 제거한다. 모발 제품을 사용하여 머리 형태를 고정한다. 염색약품을 배합하여 고객의 머리카락을 염색하고 기계파마(아이론파마)도구를 이용해 파마를 한다. 면도칼과 비누거품을 사용하여 면도를 하고 로션을 바른다. 고객의 요청에 따라 염색을 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"정밀작업","similarNm":"이발사","certLic":"이용기능사, 이용장","dJobECd":"5111","dJobECdNm":"[5111]이용사","dJobJCd":"4221","dJobJCdNm":"[4221]이용사","dJobICd":"S961","dJobICdNm":"[S961]미용, 욕탕 및 유사 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001396:1', '{"dJobCd":"K000001396","dJobCdSeq":"1","dJobNm":"미용보조원","workSum":"고객에게 적합한 머리 스타일을 연출하고, 기타 고객의 머리 손질에 관련된 서비스를 제공하는 미용사의 일을 보조한다.","doWork":"각종 미용기구 및 용품을 준비하고 고객이 사용 시 지원한다. 고객의 머리를 감기고 두피를 주무르거나 두드려 혈액순환을 돕고, 모발 드라이 등의 서비스를 제공한다. 미용실의 미용기구 및 용품을 정리·정돈한다. 수건, 가운 등을 세탁하고 청결하게 관리한다. 매니큐어, 피부관리, 화장, 머리장식 등 미용에 관련된 기타 다양한 서비스를 보조한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"관련없음","dJobECd":"5112","dJobECdNm":"[5112]미용사","dJobJCd":"4222","dJobJCdNm":"[4222]미용사","dJobICd":"S961","dJobICdNm":"[S961]미용, 욕탕 및 유사 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007481:1', '{"dJobCd":"K000007481","dJobCdSeq":"1","dJobNm":"미용사","workSum":"주로 여성 고객에게 미용기구를 사용하여 고객의 머리카락을 자르고 염색, 파마 등 모발미용에 관한 서비스를 제공한다.","doWork":"고객의 머리모양 등 신체적인 특성을 관찰하여 고객에게 어울리는 헤어스타일의 형태를 권하고, 고객의 요구에 따라 헤어스타일 형태를 결정한다. 가위, 빗 등의 미용기구를 사용하여 고객의 머리카락을 자르고 다듬어서 원하는 형태로 만든다. 배합한 파마약품를 머리카락에 적신 후 파마도구를 이용하여 머리카락을 말아준다. 파마 촉진을 위해 헤어드라이캡, 건조기 등을 작동시킨다. 염색약품을 배합하여 머리카락을 염색하고, 샴푸와 린스를 사용하여 머리를 감겨준다. 트리트먼트와 영양액을 사용하여 모발클리닉을 한다. 드라이어, 모발 장비를 사용하여 머리를 말리고, 빗, 머리핀과 모발제품을 사용하여 원하는 형태로 고정한다. 유행 스타일을 조사하고, 잡지 등을 스크랩하여 고객의 머리모양 선택에 도움을 준다. 시술 후 미용기구를 정리·정돈한다. 고객을 관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"수집","workFunc2":"서비스제공","workFunc3":"정밀작업","similarNm":"헤어디자이너, 헤어아티스트","certLic":"미용사(일반), 미용장","dJobECd":"5112","dJobECdNm":"[5112]미용사","dJobJCd":"4222","dJobJCdNm":"[4222]미용사","dJobICd":"S961","dJobICdNm":"[S961]미용, 욕탕 및 유사 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002984:1', '{"dJobCd":"K000002984","dJobCdSeq":"1","dJobNm":"다이어트프로그래머","workSum":"고객의 체중감소와 건강증진을 목적으로 영양학, 비만학, 운동학 등의 지식을 토대로 고객의 체형과 체질을 진단하여 프로그램을 개발하고 관리한다.","doWork":"고객의 체중, 체지방, 신장, 기타 균형상태를 기계로 측정한다. 고객의 식습관, 운동량, 주변 환경 등을 점검표를 이용하여 검토한다. 고객의 건강상태와 식습관 등 관련 조건을 고려하여 고객에게 적합한 다이어트프로그램을 설계한다. 다이어트 기간, 적합한 운동, 운동방법, 섭취 음식과 금지 음식 등을 고객에게 설명한다. 다이어트 점검표를 사용하여 계획대로 진행하는지 점검한다. 체중, 체지방 등을 기계로 측정하여 고객에게 변화 여부를 알려준다. 운동기구, 다이어트 장비 등을 사용하여 고객에게 다이어트 서비스를 제공하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"다이어트컨설턴트, 다이어트플래너, 체형관리사","connectJob":"다이어트테크니션, 다이어트세라피스트","dJobECd":"5113","dJobECdNm":"[5113]피부 및 체형 관리사","dJobJCd":"4223","dJobJCdNm":"[4223]피부 및 체형 관리사","dJobICd":"S961","dJobICdNm":"[S961]미용, 욕탕 및 유사 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005955:1', '{"dJobCd":"K000005955","dJobCdSeq":"1","dJobNm":"두피모발관리사","workSum":"고객의 두피질환 및 모발손상에 대해 상담하여 상태가 개선될 수 있도록 계획을 수립하고 관리한다.","doWork":"두피측정기를 이용하여 고객의 모발이나 두피상태를 측정하여 결과에 대하여 고객에게 설명한다. 고객의 식습관, 건강상태, 유전 등 상담을 통해 고객의 정보를 습득하고 문제의 원인을 판단한다. 적합한 관리프로그램을 수립하고 스케일링, 영양제 등을 이용하여 두피 및 모발을 관리한다. 상태개선을 위한 제품을 소개하고 관리방법을 상담한다. 두피모발 제품을 개발하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"트리콜로지스트","dJobECd":"5113","dJobECdNm":"[5113]피부 및 체형 관리사","dJobJCd":"4223","dJobJCdNm":"[4223]피부 및 체형 관리사","dJobICd":"S961","dJobICdNm":"[S961]미용, 욕탕 및 유사 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003382:1', '{"dJobCd":"K000003382","dJobCdSeq":"1","dJobNm":"목욕관리사","workSum":"목욕탕에서 고객의 때를 밀어주는 등 청결 서비스를 제공한다.","doWork":"작업에 필요한 물, 수건, 비누 등을 준비한다. 고객의 요청에 따라 때를 민다. 혈액순환을 촉진하고 피로를 풀어주기 위하여 고객의 몸을 손으로 주무르거나 문지르는 등의 서비스를 제공하기도 한다. 목욕탕 내를 정리하거나 음료값을 계산하는 등 기타 서비스를 제공하기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"고온|다습|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"때밀이, 세신사","dJobECd":"5113","dJobECdNm":"[5113]피부 및 체형 관리사","dJobJCd":"4223","dJobJCdNm":"[4223]피부 및 체형 관리사","dJobICd":"S961","dJobICdNm":"[S961]미용, 욕탕 및 유사 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005887:1', '{"dJobCd":"K000005887","dJobCdSeq":"1","dJobNm":"손톱미용사","workSum":"고객의 손·손톱·발·발톱의 미용관리 및 제모(체모 제거)에 관한 미용 서비스를 제공한다.","doWork":"고객과 상담을 통해 건강상태 및 미용관리 부위의 정보를 파악하고, 구체적인 관리방법을 결정한다. 각종 장비 및 물품을 준비하고, 고객의 시술부위를 알코올 등으로 소독한다. 손톱, 발톱 등 시술부위의 매니큐어·광택제 등을 제거한다. 시술절차에 따라 각종 물품 및 도구를 선택하여 고객의 피부 및 각질에 손상이 가지 않도록 주의하여 시술한다. 시술이 끝나면 손, 발 등에 크림을 바른 후 손으로 주무르거나 두드려 혈액순환 및 미용을 돕는다. 도구 및 장비를 청소·소독하고, 정리·정돈한다. 고객의 예약관리 및 사후관리를 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"네일아티스트, 페티큐어리스트","certLic":"미용사(네일)","dJobECd":"5113","dJobECdNm":"[5113]피부 및 체형 관리사","dJobJCd":"4223","dJobJCdNm":"[4223]피부 및 체형 관리사","dJobICd":"S961","dJobICdNm":"[S961]미용, 욕탕 및 유사 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003843:1', '{"dJobCd":"K000003843","dJobCdSeq":"1","dJobNm":"왁서","workSum":"미용과 위생을 위해 고객의 팔, 다리, 가슴, 겨드랑이, 치골, 엉덩이 등 몸에 난 털을 왁스나 천 등을 사용하여 제거하거나 다양한 형태로 예쁘게 꾸민다.","doWork":"고객과의 상담을 통해 왁싱 시술 가능성을 타진하고 왁싱할 신체부위를 파악하여 왁싱의 종류 등을 선정한다. 왁싱으로 인한 부작용과 불편한 점을 사전에 설명한다. 고객의 체형과 선호 등을 종합하여 적합한 시술 종류(하드왁싱, 소프트왁싱 등)와 방법을 디자인한다. 왁싱, 천, 스틱 등의 도구와 소재를 사용하여 왁싱할 부위에 왁스를 바르고 손 또는 부직포 등을 사용하여 털을 제거하거나 디자인에 맞춰 제거한다. 시술 후 보습제를 바른다. 고객에게 시술 결과를 설명하고 주의할 사항과 관리방법에 대해 설명한다. 고객의 요구사항과 시술방법, 시술결과 등을 담은 상담 일지를 작성한다. 고객의 관리방안을 수립하기도 한다. 왁싱을 배우고 싶어 하는 사람을 대상으로 강의하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"5113","dJobECdNm":"[5113]피부 및 체형 관리사","dJobJCd":"4223","dJobJCdNm":"[4223]피부 및 체형 관리사","dJobICd":"S961","dJobICdNm":"[S961]미용, 욕탕 및 유사 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007188:1', '{"dJobCd":"K000007188","dJobCdSeq":"1","dJobNm":"페디큐어리스트","workSum":"고객의 발을 대상으로 각질 제거 등의 청결 서비스와 발톱 미용에 관한 일을 한다.","doWork":"고객과 상담 후 발톱 및 발의 미용관리에 대해 시술계획을 결정한다. 상담을 통해 고객의 건강상태, 미용관리 등에 대한 정보를 파악한다. 사용 장비 및 물품을 준비한다. 고객의 발을 세척한 후 족탕기(Foot Spa)에 담그고 기계를 조작한다. 물에 담갔던 발을 꺼내 타월로 깨끗이 닦고, 시술할 부위를 알코올로 소독한다. 발톱의 매니큐어, 광택제 등을 제거한다. 시술절차에 따라 각종 물품 및 도구를 선택하여 고객의 피부 및 각질에 손상이 가지 않도록 주의하여 시술한다. 발의 굳은살과 각질을 제거하고, 발을 주무르거나 두드려 혈액순환을 돕는다. 발톱을 소제 및 정리하고, 고객이 선택한 색상의 매니큐어를 칠하거나 인조발톱을 붙인다. 시술 후 도구 및 장비를 소독하고, 정리·정돈한다. 고객의 예약관리 및 사후관리를 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"수집","workFunc2":"서비스제공","workFunc3":"수동조작","similarNm":"발톱미용사","certLic":"미용사(네일)","dJobECd":"5113","dJobECdNm":"[5113]피부 및 체형 관리사","dJobJCd":"4223","dJobJCdNm":"[4223]피부 및 체형 관리사","dJobICd":"S961","dJobICdNm":"[S961]미용, 욕탕 및 유사 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002880:1', '{"dJobCd":"K000002880","dJobCdSeq":"1","dJobNm":"피부미용사","workSum":"고객의 얼굴, 팔, 다리 등을 대상으로 피부 청결 및 미용 서비스를 제공한다.","doWork":"고객과의 상담, 피부 관찰, 건강상태 파악 등을 통해 고객카드를 기록하고, 적합한 피부관리방법을 결정한다. 클렌징, 세안 등으로 고객의 피부를 청결하게 한 후 각질 및 모공 노폐물 제거, 여드름 관리, 눈썹 정리 등 피부를 정돈한다. 피부상태에 적합한 크림 등의 각종 화장품을 바른 후 손이나 미용보조 기기 및 기구를 사용하여 주무르거나 두드려서 혈액순환 및 미용을 돕는다. 피부표면의 잔털을 제거하고 기초화장을 한다. 관리를 마친 고객에게 피부성향에 알맞은 화장품을 추천하고, 피부에 적합한 화장법을 조언한다. 고객의 예약관리 및 사후관리를 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"수집","workFunc2":"서비스제공","workFunc3":"정밀작업","similarNm":"피부관리사","certLic":"미용사(피부)","dJobECd":"5113","dJobECdNm":"[5113]피부 및 체형 관리사","dJobJCd":"4223","dJobJCdNm":"[4223]피부 및 체형 관리사","dJobICd":"S961","dJobICdNm":"[S961]미용, 욕탕 및 유사 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005721:1', '{"dJobCd":"K000005721","dJobCdSeq":"1","dJobNm":"메이크업아티스트","workSum":"미용, 결혼, 연극무대, 방송, 광고, 패션쇼 등의 분야에서 화장을 통해 상황에 적절한 메이크업을 한다.","doWork":"화장품, 피부관리, 색채, 분장 등에 대한 지식을 바탕으로 화장을 통해 인체의 아름다움을 적절히 표현한다. 화장품, 팔레트, 각종 브러시, 스펀지, 분첩 등 메이크업 도구를 준비한다. 고객의 요구와 메이크업의 목적을 파악하고 외모, 얼굴 특성에 따라 적절한 화장법을 선택한다. 고객을 세안시키고 피부의 상태를 확인한다. 스펀지 또는 손을 사용하여 얼굴에 메이크업 베이스를 바른 후 파운데이션(Foundation) 및 컨실러(Concealer:피부 결점을 감추어 주는 화장품)를 발라 피부를 보정한다. 머리색상, 피부톤, 의상 및 메이크업 목적을 고려하여 색조화장을 한다. 눈썹, 아이라이너, 립스틱 등 각종 화장기법을 사용하여 마무리한다. 화장이 끝나면 헤어, 의상과 잘 조화를 이루는지 점검한다. 필요시 고객에게 적절한 화장법을 조언하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"분야에 따라 뷰티메이크업아티스트, 웨딩메이크업아티스트, 무대메이크업아티스트, 광고메이크업아티스트, 포토메이크업아티스트, 패션메이크업아티스트","certLic":"미용사(메이크업)","dJobECd":"5114","dJobECdNm":"[5114]메이크업 아티스트 및 분장사","dJobJCd":"4224","dJobJCdNm":"[4224]메이크업 아티스트 및 분장사","dJobICd":"S961","dJobICdNm":"[S961]미용, 욕탕 및 유사 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001719:1', '{"dJobCd":"K000001719","dJobCdSeq":"1","dJobNm":"바디페인팅아티스트","workSum":"상품의 가치를 높이고 홍보하기 위해 모델의 전신에 그림을 그리거나 깃털 등 장식품을 치장한다.","doWork":"고객(이벤트사)으로부터 홍보제품의 콘셉트, 홍보장소, 행사규모 등을 파악한다. 바디 페인팅할 내용을 종이 등에 디자인한다. 디자인한 결과를 고객과 협의하고 필요하면 수정한다. 홍보제품과 디자인한 내용을 토대로 적합한 모델을 선정한다. 업무를 수행하기 위해 기본적으로 필요한 재료 등을 준비한다. 모델의 전신에 그릴 내용을 사진을 보거나 창작하여 연필로 스케치한다. 에어브러시, 수성물감, 아이섀도, 파운데이션 등을 사용하여 모델의 전신에 그림을 그리거나 깃털 등의 장식품을 사용하여 작품을 완성한다. 작업 후 물감이나 도구 등을 정리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"웅크림|손사용|시각|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"바디페인터","dJobECd":"5114","dJobECdNm":"[5114]메이크업 아티스트 및 분장사","dJobJCd":"4224","dJobJCdNm":"[4224]메이크업 아티스트 및 분장사","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007528:1', '{"dJobCd":"K000007528","dJobCdSeq":"1","dJobNm":"분장사","workSum":"영화, 연극, 방송프로그램 및 광고 출연자들의 얼굴을 극의 분위기에 맞게 분장한다.","doWork":"방송프로듀서(방송연출가), 배우 등과 협의하여 극의 분위기와 시대적 배경에 맞는 사진, 문헌 등을 검토하여 분장방법을 결정한다. 연지, 분, 물감 등의 분장용 재료와 화장품을 사용하여 출연자의 얼굴 생김새와 특징, 피부, 체격 등 신체적 특성과 연령, 캐릭터 등에 따라 분장한다. 가발, 수염 등을 사용하여 분장하기도 한다. 미용사, 가발제작원과 협의하여 작업을 진행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"5114","dJobECdNm":"[5114]메이크업 아티스트 및 분장사","dJobJCd":"4224","dJobJCdNm":"[4224]메이크업 아티스트 및 분장사","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005719:1', '{"dJobCd":"K000005719","dJobCdSeq":"1","dJobNm":"속눈썹미용사","workSum":"고객의 아름다움을 가꿔주기 위해 고객의 요구와 눈매, 인상, 피부색을 고려하여 속눈썹 연장 시술과 속눈썹 펌을 한다.","doWork":"고객과의 상담을 통해 고객의 요구사항을 파악한다. 속눈썹 시술을 위해 고객의 눈매, 인상, 피부색 등을 파악한다. 고객에게 적합한 시술 종류와 방법(속눈썹 연장 종류로는 J컬, C컬, JC컬 등이 대표적임)을 디자인한다. 핀셋, 인조속눈썹, 전용 글루, 마스카라 등의 도구와 소재를 사용하여 속눈썹 연장(전용 글루를 사용해서 속눈썹 한 올 한 올에 인조속눈썹을 길고 풍성하게 디자인 함)과 속눈썹 펌 시술을 한다. 시술 후 고객의 요구, 시술방법 등을 담은 상담 일지를 작성한다. 고객에게 시술 후 주의할 사항과 관리방법에 대해 설명한다. 속눈썹 미용에 사용하는 장비나 도구 등을 소독하는 등 위생적으로 관리한다. 속눈썹 미용을 배우고 싶어 하는 사람을 대상으로 강의하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"수집","workFunc2":"서비스제공","workFunc3":"수동조작","similarNm":"속눈썹아티스트","certLic":"피부미용사(메이크업)","dJobECd":"5114","dJobECdNm":"[5114]메이크업 아티스트 및 분장사","dJobJCd":"4224","dJobJCdNm":"[4224]메이크업 아티스트 및 분장사","dJobICd":"S961","dJobICdNm":"[S961]미용, 욕탕 및 유사 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002933:1', '{"dJobCd":"K000002933","dJobCdSeq":"1","dJobNm":"스킨아티스트","workSum":"천연 원료인 헤나를 이용하여 고객의 신체에 다양한 문양을 디자인한다.","doWork":"스킨아트에 사용되는 원료, 지속기간, 인체의 무해성 등을 고객에게 설명한다. 고객이 원하는 문양, 문양의 크기, 시술부위 등을 파악하고 고객의 상황에 적합한지 협의한다. 여러 가지 문양을 설명하고 선택하도록 한다. 시술기구를 선택하고 천연원료인 헤나를 시술기구에 담는다. 콘이나 스틱을 사용하여 고객의 피부에 시술한다. 시술된 문양의 보존에 관해 조언한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"5114","dJobECdNm":"[5114]메이크업 아티스트 및 분장사","dJobJCd":"4224","dJobJCdNm":"[4224]메이크업 아티스트 및 분장사","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001268:1', '{"dJobCd":"K000001268","dJobCdSeq":"1","dJobNm":"특수분장사","workSum":"영화, 연극, 방송 및 광고 등에서 출연자의 특성을 강조해 주거나 일반 분장으로 보여줄 수 없는 효과를 내기 위해 출연자에게 특수분장을 한다.","doWork":"극의 분위기, 시대적 배경, 출연자의 특징 등을 검토하여 특수분장 계획을 세운다. 감독, 연출가, 출연자 등과 협의하여 분장방법을 결정한다. 특수분장에 필요한 재료를 선택하고, 구매한다. 화장품과 분장용 재료를 사용하여 출연자의 피부를 분장하고, 가발, 수염 등을 붙인다. 미용사, 분장사, 가발제작원 등과 협의하여 작업을 진행하며, 촬영 중에도 조명, 카메라 감독과 협의한다. 새로운 효과를 만들기 위해 출연자의 골격이나 얼굴선 등을 고려하여 출연자의 몸에 재료를 붙이거나 변형한다. 극의 분위기에 맞게 촬영장소에 필요한 특수효과 소품을 제작한다. 특수분장에 대한 다양한 정보를 얻기 위해 자료를 수집·분석한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"5114","dJobECdNm":"[5114]메이크업 아티스트 및 분장사","dJobJCd":"4224","dJobJCdNm":"[4224]메이크업 아티스트 및 분장사","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006951:1', '{"dJobCd":"K000006951","dJobCdSeq":"1","dJobNm":"맞춤형화장품조제관리사","workSum":"맞춤형화장품의 혼합·소분 등 품질·안전 관리 업무를 수행한다.","doWork":"맞춤형화장품 판매장에서 개인의 피부상태, 소비자의 선호도, 진단결과에 따라 화장품에 색소, 향료 등 원료를 혼합하거나 화장품을 나누어 담는다. 내용물 또는 원료에 때한 품질성적서를 확인하고 포장용기의 오염 여부를 확인한다. 혼합·소분에 사용되는 장비 또는 기구 등은 사용 전에 위생상태를 점검하고 사용 후에는 오염이 없도록 세척한다. 혼합·소분에 사용된 내용물·원료에 내용 및 특성, 맞춤형화장품 사용 시 주의사항을 소비자에게 설명한다. 제조번호, 사용기한 및 개봉 후 사용기간, 판매일자 및 판매량이 포함된 맞춤형화장품 판매내역서를 작성·보관한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"수동조작","certLic":"맞춤형화장품조제관리사","dJobECd":"5119","dJobECdNm":"[5119]기타 미용 서비스원","dJobJCd":"4229","dJobJCdNm":"[4229]기타 미용 관련 서비스 종사원","dJobICd":"C204","dJobICdNm":"[C204]기타 화학제품 제조업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004386:1', '{"dJobCd":"K000004386","dJobCdSeq":"1","dJobNm":"스타일리스트","workSum":"방송, 패션잡지, 광고, 패션쇼 등의 성격, 분위기, 출연 프로그램의 특성에 맞게 연예인, 모델등의 스타일을 연출한다.","doWork":"의류시장, 패션잡지 등을 통해 유행을 연구한다. 방송·영화, 패션잡지·출판, 광고, 패션쇼·이벤트 등 프로그램의 특성을 검토·분석한다. 전통의상, 외국의상 등 스타일 연출에 필요한 의상을 조사한다. 행사 분위기와 출연자 특성을 고려하여 색상과 소재 등이 알맞은 의상, 장신구 등을 구입 또는 대여하거나 직접 제작하기도 한다. 연예인의 의견을 참조하여 준비한 후보의상과 장신구 중에서 최종 선정하여 조화롭게 연출한다. 야외 촬영현장 및 스튜디오에서 사용한 의상과 장신구를 정돈·관리하고, 대여한 물품은 반납한다. 헤어손질 및 메이크업을 하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"시각|","workFunc1":"수집","workFunc2":"서비스제공","workFunc3":"정밀작업","similarNm":"패션코디네이터, 패션스타일리스트","dJobECd":"5119","dJobECdNm":"[5119]기타 미용 서비스원","dJobJCd":"4229","dJobJCdNm":"[4229]기타 미용 관련 서비스 종사원","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002846:1', '{"dJobCd":"K000002846","dJobCdSeq":"1","dJobNm":"이미지컨설턴트","workSum":"고객의 다른 사람들에게 주는 이미지를 분석하여 상황에 적합한 메이크업, 화술, 매너, 태도교정, 코디 등을 조언한다.","doWork":"고객의 방문목적을 파악한다. 화장, 화술, 매너, 대화태도, 의복 등을 중심으로 고객의 현재 이미지를 분석한다. 점검된 이미지와 고객의 선호 그리고 목적에 맞추어 의상선택방법, 화장방법, 대화방법, 자세, 표정, 패션, 매너, 화술 등을 조언한다. 이미지에 대한 교육 및 강의를 한다. 사회적으로 선호되는 이미지를 분석한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|시각|","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","similarNm":"이미지메이커","dJobECd":"5119","dJobECdNm":"[5119]기타 미용 서비스원","dJobJCd":"4229","dJobJCdNm":"[4229]기타 미용 관련 서비스 종사원","dJobICd":"S961","dJobICdNm":"[S961]미용, 욕탕 및 유사 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001776:1', '{"dJobCd":"K000001776","dJobCdSeq":"1","dJobNm":"패션어드바이저","workSum":"의상의 소재, 칼라, 패션동향 등의 전문적인 지식과 이해를 바탕으로 매장을 방문한 고객에게 적절한 패션스타일을 자문하고 상품을 판매한다.","doWork":"업체로부터 납품받은 물품의 수량과 품질을 확인하여 진열, 정리한다. 교육과 패션신문 등의 각종 매체를 통해 각 상품의 소재 및 색상 등 의상에 대한 전문적인 지식과 패션동향을 파악한다. 매장을 방문한 고객이 원하는 스타일을 고려하여 고객에게 적절한 의상을 제안하거나 고객의 선택을 돕는다. 선택된 의상을 고객에게 입어보게 하고 고객의 체형과 스타일에 맞게 수선방향을 정하는 핀작업을 한다. 고객이 최종 선택한 의상과 어울리는 속옷, 바지, 액세서리 등 전반적인 스타일을 조언하고 의상을 판매한다. 매장의 전체적인 관리를 도맡아 하며, 주기적으로 방문하는 단골고객을 관리하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"수집","workFunc2":"설득","workFunc3":"단순작업","connectJob":"백화점매장관리원(샵마스터)","dJobECd":"5119","dJobECdNm":"[5119]기타 미용 서비스원","dJobJCd":"4229","dJobJCdNm":"[4229]기타 미용 관련 서비스 종사원","dJobICd":"G471","dJobICdNm":"[G471]종합 소매업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002658:1', '{"dJobCd":"K000002658","dJobCdSeq":"1","dJobNm":"연애코치","workSum":"이성교제에 어려움을 겪는 사람들을 대상으로 이성교제 방법 등에 대해 상담하고 강의한다.","doWork":"남자와 여자의 심리, 생물학적 특성, 이성교제 사례, 연애와 결혼에 대한 가치관, 사회적 변화요인, 결혼 관련 통계 등을 수집하고 분석한다. 다양한 이성교제 문제를 유형별로 정리하고 연애 방법론을 모색한다. 이성교제에 어려움을 겪는 상담고객을 대상으로 문제점, 희망사항 등을 파악한다. 적절한 데이트 장소, 코스, 마음가짐, 매너, 의사소통 방법, 행동과 말투 등을 구체적으로 조언한다. 교제를 진행하는 과정에 관여하여 성혼에 이르도록 협력한다. 결혼적령기의 자녀를 둔 부모를 상담하기도 한다. 강연, 칼럼 및 저술, 방송프로그램 출연 등의 방법으로 대중을 상대로 상담하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","dJobECd":"5121","dJobECdNm":"[5121]결혼상담원 및 웨딩플래너","dJobJCd":"4231","dJobJCdNm":"[4231]결혼상담원 및 웨딩플래너","dJobICd":"S969","dJobICdNm":"[S969]그 외 기타 개인 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007483:1', '{"dJobCd":"K000007483","dJobCdSeq":"1","dJobNm":"웨딩플래너","workSum":"결혼 예정자를 대상으로 결혼 전 준비에서부터 신혼여행에 이르기까지의 모든 과정을 기획하고 대행한다.","doWork":"결혼 예정자의 전화, 메일 등의 상담에 응대한다. 내방 고객에게 회사의 서비스를 소개한다. 결혼 예정자와 상담을 통해 스케줄, 예산, 개인성향 등의 고객정보를 분석한다. 고객정보를 바탕으로 그에 따른 맞춤정보를 기획한다. 상품정보 및 자료를 안내하고 선택을 돕는다. 고객이 선택한 웨딩 관련 업체를 방문하여 고객의 결정사항에 대해 계약과 발주를 대행한다. 고객에게 각종 서류 및 계약사항을 설명하고 확인한다. 고객에게 진행상황 및 준비물을 통보하고, 고객과 업체와의 업무를 중간에서 조율한다. 사진촬영, 예식 등의 현장 준비사항을 점검한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"언어력|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"결혼관리사, 웨딩PD, 웨딩코디네이터, 웨딩컨설턴트, 웨딩설계전문가, 결혼준비대행원","dJobECd":"5121","dJobECdNm":"[5121]결혼상담원 및 웨딩플래너","dJobJCd":"4231","dJobJCdNm":"[4231]결혼상담원 및 웨딩플래너","dJobICd":"S969","dJobICdNm":"[S969]그 외 기타 개인 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004890:1', '{"dJobCd":"K000004890","dJobCdSeq":"1","dJobNm":"커플매니저","workSum":"결혼 적령기의 고객을 대상으로 배우자의 조건을 파악하고, 컴퓨터 매칭작업과 전문지식 및 경험을 바탕으로 최적의 배우자를 소개하고 만남을 주선한다.","doWork":"배우자를 찾는 사람들의 전화, 메일 등의 문의에 응대하고, 회사의 서비스를 소개한다. 상담을 위해 내방한 고객에게 회사의 서비스를 소개하고, 회원가입을 유도한다. 회원가입 신청서 및 관련 서류를 받아 회원자격을 심사한다. 회원을 유형별로 분류하고, 컴퓨터 매칭시스템에 신상명세를 입력한다. 컴퓨터 매칭시스템의 매칭작업과 회원상담을 통하여 적합한 상대를 찾으면 전화, 메일 등으로 프로필을 소개하고, 만남을 주선한다. 만남 이후의 회원 반응을 체크하고, 다음 매칭에 참고한다. 만남을 거친 회원들을 결혼에 이를 수 있도록 사후관리한다. 회원에게 이성교제에 대하여 조언한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"결혼상담원","connectJob":"컴퓨터중매인","dJobECd":"5121","dJobECdNm":"[5121]결혼상담원 및 웨딩플래너","dJobJCd":"4231","dJobJCdNm":"[4231]결혼상담원 및 웨딩플래너","dJobICd":"S969","dJobICdNm":"[S969]그 외 기타 개인 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003278:1', '{"dJobCd":"K000003278","dJobCdSeq":"1","dJobNm":"예식장종사원","workSum":"결혼식이 순조롭게 진행되도록 예식 전반의 업무를 돕는다.","doWork":"예식장 내의 주례단상, 의자, 마이크시설, 카펫 등을 정리·정돈한다. 예식 진행에 필요한 성혼선언문, 장갑, 꽃 등을 준비한다. 식의 진행순서에 대해 알리고 입장 방법 및 주의사항을 설명한다. 방송시설을 이용하여 하객을 장내로 유도한다. 예식의 진행과정을 관찰하고 문제가 있을 시 조치를 취한다. 예식 관련 질문에 응대하고, 예식이 끝난 후 식장을 정리한다. 피아노를 이용하여 행진곡을 연주하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"관련없음","similarNm":"예식장도우미","dJobECd":"5122","dJobECdNm":"[5122]혼례 종사원","dJobJCd":"4232","dJobJCdNm":"[4232]혼례 종사원","dJobICd":"S969","dJobICdNm":"[S969]그 외 기타 개인 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004997:1', '{"dJobCd":"K000004997","dJobCdSeq":"1","dJobNm":"웨딩도우미","workSum":"결혼식 또는 웨딩촬영에서 신랑과 신부의 예복을 관리하고 예식을 돕는다.","doWork":"웨딩드레스 숍에서 예식 및 웨딩촬영 스케줄(예식장소·시간, 메이크업숍 장소와 시간, 웨딩촬영 장소와 시간, 신랑/신부의 인적사항)을 확인한다. 예복(턱시도, 웨딩드레스, 패치코트, 구두 등)과 소품(귀걸이, 부토니에르-턱시도에 착용하는 장식 꽃, 티아라-신부가 쓰는 왕관 형 머리장식)을 확인한다. 예식에 앞서 신랑과 신부가 메이크업을 하는 동안 예복을 가지고 드레스 숍에서 메이크업 숍으로 이동한다. 신랑과 신부를 확인하고 예복을 착용하는 것을 돕는다. 드레스 가방과 소품 가방에 신랑과 신부가 갈아입은 옷을 보관한다. 신랑·신부와 함께 예식장으로 이동하며 웨딩드레스가 바닥에 끌리거나, 밟히거나, 흘러내리거나, 오염되지 않도록 치마 끝을 들어주고 살펴준다. 예식장에서 신부에게 부케를, 신랑에게 부토니에르를, 혼주들에게 꽃을 달아준다. 예식이 시작되기 전에 신랑, 신부, 혼주들의 의상을 점검한다. 신부에게 드레스 잡는 법, 걷는 법, 예식절차와 행동에 대해 설명한다. 예식 중에 웨딩드레스 자락을 들어주고 펼쳐주는 등 신부가 아름답게 보이도록 한다. 예식이 끝나면 예복을 회수하고 갈아입은 옷을 건네준다. 예복 및 소품의 오염·훼손·망실 여부를 확인하고 필요시 보상을 청구하기도 한다. 예식장에서 웨딩드레스 숍으로 이동하고 예복과 소품을 반납한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"단순작업","similarNm":"웨딩헬퍼","dJobECd":"5122","dJobECdNm":"[5122]혼례 종사원","dJobJCd":"4232","dJobJCdNm":"[4232]혼례 종사원","dJobICd":"S969","dJobICdNm":"[S969]그 외 기타 개인 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003500:1', '{"dJobCd":"K000003500","dJobCdSeq":"1","dJobNm":"전문주례사","workSum":"신랑, 신부의 요청 시 일정액의 사례비를 받고 주례 업무를 대행해 준다.","doWork":"신랑, 신부의 나이, 학력, 직업 및 가정환경 등을 파악한 후 신랑, 신부에게 맞는 주례사를 준비하기 위해 원고를 작성한다. 미리 작성된 원고에 따라 덕담을 하고 혼주 간 인사, 혼인서약 등 주례 업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"관련없음","similarNm":"전속주례, 직업주례사","dJobECd":"5122","dJobECdNm":"[5122]혼례 종사원","dJobJCd":"4232","dJobJCdNm":"[4232]혼례 종사원","dJobICd":"S969","dJobICdNm":"[S969]그 외 기타 개인 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003953:1', '{"dJobCd":"K000003953","dJobCdSeq":"1","dJobNm":"폐백도우미","workSum":"결혼식 후 거행되는 신랑, 신부의 폐백을 위해 준비 및 진행을 돕는다.","doWork":"예식장 폐백실에서 신랑과 신부가 턱시도와 웨딩드레스를 한복으로 갈아입도록 돕는다. 신랑과 신부에게 한복 입는 방법 및 폐백절차, 절 올리는 방법 등을 알려준다. 신부의 활옷(가례에 착용하는 여자 예복)과 연지·곤지, 족두리(부녀자들이 예복을 입을 때에 머리에 얹는 관), 비녀의 착용을 돕는다. 폐백상을 차린다. 폐백 절차에 따라 큰절하기, 술 따르기, 술잔 옮기기, 안주 드리기, 덕담, 밤·대추 받기, 절값 받기, 사진촬영 등을 진행한다. 시아버지, 시어머니, 형제, 친척의 폐백 받는 순서를 정하고 차례대로 진행한다. 시부모 중에 돌아가신 분이 있을 경우 보료에 수의를 놓고 폐백을 드리기도 한다. 폐백 절차가 끝나면 폐백음식을 정리하여 시부모님께 전달하고, 밤·대추를 복주머니에 담아 신랑신부에게 전달한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"단순작업","similarNm":"수모","dJobECd":"5122","dJobECdNm":"[5122]혼례 종사원","dJobJCd":"4232","dJobJCdNm":"[4232]혼례 종사원","dJobICd":"S969","dJobICdNm":"[S969]그 외 기타 개인 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002856:1', '{"dJobCd":"K000002856","dJobCdSeq":"1","dJobNm":"반려동물장의사","workSum":"수시, 염습, 입관, 화장 등 애완동물의 장례를 주관한다.","doWork":"반려동물 장례 의뢰가 오면, 고객과 장례절차에 대해 논의하고 자택으로 영구차를 보내 사체를 장례식장으로 운구한다. 반려동물의 사체를 곧고 바르며 깨끗하게 거두는 수시(收屍)와 염습(殮襲:사체를 깨끗이 목욕시켜 수의를 입히는 일)을 거쳐 입관(入官:사체를 관속에 넣는 작업)을 한다. 사고사한 애완동물은 수술용 바늘로 사체를 꿰매서 최대한 깨끗한 상태로 복원한다. 입관이 끝나면 발인을 하며 고객의 종교에 맞게 장례예식을 치르고 화장을 한다. 화장 뒤에는 유골을 수습하고, 분골을 고객에게 인도하며 예식을 종료한다. 고객에 따라 화장만 하는 경우도 있고 화장 뒤에는 애완견 장묘업체가 보유하고 있는 납골당에 두거나 야외에 뿌리기도 한다. 장례식에 직접 참여하지 못하는 고객을 위하여 모든 과정을 동영상으로 촬영하여 제공하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"손사용|시각|","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"정밀작업","similarNm":"애완동물장례지도사","dJobECd":"5123","dJobECdNm":"[5123]장례 지도사 및 장례 상담원","dJobJCd":"4233","dJobJCdNm":"[4233]장례 상담원 및 장례 지도사","dJobICd":"S969","dJobICdNm":"[S969]그 외 기타 개인 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001707:1', '{"dJobCd":"K000001707","dJobCdSeq":"1","dJobNm":"장례복원메이크업전문가","workSum":"고인의 사진을 통해 생전에 얼굴 특징, 이미지를 파악하고, 사후의 얼굴 변화, 피부색 변화 등을 고려하여 생전모습에 가깝도록 복원메이크업을 한다.","doWork":"얼굴학, 색채, 피부, 화장품, 도구, 약품 등에 지식을 바탕으로 장례복원메이크업을 한다. 고인의 피부변색, 상처, 함몰 등 상태를 파악하고 유족과의 상담을 통해 장례뷰티메이크업, 복원메이크업 적용을 유무를 결정한다. 고인의 사진을 통해 생전의 얼굴 특징을 파악하고 메이크업 계획을 세운다. 고인의 얼굴 및 피부상태에 따라 화장품, 도구, 약품을 선택한다. 얼굴형태, 피부색이 정상이고, 피부변색만 있는 경우에는 얼굴과 머리를 소독, 세척하고, 면도를 시키고, 마사지를 하여 경직된 근육을 이완시켜 편안해 보이도록 얼굴을 교정한다. 파운데이션을 선택하고 손으로 바르는 스펀지, 붓, 에어브러시 기구를 사용하여 고인의 피부 자연스럽게 보정하고, 변색피부는 생전의 피부색에 가깝도록 자연스럽게 커버하여 복원시킨다. 색조화장은 피부색, 머리색, 수의 색상을 고려하여 눈썹, 아이섀도, 립스틱 등 다양한 화장품을 선택하여 자연스럽고 더 아름답게 메이크업 한다. 얼굴 변형과 소실된 피부는 소독 후 도구, 봉합, 대체물질, 약품 등을 사용하여 얼굴형과 피부를 복원한다. 색조화장을 선택하여 생전의 모습처럼 편안하고 자연스럽게 메이크업한다. 생전의 헤어스타일을 만들고, 머리카락이 없으면 붙이거나 가발, 모자, 헤어, 머풀러로 대체한다. 유족에 요구에 따라 생전에 좋아하던 안경, 액세서리, 모자 등을 착용시키고, 네일도 발라준다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"정밀작업","similarNm":"고인메이크업아티스트, 시신메이크업아티스트, 장례메이크업아티스트","dJobECd":"5123","dJobECdNm":"[5123]장례 지도사 및 장례 상담원","dJobJCd":"4233","dJobJCdNm":"[4233]장례 상담원 및 장례 지도사","dJobICd":"S969","dJobICdNm":"[S969]그 외 기타 개인 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006622:1', '{"dJobCd":"K000006622","dJobCdSeq":"1","dJobNm":"장례지도사","workSum":"유족과 장례절차를 상담하고, 장례용품 준비부터 시신관리, 장례식 주관 등 장례에 관한 절차를 관리한다.","doWork":"장례에 대한 법적 절차를 점검하고 장례에 필요한 장의용품을 준비한다. 유족과 장례절차, 일정, 안치 및 염습 방법, 장의용품 등에 대해 상의한다. 장례일정과 비용, 장례규모, 종교, 가풍 등 특이사항에 대해 상담이 끝나면 장례식장 또는 상을 당한 고객의 집을 방문하여 장례식을 총괄한다. 유족에게 조문객 접대 준비사항에 대해 안내하고, 예법에 관해 지도한다. 시신을 목욕시킨 후 알코올 솜으로 시신의 몸을 닦고, 몸이 굳기 전 팔·다리를 주물러 시신을 반듯하게 한다. 시신의 얼굴과 머리를 정리하며, 남자의 경우 면도를, 여자의 경우 화장을 한다. 한지로 시신의 몸을 감싼 후 수의를 입힌다. 입관을 할 때 시신이 관 안에서 흔들리지 않도록 시신과 관벽 사이의 공간을 벽지나 마포 등으로 채운다. 운명 시 입었던 옷 등을 소각할 수 있도록 정리하여 유족에게 전달한다. 시신 냉장시설 및 기타 물품을 살균 소독하고, 위험한 질병 사망자에 대한 위생처리를 한다. 장례행렬 절차를 점검하고, 성복제, 발인제 등의 제사를 준비한다. 시신을 영구차로 운반하는 것을 관리하며, 시신이 장지에 도착하면 묘역을 살피고 하관한다. 장례 후 제례의식, 화장, 이장 등에 관하여 상담한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"손사용|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"장의사, 상례사","connectJob":"시체 관리를 하는 경우 염사, 방부처리사","dJobECd":"5123","dJobECdNm":"[5123]장례 지도사 및 장례 상담원","dJobJCd":"4233","dJobJCdNm":"[4233]장례 상담원 및 장례 지도사","dJobICd":"S969","dJobICdNm":"[S969]그 외 기타 개인 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007477:1', '{"dJobCd":"K000007477","dJobCdSeq":"1","dJobNm":"반려동물미용사","workSum":"개나 고양이 등의 애완동물에 대한 미용과 청결에 관련된 서비스를 제공한다.","doWork":"고객과 동물 털의 커트 모양에 대해 상담한 후 작업방식을 정한다. 반려동물의 털상태 및 건강상태를 확인한다. 건강상태가 나쁜 경우 고객에게 알려 수의사에게 적절한 치료를 받게 한다. 샴푸와 린스를 사용하여 반려동물을 목욕시킨다. 드라이어를 사용하여 털을 말리고 털이 긴 동물은 트리밍(털을 잘라주는 작업)을 한다. 빗과 머리핀을 사용하여 고객이 원하는 형태로 고정시킨 후 귀청소를 하고 발톱을 깎는다. 스포팅(털만 제거), 서머마이애미(머리, 꼬리, 다리의 끝부분 털만을 남김), 로열터치(허리와 목 부분의 털만을 깎음) 등 자르는 기법을 이용해 애완동물의 균형을 고려하여 잘라준다. 털 제거, 빗질 등 마무리 작업을 한다. 고객의 요청에 따라 염색약품을 배합하여 털을 염색한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"수집","workFunc2":"서비스제공","workFunc3":"정밀작업","similarNm":"애견미용사, 반려견스타일리스트","dJobECd":"5115","dJobECdNm":"[5115]반려동물 미용 및 관리 종사원","dJobJCd":"4291","dJobJCdNm":"[4291]반려동물 미용 및 관리 종사원","dJobICd":"S969","dJobICdNm":"[S969]그 외 기타 개인 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006637:1', '{"dJobCd":"K000006637","dJobCdSeq":"1","dJobNm":"반려동물행동교정사","workSum":"개·고양이 등 반려동물의 다양한 문제행동의 본질과 원인을 분석하고, 행동교정 프로그램을 설계하고 훈련한다.","doWork":"반려동물 주인의 집을 방문하거나 교정실 등에서 동물의 행동에 대해 반려동물 보호자와 상담한다. 개와 고양이의 과도한 짖음, 공격적이고 파괴적인 행동, 화장실 문제 등과 같은 문제적 행동의 본질과 원인을 분석한다. 교정을 위한 프로그램을 설계한다. 행동교정프로그램을 적용하고 교정 여부를 평가한다. 필요시 교정프로그램을 재설계하여 재평가를 하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"손사용|언어력|","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","similarNm":"애완동물행동교정사, 애완동물상담원","certLic":"반려동물행동지도사","dJobECd":"5115","dJobECdNm":"[5115]반려동물 미용 및 관리 종사원","dJobJCd":"4291","dJobJCdNm":"[4291]반려동물 미용 및 관리 종사원","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007497:1', '{"dJobCd":"K000007497","dJobCdSeq":"1","dJobNm":"수의사보조원","workSum":"동물병원에서 개나 고양이 등의 동물에 대한 진료, 진단, 처치, 수술 등의 업무를 수행하는 수의사를 지원하고 보조한다.","doWork":"동물병원에서 접수, 보호자 안내, 수납, 차트관리 등의 원무관리 업무를 수행한다. 방문하거나 전화를 걸어 온 고객에 대한 응대 업무를 수행한다. 아픈 동물에 대한 간호 업무를 수행한다. 진료실의 장비 및 기구를 관리한다. 수의사의 지시를 받아 처치실의 업무(처치준비 및 처치보조, 처치수기), 처치실의 기구와 물품관리 업무(처치실 청소 및 소독), 수술실의 업무(수술 준비 및 수술 후 처치보조), 수술실의 기구와 물품관리 업무(수술실의 무균관리, 수술실 청소 및 소독)를 보조한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"동물간호사, 수의간호사, 동물복지간호사, 수의테크니션, 동물보건사","dJobECd":"5115","dJobECdNm":"[5115]반려동물 미용 및 관리 종사원","dJobJCd":"4291","dJobJCdNm":"[4291]반려동물 미용 및 관리 종사원","dJobICd":"M731","dJobICdNm":"[M731]수의업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003062:1', '{"dJobCd":"K000003062","dJobCdSeq":"1","dJobNm":"애견핸들러","workSum":"의뢰인에게 도그쇼에 출진하는 개를 위탁받아서 훈련하고 관리한다.","doWork":"의뢰인에게 도크쇼에 나가는 개를 위탁받는다. 의뢰인과의 상담을 통해서 개의 현 상황 및 행동습관 등을 파악한다. 파악된 자료를 토대로 개를 훈련시키고 관리해서 도그쇼에 필요한 행동거지와 매너를 익히게 한다. 개를 도그쇼에 참가시키고 개가 개의 이상적인 모습을 취하여 심사위원들에게 잘 보일 수 있도록 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"손사용|","workFunc1":"수집","workFunc2":"교육","workFunc3":"단순작업","dJobECd":"5115","dJobECdNm":"[5115]반려동물 미용 및 관리 종사원","dJobJCd":"4291","dJobJCdNm":"[4291]반려동물 미용 및 관리 종사원","dJobICd":"S969","dJobICdNm":"[S969]그 외 기타 개인 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001518:1', '{"dJobCd":"K000001518","dJobCdSeq":"1","dJobNm":"애견혈통관리자","workSum":"순수 혈통견을 보호 및 장려하고 견종 표준 확립 및 과학적인 번식을 위하여 사진 또는 실물로 견(犬) 개체를 심사하고 혈통서를 등록·발급한다.","doWork":"견주(개의 주인) 및 브리더(Breeder:번식전문가)의 의뢰에 따라 등록할 견(개)의 사진을 통해 크기, 털색, 형태를 확인하고 견종 고유의 표준과 일치하는지 판별한다. 사진으로 판별되지 않는 경우 실사하여 확인한다. 견종(개의 종류), 견명(개채 이름), 모견, 부견, 동배견(같은 어미를 가지는 견), 혈통번호, 색인번호, 번식자 및 소유자, 각종 질병 및 의학적 등급, 조상견 3대의 정보를 혈통관리프로그램에 입력한다. 혈통서(문서)를 발급한다. 혈통번호 등 고유번호를 색인기계를 사용하여 개의 귀에 문신한다. 견종에 따라 개의 가계도를 기록한다. 국내에서 발급된 혈통서를 국제단체에 보내 승인을 받고 외국견종이 국내로 들어오는 경우 국내 혈통기록에 포함시켜 각 나라의 혈통서가 전산상에서 관리되도록 한다. 각종 애견 대회, 종견인정검사(종견으로서 가치가 있는지 검사 및 선발)에 참여하여 수상 및 인정 내역을 기록한다. 혈통기록을 통계자료로 정리하여 제출하기도 한다. 혈통 관련 분쟁이나 이상번식(견종별 번식주기와 맞지 않는 번식) 등에 개입하여 전문가로서의 견해를 제공하기도 한다. 분실된 견의 귀색인 번호를 등록기록과 대조하여 견주를 확인해 주기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"관련없음","dJobECd":"5115","dJobECdNm":"[5115]반려동물 미용 및 관리 종사원","dJobJCd":"4291","dJobJCdNm":"[4291]반려동물 미용 및 관리 종사원","dJobICd":"S969","dJobICdNm":"[S969]그 외 기타 개인 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005126:1', '{"dJobCd":"K000005126","dJobCdSeq":"1","dJobNm":"펫시터","workSum":"반려동물 주인의 부재 시 애완동물을 돌봐주고 관리한다.","doWork":"반려동물의 주인과 상담을 통해 반려동물의 생활습관과 돌봄방법을 파악한다. 반려동물을 돌보고 먹이를 주며 산책시키고 배변시킨다. 주인이 돌아오면 반려동물 관리 상태를 보고하고 주인에게 인계한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"언어력|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","similarNm":"반려동물돌보미","dJobECd":"5115","dJobECdNm":"[5115]반려동물 미용 및 관리 종사원","dJobJCd":"4291","dJobJCdNm":"[4291]반려동물 미용 및 관리 종사원","dJobICd":"S969","dJobICdNm":"[S969]그 외 기타 개인 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006434:1', '{"dJobCd":"K000006434","dJobCdSeq":"1","dJobNm":"점술가","workSum":"손금, 관상, 여러 가지 점치는 도구 등을 참조하여 고객의 장래에 발생할 수 있는 일을 예언하고 조언한다.","doWork":"고객의 손금과 얼굴의 형태를 관찰하거나 고객의 태어난 생년월일시각, 성명 등을 알아 월력, 십간십이지표, 구호표, 묵죽, 타로카드 등의 용구를 사용하여 미래의 일을 풀이하거나 예언한다. 길흉화복의 운명을 판단하여 행동의 지침을 알려주며 사주, 궁합 등을 조언한다. 때때로 액운을 막기 위한 부적을 쓰기도 한다. 타고난 사주에 기반하여 신생아 이름, 개명, 상호명 등 이름을 짓기도 한다. 손금, 관상, 사주, 작명 등 한 가지를 전문으로 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"운명철학가, 역술가, 관상가, 무당, 타로상담가, 작명가, 풍수지리가","dJobECd":"5124","dJobECdNm":"[5124]점술가 및 민속신앙 종사원","dJobJCd":"4292","dJobJCdNm":"[4292]점술가 및 민속신앙 종사원","dJobICd":"S969","dJobICdNm":"[S969]그 외 기타 개인 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004731:1', '{"dJobCd":"K000004731","dJobCdSeq":"1","dJobNm":"타로상담가","workSum":"타로카드를 사용하여 고객의 연예, 건강, 진로, 재물 등의 운세를 점치고 고객에게 조언한다.","doWork":"고객으로부터 연예, 건강, 진로, 재물 등의 알고 싶은 내용을 듣는다. 타로카드를 고객이 뽑도록 하거나 직접 뽑는다. 뽑힌 카드의 내용을 고객의 질문을 토대로 염력 등을 통해 카드의 의미를 읽고 해석한다. 고객에게 미래의 운세를 조언하고 행동 방향을 말해준다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"관련없음","similarNm":"타로리더, 타로마스터","dJobECd":"5124","dJobECdNm":"[5124]점술가 및 민속신앙 종사원","dJobJCd":"4292","dJobJCdNm":"[4292]점술가 및 민속신앙 종사원","dJobICd":"S969","dJobICdNm":"[S969]그 외 기타 개인 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005543:1', '{"dJobCd":"K000005543","dJobCdSeq":"1","dJobNm":"항공기객실사무장","workSum":"기내 서비스를 제공하는 객실승무원들의 활동을 조정·감독한다.","doWork":"탑승예정인 항공기의 종류 및 목적지를 확인하고 승무원의 명단, 귀빈 명단을 확인한다. 객실승무원들에게 항로, 목적지, 귀빈에 대한 정보를 제공하고 기내에서의 근무 구역을 배치한다. 객실승무원의 업무를 총괄하고 복장 및 근무상황을 감독한다. 객실을 점검하고 탑승인원을 점검하여 기장에게 보고한다. 승객의 질문에 응대하고 요구사항을 처리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|언어력|","workEnv":"위험내재|","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","dJobECd":"5221","dJobECdNm":"[5221]항공기 객실승무원","dJobJCd":"4311","dJobJCdNm":"[4311]항공기 객실 승무원","dJobICd":"H511/H512","dJobICdNm":"[H511]항공 여객 운송업 / [H512]항공 화물 운송업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007506:1', '{"dJobCd":"K000007506","dJobCdSeq":"1","dJobNm":"항공기객실승무원","workSum":"항공기에 탑승한 승객에게 기내에서 제반 서비스를 제공한다.","doWork":"항공기객실사무장의 지시에 따라 기내를 정돈하고 목적지, 비행시간, 항로 및 귀빈 탑승현황 등에 대하여 확인한다. 항공기에 탑승한 승객이 제시하는 좌석표를 확인하여 좌석을 안내하고 인원을 점검한다. 승객의 안전 및 비상상황을 대비한 행동요령을 안내하고 승객에게 신문, 식사, 면세품 등을 제공한다. 승객의 수하물 운반을 돕고 문의에 응대한다. 비상시 비상탈출설비를 가동하여 승객의 탈출을 돕는다. 운항과 관련된 각종 일지를 작성한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|언어력|","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"관련없음","connectJob":"스튜어디스, 스튜어드","dJobECd":"5221","dJobECdNm":"[5221]항공기 객실승무원","dJobJCd":"4311","dJobJCdNm":"[4311]항공기 객실 승무원","dJobICd":"H511/H512","dJobICdNm":"[H511]항공 여객 운송업 / [H512]항공 화물 운송업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003101:1', '{"dJobCd":"K000003101","dJobCdSeq":"1","dJobNm":"고속열차팀장","workSum":"KTX, SRT 등 고속열차의 안전한 운행과 승객 서비스에 관련된 업무를 관리하고, 사고 등 이례 사항이 발생 시 조치 및 열차 내 총괄 지휘를 한다.","doWork":"열차 감시 및 열차 승강문 안전취급 업무를 한다. 차내 방송시스템 취급 및 지연 등 이례 사항이 발생 시 방송을 한다. 차체, 제어장치 등 열차 안전 운행과 관련된 장치를 취급하고 필요시 응급조치를 한다. 고속철도 물품의 인계, 인수 및 확인 업무를 한다. 열차 운전 취급 및 안전관련 업무를 한다. 사고 등 이례 사항이 발생 시 조치 및 열차 내 총괄 지휘를 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"균형감각|","workEnv":"소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"수동조작","dJobECd":"5222","dJobECdNm":"[5222]선박·열차 객실승무원","dJobJCd":"4312","dJobJCdNm":"[4312]선박 및 열차 객실 승무원","dJobICd":"H491","dJobICdNm":"[H491]철도 운송업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007578:1', '{"dJobCd":"K000007578","dJobCdSeq":"1","dJobNm":"선박객실승무원","workSum":"훼리, 크루즈, 유람선 등을 이용하는 승객의 안전과 편의를 위해 각종 서비스를 제공한다.","doWork":"승객에게 승선 및 하선, 선실 등에 대하여 안내한다. 운행 중에 목적지, 운행시각, 주의사항 등을 안내한다. 탑승인원을 확인하고 운행, 노선, 일정 및 편의시설 등을 승객에게 알려준다. 승객에게 구명조끼 착용법, 구명보트 탑승요령 등을 설명한다. 식사나 음료를 제공하며, 티켓을 확인하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"균형감각|","workEnv":"소음·진동|","workFunc1":"관련없음","workFunc2":"서비스제공","workFunc3":"관련없음","similarNm":"선실승무원","connectJob":"선박의 종류에 따라 크루즈승무원, 유람선승무원, 여객선승무원","certLic":"구명정수","dJobECd":"5222","dJobECdNm":"[5222]선박·열차 객실승무원","dJobJCd":"4312","dJobJCdNm":"[4312]선박 및 열차 객실 승무원","dJobICd":"H501/H502","dJobICdNm":"[H501]해상 운송업 / [H502]내륙 수상 및 항만 내 운송업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005354:1', '{"dJobCd":"K000005354","dJobCdSeq":"1","dJobNm":"선박사무장","workSum":"선박 화물의 관리나 선박 승객에 대한 서비스 업무를 총괄하고, 선박승무원들의 활동을 관리·감독한다.","doWork":"선박에 선적된 화물의 명세서를 확인하여 종류와 수량 및 상태, 위험물 등을 확인하고 명세서와 비교한다. 각 항구에 하역할 화물을 확인하고 관련 자료를 정리한다. 승무원의 고용계약서를 작성하고 항해종료 시에 급여 등 인원관리를 위한 자료를 정리한다. 탑승한 승객에게 안전수칙을 설명하고 구명조끼 및 구명정을 이용하는 요령을 교육한다. 승객의 세관신고 및 하선에 필요한 서류작성을 설명한다. 수하물의 운반 및 관리를 지시하고 귀중품을 보관한다. 승객의 안전한 승선에 대해 검토 및 분석하고 안전시스템 구축방안을  마련한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"손사용|","workEnv":"다습|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","certLic":"구명정수, 선박안전관리사","dJobECd":"5222","dJobECdNm":"[5222]선박·열차 객실승무원","dJobJCd":"4312","dJobJCdNm":"[4312]선박 및 열차 객실 승무원","dJobICd":"H501/H502","dJobICdNm":"[H501]해상 운송업 / [H502]내륙 수상 및 항만 내 운송업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003247:1', '{"dJobCd":"K000003247","dJobCdSeq":"1","dJobNm":"여객선개찰원","workSum":"연안여객선을 이용하는 승객의 승선을 돕고 승선표를 검사한다.","doWork":"여객선의 접안을 확인하고 출발시간 및 행선지를 확인한다. 승객이 선박에 승선할 수 있도록 다리 또는 널판지 등의 안전 통행설비를 설치하고 부착상태를 확인한다. 승객으로부터 승선표를 받아 시간 및 행선지를 확인한다. 승객이 안전한 승선을 할 수 있도록 안내한다. 승객의 승선이 완료되면 통행설비를 제거하고 승선인원을 파악한다. 승객에게 선박의 운항에 대한 안내를 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"힘든 작업","workPlace":"실내·외","workEnv":"다습|","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"관련없음","dJobECd":"5222","dJobECdNm":"[5222]선박·열차 객실승무원","dJobJCd":"4312","dJobJCdNm":"[4312]선박 및 열차 객실 승무원","dJobICd":"H501/H502","dJobICdNm":"[H501]해상 운송업 / [H502]내륙 수상 및 항만 내 운송업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003682:1', '{"dJobCd":"K000003682","dJobCdSeq":"1","dJobNm":"여객전무","workSum":"열차 출입문의 개폐 외에 승차권의 확인, 열차 내 질서유지 등의 업무를 수행한다.","doWork":"근무 스케줄을 확인하고 출무 전 열차 주의 및 공지사항을 전달받는다. 객화차의 출입문, 객실온도 등을 검수하고 승객의 승·하차를 도운 후 출입문을 개폐한다. 무전기 및 전호기를 이용하여 기관사에게 출발신호를 보낸다. 일정한 시간 간격으로 객실을 순회하며 승차권을 검사하고 무찰승객에게 표를 발행한다. 객실 내의 각종 사고 발생 시 응급처치를 하고 조치를 취한다. 열차 내의 안전, 청결 및 환기상태 등을 점검하고 조치한다. 질서유지 및 지역 공지를 위한 차내 방송을 실시한다. 열차 내 식사 및 판매 업무에 종사하는 사람들의 활동을 조정한다. 사고 및 연착, 차표확인기록 등에 대한 보고일지를 작성한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"균형감각|","workEnv":"소음·진동|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"5222","dJobECdNm":"[5222]선박·열차 객실승무원","dJobJCd":"4312","dJobJCdNm":"[4312]선박 및 열차 객실 승무원","dJobICd":"H491","dJobICdNm":"[H491]철도 운송업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007390:1', '{"dJobCd":"K000007390","dJobCdSeq":"1","dJobNm":"열차승무원","workSum":"열차승객의 편안한 여행을 위해 승객에게 서비스를 제공한다.","doWork":"승객의 승·하차를 안내하고 도와준다. 운행 중인 열차를 순회하며 고객의 편의를 도모한다. 승객의 안전을 위해 객실 선반의 물건을 정리하고 확인한다. 무선이동단말기를 이용하여 승차권 발행, 열차 정보를 제공한다. 승객의 질문에 응대하고, 사고발생, 승객의 불만 및 요구사항에 대하여 여객전무(열차팀장)와 상의하여 처리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"관련없음","similarNm":"철도승무원, 열차객실승무원, 고속철도승무원","dJobECd":"5222","dJobECdNm":"[5222]선박·열차 객실승무원","dJobJCd":"4312","dJobJCdNm":"[4312]선박 및 열차 객실 승무원","dJobICd":"H491","dJobICdNm":"[H491]철도 운송업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004254:1', '{"dJobCd":"K000004254","dJobCdSeq":"1","dJobNm":"전철차장","workSum":"도시철도(전동차)에서 승객의 승·하차 및 기타 안전수송을 위한 업무를 수행한다.","doWork":"전동차의 감시 및 승강문 안전취급 업무를 한다. 차내 방송시스템 취급 및 지연 등 이례 사항이 발생 시 방송을 한다. 차체, 제어장치 등 전동차 안전 운행과 관련된 장치를 취급하고 필요시 응급조치를 한다. 전동차 운전 취급 및 안전 관련 업무를 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"균형감각|","workEnv":"소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"수동조작","dJobECd":"5222","dJobECdNm":"[5222]선박·열차 객실승무원","dJobJCd":"4312","dJobJCdNm":"[4312]선박 및 열차 객실 승무원","dJobICd":"H491","dJobICdNm":"[H491]철도 운송업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003992:1', '{"dJobCd":"K000003992","dJobCdSeq":"1","dJobNm":"특급열차팀장","workSum":"특급 여객 열차의 안전한 운행과 승객 서비스에 관련된 업무를 관리하고, 열차승무원들의 활동을 조정·감독한다.","doWork":"열차 감시 및 열차 승강문 안전취급 업무를 한다. 차내 방송시스템 취급 및 지연 등 이례 사항이 발생 시 방송을 한다. 차체, 제어장치 등 열차 안전 운행과 관련된 장치를 취급하고 필요시 응급조치를 한다. 고속철도 물품의 인계, 인수 및 확인 업무를 한다. 열차 운전 취급 및 안전 관련 업무를 한다. 사고 등 이례 사항이 발생 시 조치 및 열차 내 총괄 지휘를 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"균형감각|","workEnv":"소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"수동조작","dJobECd":"5222","dJobECdNm":"[5222]선박·열차 객실승무원","dJobJCd":"4312","dJobJCdNm":"[4312]선박 및 열차 객실 승무원","dJobICd":"H491","dJobICdNm":"[H491]철도 운송업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005588:1', '{"dJobCd":"K000005588","dJobCdSeq":"1","dJobNm":"관광통역안내원","workSum":"국내를 여행하는 외국인 관광객 또는 국외를 여행하는 내국인 관광객을 대상으로 관광지 등을 안내하고 여행에 필요한 정보와 서비스를 제공한다.","doWork":"여행 출발 전에 목적지 및 일정에 대한 예비조사를 실시하고 담당자와 협의한다. 예약된 외국인 관광객을 공항에서 영접한다. 명승지, 고적지 등의 관광지를 안내한다. 관광객을 대상으로 관광국가의 문화, 관광지, 역사에 대한 해설을 통해 관광객의 이해를 돕는다. 환전, 숙박시설, 교통편 등 입국에서 출국에 이르기까지 관광객의 일정에 관한 모든 편의를 제공한다. 내국인의 해외여행 시 동행하여 공항에서 수속업무를 일괄적으로 대행하고 관광지를 안내하며 필요시 통역업무를 수행한다. 현지에서 관광객에게 집합시간, 장소, 당일 일정 등을 확인하여 사전에 설명한다. 관광객에게 응급상황 발생 시 이에 대한 조치를 취한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"언어력|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"투어가이드, 투어컨덕터(TC), 해외여행인솔자, 관광통역안내사","connectJob":"관광통역안내사(러시아어), 관광통역안내사(말레이/인도네시아어), 관광통역안내사(베트남어), 관광통역안내사(독어), 관광통역안내사(불어), 관광통역안내사(스페인어), 관광통역안내사(아랍어), 관광통역안내사(영어), 관광통역안내사(이탈리아어), 관광통역안내사(일본어), 관광통역안내사(중국어), 관광통역안내사(태국어)","certLic":"관광통역안내사(러시아어),관광통역안내사(말레이/인도네시아어), 관광통역안내사(베트남어), 관광통역안내사(독어), 관광통역안내사(불어), 관광통역안내사(스페인어), 관광통역안내사(아랍어), 관광통역안내사(영어), 관광통역안내사(이탈리아어), 관광통역안내사(일본어), 관광통역안내사(중국어), 관광통역안내사(태국어)","dJobECd":"5213","dJobECdNm":"[5213]여행 안내원 및 해설사","dJobJCd":"4321","dJobJCdNm":"[4321]여가 및 관광 서비스 종사원","dJobICd":"N752","dJobICdNm":"[N752]여행사 및 기타 여행보조 서비스업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005557:1', '{"dJobCd":"K000005557","dJobCdSeq":"1","dJobNm":"국내여행안내원","workSum":"국내 여행을 하는 관광객들을 대상으로 명승지나 고적지를 안내 및 소개하고 여행에 필요한 각종 서비스를 제공한다.","doWork":"관광객에게 여행경로, 일정 등 관광에 필요한 전반적인 안내를 한다. 역사적 유물, 유적지 및 명소 등에 방문하여 여행지의 특성에 대하여 설명한다. 교통편, 숙박시설, 식당 등에 관한 예약 또는 예약확인을 위해 여행사와 상의한다. 개인 또는 단체 관광객을 수행 및 안내하며, 필요한 제반 서비스를 제공한다. 관광객에게 여행 시 필요한 장비사용에 대하여 조언한다. 관광객의 부상 시 응급조치를 한다. 예산집행에 따른 여행비용을 검토하고 정산한다. 여행 경로에 출입금지구역이 있을 때 출발에 앞서 출입허가를 받는다. 낚시, 등반 등의 전문 여행상품을 계획·조직하고, 행선지까지 참가자 및 필요 물품을 운송하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"언어력|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"국내관광안내원, 국내여행인솔자","certLic":"국내여행안내사","dJobECd":"5213","dJobECdNm":"[5213]여행 안내원 및 해설사","dJobJCd":"4321","dJobJCdNm":"[4321]여가 및 관광 서비스 종사원","dJobICd":"N752","dJobICdNm":"[N752]여행사 및 기타 여행보조 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003745:1', '{"dJobCd":"K000003745","dJobCdSeq":"1","dJobNm":"국제의료관광코디네이터","workSum":"한국에 방문한 외국인 환자 및 그 가족을 대상으로 의료관광 서비스를 설명하고 상품을 기획하며 의료관광을 안내하고 사후관리를 지원한다.","doWork":"의료관광에 대해 외국 환자 및 가족과 상담한다. 의료관광객의 진료에 적합한 의료기관을 연결한다. 의료관광 고객을 위한 공항영접 및 환송, 진료지원, 사후 관리 등을 한다. 의료관광과 관련하여 사고 예방 및 발생 후 관리 등 리스크 관리를 한다. 의료관광 상품을 기획한다. 의료관광과 관련된 마케팅 업무를 한다. 고객만족도 조사 등 고객관리를 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"언어력|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"의료관광코디네이터","certLic":"국제의료관광코디네이터","dJobECd":"5213","dJobECdNm":"[5213]여행 안내원 및 해설사","dJobJCd":"4321","dJobJCdNm":"[4321]여가 및 관광 서비스 종사원","dJobICd":"N752","dJobICdNm":"[N752]여행사 및 기타 여행보조 서비스업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005154:1', '{"dJobCd":"K000005154","dJobCdSeq":"1","dJobNm":"문화관광해설사","workSum":"관광객들에게 관광지에 대한 전문적인 해설을 제공한다.","doWork":"방문 목적이나 관심 분야, 연령층 등에 따른 다양한 관광객들에게 각 지역의 문화유적을 안내한다. 문화유적에 대한 관광객의 이해를 돕기 위해 가벼운 이야기 위주의 해설로부터 역사, 문화, 자연에 대한 전문적인 해설을 한다. 관광객들의 바람직한 관람예절과 건전한 관광문화를 유도한다. 국가유산을 비롯한 관광자원 및 주변 환경 보호를 위한 활동을 한다. 영어, 일어, 중국어 등을 통해 외국인 관광객의 우리 문화에 대한 정확한 이해를 돕기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"언어력|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"문화유산해설사, 국가유산해설사","connectJob":"박물관해설사","certLic":"관광통역안내사(러시아어), 관광통역안내사(말레이/인도네시아어), 관광통역안내사(베트남어), 관광통역안내사(독어), 관광통역안내사(불어), 관광통역안내사(스페인어), 관광통역안내사(아랍어), 관광통역안내사(영어), 관광통역안내사(이탈리아어), 관광통역안내사(일본어), 관광통역안내사(중국어), 관광통역안내사(태국어)","dJobECd":"5213","dJobECdNm":"[5213]여행 안내원 및 해설사","dJobJCd":"4321","dJobJCdNm":"[4321]여가 및 관광 서비스 종사원","dJobICd":"R902","dJobICdNm":"[R902]도서관, 사적지 및 유사 여가관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001527:1', '{"dJobCd":"K000001527","dJobCdSeq":"1","dJobNm":"사파리버스운전원","workSum":"동물원에서 사파리버스를 운전하며 관광객에게 동물들을 소개한다.","doWork":"안내차량을 이용하는 관광객의 탑승 및 하차를 안내한다. 버스를 운전하면서 미리 준비한 먹이를 이용하여 동물을 유인해 재주를 부릴 수 있도록 유도한다. 동물의 성향, 특징 등을 숙지하여 관광객에게 재치있게 동물에 대해 설명한다. 사파리 안내차량을 점검한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"오락제공","workFunc3":"조작운전","connectJob":"사파리관광을 위한 안내 등을 전문으로 하는 경우 사파리엔터테이너, 사파리관광안내원","dJobECd":"5213","dJobECdNm":"[5213]여행 안내원 및 해설사","dJobJCd":"4321","dJobJCdNm":"[4321]여가 및 관광 서비스 종사원","dJobICd":"R912","dJobICdNm":"[R912]유원지 및 기타 오락관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006846:1', '{"dJobCd":"K000006846","dJobCdSeq":"1","dJobNm":"숲길등산지도사","workSum":"등산 또는 트래킹을 안전하게 할 수 있도록 해설하거나 지도·교육한다.","doWork":"청소년, 기업체 등 대상과 등산, 트래킹 등 체험 목적에 맞춰 숲길체험 프로그램을 구성한다. 등산예절, 보행법, 스틱사용법 등 장비 사용법 및 등반기술을 교육한다. 배수로, 낙석, 도복목 정리 등 간단한 등산로 및 트레킹 길을 정비·관리한다. 위험구간 및 기상악화 시 안전사고 예방활동을 한다. 응급사고가 발생할 경우 산악구조대에 연락하고 응급처치 및 산악구조 활동을 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|손사용|","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"숲길체험지도사","connectJob":"숲해설사, 숲길지도사, 산림치유지도사","certLic":"산림교육전문가(숲길지도사)","dJobECd":"5213","dJobECdNm":"[5213]여행 안내원 및 해설사","dJobJCd":"4321","dJobJCdNm":"[4321]여가 및 관광 서비스 종사원","dJobICd":"R902","dJobICdNm":"[R902]도서관, 사적지 및 유사 여가관련 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006486:1', '{"dJobCd":"K000006486","dJobCdSeq":"1","dJobNm":"숲해설사","workSum":"휴양림, 수목원 등에서 탐방객들에게 자연생태 등을 설명하고 스스로 관찰할 수 있도록 도와준다.","doWork":"자연휴양림, 수목원, 자연생태공원 등을 찾아오는 탐방객들에게 숲과 자연생태, 자연과 인간과의 관계 등에 대해 설명을 해주는 일을 한다. 숲속에 사는 동식물과 곤충들이 자연과 사람에게 어떻게 영향을 주고받으며 관련을 맺는지를 설명해 준다. 자연에서 느낄 수 있는 상황들에 대해 알려주어 자연에서 동식물이나 곤충들을 스스로 찾아내어 관찰할 수 있도록 도와준다. 숲과 자연휴양림을 찾는 사람들에게 나무와 숲에 대한 올바른 이해와 효율적인 산림탐방활동 등을 도와준다. 산림 내에서의 산림휴양이나 자연체험활동 등에 대해 지도하는 일도 한다. 숲해설 대상자에 맞는 교재를 제작하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"언어력|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"숲생태해설원, 숲해설가","connectJob":"환경지도사, 생태해설사, 산림치유지도사, 숲길등산지도사","certLic":"산림교육전문가(숲해설사)","dJobECd":"5213","dJobECdNm":"[5213]여행 안내원 및 해설사","dJobJCd":"4321","dJobJCdNm":"[4321]여가 및 관광 서비스 종사원","dJobICd":"R902","dJobICdNm":"[R902]도서관, 사적지 및 유사 여가관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005812:1', '{"dJobCd":"K000005812","dJobCdSeq":"1","dJobNm":"여행안내원(일반)","workSum":"개인 또는 단체의 여행을 계획·조직하고 안내한다.","doWork":"여행 출발 전에 관광객의 신상 및 여행 목적 등을 파악한다. 여행 방문지에 대한 정보를 수집하고 숙박시설, 교통편 등의 모든 사항을 확인한다. 관광객들에게 여행일정에 대해 설명하고 관광지로 인솔한다. 관광지에 대한 역사와 문화 및 정보를 제공한다. 여행 중에 발생한 불의의 사고는 본사와 연락하여 신속하게 해결한다. 여행이 끝난 후 여행의 문제점 및 개선점을 확인하여 향후 관광기획에 참고한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"언어력|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"관광안내원","connectJob":"낚시안내원, 등반안내원, 고궁안내원, 화랑안내원, 박물관안내원","certLic":"국내여행안내사, 관광통역안내사(러시아어), 관광통역안내사(말레이/인도네시아어), 관광통역안내사(베트남어), 관광통역안내사(독어), 관광통역안내사(불어), 관광통역안내사(스페인어), 관광통역안내사(아랍어), 관광통역안내사(영어), 관광통역안내사(이탈리아어), 관광통역안내사(일본어), 관광통역안내사(중국어), 관광통역안내사(태국어)","dJobECd":"5213","dJobECdNm":"[5213]여행 안내원 및 해설사","dJobJCd":"4321","dJobJCdNm":"[4321]여가 및 관광 서비스 종사원","dJobICd":"N752","dJobICdNm":"[N752]여행사 및 기타 여행보조 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002293:1', '{"dJobCd":"K000002293","dJobCdSeq":"1","dJobNm":"유람선관광가이드","workSum":"유람선 이용객이 쾌적한 관광을 할 수 있도록 방송안내, 응대, 여흥진행 등 각종 서비스를 제공한다.","doWork":"방송기기의 이상 여부를 확인한다. 배선 스케줄을 보고 방송을 구상한다. 날씨, 안전 등 특이사항 등을 안내한다. 승선안내 및 접객을 한다. 선박이 출항하면 주변의 관광, 역사, 안전에 대한 우리말 및 외국어 방송서비스를 한다. 승객의 요구에 응대하고 각종 선내 서비스를 제공한다. 승객이 유람선 하선 시에 하선인사를 한다. 간단한 선내 오락시간을 주최하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workEnv":"위험내재|다습|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"5213","dJobECdNm":"[5213]여행 안내원 및 해설사","dJobJCd":"4321","dJobJCdNm":"[4321]여가 및 관광 서비스 종사원","dJobICd":"H501/H502","dJobICdNm":"[H501]해상 운송업 / [H502]내륙 수상 및 항만 내 운송업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006952:1', '{"dJobCd":"K000006952","dJobCdSeq":"1","dJobNm":"전문도슨트","workSum":"전시 작품에 대한 정보를 수집, 해석하여 미술관 및 박물관 관람객에게 해설한다.","doWork":"해설 대상 작품 및 작가 등에 대한 자료를 수집한다. 해설스크립트를 작성한다. 관람객의 수, 특성 등을 파악한다. 관람객에게 마이크를 사용하여 관람개요 및 작품의 배경, 주요 내용, 작가의 생애 등, 전시작품의 해설을 한다. 전시작품에 대한 질문을 받아 답변을 한다. 도슨트 관련 강의를 하거나 글을 쓰기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"전시해설가, 도슨트, 미술전시해설사, 박물관해설사","connectJob":"학예사, 큐레이터","dJobECd":"5213","dJobECdNm":"[5213]여행 안내원 및 해설사","dJobJCd":"4321","dJobJCdNm":"[4321]여가 및 관광 서비스 종사원","dJobICd":"R902","dJobICdNm":"[R902]도서관, 사적지 및 유사 여가관련 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007340:1', '{"dJobCd":"K000007340","dJobCdSeq":"1","dJobNm":"해외여행안내원","workSum":"해외여행을 하는 내국인 관광객을 대상으로 관광지의 문화, 역사 등을 안내하고, 해외여행에 필요한 각종 서비스를 제공한다.","doWork":"여행일정표에 따라 국내 관광객을 해외로 인솔하여 방문 관광지의 문화, 역사 등을 설명한다. 교통편, 숙박시설, 식당 등의 예약 또는 예약확인을 위해 여행사와 상의한다. 식사와 숙박 등 관광객과 여정을 함께 하고, 귀국할 때까지 관광일정의 편의를 위해 제반 서비스를 제공한다. 관광객의 부상 시 응급조치를 한다. 예산집행에 따른 여행비용을 검토하고 정산한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"언어력|","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"관련없음","similarNm":"투어가이드, 투어컨덕터(TC), 해외여행인솔자","certLic":"관광통역안내사(러시아어), 관광통역안내사(말레이/인도네시아어), 관광통역안내사(베트남어), 관광통역안내사(독어), 관광통역안내사(불어), 관광통역안내사(스페인어), 관광통역안내사(아랍어), 관광통역안내사(영어), 관광통역안내사(이탈리아어), 관광통역안내사(일본어), 관광통역안내사(중국어), 관광통역안내사(태국어)","dJobECd":"5213","dJobECdNm":"[5213]여행 안내원 및 해설사","dJobJCd":"4321","dJobJCdNm":"[4321]여가 및 관광 서비스 종사원","dJobICd":"N752","dJobICdNm":"[N752]여행사 및 기타 여행보조 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004049:1', '{"dJobCd":"K000004049","dJobCdSeq":"1","dJobNm":"발렛파킹원","workSum":"호텔, 레스토랑 등에서 고객의 차량을 대신 주차·출차하는 서비스를 제공한다.","doWork":"유니폼을 착용하고 지정된 장소에서 대기한다. 고객의 주차 요청을 접수한다. 고객의 신원과 차량번호, 차량 종류를 확인하고 차키를 받는다. 주차관리시스템 단말기에 차량번호를 입력하고 주차공간을 확인한 후 차량을 이동시켜 주차한다. 이동 및 주차 중에 사고(도난, 파손 등)가 발생하지 않도록 주의 및 예방한다. 주차된 차량의 차키에 차량번호를 부착하고 보관장소에 보관한다. 고객의 출차요청에 따라 주차장에서 승강장까지 차량을 이동시킨다. 고객의 신원 및 차량의 이상 여부를 확인하고 차량을 인계한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"시범후 30일 이하","workStrong":"가벼운 작업","workPlace":"실외","workFunc1":"관련없음","workFunc2":"서비스제공","workFunc3":"단순작업","certLic":"자동차운전면허","dJobECd":"5230","dJobECdNm":"[5230]숙박시설 서비스원","dJobJCd":"4322","dJobJCdNm":"[4322]숙박시설 서비스 종사원","dJobICd":"I551","dJobICdNm":"[I551]일반 및 생활 숙박시설 운영업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007042:1', '{"dJobCd":"K000007042","dJobCdSeq":"1","dJobNm":"숙박시설운영원","workSum":"관광객 대상의 민박사업을 기획하거나 직접 민박을 운영한다.","doWork":"도시지역에 거주하고 있는 주택을 이용하여 외국인 관광객에게 한국의 가정문화를 체험할 수 있도록 숙식 등을 제공한다. 한국문화와 전통을 소개하기 위하여 관광, 식문화 체험, 동행 프로그램 등의 체험 프로그램을 소개한다. 투숙객을 위하여 내부 청소, 침구류 관리를 하며 내부 시설 및 구조에 대한 설명을 한다. 숙박객 성향에 맞춰 여행 동선을 짜주거나 조식을 제공하기도 한다. 예약을 위한 부킹 에이전시에 숙박시설을 등재하고 사진을 업로드하거나 예약 관리를 한다. SNS 등을 통하여 숙박시설을 홍보하기도 한다. 주변 역이나 공항까지 픽업 서비스를 제공하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"한옥체험운영자","dJobECd":"5230","dJobECdNm":"[5230]숙박시설 서비스원","dJobJCd":"4322","dJobJCdNm":"[4322]숙박시설 서비스 종사원","dJobICd":"I551","dJobICdNm":"[I551]일반 및 생활 숙박시설 운영업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007704:1', '{"dJobCd":"K000007704","dJobCdSeq":"1","dJobNm":"하우스키핑인스펙터","workSum":"호텔 객실의 정비 상태 점검을 통해 판매 가능 여부를 판단하고 룸메이드의 객실 관리 상태를 확인‧지도한다.","doWork":"하우스키퍼(룸메이드)가 정비를 마친 객실을 방문하여 청결 상태, 침구 정리, 욕실 위생, 비품 비치 여부, 냄새 등 전반적인 상태를 점검한다. 호텔의 객실 관리 기준(SOP)에 따라 이상 여부를 확인하고, 문제 발견 시 정비 재요청 또는 현장 조치를 수행한다. 점검 완료 후 객실 운영 시스템(PMS 등)에 상태를 등록하여 판매 가능 여부를 반영하고, 프런트오피스와 정보를 공유한다. 룸메이드의 작업 품질을 확인하며, 기준에 미달한 경우 현장에서 개선 사항을 피드백하고 필요 시 방법을 지도한다. 객실과 연계된 복도나 서비스룸의 상태를 점검 중 함께 확인하기도 하며, 공용구역 전담 인력의 정기 점검을 보완하는 수준에서 수행된다. VIP 고객 객실이나 요청이 들어온 특수 객실의 점검을 우선적으로 수행하고, 특별 세팅 상태를 확인한다. 긴급 청소 요청(Express Cleaning 등)에 대응하기 위해 객실 상태를 우선 점검하고, 빠르게 투숙 가능 여부를 결정하기도 한다. 객실 정비 관련 이슈를 간단히 기록하거나, 품질관리 및 교육 자료로 활용하기 위한 보고서를 작성하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"웅크림|손사용|시각|","workFunc1":"수집","workFunc2":"감독","workFunc3":"관련없음","similarNm":"하우스키핑슈퍼바이저, 객실인스펙터","certLic":"호텔서비스사","dJobECd":"5230","dJobECdNm":"[5230]숙박시설 서비스원","dJobJCd":"4322","dJobJCdNm":"[4322]숙박시설 서비스 종사원","dJobICd":"I551","dJobICdNm":"[I551]일반 및 생활 숙박시설 운영업","inqYear":"2025"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005062:1', '{"dJobCd":"K000005062","dJobCdSeq":"1","dJobNm":"호텔도어맨","workSum":"호텔에 도착한 고객의 차량을 안내하고, 호텔 현관 주변의 차량소통이 원활하도록 관리한다.","doWork":"고객의 차량이 현관으로 들어오면 정차 위치를 안내하고 차가 정지하면 차량의 문을 열어 고객을 맞는다. 자동차 열쇠를 보관할 경우에는 열쇠를 받아 보관장소에 걸어 관리한다. 고객의 요청에 따라 고객의 차량을 주차하거나 택시를 호출한다. 현관 주변의 원활한 차량소통을 위해 주차를 통제한다. 호텔시설, 주변 관광지, 대중교통 이용 등을 고객에게 안내한다. 고객이 원할 경우 주차장에 대기 중인 고객차량이나 운전기사를 호출하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"단순작업","similarNm":"호텔발렛맨, 호텔차량관리원, Door Attendant","certLic":"호텔서비스사","dJobECd":"5230","dJobECdNm":"[5230]숙박시설 서비스원","dJobJCd":"4322","dJobJCdNm":"[4322]숙박시설 서비스 종사원","dJobICd":"I551","dJobICdNm":"[I551]일반 및 생활 숙박시설 운영업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006452:1', '{"dJobCd":"K000006452","dJobCdSeq":"1","dJobNm":"호텔벨맨","workSum":"호텔에 도착한 고객을 객실로 안내하고 호텔시설 등의 정보를 제공한다.","doWork":"단정한 복장을 갖추고 현관에서 대기한다. 고객이 현관에 도착하면 정중히 인사를 하고 고객의 짐을 받아들고 프런트(Front)로 안내한다. 배정된 고객의 객실 열쇠를 건네받아 고객을 해당 객실로 안내한다. 고객의 짐을 보관하거나 객실로 운반한다. 객실에 도착하면 문을 열고 실내등을 켠다. 고객의 짐을 정해진 위치에 놓고 고객에게 객실 내의 시설물, 호텔시설, 영업시간 등의 정보를 제공한다. 고객에게 전달할 메모, 우편물 등을 배달한다. 고객이 퇴실할 때 짐을 들어다 주거나 배웅하는 서비스를 제공한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"단순작업","similarNm":"포터","certLic":"호텔서비스사","dJobECd":"5230","dJobECdNm":"[5230]숙박시설 서비스원","dJobJCd":"4322","dJobJCdNm":"[4322]숙박시설 서비스 종사원","dJobICd":"I551","dJobICdNm":"[I551]일반 및 생활 숙박시설 운영업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007747:1', '{"dJobCd":"K000007747","dJobCdSeq":"1","dJobNm":"호텔연회코디네이터","workSum":"호텔 내 연회장에서 진행되는 각종 행사(연회‧이벤트 포함)의 목적과 성격에 따라 고객 요구를 반영한 운영 계획을 수립하고 관련 부서와 협의하여 행사가 원활히 진행되도록 조율한다.","doWork":"고객과 상담하여 행사 목적, 일정, 예상 인원, 예산, 행사 성격(웨딩, 기업 행사, 가족 연회 등)을 파악하고, 행사 운영에 필요한 기본 계획을 수립한다. 행사 유형에 따라 연회장 배치, 좌석 구성, 식음 제공 방식, 장비 사용(음향·조명·스크린 등) 등의 세부 사항을 기획하고, 필요시 견적 산출을 위한 정보를 영업 부서에 전달한다. 운영 계획을 식음팀, 조리부, 시설관리팀, 보안팀 등 관련 부서에 공유하고, 실행 가능 여부를 사전 협의한다. 행사 전 리허설 또는 현장 점검을 통해 장비 상태, 인력 배치, 고객 동선 등을 확인하고 조율한다. 행사 당일 현장에서 고객을 응대하며, 식음 서비스 흐름과 일정 진행 상황을 실시간으로 관리한다. 돌발상황 발생 시 관련 부서와 협력하여 신속하게 대응하고, 행사 품질을 유지하도록 조정한다. 행사 종료 후 고객의 의견을 청취하고, 필요 시 불만사항을 접수하여 관계 부서와 협력해 조치한다. 행사 종료 후 고객에게 간단한 피드백을 요청하거나 후속 상담을 안내하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"언어력|시각|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"연회기획담당자, 호텔이벤트코디네이터, 연회운영담당자","certLic":"호텔서비스사, 호텔관리사, 컨벤션기획사","dJobECd":"5230","dJobECdNm":"[5230]숙박시설 서비스원","dJobJCd":"4322","dJobJCdNm":"[4322]숙박시설 서비스 종사원","dJobICd":"I551","dJobICdNm":"[I551]일반 및 생활 숙박시설 운영업","inqYear":"2025"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005316:1', '{"dJobCd":"K000005316","dJobCdSeq":"1","dJobNm":"호텔컨시어지","workSum":"호텔을 방문한 고객이 필요로 하는 모든 서비스를 제공한다.","doWork":"호텔 투숙객의 짐을 들어주고, 호텔시설 이용정보를 제공하는 등 각종 문의사항에 응대한다. 관광지, 교통, 식당, 쇼핑 등 고객이 원하는 정보를 수집하여 안내한다. 고객의 요구사항을 해결하고 고객의 요청에 따라 항공기 등 교통편을 예약·확인하여 수속업무를 대행한다. 공연티켓 예약, 렌터카 및 리무진 예약 등을 대행한다. 벨맨 및 도어맨의 서비스를 감독하고 교육한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"서비스제공","workFunc3":"관련없음","similarNm":"GRO(Guest Relation Officer)","certLic":"호텔서비스사","dJobECd":"5230","dJobECdNm":"[5230]숙박시설 서비스원","dJobJCd":"4322","dJobJCdNm":"[4322]숙박시설 서비스 종사원","dJobICd":"I551","dJobICdNm":"[I551]일반 및 생활 숙박시설 운영업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006870:1', '{"dJobCd":"K000006870","dJobCdSeq":"1","dJobNm":"호텔프런트사무원","workSum":"호텔 프런트 데스크(Front Desk)에서 고객응접 업무를 수행한다.","doWork":"고객을 맞이하여 인사하고 환영한다. 전반적인 호텔의 정보를 고객에게 제공한다. 프런트 데스크 시스템(Front Desk System)을 사용하여 객실 예약을 확인한다. 예약된 리스트를 확인하고 투숙예정 고객의 객실배정 상황, 객실준비 상황을 확인하여 체크인(Check-in) 시 혼잡을 방지한다. 프런트 데스크 시스템에 숙박등록(고객의 주소, 성명, 직업, 여권번호, 체재기간, 객실종류, 객실요금, 객실번호, 서명 등)을 한다. 이용안내서(Welcome letter)를 준비하고 고객에게 교부한다. 선수금 현황을 파악하고 스키퍼(Skipper:객실료를 내지 않고 퇴실하는 행위)를 예방한다. 예약하지 않고 방문하는 고객(Walk-in 고객)에게 적절한 요금으로 객실을 판매한다. 객실배정(Room Assignment)을 효율적으로 조정·통제하여 객실 판매의 촉진, 고가객실 우선판매에 따른 매출 증진을 기한다. 체크아웃(Check-out) 업무를 수행한다. 기준을 초과한 고객의 고액 외상잔액 보고서(High Balance Report)를 작성하고 보고한다. 고객이 지불하는 이용요금을 정확히 처리한다. 고객에게 온 메모, 전달사항 등이 있으면 기록하고 고객에게 전달한다. 고객의 불편사항에 적극적으로 개입하여 해결한다. 고객의 항공편, 투어링 버스 등의 예약을 확인하고 필요시 안내한다. 귀중품 보관함을 운용한다. 영업일지를 작성하고 보관 및 보고한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"기록","workFunc2":"서비스제공","workFunc3":"관련없음","similarNm":"리셉션리스트(Receptionist)","dJobECd":"5230","dJobECdNm":"[5230]숙박시설 서비스원","dJobJCd":"4322","dJobJCdNm":"[4322]숙박시설 서비스 종사원","dJobICd":"I551","dJobICdNm":"[I551]일반 및 생활 숙박시설 운영업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003166:1', '{"dJobCd":"K000003166","dJobCdSeq":"1","dJobNm":"볼링설비조작원","workSum":"볼링핀을 자동으로 레인에 세우는 설비인 핀셋터(Pin Setters) 및 레인시스템 등을 조작·관리한다.","doWork":"프레임(Frame)이 끝난 레인을 확인하고 볼링핀을 다시 세우기 위하여 핀셋터(Pin Setters) 장비를 조작한다. 기계의 벨트에 물린 볼링핀을 빼내거나 파손된 부품을 교체한다. 레인시스템을 관리하며 유지·보수한다. 원활한 기계작동을 위해 작동부위에 윤활유를 주입한다. 엘리베이터 핀 가이드, 볼리프트, 각종 벨트, 기어오일 등을 정비·점검한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|손사용|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"5240","dJobECdNm":"[5240]오락시설 서비스원","dJobJCd":"4323","dJobJCdNm":"[4323]오락시설 서비스 종사원","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007047:1', '{"dJobCd":"K000007047","dJobCdSeq":"1","dJobNm":"스케이트얼음판관리원","workSum":"스케이트를 탈 수 있도록 얼음판을 만들고 관리하는 업무를 수행한다.","doWork":"순도가 높은 물을 데워 안개 상태로 냉각코일이 깔린 링크에 뿌려 일정 두께의 얼음을 만든다. 얼음판의 표면을 다듬기 위하여 정빙차를 이용하여 깨어지거나 부서진 얼음조각을 분쇄하여 모으고 급수밸브로 물을 뿌린 후 걸레질하여 마무리한다. 고객들의 질서를 유지하고 비수기 동안에 시설을 유지·관리한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"저온|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","similarNm":"정빙차운전원","dJobECd":"5240","dJobECdNm":"[5240]오락시설 서비스원","dJobJCd":"4323","dJobJCdNm":"[4323]오락시설 서비스 종사원","dJobICd":"R912","dJobICdNm":"[R912]유원지 및 기타 오락관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003254:1', '{"dJobCd":"K000003254","dJobCdSeq":"1","dJobNm":"오락용승차기구보조원","workSum":"오락용승차기구조작원의 보조 업무를 수행한다.","doWork":"놀이기구 주변을 청소한다. 손님 입장 시 검표 업무를 본다. 놀이기구 운행 전에 안전장치에 대한 착용을 안내하고 확인한다. 놀이기구가 작동을 멈추고 손님들이 내리면 출구를 안내하고 손님들이 다 빠져나가기 전까지 입장 고객들을 대기시킨다. 놀이기구 운전 중 소지품 분실 우려가 있으므로 손님들의 소지품을 보관하여 준다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"시범후 30일 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"수동조작","connectJob":"디스코팡팡조작원","dJobECd":"5240","dJobECdNm":"[5240]오락시설 서비스원","dJobJCd":"4323","dJobJCdNm":"[4323]오락시설 서비스 종사원","dJobICd":"R912","dJobICdNm":"[R912]유원지 및 기타 오락관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002303:1', '{"dJobCd":"K000002303","dJobCdSeq":"1","dJobNm":"오락용승차기구조작원","workSum":"유원지, 오락장 또는 기타 여흥장소에 설치된 오락용 승차기구를 조작하거나 고객에게 운전방법을 알려준다.","doWork":"벨트나 빗장 등의 안전장치에 대하여 설명·착용을 의무화한다. 각종 오락기구의 조정장치를 조작, 승차기구를 출발 또는 정지시킨다. 고객이 승차기구를 운전할 수 있도록 전원스위치를 올리고 일정 시간이 지나면 스위치를 내린다. 승차기구에 주유, 연료공급, 축전지 교환 등의 정비와 수리를 한다. 안전사고 방지를 위해 운행종료 후 기구를 점검·시험한다. 정원초과를 금지하고 안전벨트나 빗장의 안전상태를 관찰하며 충돌의 위험을 막기 위하여 승차기구들의 시간적·공간적 간격을 조정하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"손사용|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"조작하거나 취급하는 기구에 따라 바이킹조작원, 궤도열차조작원, 허니문카조작원, 회전목마조작원, 회전열차조작원, 스카이팡팡조작원, 디스코팡팡디제이","dJobECd":"5240","dJobECdNm":"[5240]오락시설 서비스원","dJobJCd":"4323","dJobJCdNm":"[4323]오락시설 서비스 종사원","dJobICd":"R912","dJobICdNm":"[R912]유원지 및 기타 오락관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003536:1', '{"dJobCd":"K000003536","dJobCdSeq":"1","dJobNm":"오락장서비스원","workSum":"경기장, 유기장, 유원지, 도박장, 전망대 등과 운동설비를 갖춘 장소 등에서 편의와 안전유지 업무를 수행한다.","doWork":"고객의 질서를 위하여 줄을 서도록 유도한다. 고객의 물품을 보관한다. 휴게실, 화장실, 공중전화 등의 위치를 알려준다. 고객이 이용하기 위한 유기시설이나 운동시설 등의 순서를 정하고 순서를 기다리도록 권한다. 승차기구를 이용하는 고객의 안전을 위하여 안전벨트나 빗장을 채워준다. 안내 소책자를 배부하고 설명한다. 오락이나 게임의 방법, 규칙 등에 대하여 개략적인 설명을 한다. 오락설비, 운동장비, 비품 등을 관리하고 간단한 수리를 한다. 고객의 이용접수를 받고 인원을 확인하며 이용장소를 배정한다. 점수기록 시스템을 조작한다. 이용요금을 계산하여 수납한다. 동전으로 운영되는 놀이시설을 위해서 동전으로 환전해준다. 안내방송을 접수하여 장내아나운서가 안내방송을 할 수 있도록 알려준다. 분실물이나 습득물을 접수한다. 고객 불편사항을 접수하고 접수사항 기록을 유지하며 시정조치하기 위하여 해당 부서에 통보한다. 오락장비나 운동용품을 대여하는 오락장비대여원의 일을 하기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"직무를 수행하는 장소에 따라 경기장종사원, 골프장종사원, 기원종사원, 당구장종사원, 도박장종사원, 롤러스케이트장종사원, 볼링장종사원, 사격장종사원, 수영장종사원, 스케이트장종사원, 스키장종사원, 유원지종사원, 전망대종사원, 정구장종사원, 체육관종사원, 케이블카종사원, 탁구장종사원, 스카이팡팡디제이","dJobECd":"5240","dJobECdNm":"[5240]오락시설 서비스원","dJobJCd":"4323","dJobJCdNm":"[4323]오락시설 서비스 종사원","dJobICd":"R912","dJobICdNm":"[R912]유원지 및 기타 오락관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007309:1', '{"dJobCd":"K000007309","dJobCdSeq":"1","dJobNm":"케이블카안내원","workSum":"케이블카를 이용하는 승객의 탑승을 유도하고 안내한다.","doWork":"케이블카를 이용하는 승객의 탑승을 확인한다. 케이블카에 함께 탑승하여 안쪽의 이중문을 개폐한다. 승객 안전에 관한 유의사항 및 비상시 대처방안 등이 녹음되어 있는 안내방송장치를 조작한다. 승객의 질문에 답변하고 케이블카 내의 청결을 유지한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"관련없음","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"5240","dJobECdNm":"[5240]오락시설 서비스원","dJobJCd":"4323","dJobJCdNm":"[4323]오락시설 서비스 종사원","dJobICd":"H492","dJobICdNm":"[H492]육상 여객 운송업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005261:1', '{"dJobCd":"K000005261","dJobCdSeq":"1","dJobNm":"피씨(PC)방관리원","workSum":"PC방에서 고객을 응대하고 매장을 관리한다.","doWork":"PC방 계산대에서 고객을 맞이하고 회원 및 비회원을 구분하여 사용요금 정산카드를 발급한다. 고객의 흡연 여부에 따라 흡연 및 비흡연 좌석으로 안내한다. PC사용 및 매장의 서비스를 원활히 사용할 수 있도록 한다. 고객의 불편사항에 대해 좌석의 이동, PC 프로그램의 재설치 등의 조치를 취한다. 사용요금을 정산하고 요금을 받는다. 사용이 종료된 좌석 및 매장을 청소한다. 매장 내에서 판매하는 커피, 음료수, 과자, 용기라면 등의 재고를 파악하고 이용에 불편함이 없도록 관리한다. 고장 난 PC, 파손된 의자, 헤드폰, 마우스 등을 파악하여 교체하거나 수리를 의뢰한다. 냉난방 시설 및 환기시설을 조절한다. 근무시간이 종료되면 근무 중 매출액을 정산하고 다음 근무자에게 인계한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"관련없음","dJobECd":"5240","dJobECdNm":"[5240]오락시설 서비스원","dJobJCd":"4323","dJobJCdNm":"[4323]오락시설 서비스 종사원","dJobICd":"R912","dJobICdNm":"[R912]유원지 및 기타 오락관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006715:1', '{"dJobCd":"K000006715","dJobCdSeq":"1","dJobNm":"경기장전광판조작원","workSum":"운동경기의 득점상황, 시간, 경기내용 등을 관중에게 알리기 위하여 컴퓨터 등을 조작하여 관련 내용을 전광판에 표시한다.","doWork":"경기 진행상황이나 경기장 내의 상황을 파악한다. 심판이나 운동경기기록원의 신호를 확인한 후 컴퓨터 등을 조작하여 전광판에 점수나 각종 영상을 표시한다. 시계를 작동하여 시간의 진행을 알리기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"청각|시각|","workFunc1":"기록","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"4209","dJobECdNm":"[4209]기타 스포츠 및 여가서비스 종사원","dJobJCd":"4329","dJobJCdNm":"[4329]기타 여가 서비스 종사원","dJobICd":"R912","dJobICdNm":"[R912]유원지 및 기타 오락관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004909:1', '{"dJobCd":"K000004909","dJobCdSeq":"1","dJobNm":"골프경기진행자","workSum":"골프장에서 여러 팀의 고객들이 경기를 원활히 진행할 수 있도록 경기 진행상황과 속도를 조종한다.","doWork":"예약자를 확인하고 예약 순서에 맞춰 일정한 시차를 두고 경기를 진행시킨다. 경기 지연을 방지하기 위해 카트를 타고 순찰하며 지연되는 고객에게 진행속도를 맞출 수 있도록 독려한다. 무전기를 이용하여 경기 진행상황을 통보한다. 안전사고 발생 시 응급조치를 하고 응급실에 통보한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"단순작업","dJobECd":"4209","dJobECdNm":"[4209]기타 스포츠 및 여가서비스 종사원","dJobJCd":"4329","dJobJCdNm":"[4329]기타 여가 서비스 종사원","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003849:1', '{"dJobCd":"K000003849","dJobCdSeq":"1","dJobNm":"골프장캐디","workSum":"골프장에서 고객이 원활한 경기를 할 수 있도록 도와주고 골프백을 운반하거나 카트를 이동시킨다.","doWork":"고객의 골프백을 카트에 싣고 경기 중인 고객을 따라다니며 용도에 맞는 골프채를 건네준다. 코스의 특징을 설명한다. 공을 칠 방향 및 거리에 대하여 조언한다. 흙주머니를 가지고 다니며 경기로 인해 손상된 잔디 위에 붓고 다진다. 골프공 또는 골프채의 이물질을 털어준다. 경기 전·후에 골프채의 개수를 확인하여 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실외","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"단순작업","similarNm":"캐디","dJobECd":"4209","dJobECdNm":"[4209]기타 스포츠 및 여가서비스 종사원","dJobJCd":"4329","dJobJCdNm":"[4329]기타 여가 서비스 종사원","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004478:1', '{"dJobCd":"K000004478","dJobCdSeq":"1","dJobNm":"마리나운영원","workSum":"마리나 시설을 유지·관리하고 이용 선박에 접안, 계류 등 관련 서비스를 제공한다.","doWork":"마리나 시설(스포츠 또는 레크리에이션용 요트, 모터보트 등의 선박을 위한 항구)의 선석 배정 현황을 관리한다. 선석 예약 및 연·월간 이용계약을 체결하고 등록·관리하여 가용선석을 효율적으로 운영한다. 선박의 이안 및 접안을 통제한다. 폰툰(Pontoon:선석을 이루는 부유구조물) 및 계류장에서 주유, 전기충전, 급수, 소모품 공급 등 관련 서비스를 제공한다. 상·하가시설을 운영하여 선박을 육지로 끌어올리거나 육지의 선박을 물에 내린다. 선박보관시설, 상·하가시설, 급유시설, 전기시설, 선박작업용 시설 등 관련 시설의 환경·출입·보안을 유지·관리한다. 재해 및 비상시 관련 지침에 따라 대응한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실외","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"4209","dJobECdNm":"[4209]기타 스포츠 및 여가서비스 종사원","dJobJCd":"4329","dJobJCdNm":"[4329]기타 여가 서비스 종사원","dJobICd":"R912","dJobICdNm":"[R912]유원지 및 기타 오락관련 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;