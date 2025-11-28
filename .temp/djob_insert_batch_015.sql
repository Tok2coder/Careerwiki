INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003481:1', '{"dJobCd":"K000003481","dJobCdSeq":"1","dJobNm":"가스시험분석원","workSum":"양질의 가스를 공급하기 위하여 표본을 추출하여 열량, 부취농도, 밀도, 유황농도 등의 성분을 분석한다.","doWork":"도입된 가스의 시료를 채취한다. 시료의 성분을 분석하여 열량, 밀도 등을 계산한다. 가스의 유출을 알려주기 위한 부취제의 주입농도를 분석한다. 유황성분의 농도를 분석하여 배관에 미치는 영향을 판단한다. 검사한 각종 결과를 보고서에 기록한다. 수용가의 시료를 채취하여 열량을 분석한다. 실험용 기자재 및 설비를 유지·관리한다. 기타 가스분석과 관련된 업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"가스기사, 가스산업기사","dJobECd":"1552","dJobECdNm":"[1552]가스·에너지공학 시험원","dJobJCd":"2374","dJobJCdNm":"[2374]가스 및 에너지 시험원","dJobICd":"D352","dJobICdNm":"[D352]연료용 가스 제조 및 배관공급업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002725:1', '{"dJobCd":"K000002725","dJobCdSeq":"1","dJobNm":"가스용품검사원","workSum":"가스용품 및 용기의 성능과 안전도를 점검하기 위하여 각종 시험 및 검사를 한다.","doWork":"각종 가스 용품 및 용기(탱크류, 특정설비, 호스, 가스누설차단장치, 연소기 등)의 구조검사, 치수검사, 기밀시험, 내압시험, 작동검사, 연소상태시험, 규격표시의 적부를 각종 시험기구나 육안으로 검사·확인한다. 난방기, 건조기, 보일러 등의 연소기나 호스, 콕(Cock), 밸브, 조정기, 가스통 등의 용품이나 용기의 기밀, 가스소비량, 연소상태, 온도상승, 성능, 반복사용, 열효율, 내구성 등에 대하여 각종 기구로 시험·검사한다. 연소기나 가스용품·용기를 표준규격과 비교한다. 각종 시험에 필요한 장비를 운영·관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"가스산업기사, 가스기사","dJobECd":"1552","dJobECdNm":"[1552]가스·에너지공학 시험원","dJobJCd":"2374","dJobJCdNm":"[2374]가스 및 에너지 시험원","dJobICd":"D352","dJobICdNm":"[D352]연료용 가스 제조 및 배관공급업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004664:1', '{"dJobCd":"K000004664","dJobCdSeq":"1","dJobNm":"가스품질검사원","workSum":"가스의 원료, 생산 과정 중의 반제품, 생산된 완제품의 견본을 채취하고 각종 분석기를 이용해 품질을 측정·분석한다.","doWork":"탱크나 실린더로부터 가스의 원료 및 완제품의 시료를 채취하거나 실린더를 시험장소로 운반한다. 시험기구를 준비하고 채취된 시료 또는 의뢰된 시료를 가스크로마토그래프, 이온미터 등을 사용하여 순도, 불순물 여부, 혼합가스 비율 등의 성분을 측정한다. 제품규격과 일치하는지 확인하고 문제점이 발견되면 해당 부서에 통보하여 조치를 취한다. 분석원료, 분석결과, 조치사항 등을 일지에 기록하며 시험기구를 유지 및 관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"가스제품시험원","certLic":"가스기사, 가스산업기사","dJobECd":"1552","dJobECdNm":"[1552]가스·에너지공학 시험원","dJobJCd":"2374","dJobJCdNm":"[2374]가스 및 에너지 시험원","dJobICd":"D352","dJobICdNm":"[D352]연료용 가스 제조 및 배관공급업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006214:1', '{"dJobCd":"K000006214","dJobCdSeq":"1","dJobNm":"갱내탐사원","workSum":"갱내의 시추, 탐광, 굴진 등을 위한 계획을 수립하고 광량을 계산하기 위하여 유용광물의 폭, 연장, 품위, 경사, 주향 등을 조사하여 지질도를 작성한다.","doWork":"조사 대상지의 광맥·암질 등을 숙지하고 시추, 탐광, 굴진 등의 계획을 세운다. 탐사에 필요한 각종 장비 및 부속 기기류를 관리한다. 작업장소의 부석, 낙석, 붕락 등의 안전을 점검한다. 광맥의 연장에 따라 폭과 품의 지질구조를 조사하여 암석의 종류, 암맥의 주향, 단층의 경사, 방향 등을 기록한다. 조사된 자료에 따라 지질도를 작성한다. 샘플을 채취하여 분석실에 광물의 분석을 의뢰한다. 광물 분석결과를 토대로 광량을 계산한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"갱내탐광원","certLic":"화약류관리산업기사, 응용지질기사","dJobECd":"1552","dJobECdNm":"[1552]가스·에너지공학 시험원","dJobJCd":"2374","dJobJCdNm":"[2374]가스 및 에너지 시험원","dJobICd":"B051/B061/B062","dJobICdNm":"[B051]석탄 광업 / [B061]철 광업 / [B062]비철금속 광업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006958:1', '{"dJobCd":"K000006958","dJobCdSeq":"1","dJobNm":"매립가스포집분석원","workSum":"매립가스(Landfill Gas)를 수집(수집포집, 수평포집)하고 농도, 오염물질인 휘발성 유기화합물(VOC)의 양을 장비를 이용해 분석한다.","doWork":"매립가스(Landfill Gas)의 발열량 및 노동에 영향을 미치는 공기가 스며들지 않도록 주의하면서 매립가스 발생량을 조절한다. 배관 및 설비의 부식을 방지하기 위해 침출수분리시설을 이용해 매리가습 내 침출수를 분리한다. 가스 포집률을 높이기 위해 가승정과 포집스테이션의 모니터링과 제어를 한다. 포집된 바이오가스를 전기생산을 위한 보일러로 이송한다.  매립가스의 성상분석 장비를 이용해서 메탄, 이산화탄소, 산소 등의 농도를 분석한다. 매립장 표면발산 가스분석 장비를 이용해 유기화합물(VOC) 가스의 정량적 분석을 한다. 매립쓰레기 총량, 매립 년 수, 쓰레기 분해속도상수, 쓰레기 톤 당 발생되는 매립가스 발생량 등의 기본입력 수치에 가연성분 분석, 가연성분 원소분석 자료를 적용해 가스유량, 압력, 가스 질 등을 분석한다. 이러한 수치들을 이용해서 매립가스의 연간 발생량 및 사용 가능한 가스량을 예측하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"1552","dJobECdNm":"[1552]가스·에너지공학 시험원","dJobJCd":"2374","dJobJCdNm":"[2374]가스 및 에너지 시험원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002073:1', '{"dJobCd":"K000002073","dJobCdSeq":"1","dJobNm":"검열조종사","workSum":"항공기의 안전한 운항을 위하여 조종사의 비행 기량을 점검·관리한다.","doWork":"운항규정, 항공법 등 운항관계규정의 숙지상태를 점검한다. 각 시스템의 구조와 작동원리의 이해 상태를 점검한다. 항공기의 비행이론, 노선의 운행절차, 엔진의 가동, 지상주행, 이륙, 상승, 순항, 강하, 착륙 등에 이르는 모든 비행단계의 조종기량을 점검한다. 항공기 모의 조정장치를 조정하여 기상의 악화, 기체의 결함 등의 상황에서 조종사의 비행 기량을 점검하고 관련 자료를 정리하여 등급을 결정한다. 조종사의 운항일지를 검토하여 문제점을 확인하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"조작운전","certLic":"운송용조종사, 사업용조종사, 자가용조종사, 경량항공기조종사, 부조종사","dJobECd":"6211","dJobECdNm":"[6211]항공기 조종사","dJobJCd":"2381","dJobJCdNm":"[2381]항공기 조종사","dJobICd":"H511/H512","dJobICdNm":"[H511]항공 여객 운송업 / [H512]항공 화물 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004462:1', '{"dJobCd":"K000004462","dJobCdSeq":"1","dJobNm":"교관조종사","workSum":"신입 조종사 또는 기종전환 조종사에 대한 학술교육 및 비행훈련을 실시한다.","doWork":"운항규정·항공법 등 관계규정을 강의한다. 항공기의 각 시스템의 구조와 작동원리에 대하여 강의한다. 항공기의 비행이론에 대하여 강의한다. 엔진시동·지상주행·이륙·상승·순항·강하·착륙에 이르는 모든 비행단계에서 항공기의 실제 조종방법에 대하여 강의한다. 항공기 시스템의 일부결함, 기상불량 등 비정상 상황하에서 항공기 조종방법을 강의한다. 항공기 모의조종장치를 사용하여 단계별 혹은 각 비정상 상황별로 조종훈련을 실시한다. 항공기에 탑승하여 실제 조종훈련을 실시한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"손사용|언어력|시각|","workFunc1":"분석","workFunc2":"교육","workFunc3":"조작운전","certLic":"운송용조종사, 사업용조종사, 자가용조종사, 경량항공기조종사, 부조종사","dJobECd":"6211","dJobECdNm":"[6211]항공기 조종사","dJobJCd":"2381","dJobJCdNm":"[2381]항공기 조종사","dJobICd":"H511/H512","dJobICdNm":"[H511]항공 여객 운송업 / [H512]항공 화물 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006809:1', '{"dJobCd":"K000006809","dJobCdSeq":"1","dJobNm":"시험비행조종사","workSum":"항공기의 감항성(Airworthiness:비행에 적합한 항공기의 안전성 및 신뢰성)을 확인하기 위하여 새로 개발된 항공기, 실험용 항공기, 정비된 항공기를 조종하며 시험·평가한다.","doWork":"조종석에 앉아 연료량 및 각종 계기판을 살피고 조종간이 잘 움직이는지 체크한다. 엔진을 시동시켜 가열하고 여러 단계의 속도에서 나는 엔진소리를 듣고 고장을 찾아내기 위하여 계기를 관찰한다. 조종간, 제동기 및 완충기를 테스트하기 위하여 서서히 활주시킨다. 무선통신을 통해 관제탑의 이륙지시를 받고 브레이크를 풀어준 후, 비행기를 이륙하기 위하여 트로틀 및 기타 조종장치를 작동시킨다. 이륙 후 비행기를 실제속도, 강하, 활동, 회전, 활주와 같은 방향조정을 통하여 안전성·조종특성 및 공기역학상의 설계를 시험·평가한다. 상공까지 올라가 음속을 돌파하고 초음속 상태에서 기체의 이상 여부를 체크하고, 약간 낮은 높이에 내려와서는 수차례 비행을 통해 엔진 이상 유무를 확인한다. 더 낮은 높이에서는 비행 중 엔진을 껐다가 다시 작동하는 시험을 통해 시동이 꺼지는 등의 비상사태에 대처할 수 있는 능력 등을 테스트한다. 항목별 테스트를 한 뒤 착륙할 때 드래그 슈트(Drag Chute:고속항공기가 착륙할 때 활주거리를 단축하기 위해 사용하는 낙하산)가 제대로 펴지는지 확인하기도 한다. 수시로 기록계기 및 조종계기를 관찰하면서 비행기의 성능을 평가한다. 착륙 후 시험결과에 관한 보고서를 제출한다. 이상이 있으면 부품의 수정 또는 교체에 필요한 지시를 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"조작운전","similarNm":"시험비행파일럿, 정비창시험비행조종사, 테스트파일럿","certLic":"운송용조종사, 사업용조종사, 자가용조종사, 경량항공기조종사, 부조종사","dJobECd":"6211","dJobECdNm":"[6211]항공기 조종사","dJobJCd":"2381","dJobJCdNm":"[2381]항공기 조종사","dJobICd":"C313","dJobICdNm":"[C313]항공기, 우주선 및 부품 제조업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007552:1', '{"dJobCd":"K000007552","dJobCdSeq":"1","dJobNm":"항공기조종사","workSum":"여객 및 화물을 목적지까지 운송하기 위하여 항공기를 조종한다.","doWork":"비행스케줄에 따라 항로, 목적지, 승객 수, 연료량, 기상조건 등이 적혀진 비행관계서류를 수령한다. 비행노선 및 도착공항 정보가 있는 비디오를 시청한다. 비행관계 서류를 검토하고 운항 시 주의사항, 사전에 확인해야 할 항목을 점검한다. 비행일지, 항공기 상태, 연료의 탑재량, 조종실 시스템 등을 점검한다. 비행시간, 비행조건, 난기류 지역 및 시간 등의 비행 일정 및 계획에 대하여 항공기객실승무원과 의논한다. 승객탑승 완료 후 탑승인원을 확인하고 항로, 항공기 하중 등 각종 비행 자료를 컴퓨터에 입력한다. 이륙 허가를 받기 위해 목적지, 항로 및 소속 항공사 등을 관제탑에 보고한다. 활주로에 진입 후 이륙하고, 이륙 후 관제탑에 보고한다. 기상도 및 기상레이더를 비교 확인하고 고도계 등을 점검하며 자동조종장치를 조정한다. 착륙안내방송 및 승무원에게 착륙 준비를 지시한다. 착륙공항의 기상상태, 접근절차, 비행장시설, 주기장 활주경로 등을 브리핑한 후 착륙허가를 받고 착륙한다. 항공기 비행시간, 비행구간별 연료소모량, 항로, 풍속 등을 운항일지에 기록한다. 비행 중에 발생한 각종 설비고장 및 이상현상에 대해 보고한다. 새로운 항공기 기종에 대하여 적응 훈련을 받고 기술을 습득한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"조작운전","similarNm":"항공기파일럿","connectJob":"책임영역에 따라 항공기기장, 항공기부기장 , 경비행기조종사","certLic":"운송용조종사, 사업용조종사, 자가용조종사, 경량항공기조종사, 부조종사","dJobECd":"6211","dJobECdNm":"[6211]항공기 조종사","dJobJCd":"2381","dJobJCdNm":"[2381]항공기 조종사","dJobICd":"H511/H512","dJobICdNm":"[H511]항공 여객 운송업 / [H512]항공 화물 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004204:1', '{"dJobCd":"K000004204","dJobCdSeq":"1","dJobNm":"헬기조종사","workSum":"각종 운행장비를 확인하고 조정간을 조작하여 헬기를 조종한다.","doWork":"운항 부장으로부터 운항지시를 받는다. 각종 계기판의 안전점검을 실시한다. 이륙을 위하여 배터리와 발전기를 켠다. 각종 파워시스템(하이드롤릭, 오일, 연료)을 작동시킨다. 통신장비를 체크한다. 계기판을 점검한다. 스타트를 하고, 토크, 엔진의 분당회전속도(rpm)의 정상 여부를 체크한다. 분당회전속도(rpm) 조절 그립을 연다. 버닝 및 점화한다. 분당 회전 속도가 최대에 이르면 종합적으로 이륙을 점검한다. 조종간을 상방향으로 하고 우측 페달에 압력을 서서히 가하여 이륙하고 조종간을 조정하여 비행한다. 착륙지에 도착하면 착륙 전 점검을 하고 목표물을 판단 접지한다. 검열심사(조종사 연간 표준화평가) 및 안전교육(안전관리자격증을 소지한 조종사가 교육함)을 하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"조작운전","similarNm":"헬리콥터조종사, 헬기파일럿","connectJob":"헬리콥터시험조종사, 소방헬기조종사, 방송헬기조종사, 산림방제조종사","certLic":"운송용조종사, 사업용조종사, 자가용조종사, 경량항공기조종사, 부조종사","dJobECd":"6211","dJobECdNm":"[6211]항공기 조종사","dJobJCd":"2381","dJobJCdNm":"[2381]항공기 조종사","dJobICd":"H511/H512","dJobICdNm":"[H511]항공 여객 운송업 / [H512]항공 화물 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003458:1', '{"dJobCd":"K000003458","dJobCdSeq":"1","dJobNm":"도선사","workSum":"항구, 해협 등 연해의 도선구역을 통과하는 선박에 승선하여 입·출항로를 안내 및 지시한다.","doWork":"출항하거나 입항하는 선박의 종류와 규모를 확인한다. 도선선(Pilot Boat)을 타고 도선구역으로 이동한다. 도선할 선박에 승선사다리를 사용하여 승선한다. 도선할 선박의 선장으로부터 업무를 인수·인계 받는다. 항로의 기상, 조류, 암초 등을 고려하여 선박의 항로와 속도를 항해사에게 지시한다. 갑문, 좁은 수로 등을 통과하거나 부두에 접안하는 경우 예인선을 조종하는 선장을 지휘하며 선박의 접안을 돕도록 지시한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"균형감각|청각|손사용|언어력|시각|","workEnv":"위험내재|다습|","workFunc1":"조정","workFunc2":"감독","workFunc3":"수동조작","connectJob":"도크마스터","certLic":"도선사","dJobECd":"6212","dJobECdNm":"[6212]선장, 항해사 및 도선사","dJobJCd":"2382","dJobJCdNm":"[2382]선장·항해사 및 도선사","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005573:1', '{"dJobCd":"K000005573","dJobCdSeq":"1","dJobNm":"선박공무감독","workSum":"육상관리직으로 승선하는 선원의 채용, 교육, 훈련, 승선배치 등의 인사 및 행정업무를 수행한다.","doWork":"선원의 채용을 기획한다. 면접을 보고 선원을 채용한다. 선원 교육·훈련프로그램을 기획한다. 선상 안전 등 선원을 교육 및 훈련시킨다. 선원의 승선과 관련한 배치를 한다. 선박의 보험과 관련된 업무를 하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"선박관리전문가, 해사감독","certLic":"해기사(기관사)","dJobECd":"6212","dJobECdNm":"[6212]선장, 항해사 및 도선사","dJobJCd":"2382","dJobJCdNm":"[2382]선장·항해사 및 도선사","dJobICd":"H501","dJobICdNm":"[H501]해상 운송업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002860:1', '{"dJobCd":"K000002860","dJobCdSeq":"1","dJobNm":"선박기계시운전원","workSum":"선박 및 해양시설에 설치된 각종 선박기계의 원활한 작동을 위하여 시운전하고 시험한다.","doWork":"선박 또는 해양시설의 종류에 따라 기계도면 및 시공지침서를 숙지한다. 시험이나 수리에 필요한 공구류를 준비한다. 기계에 윤활유를 급유한다. 각종 계기를 세팅한다. 기계별로 시운전을 실시하여 작동상태 및 계기를 검사하고 기록한다. 이상 부분을 발견하면 수리하거나 정비를 의뢰한다. 해상시운전(건조된 선박을 바다에서 실제로 운전하는 시험)에 승선하여 개별적인 기기의 종합적 성능을 검증한다. 해상시운전이 완료되면 선주검사관(선주 측 검사관)에게 인계한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"균형감각|청각|손사용|시각|","workEnv":"대기환경미흡|소음·진동|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"시운전하는 기계의 종류에 따라 갑판기계시운전원, 보조기계시운전원","certLic":"기계조립산업기사, 동력기계정비기능사, 해기사(기관사)","dJobECd":"6212","dJobECdNm":"[6212]선장, 항해사 및 도선사","dJobJCd":"2382","dJobJCdNm":"[2382]선장·항해사 및 도선사","dJobICd":"C311","dJobICdNm":"[C311]선박 및 보트 건조업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007469:1', '{"dJobCd":"K000007469","dJobCdSeq":"1","dJobNm":"선박기관사","workSum":"선박의 엔진, 보일러, 갑판의 기계장치 및 전기장치 등을 조작·정비한다.","doWork":"시동전 각종 계기류의 작동상황에 따라 회전속도의 변동, 이상진동, 이상음의 발생, 온도, 배기색의 변동, 윤활유의 소비량 등을 점검한다. 선박기관장의 지시에 따라 선박을 가동하기 위하여 시동을 걸고, 엔진상태를 조절한다. 기관의 주유상태, 보일러의 수압·증기압 등의 상태를 확인한다. 선박의 기계설비를 검사하고 결함이 있는 부품을 교체한다. 기계의 청소, 급유, 검사 또는 수리작업 시 기계의 운전을 정지하거나 동력원에서 작동부분을 차단한다. 항해 중에 소모되는 연료의 양을 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|청각|","workEnv":"대기환경미흡|위험내재|고온|다습|소음·진동|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"선박의 규모에 따라 일등기관사, 이등기관사, 삼등기관사, 승선하는 선박의 종류에 따라 예인선기관사, 준설선기관사","certLic":"해기사(기관사)","dJobECd":"6243","dJobECdNm":"[6243]선박승무원 및 관련 종사원(선박객실 승무원 제외)","dJobJCd":"2382","dJobJCdNm":"[2382]선장·항해사 및 도선사","dJobICd":"H501","dJobICdNm":"[H501]해상 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002264:1', '{"dJobCd":"K000002264","dJobCdSeq":"1","dJobNm":"선박기관시운전원","workSum":"선박 또는 해양시설에 설치된 기관(발전기, 펌프, 엔진, 보일러 등)을 시운전하여 작동상태를 검사한다.","doWork":"선박 또는 해양시설의 종류에 따라 기관도면 및 시공지침서를 숙지한다. 기관시운전을 하기 위하여 기관에 연결된 각종 배관(Piping System)을 점검하고 밸브를 개방한다. 연료공급 장치(Purifier)를 연료탱크에 연결하고 연료를 주입한다. 각종 펌프, 발전기 엔진, 보일러, 기타 계기류, 메인엔진의 상태를 점검하고 시운전한다. 시운전 내용을 기록한다. 해상시운전(건조된 선박을 바다에서 실제로 운전하는 시험)에 승선하여 개별적인 기기의 종합적 성능을 검증한다. 해상시운전이 완료되면 선주검사관(선주 측 검사관)에게 인계한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"균형감각|청각|손사용|시각|","workEnv":"위험내재|고온|소음·진동|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"해기사(기관사)","dJobECd":"6212","dJobECdNm":"[6212]선장, 항해사 및 도선사","dJobJCd":"2382","dJobJCdNm":"[2382]선장·항해사 및 도선사","dJobICd":"C311","dJobICdNm":"[C311]선박 및 보트 건조업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004835:1', '{"dJobCd":"K000004835","dJobCdSeq":"1","dJobNm":"선박기관장","workSum":"선박의 엔진, 보일러, 갑판의 기계장치 및 전기장치를 조작·정비하는 작업원들의 활동을 감독·조정한다.","doWork":"장비의 성능, 안전성, 사용법과 안전사항을 작업시작 전 교육한다. 엔진, 보일러 등의 장비를 검사하여 선박기관사에게 결함이 있는 부품을 수리 또는 교체하도록 지시하고, 관련 서류를 정리한다. 선박을 추진시키기 위하여 엔진을 가동한다. 선박의 속도를 조정하기 위하여 동력전달장치를 조작한다. 갑판, 냉동 및 위생시설, 기계·전기 등의 장비를 검사하거나 보수계획을 수립한다. 항해연료 및 기관실의 용품을 청구하고 관련 자료를 정리한다. 자동화된 선박의 조정실에서 계기를 관찰하여 기관의 가동상태를 점검하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|청각|손사용|언어력|시각|","workEnv":"대기환경미흡|위험내재|고온|다습|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","connectJob":"승선하는 선박의 종류에 따라 예인선기관장, 준설선기관장","certLic":"해기사(기관사)","dJobECd":"6212","dJobECdNm":"[6212]선장, 항해사 및 도선사","dJobJCd":"2382","dJobJCdNm":"[2382]선장·항해사 및 도선사","dJobICd":"H501","dJobICdNm":"[H501]해상 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007181:1', '{"dJobCd":"K000007181","dJobCdSeq":"1","dJobNm":"선장(일반)","workSum":"화물 및 승객운송, 어로를 위하여 항해하는 선박 내의 제반 활동을 지휘·감독·조정한다.","doWork":"항해목적지, 기후, 거리 등을 확인하고 선박의 조정실, 기관실, 통신실 등을 점검한다. 화물의 적재상태, 식료품, 연료 등을 검사하고 승무원을 확인한다. 선내 종사원에게 업무를 분담하고 업무를 지휘한다. 항해도, 나침반, 레이더 및 기타 항해 보조기기를 사용하여 선박의 속도를 조절하고 항로를 지시한다. 승무원 및 승객에게 안전수칙과 절차를 교육하고 운항규정을 준수하는지 확인한다. 화물을 하역하기 위한 계획을 수립하고 작업을 지시한다. 파손부위를 확인하고 수리하도록 지시한다. 선박의 항해에 위험이 발생할 경우 해상보안기관에 통보하고 긴급구조신호를 보낸다. 목적지나 어군에 맞추어 항로를 조정한다. 선박의 운항상태를 점검하고 항해 중에 발생한 상황을 항해일지에 기록한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|청각|손사용|언어력|시각|","workEnv":"위험내재|고온|저온|다습|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"조작운전","connectJob":"승선하는 선박의 종류에 따라 어선선장, 예인선선장, 작업선선장, 준설선선장, 내륙수로선박선장, 특수선박선장","certLic":"해기사(항해사), 선박통신사, 의료관리자","dJobECd":"6212","dJobECdNm":"[6212]선장, 항해사 및 도선사","dJobJCd":"2382","dJobJCdNm":"[2382]선장·항해사 및 도선사","dJobICd":"H501","dJobICdNm":"[H501]해상 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002683:1', '{"dJobCd":"K000002683","dJobCdSeq":"1","dJobNm":"수면비행선박조종사","workSum":"위그선(Wing-ln-Ground Effect Ship:수면비행선박)을 조종한다.","doWork":"출항하는 항구에 따라 항만청 또는 해양경찰청에 출항신고(행선지, 출항시간 및 도착예정시간, 항로 등을 유선, 온라인 및 직접 신고)를 한다. 항만청 또는 해양경찰청에서 날씨 등 출항통제기준에 따라 출항을 허가하면 해양관제에 따라 운항을 시작한다. 다른 나라로 운항하는 경우에는 국제운항선박의 입출항 절차에 따른다. 출항에 앞서 점검기준에 따라 엔진, 조종, 연료, 각종 계기의 이상 유무를 점검한다. 승선인원, 적재화물, 사용연료, 무게 등을 점검하고 안전하게 출항할 수 있도록 준비한다. 엔진을 시동하고 선체를 조종하여 출항한다. 선박의 이동이 빈번한 항구지역을 벗어나 지정된 이수구역으로 이동한다. 이수구역의 표식, 지표를 육안으로 확인하고 주변에 장애물이 있는지 확인한다. 바람이 부는 방향으로 선수를 돌리고(맞바람을 받아 더 쉽게 이수할 수 있도록) 속도를 빠르게 한다. 이수속도에 도달하여 이수한다. GPS 등 각종 항법장치를 이용하여 항로를 설정하고 해상관제의 통제를 받아 수면효과비행(날개 하면이 수면에 가까울수록 양력 극대화, 와류 감소되는 효과 양력을 이용하여 비행)을 한다. 레이더와 육안으로 장애물을 확인하면서 운항한다. 목적지에 도착(입항)한다. 위그선을 계류시키고 하선, 점검, 정비의뢰 및 다음 출항 준비를 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"균형감각|손사용|시각|","workEnv":"다습|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"조작운전","similarNm":"위그선(Wing ln Ground Effect Ship)조종사","certLic":"수면비행선박조종사","dJobECd":"6212","dJobECdNm":"[6212]선장, 항해사 및 도선사","dJobJCd":"2382","dJobJCdNm":"[2382]선장·항해사 및 도선사","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001473:1', '{"dJobCd":"K000001473","dJobCdSeq":"1","dJobNm":"유람선선장","workSum":"승객들의 쾌적한 관광을 위하여 유람선 내의 제반 활동을 지휘·감독·조정한다.","doWork":"유람선 운행일정, 승객 수 등을 확인한다. 날씨, 풍속, 거리 등을 고려하여 운행을 결정하며 운행을 위한 각종 장치의 이상 유무를 보고받고 지시한다. 조종실에서 조타기로 운전한다. 상황에 따라 승객들에게 관광명소의 역사 등을 소개한다. 모니터를 활용하여 안전하게 정박시킨다. 운행일지에 운행거리, 속력, 운행시간 등 운행 중 발생한 상황을 기록한다. 승무원들에게 소방기구사용법 등 안전에 대해 교육한다. 승무원의 복무관계를 총괄한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"조작운전","certLic":"해기사","dJobECd":"6212","dJobECdNm":"[6212]선장, 항해사 및 도선사","dJobJCd":"2382","dJobJCdNm":"[2382]선장·항해사 및 도선사","dJobICd":"H502","dJobICdNm":"[H502]내륙 수상 및 항만 내 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002764:1', '{"dJobCd":"K000002764","dJobCdSeq":"1","dJobNm":"조기장","workSum":"기관원과 조기수를 관리·감독하며 문제 발생 시 1등 기관사에게 보고한다.","doWork":"기관원과 조기수를 관리·감독한다. 당직근무를 한다. 문제점이나 보고사항을 1등 기관사에게 보고한다. 사고, 안전 등 선내문제 등을 시정한다. 입출항과 관련된 작업을 수행한다. 부품 등 재고를 관리한다. 기관장 및 기관사의 지시에 따라 교육훈련을 실시한다. 기관원과 조기수가 수행하는 업무를 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"웅크림|","workEnv":"위험내재|다습|소음·진동|","workFunc1":"수집","workFunc2":"감독","workFunc3":"수동조작","similarNm":"선박부원","dJobECd":"6212","dJobECdNm":"[6212]선장, 항해사 및 도선사","dJobJCd":"2382","dJobJCdNm":"[2382]선장·항해사 및 도선사","dJobICd":"H501","dJobICdNm":"[H501]해상 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001509:1', '{"dJobCd":"K000001509","dJobCdSeq":"1","dJobNm":"항해사","workSum":"선장의 지시에 따라 선박의 항로를 결정하고, 승무원을 지휘·감독하여 항해 안전, 선원의 의료업무, 해상운송 등 갑판업무의 전반을 관리한다.","doWork":"항해 계획을 수립한다. 항해계기를 정비·관리한다. 선원을 지휘·감독하며 선박의 안전관리 및 해상작업의 규율 및 기강을 확립한다. 선박의 안전을 고려한 화물의 적·양하 계획을 수립하고 충분한 복원력 및 선체강도의 확보를 고려한 적·양하 작업 및 이와 관련한 밸러스트(Ballast:배의 중심(重心)을 낮추어 복원력을 증대시키기 위하여 배 밑에 싣는 돌, 모래, 해수 등) 작업을 감독한다. 화물의 고정상태를 점검한다. 유조선의 경우 오일기록부의 기록을 하기도 한다. 의료 및 위생업무를 수행한다. 해도 및 항해계기 등 항해를 위한 준비업무를 수행한다. 항해계기를 관리하고 해도, 수로서지 및 항해 관련 도서를 관리한다. 조타장치를 포함한 항해장비의 적절한 운용 및 관리를 한다. 구명, 안전설비를 점검한다. 선내의 질서를 유지한다. 화물의 선적·하역이나 어로작업을 감독한다. 항해도, 나침반, 레이더 및 기타 항해보조기기를 사용하여 선박의 위치와 항로를 선장과 협의한다. 신호기무선통신설비를 이용하여 다른 선박 또는 육지와 통신한다. 선체나 배의 상부구조, 화물실, 갑판설비를 관리한다. 선장의 지시에 따라 야간근무계획을 수립하고 조종실, 기관실, 갑판 등을 점검한다. 선장의 유고 시 직무를 대행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"균형감각|청각|손사용|언어력|시각|","workEnv":"위험내재|고온|저온|다습|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"조작운전","connectJob":"선박의 규모에 따라 일등항해사, 이등항해사, 삼등항해사","certLic":"항해사(1-6급), 의료관리자, 선박통신사","dJobECd":"6212","dJobECdNm":"[6212]선장, 항해사 및 도선사","dJobJCd":"2382","dJobJCdNm":"[2382]선장·항해사 및 도선사","dJobICd":"H501","dJobICdNm":"[H501]해상 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005698:1', '{"dJobCd":"K000005698","dJobCdSeq":"1","dJobNm":"해양플랜트시운전엔지니어","workSum":"해양플랜트 건조의 마지막 공정으로 설치된 장비 및 운항과 관련된 모든 시스템을 운영하고 발생되는 문제에 대해 보완작업을 진행한다.","doWork":"해양플랜트 건조의 마지막 공정으로 배관, 전장, 의장부서에서 각 부분의 설치 및 검사가 완료되면 선주와 선급의 담당자를 동반하여 장비 및 운항과 관련된 모든 시스템을 시운전한다. 설계단계에 참여하여 현장상황을 반영한 시운전 절차서를 작성하고 마지막 검증에 참여해 시운전 절차서의 완성도를 높인다. 만약 시운전 진행 중 규정에 만족하지 못한 결과가 발생되거나 진행에 문제가 발생하면 이를 해결하기 위해 설계 담당자 및 설치 담당자에게 연락하고 해결방안 제시 및 수정작업이 이루어질 수 있도록 협조한다. 규정 미달로 인한 재검사 진행을 담당하며, 최종 통합 시운전이 이루어질 때까지 모든 시운전 과정의 책임을 맡는다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"청각|손사용|언어력|시각|","workEnv":"위험내재|소음·진동|","workFunc1":"분석","workFunc2":"감독","workFunc3":"제어조작","dJobECd":"6212","dJobECdNm":"[6212]선장, 항해사 및 도선사","dJobJCd":"2382","dJobJCdNm":"[2382]선장·항해사 및 도선사","dJobICd":"C311","dJobICdNm":"[C311]선박 및 보트 건조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005930:1', '{"dJobCd":"K000005930","dJobCdSeq":"1","dJobNm":"우주센터발사지휘통제원","workSum":"우주발사체의 발사준비 진행 과정을 점검하고 발사 및 발사체 추적 지휘 기능을 수행한다.","doWork":"발사 지휘센터, 발사체통제센터, 비행안전통제센터 등 발사 및 발사체 추적과 관련된 통제시설에서 발사 임무와 관련된 운용 작업을 총괄 지휘한다. 발사지휘센터(MDC:Mission Director Center)의 통제원은 우주센터의 발사 임무를 총괄 지휘·통제하고 발사체통제센터(LCC)의 발사준비 상황, 해상 및 공중의 안전통제정보, 기상정보, 비행경로 추적 장비 및 운용자 준비상황 등의 발사업무 연계상황을 종합적으로 판단하여 최종 발사 여부를 결정한다. 발사체통제센터(LCC;Launcher Control Center)의 통제원은 우주발사체와 위성의 조립, 시험 및 연료 공급과 같은 발사 준비 작업을 단계별로 확인하여 운용상황을 발사지휘센터(MDC)로 보고하고 발사지휘센터의 최종 결정에 따라 발사작업을 진행한다. 비행안전통제센터(FSC:Flight Safety Center)의 통제원은 우주발사체가 비행을 시작한 직후부터 임무 종료까지 비행 안전과 관련된 모든 업무를 다른 운용실의 간섭 없이 독자적으로 처리한다. 이를 위해 실시간으로 우주발사체의 상태 정보 및 비행 상황 정보를 감시하면서 문제가 발생되면 비행종단지령장비(FTS:Flight Termination System)를 이용하여 우주 발사체의 비행을 강제적으로 종료시키는 임무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"협의","workFunc3":"정밀작업","dJobECd":"6214","dJobECdNm":"[6214]관제사","dJobJCd":"2383","dJobJCdNm":"[2383]관제사","dJobICd":"H512","dJobICdNm":"[H512]항공 화물 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007515:1', '{"dJobCd":"K000007515","dJobCdSeq":"1","dJobNm":"철도교통관제사","workSum":"철도교통관제 센터에서 열차통제, 운행스케줄 조정 등 관제업무를 수행한다.","doWork":"열차의 정상적인 운행을 위하여 일상적인 운행정리업무를 한다. 수송질서 혼란 시 열차의 운행을 통제하고 조정한다. 재해 사고를 포함하여 운전사고 발생 시 최초 상황을 조사하고 운행중지, 우회운전 등 열차운행에 관한 조치를 한다. 기상상황을 파악하고 이에 대한 조치를 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"철도교통관제사","dJobECd":"6214","dJobECdNm":"[6214]관제사","dJobJCd":"2383","dJobJCdNm":"[2383]관제사","dJobICd":"H491","dJobICdNm":"[H491]철도 운송업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007489:1', '{"dJobCd":"K000007489","dJobCdSeq":"1","dJobNm":"항공교통관제사","workSum":"항공기의 충돌을 방지하고, 항공기가 안전하고 효율적인 운항할 수 있도록 이·착륙과 비행 경로를 통제한다.","doWork":"교신장비와 감시 장비(레이더 등)를 활용하여 항공기의 위치와 이동 상황을 실시간으로 파악하고, 항공기의 안전한 운항을 위한 관제지시를 수행한다. 비행장관제사는 관제탑에서 항공기의 비행계획과 공항 주변의 기상 상태를 확인하고, 이·착륙 하려는 항공기 조종사와 교신하여 이·착륙 활주로, 순서, 예정시간 등을 배정하고 유도한다. 접근관제사는 공항 인근의 항공기 위치와 고도를 모니터링하며 고도 상승·강하를 지시하고 안전한 접근 경로를 제공한다. 항로관제사는 항로상에서 순항 중인 항공기를 관제하며, 항공기 간 충돌을 방지하기 위해 비행 고도와 속도, 방향을 조정한다.  관련 기관과 협조해 관제 대상 항공기의 정보를 수집하고, 비상상황 발생 시 적절한 대응을 위해 비상 착륙 절차 및 비상 활주로 정보를 제공한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"청각|손사용|언어력|시각|","workEnv":"대기환경미흡|소음·진동|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"제어조작","connectJob":"계류장관제사","certLic":"항공교통관제사","dJobECd":"6214","dJobECdNm":"[6214]관제사","dJobJCd":"2383","dJobJCdNm":"[2383]관제사","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006967:1', '{"dJobCd":"K000006967","dJobCdSeq":"1","dJobNm":"해상교통관제사","workSum":"지정된 수로범위 내에서 근해와 내륙 해양교통을 모니터하고 규제한다.","doWork":"레이더나 폐쇄회로모니터, 원격무전시스템 및 기타 통신장비를 이용하여 선박의 이동을 지휘하고 감시한다. 선박의 위치, 항로, 속도 및 추정도착시간과 통행지역을 통과하는 선박의 진행과정을 감시한다. 선박에게 출항인가를 내고 선박교통량, 기후조건에 대해 조언하며 선박교통 관제소에 대한 정보를 전해준다. 관계자에게 사고, 조난 신호, 항해 위험 및 기타 비상사태에 대하여 보고한다. 인근 해양관제구역과 관할권 내의 선박들과 무전 및 전화연결을 유지한다. 항해일지에 선박이동, 크기 및 구조에 대하여 기록하고 보관한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"선박교통관제사","certLic":"해기사(항해사, 선박통신사)","dJobECd":"6214","dJobECdNm":"[6214]관제사","dJobJCd":"2383","dJobJCdNm":"[2383]관제사","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001324:1', '{"dJobCd":"K000001324","dJobCdSeq":"1","dJobNm":"곤충식품연구원","workSum":"곤충을 원료로 식품을 제조하기 위해 곤충성분, 가공법 등을 연구·개발한다.","doWork":"곤충을 식품으로 이용하기 위해 섭취 가능한 곤충의 종류, 사례와 영양학적 가치, 인체에 유효한 성분 등의 정보를 수집하고 분석한다. 해외사례를 수집하고 식용으로 가공이 허용된 곤충의 물성을 연구하여 액상, 추출, 유지 등의 식품원료화를 위한 물리적인 가공기술 및 이화학적 가공기술을 연구한다. 조리적용을 위한 식용곤충의 특성 탐색 및 기반기술을 연구한다. 식용곤충과 식용곤충을 가공한 식품원료 등의 포장 및 유통기술을 연구·개발하고 시장 현황 및 식용곤충의 인식개선과 혐오감을 줄이는 마케팅 방법을 연구한다. 문화권별 음식 조리법과 식용곤충 함량 증가를 위한 기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"식품기술사, 식품기사, 식품산업기사, 식육가공기사, 축산기사","dJobECd":"1571","dJobECdNm":"[1571]식품공학 기술자 및 연구원","dJobJCd":"2391","dJobJCdNm":"[2391]식품공학 기술자 및 연구원","dJobICd":"C107/M701","dJobICdNm":"[C107]기타 식품 제조업 / [M701]자연과학 및 공학 연구개발업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007804:1', '{"dJobCd":"K000007804","dJobCdSeq":"1","dJobNm":"기능성식품연구원","workSum":"결핍되기 쉬운 영양소 또는 인체에 유용한 기능을 가진 원료나 성분을 사용하여 건강을 유지하는데 도움을 주는 건강기능성식품을 연구·개발한다.","doWork":"보건학적 중요성 및 문헌 조사, 시장 조사에 기반하여 목적 기능성과 대상 원료를 설정한다. 기능성 원료에 대한 과학적 근거 확보를 위해 표준화, 기능성, 안전성 연구 및 설계한다. 원재료 확보, 추출, 농축, 분리, 정제, 대량생산, 지표성분, 영양성분 분석, 유해 물질 규격 설정 및 저장안정성 등의 표준화 연구를 통해 기능성 원료에 대한 품질관리를 한다. 연구유형별(세포, 동물 및 인체적용시험) 바이오마커 및 실험계 설정, 유효성 평가를 통해 원료의 기능성에 대한 과학적 근거를 도출한다. 원료섭취량 평가, 단회투여독성, 반복투여독성, 유전독성 평가를 통해 식경험 부재 및 섭취량 증가 기능성 원료에 대한 안전성을 검증한다. 건강기능식품 법률 기준을 충족하는 기능성 원료를 이용하여 음료, 정제, 캡슐, 환, 과립, 액상, 분말, 편상, 페이스트, 시럽, 젤리, 바, 필름 등 최종 소비 형태의 건강기능식품을 개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"자문","workFunc3":"제어조작","similarNm":"식품연구원, 식품연구기능원, 식품연구기술원, 식품전문연구원","connectJob":"식품기능성평가연구원, 식품안전성평가연구원, 기능성원료표준화연구원, 기능성원료생산연구원","certLic":"식품기술사, 식품기사, 식품산업기사, 식품가공기능사, 식품영양사","dJobECd":"1571","dJobECdNm":"[1571]식품공학 기술자 및 연구원","dJobJCd":"2391","dJobJCdNm":"[2391]식품공학 기술자 및 연구원","dJobICd":"C107/M701","dJobICdNm":"[C107]기타 식품 제조업 / [M701]자연과학 및 공학 연구개발업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002838:1', '{"dJobCd":"K000002838","dJobCdSeq":"1","dJobNm":"담배신제품개발원","workSum":"새로운 종류의 담배개발, 기존 담배의 품질개선, 담배제조공정을 연구하여 유해성 및 원가절감을 한다.","doWork":"세계적으로 판매되고 있는 담배의 수집 및 분석과 우리의 기술을 근거로 하여 새로운 담배를 개발하여 애연가의 기호나 추세에 맞는 담배를 제조한다. 애연가의 기호추세에 대처하고 기존 제품의 품질을 향상시키기 위하여 향료, 당류, 보습제, 각종 추출물 등 담배용 첨가제를 첨가하고 각종 측정 장치를 이용하여 측정·개선한다. 새로운 담배제조공정의 개발과 기존 공정의 개선으로 원가절감 및 품질향상과 작업성을 향상시킨다. 각종 향료에 대한 연구를 하여 담배에 사용할 수 있는 향료물질을 개발한다. 담배제품에 소요되는 필터, 지류 등의 물질에 대하여 물리·화학적인 검사를 하여 실용적인 제품을 개발한다. 담배연기가 인체에 미치는 영향을 연구하여 유해한 물질을 최소화하는 연구를 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|다습|소음·진동|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"담배신제품개발기술자, 담배신제품개발연구원","dJobECd":"1571","dJobECdNm":"[1571]식품공학 기술자 및 연구원","dJobJCd":"2391","dJobJCdNm":"[2391]식품공학 기술자 및 연구원","dJobICd":"C120","dJobICdNm":"[C120]담배 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002584:1', '{"dJobCd":"K000002584","dJobCdSeq":"1","dJobNm":"담배제품연구원","workSum":"담배제품의 개발을 위하여 담배원료, 담배재료 및 향료, 화학성분, 원료잎담배 배합 등에 관하여 시험·연구한다.","doWork":"산지별 잎담배를 수집하고 분석기기를 사용하여 산지별, 품종별, 엽분별 등 이화학적 특성을 분석한다. 제조과정에서 나오는 부산물의 이용방법, 잎담배 조기저장 숙성을 위한 효소 발굴 및 이용에 관해 시험·연구한다. 담배의 향미와 품질의 종류에 따라 엽배합 비율을 연구·개발한다. 담배의 품질에 영향을 미치는 필터의 종합적 설계방법에 관한 연구를 한다. 담배향료 개발 및 유기산이 담배품질에 미치는 영향을 연구한다. 품질개선 및 관리를 위하여 담배에 함유되어 있는 니코틴, 전당, 전질소, 조섬유, 조회분, 조지방 등의 화학성분 및 담배연기 중의 타르, 니코틴, 일산화탄소 등을 분석한다. 원료가공에 관한 공정기술을 개선하거나 경제적 효율을 높일 수 있는 신기술을 개발한다. 연구·개발된 기술을 현장에 보급하고 교육한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1571","dJobECdNm":"[1571]식품공학 기술자 및 연구원","dJobJCd":"2391","dJobJCdNm":"[2391]식품공학 기술자 및 연구원","dJobICd":"C120","dJobICdNm":"[C120]담배 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007811:1', '{"dJobCd":"K000007811","dJobCdSeq":"1","dJobNm":"세포배양기반대체식품연구원","workSum":"육류 단백질을 대체하기 위하여 동물유래 세포를 배양하여 대체식품 제조 기술을 연구하고 제품을 개발한다.","doWork":"풍미, 식감, 육즙 등 실제고기와 같은 세포배양 식품을 대량생산하기 위한 기술을 연구한다. 세포배양식품 개발에 필요한 세포를 동물 및 해산물로부터 확보 및 증식시키고 필요한 경우 세포의 증식능을 높이기 위하여 불멸화한다. 세포배양에 필수적인 가식성 지지체를 개발한다. 세포배양식품 산업화를 위한 단가절감을 위해 소태아혈청(FBS)을 대체하기 위한 신규 배양액 및 세포를 대량으로 배양하기 위한 배양방법을 개발한다. 개발된 세포배양식품의 풍미를 높힐 수 있는 천연첨가물 개발 및 가공제품 등을 개발한다. 제조된 완제품의 소비자 기호도 조사를 실시하여 제품을 개선한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"위험내재|","workFunc1":"조정","workFunc2":"자문","workFunc3":"정밀작업","similarNm":"식품연구원, 가공식품연구원","connectJob":"대체단백질연구원, 대체지방연구원, 세포배양기조작원, 대체식품향미개선연구원","certLic":"식품기술사, 식품기사, 식품산업기사, 식품가공기능사, 식품영양사","dJobECd":"1571","dJobECdNm":"[1571]식품공학 기술자 및 연구원","dJobJCd":"2391","dJobJCdNm":"[2391]식품공학 기술자 및 연구원","dJobICd":"C107/M701","dJobICdNm":"[C107]기타 식품 제조업 / [M701]자연과학 및 공학 연구개발업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002107:1', '{"dJobCd":"K000002107","dJobCdSeq":"1","dJobNm":"수산식품위생연구원","workSum":"수산물 및 수산제품의 섭취에 따른 위해성 여부를 밝히기 위하여 수산물에 대해 미생물학적 시험연구, 독성연구, 그리고 수산물의 물질 오염조사를 한다.","doWork":"대상 시료를 바다, 강, 호수 등에서 채취한다. 액체크로마토그래프, 가스크로마토그래프, 유도결합플라스마, 세균동정기 등을 사용하여 패류독소, 항생물질의 정량 및 정석분석한다. 지방산, 유기산, 당 등의 정량 및 정성분석, 중금속, 무기질의 정량, 균의 분리 및 동정 등을 시험·분석한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"수산제조기술사, 수산제조기사, 수산물품질관리사, 위생사","dJobECd":"1571","dJobECdNm":"[1571]식품공학 기술자 및 연구원","dJobJCd":"2391","dJobJCdNm":"[2391]식품공학 기술자 및 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007805:1', '{"dJobCd":"K000007805","dJobCdSeq":"1","dJobNm":"식물기반대체식품연구원","workSum":"육류 단백질을 대체하기 위하여 식물 유래의 단백질과 지방을 활용한 식물 기반의 대체식품 제조 기술을 연구하고 제품을 개발한다.","doWork":"콩, 쌀, 감자 등의 식물, 해조류 등에서 식물성 단백질 성분의 추출과 분리, 기능화, 포뮬러화한다. 식물기반대체식품의 풍미를 향상시킬 수 있는 천연첨가물을 개발한다. 식물기반 단백질에 지방, 유지, 색소, 기타 첨가물 등의 부재료를 투입하여 맛과 향 등을 향상시켜 완제품을 제조한다. 제조된 완제품의 소비자 기호도 조사를 실시하여 제품을 개선한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"위험내재|","workFunc1":"조정","workFunc2":"자문","workFunc3":"정밀작업","similarNm":"식품연구원, 가공식품연구원","connectJob":"대체단백질연구원, 대체지방연구원, TVP(Textured Vegetable Protein)연구원, Extruder조작원, 해조류식품연구원, 대체식품향미개선연구원","certLic":"식품기술사, 식품기사, 식품산업기사, 식품가공기능사, 식품영양사","dJobECd":"1571","dJobECdNm":"[1571]식품공학 기술자 및 연구원","dJobJCd":"2391","dJobJCdNm":"[2391]식품공학 기술자 및 연구원","dJobICd":"C107/M701","dJobICdNm":"[C107]기타 식품 제조업 / [M701]자연과학 및 공학 연구개발업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001474:1', '{"dJobCd":"K000001474","dJobCdSeq":"1","dJobNm":"식품가공연구원","workSum":"농산물, 축산물, 수산물 등의 식품원료에 영양학적·미각적·시각적 특징을 부여하고, 소비자의 감성이나 행동유형에 대처하여 가공식품을 연구·개발한다.","doWork":"각종 식품원료를 목적에 맞게 혼합하여 가공 적성(알맞은 성질이나 적응능력),형태 및 우수품질 조건을 탐색한다. 식품을 장기간 저장할 수 있도록 살균·처리한다. 제품의 특성에 따라 맛, 향, 색상, 모양, 포장방법 등을 고려하여 제품을 개발한다. 맛과 향에 대해 관능검사(오감에 따라 품질 평가)를 한다. 새로운 맛의 제품을 개발하기 위해 제조방법, 발효 정도, 형태, 지역 등을 고려하여 연구한다. 시험장비를 사용하여 제품의 주요성분을 실험하고, 결과를 분석한다. 각종 가공기기를 사용하여 가열, 혼합, 절단, 수세, 추출, 압출 등의 공정을 연구·개발한다. 기타 연구원들이 수행하는 일반적인 활동을 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"제과연구원, 제빵연구원, 케이크연구원, 비스킷연구원, 아이스크림연구원, 음료연구원, 초콜릿연구원, 캔디연구원, 녹차연구원, 기능성식품연구원","certLic":"식품기술사, 식품기사, 식품산업기사, 수산제조기술사, 수산제조기사, 수산물품질관리사, 식육가공기사, 유기농업기사","dJobECd":"1571","dJobECdNm":"[1571]식품공학 기술자 및 연구원","dJobJCd":"2391","dJobJCdNm":"[2391]식품공학 기술자 및 연구원","dJobICd":"C107/M701","dJobICdNm":"[C107]기타 식품 제조업 / [M701]자연과학 및 공학 연구개발업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006872:1', '{"dJobCd":"K000006872","dJobCdSeq":"1","dJobNm":"식품미생물공학연구원","workSum":"미생물로부터 생성되는 효소, 천연색소. 식품첨가물 및 생리활성 물질 등 식품산업 유용소재 생산을 위한 대사작용을 유도 또는 설계하고, 그 특성을 조사하여 새로운 식품에 적용하는 기술을 연구·개발한다.","doWork":"목적하는 물질 또는 활성을 나타내는 균주를 발효식품, 토양 등 다양한 급원으로부터 선별·동정한다. 식품의 용도에 적합한 소재 생산균주를 선별 또는 변이시켜 고생산균주를 확보하고 배지를 조성하여 성장조건 및 생산 조건을 연구한다. 적응 진화 또는 유전자 조작기법을 통하여 균주를 개량함으로써 목적물질의 생성능력 및 생산성을 증진시킨다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"정밀발효연구원, 시스템생물학연구원","dJobECd":"1571","dJobECdNm":"[1571]식품공학 기술자 및 연구원","dJobJCd":"2391","dJobJCdNm":"[2391]식품공학 기술자 및 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006418:1', '{"dJobCd":"K000006418","dJobCdSeq":"1","dJobNm":"식품미생물응용연구원","workSum":"유산균, 효모 등 식품에 활용할 수 있는 유익한 미생물을 분리・동정・보관하고, 이에 대한 발효 활성 및 건강기능성 평가를 통하여 적정 미생물을 선발하고 응용식품 개발 및 기타 산업응용에 관하여 연구한다.","doWork":"식품에 활용할 수 있는 유용 미생물을 수집(분리・동정・저장)하고, 미생물의 고유 특성(성상, 생장특성 등) 조사 한다. 기능적 특성(내산성, 내답즙성, 내열성 등)을 연구한다. 각 유용 미생물이 갖는 건강기능성(항산화, 장 기능개선, 면역활성 등)을 규명한다. 발효 적성 등을 조사하여 적정 종균 선별 및 배양조건을 연구・개발한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"발효유개발원","certLic":"식품기술사, 식품기사, 식품산업기사","dJobECd":"1571","dJobECdNm":"[1571]식품공학 기술자 및 연구원","dJobJCd":"2391","dJobJCdNm":"[2391]식품공학 기술자 및 연구원","dJobICd":"C105","dJobICdNm":"[C105]낙농제품 및 식용빙과류 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007233:1', '{"dJobCd":"K000007233","dJobCdSeq":"1","dJobNm":"식품분석연구원","workSum":"식품재료 및 제품의 안전성 및 영양성분을 분석기기를 이용하여 분석·연구한다.","doWork":"식품의 원료, 제조·가공·조리 및 유통 등 전 과정에서 위해물질 등 안정성과 영양성분을 분석한다. 식품 중의 비타민류, 당류, 핵산류, 유기산류 및 지방산 등을 분석한다. 식품원료인 농산물의 잔류농약에 대한 정성·정량분석을 실시한다. 엑기스 등 용매추출 제품의 잔류용매를 분석하고 제품생성 시 부반응으로 생성되는 위해물질의 잔류량을 분석한다. 향신료 식품에 대하여 향미 및 이취 분석 등 휘발성 성분을 분석한다. 식품, 원료 및 수질 중의 비소, 납을 비롯한 중금속과 미네랄 성분을 분석한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"품질관리기술사, 품질경영기사, 수산물품질관리사, 농산물품질관리사, 식품기사","dJobECd":"1571","dJobECdNm":"[1571]식품공학 기술자 및 연구원","dJobJCd":"2391","dJobJCdNm":"[2391]식품공학 기술자 및 연구원","dJobICd":"C107/M701","dJobICdNm":"[C107]기타 식품 제조업 / [M701]자연과학 및 공학 연구개발업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002847:1', '{"dJobCd":"K000002847","dJobCdSeq":"1","dJobNm":"식품연구원(일반)","workSum":"시장이 요구하는 식품을 개발 및 개선하기 위해 제품 개발 계획 수립, 제조 공정 및 규격 설계, 안전성 및 안정성 평가 등 연구, 시험분석, 설계 및 개발 업무를 한다.","doWork":"시장정보수집과 시장조사를 통하여 조사 결과를 분석하고 개발 목표를 설정한다. 개발계획수립을 위해 기술, 시장성, 사업성을 평가한다. 실험 설계, 배합비 개발, 공정 개발, 포장 개발, 살균 공정 개발하고 시제품을 설계한다. 활용장비를 검토하고, 배합원료의 특성·물성을 검토하여 시제품을 생산한다. 관능평가, 이화학·미생물학적 평가, 시제품 규격 적합 여부평가 등 시제품을 평가한다. 설비 설정, 레이아웃 설정, 생산조건을 설정 등 공정 요건을 설정한다. 원료 규격 설정, 부자재 규격 설정, 최종상품 규격 설정 등 규격을 설정한다. 개발 상품의 가치 평가를 위하여 평가 요소 설계, 평가결과 분석 등 상품성을 평가한다. 생산부문 지원, 관리부문 지원, 영업부문 지원을 하기 위한 기술이관 업무를 한다. 제품 개선을 위한 개선점을 파악？분석하여 공정과 기준 규격 표준화 등 식품품질개선 업무를 한다. 선행 기술분석을 통해 차별화된 소재 및 완제품에 관한 기술 트렌드를 분석하고, 기초 연구와 응용연구를 수행한다. 제품 고유의 특성을 확인하기 위하여 물리적, 화학적, 생물학적 분석과 보존성을 검사한다.  식품의 안전성 및 법정 기준을 충족시키기 위하여 재료 적법성과 위해요소를 확인하고 독성검사 등 재료 안전성검사를 한다. 창의적이고 경쟁력 있는 신제품 개발을 위하여 기술평가를 실시하고 목표기술을 설정하는 선행기술조사연구를 한다. 연구실에서 소규모로 제조한 표준 시제품에 대한 제품 생산 시 설비？공정 및 배합비 보완 사항 등의 이상유무 점검을 위하여 제조현장에서 시생산 테스트를 실시한다. 관능평가, 이화학·미생물학적 평가, 표준시제품과 시생산제품 규격 적합여부 비교 등 시생산제품을 평가한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"식품기술사, 식품기사, 식품산업기사, 수산제조기술사, 수산제조기사, 수산물품질관리사, 농산물품질관리사, 식육가공기사, 축산기사, 유기농업기사","dJobECd":"1571","dJobECdNm":"[1571]식품공학 기술자 및 연구원","dJobJCd":"2391","dJobJCdNm":"[2391]식품공학 기술자 및 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006165:1', '{"dJobCd":"K000006165","dJobCdSeq":"1","dJobNm":"식품영양연구원","workSum":"각종 식품에 함유된 영양소를 분석하고 국민의 영양상태 유지, 개선을 위한 제반 연구를 수행한다.","doWork":"식생활 습관 등에 대한 각종 조사를 통해서 국민들의 영양상태를 파악하고 조사내용을 분석한다. 결과에 대해서 보고서를 작성하고 관련 기관이나 학교에 제공한다. 문제가 되는 특정식품과 관련된 규격기준 및 식생활지침에 대해 연구한다. 식품영양성분, 외식의 표준영양소함량 등에 대한 관련 연구를 수행하며 필요한 데이터베이스를 개발·관리한다. 식품산업체에 식품영양에 대해 조언하기도 하며 정부 및 관련 위생안전기관에 기술자문을 수행하기도 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"영양사, 위생사, 식품기사","dJobECd":"1571","dJobECdNm":"[1571]식품공학 기술자 및 연구원","dJobJCd":"2391","dJobJCdNm":"[2391]식품공학 기술자 및 연구원","dJobICd":"C107/M701","dJobICdNm":"[C107]기타 식품 제조업 / [M701]자연과학 및 공학 연구개발업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001618:1', '{"dJobCd":"K000001618","dJobCdSeq":"1","dJobNm":"식품재료연구원","workSum":"식품재료가 식품제조에 활용되고 안전하게 소비될 수 있도록 식품재료를 가공하고 품질을 시험·연구한다.","doWork":"식품재료의 구조 및 특성에 따라 추출, 분리, 정제, 반응, 발효 등의 공정을 수립하고 저장성, 안전성 및 안정성을 실험한다. 식품재료에 대한 각종 처리 및 공정기술을 연구·개발한다. 생산된 식품이 소비단계에서 안전성을 확보할 수 있도록 산화안정성, 미생물안정성, 일반성분분석 등에 대한 실험을 실시한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"품질경영기사, 품질관리기술사, 수산물품질관리사, 식품기술사, 식품기사","dJobECd":"1571","dJobECdNm":"[1571]식품공학 기술자 및 연구원","dJobJCd":"2391","dJobJCdNm":"[2391]식품공학 기술자 및 연구원","dJobICd":"C107/M701","dJobICdNm":"[C107]기타 식품 제조업 / [M701]자연과학 및 공학 연구개발업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007803:1', '{"dJobCd":"K000007803","dJobCdSeq":"1","dJobNm":"식품향미소재개발연구원","workSum":"식품의 향미를 개선 및 모사하는 유사 향미소재를 개발하고, 천연 및 화학적 합성, 미생물 이용 등을 통해 향미를 구현 및 평가한다.","doWork":"맛과 향의 생성 기전을 연구하고 향미 구현·포집·제형화한다. 식품의 이미, 이취를 개선하거나 식품 본연의 향을 증진 또는 모사할 수 있는 유사 향미소재를 개발한다. 천연 소재를 추출, 압착, 가열 등의 물리·이화학적 가공하거나 화학적 합성반응을 통해 개발하고 또는 미생물을 이용하여 생물학적 합성하여 개발한다. 식품의 온도, 영양성분, 저장 및 유통 조건 등에 따라 향미 특성이 발현되는 특성을 연구하고 사람의 감각 및 정밀기기분석 등을 이용하여 정성 및 정량적으로 평가한다. 대체식품 개발 시 대체소재에서 유래하는 이미, 이취를 제어하고 목표 식품의 향미를 재현하여 개발한다. 심리학, 식문화, 생리학 등의 지식을 바탕으로 사람이 인지하는 향미 특성 및 수준을 평가한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"종합","workFunc2":"자문","workFunc3":"정밀작업","similarNm":"식품향료연구원, 식품가공연구원","connectJob":"식품향료조향사, 향미평가사, 관능평가조사자, 식품분석연구원, 식품공학기술자, 식품가공연구원","certLic":"식품기술사, 식품기사, 식품산업기사, 조향사, 식품분석전문가","dJobECd":"1571","dJobECdNm":"[1571]식품공학 기술자 및 연구원","dJobJCd":"2391","dJobJCdNm":"[2391]식품공학 기술자 및 연구원","dJobICd":"C107/M701","dJobICdNm":"[C107]기타 식품 제조업 / [M701]자연과학 및 공학 연구개발업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006110:1', '{"dJobCd":"K000006110","dJobCdSeq":"1","dJobNm":"음식료품개발원","workSum":"신제품 컨셉 기획 및 개발 또는 제품을 개선하고자 각종 음식료품을 시험·분석하고 배합비 및 생산 기술을 개발한다.","doWork":"신제품을 개발하고자 사전에 소비자의 행동을 분석하여 시장이 요구하는 음식료품의 특성을 분석한다. 배합할 원료의 특성과 성분을 분석하고, 원료의 배합 또는 새로운 조리법을 시험·분석한다. 실험기구 또는 조리기구를 사용하여 기존제품을 조리·시험하고 조직, 맛, 색, 영양 등을 기록·분석하여 각 제품의 조리방법 및 개선방법을 연구한다. 제품의 개선·개발을 위하여 각종 문헌, 실험법, 조리법 등을 찾아 정리한다. 생산관리나 품질관리를 위하여 새로 개발되거나 개선된 제품의 작업표준을 순서대로 정리한다. 각 공정에서 채취한 견본을 분석하여 크기, 맛, 조직, 입자, 중량 등의 상태를 기록하고 개선점을 연구한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"가공식품연구원","connectJob":"음료류(유제품, 탄산음료, 커피, 과일음료 등) 개발원, 제과류(과자, 빵류 등) 개발원, 빙과류 개발원, 식육가공품(햄, 소시지, 베이건 등)개발원, 조리식품(카레, 소스 등) 개발원, 즉석식품류(만두, 즉석조리식품 등) 개발원","certLic":"식품기술사, 식품기사, 식품산업기사","dJobECd":"1571","dJobECdNm":"[1571]식품공학 기술자 및 연구원","dJobJCd":"2391","dJobJCdNm":"[2391]식품공학 기술자 및 연구원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002902:1', '{"dJobCd":"K000002902","dJobCdSeq":"1","dJobNm":"음식료품제조공정개발원","workSum":"식품공학을 바탕으로 기계, 전기, 화학 및 생물 공학을 적용하여 음식료품의 생산기술, 품질관리, 포장기술, 가공기술 등을 연구한다.","doWork":"원료 및 첨가물 등 재료의 종류, 배합이나 숙성 및 가공 방법, 원재료 비율 및 저장·유통 기간 등을 개발하여 새로운 제품을 계획하고 가공공정을 개발한다. 음식료품의 전 처리, 가공, 생산, 품질관리, 포장에 관한 개선된 방법 및 기술을 개발한다. 맛, 색상, 영양, 조직 등 식품의 품질 또는 식품에 관한 물리·화학·미생물학적 분석을 시도하여 제품의 품질을 개선하고 개량하기 위한 방법을 연구한다. 식품기준·안전 및 위생규정·폐기물관리 등을 개선한다. 완제품의 원재료 비용 등을 계산하고 가공비용 등을 포함하여 적절한 제조 공정을 개발한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"웅크림|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"음식료생산기술원","connectJob":"품질보증원(QA), 품질관리원(QC), 식품제조기계조작원, HACCP 전문가","certLic":"품질관리기술사, 품질경영기사, 식품기사, 산업위생관리기사","dJobECd":"1571","dJobECdNm":"[1571]식품공학 기술자 및 연구원","dJobJCd":"2391","dJobJCdNm":"[2391]식품공학 기술자 및 연구원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005563:1', '{"dJobCd":"K000005563","dJobCdSeq":"1","dJobNm":"전통발효식품연구원","workSum":"전통적 발효기법에 의하여 곡류, 두류, 과채류, 수산물 등을 발효하여 김치, 장류(간장, 된장, 고추장, 청국장 등), 식초류, 젓갈류 등 각종 전통식품을 연구·개발한다. (주류 제외)","doWork":"곡류, 두류, 과채류 및 수산물등을 이용해 각종 김치류, 장류, 식초류, 젓갈류 등의 전통 발효 식품을 연구・개발한다. 이를 위해 각종 균(바실러스균, 납두균, 누룩곰팡이, 초산균 등)을 배양하고 접종(接種)시키며, 전통발효식품의 발효 및 기호 특성, 영양 성분 분석, 건강 기능성 등을 연구한다. 고문헌이나 전통식품 장인의 기법을 응용하여 효율적인 발효공정을 발굴하기도 한다. (주류 제외)","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"김치연구원, 장류연구원, 식초연구원","certLic":"식품기술사, 식품기사","dJobECd":"1571","dJobECdNm":"[1571]식품공학 기술자 및 연구원","dJobJCd":"2391","dJobJCdNm":"[2391]식품공학 기술자 및 연구원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004722:1', '{"dJobCd":"K000004722","dJobCdSeq":"1","dJobNm":"제분가공연구원","workSum":"원맥으로부터 생산된 밀가루를 이용하여 물리적·이화학적 특성분석에 따른 밀의 적성시험을 통하여 가장 효율적인 2차 상품을 연구·개발한다.","doWork":"소맥가공제품의 제조기술 및 신제품에 따른 연구·개발을 수행한다. 해외의 신기술들을 수집·분석하여 식품 제조 신기술을 도입한다. 밀가루를 이용하여 물리적·이화학적 특성분석에 따른 밀의 적성시험을 수행한다. 소맥분과 부산물을 사용한 제품의 품질개선 및 2차 가공연구 실험을 수행한다. 식품 안전성 및 안정성 확보, 식품학적·영양학적 기능 강화를 위한 연구개발을 수행한다. 원료 및 제품 첨가물 분석실험을 수행한다. 품질 및 기술에 관한 고객지원업무를 수행하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"식품기술사, 식품기사, 식품산업기사, 제과제빵산업기사","dJobECd":"1571","dJobECdNm":"[1571]식품공학 기술자 및 연구원","dJobJCd":"2391","dJobJCdNm":"[2391]식품공학 기술자 및 연구원","dJobICd":"C106","dJobICdNm":"[C106]곡물가공품, 전분 및 전분제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003324:1', '{"dJobCd":"K000003324","dJobCdSeq":"1","dJobNm":"주류제품연구원","workSum":"소주, 맥주, 청주, 막걸리(탁주), 약주, 와인, 위스키, 브랜디, 일반증류주, 기타증류주, 주정 등의 주류 제품을 개선하고 신제품을 개발하기 위해 연구한다.","doWork":"주류제품의 문제점과 개선사항 등을 파악한다. 관련 문헌을 고찰한다. 제품을 개선하고 신제품을 개발하기 위해 각종 분석기로 맛, 향기, 성분 등을 실험하고 연구한다. 제조공정 및 제조방법을 개발하고 개선하기 위해 연구한다. 제품 내 위해물질의 잔류량을 등 정밀 분석한다. 연구논문이나 보고서를 작성하고 발표한다. 주류 주종에 따른 특성 이해, 허용 원료, 제조방법, 첨가물 등에 대한 관련법규를 기반 지식으로 신제품을 개발한다. 생산관리나 품질관리를 위하여 새로 개발되거나 개선된 제품의 작업표준을 순서대로 정리한다. 각 공정에서 채취한 견본을 분석하여 크기, 맛, 조직, 입자, 중량 등의 상태를 기록하고 개선점을 연구한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"주류개발자, 주류연구원","connectJob":"브루어, 디스틸러, 양조업자, 블렌더","certLic":"주조사, 조주사, 식품기술사","dJobECd":"1571","dJobECdNm":"[1571]식품공학 기술자 및 연구원","dJobJCd":"2391","dJobJCdNm":"[2391]식품공학 기술자 및 연구원","dJobICd":"C111","dJobICdNm":"[C111]알코올음료 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005912:1', '{"dJobCd":"K000005912","dJobCdSeq":"1","dJobNm":"할랄제품연구원","workSum":"할랄제품 제조 및 가공에 사용되는 대체 재료와 할랄 시제품을 연구·개발한다.","doWork":"할랄제품에 사용이 불가한 돼지 유래 성분, 알코올 성분 등을 대체하기 위한 재료를 연구한다. 대체 재료의 원재료와의 맛, 효능의 유사성 및 안전성, 안정성 등을 확보하기 위한 실험을 실시한다. 대체 재료의 처리 및 공정기술을 연구·개발하고 시제품 연구·개발에 적용한다. 대체 재료 부재 시, 활용이 가능한 원재료로 할랄제품을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","connectJob":"할랄의약품연구원, 할랄식품연구원, 할랄화장품연구원","dJobECd":"1571","dJobECdNm":"[1571]식품공학 기술자 및 연구원","dJobJCd":"2391","dJobJCdNm":"[2391]식품공학 기술자 및 연구원","dJobICd":"C107/M701","dJobICdNm":"[C107]기타 식품 제조업 / [M701]자연과학 및 공학 연구개발업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003839:1', '{"dJobCd":"K000003839","dJobCdSeq":"1","dJobNm":"부직포기술자","workSum":"부직포에 관련된 공학적 지식을 활용하여 관련 생산공정 및 장치를 설계·개선하거나 신제품을 개발한다.","doWork":"부직포 제품에 관련된 논문, 특허 등 정보를 조사·입수하고, 시장성을 조사하여 신제품 개발계획을 세운다. 제조공정 및 재료의 개발이나 개선에 관한 연구를 수행한다. 제품의 제조관련 장치 및 장비를 설계·검사하며, 장치의 운용, 유지, 보수작업을 계획한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"섬유기술사, 섬유기사, 섬유산업기사","dJobECd":"1561","dJobECdNm":"[1561]섬유공학 기술자 및 연구원","dJobJCd":"2392","dJobJCdNm":"[2392]섬유공학 기술자 및 연구원","dJobICd":"C139","dJobICdNm":"[C139]기타 섬유제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002821:1', '{"dJobCd":"K000002821","dJobCdSeq":"1","dJobNm":"섬유공정개발기술자","workSum":"공학기술을 이용하여 섬유의 제조나 섬유가공 공정을 설계·개선한다.","doWork":"각종 원료에 따른 섬유제품, 섬유에 형태안정성 등 특성을 부여하는 가공공정, 특수섬유의 제조공정 등에 관하여 연구한다. 공정별 섬유제조장치를 설계하고 가공공정을 개선한다. 제품의 제조관련 장치 및 장비를 설계·검사하며, 장치의 운용, 유지, 보수작업을 계획한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"합성섬유공정개발기술자, 화학섬유공정개발기술자","certLic":"섬유기술사, 섬유기사, 섬유산업기사, 의류기술사, 의류기사","dJobECd":"1561","dJobECdNm":"[1561]섬유공학 기술자 및 연구원","dJobJCd":"2392","dJobJCdNm":"[2392]섬유공학 기술자 및 연구원","dJobICd":"C131/M701","dJobICdNm":"[C131]방적 및 가공사 제조업 / [M701]자연과학 및 공학 연구개발업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004073:1', '{"dJobCd":"K000004073","dJobCdSeq":"1","dJobNm":"섬유소재개발기술자","workSum":"합성섬유, 천연섬유, 화학섬유 등을 제조하기 위해 사용되는 원료를 연구·개발한다.","doWork":"식물성 섬유, 동물성 섬유, 합성섬유, 재생섬유 등 각종 섬유원료를 연구하여 새로운 섬유소재를 개발한다. 섬유원료별 섬유화 방법, 섬유개질 등 특성 및 구조를 연구·분석한다. 각종 섬유의 화학적 구조, 형성과정 등을 연구하고 일정 비율의 혼합비를 계산하여 특이한 성질의 섬유를 개발한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"섬유기술사, 섬유기사, 섬유산업기사, 의류기술사, 의류기사","dJobECd":"1561","dJobECdNm":"[1561]섬유공학 기술자 및 연구원","dJobJCd":"2392","dJobJCdNm":"[2392]섬유공학 기술자 및 연구원","dJobICd":"C131/M701","dJobICdNm":"[C131]방적 및 가공사 제조업 / [M701]자연과학 및 공학 연구개발업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002700:1', '{"dJobCd":"K000002700","dJobCdSeq":"1","dJobNm":"스마트섬유연구원","workSum":"패션, 헬스케어, 의료, 스포츠 등 다양한 분야에서 사용되는 스마트섬유를 연구·개발한다.","doWork":"섬유와 전자재료를 접목시켜 안정성을 확보하는 기술과 스마트섬유 회로설계기술, 스마트섬유와 IT기기 간의 커넥팅 기술 등을 연구한다. 스마트섬유의 편의성, 내구성, 안정성, 내열성 등을 강화하기 위한 연구를 한다. 융합형 의류 제품을 생산하기 위한 소재 및 기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1561","dJobECdNm":"[1561]섬유공학 기술자 및 연구원","dJobJCd":"2392","dJobJCdNm":"[2392]섬유공학 기술자 및 연구원","dJobICd":"C205","dJobICdNm":"[C205]화학섬유 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005326:1', '{"dJobCd":"K000005326","dJobCdSeq":"1","dJobNm":"스마트의류개발원","workSum":"스마트섬유를 활용하여 기능성과 대중성을 갖춘 스포츠용 스마트웨어와 헬스캐어, 멀티미디어 등 특수분야에서 의류 일체형 웨어러블 스마트의류를 개발한다.","doWork":"쾌적성, 안전성, 내구성, 편의성 등의 스마트의류의 기능적인 요소와 패션 요소인 심미성을 고려하여 인간 중심의 편리성과 휴대성을 확보한 스마트의류를 개발한다. 착용자의 심박수, 체온 등의 감지를 통한 헬스케어 제품과 멀티미디어, 위치기반서비스 등을 활용한 특수분야 등 다양한 분야에서 활용이 가능한 스마트의류를 연구·개발한다. 액세서리형 및 직물 및 의류 일체형 웨어러블 디바이스 등 다양한 형태의 스마트의류를 개발한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1561","dJobECdNm":"[1561]섬유공학 기술자 및 연구원","dJobJCd":"2392","dJobJCdNm":"[2392]섬유공학 기술자 및 연구원","dJobICd":"C205","dJobICdNm":"[C205]화학섬유 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005947:1', '{"dJobCd":"K000005947","dJobCdSeq":"1","dJobNm":"염료개발기술자","workSum":"염색을 하고자 하는 섬유에 적합한 염색 방법을 정하고 그에 적합한 염료와 염색 조건 등을 개발·적용한다.","doWork":"각종 섬유(섬유소섬유, 단백질섬유, 반합성섬유, 합성섬유, 신규섬유, 복합섬유 등)에 적합한 염료와 염색 방법을 개발·적용한다. 염색되는 물질의 재료, 형태, 사용목적 등에 맞는 적당한 색상과 견뢰도를 갖는 염료를 선택한 후, 조건별 염색성, 색특성, 견뢰도 등을 평가하여 적용가능성을 판단한다. 염색되는 물질의 종류, 형태와 사용되는 염료의 종류에 따라 염색법, 염료의 농도, 첨가하는 염색조제의 성질·양, 염색온도, 염색시간, 후처리조건 등을 정한다. 염료에 대한 안전성 검사를 실시하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|시각|","workEnv":"대기환경미흡|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"섬유기술사, 섬유기사, 섬유산업기사","dJobECd":"1561","dJobECdNm":"[1561]섬유공학 기술자 및 연구원","dJobJCd":"2392","dJobJCdNm":"[2392]섬유공학 기술자 및 연구원","dJobICd":"C204/M701","dJobICdNm":"[C204]기타 화학제품 제조업 / [M701]자연과학 및 공학 연구개발업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004402:1', '{"dJobCd":"K000004402","dJobCdSeq":"1","dJobNm":"염색공정개발기술자","workSum":"섬유 및 염색기술을 이용하여 염색공정을 개선·개발한다.","doWork":"섬유와 염료의 물성 및 특성에 대해 연구·분석한다. 섬유의 종류에 따라 염색할 방법을 선택하고 염색공정을 설계한다. 염료와 염색기술을 적절히 사용하여 제품에 적용하고 가공공정을 개선한다. 재료의 개발이나 개선에 관한 연구를 수행한다. 장치의 운용, 유지, 보수작업을 계획한다. 제품의 제조관련 장치 및 장비의 설계·검사에 참여하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"섬유기술사, 섬유기사, 섬유산업기사","dJobECd":"1561","dJobECdNm":"[1561]섬유공학 기술자 및 연구원","dJobJCd":"2392","dJobJCdNm":"[2392]섬유공학 기술자 및 연구원","dJobICd":"C134","dJobICdNm":"[C134]섬유제품 염색, 정리 및 마무리 가공업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002284:1', '{"dJobCd":"K000002284","dJobCdSeq":"1","dJobNm":"직물설계기술자","workSum":"시장성과 생산에 필요한 기술적 자료를 제시하고, 새로운 디자인의 자료를 수집하고 비용을 검토하며 직물의 생산가능 여부를 검토하여 생산계획서를 작성한다.","doWork":"직물의 생산가능 여부, 능률, 시장성, 손실, 비용 등을 검토하여 생산계획서를 작성한다. 새로운 디자인의 자료를 수집하여 견본을 설계하고 시험제품의 생산을 지시한다. 제품의 유행성에 대한 시장성을 조사하고 새로운 제품과 디자인을 개발하며 직물의 배색 및 색상의 표준화를 연구한다. 거래처의 직물수주에 시장성과 생산에 필요한 기술적 자료 등을 제시한다. 잔사의 효율적인 이용을 검토하여 설계를 지시한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"의류기술사, 의류기사, 섬유기술사, 섬유기사,","dJobECd":"1561","dJobECdNm":"[1561]섬유공학 기술자 및 연구원","dJobJCd":"2392","dJobJCdNm":"[2392]섬유공학 기술자 및 연구원","dJobICd":"C132","dJobICdNm":"[C132]직물직조 및 직물제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003335:1', '{"dJobCd":"K000003335","dJobCdSeq":"1","dJobNm":"탄소섬유공정연구원","workSum":"탄소섬유 제품의 물성을 향상시키기 위해 중합, 방사, 내염화, 탄소화, 흑연화, 표면처리·사이징 등 전 공정을 분석하고 개선을 위해 연구·개발한다.","doWork":"PAN(PolyAcryloNitrile:폴리아크릴로니트릴)계 탄소섬유, 피치(Pitch)계 탄소섬유 및 레이온계 탄소섬유를 생산하기 위해 각 원료로부터 섬유(아크릴섬유, 피치섬유)로 방사하기까지의 개질, 정제, 중합, 용융방사 공정을 분석한다. 섬유를 탄소섬유로 제조하기 위한 내염화, 탄소화, 흑연화 공정과 탄소섬유를 고강도, 고탄성률사로 제조하기 위한 표면처리, 사이징 공정 등 각 공정을 분석한다. 분석된 자료를 바탕으로 개발 및 개선방향을 연구한다. 공정의 개선 및 변화를 위해 탄소섬유의 생산설비를 연구하기도 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"위험내재|고온|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"화공기사, 화공기술사, 화학분석기사, 섬유기술사, 섬유기사, 섬유산업기사","dJobECd":"1561","dJobECdNm":"[1561]섬유공학 기술자 및 연구원","dJobJCd":"2392","dJobJCdNm":"[2392]섬유공학 기술자 및 연구원","dJobICd":"C205","dJobICdNm":"[C205]화학섬유 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005019:1', '{"dJobCd":"K000005019","dJobCdSeq":"1","dJobNm":"가축품질관리원","workSum":"도축한 소와 돼지의 품질관리 및 위생관리 등의 업무를 수행한다.","doWork":"도축한 소, 돼지 등의 수출물량과 내수물량을 판단한다. 도축 이전 소, 돼지 내장의 견본을 채취하여 항생제 과다 투여 등 건강 여부를 판단한다. 타박 등으로 나타난 문제점 등을 검사한다. 공정 중에 소, 돼지 등의 견본을 채취하여 미생물, 대장균, 헤모레나 등을 검사한다. 포장된 제품에 대해 미생물 검사를 한다. 고기의 육질 및 병균 등 소비자의 불만 원인을 분석한다. 직원을 대상으로 위생교육을 실시한다. 수출입 등 품질과 관련된 문서를 작성하고 행정업무를 처리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"교육","workFunc3":"정밀작업","similarNm":"가축품질검정원","certLic":"수의사, 위생사","dJobECd":"1572","dJobECdNm":"[1572]식품공학 시험원","dJobJCd":"2393","dJobJCdNm":"[2393]식품공학 시험원","dJobICd":"C101","dJobICdNm":"[C101]도축, 육류 가공 및 저장 처리업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004700:1', '{"dJobCd":"K000004700","dJobCdSeq":"1","dJobNm":"곡물가공품검사원","workSum":"밀가루, 이유식 등 곡물가공품의 품질·성분 및 이물질·정량상태 등을 검사하고 포장상태를 점검한다.","doWork":"투입한 첨가물의 비율을 검사하고자 제품표준과 색상, 맛, 향 등을 비교한다. 제품의 수분함량, 글루텐함량 등을 시험한다. 균일한 품질의 제품을 제조하고자 배합비를 결정한다. 제품의 인장강도 등을 검사한다. 제품에 이물질이 포함되었는지 검사한다. 포장재에 인쇄 또는 부착된 상표의 위치와 부착 상태를 점검한다. 포장된 제품의 견본을 사용하여 내용물의 중량을 검사한다. 생산된 제품의 견본을 채취하여 시험·분석한 자료와 비교한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"밀가루검사원","certLic":"품질경영기사, 농산물품질관리사, 식품기사","dJobECd":"1572","dJobECdNm":"[1572]식품공학 시험원","dJobJCd":"2393","dJobJCdNm":"[2393]식품공학 시험원","dJobICd":"C106","dJobICdNm":"[C106]곡물가공품, 전분 및 전분제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003766:1', '{"dJobCd":"K000003766","dJobCdSeq":"1","dJobNm":"낙농품품질검사원","workSum":"낙농품을 제조하고자 입고되는 원료나 반제품, 완제품을 각종 실험기구를 사용하여 시험·분석한다.","doWork":"색도계를 사용하여 제품에 사용되는 원재료 및 유제품의 색상을 측정한다. 원유에 포함되어 있는 농약 및 항생물질의 잔류검사와 지방산을 검사한다. 원유의 체세포 수를 검사하고 균질기를 사용하여 시제품을 생산한다. 적외선 또는 가시광선분광기를 사용하여 가공제품의 비타민, 철, 구리, 인 등의 미네랄을 측정한다. 아이스크림제조 기구를 사용하여 아이스크림을 시험생산하고 미생물을 검사한다. 시험, 분석한 자료를 정리하고 제품의 개선방법이나 신제품에 관련된 보고서를 작성한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|시각|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"발효유품질검사원, 버터품질검사원, 분유품질검사원, 아이스크림품질검사원","certLic":"농산물품질관리사, 품질경영기사, 식품기사","dJobECd":"1572","dJobECdNm":"[1572]식품공학 시험원","dJobJCd":"2393","dJobJCdNm":"[2393]식품공학 시험원","dJobICd":"C105","dJobICdNm":"[C105]낙농제품 및 식용빙과류 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002730:1', '{"dJobCd":"K000002730","dJobCdSeq":"1","dJobNm":"담배성분분석원","workSum":"담배 및 담배연기와 관련된 화합물의 분석이나 미지물질의 동정과 관련된 연구를 수행한다.","doWork":"전국 산지에서 수집된 담배시료의 니코틴, 전당, 전질소, 조섬유, 조회분, 무기성분 등을 분석하여 잎담배의 품질을 평가한다. 담배의 향기, 잔류농약, 유기산, 천연 활성물질의 정량 및 미지물질을 각종 기기를 사용하여 분석한다. 담배연기 중 니코틴, 타르, 일산화탄소, 다이옥신 등 연기관련 화합물을 스모킹 머신(Smoking Machine)으로 분석한다. 담배에 첨가되는 향료의 순도확인을 비롯하여 제품담배에 대한 연소성, 수분함량 등을 연소성 측정기, 흡인저항측정기, 끝빠짐 측정기 등으로 측정하여 품질을 유지하며 외산 담배와 비교·분석하여 신제품개발에 필요한 정보를 제공한다. 담배의 재료로 사용되는 각종 궐련지, 필터 및 필터충전물, 포갑지의 체제 등 재료의 이화학적 특성을 비표면적 측정기, 경도측정기, 현미경 등으로 분석하여 일정한 품질유지가 지속되도록 하고 신제품에 대한 규격을 제정하여 이를 심사·분석한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1572","dJobECdNm":"[1572]식품공학 시험원","dJobJCd":"2393","dJobJCdNm":"[2393]식품공학 시험원","dJobICd":"C120","dJobICdNm":"[C120]담배 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004453:1', '{"dJobCd":"K000004453","dJobCdSeq":"1","dJobNm":"수산물품질검사원","workSum":"각종 수산제품의 원산지 확인 및 위생안전 등의 품질검사 업무를 수행한다.","doWork":"수산물의 검사계획을 수립한다. 건제품, 염장품, 조미가공품, 해조, 한천 등의 검사와 검사대상품에 대한 포장이나 제품생산지 및 시료를 관리한다. 견본품을 선정하고 보관·관리한다. 외화획득용 수산물의 원료수입을 추천하고 사후 관리를 한다. 외국에서 수입되는 각종 수산물을 검사한다. 원양어획물 반입신고 및 조사·확인업무를 수행한다. 냉동품, 통조림 식품, 병조림 식품, 어간유(魚肝油), 어비(魚肥), 어육연제품을 삶아 냉장한 패류를 검사한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"수산물품질관리사, 수산제조기술사, 수산제조기사, 위생사","dJobECd":"1572","dJobECdNm":"[1572]식품공학 시험원","dJobJCd":"2393","dJobJCdNm":"[2393]식품공학 시험원","dJobICd":"A032","dJobICdNm":"[A032]양식어업 및 어업관련 서비스업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007285:1', '{"dJobCd":"K000007285","dJobCdSeq":"1","dJobNm":"식품품질검사원","workSum":"식품에 관한 물리·화학적 특성을 시험하여, 회사나 정부의 품질기준과 일치하는지 검사한다.","doWork":"배양기, 압력솥, 천칭, 굴절계와 기타 장비를 사용하여 포장된 식품, 통조림 식품, 냉동된 식품 등에 관한 표준화 검사를 수행한다. 식료품의 맛, 색깔, 영양 등을 내기 위한 첨가물 또는 방부제 등에 관한 표준화 검사를 한다. 분광광도계, 입체현미경 등을 사용하여 조미료와 향신료를 검사하며, 수분, 색깔, 자극성, 맛 등을 조사한다. 식품견본을 pH계, 증류장비와 천칭 등을 사용하여 명세서와 일치하는지 조사한다. 습도, 염분, 앙금, 가용성 등의 요인들을 계산한다. 세균성물질과 이물질을 구별하고자 현미경을 통해 세균배양기의 견본·침전물질 등을 검사한다. 검사결과를 기준과 비교하고 결과를 기록한다. 최종생산물에 존재하는 성분요소들의 비율을 계산하고자 측정기계를 작동하기도 하며, 특정식품을 검사하고자 특수한 방법이나 장비를 사용하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"식품시험원","connectJob":"통조림품질검사원, 농산물품질관리사, 수산물품질관리사","certLic":"품질경영기사, 품질경영산업기사, 품질관리기술사, 농산물품질관리사, 수산물품질관리사, 식품기사","dJobECd":"1572","dJobECdNm":"[1572]식품공학 시험원","dJobJCd":"2393","dJobJCdNm":"[2393]식품공학 시험원","dJobICd":"C107/M729","dJobICdNm":"[C107]기타 식품 제조업 / [M729]기타 과학기술 서비스업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003582:1', '{"dJobCd":"K000003582","dJobCdSeq":"1","dJobNm":"우유검사원","workSum":"양질의 우유를 모으기 위하여 축산물가공처리법에 의해 원유를 검사하고 집유작업을 지휘한다.","doWork":"집유원에 의해 채취된 견본원유 또는 집유된 원유의 견본을 채취한다. 지방측정기, 체세포검사기, 시약과 실험기구를 사용하여 축산물가공처리법에 규정된 지방검사, 체세포검사, 세균검사, 비중검사, 세균발육억제물검사, 관능검사 등을 통해 외관, 온도, 성분, 세균수, 항생물질 등의 검사를 수행한다. 원유를 계량하고 집유작업원을 감독하고 집유기기를 관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"시각|","workEnv":"대기환경미흡|다습|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"농산물품질관리사, 품질경영기사, 식품기사","dJobECd":"1572","dJobECdNm":"[1572]식품공학 시험원","dJobJCd":"2393","dJobJCdNm":"[2393]식품공학 시험원","dJobICd":"C105","dJobICdNm":"[C105]낙농제품 및 식용빙과류 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007380:1', '{"dJobCd":"K000007380","dJobCdSeq":"1","dJobNm":"음료품질관리원","workSum":"맥주, 청주, 탄산음료, 위스키 등의 품질관리 실험을 수행하고자 원료, 용기, 제품 등의 물리·화학적 검사 및 각 공정의 작업관리와 위생상태를 점검한다.","doWork":"제품을 생산하고자 사용되는 원료와 식품첨가물 그리고 반제품을 공정별로 견본을 채취한다. 채취한 견본은 각종 분석기기(습도기, pH meter, 형광분석기, GC, LC, 분광기) 등을 사용하여 성분함량, 제품의 완성도, 제품규격과의 일치 여부, 위생상태 등을 검사한다. 검사결과를 해당 부서에 통보한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"품질경영산업기사, 식품기사","dJobECd":"1572","dJobECdNm":"[1572]식품공학 시험원","dJobJCd":"2393","dJobJCdNm":"[2393]식품공학 시험원","dJobICd":"C111/C112","dJobICdNm":"[C111]알코올음료 제조업 / [C112]비알코올음료 및 얼음 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003468:1', '{"dJobCd":"K000003468","dJobCdSeq":"1","dJobNm":"주류품질관리원","workSum":"맥주, 소주, 막걸리 등의 원료 및 제품의 품질관리를 위하여 각종 분석기기를 사용하여 화학적 검사를 수행한다.","doWork":"맥주, 소주 등 주류제품의 원료입고, 생산, 제품출하 과정에서 견본을 채취한다. pH미터 등 각종 분석기기 등을 사용하여 성분함량검사, 원료품질검사, 미생물검사 등을 실시·분석하고 품질규격과 비교한다. 품질결과에 대한 보고서를 작성한다. 품질에 문제가 있으면 해당 부서에 통보하여 조치를 취한다. 품질과 관련된 문서를 작성하는 등 행정업무를 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1572","dJobECdNm":"[1572]식품공학 시험원","dJobJCd":"2393","dJobJCdNm":"[2393]식품공학 시험원","dJobICd":"C111","dJobICdNm":"[C111]알코올음료 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003023:1', '{"dJobCd":"K000003023","dJobCdSeq":"1","dJobNm":"주정검사원","workSum":"식용, 의약품용, 공업용 등으로 사용하기 위해 제조되는 주정(에틸알코올)이 용도에 적합한 상태인지 각종 분석기기를 사용하여 성분분석을 한다.","doWork":"제조된 주정의 표본을 추출한다. 각종 검사기기(GC, 현미경, 증류기, pH meter 등)를 사용하여 미생물 상태, 알코올농도, 산성도, 원료의 전분질, 주모(효모)상태 등을 분석·검사한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"주정분석원","dJobECd":"1572","dJobECdNm":"[1572]식품공학 시험원","dJobJCd":"2393","dJobJCdNm":"[2393]식품공학 시험원","dJobICd":"C111","dJobICdNm":"[C111]알코올음료 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004129:1', '{"dJobCd":"K000004129","dJobCdSeq":"1","dJobNm":"날염시험원","workSum":"직물에 날염하여 요구하는 색상을 내기 위해 색소를 배합하고 염료, 안료, 호제, 약제 등을 처방하여 자료를 작성한다.","doWork":"견본 색상을 구현하도록 염료, 안료 및 시험도구들을 준비한다. 견본 디자인이나 색상에 따라 천의 종류, 날염기법, 염색방법 등을 결정한다. 날염에 관한 지식을 응용하여 염료 및 도료를 조제한다. 증열 및 세척방법 등에 따라 염색시험을 반복한다. 견본 디자인이나 색상과 일치하는 염색방법 및 순서에 관한 자료를 정리하고 배색순서, 날염틀 번호, 섬유의 종류 등이 명시된 공정표를 작성한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"배색원, 배합사, 염료조색원, 염료배색원, 칼라매칭원","certLic":"섬유기술사, 섬유기사, 섬유산업기사","dJobECd":"1562","dJobECdNm":"[1562]섬유공학 시험원","dJobJCd":"2394","dJobJCdNm":"[2394]섬유공학 시험원","dJobICd":"C134","dJobICdNm":"[C134]섬유제품 염색, 정리 및 마무리 가공업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004621:1', '{"dJobCd":"K000004621","dJobCdSeq":"1","dJobNm":"방적사시험원","workSum":"실과 직물의 제조공정 중 표준과의 일치 여부를 확인하고자 직물과 편물의 실을 검사한다.","doWork":"공정별 시료를 채취하여 준비한다. 제조방법과 꼬임계산기의 수치를 사용하여 견본실의 꼬임수를 산출한다. 실, 조사, 슬라이버(Sliver:면섬유 다발)를 균제도시험기 안에 넣어 실 가닥의 굵기를 육안으로 확인하고 기록한다. 실의 장력을 확인하기 위해 실타래를 파괴시험기로 절단한다. 저울이나 천칭으로 실타래의 중량을 계량하고 다이얼이나 도표로 실의 번수(섬도)를 알아본다. 검은 패널(Panel)에 검사할 실을 감고 방적사의 거친 실과 넵(Nep)의 균제도와 번수를 표준과 비교하여 등급을 결정한다. 염색하기 전후에 섬유견본을 저울이나 천칭으로 계량하고 계산한 후 도표를 찾아 수분함유량(공정수분)의 퍼센트를 알아낸다. 시험결과를 기록하고 공정에 적용하기 위해 공정책임자에게 수정사항을 전달한다. 방적사에 함유된 기름과 풀의 양을 알기 위해 표준화된 화학시험을 수행하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"섬유기술사, 섬유기사, 섬유산업기사","dJobECd":"1562","dJobECdNm":"[1562]섬유공학 시험원","dJobJCd":"2394","dJobJCdNm":"[2394]섬유공학 시험원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002674:1', '{"dJobCd":"K000002674","dJobCdSeq":"1","dJobNm":"색상개발원","workSum":"여러 가지 색상의 염료 및 안료를 조합하여 새로운 견본색상과 일치하는 염액을 개발한다.","doWork":"일정 농도의 염료, 안료, 조제가 들어 있는 염액 및 조제액을 준비한다. 시험에 필요한 피염물을 준비한다. 비커에 일정량의 염액을 혼합하여 견본색상과 비슷한 색상을 만드는 비커 테스트를 수차례 반복한다. 견본과 가장 가까운 색상을 개발하고 개발된 색상을 제조하기 위한 명세를 정리한다. 선정된 색상은 색상번호를 붙여 생산 색상으로 등록한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workEnv":"대기환경미흡|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"컬러리스트산업기사, 컬러리스트기사, 섬유기술사, 섬유기사, 섬유산업기사","dJobECd":"1562","dJobECdNm":"[1562]섬유공학 시험원","dJobJCd":"2394","dJobJCdNm":"[2394]섬유공학 시험원","dJobICd":"C134","dJobICdNm":"[C134]섬유제품 염색, 정리 및 마무리 가공업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007236:1', '{"dJobCd":"K000007236","dJobCdSeq":"1","dJobNm":"섬유공정개발시험원","workSum":"섬유 및 섬유제품의 제조공정 관련 시험·분석과 섬유공정 장비의 유지·보수를 수행한다.","doWork":"섬유가공공정을 개선하고자 현장을 조사하고 자료를 수집한다. 섬유의 가공공정 중 발생하는 결함을 조사하여 해결책을 찾고 기록한다. 섬유공정개발기술자를 보조하여 섬유의 가공공정, 특수섬유의 제조공정에 관한 기술을 개발한다. 설계 및 검사를 거친 장비에 대하여 유지·보수작업을 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"합성섬유공정개발시험원, 화학섬유공정개발시험원","certLic":"섬유기술사, 섬유기사, 섬유산업기사","dJobECd":"1562","dJobECdNm":"[1562]섬유공학 시험원","dJobJCd":"2394","dJobJCdNm":"[2394]섬유공학 시험원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006673:1', '{"dJobCd":"K000006673","dJobCdSeq":"1","dJobNm":"섬유소재개발시험원","workSum":"섬유를 제조하기 위한 원료의 특성을 시험·분석한다.","doWork":"새로운 섬유소재 개발을 위해 연구된 자료를 기초로 하여 일정비율로 원료를 혼합하여 견본을 제조한다. 제조된 견본섬유의 인장강도, 수축률, 변색, 인열강도 등 각종 섬유의 물리적 특성을 시험한다. 섬유소재개발기술자를 지원하여 각종 섬유의 화학적 구조, 형성과정 등에 대한 연구를 위한 시험 및 검사를 실시한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"합성섬유원료개발시험원, 화학섬유원료개발시험원","certLic":"섬유기술사, 섬유기사, 섬유산업기사","dJobECd":"1562","dJobECdNm":"[1562]섬유공학 시험원","dJobJCd":"2394","dJobJCdNm":"[2394]섬유공학 시험원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003455:1', '{"dJobCd":"K000003455","dJobCdSeq":"1","dJobNm":"염색공정개발시험원","workSum":"염색가공 공정을 개선하고 시험·분석하는 업무를 수행한다.","doWork":"염색가공 공정을 개선하기 위하여 염색공정개발기술자를 보조하여 현장을 조사하고 자료를 수집한다. 염색소재, 제품(실, 원단) 및 염료별 염색, 탈수, 건조 등 염색공정을 견본을 통해 시험한다. 염색가공 공정 중 발생하는 결함을 조사하여 문제점의 해결책을 찾을 수 있도록 염색공정개발기술자를 돕는다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"섬유기술사, 섬유기사, 섬유산업기사","dJobECd":"1562","dJobECdNm":"[1562]섬유공학 시험원","dJobJCd":"2394","dJobJCdNm":"[2394]섬유공학 시험원","dJobICd":"C134","dJobICdNm":"[C134]섬유제품 염색, 정리 및 마무리 가공업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002701:1', '{"dJobCd":"K000002701","dJobCdSeq":"1","dJobNm":"염색시험원","workSum":"제품을 염색하는 현장에서 본 작업을 할 수 있도록 소규모의 염색시험기를 사용하여 염색, 시험 후 본 작업에 필요한 자료를 작성한다.","doWork":"제품에 따라 염색방법을 구상하고 염료나 실, 직물의 피염물 견본을 준비한다. 염색원단의 무게나 염료의 종류에 따라 염색처방을 결정하고 실험기재나 소규모 염색시험기를 사용하여 염색시험을 한다. 산출된 염색처방 자료를 본 작업 현장 염색부서에 통보한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workEnv":"대기환경미흡|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"염료시험원, 예염원","certLic":"섬유기술사, 섬유기사, 섬유산업기사","dJobECd":"1562","dJobECdNm":"[1562]섬유공학 시험원","dJobJCd":"2394","dJobJCdNm":"[2394]섬유공학 시험원","dJobICd":"C134","dJobICdNm":"[C134]섬유제품 염색, 정리 및 마무리 가공업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004033:1', '{"dJobCd":"K000004033","dJobCdSeq":"1","dJobNm":"자동차시트품질검사원","workSum":"자동차시트 원자재의 외관검사, 물성검사 등 원단에서부터 최종 완성된 제품까지 물품의 품질을 검사한다.","doWork":"입고된 시트원단 및 최종 완제품의 품질을 각종 기계장비를 이용하여 검사한다. 연소성 시험기를 이용하여 난연, 비난연 처리된 원단에 대해서 불에 대한 저항성을 측정한다. 만능시험기를 사용하여 제품에 물리적인 힘을 가하고 인장강도, 인장신율, 인열강도, 접착강도, 봉목강도 등 제품의 각종 강도를 측정한다. 봉합 피로도 시험기를 이용하여 제품의 봉합부위에 물리적 힘을 가하고 봉합 부분의 벌어짐 정도를 측정한다. 처짐 저항성 시험기를 사용하여 제품의 처짐(영구 변형률)정도를 측정한다. 제품의 이상 유무를 기록하여 품질 검사를 통과한 제품에 한하여 출고시킨다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"품질경영기사, 품질경영산업기사","dJobECd":"1562","dJobECdNm":"[1562]섬유공학 시험원","dJobJCd":"2394","dJobJCdNm":"[2394]섬유공학 시험원","dJobICd":"C303","dJobICdNm":"[C303]자동차 신품 부품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003140:1', '{"dJobCd":"K000003140","dJobCdSeq":"1","dJobNm":"직물분해원","workSum":"직물설계서를 작성하기 위해 직물의 조직, 중량, 밀도, 배열상태를 분해·조사·정리한다.","doWork":"견본을 분해하여 중량, 번수, 꼬임수, 밀도, 조직, 색상, 배열, 연도 등을 관련 장비나 육안으로 조사한다. 생지나 가공 직물 견본의 번수, 밀도, 생지중량, 가공중량, 색 번호 등을 기록표에 기록한다. 견본책자(Sample Book)를 만들고 관련 부서에 보낸다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"직물분해설계원, 직물조직분해원","certLic":"섬유기술사, 섬유기사, 섬유산업기사","dJobECd":"1562","dJobECdNm":"[1562]섬유공학 시험원","dJobJCd":"2394","dJobJCdNm":"[2394]섬유공학 시험원","dJobICd":"C132","dJobICdNm":"[C132]직물직조 및 직물제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006471:1', '{"dJobCd":"K000006471","dJobCdSeq":"1","dJobNm":"직물시험원","workSum":"표준화된 검사장비 및 방법 등을 이용하여 생지와 가공된 직물의 물리적 특성을 시험한다.","doWork":"시험용 견본을 채취하기 위해 일정 크기의 옷감을 절단한다. 그레인(Grain)저울로 견본을 계량하고 계산표를 사용하여 그레인 단위를 필요한 단위로 환산한다. 확대계산기를 사용하여 단위공정 당 경사와 위사의 숫자를 확인한다. 시험기의 물림장치 사이에 옷감견본을 놓고 기계조정기를 움직여 견본을 찢기 위해 필요한 힘을 가하여 옷감의 장력을 시험한다. 이동용 재봉기를 사용하여 견본을 바느질하고, 재봉기의 바늘에 의한 사절을 알기 위해 확대렌즈로 바느질 상태를 점검한다. 적정한 조건 상태에서 견본에 주름을 잡고 주름회복 검사기의 꺾쇠에 견본을 놓고 주름회복을 알아본다. 시험결과를 기록하고 기준에 벗어난 편차를 품질관리부서에 통보한다. 절단시험, 권축탄성시험, 직물굽힘시험, 마모시험, 파열강도시험, 투수시험, 방수시험 등의 기타 시험을 수행하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"섬유기술사, 섬유기사, 섬유산업기사","dJobECd":"1562","dJobECdNm":"[1562]섬유공학 시험원","dJobJCd":"2394","dJobJCdNm":"[2394]섬유공학 시험원","dJobICd":"C132","dJobICdNm":"[C132]직물직조 및 직물제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005824:1', '{"dJobCd":"K000005824","dJobCdSeq":"1","dJobNm":"타이어코드직물시험원","workSum":"타이어코드 꼬임이 없고 직조가 되지 않은 실이나 접착코팅 공정을 거친 직조물이 고객이 원하는 물성을 만족하는지 고객이 표준으로 정한 방법으로 시험한다.","doWork":"고객이 시험방법으로 제시한 표준서를 확인하고 생산공정에서 물성 의뢰된 시료를 확인한다. 각 시료는 시험표준에서 정하고 있는 방법으로 온습도 조작 장치 또는 진공장치에 넣어서 표준 상태에 도달되도록 한다. 표준상태에 도달된 시료는 각 분석 물성항목별, 시료표준 가닥수를 확인하여 표준화를 실시하고 이를 각 시험 기계별로 분석을 수행한다. 분석된 데이터는 기록관리를 실시하고 고객이 규정된 표준사양을 벗어나는 경우 현장관리책임자 또는 담당사원에게 연락한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|고온|소음·진동|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"타이어코드시험원","dJobECd":"1562","dJobECdNm":"[1562]섬유공학 시험원","dJobJCd":"2394","dJobJCdNm":"[2394]섬유공학 시험원","dJobICd":"C132","dJobICdNm":"[C132]직물직조 및 직물제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002923:1', '{"dJobCd":"K000002923","dJobCdSeq":"1","dJobNm":"화학섬유시험원","workSum":"나일론, 폴리에스테르 등의 합성섬유 및 제조공정의 품질관리를 위하여 제품 견본을 측정·검사·분석·시험한다.","doWork":"화학섬유의 구조적 특성을 알기 위해 화학적·물리학적 시험을 한다. 단면을 얇고 정확히 자르기 위해 여러 가닥을 꼰 견본 실을 용융한 왁스에 넣어 굳힌 후 마이크로 톱(현미경 검사용 절편절단기)로 자른다. 솔벤트 등을 사용하여 왁스를 용해하여 현미경 또는 더 정확한 관찰하기 위해 전자현미경을 사용하여 실의 견본을 촬영하고 이를 현상하여 사진을 분석한다. 분석된 결과가 해당 섬유의 구조와 기타 특성과 일치하는지 비교·검사한다. 실의 한쪽 끝을 인장기의 척에 고정하고 다른 한쪽을 서서히 당겨 끊어지는 순간까지의 인장력, 면적계를 사용한 견본실의 단면적 측정 등의 물리적 시험과 실을 물, 부식제, 세척제에 담가 실의 수축 및 손상의 정도를 알아보고 염료용기에 실을 담가 염료의 특성 등을 알아보는 화학적 시험 및 통제된 광원에 실을 노출하여 빛에 대한 저항성 등을 알아보는 시험을 한다. 생산의 품질관리를 용이하게 하기 위해 생산직원에게 연구결과에 대한 보고서를 제공한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workEnv":"대기환경미흡|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1562","dJobECdNm":"[1562]섬유공학 시험원","dJobJCd":"2394","dJobJCdNm":"[2394]섬유공학 시험원","dJobICd":"C205","dJobICdNm":"[C205]화학섬유 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003601:1', '{"dJobCd":"K000003601","dJobCdSeq":"1","dJobNm":"국가유산실측설계보조원","workSum":"전통건축물의 보수, 복원을 위하여 실측하여 설계도를 작성하고 이에 따른 간단한 시굴조사를 실시한다.","doWork":"국가유산실측설계기술자의 지시에 따라 국가유산의 유구조사 및 지표조사에 대한 기술적 자문이나 설계를 보조한다. 현장조사를 통하여 실측조사와 측량을 하고 사진 등을 통하여 기록을 남기고 관련 자료를 수집·정리한다. 정리된 자료를 기본으로 기본설계를 작성하여 검토한다. 실시설계도서를 작성한다. 설계도서를 기준으로 작업이 진행되면 현장에 상주하여 기술지원 및 감리업무를 수행한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"시각|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"건축설계기술자, 한옥설계기술자","certLic":"국가유산수리기능자(실측설계사보)","dJobECd":"1591","dJobECdNm":"[1591]제도사","dJobJCd":"2395","dJobJCdNm":"[2395]제도사","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006416:1', '{"dJobCd":"K000006416","dJobCdSeq":"1","dJobNm":"기계캐드사","workSum":"기계설계기술자가 그린 도면을 CAD를 이용하여 그리고 관련 정보를 관리한다.","doWork":"기계설계기술자가 지시한 작업을 확인한다. 2D, 3D 등 기계설계 전용 컴퓨터프로그램을 사용하여 기계설계도면을 작성한다. 작성결과를 검토받고 필요하면 수정한다. 작성된 도면에 번호를 부여하고 관리한다. 설계정보를 데이터베이스에 저장하고 관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"전산응용기계제도기능사","dJobECd":"1591","dJobECdNm":"[1591]제도사","dJobJCd":"2395","dJobJCdNm":"[2395]제도사","dJobICd":"C291","dJobICdNm":"[C291]일반 목적용 기계 제조업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003752:1', '{"dJobCd":"K000003752","dJobCdSeq":"1","dJobNm":"날염제도사","workSum":"스크린 날염공정에서 직물에 무늬를 넣기 위하여 제시된 디자인을 제도필름 위에 제도잉크나 테이프 등을 사용하여 그린다.","doWork":"주문된 제품의 작업지시서와 도안의 디자인과 색상을 검토하여 날염방법을 결정한다. 소요되는 색상을 색분해에 따라 제도도수를 결정한다. 날염방법에 따른 스크린 무늬의 반복거리를 산정하고 다른 색상 사이의 중복되는 크기, 면적, 선 등의 굵기를 결정한다. 제도도수와 같은 필름을 준비하고 필름에 제도용 잉크나 제도용 테이프 등을 사용하여 무늬를 그려 넣는다. 반복되는 무늬의 크기에 따라 제도된 필름을 제도복사기로 복사하여 날염틀에 들어갈 전체 무늬를 조립한다. 조립한 필름을 주문 디자인과 비교·확인하여 검토한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"염색기능사","dJobECd":"1591","dJobECdNm":"[1591]제도사","dJobJCd":"2395","dJobJCdNm":"[2395]제도사","dJobICd":"C134","dJobICdNm":"[C134]섬유제품 염색, 정리 및 마무리 가공업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003958:1', '{"dJobCd":"K000003958","dJobCdSeq":"1","dJobNm":"신발캐드사","workSum":"캐드(CAD)를 사용하여 신발 도면을 그리고, 신발제조에 사용할 신발패턴 조각을 제작 및 조립한다.","doWork":"종이로 된 신발패턴 조각을 조립한다. 다양한 신발사이즈에 맞게 자와 각도기 등을 사용하여 다양한 종류를 제작한다. 캐드를 이용하여 디자인을 그린다. 커터기에서 작업되어 나오는 다양한 신발패턴을 관찰한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"1591","dJobECdNm":"[1591]제도사","dJobJCd":"2395","dJobJCdNm":"[2395]제도사","dJobICd":"C152","dJobICdNm":"[C152]신발 및 신발 부분품 제조업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003993:1', '{"dJobCd":"K000003993","dJobCdSeq":"1","dJobNm":"캐드원(일반)","workSum":"캐드 프로그램을 이용하여 제품 관련 설계도면이나 기타 회로도를 작성하고 자료를 수정·관리한다.","doWork":"설계기술자의 약도나 설계서의 내용을 파악하여 캐드작업을 제품, 기계, 특수, 정밀 도면으로 분류한다. 설계서에 따라 캐드 프로그램에 직접 입력을 하거나 제도내역, 수치, 도형형태 등의 정보를 입력장치로 입력한다. 모니터를 주시하면서 캐드 프로그램을 사용하여 도면을 완성시키고 완성된 도면을 출력하여 점검·수정하거나 설계담당자에게 문의하여 수정한다. 특수도면, 상세도면 등을 분류하고 입력·관리한다. 완성된 도면으로 컴퓨터상에서 투시도 또는 3차원 시뮬레이션으로 재현하기도 한다. 도면에 관련된 도표, 수치에 대한 도표를 작성하거나 파일로 저장하여 근거를 기록한다. 개발이 진행됨에 따라 도면에 수정이 발생하게 되면 이를 반영한 후 수정내용의 이력을 작성하고 관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"CAD원","connectJob":"분야에 따라 기계캐드원, 금속캐드원, 전기전자캐드원, 토목캐드원, 건축캐드원, 인테리어캐드원, 측량캐드원 등","certLic":"전산응용건축제도기능사, 전산응용기계제도기능사, 전산응용토목제도기능사, 지도제작기능사, 도화기능사, 전자캐드기능사","dJobECd":"1591","dJobECdNm":"[1591]제도사","dJobJCd":"2395","dJobJCdNm":"[2395]제도사","dJobICd":"C","dJobICdNm":"[C]제조업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007387:1', '{"dJobCd":"K000007387","dJobCdSeq":"1","dJobNm":"투시조감도제작원","workSum":"시공할 건축구조물, 조경물 등의 모양을 상상이나 설계도면을 보고 완성을 예상하여 투시도를 제작한다.","doWork":"설계도면(평면도, 입면도, 측면도 등)을 검토하고 설계기술자와 상의하여 투시도의 제작 방향을 설정한다. 컴퓨터를 이용하여 입체적인 투시도를 제작한다. 연필·색연필·펜, 에어브러시·수채화(과슈 등)물감·아크릴물감 등 기타 그림도구를 사용하여 스케치하고 채색하거나 카메라 등을 사용하기도 한다. 투시하는 시점의 위치에 따라 앙각투시도(밑에서 위로 투시), 조감도(위에서 아래로 투시), 부감도(지붕을 제거한 상태에서 내부를 투시하여 그리는 방법), 투시도(눈높이에서 투시)로 구분할 수 있다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"분석","workFunc2":"협의","workFunc3":"정밀작업","certLic":"컴퓨터그래픽스운용기능사","dJobECd":"1591","dJobECdNm":"[1591]제도사","dJobJCd":"2395","dJobJCdNm":"[2395]제도사","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003657:1', '{"dJobCd":"K000003657","dJobCdSeq":"1","dJobNm":"가구시험원","workSum":"가구 생산기술 및 자재기술을 개발하기 위해서 가구자재의 성능, 구조 등을 시험·분석한다.","doWork":"목재 및 목질 복합재의 강도를 충격시험기로 시험하고 판제품의 물성시험을 한다. 경칩, 태커(Tacker), 접착제, 도료 등 자재의 특성을 시험한다. 완성된 가구를 육안으로 먼지, 녹, 때, 이물질, 찌그러짐 등이 있는지 틈새게이지, 에어실린더 등으로 조사한다. 불량이 발견되면 해당 담당자에게 통보하여 개선할 것을 요구한다. 기술관리를 위해 시험한 결과 및 신기술 정보를 기록한다. 자재 시장동향을 분석하여 가격, 품질, 수입처 등을 파악하고 신제품 개발 디자인이 결정되면 적합한 자재를 가구디자이너와 협의하여 결정한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"자재품질시험원","certLic":"가구제작기능사","dJobECd":"1599","dJobECdNm":"[1599]기타 인쇄·목재 등 공학 기술자 및 시험원","dJobJCd":"2399","dJobJCdNm":"[2399]기타 공학 관련 기술자 및 시험원","dJobICd":"C320","dJobICdNm":"[C320]가구 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001488:1', '{"dJobCd":"K000001488","dJobCdSeq":"1","dJobNm":"그물개발원","workSum":"그물에 관련된 공학적 지식을 활용하여 관련 생산공정 및 장치를 설계·개선하거나 신제품을 개발한다.","doWork":"그물에 관련된 논문 등의 자료를 조사·입수하고, 시장성을 조사하여 신제품 개발계획을 세운다. 배의 중량, 바닷물의 속도, 바다의 심도, 어획방법, 고기의 종류 등 여건에 부합한 어망을 제조하기 위해 실의 굵기, 망의 조직, 부이(Float:낚시찌, 부표 등 물 위에 뜨는 물건), 추(Sinker), 당김줄(Leader Line) 등을 연구·개발한다. 개발 결과를 토대로 도면상에 설계하고 조립 방법을 제시한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"섬유기술사, 섬유기사, 섬유산업기사","dJobECd":"1599","dJobECdNm":"[1599]기타 인쇄·목재 등 공학 기술자 및 시험원","dJobJCd":"2399","dJobJCdNm":"[2399]기타 공학 관련 기술자 및 시험원","dJobICd":"C139","dJobICdNm":"[C139]기타 섬유제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006420:1', '{"dJobCd":"K000006420","dJobCdSeq":"1","dJobNm":"목재수분시험원","workSum":"휴대용 전기수분검사기를 이용하여 건조한 목재의 수분 함유량을 확인한다.","doWork":"검사기를 목재의 끝부분에 놓거나 검사기의 전극을 목재 속에 찔러넣어 수치를 읽고 수분 함유량을 측정한다. 측정한 수치를 기록표에 기록하고 목재에 부착한다. 정밀한 측정이 요구되는 경우에는 시료를 채취하여 실험실에서 측정하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"목재함수율시험원","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"1599","dJobECdNm":"[1599]기타 인쇄·목재 등 공학 기술자 및 시험원","dJobJCd":"2399","dJobJCdNm":"[2399]기타 공학 관련 기술자 및 시험원","dJobICd":"C161","dJobICdNm":"[C161]제재 및 목재 가공업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006115:1', '{"dJobCd":"K000006115","dJobCdSeq":"1","dJobNm":"목재칩분석원","workSum":"펄프제조에 사용할 목재 칩(Chip)의 품질과 특성을 확인하기 위하여 견본을 채취하여 시험·분석한다.","doWork":"목재 칩검수원이 보고한 이상한 목재 칩에 대해 견본을 채취한다. 목재 칩을 건조시켜서 저울로 무게를 달고 건조 전의 무게와 비교한다. 분류기를 사용하여 칩(Chip)의 크기와 상태를 분석한다. 함수율 측정기로 목재 칩의 함수율을 측정한다. 이물질의 함량을 검사한다. 목재 칩의 질, 형태 등에 대하여 기록하고, 펄프 제조 원료로서 적정 여부를 판단한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workEnv":"대기환경미흡|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"펄프공정품질관리원","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"1599","dJobECdNm":"[1599]기타 인쇄·목재 등 공학 기술자 및 시험원","dJobJCd":"2399","dJobJCdNm":"[2399]기타 공학 관련 기술자 및 시험원","dJobICd":"C171","dJobICdNm":"[C171]펄프, 종이 및 판지 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007024:1', '{"dJobCd":"K000007024","dJobCdSeq":"1","dJobNm":"물류기술연구원","workSum":"물류의 효율화를 위한 운송, 보관, 하역 등 시스템 및 운용에 필요한 정보화 및 표준화 기술을 연구·개발한다.","doWork":"재화가 공급자로부터 조달·생산되어 수요자에게 전달되거나 소비자로부터 회수되어 폐기될 때까지 이루어지는 운송, 보관, 하역 등과 기타 부가활동에 필요한 제반 기술에 대한 연구를 수행한다. 물류운송기술(Logistic Transportation Technology)분야의 경우, 물류시스템의 효율성 최적화를 위한 전반적인 운송기술을 연구한다. 보관기술(Storage)분야의 경우, 재화를 물리적으로 보존하고 관리하기 위하여 물품의 생산과 소비의 시간적 거리를 조정하여 궁극적으로 시간적 효용을 창조하는 활동에 관련된 제반 기술을 연구한다. 하역기술(Cargo-Working)분야의 경우, 수송과 보관의 양단에 걸친 물품의 취급에 대해서 물자의 이동 및 하역, 시설 내 이동, 피킹(출고될 화물의 정리), 분류 등의 작업에 관련된 제반 기술을 연구한다. 물류정보화기술(Logistics Systems Information Technology)분야의 경우, 물류시스템의 계획 및 정보체계구축을 위한 제반 기술을 연구한다. 물류시스템운용기술(Logistics System Handling)분야의 경우, 수송물류시스템의 거시적 관점에서의 전반적인 분석 및 계획, 절차 등 물류시스템 운용에 관한 제반 기술을 연구한다. 교통수단별 물류운용기술(Logistics Handling by Transportation Method)분야의 경우, 교통수단에 따른 물류의 운반, 이동, 반출 시 운송의 취급방식 등 물류운용에 관한 제반 기술을 연구한다. 물류표준화기술(Logistics Standardization)분야의 경우, 물류시스템의 단순화, 규격화를 통해 물류활동에 공통의 기준을 부여하여 물류체계를 구축하는 기술을 연구한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"협의","workFunc3":"정밀작업","connectJob":"물류운송기술연구원, 물류보관기술연구원, 물류하역기술연구원, 물류정보화기술연구원, 물류시스템운용기술연구원, 물류표준화기술연구원","dJobECd":"1599","dJobECdNm":"[1599]기타 인쇄·목재 등 공학 기술자 및 시험원","dJobJCd":"2399","dJobJCdNm":"[2399]기타 공학 관련 기술자 및 시험원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004577:1', '{"dJobCd":"K000004577","dJobCdSeq":"1","dJobNm":"방사성폐기물인수검사원","workSum":"방사성폐기물처리장에 처분 의뢰된 방사성폐기물이 폐기물인수기준에 적합한지 확인하기 위하여 방사성폐기물 인수검사를 수행한다.","doWork":"처분시설의 인수검사 계획을 수립하고 육안검사기, 방사선량률측정기, 표면오염도측정기, 엑스선검사기, 드럼핵종분석기, 압축강도측정기 등을 사용하여 인수검사를 수행한다. 검사결과의 처분적합성을 확인하고 규제기관으로부터 처분검사를 받는다. 인수검사실과 인수검사기기의 유지·보수와 개선 및 교정업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"1599","dJobECdNm":"[1599]기타 인쇄·목재 등 공학 기술자 및 시험원","dJobJCd":"2399","dJobJCdNm":"[2399]기타 공학 관련 기술자 및 시험원","dJobICd":"E382","dJobICdNm":"[E382]폐기물 처리업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006963:1', '{"dJobCd":"K000006963","dJobCdSeq":"1","dJobNm":"방사성폐기물처리처분연구원","workSum":"방사성폐기물관리 기술개발 업무수행을 위하여 처리, 해체 및 처분 관련 기술개발과제 수행계획을 수립하고 운영한다.","doWork":"중저준위방사성폐기물의 처리, 해체 및 처분 기술개발과 고준위폐기물 관리사업 수행을 위한 처분기술개발 업무를 수행한다. 방사성폐기물 처분사업의 원활한 수행을 위하여 관련 기술의 개발을 지원하고 수리지질, 공학적 방벽, 지화학, 부지감시, 처리 분야의 기술지원 업무를 수행한다. 실증실험동굴을 운영·관리하고 콘크리트 실증실험장치를 모니터링하기도 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","certLic":"지질 및 지반기술사","dJobECd":"1599","dJobECdNm":"[1599]기타 인쇄·목재 등 공학 기술자 및 시험원","dJobJCd":"2399","dJobJCdNm":"[2399]기타 공학 관련 기술자 및 시험원","dJobICd":"E382","dJobICdNm":"[E382]폐기물 처리업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005221:1', '{"dJobCd":"K000005221","dJobCdSeq":"1","dJobNm":"벽지개발연구원","workSum":"벽지의 품질개선, 신제품 및 원·부자재 개발, 생산설비의 효율적 운영 등에 대해 연구하고 제안한다.","doWork":"벽지 생산에 사용되는 주원료의 경제성 여부를 검토·분석한다. 제품의 품질을 향상시키기 위한 새로운 기술을 검토한다. 신제품 개발을 위한 각종 자료를 수집·분석하고 새로운 대체 원료의 적용 여부를 검토한다. 새로운 신소재 및 원료를 적용하기 위하여 시험생산을 통하여 제품화에 따른 타당성을 시험하고 상용화에 따른 작업표준서 및 설명서를 제작한다. 디자인실에서 신제품 디자인이 확정되면 동판, 롤러의 제작을 의뢰하고 시험생산 후 품질검사를 실시하여 합격되면 대량생산을 한다. 제품의 문제점을 파악하여 작업원들에게 해결책을 알린다. 새로운 기계의 도입에 따른 담당 작업원의 교육과 운용에 따른 작업표준서를 만든다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"인쇄산업기사, 임산가공기사 ","dJobECd":"1599","dJobECdNm":"[1599]기타 인쇄·목재 등 공학 기술자 및 시험원","dJobJCd":"2399","dJobJCdNm":"[2399]기타 공학 관련 기술자 및 시험원","dJobICd":"C179","dJobICdNm":"[C179]기타 종이 및 판지 제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004638:1', '{"dJobCd":"K000004638","dJobCdSeq":"1","dJobNm":"사용후핵연료수송저장연구원","workSum":"사용후핵연료의 처리와 처분을 위하여 수송·저장 기술 및 이에 수반되는 용기를 연구·개발한다.","doWork":"사용후핵연료의 안전한 수송·저장시스템을 구축하는 데에 필요한 분야별 기술을 검토한다. 해외 기술사례를 분석하고 관련 기술을 개발하고 관리한다. 수송·저장 및 용기에 관련된 인허가 등에 필요한 기술지원을 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","certLic":"방사성동위원소취급자 일반면허, 원자력기사","dJobECd":"1599","dJobECdNm":"[1599]기타 인쇄·목재 등 공학 기술자 및 시험원","dJobJCd":"2399","dJobJCdNm":"[2399]기타 공학 관련 기술자 및 시험원","dJobICd":"E382","dJobICdNm":"[E382]폐기물 처리업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003459:1', '{"dJobCd":"K000003459","dJobCdSeq":"1","dJobNm":"신발성능평가사","workSum":"보행측정시스템 등을 사용하여 신발의 기능성과 착용성을 측정하고 분석한다.","doWork":"보행측정시스템을 사용하여 보행에 대한 족저압, 지면과 발바닥의 수직반발력 등 신발의 기능성과 착용성을 보행분석기로 측정한다. 3차원의 모델링을 통해 라스트(솔)의 적합성을 평가한다. 라스트의 부위별 치수를 측정하고 비교, 분석을 한다. 측정한 발과 표준발의 체형특성을 비교·분석한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"신발착화평가원","dJobECd":"1599","dJobECdNm":"[1599]기타 인쇄·목재 등 공학 기술자 및 시험원","dJobJCd":"2399","dJobJCdNm":"[2399]기타 공학 관련 기술자 및 시험원","dJobICd":"C152/M701","dJobICdNm":"[C152]신발 및 신발 부분품 제조업 / [M701]자연과학 및 공학 연구개발업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003338:1', '{"dJobCd":"K000003338","dJobCdSeq":"1","dJobNm":"신발시험연구원","workSum":"신발 완제품, 부품, 소재 등에 대해 정량 및 정성적 분석을 하고, 부품 신소재 개발 등 연구 업무를 한다.","doWork":"분석대상 제품 및 분석항목을 검토한다. 분석기기를 준비하고 점검한다. 이화학기기를 포함한 분석기기를 사용하여 신발 완제품, 부품 및 소재를 시험한다. 신발 및 피혁에 관련된 물질의 정량 및 정성적인 분석을 한다. 수입제품에 대한 품질 및 구성성분을 확인한다. 불량제품 여부를 규명한다. 인체함유물질의 함유량을 측정한다. 기존 제품의 품질을 개선하기 위한 연구와 신소재 개발 연구를 한다. 시험결과에 대한 보고서 및 성적서를 작성한다. 기타 연구원(일반)들이 수행하는 일반적인 활동을 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"신발연구원","dJobECd":"1599","dJobECdNm":"[1599]기타 인쇄·목재 등 공학 기술자 및 시험원","dJobJCd":"2399","dJobJCdNm":"[2399]기타 공학 관련 기술자 및 시험원","dJobICd":"C152/M701","dJobICdNm":"[C152]신발 및 신발 부분품 제조업 / [M701]자연과학 및 공학 연구개발업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003813:1', '{"dJobCd":"K000003813","dJobCdSeq":"1","dJobNm":"신발실험실분석원","workSum":"신발 원·부자재와 부품의 시험규격서에 기준하여 물성을 분석하고, 신발 부품과 완제품의 시험규격서에 기준하여 접착과 물성을 분석하여 합격과 불합격을 판정한다.","doWork":"실험실 온·습도를 관리하고 실험기기를 점검하여 최적의 상태를 유지 관리한다. 분석 대상 소재, 부품과 완제품의 분석항목을 검토한다. 실험분석기를 사용하여 신발 소재와 부품의 시험규격서에 기준하여 물성을 분석하여 합격과 불합격을 판정한다. 신발 부품과 완제품의 시험규격서에 기준하여 접착과 물성을 분석하여 합격과 불합격을 판정한다. 판정결과 등을 주요 내용으로 보고서를 작성한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"CE(화공전문가), 신발피혁시험분석원","dJobECd":"1599","dJobECdNm":"[1599]기타 인쇄·목재 등 공학 기술자 및 시험원","dJobJCd":"2399","dJobJCdNm":"[2399]기타 공학 관련 기술자 및 시험원","dJobICd":"C152/M701","dJobICdNm":"[C152]신발 및 신발 부분품 제조업 / [M701]자연과학 및 공학 연구개발업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004954:1', '{"dJobCd":"K000004954","dJobCdSeq":"1","dJobNm":"신발채산규격전문가","workSum":"확정된 신발 견본을 바탕으로 생산에 필요한 자재 및 공정별 표준화된 신발채산서 및 신발규격서를 작성한다.","doWork":"확정된 신발 견본을 바탕으로 생산에 필요한 자재를 분석한다. 소요량을 측정하고, 불량률을 감안해서 채산서를 만든다. 신발생산 공정을 분석하여 재단, 재봉, 창, 생산준비, 제조할 수 있는 기준이 되는 신발생산규격서를 작성한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"채산전문가, 규격전문가","dJobECd":"1599","dJobECdNm":"[1599]기타 인쇄·목재 등 공학 기술자 및 시험원","dJobJCd":"2399","dJobJCdNm":"[2399]기타 공학 관련 기술자 및 시험원","dJobICd":"C152/M701","dJobICdNm":"[C152]신발 및 신발 부분품 제조업 / [M701]자연과학 및 공학 연구개발업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003133:1', '{"dJobCd":"K000003133","dJobCdSeq":"1","dJobNm":"신발프로젝트매니저","workSum":"견본제품 요청서를 분석하여 디자인 콘셉트를 파악하고, 디자이너를 통해 그려진 드로잉(Drawing)에 주요 자재정보, 기술적 요소를 더하여 신발견본 제품을 개발하는 과정을 기획하고 관리한다.","doWork":"신발패턴사, 신발금형전문가, 자재구매전문가와 함께 견본제품 요청서를 분석하여 디자인 콘셉트를 파악하다. 디자이너가 그린 드로잉(Drawing)에 근거하여 패턴을 만들고, 신발 금형을 만들며 자재를 구매하는 업무와 관련하여 지시하고 모니터링하며, 관리한다. 기술적 요소를 분석하여 견본 신발을 만드는 모든 과정을 기획하고, 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"신발PM, 수발","certLic":"신발개발기사, 신발기능사","dJobECd":"1599","dJobECdNm":"[1599]기타 인쇄·목재 등 공학 기술자 및 시험원","dJobJCd":"2399","dJobJCdNm":"[2399]기타 공학 관련 기술자 및 시험원","dJobICd":"C152","dJobICdNm":"[C152]신발 및 신발 부분품 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006394:1', '{"dJobCd":"K000006394","dJobCdSeq":"1","dJobNm":"엘이디조명컨설턴트","workSum":"고객의 환경과 요구에 맞는 최적의 엘이디(LED)조명 제품, 시스템에 대한 컨설팅을 제공한다.","doWork":"엘이디(LED)조명의 도입을 검토하고 있는 고객을 대상으로 가장 효율적인 도입방안을 분석하여 제시하기 위해 조명을 도입할 장소의 기존 조명사용 부화를 조사한다. 조명배치도면과 전력구성도를 분석하여 엘이디(LED)조명의 도입방안에 따른 소요비용과 경제효과 등을 분석·제시한다. 가장 적합한 조명의 배치와 조명제어시스템의 도입 등을 통한 전력절약 등을 컨설팅한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"자문","workFunc3":"관련없음","dJobECd":"1599","dJobECdNm":"[1599]기타 인쇄·목재 등 공학 기술자 및 시험원","dJobJCd":"2399","dJobJCdNm":"[2399]기타 공학 관련 기술자 및 시험원","dJobICd":"C284","dJobICdNm":"[C284]전구 및 조명장치 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003950:1', '{"dJobCd":"K000003950","dJobCdSeq":"1","dJobNm":"제지공정시험연구원","workSum":"종이의 질과 균일성을 조절하기 위하여 표준 시험장비를 활용하여 제지공정에서 채취한 시료를 시험·분석한다.","doWork":"종이를 제조하는 각 공정마다 시간대별로 시료를 채취한다. 온도계를 사용하여 공정별 저장탱크의 온도를 측정한다. 백색도측정기를 사용하여 채취시료의 백색도를 측정한다. 섬유분급기를 이용하여 펄프견본의 섬유분급시험을 한다. 습지강도측정기를 사용하여 각 공정에서 채취된 시료의 습지강도를 측정한다. 산·염기측정기를 이용하여 각 시료의 산성도를 측정한다. 각 공정 및 시간대별 측정치를 기록하고 기준치와 비교·분석한다. 시험, 분석에서 제기된 문제점을 해당 공정이나 부서의 작업자에게 통보한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"특수지공정개선연구원","certLic":"화공기술사, 화공기사, 화공산업기사, 임산가공기사","dJobECd":"1599","dJobECdNm":"[1599]기타 인쇄·목재 등 공학 기술자 및 시험원","dJobJCd":"2399","dJobJCdNm":"[2399]기타 공학 관련 기술자 및 시험원","dJobICd":"C171","dJobICdNm":"[C171]펄프, 종이 및 판지 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;