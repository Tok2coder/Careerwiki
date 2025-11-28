INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004051:1', '{"dJobCd":"K000004051","dJobCdSeq":"1","dJobNm":"전자기타부품조립원","workSum":"전자기타를 제조하기 위해 전자 부품을 납땜하고 몸통, 넥 등 부품을 조립한다.","doWork":"육안으로 전자 부품의 상태를 점검한다. 작업계획서에 따라 배선도를 참고하여 볼륨 노브(Knob), 픽업 등 전자부품을 납땜한다. 몸통의 정해진 위치에 전자부품을 끼우고 수동공구로 고정시킨다. 넥을 몸통의 정해진 홈에 위치시킨 후 수동공구를 사용하여 고정시킨다. 브리지(Bridge), 줄감개 등 외장을 조립한다. 현을 매달아 전자기타를 완성한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8851","dJobECdNm":"[8851]악기 제조원 및 조율사","dJobJCd":"7303","dJobJCdNm":"[7303]악기 제조 및 조율사","dJobICd":"C332","dJobICdNm":"[C332]악기 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006665:1', '{"dJobCd":"K000006665","dJobCdSeq":"1","dJobNm":"전자오르간검사원","workSum":"제조된 전자오르간을 제품검사 규격에 따라 육안이나 측정기기를 사용하여 검사한다.","doWork":"작업표준서에 명시된 검사규격을 숙지한다. 전자오르간을 작동시켜 전원이 들어오는지 확인한다. 건반덮개, 악보대, 발판 등을 움직여 작동상태를 점검한다. 볼륨조절기, 음원선택기 등 버튼을 눌러보고 상태를 점검한다. 건반을 눌러 소리가 나오는지 확인한다. 내장된 프로그램에 이상이 없는지 확인한다. 이상이 있으면 회로도면을 살펴보고 작업표준서에 명시된 표준시험을 한다. 작업표준서와 회로도면을 참조하여 결함이 있는 부품과 배선을 교체하고 수동공구를 사용하여 부품을 조정한다. 외장, 내장이 규격대로 가공되었는지 버니어캘리퍼스, 게이지 등으로 측정한다. 측정 자료에 따라 제품을 판정하고 성적표를 작성한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"청각|손사용|시각|","workEnv":"소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"8851","dJobECdNm":"[8851]악기 제조원 및 조율사","dJobJCd":"7303","dJobJCdNm":"[7303]악기 제조 및 조율사","dJobICd":"C332","dJobICdNm":"[C332]악기 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003444:1', '{"dJobCd":"K000003444","dJobCdSeq":"1","dJobNm":"피아노액션조립원","workSum":"피아노 제조 시 액션(연동장치)이 흔들리거나 기울어지고 뒤틀어진 부분을 수동공구를 사용하여 조정하고 조립한다.","doWork":"입고된 액션의 해머(Hammer), 다리(Shank), 댐퍼레버(Damper Lever), 버트(Butt) 등을 손으로 눌러보아 흔들림, 기울기, 높이, 뒤틀린 상태를 관찰한다. 테이프나 드라이버 등을 사용하여 작동이 원활하도록 조정한다. 불량한 부품은 교환한다. 스켈레톤(Skeleton)에 액션을 삽입하고 고정나사를 조여 고정시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"댐퍼레버조정원, 댐퍼조정원, 버트조정원, 입펜조정원, 해머조정원","certLic":"피아노조율산업기사, 피아노조율기능사","dJobECd":"8851","dJobECdNm":"[8851]악기 제조원 및 조율사","dJobJCd":"7303","dJobJCdNm":"[7303]악기 제조 및 조율사","dJobICd":"C332","dJobICdNm":"[C332]악기 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006382:1', '{"dJobCd":"K000006382","dJobCdSeq":"1","dJobNm":"피아노튜닝핀가공원","workSum":"피아노 부품인 튜닝핀(Tuning Pin)을 가공하는 기계를 조작한다.","doWork":"작업지시서에 따라 튜닝핀 재료를 머리 부분과 구별하여 적재함에 투입한다. 물림대에 튜닝핀이 물리도록 자동제어장치를 조작한다. 절삭바이트를 일정속도로 이동시켜 튜닝핀을 절삭한다. 절삭 작업 중에 수시로 절삭유를 공급한다. 버튼을 조작하여 성형기를 가동한다. 가동 중인 기계의 상태를 점검하고 절삭유를 공급한다. 튜닝핀의 나사산(나사의 골과 골 사이의 높은 부분)이나 절삭 가공된 부분이 규격이 맞는지 게이지와 육안으로 검사한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"조작운전","dJobECd":"8851","dJobECdNm":"[8851]악기 제조원 및 조율사","dJobJCd":"7303","dJobJCdNm":"[7303]악기 제조 및 조율사","dJobICd":"C332","dJobICdNm":"[C332]악기 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003418:1', '{"dJobCd":"K000003418","dJobCdSeq":"1","dJobNm":"피아노핀압입원","workSum":"피아노 제조 시 스켈레톤(Skeleton)조립품에 나무망치나 공기해머를 사용하여 각종 핀(Pin)을 압입한다.","doWork":"이미 뚫어진 구멍에다 나무망치나 공기해머를 사용하여 튜닝 부싱을 압입한다. 드릴을 사용하여 튜닝구멍을 뚫은 후, 압입기로 튜닝핀을 박는다. 굽히는 공구를 사용하여 힛치핀(Hitch Pin), 연결핀(Bearing Pin)을 일정 각도로 굽혀준다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"웅크림|손사용|시각|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"건반악기핀박기원","connectJob":"베어링핀압입원, 튜닝부싱천압입원, 튜닝핀압입원, 힛치핀압입원","dJobECd":"8851","dJobECdNm":"[8851]악기 제조원 및 조율사","dJobJCd":"7303","dJobJCdNm":"[7303]악기 제조 및 조율사","dJobICd":"C332","dJobICdNm":"[C332]악기 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006185:1', '{"dJobCd":"K000006185","dJobCdSeq":"1","dJobNm":"현악기수선원","workSum":"바이올린, 비올라, 첼로, 콘트라베이스, 기타 등 현악기의 고장 부분을 수선한다.","doWork":"현악기의 결함을 알아내기 위해 직접 연주하여 본다. 수동공구를 사용하여 프렛(Fret:현악기의 기러기발)을 빼내어 새 부품으로 대체한다. 나무와 금속부품을 대체하여 조립한다. 넥(Neck:악기 따위의 잘록한 부분)과 현을 배열하기 위해 트러스(Truss:직선봉을 삼각형으로 조립한 일종의 보재)막대기와 브리지(Bridge)를 조절한다. 악기를 조율하기 위해 건반과 줄을 연주해 보고 조절한다. 각종 결함 부품을 대체한다. 교환한 부품과 각 부품의 연결부분을 납땜한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"청각|손사용|시각|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"현악기조율원","connectJob":"기타수선원, 더블베이스수선원, 만도린수선원, 바이올린수선원, 비올라수선원, 첼로수선원, 하프수선원, 어쿠스틱기타수선원, 전자기타수선원","dJobECd":"8851","dJobECdNm":"[8851]악기 제조원 및 조율사","dJobJCd":"7303","dJobJCdNm":"[7303]악기 제조 및 조율사","dJobICd":"C332","dJobICdNm":"[C332]악기 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004501:1', '{"dJobCd":"K000004501","dJobCdSeq":"1","dJobNm":"현악기제작원","workSum":"바이올린, 비올라, 첼로 등 현악기를 제조하기 위해 목재를 가공하고 완성된 악기를 직접 연주하여 상태를 점검한다.","doWork":"악기의 종류에 알맞은 목재를 선별한다. 앞판을 제조하기 위해 목재에 도본(圖本)한다. 톱, 띠톱 등 절단기구를 사용하여 도본에 맞추어 절단한다. 목공구를 사용하여 평평한 목재를 파내어 형태를 성형한다. 울림통 형태의 몰드에 블록(옆판을 지지하는 뼈대)를 끼운 후 사포로 연마한다. 옆판에 쓰일 나무를 알맞은 두께로 가공한다. 게이지로 두께를 측정한다. 열성형기를 가동하여 일정 시간 예열시킨다. 열성형기에 나무판을 댄 후 철판으로 당겨 휘어준다. 블록과 옆판에 붓으로 아교를 바른 후 접착한다. 고정공구로 일정 시간 고정시킨다. 옆판의 형태를 참조하여 뒤판에 쓰일 목재에 도본한다. 톱, 띠톱 등 절단기구를 사용하여 도본에 맞추어 절단한 후 목공구를 사용하여 나무를 깎아낸다. 베이스바(Bass-Bar) 제조에 쓰일 목재를 선별하여 알맞은 크기로 가공한다. 앞판의 안쪽 면에 베이스바를 부착할 장소를 정해 백묵을 칠한다. 백묵에 아교를 바르고 평평한 목재를 갖다 대어 백묵이 묻는 정도를 관찰한다. 목재에 백묵이 골고루 묻을 때까지 나무를 깎아준다. 완성된 베이스바를 접착한다. 앞·뒤 판에 아교를 발라 옆판에 접착 후 고정공구로 일정 시간 고정시킨다. 넥을 제조하기 위해 가공할 위치를 측정하고 도본한다. 목공구를 사용하여 나무를 깎고 사포로 연마한다. 울림통에 홈을 깎고 넥을 끼워 맞춘다. 흑단을 알맞은 크기로 절단하고 연마하여 아교를 발라 넥에 접착한다. 붓, 경화제, 셀락 등을 사용하여 악기를 도장한다. 엔드핀, 새들, 페그 등 외장을 조립하고 현을 매단다. 울림통과 현 사이에 브리지를 끼운다. 현을 조율하고 악기를 직접 연주하여 상태를 점검한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"바이올린제작원, 비올라제작원, 첼로제작원, 더블베이스제작원, 현악기가공원, 현악기돌림목성형원, 현악기부품성형원, 현악기울림통조립원, 현악기지판접착원, 현악기향봉접착원","dJobECd":"8851","dJobECdNm":"[8851]악기 제조원 및 조율사","dJobJCd":"7303","dJobJCdNm":"[7303]악기 제조 및 조율사","dJobICd":"C332","dJobICdNm":"[C332]악기 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002912:1', '{"dJobCd":"K000002912","dJobCdSeq":"1","dJobNm":"현악기현제조원","workSum":"기타, 바이올린 등에 사용되는 악기 현을 제조한다.","doWork":"강선, 나일론줄 등 현을 제조하는 데 필요한 자재를 점검한다. 물레에 줄을 걸고 레버를 조작하여 회전시켜 줄을 일정한 길이로 풀어 절단한다. 링의 홈에 현을 걸어 집게로 고정시킨다. 고리제조기의 갈고리에 링을 걸고 페달을 발로 밟아 모터를 작동한다. 링이 감긴 줄에 코일을 감기 위해 권선기의 양끝 고리에 줄을 건다. 코일을 줄의 링 부분에 매달아 페달을 발로 밟아 모터를 회전시킨다. 감은 현을 권선기에서 빼내고 남은 코일을 절단기로 자른다. 완성된 현을 감아 포장지에 담는다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","connectJob":"고리제조원, 권선원, 현압축원","dJobECd":"8851","dJobECdNm":"[8851]악기 제조원 및 조율사","dJobJCd":"7303","dJobJCdNm":"[7303]악기 제조 및 조율사","dJobICd":"C332","dJobICdNm":"[C332]악기 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001240:1', '{"dJobCd":"K000001240","dJobCdSeq":"1","dJobNm":"간판설치원","workSum":"수동공구, 동력공구, 크레인 등을 이용해 각종 장소나 건물에 간판, 사인, 광고물 등을 설치한다.","doWork":"설치할 장소에 삽, 해머드릴 등의 기계 및 기구를 사용하여 구멍을 판다. 파이프나 금속기둥을 구멍에 세우고 기둥을 수직으로 고정하기 위하여 기둥 둘레에 돌, 모래, 자갈, 시멘트 등을 채운다. 밧줄, 수동공구, 크레인 등을 사용하여 기둥에 간판이나 광고물을 붙이고 볼트와 너트로 고정한다. 간판을 건물에 설치할 때에는 부착위치를 지정된 곳에 표시한다. 지지대나 볼트, 너트를 이용하여 간판을 건물의 벽면에 부착한다. 간판에 연결되어 있는 전선을 전원에 연결하고 간판의 작동상태를 확인한다. 세척 또는 페인트칠을 하거나 간판을 부착하기 위해 용접을 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"힘든 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","certLic":"광고도장기능사, 옥외광고사2급","dJobECd":"8852","dJobECdNm":"[8852]간판 제작·설치원","dJobJCd":"7304","dJobJCdNm":"[7304]간판 제작 및 설치원","dJobICd":"C339","dJobICdNm":"[C339]그 외 기타 제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002479:1', '{"dJobCd":"K000002479","dJobCdSeq":"1","dJobNm":"간판제작원","workSum":"전기 간판 등 간판을 제작하기 위해 아크릴판에 글자나 문양 등을 새기고 일정한 크기로 자른 후 조명을 위한 형광등과 전기재료를 부착·조립한다.","doWork":"설계도면에 따라 아크릴판이나 기타 재료 위에 문자, 상표, 무늬 등을 필기도구로 스케치한다. 스케치된 부분을 칼, 톱, 쇠톱, 줄 등을 사용하여 자른다. 접착제를 아크릴이나 금속, 고무에 도포하여 접착한다. 접착한 재료를 열처리하거나 스프레이로 도장을 한다. 설계도면에 따라 형광등과 같은 전기재료를 부착·조립하고 전선을 연결한다. 간판을 조립하기 위해 전동공구나 드릴로 구멍을 뚫고 볼트와 너트로 고정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|손사용|시각|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"간판수리원, 네온관제작원","certLic":"광고도장기능사, 옥외광고사","dJobECd":"8852","dJobECdNm":"[8852]간판 제작·설치원","dJobJCd":"7304","dJobJCdNm":"[7304]간판 제작 및 설치원","dJobICd":"C339","dJobICdNm":"[C339]그 외 기타 제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001297:1', '{"dJobCd":"K000001297","dJobCdSeq":"1","dJobNm":"금형모델프로그래머","workSum":"금형을 제작하기 위한 설계도면의 데이터를 CAM에 입력하여 NC가공 데이터를 생성한 후 모의 가공 등을 데이터를 수정하여 CNC가공 데이터를 추출한다.","doWork":"설계된 금형도면을 받아 가공설비의 기계적인 특성에 따른 제작방법을 설계하고 세부항목을 조정하여 세부 제작도면을 제작한다. 세부 제작도면의 각 항목을 숫자, 문자, 기호 등의 형태로 CAM(Computer Aide Manufacturing)에 입력한다. 생산된 샘플이 설계 의도에 맞게 생산되었는지 여부를 살펴보고, 이상 시 수정작업을 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"금형프로그래머, 금형CAD/CAM기사","connectJob":"금형설계원","certLic":"사출금형기사, 프레스금형기사","dJobECd":"8131","dJobECdNm":"[8131]금형원","dJobJCd":"7411","dJobJCdNm":"[7411]금형원","dJobICd":"C243/C259","dJobICdNm":"[C243]금속 주조업 / [C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004773:1', '{"dJobCd":"K000004773","dJobCdSeq":"1","dJobNm":"금형방전원","workSum":"복잡하고 정밀한 금형을 제작하기 위하여 전극을 사용하여 전기적인 힘으로 금형을 가공하는 방전기를 조정·조작한다.","doWork":"작업지시서의 작업내용을 확인하고 지시사항에 가공에 적합한 전극을 선택한다. 공작물의 정밀한 가공을 위하여 전극과 공작물의 불순물을 세척액으로 제거한다. 전극과 공작물에 좌·우·상·하 중심을 설정하여 공작물을 장착하고 방전가공 치수를 제어판에 입력한다. 전극의 과열을 방지하기 위하여 가공유를 공급·조절한다. 작업이 종료되면 가공 깊이 및 치수를 측정·확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"방전기조작원","certLic":"금형기능사, 사출금형산업기사","dJobECd":"8131","dJobECdNm":"[8131]금형원","dJobJCd":"7411","dJobJCdNm":"[7411]금형원","dJobICd":"C243/C259","dJobICdNm":"[C243]금속 주조업 / [C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002884:1', '{"dJobCd":"K000002884","dJobCdSeq":"1","dJobNm":"금형설치원","workSum":"열가소성 플라스틱 재료를 일정한 모양으로 사출·성형하기 위한 주입형이나 압축용 금형을 설치하고 관리한다.","doWork":"작업지시서를 읽고 수지의 종류, 제품의 투형 면적, 제품의 디자인, 제품의 무게, 사출기의 사양 등을 파악한다. 금형보관실에서 맞는 금형을 선택한다. 호이스트를 사용하여 설치할 금형을 사출성형기에 옮긴다. 금형의 고정측와 가동측을 맞물린다. 금형의 스프루부시(Sprue Bush:수지 용액 등을 주입하는 금형 입구 장치)를 금형의 중앙에 맞춰 아이볼트로 단단히 고정한다. 실린더노즐의 주입부의 중앙과 일치하게 놓고 스프루부시 중앙과 실린더노즐 주입부가 정확히 일치되었는지 종이 등을 대고 기계를 작동시켜 확인한다. 맞지 않을 경우 레버를 돌려 실린더를 움직여 중앙에 일치시킨다. 냉각수 호스를 연결하여 사출기금형의 내부에 냉각수를 주입한다. 금형의 녹을 방지하기 위하여 방청제 등을 뿌려 유지·보수한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"설치","certLic":"금형기능사, 사출금형산업기사, 프레스금형산업기사, 금형제작기능장","dJobECd":"8131","dJobECdNm":"[8131]금형원","dJobJCd":"7411","dJobJCdNm":"[7411]금형원","dJobICd":"C222","dJobICdNm":"[C222]플라스틱제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002450:1', '{"dJobCd":"K000002450","dJobCdSeq":"1","dJobNm":"금형정비반장","workSum":"금형을 보관하고 파손되거나 마모된 금형을 절삭, 커팅, 연마, 용접 등을 통해 정비하는 작업원의 직무를 분장하고 조정 한다.","doWork":"선반, 밀링, 연마기 등 각 기계 및 보조공구의 이상 유무를 확인한다. 금형정비내용을 파악하여 작업원에게 작업을 지시하고 함께 작업하며 작업이행 여부를 확인한다. 정비가 완료된 금형을 측정기구를 사용하여 검사한다. 금형정비에 필요한 직무교육 및 안전위생교육을 통하여 작업원의 직무수행능력을 향상시키고 안전재해를 예방한다. 금형의 수리가 불가할 때에는 부분 금형 제작이나 신금형의 제작을 의뢰한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"대기환경미흡|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"금형수리반장","connectJob":"금형조립원","certLic":"금형기능사, 사출금형산업기사, 프레스금형산업기사, 금형제작기능장","dJobECd":"8131","dJobECdNm":"[8131]금형원","dJobJCd":"7411","dJobJCdNm":"[7411]금형원","dJobICd":"C243","dJobICdNm":"[C243]금속 주조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003248:1', '{"dJobCd":"K000003248","dJobCdSeq":"1","dJobNm":"금형정비원","workSum":"주조금형을 정비, 보관하고 이상이 생겼을 때 절삭, 연마, 용접 등의 가공을 통해 사용가능하도록 성형한다.","doWork":"금형의 정밀도를 유지하기 금형의 형합(분리, 조립)과 사용 후 세척, 보관, 적재를 한다. 금형을 작업하기 전에 에어브러시나 솔, 세척제 등으로 세척한다. 조립 시 금형의 틈새가 벌어지지 않았는지 확인하여 금형파손을 예방한다. 작업 후 금형의 각 틈과 구멍(홀)에 남아 있는 냉각수 등 이물질을 에어브러시 등으로 제거한다. 사용 중 이상이 발생한 금형은 분해하여 이상부위를 확인하고 도면과 비교하여 절삭, 연마, 용접 등이 가공을 통해 정비하여 재조립한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"금형수리원","connectJob":"금형제작원","certLic":"금형기능사, 사출금형산업기사, 프레스금형산업기사","dJobECd":"8131","dJobECdNm":"[8131]금형원","dJobJCd":"7411","dJobJCdNm":"[7411]금형원","dJobICd":"C243","dJobICdNm":"[C243]금속 주조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004665:1', '{"dJobCd":"K000004665","dJobCdSeq":"1","dJobNm":"금형제작반장","workSum":"단조 및 주조에 사용되는 금형을 현도·가공·제작·조립하는데 작업원의 직무를 분장하고 조정한다.","doWork":"제작할 금형의 가공 방법 및 절차, 금형의 구성체 수 등을 고려하여 작업을 지시하고 작업자와 함께 작업하며 작업내용을 점검한다. 금형제작에 필요한 선반, 밀링, 방전기 및 기타 보조공구를 점검한다. 제품도 및 견본품을 검사하여 현도를 제작한다. 현도 된 금형을 적정공정에 배치·이동한다. 정밀을 요하는 금형은 방전실로 보낸다. 제작 완료된 금형을 게이지·캘리퍼스 등 측정기구를 사용하여 검사한다. 금형의 설계와 가공, 검사의 전 과정을 관리, 감독하며 금형의 품질을 관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"대기환경미흡|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","certLic":"금형기능사, 사출금형산업기사, 프레스금형산업기사, 금형제작기능장","dJobECd":"8131","dJobECdNm":"[8131]금형원","dJobJCd":"7411","dJobJCdNm":"[7411]금형원","dJobICd":"C243/C259","dJobICdNm":"[C243]금속 주조업 / [C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003576:1', '{"dJobCd":"K000003576","dJobCdSeq":"1","dJobNm":"금형제작원","workSum":"금형을 선반, 밀링기, 방전기, 기타 보조공구를 사용하여 금형을 가공·제작한다.","doWork":"작업지시서와 제작도면에 따라 금형소재와 부자재를 결정 및 준비하고 각종 가공기계의 유압과 작동상태를 확인한다. 규정된 절삭공구를 공구대에 장치하고 자동제어장치에 프로그램을 입력한다. 기계를 작동시키고 프로그램의 공정도와 패널의 숫자를 확인하면서 가공하는 금형의 정밀도에 따라 황삭·중삭·정삭 및 중정삭 가공공정을 통해 가공한다. 마이크로미터, 다이얼게이지, 캘리퍼스 등 측정기구나 가공된 금형에 석고를 부어 금형의 가공상태를 관찰하고 도면과 가공치수의 일치도를 확인한다. 일차 가공된 금형을 정밀하게 가공하기 위하여 방전기에서 가공하고 후처리 작업을 한다. 후처리 작업이 끝난 금형에 석고를 부어 금형을 확인하고 필요시 재가공한다. 합격된 금형은 도금 및 문자를 조각한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"금형가공원","connectJob":"프레스금형제조원, 프레스금형미각기원, 프레스제조원, 금형제작수리원, 프레스금형원, 프레스금형래핑원, 플라스틱금형제조원, 플라스틱금형제작원, 플라스틱금형조립원, 플라스틱금형원, PCB금형제조원, 플라스틱금형래핑원, 플라스틱금형미각기원, 다이캐스팅금형제조원, 주조금형제조원, CS가공금형제작원, 주물금형제작원, 다이캐스팅금형원, 다이캐스팅래핑원, 다이캐스팅미각기원","certLic":"금형기능사, 사출금형산업기사, 프레스금형산업기사, 금형제작기능장","dJobECd":"8131","dJobECdNm":"[8131]금형원","dJobJCd":"7411","dJobJCdNm":"[7411]금형원","dJobICd":"C243/C259","dJobICdNm":"[C243]금속 주조업 / [C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007157:1', '{"dJobCd":"K000007157","dJobCdSeq":"1","dJobNm":"금형조립원","workSum":"가공된 금형부품을 조립하여 완성된 금형을 만든다.","doWork":"마이크로미터, 버니어캘리퍼스 등의 측정기구를 사용하여 가공이 완료된 부품이 도면과 일치하는지 확인한다. 도면의 조립절차에 따라 금형을 조립한다. 조립이 완성된 금형의 치수 및 요철 부분의 간격 등을 측정기구를 이용하여 검사한다. 이상이 있는 부분은 사상 작업을 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"금형제작원","connectJob":"프레스금형조립원, 주조용금형조립원","certLic":"금형기능사, 사출금형산업기사, 프레스금형산업기사, 금형제작기능장","dJobECd":"8131","dJobECdNm":"[8131]금형원","dJobJCd":"7411","dJobJCdNm":"[7411]금형원","dJobICd":"C243/C259","dJobICdNm":"[C243]금속 주조업 / [C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007248:1', '{"dJobCd":"K000007248","dJobCdSeq":"1","dJobNm":"자동차금형원형제작원","workSum":"신차종 개발 및 모델 변경 시 금형제작을 위해 모델을 제작하고 금형에 의해 양산된 바디패널의 검사를 위한 검사치구를 제작한다.","doWork":"설계도 또는 도면을 검토하여 수치표를 작성하고 제작에 관한 구상을 한다. 모델 제작 시 필요한 부위에 여유를 주고 형판을 제작한다. 제작된 형판을 조립하여 최종적으로 만들어질 모델의 반대 형태인 형판원형을 제작한다. 제작된 모델 표면층에 수지를 주입하여 적층한 후 강철파이프 또는 수지파이프를 사용하여 프레임을 설치하고 수지가 충분히 경화되면 형판원형에서 떼어내 기초를 만든다. 떼어낸 기초를 가공하고 정반에 고정시켜 끌이나 사포를 사용하여 표면을 정밀하게 다듬어 완성한다. 금형에 의해 양산된 바디패널을 검사하기 위하여 검사치구를 제작한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"웅크림|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"금형기능사, 금형제작기능장, 사출금형산업기사, 프레스금형산업기사, 치공구설계산업기사","dJobECd":"8131","dJobECdNm":"[8131]금형원","dJobJCd":"7411","dJobJCdNm":"[7411]금형원","dJobICd":"C301","dJobICdNm":"[C301]자동차용 엔진 및 자동차 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004601:1', '{"dJobCd":"K000004601","dJobCdSeq":"1","dJobNm":"자동차모형제작원","workSum":"기존 자동차의 내·외부를 바꾸거나 새로운 차를 개발할 때 디자이너들이 제시한 도안의 모형을 제작한다.","doWork":"디자이너들의 아이디어를 형상화한다. 디자이너의 요청에 따르거나 디자이너가 제시한 안에 따라 모형제작용 진흙, 나무, 플라스틱 등 여러 가지 재료를 이용해 기본형을 제작한다. 기본형을 다듬어서 모형을 제작하며 기술적인 사항을 검토하여 모형을 완성한다. 2차원으로 진행된 디자인 안을 입체적 형상으로 구현하기 위하여 클레이(Clay)를 이용하여 3차원으로 형상화한다. 컴퓨터를 이용하여 3D 디지털 모델을 제작한다. 수치제어가공기를 사용하여 축소 모델을 제작한 후 채택된 디자인을 실물크기 모델로 제작한다. 완성된 모형차체에 칠을 하고 부속품을 장착하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"자동차모델러","dJobECd":"8131","dJobECdNm":"[8131]금형원","dJobJCd":"7411","dJobJCdNm":"[7411]금형원","dJobICd":"C302/M732","dJobICdNm":"[C302]자동차 차체 및 트레일러 제조업 / [M732]전문 디자인업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007698:1', '{"dJobCd":"K000007698","dJobCdSeq":"1","dJobNm":"타이어금형(몰드)교체원","workSum":"타이어를 생산하는데 필수적인 몰드(금형)를 클리닝하고 규격에 맞게 준비하며 금형의 세척 및 준비, 예열 및 교체 등의 업무를 병행하기도 한다.","doWork":"작업지시서를 확인 후 규격에 맞는 몰드(금형)를 작업계획을 사전에 확인하고 준비한다. 확인된 금형을 가류공정에서 교체 지시 또는 요청받으면 작업지시에 따라 금형을 지게차 협조를 받아 조립한다. 금형의 세척 및 준비, 예열 및 교체 등의 업무를 병행하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"타이어금형설치원","connectJob":"타이어가류기(가황기)조작원","certLic":"금형기능사, 사출금형산업기사, 프레스금형산업기사, 금형제작기능장","dJobECd":"8131","dJobECdNm":"[8131]금형원","dJobJCd":"7411","dJobJCdNm":"[7411]금형원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2025"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001677:1', '{"dJobCd":"K000001677","dJobCdSeq":"1","dJobNm":"기계조형원","workSum":"금속주물을 생산하는 데 사용되는 주형을 주형상자, 모래, 주물사, 수공구 등을 이용하여 주조품의 도면과 일치하도록 제작한다.","doWork":"조형반장의 지시사항과 제품의 종류, 작업량 및 기타 특이사항을 기록한 조형작업지시서의 내용을 확인하고 주형작업에 필요한 각종 자재 및 공구를 준비한다. 주형상자와 모형을 검사하여 진동테이블에 올려놓고 조립한다. 삽을 사용하여 주형상자에 주물사를 채우고, 상·하 주형상자를 결합하고 모형둘레에 주물사를 채운다. 고압식 해머로 모형 둘레의 주물사를 다지고 주형상자에 주물사가 채워지도록 기계를 작동한다. 주형의 종류에 따라 진동수를 조절한다. 주입구와 가스 배출구를 만들고 상부주형상자를 들어내고 모형을 떼어낸다. 공기호스를 사용하여 주형의 빈 구멍을 청소한다. 중자를 빈 구멍에 고정시켜 조립하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"원형기능사, 주조기능사, 주조산업기사, 주조기능장","dJobECd":"8233","dJobECdNm":"[8233]주조원","dJobJCd":"7412","dJobJCdNm":"[7412]주조원","dJobICd":"C243","dJobICdNm":"[C243]금속 주조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006860:1', '{"dJobCd":"K000006860","dJobCdSeq":"1","dJobNm":"내화물피복원","workSum":"조립된 트리 또는 크러스트 등의 왁스모형 외부를 세라믹 내화물로 피복(코팅)하여 주조한다.","doWork":"작업지시서 및 왁스모형조립반장의 지시에 따라 작업내용을 확인하고 재료 및 관련 기기의 작동상태를 점검한다. 모래 및 접착제를 혼합하여 피복재를 제조한다. 전 공정에서 제작된 왁스트리의 표면에 세라믹 내화물을 도포한다. 내화물 피복장치를 작동시켜 왁스트리 표면에 피복재를 도포한다. 지정된 횟수만큼 침적과 코팅, 건조를 반복하여 주조가 가능한 상태로 성형한다. 완료된 제품을 검사한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"주조기능사, 주조산업기사, 주조기능장","dJobECd":"8233","dJobECdNm":"[8233]주조원","dJobJCd":"7412","dJobJCdNm":"[7412]주조원","dJobICd":"C243","dJobICdNm":"[C243]금속 주조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001392:1', '{"dJobCd":"K000001392","dJobCdSeq":"1","dJobNm":"목형검사원","workSum":"주조에 사용되는 목형(木型)의 제작상태와 도면과의 일치 여부, 주조방안과의 일치 여부를 검사한다.","doWork":"제작된 모형을 정반 위에 손이나 호이스트를 이용하여 이동시킨 뒤 제품의 형상을 도면과 대조하여 이상 유무를 확인한다. 목형에 표시된 기준선 및 중심선 등을 확인하고 주조명세서·수축률 및 가공 여유 등을 고려하여 수축자, 분도기, 높이게이지 및 기타 특정 기구를 사용하여 목형을 실측해서 치수상의 이상 유무를 확인한다. 제작된 목형의 견고성 및 합리성 등을 육안 및 촉감으로 검사한다. 원도에 따라 그려진 현도를 제도기구를 사용하여 측정·검사하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"힘든 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"원형기능사, 주조기능사, 주조산업기사, 주조기능장","dJobECd":"8233","dJobECdNm":"[8233]주조원","dJobJCd":"7412","dJobJCdNm":"[7412]주조원","dJobICd":"C243","dJobICdNm":"[C243]금속 주조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004976:1', '{"dJobCd":"K000004976","dJobCdSeq":"1","dJobNm":"목형설계원","workSum":"주조에 사용되는 목형을 만들기 위한 현장세부도면(현도)을 그린다.","doWork":"제작할 주형의 특성을 파악하고 목형을 설계하기 위한 도면을 보고 치수들의 불일치점이 없는지 확인한다. 주형 제작이 용이하도록 목형의 형태와 분할방법을 검토하여 결정한다. 도면치수를 목형치수로 환산하고 부분별로 보정치수 및 가공대치수를 추가하여 목형 제작용 도면을 설계한다. 목형 제작용 도면이 작도되면 결재를 받고 복사하여 외주 및 검사용 등으로 송부한다. 시제품의 결과를 도면치수와 비교하여 목형수정방안을 결정하고 제품의 결과가 만족할 때까지 반복 수정·보완한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"목형캐드설계원","certLic":"원형기능사","dJobECd":"8233","dJobECdNm":"[8233]주조원","dJobJCd":"7412","dJobJCdNm":"[7412]주조원","dJobICd":"C243","dJobICdNm":"[C243]금속 주조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003224:1', '{"dJobCd":"K000003224","dJobCdSeq":"1","dJobNm":"목형제작반장","workSum":"주물제품(鑄物製品)을 만들기 위하여 필요한 주형(鑄型)을 만드는데 사용되는 목형(木型)을 제작하는 작업원의 활동을 감독·조작한다.","doWork":"제품생산계획에 따라 생산할 목형의 재료 및 부재료 등의 관리와 공장의 안전상태 등을 수시로 점검한다. 목형제작을 위한 주조방안을 주조반장과 협의하여 결정한다. 제작된 목형을 검사하여 이상 유무를 판단한다. 작업 시 작업자에게 기술지도를 하며, 현장을 관찰하여 문제점을 수정·보완한다. 제작된 목형이나 사용한 목형을 보관·관리하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","certLic":"원형기능사","dJobECd":"8233","dJobECdNm":"[8233]주조원","dJobJCd":"7412","dJobJCdNm":"[7412]주조원","dJobICd":"C243","dJobICdNm":"[C243]금속 주조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003883:1', '{"dJobCd":"K000003883","dJobCdSeq":"1","dJobNm":"목형제작원","workSum":"설계도면(현도)에 따라 주물주조에 사용되는 주형 모형인 목형을 제작한다.","doWork":"목형 설계도면에 따른 재질과 특성을 파악하고 목형제작반장의 작업지시에 따라 세부적인 작업계획을 수립한다. 목자재에 도면의 치수를 쇠자, 직각자, 연필 등의 제도기구를 사용하여 가공 여부를 고려하여 설계한다. 설계된 목자재를 수공구와 자동공구(목선반) 등을 이용하여 가공한다. 각 부분을 못, 나사, 접착제 등을 이용하여 조립한다. 나사나 못의 머리 부위를 보강하고 마무리한다. 조립이 완성된 목형은 치수를 검사하고, 이상이 없으면 최종적으로 수공구를 사용하여 세밀하게 표면을 마무리한다. 완성된 목형의 보호를 위해 페인트나 니스를 도포한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"목형기능원, 모형원, 모형제조원, 원형원, 목형원, 수지형원","connectJob":"목형다듬질원, 목형조립원, 목형페인트원, 목형현도원","certLic":"원형기능사","dJobECd":"8233","dJobECdNm":"[8233]주조원","dJobJCd":"7412","dJobJCdNm":"[7412]주조원","dJobICd":"C243","dJobICdNm":"[C243]금속 주조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006650:1', '{"dJobCd":"K000006650","dJobCdSeq":"1","dJobNm":"선박주형제작원","workSum":"FRP(유리섬유강화플라스틱) 선박건조에 사용되는 주형을 제조한다.","doWork":"주어진 도면을 보고 공구 및 목재를 준비한다. 나무를 기계톱을 이용하여 도면에 맞게 절단한다. 도면을 보고 나무에 현도(축적된 도면을 실물 크기로 확대, 평면 위에 나타나게 한 것)를 그린다. 현도의 모양대로 목재를 절단한다. 절단된 목재를 선수부와 선미부의 형태에 맞게 설치하고 지지대를 설치한다. 합판을 골격에 부착하여 배의 형상을 만든다. 날카로운 부분은 연마기를 이용하여 다듬는다. 완성된 주형이 도면과 일치하는지 확인하다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"원형기능사","dJobECd":"8233","dJobECdNm":"[8233]주조원","dJobJCd":"7412","dJobJCdNm":"[7412]주조원","dJobICd":"C311","dJobICdNm":"[C311]선박 및 보트 건조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003068:1', '{"dJobCd":"K000003068","dJobCdSeq":"1","dJobNm":"수동조형원","workSum":"주형상자, 모형, 주물사, 수동공구를 이용하여 주조품의 도면과 일치하는 주형을 제작한다.","doWork":"목형치수와 도면이 일치하는지 확인한다. 하부주형상자를 정반 위에 놓고 탕도를 설치한 다음 주형과 목형에 이형제를 분무한다. 주물사를 주형상자에 넣고 손이나 공기램(Ram)으로 다져준다. 상부주형을 만들기 위해 하부주형을 뒤집고 모형과 상부주형상자를 하부주형상자 위에 놓는다. 하부에서 상부주형상자를 올리고 모형을 분리한다. 이형한 후 중자 등을 조립하여 상부주형상자를 조립한다. 주형의 굳히는 방법을 조형방법에 따라 달리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"이산화탄소조형원","certLic":"원형기능사, 주조기능사, 주조산업기사, 주조기능장","dJobECd":"8233","dJobECdNm":"[8233]주조원","dJobJCd":"7412","dJobJCdNm":"[7412]주조원","dJobICd":"C243","dJobICdNm":"[C243]금속 주조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005385:1', '{"dJobCd":"K000005385","dJobCdSeq":"1","dJobNm":"왁스모형제작반장","workSum":"정밀주조용 왁스(Wax)모형을 성형하기 위하여 사출기를 조작하는 작업원의 활동을 감독·조정한다.","doWork":"왁스(Wax)모형 제작에 필요한 사출기, 금형 및 기타 공구를 점검하고 작업계획에 따라 작업원에게 작업을 지시한다. 작업원을 작업내용과 작업량에 따라 배치하고 함께 작업하며 이행 여부를 확인한다. 완성된 왁스모형의 표면조도를 검사하고 합격 여부를 판정한다. 금형의 청결도를 확인하고 원형금형의 청소를 지시한다. 사용하는 이형제의 종류를 선정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","dJobECd":"8233","dJobECdNm":"[8233]주조원","dJobJCd":"7412","dJobJCdNm":"[7412]주조원","dJobICd":"C243","dJobICdNm":"[C243]금속 주조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004785:1', '{"dJobCd":"K000004785","dJobCdSeq":"1","dJobNm":"왁스모형제작원","workSum":"정밀주조제품을 주조하기 위하여 왁스(Wax)로 모형을 성형하는 기계를 조작한다.","doWork":"왁스를 분사하여 금형에 주입하는 기계장치(Injection Machine) 및 관련 설비의 이상 유무를 확인한다. 왁스를 끓여 액체화한 후 보온통에 저장하여 사출기계에 삽입한다. 사출기를 작동한 후 금형에 주입하여 왁스모형을 제작한다. 제작된 왁스모형의 표면조도를 확인하고 표준표면조도와 비교하여 이상이 없는지 확인한 후 연속작업을 한다. 에어렌치로 제작된 왁스모형을 금형에서 떼어낸다. 금형의 청결도를 확인하고 금형을 청소한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"왁스모델러","connectJob":"왁스모형사출기조작원, 왁스주물원","dJobECd":"8233","dJobECdNm":"[8233]주조원","dJobJCd":"7412","dJobJCdNm":"[7412]주조원","dJobICd":"C243","dJobICdNm":"[C243]금속 주조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005176:1', '{"dJobCd":"K000005176","dJobCdSeq":"1","dJobNm":"왁스모형조립반장","workSum":"제작된 왁스(Wax)모형을 트리 또는 크러스터 모양 등으로 주조하는 작업원의 활동을 감독·조정한다.","doWork":"왁스모형을 조립하기 위하여 필요한 인두 및 기타 공구를 점검하고 작업계획에 따라 작업내용을 작업원에게 지시한다. 작업원을 배치하고 함께 작업하며 작업지시에 대한 이행 여부를 확인한다. 조립된 트리 또는 크러스터 등의 모형을 검사하여 이상 유무를 확인하고 합격판정을 한다. 관찰과 면담을 통하여 작업원의 애로 및 건의사항을 수렴·해결한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","dJobECd":"8233","dJobECdNm":"[8233]주조원","dJobJCd":"7412","dJobJCdNm":"[7412]주조원","dJobICd":"C243","dJobICdNm":"[C243]금속 주조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006678:1', '{"dJobCd":"K000006678","dJobCdSeq":"1","dJobNm":"왁스모형조립원","workSum":"성형된 탕구모형에 왁스(Wax)모형을 붙여 조립한다.","doWork":"작업지시서나 왁스(Wax)모형조립반장의 지시에 따라 작업내용을 확인한다. 인수받은 왁스(wax)모형, 성형된 탕구용 왁스(Wax)모형, 인두 및 조립장비의 이상 유무를 확인한다. 성형된 탕구용 왁스모형에 왁스모형을 대고 일정 온도로 달구어진 인두로 접합하여 트리나 크러스터 모양으로 조립한다. 조립된 왁스(Wax)모형의 배치 및 치수를 표준규격과 일치하는지 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"원형기능사","dJobECd":"8233","dJobECdNm":"[8233]주조원","dJobJCd":"7412","dJobJCdNm":"[7412]주조원","dJobICd":"C243","dJobICdNm":"[C243]금속 주조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003212:1', '{"dJobCd":"K000003212","dJobCdSeq":"1","dJobNm":"인조석몰드제작원","workSum":"원석의 형태로 인조석을 찍어내기 위해 성형과 큐어링(Curing)을 하는 몰드를 제작한다.","doWork":"몰드액을 넣은 몰드 혼합통에 경화제를 투입한 후 전기 스위치를 넣어 가열하고 드릴이나 젓는 도구 등을 이용해 교반을 한다. 교반된 몰드액을 제작이 된 틀에 부어 넣는다. 에어컴프레서를 이용해 기포를 제거한다. 일정 시간 경과 후 완전경화가 되면 발포제를 뿌리고 굳어진 몰드를 원석과 분리한다. 노후하여 닳아진 몰드는 잘게 잘라서 다시 몰드통에 넣어 재활용한다. 원석 성형판을 만들기 위해 나무합판으로 지지대 틀을 제작한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"인조석성형틀제작원","dJobECd":"8233","dJobECdNm":"[8233]주조원","dJobJCd":"7412","dJobJCdNm":"[7412]주조원","dJobICd":"C239","dJobICdNm":"[C239]기타 비금속 광물제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006286:1', '{"dJobCd":"K000006286","dJobCdSeq":"1","dJobNm":"자동조형기조작원","workSum":"대량생산을 위해 금속주조에 사용되는 주형을 자동으로 조형하는 기계를 조작한다.","doWork":"생산계획에 따른 세부지침을 확인하고 주물사 공급장치의 주물사 재고 및 생산제품에 따른 배합량, 자동 주형을 위한 주물금형을 확인한다. 일정 온도로 예열이 된 상태에서 주물틀에 주물사를 투입하여 주형을 성형하고 중자를 주형에 삽입한다. 상부와 하부 주형이 완성되면 합형한다. 주조 후 탈사되는 주물사가 자동으로 수집되어 주물사 공급장치로 이송되도록 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|고온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"컴퓨터응용가공산업기사","dJobECd":"8233","dJobECdNm":"[8233]주조원","dJobJCd":"7412","dJobJCdNm":"[7412]주조원","dJobICd":"C243","dJobICdNm":"[C243]금속 주조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005613:1', '{"dJobCd":"K000005613","dJobCdSeq":"1","dJobNm":"조형반장","workSum":"주조품을 만들기 위해 주형을 만드는 일에 종사하는 인원을 관리·감독한다.","doWork":"조형 및 합형 작업계획을 검토하고 세부 실행계획을 수립하여 작업원에게 지시하고 이행 여부를 확인한다. 완성된 제품이 표준명세와 일치하는지 확인하고 작업상 문제점에 대한 해결방법 및 기술지도를 한다. 문제 발생 시는 적절한 비상조치를 취하고 생산관리자에게 보고하고 관련 부서와 협조하여 신속히 복구한다. 담당 설비 및 환경상태를 예비점검한 후 정기점검을 하고 이상 및 불량개소에 대해서 시정을 지시하고 확인한다. 직무교육 및 안전위생교육에 대한 계획을 수립하고 시행하여 작업원에 대한 직무수행능력을 향상시키고 재해를 예방한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"고온|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","certLic":"원형기능사, 주조기능사, 주조산업기사, 주조기능장","dJobECd":"8233","dJobECdNm":"[8233]주조원","dJobJCd":"7412","dJobJCdNm":"[7412]주조원","dJobICd":"C243","dJobICdNm":"[C243]금속 주조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003088:1', '{"dJobCd":"K000003088","dJobCdSeq":"1","dJobNm":"주물사상원","workSum":"주조된 주물제품을 수동공구로 후처리 가공하여 제품을 완성한다.","doWork":"작업지시서에 따라 가공할 제품의 명세서를 확인·검토한다. 작업에 필요한 장비와 작업공구를 준비한다. 가공품을 작업대 위에 올려놓는다. 작업지시서에 따라 주조 가공품의 불필요한 부분을 체크한다. 절단톱, 연마기, 연삭기, 줄, 사포 등으로 도면상의 주조 제품규격에 맞추어 연마, 절삭, 연삭작업을 한다. 가공된 최종 제품을 작업명세서상의 규격 및 수치와 비교한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8233","dJobECdNm":"[8233]주조원","dJobJCd":"7412","dJobJCdNm":"[7412]주조원","dJobICd":"C243","dJobICdNm":"[C243]금속 주조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006934:1', '{"dJobCd":"K000006934","dJobCdSeq":"1","dJobNm":"주물사제조원","workSum":"모래, 점토, 물, 첨가제 등을 혼합하여 주물사를 만든다.","doWork":"작업지시에 따라 주물사를 배합하기 위한 재료를 준비한다. 주물제품의 특성에 따른 주물사의 배합비율에 따라 준비된 재료를 배합한다. 채를 이용하여 주물사의 이물 제거 및 적정한 크기로 선별하고 신사, 고사, 점결제, 첨가제, 물을 배합비율에 따라 혼합한다. 육안 및 촉감으로 점도를 검사한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"주물사배합원, 주물사처리원","certLic":"주조기능사, 주조산업기사, 주조기능장","dJobECd":"8233","dJobECdNm":"[8233]주조원","dJobJCd":"7412","dJobJCdNm":"[7412]주조원","dJobICd":"C243","dJobICdNm":"[C243]금속 주조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002098:1', '{"dJobCd":"K000002098","dJobCdSeq":"1","dJobNm":"주물주조원","workSum":"주물 주조제품을 생산하기 위해 주형에 용탕을 주입하여 주물을 만든다.","doWork":"작업명세서에 의해 조형작업을 하고 가열된 용탕을 탈황처리 한다. 주형의 종류에 따라 주형속도를 조절하여 주입한다. 주입작업과 동시에 가스배출구에 불을 붙여 가스방출을 돕고 폭발을 방지한다. 주입이 완료된 후 충분한 응고시간이 지난 뒤 수동공구를 사용하여 주형에서 주조물을 분리한다. 제품의 탕구제거와 모래털기 작업이 끝나면 제품별로 선별하여 갈라진 틈, 기포, 주조불량 등의 제품 이상 유무를 검사한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|고온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"주조기능사, 주조산업기사, 주조기능장","dJobECd":"8233","dJobECdNm":"[8233]주조원","dJobJCd":"7412","dJobJCdNm":"[7412]주조원","dJobICd":"C243","dJobICdNm":"[C243]금속 주조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005717:1', '{"dJobCd":"K000005717","dJobCdSeq":"1","dJobNm":"주조물선별원","workSum":"다이캐스팅(Die Casting)법으로 주조된 제품 중 불량품을 선별하고 불량요소를 제거한다.","doWork":"주조된 제품의 이상 유무를 확인한다. 제품의 형태, 표면 상태, 기포 유무 등을 육안으로 관찰하고 이상 제품을 선별하여 각 공정에 재처리를 의뢰하거나 폐기 조치한다. 이상이 없는 제품은 포장을 위한 공정으로 보내며, 같이 포장을 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"관련없음","dJobECd":"8233","dJobECdNm":"[8233]주조원","dJobJCd":"7412","dJobJCdNm":"[7412]주조원","dJobICd":"C243","dJobICdNm":"[C243]금속 주조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003228:1', '{"dJobCd":"K000003228","dJobCdSeq":"1","dJobNm":"주조반장","workSum":"주물주조제품을 만들기 위한 일에 종사하는 작업자들을 관리·감독한다.","doWork":"금속을 용해하고, 용해된 금속을 주형에 붓고, 탈사하여 후처리작업을 하는데 작업원들을 주물제품 생산계획에 따라 공정별로 인원을 배치하고 관리·감독한다. 생산계획에 따른 자재 및 설비의 현황을 파악하고 관리·감독한다. 생산현장의 문제점을 파악하여 조치하며, 기술교육 및 안전교육을 실시하고 생산된 주조제품이 제품시방과 일치하는지 여부를 파악하여 조치한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|고온|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","similarNm":"주조직장","certLic":"주조기능사, 주조산업기사, 주조기능장","dJobECd":"8233","dJobECdNm":"[8233]주조원","dJobJCd":"7412","dJobJCdNm":"[7412]주조원","dJobICd":"C243","dJobICdNm":"[C243]금속 주조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007164:1', '{"dJobCd":"K000007164","dJobCdSeq":"1","dJobNm":"주형제작원(일반)","workSum":"금속제품을 주조하는 데 사용되는 금속주형을 제작한다.","doWork":"주형틀에 원형을 넣고 주위를 고무로 채운다. 주형틀을 경화시키기 위하여 경화기에 넣는다. 경화기 작동스위치를 누르고 일정 시간 경화한다. 경화된 고무를 칼로 절단하고 절단한 공간에 왁스를 주입한다. 일정 시간이 경과 후 왁스모형을 빼낸다. 석고가 든 주조상자를 전기로나 가스로에 넣고 작동스위치를 누른다. 일정 시간이 경과 후, 전기로나 가스로에서 꺼내어 원심분리기에 넣고 기계 작동스위치를 누른다. 작동스위치를 내리고 금속이 굳으면 찬물에 넣는다. 찬물에서 주조물을 꺼내어 세척하기 위하여 약품을 넣는다. 세척한 주조물을 절단한다. 절단한 주조물을 줄·핸드피스 등으로 다듬는다. 다듬질이 끝난 주조물의 표면을 보밍(화학약품을 사용하여 거친 표면을 한 꺼풀 벗기는 작업)처리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|고온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"조형원, 조형기조작원, 사형원, 모래주형원, 합형원, 주형원, 주물틀제작원, 몰딩조형원, 중자조형원, 귀금속주형제작원","certLic":"원형기능사, 주조기능사, 주조산업기사, 주조기능장","dJobECd":"8233","dJobECdNm":"[8233]주조원","dJobJCd":"7412","dJobJCdNm":"[7412]주조원","dJobICd":"C243","dJobICdNm":"[C243]금속 주조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007109:1', '{"dJobCd":"K000007109","dJobCdSeq":"1","dJobNm":"중자제조기조작원","workSum":"조형작업을 하는데 사용되는 중자(中子)를 만드는 기계를 조작한다.","doWork":"중자금형의 가열기 스위치를 조작하여 금형을 일정 온도로 가열한다. 가열된 중자금형을 기계램(Ram) 아래에 있는 하부베드 위에 올려놓는다. 스위치를 조작하여 램이 하강하는 동시에 공기밸브의 조절로 상부에 있는 저장통에 있는 모래가 금형 속으로 들어가게 한다. 램을 상승시키고 금형이 연속작업을 하도록 자동스위치를 조정한다. 제조된 중자를 빼내서 육안검사를 하고 작업대 위에 놓는다. 경화되지 않은 모래와 불순물을 공기호스로 제거한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|고온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"코어제조기조작원","certLic":"주조기능사, 주조산업기사, 주조기능장","dJobECd":"8233","dJobECdNm":"[8233]주조원","dJobJCd":"7412","dJobJCdNm":"[7412]주조원","dJobICd":"C243","dJobICdNm":"[C243]금속 주조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003490:1', '{"dJobCd":"K000003490","dJobCdSeq":"1","dJobNm":"중자제조반장","workSum":"주물(鑄物)의 중공부(中空部)를 만들기 위한 중자(中子)를 제조하는데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"생산계획에 따라 세부적인 생산계획을 수립하여 각 작업원에게 전달한다. 같이 작업하며 이행 여부를 확인한다. 중자를 제조하는 설비와 원자재, 공구들을 관리, 점검하며, 생산되는 중자의 품질을 관리한다. 작업장과 작업자의 안전관리를 하며 직무기술을 교육한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|고온|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"코어제조반장","certLic":"주조기능사, 주조산업기사, 주조기능장","dJobECd":"8233","dJobECdNm":"[8233]주조원","dJobJCd":"7412","dJobJCdNm":"[7412]주조원","dJobICd":"C243","dJobICdNm":"[C243]금속 주조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002301:1', '{"dJobCd":"K000002301","dJobCdSeq":"1","dJobNm":"중자제조원","workSum":"주물제품(鑄物製品)의 중공부(中空部)를 만들기 위한 중자(中子)를 제조한다.","doWork":"중자모형을 조립하고 중자틀에 중자모래를 넣어 에어램으로 다진다. 부력에 의해 주조사가 깨지거나 변형되지 않도록 중자의 경도와 평창 등을 고려하여 철심이나 냉심을 넣는다. 이산화탄소 가스를 주입하여 경화한다. 중자틀을 분리하여 완성된 중자를 분리한다. 중자의 흠이 난 부분을 메우고 흙칼을 사용하여 표면을 다듬는다. 경우에 따라 중자를 가열하여경화시키기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"코어제조원","certLic":"주조기능사, 주조산업기사, 주조기능장","dJobECd":"8233","dJobECdNm":"[8233]주조원","dJobJCd":"7412","dJobJCdNm":"[7412]주조원","dJobICd":"C243","dJobICdNm":"[C243]금속 주조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006381:1', '{"dJobCd":"K000006381","dJobCdSeq":"1","dJobNm":"탈사원","workSum":"금속주물(金屬鑄物)의 표면에 부착된 주물사, 피막, 불순물 등을 제거한다.","doWork":"손 또는 기중기를 사용하여 주물을 작업대 위에 올려놓는다. 주물 표면의 부착된 주물사 등 불순물을 착암기, 용제 등을 사용하여 깨끗이 제거한다. 제거되지 않은 불순물은 산소나 프로판가스를 이용하여 가열한 후 망치나 수공구 및 공기해머로 제거한다. 주물의 표면을 육안 및 게이지로 검사하고 절단할 부위나 제거되지 않은 불순물을 제거하기 위하여 톱날절단원이나 쇼트원에게 보낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"주조기능사, 주조산업기사, 주조기능장","dJobECd":"8233","dJobECdNm":"[8233]주조원","dJobJCd":"7412","dJobJCdNm":"[7412]주조원","dJobICd":"C243","dJobICdNm":"[C243]금속 주조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004831:1', '{"dJobCd":"K000004831","dJobCdSeq":"1","dJobNm":"탈왁스원","workSum":"주형을 만들기 위하여 제작된, 내화물이 피복된 왁스모형에서 왁스를 제거한다.","doWork":"작업지시서나 반장의 지시에 따라 작업내용을 확인하고 탈왁스를 위한 보일러 등의 설비를 점검한다. 탈왁스 처리할 제품의 상태를 점검한다. 탈왁스 처리 방법이나 지침서에 따라 작업절차를 선택하여 가열된 용액을 붓거나 용제를 사용하여 왁스를 제거한다. 왁스가 제거된 왁스모형의 상태 등을 확인하고 주조공정으로 보낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|고온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"로스트왁스원","certLic":"주조기능사, 주조산업기사, 주조기능장","dJobECd":"8233","dJobECdNm":"[8233]주조원","dJobJCd":"7412","dJobJCdNm":"[7412]주조원","dJobICd":"C243","dJobICdNm":"[C243]금속 주조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004436:1', '{"dJobCd":"K000004436","dJobCdSeq":"1","dJobNm":"합형원","workSum":"용탕을 주입할 수 있도록 분리된 상·하 주형과 중자를 도면에 따라 결합한다.","doWork":"주조작업 계획의 세부 작업지시서나 합형반장의 작업지시에 따라 작업내용을 확인하고 각종 설비 및 공구를 점검하고 준비한다. 합형 작업지침에 따라 합형 방법 및 절차 등을 검토·확인한다. 하형주형상자를 수평이 되게 작업장에 장치한다. 상·하주형 내부의 불순물을 공기총을 이용하여 청소하고, 열을 가하여 상·하주형 및 중자를 건조한다. 중자의 표면에 붓을 사용하여 도형재를 바르고 정확하게 설치한다. 주형의 크기, 중자의 위치와 도면이 일치하는가를 확인하고 상형의 입탕부위, 주입구 주위 등을 흙손·칼 등의 수공구를 이용하여 매끄럽게 한다. 상형주형상자와 하형주형상자의 중심점이 맞도록 결합한다. 작업이 완료되면 주형을 제거하고 주물에 묻은 모래를 제거하는 탈사작업을 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"주형손질원","certLic":"주조기능사, 주조산업기사, 주조기능장","dJobECd":"8233","dJobECdNm":"[8233]주조원","dJobJCd":"7412","dJobJCdNm":"[7412]주조원","dJobICd":"C243","dJobICdNm":"[C243]금속 주조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003462:1', '{"dJobCd":"K000003462","dJobCdSeq":"1","dJobNm":"단조반장","workSum":"단조작업과 작업 공정 직원의 직무를 분장하고 조정한다.","doWork":"주문서에 따라 단조할 제품을 확인한다. 공정계획을 수립하고 각종 공구를 점검하고 확인한다. 공정별 계획에 따라 작업원을 배치하고 작업지시를 한다. 각 공정을 확인하며 부분품을 확인하고 개선사항을 지시한다. 완성된 제품의 규격을 점검하고 작업지시서와 일치하는지를 확인한다. 작업원에게 기술적인 지도를 하며 작업장의 안전을 관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"조정","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"단조공정관리자","connectJob":"단조공정반장","dJobECd":"8231","dJobECdNm":"[8231]단조원","dJobJCd":"7413","dJobJCdNm":"[7413]단조원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003574:1', '{"dJobCd":"K000003574","dJobCdSeq":"1","dJobNm":"단조원","workSum":"금속재질을 일정 온도로 가열하고 두들기거나 가압하여 성형한다.","doWork":"작업지시서에 따라 단조할 제품을 확인한다. 가공할 제품의 종류와 형태에 따라 스웨이지블럭, 정반, 세트해머, 메(Sledge), 집게(Tong), 탭(Tap) 등의 공구를 준비한다. 도면 및 작업표준서에 명시된 중요 품질특성을 준수하고 초, 중, 종물 공정검사를 한다. 실대장용 괴철로나 가열로에서 금속재료를 가열한다. 보호장구를 착용하고 재료를 모루의 모양과 크기대로 망치질하거나 또는 스프링해머·벨트해머·증기해머 등 동력망치의 모루 위에 재료를 올려놓고 페달을 밟아 가공한다. 금속부품을 함께 가열하고 망치질하여 모재와 단조한다. 단조한 부품들을 열처리한다. 가스절단기를 사용하여 철부품을 자르고 붙이는 일을 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"대장원, 대장장이, 단조기조작원","connectJob":"수동단조원, 프레스단조원, 열간단조원, 햄머단조원, 소성단조원, 냉간단조원, 단조프레스기조작원, 단조압연기조작원, 열간단조프레스기조작원","dJobECd":"8231","dJobECdNm":"[8231]단조원","dJobJCd":"7413","dJobJCdNm":"[7413]단조원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005732:1', '{"dJobCd":"K000005732","dJobCdSeq":"1","dJobNm":"매니플레이트운전원","workSum":"매니플레이터(가열된 금속재료를 집게로 고정하여 이동·운반하는 기구)를 운전한다.","doWork":"매니플레이터의 주유 상태를 확인하는 등 시험작동을 한다. 단조작업을 위한 준비를 한다. 전기로에서 가열된 금속재료를 단조기계로 옮기기 위해 원격조정기(리모컨)나 레버를 조작하여 금속재료를 잡는다. 정확한 위치로 이동하기 위해 단조기 조작원의 신호와 지시에 따라 집게로 잡은 가열된 금속재료를 전후좌우로 이동한다. 단조원의 단조작업이 완료되면 성형이 된 제품을 다시 잡은 후에 적재장에 안전하게 운반한다. 작업이 완료되면 기계를 점검한다. 정비작업을 수시로 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|손사용|","workEnv":"위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"호이스트운전원","connectJob":"매니플레이트조작원","dJobECd":"8231","dJobECdNm":"[8231]단조원","dJobJCd":"7413","dJobJCdNm":"[7413]단조원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005880:1', '{"dJobCd":"K000005880","dJobCdSeq":"1","dJobNm":"금속제관공","workSum":"금속구조물과 같은 금속제품을 제조하기 위하여 철판 등의 금속소재를 절단·가공·용접·조립하여 명세된 형태로 만든다.","doWork":"도면을 검토하여 제관할 형태를 확인하고 작업 방법 및 순서를 숙지한다. 제관에 필요한 철골·강판 등의 금속소재와 공구·장비 등을 준비한다. 현도·마킹된 금속소재를 절단기·벤딩기·프레스 등의 장비를 사용하여 절단하거나 구부리고 가공한다. 용접이나 볼트·너트로 각 부분품을 가조립하여 제품의 형태가 명세서와 일치하면 완전히 용접·조립한다. 그라인더나 끌을 이용하여 용접부위를 다듬는다. 제관된 제품을 확인하여 도면과 비교한다. 도면에 따라 현도하고 마킹하는 일을 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|","workEnv":"소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"제관조립원, 금속제관원, 제관기조작원, 제관기능원","connectJob":"제관현도원, 제관용접원, 제관사상원, 제관마킹원, 제관취부원, 탱크제관원, 파이프제관원, 보일러파이프제관원, 물탱크제관원, 제관화염절단원, 벌징기조작원","certLic":"판금제관기능사, 판금제관산업기사, 판금제관기능장","dJobECd":"8223","dJobECdNm":"[8223]제관원","dJobJCd":"7421","dJobJCdNm":"[7421]제관원","dJobICd":"F422","dJobICdNm":"[F422]건물설비 설치 공사업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006259:1', '{"dJobCd":"K000006259","dJobCdSeq":"1","dJobNm":"설비제관공","workSum":"압력용기나 저장탱크 등의 베슬(Vessel)류와 크레인, 교량, 건축철골, 차량, 선박 등의 설비류 등을 제작하기 위해 강판, 형강, 철골 등을 설계도면에 따라 제작한다.","doWork":"제관에 필요한 철판, 강판 등의 금속소재와 작업에 필요한 장비 그리고 안전도구를 준비한다. 도면 및 작업지시서에 따라 가공할 제품의 명세서를 확인·검토한다. 제관작업 지시서를 검토하여 제관형태를 확인하고 작업방법 및 순서를 결정한다. 마킹된 금속소재를 절단기, 벤딩기, 프레스기 등의 기계장비를 이용하여 절단하거나 구부리고 가공한다. 용접이나 볼트 및 너트로 각 부분품을 가조립하여 제품의 형태가 명세서와 일치하면 완전히 용접 및 조립한다. 그라인더 및 끌로 용접부위를 다듬는다. 제관된 제품을 확인하여 도면과 비교한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"설비제관원","connectJob":"플랜트제관공, 엘리베이터제관공","certLic":"판금제관기능사, 판금제관산업기사, 판금제관기능장","dJobECd":"8223","dJobECdNm":"[8223]제관원","dJobJCd":"7421","dJobJCdNm":"[7421]제관원","dJobICd":"C291","dJobICdNm":"[C291]일반 목적용 기계 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003069:1', '{"dJobCd":"K000003069","dJobCdSeq":"1","dJobNm":"송풍기제관공","workSum":"송풍기의 각종 부품을 도면의 형태로 만들기 위하여 금속재료를 절단, 용접, 쇼트, 기계 가공을 수행한다.","doWork":"송풍기제조반장의 지시에 따라 도면과 작업지시서를 검토하고 작업의 내용을 파악한다. 작업에 필요한 장비와 각종 공구를 준비한다. 작업할 금속재료의 수량 및 변형 상태 등을 파악한다. 도면에 따라 현도작업을 하고 마킹한다. 정해진 규격에 따라 소재를 케이싱으로 만들기 위해 절단하고 케이싱을 사이즈별로 절단하여 드릴 작업을 한다. 절단작업이 완료된 소재를 용접하고 쇼트하는 작업을 한다. 송풍기도장원에게 하도도장을 시킨 후 보링머신 등을 이용하여 기계 가공을 한다. 임펠러, 모터와의 조립을 위해 조립반으로 이동한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"송풍기제관원","certLic":"판금제관기능사, 판금제관산업기사, 판금제관기능장","dJobECd":"8223","dJobECdNm":"[8223]제관원","dJobJCd":"7421","dJobJCdNm":"[7421]제관원","dJobICd":"C291","dJobICdNm":"[C291]일반 목적용 기계 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006648:1', '{"dJobCd":"K000006648","dJobCdSeq":"1","dJobNm":"수압시험원","workSum":"금속관에 일정 압력을 가하여 용접부 또는 모재부의 파열이나 누수 여부를 파악하는 수압시험기를 조작한다.","doWork":"시험할 관의 위치를 수압시험기의 물 투입구의 중앙에 맞춘다. 제어판을 조작하여 양쪽의 고무판을 이송시켜 관을 밀폐시킨 뒤 반대쪽 벨브를 열어 관 내부의 공기가 배출되도록 한다. 저압모터를 사양하여 관 내부에 물을 채워 내부 공기를 배출시킨 뒤 반대쪽 밸브를 닫아 밀폐한 뒤 고압모터를 작동하여 수압을 올리며 측정압력까지 수압이 도달하면 모터를 정지한다. 관 용접부와 모재의 누수 여부를 확인하여 불량 여부를 판단한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"수압","connectJob":"강관수압시험원, 주철관수압시험원","dJobECd":"8223","dJobECdNm":"[8223]제관원","dJobJCd":"7421","dJobJCdNm":"[7421]제관원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006646:1', '{"dJobCd":"K000006646","dJobCdSeq":"1","dJobNm":"연소기구조립원","workSum":"산업용 또는 가정용 보일러와 연소기구 제조를 위해 재단, 성형, 용접, 조립을 수행한다.","doWork":"작업지시서에 따라 도구 및 공구를 준비한다. 작업시방서대로 압연강판을 전단한다. 절단한 판관을 벤딩기 등으로 성형한다. 절단된 판관에 홀가공을 한다. 전기배선장치 등을 조립한다. 볼트 및 나사를 조립하여 완성하고 도장처리 등의 표면처리를 한다. 명판 등을 부착한다. 시험검사와 시운전을 통해 이상 유무 등 결함 여부를 확인한다. 완제품을 적재한다. 다음 작업준비를 위하여 공구를 정리하고 주변을 정리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"버너조립원, 보일러조립원","certLic":"판금제관기능사, 판금제관기능장, 판금제관산업기사","dJobECd":"8223","dJobECdNm":"[8223]제관원","dJobJCd":"7421","dJobJCdNm":"[7421]제관원","dJobICd":"C251","dJobICdNm":"[C251]구조용 금속제품, 탱크 및 증기발생기 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002290:1', '{"dJobCd":"K000002290","dJobCdSeq":"1","dJobNm":"조관원","workSum":"작업지시서 및 도면에 따라 조관기계를 작동하여 주름관을 가공한다.","doWork":"작업지시서에 따라 조관할 제품을 확인한다. 조관소재의 종류·형태 등에 따라 조관방법 및 절차를 결정한다. 조관기의 유압, 윤활상태 등을 점검하고 시험가동 한다. 철판을 호이스트 및 지게차로 운반하여 코일다이에 고정한다. 작업지시서 및 도면에 따라 파이프의 절단길이 및 주름의 간격을 결정한 후 계기에 입력한다. 성형기에 철판롤을 투입하여 전원의 스위치를 오픈한다. 작업명세서에 따라 가공수치 및 데이터를 디지털계기에 입력한다. 일정 길이로 성형된 주름관을 절단하여 성형 상태를 확인한다. 불량 유무와 외경 및 내경의 오차를 버니어캘리퍼스로 측정한다. 규격과 다를 시 작업표준에 맞도록 교정한다. 완성된 제품은 출하를 위하여 지게차로 운반하여 적재한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"판금제관기능사, 판금제관산업기사, 판금제관기능장","dJobECd":"8223","dJobECdNm":"[8223]제관원","dJobJCd":"7421","dJobJCdNm":"[7421]제관원","dJobICd":"C291","dJobICdNm":"[C291]일반 목적용 기계 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005705:1', '{"dJobCd":"K000005705","dJobCdSeq":"1","dJobNm":"확관기조작원","workSum":"제관된 강관의 관단을 소켓 또는 나팔관 형태로 확대 가공하기 위하여 확관기를 조작한다.","doWork":"강관의 규격에 따라 확관기 헤드에 조립된 다이스를 교체한다. 작업할 관의 길이에 맞도록 받침대의 간격을 조정한다. 받침롤의 높이를 관 외경에 맞도록 상승한계 스위치를 조정한다. 천장기중기를 이용하여 관을 확관기에 올려놓고 확관하여 규정된 지름이 되도록 확관지름한계 스위치를 조정한다. 관을 확관 추입용 테일에 내면 용접돌출부를 확관 다이스 방향에 맞추어 정렬한다. 관을 굴려 확관기에 투입하고 자동확관 버튼을 눌러 확관 작업을 실시한다. 작업이 완료되면 확관된 양 끝 지름을 줄자나 자 등을 이용하여 측정하고 작업표준과 일치하는지 비교한다. 작업내용을 일지에 기록한다. 관을 천장기중기로 다음 공정으로 이송한다. 강관의 확관부위, 용접부위에 드릴로 구멍을 뚫고 탭으로 나사를 낸 다음 준비된 플러그를 조립하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"확관기조작원","certLic":"판금제관기능사, 판금제관산업기사, 판금제관기능장","dJobECd":"8223","dJobECdNm":"[8223]제관원","dJobJCd":"7421","dJobJCdNm":"[7421]제관원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006447:1', '{"dJobCd":"K000006447","dJobCdSeq":"1","dJobNm":"차체판금원","workSum":"자동차 조립용 판금부품을 제작하거나 교정하기 위하여 판금작업을 한다.","doWork":"도면에 따라 철판에 전개도를 그리고 절단한다. 용접기로 가열하면서 판금해머로 철판을 두드려 형상을 성형한다. 성형된 부품의 표면을 디스크 그라인더, 줄, 판금해머 등으로 다듬질하여 끝내기 작업을 한다. 성형된 판금부품을 지그에 고정시키고 용접 또는 판금하고 그라인딩 하여 제품을 완성한다. 차체조립공정에서 판금하는 경우에는 차체 내외부의 요철, 단차, 간격, 변형, 들뜸, 응력 등에 의해 발생한 외관불량 판금을 육안 및 촉감으로 확인하면서 판금해머 등으로 평활하게 수정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"체체판금작업원","connectJob":"판금사상원","certLic":"판금제관기능사, 판금제관산업기사","dJobECd":"8221","dJobECdNm":"[8221]판금원","dJobJCd":"7422","dJobJCdNm":"[7422]판금원","dJobICd":"C301","dJobICdNm":"[C301]자동차용 엔진 및 자동차 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006225:1', '{"dJobCd":"K000006225","dJobCdSeq":"1","dJobNm":"가스용접원","workSum":"작업지시서와 설계도서에 따라 가스용접장비를 사용하여 금속 부재를 접합하거나 절단한다.","doWork":"설계도면을 확인하고 작업계획을 세운다. 용접에 필요한 재료와 공구를 준비하고 모재와 용접봉 표면에 기름, 녹, 먼지 등을 깨끗이 제거한다. “모재의 재질과 두께” 등에 따라 토치팁(Torch Tip), 용가재(용접작업을 할 때 부가되는 금속재료), 용제(Flux:불순물 제거와 산화 방지를 위해 사용되는 화학물) 등을 결정한다. 받침대, 고정구, 지그(Jig)에 용접할 재료를 고정한다. “산소실린더 및 가스 실린더에 압력조정기를 설치하고 가스호스와 토치를 연결한 후” 비눗물로 새는 곳이 있는지 검사한다. “토치 밸브를 열어” 불을 붙이고 재료의 종류나 “두께에” 따라 토치의 불꽃을 조절한다. “불꽃을 모재의 접합할 위치에 접근시켜 가열하여 용융시키며 동시에 용접봉도 용융시켜” 가용접한 후 “접합할 부분을 접합하기에” 적절한 온도로 “가열하여 접합부와 용가재를” 용융(녹여서 섞음)시켜 용접한다. 용접작업이 끝나면 “토치의 밸브를 잠그어” 불꽃을 끄고, 용접부위를 와이어브러시로 청소한다. 용접비드폭(넓이)과 용접결합상태를 검사한다. 도면에 따라 치수를 측정하고, 용접부위의 변형을 바로 잡는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"가스용접공, 가스용접기조작원","connectJob":"LPG가스용접원, 프로판가스용접원, 산소아세틸렌용접원, 공기아세틸렌용접원, 산소수소용접원, 산소용접원, 산소절단원","certLic":"용접기능사, 용접산업기사, 용접기능장, 이산화탄소아크용접기능사, TIG용접기능사","dJobECd":"8241","dJobECdNm":"[8241]용접원","dJobJCd":"7430","dJobJCdNm":"[7430]용접원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004768:1', '{"dJobCd":"K000004768","dJobCdSeq":"1","dJobNm":"납땜원","workSum":"인두와 각종 납을 사용하여 금속 및 금속제품의 부품을 결합한다.","doWork":"납땜공구와 재료를 준비한다. 공작물과 납땜인두를 화학용액에 담그거나 와이어브러시와 사포로 녹·도료·기름 등의 불순물을 제거한다. 공작물을 고정구에 놓거나 작업대의 지정된 위치에 올려놓는다. 납땜인두를 가열하고 납땜할 접합부를 밀착한다. 납땜부위 전체를 고르게 가열한다. 나무 또는 철사 등으로 용제를 찍어 접합부에 바른다. 가열된 납땜인두를 접속부분에 대고 접합선을 따라 인두와 납을 움직인다. 납땜작업이 완료되면 땜납이 완전히 굳었는가를 확인하고 납땜부위를 깨끗이 닦아낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"경납접원, 연납접원","dJobECd":"8241","dJobECdNm":"[8241]용접원","dJobJCd":"7430","dJobJCdNm":"[7430]용접원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001554:1', '{"dJobCd":"K000001554","dJobCdSeq":"1","dJobNm":"레이저용접원","workSum":"작업지시서와 설계도서에 따라 레이저용접 장비를 사용하여 금속재를 접합한다.","doWork":"설계도면을 확인하고 작업계획을 세운다. 레이저용접에 필요한 장비와 공구 및 재료를 준비하고 모재와 용접봉 표면에 기름, 녹, 먼지 등을 깨끗이 제거한다. 레이저 용접작업의 안전사항을 숙지한다. 레이저용접장비의 구성과 명칭 및 취급방법에 대하여 숙지한다. 레이저용접장비를 설치하고 냉각장치를 점검한다. 레이저용접기의 사용설명서를 숙지하고 제어판을 조작하여 용접조건(레이저 출력, 용접 부하율, 주파수, 진동기, 진동 폭, 좌·우 촛점, 레이저 용접 시작 on/off, 연속/스폿용접 등)을 설정한다. 용접재료의 재질과 두께 및 이음의 형상 등에 따라 건(gun)과 팁(tip) 등을 결정하여 설치한다. 받침대, 고정구, 지그(Jig)에 용접할 재료를 고정한다. 알곤실린더와 유량계 및 호스를 연결하고 연결부에서 가스 누설 여부를 비눗물로 검사한다. 유량 조절밸브를 열어 용접조건에 따라 유량을 조절한다. 보호구를 착용하고 도면의 형상과 치수로 부품을 가용접한 후 확인 및 교정한 후 용접한다. 용접작업이 끝나면 가스를 잠그고 용접기의 스위치를 끈 후 비드의 폭과 높이, 기타 용접결합상태를 검사한다. 도면에 따라 치수를 측정하고, 용접부위의 변형을 바로 잡는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"레이저 용접공","certLic":"용접산업기사, 용접기능장, 판금제관기능사, 판금제관산업기사, 판금제관기능장","dJobECd":"8241","dJobECdNm":"[8241]용접원","dJobJCd":"7430","dJobJCdNm":"[7430]용접원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001231:1', '{"dJobCd":"K000001231","dJobCdSeq":"1","dJobNm":"레이저절단원","workSum":"작업지시서와 설계도서에 따라 레이저 절단 장비를 사용하여 금속재를 절단한다.","doWork":"설계도면을 확인하고 작업계획을 세운다. 레이저 절단에 필요한 장비와 공구 및 재료를 준비하고 절단재의 표면에 기름, 녹, 먼지 등을 깨끗이 제거한다. 레이저 절단작업의 안전사항을 숙지한다. 레이저 절단장비의 구성과 명칭 및 취급방법에 대하여 숙지한다. 작동가스의 종류별 특징과 액화가스를 안전하게 취급하는 방법을 숙지하고 재질에 따라 적합한 가스를 선택 및 설치한다. 레이저 절단장비의 사용설명서를 숙지하고 절단장비를 설치하여 냉각장치를 점검한다. 피 절단재의 재질과 두께에 알맞은 노즐을 선택하여 설치한다. 제어판을 조작하여 절단조건(레이저 출력의 세기, 절단재와 팁 간의 거리, 절단속도 및 순서 등)을 설정한다. 설계된 도면 파일을 입력한다. 절단재료의 재질과 두께 형상 등에 따라 절단대 위에 피 절단재를 고정한다. 가스를 연결하고 연결부에서 가스 누설 여부를 비눗물로 검사한다. 절단 조건에 따라 가스압력을 조절한다. 환기장치를 구동시킨다. 보호구를 착용하고 작동 스위치를 눌러 절단작업을 시작한다. 절단작업이 끝나면 절단물의 형상과 치수를 확인한다. 절단 작업이 끝나면 가스를 잠근 후 절단장비의 스위치를 끄고 정리 정돈한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"레이저 절단공","certLic":"용접산업기사, 용접기능장, 판금제관기능사, 판금제관산업기사, 판금제관기능장","dJobECd":"8241","dJobECdNm":"[8241]용접원","dJobJCd":"7430","dJobJCdNm":"[7430]용접원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006676:1', '{"dJobCd":"K000006676","dJobCdSeq":"1","dJobNm":"불활성가스텅스텐아크용접원","workSum":"불활성가스텅스텐아크용접기를 사용하여 청간재료, 스테인레스강 또는 알루미늄합금을 용접한다.","doWork":"도면, 작업지시서, 용접절차사양서 등을 확인한다. 용접할 모재의 표면에 스케일, 녹, 기름 및 기타 유해한 물질을 제거하여 깨끗하게 준비한다. 아르곤용접기의 상태를 확인하고 작동상태를 점검한다. 모재의 재질과 두께 및 이음부의 형상에 따라 직류 또는 교류전류를 선택하고, 펄스의 유무와 슬로프 및 크레이터전류 등에 관한 세팅을 한다. 용접장갑과 헬멧 등의 안전보호구를 착용하고, 용접작업을 한다. 비드의 폭은 알맞은 크기로 균일하게 하며, 높이는 모재의 표면보다 약간 높게 쌓는다. 용접이 끝나면 비드상태를 검사한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"알곤용접원, 알곤용접기능원, TIG용접기능원","connectJob":"자동아르곤용접기조작원, 티그(TIG)용접원","certLic":"용접기능사, 용접산업기사, 용접기능장, 가스텅스텐아크용접기능사, 이산화탄소가스아크용접기능사, TIG용접기능사","dJobECd":"8241","dJobECdNm":"[8241]용접원","dJobJCd":"7430","dJobJCdNm":"[7430]용접원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003024:1', '{"dJobCd":"K000003024","dJobCdSeq":"1","dJobNm":"선박용접원","workSum":"선박 및 해양구조물의 건조를 위하여 선각공정, PE(Pre-erection), 의장공정 등에서 각종 철 구조물을 용접하여 접합한다.","doWork":"선각공장(船殼工場:강재가공, 철 구조물, 블록조립 등), PE(Pre-erection:선대나 독 근처에서 기중기에 의해 탑재될 수 있는 블록을 만드는 장소), 의장공사(艤裝, outfit)에서 각종 철 구조물을 용접한다. 작업지시서, 도면(용접기호)을 숙지하고 용접기, 용접재료, 개인공구를 준비한다. 안전장구를 착용한다. 작업장소로 용접기를 이동하고 용접기케이블을 설치한다. 작업 위치에 따라 고소차에 탑승하거나 비계를 사용하기도 한다. 용접할 부분을 확인하고 이물질을 제거한다. 각종 용접 기법을 사용하여 용접한다. 용접 비드상태(Weld Bead:용접에 의하여 만들어진 용착 금속)를 확인한다. 용접 시 발생하는 응력(Welding Stress:금속이 냉각하여 수축할 때 생기는 잔류응력)에 따른 변형상태를 확인한다. 작업이 종료되면 용접기와 케이블을 정돈하고 작업장을 청소하여 안전사고를 예방한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"힘든 작업","workPlace":"실외","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"용접사","certLic":"용접기능사, 용접산업기사, 용접기능장, 가스텅스텐아크용접기능사, 이산화탄소가스아크용접기능사","dJobECd":"8241","dJobECdNm":"[8241]용접원","dJobJCd":"7430","dJobJCdNm":"[7430]용접원","dJobICd":"C311","dJobICdNm":"[C311]선박 및 보트 건조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003059:1', '{"dJobCd":"K000003059","dJobCdSeq":"1","dJobNm":"스폿용접원","workSum":"스폿 용접기의 전기 저항열을 이용하여 겹쳐진 절곡 모재에 점 접합을 한다.","doWork":"모재(피용접물)의 두께와 재질 등에 따라 전류의 세기, 가압력 및 통전시간 등 용접 조건을 세팅한다. 작업지시서나 도면에 따라 모재를 접합할 형태로 고정하여 용접할 부분이 전극봉에 일치되도록 맞추고 발로 풋 스위치를 밟아, 용접기 상단팁이 용접하고자 하는 모재의 정확한 지점에 닿을 수 있도록 조절하여 스폿용접을 진행한다. 용접이 제대로 되었는지 육안으로 검사한다. 용접 부위를 필요시 연마하여 표면을 깨끗하게 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"용접기능사, 용접산업기사, 용접기능장, 이산화탄소아크용접기능사, TIG용접기능사","dJobECd":"8241","dJobECdNm":"[8241]용접원","dJobJCd":"7430","dJobJCdNm":"[7430]용접원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002393:1', '{"dJobCd":"K000002393","dJobCdSeq":"1","dJobNm":"아크용접원","workSum":"전기아크용접 장비를 사용하여 작업지시서 설계도면, 용접절차 사양서에 따라 자동차, 선박, 항공기, 산업기계, 전기장치, 보일러 등의 금속제품이나 구성부품들을 용접한다.","doWork":"작업지시서에 따라 용접방법 및 절차를 검토하고 용접기를 선택하여 설치와 점검 및 조작하여 용접작업 조건에 알맞게 전류를 세팅한다. 용접봉을 선택하여 건조시키고, 공구 등을 준비한다. 보호구를 착용한다. 모재를 가공하고 도면의 형태대로 설치 고정하여 가접(가용접)한다. 슬래그를 제거하고 변형을 교정한다. 용융지의 크기와 형태가 알맞고 균일하게 본 용접을 실시한다. 슬래그와 스패터를 제거하고 용접부를 청소한 후 용접부를 검사한다. 용접결함을 보수용접한다. 핸드그라인더를 사용하여 다듬질 연삭한다. 작업이 끝나면 용접기의 스위치를 끄고 정리 정돈한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"전기아크용접원","connectJob":"교류아크용접원, 직류아크용접원, 스터드용접원, 피복아크용접원, 가우징원, 전기용접원, 피복아크용접원","certLic":"이산화탄소아크용접기능사. TIG용접기능사, 용접기능사, 용접산업기사, 용접기능장","dJobECd":"8241","dJobECdNm":"[8241]용접원","dJobJCd":"7430","dJobJCdNm":"[7430]용접원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003947:1', '{"dJobCd":"K000003947","dJobCdSeq":"1","dJobNm":"용접반장","workSum":"용접시공기준, 관리요령을 응용하여 금속제품이나 부품을 용접하고 절단하는 작업원의 활동을 감독·조정한다.","doWork":"작업지시서와 설계도서를 분석하여 용접기기 및 용접장비, 용접방법, 용접재, 용접절차 등을 결정한다. 용접할 제품의 종류와 형태에 따라 용접부의 강도계산 및 설계, 용접기술 및 안전관리, 용접규격 등을 적용하여 용접계획을 수립한다. 작업원에게 안전교육 및 제반 기술교육을 실시한다. 용접에 필요한 용접봉, 가스, 용액, 고정구 등의 물품을 청구한다. 용접장비 조작법을 작업원에게 훈련시키고 용접작업을 감독·조정한다. 장비를 점검하고 일일작업량을 작업일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","certLic":"용접기능사, 용접산업기사, 용접기능장","dJobECd":"8241","dJobECdNm":"[8241]용접원","dJobJCd":"7430","dJobJCdNm":"[7430]용접원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006525:1', '{"dJobCd":"K000006525","dJobCdSeq":"1","dJobNm":"용접원(일반)","workSum":"용접과 절단기술, 자재, 장비, 제반 요건 등에 관한 지식을 적용하여 각종 금속자재 및 부품을 용접하기 위하여 용접기를 조작한다.","doWork":"작업지시서에 따라 용접기, 용접봉, 공구 등을 준비하고 작업절차 및 방법을 검토한다. 용접기를 점검하고 용접작업에 필요한 소요자재를 파악·수령한다. 용접할 부분을 청소하고 용접봉을 충분히 건조한 후 용접 위치와 모재에 따라 전류 및 가스의 압력을 조정한다. 용접부에 생기는 결함과 원인을 판별하며 금속재료의 재질을 고려하여 용접봉의 종류를 선정하고 판 두께에 따라 홈을 결정하고 용접한다. 모재를 미리 예열한 후 용접에 임하고 용접이 끝났을 때에는 슬래그(Slag)를 제거하고 와이어브러시(Wire Brush)로 손질한다. 용접기의 토치(Torch)를 선별하고 전류 및 가스압력을 조절하여 모재를 절단하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"용접기조작원, 용접원","connectJob":"가스용접원, 이산화탄소용접원, 아크용접원, 아르곤용접원, 특수용접원(티그, 미그, 테르밋용접원)","certLic":"용접기능장, 용접산업기사, 용접기능사, 이산화탄소아크용접 기능사, TIG용접기능사","dJobECd":"8241","dJobECdNm":"[8241]용접원","dJobJCd":"7430","dJobJCdNm":"[7430]용접원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005679:1', '{"dJobCd":"K000005679","dJobCdSeq":"1","dJobNm":"용접절단원","workSum":"절단장비와 용접기를 조작하여 금속재료를 절단가공 및 용접작업을 실시하고, 작업물을 다듬질한다.","doWork":"손 또는 기중기를 사용하여 작업물을 받침대 위에 올려놓는다. 가스용기에 압력조정기, 역화방지기, 호스 및 절단토치를 차례로 연결하고 점검하여 연결부에서 가스가 누설되지 않도록 조치한다. 헬멧, 보안경, 장갑 등의 안전보호구를 착용한다, 절단할 모재의 재질과 두께에 따라 압력 조정기를 알맞게 조정한다. 절단 토치의 가연성 가스 밸브를 알맞게 열어 점화하고 산소 밸브를 열어 불꽃을 조정한다. 절단할 부분에 가까이 접근시켜 예열한 상태에서 토치의 고압산소를 밸브를 열어 절단이 시작되면 절단할 선을 따라 천천히 알맞은 속도로 이동하여 절단 작업을 시행한다. 절단 작업이 끝나면 토치 밸브를 닫아 불을 끄고 용기의 밸브를 잠근 후 주변을 정돈한다. 절단한 재료를 다듬질 청소한다. 준비한 재료를 도면의 형상과 치수에 맞게 고정하여 가 용접한 후 청소 및 교정한 후 본용접을 실시하고 마무리 작업을 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|","workEnv":"고온|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"가스절단원, 토치절단원, 화염절단원, 용융절단원","certLic":"용접기능사","dJobECd":"8241","dJobECdNm":"[8241]용접원","dJobJCd":"7430","dJobJCdNm":"[7430]용접원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002943:1', '{"dJobCd":"K000002943","dJobCdSeq":"1","dJobNm":"이산화탄소가스아크용접원","workSum":"이산화탄소가스 아크용접기를 설치 및 조작하여 철강재료를 용접하여 기계, 자동차, 선박의 건조 및 각종 산업설비의 건설과 보수작업 등에 폭넓게 적용된다.","doWork":"용접기와 와이어 및 보호가스를 설치하고 용접전류와 전압 그리고 가스의 분출량을 알맞게 조정한다. 보호구를 착용한다. 작업지시서와 도면의 형상대로 용접될 모재를 가공하고 표면의 스케일, 녹, 기름 및 기타 유해 물질을 제거한다. 접합할 위치에 잭, 크램프 등을 사용하여 정확하게 고정하고 가접한다. 치수와 변형상태 등을 확인하여 교정한다. 본 용접을 실시한다. 뒷면을 가우징 또는 그라인딩하고 용접한다” 용접이 끝나면 모재 표면의 함몰, 긁힘 또는 결함부분을 확인하여 연마한다. 결함이 제거된 부분이 도면에서 요구하는 최소단면 두께보다 감소되었을 경우 재용접을 한다. 용접상태를 검사한다. “정리 정돈 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"CO₂용접원","certLic":"용접기능사, 용접산업기사, 용접기능장, 이산화탄소가스아크용접기능사, 불활성가스텅스텐아크용접기능사","dJobECd":"8241","dJobECdNm":"[8241]용접원","dJobJCd":"7430","dJobJCdNm":"[7430]용접원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002258:1', '{"dJobCd":"K000002258","dJobCdSeq":"1","dJobNm":"전기저항용접원","workSum":"전기의 저항열을 열원으로 명세서·설계도면에 따라 건축설비 및 금속부품을 용접절차에 따라 접합한다.","doWork":"작업지시서, 설계도면 등을 검토하고 용접방법 및 절차를 결정한다. 용접기 및 기타 장비를 준비하고 점검한다. 모재(피용접물)의 제질과 두께에 따라 전류의 세기, 가압력, 통전시간 등을 조절한다. 접합부의 형태에 적합한 전극을 선택하여 설치한다. 도면의 형상과 치수에 맞추어 지그나 클램프 등으로 고정한다. 접합시킬 위치와 전극봉이 정확하게 일치하도록 정렬한후 페달 스위치를 밟아 접촉지점을 용접한다.”연마기와 줄 등을 사용하여 전극을 깨끗이 닦아낸다. 용접부위를 확인하여 용접상태를 검사한다","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"전기저항용접공","connectJob":"업셋용접원, 플래시용접원, 봉합용접원, 섬광용접원","certLic":"용접기능사, 용접산업기사, 용접기능장","dJobECd":"8241","dJobECdNm":"[8241]용접원","dJobJCd":"7430","dJobJCdNm":"[7430]용접원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004408:1', '{"dJobCd":"K000004408","dJobCdSeq":"1","dJobNm":"조관기입측원","workSum":"강관제조를 위해 강판, 코일 등의 원료의 수급을 조절·관리하며 일정 치수로 절단된 코일을 조관기에 투입하여 연속작업이 가능하도록 전·후 코일의 끝을 용접한다.","doWork":"작업계획에 따라 작업할 코일을 인수하고 재질, 두께, 폭, 중량 등을 확인한다. 천장기중기나 지게차 등으로 이송된 작업할 코일과 예비코일을 언코일러 드럼에 삽입하기 위하여 계기판을 조작한다. 코일을 풀어 루프실(Loop:코일을 저장하는 장치)에 저장한다. 저장된 코일이 조관기로 전부 투입되기 전 예비코일을 삽입하고 용접기를 조작하여 전코일의 후단과 후코일의 선단을 맞대기 용접하여 연속조관작업이 가능하도록 한다. 용접상태를 검사하고 불량 시 재용접한다. 코일의 진입상태 및 장력을 점검하고 이상 시 조치를 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"코일연결원, 엔트리원","certLic":"가스텅스텐아크용접기능사, 이산화탄소가스아크용접기능사, 판금제관기능사, 판금제관산업기사, 판금제관기능장","dJobECd":"8241","dJobECdNm":"[8241]용접원","dJobJCd":"7430","dJobJCdNm":"[7430]용접원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005043:1', '{"dJobCd":"K000005043","dJobCdSeq":"1","dJobNm":"취부사","workSum":"제조된 선박블록(Block)들을 도면에 따라 조립하기 위하여 철목원이 고정(Setting)한 블록의 주판과 내부재 등을 정렬(Align)하여 단차(블록과 블록 사이의 접합부)를 맞추고 정해진 위치에 취부 및 가 용접 한 후 본 용접하여 고정한다.","doWork":"취부할 부재의 제원, 설계도, 검사 관련 규정 등을 파악한다. 작업도면을 보고 철목원이 세팅한 블록의 상태를 확인한다. 작업범위, 요구품질, 공사기간 등을 반영하여 작업계획서를 작성한다. 작업에 필요한 자재목록을 작성한다. 절단기, 용접기, 각종 피스류, 지그류, 마스크, 보안경, 용접장갑, 조명 및 환기장치를 준비한다. 주판(블록의 판재부분)을 취부하기 위하여 정렬(Align)하고 쐐기피스를 조립하여 고정한다. 내부 론지(Longi:블록의 수직부재)를 취부하기 위하여 론지 지그로 벌어지거나 상하 차이가 나지 않도록 고정한다. 론지 지그의 파워를 작동하여 정렬한다. 잘못 정렬된 부분을 확인하고 이상이 없으면 용접하여 고정한다. 각 작업 공정에서는 부재를 도면에 맞추어 정해진 위치에 취부 및 가 용접 한 후 본 용접한다. 선체를 조립 할 때는 소조립, 중조립, 대조립, 탑재 등의 공정별 순서에 의해서 진행한다. 자동용접장치를 사용하는 경우 자동용접장치의 가이드롤러를 론지에 결합하고 용접헤드를 설정한다. 자동용접장치를 작동시켜 용접 시작 위치부터 종료 위치까지 용접한다. 필요에 따라 절단과 치구류 등을 사용해야 한다. 관련 규정이나 법규에 따라 설치검사를 하고 검사결과를 기록한다. 작업이 완료되면 작업 내용서를 작성하여 고객 및 작업 요청부서에 인계한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"힘든 작업","workPlace":"실외","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"심출사, 취부원, 조선용접원, 조선취부사, 취부용접원, 선박가용접원","certLic":"용접기능사, 용접산업기사, 용접기능장","dJobECd":"8241","dJobECdNm":"[8241]용접원","dJobJCd":"7430","dJobJCdNm":"[7430]용접원","dJobICd":"C311","dJobICdNm":"[C311]선박 및 보트 건조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003592:1', '{"dJobCd":"K000003592","dJobCdSeq":"1","dJobNm":"테르밋용접원","workSum":"산화금속과 알루미늄 분말에 합금원소 등을 첨가해 용접용으로 조정된 테르밋제를 이용한 테르밋용접기로 주강, 연강, 철도궤도 등의 금속부품들을 접합한다.","doWork":"고정구에 부품을 정렬하여 고정한다. 가스토치를 이용하여 결합시킨 부분을 다듬는다. 갭 주위에 왁스형판과 주형을 놓는다. 특수한 위치에는 게이트 주형과 라이서 주형을 놓는다. 플러그를 잡아당겨 형틀에 테르밋 물질이 일정한 양만큼 자동적으로 부어지도록 한다. 가스토치를 사용하여 왁스를 녹이고 히터를 이용하여 주형을 건조한다. 토치를 사용하여 혼합물을 전화시키고, 테르밋용접을 시작한다. 수동공구를 사용하여 주형을 깬다. 가스토치를 사용하여 게이트와 라이서를 절단한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"가스텅스텐아크용접기능사, 이산화탄소가스아크용접기능사, 용접기능장","dJobECd":"8241","dJobECdNm":"[8241]용접원","dJobJCd":"7430","dJobJCdNm":"[7430]용접원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006021:1', '{"dJobCd":"K000006021","dJobCdSeq":"1","dJobNm":"특수용접원","workSum":"설계도면과 용접절차서에 따라 합금강 계열이나 얇은 두께의 고속조관 등에 고능률 용접을 한다.","doWork":"작업물을 작업대에 고정한다. 용접할 부위의 이물질을 제거한다. 용접부위의 청결도를 유지시키고 주위에 유해환경이 없도록 정리한다. 유도전류의 저항발열을 이용하거나 전류 또는 탄산가스에서 생긴 광에너지를 이용하여 모재를 가열하여 비교적 얇은 두께의 관이나 합금강 등을 맞대기 용접, 중첩용접, 변두리용접, 덧살용접 등의 방법을 이용하여 용접한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"고주파용접원, 플라스마용접원, 레이저용접원, 미그용접원, 티그용접원, 플랜트특수용접원, 원자력용접원","certLic":"용접기능장, 불활성가스텅스텐아크용접, 이산화탄소가스아크용접","dJobECd":"8241","dJobECdNm":"[8241]용접원","dJobJCd":"7430","dJobJCdNm":"[7430]용접원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003737:1', '{"dJobCd":"K000003737","dJobCdSeq":"1","dJobNm":"자동차검사원","workSum":"육안 및 검사 장비를 사용하여 자동차의 안전도와 환경검사를 실시하고 자동차등록 원부와 동일성 여부 등을 확인한다.","doWork":"검사대에 차량을 위치시키고 검사장비를 작동한다. ABS 모니터기, 배기가스 측정기, 매연측정기, 헤드라이트측정기기 등을 사용하여 자동차의 안전도 검사와 배기가스 허용기준 적합 여부 등 환경검사를 실시한다. 동일성 확인이나 불법설치물 여부, 기타 경보장치, 시야확보, 창유리 등을 육안으로 검사한다. 경적음 및 배기소음을 측정한다. 검사결과를 자동차검사표에 기록한다. 차량의 검사내용을 정리하여 종합적으로 평가한다. 시정권고 사항이 있을 경우 조언하며 기타 불합격의 원인을 제시하여 수리하도록 차주에게 권한다. 검사결과를 전산시스템에 입력한다. 일일검사대장을 작성한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"청각|시각|","workEnv":"소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"자동차정비검사원","connectJob":"자동차휠검사원","certLic":"자동차정비기능사, 자동차차체수리기능사, 자동차정비기능장, 자동차정비산업기사","dJobECd":"8124","dJobECdNm":"[8124]자동차 정비원","dJobJCd":"7510","dJobJCdNm":"[7510]자동차 정비원","dJobICd":"S952","dJobICdNm":"[S952]자동차 및 모터사이클 수리업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005637:1', '{"dJobCd":"K000005637","dJobCdSeq":"1","dJobNm":"자동차검수원","workSum":"버스, 택시, 화물차 운송업체에서 차량의 안전운행을 확보하기 위하여 검차하고 정비한다.","doWork":"계획에 따라 차량을 검사하고 정비한다. 부품과 공구를 관리하고 부족량을 신청한다. 차량이 안전하게 운행되며 승객이 불편함이 없도록 타이어공기압 및 마모정도, 냉각수, 오일, 연료공급장치, 각종 벨트류, 공조장치, 제동장치 등을 점검한다. 운전기사로 부터 고장신고를 접수하여 조치한다. 사고차량의 경우 손상범위와 원인을 조사·검토하고 예방대책을 강구한다. 손상범위가 커서 자체에서 수리하지 못하는 것은 정비공장에 의뢰한다. 정비일지를 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|청각|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"자동차정비기능사, 자동차차체수리기능사, 자동차정비기능장, 자동차정비산업기사","dJobECd":"8124","dJobECdNm":"[8124]자동차 정비원","dJobJCd":"7510","dJobJCdNm":"[7510]자동차 정비원","dJobICd":"S952","dJobICdNm":"[S952]자동차 및 모터사이클 수리업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007155:1', '{"dJobCd":"K000007155","dJobCdSeq":"1","dJobNm":"자동차경주미케닉","workSum":"자동차 경주 전 또는 도중에 자동차가 경주에 최적화되도록 정비한다.","doWork":"경주 전에 자동차에 이상 여부를 확인하고, 시범 운전을 반복한다. 엔지니어와 함께 경주용 자동차에 부품을 장착하기도 한다. 경기 중에 피트인(Pit-in:정비구역)에 경주차가 들어오면 신속하게 수리, 부품조정 등을 하고, 이상이 생긴 부품은 교체한다. 장거리 경기에서 타이어 교환과 연료를 보급한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"손사용|","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"카레이싱미케닉","certLic":"자동차정비기능사, 자동차차체수리기능사, 자동차정비기능장, 자동차정비산업기사, 자동차정비기사","dJobECd":"8124","dJobECdNm":"[8124]자동차 정비원","dJobJCd":"7510","dJobJCdNm":"[7510]자동차 정비원","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004856:1', '{"dJobCd":"K000004856","dJobCdSeq":"1","dJobNm":"자동차내장설치원","workSum":"자동차용 전기용품, 시트 등의 내장용품, 비상공구 등을 설치 또는 비치하고 이상 유무를 확인하거나 수리한다.","doWork":"소비자가 선택한 각종 등화장치(안개등, 실내·외 네온등 등) 및 내장용품(각종 액세서리), 편의용품(전자혼, 라디오, 난방기, 스피커, 내비게이션 등)을 설치 및 교체한다. 차량의 치수에 맞추어 고무판 및 천 등을 절단하여 설치한다. 차량시트를 교체하거나 차량용 액세서리를 판매하기도 한다. 각종 튜닝용품에 대하여 소비자와 상담한 후 설치하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"자동차인테리어설치원, 자동차경정비원","dJobECd":"8124","dJobECdNm":"[8124]자동차 정비원","dJobJCd":"7510","dJobJCdNm":"[7510]자동차 정비원","dJobICd":"G452","dJobICdNm":"[G452]자동차 부품 및 내장품 판매업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006168:1', '{"dJobCd":"K000006168","dJobCdSeq":"1","dJobNm":"자동차도장정비원","workSum":"자동차의 페인트 표면 흠집을 없애기 위하여 페인트 및 분무기로 도색한다.","doWork":"차량의 부식된 부위를 확인하고 사포나 연마기를 사용하여 각종 이물질을 제거한다. 공기압축호스를 사용하여 표면에 부착된 먼지, 수분 등을 제거하고 칠하지 않을 부위에 종이테이프를 사용하여 덮는다. 차량의 차대번호에 따라 차량의 색상을 확인하고 같은 색상을 맞추기 위하여 도료를 배합하고 분무기나 솔을 사용하여 도색한다. 도색부위를 이중으로 도색한 후 열처리실에 차량을 넣고 일정 시간 동안 가열하여 경화한다. 차량의 도색작업이 완료되면 연마재와 연마기를 사용하여 거친 부분을 제거하고 왁스를 사용하여 광을 낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"자동차보수도장기능사","dJobECd":"8124","dJobECdNm":"[8124]자동차 정비원","dJobJCd":"7510","dJobJCdNm":"[7510]자동차 정비원","dJobICd":"S952","dJobICdNm":"[S952]자동차 및 모터사이클 수리업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002582:1', '{"dJobCd":"K000002582","dJobCdSeq":"1","dJobNm":"자동차선팅필름부착원","workSum":"햇빛 차단, 시야확보, 단열기능, 사생활보호 등 목적에 따라 고객과의 상담을 통해 자동차 선팅필름 부착작업을 수행한다.","doWork":"고객과의 상담을 통해 가시광선 투과율 및 반사율, 자외선 및 태양열 차단율 등을 고려하여 기능성 선팅필름의 종류를 결정한다. 시야성을 고려하여 전면, 측면, 후면부 등 각 부분의 선팅 농도를 결정한다. 선팅필름을 부착할 유리면의 이물질을 제거하고 분무기를 사용하여 비눗물을 충분히 뿌린 후 선팅필름을 부착한다. 부착된 선팅필름 표면에도 비눗물을 뿌려준 후 고무 스크레이퍼 또는 드라이어 등 도구를 사용하여 기포를 제거한다. 선팅필름 부착 후 모서리 부분을 정리하고 유리와 끝선을 정교하게 재단하여 완성한다. 홍보용 차량 및 돌과 모래, 산화, 부식 등 자동차에 손상을 주는 위해로부터 자동차를 안전하게 보호하기 위하여 자동차 외장 표면에 카스킨 필름을 사용하여 시공작업을 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"자동차경정비원","connectJob":"카스킨작업원, 카스킨공, 틴틴공","dJobECd":"8124","dJobECdNm":"[8124]자동차 정비원","dJobJCd":"7510","dJobJCdNm":"[7510]자동차 정비원","dJobICd":"G452","dJobICdNm":"[G452]자동차 부품 및 내장품 판매업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002550:1', '{"dJobCd":"K000002550","dJobCdSeq":"1","dJobNm":"자동차엔진정비원","workSum":"자동차의 엔진과 부속장치 등을 각종 측정 장치를 통해 점검하고 부품을 교체하거나 정비한다.","doWork":"차량을 정지 또는 시동상태에서 오일의 양, 누유 및 개스킷의 상태 등을 점검하고 필요한 경우 각종 측정 장치를 엔진에 설치하여 ECU(Electronic Control Unit), 점화시기, 센서, 엔진 회전수, 배기가스 등을 측정한다. 파손부위에 따라 엔진부속장치인 냉각장치, 윤활장치, 흡기장치, 배기장치 등을 교체하거나 정비한다. 파손의 상태에 따라 엔진을 탈착하고 분해한다. 교체부품에 대한 견적을 산출하기도 한다. 정비 차량을 소비자에게 인도하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|청각|","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"승용차엔진정비원, 버스엔진정비원, 트럭엔진정비원","certLic":"자동차정비기능사, 자동차정비산업기사, 자동차정비기능장","dJobECd":"8124","dJobECdNm":"[8124]자동차 정비원","dJobJCd":"7510","dJobJCdNm":"[7510]자동차 정비원","dJobICd":"S952","dJobICdNm":"[S952]자동차 및 모터사이클 수리업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002705:1', '{"dJobCd":"K000002705","dJobCdSeq":"1","dJobNm":"자동차완성수정원","workSum":"완성검사에서 발견된 차량의 의장 및 섀시의 결함을 수정한다.","doWork":"완성검사에서 지적된 결함을 확인한다. 수정에 필요한 공구·장비 및 자재를 준비한다. 차량의 내·외부의 각종 누수, 누유, 작동불량 등의 결함상태를 파악한다. 엔진오일팬, 트랜스미션, 각종 케이블 및 호스류 등을 교환하거나 브레이크, 클러치 페달 등의 유격을 조정한다. 차량의 속도계, 배전기, 공기조절장치 등을 수정하거나 교환한다. 엔진을 탈거하여 교환하는 경우도 있다. 수정된 항목을 기록하고 완성된 차량을 출고공정으로 인도한다. 필요시 해당 공정의 작업자에게 작업을 의뢰하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|청각|시각|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"자동차정비기능사, 자동차정비산업기사, 자동차정비기능장","dJobECd":"8124","dJobECdNm":"[8124]자동차 정비원","dJobJCd":"7510","dJobJCdNm":"[7510]자동차 정비원","dJobICd":"C301","dJobICdNm":"[C301]자동차용 엔진 및 자동차 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001449:1', '{"dJobCd":"K000001449","dJobCdSeq":"1","dJobNm":"자동차의장수정원","workSum":"차체검사 또는 의장검사에서 발견된 자동차 의장조립 공정의 결함을 수정한다.","doWork":"자동차의장검사원이 작성한 검사카드를 보고 결함사항을 확인하고 조치 방법을 결정한다. 차량 엔진룸 내부의 각종 부품 및 배선의 취부상태를 점검한다. 차량외부에 부착된 부품의 장착상태를 점검하여 취부 불량부위는 망치 및 특수공구로 수정한다. 차량내부의 각종 부품의 장착상태, 작동상태 등을 점검하여 작동불량, 들뜸, 벌어짐, 장치불량 등의 결함부위를 수정한다. 시트, 도어유리, 루프라이닝(Roof Lining), 몰딩 등의 결함부품을 교환한다. 작업결과를 일지에 작성한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"자동차정비기능사, 자동차정비산업기사, 자동차정비기능장","dJobECd":"8124","dJobECdNm":"[8124]자동차 정비원","dJobJCd":"7510","dJobJCdNm":"[7510]자동차 정비원","dJobICd":"C301","dJobICdNm":"[C301]자동차용 엔진 및 자동차 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006139:1', '{"dJobCd":"K000006139","dJobCdSeq":"1","dJobNm":"자동차전장수정원","workSum":"완성된 차량의 엔진을 시동하여 전기장치 및 전장부분품의 이상 유무를 점검하고 결함사항을 수정한다.","doWork":"검사기준서를 숙지하고 각종 시험기기 및 공구를 준비한다. 입고된 차량의 엔진을 시동시키기 전에 연료 상태 및 윤활유 상태를 점검한다. 엔진을 기동시키고 각종 전장부품(전기, 전자장치, 배터리, 와이어하네스, 디스플레이장치, 모터, 센서, 액추에이터, 컨트롤유닛, 스위치, 인터페이스 및 커넥터, 배선)과 전장부분품의 동작시험을 한다. 엔진시험기를 설치하고 액정장치를 확인하여 엔진의 상태와 각종 센서의 작동상태를 확인한다. 점검 후 접촉불량, 동작불량, 오(誤)배선을 수리하거나 해당 부품을 교환한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"자동차전장정비원","certLic":"자동차정비기능사, 자동차정비산업기사, 자동차정비기능장","dJobECd":"8124","dJobECdNm":"[8124]자동차 정비원","dJobJCd":"7510","dJobJCdNm":"[7510]자동차 정비원","dJobICd":"C301","dJobICdNm":"[C301]자동차용 엔진 및 자동차 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001746:1', '{"dJobCd":"K000001746","dJobCdSeq":"1","dJobNm":"자동차정비반장","workSum":"수리를 의뢰받은 자동차의 상태를 확인하고 작업원들의 활동을 지시 및 감독하고 조정한다.","doWork":"소비자의 차량상태를 확인하고, 차량의 제원에 따른 기초 자료를 수집한다. 고장원인을 판정하기 위해 시운전을 하고, 장비를 운용하여 차량의 고장 여부를 판정한 뒤 고장결과에 따른 작업에 대해 업무분담을 지시한다. 수리에 필요한 부품목록을 수집하여 확인 및 검토하고 정비 소요시간을 고려하여 견적서를 산출한다. 정비과정 중에 발생하는 기술상의 문제를 감독·조정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|청각|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"수동조작","connectJob":"승용차정비반장, 버스정비반장, 트럭정비반장","certLic":"자동차정비기능사, 자동차정비산업기사, 자동차정비기능장","dJobECd":"8124","dJobECdNm":"[8124]자동차 정비원","dJobJCd":"7510","dJobJCdNm":"[7510]자동차 정비원","dJobICd":"S952","dJobICdNm":"[S952]자동차 및 모터사이클 수리업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002234:1', '{"dJobCd":"K000002234","dJobCdSeq":"1","dJobNm":"자동차튜너","workSum":"자동차의 기능을 향상시키거나 형태를 변화시키기 위해 합법적 범위 내에서 자동차를 개조한다.","doWork":"자동차를 변형(튜닝)하려는 목적을 파악하여 자동차 개조계획을 수립한다. 튜닝을 위한 견적을 산출한다. 경주용 튜닝의 경우 경기규칙을 검토하고 규정되어 있는 튜닝 범위를 확인한다. 성능을 향상시키는 튠업튜닝, 자동차 적재장치 및 승차장치의 구조를 변경하는 빌드업튜닝, 자동차의 내·외관을 변화시키기 위한 드레스업튜닝을 위하여 자동차의 엔진, 조향장치, 소음장치, 타이어, 휠, 오디오, 핸들, 범퍼 등의 부품을 교체, 부착 및 변형한다. 시험운전을 통해 자동차에 이상이 없는지 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|소음·진동|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"자동차튜닝엔지니어","certLic":"자동차정비기능사, 자동차정비산업기사","dJobECd":"8124","dJobECdNm":"[8124]자동차 정비원","dJobJCd":"7510","dJobJCdNm":"[7510]자동차 정비원","dJobICd":"S952","dJobICdNm":"[S952]자동차 및 모터사이클 수리업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006674:1', '{"dJobCd":"K000006674","dJobCdSeq":"1","dJobNm":"자동차판금정비원","workSum":"사고로 인해 변형 및 파손된 차체를 각종 수공기, 용접기, 유압기, 연삭기 등을 사용하여 수리한다.","doWork":"작업지시서 및 정비차량의 종류를 확인하고 파손 및 변형 정도를 파악한다. 리프트를 사용하여 차량을 올린 후 차체 바닥 및 엔진룸, 도어, 라디에이터서포트 등의 변형 여부를 살핀다. 손상부위에 따라 판금가능 부품과 교체할 부품을 결정한다. 각도기와 강철직각자, 수평계 등을 사용하여 파손부위의 절단범위를 결정한다. 유압기를 사용하여 파손된 차체 및 부품을 펴고 연마기나 파우더로 요철부위를 복구한다. 용접기를 사용하여 완파된 부위를 절단하고 새로운 부품을 용접한다. 용접 후 용접부위 및 판금부위는 연마재와 연삭기를 사용하여 연마한다. 전문 성형작업을 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"자동차판금원, 자동차차체정비원","certLic":"자동차차체수리기능사","dJobECd":"8124","dJobECdNm":"[8124]자동차 정비원","dJobJCd":"7510","dJobJCdNm":"[7510]자동차 정비원","dJobICd":"S952","dJobICdNm":"[S952]자동차 및 모터사이클 수리업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005312:1', '{"dJobCd":"K000005312","dJobCdSeq":"1","dJobNm":"자동차하체정비원","workSum":"자동차의 엔진을 제외한 동력전달장치, 조향장치, 현가장치, 제동장치 등을 점검 및 교체, 수리한다.","doWork":"차량의 각종 장치들에 대한 지식을 바탕으로 섀시부품들의 작동상태를 점검하고 이상 유무를 확인하여 부품에 따라 교체 및 수리작업을 실시한다. 부품의 손상 여부에 따라 분해 및 소제작업을 실시하며, 장치에 맞는 오일 또는 그리스를 주입한다. 동력전달장치인 클러치(기계식, 유압식) 및 변속기(수동, 자동, 무단)의 작동상태에 따라 교체 및 부품교체작업을 실시하고, 현가장치인 쇼크업소버(Shock Absorber) 및 스프링의 작동상태를 점검하고 교체한다. 제동장치인 브레이크 장치에 대해 오일의 보충 및 패드 교환, 제동력 점검, 디스크 교환 작업 등을 실시한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"자동차섀시정비원","connectJob":"승용차차체정비원, 버스차체정비원, 트럭차체정비원","certLic":"자동차차체정비기능사, 자동차정비기능장","dJobECd":"8124","dJobECdNm":"[8124]자동차 정비원","dJobJCd":"7510","dJobJCdNm":"[7510]자동차 정비원","dJobICd":"S952","dJobICdNm":"[S952]자동차 및 모터사이클 수리업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001581:1', '{"dJobCd":"K000001581","dJobCdSeq":"1","dJobNm":"전기자동차정비원","workSum":"전기자동차를 진단점검하고 관련 장치를 수리교환한다.","doWork":"정비지침서에 따라 전기자동차(EV, electric vehicle, HEV, hybrid electric vehicle)의 장치 및 작동상태를 파악한다. 정비지침서의 세부점검 목록을 확인하고 확인진단장비(메가옴테스터, 종합진단기, 스캐너, 멀티테스터 등)를 사용하여 고장원인을 파악한다. 고장 부품을 수리하거나 교환한다. 정비한 부품을 베리언트 코딩(variant coding, 모듈별 사양인식) 한다. EV공조장치, EV모터, 고전압 배터리, 직류교류변환기, BMS(battery management system, 배터리 운용장치) 등을 점검조정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"자동차정비기능사, 자동차정비산업기사","dJobECd":"8124","dJobECdNm":"[8124]자동차 정비원","dJobJCd":"7510","dJobJCdNm":"[7510]자동차 정비원","dJobICd":"S952","dJobICdNm":"[S952]자동차 및 모터사이클 수리업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002710:1', '{"dJobCd":"K000002710","dJobCdSeq":"1","dJobNm":"휠평형시험원","workSum":"주행 중 차량의 쏠림 또는 편 마모가 발생하는 타이어의 휠 평형을 점검하고 조정한다.","doWork":"새 타이어 또는 시험을 의뢰한 타이어를 휠 평형시험기(Wheel Balance Tester)에 장착한다. 타이어를 회전시키면서 테스터기를 통해 타이어의 정적, 동적 평형을 점검한다. 테스터기에 표시된 타이어의 상·하·좌·우 무게 차이를 보면서 평형추(알루미늄 또는 납)를 휠에 덧붙여 휠의 평형을 맞춘다. 시운전을 통하여 타이어의 상태를 최종 점검한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"휠얼라이먼트시험원","dJobECd":"8124","dJobECdNm":"[8124]자동차 정비원","dJobJCd":"7510","dJobJCdNm":"[7510]자동차 정비원","dJobICd":"S952","dJobICdNm":"[S952]자동차 및 모터사이클 수리업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005643:1', '{"dJobCd":"K000005643","dJobCdSeq":"1","dJobNm":"항공기기체검사원","workSum":"항공기에 설치된 배관 시스템이 항공기 정비 매뉴얼,, 기술 지시서의 내용과 일치하는지 검사한다.","doWork":"보기와 연결된 배관의 찍힘, 굽힘, 마모, 연결구의 체결 상태,를 검사한다. 해당 계통을 작동 점검을 수행하여 계통 유체,의 누설 여부를 검사한다. 결함이 발견되면 그 내역을 기록, 보관하여 수정 작업이 이뤄지도록 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"항공정비사, 항공기사, 항공산업기사","dJobECd":"8121","dJobECdNm":"[8121]항공기 정비원","dJobJCd":"7521","dJobJCdNm":"[7521]항공기 정비원","dJobICd":"C313","dJobICdNm":"[C313]항공기, 우주선 및 부품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006301:1', '{"dJobCd":"K000006301","dJobCdSeq":"1","dJobNm":"항공기기체정비사","workSum":"항공기의 기체를 점검, 수리, 개조를 수행한다.","doWork":"항공기 운영사가 제공하는 작업 지시서에 의거 항공기 기체를 점검, 수리, 개조, 계통별 성능테스트 를 수행히고 비행 대기 태세를 확보한다. 항공기 결함에 대하여 제작사의 정비 매뉴얼의 의거 결함을 해소 한다","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"항공기기체정비원","connectJob":"항공기운항정비원, 항공기공장정비원, 헬리콥터기체정비원","certLic":"항공정비사, 항공기체정비기능사, 항공산업기사","dJobECd":"8121","dJobECdNm":"[8121]항공기 정비원","dJobJCd":"7521","dJobJCdNm":"[7521]항공기 정비원","dJobICd":"H511","dJobICdNm":"[H511]항공 여객 운송업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006197:1', '{"dJobCd":"K000006197","dJobCdSeq":"1","dJobNm":"항공기기체표면처리정비사","workSum":"항공기의 표면을 화학적 표면처리, 도장 처리하기 전·후에 동체 및 각종 부품·조립품의 표면을 검사한다.","doWork":"항공기 표면에 결점(가는 선, 작은 구멍, 눌린 자국, 기포, 먼지 등)이 있는지 알기 위하여 회중전등, 거울, 마이크로미터 등 각종 계기를 사용해 금속 표면(페인트칠·도금·열처리 및 보호막을 입혀 전기분해가 된 상태)을 검사한다. 표면경화(Surface Hardening:중심부는 무르게 하고 외부 표면의 강도를 증가), 담금질(Quenching:고온에서 형상된 금속을 기름이나 물에 담가 빨리 식힘), 도금, 풀림(Annealing:금속을 미리 정해진 온도로 가열해 일정 시간 동안 그 상태로 유지한 다음 실온에서 냉각시킴으로써 가단성(可鍛性)을 높이고 깨지기 쉬운 성질을 줄임) 작업의 전·후에 마이크로미터와 경도시험기를 사용하여 부품·재료 및 조립품의 청결, 내성, 경도 등을 검사한다. 전기안전도 기기를 사용하여 금속부품의 안전도를 검사하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|청각|손사용|시각|","workEnv":"대기환경미흡|다습|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"항공기표면검사원","certLic":"항공기정비기능사, 항공산업기사","dJobECd":"8121","dJobECdNm":"[8121]항공기 정비원","dJobJCd":"7521","dJobJCdNm":"[7521]항공기 정비원","dJobICd":"C313","dJobICdNm":"[C313]항공기, 우주선 및 부품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003840:1', '{"dJobCd":"K000003840","dJobCdSeq":"1","dJobNm":"항공기보기정비사","workSum":"항공기 보기에 대해 분해, 세척, 수리, 검사, 조립, 성능 테스트를 수행한다.","doWork":"항공기에서 떼어낸 보기를 해당 보기의 제작사에서 제공하는 보기 정비 매뉴얼에 제시된 절차에 따라 분해, 세척, 수리, 검사, 조립, 성능 테스트를 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"항공기부품정비원","connectJob":"항공기전자계기정비원, 항공기기계보기정비원, 헬리콥터부품정비원","certLic":"항공정비사, 항공기체정비기능사, 항공산업기사","dJobECd":"8121","dJobECdNm":"[8121]항공기 정비원","dJobJCd":"7521","dJobJCdNm":"[7521]항공기 정비원","dJobICd":"H511","dJobICdNm":"[H511]항공 여객 운송업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003396:1', '{"dJobCd":"K000003396","dJobCdSeq":"1","dJobNm":"항공기비행지원원","workSum":"항공기 출발장에서 항공기의 비행태세를 확인하여 운항일지에 기록하고 조종사와 의사를 교환하고 출발을 지원한다.","doWork":"항공기 정비, 운항에 필요한 견인, 유도를 수행한다. 항공기 운항에 필요한 연료, 엔진오일, 유압 작동 유, 주방용 물, 화장실 서비스의 보급상태를 확인한다. 항공기 출발장에서 항공기의 상태를 점검하여 비행태세가 확보되었음을 운항일지에 기록 및 싸인하고 조종사와 의사를 교환한다. 항공기의 출발을 지원한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"항공기운항정비사","certLic":"항공산업기사, 항공정비기능사, 항공정비사","dJobECd":"8121","dJobECdNm":"[8121]항공기 정비원","dJobJCd":"7521","dJobJCdNm":"[7521]항공기 정비원","dJobICd":"C313","dJobICdNm":"[C313]항공기, 우주선 및 부품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004333:1', '{"dJobCd":"K000004333","dJobCdSeq":"1","dJobNm":"항공기엔진오일분석원","workSum":"항공기의 엔진오일 및 유압유(油壓油:유압 동력 전달의 매체로 쓰는 점성이 낮은 기름)의 중금속 및 미생물 오염 정도를 점검한다.","doWork":"비행을 마치고 시동을 끈 항공기 엔진의 엔진오일을 병에 담아 채취한다. 정밀측정 검사의 경우에는 제트엔진의 시험운영 단계별로 오일을 채취한다. 육안이나 오일 분석기를 이용해 채취된 오일의 오염정도(철, 은, 구리, 마그네슘 등 중금속의 함유 여부)를 분석한다. 단계별로 분석결과 그래프를 그리고 정해진 운용한계치 내에 있는지 판독한다. 판독결과는 오일 분석 기록 카드에 표시하고 이상 여부를 기록한다. 오염 정도가 정해진 운용한계치를 벗어난 경우 항공기 오일을 교환하고, 필요에 따라 항공기 엔진을 장탈하여 엔진의 오일 시스템을 검사하여 오일의 오염원인을 찾아내도록 권고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"청각|손사용|시각|","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"기름여과기검사원, 오일 SOAP (Spectrometric Oil Analysis Program) 검사원","certLic":"항공기정비기능사, 항공산업기사","dJobECd":"8121","dJobECdNm":"[8121]항공기 정비원","dJobJCd":"7521","dJobJCdNm":"[7521]항공기 정비원","dJobICd":"C313","dJobICdNm":"[C313]항공기, 우주선 및 부품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002141:1', '{"dJobCd":"K000002141","dJobCdSeq":"1","dJobNm":"항공기왕복엔진정비사","workSum":"비행안전을 보장하고 항공기 기관상태를 최상으로 유지하기 위해 정기적 또는 비정기적으로 왕복기관을 정비한다.","doWork":"왕복(추가) 기관 및 관련 계통의 작동상태를 검사한다. 기체, 엔진, 부품, 전자장비, 제어장치, 타이어 등 손상된 각 기관 및 부품을 분해하고 부식, 균열, 소모, 약화 여부 등을 검사한다. 각종 부품을 세척하고 사용 가능 여부를 시험한다. 수리가 필요한 부품 및 기관은 판금, 용접, 가공 등의 과정을 거쳐 수리하고, 재사용이 불가능할 경우 교체한다. 수리가 끝나면 항공기를 기동해 성능을 시험한다. 성능 향상을 위하여 특별 정비를 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|청각|손사용|시각|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"항공기관정비사, 항공기엔진정비원","certLic":"항공정비사, 항공기정비기능사, 항공산업기사","dJobECd":"8121","dJobECdNm":"[8121]항공기 정비원","dJobJCd":"7521","dJobJCdNm":"[7521]항공기 정비원","dJobICd":"H511/H512","dJobICdNm":"[H511]항공 여객 운송업 / [H512]항공 화물 운송업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001410:1', '{"dJobCd":"K000001410","dJobCdSeq":"1","dJobNm":"항공기운송장비조립원","workSum":"도면을 읽고 각종 검사장비를 사용하여 항공기의 아날로그·디지털 통신장비와 부품을 수리 및 검사한다.","doWork":"작업 방법과 공정에 맞는 검사를 위해 기술도면 및 부속도면을 분석한다. 여러 가지 장비를 사용하여 각종 부품을 시험하고 측정한다. 정해진 공정에서 발견된 결함은 시정서를 발행하여 시정조치를 시킨 후에 최종 성능검사를 한다. 최종 성능검사에서 발견된 결함사항은 시정하고 부품이 규정된 표준치와 일치하는지 확인한다. 불합격일 경우에는 불합격 내역을 기록한 서류를 작성하고 불합격 판정을 내린다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|청각|손사용|시각|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"항공기계기부품검사원","certLic":"항공산업기사, 항공전기전자정비기능사","dJobECd":"8121","dJobECdNm":"[8121]항공기 정비원","dJobJCd":"7521","dJobJCdNm":"[7521]항공기 정비원","dJobICd":"C313","dJobICdNm":"[C313]항공기, 우주선 및 부품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;