INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003111:1', '{"dJobCd":"K000003111","dJobCdSeq":"1","dJobNm":"형틀목공","workSum":"콘크리트 타설 또는 흙막이 공사를 위하여 형틀을 제작하고 설치한다.","doWork":"설계도면을 검토하여 필요한 장비 및 공구를 준비한다. 합판과 각재를 치수에 따라 먹줄을 긋고 절단한다. 기계톱, 기계대패 등의 마름질용 기계를 사용하여 마름질한다. 설치할 위치에 수평기(레벨)를 사용하여 수평을 잡고 거푸집을 조립한다. 철근공이 철근으로 기둥·옹벽 등을 세우고 내선전공이 전선관 및 부속물을 설치하면 기둥거푸집과 보거푸집을 설치한다. 설치된 거푸집의 수평도·수직도 및 설치상태 등을 검사한다. 콘크리트를 충분히 양생한 후 거푸집 및 지주를 제거한다. 거푸집 및 지주가 해체되면 주위를 정리하고 다음 작업을 준비한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"힘든 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"형틀공, 형틀목수, 형틀목수공, 거푸집설치공, 거푸집설치원, 거푸집설치기능원","certLic":"거푸집기능사","dJobECd":"7016","dJobECdNm":"[7016]건축 목공","dJobJCd":"7824","dJobJCdNm":"[7824]건축 목공","dJobICd":"F421","dJobICdNm":"[F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003545:1', '{"dJobCd":"K000003545","dJobCdSeq":"1","dJobNm":"경량벽돌조적공","workSum":"건축구조물의 내·외벽을 구축하기 위하여 방음·보온성이 우수한 경량벽돌(ALC)을 조적한다.","doWork":"설계도면을 검토하고, 건물의 규모, 모양 등을 파악한다. 시공에 필요한 장비 및 공구를 준비한다. 바닥과 벽면에 경량벽돌(ALC)의 두께를 고려하여 먹줄을 놓는다. 벽 중심으로부터 경량벽돌의 두께 먹을 낸다. 시멘트모르타르를 사용하여 바닥면의 수평을 잡는다. 규격에 맞도록 절단톱을 사용하여 경량벽돌(ALC)을 절단한다. 바닥수평면 위에 경량벽돌(ALC)의 모서리 부분을 먼저 쌓고, 수평실에 의해 중앙부를 쌓는다. 벽면과 경량벽돌(ALC)은 밴드플레이트에 타정공구로 못을 박고, 경량벽돌(ALC)은 플레이트를 박아 고정시킨다. 경량벽돌(ALC) 위에 경량벽돌(ALC)모르타르를 바른다. 정확한 치수로 양쪽 끝을 마무리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"경량벽돌조적원, ALC조적원, ALC조적공","dJobECd":"7017","dJobECdNm":"[7017]조적공 및 석재부설원","dJobJCd":"7825","dJobJCdNm":"[7825]조적공 및 석재 부설원","dJobICd":"F421","dJobICdNm":"[F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002443:1', '{"dJobCd":"K000002443","dJobCdSeq":"1","dJobNm":"보도블럭설치원","workSum":"인도, 공원의 산책로, 광장 등에 콘크리트 또는 석재 보도블록을 포설한다.","doWork":"보도블록 포설장소를 시방서에 지시된 깊이로 파고 바닥을 고르며 침하가 우려되는 곳에는 다짐을 한다. 바닥에 일정 두께로 모래를 깔고 탬퍼(Tamper:포장 공사에서 콘크리트 등의 표면을 두드려 다지는 도구)를 사용하여 다진다. 모래 위에 수평하게 블록을 포설하고 모서리를 덮는 마감블록은 콘크리트절단기를 사용하여 절단 후 포설한다. 계측기로 블록 포설면의 수평도를 점검한다. 포설 블록 위에 모래를 얇게 펴고 블록과 블록 사이의 줄눈을 모래로 메우거나 스페이서를 설치한다. 모서리에 시멘트모르타르를 바른다. 시공여건에 따라 보도블록작업이 편리하도록 경계석을 설치하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실외","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"도로경계석설치원","dJobECd":"7017","dJobECdNm":"[7017]조적공 및 석재부설원","dJobJCd":"7825","dJobJCdNm":"[7825]조적공 및 석재 부설원","dJobICd":"F421","dJobICdNm":"[F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004302:1', '{"dJobCd":"K000004302","dJobCdSeq":"1","dJobNm":"조적공(일반)","workSum":"건축물의 내·외벽, 기둥, 담장과 같은 수직구조물을 구축하기 위하여 벽돌, 콘크리트 블록 등을 쌓는 일을 한다.","doWork":"수평기, 내림추, 물수평기를 사용하여 수평·수직을 맞춘다. 시공 바닥면을 모르타르나 기타 재료로 수평을 맞춘다. 시멘트, 모래, 물을 일정 배합비로 혼합하여 모르타르를 준비한 후 벽돌이나 블록을 설계도면에 맞게 쌓는다. 조적면의 균열방지를 위하여 일정 간격으로 매시 등 고정철물을 묻어 쌓는다. 버팀대, 연결대 등을 써서 위치를 정확히 유지하고, 창문 등 개구부 상부에 인방을 설치한 후 벽돌을 쌓는다. 물, 빛, 소음 등이 차단되도록 벽돌 사이 공간을 보강한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"조적원","connectJob":"하는 일에 따라 벽돌조적원, 내화재조적원, 블록조적원, 치장벽돌공, 축로원, 연돌공, 줄눈공","certLic":"조적기능사","dJobECd":"7017","dJobECdNm":"[7017]조적공 및 석재부설원","dJobJCd":"7825","dJobJCdNm":"[7825]조적공 및 석재 부설원","dJobICd":"F421","dJobICdNm":"[F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004721:1', '{"dJobCd":"K000004721","dJobCdSeq":"1","dJobNm":"조적반장","workSum":"건축물의 내·외벽, 기둥, 담장과 같은 수직구조물을 구축하기 위하여 벽돌, 콘크리트 블록 등을 조적하는 작업을 관리하고 조적공 및 조적보조원의 활동을 감독·조정한다.","doWork":"설계도면을 읽고 작업계획을 수립한다. 조적시공지점 주위를 점검하고 조적재의 선별, 적재 및 구입, 배분 등을 결정·지시한다. 작업계획에 따라 세부실행항목을 수립하여 작업 절차 및 방법을 결정한 후 작업원에게 작업내용을 지시하거나 작업배치를 한다. 표준명세에 따라 지시된 작업이 이루어지는지 작업원과 함께 작업하면서 작업내용을 점검한다. 조적상태를 점검하고 불량부분을 재시공하도록 지시한다. 작업진행상황을 파악하여 작업내용을 보고한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원 및 자재 공급을 한다. 작업원에 대한 직무교육 및 안전위생교육을 실시한다. 수시 관찰과 면담을 통하여 작업원의 애로사항 및 건의사항을 수렴·해결하고 문제점을 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"벽돌조적반장","certLic":"조적기능사","dJobECd":"7017","dJobECdNm":"[7017]조적공 및 석재부설원","dJobJCd":"7825","dJobJCdNm":"[7825]조적공 및 석재 부설원","dJobICd":"F421","dJobICdNm":"[F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004111:1', '{"dJobCd":"K000004111","dJobCdSeq":"1","dJobNm":"조적보조원(일반)","workSum":"건축물의 내·외벽, 기둥, 담장과 같은 수직구조물을 구축하기 위하여 벽돌, 콘크리트 블록 등을 조적하는 조적원을 보조한다.","doWork":"벽돌, 블록 등의 조적재와 시멘트모르타르 및 작업공구를 시공장소에 운반한다. 모래, 시멘트, 물을 일정 비율에 맞게 적당량을 혼합한다. 높은 곳의 조적작업이 편리하도록 안전작업발판을 조립한다. 시공 전후 작업장과 그 주위를 정리·정돈한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"벽돌조적보조원","certLic":"조적기능사","dJobECd":"7017","dJobECdNm":"[7017]조적공 및 석재부설원","dJobJCd":"7825","dJobJCdNm":"[7825]조적공 및 석재 부설원","dJobICd":"F421","dJobICdNm":"[F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004757:1', '{"dJobCd":"K000004757","dJobCdSeq":"1","dJobNm":"축로공","workSum":"노(爐) 및 레이들(Ladle)에 축조된 내화물의 파손된 부위를 보수하거나 축조한다.","doWork":"노(爐:증기 기관과 같은 가마에서 연료를 태우는 부분) 및 레이들(Ladle:제강공장의 노에서 정련·용해된 강인 용탕(熔湯)을 받는 쇳물 바가지)에 축조된 내화물의 흠, 균열 및 침식 여부를 육안관찰하고 연와망치로 내화물을 두드려 연와의 강도를 점검하여 이상 여부를 확인한다. 보수할 내화물을 제거하고 작업대를 설치한다. 보수하거나 새롭게 축조하기 위하여 연와흙손, 연와망치, 고무망치, 래머(Rammer:달구), 착암기, 모르타르믹서기 등 각종 공구 및 장비와 내화벽돌을 준비한다. 개·보수할 노(爐) 및 레이들(Ladle) 안에 사용할 내화물의 수량을 파악하고 기중기를 이용하여 운반한다. 모르타르 분말에 알맞은 수분을 첨가하여 일정 시간 동안 믹서기로 혼합한 모르타르를 기중기로 노 및 레이들 안에 운반한다. 작업표준명세에 지시된 축조방법 및 절차에 따라 내화물을 보수하거나 축조한다. 남은 내화물과 작업대를 축조된 내화물에 손상이 가지 않도록 제거한다. 보수 및 축조가 완료된 노와 레이들을 내화물로 도장하는 공정으로 운반한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|고온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"노재정비원, 연와축로원, 제철축로공, 축로원","certLic":"축로기능사","dJobECd":"7017","dJobECdNm":"[7017]조적공 및 석재부설원","dJobJCd":"7825","dJobJCdNm":"[7825]조적공 및 석재 부설원","dJobICd":"C242","dJobICdNm":"[C242]1차 비철금속 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004416:1', '{"dJobCd":"K000004416","dJobCdSeq":"1","dJobNm":"축로반장","workSum":"노(爐) 및 레이들(Ladle)을 정비하고 내화물을 축조하거나 보수하는 작업을 관리하고, 축로공의 활동을 감독·조정한다.","doWork":"작업계획에 따라 세부실행항목을 수립하여 작업 절차 및 방법을 결정한다. 작업원에게 작업내용을 지시하고 작업배치를 한다. 축로를 축조하고 보수하기 위한 각종 수공구 및 설비의 이상 유무를 파악하고 이상 시 보수를 지시한다. 표준명세에 따라 지시된 작업이 이루어지는지 작업원과 함께 작업하면서 작업내용을 점검한다. 작업원에 대한 직무교육 및 안전위생교육을 실시한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|고온|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"축로계장, 제철축로반장","certLic":"축로기능사","dJobECd":"7017","dJobECdNm":"[7017]조적공 및 석재부설원","dJobJCd":"7825","dJobJCdNm":"[7825]조적공 및 석재 부설원","dJobICd":"C242","dJobICdNm":"[C242]1차 비철금속 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005109:1', '{"dJobCd":"K000005109","dJobCdSeq":"1","dJobNm":"건물해체원","workSum":"노후된 건축물의 전체 또는 부분을 철거 및 해체하는 작업을 수행한다.","doWork":"해체 건물의 종류와 규모 및 주변여건에 맞게 작성된 공정표에 따라 작업계획을 수립한다. 소음, 분진, 진동에 대한 대책 등 안전대책을 수립한다. 비산분진(공사장 등에서 일정한 배출구를 거치지 않고 대기 중으로 직접 배출되는 먼지)과 소음 등의 차단과 안전관리를 위하여 가설 울타리를 설치하고 가설급수와 가설전기를 원활히 공급하도록 준비한다. 수장재(건축물의 내부나 외부에 노출되는 재료)와 설비재 등 지상구조물을 공법에 맞게 해체한 후 철거재를 재활용과 폐기물로 분류하여 반출한다. 주변건물과 도로 등을 종합분석하여 지하구조물을 해체하고 철거한 후 후속공정에 지장이 없도록 흙막이 공사 및 되메움 작업 등을 실시한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"건물철거원, 해체원","connectJob":"석면해체공","dJobECd":"7019","dJobECdNm":"[7019]기타 건설 구조 기능원","dJobJCd":"7829","dJobJCdNm":"[7829]기타 건설 관련 기능 종사원","dJobICd":"F421","dJobICdNm":"[F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003291:1', '{"dJobCd":"K000003291","dJobCdSeq":"1","dJobNm":"데크설치원","workSum":"건축물의 슬래브 대용으로 사용되는 데크플레이트를 설치 및 해체한다.","doWork":"데크플레이트(철근트러스와 거푸집 대용 자재인 아연도금강판 등을 전기용접, 압접 등의 방법으로 접합하여 현장에서 주로 동바리 없이 무지주 조립하여 콘크리트를 타설할 수 있도록 제작된 슬래브용 제품)와 부재(슬리퍼(Sleeper), 래치재(Latch), 래티스재(Lattice), 크랭크(Crank), 쪽판 등)를 현장에 운반 및 반입한다. 데크플레이트 걸침부의 면이 고르지 않거나 불순물이 있는 경우에 양중 전에 청소하고 수분 및 유분을 제거한다. 배치도에 따라 보의 상면에 기준선 먹메김을 한다. 데크플레이트 포장용 밴드를 절단한다. 설계도면 또는 시공상세도면에 따라 데크플레이트를 걸친다. 최초의 데크플레이트를 설치할 때 걸침 위치와 간격에 유의하여 고정한 후 배치도에 따라 순차적으로 설치한다. 절단 및 구멍뚫기에 의해 손상된 단면, 철선용접부위, 시공 중 아연도금이 손상된 부위에 부식방지 처리를 한다. 설치가 끝나면 단부의 걸림상태, 연결부의 체결상태를 확인하고 아연못 등을 사용하여 고정한다. 배근 및 개구부 보강작업을 한다. 구조용데크 또는 탈형용 데크를 설치한다. 탈형용 데크의 경우는 설치 외에 해체 작업을 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"힘든 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|손사용|시각|","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"7019","dJobECdNm":"[7019]기타 건설 구조 기능원","dJobJCd":"7829","dJobJCdNm":"[7829]기타 건설 관련 기능 종사원","dJobICd":"F421","dJobICdNm":"[F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002650:1', '{"dJobCd":"K000002650","dJobCdSeq":"1","dJobNm":"비계공(일반)","workSum":"건축물의 조적·미장·해체, 대형기계의 설치, 조립건축물의 건립 등을 목적으로 통나무, 강관 등을 이용하여 비계를 설치한다.","doWork":"비계재를 점검하고 일정한 길이로 절단된 철선 또는 이음철물을 준비한다. 연약한 기초지반을 파고 받침널이나 잡석으로 채운다. 비계기둥을 일렬로 수직이게 세우고 띠장을 기둥에 일정간격으로 엇대어 철선 또는 이음철물로 결속한다. 구조물의 벽체와 비계기둥 사이에 버팀목을 결속한다. 비계목적에 따라 자재운반용 오름판과 작업대를 적당한 간격으로 설치한다. 낙하물을 방지하고 작업원과 통행인을 보호하기 위하여 방호철망과 보호대를 외부비계 기둥에 설치한다. 작업이 완료된 비계를 해체한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"비계원, 비계설치원, 아시바설치원, 비계설치공, 아씨바설치공, 비계구조물설치공, 비계구조물설치원","connectJob":"동바리공, 철골비계공","certLic":"비계기능사","dJobECd":"7019","dJobECdNm":"[7019]기타 건설 구조 기능원","dJobJCd":"7829","dJobJCdNm":"[7829]기타 건설 관련 기능 종사원","dJobICd":"F421","dJobICdNm":"[F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002985:1', '{"dJobCd":"K000002985","dJobCdSeq":"1","dJobNm":"비계반장","workSum":"건축물의 조적·미장, 대형기계 설치, 조립건축물의 건립 등을 목적으로 목재, 강관, 강판넬 등의 재료를 이용하여 비계를 설치하거나 해체하는 작업을 관리하고, 비계공 및 비계해체원의 활동을 감독·조정한다.","doWork":"설계도면 및 작업장을 점검하고 비계형태를 결정한다. 비계재, 이음철물 등 필요자재의 수량을 파악하여 수령한다. 비계기둥이 세워질 지반을 점검하고 침하 가능성이 있는 지반에 받침널을 대거나 잡석을 넣어 다지도록 작업원에게 지시한다. 비계형태의 변경 또는 비계부대설비의 설치 등에 관하여 작업원과 협의한다. 표준명세에 따라 지시된 작업이 이루어지는지 작업진행상황을 파악하여 작업내용을 보고한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원 및 자재 공급을 한다. 작업원에 대한 직무교육 및 안전위생교육을 실시한다. 수시 관찰과 면담을 통하여 작업원의 애로사항 및 건의사항을 수렴·해결하고 문제점을 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"힘든 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|고온|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"철골비계반장, 아시바반장, 비계구조물반장","certLic":"비계기능사","dJobECd":"7019","dJobECdNm":"[7019]기타 건설 구조 기능원","dJobJCd":"7829","dJobJCdNm":"[7829]기타 건설 관련 기능 종사원","dJobICd":"F421","dJobICdNm":"[F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002352:1', '{"dJobCd":"K000002352","dJobCdSeq":"1","dJobNm":"비계해체원","workSum":"공사가 완료된 후 기 설치된 비계 및 안전망을 해체한다.","doWork":"작업 전에 안전벨트, 안전모 등 안전장구를 착용한다. 동바리(앵글)에 체결된 볼트와 너트를 폭스로 해체한다. 안전망, 추락방지망을 해체하여 와이어 로프와 샥클(Shackle)로 결박한다. 신호수에 하강 수신호로 대상물을 내린다. 대상물이 지면에 도착 시 결박을 해체하여 목재, 앵글, 추락방지망, 비계고정철물 등으로 분류·정리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"비계해체공, 비계구조물해체공, 비계구조물해체원","certLic":"비계기능사","dJobECd":"7019","dJobECdNm":"[7019]기타 건설 구조 기능원","dJobJCd":"7829","dJobJCdNm":"[7829]기타 건설 관련 기능 종사원","dJobICd":"F421","dJobICdNm":"[F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002269:1', '{"dJobCd":"K000002269","dJobCdSeq":"1","dJobNm":"시스템서포트설치원","workSum":"시스템서포트(시스템동바리)를 설치 및 해체한다.","doWork":"층고가 4.2미터를 초과하여 일반 동바리를 사용할 수가 없는 건설현장에 시스템서포트를 설치한다. 작업지시서와 작업반장의 지시에 따라 수직재(거푸집의 상부 하중을 하부로 전달하는 부재), 링(수직부재에 용접으로 고정하여 수평부재를 수직부재와 연결하여 고정할 수 있게 만든 부재), 수평재(수직부재의 좌굴을 방지하기 위하여 수평으로 연결하는 부재), 연결핀(수직재와 수직재, 링과 가새 또는 수평재와 링을 연결하여 고정할 수 있게 한 부재), U헤드잭(수직재 상부에 설치하여 멍에재를 시스템동바리에 연결할 수 있게 하는 조절형 받침대), 잭베이스(하부에 설치하여 수직재의 수평 및 수직을 유지하게 하는 조절형 받침대), 장선(거푸집 널 하부에 고정하고 상부하중을 멍에에 전달하는 부재), 멍에(장선을 지지하고 상부하중을 하부구조에 전달하기 위하여 장선과 직각방향으로 설치하는 부재), 가새(작용하는 횡력에 견딜 수 있도록 수평재와 수평재, 수직재와 수직재를 연결하여 고정하는 부재) 등을 사용하여 시스템서포트를 설치한다. 시스템서포트를 해체하는 작업을 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"힘든 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|손사용|시각|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"7019","dJobECdNm":"[7019]기타 건설 구조 기능원","dJobJCd":"7829","dJobJCdNm":"[7829]기타 건설 관련 기능 종사원","dJobICd":"F421","dJobICdNm":"[F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001778:1', '{"dJobCd":"K000001778","dJobCdSeq":"1","dJobNm":"안전망설치원","workSum":"건설현장에서 낙하물 또는 인명추락을 방지하기 위하여 추락방지망 및 낙하물방지망을 설치한다.","doWork":"방지망의 그물코를 관통시켜 서로 중복됨이 없이 테두리로프를 결속·보강한다. 기중기와 인양로프를 이용하여 안전망을 설치위치까지 끌어올린다. 달기로프를 감아 묶거나 그 이상의 강도를 갖도록 테두리로프를 결속한다. 방지망을 클램프(Clamp:체결하는 부품 또는 도구)나 강관을 이용하여 달기로프로 망테두리와 함께 고정시킨다. 설치된 안전망은 일정 높이에서 물건을 낙하시켜 안전도를 검사한다. 안전망 해체 시 안전망에 떨어진 낙하물이 하부로 쏟아지지 않도록 조정하여 하강·해체시킨다. 각종 안전 시설물(계단, 발코니, ROOF, E/V 난간대 등)을 시설물 매뉴얼에 따라 설치한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"안전망설치공, 건설안전망설치공, 건설안전망설치원, 추락방지망설치공, 추락방지망설치원, 낙하물방지망설치원, 낙하물방지망설치공, 수직보호망설치원, 수직보호망설치공","connectJob":"해체하면 안전망해체원, 안전망해체공","dJobECd":"7019","dJobECdNm":"[7019]기타 건설 구조 기능원","dJobJCd":"7829","dJobJCdNm":"[7829]기타 건설 관련 기능 종사원","dJobICd":"F421","dJobICdNm":"[F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006906:1', '{"dJobCd":"K000006906","dJobCdSeq":"1","dJobNm":"조선비계공","workSum":"선박 및 해양구조물의 건조 시 고소작업을 위하여 블록(Block)이나 건조 중인 선박에 강관을 이용하여 비계(飛階, Scaffolding)를 설치한다.","doWork":"도면을 읽고 작업방법을 설정한다. 비계설치에 필요한 파이프, 이음쇠, 족장판 및 치구 등을 준비한다. 고소작업에 필요한 안전벨트, 개인공구, 안전복장 등을 점검한다. 도면을 보고 조립순서를 숙지한다. 비계기둥을 일렬로 세우고 띠장을 기장에 일정 간격으로 엇대어 철선이나 이음쇠로 결속한다. 구조물의 벽체와 비계기둥 사이에 버팀목을 결속한다. 비계목적에 따라 자재운반용 오름판과 작업대를 적당한 간격으로 설치한다. 방호철망과 보호대를 외부 비계기둥에 설치하고 필요한 표식을 부착한다. 비계의 해체작업은 설치작업의 역순으로 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|손사용|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"비계기능사","dJobECd":"7019","dJobECdNm":"[7019]기타 건설 구조 기능원","dJobJCd":"7829","dJobJCdNm":"[7829]기타 건설 관련 기능 종사원","dJobICd":"C311","dJobICdNm":"[C311]선박 및 보트 건조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005920:1', '{"dJobCd":"K000005920","dJobCdSeq":"1","dJobNm":"지붕잇기공","workSum":"기와 및 슬레이트를 절단, 가공하여 지붕, 벽체 등에 부착한다.","doWork":"건물의 구조 및 형태에 따라 지붕의 재료(너와지붕, 기와, 금속판, 석면 슬레이트 및 천연 슬레이트 등)와 지붕 구조 평면도를 확인한다. 선택된 재료에 따라 금속판(함석판, 동판 등) 또는 슬레이트를 그라인더, 활톱 등을 사용하여 크기에 맞게 절단한다. 드릴 등을 사용하여 일정한 간격으로 구멍을 뚫는다. 그라인더나 줄을 사용하여 절단면을 마감한다. 뚫린 구멍에 못이나 나사 등을 사용하여 부착면에 부착한다. 추녀마루, 내림마루, 용마루 공사 등 마무리 작업을 진행한다. 물청소 및 정리작업을 통해 기와잇기를 완성한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"균형감각|","workEnv":"대기환경미흡|위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"지붕잇기원, 지붕공","connectJob":"지붕의 종류에 따라 금속지붕설치원, 기와지붕잇기원, 루핑지붕잇기원","dJobECd":"7019","dJobECdNm":"[7019]기타 건설 구조 기능원","dJobJCd":"7829","dJobJCdNm":"[7829]기타 건설 관련 기능 종사원","dJobICd":"F421","dJobICdNm":"[F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004221:1', '{"dJobCd":"K000004221","dJobCdSeq":"1","dJobNm":"철판공","workSum":"철판을 사용하여 각종 철판 제품을 제작, 가공, 조립하거나 철판제작물 해체 작업을 한다.","doWork":"설계도면에 따라 철판절단기를 사용하여 철판을 일정한 크기로 절단한다. 절단된 철판의 사이즈를 조절하고 치수가 정확한지 확인한다. 제품에 따라 절단된 철판을 프레스기나 절곡기를 사용하여 각 패널(Panel)부품의 성형 작업을 하기도 한다. 절단되거나 성형된 각 부분품을 렌치, 리벳기계 또는 용접장비를 사용하여 고정, 결합시킨다. NC가공(Numerical Control:수치제어가공)을 통해 컴퓨터를 써서 가공에 필요한 데이터를 주어 수치 제어 공작기에 의해서 철판을 가공하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|고온|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"7019","dJobECdNm":"[7019]기타 건설 구조 기능원","dJobJCd":"7829","dJobJCdNm":"[7829]기타 건설 관련 기능 종사원","dJobICd":"F421","dJobICdNm":"[F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003798:1', '{"dJobCd":"K000003798","dJobCdSeq":"1","dJobNm":"기성콘크리트미장공","workSum":"아파트, 공장 등의 콘크리트 조립건축물을 건립하는 데 필요한 기성콘크리트(Precast Concrete)제품을 제조하기 위하여 콘크리트의 표면을 미장하거나 양생하는 기계를 조작한다.","doWork":"전기히터식 콘크리트양생기를 사용하는 경우는 타설된 콘크리트 표면을 1차 미장한다. 타이머를 조정하여 덮개를 덮고 1차 양생한 후 표면을 2차 미장한다. 전기히터의 타이머를 조정하여 2차 양생 후 완성한다. 스팀식 콘크리트양생기를 사용하는 경우 콘크리트를 거푸집에 타설하고 표면을 고르게 1차 미장한다. 양생천막을 덮은 후 1차 양생을 위하여 스팀라인밸브를 연다. 1차 양생이 되면 천막을 걷어내고 2차 미장을 한다. 본양생을 위하여 스팀라인밸브를 열어 본양생에 들어간다. 전기 또는 스팀양생기로 양생이 되면 피시제품의 표면을 검사하고 결과를 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"손사용|시각|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"콘크리트미장공","dJobECd":"7021","dJobECdNm":"[7021]미장공","dJobJCd":"7831","dJobJCdNm":"[7831]미장공","dJobICd":"F411","dJobICdNm":"[F411]건물 건설업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006173:1', '{"dJobCd":"K000006173","dJobCdSeq":"1","dJobNm":"미장공(일반)","workSum":"건축구조물의 바닥, 내·외벽, 천정의 미관과 방음·방습효과를 높이기 위하여 모르타르, 회반죽 등을 바른다.","doWork":"모르타르 접착에 방해되는 이물질을 제거한 후 돌출 부분은 정으로 깎아내고, 함몰 부분은 모르타르로 채워 평활하게 한다. 접착성을 증대시키기 위하여 물을 뿌린다. 콘크리트 이어치기한 모든 부위는 누수의 우려가 있으므로 미장작업 전 방수모르타르로 보강한다. 모르타르 수축에 따른 홈, 갈라짐을 고려하여 적당한 바름면적에 줄눈 및 줄눈대를 설치한다. 시공부위에 따라 초벌, 재벌, 정벌 등 단계별로 구분하여 일정 두께로 바른다. 초벌, 재벌바름을 한 후 접착성을 높이기 위해 시공면을 긁어 거칠게 한다. 흙손으로 매끈하게 문질러 마감한다. 보양 및 양생을 한다. 미장용 공구를 이용하여 초벌·재벌·정벌 미장작업을 기능 정도에 따라 분담하여 수행하기도 한다. 방수모르타르를 이용하여 방수처리작업을 하는 방수원의 일을 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|손사용|시각|","workEnv":"대기환경미흡|위험내재|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"미장기능공","connectJob":"하는 일에 따라 장식미장공, 치장미장공, 분사미장공, 외벽미장공, 초벌미장공, 황토미장공","certLic":"미장기능사","dJobECd":"7021","dJobECdNm":"[7021]미장공","dJobJCd":"7831","dJobJCdNm":"[7831]미장공","dJobICd":"F424","dJobICdNm":"[F424]실내건축 및 건축마무리 공사업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005493:1', '{"dJobCd":"K000005493","dJobCdSeq":"1","dJobNm":"미장반장(일반)","workSum":"건축구조물의 바닥, 내·외벽, 천정의 미관과 방음·방습효과를 높이기 위하여 모르타르, 회반죽 등을 바르는 작업을 관리하고 미장공 및 미장보조원의 활동을 감독·조정한다.","doWork":"작업시작 전에 설계도와 작업내용을 파악한다. 조사된 자료를 담당원에게 보고하고 작업내용을 협의한다. 작업계획에 따라 세부실행항목을 수립하여 작업 절차 및 방법을 결정한다. 작업원에게 작업내용을 지시하고 작업배치를 한다. 표준명세에 따라 지시된 작업이 잘 이루어지는지를 확인하기 위해 작업원과 함께 작업하며 작업내용을 점검한다. 작업진행상황을 파악하고 작업내용을 보고한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원 및 자재 공급을 한다. 자재의 혼합상태 등을 점검하고 확인한다. 작업원에 대한 직무교육 및 안전위생교육을 실시한다. 수시 관찰과 면담을 통하여 작업원의 애로사항 및 건의사항을 수렴·해결하고 문제점을 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|손사용|시각|","workEnv":"대기환경미흡|위험내재|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"미장기능공","connectJob":"하는 일에 따라 장식미장반장, 치장미장반장, 분사미장반장, 외벽미장반장, 초벌미장반장, 황토미장반장","certLic":"미장기능사","dJobECd":"7021","dJobECdNm":"[7021]미장공","dJobJCd":"7831","dJobJCdNm":"[7831]미장공","dJobICd":"F424","dJobICdNm":"[F424]실내건축 및 건축마무리 공사업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003928:1', '{"dJobCd":"K000003928","dJobCdSeq":"1","dJobNm":"미장보조원(일반)","workSum":"건축구조물의 바닥, 내·외벽, 천정의 미관과 방음·방습효과를 높이기 위하여 모르타르, 회반죽 등을 바르는 미장원을 보조한다.","doWork":"필요한 자재를 준비한다. 시공 장소에 미장공이 사용할 수 있도록 시멘트모르타르 등의 자재를 운반한다. 모래를 체로 치거나 시멘트, 모래 등의 미장재를 일정 비율로 혼합한다. 작업 시 믹서기에 인조석과 백시멘트, 물을 호퍼에 넣는다. 높은 곳의 미장작업이 편리하도록 안전작업발판을 조립한다. 시공 바탕면을 정리한다. 시공 후 작업장 주변 청소 등 정리·정돈한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"미장보조공","connectJob":"하는 일에 따라 장식미장보조원, 치장미장보조원, 분사미장보조원, 외벽미장보조원, 초벌미장보조원, 황토미장보조원","certLic":"미장기능사","dJobECd":"7021","dJobECdNm":"[7021]미장공","dJobJCd":"7831","dJobJCdNm":"[7831]미장공","dJobICd":"F424","dJobICdNm":"[F424]실내건축 및 건축마무리 공사업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002367:1', '{"dJobCd":"K000002367","dJobCdSeq":"1","dJobNm":"한식미장공","workSum":"전통한식기법으로 문화재 수리 및 한옥, 사원, 궁궐과 같은 전통가옥의 외벽, 칸막이벽, 불벽(포벽법당 등에서 불상을 그리는 화반과 화반 사이의 빈 데를 메우는 흙으로 된 벽체), 앙벽(천장, 산자 안쪽에 바르는 흙) 등을 미장하고, 담장, 꽃담, 문양합각, 박석깔기, 화방벽, 줄눈, 등에 진흙이나 모래, 석회 풀 등을 사용하여 바름재를 만들어 표면이나 틈을 메워 치장하여 마감한다.","doWork":"설계도서와 고증자료를 숙지한다. 한식미장편수의 지시에 따라 작업을 시작한다. 대목이 벽의 외형을 짜면 설계도서와 시방서에 따라 작업순서를 정하고 작업을 시작한다. 목구조 심벽에 흙을 바르기 위하여 나뭇가지, 각재, 옻나무가지, 싸리개비, 대나무쪽 등을 사용하여 중깃(흙벽을 치는 상·하인방에 세워대서 욋가지를 이어 매는 가는 기둥), 힘살(외를 보강하거나 얽어매기 위하여 중깃 사이에 세워대는 굵은 욋가지), 가시새(방보라:흙벽의 중깃에 가로로 꿰뚫어 끼워 가로를 보강하며 세로외를 엮어매는 가로재), 욋가지(흙벽의 바탕으로 엮어대는 가는 나뭇가지), 세로외(중깃에 세로로 엮는 욋가지), 가로외(중깃에 가로로 엮은 욋가지) 등을 중방과 상·하인방 사이에 외엮기를 한다. 미장을 하기에 앞서 진흙을 모래, 백토, 짚, 해초물 등을 목적에 맞게 미리 섞는다. 외엮기가 완성되면 초벽치기(진흙에 모래와 백토(풍화토)를 섞어 넣은 흙), 홑벽치기, 맞벽치기, 고름질 및 재벽(재벌)바름, 정벌바름 순으로 벽체의 미장을 한다. 궁궐의 담, 꽃담, 문양합각, 박석깔기, 화방벽, 줄눈 등을 쌓거나 미장한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"한식미장기능공, 황토미장공, 황토미장원, 황토미장기능공","connectJob":"온돌공, 황토구들장공, 구들장공","certLic":"미장기능사, 문화재수리기능자(한식미장공)","dJobECd":"7021","dJobECdNm":"[7021]미장공","dJobJCd":"7831","dJobJCdNm":"[7831]미장공","dJobICd":"F424","dJobICdNm":"[F424]실내건축 및 건축마무리 공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002271:1', '{"dJobCd":"K000002271","dJobCdSeq":"1","dJobNm":"한식미장공조공","workSum":"전통한식기법으로 문화재 수리 및 전통가옥의 벽체, 궁궐의 담 등을 미장하는 한식미장공을 보조한다.","doWork":"한식미장공의 지시에 따라 목구조 심벽에 나뭇가지, 각재, 옻나무가지, 싸리개비, 대나무쪽 등을 사용하여 외엮기를 한다. 선별된 진흙을 목적에 맞게 모래, 백토, 짚, 해초 끓인 물 등의 재료와 혼합하고 미장하는 목적에 맞게 배합한다. 필요한 재료를 미장할 곳으로 운반한다. 한식미장공의 주문에 따라 벽바르기 등을 한다. 작업하기 전 작업현장을 보양하고, 작업이 완료되면 주변을 정리하고 작업 중 목재부분에 묻은 진흙이나 오물 등을 제거한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"황토미장보조원","connectJob":"황토구들장미장보조원, 구들장미장보조원, 온돌미장보조원, 한식미장공","certLic":"미장기능사, 문화재수리기능자(한식미장공)","dJobECd":"7021","dJobECdNm":"[7021]미장공","dJobJCd":"7831","dJobJCdNm":"[7831]미장공","dJobICd":"F424","dJobICdNm":"[F424]실내건축 및 건축마무리 공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003693:1', '{"dJobCd":"K000003693","dJobCdSeq":"1","dJobNm":"한식미장편수","workSum":"전통한식기법으로 문화재 수리 및 한옥, 사원, 궁궐과 같은 전통가옥의 외벽, 칸막이벽, 불벽(포법당 등에서 불상을 그리는 화반과 화반 사이의 빈 데를 메우는 흙으로 된 벽), 앙벽(천장, 산자 안쪽에 바르는 흙) 등을 수리하거나 미장하는 작업을 관리하고, 한식미장공 및 한식미장공조공의 활동을 감독·조정한다.","doWork":"설계도서와 고증자료를 숙지한다. 작업내용을 파악한다. 단청문양, 낙서흔적 등 벽체를 조사하고 미장재료를 관리한다. 조사된 자료를 담당원에게 보고하고 작업내용을 협의한다. 작업내용을 작업원에게 지시·배치한다. 작업진행상황을 파악하고 작업내용을 보고한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원 및 자재 공급을 한다. 자재의 혼합상태 등을 점검하고 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"황토미장편수","connectJob":"황토구들장반장, 구들장반장, 온돌반장, 한식미장공","certLic":"미장기능사, 문화재수리기능자(한식미장공)","dJobECd":"7021","dJobECdNm":"[7021]미장공","dJobJCd":"7831","dJobJCdNm":"[7831]미장공","dJobICd":"F424","dJobICdNm":"[F424]실내건축 및 건축마무리 공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002239:1', '{"dJobCd":"K000002239","dJobCdSeq":"1","dJobNm":"방수공(일반)","workSum":"건축구조물의 바닥, 지붕, 벽체 등에 물이 스며드는 것을 방지하기 위하여 모르타르, 방수도막재 등의 방수재를 바르거나 도포한다.","doWork":"망치, 정, 연삭기 등을 이용하여 방수시공면의 요철부분을 다듬는다. 시공면에 생긴 공극을 모르타르나 방수도막재로 메운다. 방수액과 시멘트를 희석하여 만든 방수시멘트풀을 시공면에 바르고 방수보호 모르타르를 두껍게 입힌다. 프라이머를 시공면에 바른 후 방수도막재를 도포한다. 방수보호용 시멘트모르타르를 타설한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|손사용|시각|","workEnv":"대기환경미흡|위험내재|다습|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"방수기능공","connectJob":"사용되는 방수재 또는 하는 일에 따라 시트방수공, 도막방수공, 아스팔트방수공, 모르타르방수공, FRP방수공, 우레아도장방수공","certLic":"방수기능사, 방수산업기사","dJobECd":"7022","dJobECdNm":"[7022]방수공","dJobJCd":"7832","dJobJCdNm":"[7832]방수공","dJobICd":"F424","dJobICdNm":"[F424]실내건축 및 건축마무리 공사업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004618:1', '{"dJobCd":"K000004618","dJobCdSeq":"1","dJobNm":"방수반장","workSum":"건축구조물의 바닥, 지붕, 벽체 등에 물이 스며드는 것을 방지하기 위하여 방수하는 작업을 관리하고, 방수공의 활동을 감독·조정한다.","doWork":"방수 시공면을 점검하고, 시공견적을 산출한다. 방수의 종류에 따라 방수재 및 부자재의 종류와 양을 결정하여 청구한다. 작업계획을 수립하여 작업내용을 작업원에게 지시·배치한다. 표준명세에 따라 지시된 작업이 잘 이루어지는지 작업진행상황을 파악하여 작업내용을 보고한다. 불량부분을 재시공하도록 지시한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원 및 자재 공급을 한다. 작업원에 대한 직무교육 및 안전위생교육을 실시한다. 수시 관찰과 면담을 통하여 작업원의 애로사항 및 건의사항을 수렴·해결하고 문제점을 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|시각|","workEnv":"대기환경미흡|위험내재|다습|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","connectJob":"사용되는 방수재 또는 하는 일에 따라 시트방수반장, 도막방수반장, 아스팔트방수반장, 모르타르방수반장, FRP방수반장, 우레아도장방수반장","certLic":"방수기능사, 방수산업기사","dJobECd":"7022","dJobECdNm":"[7022]방수공","dJobJCd":"7832","dJobJCdNm":"[7832]방수공","dJobICd":"F424","dJobICdNm":"[F424]실내건축 및 건축마무리 공사업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006926:1', '{"dJobCd":"K000006926","dJobCdSeq":"1","dJobNm":"방수보조원","workSum":"건축구조물의 바닥, 지붕, 벽체 등에 물이 스며드는 것을 방지하기 위하여 모르타르, 방수도막재 등의 방수재를 바르는 방수공을 보조한다.","doWork":"필요한 자재를 준비한다. 시공장소에 방수공이 사용할 수 있도록 방수액 등의 자재를 운반한다. 모래를 체로 치거나 시멘트, 모래 등의 방수재를 일정 비율로 혼합한다. 작업 시 재료배합통에 방수재를 넣는다. 높은 곳의 방수작업이 편리하도록 안전작업발판을 조립한다. 시공 바탕면을 정리한다. 시공 후 작업장 주변 청소 등 정리·정돈한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|다습|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"방수보조공","connectJob":"방수보조원","dJobECd":"7022","dJobECdNm":"[7022]방수공","dJobJCd":"7832","dJobJCdNm":"[7832]방수공","dJobICd":"F424","dJobICdNm":"[F424]실내건축 및 건축마무리 공사업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002964:1', '{"dJobCd":"K000002964","dJobCdSeq":"1","dJobNm":"시트방수공","workSum":"터널, 지하구조물, 건축구조물, 수처리시설물 등에 물이 스며드는 것을 방지하기 위하여 방수시트를 부착한다.","doWork":"방수 시공면을 검사하여 돌출된 철사나 철근, 파이프 등을 망치나 정으로 두들겨서 매끈하게 한다. 시공면에 생긴 공극을 모르타르로 메운다. 표면 정리가 끝난 표면에 부직포를 대고 그 위에 패킹을 붙인 후 타정공구로 못을 박는다. 하부 배수 유공관 설치 시 토사입자의 유입을 방지하기 위하여 측면 부직포와 하부에 부설한 부직포로 완전히 감싼다. 방수시트를 씌우고 접합부분은 자동접합기로 열융착시킨다. 손상된 부분은 방수시트를 덧대어 열융착한다. 접합부분을 에어테스터(Air-tester:압축공기에 의해 빈 캔의 누설시험에 사용하는 기계)를 이용해 봉합하고 시험한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|다습|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"시트방수원, 방수시트부착원","certLic":"방수기능사","dJobECd":"7022","dJobECdNm":"[7022]방수공","dJobJCd":"7832","dJobJCdNm":"[7832]방수공","dJobICd":"F424","dJobICdNm":"[F424]실내건축 및 건축마무리 공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003723:1', '{"dJobCd":"K000003723","dJobCdSeq":"1","dJobNm":"냉장고발포액주입원","workSum":"냉장고 및 냉동고 내부의 열이 방출되거나 외부의 열이 침입하지 않도록 캐비닛과 내상 사이에 우레탄액을 주입한다.","doWork":"발포로의 온도를 일정하게 유지시킨다. 자동으로 우레탄액을 주입하는 기계를 사용하여 발포액을 주입한다. 관련 기계 및 기계설비를 관리하고 주기적으로 청소 및 주유를 한다. 우레탄액을 만들기 위해 화학약품의 액량을 조절하고 배합 및 관리를 한다. 작업방법 개선 및 설비 개선에 관한 제안을 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"발포단열공","connectJob":"발포기조작원","dJobECd":"7023","dJobECdNm":"[7023]단열공","dJobJCd":"7833","dJobJCdNm":"[7833]단열공","dJobICd":"C285","dJobICdNm":"[C285]가정용 기기 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004205:1', '{"dJobCd":"K000004205","dJobCdSeq":"1","dJobNm":"보온공","workSum":"냉난방기기, 위생기구, 상하수도 설비 등의 동파 또는 열손실을 방지하기 위하여 보일러, 파이프, 탱크 등과 같이 노출된 장비나 부품에 보온재를 설치한다.","doWork":"단열시공에 필요한 장비 또는 부품을 점검한다. 표면의 녹·이물질 등을 제거한 후 방청페인트를 칠하여 방청 처리한다. 매트, 보드, 파이프커버, 아티론 등의 적당한 보온재를 시공조건에 따라 선택한다. 온냉수 및 위생설비의 경우 보온재(암면, 매트 등)를 붙이고 은박테이프로 마감한 후 일정 간격으로 알루미늄밴드를 감는다. 냉각수의 경우 속비닐을 감고 보온재를 그 위에 감은 후 은박테이프로 마감하고 알루미늄밴드를 감는다. 일반적인 경우 보온재(커버), 보르(종이 두루마리), 프리마테이프(비닐테이프) 순으로 감아 마감한다. 규격에 맞춰 일정 간격으로 알루미늄밴드로 감고 마감한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"균형감각|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"보온공, 보온기술자, 단열기능원","connectJob":"하는 일에 따라 건물단열공, 배관단열공, 냉동시설장비단열공, 방음시설단열공","certLic":"온수온돌 기능사","dJobECd":"7023","dJobECdNm":"[7023]단열공","dJobJCd":"7833","dJobJCdNm":"[7833]단열공","dJobICd":"F422","dJobICdNm":"[F422]건물설비 설치 공사업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005028:1', '{"dJobCd":"K000005028","dJobCdSeq":"1","dJobNm":"분사단열원","workSum":"축구조물의 방음·내화·단열성을 높이기 위하여 동력분사기로 철구조물 또는 시멘트면에 피복제를 분사한다.","doWork":"시공면에 심도계를 부착한다. 혼합기 호퍼에 피복제와 물을 넣어 적당히 혼합한다. 혼합된 피복제를 분사기 호퍼에 넣는다. 고소작업 시 받침대를 조립하고 받침대를 밀어 분사액을 분무한다. 분사된 면의 상태를 확인하고자 분사하기도 하며 작업이 완료된 후 작업일지에 기록한다. 분사 전에 필요에 따라 분사면을 세척하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"균형감각|","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"보온공, 보온기술자, 단열기능원","certLic":"온수온돌 기능사, 실내 인테리어, 실내건축 인테리어, 기계설비공사업","dJobECd":"7023","dJobECdNm":"[7023]단열공","dJobJCd":"7833","dJobJCdNm":"[7833]단열공","dJobICd":"F422","dJobICdNm":"[F422]건물설비 설치 공사업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004063:1', '{"dJobCd":"K000004063","dJobCdSeq":"1","dJobNm":"온돌공","workSum":"전통한식기법으로 국가유산 수리 및 한옥, 사원, 궁궐과 같은 전통가옥 난방시설의 아궁이, 아궁이후렁이, 불목, 구들개자리, 고래, 고래둑, 고래개자리 구들장, 연도, 굴뚝개자리, 굴뚝 등의 온돌(구들)을 설치하거나 수리하는 작업을 한다.","doWork":"설계도서와 고증자료를 숙지한다. 온돌편수의 지시에 따라 작업을 시작한다. 대목이 벽의 외형을 짜고 한식미장공의 심벽작업이 완료되면 설계도서와 시방서에 따라 작업순서를 정하고 작업을 시작한다. 아궁이와 아궁이후렁이 개자리, 연도를 설치하고, 고막이와 시근담, 고래바닥을 완성하면 고래바닥 위에 고래둑이나 굇돌을 설치하고 구들장을 덮은 다음 거미줄치기와 부토를 하여 온돌(구들)을 완성한다. 구들이 완성되면 부뚜막을 설치하고, 굴뚝을 완성한다. 온돌(구들)놓기에 앞서 재료를 확인하고, 진흙을 모래, 백토, 짚여물, 풀물 등을 목적에 맞게 미리 배합하여 놓는다. 고래의 형태에는 줄고래, 허튼고래, 선자고래, 되돈고래 등이 있다. 아궁이는 부뚜막아궁이와 함실아궁이로 구분된다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"온돌공, 황토미장공, 황토미장원, 황토미장기능공","connectJob":"온돌공, 황토구들장공, 구들장공, 온돌장","certLic":"온돌기능사, 국가유산수리기능자(온돌공), 온수온돌기능사","dJobECd":"7024","dJobECdNm":"[7024]바닥재 시공원","dJobJCd":"7834","dJobJCdNm":"[7834]바닥재 시공원","dJobICd":"F424","dJobICdNm":"[F424]실내건축 및 건축마무리 공사업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006383:1', '{"dJobCd":"K000006383","dJobCdSeq":"1","dJobNm":"온돌공조공","workSum":"전통한식기법으로 국가유산 수리 및 한옥, 사원, 궁궐과 같은 전통가옥 난방시설의 아궁이, 아궁이후렁이, 불목, 구들개자리, 고래, 고래둑, 고래개자리 구들장, 연도, 굴뚝개자리, 굴뚝 등의 온돌(구들)을 설치하거나 수리하는 온돌공을 보조한다.","doWork":"온돌공의 지시에 따라 온돌(구들)놓기의 고래를 설치하거나, 구들장을 설치한다. 선별된 재료를 목적에 맞게 모래, 백토, 짚, 해초 끓인 물 등의 재료와 혼합하고 온돌(구들) 놓는 목적에 맞게 배합한다. 필요한 재료를 운반한다. 온돌공의 주문에 따라 부뚜막 및 굴뚝의 줄눈 등을 한다. 작업을 시작하기 전 작업현장을 보양하고, 작업이 완료되면 주변을 정리하고 작업 중 목재부분에 묻은 진흙이나 오물 등을 제거한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"온돌공보조원","connectJob":"구들장미장보조원, 온돌미장보조원, 한식미장공","certLic":"온돌기능사, 국가유산수리기능자(온돌공)","dJobECd":"7024","dJobECdNm":"[7024]바닥재 시공원","dJobJCd":"7834","dJobJCdNm":"[7834]바닥재 시공원","dJobICd":"F424","dJobICdNm":"[F424]실내건축 및 건축마무리 공사업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002617:1', '{"dJobCd":"K000002617","dJobCdSeq":"1","dJobNm":"온돌편수","workSum":"전통한식기법으로 국가유산 수리 및 한옥, 사원, 궁궐과 같은 전통가옥 난방시설의 아궁이, 아궁이후렁이, 불목, 구들개자리, 고래, 고래둑, 고래개자리 구들장, 연도, 굴뚝개자리, 굴뚝 등의 온돌(구들)을 설치하거나 수리하는 작업을 관리하고, 온돌공 및 온돌공조공의 활동을 감독·조정한다.","doWork":"설계도서와 고증자료를 숙지한다. 작업내용을 파악한다. 전통난방시설인 온돌(구들)을 조사하고 온돌(구들)재료를 관리한다. 조사된 자료를 담당원에게 보고하고 작업내용을 협의한다. 작업내용을 작업원에게 지시·배치한다. 작업진행상황을 파악하고 작업내용을 보고한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원 및 자재 공급을 한다. 자재의 혼합상태 등을 점검하고 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"구들편수","connectJob":"황토구들장반장, 구들장반장, 온돌반장, 온돌공","certLic":"온돌기능사, 국가유산수리기능자(온돌공)","dJobECd":"7024","dJobECdNm":"[7024]바닥재 시공원","dJobJCd":"7834","dJobJCdNm":"[7834]바닥재 시공원","dJobICd":"F424","dJobICdNm":"[F424]실내건축 및 건축마무리 공사업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005439:1', '{"dJobCd":"K000005439","dJobCdSeq":"1","dJobNm":"철도차량바닥재시공원","workSum":"철도차량 바닥의 녹 방지 및 방수, 방음, 단열을 목적으로 객실바닥재를 시공한다.","doWork":"철도차량의 객실바닥표면공사를 위하여 작업도면을 파악한다. 공사시방서 기준에 따라 작업물량과 작업시간, 원료의 물량 및 작업방법, 양생시간 등을 산정한다. 작업표준에 따라 원료 및 작업도구를 준비한다. 작업 전 작업 주위에 보양작업을 한다. 규격재품인 경화제 및 혼합제를 준비한다. 작업표준에 따라 원료를 정량 혼합한다. 객실바닥에 경화제를 혼합한 액체를 일정 간격으로 도포한다. 경화제를 혼합한 액체에 경량골재를 일정 비율로 혼합하고 도포한다. 시멘트, 경량골재 및 염화고무계의 수지를 일정 비율로 혼합하여 중도 위에 요구규격의 두께로 상도 도포한다. 상도의 굴곡진 표면을 공기분사기로 연마하고 먼지를 제거한다. 일정 시간 동안 양생시킨다. 난연성바닥재를 시공하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"유니텍스시공원, 유니텍스설치원, 철도차량바닥재시공기능원","dJobECd":"7024","dJobECdNm":"[7024]바닥재 시공원","dJobJCd":"7834","dJobJCdNm":"[7834]바닥재 시공원","dJobICd":"C312","dJobICdNm":"[C312]철도장비 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005982:1', '{"dJobCd":"K000005982","dJobCdSeq":"1","dJobNm":"카펫타일공","workSum":"주택, 상가, 일반사무실의 목재, 콘크리트 등의 바닥에 카펫타일을 깔거나 보수한다.","doWork":"시공바닥면을 점검하여 요철, 굴곡이 없게 하고 기름, 페인트, 왁스 등의 이물질을 제거한다. 카펫타일을 부착할 내부 바닥 면적을 자로 측정하여 부착할 카펫타일의 양과 형태를 결정한다. 수평도를 검사하고 시공할 카펫의 매수를 최소한으로 하기 위하여 바닥을 사등분하여 먹줄이나 백묵으로 중심선을 표시한다. 중심선 설치로 사등분된 면적 중 한 면에 작업속도를 고려하면서 점착체를 도포한다. 점착제가 투명하게 되는 시점에 반장 이상이 되도록 나누기를 한 후 카펫타일을 붙인다. 특수압착기로 접합부분을 눌러 표시가 나지 않게 한다. 손상된 카펫타일은 주변 카펫의 색을 고려한 후 깐다. 모서리나 가장자리 부분에 시공할 카펫타일을 자와 재단칼을 사용하여 일정 크기로 절단하기도 한다. 카펫의 중류에 따라 들뜬 곳이 없도록 핸드롤러로 부착한 카펫타일을 누르거나 중성세제로 시공바닥면을 깨끗이 청소하고, 완전히 건조되면 수용성 왁스로 광택을 낸다. 시공 후 무거운 물건을 이동시킬 경우에는 보양재를 덮어 카펫을 보호한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"카펫공, 카펫설치공, 카펫원, 아스타일공, 아스타일원, 아스타일시공원, 나무장판원, 비닐 타일공","dJobECd":"7024","dJobECdNm":"[7024]바닥재 시공원","dJobJCd":"7834","dJobJCdNm":"[7834]바닥재 시공원","dJobICd":"F424","dJobICdNm":"[F424]실내건축 및 건축마무리 공사업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002637:1', '{"dJobCd":"K000002637","dJobCdSeq":"1","dJobNm":"타일공","workSum":"건축구조물의 방음, 방수, 장식을 목적으로 내·외부에 대리석, 점토 등으로 만든 타일을 부착한다.","doWork":"시공면을 충분히 양생한 후 기름, 먼지 등 접착에 유해한 이물질을 제거한다. 떠붙임 공법으로 타일 뒷면에 모르타르를 일정량 발라, 타일을 바탕면에 비벼서 붙인다. 접착면에 접착제를 일정 두께로 도포 후 요철을 내고, 타일의 뒷면이 완전히 접착되도록 타일을 눌러 부착시키며 빠른시간 내에 벽 혹은 바닥에 고정시키는 압착 붙임을 한다. 압착 붙임과 같은 방법이나 타일 뒷면에도 접착제를 붙여서 바탕에 붙이는 개량압착 공법을 적용하기도 한다. 떠붙임과 같은 공법이나 접착제의 재료가 모르타르가 아닌 에폭시를 사용하는 에폭시 붙임 공법을 적용하기도 한다. 타일과 줄눈재의 색상을 고려하여 물을 혼합한다. 줄눈재를 타일과 타일 사이에 밀어 넣어 봉합한다. 물수건, 스펀지 등을 사용하여 타일표면을 닦아낸다. 줄눈시공 중 또는 시공 후 빗물침투로 인한 백화현상(건물의 벽면이 하얗게 굳는 현상)을 예방하기 위하여 방수시트를 부착하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"고온|저온|소음·진동|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"타일부착원, 타일원, 타일부착기능공, 타일부착기능원, 타일기사","connectJob":"대리석부착원, 대리석설치원, 타일및대리석부착기능원","certLic":"타일기능사","dJobECd":"7024","dJobECdNm":"[7024]바닥재 시공원","dJobJCd":"7834","dJobJCdNm":"[7834]바닥재 시공원","dJobICd":"F424","dJobICdNm":"[F424]실내건축 및 건축마무리 공사업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003008:1', '{"dJobCd":"K000003008","dJobCdSeq":"1","dJobNm":"도배사","workSum":"종이, 천, PVC코팅 재질의 도배지를 건축구조물의 천장, 벽, 바닥, 창호 등에 풀 또는 접착제를 사용하여 부착한다.","doWork":"도배에 필요한 도배지·풀 등의 양을 산출하기 위하여 벽·천장 등의 넓이를 측정한다. 바탕면을 충분히 건조시키고 못, 철선, 모르타르 찌꺼기 등을 제거한다. 갈라진 틈이나 구멍은 흙손을 사용하여 모르타르나 회반죽으로 메운다. 낡은 벽지가 붙어 있을 때는 물로 적신 스펀지를 바탕면에 적셔 제거한다. 도배지가 잘 부착되지 않는 단열모르타르, 판상단열재, 압착스티로폼 부위는 바니시 또는 바인더를 바른다. 벽 · 천정 등 고르지 않은 곳은 초배지, 부직포, 텍스등을 사용하여 띄움시공으로 시공한다. 종이벽지, 발포벽지, 실크벽지 등의 정배지에 골고루 풀을 도포한 후 정배솔, 헝겊 등으로 주름이 생기지 않도록 또는 들뜨지 않도록 눌러준다. 작업 후 몰딩과 걸레받이에 맞게 칼로 자른다. 그 후 나오는 도배지의 쓰레기는 수거한다. 걸레받이, 반자돌림, 타일 등에 묻은 풀을 깨끗이 닦아낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"도배사, 도배기사","connectJob":"도배재단공, 실내장식도배공, 그린홈도배원","certLic":"도배기능사","dJobECd":"7025","dJobECdNm":"[7025]도배공 및 유리 부착원","dJobJCd":"7835","dJobJCdNm":"[7835]도배공 및 유리 부착원","dJobICd":"F424","dJobICdNm":"[F424]실내건축 및 건축마무리 공사업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001845:1', '{"dJobCd":"K000001845","dJobCdSeq":"1","dJobNm":"스테인드글라스제작자","workSum":"실측 디자인 도면을 따라 유리칼, 자, 각종 도구를 이용하여 여러 가지 컬러의 유리조각을 가공하여 납선 또는 동테이프로 스테인드글라스를 제작한다.","doWork":"작업명세서 및 주문서에 따라 제작할 스테인드글라스의 형태, 규격을 확인한다. 작업도구(카툰지, 카본지, 유리칼, 케임, 인두, 러스킨, 이중날가위, 납칼, 망치 등)를 준비한다. 주문서에 적합한 컬러유리(붉은색, 푸른색, 자주색, 노란색, 초록색)를 준비한다. 유리칼과 이중날가위를 이용한 다양한 기법을 사용하여 디자인된 실측도면에 따라 각각의 색깔별로 유리를 재단하여 밑그림 재단작업을 한다. 도면에 맞게 재단된 컬러유리를 케임(Came:납선)에 하나씩 끼워 맞추어 색유리 조각 맞추기 작업을 한다. 케임을 작은 못으로 고정시키는 조립작업을 한다. 인두기 및 납땜기로 실납을 녹여 붙이는 납땜작업을 한다. 납칼을 이용하여 납땜한 곳의 불필요한 부분을 제거하는 납땜 마무리 작업을 한다. 조립을 마친 후 유리조각과 이음새 사이의 틈을 메워주기 위해 스투코(Stucco:벽돌이나 목조 건축물 벽면에 바르는 미장 재료) 또는 접착제(Putty:퍼티)를 제작품 위에 바르고 러스킨, 브러쉬 및 깨끗한 헝겊으로 유리판 표면의 퍼티를 닦아내어 마무리 작업을 한다. 조각된 유리성형물을 꺼내어 조각된 모양을 검사한다. 완성된 유리는 포장공정으로 보낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|손사용|시각|","workEnv":"위험내재|저온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"7025","dJobECdNm":"[7025]도배공 및 유리 부착원","dJobJCd":"7835","dJobJCdNm":"[7835]도배공 및 유리 부착원","dJobICd":"C231","dJobICdNm":"[C231]유리 및 유리제품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001478:1', '{"dJobCd":"K000001478","dJobCdSeq":"1","dJobNm":"유리설치반장","workSum":"건축구조물의 내벽 또는 외벽에 유리를 설치하는 작업을 관리하고, 유리설치원의 활동을 감독·조정한다.","doWork":"작업 시작 전에 유리를 설치할 현장을 실측·검사하여 필요자재를 파악하고 작업계획을 세운다. 도면에 따라 작업절차 및 방법을 결정한다. 유리 대리점(공장)에 도면 내역에 맞게 유리를 주문한다. 작업사항을 관찰하고 작업내용을 점검한다. 유리설치원과 함께 유리를 설치하고, 설치에 따른 이상 유무를 점검·확인한다. 작업진행상황을 파악하고 작업내용을 보고한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원 및 자재 공급을 한다. 유리공사에 따른 작업원들의 안전을 관리하고 교육을 실시한다. 수시 관찰과 면담을 통하여 작업원의 애로사항 및 건의사항을 수렴·해결하고 문제점을 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|","workEnv":"위험내재|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"유리시공 책임자","connectJob":"유리절단공, 유리가공공","certLic":"유리시공기능사","dJobECd":"7025","dJobECdNm":"[7025]도배공 및 유리 부착원","dJobJCd":"7835","dJobJCdNm":"[7835]도배공 및 유리 부착원","dJobICd":"F424","dJobICdNm":"[F424]실내건축 및 건축마무리 공사업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004473:1', '{"dJobCd":"K000004473","dJobCdSeq":"1","dJobNm":"유리설치원","workSum":"건축구조물의 내벽 또는 외벽에 유리를 설치한다.","doWork":"유리를 설치하기 전에 유리면에 부착된 종이, 기름, 먼지 등을 제거하고 도면에 표시된 유리를 찾아 시공장소로 운반한다. 유리운반 시 중량이 큰 유리는 운반구나 압축기 등을 사용하여 파손을 주의하여 운반한다. 유리의 파손 방지를 위하여 세팅블록 및 단부 스페이서(Edge Spacer)를 설치한다. 외관상 균일성이 유지되도록 유리를 끼운다. 유리와 틀 사이에 백업(Back-up)제를 삽입하여 유리의 유동을 방지한다. 유리 끼우기가 완료된 후 파손 및 흠이 생기지 않도록 널, 종이 등 보양재로 보호한다. 일정 기일 내에 보양재를 제거하고 유리면을 닦는다. 특수목적으로 유리를 설치하는 형태에 따라 교회나 기념관 등에 스테인드글라스로 디자인하여 설치하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"균형감각|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"유리시공원","connectJob":"하는 일에 따라 외벽유리설치원, 내벽유리설치원, 구조물유리설치원, 판유리설치원, 스테인드글라스설치원, 장식유리부착원, 차량유리부착원, 안전유리설치원, 유리블럭설치원","certLic":"유리시공기능사","dJobECd":"7025","dJobECdNm":"[7025]도배공 및 유리 부착원","dJobJCd":"7835","dJobJCdNm":"[7835]도배공 및 유리 부착원","dJobICd":"F424","dJobICdNm":"[F424]실내건축 및 건축마무리 공사업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007480:1', '{"dJobCd":"K000007480","dJobCdSeq":"1","dJobNm":"건물도장공","workSum":"각종 건축물·구조물의 내·외부표면을 미화(美化)하거나 부식을 방지하고 방수효과를 주기 위하여 도장용구를 사용하여 수성·유성페인트, 합성수지 에멀션페인트 및 기타 도료를 칠한다.","doWork":"도면이나 지시서를 숙지하고 도장 당일의 온도, 습도, 바람, 환기조건 등의 환경조건을 살핀다. 도료가 시공면에 잘 도장될 수 있도록 스크레이퍼(Scraper:긁개), 쇠슬, 사포 등을 사용하여 묵은 페인트나 거친 부위를 긁어낸다. 퍼티스크레이퍼를 사용하여 못구멍, 균열부분, 봉합면을 퍼티, 모르타르 등을 발라 고르게 하고, 건조한 후 규정된 규격 연마지로 매끄럽게 연마한다. 페인트에 희석제를 섞거나 색조를 혼합한다. 붓, 롤러, 스프레이 건(분사기) 등을 사용하여 지정된 표면에 수성·유성페인트, 합성수지 에멀션페인트 등의 도장재를 도장한다. 도장 대상물에 따라 연마와 도장을 반복적으로 한다. 높은 장소에 칠을 할 경우 파이프, 클램프, 발판 등의 비계를 설치하거나 줄, 곤돌라 등을 설치하여 도장작업을 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"도장원, 페인트공, 건축도장원, 건물도장기능원, 도색공, 도장공","connectJob":"에폭시도장원, 우레탄도장원 , 퍼티공","certLic":"건축도장기능사","dJobECd":"7026","dJobECdNm":"[7026]건축 도장공","dJobJCd":"7836","dJobJCdNm":"[7836]건축 도장공","dJobICd":"F424","dJobICdNm":"[F424]실내건축 및 건축마무리 공사업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002589:1', '{"dJobCd":"K000002589","dJobCdSeq":"1","dJobNm":"건물도장반장","workSum":"각종 건축물이나 구조물 등의 내·외부 표면에 페인트류나 기타 도료를 칠하는 작업을 관리하고, 건물도장공의 활동을 감독·조정한다.","doWork":"도면이나 시방서를 읽고 작업을 숙지한다. 도장용구와 재료를 공급하고 물량을 청구한다. 작업원을 현장에 배치한다. 페인트를 혼합하거나 표면에 묵은 페인트나 이물질을 제거하고 도장용구를 사용하여 수성·유성페인트, 합성수지 에멀션페인트 및 기타 도료를 도장하는 작업원의 활동을 감독·조정하며 기술적인 조언을 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"건축도장반장, 도색반장, 도장반장","certLic":"건축도장기능사","dJobECd":"7026","dJobECdNm":"[7026]건축 도장공","dJobJCd":"7836","dJobJCdNm":"[7836]건축 도장공","dJobICd":"F424","dJobICdNm":"[F424]실내건축 및 건축마무리 공사업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005510:1', '{"dJobCd":"K000005510","dJobCdSeq":"1","dJobNm":"건물외벽그래픽공","workSum":"빌딩·아파트·공장 등 건축물 및 구조물의 외부표면을 주위환경과 조화되도록 그림, 그래픽, 문자 등을 도안하고 도장한다.","doWork":"도면이나 지시서를 숙지하고 당일의 온도, 습도, 바람, 환기조건 등의 환경조건을 살핀다. 도장공이 건축물이나 구조물에 도장작업을 완료하면 그 위에 숙지한 도면의 그림, 그래픽 또는 문자 등을 그리기 위하여 색연필, 컴퍼스, 수평대를 이용하여 전체적인 스케치를 한다. 높은 곳은 곤돌라, 줄 등으로 안전장비를 갖춘 후 스케치를 한다. 스케치가 도면과 일치하는지 검사하고 조정한 후 스케치된 시공면을 도장한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"보통 작업","workPlace":"실외","physicalAct":"균형감각|손사용|시각|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"슈퍼그래픽공, 건물외벽그래픽기능원","dJobECd":"7026","dJobECdNm":"[7026]건축 도장공","dJobJCd":"7836","dJobJCdNm":"[7836]건축 도장공","dJobICd":"F424","dJobICdNm":"[F424]실내건축 및 건축마무리 공사업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002140:1', '{"dJobCd":"K000002140","dJobCdSeq":"1","dJobNm":"선박도장공","workSum":"선박 및 해양구조물의 표면을 보호하기 위하여 목재, 유리섬유강화플라스틱(Glass Fiber Reinforcer Plastic) 및 금속표면을 세척하고 솔, 분사기 및 롤러를 사용하여 선체 및 부품에 도장한다.","doWork":"목선을 도장하는 경우, 도장면의 그리스(Grease:기계의 마찰 부분에 쓰는 끈적끈적한 윤활유), 먼지, 녹, 기타 불순물을 깨끗이 제거한다. 토치를 사용하여 묵은 페인트를 태운다. 사포, 스크레이퍼, 기타 광택을 내는 물질을 사용하여 표면에 광택을 낸다. 접합제 및 부드러운 나무부스러기 등을 사용하여 갈라진 틈이나 구멍을 메운다. 페인트 착색제, 도료, 기타 수성도료 등을 혼합하여 페인트의 색상을 조합한다. 분사기 등을 사용하여 선박표면을 칠한다. 도장한 페인트가 다 마르면 사포를 사용하여 손질을 한다. 강선(쇠로 만든 선박)을 도장하는 경우, 선박사상원의 소지작업(도장할 부분의 녹이나 이물질을 제거하는 작업)을 확인한다. 작업지역 주변에 오염을 방지하는 천이나 비닐을 씌운다. 보호복을 착용하여 도료의 피부접촉을 막는다. 비계 또는 고소작업대에 올라 작업지역으로 이동한다. 펌프를 작동하고 분사기를 사용하여 도장한다. 도면에 규정된 코팅처리를 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|손사용|","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"선박도장원, 조선도장공, 조선도장원, 조선도장기능원, 선박도장기능원","certLic":"금속도장기능사","dJobECd":"7026","dJobECdNm":"[7026]건축 도장공","dJobJCd":"7836","dJobJCdNm":"[7836]건축 도장공","dJobICd":"C311","dJobICdNm":"[C311]선박 및 보트 건조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007092:1', '{"dJobCd":"K000007092","dJobCdSeq":"1","dJobNm":"선박도장반장","workSum":"선박 및 해양구조물 건조 시 부분품·장비·보트 등 선박에 페인트를 칠하는 작업을 관리하고, 선박도장공의 활동을 감독·조정한다.","doWork":"도면이나 지시서를 숙지하고 작업원에게 페인트 장비를 조작하는 방법을 훈련시키고 모래분사, 쇠솔질, 페인트를 칠하는 작업계획을 세운다. 선박사상원에게 소지작업(도장할 부분의 녹이나 이물질을 제거하는 작업)을 지시한다. 소지검사를 실시하여 도장을 실시할 수 있는지 여부를 검사한다. 선박도장원을 작업현장에 배치하고 작업내용을 지시한다. 작업진행에 따라 작업원의 작업상황을 감독·조정한다. 도면대로 도장되었는지를 확인하기 위하여 도장부위를 검사한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"대기환경미흡|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"조선도장반장","certLic":"금속도장기능사","dJobECd":"7026","dJobECdNm":"[7026]건축 도장공","dJobJCd":"7836","dJobJCdNm":"[7836]건축 도장공","dJobICd":"C311","dJobICdNm":"[C311]선박 및 보트 건조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006226:1', '{"dJobCd":"K000006226","dJobCdSeq":"1","dJobNm":"차선도색보조원","workSum":"고속도로, 일반도로, 활주로, 주차장 등 노면에 차선을 표시하는 차선도색반장 및 차선도색원을 보조한다.","doWork":"차선도색 준비작업을 위하여 붓과 페인트로 노면에 점을 찍는다. 페인트를 공급탱크나 드럼에 투입한다. 차선도색작업을 할 때 차단봉(라바콘)을 차선 옆에 일정 간격으로 놓는다. 다른 차량이 차선도색차량에 접근하는 것을 방지하거나, 도색된 차선에 차량이 지나가지 못하도록 교통정리를 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"약간의 시범정도","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"단순작업","similarNm":"특수도장보조원, 차선도장보조원","connectJob":"하는 일에 따라 중앙선도색보조원, 주차구역도색보조원","dJobECd":"7026","dJobECdNm":"[7026]건축 도장공","dJobJCd":"7836","dJobJCdNm":"[7836]건축 도장공","dJobICd":"F412","dJobICdNm":"[F412]토목 건설업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002530:1', '{"dJobCd":"K000002530","dJobCdSeq":"1","dJobNm":"차선도색원","workSum":"고속도로, 일반도로, 활주로, 주차장 등 노면에 차선을 표시하는 분사기계를 운전한다.","doWork":"발주처로부터 제시된 도면을 숙지한다. 줄자를 사용하여 도로의 폭을 재고 중심점 및 차선폭을 석필로 표시한다. 석필로 표시된 점을 일정 간격으로 일직선이 되도록 줄을 당겨 붓과 페인트로 굵은점을 표시한다. 차선도색 차량에 탑재된 도장액 공급탱크에 도장액을 붓는다. 차선도색 차량에 승차하여 차선간격·중앙선·노변선 등 차선의 종류와 간격에 따라 차선폭·페인트 분사압력 등 계기를 관찰하여 노즐과 밸브를 조정한다. 차선도색장치로부터 분사되는 페인트의 양을 관찰하여 압력·폭 등이 규정된 넓이·양으로 분사되는지 확인한다. 수동 도색기나 롤러 등을 이용하여 차선, 횡단보도, 문자, 기호 등을 표시하고 분사기를 이용하여 페인트를 분사하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","similarNm":"차선도장원, 특수도장원","dJobECd":"7026","dJobECdNm":"[7026]건축 도장공","dJobJCd":"7836","dJobJCdNm":"[7836]건축 도장공","dJobICd":"F424","dJobICdNm":"[F424]실내건축 및 건축마무리 공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002998:1', '{"dJobCd":"K000002998","dJobCdSeq":"1","dJobNm":"새시원","workSum":"철재, 철사 등의 고정철물을 구조체에 설치한 후 알루미늄, 스테인리스 등과 같은 재질의 창문틀, 새시, 철망문 등을 벽에 설치한다.","doWork":"자, 컴퍼스, 줄자 등을 사용하여 새시를 설치할 공간의 크기를 잰다. 공간의 크기에 맞춰 각종 재료에 절단 표시를 하고 쇠톱, 동력톱, 파이프절단기계 등으로 자른다. 새시를 조립하기 위하여 부속품에 구멍을 뚫고 동력렌치를 사용하여 볼트를 조인다. 조립된 새시를 설치대에 놓고 볼팅·용접 등으로 고정·접합한다. 새시, 틀 및 문에 각종 장식물을 볼팅 및 용접하여 고정한다. 용접된 부위의 거친 면을 끌, 줄, 망치 등을 사용하여 다듬는다. 설치된 새시에 색상을 내거나 녹을 방지하기 위하여 페인트를 칠하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"샷시원","certLic":"금속재창호기능사","dJobECd":"7027","dJobECdNm":"[7027]새시 조립·설치원","dJobJCd":"7837","dJobJCdNm":"[7837]새시 조립 및 설치원","dJobICd":"F424","dJobICdNm":"[F424]실내건축 및 건축마무리 공사업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005869:1', '{"dJobCd":"K000005869","dJobCdSeq":"1","dJobNm":"창호설치반장","workSum":"알루미늄 새시, 전동문·자동문 등을 도면에 따라 건물 정면이나 벽 내부에 설치하는 작업원의 활동을 감독·조정한다.","doWork":"설계도면을 숙지하고 설치될 창호의 위치, 형을 결정하여 작업계획을 수립한다. 자재를 확보하고, 설치절차 및 방법을 결정하여 작업원에게 지시하고 작업을 배치한다. 표준명세에 따라 지시된 작업이 이루어지는지 파악하여 작업내용을 보고한다. 불량부분을 재시공하도록 지시한다. 작업원의 작업상황을 관리·감독하고, 기술적인 지원을 하며 자재를 공급한다. 작업원에 대한 직무교육 및 안전위생교육을 통하여 직무수행능력을 향상시키고 재해를 예방한다. 수시 관찰과 면담을 통하여 작업원의 애로사항 및 건의사항을 수렴·해결하고, 문제점을 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","certLic":"금속재창호기능사, 플라스틱창호기능사","dJobECd":"7027","dJobECdNm":"[7027]새시 조립·설치원","dJobJCd":"7837","dJobJCdNm":"[7837]새시 조립 및 설치원","dJobICd":"F424","dJobICdNm":"[F424]실내건축 및 건축마무리 공사업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006795:1', '{"dJobCd":"K000006795","dJobCdSeq":"1","dJobNm":"창호설치원","workSum":"알루미늄 새시, 금속창호, 전동문·자동문 등의 창호를 도면에 따라 용접기나 제반 공구를 사용하여 건물 정면이나 내부에 설치한다.","doWork":"시공에 필요한 장비 및 공구를 준비한다. 승인된 재료, 공법 및 시공 상세도에 따라 견본을 설치하여 문제점을 점검·보완한다. 설계도면 및 시방서에 따라 기준을 잡고 폭 및 높이를 정하여 먹매김한다. 아파트 창호설치 시 틀(Frame) 보강 및 누수 방지를 위하여 시멘트모르타르 등을 충진시켜 양생한다. 오피스텔 및 상가 창호설치 시 먹줄작업 후 앵커를 설치한다. 콘크리트, 벽돌, 블록 등 시공면 프레임의 좌우에 용접앵커 또는 일반앵커를 설치한다. 도면과 시방서에 따라 창호를 수평·수직이 정확히 유지되도록 설치한다. 설치 후 손상, 변형이 없도록 보양재를 사용하여 보양한다. 각 창호형태, 층 등을 분류하여 설치부위에 양중·배치한다. 창틀을 수직·수평 먹매김선에 따라 정위치에 고정한다. 시공면에 매설되어 있는 앵커철물과 프레임에 부착된 연결철물을 볼트, 너트 또는 용접으로 잇고 맞춘다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"창호공","connectJob":"금속재창호원, 금속새시원, 금속새시제작원, 금속새시설치원, 금속창호설치원, 발코니금속창호제작원, PVC창호원, PVC새시원, PVC새시제작원, PVC새시설치원","certLic":"금속재창호기능사, 플라스틱창호기능사","dJobECd":"7027","dJobECdNm":"[7027]새시 조립·설치원","dJobJCd":"7837","dJobJCdNm":"[7837]새시 조립 및 설치원","dJobICd":"F424","dJobICdNm":"[F424]실내건축 및 건축마무리 공사업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004159:1', '{"dJobCd":"K000004159","dJobCdSeq":"1","dJobNm":"창호제작반장","workSum":"방화문과 같은 금속문을 비롯하여 철문, 새시제품, 및 경첩, 힌지 등 금속장식물 등의 창호제품을 제작하기 위하여 금속을 가공, 절곡, 용접, 조립하는 데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"도면을 확인하고 작업의 생산공정계획을 수립한다. 창호 제작 공정도를 작성하고 작업에 필요한 설비 및 장비, 인원투입, 재료, 방법 등의 계획을 수립한다. 일일 생산량 및 인원 구성을 계획하여 작업지시를 한다. 공정별 작업자 및 작업인원과 절단기 등의 작업설비와 장비를 점검하고 작업을 감독한다. 작업공정을 감독·조정하며 작업공정상의 개선사항을 지시한다. 수동 및 자동계측기를 이용하여 부분품이나 완성된 창호제품을 계측하여 시방서 또는 명세서와 일치하는지 확인한다. 완성된 창호제품의 품질을 검사한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","similarNm":"창호조립반장","connectJob":"금속장식물제작반장, 새시품제작반장, 철문제작반장","certLic":"금속재창호기능사, 플라스틱창호기능사","dJobECd":"7027","dJobECdNm":"[7027]새시 조립·설치원","dJobJCd":"7837","dJobJCdNm":"[7837]새시 조립 및 설치원","dJobICd":"C251","dJobICdNm":"[C251]구조용 금속제품, 탱크 및 증기발생기 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001884:1', '{"dJobCd":"K000001884","dJobCdSeq":"1","dJobNm":"창호제작원","workSum":"문, 창, 배전반 등 금속새시 및 장식물 등과 같은 창호 및 관련 제품을 제작하기 위하여 금속을 가공하고 가공된 부속품 등을 용접·사상·조립한다.","doWork":"제품의 표준 및 작업지시서에 따라 제품의 형태를 확인하고 철판 및 알루미늄 등 사용될 금속재료를 준비한다. 샤링기나 및 벤딩기 같은 필요한 가공장비를 점검한다. 제품의 규격을 맞추기 위하여 작업지시서를 보고 프레스가공, 코너샤링, 타공, 도장 등의 공정작업을 수행한다. 절단기 및 샤링기를 사용하여 절단한다. 제품의 조립을 위해 철판의 좌우양면을 규격에 맞게 벤딩기로 성형한다. 이음부를 용접하거나 경첩 등을 리베팅하여 부착한다. 상관 및 하관의 철판 내부에 천공을 하거나 내부재를 부착한다. 상판과 하판을 조립하고 이음매부분을 용접한다. 도어 보강대를 부착한다. 힌지, 도어록 등 장식물을 부착하는 볼트작업을 한다. 장식부위를 비닐 등을 이용하여 엄폐(Masking)한 후 전기도장을 한다. 도장부위가 완전히 건조되면 포장을 하고 출하장에 적재한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"창호조립원","connectJob":"금속장식물제작원, 새시제품제작원, 철문제작원","certLic":"금속재창호기능사, 플라스틱창호기능사","dJobECd":"7027","dJobECdNm":"[7027]새시 조립·설치원","dJobJCd":"7837","dJobJCdNm":"[7837]새시 조립 및 설치원","dJobICd":"C251","dJobICdNm":"[C251]구조용 금속제품, 탱크 및 증기발생기 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006709:1', '{"dJobCd":"K000006709","dJobCdSeq":"1","dJobNm":"건물보수원","workSum":"건물이나 시설의 유지 및 보수 업무를 담당한다.","doWork":"각종 공구를 사용하여 건물의 창문 등을 수리한다. 건물의 문, 기계 등을 도장한다. 지붕이나 석재부분 등을 보수한다. 기타 건물과 관련된 보수와 유지 업무를 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"영선원, 건물영선원, 건물수리원, 건물유지보수원, 건물시설관리원, 건물관리원, 영선기사원","connectJob":"대상에 따라 공장영선원, 아파트영선원","dJobECd":"7029","dJobECdNm":"[7029]기타 건축 마감 기능원","dJobJCd":"7839","dJobJCdNm":"[7839]기타 건축 마감 관련 기능 종사원","dJobICd":"F411","dJobICdNm":"[F411]건물 건설업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004114:1', '{"dJobCd":"K000004114","dJobCdSeq":"1","dJobNm":"지하철역사시설관리원","workSum":"지하철 역사 및 차량기지의 부대시설을 개량 및 유지 보수한다.","doWork":"업무계획에 따라 역사 내의 건축시설물인 셔터, 천정, 바닥, 벽체, 도장, 창호 및 배수로, 화장실 등의 건축물을 점검한다. 이상이 있는 부분을 개량하거나 보수하는 업무를 한다. 안내표지판의 설치 및 철거, 내용변경 등을 점검·관리한다. 계절에 따라 안전관리업무를 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실외","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"지하철역사유지보수원","certLic":"주택관리사보, 주택관리사","dJobECd":"7029","dJobECdNm":"[7029]기타 건축 마감 기능원","dJobJCd":"7839","dJobJCdNm":"[7839]기타 건축 마감 관련 기능 종사원","dJobICd":"H492","dJobICdNm":"[H492]육상 여객 운송업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004208:1', '{"dJobCd":"K000004208","dJobCdSeq":"1","dJobNm":"코킹공","workSum":"건축구조물을 구성하는 요소 간 또는 마감재 간 틈새로 유입될 수 있는 우수, 소음, 이물질 등의 유입을 막기 위하여 간격 및 접합부에 실란트(Sealant)를 충전한다.","doWork":"실란트(Sealant:토목, 건축, 자동차 등의 부재 상호 간 창틀 등의 접합부, 빈틈에 사용되어 기밀, 수밀의 기능 외에 부재 상호 간의 신축, 진동, 변형을 흡수 완화하기 위한 고무상의 물질)와 피착체 간의 접착성을 부여하기 위하여 실란트 적용부위를 깨끗하게 청소한다. 계절별 온도변화, 자재를 고려하여 실란트를 선정한다. 충전하기 전 유리, 석재, 경량벽돌(ALC) 등의 피착면 보호를 위하여 줄눈 양측의 가장자리 선과 일치하게 테이프를 붙인다. 줄눈 폭에 맞는 노즐을 선택하고, 공기가 들어가지 않도록 심층부까지 실란트를 충전한다. 자외선을 차단하고 빗물이 잘 흐르도록 바깥 하단부는 경사지게 한다. 작업 후 테이프를 제거한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|","workEnv":"위험내재|고온|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"코킹작업원, 코킹원, 실란트코킹공, 실란트코킹원, 실란트코킹작업원","dJobECd":"7029","dJobECdNm":"[7029]기타 건축 마감 기능원","dJobJCd":"7839","dJobJCdNm":"[7839]기타 건축 마감 관련 기능 종사원","dJobICd":"F424","dJobICdNm":"[F424]실내건축 및 건축마무리 공사업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004847:1', '{"dJobCd":"K000004847","dJobCdSeq":"1","dJobNm":"한식와공","workSum":"전통가옥의 지붕 위에 기와를 잇는다.","doWork":"설계도서 및 시방서를 이해하고 작업내용을 숙지한다. 한식와공보조원이 제작한 산자를 댄다. 연암(서까래 끝의 평고대 위에 대어 암기와가 놓이게 반달모양의 톱니같이 에운 나무) 위에 적심(산자를 엮은 위에 지붕물매를 잡기 위하여 서까래에 가로 덧대는 잡목 따위)을 고정한다. 산자 위에 지붕물매를 고려하여 진흙 또는 보통흙을 이겨 보토(補土:새우흙)를 깐다. 보토 위에 충분히 피운 강회(진흙, 강회, 백토를 물로 배합)를 써서 누수 되지 않도록 강회다짐을 한다. 암기와의 밑면이 잘 붙도록 되게 이긴 양질의 진흙을 개어 기와바탕(산자엮음, 널깔기, 강회다짐) 위에 규정 두께로 편편하게 알매흙을 바른다. 암기와를 골의 줄이 바르고 옆장과 서로 맞닿을 정도로 깔고 겹쳐 기와를 잇는다. 암기와 사이의 골에 홍두깨흙(기와를 이을 때에 숫기와가 붙어있게 하기 위하여 그 밑에 괴는 반죽 흙)을 숫기와 속이 가득 차도록 채우고 숫기와 잇기작업을 한다. 숫기와 사이에 회백토반죽 또는 진흙을 빈틈없이 채워 넣어 면바르고 가지런한 모양이 되도록 착고막이를 한다. 시방서에 따라 용마루, 박공마루, 추녀마루, 합각마루 등 각종 지붕마루를 시공한다. 숫기와의 첫 장을 가만히 들어 올리고 숫기와의 안쪽으로 일정량의 와구토(강회, 백토, 물을 혼합한 흙)를 곱고 미끈하게 마감한다. 잘못 이은 부분은 수정·보완하고 작업 중 깨진 기와는 갈아 끼운다. 처마 끝에 암막새와 수막새로 마무리하기도 한다. 궁궐 등의 특수한 곳에 취두(용모양의 기와)를 올려놓기도 하고 궁의 담을 쌓고 기와를 잇는 작업을 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"힘든 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"기와공, 기와장이, 기와지붕잇기원,와장","connectJob":"번와와공, 제작와공","certLic":"문화재수리기능자(번와와공), 문화재수리기능자(제작와공)","dJobECd":"7029","dJobECdNm":"[7029]기타 건축 마감 기능원","dJobJCd":"7839","dJobJCdNm":"[7839]기타 건축 마감 관련 기능 종사원","dJobICd":"F421","dJobICdNm":"[F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005015:1', '{"dJobCd":"K000005015","dJobCdSeq":"1","dJobNm":"한식와공반장","workSum":"전통가옥의 지붕 위에 기와를 내리고 잇는 작업을 관리하고 한식와공 및 한식와공보조원의 활동을 감독·조정한다.","doWork":"작업내용이나 작업진행계획을 담당원과 협의한다. 설계도서 및 시방서를 이해하고 작업내용을 작업원에게 지시한다. 작업진행상황을 파악하고 작업내용을 보고한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원 및 자재를 공급한다. 기와를 잇기 위하여 작업계획에 따라 세부실행항목을 수립하여 작업 절차 및 방법을 결정하여 작업원에게 작업내용을 지시하고 작업배치를 한다. 표준명세에 따라 지시된 작업이 이루어지는지 작업원과 함께 작업하면서 작업내용을 점검한다. 작업원에 대한 직무교육 및 안전위생교육을 실시한다. 수시 관찰과 면담을 통하여 작업원의 애로 및 건의사항을 수렴·해결하고 문제점을 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"힘든 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"기와공반장, 기와잇기반장","connectJob":"번와와공, 제작와공","certLic":"문화재수리기능자(번와와공), 문화재수리기능자(제작와공)","dJobECd":"7029","dJobECdNm":"[7029]기타 건축 마감 기능원","dJobJCd":"7839","dJobJCdNm":"[7839]기타 건축 마감 관련 기능 종사원","dJobICd":"F421","dJobICdNm":"[F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004184:1', '{"dJobCd":"K000004184","dJobCdSeq":"1","dJobNm":"한식와공보조원","workSum":"전통한식기법으로 한옥, 사원, 궁궐 등의 전통가옥의 지붕 위에 기와를 잇는 한식와공을 보조한다.","doWork":"와공을 보조하여 진흙, 강회, 백토 등을 물과 혼합하며 기와를 지붕 위로 지게나 들 것을 이용하여 운반한다. 산자에 진흙을 고르게 편다. 한식와공의 지시에 따라 기와를 잇는다. 작업이 완료되면 진흙이나 강회가 묻은 기와와 도구를 닦고 주변을 정리한다. 한식와공을 보조하여 산자(子:지붕 서까래 위나 고미 위에 흙을 받쳐 기와를 이기 위하여 가는 나무오리나 싸리나무 따위로 엮은 것. 또는 그런 재료) 새끼를 평고대(처마에 얹힌 서까래 끝에 가로로 길게 얹힌 나무)에서 용마루까지 늘이고 긴장작, 싸릿개비, 죽데기장 등의 산자를 대며 칡덩쿨이나 등나무덩쿨 등을 이용하여 산자를 만들기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"힘든 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"기와공보조원, 한식와공보조원, 기와지붕잇기보조원, 한식와공조공","connectJob":"번와와공, 제작와공","certLic":"문화재수리기능자(번와와공), 문화재수리기능자(제작와공)","dJobECd":"7029","dJobECdNm":"[7029]기타 건축 마감 기능원","dJobJCd":"7839","dJobJCdNm":"[7839]기타 건축 마감 관련 기능 종사원","dJobICd":"F421","dJobICdNm":"[F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002266:1', '{"dJobCd":"K000002266","dJobCdSeq":"1","dJobNm":"슈트조작원","workSum":"갱내에서 채굴된 광석을 광차, 스킵, 컨베이어 등에 싣기 위하여 슈트(Chute:중력을 이용하여 무거운 짐을 아래로 내리는 컨베이어의 일종)를 조작한다.","doWork":"슈트의 안전상태, 문짝의 개폐상태, 발판의 견고성 등을 점검한다. 해머, 괭이, 삽 등을 사용하여 슈트 천정 및 측벽의 낙석 발생의 위험을 제거한다. 레일 위에 떨어진 광석을 제거한다. 광산기관차운전원 또는 권양기조종원에게 신호하여 광차나 스킵이 슈트 입구에 정확히 정차되도록 한다. 스위치나 레버를 조작하여 슈트의 문짝을 개폐시켜 적절한 양의 광석을 싣는다. 지렛대 또는 압축공기를 사용하여 막히거나 들러붙은 광석을 떼어낸다. 광석의 적재가 완료되면 슈트의 문짝을 완전히 닫고, 떨어진 광석을 광차에 싣거나 정리한다. 적하된 광석의 양을 기록하고 슈트의 주위를 정리한다. 슈트 보수가 요구될 경우 지주원에게 통보하여 수리한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","similarNm":"탄발원, 호퍼작업원","dJobECd":"7051","dJobECdNm":"[7051]광원, 채석원 및 석재 절단원","dJobJCd":"7841","dJobJCdNm":"[7841]광원·채석원 및 석재 절단원","dJobICd":"B051/B061/B062","dJobICdNm":"[B051]석탄 광업 / [B061]철 광업 / [B062]비철금속 광업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005096:1', '{"dJobCd":"K000005096","dJobCdSeq":"1","dJobNm":"암석절단원","workSum":"석산에서 암석을 채석하기 위하여 버너를 사용하여 암석을 절단한다.","doWork":"광산보안법을 숙지하고 암석절단에 따른 제반 안전사항을 파악한다. 버너탱크에 기름을 주입하고 버너를 점검한다. 버너에 기름호스 및 공기호스를 연결한다. 일정한 압력에 의해 기름을 뿜어줄 수 있도록 컴프레서(Compressor:압축기)를 가동시키고, 공기압축기운전원에게 연락하여 공기압을 조정한다. 버너 노즐 부분을 가열시키기 위하여 기름에 불을 붙인다. 암석을 절단하기 위하여 버너대를 어깨에 메고 버너 노즐 끝부분을 절단부위에 대어 공기·기름을 분사시킨다. 암석의 절단상태를 확인한다. 암석을 깊이 절단할 경우 버너대를 연결한다. 석산에 줄사다리를 이용하여 오르내리기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"버너절단원","dJobECd":"7051","dJobECdNm":"[7051]광원, 채석원 및 석재 절단원","dJobJCd":"7841","dJobJCdNm":"[7841]광원·채석원 및 석재 절단원","dJobICd":"B071","dJobICdNm":"[B071]토사석 광업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004084:1', '{"dJobCd":"K000004084","dJobCdSeq":"1","dJobNm":"지주원","workSum":"갱도굴착 후 공동유지, 낙반이나 측벽 붕괴방지를 위하여 목재, 철재, 콘크리트, 록볼트(Rock Bolt) 등을 사용하여 천장과 벽을 지지하는 작업을 수행한다.","doWork":"지주방식 및 작업장의 형태에 따라 작업 방법을 결정한다. 톱, 망치, 못, 해머, 보안경, 지주도구를 준비하고 갱목, 각주, 관목, 록볼트, 시멘트 등 사용재료를 준비하여 작업장에 운반한다. 작업장을 점검하여 부석 등의 위험물을 제거하고 지주위치를 선정한다. 보안경을 착용하고 암반이 나올 때까지 삽으로 각주 그릇을 판다. 하중에 견딜 수 있는 지주를 선택하고 마름질한다. 작업목적 및 형태에 따라 지주 설치방법을 선택하고, 지주도구를 사용하여 각주·타주를 세우고 관목, 시목, 갱목 등을 설치하고, 천반이 높을 경우 폐석 또는 시목을 쌓거나 매시(Mash)를 조립한다. 작업이 끝난 후, 설치한 지주를 점검하고 보수하며 남은 목편·도끼밥 등 이물질이 광석에 혼입되지 않도록 치운다. 사용 후 남은 재료, 폐자재를 사람 또는 장비의 통행에 불편이 없도록 반출하거나 정리한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"10년 초과","workStrong":"힘든 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"보갱원","dJobECd":"7051","dJobECdNm":"[7051]광원, 채석원 및 석재 절단원","dJobJCd":"7841","dJobJCdNm":"[7841]광원·채석원 및 석재 절단원","dJobICd":"B051/B061/B062","dJobICdNm":"[B051]석탄 광업 / [B061]철 광업 / [B062]비철금속 광업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003525:1', '{"dJobCd":"K000003525","dJobCdSeq":"1","dJobNm":"채광반장","workSum":"지하나 노천광산에서 광물을 채취하기 위하여 착암·지주·시설 등의 작업을 관리하며, 작업원의 활동을 감독·조정한다.","doWork":"작업인원을 점검하고 보안을 숙지시킨 후 작업배치 및 작업량을 배분한다. 작업장비 및 자재를 파악하고 점검한다. 작업장까지 작업원들을 인솔한다. 작업장의 출수·부석·가스 등 위험요소를 파악하고 보안장치를 점검한다. 광맥발달 상태를 검토하여 채굴방향을 제시한다. 천공·발파·운반·지주·시설 등의 작업상황을 감독하고, 기술적인 요인을 제시하고 조정한다. 작업이 끝나면 작업량을 확인하고 작업원들을 인솔하여 퇴갱한다. 보안 및 작업일지를 작성하고 인계사항을 다음 작업반장에게 세밀히 인계한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"힘든 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"조작운전","similarNm":"채광계원, 굴진계원, 광원","connectJob":"굴진반장, 궤도반장, 발파반장, 지주반장, 착암반장, 채탄반장","certLic":"화약류관리산업기사, 광산보안기능사, 화약취급기능사","dJobECd":"7051","dJobECdNm":"[7051]광원, 채석원 및 석재 절단원","dJobJCd":"7841","dJobJCdNm":"[7841]광원·채석원 및 석재 절단원","dJobICd":"B051/B061/B062","dJobICdNm":"[B051]석탄 광업 / [B061]철 광업 / [B062]비철금속 광업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002511:1', '{"dJobCd":"K000002511","dJobCdSeq":"1","dJobNm":"채석장석수","workSum":"석산에서 잘라낸 암석을 주문에 따라 일정한 크기로 절단한다.","doWork":"광산보안법을 확인한다. 착암원이 발파시킨 암석의 위치를 확인한다. 암석에 와이어로프(Wire Rope)를 걸어주고 중기운전원에게 연락하여 암석을 눕히게 한다. 주문된 작업지시서나 석수반장의 지시에 따라 먹줄을 사용하여 암석에 금을 긋는다. 삐찡노미(착암기의 일종으로 망치질하는 기계)를 사용하여 암석에 일정한 간격으로 구멍을 뚫는다. 구멍 속에 쐐기를 박고 해머질하여 암석을 일정 크기로 쪼갠다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"힘든 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"석수","connectJob":"석산채석원","dJobECd":"7051","dJobECdNm":"[7051]광원, 채석원 및 석재 절단원","dJobJCd":"7841","dJobJCdNm":"[7841]광원·채석원 및 석재 절단원","dJobICd":"B071","dJobICdNm":"[B071]토사석 광업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006818:1', '{"dJobCd":"K000006818","dJobCdSeq":"1","dJobNm":"채석장석수반장","workSum":"석산에서 암석을 채석하고 일정 크기로 절단하는 채석작업을 관리하며, 채석장석수의 활동을 감독·지시한다.","doWork":"생산에 관한 일정생산량·인원배치 등의 계획을 세운다. 작업원들에게 안전교육을 실시한다. 암석을 폭파시키기 위하여 폭파구멍에 폭파공구나 폭발물을 채우고 폭파시킨다. 암석절단 크기를 결정하고 절단·운반 등의 작업을 감독·지시한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실외","physicalAct":"균형감각|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","similarNm":"석수반장","certLic":"화약류관리산업기사 광산보안기능사, 화약취급기능사","dJobECd":"7051","dJobECdNm":"[7051]광원, 채석원 및 석재 절단원","dJobJCd":"7841","dJobJCdNm":"[7841]광원·채석원 및 석재 절단원","dJobICd":"B071","dJobICdNm":"[B071]토사석 광업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001951:1', '{"dJobCd":"K000001951","dJobCdSeq":"1","dJobNm":"광산궤도공","workSum":"광산에서 광물이나 각종 자재를 운반하기 위하여 기관차·광차 등이 이동할 수 있도록 레일을 설치·보수·관리한다.","doWork":"작업지시서에 따라 레일설치장소를 파악하고 주위를 정리한다. 갱도바닥을 파고 일정 간격으로 침목을 배열한다. 침목 중앙이 갱도 중심과 일치되도록 하고 구배(경사도)를 맞추어 놓는다. 침목 위에 일정 간격을 유지하면서 레일을 놓고 매시(Mash)로 연결한다. 침목의 높이를 조절하고 레일과 직각이 되도록 맞춘다. 레일 게이지를 사용하여 레일간격을 맞춘다. 지렛대로 침목을 받치고 스파이크를 박아 고정시킨다. 중심과 구배를 확인한다. 침목을 지렛대로 들고 침목 밑과 사이에 자갈을 채워 충전하고 다진다. 레일의 구배·고도·확도 및 연결부위를 확인·점검한다. 정기적으로 레일을 점검·보수하고, 부패된 침목은 회수·교체한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"레일설치원, 광산궤도원","connectJob":"갱목설치원","certLic":"철도토목기능사","dJobECd":"7052","dJobECdNm":"[7052]철로 설치·보수원","dJobJCd":"7842","dJobJCdNm":"[7842]철로 설치 및 보수원","dJobICd":"B051/B061/B062","dJobICdNm":"[B051]석탄 광업 / [B061]철 광업 / [B062]비철금속 광업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001238:1', '{"dJobCd":"K000001238","dJobCdSeq":"1","dJobNm":"궤도공(일반)","workSum":"궤도를 부설하기 위하여 레일, 침목 등의 부재를 운반·설치하거나 지반다짐, 자갈 또는 콘크리트를 포설한다.","doWork":"지반을 다지고 자갈 또는 콘크리트를 포설한다. 침목, 레일패드, 절연편 등의 자재를 운반한다. 레일을 운반·배열하고 상부에 침목설치 위치를 표시한다. 레일을 문형크레인을 사용하여 들어 올리고 침목을 운반하여 레일에 표시된 간격으로 배열한다. 레일저면과 침목 사이에 레일패드를 삽입하고, 팬드롤크립은 숄더를 이용하고 레일접촉면에 절연재를 삽입하여 견고히 체결한다. 콘크리트 타설 시까지 변위 또는 변형을 방지하기 위하여 궤광을 들어올리고 방진상자(Rubber Boot)와 방진고무판(Microcellular Pad)을 침목에 밀착시켜 고정한다. 궤간을 정확히 유지시키기 위하여 궤광조립대로 레일을 받친다. 침목에 이물질의 접착을 방지하기 위하여 보망제를 씌운다. 콘크리트 타설 후 궤광조립대를 해체·철거한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"힘든 작업","workPlace":"실외","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"선로원, 궤도원, 철도궤도공, 철도선로원, 철도선로설치원","certLic":"철도토목기능사","dJobECd":"7052","dJobECdNm":"[7052]철로 설치·보수원","dJobJCd":"7842","dJobJCdNm":"[7842]철로 설치 및 보수원","dJobICd":"F421","dJobICdNm":"[F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002893:1', '{"dJobCd":"K000002893","dJobCdSeq":"1","dJobNm":"선로보수원","workSum":"열차의 안전운행을 위해 철도의 궤도(선로), 침목 및 철로지반 등 구조물의 상태를 점검하여 유지·관리하고 이상이 있을 시 보수 및 교체한다.","doWork":"궤도구조물 점검을 위해 도보 또는 순회점검차를 이용하여 지정된 선로를 순찰하고 점검한다. 궤도에 이상이 있을 시 레일, 침목 등의 마모 정도에 따라 보수 및 교체를 결정한다. 궤도차에 보수장비를 싣고 이동하며 트랙렌치, 트랙잭, 드릴러 등의 공구를 사용하여 침목에 자갈을 넣어 지반을 다지고 궤도의 변형된 부분을 정정·복구한다. 부패되거나 마모가 심한 레일 및 침목은 교체한다. 처진 이음매를 정정하고, 침목 부속품 등을 보수한다. 분기별로 정해진 궤도구조물을 교환한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"웅크림|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"보선원, 철도시설관리원, 선로유지보수원","certLic":"철도토목기능사","dJobECd":"7052","dJobECdNm":"[7052]철로 설치·보수원","dJobJCd":"7842","dJobJCdNm":"[7842]철로 설치 및 보수원","dJobICd":"H491","dJobICdNm":"[H491]철도 운송업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002810:1', '{"dJobCd":"K000002810","dJobCdSeq":"1","dJobNm":"철도토목원","workSum":"열차가 안전하게 운행할 수 있도록 레일, 침목, 철로지반 등 선로시설물을 유지·보수하는 업무를 수행한다.","doWork":"선로 순회 및 점검을 통해 궤도 및 시설물 이상 유무 확인한다. 궤도선형검측기, 초음파레일탐상기 등 사용하여 궤도선형, 레일 검측, 침목, 레일 등 궤도재료를 점검한다. 궤도틀림보수, 보선장비를 활용한 선로보수, 궤도·분기기 총다짐작업, 도상자갈치환, 레일, 침목 등 궤도재료 교환 등의 업무를 수행한다. 열차운행선 상 작업 시 운행안전관리 및 열차, 교량·터널 등 철도시설물의 안전점검 및 진단, 열차운행선 인접공사개소 안전관리 감시업무 등을 수행한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"힘든 작업","workPlace":"실외","physicalAct":"웅크림|","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"철도보선원, 철로보선원, 철로보수원","connectJob":"철로설치원","certLic":"철도토목기능사","dJobECd":"7052","dJobECdNm":"[7052]철로 설치·보수원","dJobJCd":"7842","dJobJCdNm":"[7842]철로 설치 및 보수원","dJobICd":"H491","dJobICdNm":"[H491]철도 운송업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003399:1', '{"dJobCd":"K000003399","dJobCdSeq":"1","dJobNm":"골재포설공","workSum":"도로 및 옹벽 시공 등 각종 토목공사에서 골재를 포설한다.","doWork":"포설작업에 필요한 골재를 페이로더, 덤프트럭 등 운반장비를 이용하여 포설위치로 운반한다. 포설할 위치를 정리한다. 시공 기술시방서에 따라 포설할 층별로 라인(Line)을 표시하고 층별 라인을 준수하여 골재를 골고루 평탄하게 포설한 후 물을 뿌린다. 롤러(Roller) 및 래머(Rammer)를 사용하여 다짐작업을 실시한다. 매 층마다 다짐을 실시하고 감리의 검측을 받는다. 검측이 완료된 후 동일하게 다음 층 작업을 실시한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"웅크림|","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"조작운전","similarNm":"골재포설원","dJobECd":"7059","dJobECdNm":"[7059]기타 채굴·토목 종사원","dJobJCd":"7849","dJobJCdNm":"[7849]기타 채굴 및 토목 관련 종사원","dJobICd":"F412","dJobICdNm":"[F412]토목 건설업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003393:1', '{"dJobCd":"K000003393","dJobCdSeq":"1","dJobNm":"광산측량보조원","workSum":"광산의 갱 내외에서 매장량의 확보와 천연자원개발을 위하여 시추와 채굴에 필요한 제반 측량을 실시하는 광산측량기술자 및 광산측량사의 업무를 보조한다.","doWork":"측량기구를 준비하고 측량장소로 운반한다. 측량지점 사이의 거리를 줄자로 재고, 고도·지역번호·거리 등의 측정치를 기록한다. 측량지역을 정리한다. 광산측량사의 지시에 따라 폴(Pole)을 세우고 폴의 위치를 표시한다. 위치이동에 따른 지시를 받아 수행한다. 측량기구를 회수하여 정비하고 보관한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|손사용|시각|","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"단순작업","dJobECd":"7059","dJobECdNm":"[7059]기타 채굴·토목 종사원","dJobJCd":"7849","dJobJCdNm":"[7849]기타 채굴 및 토목 관련 종사원","dJobICd":"M729","dJobICdNm":"[M729]기타 과학기술 서비스업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002126:1', '{"dJobCd":"K000002126","dJobCdSeq":"1","dJobNm":"교량케이블설치원","workSum":"현수교와 같은 교량건설에서 케이블, 로프 등을 교량에 설치한다.","doWork":"탑정설비에 윈치(Winch:로프를 원통에 감아올려 중량물을 끌어 올리거나 도르래를 끼워 매다는 기중기의 일종) 등 작업에 필요한 설비를 이동시킨다. 케이블 설치 작업에 필요한 이동 작업대를 설치한다. 케이블을 앵커에 연결한다. 케이블과 케이블 마디를 커플러(Coupler) 등으로 연결한다. 이동작업대에서 케이블이 올바르게 접속되었는지 확인하고 조치를 취한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"힘든 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|손사용|","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"7059","dJobECdNm":"[7059]기타 채굴·토목 종사원","dJobJCd":"7849","dJobJCdNm":"[7849]기타 채굴 및 토목 관련 종사원","dJobICd":"F412","dJobICdNm":"[F412]토목 건설업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004906:1', '{"dJobCd":"K000004906","dJobCdSeq":"1","dJobNm":"사충원","workSum":"채광 시 실수율의 향상, 내지압의 조정, 상부 및 측벽갱의 침몰방지, 광해의 방지, 통기의 원활한 흐름조정 등을 위하여 갱내에서 광석을 채광하고 난 채굴공동에 광미(Tailing)나 모래로 충진한다.","doWork":"갱내의 채굴공동을 파악하고 작업계획을 세운다. 채굴공동 입구에 콘크리트나 목재로 칸막이를 설치한다. 광미가 새는 것을 방지하기 위하여 나일론 망사 등으로 칸막이의 틈을 막는다. 물과 광미 혹은 모래를 적당한 비율로 혼합하여 모래펌프 탱크에 담는다. 펌프에 연결된 광미 압송관이나 채굴공동까지 연장 설치한다. 펌프를 가동하고 밸브를 열어 채굴공동에 광미나 모래를 채운다. 충진되는 광미의 농도를 측정하고 충진상태를 확인한다. 작업일지를 작성·보관한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"충진원","dJobECd":"7059","dJobECdNm":"[7059]기타 채굴·토목 종사원","dJobJCd":"7849","dJobJCdNm":"[7849]기타 채굴 및 토목 관련 종사원","dJobICd":"B051/B061/B062","dJobICdNm":"[B051]석탄 광업 / [B061]철 광업 / [B062]비철금속 광업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001508:1', '{"dJobCd":"K000001508","dJobCdSeq":"1","dJobNm":"산업잠수사(일반)","workSum":"대기압 이상의 작업환경에서 인원, 장비, 자재를 바탕으로 공기 및 혼합기체를 사용하여 구조물의 용접 및 절단, 보수, 구조물의 설치 및 해체, 안전진단, 고르기, 발파, 해난구조, 극한환경잠수 등을 수행한다.","doWork":"작업지시에 따라 작업방법, 순서, 업무분담 등을 협의·결정한다. 수심, 작업량, 주위환경과 특성에 따라 표면공급식(SSDS) 장비 또는 스쿠버(Scuba) 장비를 선택하여 잠수작업에 필요한 수중용접장비, 수중촬영장비, 기타 기구 등을 점검한다. 잠수장비를 착용하고 수중에 들어가 사진, 비디오, CCTV 등으로 선박의 상태를 촬영한다. 촬영내용을 보고 수면 아래 선체 및 각종 수중 구조물의 이상 유무 및 손상 정도를 파악하여 해결방법을 제시한다. 수중작업선의 설치, 선박바닥상태검사, 외판물때제거, 프로펠러 이물질제거, 수중촬영, 수중 용접 및 절단, 각종 수중밸브의 개폐, 수중반목 검사 및 각종 인양작업을 수행한다. 작업종료 후 작업시간, 작업내용, 잠수횟수, 잠수심도 등의 기록을 작성한다. 각종 수중장비를 세척 및 건조한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"균형감각|손사용|","workEnv":"위험내재|다습|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"잠수사, 잠수부, 머구리, 컴머설다이버","connectJob":"하는 일에 따라 해난구조요원, 수중조사원, 수중촬영사","certLic":"잠수기능장, 잠수산업기사, 잠수기능사","dJobECd":"7059","dJobECdNm":"[7059]기타 채굴·토목 종사원","dJobJCd":"7849","dJobJCdNm":"[7849]기타 채굴 및 토목 관련 종사원","dJobICd":"C311/F421","dJobICdNm":"[C311]선박 및 보트 건조업 / [F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004469:1', '{"dJobCd":"K000004469","dJobCdSeq":"1","dJobNm":"선박잠수사","workSum":"선박 건조 시 상태조사 촬영, 오염된 외판의 선저청소 및 수중용접, 선급검사 등 수중에서 발생되는 제반 작업을 수행한다.","doWork":"잠수장비를 착용하고 수중에 들어가 사진, 비디오, CCTV 등으로 선박의 상태를 촬영한다. 촬영내용을 보고 수면 아래 선체 및 각종 수중 구조물의 이상 유무 및 손상 정도를 파악하여 해결방법을 제시한다. 작업지시에 따라 작업방법, 순서, 업무분담 등을 협의·결정한다. 표면공급식(SSDS) 장비 또는 스쿠버(Scuba) 장비를 선택하여 잠수 전 장비의 이상 유무를 점검한다. 선박바닥상태검사, 외판물때제거, 프로펠러 이물질제거, 수중촬영, 수중 용접 및 절단, 수중반목 검사 및 각종 인양작업을 수행한다. 수심이나 구조형식을 고려하여 알루미늄, 마그네슘, 아연 등의 양극을 일정 간격으로 강구조물에 취부한다. 작업종료 후 작업시간, 작업내용, 잠수횟수, 잠수심도 등의 기록을 작성한다. 각종 수중장비를 세척 및 건조한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실외","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"선박잠수사","connectJob":"하는 일에 따라 수중용접원, 수중선박검사원","certLic":"잠수기능사","dJobECd":"7059","dJobECdNm":"[7059]기타 채굴·토목 종사원","dJobJCd":"7849","dJobJCdNm":"[7849]기타 채굴 및 토목 관련 종사원","dJobICd":"C311","dJobICdNm":"[C311]선박 및 보트 건조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006785:1', '{"dJobCd":"K000006785","dJobCdSeq":"1","dJobNm":"소금채취원","workSum":"천일염을 생산하기 위하여 해수를 끌어들여 태양열에 증발시키고 건조하는 작업을 수행한다.","doWork":"기후, 해수의 농도, 염전의 규모, 장비 및 작업인원 등을 감안하여 생산계획을 수립한다. 저수지, 증발지, 결정지의 제방 및 수로를 점검·보수한다. 소금생산량과 품질을 위하여 염판의 바닥을 단단히 다지는 지고작업(롤러작업)을 하고 해초나 풀 등 저수지 바닥의 침전물을 퍼낸다. 저수지, 증발지, 결정지의 누수상태를 점검하고 양수원에게 지시하여 저수지 및 제1증발지의 수문을 열도록 지시한다. 액체비중계를 사용하여 각 증발지의 소금용액 농도를 측정하고, 규정된 농도까지 증발되면 수문을 열거나 펌프를 작동시켜 결정지로 소금물을 이동시킨다. 소금의 결정을 촉진시키기 위하여 못바닥에 타일이나 비닐을 설치한다. 결정이 되면 대패로 소금을 모으는 채염작업을 한다. 목도, 일륜차 등을 이용하여 채염된 소금을 창고로 운반한다. 저장된 소금창고에서 일정한 무게단위로 마대에 포장한다. 우천 시에는 소금용액의 희석을 막기 위하여 증발지의 염수에 소금용액을 집어넣는 작업을 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"웅크림|","workEnv":"다습|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"염부","connectJob":"제염공","dJobECd":"7059","dJobECdNm":"[7059]기타 채굴·토목 종사원","dJobJCd":"7849","dJobJCdNm":"[7849]기타 채굴 및 토목 관련 종사원","dJobICd":"B072","dJobICdNm":"[B072]기타 비금속광물 광업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003531:1', '{"dJobCd":"K000003531","dJobCdSeq":"1","dJobNm":"잠수반장","workSum":"잠수작업을 계획, 추진, 완료할 수 있도록 작업을 기획, 지시, 조정하고 잠수사 및 잠수보조원을 교육하고 각종 활동을 감독·조정한다.","doWork":"잠수에 대한 지식을 바탕으로 필요에 따라 작업방법에 대해 잠수사를 교육·훈련시킨다. 잠수반장은 작업현장에서 사용되는 모든 장비를 점검하고 수행해야 할 작업에 대해 잠수사들에게 사전설명을 한다. 잠수사가 수중에서 찍은 사진, 비디오, CCTV 등 상태조사 촬영내용으로 수면 아래 선체 및 각종 수중 구조물의 이상 유무 및 손상 정도를 파악하여 해결방법을 제시한다. 작업장소의 기상 및 해상조건을 파악하여 작업방법, 순서, 업무분담 등을 협의·결정한다. 수중작업 시 수중 밖에서 통신기로 잠수사에게 작업을 지시하고 작업상황을 파악한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실외","workEnv":"위험내재|다습|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","certLic":"잠수기능장, 잠수산업기사, 잠수기능사","dJobECd":"7059","dJobECdNm":"[7059]기타 채굴·토목 종사원","dJobJCd":"7849","dJobJCdNm":"[7849]기타 채굴 및 토목 관련 종사원","dJobICd":"C311/F421","dJobICdNm":"[C311]선박 및 보트 건조업 / [F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004646:1', '{"dJobCd":"K000004646","dJobCdSeq":"1","dJobNm":"측량보조원(일반)","workSum":"토목건설, 지도작성, 토지구획, 천연자원개발 등의 목적에 따라 토지표면의 경계와 정확한 위치를 설정하여 측지·측량하는 측량기술자 및 측량사를 보조한다.","doWork":"측량이 진행되고 있는 지점의 고도·지역번호 등을 기록한다. 측량기술자의 업무를 보조하여 현장측량에 필요한 후시관측, 측량보조업무 등을 수행하여 실내에서는 측량성과 정리 등을 보조한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"손사용|시각|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"단순작업","similarNm":"측지보조원","dJobECd":"7059","dJobECdNm":"[7059]기타 채굴·토목 종사원","dJobJCd":"7849","dJobJCdNm":"[7849]기타 채굴 및 토목 관련 종사원","dJobICd":"M729","dJobICdNm":"[M729]기타 과학기술 서비스업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002820:1', '{"dJobCd":"K000002820","dJobCdSeq":"1","dJobNm":"토목잠수사","workSum":"교량·항만 등의 공사를 하기 위하여 수중에서 사석고르기, 돌쌓기, 용접, 절단 및 전기방식 등의 작업을 한다.","doWork":"작업장소의 기상·해상조건을 파악하여 작업방법, 순서, 업무분담 등을 협의·결정한다. 표면공급식(SSDS) 장비를 선택하여 잠수 전 장비의 이상 유무를 점검한다. 잠수장비를 착용하고 수중에 입수한다. 수중에서 잠수보조원 및 기중기조종원과 연락하며 규준틀을 설치하고 강제잣대에 맞추어 요철을 고른다. 물속에서 쇠지렛대를 사용하여 기중기로 내린 호안석, 블록, 피복석, 케이슨(Caisson:상자 형태로 제작된 콘크리트 구조물) 등을 좌우로 이동시켜 제자리에 설치한다. 구조물이 제자리에 안착되면 로프를 풀고 작업완료를 기중기조종원에게 통화 또는 신호로 보낸다. 수중에서 강구조물을 용접·절단작업 한다. 수심이나 구조형식을 고려하여 알루미늄, 마그네슘, 아연 등의 양극을 일정 간격으로 강구조물에 취부한다. 작업종료 후 작업시간, 작업내용, 잠수횟수, 잠수심도 등의 기록을 작성한다. 수중의 암반을 착암기, 소형쇄석드릴(Jack Hammer) 등을 이용하여 천공·발파한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"힘든 작업","workPlace":"실외","workEnv":"위험내재|다습|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"수중공사원","connectJob":"수중호안석공","certLic":"잠수기능사, 잠수산업기사","dJobECd":"7059","dJobECdNm":"[7059]기타 채굴·토목 종사원","dJobJCd":"7849","dJobJCdNm":"[7849]기타 채굴 및 토목 관련 종사원","dJobICd":"F421","dJobICdNm":"[F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004509:1', '{"dJobCd":"K000004509","dJobCdSeq":"1","dJobNm":"화약류관리보조원","workSum":"화약류 및 기자재를 관리하고 발파를 위한 화약 구멍에 화약 및 모래를 넣어 충전하며, 발파 실시에 따른 화약류관리원 업무를 보조한다.","doWork":"화약류(함수,초안폭약 등) 및 기자재(노관, 발파기, 도통시험기, 발파모선, 메가폰 등)를 종류별로 구분하여 화약취급소에 정리·보관·관리한다. 천공기운전원, 착암원이 뚫어 놓은 구멍에 화약을 넣고 모래를 충전시킨다. 발파하는 화약류관리원을 보조하고, 발파현장 주변을 통제한다. 작업현장의 화약요구에 따라 화약취급소로부터 발파현장까지 화약을 운반하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"화약류보조원","connectJob":"장약수, 장약공","certLic":"화약류취급기능사, 광산보안기능사","dJobECd":"7059","dJobECdNm":"[7059]기타 채굴·토목 종사원","dJobJCd":"7849","dJobJCdNm":"[7849]기타 채굴 및 토목 관련 종사원","dJobICd":"F412","dJobICdNm":"[F412]토목 건설업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002125:1', '{"dJobCd":"K000002125","dJobCdSeq":"1","dJobNm":"화약류관리원","workSum":"광석, 석탄, 토사석 등을 채광·채탄·채취하기 위한 광산 발파 또는 도로, 철도, 운하, 댐, 터널 등의 건설 시 암석의 분리·분쇄 작업을 위하여 소요되는 화약류 제품을 수불·통제·보안·취급업무를 관리한다.","doWork":"광산 개발을 목적으로 발파하는 경우 광산보안법에 따라, 건설을 위한 발파의 경우 총포화약류단속법에 따라 발파 시 복장 및 태도, 화약류 취급, 천공 및 발파, 불발화약 및 발파 후의 조치에 관한 보안교육을 실시한다. 화약류 취급요령을 숙지하고 화약류 취급자에게 보안교육을 실시한다. 발파계획을 파악하고 중·단기 화약수급계획을 수립한다. 화약수령에 따른 제반 서류를 작성하고 화약 보관부서로부터 화약을 수령하여 화약저장소까지 운반하는 일체의 사항을 감독한다. 화약류 및 기자재를 종류별로 구분하여 화약저장소에 보관·관리한다. 화약요구서에 따라 화약을 불출하고 착암원 혹은 천공기운전원이 뚫어 놓은 구멍에 화약류관리보조원(장약수 등)이 화약을 넣고 모래를 충진시키면 발파한다. 발파하고 남은 잔량을 회수한다. 화약관리대장에 수급·불출현황을 기록하고 재고량을 확인하여 관할 부서에 보고한다. 화약저장소의 안전 및 보안상태, 소방점검을 확인한다. 화약류에 관련된 각종 보고서를 작성하여 보고·보관한다. 화약류의 성능을 시험하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"분석","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"화약계장, 화약반장, 화약취급공, 화약관리원, 화약관리기사, 화약기사","connectJob":"화약발파안전계원","certLic":"화약류관리기사, 화약류관리산업기사, 화약취급기능사, 광산보안기사, 광산보안산업기사, 1급·2급화약류관리보안책임자","dJobECd":"7059","dJobECdNm":"[7059]기타 채굴·토목 종사원","dJobJCd":"7849","dJobJCdNm":"[7849]기타 채굴 및 토목 관련 종사원","dJobICd":"F412","dJobICdNm":"[F412]토목 건설업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007440:1', '{"dJobCd":"K000007440","dJobCdSeq":"1","dJobNm":"화약운반원","workSum":"화약류관리원의 지시를 받아 화약저장소의 정리, 화약류의 포장 및 수불업무를 수행하며, 화약류를 화약취급소로부터 작업장까지 운반한다.","doWork":"광산안전법, 총포 도검 화약류 등의 안전관리에 관한 법률 등 관계법에 의한 화약류 취급요령을 숙지한다. 지정된 용기와 운반수단을 이용하여 화약취급소로부터 화약류를 작업장까지 안전하게 분리, 운반한다. 화약관리원(채광관리원, 발파관리원)의 업무를 보조한다. 사용량 및 사용 후 잔량을 정확히 파악하여 화약관리원에게 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","connectJob":"화약창고작업원, 화약수, 장약수","dJobECd":"7059","dJobECdNm":"[7059]기타 채굴·토목 종사원","dJobJCd":"7849","dJobJCdNm":"[7849]기타 채굴 및 토목 관련 종사원","dJobICd":"F412","dJobICdNm":"[F412]토목 건설업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003060:1', '{"dJobCd":"K000003060","dJobCdSeq":"1","dJobNm":"건축모형제작원","workSum":"시공 계획에 있거나 시공된 건축구조물, 조경물 등을 설계도면을 보면서 축소·확대하여 모형을 제작한다.","doWork":"프레젠테이션 모형, 스터디 모형, 콘셉트 모형, 이미지 모형 등 모델링의 목적을 확인한다. 작업지시서나 설계도면을 확인하고 작업을 분담한다. 도면에 따라서 모형을 설계해 부분별로 재료를 절단·재단·가공한다. 절단되고 조각된 각 부분을 도면에 따라 조립한다. 제작·조립된 모형에 연출 작업을 한다. 조경재료, 수지재료 등의 원자재에 적절히 염색한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|시각|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"건물모델러","connectJob":"국가유산모형제작원, 현대건축물모형제작원, 플랜트모형제작원","certLic":"제품응용모델링기능사","dJobECd":"8841","dJobECdNm":"[8841]공예원","dJobJCd":"7911","dJobJCdNm":"[7911]공예원","dJobICd":"C339","dJobICdNm":"[C339]그 외 기타 제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007139:1', '{"dJobCd":"K000007139","dJobCdSeq":"1","dJobNm":"공예가","workSum":"목재, 석재, 점토, 금속 등의 재료와 공구를 사용하여 공예품(실용적이면서 예술적 가치가 있게 만든 물품)을 제작한다.","doWork":"작품의 주제, 메시지 등을 구상한다. 작품의 종류에 따라 재료를 선별하고 크기 및 수량에 따라 일정한 형태로 절단한다. 작품의 형태에 따라 줄, 가스용접기, 사포 등을 사용하여 원하는 형태로 제작한다. 점토 등을 반죽하여 작품을 만들기도 하고 별도의 페인팅 작업을 거치기도 한다. 창작작품을 토대로 전시회를 개최하거나 개인, 기업체, 공연단체 등이 의뢰한 작품을 제작하기도 한다. 공예품의 종류에 따라, 목공예, 염색공예, 도자공예, 한지공예, 금속공예, 석공예, 전통공예, 유리공예, 펠트공예, 점토공예, 가죽공예, 양초공예, 칠공예, 죽세공예 등의 물품을 제작한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|손사용|시각|","workEnv":"대기환경미흡|소음·진동|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"공예원","connectJob":"목공예원, 석공예원, 칠공예원, 종이공예원, 죽세공예원, 도자공예원, 금속공예원(방짜유기기능자 등), 자개공예원","dJobECd":"8841","dJobECdNm":"[8841]공예원","dJobJCd":"7911","dJobJCdNm":"[7911]공예원","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004504:1', '{"dJobCd":"K000004504","dJobCdSeq":"1","dJobNm":"공예도자기성형원","workSum":"반죽된 점토 소지를 손으로 다듬고 자른 후, 목적하는 형태로 쌓아 올려 도자기제품을 성형한다.","doWork":"성형을 위한 작업준비를 한다. 작업대를 정리하고 물과 나무조각칼 등의 작업도구를 준비한다. 작업주문서 및 작업명세서에 따라 성형할 공예품의 모양과 규격을 확인한다. 반죽한 점토소지를 작업대 위에 올려놓고 적당량을 잘라 기물의 바닥과 굽의 형태를 만든다. 점토소지를 일정 크기로 잘라 점토소지를 굴려 가늘고 긴 형태로 만든다. 만들어 놓은 점토소지의 바닥에서부터 한 줄씩 감아 올려 1차 성형을 한다. 감아 올린 성형체 표면의 접합부분 및 요철은 손에 물을 묻혀 표면을 매만져 고르게 다듬어 2차 성형을 한다. 성형물의 입구는 물을 묻혀 가며 둥글게 다듬는다. 완성된 성형물을 자름실을 이용하여 밑둥과 작업대로부터 분리하여 그늘에 건조하기 위하여 적재한다. 사각 또는 여러 각의 형태의 기물을 성형할 때에는 소지를 얇은 판형으로 반죽하고 칼로 잘라서 쌓아 올리기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|시각|","workEnv":"대기환경미흡|소음·진동|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"독물레작업원, 흙줄성형작업원","dJobECd":"8841","dJobECdNm":"[8841]공예원","dJobJCd":"7911","dJobJCdNm":"[7911]공예원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004510:1', '{"dJobCd":"K000004510","dJobCdSeq":"1","dJobNm":"국악기가죽가공원","workSum":"소, 말 등의 가죽을 가공 처리하여 장구, 북, 소고 등을 제조한다.","doWork":"입고된 가죽에서 털을 제거하기 위하여 약물 처리한다. 태고(물레 형태의 회전하는 커다란 드럼)에 톱밥과 가죽을 투입하여 가죽을 이완한다. 용도에 따라서 절단기를 사용하여 가죽을 일정 두께로 얇게 잘라낸다. 가죽의 지방질을 제거하기 위하여 화학약품으로 처리한다. 악기의 종류와 크기에 따라 칼을 사용하여 일정한 모양과 크기로 재단한다. 재단한 가죽을 일정한 모양의 틀에 맞추어 늘리고 편다. 못을 박아 가죽을 틀에 고정하고 일정한 시간동안 자연 건조한다. 건조된 가죽의 테를 실로 꿰매고 실과 철사 고리를 이용하여 부전(가죽이 강도를 조절하는 판)을 끼워 가죽을 통에 맨다. 부전을 밀거나 당기면서 가죽의 강도를 조절한다. 마른 가죽에 물을 적시면서 못을 치거나 가죽에 줄 구멍을 뚫기도 한다. 완성된 가죽을 울림통에 매달아 일정 시간 건조한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"청각|손사용|","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"8841","dJobECdNm":"[8841]공예원","dJobJCd":"7911","dJobJCdNm":"[7911]공예원","dJobICd":"C332","dJobICdNm":"[C332]악기 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006578:1', '{"dJobCd":"K000006578","dJobCdSeq":"1","dJobNm":"국악기울림통가공원","workSum":"장구, 북 등의 울림통을 제조하기 위하여 오동나무나 미루나무를 목재공구로 깎고 다듬는다.","doWork":"오동나무나 미루나무를 톱을 사용하여 일정한 크기로 절단한다. 절단한 나무를 선반의 척에 물리거나 고정구에 고정시켜 심압대에 끼운다. 기계를 가동하여 일정한 형태로 나무겉을 깎는다. 장구, 북 등의 형태에 따라 울림통의 내부를 칼로 깎는다. 일정한 형태로 가공한 나무를 접착하여 일정 시간 압착한다. 사포를 사용하여 다듬질한다. 완성된 울림통을 두드려 소리를 들어본다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"청각|손사용|시각|","workEnv":"위험내재|소음·진동|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"북통제조원, 장구통제조원","dJobECd":"8841","dJobECdNm":"[8841]공예원","dJobJCd":"7911","dJobJCdNm":"[7911]공예원","dJobICd":"C332","dJobICdNm":"[C332]악기 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006481:1', '{"dJobCd":"K000006481","dJobCdSeq":"1","dJobNm":"국악목관악기제조원","workSum":"대나무를 사용하여 대금, 소금, 단소, 피리 등의 국악목관악기를 제조한다.","doWork":"제조할 국악목관악기의 형태에 따라 알맞은 대나무를 선별한다. 절단톱을 사용하여 대나무를 일정 크기로 절단한다. 절단한 대나무를 일정 기간 동안 소금물에 담근 후 꺼낸다. 대나무에 묻은 오물을 헝겊으로 닦아낸다. 형태를 바로 잡기 위해 대나무를 불로 가열하고 틀거나 굽히기 위하여 손으로 힘을 가한다. 음정을 고려하여 드릴로 지공, 취구를 뚫는다. 정확한 음정을 내기 위해 지공, 취구명통 등을 수동공구를 사용하여 손질한다. 사포를 사용하여 마구리(양쪽 구멍부분)를 다듬질한다. 대나무가 터지지 않도록 악기의 중간 부분에 명주실을 감는다. 목관악기에 끼워 소리를 내는 피리 혀를 제조하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"청각|손사용|시각|","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"단소제조원, 대금제조원, 소금제조원, 향피리제조원","dJobECd":"8841","dJobECdNm":"[8841]공예원","dJobJCd":"7911","dJobJCdNm":"[7911]공예원","dJobICd":"C332","dJobICdNm":"[C332]악기 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004346:1', '{"dJobCd":"K000004346","dJobCdSeq":"1","dJobNm":"국악현악기제조원","workSum":"오동나무, 밤나무, 명주실을 사용하여 거문고, 가야금, 아쟁 등을 제조한다.","doWork":"작업지시서에 따라 오동나무나 밤나무를 작업대에 준비한다. 준비한 재료를 절단톱 등을 사용하여 규격에 따라 절단한다. 절단한 재료를 자연 건조한다. 절단한 나무를 대패, 끌 등을 사용하여 일정한 두께와 폭으로 깎는다. 위판(오동나무)과 뒤판(밤나무)을 접착제를 사용하여 붙인다. 오동나무판을 나무못이나 접착제를 사용하여 공명통의 위아래 부분에 붙인다. 봉미(줄 매는 부분)를 공명통의 밑부분에 붙이고 윗부분에는 학, 달, 해 등 무늬를 접착제로 붙인다. 악기의 변형을 방지하기 위해 오동나무 위판을 무늬가 들어날 정도로 인두로 긁어낸다. 모양을 내기 위해 대패, 끌 등을 사용하여 다듬질한다. 현을 제조하기 위해 악기의 크기에 따라서 명주실을 손으로 일정 횟수 꼰다. 꼬아진 명주실이 풀어지지 않도록 증기와 열을 가해 고정한다. 제조된 공명통에 현을 걸어준다. 안족(기러기 발모양의 버팀목)을 현과 공명통 사이에 끼운다. 완성된 제품을 육안으로 검사하고 악기음정을 검사하기 위하여 직접 연주하여 본다. 음정의 간격에 따라 정간(음의 높낮이를 조절하는 칸)을 접착제로 붙이기도 하고 필요에 따라 붓이나 스프레이를 사용하여 제품에 도장을 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"청각|손사용|시각|","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"가야금제조원, 거문고제조원, 아쟁제조원","dJobECd":"8841","dJobECdNm":"[8841]공예원","dJobJCd":"7911","dJobJCdNm":"[7911]공예원","dJobICd":"C332","dJobICdNm":"[C332]악기 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004572:1', '{"dJobCd":"K000004572","dJobCdSeq":"1","dJobNm":"금속공예가","workSum":"비철금속 및 금속을 사용하여 일용품이나 장식품을 만든다.","doWork":"프레스나 스웨이징을 사용하여 제품을 제작한다. 달군 금속판을 형 위에 씌우고 회전시켜 금속제 촉으로 눌러 성형하는 스피닝 기법을 사용하여 제품을 제작한다. 정밀함을 요구하는 제품은 선반을 이용하여 깎아 제작하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"8841","dJobECdNm":"[8841]공예원","dJobJCd":"7911","dJobJCdNm":"[7911]공예원","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006484:1', '{"dJobCd":"K000006484","dJobCdSeq":"1","dJobNm":"나전칠기도장공","workSum":"목재로 제작된 물건에 헝겊 등을 깔아놓고 옻칠 혹은 캐슈칠(Cashew)을 한다.","doWork":"부드러운 목재로 제작한 백골(칠과 자개세공을 하기 전의 장, 혹은 함과 같은 나전제품) 밑바탕에 천이나 종이를 전면에 붙인다. 그 위에 아교에 녹인 호분(조개껍질을 구워 만든 백분)을 나무주걱으로 문질러서 백골의 미세한 틈새를 메우고 반질반질하게 만든다. 부드러운 사포로 물을 뿌리면서 연마하여 표면을 매끄럽게 만든 후 습기를 제거한다. 삼베 천 혹은 한지를 바른다. 조개가루와 칠을 반죽하여 마른 후에 바탕칠을 하고, 마르면 닦아낸다. 사포를 사용하여 칠한 부위를 고르게 문지르고 다시 옻칠을 한다. 이런 과정을 수 회 반복한 후 자개·금속장식세공원에게 이송한다. 자개세공 작업이 끝나면 다시 옻칠(Cashew)을 여러 번 하고 자개 위의 옻칠을 조심스럽게 걷어낸다. 최종적으로 사포로 다시 갈고 광약과 부드러운 솜(탈지면)을 사용하여 광택을 낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"나전칠기도장원, 정재장","connectJob":"칠공, 정재장, 생칠장","certLic":"목공예기능사, 국가유산수리기능자(칠공)","dJobECd":"8841","dJobECdNm":"[8841]공예원","dJobJCd":"7911","dJobJCdNm":"[7911]공예원","dJobICd":"C320","dJobICdNm":"[C320]가구 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004092:1', '{"dJobCd":"K000004092","dJobCdSeq":"1","dJobNm":"나전칠기백골원","workSum":"목재나 합판을 절단하여 나전제품의 부품을 아교로 붙여 백골을 제작한다.","doWork":"목공도구나 목공기계를 이용하여 제품의 설계도면에 따라 목재를 자르고 깎고 다듬는다. 곡선모양으로 제품을 재단할 때는 자동톱(루터)을 사용하고 부품 접합 시에는 접착제(본드)를 사용하여 고무줄이나 조임쇠로 조인다. 일정 시간 경과 후 접착제가 응고됐는지 확인하고 조였던 고무줄이나 조임쇠를 푼다. 접합된 부분에 밀려 나온 접착제는 물솔로 닦아내고 닦이지 않는 곳은 사포로 문지르거나 대패로 다듬어 표면을 매끈하게 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"백골부","certLic":"목공예기능사","dJobECd":"8841","dJobECdNm":"[8841]공예원","dJobJCd":"7911","dJobJCdNm":"[7911]공예원","dJobICd":"C320","dJobICdNm":"[C320]가구 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004778:1', '{"dJobCd":"K000004778","dJobCdSeq":"1","dJobNm":"단청기술자","workSum":"현장조사나 고증자료를 통하여 복원단청이나보수건물의갈아끼운신부재를땜단청인가를 파악하고설계도서에 따라 문양모사 및 복원도를 작성하여 단청시공 순서에 따라 단청시공 현장을 총괄 관리·감독한다.","doWork":"단청공사 시 현장조사를 통해 단청공사를 계획한다. 단청편수에게 업무를 지시한다. 단청 문양및색채 모사, 복사및초안도작성, 출초 및 타분, 조채및접착제조합, 먹,분선기화, 불벽,포벽화및풍혈화 등의도채를 한다. 감독원입회하에 문양모사, 조채하기, 면닦기 등을 한다. 단청 시공 순서에 따라 단청시공 현장을 총괄 관리, 감독한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"손사용|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","certLic":"국가유산수리기술자(단청)","dJobECd":"8841","dJobECdNm":"[8841]공예원","dJobJCd":"7911","dJobJCdNm":"[7911]공예원","dJobICd":"F411","dJobICdNm":"[F411]건물 건설업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006016:1', '{"dJobCd":"K000006016","dJobCdSeq":"1","dJobNm":"단청편수","workSum":"단청시공 현장에서 화공의 단청시공 진행과정을 총지휘하고 감독한다.","doWork":"단청기술자로부터 작업에 대한 자세한 내용을 지시받는다. 단청 시공 순서에 따라 시공 과정을 순서대로 원만하게 진행시킨다. 화공들의 시공활동 영역을 지시하고 감독한다. 기술적인 면에서 지원을 하며 문제점이 발생하면 담당자나 관련 기술자와 협의한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","connectJob":"도채장, 단청책임자, 단청반장","certLic":"국가유산수리기능자(화공)","dJobECd":"8841","dJobECdNm":"[8841]공예원","dJobJCd":"7911","dJobJCdNm":"[7911]공예원","dJobICd":"F411","dJobICdNm":"[F411]건물 건설업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002405:1', '{"dJobCd":"K000002405","dJobCdSeq":"1","dJobNm":"도자기검사원","workSum":"완성된 도자기를 검사하여 불량품을 선별하고 불량품은 깨뜨린다.","doWork":"도자기의 종류에 따라 검사항목, 검사방법 등 검사표준서의 내용을 숙지하고 작업지시사항에 따라 검사할 도자기의 규격과 형태, 모양 등을 확인한다. 컨베이어를 타고 흘러나오거나 검사대 위에 한 줄로 배열된 완성품을 각각 집어서 색채, 표면의 굴곡, 균열, 흠집, 장식의 위치와 상태 등을 검사한다. 불량품을 구별하여 선별한 후 파쇄공정으로 보낸다. 수정이 가능한 제품은 결함부분에 분필이나 크레용으로 표시하여 따로 모아 해당 공정으로 돌려보낸다. 합격품과 불량품의 수량을 파악하여 작업표에 기록한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","dJobECd":"8841","dJobECdNm":"[8841]공예원","dJobJCd":"7911","dJobJCdNm":"[7911]공예원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003844:1', '{"dJobCd":"K000003844","dJobCdSeq":"1","dJobNm":"도자기인쇄원","workSum":"도기류와 자기접시 등에 도안을 인쇄하는 기계를 운전·조작한다.","doWork":"인쇄할 도자기의 종류, 규격, 인쇄부위, 인쇄문양 및 도안을 작업지시서와 비교하여 확인한다. 인쇄기의 작동 여부를 점검한다. 도자기의 크기와 인쇄할 특성에 따라 인쇄기의 게이지를 관찰하고, 기계의 압력을 조정한다. 인쇄에 필요한 잉크를 배합하여 인쇄통에 주입한다. 작업대에 인쇄할 도자기를 놓고 고정한다. 인쇄기의 가이드바(조정핸들)를 조절하여 도자기 위에 스탬프(Stamp)를 올려놓는다. 인쇄기의 헤드를 낮추고, 도자기에 도안을 찍는 페달을 누른다. 인쇄금형에서 도자기를 빼내고, 연속작업을 한다. 인쇄상태를 검사하여 결함이 있는 기물을 따로 분류하여 보관한다. 잉크의 얼룩이나 과다한 광택제를 제거하기 위하여 연마제로 문지르기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"조작운전","dJobECd":"8841","dJobECdNm":"[8841]공예원","dJobJCd":"7911","dJobJCdNm":"[7911]공예원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002476:1', '{"dJobCd":"K000002476","dJobCdSeq":"1","dJobNm":"도자기장식원","workSum":"기계작업이나 시유작업 등 장식하기 어려운 것을 정해진 도안에 따라 붓으로 칠하고 그림을 그려 장식한다.","doWork":"양각, 음각, 투각, 부각, 상감처리로 1차 장식한 도자기의 2차 장식공정을 위하여 장식할 도자기의 규격, 형태, 장식부위, 장식문양 및 도안을 작업주문서와 비교하여 확인한다. 장식할 제품을 준비하고 샘플이나 작업지시서를 받는다. 여러 종류의 장식붓을 세척하여 준비하고 혼합된 안료를 수령하거나 직접 혼합하여 색상을 확인한다. 안료에 규산소다 등의 용해제를 첨가하여 안료를 희석한다. 칠이나 그림에 적당한 붓을 사용하여 장식할 부위에 그림을 그리고 색칠한다. 공동작업이 필요하면 다음 작업원에게 인계한다. 접시나 컵 등의 테두리에 선을 그을 때에는 장식할 기물을 물레 위에 올려놓고 회전시키며 테두리에 붓을 대어 선을 긋기도 한다. 작업이 완성되면 건조 후 전사지 부착공정으로 이송한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"8841","dJobECdNm":"[8841]공예원","dJobJCd":"7911","dJobJCdNm":"[7911]공예원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006140:1', '{"dJobCd":"K000006140","dJobCdSeq":"1","dJobNm":"도자기조각원","workSum":"성형된 도자기를 장식하기 위해 손이나 기계장식이 불가능한 부분을 조각도로 음각, 양각, 상감조각을 한다.","doWork":"성형이 완료된 도자기공예품의 1차장식공정을 위하여 작업주문서 및 작업지시서에 따라 조각할 도자기공예품의 크기와 형태를 확인하고 조각문양 및 조각부위를 확인한다. 작업을 위하여 여러 종류의 도자기용 조각칼 등 도구를 준비한다. 조각할 도자기공예품을 수령하고 견본이나 작업지시서를 확인한다. 작업지시서에 맞추어 조각칼로 음각, 양각, 상감조각을 하여 형태를 나타낸다. 각종 조각칼을 사용하여 도자기의 표면을 일정하게 다듬는다. 조각이 완료된 도자기를 대차에 적재하여 1차 소성공정으로 이송한다. 경우에 따라서 일정한 패턴의 문양이나 조각원의 자유로운 창작문양으로 조각을 하기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"도자기조각사","certLic":"도자공예기능사","dJobECd":"8841","dJobECdNm":"[8841]공예원","dJobJCd":"7911","dJobJCdNm":"[7911]공예원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003042:1', '{"dJobCd":"K000003042","dJobCdSeq":"1","dJobNm":"도자기조립원","workSum":"위생도기류, 자기류, 내화요업류의 도자기 제품의 부분품을 조립한다.","doWork":"작업지시서에 따라 조립할 도자기 및 요업제품의 종류와 규격, 형태, 부품 등을 확인하고 점검한다. 작업표준서에 의하여 위생도기류(변기 및 소변기, 세면기), 자기류, 내화요업류(애자) 등의 조립순서와 방법을 확인한다. 위생도기 제조 시 상부와 하부 등으로 구분되어 성형된 제품을 수령하여 석고형과 성형체를 분리시킨 후 각 부분을 결합하고 파이프 연결을 위한 부속품 등을 조립한다. 조립이 끝난 반제품에 고유번호와 제조일자 등을 인쇄한다. 자기류의 몸체와 손잡이, 주둥이 등 복잡한 형상의 제품 성형 시 분리하여 성형한 각 부분품을 슬립(고체 입자의 현탁액)을 이용하여 조립한다. 조립할 부위의 위치를 선정하고 조립할 부위를 칼이나 스펀지 등으로 다듬고 슬립을 칠하여 부분품을 부착한다. 애자 제조 시 완성된 애자와 금구를 조립한다. 애자, 금구, 접착시멘트 등을 준비하고, 애자와 금구에 절연 니스를 칠한다. 접착 시멘트를 혼합기준에 따라 혼합한 후 접착 부위에 칠한다. 금구(금속류)와 애자를 접착시켜 조립하고 애자와 금구에 묻은 시멘트를 닦아 낸다. 조립된 애자를 양생실에 넣어 스팀으로 양생한다. 각 도자기 및 요업제품의 조립이 완성되면 검사공정으로 이송한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|시각|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8841","dJobECdNm":"[8841]공예원","dJobJCd":"7911","dJobJCdNm":"[7911]공예원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;