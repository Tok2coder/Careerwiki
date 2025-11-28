INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005036:1', '{"dJobCd":"K000005036","dJobCdSeq":"1","dJobNm":"항공기운항정비사","workSum":"항공기 운항 중에 발생할 수 있는 위험요인을 제거하기 위해 비행 전·후 주기적으로 항공기를 점검·정비한다.","doWork":"항공 일정 및 운항시간 등을 확인한다. 주기장에서 비행 전·후의 항공기를 대상으로 검사장비를 이용하거나 육안으로 기체부분의 변형 및 파손, 부식상태 등을 점검한다. 점검 카드 목록에 따라 전기, 보기 계통을 점검하고, 항공기에 장착되어 있는 기관의 작동상태를 정비한다. 오일 및 공압류의 유출 등 이상이 없는지 확인하고 이상 발견 시 원인을 찾고 수리한다. 부품을 점검하고 교환주기를 확인하여 사용 수명이 완료된 부품을 교체한다. 신종 항공기 기술정보, 안전운항 규정 등의 교육을 이수한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"청각|손사용|시각|","workEnv":"소음·진동|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"항공정비사, 항공기정비원, 고정익정비사, 항공기운용기술자","connectJob":"헬리콥터정비원(회전익정비사), 항공기체정비원, 항공기관정비원, 항공장비정비원, 항공전자정비원","certLic":"항공정비사, 항공기정비기능사,  항공산업기사, 항공전기전자정비기능사","dJobECd":"8121","dJobECdNm":"[8121]항공기 정비원","dJobJCd":"7521","dJobJCdNm":"[7521]항공기 정비원","dJobICd":"H511/H512","dJobICdNm":"[H511]항공 여객 운송업 / [H512]항공 화물 운송업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001709:1', '{"dJobCd":"K000001709","dJobCdSeq":"1","dJobNm":"항공기제트엔진정비사","workSum":"비행기의 제트엔진(Jet Engine)의 정비·수리·개조가 정해진 절차대로 이루어졌는지 확인한 후 작업결과를 기록한다.","doWork":"비행기의 제트엔진을 분해하기 전에 외관상의 이상 유무와 보조기기 등을 점검해 상태를 기록한다. 엔진 구성품을 엔진으로부터 하나씩 분해할 때 정해진 작업 절차를 따르는지 확인한다. 하나씩 분해된 엔진 구성품의 청결상태를 점검한 후, 필요시 세척작업을 하기도 한다. 각종 검사(육안검사, 정밀측정기기검사, 비파괴검사 등)를 실시해 이상이 있는 구성품의 정비·수리·교체 등을 지시하고 그 결과를 검사카드에 기록한다. 정비·수리·교체된 구성품들을 정해진 조립절차에 따라 조립하는지 점검하고 확인한다. 조립된 제트엔진을 시운전하여 합격 여부를 판정한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"청각|손사용|시각|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"분석","workFunc2":"교육","workFunc3":"정밀작업","similarNm":"제트엔진검사원","certLic":"항공산업기사, 항공정비사, 항공기사","dJobECd":"8121","dJobECdNm":"[8121]항공기 정비원","dJobJCd":"7521","dJobJCdNm":"[7521]항공기 정비원","dJobICd":"C313","dJobICdNm":"[C313]항공기, 우주선 및 부품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002715:1', '{"dJobCd":"K000002715","dJobCdSeq":"1","dJobNm":"레저선박선체정비원","workSum":"요트나 레저보트의 선체를 각종 공구를 사용하여 정비하고 수리한다.","doWork":"요트나 레저보트 등 파손된 레저선박 선체의 수리부위를 확인한다. 선체 종류(FRP, 알루미늄 등) 및 파손부위나 파손정도에 따라 수리방식을 결정한다. FRP보트의 경우 파손부위를 겔코트(Gelcoat)로 메꾸거나 덧바르고 경우에 따라 파손부위에 유리섬유와 경화제를 적층하여 수리하고 도장하여 마무리한다. 알루미늄 선체의 경우 파손부위에 보강용접을 하고 도장작업을 실시한다. 필요에 따라 선체를 수상에서 건져내어 선체 하부를 청소하고 수면 아래 부분 보호를 위한 보호층 형성작업(Anti-fouling:안티 파울링)을 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"선체정비테크니션","dJobECd":"8122","dJobECdNm":"[8122]선박 정비원","dJobJCd":"7522","dJobJCdNm":"[7522]선박 정비원","dJobICd":"C311","dJobICdNm":"[C311]선박 및 보트 건조업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002643:1', '{"dJobCd":"K000002643","dJobCdSeq":"1","dJobNm":"레저선박엔진정비원","workSum":"요트나 레저보트의 엔진(선외기, 선내기)를 각종 공구를 사용하여 정비하고 수리한다.","doWork":"대형 요트나 보트의 내부에 장착된 엔진(선내기) 또는 소형 보트나 고무보트의 외부에 장착된 엔진(선외기)을 정비하고 수리한다. 엔진을 분리하여 수리가 필요한 부분을 파악한다. 스파크 플러그를 점검하고 정비하거나 교체한다. 연료탱크의 필터와 연료탱크를 세척하거나 기어오일을 교환하기도 한다. 프로펠러를 점검하고 금이 가거나 파손된 경우 교체하고 미세한 손상은 수리하고 도장을 한다. 임펠러, 샤프트 축 등 엔진 주요부위에 대한 점검 및 정비를 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"해상엔진테크니션","certLic":"기계정비기능사, 기계정비산업기사, 동력기계정비기능사","dJobECd":"8122","dJobECdNm":"[8122]선박 정비원","dJobJCd":"7522","dJobJCdNm":"[7522]선박 정비원","dJobICd":"C311","dJobICdNm":"[C311]선박 및 보트 건조업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002166:1', '{"dJobCd":"K000002166","dJobCdSeq":"1","dJobNm":"선박기관정비원","workSum":"고객, 검사기관 또는 관련 법규에 따라 선박기관계통의 기기 및 장비를 정비한다.","doWork":"정비할 선박의 제원, 설계도, 정비이력카드, 검사 관련 규정 등을 파악한다. 정비범위, 요구품질, 공사기간 등을 반영하여 정비계획서를 작성한다. 정비에 필요한 자재목록을 작성하고 발주, 입고검사, 보관, 운반한다. 주기관, 보조기관, 발전기관, 동력전달장치(감속기, 축계, 추진장치 등), 외부연소장치(보일러, 소각기 등), 압력용기(열교환기, 조수기 등), 냉동공조기기, 유압기기, 공압기기, 유체기기(펌프, 침, 팬), 처리설비(청정기, 분뇨처리장치, 유수분리기 등) 등을 수리, 설치, 철거, 교체한다. 관련 규정이나 법규에 따라 시험검사를 하고 검사결과를 기록한다. 완공사양서, 정비이력서를 작성하고 정비품을 인도한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"균형감각|손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"선박엔진정비원","certLic":"동력기계정비기능사","dJobECd":"8122","dJobECdNm":"[8122]선박 정비원","dJobJCd":"7522","dJobJCdNm":"[7522]선박 정비원","dJobICd":"C311","dJobICdNm":"[C311]선박 및 보트 건조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001469:1', '{"dJobCd":"K000001469","dJobCdSeq":"1","dJobNm":"선박배관정비원","workSum":"고객, 검사기관 또는 관련 법규에 따라 선박배관을 철거, 제작, 도장, 조립하여 기능을 복구·유지한다.","doWork":"정비할 선박의 제원, 설계도, 정비이력카드, 검사 관련 규정 등을 파악한다. 정비범위, 요구품질, 공사기간 등을 반영하여 정비계획서를 작성한다. 정비에 필요한 자재목록을 작성하고 발주, 입고검사, 보관, 운반한다. 배관 및 관 부착품(계기류, 센서류, 밸브, 관, 보온재, 방열재 등)을 철거한다. 배관을 재단, 용접, 형취(도면에 준하지 않고 현장에서 현물에 맞추어 설치)하여 배관 부분품을 제작한다. 제작된 부분품을 운반, 거치, 조립, 취부한다. 밸브 등 부착품을 정비하고 조립한다. 관련 규정이나 법규에 따라 시험검사를 하고 검사결과를 기록한다. 완공사양서, 정비이력서를 작성하고 정비품을 인도한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"균형감각|손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"용접기능사","dJobECd":"8122","dJobECdNm":"[8122]선박 정비원","dJobJCd":"7522","dJobJCdNm":"[7522]선박 정비원","dJobICd":"C311","dJobICdNm":"[C311]선박 및 보트 건조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003772:1', '{"dJobCd":"K000003772","dJobCdSeq":"1","dJobNm":"선박의장정비원","workSum":"고객, 검사기관 또는 관련 법규에 따라 선박의장품을 정비한다.","doWork":"정비할 선박의 제원, 설계도, 정비이력카드, 검사 관련 규정 등을 파악한다. 정비범위, 요구품질, 공사기간 등을 반영하여 정비계획서를 작성한다. 정비에 필요한 자재목록을 작성하고 발주, 입고검사, 보관, 운반한다. 철의장품을 철거, 가공, 조립, 취부 및 용접한다. 하역장비, 구명설비, 계선·계류장치(앵커, 앵커체인 등), 화재안전설비, 목의장품을 점검·수리하고 부품을 교환한다. 관련 규정이나 법규에 따라 시험검사를 하고 검사결과를 기록한다. 완공사양서, 정비이력서를 작성하고 정비품을 인도한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"균형감각|손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"전파전자통신기능사, 전파전자통신산업기사, 무선설비기능사, 무선설비산업기사","dJobECd":"8122","dJobECdNm":"[8122]선박 정비원","dJobJCd":"7522","dJobJCdNm":"[7522]선박 정비원","dJobICd":"C311","dJobICdNm":"[C311]선박 및 보트 건조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002647:1', '{"dJobCd":"K000002647","dJobCdSeq":"1","dJobNm":"선박전장정비원","workSum":"고객, 검사기관 또는 관련 법규에 따라 선박의 전기·전자 장비를 정비한다.","doWork":"정비할 선박의 제원, 설계도, 정비이력카드, 검사 관련 규정 등을 파악한다. 정비범위, 요구품질, 공사기간 등을 반영하여 정비계획서를 작성한다. 정비에 필요한 자재목록을 작성하고 발주, 입고검사, 보관, 운반한다. 전원장치(발전기, 배전반, 변압기, 축전기 등), 동력장치(전동기, 변압기, 계전기, 계류기, 스위치 등), 조명장치(선내 조명, 항해등, 탐조등 등), 전로설비(케이블, 접속반 등), 제어·감시장치(경보장치, 안전장치, 모니터링장치 등), 항해·통신장비, 어로장비(어군탐지기 등)을 수리, 설치, 철거, 교체한다. 관련 규정이나 법규에 따라 시험검사를 하고 검사결과를 기록한다. 완공사양서, 정비이력서를 작성하고 정비품을 인도한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"균형감각|손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"전파전자통신기능사, 전파전자통신산업기사, 전파전자통신기사, 무선설비기능사, 무선설비산업기사","dJobECd":"8122","dJobECdNm":"[8122]선박 정비원","dJobJCd":"7522","dJobJCdNm":"[7522]선박 정비원","dJobICd":"C311","dJobICdNm":"[C311]선박 및 보트 건조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002752:1', '{"dJobCd":"K000002752","dJobCdSeq":"1","dJobNm":"선체정비원","workSum":"고객, 검사기관 또는 관련 법규에 따라 선체를 점검, 수리, 시험·검사 한다.","doWork":"정비할 선박의 제원, 설계도, 정비이력카드, 검사 관련 규정 등을 파악한다. 정비범위, 요구품질, 공사기간 등을 반영하여 정비계획서를 작성한다. 정비에 필요한 자재목록을 작성하고 발주, 입고검사, 보관, 운반한다. 비계(飛階:Scaffold)를 설치한다. 선체의 손상 및 마모된 부분을 제거한다. 부재를 취부하고 용접한다. 작업부분의 오염물을 제거하고 도장한다. 관련 규정이나 법규에 따라 시험검사를 하고 검사결과를 기록한다. 완공사양서, 정비이력서를 작성하고 정비품을 인도한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"균형감각|손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"용접기능사, 선체건조기능사","dJobECd":"8122","dJobECdNm":"[8122]선박 정비원","dJobJCd":"7522","dJobJCdNm":"[7522]선박 정비원","dJobICd":"C311","dJobICdNm":"[C311]선박 및 보트 건조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001586:1', '{"dJobCd":"K000001586","dJobCdSeq":"1","dJobNm":"수상레저기구정비원","workSum":"보트, 요트 등 수리가 필요한 수상레저기구를 점검, 수리한다.","doWork":"수리할 수상레저기구의 설계도 및 검사 관련 규정을 확인한다. 의뢰자와 면담을 통해 정비범위와 요구품질을 확인한다. 수상레저기구의 손상된 부위 및 오염부위를 제거하고 부속품을 사용하여 수리한다. 부속품이 없는 경우 부속품을 청구하기도 한다. 수리가 완료된 수상레저기구를 시험하고 검사결과를 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"8122","dJobECdNm":"[8122]선박 정비원","dJobJCd":"7522","dJobJCdNm":"[7522]선박 정비원","dJobICd":"C311","dJobICdNm":"[C311]선박 및 보트 건조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003465:1', '{"dJobCd":"K000003465","dJobCdSeq":"1","dJobNm":"준설선내연기관수리원","workSum":"준설선 등의 해상장비에 설치된 주기관, 발전기, 냉동기, 공기조화기, 유압기기 등의 내연기관을 수리, 정비, 분해, 점검, 조정한다.","doWork":"기관고장 시 각종 계기류의 작동상황에 따라 회전속도의 변동, 이상진동, 이상음의 발생, 온도, 배기색의 변동, 연료, 윤활유의 소비량 등을 점검한다. 기관고장 시 고장기관을 해체하여 파손·마모부분을 수리하며, 수리가 불가능할 경우 신품과 교환한다. 압력계의 변동에 주의하여 기동용 축압기가 부족할 경우 누설원인을 조사·수리하고, 보충하여 항상 필요한 압력이 유지되도록 한다. 기관 각 부분을 청소하며 재조립하여 시운전을 하고 조정한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"청각|","workEnv":"대기환경미흡|고온|다습|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"동력기계정비기능사, 조선산업기사","dJobECd":"8122","dJobECdNm":"[8122]선박 정비원","dJobJCd":"7522","dJobJCdNm":"[7522]선박 정비원","dJobICd":"F426","dJobICdNm":"[F426]건설장비 운영업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002143:1', '{"dJobCd":"K000002143","dJobCdSeq":"1","dJobNm":"고속철도차량유지보수원","workSum":"고속철도차량을 최적기능 상태로 유지시켜 효율적으로 운행하기 위하여 고속철도차량의 사전고장예측, 사후고장보수 등을 하며 작업표준을 수립한다.","doWork":"작업표준규격에 따라 고장진단 장비를 점검하고 작동 여부를 확인한다. 작업표준의 순서에 따라 점검, 시험, 조정, 교환 등의 예방·유지·보수 등의 활동을 통하여 사용 중의 고장을 미연에 방지한다. 제동장치, 전자, 기기 등의 부품결함에서 발생되는 고장과 건널목사고 또는 열차추돌 등의 불규칙한 사고 및 고장을 신속히 보수하는 사후 유지보수를 한다. 자료를 분석하여 고장징후를 파악하고 사전 예방적 조치를 취한다. 고장부분이 다른 기기에 영향을 주지 못하게 기능적, 물리적인 부분까지 확인하여 시험한다. 각 부품의 잠재수명을 관리한다. 고장교체부품의 소요량을 예측하여 교체비용예산을 수립한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"고속철도기계및차체정비유지보수원, 고속철도전기장치유지보수원","certLic":"철도차량정비기능장, 철도차량정비기능사","dJobECd":"8123","dJobECdNm":"[8123]철도기관차·전동차 정비원","dJobJCd":"7523","dJobJCdNm":"[7523]철도 기관차 및 전동차 정비원","dJobICd":"C312","dJobICdNm":"[C312]철도장비 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002105:1', '{"dJobCd":"K000002105","dJobCdSeq":"1","dJobNm":"기관차기관정비원","workSum":"디젤기관차 기관장치의 정기검수 및 일상검수를 시행하며 그에 필요한 부대업무를 수행한다.","doWork":"디젤기관차 검수 규정에 의거하여 주기적으로 기관장치 부품의 불량 여부를 점검하고 수리 및 교환한다. 디젤기관차 기관장치의 필터(Filter)류와 같은 소모품, 윤활유 등을 규정에 의거하여 정기적으로 교환한다. 디젤기관차의 기관장치를 청소한다. 운행을 마치고 입고된 디젤기관차의 검수는 검수규정 항목에 따라 일반적인 기관장치의 상태를 점검하며 불량 시 수리·교환한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|청각|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"기관차기관검수원, 기관차엔진정비원","certLic":"철도차량정비기능사","dJobECd":"8123","dJobECdNm":"[8123]철도기관차·전동차 정비원","dJobJCd":"7523","dJobJCdNm":"[7523]철도 기관차 및 전동차 정비원","dJobICd":"H491","dJobICdNm":"[H491]철도 운송업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004692:1', '{"dJobCd":"K000004692","dJobCdSeq":"1","dJobNm":"기관차정비반장","workSum":"열차의 안전운행에 지장이 없도록 구조상의 결점 및 성능을 검사·정비하는 작업원들의 활동을 감독·조정한다.","doWork":"열차운행에 지장이 없도록 열차운행계획표와 검수계획을 기초로 검수일정을 세우고 검수인원을 확보·조정한다. 검수에 필요한 공구, 계기 및 부품의 입·출고를 확인한다. 검수가 완료된 철도차량을 시험 운전하여 상태를 점검하고 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"청각|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","certLic":"철도차량정비기능사, 철도차량정비기능장","dJobECd":"8123","dJobECdNm":"[8123]철도기관차·전동차 정비원","dJobJCd":"7523","dJobJCdNm":"[7523]철도 기관차 및 전동차 정비원","dJobICd":"H491","dJobICdNm":"[H491]철도 운송업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002966:1', '{"dJobCd":"K000002966","dJobCdSeq":"1","dJobNm":"열차검수승무원","workSum":"운행 중인 여객열차의 엔진 및 보조발전기, 객실 내 설비 등을 점검하고 운행 중 차량고장 시 응급조치한다.","doWork":"엔진 및 보조발전기, 냉난방장치, 변속기, 감속기, 연결기 등 열차의 각종 설비기능이 원활하게 작동되는지 점검한다. 객실을 순찰하면서 기기의 작동상태를 점검하고, 승객의 안락한 여행을 위해 냉난방장치 및 전등시설을 조작한다. 열차편성에 따른 제어기능 상태를 점검하고 조치한다. 기관실 내 화재발생을 감시 및 예방조치하며, 차량고장 등 긴급사항 발생 시 조치를 취한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"철도차량정비기능사, 철도차량정비기능장","dJobECd":"8123","dJobECdNm":"[8123]철도기관차·전동차 정비원","dJobJCd":"7523","dJobJCdNm":"[7523]철도 기관차 및 전동차 정비원","dJobICd":"H491","dJobICdNm":"[H491]철도 운송업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006618:1', '{"dJobCd":"K000006618","dJobCdSeq":"1","dJobNm":"전동차부품정비원","workSum":"판타그라프(집전장치)와 주회로, 실내장치, 보조기기 등에 대한 정비업무를 수행한다.","doWork":"판타그라프의 구조 및 동작성능을 검사한다. 주 퓨즈 및 피뢰기의 검사 및 정비를 수행한다. 각 연결 파이프 및 편동선을 청소한다. 주회로에 관련된 부품의 수리 및 정비업무를 수행한다. 보조기기 관련 부품의 수리 및 정비업무를 수행한다. 방송장치와 배터리, 각종 계전기, ATC장치(자동열차제어장치) 등을 점검·수리한다. 카드화된 전자부품을 정비한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"철도차량정비기능사, 철도차량산업기사, 철도차량정비기능장","dJobECd":"8123","dJobECdNm":"[8123]철도기관차·전동차 정비원","dJobJCd":"7523","dJobJCdNm":"[7523]철도 기관차 및 전동차 정비원","dJobICd":"H492","dJobICdNm":"[H492]육상 여객 운송업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003796:1', '{"dJobCd":"K000003796","dJobCdSeq":"1","dJobNm":"전동차입출창검사원","workSum":"전동차의 정기 및 비정기적 검사 시 입창 및 출창 검사를 수행한다.","doWork":"검사를 위해 입환된 전동차를 대차와 실내, 자동검차장치로 나누어 입창검사를 실시한다. E/C카드를 확인하여 수리한다. 자동검차장치를 집중적으로 확인 검사하고 고장 발견 시 이를 수리한다. 중수선 검사 및 인수검사작업을 완료했을 때 차량 각부에 대한 성능시험을 위하여 실시하는 시운전에 협조한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"철도차량정비기능사, 철도차량산업기사, 철도차량정비기능장","dJobECd":"8123","dJobECdNm":"[8123]철도기관차·전동차 정비원","dJobJCd":"7523","dJobJCdNm":"[7523]철도 기관차 및 전동차 정비원","dJobICd":"H492","dJobICdNm":"[H492]육상 여객 운송업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002536:1', '{"dJobCd":"K000002536","dJobCdSeq":"1","dJobNm":"전동차입출창관리원","workSum":"검수를 받기 위해 입창된 차량의 검수 범위와 개소를 정하고, 검수가 완료되어 출창할 차량의 이상 유무를 검사한다.","doWork":"정기 또는 임시 검수를 받기 위하여 입창한 전동차량의 운전실기기, 주행장치, 기초제동장치 등과 같은 기기를 검수하고 수선개소를 확인·기록한다. 차량의 검사·수리가 완료되면 입창검사 시 불량개소의 수선결과를 확인하고 성능검사를 실시한다. 출창검사가 끝나면 시운전을 실시하고 가속도, 감속도, 전류 및 제동거리 등을 성능측정표에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"입창관리원, 출창관리원","certLic":"철도차량정비기능사, 철도차량정비기능장, 철도차량산업기사","dJobECd":"8123","dJobECdNm":"[8123]철도기관차·전동차 정비원","dJobJCd":"7523","dJobJCdNm":"[7523]철도 기관차 및 전동차 정비원","dJobICd":"H491","dJobICdNm":"[H491]철도 운송업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006430:1', '{"dJobCd":"K000006430","dJobCdSeq":"1","dJobNm":"전동차전자기기검수원","workSum":"전동차 운행에 지장이 없도록 전동차의 각종 전자기기를 검사하고 유지·보수한다.","doWork":"전동차운전과 관련된 속도, 제동 등의 인쇄회로(PCB)기판을 검사한다. 기판의 불량상태를 점검하여 부품의 기능을 확인하고, 전압의 정상 여부를 파악한다. 공기압축기, 발전기 열차자동정지장치(ATS), 방송장치의 전자기판 또는 기기를 오실로스코프, 전압조정기, 전류계 등을 이용하여 검사한다. 고장발생을 추적하여 부품을 교환하고 작업일지에 작업내역을 기록한다. 전자식속도기록계(비행기의 블랙박스와 유사한 역할을 하는 장치)를 컴퓨터로 출력하여 정상운행 여부, 사고 시 사고조건, 사고상황, 전동차승무원의 상황대처내역 등을 분석하여 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"철도차량정비기능사, 철도차량산업기사, 철도차량정비기능장, 전기철도산업기사","dJobECd":"8123","dJobECdNm":"[8123]철도기관차·전동차 정비원","dJobJCd":"7523","dJobJCdNm":"[7523]철도 기관차 및 전동차 정비원","dJobICd":"H492","dJobICdNm":"[H492]육상 여객 운송업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001408:1', '{"dJobCd":"K000001408","dJobCdSeq":"1","dJobNm":"전동차정비관리자","workSum":"전동차 정비 및 검수에 관한 관리·감독 업무를 수행한다.","doWork":"정비 및 비정기 검사의 계획을 세운다. 정비계획 수정 시 수정안을 작성하고 이를 수행하도록 지시·감독한다. 기계장비의 자체 보수 계획을 세우고 천정크레인, 압력용기, 승강기 등 법정장비검사 여부를 결정한다. 장비에 문제가 발생할 경우 이에 대한 원인을 분석한다. 정비원의 인원관리 및 안전관리교육을 실시한다. 천장기중기를 사용하여 대차와 차체를 분해한다. 기초 제동장치 분해·세척, 베어링 세척, 윤축조립체 정비, 축상장치 분해정비 등 대차공장의 정비업무를 감독·관리한다. 도어엔진, 냉난방장치 등 차체 정비를 감독한다. 제동 관련 장치 정비를 감독한다. 노후차량에 대한 도장과 각종 기기표기, 주요부품 도색 등 도장 관련 정비를 감독한다. 전동차 부품공장, 입출창 검사장, 회전기공장 업무를 확인·감독한다. 중수선 검사가 필요한 전동차의 입출창공정을 관리한다. 전동차 부품조달을 확인하고 주요 물품재고 및 물품수급계획을 지시한다. 전동차 중수선용 장비와 설비의 운용상태를 파악하여 하자보수 및 고장수리를 관리한다. 전동차 운용 및 정비기술을 지원한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"청각|","workEnv":"위험내재|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","certLic":"철도차량정비기능사, 철도차량정비기능장, 철도차량산업기사","dJobECd":"8123","dJobECdNm":"[8123]철도기관차·전동차 정비원","dJobJCd":"7523","dJobJCdNm":"[7523]철도 기관차 및 전동차 정비원","dJobICd":"H492","dJobICdNm":"[H492]육상 여객 운송업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005330:1', '{"dJobCd":"K000005330","dJobCdSeq":"1","dJobNm":"전동차정비원","workSum":"전동차 정비검사에 필요한 각종 기계장비의 정기, 임시, 특별검사를 수행한다.","doWork":"기계장비의 정기검사 및 비정기적 검사 계획에 따라 시험기, 크레인 등의 검사에 필요한 각종 기계장비를 유지·보수한다. 장비상의 문제 발생 원인을 파악하고 이를 방지하기 위한 대책을 수립한다. 시설물의 관리를 통하여 시설물 불량사항을 파악한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"철도차량정비기능사, 철도차량산업기사, 철도차량정비기능장","dJobECd":"8123","dJobECdNm":"[8123]철도기관차·전동차 정비원","dJobJCd":"7523","dJobJCdNm":"[7523]철도 기관차 및 전동차 정비원","dJobICd":"H492","dJobICdNm":"[H492]육상 여객 운송업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003850:1', '{"dJobCd":"K000003850","dJobCdSeq":"1","dJobNm":"전동차차량검수원","workSum":"운행을 마치고 기지 내에 입고된 열차의 각 부분을 검수한다.","doWork":"도착점검 및 일상검사로 나누어서 검수를 실행한다. 도착점검으로서 옥상기기, 집전장치(판타그라프)를 점검한다. 운전실의 주간제어기, 발차지시등 점멸 및 부저기능, 형광등, 전조등, 행선표시기, 번호표시기, 제동변핸들, 속도계, 공기압력계, 전류계, 열차자동정지(ATS： Automatic Train Stop)장치, 소화기를 검사한다. 객실 내의 좌석, 손잡이, 형광등, 소화기, 계전기, 냉난방기, 문의 개폐 등을 검사한다. 상·하 기기, 대차, 제동의 전동발전기, 공기압축기, 점퍼선, 연결기 외관, 상·하 기기함 및 커버 취부, 축상외관 및 발열 여부, 속도제어기기와 제동기기를 검사한다. 대차(차륜, 제동장치)를 검사한다. 검사하여 이상 발견 시에는 기본 수리를 실시한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"철도차량정비기능사, 철도차량산업기사, 철도차량정비기능장","dJobECd":"8123","dJobECdNm":"[8123]철도기관차·전동차 정비원","dJobJCd":"7523","dJobJCdNm":"[7523]철도 기관차 및 전동차 정비원","dJobICd":"H492","dJobICdNm":"[H492]육상 여객 운송업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006033:1', '{"dJobCd":"K000006033","dJobCdSeq":"1","dJobNm":"전동차회전기정비원","workSum":"전동차의 정기 및 비정기적 검사 시 견인전동기, 전동발전기, 공기압축기, 보조공기압축기 등을 분해하여 정비한다.","doWork":"견인전동기, 전동발전기를 분해하여 정비한다. 공기압축기를 차체에서 분해한 후 피스톤과 라이너를 측정하고 전동기측 정류자를 보정한다. 피스톤을 조립해서 압축기를 시험한 후 이상이 없으면 차체에 취부한다. 집전장치 최초 가동 시 보조공기압축기를 분해하여 정비한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"철도차량정비기능사, 철도차량정비기능장, 철도차량산업기사","dJobECd":"8123","dJobECdNm":"[8123]철도기관차·전동차 정비원","dJobJCd":"7523","dJobJCdNm":"[7523]철도 기관차 및 전동차 정비원","dJobICd":"H492","dJobICdNm":"[H492]육상 여객 운송업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004984:1', '{"dJobCd":"K000004984","dJobCdSeq":"1","dJobNm":"철도차량검사원","workSum":"운행을 마치고 기지 내에 들어온 열차의 도착점검을 수행한다.","doWork":"기관차, 객차 및 전동차 등 일일운행이 끝난 차량이 기지 내로 들어오면 운행기록 및 고장기록을 확인한다. 엔진 및 바퀴소리를 듣고 이상 유무를 확인한다. 전동차 및 전기기관차의 경우 전류를 차단한다. 차량의 상판으로 올라가 옥상기기, 냉방장치, 집전장치를 점검한다. 바퀴를 점검하여 흠집이 있는 경우 매끈하게 깎는다. 대차, 제동장치, 차량실내장치, 전자장치, 발전장치 등 열차의 외관 및 기능 등을 검사한다. 소모품을 대체하고 검수 중 이상 발견 시에는 수리한다. 중정비가 요구되는 경우 중정비 담당 기관에 알린다. 일일 작업일지를 작성한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"열차입출창검사원","connectJob":"전동차차량검사원, 기관차차량검사원, 객화차 차량검사원","certLic":"철도차량정비기능사, 철도차량정비기능장","dJobECd":"8123","dJobECdNm":"[8123]철도기관차·전동차 정비원","dJobJCd":"7523","dJobJCdNm":"[7523]철도 기관차 및 전동차 정비원","dJobICd":"H491","dJobICdNm":"[H491]철도 운송업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006773:1', '{"dJobCd":"K000006773","dJobCdSeq":"1","dJobNm":"철도차량대차정비원","workSum":"열차의 정기검사 및 비정기검사, 특별검사 수행에 필요한 대차와 윤축, 축상, 탐상, 차륜교환 등의 정비업무를 수행한다.","doWork":"대차와 윤축의 분리작업을 실시한다. 제동장치를 분해하여 정비한다. 천장기중기를 사용하여 대차틀과 볼스터(Bolster)를 분해하고 조립한다. 대차의 볼트와 너트의 이완 여부 및 균열 여부를 확인·점검하고 불량 시 수리·교환한다. 기어박스 상·하부를 분해하여 윤축의 각종 부품을 정비한다. 대소 치차(Toothed Gear) 및 커플링, 베어링을 정비한다. 전동차의 소음 및 진동을 최소화하기 위하여 차륜삭정 작업을 수행한다. 축상장치 및 베어링을 분해하여 검사한다. 차축 및 주요볼트, 핀 등에 대하여 초음파 탐상, 자분탐상 검사를 수행한다. 차륜한도에 준한 차륜을 교환한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"철도차량대차검수원","connectJob":"전동차대차정비원, 기관차대차검수원","certLic":"철도차량정비기능사, 철도차량정비기능장, 철도차량산업기사","dJobECd":"8123","dJobECdNm":"[8123]철도기관차·전동차 정비원","dJobJCd":"7523","dJobJCdNm":"[7523]철도 기관차 및 전동차 정비원","dJobICd":"H491","dJobICdNm":"[H491]철도 운송업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002667:1', '{"dJobCd":"K000002667","dJobCdSeq":"1","dJobNm":"철도차량배관검사원","workSum":"철도차량의 제동장치, 전선, 냉각수 등을 설치하기 위한 배관상태가 도면에 맞게 취부되었는지 검사한다.","doWork":"작업지시서 및 검사절차서를 보고 필요한 검사방법을 확인한다. 배관 도면을 파악하고 공구(용접기, 드라이버, 스패너, 렌치, 플라이어 등의 수공구류와 전기드릴, 에어드릴 등의 동력공구류, 버니어캘리퍼스, 마이크로미터, 줄자 등의 측정기기와 압력계측정기기)를 선정하여 준비한다. 배관의 외형상태 및 누수·누유 여부를 점검하여 배관의 마무리 상태를 검사한다. 파이프의 절단, 밴딩, 나사내기, 청소상태 등을 나사게이지 등을 사용하거나 육안으로 검사한다. 파이프의 수평, 수직도, 파이프관의 간섭, 구조물의 관통상태, 관의 지지상태 등을 수평자 등 검사공구를 사용하여 검사한다. 배관 장치를 구동하여 동작상태를 확인한다. 압축공기를 파이프에 연결한다. 압력게이지의 작동상태를 확인한다. 파이프 및 압력게이지의 연결부위에 비눗물을 칠하고 누설부위를 찾아낸다. 설치된 배관장치의 주요 부위에 관련 인원이 식별 가능하도록 표시하고, 확인 시 측정한 데이터를 기록·관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"철도차량산업기사, 철도차량기사","dJobECd":"8123","dJobECdNm":"[8123]철도기관차·전동차 정비원","dJobJCd":"7523","dJobJCdNm":"[7523]철도 기관차 및 전동차 정비원","dJobICd":"C312","dJobICdNm":"[C312]철도장비 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004728:1', '{"dJobCd":"K000004728","dJobCdSeq":"1","dJobNm":"철도차량정비원","workSum":"철도차량의 정기 및 비정기 검사, 특별검사 시 차량 각 부분을 점검하여 이상 유무를 확인하고 부품을 교환하는 등 차량을 정비한다.","doWork":"검사를 위한 차량이 입환되면 대차부 및 차체부를 분리한다. 대차의 볼트, 너트 이완 여부 및 균열 여부를 점검하고, 윤축(축에 바퀴를 고정하여 바퀴와 축을 동시에 회전시키는 장치)의 각종 부품을 교환 및 수리한다. 차륜의 상태에 따라 차륜삭정 작업을 시행하고, 축상장치 및 차축 등을 검사한다. 차체 내의 공기배관설비, 출입문, 차내 시설, 냉방장치 등을 분해·점검하고, 이상이 있는 부품을 교체한다. 전기기관차 및 전동차의 경우 전자장치 및 PCB(운전속도나 제동과 관련한 전자회로) 등을 검사하여 불량상태를 파악한다. 공기압축기, ATS(발전기 열차자동정지장치), 전자기판을 전압조정기, 오실로스코프 등을 이용하여 검사한다. 전자식속도기록계를 분석한다. 회전기를 분해하여 정비한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"철도차량관리원","connectJob":"열차차량대차정비원, 열차차량차체정비원, 열차차량회전기정비원, 열차차량전자기기정비원, 디젤기관차정비원, 전기기관차정비원, 객화차정비원, 특수기관차정비원","certLic":"철도차량정비기능사, 철도차량정비기능장","dJobECd":"8123","dJobECdNm":"[8123]철도기관차·전동차 정비원","dJobJCd":"7523","dJobJCdNm":"[7523]철도 기관차 및 전동차 정비원","dJobICd":"H491","dJobICdNm":"[H491]철도 운송업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004337:1', '{"dJobCd":"K000004337","dJobCdSeq":"1","dJobNm":"철도차량차체정비원","workSum":"차체의 주요 부분인 도어엔진, 냉난방장치, 환기장치 등을 정비한다.","doWork":"검수받기 위하여 입고된 철도차량을 중장비를 사용하여 차체부와 대차부로 분리한다. 각 부분품의 안전성 및 기능을 시험하기 위하여 각종 렌치와 스패너를 사용하여 차체의 부품을 분해·취거하여 부품실험실로 보내고 대차부는 대차공장으로 보낸다. 차체 내의 공기배관설비, 출입문, 도어엔진, 의자시설, 소화설비, 냉난방설비 등을 분해하여 점검한다. 냉방장치의 유닛 쿨러, 응축기 및 증발기, 밸브 및 배관누설 여부를 점검한다. 기타 차체를 구성하고 있는 설비를 점검·시험하고, 이상이 있는 부품을 용접장치, 목공구, 렌치, 스패너와 같은 장비나 공구를 사용하여 수리하고 불량품을 교체한다. 시험·수리가 완료된 부품과 대차를 취합하여 재조립한다. 검수가 끝난 차량은 계기를 사용하여 내압시험, 공기누설시험을 한다. 차량을 연결하고 브레이크선이나 전기회로선 등을 연결한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"철도차량차체검수원","connectJob":"전동차차체정비원, 기관차차체검수원","certLic":"철도차량정비기능사, 철도차량정비기능장, 철도차량산업기사","dJobECd":"8123","dJobECdNm":"[8123]철도기관차·전동차 정비원","dJobJCd":"7523","dJobJCdNm":"[7523]철도 기관차 및 전동차 정비원","dJobICd":"H491","dJobICdNm":"[H491]철도 운송업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005483:1', '{"dJobCd":"K000005483","dJobCdSeq":"1","dJobNm":"철도차량품질검사원","workSum":"열차차량의 검수를 위해 차량검사기지에 들어오고 나가는 차량의 이상 유무를 확인하기 위하여 검사한다.","doWork":"정기 및 비정기 검수를 위해 입창한 전동차, 디젤차, 전기기관차 등 차량을 대차, 차체, 제동장치, 엔진, 차내 설비 등의 각 부분으로 구분하여 검사한다. 고장차량의 원인을 분석하고 수선 개소를 확인·기록한다. 차량 정비가 완료되면 정비결과를 확인하고 출고 차량을 검사한다. 정비가 완료된 차량은 시운전하고 가속도, 감속도, 전류 및 제동거리 등 성능을 측정하여 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"철도차량정비기능사, 철도차량정비기능장, 철도차량산업기사","dJobECd":"8123","dJobECdNm":"[8123]철도기관차·전동차 정비원","dJobJCd":"7523","dJobJCdNm":"[7523]철도 기관차 및 전동차 정비원","dJobICd":"H491","dJobICdNm":"[H491]철도 운송업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006856:1', '{"dJobCd":"K000006856","dJobCdSeq":"1","dJobNm":"모터사이클정비원","workSum":"모터사이클의 제품별 특성을 파악하고, 각 시스템의 구조 및 작동원리를 이해하여 각 구성품(엔진 및 동력전달장치, 타이어, 브레이크계통 등)의 이상 유무를 진단 및 점검하여 모터사이클의 안전한 도로주행을 위하여 정비한다.","doWork":"매연, 엔진 소음, 연료 누유, 냉각수 누수 등의 주요 원인을 파악하여 엔진을 점검 및 진단하여 정비한다. 배터리·충전장치, 직류전원장치, 모터, 모터컨트롤러의 고장을 진단하고 정비한다. 각 전기장치의 구조·작동원리를 이해하고, 결함 부품을 서비스 매뉴얼의 지침에 따라 진단 점검후 정상 작동되도록 수리, 교환한다. 동력의 흐름과 전달, 차단 및 변환 등에 대한 이해를 바탕으로 각종 측정 장비의 데이터에 따라 고장을 진단하고 수리한다. 동력 전달을 위한 각종 변속기와 동력전달 구성요소를 점검하고 수리하고 교환한다. 오토바이의 주행 중에 탑승자의 안전·편의장치 구성품의 입력, 제어, 출력 등의 작동 여부를 확인하고 수리하고 교환한다. 변형된 오토바이의 파손된 부분을 분석하고 계측하여 플레임 정비계획을 수립하고 변형된 프레임을 수정 및 교환하여 프레임 정비 마무리 점검을 통하여 오토바이 프레임 구조 강도와 안전을 유지하도록 원상 복구한다. 오토바이의 안전운행을 위해 안전기준과 관련 법규를 바탕으로 차량의 동일성, 안전성 및 배출가스 검사 등을 정기 또는 수시로 검사한다. 오토바이 정비에 사용되는 장비, 공구를 유지하고 관리한다. 고객의 오토바이 상태에 대한 의뢰사항 청취, 고장부위 및 수리비용 등을 설명한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"오토바이정비원, 오토바이수리원, 모터사이클정비원","dJobECd":"8129","dJobECdNm":"[8129]기타 운송장비 정비원","dJobJCd":"7529","dJobJCdNm":"[7529]기타 운송장비 정비원","dJobICd":"S952","dJobICdNm":"[S952]자동차 및 모터사이클 수리업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006099:1', '{"dJobCd":"K000006099","dJobCdSeq":"1","dJobNm":"자전거수리원","workSum":"자전거의 조립상태와 조정상태를 검사하고, 고장부위 후, 전문공구와 전용공구를 사용하여 자전거를 수리한다.","doWork":"자전거 프레임, 서스펜션, 휠, 타이어, 허브, 크랭크셋, 카세트·프리휠, 체인, 변속레버, 트레일러, 헤드셋, 브레이크, 핸들바, 스템, 안장, 싯포스트, 페달, 기어 등을 점검하여 고장 부위를 파악한다. 정비 전용공구를 사용하여 부품을 교체하거나 기존 부품을 수리한다. 자전거의 조립상태, 도장상태, 부품의 흔들림과 편차 등 조정상태를 검사한다. 운전자의 체형에 맞게 안장, 핸들, 페달 등의 각도와 높이를 조절하고 여러 가지 액세서리를 장착하기도 한다. 자전거의 종류에 따라 조립순서를 결정하고 플라이어·렌치 등 수동 및 동력공구를 사용하여 포크, 바퀴를 조립하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"자전거정비원, 자전거미케닉","dJobECd":"8129","dJobECdNm":"[8129]기타 운송장비 정비원","dJobJCd":"7529","dJobJCdNm":"[7529]기타 운송장비 정비원","dJobICd":"S953","dJobICdNm":"[S953]개인 및 가정용품 수리업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005518:1', '{"dJobCd":"K000005518","dJobCdSeq":"1","dJobNm":"전기자전거정비원","workSum":"전기자전거를 최적의 상태로 만들기 위하여 정비·수리지침서를 기준으로 전기자전거 각 부분의 부품과 리튬배터리(이차전지) 팩의 마감상태 유무를 확인하고 수리교체 등 정비한다.","doWork":"정비지침서 및 수리지침서를 보고 정비방법 및 순서를 숙지한다. 테스터기 등의 측정도구를 준비한다. 전원연결 상태, 모터작동, 스로틀(Throttle:전기공급조절판), 납축전지와 전기배선의 연결 및 배선구조를 확인한다. 정비도구 및 측정장비(절연저항측정기, 접지저항측정기, 클램프메타, 만능회로측정기)를 준비한다. 규정된 동력장치의 작동상태 및 규정된 조립의 측정값을 확인·검사한다.  타이어의 규격 및 타이어 휠의 조립상태를 검사한다. 모터기기의 통전시험을 통하여 문제가 없는지 확인한다. 측정하고자 하는 납축전지 배선의 양 끝을 측정기에 접속한다. 벨의 울림으로 단락 여부를 판정한다. 절연시험기를 사용하여 절연저항을 측정한다. 명세서에 의거 절연저항의 이상 여부를 판정하고 불량부분은 그 원인을 추적하여 보수한다. 시험하고자 하는 기기를 내전압시험기에 연결한다. 내압시험기를 작동하여 회로의 내압시험을 한다. 정비결과를 기록양식에 기재한다. 핸들, 프레임, 배터리, 모터, 휠, 컨트롤러, 전조등, 후미등 등 각 부분품을 조립순서에 따라 조립하기도 한다. 조립·완성된 전기자전거의 시동이 잘되는지, 주행 중 제동장치 작동과 전원차단장치 작동이 잘되는지를 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"전기자전거수리원, 전기자전거미케닉","connectJob":"전동킥보드수리원, 전동스쿠터수리원, 골프장카트수리원","certLic":"전기기능사","dJobECd":"8129","dJobECdNm":"[8129]기타 운송장비 정비원","dJobJCd":"7529","dJobJCdNm":"[7529]기타 운송장비 정비원","dJobICd":"C319","dJobICdNm":"[C319]그 외 기타 운송장비 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006379:1', '{"dJobCd":"K000006379","dJobCdSeq":"1","dJobNm":"3D프린터설치정비원","workSum":"3D프린터를 설치하고 조립상태를 검증하며 3D프린터 사용방법 등에 교육하고 3D프린터의 사후관리를 한다.","doWork":"3D프린터 하드웨어를 조립하고 장비 운용을 위한 소프트웨어를 설치한다. 설치된 3D프린터의 조립상태를 검증하여 운용상태를 확인한다. 원활한 출력을 위한 장비 운영관리 및 출력 방법을 교육한다. 기술 서비스 체크리스트를 작성하고 기술 지원을 한다. 3D프린터의 이상 발생 시 사후관리를 하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"설치","similarNm":"3D프린터서비스엔지니어","certLic":"기계설계산업기사, 3D프린터운용기능사, 3D프린터개발산업기사, 일반기계기사","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006176:1', '{"dJobCd":"K000006176","dJobCdSeq":"1","dJobNm":"가스제조장치수리원","workSum":"가스를 제조하기 위한 각종 장치(반응기, 압축기, 펌프, 열교환기, 흡수탑 등)를 수리하고 유지·관리한다.","doWork":"반응기, 압축기, 펌프, 열교환기 등 가스제조에 필요한 각종 설비 및 장치에 대해 시운전 정비, 경상정비, 예방정비를 실시하고 작동상태를 점검·관리한다. 제어장치조작원과 연락하여 기계 및 장치의 문제점을 진단한다. 진단 결과에 따라 수동공구 및 동력공구, 용접기 등을 사용하여 밸브를 조이거나, 노즐, 개스킷, 패킹 등을 교체한다. 주입기를 사용하여 펌프 및 밸브에 윤활유를 주입하고 필요시 용접한다. 압축질소호스 및 압축기·진공게이지를 사용하여 압력이 떨어지는 곳을 탐지하거나 장치의 누수 유무를 시험한다. 새로 도입된 장비 및 기계를 설치한다. 자체수리가 어려운 부분은 외부에 전문적인 진단 및 수리를 요청한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"기계정비기능사, 기계정비산업기사","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"D352","dJobICdNm":"[D352]연료용 가스 제조 및 배관공급업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006605:1', '{"dJobCd":"K000006605","dJobCdSeq":"1","dJobNm":"권사기정비원","workSum":"실을 콘 또는 치즈 형태로 감는 권사기계를 조정·수리한다.","doWork":"주기적인 정비계획이나 필요에 따라 권사기의 소제 및 각종 게이지를 점검한다. 수동공구를 사용하여 드럼부분, 보빈장치 및 장력장치 등을 분해·소제·수리한다. 각 요소 부위에 오일 및 윤활유를 주입한다. 수리·교체 내용을 보전일지에 기록·결재·보관한다. 솔이나 공기호스를 사용하여 기계 주변을 깨끗이 소제한다. 부족한 소요자재를 청구하여 비치한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"기계정비기능사, 기계정비산업기사","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002229:1', '{"dJobCd":"K000002229","dJobCdSeq":"1","dJobNm":"기계설비공무원","workSum":"공장설비 및 생산라인의 기계와 장비를 설치·유지·수리한다.","doWork":"자동화시스템 등 생산라인의 기계나 장비를 설치한다. 생산라인의 기계, 설비 등을 정기적으로 점검하여 문제가 발생하지 않도록 사전에 예방한다. 기계설비 및 장비의 고장원인을 진단하여 수리하거나 부품을 교환한다. 기계 및 설비 등을 수리한 후에는 일지에 기록한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"설치","similarNm":"기계설비영선원","connectJob":"도금설비공무원","certLic":"기계정비기능사, 기계정비산업기사","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"C","dJobICdNm":"[C]제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006863:1', '{"dJobCd":"K000006863","dJobCdSeq":"1","dJobNm":"기계정비반장","workSum":"사업체 내의 제반 생산설비의 수명과 정밀도를 유지시키고 원활한 기계가동을 위하여 각종 기계설비를 정비하는 작업원의 활동을 감독·조정한다.","doWork":"현장의 생산공정을 관찰하여 설비의 노후부분, 고장부위, 고장원인 등을 점검·파악한다. 정비작업을 검토하여 주별, 월별, 분기별 등 정비계획에 따른 세부추진항목을 수립한다. 정비방법 및 정비절차 등의 작업사항을 작업원에게 지시하고 같이 작업하며 이행 여부를 확인한다. 기계를 정비하는데 필요한 각종 수동공구, 장비 및 소요자재 등을 수급하고 관리한다. 작업원에 대한 직무교육과 안전위생교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시 관찰과 면담을 통해 애로 및 건의사항을 수렴·해결하고 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|청각|","workEnv":"위험내재|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","certLic":"기계정비기능사, 기계정비산업기사","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"ALL","dJobICdNm":"[ALL]전체","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005007:1', '{"dJobCd":"K000005007","dJobCdSeq":"1","dJobNm":"기계정비원","workSum":"사업체 내의 제반 생산설비의 돌발사고를 방지하고 원활한 기계가동 및 유지를 위하여 각종 기계설비를 점검·분해·보수·정비를 한다.","doWork":"기계정비반장의 지시를 받아 점검 및 정비 내용을 파악하고 지시사항을 확인한다. 작업에 필요한 각종 치구와 공구를 준비하고 정비현황판에 설비명, 설비번호, 정비사항 등을 기록하여 부착한다. 작업표준서에 의거 고장이나 노후된 부분을 확인하고 기계를 분해하여 세척하고 교환·정비한 후 조립한다. 조립이 완료된 기계의 이상 유무를 확인하기 위하여 시운전을 실시하고 제반 문제를 해결한다. 반복사고를 방지하기 위하여 기계조작원에게 고장부위와 원인을 설명하고 교육한다. 고장부위에 대한 원인분석 및 향후대책을 수립한다. 사용한 공구의 파손 여부를 확인하고 세척하여 정위치에 정리·정돈한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"식품기계설치원, 식품기계유지보수원, 식품기계정비원, 식품기계설치공무원, 식품기계정비공무원, 식품기계설치기사, 식품기계정비기사, 섬유기계설치원, 섬유기계유지보수원, 섬유기계정비원, 섬유기계설치공무원, 섬유기계정비공무원, 섬유기계설치기사, 섬유기계정비기사, 화학기계설치원, 화학기계유지보수원, 화학기계정비원, 화학기계설치공무원, 화학기계정비공무원, 화학기계설치기사, 화학기계관리기사, 공작기계(CNC/밀링기/선반/MCT 등)설치원, 공작기계유지보수원, 공작기계정비원, 공작기계설치공무원, 공작기계정비공무원, 공작기계관리원, 공작기계설치기사, 공작기계정비기사, 전자제품제조기계설치원, 전자제품제조기계유지보수원, 전자제품제조기계정비원, 전자제품제조기계설치공무원, 전자제품제조기계정비공무원, 전자제품제조기계관리원, 전자제품제조기계정비기사, 전자제품제조기계설치기사, 반도체생산기계정비원(테크니션), 로봇정비원, 우편기계보수원","certLic":"기계정비기능사, 기계정비산업기사","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"ALL","dJobICdNm":"[ALL]전체","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004723:1', '{"dJobCd":"K000004723","dJobCdSeq":"1","dJobNm":"누비질기계조정원","workSum":"작업도표 및 기계 기능에 관한 지식을 응용하여 누비질 기계를 조정한다.","doWork":"누비질 작업도안에 필요한 누비질 기계의 수치를 알기 위하여 도표를 분석한다. 기계의 도안을 변경하기 위하여 바늘 행정을 조정하는 캠을 교체한다. 바늘 행정과 루퍼(Looper)를 일치시키기 위해 나사돌리개를 조절한다. 기계의 작동소리를 듣고 바느질 작업을 관찰하여 결함을 알아낸다. 기계를 분해하여 파손되거나 마모된 부품을 수리하고 교체한다. 직물과 실의 종류에 따라서 실의 장력, 바늘, 행정, 공급 속도를 조절한다. 기계를 분해하여 파손되거나 마모된 부품을 수리하고 교체하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"기계정비기능사, 기계정비산업기사","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"C139","dJobICdNm":"[C139]기타 섬유제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005838:1', '{"dJobCd":"K000005838","dJobCdSeq":"1","dJobNm":"로프제작기보전원","workSum":"로프를 만드는 자동기계장치를 설치·조정·수리한다.","doWork":"기계장치의 유지보수에 필요한 부속자재를 수령하여 운반·보관한다. 주기적인 정비계획이나 필요에 따라 가공할 원료의 종류, 기계의 효율 등 기계에 관한 지식과 가공에 관한 지식을 이용하여 기계의 운전 상태를 점검한다. 수동공구를 사용하여 기계의 부분품을 분해·소제한다. 각종 게이지(Gauge)를 점검하고 조정한다. 기계의 부분품에 오일이나 그리스를 넣는다. 주요 수리내용을 기록일지에 기록·보관한다. 솔, 공기호스, 기름걸레 등을 사용하여 기계의 주변을 정리·소제한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"기계정비기능사, 기계정비산업기사","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"C139","dJobICdNm":"[C139]기타 섬유제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004422:1', '{"dJobCd":"K000004422","dJobCdSeq":"1","dJobNm":"롤러관리원","workSum":"정방, 조방, 연조, 정소면 공정에서 실의 품질향상 및 롤러, 에이프런(Apron) 등 부품의 수명을 연장하기 위하여 롤러·에이프런 등을 세척 및 청소한다.","doWork":"정방기계의 롤러 및 에이프런을 빼서 운반 통에 담아 정방롤러로 운반한다. 솔이나 세제 등을 사용하여 롤러 및 에이프런을 세척하고 보수한다. 캘리퍼스·게이지 등을 사용하여 검사한다. 교체·관리현황을 기록표에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"롤러검사원, 롤러세척원, 에이프런소제원","certLic":"기계정비기능사, 기계정비산업기사","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006807:1', '{"dJobCd":"K000006807","dJobCdSeq":"1","dJobNm":"롤러피복원","workSum":"정방기, 조방기, 연조기, 정소면기에 사용되는 롤러를 수리하고 씌우개를 씌운다.","doWork":"롤러 축의 낡은 고무씌우개(Cot)를 자르고 축을 용제로 깨끗이 닦는다. 롤러 축에 접착제를 칠하고 일정 시간이 지난 후, 축 가이드를 수동프레스로 조이고 롤러 길이에 따라 프레스 행정길이를 조절하는 손잡이를 돌린다. 주축과 고무씌우개를 프레스에 넣고 고무씌우개가 주축 위에 눌러지도록 하는 레버를 잡아당긴다. 버핑기계와 이동차의 중심 사이에 조립된 롤러를 놓는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"기계정비기능사, 기계정비산업기사","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006607:1', '{"dJobCd":"K000006607","dJobCdSeq":"1","dJobNm":"매듭기수리원","workSum":"끊어진 실을 이어 주는 매듭기(Knotter)를 수리한다.","doWork":"고장 난 매듭기를 수집하여 수리대로 운반한다. 고장 내용을 확인하기 위하여 실을 매듭기에 걸고 시험한다. 손 공구를 사용하여 순서에 따라 매듭기를 분해하고 마모나 손상된 부분을 교체한다. 부품을 청소하고 윤활유를 넣는다. 매듭기에 실을 걸고 이상이 없는지 매듭시험을 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"놋타수리원, 실잇기틀수리원","certLic":"기계정비기능사, 기계정비산업기사","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005063:1', '{"dJobCd":"K000005063","dJobCdSeq":"1","dJobNm":"바디수리원","workSum":"직기 바디의 불량을 점검하여 청소하고 수리한다.","doWork":"바디를 작업대의 틀에 올려놓고 솔이나 공기호스를 사용하여 바닥의 섬유부스러기나 수지를 청소한다. 와이어의 정렬이 바른지 바디의 거친 가장자리와 깨진 곳의 유·무 등에 대한 조사한다. 마이크로미터 및 필러게이지를 사용하여 바디의 두께 및 간격을 확인한다. 수동공구를 사용하여 구부러진 와이어를 펴서 정렬한다. 부서진 와이어를 납땜한다. 바디의 상태에 따라 경석·석회·사포·회전 브러시 등을 사용하여 바디를 닦는다. 새로운 바디를 검사하고 크기에 따라 수리한 바디와 함께 저장한다. 바디의 수치 및 이동을 기록한다. 고장 난 직기바디를 교체하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"직기바디정비원","certLic":"기계정비기능사, 기계정비산업기사","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"C132","dJobICdNm":"[C132]직물직조 및 직물제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007441:1', '{"dJobCd":"K000007441","dJobCdSeq":"1","dJobNm":"바이오의약품생산지원기술자","workSum":"안전하고 위생적인 바이오의약품 제조시설 관리를 위해 GMP 규정에 따라 바이오의약품 유틸리티관리, 보관관리, 제조위생관리, 제조용수, 가스시험 등의 업무를 수행한다.","doWork":"공조기와 제조용수, 제조용 가스, 스팀 제조설비를 운전하며 원자재, 반제품, 제품보관 및 온·습도 관리, 방충방서 관리와 주기적인 밸리데이션을 수행한다. 절차에 맞게 작업장 출입, 복장 구비, 작업자 건강관리, 작업실 청소, 소독, 훈증, 방충방서를 실시한다. 제조용수 시료 채취, 제조용수, 가스 시료 채취, 가스 시험을 실시한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"C211","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002735:1', '{"dJobCd":"K000002735","dJobCdSeq":"1","dJobNm":"반도체FAB설비관리기술자","workSum":"반도체장비 동작 및 제조공정을 위한 유틸리티 장치의 설치, 운전, 환경안전관리 및 사전예방정비, 공정가스, 화학약품, 금속재료 등의 저장, 취급, 응급조치 등 유지관리 업무를 수행한다.","doWork":"반도체장비 동작, 운영을 위해 필요한 전기, 초순수, 냉각수, 진공, 공기, 불활성 가스, 배기, 폐수 등 다양한 유틸리티의 특성을 이해하고, 관련 유체 공급장치 등을 안정적으로 운영, 유지 관리한다. 무정전 전원(UPS), 긴급비상발전기, 환경시설 등의 특성을 이해하고, 긴급복구 시스템 기술을 이용하여 소자생산 중 발생할 수 있는 유틸리티 공급 중단 사고를 사전에 예방, 유지 관리한다. 초순수, 냉각수, 가스, 화학약품, 배기, 폐수 관련 배관 설비와 트랩, 펌프 등 장치를 이해하고, 운영, 유지 관리한다. 반도체장비의 설치, 이동, 개조 작업 단계에서 유틸리티 공급의 신속성과 오차를 최소화하기 위해 관련 도면, 재질, 규격 등을 이해하여 효과적으로 지원, 관리한다. 반도체 제조공정을 위한 유독성 공정가스, 화학약품, 금속재료 등의 물질안전보건자료(MSDS)의 이해를 기준으로 위험 및 관리 등급을 결정, 관련 내용을 문서화하여 공유하며, 유틸리티 특성 및 등급에 따라 적용 배관 및 재질을 결정, 관련 내용을 문서화하여 공유하며, 시설 및 장비기술자와 공유한다. 공정가스, 화학약품, 금속재료 등의 제조공정 응용을 위해 반도체장비의 정확한 제원을 파악하고, 유틸리티 특성에 따라 선택한 배관을 이용하여 반도체장비에 연결, 공급, 안전관리 작업을 수행한다. 각종 유틸리티 중앙공급장치 기술을 이해하고, 무색, 무취, 화재, 폭발 등 환경안전 규정을 준수하여 운영, 관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체FAB설비기술자","certLic":"반도체설비보전기능사","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002666:1', '{"dJobCd":"K000002666","dJobCdSeq":"1","dJobNm":"반도체FAB시설운영기술자","workSum":"반도체 소자 품질수율 및 생산성 향상 활동을 지원하기 위해 FAB 온도, 습도, 청정도 등의 클린룸 환경, 물류자동화, 운영프로그램 등 관련 시설을 설치, 평가, 개선, 인증, 유지 관리한다.","doWork":"반도체 클린룸 온도, 습도, 청정도 등 내부 환경을 유지 관리한다. 공조장비의 원리 및 특성, 안전수칙 및 시설관리기준에 대한 설명서를 이해하고, 특수가스 시설, 배기시설, 장비 운전기술을 습득하여 클린룸에서 환경안전과 안정적인 예방 정비를 수행한다. 클린룸 내부 작업 절차 및 설명서를 이해하고, 무진장비와 국소청정시설의 운전기술을 습득하여 청정도 시설을 운영, 관리한다. 반도체 FAB의 물류자동화 장치들, Internal·Fixed Buffer Equipment, Stocker, OHS(Over Head Shuttle), OHT(Over Head Track), RGV(Rail Guided Vehicle), AGV(Auto Guided Vehicle), PGV(Personal Guided Vehicle) 원리와 구성, 일괄제어현황관리(CIM) 소프트웨어프로그램(MES 등), EFEM 기구동작 관련 국제표준, 공정장비와 호스트 간 통신 관련 국제표준 등을 이해하고, 관련 시설을 운영, 관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체FAB운영기술자","certLic":"반도체설비보전기능사","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005768:1', '{"dJobCd":"K000005768","dJobCdSeq":"1","dJobNm":"반도체계측검사장비기술자","workSum":"반도체 소자 품질수율 및 생산성 향상 활동을 지원하기 위해 계측검사 장비를 설치, 평가, 개선, 인증, 유지 관리한다.","doWork":"반도체 계측검사 관련 부품, 시설, 장비 및 공정 관련 기술을 이용하여 장비설치 장소에 유틸리티 연결을 위한 배관 시설, 진동 방지 바닥 패널 등을 준비한다. 계측검사장비 제조사의 모듈 조립, 유틸리티 연결, 공급 및 시험평가, 시스템 입출력 동작 점검 및 개선, 로봇, 광학모듈, 센서 등의 동작·위치 교정 작업, 기구동작·성능 평가·개선 작업, 유틸리티, 부품, 장치, 모듈 및 장비의 신뢰성 평가, 개선, 인증 활동을 지원한다. 계측검사장비의 측정신뢰성 검증을 위한 평가, 개선, 인증 활동을 지원한다. 계측검사장비 관련 부품, 장비 기술 전반에 대한 교육을 이수한다. 계측검사장비 제조사에서 제공하는 장비 조작, 유지관리, 사전예방 점검, 이상발생조치 관련 사용설명서를 이해하고, 각 항목들에 대한 시험, 검증, 개선 활동을 통해 반도체 제조기술 및 생산 환경에 적합한 부품, 장비의 운영방법을 규정하고, 문서화하여 반도체소자 제조원 및 공정기술자와 공유한다. 규정된 문서를 기준으로 장비를 운영할 수 있도록 반도체소자 제조원에게 교육을 실시하여 계측검사기술 응용 생산 활동을 지원한다. 계측검사장비의 정상 동작·운영을 위해 소재, 부품 및 장치의 유지관리, 사전예방점검, 이상발생조치 등 활동을 수행한다. 국내외 계측검사 관련 부품·장비 업체로부터 획득한 부품 및 요소 기술을 정기적으로 시험 평가, 인증, 응용하여 원가절감 및 개조개선 활동을 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체장비기술자","connectJob":"DEFECT검출장비기술자, 금속불순물검출장비기술자, SEM장비기술자, TEM장비기술자 등","certLic":"반도체설비보전기능사","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007348:1', '{"dJobCd":"K000007348","dJobCdSeq":"1","dJobNm":"반도체금속막증착장비기술자","workSum":"반도체 소자 품질수율 및 생산성 향상 활동을 지원하기 위해 금속막 증착 장비를 설치, 평가, 개선, 인증, 유지 관리한다.","doWork":"반도체 금속막 증착 관련 소재, 부품, 시설, 장치, 장비 및 공정 관련 기술을 이용하여 장비설치 장소에 유틸리티 연결을 위한 배관 시설 등을 준비한다. 금속막 증착장비 제조사의 모듈 조립, 유틸리티 연결, 공급 및 시험평가, 시스템 입출력 동작 점검 및 개선, 로봇, 모터, 센서 등의 동작·위치 교정 작업, 기구동작·성능 평가·개선 작업, 유틸리티, 부품, 장치, 모듈 및 장비의 신뢰성 평가, 개선, 인증 활동을 지원한다. 금속막 증착장비의 공정신뢰성 검증 평가를 위해 기초·생산 공정 평가, 개선, 인증을 지원한다. 금속막 증착장비 관련 소재, 부품, 시설, 장치, 장비 기술 전반에 대한 교육을 이수한다. 금속막 증착장비 제조사에서 제공하는 장비 조작, 유지관리, 사전예방 점검, 이상발생조치 관련 사용설명서를 이해하고, 각 항목들에 대한 시험, 검증, 개선 활동을 통해 반도체 제조기술 및 생산 환경에 적합한 소재, 부품, 장치, 장비의 운영방법을 규정하고, 문서화하여 반도체소자 제조원 및 공정기술자와 공유한다. 규정된 문서를 기준으로 장비를 운영할 수 있도록 반도체소자 제조원에게 교육을 실시하여 금속막 증착기술 응용 생산 활동을 지원한다. 금속막 증착장비의 정상 동작·운영을 위해 소재, 부품 및 장치의 유지관리, 사전예방점검, 이상발생조치 등 활동을 수행한다. 국내외 금속막 증착 관련 부품·장비 업체로부터 획득한 소재, 부품 및 장치 기술을 정기적으로 시험 평가, 인증, 응용하여 원가절감 및 개조개선 활동을 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체장비기술자","certLic":"반도체설비보전기능사","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002729:1', '{"dJobCd":"K000002729","dJobCdSeq":"1","dJobNm":"반도체사진현상장비기술자","workSum":"반도체 소자 품질수율 및 생산성 향상 활동을 지원하기 위해 사진현상 장비를 설치, 평가, 개선, 인증, 유지 관리한다.","doWork":"반도체 사진현상 관련 소재, 부품, 시설, 장치, 장비 및 공정 관련 기술을 이용하여 장비설치 장소에 유틸리티 연결을 위한 배관 시설, 진동 방지 바닥 패널 등을 준비한다. 사진현상장비 제조사의 모듈 조립, 유틸리티 연결, 공급 및 시험평가, 시스템 입출력 동작 점검 및 개선, 로봇, 모터, 센서 등의 동작·위치 교정 작업, 기구동작·성능 평가·개선 작업, 유틸리티, 부품, 장치, 모듈 및 장비의 신뢰성 평가, 개선, 인증 활동을 지원한다. 사진현상장비의 공정신뢰성 검증 평가를 위해 기초·생산 공정 평가, 개선, 인증을 지원한다. 사진현상장비 관련 소재, 부품, 시설, 장치, 장비 기술 전반에 대한 교육을 이수한다. 사진현상 장비제조사에서 제공하는 장비 조작, 유지관리, 사전예방 점검, 이상발생조치 관련 사용설명서를 이해하고, 각 항목들에 대한 시험, 검증, 개선 활동을 통해 반도체 제조기술 및 생산 환경에 적합한 소재, 부품, 장치, 장비의 운영방법을 규정하고, 문서화하여 반도체소자 제조원 및 공정기술자와 공유한다. 규정된 문서를 기준으로 장비를 운영할 수 있도록 반도체소자 제조원에게 교육을 실시하여 사진현상기술 응용 생산 활동을 지원한다. 사진현상장비의 정상 동작·운영을 위해 소재, 부품 및 장치의 유지관리, 사전예방점검, 이상발생조치 등 활동을 수행한다. 국내외 사진현상 관련 부품·장비 업체로부터 획득한 소재, 부품 및 장치 기술을 정기적으로 시험 평가, 인증, 응용하여 원가절감 및 개조개선 활동을 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체장비기술자","connectJob":"반도체사진현상장비 기술자","certLic":"반도체설비보전기능사","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005404:1', '{"dJobCd":"K000005404","dJobCdSeq":"1","dJobNm":"반도체세정장비기술자","workSum":"반도체 소자 품질수율 및 생산성 향상 활동을 지원하기 위해 세정 장비를 설치, 평가, 개선, 인증, 유지 관리한다.","doWork":"반도체 세정 관련 소재, 부품, 시설, 장치, 장비 및 공정 관련 기술을 이용하여 장비설치 장소에 유틸리티 연결을 위한 배관 시설 등을 준비한다. 세정장비 제조사의 모듈 조립, 유틸리티 연결, 공급 및 시험평가, 시스템 입출력 동작 점검 및 개선, 로봇, 모터, 센서 등의 동작·위치 교정 작업, 기구동작·성능 평가·개선 작업, 유틸리티, 부품, 장치, 모듈 및 장비의 신뢰성 평가, 개선, 인증 활동을 지원한다. 세정장비의 공정신뢰성 검증 평가를 위해 기초·생산 공정 평가, 개선, 인증을 지원한다. 세정장비 관련 소재, 부품, 시설, 장치, 장비 기술 전반에 대한 교육을 이수한다. 세정장비 제조사에서 제공하는 장비 조작, 유지관리, 사전예방 점검, 이상발생조치 관련 사용설명서를 이해하고, 각 항목들에 대한 시험, 검증, 개선 활동을 통해 반도체 제조기술 및 생산 환경에 적합한 소재, 부품, 장치, 장비의 운영방법을 규정하고, 문서화하여 반도체소자 제조원 및 공정기술자와 공유한다. 규정된 문서를 기준으로 장비를 운영할 수 있도록 반도체소자 제조원에게 교육을 실시하여 세정기술 응용 생산 활동을 지원한다. 세정장비의 정상 동작·운영을 위해 소재, 부품 및 장치의 유지관리, 사전예방점검, 이상발생조치 등 활동을 수행한다. 국내외 세정 관련 부품·장비 업체로부터 획득한 소재, 부품 및 장치 기술을 정기적으로 시험 평가, 인증, 응용하여 원가절감 및 개조개선 활동을 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체장비기술자","certLic":"반도체설비보전기능사","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005608:1', '{"dJobCd":"K000005608","dJobCdSeq":"1","dJobNm":"반도체소자웨이퍼검사장비기술자","workSum":"반도체 소자 품질수율 및 생산성 향상 활동을 지원하기 위해 소자웨이퍼검사 장비를 설치, 평가, 개선, 인증, 유지 관리한다.","doWork":"반도체 소자웨이퍼의 전기적 특성 검사 관련 프로브, 부품, 시설, 장치, 장비, 공정 및 검사프로그램 관련 기술을 이용하여 장비설치 장소에 유틸리티 연결을 위한 배관 시설 등을 준비한다. 소자웨이퍼검사장비 제조사의 유틸리티 연결, 공급 및 시험평가, 시스템 입출력 동작 점검 및 개선, 로봇, 모터, 센서 등의 동작·위치 교정 작업, 기구동작·성능 평가·개선 작업, 유틸리티, 프로브, 부품, 장치, 장비 및 검사프로그램의 신뢰성 평가, 개선, 인증 활동을 지원한다. 소자웨이퍼검사장비의 검사공정 신뢰성 평가를 위해 전기적 특성 평가, 개선, 인증을 지원한다. 소자웨이퍼검사장비 관련 프로브, 부품, 시설, 장치, 장비, 검사프로그램 기술 전반에 대한 교육을 이수한다. 소자웨이퍼검사장비 제조사에서 제공하는 장비 조작, 유지관리, 사전예방 점검, 이상발생조치 관련 사용설명서를 이해하고, 각 항목들에 대한 시험, 검증, 개선 활동을 통해 반도체 검사기술 환경에 적합한 프로브, 부품, 장치, 장비, 검사프로그램의 운영방법을 규정하고, 문서화하여 반도체검사 제조원 및 공정기술자와 공유한다. 규정된 문서를 기준으로 장비를 운영할 수 있도록 반도체검사 제조원에게 교육을 실시하여 검사기술 활동을 지원한다. 소자웨이퍼검사장비의 정상 동작·운영을 위해 프로브, 부품, 장치 및 검사프로그램의 유지관리, 사전예방점검, 이상발생조치 등 활동을 수행한다. 국내외 소자웨이퍼검사 관련 부품·장비 업체로부터 획득한 부품 및 장치 기술을 시험 평가, 인증, 응용하여 원가절감 및 개조개선 활동을 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체장비기술자","certLic":"반도체설비보전기능사","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005429:1', '{"dJobCd":"K000005429","dJobCdSeq":"1","dJobNm":"반도체소자패키지검사장비기술자","workSum":"반도체 소자 품질수율 및 생산성 향상 활동을 지원하기 위해 소자패키지검사 장비를 설치, 평가, 개선, 인증, 유지 관리한다.","doWork":"반도체 소자패키지의 전기적 특성 검사 관련 보드, 부품, 시설, 장치, 장비, 공정 및 검사프로그램 관련 기술을 이용하여 장비설치 장소에 유틸리티 연결을 위한 배관 시설 등을 준비한다. 소자패키지검사장비 제조사의 유틸리티 연결, 공급 및 시험평가, 시스템 입출력 동작 점검 및 개선, 로봇, 모터, 센서 등의 동작·위치 교정 작업, 기구동작·성능 평가·개선 작업, 유틸리티, 보드, 부품, 장치, 장비 및 검사프로그램의 신뢰성 평가, 개선, 인증 활동을 지원한다. 소자패키지검사장비의 검사공정 신뢰성 평가를 위해 전기적 특성 평가, 개선, 인증을 지원한다. 소자패키지검사장비 관련 보드, 부품, 시설, 장치, 장비, 검사프로그램 기술 전반에 대한 교육을 이수한다. 소자패키지검사장비 제조사에서 제공하는 장비 조작, 유지관리, 사전예방 점검, 이상발생조치 관련 사용설명서를 이해하고, 각 항목들에 대한 시험, 검증, 개선 활동을 통해 반도체 검사기술 환경에 적합한 보드, 부품, 장치, 장비, 검사프로그램의 운영방법을 규정하고, 문서화하여 반도체검사 제조원 및 공정기술자와 공유한다. 규정된 문서를 기준으로 장비를 운영할 수 있도록 반도체검사 제조원에게 교육을 실시하여 검사기술 활동을 지원한다. 소자패키지검사장비의 정상 동작·운영을 위해 보드, 부품, 장치 및 검사프로그램의 유지관리, 사전예방점검, 이상발생조치 등 활동을 수행한다. 국내외 소자패키지검사 관련 부품·장비 업체로부터 획득한 부품 및 장치 기술을 시험 평가, 인증, 응용하여 원가절감 및 개조개선 활동을 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체장비기술자","certLic":"반도체설비보전기능사","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001881:1', '{"dJobCd":"K000001881","dJobCdSeq":"1","dJobNm":"반도체식각장비기술자","workSum":"반도체 소자 품질수율 및 생산성 향상 활동을 지원하기 위해 식각장비를 설치, 평가, 개선, 인증, 유지 관리한다.","doWork":"반도체 식각 관련 소재, 부품, 시설, 장치, 장비 및 공정 관련 기술을 이용하여 장비설치 장소에 유틸리티 연결을 위한 배관 시설 등을 준비한다. 식각장비 제조사의 모듈 조립, 유틸리티 연결, 공급 및 시험평가, 시스템 입출력 동작 점검 및 개선, 로봇, 모터, 센서 등의 동작·위치 교정 작업, 기구동작·성능 평가·개선 작업, 유틸리티, 부품, 장치, 모듈 및 장비의 신뢰성 평가, 개선, 인증 활동을 지원한다. 식각장비의 공정신뢰성 검증 평가를 위해 기초·생산 공정 평가, 개선, 인증을 지원한다. 식각장비 관련 소재, 부품, 시설, 장치, 장비 기술 전반에 대한 교육을 이수한다. 식각장비 제조사에서 제공하는 장비 조작, 유지관리, 사전예방 점검, 이상발생조치 관련 사용설명서를 이해하고, 각 항목들에 대한 시험, 검증, 개선 활동을 통해 반도체 제조기술 및 생산 환경에 적합한 소재, 부품, 장치, 장비의 운영방법을 규정하고, 문서화하여 반도체소자 제조원 및 공정기술자와 공유한다. 규정된 문서를 기준으로 장비를 운영할 수 있도록 반도체소자 제조원에게 교육을 실시하여 식각기술 응용 생산 활동을 지원한다. 식각 장비의 정상 동작·운영을 위해 소재, 부품 및 장치의 유지관리, 사전예방점검, 이상발생조치 등 활동을 수행한다. 국내외 식각 관련 부품·장비 업체로부터 획득한 소재, 부품 및 장치 기술을 정기적으로 시험 평가, 인증, 응용하여 원가절감 및 개조개선 활동을 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체장비기술자","connectJob":"반도체Ashing장비기술자","certLic":"반도체설비보전기능사","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004152:1', '{"dJobCd":"K000004152","dJobCdSeq":"1","dJobNm":"반도체연삭장비기술자","workSum":"반도체 소자 품질수율 및 생산성 향상 활동을 지원하기 위해 웨이퍼 연삭장비를 설치, 평가, 개선, 인증, 유지 관리한다.","doWork":"반도체 웨이퍼 연삭 관련 소재, 부품, 시설, 장치, 장비 및 공정 관련 기술을 이용하여 장비설치 장소에 유틸리티 연결을 위한 배관 시설, 진동 방지 바닥 패널 등을 준비한다. 연삭장비 제조사의 모듈 조립, 유틸리티 연결, 공급 및 시험평가, 시스템 입출력 동작 점검 및 개선, 로봇, 모터, 센서 등의 동작·위치 교정 작업, 기구동작·성능 평가·개선 작업, 유틸리티, 부품, 장치, 모듈 및 장비의 신뢰성 평가, 개선, 인증 활동을 지원한다. 연삭장비의 공정신뢰성 검증 평가를 위해 기초·생산 공정 평가, 개선, 인증을 지원한다. 연삭장비 관련 소재, 부품, 시설, 장치, 장비 기술 전반에 대한 교육을 이수한다. 연삭장비 제조사에서 제공하는 장비 조작, 유지관리, 사전예방 점검, 이상발생조치 관련 사용설명서를 이해하고, 각 항목들에 대한 시험, 검증, 개선 활동을 통해 반도체 조립기술 및 생산 환경에 적합한 소재, 부품, 장치, 장비의 운영방법을 규정하고, 문서화하여 반도체조립 제조원 및 공정기술자와 공유한다. 규정된 문서를 기준으로 장비를 운영할 수 있도록 반도체조립 제조원에게 교육을 실시하여 조립기술 응용 생산 활동을 지원한다. 연삭장비의 정상 동작·운영을 위해 소재, 부품 및 장치의 유지관리, 사전예방점검, 이상발생조치 등 활동을 수행한다. 국내외 연삭 관련 소재·부품·장비 업체로부터 획득한 소재, 부품 및 장치 기술을 정기적으로 시험 평가, 인증, 응용하여 조립기술 원가절감 및 개조개선 활동을 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체장비기술자","connectJob":"반도체그라인딩장비기술자","certLic":"반도체설비보전기능사","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002805:1', '{"dJobCd":"K000002805","dJobCdSeq":"1","dJobNm":"반도체이온주입장비기술자","workSum":"반도체 소자 품질수율 및 생산성 향상 활동을 지원하기 위해 이온주입 장비를 설치, 평가, 개선, 인증, 유지 관리한다.","doWork":"반도체 이온주입 관련 소재, 부품, 시설, 장치, 장비 및 공정 관련 기술을 이용하여 장비설치 장소에 유틸리티 연결을 위한 배관 시설 등을 준비한다. 이온주입장비 제조사의 모듈 조립, 유틸리티 연결, 공급 및 시험평가, 시스템 입출력 동작 점검 및 개선, 로봇, 모터, 센서 등의 동작·위치 교정 작업, 기구동작·성능 평가·개선 작업, 유틸리티, 부품, 장치, 모듈 및 장비의 신뢰성 평가, 개선, 인증 활동을 지원한다. 이온주입장비의 공정신뢰성 검증 평가를 위해 기초·생산 공정 평가, 개선, 인증을 지원한다. 이온주입장비 관련 소재, 부품, 시설, 장치, 장비 기술 전반에 대한 교육을 이수한다. 이온주입 장비제조사에서 제공하는 장비 조작, 유지관리, 사전예방 점검, 이상발생조치 관련 사용설명서를 이해하고, 각 항목들에 대한 시험, 검증, 개선 활동을 통해 반도체 제조기술 및 생산 환경에 적합한 소재, 부품, 장치, 장비의 운영방법을 규정하고, 문서화하여 반도체소자 제조원 및 공정기술자와 공유한다. 규정된 문서를 기준으로 장비를 운영할 수 있도록 반도체소자 제조원에게 교육을 실시하여 이온주입기술 응용 생산 활동을 지원한다. 이온주입장비의 정상 동작·운영을 위해 소재, 부품 및 장치의 유지관리, 사전예방점검, 이상발생조치 등 활동을 수행한다. 국내외 이온주입 관련 부품·장비 업체로부터 획득한 소재, 부품 및 장치 기술을 정기적으로 시험 평가, 인증, 응용하여 원가절감 및 개조개선 활동을 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체장비기술자","certLic":"반도체설비보전기능사","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002907:1', '{"dJobCd":"K000002907","dJobCdSeq":"1","dJobNm":"반도체장비고객지원기술자","workSum":"반도체소자 제조기술 및 고객 요구 성능을 이해하고, 장비의 설치, 평가, 개선, 인증, 유지관리 활동으로 반도체 장비 및 공정의 신뢰성 향상을 지원한다.","doWork":"반도체 장비설치 환경을 고려하여 각종 유틸리티 연결을 위한 배관부와 진동 방지대 등을 고객사 장비기술자와 협의, 준비한다. 반도체장비 소재, 부품, 장치, 모듈 등을 평가 또는 생산 장소에 입고한 다음, 개별 부품 목록, 수량 및 기능 등을 점검한다. 장비 설치 도면 기준으로 유틸리티를 연결한 다음, 전기, 불활성 가스, 초순수 등 유틸리티를 공급하여 각종 배관 연결부 누수 여부를 점검, 조치한다. 장비소프트웨어 설계연구원과 함께 시스템 입출력 동작 점검, 개선을 수행하고, 로봇, 모터, 센서 등의 동작·위치 교정 작업을 수행한다. 공정가스, 화학약품 등 유틸리티를 공급, 누수 여부 점검, 조치한다. 각 모듈별, 장비 전체의 기구동작 및 성능평가를 시험, 개선 조치한다. 장비공정 연구원과 함께 고객 요구수준의 장비신뢰성 평가, 개선, 인증 활동을 수행하고, 공정신뢰성 평가, 개선, 인증을 지원하고, 최종 설치결과를 정리하여 보고서 작성을 지원한다. 고객 측 소자제조원, 공정·장비 기술자에게 소재, 부품, 시설, 장치, 장비 기술 관련 교육을 지원한다. 반도체 생산을 정상상태로 유지하기 위해 일, 주, 월, 분기, 반기 및 년 단위의 사전예방점검 항목을 기준으로 점검, 개선, 부품교체 활동을 지원한다. 장비 이상상황 발생 시 고객사 장비기술자에게 공지하여 생산 운영을 중단시킨 상태에서 짧은 시간 이내 문제를 해결하여 정상적으로 생산 운영될 수 있도록 조치한 다음, 원인분석 및 예방조치 보고서를 작성, 공유한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체장비기술자","certLic":"반도체설비보전기능사","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007391:1', '{"dJobCd":"K000007391","dJobCdSeq":"1","dJobNm":"반도체칩몰딩장비기술자","workSum":"반도체 소자 품질수율 및 생산성 향상 활동을 지원하기 위해 칩몰딩장비를 설치, 평가, 개선, 인증, 유지 관리한다.","doWork":"반도체 칩 몰딩 관련 소재, 부품, 시설, 장치, 장비 및 공정 관련 기술을 이용하여 장비설치 장소에 유틸리티 연결을 위한 배관 시설 등을 준비한다. 칩몰딩장비 제조사의 모듈 조립, 유틸리티 연결, 공급 및 시험평가, 시스템 입출력 동작 점검 및 개선, 로봇, 모터, 센서 등의 동작·위치 교정 작업, 기구동작·성능 평가·개선 작업, 유틸리티, 부품, 장치, 모듈 및 장비의 신뢰성 평가, 개선, 인증 활동을 지원한다. 칩몰딩장비의 공정신뢰성 검증 평가를 위해 기초·생산 공정 평가, 개선, 인증을 지원한다. 칩몰딩장비 관련 소재, 부품, 시설, 장치, 장비 기술 전반에 대한 교육을 이수한다. 칩몰딩장비 제조사에서 제공하는 장비 조작, 유지관리, 사전예방 점검, 이상발생조치 관련 사용설명서를 이해하고, 각 항목들에 대한 시험, 검증, 개선 활동을 통해 반도체 조립기술 및 생산 환경에 적합한 소재, 부품, 장치, 장비의 운영방법을 규정하고, 문서화하여 반도체조립 제조원 및 공정기술자와 공유한다. 규정된 문서를 기준으로 장비를 운영할 수 있도록 반도체조립 제조원에게 교육을 실시하여 조립기술 응용 생산 활동을 지원한다. 칩몰딩장비의 정상 동작·운영을 위해 소재, 부품 및 장치의 유지관리, 사전예방점검, 이상발생조치 등 활동을 수행한다. 국내외 칩몰딩 관련 소재·부품·장비 업체로부터 획득한 소재, 부품 및 장치 기술을 정기적으로 시험 평가, 인증, 응용하여 조립기술 원가절감 및 개조개선 활동을 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체장비기술자","certLic":"반도체설비보전기능사","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003116:1', '{"dJobCd":"K000003116","dJobCdSeq":"1","dJobNm":"반도체칩본딩장비기술자","workSum":"반도체 소자 품질수율 및 생산성 향상 활동을 지원하기 위해 칩본딩장비를 설치, 평가, 개선, 인증, 유지 관리한다.","doWork":"반도체 칩본딩 관련 소재, 부품, 시설, 장치, 장비 및 공정 관련 기술을 이용하여 장비설치 장소에 유틸리티 연결을 위한 배관 시설 등을 준비한다. 칩본딩장비 제조사의 모듈 조립, 유틸리티 연결, 공급 및 시험평가, 시스템 입출력 동작 점검 및 개선, 로봇, 모터, 센서 등의 동작·위치 교정 작업, 기구동작·성능 평가·개선 작업, 유틸리티, 부품, 장치, 모듈 및 장비의 신뢰성 평가, 개선, 인증 활동을 지원한다. 칩본딩장비의 공정신뢰성 검증 평가를 위해 기초·생산 공정 평가, 개선, 인증을 지원한다. 칩본딩장비 관련 소재, 부품, 시설, 장치, 장비 기술 전반에 대한 교육을 이수한다. 칩본딩장비 제조사에서 제공하는 장비 조작, 유지관리, 사전예방 점검, 이상발생조치 관련 사용설명서를 이해하고, 각 항목들에 대한 시험, 검증, 개선 활동을 통해 반도체 조립기술 및 생산 환경에 적합한 소재, 부품, 장치, 장비의 운영방법을 규정하고, 문서화하여 반도체조립 제조원 및 공정기술자와 공유한다. 규정된 문서를 기준으로 장비를 운영할 수 있도록 반도체조립 제조원에게 교육을 실시하여 조립기술 응용 생산 활동을 지원한다. 칩본딩장비의 정상 동작·운영을 위해 소재, 부품 및 장치의 유지관리, 사전예방점검, 이상발생조치 등 활동을 수행한다. 국내외 칩본딩 관련 소재·부품·장비 업체로부터 획득한 소재, 부품 및 장치 기술을 정기적으로 시험 평가, 인증, 응용하여 조립기술 원가절감 및 개조개선 활동을 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체장비기술자","connectJob":"반도체와이어본딩장비기술자, 반도체플립칩본딩장비기술자","certLic":"반도체설비보전기능사","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004555:1', '{"dJobCd":"K000004555","dJobCdSeq":"1","dJobNm":"반도체칩절단장비기술자","workSum":"반도체 소자 품질수율 및 생산성 향상 활동을 지원하기 위해 칩절단장비를 설치, 평가, 개선, 인증, 유지 관리한다.","doWork":"반도체 칩절단 관련 소재, 부품, 시설, 장치, 장비 및 공정 관련 기술을 이용하여 장비설치 장소에 유틸리티 연결을 위한 배관 시설 등을 준비한다. 칩절단장비 제조사의 모듈 조립, 유틸리티 연결, 공급 및 시험평가, 시스템 입출력 동작 점검 및 개선, 로봇, 모터, 센서 등의 동작·위치 교정 작업, 기구동작·성능 평가·개선 작업, 유틸리티, 부품, 장치, 모듈 및 장비의 신뢰성 평가, 개선, 인증 활동을 지원한다. 칩절단장비의 공정신뢰성 검증 평가를 위해 기초·생산 공정 평가, 개선, 인증을 지원한다. 칩절단장비 관련 소재, 부품, 시설, 장치, 장비 기술 전반에 대한 교육을 이수한다. 칩절단장비 제조사에서 제공하는 장비 조작, 유지관리, 사전예방 점검, 이상발생조치 관련 사용설명서를 이해하고, 각 항목들에 대한 시험, 검증, 개선 활동을 통해 반도체 조립기술 및 생산 환경에 적합한 소재, 부품, 장치, 장비의 운영방법을 규정하고, 문서화하여 반도체조립 제조원 및 공정기술자와 공유한다. 규정된 문서를 기준으로 장비를 운영할 수 있도록 반도체조립 제조원에게 교육을 실시하여 조립기술 응용 생산 활동을 지원한다. 칩절단장비의 정상 동작·운영을 위해 소재, 부품 및 장치의 유지관리, 사전예방점검, 이상발생조치 등 활동을 수행한다. 국내외 칩절단 관련 소재·부품·장비 업체로부터 획득한 소재, 부품 및 장치 기술을 정기적으로 시험 평가, 인증, 응용하여 조립기술 원가절감 및 개조개선 활동을 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체장비기술자","connectJob":"반도체칩다이싱장비기술자, 반도체칩쏘잉장비기술자","certLic":"반도체설비보전기능사","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006571:1', '{"dJobCd":"K000006571","dJobCdSeq":"1","dJobNm":"반도체칩접합장비기술자","workSum":"반도체 소자 품질수율 및 생산성 향상 활동을 지원하기 위해 칩접합장비를 설치, 평가, 개선, 인증, 유지 관리한다.","doWork":"반도체 칩접합 관련 소재, 부품, 시설, 장치, 장비 및 공정 관련 기술을 이용하여 장비설치 장소에 유틸리티 연결을 위한 배관 시설 등을 준비한다. 칩접합장비 제조사의 모듈 조립, 유틸리티 연결, 공급 및 시험평가, 시스템 입출력 동작 점검 및 개선, 로봇, 모터, 센서 등의 동작·위치 교정 작업, 기구동작·성능 평가·개선 작업, 유틸리티, 부품, 장치, 모듈 및 장비의 신뢰성 평가, 개선, 인증 활동을 지원한다. 칩접합장비의 공정신뢰성 검증 평가를 위해 기초·생산 공정 평가, 개선, 인증을 지원한다. 칩접합장비 관련 소재, 부품, 시설, 장치, 장비 기술 전반에 대한 교육을 이수한다. 칩접합장비 제조사에서 제공하는 장비 조작, 유지관리, 사전예방 점검, 이상발생조치 관련 사용설명서를 이해하고, 각 항목들에 대한 시험, 검증, 개선 활동을 통해 반도체 조립기술 및 생산 환경에 적합한 소재, 부품, 장치, 장비의 운영방법을 규정하고, 문서화하여 반도체조립 제조원 및 공정기술자와 공유한다. 규정된 문서를 기준으로 장비를 운영할 수 있도록 반도체조립 제조원에게 교육을 실시하여 조립기술 응용 생산 활동을 지원한다. 칩접합장비의 정상 동작·운영을 위해 소재, 부품 및 장치의 유지관리, 사전예방점검, 이상발생조치 등 활동을 수행한다. 국내외 칩접합 관련 소재·부품·장비 업체로부터 획득한 소재, 부품 및 장치 기술을 정기적으로 시험 평가, 인증, 응용하여 조립기술 원가절감 및 개조개선 활동을 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체장비기술자","certLic":"반도체설비보전기능사","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004012:1', '{"dJobCd":"K000004012","dJobCdSeq":"1","dJobNm":"반도체화학기상증착장비기술자","workSum":"반도체 소자 품질수율 및 생산성 향상 활동을 지원하기 위해 화학기상증착장비를 설치, 평가, 개선, 인증, 유지 관리한다.","doWork":"반도체 화학기상증착 관련 소재, 부품, 시설, 장치, 장비 및 공정 관련 기술을 이용하여 장비설치 장소에 유틸리티 연결을 위한 배관 시설 등을 준비한다. 화학기상증착장비 제조사의 모듈 조립, 유틸리티 연결, 공급 및 시험평가, 시스템 입출력 동작 점검 및 개선, 로봇, 모터, 센서 등의 동작·위치 교정 작업, 기구동작·성능 평가·개선 작업, 유틸리티, 부품, 장치, 모듈 및 장비의 신뢰성 평가, 개선, 인증 활동을 지원한다. 화학기상증착장비의 공정신뢰성 검증 평가를 위해 기초·생산 공정 평가, 개선, 인증을 지원한다. 화학기상증착장비 관련 소재, 부품, 시설, 장치, 장비 기술 전반에 대한 교육을 이수한다. 화학기상증착 장비제조사에서 제공하는 장비 조작, 유지관리, 사전예방 점검, 이상발생조치 관련 사용설명서를 이해하고, 각 항목들에 대한 시험, 검증, 개선 활동을 통해 반도체 제조기술 및 생산 환경에 적합한 소재, 부품, 장치, 장비의 운영방법을 규정하고, 문서화하여 반도체소자 제조원 및 공정기술자와 공유한다. 규정된 문서를 기준으로 장비를 운영할 수 있도록 반도체소자 제조원에게 교육을 실시하여 화학기상증착기술 응용 생산 활동을 지원한다. 화학기상증착장비의 정상 동작·운영을 위해 소재, 부품 및 장치의 유지관리, 사전예방점검, 이상발생조치 등 활동을 수행한다. 국내외 화학기상증착 관련 부품·장비 업체로부터 획득한 소재, 부품 및 장치 기술을 정기적으로 시험 평가, 인증, 응용하여 원가절감 및 개조개선 활동을 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체장비기술자","connectJob":"반도체스퍼터링장비기술자, 반도체원자층증착장비기술자","certLic":"반도체설비보전기능사","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002501:1', '{"dJobCd":"K000002501","dJobCdSeq":"1","dJobNm":"반도체화학적기계적연마장비기술자","workSum":"반도체 소자 품질수율 및 생산성 향상 활동을 지원하기 위해 화학적기계적연마장비를 설치, 평가, 개선, 인증, 유지 관리한다.","doWork":"반도체 화학적기계적연마 관련 소재, 부품, 시설, 장치, 장비 및 공정 관련 기술을 이용하여 장비설치 장소에 유틸리티 연결을 위한 배관 시설, 진동 방지 바닥 패널 등을 준비한다. 화학적기계적연마장비 제조사의 모듈 조립, 유틸리티 연결, 공급 및 시험평가, 시스템 입출력 동작 점검 및 개선, 로봇, 모터, 센서 등의 동작·위치 교정 작업, 기구동작·성능 평가·개선 작업, 유틸리티, 부품, 장치, 모듈 및 장비의 신뢰성 평가, 개선, 인증 활동을 지원한다. 화학적기계적연마장비의 공정신뢰성 검증 평가를 위해 기초·생산 공정 평가, 개선, 인증을 지원한다. 화학적기계적연마장비 관련 소재, 부품, 시설, 장치, 장비 기술 전반에 대한 교육을 이수한다. 화학적기계적연마 장비제조사에서 제공하는 장비 조작, 유지관리, 사전예방 점검, 이상발생조치 관련 사용설명서를 이해하고, 각 항목들에 대한 시험, 검증, 개선 활동을 통해 반도체 제조기술 및 생산 환경에 적합한 소재, 부품, 장치, 장비의 운영방법을 규정하고, 문서화하여 반도체소자 제조원 및 공정기술자와 공유한다. 규정된 문서를 기준으로 장비를 운영할 수 있도록 반도체소자 제조원에게 교육을 실시하여 화학적기계적연마기술 응용 생산 활동을 지원한다. 화학적기계적연마장비의 정상 동작·운영을 위해 소재, 부품 및 장치의 유지관리, 사전예방점검, 이상발생조치 등 활동을 수행한다. 국내외 화학적기계적연마 관련 부품·장비 업체로부터 획득한 소재, 부품 및 장치 기술을 정기적으로 시험 평가, 인증, 응용하여 원가절감 및 개조개선 활동을 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체장비기술자","certLic":"반도체설비보전기능사","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004001:1', '{"dJobCd":"K000004001","dJobCdSeq":"1","dJobNm":"반도체확산장비기술자","workSum":"반도체 소자 품질수율 및 생산성 향상 활동을 지원하기 위해 확산장비를 설치, 평가, 개선, 인증, 유지 관리한다.","doWork":"반도체 확산 관련 소재, 부품, 시설, 장치, 장비 및 공정 관련 기술을 이용하여 장비설치 장소에 유틸리티 연결을 위한 배관 시설 등을 준비한다. 확산장비 제조사의 모듈 조립, 유틸리티 연결, 공급 및 시험평가, 시스템 입출력 동작 점검 및 개선, 로봇, 모터, 센서 등의 동작·위치 교정 작업, 기구동작·성능 평가·개선 작업, 유틸리티, 부품, 장치, 모듈 및 장비의 신뢰성 평가, 개선, 인증 활동을 지원한다. 확산장비의 공정신뢰성 검증 평가를 위해 기초·생산 공정 평가, 개선, 인증을 지원한다. 확산장비 관련 소재, 부품, 시설, 장치, 장비 기술 전반에 대한 교육을 이수한다. 확산장비 제조사에서 제공하는 장비 조작, 유지관리, 사전예방 점검, 이상발생조치 관련 사용설명서를 이해하고, 각 항목들에 대한 시험, 검증, 개선 활동을 통해 반도체 제조기술 및 생산 환경에 적합한 소재, 부품, 장치, 장비의 운영방법을 규정하고, 문서화하여 반도체소자 제조원 및 공정기술자와 공유한다. 규정된 문서를 기준으로 장비를 운영할 수 있도록 반도체소자 제조원에게 교육을 실시하여 확산기술 응용 생산 활동을 지원한다. 확산장비의 정상 동작·운영을 위해 소재, 부품 및 장치의 유지관리, 사전예방점검, 이상발생조치 등 활동을 수행한다. 국내외 확산 관련 부품·장비 업체로부터 획득한 소재, 부품 및 장치 기술을 정기적으로 시험 평가, 인증, 응용하여 원가절감 및 개조개선 활동을 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체장비기술자","connectJob":"반도체열처리장비기술자, 반도체열산화막장비기술자, 반도체RTP장비기술자, 반도체Furnace장비기술자","certLic":"반도체설비보전기능사","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004057:1', '{"dJobCd":"K000004057","dJobCdSeq":"1","dJobNm":"발전기계설비정비반장","workSum":"발전소에서 열·전기를 생산하는 보일러, 터빈, 발전기 등 발전기계설비의 장애요인을 제거하고 파손된 부품을 교체·보수하는데 종사하는 작업원들의 활동을 감독·조정한다.","doWork":"작업계획에 따라 세부실행항목을 수립하여 작업 절차 및 방법을 결정한다. 작업원이 효율적으로 작업할 수 있도록 위치를 배정하고, 작업내용을 지시한다. 작업진행상황을 파악하고 작업내용을 보고한다. 작업원의 작업상황을 관리·감독하고 작업공정에 있어 필요한 자재 및 기술을 지원한다. 파손기계의 상태를 파악하고 원인을 규명한다. 작업에 소요된 부품의 종류 및 수량을 작업일지에 기록한다. 작업원과 함께 작업하며 표준명세에 따라 지시된 작업이 이루어지는지 작업상황을 관찰하고, 작업내용을 점검한다. 작업이 완료되면 작업내용을 일지에 기록한다. 작업원에 대한 직무교육 및 안전위생교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시로 관찰과 면담을 통하여 작업원의 애로 및 건의사항을 수렴·해결하고 문제점을 보고한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"감독","workFunc3":"정밀작업","certLic":"기계정비기능사, 기계정비산업기사","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004391:1', '{"dJobCd":"K000004391","dJobCdSeq":"1","dJobNm":"발전설비기계정비원","workSum":"발전에 사용되는 각종 기계설비 및 부품을 점검하여 유지·관리하고, 결함을 제거하기 위하여 장비를 사용하여 정비한다.","doWork":"발전기계 설비를 정기적으로 점검하고, 점검사항을 일지에 기록한다. 파손부위의 설계도를 점검하여 파손상태와 파손정도를 확인한다. 각종 장비를 사용하여 파손된 부품을 분해하고, 파손상태를 확인한다. 파손원인을 규명하고 부품을 교체한다. 보수가 완료되면 시험가동을 실시하여 정상 작동 여부를 확인한 후 재조립한다. 작업에 소요된 부품의 종류, 규격 및 수량 등을 일지에 기록하고 파손원인 및 방지대책을 검토한다. 기계설비에 사용되는 특수부품이나 장비를 조립한다. 보수가 불가능한 기계설비는 전문업체에 의뢰하여 신속한 복구가 이루어지도록 조치하고 공사시공을 관리·감독한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"감독","workFunc3":"정밀작업","connectJob":"보일러기계설비정비원, 터빈기계설비정비원, 화력발전설비정비원, 수력발전설비정비원, 원자력발전설비정비원, 풍력발전설비정비원, 조력발전설비정비원, 태양광발전설비정비원","certLic":"기계정비기능사, 기계정비산업기사","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006820:1', '{"dJobCd":"K000006820","dJobCdSeq":"1","dJobNm":"북수리원","workSum":"직기의 목재 및 플라스틱 북을 검사하고 수리한다.","doWork":"북(Shuttle)을 검사하여 쪼개어진 곳, 매듭진 곳, 긁힌 곳 등의 결함이 있는지 확인한다. 스크루드라이버를 사용하여 금속부분이나 북 모서리부분을 제거한다. 연마용 헝겊 및 연마기를 사용하여 금속부분품을 깨끗이 닦아 윤을 낸다. 사포나 샌딩 기계를 사용하여 북의 거친 부분을 부드럽게 한다. 스크루드라이버를 사용하여 금속부분을 재조립한다. 렌치 및 스크루드라이버를 사용하여 직기의 파손된 북을 제거하거나 교환한다. 북을 직기에 설치하기 전 직경을 확인하기 위하여 게이지나 자를 사용하여 북의 외형을 측정한다. 수리현황을 작업일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"직기북정비원","certLic":"기계정비기능사, 기계정비산업기사","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"C132","dJobICdNm":"[C132]직물직조 및 직물제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003333:1', '{"dJobCd":"K000003333","dJobCdSeq":"1","dJobNm":"생산설비관리원","workSum":"생산에 필요한 설비·치공구 계측기기 및 기계설비를 점검하고 유지·보수하며 설비를 개선·개발·발주·관리하는 일을 한다.","doWork":"현장의 작업원들에게 필요한 공구를 지급한다. 설비상의 문제점을 파악·취합하여 개선한다. 공구보유량 및 적정수량을 파악하고 재고를 관리한다. 기계, 전기, 건물부속 설비를 점검하고 보수사항을 관련 부서에 연락하여 보수를 의뢰한다. 생산에 필요한 지그, 비품계측기기, 기판, 생산장비, 운송장비 등을 관리하며 제작에 관한 품의서를 작성·구입·의뢰한다. 필요 생산 물량에 대비하여 생산설비 증설계획 및 운영계획을 세우기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"설치","similarNm":"설비보전원","certLic":"기계정비기능사, 기계정비산업기사","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"C","dJobICdNm":"[C]제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007442:1', '{"dJobCd":"K000007442","dJobCdSeq":"1","dJobNm":"석유화학설비유지보수원","workSum":"설비의 기능을 유지하기 위해 정비계획에 따라 점검, 보수, 부품관리 등을 수행한다.","doWork":"설비 내 물질을 조사하고 공정 유체를 제거·차단과 가스 누출 및 배관 내부 압력을 점검한다. 설비도면과 설비 작동원리를 이해하고 설비별 특성 파악 후 설비 가동 전·후를 비교한다. 보수·정비 이력을 파악 후 보수·정비 계획을 수립하고, 설비 보수·정비를 실시한다. 고장 목록을 정리하고 고장 파급효과, 발생빈도·심각도·검출도를 확인하고 고장모드에 대한 영향분석을 실시한다. 설비부품 구매항목을 조사하고, 설비부품을 구매요청하고 설비부품의 성능을 확인한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"C201","dJobICdNm":"[C201]기초 화학물질 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007443:1', '{"dJobCd":"K000007443","dJobCdSeq":"1","dJobNm":"석유화학유틸리티관리자","workSum":"유틸리티의 생산 및 분배의 효율성을 높이기 위하여 정확하고 안정적인 측정과 모니터링을 통해 에너지 손실 최소화 및 최적화하는 업무를 수행한다.","doWork":"사용처별 사용량을 파악하기 위해 증감 요인을 분석하고 유틸리티 수급계획을 수립·보완하고 유틸리티 효율성을 계산한다. 종합 유틸리티의 효율성 극대화 방안을 도출하기 위해 최적화 시뮬레이션과 방안을 수립한다. 사용처별 에너지 절감 항목을 파악하여 에너지 절감 개선계획을 수립하며 계획을 적용하여 개선하고 효율성을 평가한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"C201","dJobICdNm":"[C201]기초 화학물질 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007444:1', '{"dJobCd":"K000007444","dJobCdSeq":"1","dJobNm":"석유화학유틸리티운전원","workSum":"생산공정에 필요한 증기, 전기, 용수 등을 정확하게 공급하기 위하여 유틸리티 수급계획에 따라 설비 및 제어시스템을 운영한다.","doWork":"작업표준 (정상운전 작업절차, 이상시 조치작업 절차 등) 에 따라 담당 유틸리티 설비를 안전하고 효율적으로 운전한다. 사용량 증감에 따라 신속히 조치하여 유틸리티의 공급에 차질이 없도록 운전한다. \n특히 비상상황별 매뉴얼을 숙지하여 비상상황 발생시 신속히 조치 한 후 개선방안을 수립한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"C201","dJobICdNm":"[C201]기초 화학물질 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003857:1', '{"dJobCd":"K000003857","dJobCdSeq":"1","dJobNm":"선박수압검사원","workSum":"선박 및 해양구조물의 구획이나 각 탱크로 구성된 격벽에 누수 및 누유 또는 변형을 검사하기 위하여 수압시험을 한다.","doWork":"작업지시서를 보고 필요한 공구를 준비한다. 선각(船殼) 본작업 및 주변공간작업, 관통 파이프 및 파이프라인 작업이 완료되었는지 확인한다. 수압 및 공기시험을 실시하여 장애요소가 있는지 점검한다. 수압시험장비와 기타 압력장치, 초음파검사기를 준비한다. 각종 파이프라인, 통풍구 및 맨홀(Manhole)을 밀폐시키고 공기나 물을 급수할 수 있는 밸브를 설치한다. 승인된 탱크 시험계획에 준해 공기나 물을 주입하여 이상 유무를 검사한다. 결함이 발생된 부위는 수정하거나 관련 부서에 통보한다. 자체시험이 끝나면 선주 및 선급 검사관의 검사를 실시하여 승인을 받는다. 검사가 끝나면 공기나 물을 빼고 밀폐시킨 부위를 제거하여 원상태로 복귀한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"균형감각|손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"누설비파괴검사기사","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"C311","dJobICdNm":"[C311]선박 및 보트 건조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004465:1', '{"dJobCd":"K000004465","dJobCdSeq":"1","dJobNm":"섬유방사노즐교환원","workSum":"합성섬유의 실을 방사하는 노즐(Nozzle)불량으로 끊어진 필라멘트를 찾아내고 노즐을 교환한다.","doWork":"사절추를 확인하고 노즐면의 오염상태를 확인한다. 노즐면 청소용 수동분사기를 사용하여 물, 공기를 분사한다. 파손된 노즐팩을 제거하고 새로운 노즐팩을 삽입한다. 작업물량에 따라 예비 자재를 확인하고 준비한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","similarNm":"와이핑원, 팩교체원","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"C205","dJobICdNm":"[C205]화학섬유 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001428:1', '{"dJobCd":"K000001428","dJobCdSeq":"1","dJobNm":"섬유방사노즐세정원","workSum":"화학섬유 방사공정에 사용되는 노즐팩(Nozzle Pack)을 분해하여 세척하고 조립한다.","doWork":"사용주기에 따라 파손된 노즐팩을 회수한다. 수동공구를 사용하여 노즐팩을 분해한다. 각 부품을 전기로에 넣어 불순물을 태우거나 화학약품으로 세척한다. 부품을 건조시키고 조립한다. 노즐팩을 방사온도로 맞추기 위해 가열기에 넣어 예열한다. 파손된 부품을 제작하기도 하고 동력연마기를 사용하여 표면을 연마하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","similarNm":"구금처리원","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"C205","dJobICdNm":"[C205]화학섬유 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001915:1', '{"dJobCd":"K000001915","dJobCdSeq":"1","dJobNm":"성형프레스설치원","workSum":"전기용 세라믹 제품 및 애자를 생산하기 위해 다양한 형태의 제품을 성형할 수 있는 프레스 금형을 설치한다.","doWork":"각 공정원의 보고에 따라 프레스기계 설비상의 문제 및 기계노후, 부품파손 등에 의하여 생산공정에 문제가 발생하거나 공정상의 하자가 발생하여 성형제품의 규격, 모양, 형태 등에 이상 유무가 있을 경우 성형프레스기기를 점검하고 확인한다. 기기의 교환 및 교체가 필요할 경우 제품별로 요구되는 프레스 금형을 외부 제작업체에 주문하기 위해 기계조건, 제품특성, 수축률, 재질 등을 고려하고 각 부품별로 세부적인 주문사항을 작성한다. 주문된 금형이 입고되면 기계적 특성을 고려하여 성형프레스기에 각 부품별로 장착하고, 양산에 들어가기 전에 시제품을 만들어 시험한다. 시제품 시험을 통해 소성 시의 제품변형, 수축률 등을 파악하고 원하는 제품이 나올 때까지 설치된 프레스의 각 부품별로 미세 조정작업을 한다. 당일 생산이 시작되기 전에 프레스기에 해당 금형을 설치한다. 수시로 성형프레스기의 작동상태를 점검하고 생산된 제품의 품질을 통해 기계의 이상 유무를 파악한다. 새로운 제품의 주문이 들어오면 주문제품의 도면을 검토하여 생산가능 여부를 파악한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"설치","certLic":"금형기능사, 금형제작기능장, 사출금형산업기사, 프레스금형산업기사","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005758:1', '{"dJobCd":"K000005758","dJobCdSeq":"1","dJobNm":"소면기마침원","workSum":"소면기의 실린더, 테이커인(Taker In), 플랫(Flat), 도퍼(Doffer)의 손상이나 마모된 부분을 연마기로 연마하고 간격게이지(Space Gauge)로 측정하여 높이를 일정하게 한다.","doWork":"연마롤러를 기계 위에 있는 받침대에 올려놓는다. 드럼의 침 끝과 연마롤러의 압력을 조절하기 위하여 연삭음을 들어보거나 불꽃이 알맞은 정도가 되도록 간격을 조정한다. 연마롤러를 왕복 운동시켜 침 끝을 연마한다. 소면기계에서 침포(針布:방적용 빗질 기계에 쓰는 작은 바늘을 심은 띠 모양의 기구)를 떼어내어 운반수레에 실어 연마기로 운반한다. 진공소제기를 사용하여 침포에 묻어있는 섬유부스러기나 불순물들을 제거 및 소제한다. 침포를 연마기에 고정하고 연마기를 가동하여 마찰되는 불꽃이나 소리를 들어 간격을 일정하게 한다. 연마가 끝난 침포를 소면기계에 조립한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"소면기침수리원","certLic":"기계정비기능사, 기계정비산업기사","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001415:1', '{"dJobCd":"K000001415","dJobCdSeq":"1","dJobNm":"소면기보전원","workSum":"기계조작에 관한 지식을 적용하여 원료 또는 랩(Lap)상태의 솜(면, 아크릴)을 슬리버(Sliver:면섬유 다발)로 생산하는 소면기를 조정·수리한다.","doWork":"보전에 필요한 부속자재를 수령하여 운반·보관한다. 주기적인 정비계획이나 필요에 따라 가공할 원료의 종류, 기계의 효율 등 기계에 관한 지식과 가공에 관한 지식을 이용하여 기계의 운전 상태를 점검한다. 수동공구를 사용하여 각종 롤러 및 실린더 언더케이싱(Under Casing), 테이커인(Taker In) 등을 분해·소제한다. 각 롤러와 롤러 사이의 게이지를 점검·조정한다. 회전부위의 소음 등 기계의 장애를 점검하고 웨이브(Wave)의 방출상태를 확인한다. 각 요소에 오일 및 그리스를 주입한다. 주요 수리내용을 기록일지에 기록·보관한다. 솔이나 공기호스를 사용하여 기계의 주변을 깨끗이 정리·소제한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"소면기정비원","certLic":"기계정비기능사, 기계정비산업기사","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005913:1', '{"dJobCd":"K000005913","dJobCdSeq":"1","dJobNm":"수력발전설비설치원","workSum":"터빈(수차), 발전기, 변압기, 제어설비 등의 수력발전설비 및 주변기기를 설치한다.","doWork":"설계도를 검토하고 발전방식(수로식, 댐식, 터널식) 및 발전설비를 확인한다. 구성품인 터빈(수차), 발전기, 변압기 등의 전기설비, 기계설비 및 송전설비 등을 크레인 등의 지원을 받아 조립·설치한다. 각종 측정기구를 사용하여 장비의 고장이나 기능장애를 검사하고 부품이나 장치의 조립상태, 마모상태, 균열 등을 점검하는 기술적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"기계정비기능사, 기계정비산업기사","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"F412","dJobICdNm":"[F412]토목 건설업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003070:1', '{"dJobCd":"K000003070","dJobCdSeq":"1","dJobNm":"수력발전설비유지보수원","workSum":"전기설비, 기계설비, 제어설비 등 수력발전설비 및 주변기기를 유지·보수한다.","doWork":"전기설비(발전기, 변압기 등), 기계설비(터빈(수차)) 및 제어설비 등의 수력발전설비 및 주변기기들의 기계적, 전기적 고장 시에 부품을 교체하거나 구성품을 수리한다. 터빈의 조속기(Governor)를 수리한다. 발전기의 회전자(전기자) 및 고정자, 슬립링(Slip Ring:전기를 외부로 끌어내는 장치) 등 노후된 부품을 교체한다. 자동전압조절기 및 냉각장치의 고장 시 수리한다. 송전설비인 차단기, 개폐기 등을 수리한다. 고장이 발생한 설비를 정비업체에 의뢰하여 수리하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"전기공사산업기사, 전기기능사, 전기산업기사, 전기기능장, 설비보전기능사, 설비보전기사, 기계정비기능사, 기계정비산업기사","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007074:1', '{"dJobCd":"K000007074","dJobCdSeq":"1","dJobNm":"스마트공장시스템설치원","workSum":"스마트공장 시스템의 사양을 검토하여 특성을 파악하고 하드웨어, 소프트웨어, 네트워크, 보안 설비 등을 설치한다.","doWork":"시스템 설치 도면을 검토하고 사용자 요구 조건에 따라 시스템 설치 사양 등을 검토한다. 스마트공장 구성요소의 매뉴얼을 확인하고 사용목적 및 시스템 특성을 파악한다. 스마트공장 시스템 상호 간의 원활한 통신 네트워크 운영을 위해 통신 네트워크 설비를 설치한다. 시스템 운용에 필요한 데이터 수집을 위한 데이터 수집 장치 및 데이터 인터페이스 장치를 설치한다. 경영 정보 시스템, 제조 정보 시스템, 감시 제어 시스템 등을 설치한다. 스마트 설비, 전기 장치, 통신장치의 연동 및 시스템의 원활한 작동을 시험한다. 보안 요구사항에 맞춰 보안 시스템을 준비하여 설치한다. 구축이 완료된 스마트공장 시스템이 설치계획에 따라 정상 작동하는지 시스템을 검증한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"정보처리기사, 정보처리산업기사","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"J620","dJobICdNm":"[J620]컴퓨터 프로그래밍, 시스템 통합 및 관리업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006393:1', '{"dJobCd":"K000006393","dJobCdSeq":"1","dJobNm":"실린더밸브수리원","workSum":"화학공장의 압축·액화 가스 실린더, 드럼 등에 설치된 안전밸브 및 유량조절밸브를 점검하고 수리한다.","doWork":"공장의 각종 공정을 순회하면서 렌치, 바이스 및 수동공구를 사용하여 밸브를 분해한다. 표면에 결함이 있는지 또는 체결부나 나사면에 결함이 있는지를 검사한다. 손연삭기로 밸브면을 다듬는다. 체결부를 탭 및 다이로 가공한다. 부분품을 세척용 용기에 넣어 세척하여 실린더에 조립한다. 실린더 용기에 고압가스를 충전하고 용접부위 및 가스누설이 예상되는 부분에 비눗물을 칠하여 거품의 발생 여부를 살핀다. 실험된 밸브의 수압 및 공압 실험의 결과를 기록한다. 충진된 고압가스의 압력을 시험하기 위하여 압력 게이지를 부착하고 공기밸브를 열기도 한다. 부식의 상태를 확인하고, 노후된 기기 장치류는 새로운 설비로 교체를 요구한다. 기기 장치의 정비 내역을 일자별로 기록해 예방 정비 계획을 세우는 데 기초자료를 만든다. 주기적인 점검 계획과 연차 보수 계획을 수립하기 위한 자료를 제공한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"힘든 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"설비보전원, 설비담당원, 밸브수선원","certLic":"위험물기능사, 위험물산업기사, 위험물기능장, 배관산업기사","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"C201","dJobICdNm":"[C201]기초 화학물질 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003763:1', '{"dJobCd":"K000003763","dJobCdSeq":"1","dJobNm":"실크리어러수리원","workSum":"실의 결점을 제거해 주는 실크리어러(Varn Clearer)를 수리한다.","doWork":"고장 난 실크리어러와 그 부품을 분리하여 수리대에 핸드카로 운반한다. 고장 난 부분을 분류하기 위하여 시험기에 걸어 시험한다. 저항치가 변화된 것은 규정에 맞도록 조절하고 마모된 부품과 손상된 것을 교환한다. 전용 테스터기로 이상 유무를 작동·시험하고 조립한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"정사기수리원","certLic":"기계정비기능사, 기계정비산업기사","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005290:1', '{"dJobCd":"K000005290","dJobCdSeq":"1","dJobNm":"연조기보전원","workSum":"실의 균제도를 향상하기 위하여 여러 개의 슬리버를 합하여 가는 슬리버로 만드는 연조기계를 조정·수리한다.","doWork":"주기적인 정비계획이나 필요에 따라 원료의 종류, 기계의 효율, 가공에 관한 지식 등을 이용하여 기계의 소리나 진동상태 등을 파악하고 기계의 운전 상태를 점검한다. 수동공구를 사용하여 롤러부분, 코일링헤드(Coiling Head), 캘린더 롤러(Calender Roller) 등 기계의 부속품을 분해·소제·수리한다. 각 요소에 오일 및 그리스를 주입한다. 교체된 부속, 수리한 내용을 작업일지에 기록·보관한다. 솔, 공기호스 등으로 기계 주변을 정리·소제하여 운전중단을 예방한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"연조기정비원","certLic":"기계정비기능사, 기계정비산업기사","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004447:1', '{"dJobCd":"K000004447","dJobCdSeq":"1","dJobNm":"온실가스저감장치설치원","workSum":"온실가스저감장치를 운송장비, 생산설비 등에 설치한다.","doWork":"온실가스저감장치의 설치 장소(자동차, 생산설비, 연소설비 등)의 구조와 도면, 전체 작업계획을 파악한다. 세부 작업계획을 수립하고 구체적인 작업방법을 계획한다. 설치작업 중 발생하는 기술적 문제의 해결을 위해 온실가스저감장치기술자에게 자문을 구한다. 온실가스저감장치의 설치 후 저감장치를 운전하여 정상작동 여부를 평가한다. 배출되는 온실가스의 양을 측정하여 저감 정도를 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"기계정비기능사, 기계정비산업기사","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"C292","dJobICdNm":"[C292]특수 목적용 기계 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003956:1', '{"dJobCd":"K000003956","dJobCdSeq":"1","dJobNm":"용수설비정비반장","workSum":"용수를 공급하는 기계장치, 전기장치, 배관설비의 원활한 운전을 위하여 정비작업계획을 수립하고 작업원을 감독·조정한다.","doWork":"시설운영부서의 작업의뢰나 운전 중 시설점검 결과에 의거 우선순위에 따라 정비계획을 수립한다. 점검과 보수가 필요한 장치나 시설의 정비계획을 수립하여 필요한 부품을 확보한다. 정비에 필요한 장비나 인력수급계획을 수립한다. 해당 장치나 시설의 표준정비작업 절차와 경험을 작업원에게 교육한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","certLic":"기계정비기능사, 기계정비산업기사, 정수시설운영관리사(1급, 2급, 3급)","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"E360","dJobICdNm":"[E360]수도업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004612:1', '{"dJobCd":"K000004612","dJobCdSeq":"1","dJobNm":"용수설비정비원","workSum":"용수를 공급하는 기계장치, 전기장치, 배관설비의 정상작동이 이루어지도록 이상 및 장애요인을 제거·정비한다.","doWork":"정비작업에 대한 주요 사항을 용수설비정비반장의 지시나 작업지시서를 확인한다. 정비계획에 따라 필요한 정비 장비와 설비를 준비하여 설비를 점검한다. 정비작업 의뢰나 점검결과에 따라 우선순위별로 정비작업을 실시한다. 정비에 필요한 장비나 장치의 이상 유무를 점검한다. 각종 용수설비(관개용 수로, 물을 끌어오기 위하여 설치되는 각종 시설)를 작업절차에 따라 정비하고 보수한다. 정비에 따른 필요한 기술 및 자재를 용수설비정비반장에게 요청한다. 정비일지에 작업내용을 기록하여 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"기계정비기능사, 기계정비산업기사, 정수시설운영관리사(1급, 2급, 3급)","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"E360","dJobICdNm":"[E360]수도업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002492:1', '{"dJobCd":"K000002492","dJobCdSeq":"1","dJobNm":"우편기계보수원","workSum":"우편업무용 자동화설비의 운용을 지원하고 유지·보수한다.","doWork":"우편집중국에서 각종 제어실과 옥내 운반기계설비 및 우편구분시설 등을 운용·유지한다. 서장구분기(LSM: Letter Sorting Machine, 우편봉투에 인쇄된 바코드를 판독하여 우편물을 우편번호별로 구분하는 기계), 서장비닐파속기, 대형통상우편물구분기, 소인기, 운반장비, 발착시설, 우편자루걸이대 등을 유지·보수한다. 우편작업기계의 각종 부품을 수급·관리한다. 국제우편국에서 반송설비, 승강기기 및 중앙통제설비 등을 운용하고 유지·보수하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"기계정비기능사, 기계정비산업기사","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"J611","dJobICdNm":"[J611]공영 우편업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007302:1', '{"dJobCd":"K000007302","dJobCdSeq":"1","dJobNm":"의약품생산지원기술자","workSum":"작업자의 안전과 위생, 제조설비 관리, 보관관리, 공기조화장치 관리, 제조용수 관리, 환경안전위생 관리 등의 정해진 업무를 GMP 규정에 따라 수행한다.","doWork":"원부자재, 반제품 및 완제품을 조건별로 보관, 출하 관리 하며 반품 및 부적합품의 폐기 등을 관리한다. 공기조화시스템 도면을 활용하여 공기조화시스템 파악 및 청정도 등급별 공기 품질을 파악한다. 제조용수 관리항목별 품질요건에 맞춰 품질을 유지하고, 제조소 구역별 등급에 맞는 제조용수 공급한다. 폐수 및 폐기물 안전 처리와 작업장 및 작업자의 위생을 관리하고, 사고발생 비상조치 계획 수립 및 안전사고에 대응한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"C211","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002817:1', '{"dJobCd":"K000002817","dJobCdSeq":"1","dJobNm":"인쇄기계정비원","workSum":"서적·신문 및 각종 인쇄물을 인쇄하는 자동 및 반자동 인쇄기를 검사하고 이상이 있으면 수리한다.","doWork":"가동 중인 인쇄기의 작동상태와 인쇄상태를 점검하고 필요한 조정을 한다. 일정한 주기로 인쇄기를 전체 또는 부분적으로 분해하여 청소하고, 낡은 롤(Roll)을 교체한다. 재조립된 인쇄기를 시험운전하고 인쇄기계의 가동특성을 인쇄담당자에게 알려준다. 지시된 치수에 따라 종이나 판지를 자르는 동력절단기를 설치·수리하기도 한다. 새로운 인쇄 장비를 도입하여 설치하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"그라비어인쇄기정비원, 스크린인쇄기정비원, 오프셋인쇄기정비원","certLic":"기계정비기능사, 기계정비산업기사, 인쇄산업기사, 인쇄기능사, 인쇄기사","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"C340","dJobICdNm":"[C340]산업용 기계 및 장비 수리업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002639:1', '{"dJobCd":"K000002639","dJobCdSeq":"1","dJobNm":"자동화장비설치원","workSum":"업체의 요구에 따라 자동 세차기와 같은 자동화 관련 장비를 설치, 점검, 정비한다.","doWork":"기업체로부터 설치 주문을 확인한다. 현지방문을 통해 제조공정 및 설비설치도를 작성한다. 장비설정 및 주문계약을 체결한 후 설치 장비를 사용하여 자동화장비를 설치하며, 설비 설치와 관련된 감독을 한다. 자동화장비설치 후 서비스와 관련된 계약을 체결하고 일정 기간 점검 및 유지 보수업무를 수행한다. 기업체 또는 용역회사부터 자동화 장비의 고장신고를 받은 후 접수 내역에 따라 정비계획을 수립하여 필요한 장비 및 공구를 준비한다. 자동화설비의 윤활 상태를 점검하고 점검표를 토대로 고장 유무를 확인한다. 고장 상태에 따라 부품의 교체 또는 윤활유를 주입한다. 소비자의 요구에 따라 기계의 재설치 및 정기적인 점검을 실시하기도 하며, 정비 후 정비목록을 작성한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"설치","similarNm":"자동화장비수리원, 자동화기계정비원, 자동화장비유지보수원","connectJob":"자동화장비유지보수원","certLic":"기계정비기능사, 기계정비산업기사, 생산자동화산업기사, 생산자동화기능사","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"C340","dJobICdNm":"[C340]산업용 기계 및 장비 수리업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002515:1', '{"dJobCd":"K000002515","dJobCdSeq":"1","dJobNm":"전자부품자삽설비수리원","workSum":"인쇄회로기판에 트랜지스터·콘덴서 등 전자부품을 자동으로 삽입하는 설비를 유지·정비·보수한다.","doWork":"수리용 각종 공구, 오실로스코프, 테스터 등을 사용하여 자동삽입 설비의 고장을 수리하고 정기 및 수시로 주유·점검한다. 수리를 마친 후 기계 정비 이력카드를 작성·관리한다. 조작원들에게 기계교육을 실시한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"자삽기정비원","connectJob":"에스엠디(SMD)기정비원","certLic":"전자부품장착기능사, 전자부품장착산업기사","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"C340","dJobICdNm":"[C340]산업용 기계 및 장비 수리업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007303:1', '{"dJobCd":"K000007303","dJobCdSeq":"1","dJobNm":"정밀화학설비점검원","workSum":"정밀화학 설비의 기능을 유지하기 위해 설비 보전계획에 따라 설비를 일상적으로 점검한다.","doWork":"일상 점검 항목의 자주·계획 보전 역할을 구분하여 업무를 수행한다. 작업지시서를 바탕으로 설비 일상 점검 계획을 수립하고 일상 점검 체크리스트를 작성하여 점검을 실시한다. 일상 점검을 실시하면서 이상 징후 발견 시 작업지시서 또는 감독자의 지시에 따라 적절한 조치를 취한다. 설비의 특성에 맞는 자주 보전계획을 수립하고 설비의 기본 조건을 유지하고 소정비를 실시한다. 불합리한 것을 발견한 경우 관리감독자에게 보고하여 일상 점검 항목을 수정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"C203/C204","dJobICdNm":"[C203]비료, 농약 및 살균, 살충제 제조업 / [C204]기타 화학제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004889:1', '{"dJobCd":"K000004889","dJobCdSeq":"1","dJobNm":"정방기보전원","workSum":"정방기계와 가공에 관한 지식을 이용해 필요한 굵기로 잡아 늘여 실을 만드는 정방기계를 조정·수리한다.","doWork":"보전에 필요한 자재를 청구하고 운반하여 비치한다. 주기적인 정비계획이나 필요에 따라 기계의 운전 상태를 점검하고 부품을 분해·소제·수리한다. 스핀들 위에 플럼을 설치하고 스핀들과 원주 사이의 틈이 동일하도록 조정한다. 기계를 시동하고 스핀들을 관찰한다. 보텀롤러(Bottom Roller) 부분의 롤러 진곡을 수정한다. 자동변속 풀리와 자동계수 수치가 일치하는지 조사한다. 부품이나 연결부분에 솜이나 이물질이 끼어 작동에 지장을 주는지 점검하고 소제한다. 각종 벨트의 장력을 조절한다. 스핀들을 작동하는 테이프가 끊어지거나 낡은 것은 교체한다. 수리내용을 기록일지에 기록·보관한다. 솔이나 공기호스를 사용하여 기계 주변 낙물 및 먼지를 깨끗이 소제한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"정방기정비원","certLic":"기계정비기능사, 기계정비산업기사","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004979:1', '{"dJobCd":"K000004979","dJobCdSeq":"1","dJobNm":"정소면기보전원","workSum":"기계에 관한 지식을 활용하여 정소면기, 랩포머기 등을 조정·수리한다.","doWork":"보전에 필요한 자재를 수령하여 운반·배치한다. 주기적인 정비계획이나 필요에 따라 가공할 원료의 종류, 기계의 효율 등 기계에 관한 지식과 가공에 관한 지식을 이용하여 기계의 운전 상태를 점검한다. 각종 기어·롤러 등을 분해하여 이상 유무를 확인하고 이상이 있을 시 수리 및 교체한다. 수동공구를 사용하여 축의 편심·베어링·코일러 튜브 등을 분해·정비한다. 회전부위의 소음 등 기계의 상태를 파악하고 각종 계기를 확인한다. 각 부위에 오일 및 그리스를 주입한다. 수리 및 교체 내용을 보전일지에 기록·보관한다. 솔이나 공기호스를 사용하여 기계 주변을 소제한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"정소면기정비원","certLic":"기계정비기능사, 기계정비산업기사","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005532:1', '{"dJobCd":"K000005532","dJobCdSeq":"1","dJobNm":"조방기보전원","workSum":"섬유가공에 관한 지식을 이용하여 슬리버(Sliver:면섬유 다발)를 느슨하게 꼬아 조사를 만드는 조방기계를 조정·수리한다.","doWork":"보전에 필요한 부속 및 자재를 수령한다. 주기적인 정비계획이나 필요에 따라 운전 상태를 점검하고 수동공구를 사용하여 보텀롤러(Bottom Roller), 플라이어, 보빈레일, 콘드럼 등을 분해·소제·수리한다. 각 부위에 오일 및 그리스를 주입한다. 수리·분해·교체 내용을 보전일지에 기록·보관한다. 솔이나 공기호스를 사용하여 기계 주변을 깨끗이 청소한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"조방기정비원","certLic":"기계정비기능사, 기계정비산업기사","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001352:1', '{"dJobCd":"K000001352","dJobCdSeq":"1","dJobNm":"직물제조기계수리원","workSum":"수동공구·기중기 및 정밀측정도구를 사용해 직물제조 기계 및 장비를 수리하고 유지한다.","doWork":"기계 수리에 필요한 부속자재를 수령하여 운반·보관한다. 주기적인 정비계획이나 필요에 따라 가공할 원료의 종류, 기계의 효율 등 기계에 관한 지식과 가공에 관한 지식을 이용하여 기계의 운전 상태를 점검한다. 플라이어·렌치 및 드라이버를 사용하여 기계를 뜯어내고 고장 난 부분품을 제거한다. 각종 게이지(Gauge)를 점검하고 조정한다. 기계의 각 부분품에 오일이나 그리스를 주입한다. 주요 수리내용을 기록일지에 기록·보관한다. 솔, 공기호스, 기름걸레 등을 사용하여 기계의 주변을 정리·소제한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"기계정비산업기사, 기계정비기능사","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"C132","dJobICdNm":"[C132]직물직조 및 직물제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003117:1', '{"dJobCd":"K000003117","dJobCdSeq":"1","dJobNm":"직조기보전원","workSum":"직조기의 기능과 직조작업·도면·안내서 등을 활용하여 직조기를 조정·설치·수리한다.","doWork":"직조기의 수리나 조정이 필요한지 알아보기 위하여 짜인 천이나 직조기를 검사한다. 손공구를 사용하여 종광(날실을 아래위로 벌려서 씨실이 투입되는 개구를 만들어주는 장치) 벨트와 북 등의 결함이 있는 부분을 수리하거나 대체하고 장력장치와 북침장치 등을 조절한다. 곧은 자와 수준기·직각자를 사용하여 북집·레이스판 및 바디 등의 부속장치를 수평조절하고 정돈한다. 수리·분해·교체 등 유지보수 내용을 일지에 기록·보관한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"직기정비원, 직조기수리원, 직출원","certLic":"기계정비기능사, 기계정비산업기사","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"C132","dJobICdNm":"[C132]직물직조 및 직물제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001703:1', '{"dJobCd":"K000001703","dJobCdSeq":"1","dJobNm":"콘크리트제조설비정비원","workSum":"콘크리트제조공장의 각종 설비를 점검하고 이상 시 수리·보수한다.","doWork":"각종 설비를 점검하고 상태를 파악하여 보고한다. 작업지시에 따라 믹서의 마모부품(혼합페달, 라이너 등)과 에어컴프레서의 부품을 교체한다. 벨트컨베이어의 롤러 및 베어링의 이상 유무를 파악하여 노후한 부품은 교체한다. 각종 설비의 구동부분이 원활히 작동되도록 정규적으로 주유하여 파손을 방지한다. 세정기 및 세차설비의 작동상태를 점검하고 수리·보수한다. 기타 장비의 보수·유지업무를 수행한다. 겨울철을 대비하여 보일러의 상태를 점검한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"기계정비기능사, 기계정비산업기사","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"C233","dJobICdNm":"[C233]시멘트, 석회, 플라스터 및 그 제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005267:1', '{"dJobCd":"K000005267","dJobCdSeq":"1","dJobNm":"타이어주형수리원","workSum":"타이어를 제조하기 위하여 성형공정에 사용하는 주형(鑄型)을 수리하고 문자판과 비드링(Bead Ring)을 변형한다.","doWork":"각종 도구(해머, 수동드릴, 징, 용접기 등)를 사용하여 주형에 있는 균열, 부딪혀 움푹 패인 곳, 구멍 등을 수선한다. 수동 연마기를 사용하여 수선된 부분이나 완성된 주형을 끝손질한다. 렌치 등의 수동공구를 사용하여 크기와 두께를 나타내는 비드링과 문자판을 변경한다. 판, 비드링, 주조물의 재고품을 손질하고 보관한다. 용접장비나 줄을 사용하여 판, 링, 주조물 등에 금속을 붙이거나 떼어낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"기계정비기능사, 기계정비산업기사","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005506:1', '{"dJobCd":"K000005506","dJobCdSeq":"1","dJobNm":"태양열시스템정비원","workSum":"사용 중 이상이 발생한 태양열 시스템의 정비 점검을 통해 이상부위를 점검하고 정비한다.","doWork":"접수된 수리요청에 따라 태양열 시스템의 보수점검을 실시한다. 태양열 집열부의 균열이나 배관의 누수 등을 점검하는 등 고장부위를 확인하고 수리한다. 조도계를 이용하여 일사량을 측정한다. 일사량 대비 축열온도를 측정하여 이상 유무를 확인한다. 유량계를 이용하여 축열제의 보충 여부를 확인한다. 집열부를 개봉하여 청소하거나 내부 배관을 보수한다. 배관 내의 축열제를 보충하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"신재생에너지발전설비기능사, 신재생에너지발전설비산업기사, 신재생에너지발전설비기사","dJobECd":"8111","dJobECdNm":"[8111]공업기계 설치·정비원","dJobJCd":"7531","dJobJCdNm":"[7531]공업기계 설치 및 정비원","dJobICd":"C281","dJobICdNm":"[C281]전동기, 발전기 및 전기 변환ㆍ 공급ㆍ제어 장치 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;