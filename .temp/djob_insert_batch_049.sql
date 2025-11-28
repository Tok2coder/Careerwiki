INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001438:1', '{"dJobCd":"K000001438","dJobCdSeq":"1","dJobNm":"벨트여과기조작원","workSum":"소광을 황산으로 녹인 용액으로 수용성 아연을 회수하고 불용분을 여과하여 배출시키는 벨트여과기를 조작한다.","doWork":"농축기에서 제거된 슬러리(Slurry)를 벨트여과기 하부용기에 공급하기 위하여 펌프를 가동한다. 진공펌프를 시동하여 벨트여과기 드럼 내부를 진공상태로 유지시킨다. 드럼작동스위치를 조작하여 드럼을 회전시키고 하부용액을 흡입하여 여과액은 여과액조로 공급하고 남은 액은 벨트 여포에 붙여서 떨어지게 한다. 여과상태를 육안관찰하고 불량 시에는 온도와 슬러리 함량을 조절한다. 기계의 작동상태를 점검하고 불량여포를 세척·교환·보수한다. 벨트여과기 하부액은 양수장으로 펌프를 가동시켜 퍼낸다. 양수량, 순환액, 회수량을 조절한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C242","dJobICdNm":"[C242]1차 비철금속 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006523:1', '{"dJobCd":"K000006523","dJobCdSeq":"1","dJobNm":"부동액배합원","workSum":"원료 및 첨가제 등의 화합물을 용해조 및 배합조에서 용해·배합하여 부동액을 제조한다.","doWork":"작업 전 배합탱크의 모든 밸브를 열고 잔류액을 수거통으로 이송한다. 작업지시서에 따라 원료저장탱크와 연결된 밸브를 열고 유량계를 확인하면서 일정량의 첨가제를 용해조에 투입한다. 작업지시서에 따라 첨가제(냉각장치를 녹슬게 하지 않기 위한 부식방지제, 냉각수가 새지 않게 하는 밀봉제, 거품을 막기 위한 거품방지제 등)를 계량하여 용해탱크 및 배합탱크에 투입하고 스팀밸브를 열어 일정 온도까지 올려 용해한다. 용해가 완료되면 밸브를 열어 용해조에서 배합조로 이송한다. 첨가제와 원료(에틸렌글리콜 등의 화합물과 알코올류)의 배합이 완료된 후 호스를 배합탱크에 연결하고 하단의 배출밸브를 열어 배합탱크에 투입한다. 배합탱크에 이송이 완료된 후 펌프를 가동하여 배합기 내부에 공기를 주입하여 상하 혼합을 실시한다. 일정 시간 배합이 완료되면 배합기를 정지시키고 견본을 채취하여 품질검사부로 보낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C204","dJobICdNm":"[C204]기타 화학제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006153:1', '{"dJobCd":"K000006153","dJobCdSeq":"1","dJobNm":"분제제조원","workSum":"분제(유효성분에 유동제·증량제 등을 가하여 혼합한 미세 분말상으로 조제하여 약제 그대로 살포) 형태의 살충제·살균제·제초제를 제조하기 위하여 원·부제를 혼합·분쇄하는 기계를 조작·관리한다.","doWork":"혼합작업을 하기 위해 작업지시서에 따라 고상원제, 액상원제 등을 계량하여 1차 혼합기에 투입한다. 이때 고상원제는 호이스트와 리프트, 액상원제는 펌프를 사용하여 투입한다. 모든 원·부제의 투입이 완료되면 상단의 교반축을 혼합기 안으로 삽입하고 혼합기 조정판에 혼합조건을 입력하고 가동한다. 일정 시간 혼합이 완료되면 교반축을 혼합기 외부로 올리고 분쇄날을 혼합기 내부로 내려 장착한다. 분쇄기를 가동하고 일정 시간 후 견본을 검사하여 입도가 작업표준과 일치하면 작업순서에 따라 원제와 액상보조제를 투입하기 위하여 투입버튼을 누른다. 스프레이로 분사되는 보조제의 상태를 육안으로 관찰한다. 일정 시간 혼합과 분쇄가 완료되면 중간분쇄기로 이송하기 위하여 호스를 연결하고 밸브를 열고 펌프를 가동한다. 중간분쇄가 완료되면 2차 혼합기로 이송하고 혼합물이 균일하게 되었는지 견본을 채취하여 검사하고 첨가제를 투입하여 제품표준과 맞춘다. 보정공정으로 이송하기 위하여 호스를 연결하고 펌프를 가동한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C204","dJobICdNm":"[C204]기타 화학제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003146:1', '{"dJobCd":"K000003146","dJobCdSeq":"1","dJobNm":"샌드밀연화원","workSum":"배합공정을 거쳐 프리믹스(Pre-mix)된 도료 반제품을 연화시키기 위해 샌드밀(Sand Mill)을 조작·관리한다.","doWork":"샌드밀의 샌드드럼 하부에 있는 냉각수 밸브를 열어 냉각수를 공급한다. 샌드밀로부터 배출되는 연화물질을 받아 희석조정 작업에서 사용하기 위해 희석조를 샌드밀 배출구쪽으로 이동시킨다. 배출물질의 공급파이프와 샌드드럼 내에 용제가 충진되어 있을 경우 배합작업 전에 배합조 하부에 있는 배출밸브와 공급파이프에 있는 전 밸브를 열어 용제를 제거한다. 배합물질의 공급파이프를 닫고 수급밸브를 연 다음 가동한다. 이때 샤프트(Shaft)의 회전으로 디스크가 고속운동을 하게 되고 용기(Vessel) 안에 있는 미디어(Media)의 전달력에 의하여 분산 과정이 이루어진다. 샌드밀의 배출수로부터 배출되는 연화물의 연화도가 제품지시서에 지시된 연화도에 맞도록 밸브를 조절하여 샌드밀에 공급되는 배합물질의 양을 조절한다. 배합물의 공급이 일정하게 조절되면 계속 분산·연화 작업을 실시한다. 연화가 완료되면 연화도를 최종 측정하여 이상 유무를 확인하고 조정공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"분산기조작원","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C204","dJobICdNm":"[C204]기타 화학제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002261:1', '{"dJobCd":"K000002261","dJobCdSeq":"1","dJobNm":"섬유유연제이차반응기조작원","workSum":"섬유유연제를 제조하고자 1차 반응이 완료된 반제품을 2차 반응시키는 장치를 조작·관리한다.","doWork":"1차 반응이 완료된 반제품을 2차 반응기로 이송하고자 공급호스를 2차 반응기 투입구에 연결하고 펌프를 가동하여 이송한다. 작업지시서의 내용에 따라 요소를 계량한 후 반응기에 투입한다. 스팀밸브를 열고 일정 온도까지 온도를 올린다. 정해진 온도까지 올라가면 반응기의 조정 판에 기타 반응조건(반응온도, 시간, 교반속도 등)을 입력한다. 상단의 교반축을 반응기 내부로 내리고 가동한다. 반응조건이 일정하게 유지되는지 관찰하고 이상발생 시에는 신속히 조치를 취한다. 조치사항을 작업일지에 기록한다. 일정 시간 반응이 완료되면 견본을 채취하여 아민가(Amine Value)를 측정하고 원료와 부원료를 적정량 투입하여 아민가를 맞춘다. 냉각밸브를 열어 일정 온도까지 냉각시킨 후 첨가제로 적정한다. 적정이 완료되면 3차 반응을 시키기 위하여 설정온도, 시간, 교반속도 등을 작업표준에 따라 재설정하고 다시 가동시킨다. 3차 반응이 완료되면 다시 아민가를 측정하고 제품표준과 동일하면 최종 첨가제를 투입한다. 최종 반응이 완료된 후 배출밸브를 열고 펌프를 가동하여 저장탱크에 이송한다. 작업일지를 작성한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|고온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"위험물기능사, 위험물산업기사","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C201","dJobICdNm":"[C201]기초 화학물질 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006576:1', '{"dJobCd":"K000006576","dJobCdSeq":"1","dJobNm":"섬유유연제일차반응기조작원","workSum":"섬유유연제를 제조하기 위하여 원료 및 첨가제를 혼합하여 1차 반응시키는 장치를 조작·관리한다.","doWork":"고압호스를 이용해 1차 반응기를 물로 세척한 후 스팀밸브를 열어 반응기 내부를 완전 건조시킨다. 원료 및 첨가제가 고상일 경우 다른 탱크에 충진 후 스팀을 가하여 용해한다. 계면활성제 등의 원료 및 첨가제를 투입하고자 작업표준에 명시된 순서대로 공급밸브를 열고 유량계를 확인하면서 펌프를 가동하여 1차 반응기에 투입한다. 반응기의 조정 판에 반응조건(온도, 압력, 시간, 교반속도 등)을 입력하고 가동한다. 반응기가 적정온도에 도달하면 촉매를 배합비에 따라 계량하여 투입한다. 일정 시간 반응이 진행된 후 견본을 채취하여 반응물의 아민가(Amine Value)를 측정한다. 아민가가 작업표준과 다를 경우 원료와 부원료를 첨가하여 적정하게 맞춘다. 반응이 완료되면 냉각수 밸브를 열고 일정 온도까지 냉각시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|고온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"반응조작원, 반응탑조작원, 산화반응기조작원","certLic":"위험물기능사, 위험물산업기사","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C201","dJobICdNm":"[C201]기초 화학물질 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004799:1', '{"dJobCd":"K000004799","dJobCdSeq":"1","dJobNm":"수지배합원","workSum":"합성수지를 생산하기 위하여 원료를 합성용 탱크에 투입하여 배합하는 기계나 장비를 조작·관리한다.","doWork":"작업지시서에 따라 필요한 원료를 지게차, 대차, 호이스트 등을 사용하여 저장창고로부터 합성용 탱크로 운반한다. 호이스트나 리프트 등을 사용하여 원료를 합성용 탱크에 투입하고 뚜껑을 덮는다. 작업지시서에 따라 배합조건을 조정패널에 입력하고 배합기를 작동시켜 원료를 배합한다. 배합이 완료된 반제품의 견본을 채취하여 검사한 후, 첨가제의 투입이 필요할 경우 조장에게 보고·조치한다. 작업 중 이상이 발생하면 공정관리규정에 따라 조치한다. 배합이 완료되면 배합기 하단에 위치한 배출밸브를 열고 펌프를 가동하여 저장탱크로 이송한다. 배출이 완료되면 일일 배출량과 제품명, 작업조건 등을 작업일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"플라스틱제조배합원","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C202","dJobICdNm":"[C202]합성고무 및 플라스틱 물질 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006188:1', '{"dJobCd":"K000006188","dJobCdSeq":"1","dJobNm":"수지제조원","workSum":"합성수지를 제조하기 위하여 각종 원료 및 부재료에 촉매를 첨가하고 관련 장치를 조작·관리한다.","doWork":"작업지시서의 내용을 통해 생산할 제품을 확인한 후 필요한 원·부재료(글리콜, 아디프산, 폴리에스테르, 아크릴산 등)의 양을 파악한다. 분말형 원·부재료는 중량을 측정한 후 호이스트나 리프트를 사용하여 반응조에 투입을 하고, 액체일 경우에는 파이프의 밸브를 열고 유량계를 확인하면서 반응조로 이송을 한다. 원·부재료는 생산을 하기 위한 제품에 따라 폴리에스터수지, 폴리우레탄수지, 아크릴수지 반응조 등에 각각 투입한다. 원·부재료의 투입이 완료되면 중합반응을 시키기 위하여 반응조의 조정판에 반응조건(온도, 압력, 교반속도 등)을 입력하고 가동을 한다. 일정 시간 반응이 진행된 후 반응속도를 가속시키기 위하여 각각의 반응조에 알맞은 촉매를 계량하여 투입한다. 촉매투입 후 중합반응이 이상 없이 이루어지는지 반응조 유리창을 통하여 관찰한다. 반응이 완료되면 제품에 따라 균일한 입도를 가지도록 분쇄기를 가동하여 반제품을 분쇄한다. 견본을 채취하여 제품규격과 일치하는지를 검사한다. 정밀한 검사를 위하여 견본의 일부를 품질검사부로 보낸다. 합격 결과가 통보되면 각 반응조 하단에 위치한 배출밸브를 열고 펌프를 가동하여 반제품을 저장조로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"플라스틱제조원","connectJob":"아크릴제조원, 폴리에스터제조원, 폴리우레탄제조원","certLic":"위험물산업기사, 위험물기능사","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C202","dJobICdNm":"[C202]합성고무 및 플라스틱 물질 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001650:1', '{"dJobCd":"K000001650","dJobCdSeq":"1","dJobNm":"수채액배합원","workSum":"수채물감을 만들기 위해 다양한 색상의 안료와 전색제, 기타 보조약품을 배합한다.","doWork":"제품명세서에 따라 만들고자 하는 색상의 안료(물이나 기름에 용해되지 않는 색을 가진 미세한 분말), 수채물감의 전색제(본드 성분의 역할을 하는 아라비아고무), 각종 보조약품을 준비한다. 배합기에 각각의 양을 정확히 측정해 투입하고 배합기의 패널에 배합조건을 입력한다. 배합기를 가동해 정제 미디엄(Medium)을 얻고, 여기에 기타 첨가제(글리세린, 덱스트린, 방부제, 풀)를 넣어 가동시킨다. 배합이 완료되면 수채액을 시험판에 바르고 색상이 제품규격과 일치하는지를 확인하고 용기에 담는다. 용기 겉 표면에 품명과 색상명을 정확히 기록하여 다른 안료가 섞이지 않도록 뚜껑을 닫아 봉한다. 배합하고 남은 원료는 원료저장창고로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C204","dJobICdNm":"[C204]기타 화학제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003541:1', '{"dJobCd":"K000003541","dJobCdSeq":"1","dJobNm":"시약원","workSum":"선광·선탄기에서 광물을 분리하기 위하여 사용되는 시약을 조제한다.","doWork":"광물의 종류, 특성에 따라 사용할 시약을 결정하거나 작업표준을 확인한다. 작업표준이나 실험에 얻어진 표준에 따라 천칭, 저울, 탱크 등의 측정기구를 사용하여 시약조제에 사용되는 약품, 재료, 물 등의 무게 및 부피를 측정한다. 측정된 재료를 혼합하기 위하여 혼합탱크에 넣고 일정 시간 교반기를 가동시키거나 기타 혼합장치를 사용한다. 기포제, 포집제, 맥석통제제, 억제제, 촉진제, 중액 등으로 조제된 시약을 피펫으로 견본을 채취하여 규정농도 유지 여부를 검사한다. 혼합·조제된 시약을 펌프를 가동하여 선광·선탄기로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"시약조제원","connectJob":"중액제조원","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"B051/B061/B062","dJobICdNm":"[B051]석탄 광업 / [B061]철 광업 / [B062]비철금속 광업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006303:1', '{"dJobCd":"K000006303","dJobCdSeq":"1","dJobNm":"식품여과기조작원","workSum":"식물성 단백질 분해물(HVP: Hydrolyzed Vegetable Protein) 제조 시 중화액에서 단백질 찌꺼기를 제거하고 색·냄새·맛 등을 조절하는 기계를 조작·관리한다.","doWork":"규조토(주로 설탕, 시럽, 조미료 등을 정화하는 여과재로 사용, 현재는 거의 모든 산업용 여과장치에 적용)를 작업표준에 명시된 농도로 물에 투입하고 펌프를 가동시켜 여과기 내부에 주입한다. 여과기 내부와 연결된 진공펌프를 가동시키고 여과포로 된 드럼을 회전시켜 드럼에 규조토 피막을 형성시킨다. 규조토 피막이 입혀지면 칼날과 드럼 사이의 간격을 조절하여 피막에 입혀질 불순물을 제거한다. 펌프를 가동시켜 중화액을 여과탱크에 주입하고 진공펌프를 가동하여 중화액을 여과드럼에 통과시켜 탈색탱크에 저장한다. 탈색탱크에 규정된 양의 활성탄(活性炭:주성분이 탄소이며 다공성으로, 표면적이 넓어 흡착성이 강하고, 화학 반응이 빨리 일어나는 물질)을 투입하고 일정 온도로 증기가열을 명시된 시간 동안 한다. 활성탄에 의해 착색된 중화액을 다시 여과기로 보내 여과한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"식품산업기사, 식품가공기능사","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004511:1', '{"dJobCd":"K000004511","dJobCdSeq":"1","dJobNm":"아세틸렌가스제조원","workSum":"아세틸렌(Acetylene:C₂H₂) 가스를 제조하기 위하여 냉각기, 건조기, 정제기, 가스압축기 등 관련 장치를 조작·관리한다.","doWork":"물탱크의 밸브, 수위게이지, 온도조절장치 등을 돌려서 가스발생기에 규정된 수위까지 물을 넣고 호퍼(Hopper)에 일정량의 탄화칼슘(칼슘카바이드) 결정체를 쏟아붓는다. 냉각기, 가스홀더, 건조기, 가스정제기, 가스압축기 등을 조작하여 아세틸렌가스(Acetylene, C₂H₂:산소·아세틸렌염을 이용해 금속의 용접 및 절단에 주로 사용함)의 열을 냉각시키고 아세틸렌가스에 포함된 불순물 및 기름성분을 제거한다. 압력, 온도, 용액높이, 유동게이지 등을 관찰하여 공정의 흐름을 조절하고 안전사고를 방지하기 위해 역화방지기, 안전밸브 등을 점검한다. 제조한 아세틸렌가스를 실린더 용기에 충전하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실외","physicalAct":"웅크림|","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"D352","dJobICdNm":"[D352]연료용 가스 제조 및 배관공급업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006461:1', '{"dJobCd":"K000006461","dJobCdSeq":"1","dJobNm":"아연젤제조원","workSum":"알칼라인전지에서 음극(-)으로 사용되는 아연젤을 제조하는 기계를 조작한다.","doWork":"아연파우더·알칼리액·젤화제 등의 재료를 크레인으로 이송해서 자동계량장치에 투입하고 무게를 측정한다. 자동계량장치로부터 자동으로 이송되어 혼합기에 투입된 아연파우더와 알칼리액, 젤화제 등이 골고루 혼합되도록 혼합기를 일정 시간 가동한다. 운반용 용기를 아연젤 배출구에 대기시켰다가 일정한 용량만큼의 아연젤을 용기에 담아서 다음 공정으로 운반한다. 정밀저울을 사용해서 제조된 아연젤의 비중·무게 등을 검사한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"음극젤제조원","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C282","dJobICdNm":"[C282]일차전지 및 축전지 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007098:1', '{"dJobCd":"K000007098","dJobCdSeq":"1","dJobNm":"액상수화제제조원","workSum":"액상수화제(액상 또는 점질 액상으로 물에 희석했을 때 수화가 되는 살균제, 살충제, 제초제)를 제조하기 위하여 원·부제를 혼합·분산·분쇄하는 장치를 조작·관리한다.","doWork":"작업지시서에 명시된 배합비율대로 계면활성제, 소포제(거품 발생을 방지시킴)를 물에 혼합시켜 혼합조에 투입한다. 혼합조에 원제를 투입한 후 혼합기의 조정판에 혼합조건을 입력하고 가동한다. 저장조에 이송된 반제품의 분쇄를 위해 비드밀(Bead Mill)을 가동해 유리(Glass)나 세라믹(Ceramic) 비드와 현탄액이 혼합이 되도록 한다. 현탄액은 다이노밀(Dyno Mill)과 같은 여러 밀을 이용해 고속 회전을 시킨다. 이 회전 공정이 이루어지는 동안에 비드와 입자들이 밀착되어 입자들이 부서지게 된다. 이러한 과정을 촉진하기 위해 고체-액체 표면 사이에 흡착되는 분산제를 투입한다. 증점제, 동결방지제, 방부제, 물 등을 계량하여 투입하고 교반축을 내려 다시 교반한다. 교반이 완료되면 견본을 채취하여 주성분, 점도 등을 확인하고 일부를 품질검사부로 보낸다. 분쇄·교반이 완료된 된 반제품을 호퍼중량계에 계량하고 중량을 확인한 후 작업일지에 기록한다. 저장조로 이송하기 위하여 밸브를 열고 펌프를 가동한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"펄밀조작원","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C204","dJobICdNm":"[C204]기타 화학제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004746:1', '{"dJobCd":"K000004746","dJobCdSeq":"1","dJobNm":"여과기정화원","workSum":"반응이 완료된 내용액을 여과하기 위한 여과기를 조작·관리한다.","doWork":"방진복과 마스크를 갖추고 직무명세서를 통해 작업의 내용을 확인한다. 여과 작업이 완료가 된 후 여과망에 붙어 있는 덩어리를 세척하기 위하여 수세밸브를 열고 여과기에 물을 공급하여 수세를 한다. 일정 시간 수세 후 수세밸브를 잠근다. 압축기를 작동시켜 공기를 서서히 방출시킨다. 여과기의 여과망을 분리시켜 여과망에 붙어 있는 덩어리를 여과망에서 떼어내어 대차에 담는다. 분리되지 않은 덩어리는 주걱으로 긁어서 대차에 담는다. 대차를 저장실로 운반한다. 수동공구를 사용하여 여과기와 펌프를 분해하여 필터나 스크린에 붙어 있는 덩어리를 제거하고 용제로 깨끗이 닦는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|","workEnv":"고온|다습|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"여과기교환원","connectJob":"화학여과기조작원","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C204","dJobICdNm":"[C204]기타 화학제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004339:1', '{"dJobCd":"K000004339","dJobCdSeq":"1","dJobNm":"연육기조작원","workSum":"배합·프리믹싱(Premixing)이 완료된 안료와 바니시를 완전 혼합하여 잉크 반제품을 분산(연육)시키기 위해 분산기를 조작·관리한다.","doWork":"배합, 숙성 공정을 거친 바니시를 분산(연육)하기 위해 분산기(비드밀, 펄밀, 롤밀 등)에 분산 조건을 입력하고 호스 밸브를 연다. 분산기를 이용하여 안료 입제에 바니시와 용제가 고르게 침적되도록 물리적인 힘을 가한다. 분산기가 가동하는 중에 수시로 분산(연육) 상태를 관찰하고 롤밀의 가동소리가 비정상적일 경우 분산기를 정지시키고 롤밀을 검사한다. 조정핸들을 이용해 제품에 따라 롤 간격을 조정한다. 운전 중에 냉각수가 주입되는지 확인하고 호퍼(Hopper:분립체의 저장 및 공급장치)에 연화물이 새는지 확인한다. 분산(연육)이 완료된 바니시는 파이프나 호이스트를 이용하여 조정공정으로 이송한다. 견본을 채취하여 잉크검사원에게 보낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"니더조작원, 롤밀연화원, 연육원","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C204","dJobICdNm":"[C204]기타 화학제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002060:1', '{"dJobCd":"K000002060","dJobCdSeq":"1","dJobNm":"염료건조원","workSum":"젖은 덩어리 상태의 염료 반제품을 열풍건조기를 사용해 건조한다.","doWork":"열풍건조기의 상태를 육안으로 점검하고 가동을 시켜보면서 이상 유무를 확인한다. 여과 공정을 거친 염료 반제품 덩어리들을 건조하기 위해 열풍 건조기 안에 투입한다. 건조기의 조정패널에 온도와 송풍속도 등 각종 조건을 입력하고 가동 스위치를 누른다. 일정 시간이 지난 후 건조기를 열고 주걱 등으로 건조가 고르게 이루어지도록 뒤집어 준다. 작업지시서에 따른 일정 시간 건조 후 견본을 채취하여 건조상태를 확인한다. 표준화 공정으로 이송하기 위해 건조된 덩어리를 대차에 퍼서 담는다. 분쇄가 필요한 덩어리는 분쇄공정으로 이송을 시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|고온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"염료건조기작업원, 건조기작업원","certLic":"위험물산업기사, 위험물기능사","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C201","dJobICdNm":"[C201]기초 화학물질 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005833:1', '{"dJobCd":"K000005833","dJobCdSeq":"1","dJobNm":"염료분산기조작원","workSum":"제조된 염료의 분산도를 높이기 위하여 분산제(分散劑:고체의 미립자를 액체 속에 분산하는 데에 쓰는 약제)를 투입한 후 균일한 상태로 분산시키는 장치를 조작·관리한다.","doWork":"탈수공정 또는 건조공정을 거친 염료 덩어리를 호이스트나 리프트를 사용하여 분쇄장치에 투입한다. 밸브를 열어 표준에 따른 일정 배합비만큼 물을 공급한다. 액상이나 가루로 되어 있는 분산제를 전자저울로 계량한 후 분쇄장치에 투입한다. 작동스위치를 눌러 분산기가 회전이 되도록 가동을 한다. 이때 Media(철 또는 알루미늄 구)가 들어있는 드럼 내용물이 운동을 하여 여기서 생기는 분쇄력을 이용하여 분산 과정이 행해진다. 분산되어 나오는 1차 분산염료의 상태를 검사한다. 1차 분산이 완료되면 밀링기(세라믹 또는 글라스 비드)로 이송하여 2차 분산을 실시한다. 1차 분산과 동일한 방법으로 2차 분산을 실시하며 견본을 채취하여 색상, 점도, 분산상태 등을 점검한 후 저장 탱크로 이송한다. 이송이 완료되면 분산장비는 깨끗이 세척하며 작업시간 및 분석결과를 작업일지에 기재한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"볼밀조작원, 분산원","certLic":"위험물산업기사, 위험물기능사","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C201","dJobICdNm":"[C201]기초 화학물질 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002359:1', '{"dJobCd":"K000002359","dJobCdSeq":"1","dJobNm":"염료여과기조작원","workSum":"중화공정을 거친 염료 반제품에 포함된 각종 불순물을 제거하기 위하여 여과기를 조작·관리한다.","doWork":"여과기의 작동과 여과망의 여과 상태를 점검한 후 필요시 여과망을 교체한다. 중화된 염료 반제품을 여과기에 투입하기 위해서 밸브를 열고 펌프를 작동시킨다. 염료 덩어리가 여과망에 걸러지는지를 확인하고 여과기에 공급되는 염료 반제품의 공급 속도를 조절한다. 여과 작업이 완료된 후 여과망에 붙어 있는 덩어리를 세척하기 위하여 수세밸브를 열고 여과기에 물을 공급하여 수세를 한다. 일정 시간 수세 후 수세밸브를 잠근다. 압축기를 작동시켜 공기를 서서히 방출시킨다. 여과기의 여과망을 분리시켜 여과망에 붙어 있는 덩어리를 여과망에서 떼어내어 대차에 담는다. 분리되지 않은 덩어리는 주걱으로 긁어서 대차에 담는다. 수동공구를 사용하여 여과기와 펌프를 분해하여 필터나 스크린에 붙어 있는 덩어리를 제거하고 용제로 깨끗이 닦는다. 대차를 끌거나 용기를 리프트로 들어서 볼밀(염료분산)공정으로 운반한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"위험물산업기사, 위험물기능사","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C201","dJobICdNm":"[C201]기초 화학물질 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005484:1', '{"dJobCd":"K000005484","dJobCdSeq":"1","dJobNm":"염료표준화원","workSum":"생산 과정에서 얻어진 염료 반제품을 제품표준에 맞추기 위해 혼합기(황산나트륨 등의 염을 투입해 적정 농도로 희석시키는 장치)를 조작·관리한다.","doWork":"열풍건조기를 거치면서 완전히 건조된 염료 덩어리 또는 염료 가루를 혼합기의 표준화탱크 또는 믹서기로 운반한다. 이송 견본을 정해진 방법에 따라 일정량 채취하여 염료성분의 색강도를 제품표준과 비교·검사한다. 검사결과 염료의 색강도가 제품표준보다 높으면 황산나트륨으로 희석하기 위해 작업표준서에 명시된 표준화 배합 비율에 따라 일정량을 계량한다. 황산나트륨을 투입하고 혼합기를 가동한다. 일정 시간 혼합 후 견본을 채취하여 제품표준과 비교·검사하고 합격판정이 되면 대차에 담거나 지름이 넓은 이송호스를 혼합기 하단에 꼽고 펌프를 가동하여 포장공정으로 이송한다. 견본의 일부를 품질검사부로 보내 정밀 제품검사를 의뢰한다. 표준화 과정을 통해 얻어진 데이터는 문서화 되어 일정한 기간 동안 보관, 유지되도록 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"염료희석원","certLic":"위험물산업기사, 위험물기능사","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C201","dJobICdNm":"[C201]기초 화학물질 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005835:1', '{"dJobCd":"K000005835","dJobCdSeq":"1","dJobNm":"염료합성원","workSum":"염료를 제조하기 위하여 각종 원료 및 첨가제를 합성·결합·축합·에스테르화시켜 중화하고 여과하는 장비를 조작·관리한다.","doWork":"작업표준에 따른 일정량의 물과 원료를 반응기에 투입한 후 얼음덩어리를 함께 넣는다. 반응기의 패널에 반응조건을 입력한 후 반응기를 작동시키고 아초산소다용액을 서서히 가하면서 합성시킨다. 또 다른 반응기에서는 물, 얼음, 염산 또는 가성소다 및 각종 화학원료를 투입하여 반응기를 작동시킨다. 한쪽 반응기에서 합성된 용액을 다른 반응기에 서서히 가하여 혼합한 다음, 결합 반응 시키고 반응 완결점을 관찰·기록한다. 이 과정에서 반응기에 물, 솔벤트 및 각종 원료를 투입하기 위하여 밸브를 열고 유량계를 확인하면서 적정량을 투입한다. 반응기 재킷에 온도를 가하기 위하여 스팀밸브를 열어 축합반응이 잘 일어나도록 한다. 또한 에스테르화 반응을 시키기 위하여 밸브를 열어 반응기에 물, 유기산, 솔벤트 및 각종 화학원료를 일정량 투입하고 재킷에 스팀을 통과시켜 온도를 조절한다. 지시된 산도로 중화하기 위하여 반응이 끝난 반응물에 산 또는 알칼리를 첨가한다. 펌프를 작동시키고 여과기를 조작하여 슬러리 상태의 반응물을 여과하고 중성으로 만들기 위하여 물로 세척한다. 가공처리 중에 비중·산도 등을 실험하기 위하여 견본을 채취하고 비중계, pH미터 등을 사용하여 제품규격과 일치하는지 확인한다. 합성이 완료된 염료를 여과공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|저온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"디아조탱크작업원, 염석작업원, 축합반응원, 커플링작업원","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C201","dJobICdNm":"[C201]기초 화학물질 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003715:1', '{"dJobCd":"K000003715","dJobCdSeq":"1","dJobNm":"용융유황제조원","workSum":"황산을 제조하는 데 사용되는 용융유황을 공급하기 위하여 고체유황을 용융시키고 이송하는 장비를 조작·관리한다.","doWork":"입고된 고체유황을 기중기를 이용하여 야적장에 정리한다. 용융작업을 하기 위해 보호복과 보호안경, 보호장갑을 착용한다. 작업지시서의 내용에 따라 일일생산량을 확인하고 정해진 양의 고체유황을 용융조에 투입한다. 용융이 진행되는 동안 용융조의 온도를 체크하고 스팀밸브를 조정하여 용융온도를 조절한다. 용융된 유황을 황산 제조 공정으로 이송하기 위하여 펌프를 작동시킨다. 용융작업에 투입이 된 고체유황의 양과 용융시간, 생산량 등을 일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|고온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"유황용융원","certLic":"위험물기능사, 위험물산업기사","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C201","dJobICdNm":"[C201]기초 화학물질 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005111:1', '{"dJobCd":"K000005111","dJobCdSeq":"1","dJobNm":"원액현장감독자","workSum":"화학섬유를 제조하기 위하여 소요되는 제반 첨가액을 만드는데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"작업표준서와 작업내용을 확인하여 생산량, 제조품목, 시간계획 등을 수립하여 할당된 작업량에 따라 작업계획을 세운다. 자재를 준비·공급하고 관련 장비를 점검한다. 작업계획에 따라 작업원을 수행직무별로 훈련시키고 작업원을 선정·배치한다. 공정 중 원액의 규정 농도를 점검한다. 안전사고에 대비하여 작업원에게 안전교육을 실시한다. 작업이 완료되면 혼합된 용액의 농도가 규정과 일치하는지 점검하고 생산량을 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"고온|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","similarNm":"원액반장","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C205","dJobICdNm":"[C205]화학섬유 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005298:1', '{"dJobCd":"K000005298","dJobCdSeq":"1","dJobNm":"유기용제증류시설관리원","workSum":"폐유기용제 증류장치의 이상 유·무를 파악하고 증류방식을 결정하여 수행할 작업을 지시한다.","doWork":"폐유기용액 공급업체와 원료입고계획을 수립하고 증류시설 장치의 용량 및 정제효율을 파악한다. 수거한 폐유기용액의 사료를 채취하여 이학실험을 통해 가장 효과적인 증류방법을 결정한다. 인력을 작업장에 배치한 후 작업자에게 사전교육 및 작업방법을 설명한다. 증류장치의 각종 계기판을 점검하여 이상 유·무를 파악하고 안전사고에 대한 대책을 미리 수립한다. 증류시설 가동에 필요한 각종 기자재 및 연료를 사전에 구매한다. 가동일지를 작성하고 가동기기의 운전상태를 점검한다. 고순도 유기용액의 저장고 및 탱크 용량을 계산하여 정제할 폐유기용제의 투입량을 산정한다. 유기용제증류정제원에게 작업지시를 하달하고 공급업체로 운송 시 필요한 차량을 미리 확보한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","certLic":"산업안전산업기사, 산업안전기사","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"E383","dJobICdNm":"[E383]해체, 선별 및 원료 재생업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004508:1', '{"dJobCd":"K000004508","dJobCdSeq":"1","dJobNm":"유기용제증류정제원","workSum":"작업지시서에 따라 폐유기용제 증류장치를 조작한다.","doWork":"작업지시서에 따라 폐유기용액 원료를 이용 증류시설 장치를 이용하여 관련 설비를 조작하는 업무를 담당한다. \n수거한 폐유기용액의 사료를 채취하고 관리자로부터 사전교육 및 작업방법을 지시 받는다. \n증류장치의 각종 계기판을 점검하여 이상 유·무를 파악하고 안전사고에 유의하여 작업한다. \n증류시설 가동에 필요한 각종 기자재 및 연료 사전 구매 할수 있도록 재고를 관리한다. \n가동일지를 작성하고 가동기기의 운전상태를 점검한다. \n투입량 산정에 필요한 고순도 유기용액의 저장고 및 탱크의 재고를 관리한다\n유기용제증류시설관리원으로부터 작업지시를 받아 필요한 조치를 실시한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"위험물기능사, 산업안전산업기사(삭제), 산업안전기사(삭제)","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"E383","dJobICdNm":"[E383]해체, 선별 및 원료 재생업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001994:1', '{"dJobCd":"K000001994","dJobCdSeq":"1","dJobNm":"유화플레이크공정원","workSum":"3차 반응을 거친 섬유유연제 반제품을 유화하고 얇은 조각(플레이크)으로 만들기 위하여 유화기 및 혼합기를 조작·관리한다.","doWork":"유화조에 공급호스를 연결하고 펌프를 가동하여 3차 공정을 거친 섬유유연 제반 제품을 이송받는다. 작업 표준상의 배합비에 따라 유화제를 계량하여 투입한다. 유화조의 조정판에 유화조건(온도, 교반속도)을 입력한 후 가동한다. 유화조건이 일정하게 유지되는지 관찰하고 이상이 발생하면 신속한 조치를 취한 후 작업일지에 기록한다. 유화가 완료되면 하단의 배출밸브에 호스를 연결하고 펌프를 가동하여 혼합기로 이송한다. 혼합기를 가동하고 혼합기를 통과한 반제품이 제품표준에 명시된 규격과 동일한지 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|고온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"1차반응기조작원, 2차반응기조작원","certLic":"위험물기능사","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C201","dJobICdNm":"[C201]기초 화학물질 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004387:1', '{"dJobCd":"K000004387","dJobCdSeq":"1","dJobNm":"이온수지투입원","workSum":"제조된 액체여과기 내에 투입되는 양이온수지를 이온수지투입기에 넣고 기계를 작동하여 양이온 수지를 액체여과기 내에 투입한다.","doWork":"작업지시서에 따라 가공 및 제작된 액체여과기제품을 확인한다. 투입할 이온수지를 운반하여 투입기에 넣어 준비한다. 액체여과기의 규격에 따라 투입할 양이온수지의 양을 확인한다. 작업표준서에 따라 일정량의 양이온수지를 액체여과기 내에 투입한다. 액체여과기 내에 일정한 양의 이온수지가 투입되는지 확인한다. 투입이 완료된 액체여과기를 투입기에서 분리하여 적재한다. 적재한 완성품을 다음 공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C291","dJobICdNm":"[C291]일반 목적용 기계 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004866:1', '{"dJobCd":"K000004866","dJobCdSeq":"1","dJobNm":"잉크교반원","workSum":"잉크를 제조하기 위한 분산작업을 원활히 수행하기 위해 안료와 바니시를 섞어 주는 프리믹싱(Premixing)을 한다.","doWork":"반응기를 거쳐 제조가 된 바니시와 각종 안료, 첨가제를 이송시킨 후 교반기의 혼합탱크에 순서대로 투입을 한다. 교반기의 조작판넬에 시간, 온도 등의 조건을 입력한 후 일정 시간 동안 배합을 시킨다. 이때 교반기의 혼합탱크에서는 먼저 좌우화전이 된 후 상하회전이 이루어진다. 교반기 유리창을 통하여 배합이 잘 이루어지는지 육안으로 관찰하고 필요시 교반기를 정지시킨 후에 적절한 조치를 취한다. 배합이 완료되면 밸브를 열고 펌프를 가동해, 숙성을 시킨 후 분산공정으로 이동이 되도록 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"잉크교반기조작원, 잉크배합기조작원","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C204","dJobICdNm":"[C204]기타 화학제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007283:1', '{"dJobCd":"K000007283","dJobCdSeq":"1","dJobNm":"잉크조정원","workSum":"잉크검사원의 교정지시에 따라 잉크의 점도, 컬러 및 기타 물성 등을 제품표준에 일치하도록 조정하여 완제품을 생산한다.","doWork":"잉크검사원이 각종 검사와 시험을 통해 작성한 교정지시서 내용을 확인해 조정작업을 준비한다. 바니시를 이동시킨 후 필요한 각종 보조제와 용제를 준비한다. 분산공정을 통해 분산이 완료된 바니시에 인쇄적성에 맞게 보조제 및 용제를 섞어 조정탱크 안에 투입한다. 조정탱크의 조정판에 속도와 온도, 조건 등을 입력한다. 조정탱크 안에서 먼저 좌우 회전시킨 후 다시 상하 회전시켜 물성 및 색상 상태를 조정한다. 일정 시간이 경과 된 후 조정탱크의 작동을 멈춘 후 견본을 채취해 잉크검사원에게 보낸다. 합격 판정이 되면 밸브를 열고 펌프를 가동하여 완성된 잉크를 포장공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|다습|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C204","dJobICdNm":"[C204]기타 화학제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004434:1', '{"dJobCd":"K000004434","dJobCdSeq":"1","dJobNm":"전물침출원","workSum":"양극 조동 중에 함유되어 있는 전해액 중의 불용성인 양극전물에서 금, 은, 셀레늄 등을 회수하는 장치를 조작한다.","doWork":"양극전물을 전해액과 함께 펌프를 사용하여 전물침줄조로 보내고 증기와 공기를 주입시켜 침출하여 동을 용해시킨다. 여과기에서 여과하여 회수한 전물을 귀금속부서로 인계한다. 증기 및 공기밸브를 열어 전물출조로 송입·침출하여 전해액에서 용해 가능한 동을 회수한다. 침출 완료 후 전물 여과기에서 여과하여 물로 세척하고 공기로 건조시켜 드럼통에 담아 평량하고 귀금속부서로 인계한다. 침출 후 액을 펌프를 가동시켜 셀레늄 치환조에 보내 액 중에 함유된 셀레늄을 제거한다. 셀레늄 치환조에 동설과 증기를 공급하고 교반기를 가동시켜 치환작업을 한다. 치환작업 후 여과기에서 여과하여 셀레늄을 회수한다. 셀레늄 치환작업 시 침출 후 액 중 산농도를 분석한 후 황산을 보충한다. 전물침출 작업 시 전물농도를 측정하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"다습|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"점물처리원","certLic":"화학분석기능사","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C242","dJobICdNm":"[C242]1차 비철금속 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001876:1', '{"dJobCd":"K000001876","dJobCdSeq":"1","dJobNm":"전지합제성형원","workSum":"알칼라인전지 제조에 사용되는 혼합된 합제를 일정한 형태로 성형하고 용기에 삽입하는 기계를 조작한다.","doWork":"알칼라인전지에 사용되는 합제성형의 경우 분말형태의 합제를 성형기 상부의 합제투입기에 투입하고 합제배출 밸브를 조절한다. 합제성형기를 가동하고 원하는 규격에 맞게 합제가 성형되고 있는지 감시한다. 성형된 합제가 적정한 힘으로 철관(Can)에 삽입되도록 기계를 조정한다. 기계를 가동하고 자동으로 아연관에 충전되는 합제와 전해액의 양이 작업명세서와 일치하는지 관찰한다. 전해액이 합제가 성형된 아연관의 정중앙에 올바르게 주입되고 있는지 관찰한다. 알칼라인전지에 사용되는 합제를 성형하고 용기에 삽입하고 난 후, 합제의 외관, 치수, 합제의 삽입 상태 등을 육안 및 검사기기로 검사하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"합제충전원, 망간아연전지합제충전춴, 1차전지합제충전원, 알카리합제충전원","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C282","dJobICdNm":"[C282]일차전지 및 축전지 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001640:1', '{"dJobCd":"K000001640","dJobCdSeq":"1","dJobNm":"접착제제조원","workSum":"테이프 접착제를 제조하기 위하여 원료를 혼합·분쇄하는 교반기를 조작·관리한다.","doWork":"작업지시서를 보고 점착제의 종류 및 특징에 맞는 온도, 교반시간, 교반방법 등을 확인한다. 교반기의 작동상태 및 고무, 아크릴, 실리콘 계통의 원료와 노화방지제, 수지류 등의 배합제를 점검한다. 교반기에 원료와 부원료를 일정량 투입하고 온도, 교반시간 등을 조절하고 교반기를 가동한다. 교반기 내의 혼합물이 균일하게 분쇄되고 혼합되는지 육안으로 확인한다. 교반이 끝난 점착제를 적정온도로 유지된 저장탱크로 옮긴다. 견본을 채취하여 관련 부서에 검사를 의뢰한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"균형감각|","workEnv":"대기환경미흡|위험내재|고온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"원료혼합원","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C222","dJobICdNm":"[C222]플라스틱제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006235:1', '{"dJobCd":"K000006235","dJobCdSeq":"1","dJobNm":"조립식입제제조원","workSum":"국수가락 모양의 조립식 입제(원제를 보조제와 혼합하고 물에 반죽한 후 조립기를 이용해 입자의 형태로 뽑고 건조시킨 살균제·살충제·제초제)를 제조하기 위해 각종 장치(혼합기, 분쇄기, 반죽기, 조립기, 선별기 등)를 조작·관리한다.","doWork":"1차 혼합기에 고상원제, 반제품 결합제, 보조제, 증량제 등의 원·부제를 계량하여 투입한다. 여기에 분산액의 습전성을 높일 수 있는 액상 계면활성제를 투입한다. 혼합기의 조정판에 혼합조건을 입력하고 상단의 교반축을 내린다. 혼합기를 일정 시간 가동한다. 교반 및 혼합상태를 육안으로 관찰한다. 원료가 액상일 경우 배합비에 따라 혼합과정 중에 노즐을 통하여 분사되도록 한다. 혼합이 완료되면 분쇄기와 연결된 호스를 혼합기 하단의 배출밸브에 연결한다. 제품에 따라 적당한 날을 선택하고 분쇄기를 가동한다. 분쇄기에 투입되는 혼합물의 양은 호스에 연결된 유량계를 통해서 제어한다. 분쇄가 완료되면 호스를 2차 혼합기에 연결하고 이송한다. 2차 혼합이 완료되면 대차 및 용기에 담아 분상저장조로 운반하여 보관한다. 일일 작업량에 따라 분상저장조로부터 보관된 반제품을 운반해 반죽기에 투입한다. 반죽되는 상태를 관찰하고 반죽이 완료되면 조립기를 가동한다. 반제품이 국수가락처럼 뽑아져 나오는 상태를 만져보거나 육안으로 관찰한다. 조립이 끝나면 건조기로 운반하고 일정 조건에서 건조되도록 건조기의 입력값을 조정한다. 건조가 완료되면 절단기에 투입하여 일정 크기로 잘려지는 상태를 관찰한다. 잘려진 반제품을 선별기에 투입하여 입자를 선별한다. 선별된 반제품을 대차에 적재하여 저장조로 운반한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C204","dJobICdNm":"[C204]기타 화학제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005844:1', '{"dJobCd":"K000005844","dJobCdSeq":"1","dJobNm":"조산기조작원","workSum":"배소공정에서 발생한 이산화황(SO₂) 가스를 건조, 전화, 흡수공정을 거쳐 황산으로 제조하는 설비를 조작한다.","doWork":"냉각탑 교환산을 점검하고 교환산 밸브를 조절한다. 희석수 주입량, 각 탱크의 상태, 산농도, 순환산온도, 냉각수량, 누산 여부 등을 조절하고 확인한다. 모터를 가동시켜 진동상태를 점검한다. 산가스 버너에 불을 붙이고 압력, 냉각수 온도, 풍량 등을 조절한다. 전화기 각 층의 온도를 점검하고 고온이나 저온일 경우 가스 밸브를 조작하여 온도를 조절한다. 전화기 내의 압력손실 및 누산 여부를 점검한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C242","dJobICdNm":"[C242]1차 비철금속 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002310:1', '{"dJobCd":"K000002310","dJobCdSeq":"1","dJobNm":"조산현장감독자","workSum":"배소로에서 정제된 가스를 황산제조설비로 흡입하여 황산을 제조하는데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"황산 생산계획에 따라 작업원의 인원관리, 작업분배, 안전교육, 제반 기술교육을 실시한다. 흡입탑, 집진기, 건조기, 열교환기, 냉각탑 등의 설비를 점검·확인한다. 제조하는 산 농도를 작업원에게 지시하고 농도를 관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"다습|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","similarNm":"황산반장, 조산반장","certLic":"위험물산업기사, 위험물기능사","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C242","dJobICdNm":"[C242]1차 비철금속 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005243:1', '{"dJobCd":"K000005243","dJobCdSeq":"1","dJobNm":"조색공정원","workSum":"다양한 색상의 안료를 생산하기 위하여 원재료들을 일정 규격의 입도로 분쇄하고 혼합한 후 색상을 맞춘다.","doWork":"만들고자 하는 안료의 색상에 따라서 원재료가 많은 차이를 보이기 때문에 작업지시서 및 조색표에 따라 정확한 재료들을 준비한다. 혼합기를 가동시킨 후 이송되어 온 안료를 호이스트에 걸어 분쇄기의 투입구에 위치시키고 입구를 기울여 안료를 투입한다. 분쇄기를 가동하고 일정한 입도로 분쇄가 완료되면 혼합기의 투입밸브를 열어 분쇄된 안료를 투입한다. 일정 시간 혼합기를 가동한 후 수시로 견본을 채취하여 조색표와 비교한 후 첨가물을 투입하여 색상을 맞춘다. 제품표준색상과 일치할 때까지 반복적으로 첨가제 투입, 혼합, 색상 비교 작업을 반복한다. 색상이 맞추어지면 포장공정으로 이송하기 위하여 혼합기 하단에 있는 밸브를 열고 지대를 제품 출구에 끼운다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|시각|","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"조색원","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C204","dJobICdNm":"[C204]기타 화학제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004619:1', '{"dJobCd":"K000004619","dJobCdSeq":"1","dJobNm":"중소다용해공정원","workSum":"안료를 제조하기 위하여 중크롬산소다를 용해하는 용해조를 조작·관리한다.","doWork":"계량조의 눈금을 확인한 후 밸브를 열어 중소다를 용해조 상부 투입구에 투입한다. 이때 서로 다른 탱크에 원료와 부원료를 계량하여 투입한 후 배합비에 따라 일정량의 물을 용해조에 투입해야 한다. 용해조 투입구를 닫고 용해조의 조정판에 용해조건을 입력한 후 가동시킨다. 용해가 완료되면 이송 펌프를 가동해 용해조와 수직적으로 배열이 된 주반응조(제조가 된 질산납과 반응을 시켜 크로뮴산납을 생성)로 이동시킨다. 견본을 채취하여 산도(pH)를 측정하고 가성소다를 사용하여 조절한다. 냉각밸브를 열어 용해조를 일정 온도까지 냉각시킨다. 용해조 내부의 온도변화를 확인하면서 냉각밸브를 조절한다. 작업 중에는 용해조에서 발생되는 수증기, 산 가스 등이 배기라인을 통해서 잘 배출이 되는지를 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C204","dJobICdNm":"[C204]기타 화학제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004647:1', '{"dJobCd":"K000004647","dJobCdSeq":"1","dJobNm":"중합반응기조작원","workSum":"합성수지를 제조하기 위하여 수지 원료 및 각종 부자재들을 중합(Polymerization, 重合)하는 중합반응기 및 관련 설비를 조작·관리한다.","doWork":"작업지시서의 내용에 따라 제조를 하고자 하는 합성수지의 생산량을 파악한 후, 각종 수지 원료 및 첨가제 등의 수량을 파악하고 준비한다. 혼합물의 배합량을 확인하고 중합반응기의 상태를 점검한다. 작업지시서의 배합 내용 또는 중앙조정실운전원의 지시에 따라 원료를 계량하거나 펌프를 작동시켜 배합원료를 중합반응기에 투입한다. 중합반응기 조정패널에 반응조건(압력, 온도, 교반속도 등)을 입력하고 버튼을 눌러 교반 작업을 한다. 반응 도중 수시로 견본을 채취하여 점도, 색, 외관 등을 검사하고 제품규격과 차이가 있을 경우 반응시간·온도 등을 재조정하여 반응시킨다. 제품에 따라 탈수기를 사용하여 탈수작업을 하는 경우도 있다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"반응기조작원","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C201","dJobICdNm":"[C201]기초 화학물질 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005201:1', '{"dJobCd":"K000005201","dJobCdSeq":"1","dJobNm":"중화조조작원","workSum":"화학조미료의 글루타민산나트륨(MSG)을 제조하기 위하여 글루타민산액에 가성소다(수산화나트륨)를 첨가하여 중화하는 기계(중화탱크)를 조작·관리한다.","doWork":"중화탱크의 투입밸브를 열고 이송펌프를 가동하여 분리기에서 분리된 글루타민산액을 투입한다. 중화탱크의 유량계를 확인한 후, 일정 비율의 가성소다를 첨가해 알칼리로 중화시키기 위하여 중화탱크의 온도를 일정하게 유지한다. 수시로 견본을 채취하여 중화상태를 점검한다. 중화가 완료된 글루타민산나트륨(MSG) 용액을 정제공정으로 이송하기 위하여 배출밸브를 열고 이송펌프를 가동한다. 투입한 가성소다용액의 수량과 중화시간을 작업일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"식품산업기사, 식품가공기능사","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004801:1', '{"dJobCd":"K000004801","dJobCdSeq":"1","dJobNm":"질산납용해공정원","workSum":"안료를 제조하기 위하여 납을 일정 농도의 질산액에 녹여 질산납을 제조하는 장치를 조작·관리한다.","doWork":"방진 작업복과 마스크를 착용하고 작업명세서의 내용을 확인한다. 납 1개의 무게를 저울에 달아 무게를 측정하고 전체 납의 중량을 파악하여 납의 개수를 파악한다. 적재된 납을 호이스트에 걸어 용해조에 투입하고, 용해조 상부의 투입구를 밀폐시킨 후 버너를 작동시켜 용해시킨다. 용해작업 중에는 교반과 작업 확인을 위해 투입구를 여는 일이 없도록 한다. 반응조에 납을 투입하기 위하여 투입밸브를 열고 펌프를 가동한다. 유량계를 확인하면서 밸브를 조절한다. 납용해로 밸브를 열어 용해된 납을 반응조에 투입하고 반응조에 납이 골고루 분산되는지 육안으로 확인한다. 샤워펌프를 가동하고 샤워수의 pH를 검사하여 가성소다로 소량씩 적정한다. 반응조의 스팀밸브를 수시로 여닫으면서 반응조의 액이 넘치지 않도록 한다. 산도(pH)를 확인하여 작업표준에 부합되면 스팀밸브를 잠그고 샤워펌프를 중지시킨다. 작업 중에는 용해조와 반응조에서 발생이 되는 수증기, 산 가스 등이 배기라인을 통해서 잘 배출이 되는지를 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C204","dJobICdNm":"[C204]기타 화학제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002117:1', '{"dJobCd":"K000002117","dJobCdSeq":"1","dJobNm":"축전지연분원","workSum":"축전지에 사용되는 연분을 제조하기 위해서 순연 덩어리를 용해하고 연분(산화납 분말)으로 바꾸는 연속적인 기계들을 관리한다.","doWork":"납을 둥근 구 형태로 성형하는 기계 안에 용융된 납을 투입하고 연속적으로 저장통 안에 둥근 모양의 납을 방출하는 설비를 관리한다. 자동으로 연구를 연분으로 바꿔주는 납연분기 속에 일정 수의 연구를 투입한다. 작업명세서에 따라 연구가 완전히 분쇄되어 납산화물이 될 때까지 연분기를 가동시킨다. 일정한 크기의 산화연분 입자만을 거르기 위해서 산화납 여과기를 가동시킨다. 각종 시험기구를 사용해서 산화납 분말의 무게 및 산화율을 검사한다. 작업명세서의 기준과 일치하지 않는 분말을 재가공 처리한다. 납을 둥근 구 형태로 성형하는 기계 안에 용융된 납을 투입하고 연속적으로 저장통 안에 둥근 모양의 납을 방출하는 설비를 관리한다. 자동으로 연구를 연분으로 바꿔주는 납연분기 속에 일정 수의 연구를 투입한다. 작업명세서에 따라 연구가 완전히 분쇄되어 납산화물이 될 때까지 연분기를 가동시킨다. 일정한 크기의 산화연분 입자만을 거르기 위해서 산화납 여과기를 가동시킨다. 각종 시험기구를 사용해서 산화납 분말의 무게 및 산화율을 검사한다. 작업명세서의 기준과 일치하지 않는 분말을 재가공 처리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|다습|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"산화납분쇄기관리원","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C282","dJobICdNm":"[C282]일차전지 및 축전지 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006117:1', '{"dJobCd":"K000006117","dJobCdSeq":"1","dJobNm":"축전지연화물혼합원","workSum":"축전지의 음극판에 도포되는 연화물(활물질 페이스트)을 제조하기 위하여 혼합기를 사용하여 연분(산화납분말), 황산, 물 및 기타 화학물질 등의 첨가제를 혼합한다.","doWork":"극판 제조를 위한 연분과 주조작업을 거쳐 그리드경화가 된 Ca그리드의 상태를 확인한다. 자동저울 및 계량장치를 사용해서 연분 공정으로부터 얻어진 연분(산화납분말), 물, 황산 등을 측정·계량한다. 배합표에 따라서 일정한 비율로 계량된 원료를 혼합기에 투입한다. 혼합기를 작동시키고 밸브를 조정해서 물과 황산을 투입한다. 시험기구를 사용해서 연화물 견본의 온도·밀도 등을 시험하고 결과를 기록한다. 작업을 종료한 후 기계를 청소한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C282","dJobICdNm":"[C282]일차전지 및 축전지 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007103:1', '{"dJobCd":"K000007103","dJobCdSeq":"1","dJobNm":"축전지전해액혼합원","workSum":"축전지의 전해조 안에 전류가 통하는 매체가 되는 용액인 전해액을 제조하기 위하여 혼합기를 사용하여 황산, 물 및 기타 화학물질 등의 첨가제를 혼합한다.","doWork":"제품의 특성에 따라 황산과 물(증류수), 기타 화학물질을 계량하여 준비한다. 혼합비율에 따라 물과 화학물질을 혼합기에 넣어 혼합하고 황산을 투입하여 혼합한다. 혼합된 전해액을 채취하여 비중검사를 의뢰한다. 제조가 완료된 전해액은 충전을 위해 보관탱크로 이송시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C282","dJobICdNm":"[C282]일차전지 및 축전지 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005748:1', '{"dJobCd":"K000005748","dJobCdSeq":"1","dJobNm":"측색시험원","workSum":"롤링공정을 마친 각종 물감의 색상이 제품표준과 일치하는지 견본을 채취해 검사하고 재배합을 하도록 교정지시서를 작성한다.","doWork":"롤링공정을 거친 물감 반제품의 견본을 채취해 비커에 담는다. 숙성실에 보관된 물감에서 견본을 채취하여 비커에 담는다. 물을 적신 화필을 각각의 비커에 담근 후 꺼내서 검색지나 평유리에 대고 좌우 및 상하 방향으로 칠한 후에 그 칠한 면이 균일하도록 반복해서 칠한다. 조명을 수직 방향에서 비추고 일정 방향에서 관찰한다. 물감 반제품의 색상이 견본 제품과 일치하는지를 표준색상도와 비교한다. 검사결과를 작성하고 이상이 있으면 교정지시서를 작업자에게 보내 재배합하도록 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"시각|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C204","dJobICdNm":"[C204]기타 화학제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003904:1', '{"dJobCd":"K000003904","dJobCdSeq":"1","dJobNm":"탈색여과기조작원","workSum":"화학조미료를 제조하기 위하여 중화된 글루타민산나트륨(MSG)에 포함된 이물질을 여과하고 활성탄(活性炭)으로 탈색하는 기계를 조작·관리한다.","doWork":"탈색조에 활성탄을 채우고 여과기 내부의 여과망을 점검한다. 이온교환 수지탑에 양이온과 음이온을 순서대로 채우고 저장탱크의 배출구를 수지탑의 투입구에 연결한다. 글루타민산나트륨 용액 저장탱크의 유량계를 확인하고 견본을 채취하여 용액의 산도(酸度)를 검사한다. 글루타민산나트륨(MSG) 용액을 알칼리로 중화하기 위하여 저장탱크의 투입구를 열고 일정 비율의 암모니아나 가성소다 등의 중화제를 투입한다. 혼합이 용이하도록 교반기를 가동한 후, 혼합이 완료되면 활성탄이 채워진 탈색조로 이송하기 위하여 펌프를 가동한다. 탈색된 용액의 견본을 채취하고 용액 중에 포함된 이물질을 제거하기 위하여 여과포와 이온교환수지가 부착된 여과기로 이송한다. 용액에 포함된 불순물을 완전히 제거하기 위하여 같은 방법을 수차례 반복한다. 각 공정의 견본을 채취하여 용액 중에 포함된 이물질의 잔류 유무를 검사한다. 자동화된 기계의 조정판에 중화제의 투입량, 교반기의 가동시간, 탈색기의 투입시간, 여과기의 투입시간 등을 입력하여 탈색 및 여과되는 과정을 관찰·조절하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"식품산업기사, 식품가공기능사","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005269:1', '{"dJobCd":"K000005269","dJobCdSeq":"1","dJobNm":"폴리염화알루미늄제조원","workSum":"수산화알루미늄과 염산을 이용해서 폴리염화알루미늄(P.A.C:Polyaluminium Chloride)을 제조하는 제어장치를 조작·관리한다.","doWork":"제조를 하고자 하는 폴리염화알루미늄(P.A.C:Polyaluminium Chloride)의 염기도를 확인한 후 작업표준에 따른 수산화알루미늄과 염산의 적정량을 준비한다. 컴퓨터로 작동되는 자동 계량장치가 부착된 혼합조에서 정량의 수산화알루미늄과 염산을 작업표준에 따라 일정량씩 계량하도록 자동계량기의 수치를 입력하고 가동버튼을 눌러 혼합한다. 교반된 혼합액을 공기수송설비를 이용하여 자동으로 반응조에 이송한다. 제어판의 모니터를 관찰하면서 혼합상태를 관찰한다. 제어판에 반응온도와 시간을 입력한다. 중합촉진제 및 응집보조제(소석회, 가성소다)를 배합비에 따라 물이 충진된 탱크에 투입하고 교반하여 용해한다. 용해가 완료되면 하단부의 밸브를 열고 펌프를 가동하여 희석탱크로 이송한다. 중화제와 안정제를 희석탱크에 투입하고 일정 시간 반응시킨다. 반응이 완료되면 밸브를 열고 펌프를 가동하여 여과조로 이송한다. 필요시 여과망을 교체한다. 견본을 채취하여 품질검사부로 보낸다. 여과가 완료되면 펌프를 가동하여 제품저장탱크로 이송·보관한다. 원료투입에서 검사까지 전 공정을 컴퓨터에 의하여 자동으로 조업한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"위험물기능사, 위험물산업기사","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C201","dJobICdNm":"[C201]기초 화학물질 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004607:1', '{"dJobCd":"K000004607","dJobCdSeq":"1","dJobNm":"피복수지배합원","workSum":"절연전선을 피복하는 각종 수지류를 제조하기 위해서 배합제와 가소제를 배합기에 투입하여 배합한다.","doWork":"작업지시서에 따라 색상배합제 처방, 가소제, 수지류, 배합제를 작업장소에 운반하고 배합표에 따라서 무게를 측정한다. 스팀밸브를 열어 배합기의 온도를 조정하고 원료의 무게를 측정하여 배합기에 투입한다. 배합기의 뚜껑을 닫고 스위치를 넣어 가동시킨 후 가소제를 투입하고 일정 시간 배합한다. 일정 시간이 지난 후 냉각기를 가동하고 냉각된 원료를 빼서 압출기의 호퍼에 투입한다. 배합일지에 원료명, 색상, 투입량 등을 기록한다. 압출기 호퍼를 청소한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C283","dJobICdNm":"[C283]절연선 및 케이블 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002746:1', '{"dJobCd":"K000002746","dJobCdSeq":"1","dJobNm":"합성수지제조현장감독자","workSum":"합성수지를 제조하는 담당 공정을 책임지고 안전하고 안정되게 운전되도록 할 책임이 있으며, 중앙조정실운전원 및 현장운전원들이 해당 조원들의 활동을 감독·조정한다.","doWork":"수지제조원들의 업무 내용과 책임 한계를 명확히 해 효율적인 생산이 이루어지고 안전사고가 발생되지 않도록 작업지시서에 따른 업무 분장을 한다. 제조원들에게 안전과 관련이 된 규정을 교육시키고, 안전 관련 규정의 준수 여부를 확인하고 점검한다. 원료의 공정 투입 현황을 파악하고, 각 합성수지 제품의 규격별로 생산 확인을 하면서 적정 생산량을 관리한다. 작업장의 장치 및 기기에 대해 이상 여부를 확인하고 조작원들에게 제반 사항에 대해 조치를 취하도록 하며, 문제점을 파악해 상부에 보고를 한 후 지시를 받는다. 작업장 주변의 정리정돈상태를 점검하고 개선을 한다. 환경에 대한 법적 규정에 따라 안전 운전을 하고 규정 준수 여부를 철저히 확인한다. 공정 위험 요소를 발견해 보고하기도 한다. 수시면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴하고 문제점을 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","similarNm":"합성수지제조반장","certLic":"위험물기능사, 위험물산업기사","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C202","dJobICdNm":"[C202]합성고무 및 플라스틱 물질 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005567:1', '{"dJobCd":"K000005567","dJobCdSeq":"1","dJobNm":"합성수지조색원","workSum":"합성수지 제품의 다양한 색깔을 내기 위하여 안료의 종류를 결정하고 안료원료를 배합한다.","doWork":"작업지시서 및 견본을 읽거나 보고 색상카드와 비교한다. 여러 가지 색깔의 안료 및 PVC·가소제·충진제·안정제 등을 저울에 계량하고 밀폐혼련기에 넣어 혼련한다. 혼련된 합성수지 배합물의 시료를 채취하여 견본과 대조한다. 견본과 합성수지 배합물의 색상을 비교하여 색상이 다를 경우 그에 맞는 색깔의 안료를 다시 배합하고 비교하여 색상이 일치할 때까지 반복작업을 한다. 견본과 색상이 일치할 경우 투입된 색안료의 투입량과 색상을 색상카드에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"시각|","workEnv":"대기환경미흡|위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"합성수지안료배합원","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C222","dJobICdNm":"[C222]플라스틱제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005453:1', '{"dJobCd":"K000005453","dJobCdSeq":"1","dJobNm":"합성수지혼합기조작원","workSum":"플라스틱 제품에 사용되는 PVC, 가소제, 충진제, 안정제 등의 재료 및 안료를 배합·혼합하기 위하여 혼합기를 조작·관리한다.","doWork":"작업지시서를 확인하여 제조할 플라스틱 제품의 종류와 생산량을 확인한다. 합성수지 제품의 생산에 투입될 수지와 가소제, 충진제, 안정제, 안료 등의 첨가제를 혼합비에 따라 계량하여 준비한다. 혼합조건을 확인하고 온도, 속도를 등을 제어판에 입력한다. 투입 순서에 따라 원재와 부재를 혼합기에 넣어 일정 시간 배합한다. 혼합과정을 관찰하여 이상이 없는지 관찰한다. 시료를 채취하여 검사를 의뢰한다. 혼합이 완료되면 다음 공정으로 이송한다. 혼합기의 점검하고 이상 시 조치를 의뢰한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C222","dJobICdNm":"[C222]플라스틱제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006172:1', '{"dJobCd":"K000006172","dJobCdSeq":"1","dJobNm":"합성염산제조설비운전원","workSum":"전해조를 거치면서 기체 상태로 얻어진 염소와 수소 가스를 정제·반응시켜 염산을 제조하는 설비를 운전한다.","doWork":"전해조에서 전기분해가 되어 기체 상태로 합성 염산 공정에 이송된 염소, 수소가스의 양을 확인한다. 염산을 만드는 반응을 하기 전에 수소가스는 정제를 하고, 염소가스는 정제와 정화 과정을 거친다. 합성탑에 냉각수를 공급하기 위하여 냉각수 공급밸브를 열고 펌프를 가동한다. 수소가스가 점화되었는지를 확인하고 염소와 수소가스의 유량계를 조절하여 적정 비율로 조절한다. 내부 압력과 온도를 게이지를 통해 확인한다. 반응이 완료된 후 생산된 염산의 견본을 채취하여 제품규격과 일치하는지 비교·확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|","workEnv":"위험내재|고온|다습|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"합성염산중앙조정실운전원","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C201","dJobICdNm":"[C201]기초 화학물질 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006601:1', '{"dJobCd":"K000006601","dJobCdSeq":"1","dJobNm":"형광물질혼합원","workSum":"형광등, 3파장램프, 백색 LED전구와 같은 유리전구에 사용되는 형광물질을 제조하기 위해 여러 가지 화공약품을 배합하는 기계를 조작한다.","doWork":"형광물질 제조에 사용되는 산화물, 질소화물, 황화물, 셀레늄화물 등의 원료를 저울로 계량하고 건조기에 넣어 건조시킨다. 배합표에 따라서 원료를 배합기에 투입하고 일정 시간 동안 배합기를 가동시켜서 원료를 골고루 배합한다. 배합된 형광물질의 견본을 채취해서 배합비, 점도, 비중, 온도 등을 검사한다. 다음 공정으로 보내기 위해 배합된 형광물질을 준비된 통에 붓는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C284","dJobICdNm":"[C284]전구 및 조명장치 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006883:1', '{"dJobCd":"K000006883","dJobCdSeq":"1","dJobNm":"형석건조기조작원","workSum":"아세틸렌(Acetylene:C₂H₂) 가스를 제조하기 위해 필요한 형석(CaF₂)을 건조하는 건조기를 조작한다.","doWork":"건조에 필요한 건조기, 정제탑, 컨베이어벨트를 점검하고 가동을 한다. 형석(아세틸렌 가스의 생산을 위한 칼슘카바이드 제조에 필요함)을 컨베이어벨트에 투입한다. 매시간 계기판을 점검하고 온도, 압력계를 조작하여 공정을 유지한다. 건조기를 포함한 관련 기기를 점검하고 유지 관리한다. 점검사항, 건조량 등을 작업일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실외","physicalAct":"웅크림|","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"D352","dJobICdNm":"[D352]연료용 가스 제조 및 배관공급업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003900:1', '{"dJobCd":"K000003900","dJobCdSeq":"1","dJobNm":"화학물분쇄기조작원","workSum":"프리믹스(Premix)된 도료 반제품을 제조하기 위해 입자를 일정한 크기로 분쇄시키는 분쇄기를 조작·관리한다.","doWork":"분쇄기(Kneader)의 작동상태를 점검한다. 배합된 혼합물을 분쇄기에 투입하고자 해당 밸브를 열고 펌프를 가동한다. 전동핸들을 올려 전동장치가 가동되고 전동기아가 돌아가도록 한다. 반원통형인 분쇄기(Kneader)의 양 벽에 있는 큰 각반날개가 서로 역방향이 되면서 분쇄작업이 이루어지도록 한다. 일정 시간 분쇄기를 작동시킨 후 견본을 채취하여 육안 또는 입도계를 사용하여 분쇄상태를 검사한 후 분쇄 횟수를 결정한다. 분쇄가 완료되면 분쇄기를 중지시키고 밸브를 열어 빈 용기에 담는다. 분쇄작업이 완료되면 용제를 사용하여 분산기의 내부를 세척한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"롤밀조작원, 볼밀조작원, 샌드밀조작원","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C204","dJobICdNm":"[C204]기타 화학제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006718:1', '{"dJobCd":"K000006718","dJobCdSeq":"1","dJobNm":"화학반응기조작원","workSum":"도료건조제를 제조하기 위하여 원료 및 부원료를 반응시키는 반응기를 조작·관리한다.","doWork":"액체원료는 반응기의 액체원료 계량조에 투입을 하고, 고체원료는 판상이나 터빈(Turbine)형의 교반기가 있는 반응기의 호퍼(Hopper:분립체의 저장 및 공급장치)에 투입을 한다. 반응기의 제어판에 반응조건(온도, 교반속도)을 입력하고 상부에 달려 있는 교반기를 내린 후 반응기를 작동시킨다. 반응기가 작동하면 교반기의 작동 유무를 확인하고 일정 시간 반응시킨다. 반응이 완료되면 용수 밸브를 열어 반응기 내에 물을 공급하여 수세한다. 수세 완료 후 조정판에 온도를 저온으로 조정하고 진공펌프를 가동하여 수분을 제거한다. 탈수가 완료되면 이송밸브를 열어 여과 공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C204","dJobICdNm":"[C204]기타 화학제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006843:1', '{"dJobCd":"K000006843","dJobCdSeq":"1","dJobNm":"화학여과기조작원","workSum":"반응이 완료된 유기안료에 남아있는 미반응 물질 및 불순물을 제거하기 위하여 여과시설을 조작·관리한다.","doWork":"보통 긴 직육면체형 여과시설에 있는 여과기의 공급탱크에 필터나 스크린을 장치한다. 반응공정을 마친 액상 반제품을 여과시키기 위해 펌프를 가동한다. 여과상태를 관찰하면서 공급밸브를 조절하고 공급속도를 조절한다. 각 배관과 탱크들에 흐르는 양을 조절하기 위하여 유량계를 확인하면서 밸브를 조정한다. 여과된 액상 반제품을 열풍 밀폐건조 시키는 건조 공정으로 이송하기 위하여 펌프를 가동하고 배출용 밸브를 연다. 여과된 액상반제품의 견본을 채취하여 품질검사부서로 보낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|다습|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"여과기정화원","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C204","dJobICdNm":"[C204]기타 화학제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001482:1', '{"dJobCd":"K000001482","dJobCdSeq":"1","dJobNm":"화학제품제조중앙조정실운전원","workSum":"석유화학제품 및 기타 화학제품을 제조하기 위하여 중앙조정실에서 DCS 등 Control System 을 조작하여 각 공정의 최적운전조건을 유지하며, 필요시 현장 운전원과 연락하여 필요한 조치를 하도록 한다.","doWork":"교대 근무 시에는 전 근무자의 운전 현황 및 특별사항을 인수인계하고 각종 기기들의 상태를 점검한다. 모니터와 각종 장치를 통해 현장의 작업상황을 파악한 후 현장과 조정판의 운전상태를 비교하면서 적절한 상태를 유지하고, 문제 발생 시 현장조작원에게 현장상황을 파악하도록 신속히 연락하고 지시한다. 운전조건에 따라 원료·부원료·촉매 등의 공급량을 유량계로 파악하여 제어기로 조절하고 제어판에 있는 계기들을 점검하여 각 공정의 온도, 압력, 반응시간 등을 기록·조절한다. 공정의 불안정한 작동상태를 알리는 경보장치를 작동하거나 표시기계가 조건에서 벗어나면 정상상태로 환원한다. 수리가 필요한 경우에는 공무팀에 연락을 취해 조치를 취한다. 문제점 및 현황에 대해서 중앙조정실반장에게 보고를 한다. 작업을 완료한 후에는 조정판 운전현황을 기록하고 패널을 정돈한 후 컨트롤 룸을 청소한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"보드맨, 제어판조작원","connectJob":"가성소다제조공정조정판조작원, 가소로공정조정판조작원, 고순도텔레프탈산제조장치조정판조작원, 산화공정조정판조작원, 아세트알데히드합성공정조정판조작원, 알킬화공정조정판조작원, 암모니아합성장치제어판조작원, 액화염소제조장치조정판조작원, 에탄올합성공정조정판조작원, 옥심공정조정판조작원, 이성화공정조정판조작원, 인산제조장치조정판조작원, 정제공정조정판조작원, 중합공정조정판조작원, 카프로락탐제조공정조정판조작원, 콜타르정류장치제어판조작원, 탈수소공정조정판조작원, 하이암공정조정판조작원, 합성수지제조장치조정판조작원, 황산제조장치조정판조작원","certLic":"위험물기능사, 위험물산업기사, 가스기능사, 가스산업기사","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C201/C202/C203","dJobICdNm":"[C201]기초 화학물질 제조업 / [C202]합성고무 및 플라스틱 물질 제조업 / [C203]비료, 농약 및 살균, 살충제 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003598:1', '{"dJobCd":"K000003598","dJobCdSeq":"1","dJobNm":"화학제품제조중앙조정실현장감독자","workSum":"석유화학제품 및 기타 화학제품을 안전하고, 안정되며 효율적으로 제조하기 위하여 중앙조정실에서 제어판 및 관련 장비를 조정하는 중앙조정실운전원 및 현장조작원의 활동을 조정·감독한다.","doWork":"업무분장에 맞게 해당 공정을 책임지고 안전하고 안정되고 운영할 책임이 있으며, 해당 조원의 중앙조정실운전원 및 현장조작원의 활동을 조정·감독하며 관련 부서와의 소통 및 공정 이상시에는 해당부서 상사에게 현상 및 파악된 원인/ 조치현황을 보고한다.\n운전중 수시로 모니터와 각종 기기를 이용해 운전 및 공정상의 이상현상을 발견하고 중앙조정실운전원에게 적절한 조치를 취하도록 지시한다. 기기장치의 오작동을 방지하고, 기기장치 사고에 대한 요인 분석과 조정상황을 파악해 현장을 파악하게 하는 등 적절한 지시를 내린다. 가동정지의 원인을 분석해 생산의 손실을 줄이고 작업원의 안전을 보호하도록 하며, 가동정지가 발생 시 이에 대한 보고를 상부에 한다. 작업원에 대한 직무교육 및 안전위생교육을 하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴하고 문제점을 보고한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","similarNm":"보드맨반장, 제어판조작반장, 화학제품제조중앙조정실반","connectJob":"가성소다제조장치조정실반장, 가소로공정조정실반장, 고순도텔레프탈산제조장치조정실반장, 산화공정조정실반장, 아세트알데히드합성공정조정실반장, 알킬화공정조정실반장, 암모니아합성장치조정실반장, 액화염소제조장치조정실반장, 에탄올합성공정조정실반장, 옥심공정조정실반장, 이성화공정조정실반장, 인산제조장치조정실반장, 정제공정조정실반장, 중합공정조정실반장, 카프로락탐제조공정조정실반장, 콜타르증류장치조정실반장, 탈수소공정조정실반장, 하이암공정조정실반장, 합성수지제조장치조정실반장, 황산제조장치조정실반장","certLic":"위험물기능사, 위험물산업기사","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C201","dJobICdNm":"[C201]기초 화학물질 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003403:1', '{"dJobCd":"K000003403","dJobCdSeq":"1","dJobNm":"황산알루미늄제조원","workSum":"황산알루미늄을 제조하기 위해 수산화알루미늄을 반응하고 배합하는 기계를 조작·관리한다.","doWork":"보호의와 보호안경을 착용한 후 작업지시서에 따라 일일작업량을 파악하고 필요한 원부재를 확인한다. 원료와 물 투입 밸브를 열고 펌프를 가동하여 작업표준에 따른 유량계를 확인하면서 적정비로 원료 배합조에 투입을 한다. 원료 충전(충진) 후 배합기의 조정판에 배합조건을 입력하고 가동한다. 교반기의 작동 여부를 확인한다. 일정 시간 배합 후 견본을 채취하여 수산화알루미늄이 물에 잘 혼합되었는지 검사한다. 견본의 일부를 품질검사부로 보내 정밀검사를 의뢰한다. 합격통보를 받으면 밸브를 열고 펌프를 가동하여 반응조로 이송한다. 작업표준에 따라 일정량의 황산을 유량계로 확인하면서 투입한다. 밸브를 열고 눈금계량기를 확인하면서 일정량의 물을 투입한다. 모든 원료의 투입이 완료되면 반응기의 조정판에 반응조건을 입력하고 가동한다. 반응 중에 발생하는 유해가스를 제거하고자 송풍기를 가동한다. 반응이 완료되면 압축여과기로 이송하고자 펌프를 가동한다. 여과가 완료되면 견본을 채취하여 품질검사부로 보낸다. 합격통보를 받으면 펌프를 가동하여 저장조로 이송·보관한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"위험물기능사, 위험물산업기사","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C201","dJobICdNm":"[C201]기초 화학물질 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001820:1', '{"dJobCd":"K000001820","dJobCdSeq":"1","dJobNm":"소결체제조원","workSum":"재변환 공정(6불화우라늄을 이산화우라늄 분말로 만드는 공정)에서 생산된 농축우라늄분말을 사용하여 연료봉에 장입되는 핵연료(소결체:燒結體)로 제조하기 위한 관련 장비를 조작한다.","doWork":"각 저장용기의 순수한 우라늄분말과 분말회수공정을 통해 회수한 분말 및 연삭찌꺼기, 소결체의 밀도조정 및 기공형성을 위한 기공형성제 및 윤활제를 혼합기에 투입하여 혼합한다. 혼합분말을 겉보기 밀도와 유동성을 향상시키기 위해 구형의 과립분말로 만든다. 과립 우라늄분말을 압분기에 투입하고 압력을 가하여 일정한 밀도를 가진 압분제를 제조한다. 저밀도의 압분체를 환원성 분위기의 소결로에 투입하고 고온 소결시켜 고밀도의 소결체로 제조한다. 고온소결로 수축된 소결체의 원통면을 일정하게 가공하고자 무심연삭기를 가동한다. 제조공정 중에 발생한 불량품이나 찌꺼기를 회수하여 재사용하고자 원심분리기와 건조기를 조작한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8519","dJobECdNm":"[8519]기타 석유·화학물 가공장치 조작원","dJobJCd":"8319","dJobJCdNm":"[8319]기타 석유 및 화학물 가공 장치 조작원","dJobICd":"C201","dJobICdNm":"[C201]기초 화학물질 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003608:1', '{"dJobCd":"K000003608","dJobCdSeq":"1","dJobNm":"우라늄재변환제조원","workSum":"육불화우라늄과 부자재(수증기, 수소, 질소)를 반응시켜 핵연료용 우라늄분말로 재변환하고자 제어시스템의 운전(중앙제어실), 설비 점검, 용기의 이동 및 장착, 분리작업을 수행한다,","doWork":"변환로, 혼합기, 체질기를 작동하고 제어실의 모니터를 통하여 각 단계가 제대로 작동하고 있는지 관찰한다. 공정에 유의하여 작업을 진행하고 긴급발생 시 작업을 중지시킨다. 정기적으로 설비의 상태를 점검한다. 각 단계가 끝나면 용기를 이동시키고 빈 용기를 장착한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8519","dJobECdNm":"[8519]기타 석유·화학물 가공장치 조작원","dJobJCd":"8319","dJobJCdNm":"[8319]기타 석유 및 화학물 가공 장치 조작원","dJobICd":"C201","dJobICdNm":"[C201]기초 화학물질 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002019:1', '{"dJobCd":"K000002019","dJobCdSeq":"1","dJobNm":"전해조운전원","workSum":"원염용해공정을 거친 순수한 염수를 전기분해해 염소, 가성소다, 수소를 제조하는 전해조를 운전한다.","doWork":"용해공정을 거친 염수를 전기분해하기 위해 전해조에 충전(충진)을 한다. 버튼을 눌러 염수와 가성소다 수용액을 순환시킨 후, 각 전해조에 공급된 가송소다 및 염수가 넘치지 않는지 확인을 한다. 스팀밸브를 가동하여 온도를 올리고 정류기를 작동시킨다. 공정이 안정적인지 확인한 후 공정스위치를 자동으로 변환한다. 정류기의 암페어를 확인하고 각 전해조에 공급된 전열량과 온도를 작업일지에 기록한다. 전해조에 공급되는 염수 및 가성소다의 유량, 온도를 확인한다. 전해조에서 발생되는 염소, 수소 가스의 견본을 포집하여 기체크로마토그래피 등을 이용하여 성분을 분석하고 주 압력, 유량, 온도를 작업일지에 기록한다. 견본을 채취하여 함량조견표와 비교·확인한다. 전해조에서 전기분해된 기체상태의 염소와 수소는 정제 과정으로 보내고, 액체상태의 가성소다는 농축을 하기 위해 증발기를 거쳐 저장이 되도록 다음 공정으로 이송을 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|","workEnv":"위험내재|고온|다습|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"쎌맨(Cell맨)","connectJob":"중앙조정실운전원","certLic":"위험물산업기사, 위험물기능사","dJobECd":"8519","dJobECdNm":"[8519]기타 석유·화학물 가공장치 조작원","dJobJCd":"8319","dJobJCdNm":"[8319]기타 석유 및 화학물 가공 장치 조작원","dJobICd":"C201","dJobICdNm":"[C201]기초 화학물질 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006725:1', '{"dJobCd":"K000006725","dJobCdSeq":"1","dJobNm":"가스제조장치조작원","workSum":"산업용이나 의료용으로 사용되는 일반가스(산소, 염소, 암모니아, 수소, 아세틸렌 등)를 추출하고자 제어장치를 통하여 설비(청정탑, 공기압축장치, 열교환기 등)를 조작·관리한다.","doWork":"제어장치를 통해서 공정의 정상상태 여부를 점검한다. 일정 시간마다 공정 상태를 작업일지에 작성한다. 공정 중에 문제가 발생하면 현장관리자에게 현장상황을 파악하도록 지시한다. 공정 중의 문제가 발생하거나 압축장치, 열교환기 등의 온도, 압력 등을 변경할 필요가 있을 때에는 제어장치를 조작하여 변경시킨다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"가스제조장치보드맨반장, 가스제조장치중앙조정실조작반장, 가스제조장치보드맨조작원, 가스제조장치중앙조정실조작원","certLic":"가스기능사, 가스산업기사","dJobECd":"8523","dJobECdNm":"[8523]화학제품 생산기계 조작원(고무·플라스틱 제외)","dJobJCd":"8321","dJobJCdNm":"[8321]화학제품 생산기 조작원","dJobICd":"D352","dJobICdNm":"[D352]연료용 가스 제조 및 배관공급업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003788:1', '{"dJobCd":"K000003788","dJobCdSeq":"1","dJobNm":"가스제조장치조작현장감독자","workSum":"가스를 제조하기 위하여 제어패널을 조정하는 작업원의 활동을 관리·감독한다.","doWork":"가스제조에 필요한 기계장치의 운전상태를 점검하여 운전방법의 시정·개선에 관한 지시를 한다. 작업의 진행상황을 파악하고 작업내용을 보고한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원 및 자재를 공급한다. 작업계획에 따라 세부실행항목을 수립하고 작업절차 및 방법을 결정하여 작업원에게 작업내용을 지시하고 작업배치를 한다. 표준작업명세에 따라 지시된 작업이 이루어지는지 작업원과 함께 작업하며 작업상황을 관찰하며 작업내용을 점검한다. 작업원의 직무교육 및 안전보건 교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴·해결하고 문제점을 보완한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","similarNm":"가스제조장치보드맨반장, 가스제조장치중앙조정실조작반장, 가스제조장치조작반장","certLic":"가스기능사, 가스산업기사, 가스기능장  ","dJobECd":"8523","dJobECdNm":"[8523]화학제품 생산기계 조작원(고무·플라스틱 제외)","dJobJCd":"8321","dJobJCdNm":"[8321]화학제품 생산기 조작원","dJobICd":"D352","dJobICdNm":"[D352]연료용 가스 제조 및 배관공급업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001751:1', '{"dJobCd":"K000001751","dJobCdSeq":"1","dJobNm":"가스제조장치현장감독자","workSum":"가스를 제조하고자 현장의 각종 설비와 장치를 조작·관리하는 작업원의 활동을 관리·감독한다.","doWork":"가스 제조를 위한 현장조작원에게 작업사항을 지시하고 공정을 순회하여 운전상태를 점검한다. 작업의 진행상황을 파악하고 작업내용을 보고한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원 및 자재를 공급한다. 작업계획에 따라 세부실행항목을 수립하고 작업절차 및 방법을 결정하여 작업원에게 작업내용을 지시하고 작업배치를 한다. 표준작업명세에 따라 지시된 작업이 이루어지는지 작업원과 함께 작업하며 작업상황을 관찰하며 작업내용을 점검한다. 작업원의 직무교육 및 안전보건 교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시면담과 관찰을 하여 작업원의 애로점 및 건의사항을 수렴·해결하고 문제점을 보완한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","similarNm":"가스제조장치현장반장","certLic":"가스기능사, 가스기능장 ","dJobECd":"8523","dJobECdNm":"[8523]화학제품 생산기계 조작원(고무·플라스틱 제외)","dJobJCd":"8321","dJobJCdNm":"[8321]화학제품 생산기 조작원","dJobICd":"D352","dJobICdNm":"[D352]연료용 가스 제조 및 배관공급업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003265:1', '{"dJobCd":"K000003265","dJobCdSeq":"1","dJobNm":"가스제조장치현장조작원","workSum":"산업용이나 의료용으로 사용되는 일반가스(산소, 염소, 암모니아, 수소, 아세틸렌 등)를 추출하기 위한 제조 장치 및 설비(청정탑, 공기압축장치, 열교환기 등)를 현장 점검하고 조정 및 간단한 수리를 한다.","doWork":"일정 시간마다 청정탑, 공기압축기, 열교환기 등이 설치된 현장의 순찰을 통해서 고장과 누설을 탐지하고 펌프·파이프 등의 가공처리장비를 검사한다. 순찰사항을 작업일지에 기록한다. 공정 중에 문제가 발생하면 제어장치를 조작하는 가스제조장치조작원에게 현장상황을 보고하고 조작원의 지시에 따라 현장 기계 및 장비를 조정한다. 시험분석을 위해 시료를 채취한다. 조작원과 함께 제어장치를 통해서 공정상태를 감시하며 지시에 따라 제어장치를 조작하여 공정상태를 변경하기도 한다. 간단한 보수 및 수리작업을 직접하고, 어려운 수리는 공무팀에게 그 내용을 전달한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"가스제조필드맨","connectJob":"산소제조현장조작원, 아르곤현장조작원, 이산화탄소제조현장조작원","certLic":"가스기능사","dJobECd":"8523","dJobECdNm":"[8523]화학제품 생산기계 조작원(고무·플라스틱 제외)","dJobJCd":"8321","dJobJCdNm":"[8321]화학제품 생산기 조작원","dJobICd":"D352","dJobICdNm":"[D352]연료용 가스 제조 및 배관공급업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007320:1', '{"dJobCd":"K000007320","dJobCdSeq":"1","dJobNm":"경피흡수의약품생산원","workSum":"경피흡수제 의약품을 원활하게 생산하기 위하여 GMP 규정에 따라 제조조건 설정, 원료칭량, 경피흡수제 제조, 선별·포장 등의 정해진 업무를 수행한다.","doWork":"제조장비별 작동원리 및 운용조건을 파악하고, 설정 및 유지 상태를 확인한 후 문제발생의 유형별 트러블슈팅 방법을 숙지하여 적절한 조치를 한다. 원료칭량 후 라벨을 발행 및 부착하고 칭량에 사용된 도구와 보관용기를 세척 및 관리한다. 도포액 조제에 필요한 혼합기나 교반기, 도포기, 절단기 등의 가동범위 및 주의사항을 확인하고 기기를 조립 및 분해하고 청소한다. 제조지시서에 따라 혼합기, 도포기에 원료 투입시 조건 및 주의사항을 확인하고 기록하며, 도포에 필요한 원료를 투입하고 가동한다. 도포된 제품을 건조, 합지, 숙성하고 제조기록서에 작업내용을 확인하고 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8523","dJobECdNm":"[8523]화학제품 생산기계 조작원(고무·플라스틱 제외)","dJobJCd":"8321","dJobJCdNm":"[8321]화학제품 생산기 조작원","dJobICd":"C211","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007328:1', '{"dJobCd":"K000007328","dJobCdSeq":"1","dJobNm":"고형제의약품생산원","workSum":"고형제 의약품을 원활하게 생산하기 위하여 GMP 규정에 따라 제조조건 설정, 원료칭량 및 조제, 용기세척 및 충전, 공정검사, 선별·포장 등의 정해진 업무를 수행한다.","doWork":"제조장비별 작동원리 및 운용조건을 파악하고, 설정 및 유지 상태를 확인한다. 원료칭량 후 라벨을 발행하고 부착한다. 원료의 보관조건, 원료명, 관리번호, 유효기간, 사용승인 여부원료를 확인한다. 투입 전 원료를 확인하여 혼합작업을 수행하고 기록하며, 건식 또는 습식 과립작업, 열풍 또는 유동층 등의 건조작업을 수행하고 기록한다. 과립을 일정 압력으로 압축 또는 캡슐에 충전하여 일정한 성상을 만드는 공정을 수행한다. 타정기와 충전기의 용량과 가동범위 및 주의사항을 확인하고 타정 및 충전작업을 수행하고 기록한다. 코팅기의 용량과 가동범위 및 주의사항을 확인하고, 코팅공정 작업을 수행하고 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8523","dJobECdNm":"[8523]화학제품 생산기계 조작원(고무·플라스틱 제외)","dJobJCd":"8321","dJobJCdNm":"[8321]화학제품 생산기 조작원","dJobICd":"C211","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004143:1', '{"dJobCd":"K000004143","dJobCdSeq":"1","dJobNm":"과립원","workSum":"중량이 측정된 원료 및 부원료를 혼합, 조립, 건조, 정립, 재혼합, 최종 혼합하는 장치를 조작한다.","doWork":"제조 의약품의 종류 및 원료배합율을 확인한다. 일일 작업 생산량에 따라 원료 및 부원료를 정량공급기에 투입한다. 정량공급기의 공급량을 조절한 후 결합액을 조제하고자 조제 탱크에 연결된 에탄올 공급밸브를 열어 투입하고 하이드록시프로필셀룰로오스를 천천히 첨가하고 교반기를 가동하여 완전히 용해시킨다. 용해가 완료되면 하단의 밸브를 열어 체에 거르고 조제된 결합액만큼의 분량을 고속혼합기에 투입하고 일정 시간 혼합한다. 일정 시간 후 조제된 결합액을 고속혼합기의 결합액 탱크에 투입하고 천천히 첨가하면서 조립한다. 조립이 완료되면 혼합기에 연결된 호스를 용기에 연결하고 밸브를 열어 반제품을 용기에 옮겨 담는다. 용기를 유동층건조기에 장착하고 건조기에 건조조건(송풍속도, 건조시간 등)을 입력한 후 가동시켜 건조한다. 건조가 완료되면 리본형 혼합기에 리프트(Lift)를 사용하여 투입하고 일정 시간 혼합기를 가동시킨 후 정지시킨다. 기타 원료(첨가제)를 첨가한 후 다시 혼합기를 가동한다. 용기를 건조기에서 꺼내어 리프트를 사용하여 분쇄기의 원료 투입구에 투입한다. 분쇄기를 가동시킨 후 일정 크기로 정립되는지 확인한다. 견본을 채취하여 입자의 크기를 검사하고 분쇄기의 날을 조정한다. 분쇄가 완료되면 청결 건조한 비닐팩이 든 용기에 일정 중량만큼 계량하여 담는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8523","dJobECdNm":"[8523]화학제품 생산기계 조작원(고무·플라스틱 제외)","dJobJCd":"8321","dJobJCdNm":"[8321]화학제품 생산기 조작원","dJobICd":"C212","dJobICdNm":"[C212]의약품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002848:1', '{"dJobCd":"K000002848","dJobCdSeq":"1","dJobNm":"단백질의약품배양원","workSum":"치료단백질을 생산하기 위하여 미생물·효모·동물세포를 배양하는 배양기를 조작·관리한다.","doWork":"단백질의약품의 배양을 위해 작업지시서를 확인하고 냉동된 세포주를 냉동탱크(액체질소탱크)에서 꺼내 상온수조에서 해동시킨다. 세포주 배양을 위해 플라스크(Flask)에 배지를 넣고 해동된 세포주를 접종한다. 인큐베이터(Incubator)에 온도, 습도 등의 배양조건을 입력하고 플라스크 넣어 일정 시간 배양한다. 배양 단계에 따라 웨이브 세포배양기(Wave Bioreactor)를 사용하여 배양시키기도 한다. 종배양기(Seed Bioreactor)기 내부를 고온의 순수로 살균하고 배지와 순수를 공급하고 온도, 습도, 산도(pH), 교반속도(rpm) 등의 배양조건을 입력한 뒤 플라스크에서 배양된 세포주를 종배양기에 넣어 일정 시간 배양한다. 배양체적 증가 속도에 따라 배양기의 용량을 늘려가며 본배양기(Production Bioreactor)로 이동시킨다. 세포 배양 중 세포량에 따라 배지와 각종 영양물질, 순수의 공급과 온도, 습도, 산도(pH), 교반속도(rpm), 세포주의 대사물질 등을 모니터링하고 기록한다. 일정 시간마다 샘플을 채취하여 세포수 및 생존율을 구하고 단백질관련 시험분석을 실시한다. 주배양이 완료된 배양액을 원심분리나 필터처리하여 목표 단백질이 포함된 분리회수액을 회수한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"손사용|언어력|시각|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"세포주해동원, 플라스크배양원, 종배양원, 주배양원","certLic":"바이오화학제품제조산업기사","dJobECd":"8523","dJobECdNm":"[8523]화학제품 생산기계 조작원(고무·플라스틱 제외)","dJobJCd":"8321","dJobJCdNm":"[8321]화학제품 생산기 조작원","dJobICd":"C211","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002431:1', '{"dJobCd":"K000002431","dJobCdSeq":"1","dJobNm":"단백질의약품정제원","workSum":"세포 등의 배양액으로부터 크로마토그래프 등을 사용하여 치료단백질을 분리·정제한다.","doWork":"단백질의약품을 만들기 위해 배양 후 원심 분리나 필터를 거친 분리회수액에서 기타 단백질, 불순물 등을 분리하여 목표 단백질을 회수농축하기 위해 크로마토그래프(Chromatography)와 한외여과/투석여과(UF/DF:Ultrafiltration/Diafiltration), 바이러스필터시스템을 조작한다. 정제조건에 따라 크로마토그래프의 컬럼컨트롤러(Column Controller)에 정제시간, 온도, 버퍼의 종류, 정제순서 등의 정제조건을 입력하고 컬럼에 레진을 충진시킨 후 버퍼를 주입하고 예열한다. 분리회수액을 컬럼에 주입하여 순차적으로 정제한다. 정제된 용출액을 적정농도로 농축하기 위해 한외여과/투석여과(UF/DF:Ultrafiltration/Diafiltration)를 수행하고 안정화 버퍼(Buffer)에 정착시킨다. 멤브레인(Membrane) 크로마토그래프나 필터를 이용하여 내부의 바이러스를 제거하기도 한다. 각 과정의 샘플을 채취하여 시험검사를 의뢰하고, 공정조건과 과정을 기록한다. 정제/농축이 완료된 치료단백질은 보관용기에 보관한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"손사용|언어력|시각|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"크로마토그래프정제원, UF/UD정제원","certLic":"바이오화학제품제조산업기사","dJobECd":"8523","dJobECdNm":"[8523]화학제품 생산기계 조작원(고무·플라스틱 제외)","dJobJCd":"8321","dJobJCdNm":"[8321]화학제품 생산기 조작원","dJobICd":"C211","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004489:1', '{"dJobCd":"K000004489","dJobCdSeq":"1","dJobNm":"동물백신생산원","workSum":"배양기, 농축기, 세포파쇄기, 원심분리기, 멸균기, 건조기 등을 조작하여 동물백신을 생산한다.","doWork":"바이러스 배양을 위해 숙주에 접종한다. 대량배양기를 통해서 배양한다. 배지(배양액:식물이나 세균, 배양 세포 따위를 기르는 데 필요한 영양소가 들어있는 액체)를 제외하기 위해 농축기를 조작한다. 세포 내 성분을 추출하기 위해 세포파쇄기를 조작한다. 채독기로 채독한다. 백신의 종류에 따라 냉동실 또는 고온실에 보관한다. 백신생산을 위해 관련 기기의 온도, 습도, 그리고 기타 조건 등을 설정한다. 관련 기기 및 장비를 관리한다. 생산된 벌크를 적정한 조건에서 보관한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"바이러스백신생산원, 세균백신생산원","dJobECd":"8523","dJobECdNm":"[8523]화학제품 생산기계 조작원(고무·플라스틱 제외)","dJobJCd":"8321","dJobJCdNm":"[8321]화학제품 생산기 조작원","dJobICd":"C212","dJobICdNm":"[C212]의약품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006689:1', '{"dJobCd":"K000006689","dJobCdSeq":"1","dJobNm":"동물용약제품제조원","workSum":"동물용 약제품을 제조하기 위하여 분말 또는 액상의 원료를 혼합, 분주(분류하여 나눔)하는 장치를 조작한다.","doWork":"분말 또는 액상의 원료(린코마이신, 스펙티노마이신 등)를 작업지시서에 따라 전자 저울을 사용하여 계량한다. 계량된 원료가 분말일 경우는 포도당과 함께 투입하고 원료가 액상일 경우는 벤질알코올과 증류수를 작업표준서에 명시된 배합비에 따라 액체혼합기, 분립체혼합기, 분체혼합기에 투입한다. 원료투입이 완료되었으면 혼합기의 조정판에 혼합조건을 입력하고 가동한다. 일정 시간 혼합을 시킨 후 작동을 멈추고 분주기(분류하여 나누는 기계)에 투입한다. 제품용량별로 분주가 이루어지는지 확인하고 이상이 발생하면 타이머를 조작하여 개선한다. 제품의 특성에 따라 제형화한다. 제품 중에서 견본을 채취하여 품질검사부에 보낸다. 검사결과가 통보되면 분주물을 봉인기에 투입하여 봉인이 잘 이루어지는지 관찰한다. 봉인된 제품을 박스에 담고 적재함에 적재한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8523","dJobECdNm":"[8523]화학제품 생산기계 조작원(고무·플라스틱 제외)","dJobJCd":"8321","dJobJCdNm":"[8321]화학제품 생산기 조작원","dJobICd":"C212","dJobICdNm":"[C212]의약품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003454:1', '{"dJobCd":"K000003454","dJobCdSeq":"1","dJobNm":"미생물정제원","workSum":"채취한 미생물을 적당한 방법으로 정제한 후 순수한 미생물 또는 미생물의 항원성분만을 분리하기 위하여 관련된 장비를 조작한다.","doWork":"채취한 미생물을 정제실로 운반하여 정제준비를 한다. 항온수조를 조작하여 항온수조 내에서 일정한 온도로 일정 시간 미생물을 유지하고 교반하여 불활화(바이러스 및 독성을 없앰)한다. 불활화된 미생물액을 원심분리, 여과, 농축, 침전등의 적당한 방법으로 침전물을 얻는다. 이를 원심분리, 알콜분획, 침전, 페놀처리, 투석등을 통하여 정제하고 그 원액을 용기에 담아 동결건조한다. 또한, 배양한 미생물을 원심분리 한후, 침전물을 부유시켜 그 원액을 용기에 담아 동결건조할 수도 있다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|언어력|시각|","workEnv":"위험내재|저온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"바이오화학제품제조산업기사","dJobECd":"8523","dJobECdNm":"[8523]화학제품 생산기계 조작원(고무·플라스틱 제외)","dJobJCd":"8321","dJobJCdNm":"[8321]화학제품 생산기 조작원","dJobICd":"C211","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005449:1', '{"dJobCd":"K000005449","dJobCdSeq":"1","dJobNm":"미생물제조원","workSum":"미생물제를 제조하기 위하여 채란, 접종, 채독, 분류 등의 관련된 장비를 조작한다.","doWork":"작업표준에 따라 손을 소독하고 방역신발과 방역모자, 방역마스크 등의 장비를 갖춘다. 무균작업대(클린벤치)를 작동시켜 채독을 하고자 원료(계란)를 부화기에 넣고 일정 시간 동안 부화시킨다. 부화된 원료에 주사기를 사용하여 바이러스를 투입하고 파라핀(Paraffin)으로 봉한다. 다시 부화기에 입관한다. 부화된 원료를 소독수로 세척한다. 부화된 계란의 상부를 절단하고 진공펌프를 사용하여 배양된 바이러스를 채독한다. 채독된 바이러스를 원심분리기로 수분을 제거하고, 초고속 원심분리기를 이용해 바이러스 입자를 분리한다. 부작용의 원인이 되는 바이러스를 제거하고, 약독화(藥毒化)한다. 병에 넣기 위하여 증류수로 병을 세척한다. 병을 멸균기에 넣고 멸균, 건조시킨다. 바이러스를 채독하고 남은 유정란은 쿠킹실로 보내 처분한다. 또한, 육즙, 혈청을 이용한 세균배양, 맥아추출물을 이용한 곰팡이배양, 액체배양을 통한 합성배양 및 한천, 젤라틴 등을 가한 고형배지를 사용하여 대량 배양을 하기도 하며 많은 종류의 세균을 포함하는 재료로부터 목적균을 추출하는 선택배양을 한다. 이때 잡균의 번식을 막기 위하여 완전히 멸균을 시킨 후 목적균을 심어 배양한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|언어력|시각|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"8523","dJobECdNm":"[8523]화학제품 생산기계 조작원(고무·플라스틱 제외)","dJobJCd":"8321","dJobJCdNm":"[8321]화학제품 생산기 조작원","dJobICd":"C211","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007329:1', '{"dJobCd":"K000007329","dJobCdSeq":"1","dJobNm":"바이오의약품배양원","workSum":"GMP 규정과 현장 실무지식 및 바이오의약품 제조의 기초이론을 활용하여 균주·세포주 관리, 세척·멸균, 배양, 회수 등의 업무를 수행한다.","doWork":"주생산세포주(MCB)와 작업생산세포주(WCB)를 구분하여 조제하고 균주·세포주의 특성에 따른 동결보존방법 선택, 보존 후 세포주의 오염과 활성여부, 농도 및 생존율을 측정 확인한다. 규정에 따른 세척기, 멸균기 점검 및 정기 밸리데이션을 수행하고, 각 배지별 원료준비 및 원료를 칭량한다. 배지 조제, 배지 멸균을 수행하며 배양기 세척, 멸균, 운전을 준비하고, 셀뱅크로부터 균주·세포주를 해동하여 접종한다. 단계별로 배양조건에 따라 배양하고 배양 중 공정관리 및 일탈발생 시 조치를 한다. 세포의 특성을 고려한 배양액 또는 파쇄물을 회수하고, 목적산물의 회수율을 측정, 회수장비를 유지 관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"제약발효기조작원, 바이오화학제품균주관리원, 바이오화학제품배양원","dJobECd":"8523","dJobECdNm":"[8523]화학제품 생산기계 조작원(고무·플라스틱 제외)","dJobJCd":"8321","dJobJCdNm":"[8321]화학제품 생산기 조작원","dJobICd":"C211","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004921:1', '{"dJobCd":"K000004921","dJobCdSeq":"1","dJobNm":"바이오의약품배지제조원","workSum":"바이오의약품 생산을 위해 미생물이나 세포를 배양하기 위해 영양공급원인 배지를 제조한다.","doWork":"제조지시서에 따라 제조할 배지의 종류에 따른 정량의 원·부자재를 준비한다. 교반기 내부를 살균하고 교반속도, 온도, 산도(pH) 등 교반환경을 설정하고 순서에 따라 원·부자재를 투입한 뒤 교반기를 작동하여 배지를 제조한다. 제조된 배지의 샘플을 채취하여 시험분석을 의뢰한다. 제조가 완료된 배지는 저장용기에 담거나 저장탱크로 이송시키고 생산조건과 원·부자재의 투입량 시험결과를 기록한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"바이오화학제품제조산업기사","dJobECd":"8523","dJobECdNm":"[8523]화학제품 생산기계 조작원(고무·플라스틱 제외)","dJobJCd":"8321","dJobJCdNm":"[8321]화학제품 생산기 조작원","dJobICd":"C211","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007343:1', '{"dJobCd":"K000007343","dJobCdSeq":"1","dJobNm":"바이오의약품분리정제원","workSum":"바이오의약품 제조의 기초이론 및 관련 GMP 규정과 현장 실무지식을 활용하고 크로마토그래피 및 막여과방법 등을 이용하여 목적물질의 분리ㆍ정제, 최종원액 제조 등의 업무를 수행한다.","doWork":"제형버퍼에 필요한 원료와 분리·정제에 필요한 유틸리티 공급조건을 확인하고, 최종원액 조제에 필요한 원료와 자재를 검수한다. 기준에 맞게 정제버퍼를 조제하고 크로마토그래피 방법 및 한외여과/투석여과 등의 정제장비 및 농축장비를 준비하여, 최종산물을 분리·정제, 공정관리를 수행한다. 최종정제액의 제균여과 후 정제액을 충전 보관한다. 제형버퍼에 필요한 원료를 확인 및 검수하고 버퍼 및 최종원액을 기준에 맞게 조제한다. 정비가동상태를 확인하고, 작업 전·후 필터 완전성 시험을 수행하며 최종원액의 여과작업을 실시한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"바이오의약품정제원, 바이오DS원","connectJob":"바이오화학제품분리정제공정관리자","dJobECd":"8523","dJobECdNm":"[8523]화학제품 생산기계 조작원(고무·플라스틱 제외)","dJobJCd":"8321","dJobJCdNm":"[8321]화학제품 생산기 조작원","dJobICd":"C211","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007344:1', '{"dJobCd":"K000007344","dJobCdSeq":"1","dJobNm":"바이오의약품완제포장원","workSum":"바이오의약품의 최종제품 제조를 위하여 바이오의약품 제조의 기초이론 및 관련 GMP 규정과 현장 실무지식을 활용하고 제형화, 포장 등의 업무를 수행한다.","doWork":"제품별 조제액의 용해 상태 확인 및 최종액량을 정하고, 공정관리용(IPC용) 조제액을 샘플링한다. 약액을 이송하면서 제균 여과, 멸균기를 이용하여 용기를 멸균하고 충전기 작업 조건을 설정하고 가동한다. 용봉, 실링(sealling), 캡핑(capping) 이물검사, 누출검사를 수행하고 동결건조 장비 및 멸균기의 조건을 설정하고 가동한다. 라벨 등의 표시자재 구분, 관리를 통해 포장재와 표시자재 점검, 제조번호와 유효기간을 인쇄한다. 포장관련 지침에 따라 포장공정을 수행하며 공정 중 일탈 발생 시 처리하고 포장공정 종료 후 표시자재 수량을 관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"바이오의약품완제원, 바이오DP원","dJobECd":"8523","dJobECdNm":"[8523]화학제품 생산기계 조작원(고무·플라스틱 제외)","dJobJCd":"8321","dJobJCdNm":"[8321]화학제품 생산기 조작원","dJobICd":"C211","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006873:1', '{"dJobCd":"K000006873","dJobCdSeq":"1","dJobNm":"바이오의약품완충액제조원","workSum":"바이오의약품의 배양, 정제, 원액제조 완제제조등의 생산을 위해  사용되는 완충액을 제조한다.","doWork":"제조지시서에 따라 제조할 완충액(Buffer)의 종류에 따른 정량의 원·부자재를 준비한다. 교반기 내부를 살균하고 교반속도, 온도, 산도(pH) 등 교반환경을 설정하고 순서에 따라 원·부자재를 투입한 뒤 교반기를 작동하여 완충액(Buffer)을 제조한다. 완충액의 농도를 조정하고 산도(pH)측정기를 이용하여 검사한다. 제조된 완충액(Buffer)을 샘플을 채취하여 시험분석을 의뢰한다. 경우에 따라 고압멸균기(Autoclave)를 이용하여 멸균소독하기도 한다. 제조가 완료된 완충액(Buffer)은 저장용기에 담고 생산조건과 원·부자재의 투입량 시험결과를 기록한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"바이오화학제품제조산업기사","dJobECd":"8523","dJobECdNm":"[8523]화학제품 생산기계 조작원(고무·플라스틱 제외)","dJobJCd":"8321","dJobJCdNm":"[8321]화학제품 생산기 조작원","dJobICd":"C211","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007345:1', '{"dJobCd":"K000007345","dJobCdSeq":"1","dJobNm":"반고형제의약품생산원","workSum":"반고형제 의약품을 원활하게 생산하기 위하여 GMP 규정에 따라 제조조건 설정, 원료칭량, 반고형제 제조·충전, 선별·포장 등의 정해진 업무를 수행한다.","doWork":"제조장비별 작동원리 및 운용조건을 파악하고, 설정 및 유지 상태를 확인한다.\n원료칭량 후 라벨을 발행 및 부착하고 칭량에 사용된 도구와 보관용기를 세척 및 관리한다. 제조지시서에 따라 조제탱크 및 유화기에 원료를 투입하고 조건을 설정한 후 가동하고, 반제품의 성상 및 점도 등의 유화상태를 확인한다. \n제조기록서에 반고형제 조제작업 내용을 확인하여 기록한다. 제조지시서에 따라 충전기의 조건을 설정하고 충전 작업 중 이물 혼입 및 기타 오염을 확인하여 제조기록서에 충전 작업내용을 기록한다. 표준작업지침서에 따라 조제탱크 및 유화기를 청소하고 충전 장비를 세척한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8523","dJobECdNm":"[8523]화학제품 생산기계 조작원(고무·플라스틱 제외)","dJobJCd":"8321","dJobJCdNm":"[8321]화학제품 생산기 조작원","dJobICd":"C211","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002507:1', '{"dJobCd":"K000002507","dJobCdSeq":"1","dJobNm":"방향제품제조원","workSum":"방향제품을 제조하기 위하여 각종 향료를 분산매에 넣고 교반기를 이용해 혼합·용해한 후 여과·숙성 시킨다.","doWork":"교반의 목적, 액의 비중, 점도의 성질, 혼합상태, 혼합시간 등을 고려해 교반기를 편심 설치하거나 중심 설치를 한다. 혼합 공정의 특성에 맞게 교반기의 회전속도를 적절히 맞추어 가동을 한다. 수상 원료를 용해 탱크에 넣은 후 교반기를 회전시키면서 향료를 포함한 알코올상을 서서히 첨가하여 가용화하고 여과 작업을 거친 후 투명한 제품을 얻는 가용화 공정을 진행한다. 여과가 완료되어 벌크 생산이 된 방향액을 냉암소에서 숙성시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|저온|소음·진동|","workFunc1":"관련없음","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"향료교반기조작원","dJobECd":"8523","dJobECdNm":"[8523]화학제품 생산기계 조작원(고무·플라스틱 제외)","dJobJCd":"8321","dJobJCdNm":"[8321]화학제품 생산기 조작원","dJobICd":"C204","dJobICdNm":"[C204]기타 화학제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007258:1', '{"dJobCd":"K000007258","dJobCdSeq":"1","dJobNm":"분병원","workSum":"제품화된 약품을 분병하기 위하여 관련된 장비를 조작한다.","doWork":"작업량을 확인하고 분병할 의약품의 종류에 따라 생산에 필요한 자재의 수량을 점검한다. 병, 고무마개, 알루미늄캡 등의 세척, 침적, 가열, 건조, 멸균상태를 확인한다. 작업지시서에 따라 조제된 표준품에 적합한 용량의 준비된 병을 자동분병기에 위치시키고 소분한 후 분병한다. 분병이 완료된 병에 고무마개를 막고 알루미늄마개로 완전히 밀폐한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"분주원, 분병기조작원","dJobECd":"8523","dJobECdNm":"[8523]화학제품 생산기계 조작원(고무·플라스틱 제외)","dJobJCd":"8321","dJobJCdNm":"[8321]화학제품 생산기 조작원","dJobICd":"C212","dJobICdNm":"[C212]의약품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006647:1', '{"dJobCd":"K000006647","dJobCdSeq":"1","dJobNm":"색조화장품제조원","workSum":"색조화장품을 만들기 위하여 유상원료와 수상원료를 혼합·유화·분산하는 기기를 조작·관리한다.","doWork":"교반기를 이용해 원료를 혼합하거나 분산(분산매가 분산상에 퍼져있는 현상) 된 재료와 유상 및 수상 원료를 유화탱크에 주입하여 유화기를 조작한다. 교반속도, 온도, 시간, 탈기, 냉각 등이 컴퓨터로 자동조작이 가능한 진공 유화장치, 또는 필요시에 개폐를 할 수 있는 개폐식 유화장치를 가동한다. 제조공정을 준수하여 적합한 품질의 색조화장품을 제조한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"립스틱제조원, 매니큐어제조원, 아이섀도제조원, 아이라이너제조원","dJobECd":"8523","dJobECdNm":"[8523]화학제품 생산기계 조작원(고무·플라스틱 제외)","dJobJCd":"8321","dJobJCdNm":"[8321]화학제품 생산기 조작원","dJobICd":"C204","dJobICdNm":"[C204]기타 화학제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007346:1', '{"dJobCd":"K000007346","dJobCdSeq":"1","dJobNm":"석유화학생산설비운전원","workSum":"석유 화학제품을 생산하기 위해 생산설비를 운전한다.","doWork":"작업표준 (정상운전 작업표준, 이상시 조치작업 표준 등) 및 석유화학 공정제어원의 지시에 따라 담당공정의 설비가 안정되고 효율적으로 운전 될 수 있도록 현장설비를 조작한다. 순찰시 이상 상황이 발생하면 즉시 보고하고 조치를 통하여 공정의 생산설비가 안전하고 최적으로 운전한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실외","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"석유화학필드맨, 석유화학현장운전원","dJobECd":"8523","dJobECdNm":"[8523]화학제품 생산기계 조작원(고무·플라스틱 제외)","dJobJCd":"8321","dJobJCdNm":"[8321]화학제품 생산기 조작원","dJobICd":"C201","dJobICdNm":"[C201]기초 화학물질 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004965:1', '{"dJobCd":"K000004965","dJobCdSeq":"1","dJobNm":"수동충전원","workSum":"수동충전대에서 저울을 사용해 생산된 화장품 및 의약품을 일정 용량의 포장용기에 수동 충전(Filling)한다.","doWork":"생산된 화장품이나 의약품을 포장라인의 저장통 및 가압탱크에 운반하여 충전 준비를 한다. 로션 등 겔(Gel) 상태의 원료는 펌프를 사용하고, 스킨 등의 액체는 공기를 사용하여 이송한다. 수동충전대에 일정 용량의 포장용기를 준비하고 배치한 후, 저울을 이용해서 정해진 용량에 맞게 화장품이나 의약품을 충전한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"화장품수동충전원, 의약품수동충전원","dJobECd":"8523","dJobECdNm":"[8523]화학제품 생산기계 조작원(고무·플라스틱 제외)","dJobJCd":"8321","dJobJCdNm":"[8321]화학제품 생산기 조작원","dJobICd":"C204/C212","dJobICdNm":"[C204]기타 화학제품 제조업 / [C212]의약품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007352:1', '{"dJobCd":"K000007352","dJobCdSeq":"1","dJobNm":"액제의약품생산원","workSum":"액제 의약품을 원활하게 생산하기 위하여 GMP 규정에 따라 제조조건 설정, 원료칭량, 액제 조제, 액제 용기세척 및 충전, 공정검사 선별·포장 등의 정해진 업무를 수행한다.","doWork":"제조장비별 작동원리 및 운용조건을 파악하고, 설정 및 유지 상태를 확인한다. 조제용 기구, 조제 탱크의 세척상태를 확인하고 조제작업장의 차압, 온도 및 습도를 확인하여 기록한다. 원료 및 제조용수를 조제 탱크에 투입 후 기록하고 조제 탱크의 온도, RPM, 시간 등을 설정하여 운전한다. 제품별 조제액의 용해상태 확인, 최종액량을 맞추고 반제품의 이물여과 및 살균작업을 수행한다. 충전을 위한 기구, 청소상태, 차압, 온습도 등을 확인하고 제품 형태에 따라 용기의 실링, 캡핑 등의 가동조건을 입력하고 작동시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8523","dJobECdNm":"[8523]화학제품 생산기계 조작원(고무·플라스틱 제외)","dJobJCd":"8321","dJobJCdNm":"[8321]화학제품 생산기 조작원","dJobICd":"C211","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001897:1', '{"dJobCd":"K000001897","dJobCdSeq":"1","dJobNm":"앰풀검사기조작원","workSum":"액체약품이 충진된 앰풀(Ampule)의 변색 및 이물질, 충전량 등을 검사기를 통하여 검사한다.","doWork":"제조라인의 이송컨베이어벨트상의 앰풀(Ampule)이 화상검사 카메라로 촬영할 수 있도록 조절하여 액중이물검사기의 자동검사기에 위치시킨다. 자동검사기 및 자동검사제어장치를 조작한다. 검사과정을 주의 깊게 관찰하여 액 중에 벌레나 기타의 이물 등이 혼입해있는지 컴퓨터 화상을 주의 깊게 관찰한다. 적재함을 벗어난 앰풀을 제거하거나 기타 공정 중의 문제점을 관찰한다. 작업이 완료되면 검사한 앰풀의 수와 불량앰풀의 수를 작업일지에 기록하고 포장공정으로 이송하고자 용기에 담는다. 불량으로 판정된 앰풀적재함을 수거하여 폐기시킨다. 검사한 앰풀의 수를 기록하고 운반한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8523","dJobECdNm":"[8523]화학제품 생산기계 조작원(고무·플라스틱 제외)","dJobJCd":"8321","dJobJCdNm":"[8321]화학제품 생산기 조작원","dJobICd":"C212","dJobICdNm":"[C212]의약품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002050:1', '{"dJobCd":"K000002050","dJobCdSeq":"1","dJobNm":"앰풀세척기조작원","workSum":"앰풀(Ampule)을 초음파·공기·증류수 등을 사용하여 세척하는 기계를 조작한다.","doWork":"작업지시에 따라 세척할 앰풀의 종류와 수량을 확인한다. 초음파조의 노즐 및 분사량을 확인하고 증류수의 양이 충분한지 점검한다. 깨끗한 증류수를 일정량 투입하고 앰풀을 세척하고자 스위치를 넣어 세척기를 작동시킨다. 작업표준에 따라 용기, 시간 등에 맞는 세척초음파를 발진시킨다. 세척기 컨베이어 위의 지정된 장소에 앰풀을 올려놓고 컨베이어를 작동시킨 후 세척기에 앰풀을 통과시켜 세척한다. 세척되는 상태, 노즐의 상태, 세척되는 시간 등을 살펴보고 노즐이 정확하게 용기 안으로 들어가도록 조정한다. 세척된 앰풀을 살펴보고 멸균상자에 적재하여 건조기에서 건조한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8523","dJobECdNm":"[8523]화학제품 생산기계 조작원(고무·플라스틱 제외)","dJobJCd":"8321","dJobJCdNm":"[8321]화학제품 생산기 조작원","dJobICd":"C212","dJobICdNm":"[C212]의약품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003719:1', '{"dJobCd":"K000003719","dJobCdSeq":"1","dJobNm":"약제추출기조작원","workSum":"액체약품(드링크제)에 포함될 추출물을 만들어내기 위하여 열탕추출기, 추출탱크, 원심분리기를 조작한다.","doWork":"작업지시에 따라 추출물의 종류와 생산량을 확인하고 물, 알코올 등의 용매를 준비하여 추출물의 원료인 생약, 원액, 원료를 수령하여 그 무게를 측정하고 성질 및 상태를 파악한다. 제조명세서에 따라 제조하려는 제품의 원료 및 물을 탱크에 투입하거나 경우에 따라 알코올 등 필요한 성분만 녹일 수 있는 특정한 용매를 투입하고 장치를 조작한다. 적정한 온도를 유지한 채 일정 시간 동안 추출상태를 유지하여 정해진 시간 후 조작기를 멈추고 추출된 생약의 찌꺼기 또는 불순물을 걸러내기 위하여 여과기를 조작한다. 순도가 높은 추출물을 생산하기 위해서 여러 차례의 여과공정을 반복하여 추출물을 생성한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|고온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8523","dJobECdNm":"[8523]화학제품 생산기계 조작원(고무·플라스틱 제외)","dJobJCd":"8321","dJobJCdNm":"[8321]화학제품 생산기 조작원","dJobICd":"C211","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006242:1', '{"dJobCd":"K000006242","dJobCdSeq":"1","dJobNm":"연고조제원","workSum":"유상조제, 수상조제, 용해, 유화, 냉각하는 장치를 사용하여 연고형태의 의약품을 조제한다.","doWork":"작업지시서에 따라 조제할 연고의 각 원료를 확인하고 각 원료를 정량계량하여 준비한다. 작업표준에 의하여 각 원료의 배합비에 따라 원료용해탱크에 주원료(프로필렌글리콜 등)를 계량하여 투입한다. 스팀밸브를 열어 일정 온도로 승온한다. 작업표준서에 따라 기타 원료를 순서대로 계량하여 투입한다. 용해탱크의 조정판에 용해조건을 입력하고 가동한다. 유상조제탱크에 연결된 스팀밸브를 열어 유상조제탱크를 미리 일정 온도로 승온한다. 작업표준서에 따라 원료를 순서대로 계량하여 투입하고 온도 및 교반속도 등을 입력한 후 가동한다. 일정 시간 가동 후 조제원료가 완전히 용융되었는지 확인한 다음 첨가제를 넣고 다시 교반기로 완전히 용융시킨다. 일정 온도의 정제수를 다른 용기에 받아 구연산을 넣어 녹인다. 유상조제탱크, 수상조제탱크, 원료용해탱크의 용해가 완료되면 원료용해탱크와 연결된 호스를 유상조제탱크와 연결한 후 밸브를 열어 원료용해탱크에 있는 용해물을 유상조제탱크에 투입하고 교반속도와 시간을 재조정한 후 교반시킨다. 수상조제탱크와 연결된 호스를 유상조제탱크에 연결하고 밸브를 열어 수상조제탱크에 있는 용해된 구연산을 유상조제탱크에 투입하여 안정하게유지하며 부드러운 상태로 만든다. 유화(안정하게 유지하며 부드러운 상태)되는 상태를 관찰하여 일정 온도까지 천천히 냉각시키면서 교반한다. 기포를 제거하기 위해 진공펌프를 가동한다. 첨가제를 물에 녹인 후 유화가 끝난 조제탱크에 넣고 교반한다. 성분의 상태가 크림형태로 변할 때 진공도를 일정하게 유지하고 균질기를 사용하여 균질화한 후 크림상태를 확인한다. 냉각밸브를 열어 일정 온도까지 냉각한 후 교반한다. 조제 완료된 반제품의 견본을 채취하여 품질검사부서로 보낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"수상조제원, 유상조제원","dJobECd":"8523","dJobECdNm":"[8523]화학제품 생산기계 조작원(고무·플라스틱 제외)","dJobJCd":"8321","dJobJCdNm":"[8321]화학제품 생산기 조작원","dJobICd":"C212","dJobICdNm":"[C212]의약품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002903:1', '{"dJobCd":"K000002903","dJobCdSeq":"1","dJobNm":"유화장치조작원","workSum":"의약품, 화장품을 제조하기 위하여 유상용해물, 분말용해물, 수상용해물 등을 혼합·유화시키는 유화장치를 조작·관리한다.","doWork":"유화장치 탱크에 지시된 양까지 분말용액을 쏟아붓는다. 스위치를 넣어 진공펌프를 작동시키고 유상용액탱크의 용해물에 흡입파이프를 삽입한다. 유화탱크에 부착되어 있는 진공게이지를 확인하고 일정한 진공상태가 되면 밸브를 조절하여 혼합물의 흡입량을 조절하고 여과·투입하고 밸브를 잠근다. 스위치를 넣어 교반기를 작동시킨다. 온도게이지를 확인하여 스팀밸브를 열거나 잠그면서 유상혼합물의 온도를 유지시킨다. 수상용해물에 흡입파이프를 넣고 밸브를 열어 투입시킨다. 유화되는 상태를 육안 또는 검사기구를 사용하여 유화 상태를 확인한다. 냉각수 밸브를 열어 냉각수를 유화장치에 통과시켜 진공압을 올리고 유화물질을 냉각, 발포시킨다. 첨가물을 투입해야 하는 온도에 도달하면 탱크 상부의 탱크 호퍼(Hopper)에 색소, 향료, 영양제 등을 투입한다. 버튼을 눌러 교반기를 들어내고 교반기에 묻어 있는 용액을 고무주걱을 사용하여 긁어낸다. 교반기를 하향시키고 온수를 유화조에 투입하여 교반시켜 유화조 내부를 청소한다. 제품이 강압을 요구할 경우 탱크와 뚜껑을 볼트로 단단히 조여 밀폐시키기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8523","dJobECdNm":"[8523]화학제품 생산기계 조작원(고무·플라스틱 제외)","dJobJCd":"8321","dJobJCdNm":"[8321]화학제품 생산기 조작원","dJobICd":"C204/C212","dJobICdNm":"[C204]기타 화학제품 제조업 / [C212]의약품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003476:1', '{"dJobCd":"K000003476","dJobCdSeq":"1","dJobNm":"유화제혼합원","workSum":"유탁제나 유제 제형의 살균제·살충제·제초제를 제조하기 위하여 원제에 유화제 및 기타 보조제를 첨가하여 혼합하는 장치를 조작·관리한다.","doWork":"작업지시서에 따라 생산제품 및 일일작업량을 파악한다. 고상원제는 호이스트와 리프트, 액상원제는 펌프를 사용하여 혼합기로 이동시킨다. 유량계를 주시하면서 일정 배합비에 따라 원료와 부원료 그리고 유화제(어떤 액체가 다른 액체에 부유하도록 하는 여러 화학적 첨가물) 등의 첨가제를 계량하여 투입한다. 상단의 교반축을 혼합기 내부로 내리고 조정판에 혼합조건(교반속도, 온도 등)을 입력한 후 가동한다. 일정 시간 혼합 후 하단의 시료 채취 밸브를 열고 견본을 채취하여 검사한다. 견본의 일부를 품질검사부로 보내 정밀 검사를 의뢰한다. 품질검사부로부터 합격통보를 받은 후 배출밸브를 열고 펌프를 가동하여 여과기로 이송한다. 여과망의 상태를 점검한 후 교체가 필요하면 교체하고 여과시킨다. 여과가 완료되면 저장조로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"계면활성제혼합원","dJobECd":"8523","dJobECdNm":"[8523]화학제품 생산기계 조작원(고무·플라스틱 제외)","dJobJCd":"8321","dJobJCdNm":"[8321]화학제품 생산기 조작원","dJobICd":"C204","dJobICdNm":"[C204]기타 화학제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001246:1', '{"dJobCd":"K000001246","dJobCdSeq":"1","dJobNm":"의약세병기조작원","workSum":"의약품을 충진하기 위하여 준비된 공병을 세척하는 자동세병기계를 조작한다.","doWork":"작업지시서에 따라 세척할 병의 종류와 수량을 확인한다. 세병기의 이온화된 압축공기 압력상태를 점검하고 공기분사노즐 및 작동 여부를 확인한다. 이송컨베이어의 작동 여부를 확인하고 공병의 이동이 원활한지 확인한다. 공병의 회전과 거꾸로 된 공병의 입구로 압축공기가 분사되는 과정에 공병의 이물질이 세척되는 상태를 관찰한다. 제거된 이물질이 외부에 유출되지 않도록 집진장치를 가동하여 작업환경을 개선한다. 작업이 끝난 후 제조지시기록서에 세척한 병의 종류 및 수량을 기록한다. 운전 중 기계의 고장, 병의 파손 등의 이상발생 시 관련 부서에 통보하고 간단한 청소 및 점검을 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8523","dJobECdNm":"[8523]화학제품 생산기계 조작원(고무·플라스틱 제외)","dJobJCd":"8321","dJobJCdNm":"[8321]화학제품 생산기 조작원","dJobICd":"C212","dJobICdNm":"[C212]의약품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001848:1', '{"dJobCd":"K000001848","dJobCdSeq":"1","dJobNm":"의약타정기조작원","workSum":"건조가 완료된 의약반제품을 일정한 크기의 의약정제품으로 만들기 위하여 정제기(타정기)를 조작한다.","doWork":"품질관리부서에서 함량시험에 합격한 의약반제품을 대차에 담아 정제실로 운반해 온다. 작업지시서의 제품번호와 의약반제품이 동일한지 확인한다. 수동공구를 사용하여 명세서에 따라 기계 안에 금형을 설치하고 공기식, 수압식 동력 압착기의 스프링 장력과 램 압력을 조정한다. 리프트(Lift)나 호이스트(Hoist)를 사용하여 의약반제품을 정제기 호퍼(Hopper:분립체의 저장 및 공급장치)에 위치시킨 후 입구를 기울여 투입한다. 정제기의 펀치(타공) 수량과 제품의 원료 및 나정(Tablets) 크기와 정제속도 등을 입력한 후 가동시킨다. 타정할 때 발생되는 분진을 제거할 수 있도록 집진장치를 가동하여 정제한다. 정제된 나정의 평균중량, 경도, 두께, 마손도, 붕해도 등을 측정하고 작업일지에 기록한다. 정제작업이 완료되면 일일작업량을 작업일지에 기록하고 견본을 품질검사부서에 보낸다. 검사결과가 합격이면 정제된 나정을 용기에 담아 보관한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"제환원","dJobECd":"8523","dJobECdNm":"[8523]화학제품 생산기계 조작원(고무·플라스틱 제외)","dJobJCd":"8321","dJobJCdNm":"[8321]화학제품 생산기 조작원","dJobICd":"C212","dJobICdNm":"[C212]의약품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004973:1', '{"dJobCd":"K000004973","dJobCdSeq":"1","dJobNm":"의약품건조기조작원","workSum":"세척한 한약원료나 정제된 의약품 원료의 수분을 제거하기 위하여 건조기를 조작한다.","doWork":"작업지시서에 따라 건조할 의약원료를 확인하고 건조량을 계산한다. 건조기의 작동 여부와 계기 등을 점검한다. 원료를 건조통에 투입한다. 컨트롤박스의 제어판을 조작하여 온도 및 건조시간을 입력한다. 열풍밸브를 열어 건조기에 열풍을 불어넣는다. 일정 시간의 건조가 끝나면 건조기의 작동을 멈춘다. 견본을 채취하여 원료의 건조상태를 점검한다. 열풍밸브를 재조절한다. 작업의 계획수량과 실제 생산된 수량을 확인하여 작업일지에 기록하고 외관상의 결함을 검사한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8523","dJobECdNm":"[8523]화학제품 생산기계 조작원(고무·플라스틱 제외)","dJobJCd":"8321","dJobJCdNm":"[8321]화학제품 생산기 조작원","dJobICd":"C212","dJobICdNm":"[C212]의약품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006296:1', '{"dJobCd":"K000006296","dJobCdSeq":"1","dJobNm":"의약품분병기조작원","workSum":"의약품 최종원액을 병으로 분배하기 위한 분병기를 조작한다.","doWork":"병, 고무마개를 세척·침적·가열·건조·멸균하여 자재를 준비한다. 준비된 병을 자동분병기에 위치시키고 분병기를 조작한다. 분병이 완료된 병을 이동시킨다. 분병 관련 기기나 기자재를 관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","dJobECd":"8523","dJobECdNm":"[8523]화학제품 생산기계 조작원(고무·플라스틱 제외)","dJobJCd":"8321","dJobJCdNm":"[8321]화학제품 생산기 조작원","dJobICd":"C212","dJobICdNm":"[C212]의약품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003580:1', '{"dJobCd":"K000003580","dJobCdSeq":"1","dJobNm":"의약품선별원","workSum":"의약 완제품에서 불량품을 선별하기 위하여 선별기를 조작하거나 육안으로 선별한다.","doWork":"작업지시에 따라 선별할 의약품의 종류와 수량을 확인한다. 적재함에 적재되었거나 보관창고에 보관된 의약완제품을 대차 또는 지게차를 사용하여 선별기로 운반한다. 운반한 제품과 작업지시서의 제품번호가 동일한지 확인한다. 선별기의 작동상태를 점검한 후 이상이 없으면 선별기를 가동하고 선별기 상단의 호퍼(Hopper:분립체의 저장 및 공급장치)에 의약완제품을 투입한다. 선별기를 거친 의약완제품이 컨베이어 벨트 위에 놓여지는 것을 면밀히 살펴서 불량품을 가려낸다. 가려낸 불량품을 별도의 용기에 담는다. 선별이 완료된 의약완제품을 포장공정으로 이송하고자 대차에 모으거나 포장공정과 연결된 컨베이어벨트에 올려놓는다. 작업이 완료되면 불량품의 무게를 재서 작업일지에 기록한다. 정, 캡슐의 경우 코팅 및 제조되어 벨트온푸져(Belt on Puser), 플립바(Flip Bar), 드롭(Drop), 슬라이드캐리어(Slide Carrier)의 이동 컨베이어를 거쳐 중량선별기에 투입하여 의약품의 과량, 정상, 부족의 기준으로 선별기계에 의하여 자동으로 선별하는 작업을 수행하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8523","dJobECdNm":"[8523]화학제품 생산기계 조작원(고무·플라스틱 제외)","dJobJCd":"8321","dJobJCdNm":"[8321]화학제품 생산기 조작원","dJobICd":"C211/C212","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업 / [C212]의약품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002231:1', '{"dJobCd":"K000002231","dJobCdSeq":"1","dJobNm":"의약품원료제조원","workSum":"여러 종류의 의약품 원료를 제조하기 위하여 반응, 농축, 여과, 건조 또는 배양, 분리정제, 여과하는 장치를 조작한다.","doWork":"원료의약품 제조 및 품질관리기준(GMP)에 의하여 의약용 화합물 및 항생물질, 생물학적 제제, 의약용 단백질 등 원료의약품 제조를 위한 작업지시서를 확인한다. 각 의약품의 종류에 따라 원료를 계량한다. 계량된 원료를 이용하여 유기합성반응공정, 미생물배양공정, 동물세포배양공정, 분리정제공정 중 필요한 공정을 거쳐 원료의약품을 제조한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8523","dJobECdNm":"[8523]화학제품 생산기계 조작원(고무·플라스틱 제외)","dJobJCd":"8321","dJobJCdNm":"[8321]화학제품 생산기 조작원","dJobICd":"C211","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004937:1', '{"dJobCd":"K000004937","dJobCdSeq":"1","dJobNm":"의약품정립기조작원","workSum":"의약품 원료를 정해진 입도로 조절하거나 재가공을 위한 정제나 분말로 제조하기 위하여 정립기를 조작·관리한다.","doWork":"압력 정립기, 청칭(淸澄) 정립기, 원심력 정립기 등 정립하고자 하는 의약품 원료에 맞는 정립기를 선택한다. 제품의 특성에 따라 적합한 정립망(체)을 선택한다. 정립망을 세제로 세척하고 스팀으로 멸균한 후 정제수로 세척한다. 정립기에 세척한 정립망을 설치하고, 정립기의 호퍼(Hopper)에 의약품 원료를 투입한다. 의약품 원료를 정립기망에 통과시키고, 정해진 입도로 여과되었는지 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8523","dJobECdNm":"[8523]화학제품 생산기계 조작원(고무·플라스틱 제외)","dJobJCd":"8321","dJobJCdNm":"[8321]화학제품 생산기 조작원","dJobICd":"C211/C212","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업 / [C212]의약품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;