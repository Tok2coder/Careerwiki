INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001936:1', '{"dJobCd":"K000001936","dJobCdSeq":"1","dJobNm":"금속가열로반장","workSum":"압연 또는 단조하기에 적당한 온도로 금속소재를 가열하는데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"금속소재의 특성을 확인하고 가열로 작업준비를 지시한다. 가열로 장입 및 추출장치, 가열로의 버너, 송풍기, 펌프 등 가열로 및 관련 설비를 점검한다. 이상 및 불량개소의 수리를 지시하고 관련 부서에 정비를 의뢰한다. 장입을 지시하고 가열상태를 관찰하여 작업표준에 따라 가열시간을 결정한다. 작업원에 대한 직무교육 및 안전위생교육을 통하여 직무수행기술을 향상시키고 안전재해를 예방한다. 작업내용을 작업일지에 기록하고 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|고온|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","certLic":"압연기능장","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007134:1', '{"dJobCd":"K000007134","dJobCdSeq":"1","dJobNm":"금속원료계량원","workSum":"금속재료의 용해, 주조 또는 정련을 목적으로 사용되는 각종 원료들의 구매계획 수립, 입고 검사, 저장과 시설관리 업무와 조업에 사용될 원료의 계량 업무를 수행한다.","doWork":"금속의 용해 또는 정련에 사용되는 원부재료의 품질규격과 물질 특성을 파악하고, 생산계획을 통해 각 제품별로 적합한 원료와 부재료의 필요 수량을 산정하고, 재고량을 관리한다. 작업자의 안전, 보건을 위해 재료의 물질안전보건자료를 확인과 계량 및 재료 운반설비의 이상유무를 점검한다. 작업지시서에 따른 원료를 계량하고 후속 공정에 투입될 수 있도록 작업한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"균형감각|","workEnv":"대기환경미흡|소음·진동|","workFunc1":"계산","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"부원료관리원","certLic":"주조기능사, 주조기능장","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001397:1', '{"dJobCd":"K000001397","dJobCdSeq":"1","dJobNm":"금속원료반장","workSum":"금속 및 비철금속을 생산하기 위한 각종 원료와 부재료의 저장·조합·운반·건조하는데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"생산계획표를 숙지하고 작업계획을 수립한다. 작업에 필요한 원료를 확보하고 설비공구·자재를 준비한다. 작업원에게 안전위생 및 직무에 관한 교육을 실시하고 안전재해예방과 제반 기술교육을 실시한다. 작업표준에 따라 작업을 지시하고 작업이행 여부를 확인한다. 작업표준서에 준한 각종 설비의 예비점검을 실시하여 이상 시 정비 관련 부서에 보수·정비하도록 지시한다. 작업원과의 수시 면담을 통하여 애로 및 건의사항을 수렴·해결한다. 작업장을 순회하며 원료상태 및 재고량을 확인한다. 원료하역작업을 감독·조정하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","similarNm":"원료처리반장","certLic":"제선기능사, 제선기능장, 금속재료기능사","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C241/C242","dJobICdNm":"[C241]1차 철강 제조업 / [C242]1차 비철금속 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005296:1', '{"dJobCd":"K000005296","dJobCdSeq":"1","dJobNm":"금속원료준비원","workSum":"금속 및 비철금속을 생산하기 위한 각종 설비를 조정·조작하여 원료 및 부재료를 저장·조합·운반·건조한다.","doWork":"작업표준명세서나 금속원료반장의 지시사항을 확인한다. 원료 및 부재료의 저장량과 저장상태, 각종 저장탱크 및 설비의 이상 유무를 점검·확인한다. 작업표준에 명시된 입도로 원료를 부수는 파쇄기, 건조기, 컨베이어벨트의 작동상태를 점검한다. 원료배합 및 수급계획에 따라 원료별 또는 원료배합비율별로 분리하여 저장·관리·장입·수불·배합한다. 일일배합작업량 및 건조량 등 작업내용을 작업일지에 기록하여 작업상황을 관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"원료설비운전원, 원료설비작업원","connectJob":"광석조합원, 데이빈원, 원료계량원, 원료혼합원, 원료건조기조작원, 광석건조로조작원","certLic":"제선기능사, 제선기능장","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C241/C242","dJobICdNm":"[C241]1차 철강 제조업 / [C242]1차 비철금속 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003447:1', '{"dJobCd":"K000003447","dJobCdSeq":"1","dJobNm":"금속자원재생원료가공원","workSum":"시험분석 결과에 따라 금속 함량별로 금속자원재생원료를 분류하고 파쇄한다.","doWork":"폐인쇄회로(PCB)기판 등의 금속자원재생원료를 시험분석 결과를 바탕으로 동일 금속함량별로 분류하여 파쇄기에 넣어 적당한 크기로 분쇄한다. 분쇄된 원료를 금속함량별로 보관한다. 납품 시 요구되는 품위에 따라 분쇄된 원료들을 금속함량을 고려하여 혼합한다. 호퍼를 이용하여 마대나 톤백 등에 넣어 적재한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"E383","dJobICdNm":"[E383]해체, 선별 및 원료 재생업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006901:1', '{"dJobCd":"K000006901","dJobCdSeq":"1","dJobNm":"금속재료용해원","workSum":"철강 또는 비철금속의 주조를 위해 규격에 맞도록 합금성분을 계산하여 재료를 장입, 용해 후 온도를 조정하고 목적한 합금성분의 용탕을 제조한다.","doWork":"용해로 및 내화물의 이상유무를 확인하고, 주조품의 목표성분을 파악하여 목표성분을 만족할 수 있는 장입재의 배합비를 계산한다. 용해로에 계산된 재료를 장입하고 용해로의 운전을 통해 재료를 용해하며 화학 성분표와 분석장치를 활용하여 목표치로 화학성분을 조절한다. 작업표준서에 따라 지시된 용탕온도를 측정, 유지하고 출탕 전 슬래그를 제거하여 용탕을 깨끗이 할 수 있도록 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"알루미늄용해원, 용동원, 도가니로원, 용해로조작원, 유지로조작원, 출탕원","certLic":"주조기능사, 주조기능장","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006933:1', '{"dJobCd":"K000006933","dJobCdSeq":"1","dJobNm":"금속제련원","workSum":"광석 및 이를 대체할 수 있는 원료에 고온반응을 적용(건식제련) 또는 용매를 사용하여 광석 및 재활용 원료를 용해한 수용액에서 목적 금속을 생산(습식제련)한다.","doWork":"광석 또는 폐자원으로부터 목적한 금속을 추출하기 위하여 최적의 습식 또는 건식공정을 선택하거나 두 공정을 동시에 선정하여 설비 및 부원료를 준비한다. 건식제련의 경우 최적의 용융 및 환원조건을, 습식제련의 경우 최적 침출 및 금속의 회수를 위한 화학반응을 고려한다. 입고된 원료를 분석하고 필요한 조성으로 배합하고 형상을 제어하는 등 원료를 예비처리 한다. 건식제련의 경우 고온에서 환원가스와의 반응를 최적화하여 목적 금속과 불순물을 분리 회수하고, 습식제련의 경우 용매를 사용하여 수용액에서 목적 금속을 생산하고 순도 및 품질을 검사한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"용련통합제어실조정원","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C242","dJobICdNm":"[C242]1차 비철금속 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001316:1', '{"dJobCd":"K000001316","dJobCdSeq":"1","dJobNm":"금제련원","workSum":"시안화나트륨(NaCN) 등 용매를 사용하여 광석 또는 재활용 원료를 용해한 후, 전해조에서 전기 분해시켜 금을 채취한다.","doWork":"광석을 잘게 분쇄하여 이것을 시안화나트륨이나 시안화칼륨 또는 시안화칼슘 0.1∼0.5%의 수용액에 가하여 공기를 불어넣으면서 교반하여 광석 중의 금을 시아노착염으로 녹여낸다. 이 용액을 조금을 판으로 주조한 양극과 전해액으로 염화금을 사용한 음극 순금판의 전해조에서 전해정련을 실시한다. 액체의 온도를 60∼70℃로 유지하고 직류 및 교류를 교대로 통해서 양극표면의 염화은 생성피막을 제거한다. 정출된 금은 흑연도가니 속에서 융해시켜 잉곳으로 만든다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실내","workEnv":"위험내재|다습|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"비철제련기술자","connectJob":"은전해원","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C242","dJobICdNm":"[C242]1차 비철금속 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003297:1', '{"dJobCd":"K000003297","dJobCdSeq":"1","dJobNm":"납제련원","workSum":"납광석으로부터 납을 추출하여 고순도의 납을 제조한다.","doWork":"납광석을 용광로 제련에 적합하도록 괴상으로 만들고, 휘발성 성분을 제거하기 위하여 소결로에서 소결한다. 소결광을 연료와 코크스, 용제로서 석회석 등을 가하여 용광로에 투입하고 송풍하여 납을 제조한다. 이를 건식제련 또는 전해정련을 거쳐 고순도의 납을 제조한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|고온|다습|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"비철제련기술자","connectJob":"금속제련기술사","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C242","dJobICdNm":"[C242]1차 비철금속 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003085:1', '{"dJobCd":"K000003085","dJobCdSeq":"1","dJobNm":"단락원","workSum":"전해조의 전기분해에서 양호한 전착상태가 되도록 종판과 조동 사이의 간격을 조정하고 단락(Short Circuit)된 전극을 교정한다.","doWork":"적외선 주사기를 기중기에 부착한다. 적외선 기중기에 전원을 연결하고 스위치를 켜 감도를 조정한다. 전해조 위를 기중기로 주행하면서 자동 촬영하거나 전해조 위를 순회하며 전압측정기를 사용하여 전압 세기를 측정한다. 촬영 이미지를 판독하거나 전압상태가 불량한 곳에 단락 표시를 하고 단락회수를 집계한다. 단락 표시된 전극을 플럭스메타(Flux Meta) 등 수동공구를 사용하여 수정, 제거, 교정한다. 종판상태의 휨 및 표면의 전착불량상태를 교정하여 전해조에 다시 장입한다. 종판 사이의 간격을 일정하게 유지한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"고온|다습|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"전해조교정원","certLic":"제강기능사, 제강기능장","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C242","dJobICdNm":"[C242]1차 비철금속 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005654:1', '{"dJobCd":"K000005654","dJobCdSeq":"1","dJobNm":"동정액반장","workSum":"양극조동을 전해하는데 필요한 전해액 내의 불순물을 제거하기 위하여 전물(Slim)침출처리, 탈동탈비소, 농축, 조황산니켈 분리 등의 작업에 종사하는 작업원의 활동을 감독·조정한다.","doWork":"작업원의 인원관리 및 작업지시서에 따른 작업을 분배한다. 작업장을 순회하며 안전교육 및 제반 기술교육을 실시한다. 전해액의 불순물 농도를 측정하고 조절한다. 공장 내의 정액작업에 필요한 시설 및 장치의 이상 유무를 확인하고 수리·보수하는 작업원의 활동을 감독·조정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"고온|다습|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C242","dJobICdNm":"[C242]1차 비철금속 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002914:1', '{"dJobCd":"K000002914","dJobCdSeq":"1","dJobNm":"동정제로조작원","workSum":"전로에서 운반된 조동용탕을 정제로에 장입하여 산화 및 환원반응을 통해 각종 불순물을 제거하고 정제하는 정제로를 조작한다.","doWork":"정제로의 좌·우회전상태, 브레이크상태, 비상구동장치의 작동상태, 팬 및 모터작동상태 등을 점검·확인한다. 기름버너를 점화하고 불꽃을 조절하여 정제로를 일정 온도까지 가열한다. 전로에서 레이들에 담은 조동용탕을 정제로 장입구에 투입하기 위하여 정제로 뚜껑을 열고 용탕을 붓고, 뚜껑을 닫도록 천장기중기조작원에게 신호한다. 조동용탕 위에 덮인 슬래그를 거르기 위해 정제로를 좌우로 회전시키는 조작반의 스위치를 조작하여 노를 일정 각도로 기울인다. 압축공기 밸브를 열어 정제로에 공기를 주입하여 조동용탕을 산화시킨다. 온도 및 공기압력 계기판을 조정한다. 산화상태를 육안으로 검사하고 배관을 용동 내에 삽입하고 밸브를 열어 환원제를 정제로에 투입한다. 샘플을 채취하여 환원상태를 검사한다. 정제로를 기울여 출탕한다. 우구를 교체하기도 하고, 출탕구를 정리하기도 한다. 샘플을 채취하여 실험실에 성분분석을 의뢰하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C242","dJobICdNm":"[C242]1차 비철금속 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006170:1', '{"dJobCd":"K000006170","dJobCdSeq":"1","dJobNm":"동정제반장","workSum":"조동용탕을 정제로에 장입하여 동을 정제하는데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"작업원의 안전교육 및 제반 기술교육을 실시한다. 조동용탕을 정제로에 투입하는 일련의 작업을 지시한다. 용동의 시료를 관찰하여 산화작업과 환원작업의 종말점을 판정한다. 정제로 설비물의 결함 또는 기계고장을 탐지하기 위해 검사하고 수리·보수하는 작업원의 활동을 감독·조정한다. 작업원의 근태상황을 관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"고온|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C242","dJobICdNm":"[C242]1차 비철금속 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005938:1', '{"dJobCd":"K000005938","dJobCdSeq":"1","dJobNm":"레이들관리원","workSum":"양질의 용선 또는 용강의 생산과 취급을 위하여 조업에 필요한 내화물을 최적의 상태로 관리하며, 유지 및 보수를 통해 철강의 안정적 생산을 도모토록 한다.","doWork":"레이들의 주요 구성품인 철강 재질의 외피와 내화물의 품질을 확인하여 용선 또는 용강을 취급하는데 이상없도록 준비하며, 경우에 따라 예열을 실시한다. 내화물 이상시 정형 또는 부정형 내화물과 축로용 장비 및 수공구를 사용하여 각종 요로를 축조하고 관리·보수하는 업무 수행한다. 양질의 용선 또는 용강을 생산하기 위해 설비에 대한 운전기록을 관리하고 정기적인 점검을 통해 설비를 최적 상태로 운용할 수 있도록 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"힘든 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|고온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"레이들수리원","connectJob":"축로원","certLic":"축로기능사","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007245:1', '{"dJobCd":"K000007245","dJobCdSeq":"1","dJobNm":"박리기조작원","workSum":"아연이 전착된 음극판에서 아연을 분리·탈하시키고 다음 전착이 용이하게 종판을 연마하는 자동박리기를 조작한다.","doWork":"개폐용 공기호스, 연마기 브러시 회전상태, 연마수, 연마기 파손 여부, 컨베이어후크 교정상태 등을 점검한다. 자동박리기 스위치를 조작하여 기계를 가동하고, 기중기를 이용하여 대차에 적재한다. 연마수 밸브를 열어 연마수량을 조절하고 연마수 펌프를 조작하여 가동한다. 컨베이어를 통해 자동박리기에 투입되는 전착된 음극판을 관찰하고, 박리된 전착아연을 적중기에 정리한다. 박리된 음극판에 묻어 있는 불순물을 제거하고 전착을 용이하게 하기 위하여 연마기로 음극판 표면을 연마한다. 연마된 음극판을 기중기를 이용하여 전해조에 다시 투입한다. 박리기 운전일지 및 작업량을 기록·작성한다. 연마기 하부에 쌓인 아연조각을 제거하기도 하며, 박리칼을 교환하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"다습|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C242","dJobICdNm":"[C242]1차 비철금속 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002560:1', '{"dJobCd":"K000002560","dJobCdSeq":"1","dJobNm":"반응로장입원","workSum":"연(Ph:납)을 생산하기 위하여 원료를 반응로(Reactor)에 투입하는 장비 및 부대설비를 조작한다.","doWork":"작업지시서 및 연제련반장의 지시에 따라 원료수급계획을 수립한다. 원료장 입구를 항상 청결하게 정리·정돈하고 관련 설비의 이상 유무를 확인한다. 반응로 장입되는 연정광 상태를 관찰하고 슈트(Chute)와 호퍼가 막히지 않도록 수동공구를 사용하여 뚫어준다. 투입되는 연정광의 샘플을 채취하여 투입 원료의 수분함유량, 이물질혼합 여부 등을 확인하기 위해 실험실에 의뢰하고 그 결과를 확인한다. 원료를 투입하기 위하여 가동되는 컨베이어의 후미에 떨어진 낙광을 정리한다. 작업내용을 작업일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"투입인출","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C242","dJobICdNm":"[C242]1차 비철금속 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006415:1', '{"dJobCd":"K000006415","dJobCdSeq":"1","dJobNm":"반응로조작원","workSum":"연정광을 태워 산화슬래그(Slag)와 황산으로 만들기 위한 반응로 및 관련 장비를 조작한다.","doWork":"작업지시서나 연제련반장의 지시에 따라 일일생산계획을 세운다. 각종 설비의 이상 유무 및 설비의 가동상태를 파악하여 현장에 통보한다. 반응로를 조작하여 연정광을 산화시켜 슬래그를 생성하고 황산(기체상태에서 수증기로 회수)으로 제조한다. 샘플결과에 따라 원료수송 순서 등을 조정하기 위하여 원료준비원에게 통보한다. 원료수송설비 운전 및 수송상태를 모니터를 통하여 점검한다. 조정계기를 판독하여 온도, 압력, 부하율 등의 작업상황을 관찰하고 내용을 일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"고온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C242","dJobICdNm":"[C242]1차 비철금속 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005772:1', '{"dJobCd":"K000005772","dJobCdSeq":"1","dJobNm":"배소로조작원","workSum":"아연정광(ZnO)을 유동배소로에서 산화배소시켜 산화아연으로 생산하기 위한 급광설비, 배소로, 송풍기, 보일러, 집진설비 등의 설비를 조작한다.","doWork":"작업지시서나 배소반장의 지시에 따라 일일생산계획을 세우고 각종 설비의 이상 유무를 점검한다. 조정실 계기를 조절하여 배소로 온도, 냉각장치, 압력, 컨베이어 속도 등을 작업표준에 맞도록 유지한다. 아연정광이 투입되는 진행상황을 모니터로 관찰하며 투입량을 조절하여 급광량을 확인한다. 배소로에서 태워진 소광 및 가스가 다음 공정으로 운송되는 상태를 확인한다. 유동층에서 소광시료를 채취하여 입도를 분석하고 이상 발견 시 보고한다. 조정계기판을 판독하여 온도, 압력, 부하율 등을 작업일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"배소로자동제어원","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C242","dJobICdNm":"[C242]1차 비철금속 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001838:1', '{"dJobCd":"K000001838","dJobCdSeq":"1","dJobNm":"배소반장","workSum":"아연소광을 만들기 위해 정광을 배소하는데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"작업지시서에 따라 세부실행계획을 수립하고 인원관리 및 작업분배를 한다. 작업장을 순회하며 안전교육 및 제반 기술교육을 실시한다. 배소로에 정광이 투입되어 배소된 소광상태가 작업표준과 부합되는지 확인하기 위해 색깔 및 입도를 육안으로 관찰한다. 배소로 제어장치의 계기를 판독하고 공정의 흐름을 파악한다. 기계의 기능장애나 결점을 발견하기 위해 기계장치를 점검하며 작업원에게 보수하도록 지시한다. 생산량 및 작업내용을 작업일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"고온|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C242","dJobICdNm":"[C242]1차 비철금속 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001562:1', '{"dJobCd":"K000001562","dJobCdSeq":"1","dJobNm":"셀레늄가스처리원","workSum":"용전로 배출가스 중에 함유된 분진, 셀레늄, 귀금속 등을 회수하기 위하여 가스냉각기, 가스세척탑 및 전기집진기를 조작한다.","doWork":"용전로 배출가스를 냉각시켜 산화셀레늄을 가스냉각기의 호퍼에 포집시켜 회수한다. 가스냉각기 내에 함유된 분진을 포집하기 위하여 가스세척탑에 물을 순환한다. 가스세척탑에서 포집되지 않은 잔여 수분과 분진을 포집하기 위하여 전기집진기의 정류기를 운전한다. 가스세척탑에 포집된 분진과 산화셀레늄용액을 아황산가스 반응조에 통과시키고, 진공여과기에서 여과한 후 건조기에서 건조되도록 각 설비를 조작한다. 펌프를 작동시켜 여과한 용액을 폐수처리장으로 보낸다. 가스세척탑에 순환되는 용액 중의 셀레늄 농도분석, 용탕의 육안관찰, 연도청소 및 가스냉각기를 청소한다. 침전물 중의 셀레늄을 휘발시켜 가스냉각기에 포집하기 위하여 회전건조로를 가동한다. 잔여물을 용전로에 투입한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"고온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C242","dJobICdNm":"[C242]1차 비철금속 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001817:1', '{"dJobCd":"K000001817","dJobCdSeq":"1","dJobNm":"셀레늄반장","workSum":"용전물 배출가스 중에 함유된 분진, 셀레늄, 귀금속 등을 회수하기 위하여 각종 설비를 조작하는 작업원의 활동을 감독·조정한다.","doWork":"작업계획에 따라 세부항목을 수립하여 작업원에게 작업을 지시하고 함께 작업하며 이행하는지 확인한다. 작업원을 배치하고 인원관리, 안전교육 및 직무교육을 실시한다. 용전로, 전물용해, 가스처리 등의 작업을 지시·조정한다. 배출되는 가스의 색을 관찰하고 작업의 이상 유무를 확인한다. 각종 설비의 이상 유무를 점검한다. 작업내용을 작업일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"고온|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C242","dJobICdNm":"[C242]1차 비철금속 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001698:1', '{"dJobCd":"K000001698","dJobCdSeq":"1","dJobNm":"소결원","workSum":"분말 상태의 철광석을 소결로에서 가열하여 품질을 고르게하고 일정한 크기로 괴상화하여, 고로조업에 적합한 양질의 소결광을 안정적으로 생산한다.","doWork":"분철광석을 소결하기 위한 연·원료와 설비를 점검하고, 연·원료 정량 절출장치를 이용하여 소결에 적합한 원료로 배합한다. 공구를 사용하여 원료장입기(Drum Feeder) 절출 게이트의 부착광 제거와 셔틀 컨베이어를 이용, 연·원료가 소결기에 균일하게 장입되도록 한다. COG를 이용하여 점화로에 착화하고 화염을 보고 유량을 조절한다. 점화로내 온도의 셋팅값 유지를 확인한다. 소결기 조업상황을 파악하여 구동장치로 소결 속도를 조정한다. 소괴상화된 소결광을 핫 크러셔를 이용, 파쇄하고 핫 스크린을 이용하여 선별한 후, 냉각송풍기를 이용하여 냉각한다. 이후 소결광을 파쇄하고 고로 빈으로 이송하여 고로에 사용할 수 있도록 저장한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"고온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"소결제어실운전원, 소결기조작원","certLic":"제강기능사,제강기능장 전기기능사, 제선기능장, 전기기능사, 금속재료기능사, 가스기능사, 용접기능사","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004220:1', '{"dJobCd":"K000004220","dJobCdSeq":"1","dJobNm":"아말감제련원","workSum":"수은 용융처리로 원광에서 금 또는 은을 분리시키는 기계장치를 조작한다.","doWork":"밸브를 조작하여 도금판 위의 원광과 물의 유동을 조절한다. 형판의 각도를 조절하여 아말감 침적을 촉진한다. 형판에 쌓인 아말감을 문질러 깎아내고 수은으로 형판을 도금한다. 밸브를 조작하여 원광과 수은을 회전식통이나 교반식 탱크에 투입한다. 기계장치를 시동하고 아말감 침적상태를 육안으로 관찰한다. 통이나 탱크의 물을 배출시키고 금 또는 은 아말감을 회수한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|고온|다습|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C242","dJobICdNm":"[C242]1차 비철금속 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006031:1', '{"dJobCd":"K000006031","dJobCdSeq":"1","dJobNm":"아연말제조원","workSum":"아연용탕에 함유된 부산물 중에서 불순물을 제거하고 아연분말을 제조한다.","doWork":"공기압축기, 유동컨베이어, 분리기 등을 가동한다. 보온로에 있는 아연용탕을 출탕하여 분사실로 보낸다. 압축공기 밸브를 조절하고, 압축공기를 분사실에 공급하여 용탕을 냉각한다. 냉각된 아연말을 컨베이어로 운반하고 일정 크기로 분류하여 분리기에 투입한다. 분사실의 분사상태와 분리기 작동상태를 육안으로 관찰한다. 분리된 아연말을 저장호퍼에 저장한다. 아연말 생산량을 기록한다. 분사실에서 발생된 분사진을 수집하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C242","dJobICdNm":"[C242]1차 비철금속 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006194:1', '{"dJobCd":"K000006194","dJobCdSeq":"1","dJobNm":"아연용해반장","workSum":"아연정광을 직접 침출하거나 아연소광을 용해하기 위하여 중성용해, 고온고산용해, 침철석(Goethite)용해, 벨트컨베이어 등을 조작하는 작업원의 활동을 감독·조정한다.","doWork":"아연정광을 직접 침출하거나 아연소광을 용해하는 조건 및 상황을 파악하여 작업계획을 수립한다. 작업원에게 작업을 지시하거나 함께 작업하며 이행 여부를 확인한다. 안전교육 및 제반 기술교육을 실시한다. 조정실의 계기를 관찰하여 온도, 산도, 압력 등을 점검한다. 슬러리(Slurry)농도와 양, 농축기의 공조(空槽)상태를 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C242","dJobICdNm":"[C242]1차 비철금속 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005754:1', '{"dJobCd":"K000005754","dJobCdSeq":"1","dJobNm":"아연용해원","workSum":"아연정광과 소광을 용해하는 용해설비의 각종 계기를 조작하거나 농축기에서 나온 슬러리에서 아연을 회수하는 탱크를 조작한다.","doWork":"아연용해반장의 지시나 작업지시서에 따라 작업진행계획을 수립한다. 용해조 및 관련 설비의 이상 유무를 확인한다. 조정실계기를 조절하여 온도, 압력, pH 등을 작업표준에 맞도록 조정한다. 용해조에 투입되는 소광 및 정광의 양을 확인하고 투입량을 조절한다. 벨트컨베이어의 아연 여과상태를 점검한다. 용해조 내의 공조상태를 파악하고 누액발생 시 회수한다. 산 사용량 및 재고량을 파악한다. 조정반 계기를 판독하여 온도, 압력, 산농도, 여과상태, 누액발생 등을 작업일지에 기록한다. 펌프를 가동시켜 농축기에 배출된 슬러지를 고온고산 용해조에 장입한다. 시료의 산도분석 결과에 따라 규정량의 황산을 주입하고 교반기로 혼합한다. 증기밸브를 열어 용해조의 온도를 조절한다. 용해된 액을 농축기로 이송하여 슬러지를 침전한다. 열교환기를 통해 농축기 비등액의 온도를 높여 슬러지를 배출한다. 침강제를 첨가하여 슬러지 침전을 강화하며 농축기 내의 슬러지 배출량을 조절하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"아연용해제어실운전원","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C242","dJobICdNm":"[C242]1차 비철금속 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006874:1', '{"dJobCd":"K000006874","dJobCdSeq":"1","dJobNm":"아연정액반장","workSum":"아연황산용액에서 불순물을 제거해 주기 위하여 부원료조제, 탱크관리, 여과압착기조작, 탈수 등의 작업에 종사하는 작업원의 활동을 감독·조정한다.","doWork":"작업지시서에 따라 작업계획을 수립하여 작업원을 배치하고 작업 이행 여부를 확인하는 등 관리한다. 작업장을 순회하며 안전교육 및 제반 기술교육을 실시한다. 정액공정에 따른 반응탱크, 펌프, 냉각탑 등 시설 장치를 관리하고 고장 발생 시 정비부서와 협조하여 정비한다. 정액량, 시험결과, 부원료 사용량 등 작업내용을 작업일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|고온|다습|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C242","dJobICdNm":"[C242]1차 비철금속 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001368:1', '{"dJobCd":"K000001368","dJobCdSeq":"1","dJobNm":"아연정액원","workSum":"전해공정의 전류효율을 높이고 고순도의 아연괴를 생산하기 위하여 각종 설비를 조작한다.","doWork":"펌프를 가동시켜 저장탱크에 정액탱크로 아연용액을 공급한다. 모터를 시동하여 교반기를 회전시키고 불순물을 침전시키는 화학약품을 작업표준에 따라 일정량을 탱크에 투입한다. 조액(용해)공정과 전해공정의 조업상태를 확인하고 중성액, 미액, 신액, 공조 등을 파악한다. 전해액의 농도 및 전해액량, 신액량을 맞추고 냉각탑 등 부대설비를 가동하여 용액의 온도를 유지한다. 정액상태를 육안으로 관찰한다. 구리, 카드뮴 등의 비철함량 및 pH를 측정하기 위해 시료를 채취하고 실험실에 검사를 의뢰한다. 펌프, 교반기, 냉각탑 등의 설비를 관리·점검한다. 용액온도, 용액량, 시료분석결과 등을 조업일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"다습|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"리펄퍼(Repulper)원","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C242","dJobICdNm":"[C242]1차 비철금속 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006475:1', '{"dJobCd":"K000006475","dJobCdSeq":"1","dJobNm":"아연제련원","workSum":"아연광으로부터 아연을 추출하기 위하여 광석을 배소하고 건식 및 습식처리하여 순도가 높은 아연을 제조한다.","doWork":"아연광석인 황화아연(ZnS)을 900~1,200℃로 가열, 산화아연(ZnO)로 변환시킨다. 산화아연은 침출조에서 황산과 반응시켜 황산아연용액을 형성시키고 염화암모늄과 혼합하여 황산아연을 침출시킨다. 제조된 황산아연 용액을 중화시키고 여과하여 불순물을 제거한다. 정제된 황산아연 용액은 전해조로 이송하고 통전시켜 음극에서 아연금속을 정출시킨다. 음극에 침전된 아연금속을 용해하여 잉곳으로 제조한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|고온|다습|","workFunc1":"계산","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C242","dJobICdNm":"[C242]1차 비철금속 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001500:1', '{"dJobCd":"K000001500","dJobCdSeq":"1","dJobNm":"용강조정원","workSum":"전로에서 출강된 용강상태를 확인하고 강종의 특성에 따라 2차 정련설비를 조작하여 불순물제거, 탈가스작업, 성분조정 등 최적의 용강상태로 조정·제어한다.","doWork":"2차 정련 설비(RH 또는 LF)를 이용하여 전로 또는 전기로에서 출강된 용강의 온도 및 합금성분 조정, 탈가스, 탈산, 개재물 형상제어, 탈인, 탈황 등을 수행하기 위하여 제반 원료와 설비의 이상유무를 점검하고 작업지시서를 숙지한다. 진공정련로(RH)의 운전으로 레이들내 용강을 진공처리하고 강제 순환시켜 용강내 불순물과 가스를 제거하고 합금철 및 부원료 투입으로 목표 온도와 조성으로 제어한다. 래들퍼니스(Ladle Furnace, 이하 LF) 작업의 경우 용강의 온도에 따라 전기 아크열을 이용하여 승온하거나, 강의 버블링 작업이나 냉각제 투입으로 용강으 온도를 조정한다. 용강과 슬래그의 탈산 정도를 확인하여 탈산제를 투입하고 용강의 성분 목표에 적중하도록 합금철 투입량을 계산하여 투입한다. 작업 일지를 작성하고 결과를 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"보통 작업","workPlace":"실내","workEnv":"고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"2차정련원","certLic":"제강기능사, 제강기능장","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002395:1', '{"dJobCd":"K000002395","dJobCdSeq":"1","dJobNm":"용선예비처리직","workSum":"고로에서 출선된 용선중에 함유되어 있는 규소, 인, 황 등의 불순물을 제거하여 전로제강에서 필요한 적정성분의 용선을 제조한다.","doWork":"고로에서 생산된 용선을 토페도카로 출선하여 전로에 장입하기 전 용선의 성분 및 온도 등의 특성과 해당강종의 규제사항을 파악한다. 용선을 예비처리하기 위해 반응 효율에 따른 부원료 조정 및 처리순서를 결정하고 탈규소를 위해 용선에 밀스케일 및 기체 산소 등 취입한다. 이후 용선로의 슬래그를 제거한다. 이후 예비처리 반응 효율에 따른 부원료 조정 및 처리순서를 결정하고 탈황 및 탈인을 위한 생석회, 소결광 및 산소의 취입량을 배분하고 용강중에 투입하는데 경우에 따라 기계식교반장치를 사용한다. 슬래그 배재 후 용선표면에 보온제를 투입하며, 용선의 온도 및 성분을 측정하여 관리하고 전로 생산스케줄 및 장입요구조건에 맞추어 전로에 최적의 용선을 공급한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|고온|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","certLic":"주조기능사, 주조산업기사, 주조기능장, 제강기능사, 제강기능장","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002175:1', '{"dJobCd":"K000002175","dJobCdSeq":"1","dJobNm":"용해로조작원","workSum":"금속의 용해 및 주조를 위한 설비의 유지 및 보수 업무를 담당하고, 규격에 맞는 장입재를 용해 후 성분과 온도를 조정 후, 출탕하여 주형에 장입하고 주물을 제조한다.","doWork":"주철 또는 비철금속의 주조를 위한 용해로의 내화물 및 부대설비를 점검한다. 규격에 맞도록 장입물의 배합비를 조정하고, 이를 용해로에 장입 및 용해를 수행한다. 용해 후 성분 및 온도를 조정, 확인하고 출탕한다. 용탕을 주형에 장입하고 최적조건으로 응고시켜 주물을 제조한다. 주조품의 외관, 형상 및 품질을 점검하고 검사보고서를 작성한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"힘든 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"주조기능사, 주조산업기사, 주조기능장","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C242","dJobICdNm":"[C242]1차 비철금속 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006368:1', '{"dJobCd":"K000006368","dJobCdSeq":"1","dJobNm":"용해원부자재관리원","workSum":"철강 및 비철금속을 생산하기 위한 연·원료의 수급, 배합, 불출과 관련 설비 및 장비들의 관리를 통해 후공정에 안정적으로 연·원료를 공급하는 업무를 수행한다.","doWork":"연원료 품종별 사용량을 고려하여 재고관리를 통해 적정 연원료를 상시 확보한다. 안전재고 일수, 환경관리, 기상상태를 고려하여 스테커 및 저장고 설비와 저장된 연원료의 품질을 점검한다. 품질관리 기준에 따라 혼합장치를 이용하여 배합원료를 조립하고, 연원료를 정량절출장치 및 이송장치를 이용하여 후속 공정에 정량 불출한다. 연원료 불출량과 재고량을 작업일지에 기록한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001416:1', '{"dJobCd":"K000001416","dJobCdSeq":"1","dJobNm":"유도로조작원","workSum":"유도가열을 이용하여 금속을 용해 및 정련하고 후공정에 적합한 용탕을 공급하는 업무를 수행한다.","doWork":"작업내용과 유도로 및 관련설비의 이상유무를 점검한다. 장입물 및 조업상황, 주원료의 종류에 따라 장입방법과 위치를 결정하고 원료 배합기준에 따라 장입물을 장입한다. 장입물 조건에 따라 목표 온도를 설정하고 작업지침서에 따라 조작반을 조작하고 장입물 용해를 수행한다. 조건에 따라 부원료를 사용량을 결정하고 투입하면서 용탕을 목표 온도와 성분이 되도록 조정한다. 목표 온도와 성분에 도달하면 용해조업을 중단하고 노내 슬래그를 제거하고 래들에 용탕을 출탕하여 후속 공정으로 이송한다. 설비 및 용탕 조건을 기록한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"용해로조작원","connectJob":"고주파유도로조작원, 저주파유도로조작원","certLic":"주조기능사, 주조산업기사, 주조기능장","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C242","dJobICdNm":"[C242]1차 비철금속 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006131:1', '{"dJobCd":"K000006131","dJobCdSeq":"1","dJobNm":"은용해반장","workSum":"은립(銀粒)을 용해하여 은괴를 제조하는 작업원의 활동을 감독·조정한다.","doWork":"작업계획서를 확인하고 작업에 따른 세부 실행 계획을 수립한다. 은용해를 위한 용해로 및 관련 설비를 점검하고 이상 유무를 확인·점검한다. 작업원을 배치하고 작업을 지시하고 이행 여부를 확인한다. 안전교육 및 직무교육을 통하여 안전재해를 예방하고 직무수행기술을 향상한다. 은 생산량 등의 작업내용을 작업일지에 기록한다. 은제품을 평량하고 포장하는 작업원의 활동을 감독하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|고온|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C242","dJobICdNm":"[C242]1차 비철금속 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003498:1', '{"dJobCd":"K000003498","dJobCdSeq":"1","dJobNm":"은제련원","workSum":"시안화나트륨(NaCN) 등 용매를 사용하여 광석 또는 재활용 원료를 용해한 후, 전해조에서 전기 분해시켜 은을 채취한다.","doWork":"광석을 잘게 분쇄하여 이것을 시안화나트륨이나 시안화칼륨 또는 시안화칼슘 0.1∼0.5%의 수용액에 가하여 공기를 불어넣으면서 교반하여 광석 중의 은을 시아노착염으로 녹여낸다. 이때 생성된 조지금을 양극으로하여 은만을 용해시켜 금을 남기고 음극(陰極)에서는 순은(純銀)을 석출 시킨다. 석출된 은은 도가니 속에서 융해시켜 잉곳으로 만든다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C242","dJobICdNm":"[C242]1차 비철금속 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004442:1', '{"dJobCd":"K000004442","dJobCdSeq":"1","dJobNm":"자로사이트용해원","workSum":"아연용액에서 자로사이트(Jarosite)를 생성하여 철을 제거하는 자로사이트 반응조를 관리한다.","doWork":"반응조에 있는 농축기의 상등액의 온도를 확인·점검한다. 일정량의 소광 및 암모니아 가스를 투입하여 교반기로 반응시킨다. 반응된 액을 농축기에 보내어 찌꺼기를 침전시키고 상등액은 철정액조로 보낸다. 침전물을 벨트여과기로 보내고 찌꺼기 양을 더 많이 만들기 위하여 침강제를 첨가하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"용해로조작원","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C242","dJobICdNm":"[C242]1차 비철금속 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004249:1', '{"dJobCd":"K000004249","dJobCdSeq":"1","dJobNm":"자용로설비원","workSum":"건조된 동정광을 용해하여 매트(Matte)와 슬래그로 분리하는 자용로 및 부대설비를 조작하고 관리한다.","doWork":"작업지시서나 자용로반장의 지시에 따라 일일작업계획 및 생산량을 확인한다. 자용로 및 부대설비의 이상 유무를 점검한다. 건조로에서 건조된 정광을 받아 자용로에 투입하고 공기량, 산소량 등을 조절하여 반응하도록 한다. 반응로에서 생성된 매트와 슬래그의 상태를 관찰·확인한다. 연소가스, 분진, 가스열을 회수하기 위하여 가스배출기, 전기집진기, 폐열보일러 등을 작동한다. 순환수온도, 증기량, pH 등을 조정한다. 생산량 및 작업내용을 작업일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"고온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"자용로조작원","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C242","dJobICdNm":"[C242]1차 비철금속 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005443:1', '{"dJobCd":"K000005443","dJobCdSeq":"1","dJobNm":"자용로출탕원","workSum":"자용로에서 용해된 매트를 출탕하기 위한 각종 설비 및 부속설비를 관리하고 조작한다.","doWork":"작업지시서 및 자용로조작원의 지시에 따라 오일버너, 탕도, 가스흡입설비 등 출탕 관련 설비를 점검·관리한다. 출탕시간 등의 작업내용이 기록된 작업지시서를 받고 출탕순서에 따라 용탕레벨(용탕량)을 측정하고 조업 사이클을 파악한다. 자용로에서 매트를 출탕하고 작업이 완료되면 탕도를 청소하고 정비한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"고온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"유지","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C242","dJobICdNm":"[C242]1차 비철금속 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004340:1', '{"dJobCd":"K000004340","dJobCdSeq":"1","dJobNm":"재가열로운전원","workSum":"연속주조에서 생산된 소재(슬라브, 블룸 빌릿 등)의 열간압연을 위하여 가열로내 소재의 가열, 균열 및 추출한다.","doWork":"작업지시서에 따라 후속공정인 압연의 순서를 고려하여 소재의 장입순서를 결정한다. 대차를 이용하여 소재를 장입하고 문을 닫는다. 작업지시에 따라 온도조절 및 시간 등 가열로의 계기판을 조작한다. 소재의 두께, 형상, 강종에 따른 예열대, 가열대 및 균열대의 가열시간과 온도를 설정한다. 가열로 내부의 오일버너를 점화하고 오일과 공기량을 조절한다. 대(Zone)별 온도, 가열시간, 연소조건을 관리하면서, 가열로의 이상발생시 조치작업을 한다. 소재의 추출 피치(Pitch)를 관리하면서 재로시간을 제어한다. 이후 롤 단위편성에 따라 가열된 소재를 추출하고, 후속 공정이 이루어지도록 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|고온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"제강기능사, 전기기능사, 주조기능사, 제강기능장, 가스기능사, 용접기능사, 금속재료기능사","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002312:1', '{"dJobCd":"K000002312","dJobCdSeq":"1","dJobNm":"전기로반장","workSum":"자용로 및 전기로에서 운반된 매트(Matte)를 정제하기 위하여 전로를 조작하는 작업원의 활동을 감독·조정한다.","doWork":"작업원에게 안전교육 및 제반 기술교육을 실시한다. 자용로 및 전기로로부터 레이들(Ladle)에 반입된 용탕상태의 매트를 전로장 입구에 장입할 시간, 조업상태, 종말점 판단 등을 지시하고 작업이행 여부를 확인한다. 설비의 정상가동 여부를 점검한다. 작업내용을 작업일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"고온|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C242","dJobICdNm":"[C242]1차 비철금속 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003298:1', '{"dJobCd":"K000003298","dJobCdSeq":"1","dJobNm":"전기로용해반장","workSum":"강재를 생산하기 위해 고철 및 부재료를 전기로에 장입하여 용강 상태로 용해시키는데 종사하는 작업원의 활동을 감독·조정 한다.","doWork":"용해작업 계획을 검토하고 고철이나 부재료의 재고 현황을 파악한다. 용해작업에 필요한 원료의 장입 절차 및 방법 등을 작업원에게 지시하고 작업진행을 감독·조정한다. 전력, 산소와 가탄재 등 부원료, 출강량 등 조업지표를 관리하며, 용해 공정 전반을 관리하고 감독한다. 설비의 이상 유무를 파악하고 이상 및 불량개소를 보수·정비하도록 의뢰한다. 작업원에게 직무교육 및 안전위생교육을 실시하여 직무수행능력을 향상시키고 안전재해의 예방활동을 한다. 작업내용을 일지에 기록하여 유지·관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"고온|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","certLic":"제강기능사, 재강기능장","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006441:1', '{"dJobCd":"K000006441","dJobCdSeq":"1","dJobNm":"전기로용해보조원","workSum":"전기로용해원(철강제품을 만들기 위해 스크랩을 용해한 용강을 출강하는 작업원)을 보조한다.","doWork":"전기로용해원의 지시를 받아 전기로 설비의 점검을 보조한다. 전기로에서 원재(고철)의 용해를 촉진하는 산소 및 가탄랜스를 준비하고 가동작업을 보조한다. 전기로에서 용강 레이들(Ladle)로 출강될 때 샘플채취기(샘플러)를 용강에 취입해 샘플을 채취하고 샘플 이송장치를 이용하여 성분의 분석을 의뢰한다. 레이들의 이동 등 현장에서 천장기중기의 작업을 유도한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|고온|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"용강정련보조원, 용강조정보조원, 용강주입원, 해정련보조원","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004041:1', '{"dJobCd":"K000004041","dJobCdSeq":"1","dJobNm":"전기로용해원","workSum":"철강제품을 생산하기 위하여 고철 및 부재료가 용해되어 용강상태가 된 이후부터 출강되기까지의 공정에서 전기로를 조작·운영한다.","doWork":"전기로 작동상태 및 이상 유무를 점검하여 노의 작업을 용이하게 한다. 축로 상태 및 전극봉의 단락 여부, 변압설비 등의 상태를 점검한다. 원료를 전기로에 장입한다. 점화기 탭(Tap)으로 전환시킨 후 통전하고, 마스터(전극)을 하강시킨다. 제트버너를 작동시킨 뒤 작업구에 설치된 산소파이프로 산소를 보낸다. 시간의 경과에 따라 탭을 바꾸어 주용해기 상태를 유지한다. 고철의 추가 장입시기를 아크소리와 용해시간 및 전력사용량 등을 감안하여 판정한다. 마스터 및 천정을 상승시켜 추가 장입을 실시한다. 필요에 따라 용해작업 중 전극의 길이를 조정한다. 용해작업 중 고철 상태에 따라 생석회·괴탄을 투입한다. 출강을 위해 예열된 레이들을 준비하고 출강장치를 확인한다. 출강의 온도와 출강의 진정상태를 검사한다. 불활성가스를 레이들에 불어넣어 용강을 교반시킨 뒤 전기로를 경동시켜 서서히 출강한다. 시료를 채취하여 분석을 의뢰한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"용강정련원, 용강조정원, 전해정련원","certLic":"제강기능사, 제강기능장","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003121:1', '{"dJobCd":"K000003121","dJobCdSeq":"1","dJobNm":"전기로전극운전원","workSum":"전극에 필요한 패이스트(Paste) 충전 및 냉각수 온도를 조절하고 유압에 의해 작동되는 전극설비를 운전한다.","doWork":"전극설비운전에 대한 작업표준을 확인하고 설비의 이상 유무를 점검한다. 자용로나 전로에서 유입된 슬래그(Slag)를 재용융하여 매트와 슬래그로 분리하기 위해 유압식 전극을 작동한다. 전기로 상황을 조절하고 소모되는 전극을 보충하기 위하여 페이스트를 충전한다. 전극이 고온에 견딜 수 있도록 냉각수량을 조절하고 전극과 연결된 유압장치를 점검·관리한다. 코크스 등의 환원제를 장입한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"고온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C242","dJobICdNm":"[C242]1차 비철금속 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003207:1', '{"dJobCd":"K000003207","dJobCdSeq":"1","dJobNm":"전기로제강원","workSum":"철 스크랩을 원료로 전기로에서 용해 및 정련과정을 거쳐 불순물을 제거하고, 목적한 온도와 성분으로 조정하여 양질의 용강을 생산한다.","doWork":"작업지시서에 따라 전기로 노체와 부대설비 및 투입원료 및 투입설비를 점검하고, 공정 및 품질을 설계한다. 철 스크랩을 강종 특성에 맞게 등급별로 배합비와 장입량을 결정하여 노 내로 장입한다. 스크랩 용해를 위한 전극을 하강시키고 통전개시 및 용해기 작업을 수행한다. 산소 및 가탄재 취입량을 결정하여 용강중에 투입하고, 불순원소를 제거한다. 슬래그 제제 작업과 목적한 성분 조정을 위해 필요한 부원료와 합급철을 투입한다. 용해와 정련이 완료되면 용강을 래들에 출강하면서 탈산제와 합금철을 투입하여 온도와 성분을 조정한다. 이후 수강대차를 출강 출강대기 위치에 인입시키고 출강구를 개공하여 용강을 래들안으로 출강한다. 슬래그 유출을 최소화하면서 출강완료 후 출강구 주변에 부탁된 지금을 스크레퍼를 운전하여 제거한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|고온|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","certLic":"제강기능사, 전기기능사, 주조기능사, 제강기능장, 가스기능사, 용접기능사","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006277:1', '{"dJobCd":"K000006277","dJobCdSeq":"1","dJobNm":"전로제강원","workSum":"고로에서 생산된 용선 및 스크랩을 원료로 전로에서 용해 및 산소정련을 통해 불순물을 제거하고, 목적한 온도와 성분으로 조정하여 양질의 용강을 생산한다.","doWork":"작업지시서에 따라 전로 노체와 부대설비, 투입원료 및 투입설비를 점검하고, 공정 및 품질을 설계한다. 스크랩 및 용선의 사용비를 결정하고 안전하게 전로에 장입한다. 출강 스케줄을 확인하여 산소 취련을 개시하고 랜스 높이와 산소유량을 취련패턴에 따라 조정한다. 종점 온도를 파악하고 재취련 여부를 결정한다. 이후 취련을 완료한 용강을 출강구를 통해 출강래들로 수강하며, 합금철 투입, 다트 투입 작업 후에 수강대차를 출강 출강대기 위치에 인입시킨다. 출강 후 수강대차 위치와 전로 경동 각도를 조정하여 후속 공정을 준비한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|고온|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"수동조작","certLic":"제강기능사, 전기기능사, 주조기능사, 제강기능장, 가스기능사, 용접기능사","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003450:1', '{"dJobCd":"K000003450","dJobCdSeq":"1","dJobNm":"전해설비정비원","workSum":"전해공장의 전해설비 및 관련 설비를 점검하고 수리·보수한다.","doWork":"공장을 주기적으로 순회하며 전해조, 냉각탑, 배수관 등의 시설물을 점검하고 이상발생 시 자체 보수하거나 수리를 의뢰한다. 천공기를 사용하여 전로에 구멍을 뚫고 압력과 풍량을 조절한다. 수동펀치봉을 사용하여 요동 시료를 채취하고 시료의 색을 육안으로 검사한다. 송풍구의 막힘을 관찰한다. 점검에 따른 작업내용을 작업일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"다습|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"기계정비기능사, 기계정비산업기사","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C242","dJobICdNm":"[C242]1차 비철금속 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004089:1', '{"dJobCd":"K000004089","dJobCdSeq":"1","dJobNm":"전해액관리원","workSum":"생산되는 전기동의 품질을 향상하기 위하여 전해액관리, 전해실험, 저동 및 종판 규격 측정, 전기동 시료채취 등의 작업을 수행한다.","doWork":"작업표준을 확인하고 전해액의 농도를 분석한다. 전해작업을 위한 적당한 농도를 유지하기 위한 액을 관리한다. 전해액의 유량 및 순환액의 유속을 측정한다. 실험 전해조 운영 및 첨가제 실험을 위한 과전위 측정, 양극전물침강 실험을 한다. 조동 및 종판의 규격을 재고 작업표준과 비교한다. 전기동 시료를 채취하여 품질을 검사한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"전해액시험원","certLic":"화학분석기능사","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C242","dJobICdNm":"[C242]1차 비철금속 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003155:1', '{"dJobCd":"K000003155","dJobCdSeq":"1","dJobNm":"전해액농축원","workSum":"비소제거 효율을 높이고 니켈을 침전하기 위하여 탈동 전해 후 액을 농축하는 농축기와 조황산니켈과 조황산을 분리하는 원심분리기를 조작한다.","doWork":"급액펌프를 가동하고 급액밸브를 열어 탈동전해된 전해액을 농축기에 급액한다. 전해액 순환펌프를 가동하여 액을 증발실 및 열교환기에 순환시킨다. 전송펌프를 가동하여 증발실에 진공을 유지한다. 증기밸브를 열어 열교환기에 증기를 공급하여 비등점까지 액의 온도를 상승시킨다. 농축액의 농도를 조절하기 위하여 황산칼슘을 교반조에 첨가하고 침강제를 침강조에 공급한다. 농축기제어반을 수동 조작하여 기준온도 및 진공도가 유지되도록 조정하고 자동으로 전환한다. 일정 농도까지 도달되면 배출펌프를 작동시켜 농축액을 연속적으로 배출한다. 여과기에서 진공으로 농축액을 여과시킨 후 2차 농축을 한다. 증기압력, 진공도, 증발실온도, 배출속도 등을 조정하고 기록·유지한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|고온|다습|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"농축기조작원, 정액원","connectJob":"조황산니켈분리원","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C242","dJobICdNm":"[C242]1차 비철금속 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003345:1', '{"dJobCd":"K000003345","dJobCdSeq":"1","dJobNm":"전해액순환원","workSum":"전해조 내에서 전기분해시켜 동이나 아연 등을 종판에 전착시키기 위하여 정류기 운전, 전해액 농도 및 온도 조절, 전해액 순환량 조정, 첨가제공급, 냉각탑조작 등의 작업을 수행한다.","doWork":"전해정류기의 스위치를 넣고 전류, 전압, 온도를 작업표준에 맞춘다. 전해액의 샘플을 채취하여 농도를 분석하고 농도를 조절하기 위하여 아연신액 사용량을 조절한다. 전해조 내의 전해액순환장치를 조작하여 전해액을 순환시킨다. 전해조 내의 전해액량을 적정 유지한다. 전해액 온도 조절을 위한 냉각탑을 조작한다. 전해조 보수 시 각 전해조를 통전·단전시키며 시간을 기록한다. 증기, 전력, 물 등의 사용량을 기록·유지한다. 전해실 내의 각 시설의 이상 유무를 점검한다. 전해조와 각 배관의 누액상태를 조사한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"다습|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C242","dJobICdNm":"[C242]1차 비철금속 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003286:1', '{"dJobCd":"K000003286","dJobCdSeq":"1","dJobNm":"전해원","workSum":"조동을 사용하여 전기동을 생산하는 전해조를 관리한다.","doWork":"작업명세서에 따라 전해액을 공급하면서 전해액 농도를 맞춘다. 조동이 전기분해되어 전기동(양극)에 흡착되는지를 전해조 위를 순회하면서 육안으로 확인한다. 전기동에 흡착이 잘못된 것은 수동공구를 사용해서 제거한다. 명시된 작업시간에 도달하면 전기동을 육안으로 검사하고, 이상이 없는 것은 호이스트를 사용하여 전해조에서 세척조로 장입하여 세척한다. 전류의 흐름을 수시로 점검하거나 전해조 내에 침전된 비철금속 불순물을 청소하기도 한다. 접착성 물질을 첨가하여 전기분해를 촉진하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|저온|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C242","dJobICdNm":"[C242]1차 비철금속 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004600:1', '{"dJobCd":"K000004600","dJobCdSeq":"1","dJobNm":"전해조청소원","workSum":"조동을 사용하여 전기동을 생산하는 전해조를 청소한다.","doWork":"비철금속 전해조에 전물(Slime:전해조 내에 침전된 비철금속 불순물)이 발생했는지 확인한다. 극판 청소기나 진공펌프를 준비하고 작동을 확인한다. 전해조 내의 전해액을 배출하고 청소기를 사용하여 극판과 바닥을 청소한다. 육안으로 청소상태를 점검한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"시범후 30일 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","similarNm":"세조원","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C242","dJobICdNm":"[C242]1차 비철금속 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003625:1', '{"dJobCd":"K000003625","dJobCdSeq":"1","dJobNm":"제강설비정비원","workSum":"전로 또는 전기로의 원활한 작업으로 양질의 용강 생산을 위한 노체와, 부대설비 등 제강에 필요한 설비를 점검 및 보수하여, 원활한 제강 업무가 진행토록 한다.","doWork":"제강을 위한 전기로 또는 전로의 노체 및 내화물 현황을 파악하여 효율적으로 보수하고, 내화물 침식을 최소화하기 위한 노체 상황을 최상으로 유지한다. 또한 제강을 위한 집진기, 수처리 설비, 가스공급장치 및 유틸리티 설비의 이상유무를 파악하고, 보수하여 이를 기록한다. 제강 과정 중 장비 이상이 발생시 응급조치 및 정상가동을 위한 설비 점검 및 보수를 진행한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"전로정비원, 전기로정비원","certLic":"제강기능사, 전기기능사, 기계정비기능사, 기계정비산업기사, 주조기능사, 제강기능장, 가스기능사, 용접기능사","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006745:1', '{"dJobCd":"K000006745","dJobCdSeq":"1","dJobNm":"제련반장","workSum":"동, 아연 등의 비철금속을 생산하기 위하여 원료를 장입하고 자용로·전기로·전로·정제로·용해로·전해 등의 작업에 종사하는 작업원의 활동을 감독·지휘한다.","doWork":"생산계획에 따른 세부 실행계획을 수립하고 생산계획 지침에 따라 지시사항을 작업원에게 전달하고 조업상에 발생하는 문제들을 해결한다. 각종 원료, 자재 등을 구입하는 제반 문제를 해결한다. 각종 설비를 점검하고 이상 시 보수하도록 지시한다. 작업원에게 안전교육 및 직무교육을 실시하여 재해를 예방하고 직무수행능력을 향상한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"고온|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"제련직장","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C242","dJobICdNm":"[C242]1차 비철금속 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001814:1', '{"dJobCd":"K000001814","dJobCdSeq":"1","dJobNm":"조괴원","workSum":"2차정련한 용강을 주형에 주입하고 응고된 강괴를 인발하여 소형 및 대형 강괴(Ingot)를 제조한다.","doWork":"작업지시서를 숙지하고 주형 및 정반을 청소하고 예열·정치하여 주입작업을 준비한다. 주형내 용강 주입시 소요되는 산소, 아르곤, 공기 등 가스류의 공급상태와 설비를 점검하고, 발열제, 표면미려제, 보온제, 압탕보온판 등 각종 부자재를 준비한다. 기중기, 와이어로프, 노즐 개공용 파이프, 잔탕박스, 강괴 인발기, 대차, 슬래그포트 등 각종 사용설비 및 공구의 준비사항을 점검한다. 주괴 대상의 용강품질과 응고특성을 숙지하고, 주형을 예열한다. 강종 및 주입조건에 따라 주입속도를 조정하며 용강이 재산화되지 않도록 한다. 주형내 용강 상태와 탕면변동 여부를 확인하고, 이들 발생시 응급조치를 시행한다. 용강의 응고상태를 확인한 후 크레인 및 인발기를 활용하여 강괴를 인발한다. 인발된 강괴를 이동용 대차에 상차하고 작업일지를 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"진공조괴원","certLic":"제강기능사, 제강기능장","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006232:1', '{"dJobCd":"K000006232","dJobCdSeq":"1","dJobNm":"조액분석원","workSum":"아연광을 배소한 배소광을 황산 용액으로 침출시켜 불순물들을 철산화물 잔사와 함께 공침시켜 분리, 제거하며 얻은 조액을 기기를 통해 분석한다.","doWork":"아연광의 습식제련공정에 생성된 조액의 성분검사를 위한 시험요구조건에 따라 주위 온도와 습도를 설정한다. 시험작업 표준에 따라 표준시료 또는 시편을 사용하여 측정값의 유효성을 확인한다. 용액에서 용액에서 일정량의 시료를 채취하고 조건에 맞도록 희석시킨다. 분석기기를 이용하여 시료를 분석하고 용액 중의 철·황산·철의 함유량, pH 등을 검사한다. 정액공정의 각 정액탱크에서 시료를 채취하여 니켈, 카드뮴, 코발트 등의 불순물 함량을 분석한다. 시험결과를 해석하고 성적서를 작성한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|다습|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"화학분석기능사","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C242","dJobICdNm":"[C242]1차 비철금속 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003142:1', '{"dJobCd":"K000003142","dJobCdSeq":"1","dJobNm":"종판제작원","workSum":"전해 정련용 음극으로 사용되는 금속박판을 만들기 위하여 종판제작기를 조작한다.","doWork":"종판제작용 전해조에서 모판을 탈조하여 박리하고 종판제작용과 리본용 종판제작용을 분리한다. 스위치를 넣어 종판제작기를 시동하고 유압오일의 온도를 조정한다. 종판을 종판제작기에 장입하여 절단한다. 기계를 조작하여 종판에 정방형 무늬를 넣어 종판의 뒤틀림을 방지한다. 절단된 종판에 환고리와 현수대를 부착한다. 제작된 종판을 종판보관대에 적재한다. 불량종판을 재사용하기 위해 수동공구를 사용하여 수리하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"종판가공원","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C242","dJobICdNm":"[C242]1차 비철금속 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003097:1', '{"dJobCd":"K000003097","dJobCdSeq":"1","dJobNm":"종판탈취원","workSum":"전기분해에 의해 모판에 형성된 전기동판을 떼어낸다.","doWork":"전기분해에 의해 모판에 형성된 전기동판을 탈취대에 놓는다. 종판 탈취용 칼이나 막대를 사용하여 모판 양쪽에 형성된 종판을 떼어낸다. 떼어낸 전기동판을 일정 수량씩 적재한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"고온|다습|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","similarNm":"종판박리원","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C242","dJobICdNm":"[C242]1차 비철금속 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002554:1', '{"dJobCd":"K000002554","dJobCdSeq":"1","dJobNm":"주철관제조반장","workSum":"주철강관을 제조하기 위하여 원재료와 부재료를 용해하여 관을 주조·가공하는 작업원의 활동을 감독·조정한다.","doWork":"생산계획에 따라 설비, 원료, 인원 등을 고려하여 세부실행계획을 수립한다. 작업내용을 작업원에게 지시하고 함께 작업하며 이행 여부를 확인한다. 용해된 주철의 성분확인 및 관의 원심주조상태 등을 확인한다. 작업장의 안전상황을 점검하고 작업원에게 제반 기술을 교육하고 안전교육을 실시한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"감독","workFunc3":"제어조작","certLic":"주조기능사, 주조산업기사, 주조기능장","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001769:1', '{"dJobCd":"K000001769","dJobCdSeq":"1","dJobNm":"중성용해원","workSum":"전해공정에서 사용된 황산용액에 일정량의 아연소광을 첨가하여 반응시키는 탱크를 조작한다.","doWork":"중성용해조에 투입된 전해액의 성분 및 양을 확인한다. 추출기의 스위치를 조절하여 일정량의 아연소광을 용해조에 공급한다. pH지를 사용하여 중성용해조 내의 pH를 조사하여 작업명세와 일치하는지 점검한다. 사질(Sandy)의 침철석(Goethite)과 용해된 소광을 교반기로 혼합하고 침강제를 첨가하여 침전상태를 조절한다. 철분을 산화하고 산화아연을 용해시키기 위하여 용해조 내에 압축공기를 주입한다. 농축기에서 상등액의 색깔을 육안으로 관찰하고 중성액 저장탱크로 이송하여 침전물은 펌프를 사용하여 운반한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"다습|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"화학분석기능사","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C242","dJobICdNm":"[C242]1차 비철금속 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003644:1', '{"dJobCd":"K000003644","dJobCdSeq":"1","dJobNm":"출선반장","workSum":"출선·출재작업과 이와 관련된 스키머(Skimmer), 탕도부분을 보온·피복하고 스토퍼를 교체하는 작업원을 감독·조정한다.","doWork":"작업계획을 검토하고 세부 추진계획을 수립하여 작업원에게 지시하고 이행 여부를 확인한다. 비정상 시는 적절한 비상조치를 취하고, 상급자에게 보고하며 복구작업을 한다. 담당 설비의 이상 및 불량개소에 대해서 확인하고 시정작업을 한다. 작업원을 수시로 면담하여 애로 및 건의사항을 파악·해결하고 보고한다. 작업원의 직무수행 능력을 향상하고 재해를 예방하기 위해 노무관리교육, 직무교육, 안전위생교육을 실시한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"보통 작업","workPlace":"실내","workEnv":"고온|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","similarNm":"노전반장","certLic":"제선기능사, 제선기능장","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005375:1', '{"dJobCd":"K000005375","dJobCdSeq":"1","dJobNm":"출선원","workSum":"고로 노상(爐床)에 고인 용융물을 원활하게 배출하기 위해 출선·출재작업을 하고 슬래그(Slag)가 분리된 용선을 레이들에 안전하게 유도한다.","doWork":"출선 개공기 및 머드건을 점검·확인하고 머드건에 머드를 충진한다. 용선레이들을 대기시키고 스키머·탕도·출선구를 점검·정리한다. 노황관리원의 연락에 따라 노 내 용융물을 노 외부로 배출하기 위해 통로를 굴착하는 개공기로 출선구를 개공하고 출선상황을 감시한다. 비상시에 산소 및 머드건으로 개공한다. 작업표준에 의거 시료를 채취한다. 레이들을 감시하고 용선의 주입이 끝나면 스토퍼를 교체하여 용선을 다른 레이들로 유도한다. 출선 시 용선 보온 등을 위하여 보온재를 덮어주며 출선 종료시간과 출산량 및 레이들 수를 파악하여 노황관리원에게 연락한다. 출재 도구 및 공구를 준비하고 재구 및 재통을 정리한 후 재구를 개폐하여 출재작업을 행한다. 출선구·스키머·노체를 점검·보수하고 정기수리 시 정비부서를 지원한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|고온|소음·진동|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"노전원","certLic":"제선기능사, 제선기능장","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005677:1', '{"dJobCd":"K000005677","dJobCdSeq":"1","dJobNm":"취련사","workSum":"용선(용광로 조업) 또는 용융 고철(전기로 조업)의 불순물을 제거하고, 목적한 합금원소를 첨가하여 강을 제조하고자 산소 취입, 주·부원료의 장입량 계산 및 투입, 온도, 성분 조정, 출강 등 후공정에서 요구하는 품질의 용강을 제조한다.","doWork":"제강로(전로 또는 전기로) 및 부대설비의 이상유무를 확인하고, 작업표준서에 따른 작업내용을 숙지한다. 노에 원료 투입량과 열배합 계산을 토대로 냉각제 및 산소량을 계산하고 메인랜스(Main Lance: 전로 또는 전기로에 순산소를 취입하는 설비)를 통해 산소를 취입하여 불순물을 산화시켜 제거한다. 주·부원료의 투입과 조정으로 목적한 합금조성의 강을 제조한다.\n서브랜스(Sub Lance)를 통해 용강의 온도를 측정하고 성분 분석용 시편을 채취하며 측정된 결과를 기록한다. 취련작업 중 발생한 이상 상황을 긴급 조치하고, 이를 신속히 보고하며, 작업내용을 작업일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"고온|소음·진동|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"취련원, 정련원","certLic":"제강기능사, 제강기능장","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005347:1', '{"dJobCd":"K000005347","dJobCdSeq":"1","dJobNm":"코크스가스정제원","workSum":"코크스로에서 석탄건류 시 발생한 가스를 정제하기 위한 관련 설비를 운전한다.","doWork":"냉각장치를 운전하여 코크스로에서 방생한 가스를 흡입하여 타르(Tar)를 회수한다. 타르의 불출량, 온도, 압력, 가스 발생량, 수분 등의 평균치를 계산하고 기록한다. 코크스가스를 암모니아포집탑(Ammonia Washer)에 투입하여 암모니아를 포집하고 경유를 축출한다. 포화기를 운전하여 가스 중에 포함된 암모니아와 황산을 함유한 용액과 반응시켜 반죽 상태의 유안(Ammonium Sulfate:황산암모늄)으로 만든다. 건조설비 및 원심분리기를 작동하여 수분이 제거된 유안을 생산한다. 각 계기를 감시하여 유량, 압력, 온도 등을 확인·기록하며 작업표준에 따라 일상점검과 간단한 보수 및 교체 작업 등을 수행한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|고온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C191","dJobICdNm":"[C191]코크스 및 연탄 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004180:1', '{"dJobCd":"K000004180","dJobCdSeq":"1","dJobNm":"탄소나노튜브합성로조작원","workSum":"탄소나노튜브(Carbon Nanotube)를 제조하기 위해 탄소나노튜브합성로(가열로)를 조작·운전한다.","doWork":"합성로(가열로)에 공급할 반응가스의 유량을 제어·조작한다. 합성로 내부의 온도와 압력을 조절하여 증식 분위기를 조성한다. 분위기가 조성된 합성로의 반응판(포트)에 촉매를 공급하며 반응판 위에 탄소나노튜브를 증식한다. 증식이 끝난 합성로를 완전히 발열시킨 후 반응판을 꺼내 분쇄공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C239","dJobICdNm":"[C239]기타 비금속 광물제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005797:1', '{"dJobCd":"K000005797","dJobCdSeq":"1","dJobNm":"탈동탈비원","workSum":"전해액 중 농축되어 있는 비소를 제거하기 위하여 납 양극과 종판을 전해조에 장입하여 전기 분해한다.","doWork":"전류, 전압, 온도 등을 측정하고 조절한다. 기중기를 이용하여 납 양극과 종판을 탈동탈비 소조에 장입한다. 탈동탈비 소조의 정류기를 운전하고 전해액 공급량을 조절한다. 전해상태를 육안으로 검사한다. 기중기로 전착된 음극을 세척조에 인양하여 세척하고 무게를 단 후 전로로 인계한다. 전해조의 전해액과 전물(Slime)을 침전조로 배출한다. 전력사용량과 조전압을 기록·유지한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"다습|","workFunc1":"관련없음","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"탈동탈비전해원","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C242","dJobICdNm":"[C242]1차 비철금속 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002149:1', '{"dJobCd":"K000002149","dJobCdSeq":"1","dJobNm":"회전건조로조작원","workSum":"동정광을 조합, 건조하는 건조로 및 부속설비를 조작한다.","doWork":"생산계획에 따라 동정광, 규사 등 광석을 조합하기 위하여 기계를 조작한다. 원료운반 상황을 파악하고 필요시 진행상황을 작업계획에 따라 조정한다. 원료의 수분을 건조하기 위하여 건조설비의 회전속도, 온도 등을 작업표준에 따라 조작한다. 전기집진기, 세척탑 등의 부속설비를 조작한다. 작업내용 및 특이사항 등을 작업일지에 기록하고 다음 근무자에게 전달한다. 각종 설비를 점검하고 이상을 발견하면 반장에게 보고하고, 기계·전기 담당 인원에게 연락하여 수리 및 보수를 받는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8211","dJobECdNm":"[8211]금속가공 제어장치 조작원","dJobJCd":"8414","dJobJCdNm":"[8414]금속가공 관련 제어 장치 조작원","dJobICd":"C242","dJobICdNm":"[C242]1차 비철금속 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005712:1', '{"dJobCd":"K000005712","dJobCdSeq":"1","dJobNm":"강관교정원","workSum":"관의 직진도 및 진원도(眞圓度, Out of Roundness)를 교정하기 위하여 자동 혹은 수동 교정기를 조작한다.","doWork":"관의 규격에 따라 교정롤을 설치·조정한다. 절단되어 나오는 관을 유도장치로 조작하여 교정롤 사이로 하나씩 투입한다. 교정되어 나온 관을 다음 공정으로 이송하기 위해 묶거나 이송대 위에 올려놓는다. 교정기의 롤 및 제반 기기를 점검·손질하고 주변을 정돈한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"교정기조작원","certLic":"압연기능사, 압연기능장","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004783:1', '{"dJobCd":"K000004783","dJobCdSeq":"1","dJobNm":"강관면취기조작원","workSum":"강관이나 판재의 후속가공 및 취급을 용이하도록 모서리나 끝단부를 비스듬하게 깎아내고 다듬질하는 작업을 수행한다.","doWork":"작업 대상 제품의 면취 방법 및 절차와 작업공구를 점검한다. 작업 대상 제품을 대기 작업대에서 이동시켜 작업전 단계로 정렬시킨다. 가공 축에 강관 또는 판재의 끝을 면취기 면판과 일치시키고 제품을 정위치 시킨다. 면취바이트 및 절단기의 절단 각도를 조정하고 면취기를 작동시켜 제품 선,후단부 면취를 진행한다. 면취 작업 후 가공면을 계측기 도는 육안으로 검사한다. 가공 제품을 관리하면서 후속 공정으로 이송하고 작업 일지를 작성한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"면취원, 모따기작업원","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004760:1', '{"dJobCd":"K000004760","dJobCdSeq":"1","dJobNm":"강관압출기조작원","workSum":"이음매 없는 관이나 환봉을 생산하기 위하여 가열된 강편(Billet) 소재에 압력을 주어 가공하는 강관압출기를 조작한다.","doWork":"압출기의 각종 계기를 점검하고, 강 종류 및 구경에 따라 작업표준에 맞게 가열로를 조작한다. 강 종류 및 구경에 따라 다이 및 기타 도구를 준비한다. 강편(Billet)을 가열로에서 가열하여 필요에 따라 확공작업을 실시한다. 가열 후 산화철을 제거한다. 강편 내·외면에 윤활제를 도포하여 컨테이너 속으로 장입되도록 기계를 조작한다. 램(Ram)을 조작하여 금형을 통해 압출한다. 압출된 제품을 육안으로 검사하고, 시료를 채취하여 규격에 맞게 압출되었는지 확인한다. 압출된 제품을 공기 중에 냉각한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"압연기능사, 압연기능장","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004719:1', '{"dJobCd":"K000004719","dJobCdSeq":"1","dJobNm":"강편압연원","workSum":"용강을 주조하여 제조한 잉곳(Ingot)을 압연하여 내부 수축관, 기포 등의 결함을 최소화하고,  판, 봉, 선, 형강 등의 형상으로 가공하기 적합한 소형괴로 압연하는 업무를 수행한다.","doWork":"작업지시서와 강종 특성을 숙지하고, 압연기 및 부속설비의 이상유무를 점검한다. 소재를 압연기에 치입(Biting)하고 롤갭(Roll Gap), 압연속도 및 스킨패스를 조정하여 목적한 형상의 제품으로 압연한다. 압연되어 나온 소재(슬라브, 블룸, 빌릿 등) 단면을 게이지를 이용하여 측정하고 압하율을 교정하며 작업일지를 작성한다. 압연 후 제품의 형상 및 표면품질 점검과 롤의 마모 및 균열(Crack) 상태를 점검하여 교체 여부를 판정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"분괴압연원, 강편압연원","certLic":"압연기능사, 압연기능장","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002611:1', '{"dJobCd":"K000002611","dJobCdSeq":"1","dJobNm":"고주파열처리원","workSum":"강(鋼)의 기계적 성질을 향상·개선하기 위하여 금속의 표층부에 유도전류를 가하여 가공품 표면에 국부적인 열을 발생시키는 고주파 증폭장치를 조작하여 열처리작업을 한다.","doWork":"제품주문서 및 작업지시서에 따라 담금질 작업공정을 계획한다. 단조, 주조의 소재는 담금질이나 뜨임 전에 전처리로써 불림이나 풀림을 한다. 금속의 형상 및 종류에 따라 유도코일을 준비하여 고주파 증폭장치에 설치한다. 고주파 열처리설비의 규정된 출력전압, 승강장치의 속도, 회전 상태 등을 확인한다. 설치된 유도코일 내에 피가열 금속을 장입하여 코일간격을 맞추고 전원을 넣어 가열하며 규정된 출력전압이 유지되도록 조정하고 승강장치 및 회전 장치를 가동해 특정 부위를 가열한다. 냉각장치를 가동시켜 유도코일과 피가열금속을 일정 온도로 유지한다. 냉각수 밸브를 작동시켜 가열된 금속을 냉각한다. 냉각이 완료되면 전원 및 냉각수를 차단하고, 승강장치를 작동하여 금속을 유도코일에서 인출하여 작업대 위에 놓는다. 유도코일의 냉각수 및 설비의 전원을 차단하고 고주파 증폭장치에서 유도코일을 분리하여 작업대에 원상태로 놓는다. 부시(Bush) 및 파이프류의 외경고주파 작업 시에는 두께에 따라서 치수 변형향의 차이에 의한 내경공차부에 재가공이 필요하므로 고주파 후에 정삭을 한다. 가열 및 냉각조의 보수작업을 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"유도기조작원","connectJob":"열처리작업원","certLic":"열처리기능사","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004779:1', '{"dJobCd":"K000004779","dJobCdSeq":"1","dJobNm":"권취기조작원","workSum":"사상압연을 거친 금속 박판을 권취기를 이용하여 코일의 형상으로 감는 공정을 수행한다.","doWork":"압연지시 정보상의 소재 두께, 폭, 규격 정보를 확인한다. 사상압연(Finish Mill)된 제품을 권취기로 유도하는 사이드 가이드(Side Guide) 및 핀치롤(Pinch Roll)을 통해 제품 선단을 맨드렐(Mandrel)에 유도함과 동시에 권취 형상 및 소재 폭 가감을 고려하여 적정장력을 부여한다. 권취속도 제어를 통해 권취 형상을 관리하면서 검사장비(SDD) 및 계측기를 활용하여 권취품질을 확인한다. 제품검사 기준에 의거 제품의 합부판정과 검사 보고서를 작성한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"열간압연원, 냉간압연원","certLic":"압연기능사","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005807:1', '{"dJobCd":"K000005807","dJobCdSeq":"1","dJobNm":"금속가열로조작원","workSum":"금속을 열간중에 단조, 압연, 인발, 압출, 프레스 등 성형을 하기 위한 가공을 위한 제품의 장입, 가열로 운전 및 추출 업무를 수행한다.","doWork":"작업지시서를 확인하여 위한 효율적 생산 및 일정 등 생산계획을 파악하고, 금속 가열로 및 부대설비의 이상유무를 점검하여 현황을 기록한다. 소재, 설비, 지그, 작업인원, 가열 방법 등 최적의 생산준비를 한다. 소제를 가열로에 장입하고, 가열로를 조작하여 소재 특성에 맞는 분위기 관리 및 가열 업무를 수행한다. 가열 중 소재 현황 파악과 온도 및 시간 조정을 통해 목적한 가열과 냉각조건에 따라 업무를 수행한다. 가열 및 냉각 이후 소재를 추출하고 후속공정으로 소재를 이송하기위한 추출 작업을 수행한다. 작업일지를 작성하고 장비의 이상유무를 파악한 후 후속 작업을 진행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실외","workEnv":"대기환경미흡|위험내재|고온|다습|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"가열로운전원, 열처리작업원","connectJob":"열처리원","certLic":"열처리기능사, 압연 기능사, 압연 기능장","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004531:1', '{"dJobCd":"K000004531","dJobCdSeq":"1","dJobNm":"금속박판분리원","workSum":"두 장의 금속코일을 동시에 압연하여 생산된 금속박들을 분리하여 각각 권취하고 분단하는 작업을 수행한다.","doWork":"작업지시서의 분리 규격에 의하여 작업내용을 확인하고 분리 및 분단을 위한 관련 설비를 점검한다. 작업에 필요한 코일소재를 언코일러축에 끼워 고정한다. 가이드롤에 금속박을 통과시키고 양호한 권취가 유지되도록 장력을 조정하며 분리 및 분단 작업을 한다. 2개의 권취기를 이용하여 각각의 금속박을 장력조정을 통해 표면품질을 관리하면서 권취하여 제품을 생산한다. 경우에 따라 응력제거 및 탈지를 목적으로 어닐링을 실시한다. 작업이 끝나면 두께와 중량을 측정하고 작업내용을 기록한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"설비운전원","certLic":"압연기능사, 압연기능장","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001877:1', '{"dJobCd":"K000001877","dJobCdSeq":"1","dJobNm":"금속캔재생처리반장","workSum":"금속캔 재생장비의 작동상태를 점검하고 작업량을 산정하여 금속캔재생처리원에게 작업을 분장하고 조정한다.","doWork":"폐 금속캔 회수·처리조직을 통해 폐 금속캔을 주기적으로 수거한다. 재생처리공정을 점검하고 작업자에게 작업을 지시한다. 재생공정 중 발생할 수 있는 안전사고 및 악취 발생에 대비하여 사전계획을 수립한다. 가동 기계장비의 운전시간 및 처리효율을 기록하여 차후 폐 금속캔 수거량을 산정한다. 금속 캔 압축물을 제철소 및 기타 사업체로 운송하기 위한 사전계획을 수립한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","connectJob":"금속캔재생처리관리원","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"E383","dJobICdNm":"[E383]해체, 선별 및 원료 재생업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001341:1', '{"dJobCd":"K000001341","dJobCdSeq":"1","dJobNm":"금속캔재생처리원","workSum":"폐 금속캔을 수거·분리하고 재생처리하여 알루미늄 및 강철 원료로 생산한다.","doWork":"학교 및 공공기관에서 수집된 폐 알루미늄 및 강철 캔을 지게차를 이용하여 재생공장에 운반한다. 수거한 폐 금속캔을 재생처리 장치에 투입하고 투입량을 조절하면서 이송한다. 슬로프(Slop) 컨베이어를 이용하여 강철 선별기까지 이송하고 자석을 이용하여 강철캔과 알루미늄캔 및 이물질을 분리한다. 강철캔은 회전분리기로, 알루미늄캔 등은 알루미늄 선별기로 재선별한 후 압축한다. 회전분리기로 사용한 캔과 비 사용한 캔으로 선별한다. 사용한 캔은 분쇄기로 이송 후 분쇄하고 비 사용 캔은 강철 압축기로 이송 후 압축한다. 압축된 알루미늄 및 철 압축물을 압축기로부터 분리하여 외부로 반출한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"금속재활용원","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"E383","dJobICdNm":"[E383]해체, 선별 및 원료 재생업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005193:1', '{"dJobCd":"K000005193","dJobCdSeq":"1","dJobNm":"냉간압연원","workSum":"열연코일을 소재로 고객의 요구조건을 충족시키기 위한 공정 설계와 표면 산세, 냉간압연, 풀림, 조질압연, 정정, 도금 등을 통한 최적의 냉연제품을 생산한다.","doWork":"열간압연 제품의 표면을 검사하고, 적정 조건에 따라 산세하여 표면의 스케일층을 제거한다. 냉간압연 전 압연스케줄 편성, 압연유, 압연롤 등 사전 준비 후 고객이 요구하는 두께, 폭, 형상을 만족시키도록 냉간중에 압연을 진행한다. 설비사양서를 기초로 소재별 텐션량을 조절하고, 압연조건을 최적화하여 두께 및 형상제어를 실시한다. 냉간압연 후 소재 표면에 잔류하는 압연유 및 이물질을 제거하는 청정작업을 실시하고, 목적한 재질과 표면품질을 만족하도록 설정된 온도와 시간의 풀림처리를 실시한다. 경우에 따라 표면 및 재질 개선을 위한 조질압연을 진행한다. 이후 고객이 요구하는 품질의 폭 전단, 도유 및 표면검사를 하고 최종 제품을 포장한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"냉연작업원","connectJob":"냉간압연작업원","certLic":"압연기능사, 압연기능장","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001483:1', '{"dJobCd":"K000001483","dJobCdSeq":"1","dJobNm":"담금질원","workSum":"금속재료를 가열하고 급냉하여 금속재료의 강도와 경도를 높이기 위한 가열 및 냉각 설비를 조작한다.","doWork":"제품의 특성, 재질, 경도, 형상 등에 따라 열처리 조건을 설정하고 그에 맞는 담금질 온도와 가열시간을 결정한다. 냉각수와 냉각 기름 등 냉각 용매를 결정하고 양을 보충하며 관련 장비와 설비를 점검한다. 조작반의 스위치를 조정하여 노의 문을 열어 피가열 금속을 수동 또는 기중기로 가열로에 장입한다. 직접 가열 혹은 간접 가열, 가열 온도, 가열시간, 냉각방법 등 작업조건에 따라 시간 조절기 및 온도 조절기를 조절하여 온도 및 시간을 조정한다. 일정한 온도(보통 변태점보다 20~30도 높은 온도)에서 필요한 가열시간이 경과하면 노 문을 열고 가열이 된 금속물을 꺼내어 물·기름 등 냉각용매에서 급속히 냉각한다. 이때 강종, 담금질 온도, 형상에 따라 냉각용매를 선정하고 불순물이나 산화스케일 등의 찌꺼기는 정기적으로 제거한다. 냉각된 완성제품의 품질을 경도기 등을 이용해 검사한다. 작업내용을 작업일지에 상세히 기록·보관한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"열처리원","certLic":"열처리기능사","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001444:1', '{"dJobCd":"K000001444","dJobCdSeq":"1","dJobNm":"뜨임원","workSum":"담금질 또는 불림 처리가 된 강(鋼)의 메짐을 줄여 강인성을 주고 경도를 용도에 맞게 변화하기 위해서 적당한 온도로 가열한 후 냉각시키는 가열설비 및 냉각설비를 조작한다.","doWork":"담금질이나 불림 처리된 금속재료의 잔류응력을 제거하고 조직 및 기계적 성질의 안정을 위해 작업지시서에 따라 뜨임 가열로의 온도를 올리고 템퍼링(Tempering) 준비를 한다. 가열로 내의 온도 및 분위기 등을 관찰·확인한다. 준비작업이 끝난 피가열 금속을 뜨임 가열로에 장입한다. 가열 온도 및 시간, 분위기 등을 조절하여 금속을 가열한다. 가열이 완료된 금속을 작업표준에 의해 냉각한다. 뜨임 및 냉각이 완료된 제품을 경도기를 이용해 검사한다. 사용한 각종 공구 및 장비를 정리·정돈한다. 노 내의 청소 및 간단한 보수작업을 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|고온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"소려원, 템퍼링원, 달굼원","connectJob":"열처리원","certLic":"열처리기능사","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006623:1', '{"dJobCd":"K000006623","dJobCdSeq":"1","dJobNm":"롤벤딩원","workSum":"나란히 연속된 성형 롤러에 연속적으로 금속판을 통과시키면서 순차적으로 성형 가공하여 목적의 원 또는 타원형 형상의 제품으로 성형한다.","doWork":"원재료의 재질, 폭, 두께 등이 제작시방서와 일치하는지 확인하고, 작업일지에 기록한다. 하부롤과 상부롤 사이에 원재료를 투입시켜 상,하부롤을 설정된 횟수만큼 회전시키고 관의 형상으로 성형한다. 선,후단 미벤딩 구간은 포스트 벤더를 통해 성형작업을 지속한다. 이후 외경별 프레스 설비를 사용하여 원재료를 순차적으로 굽힘벤딩하여, J형, C형, O형의 순서로 성형작업을 실시한다. 성형공정 완료 후 용접공정으로 제품을 이송하고, 작업일지를 작성한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"투입인출","similarNm":"롤벤딩기조작원","certLic":"압연기능사, 금속가공기술사","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"C291","dJobICdNm":"[C291]일반 목적용 기계 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003990:1', '{"dJobCd":"K000003990","dJobCdSeq":"1","dJobNm":"볼트신선원","workSum":"입고된 원재료를 다이를 통해서 신선한다.","doWork":"신선장치인 다이스 홀더에 다이를 고정한다. 원재료 시작부를 포인팅한다. 교정롤러에 원자재를 투입한다. 포인팅된 원자재를 신선드럼의 체인에 물린다. 신선기를 조작한다. 신선이 완료된 원자재에 재료 구분을 위해 스프레이를 뿌린다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"신선기조작원","connectJob":"신선기조작원","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004908:1', '{"dJobCd":"K000004908","dJobCdSeq":"1","dJobNm":"볼트열처리원","workSum":"성형된 볼트의 성질을 변화시키기 위해 열처리 장치를 조작한다.","doWork":"작업지시서 내용을 숙지하고 열처리 작업을 위한 각종 설비를 점검한다. 열처리방법 및 절차, 온도 및 시간을 결정하고 열처리로의 제반 조건을 설정한다. 노 내 주입 바스켓으로 이형제품을 장입한다. 리프트 및 자동이동대차를 이용하여 볼트를 열처리로에 투입한다. 열처리로 내 자동장치에 온도 등을 설정하고 열처리를 한다. 작업표준을 활용하여 열처리된 제품을 검사한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|고온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"볼트열처리기조작원","certLic":"열처리기능사","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001590:1', '{"dJobCd":"K000001590","dJobCdSeq":"1","dJobNm":"분괴압연원","workSum":"용강을 주조하여 제조한 잉곳(Ingot)을 압연하여 내부 수축관, 기포 등의 결함을 최소화하고,  판, 봉, 선, 형강 등의 형상으로 가공하기 적합한 소형괴로 압연하는 업무를 수행한다.","doWork":"작업지시서와 강종 특성을 숙지하고, 압연기 및 부속설비의 이상유무를 점검한다. 소재를 압연기에 치입(Biting)하고 롤갭(Roll Gap), 압연속도 및 스킨패스를 조정하여 목적한 형상의 제품으로 압연한다. 압연되어 나온 소재(슬라브, 블룸, 빌릿 등) 단면을 게이지를 이용하여 측정하고 압하율을 교정하며 작업일지를 작성한다. 압연 후 제품의 형상 및 표면품질 점검과 롤의 마모 및 균열(Crack) 상태를 점검하여 교체 여부를 판정한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"강괴압연원, 강편압연원","certLic":"압연기능사, 압연기능장","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001501:1', '{"dJobCd":"K000001501","dJobCdSeq":"1","dJobNm":"불림원","workSum":"금속물의 조직 개선 및 표준화, 응력제거, 가공성 향상을 목적으로 금속물을 변태점까지 가열·유지시킨 후 공기 중에서 서서히 냉각시킴으로써 표준 조직으로 처리하는 불림작업을 수행한다.","doWork":"불림 처리를 하고자 하는 금속의 기본적인 성질과 목적에 따라 적절한 열처리 방법 및 절차를 확인한다. 계기를 시험 조작하고 노의 적절한 온도를 사전에 조정한다. 노(爐)의 스위치를 돌려서 노의 온도를 올리고 노 안의 상태를 확인하고 조정하는 작업을 한다. 노 안에 불림 처리를 하고자 하는 금속물을 장입하고 미리 규정된 온도에 적절한 시간 동안 가열한다. 적절한 작업이 이루어지는지 계기 조작 판넬의 온도계를 수시로 확인한다. 알맞게 가열된 금속재료를 꺼내 실온에서 서서히 식힌다. 식은 금속재료의 상태를 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|고온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"소준원, 노르멀라이징원","connectJob":"열처리작업원","certLic":"열처리기능사","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002935:1', '{"dJobCd":"K000002935","dJobCdSeq":"1","dJobNm":"브레이크라이닝공정원","workSum":"자동차 브레이크 라이닝(Brake Lining)을 제조하기 위하여 원재료의 혼합, 가성형, 열성형, 열처리, 커팅, 연마, 마킹, 접착제도포 및 건조 공정을 수행한다.","doWork":"작업지시서에 따라 제작할 라이닝의 규격, 수량을 파악한다. 마찰재를 만들기 위하여 혼합된 재료를 프레스성형기에 투입하여 가성형 한다. 열성형 장비에 적정온도, 압력, 시간을 입력하고 가성형된 반제품 또는 혼합 원재료를 투입하여 제품을 형성한다. 제품, 두께, 재질, 제조공법에 따라 열처리시설의 온도, 유지시간 등을 설정한다. 열성형을 통해 형상된 마찰재를 열처리시설에 투입한다. 처음에는 천천히 온도를 올리고 온도설정치에 도달하게 되면 규정시간을 유지한다. 열처리가 완료된 슈라이닝(Shoe Lining) 형상의 마찰재를 규격에 맞게 커팅하고 접착제의 도포가 용이하도록 내·외면을 연마한다. 마킹머신을 사용하여 제품번호 등을 새겨 넣는다. 라이닝을 슈에 접착하기 위하여 라이닝에 접착제를 도포하고 건조한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"C303","dJobICdNm":"[C303]자동차 신품 부품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004568:1', '{"dJobCd":"K000004568","dJobCdSeq":"1","dJobNm":"브레이크슈공정원","workSum":"자동차 브레이크 슈(Brake Shoe)를 제조하기 위하여 프레스 가공, 용접 가공, 세척 및 코팅 공정을 수행한다.","doWork":"작업지시서에 따라 제작할 슈(Shoe)의 규격, 수량을 파악한다. 브레이크 슈의 부품인 웨브(Web)와 림(Rim)을 용접한다. 용접 후 슈가 요구하는 치수 및 외관에 변형이 일어나지 않도록 R교정(구부러진 정도를 교정함) 장치를 이용하여 규정된 수치로 제작한다. 제작된 슈 및 슈 어세이(Shoe Assay)를 자동이송장치에 위치하고 침전방식(Dipping Type) 세척장치에 투입하여 부식방지 및 라이닝과의 접착력을 향상한다. 작업이 완료되면 수량과 품질을 검사하고 슈 어셈블리(Shoe Assembly) 공정으로 이동한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"C303","dJobICdNm":"[C303]자동차 신품 부품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003733:1', '{"dJobCd":"K000003733","dJobCdSeq":"1","dJobNm":"브레이크슈조립공정원","workSum":"자동차 브레이크 슈(Brake Shoe)를 제조하기 위하여 라이닝(Lining)과 슈(Shoe)를 접착, 연마, 마킹, 조립하는 어셈블리(Assembly) 공정을 수행한다.","doWork":"세척 건조된 슈와 접착제가 도포된 라이닝을 결합한다. 치구를 사용하여 스프링의 힘으로 강제 접착 후 열처리 장비에 투입하여 일정한 온도와 시간을 유지한다. 접착제가 녹으면서 제품이 접착되는 것을 확인한다. 제품 고유의 접착 강도와 접착 면적을 만족시키도록 한다. 접착이 완료되면 브레이크 드럼(Brake Drum)의 크기에 맞게 마찰재로 외면을 연마한다. 제품에 상호, 재질명, 로트넘버 등을 마킹한다. 파킹레버, 핀 등을 슈에 부착한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"C303","dJobICdNm":"[C303]자동차 신품 부품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004844:1', '{"dJobCd":"K000004844","dJobCdSeq":"1","dJobNm":"브레이크패드공정원","workSum":"접착된 몰드(마찰재)와 베이스플레이트(Base Plate)의 열처리, 그루빙(Grooving:모재에 용접 홈을 내어 가공), 연마, 스코칭(Scorching) 공정을 거처 브레이크패드(Brake Pad)를 제조하는 공정 작업을 수행한다.","doWork":"열성형 시설에 제품의 형태, 두께, 재질에 따라 열처리 시간, 온도 등을 입력한다. 제품에 압력을 가한 상태에서 열성형처리(Clamping:클램핑 공법)하여 열성형 시 발생하는 제품의 변형 및 물성을 보전한다. 열성형에 의해 제조된 패드의 중앙 부위에 홈을 파고(Grooving:그루빙 작업) 패드의 양 측면을 경사지게 연삭(면취작업)한다. 성형 및 열처리 공정을 거처 완성된 제품을 자동이송장치를 통해 회전연마기에 투입하여 패드의 두께, 마찰재 면의 평행도를 조성한다. 스코칭(Scorching:패드의 마찰재 표면을 태우는 작업) 기기로 이동하여 스코칭 작업을 실시한다. 완성된 제품은 다음 공정인 도장실로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"C303","dJobICdNm":"[C303]자동차 신품 부품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004048:1', '{"dJobCd":"K000004048","dJobCdSeq":"1","dJobNm":"브레이크패드몰드제조원","workSum":"자동차 브레이크패드(Brake Pad)의 몰드(마찰재)를 제조하기 위하여 원료를 계량, 혼합, 가성형, 건조하는 작업을 수행한다.","doWork":"작업지시서를 보고 생산할 몰드(Molded)의 규격과 종류, 수량을 확인한다. 배합비율에 따라 각종 원재료를 계량하여 혼합기(개면기, 開綿機:압축된 섬유질을 풀어주는 기계)에 투입한다. 계기판을 조작하여 혼합기의 온도, 압력, 작동상태를 조절한다. 생산품목에 따라 섬유류를 1차 개면한 후 다른 원재료를 투입하여 단계별로 혼합(개면)하기도 한다. 성형기의 금형, 유압, 온도 등을 조절하고 혼합(개면)이 완료된 재료를 성형기에 투입시켜 가성형품을 제작한다. 가성형품을 건조기(열풍 또는 히터)로 이송시켜 수분을 제거한다. 건조가 완료된 제품을 베이스플레이트(Base Plate)와 결합시키기 위하여 다음 공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"C303","dJobICdNm":"[C303]자동차 신품 부품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002433:1', '{"dJobCd":"K000002433","dJobCdSeq":"1","dJobNm":"브레이크패드제조반장","workSum":"자동차 브레이크패드(Brake Pad) 생산라인에 종사하는 종업원들의 직무를 분장하고 조정한다.","doWork":"생산계획에 따라 자동차 브레이크패드(Brake Pad) 생산라인의 인원을 배치한다. 생산라인 가동을 위한 각종 원부자재를 관리한다. 철판가공, 가성형, 열성형, 클램핑(Clamping), 열처리, 면취, 연마, 스코칭(Scorching), 도장, 조립, 검사에 이르는 생산라인의 이상 유무를 파악하고 조치한다. 불량품 발생의 원인을 파악하고 적절한 조치를 취한다. 작업자가 작업지시에 따라 안전하게 작업하는지 확인한다. 생산 일지를 기록하고 보고한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"C303","dJobICdNm":"[C303]자동차 신품 부품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005133:1', '{"dJobCd":"K000005133","dJobCdSeq":"1","dJobNm":"브레이크패드플레이트제조원","workSum":"자동차 브레이크패드의 플레이트(Plate)를 제조하기 위하여 프레스가공, 세척 및 쇼트, 접착, 건조 작업을 수행한다.","doWork":"작업지시서를 보고 생산할 플레이트(Plate)의 규격과 종류, 수량을 확인한다. 자동프레스 기기에 플레이트 금형을 설치하고 제어판에 속도, 수량, 압력 등을 입력한다. 기기를 작동시켜 베이스플레이트(Base Plate)를 제작한다. 제작된 베이스 플레이트를 세척기와 쇼트기에 통과시켜 표면의 기름, 녹을 제거한다. 거친 부분(Burr)을 제거하여 접착 면적을 넓히고 접착력을 향상한다. 베이스 플레이트와 몰드를 접착하기 위하여 몰드 내면에 액상 접착제를 도포하고 컨베이어 열풍건조방식으로 건조한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"C303","dJobICdNm":"[C303]자동차 신품 부품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001836:1', '{"dJobCd":"K000001836","dJobCdSeq":"1","dJobNm":"사상압연원","workSum":"열간중에서 조압연된 제품을 정해진 두께와 폭으로 조정하고 용도에 맞는 마무리 온도에서 양호한 표면 및 형상으로 압연하는 업무를 수행한다.","doWork":"작업표준서 및 압연할 소재의 특성과 치수 등을 확인한다. 압연스케줄 편성, 압연유, 압연롤 등을 준비한다. 조압연된 제품의 특성을 파악하고 고객이 요구하는 두께, 폭, 형상을 만족시키도록 마무리압연을 진행한다. 열간중에 압연과 냉각을 진행하면서 설비사양서를 기초로 소재별 텐션량을 조절하고, 압연조건을 최적화하여 두께 및 형상제어를 실시한다. 경우에 따라 표면 및 재질 개선을 위한 교정압연을 진행한다. 이후 고객이 요구하는 품질의 폭 전단 및 표면검사를 실시하여 작업일지를 작성한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"사상압연기조작원, 열간압연원","connectJob":"열연작업원","certLic":"압연기능사, 압연기능장","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001931:1', '{"dJobCd":"K000001931","dJobCdSeq":"1","dJobNm":"선재교정기조작원","workSum":"인발된 선재 코일을 교정하고 절단하는 기계를 조작한다.","doWork":"작업지시서에 따라 인발금형을 선택하여 금형지지대에 끼운다. 입내기 작업에서 경사진 코일재의 선단부를 금형에 끼운다. 코일 선재를 몇 바퀴 감아 인발한다. 교정부의 교정금형을 풀고 인발된 코일을 교정부에 통과시키고 조인다. 직선기를 작동시켜 코일을 교정하고 일정 길이로 절단한다. 교정 롤 및 핀치 롤의 마모상태, 유동장치, 막대의 조정상태 등을 점검한다. 마모된 부품을 교환하고 규정에 따라 조정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|고온|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"각선기조작원, 선재교정원","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002971:1', '{"dJobCd":"K000002971","dJobCdSeq":"1","dJobNm":"선재압연원","workSum":"강편(Billet)을 선재(線材) 형태로 가공하기 위하여 압연기 및 관련 설비를 조작한다.","doWork":"압연롤의 간격 및 마모상태를 확인하고 롤(Roll) 교체 시 롤 및 유도장치의 중심부를 맞추도록 조정한다. 각종 설비의 계기판을 작업표준의 규정치로 조정하고 시운전하여 작동상태를 점검한다. 각 라인과 연락하고 롤별 압연속도를 조정하여 금속소재를 압연한다. 압연 중 소재형상을 검사하고 나선각도, 롤 간의 장력 및 루프(Loope)상태를 관찰·조정한다. 주기적이거나 부정기적인 롤 교체 시 롤 및 유도장치 등의 마모상태를 조사하여 교체 여부를 판단하고 교체작업을 지원한다. 유압 및 냉각수 계통기계의 이음발생 및 발열상태, 오일 및 그리스의 공급상태 등을 점검하고 이상 유무를 파악한다. 정비·수리하고 지원한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"선재압연기조작원","certLic":"압연기능사, 압연기능장","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006771:1', '{"dJobCd":"K000006771","dJobCdSeq":"1","dJobNm":"선재제조반장","workSum":"전선 제조에 사용되는 선재(線材)를 제조하기 위해서 전기동, 알루미늄 등과 같은 금속을 용해, 주조, 압연, 권취하는데 종사하는 작업원의 직무를 분장하고 조정한다.","doWork":"용해로 내의 온도, 가스압력, 냉각수펌프 작동, 배수펌프의 작동 여부, 압연기 내 전류의 세기, 각종 스위치의 작동 여부 등을 확인한다. 유지로의 온도를 점검하고 출탕 시점을 판단한다. 금속재료 용해원에게 출탕을 지시한다. 주조된 금속막대(Bar)의 온도를 측정하고 선재의 특성에 맞도록 작업을 조정·지시한다. 생산된 선재의 순도·성분 등을 검사하기 위해 분석실에 검사를 의뢰한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|고온|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","connectJob":"용동반장, 도가니로반장, 열간압연반장","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"C241/C242","dJobICdNm":"[C241]1차 철강 제조업 / [C242]1차 비철금속 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003924:1', '{"dJobCd":"K000003924","dJobCdSeq":"1","dJobNm":"선재코일원","workSum":"인발 기계에서 나온 강선(鋼線)을 가공 작업에 적당한 타래 형태로 보빈에 감는 기계를 조작한다.","doWork":"지름별로 분류된 강선(鋼線)을 급송릴에 올려놓는다. 강선 끝을 롤 사이로 통과시켜 롤홈에 끼우고 보빈에 감는다. 스위치를 눌러 기계를 작동시키고 강선을 보빈에 연속적으로 감는다. 감기는 상태를 육안으로 관찰하여 불량한 것을 절단한다. 감긴 보빈을 지지대에서 빼내 적재한다. 연속작업을 하기 위해 용접 등의 방법으로 강선과 강선을 연결하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"해사원","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"C241/C283","dJobICdNm":"[C241]1차 철강 제조업 / [C283]절연선 및 케이블 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001832:1', '{"dJobCd":"K000001832","dJobCdSeq":"1","dJobNm":"쇼트원","workSum":"금속제품의 표면에 묻어 있는 찌꺼기, 녹, 기름때, 군더더기 등의 불순물을 제거하고 표면을 매끄럽게 하기 위해 쇼트기계를 조작한다.","doWork":"표면을 매끄럽게 처리할 제품의 종류, 크기, 형태에 따라 작업방법을 결정한다. 모래, 강립(鋼粒:금속알갱이), 그릿 등의 연마제를 쇼트기계장치의 호퍼에 채운다. 신체를 보호하기 위하여 헬멧, 보안경, 쇼트복, 장갑 등의 안전보호구를 착용한다. 밀폐된 쇼트실에 제품을 올려놓고 쇼트할 부분을 확인하고 밀폐한다. 회전통에 제품과 강립을 투입하고 쇼트분사장치를 조정한다. 공기송풍기를 시동하고 압력을 조절하여 쇼트 분사기의 노즐압력을 조절하고 제품에 강립(금속알갱이)이나 그릿을 분사하여 불순물을 제거될 때까지 쇼트실 내의 제품을 일정 시간 쇼트한다. 쇼트된 제품을 육안으로 검사하여 표면 상태를 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"샌드블라스트원","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"C","dJobICdNm":"[C]제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005024:1', '{"dJobCd":"K000005024","dJobCdSeq":"1","dJobNm":"스파이럴강관조관원","workSum":"대형관을 성형하기 위하여 나선 형태로 감아서 용접하는 조관기를 조작한다.","doWork":"작업지시서를 확인하고 관의 규격에 따라 롤을 선택하여 교환 설치한다. 관의 규격에 맞추어 각도 조정 스크루로 규정된 성형각도 및 롤간격을 조정한다. 용접심선 안내장치를 설치하고 용접심선을 릴에 끼운 후 후럭스(Flux)호스를 준비한다. 코일(Coil)이나 강판을 성형롤 사이로 이송시켜 나사형태의 관을 성형하고 아크자동용접기의 조작반을 조작하여 이음부위를 용접한다. 가이드롤러에 코일이나 강판이 도달하면 관의 중심에 맞추어 롤을 조정한다. 심선 공급롤을 구동하여 용접심선을 가이드팁까지 이송하고 공기밸브와 후럭스 호퍼를 열어 후럭스를 공급한다. 용접기의 간격조정버튼을 조작하여 코일이나 강판의 튀어나온 모서리부분과 간격을 조정한다. 외경측정치와 튀어나온 부분 및 간격을 확인하며 조관작업을 진행한다. 강관의 후단이 연결대에 도달하면 정지버튼을 눌러 조관작업을 중지하고 강관 후단의 폭을 자로 측정하고 조관방향에 직각이 되게 절단한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"강관제조원","dJobECd":"8212","dJobECdNm":"[8212]금속가공 기계 조작원","dJobJCd":"8415","dJobJCdNm":"[8415]금속가공 기계 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;