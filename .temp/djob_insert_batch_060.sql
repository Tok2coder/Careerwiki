INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002741:1', '{"dJobCd":"K000002741","dJobCdSeq":"1","dJobNm":"사리채취기운전원","workSum":"강·호수·바다·만 등의 물속에 있는 골재를 채취하는 사리채취기를 운전한다.","doWork":"작업도면을 읽고 골재채취방법과 앵커설치에 따른 위치와 방법을 결정한다. 예인선(曳引船:주로 다른 선박을 예항(曳航) 또는 압항(押航) 하는 선박)에 의해 예인되는 사리채취기를 골재채취현장에 고정시킨다. 사리채취기를 조작하기 위하여 원동기를 시동한 후 각종 계기를 점검한다. 작업현장의 수심을 측정하고 수심에 의거하여 작업진행방향·거리·굴착깊이·골재량·골재종류 등을 조사·확인한다. 정격 회전수대로 상승시킨 후 래더(Ladder:사다리)를 바닥까지 내린다. 모래나 자갈 등의 골재를 퍼 올리는 연속 버킷이나 펌프를 작동시키기 위하여 구동버튼을 누른다. 버킷에 담아지는 골재의 양에 따라 래더의 적정깊이를 조정한다. 채취한 골재를 운반용 배에 싣는다. 버킷을 완전히 청소한 후 래더를 수면상의 원위치에 두고 메인 클러치를 풀고 원동기를 정지시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"손사용|시각|","workEnv":"위험내재|다습|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"조작운전","similarNm":"골재채취기조작원, 드레져(Dredger)원, 사리재취기조작운전원","connectJob":"준설선","certLic":"건설기계조종사면허증(준설선)","dJobECd":"7040","dJobECdNm":"[7040]건설·채굴 기계 운전원","dJobJCd":"8750","dJobJCdNm":"[8750]건설 및 채굴기계 운전원","dJobICd":"B071","dJobICdNm":"[B071]토사석 광업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002503:1', '{"dJobCd":"K000002503","dJobCdSeq":"1","dJobNm":"쇄석기조종사","workSum":"도로, 토목 및 콘크리트 등의 공사 시 골재 생산을 위해 원석을 일정한 규격과 형태로 부수는 쇄석기(Crusher:크러셔)를 조종·작동한다.","doWork":"작업진행사항을 확인한 후 각종 게이지와 구동윤활개소를 확인·점검한다. 원석을 준비하고 작업지시서나 작업반장의 지시에 따라 분쇄규격과 형태를 결정한다. 분쇄입도에 맞추어 쇄석기의 조(Jaw)와 콘(Cone), 롤(Roll) 등을 조절한다. 덤프트럭에 의해 파쇄기 공급호퍼에 원석이 공급되면 조크러셔, 롤크러셔, 콘크러셔, 오일펌프, 그리즐리(Grizzly:광석, 석탄, 자갈 등을 가려내는 데 사용되는 체질 기계), 진동스크린, 환송장치 등을 작동한다. 에이프런피더(Apron Feeder:에이프런 컨베이어를 사용하여 공급물을 적당량씩 이송하는 장치)의 속도조절 스위치를 조작하고 속도를 조절한다. 철편류 및 나무 등의 이물질이 투입되는지 진행작업을 관찰한다. 투입구 막힘을 방지하기 위해 운전보조원에게 막대기나 대형해머를 사용하여 덩어리를 제거하도록 요청한다. 분쇄된 골재 입경을 확인하고 부품을 재조정한다. 파쇄된 골재 이동을 위해 컨베이어를 조작한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","similarNm":"크러셔운전원, 크라샤운전원, 새석기운전원","connectJob":"아스팔트 믹싱플랜트, 콘크리트 뱃칭플랜트","certLic":"건설기계조종사면허증(쇄석기)","dJobECd":"7040","dJobECdNm":"[7040]건설·채굴 기계 운전원","dJobJCd":"8750","dJobJCdNm":"[8750]건설 및 채굴기계 운전원","dJobICd":"F426","dJobICdNm":"[F426]건설장비 운영업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003504:1', '{"dJobCd":"K000003504","dJobCdSeq":"1","dJobNm":"스노우트랙터운전원","workSum":"슬로프(Slope)의 상태를 유지시키기 위하여 스노우트랙터를 운전하여 필요 이상으로 쌓인 눈을 치우고 슬로프를 고른다.","doWork":"스노우트랙터의 엔진오일, 건전지, 연료의 충진상태 등을 점검한다. 시동을 걸고 조정 간을 조작하여 스노우트랙터를 작업위치로 이동시킨다. 눈을 치우기 위하여 삽날레버를 앞으로 밀어 삽날을 내리고 스노우트랙터를 전진 또는 후진시켜 눈을 고른다. 롤러레버를 밀어 롤러를 내리고 전원스위치를 넣어 롤러를 회전시켜 얼어붙은 눈을 깨뜨리고 슬로프면을 고른다. 제설기나 기타 장비를 작업현장까지 운반한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"손사용|시각|","workEnv":"저온|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"조작운전","similarNm":"스노우트랙터조종원","connectJob":"모터그레이더","dJobECd":"7040","dJobECdNm":"[7040]건설·채굴 기계 운전원","dJobJCd":"8750","dJobJCdNm":"[8750]건설 및 채굴기계 운전원","dJobICd":"R912","dJobICdNm":"[R912]유원지 및 기타 오락관련 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001942:1', '{"dJobCd":"K000001942","dJobCdSeq":"1","dJobNm":"스크레이퍼조종사","workSum":"도로·활주로·골프장·제방·저수지·건물 등의 토공작업에서 굴삭·적재·운반·사토·부설작업을 연속적으로 작업하는 견인식 또는 피견인식 스크레이퍼를 조종 운전한다.","doWork":"현장의 넓이, 운반거리, 지형, 토질 등을 고려하여 작업계획을 세운다. 에이프런(Apron)을 열고, 이젝터 플레이트(Ejector Plate)를 지면에 내리고 전진한다. 볼(Bowl)용량의 스크레이퍼에 흙이 만재되면 이젝터 플레이트를 올려 포설장소까지 이동한다. 포설장소에 도달한 후 이젝터 플레이트를 열어 일정한 두께로 흙을 깔면서 이동한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실외","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"조작운전","similarNm":"스크레이퍼운전원","connectJob":"동력식스크레이퍼운전원, 피견인식스크레이퍼운전원","certLic":"건설기계조종사면허증(롤러)","dJobECd":"7040","dJobECdNm":"[7040]건설·채굴 기계 운전원","dJobJCd":"8750","dJobJCdNm":"[8750]건설 및 채굴기계 운전원","dJobICd":"F426","dJobICdNm":"[F426]건설장비 운영업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005618:1', '{"dJobCd":"K000005618","dJobCdSeq":"1","dJobNm":"슬러셔조작원","workSum":"채굴막장 등에서 채광된 광석을 끌어 내리기 위하여 슬러셔(Slusher)를 조작한다.","doWork":"슬러셔(스크레이퍼를 전진과 후퇴운동을 시켜 광석을 긁어서 이동시키는 시설)를 채굴막장으로 이동하여 설치한다. 도르래블록을 설치할 적당한 개소에서 착암원으로 하여금 앵커볼트 구멍을 천공하게 하고 앵커볼트를 박는다. 슬러셔대에 조명장치를 설치하고 와이어로프 및 스크레이퍼의 이상 유무를 확인한다. 스위치를 넣어 슬러셔를 운전하여 채광된 광석을 스크레이퍼(토사를 굴삭(掘削)하고 운반하는 데 사용되는 기계)로 당겨 끌어내린다. 효율적인 작업수행을 위하여 블록을 적당히 좌·우이동 설치하면서 슬러셔를 운전한다. 운전 중 스크레이퍼가 설치된 파이프를 파손하지 않도록 유의하고, 와이어로프의 절단 유무를 확인한다. 운전작업 시 슈트 밑에 떨어진 광석을 정리하거나 대기 중인 광차에 싣는다. 작업 후 와이어로프를 드럼에 감고 블록과 앵커볼트를 철거한다. 슬러셔를 점검하고 간단한 보수를 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"조작운전","similarNm":"슬러셔운전원","dJobECd":"7040","dJobECdNm":"[7040]건설·채굴 기계 운전원","dJobJCd":"8750","dJobJCdNm":"[8750]건설 및 채굴기계 운전원","dJobICd":"B051/B061/B062","dJobICdNm":"[B051]석탄 광업 / [B061]철 광업 / [B062]비철금속 광업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003380:1', '{"dJobCd":"K000003380","dJobCdSeq":"1","dJobNm":"시추보조원","workSum":"지하에 부존하는 유용광물의 위치와 형태를 조사하기 위하여 시추기 및 그 부속장치를 설치하고 조작하여 시료(Core)를 채취하는 시추기사를 보조한다.","doWork":"시추기사의 지시에 따라 시추장소를 정리한다. 시추기 및 그 부속장치의 설치를 보조한다. 급수용 펌프를 조작한다. 흙물침전약품을 혼합하여 탱크에 보충한다. 로드(Rod)·케이싱(Casing)·코어튜브(Core Tube)·비트(Bit)·호스 등의 장비를 시공현장까지 운반·점검하여 연결한다. 채취된 시료에 시추지점과 심도를 표시하고 심도 순서에 따라 시료상자(Core Box)에 보관한다. 기계에 기름칠하고 시추장비를 수선하는 일을 보조한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"힘든 작업","workPlace":"실외","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|다습|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"시추기조작보조원, 시추장비조작보조원, 시추용천공기조작보조원, 보링기조작보조원, 보링기운전보조원, 시추보조기사","connectJob":"하는 일과 장비에 따라 회전식천공기조작보조원, 케이블식천공기조작보조원, 지하수개발시추보조원, 지하수시추보조원","certLic":"시추기능사, 천공기운전기능사","dJobECd":"7040","dJobECdNm":"[7040]건설·채굴 기계 운전원","dJobJCd":"8750","dJobJCdNm":"[8750]건설 및 채굴기계 운전원","dJobICd":"B051/B061/F412","dJobICdNm":"[B051]석탄 광업 / [B061]철 광업 / [F412]토목 건설업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001748:1', '{"dJobCd":"K000001748","dJobCdSeq":"1","dJobNm":"시추원","workSum":"구조물 기초설계나 지하의 지질적인 특성, 암석의 성질·강도·유형 등의 분석을 위한 지하물질 표본 채취작업을 한다.","doWork":"시추작업 위치로 선정된 구역 내에 잔존하는 잡석 등을 제거한다. 시추기·펌프 등의 배치 및 위험물 취급장소·폐수처리장소 등을 지정한다. 파이프 또는 앵글로 철탑을 조립하고, 시공각도에 맞추어 철탑하부에 시추기를 설치한다. 용수확보지역으로부터 시추공사 시공위치까지 배관 후 양수기를 설치한다. 흙물보관탱크 및 침전탱크를 시추기 옆에 설치한다. 양수용 펌프를 가동시킨다. 흙물을 혼합시킨다. 시추기에 코어튜브(Core Tube)·비트(Bit)·슈(Shoe)·호스 등을 수동공구를 사용하여 연결한다. 시추기를 가동하고 지층에 따라 비트의 회전수·압력·순환 이수량을 결정하고 굴착한다. 일정 깊이까지 굴착시킨 후, 채취된 코어를 인양하기 위하여 철관(Pipe) 상부에 와이어로프로 연결하고 철관을 뽑아낸다. 지층의 붕괴를 방지하기 위하여 케이싱을 보링기 입구에 삽입한다. 암추를 회수하여 코어상자(Core Box)에 담아 보관한다. 침전탱크에서 침전시킨 찌꺼기를 채취하여 비닐봉지에 보관한다. 시추기 및 부속장치를 철수하여 기름칠하고 손상하거나 낡은 부품은 정비한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"힘든 작업","workPlace":"실외","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|다습|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"시추기조작원, 시추장비조작원, 시추용천공기조작원, 보링기조작원, 보링기운전원, 보링원, 보링공, 시추기사","connectJob":"하는 일과 장비에 따라 회전식천공기조작원, 케이블식천공기조작원, 지하수개발시추원, 지하수시추원","certLic":"시추기능사, 천공기운전기능사","dJobECd":"7040","dJobECdNm":"[7040]건설·채굴 기계 운전원","dJobJCd":"8750","dJobJCdNm":"[8750]건설 및 채굴기계 운전원","dJobICd":"B051/B061/F412","dJobICdNm":"[B051]석탄 광업 / [B061]철 광업 / [F412]토목 건설업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006451:1', '{"dJobCd":"K000006451","dJobCdSeq":"1","dJobNm":"시추작업반장","workSum":"구조물의 기초설계나 지하의 지질적인 특성, 암석의 성질·강도·유형 등의 분석을 위한 지하물질 표본을 채취하는 시추 작업을 관리하며, 시추기사 및 시추보조원의 활동을 감독·조정한다.","doWork":"각 시추원에게 지질기사의 지시를 전달하고 굴착심도별 대수층 발달을 기록·유지한다. 작업현장에서 채취된 시료(Core:시험, 검사, 분석 따위에 쓰는 물질이나 생물)를 심도 순서대로 시료상자(Core Box)에 정리한다. 현장작업조건에 맞는 안전조치 및 굴진속도 조절, 시추공벽보강 등 시추현장 전반을 총괄 지휘한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"힘든 작업","workPlace":"실외","workEnv":"위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"수동조작","similarNm":"시추반장, 작업반장","certLic":"시추기능사, 천공기운전기능사","dJobECd":"7040","dJobECdNm":"[7040]건설·채굴 기계 운전원","dJobJCd":"8750","dJobJCdNm":"[8750]건설 및 채굴기계 운전원","dJobICd":"B051/B061/F412","dJobICdNm":"[B051]석탄 광업 / [B061]철 광업 / [F412]토목 건설업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002020:1', '{"dJobCd":"K000002020","dJobCdSeq":"1","dJobNm":"아스팔트믹싱플랜트조종사","workSum":"도로 등 지면 포장에 사용되는 아스팔트를 혼합하고 생산하는 아스팔트믹싱플랜트를 조종한다.","doWork":"아스팔트믹싱플랜트의 연소장치, 배기집진장치, 컨베이어벨트, 혼합장치 등 각종 장치의 상태를 점검하고 확인한다. 가동순서에 따라 배풍기, 송풍기, 믹서, 스크린 등을 가동한다. 각각의 저장소에 골재가 저장되면 생산할 1회분의 양(Batch:배치)을 입력하고 작동을 위해 기계를 조작한다. 운전실의 모니터를 통해 골재의 흐름과 양을 속도제어장치로 조절한다. 생산이 완료되면 배합된 아스팔트혼합물(아스콘)을 덤프트럭 등의 운송장비에 출하한다. 버킷 하부의 슈트(Chute)부 골재 또는 필터의 먼지를 제거하고 기계적 이상 유무를 확인한 후 재가동한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"조작운전","similarNm":"아스팔트혼합장치운전원, 아스팔트믹싱플랜트운전원, 아스팔트혼합장치조종원, 아스팔트믹싱플랜트조종원","certLic":"건설기계조종사면허증(쇄석기)","dJobECd":"7040","dJobECdNm":"[7040]건설·채굴 기계 운전원","dJobJCd":"8750","dJobJCdNm":"[8750]건설 및 채굴기계 운전원","dJobICd":"F421","dJobICdNm":"[F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006816:1', '{"dJobCd":"K000006816","dJobCdSeq":"1","dJobNm":"아스팔트살포기조종원","workSum":"포장공사를 위해 흙이나 자갈에 아스팔트 혼합물(아스콘)이 부착되도록 아스팔트를 가열, 융해 및 살포하는 아스팔트살포기를 운전한다.","doWork":"작업 전에 아스팔트 살포량 및 살포속도를 확인한다. 엔진오일, 연료 등을 확인하고 장비를 점검한다. 작업조건에 적합한 분무재료를 선택하고 선택된 재료를 호스를 이용하여 트럭탱크에 공급한다. 탱크의 외기를 가열하여 아스팔트를 액상으로 만든다. 적정한 양의 아스팔트가 살포되도록 분사대 및 살포량을 조절한다. 도로에 균일하게 살포되도록 살포기를 조종하고 작업상태를 관찰한다. 스크리드(Screed)의 각도와 깊이를 조정한다. 심도측정기를 사용하여 다져 넣은 아스팔트의 깊이를 검사한다. 작업종료 후 장비를 세척하고 이상 유무를 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","similarNm":"아스팔트스프레이어조종원, 아스팔트디스트리뷰터조종원, 아스팔트스프레이어운전원, 아스팔트디스트리뷰터운전원, 아스팔트살포기운전원, 아스팔트살포기조작운전원","certLic":"자동차운전면허(1종 대형)","dJobECd":"7040","dJobECdNm":"[7040]건설·채굴 기계 운전원","dJobJCd":"8750","dJobJCdNm":"[8750]건설 및 채굴기계 운전원","dJobICd":"F426","dJobICdNm":"[F426]건설장비 운영업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003181:1', '{"dJobCd":"K000003181","dJobCdSeq":"1","dJobNm":"아스팔트피니셔조종사","workSum":"도로 및 주차장 등을 포장하기 위해 노면에 가열된 아스팔트 혼합물을 일정한 두께로 깔고 다져주는 아스팔트피니셔를 조종한다.","doWork":"작업일정을 확인한다. 연료, 엔진오일 및 냉각수, 각종 장치 등을 점검한다. 아스팔트 혼합물이 스크리드에 부착되거나 긁힘을 방지하기 위해 스크리드를 예열한다. 아스팔트를 포설할 방향 및 슬래브 두께를 통제하는 센서의 작동 여부를 확인하기 위하여 센서라인(와이어)을 점검한다. 아스팔트 혼합물을 실은 덤프트럭을 아스팔트피니셔의 호퍼에 밀착시키고 엔진을 가동한다. 포장두께 및 포설간격을 조정하고 일정 속도를 유지하면서 피니셔를 조종한다. 포장물질이 포설되는 상태를 관찰하고 아스팔트가 균일하게 포설되도록 스크리드 방향을 조절한다. 콘크리트 도로 포장 시 보조기층, 동상방지층을 포설하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","similarNm":"아스팔트휘니샤조종원, 아스팔트피니셔운전원, 아스팔트휘니샤운전원, 아스팔트피니셔조종원","certLic":"건설기계조종사면허증(롤러)","dJobECd":"7040","dJobECdNm":"[7040]건설·채굴 기계 운전원","dJobJCd":"8750","dJobJCdNm":"[8750]건설 및 채굴기계 운전원","dJobICd":"F426","dJobICdNm":"[F426]건설장비 운영업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004811:1', '{"dJobCd":"K000004811","dJobCdSeq":"1","dJobNm":"준설선운전원","workSum":"항해가 가능하도록 수로를 굴착 또는 보수하거나 호수, 바다, 강 등의 바닥에 모래·자갈·진흙을 파내는 동력준설장비를 운전한다.","doWork":"준설선에서 육상까지 송토관(배사관)을 고무슬리브·볼조인트·앵커·앵커와이어 등으로 연결·설치한다. 각종 회전계·게이지·윤활부위 등을 확인하여 운전상태를 점검한다. 레버를 움직여 준설선을 굴착지점에 위치시키고 수압펌프를 작동시키며 흡입펌프를 상하좌우로 조절하거나 그라브버킷(흡입장치)·커터헤드의 회전을 조정한다. 윈치를 사용하여 흡입거리용 닻대를 드리워 굴착깊이를 결정한다. 풍력·조류 및 전진 시 오차를 수정하기 위해 삼각측량을 실시하여 수시로 위치를 확인한다. 동력윈치나 유압실린더를 사용하여 준설선의 닻을 올리거나 내려 준설선을 전진·이동시켜 위치를 변경시킨다. 누수·누유·누설부분을 점검하여 용접·수리하거나 커터·스윙·스파트·버킷·와이어 등을 교체한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실외","workEnv":"위험내재|다습|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"조작운전","similarNm":"준설기계조종사","connectJob":"운전하는 준설선에 따라 딥퍼준설선운전원, DIPPER준설선운전원, 그래브준설선운전원, GRAB준설선운전원, 버킷준설선운전원, BUCKET준설선운전원, 펌프준설선운전원, PUMP준설선운전원","certLic":"건설기계조종사면허증(준설선)","dJobECd":"7040","dJobECdNm":"[7040]건설·채굴 기계 운전원","dJobJCd":"8750","dJobJCdNm":"[8750]건설 및 채굴기계 운전원","dJobICd":"F426","dJobICdNm":"[F426]건설장비 운영업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001879:1', '{"dJobCd":"K000001879","dJobCdSeq":"1","dJobNm":"중앙분리대설치장비운전원","workSum":"고속도로·일반도로 등의 중앙분리대, 배수로, 난간, 측구 등을 콘크리트로 설치하는 장비를 운전·조작한다.","doWork":"공사현장관리자의 지시와 작업지시서를 보고 작업내용을 파악한다. 장비의 기능이나 작동상태의 이상 유무를 확인·점검한다. 작업계획에 따라 작업에 맞는 몰드(L형 측구, 중앙분리대 등)로 교체한다. 설치할 중앙분리대, L형 측구, 배수로 등의 포설 높이를 일정하게 하기 위하여 그레이를 조절하고 센서를 포설라인에 접촉시킨다. 컨베이어벨트가 달린 호퍼에 레미콘트럭이 콘크리트를 붓도록 지시한다. 유압, 엔진오일, 온도, 센서 등의 계기판상태를 관찰하면서 작업을 진행한다. 포설이 끝나면 콘크리트가 묻어 굳는 것을 방지하기 위하여 컨베이어벨트, 몰드의 내부, 그레이 부위 등을 물로 청소하고 장비의 각 부품을 정비한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"손사용|","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"조작운전","similarNm":"중앙분리대피니셔운전원, 중앙분리대콘크리트피니셔조종원, 중앙분리대콘크리트피니셔운전원","dJobECd":"7040","dJobECdNm":"[7040]건설·채굴 기계 운전원","dJobJCd":"8750","dJobJCdNm":"[8750]건설 및 채굴기계 운전원","dJobICd":"F412","dJobICdNm":"[F412]토목 건설업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002949:1', '{"dJobCd":"K000002949","dJobCdSeq":"1","dJobNm":"착암공","workSum":"지하 또는 노천광산에서 석탄, 금속, 석회석 등의 유용광물을 채취하거나 굴착을 목적으로 착암기 및 부속장치를 설치·조작하여 암반을 천공한다.","doWork":"착암을 하는 작업장을 점검하고 부석·잔류공 등의 위험물을 철재봉을 사용하여 제거한다. 공기압축기의 압력 및 냉각상태 등을 점검한다. 연마기를 사용하여 마모된 드릴비트(Drill Bit)를 규정된 각도까지 연마 후 비트게이지를 사용하여 검사한다. 착암기 설치장소의 낙반 위험성을 점검하고, 위치를 선정한다. 레그(Leg)를 설치하고 착암기를 그 위에 설치한다. 섕크(Shank:삽입된 로드의 상단부)의 마모상태를 점검한다. 작업에 알맞은 길이의 로드의 비트각을 점검하고 섕크에 끼운 후 연결상태를 확인한다. 물·공기호스를 착암기의 압수구와 압기구에 연결한다. 착암기의 작동순서를 숙지하고 주유상태를 확인한다. 스로틀밸브(Throttle Valve:유체의 압력을 낮추는 데 사용하는 밸브) 및 피이드 콘트롤(Feed Control) 밸브를 조정하여 착암기를 운전·점검한다. 막장면의 층리와 절리를 조사하고 막장의 중앙에 심발공의 위치를 분필로 표시한 후 그 주위에 보조공의 위치와 천공방향을 표시한다. 비트의 회전상태 및 물의 분사상태를 확인하고 스로틀 및 피이드 콘트롤 밸브를 조정하여 천공한다. 천공 후 압축공기를 사용하여 천공부위를 깨끗이 세척한다. 착암기 및 부속장치, 지렛대, 호퍼(Hopper:분립체의 저장 및 공급장치), 세척봉 등을 발파에 피해가 없는 안전한 장소로 대피시킨다. 작업 및 보안일지를 작성한다. 작업장의 광·폐석을 갱차에 싣기도 한다. 지보(支保, Timbering)를 갱도에 설치하기도 하며, 착암기를 분해·정비하기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"착암원, 착암기조작원","connectJob":"충격식착암기조작원, 해머식착암기조작원, 회전식착암기조작원","certLic":"천공기운전기능사, 건설기계조종사면허증(천공기, 공기압축기)","dJobECd":"7040","dJobECdNm":"[7040]건설·채굴 기계 운전원","dJobJCd":"8750","dJobJCdNm":"[8750]건설 및 채굴기계 운전원","dJobICd":"B051/B061/B062","dJobICdNm":"[B051]석탄 광업 / [B061]철 광업 / [B062]비철금속 광업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001471:1', '{"dJobCd":"K000001471","dJobCdSeq":"1","dJobNm":"천공기조종사","workSum":"도로·철도·운하·댐 등의 건설 시 폭파작업, 파이프설치, 암석관통 등을 위하여 견고한 바위나 흙 등에 구멍을 뚫는 천공기를 운전한다.","doWork":"구멍을 뚫을 작업장소로 장비를 이동시키고 진동을 방지하기 위하여 장비의 수평을 맞춘다. 작업지시서에 따라 천공 깊이와 간격을 확인한다. 바위의 견고성과 작업성격에 따라 강철드릴이나 바위 뚫는 송곳을 선택하고 수공구를 이용하여 척(Chuck)에 고정시킨다. 점검목록에 따라 작업 전 점검을 체크한다. 공기압축기의 압축공기호스를 장비에 연결시키거나 압축물호스를 장비에 연결시켜 작업상황에 맞추어 사용한다. 굴착추를 천공위치에 정위치시키고 천공각도를 맞춘다. 압축공기밸브나 압축기를 조작하여 공급할 물의 밸브를 열고 엔진의 시동·정지 및 속도를 조절하기 위하여 레버를 조작한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"조작운전","similarNm":"드릴조작원, 천공기조작원, 천공기운전원","connectJob":"천공기기사","certLic":"건설기계조종사면허증(천공기)","dJobECd":"7040","dJobECdNm":"[7040]건설·채굴 기계 운전원","dJobJCd":"8750","dJobJCdNm":"[8750]건설 및 채굴기계 운전원","dJobICd":"F412","dJobICdNm":"[F412]토목 건설업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003831:1', '{"dJobCd":"K000003831","dJobCdSeq":"1","dJobNm":"콘크리트노면처리기조작원","workSum":"도로, 주차장 및 진입로 등 콘크리트로 포장된 노면에 양생제를 뿌리고 미끄럼방지 홈을 내는 타이닝 장비를 조종한다.","doWork":"작업지시서를 보고 작업할 내용을 파악한다. 장비의 기능 및 작동상태의 이상 유무를 점검한다. 장비에 콘크리트를 양생하는 화학혼합물을 채운다. 콘크리트피니셔조종원이 본선 포장을 진행하면 그 속도에 맞추어 콘크리트조면처리기(타이닝장비)를 조종한다. 콘크리트 양생제를 뿌리고 미끄럼 방지용 선을 긋는 장치의 조정레버를 작동하며 작업한 내용을 확인한다. 작업 후 장비를 세척한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","similarNm":"표면마무리기조종원, T/C기사, 콘크리트타이닝장비조종원, 콘크리트노면처리기운전원, 콘크리트타이닝장비조종원, 콘크리트타이닝장비운전원, 콘크리트노면처리기조종원","dJobECd":"7040","dJobECdNm":"[7040]건설·채굴 기계 운전원","dJobJCd":"8750","dJobJCdNm":"[8750]건설 및 채굴기계 운전원","dJobICd":"F426","dJobICdNm":"[F426]건설장비 운영업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006636:1', '{"dJobCd":"K000006636","dJobCdSeq":"1","dJobNm":"콘크리트도로포장기조작원","workSum":"고속도로나 일반도로 등의 교량을 콘크리트로 포장하는 장비를 운전·조작한다.","doWork":"공사현장관리자의 지시와 작업지시서를 보고 작업내용을 파악한다. 포장을 위하여 장비의 기능이나 작동상태의 이상 유무를 확인하고 점검한다. 포장기를 설치하기 위하여 먹줄작업을 하고 먹선의 높이로 레일을 설치한다. 레일이 설치되면 포장기를 기중기 등을 이용하여 레일 위에 올려놓는다. 펌프카 등을 이용하여 포장할 면에 콘크리트를 타설한다. 오가(Augar)와 템퍼 조절기를 작동하여 좌우로 펼쳐주는 스크루와 콘크리트를 다져주는 진동기를 작동시킨다. 스크루에 콘크리트가 쌓여 넘치면 콘크리트공에게 지시하여 긁어내도록 한다. 신호에 맞추어 작업진행속도를 조절하고 진행방향으로 포설한다. 포장이 끝나면 콘크리트가 묻어 굳는 것을 방지하기 위하여 물로 스크루·몰드 등을 청소하고 장비의 각 부품을 정비한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실외","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"조작운전","similarNm":"데크피니셔운전원, 도로포장공","dJobECd":"7040","dJobECdNm":"[7040]건설·채굴 기계 운전원","dJobJCd":"8750","dJobJCdNm":"[8750]건설 및 채굴기계 운전원","dJobICd":"F426","dJobICdNm":"[F426]건설장비 운영업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005826:1', '{"dJobCd":"K000005826","dJobCdSeq":"1","dJobNm":"콘크리트믹서트럭운전원","workSum":"굳지 않도록 생산된 콘크리트(레미콘)를 건설현장으로 운반하기 위해 콘크리트믹서트럭을 운전한다.","doWork":"작업지시서를 확인하고 엔진오일, 연료 등을 점검한다. 콘크리트믹서트럭의 드럼 속에 있는 물을 배출시킨다. 콘크리트배치플랜트(건설공사에 사용되는 시멘트, 모래, 물 등의 재료를 배합비율로 계량하고 혼합하여 액상의 콘크리트를 생산하는 설비)의 배출구와 레미콘 차량의 호퍼를 일치시키고 액상의 콘크리트를 드럼에 주입한다. 차량을 목적지까지 운전하고 포설위치 또는 콘크리트펌프 등의 운반기에 레미콘차량의 배출구를 열어 콘크리트를 포설한다. 작업 후 배출구 등 콘크리트가 남아있는 부분을 세척한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","similarNm":"레미콘차량운전기사, 레미콘차량운전원","certLic":"자동차운전면허(대형)","dJobECd":"7040","dJobECdNm":"[7040]건설·채굴 기계 운전원","dJobJCd":"8750","dJobJCdNm":"[8750]건설 및 채굴기계 운전원","dJobICd":"C233","dJobICdNm":"[C233]시멘트, 석회, 플라스터 및 그 제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005855:1', '{"dJobCd":"K000005855","dJobCdSeq":"1","dJobNm":"콘크리트배치플랜트조종원","workSum":"건설공사에 사용되는 시멘트, 모래 물 등의 재료를 배합비율로 정확하게 계량하고 혼합하여 액상의 콘크리트를 생산하는 콘크리트배치플랜트(Batch Plant)를 조종한다.","doWork":"생산할 콘크리트의 분량을 확인하고 기계의 이상 유무를 점검한다. 콘크리트 생산을 위해 각 저장조에 있는 시멘트, 자갈, 모래, 물 등 자재의 양 및 상태를 모니터 및 수량표시그래프를 통해 확인한다. 생산할 콘크리트의 강도에 맞추어 혼합비율을 조절하여 입력한다. 자재의 혼합상태를 확인하고 믹서기를 조작한다. 혼합이 종료되면 개폐기를 열어 콘크리트 운반차량에 적재한다. 작업이 완료되면 장비를 세척하고 혼합기 및 동력부를 점검한다. 콘크리트 타설장소까지 콘크리트의 운반이 어려울 경우, 작업현장 내에 설치한 이동식 배치플랜트장치를 조작하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"조작운전","similarNm":"콘크리트혼합장치조작원, 콘크리트뱃칭플랜트조종원, 콘크리트뱃칭플랜트운전원, 콘크리트혼합원, 콘크리트혼합공","connectJob":"모바일믹서조종원","dJobECd":"7040","dJobECdNm":"[7040]건설·채굴 기계 운전원","dJobJCd":"8750","dJobJCdNm":"[8750]건설 및 채굴기계 운전원","dJobICd":"F421","dJobICdNm":"[F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002092:1', '{"dJobCd":"K000002092","dJobCdSeq":"1","dJobNm":"콘크리트살포기조종원","workSum":"고속도로·일반도로·주차장·진입로 등의 본선을 포장하기 위하여 콘크리트를 일정 높이와 폭으로 펼쳐서 깔아주는 일차포설 장비를 운전·조작한다.","doWork":"공사현장관리자의 지시와 작업지시서를 보고 작업내용을 파악한다. 작업진행계획을 콘크리트페이버운전원과 콘크리트조면처리기운전원 등과 논의한다. 포장하기 위하여 장비의 기능이나 작동상태의 이상 유무를 확인하고 점검한다. 콘크리트를 포설하기 위하여 몰드의 조정레버를 조정하여 높이와 폭을 시공할 규격으로 조절한다. 자동 높이조절 센서를 포설라인에 설치한다. 덤프트럭이 포설할 부위에 콘크리트를 쏟아주면 동력스위치와 콘크리트를 좌우로 펼쳐주는 스크루 레버를 작동시키고 포설방향으로 운전한다. 스크루에 콘크리트가 쌓여 넘치면 콘크리트공에게 지시하여 긁어내도록 한다. 콘크리트페이버운전원의 신호에 따라 속도를 조절한다. 포장이 끝나면 콘크리트살포기에 콘크리트가 묻어 굳는 것을 방지하기 위하여 물로 청소하고 장비의 각 부품을 정비한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실외","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"조작운전","similarNm":"콘크리트스프래더조종원, 콘크리트스프래더운전원, 콘크리트일차포설기운전원, 콘크리트일차포설기조종원","connectJob":"아스팔트살포기조종원","certLic":"건설기계조종사면허증(롤러)","dJobECd":"7040","dJobECdNm":"[7040]건설·채굴 기계 운전원","dJobJCd":"8750","dJobJCdNm":"[8750]건설 및 채굴기계 운전원","dJobICd":"F426","dJobICdNm":"[F426]건설장비 운영업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005229:1', '{"dJobCd":"K000005229","dJobCdSeq":"1","dJobNm":"콘크리트진동기조작원","workSum":"시멘트, 모래, 자갈, 물이 혼합된 콘크리트를 거푸집 안에 치밀하고 균질하게 충전(충진)하기 위하여 진동을 주어 다지는 기계를 조작한다.","doWork":"진동기(Vibrator)에 진동봉을 연결한다. 콘크리트 혼합상태를 확인하고, 재료가 골고루 혼합되지 않은 부위에 진동봉을 넣어준다. 거푸집 속에 콘크리트를 포설시킬 때 콘크리트의 분리 및 기포발생을 방지하기 위하여 진동봉을 포설위치에 넣어 진동시킨다. 건축물의 측벽, 기둥, 슬래브, 계단, 아치 등 콘크리트가 유입하기 어려운 곳은 손잡이형 진동기(Vibrator)를 사용하여 간접 진동시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"다습|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"조작운전","similarNm":"바이브레이터공, 콘크리트다짐공, 콘크리트바이브레타공, 콘크리트타설공","dJobECd":"7040","dJobECdNm":"[7040]건설·채굴 기계 운전원","dJobJCd":"8750","dJobJCdNm":"[8750]건설 및 채굴기계 운전원","dJobICd":"F411/F412","dJobICdNm":"[F411]건물 건설업 / [F412]토목 건설업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006835:1', '{"dJobCd":"K000006835","dJobCdSeq":"1","dJobNm":"콘크리트펌프카조종원","workSum":"교각, 댐, 빌딩 등을 건설공사에서 콘크리트 타설 위치가 높거나 많은 양의 콘크리트를 타설하기 위해 펌프 및 배관이 장착된 콘크리트펌프카를 조종한다.","doWork":"작업내용을 파악하고 콘크리트펌프의 종류, 압송관의 직경, 배관을 결정한다. 거푸집, 배근 및 콘크리트의 압송 진동 등에 의한 영향을 고려하여 압송관을 설치한다. 압송작업에 문제가 없는지 확인하고 압송이 잘 되도록 압송관에 물을 보낸다. 재료 투입을 위해 레버를 조작해 투입구를 조절하고, 레미콘을 호퍼에 공급하도록 레미콘차량운전원에게 신호를 보낸다. 혼합장치, 펌프, 압축기 등을 조작하고, 펌프재의 유압을 조절한다. 거푸집 및 균열부위를 충전하거나 미장작업을 하는 경우 콘크리트원에게 적정한 위치에 호스노즐을 위치시키도록 요청한다. 압송 완료 후 펌프카를 세척하고 부품 및 장비를 점검한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","similarNm":"콘크리트펌프카조작운전원","certLic":"자동차운전면허(1종 대형)","dJobECd":"7040","dJobECdNm":"[7040]건설·채굴 기계 운전원","dJobJCd":"8750","dJobJCdNm":"[8750]건설 및 채굴기계 운전원","dJobICd":"F426","dJobICdNm":"[F426]건설장비 운영업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004790:1', '{"dJobCd":"K000004790","dJobCdSeq":"1","dJobNm":"콘크리트플래싱붐조종원","workSum":"선조립 철근을 적용하는 건축구조물 공사에 사용되는 콘크리트플래싱붐(CPB:Concrete Placing Boom)을 운용·조종한다.","doWork":"콘크리트플래싱붐(CPB:Concrete Placing Boom, 콘크리트 타설 장비로서 초고압 펌프와의 사이에 배관이 연결되어 있는 장비)을 수직배관 직상부 및 수직배관이 마감공사에 영향을 미치지 않는 곳을 선정하여 설치한다. 안전기준을 점검하고 작동상태 등을 확인하여 시공준비를 한다. 작업지시서와 현장 지휘에 따라 CPB의 무선리모컨 또는 조작레버를 조종하여 붐을 위치시키고 콘크리트를 타설한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|손사용|시각|","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"조작운전","dJobECd":"7040","dJobECdNm":"[7040]건설·채굴 기계 운전원","dJobJCd":"8750","dJobJCdNm":"[8750]건설 및 채굴기계 운전원","dJobICd":"F426","dJobICdNm":"[F426]건설장비 운영업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001664:1', '{"dJobCd":"K000001664","dJobCdSeq":"1","dJobNm":"콘크리트피니셔조종사","workSum":"도로, 주차장, 진입로, 빌딩, 아파트 등에 콘크리트를 포설하고 도로 및 건물의 표면을 평할하게 성형하기 위해 콘크리트피니셔를 조종한다.","doWork":"작업지시서를 확인하고 작업내용을 파악한다. 장비의 기능 및 작동상태의 이상 유무를 점검한다. 콘크리트 포설을 위해 콘크리트피니셔의 센서높이를 조절하고 포설라인에 위치시킨다. 몰드의 조정레버를 조정하여 시공 구격으로 높이와 폭을 조절한다. 일정한 두께로 콘크리트를 포설하는 스크리드를 조작하고 콘크리트를 다져주는 진동기를 작동한다. 피니셔의 속도를 조정하며 작업상황을 관찰한다. 작업 후 장비를 세척한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","similarNm":"콘크리트페이버조종원, 콘크리트피니셔조종원","certLic":"건설기계조종사면허증(롤러)","dJobECd":"7040","dJobECdNm":"[7040]건설·채굴 기계 운전원","dJobJCd":"8750","dJobJCdNm":"[8750]건설 및 채굴기계 운전원","dJobICd":"F426","dJobICdNm":"[F426]건설장비 운영업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004191:1', '{"dJobCd":"K000004191","dJobCdSeq":"1","dJobNm":"토공반장","workSum":"고속도로·일반도로·관개수로·댐·건축 등의 건설공사에서 절토 및 성토, 평탄작업 등의 토공작업을 관리하고, 토공작업원을 감독·조정한다.","doWork":"공사시방서나 도면을 읽고 작업공정표를 작성한다. 기준점을 선정하고 건설현장의 경계를 설정하기 위하여 기준점으로부터 거리를 측정한다. 벌개제근(모공 작업 전에 나무뿌리나 초목 등을 제거하는 작업)과 절토(땅 깎기) 및 성토(흙 쌓기)를 하고 경사진면을 깎고, 토사 등을 운반하는 중장비운전원의 작업을 감독·조정한다. 공사진척에 따라 굴착깊이·경사도·롤링상태 등이 공정표와 일치하는지 확인한다. 중장비운전원과 작업원에게 안전수칙을 교육한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실외","workEnv":"위험내재|","workFunc1":"조정","workFunc2":"감독","workFunc3":"조작운전","connectJob":"벌목반장, 절토반장, 성토반장, 정지반장","certLic":"토목기사, 토목산업기사","dJobECd":"7040","dJobECdNm":"[7040]건설·채굴 기계 운전원","dJobJCd":"8750","dJobJCdNm":"[8750]건설 및 채굴기계 운전원","dJobICd":"F412","dJobICdNm":"[F412]토목 건설업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003902:1', '{"dJobCd":"K000003902","dJobCdSeq":"1","dJobNm":"항타항발기조종사","workSum":"건축물·교량·제방 등의 지반공사 시 약한 지반을 보강하기 위하여 콘크리트·강관파일을 박는 동력해머가 장치된 항타기를 운전한다.","doWork":"도면이나 지질주상도를 보고 항타(말뚝을 박는 것) 시공계획을 세운다. 항타장비를 시공장소까지 이동시킨다. 해머, 파워팩 등의 항타장비를 조립·연결한다. 항타기운전보조원이 파일에 와이어를 걸어 체결한 후 신호에 따라 파일을 끌어올리고, 레버를 조작하여 항타지점에 파일을 정위치시킨다. 공사 종료 후 조립의 역순으로 해체한다. 해머, 파워팩의 기능고장 시 제작 업체에 수리를 의뢰한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실외","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"조작운전","similarNm":"항타기조작원","certLic":"건설기계조종사면허(천공기)","dJobECd":"7040","dJobECdNm":"[7040]건설·채굴 기계 운전원","dJobJCd":"8750","dJobJCdNm":"[8750]건설 및 채굴기계 운전원","dJobICd":"F412","dJobICdNm":"[F412]토목 건설업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003307:1', '{"dJobCd":"K000003307","dJobCdSeq":"1","dJobNm":"갑판원","workSum":"선박의 항로에 방해물이 있는지 감시하고 갑판에 설치된 각종 갑판시설 및 장비를 유지·관리하고 배사관 및 앵커를 설치한다.","doWork":"선박의 구명장비, 화물취급설비, 닻, 케이블 등의 장비를 점검·수리하고, 갑판에 설치된 시설물 및 장비를 보수하며 선박에 페인트를 도장하거나 선체를 정비한다. 배송거리, 토질 및 매립지의 조건을 고려하여 배사관 및 앵커의 설치위치를 결정한다. 갑판에 설치된 시설물 및 장비를 일정한 운전시간마다 점검하고 소모된 부품을 교체한다. 준설여건을 고려하여 해상관, 침설관 및 육상관을 고무슬리브 또는 볼조인트를 연결하여 설치한다. 스윙작업을 위하여 선수 또는 선미에 앵커를 설치한다. 선체의 부식·마멸을 방지하기 위하여 페인트를 칠한다. 작업수행에 필요한 연료, 물, 식료품, 작업장비 등 각종 자재를 운반·적재하고 구명부기, 구명대, 구명동의, 구명부환 등 구명장비를 지정장소에 비치한다. 안개, 태풍 등의 기상악화 상태에서 선박의 안전운항을 위하여 전방이나 후방을 관찰한다. 갑판 위를 청소하거나 정리한다. 구명정 및 소형보트를 관리한다. 선박운항이나 작업수행에 필요한 연료, 물, 식료품, 작업장비 등 각종 화물을 하역 또는 선적하는 화물취급장비를 정비·관리한다. 안개, 태풍 등의 기상악화 상태에서 선박의 안전운항을 위하여 전방이나 후방을 관찰한다. 선교나 뱃머리에서 선박의 항로에 방해물이 있는지 관찰한다. 갑판이나 선박의 주요 시설물에 발생한 녹을 제거하고 페인트를 도장한다. 닻줄, 난간 등의 장비를 보수한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"위험내재|다습|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"투입인출","similarNm":"선박갑판원, 갑판선원","connectJob":"갑판장, 선박갑판장","dJobECd":"6243","dJobECdNm":"[6243]선박승무원 및 관련 종사원(선박객실 승무원 제외)","dJobJCd":"8760","dJobJCdNm":"[8760]선박 승무원 및 관련 종사원","dJobICd":"H501","dJobICdNm":"[H501]해상 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005846:1', '{"dJobCd":"K000005846","dJobCdSeq":"1","dJobNm":"부선관리원","workSum":"호안공사·준설공사 등에서 공사자재나 크레인 등을 운반하거나 탑재·고정하여 작업하는 부선(바지선)을 관리한다.","doWork":"호안석축공사에 소요되는 블록·피복석 등 해상공사 자재나 크레인을 부선에 적재·운반할 때 움직이지 않도록 로프를 잡아준다. 구멍 난 바닥을 용접하고 낡은 드럼통을 교체한다. 부선(바지선)을 고정시키기 위해 닻을 내리거나 말뚝을 박는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실외","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","similarNm":"바지선선두, 바지선선원","dJobECd":"6243","dJobECdNm":"[6243]선박승무원 및 관련 종사원(선박객실 승무원 제외)","dJobJCd":"8760","dJobJCdNm":"[8760]선박 승무원 및 관련 종사원","dJobICd":"F426","dJobICdNm":"[F426]건설장비 운영업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005011:1', '{"dJobCd":"K000005011","dJobCdSeq":"1","dJobNm":"항로표지관리원","workSum":"선박의 항해에 도움을 주기 위한 부표, 등대 등을 관리·조작한다.","doWork":"부표가 설치된 해안을 점검하여 이상 유무를 확인한다. 항로의 암초나 조류를 확인하여 보고자료를 작성한다. 야간 또는 안개, 폭풍 등 기상이변이 발생하면 조명장치 및 음향장치를 가동한다. 통행선박이 부표나 등대에 충돌하면 사고상황과 원인 등을 보고한다. 작업일지를 작성한다. 조명장치나 음향장치의 가동상태를 점검하여 보수하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"다습|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"투입인출","similarNm":"등대원, 부표관리원, 등대지기, 등대선선원","certLic":"항로표지기사, 항로표지산업기사, 항로표지기능사","dJobECd":"6243","dJobECdNm":"[6243]선박승무원 및 관련 종사원(선박객실 승무원 제외)","dJobJCd":"8760","dJobJCdNm":"[8760]선박 승무원 및 관련 종사원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004350:1', '{"dJobCd":"K000004350","dJobCdSeq":"1","dJobNm":"배수장관리원","workSum":"농지에 넘치는 물을 배수로로 퍼내는 배수시설을 관리하고 운영한다.","doWork":"배수장의 펌프, 전동기, 변전설비 및 주변 설비의 이상 유무를 확인하고 필요시 작동될 수 있도록 관리한다. 배수로의 수초 및 오물을 제거하는 등 주변 환경을 정리한다. 홍수로 인한 농지의 물을 빼내기 위하여 배수설비의 조작방법에 따라 조작한다. 홍수 등의 긴급상황 시 신속한 배수작업이 이루어지도록 배수로에 떠내려온 각종 이물질을 제거한다. 각종 배수장 설비의 개보수 및 유지보수에 따른 공사감독을 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"전기산업기사, 전기공사산업기사","dJobECd":"8531","dJobECdNm":"[8531]상·하수도 처리장치 조작원","dJobJCd":"8810","dJobJCdNm":"[8810]상하수도 처리 장치 조작원","dJobICd":"A014","dJobICdNm":"[A014]작물재배 및 축산 관련 서비스업","inqYear":"2022","etc":"수리시설감시원으로 통합"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002953:1', '{"dJobCd":"K000002953","dJobCdSeq":"1","dJobNm":"배수지관리원","workSum":"수용가에게 수돗물을 원활하게 공급하기 위하여 물을 저장·공급하는 시설물인 배수지를 관리한다.","doWork":"배수지의 저장탱크 및 관련 설비를 관리하고 정기적으로 저장탱크를 청소용역업체에 의뢰하여 청결하게 유지한다. 수용자에게 원활한 물 공급을 위하여 정수장의 관련 담당자에게 물 수급 조정을 요청한다. 배수지 내 저수위, 펌프가동상태, 배전반의 작동상태 등의 계기수치를 감시하고 제어한다. 시간대별로 용수 공급량을 조정하여 안정적으로 물을 공급한다. 설비의 이상 및 장애요인 발생 시 관련 부서에 정비를 의뢰한다. 정기적으로 수질검사를 외부 수질검사기관에 의뢰한다. 배수지 주변의 환경을 청결하게 유지하고 제초작업을 한다. 정기적인 배수지 및 관련 시설물을 순시 점검하며, 외부 침입자가 발생되지 않도록 보안관리업무를 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"시각|","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"관망시설운영관리사","connectJob":"청원경찰, 배수지경비 등","certLic":"정수시설운영관리사 1급, 2급, 3급, 경비면허","dJobECd":"8531","dJobECdNm":"[8531]상·하수도 처리장치 조작원","dJobJCd":"8810","dJobJCdNm":"[8810]상하수도 처리 장치 조작원","dJobICd":"E360","dJobICdNm":"[E360]수도업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003718:1', '{"dJobCd":"K000003718","dJobCdSeq":"1","dJobNm":"수리시설감시원","workSum":"농작물 재배에 필요한 농업용수를 원활하게 공급하기 위하여 용수 및 농업생산기반시설물을 효율적으로 관리·운영하기 위한 제반 업무를 지원한다.","doWork":"영농기(4월~9월)에 농업용수 관리 및 농업생산기반시설물(저수지, 양·배수장, 용·배수로, 취입보, 방조제 등)을 감시·관리 업무를 수행한다. (저수지) 급수계획에 따른 통수 및 통수량 조절, 저수량 측정 및 통보, 저수지 수면 내 불법어로 및 불법 경작 단속, 환경오염 방지 및 안전사고 예방을 위한 지도단속, 제당 누수여부 확인 등의 업무를 수행한다. (양·배수장) 급수계획에 따른 가동 및 노선별 통수량 조절, 양·배수장 설비 이상 유무 확인, 취입수조 부유물 제거, 도난, 화재, 동파 안전사고 방지조치 등의 업무를 수행한다. (용·배수로) 문비 조작, 통수 전·후 수로 점검 및 정비, 스크린, 분수문 등 장애물 제거, 유량 및 수위 측정 및 통보, 불법경작·부산물 적치 등 단속 등의 업무를 수행한다. (취입보) 보 취수문 및 배수문, 권양기 조작, 취입구 토사 및 부유장애물 제거, 안전사고 예방을 위한 지도단속 등의 업무를 수행한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"웅크림|손사용|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"수리시설관리원, 양·배수장 관리원, 수로관리원","certLic":"전기산업기사, 전기공사산업기사","dJobECd":"8531","dJobECdNm":"[8531]상·하수도 처리장치 조작원","dJobJCd":"8810","dJobJCdNm":"[8810]상하수도 처리 장치 조작원","dJobICd":"A014","dJobICdNm":"[A014]작물재배 및 축산 관련 서비스업","inqYear":"2022","etc":"수리시설감시원으로 통합"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006766:1', '{"dJobCd":"K000006766","dJobCdSeq":"1","dJobNm":"양수장관리원","workSum":"농작물 재배에 필요한 농업용수를 공급하기 위하여 방조제, 하천, 강 등에서 용수를 끌어오는 양수시설을 관리하고 운영한다.","doWork":"양수장의 펌프, 전동기, 변전설비 및 관련 설비를 유지·관리한다. 용수로의 수초를 제거하는 등의 주변 환경을 정리한다. 농업용수를 농지에 공급하기 위하여 용수로의 용수공급량을 조절하고 관리한다. 양수장의 용수가 투입되는 펌프 주입구에 쌓인 잡초 및 쓰레기를 제거한다. 농업용수를 공급하는 양수설비 및 시설물의 점검을 하여 안전관리를 한다. 양수장과 주변 시설물을 감시하는 작업자의 활동을 감독한다. 양수 작업내용을 작업일지에 기록하고 주요사항을 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"관개시설관리인","certLic":"전기산업기사, 전기공사산업기사","dJobECd":"8531","dJobECdNm":"[8531]상·하수도 처리장치 조작원","dJobJCd":"8810","dJobJCdNm":"[8810]상하수도 처리 장치 조작원","dJobICd":"A014","dJobICdNm":"[A014]작물재배 및 축산 관련 서비스업","inqYear":"2022","etc":"수리시설감시원으로 통합"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005064:1', '{"dJobCd":"K000005064","dJobCdSeq":"1","dJobNm":"정수시설운전보조원","workSum":"원수를 생활 및 공업 용수로 정수하는 설비를 제어 조정하는 정수시설제어운전원을 보조하고 현장설비를 관리·조작한다.","doWork":"생산계획 및 작업내용을 숙지하고 원활한 물 공급이 이루어지도록 설비를 점검한다. 정수시설에 투입되는 응집제, 분말활성탄 등의 약품을 설비에 투입한다. 제어실의 지시에 따라 설비를 점검하고 현장설비를 조작하여 설비를 가동한다. 정수과정에서 발생한 침전지의 고형물을 제거하고 착수정, 혼화지, 응집지, 침전지, 여과지, 정수지를 청결하게 청소한다. 고형물을 오니 처리설비로 운반하고 설비를 조작하여 처리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"정수시설운영관리사","connectJob":"정수기전설비조작원","certLic":"정수시설운영관리사 1급, 2급, 3급, 일반기계기사 또는 산업기사, 화공기사","dJobECd":"8531","dJobECdNm":"[8531]상·하수도 처리장치 조작원","dJobJCd":"8810","dJobJCdNm":"[8810]상하수도 처리 장치 조작원","dJobICd":"E360","dJobICdNm":"[E360]수도업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004109:1', '{"dJobCd":"K000004109","dJobCdSeq":"1","dJobNm":"정수시설제어운전원","workSum":"원수를 생활용수 및 산업용수로 사용하기 위해 정수로 처리하는 각종 설비를 제어·운전한다.","doWork":"원수를 정수처리하기 위하여 수변전설비, 유량설비, 수위설비, 수질계측설비 등의 부속설비와 혼화기, 응집기, 약품투입설비, 여과설비, 소독설비, 탈수처리설비와 같은 정수설비 및 배출수설비의 작동상태를 감시한다. 취수장으로부터 취수된 원수가 착수정에 도달되고 침사지, 혼화지, 응집지, 침전지, 여과지를 거쳐 정수처리한다. 수질관리원의 약품투여량 등에 대한 지시에 따라 원수와 약품의 양을 조절하여 투입한다. 정수된 물을 수용가에게 보내기 전에 염소 등의 약품을 넣어 소독한다. 정수시설의 각종 계기판을 통해 용수공급현황을 확인하고 수압이나 용수분배량 등을 제어장치로 조정한다. 작업내용을 기록하여 보고한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"정수시설운영관리사","certLic":"정수시설운영관리사 1급, 2급, 3급","dJobECd":"8531","dJobECdNm":"[8531]상·하수도 처리장치 조작원","dJobJCd":"8810","dJobJCdNm":"[8810]상하수도 처리 장치 조작원","dJobICd":"E360","dJobICdNm":"[E360]수도업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006149:1', '{"dJobCd":"K000006149","dJobCdSeq":"1","dJobNm":"제염양수원","workSum":"태양열 증발에 의한 천일염을 생산하기 위하여 해수를 취입하고 송수한다.","doWork":"필요시 저수지·증발지·결정지의 수량 및 염분농도를 측정하고 일지에 기록하여 보고한다. 밀물 때 수문을 열거나, 펌프를 사용하여 저수지에 바닷물을 취입한다. 해수의 송수요구가 있으면 저수지의 수문을 열거나, 펌프를 가동시켜 일정한 양의 해수를 증발지로 이동시킨다. 펌프, 운반차, 수문, 함수류 등을 점검하고 필요 물품을 청구하거나 필요시 수리를 의뢰한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workEnv":"다습|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","dJobECd":"8531","dJobECdNm":"[8531]상·하수도 처리장치 조작원","dJobJCd":"8810","dJobJCdNm":"[8810]상하수도 처리 장치 조작원","dJobICd":"B072","dJobICdNm":"[B072]기타 비금속광물 광업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007063:1', '{"dJobCd":"K000007063","dJobCdSeq":"1","dJobNm":"펌프설비운전원","workSum":"수돗물의 원활한 공급을 위하여 원수 또는 정수(淨水)를 정수장과 수요자에게 공급하는 가압설비인 펌프설비(전기설비 포함)를 운전한다.","doWork":"가압설비인 펌프설비의 안전운영을 위하여 배전설비 및 가압설비의 특성과 이상 유무를 파악하고 점검한다. 모니터를 통하여 가압설비인 펌프설비의 운전상태를 감시한다. 취수지로부터 원수를 정수장으로 또는 정수(淨水)를 일반급수지나 배수지로 보내기 위하여 (밸브를 돌리거나) 가압설비인 펌프설비의 전원 스위치를 조작하여 펌프를 (작)가동(·제어한다.)하거나, 제어밸브를 통해 유량을 제어한다. 운영계획(이나)에 따라 (정수시설제어운전원) 정수시설운영관리자와(과) 협의하여 적당량의 (물) 정수가(이) 공급되도록 (장비) 펌프설비를 (조정)운영한다. 이에 따른 송수량 및 전력소모량, 운전시간이나 작동상황을 파악하고 기록한다. 일정 시간마다 펌프실을 순찰하여 이상 유무를 확인한다. 고장 및 장애요인이 있는 설비를 정비하도록 요청한다. 설비운전 내용을 일지에 기록한다. 자동화된 무인 가압장에 상주하며, 가압설비인 펌프설비의 시스템관리 및 운영과 비상사태에 대응하여 가압설비를 조작하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workEnv":"위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"정수시설운영관리사","connectJob":"원수가압설비조작원, 정수가압설비조작원, 무인가압장관리원","certLic":"정수시설운영관리사 1급, 2급, 3급, 일반기계(산업)기사, 건설기계(산업)기사, 전기(산업)기사 등","dJobECd":"8531","dJobECdNm":"[8531]상·하수도 처리장치 조작원","dJobJCd":"8810","dJobJCdNm":"[8810]상하수도 처리 장치 조작원","dJobICd":"E360","dJobICdNm":"[E360]수도업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004775:1', '{"dJobCd":"K000004775","dJobCdSeq":"1","dJobNm":"펌프조작원","workSum":"갱내에서 유출되는 갱내수를 갱외로 퍼내기 위하여 펌프를 조작·유지·관리하고 하천 오염방지를 위한 갱내수 정화시설을 점검·유지·관리한다.","doWork":"펌프의 회전상태, 오일 및 윤활유의 주입상태를 확인·점검한다. 커플링의 볼트, 너트를 조이고 중심을 맞춘다. 밸브의 누수, 배전함의 전류계·압력계·진공계·수면계·경보기·연료차단장치 등을 확인 점검한다. 갱내에서 유출되는 갱내수가 집수지로 모아지는 제반 사항을 관리하고 집수지의 수위를 확인한다. 슬로틀 밸브와 바이패스 밸브를 열어 펌프에 물을 채운다. 레버를 작동하여 펌프를 가동한다. 펌프의 회전이 정상인지 확인하고 바이패스 밸브를 잠근다. 진공계를 보고 정상적인 양수상태, 냉각수의 순환상태, 수류지의 수위상태를 확인한다. 갱내수의 정화시설을 점검·유지·관리한다. 배수량을 측정하고 운전일지를 작성한다. 펌프를 정지한 후 펌프와 모터를 청소한다. 예비용 펌프를 수시로 시운전하여 이상 유무를 확인한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|다습|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","connectJob":"선광용수펌프원, 항내펌프운전원","certLic":"기계기능사","dJobECd":"8531","dJobECdNm":"[8531]상·하수도 처리장치 조작원","dJobJCd":"8810","dJobJCdNm":"[8810]상하수도 처리 장치 조작원","dJobICd":"B051/B061/B062","dJobICdNm":"[B051]석탄 광업 / [B061]철 광업 / [B062]비철금속 광업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002131:1', '{"dJobCd":"K000002131","dJobCdSeq":"1","dJobNm":"폐수처리기술자","workSum":"폐수를 정화하기 위한 폐수처리장치 등을 제어 조작한다.","doWork":"폐수처리장치를 통제하는 중앙통제장치로 온도, 수위 등을 모니터링한다. 폐쇄회로를 통해 현장을 감시한다. 중앙통제장치로 약품투입량, 온도, 수위 등을 조정한다. 여과기, 정수기, 농축조 등 폐수처리 관련 장치 및 설비의 작동 유무를 점검하기 위해 현장을 순찰한다. 침전부유물 등 폐수처리 장치의 밸브를 열어 응집제 등을 직접 투입한다. 열교환기 등 관련 부품이나 설비를 교체한다. 수질 운영 및 작업일지를 작성한다. 설비고장 시 응급처치를 한다. 제어장치 외 폐수를 처리하기 위하여 개별 처리 장비 및 설비를 조작하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"웅크림|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"폐수처리장치중앙제어원, 폐수처리장치조작원","certLic":"수질관리기술사, 수질환경기사, 수질환경산업기사, 환경기능사","dJobECd":"8531","dJobECdNm":"[8531]상·하수도 처리장치 조작원","dJobJCd":"8810","dJobJCdNm":"[8810]상하수도 처리 장치 조작원","dJobICd":"E370","dJobICdNm":"[E370]하수, 폐수 및 분뇨 처리업","inqYear":"2022","etc":"폐수처리기술자로 통합"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004054:1', '{"dJobCd":"K000004054","dJobCdSeq":"1","dJobNm":"하수처리설비중앙제어원","workSum":"중앙 대형 컴퓨터로 하수처리 공정을 감시·제어하며 분산제어 시스템 설비를 관리한다.","doWork":"중앙 대형컴퓨터 시스템 및 네트워크를 이용하여 공정감시, 공정제어, 자료관리, 시스템 유지관리, 계측기 유지관리 업무를 시행한다. 공정별로 기기 운전상태를 확인하고 모니터를 보면서 유량, 수위 등이 정상적으로 작동되는지, 각종 계측기 지시상태와 시스템별 경보기 및 현재 작업상태 등에 이상이 없는지 감시한다. 수시로 시스템이 자동운전이 되고 있는지 무인카메라로 확인하며 유량값 등을 현장과 협의하여 조정한다. 매일 종합 가동일지를 출력하여 자료를 분석하고 시스템설비의 유지를 위하여 현장 신호전송반 패널을 점검하고 하수처리장 컴퓨터 시스템, 데이터 등을 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"수질관리기술사, 수질환경기사, 수질환경산업기사, 환경기능사","dJobECd":"8531","dJobECdNm":"[8531]상·하수도 처리장치 조작원","dJobJCd":"8810","dJobJCdNm":"[8810]상하수도 처리 장치 조작원","dJobICd":"E370","dJobICdNm":"[E370]하수, 폐수 및 분뇨 처리업","inqYear":"2022","etc":"하수처리기술자에 직무 포함 필요"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002168:1', '{"dJobCd":"K000002168","dJobCdSeq":"1","dJobNm":"하수처리장치조작원","workSum":"하수를 처리하기 위하여 탱크, 펌프, 열교환기, 반응탑, 침전장치, 농축조, 탈취장치 등의 처리설비를 관리·조작한다.","doWork":"처리설비의 처리능력 및 가동상황을 점검·확인하고 생물반응조의 미생물 농도를 확인한다. 하수의 유입구 및 부유물 제거장치의 가동상태를 확인하고 하수의 유입량을 점검한다. 펌프, 열교환기, 반응조, 침전장치, 농축조, 탈취장치 등에 부착된 각종 기록계기 및 산도계(pH meter)를 점검하여 정상가동 여부를 확인하고 미생물의 농도를 조절한다. 수시로 처리수의 견본을 채취하여 산도, 생화학적 산소요구량 등을 검사하여 설비를 재조정한다. 각종 설비의 가동상태를 점검하여 누수, 파손, 부식 등의 이상 유무를 확인한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workEnv":"위험내재|다습|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","connectJob":"분뇨처리장치조작원","certLic":"수질관리기술사, 수질환경기사, 수질환경산업기사, 환경기능사","dJobECd":"8531","dJobECdNm":"[8531]상·하수도 처리장치 조작원","dJobJCd":"8810","dJobJCdNm":"[8810]상하수도 처리 장치 조작원","dJobICd":"E370","dJobICdNm":"[E370]하수, 폐수 및 분뇨 처리업","inqYear":"2022","etc":"하수처리기술자에 직무 포함 필요"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002535:1', '{"dJobCd":"K000002535","dJobCdSeq":"1","dJobNm":"분뇨처리기술자","workSum":"도심의 주택, 회사, 공장 등의 정화조에서 배출되는 분뇨 및 슬러지를 위생적으로 처리하여 공공수역으로 방류한다.","doWork":"건물에 설치된 정화조나 재래식 화장실에서 수거차량으로 수거된 정화조 슬러지와 분뇨를 위생처리시설로 정화한다. 위생처리공정에서 발생하는 악취를 운송관을 통하여 탈취시설로 이송시킨 후 알칼리세정 및 산세정 단계를 거쳐서 활성탄, 바이오필터 등을 이용하여 악취물질을 제거하고 굴뚝을 통해 대기 중으로 방출시킨다. 위생처리 후 잔존하는 최종 폐기물은 매립지로 운반하여 매립 등으로 최종처분하고 최종 처리수는 공공수역으로 방류시킨다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|다습|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"수질관리기술사, 수질환경기사, 수질환경산업기사, 폐기물처리기술사, 폐기물처리기사, 폐기물처리산업기사, 환경기능사","dJobECd":"8532","dJobECdNm":"[8532]재활용 처리장치·소각로 조작원","dJobJCd":"8820","dJobJCdNm":"[8820]재활용 처리 및 소각로 조작원","dJobICd":"E370","dJobICdNm":"[E370]하수, 폐수 및 분뇨 처리업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004178:1', '{"dJobCd":"K000004178","dJobCdSeq":"1","dJobNm":"의료폐기물소각처리리원","workSum":"의료폐기물의 반입실태를 확인하고, 소각시설로 반입하여 소각시설을 운전하여 2차오염이 없도록 소각한다.","doWork":"반입되는 의료폐기물의 용기를 확인하고, 전자인수인계서의 부착내용을 확인한다. 부착내용에 있어서 의료폐기물을 종류를 파악한다. 투입구에 호퍼의 상태를 점검한다. 사용하는 연료의 이상 여부를 확인한다. 소각로 폐기물을 투입한 후에 정상소각 여부(온도, 체류 시간 등)을 확인한다. 소각이 종료되어 발생되는 소각재를 확인한다. 소각에 의하여 수반되는 대기오염방지시설의 정상가동 여부를 확인한다. 소각장 주위나 소각 장비를 정리·정돈한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"시범후 30일 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"유지","similarNm":"멸균기운전원","certLic":"폐기물처리기사, 폐기물처리산업기사","dJobECd":"8532","dJobECdNm":"[8532]재활용 처리장치·소각로 조작원","dJobJCd":"8820","dJobJCdNm":"[8820]재활용 처리 및 소각로 조작원","dJobICd":"Q869","dJobICdNm":"[Q869]기타 보건업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006253:1', '{"dJobCd":"K000006253","dJobCdSeq":"1","dJobNm":"폐기물고형연료제조설비운전원","workSum":"생활쓰레기 고형연료 생산에 필요한 설비를 운전하며 필요시 정비한다.","doWork":"생활쓰레기를 투입설비를 이용해 파쇄기로 이동시켜 파쇄한다. 파쇄된 생활쓰레기를 진동스크린, 풍력선별기, 광학선별기, 비중선별기 등 설치된 선별기를 이용하여 선별한다. 선별된 생활쓰레기를 분쇄기로 이동시켜 분쇄한 후 건조한다. 건조기의 온도와 시간이 적정한지 제어판 설정값을 확인한다. 건조가 끝나면 성형기로 이동시켜 고형연료로 사용될 수 있도록 적당한 크기로 성형한다. 성형된 생활쓰레기 고형연료를 저장소로 이동시켜 반출될 수 있도록 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"생활쓰레기고형연료제조설비운전원","dJobECd":"8532","dJobECdNm":"[8532]재활용 처리장치·소각로 조작원","dJobJCd":"8820","dJobJCdNm":"[8820]재활용 처리 및 소각로 조작원","dJobICd":"E382","dJobICdNm":"[E382]폐기물 처리업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001870:1', '{"dJobCd":"K000001870","dJobCdSeq":"1","dJobNm":"폐기물소각로운전원","workSum":"재활용 재생이 불가능한 생활폐기물·사업장폐기물을 연소시켜 처리하는 소각로를 운전한다.","doWork":"소각로와 폐기물 저장조, 폐기물 운반시설, 예열기 등 관련 기기의 정상 여부를 확인한다. 연소상태확인공과 청소구 등을 통해 소각잔재가 남아 있는지 확인하고 잔재가 남아있을 경우 청소한다. 집수조의 방지시설을 점검하고 산도를 조정한다. 소각상태와 효율을 고려하여 소각로의 용량에 대비한 적당량의 폐기물을 일정하게 투입하며 화염이 형성된 소각로에 공기공급량을 조절하여 완전연소가 가능한 온도로 가열한 뒤 출구온도를 유지한다. 온도지시계·자동온도기록계·운전내용자동기록지, 일산화탄소·산소·먼지 연속측정기록장치 등 각종 계측장비가 운전내용을 연속적으로 측정·기록하는지 확인한다. 연소실 내 폐기물이 완전 연소되면 소각로와 주변기기의 작동을 중단하고 소각재 회수장치를 가동하여 소각재를 회수한다. 화재예방을 위해 소각로 주위를 청소한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"폐기물처리기사, 폐기물처리산업기사","dJobECd":"8532","dJobECdNm":"[8532]재활용 처리장치·소각로 조작원","dJobJCd":"8820","dJobJCdNm":"[8820]재활용 처리 및 소각로 조작원","dJobICd":"E382","dJobICdNm":"[E382]폐기물 처리업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002198:1', '{"dJobCd":"K000002198","dJobCdSeq":"1","dJobNm":"폐비닐재활용설비운전원","workSum":"하이덴 폐비닐(High Density:비닐하우스 비닐, 비닐봉지 등) 재생공정을 제어하고 기계설비의 작동상태를 감시하며 각 공정에서 필요한 수동작업을 담당한다.","doWork":"고정크레인으로 하이덴 폐비닐을 선파쇄기에 투입하며 큰 조각으로 파쇄한다. 파쇄한 폐비닐을 스크루컨베이어로 이송시켜 이물질 제거공정에 투입한다. 이물질이 제거된 폐비닐을 파쇄 및 혼합공정에 투입한다. 스크루컨베이어를 가동하여 원형 세정기에 투입하여 세척한다. 드럼스크린을 작동하여 이물질을 분리한다. 이송펌프로 혼합하여 세정기로 이송한다. 스크루로 압착하여 탈수하는 스크루식 탈수기에서 배출된 하이덴 폐비닐을 용융기로 투입한다. 펠릿 중에서 크기와 모양이 알맞지 않은 불량품을 체로 걸러낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"폐기물처리기사, 폐기물처리산업기사","dJobECd":"8532","dJobECdNm":"[8532]재활용 처리장치·소각로 조작원","dJobJCd":"8820","dJobJCdNm":"[8820]재활용 처리 및 소각로 조작원","dJobICd":"E382","dJobICdNm":"[E382]폐기물 처리업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005255:1', '{"dJobCd":"K000005255","dJobCdSeq":"1","dJobNm":"폐형광등재활용처리원","workSum":"관련 법규에 의거 매입 및 소각이 전면 금지된 가정 및 산업용 폐형광 등을 안전하게 재활용하기 위한 각종 기기를 조작한다.","doWork":"폐형광등수거원으로부터 수거된 폐형광등을 동일 길이로 분류하여 자동공급장치의 컨베이어(적재대)에 올려놓는다. 자동으로 투입이 된 폐형광등이 분리기를 거치면서 유리제 외피, 형광물질 파우더, 발광관, 엔드캡 등으로 분리가 되도록 한다. 파쇄기를 거치면서 형광물질 파우더가 제거된 유리제 외피는 파쇄하고, 수은 등 유해한 환경물질이 포함된 발광관은 파쇄한 후 증류기로 이동시킨다. 증류기(히팅오븐)나 원심분리선별기를 이용해 유리나 금속에 잔류해 있는 수은을 회수하고, 캡부분으로부터 금속물질을 회수한다. 회수가 된 수은과 금속물질은 재활용을 위해 이용을 하고 파쇄한 유리는 파기를 위한 공정으로 이동시킨다. 주변을 정리하고 작업장의 수은농도 및 대기 수은농도를 감시하는 시스템을 관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"폐기물처리기사, 폐기물처리산업기사","dJobECd":"8532","dJobECdNm":"[8532]재활용 처리장치·소각로 조작원","dJobJCd":"8820","dJobJCdNm":"[8820]재활용 처리 및 소각로 조작원","dJobICd":"E382","dJobICdNm":"[E382]폐기물 처리업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005530:1', '{"dJobCd":"K000005530","dJobCdSeq":"1","dJobNm":"가구목재성형원","workSum":"자동 목재 성형장치를 사용하여 제품별로 사양에 맞게 원목을 가공하고 다듬는다.","doWork":"자동 목재 가공장치에 원목을 투입하기 전 제품의 모델에 맞게 기계장비를 준비한다. 작업지시서의 내용을 확인하면서 거친 원목 표면을 사포로 연마한 후 연마된 이물질을 에어스프레이로 제거한다. 자동 가공장치와 연결되어 있는 롤 위에 목재를 놓고 기계장비를 가동시켜 차례대로 비닐 위에 놓인 목재들이 가공장치에 투입되도록 작업한다. 제품이 성형되면 가공된 목재 위에 목재용 피복지를 씌운다. 초품에 이상이 없을 때 목재 성형과정을 순차적으로 반복하여 원목을 성형·가공한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"가구자재가공원, 목수","certLic":"가구제작기능사, 목공예기능사","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C320","dJobICdNm":"[C320]가구 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006616:1', '{"dJobCd":"K000006616","dJobCdSeq":"1","dJobNm":"가구목재재단원","workSum":"자동 목재 재단기를 이용하여 제품의 규격에 맞게 자재를 재단한다.","doWork":"작업지시서에 명기되어 있는 제품의 규격, 두께 및 분할도 등을 확인하여 자동 목재 재단장비의 컴퓨터에 치수를 입력한다. 재단할 자재를 롤러 위에 올려놓고 자동재단기를 가동하여 기계 안으로 밀어놓는다. 목재가 재단이 되면 재단된 규격을 자 등으로 확인하고 품목별로 수량을 맞추어 적재한다. 작업지시서와 라벨을 대조·확인한 후 각 자재에 라벨을 붙이고 자재성형원에게 인계한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"목수","certLic":"가구제작기능사","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C320","dJobICdNm":"[C320]가구 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003186:1', '{"dJobCd":"K000003186","dJobCdSeq":"1","dJobNm":"가구연마원","workSum":"사포로 목재의 표면을 부드럽고 매끄럽게 다듬는다.","doWork":"연마할 제품을 작업장에 운반하고 사포의 이상 유무를 확인하고 착색제가 필요한 부품일 경우 도료를 준비한다. 사포를 부품에 대고 사방으로 연마 정도를 확인해 연속 작업하고 연마 상태를 수시로 확인하면서 사포를 교체한다. 접착제가 묻은 곳은 칼자국이 발생되지 않도록 구두칼로 접착제를 제거하고 단계별로 연마강도를 조절한다. 도료를 묻힌 헝겊으로 착색한 후 마른 헝겊으로 닦아준다. 작업이 끝난 부품은 다음 작업이 용이하도록 적재한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"가구사상원","certLic":"가구제작기능사","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C320","dJobICdNm":"[C320]가구 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001721:1', '{"dJobCd":"K000001721","dJobCdSeq":"1","dJobNm":"각끌기조작원","workSum":"결합부의 구조가 장부맞춤일 때에 턱의 가공을 위하여 각끌기를 조작한다.","doWork":"가공부위를 표시한 후 각끌기의 날을 세우고 전후 이동장치를 조절하여 가공할 구멍의 위치와 끌을 맞춘다. 승강핸들을 조절하여 가공할 구멍의 깊이를 조절한다. 가공할 목재를 고정하고 전원을 넣는다. 승강핸들을 눌러 구멍을 파낸다. 구멍가공이 완료되면 승강핸들을 들어 올려 끌날을 목재 위로 빼낸다. 좌·우 이동장치를 조절하여 다음 가공위치로 끌날을 이동한다. 동일한 방법으로 작업을 반복한다. 작업이 완료되면 기계를 정지하고 고정핸들을 돌려 목재를 빼낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","connectJob":"다축각끌기조작원, 단축각끌기조작원, 만능각끌기조작원","certLic":"건축목공기능사","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C161/C162","dJobICdNm":"[C161]제재 및 목재 가공업 / [C162]나무제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004958:1', '{"dJobCd":"K000004958","dJobCdSeq":"1","dJobNm":"갱립톱조작원","workSum":"각종 목재나 합판 등을 규격에 맞추어 길이 방향으로 절단하기 위하여 갱립톱(Gang Rip Saw)을 조작한다.","doWork":"기계커버를 열고 나사를 푼 다음 톱날고정장치를 분해한다. 절단규격으로 톱날을 고정하고 톱날고정장치와의 밀착상태를 점검한다. 목재나 합판의 두께에 맞추어 톱날의 높이 및 가이드를 조절한다. 급유펌프의 윤활유 주입 및 작동상태를 점검한다. 절단할 목재의 두께에 따라 기계의 압력을 조절하고 톱날과 칼날필터를 작동한다. 견본 목재를 테이블 위에 올려놓고 안내목과 밀착시킨 상태로 기계에 투입한다. 절단되어 나오는 목재의 규격을 검사한다. 규격에 이상이 없으면 연속작업을 실시한다. 작업이 끝나면 주위를 청소하고 기계를 정비한다. 각종 목재나 파티클보드 등을 리프터(Lifter) 위에 밀어 올리고, 절단되어 나오는 부재를 검사하고 운반할 수 있도록 밀차 위에 적재하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"길이재단기조작원","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C161","dJobICdNm":"[C161]제재 및 목재 가공업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004202:1', '{"dJobCd":"K000004202","dJobCdSeq":"1","dJobNm":"고속성형절삭기조작원","workSum":"두꺼운 판재를 쟁반형태로 깎거나 액자 등 나무제품의 테두리를 가공하기 위하여 고속성형절삭기를 조작한다.","doWork":"기계 각 부위를 점검하고, 가공할 형태에 적합한 톱날을 선정하여 절삭기에 끼운다. 목재를 준비하고 가공할 부위를 연필로 표시한다. 가공할 위치와 가공 깊이에 맞게 톱날을 조정한다. 기계의 안내자와 테이블의 위치를 조정한다. 기계를 가동하고 목재를 기계의 투입구에 밀어 넣는다. 가공되어 나온 목재의 규격을 확인한다. 작업이 완료되면 기계를 정지하고 주위를 청소한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"목재몰딩기조작원","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C161/C162","dJobICdNm":"[C161]제재 및 목재 가공업 / [C162]나무제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006603:1', '{"dJobCd":"K000006603","dJobCdSeq":"1","dJobNm":"냉압기조작원","workSum":"접착제로 부착된 합판과 심재를 압착하여 접착하는 기계(Cold Press)를 조작한다.","doWork":"냉압관 상·하단부에 있는 오물을 제거한 후 받침판을 놓고 접착하려는 부재(접착제로 부착된 합판과 심재)를 수평 또는 수직으로 적재한다. 부재의 종류나 접착제의 용도에 따라 온도별 가압시간을 조절한다. 균일한 접착이 이루어질 수 있도록 조절기를 조작하여 실내온도를 일정하게 유지한다. 기계를 가동하고 압착되는 상태를 관찰한다. 가압시간과 접착상태를 확인한 후 기계의 압력을 풀고 부재가 완전히 굳을 수 있도록 일정 시간 쌓아 놓는다. 냉압이 완료된 제품을 열압기로 운반한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"냉압처리원","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C162","dJobICdNm":"[C162]나무제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004158:1', '{"dJobCd":"K000004158","dJobCdSeq":"1","dJobNm":"단판감기원","workSum":"합판을 제조하기 위해 절삭된 단·중판을 원추형 통(보빈:Bobbin)에 감는 기계를 조작한다.","doWork":"절삭된 단판의 두께를 확인한다. 절삭된 중판은 손으로 감아 수동클리퍼로 운반한다. 보빈을 권취대까지 내려 컨베이어에 닿게 하고 중판받기 작업자의 도움을 받아 보빈에 단판을 고정한다. 단판이 갈라지는 것을 방지하기 위해 단판 양쪽 끝에 테이프를 붙인다. 보빈을 고정하고 권취대를 하향 조정하여 얇게 깎인 단판을 보빈에 감는다. 보빈에 감은 단판이 풀리지 않도록 단판 끝부분에 고정 못을 꼽거나 끈으로 묶는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C162","dJobICdNm":"[C162]나무제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006084:1', '{"dJobCd":"K000006084","dJobCdSeq":"1","dJobNm":"단판성형기운전원","workSum":"합판을 제조하기 위해 건조기를 통해 건조된 단판이 클리퍼(Clipper)에 의해 재단되고 남은 쪽판을 표준규격으로 성형하는 기계를 조작한다.","doWork":"재단되고 남은 단판 쪽판을 성형기(컴포저:Composer) 작업대로 운반하고 투입구 승강반에 올려놓는다. 기계를 작동하고 승강반을 투입구 높이까지 올린 후 옮겨진 단판 쪽판을 맨 윗부분부터 차례로 한 장씩 투입한다. 투입되는 재료 중 결점이 있는 것은 모서리를 제거하여 성형되지 않도록 하고 가공재는 별도로 적재한다. 성형기 스펀지에 물을 적당히 공급하고 단판성형을 위해 사용하는 테이프의 접합상태를 확인한다. 성형된 단판이 일정량 적재되면 스택커(Stacker)를 내려 재료를 다른 곳에 적재한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C162","dJobICdNm":"[C162]나무제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001491:1', '{"dJobCd":"K000001491","dJobCdSeq":"1","dJobNm":"대차기조작원","workSum":"일정한 길이로 잘린 원목(통나무)으로 일정한 두께의 반제품(혹은 빵재)을 생산하는 대차기(띠톱기계)를 조작한다.","doWork":"대차기에 실린 원목을 육안이나 자로 재어보고 수종, 직경, 나뭇결, 조직, 결점, 형상 등을 고려하여 최적으로 수율(收率)을 내기 위한 제재방법을 구상한다. 제재할 반제품의 두께를 맞추기 위해 기계의 종류에 따라 제어판에 수치를 입력하여 자동으로 조절하거나 해당규격의 핀을 눌러 원목이 일정 두께의 반제품으로 켜지도록 하는 안내판(지그)의 위치를 고정한다. 스위치를 눌러 대차기를 작동시키고, 손잡이를 조작하여 대차를 전진시켜 회전하는 띠톱에 원목을 대어 켠다. 원목이 다 켜지면 다시 손잡이를 조작하여 대차를 환원한다. 위와 같이 대차의 전진과 환원을 반복하면서 원목이 죽데기(Slabs:규정된 치수의 목재로 쓸 수 없는 나뭇조각)만 남을 때까지 켠다. 최신 대차기는 원목의 수율을 높이기 위한 최적의 제재방법을 컴퓨터가 자동으로 계산하고, 레이저로 최적수율을 원목 위에 표시한다. 컨베이어 속도를 조절하기도 하며 쇠갈고리를 사용하여 원목의 위치를 조정하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"원목제재원, 띠톱제재기원","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C161","dJobICdNm":"[C161]제재 및 목재 가공업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003514:1', '{"dJobCd":"K000003514","dJobCdSeq":"1","dJobNm":"둥근톱조작원","workSum":"목재를 세로로 켜거나 경사지게 자르고, 홈을 파는 등 규정된 치수로 절단하기 위하여 둥근톱을 설치·조작한다.","doWork":"절단형태에 따라 원반형의 둥근톱을 선택하여 기계의 축에 렌치를 사용하여 설치한다. 절단 깊이에 따라 테이블을 조절하고 지정된 각도로 기계의 테이블을 기울이기 위하여 수동 휠이나 크랭크를 돌려 고정한다. 테이블 위의 안내목을 고정하기 위해 손잡이를 돌리거나 렌치를 사용하여 고정한다. 기계를 시동하고 목재를 테이블 위에 놓고 안내목을 향하도록 조절하여 톱날을 향해 목재를 민다. 재목의 치수가 명세서와 일치하는지 확인하기 위하여 자, 캘리퍼스, 직각자 등을 사용하여 규격을 잰다. 작업이 완료되면 작업대 주위를 청소한다. 절단할 목재를 작업장으로 운반하고 절단작업 시 정확한 절단을 위하여 톱날에 진입하는 목재의 뒷부분을 잡아 목재가 흔들리지 않도록 받치기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","connectJob":"간이둥근톱조작원, 경사용둥근톱조작원, 레디얼톱조작원, 만능용둥근톱조작원, 버라이어티톱조작원, 버즈톱조작원, 승강용둥근톱조작원, 유니버설톱조작원","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C161","dJobICdNm":"[C161]제재 및 목재 가공업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006195:1', '{"dJobCd":"K000006195","dJobCdSeq":"1","dJobNm":"띠톱조작원","workSum":"목재를 곡선이나 불규칙한 형태로 톱질하거나 두꺼운 재목을 절단하기 위하여 띠톱을 조작한다.","doWork":"수동 휠을 돌려 기계의 정반과 톱날 가이드를 조정한다. 가이드 사이에 절단할 목재를 넣고 기계를 가동한다. 띠톱 날을 향하여 목재를 밀어 넣거나 띠톱 날에 목재를 대고 돌리면서 규정된 형태로 절단한다. 절단된 목재를 꺼내 자, 캘리퍼스 등으로 치수를 재거나 견본과 비교하여 규격을 확인한다. 수동 휠을 돌려 밴드 휠(Band Wheel) 사이에 있는 띠톱 날을 헐겁게 한 후 드라이버나 렌치를 사용하여 띠톱 날을 풀어낸 후 마모된 톱날을 교환한다. 견본을 재목 위에 올려놓고 연필로 본을 뜨기도 한다. 수동띠톱을 사용하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"실톱조작원","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C162","dJobICdNm":"[C162]나무제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001243:1', '{"dJobCd":"K000001243","dJobCdSeq":"1","dJobNm":"러닝톱조작원","workSum":"조립된 목재부품이나 합판을 규정된 치수에 맞도록 절단하는 러닝톱(Running Saw)를 조작한다.","doWork":"절단할 목재를 작업도면과 비교하여 규격을 확인한다. 목재를 작업대 위에 올려놓는다. 톱의 마모와 목재 이송벨트의 이상 유무를 점검한다. 일정한 치수로 절단하기 위하여 기계를 세팅(Setting)한다. 공기스위치를 조작하여 공기압력을 조절하고 소재 눌림대의 가압상태를 점검한다. 기계를 가동하여 목재가 이송되면 톱날 이송스위치를 조작하여 절단한다. 톱날의 후진상태를 확인한 후 제품을 빼내 규격을 확인한다. 작업이 완료되면 공기스위치를 잠그고 기계를 정지한다. 작업이 완료되면 주위를 청소하고 기계를 점검한다. 밀차에 실려 있는 부재(심재 조립된 목재부품이나 합판)를 리프트(Lift) 위로 밀어 올리고, 재단된 제품의 상태를 점검하여 적재하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","connectJob":"패널톱조작원","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C161","dJobICdNm":"[C161]제재 및 목재 가공업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004291:1', '{"dJobCd":"K000004291","dJobCdSeq":"1","dJobNm":"롤러압착기조작원","workSum":"절단, 가공된 소재 단면에 테두리(Edge)를 접착하는 기계(Edge Roller Press Machine)를 조작한다.","doWork":"일정 비율로 접착제와 용제를 혼합하고 접착할 목재를 기계 위에 쌓는다. 테두리 및 목재에 접착할 접착제의 양을 결정하고 도포한다. 도포된 접착제가 자연건조 되도록 일정 시간 방치한다. 기계 부착된 폭 조정 핸들을 돌려 소재 규격보다 약간 높게 압축롤러를 조정한다. 테두리를 목재 패널에 가접착시킨 후 롤러를 가동한다. 회전하는 롤러 사이로 목재를 투입하여 점검한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"에지롤러프레스조작원","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C161","dJobICdNm":"[C161]제재 및 목재 가공업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004944:1', '{"dJobCd":"K000004944","dJobCdSeq":"1","dJobNm":"루터기조작원","workSum":"목재에 가늘고 긴 구멍과 홈, 도안 등을 오목하게 파는 루터기(Router Machine)를 조작한다.","doWork":"작업할 도면에 따라 척 키(Chuck Key)를 사용하여 스핀들 척에 루터 비트를 선택하여 장착한다. 렌치를 사용하여 일정한 간격으로 굴대(Shaft)에 스핀들을 놓고 가공 깊이를 조절하기 위해 수동 휠(Hand Wheel)을 돌린다. 지그에 목재를 고정하고 기계작업대의 가이드홀(Guide Hole)에 핀을 끼운 후 가이드 핀 위에 지그를 놓거나 기계의 이동테이블에 부품을 조인다. 기계 시동 전에 테이블 중앙에 위치한 비트와 지그 위에 놓인 목재와의 가공 위치를 확인한다. 기계 시동 후 목재에 가늘고 긴 틈이나 모서리, 도안, 홈 등을 가공한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","connectJob":"다축루터기조작원","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C161/C162","dJobICdNm":"[C161]제재 및 목재 가공업 / [C162]나무제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003770:1', '{"dJobCd":"K000003770","dJobCdSeq":"1","dJobNm":"리톱기계조작원","workSum":"두꺼운 판재나 큰 각재 또는 넓은 널판을 얇은 널로 절단하기 위하여 리톱(Resaw)을 조작한다.","doWork":"목재의 형태에 따라 절단 방법을 결정한다. 공급롤러(Feed Roller) 사이의 간격을 조정하기 위하여 수동 휠을 돌리거나 레버를 조정한다. 판재의 두께에 맞추어 톱을 조절한다. 톱과 공급롤러의 작동속도를 조절하기 위해 조절 레버를 움직인다. 목재의 끝 부분을 공급롤러에 밀어 넣는다. 절단된 목재의 치수를 확인하고 수동 휠이나 레버로 다시 조절한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"리톱원","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C161","dJobICdNm":"[C161]제재 및 목재 가공업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006580:1', '{"dJobCd":"K000006580","dJobCdSeq":"1","dJobNm":"면취기조작원","workSum":"목재를 대패질하여 형태를 만들고 홈을 파는 목형기계(Spindle Moulder)를 조작한다.","doWork":"모형의 형태를 검토하여 목형기계 설치 순서와 가공할 형태를 결정한다. 제작할 형태에 따라 커팅헤드를 선택하고 렌치 등 수동공구를 사용하여 기계에 장치한다. 목형기계에 모형을 놓고 수동 휠을 돌려 모형에 맞추어 날을 조정한다. 모형을 치우고 잘릴 부분의 깊이가 조정되도록 수동 휠을 돌린다. 기계를 시동하고 공급테이블(Feed Table)에 목재를 올려놓는다. 수동 휠을 돌려서 공급롤러가 목재를 눌러 기계 속으로 투입한다. 가공되는 목재에 결함이 있는지 검사한다. 기계의 종류에 따라 기계에 목재를 자동으로 공급하는 호퍼(Hopper:분립체의 저장 및 공급장치)에 목재를 투입하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"목형기조작원","connectJob":"단축면취기조작원, 쌍축면취기조작원","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C161","dJobICdNm":"[C161]제재 및 목재 가공업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005773:1', '{"dJobCd":"K000005773","dJobCdSeq":"1","dJobNm":"목선반성형기조작원","workSum":"목각인형, 찻잔받침 등 둥근 형태의 목재기물을 가공하기 위해 목선반을 조작한다.","doWork":"둥근 형태로 절단된 나무를 수령하여 작업대로 운반한다. 제품 가공에 사용할 목형 틀을 선반에 끼워 장치한다. 가공에 필요한 재료를 목형틀에 끼우고 망치로 가볍게 두드려 고정한다. 선반을 회전시키고, 평 칼과 둥근 칼로 외형을 깎아낸다. 조각이 끝나면 목재기물을 회전하는 사포에 대어 다듬질한다. 선반을 정지하고 재료를 뒤집어 끼우고 내형을 깎는다. 작업이 완료되면 목형에 맞닿은 모서리를 사포나 연마기로 다듬는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","connectJob":"내형절삭원, 외형절삭원","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C162","dJobICdNm":"[C162]나무제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002652:1', '{"dJobCd":"K000002652","dJobCdSeq":"1","dJobNm":"목선반조작원","workSum":"목재기물을 가공하기 위하여 목재터닝선반(Wood Turning Lathe)을 조작한다.","doWork":"스퍼척(Spur Chuck)과 심압대(Tail Stock) 사이에 목재를 놓고 수동 휠을 돌려 목재의 중심을 표시한다. 선반을 가동하고, 둥근 끌과 캘리퍼스 끌을 고정하여 목재를 향하게 하고 끌을 움직여 목재를 원통형으로 깎는다. 가공형태에 적합한 끌을 선택한다. 회전하는 원통형의 목재기물에 끌을 대어 가공 형태대로 깎아낸다. 캘리퍼스와 자를 사용하여 가공된 기물의 치수를 확인한다. 회전하는 목재에 사포를 대어 표면을 매끄럽게 다듬는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C161","dJobICdNm":"[C161]제재 및 목재 가공업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003724:1', '{"dJobCd":"K000003724","dJobCdSeq":"1","dJobNm":"목재가공기조작원","workSum":"컨테이너용 합판의 모서리를 가공하는 기계(Tenoner)를 조작한다.","doWork":"합판규격에 맞는 날(Cutter)을 선택하여 기계의 회전축에 끼운다. 가공하고자 하는 형태로 기계를 조정하고, 동력스위치를 조작한다. 합판을 컨베이어에 올려놓고 컨베이어 속도를 조절하면서 기계에 투입한다. 모서리가 가공되는 상태를 관찰하고 형태와 규격이 도면과 일치하는지 검사한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"테노나(Tenoner)운전원","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C162","dJobICdNm":"[C162]나무제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005432:1', '{"dJobCd":"K000005432","dJobCdSeq":"1","dJobNm":"목재건조기운전원","workSum":"제재된 목재를 필요한 함수율이 유지되도록 건조하는 건조기를 운전한다.","doWork":"함수율측정기를 사용하여 목재의 수분 함유량이나 무게를 측정한다. 목재의 견본을 오븐에 넣어 견본이 건조해 감에 따라 주기적으로 견본의 무게를 측정하여 수분량 축소의 비율 및 백분율을 결정하여 표준으로 삼는다. 스팀히터 밸브(Steam Heater Valve)를 열고 건조기 내부온도를 일정하게 유지하고, 건조기 내부의 온도, 압력을 나무의 종류에 따라 조절한다. 히터파이프에서 스팀이 유출되는지 점검한다. 건조기의 온도 및 압력, 목재의 무게, 건조시간, 수종 등의 필요한 수치를 컴퓨터 프로그램에 입력하거나 조정판의 버튼을 누르거나 밸브를 개폐하여 조절하고 기록표에 기록한다. 건조가 완료되면 수분측정기를 사용하여 규정된 수분 함유량과 비교·검사한다. 목재의 출고 일시를 정하여 목재의 입·출고 계획을 수립한 후시행한다. 건조기의 이상 유무를 확인 관리하며 건조목의 입·출고를 일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","connectJob":"진공건조기운전원, 제습건조기운전원, 롤러건조기운전원","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C161","dJobICdNm":"[C161]제재 및 목재 가공업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006425:1', '{"dJobCd":"K000006425","dJobCdSeq":"1","dJobNm":"목재건조반장","workSum":"제재된 목재를 건조하기 위해 건조로를 운전하는 작업원의 활동을 감독·조정한다.","doWork":"생산지시서, 명세서 등을 숙지한다. 건조방법을 결정하고 수종별 건조시간, 온도, 압력, 목재무게 등을 결정한다. 목재건조기운전원에게 지시하여 건조실에 스팀을 공급하여 건조한다. 건조 중에 나무가 갈라지거나 틀어지지 않는지 주기적으로 확인한다. 도장된 목재를 건조하는 경우 제어판에 건조스케줄 수치를 입력하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"고온|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C161","dJobICdNm":"[C161]제재 및 목재 가공업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003948:1', '{"dJobCd":"K000003948","dJobCdSeq":"1","dJobNm":"목재밀링기조작원","workSum":"가공한 목제품의 각 부위에 경첩 등을 부착할 수 있도록 홈을 가공하는 기계(Milling Machine)를 조작한다.","doWork":"목제품에 따라 가공할 비트를 기계에 삽입하고 고정한다. 도면과 목재규격을 확인하고 투입 목재에 가공위치를 표시한다. 도면상의 간격을 확인하고 스패너를 사용하여 헤드간격을 조절한다. 경첩의 폭에 맞게 가이드를 조절하고 도면의 간격을 확인한 후 너트를 조인다. 테이블의 높이를 조절하여 비트와의 간격 및 깊이를 맞춘다. 견본 목재를 기계에 투입하여 가공하고 재조정한다. 자동제어 밀링머신을 사용하는 경우 제어판에 수치를 입력하고 자동투입장치를 작동하여 대량생산하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C161","dJobICdNm":"[C161]제재 및 목재 가공업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001303:1', '{"dJobCd":"K000001303","dJobCdSeq":"1","dJobNm":"목재보링기조작원","workSum":"각종 부재를 결합하기 위하여 일정한 간격, 직경, 깊이로 구멍을 뚫는 기계(Boring Machine)를 조작한다.","doWork":"부품가공에 필요한 비트(Bit)의 직경, 깊이 등을 확인하고 기계의 압력, 부품이송벨트를 점검한다. 순서에 따라 상축, 하축, 측축을 분리하고 규격에 맞도록 비트 고정축의 간격을 조절한다. 비트 고정위치에 비트의 캡을 분리하고 좌·우로 돌려 축의 높이를 조절한다. 부재의 크기를 측정하여 정확한 위치에 구멍이 가공될 수 있도록 핸들을 돌려 위치를 고정한다. 견본부재를 투입하여 가공한 후 구멍의 위치, 깊이, 직경 등을 검사한다. 견본부재에 이상이 없으면 연속으로 작업한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","connectJob":"다축보링기조작원, 단축보링기조작원, 탁상보링기조작원","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C161/C162","dJobICdNm":"[C161]제재 및 목재 가공업 / [C162]나무제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002265:1', '{"dJobCd":"K000002265","dJobCdSeq":"1","dJobNm":"목재분쇄기운전원","workSum":"하드보드(Hard Board)나 파티클보드(Particle Board) 등을 제조하기 위하여 죽데기(Slabs:나무쪼가리)를 작은 조각(Chip)으로 분쇄하는 목재분쇄기(Chipping Machine)를 운전한다.","doWork":"목재분쇄기운전보조원(합판제조)이 컨베이어 벨트 위에 올려놓은 죽데기(Slabs)가 분쇄되도록 레버를 당기거나 버튼을 눌러서 목재분쇄기와 컨베이어, 버킷엘리베이터(Bucket Elevator) 등을 가동한다. 막힘을 방지하고 유동성이 좋도록 컨베이어의 속도를 조정한다. 덜 분쇄되어 나온 칩(Chip)은 목재분쇄기에 다시 투입한다. 기계가 막혔을 때에는 컨베이어의 작동을 중단하고 호퍼 및 컨베이어에 엉킨 나무토막을 제거한다. 목재분쇄기와 컨베이어에 기름을 친다. 칩 저장탱크를 관리하기도 한다. 목탄, 목초액 등의 제조에 쓰이는 원목재료칩(Chip)을 분쇄하는 목재분쇄기를 운전하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"약간의 시범정도","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"치핑기운전원, 칩제조기운전원","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C162","dJobICdNm":"[C162]나무제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002470:1', '{"dJobCd":"K000002470","dJobCdSeq":"1","dJobNm":"목재연마원","workSum":"사포, 휴대용 전동사포기, 사포가 부착된 연마기 등을 사용하여 목재 표면이나 절단면을 매끄럽게 연마한다.","doWork":"휴대용 전동사포기나 에어 드라이버에 원통형 연마 비트를 끼우고 드라이버로 죄어 고정한다. 가동스위치를 눌러 회전상태를 점검한다. 목재 표면이나 테두리 접착 면에 대고 거친 면을 연마하고, 손으로 만져서 연마 정도를 확인한다. 수동 휠을 돌려 샌딩벨트(Sanding Belt:전동사포벨트)의 장력을 조절한다. 기계 각 부위를 점검한 후 가동한다. 목재부품의 가공 부위를 확인하고 샌딩벨트에 밀착하여 연마한다. 마모된 샌딩벨트를 교환한다. 조립부분의 과잉 접착제를 칼이나 끌로 제거하기도 한다. 옹이구멍, 균열 등의 결함을 표시하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","connectJob":"드럼샌딩기조작원, 벨트샌딩조작원, 에지벨트샌딩기조작원, 프로파일샌딩기조작원, 목선반사포연마원, 진공방추사포연마원","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C161/C162","dJobICdNm":"[C161]제재 및 목재 가공업 / [C162]나무제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002751:1', '{"dJobCd":"K000002751","dJobCdSeq":"1","dJobNm":"목재조각기조작원","workSum":"목재의 각 부분에 동일한 모양을 동시에 조각하는 다축조각기(Multiple Spindle Caving Machine)를 조작한다.","doWork":"목재의 형태와 조각형태에 적합한 조각칼을 결정하고, 조각부위를 파악한다. 스핀들(Cutter Spindle) 척에 적당한 비트(Bit)를 끼운 후 렌치를 사용하여 고정한다. 목재를 기계의 작업대 위에 놓고 중심부를 맞춘 후 고정나사로 고정한다. 컴퓨터 프로그램을 입력하고 기계를 가동하여 커터 스핀들을 작동한다. 자동으로 조절되는 스핀들에 의해 목재를 원하는 모형으로 조각한다. 다듬질 절삭 바이트(Finish Cutting Bite)와 포인트를 장착하여 조각을 완성한다. 캘리퍼스, 자, 형판 등을 사용하여 제품규격을 측정·비교한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"장식가구조작원","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C161/C162","dJobICdNm":"[C161]제재 및 목재 가공업 / [C162]나무제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006294:1', '{"dJobCd":"K000006294","dJobCdSeq":"1","dJobNm":"목재천공원","workSum":"핸드드릴(Hand Drill)이나 탁상용 드릴을 사용하여 목재에 구멍을 뚫는다.","doWork":"작업에 필요한 목재를 준비하고 드릴의 작동상태를 점검한다. 목재의 가공부위를 정확히 표시한다. 준비된 목재를 작업대 또는 탁상드릴의 선반에 고정한다. 구멍의 크기에 알맞은 드릴 날을 선정한다. 탁상드릴이나 핸드드릴에 날을 끼운다. 드릴을 가동하여 드릴날을 수직으로 유지하며 가공위치에 놓는다. 드릴날을 서서히 밀어 넣어서 가공하고, 작업이 완료되면 서서히 들어 올린다. 기계를 중지하고 작업부위를 사포 등으로 다듬는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","connectJob":"핸드드릴조작원","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C161","dJobICdNm":"[C161]제재 및 목재 가공업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005254:1', '{"dJobCd":"K000005254","dJobCdSeq":"1","dJobNm":"목재칩정선기조작원","workSum":"목재 칩을 펄프제조용 원료로 사용할 수 있도록 이물질을 제거하는 정선설비를 조작한다.","doWork":"작업지시서를 확인하고 작업내용을 파악한다. 목재 칩 저장사일로의 저장상태, 목재 칩 이동 컨베이어의 상태, 칩 정선기의 작동 여부, 물탱크의 수량 등을 점검한다. 목재 칩을 정선하기 위하여 야적장관리원에게 원료투입을 지시한다. 성형된 목재 칩(Chip)의 크기를 확인한다. 컨베이어의 가동스위치를 조작하여 목재 칩의 투입량이나 방향 등을 조정하고, 칩정선기에 원료가 투입되는 상태를 관찰한다. 칩정선기에서 걸러진 규격 이상의 목재 칩을 파쇄기로 보내 잘게 부순 다음 다시 투입한다. 물탱크의 밸브를 조절하여 정선기 내부로 적정량의 물이 투입되도록 조절한다. 정선된 목재 칩의 상태를 검사하고 작업내용을 작업일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C171","dJobICdNm":"[C171]펄프, 종이 및 판지 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006620:1', '{"dJobCd":"K000006620","dJobCdSeq":"1","dJobNm":"목재평삭기조작원","workSum":"가구, 악기, 칠판 등에 사용되는 목재부품들의 표면을 매끄럽게 다듬는 평삭기를 조작한다.","doWork":"렌치와 계기를 사용하는 커터헤드(Cutter Head)에 날을 골라 장착한다. 수동 휠을 돌려서 깎을 깊이, 목재의 두께에 따라 테이블 높이를 조정하고 공급롤러를 조절한다. 평삭기를 시동하고 컨베이어 위에 목재를 놓거나 목재를 평삭기로 운반하는 공급롤러 사이에 목재를 끼운다. 가공선 목재의 표면과 두께를 계기와 자를 사용하여 검사한다. 커터를 날카롭게 연삭하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C161","dJobICdNm":"[C161]제재 및 목재 가공업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003202:1', '{"dJobCd":"K000003202","dJobCdSeq":"1","dJobNm":"목재홈톱질원","workSum":"완성된 목제품의 결함부위를 잘라내기 위해 목재홈톱(Stock Patch Saw)을 조작한다.","doWork":"목제품을 조사하여 결함부위를 파악하고 결함의 길이와 깊이에 따라 기계를 조정하기 위하여 레버를 조작한다. 목재를 기계의 테이블 위에 올려놓고 목재의 결함부분을 톱날 아래로 밀어 넣는다. 결함부위를 절단하기 위해 페달을 눌러 톱날을 내린다. 작업이 완료되면 페달을 풀고 결함부분이 절단된 목재를 빼낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C161","dJobICdNm":"[C161]제재 및 목재 가공업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003995:1', '{"dJobCd":"K000003995","dJobCdSeq":"1","dJobNm":"무늬목슬라이서조작원","workSum":"원목을 무늬목(합판 등의 표면에 붙이는 얇은 판)으로 자르기 위해 슬라이싱기(Slicing Machine)나 로터리를 조작한다.","doWork":"무늬모양에 따라 원목의 절단방법을 결정한다. 칼날을 기계의 칼날 조임쇠에 걸고 핸들을 돌려 조임쇠를 조인다. 호이스트를 이용하여 원목을 들어 올려서 슬라이싱기의 원목조임쇠에 물려준다. 자를 사용하여 원목이 수평이 되도록 조정하고 원목 조임쇠를 조여서 고정한다. 원목을 무늬목으로 얇게 자르기 위해 슬라이싱기의 기어를 렌치로 조정한다. 기계작동스위치를 눌러서 무늬목을 생산하고, 더 이상 무늬목을 생산할 수 없는 원목조각은 조임쇠를 풀고 기계로부터 제거한다. 버니어캘리퍼스로 무늬목의 두께를 측정한다. 칼날을 갈아 끼우거나 거칠어진 칼날을 연마기로 갈기도 한다. 원형톱으로 원목을 일정 길이로 자르기도 한다. 무늬목을 재단기로 일정 규격에 맞게 자르기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"슬라이싱기조작원","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C162","dJobICdNm":"[C162]나무제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001306:1', '{"dJobCd":"K000001306","dJobCdSeq":"1","dJobNm":"무늬목열압처리원","workSum":"가접착된 무늬목합판을 경화·접착하기 위하여 열압기를 조작한다.","doWork":"열압기의 작동 유무를 점검한다. 제품의 종류에 따라 온도, 압력을 조정한다. 승강반에 무늬목을 접착시킨 제품을 적재한다. 무늬목합판 위에 내열필름을 올려놓고 열판에 투입한 다음 열압기를 작동한다. 일정한 시간이 지나면 작동스위치를 끄고 열압된 상태를 확인한다. 열판을 내리고 제품을 반출한다. 육안으로 열압된 제품의 겹침, 벌어짐 등을 검사하여 불량품은 보수한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|고온|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C162","dJobICdNm":"[C162]나무제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006458:1', '{"dJobCd":"K000006458","dJobCdSeq":"1","dJobNm":"무늬목접착원","workSum":"수지가 도포된 합판 위에 무늬목을 접착한다.","doWork":"제품규격 및 작업방법을 확인하고 재단된 합판을 조판대로 운반한다. 합판표면의 도포상태를 확인하고 고객의 주문이나 작업지시서에 따라 무늬목의 종류를 준비하여 접착한다. 무늬목이 접착되면 무늬배열상태, 간격, 틈, 겹침, 오물 등의 외관검사를 하고 컨베이어 위에 올려 열압처리 공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"약간의 시범정도","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C162","dJobICdNm":"[C162]나무제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003972:1', '{"dJobCd":"K000003972","dJobCdSeq":"1","dJobNm":"방부처리반장","workSum":"생산된 목재에 방부, 방충, 난연성을 부여하기 위하여 방부제나 방충제 등의 화학약품을 사용하여 방부처리하는 작업원의 활동을 감독·조정한다.","doWork":"생산지시서, 명세서 등을 숙지하고 방부처리 방법을 결정한다. 방부처리 순서, 방부처리에 쓰이는 화학약품의 종류, 방부탱크(주약처리관) 내의 압력 및 온도, 목재가 방부탱크 속에 있어야 할 시간 등을 작업원에게 지시한다. 계기와 공정표를 관찰하여 장비의 기능장애를 탐지하여 기능장애를 바로잡을 수 있도록 방부탱크 내의 온도, 압력, 액체의 높이 등을 조절한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C161","dJobICdNm":"[C161]제재 및 목재 가공업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006867:1', '{"dJobCd":"K000006867","dJobCdSeq":"1","dJobNm":"방부처리원","workSum":"건축외장재 및 어린이놀이시설물, 조경시설물, 지주재 등의 건축용재와 철도침목 등으로 쓰이는 판재나 각재 같은 목제품에 압력을 가해 방부제나 방충제 등의 화학약품을 처리하는 주약처리 과정을 조정·관리한다.","doWork":"물과 방부약품을 약품혼합탱크에 넣고 자동교반기를 사용하여 혼합한다. 비중계를 사용하여 방부약품과 물의 배합비율이 목재의 종류나 용도에 적당한지 측정한다. 제조 농도에 적합하지 않으면 물이나 방부약품을 투입하여 농도를 맞춘다. 방부액이 준비되면 방부처리보조원에게 지시하여 대차에 결속 및 적재된 목재를 방부탱크(주약처리관)에 넣도록 한다. 방부탱크의 뚜껑을 렌치를 사용하여 닫아서 밀폐한다. 감압, 가압, 후감압의 순차적인 과정에 따른 시간을 제어판에 입력한다. 온도, 진공상태, 압력상태, 용액높이 등이 규정된 수준으로 유지되어 있는지 확인한다. 버튼을 눌러 탱크 내의 공기와 증기를 없애 주는 진공펌프와 처리속도를 빠르게 하는 가압펌프를 작동한다. 방부처리 중에 일정 시간 간격으로 방부탱크의 작동 여부를 확인한다. 방부처리가 끝나면 방부처리보조원에게 지시하여 방부탱크에서 대차를 꺼내도록 한다. 방부처리 과정이 자동으로 기록된 플로어차트를 분석하고 기록한다. 방부계획서를 작성한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C161","dJobICdNm":"[C161]제재 및 목재 가공업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004241:1', '{"dJobCd":"K000004241","dJobCdSeq":"1","dJobNm":"분열방지밴드압입원","workSum":"목재나 철도침목이 갈라지지 않도록 압입프레스나 망치를 사용하여 강철밴드(Band)를 압입한다.","doWork":"지게차로 제재 규격에 맞추어 절단된 목재나 침목을 작업장으로 운반한다. 목재나 침목에 압입프레스나 망치를 사용하여 일정 형태(S형, C형 링)의 강철밴드를 목재나 철도침목의 끝부분에 박는다. 고정되었는지 확인한 후 마무리작업을 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"H491","dJobICdNm":"[H491]철도 운송업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006175:1', '{"dJobCd":"K000006175","dJobCdSeq":"1","dJobNm":"수압대패기조작원","workSum":"이동식 기계대패(Hand Feed Planer)를 사용하여 목재의 표면을 고르게 깎는다.","doWork":"이동식 기계대패의 테이블 높이를 조정한다. 직각자 또는 각도기를 사용하여 기계대패의 기준각도를 조정한다. 대팻날의 위치를 조정하고 기계를 가동한다. 정상 회전속도가 되면 목재의 넓은 면을 대패질하여 기준면으로 정하고 삼면을 깎는다. 가공이 완료되면 치수를 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C161","dJobICdNm":"[C161]제재 및 목재 가공업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006396:1', '{"dJobCd":"K000006396","dJobCdSeq":"1","dJobNm":"에지밴딩기조작원","workSum":"절단된 목재 부재의 테두리를 접착 및 가공하는 기계(Double Edge Bending Machine)를 조작한다.","doWork":"기계의 이상 유무를 확인하기 위하여 계기판을 점검한다. 알갱이로 된 접착제를 통에 채우고 용해 온도를 점검한 후 가열한다. 밀차에 밀려온 부재를 작업준비대 위로 밀어 올린다. 작업지시서에 따라 기계의 온도, 압력, 기계 축의 간격, 포머커터(Former Cutter), 롤러의 부재 공급속도 등을 조정한다. 기계를 가동하여 컨베이어 벨트에 이상이 없는지 점검한다. 견본 부재를 시험가공하여 접착·가공상태를 점검하고 규격에 이상이 없으면 연속작업을 실시한다. 작업이 완료되면 주위를 청소하고 기계를 점검한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","connectJob":"싱글에지밴딩기조작원, 더블에지밴딩기조작원","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C161","dJobICdNm":"[C161]제재 및 목재 가공업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004803:1', '{"dJobCd":"K000004803","dJobCdSeq":"1","dJobNm":"열압성형기운전원","workSum":"파티클보드, 하드보드, 코르크보드 등 목재 판재를 생산하기 위하여 접착제가 도포된 칩을 스틸벨트(Steel Belt) 위에서 판 형태로 성형하고 프레스로 열압하는 설비를 운전한다.","doWork":"도포칩 이송 벨트 컨베이어 및 스크류 컨베이어를 가동한다. 성형기의 칩 적재장에 칩이 정상적으로 공급되는지 확인한다. 성형기의 각종 작동모터를 조작한다. 스틸벨트 위에 매트를 형성한다. 보일러를 가동하여 열판의 온도를 적정 온도로 유지한다. 냉각수의 순환 여부를 확인한다. 펌프를 가동하여 적당한 압력을 유지한다. 열압 준비가 완료되면 성형된 매트를 프레스 열판 내부로 이송한다. 열압기(Hot Press)를 작동하여 제품을 생산한다. 각 기계의 계기 작동 상태를 수시로 점검하여 열압된 제품상태를 점검한다. 스팀밸브를 열고 열판온도를 규격에 맞추어 조절한다. 차저(Charger:제품을 한 장씩 받치게끔 만든 판)와 열판의 상승 및 하강 등 기기의 작동 상태를 확인한다. 제품의 수량 및 수지 종류에 따라 단위압력, 열압시간을 타이머로 조절한다. 냉압 처리된 제품을 승강판에 적재하고 열판과 제품의 청결상태 등을 확인한다. 롤러에 가접착한 제품을 한장씩 투입하여 제품종류에 따라 일정 높이까지 쌓는다. 차저에 제품이 열판 밖으로 나오는지의 여부를 확인한다. 열판 속으로 제품의 투입이 완료되면 열판을 올리고 온도, 열압시간을 규정에 따라 조절하여 열압한다. 열압작업이 완료된 합판을 적재한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","connectJob":"하드보드열압성형기운전원, 파티클보드열압성형기운전원","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C162","dJobICdNm":"[C162]나무제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004792:1', '{"dJobCd":"K000004792","dJobCdSeq":"1","dJobNm":"원목박피기조작원","workSum":"원목의 나무껍질을 벗기기 위해 박피기(Debarker)를 조작한다.","doWork":"레버를 움직여서 절단기의 헤드 밑으로 통나무를 나르는 컨베이어의 롤러를 들어 올리거나 낮춘다. 기계의 버튼을 눌러 가동한다. 레버를 움직이거나 수동 휠을 돌려서 통나무의 모양과 크기에 따라 기계의 커팅헤드의 압력을 조절하고 통나무를 회전시켜 나무껍질을 제거한다. 절단날을 교체하거나 연마기로 절단날을 연마한다. 오일캔과 그리스(Grease:기계의 마찰 부분에 쓰는 끈적끈적한 윤활유) 주입기를 사용하여 기름을 치기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실외","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C161","dJobICdNm":"[C161]제재 및 목재 가공업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006474:1', '{"dJobCd":"K000006474","dJobCdSeq":"1","dJobNm":"원목절단원","workSum":"원목재단위치표시원이 분필이나 페인트로 표시한 위치에 따라 체인톱(Chain Saw)을 사용하여 원목을 일정한 길이로 절단한다.","doWork":"원목 야적장이나 작업장에서 체인톱으로 절단할 원목을 손으로 밀어 앞으로 옮긴다. 절단 위치에 체인톱을 직각방향으로 갖다 댄다. 버튼을 눌러 체인톱을 작동하고 절단 위치에 압력을 가해 원목을 절단한다. 줄자나 측정기구를 사용하여 원목의 길이나 직경을 측정하여 절단하는 위치를 표시하기도 한다. 절단되거나 절단할 원목의 수량, 재적, 투입량 등을 일지에 기록하기도 한다. 체인톱에 기름을 칠하거나 연마기로 톱날을 연마하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"조목원, 체인톱조작원","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C161","dJobICdNm":"[C161]제재 및 목재 가공업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006343:1', '{"dJobCd":"K000006343","dJobCdSeq":"1","dJobNm":"원목절삭기조작원","workSum":"합판 제조 시 박피(나무 껍질을 벗김)된 원목을 규격에 맞는 두께로 절삭하는 기계를 조작한다.","doWork":"박피된 원목을 기계로 들어 올려 로터리 작업대(Rotary Lathe)의 양 스핀들(Spindle:원목을 고정시키는 장치) 사이로 이동시켜 원목의 높이나 수평거리 등을 조절하면서 중심잡기 척에 원목단구의 중심점을 고정(Chucking)한다. 원목이 로터리 작업대의 스핀들에 완전히 고정되면 중심잡기 척을 원위치시킨다. 원목과 칼날과의 거리를 약간 벌리고 최저속도로 회전하면서 잔여 오물을 제거한다. 단판의 감기는 속도와 스핀들 회전과의 균형을 조절하고 절삭두께를 표시하는 게이지를 관찰하면서 절삭한다. 나무표피 절삭이 끝나면 중간칼을 올리고 절삭칼을 조정한 후 판면의 상태를 구분하면서 절삭한다. 박심(박피를 절삭하고 남은 중심부분의 심목)이 될 때까지 절삭이 완료되면 스핀들 회전을 중지하고 스핀들을 후퇴시켜 박심을 제거한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C162","dJobICdNm":"[C162]나무제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002809:1', '{"dJobCd":"K000002809","dJobCdSeq":"1","dJobNm":"윤곽형삭기조작원","workSum":"목재조립 부분의 형태를 가공하거나 견본의 윤곽대로 목재의 외관을 절단하기 위하여 윤곽형삭기(Shaper)를 조작한다.","doWork":"목재의 외형, 형태 또는 작업지시서에 명시된 절단형태에 따라 절단날을 선정한다. 횡축에 있는 커터헤드의 틈에 날을 끼우고, 견본의 윤곽에 따라 날을 가지런히 맞춘다. 수동공구를 사용하여 커터헤드의 볼트를 돌려 날을 조인다. 렌치를 사용하여 기계의 작업대 위에 견본이나 모형을 고정한다. 기계를 시동한다. 목재를 클램프 아래에 놓고 멈춤장치를 향하도록 조절한다. 페달을 눌러 클램프가 자동으로 닫히는 기계장치를 작동하고, 회전커터를 향해 목재를 이송하거나 회전커터를 목재로 이동하여 가공한다. 작업이 완료되면 목재와 회전커터를 분리하고 클램프를 푼다. 목재와 절단할 윤곽의 형태에 따라 목재 또는 회전커터의 이동속도를 조절하는 나비형 나사를 돌리기도 한다. 모양과 규격을 검사하기 위하여 견본품과 가공품을 비교한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"목공예기능사","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C161","dJobICdNm":"[C161]제재 및 목재 가공업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004131:1', '{"dJobCd":"K000004131","dJobCdSeq":"1","dJobNm":"자동대패기조작원","workSum":"제재된 목재표면을 규정된 두께로 다듬기 위해 자동대패기를 조작한다.","doWork":"가공할 목재를 수령하고 작업지시서에 명시된 가공치수를 확인한다. 수동 휠을 돌려 표면을 다듬을 치수와 목재의 두께에 따라 테이블의 높이와 절단날을 조정한다. 기계를 가동한다. 목재를 공급롤러에 넣고 균형을 잡는다. 작업표준서에 따라 규격검사를 한다. 작업이 완료되면 주위를 청소하고 기계를 점검한다. 칼날을 연마하거나 교체하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","connectJob":"자동단면대패기조작원, 자동사면대패기조작원, 자동삼면대패기조작원, 자동이면대패기조작원","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C161","dJobICdNm":"[C161]제재 및 목재 가공업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003925:1', '{"dJobCd":"K000003925","dJobCdSeq":"1","dJobNm":"자동선반조작원","workSum":"목재부분품을 둥글게 또는 여러 가지 형태로 가공하는 자동선반을 조작한다.","doWork":"설계도면을 검토하여 완성품의 크기와 모양을 파악한다. 형판(Template), 자, 캘리퍼스, 렌치 등을 사용하여 절단날을 기계 스핀들의 절상부에 장치한다. 목재의 회전과 가공형태를 조절하기 위하여 적당한 캠(Cam)을 선정하여 기계에 장치한다. 주축대(Head Stock)와 심압대(Tailstock) 사이에 목재를 끼우고 크랭크를 돌려 정확한 위치에 목재를 고정한다. 기계를 작동하고 레버를 움직여 가공이 완전히 이루어질 때까지 목재를 회전시키거나 호퍼피딩(Hopper Feeding)이 부착된 기계를 자동으로 작동한다. 가공이 완료되면 제품의 규격을 점검한다. 연삭기를 사용하여 칼날을 연마하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"회전식선반조작원","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C320","dJobICdNm":"[C320]가구 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004460:1', '{"dJobCd":"K000004460","dJobCdSeq":"1","dJobNm":"장부가공기조작원","workSum":"악기, 가구 등에 사용하는 목재의 끝부분을 맞추기 위하여 장부를 깎은 기계(Tenoner Machine)를 조작한다.","doWork":"제품도면을 검토하여 사용할 톱날, 커터헤드(Cutter Head), 지그(Jig), 캠(Cam)등의 크기와 형태 및 고정위치를 결정한다. 톱날, 커터, 부속물을 선택하고 자와 렌치를 사용하여 장부의 두께에 따라 기계에 설치한다. 기계측면에 부착된 핸들로 톱의 간격을 장부의 길이와 동일하게 조절한다. 톱이 회전하는 방향으로 고정나사를 결속하고 렌치로 고정한다. 기계를 시동하여 회전상태를 확인하고, 재목을 기계운반대 위의 가이드로 향하도록 한다. 운반대를 기계 속으로 밀어 재목이 커터 사이로 이송되게 하거나 공급체인 위에 재목을 도그(Dogs)와 가이드를 향해 놓아 기계 속으로 이송되도록 한다. 공정이 끝난 재목을 꺼내어 가공 상태를 확인한다. 기계가 작동하는 동안 수동 휠을 돌려 커터헤드 사이의 간격을 넓히거나 좁히기도 하고 잘못된 곳을 조절하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","connectJob":"조작하는 기계의 종류에 따라 다축장부기조작원, 단축장부기조작원, 복열사이자조작원, 압축장부가공기조작원, 횡축장부가공기조작원","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C320","dJobICdNm":"[C320]가구 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002915:1', '{"dJobCd":"K000002915","dJobCdSeq":"1","dJobNm":"접착제도포검사원","workSum":"합판을 제작하기 위하여 단판과 중판을 접합하는 접착제의 혼합상태와 도포상태를 검사한다.","doWork":"접착제를 검사유리판 위에 놓고 유리막대로 얇게 편다. 모래, 먼지, 녹 등의 이물질을 육안으로 검사하고 제거한다. 각종 실험도구를 사용하여 표준온도 및 표준습도에서의 접착상태를 검사한다. 접착제를 중판에 도포하기 전에 저울로 중판무게를 평량하고 도포되어 나온 중판의 무게를 측정하여 도포 전후의 무게 차이를 비교한다. 단위 면적당 도포량을 측정하고 과대도포와 과소도포된 불량품은 구분·적재하여 해당 부서에 수정작업을 통보한다. 검사결과를 검사일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C162","dJobICdNm":"[C162]나무제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006227:1', '{"dJobCd":"K000006227","dJobCdSeq":"1","dJobNm":"접착제투입기운전원","workSum":"하드보드(Hard Board) 제조 시 생산된 섬유 간의 접착력을 보강하기 위한 접착제와 내수성 강화를 위해 사용하는 왁스를 첨가한 접착제투입기(Glue Injection System)를 운전한다.","doWork":"작업지시서의 배합비율 표에 따라 접착제 및 왁스 등의 화학약품을 계량하여 원료탱크에 투입한다. 접착제투입기의 펌프와 밸브 작동 관련 조정장치를 점검한다. 생산제품에 따른 접착제의 양을 입력한 후 투입기를 조작한다. 제품 상태를 확인한 후 입력량을 다시 수정한다. 제품의 품질을 검사하고 생산일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C162","dJobICdNm":"[C162]나무제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006335:1', '{"dJobCd":"K000006335","dJobCdSeq":"1","dJobNm":"제재기조작원","workSum":"대차기로 제재한 반제품(혹은 빵재)을 테이블(Table)식 제재기를 사용하여 제재기보조원과 함께 규정된 치수의 각재나 판재로 켠다.","doWork":"제재할 각재나 판재의 규격을 맞추기 위해 기계의 종류에 따라 컴퓨터 제어판에 수치를 입력하거나 해당 규격의 핀을 눌러 반제품이 일정 두께의 각재나 판재로 켜지도록 하는 안내판(지그)의 위치를 고정한다. 작업대 위에 반제품을 올려놓고 띠톱작동스위치를 넣어 띠톱을 회전시킨다. 테이블제재보조원에게 작업시작 신호를 한다. 목재의 한쪽 끝은 손으로 움직여 복부에 대고 곧게 켜지도록 목재를 주시하며 복부로 목재를 밀어 회전하는 띠톱에 댄다. 한쪽을 켜고 난 다음에 작업대 위로 미끄러져 돌아온 목재를 받아 같은 방법으로 되풀이하여 일정 치수의 각재나 판재를 켠다. 죽데기(Slabs:제재하고 남은 찌꺼기)만 남을 때까지 켜고, 죽데기는 후공정으로 인계하여 야적장, 창고 등에 적재하도록 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"시각|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"테이블제재원, 소할제재기조작원","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C161","dJobICdNm":"[C161]제재 및 목재 가공업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007080:1', '{"dJobCd":"K000007080","dJobCdSeq":"1","dJobNm":"제재반장","workSum":"원목(통나무)이나 제재목을 규정된 방법에 따라 제재하는 데 종사하는 작업원의 활동을 조정·감독한다.","doWork":"작업지시서를 보고 제재할 목재의 형태와 규격, 수종을 확인하고 생산계획을 세우며 작업원을 배치한다. 제재기계의 이상 유무를 수시로 확인하며 이상이 있는 기계는 관련 부서에 수리하도록 의뢰한다. 작업 중이나 작업이 끝나면 재료와 제품을 검사하여 규격과 등급이 작업지시서와 일치하는지 확인한다. 결함을 바로잡기 위해 기계를 재조정하거나 공정절차를 조정하도록 작업원에게 지시한다. 주문에 맞게 생산하기 위해 필요한 재료의 양과 수종을 결정·계산한다. 제재된 목재를 재질이나 치수 등에 따라 구분하여 적재·정리하거나 죽데기(Slabs:제재하고 남은 찌꺼기)를 골라내는 일을 하는 작업원의 활동을 감독·조정하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"시각|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C161","dJobICdNm":"[C161]제재 및 목재 가공업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007019:1', '{"dJobCd":"K000007019","dJobCdSeq":"1","dJobNm":"중판삽입원","workSum":"성형된 중판을 단판과 접착하기 위하여 접착제 도포기(Spreader)에 손으로 한장씩 투입한다.","doWork":"성형된 중판을 승강반에 적재하여 운반한다. 승강반을 접착제 도포기 투입구까지 올리기 위하여 버튼을 조작한다. 회전하는 롤러 사이로 중판을 한 장씩 투입한다. 판면 전체에 골고루 접착제가 도포될 수 있도록 빗자루 등을 사용하여 오물을 제거한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"약간의 시범정도","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"투입인출","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C162","dJobICdNm":"[C162]나무제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004293:1', '{"dJobCd":"K000004293","dJobCdSeq":"1","dJobNm":"중판성형기운전원","workSum":"합판제조를 위해 절삭·건조된 편매(중판을 이어 붙이기 위해 절단한 단판)를 규정치수에 맞추어 접착하고 성형하는 기계를 조작한다.","doWork":"기계의 온도를 확인하고 계절에 따라 접착제의 농도를 조절한다. 칼날을 조정하고 컨베이어를 가동한다. 적재된 편매를 검사하여 화목, 포장재, 중절용, 두께불량, 요철, 엇결, 폭 부족 등의 불량요소를 선별한다. 불량품은 별도 적재함에 적재하고 합격중판은 절단각도를 고려하여 뒷면을 위로 하여 투입방향을 결정한다. 맞춤벨트에 완전히 밀착시키면서 기계에 투입한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"코어빌더조작원","dJobECd":"8821","dJobECdNm":"[8821]목재 가공기계 조작원","dJobJCd":"8911","dJobJCdNm":"[8911]목재가공 관련 기계 조작원","dJobICd":"C162","dJobICdNm":"[C162]나무제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;