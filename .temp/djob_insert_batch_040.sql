INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003194:1', '{"dJobCd":"K000003194","dJobCdSeq":"1","dJobNm":"배전선로순시원","workSum":"배전설비의 효율적인 운영과 양질의 전력 공급을 위하여 선로경과지를 순회하며 선로 및 배전설비의 이상 및 장애요인 등을 점검한다.","doWork":"배전선로의 순시점검 및 보수계획에 따라 각 지역의 선로 및 배전설비에 대하여 정기점검계획을 수립하고, 계획에 따라 각종 보수작업이나 휴전작업을 관리한다. 선로경과지를 순회하며 선로와 배전설비에 대해 이상 및 장애요인을 주는 주변공사, 부착물, 까치집과 같은 이물질 등이 있는지 관찰한다. 배전선로와 각종 배전설비의 이상 유무와 저항, 전류, 전압 등을 측정하여 작동상태를 정기적으로 검사하고 관련 자료를 기록한다. 배전계통의 신·증설 또는 개·보수 공사가 진행되기 전 배전설비를 조작하여 휴전작업을 하고 계통변경에 따른 설비의 검전, 상측정 등의 검사를 통하여 설비의 이상 유무를 확인한다. 배전설비에 이상 및 장애요인이 발견되면 정상적인 작동이 이루어지도록 임시조치를 취하고 보수상황을 검토하여 지중배전원에게 보고한다. 배전설비에 대한 공사 시 지중배전원을 보조하여 공사를 감독한다. 때에 따라 가공(지중)선로를 순회하며, 선로 및 배전설비의 이상 및 장애요인을 점검한다. 이상발생 시 간단한 복구는 직접 처리하거나 배전설비운영원에게 보고하여 처리하게 한다. 발전소와 변전소, 변전소와 변전소를 연결하는 전력선을 순시하며, 이상 및 장애요인을 점검하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"배전선로관리원, 배전선로보호원","connectJob":"가공선로순시원, 송전선로순시원","certLic":"전기기능사","dJobECd":"8313","dJobECdNm":"[8313]외선 전기공","dJobJCd":"7623","dJobJCdNm":"[7623]외선 전기공","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006632:1', '{"dJobCd":"K000006632","dJobCdSeq":"1","dJobNm":"배전설비보수원","workSum":"지중선로, 애자, 변압기, 단로기, 개폐기 등 배전설비의 장애요인을 제거하고, 파손된 설비를 교체·보수하는 제반 업무를 수행한다.","doWork":"보수할 배전설비의 보수실적에 대한 기록내용을 참조하여 보수상황을 파악하고 가동상태를 점검한다. 기기의 설계도면 및 가동상태를 점검하여 파손부위를 확인한다. 전류계, 전압계, 저항계 등의 측정장비를 사용하여 정확한 파손부위를 확인한다. 삽이나 굴착기계를 사용하여 땅을 파고 전신주를 세운다. 전신주에 변압기를 고정하는 금속막대를 부착한다. 체인을 사용하여 변압기를 전신주에 올리고 볼트와 수동공구를 사용하여 금속막대에 고정한다. 배전선의 입·출력전선을 확인한 후 변압기의 단자에 연결한다. 주택의 벽면에 계량기와 전기차단기구를 설치한다. 작업도면과 전선의 연결상태를 점검·비교한다. 설치된 각 전기설비의 파손부위를 확인하고 보수하여 재조립하거나 교체한다. 파손된 부품을 확인하여 제거하고 신부품으로 교체한다. 각종 측정장비를 사용하여 교체한 설비의 성능을 확인한 후 수동공구를 사용하여 재조립한다. 수리가 불가능한 기기는 조작자와 상의하여 교체의뢰서를 작성한다. 교체한 부품의 종류와 수량을 작업일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"보선원","connectJob":"배전선로보수원, 지중선로보수원, 내선보선원, 배선보선원, 가로등설치보수원, 변압기설치보수원","certLic":"전기기능사","dJobECd":"8313","dJobECdNm":"[8313]외선 전기공","dJobJCd":"7623","dJobJCdNm":"[7623]외선 전기공","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005245:1', '{"dJobCd":"K000005245","dJobCdSeq":"1","dJobNm":"배전작업현장감독자","workSum":"전기·통신·조명시설용 콘크리트주(CP주), 강관주 등을 세우고 전선을 가설하는 작업원의 활동을 감독·조정한다.","doWork":"배전공사 도면을 읽고 선로가설거리와 작업환경을 파악한다. 작업내용, 순서 및 작업자별 임무를 확인하고 안전모, 안전허리띠의 착용상태를 점검한다. 작업진행상황을 파악하고 작업내용을 보고한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원 및 자재를 공급한다. 작업계획에 따라 세부실행항목을 수립하여 작업 절차 및 방법을 결정하여 작업원에게 작업내용을 지시하고 작업배치를 한다. 표준명세에 따라 지시된 작업이 이루어지는지 작업원과 함께 작업하며 작업상황을 관찰하고 작업내용을 점검한다. 작업원에 대한 직무교육 및 안전위생교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시 관찰과 면담을 통하여 작업원의 애로 및 건의사항을 수렴·해결하고 문제점을 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"위험내재|다습|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"배전전기작업반장, 배전작업반장","certLic":"전기산업기사, 전기공사산업기사, 전기기능사","dJobECd":"8313","dJobECdNm":"[8313]외선 전기공","dJobJCd":"7623","dJobJCdNm":"[7623]외선 전기공","dJobICd":"F423","dJobICdNm":"[F423]전기 및 통신 공사업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004630:1', '{"dJobCd":"K000004630","dJobCdSeq":"1","dJobNm":"배전전공","workSum":"가공 배전선로의 콘크리트 전주 등 지지물 설치, 지중관로 부설, 전선 가선 또는 포설, 변압기, 개폐기 등의 배전기기 설치와 유지관리에 따른 시공을 한다.","doWork":"도면에 따른 현장 건주지점에 지하매설물 등 지장물 여부를 확인하고 장비를 이용하여 굴착한다. 전주를 운반하여 수직으로 건주하고 근가, 지선 등을 설치한다. 전주에 완철, 애자 등을 장치하고 전선을 가설한다. 변압기, 개폐기, 피뢰기 등 배전기기를 설치한다. 활선 및 무정전 전공은 절연보호구를 착용하고 활선용 절연 바스켓 차량 등 장비를 이용하여 작업하기도 한다. 지중전선로 공사는 관로경과지를 매설물에 유의하여 굴착한 뒤 관로를 부설하고 맨홀, 전력구 설치와 지중 변압기, 개폐기기 등의 장치, 전력 케이블의 접속 등의 작업을 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"힘든 작업","workPlace":"실외","physicalAct":"균형감각|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"배전전기원, 배전전기공, 배전공, 외선전공","connectJob":"배전활선전공, 건주차운전원","certLic":"전기공사산업기사, 전기기능사","dJobECd":"8313","dJobECdNm":"[8313]외선 전기공","dJobJCd":"7623","dJobJCdNm":"[7623]외선 전기공","dJobICd":"F423","dJobICdNm":"[F423]전기 및 통신 공사업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004153:1', '{"dJobCd":"K000004153","dJobCdSeq":"1","dJobNm":"송변전설비보수원","workSum":"발전소와 변전소, 변전소와 변전소로의 안정적인 전기공급을 위하여 각종 송·변전설비의 설치 및 보수에 대한 제반 업무를 수행한다.","doWork":"송·변전설비의 보수실적에 대한 대장기록을 참조하여 보수상황을 파악하고 가동상태를 점검한다. 보수할 설비 및 기기, 송전선로의 도면 등을 점검한다. 전류계, 전압계, 저항계 등의 측정장비를 사용하여 파손부위나 선로위치를 확인한다. 파손된 송전선로를 제거하고 공구를 사용하여 애자에 연결한다. 이상 및 장애요인이 있는 설비를 작업절차에 따라 공구를 사용하여 해체하고 보수한다. 보수가 완료된 설비 및 기기는 조립절차에 따라 설치한다. 보수가 완료되면 도면과 비교하여 전선의 연결상태, 기기 및 설비의 작동상태를 비교·점검한다. 파손 부품을 확인하여 제거하고 새로운 부품으로 교체한다. 수리가 불가능한 기기는 교체의뢰서를 작성하여 교체한다. 교체한 설비는 각종 측정장비를 사용하여 성능을 점검한다. 교체 부품의 종류와 수량, 작업내용 등을 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"웅크림|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"외선전공","connectJob":"송전설비설치원, 변전설비설치원(변전전공), 송전탑조립원, 활선원, 송전탑해체원, 송전정비원","certLic":"전기기능사","dJobECd":"8313","dJobECdNm":"[8313]외선 전기공","dJobJCd":"7623","dJobJCdNm":"[7623]외선 전기공","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004540:1', '{"dJobCd":"K000004540","dJobCdSeq":"1","dJobNm":"송전전공","workSum":"발전소에서 변전소 또는 변전소 간의 전력 수송을 위하여 철탑 또는 지하 전력구를 설치하며 애자 등을 장치하고 전력선을 부설한다.","doWork":"송전선로 건설계획에 따른 철탑 설치를 위해 굴착하고 기초공사를 한다. 철탑을 구성하는 금구류를 운반하여 설계도면에 맞게 조립하여 세운다. 철탑에 애자장치를 취부하고 전선을 가선하고 전선이도를 조정한다. 지중송전의 경우 지하 수십미터 깊이에 전력구를 건설하고 케이블을 포설한다. 송전활선전공의 경우 운영 중인 선로의 유지 및 보수를 위하여 절연복, 도전복 등의 복장과 절연된 장비 등을 이용하여 애자의 세척, 교체, 이도조정 등 작업을 수행하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"힘든 작업","workPlace":"실외","physicalAct":"균형감각|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"송전전기원, 송전전기공, 송전공, 외선전공","connectJob":"송전활선전공","dJobECd":"8313","dJobECdNm":"[8313]외선 전기공","dJobJCd":"7623","dJobJCdNm":"[7623]외선 전기공","dJobICd":"F423","dJobICdNm":"[F423]전기 및 통신 공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006560:1', '{"dJobCd":"K000006560","dJobCdSeq":"1","dJobNm":"송전현장감독자","workSum":"발전소와 변전소 사이의 전력을 공급하기 위하여 송전탑을 세우고 전선을 가설하는 작업원의 활동을 감독·조정한다.","doWork":"송전공사 도면을 읽고 선로가설거리와 작업환경을 파악한다. 작업내용, 순서 및 작업자별 임무를 확인하고 안전모, 안전허리띠의 착용상태를 점검한다. 작업을 위해 자재 목록을 확인하고, 자재 준비상태를 점검한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"10년 초과","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"위험내재|다습|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"송전전기반장, 송전반장","certLic":"전파전자통신기능사, 전파전자통신산업기사, 전기기능사, 전기산업기사, 전기공사산업기사","dJobECd":"8313","dJobECdNm":"[8313]외선 전기공","dJobJCd":"7623","dJobJCdNm":"[7623]외선 전기공","dJobICd":"F423","dJobICdNm":"[F423]전기 및 통신 공사업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005890:1', '{"dJobCd":"K000005890","dJobCdSeq":"1","dJobNm":"전동차선로관리원","workSum":"도면 및 작업지시서에 따라 전동차에 전기를 공급하는 변전소, 전기실, 전주, 배전선, 전차선, 고압선 등의 전기시설을 점검, 유지·보수 및 관리한다.","doWork":"변전설비 및 역사전기설비를 건설 및 개량, 유지·관리한다. 전동차의 전기보수용 자재, 공기구 비품을 관리한다. 전동차의 전차선, 송배전설비를 건설 및 개량, 유지·관리한다. 모타카, 기동차량 등 중장비를 관리한다. 수전선로 선방설비를 관리한다. 수탁전로 시설을 관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실외","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"전기통신원","certLic":"전기철도산업기사","dJobECd":"8313","dJobECdNm":"[8313]외선 전기공","dJobJCd":"7623","dJobJCdNm":"[7623]외선 전기공","dJobICd":"H492","dJobICdNm":"[H492]육상 여객 운송업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003560:1', '{"dJobCd":"K000003560","dJobCdSeq":"1","dJobNm":"통신전원유지보수원","workSum":"통신설비에 전원을 공급하기 위하여 정류기, 축전지, 변압기, 발전기, 수배전반 등의 전력공급시설을 유지·보수한다.","doWork":"각 설비의 가동 또는 중지에 따라 변화하는 전력량을 예측하고 각종 수동공구 및 테스터, 절연저항계, 전류계 등의 측정장비를 사용하여 정류기, 인버터, 발전기, 신호기 등 전력설비의 출력을 조정한다. 파손된 설비의 설계도면 또는 회로도 등을 검토하여 파손부위 및 상태를 점검하고 원인을 파악한다. 수동공구를 사용하여 파손된 부품을 교체하고 재조립한다. 각 설비의 전력사용량을 검침하고 부하량, 방전량 등을 조사하여 통계자료를 작성한다. 전력시설의 장애 및 고장실적에 관련된 보고자료를 작성하고 원인을 분석한다. 전진배치시설의 정전 시 비상조치를 한다. 설비에 따라 무정전전원공급장치(UPS:Uninterruptible Power Supply)를 점검하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"정보통신기사, 정보통신산업기사, 통신선로산업기사, 통신선로기능사, 통신기기기능사","dJobECd":"8313","dJobECdNm":"[8313]외선 전기공","dJobJCd":"7623","dJobJCdNm":"[7623]외선 전기공","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006675:1', '{"dJobCd":"K000006675","dJobCdSeq":"1","dJobNm":"전자기판기능검사원","workSum":"영상기기, 음향기기, 사무기기 등 각종 전자제품에 장착되는 전자부품이 조립된 인쇄회로기판을 기능검사장비를 이용하여 검사·측정·시험한다.","doWork":"기판기능검사장비에 검사프로그램을 로드(Load)한다. 검사절차서를 보고 검사요량을 숙지한다. 검사에 필요한 장비 및 지그를 설치한다. 불량표를 작업대에 준비하고 불량기판을 담을 지그를 작업대에 준비한다. 검사할 기판의 안내홀(Guide Hole)을 고정구 안내판에 맞추어 올려놓는다. 비디오·프린터·플로피디스크·키보드·스피커 등을 접속하고 전원을 켜고 키를 눌러 검사절차에 따라 프로그램을 이용하여 모니터를 주시하며 검사를 진행한다. 검사내용을 프린트로 인쇄하여 기록하고 기판수량을 파악하여 수리 부서에 불량품을 수리·의뢰한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"유지","similarNm":"기판측정원, 보드검사원(자동), 자삽검사원(자동), PCB검사원(자동)","certLic":"전자기능사","dJobECd":"8411","dJobECdNm":"[8411]컴퓨터 설치·수리원","dJobJCd":"7711","dJobJCdNm":"[7711]컴퓨터 설치 및 수리원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003869:1', '{"dJobCd":"K000003869","dJobCdSeq":"1","dJobNm":"컴퓨터수리원","workSum":"컴퓨터 및 주변기기가 오작동되는 원인을 찾아내 장애를 처리한다.","doWork":"고객으로부터 받은 접수사항을 파악하여 고객과 약속을 하고 방문한다. 컴퓨터의 증상에 따라 파일을 복구하거나, 운영체제 및 응용 소프트웨어를 점검한다. 조립과 분해를 하고, 부품을 교체·수리한다. 오실로스코프·멀티미터 등의 측정기구로 불량제품의 원인을 분석하고 전기인두·니퍼·롱로즈 등의 공구를 사용하여 부품을 교환하거나 수리한다. 불량원인에 따라 작업·자재·설계·외주 등을 구분하여 파악하고, 작업일지를 작성하며 동일한 불량의 재발을 방지하기 위하여 관련 부서에 통보한다. 사용자에게 맞는 하드웨어 업그레이드 방향을 제시하거나, 장애 발생을 예방할 수 있도록 사전점검을 실시한다. 프린터, 스캐너 등의 컴퓨터 주변기기 및 네트워크, 서버 등의 장애를 처리하기도 한다. 수리가 끝나면 출장서비스 내역서를 고객에게 전달하고 결과를 등록한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"서비스제공","workFunc3":"정밀작업","similarNm":"컴퓨터정비사, 컴퓨터AS요원, 컴퓨터리페어러, 컴퓨터수리기사","connectJob":"하는 일에 따라 PC수리원, 개인용컴퓨터수리원, 컴퓨터하드웨어수리원, 하드디스크수리원, 모니터수리원, 노트북수리원","certLic":"정보처리산업기사, 사무자동화산업기사, 전자산업기사","dJobECd":"8411","dJobECdNm":"[8411]컴퓨터 설치·수리원","dJobJCd":"7711","dJobJCdNm":"[7711]컴퓨터 설치 및 수리원","dJobICd":"S951","dJobICdNm":"[S951]컴퓨터 및 통신장비 수리업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006832:1', '{"dJobCd":"K000006832","dJobCdSeq":"1","dJobNm":"컴퓨터조정원","workSum":"컴퓨터 및 주변기기를 생산하는 과정에서 컴퓨터의 작동상태가 양호하도록 조정한다.","doWork":"정해진 작업표준에 의거하여 주파수측정기, 오실로스코프, 지그, 드라이버, 마그네트(전자접촉기), 실리콘, 조정봉 등 계측기기와 수동공구를 사용함으로써 모니터의 밝기, 선명도 등을 조정하거나 컴퓨터 본체 및 주변기기들을 전기적·기구적 특성과 기능에 맞도록 조정한다. 컴퓨터와 주변기기와의 입력·출력신호를 확인·검사한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"전자기능사","dJobECd":"8411","dJobECdNm":"[8411]컴퓨터 설치·수리원","dJobJCd":"7711","dJobJCdNm":"[7711]컴퓨터 설치 및 수리원","dJobICd":"C263","dJobICdNm":"[C263]컴퓨터 및 주변장치 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006612:1', '{"dJobCd":"K000006612","dJobCdSeq":"1","dJobNm":"무선통신단말기수리원(사후서비스)","workSum":"수리센터(서비스센터)에서 고장난 무선통신단말기를 점검하고 수리한다.","doWork":"고객관리 시스템에 무선전화번호와 이름을 접수 및 등록하여 개인의 파일을 불러내고 고장접수 일시를 기록한다. 단말기를 고장측정기의 케이블에 연결을 하여 고장내역을 파악한다. 외관이 파손된 경우, 외관을 해체하여 새로운 외관으로 교체한다. 프로그램 장애로 인한 송수신 불량에 의해 에코(Echo:반사 따위의 작용으로 충분한 진폭과 명확한 지연 시간을 갖고 되돌아온 파)가 생기는 경우 계측기로 에코의 상태를 확인하여 수신감도가 낮으면 트랜스퍼 프로그램을 이용하여 버전업(Version Up:버전 향상)을 한다. 회로·칩 등의 하드웨어 부분의 납땜 등을 점검하고 교체하거나 다시 납땜을 한다. 신규 부가서비스의 기능을 추가한다. 부가서비스 버전업 프로그램을 실행시킨다. 수리가 끝나면 제조업체별 단말기의 부품 구매가격을 기준으로 하여 컴퓨터를 사용하여 수리비 산출을 한다. 정밀부품의 고장인 경우 제조업체에 배송하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"정밀작업","similarNm":"휴대폰수리원, 스마트폰수리원, 무선통신단말기수리기사","certLic":"무선설비기능사, 전파전자통신기능사, 통신기기기능사","dJobECd":"8412","dJobECdNm":"[8412]이동전화기 수리원","dJobJCd":"7712","dJobJCdNm":"[7712]이동전화기 수리원","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005489:1', '{"dJobCd":"K000005489","dJobCdSeq":"1","dJobNm":"무선통신단말기수리원(제조 과정)","workSum":"무선통신단말기 제조 과정에서 발생한 불량을 수리한다.","doWork":"각종 무선통신단말기의 회로도와 특성을 파악하고 숙지한다. 조정·검사 과정에서 불량으로 판정된 단말기를 인수받아 각종 계측기기를 이용하여 점검하고 부품을 교환하며 수리한다. 조립공정에서 잘못된 부분을 점검하고 수리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"대상에 따라 휴대폰수리원, 스마트폰수리원, 태블릿PC수리원, PMP수리원, GPS수리원, 내비게이션수리원","certLic":"무선설비기능사, 전자기능사","dJobECd":"8412","dJobECdNm":"[8412]이동전화기 수리원","dJobJCd":"7712","dJobJCdNm":"[7712]이동전화기 수리원","dJobICd":"C264","dJobICdNm":"[C264]통신 및 방송 장비 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001411:1', '{"dJobCd":"K000001411","dJobCdSeq":"1","dJobNm":"유선전화기수리원","workSum":"전화기·인터폰·키폰 등의 불량원인을 분석하고 수리한다.","doWork":"제품의 회로도를 숙지한다. 기능불량품 및 인쇄회로기판을 해당 기능시험기에 연결하여 종합시험을 실시하여 불량정도를 파악하고 원인을 분석한다. 파악된 불량내용에 따라 각종 계측기기를 사용하여 점검하며 불량위치를 찾아낸다. 공구를 사용하여 수리하거나 부품을 교체한다. 수리가 완료되면 전화테스트 장비를 사용하여 수신감도 및 기타 기능을 점검하고 이상이 없으면 출고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"유선전화기수리기사, 유선통신기기수리기사","connectJob":"전화기수리원, 인터폰수리원, 키폰수리원","certLic":"전자기능사","dJobECd":"8419","dJobECdNm":"[8419]기타 정보통신기기 설치·수리원","dJobJCd":"7719","dJobJCdNm":"[7719]기타 정보 통신기기 설치 및 수리원","dJobICd":"C264","dJobICdNm":"[C264]통신 및 방송 장비 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005751:1', '{"dJobCd":"K000005751","dJobCdSeq":"1","dJobNm":"방송기기정비원","workSum":"방송기자재(카메라, 조명, 중계차, 스튜디오 장비 등)를 정기점검하고 유지보수한다.","doWork":"방송기자재의 구입연도, 규격, 종류 등을 검토하여 정기적인 보수계획을 수립한다. 보수요구서를 확인하여 작동불량부위를 확인하고 오실로스코프 등의 각종 시험기구를 사용하여 고장원인을 조사한다. 수동공구와 동력공구를 사용하여 장비를 분해하고 파손부위를 확인하여 부품을 교체한다. 부품의 교환이 완료되면 장비를 재조립하고 작동시험을 실시한다. 각종 소모성 부품의 교체계획을 수립하여 일정 기간을 주기로 교환하기도 한다. 고장 정도에 따라 제조사에 수리를 의뢰하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"설치 및 수리를 하면 방송장비설치수리원, 대상에 따라 녹화장비정비원, 영상장비정비원, 음향장비정비원","certLic":"방송통신기사, 방송통신산업기사, 방송통신기능사, 전자기능사","dJobECd":"8421","dJobECdNm":"[8421]방송장비 설치·수리원","dJobJCd":"7721","dJobJCdNm":"[7721]방송 관련 장비 설치 및 수리원","dJobICd":"J601/J602","dJobICdNm":"[J601]라디오 방송업 / [J602]텔레비전 방송업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001617:1', '{"dJobCd":"K000001617","dJobCdSeq":"1","dJobNm":"안테나설치원","workSum":"전파를 송·수신하기 위하여 철탑 등에 무선통신 및 방송용 안테나를 설치·조정한다.","doWork":"설계도면과 시방서를 읽고 적당한 설치 위치와 방향을 확인한다. 크레인이나 인력으로 철탑의 지정된 위치에 안테나 가대와 지지앵글을 조립·고정한다. 인양할 안테나의 규모에 따라 도르래, 윈치, 기중기를 이용하여 철탑의 설치 위치에 안테나 및 기타 송·수신장비를 끌어올려 고정시킨다. 수신레벨기로 안테나의 방향을 조절하여 수신방향이 설정되면 안테나를 가대 또는 앵글에 고정시키고 부속장비를 설치하여 연결한다. 오실로스코프, 주파수측정기 등을 이용하여 안테나의 방향과 성능 등을 점검·조정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"힘든 작업","workPlace":"실외","physicalAct":"균형감각|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"무선안테나공, 안테나설치공, 무선안테나설치원, 무선안테나설치공","connectJob":"위성방송안테나설치및수리원","dJobECd":"8421","dJobECdNm":"[8421]방송장비 설치·수리원","dJobJCd":"7721","dJobJCdNm":"[7721]방송 관련 장비 설치 및 수리원","dJobICd":"F423","dJobICdNm":"[F423]전기 및 통신 공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005980:1', '{"dJobCd":"K000005980","dJobCdSeq":"1","dJobNm":"유무선방송설비기사","workSum":"유무선방송 선로 및 기기를 설치하고 보수한다.","doWork":"고장, 신규, 이전접수 명단을 유선방송고객관리사무원에게 또는 무선상으로 긴급을 요하는 수리전화를 직접 접수한다. 수리지역으로 이동하여 가설작업을 한다. 전주에서 가입자의 인입선까지 선로를 설치하기 위하여 전주에 올라간다. 옥내의 텔레비전에 유선방송 선로를 연결하여 주고 이용약관을 작성한다. 알에프(R/F)측정기 등을 이용하여 고장의 유무를 찾는다. 드라이버 등을 이용하여 수리하고, 선로에 이상이 없을 경우 텔레비전 수상기를 조정한다. 디지털방송 셋탑박스를 설치하거나 인터넷, 인터넷전화, TV 등 복합상품을 설치하기도 한다. 설치가 완료되면 설치결과를 검증하고 이용자에게 상품 설명을 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"균형감각|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"유선방송설치기사, 인터넷설치기사","connectJob":"케이블TV설치기사, IPTV설치기사","certLic":"무선설비기사, 무선설비산업기사, 무선설비기능사","dJobECd":"8421","dJobECdNm":"[8421]방송장비 설치·수리원","dJobJCd":"7721","dJobJCdNm":"[7721]방송 관련 장비 설치 및 수리원","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002307:1', '{"dJobCd":"K000002307","dJobCdSeq":"1","dJobNm":"공중전화관리원","workSum":"공중전화의 설치·통신선로 가설 등의 설치 업무와 집금, 유지·보수, 순회점검 등의 보전업무를 수행한다.","doWork":"작업지시서에 따라 통신선로를 가설한다. 공중전화부스 내부와 외부의 배선설비를 연결한다. 전류계·저항계 등의 시험장비를 사용하여 배전반·도난경보기·전화기 등의 회로를 점검한다. 공중전화의 외관 및 작동상태를 점검하고 수동공구를 사용하여 파손부위를 분해하고 부품을 교체한다. 공중전화의 내부를 열어 집금통의 봉인을 확인하고 교체한다. 카드 리더기(공중전화카드, 교통카드)의 작동을 점검한다. 파손된 부품 및 수량을 일지에 기록하고 관련 작업내용을 정리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","similarNm":"공중전화설치원, 공중전화수리원","certLic":"통신선로산업기사, 통신선로기능사","dJobECd":"8422","dJobECdNm":"[8422]통신장비 설치·수리원","dJobJCd":"7722","dJobJCdNm":"[7722]통신 관련 장비 설치 및 수리원","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002247:1', '{"dJobCd":"K000002247","dJobCdSeq":"1","dJobNm":"기지국유지보수원","workSum":"이동전화의 원활한 소통을 위해 산이나 빌딩 옥상에 설치한 무인송수신설비 또는 기지국을 유지보수한다","doWork":"담당 구역 내의 기지국 또는 송수신설비의 수량을 파악하고 보수한다. 전압계·전류계·저항계 등의 측정장비를 사용하여 변환기, 송신 및 수신장치 등의 가동상태를 점검한다. 소통장애가 발생한 지역의 송·수신설비 또는 기지국의 위치를 파악하여 기능시험을 실시한다. 파손된 장비와 설계도면을 검토하여 파손부위를 확인하고 각종 수동공구를 사용하여 부품을 교환한다. 조립이 완료되면 시험 가동을 실시하여 정상가동 여부를 확인한다. 교환한 부품의 종류 및 수량을 일지에 기록하고 파손원인 및 보수방법을 정리하여 보고자료를 작성한다. 각 지역의 송신 또는 수신감도를 시험하여 기기 증설에 관련된 자료를 정리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"무선기지국유지보수원, 무선통신기지국유지보수원","connectJob":"무선중계기수리원, 무선기지국설치및수리원, 기지국중계기설치및수리원","certLic":"정보통신기사, 정보통신산업기사, 통신선로산업기사, 통신선로기능사, 통신기기기능사, 무선설비기사, 무선설비산업기사, 무선설비기능사","dJobECd":"8422","dJobECdNm":"[8422]통신장비 설치·수리원","dJobJCd":"7722","dJobJCdNm":"[7722]통신 관련 장비 설치 및 수리원","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007281:1', '{"dJobCd":"K000007281","dJobCdSeq":"1","dJobNm":"무선통신기기주파수조정원","workSum":"조립된 무선통신기기의 주파수·출력을 조정한다.","doWork":"무선통신기기의 코일이나 콘덴서를 조정하여 정해진 주파수 영역에서 동작하는지 확인하여 주파수를 고정한다. 계측기기를 통해 파형을 일정 모양과 수준으로 하여 감도를 조정하고 파형의 찌그러짐을 조정한다. 송신기의 버튼을 눌러 부저상태를 확인하고 정상인지 점검한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"무선통신단말기조정원","dJobECd":"8422","dJobECdNm":"[8422]통신장비 설치·수리원","dJobJCd":"7722","dJobJCdNm":"[7722]통신 관련 장비 설치 및 수리원","dJobICd":"C264","dJobICdNm":"[C264]통신 및 방송 장비 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003100:1', '{"dJobCd":"K000003100","dJobCdSeq":"1","dJobNm":"무선항해통신장비설치원","workSum":"선박 및 해양시설에 무선장비, 유선설비, 항해장비 및 방송설비 등의 무선항해통신장비를 설치한다.","doWork":"작업도면 및 장비도면을 확인하고 설치할 장비의 목록을 작성한다. 장비에 따라 작업방법을 결정한다. 수동공구, 전선, 테스터 등 필요한 공구 및 자재를 준비한다. 도면에 따라 설치 위치를 확인한다. 장비를 취부한 후 각종 공구를 사용하여 작업순서에 따라 배선 및 결선을 한다. 결선된 장비는 전선에 이상이 없으면 전원을 넣어 작동상태를 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|손사용|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"선박전기의장원","certLic":"통신설비기능장, 통신기기기능사, 무선설비기능사","dJobECd":"8422","dJobECdNm":"[8422]통신장비 설치·수리원","dJobJCd":"7722","dJobJCdNm":"[7722]통신 관련 장비 설치 및 수리원","dJobICd":"C311","dJobICdNm":"[C311]선박 및 보트 건조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007147:1', '{"dJobCd":"K000007147","dJobCdSeq":"1","dJobNm":"이동통신시스템유지보수원","workSum":"이동통신서비스를 제공하기 위하여 통합망, 전송망, 엑세스망 운용 과정에서 발생하는 장애를 처리한다.","doWork":"이동통신시스템 유지보수 매뉴얼, 업무와 관련된 표준, 통신시스템 계통도, 네트워크 망 장비, 시스템에 연동되는 전국망 운용에 대한 지식 등 유지보수 업무에 필요한 기술과 현재의 망 상황·환경을 파악하고 숙지한다. 유지보수 매뉴얼에 따라 정기점검 및 비정기 점검을 실시한다. 시스템의 운용 시 발생하는 고장, 장애내용, 문제 등을 이동통신서비스운용원과 공유하며 매뉴얼에 반영하고 정기점검 시 활용한다. 장애가 발생하면 상태 메시지를 분석하여 장애문제를 파악하고 처리한다. 망을 모니터링하고 특정 시스템에 장애가 발생하면 전국에 전파하고 필요한 조치를 취한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"정보처리기사, 정보처리산업기사","dJobECd":"8422","dJobECdNm":"[8422]통신장비 설치·수리원","dJobJCd":"7722","dJobJCdNm":"[7722]통신 관련 장비 설치 및 수리원","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001822:1', '{"dJobCd":"K000001822","dJobCdSeq":"1","dJobNm":"전송설비유지보수반장","workSum":"전화국 간의 회선단말장치를 유지·관리하는 작업원들의 활동을 감독·조정한다.","doWork":"회선단말장치를 운용·관리하기 위한 계획을 세운다. 고정 유닛의 입출을 파악한다. 작업내용을 작업원에게 지시·배치한다. 작업진행상황을 파악하고 작업내용을 보고한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원 및 자재를 공급한다. 표준명세에 따라 지시된 작업이 이루어지는지 작업원과 함께 작업하며 작업상황을 관찰하고 작업내용을 점검한다. 작업원에 대한 직무교육 및 안전위생교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시 관찰과 면담을 통하여 작업원의 애로 및 건의사항을 수렴·해결하고 문제점을 보고한다. 각종 시설의 확충에 관하여 관련 분야의 기술자와 협의한다. 기계의 기능장애를 알리고 기록하는 경보장치를 관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","certLic":"정보통신기사, 정보통신산업기사, 통신선로산업기사, 통신선로기능사","dJobECd":"8422","dJobECdNm":"[8422]통신장비 설치·수리원","dJobJCd":"7722","dJobJCdNm":"[7722]통신 관련 장비 설치 및 수리원","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003521:1', '{"dJobCd":"K000003521","dJobCdSeq":"1","dJobNm":"철도통신설비유지보수원","workSum":"역무실, 대합실, 승강장 본선이나 통신기계실에 설치되어 있는 각종 통신장비를 점검·유지 및 보수한다.","doWork":"기지국의 정전에 대비한 축전지 및 정류기를 점검·보수한다. 디지털전송설비, 화상전송설비, 열차무선전송설비 등의 열차운행설비를 점검한다. 역사자동안내방송설비, 행선안내게시기, CCTV, 복합통신설비, 콜폰 등의 서비스 설비 및 각종 교환기, 전화기, 이동통신 설비 등의 상태를 점검하고 이상이 있을 시 유지·보수한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실외","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"철도통신장비유지보수원, 철도통신시설유지보수원","certLic":"전자산업기사, 정보통신산업기사","dJobECd":"8422","dJobECdNm":"[8422]통신장비 설치·수리원","dJobJCd":"7722","dJobJCdNm":"[7722]통신 관련 장비 설치 및 수리원","dJobICd":"H491","dJobICdNm":"[H491]철도 운송업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005753:1', '{"dJobCd":"K000005753","dJobCdSeq":"1","dJobNm":"초고속망고장접수처리원","workSum":"초고속망서비스 사용자로부터 서비스의 중단 또는 품질불량 등의 불만을 접수하여 해당 시설을 시험하고 고장 구간별 작업자에게 수리작업을 할당한다.","doWork":"고장 신고 내역을 기초로 고장 유형을 파악한다. 시험장치를 이용하여 고장이력을 분석한다. 고객의 불편사항을 파악하고 해소한다. 고객응대 사항을 녹취시스템을 이용하여 저장하고 검색하여 이용한다. 고객과의 원격접속을 통해 고장에 대한 응급조치를 취한다. 다양한 시험방법을 통해 고객별 고장구간을 파악하고 고장내역을 문서화한다. 고장유형에 따라 작업 처리부서를 할당하고 작업자의 진행과정을 파악한다. 고장 이력관리를 위해 수리결과를 문서화한다. 수리내역을 고객에게 설명하고 수리결과에 대한 특이사항이 있으면 관련 부서와 공유한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"8422","dJobECdNm":"[8422]통신장비 설치·수리원","dJobJCd":"7722","dJobJCdNm":"[7722]통신 관련 장비 설치 및 수리원","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004794:1', '{"dJobCd":"K000004794","dJobCdSeq":"1","dJobNm":"통신내선공","workSum":"통신설비를 빌딩·공장·주택의 옥내에 설치하기 위하여 통신케이블이나 전선을 옥내에 설치·배선·보수한다.","doWork":"건축설계도면과 배선도를 읽고 구조물 내부의 배관상태, 통신설비의 설치 위치 등을 파악한다. 배관 루트를 따라 전선 또는 케이블로 포설한다. 옥내인입케이블과 옥내 배선 사이에 단자함을 설치하고 심선을 대조하여 연결한다. 전화, 교환기, 반송기기, 단말기 등 통신설비를 설치할 곳이나 이용목적에 적합하도록 플러그용 콘센트를 설치하고 포설된 선에 연결한다. 시험기기를 이용하여 회선접속 여부를 시험한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"통신공, 통신내선원, 통신전기공, 통신전기원, 통신전공","connectJob":"회선시험원","certLic":"통신선로기능사","dJobECd":"8422","dJobECdNm":"[8422]통신장비 설치·수리원","dJobJCd":"7722","dJobJCdNm":"[7722]통신 관련 장비 설치 및 수리원","dJobICd":"F423","dJobICdNm":"[F423]전기 및 통신 공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006331:1', '{"dJobCd":"K000006331","dJobCdSeq":"1","dJobNm":"통신설비수리원","workSum":"전신, 전화장비, 구내 통신선로 및 보조기기를 설치하거나 전화국 간의 중계선로의 연결상태를 점검 및 유지보수한다.","doWork":"통신장비의 설치 또는 보수의뢰를 확인하고 장소와 통신장비의 종류를 확인한다. 설계도면을 참고하여 통신선로를 분리·연결한다. 수동공구나 전기인두를 사용하여 전화기나 팩시밀리 등에 연결한다. 선로테스트를 통해 선로의 장애 유무를 확인한다. 테스터기를 이용하여 각종 통신선로를 점검하며 파손된 장비의 수리를 한다. 파손된 선로가 확인될 시 케이블의 파손상태 및 수리가능 여부를 확인하고 케이블단자에서 가입자까지의 선로고장을 보수한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"통신선로기능사","dJobECd":"8422","dJobECdNm":"[8422]통신장비 설치·수리원","dJobJCd":"7722","dJobJCdNm":"[7722]통신 관련 장비 설치 및 수리원","dJobICd":"S951","dJobICdNm":"[S951]컴퓨터 및 통신장비 수리업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003586:1', '{"dJobCd":"K000003586","dJobCdSeq":"1","dJobNm":"통신장비설치원","workSum":"전화기, 이동전화, 무선장비 등의 통신장비와 구내 통신선로 및 보조기기를 설치한다.","doWork":"통신장비의 설치접수증을 확인하여 설치할 장소와 통신장비의 종류를 확인한다. 통신배선도면을 검토하여 주배선반(MDF:Main Distribution Frame)으로부터 설치장소에 따라 중간배선반(IDF:Intermediate Distributing Frame)으로 통신선로를 연결하거나 구내단자로 직접 연결한다. 전화기, 인터넷모뎀 등의 통신장비의 설치가 완료되면 선로시험원에게 연락하여 선로의 장애 유무를 확인한다. 전류계, 저항계 등 각종 측정장비를 사용하여 구내의 통신선로를 점검하기도 하며 파손된 장비를 수리하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"8422","dJobECdNm":"[8422]통신장비 설치·수리원","dJobJCd":"7722","dJobJCdNm":"[7722]통신 관련 장비 설치 및 수리원","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005497:1', '{"dJobCd":"K000005497","dJobCdSeq":"1","dJobNm":"통신전기원","workSum":"발전통신원을 보조하여 발전소의 정보·통신설비를 유지·관리한다.","doWork":"통신선로를 순찰하며 경비용 인터폰, CCTV 및 적외선감지설비 등의 보안선로 및 통신선로의 이상 유무를 점검한다. 비상사태 및 위험한 상황에 대처하기 위하여 군부대 및 유관기관에 연결된 직통전화의 상태를 점검하는 등 발전통신원을 보조하여 정보·통신설비의 유지·관리를 한다. 기타 사무보조 업무를 수행한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"발전통신관리원","certLic":"정보처리기능사, 정보기기운용기능사, 통신기기기능사","dJobECd":"8422","dJobECdNm":"[8422]통신장비 설치·수리원","dJobJCd":"7722","dJobJCdNm":"[7722]통신 관련 장비 설치 및 수리원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003519:1', '{"dJobCd":"K000003519","dJobCdSeq":"1","dJobNm":"전용회선서비스개통원","workSum":"고객에게 전용회선 서비스를 개통해 주기 위해 케이블 접속, 통신장비 설치, 통신환경 구성의 업무를 수행한다.","doWork":"고객의 약정내용에 따라 전용회선 서비스 내용을 확인한다. 서비스에 따른 작업규모를 산정하고 작업지시서를 작성한다. 작업지시서에 따라 필요한 자재와 장비를 수령한다. 케이블의 종류, 연결방식, 결선 시험방법을 결정하고 시공한다. 케이블이 접속되면 시험 평가한다. 통신장비의 장비설치 환경을 구성하고 장비를 설치한다. 전용회선망의 환경을 파악하여 통신환경을 구성한다. 서비스 개통 작업을 수행하고 회선별, 규격별로 표준화된 측정기준에 의해 서비스품질을 측정한다. 고객의 약정사항에 준하여 개통결과를 확인하고 개통 관련 행정업무를 처리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"8423","dJobECdNm":"[8423]방송·통신·인터넷 케이블 설치·수리원","dJobJCd":"7723","dJobJCdNm":"[7723]통신·방송·인터넷케이블 설치 및 수리원","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002668:1', '{"dJobCd":"K000002668","dJobCdSeq":"1","dJobNm":"주배선반원","workSum":"전화가 원활히 소통되도록 주배선반을 유지관리한다.","doWork":"회선시험원의 호출에 따라 주배선반(MDF：Main Distributing Frame, 전화국 시험실에 위치하여 외선케이블과 교환기의 내선케이블 사이를 연결해주는 장치) 상의 번호 하나하나를 시험대와 연결하여 주배선반(MDF) 및 점퍼선의 이상 유무를 시험한다. 전출 시 전화 해지를 하며 가설공사를 한다. 심선불량, 노후선 유휴점퍼를 절체한다. 납땜 및 낡은 단자커버를 정비한다. 선로시험원과 공동으로 작업하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"주배선반유지보수원, MDF유지보수원","certLic":"통신선로산업기사, 통신선로기능사, 통신기기기능사","dJobECd":"8423","dJobECdNm":"[8423]방송·통신·인터넷 케이블 설치·수리원","dJobJCd":"7723","dJobJCdNm":"[7723]통신·방송·인터넷케이블 설치 및 수리원","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003104:1', '{"dJobCd":"K000003104","dJobCdSeq":"1","dJobNm":"초고속통신망설치원","workSum":"고객의 PC사양에 맞추어 초고속통신모뎀을 설치하고, 필요에 따라 소프트웨어를 설치한다.","doWork":"고객접수팀에서 발급한 설치지시서에 따라 일정표를 작성한다. 일정표에 따라 방문 전 고객에게 연락 후 방문한다. 우천 시 또는 고객부재 시에는 익일 혹은 고객과 재연락 후 방문한다. 집안의 PC가 있는 장소까지 인터넷 전용케이블을 구성한다. PC의 기종을 확인하여 송수신 신호를 세팅한다. 익스플로러 등 인터넷 활용을 위해 필요한 소프트웨어를 설치하고 인터넷 접속 등 사용가능 여부, 전송속도 등에 대하여 테스트를 실시한다. 개통등록을 한다. 고객의 요구에 따라 케이블 모뎀을 회수하고 고장접수 시 필요한 조치를 한다. IPTV, 인터넷전화 등 통신결합상품을 개통하거나 수리하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"통신선로산업기사, 통신선로기능사","dJobECd":"8423","dJobECdNm":"[8423]방송·통신·인터넷 케이블 설치·수리원","dJobJCd":"7723","dJobJCdNm":"[7723]통신·방송·인터넷케이블 설치 및 수리원","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003687:1', '{"dJobCd":"K000003687","dJobCdSeq":"1","dJobNm":"케이블방송단말기설치원","workSum":"케이블방송 가입자 단말기를 설치·철거한다.","doWork":"신규(이전) 인입선을 설치하는 경우 댁내 케이블 인입공법 표준에 따라 현장에 인입선을 설치하고 셋톱박스, 인터넷 모뎀, VoIP(인터넷전화), AP(무선인터넷 안테나) 등 서비스 종류에 따라 단말기를 설치한다. 인입선 설치 후 댁내 환경에 따라 신호점검을 하고 안정적인 조치를 한다. 단말기 설치 후 정상적인 서비스가 되는지 화면점검, PING(IP 네트워크를 통해 특정한 호스트가 도달할 수 있는지 테스트하는 컴퓨터 네트워크 도구), 통화품질을 테스트한다. 가입자 해지 시 철거 기준에 따라 인입케이블, 단말기, 부속자재 등을 회수하고 철거작업을 한다. 철거가 완료되면 해지 동의서 및 전산 해지처리 작업을 한다. 해지된 가입자 케이블의 인식표를 수정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"8423","dJobECdNm":"[8423]방송·통신·인터넷 케이블 설치·수리원","dJobJCd":"7723","dJobJCdNm":"[7723]통신·방송·인터넷케이블 설치 및 수리원","dJobICd":"J602","dJobICdNm":"[J602]텔레비전 방송업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001489:1', '{"dJobCd":"K000001489","dJobCdSeq":"1","dJobNm":"케이블작업반장","workSum":"전기선로용 및 통신용 단심케이블, 다심케이블 및 광케이블을 지하 또는 공중에 포설·설치·접속·시험하는 작업원의 활동을 감독·조정한다.","doWork":"설계도면 및 접속도면을 읽고 케이블 접속거리·회전수·부속설치장비 등을 파악하여 작업원과 작업상황에 대해 협의한다. 작업상황에 따라 작업원을 배치한다. 주파수발전기·저항측정기(암페어측정기)·임피던스측정기 등을 사용하여 케이블로딩, 절연시험, 도전시험, 장하 등 케이블을 시험한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","connectJob":"하는 일에 따라 케이블포설반장, 케이블접속반장, 케이블시험반장","certLic":"전기기능사, 통신선로기능사","dJobECd":"8423","dJobECdNm":"[8423]방송·통신·인터넷 케이블 설치·수리원","dJobJCd":"7723","dJobJCdNm":"[7723]통신·방송·인터넷케이블 설치 및 수리원","dJobICd":"F423","dJobICdNm":"[F423]전기 및 통신 공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004670:1', '{"dJobCd":"K000004670","dJobCdSeq":"1","dJobNm":"케이블접속원","workSum":"포설 또는 가선된 전기 및 통신용 단심케이블, 다심케이블 및 광케이블을 접속·시험하고 케이블 부속장비를 설치한다.","doWork":"케이블과 케이블 사이의 거리나 케이블과 기기 사이의 접속거리를 측정한다. 절단톱 등 공구를 사용하여 케이블의 접속에 용이한 적당한 길이로 절단한다. 절단부의 외피를 칼이나 외피제거용 공구를 사용하여 제거한다. 접속하기 알맞은 길이로 케이블의 심선피를 수동공구로 벗긴다. 절연지 또는 내화지로 접속부를 감고 케이블과 케이블은 결속기를 이용하여 방습용 연공슬립으로 압착하여 연결한다. 케이블과 기기는 케이블에 터미널을 걸고 압착기로 압착하여 부착한 후 볼트로 기기와 연결한다. 슬립의 주입구에 절연유(콤파운드)를 주입한다. 케이블의 용도와 목적에 맞는 단자함·지지대 등 부속장치를 설치한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"단말공, 케이블전공","connectJob":"하는 일에 따라 해저케이블접속원, 플랜트케이블접속원, 광케이블접속원, 특고압케이블전공, 고압케이블전공, 저압케이블전공","certLic":"전기기능사, 통신선로기능사","dJobECd":"8423","dJobECdNm":"[8423]방송·통신·인터넷 케이블 설치·수리원","dJobJCd":"7723","dJobJCdNm":"[7723]통신·방송·인터넷케이블 설치 및 수리원","dJobICd":"F423","dJobICdNm":"[F423]전기 및 통신 공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001529:1', '{"dJobCd":"K000001529","dJobCdSeq":"1","dJobNm":"케이블포설원","workSum":"전기선로용 및 통신용 단심케이블, 다심케이블 및 광케이블을 포설하기 위해 동도·관로 등을 매설하고 포설루트에 따라 케이블을 배열·투입·인출한다.","doWork":"설계도면에 따라 케이블을 포설한다. 포설루트에 따라 터파기 작업을 하고 시방서나 설계도면의 깊이로 파지면 바닥의 돌이나 울퉁불퉁한 면을 고르는 작업을 한다. 파이프를 깔고 파이프스페셜로 파이프를 고정한다. 파이프가 돌이나 기타 오물에 의해 파손되는 것을 막기 위하여 모래로 일정 높이까지 덮는다. 모래 위로 일정 높이까지 흙을 덮은 후 안전테이프를 덮고 흙으로 다시 메운다. 파이프에 안내선을 삽입하고 케이블과 연결한 뒤 인력이나 전동윈치 등을 이용하여 케이블을 포설한다. 케이블 포설 중 장력에 의한 케이블 파손을 감시하고 케이블의 원활한 포설을 위해 파이프에 윤활물질을 주입하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실외","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"케이블포설공, 케이블포설기사","connectJob":"통신외선원, 통신외선공","certLic":"전기기능사, 통신선로기능사","dJobECd":"8423","dJobECdNm":"[8423]방송·통신·인터넷 케이블 설치·수리원","dJobJCd":"7723","dJobJCdNm":"[7723]통신·방송·인터넷케이블 설치 및 수리원","dJobICd":"F423","dJobICdNm":"[F423]전기 및 통신 공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002337:1', '{"dJobCd":"K000002337","dJobCdSeq":"1","dJobNm":"통신선로가설원","workSum":"전화국 간의 중계선로나 수용가까지 통신선로를 가설한다.","doWork":"설계도면이나 작업지시서를 확인하여 가설할 위치와 케이블의 종류, 규격 등을 점검한다. 양수기를 사용하여 지중관의 물을 제거하고 케이블 인입선을 지중관에 투입한다. 케이블의 끝을 인입선에 연결하고 기계를 가동하여 케이블을 투입한다. 저항계, 전류계 등의 측정장비나 전화기를 연결하여 선로의 연결상태를 확인하고 장애 유무를 확인한다. 선로의 가설에 사용된 자재의 수량을 일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|고온|다습|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"장소에 따라 가공선로가설원, 지중선로가설원, 해저선로가설원","certLic":"통신선로산업기사, 통신선로기능사","dJobECd":"8423","dJobECdNm":"[8423]방송·통신·인터넷 케이블 설치·수리원","dJobJCd":"7723","dJobJCdNm":"[7723]통신·방송·인터넷케이블 설치 및 수리원","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004742:1', '{"dJobCd":"K000004742","dJobCdSeq":"1","dJobNm":"통신선로시험원","workSum":"단락, 잡음, 수신불량, 발신고장 등 신고된 고장내역을 시험·조사하기 위하여 통신선로를 시험·관리 및 운용한다.","doWork":"접수된 신고내역서를 확인하여 장애유형을 파악한다. 통신선로시험기를 가동하여 선로고장의 유형을 분석한다. 시험대의 측정장비를 사용하여 장애 위치를 확인한다. 장애의 유형이 판별되면 관련 부서에 연락하여 보수를 의뢰한다. 보수가 완료되면 소통상태를 점검하여 정상가동 여부를 확인한다. 주기적으로 통신선로 및 전화기의 감도, 전압특성 등의 시험을 실시하여 관련 자료를 정리한다. 일일 고장 신고량 및 보수내역을 정리하여 보고자료를 작성한다. 신규개통, 이전개통 등 회선개통 업무를 총괄하여 수행한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"장애통신선로시험원","connectJob":"일반회선시험원","certLic":"통신선로산업기사, 통신선로기능사","dJobECd":"8423","dJobECdNm":"[8423]방송·통신·인터넷 케이블 설치·수리원","dJobJCd":"7723","dJobJCdNm":"[7723]통신·방송·인터넷케이블 설치 및 수리원","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005132:1', '{"dJobCd":"K000005132","dJobCdSeq":"1","dJobNm":"통신선로유지보수원","workSum":"전화국 간에 연결된 중계선로의 연결상태를 점검하고 파손된 부위를 보수한다.","doWork":"파손된 선로의 설계도면 및 현장을 확인하여 파손상태를 점검한다. 케이블의 파손상태 및 수리가능 여부를 확인한다. 양수기를 사용하여 맨홀의 물을 제거하고 토치(Torch:금속 따위의 절단이나 용접에 사용하는 버너) 및 수동공구를 사용하여 파손된 케이블을 제거한다. 케이블의 심선을 연결하고 심선 접촉점을 열수축관 등을 이용하여 밀봉한다. 연결부위의 봉합상태를 확인하기 위하여 케이블에 주입하는 공기 및 가스의 누출 여부를 확인한다. 전신주에 부착된 단자함을 확인하여 누수 및 오염정도를 확인한다. 전화선을 연결하기 위하여 단자함에서 가입자까지 인입선을 가설한다. 가입자의 인입선로를 정비하고 실내선을 정리한다. 케이블 단자에서 가입자까지 선로고장을 탐지하고 보수한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|다습|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"전송로유지보수원, 케이블유지보수원, 중계선로유지보수원, 통신케이블유지보수원","connectJob":"장소에 따라 가공선로유지보수원, 지중선로유지보수원, 해저선로유지보수원","certLic":"통신선로산업기사, 통신선로기능사","dJobECd":"8423","dJobECdNm":"[8423]방송·통신·인터넷 케이블 설치·수리원","dJobJCd":"7723","dJobJCdNm":"[7723]통신·방송·인터넷케이블 설치 및 수리원","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006516:1', '{"dJobCd":"K000006516","dJobCdSeq":"1","dJobNm":"해저케이블보호원","workSum":"해저케이블 절체 사고를 예방하기 위한 감시 업무를 수행하고, 고장 발생 시 유지보수 업무를 지도 및 관리하며, 관련 홍보 및 교육을 실시한다.","doWork":"해저케이블 감시레이더를 이용하여 해저케이블 루트에 근접하는 조업선박을 포착하고, 감시선박을 현장에 출동하도록 조치한다. 케이블 루트변 조업포착 시에는 어업무선국, 해안경비정, 어업지도선과 협조하며 무선국을 이용하여 해저케이블 보호 홍보방송 및 조업계도 활동을 실시한다. 게재, 교육, 서신, 방문 및 간담회 개최 등을 통해 해저케이블 보호의 중요성을 주기적으로 홍보한다. 해저케이블 고장 발생 시 전송기조작원에게 절단지점을 확인토록 의뢰한다. 해저케이블 유지·보수선에 승선하여 절체 및 연결 작업에 대한 지도 및 관리를 한다. 해저케이블 고장발생을 분석하고 대책을 강구한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","certLic":"정보통신기술사, 정보통신기사, 정보통신산업기사","dJobECd":"8423","dJobECdNm":"[8423]방송·통신·인터넷 케이블 설치·수리원","dJobJCd":"7723","dJobJCdNm":"[7723]통신·방송·인터넷케이블 설치 및 수리원","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005317:1', '{"dJobCd":"K000005317","dJobCdSeq":"1","dJobNm":"금속구조물제작반장","workSum":"철교, 빌딩철구조물, 공장철골, 지그 등의 구조용 철구조물 및 금속제품을 제작하기 위하여 철구조물을 설계·현도하고 금속재료를 절단·절곡, 가공·용접하는 작업을 관리하며 금속구조물조립설치원의 활동을 감독·조정한다.","doWork":"설계도면을 검토하여 작업계획을 수립한다. 생산작업계획에 따라 작업일정을 수립한다. 공정별 작업공정계획을 수립한다. 납기생산일을 맞추기 위하여 생산라인을 구축한다. 생산장비, 소요인원, 주재료 및 부재료, 생산방법의 계획을 수립하여 작업자, 작업장비, 작업인원을 점검하고 감독한다. 각 공정별 책임자에게 작업지시를 내리고 소요되는 인원, 장비, 자재 등을 배치한다. 생산라인을 순회하여 감독·조정하며 공정상의 수정 및 개선사항을 지시한다. 생산품을 점검하여 시방서 또는 명세서와 일치하는지 확인한다. 작업상의 안전 및 위생 등을 점검하여 개선한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"철구조물제작반장","dJobECd":"7011","dJobECdNm":"[7011]강구조물 가공원 및 건립원","dJobJCd":"7811","dJobJCdNm":"[7811]강구조물 가공원 및 건립원","dJobICd":"C251","dJobICdNm":"[C251]구조용 금속제품, 탱크 및 증기발생기 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003701:1', '{"dJobCd":"K000003701","dJobCdSeq":"1","dJobNm":"금속구조물조립설치원","workSum":"건축물·도로·주택·공원 등에 사람이나 시설물을 보호하거나 방호하기 위하여 철강 및 스테인리스 봉을 천공, 절단, 성형 및 가공하여 구조용 부재로 조립한다.","doWork":"설계도면을 숙지하고 재료의 겉모양, 치수 등을 확인한다. 장비를 점검하고 작업지시를 확인한 후 치수에 따라 재료를 절단한다. 철물을 가공하기 위하여 수동기계나 자동기계의 작동범위를 설정하고 원하는 모양으로 벤딩가공을 한다. 가공이 완료되면 용접기를 사용하여 기둥, 칸살 등의 순서로 조립한다. 용접이 균일하고 외관의 변형이 없도록 한다. 조립이 완료되면 이물, 오물, 얼룩 등을 세척한 후 보관한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"난간설치원","dJobECd":"7011","dJobECdNm":"[7011]강구조물 가공원 및 건립원","dJobJCd":"7811","dJobJCdNm":"[7811]강구조물 가공원 및 건립원","dJobICd":"F421","dJobICdNm":"[F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003031:1', '{"dJobCd":"K000003031","dJobCdSeq":"1","dJobNm":"기초구조물설치반장","workSum":"교량의 교대 및 교각기초, 각종 사일로(Silo) 및 탱크의 기초, 대형건물의 기초, 해상구조물의 기초, 지하굴토벽의 붕괴방지, 성토의 지반개량을 위해 기초구조물을 설치하는 작업을 관리하고 기초구조물설치원의 활동을 감독·조정한다.","doWork":"도면을 읽고 작업내용과 규모를 파악하고 투입할 장비 및 인원을 관리한다. 기초구조물설치원과 기초구조물설치보조원이 설치한 대구경관의 각도 및 작업상태를 확인한다. 장비의 운전에 따른 작업진행상황을 점검하고 작업활동을 감독·조정한다. 부분품이나 완성된 구조물을 점검하여 명세서와 일치하는지 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"보통 작업","workPlace":"실외","workEnv":"위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","similarNm":"골조시공반장","dJobECd":"7011","dJobECdNm":"[7011]강구조물 가공원 및 건립원","dJobJCd":"7811","dJobJCdNm":"[7811]강구조물 가공원 및 건립원","dJobICd":"F412","dJobICdNm":"[F412]토목 건설업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002480:1', '{"dJobCd":"K000002480","dJobCdSeq":"1","dJobNm":"기초구조물설치원","workSum":"교량의 교대 및 교각기초, 각종 사일로 및 탱크의 기초, 대형건물의 기초, 해상구조물의 기초, 지하굴토벽의 붕괴방지, 성토의 지반개량을 위해 기초구조물을 설치한다.","doWork":"설정된 구간에 상부 토사유실방지를 위한 안내벽을 설치한다. 시공 위치로 착암장비를 이동시킨다. 대형착암기운전원에게 지시하여 시공할 부위를 굴착한다. 펌프를 이용하여 물과 섞인 토사를 토사분류장치로 이동시켜 토사를 제거한다. 착암 시 토압으로 인한 붕괴를 방지하기 위해 안정액을 교체하는 치완작업을 한다. 철근망을 삽입하고 콘크리트를 타설하여 기초구조물을 설치한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"힘든 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"골조시공원","connectJob":"대구경말뚝설치원, 지하연속벽설치원","dJobECd":"7011","dJobECdNm":"[7011]강구조물 가공원 및 건립원","dJobJCd":"7811","dJobJCdNm":"[7811]강구조물 가공원 및 건립원","dJobICd":"F412","dJobICdNm":"[F412]토목 건설업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005811:1', '{"dJobCd":"K000005811","dJobCdSeq":"1","dJobNm":"능형망제조원","workSum":"크리프(Creep) 장비 등 철망기계를 조작하여 금속울타리 등의 건축설치용 체인링크철망으로 사용하기 위한 능형망을 제조한다.","doWork":"작업명세서에 명시된 능형망의 규격에 따라 작업계획을 수립한다. 철망기계의 작동 여부를 점검한다. 철선의 굵기 등 규격을 정하고 제품의 종류에 따라 철선의 굵기와 그물눈(Mesh)의 크기에 맞는 금형틀을 선택하여 크리프기계에 설치하고 조정한다. 아연 도금철선재 및 PVC 피복철선재를 크리프(Creep : 외력이 일정하게 유지되어 있을 때, 시간이 흐름에 따라 재료의 변형이 증대하는 현상) 장비에 넣고 작업지시서의 규격에 맞게 굴곡각도를 설정한다. 철망기기를 작동하여 일정한 규격으로 철사를 구부리고 절단한다. 철망기기를 일정모양으로 교차하도록 기기를 조작하여 절단된 철선을 교차적으로 엮어준다. 기기를 작동하면서 마찰을 줄이기 위해 윤활유를 철선에 뿌리기도 한다. 날카로운 철사의 끝부분을 수동절단기로 절단하여 다듬질하고 교차된 철선을 두 가닥씩 꼬아준다. 제품의 품질을 검사하고 일정 규격에 맞게 포장하고 적재한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"체인링크철망제조원, 능형망펜스제조원","connectJob":"용접철망기조작원","dJobECd":"7011","dJobECdNm":"[7011]강구조물 가공원 및 건립원","dJobJCd":"7811","dJobJCdNm":"[7811]강구조물 가공원 및 건립원","dJobICd":"C251","dJobICdNm":"[C251]구조용 금속제품, 탱크 및 증기발생기 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004535:1', '{"dJobCd":"K000004535","dJobCdSeq":"1","dJobNm":"리벳원","workSum":"명세서에 따라 철판이나 판금 등으로 제조된 부품을 접합하거나 이탈을 방지하는 목적으로 리베팅건이나 리베팅기계를 조작한다.","doWork":"명세서를 확인하여 접합 및 조립부분을 숙지한다. 리베팅건이나 리베팅기계를 점검하고 리벳(Rivet:강철판·형강(形鋼) 등의 금속재료를 영구적으로 결합하는 데 사용되는 막대 모양의 기계요소)을 준비한다. 접합이나 조립할 부품의 리벳구멍에 리벳을 넣고 모루(Anvil:단조(鍛造)나 판금(板金)작업 때 공작재료를 얹어놓고, 해머로 두드려 가공하는 대)와 다이(받침), 리베팅건을 사용하여 접합한다. 리베팅기계의 작업대에 접합할 소재를 놓고 리벳구멍에 리벳을 놓는다. 손잡이와 고정나사를 돌려 램의 작동길이와 압력을 조절한다. 페달을 눌러 기계의 램을 작동시키고 소재를 접합한다. 반자동식 기계를 조작할 때 호퍼(Hopper:기계장치의 일부이며 깔때기 현상을 한 것)에 리벳을 채운다. 접합된 부분을 검사하여 잘못된 부분을 수정한다. 드릴을 사용하여 리벳구멍을 뚫기도 하며, 수동펀치를 사용하여 결함이 있는 리벳을 제거하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"리베팅기조작원, 리베팅머신조작원","dJobECd":"7011","dJobECdNm":"[7011]강구조물 가공원 및 건립원","dJobJCd":"7811","dJobJCdNm":"[7811]강구조물 가공원 및 건립원","dJobICd":"F421","dJobICdNm":"[F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003229:1', '{"dJobCd":"K000003229","dJobCdSeq":"1","dJobNm":"셔터설치반장","workSum":"건축물에 셔터를 설치하는 작업을 관리하고 셔터설치원의 활동을 감독·조정한다.","doWork":"작업시작 전에 설계도면이나 청사진을 숙지하고 셔터를 설치할 위치의 규격·수치 등을 자, 컴퍼스, 형판 등을 사용하여 측정하고 표시한다. 셔터 구조상의 이상 여부를 확인하고 셔터 형태를 결정한다. 셔터설치 절차에 따른 작업계획을 세우고, 각종 자재를 확보하는데 생기는 문제점을 해결한다. 작업원에게 작업절차와 안전에 대해서 교육하고, 작업내용 지시 및 작업배치를 한다. 지시된 작업이 제대로 이루어지는지 작업원과 함께 작업하며 작업내용을 점검한다. 작업진행상황을 파악하고 작업내용을 보고한다. 작업원에 대한 직무교육 및 안전위생교육을 통하여 직무수행능력을 향상시키고, 안전재해를 예방한다. 수시 관찰과 면담을 통하여 작업원의 애로사항 및 건의사항을 수렴하고 문제점을 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"저온|다습|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","dJobECd":"7011","dJobECdNm":"[7011]강구조물 가공원 및 건립원","dJobJCd":"7811","dJobJCdNm":"[7811]강구조물 가공원 및 건립원","dJobICd":"F424","dJobICdNm":"[F424]실내건축 및 건축마무리 공사업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002189:1', '{"dJobCd":"K000002189","dJobCdSeq":"1","dJobNm":"셔터설치원","workSum":"설계도면에 따라 건축물에 셔터를 제작·설치한다.","doWork":"기본 먹매김(이음, 맞춤의 가공, 부재의 부착을 위해 그 형상, 치수, 위치 등의 선을 부재 표면에 표시하는 것)에 따라 가이드레일, 개폐기인방틀 및 박스의 취부 위치를 선정·표시한다. 셔터의 작동을 원활히 감기게 하는 가이드레일(Guide Rail)의 위치를 선정하고 셔터 높이나 폭을 조절하여 천장의 고정철물에 수직이 되게 걸어 설치한다. 셔터를 받쳐주는 받침대(Bracket)를 좌판집(Lintel), 문지방(Sill)기둥, 철골, 기타 구조물에 용접하여 부착시킨다. 셔터를 감아주는 샤프트 파이프(Shaft pipe)를 받침대 베어링 부위에 연결한다. 전원으로 셔터를 감고 풀 수 있도록 하기 위하여 전동개폐기를 샤프트 파이프에 연결·설치한다. 구조물의 각 부위를 연결하기 위하여 휴대용 동력드릴·에어해머·수공구 등을 사용하여 금속·콘크리트벽·석조물·철골·셔터구조물 등에 구멍을 뚫는다. 샤프트 파이프의 볼트 구멍에 조인트를 부착하고 슬레이트(Slat)를 끼워 연결한다. 제작된 셔터조각을 도면의 높이만큼 끼워 가이드레일 속에 건다. 셔터 전동장치의 노출을 방지하기 위하여 셔터박스(Hood)를 하단마감재에 밀착시킨 상태에서 천정의 스트롱앵커에 연결하고 행거바 또는 앵글과 용접하여 설치한다. 전동개폐기의 전원에 전기를 결선한다. 감지기, 연동제어기, 자동폐쇄장치 등 각종 장치의 작동상태를 확인·점검한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"저온|다습|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"스프링셔터설치원, 전동셔터설치원","dJobECd":"7011","dJobECdNm":"[7011]강구조물 가공원 및 건립원","dJobJCd":"7811","dJobJCdNm":"[7811]강구조물 가공원 및 건립원","dJobICd":"F424","dJobICdNm":"[F424]실내건축 및 건축마무리 공사업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004320:1', '{"dJobCd":"K000004320","dJobCdSeq":"1","dJobNm":"철골마킹원","workSum":"철공사에 사용되는 원자재 및 부자재에 절단면, 천공위치, 취부위치 및 브래킷의 위치 및 방향을 표시한다.","doWork":"작업 전 부재의 규격, 재질, 손상 여부 등을 확인한다. 부재번호를 마킹펜으로 지워지지 않게 기입한다. 부재의 절단면, 천공위치를 줄자로 길이를 재서 금긋기 바늘 또는 센터펀치로 위치를 나타낸다. 줄자를 부재 위에 고정시킨다. 소부재의 취부위치, 브래킷의 위치 및 방향을 금긋기 바늘로 표시하고 마킹펜으로 크기, 방향을 기입한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"7011","dJobECdNm":"[7011]강구조물 가공원 및 건립원","dJobJCd":"7811","dJobJCdNm":"[7811]강구조물 가공원 및 건립원","dJobICd":"C251/F421","dJobICdNm":"[C251]구조용 금속제품, 탱크 및 증기발생기 제조업 / [F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006318:1', '{"dJobCd":"K000006318","dJobCdSeq":"1","dJobNm":"철골바닥재조립반장","workSum":"철골구조물의 슬래브에 콘크리트를 타설하기 위하여 바닥재를 설치하는 작업을 관리하고 철골바닥재조립원을 감독·조정한다.","doWork":"철골구조물의 조립상황을 점검하고 작업계획을 수립한다. 수립된 계획에 따라 자재를 수령하고 자재를 작업현장에 불출한다. 도면 및 시방서를 도해한 후 철골바닥재조립원이 효율적으로 작업할 수 있도록 적당한 위치에 배정하고 작업내용을 작업원에게 지시한다. 작업진행상황을 파악하고 작업내용을 보고한다. 작업원의 작업상황을 관리·감독한다. 작업공정에 있어 필요한 자재 및 기술을 지원한다. 작업계획에 따라 세부 실행항목을 수립하여 작업 절차 및 방법을 결정하여 작업원에게 작업내용을 지시하고 작업배치를 한다. 표준명세에 따라 지시된 작업이 이루어지는지 작업원의 작업상황을 관찰하고 점검한다. 작업원에 대한 직무교육 및 안전위생교육을 실시한다. 수시로 관찰과 면담을 통하여 작업원의 애로 및 건의사항을 수렴·해결하고 문제점을 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"힘든 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"데크플레이트반장","dJobECd":"7011","dJobECdNm":"[7011]강구조물 가공원 및 건립원","dJobJCd":"7811","dJobJCdNm":"[7811]강구조물 가공원 및 건립원","dJobICd":"F421","dJobICdNm":"[F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006532:1', '{"dJobCd":"K000006532","dJobCdSeq":"1","dJobNm":"철골바닥재조립원","workSum":"철골구조물에 슬래브를 콘크리트로 타설하기 위한 바닥재(데크플레이트)를 조립·설치한다.","doWork":"도면 및 시방서를 숙지한다. 철골 골조의 설치할 위치로 올라간다. 기중기조종원의 도움을 받아 자재를 설치할 위치로 운반한다. 시공부위를 청소하고 바닥재를 골조의 보에 하나씩 맞춰 펼쳐 놓는다. 바닥재(데크플레이트)가 보에 도면대로 배치되었는지 확인하고 시공할 부위를 먹줄로 표시한다. 표시한 선에 맞추어 바닥재 끝을 끼워 맞추고 낙하방지 및 날림방지를 위해 적당한 매수(5~10매)를 임시로 용접하여 고정시킨 후 탭 볼트나 타입 볼트로 고정한다. 절단기로 골조 밖으로 나온 부분을 절단한다. 바닥재와 보를 용접기를 사용하여 장방향과 폭방향으로 용접한다. 용접상태를 검사하고 부실한 곳을 보완한다. 콘크리트를 타설할 높이까지 콘크리트스토퍼를 설치한다. 바닥재(데크플레이트) 상면에 부착된 용접 이물질 등을 말끔히 청소하고 마무리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"데크원, 데크플레이트원","dJobECd":"7011","dJobECdNm":"[7011]강구조물 가공원 및 건립원","dJobJCd":"7811","dJobJCdNm":"[7811]강구조물 가공원 및 건립원","dJobICd":"F421","dJobICdNm":"[F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002968:1', '{"dJobCd":"K000002968","dJobCdSeq":"1","dJobNm":"철골조립반장","workSum":"건축구조물의 골조를 건립하기 위하여 기 제작된 강철부재를 조립·설치하는 작업을 관리하고 철골조립원의 활동을 감독·조정한다.","doWork":"설계도면을 숙지하고 작업장을 점검한다. 자재 및 장비의 종류와 양을 결정한다. 자재를 수령하고 기 제작된 부재의 형상 및 치수(길이, 폭, 두께), 접합부의 위치, 브래킷의 치수, 건물의 높이 등을 확인한다. 작업계획을 수립하여 작업내용을 작업원에게 지시·배치한다. 표준명세에 따라 지시된 작업이 이루어지는지 작업진행상황을 파악하여 작업내용을 보고 한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원 및 자재 공급을 한다. 세워진 골조의 수평·수직 상태를 레벨기를 사용하여 검사한다. 작업원에 대한 직무교육 및 안전위생교육을 실시한다. 수시 관찰과 면담을 통하여 작업원의 애로사항 및 건의사항을 수렴·해결하고 문제점을 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"힘든 작업","workPlace":"실외","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","dJobECd":"7011","dJobECdNm":"[7011]강구조물 가공원 및 건립원","dJobJCd":"7811","dJobJCdNm":"[7811]강구조물 가공원 및 건립원","dJobICd":"F421","dJobICdNm":"[F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004991:1', '{"dJobCd":"K000004991","dJobCdSeq":"1","dJobNm":"철골조립원","workSum":"건축구조물의 골조를 건립하기 위해 강철부재를 조립하고 설치한다.","doWork":"철골반장의 작업지시에 따라 작업에 필요한 공구를 준비한다. H형강, ㄱ형강, ㄷ형강 등의 자재를 이용하여 공장에서 제작된 철골을 설치할 위치까지 운반하기 위해 기중기의 견인쇠밧줄 및 사슬로 안전하게 고정시킨다. 운반된 강철부재를 설치할 위치로 유도하여 수평기를 이용하여 수평 및 수직 상태로 일치시킨다. 볼트를 조이고 용접하여 고정시키고 육안으로 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"철골공, 철구조물조립원, 강구조물건립원","connectJob":"용접, 볼트체결 등등","certLic":"용접기능사 등","dJobECd":"7011","dJobECdNm":"[7011]강구조물 가공원 및 건립원","dJobJCd":"7811","dJobJCdNm":"[7811]강구조물 가공원 및 건립원","dJobICd":"F421","dJobICdNm":"[F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001807:1', '{"dJobCd":"K000001807","dJobCdSeq":"1","dJobNm":"철구조물제작원","workSum":"철교, 빌딩철구조물, 공장철골 등의 철구조물을 제작하기 위하여 철구조물을 현도하고 금속재료를 절단, 가공, 용접하는 작업을 한다.","doWork":"주문서 및 작업지시서와 도면을 확인하고 자재를 확인한다. 도면에 맞게 절단선을 계산하여 표시한다. 표시된 절단선에 따라 가스절단기를 이용하여 절단한다. 절단된 부재를 자동용접기에 설치하고 자동용접기를 가동하여 전체용접을 한다. 용접을 마친 후 기타부품을 조립하는 부위에 파워 프레스(Power Press:판금 공작용 프레스의 일종)를 이용하여 홀가공을 한다. 용접부위의 용접잔여물이나 날카로운 부분을 연마기를 사용하여 표면을 매끄럽게 한다. 녹방지를 위해 구조물에 아연도금 등으로 도장한다. 게이지를 이용하여 겉모양, 치수, 아연도금부착량, 재하강도, 내충격성 등의 품질검사를 한다. 철벤딩기로 포장한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"철물공, 철구조물제작공","connectJob":"금속장식물제작반장, 새시품제작반장, 철물제작반장","certLic":"금속재창호기능사, 건축목공기능사, 플라스틱창호기능사, 문화재수리기능자(철물공)","dJobECd":"7011","dJobECdNm":"[7011]강구조물 가공원 및 건립원","dJobJCd":"7811","dJobJCdNm":"[7811]강구조물 가공원 및 건립원","dJobICd":"C251","dJobICdNm":"[C251]구조용 금속제품, 탱크 및 증기발생기 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003937:1', '{"dJobCd":"K000003937","dJobCdSeq":"1","dJobNm":"철망설치반장","workSum":"산업시설, 군사시설, 주택, 농장, 운동장 등에 철망, 앵글, 파이프 등 철물을 이용하여 보호 또는 방호용 울타리를 설치하는 작업을 관리하고, 철망설치원의 활동을 감독·조정한다.","doWork":"설계도면을 읽고 현장을 답사하여 철망설치를 위한 라인을 설정한다. 설치할 라인의 장애물을 파악한다. 주주를 설치할 위치에 따라 먹매김을 한다. 작업원이 효율적으로 작업할 수 있도록 적당한 위치에 배정하고 작업내용을 작업원에게 지시한다. 작업진행상황을 파악하고 작업내용을 보고한다. 작업원의 작업상황을 관리·감독하고 작업공정에 있어 필요한 자재지원 및 기술을 지원한다. 작업계획에 따라 세부실행항목을 수립하여 작업절차 및 방법을 결정하여 작업원에게 작업내용을 지시하고 작업배치를 한다. 표준명세에 따라 지시된 작업이 이루어지는지 작업원과 함께 작업하며 작업상황을 관찰하며 작업내용을 점검한다. 작업원에 대한 직무교육 및 안전위생교육을 실시한다. 수시로 관찰과 면담을 통하여 작업원의 애로 및 건의 사항을 수렴·해결하고 문제점을 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실외","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"펜스반장, 펜스설치반장","dJobECd":"7011","dJobECdNm":"[7011]강구조물 가공원 및 건립원","dJobJCd":"7811","dJobJCdNm":"[7811]강구조물 가공원 및 건립원","dJobICd":"F422","dJobICdNm":"[F422]건물설비 설치 공사업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006089:1', '{"dJobCd":"K000006089","dJobCdSeq":"1","dJobNm":"철망설치원","workSum":"산업시설, 군사시설, 주택, 농장, 운동장 등에 철망, 앵글, 파이프 등 철물을 이용하여 보호 또는 방호용 울타리를 설치한다.","doWork":"설계도면을 읽고 작업할 위치의 상황을 파악하기 위하여 현장을 답사한다. 작업 위치의 장애물을 제거하고 장비 및 자재의 진입로를 확보한다. 설계도면을 보고 먹메김한 일정 간격마다 거푸집설치를 위한 굴토작업을 한다. 설치된 거푸집에 주주를 고정시켜 콘크리트를 타설한다. 양생이 되면 거푸집을 제거하고 파인 부분에 되메운다. 설치된 기둥의 수직·수평도를 측정한다. 설치된 주주 사이에 동연을 상·하부에 조립한다. 상·하의 동연을 잇는 망을 핀이나 볼트·너트로 연결하고 철망이 울지 않게 하기 위하여 횡선을 규정 간격으로 설치한다. 침투봉(말뚝)으로 펜스를 견고하게 고정시킨다. 설치된 철망의 수직·수평도를 측정하고 잘못된 부분을 교정한다. 펜스의 종류에 따라 상단부에 가시철선이나 능형망을 설치한다. 작업여건에 따라 보조기둥을 설치한다. 도로, 공원, 주택, 공공시설물 등에 철물을 이용하여 소음이나 위험물로부터 사람이나 시설물 등을 보호·방호하기 위하여 울타리를 설치하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실외","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"펜스원, 펜스설치원","connectJob":"방음벽설치원, 가이드레일설치원, 가이드케이블설치원, 난간설치원","dJobECd":"7011","dJobECdNm":"[7011]강구조물 가공원 및 건립원","dJobJCd":"7811","dJobJCdNm":"[7811]강구조물 가공원 및 건립원","dJobICd":"F422","dJobICdNm":"[F422]건물설비 설치 공사업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007488:1', '{"dJobCd":"K000007488","dJobCdSeq":"1","dJobNm":"경량철골공","workSum":"경량철골을 사용하여 건물 내부에 천장 틀이나 경량벽체 틀을 설치하고 합판, 무늬판, 석고보드 등을 시공하여 천정이나 경량벽체를 설치한다.","doWork":"콘크리트 타설 전에 매립한 천장 틀 앵커인서트(Anchor Insert)에 천장으로부터 일정 간격 떨어져서 격자로 달대(반자틀을 위에서 달아매는 세로 재)를 설치한다. 절단기를 사용하여 경량철골을 치수에 맞도록 절단한다. 아연도금된 M형 금속막대(M-bar)를 찬넬크립으로 견고하게 고정시켜 천장 틀을 시공한다. 석고보드를 M형 금속막대의 중심이 되게 붙이며 이음새가 M형 금속막대의 중심에 오게 한다. 석고보드는 M형 금속막대에 수평을 맞추며 나사못의 머리는 보드표면보다 약간 들어가게 부착한다. 설치된 천장 틀에 합판, 무늬목, 석고보드를 올려 설치하고 못, 나사로 고정시킨다. 환기통, 전기기구를 설치하기 위해 간단한 용접을 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"경량철골원","connectJob":"석고보드취부원, 천장공, 천장텍스공","certLic":"목공기능사","dJobECd":"7012","dJobECdNm":"[7012]경량철골공","dJobJCd":"7812","dJobJCdNm":"[7812]경량 철골공","dJobICd":"F421","dJobICdNm":"[F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006201:1', '{"dJobCd":"K000006201","dJobCdSeq":"1","dJobNm":"경량철골반장","workSum":"건물 내부에 경량철골을 사용하여 천장 틀이나 경량벽체를 설치하고 합판, 무늬판, 석고보드 등을 설치하는 작업을 관리하고, 경량철골공의 활동을 감독·조정한다.","doWork":"작업시작 전에 설계도면을 보고 설치위치, 설치간격 등을 결정한다. 작업계획에 따라 세부실행 항목을 수립하여 작업절차 및 방법을 결정하여 작업원에게 작업내용을 지시하고 작업배치를 한다. 표준명세에 따라 지시된 작업이 이루어지는지 작업원과 함께 작업하며 작업상황을 관찰하여 작업내용을 점검한다. 작업진행상황을 파악하고 작업내용을 보고한다. 작업상황을 관리·감독하고 기술적인 지원 및 자재 공급을 한다. 작업원에 대한 직무교육 및 안전위생교육을 실시한다. 수시 관찰과 면담을 통하여 작업원의 애로 및 건의사항을 수렴·해결하고 문제점을 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"수동조작","dJobECd":"7012","dJobECdNm":"[7012]경량철골공","dJobJCd":"7812","dJobJCdNm":"[7812]경량 철골공","dJobICd":"F421","dJobICdNm":"[F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007086:1', '{"dJobCd":"K000007086","dJobCdSeq":"1","dJobNm":"금속판넬조립공","workSum":"건축구조물의 벽체나 지붕 등을 잇는 금속판을 성형·조립한다.","doWork":"설계도면을 보고 작업반장의 지시를 받는다. 철골조립원이 설치한 안전작업발판에 설치할 판넬(금속판) 및 부자재를 수령하여 치수별로 구별한다. 작업상황에 따라 판넬을 절단·가공한다. 설치할 판넬 옆면 하단부의 페이스플랫을 용접하여 연결하고 리베팅하여 나사못을 하단 철물에 고정한다. 옆면에 판넬을 하나씩 대고 일정 간격으로 전기드릴을 사용하여 나사못을 골조에 고정한다. 옆면이 설치되면 지붕 위로 자재를 운반한다. 일정 간격으로 판넬을 나열하여 배치한 후 판넬끼리 연결하고 상하를 맞추어 나사못으로 고정시킨다. 연결부위를 방수테이프로 부착하여 물이 스며드는 것을 방지한다. 지붕이 완료되면 판넬의 내용물이 보이지 않도록 처마 끝을 마감한다. 작업진행상의 잘못된 부분을 점검하고 보완한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"판넬공, 판넬원, 금속판넬조립원, 금속판넬원, 금속판넬공","dJobECd":"7012","dJobECdNm":"[7012]경량철골공","dJobJCd":"7812","dJobJCdNm":"[7812]경량 철골공","dJobICd":"F424","dJobICdNm":"[F424]실내건축 및 건축마무리 공사업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005025:1', '{"dJobCd":"K000005025","dJobCdSeq":"1","dJobNm":"강연선설치원","workSum":"옹벽(토사가 무너지는 것을 방지하기 위해 설치하는 구조물)의 전도 방지, 적교(쇠줄로 매단 다리)의 앵커, 철탑의 기초, 사면(斜面)구조물의 기초, 산사태 방지, 급경사지 붕괴 방지, 기성 콘크리트제품 제조 등 기초지반을 보강하거나 제품의 판형을 유지할 목적으로 강연선을 설치한다.","doWork":"기초지반을 보강·유지하기 위하여 강연선원이 제작한 강연선을 설치할 위치로 운반한다. 천공기운전원이 뚫어놓은 구멍의 밑바닥까지 강연선다발을 삽입한다. 그라우팅을 하기 위하여 전선관에 연결하고 수신호 또는 무전기를 이용하여 주입을 신호한다. 주입상태를 주시하고 그라우팅혼합제가 차면 신호하여 차단하고 전선관에 연결된 밸브를 뺀다. 천공기운전원을 보조하여 케이싱을 천공기에 연결하거나 그라우팅 시 혼합제가 차면 케이싱을 빼는 작업과 천공기에 압축공기밸브나 물공급밸브를 연결하는 보조업무를 수행하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"힘든 작업","workPlace":"실외","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"피시철근설치원, PC강연선설치원","dJobECd":"7013","dJobECdNm":"[7013]철근공","dJobJCd":"7821","dJobJCdNm":"[7821]철근공","dJobICd":"F421","dJobICdNm":"[F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003897:1', '{"dJobCd":"K000003897","dJobCdSeq":"1","dJobNm":"강연선원","workSum":"옹벽의 전도 방지, 적교(쇠줄로 매단 다리)의 앵커, 철탑의 기초, 사면(斜面)구조물의 기초, 산사태 방지, 급경사지 붕괴 방지, 기성 콘크리트제품 제조 등 기초지반을 보강하거나 제품의 판형을 유지할 목적으로 강재, 강선 또는 연선을 제작·조립한다.","doWork":"설계도면의 내용을 파악하고 공사현장관리자의 지시내용을 숙지한다. 롤 타입으로 된 강선 또는 연선을 풀어 도면에 표시된 일정 길이로 필요한 수량만큼 절단한다. 앵커채를 만들기 위하여 도면의 치수대로 정착장과 자유장의 치수를 표시한다. 그라우팅 시 모르타르(시멘트와 모래를 물로 반죽한 것) 혼합물을 주입할 전선관을 설치한 후 도면에 지시된 간격으로 설치할 철선의 개수만큼의 이가 있는 간격재를 설치한다. 조임쇠(가는 철사 등)를 이용하여 전선과 강연선을 유선형이 되도록 묶는다. 정착장의 설치가 완료되면 자유장을 설치한다. 전선관을 통하여 그라우팅을 주입할 때 여유장으로 모르타르혼합제가 넘어오는 것을 방지하기 위해 팩커장을 설치한다. 팩커장이 설치된 끝부분부터 자유장의 끝부분까지 피복재(천, PVC 등)를 씌우고 인장기를 물릴 수 있는 여유장을 만들면 제작이 완료된다. 완료된 강연선을 시공할 위치로 운반하기도 하고 강연선을 설치할 때 도와주기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"피에스원(Pre-Stressed),피시철근조립원, PC강연선조립원","dJobECd":"7013","dJobECdNm":"[7013]철근공","dJobJCd":"7821","dJobJCdNm":"[7821]철근공","dJobICd":"F421","dJobICdNm":"[F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003702:1', '{"dJobCd":"K000003702","dJobCdSeq":"1","dJobNm":"강연선인장원","workSum":"기초지반을 보강하거나 기성 콘크리트(Precast Concrete)제품의 판형을 유지할 목적으로 강연선을 인장기구를 사용하여 정착부분과 고정부분을 늘려주는 작업을 한다.","doWork":"강연선을 설치한 후 시멘트모르타르가 양생되면, 지시된 인장 강도를 도면이나 관리자의 지시에 따라 인장작업을 한다. 여유장의 겉으로 나와 있는 강연선의 가닥마다 앵커헤드를 끼운다. 하부받침대를 설치하고 인장기를 설치한다. 상부받침 고정대를 설치한다. 상부받침대에 설치된 콘(추삽이)으로 강연선을 물린다. 인장기를 작동시켜 지시된 수치만큼 유압계기를 조정하여 인장기를 가동한다. 지시된 인장강도가 되면 스위치를 끄고 설치된 유압기를 해체한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실외","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"피시철근인장원, PC강연선인장원, 피시강연선인장원","dJobECd":"7013","dJobECdNm":"[7013]철근공","dJobJCd":"7821","dJobJCdNm":"[7821]철근공","dJobICd":"F421","dJobICdNm":"[F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006002:1', '{"dJobCd":"K000006002","dJobCdSeq":"1","dJobNm":"기성콘크리트철근조립원","workSum":"설계도면이나 작업지시서에 따라 기성 콘크리트(Precast Concrete)제품을 제조하기 위하여 철망이나 철근을 절단기·굴곡기를 사용하여 가공·조립한다.","doWork":"설계도면이나 강재거푸집설치반장(건설)의 지시에 따라 제품의 규격을 확인하고 철근을 일정 길이로 절단한다. 절단된 철근을 벤딩기를 이용하여 규격에 맞게 가공한다. 철근을 배근하고 결속선으로 긴결(緊結:물체와 물체를 연결하거나 물체가 떨어져 나가지 못하도록 연결하는 것)한다. 철망을 규격에 맞추어 수동절단기나 전동절단기를 사용하여 절단하고 철근과 조립한다. 조립된 철근과 철망을 적재장소에 운반한다. 강재거푸집설치원이 철근과 철망을 거푸집에 설치한 후 PVC관 등의 부속물들을 삽입하여 고정시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"기성콘크리트철근조립공, PC콘크리트조립공, 피시콘크리트조립공, 기성콘크리트철근조립원, PC콘크리트조립원, 피시콘크리트조립원","dJobECd":"7013","dJobECdNm":"[7013]철근공","dJobJCd":"7821","dJobJCdNm":"[7821]철근공","dJobICd":"F421","dJobICdNm":"[F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007165:1', '{"dJobCd":"K000007165","dJobCdSeq":"1","dJobNm":"철근가스압접원","workSum":"철근 공사 시 철근 가스 압접을 수행한다.","doWork":"압접계획서, 철근배근도 등을 확인하여 압접위치, 압접개소 등을 파악한다. 압접장치 및 기구류(모재, 압접용가스, 가스, 가열기, 불대, 화구선, 압접기, 가압기, 기타 그라인더, 연마숫돌, 케이블 등)를 준비한다. 시공 전 시험을 실시하여 압접작업 및 기구의 이상 여부를 점검한다. 철근을 절단 또는 가공한다. 압접면의 불순물을 그라인더 등으로 처리한다. 압접하는 두 봉의 철근을 압접기에 맞대고 압접기를 가압 및 가열하여 압접한다. 압접부의 외관을 확인하고 이상이 있으면 압접부를 떼어내고 재접합 및 재가열, 재압접하여 수정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|손사용|시각|","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"용접기능사, 용접산업기사, 용접기능장","dJobECd":"7013","dJobECdNm":"[7013]철근공","dJobJCd":"7821","dJobJCdNm":"[7821]철근공","dJobICd":"F421","dJobICdNm":"[F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007533:1', '{"dJobCd":"K000007533","dJobCdSeq":"1","dJobNm":"철근공","workSum":"건물, 다리, 댐 등의 건설공사에서 콘크리트를 보강시키기 위하여 철근을 자르고 구부려 콘크리트 틀이나 콘크리트를 타설할 곳에 넣어 고정시킨다.","doWork":"설계도면이나 철근반장의 지시에 따라 철근을 규격대로 절단한다. 수동공구와 철근만곡공구로 철근의 적절한 부위를 지시된 각도로 구부린다. 가공된 철근을 시공할 위치로 운반한다. 콘크리트 포설 시 하중을 견디기 위하여 철근과 철근의 이음매를 결속선으로 묶거나 용접하여 연결한다. 거푸집과 철근과의 간격을 유지하기 위하여 철근재, 모르타르재, 패킹재 등의 간격재를 설치한다. 변경되거나 잘못된 부분을 해체·보수한다. 설치된 철근의 배근상태를 점검한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"힘든 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"철근원, 철근기능원","connectJob":"철근절단원","certLic":"철근기능사","dJobECd":"7013","dJobECdNm":"[7013]철근공","dJobJCd":"7821","dJobJCdNm":"[7821]철근공","dJobICd":"F421","dJobICdNm":"[F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006284:1', '{"dJobCd":"K000006284","dJobCdSeq":"1","dJobNm":"철근반장","workSum":"건물, 도로, 다리, 댐 등의 건설공사에서 콘크리트를 보강시키기 위하여 철근을 자르고 구부려 고정시키는 작업을 관리하고 철근공의 활동을 감독·조정한다.","doWork":"설계도면을 점검하고 철근의 굵기와 수량을 파악한다. 작업계획을 수립하여 작업내용을 작업원에게 지시·배치한다. 표준명세에 따라 지시된 작업이 이루어지는지 작업진행상황을 파악하여 작업내용을 보고한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원 및 자재 공급을 한다. 철근의 고정상태, 철근 간의 배치 및 간격이 도면에 따라 시공되었는지를 확인·검사한다. 작업원에 대한 직무교육 및 안전위생교육을 실시한다. 수시 관찰과 면담을 통하여 작업원의 애로사항 및 건의사항을 수렴·해결하고 문제점을 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","certLic":"철근기능사","dJobECd":"7013","dJobECdNm":"[7013]철근공","dJobJCd":"7821","dJobJCdNm":"[7821]철근공","dJobICd":"F421","dJobICdNm":"[F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003913:1', '{"dJobCd":"K000003913","dJobCdSeq":"1","dJobNm":"견출공","workSum":"건축구조물의 콘크리트벽 내·외부의 미관을 좋게 하기 위하여 매끈하게 마무리 작업을 한다.","doWork":"거푸집 제거 후 표면의 폼타이(Form-tie:강철제 거푸집의 조임 기구)를 제거한다. 견출면의 구멍부위, 조인트면의 돌출부위를 제거한다. 제거된 부위에 시멘트모르타르를 바른다. 시공면을 그라인더로 매끈하게 처리한다. 접착제와 시멘트페이스트를 혼합하여 분칠한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"견출원, 콘크리트견출공, 콘크리트견출원, 콘크리트견출기능공","connectJob":"콘크리트견출공, 콘크리트견출원, 콘크리트견출기능공","dJobECd":"7014","dJobECdNm":"[7014]콘크리트공","dJobJCd":"7822","dJobJCdNm":"[7822]콘크리트공","dJobICd":"F424","dJobICdNm":"[F424]실내건축 및 건축마무리 공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004119:1', '{"dJobCd":"K000004119","dJobCdSeq":"1","dJobNm":"그라우팅반장","workSum":"연약지반 강화 및 개량, 교대 및 교각의 방호, 지반굴착 시 인접 건물의 침하·누수 방지를 위해 땅속 또는 암반의 틈에 모르타르, 물유리 등의 그라우트액을 주입하는 작업을 관리하고, 그라우팅원과 그라우팅보조원의 활동을 감독·조정한다.","doWork":"그라우팅원과 그라우팅보조원이 설치한 주입기를 확인한다. 그라우트 압력계기를 관찰하여 작업의 진행 여부를 판단한다. 그라우팅펌프·그라우트믹서기 등 장비를 점검·정비하고 기계의 설치위치를 정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실외","workEnv":"위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"그라우팅기계반장, 그라우팅기반장","dJobECd":"7014","dJobECdNm":"[7014]콘크리트공","dJobJCd":"7822","dJobJCdNm":"[7822]콘크리트공","dJobICd":"F421","dJobICdNm":"[F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006202:1', '{"dJobCd":"K000006202","dJobCdSeq":"1","dJobNm":"그라우팅보조원","workSum":"연약지반 강화 및 개량, 교대 및 교각의 방호, 지반굴착 시 인접 건물의 침하·누수 방지를 위해 땅속 또는 암반의 틈에 모르타르, 물유리 등의 그라우트액을 주입하는 그라우팅원을 보조한다.","doWork":"믹서기에서 모르타르 등 혼합물을 만들기 위해 재료를 투입하고 배합비율을 조절한다. 그라우팅펌프에 혼합물을 보낸다. 그라우팅펌프·그라우트혼합기 등의 장비를 물과 공기압축기로 세척하고 수동공구를 사용하여 간단한 정비를 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실외","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"그라우팅기계보조원, 그라우팅기보조원","dJobECd":"7014","dJobECdNm":"[7014]콘크리트공","dJobJCd":"7822","dJobJCdNm":"[7822]콘크리트공","dJobICd":"F421","dJobICdNm":"[F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005194:1', '{"dJobCd":"K000005194","dJobCdSeq":"1","dJobNm":"그라우팅원","workSum":"연약지반 강화 및 개량, 교대 및 교각의 방호, 지반굴착 시 인접 건물의 침하·누수 방지를 위해 땅속 또는 암반의 틈에 모르타르, 물유리 등의 그라우트액을 고압주입펌프로 주입하는 기계를 조작한다.","doWork":"시추원이 뚫어놓은 구멍에 주입기를 넣고 핸들을 돌려 고정시킨다. 그라우팅펌프 및 그라우트믹서기를 설치할 적당한 위치를 선정하고 고정시킨다. 그라우트주입기와 그라우팅펌프를 호스로 연결하고 전원을 연결한다. 그라우트믹서기에 시멘트·물 등 혼합재료를 일정 비율로 투입하여 혼합한다. 혼합된 재료를 그라우트펌프에 보내 압력을 주어 그라우팅주입기로 보내도록 한다. 압력계기를 관찰하며 밸브를 돌려 그라우트 주입압력을 조정하며 땅속, 암반 등의 균열부위에 그라우트를 밀어 넣는다. 그라우트의 흐름을 관찰하며 시공부위가 충진되었을 때 밸브를 잠근다. 그라우트가 양생되면 주입기를 제거하고 구멍을 시멘트로 메우거나 쐐기를 박는다. 그라우팅펌프·그라우트믹서기·모터·피대 등 장비를 수동공구를 사용하여 정비한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실외","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"그라우팅기계원, 그라우팅기계조작원, 그라우팅기조작원","dJobECd":"7014","dJobECdNm":"[7014]콘크리트공","dJobJCd":"7822","dJobJCdNm":"[7822]콘크리트공","dJobICd":"F421","dJobICdNm":"[F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001506:1', '{"dJobCd":"K000001506","dJobCdSeq":"1","dJobNm":"기성콘크리트제품조립반장","workSum":"아파트 등의 콘크리트 조립건축물을 건립하기 위하여 철구조물이나 콘크리트 기둥에 기 제작된 피시(Precast Concrete)를 조립하는 작업을 관리하고 기성콘크리트조립공의 활동을 감독·조정한다.","doWork":"기성 콘크리트(Precast Concrete) 조립에 따른 전반적인 공사계획을 세운다. 작업내용을 작업원에게 지시·배치한다. 작업계획에 따라 세부실행항목을 수립하고 작업절차 및 방법을 결정한다. 작업원에게 작업내용을 지시하거나 작업을 배치한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원 및 자재 공급을 한다. 표준명세에 따라 지시된 작업이 이루어지는지 진행상황을 파악하여 작업내용을 보고한다. 작업원에 대한 직무교육 및 안전위생교육을 실시한다. 수시 관찰과 면담을 통하여 작업원의 애로사항 및 건의사항을 수렴·해결하고 문제점을 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"콘크리트건물조립반장, 피시조립반장, PC콘크리트조립반장, 조립콘크리트설치반장","dJobECd":"7014","dJobECdNm":"[7014]콘크리트공","dJobJCd":"7822","dJobJCdNm":"[7822]콘크리트공","dJobICd":"F411","dJobICdNm":"[F411]건물 건설업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003654:1', '{"dJobCd":"K000003654","dJobCdSeq":"1","dJobNm":"기성콘크리트조립공","workSum":"아파트 등의 콘크리트 조립건축물을 건립하기 위하여 철물구조물이나 콘크리트 기둥에 철근, PVC파이프를 절단·가공하여 기성 콘크리트(Precast Concrete)를 조립한다.","doWork":"아파트 등의 콘크리트 조립건축물 건립에 사용할 기성 콘크리트(Precast Concrete)제품을 생산하기 위하여 설계도면이나 작업지시서에 명시된 기성 콘크리트제품의 규격, 철근 길이 등을 확인한다. 치수에 따라 철근에 절단위치를 표시한다. 수동절단기 또는 자동절단기를 사용하여 철근의 표시된 부위를 절단한다. 절단된 철근을 기성 콘크리트의 규격대로 조형된 강재거푸집 안에 뼈대를 배근하고, 가는 철사로 교차지점을 잇는다. 전화선이나 전기선을 설치하기 위하여 PVC파이프를 절단·가공하여 철근 사이에 조립한다. 강재거푸집설치원의 직무를 수행하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"웅크림|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"콘크리트건물조립원, 피시조립원, PC콘크리트조립공, 조립콘크리트설치원","dJobECd":"7014","dJobECdNm":"[7014]콘크리트공","dJobJCd":"7822","dJobJCdNm":"[7822]콘크리트공","dJobICd":"F411","dJobICdNm":"[F411]건물 건설업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007467:1', '{"dJobCd":"K000007467","dJobCdSeq":"1","dJobNm":"콘크리트공","workSum":"콘크리트 공사 시 콘크리트 차량을 유도하고 타설된 콘크리트를 평탄하게 다진다.","doWork":"콘크리트반장의 지시에 따라 작업공정을 파악하고 콘크리트를 포설할 거푸집과 철근을 점검한다. 콘크리트를 포설 위치에 타설하기 위해 레미콘차량, 펌프카 등을 유도한다. 포설된 콘크리트의 기공을 없애기 위해 진동기나 다짐기를 이용하여 평탄하게 다지고 철근 및 거푸집 구석까지 채워졌는지 확인한다. 산업시설, 주택, 농장, 아파트 경계에 콘크리트를 사용하여 울타리를 설치하기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"투입인출","similarNm":"콘크리트원, 공구리공, 시멘트공, 콘크리트기능원","certLic":"콘크리트기능사","dJobECd":"7014","dJobECdNm":"[7014]콘크리트공","dJobJCd":"7822","dJobJCdNm":"[7822]콘크리트공","dJobICd":"F421","dJobICdNm":"[F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003862:1', '{"dJobCd":"K000003862","dJobCdSeq":"1","dJobNm":"콘크리트반장","workSum":"콘크리트 공사 시 콘크리트를 포설하는 작업을 관리하고, 콘크리트공의 활동을 감독·조정한다.","doWork":"건물, 도로, 다리, 댐 등의 구조물 시공 시 시공절차 및 건축법규에 따라 작업계획을 세우고 콘크리트공의 업무조정 및 장비계획을 수립한다. 철근 및 목공 관련 반장과 작업일정을 협의하여 작업일정을 조정한다. 콘크리트 포설 및 양생과정을 확인한다. 작업공정일지, 검사일지, 공정보고서 등을 작성하여 건설시공관리자에게 보고한다. 콘크리트공의 안전교육을 실시하고 활동을 관리·감독한다. 수시 관찰과 면담을 통하여 작업원의 애로사항 및 건의사항을 수렴·해결하고 문제점을 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"투입인출","similarNm":"공구리반장, 시멘트반장","certLic":"콘크리트기능사","dJobECd":"7014","dJobECdNm":"[7014]콘크리트공","dJobJCd":"7822","dJobJCdNm":"[7822]콘크리트공","dJobICd":"F421","dJobICdNm":"[F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002119:1', '{"dJobCd":"K000002119","dJobCdSeq":"1","dJobNm":"테라조공","workSum":"내구력과 미관을 높이기 위하여 건축물의 벽, 바닥, 계단 등에 백시멘트, 종석, 안료 등의 혼합액을 포설하여 바른다.","doWork":"테라조(Terrazzo:각종 돌의 파편을 백색 시멘트 등으로 굳힌 모조 자연석)의 색상과 포설량을 사양서와 비교·확인한다. 바닥을 평탄하게 고른 후 내림추, 수평실 등으로 위치를 나누고 필요시 먹줄을 쳐서 표시한다. 종석을 깨끗이 씻어 시멘트, 모래, 색소 등과 일정한 비율로 혼합한다. 테라조 시공면에 테라조 첫겹을 구획하기 위하여 목재틀을 설치한다. 시공면에 방수지를 깔고 모르타르(Mortar)를 목재틀 부위까지 포설한다. 목재틀을 떼어내고 바름구획, 균열방지, 보수용이를 위하여 청동재 줄눈대를 일정 간격으로 배치하여 눌러준다. 줄눈대와 모르타르면이 수평이 되도록 색소가 혼합된 모르타르와 종석을 뿌려서 고르게 편다. 표면에 종석을 뿌리고 롤러로 밀어준다. 표면의 수평상태를 점검한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"다습|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"테라조원","dJobECd":"7014","dJobECdNm":"[7014]콘크리트공","dJobJCd":"7822","dJobJCdNm":"[7822]콘크리트공","dJobICd":"F424","dJobICdNm":"[F424]실내건축 및 건축마무리 공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003061:1', '{"dJobCd":"K000003061","dJobCdSeq":"1","dJobNm":"테라조연마공","workSum":"테라조·인조석 등의 바름면을 평탄하게 하고 광택을 내기 위하여 연마기를 이용하여 연마한다.","doWork":"경화 정도를 점검하여 연마 적합 여부를 결정한다. 적당한 연마제로 연마기를 조작하여 테라조바름면을 간다. 물로 초벌연마면을 청소하고 시멘트 풀을 이용하여 표면 공극을 메우고 보양한다. 정밀한 연마제로 교체하고, 재벌 및 정벌연마작업을 한다. 연마면을 물로 청소하여 건조시킨다. 옥산살(Oxalic Acid)을 물에 녹여 테라조면에 뿌리고 모포 조각을 끼운 연마기로 문질러 때를 벗긴다. 건조한 테라조면에 왁스를 바르고 펠트를 끼운 연마기를 조작하여 광택을 낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"다습|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"인조석연마원, 테라조연마원","dJobECd":"7014","dJobECdNm":"[7014]콘크리트공","dJobJCd":"7822","dJobJCdNm":"[7822]콘크리트공","dJobICd":"F424","dJobICdNm":"[F424]실내건축 및 건축마무리 공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002242:1', '{"dJobCd":"K000002242","dJobCdSeq":"1","dJobNm":"건설할석공","workSum":"도로, 궤도, 가스, 수도, 전기, 건축, 토목 등의 공사현장에서 압축공기 및 유압식 핸드브레이커(Hand Breaker)를 사용하여 콘크리트, 벽돌, 지반 등을 파쇄 및 절삭한다.","doWork":"파쇄대상물의 위치 및 강약 정도를 확인한다. 작업에 맞는 브레이커와 정(돌에 구멍을 뚫거나 돌을 쪼아서 다듬는 쇠로 만든 연장)의 종류를 결정한다. 파쇄할 암반 및 콘크리트 구조물에 정을 대고 양쪽 손잡이를 눌러 파쇄한다. 정밀작업이 요구될 때에는 망치, 정 등의 수공구를 사용하여 조금씩 파쇄한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"할석원, 브레이커원, 할석공","certLic":"석공기능사","dJobECd":"7015","dJobECdNm":"[7015]건축 석공","dJobJCd":"7823","dJobJCdNm":"[7823]건축 석공","dJobICd":"F411/F412/F426","dJobICdNm":"[F411]건물 건설업 / [F412]토목 건설업 / [F426]건설장비 운영업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007475:1', '{"dJobCd":"K000007475","dJobCdSeq":"1","dJobNm":"건축석공","workSum":"화강석·자연석 등 건축용 석재를 다듬고 일정한 형태로 쌓거나 가공·설치한다.","doWork":"가공된 돌을 지정된 위치·번호·크기·형태·색상에 따라 선별한다. 공법에 맞추어 시공면에 모르타르를 바르거나 제작된 앵글을 조립한다. 손 또는 인양 장비를 이용하여 가공 석재를 들어 올려 모르타르면 위에 붙이거나 앵글에 고정시킨다. 석재 표면을 망치로 두들겨 고르게 한다. 흙손을 사용하여 돌의 연결부분에 모르타르나 치장용재를 채운다. 수평기·측연추 등을 사용하여 석재의 정위치 상태와 무늬·형태를 점검한다. 수공구나 전동공구를 사용하여 석재를 시공에 편리하도록 재단·절단·가공하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"손사용|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"석공, 건축석공기능원","connectJob":"한식석공(가공석공), 한식석공(쌓기석공), 조경석석공","certLic":"석공기능사, 국가유산수리기능자(가공석공, 쌓기석공)","dJobECd":"7015","dJobECdNm":"[7015]건축 석공","dJobJCd":"7823","dJobJCdNm":"[7823]건축 석공","dJobICd":"F424","dJobICdNm":"[F424]실내건축 및 건축마무리 공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005672:1', '{"dJobCd":"K000005672","dJobCdSeq":"1","dJobNm":"건축석공반장","workSum":"건축용 석재를 다듬고 일정한 형태로 쌓거나 설치하는 작업을 관리하고 건축석공의 활동을 감독·조정한다.","doWork":"도면을 읽고 작업내용과 규모에 따른 시공계획을 수립한다. 입수된 석재의 종류와 석공사 시공법에 대하여 작업원들과 합의하고 업무를 나눈다. 석공사에 소요될 앵글·시멘트·인양 장비 등을 구입 또는 청구한다. 전통한식기법으로 가옥, 사찰, 궁궐 등의 전통건축물의 주춧돌, 기단석, 성곽 등을 가공하고 쌓는 건축석공의 활동을 감독하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"손사용|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"석공반장","connectJob":"한식석공편수","certLic":"석공기능사","dJobECd":"7015","dJobECdNm":"[7015]건축 석공","dJobJCd":"7823","dJobJCdNm":"[7823]건축 석공","dJobICd":"F424","dJobICdNm":"[F424]실내건축 및 건축마무리 공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005471:1', '{"dJobCd":"K000005471","dJobCdSeq":"1","dJobNm":"건축석축공","workSum":"석조건축물, 댐, 축대 등 석축구조물을 건립하기 위하여 돌을 다듬고 쌓는다.","doWork":"도면을 읽고 규준틀이나 측연추를 설치한다. 축조형태와 도면에 지시된 치수에 따라 정, 망치, 동력공구 등을 이용하여 돌을 다듬는다. 시공면을 고르게 하고 배합모르타르를 바른다. 기중기를 이용하거나 손으로 다듬은 돌을 모르타르 위에 축조한다. 돌의 축조모양과 위치를 바르게 잡고 모르타르 또는 작은 돌로 연결부분을 채운다. 축조높이와 길이, 경사도, 축조모양 등을 점검한다. 잡석, 토사, 시멘트 모르타르 등으로 뒤채움 작업을 하도록 작업원을 지휘한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실외","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"견치석공, 적석공, 석축공","certLic":"석공기능사","dJobECd":"7015","dJobECdNm":"[7015]건축 석공","dJobJCd":"7823","dJobJCdNm":"[7823]건축 석공","dJobICd":"F421","dJobICdNm":"[F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001380:1', '{"dJobCd":"K000001380","dJobCdSeq":"1","dJobNm":"국가유산석조각공","workSum":"정과 망치로 형태나 도안부분을 쪼아서 문양이나 형태를 조각하여 석조형물을 제작한다.","doWork":"조각할 석재를 준비하고 도면에 맞추어 크기를 정해 큰정으로 쪼아내고 작은정으로 곱게 쪼아내고 도드락으로 다듬는다. 조각할 도안을 석재표면에 모사한다. 도안 형태의 선과 면을 분석하여 조각할 부분을 표시하고 외형부터 먹칼이나 붓으로 선을 그린다. 큰정, 중간정, 작은정, 털이개, 큰망치, 중간망치, 작은망치 등 각종 망치와 정을 사용하여 평면, 곡면, 곡선, 홈 등 각종 형태를 치석(治石)하며 조각한다. 자나 측정기로 측정하여 도면에 규정된 깊이로 조각면을 파내고 조각한다. 조각이 완성되면 작은정으로 곱게 다듬는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"힘든 작업","workPlace":"실내·외","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"석재조각원","connectJob":"석조각공","certLic":"문화재석수리조각공","dJobECd":"7015","dJobECdNm":"[7015]건축 석공","dJobJCd":"7823","dJobJCdNm":"[7823]건축 석공","dJobICd":"F424","dJobICdNm":"[F424]실내건축 및 건축마무리 공사업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004448:1', '{"dJobCd":"K000004448","dJobCdSeq":"1","dJobNm":"석편수","workSum":"전통한식기법으로 한옥, 성곽, 능, 누곽, 사원, 사찰, 궁궐 등의 석구조물과 국가유산을 건립 및 복원하는 작업을 관리하고 한식석공을 관리·감독한다.","doWork":"설계서나 시방서에 따라 석구조물 및 고정설치물을 만들거나 조립하는 일을 계획한다. 작업원을 배치하고 사용할 석재와 자재들이 건축관계법규(건축법, 국가유산수리표준시방서)와 부합하는지 여부를 검사한다. 조립 또는 세우기에 앞서 각 부재의 조립순서, 사용기구, 조립방법 등 세부계획을 수립하여 담당원에게 승인을 받는다. 석재의 가공, 조립, 설치 등에 대한 기술과 관련 법규 및 시방서의 내용을 한식석공과 쌓기석공, 드잡이공, 석조각공에게 숙지시킨다. 석부재 치석을 위해 이음 및 맞춤 현척도를 작도하여 부재에 직접 도해한다. 작업을 지시. 조정하고 전체적인 작업공정을 관리한다. 국가유산을 보수신축할 경우 국가유산청 직원과 문제점을 협의하고 해결방안을 모색한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"대석수, 도석수","connectJob":"나무를 다루면 도편수","certLic":"건축석공기능사, 문화재수리기능자(대석수)","dJobECd":"7015","dJobECdNm":"[7015]건축 석공","dJobJCd":"7823","dJobJCdNm":"[7823]건축 석공","dJobICd":"F424","dJobICdNm":"[F424]실내건축 및 건축마무리 공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003226:1', '{"dJobCd":"K000003226","dJobCdSeq":"1","dJobNm":"암석조각원","workSum":"암석 조각기술을 이용하여 석제품제작원(기타 비금속광물제품제조)이 개발한 원형에 맞추어 암석을 조각한다.","doWork":"제품 도안을 확인하고 작업도구를 준비한다. 준비된 석재를 가공선반이나 작업대로 이동한다. 대형석재의 경우 지게차나 크레인으로 이동한다. 석재 위에 조각할 모양을 투사지를 사용하여 모사하거나 종이에 출력해서 붙이는 방법으로 가공선을 표시한다. 보안경, 보안모자, 방진복을 착용하고 다이아몬드연마기, 드릴, 쇄기, 망치 등을 사용하여 가공선에 따라 석재를 자르고 쪼갠다. 대형석재의 경우 가공면을 바꾸기 위하여 지게차를 사용한다. 작업물과 먼 거리에서 작업물을 관찰하여 구도를 확인하고 도안, 설계도와 수시로 비교한다. 제품에 따라 석재표면을 토치(Torch:금속 따위의 절단이나 용접에 사용하는 버너)로 가열하는 표면처리를 하기도 한다. 제품에 따라 음각으로 글씨, 그림 등을 새겨 넣고 유성페인트를 칠하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"불상조각원, 비석조각원, 화병조각원, 화강암조각원, 기념비석공","certLic":"국가유산수리기능자(석조각공)","dJobECd":"7015","dJobECdNm":"[7015]건축 석공","dJobJCd":"7823","dJobJCdNm":"[7823]건축 석공","dJobICd":"C239","dJobICdNm":"[C239]기타 비금속 광물제품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007213:1', '{"dJobCd":"K000007213","dJobCdSeq":"1","dJobNm":"호안석공","workSum":"파도와 누수에 의해 수상 및 수중 축조물이 붕괴되는 것을 방지하기 위하여 호안에 피복석(사석을 보호하기 위해서 그 표면에 쌓는 돌)을 축조한다.","doWork":"피복석의 축조면적, 위치, 경사도를 측정하여 파악한다. 작업방법, 사용할 장비 등을 결정한다. 축조면에 적당한 피복석을 선정한다. 피복석이 적재된 부선을 유도하고 연결된 밧줄을 내륙에 묶어 고정시킨다. 기중기조종원에게 신호하여 피복석을 축조위치로 운반한다. 경사도를 기준으로 피복석 축조위치를 교정해 준다. 피복석과 피복석 간의 맞물림을 정확하게 하기 위해 장비를 이용하여 유도하고 잡석을 옆면이나 뒷면에 채워 넣는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실외","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"수중호안석공","certLic":"석공기능사","dJobECd":"7015","dJobECdNm":"[7015]건축 석공","dJobJCd":"7823","dJobJCdNm":"[7823]건축 석공","dJobICd":"F421","dJobICdNm":"[F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002508:1', '{"dJobCd":"K000002508","dJobCdSeq":"1","dJobNm":"내장목공","workSum":"건축물 내부의 장식, 방음, 실용성 제고를 목적으로 목재를 이용하여 방음설비 및 마루, 칸막이, 천정, 목(木)장식품 등을 제작하고 설치한다.","doWork":"도면을 검토하여 필요한 목재의 종류, 기 제작된 목제품 등을 확인한다. 자, 톱, 대패, 끌 등 전동공구 및 수동공구를 사용하여 합판, 인조벽판, 목재 등을 재단하거나 절단한다. 가공 목재를 못, 맞춤편, 접착제 등을 사용하여 조립한다. 목부재의 외면을 연마기 또는 대패를 사용하여 고르게 다듬는다. 이음매의 빈틈을 제거하기 위하여 초지 등의 재료를 이용하여 틈 사이에 바른다. 내장설비의 실용성과 미관을 고려하여 가공된 목재를 설치할 장소에 접착제, 드릴, 맞춤편, 타정공구 등을 이용하여 설치한다. 표준명세의 규격과 일치하는지 검사한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"내장공, 인테리어목공, 인테리어목공시공원, 인테리어치장목공, 내장목공기능원, 목수","connectJob":"하는 일에 따라 장식목공, 보수목공, 초벌목공","certLic":"건축목공기능사","dJobECd":"7016","dJobECdNm":"[7016]건축 목공","dJobJCd":"7824","dJobJCdNm":"[7824]건축 목공","dJobICd":"F424","dJobICdNm":"[F424]실내건축 및 건축마무리 공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003192:1', '{"dJobCd":"K000003192","dJobCdSeq":"1","dJobNm":"도편수","workSum":"전통한식기법으로 한옥, 누곽, 사원, 사찰, 궁궐 등의 목조구조물과 국가유산을 건립 및 복원하는 작업을 관리하고 한식목공을 관리·감독한다.","doWork":"설계서나 시방서에 따라 목조구조물 및 고정설치물을 만들거나 조립하는 일을 계획한다. 작업원을 배치하고 사용할 목재와 자재들이 건축관계법규(건축법, 국가유산수리표준시방서)와 부합하는지 여부를 검사한다. 조립 또는 세우기에 앞서 각 부재의 조립순서, 사용기구, 조립방법 등 세부계획을 수립하여 담당원에게 승인을 받는다. 목재의 가공, 조립, 설치 등에 대한 기술과 관련 법규 및 시방서의 내용을 대목과 소목에게 숙지시킨다. 목부재 치목을 위해 이음 및 맞춤 현척도를 작도하여 부재에 직접 도해한다. 작업을 지시·조정하고 전체적인 작업공정을 관리한다. 국가유산을 보수·신축할 경우 국가유산관리국 직원과 문제점들을 협의하고 해결방안을 모색한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"대목장, 도목수","connectJob":"돌을 다루면 도석수","certLic":"건축목공기능사, 국가유산수리기능자(대목수)","dJobECd":"7016","dJobECdNm":"[7016]건축 목공","dJobJCd":"7824","dJobJCdNm":"[7824]건축 목공","dJobICd":"F421","dJobICdNm":"[F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002952:1', '{"dJobCd":"K000002952","dJobCdSeq":"1","dJobNm":"드잡이공","workSum":"내려앉거나 기울어진 전통목조건조물이나 석조건조물 등의 뒤틀림, 기울임 또는 파손된 부분을 바로잡고 원형에 맞게 복원한다.","doWork":"현장답사를 통하여 설계도면과 비교하여 정밀하게 살펴 파손되거나 기울어진 정도, 뒤틀림 상태 등을 파악한다. 목재·석재 등의 자재를 구입한다. 설계도면이나 고증자료를 토대로 기울어지거나 뒤틀린 부분은 실측·모사·사진 등으로 기록하고 해체방법 및 보양방법을 서류로 작성하여 담당원의 승인을 받는다. 목조건축물이나 석조건조물을 파손 없이 해체하고 원형대로 조립한다. 신축할 때는 터파기, 초석(주춧돌)놓기, 기둥세우기 등의 순으로 복원한다. 복원된 상태를 담당원의 검사와 시정을 통하여 완료한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"힘든 작업","workPlace":"실외","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"전통건축수리원, 전통건축수리기술자","connectJob":"국가유산수리원, 국가유산수리기술자, 비계공","certLic":"문화재수리기능자(드잡이공)","dJobECd":"7016","dJobECdNm":"[7016]건축 목공","dJobJCd":"7824","dJobJCdNm":"[7824]건축 목공","dJobICd":"F421","dJobICdNm":"[F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007100:1', '{"dJobCd":"K000007100","dJobCdSeq":"1","dJobNm":"라이닝폼조립원","workSum":"돔 또는 반원형 형태로 콘크리트를 타설하기 위한 라이닝폼(이동식거푸집)을 조립한다.","doWork":"H-빔 및 금속자재를 전동절단기를 사용하여 도면대로 절단한다. 레일을 정위치에 놓고 주행빔에 바퀴를 부착한다. 레일 위에 주행빔을 두 개 올려놓는다. 절단된 H-빔과 자재를 용접하여 라이닝 형틀을 짠다. 라이닝 형틀을 장비에 올리고, 라이닝 형틀 위에 챤넬을 가로 방향으로 설치한다. 라이닝 형틀 위에 금속판(Skin Plate)을 씌운다. 작동장치(H·Y·D, Scrow Jack, Turnbuckle)를 설치한다. 금속판에 샌딩을 한 뒤 리바콤 액체(콘크리트 타설 시 금속판의 처리약품)를 도포한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"힘든 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"이동식거푸집조립원, 강재거푸집조립공, 강재거푸집조립원","connectJob":"H빔설치원, 구조강건립원","dJobECd":"7016","dJobECdNm":"[7016]건축 목공","dJobJCd":"7824","dJobJCdNm":"[7824]건축 목공","dJobICd":"F421","dJobICdNm":"[F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003004:1', '{"dJobCd":"K000003004","dJobCdSeq":"1","dJobNm":"목공반장","workSum":"목재구조물 및 고정설치물을 성형·건조·보수하는 작업을 관리하고 목공 및 목공보조원의 활동을 감독·조정한다.","doWork":"설계도면에 따라 작업일정을 계획한다. 필요한 장비 및 공구의 종류와 양을 결정한다. 작업계획을 수립하여 작업내용을 작업원에게 지시·배치한다. 건축용 목재와 목재구조물이 건축관계법규와 부합하는지 여부를 검사한다. 목재를 가공·조립·설치하는 작업원의 업무를 지시·조정하고 작업공정을 관리한다. 표준명세에 따라 지시된 작업이 이루어지는지 작업진행상황을 관리·감독하고 기술적인 지원 및 자재 공급을 한다. 작업원에 대한 직무교육 및 안전위생교육을 실시한다. 수시 관찰과 면담을 통하여 작업원의 애로사항 및 건의사항을 수렴·해결하고 문제점을 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"힘든 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"건축목공반장","certLic":"건축목공기능사, 건축목공산업기사","dJobECd":"7016","dJobECdNm":"[7016]건축 목공","dJobJCd":"7824","dJobJCdNm":"[7824]건축 목공","dJobICd":"F421","dJobICdNm":"[F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002208:1', '{"dJobCd":"K000002208","dJobCdSeq":"1","dJobNm":"목공보조원","workSum":"건축물을 건조하고 실내 목구조물을 제작하기 위하여 목재를 재단·성형·조립하는 목공을 보조한다.","doWork":"작업대를 조립·설치하고 가공기계의 설치와 조작을 보조한다. 선별된 목재를 작업 장소로 옮긴다. 목재를 가공하기 쉽도록 규격별로 분류하고 전기톱이나 수동톱을 이용하여 자른다. 조립된 목제품의 설치 또는 목구조물의 건립을 돕는다. 시공 면을 정리하고, 시공 후 작업장 주변 청소 등 정리·정돈한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"건축목공보조원","certLic":"건축목공기능사","dJobECd":"7016","dJobECdNm":"[7016]건축 목공","dJobJCd":"7824","dJobJCdNm":"[7824]건축 목공","dJobICd":"F421","dJobICdNm":"[F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003495:1', '{"dJobCd":"K000003495","dJobCdSeq":"1","dJobNm":"목조주택건립반장","workSum":"가공된 목부재를 사용하여 주택의 벽, 기둥, 토대, 트러스(Truss:부재(部材)가 휘지 않게 접합점을 핀으로 연결한 골조구조), 지붕 등을 연결·시공하는 작업을 관리하고, 목조주택건립원의 활동을 감독·조정한다.","doWork":"작업지시서에 따라 작업내용과 작업량을 파악하여 작업원을 배치한다. 반입목재의 옹이(목재의 사절(死節) 또는 부절(腐節)이 느슨해져 빠질 듯한 상태로 존재하는 마디 또는 빠져 떨어져 나간 구멍), 비틀림, 방부·방충처리 상태, 규격 등 가공상태를 검사한다. 설계도서에 따라 목제의 가공, 조립·설치하는 업무로써 목조주택건립원을 지도·감독한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"시각|","workEnv":"대기환경미흡|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"목구조목공반장","connectJob":"목조주택 중 통나무집을 건립하면 통나무집건립반장, 통나무집건축반장","certLic":"건축목공기능사","dJobECd":"7016","dJobECdNm":"[7016]건축 목공","dJobJCd":"7824","dJobJCdNm":"[7824]건축 목공","dJobICd":"F411","dJobICdNm":"[F411]건물 건설업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004200:1', '{"dJobCd":"K000004200","dJobCdSeq":"1","dJobNm":"목조주택건립원","workSum":"가공된 규격재를 사용하여 주택의 바닥, 벽, 기둥, 지붕 등의 목구조와 실내외 목재마감을 시공한다.","doWork":"목구조 설계도서를 숙지한다. 시공된 콘크리트 기초 상단의 벽체나 기둥 위치에 앵커볼트를 고정한다. 바닥장선, 벽, 서까래, 기둥, 보 등을 가공하거나 이미 가공된 것을 못이나 연결철물을 사용하여 조립한다. 건물의 열손실과 소음차단을 위해 천장, 외벽, 바닥에 유리섬유(Glass Fiber), 유기섬유(Paper) 등의 단열재를 설치한다. 외부에 노출되는 목재는 목재를 보호하기 위하여 오일스테인 등 외부전용 페인트로 도장한다. 지붕마감은 루핑펠트를 설치한 후 목재 싱글, 아스팔트 싱글 등의 지붕재로 조립·시공한다. 창호 시공이나 지붕 시공 시 누수방지를 위한 후레싱 설치를 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"목구조목공","connectJob":"목조주택 중 통나무집을 건립하면 통나무집건립원, 통나무집건축공","certLic":"건축목공기능사","dJobECd":"7016","dJobECdNm":"[7016]건축 목공","dJobJCd":"7824","dJobJCdNm":"[7824]건축 목공","dJobICd":"F411","dJobICdNm":"[F411]건물 건설업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006610:1', '{"dJobCd":"K000006610","dJobCdSeq":"1","dJobNm":"소목","workSum":"전통한식기법으로 나무를 치목하여 깎고 다듬어서 한옥, 사원, 궁궐 등의 전통창호 또는 가구를 제작한다.","doWork":"설계도서를 숙지하고 소목장의 지시에 따라 작업내용을 숙지한다. 사용할 춘향목, 홍송 등 목재의 건조상태, 비틀림 등을 확인하여 선별한다. 목재의 비틀림을 바로잡고 두께를 일정하게 잡기 위하여 대패질하고 치수에 따라 마름질한다. 문틀의 크기를 고려하여 각 부분품을 먹매김하여 부분별로 제작한다. 제작된 부품을 검사하여 치수가 맞지 않거나 잘못된 부분을 바로잡는다. 부분별로 제작된 부속품을 조립하고 쐐기나 접착제 등을 사용하여 결속한다. 완성된 창호를 건물에 설치한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"소목수","connectJob":"하는 일에 따라 전통창호목수, 전통가구목수","certLic":"국가유산수리기능자(소목수)","dJobECd":"7016","dJobECdNm":"[7016]건축 목공","dJobJCd":"7824","dJobJCdNm":"[7824]건축 목공","dJobICd":"F421","dJobICdNm":"[F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002353:1', '{"dJobCd":"K000002353","dJobCdSeq":"1","dJobNm":"소목장","workSum":"전통한식기법으로 한옥, 사원, 궁궐 등의 전통창호와 가구를 제작하는 작업을 관리하고 소목의 활동을 감독·조정한다.","doWork":"목부재의 종류에 따라 목재를 선정·구입하고 통풍이 잘되는 곳에서 자연상태로 건조시킨다. 설계도와 고증자료를 검토하고 작업내용을 작업원들에게 지시한다. 목재의 보관상태나 함수상태가 적절한지 확인하고 검사한다. 대패질상태나 마름질상태 등을 검사하고 작업원들의 작업진행상황을 관리·감독한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"보통 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"소목반장","connectJob":"하는 일에 따라 전통창호목수반장, 전통가구목수반장","certLic":"국가유산수리기능자(소목수)","dJobECd":"7016","dJobECdNm":"[7016]건축 목공","dJobJCd":"7824","dJobJCdNm":"[7824]건축 목공","dJobICd":"F421","dJobICdNm":"[F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005512:1', '{"dJobCd":"K000005512","dJobCdSeq":"1","dJobNm":"수동대패원","workSum":"수동대패를 사용하여 목재의 표면을 매끄럽게 깎는다.","doWork":"목재표면에 못 또는 다른 이물질의 존재 여부를 검사한다. 작업물에 따라 막대패, 중간대패, 다듬질대패를 선정한다. 대패 집을 손으로 잡고 대패 날과 덧날을 망치로 두드려서 날 길이를 조정한다. 초벌대패로 목재의 거친 부분을 깎아낸다. 깎아낸 목재의 치수를 확인하면서 끝손질 대패를 사용하여 완성규격으로 깎아낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"전동대패기조작원","certLic":"목재가공기능사, 목공예기능사","dJobECd":"7016","dJobECdNm":"[7016]건축 목공","dJobJCd":"7824","dJobJCdNm":"[7824]건축 목공","dJobICd":"C162","dJobICdNm":"[C162]나무제품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006767:1', '{"dJobCd":"K000006767","dJobCdSeq":"1","dJobNm":"요소맞춤원","workSum":"목제품의 모서리를 맞추기 위하여 각종 끌이나 톱으로 모서리 결합부위를 만든다.","doWork":"맞춤의 종류에 따라 목재 모서리에 금을 긋고, 제거할 부분을 톱으로 자른다. 각끌이나 끌로 맞춤 형태에 적당한 구멍, 홈, 요철 등의 모양으로 파낸다. 결합부위를 맞추어 보면서 끌로 다듬는다. 접착 면에 접착제를 바르고 접착부위를 잘 맞추어 조임쇠나 조임목으로 고정한다. 접착제가 완전히 마르면 조임쇠를 풀고 맞춤부위를 다듬는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"목재가공기능사","dJobECd":"7016","dJobECdNm":"[7016]건축 목공","dJobJCd":"7824","dJobJCdNm":"[7824]건축 목공","dJobICd":"C162","dJobICdNm":"[C162]나무제품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005191:1', '{"dJobCd":"K000005191","dJobCdSeq":"1","dJobNm":"창호목공","workSum":"목재를 가공·성형하여 창틀·창문·문 등을 조립하여 건축물에 설치한다.","doWork":"제작도면을 읽고 알맞은 재료를 골라 마름질한다. 톱, 대패, 끌, 송곳 등을 이용하여 재료를 절단·성형한다. 가공된 재료를 못, 접착재, 맞춤편 등으로 조립한다. 건축물의 창틀에 맞추어 고정시킨다. 문짝·창문에 설치된 창호 제품이 바르게 고정되었는지를 검사하고 장식부품을 부착한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"창호공, 나무창호목공, 창호목공기능원","certLic":"건축목공기능사","dJobECd":"7016","dJobECdNm":"[7016]건축 목공","dJobJCd":"7824","dJobJCdNm":"[7824]건축 목공","dJobICd":"F421","dJobICdNm":"[F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001335:1', '{"dJobCd":"K000001335","dJobCdSeq":"1","dJobNm":"콘크리트거푸집제작원","workSum":"콘크리트제품을 제조하기 위하여 거푸집(Mold:형틀, 몰드)을 조립한다.","doWork":"콘크리트 거푸집(Mold:형틀, 몰드)의 내부, 구석, 접합 면을 청소한다. 거푸집을 탈형할 때 거푸집과 제품이 결착되는 것을 방지하기 위하여 탈형유를 몰드 내부에 바른다. 제작할 콘크리트제품에 따라 철골조, 조립철망 등을 투입한다. 거푸집을 조립하고 볼트, 너트를 결속한다. 탈형작업을 쉽게 하기 위하여 볼트, 너트에 탈형유를 바른다. 임팩트렌치(Impact Wrench:마찰 접합용 고장력 볼트를 체결하는 공구)로 캐스팅(Casting:주물)을 조여 조립을 완성한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"철근콘크리트형틀제작원, 철근콘크리트거푸집제작공, 콘크리트철거푸집제작원, 콘크리트철거푸집제작공","dJobECd":"7016","dJobECdNm":"[7016]건축 목공","dJobJCd":"7824","dJobJCdNm":"[7824]건축 목공","dJobICd":"F412","dJobICdNm":"[F412]토목 건설업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005467:1', '{"dJobCd":"K000005467","dJobCdSeq":"1","dJobNm":"한식목공","workSum":"전통한식기법으로 한옥, 성곽의 누곽, 사원, 사찰, 궁궐 등의 전통 목조구조물과 문화재의 건립 및 복원을 위하여 나무를 치목하여 깎고 다듬어서 설치한다.","doWork":"설계도서나 도편수의 지시에 따라 작업내용을 숙지한다. 각종 대패, 톱, 끌 및 자귀 등의 도구를 사용하여 제재(나무를 켜서 재목을 만듦), 치목(재목을 다듬음), 바심질(목재를 깎고 파서 다듬는 일)하여 목적에 맞게 목재를 가공한다. 기초와 기둥, 기둥과 보, 기둥이음, 도리(기둥과 기둥 위에서 서까래를 얹으려고 돌려 얹히는 나무)의 이음, 도리의 맞춤, 귀틀(마루를 놓을 때 먼저 굵은 나무로 가로나 세로로 짜 놓는 틀)의 맞춤, 귀틀과 볼(마루널)의 맞춤, 하인방(기둥과 기둥 또는 벽체의 아래쪽에 뼈대가 되는 가로재)과 기둥맞춤, 중방(기둥과 기둥 또는 벽체의 중간에 뼈대가 되는 가로재)과 기둥맞춤, 문설주(문짝을 끼워 달기 위하여 중방과 문지방 사이 문의 양편에 세운 기둥)와 문인방(벽을 치거나 문골을 내기 위하여 기둥궁 사이에 가로 건너는 재)맞춤, 기둥과 인방·장여(도리를 받치고 있는 길고 모진 나무)맞춤, 왕대공(용마루 보를 받치는 기둥) 등의 순으로 가공한 목재의 부속들을 조립한다. 조립된 상태를 점검·보완하고 기타 일들을 처리한다. 작업상 문제점이 발생하면 도편수에게 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"건축목공, 대목, 대목수, 소목수","certLic":"문화재수리기능자(대목수), 문화재수리기능자(소목수)","dJobECd":"7016","dJobECdNm":"[7016]건축 목공","dJobJCd":"7824","dJobJCdNm":"[7824]건축 목공","dJobICd":"F421","dJobICdNm":"[F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;