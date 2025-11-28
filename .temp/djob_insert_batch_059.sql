INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005979:1', '{"dJobCd":"K000005979","dJobCdSeq":"1","dJobNm":"음향기기조립현장감독자","workSum":"음향기기를 조립하는 데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"생산계획을 기준으로 작업원의 기술수준에 따라 작업할당을 계획한다. 모델변경에 따른 제품명세서·작업지시서·기술지침서 등을 검토하고 조립원들이 볼 수 있도록 조립라인에 부착한다. 부품의 필요량과 공급량을 파악하고 준비한다. 생산라인에서 필요한 장비나 검사장비 등의 이상 유무를 파악하고 관리한다. 제품의 불량원인을 분석하고 자체 품질기준에 따른 제품을 검사하기도 한다. 조립진행상황을 파악·점검하고 조립원의 의견을 수렴하며 문제점을 개선한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"수동조작","similarNm":"오디오조립반장, 음향기기조립반장","connectJob":"만드는 제품에 따라 카세트조립반장, CDP조립반장, DVD조립반장, 홈시어터조립반장, MP3조립반장","certLic":"전자기능사","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C265","dJobICdNm":"[C265]영상 및 음향기기 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002062:1', '{"dJobCd":"K000002062","dJobCdSeq":"1","dJobNm":"음향기기조정원","workSum":"음향기기제조 공정 중 조립되어 완성된 제품의 인쇄회로기판(PCB)을 성능에 필요한 명세서 내용에 따라 출력전압 및 주파수 등을 조정한다.","doWork":"조립이 완성된 인쇄회로기판(PCB:Printed Circuit Board)의 출력상태를 각종 계측기기를 사용하여 파형을 관찰하여 동작상태와 각종 기능을 확인한다. 계측기기에 측정된 출력값이 설계된 값과 차이가 있을 경우 전압·주파수 등을 규격과 균형을 맞추어 조정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"오디오조정원","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C265","dJobICdNm":"[C265]영상 및 음향기기 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005080:1', '{"dJobCd":"K000005080","dJobCdSeq":"1","dJobNm":"의료기기제조현장감독자","workSum":"의료기기를 제작·조립·검사하는 데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"의료기기 제조공정, 의료기기 부품, 의료기기 성능 및 기능 등의 의료기기 전반에 관한 지식과 내용을 숙지한다. 생산량, 제조품목, 시간계획 등을 수립하여 할당된 작업량에 따라 작업계획을 세우고 부품과 작업지그 등을 준비한다. 작업계획에 따라 작업원들을 수행직무별로 훈련시키고 작업공구 및 작업원들을 선정·배치한다. 부서 간의 원활한 작업흐름을 조정하기 위해 다른 작업반장 등과 협의한다. 조립라인의 설치 및 개·보수와 관련하여 계획을 수립·실시한다. 각 생산공정을 관리·감독하며 때에 따라 기술지도를 병행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","similarNm":"의료용구제조반장, 전자의료장비제조반장, 플라스틱의료용품제조반장, 의료기구제조반장, 의료장비제조반장, 의료기기제조반장","connectJob":"감독하는 공정에 따라 의료기기조립반장, 의료기기검사반장, 의료기기수리반장","certLic":"전자기기산업기사","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C271","dJobICdNm":"[C271]의료용 기기 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005320:1', '{"dJobCd":"K000005320","dJobCdSeq":"1","dJobNm":"의료기기조립원","workSum":"X-ray, 초음파진단기기, PET-CT, MRI장비 등의 전자·전기의료기기를 구성하는 부분품과 부속품들을 드라이버, 동력공구, 납땜기 등으로 조립․검사를 한다.","doWork":"제품시방서 혹은 제품도면을 숙지하고 작업명세서에 따라 조립할 전자의료기기의 종류와 수량, 규격 등을 확인한다. 조립에 필요한 각 부품의 수량을 확인하고 단위별 자체 제작부품 또는 외주 가공된 조립품 등을 수령한다. 드라이버, 동력공구, 납땜기, 계측기기 등의 공구 및 장비를 준비한다. 제품시방서에 따라 드라이버 및 동력공구로 구성단위별 부품들을 조립한다. 제품 도면을 보고 각종 공구를 사용하여 전기장치의 배선작업을 한다. 기계구성부품은 용접 및 동력공구를 사용하여 조립작업을 한다. 부분별로 조립한 이후에는 각종 계측기기를 사용하여 오배선, 전선의 단락, 전기적 저항이나 전원전압 등의 관련 장치가 원활히 작동하는지 검사한다. 결함 발생 시 자체 수리 가능한 경우 수리를 하며 부속부품의 문제인 경우 부품을 재수령하여 조립한다. 제조 기록을 작성한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"의료장비조립원","connectJob":"X-ray기기조립원, 초음파영상진단기기조립원","certLic":"전기기능사, 전기기기산업기사, 전자산업기사, 전자기능사","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C271","dJobICdNm":"[C271]의료용 기기 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004319:1', '{"dJobCd":"K000004319","dJobCdSeq":"1","dJobNm":"이동통신단말기구조립원","workSum":"이동통신 단말 기구를 조립한다.","doWork":"작업지시서에 따라 조립할 단말기 기구의 부품 및 작업도구(컨베이어벨트, 전동드라이버, 핀셋, 정전기 방지 장갑 및 매트 등)를 확인한다. 기구물의 외관 및 치수를 검사한다. 조립순서에 따라 조립한다. 조립 후 들뜸이나 유동성을 시험한다. 부품의 공차나 삽입 공간의 공차를 확인한다. 조립된 단말기 기구를 적재하여 다음 공정으로 이동한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"무선통신단말기조립원","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C264","dJobICdNm":"[C264]통신 및 방송 장비 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001558:1', '{"dJobCd":"K000001558","dJobCdSeq":"1","dJobNm":"인쇄회로기판기능검사원","workSum":"영상기기, 음향기기, 사무기기 등 각종 전자제품에 장착되는 전자부품이 조립된 인쇄회로기판을 기능검사장비를 이용하여 검사·측정·시험한다.","doWork":"기판기능검사장비에 검사프로그램을 로드(Load)한다. 검사절차서를 보고 검사요량을 숙지한다. 검사에 필요한 장비 및 지그를 설치한다. 불량표를 작업대에 준비하고 불량기판을 담을 지그를 작업대에 준비한다. 검사할 기판의 안내홀(Guide Hole)을 고정구 안내판에 맞추어 올려놓는다. 비디오·프린터·플로피디스크·키보드·스피커 등을 접속하고 전원을 켜고 키를 눌러 검사절차에 따라 프로그램을 이용하여 모니터를 주시하며 검사를 진행한다. 검사내용을 프린트로 인쇄하여 기록하고 기판수량을 파악하여 수리 부서에 불량품을 수리·의뢰한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"유지","similarNm":"기판측정원, 보드검사원(자동), 자삽검사원(자동), PCB검사원(자동)","certLic":"전자기기기능사","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002007:1', '{"dJobCd":"K000002007","dJobCdSeq":"1","dJobNm":"자석스위치조립원","workSum":"시동모터를 작동시켜 주는 마그네트스위치의 몰드캡 부품과 코일뭉치 등 부품을 케이스(몸체)에 삽입시켜 조립한다.","doWork":"보빈에 감긴 코일뭉치에 코어스위치를 삽입시키고 코일리드를 코어스위치에 스폿용접기로 연결·용접한다. 부싱 및 도체(Conductor)조립부품을 일정 크기의 케이스에 삽입시키고 도체부품을 코어스위치 중심부에 끼워준다. 접지 및 방수 목적으로 코어스위치에 고무패킹을 끼우고 귀선스프링의 도체스토퍼 위에 올려놓는다. 단자볼트로 결합된 몰드캡 부품을 귀선(Return)스프링 위에 올려놓고 리드가 아일릿(Eyelet)구멍으로 나오게 한다. 조립된 마그네트스위치를 검사기구 위에 올려놓고 접점 갭 검사 및 접촉 스프링의 강도를 시험한다. 납땜인두를 사용하여 코일리드와 단자를 연결·땜질한다. 오실로스코프 등의 검사기구를 사용하여 마그네트스위치의 접지·단락·코일저항상태를 검사하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"도체조립원, 캡조정원","certLic":"전기기능사","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C289","dJobICdNm":"[C289]기타 전기장비 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005447:1', '{"dJobCd":"K000005447","dJobCdSeq":"1","dJobNm":"재제조잉크카트리지조립원","workSum":"폐잉크카트리지를 분해하여 세척한 후 잉크를 주입하고 매쉬, 스펀지, 바디, 캡 등의 부품을 이용하여 재생잉크카트리지를 조립한다.","doWork":"분리기계를 이용하여 바디와 캡을 분리한 후 세척기를 이용하여 매쉬(Mash)를 깨끗하게 세척한다. 모든 세척이 끝나면 새로운 잉크 스펀지를 카트리지 안에 삽입하고 매쉬융착기로 매쉬를 융착한다. 초음파 융착기를 이용해 뚜껑을 융착하고 융착 여부를 육안으로 확인한 후 진공충전기를 이용하여 카트리지에 잉크를 흡입 충전한다. 충전이 끝난 후 카트리지 모델에 맞는 프린터에 넣고 인쇄가 잘 되는지 테스트한다. 색상, 회상도, 줄 이음 부분 등 모든 테스트에 합격되면 노즐부분에 보호 테이프를 붙인 후 포장한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","similarNm":"재생잉크카트리지조립원","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C204","dJobICdNm":"[C204]기타 화학제품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006051:1', '{"dJobCd":"K000006051","dJobCdSeq":"1","dJobNm":"재제조토너카트리지조립원","workSum":"드럼테스트를 거친 폐토너카트리지의 토너유닛(Toner Unit)과 드럼유닛(Drum Unit)을 분해한 후 토너파우더를 주입하고 호퍼(Hopper) 블레이드(Blade), 매그롤러(Mag Roller), 피시아르(PCR) 등 부품을 이용하여 재생토너카트리지를 조립한다.","doWork":"폐카트리지의 캡을 분리하기 위해 양쪽 끝에 붙어있는 볼트를 풀어 토너유닛과 드럼유닛으로 나눈다. 드럼유닛에서 드럼, 피시아르(PCR)롤러, 마그네틱롤러, 드럼을 분리하여 새로운 부품으로 교체할 준비를 한다. 토너유닛에서 닥터블레이드, 리커버리블레이드, 서스블레이드, 클립 등을 분해한 후 호퍼, 폐통 등이 붙어있는 토너유닛을 집진실로 가져간다. 집진기로 폐통에 남아있는 토너 찌꺼기와 토너유닛 부품 사이에 있는 토너파우더를 집진한다. 토너유닛에서 분해된 피시아르롤러를 새것으로 교체하고 끝이 마모된 닥터블레이드를 패딩파우더 처리한다. 마그네틱롤러-피시아르롤러-닥터블레이드 순으로 조립한 후 새로운 토너파우더를 충진하고 최종적으로 드럼을 장착하여 조립을 완료한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","similarNm":"재생토너카트리지조립원","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C204","dJobICdNm":"[C204]기타 화학제품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001916:1', '{"dJobCd":"K000001916","dJobCdSeq":"1","dJobNm":"저울조립원","workSum":"저울의 전기부문인 제어 판넬을 제작하고 각종 부품을 조립하여 계량부의 정밀도를 조정한다.","doWork":"작업공정도를 숙지하고 각 사양을 체크한다. 각 섹터에 맞는 공구를 준비한다. 전동드라이버를 이용해 로드셀(Load Cell)을 조립한 후 전동드라이버와 에어임팩트를 이용해 플랫폼을 조립한다. 분동과 줄을 이용해 사귀가동을 하고 표준분동으로 저울세팅 및 저울품질을 검사한다. 완성된 검사합격 제품을 포장 레일에 올리고 포장 자재확보 및 확인 후 포장을 하여 펠릿에 적재한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C291","dJobICdNm":"[C291]일반 목적용 기계 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007230:1', '{"dJobCd":"K000007230","dJobCdSeq":"1","dJobNm":"적산전력계조립원","workSum":"일정 기간 동안 사용한 전력의 총량을 측정하는 적산전력계를 조립한다.","doWork":"작업명세서에 따라 조립할 부분품을 확인하고 점검한다. 수동공구를 사용하여 소자·자석·레지스터(Register) 등의 부품을 조립한 후 납땜공구를 사용하여 전압·전류 리드선을 배선한다. 유리커버 등 외장부품을 조립하고 봉인나사 압착지그를 사용하여 완제품에 납봉인을 한다. 착감자장치를 사용하여 자력을 부여한다. 알루미늄으로 만든 원판과 원판축을 금형에 넣고 용융된 납을 금형에 넣어 원판과 원판축을 접합한다. 적산전력계의 원판의 평탄도와 직각도를 수정하기 위해 원판투영기 안으로 원판을 투사시켜 상태를 확인하고 손으로 눌러 원판을 수정하고 페인트를 칠한다. 프레스를 사용하여 전압·전류소자로 사용되는 소형전자석을 조립한다. 숫자를 나타내는 계량장치의 문자차에 전사롤러를 사용하여 문자를 인쇄·검사하며 문자차·송차·기어 등을 조립하여 계량장치를 제조하고 규격에 일치하는지 검사한다. 완성품은 시험검사공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"전기계량기조립원, 전력량계조립원","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C281","dJobICdNm":"[C281]전동기, 발전기 및 전기 변환ㆍ 공급ㆍ제어 장치 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001374:1', '{"dJobCd":"K000001374","dJobCdSeq":"1","dJobNm":"전구부속품조립원","workSum":"전등소켓·스위치·단자판·플러그 장치 등과 같은 전기장비의 기계부품을 조립한다.","doWork":"작업지시서나 도면의 내용을 이해하고 작업하고자 하는 도구와 부품을 준비한다. 고정구·나사돌리개를 사용하여 소켓·베이스·축·접촉점·스프링 등의 부품을 지정된 순서대로 설치한다. 결함이 있는 부품과 잘못된 작업을 탐지하기 위해 가동부품의 동작을 시험하고 작동 소리를 듣는다. 그림도면을 보면서 작업의 진행을 체크하고 완성된 조립품을 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"형광등코팅기조작원, 유리관도포원","connectJob":"단자판조립원, 텀블러스위치조립원, 푸시버튼스위치조립원, 풀소켓조립원, 플러그조립원","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C284","dJobICdNm":"[C284]전구 및 조명장치 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001862:1', '{"dJobCd":"K000001862","dJobCdSeq":"1","dJobNm":"전기장비제조현장감독자","workSum":"전동기, 변압기, 전원공급 및 제어장치 등을 조립 및 검사하거나 가공장비를 조작하는 작업원의 활동을 감독·조정한다.","doWork":"주문서에 따라 작업지시서를 만든다. 납기일에 따라 일일생산량계획을 수립한다. 작업에 필요한 각종 공구와 기계 등을 점검하고 확인한다. 작업공정방법과 순서를 정하여, 작업원을 배치하고 작업원들에게 지시한다. 각 공정별 작업실적을 체크한다. 작업공정을 순회하고 공정별 기술적인 지도를 한다. 완성된 제품의 규격이 작업명세서와 일치하는지를 확인하고 검사한다. 불량조립품에 대해서는 재조립 및 수정을 지시한다. 작업장의 안전과 작업원의 위생 등을 관리한다. 완성된 제품은 시험, 검사공정으로 이송시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","similarNm":"전기장비제조반장","connectJob":"전동기제조반장, 발전기제조반장, 변압기제조반장, 전원공급장치제조반장, 가공반장, 조립반장, 검사반장, 정비반장, 권선반장, 철심제조반장","certLic":"전기산업기사, 전기기기산업기사","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C281","dJobICdNm":"[C281]전동기, 발전기 및 전기 변환ㆍ 공급ㆍ제어 장치 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002812:1', '{"dJobCd":"K000002812","dJobCdSeq":"1","dJobNm":"전자교환기시험원","workSum":"전자교환기측정방법 및 시험업무에 관한 지식을 이용하여 교환기 내의 개별 회로기판이나 완제품을 시험한다.","doWork":"각종 시험장비와 계측기기를 사용하여 일반동작 및 성능, 온도상승, 정전기 등 일반시험을 실시한다. 적응환경에 따른 고온동작, 저온동작, 보존정도 등 환경시험을 한다. 계측기기를 사용하여 소비전력을 측정하고 내압·절연·저항을 점검·시험한다. 외관구조, 조정성확인, 퓨즈단락, 진동, 낙하 등의 정밀분석시험을 실시한다. 시험자료를 정리·계산하고 품질평가회의를 주관한다. 견본제품의 이력을 관리하고 구매자의 요구사항 및 하자사항을 처리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"전자산업기사, 통신선로기능사","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C264","dJobICdNm":"[C264]통신 및 방송 장비 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004836:1', '{"dJobCd":"K000004836","dJobCdSeq":"1","dJobNm":"전자교환기조립원","workSum":"교환기를 생산하기 위하여 생산라인에서 반조립품 및 완제품을 조립한다.","doWork":"유닛(Unit)에 각종 반도체 및 전자부품을 조립한다. 전자부품이 조립된 보드를 회로도면을 보면서 교환기 내에서 각 기능을 수행하는 셀프(Self) 단위로 조립한다. 셀프(Self) 단위로 조립할 때 교환기로서의 기능이 제대로 동작하는지 각종 계측기기를 이용하여 확인한다. 셀프(Self) 단위로 조립된 것을 가입자의 수에 따라 필요한 수량을 조립하여 완제품을 만든다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C264","dJobICdNm":"[C264]통신 및 방송 장비 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005582:1', '{"dJobCd":"K000005582","dJobCdSeq":"1","dJobNm":"전자기판검사기운영원","workSum":"각종 전자부품이 조립된 인쇄회로기판을 검사하는 설비의 검사프로그램 및 고정구를 제작하고, 장비의 효율적 운용과 유지·개선·보수·관리 업무를 한다.","doWork":"새로이 개발된 모델의 회로 및 필름을 준비하고 부품의 배열·부품수 등 정보를 분석하여 회로를 분석한다. 회로를 데이터(Data)화하여 시스템에 입력한다. 입력된 데이터로 시스템을 이용하여 테스트 프로그램 생성과정에서 발생된 파일(File)을 이용하여 고정구를 제작한다. 완성된 검사프로그램과 고정구를 설치하고 기판을 올려놓고 오류를 수정한다. 검사범위를 산출하여 목록을 작성한다. 오류수정이 끝난 프로그램과 고정구를 검사자에게 넘긴다. 검사 중 문제가 발생하면 기술적인 지원을 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"전자계산기기능사, 전자기능사","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006436:1', '{"dJobCd":"K000006436","dJobCdSeq":"1","dJobNm":"전자램프제조원","workSum":"전자램프를 제조하기 위하여 다음 직무의 일부를 수행한다.","doWork":"리드 프레임(lead frame)에 칩(chip)을 붙이기 위해 현미경을 사용하여 압력기(dispenser)와 주사기로 수은에폭시를 찍어준다. 현미경을 보며 핀셋으로 칩을 집어 올려 수은에폭시 위에 눌러 붙인다. 접착된 칩과 리드프레임 사이를 선으로 연결한다. 현미경으로 보며 칩이 떨어지거나 선이 끊어져 있는지 검사한다. 에폭시를 혼합하여 성형기계에 주입하고 형틀에 제품별로 삽입한다. 압력기를 사용하여 에폭시를 주입한 후 선이 접착된 반제품을 형틀 윗판에 끼우고 형틀 밑판과 결합한 후 일정 온도의 오븐 속에서 일정 시간 동안 경화시킨다. 성형된 제품을 절단기계를 사용하여 일정한 모양으로 절단한다. 절단된 제품을 검사지그에 꽂아 기포량의 정도, 이물질, 중심에서 벗어난 정도, 색상, 굴곡, 발광출력, 역전류, 순전압 등 외관검사와 특성검사를 한다. 완성된 제품을 일정수량으로 세어서 제품명세서와 함께 비닐봉지로 포장한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006529:1', '{"dJobCd":"K000006529","dJobCdSeq":"1","dJobNm":"전자램프제조현장감독자","workSum":"전자램프를 제조하기 위해 접착하고 선을 연결하고 검사하는 작업원의 활동을 감독·조정한다.","doWork":"작업내용에 따라 작업원에게 지시·배치한다. 작업의 진행상황을 파악하고 작업내용을 보고한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원 및 자재를 공급한다. 작업계획에 따라 세부실행항목을 수립하고 작업절차 및 방법을 결정하여 작업원에게 작업내용을 지시하고 작업배치를 한다. 표준작업명세에 따라 지시된 작업이 이루어지는지 작업원과 함께 작업하며 작업상황을 관찰하고 작업내용을 점검한다. 작업원의 직무교육 및 안전위생 교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴·해결하고 문제점을 보완한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"수동조작","similarNm":"전자램프제조반장","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002108:1', '{"dJobCd":"K000002108","dJobCdSeq":"1","dJobNm":"전자부품검사원","workSum":"견본품·전자조립품·반조립품·부품 등을 검사한다.","doWork":"절단된 전선, 과잉 납땜, 봉합제의 구멍, 균일하게 감기지 않은 코일, 피복 및 도금의 흠집, 기름누출, 잘못된 저항용접, 긁힌 자국, 갈라진 틈 등 결함 여부에 대해 육안으로 부품을 검사한다. 조립된 회로기판의 배선과 구성부품을 견본판과 비교하고 명세서와의 일치 여부를 확인한다. 설비를 확인하기 위하여 조립품·부속조립품·부분품에 필요한 아일릿(Eyelet)·브래킷·돌출부 등의 하드웨어를 부품 목록표와 비교한다. 도선구역에 지정대로 접촉이 되었나 하드웨어를 검사한다. 잘못된 조립부품·구성요소를 불합격시킨다. 기록통계를 위하여 결함의 종류와 양을 기록한다. 치수의 정확도를 확인하기 위하여 표준계기로 부품을 측정하기도 한다. 영상의 정밀도와 크기를 확인하거나 결함을 찾아내기 위하여 쌍안경식 현미경 또는 확대경을 사용하기도 한다. 다시 이용하거나 폐기처분하기 위하여 결함이 있는 성분과 부품을 분류하기도 한다. 표준시험기 또는 계기를 사용하여 인쇄회로기판의 연속성을 시험하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003833:1', '{"dJobCd":"K000003833","dJobCdSeq":"1","dJobNm":"전자부품수삽원","workSum":"전자회로기판을 제조하기 위해 집적회로·트랜지스터·고주파코일·저항·콘덴서 등 전자부품을 인쇄회로기판에 삽입한다.","doWork":"부품의 리드를 수동공구와 손으로 구부리거나 리드가 구부러진 부품을 준비한다. 설계·가공된 회로기판을 작업대 지그나 레일 위에 올려 고정한다. 핀셋·집게 등을 사용하여 회로도에 맞게 전자부품의 리드를 기판의 구멍에 끼운다. 기판이면(동박면)으로 인출된 리드를 배열하고 부품의 높이를 정렬한다. 수삽공정 이전에 자동으로 작업된 전자부품의 이상 유무를 검사하거나 수삽된 부품을 도면과 비교하여 오극성, 오삽입, 미삽입 등 이상 유무를 육안검사한다. 자동납땜기에 투입하기 위해 인쇄회로기판에 납이 묻지 말아야 할 부분을 테이프로 보강하거나 용량이 큰 전자부품을 손으로 끼우고 납땜기구로 땜질하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"시각|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"PCB조립원, 전자회로기판조립원, 전자부품수동삽입원","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002357:1', '{"dJobCd":"K000002357","dJobCdSeq":"1","dJobNm":"전자총조립반장","workSum":"브라운관 전자총을 조립하는데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"생산계획에 따라 작업원을 적정하게 배치한다. 히터·캐소드(cathode)·그리드(grid) 등의 생산현황을 파악하고 원부자재의 공급량을 결정한다. 기계설비의 가동상태를 점검한다. 각종 그래프·관리도를 확인·점검하며 작업원들에게 안전교육을 실시한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"마운트조립반장","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2011"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003806:1', '{"dJobCd":"K000003806","dJobCdSeq":"1","dJobNm":"전자총조립원","workSum":"전자총의 구성요소인 가열체(heater)와 제어그리드, 음극(cathode) 등을 조립하여 전자총을 만든다.","doWork":"작업지시서를 읽거나 구두지시를 받아 도면과 견본조립품을 검토한다. 가열체를 만들기 위해 자동권선기를사용하여 그리드(grid), 코어(core)와 축 주위를 와이어로 감는다. 가열체를 성형하기 위해 손 및 동력공구를 사용하여 감긴 그리드 코어를 펼치고 누르며 일정크기로 절단한다. 특수자동기계를 사용하여 그리드 등의 부품을 성형한다. 그리드·가열체 등의 부품을 고정구 안에 놓고 점용접기·납땜오븐 등 다양한 용접 및 납땜장비를 이용하여 서로 접합시킨다. 지정된 관의 베이스와 상부뚜껑을 접착제로 채우고 유리진공관과 금속쉘(shell)을 부착시킨다. 불순물을 제거하기 위해 자동장비 안에 조립된 진공관을 놓고 진공상태를 만들어 관을 봉한다. 관 전극의 정전 차폐효과를 위해 지정된 관에 탄소도장을 한다. 부품과 조립품을 검사하는 작업을 수행하기도 하며 완성된 진공관의 전기특성을 안정화시키기 위해 자동전기 수리장비를 다루기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"마운트조립원","connectJob":"전자총세정원, 전자총제진원, 캐쇼드용접원, 히터용접원","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2011"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004978:1', '{"dJobCd":"K000004978","dJobCdSeq":"1","dJobNm":"전자코일조립원","workSum":"수평·수직 권선, 코일조립, 화면검사 등의 공정을 거쳐 IFT(Intermediate Frequency Transformer)코일, 인덕터코일(Inductor Coil), 트로이덜코일(Troidal Coil) 등의 전자코일 및 트랜스포머를 조립한다.","doWork":"작업표준에 따라 코일 및 조립할 부분품과 재료를 확인한다. 작업공구를 준비하고 점검한다. 작업명세에 따라 규격코일을 선정하여 권선기에 건다. 권선(Winding)공정에 따라 수평권선기를 사용하여 전선(Wire)을 감은 후 수직권선기로 전선(Wire)을 감는다. 수평 및 수직코일의 배선상태를 정리하며 커넥터를 조립하고 전선 끝의 피막을 제거한다. 자성체를 이용하여 브라운관 화면상의 흩어짐, 일그러짐 등을 검사한다. 문제가 있는 부분의 코일상태를 조정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"편향코일조립원","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C281","dJobICdNm":"[C281]전동기, 발전기 및 전기 변환ㆍ 공급ㆍ제어 장치 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005155:1', '{"dJobCd":"K000005155","dJobCdSeq":"1","dJobNm":"전해콘덴서조립원","workSum":"전해콘덴서를 제조하기 위해 함침된 소자에 고무전을 끼우고 알루미늄케이스를 씌우고 밀폐 후 용량·전압·극성이 표시된 슬리브(Sleeve)를 씌우는 기계를 조작한다.","doWork":"공정카드의 로트번호·알루미늄박 라벨 등을 보고 작업지시 내용을 확인한다. 각종 도구를 사용하여 침적깊이를 확인하고 자동조립기계를 점검한다. 사용될 부품을 각각 자동공급장치에 넣는다. 콘덴서제조 장비를 작동시키고 작동되는 기계를 관찰하며 극성 체크부위의 작동상태, 불량 여부, 슬리브상태를 확인하며 수축온도를 측정하고 부품자동공급장치의 공급량을 조정한다. 작업일지를 작성한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|고온|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006886:1', '{"dJobCd":"K000006886","dJobCdSeq":"1","dJobNm":"점화전조립원","workSum":"점화전(Spark Plug)을 만들기 위하여 전극(Electrode)부분, 절연체(Insulator)부분, 쉘(Shell)구성 부품을 조립한다.","doWork":"작업명세에 따라 조립할 점화플러그의 종류를 구분하고 작업도구 및 장비를 준비한다. 작업표준에 따라 전극(Electrode)부분, 절연체(Insulator)부분, 쉘(Shell)부분의 공정 순서로 조립작업을 한다. 조립된 플러그의 종류에 따라서 베이스와 모형을 선택한다. 니켈 합금, 내열 합금, 백금 합금 등으로 만든 중심 전극의 끝을 접착제에 담그고 자기절연재 안에 삽입한다. 이때 중심전극과 접지전극의 간극을 0.5∼1.5㎜로서 유지한다. 전선을 연결하고 조립품을 탄소강으로 만든 쉘 안에 삽입한다. 기계를 사용하여 절연제 둘레에 금속베이스가 맞도록 고정시킨다. 완성품은 시험검사공정으로 보낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C281","dJobICdNm":"[C281]전동기, 발전기 및 전기 변환ㆍ 공급ㆍ제어 장치 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002008:1', '{"dJobCd":"K000002008","dJobCdSeq":"1","dJobNm":"점화코일조립원","workSum":"자동차 엔진 시동용 점화코일인 개자로형 점화코일 및 폐자로형 점화코일을 제조하기 위하여 점화코일뭉치·코일받침대·적층판·혼합물브래킷·외부저항부품 등을 조립한다.","doWork":"작업명세서에 따라 조립할 부분제품을 확인한다. 부분품 및 용도에 따라 조립방법 및 절차를 결정한다. 작업에 필요한 공구를 준비하고 점검한다. 점화코일뭉치·코어받침대·코어철심·절연재가 삽입된 점화코일을 코일로부터의 방열을 좋게 하기 위하여 단면적을 크게 한 브래킷에 고정시킨다. 코일캡과 코어가 접촉되도록 코일스프링을 코어 상부판에 놓는다. 점화코일뭉치에 적층판을 끼워서 애자베이스에 놓고 케이스 중심에 오도록 삽입한다. 용해된 혼합물을 주입기를 통해 케이스에 일정량 넣어 경화시킨다. 코일과 케이스 사이에는 절연하기 위하여 피치콤파운드(Compound:수지·납·고무 등을 배합하여 만든 일종의 절연 재료)를 넣거나 또는 냉각효과를 높이기 위하여 절연유를 넣는다. 세라믹으로 제조한 애자·저항선·리드 등 외부저항 부품을 브래킷에 고정시킨다. 접속단자가 연결된 리드를 코일캡 일차단자에 끼워 결선한다. 완성된 제품은 시험검사공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C281","dJobICdNm":"[C281]전동기, 발전기 및 전기 변환ㆍ 공급ㆍ제어 장치 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005253:1', '{"dJobCd":"K000005253","dJobCdSeq":"1","dJobNm":"정류자조립원","workSum":"금속가공기구와 측정공구를 사용하여 전동기·발전기 등에 필요한 정류자를 제조한다.","doWork":"작업명세서에 따라 조립할 부분품을 확인한다. 부분품 및 용도에 따라 조립방법 및 절차를 결정한다. 다이얼게이지 및 수동망치 등 작업에 필요한 공구를 준비하고 점검한다. 프레스를 사용하여 명세서에 표기한 두께·길이·폭에 맞추어 동판과 운모판을 절단하여 분리핀·슬리브(Sleeve)칼라(Collar)를 만든다. 동판 및 운모조립품을 고정구에 설치하고 유압프레스를 사용하여 누르는 바조임공정 작업을 한다. 오스테나이트를 안정화시킬 수 있는 시즈닝(Seasoning:금속재료 등을 제품화하는 과정에서 외기 중에 장기간 방치하거나 특정처리를 하여 제품성능을 개선하는 것)공정 작업을 한다. 동판의 끝에 운모칼라를 놓고 V링이 사용되는 경우에는 유압프레스를 사용하여 칼라를 링으로 누르는 바조임공정 작업을 한다. 오스테나이트를 안정화시킬 수 있는 시즈닝공정 작업을 한다. 조립품을 볼트·너트 또는 나사줄임링으로 고정한다. 슬롯기계 위의 고정대에 조립품을 설치하고 명시된 깊이에 따라 운모를 가위로 도려내거나 홈을 파는 V홈가공 작업을 한다. 오스테나이트(Austenite:합금원소가 녹아 들어간 면심입방 조직을 이루는 철강 및 합금강을 통틀어 이르는 말)를 안정화시킬 수 있는 시즈닝공정 작업을 한다. 외경을 가공하고 회전시즈닝공정 작업을 한다. 정류자를 시험하기 위해 리드에 전원을 연결한다. 정류자의 기능 이상을 확인하기 위해 검사한다. 완성된 제품은 출하를 위하여 적재한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C281","dJobICdNm":"[C281]전동기, 발전기 및 전기 변환ㆍ 공급ㆍ제어 장치 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006282:1', '{"dJobCd":"K000006282","dJobCdSeq":"1","dJobNm":"제어패널조립원","workSum":"작업표준과 작업지시에 따라 냉동장비와 관련된 각종 제어패널을 조립하여 작동 유무를 확인한다.","doWork":"작업지시서에 따라 조립할 제품의 부분품을 확인·검토한다. 작업에 필요한 장비와 작업공구를 준비한다. 작업표준에 따라 인쇄회로기판, 버튼패널 및 외관커버를 조립한다. 부품을 결합한 후 전원을 넣고 작동 여부를 검사한다. 이상이 있는 제품에 대해 다기능테스터기를 통해 결선 및 단선 여부를 검사하여 수리한다. 이상이 없는 제품을 포장 및 운반하여 적재한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C291","dJobICdNm":"[C291]일반 목적용 기계 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004203:1', '{"dJobCd":"K000004203","dJobCdSeq":"1","dJobNm":"조명기구제조현장감독자","workSum":"엘이디조명·형광등·수은등 등의 조명기구를 제조하는 데 종사하는 작업원의 제조공정의 활동을 감독·조정한다.","doWork":"설계도면을 숙지하고 작업에 필요한 부품과 재료의 수량 및 종류를 확인한다. 작업계획에 따라 작업원을 배치하고 공정별 기계의 준비작업을 감독한다. 작업 중 위험을 방지하고 불량 감소를 위해 작업원을 교육한다. 신입 작업원의 현장교육을 담당한다. 사용되는 기계의 수리·유지업무를 담당하기도 한다. 제조 공정의 수율과 생산 수량을 관리한다. 현장직원의 작업상 애로사항을 듣고 개선 방법을 보고·논의한다. 작업일지를 작성한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","similarNm":"등기구제조반장, 조명기구제조반장","connectJob":"형광등제조반장, 차량등제조반장, 전조등제조반장, 엘이디조명제조반장","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C284","dJobICdNm":"[C284]전구 및 조명장치 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005124:1', '{"dJobCd":"K000005124","dJobCdSeq":"1","dJobNm":"고속철도기장","workSum":"운전조건(선로, 신호, 차량 등)을 고려하여 차종별 견인기기 또는 제동기기를 사용하여 고속철도 차량을 운전한다.","doWork":"출근하여 신고를 하고 상황실 교육 및 승무적합성 검사를 받는 등 고속철도를 운전하기 위한 준비를 한다. 차량인수, 차량기능 점검 및 제동시험, 열차운행조건을 최종적으로 확인한다. 열차시간에 맞춰 열차를 출발시키고 운전조건(선로, 신호, 차량 등)을 고려하여 차종별 견인기기 또는 제동기기를 사용하여 가·감속한다. 열차운행에 필요한 운전정보를 무선전화기를 사용하여 관계직원(관제사, 역장, 기관사, 열차승무원, 기타 관계 직원 등)과 정보를 교환한다. 응급조치 매뉴얼에 따라 사고발생 시 안전조치, 관계사항 급보, 사상자 응급조치 등 현장조치를 한다. 열차 종별에 따라 제동거리를 판단하고 제동기기를 조작하여 감속하여 정차위치에 정착한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"소음·진동|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"조작운전","similarNm":"KTX기관사, KTX기장, SRT기관사, SRT기장","certLic":"고속철도차량운전면허","dJobECd":"6213","dJobECdNm":"[6213]철도·전동차 기관사","dJobJCd":"8710","dJobJCdNm":"[8710]철도 및 전동차 기관사","dJobICd":"H491","dJobICdNm":"[H491]철도 운송업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003987:1', '{"dJobCd":"K000003987","dJobCdSeq":"1","dJobNm":"광산기관차운전원","workSum":"광산에서 채굴된 광석을 운반하는 기관차를 연결·분리·운전한다.","doWork":"광차의 차륜·베어링·문의 개폐상태·주유상태·제동·동력·조명장치 등을 점검하고 연료, 축전기, 주유상태를 확인한다. 광차의 차륜 및 베어링을 점검하고 광차조작원에게 신호하여 광차를 연결하고 연결상태를 점검한다. 이동장소를 확인하고 운광 선로상태를 사전에 확인한다. 광차의 적재량 및 광차 개수를 확인하고 작업원의 승차 여부를 확인한다. 기관차를 운전하여 운행지점으로 이동한다. 광차의 연결순서를 결정하고 광차의 분리 및 연결을 위하여 핀을 조정한다. 규정된 속도로 운행을 하고 앞차와의 간격을 유지한다. 곡선부에서는 경종을 타종하고 분기점·교차점·곡선부·슈트 등 시설장애물이 있는 곳은 서서히 운행한다. 광석을 덤핑할 때에는 서행하여 안전하게 작업할 수 있도록 운전한다. 운행 중 탈선하였을 경우 전후방에 연락하여 다른 기관차의 운행을 정지시키고 적당한 방법으로 복구작업을 한다. 광석을 용이하게 적재할 수 있도록 서서히 운행하거나 적절한 위치에 정차시킨다. 작업 후 광차 및 기관차에 부착된 광석 또는 폐석을 제거하고 이상 유무를 점검한 후 지정된 장소에 주차시킨다. 운행일지를 기록한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"조작운전","similarNm":"광산열차기관사","connectJob":"소형기관차의 종류에 따라 디젤기관차운전원, 트로이카운전원","dJobECd":"6213","dJobECdNm":"[6213]철도·전동차 기관사","dJobJCd":"8710","dJobJCdNm":"[8710]철도 및 전동차 기관사","dJobICd":"B051/B061/B062","dJobICdNm":"[B051]석탄 광업 / [B061]철 광업 / [B062]비철금속 광업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003478:1', '{"dJobCd":"K000003478","dJobCdSeq":"1","dJobNm":"기관차기관사","workSum":"여객과 화물을 수송하기 위하여 객차와 화차를 끄는 디젤기관차를 운전한다.","doWork":"운행할 열차의 연료, 열차연결부, 주행장치, 제어장치, 객실 및 운전실의 상태를 차장과 함께 점검한다. 제동판을 시험조작하여 작동상태를 점검한다. 운행시간표와 운행계획표를 확인하고 신호기 불빛과 수송원 또는 차장의 신호를 주시하여 기관차를 운전한다. 열차의 상태와 속도를 지시계기로 확인하여 조정한다. 열차의 도착, 연착, 사고 등에 관한 정보 및 지시를 운전사령실로부터 받는다. 장애물을 확인하기 위하여 전방철로를 주시한다. 기관차 인계일지와 운행일지를 작성한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"조작운전","connectJob":"수송하는 목적물의 종류에 따라 여객열차기관사, 화물열차기관사","certLic":"철도운송산업기사","dJobECd":"6213","dJobECdNm":"[6213]철도·전동차 기관사","dJobJCd":"8710","dJobJCdNm":"[8710]철도 및 전동차 기관사","dJobICd":"H491","dJobICdNm":"[H491]철도 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004294:1', '{"dJobCd":"K000004294","dJobCdSeq":"1","dJobNm":"기관차기관조사","workSum":"전동차기관사 혹은 기관차기관사의 업무를 보좌한다.","doWork":"기관사가 신호·운행지시 및 운행시간표를 지키는지를 살피고 운행 중 간단한 수리 등을 돕는다. 기관차가 안전하고 효율적으로 운행되고 있는지를 확인하기 위하여 연료계, 온도계, 압력계 등을 관찰한다. 통행인, 교차열차, 낙석 등 선로의 상태를 살피는 업무를 수행한다. 객화차의 연결·분리상태, 진동상태 등을 점검·확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","certLic":"철도운송산업기사","dJobECd":"6213","dJobECdNm":"[6213]철도·전동차 기관사","dJobJCd":"8710","dJobJCdNm":"[8710]철도 및 전동차 기관사","dJobICd":"H491","dJobICdNm":"[H491]철도 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006552:1', '{"dJobCd":"K000006552","dJobCdSeq":"1","dJobNm":"열차기관사(일반)","workSum":"화물 및 승객을 수송하고, 객화차 및 기관차를 이동시키기 위해 디젤기관차, 전기기관차, 전동기관차를 운전한다.","doWork":"운행스케줄을 확인하고 전달사항 및 운행 주의사항, 운전조건 등에 대하여 교번운용원에게 전달받아 운행일지에 기록한다. 운행할 열차의 주행장치, 제어장치, 열차연결 상태 및 연료를 점검한다. 철도수송원이나 운용원, 여객전무나 열차차장 등과 신호를 교신하며 기관차를 운전한다. 운전 시 장애물 등을 확인하고, 열차의 진행방향 및 철로를 주시하며 조종장치를 조작한다. 열차승무원 및 운전사령실 및 철도운용원 등과 무선 및 신호를 이용해 열차의 도착 및 연착시간, 사고사항 등에 대한 정보를 주고받는다. 안전운행을 위하여 수신호, 철도규정, 운전명령서 등을 이해하고 적용한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"소음·진동|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"조작운전","connectJob":"열차의 종류에 따라 기관차기관사, 전동차기관사, 지하철기관사, 철도기관사, 고속철기관사, 궤도열차기관사, 디젤기관차기관사","certLic":"철도차량운전면허","dJobECd":"6213","dJobECdNm":"[6213]철도·전동차 기관사","dJobJCd":"8710","dJobJCdNm":"[8710]철도 및 전동차 기관사","dJobICd":"H491","dJobICdNm":"[H491]철도 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005834:1', '{"dJobCd":"K000005834","dJobCdSeq":"1","dJobNm":"열차기관조사","workSum":"열차 운행 시 열차의 안전운행을 위해 선로 및 신호 등을 살피며 기관사의 업무를 보좌한다.","doWork":"운전업무를 수행하는 열차기관사를 도와 열차신호를 확인하고, 운행지시사항 및 운행시간표를 확인하여 알린다. 열차 운행에 이상이 없는지 수시로 확인하고, 안전운행을 위해 선로의 상태를 확인한다. 연료계, 온도계, 압력계 등을 관찰한다. 객화차의 연결 및 분리상태, 진동상태 등을 점검하고 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"기관차부기관사","certLic":"철도차량운전면허","dJobECd":"6213","dJobECdNm":"[6213]철도·전동차 기관사","dJobJCd":"8710","dJobJCdNm":"[8710]철도 및 전동차 기관사","dJobICd":"H491","dJobICdNm":"[H491]철도 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002376:1', '{"dJobCd":"K000002376","dJobCdSeq":"1","dJobNm":"전동차기관사","workSum":"정해진 운전시각표에 의해 열차의 출고 또는 열차 운전업무를 한다.","doWork":"출근 시간을 기록하고 지시사항을 전달받아 승무일지에 기록한다. 휴대품을 수령하고 일일 교양교육과 적합성검사를 받는다. 승무원 운용표에 의거하여 담당 열차를 운전하며 차장과 수시로 통신연락을 취하여 열차의 이상 유무를 확인하고 안전운행을 기한다. 오른손으로 속도 레버를 조정하고 왼손으로 브레이크 레버를 조정하며 발로 상향등, 하향등을 조절한다. 각종 신호기의 신호와 종합사령실의 지시, 차장의 신호에 따라 열차를 출발시킨다. 규정된 속도로 열차를 운행한다. 운전 중에는 신호, 전로, 전차선로, 기타 구조물의 이상 유무를 확인하고 신호나 통신을 통한 지시를 통하여 신호정지 및 정지 후 출발에 관한 제반 조치를 취한다. 역에 진입 시 속도를 늦추며 정확하게 정차표지를 확인하여 정차위치에 열차를 정차한다. 일정거리의 운전이 끝나면 담당 열차 운전개황, 사고 유무 및 내역, 기타 운전에 관계되는 사항에 대하여 보고한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"조작운전","similarNm":"지하철기관사, 전철기관사","certLic":"철도운송산업기사, 철도차량운전면허(제2종전기차량운전면허)","dJobECd":"6213","dJobECdNm":"[6213]철도·전동차 기관사","dJobJCd":"8710","dJobJCdNm":"[8710]철도 및 전동차 기관사","dJobICd":"H492","dJobICdNm":"[H492]육상 여객 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003722:1', '{"dJobCd":"K000003722","dJobCdSeq":"1","dJobNm":"전동차입환기관사","workSum":"열차의 기지 내의 입환작업 수행을 주 업무로 하며 필요시 본선열차 운전 및 취급역의 열차 반복입환을 한다.","doWork":"운전취급실의 지시에 따라 입고선과 검수고에 차량을 유치시키는 일을 한다. 구내에서 승객이 탑승하지 않은 열차를 청소, 정비, 검수를 위해 기지창, 검사고, 유치선, 세척선의 일련의 기지 내 입환운전을 한다. 중장기 검사를 위해 해체·조립된 차량을 입환전동차를 이용하여 검수고 또는 주공장에 입환시킨다. 명령에 의하여 본선의 임시영업열차를 운행하고 운전취급역의 열차를 기지 내에 입고시키고 역으로 출고시키는 업무를 수행한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"조작운전","similarNm":"전동차입환승무원","certLic":"산업안전산업기사, 철도운송산업기사, 철도차량운전면허","dJobECd":"6213","dJobECdNm":"[6213]철도·전동차 기관사","dJobJCd":"8710","dJobJCdNm":"[8710]철도 및 전동차 기관사","dJobICd":"H492","dJobICdNm":"[H492]육상 여객 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006699:1', '{"dJobCd":"K000006699","dJobCdSeq":"1","dJobNm":"철도차량시운전원","workSum":"철도차량 제작 후 단차 및 편성상태에서의 성능을 시험하고 발생될 수 있는 문제점을 찾아내 운행 전 조치한다.","doWork":"철도차량시운전을 위하여 완성된 열차를 견인차로 이동한다. 공장 내 시운전과 본선에서 시운전을 실시한다. 공장 내 시운전을 통하여 내구성(운전실장치 등 차량성능, 신호장치 등의 안전성, 조명장치, 출입문장치, 방송장치 등의 쾌적성, 누수 및 누기 등)을 작업표준서와 비교하고 검사한다. 시운전 선로에서는 차량을 운전하면서 차량의 성능(운전실 내 기기의 작동상태, 주행성능, 대차주행성능, 차체진동특성, 제동특성, 유도장애, 집진장치성능, 주행저항, 차내소음, 냉난방환기, 제어 및 감시, 차외소음, 공력특성, 괘도성능, 비상제동거리, 제동거리 등)을 작업표준서와 비교, 검사한다. 차량 출하 후 본선에서 발주처의 관련자와 동승하여 운전시험을 하며 각종 기기의 작동상태를 확인한다. 시운전 측정기록지를 작성하여 관련 부서에 제출한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|손사용|시각|","workEnv":"소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"조작운전","similarNm":"전동차시운전원","certLic":"철도차량운전면허(고속철도차량운전면허, 제1종전기차량운전면허, 제2종전기차량운전면허, 디젤차량운전면허, 철도장비운전면허)","dJobECd":"6213","dJobECdNm":"[6213]철도·전동차 기관사","dJobJCd":"8710","dJobJCdNm":"[8710]철도 및 전동차 기관사","dJobICd":"C312","dJobICdNm":"[C312]철도장비 제조업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004136:1', '{"dJobCd":"K000004136","dJobCdSeq":"1","dJobNm":"열차수송원","workSum":"객차 및 화차를 연결 및 분리하여 정해진 차량 수에 맞추어 한 개의 열차로 만든다.","doWork":"기관차가 이끌 수 있는 견인력 및 기차가 통과하는 역의 철로 길이를 파악한다. 입환기를 조작하여 객차 및 화차를 연결한 후 한 개의 열차로 만든다. 도착열차 및 운행열차 등에 문제 발생 시 문제가 발생한 객차 및 화차를 분리한다. 선로전환기를 조작하여 지정된 철로에서 기관차를 분리 및 연결한 후, 확인한다. 입환지시서를 발행하고 입환에 관하여 기관사와 협의한다. 수송작업장 및 관련 장비나 도구를 관리하고 필요시 보수하기도 한다. 제설·제초작업을 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|","workEnv":"소음·진동|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"입환원, 조차원","certLic":"철도운송산업기사","dJobECd":"6219","dJobECdNm":"[6219]기타 철도운송 종사원","dJobJCd":"8720","dJobJCdNm":"[8720]철도운송 관련 종사원","dJobICd":"H491","dJobICdNm":"[H491]철도 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006041:1', '{"dJobCd":"K000006041","dJobCdSeq":"1","dJobNm":"열차신호원","workSum":"역내의 이동 열차의 교통을 통제하기 위하여 신호기 및 전철기를 조작한다.","doWork":"역내의 신호소에서 역내를 통과하는 열차의 충돌 및 사고 방지를 위하여 열차운행관리원과 연락하여 지정선을 관리하고 열차 운행상황을 통보한다. 들어오는 차량을 지정된 선로로 이동시키기 위해 선로를 변경한다. 열차 이동상황이 나타나는 전광판의 신호를 보면서 열차의 위치를 확인하여 신호조작판을 조작한다. 인접역과 연락하여 열차의 도착 및 출발상황을 통보한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","dJobECd":"6219","dJobECdNm":"[6219]기타 철도운송 종사원","dJobJCd":"8720","dJobJCdNm":"[8720]철도운송 관련 종사원","dJobICd":"H491","dJobICdNm":"[H491]철도 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001717:1', '{"dJobCd":"K000001717","dJobCdSeq":"1","dJobNm":"열차운용원","workSum":"해당 역을 통과하는 열차의 출발 또는 도착 레일을 조정하고, 해당 구역 내의 열차 운행상황을 총괄적으로 관리한다.","doWork":"도착하거나 출발하는 열차의 선로를 조정 및 확인한다. 지연되는 열차의 운행사항을 파악하고 도착에 맞추어 선로를 조정한다. 기관차기관사 및 열차승무원의 현황 및 운행상태를 확인하고, 고장 유무를 파악한다. 열차 운행 시 진행, 주의 및 정지 등 각종 신호를 조작판에서 조작한다. 열차 통과 시각을 컴퓨터에 입력한다. 건널목에서 열차를 통제할 수 있도록 임시열차 및 공사열차 등의 열차 상황을 알려준다. 전철기 및 신호보안장치를 점검하고 열차사고 및 연락사항 발생 시 관계처에 통보한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"수동조작","certLic":"철도운송산업기사","dJobECd":"6219","dJobECdNm":"[6219]기타 철도운송 종사원","dJobJCd":"8720","dJobJCdNm":"[8720]철도운송 관련 종사원","dJobICd":"H491","dJobICdNm":"[H491]철도 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005806:1', '{"dJobCd":"K000005806","dJobCdSeq":"1","dJobNm":"열차홈안내원","workSum":"열차의 안전운행을 유도하고, 승객의 승·하차 상황을 파악하여 안전사고를 예방한다.","doWork":"열차가 안전하게 운행될 수 있도록 열차를 유도하고. 열차의 진·출입 시 역 승강장의 승객들의 안전을 도모한다. 승·하차 시 동태를 파악하여 사고를 미연에 방지한다. 승객의 유실물이 있을 시 열차승무원에게 연락하고 유실물을 보관한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"홈안내원","dJobECd":"6219","dJobECdNm":"[6219]기타 철도운송 종사원","dJobJCd":"8720","dJobJCdNm":"[8720]철도운송 관련 종사원","dJobICd":"H491","dJobICdNm":"[H491]철도 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001400:1', '{"dJobCd":"K000001400","dJobCdSeq":"1","dJobNm":"유도무선원","workSum":"갱내 기관차의 위치를 선정하고 확인하여 작업상황을 파악하기 위하여 중앙제어실에서 통제기를 감시·조정한다.","doWork":"상황판 및 통제기를 주시하여 기관차의 위치 및 가동상태의 정상 여부를 확인한다. 작업 위치로 기관차의 진입을 지시하고 조정한다. 작업원의 인수인계 상황을 점검하고 지시사항을 통보하며 작업실적을 기록한다. 중앙제어실의 계기를 판독하여 작업장의 이상 유무를 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"6219","dJobECdNm":"[6219]기타 철도운송 종사원","dJobJCd":"8720","dJobJCdNm":"[8720]철도운송 관련 종사원","dJobICd":"B051/B061/B062","dJobICdNm":"[B051]석탄 광업 / [B061]철 광업 / [B062]비철금속 광업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001273:1', '{"dJobCd":"K000001273","dJobCdSeq":"1","dJobNm":"전동차차장","workSum":"승객안내방송 및 출입문을 취급하며 열차 정지 및 출발 시에 신호기 상태 및 열차의 제반 상태를 감지·파악하는 업무를 수행한다.","doWork":"운행스케줄을 확인하고 전달사항 및 운행 주의사항, 운전조건 등을 확인하고 운행일지에 기록한다. 전동차를 점검하여 전기 또는 기계정치를 시험하고 연료, 물 등의 공급이 적당한지 확인한다. 승객안내방송을 하고 출입문을 개폐한다. 열차의 진행방향과 철로를 관찰하며 교통통제원과 교통정보 신호를 주고받는다. 열차의 정거장 진입 및 출발 시에 열차의 상태, 승객의 안전 여부, 후부를 파악하고 감시한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"열차차장","certLic":"철도운송산업기사","dJobECd":"6219","dJobECdNm":"[6219]기타 철도운송 종사원","dJobJCd":"8720","dJobJCdNm":"[8720]철도운송 관련 종사원","dJobICd":"H492","dJobICdNm":"[H492]육상 여객 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001756:1', '{"dJobCd":"K000001756","dJobCdSeq":"1","dJobNm":"철도건널목안내원","workSum":"열차사고를 예방하기 위하여 철도 건널목에서 차단기를 올리고 내린다.","doWork":"철도차량의 운행시간을 숙지한다. 열차가 통과하기 전에 차단기를 내리고 통행인과 차량을 통제한다. 통과열차에 안전신호를 보내기 위해 신호깃발을 흔든다. 열차가 통과하면 차단기를 올리고 차량이나 행인을 통과시킨다. 차단기에 도색을 하기도 하고 산사태·선로침수와 같은 사고가 없는지 순찰하기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"가벼운 작업","workPlace":"실외","physicalAct":"웅크림|","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"차단기조작원, 철도신호원, 철도건널목간수","dJobECd":"6219","dJobECdNm":"[6219]기타 철도운송 종사원","dJobJCd":"8720","dJobJCdNm":"[8720]철도운송 관련 종사원","dJobICd":"H491","dJobICdNm":"[H491]철도 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001546:1', '{"dJobCd":"K000001546","dJobCdSeq":"1","dJobNm":"철도수송원","workSum":"철도객차 및 화차의 조성, 연결, 해방, 운전취급 등의 업무를 수행한다.","doWork":"입환기를 움직여 객차 및 화차를 연결 또는 분리하고 정해진 객차(화차)량수에 발전차, 기관차 등을 연결 조합하여 한 개의 열차를 편성한다. 도착열차, 운행열차 등에 불량차가 발생하였을 때 분리하여 불량차를 해방하고 양차를 붙이기도 한다. 운전원이 없는 경우 운전취급 담당자로 지정받아 신호조작, 열차감시, 폐색기취급 등의 업무를 수행한다. 전철기(전기선로전환기)를 청소한다. 비상사태 발생 시 소속장의 지시에 따라 업무를 처리한다. 역구내 착발 열차의 조사·조성, 차량수배 등의 업무를 수행한다. 입환지시서를 발행하고 입환에 관하여 기관사와 협의한다. 제설, 제초, 환경미화 등의 작업을 수행하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실외","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","similarNm":"조차원, 입환원","connectJob":"차량기지내수송원","certLic":"철도운송산업기사, 철도신호산업기사, 철도신호기능사","dJobECd":"6219","dJobECdNm":"[6219]기타 철도운송 종사원","dJobJCd":"8720","dJobJCdNm":"[8720]철도운송 관련 종사원","dJobICd":"H491","dJobICdNm":"[H491]철도 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006608:1', '{"dJobCd":"K000006608","dJobCdSeq":"1","dJobNm":"철도신호원","workSum":"기지 내의 이동차량에 대하여 신호기와 전철기(전기선로전환기)를 조작하여 차량의 위치를 조정한다.","doWork":"열차 운전원과 연락하여 열차의 운행계획이나 시간표 등을 확인한다. 차량편성표에 따라 충돌, 사고방지를 판단하여 차량을 목적 위치에 유치하도록 선로를 변경한다. 열차운행 전광판의 신호(LED) 및 신호기의 색상을 보고 열차의 위치를 확인하여 신호조작패널을 조작하여 선로를 변경한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"구내반원","connectJob":"지하철신호원, 철도신호기조작원","certLic":"철도신호산업기사, 철도신호기능사","dJobECd":"6219","dJobECdNm":"[6219]기타 철도운송 종사원","dJobJCd":"8720","dJobJCdNm":"[8720]철도운송 관련 종사원","dJobICd":"H491","dJobICdNm":"[H491]철도 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003683:1', '{"dJobCd":"K000003683","dJobCdSeq":"1","dJobNm":"철도장비운전원","workSum":"철도 및 지하철과 관련한 토목 및 궤도의 보수·점검 시 사용하는 각종 장비를 조작·운전 및 관리하는 일을 한다.","doWork":"궤도구조물 및 토목구조물 개보수공사, 순회점검 시 모터카, 순회점검차, 연마차, 탐상차, 자갈다짐차, 침식차 등을 조작 및 연결하여 보수 및 점검 현장까지 이동시킨다. 장비를 점검하고 문제가 있는 장비의 경우 수리하거나 수리업체에 의뢰한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"손사용|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"조작운전","certLic":"철도장비운전면허","dJobECd":"6219","dJobECdNm":"[6219]기타 철도운송 종사원","dJobJCd":"8720","dJobJCdNm":"[8720]철도운송 관련 종사원","dJobICd":"H491","dJobICdNm":"[H491]철도 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007465:1', '{"dJobCd":"K000007465","dJobCdSeq":"1","dJobNm":"택시운전원","workSum":"승객을 승차시켜 원하는 장소까지 수송하는 택시를 운전한다.","doWork":"운행 전에 택시배차원이 지정해준 차량이나 자신의 택시의 엔진오일, 공기압력, 냉각수 등을 점검한다. 운행하면서 승객의 신호에 따라 승객을 승차시키고 미터기, 내비게이션이나 통역시스템 등을 조작한다. 목적지까지 운전하고 미터기에 기록된 요금을 수령한다. 회사택시의 경우 업무 후 차량을 회사에 입고시키고 교대자에게 인수한 후 정해진 수입금을 납부한다. 운행일지를 작성하고, 간단한 고장을 수리하거나 파손된 타이어를 교체한다. 사고 발생 시 차량사고처리원에게 연락하여 사진 촬영 등 사고처리를 위한 업무를 수행한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|","workFunc1":"계산","workFunc2":"말하기신호","workFunc3":"조작운전","similarNm":"택시운전사, 택시운전기사, 택시기사","connectJob":"영업용택시기사, 개인용택시기사, 콜택시기사, 리무진택시기사, 밴택시기사","certLic":"자동차운전면허(1종, 2종), 택시운전자격시험, 개인택시면허","dJobECd":"6221","dJobECdNm":"[6221]택시 운전원","dJobJCd":"8731","dJobJCdNm":"[8731]택시 운전원","dJobICd":"H492","dJobICdNm":"[H492]육상 여객 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007468:1', '{"dJobCd":"K000007468","dJobCdSeq":"1","dJobNm":"버스운전원","workSum":"승객을 수송하기 위해 운행계획표에 따라 버스를 운전한다.","doWork":"운수회사, 기업체 등에서 일반승객이나 사원 등을 수송하기 위해 정해진 운행계획표를 확인한다. 안전운행을 위해 차량의 엔진오일, 냉각수 등을 점검한다. 승객의 편의를 돕기 위해 냉난방, 조명 등을 조절하고 정해진 노선을 따라 버스를 운전한다. 승객의 요금을 확인하거나 정산해주기도 한다. 운행이 끝나면 운행시간, 특이사항이나 사고사항 등에 대하여 운행일지를 작성한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"조작운전","similarNm":"버스운전사","connectJob":"운전하는 버스의 종류에 따라 시내버스운전원, 시외버스운전원, 고속버스운전원, 전세버스운전원, 사업체버스운전원, 승합차버스운전원, 마을버스운전원, 관광버스운전원, 읍내버스운전원, 학원버스운전원, 노선버스운전원, 통학버스운전원, 학교버스운전원, 스쿨버스운전원, 유치원셔틀버스운전원, 어린이집버스운전원, 통근버스운전원, 출퇴근버스운전원, 건강검진버스운전원, 이동목욕차량운전원","certLic":"자동차운전면허(대형)","dJobECd":"6222","dJobECdNm":"[6222]버스 운전원","dJobJCd":"8732","dJobJCdNm":"[8732]버스 운전원","dJobICd":"H492","dJobICdNm":"[H492]육상 여객 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005279:1', '{"dJobCd":"K000005279","dJobCdSeq":"1","dJobNm":"장의차운전원","workSum":"시체를 운수할 수 있는 특수한 설비를 갖춘 차량을 운전한다.","doWork":"장례식장 또는 병원의 영안실에서 시체운구를 접수하고 영구차를 운전한다. 관의 묶임상태를 확인하고 차량의 관함문을 열어 관을 넣는다. 관이 움직이지 않도록 고정한다. 문을 닫고 상주 및 조객의 승차를 유도한다. 조객의 승차를 확인하고 장지로 차량을 운전한다. 주행거리를 계산하여 차량의 사용요금을 받고 영수증을 발급한다. 세척제를 사용하여 차량을 청소하기도 하고 소독제를 사용하여 관함을 소독하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|손사용|시각|","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","similarNm":"영구차버스운전원","certLic":"자동차운전면허","dJobECd":"6222","dJobECdNm":"[6222]버스 운전원","dJobJCd":"8732","dJobJCdNm":"[8732]버스 운전원","dJobICd":"S969","dJobICdNm":"[S969]그 외 기타 개인 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003968:1', '{"dJobCd":"K000003968","dJobCdSeq":"1","dJobNm":"분뇨수거차량운전원","workSum":"일반주택, 아파트, 빌딩 등의 분뇨를 수거하기 위하여 분뇨수거차량을 운전·조작한다.","doWork":"분뇨의 수거신청서를 검토하여 지역 및 예상수량을 확인하고 분뇨수거차량을 운전한다. 분뇨를 수거하기 위하여 정화조 또는 분뇨탱크의 뚜껑을 열고 흡입호스를 투입한다. 분뇨수거차량의 진공펌프를 가동하고 유량계를 확인한다. 수거된 분뇨의 용량에 따라 요금을 받고 영수증을 발급한다. 수거한 분뇨를 분뇨처리장(위생처리장)으로 운반하고 운반확인증을 발급받는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"손사용|시각|","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","connectJob":"분뇨수거차량을 운전하지는 않으나 조작하는 경우 분뇨수거원","certLic":"자동차운전면허(대형)","dJobECd":"6223","dJobECdNm":"[6223]화물차·특수차 운전원","dJobJCd":"8733","dJobJCdNm":"[8733]화물차 및 특수차 운전원","dJobICd":"E370","dJobICdNm":"[E370]하수, 폐수 및 분뇨 처리업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004804:1', '{"dJobCd":"K000004804","dJobCdSeq":"1","dJobNm":"산업폐수수거원","workSum":"병원, 중소업체 및 대기업체 등에서 발생한 산업폐수를 수거하는 업무를 한다.","doWork":"산업폐수수거 업무에 대한 일일 및 주계획을 숙지한다. 방문할 업체를 확인하고 수거장비를 준비한다. 업체를 방문하여 수거장비를 이용하여 운반하거나 장비를 조작하여 산업폐수를 수거한다. 수거된 폐수를 집수기에 저장한다. 흡입장비가 설치된 탱크로리를 운전하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실외","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","certLic":"자동차운전면허(대형)","dJobECd":"6223","dJobECdNm":"[6223]화물차·특수차 운전원","dJobJCd":"8733","dJobJCdNm":"[8733]화물차 및 특수차 운전원","dJobICd":"E370","dJobICdNm":"[E370]하수, 폐수 및 분뇨 처리업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003686:1', '{"dJobCd":"K000003686","dJobCdSeq":"1","dJobNm":"청소차운전원","workSum":"주택가, 상가, 공장지역 등의 쓰레기를 수거하기 위하여 청소차를 운전한다.","doWork":"관할 지역의 쓰레기, 음식물쓰레기, 재활용 쓰레기 등 여러 형태의 쓰레기를 수거하기 위하여 일정한 시간과 코스에 따라 청소차를 운전한다. 차량에 동승한 쓰레기 수거원이 차량에 부착된 쓰레기통 견인장치를 작동하거나 쓰레기봉투를 수거하여 적재함에 투입할 수 있도록 차량을 운전한다. 쓰레기의 수거가 완료되면 중간집결지(적환장)로 이동하며 청소차를 운전하여 매립 또는 소각 가능한 것으로 분류된 쓰레기를 쓰레기매립장이나 소각장에 하차한다. 분리하여 배출된 재활용품이나 대형폐기물을 적환장이나 처리업체로 운반하기도 한다. 공장에서 배출되는 각종 산업폐기물 및 쓰레기를 운반하기도 한다. 도로 위에 쌓인 흙, 먼지 등을 차량의 세척장치를 사용하여 청소하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"손사용|시각|","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","certLic":"자동차운전면허(대형)","dJobECd":"6223","dJobECdNm":"[6223]화물차·특수차 운전원","dJobJCd":"8733","dJobJCdNm":"[8733]화물차 및 특수차 운전원","dJobICd":"N742","dJobICdNm":"[N742]건물ㆍ산업설비 청소 및 방제 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005750:1', '{"dJobCd":"K000005750","dJobCdSeq":"1","dJobNm":"탑승장비운전원","workSum":"항공기에 탑승하는 승객의 편의를 돕기 위하여 스텝카(Step Car), 로딩브리지(Loading Bridge) 등의 탑승장비를 조작한다.","doWork":"항공기에 탑승하거나 내리는 승객의 편의를 돕기 위하여 스텝카(Step Car：계단이 부착된 차량)를 운전하여 출입문에 부착한다. 바퀴를 고정하고 출입구의 높이를 조정한다. 항공기가 로딩브리지(Loading Bridge：터널식 탑승장비)의 옆에 정지하면 스위치를 조작하여 항공기의 출입구에 로딩브리지의 입구를 맞춘다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"손사용|시각|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"자동차운전면허","dJobECd":"6223","dJobECdNm":"[6223]화물차·특수차 운전원","dJobJCd":"8733","dJobJCdNm":"[8733]화물차 및 특수차 운전원","dJobICd":"H511","dJobICdNm":"[H511]항공 여객 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003184:1', '{"dJobCd":"K000003184","dJobCdSeq":"1","dJobNm":"트랜스포터운전원","workSum":"제철소, 조선소, 항만 등에서 수백 톤에서 천 톤 정도의 중량물을 운반하는 특수장비 차량인 트랜스포터를 운전한다.","doWork":"적재된 화물과 이동장소를 확인한다. 트랜스포터의 운전석에 승차한다. 트랜스포터의 앞, 뒤, 좌, 우에 위치한 신호수들과 조를 이루어 이동 구간에 간섭이 없는지 확인하며 이동한다. 차량에 장치된 모니터와 거울을 확인하며 이동 간에 위험요인을 배제한다. 운전석 밖에서 원격 조종장치로 조종하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실외","physicalAct":"청각|손사용|언어력|시각|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"조작운전","dJobECd":"6223","dJobECdNm":"[6223]화물차·특수차 운전원","dJobJCd":"8733","dJobJCdNm":"[8733]화물차 및 특수차 운전원","dJobICd":"C241/C311/H493","dJobICdNm":"[C241]1차 철강 제조업 / [C311]선박 및 보트 건조업 / [H493]도로 화물 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002049:1', '{"dJobCd":"K000002049","dJobCdSeq":"1","dJobNm":"특수차량운전원","workSum":"부정기적인 특정화물을 운송하기 위하여 냉동탱크 등의 특수설비가 장착된 차량을 운전한다.","doWork":"운송지역을 확인하고 엔진오일, 냉각수, 타이어의 공기압력 등을 점검한다. 특정화물의 안전한 수송을 위하여 각종 안전장치의 이상 유무를 확인한다. 목적지에 도착하여 화물의 이상 유무를 확인하고 서류를 정리하여 관련 부서에 인계한다. 가스나 유류를 운반하기 위하여 탱크의 밀폐상태 및 압력을 점검하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|손사용|시각|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"조작운전","similarNm":"특수차운전원","connectJob":"운전하는 차량의 종류에 따라 냉동차운전기사, 유조차운전기사, 컨테이너차운전기사, 트레일러운전기사, 렉카운전원, 견인차운전원, 탱크로리운전원, 트레일러운전원, 컨테이너트레일러운전원, 특장차운전원, 살수차운전원, 정화조차량운전원, 압착진개차운전원, 바큠카운전원, 압롤차량운전원, 집게차운전원, 사다리차운전원","certLic":"자동차운전면허","dJobECd":"6223","dJobECdNm":"[6223]화물차·특수차 운전원","dJobJCd":"8733","dJobJCdNm":"[8733]화물차 및 특수차 운전원","dJobICd":"H493","dJobICdNm":"[H493]도로 화물 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005047:1', '{"dJobCd":"K000005047","dJobCdSeq":"1","dJobNm":"화물차운전원","workSum":"각종 화물을 적재하여 목적지까지 운송하기 위해 화물차를 운전한다.","doWork":"화물의 종류, 수량 및 행선지 등이 기록된 운송기록장을 확인하고 화물을 적재할 장소까지 화물차를 운전한다. 화물의 적재형태와 안전성 여부를 확인하고 화주로부터 운송확인서를 접수한다. 화물의 적재높이, 무게 등을 고려하여 차량을 행선지까지 운전한다. 화물의 파손상태 및 수량을 확인하여 하역하고, 운송기록장을 인계한다. 화물 적재 및 하역을 돕기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","similarNm":"화물자동차운전사","connectJob":"차량 크기에 따라 소형트럭운전원, 대형트럭운전원, 십바리운전원, 앞사바리운전원","certLic":"자동차운전면허(1종), 화물운송종사자(자격시험)","dJobECd":"6223","dJobECdNm":"[6223]화물차·특수차 운전원","dJobJCd":"8733","dJobJCdNm":"[8733]화물차 및 특수차 운전원","dJobICd":"H493","dJobICdNm":"[H493]도로 화물 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002797:1', '{"dJobCd":"K000002797","dJobCdSeq":"1","dJobNm":"구급차운전원","workSum":"응급환자나 안전한 이동을 요하는 환자를 운송하기 위해 구급차를 운전한다.","doWork":"구급차의 안전운전 및 방어운전 지침, 구급차에서의 통신 및 제반 업무 지침을 숙지한다. 응급환자가 발생하면 환자가 신속하게 의사의 진료를 받을 수 있도록 빠른 속도로 운전한다. 응급환자가 타고 있음을 알리는 경광등을 켜고 경음을 울린다. 운송 중에 환자가 갑작스러운 상해를 입지 않도록 차체가 흔들리지 않게 주의하면서 병원 또는 기타 목적지로 운전한다. 난폭한 환자에게 족쇄(Shackle)를 채우기도 한다. 필요시 간단한 응급조치를 하기도 한다. 사고 또는 응급조치에 관한 사실을 의사나 병원직원에게 보고하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"손사용|시각|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"조작운전","certLic":"자동차운전면허, 응급구조사","dJobECd":"6229","dJobECdNm":"[6229]기타 자동차 운전원","dJobJCd":"8739","dJobJCdNm":"[8739]기타 자동차 운전원","dJobICd":"Q869","dJobICdNm":"[Q869]기타 보건업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005706:1', '{"dJobCd":"K000005706","dJobCdSeq":"1","dJobNm":"대리운전기사","workSum":"대리운전을 신청한 고객의 요청에 따라 고객의 자동차를 대신 운전하여 자동차 또는 고객을 목적지까지 유상으로 운송한다.","doWork":"대리운전업체에 기사등록을 하고 수수료와 보험료를 납부한다. 대리운전 수요가 빈번하게 발생하는 지역에서 대기한다. 대리운전업체에서 전화로 보내주는 콜(고객의 출발지와 목적지, 전화번호, 이용요금 등)을 확인하여 현재 자신의 위치에서 이동이 가능하면 자신이 대리운전을 수행하겠다는 표시인 콜수신을 한다. 고객의 차량이 있는 장소로 이동한다. 고객을 확인하고 목적지까지 고객을 대신하여 운전하고 정해진 요금을 받는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","certLic":"자동차운전면허","dJobECd":"6229","dJobECdNm":"[6229]기타 자동차 운전원","dJobJCd":"8739","dJobJCdNm":"[8739]기타 자동차 운전원","dJobICd":"H492","dJobICdNm":"[H492]육상 여객 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003367:1', '{"dJobCd":"K000003367","dJobCdSeq":"1","dJobNm":"자가용운전원","workSum":"기관의 장이나 임원의 출퇴근 및 외부일정을 돕기 위해 차량을 운행하고 차량의 상태를 지속적으로 관리한다.","doWork":"기관의 장이나 임원의 출퇴근 및 외부일정 시간과 목적지를 숙지한다. 목적지까지 안전한 운행을 위해 차량을 사전 점검한다. 주행 중 법률을 준수하며 안전하게 자가용을 운전한다. 차량의 상태를 수시로 점검하고 소모품과 부품을 정기적으로 교체한다. 차량 사고가 발생하거나 차량에 이상이 발생할 경우 신속하게 안전조치를 취하며, 총무부 등 관련 부서와 보험 및 수리에 관련된 일련의 조치를 취한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","similarNm":"자가용운전사, 승용차운전원","connectJob":"대리운전기사, 렌터카운전원, 렌터카인도원, 사장차운전원, 업무차량운전원, 수행기사","certLic":"자동차운전면허","dJobECd":"6229","dJobECdNm":"[6229]기타 자동차 운전원","dJobJCd":"8739","dJobJCdNm":"[8739]기타 자동차 운전원","dJobICd":"H492","dJobICdNm":"[H492]육상 여객 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003619:1', '{"dJobCd":"K000003619","dJobCdSeq":"1","dJobNm":"가공삭도운전원","workSum":"광산에서 광석·자재 및 기타 재료를 운반하기 위하여 지주에 의하여 가설된 케이블 선로에 매달린 버킷(Bucket)을 조작한다.","doWork":"케이블의 장력을 조절하고 활차의 상태를 점검한다. 구동부의 상태를 점검하고 윤활유를 주입한다. 버킷의 파손 여부를 검사한다. 버튼 및 스위치를 조작하여 회전부 및 케이블을 감는 장치를 시동한다. 신호를 보내 운반물을 싣도록 하고 운반장소까지 버킷을 이동시키기 위해 레버를 조작한다. 버킷의 이동상태를 감시하고 운반물을 부리기 위해 버튼을 누른다. 신호판을 감시하고 자동으로 운반물을 부리는 장치를 주시한다. 선로 및 롤러를 보수한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|손사용|","workEnv":"위험내재|다습|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","dJobECd":"6230","dJobECdNm":"[6230]물품이동장비 조작원(크레인·호이스트·지게차)","dJobJCd":"8740","dJobJCdNm":"[8740]물품 이동 장비 조작원","dJobICd":"B071","dJobICdNm":"[B071]토사석 광업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004334:1', '{"dJobCd":"K000004334","dJobCdSeq":"1","dJobNm":"가구자재운반원","workSum":"지게차를 이용하여 목재 등의 가구 자재를 운반하고 하역한다.","doWork":"지게차 혹은 자재 운송용 특수차량을 이용하여 각종 가구 자재를 작업자에게 운반하고 하역한다. 지게차의 시동을 걸고 전후좌우 시야를 확인한 후 차량 앞쪽에 위치한 운반용 포크 발을 지면에서 일정 간격으로 높이고 서행한다. 들고자 하는 자재의 넓이에 따라 포크 발을 조정하고 자재가 땅바닥에 닿지 않도록 한다. 자재를 포크 발에 싣고 운전자 앞쪽으로 포크 발을 당겨서 균형을 잡는다. 하역 장소까지 서행하면서 목적지에 자재를 내려놓고 포크 발을 수평 이하로 내린 후 후진으로 하역장소에서 빠져나온다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","certLic":"지게차운전기능사","dJobECd":"6230","dJobECdNm":"[6230]물품이동장비 조작원(크레인·호이스트·지게차)","dJobJCd":"8740","dJobJCdNm":"[8740]물품 이동 장비 조작원","dJobICd":"C320","dJobICdNm":"[C320]가구 제조업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003006:1', '{"dJobCd":"K000003006","dJobCdSeq":"1","dJobNm":"갑문조정판조작원","workSum":"선박의 수리나 이송 등의 목적으로 항구의 갑문을 개폐하는 조정판을 조작한다.","doWork":"조정판의 수위, 유량 등을 측정하는 계기를 점검하고 선박의 종류 및 규모를 확인한다. 선박의 종류와 제원에 따라 갑문을 선정하고 해당 선박의 선장이나 도선사에게 통보한다. 선박이 갑문을 향해 입항하면 조정판을 조작하여 바다 측의 갑문을 열고 선박이 통행할 수 있도록 안내한다. 선박의 통행이 완료되면 조정판을 조작하여 바다 측의 갑문을 닫고 펌프나 수로를 열어 수면을 조정한다. 수면의 조정이 완료되면 항구 측의 갑문을 열어 선박이 항구로 진입할 수 있도록 안내한다. 갑문을 통과한 선박의 종류, 제원 및 갑문의 통과시간 등을 일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"6230","dJobECdNm":"[6230]물품이동장비 조작원(크레인·호이스트·지게차)","dJobJCd":"8740","dJobJCdNm":"[8740]물품 이동 장비 조작원","dJobICd":"H501","dJobICdNm":"[H501]해상 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006638:1', '{"dJobCd":"K000006638","dJobCdSeq":"1","dJobNm":"갠트리크레인조종원","workSum":"컨테이너 화물을 선박이나 부두에 선적·하역하기 위해 갠트리크레인(컨테이너크레인)을 조종한다.","doWork":"선적·하역할 컨테이너의 수량 및 규격을 확인한다. 컨테이너를 이동시키기 위해 갠트리크레인의 조종장치를 조작한다. 신호수의 신호에 따라 기중기의 조정레버와 스위치를 조작하여 컨테이너를 선박에 선적하거나 차량에 적재한다. 사고 예방을 위해 크레인을 점검하고 정비한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","similarNm":"컨테이너크레인운전원","certLic":"기중기운전기능사","dJobECd":"6230","dJobECdNm":"[6230]물품이동장비 조작원(크레인·호이스트·지게차)","dJobJCd":"8740","dJobJCdNm":"[8740]물품 이동 장비 조작원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005230:1', '{"dJobCd":"K000005230","dJobCdSeq":"1","dJobNm":"곡물하역장치조작원","workSum":"선박의 곡물을 하역하기 위하여 하역설비를 조작한다.","doWork":"곡물하역설비 운전실의 각종 스위치를 점검하고 화물의 종류를 사전에 파악한다. 선박의 접안상태와 해치커버의 개방 유무를 점검한다. 선박의 작업홀드의 순서를 선사측과 협의한다. 하역설비를 작업할 홀드로 이동시키고 컨베이어의 작동과 작업이상 유무를 확인한다. 컨베이어의 운반능력과 사일로 저장능력을 감안하여 시간당 하역량을 결정하고 하역설비를 운전한다. 하역 중 모니터의 확인과 감독자의 지시에 따라 시간당 하역량을 조정한다. 작업을 종료한 후 하역설비를 점검하고 작업일지를 작성한다. 하역설비의 관리와 청소를 담당한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","dJobECd":"6230","dJobECdNm":"[6230]물품이동장비 조작원(크레인·호이스트·지게차)","dJobJCd":"8740","dJobJCdNm":"[8740]물품 이동 장비 조작원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003105:1', '{"dJobCd":"K000003105","dJobCdSeq":"1","dJobNm":"권양기조종보조원","workSum":"광산의 수갱이나 사갱에서 광석이나 경석을 운반하기 위하여 권양기를 운전하는 권양기조종원을 보조한다.","doWork":"광차를 싣거나 내리는 데킹(Decking)장비의 조작스위치·주유 및 공기압력상태·연동장치·신호장치 등을 점검한다. 권양기조종원에게 전화·인터폰·벨 등으로 신호하여 케이지를 내려보내도록 한다. 케이지의 문을 열고 대기 중인 광차·인원·자재·장비 등을 싣고 안전상태를 점검한다. 데킹장비의 조작스위치 및 레버를 조작하여 케이지문을 닫고 권양기조종원에게 신호하여 권양기를 운행하도록 하거나 자동으로 케이지를 올린다. 출발상태를 확인하고 광차의 대수 또는 운반물품을 기록한다. 사갱(斜坑,Inclined Shaft)의 레일에 의한 광차를 권양할 경우 광차의 연결상태를 점검하고 권양기로프와 궤도차량을 연결한다. 권양기조종원에게 신호를 보내 광차를 운행하도록 한다. 분기레일의 전철기를 조작하여 운행하고, 광차에 편승하여 운반물이 목적지에 하차되도록 신호한다. 광석·자재·장비·인원 등의 승·하차를 유도하고 안전상태를 점검·감시한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"시범후 30일 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","similarNm":"권양기운전보조원, 권양기신호원","dJobECd":"6230","dJobECdNm":"[6230]물품이동장비 조작원(크레인·호이스트·지게차)","dJobJCd":"8740","dJobJCdNm":"[8740]물품 이동 장비 조작원","dJobICd":"B051/B061/B062","dJobICdNm":"[B051]석탄 광업 / [B061]철 광업 / [B062]비철금속 광업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003595:1', '{"dJobCd":"K000003595","dJobCdSeq":"1","dJobNm":"권양기조종원","workSum":"광산이나 채석장의 사갱이나 수갱에서 작업원·광석·맥석·자재 등을 운반하는 케이지(Cage)·스킵(Skip)·광차를 끌어 올리고 내리는 권양기를 운전한다.","doWork":"기아박스의 오일케이지, 베어링 및 클러치의 윤활유 주입상태, 회전부의 회전상태를 확인한다. 브레이크, 클러치기어, 와이어로프 상태를 점검한다. 스위치를 작동시켜 각종 계기판을 점검하고 신호연락장치를 점검한다. 출발신호가 오면 조절레버 및 페달을 작동하고, 브레이크를 풀어 서서히 가속시킨다. 원하는 위치에 도착하였는지 확인하기 위하여 심도지시계기 및 케이블 또는 드럼의 표시기를 주시하고, 정위치에 도착시키기 위해 브레이크 및 콘트롤레버를 조작하여 서서히 정지시킨다. 계기판을 보고 과부하 상태를 확인한다. 인터폰 및 전화로 갱내상태를 수시로 확인한다. 작업종료 신호에 따라 모든 스위치를 시동역순으로 차단하고 점검한다. 보안사항을 점검하고 다음 교대원에게 인계한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"조작운전","similarNm":"권양기운전원, 스킵운전원, 케이지운전원, 데킹원, 권양기승회부(乘廻夫)","dJobECd":"6230","dJobECdNm":"[6230]물품이동장비 조작원(크레인·호이스트·지게차)","dJobJCd":"8740","dJobJCdNm":"[8740]물품 이동 장비 조작원","dJobICd":"B051/B061/B062","dJobICdNm":"[B051]석탄 광업 / [B061]철 광업 / [B062]비철금속 광업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003056:1', '{"dJobCd":"K000003056","dJobCdSeq":"1","dJobNm":"기중기조종반장","workSum":"작업계획을 세우고 각종 기중기조종원의 활동을 지시·감독한다.","doWork":"제품·반제품·중간소재·재료 등의 중량물을 필요한 위치와 목적에 따라 운반·교환·장입·적재하기 위한 작업계획을 세운다. 기중기조종원 등의 작업원에게 작업지시를 한다. 경우에 따라서는 기중기운전을 직접 수행하기도 한다. 기중기조종원 등의 작업원에게 직무교육 및 안전위생교육을 실시하여 직무수행능력을 향상시키고 안전재해를 예방한다. 작업원을 수시로 관찰하여 애로 및 건의 사항을 수렴·해결하고 문제점을 보고한다. 각종 설비점검을 통하여 보수사항을 파악하고 관련 부서에 수리의뢰를 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"조작운전","similarNm":"기중기운전반장","connectJob":"운전하는 기중기의 종류에 따라 천정기중기운전반장, 용강기중기운전반장, 자석기중기운전반장","certLic":"기중기운전기능사, 천장크레인운전기능사","dJobECd":"6230","dJobECdNm":"[6230]물품이동장비 조작원(크레인·호이스트·지게차)","dJobJCd":"8740","dJobJCdNm":"[8740]물품 이동 장비 조작원","dJobICd":"F426","dJobICdNm":"[F426]건설장비 운영업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007257:1', '{"dJobCd":"K000007257","dJobCdSeq":"1","dJobNm":"기중기조종원","workSum":"고층건축물, 토목건축물 등의 건설공사에서 흙, 모래, 골재, 목재, 철재 등의 자재와 건설장비를 견인·인양·이동·적재하는 기중기를 운전한다.","doWork":"작업지시서에 따라 이동시킬 물품의 종류·위치 등을 확인한다. 작업목적에 따라 부대품을 선택하고 수공구를 사용하여 붐(Boom)에 작업장치를 조립·설치하고 점검 일지에 명시된 사항을 점검한다. 시동순서에 따라 엔진을 시동한다. 레버를 조작하여 기중기방향을 조종하고 작업장소로 운전한다. 작업 중 안전사고를 방지하기 위하여 기중기의 수평상태를 확인하고 정차시킨다. 운반물의 고정상태를 확인하고 기중기신호수의 신호에 따라 붐을 상승·회전·이동·하강시켜 운반물을 작업목적에 따라 이동시킨다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"시각|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","similarNm":"크레인운전원, 기중기운전원","connectJob":"기중기의 종류에 따라 자석크레인조종원, 지브크레인조종원, 천정크레인조종원, 크로크레인조종원, 타워크레인조종원, 하이크레인조종원, 오가크레인조종원","certLic":"기중기운전기능사, 천장크레인운전기능사, 타워크레인운전기능사","dJobECd":"6230","dJobECdNm":"[6230]물품이동장비 조작원(크레인·호이스트·지게차)","dJobJCd":"8740","dJobJCdNm":"[8740]물품 이동 장비 조작원","dJobICd":"F426","dJobICdNm":"[F426]건설장비 운영업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003742:1', '{"dJobCd":"K000003742","dJobCdSeq":"1","dJobNm":"동력윈치조작원","workSum":"건축이나 토목공사 시 지상에 있는 모래·벽돌·시멘트 등의 건설자재를 지하 또는 고층높이로 운반하기 위하여 줄을 감아주는 견인·인양장치를 조작한다.","doWork":"버튼이나 스타칭을 눌러 원동기 시동을 건다. 와이어로프를 풀어 상부작업자에게 인계한다. 신호원의 신호를 받기 위해 신호수를 주시한다. 신호원의 수신호에 의해 건설자재를 상부로 올리거나 하부로 내린다. 작업완료 후 작업장비를 정리한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실외","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","dJobECd":"6230","dJobECdNm":"[6230]물품이동장비 조작원(크레인·호이스트·지게차)","dJobJCd":"8740","dJobJCdNm":"[8740]물품 이동 장비 조작원","dJobICd":"F411/F412/F421","dJobICdNm":"[F411]건물 건설업 / [F412]토목 건설업 / [F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007259:1', '{"dJobCd":"K000007259","dJobCdSeq":"1","dJobNm":"리프트조작원","workSum":"스키어들을 슬로프(Slope)의 정상까지 운반하기 위하여 리프트를 조작·운행한다.","doWork":"전원스위치를 넣고, 운전판넬의 램프를 확인한다. 브레이크의 유압을 점검하고 스위치를 조작하여 브레이크의 유압을 적정하게 맞춘다. 스위치를 조작하여 의자가 매달려 있는 케이블의 장력을 조절한다. 케이블의 상태, 의자상태 등을 점검한다. 속도조절 키를 조작하여 속도를 조절한다. 안전장치의 키를 확인하고 리프트를 출발시킨다. 리프트의 작동상태를 주시한다. 정전 시 정전을 변전실에 통보하여 자가발전기를 가동하도록 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","similarNm":"리프트운전원","certLic":"교통안전관리자, 산업안전산업기사","dJobECd":"6230","dJobECdNm":"[6230]물품이동장비 조작원(크레인·호이스트·지게차)","dJobJCd":"8740","dJobJCdNm":"[8740]물품 이동 장비 조작원","dJobICd":"R912","dJobICdNm":"[R912]유원지 및 기타 오락관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003235:1', '{"dJobCd":"K000003235","dJobCdSeq":"1","dJobNm":"배재원","workSum":"선박 및 해양시설 건조 시 각 공정에 필요한 원부자재를 크레인, 지게차 등을 이용하여 투입한다.","doWork":"현장공정표, 자재투입신청표에 따라 입출고할 자재의 수량, 무게, 시간, 적재장소, 투입장소, 이송장비 등을 숙지한다. 투입할 자재의 종류와 수량을 바코드, 일련번호, 꼬리표 등을 통해 확인한다. 자재운반을 위해 크레인, 지게차, 차량 등을 사전에 확보한다. 투입순서에 따라 자재를 크레인, 지게차, 차량 등을 이용하여 각 공정에 정확히 투입하고 목록을 작성한다. 물류관리 시스템의 휴대용 원격단말기를 조작하여 자재의 입출고를 전산 입력하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"손사용|","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"조작운전","similarNm":"부재운반원, 자재운반원","certLic":"기중기운전기능사, 지게차운전기능사, 천장크레인운전기능사","dJobECd":"6230","dJobECdNm":"[6230]물품이동장비 조작원(크레인·호이스트·지게차)","dJobJCd":"8740","dJobJCdNm":"[8740]물품 이동 장비 조작원","dJobICd":"C311","dJobICdNm":"[C311]선박 및 보트 건조업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005398:1', '{"dJobCd":"K000005398","dJobCdSeq":"1","dJobNm":"선거작업반장","workSum":"선박 및 해양시설을 건조, 보수하기 위하여 선박의 입·출거 작업 및 반목조정, 설치하는 선거작업원의 활동을 감독·조정한다.","doWork":"도면 또는 작업명세서를 분석하고 선박을 받쳐줄 수 있는 용골 및 반목의 크기·모양·수량을 결정한다. 선거작업원에게 지시하여 받침대·레일·보호판 등을 설치·조립한다. 전경의(Transit:망원경과 눈금판을 갖춘 정밀한 측각기구)를 사용하여 배를 놓을 기준점을 측정한다. 선거작업원의 선박정렬을 감독한다. 선박의 진수, 이동, 의장안벽시운전(艤裝岸壁:독 구내의 안벽(岸壁,Quay Wall)에서 이루어지는 선박시험) 등을 지원한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"시각|","workEnv":"위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","dJobECd":"6230","dJobECdNm":"[6230]물품이동장비 조작원(크레인·호이스트·지게차)","dJobJCd":"8740","dJobJCdNm":"[8740]물품 이동 장비 조작원","dJobICd":"C311","dJobICdNm":"[C311]선박 및 보트 건조업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004736:1', '{"dJobCd":"K000004736","dJobCdSeq":"1","dJobNm":"선거작업원","workSum":"선박 및 해양시설을 건조하기 위하여 선거에 출입하는 선박의 양륙작업을 하고 반목가설, 조정 및 독 갑문의 개폐장치를 작동한다.","doWork":"도면 및 작업지시서를 읽고 클램프(금속재 집게), 로프 등 필요한 작업공구를 준비한다. 선박 입고 시 입고되는 선체의 도면을 참조하여 선거의 바닥에 반목을 놓고 조정한다. 입거선박이 독 내에 장치되면 중심선을 잡고 반목과 선체의 공간을 나뭇조각 등을 사용하여 괸다. 독의 갑문을 이동하여 닫고 배수작업을 한다. 기상악화로 안벽에 계류 중인 선박의 안전조치를 취한다. 해초나 낡은 페인트를 제거하기 위하여 선박의 외벽을 청소하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실외","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"선거원","dJobECd":"6230","dJobECdNm":"[6230]물품이동장비 조작원(크레인·호이스트·지게차)","dJobJCd":"8740","dJobJCdNm":"[8740]물품 이동 장비 조작원","dJobICd":"C311","dJobICdNm":"[C311]선박 및 보트 건조업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005492:1', '{"dJobCd":"K000005492","dJobCdSeq":"1","dJobNm":"용강기중기조종원","workSum":"강 레이들(Ladle)을 필요한 위치에 권상·권하하여 안착 및 이동하기 위한 용강기중기를 운전한다.","doWork":"작업지시서를 숙지하고 작업내용을 숙지한다. 기중기 및 관련 설비를 운전 전후 점검하여 이상 여부를 확인한다. 주유 및 시운전을 하고 고장 시 수리부서에 의뢰를 한다. 신호에 따라 출선된 레이들(Ladle)을 권상하여 전로에 용선장입, 슬래그 배재 및 운반작업을 위하여 용강기중기를 운전한다. 취련이 종료된 용강을 신호에 따라 운반, 안착, 이동하며 주조가 완료된 레이들을 운반, 배재한다. 출강된 용강을 신호에 따라 매주형별 주입위치로 이동시킨다. 슬래그 배재 및 포트(Pot)이동, 이동대차 상에 레이들을 운반하기 위하여 주입기중기를 운전한다. 일일작업량, 고장수리 및 점검사항 등을 기록 작성하여 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"시각|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"조작운전","similarNm":"용강기중기운전원","certLic":"천장크레인운전기능사","dJobECd":"6230","dJobECdNm":"[6230]물품이동장비 조작원(크레인·호이스트·지게차)","dJobJCd":"8740","dJobJCdNm":"[8740]물품 이동 장비 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001859:1', '{"dJobCd":"K000001859","dJobCdSeq":"1","dJobNm":"원목공급원","workSum":"원목을 제재하기 위하여 원목제재원의 지시에 따라 지게차나 윈치(Winch)를 사용하여 원목을 대차기나 제재기에 공급한다.","doWork":"원목(통나무)에 붙어있는 돌·쇠 등의 불순물을 갈고리나 칼 등의 공구를 사용하여 제거한다. 원목을 제재기에 공급하기 위하여 원목제재원의 지시에 따라 지게차를 운전하거나 윈치(Winch:로프를 원통에 감아올려 중량물을 끌어올리거나 도르래를 끼워 매다는 기중기의 일종)의 줄과 고리를 사용한다. 박피기조작원의 지시에 따라 박피기에 원목을 공급하거나 원목절단원의 지시에 따라 절단기에 원목을 공급하기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"조작운전","similarNm":"원목선별원","connectJob":"원목에 절단위치를 표시하는 경우 원목재단위치표시원, 작업하는 부서에 따라 출고검척원, 침목검척원","certLic":"지게차운전기능사","dJobECd":"6230","dJobECdNm":"[6230]물품이동장비 조작원(크레인·호이스트·지게차)","dJobJCd":"8740","dJobJCdNm":"[8740]물품 이동 장비 조작원","dJobICd":"C161","dJobICdNm":"[C161]제재 및 목재 가공업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004488:1', '{"dJobCd":"K000004488","dJobCdSeq":"1","dJobNm":"원목인양기조종원","workSum":"윈치나 집게차 등의 원목인양기를 운전하여 해상의 본선에 적재되어 있는 원목을 바지선에 적재하거나 혹은 바지선의 원목을 육상 원목야적장이나 트레일러에 적재한다.","doWork":"원목인양기보조원이 본선의 원목을 와이어로 윈치(Winch:로프를 원통에 감아올려 중량물을 끌어올리거나 도르래를 끼워 매다는 기중기의 일종)에 걸고 신호를 하면 스위치를 작동하여 원목을 바지선으로 들어 올린다. 또는 집게차로 원목을 집어서 육상 원목야적장이나 트레일러에 적재한다. 원목인양기보조원의 신호에 따라 레버를 밀거나 당겨서 원목을 적재된 방향에 맞추어 쌓는다. 야적장의 정리 및 재고원목의 품질의 균질화 등을 위해 적재된 원목을 다른 장소로 옮기기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"힘든 작업","workPlace":"실외","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"조작운전","similarNm":"원목인양기운전원","certLic":"기중기운전기능사","dJobECd":"6230","dJobECdNm":"[6230]물품이동장비 조작원(크레인·호이스트·지게차)","dJobJCd":"8740","dJobJCdNm":"[8740]물품 이동 장비 조작원","dJobICd":"C161","dJobICdNm":"[C161]제재 및 목재 가공업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003509:1', '{"dJobCd":"K000003509","dJobCdSeq":"1","dJobNm":"이송장비운전원","workSum":"석유화학제품 및 기타 화학제품을 제조하기 위해 각 공정에서 필요한 원·부자재를 파악하고 이를 필요한 부서에 이송시키는 장비를 조작·관리한다.","doWork":"각 생산부서로부터 요청을 받은 필요한 양의 원·부자재를 파악하고 준비를 한다. 작업지시서의 내용에 따라 압력·온도·진공·회전기계·밸브 등의 상태를 확인한다. 준비된 원·부자재를 저장탱크나 필요로 하는 생산부서에 이송하기 위하여 기계를 운전하고 밸브를 열어 전송한다. 작업이 완료되면 작업상황을 작업일지에 기록하고 운전 중 발생한 문제점을 파악한다. 주변을 정리·정돈하고 작업내용이나 특이사항 등을 교대 근무자에게 인수인계한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"조작운전","certLic":"화공산업기사, 위험물산업기사","dJobECd":"6230","dJobECdNm":"[6230]물품이동장비 조작원(크레인·호이스트·지게차)","dJobJCd":"8740","dJobJCdNm":"[8740]물품 이동 장비 조작원","dJobICd":"C201","dJobICdNm":"[C201]기초 화학물질 제조업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003494:1', '{"dJobCd":"K000003494","dJobCdSeq":"1","dJobNm":"입환원","workSum":"철도차량 제작 시 공정 간 또는 공장 간의 원활한 생산활동을 위하여 생산 중인 반제품 및 완성차량을 정해진 위치로 이동시킨다.","doWork":"작업지시서를 보고 생산 및 조립 중인 반제품 및 부분품의 공정 간 운반을 위해 리프트, 천장크레인, 트레바샤(바퀴의 제동장치) 및 안토카(레일 위를 움직이는 작은 궤도차량) 등을 이용하여 이동시킨다. 완제품의 경우 시험 및 검사(단차, 편성시험) 등을 위해 검사장 및 시운전 선로로 이동시킨다. 공정 간 반제품의 이동 시에는 로프를 이용하여 끌어당기고, 정지 시는 나무막대를 대차의 바퀴 밑에 깔아 정지시킨다. 작업지시에 따라 작업 후 발생되는 부분품의 조각이나 불필요한 부품 등의 일부를 작업장 밖으로 이송시킨다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"약간의 시범정도","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"조작운전","dJobECd":"6230","dJobECdNm":"[6230]물품이동장비 조작원(크레인·호이스트·지게차)","dJobJCd":"8740","dJobJCdNm":"[8740]물품 이동 장비 조작원","dJobICd":"C312","dJobICdNm":"[C312]철도장비 제조업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001437:1', '{"dJobCd":"K000001437","dJobCdSeq":"1","dJobNm":"적재기조작원","workSum":"생산된 제품을 일정 수량씩 자동으로 적재시키는 적재기(Loader)를 조작한다.","doWork":"적재기의 이상 유무를 점검한다. 제품의 크기나 형상에 따라 적재대의 간격을 조절한다. 생산제품의 출고되는 속도에 맞추어 적재기의 속도계기를 조정한다. 전원스위치를 넣어 기계를 가동시킨다. 적재되는 제품의 샘플을 선별하여 중량을 측정한다. 생산일지를 작성하여 생산부서에 제출한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"조작운전","dJobECd":"6230","dJobECdNm":"[6230]물품이동장비 조작원(크레인·호이스트·지게차)","dJobJCd":"8740","dJobJCdNm":"[8740]물품 이동 장비 조작원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007462:1', '{"dJobCd":"K000007462","dJobCdSeq":"1","dJobNm":"지게차운전원","workSum":"창고나 공장에서 원료나 자재, 제품 등을 하역, 운반, 적재하기 위해 지게차를 운전한다.","doWork":"운반, 하역 또는 적재할 물품을 확인한다. 장비의 부품이나 연료, 엔진오일 등을 점검하고 작동에 이상이 없는지 확인한다. 운반할 자재나 화물, 제품 등의 균형상태를 확인하고 틸트, 리프트 등의 레버, 포크 및 운전장치를 조작하여 화물을 들어 올리고 운반·적재한다. 작업이 종료되면 지게차에 이상이 없는지 확인하고 작업일지를 기록한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"손사용|","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","connectJob":"전동지게차운전원","certLic":"지게차운전기능사","dJobECd":"6230","dJobECdNm":"[6230]물품이동장비 조작원(크레인·호이스트·지게차)","dJobJCd":"8740","dJobJCdNm":"[8740]물품 이동 장비 조작원","dJobICd":"ALL","dJobICdNm":"[ALL]전체","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005140:1', '{"dJobCd":"K000005140","dJobCdSeq":"1","dJobNm":"천정기중기조종원","workSum":"제품·반제품 및 소재 등의 중량물을 필요한 위치와 목적에 따라 권상, 운반, 적치, 상차작업 등을 하기 위하여 천장기중기를 운전한다.","doWork":"작업지시서 및 기중기반장의 지시사항을 숙지하고 작업내용 및 목적, 작업특성 등을 파악한다. 기중기 및 주요 장비에 대하여 운전하기 전 또는 후 검사일지에 명시된 사항을 점검하고 시운전하며 고장 시 정비부서에 수리를 의뢰한다. 작업목적 및 특성에 따라 기중기의 부대품을 선택하고 수동공구 및 장비를 이용하여 붐(Boom)에 작업장치를 조립하거나 설치한다. 작업지시에 따라 기중기의 조정기나 레버를 조작하여 상하좌우로 이동시켜 제품, 반제품 및 소재 등을 운반, 적재, 상차 등의 작업을 한다. 작업상황, 점검결과, 정비인력 등의 기록유지와 보고를 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"손사용|시각|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","similarNm":"천정기중기운전원","certLic":"기중기운전기능사, 천장크레인운전기능사","dJobECd":"6230","dJobECdNm":"[6230]물품이동장비 조작원(크레인·호이스트·지게차)","dJobJCd":"8740","dJobJCdNm":"[8740]물품 이동 장비 조작원","dJobICd":"F426","dJobICdNm":"[F426]건설장비 운영업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006680:1', '{"dJobCd":"K000006680","dJobCdSeq":"1","dJobNm":"컨테이너기중기조종원","workSum":"컨테이너를 선박이나 부두에 하역하기 위하여 기중기를 조작한다.","doWork":"하역할 컨테이너의 수량 및 규격을 확인하고 조정장치를 조작하여 기중기를 선박의 갑판이나 차량 위로 내린다. 조정레버와 패널을 조작하여 선박으로부터 컨테이너를 들어 올려 갑판 위나 차량으로 운반한다. 신호원의 신호에 따라 선적·하역할 장소에 기중기를 내리고 조정장치를 조작하여 컨테이너를 선박에 선적하거나 차량에 적재한다. 컨테이너를 부두에서 야적장으로 이동하는 차량인 리치스태커(Reach Stacker)를 운전하기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"손사용|시각|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"조작운전","similarNm":"트렌스퍼크레인조작원, 컨테이너기중기조작원","connectJob":"리치스테커조종원","certLic":"기중기운전기능사","dJobECd":"6230","dJobECdNm":"[6230]물품이동장비 조작원(크레인·호이스트·지게차)","dJobJCd":"8740","dJobJCdNm":"[8740]물품 이동 장비 조작원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004930:1', '{"dJobCd":"K000004930","dJobCdSeq":"1","dJobNm":"케이블카조작원","workSum":"승객 또는 화물을 일정 장소로 운반하기 위해 케이블카를 조작하고 설비를 정비한다.","doWork":"케이블카 운행 전에 승객의 안전을 위하여 시운전을 한다. 오일 및 기어 등을 확인하고 케이블카를 정비하여 이상 유무를 확인한다. 신호 및 폐쇄회로TV를 통해 승객의 탑승 여부를 확인하고 조작판넬 및 수동제어장치를 조작하여 케이블카를 출발 및 도착시킨다. 삭도(공중에 설치한 강철 선)설비를 정비한다. 케이블카의 운행상황을 주시하면서 작동상태를 확인한다. 일일 운행을 종료하면 조작판넬을 확인하고 기계의 이상 유무를 점검한 후 케이블카운영관리자에게 운행상황을 보고한다. 안전관리에 대하여 교육받는다. 고장 발생 시 부품을 교체하고, 중정비의 경우 전문업체에 정비를 요청한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"6230","dJobECdNm":"[6230]물품이동장비 조작원(크레인·호이스트·지게차)","dJobJCd":"8740","dJobJCdNm":"[8740]물품 이동 장비 조작원","dJobICd":"H492","dJobICdNm":"[H492]육상 여객 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003663:1', '{"dJobCd":"K000003663","dJobCdSeq":"1","dJobNm":"크레인조종원","workSum":"크레인을 작동하여 블록(Block), 철의장품 등의 중량물을 정해진 위치에 이동시킨다.","doWork":"작업지시서를 보고 운반할 블록을 확인한다. 크레인의 작동상태를 확인한다. 전원을 확인하고, 신호수와의 통신상태를 확인한다. 와이어로프와 새클(Shackel:연결용 쇠고랑)을 체결하고, 신호수의 신호에 따라 작업물을 권양한다. 작업장 주위의 상태, 주위 시설물 등을 고려하여 주의 깊게 이동한다. 신호수의 신호에 따라 정해진 위치에 놓는다. 작업이 종료되면 장비의 이상 유무를 확인하고 전원을 차단하여 크레인의 작동을 중지시킨다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"균형감각|","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","connectJob":"크레인의 종류에 따라 골리앗크레인조종원, 지브크레인조종원, 호이스트를 전문으로 운전하는 경우 호이스트조종원, 건설용호이스트조종원, 광산용호이스트조종원, 하차장호이스트조종원, 철강재호이스트조종원","certLic":"기중기운전기능사, 천장크레인운전기능사, 타워크레인운전기능사","dJobECd":"6230","dJobECdNm":"[6230]물품이동장비 조작원(크레인·호이스트·지게차)","dJobJCd":"8740","dJobJCdNm":"[8740]물품 이동 장비 조작원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003371:1', '{"dJobCd":"K000003371","dJobCdSeq":"1","dJobNm":"타워크레인조종원","workSum":"건축 공사 시 제품, 중간소재, 자재, 재료 등을 정해진 위치로 운반하거나 들어 올리는 건설장비인 타워크레인을 조종한다.","doWork":"작업하기 전에 이동시킬 물품의 종류 및 위치 등을 확인한다. 작업에 사용할 부대품을 선택하고 수공구를 이용하여 붐에 작업장치를 조립하거나 설치한다. 레버를 조작하여 타워크레인의 방향을 조종한다. 작업 중 안전사고를 방지하기 위해 기중기의 수평상태를 확인하고 정차시킨다. 운반물의 고정상태를 확인한 후 신호수의 신호에 따라 붐을 상승시키거나 회전, 이동 및 하강시켜 운반물을 목적 장소로 이동시키고 확인한다. 건물의 높이가 높아지는 정도에 따라 텔레스코핑게이지를 이용하여 공간을 만들고 마스트(Mast)를 넣어 타워크레인의 높이를 올리는 텔레스코핑(Telescoping) 작업을 하기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실외","physicalAct":"균형감각|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","similarNm":"타워크레인운전원","certLic":"타워크레인운전기능사","dJobECd":"6230","dJobECdNm":"[6230]물품이동장비 조작원(크레인·호이스트·지게차)","dJobJCd":"8740","dJobJCdNm":"[8740]물품 이동 장비 조작원","dJobICd":"F421","dJobICdNm":"[F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004614:1', '{"dJobCd":"K000004614","dJobCdSeq":"1","dJobNm":"하역기중기조종원","workSum":"철광석·석탄 등의 원료나 컨테이너 화물을 선박에 싣거나 내리기 위해 하역기중기를 운전한다.","doWork":"하역순서와 선적순서를 숙지한다. 기중기 및 주요 장비, 기중기의 붐(Boom)·밧줄·와이어로프 등의 안전성 여부에 대하여 운전하기 전 또는 후 검사일지에 명시된 사항을 점검하고 시운전하며 고장 시 정비부서에 수리를 의뢰한다. 조정기나 레버를 조작하여 기중기를 선박의 갑판이나 선창 위로 하강시킨다. 조정기를 조작하여 화물을 들어 올리고 부두나 선창 또는 갑판 위에 내려놓는다. 일일 작업량 및 수리점검 상황을 기록한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"손사용|","workEnv":"위험내재|고온|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","similarNm":"하역기중기운전원","certLic":"기중기운전기능사, 양화장치운전기능사","dJobECd":"6230","dJobECdNm":"[6230]물품이동장비 조작원(크레인·호이스트·지게차)","dJobJCd":"8740","dJobJCdNm":"[8740]물품 이동 장비 조작원","dJobICd":"F426","dJobICdNm":"[F426]건설장비 운영업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003799:1', '{"dJobCd":"K000003799","dJobCdSeq":"1","dJobNm":"하역윈치조종원","workSum":"선박으로부터 화물을 양화 또는 적화하기 위해 선박의 하역설비인 양화장치(지브크레인이나 데릭)을 운전한다.","doWork":"선박의 하역설비인 양화장치의 종류에 따라 데릭(Derrick), 지브크레인(Jib Crane), 쉽 겐트리 크레인(Ship Gantry Crane)의 안전상태를 점검한다. 화물의 중량을 파악하여 양화장치로 인양할 수 있는지를 검토한다. 운전실의 스위치의 작동상태를 파악한다. 육상작업자나 본선작업자가 인양한 화물을 매다는 로프 스링(Rope Sling) 고리를 양화장치의 훅(Hook)에 걸어주면 신호수의 신호에 따라 선박이나 육상측으로 인양한다. 목적지에 도착하면 육상이나 본선작업자가 훅에서 스링의 한쪽 고리를 제거하면 스링을 화물로부터 안전하게 빼낸다. 빈 스링을 원래 위치로 가져간다. 선박 측이나 감독자와 작업의 속도 등에 대해 협의한다. 아래 작업하는 작업자의 안전에 주의한다. 작업이 종료되면 작업내용을 작업일지에 기록하기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"조작운전","similarNm":"하역윈치조작원","connectJob":"지브크레인조종원, 데릭조종원, 갠트리크레인조종원","certLic":"양화장치운전기능사","dJobECd":"6230","dJobECdNm":"[6230]물품이동장비 조작원(크레인·호이스트·지게차)","dJobJCd":"8740","dJobJCdNm":"[8740]물품 이동 장비 조작원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005343:1', '{"dJobCd":"K000005343","dJobCdSeq":"1","dJobNm":"항공기지상조업장비운전원","workSum":"원활한 항공기 운항을 위해 지상조업에 필요한 장비를 운전·조작한다.","doWork":"항공화물, 급유, 세척, 유도, 청소, 기내용품 조달 등의 관련 업무인 지상조업 작업 내용을 확인한다. 항공기의 정기점검 시 필요한 전력을 공급하기 위해 전력공급장치를 가동한다. 엔진 정비 시 사용하는 엔진가동기, 항공기 내 환기 시 사용하는 환기 차량, 항공기 주방에 물을 공급하는 급수 차량, 오물 수거 차량, 항공기를 견인·유도하는 토잉트랙터, 화물 운송 및 탑재 시 사용하는 카고로더, 컨베이어 등을 운전하고 작동한다. 각종 장비의 가동상태를 점검하여 정상가동 여부를 확인하고 파손된 부위를 점검·수리하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","similarNm":"지상조업장비운전원","dJobECd":"6230","dJobECdNm":"[6230]물품이동장비 조작원(크레인·호이스트·지게차)","dJobJCd":"8740","dJobJCdNm":"[8740]물품 이동 장비 조작원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001837:1', '{"dJobCd":"K000001837","dJobCdSeq":"1","dJobNm":"화물탑재장비조작원","workSum":"항공기에 화물 및 기내용품을 탑재하기 위하여 카고로더(Cargo Loader)를 조작한다.","doWork":"화물의 종류와 수량을 확인하여 동원할 장비를 검토한다. 항공기의 높이까지 화물을 올리는 카고로더(Cargo Loader)를 조작하여 화물을 적재한다. 컨베이어를 가동하여 화물의 탑재작업을 지원한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"조작운전","connectJob":"로더운전원","dJobECd":"6230","dJobECdNm":"[6230]물품이동장비 조작원(크레인·호이스트·지게차)","dJobJCd":"8740","dJobJCdNm":"[8740]물품 이동 장비 조작원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005226:1', '{"dJobCd":"K000005226","dJobCdSeq":"1","dJobNm":"건설기계운전보조원","workSum":"건설공사 현장에서 작업 목적에 따라 각종 건설기계를 운전하는 운전원을 보조한다.","doWork":"수공구나 동력공구를 사용하여 각종 작업장치를 설치하고 부속품의 마모 및 손상유무를 확인한다. 물체나 건설자재 등을 인양하기 위하여 작업장치의 연결고리에 걸어준다. 건설기계를 일정방향으로 안전하게 유도하기 위하여 신호를 보낸다. 작업완료 후 각종 건설기계의 보관 및 관리를 위하여 이물질을 물로 씻어내고 정비한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실외","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"준설장비운전보조원, 중장비조수, 중장비조종보조원, 중장비운전조수, 중장비운전보조원","certLic":"건설기계조종사면허증(기계종류별)","dJobECd":"7040","dJobECdNm":"[7040]건설·채굴 기계 운전원","dJobJCd":"8750","dJobJCdNm":"[8750]건설 및 채굴기계 운전원","dJobICd":"F426","dJobICdNm":"[F426]건설장비 운영업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002417:1', '{"dJobCd":"K000002417","dJobCdSeq":"1","dJobNm":"굴착기조종사","workSum":"각종 현장에서 토사 및 자갈 등을 깍기, 쌓기, 메우기를 위한 이동수단으로 타이어식 또는 무한궤도식 있으며 작업장치인 백호나 셔블(Shovel)장치가 부착된 버킷 등이 장착된 굴착기를 조종한다.","doWork":"작업할 내용을 숙지하고 굴착작업을 원활하게 수행하기 위해 굴착기의 연료상태, 냉각수, 각종오일상태 및 작업장치의 작동상태 등을 작업 전에 확인한다. 작업장의 지형 및 환경에 따른 작업조건을 파악하여 작업방법을 결정한다. 굴착기 설치위치를 평탄상태로 유지하고 붐, 암(Arm), 버킷을 조작하여 굴토 및 덤프트럭 적재함에 하역하기 등을 위해 조작한다. 덤프트럭운전원과 신호를 주고받으며 굴착기를 조종한다. 굴착기 버킷을 조종하여 지면을 평탄하게 고른다. 포장도로나 콘크리트의 파쇄작업을 위해 버킷 대신 유압브레이커를 장착하여 조종한다. 작업 종료 후 장비를 점검한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","similarNm":"굴삭기운전, 굴삭기조종사, 굴착기운전, 굴착기조종원, 굴착기기사, 굴삭기기사, 백호기사","certLic":"굴착기운전기능사, 건설기계조종사면허증(굴착기, 3톤미만굴착기)","dJobECd":"7040","dJobECdNm":"[7040]건설·채굴 기계 운전원","dJobJCd":"8750","dJobJCdNm":"[8750]건설 및 채굴기계 운전원","dJobICd":"F426","dJobICdNm":"[F426]건설장비 운영업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003039:1', '{"dJobCd":"K000003039","dJobCdSeq":"1","dJobNm":"농기계운전원","workSum":"농가의 작업능률과 노동생산성을 향상시키기 위하여 한 가지 또는 그 이상의 동력농기계와 장비를 조작·운전한다.","doWork":"작업계획서에 명시된 사용기종·작업면적·작업소요시간·작업순서 등을 참조하여 각종 소요 자재를 준비한다. 사전에 운전. 조작요령과 안전수칙을 숙지한다. 농기계에 연료를 주입하고, 부품에 오일을 주입하거나 바르고 기계의 작동상태를 검사한다. 자동추진 밭갈이, 심기, 수확, 포장 또는 기타 특수용도에 필요한 장비를 기계에 부착한다. 작업의 종류에 맞는 기계를 선택하여 이랑을 만들고, 작물을 자르고, 뽑고, 파내고, 파종·탈곡·절단하고, 자루에 넣고 포장하는 기계를 조작 운전한다.작업일지에 기계종류·작업명·소요시간·능률 등을 기록한다. 기계의 고장 시 수리를 의뢰한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"손사용|시각|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"조작운전","similarNm":"농기기조작운전원, 농기계운전원","connectJob":"건조기운전원, 경운기운전원, 이앙기운전원, 콤바인운전원, 탈곡기운전원, 트랙터운전원, 파종기운전원","certLic":"농기계운전기능사","dJobECd":"7040","dJobECdNm":"[7040]건설·채굴 기계 운전원","dJobJCd":"8750","dJobJCdNm":"[8750]건설 및 채굴기계 운전원","dJobICd":"A014","dJobICdNm":"[A014]작물재배 및 축산 관련 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003823:1', '{"dJobCd":"K000003823","dJobCdSeq":"1","dJobNm":"대형착암기조작원","workSum":"광산에서 광물을 채취 또는 탐광을 하기 위하여 자체동력 또는 견인으로 이동할 수 있는 대형착암기를 조작하여 암반을 천공한다.","doWork":"채광반장으로부터 작업장, 천공위치 및 공배열 등을 지시받는다. 작업장으로 착암기를 이동하고 비트연마·주유·엔진상태 등을 점검하고 작업장의 안전상태를 확인한다. 압축공기 및 착암용수 호스를 연결하고 모터를 가동한다. 레버를 조정하여 천공각도를 조절한다. 압축공기밸브를 열고, 레버를 조절하여 천공을 한다. 일정한 깊이까지 더 뚫어야 할 경우 착암기의 위치를 다시 잡고 천공한다. 천공 후 로드의 길이에 따라 견본을 채취하거나, 발파를 위해 압축공기로 갱 내의 암분을 제거한다. 작업장을 정리하고, 장비를 안전한 장소로 대피시키거나 다음 작업장으로 이동시킨다. 작업 및 보안일지를 작성한다. 발파를 위해 화약 및 장비를 운반하고, 천공된 구멍에 화약을 장착하여 발파작업을 하기도 한다. 착암기의 분해·정비를 하기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"조작운전","similarNm":"광산착암기조작원, 착암용점보드릴기사","connectJob":"장공착암기조작원, 점보착암기조작원, 채석장착암기조작원, TBM기조작원, RBM기조작원","certLic":"천공기조종사면허증, 시추기기능사","dJobECd":"7040","dJobECdNm":"[7040]건설·채굴 기계 운전원","dJobJCd":"8750","dJobJCdNm":"[8750]건설 및 채굴기계 운전원","dJobICd":"B051/B061/B062","dJobICdNm":"[B051]석탄 광업 / [B061]철 광업 / [B062]비철금속 광업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003461:1', '{"dJobCd":"K000003461","dJobCdSeq":"1","dJobNm":"덤프트럭운전원","workSum":"토사 및 골재 등의 화물을 운반·적재하는 덤프기가 부착된 트럭을 운전한다.","doWork":"작업일정을 확인한 후 덤프트럭의 연료, 엔진오일 등의 누수 및 차량의 작동상태를 점검한다. 작업일정을 확인한 후 덤프트럭의 연료상태 및 오일, 냉각수 등의 누유수 및 차량의 작동상태를 점검한다. 차량을 운전하여 작업현장으로 이동한 후 정해진 장소에 정차시킨다. 굴삭기, 굴착버켓 등의 중장비에 의해 운반물이 덤프에 적재되면 적재량 및 적재높이를 확인한다. 굴착기, 로더 등의 건설기계에 의해 토사 등이 적재되면 적재량 및 적재 높이를 확인한다. 덮개 및 로프로 적재물을 고정시킨 후 적재장소까지 운전한다. 레버를 조작하여 덤프적재함의 재료를 후방이나 측방, 적재함 바닥 등으로 하역한 후 원위치시킨다. 작업 종료 후 차량에 이상이 없는지 확인하고 정비한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","similarNm":"덤프트럭기사","certLic":"자동차운전면허(대형)","dJobECd":"7040","dJobECdNm":"[7040]건설·채굴 기계 운전원","dJobJCd":"8750","dJobJCdNm":"[8750]건설 및 채굴기계 운전원","dJobICd":"H493","dJobICdNm":"[H493]도로 화물 운송업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006464:1', '{"dJobCd":"K000006464","dJobCdSeq":"1","dJobNm":"도로줄눈공","workSum":"마찰, 온도 및 습도의 영향에 따른 콘크리트 포장도로의 파손 방지를 위하여 일정 간격마다 가로 및 세로로 줄눈을 설치한다.","doWork":"콘크리트 도로를 바닥포창 시공한 후 일정 시간 동안 양생이 되면 줄눈을 설치할 위치마다 먹줄작업을 한다. 시방서나 설계도면에 표시된 깊이와 폭으로 도로를 절단한다. 일정한 강도로 양생이 되면 도로 상단의 커팅된 모서리를 각지지 않고 부드럽게 만들기 위해 모따기(공작물의 날카로운 모서리 또는 구석을 비스듬하게 깎는 것)한다. 물로 청소한 후 도로 방수를 위해 충전재(충진재) 및 실리콘을 넣는다. 기온변화로 커팅된 도로의 틈에 충전재(충진재)를 채우고, 실리콘의 접착력을 높이기 위해 프라이머를 바른다. 포장된 도로 등에 부대시설 및 보수를 용이하게 하기 위해 회전톱을 조작하여 절단표시선을 따라 아스팔트나 콘크리트를 절단한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"힘든 작업","workPlace":"실외","physicalAct":"웅크림|손사용|시각|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"도로줄눈원, 도로줄눈표시원, 도로줄눈표시공, 도로줄눈시공원, 도로줄눈시공기사","dJobECd":"7040","dJobECdNm":"[7040]건설·채굴 기계 운전원","dJobJCd":"8750","dJobJCdNm":"[8750]건설 및 채굴기계 운전원","dJobICd":"F412","dJobICdNm":"[F412]토목 건설업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007367:1', '{"dJobCd":"K000007367","dJobCdSeq":"1","dJobNm":"도저조종사","workSum":"각종 토목 및 건설공사현장에서 땅을 밀어내거나 평탄하게 고르기, 흙쌓기, 돌 등을 제거하는데 사용하는 도저 등을 조종한다.","doWork":"각종 공사현장, 채석 및 벌목작업 시 공사내용을 확인하고 작업에 적합한 부착장비를 선정한다. 틸트(Tilt), 트러니언(Trunnion) 등을 고정하여 연결시키고 장비의 작동상태, 연료, 오일 등을 점검한다. 작업현장의 지면상태를 확인하여 작업위치를 선정하고, 시동을 건 후 불도저를 조종한다. 작업지형에 따라 블레이드 조정레버를 조작하여 블레이드의 높이를 조절한다. 일정한 방향으로 반복 운전하며 암석, 토사, 눈 등을 적재하거나 운반·제거한다. 작업종료 후 장비에 붙어있는 흙과 물 등의 이물질을 제거하고 장비를 점검한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","similarNm":"도저기사, 불도저조종원","certLic":"건설기계조종사 면허증(불도저, 5톤미만불도저)","dJobECd":"7040","dJobECdNm":"[7040]건설·채굴 기계 운전원","dJobJCd":"8750","dJobJCdNm":"[8750]건설 및 채굴기계 운전원","dJobICd":"F426","dJobICdNm":"[F426]건설장비 운영업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002716:1', '{"dJobCd":"K000002716","dJobCdSeq":"1","dJobNm":"로더조종사","workSum":"지면 위에 각종 흙, 모래나 자갈 또는 폐기물 등을 운반차량 상차에 사용하는 로더(Loader)를 조종한다.","doWork":"작업 분량을 확인한 후 로더의 작업위치, 작업량 및 작업장소의 넓이를 고려하여 작업방법을 결정한다. 기관상태, 동력전달상태, 유압상태 등에 이상이 있는지 점검한 후 로더를 작동한다. 붐 레버와 버킷 레버를 조정하여 각종 원료를 퍼서 운반장비에 싣거나(상차) 호퍼에 투입한다. 작업 후에는 장비의 버킷, 타이어, 트랙의 마모상태, 엔진오일, 냉각수, 연료 등을 점검하고 보충한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","similarNm":"로우더운전원, 페이로우더운전원, 페이로더운전원, 로더운전원, 로더조종원, 로더조작원, 로더운전기사","certLic":"건설기계조종사면허증(로더, 5톤미만로더)","dJobECd":"7040","dJobECdNm":"[7040]건설·채굴 기계 운전원","dJobJCd":"8750","dJobJCdNm":"[8750]건설 및 채굴기계 운전원","dJobICd":"F426","dJobICdNm":"[F426]건설장비 운영업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003475:1', '{"dJobCd":"K000003475","dJobCdSeq":"1","dJobNm":"모터그레이더조종사","workSum":"도로, 활주로 및 제방 등 토목공사 시 토사나 자갈을 긁고 펼쳐 지표면을 일정한 높이로 평탄하게 고르는 그레이더를 운전·조작한다.","doWork":"작업 전에 모터 그레이더의 작동상태를 점검한 후 작업현장으로 이동하여 작업한다. 작업장 환경과 지면의 강도에 따라 땅을 깎거나 고르는 블레이드(날)와 차체 진행방향, 지면과의 교각인 추진각, 절삭각을 조정한다. 땅을 파 일구는 스캐리파이어(Scarifier:흙갈퀴)를 내려 노면의 잡초 및 나무뿌리 등을 제거하는 제근작업을 한다. 작업장의 지하매설물, 돌출암석 등을 확인하고 운전보조원의 수신호에 따라 그레이더를 조작하여 지면을 평탄하게 고른다. 배수로 구축 및 제방경사작업, 토사 살포작업, 자갈길의 유지·보수작업, 제설작업 등을 수행한다. 작업 후 장비를 점검하고 각종 계기의 마모 여부와 접속상태를 점검한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","similarNm":"모터그레이더 조종사","connectJob":"종류에 따라 기계식모터그레이더조종사, 승강기그레이더조종사, 유압식그레이더조종사, 폼그레이더조종사","certLic":"롤러운전기능사, 건설기계조종사면허증","dJobECd":"7040","dJobECdNm":"[7040]건설·채굴 기계 운전원","dJobJCd":"8750","dJobJCdNm":"[8750]건설 및 채굴기계 운전원","dJobICd":"F426","dJobICdNm":"[F426]건설장비 운영업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;