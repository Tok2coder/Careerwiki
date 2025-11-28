INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003807:1', '{"dJobCd":"K000003807","dJobCdSeq":"1","dJobNm":"중판적재원","workSum":"합판을 제조하기 위해 접착제가 도포된 중판을 받아 받침대에 쌓는다.","doWork":"접착용 깔판을 접착기 앞에 놓고 깔판 위에 평판을 놓는다. 도포되어 나온 중판을 막대기로 받아 단판과 접착하기 위하여 단판 위에 놓고 중판의 찢어진 부분과 수리 부분은 손으로 겹쳐지지 않도록 받아 놓는다. 도포된 중판규격에 오차가 발생하면 중판을 투입하는 작업원에게 규격의 오차내용을 통보하여 알맞은 치수의 중판을 공급받고, 측면부위에 구멍이 발생하지 않도록 짝맞춤을 한다. 중판을 받아 놓을 때 맞춤변이 일직선이 되도록 밀착하고, 이때 중판이 밀리거나 단판과 중판의 겹침이 발생하지 않도록 한다. 도포되어 나온 중판의 도포상태를 확인하고 부분적으로 도포가 되지 않은 부분이나 겹침 및 오물로 인한 곳은 손으로 접착제를 바른다. 일정 높이까지 적재되면 냉각기로 운반한다. 적정함수율에 미달한 중판은 따로 적재하여 건조기에 재투입한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"약간의 시범정도","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"단순작업","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C162","dJobICdNm":"[C162]나무제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006306:1', '{"dJobCd":"K000006306","dJobCdSeq":"1","dJobNm":"증기통관리원","workSum":"무늬목을 제조하거나 기타 목재를 가공하기 위하여 통나무를 증기통이나 더운 물통에 담근다.","doWork":"기중기나 호이스트(Hoist)를 사용하여 증기통으로 통나무를 운반한다. 일정 수준의 증기압으로 열처리한다. 목재의 종류나 통나무의 크기에 따라 규정된 시간이 경과한 후 증기통에서 꺼내 원형톱으로 자르거나 나무껍질을 제거한다. 가공된 목재를 지정된 야적장 혹은 보관소로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C162","dJobICdNm":"[C162]나무제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006066:1', '{"dJobCd":"K000006066","dJobCdSeq":"1","dJobNm":"증열처리원","workSum":"성형된 하드보드(Hard Board)의 강도를 유지시키기 위해 증열처리기를 운전한다.","doWork":"적재된 제품을 급습실이나 열처리실에 넣고 문을 닫는다. 온도를 일정하게 유지하기 위해 조절판스위치를 조작한다. 증기나 열풍을 열처리실에 불어넣기 위해 밸브를 연다. 증열처리된 하드보드를 꺼내 지정된 장소로 옮긴다. 보드를 검사하여 긁힌 줄무늬자국이나 변색 등 결함 여부를 알아낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"조습원","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C162","dJobICdNm":"[C162]나무제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006244:1', '{"dJobCd":"K000006244","dJobCdSeq":"1","dJobNm":"침목가공원","workSum":"침목 같은 목재에 방부제의 침투가 용이하도록 절개하여 구멍을 뚫는 기계를 조작한다.","doWork":"기계에 렌치나 지렛대 등의 손공구를 사용하여 날이 박힌 인사이징 롤러(Incising Roller)를 설치하고 제품의 규격에 따라 치구를 고정한다. 공기밸브를 돌려 인사이징롤러의 압력을 조정하고 컨베이어를 작동한다. 다른 작업원에게 신호를 보내 침목의 형태로 만들어진 목재를 컨베이어 위에 적재하도록 한다. 레버를 움직이거나 발로 페달을 밟아 컨베이어의 속도를 조절하고 일정 규격에 따라 인사이징롤러를 사용하여 목재를 절개하여 구멍을 뚫는다. 인사이징롤러, 컨베이어의 부품, 베어링 등을 검사하고 손 공구를 사용하여 닳고 부서진 부품을 교체한다. 검인용 망치를 사용하여 품질표시용 소인을 찍기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"인사이징기조작원, 프리보링원","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C161","dJobICdNm":"[C161]제재 및 목재 가공업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006566:1', '{"dJobCd":"K000006566","dJobCdSeq":"1","dJobNm":"칩건조기운전원","workSum":"분쇄된 나뭇조각 칩(Chip)을 적정 함수율로 건조하기 위하여 건조기를 운전한다.","doWork":"연료의 재고상태 및 소화전 밸브의 작동상태를 확인한다. 투입할 칩과 건조 칩 저장탱크의 칩 양을 확인한다. 전원스위치를 넣고 건조기를 점화한다. 건조실의 온도가 일정한 수준에 도달하면 칩을 건조실로 투입하기 위하여 스위치를 조작한다. 건조된 칩이 선별기에서 중층과 표층용으로 분리되어 접착제 도포공정으로 이송되는 것을 관찰하고, 칩의 건조상태를 확인한다. 기계가 정지하면 기계의 구동부위에 윤활유 등을 주입한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"고온|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","connectJob":"파티클보드칩건조기운전원, 하드보드칩건조기운전원","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C162","dJobICdNm":"[C162]나무제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001689:1', '{"dJobCd":"K000001689","dJobCdSeq":"1","dJobNm":"칩저장실관리원","workSum":"칩 저장탱크에 있는 분쇄된 칩(Chip:나뭇조각)에서 철물 등의 이물질을 제거한다.","doWork":"칩 저장탱크에 펌프공급기로 물을 공급한다. 철물을 제거하기 위하여 전자석 장치에 전원스위치를 넣는다. 컨베이어를 작동하여 이송되는 칩에서 옹이나 규격보다 큰 칩을 제거한다. 칩과 물을 분리하기 위하여 진동분리 장치를 작동한다. 물과 분리된 칩을 컨베이어를 이용하여 저장탱크에 저장한다. 칩 저장탱크를 관리하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"대기환경미흡|다습|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C162","dJobICdNm":"[C162]나무제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005994:1', '{"dJobCd":"K000005994","dJobCdSeq":"1","dJobNm":"칩접착제혼합원","workSum":"파티클보드(Particle Board) 제조를 위하여 칩과 접착제를 혼합하는 기계를 운전한다.","doWork":"칩 저장탱크에서 레버를 당겨 칩(Chip:나뭇조각)을 혼합기(Mixer)로 보낸다. 작업지시서에 따라 수지접착제와 첨가제의 배합비 및 투입량을 정하여 혼합기에 투입한다. 손으로 칩을 만져보거나 칩의 무게를 재어 수분함유량을 측정한다. 칩이 너무 건조하면 혼합물에 물을 첨가한다. 칩건조기운전원(합판제조)에게 건조기 온도를 조정하여 칩의 수분함유량을 조정할 것을 통보한다. 레버를 당겨 혼합물을 압출기 호퍼(Hopper:분립체의 저장 및 공급장치)로 방출한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"칩접착제도포기운전원","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C162","dJobICdNm":"[C162]나무제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001391:1', '{"dJobCd":"K000001391","dJobCdSeq":"1","dJobNm":"코르크보드제조원","workSum":"코르크 분말을 가공하여 건축내장재, 코르크보드 등 각종 코르크판재를 제조한다.","doWork":"작업지시서를 확인하고 생산할 제품에 따라 코르크분말을 준비한다. 코르크분말을 믹서에 투입하고 배합비에 따라 접착제(포리졸:목공용 접착제) 또는 첨가물(고무, 우레탄 등)을 첨가한다. 믹서의 타이머를 설정하고 스위치를 눌러 작동시킨다. 믹서 하단의 밸브를 열어 배합된 코르크를 성형판에 투입한다. 레버를 조작하여 열판온도, 프레스압력, 속도를 조절한다. 초도품을 생산하고 이상이 없으면 연속해서 생산한다. 압축 성형된 코르크를 프레스기에서 꺼내어 건조한다. 건조된 코르크보드를 연마기를 사용하여 표면을 부드럽게 한다. 코르크보드를 자르거나 켜서 규격에 맞게 완성한다. 코르크판을 크기별로 분류하여 적재한다. 작업일지에 작업내용을 기록하고 코르크제품제조반장에게 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C163","dJobICdNm":"[C163]코르크 및 조물 제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005830:1', '{"dJobCd":"K000005830","dJobCdSeq":"1","dJobNm":"코르크선별원","workSum":"코르크보드를 만들기 위하여 코르크 분말을 생산하고 선별한다.","doWork":"입고된 코르크가루 또는 자투리 코르크를 모아 분쇄기에 투입한다. 미세먼지를 줄이기 위하여 스위치를 눌러서 집진기를 가동한다. 분쇄기를 가동하여 코르크분말을 생산한다. 컨베이어 벨트를 가동시키고 분쇄된 코르크분말을 입자 크기별로 구분된 망(거름채)에 통과시켜 크기별로 분류한다. 분류된 코르크분말을 자루에 담고 내용물을 표시하여 적재하거나 다음 공정으로 이동시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"약간의 시범정도","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C163","dJobICdNm":"[C163]코르크 및 조물 제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006234:1', '{"dJobCd":"K000006234","dJobCdSeq":"1","dJobNm":"코르크제품제조반장","workSum":"코르크제품을 제조하는 작업원의 활동을 감독·조정한다.","doWork":"생산계획에 따라 원료(코르크보드, 코르크분말, 반가공품) 및 자재의 소요량을 계산한다. 원료수입처에 주문서를 발주한다. 입고된 코르크의 수량, 두께, 재질, 입자크기를 확인하고 보관소에 적재하도록 작업원에게 지시한다. 생산의뢰서 및 샘플을 보고 생산할 코르크제품의 특성(모양, 용도, 가공면)을 파악한다. 재료가 최소한으로 사용되며 작업효율이 높은 작업방법을 고안한다. 작업지시서를 작성하고 작업원을 배치한다. 작업원에게 생산방법을 교육하고 생산활동을 관리·감독한다. 생산되어 나오는 코르크제품의 품질을 육안으로 검사한다. 코르크보드를 생산하는 경우에는 원재료와 부재료의 배합비율을 결정하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C163","dJobICdNm":"[C163]코르크 및 조물 제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004137:1', '{"dJobCd":"K000004137","dJobCdSeq":"1","dJobNm":"코르크제품제조원","workSum":"각종 코르크제품을 생산하기 위하여 코르크를 성형·가공한다.","doWork":"병마개, 받침, 손잡이, 장식용품 또는 각종 제품의 부분품에 사용되는 코르크제품을 만들기 위하여 제품에 따라 고안된 작업방법을 숙지한다. 코르크를 톱, 칼, 드릴, 펀치 등을 사용하여 가공한다. 생산할 제품에 따라 코르크와 부분품을 접착제로 접착하기도 한다. 경사면이나 굴곡 면을 가공하기 위하여 고안된 도구를 사용하기도 한다. 작업이 종료되면 작업 중에 발생한 코르크 가루를 자루에 담아 보관한다. 생산물의 수량을 파악하고 적재한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C163","dJobICdNm":"[C163]코르크 및 조물 제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002361:1', '{"dJobCd":"K000002361","dJobCdSeq":"1","dJobNm":"크로스커팅기조작원","workSum":"목재나 합판, 하드보드(Hard Board), 파티클보드(Particle Board)를 길이 방향으로 절단하는 기계톱(Cross Cutting Saw)을 조작한다.","doWork":"공기스위치를 열고 압력상태를 확인한다. 바닥에 있는 작동스위치를 발로 눌러 톱날을 전진시키고 발을 떼어 후진되는 상태를 점검한다. 강약 스위치를 좌우로 돌려 목재의 전·후진 속도를 조정한다. 안전레버를 열고 톱날을 끼운 다음 스패너를 사용하여 톱날고정용 나사를 조인 후 손으로 회전시켜 본다. 가동스위치를 넣고 톱날의 회전, 고정상태, 힘, 강도 등을 점검한 후 정지한다. 시험절단을 위해 소재를 테이블(작업대) 위에 놓고 작동스위치를 밟는다. 절단이 완료되면 규격을 확인하고 안내목을 규격대로 조절한다. 기계조작이 완료되면 연속작업을 실시한다. 절단된 소재는 규격별, 수종별로 적재하고 심한 갈림 등의 불량은 별도로 적재한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C161","dJobICdNm":"[C161]제재 및 목재 가공업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004067:1', '{"dJobCd":"K000004067","dJobCdSeq":"1","dJobNm":"톱밥제조기조작원","workSum":"톱밥을 제조하기 위하여 톱밥제조기를 운전한다.","doWork":"톱밥제조기를 작동시킨다. 목재로 사용이 불가능한 죽데기(Slabs:제재하고 남은 찌꺼기)를 손으로 직접 톱밥제조기에 투입한다. 톱밥제조기가 불순물에 걸려서 작동이 멈추면 불순물을 제거하는 등 기계를 정비한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C161","dJobICdNm":"[C161]제재 및 목재 가공업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007062:1', '{"dJobCd":"K000007062","dJobCdSeq":"1","dJobNm":"핑거조인트기조작원","workSum":"짧은 원목 부재에 핑거(부재와 부재의 결합부분)를 제작하고 접착제로 결합하여 집성재를 만드는 핑거조인트기를 조작한다.","doWork":"핑거조인트기를 작동한다. 선별된 짧은 각재를 핑거조인트기에 하나하나 투입한다. 일정 길이로 결합(핑거조인트)된 각재를 수동으로 반출한다. 간단한 고장의 경우 기계를 직접 정비한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"약간의 시범정도","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C162","dJobICdNm":"[C162]나무제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005972:1', '{"dJobCd":"K000005972","dJobCdSeq":"1","dJobNm":"합판보수원","workSum":"재단한 합판의 측면에 구멍이 난 곳을 공구 등을 사용하여 보수한다.","doWork":"재단한 제품의 측면을 확인하고 접착불량, 후미, 중판부족, 단판부족, 구멍 등의 불량부위를 표시한다. 불량부위의 색과 동일한 보수용 꼬챙이를 준비하고, 구멍의 크기에 맞추어 칼로 다듬는다. 다듬어진 꼬챙이에 풀칠을 한 후 구멍 속으로 들어가도록 나무망치로 박고, 보수 칼로 측면과 반듯하게 잘라낸다. 나무꼬챙이 대신 보수용 퍼티(Putty)를 넣어 보수하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"약간의 시범정도","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","connectJob":"합판측면보수원, 합판표면보수원, 퍼티보수원","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C162","dJobICdNm":"[C162]나무제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006794:1', '{"dJobCd":"K000006794","dJobCdSeq":"1","dJobNm":"합판연마기조작원","workSum":"규격에 맞추어 재단한 합판의 품질을 높이기 위하여 판면을 수평이 되도록 다듬고 연마하는 연마기를 조작한다.","doWork":"전동사포기계(Deluxe Sander)의 롤러 압력, 샌드페이퍼, 크로스페이퍼의 규격을 확인한다. 기계를 승강기 받침대와 수평이 되도록 조정하고, 연마할 합판을 연마기 중앙에 맞도록 적재한다. 연마하려는 제품의 두께에 따라 롤러의 간격을 조절한다. 테이블의 컨베이어속도와 기계의 투입속도를 일정하게 조절한다. 기계작동에 대한 이상 유무를 확인한다. 합판을 한 장 투입하여 계기판의 전압 및 연마된 상태를 표준규격과 비교·검토한다. 연마 상태가 양호하면 일정한 시간 간격을 유지하면서 연속적으로 투입하고 롤러의 마모를 방지하기 위하여 두 장이 겹쳐 투입되지 않는지 관찰한다. 연마된 제품의 상태를 확인하고 불량품은 분리하여 재연마하기도 하고, 부분적 연마불량은 사포를 사용하여 손으로 연마하기도 한다. 기계의 청결을 유지하고, 최종제품을 등급별, 크기별로 분류하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","connectJob":"무늬목연마기조작원, 하드보드연마기조작원, 파티클보드연마기조작원, 화장판연마기조작원","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C162","dJobICdNm":"[C162]나무제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005341:1', '{"dJobCd":"K000005341","dJobCdSeq":"1","dJobNm":"합판재단원","workSum":"합판제조 시 열압기(Hot Press)에서 접착된 제품을 가로, 세로 규격에 맞추어 재단하는 기계를 조작한다.","doWork":"제품의 규격에 따라 톱의 위치 및 간격을 조정한다. 기계의 맞춤판에 제품의 맞춤변을 밀착하면서 손으로 재단기 입구에 투입한다. 롤러 위의 오물 및 팬(Fan)의 흡입상태, 전동기의 가동 여부, 맞춤판의 유동상태 등을 확인한다. 먼저 한 장을 절단하여 재단 규격 및 기계 이상 여부를 점검하고, 이상이 없으면 연속작업을 한다. 재단한 제품의 가로, 세로 길이와 두께를 자로 측정하여 제품이 작업표준서와 일치하는지 검사한다. 개개의 검사결과를 재단검사 일지에 기록하고 합판품질관리원에게 통보한다. 재단기의 종류에 따라서는 절단한 제품의 단면을 손 대패질하여 잔 거스름을 제거하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","connectJob":"무늬목재단원, 하드보드재단원, 파티클보드재단원","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C162","dJobICdNm":"[C162]나무제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004303:1', '{"dJobCd":"K000004303","dJobCdSeq":"1","dJobNm":"합판접착제도포기조작원","workSum":"합판을 제작하기 위하여 단판과 중판에 접착제를 바르는 접착제도포기를 조작한다.","doWork":"포개기 작업이 끝난 단·중판을 승강반에 실어 운반한다. 운반한 단판을 두께와 규격에 따라 등급별로 구분한다. 배합실에서 온 접착제의 점도를 표준과 비교·확인한다. 중판의 두께에 따라 상·하롤러 간의 압력을 조절한다. 접착제 공급펌프의 스위치를 작동한다. 상·하롤러의 중앙에 일직선으로 투입되도록 조절한다. 중판이 접착롤러를 통과하기 전에 중판의 무게를 달아 도포량을 조절한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C162","dJobICdNm":"[C162]나무제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002080:1', '{"dJobCd":"K000002080","dJobCdSeq":"1","dJobNm":"합판제조반장","workSum":"합판을 제조하는 데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"작업지시서에 따라 생산될 제품의 양, 질, 치수를 결정하고 기계의 유용성 및 작업 우선순위를 검토하여 작업계획을 작성한다. 설비 및 장비의 작동 상태를 확인하고, 정비 및 부품 교체계획을 작성한다. 전체 공정이 원활히 수행되고 있는지를 수시로 확인하고 생산된 제품이 명세서와 일치하는지 확인한다. 기계, 재료, 사람으로 인하여 공정에 이상이 있거나 불량품이 발생하면 원인을 분석하여 해결한다. 신입 작업원을 훈련하고 업무를 할당한다. 안전사고 예방교육을 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","connectJob":"파티클보드제조반장, 하드보드제조반장","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C162","dJobICdNm":"[C162]나무제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006817:1', '{"dJobCd":"K000006817","dJobCdSeq":"1","dJobNm":"해섬기운전원","workSum":"하드보드(Hard Board) 제조 시 에어클리너(Air Cleaner)에서 세척되어 자동 이송된 칩(Chip:나뭇조각)의 해섬 효율을 높이기 위하여 침지기와 고해기를 운전한다.","doWork":"제어반(Control Board)에 나타나는 계기의 수치를 보며 기계를 작동한다. 칩으로부터 소정의 섬유 굵기가 나오도록 수치를 입력하고 추출된 섬유의 상태를 육안으로 확인한다. 계기판에 나타난 변화를 관찰하고 전압, 증기압, 온도, 속도 등을 조정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C162","dJobICdNm":"[C162]나무제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001854:1', '{"dJobCd":"K000001854","dJobCdSeq":"1","dJobNm":"형삭기조작원","workSum":"목재의 표면과 모서리에 홈·접합부분 및 모형을 가공하는 형삭기를 조작한다.","doWork":"작업도면을 검토한 후 커터헤드(Cutter Head), 가이드(Guide), 지그(Jig) 등을 선택하여 장치하고 각 부분을 조절한다. 공기호스를 점검하고 기계를 가동한다. 가공할 목재를 커터헤드로 공급하여 가이드나 지그에 대고 눌러 규정된 형상으로 가공한다. 가공된 목재를 측정하여 규격을 검사한다. 지그나 가이드를 사용하지 않고 커터헤드에 직접 대어 가공하기도 한다. 연삭기에 커터 날을 연마하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","connectJob":"단축형삭기조작원, 양축형삭기조작원","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C161","dJobICdNm":"[C161]제재 및 목재 가공업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004868:1', '{"dJobCd":"K000004868","dJobCdSeq":"1","dJobNm":"화장판용해조운전원","workSum":"멜라민화장판(목재의 무늬결과 색상을 지니는 HPM, LPM)을 만들기 위해 열경화성 수지를 배합·합성하여 함침에 적절한 수지를 만드는 반응조를 조작·관리한다.","doWork":"표면지와 모양지를 만들기 위한 멜라민 수지(색상, 디자인, 화장 효과를 결정), 심재지와 응력지를 만들기 위한 페놀 수지(강도와 완충 유지, 응력 유지를 위한 하부층 구성)분말이나 액상 물질을 준비하고 계량한다. 작업지시서에 따라 반응조에 자동으로 투입되는 용재량의 수치를 맞춘다. 반응조에 용재를 자동으로 투입시키고 적절한 열경화성 수지(분말이나 액상 물질)를 투입한다. 반응조에 투입된 재료가 가열되어 액체 형태로 반응하고, 이 고온의 액체가 상온으로 냉각되도록 반응조 제어판을 조작한다. 온도·시간기록계를 분석하여 열경화성 수지가 제대로 반응했는지 검사한다. 검사에 합격한 열경화성 수지를 저장탱크에 자동으로 이송되도록 반응조 제어판을 조작한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","connectJob":"화장판함침건조기운전원","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C222","dJobICdNm":"[C222]플라스틱제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005589:1', '{"dJobCd":"K000005589","dJobCdSeq":"1","dJobNm":"화장판프레스기운전원","workSum":"멜라민화장판(목재의 무늬결과 색상을 지니는 HPM, LPM)을 만들기 위해 모양지와 베이스지를 필요한 매수만큼 압착하고, 모양지의 표면을 다양한 색상과 패턴으로 만드는 프레스기를 조작·관리한다.","doWork":"모양지(Printed Decopaper), 무늬인쇄된 함침지를 몇 장의 베이스지(크라프트 종이에 페놀수지를 함층한 층) 위에 적층하고 그 위에 경면판(모양지 표면에 무늬를 새김)을 적층한다. 색상과 디자인 및 화장 효과를 결정하는 모양지 위에 멜라민 수지가 함유된 표면지를 오버레이 처리해 화장판을 만든다. 경면판의 불순물을 공기분사기로 제거하기도 한다. 몇 번에 걸쳐 세트를 적층하고, 세트와 세트의 중간에는 이형지(각 세트를 분리해 줌)를 삽입한다. 적층한 세트들을 프레스기에 자동으로 넣어준 후 가압을 하면서 고온을 유지한다. 성형이 완료되면 경면판을 냉각시킨 후 이형지와 경면판을 분리시키고 주변 정돈을 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"HPM제작원","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C222","dJobICdNm":"[C222]플라스틱제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006010:1', '{"dJobCd":"K000006010","dJobCdSeq":"1","dJobNm":"화장판함침건조기운전원","workSum":"목재의 무늬결과 색상을 인공적으로 내는 멜라민화장판(HPM, LPM)을 제조하기 위해 구성원지에 멜라민, 페놀 수지를 함침하는 기계를 조작·관리한다.","doWork":"제조하려는 화장판의 특성에 따라서 함침건조기의 제어판에서 멜라민 수지의 온도와 롤러의 속도를 조절한다. 호이스트를 운전하여 다양한 색상과 무늬가 인쇄된 종이원단을 함침건조기에 거치하고, 종이원단의 한쪽 끝을 함침건조기에 걸어서 물린다. 표면지, 모양지, 심재지, 응력지 등의 구성원지별로 액체 상태의 멜라민 수지(모양지를 보호하는 역할)와 페놀수지(화장판의 심판부위 함침수지)를 함침한다. 함침이 완료된 원지를 건조로를 통과시켜 건조한다. 건조가 완료되면 일정한 길이로 자동절단을 시킨 후 불순물을 제거한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"화장판함침원","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C222","dJobICdNm":"[C222]플라스틱제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006317:1', '{"dJobCd":"K000006317","dJobCdSeq":"1","dJobNm":"환봉사상기조작원","workSum":"목재환봉의 표면을 매끄럽게 연마하는 사상기를 조작한다.","doWork":"기계의 이상 유무를 점검한 후 제품의 작업부위에 따라 사포벨트를 장치한다. 기계를 가동하고 환봉을 투입하여 표면을 연마한다. 가공이 완료된 환봉의 규격을 검사한다. 검사 결과에 따라 사상량을 재조정하고 다시 검사하여 부적판정을 내린 후 자동 공정라인으로 작업한다. 작업이 완료되면 기계를 청소하고 윤활유를 주입한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C161","dJobICdNm":"[C161]제재 및 목재 가공업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006662:1', '{"dJobCd":"K000006662","dJobCdSeq":"1","dJobNm":"가구부품가공원","workSum":"가구부품의 홈, 상하 에지(Edge)처리 등 가구조립에 필요한 각종 자재를 제품사양에 맞게 가공한다.","doWork":"작업지시서에 명시되어 있는 제품의 규격, 수량, 색상 등을 확인하고 가공할 홈(구멍), 상하 에지(Edge) 등 초품 가공을 위하여 자동 가공장치에 필요한 정보를 입력한다. 부품의 전·후면을 검사한 후 가공장비에 투입하고 제품의 홈을 가공한다. 홈에 이음쇠를 부착하여 부품을 연결한다. 가공된 자재를 뒤집어서 에지를 접착하고 이상 유무를 검사한 후 적재한다. 시험 가공된 제품에 이상이 없으면 모든 자재를 순차적으로 투입하여 가공한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"목수","certLic":"가구제작기능사","dJobECd":"8832","dJobECdNm":"[8832]가구 조립원","dJobJCd":"8912","dJobJCdNm":"[8912]가구 조립원","dJobICd":"C320","dJobICdNm":"[C320]가구 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001524:1', '{"dJobCd":"K000001524","dJobCdSeq":"1","dJobNm":"가구부품조립원","workSum":"접착제를 사용하여 가조립된 가구부품에 프레스기로 압력을 가하여 조립한다.","doWork":"조립할 목재의 규격을 검사하고 조립부분의 먼지나 오물을 제거한다. 기계의 작동상태 및 압력을 조절하고 제품이 기계에 투입되는 간격을 조정한다. 가조립된 제품을 프레스기 위에 올려 가압 위치에 고정한 후 접착제 펌핑(Pumping) 작업을 한다. 접착 및 조립된 제품의 규격이나 접착상태를 점검한다. 자동접착기를 사용하지 않는 경우는 수작업으로 접착하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","similarNm":"가구부품접착원","certLic":"가구제작기능사","dJobECd":"8832","dJobECdNm":"[8832]가구 조립원","dJobJCd":"8912","dJobJCdNm":"[8912]가구 조립원","dJobICd":"C320","dJobICdNm":"[C320]가구 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002775:1', '{"dJobCd":"K000002775","dJobCdSeq":"1","dJobNm":"당구대조립원","workSum":"당구대를 제조하기 위하여 테이블 프레임에 다리, 쿠션, 직물덮개 등 각 부품을 조립한다.","doWork":"입고된 각 부품을 육안으로 검사한다. 작업대에 쿠션, 직물덮개, 테이블 윗면 등 조립할 부품들을 준비한다. 테이블 윗면에 쿠션과 직물덮개 등을 조립한다. 완성된 테이블 윗면을 테이블 프레임에 조립한 후, 수동공구를 사용하여 레일과 다리를 조립한다. 조립이 끝난 제품을 육안으로 검사한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","connectJob":"당구대천(라시지)갈이원, 당구대고무갈이원","dJobECd":"8832","dJobECdNm":"[8832]가구 조립원","dJobJCd":"8912","dJobJCdNm":"[8912]가구 조립원","dJobICd":"C333","dJobICdNm":"[C333]운동 및 경기용구 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005294:1', '{"dJobCd":"K000005294","dJobCdSeq":"1","dJobNm":"탁구대조립원","workSum":"탁구대를 제조하기 위하여 테이블의 밑쪽에 다리와 각종 부품을 조립한다.","doWork":"작업대 위에 탁구대 테이블의 밑면이 위를 향하도록 거꾸로 놓는다. 연필을 사용하여 테이블 밑면에 다리 부분과 장식품이 부착될 위치를 표시한다. 표시된 위치에 접착제를 이용해 다리 부분과 장식품을 붙이고 나사못을 사용하여 조립한다. 조립한 다리 부분에 이동하기 위한 바퀴를 부착하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","dJobECd":"8832","dJobECdNm":"[8832]가구 조립원","dJobJCd":"8912","dJobJCdNm":"[8912]가구 조립원","dJobICd":"C333","dJobICdNm":"[C333]운동 및 경기용구 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004003:1', '{"dJobCd":"K000004003","dJobCdSeq":"1","dJobNm":"고무화아스팔트시트제조원","workSum":"물의 침투를 방지하여 시설물을 보호하는 고무화아스팔트시트를 제조하는 각종 설비를 조작한다.","doWork":"생산계획서를 확인하고 작업내용을 숙지한다. 가공에 필요한 원료혼합기, 코팅장치, 가열장치, 냉각장비 등 각종 장치를 점검하여 이상 유무를 확인한다. 아스팔트 루핑지(종이원료에 양모, 면, 마 등의 일반직물의 넝마를 넣어 배합한 종이) 원단을 원지걸이에 걸고 아스콘, 합성수지를 혼합탱크에 투입하도록 보조원에게 지시한다. 아스팔트루핑지에 코팅할 수 있도록 원료를 조성하기 위하여 가열장치를 조작한다. 규격제품을 생산하기 위하여 코팅액이 일정량씩 투입되도록 펄프의 압력, 롤러의 간격을 조정한다. 설비를 작동하여 생산된 제품의 코팅두께, 외관상태 등을 관찰한다. 생산된 제품의 열을 식히기 위하여 냉각장치를 조작하고 냉각된 제품은 루프실(저장실)의 저장걸이에 걸어 일정 시간 보관한다. 생산된 제품을 원하는 규격으로 절단하여 권취하는 설비를 조작한다. 작업내용을 작업일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"8822","dJobECdNm":"[8822]펄프·종이 제조장치 조작원","dJobJCd":"8913","dJobJCdNm":"[8913]펄프 및 종이 제조 장치 조작원","dJobICd":"C171","dJobICdNm":"[C171]펄프, 종이 및 판지 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001954:1', '{"dJobCd":"K000001954","dJobCdSeq":"1","dJobNm":"고해기조작원","workSum":"해리된 종이원료의 섬유질을 종이의 질에 맞게 잘라주고 종이의 강도를 높이기 위해 고해기를 조작한다.","doWork":"고해기 내의 회전판(Disc)을 회전하도록 모터를 작동한다. 해리된 종이원료가 고해기 내로 들어가도록 원료투입밸브를 연다. 고해도를 작업지시서에 명시된 기준에 맞추기 위하여 유압스위치를 조작하여 회전판을 조정한다. 계기판을 관찰하여 고해공정이 원활히 유지되도록 한다. 이상이 발생하면 조성반장에게 보고 후 조치한다. 고해액에서 시료를 채취하고 고해도시험기를 사용하여 고해도를 측정하여 기록한다. 고해된 원료를 초지기 저장조로 보내기 위하여 이송펌프를 작동한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|고온|다습|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8822","dJobECdNm":"[8822]펄프·종이 제조장치 조작원","dJobJCd":"8913","dJobJCdNm":"[8913]펄프 및 종이 제조 장치 조작원","dJobICd":"C171","dJobICdNm":"[C171]펄프, 종이 및 판지 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003220:1', '{"dJobCd":"K000003220","dJobCdSeq":"1","dJobNm":"닥피고해원","workSum":"표백된 닥피의 섬유를 분해하기 위하여 비터기(Beater)를 조작하거나 방망이로 두들긴다.","doWork":"생산할 한지에 따라 원료인 표백닥피, 펄프, 탈묵고지를 적정 비율로 비터기 안에 채운다. 급수밸브를 조작하여 적당량의 물을 넣는다. 교반모터의 작동스위치를 조작한다. 원료의 분해·교반상태를 확인하기 위하여 비터기(Beater) 내의 원료를 만져본다. 알맞게 분해교반된 원료를 탈수시키기 위해 비터기의 배수밸브를 조작한다. 탈수된 원료를 용기에 담아 다음 공정으로 운반한다. 한지를 제조하는 데 필요한 원료를 만들기 위하여 소비자 또는 생산계획에 따라 닥피, 펄프를 배합하는 일을 하기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"다습|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"비터기조작원","dJobECd":"8822","dJobECdNm":"[8822]펄프·종이 제조장치 조작원","dJobJCd":"8913","dJobJCdNm":"[8913]펄프 및 종이 제조 장치 조작원","dJobICd":"C171","dJobICdNm":"[C171]펄프, 종이 및 판지 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003077:1', '{"dJobCd":"K000003077","dJobCdSeq":"1","dJobNm":"닥피증해원","workSum":"한지 원료인 닥나무 수피를 삶아서 해리하고 화학약품을 투입하여 표백한다.","doWork":"무쇠 솥에 적당량의 물을 넣고 가열하기 위하여 열원을 조절한다. 껍질이 벗겨진 채취 닥의 수피를 솥에 넣고 닥피의 해리를 촉진하고 불순물을 용해하기 위하여 적당량의 가성소다를 투입한다. 막대를 이용하여 닥피를 휘젓고 닥피가 풀린 상태를 확인하기 위하여 손으로 만져본다. 갈고리를 사용하여 물이 잘 빠지는 용기에 해리된 닥피를 건져 담고 수분이 제거되면, 표백통에 삶아진 닥피를 일정 비율로 물과 함께 넣고 표백용 화학약품을 투입한다. 막대로 휘저어 침수시키고, 일정 시간 침수된 닥피의 표백상태를 확인한 후 물이 잘 빠지는 용기에 건져 놓는다. 통 바닥에 가라앉거나 표백상태가 불량한 티, 옹이 등을 제거한다. 표백된 닥피의 표면에 남아있는 표피, 티꺼리 등의 잡티를 손으로 제거해 준다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"다습|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"유지","connectJob":"닥피세척원, 닥피표백원","dJobECd":"8822","dJobECdNm":"[8822]펄프·종이 제조장치 조작원","dJobJCd":"8913","dJobJCdNm":"[8913]펄프 및 종이 제조 장치 조작원","dJobICd":"C171","dJobICdNm":"[C171]펄프, 종이 및 판지 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004579:1', '{"dJobCd":"K000004579","dJobCdSeq":"1","dJobNm":"롤링기조작원","workSum":"벽지, 화장지 등의 종이제품을 명시된 길이만큼 감고 절단하여 재권취하는 롤링기를 조작한다.","doWork":"작업지시서에 지시된 사항을 확인한다. 지시된 제품규격에 맞도록 길이 및 폭등을 조작반의 조작스위치를 조정한다. 권취에 사용할 지관을 수령하여 지관자동투입기에 넣거나 투입준비를 한다. 롤링기의 스위치를 넣어 가동시킨다. 길이계수기를 통과하여 자동으로 감기고 절단되는 화장지나 벽지의 상태 및 제품 상태를 관찰한다. 권취된 롤을 편 길이와 감긴 상태 등을 확인한다. 완성된 제품은 다음 공정으로 운반하기 위하여 임시 저장소에 보관한다. 작업공정에 따라 완만하게 감긴 제품을 재권취를 하기도 한다. 생산하는 제품에 따라 제품라벨을 부착하거나 자동비닐포장기로 포장하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"8822","dJobECdNm":"[8822]펄프·종이 제조장치 조작원","dJobJCd":"8913","dJobJCdNm":"[8913]펄프 및 종이 제조 장치 조작원","dJobICd":"C172","dJobICdNm":"[C172]골판지, 종이 상자 및 종이 용기 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002033:1', '{"dJobCd":"K000002033","dJobCdSeq":"1","dJobNm":"루핑지가공반장","workSum":"원지에 아스콘, 합성수지 등의 원료를 흡입, 부착시켜 방수성 및 흡음성, 흡습성을 부여한 루핑지(종이원료에 양모, 면, 마 등의 일반직물의 넝마를 넣어 배합한 종이)를 제조하는 작업원의 활동을 감독·조정한다.","doWork":"생산할 제품의 규격사항을 확인하고 작업원을 배치한다. 작업 중에 발생할 화상 등의 안전사항을 교육한다. 표준규격에 맞는 제품을 생산하기 위하여 품질관리를 한다. 생산설비의 이상 유무를 점검·관리하며 이상 시 작업원과 함께 수리한다. 작업자의 애로사항 및 작업 시 발생하는 문제점을 해결하고 관련 부서에 보고한다. 작업내용 및 작업 시 발생한 문제점 등을 작업일지에 기록하고 보고한다. 조작원을 대신하여 설비를 조작하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","connectJob":"아스팔트루핑지제조반장, 고무화아스팔트시트제조반장","dJobECd":"8822","dJobECdNm":"[8822]펄프·종이 제조장치 조작원","dJobJCd":"8913","dJobJCdNm":"[8913]펄프 및 종이 제조 장치 조작원","dJobICd":"C179","dJobICdNm":"[C179]기타 종이 및 판지 제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001465:1', '{"dJobCd":"K000001465","dJobCdSeq":"1","dJobNm":"리와인더조작원","workSum":"스풀롤에 감긴 종이를 일정 규격의 지폭, 직경, 중량으로 재권취하기 위하여 리와인더(Rewinder)를 조작한다.","doWork":"작업지시서에 따라 재권취할 스풀롤지를 호이스트(Hoist) 또는 크레인을 사용하여 작업장으로 운반한다. 재권취용 지관을 드럼롤(Durm-roll)에 장치하고 스풀롤지를 연결시킨다. 재권취 직경, 중량, 지폭 등에 맞추어 원형칼을 지필에 밀착시킨다. 롤지의 인장을 일정하게 유지시키기 위하여 오일펌프 스위치와 유압핸들을 조정한다. 리와인더 작동스위치를 조작한다. 권취된 양을 확인하고 자동계량 저울의 눈금을 확인하고 작업일지에 기록한다. 스풀롤지 또는 재권취지의 무게를 계량기로 달아서 기록하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|고온|다습|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8822","dJobECdNm":"[8822]펄프·종이 제조장치 조작원","dJobJCd":"8913","dJobJCdNm":"[8913]펄프 및 종이 제조 장치 조작원","dJobICd":"C171","dJobICdNm":"[C171]펄프, 종이 및 판지 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004449:1', '{"dJobCd":"K000004449","dJobCdSeq":"1","dJobNm":"벽지검사원","workSum":"각종 벽지제품의 품질을 검사하고 관리한다.","doWork":"종이, 비닐, 발포 및 초경 등의 벽지 종류에 따라 검사 방법 및 규정을 검토한다. 생산된 벽지제품의 발포제의 도포상태, 인쇄상태, 엠보싱상태, 합지상태 등을 검사하기 위하여 포장 전 또는 공정 간에 육안검사, 두께검사, 형광검사, 좌우이색검사 등을 실시한다. 불량품을 선별하고 불량사항을 검토하여 관련 담당자 및 부서에 보고하여 시정토록 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","connectJob":"초경(草莖)반장","dJobECd":"8822","dJobECdNm":"[8822]펄프·종이 제조장치 조작원","dJobJCd":"8913","dJobJCdNm":"[8913]펄프 및 종이 제조 장치 조작원","dJobICd":"C179","dJobICdNm":"[C179]기타 종이 및 판지 제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004882:1', '{"dJobCd":"K000004882","dJobCdSeq":"1","dJobNm":"벽지제조반장","workSum":"벽지를 제조하는 데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"생산계획에 따라 작업원을 배치하고 작업내용을 지시한다. 작업에 사용되는 코팅기, 발포기, 인쇄기, 실크기, 합지기 등의 설비를 점검하고 유지·관리한다. 표준작업명세에 따라 지시된 작업이 이루어지는지 작업원과 함께 작업하며 작업상황을 관찰하고 작업내용을 점검한다. 작업원의 직무교육 및 안전위생교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴·해결하고 문제점을 보완한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|고온|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","connectJob":"종이벽지제조반장, 비닐벽지제조반장, 발포벽지제조반장, 초경(草莖)","dJobECd":"8822","dJobECdNm":"[8822]펄프·종이 제조장치 조작원","dJobJCd":"8913","dJobJCdNm":"[8913]펄프 및 종이 제조 장치 조작원","dJobICd":"C179","dJobICdNm":"[C179]기타 종이 및 판지 제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007307:1', '{"dJobCd":"K000007307","dJobCdSeq":"1","dJobNm":"석회소성로운전원","workSum":"펄프동력공정 중 가성화공정(백액제조공정)에서 발생한 석회니를 생석회로 재생하는 석회소성로(Lime Kiln)를 조작한다.","doWork":"조작반의 계기와 모니터를 통하여 가마의 온도, 건조로의 슬러지양, 건조로의 공존산소량과 이산화탄소 소모율 등을 관찰한다. 건조로의 용량에 따라 유입되는 슬러지의 양을 조절하기 위하여 조작반의 저항조절기를 조정한다. 건조로를 특정온도로 유지하기 위하여 조작반의 온도제어장치를 조정한다. 건조로의 공존산소량에 따라 공기흡입장치를 가동하고, 슬러지가 생석회 및 이산화탄소로 분해되는 비율에 따라 공기배출장치를 조정한다. 생석회가 물과 혼합되어 소석회를 형성하도록 생석회를 저장탱크에서 분해탱크로 보내는 컨베이어를 조작한다. 조작반의 기계 이상을 점검하도록 석회소성로운전보조원에게 지시한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|고온|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8822","dJobECdNm":"[8822]펄프·종이 제조장치 조작원","dJobJCd":"8913","dJobJCdNm":"[8913]펄프 및 종이 제조 장치 조작원","dJobICd":"C171","dJobICdNm":"[C171]펄프, 종이 및 판지 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004190:1', '{"dJobCd":"K000004190","dJobCdSeq":"1","dJobNm":"솔질원","workSum":"한지의 질을 향상시키고 완전 건조시키기 위하여 건조대에 탈수된 한지를 깔고 솔질한다.","doWork":"적당한 온도로 가열된 건조대를 깨끗하게 닦는다. 동력프레스로 눌러 탈수된 바탕(대발로 떠낸 한지를 일정 매로 쌓아놓은 것으로 지층의 순수한 우리 말)에서 한지를 한 장씩 떼어서 건조대 위에 펼쳐 놓는다. 부드러운 솔로 종이 위를 문질러서 주름을 펴고 물기를 제거한다. 건조 상태를 확인하여 종이를 떠내어 펼쳐 놓는다. 건조대의 온도를 손의 촉감으로 판단하고 열원을 조절하도록 관련 부서에 보고한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"고온|다습|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"유지","dJobECd":"8822","dJobECdNm":"[8822]펄프·종이 제조장치 조작원","dJobJCd":"8913","dJobJCdNm":"[8913]펄프 및 종이 제조 장치 조작원","dJobICd":"C171","dJobICdNm":"[C171]펄프, 종이 및 판지 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002369:1', '{"dJobCd":"K000002369","dJobCdSeq":"1","dJobNm":"아스팔트루핑지제조원","workSum":"물의 침투를 방지하여 시설물을 보호하는 아스팔트 루핑지(종이원료에 양모, 면, 마 등의 일반 직물의 넝마를 넣어 배합한 종이)를 제조하는 각종 설비를 조작한다.","doWork":"제조할 제품의 생산계획에 따라 작업에 필요한 각종 사항을 숙지한다. 가공에 필요한 함침탱크, 가열장치, 냉각장치 등 각종 장치를 점검하여 이상 유무를 확인한다. 루핑지(종이원료에 양모, 면, 마 등의 일반직물의 넝마를 넣어 배합한 종이) 원단을 원지걸이에 건다. 아스콘을 함침탱크에 투입하여 액체화하기 위하여 가열장치를 조작한다. 루핑지를 함침탱크에 투입하여 피복되도록 한다. 피복된 루핑지를 건조시키기 위하여 냉각설비를 가동하고 일정 길이로 권취하여 절단한다. 권취된 아스팔트 루핑지를 교체한다. 작업내용을 작업일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"8822","dJobECdNm":"[8822]펄프·종이 제조장치 조작원","dJobJCd":"8913","dJobJCdNm":"[8913]펄프 및 종이 제조 장치 조작원","dJobICd":"C179","dJobICdNm":"[C179]기타 종이 및 판지 제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002673:1', '{"dJobCd":"K000002673","dJobCdSeq":"1","dJobNm":"압착탈수기조작원","workSum":"종이로 형성되어 흡입, 탈수된 습지(濕紙:축축한 종이)를 건조하기 적당한 상태로 수분을 제거하기 위하여 압착·탈수하는 프레스설비를 조작·관리한다.","doWork":"깨끗한 물을 프레스모포에 분무하기 위하여 관련 밸브를 연다. 압착롤러의 간격과 탈수모포의 인장을 제조할 종이규격에 맞도록 조정한다. 흡입·탈수공정을 거친 습지(濕紙:축축한 종이)를 흡입장치를 이용하여 압착롤러와 탈수모포 사이를 통과시킨다. 공정의 흐름과 지시계기의 수치를 기록한다. 탈수모포(Press Felt)의 상태를 확인하고 수동공구를 이용하여 교체·세척한다. 프레스롤을 확인하여 손이나 공기압으로 이물질을 제거한다. 탈수된 종이의 탈수상태를 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|고온|다습|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"프레스맨","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8822","dJobECdNm":"[8822]펄프·종이 제조장치 조작원","dJobJCd":"8913","dJobJCdNm":"[8913]펄프 및 종이 제조 장치 조작원","dJobICd":"C171","dJobICdNm":"[C171]펄프, 종이 및 판지 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004751:1', '{"dJobCd":"K000004751","dJobCdSeq":"1","dJobNm":"와이어조작원","workSum":"습지(濕紙)의 수분을 제거하기 위하여 흡입·탈수하는 와이어(Wire:금망)설비를 관리·조작한다.","doWork":"작업지시서의 작업내용과 작업명세사항을 확인한다. 와이어드럼(Wire-vat)으로 유입되는 원료량을 조절하기 위하여 농도, 고해도, 온도 등을 확인한다. 와이어와 와이어 모포의 파손 및 이물질 부착 여부를 확인한다. 원료의 유출량을 조절해 주기 위하여 유출밸브를 조작한다. 평량을 맞추기 위하여 원료분배탱크의 밸브를 조작한다. 습지(濕紙:축축한 종이)를 연결하기 위하여 공기분사기(Air Shoot)를 조절한다. 지폭을 일정하게 맞추기 위하여 실린더 양쪽 끝에 부착된 노즐샤워의 간격을 조정한다. 초지(抄紙:종이를 떠냄) 과정을 점검하고 각 계기의 지시치를 기록한다. 와이어 모포의 교체작업 시에는 초지반장의 지시에 따라 와이어의 가동을 중지시키고 모포의 이물질을 제거하기 위하여 고압노즐을 이용하여 세척액으로 세척하며, 수동공구를 사용하여 와이어 및 모포 교체작업을 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|고온|다습|소음·진동|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"와이어맨","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8822","dJobECdNm":"[8822]펄프·종이 제조장치 조작원","dJobJCd":"8913","dJobJCdNm":"[8913]펄프 및 종이 제조 장치 조작원","dJobICd":"C171","dJobICdNm":"[C171]펄프, 종이 및 판지 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004672:1', '{"dJobCd":"K000004672","dJobCdSeq":"1","dJobNm":"정선기조작원","workSum":"표백된 펄프를 작업표준에 맞는 펄프로 가공하기 위하여 이물질을 제거하고, 고해도를 맞추기 위하여 정선기를 조작한다.","doWork":"작업지시서를 확인하고 작업내용 및 작업진행 사항을 숙지한다. 작업표준의 기준에 맞는 펄프로 가공하기 위하여 표백 처리된 표백펄프원료를 저장탱크로부터 조작반을 조작하여 운송한다. 작업표준에 맞는 펄프제조를 위하여 스크린(Screen:미세한 체), 원심분리기, 진동정선기 등을 가동한다. 작업내용을 작업일지에 기록하고 다음 작업을 준비한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|다습|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"스크린맨","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8822","dJobECdNm":"[8822]펄프·종이 제조장치 조작원","dJobJCd":"8913","dJobJCdNm":"[8913]펄프 및 종이 제조 장치 조작원","dJobICd":"C171","dJobICdNm":"[C171]펄프, 종이 및 판지 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006510:1', '{"dJobCd":"K000006510","dJobCdSeq":"1","dJobNm":"조약원","workSum":"펄프제조 공정 및 제지 공정에 투입되는 각종 약품을 혼합·가공하여 공급한다.","doWork":"혼합할 약품을 각각의 탱크에 공급한다. 작업지시서에 따라 약품을 교반기에 투입한다. 교반기 스위치를 가동하여 교반하고 교반된 용약의 농도를 측정기를 사용하여 측정한다. 밸브를 조작하여 혼합된 용액을 펄퍼(Pulper) 및 조성설비에 공급하거나 조액실로 이송하여 보관한다. 조약탱크, 교반기 및 부대시설을 점검하고 유지·관리한다. 약품 원료의 잔량을 확인하고 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8822","dJobECdNm":"[8822]펄프·종이 제조장치 조작원","dJobJCd":"8913","dJobJCdNm":"[8913]펄프 및 종이 제조 장치 조작원","dJobICd":"C171","dJobICdNm":"[C171]펄프, 종이 및 판지 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006943:1', '{"dJobCd":"K000006943","dJobCdSeq":"1","dJobNm":"종이선별원","workSum":"완성된 종이의 불량품을 선별하고 규정된 매수로 계수하여 지종별로 분류한다.","doWork":"지종별로 생산 적재된 제품의 전체적인 외형을 관찰하고 제품규격이 일정한지 자를 사용하여 확인한다. 색상과 광택이 작업표준에 맞는지 스크린에 비추어 육안 또는 스캐너를 사용하여 확인한다. 매수를 확인하고 주름진 종이, 기포자국과 반점이 생긴 종이, 재단이 고르지 못한 종이 등을 골라낸다. 불량품이 제거된 제품에 삽지를 넣어 매수의 간격을 표시한다. 선별한 매수를 작업일지에 기록한다. 선별된 파지를 모아 대차에 실어 펄퍼(Pulper)로 보낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8822","dJobECdNm":"[8822]펄프·종이 제조장치 조작원","dJobJCd":"8913","dJobJCdNm":"[8913]펄프 및 종이 제조 장치 조작원","dJobICd":"C171","dJobICdNm":"[C171]펄프, 종이 및 판지 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005214:1', '{"dJobCd":"K000005214","dJobCdSeq":"1","dJobNm":"증발기조작원","workSum":"흑액농축공정에서 발생된 묽은 흑액을 진한 흑액으로 만들어서 회수보일러에 공급한다.","doWork":"작업지시서를 확인하고 작업공정에 따른 작업계획을 숙지한다. 정상적인 작업이 이루어질 수 있도록 조작반의 계기와 설비를 모니터링하여 설비의 관리, 운영 및 유지를 한다. 증발기조작보조원에게 관련 설비 및 이상 설비에 대한 예비점검 및 문제해결을 위한 조치를 지시한다. 묽은 흑액을 진한 흑액으로 만들기 위하여 증발기에 투입되는 증기량, 증기온도, 증기압과 흑액농도 등을 설정하기 위해 조작반을 조정한다. 작업내용을 작업일지에 기록하여 관련 부서에 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8822","dJobECdNm":"[8822]펄프·종이 제조장치 조작원","dJobJCd":"8913","dJobJCdNm":"[8913]펄프 및 종이 제조 장치 조작원","dJobICd":"C171","dJobICdNm":"[C171]펄프, 종이 및 판지 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002940:1', '{"dJobCd":"K000002940","dJobCdSeq":"1","dJobNm":"증착기조작원","workSum":"종이, 합성수지필름, 인쇄물과 같은 재료의 표면을 가공하기 위하여 알루미늄 등으로 증착하는 설비를 조작한다.","doWork":"작업지시서의 작업내용을 숙지한다. 작업에 필요한 종이, 합성수지필름, 인쇄물과 코팅제를 준비하고 증착작업에 적합한 온도로 올려주기 위하여 설비를 가동한다. 증착할 재료를 원지걸이에 걸어준다. 생산할 제품의 규격에 맞추어 증착 폭을 조절한다. 증착제를 가공물에 증착하기 위하여 가열장치의 온도, 진공장치 등의 온도, 기압 등에 대한 자료를 조작반에 입력한다. 증착제를 투입하고 설비를 작동한다. 제품의 증착된 두께, 외형, 표면상태 등을 관찰하고 이상이 발생하면 온도, 기압 등을 재조정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"8822","dJobECdNm":"[8822]펄프·종이 제조장치 조작원","dJobJCd":"8913","dJobJCdNm":"[8913]펄프 및 종이 제조 장치 조작원","dJobICd":"C181","dJobICdNm":"[C181]인쇄 및 인쇄관련 산업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005990:1', '{"dJobCd":"K000005990","dJobCdSeq":"1","dJobNm":"증해기조작원","workSum":"펄프제조용 목재 칩(Chip)을 해리시키기 위하여 고온으로 삶는 증해기 및 부속설비를 운전한다.","doWork":"설비의 정상가동을 방해하는 이물질을 제거한다. 작동 중인 각종 설비를 순회하며 정상적인 작업이 이루어지도록 조치한다. 제어실의 제어장치를 조작하여 컨베이어를 가동하고 일정량의 목재 칩(Chip)을 증해기에 투입하고, 자동개폐장치를 작동시켜 증해기의 뚜껑을 닫는다. 증해수율을 높이기 위하여 증해액(가성소다, 황산나트륨)을 투입하는 투입밸브를 조절한다. 증해액을 순화시키기 위하여 교반모터의 스위치를 조작한다. 증해기 내의 압력을 일정하게 유지하기 위하여 스팀밸브를 조작하여 배출탱크로 증해액을 이동시킨다. 컨베이어를 작동하여 칩을 얻는다. 증해된 중간원료는 저장탱크로 이송한다. 컨베이어, 액 투입장치, 교반 모터 등의 부속설비의 가동상태를 조작판을 통하여 확인하고, 이상 발생 시 문제점을 해결하기 위하여 설비를 점검한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|다습|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8822","dJobECdNm":"[8822]펄프·종이 제조장치 조작원","dJobJCd":"8913","dJobJCdNm":"[8913]펄프 및 종이 제조 장치 조작원","dJobICd":"C171","dJobICdNm":"[C171]펄프, 종이 및 판지 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002483:1', '{"dJobCd":"K000002483","dJobCdSeq":"1","dJobNm":"증해반장","workSum":"펄프제조를 위하여 증해설비, 저장탱크, 정선설비, 표백설비에 종사하는 작업원의 활동을 감독·조정한다.","doWork":"증해설비, 저장탱크, 정선설비, 표백설비 등 공정별 작업상태 및 설비상태를 현장에서 점검한다. 작업지시서를 읽고 공정 간의 작업균형을 유지한다. 품질검사와 공정시험 결과를 통보받고 나타난 문제점을 작업원에게 알린다. 공정별 설비의 조정상태를 작업지시서에 기재하여 작업원에게 전달하고 점검한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|고온|다습|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8822","dJobECdNm":"[8822]펄프·종이 제조장치 조작원","dJobJCd":"8913","dJobJCdNm":"[8913]펄프 및 종이 제조 장치 조작원","dJobICd":"C171","dJobICdNm":"[C171]펄프, 종이 및 판지 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001265:1', '{"dJobCd":"K000001265","dJobCdSeq":"1","dJobNm":"초경원단표백기조작원","workSum":"갈포, 황마 등의 원료를 짜서 만든 초경(草莖)원단을 검사하고 이물질 등에 오염된 부분을 표백하기 위한 작업을 한다.","doWork":"초경(草莖)원단을 육안으로 검사하고 사용이 불가한 제품은 반품토록 관련 부서에 통보한다. 이물질에 의한 오염으로 표백을 요하는 초경원단을 육안검사를 통하여 선별한다. 초경원단을 표백하기 위하여 표백설비를 점검하고 물에 혼합하여 배합한 표백약품을 투입한다. 표백할 초경원단을 투입구에 걸고 표백한다. 표백된 원단을 검사하고 오염이 제거된 제품은 건조부로 이송한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|다습|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"8822","dJobECdNm":"[8822]펄프·종이 제조장치 조작원","dJobJCd":"8913","dJobJCdNm":"[8913]펄프 및 종이 제조 장치 조작원","dJobICd":"C134","dJobICdNm":"[C134]섬유제품 염색, 정리 및 마무리 가공업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005727:1', '{"dJobCd":"K000005727","dJobCdSeq":"1","dJobNm":"초지건조기조작원","workSum":"압착, 탈수된 종이를 건조시키는 건조(Dryer)설비를 관리·조작한다.","doWork":"작업지시서에 따라 종이를 건조하기 적당한 온도로 유지시키기 위하여 건조설비의 조정판(Panel)을 조작하여 건조 실린더에 스팀을 공급한다. 스팀의 공급이 원활하지 않을 경우 기관실에 문의하여 조치한다. 연결로프(Carrier-rope)를 이용하여 종이를 건조 실린더에 연결한다. 건조기의 정상 가동 여부를 확인하고 건조할 종이의 제품규격에 맞도록 실린더의 온도와 회전속도를 조절한다. 건조기를 가동시키고 각종 계기판을 확인하여 건조작업을 유지하면서 건조 처리된 종이견본의 습도, 장력 등에 대한 분석결과에 따라 건조설비를 재조정한다. 건조 실린더, 배관 등에서 증기가 유출되는 곳이 없는지 점검한다. 건조기 내의 지분을 청소한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|고온|다습|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"드라이어맨","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8822","dJobECdNm":"[8822]펄프·종이 제조장치 조작원","dJobJCd":"8913","dJobJCdNm":"[8913]펄프 및 종이 제조 장치 조작원","dJobICd":"C171","dJobICdNm":"[C171]펄프, 종이 및 판지 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005205:1', '{"dJobCd":"K000005205","dJobCdSeq":"1","dJobNm":"초지반장","workSum":"초지공정(조성공정에서 보내진 지료(원료+물)를 탈수·압착·건조하여 종이를 만드는 공정)을 수행하는 작업원의 활동을 감독·조정한다.","doWork":"작업계획서를 확인하고 작업내용을 작업원에게 지시하고 배치한다. 각종 초지설비를 점검하고 정상적인 작업이 이루어질 수 있도록 관리한다. 지종의 변경에 따라 지종의 특성을 확인하고 각 기계의 조정상태를 작업지시서에 기재하여 작업원에게 전달하고 점검한다. 작업진행 중 발생한 문제를 해결하기 위한 방안을 강구하고 조치한다. 공정 간 작업균형 유지를 위해 조성반장과 연락한다. 작업자의 안전관리 및 교육을 실시한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|고온|다습|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8822","dJobECdNm":"[8822]펄프·종이 제조장치 조작원","dJobJCd":"8913","dJobJCdNm":"[8913]펄프 및 종이 제조 장치 조작원","dJobICd":"C171","dJobICdNm":"[C171]펄프, 종이 및 판지 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005793:1', '{"dJobCd":"K000005793","dJobCdSeq":"1","dJobNm":"캘린더조작원","workSum":"건조된 종이 표면이 평활(平滑)하고 광택이 나도록 캘린더(Calender) 설비를 조작한다.","doWork":"건조기를 통과한 종이와 연결로프(Carrier-rope)의 연결부위를 점검한다. 지필이 밀리지 않도록 자동가이드를 점검·조작한다. 증기를 롤러 안에 투입하는 스팀밸브를 조작하여 적당한 건조 상태를 유지한다. 공기투입기(Air Shoot:지필을 연결하는 장치)의 압력이 정상인지 확인하고 지필 연결 작업을 한다. 캘린더 조정판에 나타나는 평활도, 후박도(두께), 온도 등을 확인하고 조절한다. 롤러의 가압장치를 조정하고 두께 조정 팬을 가동한다. 수시로 평활도 및 수분을 측정하여 와이어조작원에게 연락하여 수분량을 조절하도록 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|고온|다습|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"광택기조작원, 캘린더맨","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8822","dJobECdNm":"[8822]펄프·종이 제조장치 조작원","dJobJCd":"8913","dJobJCdNm":"[8913]펄프 및 종이 제조 장치 조작원","dJobICd":"C171","dJobICdNm":"[C171]펄프, 종이 및 판지 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005117:1', '{"dJobCd":"K000005117","dJobCdSeq":"1","dJobNm":"탈묵기조작원","workSum":"해리된 고지에서 잉크성분 등을 제거하기 위하여 탈묵기를 조작한다.","doWork":"작업지시서에 따라 원료(고농도 클리너)를 투입하고 압력을 적절하게 조절한다. 원료 투입 농도를 맞추기 위하여 급수밸브를 조정한다. 기포 제거상태가 최적의 조건이 되도록 수위조절 레버를 조작한다. 기포 발생 및 잉크입자 제거상태가 양호한지 확인하기 위하여 백색도 측정기로 백색도를 측정한다. 탈묵된 원료를 농축하기 위하여 원료순환 펌프와 실린더 구동모터를 가동하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|다습|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8822","dJobECdNm":"[8822]펄프·종이 제조장치 조작원","dJobJCd":"8913","dJobJCdNm":"[8913]펄프 및 종이 제조 장치 조작원","dJobICd":"C171","dJobICdNm":"[C171]펄프, 종이 및 판지 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001995:1', '{"dJobCd":"K000001995","dJobCdSeq":"1","dJobNm":"펄퍼기조작원","workSum":"초지공정에 사용할 펄프, 고지의 섬유성분을 풀어주기 위해 펄퍼기를 조작·관리한다.","doWork":"작업지시서에 따라 펄퍼기(Pulper:펄프, 고지와 부원료 및 물을 혼합하여 믹서하는 기계)를 가동한다. 생산하려는 제품이 신문용지인 경우 펄프와 고지를 투입하고, 백상지 등 인쇄용지인 경우 펄프만 투입한다. 초지공정에서 발생한 파지를 수거하여 투입하기도 한다. 해리탱크에 일정량의 물을 주입하기 위해 급수펌프를 조작한다. 해리 촉진용 가성소다를 지시된 양만큼 주입하기 위해 밸브를 조작한다. 컨베이어를 가동하여 고지 또는 펄프를 배합비에 따라 해리탱크에 투입하고 농도를 조정한다. 해리 중인 종이원료를 희석시켜 비커에 넣어 해리상태를 확인한다. 해리기 하부의 밸브를 열어 해리된 용액을 고해탱크로 보낸다. 해리탱크의 불순물과 찌꺼기를 제거하기 위하여 청소한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|고온|다습|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"해리기조작원","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8822","dJobECdNm":"[8822]펄프·종이 제조장치 조작원","dJobJCd":"8913","dJobJCdNm":"[8913]펄프 및 종이 제조 장치 조작원","dJobICd":"C171","dJobICdNm":"[C171]펄프, 종이 및 판지 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002736:1', '{"dJobCd":"K000002736","dJobCdSeq":"1","dJobNm":"펄프건조기조작원","workSum":"펄프로 가공하기 위하여 펄프용 초지기, 탈수기, 건조기 등의 설비를 조작한다.","doWork":"작업지시서를 확인하고 작업내용 및 작업진행 사항을 숙지한다. 초지기, 압착탈수기, 건조기 등 펄프 제조설비를 점검하고 이상 유무를 확인한다. 작업지시서에 지시된 펄프제품으로 가공하기 위하여 각종 기기의 계기를 조정하여 펄프두께, 탈수기의 속도, 증기 및 실린더의 온도 등을 조절한다. 초지기, 압착탈수기, 예비건조기, 실린더건조기 등을 조작하여 펄프를 가공한다. 작업진행 중 발생한 설비의 이상 점검 및 지절(紙切)된 펄프를 연결하도록 펄프건조기조작보조원에게 지시한다. 작업내용을 작업일지에 기록하고 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"다습|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8822","dJobECdNm":"[8822]펄프·종이 제조장치 조작원","dJobJCd":"8913","dJobJCdNm":"[8913]펄프 및 종이 제조 장치 조작원","dJobICd":"C171","dJobICdNm":"[C171]펄프, 종이 및 판지 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004165:1', '{"dJobCd":"K000004165","dJobCdSeq":"1","dJobNm":"펄프분쇄기조작원","workSum":"기저귀, 생리대와 같은 위생용품의 원료로 사용되는 펄프를 가공하는 분쇄기를 조작한다.","doWork":"작업에 사용되는 분쇄기, 원지걸이 등의 설비를 점검한다. 생산계획에 맞는 원료를 운반하여 원지걸이에 걸어준다. 가공할 제품에 맞게 조작반의 계기를 조작하여 가공속도, 입자크기 등을 조절한다. 분쇄기를 작동하고 펄프의 투입상태, 이물질의 삽입 여부, 분속기의 제어상태 여부를 관찰하고 이상 유무를 확인한다. 작업진행에 맞게 펄프를 교체한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8822","dJobECdNm":"[8822]펄프·종이 제조장치 조작원","dJobJCd":"8913","dJobJCdNm":"[8913]펄프 및 종이 제조 장치 조작원","dJobICd":"C172","dJobICdNm":"[C172]골판지, 종이 상자 및 종이 용기 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002549:1', '{"dJobCd":"K000002549","dJobCdSeq":"1","dJobNm":"펄프세척기조작원","workSum":"증해된 중간 원료인 미표백 펄프를 세척하고 섬유소에서 분리된 리그닌을 물로 씻어내며 저장하는 설비를 조작한다.","doWork":"세척기, 로터기 등의 관련 설비를 순회하며 이상 유무를 확인하고 정상가동이 될 수 있도록 점검한다. 작업내용을 숙지하고, 증해된 펄프원료를 세척하기 위하여 밸브를 열어 저장탱크로부터 세척기로 이송한다. 미세한 이물질과 고해도를 향상시키기 위하여 로터기 및 부속설비를 작동한다. 섬유소에서 분리된 리그닌을 물로 세척하는 설비를 조작한다. 이물질이 제거된 고농도 미표백 펄프를 저장탱크에 저장한다. 표백을 위하여 고농도 미표백 펄프를 저장탱크에 저장한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8822","dJobECdNm":"[8822]펄프·종이 제조장치 조작원","dJobJCd":"8913","dJobJCdNm":"[8913]펄프 및 종이 제조 장치 조작원","dJobICd":"C171","dJobICdNm":"[C171]펄프, 종이 및 판지 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003034:1', '{"dJobCd":"K000003034","dJobCdSeq":"1","dJobNm":"펄프원료반장","workSum":"펄프 제조에 사용되는 원료인 목재 칩을 계근·검수·저장·공급하는 작업원의 활동을 감독·조정한다.","doWork":"야적장에 들어오는 목재 칩의 양을 자동 계근대로 파악한다. 펄프제조 공정에 투입되는 목재 칩의 양을 조사·기록한다. 생산계획에 따라 펄프제조 공정에 투입되는 목재 칩의 종류별 순서를 결정한다. 컨트롤 룸에서 목재칩 이송장치를 조작하여 목재 칩을 투입하는 작업원의 활동을 지시·감독한다. 목재 칩이 기준에 맞도록 가공되었는지 검사결과를 확인하고 투입 및 반품 여부를 결정한다. 각종 목재 칩 검사장비 및 저장설비의 상태를 점검한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workEnv":"대기환경미흡|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8822","dJobECdNm":"[8822]펄프·종이 제조장치 조작원","dJobJCd":"8913","dJobJCdNm":"[8913]펄프 및 종이 제조 장치 조작원","dJobICd":"C171","dJobICdNm":"[C171]펄프, 종이 및 판지 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003268:1', '{"dJobCd":"K000003268","dJobCdSeq":"1","dJobNm":"펄프절단포장기조작원","workSum":"완성된 펄프를 소정의 규격으로 절단하여 포장하는 설비를 조작한다.","doWork":"작업지시서의 내용을 숙지하고, 작업공정에 따른 작업진행이 원활히 이루어질 수 있도록 절단 및 포장 설비를 점검한다. 건조공정에서 건조, 권취된 펄프와 작업규격서를 인수받는다. 작업규격에 맞도록 절단기를 세팅하는 작업을 한다. 작업진행에 따라 절단된 펄프가 규격에 맞게 재단되는지 확인하고 조정한다. 절단된 펄프를 와이어로 묶고 포장한다. 지게차를 사용하여 적재장소로 이동한다. 작업이 완료되면 작업내용을 작업일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8822","dJobECdNm":"[8822]펄프·종이 제조장치 조작원","dJobJCd":"8913","dJobJCdNm":"[8913]펄프 및 종이 제조 장치 조작원","dJobICd":"C171","dJobICdNm":"[C171]펄프, 종이 및 판지 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005883:1', '{"dJobCd":"K000005883","dJobCdSeq":"1","dJobNm":"펄프제품성형검사원","workSum":"완성된 펄프성형제품의 품질을 검사하고 일정량 수량씩 파악하여 적재한다.","doWork":"검사할 펄프성형제품의 작업규정 및 검사규정을 확인한다. 컨베이어 벨트를 통해 나오는 완성된 펄프성형제품의 외관을 검사하고 불량품을 선별한다. 선별된 불량품은 재활용하기 위하여 원료조성공정으로 보낸다. 완성된 펄프성형품을 일정 수량씩 접거나 포개서 저장소로 운반하거나 다음 공정으로 보낸다. 작업이 완료되면 불량요인을 점검하여 작업일지에 기록하고 관련 부서에 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"유지","dJobECd":"8822","dJobECdNm":"[8822]펄프·종이 제조장치 조작원","dJobJCd":"8913","dJobJCdNm":"[8913]펄프 및 종이 제조 장치 조작원","dJobICd":"C179","dJobICdNm":"[C179]기타 종이 및 판지 제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005650:1', '{"dJobCd":"K000005650","dJobCdSeq":"1","dJobNm":"펄프제품성형기조작원","workSum":"계란판, 종이도시락 등 펄프성형품을 제조하기 위하여 성형설비 및 관련 설비를 조작한다.","doWork":"제조할 성형제품에 대한 작업지시서를 확인하고 생산할 제품에 맞는 금형을 성형기에 설치한다. 성형기, 건조기, 적층설비 등 성형설비 및 관련 설비를 점검하고 정상적인 작업이 이루어질 수 있도록 관리한다. 제품의 성형조건을 조성하기 위하여 펄프의 농도, 중량, 수분함량, 변형조정, 건조온도, 작업속도 등을 점검하고 관련 설비의 조작반을 조정한다. 관련 수공공구, 원료 및 주변을 정리하고 작업일지에 작업내용을 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"고온|다습|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"8822","dJobECdNm":"[8822]펄프·종이 제조장치 조작원","dJobJCd":"8913","dJobJCdNm":"[8913]펄프 및 종이 제조 장치 조작원","dJobICd":"C179","dJobICdNm":"[C179]기타 종이 및 판지 제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006811:1', '{"dJobCd":"K000006811","dJobCdSeq":"1","dJobNm":"펄프제품프레스조작원","workSum":"성형기를 통해 나온 펄프성형제품의 표면을 고르게 펴주는 고열의 수증기를 이용한 프레스를 조작한다.","doWork":"작업내용을 숙지하고 작업에 필요한 프레스를 교체한다. 작업표준에 맞는 수증기량, 압력 및 속도 등을 조정하기 위하여 조작반을 조작한다. 펄프성형제품을 투입기에 투입하고 작동스위치를 조작한다. 작업되어 나오는 제품의 상태를 관찰하고 조작반을 조작하여 작업 기준에 맞도록 재조정한다. 작업 완료된 제품은 적치대에 적치한다. 작업내용을 작업일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|고온|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"8822","dJobECdNm":"[8822]펄프·종이 제조장치 조작원","dJobJCd":"8913","dJobJCdNm":"[8913]펄프 및 종이 제조 장치 조작원","dJobICd":"C179","dJobICdNm":"[C179]기타 종이 및 판지 제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003108:1', '{"dJobCd":"K000003108","dJobCdSeq":"1","dJobNm":"펄프표백기운전원","workSum":"증해된 미표백 펄프의 백색도를 높이기 위하여 표백공정을 관리·조작한다.","doWork":"작업지시서를 확인하고 작업공정에 따른 일정 및 작업 계획을 수립한다. 고농도 미표백 펄프 저장탱크, 표백약품(소다, 이산화염소, 염소 등) 저장탑, 표백기 등 각종 표백설비를 모니터와 조작반을 통하여 이상 유무를 점검한다. 미표백된 펄프와 약품을 믹서기에 투입하여 혼합시키고 표백기(반응탑)에 투입하여 표백한다. 표백된 펄프의 원료는 고농도 표백펄프 저장탱크에 저장한다. 조작반의 모니터를 통하여 작업 진행 상황을 관찰하고, 온도조건, 산염기조건, 약품의 농도를 조정한다. 이상이 발견되면 펄프표백기운전보조원에게 지시하여 문제점을 해결하도록 한다. 큰 보수를 요하는 설비는 전담 부서에 의뢰한다. 작업내용을 작업일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|다습|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8822","dJobECdNm":"[8822]펄프·종이 제조장치 조작원","dJobJCd":"8913","dJobJCdNm":"[8913]펄프 및 종이 제조 장치 조작원","dJobICd":"C171","dJobICdNm":"[C171]펄프, 종이 및 판지 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004361:1', '{"dJobCd":"K000004361","dJobCdSeq":"1","dJobNm":"골판지제조반장","workSum":"골판지를 제조하기 위해 골 성형기, 합지기, 건조기, 절단기 등을 조작하고 관리하는 작업원의 활동을 감독·조정한다.","doWork":"골판지 생산량을 파악하여 작업량을 작업원에게 통보한다. 제조된 골판지의 품질을 확인한다. 골판지 제조에 필요한 원자재 및 부자재를 청구·관리한다. 생산설비의 상태와 성능을 파악하여 개보수 계획을 세운다. 작업내용에 따라 작업원에게 지시하고 작업배치를 한다. 작업의 진행사항을 파악하고 작업내용을 보고한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원 및 자재를 공급한다. 작업계획에 따라 세부실행계획을 수립하고 작업절차 및 방법을 결정하여 작업원에게 작업내용을 지시하고 작업배치를 한다. 표준작업명세에 따라 지시된 작업이 이루어지는지 작업원과 함께 작업하며 작업상황을 관찰하고 작업내용을 점검한다. 작업원의 직무교육 및 안전위생교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴·해결하고 문제점을 보완한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8823","dJobECdNm":"[8823]종이제품 생산기계 조작원","dJobJCd":"8914","dJobJCdNm":"[8914]종이제품 생산기 조작원","dJobICd":"C172","dJobICdNm":"[C172]골판지, 종이 상자 및 종이 용기 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002144:1', '{"dJobCd":"K000002144","dJobCdSeq":"1","dJobNm":"골판지제조원","workSum":"골판지 제조를 위하여 합지기, 접착기 등의 각종 설비를 조작·관리한다.","doWork":"원지를 수령 받아 대차를 이용하여 자동원지걸이로 이동한다. 자동원지걸이를 조작하여 각종 원지를 걸이에 걸어준다. 표면 접착용 풀을 풀칠부에 흘려주기 위하여 접착 투입 밸브를 조작한다. 원단을 각 롤러에 걸어 합지기에 연결한다. 가열롤러(Heating Roller:건조기)의 온도를 계기로 확인한다. 골형성기의 작동스위치를 조작한다. 골 형성 상태, 접착제 도포량, 원단 수분상태, 건조기의 열상태 등을 점검한다. 골형성기에서 골 형성 내지와 표면지를 열판에 삽입하고 합지기를 조작한다. 풀 도포상태, 접착상태 등을 점검한다. 완성되어 나오는 골판지가 절단기로 이송되는 상태를 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8823","dJobECdNm":"[8823]종이제품 생산기계 조작원","dJobJCd":"8914","dJobJCdNm":"[8914]종이제품 생산기 조작원","dJobICd":"C172","dJobICdNm":"[C172]골판지, 종이 상자 및 종이 용기 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005678:1', '{"dJobCd":"K000005678","dJobCdSeq":"1","dJobNm":"발포제도포기조작원","workSum":"발포벽지 제조를 위하여 발포제를 원지에 도포하는 기계를 조작한다.","doWork":"벽지 제조에 사용되는 원지를 호이스트를 이용하여 원지투입구에 건다. 발포용재(염화수지)를 배합실에서 수령하여 발포용재 통에 투입 후 발포용재를 이송용 펌프를 이용하여 발포용 롤러에 붓는다. 지폭을 조정하고 일정 두께로 도포되도록 두루마리 원지의 투입속도, 장력 등을 조절한다. 기계를 가동하고 원지(原紙)를 도포용 롤러에 통과시켜 발포제를 도포한다. 발포제가 도포된 원지에 열을 가하여 발포제 부분이 부풀어 오르고 억제제 부분은 부풀어 오르지 않게 한다. 발포상태를 육안으로 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"8823","dJobECdNm":"[8823]종이제품 생산기계 조작원","dJobJCd":"8914","dJobJCdNm":"[8914]종이제품 생산기 조작원","dJobICd":"C172","dJobICdNm":"[C172]골판지, 종이 상자 및 종이 용기 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005314:1', '{"dJobCd":"K000005314","dJobCdSeq":"1","dJobNm":"발포제제조원","workSum":"발포용 벽지 제조에 사용되는 발포제를 제조한다.","doWork":"작업지시서에 따라 벽지 제조에 필요한 PVC, 가소제, 안정제, 발포제, 충진제, 희석제 등의 원료 및 부원료를 준비한다. 준비된 PVC를 배합기에 투입하고 가소제, 안정제, 발포제 등의 부원료를 계량하여 교반기에 투입하고 교반기를 작동한다. PVC입자가 큰 경우 입자를 작게 하기 위하여 밀링기를 조작한다. PVC가 부원료에 의해 미립자로 용해 및 분산되어 액체화되는 과정을 관찰하고 점도측정기를 사용하여 점도를 측정한다. 점도 조절제를 투입하여 점도 및 농도를 조정한다. 완성된 발포제를 롤러 밑에 넣고 입자를 보다 미세하게 갈아준다. 완성된 발포제를 저장소로 운반한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|다습|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"8823","dJobECdNm":"[8823]종이제품 생산기계 조작원","dJobJCd":"8914","dJobJCdNm":"[8914]종이제품 생산기 조작원","dJobICd":"C179","dJobICdNm":"[C179]기타 종이 및 판지 제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003497:1', '{"dJobCd":"K000003497","dJobCdSeq":"1","dJobNm":"위생용품가공설비조작원","workSum":"기저귀, 생리대와 같은 위생용품의 형태로 성형된 반제품을 완성품으로 가공하는 설비를 조작한다.","doWork":"제조할 제품의 작업명세서의 내용을 확인하고 작업에 따른 주요사항을 지시 받는다. 규정된 제품을 제조하기 위하여 생산에 필요한 테이프, 허리고무줄, 다리고무줄, 위생용품의 내장포장재 등의 각종 자재의 투입 여부를 확인한다. 완성품을 제조하기 위하여 각종 롤 및 원료투입 장치를 조작한다. 제품이 완성되는 작업속도를 관찰하며 완성된 제품의 외형 상태를 확인한다. 제품의 상태에 따라 불량요인을 제거하기 위하여 설비의 이상 부위를 점검·조치한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"8823","dJobECdNm":"[8823]종이제품 생산기계 조작원","dJobJCd":"8914","dJobJCdNm":"[8914]종이제품 생산기 조작원","dJobICd":"C179","dJobICdNm":"[C179]기타 종이 및 판지 제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005897:1', '{"dJobCd":"K000005897","dJobCdSeq":"1","dJobNm":"위생용품검사원","workSum":"기저귀, 생리대와 같은 위생용품 제조공정에서 반제품 및 완성제품을 품질규격과 비교하기 위하여 각종 품질검사를 한다.","doWork":"품질규격에 맞는 제품을 생산하기 위하여 각종 품질검사 항목을 숙지한다. 위생용품 제조공정에 투입되는 각종 원·부자재의 입고 시에 품질검사를 한다. 제조공정 간에 발생한 불량품을 검사하고 불량원인을 보고한다. 견본용 반제품 및 완제품을 광원이 있는 검사대(Light Table)에 올려놓고 육안검사를 통하여 외형상태, 내용물부착상태, 자재결함 여부 등을 검사한다. 자, 계량기, 장력측정기를 사용하여 치수, 무게, 장력 등을 측정하고, 작업표준서와 비교·검사한다. 위생적인 측면에서 제품의 안전성이 규격에 적합한지 검사한다. 각종 결함요인을 파악하여 관련 부서 및 관련 작업원에게 통보서를 작성하여 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"위생용품선별원","dJobECd":"8823","dJobECdNm":"[8823]종이제품 생산기계 조작원","dJobJCd":"8914","dJobJCdNm":"[8914]종이제품 생산기 조작원","dJobICd":"C179","dJobICdNm":"[C179]기타 종이 및 판지 제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004581:1', '{"dJobCd":"K000004581","dJobCdSeq":"1","dJobNm":"위생용품성형설비조작원","workSum":"기저귀, 생리대와 같은 위생용품을 제조하기 위하여 일정한 형태로 모양을 성형하는 가공설비를 조작한다.","doWork":"작업명세서의 지시사항을 숙지한다. 규정된 위생용품을 생산하기 위하여 제조에 필요한 분쇄펄프, 종이, 합성수지 등의 각종 원료투입 여부를 확인한다. 설비를 조작하여 성형 속도, 롤 간격 등을 조정한다. 자재의 정상적인 투입 여부 및 상태, 속도 등을 관찰하며 성형되는 제품의 외형을 확인한다. 설비의 이상 부위를 점검하여 조치한다. 작업진행 상황을 관찰하고 제품을 검사하여 품질을 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"8823","dJobECdNm":"[8823]종이제품 생산기계 조작원","dJobJCd":"8914","dJobJCdNm":"[8914]종이제품 생산기 조작원","dJobICd":"C179","dJobICdNm":"[C179]기타 종이 및 판지 제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001659:1', '{"dJobCd":"K000001659","dJobCdSeq":"1","dJobNm":"위생용품제조반장","workSum":"기저귀, 생리대와 같은 위생용품을 제조하는 공정의 작업원을 감독·조정한다.","doWork":"생산계획에 따라 세부작업계획을 수립하고 작업원을 배치한다. 작업원에 대한 산업안전 및 예방에 대한 교육을 실시하고 감독한다. 제품규격에 적합한 제품을 생산하기 위하여 전반적인 품질관리를 한다. 생산설비의 이상 유무를 점검하여 정상적인 작업이 진행될 수 있도록 관리한다. 작업자의 애로사항 및 작업 시 발생하는 문제점을 해결하고 관련 부서에 보고한다. 작업내용 및 작업 시 발생한 문제점 등을 작업일지에 기록하고 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8823","dJobECdNm":"[8823]종이제품 생산기계 조작원","dJobJCd":"8914","dJobJCdNm":"[8914]종이제품 생산기 조작원","dJobICd":"C179","dJobICdNm":"[C179]기타 종이 및 판지 제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002774:1', '{"dJobCd":"K000002774","dJobCdSeq":"1","dJobNm":"인쇄타발기조작원","workSum":"종이컵, 종이접시, 우유팩 등과 같은 각종 지기제조용 블랭크(Blank)를 제조하기 위하여 코팅 처리된 원지를 지시된 규격으로 재단하고 인쇄하기 위한 인쇄·타발기를 조작한다.","doWork":"기계의 권취기에 롤(Roll:두루마리) 상태의 코팅원지를 걸어준다. 에어실린더를 가동하여 전·후지를 자동으로 연결한다. 작업지시서에 따라 제조할 지기의 규격에 맞게 타발기의 재단 칼날을 조정한다. 인쇄기에 인쇄실린더를 끼우고 배합잉크를 탱크에 투입한다. 재단·인쇄된 블랭크가 일정 매수로 계수되도록 계수기를 조정한다. 기계를 가동하기 위하여 제어판의 버튼을 누른다. 제조된 블랭크의 재단 면과 인쇄상태를 검사한다. 설비를 점검하고 이상 시 보조작업원과 보수하고 관리한다. 작업내용을 작업일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|고온|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"지기블랭크제조기조작원, 헤드맨","dJobECd":"8823","dJobECdNm":"[8823]종이제품 생산기계 조작원","dJobJCd":"8914","dJobJCdNm":"[8914]종이제품 생산기 조작원","dJobICd":"C172","dJobICdNm":"[C172]골판지, 종이 상자 및 종이 용기 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004886:1', '{"dJobCd":"K000004886","dJobCdSeq":"1","dJobNm":"인쇄타발반장","workSum":"종이컵, 종이접시, 우유팩 등과 같은 각종 지기제품을 제조하는 작업원의 활동을 관리·감독한다.","doWork":"작업지시서를 확인하고 작업내용을 작업원에게 지시하며 작업배치를 한다. 작업에 필요한 원지공급기, 인쇄기, 타발기 및 운송장치 등 설비를 점검하고 정상가동이 될 수 있도록 관리한다. 생산계획에 따라 생산목표를 달성하기 위하여 생산관리 및 작업원의 안전관리를 한다. 작업을 총괄지시하고 작업에 따른 작업내용을 작업일지에 기록하고 보고한다. 자동화 공정이 이루어진 경우 기기에서 자동으로 작업내용이 작업일지로 작성되기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|고온|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","dJobECd":"8823","dJobECdNm":"[8823]종이제품 생산기계 조작원","dJobJCd":"8914","dJobJCdNm":"[8914]종이제품 생산기 조작원","dJobICd":"C172","dJobICdNm":"[C172]골판지, 종이 상자 및 종이 용기 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005441:1', '{"dJobCd":"K000005441","dJobCdSeq":"1","dJobNm":"절곡제판원","workSum":"각종 종이제품을 제조하기 위하여 원지를 규격에 맞게 절곡·절단할 수 있는 재단·타발장치 설치용 실린더 또는 철제 절곡판을 제작·조립한다.","doWork":"작업명세서의 작업내용 및 전개도면에 나타난 제품의 절곡·절단 규격을 확인한다. 원지(原紙:원료가 되는 종이)의 손실을 최소화하고 효과적인 작업이 이루어질 수 있도록 디자인된 설계도면을 준비한다. 적당한 규격의 실린더 또는 목형을 선택하고 절곡, 절단에 사용될 철선, 칼날을 준비한다. 디자인된 설계도면을 실린더 및 목재판에 부착한다. 부착된 도면에 따라 철선 및 칼날(Pinchers)을, 쇠톱 등의 수동공구를 이용하여 절곡·절단부위에 맞도록 높낮이 및 곡선부위를 조절하며 조립한다. 실린더 또는 절곡판의 조립면이 매끄럽도록 그라인더로 연마한다. 시제품을 통하여 정밀도를 검사하고 조정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"수동조작","dJobECd":"8823","dJobECdNm":"[8823]종이제품 생산기계 조작원","dJobJCd":"8914","dJobJCdNm":"[8914]종이제품 생산기 조작원","dJobICd":"C172","dJobICdNm":"[C172]골판지, 종이 상자 및 종이 용기 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002004:1', '{"dJobCd":"K000002004","dJobCdSeq":"1","dJobNm":"접착기조작원","workSum":"규격별로 절곡·절단된 종이타발 제품에 접착제를 도포하여 접착하는 기계를 조작한다.","doWork":"작업명세서의 지시된 풀칠 방향, 풀칠 면 수 및 제작방법 등 각종 작업사항을 숙지한다. 정상조업이 될 수 있도록 접착기(接着機) 및 관련 설비를 점검한다. 제작할 종이상자의 규격 및 접착방법에 따라 풀칠 방향 및 접착 면 수를 설정한다. 제조할 종이상자의 재질이나 제품규격 별로 접착기에 타발제품의 투입 방향, 접착제 도포기의 수, 접지장치, 롤압력장치, 건조장치 및 운반장치 등 관련 장치를 조정한다. 절곡·절단된 종이상자용 타발제품을 접착기 투입구에 투입한다. 시운전을 통하여 생산된 제품에 대하여 접지상태, 봉합상태 및 접착제 도포상태 등을 검사한다. 불량이나 규격에 합격하지 못하면 재조정을 통하여 정상제품이 되도록 기계장치를 조절한다. 기계의 접착용기를 확인하고 접착제를 보충한다. 핫멜트로 접착하는 경우는 접착제의 온도를 상승시켜 접착하기도 한다. 원지표면의 코팅면을 순간적으로 가열하여 접착하는 방법을 사용하기도 한다. 종이상자를 제조하는 경우는 스테칭기를 사용하여 이음부위를 연결하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","connectJob":"철기계조작원","dJobECd":"8823","dJobECdNm":"[8823]종이제품 생산기계 조작원","dJobJCd":"8914","dJobJCdNm":"[8914]종이제품 생산기 조작원","dJobICd":"C172/C179","dJobICdNm":"[C172]골판지, 종이 상자 및 종이 용기 제조업 / [C179]기타 종이 및 판지 제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005738:1', '{"dJobCd":"K000005738","dJobCdSeq":"1","dJobNm":"제대기조작원","workSum":"규격별로 절곡·절단되어 타발된 종이 반제품을 각종 지대(紙袋:봉투) 및 가방으로 제조하는 제대기를 조작한다.","doWork":"작업명세서에 제시된 봉투 및 지대(紙袋)를 제조하기 위하여 작업사항을 확인한다. 정상적인 작업이 이루어질 수 있도록 제대기(製袋機) 및 관련 설비를 점검한다. 규격별로 절곡·절단된 종이 반제품(블랭크:Blank)을 제대기 투입구에 투입한다. 제조할 지대의 종이재질이나 제품규격별로 제대기의 접지장치, 접착제 도포장치, 롤 압력장치, 건조장치 및 운반장치 등의 관련 장치를 조정한다. 시운전하여 지대 및 봉투의 봉합상태, 접착제 도포상태 및 접지상태 등을 검사한다. 불량이나 규격에 합격하지 못하면 재조정을 통하여 정상제품이 되도록 기계장치를 조절한다. 기계의 접착용기를 확인하고 아교, 풀 등의 접착제를 보충한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"봉투제조기조작원, 봉투접지기조작원","dJobECd":"8823","dJobECdNm":"[8823]종이제품 생산기계 조작원","dJobJCd":"8914","dJobJCdNm":"[8914]종이제품 생산기 조작원","dJobICd":"C172/C179","dJobICdNm":"[C172]골판지, 종이 상자 및 종이 용기 제조업 / [C179]기타 종이 및 판지 제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002212:1', '{"dJobCd":"K000002212","dJobCdSeq":"1","dJobNm":"제함기조작원","workSum":"생산된 제품을 포장하기 위하여 포장용 상자를 만들어 제공하는 제함기(製函:종이 따위로 상자를 만드는 기계)를 조작한다.","doWork":"생산계획서 및 작업지시서를 보고 투입할 상자의 규격 및 수량을 확인한다. 제함기(製函機) 및 투입 설비를 점검하고 이상 유무를 확인한다. 작업이 원활히 이루어질 수 있도록 작업장 주변을 정리하고 제함기 등의 설비를 규격제품에 맞게 세팅한다. 제함기를 조작하여 상자를 투입하고 작업진행에 발생하는 문제점을 해결한다. 작업내용을 일지에 기록한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"8823","dJobECdNm":"[8823]종이제품 생산기계 조작원","dJobJCd":"8914","dJobJCdNm":"[8914]종이제품 생산기 조작원","dJobICd":"C172/C179","dJobICdNm":"[C172]골판지, 종이 상자 및 종이 용기 제조업 / [C179]기타 종이 및 판지 제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003401:1', '{"dJobCd":"K000003401","dJobCdSeq":"1","dJobNm":"제호설비조작원","workSum":"골판지, 지관 등의 종이제품 제조에 사용되는 접착용 풀을 제조하기 위하여 제호설비를 관리·조작한다.","doWork":"제호설비의 물탱크에 물을 채우기 위하여 급수밸브를 조작한다. 일정량의 전분(옥수수가루)을 탱크에 투입한다. 스팀밸브를 필요 열량에 따라 알맞게 조절하고 전분을 혼합·배합시키기 위하여 교반모터를 조작한다. 탱크 내의 온수순화장치를 조절한다. 점도를 증가시키기 위하여 가성소다와 붕사를 적당한 시기에 투입한다. 점도, 온도, 시간 등을 확인하기 위하여 계기판을 본다. 완성된 풀을 저장탱크로 이송시키기 위하여 기어펌프를 조작한다. 골판지 골게이터 또는 지관제조공정에 보내는 접착제를 상온으로 유지하여 점도를 안정시키고 양호한 접합이 되도록 유지하기도 한다. 원·부자재 사용량을 작업일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"8823","dJobECdNm":"[8823]종이제품 생산기계 조작원","dJobJCd":"8914","dJobJCdNm":"[8914]종이제품 생산기 조작원","dJobICd":"C172/C179","dJobICdNm":"[C172]골판지, 종이 상자 및 종이 용기 제조업 / [C179]기타 종이 및 판지 제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006858:1', '{"dJobCd":"K000006858","dJobCdSeq":"1","dJobNm":"조성반장","workSum":"조성공정(펄프, 고지 및 부원료를 해리·정선·고해시켜 신문용지, 골판지, 백상지 등의 지료를 만들어 초지공정으로 보내는 공정)에 종사하는 작업원의 활동을 감독·조정한다.","doWork":"작업계획서를 확인하고 조성공정작업원(펄퍼기조작원, 고해기조작원, 정선기조작원)을 배치·감독한다. 펄프, 고지 및 각종 부원료의 재고를 확인하고 필요한 물품을 관련 부서에 요구한다. 각종 조성설비 및 원료탱크를 점검하고 정상적인 작업이 이루어질 수 있도록 관리한다. 생산계획에 따른 작업진행 및 생산품질을 보전하기 위하여 작업관리와 생산품질관리를 한다. 작업 진행 중 발생한 문제를 해결하기 위한 방안을 연구하고 조치한다. 작업원의 안전관리 및 교육을 실시한다. 생산계획에 따른 작업속도, 공급량, 품질상태 등 작업진행상황에 대하여 초지반장과 상의한다. 표백량, 유량, 체스트의 액위 등 제반 사항을 검사하여 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|고온|다습|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8823","dJobECdNm":"[8823]종이제품 생산기계 조작원","dJobJCd":"8914","dJobJCdNm":"[8914]종이제품 생산기 조작원","dJobICd":"C171","dJobICdNm":"[C171]펄프, 종이 및 판지 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002553:1', '{"dJobCd":"K000002553","dJobCdSeq":"1","dJobNm":"종이원료공급원","workSum":"위생용품, 화장지 등 각종 종이제품을 제조하기 위하여 원료를 투입하고 각종 설비를 조작한다.","doWork":"작업명세서를 숙지하고 투입할 각종 원·부자재의 종류 및 수량을 파악한다. 생산하는 제품의 종류에 따라 필요한 종이원단 및 각종 부자재를 원지걸이에 걸거나 투입구에 투입한다. 작업 진행사항을 관찰하며, 작업이 원활히 진행될 수 있도록 필요한 원·부자재를 적기에 투입한다. 생산 제품 및 규격에 따라 달라지는 설비의 장치물을 관련 조작원과 함께 교체하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"투입인출","dJobECd":"8823","dJobECdNm":"[8823]종이제품 생산기계 조작원","dJobJCd":"8914","dJobJCdNm":"[8914]종이제품 생산기 조작원","dJobICd":"C172/C179","dJobICdNm":"[C172]골판지, 종이 상자 및 종이 용기 제조업 / [C179]기타 종이 및 판지 제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002218:1', '{"dJobCd":"K000002218","dJobCdSeq":"1","dJobNm":"종이제품재단기조작원","workSum":"지대, 상자 및 기타 종이제품을 제조할 때 종이원단을 규격에 맞추어 절단하기 위하여 재단기를 조작한다.","doWork":"재단할 제품의 규격을 확인한다. 재단할 폭 및 깊이를 맞추기 위하여 재단기의 절단가이드, 칼날 등을 조절한다. 재단할 롤지 및 낱장지를 재단기에 투입하고 원하는 규격으로 절단되는지 시험하고 재조정한다. 재단되어 나오는 제품의 재단 상태 및 재단기의 이상 유무를 관찰한다. 재단기 및 주변설비의 이상 유무를 점검하고 정상적인 작업이 이루어질 수 있도록 관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","connectJob":"길이재단기조작원","dJobECd":"8823","dJobECdNm":"[8823]종이제품 생산기계 조작원","dJobJCd":"8914","dJobJCdNm":"[8914]종이제품 생산기 조작원","dJobICd":"C172/C179","dJobICdNm":"[C172]골판지, 종이 상자 및 종이 용기 제조업 / [C179]기타 종이 및 판지 제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005534:1', '{"dJobCd":"K000005534","dJobCdSeq":"1","dJobNm":"주름성형기조작원","workSum":"골판지의 내지(內紙)로 사용되는 주름(골)종이를 제조하는 기계를 조작한다.","doWork":"작업지시서에 표시된 형성할 주름(골)의 규격 및 형태를 확인한다. 주름 규격에 맞추어 원지(原紙:원료가 되는 종이)를 지게차를 이용하여 원지걸이에 걸어준다. 제조할 골판지의 형태와 규격에 맞추어 주름형성롤러를 교체한다. 원지걸이를 조작하여 원지를 주름형성롤과 각종 롤에 연결하여 준다. 열롤러(Heating Roller:건조기)의 온도를 계기로 확인한다. 주름성형기의 작동스위치를 조작한다. 형성되어 나온 주름의 상태 등을 점검한다. 주름성형기에서 주름형성 내지와 표면지를 열판에 삽입하고 합지기를 조작한다. 접착제 도포상태, 접착상태 등을 점검한다. 완성되어 나오는 골판지를 규정된 길이로 절단하기 위하여 커팅기를 조작한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|다습|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8823","dJobECdNm":"[8823]종이제품 생산기계 조작원","dJobJCd":"8914","dJobJCdNm":"[8914]종이제품 생산기 조작원","dJobICd":"C172","dJobICdNm":"[C172]골판지, 종이 상자 및 종이 용기 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005918:1', '{"dJobCd":"K000005918","dJobCdSeq":"1","dJobNm":"지관제조기조작원","workSum":"규격별로 재단된 종이원단을 이용하여 지관(紙管)을 제조하는 설비를 조작한다.","doWork":"작업지시서에 따라 제조할 지관의 규격을 확인한다. 지관제조기 및 접착제도포기를 점검하여 정상적인 작업이 이루어질 수 있도록 관리한다. 규정된 지관구경 규격에 맞는지 관을 제조하기 위하여 지관제조기의 구경조정기 및 접착제도포기의 도포량을 조정한다. 종이원단에 접착제를 도포하여 운반하도록 접착제도포기조작원에게 작업을 지시한다. 접착제가 도포된 종이원단을 지관제조기의 롤(Roll)과 드럼(Drum)에 걸어준다. 접착면에 열접착을 한다. 지관의 제조과정을 관찰하고 지관의 규격이 허용오차의 범위에서 제조되는지 확인한다. 지관의 접착상태를 확인하고 도포량을 조절하도록 지시한다. 작업진행에 맞게 작업속도를 조절한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"와인딩기조작원, 코어제조원","connectJob":"내부지관제조기조작원, 외부지관제조기조작원, 화장지용지관제조기조작원","dJobECd":"8823","dJobECdNm":"[8823]종이제품 생산기계 조작원","dJobJCd":"8914","dJobJCdNm":"[8914]종이제품 생산기 조작원","dJobICd":"C179","dJobICdNm":"[C179]기타 종이 및 판지 제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002408:1', '{"dJobCd":"K000002408","dJobCdSeq":"1","dJobNm":"지대봉합원","workSum":"공업용 재봉틀을 사용하여 지대의 양면을 봉합한다.","doWork":"봉합사(실)를 재봉틀의 바늘에 끼운다. 재봉틀의 속도를 적당하게 조정하고 전원스위치를 넣는다. 모서리(귀)가 접힌 지대의 봉합면을 재봉기로 밀어 넣고 재봉기의 가동 페달을 밟는다. 봉합부의 상태를 확인하고, 지대의 반대 봉합면을 재봉기로 밀어 넣어 봉합한다. 봉합상태가 불량한 지대를 선별하여 손바늘로 수리하기도 한다. 자동 봉합기를 조작하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"지대재봉원","dJobECd":"8823","dJobECdNm":"[8823]종이제품 생산기계 조작원","dJobJCd":"8914","dJobJCdNm":"[8914]종이제품 생산기 조작원","dJobICd":"C172/C179","dJobICdNm":"[C172]골판지, 종이 상자 및 종이 용기 제조업 / [C179]기타 종이 및 판지 제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001505:1', '{"dJobCd":"K000001505","dJobCdSeq":"1","dJobNm":"지사벽지제조기조작원","workSum":"종이를 꼬아 엮어 지사벽지를 생산하기 위한 원단을 만든다.","doWork":"작업지시서를 확인하여 작업내용을 파악한다. 종이를 일정 길이로 절단하기 위하여 규격서에 맞게 길이 및 폭 등을 조정한다. 절단된 종이를 염색한다. 염색된 종이를 꼬아 작업지시의 문양 및 형태로 짜기 위하여 지사기 및 관련 설비를 조작한다. 종이가 꼬아지고 짜지는 상태 및 진행상황을 관찰한다. 완성된 제품은 다음 공정으로 운반하기 위하여 임시 저장소에 보관한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"지사(紙絲)기조작원","dJobECd":"8823","dJobECdNm":"[8823]종이제품 생산기계 조작원","dJobJCd":"8914","dJobJCdNm":"[8914]종이제품 생산기 조작원","dJobICd":"C179","dJobICdNm":"[C179]기타 종이 및 판지 제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001939:1', '{"dJobCd":"K000001939","dJobCdSeq":"1","dJobNm":"측면접착기조작원","workSum":"종이상자(카턴팩)를 제조하기 위하여 중간재인 블랭크(Blank)의 측면을 열로 가열하여 접착하는 설비를 조작한다.","doWork":"작업지시서를 확인하고 작업내용에 따라 블랭크투입기, 접기 설비(Fold:접착부위를 접어주는 설비) 및 운송설비 등을 조정하여 종이상자(카턴팩) 완제품을 완성하기 위하여 조작반을 조정한다. 시운전을 통하여 제품의 접착면 용융 상태 및 접착 상태를 관찰하고 조정한다. 작업진행을 관찰하며 제품 및 설비의 이상을 확인하여 정상적인 제품이 생산되도록 조정한다. 설비를 점검하고 관리한다. 작업내용을 작업일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"8823","dJobECdNm":"[8823]종이제품 생산기계 조작원","dJobJCd":"8914","dJobJCdNm":"[8914]종이제품 생산기 조작원","dJobICd":"C172","dJobICdNm":"[C172]골판지, 종이 상자 및 종이 용기 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002497:1', '{"dJobCd":"K000002497","dJobCdSeq":"1","dJobNm":"측면접착반장","workSum":"종이상자(카턴팩)를 제조하기 위하여 중간재인 블랭크(Blank)의 측면을 접합하고 포장하는 공정에 종사하는 작업원의 활동을 감독·관리한다.","doWork":"작업지시서를 확인하고 작업내용을 작업원에게 지시하며 작업배치를 한다. 작업에 필요한 블랭크공급기, 버너장치, 계수기 및 운송장치 등 설비를 점검하고 정상가동이 될 수 있도록 관리한다. 생산계획에 따라 생산목표를 달성하기 위하여 생산관리 및 작업원의 안전관리를 한다. 작업을 총괄 지시하고 작업에 따른 작업내용을 작업일지에 기록하고 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","dJobECd":"8823","dJobECdNm":"[8823]종이제품 생산기계 조작원","dJobJCd":"8914","dJobJCdNm":"[8914]종이제품 생산기 조작원","dJobICd":"C172","dJobICdNm":"[C172]골판지, 종이 상자 및 종이 용기 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005617:1', '{"dJobCd":"K000005617","dJobCdSeq":"1","dJobNm":"커팅기조작원","workSum":"제조된 지관(紙管) 등의 종이제품을 규정된 규격으로 절단하는 커팅기를 조작한다.","doWork":"작업지시서의 지관 절단 규격을 확인한다. 규정된 제품규격으로 지관(紙管) 등의 종이제품을 절단하기 위하여 절단기의 조작반을 조작하여 절단치수를 입력한다. 절단할 제품을 절단기의 축(만도링)에 투입하고 인출한다. 절단된 지관의 외관을 검사하고 이상 시 절단칼날을 교체한다. 절단이 완료되면 원지와 철판을 접합시키는 시밍(Seaming) 공정으로 이동시킨다. 정상적인 작업이 이루어질 수 있도록 기계를 정비하고 관리한다. 제작된 제품의 외관상결함을 검사하고 작업진행이 원활히 이루어질 수 있도록 주변을 청결하게 정리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"8823","dJobECdNm":"[8823]종이제품 생산기계 조작원","dJobJCd":"8914","dJobJCdNm":"[8914]종이제품 생산기 조작원","dJobICd":"C179","dJobICdNm":"[C179]기타 종이 및 판지 제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004168:1', '{"dJobCd":"K000004168","dJobCdSeq":"1","dJobNm":"타발기조작원","workSum":"각종 종이상자 및 봉투 등 종이제품을 생산하기 위하여 규정된 형상으로 절단·절곡하는 타발기를 조작한다.","doWork":"작업지시서에 명시된 작업내용을 확인한다. 작업명세서에 규정된 제품으로 타발하기 위하여 작업에 필요한 절곡제판용 실린더 또는 목형을 수령하여 부착한다. 전 공정 인쇄물 또는 무인쇄물을 수령하여 원지걸이에 걸거나 낱장지를 원지투입구에 투입한다. 타발기(Diecutter)의 조작반 및 롤을 조정하여 종이의 장력, 속도 등을 조정한다. 시운전을 통하여 타발된 중간제품의 외형 및 상태 등을 검사하고 재조정한다. 작업을 정상적으로 진행하며 타발 상태 및 제품 상태 등을 관찰하여 규격제품으로 생산되는지 확인한다. 설비를 점검하여 정상적인 작업이 이루어질 수 있도록 유지·관리한다. 작업내용을 작업일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"다이커팅기(Die-Cutter)조작원, 톰슨기조작원","dJobECd":"8823","dJobECdNm":"[8823]종이제품 생산기계 조작원","dJobJCd":"8914","dJobJCdNm":"[8914]종이제품 생산기 조작원","dJobICd":"C172","dJobICdNm":"[C172]골판지, 종이 상자 및 종이 용기 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002447:1', '{"dJobCd":"K000002447","dJobCdSeq":"1","dJobNm":"합지기조작원","workSum":"각종 종이제품을 제조하기 위하여 각각 특성이 다른 종이 및 기타 재료를 합쳐주는 합지기 및 관련 설비를 조작한다.","doWork":"작업명세서에 명시된 합지 작업사항을 숙지한다. 합지에 필요한 두루마리 원지를 원지걸이에 걸어 롤의 실린더에 걸거나 낱장지를 원지투입구에 투입한다. 접착제의 농도를 맞추어 용기에 투입한다. 각각의 합지용 원단을 합지할 규격에 맞게 접합될 수 있도록 합지기 및 관련 설비를 조정하여 종이의 장력, 접착제의 도포, 접착상태 및 합지상태 등을 검사한다. 불량제품이 발생하면 원인을 분석하고 관련 기계를 조정하여 규정제품이 제조되도록 한다. 제조하는 제품에 따라 엠보싱 롤을 부착하여 인쇄 작업 전에 합지하거나 인쇄 작업 후에 합지한다. 합지 후에 열함기를 통과시켜 접착제가 마르게 한다. 인쇄공정에서 사용한 롤러를 교체하거나 세척하기도 한다. 2장 이상의 합지작업을 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","connectJob":"벽지합지기조작원, 초경벽지호부기조작원, 화장지합지기조작원","dJobECd":"8823","dJobECdNm":"[8823]종이제품 생산기계 조작원","dJobJCd":"8914","dJobJCdNm":"[8914]종이제품 생산기 조작원","dJobICd":"C172","dJobICdNm":"[C172]골판지, 종이 상자 및 종이 용기 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001383:1', '{"dJobCd":"K000001383","dJobCdSeq":"1","dJobNm":"화장지가공설비조작원","workSum":"각종 형태의 화장지로 제조하기 위하여 가공하는 설비를 조작한다.","doWork":"생산할 제품의 규격사항을 확인한다. 접지기, 권취기, 절단기, 지관 삽입장치 등의 각종 기계 및 장치를 점검하고 정상적인 작업이 이루어 질 수 있도록 관리한다. 초지공정 및 합지공정에서 제조된 화장지 원단을 원지걸이에 건다. 생산할 제품의 규격에 맞게 엠보싱롤의 압력, 화장지 권취길이, 접지규격, 절단 길이 등을 조정하기 위하여 각종 기계 및 장치를 조정한다. 시운전을 통하여 생산된 반제품 및 완제제품의 규격 및 외관 상태를 검사하여 규격제품이 제조될 수 있도록 재조정한다. 작업 진행 과정을 관찰하며 제품 및 설비의 이상 유무를 확인한다. 작업내용을 작업일지에 기록하고 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"8823","dJobECdNm":"[8823]종이제품 생산기계 조작원","dJobJCd":"8914","dJobJCdNm":"[8914]종이제품 생산기 조작원","dJobICd":"C179","dJobICdNm":"[C179]기타 종이 및 판지 제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006260:1', '{"dJobCd":"K000006260","dJobCdSeq":"1","dJobNm":"화장지제조반장","workSum":"두루마리 또는 낱장 형태의 화장지를 제조하는 작업원의 활동을 감독·조정한다.","doWork":"생산계획에 따라 작업원을 작업공정에 배치하고 산업안전 및 예방에 대한 교육을 실시한다. 제품규격에 적합한 화장지를 생산하기 위하여 작업공정을 점검하며 품질에 대한 전반적인 관리를 한다. 생산설비의 이상 유무를 점검·관리하며 이상 시 작업원과 보수한다. 작업자의 애로사항 및 작업 시 발생하는 문제점을 해결하고 관련 부서에 보고한다. 작업내용 및 작업 시 발생한 문제점 등을 작업일지에 기록하고 보고한다. 작업 현장을 순회하고 작업원과 함께 작업하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","connectJob":"롤화장지제조반장, 미용화장지제조반장, 키친타올화장지제조반장","dJobECd":"8823","dJobECdNm":"[8823]종이제품 생산기계 조작원","dJobJCd":"8914","dJobJCdNm":"[8914]종이제품 생산기 조작원","dJobICd":"C179","dJobICdNm":"[C179]기타 종이 및 판지 제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005417:1', '{"dJobCd":"K000005417","dJobCdSeq":"1","dJobNm":"목드럼제작원","workSum":"판재를 환거기로 절단하고 사면·자동·수동대패기로 다듬질한 후 정타기로 못을 쳐 전선포장용 목드럼을 제작한다.","doWork":"작업지시서에 따라 작업량을 확인한다. 수동공구, 환거기, 사면대패기, 자동대패기, 정타기 등 기계를 점검하고 필요하면 윤활유를 주입한다. 목재가공용 기계를 조작하여 판재를 규격에 따라 절단·제재·대패질·못질하여 목드럼을 완성한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8829","dJobECdNm":"[8829]기타 목재·종이 기계 조작원","dJobJCd":"8919","dJobJCdNm":"[8919]기타 목재 및 종이 관련 기계 조작원","dJobICd":"C162","dJobICdNm":"[C162]나무제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003410:1', '{"dJobCd":"K000003410","dJobCdSeq":"1","dJobNm":"철재판부착기조작원","workSum":"제조된 내·외부 지관(紙管)의 상·하단에 철재판을 부착하여 막아주는 시밍기(기밀접기마감기계)를 조작한다.","doWork":"작업명세서의 작업내용을 확인한다. 시밍기(Seaming)를 점검하여 정상적인 작업이 이루어질 수 있도록 관리한다. 철재판을 지관에 부착하기 위하여 철재판과 지관을 수령한다. 수령한 지관(紙管)과 철재판을 시밍기의 투입구에 투입한다. 철재판을 부착하기 위하여 시밍기를 조작하여 철재판을 말아줄 길이를 조정한다. 시밍기를 작동시키고 말림정도와 철재판의 부착상태를 관찰한다. 말림정도 및 부착상태가 작업명세서의 규정규격과 차이가 있으면 재조정한다. 원지와 철재판을 단단하게 결속시키는 공정으로 이동한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"시범후 30일 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"시밍기조작원","dJobECd":"8829","dJobECdNm":"[8829]기타 목재·종이 기계 조작원","dJobJCd":"8919","dJobJCdNm":"[8919]기타 목재 및 종이 관련 기계 조작원","dJobICd":"C179","dJobICdNm":"[C179]기타 종이 및 판지 제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002148:1', '{"dJobCd":"K000002148","dJobCdSeq":"1","dJobNm":"판깔개제작원","workSum":"전선권취용 드럼을 제작하기 위하여 양쪽 원형판을 제작한다.","doWork":"절단해 놓은 판재를 규정된 원형으로 절단하기 위해 중심구가 미리 뚫어진 판재를 가운데 위치하도록 놓고 판재를 규격에 맞게 정렬하여 놓는다. 또 다른 판재를 정렬한 판재 위에 엇갈리게 올려놓고 못을 박아서 고정시킨다. 중심구에 나무로 된 컴퍼스를 끼우고 연필을 끼워서 돌려 원형으로 그려준다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","dJobECd":"8829","dJobECdNm":"[8829]기타 목재·종이 기계 조작원","dJobJCd":"8919","dJobJCdNm":"[8919]기타 목재 및 종이 관련 기계 조작원","dJobICd":"C162","dJobICdNm":"[C162]나무제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006975:1', '{"dJobCd":"K000006975","dJobCdSeq":"1","dJobNm":"견출기조작원","workSum":"전화메모수첩이나 수첩 등에 ㄱ·ㄴ·ㄷ, 가·나·다, A·B·C 등의 순서에 맞추어 찾아보기 쉽도록 필요 없는 부분을 잘라내는 기계를 조작한다.","doWork":"견출할 수첩이나 전화메모지 등을 수령하여 작업대로 운반한다. 견출기를 시동하고 견출이 필요한 부분을 견출기의 칼날에 맞춘다. 견출기의 칼날 작동 페달을 밟아 견출할 부분을 잘라낸다. 견출한 부분의 상태를 검사한다. 칼날의 상태를 확인하여 마모된 칼날을 교체한다. 자동재단기를 사용하는 경우 디지털인쇄기에 견출기 시스템을 결합하여 자동으로 견출부분을 잘라내기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"투입인출","dJobECd":"8811","dJobECdNm":"[8811]인쇄기계 조작원","dJobJCd":"8921","dJobJCdNm":"[8921]인쇄기 조작원","dJobICd":"C181","dJobICdNm":"[C181]인쇄 및 인쇄관련 산업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005033:1', '{"dJobCd":"K000005033","dJobCdSeq":"1","dJobNm":"경인쇄기조작원","workSum":"소량의 부수를 신속하게 인쇄하기 위하여 마스터인쇄기를 조작한다.","doWork":"편집된 자료를 출판물편집자나 편집디자이너에게 인수받는다. 인쇄할 내용을 확인하고 편집물을 인쇄용 판을 제작하기 위하여 제판제조기에 편집된 내용을 입력한다. 입력한 자료를 이용하여 마스터지(Master-paper)에 제판한다. 인쇄기의 제판부착 롤에 마스터지를 부착한다. 종이의 규격이나 두께에 맞도록 판 롤과 롤 사이의 압력 및 간격, 인쇄 속도 등을 조정한다. 잉크를 조색하여 투입한다. 인쇄기를 작동시켜 인쇄물의 인쇄상태, 인쇄위치 등을 검사하여 재조정한다. 작업이 완료되면 롤 및 잉크통에 남은 잉크를 용제를 이용하여 세척한다. 인쇄물의 인쇄물량에 따라 마스터제판기를 전문적으로 조작하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","similarNm":"마스터인쇄기조작원, 비지니스폼인쇄기조작원","certLic":"인쇄기능사, 인쇄산업기사","dJobECd":"8811","dJobECdNm":"[8811]인쇄기계 조작원","dJobJCd":"8921","dJobJCdNm":"[8921]인쇄기 조작원","dJobICd":"C181","dJobICdNm":"[C181]인쇄 및 인쇄관련 산업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001787:1', '{"dJobCd":"K000001787","dJobCdSeq":"1","dJobNm":"광디스크인쇄원","workSum":"복제가 완료된 광디스크의 표면에 인쇄기를 사용하여 각종 이미지를 인쇄한다.","doWork":"작업지시서를 보고 인쇄할 광디스크의 품목과 수량을 확인한다. 투명한 광디스크(CD, DVD)에 인쇄가 가능하도록 광디스크 바탕 판에 흰색으로 실크 인쇄를 하고 자외선(UV)건조를 한다. 디자인된 제판을 수령하여 광디스크용 라벨프린터에 장착한다. 건조가 완료된 광디스크를 카트리지(자동투입장치)에 담아 라벨프린터에 투입한다. 인쇄속도, 수량 등을 입력하여 인쇄를 시작하고 초판에 이상이 없을 경우 대량 인쇄한다. 인쇄되어 나온 광디스크를 자외선건조기에 통과시켜 인쇄를 완료한다. 인쇄상태를 검사하고 포장공정으로 이동한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","connectJob":"광디스크오프셋인쇄원, 광디스크스크린인쇄원","certLic":"인쇄기능사, 인쇄산업기사","dJobECd":"8811","dJobECdNm":"[8811]인쇄기계 조작원","dJobJCd":"8921","dJobJCdNm":"[8921]인쇄기 조작원","dJobICd":"C182","dJobICdNm":"[C182]기록매체 복제업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;