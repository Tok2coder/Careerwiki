INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004360:1', '{"dJobCd":"K000004360","dJobCdSeq":"1","dJobNm":"담배제조반장","workSum":"담배를 제조하는 작업원의 활동을 감독·조정한다.","doWork":"작업지시서를 확인하고 작업계획을 세운다. 기계의 가동상태를 점검하고자 각 공정을 순찰한다. 각 기계의 기능을 작업원에게 교육한다. 작업원에게 작업내용을 지시하고 작업에 맞게 배치한다. 작업의 진행사항을 파악하고 작업내용을 보고한다. 작업원의 작업상황을 관리·감독한다. 작업계획에 따라 세부실행항목을 수립한다. 작업절차 및 방법을 결정하여 작업원에게 지시한다. 필요에 따라 작업원과 함께 작업한다. 작업원을 수시로 관찰하고 면담하여 작업원의 애로점 및 건의사항을 파악하고 해결을 위해 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","connectJob":"잎담배가공반장, 담배원료가공반장, 담배제품제조반장","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C120","dJobICdNm":"[C120]담배 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004810:1', '{"dJobCd":"K000004810","dJobCdSeq":"1","dJobNm":"담배품질관리기조작원","workSum":"담배의 품질관리 및 공정관리의 효율성을 높이기 위하여 잎담배의 가동상황, 궐련의 품질 등을 관리하는 기계(자동품질관리기)를 조작한다.","doWork":"가공기계의 품질관리장치에 대한 이상 유무를 점검한다. 제품의 종류에 따라 규격을 입력하고 불량궐련 적출시험 및 자동견본장치를 조절한다. 각 기계의 조정판을 점검하고 비정상 작업기계의 이상 유무를 각 작업자에게 통보한다. 수시로 품질관리장치의 가동상태를 점검하고 가공상황을 작업일지에 기록한다. 일일 작업이 완료되면 각 기계별 가동상황을 컴퓨터에 입력한다. 고장 시 응급조치를 취한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C120","dJobICdNm":"[C120]담배 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001405:1', '{"dJobCd":"K000001405","dJobCdSeq":"1","dJobNm":"당밀분리원","workSum":"화학조미료를 제조하고자 당밀(糖蜜)에 함유된 칼슘 및 불순물을 분리·제거한다.","doWork":"당밀(사탕수수나 사탕무를 설탕으로 가공할 때 부수적으로 나오는 찐득한 시럽으로 조미료의 단맛을 내기 위해 사용) 저장탱크의 유량계를 확인하고 밸브를 열어 당밀을 용해관으로 이송한다. 용해관의 급수밸브를 조절하여 일정 비율의 황산용액을 투입한 후 혼합이 용이하도록 교반기를 가동한다. 용해가 완료되면 견본을 채취하여 불순물의 제거상태를 검사하고 제품 표준과 비교한다. 용해관의 배출밸브를 열고 펌프를 가동하여 원심분리기에 투입한다. 원심분리기 하부의 배출구를 열고 펌프를 가동하여 불순물이 제거된 용액을 저장탱크로 이송한다. 분리된 당밀슬러지(Sludge)는 폐기장으로 운반한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"당밀정제원","certLic":"식품산업기사, 식품가공기능사","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003183:1', '{"dJobCd":"K000003183","dJobCdSeq":"1","dJobNm":"된장제조원","workSum":"탈지대두에 누룩곰팡이를 접종(接種)시켜 개량식 된장을 제조하는 설비를 조작·관리한다.","doWork":"탈지대두(대두 중 지질을 추출한 것)를 증자(증기로 찜)하기 위해 증자(蒸煮)탱크의 투입구를 열고 일정량의 탈지대두를 투입한다. 제품 표준에 따라 일정 비율의 물을 함께 급수한다. 교반기를 가동하고 증기밸브를 조절하여 일정 온도를 유지시킨다. 증자된 탈지대두를 판상 위에 쏟은 후 넓게 펴서 열을 식히고, 누룩곰팡이(곡자균)를 접종(接種)시킨다. 누룩곰팡이와 접종된 탈지대두를 숙성시키기 위해 제국실(製麴室)로 운반한 후 온도, 습도를 일정하게 유지하여 발효·숙성시킨다. 견본을 채취하여 발효상태를 점검하고 제품 표준과 비교한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"고추장제조원, 쌈장제조원","certLic":"식품산업기사, 식품가공기능사","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004311:1', '{"dJobCd":"K000004311","dJobCdSeq":"1","dJobNm":"맛소금제조원","workSum":"맛소금을 제조하고자 조미료를 용해하고 소금을 코팅하는 기계를 조작·관리한다.","doWork":"제품 표준에 따라 소금 및 조미료를 선별하고 계량한다. 용해할 조미료를 물과 함께 용해탱크에 투입하고 용해탱크를 가동한다. 용해탱크 내부의 온도가 일정하게 유지되고 교반기가 작동하는지 관찰한다. 용해가 완료되면 펌프를 가동하여 맛소금을 코팅하기 위하여 용해액 저장탱크로 이송한다. 맛소금 코팅기에 투입된 조미료 용해액에 정제염을 투입하고 코팅기를 가동한다. 회전하는 코팅기에 용해와 코팅이 용이하도록 용해액을 작업표준서에 따라 일정량을 분사한다. 코팅이 완료되면 제조된 조미료를 제품 표준과 비교·검사한다. 견본의 일부를 성분 분석하고자 실험실로 보낸다. 코팅이 완료되면 조미료를 저장탱크로 운반한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"맛소금코팅원, 용해원, 조미료용해원, 조미료제조원, 설탕제조원","certLic":"식품산업기사, 식품가공기능사","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004666:1', '{"dJobCd":"K000004666","dJobCdSeq":"1","dJobNm":"배지조제원","workSum":"화학조미료 제조 시 글루타민산을 생산하고자 글루타민산 생산균을 증식할 배지를 조제한다.","doWork":"배지 조제탱크의 급수밸브를 열어 일정량의 물을 주입한다. 종균이 번식할 수 있도록 탄소, 질소, 아미노산, 무기물, 비타민 등을 일정 비율 투입한다. 증기밸브를 돌려 조제탱크를 일정 온도로 가열하고 견본을 채취하여 산도를 검사한다. 연속살균기의 증기밸브를 돌려 순환관에 증기를 투입한다. 조제탱크의 배출구를 열고 펌프를 가동하여 연속살균기에 배지를 주입한다. 살균된 합성배지를 전배양조나 본배양조로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"식품산업기사, 식품가공기능사","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006248:1', '{"dJobCd":"K000006248","dJobCdSeq":"1","dJobNm":"벌꿀제조원","workSum":"혼합된 벌꿀 속에 포함되어 있는 수분을 제거하여 일정 농도로 농축하는 기계를 조작하거나 여러 등급의 벌꿀을 혼합하는 기계를 조작·관리한다.","doWork":"벌꿀액을 농축기에 일정량 투입하고 작업표준서에 따라 농축기의 조정판에 온도와 농축시간 그리고 압력 등을 입력한다. 농축기를 가동시키고 농축이 진행되는 상황을 온도계 및 압력계 등을 통하여 관찰·점검한다. 온도가 너무 높을 경우 벌꿀이 탈 염려가 있으므로 온도변화가 있는지 각별히 유의한다. 농축이 완료된 벌꿀의 견본을 채취하여 농도와 수분함유량, 점도 등을 검사하고 제품 표준과 일치하는지 비교한다. 농축이 완료된 벌꿀은 색상과 향 등을 검사하여 등급별로 분류하고 펌프를 가동시켜 저장탱크로 이송하거나 포장기계로 이송한다. 제품의 종류에 따라 혼합할 벌꿀의 등급을 선별한 후 계량하고 혼합기에 계량한 벌꿀을 작업표준에 따라 일정 비율로 투입한다. 혼합기의 조정판에 온도, 혼합시간, 교반속도 등을 입력한 후 혼합기를 가동한다. 혼합이 완료되면 견본을 채취하여 혼합상태를 점검하고 여과기를 통과시켜 이물질을 여과한다. 여과가 완료된 혼합벌꿀은 저장탱크로 이송되어 농축기에 투입될 때까지 저장한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"고온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"토종꿀제조원, 아카시아꿀제조원, 밤꿀제조원, 잡화꿀제조원","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005162:1', '{"dJobCd":"K000005162","dJobCdSeq":"1","dJobNm":"생지가열로조작원","workSum":"동물성 유지를 제조하고자 수집한 동물성 생지(가축의 껍질 및 비곗덩어리)를 가열하는 가열로를 조작·관리한다.","doWork":"동물의 지육(脂肉), 껍질, 내장 등 원료를 선별한다. 생지가열로의 작동상태를 점검한다. 선별된 생지를 넣고 생지가열로를 작동시킨다. 원료에 따라 적정온도를 유지하고 생지의 가열상태를 관찰한다. 적정온도로 일정한 시간 동안 가열되면 융출(融出)된 유지원유를 배출하고 정제공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"시범후 30일 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|고온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"동물성유지융출작업원, 동물성유지제조원","connectJob":"토종꿀제조원, 아카시아꿀제조원, 밤꿀제조원, 잡화꿀제조원 등","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C101","dJobICdNm":"[C101]도축, 육류 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003753:1', '{"dJobCd":"K000003753","dJobCdSeq":"1","dJobNm":"설탕건조기조작원","workSum":"당액이 제거된 설탕입자의 수분을 규정수준까지 낮추기 위하여 설탕건조기를 조작·관리한다.","doWork":"설탕건조기 내부의 온도, 습도가 규정된 범위 내에서 일정하게 유지되는지 확인한다. 자동화된 기계의 조정판에 건조기의 온도, 설탕입자의 투입량, 수분함유량 등을 입력하기도 한다. 결정분리기를 거쳐 당액과 분리된 설탕입자를 건조기에 투입하고 가동한다. 건조가 완료되면 설탕의 등급별로 각 탱크에 저장하고, 견본을 채취하여 제품규격과 비교·검사한다. 견본의 일부는 성분검사를 위하여 실험실로 보낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"식품산업기사, 식품가공기능사","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004461:1', '{"dJobCd":"K000004461","dJobCdSeq":"1","dJobNm":"세당작업원","workSum":"설탕을 제조하고자 원당 표면의 불순물을 제거해 세당(洗糖)을 만드는 원심분리기를 조작·관리한다.","doWork":"일정 농도의 마그마(Magma:끈적끈적한 상태)를 만들기 위해 원당(사탕수수의 즙에서 추출한 설탕 원료) 투하량과 적정 그린시럽(Green Syrup)량을 확인한다. 자동기계의 조정판에 원당과 그린시럽의 혼합비율·시간, 원심분리기의 회전속도 등을 직접 입력하기도 한다. 호퍼스케일(Hopper Scale:호퍼에 투입된 가루, 액체, 덩어리의 양을 자동으로 계량하는 장치)을 가동하여 원당을 공급하고, 그린시럽 공급밸브를 열어 그린시럽을 혼합기에 투입한다. 혼합기를 가동해 원당과 그린시럽을 혼합하고, 혼합이 완료되면 마그마를 원심분리기에 자동 이송한다. 작업표준에 따라 원심분리기의 회전속도를 조절한 후, 원당의 겉 표면에 붙은 불순물들을 제거하고자 자동 세척한다. 세척이 완료된 세당(洗糖:세척된 원당)은 용당공정으로 자동 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"세당탱크운전원","certLic":"식품산업기사, 식품가공기능사","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004752:1', '{"dJobCd":"K000004752","dJobCdSeq":"1","dJobNm":"소금용액제조원","workSum":"설탕을 제조하고자 당액을 정제·탈색하는 과정에서 필요한 소금물을 제조한다.","doWork":"일정 농도의 수산화칼슘용액, 소금물을 제조하고자 용해탱크에 물을 채우고 일정량의 소금을 투입한다. 소금의 용해가 용이하도록 교반기를 가동하고, 견본을 채취하여 농도가 작업표준과 일치하는지 비교·검사한다. 용해가 완료되면 펌프를 가동하여 이온교환수지탑에 소금물을 자동 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"식품산업기사, 식품가공기능사","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003510:1', '{"dJobCd":"K000003510","dJobCdSeq":"1","dJobNm":"식용유원료전처리원","workSum":"식용유를 만드는 콩에서 기름이 추출되도록 전처리설비를 작동하여 콩을 물리적으로 가공한다.","doWork":"원료 저장탱크로부터 컨베이어를 통해 정선기로 이송되는 콩의 흐름을 점검한다. 자석정선기에 의해 금속조각을 제거하고 체를 사용하여 잎이나 줄기, 흙, 잡곡 등의 불순불을 제거한다. 조쇄기(Coarse Crusher), 분쇄기(Crushing Mill) 및 압편기(Press Roller)의 온도 및 압력상태를 입력한다. 컨베이어로 이송되는 콩의 투입을 관찰한다. 롤러에 통과되어서 얇은 조각(Flake) 상태로 나오는 콩의 상태를 표본추출하여 검사하고 분쇄정도를 파악한다. 설비가 가동되는 현장을 돌아보면서 기계 및 설비(컨베이어, 승강기 등)의 제어 및 작동상태, 흐름 등을 점검한다. 제어조정판에 경보등이 켜지면 전처리설비에 이물질이 걸려 있는지 등 제반원인을 확인하고 조치한다. 작업상황을 작업일지에 기록하거나 컴퓨터에 입력한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C104","dJobICdNm":"[C104]동물성 및 식물성 유지 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006833:1', '{"dJobCd":"K000006833","dJobCdSeq":"1","dJobNm":"식용유정제반장","workSum":"식용유를 제조하고자 추출 분리된 식용원유를 탈산, 탈색, 탈취, 탈검 등의 정제작업에 종사하는 작업원의 활동을 감독·조정한다.","doWork":"명시된 양과 질을 유지하고자 각 공정을 순찰하고 각종 계기를 관찰한다. 견본을 채취하여 표준견본과 비교하고자 실험실로 보낸다. 작업내용에 따라 작업원에게 지시·배치한다. 작업의 진행사항을 파악하고 작업내용을 보고한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원 및 자재를 공급한다. 작업계획에 따라 세부실행항목을 수립하고 작업절차 및 방법을 결정하여 작업원에게 작업내용을 지시하고 작업배치를 한다. 표준작업명세에 따라 지시된 작업이 이루어지는지 작업원과 함께 작업하며 작업상황을 관찰하고 작업내용을 점검한다. 작업원의 직무교육 및 안전위생교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴·해결하고 문제점을 보완한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C104","dJobICdNm":"[C104]동물성 및 식물성 유지 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003306:1', '{"dJobCd":"K000003306","dJobCdSeq":"1","dJobNm":"식용유추출반장","workSum":"식물성유지를 추출하고자 대두, 옥수수 등의 원료를 분쇄·압편·추출하는 일에 종사하는 작업원의 활동을 감독·조정한다.","doWork":"각종 계기와 기계의 상태를 관찰하고 제품의 종류와 품질에 따라 기계의 가동상태를 점검한다. 작업일지 또는 생산일지를 기록하고 작업원의 안전교육을 실시한다. 작업내용에 따라 작업원에게 지시·배치한다. 작업의 진행사항을 파악하고 작업내용을 보고한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원 및 자재를 공급한다. 작업계획에 따라 세부실행항목을 수립하고 작업절차 및 방법을 결정하여 작업원에게 작업내용을 지시하고 작업배치를 한다. 표준작업명세에 따라 지시된 작업이 이루어지는지 작업원과 함께 작업하며 작업상황을 관찰하고 작업내용을 점검한다. 작업원의 직무교육 및 안전위생교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴·해결하고 문제점을 보완한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C104","dJobICdNm":"[C104]동물성 및 식물성 유지 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004631:1', '{"dJobCd":"K000004631","dJobCdSeq":"1","dJobNm":"식용유추출원","workSum":"대두, 옥수수, 유체, 팜 등에서 유지를 분리하고자 휘발성 용제를 혼합하여 식물조직에 포함된 유지를 추출하는 기계를 조작 및 관리한다.","doWork":"식물종류의 종자에 따라 정선, 조쇄, 분쇄, 열처리, 압편 등의 전처리공정을 거친 원료가 컨베이어나 이송관을 통해 추출기의 투입구에 일정량씩 제대로 투입되는지 확인한다. 제어실의 조정판을 조작하여 휘발성 용제탱크에서 나오는 헥산, 헵탄(Heptane), 아세톤 등의 용제가 압편되어 얇은 조각 상태(Flake)의 원료에 일정한 양만큼 분무되는지 확인한다. 시간당 정액의 기름이 추출되도록 유량을 설정하여 입력한다. 원료투입량의 흐름, 추출기의 가동상태가 원활한지 점검하며 추출기의 하부탱크에 유지가 채워지면 펌프를 가동하여 저장탱크로 이송한다. 유지가 추출된 탈지박(기름성분이 빠진 콩껍질)의 견본을 채취하여 분석실로 보내 유지의 잔류량을 확인한다. 추출된 기름이 증류기를 통해 제대로 증류되도록 증류기의 스팀온도, 압력, 진공, 유량 등을 점검 및 조정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C104","dJobICdNm":"[C104]동물성 및 식물성 유지 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004493:1', '{"dJobCd":"K000004493","dJobCdSeq":"1","dJobNm":"식용유충전원","workSum":"정제완료된 식용유를 제품별 용량에 따라 포장용기에 충전하는 기계를 조작한다.","doWork":"충전기의 가동상태를 점검하고 수량측정기의 눈금을 맞춘다. 기계에 투입되는 용기의 정렬상태를 확인하고 식용유 투입밸브를 조절한다. 충전기를 가동하여 포장용기에 충전되는 상태를 점검한다. 충전이 완료된 용기가 밀봉기로 투입되는 상태를 관찰한다. 밀봉기를 통과한 용기의 밀봉상태를 확인한다. 작업이 완료되면 작업수량을 확인하고 작업일지에 기록한다. 식용유의 충전상태를 점검하여 불량제품을 제거하기도 하며 용기의 뚜껑을 조이기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C104","dJobICdNm":"[C104]동물성 및 식물성 유지 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002292:1', '{"dJobCd":"K000002292","dJobCdSeq":"1","dJobNm":"식용유탈검원","workSum":"추출된 기름에서 인지방질, 단백질, 탄수화물 등의 불순물을 제거하고자 혼합기, 원심분리기 등을 조작한다.","doWork":"추출된 원유를 혼합조에 투입한다. 조정판을 조작하여 온도, 시간, 투입할 물과 인산의 양 등을 입력한다. 원유에 일정량의 물과 인산이 투입되면 원유와 인산을 일정 시간 혼합한다. 인산과 혼합된 원유에 인지질, 단백질, 점질물, 탄수화물 등 불순물인 검질을 분리하고자 조정판을 조작하여 원심분리기를 가동한다. 탈검공정이 완료되면 원유를 탈산공정으로 이송시킨다. 분리된 불순물은 레시틴(Lecithin)으로 가공하기 위해 해당 공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|고온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C104","dJobICdNm":"[C104]동물성 및 식물성 유지 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004955:1', '{"dJobCd":"K000004955","dJobCdSeq":"1","dJobNm":"식용유탈산원","workSum":"탈검유에서 유리지방산(遊離脂肪酸)을 제거하고자 혼합기, 원심분리기 등을 조작한다.","doWork":"추출된 원유저장탱크에서 탈검공정을 거친 원유가 탈산중화조에 이송되면 제어실의 조정판을 조작하면서 열교환기 또는 증기밸브를 조절하여 원유를 중화적정 온도로 가열하여 유지한다. 유리지방산이나 미량의 금속 및 색소 등 기타 불순물을 제거하고자 인산, 가성소다 등 알칼리를 일정 비율로 투입한다. 조정판을 조작하여 원심분리기를 가동하고 진공탱크의 온도, 압력, 진공상태, 유량 등을 점검한다. 탈산과정이 완료되면 표본을 추출하여 산성도를 분석하고 점검기준서에 부합하는지 확인한다. 검토 및 점검된 제반 사항을 작업·공정일지에 기록하거나 컴퓨터에 입력한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"식용유탈산조정판조작원","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C104","dJobICdNm":"[C104]동물성 및 식물성 유지 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005545:1', '{"dJobCd":"K000005545","dJobCdSeq":"1","dJobNm":"식용유탈색원","workSum":"유리지방산(遊離脂肪酸)이 제거된 원유에서 불필요한 색소를 제거하고자 교반기와 여과기를 작동하고 관리한다.","doWork":"탈색조 내에 탈산유(산기(酸氣)가 빠진 원유)가 얼마나 차 있는지 확인하고자 원유의 액위(Level)상태를 파악하며 액위의 균형을 유지시킨다. 탈색조에 투입하는 탈색조에 활성백토, 활성탄 또는 산성백토 등의 흡착제의 투입기준이 적절한지 제어실에서 투입수치를 확인한다. 탈산유가 들어있는 탈색조에 흡착제를 투입하고 교반기를 가동해서 혼합한다. 일정 시간 동안 혼합·유지하여 탈색한 후, 여과기(Filter)로 이송하여 사용한 흡착제를 제거한다. 탈색과정을 거친 유액의 표본을 추출하여 표준색도에 비교하여 색가정도(Color Value)를 평가한다. 탈색유가 탈취탑으로 제대로 이송되는지 유량을 확인한다. 검토 및 점검된 제반사항을 작업·공정일지에 기록하거나 컴퓨터에 입력한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"식용유탈색조정판조작원","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C104","dJobICdNm":"[C104]동물성 및 식물성 유지 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003603:1', '{"dJobCd":"K000003603","dJobCdSeq":"1","dJobNm":"식용유탈취원","workSum":"탈검, 탈산, 탈색과정을 거친 탈색유의 냄새, 수분, 불순물 등을 제거하고자 탈취탑 내에서 탈취작업을 실시하고 관리한다.","doWork":"제어실에서 모니터장치를 통해 탈취탑으로 정량의 탈색유가 유입되는지 확인한다. 탈취탑의 진공상태와 온도 및 기압상태를 점검하고 적절한 수준(고진공, 고온)으로 유지시키며 변질속도를 제어한다. 정기적으로 설비가 작동되는 현장에 가서 탈취유 표본을 추출하여 수분, 색가(Color Value), 산가(Acid Value) 등을 측정한다. 검토 및 점검된 제반 사항을 작업·공정일지에 기록하거나 컴퓨터에 입력한다. 탈취과정이 끝난 식용유가 냉각열교환기로 제대로 이송되어 적정온도로 냉각되는지 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"식용유탈취조정판조작원","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C104","dJobICdNm":"[C104]동물성 및 식물성 유지 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002472:1', '{"dJobCd":"K000002472","dJobCdSeq":"1","dJobNm":"식초제조원","workSum":"식초를 제조하고자 혼합원료(청주박, 주정, 포도당 등)에 효모를 접종(接種)하여 발효·숙성·여과·살균하는 장비를 조작·관리한다.","doWork":"제조하고자 하는 제품에 따른 배합비를 확인한 후, 자동계량용기나 저울을 사용해 원료(주정, 포도당, 청주박)를 계량한다. 배합탱크에 계량한 원료를 투입하고 일정량의 물을 넣은 후, 배합이 용이하도록 교반기를 작동시킨다. 배합이 완료되면 탱크의 배출밸브를 열고 펌프를 가동하여 발효탱크로 배합액을 이송한다. 실험실에서 제조한 효모를 배합액에 접종(接種)하고 교반기를 가동한다. 증기밸브, 냉각수밸브, 송풍기 등을 사용하여 발효탱크의 온도를 일정하게 유지시킨다. 배합이 완료된 배합액을 숙성탱크로 이송하여 일정 시간 동안 숙성시킨 후 여과망이 부착된 여과기에 주입하여 배합액과 균체를 분리한다. 여과된 식초의 견본을 채취하여 산도(초 속에 포함되어 있는 각종 유기산의 산미성분 비율)를 검사하고 펌프를 가동하여 완성조 탱크로 이송한다. 산도를 제품규격에 맞추기 위하여 급수밸브를 돌려 일정 비율의 물을 주입한다. 초산균 및 기타 유해균을 살균하고자 열교환기를 통과시킨다. 살균온도와 인출온도를 확인하며 스팀을 사용할 때는 스팀압력과 가압변화, 자동컨트롤러의 이상 유무를 확인·점검한다. 펌프를 가동하여 저장탱크로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"식초발효원, 식초정제원","certLic":"식품산업기사, 식품가공기능사","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006485:1', '{"dJobCd":"K000006485","dJobCdSeq":"1","dJobNm":"식품원료혼합기조작원","workSum":"소스(마요네즈, 겨자, 샐러드용 드레싱 등)를 제조하고자 각종 식품원료를 혼합하는 기계를 조작·관리한다.","doWork":"제품의 종류에 따라 각종 식품원료(계란, 소금, 식초, 향료, 설탕 등)를 준비한 후 계량한다. 혼합기의 뚜껑을 열고, 계량한 원료를 일정 비율로 투입한다. 혼합이 용이하도록 교반기를 작동시키고, 혼합기의 밸브를 조절하여 액체원료(기름, 물, 식용유 등)를 투입한다. 균질기를 통하여 일정 시간 균질혼합한 후 견본을 채취하여 유화 분산상태를 검사한다. 유화가 완료되면 배출밸브를 열고 펌프를 가동하여 저장탱크나 배전공정으로 혼합물을 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"겨자혼합원, 마요네즈혼합원, 향료혼합원","certLic":"식품산업기사, 식품가공기능사","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005736:1', '{"dJobCd":"K000005736","dJobCdSeq":"1","dJobNm":"식품조미원","workSum":"음식의 맛을 알맞게 맞추는 데 사용되는 조미식품을 제조하고자 각종 첨가물(식염, 설탕, 포도당 등)을 혼합하고 관련 기계를 조작·관리한다.","doWork":"계량용기나 자동저울을 사용하여 첨가물(식염, 설탕, 포도당 등)을 일정 비율로 계량한다. 조미탱크의 밸브를 열고 펌프를 가동하여 희석액을 투입한다. 계량한 첨가물을 작업순서에 따라 투입한 후, 혼합이 용이하도록 교반기를 가동한다. 혼합이 완료되면 견본을 채취하여 당도, 점도, 산도, 염도 등을 제품 표준과 비교·검사한 후 펌프를 가동하여 균질기(거친 유상액이나 부유물 덩어리를 미세입자로 분해시켜 안정된 유화상태의 품질로 만드는 기계)에 투입한다. 균질기를 가동하여 일정 시간 동안 작업 후 충전탱크로 이송한다. 작업이 완료되면 투입한 원료의 종류와 수량을 작업일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"식품산업기사, 식품가공기능사","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004821:1', '{"dJobCd":"K000004821","dJobCdSeq":"1","dJobNm":"쌀엿제조원","workSum":"쌀엿을 제조하고자 쌀에 효소를 투여하여 분쇄·여과·당화·농축하는 장비를 조작·관리한다.","doWork":"공급장치인 호퍼(Hopper)에 담긴 쌀을 배출구를 통해 분쇄기로 투입한다. 분쇄기에서 분쇄가 완료되면 로터리밸브를 열고 액화조로 이송한 후 효소를 넣고 액화시킨다. 액화가 완료되면 냉각기를 통과시켜 냉각시키고 엿기름을 투입하여 당화시킨다. 당화가 완료되었는지를 확인한 후 압착여과기에 통과시킨다. 여과액의 농도를 검사하고 농축기로 이송한다. 농축기의 압력과 온도를 작업표준에 맞게 조정한 후 농축한다. 농축이 완료된 제품의 농도를 작업표준서와 비교한 후 최종 여과를 거쳐 저장실로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C106","dJobICdNm":"[C106]곡물가공품, 전분 및 전분제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004712:1', '{"dJobCd":"K000004712","dJobCdSeq":"1","dJobNm":"액상정제기조작원","workSum":"설탕을 제조하고자 당액에 포함된 불순물을 제거하는 정제장치를 조작·관리한다.","doWork":"당액을 정제·탈색하기 위한 이온교환수지탑에 음이온, 양이온 수지를 채워 넣고 여과탱크에 활성탄(Carbon)을 넣는다. 진공펌프를 가동하여 당액을 여과필터로 걸러 불순물을 제거하고, 활성탄이 채워진 여과탱크를 통과시켜 유기물질을 제거한다. 이 과정을 통해 짙은 황색의 당액은 불순물과 색을 흡착해 연한 황색의 당액이 된다. 용액 내에 남아있는 소금기를 제거하고자 펌프를 가동하여 당액을 이온교환수지탑에 투입한다. 정제된 당액의 견본을 채취하여 색도, 산도 등을 검사하고자 실험실로 보낸다. 저장탱크로 이송하고자 펌프를 가동한다. 여과탱크의 활성탄과 이온교환수지탑의 음이온, 양이온을 수시로 점검하여 교환한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"식품산업기사, 식품가공기능사","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006595:1', '{"dJobCd":"K000006595","dJobCdSeq":"1","dJobNm":"양념혼합원","workSum":"제품 표준에 맞는 양념을 제조하고자 분쇄된 원료(마늘, 생강, 고추, 계피)를 일정 비율로 계량하여 혼합한다.","doWork":"제조하려는 제품의 종류에 따라 분쇄된 원료(마늘, 생강, 설탕, 고추가루 등)를 작업표준에 맞게 계량하고 혼합기에 투입한다. 혼합기를 가동하고 혼합이 용이하게 이루어지는지, 교반기가 작동하는지 등을 확인한다. 혼합이 완료된 양념혼합물의 견본을 채취하여 혼합비, 맛, 색 등을 제품 표준과 비교·검사한다. 견본의 일부의 성분을 검사하고자 실험실로 보낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002555:1', '{"dJobCd":"K000002555","dJobCdSeq":"1","dJobNm":"양조간장발효숙성원","workSum":"양조간장을 제조하고자 소금물에 곡자(원료국)를 띄우고 효모를 첨가하여 발효·숙성시키는 탱크를 조작·관리한다.","doWork":"염수저장탱크의 밸브를 열고 펌프를 가동하여, 발효탱크(스테인리스 재질)에 일정량의 소금물을 채운다. 작업표준에 따라 일정 비율의 곡자(원료국)를 투입한다. 혼합이 용이하도록 탱크 내부에 공기를 투입하고 공기에 의한 혼합이 제대로 이루어지는지 확인한다. 발효탱크 내의 온도가 일정하게 유지되는지 확인·점검한다. 담금 후 초기에는 매일 한 번씩, 후기에는 2∼3일에 한 번씩 교반하면서 발효·숙성한다. 발효가 완료되면 살균하고, 간장과 찌꺼기를 분리하기 위한 압착공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"식품산업기사, 식품가공기능사","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002887:1', '{"dJobCd":"K000002887","dJobCdSeq":"1","dJobNm":"염수정제원","workSum":"양조간장 등의 식료품을 제조하고자 소금물을 만들고 정제(精製)한다.","doWork":"용해탱크에 물을 채우고, 자동 계량된 소금(精製鹽)을 작업표준에 따라 일정량을 투입한다. 용해탱크의 교반기를 작동시켜 용해를 시키고, 용해가 잘 이루어지는지 관찰한다. 용해가 완료되면 펌프를 가동하여 염수 저장탱크로 이송한다. 이송한 소금물을 일정 시간 방치한 후, 부유물(浮遊物)을 망으로 걸러낸다. 소금물 안에 있는 고형물(固形物)을 걸러내기 위하여 여과기를 통과시킨 후 다음 공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"염수조제원","certLic":"식품산업기사, 식품가공기능사","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006159:1', '{"dJobCd":"K000006159","dJobCdSeq":"1","dJobNm":"요리당제조원","workSum":"요리당(액상당)을 제조하기 위하여 정제기, 전하반응조(반응탱크) 등의 관련 제조설비를 조작한다.","doWork":"원당이 최종적으로 정제되면 제어실에서 펌프조정장치를 가동해 정제액을 조제탱크에 받아낸다. 탱크에 중백당(中白糖), 덱스트린(Dextrin:호정), 식품용염산, 가성소다 등의 첨가제를 일정 비율로 넣는다. 제어실에서 스팀장치를 가동하여 일정한 온도까지 가열해 전하반응시킨다. 반응이 되면 조정장치를 조작해서 냉각밸브를 열고 자동냉각시켜 일정 기간 동안 저장탱크에 저장한 후 수송용 차량(Tank Rolley)에 실을 수 있도록 조치한다. 작업 전후로 저장탱크, 스팀 등 관련 장치와 설비를 고온수 밸브를 열어 살균한다. 작업의 경과 및 종료 상황을 작업일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"액상과당제조원, 요리엿제조원, 물엿제조원","connectJob":"맛술제조원","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003999:1', '{"dJobCd":"K000003999","dJobCdSeq":"1","dJobNm":"용당제조원","workSum":"세당(洗糖)을 정제하고자 온수나 저농도의 설탕액에 세당을 혼합·가열하여 용당액(세척한 원당을 뜨거운 물에 완전히 녹인 갈색의 혼탁한 당액)을 제조한다.","doWork":"용당탱크에 세당과 온수(또는 저농도의 설탕액)를 투입한 후 작업표준에 따라 일정 온도로 가열하여 용해한다. 자동화된 기계의 조정패널에 온수의 투입량, 교반기의 가동시간, 냉각수의 급수량 등을 직접 입력하기도 한다. 압력계, 온도계를 관찰하여 용해상태를 점검하고, 필요시 수동으로 온도와 압력조절 밸브를 조작하여 적정 온도와 압력을 유지한다. 용해가 완료되면 조정판을 조작하여 용당탱크 내의 압력과 온도를 낮추고, 펌프를 가동하여 용당액을 정제·탈색공정의 포충탑으로 자동 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"용당탱크운전원","certLic":"식품산업기사, 식품가공기능사","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003867:1', '{"dJobCd":"K000003867","dJobCdSeq":"1","dJobNm":"원심분리기조작원","workSum":"동·식물성 유지에서 고체불순물과 물을 제거하는 원심분리기를 조작한다.","doWork":"원심분리기의 회전속도, 온도, 압력을 조정판에 입력한다. 원심분리기의 재킷(Jacket:주입구)에 증기를 주입하여 일정한 온도를 유지하고 이송밸브를 열어 유지가 일정하게 흐르도록 유지한다. 분리기의 회전수 및 온도계와 압력계를 확인한다. 분리가 완료된 유지를 저장탱크로 이송하는 밸브를 조작하여 이송한다. 작업이 완료되면 솥, 세제, 물호스 등을 사용하여 분리기와 탱크를 세척하고 작업장 주위를 청소한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|고온|다습|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C104","dJobICdNm":"[C104]동물성 및 식물성 유지 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001587:1', '{"dJobCd":"K000001587","dJobCdSeq":"1","dJobNm":"원염용해조조작원","workSum":"염료에 필요한 순수한 염수를 제조하고자 원료염(공업용 소금)을 정제하는 장치(용해, 반응, 침전, 여과, 정제)를 조작·관리한다.","doWork":"염(공업용 소금)탱크의 배출구를 열고 원염을 포화조에 충진한다. 작업지시서에 명시된 회수염수와 원염과의 배합비를 확인하고 회수염수밸브를 열어 일정량의 염수를 하단으로부터 통과시켜 염수농도를 조절한다. 가성소다, 탄산, 응집제 등을 계량하여 염수 반응조에 투입하고 계기판의 염수농도를 확인한다. 반응기의 조정판에 반응온도를 입력하고 가동한다. 일정 시간 반응 후 염수가 표준에 적합한지 견본을 채취하여 농도를 분석하고 일정 시간 침전시킨 후 침전상태를 육안으로 관찰한다. 반응조 하단에 위치한 배출밸브를 열고 침전된 슬러지를 제거한다. 슬러지를 제거한 후 계량된 여과 조제액을 여과공급탱크에 투입하여 통과시킨 후 염수밸브를 열고 염수를 통과시킨다. 여과가 완료된 염수를 이온교환수지탑으로 이송하기 위해 밸브를 열고 펌프를 가동한다. 이온교환수지탑을 거쳐 정제된 염수에 일정량의 염산을 첨가하여 염수의 pH를 제품 표준과 맞춘다. pH가 맞추어진 염수를 전기분해해 가성소다, 염소, 수소를 얻는 전해공정으로 이송하고자 밸브를 열고 펌프를 가동한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|","workEnv":"위험내재|고온|다습|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"브라인(Brine)근무자","certLic":"위험물산업기사, 위험물기능사","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C201","dJobICdNm":"[C201]기초 화학물질 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002238:1', '{"dJobCd":"K000002238","dJobCdSeq":"1","dJobNm":"유지압착기조작원","workSum":"참기름, 들기름 등의 유지를 제조하고자 원료를 볶고 압착하는 기계를 조작한다.","doWork":"세척한 참깨, 들깨 등의 원료를 조리솥에 넣고 조리솥을 가열한다. 스크루(Screw)가 부착된 전동기를 가동하거나 주걱으로 휘저으며 원료가 타지 않도록 균일하게 볶는다. 볶은 원료를 압착기에 일정량 쏟아 넣고 압력을 조절하여 압착한다. 압출기의 배출구를 용기에 놓고 압출기로 짜여진 기름을 받는다. 원료 찌꺼기를 빼내어 증기로 가열한 후 재압착하여 기름을 짠다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|고온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"참기름초임계추출기조작원","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C104","dJobICdNm":"[C104]동물성 및 식물성 유지 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005854:1', '{"dJobCd":"K000005854","dJobCdSeq":"1","dJobNm":"이성화반응장치조작원","workSum":"포도당액과 알칼리를 혼합하여 과당으로 이성화하는 반응장치를 조작·관리한다.","doWork":"반응탱크의 밸브를 열고 펌프를 가동하여 농축된 포도당 용액을 주입한다. 유량계를 확인한 후 자동계량펌프를 가동하여 일정량의 암모니아수나 가성소다 등의 알칼리 또는 이성화효소를 반응탱크로 투입한다. 반응탱크 내를 진공상태로 만들고 교반기를 가동하여 포도당 용액과 이성화효소를 일정 시간 혼합하여 반응시킨다. 반응이 완료되면 배출구를 열고 이송펌프를 가동하여 혼합액을 열교환기로 이송한다. 각종 게이지를 관찰하며 밸브와 조정장치를 조절하여 규정된 온도와 진동압력을 유지한다. 견본추출밸브를 열고 견본을 채취하여 과당함유량, 산도 등을 검사한다. 이성화된 용액을 이온교환수지탑으로 이송하여 불순물을 제거하고 저장탱크로 이송한다. 자동화된 기계의 조정판에 알칼리의 투입량, 진공도, 혼합시간 등을 입력하여 이성화되는 과정을 관찰·조절하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"이성화반응장치조정판조작원","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C106","dJobICdNm":"[C106]곡물가공품, 전분 및 전분제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006502:1', '{"dJobCd":"K000006502","dJobCdSeq":"1","dJobNm":"이온교환수지탑조작원","workSum":"흡착탑에서 정제된 당액(연한 황색)을 투명한 당액으로 탈색하고자 이온교환수지탑을 조작·관리한다.","doWork":"이온교환수지탑 내부의 온도가 일정하게 유지되는지 확인·점검한다. 중앙통제실(CCR)에서는 당액을 이온교환수지층에 통과시켜 이온성 불순물과 색을 흡착되도록 통제한다. 자동화된 공정에 이상이 발생해 통제실의 호출이 있을 때, 현장에 투입하여 적절한 조치를 취한다. 정기적으로 이온교환수지의 탈색 여부를 검사하여 필요시에 교체하고, 수거된 이온교환수지는 소금물을 사용하여 세척한다. 자동화된 기계의 조정판에 당액의 투입량, 수지탑의 온도, 탈색시간 등을 입력하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"수지탑조정판조작원","certLic":"식품산업기사, 식품가공기능사","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004563:1', '{"dJobCd":"K000004563","dJobCdSeq":"1","dJobNm":"인삼농축액제조원","workSum":"인삼차, 인삼음료 등을 제조하기 위해 인삼농축액을 제조하는 기계를 조작·관리한다.","doWork":"추출탱크에 미삼(尾蔘:약재, 식료품, 기호식품의 재료로 사용되는 인삼의 잔뿌리)과 희석된 주정(추출용매)을 적정 비율로 투입한 후, 추출탱크의 온도, 가열시간을 입력하고 가동한다. 추출이 완료되면 침전탱크로 이송해 일정 시간 침전시킨 후, 밸브를 열어 액상(추출액)과 고체상(침전물)을 분리한다. 분리된 추출액은 규정농도의 용액을 제조하고자 진공농축기로 이송한 후, 진공농축기의 조정판에 온도, 시간을 입력시킨 후 가동하여 농축시킨다. 농축이 완료된 농축액은 견본을 채취하여 비중, 농도를 검사하고 제품 표준과 비교한다. 배출밸브를 열고 펌프를 가동하여 저장탱크로 농축액을 이송한다. 인삼농축분말을 제조하고자 농축액을 열풍건조하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"인삼과립기조작원","certLic":"식품산업기사, 식품가공기능사","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C107/C112","dJobICdNm":"[C107]기타 식품 제조업 / [C112]비알코올음료 및 얼음 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002299:1', '{"dJobCd":"K000002299","dJobCdSeq":"1","dJobNm":"인삼편제조원","workSum":"인삼편을 제조하고자 수삼을 세척·세절·침지·건조하는 장비를 조작·관리한다.","doWork":"이물질을 제거하고자 일정량의 수삼(생삼:75% 정도의 수분을 함유한 말리지 않은 인삼)을 세척탱크에 담가 세척한다. 세척이 완료된 수삼은 칼을 사용하여 잔뿌리를 제거한다. 제품규격에 맞는 인삼편을 제조하고자 절단기의 칼날 간격을 조절한다. 절단된 인삼편은 품질을 향상시키고 향기를 주기 위하여 포도당 용액이 담긴 용기에 넣어 일정 시간 동안 담가둔다. 포도당 용액이 흡수된 인삼편을 건조기에 넣어 규정된 수분함량이 되도록 건조한다. 수삼을 길게 절단하여 꿀에 침지·건조하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"인삼정과제조원","certLic":"식품산업기사, 식품가공기능사","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005430:1', '{"dJobCd":"K000005430","dJobCdSeq":"1","dJobNm":"잎담배가습기조작원","workSum":"잎담배의 주맥분리와 불순물의 선별이 용이하도록 수분을 흡수시켜 잎을 펴는 가습기를 조작한다.","doWork":"미건조 잎담배를 건조하기 위해 가습기의 증기밸브를 열어 실린더의 온도를 일정하게 조작한다. 가습기의 가동상태를 점검하고 증기분사노즐을 점검한다. 지게차, 호이스트 등을 이용하여 미건조 잎담배를 가습기 안으로 투입한다. 조정판의 스위치를 조절하여 잎담배의 투입량, 증기분사노즐의 분사량, 가습시간 등을 입력하고 기계를 가동한다. 가습된 잎담배의 견본을 채취하여 수분함유량 및 펴진 상태를 점검하고, 최적의 가습상태를 유지하고자 조정판을 재조정한다. 작업이 완료되면 이송장치를 가동하여 가습된 잎담배를 다음 공정으로 운반하고 가습기에 투입된 잎담배의 수량을 작업일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"순엽가습기조작원, 주맥가습기조작원, 토스트가습기조작원, 판상엽가습기조작원","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C120","dJobICdNm":"[C120]담배 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002300:1', '{"dJobCd":"K000002300","dJobCdSeq":"1","dJobNm":"잎담배공급기조작원","workSum":"담배를 제조하고자 배합표준에 따라 원료 잎담배를 공급하는 공급기를 조작한다.","doWork":"습도조절 및 가공이 끝난 원료 잎담배를 인수된 순서대로 작업장에 정리한다. 공급기의 회전날을 가동하여 공수기로 투입된 잎담배를 균일하게 절단한다. 공수기를 가동하여 등급에 따라 일정 비율로 혼합된 잎담배를 궐련 제조공정으로 운반한다. 작업표준에 따라 단위투입량을 조절하고 투입한 잎담배의 등급표찰을 수거하여 중량과 등급을 작업일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"균형감각|","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"외산엽공급기조작원, 제맥엽공급기조작원, 주맥공급기조작원, 판상엽공급기조작원","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C120","dJobICdNm":"[C120]담배 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006233:1', '{"dJobCd":"K000006233","dJobCdSeq":"1","dJobNm":"잎담배배합원","workSum":"잎담배의 품종, 엽분, 등급에 따라 배합표준에 의거 일정 비율로 배합한다.","doWork":"차분(퇴적 사일로 1실 분량)별로 잎담배를 엽종, 엽분, 등급별로 분류한다. 배합조견표를 확인하고 공수기의 가동상태를 점검한다. 조정판의 스위치를 조절하여 잎담배의 등급별 투입량, 배합시간, 배출량 등을 입력하고 기계를 가동한다. 수시로 견본을 채취하여 배합상태를 확인하고 배합조견표와 대조하여 일정한 배합이 이루어지도록 조정판의 스위치를 재조절한다. 작업이 완료되면 작업장 주위의 이물질을 제거하고 배합에 투입된 잎담배의 수량과 등급을 작업일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C120","dJobICdNm":"[C120]담배 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003890:1', '{"dJobCd":"K000003890","dJobCdSeq":"1","dJobNm":"잎담배절각기조작원","workSum":"잎담배를 표준규격으로 절단하여 혼합 및 조화하는 기계를 조작한다.","doWork":"작업물의 절단규격을 확인하고 엽초를 투입하는 공수기의 가동상태를 점검한다. 절각기의 칼날과 기계작동의 이상 유무를 점검한다. 각초(잎담배를 잘게 자른 것)의 투입량, 절단속도, 절단된 각초의 배합비율 등을 입력하고 조정판의 스위치를 조절하여 기계를 가동한다. 각초의 이물질을 검출하는 금속검출기를 가동하고 수시로 세각초의 견본을 채취하여 절단규격을 검사한다. 세각초의 배합상태를 점검하고 이물질의 혼입 여부를 검사한다. 작업이 완료되면 절단칼날의 이상 유무를 확인한다. 투입한 각초의 수량과 등급을 작업일지에 기록한다. 고장 시 응급조치를 취한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C120","dJobICdNm":"[C120]담배 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004228:1', '{"dJobCd":"K000004228","dJobCdSeq":"1","dJobNm":"잎담배퇴적기조작원","workSum":"전처리(배합, 가습, 가향, 조습)된 잎담배에 향액과 수분을 혼합하고 퇴적하는 기계(퇴적기)를 조작한다.","doWork":"전처리된 잎담배의 수분함유량 및 품질을 확인하고 퇴적탱크의 기준 온도와 습도를 점검한다. 잎담배를 이송하는 컨베이어의 가동상태를 점검한 후 조정판의 스위치를 조절하여 잎담배의 투입량, 교반기의 회전속도, 시간별 분출량 등을 입력하고 기계를 가동한다. 혼합되어 분출되는 잎담배의 상태를 점검하고 수시로 견본을 채취하여 퇴적상태를 검사한다. 작업이 완료되면 퇴적조에 투입된 잎담배의 수량과 분출량을 작업일지에 기록한다. 고장 시 응급조치를 취한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C120","dJobICdNm":"[C120]담배 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006740:1', '{"dJobCd":"K000006740","dJobCdSeq":"1","dJobNm":"전분당화장치조작원","workSum":"전분유를 포도당으로 전환시키기 위하여 전분액을 당화하는 설비를 조작·관리한다.","doWork":"당화탱크에 정제된 전분인 전분유를 투입한다. 전분유를 당화시키기 위하여 산을 첨가하고 교반기로 혼합한다. 일정 시간 혼합되어 당화된 전분유에 일정 비율의 알칼리용액을 투입하여 중화시킨다. 중화된 전분유를 여과장치를 통과시켜 중화 시 형성된 단백질 등을 걸러낸다. 여과공정을 거친 전분유를 액화시키기 위해 액화조의 재킷(Jacket)이나 순환관에 증기를 투입하여 규정 온도로 가열하고 진공펌프를 이용하여 진공상태를 유지한다. 액화조 내부로 전분유를 분사하여 순간고온으로 팽창시키고, 액화효소 투입밸브를 열어 효소를 투입한다. 액화된 전분액을 당화효소와 반응할 수 있도록 증기밸브와 산투입밸브를 조절하여 산도와 온도를 맞춘다. 당화반응 시간을 단축하고자 교반기를 가동한다. 견본 채취밸브를 통해 견본을 채취하여 포도당 함량을 측정한다. 적정함량에 도달하면 활성탄을 이용하여 탈색시킨다. 자동화된 기계의 조정판에 산·알칼리의 투입량, 교반시간, 진공도, 이온교환 수지 투입량 등을 입력하여 가공되는 과정을 관찰·조절하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"당화장치조정판조작원","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C106","dJobICdNm":"[C106]곡물가공품, 전분 및 전분제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002183:1', '{"dJobCd":"K000002183","dJobCdSeq":"1","dJobNm":"정제당증발기조작원","workSum":"정제과정을 거친 낮은 농도의 당액을 보다 높은 농도로 농축하고자 정제당증발기를 조작·관리한다.","doWork":"정제과정을 거친 묽은 당액을 정제당증발기에 투입한다. 증발관을 일정 온도로 가열하고자 증기밸브를 돌려 순환관으로 증기를 투입한다. 증발관의 내부에 당액을 분무하는 노즐을 점검하고 당액 투입밸브를 조절하여 분무량을 조절한다. 당액의 농도를 정해진 수준까지 높인 후, 견본을 채취하고 농축도를 검사한다. 농축이 완료되면 결정공정으로 농축당액을 자동 이송한다. 정제당증발기의 조정판에 온도·압력, 당액의 투입량, 농축도 등을 직접 입력하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"농축공정(EVA)작업원, 증발관조정판조작원","certLic":"식품산업기사, 식품가공기능사","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005819:1', '{"dJobCd":"K000005819","dJobCdSeq":"1","dJobNm":"정제반장","workSum":"설탕을 제조하고자 원당을 여과하고 정제하는 데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"원당의 품질 및 국적을 확인하고 제품별 배합비를 작업표준과 비교·점검한다. 정제에 사용되는 장치의 이상 유무와 여과포, 활성탄, 세라믹필터, 이온교환수지 등 소모품의 교체필요 등을 확인하고 교체시기를 결정한다. 작업내용에 따라 작업원에게 지시·배치한다. 작업의 진행사항을 파악하고 작업내용을 보고한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원 및 자재를 공급한다. 작업계획에 따라 세부실행항목을 수립하고 작업절차 및 방법을 결정하여 작업원에게 작업내용을 지시하고 작업배치를 한다. 표준작업명세에 따라 지시된 작업이 이루어지는지 작업원과 함께 작업하며 작업상황을 관찰하고 작업내용을 점검한다. 작업원의 직무교육 및 안전위생교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴·해결하고 문제점을 보완한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|","workEnv":"고온|저온|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","certLic":"식품가공기능사, 식품산업기사","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005802:1', '{"dJobCd":"K000005802","dJobCdSeq":"1","dJobNm":"정제염제조원","workSum":"정제염(精製鹽:원염을 녹여서 불순물을 제거하고 재결정시킨 재제염)을 제조하고자 용해탱크, 가열탱크 등을 조작·관리한다.","doWork":"일정량의 가공염을 가공염 저장탱크로부터 용해탱크로 이송한다. 불순물(인체에 유해한 간수, 비소, 납, 수은, 카드뮴 등)과 순수한 염 성분을 분리하고자 용해탱크에 물을 채워서 용해한다. 가열탱크의 내부에 숯, 모래, 천 등을 깐다. 펌프를 사용해 용해가 완료된 소금물을 가열탱크로 이송한 후, 소금물 위의 부유물(浮遊物)을 제거한다. 가열탱크를 작동시켜 소금물을 가열한 후 수분과 소금결정을 분리한다. 소금결정을 채취해서 용기에 담고 일정 시간 건조시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"식품산업기사, 식품가공기능사","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002370:1', '{"dJobCd":"K000002370","dJobCdSeq":"1","dJobNm":"종묘배양원","workSum":"화학조미료 제조용 당밀을 발효시키기 위하여 종균을 배양하는 설비를 조작·관리한다.","doWork":"배양조를 살균하고자 증기밸브를 돌려 재킷(Jacket)에 증기를 투입한다. 미생물 배양에 필요한 요소, 무기질, 비타민 등을 계량한다. 배양조의 밸브를 조절한 후 뚜껑을 열고 조제수와 당밀을 투입한다. 배양에 맞는 산도를 맞추기 위하여 일정 비율의 중화제(가성소다 등)를 투입하고 증기를 투입하여 살균한다. 종균의 번식에 맞는 온도를 유지하고자 냉각수밸브를 돌려 순화관에 냉각수를 투입하고 비커나 계량용기를 사용하여 일정량의 종균을 투입한다. 배양이 용이하도록 교반기를 가동한다. 배양이 완료되면 견본을 채취하여 산도, 균체의 수, 당도 등을 검사하고 제품 표준과 비교한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"식품산업기사, 식품가공기능사","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001678:1', '{"dJobCd":"K000001678","dJobCdSeq":"1","dJobNm":"주맥압전기조작원","workSum":"주맥만 남은 엽초를 표준두께로 압착하는 주맥압전기를 조작한다.","doWork":"주맥압전기의 운반장치, 압착장치, 공기압력 등을 점검하고 컨베이어의 이송속도를 확인한다. 조정판의 스위치를 조절하여 주맥의 투입량, 압착시간, 압착량 등을 입력하고, 기계를 가동하여 압착되는 상태를 관찰·조절한다. 주맥의 투입상태를 점검하여 이물질을 제거한다. 압착되어 배출되는 주맥의 견본을 채취하여 규격을 검사하고 표준두께를 유지하도록 조정판을 조절한다. 작업이 완료되면 주맥의 투입량, 압착시간, 압착규격 등을 작업일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|다습|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C120","dJobICdNm":"[C120]담배 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006559:1', '{"dJobCd":"K000006559","dJobCdSeq":"1","dJobNm":"키토산올리고당제조원","workSum":"키토산올리고당을 제조하고자 분말 키토산을 용해·효소분해·살균·건조·농축하는 기계를 조작·관리한다.","doWork":"분말 키토산(Chitosan)을 용해탱크에 일정량 투입하고 물과 유기산(젖산, 초산 등)을 첨가한 후 용해탱크를 가동한다. 용해가 완료되면 견본을 채취하여 점도를 확인하고 펌프를 가동하여 효소반응기로 이송한다. 효소반응기의 조정판을 작업표준에 따라 조정하고 효소를 첨가하여 효소반응기를 작동시킨다. 효소반응기 내부의 온도, 시간, pH 등을 수시로 점검하여 발효가 정상적으로 이루어지는지를 살핀다. 반응이 완료되면 펌프를 가동하여 여과막과 살균기를 통과시키고 농축기로 이송한다. 농축도를 검사하여 일정한 농도의 키토산올리고당(키틴과 키토산을 가수분해하여 분자크기를 작게 만든 것)이 완성되면 건조과정을 거친 후 저장실로 이송하고 견본을 채취하여 실험실로 보낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"식품산업기사, 식품가공기능사","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007219:1', '{"dJobCd":"K000007219","dJobCdSeq":"1","dJobNm":"탈용제기조작원","workSum":"사료용 탈지박(기름성분이 빠진 콩껍질)에 포함된 용제를 제거하고자 진공고온으로 가열하여 용제를 제거하는 설비를 조작한다.","doWork":"용제를 제거하고자 진공펌프를 가동하여 탈용제기 내부를 진공 압력상태로 만들고 고온의 증기를 이용하여 탈용제기 내부 온도를 올린다. 이송컨베이어를 가동하여 탈지박의 투입량을 조절하며 투입한다. 용제가 제거되어 배출구로 나오는 탈지박의 견본을 채취하여 용제의 함유상태를 점검한다. 작업한 수량을 작업일지에 기록한다. 자동화된 기계의 조정판에 진공압력, 온도, 투입량 등을 입력하여 가공되는 과정을 관찰·조절하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C108","dJobICdNm":"[C108]동물용 사료 및 조제식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005526:1', '{"dJobCd":"K000005526","dJobCdSeq":"1","dJobNm":"포도당결정기조작원","workSum":"농축된 당화전분액을 포도당 결정으로 제조하고자 결정입자를 생성시키는 결정기를 조작·관리한다.","doWork":"결정관 내부를 증기를 이용하여 일정 온도로 가열하고 진공펌프를 가동하여 진공상태로 만든다. 압력계, 온도계, 유량계 등을 확인하여 제품 표준에 명시된 규격으로 농축한다. 농축이 완료되면 결정입자를 생성시키기 위하여 저장탱크의 포도당 분말을 투입한다. 과포화 상태에서 결정이 생성되도록 당액과 물을 투입하는 밸브를 조절하면서 교반기를 가동하여 포도당 결정 제조가 용이하게 한다. 결정이 생성되면 결정입자를 원심분리기로 이송한다. 결정입자와 비결정입자가 분리되면 비결정입자는 회수하여 당화공정으로 이송하고 결정입자는 수세과정을 거친 후 열풍건조기로 이송하여 건조시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"결정포도당제조기조작원","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C106","dJobICdNm":"[C106]곡물가공품, 전분 및 전분제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003404:1', '{"dJobCd":"K000003404","dJobCdSeq":"1","dJobNm":"한천제조원","workSum":"한천을 제조하고자 우뭇가사리, 꼬시래기 등의 홍조류 해초를 자숙·여과·응고·동결·탈수·건조하여 선별한다.","doWork":"우뭇가사리를 세척하여 염분, 자갈, 모래 등의 이물질을 제거한다. 세척한 우뭇가사리를 솥에 투입하고 가열하여 삶아 한천성분을 추출한다. 삶은 용액을 여과시켜 이물질을 제거한다. 여과액을 열교환기를 통해 식힌 후 응고시킨다. 응고된 우무묵을 동결한 후 녹여 탈수한다. 건조기에 투입하여 건조한 후 이물질 등을 선별하여 제거한다. 제조가 끝난 한천을 포장공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|","workEnv":"대기환경미흡|고온|저온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C102","dJobICdNm":"[C102]수산물 가공 및 저장 처리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003385:1', '{"dJobCd":"K000003385","dJobCdSeq":"1","dJobNm":"화학간장제조원","workSum":"화학간장을 제조하기 위하여 압착, 분리된 간장을 여과·배합·냉각하는 설비를 조작·관리한다.","doWork":"순환관에 증기를 투입하여 분해탱크를 가열한 후, 밸브를 조절하여 단백질 원료(탈지대두:대두 중 지질을 추출한 것)를 투입한다. 단백질 원료(탈지대두)를 산분해하고자 일정 비율의 희석된 염산을 투입한 후 혼합이 용이하도록 교반기를 가동한다. 분해가 완료되면, 중화하고자 일정 비율의 가성소다 또는 탄산소다를 투입한다. 중화가 완료되면 압착공정으로 이송한 후, 여과된 아미노산간장에 과당, 캐러멜 등을 일정 비율로 투입한 후 교반기를 가동한다. 고형분(固形粉)이 제거된 아미노산간장의 세균을 살균하고자 살균탱크를 가열한 후, 이물질을 제거하고자 규조토가 부착된 여과기로 이송한다. 살균이 완료되면 실온에서 일정 시간 동안 냉각한다. 견본을 채취하여 향, 맛, 색 등을 제품 표준과 비교·검사하고 미생물검사를 한다. 색과 맛을 조정하기 위한 설비를 조작하기도 한다. 살균탱크의 배출밸브를 열고 포장공정으로 간장을 자동 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"양조간장제조원","certLic":"식품산업기사, 식품가공기능사","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002053:1', '{"dJobCd":"K000002053","dJobCdSeq":"1","dJobNm":"회전증자기조작원","workSum":"양조간장을 제조하고자 탈지대두를 가열·증자하는 기계를 조작·관리한다.","doWork":"작업표준에 따라 자동 계량된 탈지대두와 일정 비율의 물을 증자기에 투입한다. 증자기의 조정판에 원료의 투입량, 가열온도, 급수량, 증자기의 회전속도 등을 입력하고 작동상태를 점검한다. 증자기를 가동해 재료를 가열·증자하면서, 증자기 내 온도, 압력이 일정하게 유지되는지 수시로 관찰하고 필요시 조치를 취한다. 증자가 완료되면 견본을 채취하여 작업표준과 비교·검사한다. 증자된 탈지대두는 콩단백질의 과도한 변형을 막기 위해 냉각과정을 거친 뒤 제국(製麴:증자된 탈지대두와 할쇄된 밀을 혼합하고 국균을 접종)공정으로 자동 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"증자기조정판조작원","certLic":"식품산업기사, 식품가공기능사","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003160:1', '{"dJobCd":"K000003160","dJobCdSeq":"1","dJobNm":"흡착탑조작원","workSum":"여과된 당액의 불순물과 색을 흡착·정제하고자 입상활성탄이 충진된 흡착탑을 조작·관리한다.","doWork":"흡착탑 내부에 적정량의 입상활성탄을 충진한 후 예열시킨다. 원당여과기를 통과한 여과액(짙은 황색의 당액)이 흡착탑을 통과하도록 하여, 당액의 불순물과 색을 입상활성탄에 흡착시킨다. 흡착이 잘 이루어지는지를 수시로 검사하고 흡착탑 내부의 이물질을 제거하며 흡착률이 떨어지는 입상활성탄을 교체한다. 흡착이 완료된 당액(연한 황색의 당액)을 세라믹 여과공정으로 자동 이송한다. 자동화된 기계의 조정판에 용액의 투입량, 흡착탑의 온도 등을 입력하여 정제되는 과정을 조절하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"식품산업기사, 식품가공기능사","dJobECd":"8739","dJobECdNm":"[8739]기타 식품가공 기계 조작원","dJobJCd":"8190","dJobJCdNm":"[8190]기타 식품가공 관련 기계 조작원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006913:1', '{"dJobCd":"K000006913","dJobCdSeq":"1","dJobNm":"가성소다제조원","workSum":"비스코스 레이온(Viscose Rayon) 등의 제조공정에서 쓰이는 가성소다의 농도, 비중 등을 규정농도에 맞게 조정 및 조제하고 공급한다.","doWork":"소다(NaOH)를 담금압착기를 조작하여 제조공정에 필요한 농도에 맞게 조정 및 조제한다. 펄프 침지 농도로 담금압착기를 조절하고 유산망간(MnSo4)을 투입하여 가성소다로 만든다. 가성소다의 농도, 비중 등을 분석하고 각 공정에 필요한 농도에 맞게 공급한다. 열교환기를 조작하여 공정별로 공급되는 가성소다의 적정온도를 유지하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"소다회수원","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C205","dJobICdNm":"[C205]화학섬유 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005511:1', '{"dJobCd":"K000005511","dJobCdSeq":"1","dJobNm":"가연기운전원","workSum":"신축성이 있는 스트레치(Stretch) 실을 제조하는 가열장치와 가연스핀들이 장치된 연사기를 조작한다.","doWork":"가연기의 이상 유무를 파악하고 가열장치의 온도를 가공할 수 있는 온도로 유지한다. 실을 기계의 크릴(Creel)에 끼우고 지관을 기계 상부의 걸대에 끼운다. 가공될 실을 가이드와 공급롤러, 가열장치를 통해 가연스핀들의 유입휠과 트래버스(Travers) 안내대를 거쳐 권취지관에 감기게 한다. 기계를 가동하여 가공·권취상태를 관찰한다. 가공 권취된 지관을 빼내 다음 공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C205","dJobICdNm":"[C205]화학섬유 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004532:1', '{"dJobCd":"K000004532","dJobCdSeq":"1","dJobNm":"가호반장","workSum":"경사에 호부제(풀)를 처리하는 데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"작업지시서를 숙지하고 규정된 실의 본수 등을 확인한다. 수시로 기계의 성능상태를 확인하고 생산량을 기록한다. 작업의 진행사항을 파악하고 작업내용을 보고한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원 및 자재를 공급한다. 작업계획에 따라 세부실행항목을 수립하고 작업절차 및 방법을 결정하여 작업원에게 작업내용을 지시하고 작업배치를 한다. 표준작업명세에 따라 지시된 작업이 이루어지는지 작업원과 함께 작업하며 작업상황을 관찰하고 작업내용을 점검한다. 작업원의 직무교육 및 안전위생교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴·해결하고 문제점을 보완한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|고온|다습|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","similarNm":"호부반장","certLic":"섬유산업기사","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C132","dJobICdNm":"[C132]직물직조 및 직물제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002302:1', '{"dJobCd":"K000002302","dJobCdSeq":"1","dJobNm":"가호원","workSum":"호부제를 경사에 침투시키거나, 직기 빔에 호부가 완료된 실을 감는 기계를 조작한다.","doWork":"호이스트를 사용하여 빔을 걸대 위에 올려놓는다. 경사의 끝을 모아서 기계의 실을 연결하고 호부통을 통과시켜 건조원형통 주위와 직기 빔에 감기도록 연결한다. 실이 교체되는 올 사이에 사침대를 삽입하여 실이 엉키는 것을 방지한다. 직기 빔에 균등하게 배열되도록 호부바디 사이에 실을 한 올씩 배열한다. 섬유에 따라 다른 종류의 호부제를 통 안에 놓고 건조 실린더에 증기를 투입하기 위해 증기 밸브를 연다. 직기 빔에 감긴 길이를 나타내는 길이측정기를 조정한다. 기계를 가동하고 기계를 통과하는 경사의 흐름을 살피면서 실의 결함이나 엉킨 것을 찾아낸다. 엉킨 실을 풀어놓고 끊어진 실은 잇는다. 실에 대한 호부제의 점착도를 촉감으로 확인하고 실의 건조처리가 완전한가를 확인하다. 경사에 사침줄을 삽입하여 실을 분리하고 풀림을 방지하기 위해 테이프를 사용하여 빈 빔으로 교체한다. 섬유 및 호부제의 종류에따라 제어판에 있는 온도조절표를 바꿔 입력하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|고온|다습|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"호부대지원, 호부원","certLic":"섬유산업기사","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C132","dJobICdNm":"[C132]직물직조 및 직물제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006325:1', '{"dJobCd":"K000006325","dJobCdSeq":"1","dJobNm":"권사반장","workSum":"정방에서 생산된 관사의 결점을 제거하고 콘(Cone) 또는 치즈(Cheese) 형태로 감는 데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"권사기의 작동상태를 점검한다. 작업계획에 따라 세부실행항목을 수립하고 작업절차 및 방법을 결정하여 작업원에게 작업내용을 지시하고 작업배치를 한다. 기계와 장비의 조작방법을 새로운 작업원에게 훈련시키고, 작업 실적을 평가한다. 작업의 진행사항을 파악하고 작업내용을 보고한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원 및 자재를 공급한다. 표준작업명세에 따라 지시된 작업이 이루어지는지 작업원과 함께 작업하며 작업상황을 관찰하며 작업내용을 점검한다. 작업원의 직무교육 및 안전위생교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴·해결하고 문제점을 보완한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","certLic":"섬유산업기사","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001724:1', '{"dJobCd":"K000001724","dJobCdSeq":"1","dJobNm":"권사틀보기원","workSum":"후가공, 출하, 저장 등을 위해 콘(Cone), 치즈(Cheese)) 등의 형태로 실을 감는 기계를 조작한다.","doWork":"스핀들이나 홀더에 공급 실 꾸러미를 배치한다. 각각의 실 꾸러미로부터 실 끝을 가이드(Guide)와 장력기구를 통해 지관에 부착한다. 감기는 상태를 관찰하고, 끊어진 실을 손이나 매듭기(Knotter)를 사용하여 잇는다. 일정량의 실이 감기면 타래가 엉키지 않도록 면실을 사용하여 묶는다. 기계를 정지하고, 다 감긴 실 꾸러미를 빼낸다. 감긴 실의 이상 여부를 확인한다. 실 꾸러미의 무게를 계량하고, 생산량을 확인하여 기록한다. 실을 연하게 하거나 질기게 하고 실의 잔털을 없애기 위해 유상액이나 초(파라핀)을 통해 실을 감는 기계를 다루기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"권사원","certLic":"섬유산업기사","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007271:1', '{"dJobCd":"K000007271","dJobCdSeq":"1","dJobNm":"권축기운전원","workSum":"합성섬유의 부피와 신축성을 높이고 자연섬유와의 혼방을 용이하게 하기 위해 주름을 잡는 기계를 조작한다.","doWork":"명세서에 따라 가공할 실의 형태 및 공정 등을 파악하고 권축기의 온도 및 압력을 조절한다. 롤러 사이로 섬유를 공급하여 가공상자를 통과한 섬유를 운반통에 담기게 한다. 가공상태를 점검하여 크림핑(Crimping)이 안 된 것을 찾아내고 공급롤러와 가공상자의 증기열 및 압력을 재조절한다. 운반통이 채워지면 새 것으로 교환하고 채워진 운반통은 다음 공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"크림핑기운전원","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C205","dJobICdNm":"[C205]화학섬유 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006706:1', '{"dJobCd":"K000006706","dJobCdSeq":"1","dJobNm":"권취원","workSum":"실이나 필라멘트사가 감긴 드럼(Drum)이나 보빈(Bobbin)을 기계에서 떼어내고 빈 드럼이나 보빈을 설치한다.","doWork":"실을 감기 위한 지관을 대차에 준비한다. 와이더(Winder:실감는 기계) 램프에 불이 들어오면 공기서커(Air Sucker) 또는 곡칼을 이용하여 실을 커트하고 와이더의 회전을 정지하고 지관을 떼어 대차(운반차)에 싣는다. 새 지관을 와이더에 끼우고, 에어건를 이용하여 실을 지관에 걸어준다. 사절이 발생하면 에어노즐면의 오염, 파손 상태를 점검한다. 생산된 제품에 생산번호를 부여하기 위해 대차에 기록표을 출력하여 지관 안쪽에 부착한다. 선별, 검사공정으로 생산된 실을 이동한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"투입인출","similarNm":"절사추처리원","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C205","dJobICdNm":"[C205]화학섬유 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002665:1', '{"dJobCd":"K000002665","dJobCdSeq":"1","dJobNm":"랩포머틀보기원","workSum":"고품질의 면사를 만들기 위해 슬리버 가닥들을 결합하여 리본 랩(Ribbon Lap)으로 말아주는 기계를 조작한다.","doWork":"목관을 기계에 투입하고 지지대에 목관을 지지시킨다. 슬리버 통을 크릴(Creel)위치에 배치하고, 슬리버의 끝을 안내대, 정지장치, 드래프트(Draft)롤 사이를 통과시켜 목관에 랩을 감는다. 작업기계 사이를 순회하며 슬리버가 끊어져 경고등이 켜 있거나 슬리버 통이 비어 있는지 관찰한다. 끊어진 슬리버나 랩을 잇는다. 일정 크기로 감긴 랩 롤을 기계로부터 떼어내어 운반차에 싣는다. 랩 롤을 정소면기로 운반하여 정소면기의 예비 랩 대 위에 올려놓는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"랩포머호대원, 정소면준비원, 코머준비원","certLic":"섬유산업기사","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004262:1', '{"dJobCd":"K000004262","dJobCdSeq":"1","dJobNm":"레이온방사원","workSum":"방사기를 통해 레이온(Rayon)을 방사하고 기계의 기능장애, 고장 등의 원인을 찾아내 수리·조절한다.","doWork":"작업지시서를 확인해 작업물량을 계획하고 사용될 레이온의 양을 파악한다. 사용될 기계의 이상 유무를 파악한다. 방사기에 이상이 있으면 결함을 파악하고 원인을 찾아내 부품을 교체하고 계기를 점검하고 재조절한다. 생산량과 수리된 파손된 부품을 작업일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|다습|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"레이온방사보전원","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C205","dJobICdNm":"[C205]화학섬유 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003817:1', '{"dJobCd":"K000003817","dJobCdSeq":"1","dJobNm":"롤러소제원","workSum":"정방기나 조방기의 톱 롤러(Top Roller)에서 나온 실 보푸라기와 먼지 등을 압축공기를 이용한 에어 컴프레서(Air Compressor) 또는 솔 등을 사용하여 청소한다.","doWork":"링 레일(Ring Rail)의 먼지와 실 보푸라기를 솔을 사용하여 제거한다. 정방기의 톱 롤러나 롤러 사이에 감긴 솜, 풍면 등을 기구를 사용하여 제거하거나 새로운 롤러로 교체한다. 작업 후 제품의 외관상 결함 및 상태를 검사하고 작업일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"설비보전기능사","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002742:1', '{"dJobCd":"K000002742","dJobCdSeq":"1","dJobNm":"목관세척원","workSum":"보빈이나 위관에 남아있는 실을 벗겨내는 기계를 조작한다.","doWork":"체인 호이스트 및 칼, 솔, 압축공기 등을 사용하여 보빈에서 실을 벗겨내는 기계의 호퍼에 보빈을 투입한다. 호퍼(Hopper:분립체의 저장 및 공급장치)와 공급 컨베이어 사이에서 보빈의 흐름을 조절하기 위해 갈퀴로 보빈을 밀거나 잡아당기고, 만관된 보빈이나 위관을 떼어낸다. 진동에 의해 방적실을 보빈으로부터 떼어내는 텀블러(Tumbler)에 체인 호이스트를 사용해 보빈을 투입한다. 깨끗이 손질한 보빈을 손수레로 창고에 운반하기도 한다. 목관을 색깔별로 분류하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"보빈클리너원","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002204:1', '{"dJobCd":"K000002204","dJobCdSeq":"1","dJobNm":"미연신사운반원","workSum":"방사공정에서 생산된 실의 굵기, 중량, 권취형태가 다른 미연신사(합성섬유를 제조할 때 용융액을 압출해서 만들어진 초기의 결정화도가 작고 무배향 또는 저배향도 상태인 것)를 권취공정에서 연사·연신공정으로 운반한다.","doWork":"미연신사가 감긴 보빈(Bobbin) 및 지관을 연사·연신공정으로 운반한다. 이송해온 보빈의 실 끝을 찾아 크릴 안내대, 가이드, 장력가이드를 거쳐 밑으로 내리고 덮개를 덮는다. 연신 또는 연사가 완료된 기계크릴의 덮개를 열고 보빈 및 지관을 빼낸다. 불량보빈 및 불량 실이 감긴 보빈을 찾아내어 관련 부서로 옮긴다. 보빈 및 지관을 스핀들에 걸거나 실걸이를 하는 등의 도핑(Doffing)작업을 지원한다. 기계청소 및 작업장의 정리·정돈을 하기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"로딩원","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C205","dJobICdNm":"[C205]화학섬유 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004574:1', '{"dJobCd":"K000004574","dJobCdSeq":"1","dJobNm":"방모반장","workSum":"방모의 선별, 조합, 소모, 검사 등의 공정에 종사하는 작업원의 활동을 감독·조정한다.","doWork":"생산계획표에 의해 방모의 선별, 가넷(Garnett), 조합, 소모공정의 작업계획을 세운다. 작업계획에 따라 세부실행항목을 수립하고 작업절차 및 방법을 결정하여 작업원에게 작업내용을 지시하고 작업배치를 한다. 투입원료의 방출성과, 검사결과 및 시험표를 점검하여 품질관리에 필요한 조치를 취한다. 생산량에 의한 공정 이행상 균형을 검토하고 현장을 순회하며 관리 상태를 점검한다. 작업의 진행사항을 파악하고 작업내용을 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","certLic":"섬유산업기사","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005141:1', '{"dJobCd":"K000005141","dJobCdSeq":"1","dJobNm":"방사반장","workSum":"화학섬유를 제조하고자 칩(Chip), 폴리머(Polymer) 등의 원료를 용융·압출·방사하는 데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"작업지시서를 확인하고 생산량, 생산품목, 시간계획 등의 생산계획을 세워 작업원의 업무를 할당하고 작동 중인 방사기의 상태 및 작업현황을 파악하고 기록한다. 작업계획에 따라 세부실행항목을 수립하여 작업절차 및 방법을 결정하고 작업원에게 지시한다. 작업원에 대한 직무교육(OJT) 및 안전위생교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴하고 문제점을 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"고온|다습|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","similarNm":"방적반장, 제사반장, 합사반장","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C205","dJobICdNm":"[C205]화학섬유 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002564:1', '{"dJobCd":"K000002564","dJobCdSeq":"1","dJobNm":"방사원","workSum":"합성섬유 필라멘트(Filament:장섬유)를 압출하여 권취기에 감는 기계를 조작한다.","doWork":"방사할 작업물량을 파악하고 방사기 및 권취기 등 관련 장비의 이상 유무를 파악한다. 방사노즐을 통과하는 가는 필라멘트가 계속 권취기로 투입되는지 기계의 작동상태를 점검한다. 권취공정 작업이 용이하도록 가이드를 통하여 필라멘트를 삽입한다. 압출과정에서 이상이 발생하면 기계를 중지하고 방사노즐을 청소한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|다습|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"방적원","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C205","dJobICdNm":"[C205]화학섬유 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003019:1', '{"dJobCd":"K000003019","dJobCdSeq":"1","dJobNm":"벌킹기운전원","workSum":"필라멘트사를 가공하여 구조를 바꾸고 부풀리는 벌킹기(Bulking Machine)를 조작한다.","doWork":"가공할 실의 구조 및 생산량을 파악한다. 기계의 크릴에 실을 연결하고 실 끝을 가이드, 공급롤러, 공기분사실, 장력장치 등을 통과시켜 권취실패에 일정 횟수 감는다. 공급롤러를 통해 공기분사실을 통과하는 필라멘트사에 압축공기를 쏴 필라멘트사의 구조를 바꾸고 부풀리게 한다. 실이 끊어지면 잇고 감긴 실패를 꺼낸다. 권취된 실패를 모아 다음 공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C205","dJobICdNm":"[C205]화학섬유 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005889:1', '{"dJobCd":"K000005889","dJobCdSeq":"1","dJobNm":"보비너틀보기원","workSum":"모사제조공정 중 슬리버를 실뽑기 작업에 용이하도록 연신하여 빗질하고 비벼서 일정 굵기의 조사(Roving)로 감는 기계를 조작한다.","doWork":"일정량의 슬리버를 크릴에 꽂는다. 슬리버의 끝을 찾아 안내대, 롤러 등을 거쳐 보빈(Bobbin)에 일정횟수를 감고 기계를 가동한다. 끊어진 부분이 있나 기계를 관찰하고 끊어진 슬리버와 조사를 잇는다. 일정량이 감긴 보빈을 교체한다. 보빈에 감긴 솜을 제거한다. 기계를 청소한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"보비너대지원","certLic":"섬유산업기사","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004679:1', '{"dJobCd":"K000004679","dJobCdSeq":"1","dJobNm":"보빈준비원","workSum":"실을 감는 데 쓰이는 보빈(Bobbin)을 준비한다.","doWork":"작업지시서에 의하여 품목별로 보빈이나 지관의 종류 및 색상을 분류한다. 작업이 끝난 빈 보빈이나 지관에 붙은 잔사를 제거한다. 보빈, 지관의 외관상태를 검사하여 사용가능한 것과 정비할 것을 분류한다. 운반차에 적재한다. 작업내용을 작업일지에 기록한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"시범후 30일 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C205","dJobICdNm":"[C205]화학섬유 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003087:1', '{"dJobCd":"K000003087","dJobCdSeq":"1","dJobNm":"부잠사처리원","workSum":"비수(Bisu), 생피저(Frison), 번데기 등 부산물을 정리 및 처리한다.","doWork":"생사 제조공정 중 부산물로 나오는 얇은 고치, 양견, 생피저, 번데기 등을 운반한다. 부산물처리기에 일정량의 더운물을 넣고 기계를 가동한다. 처리기에서 나온 부산물을 탈수기나 건조기로 탈수하여 건조한다. 작업 후의 제품을 검사하고 제품의 합격 여부를 판정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"힘든 작업","workPlace":"실내","workEnv":"대기환경미흡|다습|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"투입인출","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006827:1', '{"dJobCd":"K000006827","dJobCdSeq":"1","dJobNm":"비스코스불순물제거원","workSum":"액화 비스코스(Viscose)의 불순물을 여과·이송·제거하기 위해 여과기와 진공탱크 등을 조정하고 숙성시킨다.","doWork":"압착식 여과기, 진공탱크 등의 장비를 점검한다. 액화 비스코스를 압착식 여과기를 통해 여과시키고 진공탱크로 이송하여 작업표준과 생산량 등을 확인하고 온도, 압력, 연료공급 등을 입력한다. 지속적으로 모니터링하며 일정한 작업을 유지시킨다. 일정 시간 숙성시키고 성형공정으로 이송한다. 비스코스 생산량 계기의 수치를 기록하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C205","dJobICdNm":"[C205]화학섬유 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007059:1', '{"dJobCd":"K000007059","dJobCdSeq":"1","dJobNm":"사증원","workSum":"꼬아진 실이 오그라들거나 변형되는 것을 방지하고 실에 적정한 수분을 가하는 증기처리기계를 조작한다.","doWork":"원료, 번수, 연수, 색상별로 규정된 증기 처리조건에 따라 증기처리기를 조정한다. 일정형태로 감긴 실을 증기처리통에 담거나 막대에 걸어 처리기 안에 투입한다. 밸브를 열거나 펌프를 작동하여 규정된 시간, 압력, 온도로 증기처리한다. 가공된 실을 꺼내 건조실로 옮기거나 규정대로 처리되었는지 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"단사셋팅원, 연지원","certLic":"섬유산업기사","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001427:1', '{"dJobCd":"K000001427","dJobCdSeq":"1","dJobNm":"섬유교반기운전원","workSum":"알칼리 셀룰로오스를 교반기를 사용하여 이황화탄소와 혼합시켜 셀룰로오스 크잔테이트(Xanthate)를 제조한다.","doWork":"명세서를 확인하고 생산량을 점검한다. 교반기와 원료를 확인한다. 명세서를 보고 혼합·교반시간을 교반기에 입력하고 일정 시간 노성(Ageing)시킨 알칼리 셀룰로오스와 이황화탄소(CS2)를 투입한다. 교반기의 혼합상태를 모니터링하고 혼합이 완료된 셀룰로오스 크잔테이트(Xanthate)의 상태를 점검하고 이송밸브를 조작해 다음 공정으로 이송시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C205","dJobICdNm":"[C205]화학섬유 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002911:1', '{"dJobCd":"K000002911","dJobCdSeq":"1","dJobNm":"섬유신장장치운전원","workSum":"합성섬유의 탄력성을 조절하고 차기 가공 중의 고르지 못한 신장을 막기 위해 토우(Tow)나 슬리버 상태의 섬유를 늘이는 신장장치를 조작한다.","doWork":"신장장치의 신장롤러의 온도를 규정된 온도로 유지시키고 공기압력조절기를 규정된 수치로 조정한다. 기계를 가동시켜 원료가 신장롤 사이의 가열장치를 지나 운반통에 담기도록 하고 그 과정을 모니터링한다. 끊어진 토우나 슬리버를 손이나 매듭기로 연결한다. 가공된 섬유가 감긴 통의 무게를 측정하고 품목표를 부착한다. 권축장치 및 스팀조절장치 부착물이 달린 신장장치를 조작하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C205","dJobICdNm":"[C205]화학섬유 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005233:1', '{"dJobCd":"K000005233","dJobCdSeq":"1","dJobNm":"섬유압출원","workSum":"끈을 만들기 위해 수지에서 합성섬유를 압출해내는 압출기를 조작한다.","doWork":"작업지시서를 확인하고 생산할 끈의 모양, 두께, 색상 등을 파악한다. 압출에 필요한 수지 및 장비를 점검하고 준비한다. 기계의 회전드럼에 여러 색상의 수지를 투입하고 스위치를 조작해 회전드럼을 돌려 수지를 혼합한다. 혼합된 수지를 호이스트나 통에 받아 압축기의 호퍼(Hopper:분립체의 저장 및 공급장치)에 투입한다. 끈의 모양, 두께에 따라 새 금형을 설치하거나 기존 압출 금형을 청소한다. 온도조절기의 열조정장치를 확인하고 규정된 온도를 계기판에 입력한다. 기계의 스위치를 넣어 열조정장치가 일정 온도가 되면 압출을 한다. 압출되는 섬유의 두께나 색깔이 표준에 맞는지 육안이나 자로 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"시범후 30일 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|고온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C139","dJobICdNm":"[C139]기타 섬유제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001517:1', '{"dJobCd":"K000001517","dJobCdSeq":"1","dJobNm":"섬유유제원","workSum":"섬유제조 공정 및 기능상에 윤활기능을 부여하는 대전 방지용 윤활제 등의 유제를 조제·조정·공급한다.","doWork":"작업표준서의 혼합비에 따라 조제탱크에 유화제, 대전방지제, 집속(Focusing)조제 등의 화공약품들을 일정 비율로 조합하여 투입한다. 혼합되어 조제된 수성 또는 비수성 유화액으로 조제된 유제의 농도 및 점성을 측정한다. 저장탱크로 이송하고 유제를 기계별로 조정·공급한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"섬유유제관리원, 유제원","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C205","dJobICdNm":"[C205]화학섬유 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004938:1', '{"dJobCd":"K000004938","dJobCdSeq":"1","dJobNm":"섬유조합원","workSum":"솜 형태의 화학섬유(Fiber)를 색상이나 재질에 따라 손으로 혼합한다.","doWork":"화학섬유 뭉치가 담긴 자루나 포장용기를 작업장소로 운반한다. 혼합된 섬유뭉치를 색상별로 컨베이어 벨트 위에 쏟아붓고 유연제를 뿌린다. 섬유뭉치를 잘게 찢거나 쪼개면서 혼합한다. 혼합된 섬유뭉치가 컨베이어 벨트를 통해 혼합기로 들어가는지 확인한다. 공기압축기(Air Compressor) 등으로 작업장 주위의 섬유뭉치나 조각을 청소한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"섬유혼합원","certLic":"섬유산업기사","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003732:1', '{"dJobCd":"K000003732","dJobCdSeq":"1","dJobNm":"세모기운전원","workSum":"소모사를 제조하기 위한 전 공정으로 생양모(Greasy Wool) 속에 포함된 불순물(흙, 먼지, 기름 등)을 제거하기 위해 탱크나 용기로 이루어진 일련의 정련기를 운전한다.","doWork":"물과 가성소다 등의 세제가 용기 안으로 흐르도록 밸브를 조절한다. 온도계의 눈금을 읽고, 지정된 작업온도까지 세탁 및 헹굼 용액이 가열되도록 증기밸브를 연다. 생모를 호퍼(Hopper:분립체의 저장 및 공급장치)에서 세탁용기 안으로 이송하는 기계를 가동하고, 양모가 보울(Bowl)을 통하여 압착 롤과 헹굼 용기까지 이송되도록 한다. 일련의 정련기 설비를 점검하여 압착 롤이 막히는지 관찰하고 막힌 부분의 섬유를 손으로 제거한다. 세탁용기 안의 비누거품에 의한 세탁상태를 살피고 농축세제를 증감하는 밸브를 돌린다. 지시계를 통해 내부압력 및 온도를 확인한다. 건조기의 송풍기를 가동하여 뜨거운 공기를 순환시킨다. 건조기에서 나오는 양모를 만져보고 양모의 건조 상태를 확인한다. 기계를 세척한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"모정련기운전원","certLic":"섬유산업기사","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001824:1', '{"dJobCd":"K000001824","dJobCdSeq":"1","dJobNm":"소면기소제원","workSum":"소면도핑드럼과 철사 톱니에 붙은 면섬유를 제거하는 장비를 조작한다.","doWork":"소면기의 브래킷(Brackets)에 스트리핑 롤러(Stripping Roller)를 놓고 롤러의 철사톱니가 소면 실린더의 철사톱니 사이로 튀어나오도록 한다. 기계를 시동하여 스트리핑 롤러를 빨리 회전시키고 천천히 회전하는 소면 실린더에서 섬유를 제거한다. 잡물과 실 보푸라기를 제거하기 위해 손수레에 연결된 흡착파이프와 소제 롤 후드(Hood)를 사용한다. 실린더와 도핑드럼(Doffing Drum)의 앞면에 진공스트리퍼의 노즐을 위치시킨다. 스트리퍼가 실린더를 왕복하며 노즐의 먼지를 떨 수 있도록 기계를 시동한다. 소면기계를 조작하는 소면기틀보기원의 일을 하기도 한다. 소면 롤의 침포를 연삭하는 데 보조하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"소면집지기소제원, 언더케이싱소제원","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006558:1', '{"dJobCd":"K000006558","dJobCdSeq":"1","dJobNm":"소면반장","workSum":"소면기계에 관한 지식을 활용하여, 천연섬유원료 및 합성섬유원료를 실로 방적하기 위해 슬리버(Sliver)를 만드는 데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"투입할 원면의 양, 방출할 슬리버의 양 등을 파악하여 작업계획을 세운다. 작업계획에 따라 세부실행항목을 수립하고 작업절차 및 방법을 결정하여 작업원에게 작업내용을 지시하고 작업배치를 한다. 기계와 손 공구를 사용하여 소면기계의 설치와 조정상태 및 청소상태를 확인한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원 및 자재를 공급한다. 표준작업명세에 따라 지시된 작업이 이루어지는지 작업원과 함께 작업하며 작업상황을 관찰하고 작업내용을 점검한다. 작업의 진행사항을 파악하고 작업내용을 보고한다. 작업원의 직무교육 및 안전위생교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴·해결하고 문제점을 보완한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","certLic":"섬유산업기사","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005533:1', '{"dJobCd":"K000005533","dJobCdSeq":"1","dJobNm":"소면틀보기원","workSum":"면·합성섬유 또는 기타 섬유들을 풀어 깨끗이 정돈하고 전 공정에서 만들어진 랩(Lap)을 슬리버(Sliver)로 만드는 소면기를 조작한다.","doWork":"기계의 공급장치에 풀어헤친 섬유를 공급하거나, 공급부분의 걸대 위에 섬유의 랩(Lap)을 올려놓고 공급롤러를 통과하도록 랩의 끝을 꿰거나 손가락으로 끝부분을 서로 죄어서 기계에 랩의 끝을 갖다 붙인다. 작업장을 순찰하면서 다 소모된 랩이나 슬리버가 끊어진 곳이 없는지 조사한다. 소모된 랩을 새로운 랩으로 교체하고 끊어진 슬리버들을 손가락으로 말거나 비틀어서 잇는다. 슬리버 통이 꽉 차면 빈 통으로 바꾼다. 브러시나 공기호스를 사용하여 기계를 청소한 후 기름을 친다. 개포기로부터 랩을 운반하여 걸대에 걸기도 한다. 섬유의 원재료로부터 슬리버를 생산하는 기계를 조작하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"섬유산업기사","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005566:1', '{"dJobCd":"K000005566","dJobCdSeq":"1","dJobNm":"소모기운전원","workSum":"약품처리 시 침투성 향상 및 염색 시 얼룩방지를 위하여 피염물의 잔털(모우)을 태우는 기계를 조작한다.","doWork":"소모기의 온도와 속도를 입력한다. 재봉틀을 사용하여 기계의 안내천(Leader Cloth)에 가공할 천의 끝단을 연결하거나 기계의 롤러 사이로 투입한다. 가열한 롤러나 가스불 위의 습윤장치 사이를 통과하는 천이 타지 않나 관찰한다. 롤러나 가스불을 규정온도로 유지한다. 습윤장치의 물의 양을 조절하는 밸브를 조절한다. 작업 마무리 후 장비를 청소한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|고온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"가스모소기운전원, 전기모소기운전원","certLic":"섬유산업기사","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C134","dJobICdNm":"[C134]섬유제품 염색, 정리 및 마무리 가공업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004257:1', '{"dJobCd":"K000004257","dJobCdSeq":"1","dJobNm":"소모기틀보기원","workSum":"양모나 합성섬유를 풀어헤쳐 이물질을 제거하고 슬리버로 만드는 소모기(Carding Machine)를 운전한다.","doWork":"격자무늬의 공급장치(Feed Lattice) 위에 풀어헤친 섬유 또는 두루마리를 공급하고 기계에 부착된 기구를 사용해 섬유의 공급주기, 일회의 공급량을 입력한다. 공급롤러, 실린더를 거쳐 불순물이 제거되고 빗질된 섬유를 도퍼(Doffer)에서 번수를 맞추어 운반 통에 담기게 한다. 여러 기계 사이를 순회하며 운반 통에 일정량의 슬리버가 담기게 되면 새로운 통으로 교환하고 지정된 장소로 운반한다. 생산된 슬리버의 상태를 관찰한다. 기계의 이상 유무를 점검하며 부산물인 노일(Noil)을 계량하여 마대에 넣어 묶는다. 솔, 걸레, 수동공구(Handcard), 공기압축기(Air Compressor) 등을 사용하여 기계를 청소하고 주유한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"카드대지원, 카딩원","certLic":"섬유산업기사","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005908:1', '{"dJobCd":"K000005908","dJobCdSeq":"1","dJobNm":"소모반장","workSum":"양모나 화학섬유를 풀어헤쳐 섬유를 나란히 배열하여 일정 굵기의 슬리버(Sliver)로 만드는 일에 종사하는 작업원의 활동을 감독·조정한다.","doWork":"선별된 원모나 화학섬유 등의 투입원료 및 기계의 이상 유무를 확인한다. 원료를 소모기에 투입 후 전 공정을 통하여 작업지시에 따른 작업진행 및 기계운전을 감독한다. 생산품의 시험결과에 대한 기계조정 및 부산물을 관리한다. 작업계획에 따라 세부실행항목을 수립하고 작업절차 및 방법을 결정하여 작업원에게 작업내용을 지시하고 작업배치를 한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원 및 자재를 공급한다. 표준작업명세에 따라 지시된 작업이 이루어지는지 작업원과 함께 작업하며 작업상황을 관찰하고 작업내용을 점검한다. 작업의 진행사항을 파악하고 작업내용을 보고한다. 작업원의 직무교육 및 안전위생교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴·해결하고 문제점을 보완한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","certLic":"섬유산업기사","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002243:1', '{"dJobCd":"K000002243","dJobCdSeq":"1","dJobNm":"스테이플가공기운전원","workSum":"화학섬유의 토우(Tow)를 늘리고 일정 길이로 절단하여 곱슬곱슬한 스테이플섬유(Staple Fiber)로 만드는 기계를 조작한다.","doWork":"스테이플섬유의 생산량과 규격, 생산장비를 확인·점검한다. 장치에 필라멘트 토우를 안내대, 장력롤러, 가열판, 절단롤러, 권축장치(Crimping Device)를 통과시켜 필라멘트 토우를 늘리는 작업을 한다. 절단롤러 주위에 감긴 섬유가 있는지 관찰하여 엉킨 섬유를 잘라낸다. 규정량의 섬유가 운반통에 담기면 기계를 정지하고 길이계산계기를 통해 제품을 검사·조정한다. 섬유가 담긴 통에 품목표를 부착한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C205","dJobICdNm":"[C205]화학섬유 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001414:1', '{"dJobCd":"K000001414","dJobCdSeq":"1","dJobNm":"스테이플절단원","workSum":"실을 제조하거나 화학섬유를 만들기 위해 토우(Tow)나 슬리버(Sliver)를 일정 길이로 절단하는 기계를 조작한다.","doWork":"작업지시서에 따라 생산량을 확인하고 장비를 점검하고 토우, 슬리버 또는 원재료 등을 확인·준비한다. 원재료 꾸러미를 풀어헤친 후 섬유를 컨베이어 벨트에 놓아 절단날로 이송되게 하거나 슬리버의 끝이나 토우의 끝이 절단기의 공급롤로 이송되게 한다. 절단기를 통과한 섬유를 조사하여 절단된 섬유의 길이 및 절단면 등을 확인하고 무디어진 절단날을 교환하기도 한다. 절단이 끝난 스테이플사를 다음 공정으로 이송시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C205","dJobICdNm":"[C205]화학섬유 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001498:1', '{"dJobCd":"K000001498","dJobCdSeq":"1","dJobNm":"스풀회수기조작원","workSum":"스풀(Spool)에 감겨 있는 알루미늄스크랩을 분리하여 회수하는 설비를 조작한다.","doWork":"작업할 소재를 인계받아 스크랩(Scrap)을 권취기설비에 투입한다. 스크랩의 선단을 권취기의 코일러(Coiler)에 감아주고 속도를 조절하여 감는다. 코일러에 감긴 소재의 종류 및 재질에 따라 구분하여 적하장에 적재하고 스풀러를 회수한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C205","dJobICdNm":"[C205]화학섬유 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005957:1', '{"dJobCd":"K000005957","dJobCdSeq":"1","dJobNm":"실켜기원","workSum":"고치에서 바른 실마리를 찾아 한 타래의 생사를 만든다.","doWork":"실켜기 방법 또는 목적에 따라 조사기(繰絲機:실켜기 기계)의 온도, 농도, 속도를 일정하게 조절하여 생사의 굵기를 균일하게 한다. 약품을 첨가한 물에 담가 불린 고치를 브러시로 문지르면서 실의 끄트머리를 찾는다. 찾아낸 실마리를 굵기에 알맞도록 실마리 수를 덧붙이고 굵기의 균제도를 확인하며 실켜기를 한다. 실켜기 공정에서 목적하는 생사의 굵기에 따라 고치의 알 수 덧붙이기 및 생사의 조합을 관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"고온|다습|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","similarNm":"제사원, 조사원","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005642:1', '{"dJobCd":"K000005642","dJobCdSeq":"1","dJobNm":"양반원","workSum":"견직물 제조 시 적당한 크기로 실을 감기 위해 작은 얼레의 실을 큰 얼레에 감는다.","doWork":"조사원이 작은 얼레에 감은 실을 제조장으로 옮겨 작은 얼레의 실이 잘 풀리도록 진공침투기로 충분한 물을 침투시킨다. 각각의 실타래에서 실 끝을 가이드와 장치를 통해 큰 얼레에 두른다. 기계를 시동하고 실이 감기는 상태를 관찰하여 끊어진 실을 손으로 잇고 가는 실이나 오물 등을 제거한다. 큰 얼레에 타래가 되는 상태를 관찰한다. 기계를 멈추고 다 감긴 실 꾸러미를 빼낸다. 감긴 실의 이상 여부를 조사한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|다습|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C132","dJobICdNm":"[C132]직물직조 및 직물제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004214:1', '{"dJobCd":"K000004214","dJobCdSeq":"1","dJobNm":"연사틀보기원","workSum":"합사된 실의 강도를 높이고, 부드러움을 주기 위해 실을 꼬는 기계를 조작한다.","doWork":"작업명세서에 따라 실의 색상과 종류를 결정하여 실이 감긴 목관을 기계에 끼운다. 실 끝을 롤러, 장력장치, 안내대, 트래블러(Traveller) 혹은 플라이어(Flyer)를 통해 권취 실패에 감는다. 끊어진 실을 찾거나 공급 실의 소모량을 확인하기 위해 기계를 점검·관찰한다. 끊어진 실 끝을 손이나 매듭기로 잇는다. 엉킨 것을 푼다. 권취된 실 꾸러미를 빈 실패로 교체한다. 생산량을 기록하거나 작업표에 작업자의 명단을 붙이기도 한다. 롤을 설치하거나 무늬체인의 작동으로 실에 불규칙한 모양의 효과를 내는 기계를 조작하기도 한다. 몇 가닥의 실을 합하여 꼬임을 주는 합연기조작원의 일을 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"연사대지원, 연사호대원, 연사기운전원","certLic":"섬유산업기사","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005549:1', '{"dJobCd":"K000005549","dJobCdSeq":"1","dJobNm":"연신기운전원","workSum":"방사공정에서 생산된 실의 강도와 신축성을 향상하고자 필라멘트(Filament)를 연신하는 기계를 조작한다.","doWork":"지시서를 보고 생산품종 및 그에 따른 연신조건을 확인한다. 스핀들에 필라멘트를 감은 보빈을 끼우고 섬유를 연신롤러, 연신핀, 트래블러(Traveller)를 거쳐 보빈에 감거나 통에 담는다. 연신롤러를 가열하기 위해 가스의 흐름 또는 온수의 온도 및 공급량 등을 조절한다. 연신된 실이 규정에 맞는지 검사한다. 필라멘트의 절단, 얽힘 등이 발생하면 기계를 정지한 후 자르고 다시 잇거나 정리한다. 보빈이나 통에 섬유가 가득 차면 교체하고 품목표를 부착한다. 열판 및 롤러를 청소한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"고온|다습|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"도핑원","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C205","dJobICdNm":"[C205]화학섬유 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006374:1', '{"dJobCd":"K000006374","dJobCdSeq":"1","dJobNm":"연신반장","workSum":"방사공정에서 생산된 미연신사(합성섬유를 제조할 때 용융액을 압출해서 만들어진 초기의 결정화도가 작고 무배향 또는 저배향도 상태인 것)를 일정한 굵기, 중량, 형태로 늘리거나 꼬아 일정규격의 실패나 보빈, 지관에 감는데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"계열별 생산품종의 생산량 등의 작업계획을 수립하고 기계의 이상 유무를 확인·점검한다. 생산품종에 따라 기계의 조건을 변경하고 작업내용에 따라 작업원을 지시·배치한다. 연신기의 연신롤러 사이, 회전축 등의 덮개나 울 등의 안전장비를 확인·점검하고 작업원의 안전위생교육을 통해 안전재해를 예방한다. 자재의 원활한 공급 및 이상제품이 발생하지 않도록 품질관리교육을 실시한다. 작업표준서에 따라 작업의 진행사항을 파악, 관리·감독하고 기술적인 지원을 통해 직무수행능력을 향상시킨다. 수시면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴·해결하고 문제점을 보완한다. 작업상황을 관찰하고 작업내용을 작업진행상황 일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"고온|다습|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C205","dJobICdNm":"[C205]화학섬유 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006017:1', '{"dJobCd":"K000006017","dJobCdSeq":"1","dJobNm":"연조반장","workSum":"방적에 관한 지식을 활용하여 천연 섬유재료 또는 합성, 반합성 섬유재료 등의 여러 가닥의 슬리버를 합하여 균제도를 향상시키고 방적하기 좋게 하기 위한 연조공정에 종사하는 작업원의 활동을 감독·조정한다.","doWork":"연조기의 설치와 조정상태 등 이상 유무를 점검한다. 작업계획에 따라 세부실행항목을 수립하고 작업절차 및 방법을 결정하여 작업원에게 작업내용을 지시하고 작업을 배치한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원 및 자재를 공급한다. 표준작업명세에 따라 지시된 작업이 이루어지는지 작업원과 함께 작업하며 작업상황을 관찰하고 작업내용을 점검한다. 작업의 진행사항을 파악하고 작업내용을 보고한다. 작업원의 직무교육 및 안전위생교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴·해결하고 문제점을 보완한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","certLic":"섬유산업기사","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003885:1', '{"dJobCd":"K000003885","dJobCdSeq":"1","dJobNm":"연조틀보기원","workSum":"섬유를 평행하게 배열하고 균일정도를 개선하기 위해 정소면·소면 공정을 거친 여러 가닥의 슬리버를 한 가닥으로 합하여 가는 연조 슬리버로 만드는 연조기를 조작한다.","doWork":"연조될 슬리버의 색상, 농도 등을 고려하여 앞 공정에서 가공된 정소면·소면 슬리버를 연조기의 공급위치에 배치한다. 슬리버의 끝을 안내대(Guide), 정지장치(Stop Motion), 연조롤러, 콘덴서, 코일러 헤드(Coiler Head)를 통해 회전 통에 꿰거나 손가락으로 슬리버 끝을 포개고 비틀어 잇는다. 슬리버의 흐름을 관찰하고 끊어진 슬리버로 인한 기계정지를 알리는 신호등을 관찰하기 위해 기계 주위를 순찰한다. 코일러 헤드로부터 슬리버가 가득찬 통(캔)을 빈 통과 교체한다. 롤러나 슬리버가 통과하는 부분의 주위에 있는 풍면(Fly Waste) 및 먼지를 브러시나 공기호스를 사용하여 제거한다. 기계에 기름을 치거나 청소하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"연조대지원, 연조호대원, 연조기조작원","certLic":"섬유산업기사","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003276:1', '{"dJobCd":"K000003276","dJobCdSeq":"1","dJobNm":"원면혼합기조작원","workSum":"원면을 처방에 따라 골고루 혼합하는 기계를 조작한다.","doWork":"원면혼합기를 점검하고 실린더를 공회전시킨다. 저장소 조정장치와 원면 이송장치를 작동하고 작업하고자 하는 저장소로 바람이 나오는지 확인한다. 원면뭉치를 틀 위에 올려놓고 절단기를 사용하여 묶어진 철띠를 잘라 해체한다. 원면표면의 이물질을 제거하고 일정무게 단위로 혼합기에 투입하여 혼합한다. 혼합장치에 전원을 넣어 타면기 및 유도장치를 작동하여 작업하고자 하는 저장소에 혼합된 면이 나오는지 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"힘든 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|고온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"원면배합원, 혼타면기조작원","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C139","dJobICdNm":"[C139]기타 섬유제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;