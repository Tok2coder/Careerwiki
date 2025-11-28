INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006406:1', '{"dJobCd":"K000006406","dJobCdSeq":"1","dJobNm":"콘크리트성형기조작원","workSum":"벽돌, 블록 등의 콘크리트 제품을 제조하기 위하여 혼합된 원료를 성형몰드에 충전하여 콘크리트 제품을 성형하는 진동성형기를 운전·조작한다.","doWork":"콘크리트 원료공급장치의 스크루를 작동하여 이전 작업의 잔류물을 제거하고 콘크리트를 투입한다. 성형기에 적당량의 원료가 공급되도록 조정하고 모든 조절장치가 정상적으로 확인되면 스위치를 눌러 시험성형을 한다. 시험성형에 문제가 없으면 스위치를 자동으로 놓고 성형작업을 반복한다. 성형기 가동 중 압력계기를 점검하는 등 기기의 작동상태를 모니터링한다. 성형된 제품을 몰드에서 손이나 호이스트로 들어내어 적재하고 양생작업장으로 이동시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"콘크리트성형원","dJobECd":"8263","dJobECdNm":"[8263]시멘트·광물제품 생산기계 조작원","dJobJCd":"8433","dJobJCdNm":"[8433]시멘트 및 광물제품 제조기 조작원","dJobICd":"C233","dJobICdNm":"[C233]시멘트, 석회, 플라스터 및 그 제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005716:1', '{"dJobCd":"K000005716","dJobCdSeq":"1","dJobNm":"콘크리트원심성형기조작원","workSum":"콘크리트 제품을 성형하기 위하여 원심성형기를 운전·조작한다.","doWork":"콘크리트 투입기의 스크루를 작동하여 잔류물을 배출한다. 콘크리트를 투입기에 투입한다. 투입기를 원심대로 이동시키고 스위치를 눌러 콘크리트를 원심기에 투입한다. 콘크리트 투입이 완료되면 투입기를 후진한다. 스위치를 눌러 원심기를 공회전하고 콘크리트 투입 시 저속, 투입완료 시 중속, 중속 후 고속으로 운전한다. PC강선 또는 고무판이 부착된 사상봉으로 내면을 고르게 한다. 회전 중에 고정제를 살포한다. 성형이 완료되면 버튼을 눌러 원심기를 중지한다. 완료된 제품을 크레인으로 운반하여 양생실로 이동시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"원심사","dJobECd":"8263","dJobECdNm":"[8263]시멘트·광물제품 생산기계 조작원","dJobJCd":"8433","dJobJCdNm":"[8433]시멘트 및 광물제품 제조기 조작원","dJobICd":"C233","dJobICdNm":"[C233]시멘트, 석회, 플라스터 및 그 제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004676:1', '{"dJobCd":"K000004676","dJobCdSeq":"1","dJobNm":"콘크리트제조반장","workSum":"콘크리트제품 생산공장이나 건설현장의 주문에 따라 콘크리트를 소정량(Batch:1회분의 양)씩 생산하는 콘크리트제조공장의 작업원을 관리·감독한다.","doWork":"콘크리트 제조 공정의 중간검사 및 공정점검을 실시하여 콘크리트의 품질을 점검하고 관리한다. 공정관리일지를 확인하여 혼합시간, 계량허용차, 믹서 회전속도의 이상이 없는지 확인한다. 계량 및 혼합량의 허용치에 미달하거나 초과한 경우 계량기에 재료가 부착되어 계량오차가 발생하는지 확인하고 설정 값을 다시 확인한다. 오차계량 값을 감안하여 계량기준 값을 재설정한다. 혼합시간의 오차가 발생한 경우 타임스위치의 설정 값을 확인한다. 믹서 회전속도에 이상이 생기면 믹서에 부착된 모터의 상태 및 전압을 점검한다. 공정관리표의 교대근무자 확인사항을 점검하고 이상이 보고되면 수리, 점검 조치하도록 지시한다. 작업표준을 현장작업자에게 교육훈련하고 현장에 비치하여 활용되도록 지시한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","certLic":"콘크리트기능사, 콘크리트산업기사","dJobECd":"8263","dJobECdNm":"[8263]시멘트·광물제품 생산기계 조작원","dJobJCd":"8433","dJobJCdNm":"[8433]시멘트 및 광물제품 제조기 조작원","dJobICd":"C233","dJobICdNm":"[C233]시멘트, 석회, 플라스터 및 그 제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004313:1', '{"dJobCd":"K000004313","dJobCdSeq":"1","dJobNm":"콘크리트제품정형원","workSum":"콘크리트제품의 표면을 다듬고 파손부위를 교정한다.","doWork":"콘크리트 제품의 탈형 시 제품의 표면이 형틀에 달라붙어 떨어지거나 표면에 구멍이 발생한 부분을 확인한다. 제품에 사용된 콘크리트와 같은 배합의 모르타르를 혼합한다. 흙손을 사용하여 제품에 생긴 구멍과 갈라진 틈을 모르타르 반죽으로 메우고 표면을 고른다. 떨어져 나간 모서리 부분을 원형대로 정형하기 위하여 보조대를 대고 모르타르 반죽을 채워 넣는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"모르타르제품정형원, 흄관수정원","certLic":"콘크리트기능사, 콘크리트산업기사","dJobECd":"8263","dJobECdNm":"[8263]시멘트·광물제품 생산기계 조작원","dJobJCd":"8433","dJobJCdNm":"[8433]시멘트 및 광물제품 제조기 조작원","dJobICd":"C233","dJobICdNm":"[C233]시멘트, 석회, 플라스터 및 그 제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001825:1', '{"dJobCd":"K000001825","dJobCdSeq":"1","dJobNm":"콘크리트제품탈형원","workSum":"몰드 고정용 볼트를 임팩트렌치로 풀어 성형된 기물과 몰드를 분리한다.","doWork":"콘크리트 제품이 양생되어 담긴 몰드(Mold:형틀)를 호이스트(Hoist)를 이용해 탈형장으로 운반한다. 몰드의 조임볼트를 확인하고 임팩트렌치(Impact Wrench)로 볼트를 푼다. 분리된 성형품 및 몰드를 야적장이나 보관장소로 운반하여 적재한다. 분리된 성형품을 확인하여 성형품의 불량부분을 정형하거나 몰드를 청소하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"힘든 작업","workPlace":"실내·외","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"콘크리트기능사, 콘크리트산업기사","dJobECd":"8263","dJobECdNm":"[8263]시멘트·광물제품 생산기계 조작원","dJobJCd":"8433","dJobJCdNm":"[8433]시멘트 및 광물제품 제조기 조작원","dJobICd":"C233","dJobICdNm":"[C233]시멘트, 석회, 플라스터 및 그 제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005630:1', '{"dJobCd":"K000005630","dJobCdSeq":"1","dJobNm":"콘크리트혼합장치조작원","workSum":"시멘트, 모래, 자갈, 물 등의 원료를 일정량 투입하여 콘크리트를 혼합하는 혼합기를 운전·조작한다.","doWork":"작업지시서를 확인하고 호퍼(Hopper:분립체의 저장 및 공급장치)의 원료량이나 혼합기 내부의 청소상태를 점검한다. 골재의 입도 및 표면수 상태에 따라 배합을 보정한다. 시멘트, 모래, 자갈, 물 등의 재료를 계량한다. 제어판을 조작하여 혼합기 내의 교반용 로터를 가동한다. 시멘트, 모래, 자갈, 물 등의 원료를 배합비율에 맞추어 투입하고 혼합기를 일정 시간 가동한다. 혼합이 완료되면 운반통이나 분배관을 준비하고 배출한다. 작업완료 후 원료가 굳기 전에 혼합기의 내부를 물로 세척한다. 혼합기의 종류에 따라 원료를 연속적으로 투입하고 배출하는 혼합기를 다루기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"조작운전","connectJob":"콘크리트혼합원, 모르타르혼합원","dJobECd":"8263","dJobECdNm":"[8263]시멘트·광물제품 생산기계 조작원","dJobJCd":"8433","dJobJCdNm":"[8433]시멘트 및 광물제품 제조기 조작원","dJobICd":"C233","dJobICdNm":"[C233]시멘트, 석회, 플라스터 및 그 제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004274:1', '{"dJobCd":"K000004274","dJobCdSeq":"1","dJobNm":"키른운전원","workSum":"컨베이어·집진기·소성로와 부수장비를 제어실(Control Room)에서 조정하여 석회석을 굽는 작업을 한다.","doWork":"중앙제어실에서 모니터를 통하여 불꽃 색깔을 관찰하고 통제장치로 연료의 투입량을 조절하여 키른(kiln:회전가마)의 온도를 적절하게 유지한다. 운전일지에 가마온도, 연료소비, 소비된 동력 등의 공정 데이터를 기록하고 운전기록을 입력한다. 공정에 이상발생 시 조치를 취한다. 근무일지를 기록하여 다음 근무자에게 인수인계한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"소성로조작원","connectJob":"석회소성로제어장치조작원, 시멘트소성로제어장치조작원","dJobECd":"8263","dJobECdNm":"[8263]시멘트·광물제품 생산기계 조작원","dJobJCd":"8433","dJobJCdNm":"[8433]시멘트 및 광물제품 제조기 조작원","dJobICd":"C233","dJobICdNm":"[C233]시멘트, 석회, 플라스터 및 그 제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005845:1', '{"dJobCd":"K000005845","dJobCdSeq":"1","dJobNm":"탈판원","workSum":"양생이 끝난 슬레이트 제품과 적재판(Pallet)을 분리한다.","doWork":"제품이 적재된 적재판을 작업대로 운반한다. 적재된 제품을 탈판칼 등 용도와 크기에 맞는 작업도구를 이용하여 분리한다. 분리된 슬레이트 중 불량품을 분류하여 폐기하고 지정된 장소로 운반하여 적재한다. 사용된 적재판을 보수하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8263","dJobECdNm":"[8263]시멘트·광물제품 생산기계 조작원","dJobJCd":"8433","dJobJCdNm":"[8433]시멘트 및 광물제품 제조기 조작원","dJobICd":"C233/C239","dJobICdNm":"[C233]시멘트, 석회, 플라스터 및 그 제품 제조업 / [C239]기타 비금속 광물제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003169:1', '{"dJobCd":"K000003169","dJobCdSeq":"1","dJobNm":"고온피면처리기조작원","workSum":"석재표면에 열을 가하여 석재표면을 거칠게 하는 기계를 조작한다.","doWork":"석재표면에 토치 캐리지(Torch Carriage:불꽃발사장치)를 놓는다. 토치 캐리지의 조정나사를 돌려 이동 한계를 조정한다. 연료밸브를 열어 가스(LPG)가 토치에 흐르게 하고 점화를 한다. 밸브를 돌려 토치에 산소를 공급하고 가스(LPG)와 산소의 혼합비를 조절하여 화염을 조절한다. 토치를 작동하여 석재 위를 왕복한다. 석재표면의 거칠기 및 기계의 작동상태를 확인한다. 가스(LPG), 산소, 압축공기의 공급상태를 확인하기 위하여 계기와 조절판의 불빛을 관찰한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8264","dJobECdNm":"[8264]광석·석제품 생산기계 조작원","dJobJCd":"8434","dJobJCdNm":"[8434]광석 및 석제품 가공기 조작원","dJobICd":"C239","dJobICdNm":"[C239]기타 비금속 광물제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004588:1', '{"dJobCd":"K000004588","dJobCdSeq":"1","dJobNm":"광물추출원","workSum":"선광된 광석을 용해한 용액에서 순수광물결정을 추출하기 위하여 침지·하소·결정·여과·건조하는 작업을 수행한다.","doWork":"침지조·하소기·결정조·여과기·건조기·진공펌프·공급파이프 등의 설비 및 장비를 점검한다. 기계 구동부의 윤활유, 배관·탱크의 누수상태를 점검하고 조치한다. 광석용액 저장조의 밸브를 열어 용액의 흐름을 조절한다. 작업표준에 의해 각각의 기계 및 장치의 온도·압력 등을 고정시키고 전원을 넣어 가동한다. 각 공정의 용액의 흐름을 관찰하고, 견본을 채취하여 표준 여부를 확인한다. 광액의 농도를 확인하고 시약을 첨가한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실외","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"광물전처리원","connectJob":"건조원, 결정원, 여과원, 침지원, 탈수원","dJobECd":"8264","dJobECdNm":"[8264]광석·석제품 생산기계 조작원","dJobJCd":"8434","dJobJCdNm":"[8434]광석 및 석제품 가공기 조작원","dJobICd":"B061/B062","dJobICdNm":"[B061]철 광업 / [B062]비철금속 광업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004898:1', '{"dJobCd":"K000004898","dJobCdSeq":"1","dJobNm":"내장재무늬기계조작원","workSum":"가로 또는 세로로 재단된 내장재 반제품에 프레스(Press)를 이용하여 무늬를 성형하는 기계를 조작한다.","doWork":"작업지시서에 따라 성형할 무늬에 맞는 롤러로 교체한다. 종·횡으로 재단된 반제품을 컨베이어에 올려놓는다. 스위치를 조작하여 무늬롤러를 회전하고, 성형품을 무늬롤러에 통과시킨다. 롤러를 통과한 반제품의 상태를 파악하고, 이상이 있으면 롤러의 속도, 압력, 마찰강도를 조정한다. 무늬가 형성된 제품의 표면을 종·횡면취기를 사용하여 면취(Chamfer)되도록 스위치를 조작한다. 면취상태를 파악하여 이상 시 면취기를 상·하 또는 좌·우로 이동하여 적절히 맞춘다. 시운전이 완료되면 연속해서 작업한다. 무늬롤러가 마모되었을 경우 교환한다. 면취연마석이 마모된 경우 연마석을 교환한다. 무늬성형된 제품의 수량을 확인하고 적재하여 도장공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8264","dJobECdNm":"[8264]광석·석제품 생산기계 조작원","dJobJCd":"8434","dJobJCdNm":"[8434]광석 및 석제품 가공기 조작원","dJobICd":"C239","dJobICdNm":"[C239]기타 비금속 광물제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001635:1', '{"dJobCd":"K000001635","dJobCdSeq":"1","dJobNm":"마광원","workSum":"채취한 원광석을 일정한 크기의 미세한 입자로 분쇄하는 마광기를 조작한다.","doWork":"원료투입 및 마쇄(마광) 설비를 점검한다. 마쇄기 내부 라이닝의 마모상태를 확인하고 필요시 교체한다. 마광기 동력모터의 절연상태, 감속기 및 축의 윤활유상태를 확인하고 보충한다. 오일펌프를 점검하고 오일을 넣는다. 용수탱크 및 라인을 점검한다. 오일펌프를 가동하고 용수밸브를 열고 스위치를 넣어 마광기를 가동한다. 원료투입장치를 조작하여 마쇄기에 원료를 투입한다. 작업표에 마쇄기의 회전시간을 기입하고 작업 중 일어난 정전이나 기계고장으로 인한 정지시간을 기록하여 분쇄시간을 정확히 맞춘다. 일정 시간에 따라 마쇄기에 볼(Ball)을 공급한다. 투입하는 광석의 입도·처리량·광액의 농도를 수시로 점검하여 작업표준에 맞도록 조정한다. 규정시간 동안 마쇄가 진행되면 원료투입구의 덮개를 위로 하여 정지시키고 배출용 밸브를 갈아 끼운다. 배출용 밸브의 잠김을 확인하고 레버를 조절하여 배출구를 아래로 정지시킨 후 스위치를 내린다. 탈철기와 진동체를 가동하고 마광기의 배출밸브를 열고 배출량을 조절한다. 완전히 배출되면 용수밸브를 닫고, 마광기를 정지한 후 오일펌프를 정지한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실외","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"마쇄원, 미분쇄기조작원, 볼밀조작원","connectJob":"로드밀조작원, 페블밀조작원","dJobECd":"8264","dJobECdNm":"[8264]광석·석제품 생산기계 조작원","dJobJCd":"8434","dJobJCdNm":"[8434]광석 및 석제품 가공기 조작원","dJobICd":"B051/B061/B062","dJobICdNm":"[B051]석탄 광업 / [B061]철 광업 / [B062]비철금속 광업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003445:1', '{"dJobCd":"K000003445","dJobCdSeq":"1","dJobNm":"모래분리기조작원","workSum":"채취한 골재를 파쇄·세척·분별하여 모래와 자갈크기별로 분리시키기 위해 모래분리기를 조작한다.","doWork":"작업지시서에 명시된 광물입자별 크기를 파악한다. 기계장치의 이상 유무를 점검하고, 스크린에 붙어있는 암분 등 불순물을 털어낸다. 호퍼에 적재되어 있는 골재량을 확인하고 컨베이어 속도 및 스크린을 결정한다. 골재를 씻기 위해 급수시설을 점검한다. 스위치와 레버를 조작하여 스크린을 가동시키고, 골재의 크기에 따라 급광량 및 스크린의 진동수나 회전수를 조절한다. 분리된 모래를 컨베이어나 운반도구에 담아 지정된 장소로 운반한다. 컨베이어의 작동상태를 확인하고 컨베이어의 롤러에 기름을 친다. 작업이 완료되면 모래분리기를 점검한다. 모래를 관찰하여 크기나 이물질의 양을 검사한다. 작업일지에 일일생산량을 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실외","workEnv":"위험내재|다습|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8264","dJobECdNm":"[8264]광석·석제품 생산기계 조작원","dJobJCd":"8434","dJobJCdNm":"[8434]광석 및 석제품 가공기 조작원","dJobICd":"B071","dJobICdNm":"[B071]토사석 광업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003252:1', '{"dJobCd":"K000003252","dJobCdSeq":"1","dJobNm":"미분기운전원","workSum":"석탄(유·무연탄)을 미립자로 분쇄하여 보일러에 공급하는 미분기 및 보조기기를 조작·관리한다.","doWork":"분쇄기, 급탄기, 송풍기 등 각 설비를 점검하여 온도, 압력, 진동 및 누설 여부를 검사한다. 조정판의 각 계기를 조작하여 석탄의 분쇄량, 분쇄입도 등을 조정한다. 주기적으로 계기의 수치를 점검하여 지시량을 일지에 기록하고, 미분된 석탄의 견본을 채취하여 분쇄입도, 수분함유량 등을 확인한다. 정기보수공사 및 주요 기기의 보수 시에는 관련 기기의 보수상황을 파악하고 보수가 완료되면 현장을 확인하여 기기의 정상가동 여부를 점검한다. 가동 중에 발생하는 정지, 분쇄불량 등의 장애현상에 대한 조치요령을 검토하여 지침서를 작성한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"미분탄기조작원, 분탄기조작원","dJobECd":"8264","dJobECdNm":"[8264]광석·석제품 생산기계 조작원","dJobJCd":"8434","dJobJCdNm":"[8434]광석 및 석제품 가공기 조작원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002453:1', '{"dJobCd":"K000002453","dJobCdSeq":"1","dJobNm":"부선원","workSum":"무연탄을 적정 입도로 분쇄하여 광액 속에 기포를 형성·포집하여 열량을 증대하는 장비를 조작한다.","doWork":"원료를 이송하여 호퍼(Hopper:분립체의 저장 및 공급장치)에 저장한다. 원탄을 적정 입도로 분쇄한다. 장비작동 전 용수량, 스위치의 이상 유무·벨트의 마모상태, 급수펌프의 상태, 급유상태 등을 확인한다. 품질을 확보하기 위하여 적정 시약을 사용하고 기포상태를 점검하며 급수밸브를 조절한다. 부선이 끝난 광액을 탈수기에서 진공펌프로 탈수한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|","workEnv":"대기환경미흡|위험내재|저온|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"투입인출","dJobECd":"8264","dJobECdNm":"[8264]광석·석제품 생산기계 조작원","dJobJCd":"8434","dJobJCdNm":"[8434]광석 및 석제품 가공기 조작원","dJobICd":"C191","dJobICdNm":"[C191]코크스 및 연탄 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006158:1', '{"dJobCd":"K000006158","dJobCdSeq":"1","dJobNm":"부유선광원","workSum":"채취된 광물에서 유용광물을 분리해내기 위하여 부유선광기(광액과 공기를 혼합하여 미세한 공기포를 발생시키고 이 기포에 광물을 부착시켜 표면상으로 떠오르게 하여 분리하는 기계)를 조작한다.","doWork":"광액공급라인의 상태를 점검한다. 부유선광기의 임펠러·셀·교반기의 상태를 점검한다. 전동기 및 실린더 주유상태, 공기압축기 및 실린더의 작동상태, 모터 및 실린더와 풀리 사이의 벨트이완 및 단락상태, 셀 내부의 광미침전상태 등을 점검한다. 시약지시서를 확인하고 기포제·포집제·맥석통제제·억제제·촉진제 등의 시약을 용해하고 시약탱크를 확인하고 보충한다. 스위치를 넣어 후미쪽의 부유광선기부터 차례로 가동한다. 레버를 조작하여 광액을 급광한다. 시약공급기의 밸브를 조절하여 규정량의 시약을 공급하고 송풍기로 공기를 공급한다. 수시로 급광액의 농도를 확인하고 부유선광기별 거품의 품위를 점검하여 규정품질을 유지한다. 광액의 온도·농도·pH·시약첨가량을 수시로 점검하여 작업표준을 유지한다. 부유선광 상태를 감시하고 실린더 및 전동기 등의 발열·소음상태를 점검한다. 기계의 정지 시에는 충분한 시간 동안 공운전시켜 광미의 침적을 예방하고, 필요시에는 광액을 셀 밖으로 배출시킨 다음 부유선광기를 점검·보수한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실외","workEnv":"대기환경미흡|위험내재|다습|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"부선원","dJobECd":"8264","dJobECdNm":"[8264]광석·석제품 생산기계 조작원","dJobJCd":"8434","dJobJCdNm":"[8434]광석 및 석제품 가공기 조작원","dJobICd":"B051/B061/B062","dJobICdNm":"[B051]석탄 광업 / [B061]철 광업 / [B062]비철금속 광업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006577:1', '{"dJobCd":"K000006577","dJobCdSeq":"1","dJobNm":"석재공명기조작원","workSum":"공예 석제품을 제작하기 위하여 원통 형태로 석재를 자르는 공명기(Core Drill)를 조작·관리한다.","doWork":"공명기 작업에 사용할 원석을 선별한다. 선별된 재료를 지게차를 사용하여 작업장으로 운반한다. 재료를 작업대 위에 크레인으로 올려놓고 수평을 맞추어 고정한다. 무늬를 고려하여 제품화가 가능한 부분에 표시를 한다. 표면의 이물질을 걷어내고 암석부분을 노출 시킨 후 코어드릴(Core Drill:회전시키면서 바위를 뚫는 고리모양의 착암 날이 있는 기계)을 부착시켜 원통형 구멍을 뚫는다. 대형코어드릴을 사용할 경우 굴삭기에 코어드릴을 설치하고 굴삭기의 유압라인을 이용하여 뚫기도 한다. 상황에 따라 쐐기를 넣고 균열을 유도하여 뽑아내기도 한다. 가공된 원통형의 제품은 제품 금형에 올려놓고 폐자재는 지게차로 운반하여 폐기한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","dJobECd":"8264","dJobECdNm":"[8264]광석·석제품 생산기계 조작원","dJobJCd":"8434","dJobJCdNm":"[8434]광석 및 석제품 가공기 조작원","dJobICd":"C239","dJobICdNm":"[C239]기타 비금속 광물제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001504:1', '{"dJobCd":"K000001504","dJobCdSeq":"1","dJobNm":"석재모방가공원","workSum":"상세 가공이 쉽도록 원형과 유사한 형태로 석재를 가공하는 모방가공기를 조작한다.","doWork":"작업지시서에 따라 반가공된 석재의 품질, 수량, 작업내용을 확인한다. 공명기(특정의 형태로 석재를 자르는 기계)에서 석재 샘플을 채취하여 검사하고 선별한다. 모방가공기(석재가공기)의 절삭공구 상태를 점검한다. 모방가공기의 내부 바이스에 석재를 고정하고 투명한 안전망 외부에서 레버를 조작하여 절삭을 시작한다. 절삭이 끝난 제품은 측정도구로 치수를 확인하고 절삭면에 이물질이 없는지 점검한다. 양품을 선정하여 적재한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8264","dJobECdNm":"[8264]광석·석제품 생산기계 조작원","dJobJCd":"8434","dJobJCdNm":"[8434]광석 및 석제품 가공기 조작원","dJobICd":"C239","dJobICdNm":"[C239]기타 비금속 광물제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007202:1', '{"dJobCd":"K000007202","dJobCdSeq":"1","dJobNm":"석재연마원","workSum":"석제품의 표면을 연삭 또는 연마하여 표면처리를 한다.","doWork":"석재의 종류나 특성 또는 마무리공정에 따라 연마 또는 연삭숫돌을 선정한다. 연마기의 연마석 부착부위에 볼트를 조이거나 걸쇠로 걸어 연마석을 고정한다. 급수밸브를 열어 연마제와 물이 석재에 뿌려지도록 한다. 스위치를 넣어 연마기계를 가동한다. 석재표면의 고르지 못한 부분을 파악하기 위하여 석재의 표면에 물을 부어 물이 고이는 곳을 확인한다. 회전운동하는 연마숫돌을 작업물에 접촉시켜 연마한다. 에어건(Air Gun)으로 표면의 먼지와 물을 걷어내고 손으로 만져서 연마 정도를 파악한다. 명세서에 규정된 연마 정도와 비교·확인하고, 필요시 더 고운 연마제와 숫돌로 교체하여 연마한다. 연마기 위에 연마된 석재를 가지런히 놓고 수준기(水準器)로 연마상태를 측정하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"힘든 작업","workPlace":"실외","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"석재마무리원, 석제품연마기조작원, 연마석제품제조기조작원","dJobECd":"8264","dJobECdNm":"[8264]광석·석제품 생산기계 조작원","dJobJCd":"8434","dJobJCdNm":"[8434]광석 및 석제품 가공기 조작원","dJobICd":"C239","dJobICdNm":"[C239]기타 비금속 광물제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002122:1', '{"dJobCd":"K000002122","dJobCdSeq":"1","dJobNm":"석재재단기조작원","workSum":"석재 등의 비금속광물 제품을 규격에 맞추어 재단하기 위해 재단기를 조작한다.","doWork":"절단할 제품의 규격에 따라 모터와 절단날이 설치된 프레임의 위치를 조절하여 절단날의 깊이, 진행 간격을 조정한다. 절단날을 조정한 후 내장재를 한 장씩 재단기에 투입하여 종·횡 재단을 한다. 재단된 제품을 다음 공정을 위하여 다시 적재판에 적재한다. 재단면의 상태를 확인하고, 재단면이 고르지 못할 경우 절단날을 교환한다. 자동석재 재단기를 사용하는 경우 수치제어 패널을 조작하여 작업하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"석제품재단기조작원","dJobECd":"8264","dJobECdNm":"[8264]광석·석제품 생산기계 조작원","dJobJCd":"8434","dJobJCdNm":"[8434]광석 및 석제품 가공기 조작원","dJobICd":"C239","dJobICdNm":"[C239]기타 비금속 광물제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005222:1', '{"dJobCd":"K000005222","dJobCdSeq":"1","dJobNm":"석재절단기조작원","workSum":"석재를 일정한 크기로 자르기 위하여 와이어톱(Wire Saw)을 조작한다.","doWork":"작업지시서에 따라 절단할 석재의 수량, 크기, 절단위치를 확인한다. 보안경, 방진마스크, 작업복을 착용하고 와이어톱(Wire Saw:띠톱)의 톱날을 점검한다. 톱날의 마모상태, 작업물의 특성에 따라 톱날을 교체한다. 급수상태, 연마제의 공급상태를 확인한다. 호이스트, 지게차 등을 사용하여 절단기 작업대에 석재를 올려놓는다. 쇠지렛대, 쐐기, 수준기(水準器)를 사용하여 수평을 맞추고 고정고리로 고정한다. 자·직각자·먹줄 등을 사용하여 절단할 위치를 표시한다. 레버를 내려 고속으로 진행하는 톱날을 석재에 접촉시켜 절단한다. 절단된 석재의 규격을 측정하여 이상 유무를 파악한다. 이상이 있으면 재생할 수 있는 것과 폐기할 것을 구별하여 조치한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"석재절단원, 석제품절단기조작원, 석재와이어톱조작원, 석재줄톱조작원","dJobECd":"8264","dJobECdNm":"[8264]광석·석제품 생산기계 조작원","dJobJCd":"8434","dJobJCdNm":"[8434]광석 및 석제품 가공기 조작원","dJobICd":"C239","dJobICdNm":"[C239]기타 비금속 광물제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003449:1', '{"dJobCd":"K000003449","dJobCdSeq":"1","dJobNm":"석재천공원","workSum":"석판이나 석재에 구멍을 뚫기 위하여 천공드릴을 조작한다.","doWork":"작업지시서에 따라 천공(穿空:구멍을 뚫음)할 석재의 규격, 수량, 직경, 깊이, 위치를 확인한다. 보안경, 방진마스크, 작업복을 착용하고 천공드릴을 점검한다. 천공직경, 마모정도에 따라 날(Bit)을 교체한다. 천공할 석재를 작업대에 올려놓고 쇠지렛대, 쐐기, 수준기(水準器)를 사용하여 수평을 맞추고 고정고리로 고정한다. 자, 형판, 분필 등을 사용하여 천공부위를 표시한다. 기계를 가동하고 회전속도, 절삭유의 공급을 확인한다. 레버, 밸브를 조작하여 회전운동하는 날(Bit)을 수직으로 하강시켜 석재에 접촉하여 천공한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"힘든 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"석제품천공원","dJobECd":"8264","dJobECdNm":"[8264]광석·석제품 생산기계 조작원","dJobJCd":"8434","dJobJCdNm":"[8434]광석 및 석제품 가공기 조작원","dJobICd":"C239","dJobICdNm":"[C239]기타 비금속 광물제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006221:1', '{"dJobCd":"K000006221","dJobCdSeq":"1","dJobNm":"석재파쇄기조작원","workSum":"시멘트, 도자기 등의 원료와 유용한 광물을 추출하기 위해 돌이나 광물을 규정된 크기로 파쇄하는 파쇄기(Crushing Machine)를 조작한다.","doWork":"작업지시서에 따라 일일 분쇄량을 확인하고 작업계획을 세운다. 분쇄할 원료를 준비하고 분쇄기와 컨베이어(Conveyor)의 작동상태를 점검한다. 분쇄규격을 결정하고 파쇄기의 각종 계기, 주유, 벨트의 이완, 이송장치, 스크린 등을 점검한다. 분쇄할 원료를 분쇄기의 상부에 투입한다. 분쇄입도에 맞추어 분쇄기의 판 또는 턱의 간격을 조절한다. 원료투입장치의 속도를 조절하여 파쇄기의 능력에 맞게 투입량을 조절한다. 원료투입장치를 가동하여 분쇄기의 투입구로 원료를 공급하여 시험분쇄한다. 분쇄된 원료의 입경(지름)을 확인하고 분쇄판 또는 턱의 간격을 재조정한다. 분쇄기를 정상 가동하여 원료를 분쇄한다. 분쇄된 원료를 회전체나 진동체를 통과시켜 규정된 크기 이상의 원료는 걸러낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실외","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"조작운전","similarNm":"조쇄기조작원, 크러셔원","dJobECd":"8264","dJobECdNm":"[8264]광석·석제품 생산기계 조작원","dJobJCd":"8434","dJobJCdNm":"[8434]광석 및 석제품 가공기 조작원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001241:1', '{"dJobCd":"K000001241","dJobCdSeq":"1","dJobNm":"석재평삭기조작원","workSum":"석재나 석판을 일정한 형태로 만들고, 매끈하게 다듬거나 각지게 가공하기 위해 평삭기(平削機)를 조작한다.","doWork":"작업지시서에 따라 평삭작업 할 석재의 규격, 수량, 재질을 확인한다. 절삭공구의 마모 정도를 점검하여 필요시 교체한다. 렌치를 사용하여 절삭공구의 각도, 깊이를 조정한다. 급수상태를 확인한다. 호이스트, 지게차를 사용하여 석재를 작업대에 올려놓는다. 쇠지렛대, 쐐기, 수준기(水準器)를 사용하여 수평을 맞춘 후 고리에 고정한다. 자, 분필, 송곳을 사용하여 작업 부분을 표시한다. 버튼을 눌러 기계를 가동하고 레버를 작동하여 절삭한다. 평삭 정도를 육안으로 관찰하며 작업을 진행한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실외","workEnv":"위험내재|다습|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"석제품평삭기조작원","dJobECd":"8264","dJobECdNm":"[8264]광석·석제품 생산기계 조작원","dJobJCd":"8434","dJobJCdNm":"[8434]광석 및 석제품 가공기 조작원","dJobICd":"C239","dJobICdNm":"[C239]기타 비금속 광물제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006903:1', '{"dJobCd":"K000006903","dJobCdSeq":"1","dJobNm":"선탄기조작원","workSum":"채취된 원탄 중 석탄과 경석을 분리하기 위하여 비중차를 이용하여 분리시키는 선탄설비를 조작한다.","doWork":"공급기, 벨트컨베이어, 스크린, 진동체, 송풍기, 펌프, 침전조, 수선기, 중선기, 부선기 등 선탄설비를 점검하고 윤활유를 주입한다. 배전반의 전원, 전압, 전류 및 신호램프의 이상 유무를 확인한다. 원탄의 공급을 위하여 신호를 보내거나 스위치를 넣는다. 전원을 넣어 선탄설비를 가동한다. 컨베이어에 흐르는 원탄의 양을 감시하고 조절한다. 시약 또는 중액, 용수공급탱크를 확인하고 보충한다. 분리되고 선별되는 선탄과정을 감시하고 조정한다. 탄차, 컨베이어를 조작하여 분리된 석탄 및 폐석(경석)을 저탄장이나 폐석장으로 운반한다. 규정된 품위를 유지하기 위하여 수시로 견본을 채취하여 검사한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실외","workEnv":"위험내재|다습|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"선탄설비조작원","connectJob":"부유선탄기조작원, 수선탄기조작원, 중액선탄기조작원","dJobECd":"8264","dJobECdNm":"[8264]광석·석제품 생산기계 조작원","dJobJCd":"8434","dJobJCdNm":"[8434]광석 및 석제품 가공기 조작원","dJobICd":"C191","dJobICdNm":"[C191]코크스 및 연탄 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005541:1', '{"dJobCd":"K000005541","dJobCdSeq":"1","dJobNm":"원석할석원","workSum":"석재원석을 분할하는 할석(割石)기계를 운전·조작한다.","doWork":"할석기의 원판형 다이아몬드 톱날의 마모상태를 점검하고 필요시 교체한다. 호이스트, 지게차 등을 사용하여 대형다이아몬드톱날을 이동한다. 냉각수공급장치를 점검하고 윤활제의 공급에 이상이 있는지 점검하여 조치하고 시운전을 한다. 호이스트, 지게차, 크레인을 조작하여 원석을 대차에 고정한다. 원석의 상태에 따라 대차의 바닥에 시멘트를 타설하여 고정하기도 한다. 버튼을 조작해서 톱날을 회전시키고 하강레버를 조작해서 석재원석을 분할한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실내·외","workEnv":"위험내재|다습|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"가재단원","dJobECd":"8264","dJobECdNm":"[8264]광석·석제품 생산기계 조작원","dJobJCd":"8434","dJobJCdNm":"[8434]광석 및 석제품 가공기 조작원","dJobICd":"C239","dJobICdNm":"[C239]기타 비금속 광물제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003414:1', '{"dJobCd":"K000003414","dJobCdSeq":"1","dJobNm":"원형톱할석원","workSum":"석재를 규격에 맞추어 절단하기 위해 다이아몬드 또는 탄화규소질 날이 부착된 둥근톱을 설치·조작한다.","doWork":"작업지시서에 따라 절단할 석재의 규격, 수량, 절단범위를 확인하고 적합한 톱날을 선택한다. 톱날의 마모를 확인하여 필요시 교체한다. 냉각수과 연마제의 공급을 확인한다. 호이스트, 쇠지렛대를 이용하여 석재를 작업대 위에 놓고 수평자, 수준기를 보면서 쐐기를 망치로 두드려서 수평을 맞춘다. 자, 직각자를 사용해서 석재에 치수를 표시하고 연필, 송곳, 먹줄로 선을 그은 다음 정과 망치로 선을 따라 절삭선을 표시한다. 작업대를 이동시켜 톱날 하부에 고정한다. 손잡이로 톱날을 내려 절단위치를 확인하고 보안경, 마스크를 착용하고 버튼을 눌러 톱날을 회전시킨다. 회전하는 톱날을 석재에 접촉시켜 절단하고 절단하는 동안 냉각수 또는 연마제의 공급에 유의한다. 절단된 석재의 크기를 확인하고 절단면의 불량을 검사하여 양품을 적재한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"절단톱조각원, 회전톱조각원","dJobECd":"8264","dJobECdNm":"[8264]광석·석제품 생산기계 조작원","dJobJCd":"8434","dJobJCdNm":"[8434]광석 및 석제품 가공기 조작원","dJobICd":"C239","dJobICdNm":"[C239]기타 비금속 광물제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002260:1', '{"dJobCd":"K000002260","dJobCdSeq":"1","dJobNm":"파쇄반장","workSum":"채취한 광물에서 유용광물을 분리하거나 입자 크기를 균일하게 하기 위하여 광물을 파쇄·마쇄하는 작업원들의 활동을 감독·조정한다.","doWork":"선광감독의 작업지시를 받고 작업계획을 수립한다. 작업량을 지시하고 작업원들을 각 공정에 배치한다. 장비 및 시설을 점검·관리한다. 작업장을 순시하여 기계가동 상태를 점검하고 작업원들의 활동을 감독한다. 작업의 기술적 요인을 제시하고 작업을 조정한다. 광물의 파쇄·마쇄상태를 주시하고 적정한 입자가 유지될 수 있도록 기계상태 및 작업활동을 조정한다. 기계 및 장비의 정비상태를 점검하고 고장 시 조치한다. 작업 및 보안일지를 작성한다. 시험작업이나 작업원이 하기 어려운 작업은 직접 기계 및 장비를 조작하여 수행하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실외","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","dJobECd":"8264","dJobECdNm":"[8264]광석·석제품 생산기계 조작원","dJobJCd":"8434","dJobJCdNm":"[8434]광석 및 석제품 가공기 조작원","dJobICd":"B051/B061/B062","dJobICdNm":"[B051]석탄 광업 / [B061]철 광업 / [B062]비철금속 광업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006183:1', '{"dJobCd":"K000006183","dJobCdSeq":"1","dJobNm":"광학세라믹소재가공원","workSum":"제조된 재료를 가공, 코팅, 표면관리, 세정 작업을 거쳐 성형가공 한다.","doWork":"도면에 따라 물체의 모양, 크기, 구조, 제작방법 등을 파악한다. 제품 가공에 맞는 장비, 도구, 작업 순서를 결정하고 머시닝센터, 평면연마기, 원통연마기, 양면연마기, 단면연마기, 레이저 가공기 등을 사용하여 가공한다. 폴리싱(고체의 표면을 다른 고체의 모서리나 표면으로 문질러 매끈하게 하는 것)작업을 수행한다. 코팅장비를 사용하여 광학재료 표면에 기능성 코팅을 한다. 초음파장비, 열처리 장비, 세정제를 사용하여 세정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8269","dJobECdNm":"[8269]기타 비금속제품 생산기계 조작원","dJobJCd":"8439","dJobJCdNm":"[8439]기타 비금속제품 관련 생산기 조작원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002851:1', '{"dJobCd":"K000002851","dJobCdSeq":"1","dJobNm":"광학세라믹소재성형원","workSum":"냉각, 성형, 이형 작업을 수행하여 광학세라믹소재를 성형하고 성형물성을 평가한다.","doWork":"배치혼합물(용융된 상태의 유연한 광학재료)의 적절한 냉각속도를 결정한다. 실투(失透:유리 중 성분의 하나 또는 수종의 성분에 의해 구성되는 결정체가 그 유리 중에서 분리, 석출하는 현상으로 유리 내 결정이 있는 경우 유리의 투명성을 잃게 됨)가 일어나지 않도록 냉각속도, 점도 변화를 관찰한다. 설계된 형상에 따라 몰드의 구조와 재질을 결정한다. 몰딩 타이밍과 블로우압, 프레스압 및 냉각풍속 등을 결정한다. 요구되는 광학재료의 품질에 따라 몰드 내부형상과 열 교환능력을 결정한다. 광학재료를 연화하지 않는 상태까지 몰딩하고 냉각하여 원하는 형상으로 성형한 후, 몰드에서 형상화된 완성제품을 분리한다. 성형물 내에 실투허용 기준, 성형물 내 기포 허용기준, 성형물 균질도 기준에 부합하는지 검사·평가한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"위험내재|고온|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8269","dJobECdNm":"[8269]기타 비금속제품 생산기계 조작원","dJobJCd":"8439","dJobJCdNm":"[8439]기타 비금속제품 관련 생산기 조작원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006213:1', '{"dJobCd":"K000006213","dJobCdSeq":"1","dJobNm":"광학세라믹소재어닐링원","workSum":"광학세라믹소재를 제조하기 위해 용융 후 냉각과 성형공정 중 형성되는 잔류응력을 분석하고 이를 해소시키는 공정을 운영한다.","doWork":"잔류응력을 해소할 수 있는 어닐링(재료를 적당히 가열함으로써 재료의 내부구조 속에 남아있는 열 이력 및 가공에 의해 생성된 응력을 제거하는 과정) 온도와 시간, 점도 특성에 따른 온도, 제품 형상에 따른 어닐링 공정 변수를 결정한다. 가열장비(어닐링로)의 분위기를 제어한다. 용융공정변수와 성형공정변수에 따라 잔류응력 평가에 필요한 관리시점을 결정한다. 응력평가장비를 사용하여 잔류응력이 큰 제품 내 위치를 결정하고 응력을 평가한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"위험내재|고온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8269","dJobECdNm":"[8269]기타 비금속제품 생산기계 조작원","dJobJCd":"8439","dJobJCdNm":"[8439]기타 비금속제품 관련 생산기 조작원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001605:1', '{"dJobCd":"K000001605","dJobCdSeq":"1","dJobNm":"광학세라믹소재용융원","workSum":"광학세라믹소재 용융공정에 필요한 용융, 청징(Fining), 내화물 관리, 온도 관리업무를 수행한다.","doWork":"청징(Fining:원료배치를 조합해서 용융한 후 용융물 속에 존재하는 기포를 제거하는 작업) 작업을 준비한다. 요구되는 광학재료의 품질에 따라 청징정도를 결정한다. 가열장치(용융로)를 조작하고 조절한다. 용융도를 결정하고 가열장치를 조작한다. 용융로(내화물과 발열장비로 구성되어 원료배치혼합물을 고체분말상태에서 액체상태로 용융할 때 사용하는 가열장치) 설계에 따라 배치된 내화물을 설치하고 조작하며 노후된 내화물을 교체한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|시각|","workEnv":"위험내재|고온|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8269","dJobECdNm":"[8269]기타 비금속제품 생산기계 조작원","dJobJCd":"8439","dJobJCdNm":"[8439]기타 비금속제품 관련 생산기 조작원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006109:1', '{"dJobCd":"K000006109","dJobCdSeq":"1","dJobNm":"광학세라믹소재포장원","workSum":"제조된 광학세라믹소재를 포장지, 가스, 충진재를 사용하여 포장한다.","doWork":"광학재료의 경도 및 오염도에 따라 1차 포장지(PE 필름, 스펀지, 종이 박스, PVC 박스 등)를 선정하고 1차 포장한다. 품질 유지와 포장 전 포장 내부의 청정도를 유지하기 위한 분위기가스(질소 등)를 선정하여 충진한다. 광학재료의 물성에 따라 적합한 충전재의 재질, 형상을 선정하고 충전재로 포장한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8269","dJobECdNm":"[8269]기타 비금속제품 생산기계 조작원","dJobJCd":"8439","dJobJCdNm":"[8439]기타 비금속제품 관련 생산기 조작원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006868:1', '{"dJobCd":"K000006868","dJobCdSeq":"1","dJobNm":"광학세라믹소재혼합원","workSum":"요구되는 광학특성을 지닌 세라믹재료를 혼합하기 위해 계량, 혼합, 조제, 배치평가 업무를 수행한다.","doWork":"칭량장비, 혼합설비(볼밀, 비즈밀 등), 혼합균일도 분석장비, 조성분석기(XRF,ICP 등), 기초원료, 첨가제, 조성 분석용 시약을 준비한다. 광학재료의 조성에 따라 주조성, 부조성 재료를 정밀저울을 사용하여 칭량한다. 칭량한 재료를 혼합설비를 사용하여 혼합하고 혼합균일도를 측정한다. 혼합특성을 시험하고 평가한다. 혼합된 원료를 조제기준(조성, 입도, 요구되는 광학특성)에 따라 조제한다. 조제량, 조성, 입도분포의 추이를 확인한다. 배치평가(혼합된 배치의 조성, 함수율, 균질도, 안식각 등을 검사·평가하여 성분이나 특성이 전체적으로 같아, 하나의 배치에서 어느 부분을 취하여도 성분이나 특성이 일정한 것) 업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"8269","dJobECdNm":"[8269]기타 비금속제품 생산기계 조작원","dJobJCd":"8439","dJobJCdNm":"[8439]기타 비금속제품 관련 생산기 조작원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006851:1', '{"dJobCd":"K000006851","dJobCdSeq":"1","dJobNm":"내열구조세라믹소재성형원","workSum":"내열구조 세라믹 제품을 제조하기 위해 사출성형, 가압성형, 주입성형, 냉간정수압성형 작업을 수행한다.","doWork":"원료배합, 혼합, 분산 작업표준에 따라 윤활제(사출이 원활하게 진행되도록 마찰을 감소시키는 역할을 하는 첨가제), 결합제(사출된 제품이 서로 분리되지 않고 한 덩어리를 유지할 수 있도록 돕는 첨가제)의 종류와 첨가량을 확인한다. 성형체 상태의 특성 결정 요소를 확인한다. 작업표준에 의해 사출성형(점성을 가진 원료를 희망하는 형상을 가진 틀 안에 압력을 가해 채우는 성형과정)공정, 가압성형공정, 주입성형공정(물 등의 액체에 세라믹스분말을 분산시킨 현탁액을 석고에 부었을 때 액체가 제거되면서 분말이 석고표면에 쌓이는 현상을 이용하는 성형법. 원하는 목적물의 음각형상을 미리 석고로 제작하여 성형에 이용), 냉간정수압 성형(물 등의 유체를 이용해 분말 성형체에 고르게 압력을 가하는 기술로서 성형체가 균질하고 높은 밀도 분포를 가짐) 공정 작업을 수행한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"위험내재|고온|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8269","dJobECdNm":"[8269]기타 비금속제품 생산기계 조작원","dJobJCd":"8439","dJobJCdNm":"[8439]기타 비금속제품 관련 생산기 조작원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005538:1', '{"dJobCd":"K000005538","dJobCdSeq":"1","dJobNm":"내열구조세라믹재료가공원","workSum":"내열구조 세라믹 제조공정에서 도면에 따라 반제품을 치수에 맞게 가공한다.","doWork":"작업표준서 및 도면에 따라 피가공물의 작업순서를 결정하고 가공방법을 결정한다. 절삭공구, 연마공구, 절삭유, 세척용액, 연마용품, 측정용 공구를 준비한다. 절삭가공, 연마가공, 표면처리 등의 방법으로 가공한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8269","dJobECdNm":"[8269]기타 비금속제품 생산기계 조작원","dJobJCd":"8439","dJobJCdNm":"[8439]기타 비금속제품 관련 생산기 조작원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002678:1', '{"dJobCd":"K000002678","dJobCdSeq":"1","dJobNm":"내열구조세라믹재료세정원","workSum":"내열구조 세라믹 제조과정에서 건식세정, 습식세정을 통해 불필요한 부산물 및 이물질을 제거하고 포장한다.","doWork":"작업표준서에 따라 세정할 품목과 수량을 확인한다. 저울, 세정기, 건조기, 포장기, 세정액, 증류수(탈이온수), 포장지를 준비한다. 세정조건에 따라 적합한 장비를 선정하고 최종제품의 표면상태 요구조건을 확인한다. 세정기, 건조기를 사용하여 세정한다. 세정된 제품이 오염되지 않도록 포장한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8269","dJobECdNm":"[8269]기타 비금속제품 생산기계 조작원","dJobJCd":"8439","dJobJCdNm":"[8439]기타 비금속제품 관련 생산기 조작원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005020:1', '{"dJobCd":"K000005020","dJobCdSeq":"1","dJobNm":"내열구조세라믹재료소결원","workSum":"내열구조 세라믹 제조공정에서 성형체에 열을 가해 최종 제품을 생산하는 소결작업을 수행한다.","doWork":"작업표준서에 따라 소결조건, 소결방법을 결정하고 작업계획을 수립한다. 소결방법에 따라 상압소결(소결 분위기가 일반 대기 분위기), 가압소결(성형체 또는 1차 소결체에 압력을 가해주는 공정으로 형체에 압력을 가해주면서 소결하는 Hot Pressing 또는 1차 소결체에 압력을 가하면서 소결하는 Hot Isostatic Pressing 공법), 분위기 소결(소결 분위기가 일반 대기가 아닌 특정 가스 분위기), 진공 소결(진공 펌프를 이용하여 소결로의 분위기를 진공 상태로 함) 공정을 수행한다. 작업결과를 기록하고 보고서를 작성한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"위험내재|고온|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8269","dJobECdNm":"[8269]기타 비금속제품 생산기계 조작원","dJobJCd":"8439","dJobJCdNm":"[8439]기타 비금속제품 관련 생산기 조작원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006480:1', '{"dJobCd":"K000006480","dJobCdSeq":"1","dJobNm":"내열구조소재재료혼합원","workSum":"내열구조 세라믹을 제조하기 위해 원료혼합, 혼합분말의 특성 확인, 과립제조 작업을 수행한다.","doWork":"선별된 원료 분말의 특성을 확인하고 제품 생산에 적합한지 판단한다. 원료 혼합기의 종류, 용량, 가동범위를 파악한다. 작업지시서에 따라 혼합기를 조립, 운전, 분해, 청소한다. 원료혼합공정을 진행한다. 원료의 특성분석 보고서를 토대로 혼합분말 특성을 확인한다. 작업지시서에 따라 분말과립화(분말을 일정한 크기의 입자로 만드는 과정. 세립, 과립, 정제 제조의 중간형태의 공정. 건식과립법, 습식과립법, 분무과립법 등) 공정작업을 수행한다. 공정수행결과를 일지에 기록하고 제조된 과립의 특성을 평가한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"8269","dJobECdNm":"[8269]기타 비금속제품 생산기계 조작원","dJobJCd":"8439","dJobJCdNm":"[8439]기타 비금속제품 관련 생산기 조작원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005304:1', '{"dJobCd":"K000005304","dJobCdSeq":"1","dJobNm":"바이오세라믹재료가공원","workSum":"연마, 기계가공, CNC가공 등의 작업을 수행하여 바이오세라믹 재료를 만든다.","doWork":"작업표준서, 도면 및 제조지시서에 따라 작업순서를 확인하고 가공작업 방법, 측정 및 수정방법을 결정한다. 가공작업을 수행하기 위해 필요한 제품 형상, 크기 및 공차 등을 확인한다. 절삭조건(회전수, 절삭이송, 공구각, 절삭깊이 등)을 확인하고 절삭공구 및 CNC가공장비를 사용하여 절삭가공한다. 연마공구, 절삭유, 세척용액, 연마용품, 측정용 공구를 준비하고 연마가공 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8269","dJobECdNm":"[8269]기타 비금속제품 생산기계 조작원","dJobJCd":"8439","dJobJCdNm":"[8439]기타 비금속제품 관련 생산기 조작원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005550:1', '{"dJobCd":"K000005550","dJobCdSeq":"1","dJobNm":"바이오세라믹재료성형원","workSum":"사출, 프레스, 슬립캐스팅, 냉간정수압성형(CIP) 등의 공정을 수행하여 바이오세라믹재료를 성형한다.","doWork":"작업 방법에 따라 사출성형 공정(점성을 가진 원료를 희망하는 형상을 가진 틀 안에 압력을 가해 채우는 공정), 슬립캐스팅 공정(물 등의 액체에 세라믹 분말을 분산시킨 현탁액을 석고에 부었을 때 액체가 제거되면서 분말이 석고표면에 쌓이는 현상을 이용하는 성형공정), 냉간정수압성형 공정(CIP:Cold Isostatic Press, 물 등의 유체를 이용해 분말 성형체에 고르게 압력을 가하는 공정. 성형체가 균질하고 높은 밀도 분포를 갖도록 함) 작업을 수행하여 일정한 형상을 제작한다. 밀봉작업(정수압 성형과정에서 물 등의 가압매개체가 성형체로 침투하지 않도록 하는 작업. 고무와 같은 유연한 소재를 성형체에 씌운 뒤 진공 처리)을 수행한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"위험내재|고온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8269","dJobECdNm":"[8269]기타 비금속제품 생산기계 조작원","dJobJCd":"8439","dJobJCdNm":"[8439]기타 비금속제품 관련 생산기 조작원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002344:1', '{"dJobCd":"K000002344","dJobCdSeq":"1","dJobNm":"바이오세라믹재료소결원","workSum":"세라믹 분말 성형체를 열처리하여 제품에 필요한 기계적 특성을 부여하는 소결체 공정을 수행한다.","doWork":"소결로(상압소결로, 가압소결로, 분위기소결로, 진공소결로), 성형품 운반대차, 소결로 장입용 대차, 가스레귤레이터, 가스봄베 등을 준비한다. 작업표준서에 따라 소결로의 조건을 구성하고 세부사항을 제어한다. 소결방법에 따라 상압소결(소결 분위기가 일반 대기 분위기), 가압소결(성형체 또는 1차 소결체에 압력을 가해주는 공정으로 형체에 압력을 가해주면서 소결하는 Hot Pressing 또는 1차 소결체에 압력을 가하면서 소결하는 Hot Isostatic Pressing 공법), 분위기 소결(소결 분위기가 일반 대기가 아닌 특정 가스 분위기), 진공 소결(진공 펌프를 이용하여 소결로의 분위기를 진공 상태로 함) 공정의 작업을 수행한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"위험내재|고온|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8269","dJobECdNm":"[8269]기타 비금속제품 생산기계 조작원","dJobJCd":"8439","dJobJCdNm":"[8439]기타 비금속제품 관련 생산기 조작원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004167:1', '{"dJobCd":"K000004167","dJobCdSeq":"1","dJobNm":"바이오세라믹재료탈지원","workSum":"생체세라믹 재료의 제품 형상을 제조하기 위해 분말과 성형물에 존재하는 바인더를 제거하는 공정작업을 수행한다.","doWork":"성형체에 존재하는 고분자 바인더 물질을 용매를 사용하여 제거하는 용매추출(Solvent Extraction) 공정작업을 수행한다. 원료분말 및 바인더(Binder:세라믹분말을 성형할 때 성형 및 결합성을 좋게 하기 위하여 세라믹 분말에 첨가된 폴리에틸렌글리콜, 폴리비닐아세테이트, 폴리에틸렌, 폴리프로필렌, 에틸렌비닐아세테이트, 왁스, 스테아린산 등의 고분자재료)의 종류에 따라 대기탈지, 진공탈지 및 분위기탈지 공정작업을 수행한다. 하소공정(고온으로 가열하여 휘발성분의 일부 또는 전부를 제거하는 공정)의 작업을 수행한다. 탈지율을 계산하고 품질을 평가한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"위험내재|고온|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8269","dJobECdNm":"[8269]기타 비금속제품 생산기계 조작원","dJobJCd":"8439","dJobJCdNm":"[8439]기타 비금속제품 관련 생산기 조작원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001685:1', '{"dJobCd":"K000001685","dJobCdSeq":"1","dJobNm":"바이오세라믹재료포장원","workSum":"생체재료를 제시된 유효기간 내에 안전하게 보존하기 위한 세척, 포장, 라벨링, 멸균, 클린룸 관리 업무를 수행한다.","doWork":"생체재료의 종류에 따라 세척방법을 확인한다. 세척제의 종류, 양, 비율, 세척시간을 결정하고 초음파세척기, 건조기 등 세척장비를 사용하여 제조공정 과정에서 발생하는 기름때, 오물, 먼지 등을 정제수, 에탄올, 세정제, 압축 공기 등을 사용하여 제거한다. 생체재료 및 멸균공정의 종류에 따라 포장장비를 사용하여 포장한다. 라벨장비를 사용하여 라벨링한다. 재료, 포장방법, 멸균방식, 유효기간, 멸균시간을 확인하고 멸균장비(열, 방사선, 가스, 화학약품 등)를 사용하여 멸균처리를 한다. 멸균성적서를 작성한다. 공정작업이 이루어지는 클린룸을 관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8269","dJobECdNm":"[8269]기타 비금속제품 생산기계 조작원","dJobJCd":"8439","dJobJCdNm":"[8439]기타 비금속제품 관련 생산기 조작원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003637:1', '{"dJobCd":"K000003637","dJobCdSeq":"1","dJobNm":"바이오세라믹재료합성원","workSum":"생체재료의 적절한 제조를 위해 필요한 원료분말을 선정 또는 합성하고, 분말특성 확인, 분쇄, 과립화 및 혼합·안료배합을 한다.","doWork":"제품 생산에 필요한 원료(지르코니아, 알루미나, 용매 등)의 적합 유무를 확인한다. 원료 성적서를 확인한다. 증류수, pH 완충액, 염산, 수산화나트륨, 미생물시험배지, 메탄올, 표준용액 등을 사용하여 선별된 분말의 분말특성을 확인한다. 특별한 경우에는 특정 특성을 나타내는 원료를 합성하여 사용한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"8269","dJobECdNm":"[8269]기타 비금속제품 생산기계 조작원","dJobJCd":"8439","dJobJCdNm":"[8439]기타 비금속제품 관련 생산기 조작원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003137:1', '{"dJobCd":"K000003137","dJobCdSeq":"1","dJobNm":"암면성형원","workSum":"원단을 이용하여 산업용 배관 단열재로 쓰이는 암면(岩綿)제품을 만든다.","doWork":"암면(岩綿) 원단을 성형기 한쪽에 적재해 둔다. 제품규격에 따라 배관용 파이프규격에 맞는 철형봉(쇠막대기)을 성형기에 걸고 형판 위에 포장지를 펼친다. 성형기의 성형판포장지 위에 암면 원단을 골고루 편다. 원단 조각을 이용하여 암면이 일정한 두께로 펼쳐지도록 한다. 성형판 위에 암면 원단을 일정 두께로 펼친 후, 2인 1조가 되어 양쪽에서 성형기 레버를 올리면 암면 원단이 철형봉에 말리면서 압력과 열이 가해져 성형되도록 한다. 성형된 암면을 철형봉에서 분리하고 대차에 적재한 후 건조실로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8269","dJobECdNm":"[8269]기타 비금속제품 생산기계 조작원","dJobJCd":"8439","dJobJCdNm":"[8439]기타 비금속제품 관련 생산기 조작원","dJobICd":"C239","dJobICdNm":"[C239]기타 비금속 광물제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004280:1', '{"dJobCd":"K000004280","dJobCdSeq":"1","dJobNm":"연마제배합원","workSum":"연마제를 배합하기 위하여 용융 알루미나, 탄화규소 등의 주원료와 장석, 규석, 백토 등의 부원료를 배합하는 장치를 조작한다.","doWork":"작업지시서에 따라 원료(용융알루미나, 합성수지, 탄화규소, 인조다이아몬드, 입방정질화붕소, CBN 등)와 부원료(장석, 규석, 백토, 규사 등)의 규격, 수량을 확인한다. 호이스트나 지게차를 사용하여 작업장으로 운반한다. 작업표준서에 따라 저울을 사용하여 원료 및 부원료의 양을 계량하고 배합비에 따라 혼합기에 투입한다. 혼합기 상단의 교반축을 혼합기 내부로 내린 후 혼합기의 조정판에 조건을 입력한다. 혼합기를 가동하고 혼합상태를 유리창을 통하여 관찰한다. 혼합이 완료되면 혼합상태를 검사한 후 혼합기 하단의 배출밸브에 호스를 연결하여 혼합물을 대차에 담는다. 대차를 진동기로 이동시킨 후 호이스트 또는 리프트를 사용하여 진동기에 투입한다. 진동기를 가동시켜 큰 입자를 분리한다. 분리가 완료된 후 견본을 채취하여 품질검사부로 보내고 나머지는 대차에 담아 숙성실로 운반·보관한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"알루미나연마제배합원, 탄화규소연마제배합원","dJobECd":"8269","dJobECdNm":"[8269]기타 비금속제품 생산기계 조작원","dJobJCd":"8439","dJobJCdNm":"[8439]기타 비금속제품 관련 생산기 조작원","dJobICd":"C239","dJobICdNm":"[C239]기타 비금속 광물제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006714:1', '{"dJobCd":"K000006714","dJobCdSeq":"1","dJobNm":"유약배합원","workSum":"유약을 제조하기 위하여 장석, 규석, 석회석 등에 색상을 내주는 각종 발색제와 첨가제(유약의 표면 상태나 투명도를 조절하기 위해 사용)를 배합·용융·건조하는 장치를 조작·관리한다.","doWork":"일일작업량을 파악해 저장고의 원료(장석, 규석, 석회석, 발색제, 각종 첨가제 등) 재고를 확인한다. 비어 있는 대차의 무게를 레일 위에서 영점을 맞춘다. 작업표준서에 명시된 순서대로 대차를 저장고 아래로 움직인다. 명시된 배합비에 따라 각 저장고에서 원료를 대차에 담는다. 계기판에 표시된 중량게이지를 수시로 확인하여 원료를 정확히 배합한다. 대차에 원료를 충진한 후 호퍼(Hopper:분립체의 저장 및 공급장치)에 대차를 위치시키고 원료를 호퍼에 담는다. 호퍼를 호이스트 고리에 걸고 배합기로 운반한다. 배합기에 호퍼를 밀어 넣고 배합기를 가동한다. 배합이 완료된 후 견본을 채취하여 배합상태를 검사한다. 배합상태가 양호하면 호퍼를 빼내고 호이스트의 고리를 연결하여 용융로로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|다습|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"유약혼합기조작원","dJobECd":"8269","dJobECdNm":"[8269]기타 비금속제품 생산기계 조작원","dJobJCd":"8439","dJobJCdNm":"[8439]기타 비금속제품 관련 생산기 조작원","dJobICd":"C204","dJobICdNm":"[C204]기타 화학제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005306:1', '{"dJobCd":"K000005306","dJobCdSeq":"1","dJobNm":"유약용융원","workSum":"발색제와 첨가제 등이 배합된 유약 원료를 용융·건조하기 위해 용융로, 냉각수, 건조기 등을 조작·관리한다.","doWork":"가스버너를 작동시켜 용융로 내부의 온도가 일정 온도 이상이 되도록 가열한다. 배합공정에서 발색제와 첨가제 등이 혼합된 유약 원료를 용융로의 원료 투입구에 투입한다. 용융로의 용융조건(온도, 스크루 속도 등)을 입력하고 작동한다. 용융로 배출구에 물을 흐르게 하기 위하여 급수밸브를 연다. 용융된 유약 반제품의 냉각 여부를 확인하고 급수호스의 위치와 급수량을 조절한다. 대차를 준비하여 급랭된 유약이 담겨지도록 하고 유약의 물기를 제거하기 위하여 대차 하단에 있는 밸브를 열고 물을 제거한다. 대차를 호이스트에 걸어 열풍건조기로 이송하고 건조기에 밀어 넣어 건조한다. 급랭된 유약이 너무 크거나 불규칙할 경우 볼밀을 사용하여 입자크기를 맞춘다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|다습|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8269","dJobECdNm":"[8269]기타 비금속제품 생산기계 조작원","dJobJCd":"8439","dJobJCdNm":"[8439]기타 비금속제품 관련 생산기 조작원","dJobICd":"C204","dJobICdNm":"[C204]기타 화학제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001933:1', '{"dJobCd":"K000001933","dJobCdSeq":"1","dJobNm":"유약제조원","workSum":"시유할 제품의 특성과 조성에 알맞은 유약을 제조하기 위하여 유약의 성분조성을 계산하고 제품에 적합한 색상을 맞춘다.","doWork":"유약제조를 위하여 유약에 관한 재료와 원료를 수집하고 분석하여 유약성분표를 작성하며 작업표준을 만든다. 작업표준서에 따라 도기에 쓰이는 납유약과 같은 연질유와 경질류를 구분하여 불투명류에 첨가하는 첨가원료(석회석, 백운석, 활석, 바륨, 아비산, 안티몬, 티탄, 주석, 아연, 골회 등)와 참나무재, 와목, 소나무재 등 색유의 원료를 개발하고 준비한다. 작업에 필요한 전자계량기, 혼련기(혼합기의 일종)를 준비한다. 시유할 제품에 요구되는 특성에 따라 원료를 선정하고 유약의 성분조성을 계산한다. 유약원료의 배합비에 따라 유약을 배합·혼합하여 시편에 도포한다. 시유한 시편을 소성하여 유약의 융착상태와 색상·광택 등을 검사한다. 생산된 유약을 시편에 시유하여 품질규격과 일치하는지 확인한다. 완성된 유약의 종류와 구성비 등을 기록하여 보관하여 유약개발의 자료로 활용한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"유약제조기조작원","connectJob":"유약분쇄기조작원","dJobECd":"8269","dJobECdNm":"[8269]기타 비금속제품 생산기계 조작원","dJobJCd":"8439","dJobJCdNm":"[8439]기타 비금속제품 관련 생산기 조작원","dJobICd":"C204","dJobICdNm":"[C204]기타 화학제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004187:1', '{"dJobCd":"K000004187","dJobCdSeq":"1","dJobNm":"전자세라믹원료합성원","workSum":"용도별 세라믹 분말의 크기를 제어하고 원하는 조성에 맞게 합성하기 위해 혼합·분산, 분쇄, 건조, 하소작업을 수행한다.","doWork":"요구되는 전자기 특성(유전체, 압전체, 자성체 등 전자세라믹의 특성을 구현하는 나노 분말, 마이크로 분말 등)에 따라 혼합분산 작업표준을 작성한다. 혼합·분산(세라믹의 균일화, 균질화를 위해 성질이 다른 2종 이상의 세라믹원료나 원료와 용매를 균일하게 섞는 공정)작업을 수행한다. 분쇄설비를 사용하여 분쇄작업을 수행한다. 건조작업표준에 따라 건조작업을 수행한다. 하소작업(瑕燒:세라믹재료를 고온으로 가열하여 휘발성분의 일부 또는 전부를 제거하고 원하는 결정상 형성을 위한 열처리 작업)을 수행한다. 하소한 원료를 분쇄설비를 사용하여 분쇄작업을 수행한다. 분쇄 후 건조작업표준에 따라 건조작업을 수행한다. 합성한 분말을 기밀 포장하고 높은 습도에 노출되지 않도록 유지 관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8269","dJobECdNm":"[8269]기타 비금속제품 생산기계 조작원","dJobJCd":"8439","dJobJCdNm":"[8439]기타 비금속제품 관련 생산기 조작원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006190:1', '{"dJobCd":"K000006190","dJobCdSeq":"1","dJobNm":"전자세라믹재료성형원","workSum":"분말, 벌크, 후막, 박막 등의 전기전자 부품형상을 구현하기 위해 성형작업을 수행하고 성형체를 검사한다.","doWork":"요구되는 제품의 형상에 따라 건식성형, 후막성형, 박막성형 작업표준을 작성한다. 건식성형(건식성형기로 분말을 프레스 금형에 넣고 고압을 가하여 성형), 후막성형(후막성형기를 이용하여 세라믹 슬러리를 미세한 크기의 균일한 막 상태로 모양을 형성), 박막성형(박막성형기를 이용하여 세라믹 재료를 1um 미만의 균일한 막 상태로 모양을 형성) 작업을 수행한다. 성형검사기 또는 성형검사 설비를 운영하여 성형체를 검사한다. 검사성적서를 작성한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"위험내재|고온|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8269","dJobECdNm":"[8269]기타 비금속제품 생산기계 조작원","dJobJCd":"8439","dJobJCdNm":"[8439]기타 비금속제품 관련 생산기 조작원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001550:1', '{"dJobCd":"K000001550","dJobCdSeq":"1","dJobNm":"전자세라믹재료소결원","workSum":"세라믹 소재에 전기전자 소재의 특성을 구현하기 위해 소결, 재열처리 작업을 수행한다.","doWork":"작업표준에 따라 소결로, 온도표준표, 소성로, 측정기구, 온도측정표준시편, 온도측정설비, 내화판을 준비한다. 고온소결, 분위기소결(소결과정에서 산소, 질소, 아르곤 등을 이용하여 분위기를 형성하여 소결하는 것), 가압소결(열과 압력을 동시에 가하면서 소결하는 것), 재열처리 공정의 작업을 수행한다. 결정구조 분석, 두께 측정, 소결체 미세구조 평가를 한다. 소결장비의 안전관리 업무를 수행한다. 소결작업 결과를 분석하여 보고서를 작성한다. 소결공정제품의 양부를 판단한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"위험내재|고온|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8269","dJobECdNm":"[8269]기타 비금속제품 생산기계 조작원","dJobJCd":"8439","dJobJCdNm":"[8439]기타 비금속제품 관련 생산기 조작원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002504:1', '{"dJobCd":"K000002504","dJobCdSeq":"1","dJobNm":"전자세라믹재료후가공원","workSum":"세라믹 소재에 전기전자 특성을 구현하기 위하여 후처리작업을 수행한다.","doWork":"가공작업 표준에 따라 세라믹소성체, 세정액, 전극재료, 코팅재료, 분위기 형성 가스(산소, 질소, 아르곤 등)를 준비한다. 세정설비, 코팅설비, 현미경, 전기로, 스크린프린터, 기타 가공설비 등을 점검한다. 세정설비로 세라믹 소결체에 부착된 이물질을 기계적, 화학적 방법으로 제거한다. 코팅설비로 세라믹 소결체에 금속 또는 고분자 막을 형성한다. 전극형성장비로 세라믹 소결체에 금속막을 형성하고 전극의 기능을 주기 위하여 열처리한다. 가공, 세정, 코팅한 재료를 열처리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"위험내재|고온|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8269","dJobECdNm":"[8269]기타 비금속제품 생산기계 조작원","dJobJCd":"8439","dJobJCdNm":"[8439]기타 비금속제품 관련 생산기 조작원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004240:1', '{"dJobCd":"K000004240","dJobCdSeq":"1","dJobNm":"가우징기조작원","workSum":"가공된 금속물을 깎아 표면을 매끄럽게 가공하는 가우징(Gouging)기를 조작한다.","doWork":"가공하고자 하는 금속제품을 작업 중 흔들리지 않게 가우징기 정반에 안착한다. 가우징 지지대에 가우징 봉을 끼운다. 공기밸브를 조절하며 전원스위치를 동작한다. 금속표면의 결함부위에 가우징 봉을 대고 전류와 공기로 깎아내고 불어내어 표면을 매끄럽게 한다. 가우징 작업을 한 후 균열, 모래집 등이 있는지 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8132","dJobECdNm":"[8132]금속 공작기계 조작원","dJobJCd":"8510","dJobJCdNm":"[8510]금속 공작 기계 조작원","dJobICd":"C243/C259","dJobICdNm":"[C243]금속 주조업 / [C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001693:1', '{"dJobCd":"K000001693","dJobCdSeq":"1","dJobNm":"고압용기프레스기조작원","workSum":"고압가스용기의 제조를 위해 탄소강, 크롬강, 주철 등의 강판 및 경판을 미리 설치된 금형을 이용해 전단·봉합·성형한다.","doWork":"작업지시서에 따른 작업내용을 확인한다. 작업명세서상의 재료가 일치하는지 확인한다. 작업지시서에 따라 작업공정방법을 선택한다. 탄소강, 크롬강, 몰리브덴강 등의 특수고강도강을 사용하여 제조할 고압용기에 맞는 적절한 공법을 채택한다. 입고된 강철판을 확인한 후 고압프레스기에 올려놓는다. 전단할 규격을 디지털계측기에 입력하고 가동스위치를 작동한다. 강판이 계산대로 전단되는지 육안으로 확인한다. 절단된 제품에 다른 부분품과 함께 블랭킹 작업을 한다. 절단된 절판을 고압성형프레스기로 반구형 경판을 제작한다. 반구형 경판의 밑 부분을 원주형으로 가공한다. 완성된 제품이 명세서의 규격과 일치하는지 확인한다. 다음 공정작업을 위하여 완성제품을 호이스트로 이동한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"컴퓨터응용가공산업기사","dJobECd":"8132","dJobECdNm":"[8132]금속 공작기계 조작원","dJobJCd":"8510","dJobJCdNm":"[8510]금속 공작 기계 조작원","dJobICd":"C251","dJobICdNm":"[C251]구조용 금속제품, 탱크 및 증기발생기 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002748:1', '{"dJobCd":"K000002748","dJobCdSeq":"1","dJobNm":"공작기계반장","workSum":"공작기계를 사용하여 금속공작물을 가공하는데 종사하는 작업원들의 활동을 감독·조정한다.","doWork":"생산할 제품의 종류와 형상에 따라 작업방법 및 작업절차를 계획·조정한다. 기계를 조작하는 절차와 방법을 작업원에게 지시하고 함께 작업하며 작업상황을 확인한다. 기계의 기능장애 시 시정을 지시하고 정비내용을 점검·확인한다. 공작물이 명세서와 일치하는지 비교·확인한다. 생산품의 품목 및 생산량 등 작업내용을 작업일지에 기록한다. 작업원에게 직무교육 및 안전위생교육을 통하여 직무수행기술을 향상시키고 안전재해를 예방한다. 작업원의 수시관찰과 면담을 통하여 애로 및 건의사항을 수렴·해결하고 문제점을 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","certLic":"기계가공조립기능사, 컴퓨터응용가공기능사, 컴퓨터응용가공산업기사","dJobECd":"8132","dJobECdNm":"[8132]금속 공작기계 조작원","dJobJCd":"8510","dJobJCdNm":"[8510]금속 공작 기계 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003923:1', '{"dJobCd":"K000003923","dJobCdSeq":"1","dJobNm":"관절단기조작원","workSum":"명세된 규격에 따라 비철금속관 및 강관을 자르는 절단기를 조작한다.","doWork":"부재의 규격 및 기장을 확인하고 이송 중 손상 여부를 육안으로 확인한다. 절단할 제품의 종류나 재질에 따라 절단속도를 조정한다. 자·조립게이지·형판 등을 사용하여 절단 길이대로 절단선을 표시한다. 부재를 컨베이어에 올려놓고, 광센서로 톱날과 절단선이 일치하도록 컨베이어를 조작한다. 바이스와 같은 공구로 절단할 부재를 고정시키고, 스위치를 조작하여 절단날을 작동한다. 절단방법과 순서에 따라 소재를 명세된 길이로 절단한다. 균열·흠 등의 결함부분을 절단·제거한다. 치수를 확인하기 위해 게이지·형판·자 등의 측정기구를 사용하여 측정한다. 작업일지에 일일생산량을 기록한다. 절단기의 간단한 수리·점검을 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"CNC절단기조작원","certLic":"판금제관기능사, 판금제관산업기사, 판금제관기능장","dJobECd":"8132","dJobECdNm":"[8132]금속 공작기계 조작원","dJobJCd":"8510","dJobJCdNm":"[8510]금속 공작 기계 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005458:1', '{"dJobCd":"K000005458","dJobCdSeq":"1","dJobNm":"관천공원","workSum":"압출에 의하여 이음매가 없는 관을 생산하기 위하여 금속소재에 구멍을 뚫는 기계를 조작한다.","doWork":"작업명세서를 확인하고 천공할 구멍의 구경, 소재의 재질 등을 파악한다. 소재를 운반하고 관을 천공하기 위한 천공기 및 관련 설비를 점검한다. 소재를 작업대 위에 올려놓고 절삭유의 양 및 압력, 가공속도 등을 조정한다. 천공기에 소재를 고정시키고 기기를 작동시켜 강의 종류 및 천공 깊이에 따른 회전수와 이송량을 조정한다. 천공이 완료되면 금속소재를 이탈시켜 편심량, 내면의 절삭상태를 확인한다. 금속소재의 내부에 잔유하는 절삭유를 제거하고 관의 길이, 천공 크기, 수량 등을 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8132","dJobECdNm":"[8132]금속 공작기계 조작원","dJobJCd":"8510","dJobJCdNm":"[8510]금속 공작 기계 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006065:1', '{"dJobCd":"K000006065","dJobCdSeq":"1","dJobNm":"그라인딩기조작원","workSum":"연속주조기에서 생산된 제품의 흠집 등을 그라인딩기를 조작하여 교정한다.","doWork":"작업지시서의 작업내용을 파악한다. 그라인딩 설비를 점검하고 그리스와 오일을 주입 및 보충하고 작업표준 및 작업내용에 따라 그라인딩휠(Grinding-wheel)을 교체한다. 기중기로 작업대에 제품을 올리고 흠집 등을 그라인딩기로 연마하여 교정하고 교정부위의 상태를 확인한다. 작업이 완료되면 기중기로 제품을 적재장소로 이송한다. 주변을 청소한 뒤 작업내용을 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"연마기조작원, 연마원","dJobECd":"8132","dJobECdNm":"[8132]금속 공작기계 조작원","dJobJCd":"8510","dJobJCdNm":"[8510]금속 공작 기계 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001436:1', '{"dJobCd":"K000001436","dJobCdSeq":"1","dJobNm":"극인연마원","workSum":"가공된 금속재를 압인에 적합한 최종치수로 맞추기 위하여 목부, 몸통, 저면 등을 수동 및 자동연마기로 정밀하게 연마한다.","doWork":"작업계획을 수립한다. 연마기의 상태를 점검한다. 저면 및 기준면을 평면연마기로 연마한다. 연마석, 샌드페이퍼를 사용하여 몸통, 내경, 외경, 인면의 흠을 제거한다. 극인의 정확성을 검사한다. 벨트연마기, 래핑연마기로 광택연마를 한다. 초음파세정기로 극인을 세정한다. 버핑기에 방청유와 산화크롬 연마제를 도포한다. 인면을 브러싱한다. 인면의 색상(명도)을 검사한 후 정밀조정 한다. 전면에 테이프를 부착하고 도안을 현미경으로 확인하여 수술용 메스로 무광처리 부분을 제거하는 무광작업을 한다. 샌드브라스팅기로 테이프를 제거한 후 알코올, 니그로인으로 세척하고 제품을 출하한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8132","dJobECdNm":"[8132]금속 공작기계 조작원","dJobJCd":"8510","dJobJCdNm":"[8510]금속 공작 기계 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007277:1', '{"dJobCd":"K000007277","dJobCdSeq":"1","dJobNm":"금속전단반장","workSum":"제품의 규격에 따라 금속재료를 일정한 길이나 폭으로 절단하는데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"제품의 종류와 형상에 따라 금속을 분리하는 일련의 작업공정(Shearing)인 절단, 절곡, 커팅 등의 절단 방법 및 절차를 계획·조정한다. 기계를 조작하는 절차와 방법을 작업원에게 지시하고 함께 작업하며 작업상황을 확인한다. 기계의 기능장애 시 시정지시를 하고 정비내용을 점검·확인한다. 절단된 제품이 명세서, 도면과 일치하는지 비교·확인한다. 생산품의 품목 및 생산량 등 작업내용을 작업일지에 기록한다. 작업원에게 직무교육 및 안전위생교육을 통하여 직무수행기술을 향상시키고 안전재해를 예방한다. 작업원의 수시관찰과 면담을 통하여 애로 및 건의사항을 수렴·해결하고 문제점을 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","similarNm":"금속샤링반장","dJobECd":"8132","dJobECdNm":"[8132]금속 공작기계 조작원","dJobJCd":"8510","dJobJCdNm":"[8510]금속 공작 기계 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007225:1', '{"dJobCd":"K000007225","dJobCdSeq":"1","dJobNm":"금속제품연마원","workSum":"금속제품 표면을 매끄럽게 연마한다.","doWork":"연마시킬 제품의 종류·크기·형태 등에 따라 연마방법을 선택한다. 연마재(마포·연마포지·연마숫돌 등)를 연마기에 장치한다. 연마기를 가동시키고 연마시킬 제품면을 접촉시켜 표면의 얼룩, 부스러기, 돌출부분, 녹, 찌꺼기 등을 제거하여 매끄럽게 한다. 표면을 만져보거나 육안으로 관찰하여 연마상태를 검사한다. 연마된 제품에 녹을 방지하기 위하여 고주파강화처리, 코팅처리, 불소수지처리 등의 후처리작업을 하기도 한다. 품질검사 후 출하한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"광택원","dJobECd":"8132","dJobECdNm":"[8132]금속 공작기계 조작원","dJobJCd":"8510","dJobJCdNm":"[8510]금속 공작 기계 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001633:1', '{"dJobCd":"K000001633","dJobCdSeq":"1","dJobNm":"기계가공반장","workSum":"금속기계제조공장의 공정흐름, 다양한 공작기계 설치와 조작기술, 금속 및 비금속의 기계가공작업에 관한 지식을 바탕으로 기계, 주형, 장비의 부품을 생산·관리한다.","doWork":"주문서에 따라 작업지시서를 만든다. 납기일에 따라 일일생산량계획을 수립한다. 작업에 필요한 각종 공구와 기계 등을 점검하고 확인한다. 작업공정방법과 순서를 정하여, 작업원을 배치하고 지시한다. 작업공정을 순회하고 공정별 기술적인 지도를 한다. 완성된 제품의 규격이 작업명세서와 일치하는지를 확인·검사한다. 불량품에 대해서는 재가공 및 수정을 지시한다. 작업장의 안전과 작업원의 위생 등을 관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","certLic":"컴퓨터응용가공산업기사","dJobECd":"8132","dJobECdNm":"[8132]금속 공작기계 조작원","dJobJCd":"8510","dJobJCdNm":"[8510]금속 공작 기계 조작원","dJobICd":"C291","dJobICdNm":"[C291]일반 목적용 기계 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007282:1', '{"dJobCd":"K000007282","dJobCdSeq":"1","dJobNm":"기계프레스조작원","workSum":"금속강판 등 원재료를 전단, 펀칭, 눈금을 새기고, 인발하거나 다이에 소재를 고정하여 요구하는 모양으로 제작하는 기계프레스와 그 보조설비를 조작한다.","doWork":"작업명세서에 따라 가공할 제품을 확인한다. 가공할 제품의 종류와 형태에 따라 프레스장비를 조정한다. 수동공구를 사용하여 작업지시서에 따라 기계에 금형을 조립·설치·정돈한다. 공작물을 다이에 고정한다. 다이 위의 고정구에 금속공작물을 놓고 기계를 시동한다. 공작물을 블랭킹, 피어싱, 트리밍, 노칭, 슬로핑, 슬리팅, 세퍼레이팅, 퍼포레이팅, 셰이빙, 컬링, 시밍 등의 가공을 한다. 완성 제품을 마이크로미터 등의 수동게이지나 육안으로 공작물이 명세서와 일치하는지 검사하고 잘못된 부분을 조정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"프레스금형산업기사","dJobECd":"8132","dJobECdNm":"[8132]금속 공작기계 조작원","dJobJCd":"8510","dJobJCdNm":"[8510]금속 공작 기계 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007250:1', '{"dJobCd":"K000007250","dJobCdSeq":"1","dJobNm":"기어그라인딩기조작원","workSum":"작업지시서 및 도면에 따라 기어이나 스플라인을 연마하기 위한 기어그라인딩기계를 조작한다.","doWork":"작업지시서나 도면에 따라 공작물의 치수와 수량을 육안 또는 측정기기를 사용하여 확인한다. 기어의 오차범위, 기기정수, 빗각을 계산하여 제어판에 입력한다. 프로그램 테이프를 입력하기도 한다. 냉각장치, 회전숫돌을 점검하고 작업물을 고정구에 고정한다. 조정레버를 움직이거나 자동프로그램으로 이송률, 공작물 회전속도를 조절한다. 공작물의 가공상태, 장치의 작동을 점검한다. 작업 중 문제가 발생하면 기기를 중지시키고 작업반장에게 보고한다. 초도작업물에 이상이 없으면 프로그램 및 수치를 고정하고 연속해서 작업한다. 작업결과물의 수치, 상태를 측정기기로 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"기어연삭기조작원","connectJob":"수치제어웜스래드그라인딩기조작원, 웜그라인딩기조작원","dJobECd":"8132","dJobECdNm":"[8132]금속 공작기계 조작원","dJobJCd":"8510","dJobJCdNm":"[8510]금속 공작 기계 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003818:1', '{"dJobCd":"K000003818","dJobCdSeq":"1","dJobNm":"단조프레스가공원","workSum":"설계·제작된 금형에 금속재료를 넣어 원하는 금속공작물로 성형하는 단조프레스기를 조작한다.","doWork":"작업지시서나 작업표준서, 도면 등을 이해하고 그에 따른 금형을 선택하고 고정한다. 금형의 고정상태, 안전장치, 윤활상태 등을 점검한다. 금형 사이의 불순물을 제거하고, 소재를 금형 위에 올리고 단조프레스를 조작하여 성형한다. 프레스의 상하운동 사이에 손이나 기타 이물질이 끼어들지 않도록 주의한다. 검사게이지나 버니어캘리퍼스를 사용하여 초도물품의 오차한계를 측정하고, 규격이 도면과 일치하면 연속작업을 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8132","dJobECdNm":"[8132]금속 공작기계 조작원","dJobJCd":"8510","dJobJCdNm":"[8510]금속 공작 기계 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005094:1', '{"dJobCd":"K000005094","dJobCdSeq":"1","dJobNm":"드릴링기조작원","workSum":"금속공작물에 천공, 확공, 암나사 내기 작업 등의 구멍가공 작업을 하기 위하여 드릴링기를 조작한다.","doWork":"작업지시서 및 도면에 따라 가공물품을 확인한 후 절삭공구, 고정구, 수동공구 등을 준비한다. 가공여유를 결정하고 드릴의 크기를 측정한 후 분포도를 작성한다. 작성된 분포도를 원자재의 외경에 감은 후 못과 망치로 표시한다. 가공품을 탁상드릴의 테이블 위에 고정한다. 작동스위치를 작동시키며 초품검사 후 본가공을 실시한다. 수동공구를 사용하여 스핀들에 절삭공구를 고정시키고 가공할 구멍의 위치, 치수, 이송률, 절삭속도 등을 결정한다. 공작물을 지그 또는 고정구에 고정한다. 조정기를 움직여 절단속도·이송률·절삭깊이 등을 조절한다. 이송레버를 작동시켜 절삭공구를 공작물의 가공부위로 이송한다. 기계를 작동시키고 밸브 손잡이를 돌려 공작물의 가공상태를 관찰하고 냉각제와 절삭유의 흐름을 점검한다. 마이크로미터·고정게이지·캘리퍼스 등의 측정공구를 사용하여 도면과 가공치수의 일치도를 확인한다. 드릴의 마모상태를 수시로 확인하면서 드릴의 이상 유무를 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"다축드릴링기조작원, 단축드릴링기조작원, 탁상드릴링기조작원, 리밍원, 테이퍼원","certLic":"컴퓨터응용가공산업기사","dJobECd":"8132","dJobECdNm":"[8132]금속 공작기계 조작원","dJobJCd":"8510","dJobJCdNm":"[8510]금속 공작 기계 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003086:1', '{"dJobCd":"K000003086","dJobCdSeq":"1","dJobNm":"래핑기조작원","workSum":"평평하면서 원통형인 부품, 구형의 부품, 서로 접하는 기계부품 등의 금속공작물을 연마하기 위하여 래핑(Lapping)기계를 조작한다.","doWork":"작업지시서와 도면에 따라 작업절차와 가공치수를 확인한다. 렌치를 사용하여 축에 회전 연마반을 장치한다. 고정구나 기계작업대에 공작물을 놓고 고정한다. 조정기를 움직여 연마속도·공구압력·연마시간·공작물에 대한 연마반의 연마상태 등을 조절한다. 기계를 작동시키고 연마반과 공작물에 연마제(Lapping Compound)를 뿌린다. 공작물의 가공상태를 관찰하고 비교측정기·평면게이지·정반 등의 측정도구를 사용하여 도면과 가공치수의 일치도를 확인한다. 연마제·연마바퀴가 부착된 래핑기계를 조작하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8132","dJobECdNm":"[8132]금속 공작기계 조작원","dJobJCd":"8510","dJobJCdNm":"[8510]금속 공작 기계 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006800:1', '{"dJobCd":"K000006800","dJobCdSeq":"1","dJobNm":"롤러연마원","workSum":"정방기, 조방기, 연사기, 정소면기, 혼타면기 등에 쓰이는 각종 롤러를 연마한다.","doWork":"연마석이나 연마용 사포의 이상 유무를 점검한다. 고무씌우개(Cot)의 직경을 명시된 크기로 줄이기 위하여 기계를 조절하는 조절나사를 돌린다. 기계를 시동하고 연삭숫돌에 맞대어 연마한다. 연마된 롤러를 캘리퍼스로 측정하고 기준과 비교한다. 고무씌우개의 굵기가 점점 가늘어지지 않았는지 확인하기 위하여 다이얼게이지로 확인한다. 고무씌우개의 경도 및 표면에 미끄럼을 주기 위하여 황산처리 후 물로 세척하여 말리고 기계에 끼운다. 작업수량 및 연마규격 등을 작업일지에 기재·보관한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8132","dJobECdNm":"[8132]금속 공작기계 조작원","dJobJCd":"8510","dJobJCdNm":"[8510]금속 공작 기계 조작원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005752:1', '{"dJobCd":"K000005752","dJobCdSeq":"1","dJobNm":"머시닝센터조작원","workSum":"밀링·엔드밀링·드릴링·리밍·래핑·보링 등 여러 종류의 절삭가공을 자동공구교환장치에 의해 자동으로 가공하는 머시닝센터를 조작한다.","doWork":"도면을 숙지하고 가공조건을 설정한다. 프로그램을 작성하여 입력한다. 지그(Jig)를 세팅하고 입력내용을 확인한다. 공구대에 공구를 장착한다. 기계를 시운전하고 급유한다. 지그에 공작물을 고정시켜 시험 운전한 후 마이크로미터 게이지 등 측정공구를 사용하여 치수를 확인한다. 프로그램, 공구세팅, 지그세팅 상태를 수정·확인한다. 시험운전에 이상이 없으면 기계를 자동으로 전환하고 연속작업 한다. 수시로 가공물을 측정하고 기계를 청소하고 공구 및 측정기를 정리정돈한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"MCT조작원, 머시닝가공원, MCT기능원, MCT운영자","connectJob":"지그마스타조작원, CT(머시닝센터)프로그래머","certLic":"컴퓨터응용가공산업기사","dJobECd":"8132","dJobECdNm":"[8132]금속 공작기계 조작원","dJobJCd":"8510","dJobJCdNm":"[8510]금속 공작 기계 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004341:1', '{"dJobCd":"K000004341","dJobCdSeq":"1","dJobNm":"메달제조원","workSum":"금, 은, 동 등의 재료로 메달이나 금속공예품과 같은 특수제품을 제조한다.","doWork":"작업공구 및 기계를 점검하고 당일 작업분의 공표(주화를 제외한 메달 등의 제조용 소재)와 작업내용이 기록된 전표를 인수한다. 압인기에 음각금형을 거치한다. 공표에 기계적인 힘을 가하여 문양을 새긴다. 압인력에 의하여 변형된 제품을 단능기를 이용하여 정해진 규격으로 선삭 가공한다. 날카롭게 된 제품의 가장자리를 연마기를 이용하여 연마한다. 제품을 견본품과 대조·확인하여 불량품을 선별한다. 수정이 가능한 경우 해당 부위를 수정하고 수정이 불가능한 경우 전표와 함께 반납한다. 메달의 표면에 착색이 잘 이루어지도록 연마분발을 일정한 공기압력으로 메달 표면에 분사시켜 제품의 면을 미세하게 다듬어준다. 음영효과를 내기 위해 착색제를 물이나 증기를 이용하여 메달표면에 착색하고 연마분말, 연마포, 솔 등으로 착색된 제품을 균일하게 닦아낸다. 수요처에서 요구하는 정도의 색상을 메달에 조색한다. 제품의 변색방지 및 취급상의 편의를 위해 표면과 테두리에 래커를 도장하고 건조한다. 작업일지를 작성하고 사용장비를 점검한 후 작업을 마무리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|다습|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8132","dJobECdNm":"[8132]금속 공작기계 조작원","dJobJCd":"8510","dJobJCdNm":"[8510]금속 공작 기계 조작원","dJobICd":"C331","dJobICdNm":"[C331]귀금속 및 장신용품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001823:1', '{"dJobCd":"K000001823","dJobCdSeq":"1","dJobNm":"면삭원","workSum":"금속재의 슬래브 표면에 발생한 표면결함(스케일, 산화피막, 기공의 불순물, 요철)을 제거하기 위하여 스카퍼(Scarfer)를 사용하여 표면을 절삭한다.","doWork":"작업지시서에 따라 철, 합급강, 스테인리스강 등 봉재곡면 및 금속평면의 절삭할 제품을 확인하고 소재의 종류·형태 등에 따라 면삭방법 및 절차를 결정한다. 스카퍼 등 면삭기를 점검, 준비하며 면삭기의 상태를 점검한다. 철, 합금강, 스테인리스강 등으로 제조된 노(爐)제품, 주조제품, 단조제품 등을 호이스트로 운반하여 고정틀을 사용하여 작업대에 고정한다. 면삭기의 전원을 연결하고 스위치를 넣어 소재표면을 마찰하여 표면의 결함을 제거한다. 작업명세서에 따라 표면 절삭상태를 육안으로 관찰하여 표면상태, 치수 및 규격 등을 검사한다. 고정틀을 해체하여 면삭시킨 제품을 작업대에서 분리하고 표면상태, 조도상태, 치수 및 규격 등을 검사한다. 면삭한 제품이 작업명세서의 규격과 다를 때는 다시 면삭하여 작업표준에 맞도록 교정하고 완성된 제품을 호이스트로 운반하여 적재한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"스카핑원","dJobECd":"8132","dJobECdNm":"[8132]금속 공작기계 조작원","dJobJCd":"8510","dJobJCdNm":"[8510]금속 공작 기계 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005352:1', '{"dJobCd":"K000005352","dJobCdSeq":"1","dJobNm":"밀링기조작원","workSum":"기계부품, 공구, 다이부품 등과 같은 금속공작물의 평면 또는 곡면을 절삭 가공하기 위하여 밀링기를 조작한다.","doWork":"작업지시서와 도면에 따라 가공할 공작물의 치수, 허용오차를 결정하고 필요한 절삭공구, 수동공구, 고정구 등을 준비한다. 공작물을 손이나 기중기로 기계테이블 위에 올려놓고 꺾쇠, 볼트, 고정구를 사용하여 고정한다. 가공작업에 필요한 절삭공구를 스핀들(Spindle)에 장착시키고 조정기를 작동하여 이송률, 절삭속도, 절삭깊이 등을 조절한다. 수동바퀴를 돌려 절삭공구를 공작물의 가공부위로 이송한다. 기계를 가동시키고 공작물의 가공상태를 관찰한다. 마이크로미터, 버니어캘리퍼스 등의 측정공구를 사용하여 공작물의 일치도를 검사한다. 밸브 손잡이를 돌려 기계에 냉각제와 윤활유를 주입하기도 한다. 드릴링, 보링과 같은 작업을 위하여 절삭공구를 교체하여 사용하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"밀링원, 범용밀링기조작원","certLic":"컴퓨터응용가공산업기사","dJobECd":"8132","dJobECdNm":"[8132]금속 공작기계 조작원","dJobJCd":"8510","dJobJCdNm":"[8510]금속 공작 기계 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004393:1', '{"dJobCd":"K000004393","dJobCdSeq":"1","dJobNm":"바렐기조작원","workSum":"주조된 제품의 표면을 다듬기 위한 바렐기를 조작한다.","doWork":"주조된 제품을 인계받아 연마부위와 이물질이 없는지 등을 관찰한다. 연마설비를 점검하고 연마기의 바렐통에 주조품과 연마석을 일정 비율로 산정하여 투입한다. 기계를 가동하여 진동을 주어 제품의 이물질 및 모서리 부위의 제거 및 연마를 한다. 연마된 제품을 세척하고 열풍기를 가동하여 건조한다. 완료된 제품을 검사한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"바렐원, 주조물연마원","dJobECd":"8132","dJobECdNm":"[8132]금속 공작기계 조작원","dJobJCd":"8510","dJobJCdNm":"[8510]금속 공작 기계 조작원","dJobICd":"C243","dJobICdNm":"[C243]금속 주조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005631:1', '{"dJobCd":"K000005631","dJobCdSeq":"1","dJobNm":"방전가공기조작원","workSum":"경질합금, 내열강, 스테인리스강, 다이아몬드 등 고경도의 공작물을 전기의 방전현상을 이용하여 절단가공, 구멍가공, 연마가공 등을 하는 전기방전기계를 설치·조작한다.","doWork":"작업지시서와 도면에 따라 작업절차와 방식을 검토한다. 고정구·꺾쇠·물림장치 등을 사용하여 공작물을 고정한다. 전극지지대에 규정된 형상의 전극을 장치하고 캘리퍼스, 다이얼인디케이터 등의 측정기구를 사용하여 공작물과 전극의 위치를 확인한다. 밸브를 돌려 공작물과 전극이 잠기도록 비전도성의 가공액을 투입한다. 기계를 작동시키고 분사식 호스를 사용하여 전극과 공작물 사이의 잔재물을 제거하면서 가공상태를 관찰한다. 형판과 그 밖의 측정공구를 사용하여 도면과 가공치수의 일치도를 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"컴퓨터응용가공산업기사","dJobECd":"8132","dJobECdNm":"[8132]금속 공작기계 조작원","dJobJCd":"8510","dJobJCdNm":"[8510]금속 공작 기계 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007082:1', '{"dJobCd":"K000007082","dJobCdSeq":"1","dJobNm":"밸브가공원","workSum":"밸브의 종류에 따라 프레스단조 또는 주조 등의 기계가공에 필요한 밸브 형상을 가공한다.","doWork":"작업지시서에 따라 가공할 제품의 명세서를 확인·검토한다. 작업에 필요한 장비와 작업공구를 준비하고 시험가동 한다. 가공품을 작업대 위에 올려놓는다. 작업지시서에 따라 밸브의 가공부위와 가공방법을 확인한다. 작업명세서에 따라 가공수치 및 데이터를 고속가공기, CNC보링, NC보링, 밀링기, 와이어커팅기 등의 디지털계기에 입력한다. 작업명세서상의 작업공정을 단계별로 수행한다. 각 공정 후 측정공구를 사용하여 작업명세서의 수치 및 규격과 비교하여 수정·보강한다. 가공된 최종 제품을 작업명세서의 규격 및 수치와 비교한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"컴퓨터응용가공산업기사","dJobECd":"8132","dJobECdNm":"[8132]금속 공작기계 조작원","dJobJCd":"8510","dJobJCdNm":"[8510]금속 공작 기계 조작원","dJobICd":"C291","dJobICdNm":"[C291]일반 목적용 기계 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003708:1', '{"dJobCd":"K000003708","dJobCdSeq":"1","dJobNm":"밸브연삭원","workSum":"주조된 밸브제품의 표면을 갈거나 매끄럽게 하기 위해 연삭기를 조작한다.","doWork":"작업지시서에 따라 가공할 제품의 명세서를 확인·검토한다. 작업에 필요한 장비와 작업공구를 준비한다. 가공품을 작업대 위에 올려놓는다. 작업지시서에 따라 밸브의 연삭부위와 연삭방법을 계산한다. 페이스플레이트에 가공품을 고정한다. 기계를 작동시켜 밸브의 외면을 연삭한다. 숫돌의 마모방지를 위하여 숫돌과 마찰하는 부위에 연삭유나 연삭제를 주입한다. 작업명세서상의 작업공정을 단계별로 수행한다. 공정작업 후 측정공구를 사용하여 작업명세서의 수치 및 규격과 비교하여 수정·개선한다. 가공된 최종 제품을 작업명세서상의 규격 및 수치와 비교한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8132","dJobECdNm":"[8132]금속 공작기계 조작원","dJobJCd":"8510","dJobJCdNm":"[8510]금속 공작 기계 조작원","dJobICd":"C291","dJobICdNm":"[C291]일반 목적용 기계 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004101:1', '{"dJobCd":"K000004101","dJobCdSeq":"1","dJobNm":"보링기조작원","workSum":"금속공작물 표면에 뚫어진 구멍을 가공하기 위해 직경을 넓히거나 깊이를 조작하는 보링기를 조작한다.","doWork":"도면 또는 작업지시서에 따라 공작물에 적합한 보링조건을 정한다. 가공물이 도면규격과 일치하는지 확인한다. 작업에 적합한 공구 및 검사설비, 보링바이트를 준비한다. 보링바이트를 고정하고 지름이 큰 공작물의 경우 보링헤드를 보링바에 고정한다. 바이트세팅게이지로 보링경에 정확히 맞춘다. 공작물을 테이블에 고정한다. 버튼을 눌러 보링머신을 구동한다. 레버를 작동하여 스핀들을 상하로 조정한다. 가공된 공작물을 측정기기로 검사한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"컴퓨터응용선반기능사","dJobECd":"8132","dJobECdNm":"[8132]금속 공작기계 조작원","dJobJCd":"8510","dJobJCdNm":"[8510]금속 공작 기계 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004083:1', '{"dJobCd":"K000004083","dJobCdSeq":"1","dJobNm":"볼압입원","workSum":"금속제품의 홈이나 구멍 등에 매끄러운 표면처리나 확관작업을 위하여 압입작업을 실시한다.","doWork":"작업지시서에 따라 가공할 제품을 확인한다. 소재의 종류·형태 등에 따라 가공방법을 결정한다. 버니어캘리퍼스를 이용하여 내경과 외경, 길이에 대한 가공여유를 확인한다. 윤활제를 선정하고 접착제를 배합한다. 관에 볼을 넣고 굴려서 압입상태를 균일하게 한다. 경화 후 윤활제의 돌출 여부를 점검한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8132","dJobECdNm":"[8132]금속 공작기계 조작원","dJobJCd":"8510","dJobJCdNm":"[8510]금속 공작 기계 조작원","dJobICd":"C291","dJobICdNm":"[C291]일반 목적용 기계 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006890:1', '{"dJobCd":"K000006890","dJobCdSeq":"1","dJobNm":"볼트헤드원","workSum":"볼트의 머리부분인 헤드를 성형하기 위해 단조기를 조작한다.","doWork":"호이스트(Hoist:소형의 화물을 들어 옮기는 장치)를 이용하여 원재료를 스탠드에 장착한다. 필요하면 재료의 휨을 교정하고 재료를 피이드 롤러에 주입한다. 기존 금형을 해체하고 신규 금형을 세팅한다. 단조기를 조작하여 볼트의 헤드를 성형한다. 성형된 제품의 길이 등을 측정공구를 사용하여 검사한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"시범후 30일 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8132","dJobECdNm":"[8132]금속 공작기계 조작원","dJobJCd":"8510","dJobJCdNm":"[8510]금속 공작 기계 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002396:1', '{"dJobCd":"K000002396","dJobCdSeq":"1","dJobNm":"봉절단원","workSum":"원하는 크기로 봉을 절단하기 위해 선반을 사용하여 봉재의 절단작업을 실시한다.","doWork":"작업지시서 및 도면에 따라 공작물의 치수, 수량을 확인하고 절단바이트를 선택하여 선반의 공구대에 고정한다. 공작물을 척에 고정한다. 공작물이 척에 고정되지 않는 면(4각 등)일 경우는 지그를 사용한다. 스위치를 눌러서 절단작업을 한다. 초도공작물에 이상이 없으면 연속해서 작업한다. 절단바이트의 마모도를 점검한다. 버니어캘리퍼스 등 측정공구로 검사한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"시범후 30일 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8132","dJobECdNm":"[8132]금속 공작기계 조작원","dJobJCd":"8510","dJobJCdNm":"[8510]금속 공작 기계 조작원","dJobICd":"C291","dJobICdNm":"[C291]일반 목적용 기계 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003469:1', '{"dJobCd":"K000003469","dJobCdSeq":"1","dJobNm":"부시가공원","workSum":"선반기계를 이용하여 치공구를 장착하고 기계를 가동시켜 부시(Bush:원통형의 간단한 베어링 메탈)를 가공한다.","doWork":"작업지시서에 따라 가공할 제품의 명세서를 확인·검토한다. 작업에 필요한 장비와 작업공구를 준비하고 시험가동 한다. 가공품을 작업대 위에 올려놓는다. 작업지시서에 따라 부시의 가공부위와 가공방법을 확인한다. 작업지시서에 맞는 치공구를 장착한다. 금속가공물을 페이스플레이트에 고정한다. 선반기계를 작동시키고 레버를 조작하여 부시의 외면을 가공한다. 외면가공이 끝나면 치공구를 교체하여 내면을 가공한다. 작업명세서상의 작업공정을 단계별로 공정한다. 각 공정 후 측정공구를 사용하여 작업명세서의 수치 및 규격과 비교하여 수정보강한다. 가공된 최종 제품을 작업명세서상의 규격 및 수치와 비교한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"시범후 30일 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8132","dJobECdNm":"[8132]금속 공작기계 조작원","dJobJCd":"8510","dJobJCdNm":"[8510]금속 공작 기계 조작원","dJobICd":"C291","dJobICdNm":"[C291]일반 목적용 기계 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005346:1', '{"dJobCd":"K000005346","dJobCdSeq":"1","dJobNm":"사상원","workSum":"가공된 부품이나 제품을 작업지시서나 설계도면에 명시된 정밀한 표면 조도로 다듬기 위하여 줄, 호닝기 등 각종 사상기구를 사용하여 절단·연마·연삭·조립한다.","doWork":"작업지시서나 사상반장의 지시에 따라 사상할 설계도면을 검토하여 소요자재와 공구를 준비하고 작업절차 및 방법을 검토한다. 줄·호닝기 등 사상기구를 정비, 점검, 소수리 한다. 가공부품이나 제품의 조립부분, 용접부분 등의 거친 부위를 줄 등의 사상기구를 사용하여 자르고, 깎는다. 호닝기 등 연마기구를 사용하여 금속표면을 사상한다. 도면에 따라 사상된 부품을 조립하고 원형·넓이·길이·부피 등 금속의 내·외면을 검사·측정한다. 가공소재에 선을 긋고 참고사항을 표시하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"8132","dJobECdNm":"[8132]금속 공작기계 조작원","dJobJCd":"8510","dJobJCdNm":"[8510]금속 공작 기계 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004589:1', '{"dJobCd":"K000004589","dJobCdSeq":"1","dJobNm":"선박사상원","workSum":"선박 및 해양구조물의 건조 시 용접, 절단, 제관된 부위의 결함을 제거하기 위하여 연마기(Grinder)로 사상작업을 한다.","doWork":"작업지시서에 따라 사상할 용접부분, 절단부분, 제관부위를 확인한다. 그라인더(Grinder) 및 소모자재를 준비한다. 작업 위치에 따라 고소차에 탑승하거나 비계를 이용하여 이동하기도 한다. 사상할 부분에 고속으로 회전하는 그라인더디스크(Grinder Disc)를 접촉시켜 이물질을 제거하고 표면을 매끄럽게 사상한다. 사상한 부분을 세척액(시너)으로 세척하여 이물질 여부를 검사하기도 한다. 작업 중에 발생한 분진 및 이물질을 청소하고 작업장소를 정리하여 마무리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"그라인더작업원, 선박연마원","dJobECd":"8132","dJobECdNm":"[8132]금속 공작기계 조작원","dJobJCd":"8510","dJobJCdNm":"[8510]금속 공작 기계 조작원","dJobICd":"C311","dJobICdNm":"[C311]선박 및 보트 건조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003467:1', '{"dJobCd":"K000003467","dJobCdSeq":"1","dJobNm":"선반원","workSum":"작업지시서 또는 가공도면에 따라 금속공작물의 선삭가공, 구멍가공, 나사가공, 면가공과 같은 가공작업을 하기 위하여 선반을 조작한다.","doWork":"가공할 기계부품에 따라 도면을 분석하고 공작물의 구조·치수·주요부분 등을 파악한다. 작업지시서 또는 가공도면에 따라 가공할 금속공작물의 크기·허용오차·이송률·절삭속도·절삭깊이와 절삭공구를 결정한다. 렌치를 사용하여 고정구와 절삭공구를 장치한다. 렌치(Wrench)를 사용하여 공작물을 척 또는 고정구에 고정한다. 작업표준에 따라 일정한 순환속도, 이송률 및 절삭정도를 조절하기 위해 조정장치를 조작한다. 공작물의 열 발생 및 바이트(Bit) 마모를 방지하기 위하여 절삭유를 공급한다. 공작물의 가공부위에 따라 절삭공구, 이송대 핸들을 조정하여 공작물에 절삭공구를 이송한다. 기계를 작동시키고 기계의 고장이나 공구의 마모 및 가공작업을 관찰한다. 마이크로미터·버니어캘리퍼스·고정게이지 등을 사용하여 작업지시서 또는 가공도면의 치수 및 허용오차에 따라 가공상태를 확인한다. 밸브핸들을 돌려 절삭공구와 공작물에 냉각제를 공급한다. 렌치를 사용하여 마모된 공구를 교환한다. 절단 및 절삭의 정도를 설계하기 위하여 자·형판·획선기를 사용하여 공작물에 기준선을 긋기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"유압자동선반조작원, 로구로(단능선반)자동선반조작원, 범용다축선반조작원, 벤치레스(유압자동선반)조작원, 프로콘(선반일종)조작원, 범용선반기능원, CNC선반원, 범용선반원","certLic":"컴퓨터응용선반기능사","dJobECd":"8132","dJobECdNm":"[8132]금속 공작기계 조작원","dJobJCd":"8510","dJobJCdNm":"[8510]금속 공작 기계 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006241:1', '{"dJobCd":"K000006241","dJobCdSeq":"1","dJobNm":"수치제어드릴링기조작원","workSum":"금속가공물에 대해 여러 형태의 구멍가공작업을 하기 위하여 드릴가공작업을 자동으로 행하는 수치제어드릴링기(NC)를 조작한다.","doWork":"작업지시서에 따른 가공품을 확인한다. 작업명세서상의 규격과 수치를 확인한다. 작업지시서에 따라 작업공정방법을 선택한다. 가공할 금속물을 기계테이블 위에 고정한다. 절삭공구의 움직임이나 주축(主軸)의 회전수 등을 설계도의 규격대로 펀치테이프에 기록해 두거나 CAM을 이용하여 도면의 내용을 자동계측기에 입력한다. 가동스위치를 켠다. 드릴링이 계산대로 가공되는지 육안으로 확인한다. 수동 계측기로 제품의 규격 및 수치를 계측한다. 잘못된 부분은 작업표준대로 교정한다. 완성된 제품이 명세서의 규격과 일치하는지를 확인한다. 다음 공정작업을 위하여 완성제품을 이동한다. 기기의 윤활유 등을 점검하고 정리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"NC드릴링기조작원, CNC드릴링기조작원","connectJob":"HOT후로아보링기조작원, 레디알머신조작원, 보루방기능원, 마그네틱드릴조작원, PCB드릴조작원, 플로어보링기조작원, 탁상용드릴조작원, 주물케이스드릴조작원, 탭드릴조작원, 건드릴M/C조작원, RAPPING CENTER조작원, 탭핑센터조작원, HOLE드릴기조작원, 레이디얼드릴링기조작원","certLic":"컴퓨터응용가공산업기사","dJobECd":"8132","dJobECdNm":"[8132]금속 공작기계 조작원","dJobJCd":"8510","dJobJCdNm":"[8510]금속 공작 기계 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002424:1', '{"dJobCd":"K000002424","dJobCdSeq":"1","dJobNm":"수치제어밀링기조작원","workSum":"자동제어장치가 부착되어 있는 수치제어밀링기를 조작하여 금속공작물의 곡면, 면, 홈 등을 가공한다.","doWork":"도면을 읽고 가공방법, 가공조건을 정하여 컨트롤러에 NC코드를 입력한다. 설계사가 만들어 놓은 공작프로그램을 입력하기도 한다. 시뮬레이션을 통해 이상이 없으면 가공물이 도면규격과 맞는가를 확인한 다음 작업에 맞는 공구 및 검사설비, 치구를 준비한다. 기계의 각 부분에 급유를 확인하고 겨울철에는 예열을 위해 공회전을 한다. 공작물을 고정할 때는 상면을 연질해머로 가볍게 때려 밑면이 밀착하도록 한다. NC코드(공작프로그램)에 따라 주축 회전수, 절삭깊이가 정해지는 것을 확인한다. 치수기준이 디지털 스케일에 준해서 가공되며, 절삭유 및 에어로 냉각되는 것을 관찰한다. 공작물이 완성되면 측정기구를 사용하여 작업결과물을 측정하고 도면과 동일한지 확인한다. 완성된 제품을 보관 장소로 이동한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"NC밀링기조작원, CNC밀링기조작원","connectJob":"프레노밀러조작원, 5면가공기조작원, 평삭밀링기조작원, 버티칼밀링기조작원, 프레나밀링기조작원, 플레이너밀러조작원, 고속가공기OKUMA(FUNAC SYSTEM)조작원, 탭밀센터조작원, 범용밀링기조작원","certLic":"컴퓨터응용가공산업기사","dJobECd":"8132","dJobECdNm":"[8132]금속 공작기계 조작원","dJobJCd":"8510","dJobJCdNm":"[8510]금속 공작 기계 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005030:1', '{"dJobCd":"K000005030","dJobCdSeq":"1","dJobNm":"수치제어보링기조작원","workSum":"금속가공물에 대해 여러 형태의 구멍가공작업을 하기 위하여 수치제어보링기를 조작한다.","doWork":"작업지시서에 따른 가공품을 확인한다. 작업명세서상의 규격과 수치를 확인한다. 작업지시서에 따라 작업공정방법을 선택한다. 가공할 금속물을 기계테이블 위에 고정한다. 절삭공구의 움직임이나 주축의 회전수 등을 설계도의 규격대로 펀치테이프에 기록해 두거나 CAM을 이용하여 도면의 내용을 자동계측기에 입력한다. 가동 스위치를 켠다. 보링이 계산대로 가공되는지 확인한다. 수동 계측기로 제품의 규격 및 수치를 계측한다. 잘못된 부분은 작업표준대로 교정한다. 완성된 제품이 명세서의 규격과 일치하는지를 확인한다. 다음 공정작업을 위하여 완성제품을 이동한다. 기기의 윤활유 등을 점검하고 정리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"NC보링기조작원, CNC보링기조작원","certLic":"컴퓨터응용가공산업기사","dJobECd":"8132","dJobECdNm":"[8132]금속 공작기계 조작원","dJobJCd":"8510","dJobJCdNm":"[8510]금속 공작 기계 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003666:1', '{"dJobCd":"K000003666","dJobCdSeq":"1","dJobNm":"수치제어선반조작원","workSum":"수치제어장치가 부착된 수치제어선반기를 조작하여 금속공작물의 선삭, 축, 면을 가공한다.","doWork":"도면 또는 작업지시서에 따라 중요치수와 작업순서를 정한다. 공작물을 지그에 고정시키고 절삭공구를 설치한다. 작업프로그램을 입력하고 시뮬레이션 또는 느린 속도로 초도작업을 실시한다. 초도 작업물에 이상이 없으면 반복 작업할 수 있도록 프로그램을 고정한다. 기계를 작동시키고 프로그램의 공정도와 패널의 숫자를 확인하면서 가공상태를 관찰한다. 절삭공구의 마모도를 확인한다. 가공이 완료된 가공물을 떼어내어 마이크로미터나 버니어캘리퍼스 등의 측정기구를 사용하여 치수를 검사하고 이상이 없는 가공물은 다음 공정의 보관장소로 이동한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"NC선반원, CNC선반원","connectJob":"CNC터닝선반조작원, CNC다축선반조작원, CNC육축기조작원, 범용선반원","certLic":"컴퓨터응용선반기능사, 컴퓨터응용가공산업기사","dJobECd":"8132","dJobECdNm":"[8132]금속 공작기계 조작원","dJobJCd":"8510","dJobJCdNm":"[8510]금속 공작 기계 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004587:1', '{"dJobCd":"K000004587","dJobCdSeq":"1","dJobNm":"슬리터조작원","workSum":"열연 또는 냉연코일을 언코일링 한 후 전단기(Slitter)를 이용하여 다양한 넓이로 절단하고 되감아 스켈프(강대)를 생산한다.","doWork":"작업지시서의 작업내용을 확인하고 전단기 및 부대설비를 점검한다. 원재료(코일)를 언코일러에 위치하고 필치롤에 선단부를 장입하여 레벨러에서 평탄도를 유지한다. 원재료 선단부를 리코일러에 권취될 수 있도록 선단 절단기를 조작하고, 가이드 장치를 활용하여 슬리팅 스탠드까지 원재료를 이송시킨다. 슬리팅 스탠드의 나이프를 절단하고자 하는 폭에 맞추어 조정 또는 교환 후 목적한 폭으로 슬리팅 후 세퍼레이터 나이프를 활용하여 리코일러에 스켈프 선단이 정렬되어 코일링이 될 수 있도록 한다. 스켈프 운반 대차를 이용하여 절단된 스켈프를 운반 후 크레인으로 작업장이나 보관위치로 운반한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"폭전단기조작원, 코일전단원, Slitter 조작원","dJobECd":"8132","dJobECdNm":"[8132]금속 공작기계 조작원","dJobJCd":"8510","dJobJCdNm":"[8510]금속 공작 기계 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004038:1', '{"dJobCd":"K000004038","dJobCdSeq":"1","dJobNm":"연마기조작원","workSum":"연마기를 사용하여 기계부품, 게이지, 공구부품 등의 금속표면을 연마한다.","doWork":"작업지시서 및 도면에 따라 작업절차와 방법을 검토한다. 렌치 등 수동공구를 사용하여 공작물을 고정구나 동력전동 기계장치에 장치한다. 연마반의 표면에 있는 홈을 줄질한다. 스테아르산을 가열하여 액체로 만든 다음 알루미나 분체를 섞어 만든 연마제(컴파운드)를 공작물에 바른다. 공작물의 종류와 연마목적에 따라 연마반을 결정하여 회전축에 설치한다. 공작물의 상태에 따라 버핑 또는 폴리싱 공정을 추가하기도 한다. 스테인리스강, 신주, 양은 재질의 경우 헝겊연마반을 사용한다. 연마반을 회전시키고 공작물을 마찰시켜 연마한다. 특수게이지를 사용하여 도면과 연마 가공된 공작물의 일치도를 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"광택기조작원","connectJob":"버핑기조작원, 폴리싱기조작원, 평형연마기조작원, 성형연마기조작원, 원통연마기조작원, 파이프연마기조작원, 롤연마기조작원, 센타레스연마기조작원, 무심연마기조작원, 바렐연마기조작원, 전해연마원, 콘렉타연마원, 양두연마기조작원, 전극연마기조작원, PCB드릴비트연마조작원, 벨트연마원, 로타리연마원, 비트연마원, CNC연마원, 성형연마원(아프리케타), 호닝연마원, 내경연마원, 폴리싱작업원, 엔드밀(ENDMILL)연마원, 센타레스연마원","dJobECd":"8132","dJobECdNm":"[8132]금속 공작기계 조작원","dJobJCd":"8510","dJobJCdNm":"[8510]금속 공작 기계 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005277:1', '{"dJobCd":"K000005277","dJobCdSeq":"1","dJobNm":"연마반장","workSum":"연마작업원에 작업을 지시하며 작업공정을 관리·감독한다.","doWork":"작업시방서나 작업명세서에 따라 원통, 평면, 내면, 외면연삭을 구분하여 작업공정계획을 수립하고, 연마할 금속 제품의 특성과 재질을 파악하여, 연마제의 종류를 결정한다. 연삭기 사용 또는 수동연마 등의 작업형태와 작업방법 및 초벌연마, 중간연마, 마무리연마 등의 작업절차를 해당 공정 작업원에게 지시하고, 작업공정을 점검하고 확인한다. 공정상의 연마계획에 따라 연마기구를 선택하고 작업방법 및 절차를 작업원에게 지시한다. 연마된 제품의 표면검사 및 규격상태를 최종적으로 점검하여 작업명세서와 일치하는지를 확인한다. 공장 내의 부대설비를 점검한다. 작업원에 대한 안전재해를 예방한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","similarNm":"연삭반장, 광택반장","dJobECd":"8132","dJobECdNm":"[8132]금속 공작기계 조작원","dJobJCd":"8510","dJobJCdNm":"[8510]금속 공작 기계 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002304:1', '{"dJobCd":"K000002304","dJobCdSeq":"1","dJobNm":"연삭기조작원","workSum":"연삭기를 사용하여 금속의 표면을 갈거나 매끄럽게 한다.","doWork":"도면 또는 작업지시서에 따라 공작물에 적합한 연삭조건을 정한다. 기준면가공에 적합한 연삭조건을 찾는다. 작업물을 샌드페이퍼로 면치작업을 한 다음 연삭바이스에 설치한다. 연삭범위를 정하여 이송거리 및 초기 불꽃시작점을 정하고 이송속도, 이송범위, 절삭깊이 등을 조정한다. 황삭, 정삭하고 초도 작업물에 이상이 없어 반복 작업할 때는 조정값을 고정한다. 연삭불꽃, 연삭소음, 연삭정도를 주의 깊게 관찰하여 연삭환경을 조절하며 적절히 조치한다. 냉각수 드래싱 위치와 연삭위치의 변화를 파악하여 과열되지 않도록 조치한다. 완제품이 생산되면 연삭공구(연삭숫돌)의 마모량을 확인하여 마모량이 심할 경우 교체한다. 공작물에 따라 적절한 측정공구를 선택하여 치수를 확인한다. 표면조도를 검사하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"연삭원","connectJob":"내외경연삭기조작원, 금속탁마기조작원, 공구연삭기조작원, 원통연삭기조작원, 베드연삭기조작원, 평면연삭기조작원, CNC연삭원, 범용연삭기조작원","dJobECd":"8132","dJobECdNm":"[8132]금속 공작기계 조작원","dJobJCd":"8510","dJobJCdNm":"[8510]금속 공작 기계 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006268:1', '{"dJobCd":"K000006268","dJobCdSeq":"1","dJobNm":"와이어커팅기조작원","workSum":"와어어커팅기를 사용하여 가공물에 구멍을 뚫거나 복잡한 형상으로 가공한다.","doWork":"설계도면과 작업시방서에 따라 조립할 배관의 용도 및 위치와 구조를 확인한다. 작업공구를 준비하고 점검한다. 용도에 따른 관의 종류를 구별하여 선택한다. 도면 및 배관의 위치에 따라 마킹한다. 관의 길이를 규격대로 수직으로 절단한다. 곡선배관은 공구를 사용하여 구부리거나 ㄱ자형의 엘보밸브를 사용한다. 관의 이음부분은 가스캣, 커플링, 볼트, 나사, 플랜지, 피팅, 티, 맛대기용접 등을 하여 접합한다. 게이트밸브를 조립하여 유체의 제어장치를 설치한다. 도면에 따라 압축기, 계량기 등을 조립·설치한다. 수평기를 이용하여 관의 수평상태를 조정한다. 접합부분의 누수압력 및 제한압력, 유체의 누출 여부 등을 시험·검사한다. 배관의 구조가 도면과 일치하는지 검사한다. 작업내용을 작업일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"와이어커팅원","connectJob":"와이어컷방전기가공원, CNC와이어컷방전기가공원, NC와이어컷방전기조작원","certLic":"컴퓨터응용가공산업기사","dJobECd":"8132","dJobECdNm":"[8132]금속 공작기계 조작원","dJobJCd":"8510","dJobJCdNm":"[8510]금속 공작 기계 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007748:1', '{"dJobCd":"K000007748","dJobCdSeq":"1","dJobNm":"원자력연료제조원","workSum":"원자력 연료를 생산하기 위하여 튜브, 연료봉, 지지격자, 연료봉집합체 등을 선반, 자동용접기 등 도구, 장비 및 설비를 사용하거나 운전하여 절단·용접·가공하고 밀봉, 충진, 조립 및 결합한다.","doWork":"작업지시서를 확인하고 수행할 작업을 준비한다. 성형, 가공, 검사공정을 거쳐 튜브(피복관)를 제조한다. 튜브(피복관)을 도면에 따라 절단·용접하고 가공하여 (핵)연료봉을 제조한다. 핵연료 집합체 구조부품인 지지격자를 제조하기 위하여 부품을 조립·용접·납땜한다. 연료봉 및 부품들을 핵연료 결합체로 조립하여 저장 및 출하하기 위하여 관련 장비를 조작한다. 제조 후 검사하고 테스트한다. 제조 과정에 문제 발생 시 조치를 하고 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"핵연료제조원","connectJob":"튜브제조원, 연료봉제조원, 연료봉지지격자제조원, 연료봉집합체제조원","dJobECd":"8132","dJobECdNm":"[8132]금속 공작기계 조작원","dJobJCd":"8510","dJobJCdNm":"[8510]금속 공작 기계 조작원","dJobICd":"C201","dJobICdNm":"[C201]기초 화학물질 제조업","inqYear":"2025"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004850:1', '{"dJobCd":"K000004850","dJobCdSeq":"1","dJobNm":"원판절단기조작원","workSum":"명세서에 설정된 크기의 원형으로 절단하는 절단기계를 조작한다.","doWork":"생산계획서를 읽고 절단할 금속소재를 확인하고 절단기 및 관련 설비의 이상 유무를 확인한다. 작업할 금속소재를 원판절단기에 장치한다. 원판절단기의 원의 크기에 맞추어 조작반을 조작한다. 절단기의 전원을 넣어 작업을 진행하고 작업상황을 관찰한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"스크롤시어조작원, 환절기조작원","connectJob":"레이저절단기조작원","certLic":"판금제관기능사, 판금제관산업기사, 판금제관기능장","dJobECd":"8132","dJobECdNm":"[8132]금속 공작기계 조작원","dJobJCd":"8510","dJobJCdNm":"[8510]금속 공작 기계 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006517:1', '{"dJobCd":"K000006517","dJobCdSeq":"1","dJobNm":"인쇄기실린더연마원","workSum":"동 도금을 마친 그라비어 인쇄용 실린더의 면을 균일하게 하기 위하여 연마기계를 사용하여 연마한다.","doWork":"연마할 실린더를 물로 세척한다. 연마기의 원심 사이에 실린더를 고정한다. 실린더 규격에 맞는 원통 연마석을 선택하여 연마기의 주축에 고정한다. 원통 연마석을 실린더 표면에 접촉하거나 자동 투입을 유도하기 위하여 기계를 시동하여 핸들 바퀴를 돌린다. 연마의 정밀도를 파악하기 위하여 마이크로미터를 사용하여 연마작업 중에 실린더 표면의 크기를 측정한다. 연마석(숫돌)의 연마압을 조정하기 위하여 밸런스웨이트(Balance Weight:평형추)를 조정한다. 기계에서 완성된 실린더를 꺼내어 선반대에 놓는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8132","dJobECdNm":"[8132]금속 공작기계 조작원","dJobJCd":"8510","dJobJCdNm":"[8510]금속 공작 기계 조작원","dJobICd":"C181","dJobICdNm":"[C181]인쇄 및 인쇄관련 산업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006263:1', '{"dJobCd":"K000006263","dJobCdSeq":"1","dJobNm":"인쇄기실린더조각원","workSum":"그라비어인쇄용 실린더에 필름상태의 인쇄내용을 재현시켜 조각하기 위하여 실린더조각기를 조작한다.","doWork":"문자와 그림으로 형성된 필름을 조각기드럼에 적절하게 부착한다. 조각도가 설치된 조각기에 도금실린더를 장착한다. 전원스위치를 넣어 조각기를 가동한다. 조각기가 드럼에 부착된 필름을 읽고 필름의 내용을 도금실린더에 조각하는지 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"헤리오제판원","certLic":"인쇄기능사, 인쇄산업기사","dJobECd":"8132","dJobECdNm":"[8132]금속 공작기계 조작원","dJobJCd":"8510","dJobJCdNm":"[8510]금속 공작 기계 조작원","dJobICd":"C181","dJobICdNm":"[C181]인쇄 및 인쇄관련 산업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004596:1', '{"dJobCd":"K000004596","dJobCdSeq":"1","dJobNm":"임펠러가공원","workSum":"송풍기의 부품인 임펠러를 가공하기 위하여 소재를 절단, 성형하고 키홈과 동바란싱 가공 등을 한다.","doWork":"송풍기제조반장의 지시에 따라 도면과 작업지시서를 검토한다. 사용할 장비와 각종 공구를 준비한다. 재료를 규격에 맞도록 절단하고 성형한다. 용접을 하고 선반가공을 한다. 임펠러는 축에 고정시키는 키홈 가공을 한다. 동바란싱 가공을 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"날개조립원","certLic":"컴퓨터응용가공산업기사","dJobECd":"8132","dJobECdNm":"[8132]금속 공작기계 조작원","dJobJCd":"8510","dJobJCdNm":"[8510]금속 공작 기계 조작원","dJobICd":"C291","dJobICdNm":"[C291]일반 목적용 기계 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;