INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003851:1', '{"dJobCd":"K000003851","dJobCdSeq":"1","dJobNm":"도가니용융로조작원","workSum":"특수한 용도나 조성을 갖는 유리원료를 용융하거나, 소량의 제품 생산을 위하여 도가니용융로를 운전·조작한다.","doWork":"용융로의 버너를 점화하고 용융로가 서서히 가열될 수 있도록 불꽃의 세기를 조정한다. 사용치 않던 새 도가니는 미리 예열하여 사용 중 금이 가거나 깨지지 않도록 한다. 가마가 적정 온도까지 올라가면 버너의 불꽃을 강하게 조절하여 유리용융 온도까지 올려준다. 가열된 도가니에 소량의 파유리를 투입하고, 용융된 파유리가 도가니 바닥을 골고루 적실 수 있을 만큼 파유리를 넣는다. 삽으로 유리원료를 도가니에 투입한다. 투입된 원료가 용융되면 쇠막대로 용융유리를 찍어내고 쇠막대에서 떨어지는 유리물의 상태를 관찰하여 용융되지 않은 원료입자의 존재 여부를 확인한다. 투입된 유리가 완전히 용융되면 유리원료를 추가로 투입하여 용해정량에 맞춘다. 원료투입이 완료되면 용융된 유리물에 기포가 없어질 때까지 열을 가하는 청정작업을 한다. 청정되어 균질한 유리 상태가 되면 성형에 알맞은 점도를 얻을 수 있도록 서서히 냉각한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"힘든 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|고온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8261","dJobECdNm":"[8261]유리·유리제품 생산기계 조작원","dJobJCd":"8431","dJobJCdNm":"[8431]유리 제조 및 가공기 조작원","dJobICd":"C231","dJobICdNm":"[C231]유리 및 유리제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003736:1', '{"dJobCd":"K000003736","dJobCdSeq":"1","dJobNm":"렌즈검사원","workSum":"완성된 렌즈 및 프리즘이 작업지시서에 따라 가공되었는지 확인하기 위하여 렌즈 및 프리즘(Prism)을 검사한다.","doWork":"작업표준에 의하여 검사기준서 및 검사표준서를 준비하고 확인한다. 검사에 필요한 렌즈미터(Lens Meter) 등 도구 및 장비를 준비한다. 가공이 완료된 렌즈 및 프리즘의 파손, 흠, 기포, 광택도 등을 육안으로 검사한다. 렌즈미터를 사용하여 렌즈 도수, 축, 두께를 검사한다. 검사 중 먼지 또는 이물질을 알코올 및 면포로 닦아낸다. 렌즈에 따라 도수측정마크를 페인트로 표시하기도 한다. 검사에 합격한 렌즈는 포장공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"프리즘검사원","certLic":"광학기능사","dJobECd":"8261","dJobECdNm":"[8261]유리·유리제품 생산기계 조작원","dJobJCd":"8431","dJobJCdNm":"[8431]유리 제조 및 가공기 조작원","dJobICd":"C273","dJobICdNm":"[C273]사진장비 및 광학기기 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006702:1', '{"dJobCd":"K000006702","dJobCdSeq":"1","dJobNm":"렌즈멀티코팅원","workSum":"렌즈(플라스틱, 글라스 렌즈 기타 재질), 평판, 프리즘 등 다양한 광학 원재료를 다양한 증착기에 넣어 멀티코팅한다.","doWork":"멀티코팅 필요한 진공증착기, 세척기 등의 공구 및 장비를 준비한다. 작업할 렌즈를 세척걸이에 걸고 물과 세제를 이용하여 세척한다. 세척 후 렌즈돔(Dome)에 끼운 후 진공증착기에 넣는다. 진공이 되면 불화 마그네슘 등의 약품을 사용하여 온도, 증착시간 등의 작업조건을 설정하고 가열 증발시켜 렌즈표면을 증착한다. 렌즈의 볼록면과 오목면 양면에 교대로 수차례 코팅한다. 멀티코팅작업이 완료되면 렌즈의 멀티코팅 여부를 검사하고 적절한 조치를 취한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"렌즈코팅원, 멀티코팅(MT)기사, 멀티코팅기조작원, 렌즈AR 코팅원","certLic":"광학기능사","dJobECd":"8261","dJobECdNm":"[8261]유리·유리제품 생산기계 조작원","dJobJCd":"8431","dJobJCdNm":"[8431]유리 제조 및 가공기 조작원","dJobICd":"C273","dJobICdNm":"[C273]사진장비 및 광학기기 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003951:1', '{"dJobCd":"K000003951","dJobCdSeq":"1","dJobNm":"렌즈연마원","workSum":"렌즈연마기를 사용하여 렌즈를 연마하고 렌즈 구면에 광택을 낸다.","doWork":"작업지시서에 따라 연마할 렌즈의 규격, 수량 등을 확인한다. 연마에 필요한 광택패드, 자동연마기 등의 공구 및 장비를 준비한다. 베이스커브(Base Curve), 실린더커브(Cylinder Curve), 렌즈두께, 직경 등 연삭 조건을 입력하고 렌즈가 부착된 지그를 연마기에 부착하고 가공을 시작한다. 입력한 연산조건 시간이 지나면 치구와 렌즈를 분리하고 세척 후 렌즈의 연마정도를 명세서와 비교하여 검사한다. 유리렌즈의 경우 렌즈 테두리 면을 연마한다. 연마가 끝난 후 광택패드를 선정된 치구에 부착하고 연마기에 걸어 광택을 낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"렌즈면취원, 렌즈광택원, 렌즈정삭원, 렌즈황삭원, 렌즈중삭원","certLic":"광학기능사","dJobECd":"8261","dJobECdNm":"[8261]유리·유리제품 생산기계 조작원","dJobJCd":"8431","dJobJCdNm":"[8431]유리 제조 및 가공기 조작원","dJobICd":"C273","dJobICdNm":"[C273]사진장비 및 광학기기 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005427:1', '{"dJobCd":"K000005427","dJobCdSeq":"1","dJobNm":"렌즈접착원","workSum":"광학적 성능을 높이거나 렌즈의 왜곡을 줄이기 위한 광학기구를 만들기 위하여 렌즈 및 프리즘의 볼록면과 오목면을 접착한다.","doWork":"렌즈접착에 필요한 유리막대, 접착제, 건조로, 자외선편심모니터 등의 도구 및 장비를 준비한다. 조명 아래에서 접착시킬 오목렌즈와 볼록렌즈의 이물질 부착 여부를 검사하고 결합될 면을 용제, 솔 및 에어건(Air Gun)을 사용하여 이물질을 닦아낸다. 유리막대를 사용하여 접착표면에 접착제를 골고루 바른다. 접착할 렌즈들을 함께 누르면서 회전시켜, 접착면에 있는 기포를 제거한다. 접착시간 단축을 위해 결합된 광학기구를 일정 시간 동안 건조로에 넣어 굳힌다. 자외선편심모니터를 사용하여 렌즈의 접착 여부를 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"광학기능사","dJobECd":"8261","dJobECdNm":"[8261]유리·유리제품 생산기계 조작원","dJobJCd":"8431","dJobJCdNm":"[8431]유리 제조 및 가공기 조작원","dJobICd":"C273","dJobICdNm":"[C273]사진장비 및 광학기기 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006422:1', '{"dJobCd":"K000006422","dJobCdSeq":"1","dJobNm":"렌즈착색기조작원","workSum":"선글라스 혹은 연하게 착색을 필요로 하는 플라스틱 렌즈에 색상을 넣기 위하여 자동착색기를 조작한다.","doWork":"소비자가 원하는 색상 또는 작업명세서와 표준견본에 따라 렌즈의 착색 색상을 선정한다. 착색작업을 수행하기 위하여 물, 염료, 안정제 등의 원료를 준비하고 농도계, 초음파세척기, 착색기, 전기로 등의 장비를 점검한다. 물, 염료, 안정제를 혼합하여 필요한 색을 만든다. 색상에 따라 착색기의 온도, 가공시간 등 작업조건을 설정·입력한다. 렌즈를 렌즈걸이에 걸어 착색기에 집어넣는다. 일정 시간이 지난 후 착색기에서 렌즈걸이를 빼낸 후 농도계를 사용하여 검사한다. 표준견본의 색과 비교하여 착색품질을 확인한다. 초음파세척기에서 세척한 후 전기로에 넣고 가열하여 경화한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"안경렌즈착색원","certLic":"광학기능사","dJobECd":"8261","dJobECdNm":"[8261]유리·유리제품 생산기계 조작원","dJobJCd":"8431","dJobJCdNm":"[8431]유리 제조 및 가공기 조작원","dJobICd":"C273","dJobICdNm":"[C273]사진장비 및 광학기기 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003084:1', '{"dJobCd":"K000003084","dJobCdSeq":"1","dJobNm":"렌즈하드코팅원","workSum":"진공기계를 사용하여 플라스틱 렌즈나 프리즘의 표면에 하드막을 증착하거나 진공상태에서 렌즈의 표면에 반사 방지막을 입힌다.","doWork":"작업명세서에 따라 코팅할 플라스틱렌즈나 프리즘의 규격과 수량 등을 확인한다. 코팅작업에 필요한 초음파세척기, 고경도 실리콘계열 수지 등의 재료 및 장비를 준비한다. 물 또는 세제가 포함된 초음파세척기에 담가 세척한다. 연마된 렌즈나 프리즘을 렌즈돔(Dome)에 걸어 하드코팅이 되도록 고경도 실리콘계열 수지에 담가 코팅과정을 모니터링한다. 하드코팅 과정이 끝나면 이물질 여부 등 외관검사와 하드코팅 여부를 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"광학기능사","dJobECd":"8261","dJobECdNm":"[8261]유리·유리제품 생산기계 조작원","dJobJCd":"8431","dJobJCdNm":"[8431]유리 제조 및 가공기 조작원","dJobICd":"C273","dJobICdNm":"[C273]사진장비 및 광학기기 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002875:1', '{"dJobCd":"K000002875","dJobCdSeq":"1","dJobNm":"몰딩원","workSum":"유리제품 성형에 사용할 몰드를 수리하거나, 탈형이 용이하도록 몰드(Mold)의 안벽에 코르크(Cork)막을 입힌다.","doWork":"작업지시서에 따라 성형작업에 사용된 몰드 중 수리 및 점검할 몰드를 구분하여 수거한다. 수거한 몰드를 작업대로 운반한다. 세척액, 브러시, 부식액, 코르크 등 원료와 장비를 준비한다. 몰드를 일반 세척액에 넣고 끓인다. 몰드를 꺼내고 브러시로 문질러 세척한다. 부식액(인스턴트 러스트)에 일정 시간 담근 후 꺼내어 가열 건조한다. 가열된 몰드에 실리콘오일 등 몰드용 오일을 바른 후 코르크를 주입하고 몰드를 흔든다. 코르크막 생성작업이 완료되면 전기로에 넣어 규정온도에서 일정 시간 소성한다. 몰드를 꺼내어 냉각하고 검사를 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"유리형틀관리원","dJobECd":"8261","dJobECdNm":"[8261]유리·유리제품 생산기계 조작원","dJobJCd":"8431","dJobJCdNm":"[8431]유리 제조 및 가공기 조작원","dJobICd":"C231","dJobICdNm":"[C231]유리 및 유리제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006052:1', '{"dJobCd":"K000006052","dJobCdSeq":"1","dJobNm":"방사로조작원","workSum":"용융유리물을 가는 섬유상태로 뽑아내는 방사로를 운전·조작한다.","doWork":"작업지시서에 따라 성형할 유리섬유의 규격과 양을 확인한다. 방사로의 연료 및 윤활장치와 작동 여부를 확인한다. 방사로의 상부층에 있는 용융로의 유리용융 상태를 광고온계(Pyrometer)를 사용하여 육안으로 확인한다. 방사로의 전원스위치를 넣는다. 방사로의 온도가 작업에 적당한 온도가 될 때까지 온도를 올린다. 조작 스위치를 작동하여 방사로 상부층의 용융유리물을 투입한다. 백금부싱(Bushing)을 통해 성형이 되어 인출되는 필라멘트(장섬유)를 정렬한다. 다수의 필라멘트를 한 가닥으로 묶어 메인(Strand)가닥을 만들기 위하여 집속제(Sizing)를 살포한다. 고무롤러의 가동스위치를 넣어 방사된 유리섬유를 인출한다. 실측한 자료 및 계기판을 통해 나타난 수치를 통해 노의 온도와 인출되는 섬유의 굵기를 수시로 확인하고 컨트롤 패널을 통해 적정상태로 유지하며 관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|고온|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8261","dJobECdNm":"[8261]유리·유리제품 생산기계 조작원","dJobJCd":"8431","dJobJCdNm":"[8431]유리 제조 및 가공기 조작원","dJobICd":"C231","dJobICdNm":"[C231]유리 및 유리제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003256:1', '{"dJobCd":"K000003256","dJobCdSeq":"1","dJobNm":"복층유리압착기조작원","workSum":"조립된 스페이서(Spacer)와 유리를 압착시키기 위하여 프레스를 조작한다.","doWork":"작업지시서에 따라 가공할 복층유리의 종류와 구성비를 확인한다. 가공할 복층유리의 수량에 따라 재료인 판유리의 수량과 스페이서(Spacer:라이너, 유리의 양면을 고정하기 위한 틀)의 수량을 계산한다. 프레스 및 자동롤러의 작동 여부 및 그 외 부속장치를 점검한다. 구성비에 따라 유리간격 등의 수치를 입력기에 입력한다. 롤러에 판유리를 투입하여 세척기를 통과한다. 세척된 유리의 마킹부위에 스페이서를 넣고 양쪽으로 유리를 압착하여 붙인다. 압착기를 통과시켜 유리와 스페이서를 압착한다. 압착된 복층유리의 밀폐상태와 규격을 작업명세서와 비교, 검토한다. 완성된 복층유리의 수량 등을 작업표에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"복층유리제조원","dJobECd":"8261","dJobECdNm":"[8261]유리·유리제품 생산기계 조작원","dJobJCd":"8431","dJobJCdNm":"[8431]유리 제조 및 가공기 조작원","dJobICd":"C231","dJobICdNm":"[C231]유리 및 유리제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002338:1', '{"dJobCd":"K000002338","dJobCdSeq":"1","dJobNm":"부틸기조작원","workSum":"복층유리 제조 시 유리 양면 사이에 알루미늄 스페이서(Spacer)를 부착하기 위하여 양면에 접착제를 칠하는 부틸기를 운전·조작한다.","doWork":"작업명세서에 따라 부틸작업을 할 스페이서의 종류와 규격을 확인한다. 부틸작업을 할 스페이서의 수량에 따라 접착제의 양을 계산한다. 접착제의 양이 충분한지를 점검한다. 부틸기의 윤활유 및 오일상태와 온도, 압력, 노즐상태 및 작동 여부를 점검한다. 부틸기를 시험가동하고 시료에 접착제를 시험도포하여 이상 유무를 확인한다. 스페이서를 부틸기의 자동컨베이어 롤러작업대 위에 올려놓는다. 롤러컨베이어를 작동하여 부틸기에 투입한다. 부틸기를 통과하여 나오는 스페이서의 접착제 도포형태를 확인한다. 부틸작업이 완료된 스페이서를 적재하여 경화시킨다. 부틸기의 노즐을 청소한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"부틸작업원","dJobECd":"8261","dJobECdNm":"[8261]유리·유리제품 생산기계 조작원","dJobJCd":"8431","dJobJCdNm":"[8431]유리 제조 및 가공기 조작원","dJobICd":"C231","dJobICdNm":"[C231]유리 및 유리제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003386:1', '{"dJobCd":"K000003386","dJobCdSeq":"1","dJobNm":"서냉로조작원","workSum":"유리의 표면응력 등 열변형을 제거하기 위하여 유리 성형품을 재가열하고 서서히 냉각시키는 서냉로를 운전·조작한다.","doWork":"서냉작업 할 성형품을 수령하고 작업명세서에 따라 제품의 서냉 온도범위를 파악한다. 서냉점(Annealing Point)과 스트레인점(Strain Point) 사이의 온도범위로 일반 플로트(Float)유리의 서냉범위(480~550℃)와, 서냉로의 상태 및 롤러장치를 점검하고 연료장치의 연료공급 상태를 확인한다. 작업명세서의 서냉온도에 따라 온도조절기를 조작한다. 버너(Burner)를 점화하고 조정하여 서냉로 각 구간의 온도를 조절한다. 대차나 손으로 컨베이어(Conveyer)에 서냉할 제품을 적재하여 서냉로에 투입한다. 대차나 컨베이어의 이동속도를 제품의 서냉 특성에 따라 적절하게 조정한다. 서냉로에 장착된 온도계를 수시로 관찰하며 온도분포가 일정하게 유지되는지 확인하고 필요에 따라 버너의 불꽃을 조절하거나 댐퍼(Damper)를 열어 온도를 조정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|고온|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"유리서냉로조작원","dJobECd":"8261","dJobECdNm":"[8261]유리·유리제품 생산기계 조작원","dJobJCd":"8431","dJobJCdNm":"[8431]유리 제조 및 가공기 조작원","dJobICd":"C231","dJobICdNm":"[C231]유리 및 유리제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001357:1', '{"dJobCd":"K000001357","dJobCdSeq":"1","dJobNm":"슬리브제조원","workSum":"형광등 및 이화학용 관유리 성형에 사용되는 슬리브(Sleeve)의 제조를 위해 주원료인 뮬라이트 및 부원료를 배합, 성형, 가공, 소성, 조립하는 작업을 한다.","doWork":"작업지시서에 따라 제조할 슬리브(Sleeve)의 규격 및 치수를 확인한다. 뮬라이트 등 조합할 원료를 준비한다. 슬리브성형기, 토련기, 진공토련기 등 장비 및 장치의 작동을 점검한다. 원료를 작업표준에 의해 입도별로 배합하여 물로 반죽한 후 토련기에 투입한다. 진공토련기에 넣어 반복하여 작업한다. 슬리브성형기에 원료를 투입하여 성형기를 회전시키며 성형한다. 성형된 슬리브를 규격에 맞추어 두부와 동체를 접합한다. 접합이 끝난 슬리브를 일정 시간 경과시켜 접합을 견고하게 한다. 경화된 슬리브를 치공구에 끼운 후 슬리브 표면을 다듬질한다. 슬리브가 완전히 경화될 때까지 건조한다. 완전 경화된 슬리브의 선단부(Tip)를 작업표준에 의하여 선반으로 절삭하고 자연상태에서 완전 건조한다. 건조된 슬리브를 저온소성(가소)한다. 완성된 슬리브의 가공상태를 검사한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8261","dJobECdNm":"[8261]유리·유리제품 생산기계 조작원","dJobJCd":"8431","dJobJCdNm":"[8431]유리 제조 및 가공기 조작원","dJobICd":"C231","dJobICdNm":"[C231]유리 및 유리제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002017:1', '{"dJobCd":"K000002017","dJobCdSeq":"1","dJobNm":"시멘트휠라기조작원","workSum":"유리구와 접착을 하기 위해 자동 및 반자동기계를 사용하여 금속베이스의 내부에 접착제를 충진한다.","doWork":"시멘트휠라기의 접착제 탱크에 접착제를 투입하고 금속베이스를 기계의 공급대에 놓는다. 접착제가 한 번에 규정량만큼 누출되도록 밸브를 조정한다. 기계를 가동하고 규정된 양의 접착제가 금속베이스의 내부에 골고루 발라지는가를 확인한다. 접착제가 충진된 금속베이스를 저장통에 담는다. 베이스의 견본을 조사해서 도포된 접착제의 양과 도포상태를 검사한다. 작업명세서에 따라 접착제를 직접 손으로 바르기도 한다. 충진이 된 금속베이스를 유리구와 결합시키기 위한 공정으로 이동한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"시멘트도포원","connectJob":"시멘트배합원","dJobECd":"8261","dJobECdNm":"[8261]유리·유리제품 생산기계 조작원","dJobJCd":"8431","dJobJCdNm":"[8431]유리 제조 및 가공기 조작원","dJobICd":"C284","dJobICdNm":"[C284]전구 및 조명장치 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003127:1', '{"dJobCd":"K000003127","dJobCdSeq":"1","dJobNm":"유리가압성형기조작원","workSum":"컵, 병, 재떨이 등의 단순한 형상의 유리제품의 성형을 위해 수동 가압성형기를 조작한다.","doWork":"작업지시서에 따라 성형물의 규격과 모양 등을 확인한다. 성형할 기물에 맞는 금형 및 몰드(Mold)를 성형기에 설치한다. 가압성형기를 예열한다. 용해로에서 용융된 유리를 철봉 끝에 찍어내어 성형작업대로 운반한다. 몰드 안의 캐비티(Cavaty:구멍)에 유리물을 가위로 잘라 떨어뜨린다. 성형기의 가압 핸들을 내려 유리 용융물이 유동상태로 되어 캐비티 안에 골고루 퍼지도록 압착성형한다. 적당한 경화시간 이후 몰드의 윗부분을 분리하고 성형된 유리기물을 집게로 떼어낸다. 기물의 형태나 필요에 따라 일차 성형된 기물을 이차 성형기에 넣어 반복해서 성형하기도 한다. 성형물을 검사하고 이상이 없으면 다음 공정으로 이송한다. 성형기의 몰드에 스프레이로 이형제를 뿌려주기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|고온|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"유리성형기조작원, 유리압연기조작원","connectJob":"곡유리제작원","dJobECd":"8261","dJobECdNm":"[8261]유리·유리제품 생산기계 조작원","dJobJCd":"8431","dJobJCdNm":"[8431]유리 제조 및 가공기 조작원","dJobICd":"C231","dJobICdNm":"[C231]유리 및 유리제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001547:1', '{"dJobCd":"K000001547","dJobCdSeq":"1","dJobNm":"유리광택기조작원","workSum":"유리제품에 광택을 내기 위하여 광택용 탱크를 조작·관리하며, 라미네이팅(Laminating)방법을 사용하기도 한다.","doWork":"작업지시서에 따라 광택작업할 유리의 규격 및 수량을 확인한다. 작업표준에 따라 탱크에 적당량의 물을 채우고 황산 및 적철석 등 광택원료를 계량하여 탱크에 혼합하여 투입한다. 광택에 필요한 물탱크의 작동 여부를 확인한다. 증기밸브를 조절하여 탱크 안의 광택액 온도를 조절한다. 혼합된 용액을 농도측정기를 이용하여 측정하고 적정 비중을 유지한다. 제품이 부딪혀 깨지는 것을 방지하기 위하여 탱크에 제품을 하나씩 넣는다. 탱크의 문을 닫고 일정 시간 유지한다. 일정 시간이 경과하면 광택액을 배출하고 물로 세척한다. 작업이 완료된 유리를 적재한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"유리취주기조작원","dJobECd":"8261","dJobECdNm":"[8261]유리·유리제품 생산기계 조작원","dJobJCd":"8431","dJobJCdNm":"[8431]유리 제조 및 가공기 조작원","dJobICd":"C231","dJobICdNm":"[C231]유리 및 유리제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005685:1', '{"dJobCd":"K000005685","dJobCdSeq":"1","dJobNm":"유리섬유성형원","workSum":"유리섬유의 성형을 위하여 유리제품 성형기계를 운전, 조작한다.","doWork":"작업명세서에 따라 성형제조 할 유리섬유의 규격과 수량을 확인한다. 컨베이어와 열풍순환 팬의 전원스위치를 넣어 작동시키고, 건조로 버너의 공기 및 연료의 유입량을 조정한다. 노 안의 온도를 규정온도까지 서서히 올린다. 제품의 두께에 따라 컨베이어의 진행속도를 조정하고 가이드롤러(Guide Roller)의 간격을 조정하여 제품의 폭을 맞춘다. 자동절단기의 상태를 점검하고, 권취속도 조절기를 조정한다. 각 롤러와 벨트컨베이어를 가동한다. 성형할 제품규격에 따라 길이 계수기를 조절하고 자동절단기를 조정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|고온|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"유리인발기조작원","connectJob":"유리섬유사출원","dJobECd":"8261","dJobECdNm":"[8261]유리·유리제품 생산기계 조작원","dJobJCd":"8431","dJobJCdNm":"[8431]유리 제조 및 가공기 조작원","dJobICd":"C231","dJobICdNm":"[C231]유리 및 유리제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001620:1', '{"dJobCd":"K000001620","dJobCdSeq":"1","dJobNm":"유리섬유용융로조작원","workSum":"유리장섬유 제조에 사용되는 유리원료를 용해하고 방사로에 투입하여 유리섬유를 결속시키는 유리섬유용융로 기계를 운전·조작한다.","doWork":"작업지시서에 따라 제조할 유리섬유의 양을 확인한다. 용융로의 연료장치와 가동 여부를 확인한다. 유리용해로의 버너를 점화한다. 버너에 투입되는 연료량 및 공기량을 조절하여 가열온도를 조정한다. 작업표준에 따라 시간간격에 맞추어 작업온도까지 온도를 올린다. 용해상태가 적당히 유지되도록 용해로의 각종 게이지를 조정하고 유지한다. 유리원료가 적당히 용융되면 용융유리를 부싱(Bushing:유리물의 출량조절 장치)으로 보내고, 스피너(Spinner:유리물을 분사하는 장치)를 일정하게 회전시켜 용융유리를 분사하여 필라멘트로 성형한다. 섬유화(필라멘트)된 유리에는 적당량의 접착제 또는 집속제를 분사하여 집면부위에 떨어지도록 하여 스트랜드(Strand)로 성형한다. 완성된 유리섬유를 직조하기 위하여 다음 공정으로 보낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|고온|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8261","dJobECdNm":"[8261]유리·유리제품 생산기계 조작원","dJobJCd":"8431","dJobJCdNm":"[8431]유리 제조 및 가공기 조작원","dJobICd":"C231","dJobICdNm":"[C231]유리 및 유리제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006744:1', '{"dJobCd":"K000006744","dJobCdSeq":"1","dJobNm":"유리세척기조작원","workSum":"제품 규격에 맞추어 절단된 판유리, 분리렌즈 등을 세척하고 건조하기 위하여 세척기를 운전·조작한다.","doWork":"작업지시서에 따라 세척할 유리의 종류 및 형태, 규격을 확인한다. 세척기의 브러시, 스펀지, 순환펌프, 분사노즐, 건조기의 상태와 세척수, 윤활유, 오일 등을 점검하며 작동 여부를 확인한다. 세척수의 오염도를 판정하고 보충하거나 교환한다. 작업표준에 맞게 세척할 유리의 두께에 따라 자동두께 조절장치를 조작하거나, 두꺼운 유리를 세척 시 수동두께 조절장치를 조작하여 세척 브러시 및 스펀지의 상하 높이를 조절한다. 세척할 유리를 세척기의 컨베이어 작업대 위에 올린다. 전원을 켜고 세척기를 작동하여 유리를 세척한다. 육안으로 세척과정을 주시하며 관찰한다. 건조기를 가동하여 세척된 유리를 건조한다. 세척, 건조된 유리의 오염도를 육안으로 검사한다. 완성된 유리에 종이, 스티로폼 등으로 파손방지 처리하여 적재한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8261","dJobECdNm":"[8261]유리·유리제품 생산기계 조작원","dJobJCd":"8431","dJobJCdNm":"[8431]유리 제조 및 가공기 조작원","dJobICd":"C231","dJobICdNm":"[C231]유리 및 유리제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004945:1', '{"dJobCd":"K000004945","dJobCdSeq":"1","dJobNm":"유리수지배합원","workSum":"유리면 보온재의 성형을 위해 접착제(Phenol:수지)를 제조하기 위하여 수지원료를 조합하고 배합 및 혼합한다.","doWork":"작업표준에 따라 제조할 수지(Phenol, 접착제)에 따라 원료 및 성분을 확인한다. 혼합기 및 배합설비를 점검하고 원료와 공구를 준비한다. 원료를 계량하여 혼합기에 투입한다. 작업표준서에 따라 원료가 충분히 혼합될 때까지 혼합기를 가동한다. 혼합된 수지혼합물을 반응조에 투입하고 반응에 적합한 온도까지 올린다. 반응된 원료의 성분을 측정하고 측정값이 작업표준의 기준치에 적합하면 중화제를 투입하고 온도를 내린다. 수지를 계량하여 포장용기에 담는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8261","dJobECdNm":"[8261]유리·유리제품 생산기계 조작원","dJobJCd":"8431","dJobJCdNm":"[8431]유리 제조 및 가공기 조작원","dJobICd":"C231","dJobICdNm":"[C231]유리 및 유리제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002090:1', '{"dJobCd":"K000002090","dJobCdSeq":"1","dJobNm":"유리연마기조작원","workSum":"재단 및 절단된 유리의 모서리면을 연마하는 유리연마기계를 운전·조작한다.","doWork":"작업명세서 및 주문서에 따라 면취 및 연마할 유리의 종류 및 형태, 규격을 확인한다. 작업표준에 따라 유리의 두께에 적절한 연마기의 휠을 준비하여 장착한다. 연마기의 다이아몬드휠 상태, 윤활유, 오일 등과 작동 여부를 점검한다. 안전수칙에 따라 보호장갑 및 보호안경, 보호대를 착용한다. 전원스위치를 켜서 연마기를 시험 작동한다. 시험가공한 성형물이 작업명세서와 일치하는지 확인 후 유리의 사방을 연마기의 다이아몬드휠에 접착하여 날카로운 부분을 연마한다. 완성된 유리의 사방면을 검사한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"유리연마원","connectJob":"유리기계면취원","dJobECd":"8261","dJobECdNm":"[8261]유리·유리제품 생산기계 조작원","dJobJCd":"8431","dJobJCdNm":"[8431]유리 제조 및 가공기 조작원","dJobICd":"C231","dJobICdNm":"[C231]유리 및 유리제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005068:1', '{"dJobCd":"K000005068","dJobCdSeq":"1","dJobNm":"유리용융로조작원","workSum":"판유리, 유리관, 유리병 등의 제품을 대량생산하기 위하여 유리원료를 연속적으로 투입하여 용융시키는 유리용융로를 조작한다.","doWork":"작업명세서에 따라 용융할 유리원료의 양 등을 확인한다. 작업표준에 의하여 포트(Port)에 설치된 버너와 용융로의 상태를 점검한다. 유량조절기를 조정하여 원료 투입구(Doghouse)를 통하여 용융조에 유리원료가 투입되도록 한다. 버너에 사용되는 기름이나 가스의 양을 조절하여 유리원료가 충분히 녹아 용융체 간의 물리적인 균질화를 이룰 수 있도록 가열한다. 액체상의 유리에 미용융물이 존재하지 않도록 충분히 가열한다. 원료가 용융되는 과정에서 반응가스가 발생하여 생성되는 액체 내 기포를 제거한다. 생산에 적합한 조건(온도조절, 균질화)으로 유지시켜 유리물의 성형공정작업이 원활하게 이루어지도록 한다. 용융상태를 육안 또는 노 내부를 관찰하는 카메라나 노의 상태를 확인하는 컴퓨터계기판을 통해 관찰한다. 광고온계(Pyrometer)로 실측하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"용해로조작원, 유리용해로조작원, 유리제조로조작원, 유리경화로조작원","dJobECd":"8261","dJobECdNm":"[8261]유리·유리제품 생산기계 조작원","dJobJCd":"8431","dJobJCdNm":"[8431]유리 제조 및 가공기 조작원","dJobICd":"C231","dJobICdNm":"[C231]유리 및 유리제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006826:1', '{"dJobCd":"K000006826","dJobCdSeq":"1","dJobNm":"유리원료분쇄원","workSum":"유리의 주원료인 소다회(Na₂Co₃), 석회석(CaCo₃), 규사(SiO₂) 등의 광석원료와 파유리 등을 일정 규격의 입도로 분쇄하기 위하여 분쇄장치를 운전·조작한다.","doWork":"분쇄할 원료를 분쇄작업장으로 운반한다. 조합에 필요한 원료 및 공구를 준비한다. 분쇄기의 작동상태를 점검하고 저울의 영점을 조정한다. 생산할 유리의 종류에 따라 배합지시서를 확인하여 각 원료의 양을 계량한 후 분쇄기에 투입한다. 규정된 시간 동안 분쇄가 진행되면 원료 투입구의 덮개를 위로 하여 분쇄기를 정지하고 배출용구로 갈아 끼운다. 배출용구의 잠김을 확인하고 레버를 조절하여 배출구를 아래로 향하게 한다. 분쇄기의 배출구를 열어 원료저장통에 담는다. 저장통에 원료석의 종류와 색상 등을 기재한다. 조분쇄기의 투입구에 원료석을 넣고 분쇄기의 스위치를 넣어 분쇄하고, 컨베이어로 미분쇄기에 투입한다. 미분쇄된 원료는 규정된 체를 통과시키고 컨베이어를 이용하여 저장소로 이송하여 저장한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8261","dJobECdNm":"[8261]유리·유리제품 생산기계 조작원","dJobJCd":"8431","dJobJCdNm":"[8431]유리 제조 및 가공기 조작원","dJobICd":"C231/C232","dJobICdNm":"[C231]유리 및 유리제품 제조업 / [C232]내화, 비내화 요업제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005153:1', '{"dJobCd":"K000005153","dJobCdSeq":"1","dJobNm":"유리원료정제원","workSum":"유리제조에 필요한 각종 유리원료를 용융로에 투입하기 위하여 파유리를 세척, 분쇄하고 규사를 정제한다.","doWork":"작업지시서에 따라 정제할 유리의 양을 확인한다. 파유리의 양과 상태를 확인한다. 분쇄기 등 기계 및 장비를 점검한다. 파유리를 호퍼(Hopper:분립체의 저장 및 공급장치)에 투입하고, 분쇄기를 가동하여 1차 분쇄한다. 분쇄한 파유리를 세척드럼에서 세척하고 재분쇄한다. 분쇄된 파유리를 탈철기(철분 제거기계)에 넣고 가동하여 파유리에 함유된 철분을 제거한다. 파유리 분말을 체 분리하기 위해 체분리기를 가동한다. 규사를 정제하기 위하여 규사를 호퍼(Hopper)에 투입하고, 체분리기를 가동하여 규사를 분리한다. 분리된 규사를 건조로에 투입하여 건조한다. 건조된 규사를 탈철기에 넣고 가동하여 철분을 제거한다. 규사 저장 사일로(Silo:탑 모양의 저장탱크)에 저장한다. 기계 및 장비를 점검한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"조작운전","similarNm":"규사정제원","connectJob":"파유리정제원","dJobECd":"8261","dJobECdNm":"[8261]유리·유리제품 생산기계 조작원","dJobJCd":"8431","dJobJCdNm":"[8431]유리 제조 및 가공기 조작원","dJobICd":"C231","dJobICdNm":"[C231]유리 및 유리제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004903:1', '{"dJobCd":"K000004903","dJobCdSeq":"1","dJobNm":"유리원료혼합장치조작원","workSum":"유리제조에 사용되는 규사·석회석·소다회 등의 원료와 유리의 특성조절을 위하여 첨가되는 부원료를 계량하고 혼합한다.","doWork":"작업지시서에 따라 제조할 유리종류와 수량을 확인한다. 작업표준에 따라 제조할 유리에 적합한 원료와 안전화제, 청징제, 착색제 등 부재료를 준비한다. 배합기 등 혼합에 필요한 기계 및 장비를 점검한다. 배합지시표준서의 내용을 숙지하고 미분쇄기의 용량을 고려하여 각 원료의 조합량을 계산한다. 주원료와 부원료를 혼합하기 위하여 기계식 저울 또는 전자식 저울로 계량한다. 호퍼(Hopper:분립체의 저장 및 공급장치)제어기를 조작하여 혼합에 적당한 양을 입력한다. 제어기를 조작하여 각 원료를 배합기에 투입하고 규정된 시간만큼 배합기를 가동한다. 배합물의 상태를 확인 점검한다. 추가되거나 여유분의 배합물을 저장탱크에 저장한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8261","dJobECdNm":"[8261]유리·유리제품 생산기계 조작원","dJobJCd":"8431","dJobJCdNm":"[8431]유리 제조 및 가공기 조작원","dJobICd":"C231","dJobICdNm":"[C231]유리 및 유리제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006546:1', '{"dJobCd":"K000006546","dJobCdSeq":"1","dJobNm":"유리절단기조작원","workSum":"판유리나 접합유리, 유리섬유를 표준규격이나 주문 규격에 맞추어 절단하기 위해 절단기를 운전·조작한다.","doWork":"작업명세서 및 주문서에 따라 절단할 유리의 종류 및 규격을 확인한다. 작업표준에 따라 유리의 두께에 적절한 절단공구를 준비하여 절단기의 고정치구에 장착한다. 절단기의 절단공구상태, 윤활유, 오일 등과 작동 여부를 점검한다. 원판을 로딩기로 운반하여 절단기의 커팅테이블 위에 로딩한다. 워터젯 방식의 경우 분사노즐, 절단수 등을 점검한다. 절단규격을 컴퓨터에 프로그래밍한다. 전원스위치를 작동하여 절단기를 작동한다. 절단되는 상태를 육안으로 주시하며 관찰한다. 절단된 유리를 떼어낸다. 절단된 유리면의 상태를 검사한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"크리스탈유리재단원, 거울재단원, 판유리원단가공원, 판유리제조원","dJobECd":"8261","dJobECdNm":"[8261]유리·유리제품 생산기계 조작원","dJobJCd":"8431","dJobJCdNm":"[8431]유리 제조 및 가공기 조작원","dJobICd":"C231","dJobICdNm":"[C231]유리 및 유리제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001846:1', '{"dJobCd":"K000001846","dJobCdSeq":"1","dJobNm":"전구성형원","workSum":"백열등 및 자동차용 소형전구 등 유리구를 성형하기 위하여 각종 설비를 관리하며 전구 성형기를 운전·조작한다.","doWork":"작업지시에 따라 성형할 전구의 크기와 규격, 수량을 확인한다. 전구성형기의 연료, 윤활유 및 작동장치를 확인한다. 용융유리의 공급을 위해 이송장치(Feeder)와 분출장치(Spout)의 온도를 확인한다. 이송장치의 온도, 플런저(Plunger:용융유리물을 흘려보내는 장치)의 높이, 시어(Shear:플런저에서 흘러내린 유리물을 절단하는 장치)의 높이 및 속도를 조절한다. 성형기를 작동하고 시험가동을 한다. 시험유리구의 상태를 검사하고 이상이 없을 시 연속 가동한다. 작동상태를 육안으로 관찰하며 유리구가 성형되는 것을 주시한다. 성형된 유리구에 존재하는 열적 변형률(표면응력, Thermal Strain)을 제거하기 위하여 서냉로에 자동으로 투입되는 설비를 조작한다. 완성된 유리구에 필라멘트, 도입선, 앵커, 베이스를 조립하고 가스를 주입하기 위하여 다음 공정으로 이송한다. 무뎌진 시어의 날을 교환하기도 한다. 성형된 유리기물의 표면 청결상태를 유지하기 위해 시어, 형틀 등을 교환하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"고온|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"유리구성형원","dJobECd":"8261","dJobECdNm":"[8261]유리·유리제품 생산기계 조작원","dJobJCd":"8431","dJobJCdNm":"[8431]유리 제조 및 가공기 조작원","dJobICd":"C231","dJobICdNm":"[C231]유리 및 유리제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005683:1', '{"dJobCd":"K000005683","dJobCdSeq":"1","dJobNm":"제병기운전원","workSum":"유리병을 대량 생산하기 위해 자동성형기를 운전·조작한다.","doWork":"작업명세서에 따라 성형할 유리병의 규격과 수량을 확인한다. 제품규격에 맞는 주형 또는 몰드를 준비하여 예열로에 넣어 예열한다. 제병기의 이송장치(Feeder)와 예열된 주형을 결합한다. 플런저 스트로우크(Plunger Stroke:용융물이 한꺼번에 떨어지는 것을 제어하는 장치)를 조절하여 오리피스(Orifice:용융유리가 흘러나오는 인출구멍)로부터의 용융물 인출량을 조정한다. 몰드(Mold)로 떨어지는 용융유리의 양을 조절하는 시어(Shear:절단날)의 높이와 절단시기를 제품성형에 알맞은 형상과 중량으로 조절한다. 제병기의 스위치를 넣어 시험 가동한다. 시험성형된 유리병의 외관과 중량을 검사하여 작업표준과 일치함을 확인하고 연속하여 제병기를 가동한다. 1차 성형틀, 예열, 2차 성형틀에서 성형되는 제품의 상태를 관찰하고 기계의 작동상태를 점검한다. 수시로 주형에 이형제를 바르고, 전자저울 및 육안을 통해 성형된 기물의 규격과 중량을 확인한다. 성형이 완료된 제품을 상온에서의 급작스러운 균열을 방지하기 위하여 컨베이어를 작동하여 서냉로로 보낸다. 제어실에서 병의 생산 수량에 따른 기계 속도를 조작한다. 생산제품(병의 종류)이 바뀔 때는 유리물의 온도를 작업표준에 의하여 다시 설정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|고온|다습|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"유리병제조원","dJobECd":"8261","dJobECdNm":"[8261]유리·유리제품 생산기계 조작원","dJobJCd":"8431","dJobJCdNm":"[8431]유리 제조 및 가공기 조작원","dJobICd":"C231","dJobICdNm":"[C231]유리 및 유리제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007227:1', '{"dJobCd":"K000007227","dJobCdSeq":"1","dJobNm":"진공병양면부착원","workSum":"성형 및 절단된 이중의 보온병 유리에 열을 가하여 두 개의 병유리를 접합시킨다.","doWork":"보온병의 속유리와 겉유리의 고정상태를 확인하고 가공기의 물림쇠에 끼운다. 산소토치(torch)의 작동상태를 점검한다. 토치에 점화하여 부착할 양면유리에 서서히 열을 가한다. 유리가 연화되면 흑연판으로 눌러 접합시키고 보온병의 입구모양을 만든다. 접합이 끝난 보온병을 운반상자에 담는다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8261","dJobECdNm":"[8261]유리·유리제품 생산기계 조작원","dJobJCd":"8431","dJobJCdNm":"[8431]유리 제조 및 가공기 조작원","dJobICd":"C231","dJobICdNm":"[C231]유리 및 유리제품 제조업","inqYear":"2011"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003198:1', '{"dJobCd":"K000003198","dJobCdSeq":"1","dJobNm":"착공기조작원","workSum":"판유리의 일정 부위에 손잡이나 기타 부착물을 부착하기 위하여 구멍을 뚫는 기계를 조작한다.","doWork":"작업명세서에 따라 원판유리의 두께와 성형할 유리구멍의 규격과 위치를 확인한다. 착공기의 윤활장치와 절삭유, 냉각수, 드릴척 등을 확인한 후 구멍규격에 적합한 드릴을 준비하여 드릴척에 장착한다. 유리판을 대차를 이용하거나 유리압착기를 이용하여 착공기의 내부에 고정하여 설치한다. 구멍이 적당한 위치에 뚫리도록 고정판을 조정한다. 양쪽의 드릴압력이 일치하도록 착공기의 제어판을 조정한다. 절삭유의 콕크를 열어 구멍을 뚫을 위치에 소량의 절삭유가 흐르도록 한다. 착공기를 가동하여 구멍을 뚫는다. 구멍이 뚫리면 뚫린 상태를 검사하고 흠집이 나지 않도록 고무크립을 끼워 대차에 적재한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|다습|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"유리착공기조작원","dJobECd":"8261","dJobECdNm":"[8261]유리·유리제품 생산기계 조작원","dJobJCd":"8431","dJobJCdNm":"[8431]유리 제조 및 가공기 조작원","dJobICd":"C231","dJobICdNm":"[C231]유리 및 유리제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001930:1', '{"dJobCd":"K000001930","dJobCdSeq":"1","dJobNm":"촉관부착원","workSum":"밀봉된 보온병 하단에 촉관(가는 유리관)을 부착한다.","doWork":"가공할 보온병을 가공기에 고정시킨다. 가공기의 토치를 점화하여 진공기 하단을 가열한다. 보온병 하단이 연화되면 가는 유리관을 보온병의 겉유리에 눌러 관을 부착한다. 촉관이 부착된 보온병 하단에 약한 열을 가해 매끄럽게 다듬는다. 촉관을 적당한 크기로 자르고 운반통에 담는다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8261","dJobECdNm":"[8261]유리·유리제품 생산기계 조작원","dJobJCd":"8431","dJobJCdNm":"[8431]유리 제조 및 가공기 조작원","dJobICd":"C231","dJobICdNm":"[C231]유리 및 유리제품 제조업","inqYear":"2011"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003428:1', '{"dJobCd":"K000003428","dJobCdSeq":"1","dJobNm":"콘택트렌즈절삭원","workSum":"콘택트렌즈를 제조하기 위하여 자동선반기를 사용하여 원재료를 가공한다.","doWork":"작업지시서를 확인하고 절삭하는 콘택트렌즈의 규격과 작업내용을 숙지하고 관련 장비의 이상 유무를 점검한다. 콘택트렌즈의 원재료인 PMMA(Poly Methyl Methacrylate), PHEMA(Poly Hydroxt Ethyl Methacrylate) 등의 내·외면을 가공하기 위하여 핫플레이트를 이용하여 피치(접착제)를 녹이고 원재료를 접착지그에 붙인다. 자동선반기의 제어장치에 원하는 외경, 도수, 곡률반경 및 두께를 입력한다. 자동선반기의 절삭과정을 모니터링한다. 절삭된 버튼을 연마기와 연마재를 사용하여 연마한다. 연마된 버튼의 베이스커브를 렌즈미터를 사용하여 검사하고 초음파세척기를 사용하여 세척한다. 절삭 및 세척이 완료된 콘택트렌즈는 검사공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"콘택트렌즈외면절삭원, 콘택트렌즈내면절삭원, 하드콘택트렌즈절삭원, 소프트콘택트렌즈절삭원","certLic":"광학기능사","dJobECd":"8261","dJobECdNm":"[8261]유리·유리제품 생산기계 조작원","dJobJCd":"8431","dJobJCdNm":"[8431]유리 제조 및 가공기 조작원","dJobICd":"C271","dJobICdNm":"[C271]의료용 기기 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005724:1', '{"dJobCd":"K000005724","dJobCdSeq":"1","dJobNm":"프리즘가공원","workSum":"프리즘 유리를 평면절삭기(Mill-dex)와 수치제어 기계(MCT)등을 사용하여 가공한다.","doWork":"작업공정을 확인하고 제품가공에 필요한 평면절삭기 등의 장비와 광학유리 등의 재료를 점검한다. 가공할 프리즘 유리를 왁스, 본드 등을 사용하여 지그에 부착한다. 부착된 지그를 평면절삭기의 척에 고정시키고 작업속도, 높이, 치수, 가공시간 등 제어조건을 설정·입력하고 절삭과정을 모니터링한다. 가공작업이 완료되면 지그에서 분리하여 따뜻한 물이나 용제로 본드 또는 왁스를 녹인다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"광학기능사","dJobECd":"8261","dJobECdNm":"[8261]유리·유리제품 생산기계 조작원","dJobJCd":"8431","dJobJCdNm":"[8431]유리 제조 및 가공기 조작원","dJobICd":"C273","dJobICdNm":"[C273]사진장비 및 광학기기 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002490:1', '{"dJobCd":"K000002490","dJobCdSeq":"1","dJobNm":"홈가공원","workSum":"유리에 홈을 깎기 위하여 연삭기를 조작한다.","doWork":"작업명세서 및 주문서에 따라 홈가공할 유리의 종류 및 형태, 규격을 확인한다. 작업표준에 따라 연삭기의 연삭날(연삭숫돌)을 준비하여 장착한다. 연마기의 휠상태, 윤활유, 오일 등과 작동 여부를 점검한다. 안전수칙에 따라 보호장갑 및 보호안경, 보호대를 착용한다. 가공할 유리를 작업대 위에 배치한다. 깎이는 부분의 길이, 중심과 깊이를 조절하기 위해 렌치, 멈춤나사, 줄자 등으로 연삭기의 가이드레일과 멈춤장치를 고정한다. 연삭숫돌에 물을 공급하기 위하여 급수밸브를 연 후, 스위치를 눌러 연삭기를 작동한다. 절삭기의 수동손잡이를 이동하여 절삭 부위에 접촉시켜 절삭한다. 절삭이 완료되어 절삭완료를 알리는 신호등이 들어오면 절삭기의 수동손잡이를 들어 올린다. 완성된 유리의 홈상태를 검사한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"자동홈가공기조작원","dJobECd":"8261","dJobECdNm":"[8261]유리·유리제품 생산기계 조작원","dJobJCd":"8431","dJobJCdNm":"[8431]유리 제조 및 가공기 조작원","dJobICd":"C231","dJobICdNm":"[C231]유리 및 유리제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003963:1', '{"dJobCd":"K000003963","dJobCdSeq":"1","dJobNm":"가마연소원","workSum":"소성가마를 조작하여 벽돌, 하수관, 기와, 도자기, 위생도기 등의 제품을 소성한다.","doWork":"소성할 성형물의 종류와 규격, 수량을 확인한다. 소성가마의 온도센서상태, 연료 및 점화장치를 점검·확인한다. 소성할 제품을 이동 대차에 소성물 사이에 공간이 생기도록 하여 적재하여 가마에 투입한다. 연료 밸브를 열고 가마를 점화한다. 제어판을 조작하여 온도를 입력한다. 온도계나 소성가마 관찰 창(窓)을 통해 노의 내부를 관찰하고, 기름밸브, 공기밸브, 온도조정판을 조작하여 가마의 온도를 조정한다. 제품의 소성상태를 확인하며 가마의 온도를 일정하게 유지한다. 오름가마, 고리가마 및 터널가마 등을 이용하여 산화염 소성을 한다. 소성이 완료되면 연료밸브를 잠그고 제품을 냉각한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|고온|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"단가마소성원","connectJob":"도자기로조작원, 도자기건조로조작원, 도자기오븐로조작원, 도자기비스킷로조작원","dJobECd":"8262","dJobECdNm":"[8262]점토제품 생산기계 조작원","dJobJCd":"8432","dJobJCdNm":"[8432]점토제품 생산기 조작원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002358:1', '{"dJobCd":"K000002358","dJobCdSeq":"1","dJobNm":"가정용도자기조립원","workSum":"가정용 도자기의 성형된 부품을 조립한다.","doWork":"작업지시서에 따라 조립할 도자기 및 요업제품의 종류와 규격, 형태, 부품 등을 확인하고 점검한다. 작업표준서에 의하여 자기의 조립순서와 방법을 확인한다. 자기류의 몸체와 손잡이·주둥이 등 복잡한 형상의 제품성형 시 분리하여 성형한 각 부분품을 슬립(Slip:고체입자의 현탁액)을 이용하여 조립한다. 조립할 부위의 위치를 선정하고 조립할 부위를 칼이나 스펀지 등으로 다듬고 슬립을 칠하여 부분품을 부착한다. 조립이 완성되면 검사공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|시각|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8262","dJobECdNm":"[8262]점토제품 생산기계 조작원","dJobJCd":"8432","dJobJCdNm":"[8432]점토제품 생산기 조작원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003944:1', '{"dJobCd":"K000003944","dJobCdSeq":"1","dJobNm":"개방형혼련기조작원","workSum":"분쇄 및 조합이 끝난 도자기 원료의 각 성분을 골고루 섞어주기 위하여 혼련기를 운전, 조작한다.","doWork":"혼합할 원료의 종류와 양을 작업지시서의 내용에 따라 확인한다. 각 원료의 배합비를 확인하고 원료를 준비한다. 혼련기의 작동 여부를 점검하고 확인한다. 작업표준서에 따라 전자계량기를 이용하여 각각의 원료를 계량하여 혼련기에 투입한다. 배합 비율에 맞추어 투입된 원료에 결합체(Binder)를 규정량만큼 첨가한다. 혼련기(V-mixer:혼합기)를 시험 가동하고 임펠러(Impeller:회전날개)의 회전상태를 확인하고 점검한다. 혼련기를 가동하여 규정시간 동안 원료를 균일하게 혼련한다. 혼련기 하부에 장착된 배출밸브를 열어 혼련이 완료된 균질의 원료를 배출한다. 배출한 원료를 저장고에 담아 경화되지 않도록 밀폐하여 보관하거나 성형공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실외","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"도자기원료배합원, 도자기원료혼합기조작원","dJobECd":"8262","dJobECdNm":"[8262]점토제품 생산기계 조작원","dJobJCd":"8432","dJobJCdNm":"[8432]점토제품 생산기 조작원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002085:1', '{"dJobCd":"K000002085","dJobCdSeq":"1","dJobNm":"겔코팅원","workSum":"이형제가 처리된 몰드에 스프레이건을 이용하여 겔코트(경화제, 촉진제 혼합액)를 도포한다.","doWork":"작업표준에 의하여 이형제(오일 등)가 처리된 몰드(도자기, 벽돌, 내화물 등의 제품을 성형하기 위한 몰드 및 주형)의 내부상태에 이상이 없는지 육안으로 확인한다. 경화제 등의 원료를 준비하고 스프레이건의 분사노즐과 작동 여부를 확인한다. 스프레이건의 주밸브를 열고 수지통 공기밸브의 압력을 적절하게 조절한다. 경화제가 규정치만큼 토출되도록 압력과 계기판을 조절한다. 몰드의 표면상태를 확인 후 스프레이건과 몰드 사이에 일정 거리를 두고 몰드 표면과 직선이 되게 코팅을 한다. 몰드 표면에 균일하게 겔코팅이 되도록 여러 번 도포한다. 작업이 완료되면 몰드를 건조한다. 여분의 경화제를 보관통에 저장하여 공기 중에 경화되지 않도록 보관한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|시각|","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"스프레이작업원","dJobECd":"8262","dJobECdNm":"[8262]점토제품 생산기계 조작원","dJobJCd":"8432","dJobJCdNm":"[8432]점토제품 생산기 조작원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001745:1', '{"dJobCd":"K000001745","dJobCdSeq":"1","dJobNm":"도자기가압성형기조작원","workSum":"금형과 프레스를 이용하여 분말 소지토나 소량의 수분을 함유한 소지토를 성형한다.","doWork":"작업지시서에 따라 가압성형할 성형물의 규격과 형태를 확인하고 그에 맞는 석고틀을 준비한다. 소지토(素地土:반건식 이하의 가소성이 적은 점토원료)의 상태를 육안으로 점검한다. 마찰프레스, 수압 또는 유압프레스를 점검하고 작동의 이상 유무를 확인한다. 펌프 모터를 가동하여 유온을 올린다. 금형을 손질하여 상·하 금형의 이가 잘 맞도록 결합하고 프레스를 내려 제품에 맞게 간격을 조정한다. 소지토 공급장치를 조절하여 적당량의 소지토가 공급되도록 한다. 스위치를 수동 위치에 놓고 조작하여 시험 성형을 한다. 모든 조절장치가 정상으로 가동되면 스위치를 자동 위치에 놓고 기계를 가동한다. 가동 중 압력계기로 압력을 점검하고 기계의 작동상태, 제품의 성형상태를 확인한다. 기계나 제품에 이상이 발생하면 기계를 멈추고 원인을 파악하여 필요한 조치를 하고 다시 작동한다. 가압성형된 성형물을 탈착하고 분리하여 외관 및 형태의 이상 유무를 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"도자기프레스성형원","dJobECd":"8262","dJobECdNm":"[8262]점토제품 생산기계 조작원","dJobJCd":"8432","dJobJCdNm":"[8432]점토제품 생산기 조작원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003921:1', '{"dJobCd":"K000003921","dJobCdSeq":"1","dJobNm":"도자기압착성형기조작원","workSum":"배합원료를 일정 형태로 성형하기 위하여 압착성형기(Press)를 운전·조작한다.","doWork":"성형할 도자기의 형태와 규격을 확인한다. 유압프레스의 작동 여부를 점검하여 확인한다. 성형할 제품의 형태, 크기, 두께에 따라 성형틀을 기계에 설치하고 조정한다. 배합원료를 수령하고 반건식 이하의 가소성이 좋은 상태인지 점검한다. 성형틀을 프레스기계 안의 정확한 위치에 올려놓는다. 버튼을 누르거나 손잡이를 당겨 프레스의 상부램(Ram)을 내리고, 성형틀의 원료를 압착하여 일정한 형태로 성형한다. 성형틀의 압력을 제거하고 성형틀을 분리한다. 압착성형된 반제품을 적재대에 쌓는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8262","dJobECdNm":"[8262]점토제품 생산기계 조작원","dJobJCd":"8432","dJobJCdNm":"[8432]점토제품 생산기 조작원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002283:1', '{"dJobCd":"K000002283","dJobCdSeq":"1","dJobNm":"도자기정형기조작원","workSum":"도자기류를 가마에 넣어 굽기 전에 가장자리나 표면을 매끈하게 다듬기 위하여 자동정형기를 운전·조작한다.","doWork":"작업주문서에 따라 정형할 제품의 형태와 주문내용을 확인한다. 정형할 기물의 건조상태를 점검한다. 정형부위와 정형방법을 정하고 도구 및 공구를 준비한다. 자동정형기의 작동을 확인하고 정형이 필요한 제품을 선별하여 정형기의 회전판 위에 올려놓는다. 연마기에 연마판 등 정형공구를 장착한다. 레버 및 핸들을 조작하여 연마공구와 기물의 거리를 조절한다. 연마 후 세척을 하기 위하여 회전하는 기계의 스핀들(Spindle:회전주축)에 스펀지벨트를 장치한다. 물탱크에 연결된 급수밸브를 열어 스펀지벨트에 적당량의 물이 흐르도록 한다. 버튼을 눌러 정형기를 시동하여 기물을 정형한다. 기물의 크기에 따라 회전판의 회전속도를 조절한다. 기계의 작동상태나 시제품을 관찰하여 정형기를 재조정한다. 기계에서 정형이 완료된 기물을 꺼내고, 다음 작업을 위해 새 기물을 넣어 정형작업을 한다. 완성된 정형품을 일전장소에 적재하고 작업수량과 불량률을 작업일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"도자기성형원","dJobECd":"8262","dJobECdNm":"[8262]점토제품 생산기계 조작원","dJobJCd":"8432","dJobJCdNm":"[8432]점토제품 생산기 조작원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006829:1', '{"dJobCd":"K000006829","dJobCdSeq":"1","dJobNm":"롤러성형원","workSum":"접시나 컵, 항아리 등의 간단한 형상의 제품을 대량 생산하기 위하여 롤러머신(Roller Machine)을 운전·조작한다.","doWork":"작업계획에 따라 생산량을 확인하고 성형할 기물의 종류 및 형태 등을 작업지시서와 확인한다. 작업에 필요한 공구와 재료를 준비하고 성형기의 작동상태를 점검한다. 여러 가지 형태의 롤러형 흙손을 성형기의 암(Arm)에 부착한다. 석고형을 받침대에 얹고 암을 내려 성형체의 두께와 각도를 조절한다. 제품의 크기와 모양에 따라 롤러나 회전축의 회전속도와 암의 하강속도를 조절한다. 성형기에 부착된 절단기의 절단날을 제품규격에 맞추어 조절한다. 전원스위치를 넣고 석고형에 소지토를 넣어 시험성형을 한다. 시험성형품을 검사하여 성형기를 재조정한 후 스위치를 넣어 기계를 가동한다. 석고형을 잡고 스펀지로 회전하는 흙손에 피마자유나 윤활유를 바른다. 암이 내려와 성형이 진행되는 동안 다음 작업을 위하여 석고형을 준비하고 검사한다. 성형이 완료되어 암이 상승하면 성형된 기물을 석고형과 함께 들어내어 건조공정으로 보내기 위해 적재한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8262","dJobECdNm":"[8262]점토제품 생산기계 조작원","dJobJCd":"8432","dJobJCdNm":"[8432]점토제품 생산기 조작원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006457:1', '{"dJobCd":"K000006457","dJobCdSeq":"1","dJobNm":"몰드주형원","workSum":"겔(Gel, 젤리 형태)코팅된 몰드에 교반기를 통해 혼합된 소지를 주입한다.","doWork":"작업지시서에 따라 성형할 도자기의 수량을 확인한다. 몰드주형기 내부를 육안으로 확인하여 오염 여부를 확인한다. 주입할 소지의 양을 계산하고 정량하여 경화제와 함께 소지혼합기 또는 교반기에 넣어 균질하게 혼합한다. 주형에 소지를 투입하기 전에 이형제 또는 겔(Gel)을 코팅하여 소지(점토, 흙덩어리)가 붙지 않도록 한다. 혼합이 완료되면 주형용 호이스트를 이용하여 겔코팅된 몰드에 적정량의 소지를 주입한다. 소지가 몰드에 주입·성형되면 캡몰드(덮개 몰드)를 조립한다. 몰드와 제품과 캡몰드를 고정시키기 위해 만력기(C형클램프)를 장착한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8262","dJobECdNm":"[8262]점토제품 생산기계 조작원","dJobJCd":"8432","dJobJCdNm":"[8432]점토제품 생산기 조작원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004561:1', '{"dJobCd":"K000004561","dJobCdSeq":"1","dJobNm":"미분쇄기조작원","workSum":"조분쇄 및 배합된 원료를 일정한 입도로 분쇄하고 혼합하는 미분쇄기를 운전·조작한다.","doWork":"분쇄할 양을 확인하고 일일 분쇄작업계획을 수립한다. 분쇄기인 볼밀(Ball Mill)의 작동 여부를 확인하며 부품 등의 교체 및 노후정도를 수시로 점검한다. 조크러셔(Jawcrusher)를 통하여 1차로 조파쇄한 암석 및 배합원료의 상태를 확인한다. 배합된 원료를 미분쇄기의 원료투입구에 투입한다. 투입된 원료의 양에 맞추어 분쇄기에 물과 구석을 장입한다. 원료투입구 주위를 청소하고 투입구의 덮개를 덮은 후 볼트를 조여 고정한다. 분쇄기의 스위치를 넣고 레버를 당겨 회전한다. 미분쇄기에서 마쇄되어 혼합된 이장을 채로 걸러내는 탈철기를 통과시켜 철분을 제거한다. 교반탱크로 옮겨 교반하면서 펌프를 작동하여 여과기로 보내어 탈수한다. 분쇄시간을 일정하게 맞추기 위하여 작업 중에 발생한 작업정지 시간을 작업일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"볼밀조작원","dJobECd":"8262","dJobECdNm":"[8262]점토제품 생산기계 조작원","dJobJCd":"8432","dJobJCdNm":"[8432]점토제품 생산기 조작원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004316:1', '{"dJobCd":"K000004316","dJobCdSeq":"1","dJobNm":"분말소지제조원","workSum":"압축 성형용 분말소지의 제조를 위하여 분무건조기를 운전·조작한다.","doWork":"생산계획에 따라 건조할 원료의 종류와 양을 확인하고 일일 작업목표량을 계산하여 작업일지에 기록한다. 분무건조기의 작동 이상 여부를 확인하고 열풍기 버너의 연료공급밸브를 연 후 스위치를 넣어 점화한다. 송풍팬의 스위치를 넣어 분무탑에 일정량의 열풍을 공급한다. 분무탑 내 공기온도를 점검하고 버너의 연료공급량을 조절한다. 사이클론 분급기의 스위치를 넣어 슬립을 분무탑 내부 열풍 속에 분사한다. 분무탑 아래로 건조되어 나오는 분말소지의 입도분포와 함수율을 계산한다. 원하는 상태의 분말을 생산키 위해 온도와 압력을 점검하고 재조정한다. 진동체와 컨베이어를 가동하여 건조된 분말소지를 성형실의 사일로(Silo, 저장탱크)에 운반·저장한다. 작업이 끝나면 펌프를 제외한 모든 계기의 스위치를 내리고 펌프에 물을 공급하여 펌프와 슬립공급파이프를 세척한 후 펌프의 스위치를 내린다. 일일작업량을 점검하여 작업일지에 기록하고 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|다습|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"건식분말소지토제조원","dJobECd":"8262","dJobECdNm":"[8262]점토제품 생산기계 조작원","dJobJCd":"8432","dJobJCdNm":"[8432]점토제품 생산기 조작원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001242:1', '{"dJobCd":"K000001242","dJobCdSeq":"1","dJobNm":"분무시유원","workSum":"대형 또는 다량의 도기제품성형물에 압축공기로 유약을 분무하여 시유한다.","doWork":"타일 또는 위생도기 등 도기제품 성형물에 대량으로 시유(유약 입히기)하기 위하여 작업지시서에 따라 성형물에 맞는 유약(경질유, 연질유)을 준비하고 청자유, 진사유 등의 색유를 준비한다. 유약과 색유의 상태를 확인한다. 분무기의 노즐을 청소하거나 이상이 있을 시 교체한다. 분무기의 분사량을 조절하고 압축공기의 이상 유무를 점검한다. 시유할 반제품에 묻은 먼지를 압축공기나 솔로 제거하고 시유대에 올려놓는다. 유약에 적당량의 물을 첨가하여 유약의 농도를 조절한다. 스위치를 넣어 공기 압축기를 작동하고, 압력 조절 밸브로 압력을 조정한다. 분무기의 유약통에 유약을 주입한다. 분무기의 손잡이를 잡고 손가락으로 시유 손잡이를 당겨 시험분무를 하여 분무상태를 검사한다. 전체 면에 고른 두께로 유약이 시유되도록 분무기와 제품 간의 간격을 유지한다. 시유된 제품을 건조대에 올려 자연 건조시킨다. 시유 및 건조를 2~3회 반복한다. 작업이 완료되면 분무기를 세척하고, 공기 압축기의 스위치를 내린다. 공구를 정리하고 작업장을 청소한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|손사용|시각|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8262","dJobECdNm":"[8262]점토제품 생산기계 조작원","dJobJCd":"8432","dJobJCdNm":"[8432]점토제품 생산기 조작원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003931:1', '{"dJobCd":"K000003931","dJobCdSeq":"1","dJobNm":"석재건조기조작원","workSum":"대차에 적재된 반제품 벽돌이나 내화물 성형품을 운반하여 건조실에 투입하고 투입된 제품을 건조하기 위해 건조기를 조작한다.","doWork":"작업반장의 지시에 따라 일일작업량을 확인하고 건조기의 작동 여부를 확인한다. 성형된 기물을 건조하기 위하여 제품을 수령하고 성형상태 및 파손 여부를 육안으로 확인한다. 건조 예정된 대차를 건조실에 밀어 넣고 문을 닫는다. 건조실의 온도·습도 및 대차의 이동속도, 열의 공급 및 순환을 세밀히 점검한다. 건조실의 컨트롤박스를 조작하여 온도·습도 및 대차의 이동속도를 조정한다. 건조실의 문을 열어 기물을 냉각하고 건조되어 나온 제품을 검사하여 모양이 변형되거나 균열(Crack)이 생긴 성형물을 선별하여 분리한다. 건조물을 소성대기적치장으로 운반한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|다습|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8262","dJobECdNm":"[8262]점토제품 생산기계 조작원","dJobJCd":"8432","dJobJCdNm":"[8432]점토제품 생산기 조작원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003738:1', '{"dJobCd":"K000003738","dJobCdSeq":"1","dJobNm":"소지토제조원","workSum":"슬립(Slip)상태로 미분쇄된 소지를 탈수시켜 가소성 성형을 위한 소지로 만드는 장비를 다룬다.","doWork":"작업명세서에 따라 제조할 소지토의 종류와 양을 확인하고 일일 생산계획을 세운다. 소지토 제조장비의 필터 프레스(Filter Press)의 고무패킹과 기름 헝겊의 이상 유무를 확인한다. 프레스판의 잠김 핸들을 돌려 잠근다. 압력펌프와 연결된 파이프의 밸브를 열고 압력펌프의 스위치를 넣은 후 교반탱크에 있는 슬립을 필터프레스에 압입한다. 압력계와 여과수 배출구를 관찰하여 여과수가 더 이상 나오지 않고, 압력계에 표시된 압력이 일정 압력에 도달하면 펌프의 스위치를 내리고 밸브를 잠근다. 프레스판의 잠김핸들을 풀고 소지케이크(Cake)를 들어낸 후 진공토련기의 진공펌프스위치를 넣는다. 진공실의 압력계가 규정된 압력에 도달하면 진공토련기의 스위치를 넣고 토련기의 원료투입구에 소지케이크를 공급한다. 토련된 소지를 적당한 길이로 잘라 성형반으로 보낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"토련기조작원","dJobECd":"8262","dJobECdNm":"[8262]점토제품 생산기계 조작원","dJobJCd":"8432","dJobJCdNm":"[8432]점토제품 생산기 조작원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007064:1', '{"dJobCd":"K000007064","dJobCdSeq":"1","dJobNm":"시유기조작원","workSum":"성형된 기물에 유약을 도포하기 위하여 자동 시유기를 운전·조작한다.","doWork":"작업지시서에 따라 시유(유리 성분이 많은 흙과 이를 쉽게 녹여주는 융제, 색깔을 내는 발색제 등을 물에 섞은 혼합물 속에 자기를 담그고 표면에 고르게 입혀지도록 하는 과정)할 성형물의 종류, 형태, 색, 수량을 확인한다. 수량 및 색에 따라 유약의 양을 계량하여 시유기의 혼합탱크에 투입한다. 시유기의 혼합탱크를 가동하여 유약이 균일하게 혼합되도록 한 후 시유기의 호퍼(Hopper:분립체의 저장 및 공급장치)에 저장한다. 시유기의 분무장치나 이송컨베이어의 작동상태를 점검한다. 성형물에 따라 시유기의 분사량과 압력을 적정하게 조절한다. 컨베이어에 부착된 시유대를 가동하여 이동하고 시유대에 성형품을 하나씩 올려놓는다. 시유기를 작동하여 시유한다. 성형품에 유약이 시유되고 건조되는 과정을 주시하며 균일하게 시유가 되는지 육안으로 관찰한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8262","dJobECdNm":"[8262]점토제품 생산기계 조작원","dJobJCd":"8432","dJobJCdNm":"[8432]점토제품 생산기 조작원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002734:1', '{"dJobCd":"K000002734","dJobCdSeq":"1","dJobNm":"애자조립원","workSum":"전기전자 강전용 절연요업물의 성형된 부품을 조립한다.","doWork":"작업지시서에 따라 조립할 절연요업물의 종류와 규격, 형태, 부품 등을 확인하고 점검한다. 작업표준서에 의하여 종류별 각 애자(송전선용 현수애자, 장간애자, 내무애자, 배전선용 핀애자, 옥내배선용 놉애자, 애관, 클리트애자, 차단기·피뢰기용 지지애자 등)의 조립순서와 방법을 숙지한다. 완성된 애자와 금구를 조립한다. 애자, 금구, 접착 시멘트 등을 준비하고, 애자와 금구에 절연 니스를 칠한다. 접착 시멘트를 혼합기준에 따라 혼합한 후 접착 부위에 칠한다. 금구와 애자를 접착시켜 조립하고 애자와 금구에 묻은 시멘트를 닦아낸다. 조립된 애자를 양생실에 넣어 스팀으로 양생한다. 조립이 완성되면 검사공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|시각|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8262","dJobECdNm":"[8262]점토제품 생산기계 조작원","dJobJCd":"8432","dJobJCdNm":"[8432]점토제품 생산기 조작원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003656:1', '{"dJobCd":"K000003656","dJobCdSeq":"1","dJobNm":"요업소성로조작원","workSum":"성형품을 고온에서 소성하여, 내화물이 안정된 조성과 열적, 기계적, 화학적 강도를 갖도록 내화물 소성로를 운전·조작한다.","doWork":"작업표준 및 작업지시서에 따라 소성물의 종류, 수량, 규격, 형태 등을 확인한다. 소성로(터널식 가마)의 각 공정단위의 설비 및 기계의 작동 여부를 확인하고 점검한다. 소성로의 예열대, 소성대, 냉각대의 송·배풍장치, 가스순환장치 ,열풍로 등을 조절하여 기물의 소성에 적당한 온도로 조정한다. 성형품이 적재된 대차를 유압푸셔로 밀어 노의 예열대에 밀어 넣는다. 대차의 투입시간을 작업표에 기록한다. 소성대에서 발생한 고온의 열가스를 송, 배풍장치, 가스순환장치 등을 조작하여 이송하고, 규정된 승온곡선에 맞추어 가스순환량이나 배기량을 적절히 조절하기 위하여 댐퍼를 조정한다. 피소성물을 균일하게 가열·소성하기 위하여 온도를 일정하게 유지하고 연료소모량과 공기연소량을 조정하여 일정 시간 동안 소성한다. 소성이 완료된 소성품은 냉각대의 댐퍼(Damper:흡진기, 제진기)를 조정하여 냉풍투입량을 조절하고, 냉각곡선에 따라 서서히 냉각시킨다. 소성로의 원활한 운전을 위하여 수시로 각 기기의 운전상태를 점검한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"고온|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"소성원","dJobECd":"8262","dJobECdNm":"[8262]점토제품 생산기계 조작원","dJobJCd":"8432","dJobJCdNm":"[8432]점토제품 생산기 조작원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005564:1', '{"dJobCd":"K000005564","dJobCdSeq":"1","dJobNm":"위생도기이형제처리원","workSum":"몰드(Mold:석고형틀)를 이용하여 욕조, 세면대 등을 주형하는 공정에서 몰드에 이형제를 바른다.","doWork":"작업지시서에 따라 이형제(왁스)와 코팅할 욕조, 세면대 등의 주형몰드를 수령하여 몰드 내부 및 표면을 육안으로 관찰하며 점검한다. 몰드 내부 및 표면에 점토슬립이 붙어있거나 이물질이 남아 있으면 에어스프레이나 깨끗한 헝겊으로 완전히 닦아내어 제거한다. 마른 헝겊이나 유사한 도구를 이용하여 지정된 이형제(왁스)를 나선형 모양으로 마른다. 이형제(왁스)가 적당히 건조되면 마른 헝겊이나 유사한 도구를 사용하여 몰드에 광택이 나도록 닦아준다. 이형제 작업이 완료된 몰드를 겔코팅 공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|시각|","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"몰드표면처리원","dJobECd":"8262","dJobECdNm":"[8262]점토제품 생산기계 조작원","dJobJCd":"8432","dJobJCdNm":"[8432]점토제품 생산기 조작원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001642:1', '{"dJobCd":"K000001642","dJobCdSeq":"1","dJobNm":"위생도기조립원","workSum":"위생도기의 성형된 부품 및 파이프 등 부속품을 조립한다.","doWork":"작업지시서에 따라 조립할 위생도기제품의 종류와 규격, 형태, 부품 등을 확인하고 점검한다. 작업표준서에 의하여 서양식좌변기, 트랩(Trap:U자 모양의 관)이 붙은 대변기, 스톨소변기, 세면기, 수세기, 욕조 등의 조립순서와 방법을 확인한다. 상부와 하부 등으로 구분되어 성형된 제품을 수령하여 석고형과 성형체를 분리한 후 각 부분을 결합하고 파이프 연결을 위한 부속품 등을 조립한다. 조립이 끝난 반제품에 품질표시, 검사필증 및 제조고유번호와 제조일자 등을 인쇄하거나 부착한다. 조립이 완성되면 검사공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|시각|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","connectJob":"변기제조원, 욕조제조원, 생활도자기조립원","dJobECd":"8262","dJobECdNm":"[8262]점토제품 생산기계 조작원","dJobJCd":"8432","dJobJCdNm":"[8432]점토제품 생산기 조작원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001684:1', '{"dJobCd":"K000001684","dJobCdSeq":"1","dJobNm":"점토소성제품정형기조작원","workSum":"타일·벽돌 등의 점토소성제품 제조 시 성형 및 소성된 제품의 외관이나 치수가 정확한 제품을 만들기 위하여 정형기를 조작한다.","doWork":"작업계획서에 따라 정형할 제품의 규격과 형태를 확인하여 정형부분을 확인하고 정형공구를 정형기에 결합한다. 정형기의 손잡이를 조작하여 정형기의 연마석과 기물의 거리를 알맞게 조절한다. 정형기의 윤활상태 등을 점검하여 작동 여부를 확인하고 전원을 가동하여 규격에 맞도록 정형한다. 정형이 완성된 기물의 규격을 명세서와 비교한다. 이상이 없을 시 연속적인 작업을 한다. 이상이 있을 시 규격에 맞추어 정형기의 게이지(Gauge)를 재조정한다. 각종 게이지와 육안으로 정형된 제품의 외관과 규격을 검사하고, 불량품을 선별한다. 완성된 정형물은 팔레트에 적재하고 건조시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실외","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8262","dJobECdNm":"[8262]점토제품 생산기계 조작원","dJobJCd":"8432","dJobJCdNm":"[8432]점토제품 생산기 조작원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005115:1', '{"dJobCd":"K000005115","dJobCdSeq":"1","dJobNm":"점토원료혼합원","workSum":"점토제품의 생산을 위해 원료를 혼합하는 공정을 관리하고 기계장치를 운전·조작한다.","doWork":"작업 전 생산공정의 기계설비, 장치 등의 작동 유무를 점검하고 확인한다. 벨트컨베이어 작동상태의 이상 유무를 확인한다. 그라인딩밀의 마모상태나 롤의 맞물림 상태·간격 등을 점검한다. 혼련기의 작동 이상 유무를 확인한다. 계량장치를 사용하여 규정된 만큼의 원료가 계량되도록 준비한다. 관련된 기계를 순서에 맞추어 작동하고 조작스위치나 손잡이를 움직여 원료와 적당량의 물이 투입되도록 한다. 혼련된 원료의 함수율·입도 등을 각각의 측정기를 사용하여 측정한다. 원료가 적당히 혼련되면 성형기에 투입되도록 준비한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실외","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"혼련원, 혼련기조작원","dJobECd":"8262","dJobECdNm":"[8262]점토제품 생산기계 조작원","dJobJCd":"8432","dJobJCdNm":"[8432]점토제품 생산기 조작원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005224:1', '{"dJobCd":"K000005224","dJobCdSeq":"1","dJobNm":"점토제품선별원","workSum":"타일·벽돌 등의 점토제품을 등급별로 선별하여 적재대에 적재한다.","doWork":"검사표준서에 따라 성형품의 색상, 치수, 형상 등 선별기준과 선별방법을 확인한다. 작업지시서에 따라 일일 출고량과 적재 재고량을 계산하여 확인한다. 자동결속기와 이송컨베이어의 윤활장치 및 부자재를 확인한다. 지게차의 연료 등을 확인하며 장비의 작동 여부를 점검한다. 선별한 소성대차를 선별장으로 운반한다. 전원 스위치를 넣어 이송컨베이어 및 자동결속 포장기를 가동한다. 대차의 상단에 적재된 소성품을 이송컨베이어에 올려놓는다. 이송컨베이어를 타고 오는 제품의 규격이나 형상을 육안으로 확인하고 포장이 용이하게 일정 수량씩 적재한다. 파손품은 파손품 처리통에 담는다. 소성 시 서로 붙은 벽돌은 별도 분리하여 망치나 기타 공구를 사용하여 떼고 등급을 분류한다. 일정 수량씩 정리된 벽돌을 두 손으로 밀어서 포장결속기의 결속부분에 대고 발로 결속 페달을 밟아 결속한다. 결속된 벽돌을 적재대에 쌓고 일정량이 적재되면 지게차로 지정된 야적장으로 운반한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"웅크림|손사용|시각|","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","dJobECd":"8262","dJobECdNm":"[8262]점토제품 생산기계 조작원","dJobJCd":"8432","dJobJCdNm":"[8432]점토제품 생산기 조작원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005186:1', '{"dJobCd":"K000005186","dJobCdSeq":"1","dJobNm":"점토제품성형기조작원","workSum":"내화벽돌, 타일, 점토벽돌 등을 대량 생산하기 위하여 자동성형기를 운전·조작한다.","doWork":"생산할 성형물의 종류와 규격, 형태, 수량 등을 확인한다. 작업성형기(Press) 및 컨베이어의 작동상태를 점검한다. 성형에 적합한 금형을 준비하고 성형기에 금형을 조립하여 이상 여부를 확인한다. 성형에 필요한 점토, 배합원료의 상태를 육안으로 점검하며 작업에 적합한지 확인한다. 성형기를 가동하고 배합된 점토원료를 성형기에 투입한다. 벨트컨베이어를 통하여 배출구로 성형되어 나오는 반제품의 상태를 확인하며 성형물 표면을 헤라 등으로 밀어 표면을 매끄럽게 한다. 성형품의 형상 및 치수를 육안이나 자를 사용하여 확인한다. 성형공정라인의 전반적인 설비를 점검하고 생산흐름이 원활하도록 유지·관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8262","dJobECdNm":"[8262]점토제품 생산기계 조작원","dJobJCd":"8432","dJobJCdNm":"[8432]점토제품 생산기 조작원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004720:1', '{"dJobCd":"K000004720","dJobCdSeq":"1","dJobNm":"점토제품원료배합원","workSum":"벽돌, 기와, 타일 등을 제조하기 위하여 자동계량장치로 부정형 형태(반죽형태)의 원료를 배합하고 포장한다.","doWork":"작업계획에 따라 황토, 세라믹, 적점토와 모래(강사, 보명사, 마사), 고령토, 장석(도석) 등 원료들을 파악하고 준비한다. 배합할 내화물의 종류와 양을 파악하여 작업량을 계산한다. 작업명세서에 따라 각각의 재료를 계량하여 토련기(돌을 고르는 기기), 혼련기(고르게 섞어 이기는 기기) 등의 배합기계에 투입한다. 혼련기를 일정 시간 가동하여 각각의 원료들을 균질하게 배합한다. 소량의 원재료는 삽으로 퍼서 저울로 계량한 후 배합기에 투입한다. 배합이 완료된 원료의 밀도 및 점성, 색깔상태를 육안으로 확인하여 작업명세와 비교 후 다음 공정으로 이송하거나 자동포장기계를 사용하여 포장한 후 중량별로 팔레트에 쌓아서 적재한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"힘든 작업","workPlace":"실외","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"부정형내화물원료혼합원","dJobECd":"8262","dJobECdNm":"[8262]점토제품 생산기계 조작원","dJobJCd":"8432","dJobJCdNm":"[8432]점토제품 생산기 조작원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001761:1', '{"dJobCd":"K000001761","dJobCdSeq":"1","dJobNm":"점토제품주입성형원","workSum":"주입성형 도구를 사용하여 특이한 형태의 벽돌, 하수관, 기타 내화성 제품을 주형한다.","doWork":"작업명세서에 따라 주형할 내화물의 규격과 수량을 확인한다. 작업표준에 의하여 주형내화물에 적합한 점토원료를 준비한다. 점토원료를 점토반죽기에 넣어 균질하게 혼합하여 반죽한다. 꺼낼 때 파손되지 않고 원료가 주형에 붙지 않도록 주형 내부에 이형제를 칠한다. 점토반죽을 주형 안에 넣고 손 또는 수동공구를 사용하여 빈 공간이 생기지 않도록 다진다. 주형 위로 나온 반죽을 철선 및 낚시줄 등 자름실을 사용하여 제거한다. 주형을 들어 올려 철판에 놓고 뒤집어서 성형품을 빼낸다. 수동 주형공구를 사용하여 끝내기와 다듬질 작업을 한다. 제품에 인식부호를 찍는다. 사용할 주형을 청소하고 재사용을 위해 분리제를 바른다. 주형용 원료를 만들기 위해 점토와 규조토 등을 섞는 흙반죽 기계를 조작하기도 한다. 주형이 완성된 성형물을 건조하기 위하여 외부 상온에 적재하고 비닐 등의 커버로 씌운다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"도관성형작업원, 벽돌성형작업원, 화분제작원","dJobECd":"8262","dJobECdNm":"[8262]점토제품 생산기계 조작원","dJobJCd":"8432","dJobJCdNm":"[8432]점토제품 생산기 조작원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001507:1', '{"dJobCd":"K000001507","dJobCdSeq":"1","dJobNm":"점토주입성형원","workSum":"기물을 성형하기 위하여 석고형에 슬립(Slip:이장, 흙물)상태의 소지를 부어 성형한다.","doWork":"작업지시서에 따라 주입성형물의 규격, 크기, 형태를 확인한다. 슬립(Slip:이장, 흙물)원료의 상태를 확인한다. 주입성형기의 노즐상태를 점검하며 분출량을 조정한다. 성형물에 맞는 석고형을 준비하여 성형기에 결합한다. 석고형의 내부를 깨끗이 세척하고, 석고형의 부분품을 맞추어 결합한다. 결합된 석고형을 조임쇠·고무줄·끈 등으로 고정한다. 석고형의 주입구에 깔때기를 꽂고 주입통을 기울여 서서히 주입한다. 석고형이 소지에 함유된 수분을 어느 정도 흡수하면 석고형을 묶은 조임쇠나 고무줄을 풀고, 석고형을 두드리거나 압력을 가하여 성형체를 분리한다. 주입구의 유도관에 남은 소지를 칼로 잘라낸다. 손잡이 등의 부분품 부착이 필요한 제품은 성형품이 완전히 건조되기 전에 접착 부위에 물을 바르고 필요한 부분품을 부착한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8262","dJobECdNm":"[8262]점토제품 생산기계 조작원","dJobJCd":"8432","dJobJCdNm":"[8432]점토제품 생산기 조작원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005946:1', '{"dJobCd":"K000005946","dJobCdSeq":"1","dJobNm":"제토기조작원","workSum":"벽돌 등 점토제품 제조 시 야적된 원료를 성형에 필요한 원료상태로 가공하기 위해 제토공정을 관리하고 해당 기계를 운전·조작하여 원료를 제토한다.","doWork":"벽돌 등 성형물의 종류를 확인하고 제토할 원석 및 원료의 상태를 육안으로 관찰한다. 원료상태에 따라 제토에 적합한 유압진공토련기, 이동컨베이어, 석발기, 혼합기 등을 점검하고 확인한다. 작은 돌을 골라내기 위하여 원료를 이동컨베이어를 통하여 석발기의 호퍼(Hopper:분립체의 저장 및 공급장치)에 투입한다. 육안으로 확인되는 불순물이나 큰 돌을 골라낸다. 석발기를 통해 1차 제토된 원료를 찰지고 공기층을 없애기 위해 진공토련기에 투입하여 고밀도의 점토소지분말로 제토한다. 투입된 원료가 토련기를 통과하여 나오는 상태를 확인하고, 고밀도화된 점토소지의 절단면을 검사하여 불순물과 기포의 존재 유무를 검사한다. 작업이 끝난 후 장비를 청소하고 작업일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8262","dJobECdNm":"[8262]점토제품 생산기계 조작원","dJobJCd":"8432","dJobJCdNm":"[8432]점토제품 생산기 조작원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004748:1', '{"dJobCd":"K000004748","dJobCdSeq":"1","dJobNm":"주입소지제조원","workSum":"주입성형에 용이한 비중으로 소지토를 조제하기 위하여 해교제를 첨가하고 교반하여 슬립을 제조한다.","doWork":"제조할 슬립의 종류와 작업표준에 따른 성형물에 적합한 슬립의 농도 등 슬립제조 기준을 확인한다. 슬립제조할 소지토의 밀도, 입자상태를 육안으로 확인한다. 슬립(Slip)교반기 탱크 내부의 청결상태를 확인하고 교반기의 스위치를 넣어 작동의 이상 유무를 점검한다. 소지토와 해교제(고체를 슬립화 하는 것)를 준비한 후 교반탱크에 일정량의 물을 투입한다. 해교에 필요한 적당량의 해교제를 교반탱크에 투입한다. 교반탱크의 용량을 감안하여 소지토의 무게를 계산하고, 저울로 무게를 재서 작업대 위에 올려놓고 교반기를 작동시킨 후 소지토를 가는 철사로 조금씩 잘라 투입한다. 소지토의 투입이 끝나면 뚜껑을 닫고, 작업상황표에 교반 시작시간을 기재한다. 규정시간 동안 교반이 끝난 슬립을 적당한 눈금의 체를 통과시켜 슬립저장탱크에 저장한다. 슬립의 비중을 측정하여 비중을 확인한 후 제품생산에 적당한 비중으로 조정한다. 교반기와 사용기구를 물로 세척한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8262","dJobECdNm":"[8262]점토제품 생산기계 조작원","dJobJCd":"8432","dJobJCdNm":"[8432]점토제품 생산기 조작원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004127:1', '{"dJobCd":"K000004127","dJobCdSeq":"1","dJobNm":"줄무늬세공기조작원","workSum":"도기의 가장자리나 표면에 금줄 등의 줄무늬를 넣거나, 유색유약으로 줄무늬를 세공하는 기계를 운전·조작한다.","doWork":"세공할 도기류의 외형과 세공부위 및 세공내역을 작업지시서에서 확인하고 세공기의 작동 여부를 확인한다. 액체금, 액체백금, 유색유약 등 세공액을 준비한다. 가공할 기물의 형태에 알맞은 척을 선택하여 기계에 장치한다. 세공기의 롤러와 암(Arm) 등의 위치를 레버로 조정하여 세공할 기물의 위치에 맞춘다. 미리 혼합한 액체상태의 금이나 백금을 롤러의 구멍에 붓는다. 기물을 척에 고정하고 세공기를 가동한다. 세공되는 과정을 육안으로 관찰하며 주시한다. 가공이 완료된 기물을 기계에서 빼내어 작업지시서와 비교한다. 불량률 및 생산작업량을 기록하여 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"다습|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"줄무늬작업원","dJobECd":"8262","dJobECdNm":"[8262]점토제품 생산기계 조작원","dJobJCd":"8432","dJobJCdNm":"[8432]점토제품 생산기 조작원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005521:1', '{"dJobCd":"K000005521","dJobCdSeq":"1","dJobNm":"내장재가공원","workSum":"건축용 보드, 보온·단열재, 기타 석면제품의 절단·천공·홈가공·연삭·가압 등의 가공작업을 수행한다.","doWork":"작업표준 또는 설계도의 내용을 파악하여 가공방식과 작업순서 등을 결정한다. 석면가공 시 마스크를 착용한다. 작업에 필요한 기계와 공구를 준비하고 상태를 점검한다. 톱가공, 절단가공, 천공작업, 홈가공, 연삭작업, 가압성형작업 등 가공기술을 사용하여 작업표준서의 규격과 형태로 가공한다. 가공품의 규격과 형상을 작업표준과 비교·확인한다. 가압성형작업의 경우 작업물이 적재된 대차를 프레스에 밀어 넣고 압력을 가하여 작업한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"내장재연삭원, 내장재절단원, 내장재천공원, 내장재가압원","dJobECd":"8263","dJobECdNm":"[8263]시멘트·광물제품 생산기계 조작원","dJobJCd":"8433","dJobJCdNm":"[8433]시멘트 및 광물제품 제조기 조작원","dJobICd":"C239","dJobICdNm":"[C239]기타 비금속 광물제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005049:1', '{"dJobCd":"K000005049","dJobCdSeq":"1","dJobNm":"내장재배합원","workSum":"내장재 생산을 위해 원료를 배합·혼합·교반한다.","doWork":"내장재 원료인 석면·펄프·시멘트를 수령하여 작업대로 운반한다. 정량분배기에 원료를 투입하고 수치를 입력하여 펄프제조기에 공급한다. 펄프제조기(Pulper)를 작동하고 석면과 펄프, 시멘트를 배합비에 따라 투입하여 혼합한다. 원료의 혼합이 완료되면 펄프제조기의 배출밸브를 열어 혼합원료를 배출하여 교반기에 투입한다. 교반기를 작동하여 규정시간 동안 교반한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|고온|다습|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8263","dJobECdNm":"[8263]시멘트·광물제품 생산기계 조작원","dJobJCd":"8433","dJobJCdNm":"[8433]시멘트 및 광물제품 제조기 조작원","dJobICd":"C239","dJobICdNm":"[C239]기타 비금속 광물제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002969:1', '{"dJobCd":"K000002969","dJobCdSeq":"1","dJobNm":"단열재마무리원","workSum":"압축 성형된 타일, 벽돌 등 습한 상태의 단열제품을 건조하고 선별, 정형하여 포장한다.","doWork":"건조기를 가동하여 소성공정에서 발생되는 폐열을 회수(재활용)하여 제품을 건조한다. 성형품을 건조기에 투입하고 건조온도, 습도, 풍량, 풍속이 자동으로 조절되어 최적의 건조상태를 유지하도록 한다. 제품의 비중과 밀도를 측정하여 제품의 표준규격과 비교, 검사하고 외관을 육안으로 검사한다. 합격품을 지정된 상자에 담고 상자에 제조번호(Lot Number), 제조일자, 규격 등을 표시한다. 포장된 제품을 지정된 장소로 운반하여 적재한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"단열공","connectJob":"단열재선별원, 단열재건조원","dJobECd":"8263","dJobECdNm":"[8263]시멘트·광물제품 생산기계 조작원","dJobJCd":"8433","dJobJCdNm":"[8433]시멘트 및 광물제품 제조기 조작원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001603:1', '{"dJobCd":"K000001603","dJobCdSeq":"1","dJobNm":"단열재형틀관리원","workSum":"보온 단열재 생산에 필요한 형틀을 관리·보관한다.","doWork":"형틀관리지침에 따라 각종 형틀의 규격, 수량을 점검한다. 성형작업 부서의 요청에 따라 형틀을 입고, 출고하고 기록지에 기록한다. 형틀이 반납되면 검사를 실시하여 마모 및 손상 정도에 따라 수선 및 폐기를 결정한다. 반납된 형틀을 세척하고 수선한다. 수선된 형틀을 적재대에 올려 보관한다. 생산자의 요구에 따라 규격 외 형틀을 특별생산하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8263","dJobECdNm":"[8263]시멘트·광물제품 생산기계 조작원","dJobJCd":"8433","dJobJCdNm":"[8433]시멘트 및 광물제품 제조기 조작원","dJobICd":"C239","dJobICdNm":"[C239]기타 비금속 광물제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005973:1', '{"dJobCd":"K000005973","dJobCdSeq":"1","dJobNm":"레미콘플랜트운전원","workSum":"레미콘플랜트 설비를 조작하여 레미콘차량의 믹서기로 레미콘(Ready Mixed Concrete:바로 사용할 수 있도록 반죽해 놓은 콘크리트)을 방출한다.","doWork":"호퍼(Hopper:분립체의 저장 및 공급장치)와 사일로(Silo)에 있는 원자재를 레미콘플랜트 본체의 저장소에 채운다. 출하실로부터 전달받은 생산주문에 따라 배합코드를 입력하고 운전 스위치를 누른다. 레미콘 차량이 방출구 아래에 위치하면 차량번호를 확인하고 제품코드와 생산량을 입력한 후 스위치를 눌러 레미콘을 방출한다. 다음 차량이 위치하면 같은 방식으로 계속하여 레미콘을 차량믹서기로 방출한다. 일일 작업이 끝난 후에는 플랜트 내의 저장소에 있는 물을 이용하여 믹서기를 세척하고 차량의 믹서기로 방출한 후 폐수처리장으로 보낸다. 일일, 주간, 월간 정비 계획에 따라 플랜트의 필요 부위에 그리스를 주입하거나 기름을 보충하고 베어링 점검 및 교체, 사일로, 믹서기, 집진장치, 컨베이어 등의 이상 유무를 점검한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8263","dJobECdNm":"[8263]시멘트·광물제품 생산기계 조작원","dJobJCd":"8433","dJobJCdNm":"[8433]시멘트 및 광물제품 제조기 조작원","dJobICd":"C233","dJobICdNm":"[C233]시멘트, 석회, 플라스터 및 그 제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004494:1', '{"dJobCd":"K000004494","dJobCdSeq":"1","dJobNm":"목탄제조설비운전원","workSum":"목탄을 제조하기 위하여 톱밥제조기, 숯가마, 목탄성형기를 작동한다.","doWork":"직경이 작은 톱밥을 만들기 위하여 톱밥제조기에 죽데기(제재하고 남은 찌꺼기)를 투입한다. 톱밥에 함유된 수분제거를 위해 톱밥을 건조실에 넣고 보일러를 운전한다. 건조된 톱밥의 일부를 가마에 투입하여 숯을 만든 다음 숯과 톱밥을 일정 비율로 혼합기에 투입하고 혼합한다. 생산할 목탄의 종류에 따라 첨가물을 추가하여 혼합하기도 한다. 혼합된 재료를 압축 성형장치에 투입하여 일정한 크기의 목탄을 생산한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|고온|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"숯제조설비운전원","dJobECd":"8263","dJobECdNm":"[8263]시멘트·광물제품 생산기계 조작원","dJobJCd":"8433","dJobJCdNm":"[8433]시멘트 및 광물제품 제조기 조작원","dJobICd":"C161","dJobICdNm":"[C161]제재 및 목재 가공업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001399:1', '{"dJobCd":"K000001399","dJobCdSeq":"1","dJobNm":"보온단열재성형원","workSum":"보온단열재의 원료를 형틀에 투입하여 가압·성형한다.","doWork":"작업에 필요한 형틀 및 공구와 장비를 준비하여 점검한다. 작업계획에 따라 성형할 단열재의 종류와 규격, 수량 및 형태를 확인한다. 점토원료에 보온단열기능의 원료를 배합하여 단열재 배합토를 만든다. 형틀을 프레스에 끼워 고정하고 제품에 알맞은 압력으로 조절한다. 주걱으로 단열재배합토를 형틀에 투입하고 프레스의 페달을 밟아 가압한다. 성형품에 강도와 내열도를 부여하기 위하여 수열합성반응기에 투입한다. 합성약품을 반응기에 넣고 밀폐하여 압력을 조절하고 일정 시간 반응을 진행한다. 완성된 단열재의 수량을 기록하고 지정장소에 적재한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8263","dJobECdNm":"[8263]시멘트·광물제품 생산기계 조작원","dJobJCd":"8433","dJobJCdNm":"[8433]시멘트 및 광물제품 제조기 조작원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004662:1', '{"dJobCd":"K000004662","dJobCdSeq":"1","dJobNm":"생석회세정탈수원","workSum":"생석회(生石灰, Quick Lime)를 제조하기 위해 양질의 석회석을 세척·입도분리하기 위한 관련 장비를 운전·조작한다.","doWork":"자동제어실(Control Room)에서 석회석 이송설비, 여과포의 상태, 슬러리 인입상태를 확인한다. 제어패널의 진동체 작동스위치를 넣고 석회석을 투입하여 입도(粒度, Grain Size)가 분리되는 상태를 확인한다. 레버를 조작하여 분리된 석회석에 물을 공급하여 세척한다. 세척된 석회석과 물을 분리하기 위하여 프레스필터(Press Filter)를 가동하고 여과판에 슬러리가 고착되는 것을 방지하기 위하여 슬러리제거펌프를 가동한다. 작업내용을 작업일지에 기록하고 물호스를 이용하여 탱크나 기계를 세척한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8263","dJobECdNm":"[8263]시멘트·광물제품 생산기계 조작원","dJobJCd":"8433","dJobJCdNm":"[8433]시멘트 및 광물제품 제조기 조작원","dJobICd":"C201","dJobICdNm":"[C201]기초 화학물질 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006257:1', '{"dJobCd":"K000006257","dJobCdSeq":"1","dJobNm":"석탄혼합원","workSum":"코크스 제조에 쓰이는 혼합물을 얻기 위하여 여러 성분의 석탄을 분쇄·혼합하는 기계 및 장비를 조작한다.","doWork":"석탄 불출기와 컨베이어벨트를 이용해 석탄을 운반한다. 해머가 장치된 해머분쇄기를 작동한다. 석탄흐름의 불균형, 기계고장을 알아내기 위하여 기계의 작동상태를 관찰한다. 석탄불출기의 출구가 막히는 것을 방지하여 석탄의 불출이 원활하게 이루어질 수 있도록 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8263","dJobECdNm":"[8263]시멘트·광물제품 생산기계 조작원","dJobJCd":"8433","dJobJCdNm":"[8433]시멘트 및 광물제품 제조기 조작원","dJobICd":"C191","dJobICdNm":"[C191]코크스 및 연탄 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004650:1', '{"dJobCd":"K000004650","dJobCdSeq":"1","dJobNm":"석회소성원","workSum":"클링커(Clinker:시멘트의 원료가 덩어리로 소성된 것) 생산을 위해 조합원료의 투입, 예열, 소성, 냉각과정에 이르는 공정을 운용한다.","doWork":"제어실(Control Room)에서 사일로(Silo)에 공급된 원료를 공급하기 위해 정량공급기를 운전한다. 예열실과 회전 소성로의 위치별 온도·압력을 최적상태로 조정하기 위해 연료, 원료의 투입량과 배기량을 조절한다. 생산된 클링커의 열회수를 위해 냉각공정의 압력 및 유량을 조정한다. 냉각된 클링커(Clinker)의 저장을 위해 수송 공정의 운전 및 경로설정 등을 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8263","dJobECdNm":"[8263]시멘트·광물제품 생산기계 조작원","dJobJCd":"8433","dJobJCdNm":"[8433]시멘트 및 광물제품 제조기 조작원","dJobICd":"C233","dJobICdNm":"[C233]시멘트, 석회, 플라스터 및 그 제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006044:1', '{"dJobCd":"K000006044","dJobCdSeq":"1","dJobNm":"석회유정제원","workSum":"생석회와 물을 반응시킨 석회유(石灰乳, Milk of Lime)를 원심분리하여 정제유와 조유로 분리한다.","doWork":"자동제어장치(Control Panel)를 확인하여 원심분리기 및 스크린(Screen:걸러내는 장치)의 상태를 점검한다. 제어장치 버튼이나 레버를 조작하여 회전소회기(Rotary Panel)나 생석회 소회에 필요한 용수와 증기를 투입한다. 회전소회기를 가동하고 배출되는 잔사량에 따라 스팀 및 공업용수의 투입량을 조절한다. 이송펌프를 가동하여 소회된 석회유를 원심분리기에 투입한다. 원심분리된 정제유와 조유를 탱크로 이송하여 저장한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8263","dJobECdNm":"[8263]시멘트·광물제품 생산기계 조작원","dJobJCd":"8433","dJobJCdNm":"[8433]시멘트 및 광물제품 제조기 조작원","dJobICd":"C201","dJobICdNm":"[C201]기초 화학물질 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006070:1', '{"dJobCd":"K000006070","dJobCdSeq":"1","dJobNm":"소성로조작원","workSum":"석회석 및 백운석의 분광석을 고로 원료로 사용하기 위해 미분쇄(微粉碎)한 후 소성(燒成)하여 미분광석으로 제조하는 파쇄기, 소성로 및 관련 설비를 조작한다.","doWork":"작업지시 및 작업계획을 확인하고 저장소의 원료 재고량을 파악한다. 원료수세설비를 가동하여 원료의 불출, 수송, 선별 및 수세 상태를 확인하고 불출량을 조절한다. 가동 중인 기기를 점검한다. 원석을 작업표준에 준하는 규정 크기로 파쇄하기 위하여 파쇄설비를 조작한다. 기기상태를 점검하고 소성로 내부를 관찰하여 소성상태·화염상태 등을 관찰한 후 가스량, 연소 및 냉각 공기량을 조정한다. 석회소성로(Shaft Kiln:수직형 석회소성로)의 각 댐퍼(Damper:공기통), 플랩(Flap)의 개폐상태, 장입량 레벨계 작동상태, 연소용 가스 공급상태를 점검한다. 예열실의 퓨셔 작동상태 및 레벨상태를 점검하고 제품의 소성상태를 측정하여 반영하며 사이클론(Cyclone:원심분리기)을 점검·불출한다. 소성된 원료를 불출하고 재고량을 관리한다. 일일점검 및 정기점검을 통하여 각종 설비를 점검하고 이상 시 보수의뢰 한다. 작업내용 및 재고량 등을 작업일지에 기록하고 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|고온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"조작운전","dJobECd":"8263","dJobECdNm":"[8263]시멘트·광물제품 생산기계 조작원","dJobJCd":"8433","dJobJCdNm":"[8433]시멘트 및 광물제품 제조기 조작원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005210:1', '{"dJobCd":"K000005210","dJobCdSeq":"1","dJobNm":"시멘트냉각기조작원","workSum":"회전형 노에서 발생하는 분진을 방지하고, 시멘트 성형기의 분쇄효율을 높이기 위하여 냉각기를 운전·조작한다.","doWork":"회전가마(Rotary Kiln)에서 소성된 클링커(Clinker)의 분진(Dust) 생성을 방지하고, 시멘트의 품질을 관리한다. 클링커가 지니고 있는 고열을 소성가마에 불어 넣어 공기를 예열한다. 시멘트밀(Cement Mill)의 분쇄효율을 높이기 위하여 냉각기를 운전·조작한다. 냉각기의 가동·조절·정지를 위하여 자동제어실(Control Room)의 패널(Panel)상의 스위치, 밸브, 레버를 조작하며, 냉각기에 부착된 송풍팬을 가동하고 작동상태를 확인한다. 냉각작업장과 자동제어실과의 연락을 통하여 냉각기의 작동상태와 오일펌프의 순환상태를 파악한다. 냉각이 완료된 클링커를 저장소(Clinker Storage Hall)로 운반시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"8263","dJobECdNm":"[8263]시멘트·광물제품 생산기계 조작원","dJobJCd":"8433","dJobJCdNm":"[8433]시멘트 및 광물제품 제조기 조작원","dJobICd":"C233","dJobICdNm":"[C233]시멘트, 석회, 플라스터 및 그 제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004194:1', '{"dJobCd":"K000004194","dJobCdSeq":"1","dJobNm":"시멘트원료투입관리원","workSum":"시멘트제조를 위해 원료수송공정의 설비를 유지관리하고 원료공급량을 조절한다.","doWork":"시멘트원료 수송라인의 각 호퍼(Hopper:분립체의 저장 및 공급장치)의 용량이나 벨트컨베이어, 크레인 등의 상태를 확인한다. 호퍼의 원료투입구가 막혀 원료의 공급량에 변동이 생겼을 때에는 이를 조정하여 정량의 원료가 공급되도록 조치한다. 운전 중 특이사항 및 조치사항을 다음 근무자에게 기록하여 전달한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"호퍼관리원, 호퍼운전원","dJobECd":"8263","dJobECdNm":"[8263]시멘트·광물제품 생산기계 조작원","dJobJCd":"8433","dJobJCdNm":"[8433]시멘트 및 광물제품 제조기 조작원","dJobICd":"C233","dJobICdNm":"[C233]시멘트, 석회, 플라스터 및 그 제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003369:1', '{"dJobCd":"K000003369","dJobCdSeq":"1","dJobNm":"시멘트원료투입원","workSum":"시멘트원료 분쇄기에 원료를 투입하는 호퍼(Hopper) 및 정량공급 장치를 관리한다.","doWork":"시멘트원료가 분쇄기에 공급되는 상태를 관찰한다. 호퍼(Hopper, 분립체의 저장 및 공급장치)의 원료투입구가 막혀 원료공급이 중지되면 호퍼와 분쇄기를 정지하고 이상 물질이나 덩어리 원료를 제거한다. 정량공급장치의 청결상태를 유지하여 계량오차 발생을 방지하도록 관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"호퍼원, 벨트원","dJobECd":"8263","dJobECdNm":"[8263]시멘트·광물제품 생산기계 조작원","dJobJCd":"8433","dJobJCdNm":"[8433]시멘트 및 광물제품 제조기 조작원","dJobICd":"C233","dJobICdNm":"[C233]시멘트, 석회, 플라스터 및 그 제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006911:1', '{"dJobCd":"K000006911","dJobCdSeq":"1","dJobNm":"시멘트플랜트운전원","workSum":"시멘트 클링커를 규정된 입도로 분쇄하기 위하여 시멘트밀을 운전·조작한다.","doWork":"자동제어실(Control Room)의 패널(Panel)상의 각종 계기를 조작하여 이송장치를 가동하고 시멘트밀, 클링커, 응결 지연재인 석고를 배합비율에 맞추어 분쇄기에 투입한다. 수시로 패널상의 계기를 확인하고, 분쇄기의 회전속도를 점검한다. 분쇄작업장과 연락을 통하여 분쇄기의 정상 가동 여부를 확인한다. 규정시간 동안 분쇄기를 가동하고, 시멘트밀의 시멘트 배출구를 연다. 벨트 컨베이어로 시멘트를 저장조(Silo)에 보관하는 일을 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"8263","dJobECdNm":"[8263]시멘트·광물제품 생산기계 조작원","dJobJCd":"8433","dJobJCdNm":"[8433]시멘트 및 광물제품 제조기 조작원","dJobICd":"C233","dJobICdNm":"[C233]시멘트, 석회, 플라스터 및 그 제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003316:1', '{"dJobCd":"K000003316","dJobCdSeq":"1","dJobNm":"시멘트플랜트현장조작원","workSum":"시멘트제조를 위한 분쇄 및 소성공정의 설비가 최적 상태로 가동되도록 점검하는 등 현장설비의 유지관리 업무를 수행한다.","doWork":"클링커(Clinker) 분쇄기, 냉각기, 예열탑, 컨베이어, 사일로(Silo) 등의 시멘트 생산플랜트의 각종 설비가 원활히 가동되도록 감시한다. 이상발생 시 통제실(Control Room)의 운전원과 무전으로 연락을 취한다. 현장에서 예방정비를 실시하고 설비 주변의 안전과 청결을 유지한다. 통제실의 요청 또는 이상발생 시 통제실 운전원과의 통신으로 설비를 조작, 조절하는 조치를 취한다. 설비의 보수사항이 발생하면 안전작업을 위한 예방조치와 작업의 감시 및 작업 후 시운전 등을 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"시멘트생산설비관리원, 시멘트설비점검원, 시멘트필드맨","connectJob":"시멘트밀조공, 타워공, 쿨러공, 로밀조공","dJobECd":"8263","dJobECdNm":"[8263]시멘트·광물제품 생산기계 조작원","dJobJCd":"8433","dJobJCdNm":"[8433]시멘트 및 광물제품 제조기 조작원","dJobICd":"C233","dJobICdNm":"[C233]시멘트, 석회, 플라스터 및 그 제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006025:1', '{"dJobCd":"K000006025","dJobCdSeq":"1","dJobNm":"아스콘플랜트운전원","workSum":"아스콘(Asphalt Concrete:아스팔트와 콘크리트의 혼합물)을 생산하는 플랜트설비를 조작하여 아스콘차량으로 방출한다.","doWork":"출하계로부터 수령한 생산주문서를 보고 아스콘의 종류, 혼화재료의 종류 및 사용량 등을 확인한다. 스위치를 조작하여 건조로의 버너를 가열하고 골재를 건조로에 투입한다. 배합비율을 자동제어장치에 코드로 입력한다. 아스콘차량이 들어오면 차량번호, 납품서, 배합보고서를 확인하고 아스콘을 방출한다. 정비계획에 따라 플랜트의 각 부위에 그리스를 주입하거나 기름을 보충하고 베어링을 점검 및 교체한다. 건조기, 혼합기, 집진장치, 계량호퍼, 사일로(Silo) 등의 이상 유무를 점검하고 조치한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"조작운전","dJobECd":"8263","dJobECdNm":"[8263]시멘트·광물제품 생산기계 조작원","dJobJCd":"8433","dJobJCdNm":"[8433]시멘트 및 광물제품 제조기 조작원","dJobICd":"C233","dJobICdNm":"[C233]시멘트, 석회, 플라스터 및 그 제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006276:1', '{"dJobCd":"K000006276","dJobCdSeq":"1","dJobNm":"양생원","workSum":"성형이 완료된 콘크리트제품의 초기강도를 확보하기 위하여 보일러의 증기를 사용하여 숙성시키는 양생(養生, Curing)작업을 한다.","doWork":"증기공급 파이프 및 밸브, 측정설비, 양생실 뚜껑 잠금장치 및 양생실 내부의 청소상태, 배수상태를 점검한다. 연료탱크의 유량게이지를 확인하고 보일러를 시운전하여 증기압을 확인한다. 성형이 완료된 제품을 양생실에 적재한다. 보일러실의 핸드밸브를 열어 증기를 공급하고 양생실의 최고온도를 설정한다. 초기에 밸브의 일부를 개방하고 일정 시간 경과 후 완전히 개방한다. 온도계를 관찰하여 양생실 온도를 점검하고 양생시간을 준수한다. 양생작업이 완료되면 증기공급을 서서히 중단하여 내부 온도를 내리고 대기온도와 비슷해지면 양생실을 개방한다. 양생 중 증기공급 등 이상이 발생하면 생산부서장에게 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|고온|다습|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","certLic":"콘크리트기능사, 콘크리트산업기사","dJobECd":"8263","dJobECdNm":"[8263]시멘트·광물제품 생산기계 조작원","dJobJCd":"8433","dJobJCdNm":"[8433]시멘트 및 광물제품 제조기 조작원","dJobICd":"C233","dJobICdNm":"[C233]시멘트, 석회, 플라스터 및 그 제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001403:1', '{"dJobCd":"K000001403","dJobCdSeq":"1","dJobNm":"연마숫돌납부착원","workSum":"연마숫돌을 제조하기 위하여 연마숫돌 중심에 납을 부착하여 구멍을 보강하는 작업을 한다.","doWork":"전원 스위치를 넣어 도가니에 납을 용해한다. 규정된 직경의 쇠봉을 작업대에 세우고 연마숫돌을 끼운다. 작업대의 연마숫돌을 회전시키며 고정구를 사용하여 중심을 맞춘다. 납주입 공구를 쇠봉에 끼우고 쇠봉과 중심구멍 사이로 납을 부어 납이 굳으면 연마숫돌을 빼낸다. 부싱(Bushing)을 부착하는 경우에는 내경 규격에 맞는 부싱을 중심구멍 사이에 끼우고 압착기로 압착하여 부착하기도 한다. 손칼이나 연삭기계를 사용하여 여분의 납을 제거한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"부싱원","dJobECd":"8263","dJobECdNm":"[8263]시멘트·광물제품 생산기계 조작원","dJobJCd":"8433","dJobJCdNm":"[8433]시멘트 및 광물제품 제조기 조작원","dJobICd":"C239","dJobICdNm":"[C239]기타 비금속 광물제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005984:1', '{"dJobCd":"K000005984","dJobCdSeq":"1","dJobNm":"연마숫돌세공기조작원","workSum":"연마숫돌을 작업지시서에 지시된 표면의 형태로 만들기 위하여 원형 절삭공구가 설치된 선반기계를 설치·조작한다.","doWork":"작업지시서에 따라 소성 및 열경화공정을 마친 반제품 연마숫돌의 수량을 확인한다. 연마숫돌의 종류에 따라 세공기의 절삭공구를 교체한다. 세공기가 자동컨베이어 방식인 경우 이송장치에 절삭숫돌을 장치하기도 한다. 유리칸막이를 열고 세공할 연마숫돌을 선반 축에 위치하고 렌치로 고정한다. 수치제어 패널의 버튼을 눌러 절삭각도, 깊이, 시간 등을 입력한다. 유리칸막이를 닫고 버튼을 눌러 가공한다. 세공이 완료되면 자, 버니어켈리퍼스, 전자마이크로미터를 사용하여 두께, 외경, 내경을 확인하고 표면가공형태를 검사한다. 특수한 형상부분이 있을 경우 수동세공기를 사용하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"연마숫돌생정형원","dJobECd":"8263","dJobECdNm":"[8263]시멘트·광물제품 생산기계 조작원","dJobJCd":"8433","dJobJCdNm":"[8433]시멘트 및 광물제품 제조기 조작원","dJobICd":"C239","dJobICdNm":"[C239]기타 비금속 광물제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004706:1', '{"dJobCd":"K000004706","dJobCdSeq":"1","dJobNm":"연마숫돌연마원","workSum":"연마숫돌의 표면을 규정된 규격대로 연마하기 위하여 가압회전 연마기를 조작한다.","doWork":"작업지시서에 따라 작업물의 수량, 규격을 확인한다. 연마제의 충진을 확인한다. 평면연마기의 안전유리를 열고 호퍼(Hopper:분립체의 저장 및 공급장치)에 연마숫돌을 고정한다. 자동제어 패널에 작업시간, 작업물의 크기 등을 입력한다. 스위치를 눌러 호퍼를 회전시키고 연마숫돌의 표면에 연마제를 공급한다. 생산된 제품의 치수, 평형도, 내경, 외경을 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|다습|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8263","dJobECdNm":"[8263]시멘트·광물제품 생산기계 조작원","dJobJCd":"8433","dJobJCdNm":"[8433]시멘트 및 광물제품 제조기 조작원","dJobICd":"C239","dJobICdNm":"[C239]기타 비금속 광물제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002525:1', '{"dJobCd":"K000002525","dJobCdSeq":"1","dJobNm":"연마숫돌품질검사원","workSum":"제조된 연마숫돌을 작업표준에 명시된 기준과 비교·검사하고 시험한다.","doWork":"작업지시서에 따라 검사할 연마숫돌의 규격, 수량을 확인하고 검사도구를 준비한다. 육안검사로 균열, 색상, 표면균열 등 결함을 검사하고 경도기, 초음파측정기를 사용하여 외경, 내경, 두께를 측정한다. 결합도측정기를 사용하여 연마제의 결합상태를 검사한다. 수평시험대를 사용하여 평행도를 검사한다. 저울로 중량을 확인한다. 품질기준에 합격한 연마숫돌을 회전시험기에 끼우고 일정 시간 회전시켜 안정도 검사를 한다. 불량품의 경우 재생 가능한 상태와 폐기상태를 구별하여 표시한다. 양품을 규격, 수량, 품목, 검사필증을 부착하고 적재한다. 검사기기를 점검하고 청결하게 유지한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"조작운전","certLic":"화학분석기능사","dJobECd":"8263","dJobECdNm":"[8263]시멘트·광물제품 생산기계 조작원","dJobJCd":"8433","dJobJCdNm":"[8433]시멘트 및 광물제품 제조기 조작원","dJobICd":"C239","dJobICdNm":"[C239]기타 비금속 광물제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001346:1', '{"dJobCd":"K000001346","dJobCdSeq":"1","dJobNm":"연마지접착제도포기조작원","workSum":"연마지를 제조하기 위하여 섬유나 종이에 접착제를 도포하는 기계를 운전·조작한다.","doWork":"기계의 축에 호이스트를 이용하여 재료공급 롤을 끼워 고정하고, 섬유 또는 종이를 사이징머신(Sizing Machine)의 투입롤에 잇는다. 혼합된 접착제를 이송펌프나 통에 받아 사이징기의 용기에 접착제를 투입한다. 사이징머신의 스트레치율, 접착제온도, 건조장치온도, 압력, 경사도를 조절한다. 버튼을 조작해서 사이징머신을 작동시키고 공급롤의 속도에 따라 접착제 분사장치를 조정하여 접착제를 분사한다. 접착제의 도포상태를 확인하고 조정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8263","dJobECdNm":"[8263]시멘트·광물제품 생산기계 조작원","dJobJCd":"8433","dJobJCdNm":"[8433]시멘트 및 광물제품 제조기 조작원","dJobICd":"C239","dJobICdNm":"[C239]기타 비금속 광물제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004011:1', '{"dJobCd":"K000004011","dJobCdSeq":"1","dJobNm":"연마포지제조원","workSum":"천연 또는 인조 연마제의 분말을 종이 또는 헝겊에 접착제로 붙여 연마포지(硏磨布紙:쇠붙이의 녹 따위를 닦는, 금강사나 유리가루를 발라 붙인 헝겊종이)를 제조하는 작업을 한다.","doWork":"작업지시서에 따라 생산할 연마포지의 종류, 수량을 점검하고 연마재를 준비한다. 연마포지 제조기계의 접착제, 연마지립(알루미나, 탄화규소 등의 결합되지 않은 입자형태의 연마원료)의 투입을 확인하고 기기를 예열한다. 호이스트를 이용하여 두루마리 상태의 기재(연마재를 접착할 천 또는 종이)를 회전축에 끼우고 한쪽 끝을 뽑아서 유도장치, 도포장치, 절단기에 결속한다. 스위치를 눌러 기기를 작동하고 유도장치의 원활한 공급, 연마지립의 부착상태, 절단기의 상태, 인쇄상태를 관찰하고 각 부분을 조정한다. 필요시 연마분진이 붙지 않게 하는 MSC(Metal Soap Coated) 작업을 실시하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"사포제조원","dJobECd":"8263","dJobECdNm":"[8263]시멘트·광물제품 생산기계 조작원","dJobJCd":"8433","dJobJCdNm":"[8433]시멘트 및 광물제품 제조기 조작원","dJobICd":"C239","dJobICdNm":"[C239]기타 비금속 광물제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005769:1', '{"dJobCd":"K000005769","dJobCdSeq":"1","dJobNm":"연마포후가공원","workSum":"롤형태로 감겨진 연마포를 규격에 맞추어 절단하고 접착하여 제품형태로 만드는 작업을 한다.","doWork":"작업지시서에 따라 가공할 연마포(硏磨布)의 수량, 종류를 확인한다. 호이스트를 사용하여 두루마리 형태의 연마포를 가공기의 축에 끼우고 렌치를 사용하여 고정한다. 연마포의 한쪽 끝을 길게 뽑아 절단기 롤러에 고정한다. 프레스절단기의 칼날을 점검하고 필요시 교체한다. 레버를 조작하여 연마포를 절단한다. 절단된 연마포를 포장공정으로 이송한다. 띠형, 밴드형 연마포의 경우 양 끝을 결속시키고 접착제를 바른 다음 접착기에 넣고 접착한다. 접착 후 양생시간을 고려하여 적치한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8263","dJobECdNm":"[8263]시멘트·광물제품 생산기계 조작원","dJobJCd":"8433","dJobJCdNm":"[8433]시멘트 및 광물제품 제조기 조작원","dJobICd":"C239","dJobICdNm":"[C239]기타 비금속 광물제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006433:1', '{"dJobCd":"K000006433","dJobCdSeq":"1","dJobNm":"연탄제조반장","workSum":"연탄을 제조하기 위하여 석탄을 분쇄·혼합·성형하는 작업원의 활동을 조정·감독한다.","doWork":"연탄생산을 위한 작업을 계획한다. 작업원의 활동을 지휘하며, 제품의 제조 및 출하를 확인·점검하고 보고한다. 작업상황에 따라 작업원의 작업장 임무를 변경하고 인원관리 계획을 세운다. 작업계획에 따라 세부실행계획을 수립하여 작업절차 및 방법을 결정하고 작업원에게 지시한다. 작업원에 대한 직무교육 및 안전위생 교육을 통하여 직무수행능력을 향상시키고 재해를 예방한다. 수시면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴하고 문제점을 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|","workFunc1":"조정","workFunc2":"감독","workFunc3":"단순작업","dJobECd":"8263","dJobECdNm":"[8263]시멘트·광물제품 생산기계 조작원","dJobJCd":"8433","dJobJCdNm":"[8433]시멘트 및 광물제품 제조기 조작원","dJobICd":"C191","dJobICdNm":"[C191]코크스 및 연탄 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004286:1', '{"dJobCd":"K000004286","dJobCdSeq":"1","dJobNm":"연탄제조원","workSum":"연탄을 제조하기 위하여 윤전기 등 각종기기 및 설비를 사용하여 원료들을 배합·분쇄·선탄·혼합·성형한다.","doWork":"분탄을 컨베이어에 적재하고 덩어리진 분탄은 분쇄기로 투입하여 분쇄한다. 선탄 중 발생하는 불순물을 제거한다. 기계의 이상 유무를 제탄원에게 알리고 기계부품의 윤활 및 정비를 돕는다. 운반된 석탄을 혼합기 스위치를 작동하여 혼합기에 투입한다. 해머가 장치된 해머분쇄기를 작동한다. 석탄흐름의 불균형, 기계고장을 알아내기 위하여 기계의 작동상태를 관찰한다. 망치로 호퍼(Hopper:분립체의 저장 및 공급장치)의 옆을 쳐서 출구가 막히는 것을 방지한다. 공구를 사용하여 분쇄기의 체 또는 원통형의 망을 조절한다. 출하하는 연탄의 수량, 불량 등을 확인하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"연탄제조윤전기조작원","dJobECd":"8263","dJobECdNm":"[8263]시멘트·광물제품 생산기계 조작원","dJobJCd":"8433","dJobJCdNm":"[8433]시멘트 및 광물제품 제조기 조작원","dJobICd":"C191","dJobICdNm":"[C191]코크스 및 연탄 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006154:1', '{"dJobCd":"K000006154","dJobCdSeq":"1","dJobNm":"예열기조작원","workSum":"클링커(Clinker) 소성플랜트의 예열공정이 원활하게 운영될 수 있도록 현장의 유지관리 업무를 수행한다.","doWork":"클링커(Clinker) 소성플랜트의 예열실로 투입되는 원료의 인출과 정량공급기 등을 점검, 조치하고 청결상태를 유지하며, 예열실 각 단의 원료가 정상적으로 유입되도록 일정 주기마다 점검한다. 필요시 물, 공기를 이용하여 내부의 부착원료를 제거하는 포킹(Forking)작업을 실시하여 예열실각 단의 온도와 압력을 유지한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"힘든 작업","workPlace":"실내·외","workEnv":"대기환경미흡|고온|소음·진동|","workFunc1":"비교","workFunc2":"감독","workFunc3":"제어조작","dJobECd":"8263","dJobECdNm":"[8263]시멘트·광물제품 생산기계 조작원","dJobJCd":"8433","dJobJCdNm":"[8433]시멘트 및 광물제품 제조기 조작원","dJobICd":"C233","dJobICdNm":"[C233]시멘트, 석회, 플라스터 및 그 제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005559:1', '{"dJobCd":"K000005559","dJobCdSeq":"1","dJobNm":"장탄원","workSum":"코크스의 건류상태를 확인하고, 장입차를 조작하여 해당 장입노에 원료탄을 장입하고 장입 후 상승관을 조작한다.","doWork":"계획에 따라 장입차를 조작하여 석탄탑으로부터 원료탄을 수탄한다. 장입구를 개폐하고 장입차와 장입구의 위치를 조정한다. 원료탄을 탄화실에 장입한다. 장입계획에 따라 해당 노의 상승관 커버를 열어 가스 및 코크스 수축상태를 관찰하고 관련 작업원에게 알린다. 노의 장입구에 카본 부착상태를 확인한다. 장입 후 장입구 주위의 잔탄을 처리하고 장입구 사이로 가스가 누설하지 않도록 조치한다. 장입차 및 소제봉을 점검 정비한다. 건류시간, 장입시간, 요출시간 등을 기록 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"조작운전","dJobECd":"8263","dJobECdNm":"[8263]시멘트·광물제품 생산기계 조작원","dJobJCd":"8433","dJobJCdNm":"[8433]시멘트 및 광물제품 제조기 조작원","dJobICd":"C191","dJobICdNm":"[C191]코크스 및 연탄 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006540:1', '{"dJobCd":"K000006540","dJobCdSeq":"1","dJobNm":"제탄원","workSum":"선탄기, 분쇄기, 혼합기를 조작하여 분탄(분상의 석탄 입자)을 제조한다.","doWork":"선탄기, 분쇄기 및 윤전기의 고장 유무를 확인한다. 작업일지를 확인한 후 컨베이어를 가동하고 작업지시서에 따라 여러 종류의 분탄을 일정 비율로 혼합하기 위하여 제어판의 호퍼(Hopper:분립체의 저장 및 공급장치) 조작스위치를 조정한다. 스크린·분쇄기·혼합기를 가동하고 배합된 분탄이 연속적으로 선탄·분탄·혼합되는 상태를 관찰한다. 작업량 등을 작업일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"힘든 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","dJobECd":"8263","dJobECdNm":"[8263]시멘트·광물제품 생산기계 조작원","dJobJCd":"8433","dJobJCdNm":"[8433]시멘트 및 광물제품 제조기 조작원","dJobICd":"C191","dJobICdNm":"[C191]코크스 및 연탄 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007033:1', '{"dJobCd":"K000007033","dJobCdSeq":"1","dJobNm":"초조기조작원","workSum":"내장재 원료(Slurry)로 얇은 판(Sheet)을 만들기 위하여 초조(抄造)기를 운전·조작한다.","doWork":"초조기(抄造)를 가동하여 이상 여부를 점검한다. 초조기의 통(Vat)에 담긴 슬러리 상태의 내장재 원료를 투입밸브를 열어 교반기에 투입한다. 각 원료를 계량하여 교반기에 투입하고 교반기의 속도를 조절한 후 규정시간 동안 교반한다. 슬러리 통의 수위와 농도를 일정하게 유지한다. 교반기에 연결된 초조기를 통해 경질의 판 형상을 성형한다. 시트가 제조되면 시트의 상태를 육안으로 검사한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8263","dJobECdNm":"[8263]시멘트·광물제품 생산기계 조작원","dJobJCd":"8433","dJobJCdNm":"[8433]시멘트 및 광물제품 제조기 조작원","dJobICd":"C239","dJobICdNm":"[C239]기타 비금속 광물제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004371:1', '{"dJobCd":"K000004371","dJobCdSeq":"1","dJobNm":"코크스노원","workSum":"코크스로에 장입된 원료탄을 최적 상태로 연소하기 위하여 계기실의 각종 기기를 조작·감시한다.","doWork":"탄화가스(COG:Cokes Oven Gas)의 유출을 방지하기 위하여 코크스로의 문(코크스오븐도어)에 패킹장치(Sealing Strip)를 설치한다. 계기실의 각종 기기로 노(爐) 안의 온도를 조정하고 연소상태, 유압상태를 최적으로 유지한다. 폐가스의 온도, 탄압, 가스압, 공기압을 측정한다. 유도장치를 조절하여 코크스로(爐)의 분출구를 이동시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"도어기조작원, 소성원, 코크스도어손질원, 코크스연소원","dJobECd":"8263","dJobECdNm":"[8263]시멘트·광물제품 생산기계 조작원","dJobJCd":"8433","dJobJCdNm":"[8433]시멘트 및 광물제품 제조기 조작원","dJobICd":"C191","dJobICdNm":"[C191]코크스 및 연탄 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002128:1', '{"dJobCd":"K000002128","dJobCdSeq":"1","dJobNm":"코크스배합기조작원","workSum":"코크스를 생산하기 위하여 적정 크기의 입자로 분해·건조된 원료를 규정된 배합비로 배합하는 장비를 조작한다.","doWork":"해머분쇄기를 작동시켜 원료를 적정 입도(粒度, Grain Size)로 분쇄한다. 분쇄된 원료를 컨베이어벨트로 이송하여 저장한다. 원료를 규정된 배합비의 무게로 계량하여 컨베이어에 투입하여 배합물을 저장소에 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8263","dJobECdNm":"[8263]시멘트·광물제품 생산기계 조작원","dJobJCd":"8433","dJobJCdNm":"[8433]시멘트 및 광물제품 제조기 조작원","dJobICd":"C191","dJobICdNm":"[C191]코크스 및 연탄 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007130:1', '{"dJobCd":"K000007130","dJobCdSeq":"1","dJobNm":"코크스성형원","workSum":"코크스 제조계획에 따라 배합탄을 적당한 크기로 성형한다.","doWork":"컨베이어를 작동하고 가열기에 배합탄을 투입한다. 스팀밸브를 열고 적절한 압력·온도를 유지하여 배합탄을 가열한다. 전동기와 회전판의 회전상태를 확인하고 공급용 탱크에 배합탄을 공급한다. 컨베이어를 작동하고 가열된 배합탄을 윤전기로 보낸다. 윤전기의 압력, 배합탄의 투입량을 조절하여 성형압축 강도를 유지하여 성형한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"코크스소성원","dJobECd":"8263","dJobECdNm":"[8263]시멘트·광물제품 생산기계 조작원","dJobJCd":"8433","dJobJCdNm":"[8433]시멘트 및 광물제품 제조기 조작원","dJobICd":"C191","dJobICdNm":"[C191]코크스 및 연탄 제조업","inqYear":"2011","etc":"소멸(코크스성형공장의 철거)"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002115:1', '{"dJobCd":"K000002115","dJobCdSeq":"1","dJobNm":"코크스연소반장","workSum":"코크스 및 그 부산물을 얻기 위하여 석탄을 코크스화시키는 일에 종사하는 작업원들의 활동을 감독·조정한다.","doWork":"생산량과 생산일정에 따라 축열실, 퓨셔사이드(Pusher Side), 코크스사이드(Cokes Side), CDQ(Coke Dry Quenching) 작업원들의 교대근무 일정표를 수립하고 근무현황을 관리한다. 기계류, 장비류, 제조된 코크스를 검사하며 규정된 품질의 제품을 생산하기 위하여 가열로를 변경하여 조작한다. 작업원들에게 장비조작 방법에 대해 교육한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"대기환경미흡|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","dJobECd":"8263","dJobECdNm":"[8263]시멘트·광물제품 생산기계 조작원","dJobJCd":"8433","dJobJCdNm":"[8433]시멘트 및 광물제품 제조기 조작원","dJobICd":"C191","dJobICdNm":"[C191]코크스 및 연탄 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003020:1', '{"dJobCd":"K000003020","dJobCdSeq":"1","dJobNm":"코크스제조반장","workSum":"제선(용광로) 조업에 적합한 품위의 경제성 있는 코크스를 제조하는데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"작업계획을 코크스제조원에게 지시하고 이행 여부를 확인한다. 코크스로, 건식소화설비 등 각종 설비와 이동장비를 점검하고 이상 및 불량 개소를 수리하도록 지시한다. 작업원의 직무수행능력 향상과 안전재해를 예방하기 위해 코크스로 및 관련 설비의 조정·관리요령 등 직무 및 안전위생 교육을 수행한다. 작업원을 수시로 관찰하고 면담하여 애로 및 건의사항을 수렴·해결하고 문제점을 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|고온|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","dJobECd":"8263","dJobECdNm":"[8263]시멘트·광물제품 생산기계 조작원","dJobJCd":"8433","dJobJCdNm":"[8433]시멘트 및 광물제품 제조기 조작원","dJobICd":"C191","dJobICdNm":"[C191]코크스 및 연탄 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;