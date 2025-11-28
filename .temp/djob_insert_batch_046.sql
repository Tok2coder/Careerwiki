INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005006:1', '{"dJobCd":"K000005006","dJobCdSeq":"1","dJobNm":"인사틀보기원","workSum":"실을 염색하거나 수송하기 위해 실을 감는 기계를 조작한다.","doWork":"스핀들에 실 꾸러미를 놓는다. 실 끝을 가이드를 통해 꿰고 자동 릴 와인더에 연결한다. 기계를 시동하고 실이 끊어지는지 관찰한다. 기계를 정지하고 끊어진 부분을 잇고 새 공급 실 꾸러미를 갈아 끼운다. 일정량이 감겨지면 가위나 칼로 실을 자르고 실타래의 끝을 서로 묶는다. 레버를 당겨 릴에서 실타래를 빼내고 엉킴을 알아보기 위해 자동 배출을 살펴본다. 감겨진 실의 무게를 재어 보거나 길이를 알아보기 위해 회전계수기의 다이얼을 맞추기도 한다. 여러 개의 실타래를 한 꾸러미로 묶기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"인사기운전원, 인사원, 작태원","certLic":"섬유산업기사","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006119:1', '{"dJobCd":"K000006119","dJobCdSeq":"1","dJobNm":"인터길박스틀보기원","workSum":"즐모 공정으로부터 공급된 톱(Top)을 빗질하여 섬유의 평행도를 높여주고 적정수분율을 유지하여 주는 인터길박스(Inter Gill Box) 기계를 운전한다.","doWork":"지시된 비율에 따라 탱크에 기름을 채운다. 톱(Top)을 차례로 크릴(Creel)에 올린다. 기계의 앞쪽에서 스위치를 간헐적으로 누르며 슬리버를 일정 횟수 꼬아 트럼펫(Trumpet)을 통해 보빈에 감는다. 기계를 관찰하여 끊어진 부분을 서로 잇는다. 불량 폴러(Faller)를 교체하고 기계를 청소한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"섬유산업기사","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003755:1', '{"dJobCd":"K000003755","dJobCdSeq":"1","dJobNm":"일추관리원","workSum":"실을 생산하는 정방공정에서 콥(Cop)의 불량원인을 찾아내고, 기계의 추를 수리 및 관리한다.","doWork":"기계 사이를 순회하면서 점검주기표에 따라 공추상태, 불량관사, 기계적 고장을 점검한다. 불량관사를 스핀들에서 빼내어 불량원인을 점검하고 시험실에 의뢰한다. 링, 트래블러, 스핀들, 테이프, 롤러 등 기계적 불량상태를 육안검사하고 수동공구를 조정하거나 부품을 교환한다. 마모 및 절단된 스핀들 테이프를 부착하기도 한다. 불량원인을 점검표에 기록하여 보고한다. 회전속도계를 사용하여 실의 방출상태를 점검한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"방추관리원, 스핀들관리원","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001671:1', '{"dJobCd":"K000001671","dJobCdSeq":"1","dJobNm":"자견원","workSum":"고치실에 포함되어 있는 세리신(Sericin)을 연화·팽윤하여 제사작업이 용이하도록 한다.","doWork":"실켜기 목적과 방법에 따라 부합되는 용수조건, 각 처리부위별 탕의 온도, 압력, 시간을 밸브를 돌리거나 버튼을 눌러 조정한다. 삶고자 하는 고치를 일정한 속도로 진행되는 컨베이어에 붙어 있는 고치그릇에 넣어 침지부, 고온부, 저온침투부, 증자부, 자숙부, 자양부를 통과시켜 연화·팽윤한다. 삶아진 고치는 고치그릇에 받고 약품이 첨가된 일정 온도의 물을 채워 실켜기장으로 운반한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"고온|다습|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"고치삶기작업원","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006332:1', '{"dJobCd":"K000006332","dJobCdSeq":"1","dJobNm":"자동권사틀보기원","workSum":"관사를 콘(Cone)이나 치즈(Cheese)로 옮겨 감기 위해 스플라이서(Splicer)와 자동권사장치가 부착된 자동권사기계를 조작한다.","doWork":"보빈을 공급장치 매거진(Magazine)의 포켓에 넣고 실 끝을 흡착관의 구멍 위로 끌어당겨 매듭기까지 이르도록 한다. 실감개통이 찼음을 알리는 불이 켜지면 실감개통을 들어낸다. 스핀들에 튜브나 콘을 갈아 끼운다. 실을 감기 위해 콘이나 튜브에 실 끝을 둘러 감는다. 기계의 속도를 조절한다. 공급 실이 다 풀려 모여진 보빈을 일정장소에 갖다 놓는다. 기계를 순회하면서 보빈이나 공급 실, 기타 실 뭉치 등에 의한 기계의 이상을 점검한다. 만관된 콘(Cone)의 중량을 확인한다. 기계의 작동불량에 대한 응급처치를 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"유지","similarNm":"자동권사기운전원, 자동권사원","certLic":"섬유산업기사","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003047:1', '{"dJobCd":"K000003047","dJobCdSeq":"1","dJobNm":"전방반장","workSum":"즐모 공정으로부터 공급된 톱(Top)을 점차로 가늘게 하여 정방공정에 공급할 조사(Roving)를 만드는 공정에 종사하는 작업원의 활동을 감독·조정한다.","doWork":"일정 굵기의 슬리버나 조사로 만들기 위해 작업지시서를 확인하고 중량 및 가닥수, 원료의 종류를 파악한다. 파악된 내용에 따라 작업계획을 세운다. 작업계획에 따라 세부실행항목을 수립하고 작업절차 및 방법을 결정하여 작업원에게 작업내용을 지시하고 작업배치를 한다. 색상이나 품목별로 원료의 배열을 작업원에게 지시한다. 꼬리표의 색상을 선정해준다. 작업상황을 관리·감독하고 기술적인 지원 및 자재를 공급한다. 직무수행능력을 향상시키고 안전재해를 예방한다. 수시면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴·해결하고 문제점을 보완한다. 기계의 운전 및 작업현황을 파악하여 기록·보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","certLic":"섬유산업기사","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003363:1', '{"dJobCd":"K000003363","dJobCdSeq":"1","dJobNm":"정방도핑원","workSum":"정방기에서 만관된 관사를 떼어내어 관사통에 담는다.","doWork":"정방기를 정지시키고 링레일을 아래로 내린다. 관사운반차를 기계 옆에 놓고 만관된 관사를 꺼내 관사통에 담는다. 도핑(Doffing)이 완료된 기계는 빈 목관을 스핀들에 끼우고 기계를 시동하고 실을 잇는다. 관사통에 제조일자, 번수 등을 기록하고 관사통에 이물질이 들어가지 않도록 포장한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003946:1', '{"dJobCd":"K000003946","dJobCdSeq":"1","dJobNm":"정방반장","workSum":"조사(Roving)를 사용하여 실을 뽑는 데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"작업지시서를 숙지하고 정방기계의 설치와 조정상태를 확인하다. 방사의 양, 섬유의 종류, 혼율, 기본 길이, 방사의 크기 등을 기계의 종류에 따라 확인·점검한다. 파악된 내용에 따라 작업계획을 수립한다. 작업원에게 작업을 분배하고, 목관색상, 트래블러(Traveller) 번호 등을 선정해 준다. 기계 주위를 순회하며 운전상태 등을 확인하고 수정토록 한다. 작업상황을 관리·감독하고 기술적인 지원 및 자재를 공급한다. 지시된 조건에 따라 실을 생산하기 위해 기어를 교환하고 품종이 변경될 경우 시험 가동하여 중량, 연수, 번수 등을 점검한다. 직무수행능력을 향상시키고 안전재해를 예방한다. 수시면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴·해결하고 문제점을 보완한다. 작업현황을 파악하여 기록·보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","certLic":"섬유산업기사","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003703:1', '{"dJobCd":"K000003703","dJobCdSeq":"1","dJobNm":"정방틀보기원","workSum":"조사(Roving)로 부터 실을 뽑아내는 정방기를 다룬다.","doWork":"기계를 순회하면서 공급 실이 비었거나, 끊어진 실이 있는지 관찰하며 끊어진 실을 잇고 풀린 조사는 새것으로 바꾼다. 공급 실 끝과 투입 중인 조사의 끝을 꼬아 연결한다. 실이 정상적으로 감기지 않을 때는 기계를 정지하고 손으로 실 꾸러미를 스핀들로부터 뽑아낸다. 스핀들에 실밥이 감겨 있으면 손이나 철사를 이용하여 실밥을 제거한다. 재료를 빨아들이는 흡입장치를 사용해 끊어진 실을 꺼내거나 손상된 부분을 확인하고 교환한다. 조사가 통과하는 가이드에 상처가 있는지 확인하고 트럼펫 구멍의 규격을 확인한다. 솜먼지를 감아주는 클리너가 정상적으로 회전하고 있는지 살펴보고 조치한다. 감긴 실 꾸러미가 규정된 모양으로 감기는지 확인한다. 스핀들(Spindle)에 기름을 주입하고 정방기를 청소한다. 감긴 실을 기계로부터 떼어내는 정방도핑원의 일을 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"방적원, 정방대지원, 정방호대원","connectJob":"링정방틀보기원, 오픈앤드정방틀보기원, 캡정방틀보기원","certLic":"섬유산업기사","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002413:1', '{"dJobCd":"K000002413","dJobCdSeq":"1","dJobNm":"정사반장","workSum":"생산된 실을 합사·연사·권사하는 데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"합사, 연사, 권사에 소요되는 공정시간에 따라 작업계획을 수립한다. 작업계획에 따라 세부실행항목을 수립하고 작업절차 및 방법을 결정하여 작업원에게 작업내용을 지시하고 공정 간 인원을 조정하여 작업배치를 한다. 공정별 기계가동 현황과 생산현황을 점검·기록·보고한다. 미숙련공에 대해 교육을 한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원 및 자재를 공급한다. 표준작업명세에 따라 지시된 작업이 이루어지는지 작업원과 함께 작업하며 작업상황을 관찰하고 작업내용을 점검한다. 작업의 진행사항을 파악하고 작업내용을 보고한다. 작업원의 직무교육 및 안전위생교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴·해결하고 문제점을 보완한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","certLic":"섬유산업기사","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004365:1', '{"dJobCd":"K000004365","dJobCdSeq":"1","dJobNm":"정소면틀보기원","workSum":"단섬유의 넵(Neps) 및 먼지 등을 제거하고 섬유를 평행으로 배열하여 강하고 가는 실을 만들기 위해 슬리버(Sliver)나 랩(Lap)을 빗질하고, 연신하는 기계를 조작한다.","doWork":"기계의 후면에 슬리버가 담긴 통을 배치하거나 랩을 롤러 위에 올려놓는다. 랩이나 슬리버를 공급롤러, 빗질하는 연조롤러, 코일형태로 감아주는 롤러로 통과시켜 운반통에 담거나 랩 롤러에 감아준다. 새 랩이나 슬리버를 앞의 섬유 끝에 이어 붙인다. 끊어진 섬유를 이어 붙이고 운반통이나 랩 롤을 갈아 끼운다. 갈고리를 사용하여 롤러나 장치의 둘레에 엉클어지거나 겹친 면을 잡아당겨 편다. 롤러나 에이프런에 감긴 섬유를 제거한다. 기계를 청소하고 기름을 친다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"코머기운전원, 코머대지원, 코머틀보기원","certLic":"섬유산업기사","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001978:1', '{"dJobCd":"K000001978","dJobCdSeq":"1","dJobNm":"제섬탱크실관리원","workSum":"알칼리 셀룰로오스와 이황화탄소를 작용시켜 만든 크산테이트(xanthate)를 묽은 가성소다 용액과 혼합하고 숙성시키는 탱크를 관리한다.","doWork":"크산테이트와 묽은 가성소다 용액을 혼합기에 넣어 혼합한다. 작업지시서를 확인하고 규정된 시간과 온도를 유지하여 혼합된 용액을 숙성시키고 다음 공정으로 이송한다. 숙성 시간과 온도 등을 기록하고 숙성탱크를 유지·보수한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"-","connectJob":"숙성실작업원","certLic":"-","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C205","dJobICdNm":"[C205]화학섬유 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007027:1', '{"dJobCd":"K000007027","dJobCdSeq":"1","dJobNm":"조방반장","workSum":"방적 작업을 위해 슬리버를 느슨하게 늘리고 꼬아서 조사를 만드는 데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"조방기의 설치와 조정상태를 점검한다. 작업계획에 따라 세부실행항목을 수립하고 작업절차 및 방법을 결정하여 작업원에게 작업내용을 지시하고 작업배치를 한다. 기계와 장비의 조작방법을 새로운 작업원에게 훈련시키고 작업 실적을 평가한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원 및 자재를 공급한다. 표준작업명세에 따라 지시된 작업이 이루어지는지 작업원과 함께 작업하며 작업상황을 관찰하고 작업내용을 점검한다. 작업의 진행사항을 파악하고 작업내용을 보고한다. 작업원의 직무교육 및 안전위생교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴·해결하고 문제점을 보완한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","certLic":"섬유산업기사","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006247:1', '{"dJobCd":"K000006247","dJobCdSeq":"1","dJobNm":"조방틀보기원","workSum":"연조 슬리버를 사용하여 실뽑기 작업 및 꼬임작업을 하기 위해 조사(Roving)를 연신(Drawing)하고 느슨하게 꼬아주는 조방기를 조작한다.","doWork":"만관된 슬리버 통의 슬리버 끝을 앞의 슬리버 끝과 겹쳐 손으로 꼬아 잇고 슬리버를 가이드, 롤러, 플라이어를 통해 보빈(Bobbin)에 끼운다. 슬리버의 부족 및 슬리버의 절단으로 인한 기계의 작동정지 신호등을 관찰하며 기계를 순회한다. 끊어진 슬리버 끝을 롤러와 플라이어를 통해 끼우고 보빈에 있는 조사의 끝과 비틀어 잇는다. 솔을 사용하여 롤러로부터 실 부스러기 및 먼지를 제거하고 기계에 주유한다. 조사의 스풀(Spool)에 중량과 번수를 색분필로 표시하기도 한다. 만관된 조사를 꺼내고 새로운 목관으로 교체하는 조사도핑원의 일을 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"조방기운전원, 조방대지원, 조방호대원","certLic":"섬유산업기사","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005615:1', '{"dJobCd":"K000005615","dJobCdSeq":"1","dJobNm":"조사교환원","workSum":"실을 제조하기 위해 정방기 크릴(Creel)에 걸려 있는 조사(Roving)를 교체한다.","doWork":"풀린 조사를 걷어 빈 운반차에 담아 일정장소에 옮겨 놓는다. 조사 운반차를 기계 옆으로 운반하고 조사를 크릴에 건다. 조사를 조사 로드와 트럼펫(Trumpet)을 거쳐 롤러 사이로 통과시켜 빈 보빈에 감는다. 일일 작업량을 일지에 기록한다. 작업량을 예측하여 물량을 신청하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"시범후 30일 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"투입인출","similarNm":"로빙교체원","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001284:1', '{"dJobCd":"K000001284","dJobCdSeq":"1","dJobNm":"조사도핑원","workSum":"조방공정에서 만관된 조사(Roving)를 떼어내고 빈 목관으로 교체한다.","doWork":"조방기계 사이를 순회하며 만관된 조사가 있는지 관찰한다. 만관된 조사는 기계를 정지하고 목관과 플라이어(Flyer)를 잠시 분리하여 조사가 감긴 목관을 빼내고 운반차에 적재한다. 빈 목관을 스핀들에 끼우고 조사의 끝을 목관 주위에 감아 플라이어를 재결합한 후 기계를 가동한다. 운반차에 담긴 만관된 조사 목관을 정방공정까지 운반하는 일을 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"투입인출","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006671:1', '{"dJobCd":"K000006671","dJobCdSeq":"1","dJobNm":"조사측정원","workSum":"소면·연조·조방공정에서 생산된 슬리버 및 조사견본들의 무게 차이를 알아보기 위해 시험기를 사용하여 측정한다.","doWork":"작업지시서를 확인하고 조사표준 및 시험방법을 숙지한다. 조사가 감긴 실패로부터 조사의 끝을 찾아 안내대를 지나 권취롤러에 꿴다. 측정기를 규정대로 맞추고 조사의 견본을 감기 위해 크랭크를 돌린다. 견본의 무게를 저울에 달아 도표에 기록한다. 생산된 조사의 각 부분의 무게를 그래프용지에 기록하고, 조사제조 공정상의 변화를 알아보기 위해 표준그래프와 비교한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"슬리버시험원, 조사시험원","certLic":"섬유산업기사, 섬유기능사","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003472:1', '{"dJobCd":"K000003472","dJobCdSeq":"1","dJobNm":"즐모반장","workSum":"모사제조공정 중 양모섬유를 빗질하여 단섬유, 넵(Nep), 잡물 등을 제거하는 길링(Gilling)기계를 다루는 데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"직업지시서를 숙지하고, 슬리버의 중량, 혼합비율에 필요한 가닥수 등에 따라 작업계획을 세운다. 작업계획에 따라 세부실행항목을 수립하고 작업절차 및 방법을 결정하여 작업원에게 작업내용을 지시하고 작업배치를 한다. 기계의 운전상황을 파악·기록·보고한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원 및 자재를 공급한다. 표준작업명세에 따라 지시된 작업이 이루어지는지 작업원과 함께 작업하며 작업상황을 관찰하며 작업내용을 점검한다. 작업의 진행사항을 파악하고 작업내용을 보고한다. 작업원의 직무교육 및 안전위생교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴·해결하고 문제점을 보완한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","similarNm":"길링반장","certLic":"섬유산업기사","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004807:1', '{"dJobCd":"K000004807","dJobCdSeq":"1","dJobNm":"즐모틀보기원","workSum":"모, 합성섬유 및 혼합 슬리버(Sliver)를 겹쳐서 뽑아내고 다음 공정을 위해 섬유를 평행으로 빗질하는 기계를 조작한다.","doWork":"물림대 위에 슬리버 뭉치를 놓거나 슬리버 통을 기계 공급장치에 배치한다. 폴러(Faller) 아래의 안내대와 롤러 사이로 슬리버를 통과시킨다. 기계를 시동하고 슬리버를 안내대를 통해 운반통에 담기게 하거나, 슬리버를 둥근 모양으로 감는 스핀들에 슬리버 끝을 감는다. 기계의 작동을 관찰하며 슬리버가 끊어진 곳을 찾아 손으로 서로 잇는다. 만관된 운반통이나 슬리버 뭉치를 새것으로 교체한다. 가공된 슬리버 뭉치나 통의 무게를 달아 기록한다. 생산된 슬리버의 품질을 알아보기 위해 견본의 무게를 달기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"길링기운전원, 즐모대지원","certLic":"섬유산업기사","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006777:1', '{"dJobCd":"K000006777","dJobCdSeq":"1","dJobNm":"진공정석기운전원","workSum":"비스코스, 셀롤로오스 등 인조견사의 재생반응에서 생성된 황산나트륨(Sodium Sulfate)을 제거하는 정석기를 운전한다.","doWork":"작업장비의 이상 유무를 점검한다. 비스코스레이온 제조공정에 사용되는 방사욕 속의 황산나트륨을 진공정석기에 넣고 작업표준에 의해 작업냉각수량, 압력 등을 입력하고 냉각시켜 결정을 석출시키고 분리·탈수하여 망초결정용액을 얻는다. 결정의 석출상태를 육안으로 점검한다. 얻어진 망초결정용액을 다음 공정으로 이송시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C205","dJobICdNm":"[C205]화학섬유 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006314:1', '{"dJobCd":"K000006314","dJobCdSeq":"1","dJobNm":"침지압착원","workSum":"알칼리 셀롤로오스를 만들기 위하여 일정 중량의 목재펄프를 담금압착기(Steeping Press)에 투입 후 규정농도의 수산화나트륨용액에서 침지시킨다.","doWork":"담금압착기에 담긴 규정농도의 가성소다용액에 일정 중량으로 평량된 목재펄프원지를 넣는다. 작업지시서에 지시된 적정 시간과 온도를 유지시켜 침지공정을 수행하여 알칼리 셀룰로오스를 만든다. 가성소다용액을 빼내고 펄프는 압착시킨 후 분쇄기에 투입한다. 완성된 알칼리 셀룰로오스는 다음 공정으로 이송시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"투입인출","similarNm":"담금압착기조작원","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C205","dJobICdNm":"[C205]화학섬유 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002573:1', '{"dJobCd":"K000002573","dJobCdSeq":"1","dJobNm":"칩건조원","workSum":"중합공정에서 제조한 칩(Chip)에 함유된 미반응물을 온수로 제거하고, 방사할 수 있도록 칩 내의 수분을 건조하여 저장조로 이송한다.","doWork":"칩의 생산량 및 장비를 확인·점검한다. 건조기로 이송한다. 표준서에 따라 추출탑의 온도, 온수의 공급량을 조절하고 일정량의 칩과 온수를 연속적으로 공급하여 미반응물을 추출한다. 원심탈수기를 이용하여 수분을 제거하고 건조기로 이송한다. 건조기의 온도를 점검·조절한다. 건조된 칩을 시험실에 품질검사 의뢰를 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"투입인출","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C205","dJobICdNm":"[C205]화학섬유 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004675:1', '{"dJobCd":"K000004675","dJobCdSeq":"1","dJobNm":"칩배급원","workSum":"중합공정에서 생산된 실의 원료인 칩(Chip)을 저장탱크에 투입·분배하고 유지한다.","doWork":"칩 저장탑(Chip Silo) 또는 저장탱크 내의 원료량을 확인하고 기록한다. 여러 개의 저장탱크에 균등하게 칩을 공급하고 공급량을 기록한다. 기계의 작동상황을 수시로 확인하고 작업의 위험요소를 미리 없앤다. 작업물량을 파악하고 기록대장에 기록한 후 생산일정을 조정할 수 있도록 담당자와 협의한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"투입인출","similarNm":"원료배급원, 칩투입원","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C205","dJobICdNm":"[C205]화학섬유 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003647:1', '{"dJobCd":"K000003647","dJobCdSeq":"1","dJobNm":"칩절단원","workSum":"중합공정에서 생산된 칩(Chip)을 일정 크기로 절단하고 저장탱크로 이송한다.","doWork":"작업 전 중합탑 하부의 노즐을 점검하고 청소한다. 냉각통에 냉각수를 투입하여 온도를 일정하게 유지한다. 절단할 칩의 종류, 굵기 및 크기에 맞춰 절단기의 속도를 조절하고 중합체를 투입하여 칩을 절단한다. 절단된 칩을 저장탱크로 이송한다. 기어펌프와 가동펌프의 가동속도를 점검한다. 절단된 칩의 굵기 및 크기를 점검하고 재조정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C205","dJobICdNm":"[C205]화학섬유 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005822:1', '{"dJobCd":"K000005822","dJobCdSeq":"1","dJobNm":"케이크세척원","workSum":"방사공정의 잔유물과 표백제를 제거하여 인견사를 윤이 나게 하는 설비를 조작한다.","doWork":"잔유물 또는 표백제 등을 제거하고자 관련 장비의 이상 유무를 파악하고 표백용액 등의 원료를 준비한다. 방사공정이 끝난 실의 타래 또는 케이크(Cake)를 세척 걸대에 건다. 세척 걸대를 세척기에 넣고 표백용액의 양과 흐름을 조절하고 제품의 가공상태를 점검한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|다습|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C205","dJobICdNm":"[C205]화학섬유 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002753:1', '{"dJobCd":"K000002753","dJobCdSeq":"1","dJobNm":"크램프고정원","workSum":"하이벌크사(High Bulk Yarns)에 사용되는 합성섬유 중 줄지 않는 섬유를 오그라지게 하여 고정하는 증기가열기계를 조작한다.","doWork":"호이스트(Hoist)를 사용하여 슬리버(Sliver) 통을 기계의 트랙 위에 올린다. 증기가열기계에 통과시켜 증기로 가압하고 슬리버 통 속의 온도를 온도계로 정기적으로 확인한다. 진공으로 건조시킨 슬리버를 호이스트를 사용하여 트랙에서 꺼내 송출시킨다. 슬리버의 건조상태를 점검한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"증기가열기조작원","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C205","dJobICdNm":"[C205]화학섬유 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006897:1', '{"dJobCd":"K000006897","dJobCdSeq":"1","dJobNm":"타래검사원","workSum":"오물이 묻거나 끊어진 실, 고르지 못한 염색이나 꼬임 등의 결점을 알아내기 위해 실타래를 검사한다.","doWork":"실타래를 펴기 위해 막대에 타래를 흔들어 걸고 결점을 찾아내기 위해 실을 펴서 잡아당긴다. 결점이 있는 부분을 잘라내고 실 끝을 서로 묶는다. 타래가 작업순서에 맞게 되어 있는지 알아내기 위해 타래의 감김과 연결을 조사한다. 각 타래의 무게를 계량하여 기록한다. 발견된 결함의 수효와 번호를 기록한다. 다발을 만들기 위해 보빈에 감아 연결한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002113:1', '{"dJobCd":"K000002113","dJobCdSeq":"1","dJobNm":"탄성사연사원","workSum":"탄성 실을 제조하기 위해 고무사나 합성섬유 실 주위에 한 가닥 이상의 또 다른 실을 꼬아 피복하는 기계를 조작한다.","doWork":"공급롤러와 분할장치에 고무사 또는 스판텍스사를 꿰고 물림대에 속실이나 고무사 콘(Cone)을 놓는다. 스핀들에 공급 실패를 놓고 실 끝을 장력장치와 가이드를 통하도록꿴 후 속실이나 고무사 또는 스판덱스사 끝을 권취 빔에 감는다. 너무 팽팽하거나 느슨하여 잘못 꼬이는 실이 없는지 기계작동을 관찰하며 멈춤 나사를 돌려 탄력성을 재조정한다. 공급 실이나 고무사가 다 되었으면 새것으로 교환하고, 끊어진 실을 잇는다. 기계를 정지하고 빈 권취고리를 물림대에 끼운다. 느슨하게 피복된 부분과 팽팽하게 피복된 부분을 비교하여 탄력성이 일정하게 유지되도록 탄력성을 조절하는 권취장치의 속도를 조절한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"커버링사제조원","certLic":"섬유산업기사","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006531:1', '{"dJobCd":"K000006531","dJobCdSeq":"1","dJobNm":"탄소섬유방사원","workSum":"탄소섬유를 제조하기 위해 탄소섬유 중합체를 방사하여 탄소섬유 전구체를 제조한다.","doWork":"탄소섬유의 원료(아크릴로니트릴, 석유계피치, 석탄계피치, 페놀수지, 셀룰로오스 등)를 선정한다. 원료 고분자를 중합하기 위하여 중합체 제조방법과 설비를 파악하고 결정한다. 중합조건을 선정하고 적용한다. 제조된 중합체의 물성을 파악하여 방사공정 적합 여부를 판단하고 조치한다. 탄소섬유 전구체를 제조하기 위하여 중합체 방사방법(습식방사, 건식방사, 용융방사, 전기방사 등)을 선정한다. 방사공정을 운용하여 탄소섬유 전구체(前驅體:Precursor)를 제조한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"위험내재|고온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C205","dJobICdNm":"[C205]화학섬유 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003561:1', '{"dJobCd":"K000003561","dJobCdSeq":"1","dJobNm":"탄소섬유소성원","workSum":"방사된 탄소섬유 전구체를 탄소화하여 탄소섬유를 제조한다.","doWork":"방사공정을 거쳐 제조된 탄소섬유 전구체(前驅體:Precursor)의 섬유 안정화공정을 운용한다. 안정화섬유(열처리에 의한 안정화·산화 상태 이전의 섬유)를 탄소섬유로 전환하는 섬유탄화설비(저온탄화, 고온탄화, 흑연화)를 운용하여 탄소섬유를 제조한다. 탄화섬유의 표면처리, 사이징 등 후처리 공정을 수행하여 제품을 생산한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"위험내재|고온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"탄화공정기술자","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C205","dJobICdNm":"[C205]화학섬유 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002788:1', '{"dJobCd":"K000002788","dJobCdSeq":"1","dJobNm":"텍스처가공기운전원","workSum":"실에 가소성(可塑性)을 첨가하고 촉감을 부여하기 위해 주름을 잡는 기계를 조작한다.","doWork":"작업지시서에 따라 가공할 실의 형태 및 공정 등을 파악하고 장비의 이상 유무를 파악한다. 축 위에 실꾸러미를 놓고 실의 끝을 유도장치, 급송롤러 등의 권축가공 부속장치(Crimping Attachment)안으로 들어가도록 연결하고 절단된 실이나 온도변화 등의 상태를 관찰한다. 끊어진 실은 손이나 매듭기로 잇는다. 텍스처가공기에서 실을 끌어내어 유도장치 사이에 넣고 권취장치에 연결한다. 권취가 완성된 실꾸러미를 내려놓고 다음 공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"주름기조작원","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C205","dJobICdNm":"[C205]화학섬유 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004538:1', '{"dJobCd":"K000004538","dJobCdSeq":"1","dJobNm":"팩실작업원","workSum":"필라멘트로 압출하기 전에 용융된 나일론, 폴리에스테론에서 불순물을 여과하기 위해 일정량의 메탈파우더를 방사구 팩(Pack)에 채운다.","doWork":"마이크로스코프(Microscope) 또는 전자현미경을 통하여 바닥 노즐의 이물, 마모, 파손 등을 검사한다. 조립지침에 따라 팩에 메탈파우더를 채우고 조립한다. 조립된 팩을 보온·예열시킨다. 예열된 팩을 분리하여 라인으로 이동 설치한다. 기 사용된 팩을 재사용할 수 있도록 종류별로 분해하여 약품처리, 물세척, 초음파로 세척한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C205","dJobICdNm":"[C205]화학섬유 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005401:1', '{"dJobCd":"K000005401","dJobCdSeq":"1","dJobNm":"합사원","workSum":"실 가닥을 꼬기 전에 두 가닥 이상의 실을 목관이나 지관에 감는 기계를 조작한다.","doWork":"크릴(Creel)에 공급 실 꾸러미를 놓고 실 끝을 모아 공급관을 통과시켜 권취 목관이나 지관에 꿴다. 기계를 시동하고 작동 중 실이 끊어진 곳이 없는지 조사한다. 끊어진 실을 매듭기(Knotter)나 손가락으로 잇는다. 공급 실이 다 되면 크릴에 공급 실 꾸러미를 갈아 끼운다. 목관이나 지관에 실이 다 감기면 목관이나 지관을 빼내고 교체한다. 기계를 점검하고 솔을 사용하여 청소하고 주유한다. 목관이나 지관을 운반하고 정리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"합사대지원, 합사틀보기원, 합사호대원","certLic":"섬유산업기사","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006163:1', '{"dJobCd":"K000006163","dJobCdSeq":"1","dJobNm":"합성스테이플방사원","workSum":"액체 중합체에서 연속으로 합성필라멘트를 만들고 지시된 형태에 따라 통에 토우(Tow)를 투입하는 기계를 조작한다.","doWork":"작업지시서를 보고 규격, 형태, 생산량 등을 확인한다. 공구를 사용하여 중합설비 속에 팩(Pack)을 설치하고 계량펌프를 조절하여 팩을 통해 투입되는 압축된 중합체의 양을 조절한다. 압축공기호스에 있는 압출된 단섬유를 잡고 아이드를 통하여 감는 장치로 필라멘트를 빠져 나가게 한다. 방사구에 있는 필라멘트를 분리하여 냉각튜브를 방사구에 끼운 다음 필라멘트를 냉각하기 위해 레버를 밀어 튜브를 통해 공기를 넣는다. 캔(Can) 속에 토우를 넣는 장치나 감기장치로 토우를 유도한다. 기계의 작동상태, 패널판, 게이지, 로터미터 등을 관찰한다. 중합체의 색상 등을 확인하고 지시서와 일치하지 않을 때는 관련 부서에 통보한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"인조스테이플방사원, 합성단섬유방사원","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C205","dJobICdNm":"[C205]화학섬유 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004739:1', '{"dJobCd":"K000004739","dJobCdSeq":"1","dJobNm":"합성필라멘트방사원","workSum":"액체 중합체에서 합성필라멘트를 압출하는 기계와 보조장비를 조작한다.","doWork":"작업지시서를 확인하고 생산할 합성필라멘트의 형태, 규격, 생산량을 확인한다. 기계 및 장비의 이상 유무를 확인하고 계량펌프로 투입되는 양과 유제공급롤러의 유량 등을 조절하여 방사구(Nozzle)와 가이드를 통해 끊어짐 없이 연속적으로 압출된 필라멘트사를 권취기에 끼워 권취시키고 권취작업상 문제가 되는 불량 필라멘트사를 찾아낸다. 장치의 문을 열고 가위를 사용해서 가이드에서 떨어진 필라멘트와 기계의 기어 둘레에 엉킨 필라멘트를 절단한다. 장치 안의 팬을 낮추고 팩을 통하여 중합체의 흐름이 멎을 때까지 녹은 필라멘트를 잡아낸다. 계량펌프를 가동하고 방사구 아래에서 압출되는 필라멘트를 잡아당긴다. 실리콘스프레이와 끌이나 패드 등을 사용하여 방사구와 장비에서 중합체 불순물을 제거한다. 결함이 발생될 때 작업을 중단하고 방사구 수리를 의뢰한다. 장시간 정비가 필요한 경우 정비 꼬리표에 고장의 유형을 표시하고 기계에 꼬리표를 부착한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"방사판넬원, 인조필라멘트방사원, 합성장섬유방사원","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C205","dJobICdNm":"[C205]화학섬유 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001858:1', '{"dJobCd":"K000001858","dJobCdSeq":"1","dJobNm":"합연기조작원","workSum":"망, 끈 및 밧줄제조에 사용되는 실을 합하여 꼬는 기계(합연기)를 다룬다.","doWork":"작업지시서를 확인하고 생산하는 밧줄의 특성에 따라 필요한 실의 굵기를 확인하다. 일정 굵기로 감긴 화섬사나 삼실(뽕나무로부터 얻은 실)을 작업대 크릴(Creel)에 꽂는다. 기계 하부의 스핀들에 규정된 크기의 비어 있는 보빈(Bobbin)을 꽂는다. 실패에서 실 끝을 찾아 안내대, 롤, 링, 트래블러(Traveller)를 거쳐 빈 보빈에 감는다. 스위치를 넣어 기계를 작동하고 기계를 순회하면서 스핀들의 회전불량이나 끊어진 실을 잇고 실이 가득 감긴 보빈을 뽑아낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"합연원","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C139","dJobICdNm":"[C139]기타 섬유제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003751:1', '{"dJobCd":"K000003751","dJobCdSeq":"1","dJobNm":"해사원","workSum":"실에 광택을 주고 균일도를 높이기 위해 왁스처리하는 해사기를 조작한다.","doWork":"실타래를 물레에 걸고 해사기의 상단걸이에 끼운다. 실 끝을 빼내어 해사기에 장착된 파라핀 왁스에 한 바퀴 감아서 롤러와 드럼을 통과시킨 후 빈 보빈에 감는다. 해사기의 조작스위치를 작동하고 해사상태를 관찰한다. 다 감긴 보빈을 새것과 교체한다. 실이 끊어질 경우 해사기의 레버를 올려 이어준다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"왁싱(Waxing)처리원","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C133","dJobICdNm":"[C133]편조원단 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004133:1', '{"dJobCd":"K000004133","dJobCdSeq":"1","dJobNm":"혼타면급면원","workSum":"압축된 원면을 개표실에서 일정 시간 방치하여 부풀어지면 불순물을 제거하고 손으로 뜯어서 일정량의 작은 덩어리로 만들어 혼타면기계의 컨베이어에 공급한다.","doWork":"솔을 사용하여 압축된 원면의 표면에 묻은 불순물을 제거한다. 원면과 재활용면을 적당량씩 손으로 뜯어서 나누고 혼타면기계의 재료 이송 컨베이어에 공급한다. 섬유에 섞여 있는 잡물들을 골라내어 제거한다. 기계 주위를 청소하거나 재료 이송 컨베이어에 달라붙은 섬유를 제거하여 기계의 작동을 원활히 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"투입인출","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002110:1', '{"dJobCd":"K000002110","dJobCdSeq":"1","dJobNm":"혼타면반장","workSum":"실을 제조하기 위해 합성섬유와 기타 자연섬유를 혼합하고 불순물을 제거하여 두께와 폭이 균일한 랩(Lap)을 만드는 데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"주문명세서를 확인하고 규정된 대로 섬유를 섞기 위해 작업지시서에 따라 분량표를 선택하거나 준비한다. 작업원에게 가공을 위해 분량표를 나누어 주고 작업계획에 의해 작업내용을 지시한다. 다음 공정의 원료공급관계를 확인하기 위해 타 부서와 연락한다. 작업내용을 감독하고 생산된 랩의 품질과 부산물의 제거상태, 균제도, 중량을 확인하고 수정하도록 작업원에게 지시한다. 기계와 장비의 설치 및 수리를 지도한다. 가공되지 않은 섬유원료를 분류하고, 중량을 달고, 혼합하고, 꾸리는 작업을 작업원에게 훈련시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","certLic":"섬유산업기사","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004439:1', '{"dJobCd":"K000004439","dJobCdSeq":"1","dJobNm":"혼타면틀보기원","workSum":"압축된 면이나 합성섬유를 풀어서 깨끗이 하고 부풀리고 혼합하여 랩(Lap)으로 만드는 기계를 조작한다.","doWork":"작업지시서에 따라 원면의 종류와 혼면의 혼합비율을 정하고 컨베이어에 놓은 섬유의 공급량을 조절하기 위해 자동 공급장치의 슬라이딩(Sliding) 평행 추를 조정한다. 랩(Lap)의 무게와 길이, 기계의 속도를 조절하기 위해 레버를 조작한다. 재료가 기계에 막히지 않도록 기계에 재료가 공급될 때 컨베이어를 관찰하고 컨베이어 속도를 조절한다. 자동 공급장치를 열어 섬유를 기계 속으로 공급하고 섬유가공 상태를 송면관을 통해 관찰하며 비터(Beater)에 엉킨 섬유를 손이나 공구를 사용하여 비터로부터 떼어낸다. 권취 위치에 핀을 끼워 넣고 랩의 끝을 핀에 감는다. 기계에서 랩이 감긴 롤을 빼내 무게를 달아 기록하고 이동 손수레에 옮긴 다음 랩이 감겼던 핀을 빼낸다. 롤 형태로 된 랩을 섬유가 흩어지지 않도록 포장한다. 랩의 표면에 보풀이 일지 않도록 하기 위해 탱크에 수지혼합물을 공급하고 스프레이를 작동하여 적당한 수분을 공급하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"혼타면대지원, 혼타면도핑원, 혼타면호대원","certLic":"섬유산업기사","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003863:1', '{"dJobCd":"K000003863","dJobCdSeq":"1","dJobNm":"후처리반장","workSum":"제조된 폴리에스테르사, 나이론사 등을 정련·세척·포장·검사하는 데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"제조된 합성섬유의 생산량을 파악하고 생산부서와 연락하여 재료의 수급을 조절한다. 검사목록 등에 따라 선별검사, 포장 등의 작업계획을 수립하고 작업절차 및 방법을 결정하며 작업내용에 따라 작업원에게 작업내용을 지시하고 작업을 배치한다. 작업원의 작업상황을 관리·감독하고 작업에 관련된 지도, 조언 및 직무교육과 안전위생교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴·해결하고 문제점을 보완한다. 진행사항 및 작업내용을 기록하고 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","dJobECd":"8611","dJobECdNm":"[8611]섬유 제조기계 조작원","dJobJCd":"8211","dJobJCdNm":"[8211]섬유 제조 기계 조작원","dJobICd":"C205","dJobICdNm":"[C205]화학섬유 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003506:1', '{"dJobCd":"K000003506","dJobCdSeq":"1","dJobNm":"날염물검사원","workSum":"얼룩, 오염, 불규칙한 색조 등의 결함에 대하여 날염 작업과정 또는 증열, 수세, 건조 후 날염 등을 검사한다.","doWork":"날염 제품별 도안을 확인한다. 날염기에서 나오는 또는 증열, 수세 건조된 날염물을 관찰하고 결함을 조사한다. 도안의 색조 및 위치를 확인하기 위해 날염된 천을 견본 규격과 비교한다. 발견된 결함을 기록표에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"염색기능사(날염)","dJobECd":"8613","dJobECdNm":"[8613]표백·염색기 조작원","dJobJCd":"8212","dJobJCdNm":"[8212]표백 및 염색 관련 기계 조작원","dJobICd":"C134","dJobICdNm":"[C134]섬유제품 염색, 정리 및 마무리 가공업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002382:1', '{"dJobCd":"K000002382","dJobCdSeq":"1","dJobNm":"날염판제작원","workSum":"형틀과 날염용 스크린(Screen)을 접착하여 날염용 형틀을 제작한다.","doWork":"디자인된 도안을 OHP필름에 복사한다. 솔이나 분무기를 이용하여 형틀 위의 스크린에 감광액을 균일하게 칠하여 바른 후 건조한다. 감광대 위에 작업된 OHP필름을 올려놓고 스크린판을 밀착시켜 감광한다. 물호스와 스프레이를 이용하여 필요없는 부분을 세척하여 제거한다. 날염무늬가 완성되면 연속날염을 할 수 있도록 수지를 칠하여 막을 보강한다. 제판이 완료되면 원하는 색도와 무늬가 이루어졌는지 종이 위에 인쇄하여 검사한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"나염판제작원, 사제작원, 스크린제작원, 제판원","certLic":"염색기능사(날염)","dJobECd":"8613","dJobECdNm":"[8613]표백·염색기 조작원","dJobJCd":"8212","dJobJCdNm":"[8212]표백 및 염색 관련 기계 조작원","dJobICd":"C134","dJobICdNm":"[C134]섬유제품 염색, 정리 및 마무리 가공업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003764:1', '{"dJobCd":"K000003764","dJobCdSeq":"1","dJobNm":"날염호조액원","workSum":"날염에 사용되는 날염호를 제조하고자 염료와 조제를 계량하고 조액한다.","doWork":"작업지시서를 확인하고 일정량의 염료나 안료를 계량한다. 혼합기를 사용하여 염료와 함께 고점도의 풀인 원호와 염료수 용액을 첨가하여 혼합하고 여과포나 여과장치를 사용하여 덩어리와 이물질을 제거한다. 피염물에 날염호를 바르고 표준색과 비교한다. 제시된 색상과 차이가 발생하면 염료와 원호를 이용하여 색상을 수정한다. 염료의 혼합·여과과정을 자동으로 처리하는 장비를 조작하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"염색기능사(날염)","dJobECd":"8613","dJobECdNm":"[8613]표백·염색기 조작원","dJobJCd":"8212","dJobJCdNm":"[8212]표백 및 염색 관련 기계 조작원","dJobICd":"C134","dJobICdNm":"[C134]섬유제품 염색, 정리 및 마무리 가공업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006403:1', '{"dJobCd":"K000006403","dJobCdSeq":"1","dJobNm":"디지털텍스타일염색원","workSum":"문양(디지털이미지) 디자인에 따라 원단을 디지털 프린팅하는 디지털장비를 조작한다.","doWork":"원단 소재 특성에 따라 전처리 조제 종류 및 사용량을 설정하고 전처리기의 장력, 온도 등 처리조건을 설정한다. 전치리된 원단의 도포상태를 확인하고 불량 발생 시 처리하기도 한다. 문양 디자인, 원단 소재에 따라 프린팅 장비 및 방법을 선정한다. 컬러매칭 데이터를 적용한 견본테스트를 수행하고 원시료와의 색상을 비교하여 색차를 보정한다. 디지털프린팅 장비의 작동상태 및 원단의 프린팅상태를 확인한다. 원단 소재 특성에 따라 증열, 수세, 건조, 전사 등 후처리공정을 작업하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"DTP염색원, 디지털텍스타일프린팅기조작원","certLic":"섬유산업기사","dJobECd":"8613","dJobECdNm":"[8613]표백·염색기 조작원","dJobJCd":"8212","dJobJCdNm":"[8212]표백 및 염색 관련 기계 조작원","dJobICd":"C134","dJobICdNm":"[C134]섬유제품 염색, 정리 및 마무리 가공업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004328:1', '{"dJobCd":"K000004328","dJobCdSeq":"1","dJobNm":"로터리스크린날염기운전원","workSum":"직편물 등에 도안을 날염하는 로터리날염기를 조작한다.","doWork":"날염될 도안무늬의 로터리를 준비한다. 각각의 색깔이 도안에 정해진 간격에 따라 날염되도록 롤러의 위치를 조정한다. 도안 및 천의 형태에 따라 기계의 속도를 조절하고 롤러의 압력을 조정하는 손잡이를 돌린다. 날염용 페이스트를 롤러로 투입하는 밸브를 조절한다. 날염롤러 밑으로 직물을 운반하는 기계 및 컨베이어 벨트를 작동한다. 날염상태를 점검한다. 날염용 페이스트의 불규칙한 흐름을 방지하기 위하여 롤러로부터 이물질을 제거한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"염색기능사(날염)","dJobECd":"8613","dJobECdNm":"[8613]표백·염색기 조작원","dJobJCd":"8212","dJobJCdNm":"[8212]표백 및 염색 관련 기계 조작원","dJobICd":"C134","dJobICdNm":"[C134]섬유제품 염색, 정리 및 마무리 가공업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001920:1', '{"dJobCd":"K000001920","dJobCdSeq":"1","dJobNm":"롤러날염기운전원","workSum":"직편물 등에 도안을 날염하는 기계를 설치하고 조작한다.","doWork":"직물 및 염료의 종류에 따라 수동바퀴를 돌려 롤러의 압력을 조절한다. 나사를 돌려 기계에 있는 정합마크를 날염롤러에 있는 정합마크에 정렬한다. 날염롤러에 물감을 공급하고자 염료통을 점검한다. 얼룩이 생기거나 정합에서 벗어난 도안 등의 날염결함 여부를 확인하고자 이동 중인 직물을 자세히 검사한다. 날염롤러를 재정돈하고 날염롤러로부터 과도한 색을 흡수하는 브래킷 및 받침천의 위치를 조절한다. 날염된 제품을 명세표와 비교 검사하여 색상이 다를 경우 롤러날염반장에게 통보한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"염색기능사(날염)","dJobECd":"8613","dJobECdNm":"[8613]표백·염색기 조작원","dJobJCd":"8212","dJobJCdNm":"[8212]표백 및 염색 관련 기계 조작원","dJobICd":"C134","dJobICdNm":"[C134]섬유제품 염색, 정리 및 마무리 가공업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001348:1', '{"dJobCd":"K000001348","dJobCdSeq":"1","dJobNm":"롤러날염반장","workSum":"천에 롤러 날염작업을 하는 데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"날염롤러와 색의 변화에 대해 날염장비를 검사한다. 작업계획에 따라 세부실행항목을 수립하여 작업절차 및 방법을 결정한 후 작업원이 효율적으로 작업할 수 있도록 적당한 위치에 배정하고 작업내용을 작업원에게 지시한다. 작업진행상황을 파악하고 작업내용을 보고한다. 작업원의 작업상황을 관리·감독하고 작업공정에 있어 필요한 자재지원 및 기술을 지원한다. 작업원과 함께 작업하며 작업상황을 관찰하고 작업내용을 점검하기도 한다. 작업원에 대한 직무교육 및 안전위생교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시로 관찰과 면담을 통하여 작업원의 애로 및 건의사항을 수렴·해결하고 문제점을 보고한다. 명세표와 일치하는지를 확인하기 위해 날염된 천의 견본과 표준을 비교한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"수동조작","certLic":"염색기능사(날염), 염색기능사(침염)","dJobECd":"8613","dJobECdNm":"[8613]표백·염색기 조작원","dJobJCd":"8212","dJobJCdNm":"[8212]표백 및 염색 관련 기계 조작원","dJobICd":"C134","dJobICdNm":"[C134]섬유제품 염색, 정리 및 마무리 가공업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006400:1', '{"dJobCd":"K000006400","dJobCdSeq":"1","dJobNm":"머서가공기운전원","workSum":"직편물이나 실의 광택, 형태안정성, 염색성의 향상 및 강도를 증가시키는 머서가공기를 운전한다.","doWork":"기계 위에 루프상태의 직물 두루마리를 준비한다. 이동식 재봉틀을 사용하여 기계의 안내천(Leader Cloth)에 끝단을 꿰맨다. 탱크 안에 가성소다용액이 들어가도록 밸브를 돌린다. 직물이 비눗물 분무기를 통과하는 동안 수축 되지 않도록 텐터기틀의 클립을 조절하는 수동바퀴를 조절한다. 작업지시서에 따라 온도, 시간 등을 조절하여 기계를 작동하고 천의 흐름을 관찰한다. 파손된 부분을 잘라내고 잇는다. 기계의 회전속도를 맞추기 위해 조정판의 손잡이를 조절한다. 배수 후에 탱크 안을 세척한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|고온|다습|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"머서광택원, 머서라이징원, 실켓가공원","certLic":"염색기능사(날염), 염색기능사(침염)","dJobECd":"8613","dJobECdNm":"[8613]표백·염색기 조작원","dJobJCd":"8212","dJobJCdNm":"[8212]표백 및 염색 관련 기계 조작원","dJobICd":"C134","dJobICdNm":"[C134]섬유제품 염색, 정리 및 마무리 가공업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005419:1', '{"dJobCd":"K000005419","dJobCdSeq":"1","dJobNm":"모피염색원","workSum":"모피털에 다양한 색상을 주기 위해 모피를 염색한다.","doWork":"염색이 용이하고 균일하게 되도록 털에 묻은 불순물을 제거한다. 크롬염, 철염, 구리염 등의 점착제가 담긴 통에 모피를 일정 시간 넣어 염색친화력을 높인다. 견본색상을 확인하고 색상에 맞는 염료를 사용하여 염액을 제조한다. 모피와 염료의 종류에 따라 온도 및 시간을 조절하여 모피를 염색한다. 염색 후 털에 잔류하고 있는 염료를 제거한다. 고온으로 염색하는 경우 크롬태닝공정을 수행하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|고온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"모피프린트원","certLic":"염색기능사(침염)","dJobECd":"8613","dJobECdNm":"[8613]표백·염색기 조작원","dJobJCd":"8212","dJobJCdNm":"[8212]표백 및 염색 관련 기계 조작원","dJobICd":"C142","dJobICdNm":"[C142]모피제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003205:1', '{"dJobCd":"K000003205","dJobCdSeq":"1","dJobNm":"섬유얼룩세척원","workSum":"세탁제나 비눗물을 사용하여 천의 얼룩이나 오염된 부분을 세척한다.","doWork":"검사공정에서 표시된 얼룩이나 기타 천의 얼룩진 부분을 찾아낸다. 세탁제나 비눗물을 적신 스펀지나 천으로 얼룩진 부분을 닦아낸다. 깨끗한 물로 적신 천을 사용하여 세척제나 비눗물을 제거한다. 세탁한 부위에 얼룩이 발생하지 않도록 하기 위해 고온증기로 건조한다. 분무기를 사용하여 오염된 부분을 세척하기도 한다. 세척한 천에 품목표를 부착하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|고온|다습|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8613","dJobECdNm":"[8613]표백·염색기 조작원","dJobJCd":"8212","dJobJCdNm":"[8212]표백 및 염색 관련 기계 조작원","dJobICd":"C132/C134","dJobICdNm":"[C132]직물직조 및 직물제품 제조업 / [C134]섬유제품 염색, 정리 및 마무리 가공업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004396:1', '{"dJobCd":"K000004396","dJobCdSeq":"1","dJobNm":"세융가공원","workSum":"모직물의 오염된 기름때, 불순물 등을 제거하기 위해 세탁·헹굼·건조하는 정련기를 조작한다.","doWork":"재봉틀을 사용하여 천의 두루마리 끝단을 서로 연결한다. 연결한 천을 얼레, 유도장치, 급송롤러 사이를 통과시켜 정련기에 투입한다. 명세서에 따라 정련기에 물과 조제용액을 투입한다. 온도, 압력, 수위 등의 작동상태를 확인하고 기계를 가동한다. 정해진 시간동안 모직물이 얼레 위와 용액 사이를 회전하는 상태를 관찰한다. 통의 용액을 배수하고 헹구기 위한 물을 투입한다. 헹굼 처리한 후 천의 단을 분리한다. 천의 끝단을 감대 위에 걸쳐놓고 손수레까지 천을 이동한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"로프정련기운전원, 오픈정련기운전원","dJobECd":"8613","dJobECdNm":"[8613]표백·염색기 조작원","dJobJCd":"8212","dJobJCdNm":"[8212]표백 및 염색 관련 기계 조작원","dJobICd":"C134","dJobICdNm":"[C134]섬유제품 염색, 정리 및 마무리 가공업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004029:1', '{"dJobCd":"K000004029","dJobCdSeq":"1","dJobNm":"수지가공조액원","workSum":"직물의 수지처리나 방수처리 등에 사용되는 각종 합성물을 제조하기 위해 교반기, 이동혼합기 등 관련 장비를 조작한다.","doWork":"조제방법에 따라서 기름, 안료, 가소제, 수지, 안정제, 충전제, 색소농축물, 물 등의 재료를 계량한다. 계량된 재료를 혼합탱크에 투입한 후 교반기를 작동한다. 혼합된 재료들을 저장탱크 또는 드럼통으로 배출한다. 조제가 완료된 후 금속주걱과 솔벤트를 이용하여 혼합기를 청소한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|다습|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"염색기능사(날염), 염색기능사(침엽)","dJobECd":"8613","dJobECdNm":"[8613]표백·염색기 조작원","dJobJCd":"8212","dJobJCdNm":"[8212]표백 및 염색 관련 기계 조작원","dJobICd":"C134","dJobICdNm":"[C134]섬유제품 염색, 정리 및 마무리 가공업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006032:1', '{"dJobCd":"K000006032","dJobCdSeq":"1","dJobNm":"약품조액원","workSum":"면직물, 모직물, 실 등의 탈호, 정련, 표백, 머서가공(Mercerization) 등의 작업에 사용하는 화공약품을 조액·혼합한다.","doWork":"과산화물, 부식제, 유제, 수지 등의 원료를 규정된 비율에 따라 계량한다. 혼합탱크 안에 물을 넣고 투입량을 기록한다. 혼합기를 작동하고 계량한 원료를 투입하여 일정 시간 혼합한다. 밸브를 돌려 저장탱크나 가공탱크로 이송한다. 탱크의 용액을 액체비중계, 점성도계 등을 사용하여 시험하거나 표준품과의 차이를 알아보기 위해 적정시험을 하여 용액이 표준농도가 되도록 적당한 성분을 더 첨가한다. 시험결과와 혼합에 사용한 화공약품과 혼합용액의 양을 생산목록과 재고목록에 기록한다. 성분을 용해하기 위해 증기를 투입하거나 일정 농도가 되도록 열을 가하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|다습|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"염색기능사(날염), 염색기능사(침염), 섬유산업기사","dJobECd":"8613","dJobECdNm":"[8613]표백·염색기 조작원","dJobJCd":"8212","dJobJCdNm":"[8212]표백 및 염색 관련 기계 조작원","dJobICd":"C134","dJobICdNm":"[C134]섬유제품 염색, 정리 및 마무리 가공업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006741:1', '{"dJobCd":"K000006741","dJobCdSeq":"1","dJobNm":"연속염색기운전원","workSum":"천을 염색하고 건조하는 연속 기계설비를 조작한다.","doWork":"생산품목의 지시된 색상과 수량이 염색처방 및 작업공정과 일치하는지 작업카드를 확인한다. 기계의 공급대에 직물수레차를 배치하거나 동력호이스트를 사용하여 천 두루마리를 설치한다. 천을 롤러에 투입하거나 기계의 안내천(Leader Cloth)에 끝단을 연결한다. 옷감 안내 장치를 조절하는 수동휠을 돌린다. 건조 상자의 고온증기를 조절하고 패딩기계의 염료온도를 조절한다. 기계를 작동하고 제어판을 점검하여 기계의 회전속도를 조절한다. 생산과정, 품목 수, 가동시간, 천의 길이 등을 작업표에 기록한다. 염료패드에서 사용한 염료를 폐수처리장으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"직물염색원","certLic":"염색기능사(날염), 염색기능사(침염)","dJobECd":"8613","dJobECdNm":"[8613]표백·염색기 조작원","dJobJCd":"8212","dJobJCdNm":"[8212]표백 및 염색 관련 기계 조작원","dJobICd":"C134","dJobICdNm":"[C134]섬유제품 염색, 정리 및 마무리 가공업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005898:1', '{"dJobCd":"K000005898","dJobCdSeq":"1","dJobNm":"염료조액원","workSum":"실, 직물, 의류 같은 제품을 염색하기 위해 견본 색상에 맞춰 염료 및 화학약품을 혼합한다.","doWork":"견본 색상을 살펴보고 동일한 색상의 천이나 실의 처방지를 찾는다. 처방지에 따라 일정량의 분말염료와 액체염료, 화학약품의 무게를 달아서 나눈다. 혼합탱크에 약품을 넣고 일정 비율로 물을 투입한다. 염료를 용해하기 위해 막대기로 젓거나 증기를 투입한다. 용해된 염료를 견본의 색상과 비교하고 염색 실의 공급탱크로 이송한다. 염료와 화공약품의 목록을 만든다. 물호스를 사용하여 혼합탱크를 청소한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|다습|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"염료혼합원","certLic":"염색기능사(날염), 염색기능사(침염)","dJobECd":"8613","dJobECdNm":"[8613]표백·염색기 조작원","dJobJCd":"8212","dJobJCdNm":"[8212]표백 및 염색 관련 기계 조작원","dJobICd":"C134","dJobICdNm":"[C134]섬유제품 염색, 정리 및 마무리 가공업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005051:1', '{"dJobCd":"K000005051","dJobCdSeq":"1","dJobNm":"염색반장","workSum":"실, 직편물을 염색하는 일에 종사하는 작업원의 활동을 감독·조정한다.","doWork":"표준색깔카드와 고객의 견본을 비교한다. 표준작업명세에 따라 작업계획을 수립한다. 작업계획에 따라 세부실행항목을 수립하고 작업절차 및 방법을 결정하여 작업원에게 작업내용을 지시하고 작업배치를 한다. 각 공정에 필요한 염색물감과 재료들을 청구한다. 작업의 진행사항을 파악하고 작업내용을 보고한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원 및 자재를 공급한다. 지시된 작업이 이루어지는지 작업원과 함께 작업하며 작업상황을 관찰하며 작업내용을 점검한다. 작업원의 직무교육 및 안전위생교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴·해결하고 문제점을 보완한다. 염색된 생산품과 견본을 비교하여 규정대로 처리되었는지 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","similarNm":"포염반장","connectJob":"염료실반장","certLic":"염색기능사(날염), 염색기능사(침염),","dJobECd":"8613","dJobECdNm":"[8613]표백·염색기 조작원","dJobJCd":"8212","dJobJCdNm":"[8212]표백 및 염색 관련 기계 조작원","dJobICd":"C134","dJobICdNm":"[C134]섬유제품 염색, 정리 및 마무리 가공업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004994:1', '{"dJobCd":"K000004994","dJobCdSeq":"1","dJobNm":"원단개폭원","workSum":"탈수가 완료된 원단을 일정하게 자른다.","doWork":"탈수가 완료된 원단을 받아온다. 작업지시서에 의하여 일정한 폭, 무늬에 따라 개폭기 롤러에 원단을 끼운다. 개폭기를 작동시키고 잘리는 것을 관찰한다. 원단이 규격대로 절단되었는지 확인한 후, 잘린 원단을 개폭기에서 빼내어 밀차에 싣고 건조공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"시범후 30일 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","dJobECd":"8613","dJobECdNm":"[8613]표백·염색기 조작원","dJobJCd":"8212","dJobJCdNm":"[8212]표백 및 염색 관련 기계 조작원","dJobICd":"C134","dJobICdNm":"[C134]섬유제품 염색, 정리 및 마무리 가공업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005234:1', '{"dJobCd":"K000005234","dJobCdSeq":"1","dJobNm":"원단세척원","workSum":"가공하기 전에 원단을 세척하고자 세척기를 조작한다.","doWork":"원단 끝부분을 세척기의 상단 롤러에 걸고 작동하여 세척기 안에 원단을 넣는다. 세척기에 연결된 밸브를 열어 일정량의 물을 투입한다. 세척기를 작동하고 일정 기간이 지난 후 원단이 배출구의 수레에 제대로 담겨지는지 확인한다. 원단이 담긴 수레를 밀어 탈수기 앞으로 이송한다. 탈수기를 조작하여 세척된 원단을 탈수하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|다습|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"소핑기조작원","certLic":"섬유산업기사","dJobECd":"8613","dJobECdNm":"[8613]표백·염색기 조작원","dJobJCd":"8212","dJobJCdNm":"[8212]표백 및 염색 관련 기계 조작원","dJobICd":"C134","dJobICdNm":"[C134]섬유제품 염색, 정리 및 마무리 가공업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001864:1', '{"dJobCd":"K000001864","dJobCdSeq":"1","dJobNm":"원단접착기조작원","workSum":"접착심지 등 의류 부자재를 생산하고자 원단을 접착하는 기계를 조작한다.","doWork":"접착기의 호퍼(Hopper:분립체의 저장 및 공급장치)에 분말형 접착제를 적정량만큼 투입한다. 접착하는 원단의 특성에 따라 접착기의 조정판에 적정한 속도, 온도, 장력 등을 입력한다. 원단이 접착기 입구 롤에 제대로 걸려 있는지 확인하고 접착기를 가동한다. 접착이 완료된 원단의 접착상태와 열 수축 상태를 육안으로 검사한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8613","dJobECdNm":"[8613]표백·염색기 조작원","dJobJCd":"8212","dJobJCdNm":"[8212]표백 및 염색 관련 기계 조작원","dJobICd":"C134","dJobICdNm":"[C134]섬유제품 염색, 정리 및 마무리 가공업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007057:1', '{"dJobCd":"K000007057","dJobCdSeq":"1","dJobNm":"원단탈수원","workSum":"세척이 완료된 원단을 탈수하고자 탈수기를 조작한다.","doWork":"세척공정으로부터 이송된 원단 수레에서 원단을 빼낸다. 롤러에 원단을 걸고 작동하여 원심분리탈수기에 원단을 집어넣는다. 탈수시간을 입력한 후 탈수기를 가동한다. 일정 시간 후 탈수가 끝나면 탈수기에서 원단을 빼내어 수레에 담는다. 개폭공정으로 이송한다. 탈수기에 접착수지 등을 넣고 염색된 어망을 탈수하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|다습|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"어망탈수원","certLic":"섬유산업기사","dJobECd":"8613","dJobECdNm":"[8613]표백·염색기 조작원","dJobJCd":"8212","dJobJCdNm":"[8212]표백 및 염색 관련 기계 조작원","dJobICd":"C134","dJobICdNm":"[C134]섬유제품 염색, 정리 및 마무리 가공업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003026:1', '{"dJobCd":"K000003026","dJobCdSeq":"1","dJobNm":"윈치염색원","workSum":"로프 형태의 천을 염색·세척하는 기계를 조작한다.","doWork":"작업표준 및 견본을 보고 염욕의 농도, 온도 및 시간을 정한다. 천을 계속 가공하기 위해 재봉틀을 사용하여 끝단을 연결한다. 직물의 중량을 염료조액원에게 통보한다. 염색기 위로 천을 올린다. 염료 및 조제를 혼합하여 염액을 만들어 염색기에 투입한다. 기계를 가동하고 염색 가공 상태를 관찰한다. 가공이 완료되면 견본을 잘라 표준색상과 비교·확인한다. 헹굼 처리가 완료되면 연결한 끝단을 푼다. 견본천이 표준색상과 일치하지 않을 때는 염료조액원과 상의하여 염료를 추가하거나 조제를 첨가하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|고온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"릴염색원","dJobECd":"8613","dJobECdNm":"[8613]표백·염색기 조작원","dJobJCd":"8212","dJobJCdNm":"[8212]표백 및 염색 관련 기계 조작원","dJobICd":"C134","dJobICdNm":"[C134]섬유제품 염색, 정리 및 마무리 가공업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001800:1', '{"dJobCd":"K000001800","dJobCdSeq":"1","dJobNm":"융단건조기조작원","workSum":"염색처리가 끝난 융단을 건조하는 기계를 조작한다.","doWork":"기계의 선반 위에 호이스트로 축축한 두루마리형 융단을 걸고 융단의 끝을 건조기에 맞춘다. 규정된 온도가 유지되도록 적외선이나 가스난방기의 스위치를 조정한다. 기계를 작동하고 건조 처리되어 나오는 융단을 손으로 만져보아 건조 상태를 확인하고 권취롤에 감는다. 건조 처리된 융단을 정필기에 통과시키기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"시범후 30일 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"고온|다습|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","similarNm":"융단건조원","connectJob":"카펫건조원, 러그건조원","dJobECd":"8613","dJobECdNm":"[8613]표백·염색기 조작원","dJobJCd":"8212","dJobJCdNm":"[8212]표백 및 염색 관련 기계 조작원","dJobICd":"C139","dJobICdNm":"[C139]기타 섬유제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002552:1', '{"dJobCd":"K000002552","dJobCdSeq":"1","dJobNm":"자동스크린날염기운전원","workSum":"직물에 다색도안을 날염하는 자동스크린날염기를 조작한다.","doWork":"디자인된 도안을 확인한다. 인쇄도수에 따라 소요되는 색상을 파악하고 인쇄용 페이스트를 준비한다. 각각의 색상이 지정된 간격으로 날염되도록 스크린의 위치를 조정하는 나사를 돌려 장치한다. 날염용 페이스트의 고르지 못한 흐름을 방지하고자 스크린에서 이물질을 제거한다. 스크린 위에 인쇄용 페이스트를 붓거나 자동 이송팬을 채운다. 기계의 속도를 조절하고 인쇄할 도안과 천의 형태에 따라 수동공구를 사용하여 고무롤러의 진동 및 압력을 조정한다. 스크린 밑으로 직물을 이송하는 기계와 컨베이어 벨트의 시동을 건다. 날염이 되는 과정을 관찰한다. 이상이 있을 경우 작동을 멈추고 조치를 취한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"염색기능사(날염)","dJobECd":"8613","dJobECdNm":"[8613]표백·염색기 조작원","dJobJCd":"8212","dJobJCdNm":"[8212]표백 및 염색 관련 기계 조작원","dJobICd":"C134","dJobICdNm":"[C134]섬유제품 염색, 정리 및 마무리 가공업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005840:1', '{"dJobCd":"K000005840","dJobCdSeq":"1","dJobNm":"전융가공원","workSum":"모직물에 압력을 가해 표면을 평활하게 하고 광택을 부여하는 기계(Paper Pressing Machine)를 다룬다.","doWork":"직물 적재 수레를 기계공급대 앞에 배치하고 광택지를 준비한다. 직물의 끝단을 직물 접철장치에 투입하고 그 아래에 압착대를 준비한다. 회전 접철장치를 가동하고 천이 접어지는 사이에 광택지를 삽입한다. 천이 접어진 압착대를 프레스 아래에 배치하고 광택지에 전원을 공급한다. 프레스를 가동한다. 작업이 완료된 직물표면을 검사하고 다음 공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8613","dJobECdNm":"[8613]표백·염색기 조작원","dJobJCd":"8212","dJobJCdNm":"[8212]표백 및 염색 관련 기계 조작원","dJobICd":"C134","dJobICdNm":"[C134]섬유제품 염색, 정리 및 마무리 가공업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003565:1', '{"dJobCd":"K000003565","dJobCdSeq":"1","dJobNm":"정련기운전원","workSum":"원단의 기름, 먼지, 호제, 때 등의 이물질을 제거하는 기계를 운전한다.","doWork":"표준작업명세서의 천의 품목별 가동시간, 온도, 압력 및 조제의 종류 등을 확인한다. 정련기에 원단을 투입한다. 물과 조제를 투입하고 일정한 온도, 압력 및 수위를 유지하고자 각종 계기를 조절한다. 작업이 완료되면 내부압력을 제거하고 냉수를 공급하여 수세한 후 물을 배출한다. 원단을 꺼낸 후 천의 품목, 기계가동시간, 공정처리시간 및 길이를 품목표에 기록한다. 염색·정련된 천이나 실의 수축률을 측정하고 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"페퍼프레스원","dJobECd":"8613","dJobECdNm":"[8613]표백·염색기 조작원","dJobJCd":"8212","dJobJCdNm":"[8212]표백 및 염색 관련 기계 조작원","dJobICd":"C134","dJobICdNm":"[C134]섬유제품 염색, 정리 및 마무리 가공업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006264:1', '{"dJobCd":"K000006264","dJobCdSeq":"1","dJobNm":"제트염색원","workSum":"압력을 가하여 천을 염색하는 기계를 조작한다.","doWork":"연속가공을 위하여 재봉틀을 사용하여 천의 끝단을 서로 연결한다. 염색통에 정해진 비율로 물, 증기, 화학제 등을 투입한다. 감대 위에 있는 염색·헹굼 조정 장치판의 가동단추를 누른다. 오동작이 없도록 조정 장치판을 살펴본다. 공정회로 끝에서 천을 끌어 내리기 위한 감대를 가동한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|다습|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"염색기능사(날염), 염색기능사(침염)","dJobECd":"8613","dJobECdNm":"[8613]표백·염색기 조작원","dJobJCd":"8212","dJobJCdNm":"[8212]표백 및 염색 관련 기계 조작원","dJobICd":"C134","dJobICdNm":"[C134]섬유제품 염색, 정리 및 마무리 가공업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004072:1', '{"dJobCd":"K000004072","dJobCdSeq":"1","dJobNm":"증열원","workSum":"증기와 고온 공기를 사용하여 편물의류의 주름을 제거하는 기계를 조작한다.","doWork":"편물의류의 원단종류 및 디자인 등을 확인하여 증열온도 및 시간 등을 정해 기계를 조절한다. 기계의 회전운반걸대에 의류를 걸어 놓는다. 기계가 회전하면 증기와 온도를 점검하고 작업과정을 관찰한다. 증열처리된 의류를 꺼내 탁자 위에 쌓아 올린다. 편직된 원단을 가열기에 밀어 넣어서 열처리하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"아이롱원","dJobECd":"8613","dJobECdNm":"[8613]표백·염색기 조작원","dJobJCd":"8212","dJobJCdNm":"[8212]표백 및 염색 관련 기계 조작원","dJobICd":"C133","dJobICdNm":"[C133]편조원단 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004201:1', '{"dJobCd":"K000004201","dJobCdSeq":"1","dJobNm":"증융가공원","workSum":"광택을 부여하고 촉감을 향상하며 주름을 제거하고자 구멍이 있는 실린더에 감긴 옷감 사이로 증기를 순환시키는 기계를 조작한다.","doWork":"옷감의 폭에 따라 안내 장치를 조절하고 규정된 장력에 맞춰 감김장치의 감대에 압력을 가하고자 수동 휠을 돌린다. 주름을 제거하고 옷감의 장력을 유지해 주는 포장지와 옷감 단을 실린더에 겹쳐 놓는다. 포장지와 옷감이 하나의 감대에 감기도록 기계를 가동한다. 천의 모양에 따라 회전실린더 안에 증기를 채우고 천 두루마리 사이에 증기를 투입한다. 옷감을 건조하고 식히기 위하여 옷감 사이로 냉각용 공기를 불어넣는다. 감긴 포장지와 옷감을 분리하여 감대에 감는다. 옷감을 압력 처리하는 압력탱크(Kier)를 다루기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"디케이팅원, 디케타이징원, 브로잉원","connectJob":"강력증압가공원","certLic":"섬유산업기사","dJobECd":"8613","dJobECdNm":"[8613]표백·염색기 조작원","dJobJCd":"8212","dJobJCdNm":"[8212]표백 및 염색 관련 기계 조작원","dJobICd":"C134","dJobICdNm":"[C134]섬유제품 염색, 정리 및 마무리 가공업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001967:1', '{"dJobCd":"K000001967","dJobCdSeq":"1","dJobNm":"지거염색원","workSum":"천을 염료와 그 외 다른 용액의 탱크를 통과시켜 염색하는 지거(Zigger)염색기를 조작한다.","doWork":"염색에 필요한 장비 및 염료 및 화학제 등의 도구를 준비한다. 동력호이스트를 사용하여 기계 위에 천 롤을 설치한다. 천이 탱크 안의 유도롤러를 통해 권취롤러로 통과하도록 한다. 탱크에 물을 넣고 염료, 화학제를 투입한다. 기계를 가동하여 천이 염료용액이나 화학용액을 통과하도록 하고 정해진 규정으로 염색되도록 역회전한다. 기계에서 염료를 배출하고 물을 투입하여 염색된 천을 세척한다. 동력호이스트를 이용하여 염료기에 설치한 천 롤을 교체한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"염색기능사(날염), 염색기능사(침염)","dJobECd":"8613","dJobECdNm":"[8613]표백·염색기 조작원","dJobJCd":"8212","dJobJCdNm":"[8212]표백 및 염색 관련 기계 조작원","dJobICd":"C134","dJobICdNm":"[C134]섬유제품 염색, 정리 및 마무리 가공업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006398:1', '{"dJobCd":"K000006398","dJobCdSeq":"1","dJobNm":"직물방축가공원","workSum":"직물을 규정된 크기로 수축하는 기계를 조작한다.","doWork":"작업지시서를 확인하여 직물의 폭과 중량을 확인한다. 장비를 점검하고 규정된 크기로 수축하기 위해 규정 폭 넓이로 세팅하고 장비의 온도와 속도를 조절한다. 호이스트를 사용하여 천 두루마리를 기계 위에 설치한다. 천의 끝단을 장력바, 유도장치, 공급롤러, 수축장치를 통과하도록 연결한다. 권취롤에 감기는 천을 살피고 주름지거나 고르지 못하게 감기는 것을 방지하고자 수축장치 위로 들어가는 천을 유도·조절한다. 물 또는 증기의 유량을 조절하는 밸브나 스위치 조절장치를 움직인다. 자를 이용하여 천의 넓이를 측정한다. 수축 가공된 천 두루마리를 내려놓는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|고온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"직물수축원, 직물침지원","dJobECd":"8613","dJobECdNm":"[8613]표백·염색기 조작원","dJobJCd":"8212","dJobJCdNm":"[8212]표백 및 염색 관련 기계 조작원","dJobICd":"C134","dJobICdNm":"[C134]섬유제품 염색, 정리 및 마무리 가공업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007218:1', '{"dJobCd":"K000007218","dJobCdSeq":"1","dJobNm":"직물수지가공반장","workSum":"직물에 방수, 방염, 방오, 대전방지 처리를 하기 위해 수지를 입히는 기계를 다루는 데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"표준작업명세서에 따라 제품생산량 및 공정별 작업계획을 수립한다. 작업계획에 따라 세부실행항목을 수립하고 작업절차 및 방법을 결정하여 작업원에게 작업내용을 지시하고 작업을 배치한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원과 자재를 공급한다. 표준작업명세에 따라 지시된 작업이 이루어지는지 작업상황을 관찰하며 작업내용을 점검한다. 작업원의 직무교육 및 안전위생교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴·해결하고 문제점을 보완한다. 작업의 진행사항을 파악하고 작업내용을 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","similarNm":"건식반장","dJobECd":"8613","dJobECdNm":"[8613]표백·염색기 조작원","dJobJCd":"8212","dJobJCdNm":"[8212]표백 및 염색 관련 기계 조작원","dJobICd":"C134","dJobICdNm":"[C134]섬유제품 염색, 정리 및 마무리 가공업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001990:1', '{"dJobCd":"K000001990","dJobCdSeq":"1","dJobNm":"직물열처리원","workSum":"염색, 건조된 직물에 열을 가하여 폭, 길이, 수축률, 중량 등을 조정하고 직물의 조직형태를 고정하는 기계를 조작한다.","doWork":"열처리장치의 증기(Steam)밸브를 열어 장치 내의 온도를 일정하게 유지한다. 염색, 건조, 탈수된 직물을 수레차로 운반하여 기계 앞에 배치한다. 직물을 기계의 안내롤러에 걸치고 직물 지지장치에 고정한다. 직물의 폭과 길이를 수축하는 게이지를 돌려 일정수준으로 유지한다. 기계를 가동한다. 기계의 가동상태를 점검하고 이상이 없는지 점검한다. 자, 측정게이지, 촉감 등으로 직물의 가공 상태를 점검·조정한다. 가공 처리된 직물을 수레차에 실어 운반한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"텐터기조작원","dJobECd":"8613","dJobECdNm":"[8613]표백·염색기 조작원","dJobJCd":"8212","dJobJCdNm":"[8212]표백 및 염색 관련 기계 조작원","dJobICd":"C134","dJobICdNm":"[C134]섬유제품 염색, 정리 및 마무리 가공업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001588:1', '{"dJobCd":"K000001588","dJobCdSeq":"1","dJobNm":"직편물건조원","workSum":"직편물의 촉감을 부드럽게 하고 수분을 제거하고자 건조기를 조작한다.","doWork":"직편물의 종류에 따라 작업지시서를 확인하고 건조시간, 온도 등을 파악한다. 건조기의 작동 이상 유무를 확인한다. 직편물 적재수레차를 기계 앞에 배치한다. 안내롤러에 직편물의 끝을 투입하거나 기계의 안내천(Leader Cloth)에 끝단을 연결한다. 제품에 따라 건조온도를 조절한다. 기계의 가동레버를 조작하고 건조장치를 통과하는 직편물의 속도를 조절한다. 주름이 없도록 직물을 바르게 편다. 건조가 완료되면 품목표에 건조시간, 건조온도, 규격 등을 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8613","dJobECdNm":"[8613]표백·염색기 조작원","dJobJCd":"8212","dJobJCdNm":"[8212]표백 및 염색 관련 기계 조작원","dJobICd":"C134","dJobICdNm":"[C134]섬유제품 염색, 정리 및 마무리 가공업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002246:1', '{"dJobCd":"K000002246","dJobCdSeq":"1","dJobNm":"청바지탈색가공원","workSum":"청바지의 탈색을 위하여 부석 등의 첨가제를 탈색조에 넣고 적절한 색상을 만들어낸다.","doWork":"청바지의 탈색을 의뢰한 업체에서 청바지 견본을 받아서 탈색의 기준으로 삼는다. 청바지와 탈색에 필요한 부석, 유연제, 차염산 등을 적절히 탈색조에 넣고 일정한 시간 동안 탈색조를 가동한 후 청바지 견본과 비교하여 업체에서 요구한 수준으로 탈색되었는지를 확인한다. 사포나 모래, 화학약품 등을 사용하여 부분적으로 탈색을 하기도 한다. 보다 정밀하게 업체의 요구 수준을 준수하기 위해 청바지 견본과 탈색 중인 청바지를 물속에 넣고 비교하는 방법을 쓰기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|다습|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8613","dJobECdNm":"[8613]표백·염색기 조작원","dJobJCd":"8212","dJobJCdNm":"[8212]표백 및 염색 관련 기계 조작원","dJobICd":"C134","dJobICdNm":"[C134]섬유제품 염색, 정리 및 마무리 가공업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005842:1', '{"dJobCd":"K000005842","dJobCdSeq":"1","dJobNm":"축융가공원","workSum":"증기, 열, 압력을 이용하여 직물조직으로부터 털이 표면으로 나오게 하고 치밀하게 하는 축융기를 조작한다.","doWork":"작업하는 직물의 종류에 따라 수증기, 열, 압력 등을 파악하고 조절한다. 천을 장력유도장치나 압력롤러 사이의 수축넓이를 조절하는 롤러 사이와 수축 길이를 조절하는 주름상자 사이로 연결한다. 재봉틀을 사용하여 천의 끝단을 연결한다. 장력유도장치의 압력을 조절하고 천의 모양에 따른 롤러와 트랩(Trap) 위의 공기압력계기를 조정한다. 천이 통과하는 동안 물과 비누용액이 투입되도록 밸브를 조정한다. 천의 단을 연결한 이음매를 풀고, 천이 릴(Reel) 위를 통과하여 손수레 안으로 들어가도록 유도 조절한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|다습|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"축융기운전원","dJobECd":"8613","dJobECdNm":"[8613]표백·염색기 조작원","dJobJCd":"8212","dJobJCdNm":"[8212]표백 및 염색 관련 기계 조작원","dJobICd":"C134","dJobICdNm":"[C134]섬유제품 염색, 정리 및 마무리 가공업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002162:1', '{"dJobCd":"K000002162","dJobCdSeq":"1","dJobNm":"코팅가공기운전원","workSum":"직물에 코팅처리를 하는 기계를 운전한다.","doWork":"직물에 맞는 발수제 등의 코팅수지를 준비하고 사용되는 장비의 이상 유무를 파악한다. 호이스트를 사용하여 피복 처리되지 않은 시트감 롤을 기계선반대 위에 설치한다. 시트감이 캘린더기에서부터 피복처리기계 사이와 권취롤러 위를 통과하도록 연결한다. 규정된 두께로 피복처리하기 위하여 조작날이나 롤러의 여유를 조절한다. 시트감 위에 흐르는 피복용액의 유량을 조절하는 밸브를 조작한다. 확포장치에서 천이 미끄러지지 않도록 공정을 관찰한다. 공정을 관찰하며 줄, 주름, 접힌 가장자리 같은 결함이 발생하지 않도록 밸브와 조정장치를 조작한다. 피복 및 공정이 끝나는 대로 재료의 솔기를 자른다. 시트감에 구멍이나 찢어짐 등을 수선하기 위해 테이프를 부착한다. 호이스트를 이용하여 피복처리된 롤을 꺼낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8613","dJobECdNm":"[8613]표백·염색기 조작원","dJobJCd":"8212","dJobJCdNm":"[8212]표백 및 염색 관련 기계 조작원","dJobICd":"C134","dJobICdNm":"[C134]섬유제품 염색, 정리 및 마무리 가공업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007386:1', '{"dJobCd":"K000007386","dJobCdSeq":"1","dJobNm":"타래염색원","workSum":"실타래를 염색·표백·세척 처리하는 기계를 조작한다.","doWork":"작업지시서의 제조방법에 따라 염료통에 물을 채우고 온도를 조절한다. 화학연화제나 액체염료를 투입하여 염색준비를 한다. 다공선반 걸이에 실타래를 걸어 놓는다. 타래가 일정하게 회전하고 염료가 순환되도록 기계를 작동한다. 염색이 끝나면 염색통의 염료액을 버리고 세척용 물을 투입한다. 세척된 타래를 건조기에 넣고 건조시킨다. 실타래를 다발로 만들기 위해 고리로 여러 타래를 매어 놓기도 한다. 실다발을 포장상자 안에 넣는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"고온|다습|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"타래세척원, 타래정련원, 타래표백원","certLic":"염색기능사(날염), 염색기능사(침염)","dJobECd":"8613","dJobECdNm":"[8613]표백·염색기 조작원","dJobJCd":"8212","dJobJCdNm":"[8212]표백 및 염색 관련 기계 조작원","dJobICd":"C134","dJobICdNm":"[C134]섬유제품 염색, 정리 및 마무리 가공업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002761:1', '{"dJobCd":"K000002761","dJobCdSeq":"1","dJobNm":"탈호기운전원","workSum":"염색공정 시 염색친화력을 증가시키기 위하여 천에 호제를 제거하는 기계를 조작한다.","doWork":"천의 무게에 달고 중량에 따라 탈호제의 양을 조절하여 혼합탱크에 투입하여 물과 함께 혼합한다. 혼합탱크에서 탈호관으로 이송하는 밸브를 열고 용액을 가열하고자 증기압을 조절한다. 기계의 공급대에 옷감 수레차를 배치하거나 스크레이(Scray)의 선반대 위에 옷감 두루마리를 설치한다. 기계를 가동시키고 작업공정을 관찰한다. 구멍이나 잘못된 흠을 찾아 표시한다. 옷감에 따라 안내장치와 기계의 속도를 조절하는 손잡이를 돌린다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"발호기운전원","certLic":"염색기능사(날염), 염색기능사(침염)","dJobECd":"8613","dJobECdNm":"[8613]표백·염색기 조작원","dJobJCd":"8212","dJobJCdNm":"[8212]표백 및 염색 관련 기계 조작원","dJobICd":"C134","dJobICdNm":"[C134]섬유제품 염색, 정리 및 마무리 가공업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006539:1', '{"dJobCd":"K000006539","dJobCdSeq":"1","dJobNm":"탕신가공원","workSum":"모직물이나 소모사의 일정치 못한 수축현상을 방지하기 위해 열탕 처리하는 기계를 조작한다.","doWork":"표준작업명세표를 확인하고 처리 온도 및 속도를 숙지한다. 재봉틀을 사용하거나 핀을 사용하여 직물의 끝단을 연결한다. 직물의 단을 권취롤러 위에 감싸 통과하도록 한다. 밸브를 열어 일정량의 물이 욕조(Bath)에 들어가도록 하고, 온도를 조절한다. 선두롤러의 압력을 조절한다. 기계를 가동하고 옷감의 흐름을 조절한다. 래핑천(Wrapping Cloth)을 사용하여 가공할 직물을 탄탄하게 말아서 가공하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|다습|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"자융가공원, 크래빙원","dJobECd":"8613","dJobECdNm":"[8613]표백·염색기 조작원","dJobJCd":"8212","dJobJCdNm":"[8212]표백 및 염색 관련 기계 조작원","dJobICd":"C134","dJobICdNm":"[C134]섬유제품 염색, 정리 및 마무리 가공업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001728:1', '{"dJobCd":"K000001728","dJobCdSeq":"1","dJobNm":"톱염색원","workSum":"다공 빔·튜브나 스프링 코일에 감긴 톱(Top)을 염색하는 기계를 조작한다.","doWork":"작업지시서에 따라 염색할 색상의 염료를 준비하고 장비를 점검한다. 톱이 감긴 스프링 코일을 금속봉에 끼우고 틈이 발생하지 않도록 볼트를 조인다. 원료적재 스탠드와 톱이 감긴 빔을 호이스트를 사용하여 고압 염색탱크 안에 투입한다. 뚜껑을 닫고 렌치로 볼트를 조인다. 증기와 물의 유량을 조절하는 밸브를 돌린다. 규정 온도와 압력을 조절하고 혼합한 염료를 투입한다. 염색상태를 점검하고 염료를 배출한다. 물을 투입하여 세척하고 탱크 안의 온도를 조절하여 톱을 건조한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|고온|다습|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"염료염색원","certLic":"염색기능사(날염), 염색기능사(침염)","dJobECd":"8613","dJobECdNm":"[8613]표백·염색기 조작원","dJobJCd":"8212","dJobJCdNm":"[8212]표백 및 염색 관련 기계 조작원","dJobICd":"C134","dJobICdNm":"[C134]섬유제품 염색, 정리 및 마무리 가공업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005223:1', '{"dJobCd":"K000005223","dJobCdSeq":"1","dJobNm":"특수가공반장","workSum":"염색된 직물을 물리적 처리방법에 의해 촉감을 부드럽게 하거나 광택을 내는 데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"품목별 생산량 등을 수립하고 표준작업명세서에 따라 작업계획을 세운다. 작업계획에 따라 세부실행항목을 작성한다. 작업절차 및 방법을 결정하여 작업원에게 작업내용을 지시하고 작업배치를 한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원 및 자재를 공급한다. 표준작업명세에 따라 지시된 작업이 이루어지는지 작업원과 함께 작업하며 작업상황을 관찰하고 작업내용을 점검한다. 작업원의 직무교육 및 안전위생교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴·해결하고 문제점을 보완한다. 작업의 진행사항을 파악하고 작업내용을 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","similarNm":"습식반장","dJobECd":"8613","dJobECdNm":"[8613]표백·염색기 조작원","dJobJCd":"8212","dJobJCdNm":"[8212]표백 및 염색 관련 기계 조작원","dJobICd":"C134","dJobICdNm":"[C134]섬유제품 염색, 정리 및 마무리 가공업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005837:1', '{"dJobCd":"K000005837","dJobCdSeq":"1","dJobNm":"패딩기운전원","workSum":"직물에 방염, 방수, 방오 등 수지가공처리를 하는 패딩기계를 운전한다.","doWork":"작업명세서에 지시된 색상과 수량의 일치 및 공정상 온도 및 압력 등을 확인한다. 기계의 작동 이상 유무와 청결상태를 확인한다. 기계의 공급대에 직물수레차를 배치하거나 동력 호이스트를 사용하여 천 두루마리를 설치한다. 천을 롤러 사이에 걸치거나 기계의 안내천(Leader Cloth)에 천의 끝단을 연결한다. 기계의 온도를 조절하고 압착롤의 압력을 조절한다. 예비건조기를 점화하고 가스버너의 점화상태를 점검한다. 욕조(Bath)에 가공용액을 채우는 밸브를 연다. 압착롤러, 가공용액, 권취롤러 사이를 직물이 통과하도록 기계를 가동하고 직물의 가공처리 상태를 관찰한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"수지가공기운전원","dJobECd":"8613","dJobECdNm":"[8613]표백·염색기 조작원","dJobJCd":"8212","dJobJCdNm":"[8212]표백 및 염색 관련 기계 조작원","dJobICd":"C134","dJobICdNm":"[C134]섬유제품 염색, 정리 및 마무리 가공업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002948:1', '{"dJobCd":"K000002948","dJobCdSeq":"1","dJobNm":"편물압착원","workSum":"편물의류의 모양을 만들고 펴기 위해 압착롤과 다림질용 편자설비가 있는 기계를 조작한다.","doWork":"작업지시서를 확인하고 편물의류의 원단 종류에 따른 가열온도, 압착강도 및 시간 등을 확인한다. 가감저항기를 조절하여 다림질 편자를 가열하고 지정된 온도로 유지시킨다. 기계가 가열되면 의류를 롤에 펼쳐 놓고 롤을 회전시켜 회전롤과 가열된 다림질 편자가 의류를 압착하도록 조절레버를 누른다. 압착처리된 의류를 기계에서 꺼낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|고온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8613","dJobECdNm":"[8613]표백·염색기 조작원","dJobJCd":"8212","dJobJCdNm":"[8212]표백 및 염색 관련 기계 조작원","dJobICd":"C133","dJobICdNm":"[C133]편조원단 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001423:1', '{"dJobCd":"K000001423","dJobCdSeq":"1","dJobNm":"표백기운전원","workSum":"날염·염색·가공공정을 하기 전에 직물을 표백·세탁·건조하는 설비를 운전한다.","doWork":"압착롤러 등의 설비를 점검한다. 물통 및 과산화수소 침투기 등의 충전상태를 점검하고 물 및 화합물을 충전한다. 기계의 공급대 또는 선반대에 접어진 천을 배치한다. 안내롤러에 직물의 끝을 연결하거나 재봉틀을 사용하여 기계의 안내천(Leader Cloth)에 연결한다. 천의 넓이에 따라 폭을 유도조절하는 수동휠을 조절한다. 여러 가지 직물의 모양에 적합하게 압착롤러의 압력과 기계의 속도를 조절한다. 천이 기계 안으로 투입되는 것을 관찰하며 잘못된 이음매나 흠을 찾는다. 처리된 직물의 표백상태를 점검한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8613","dJobECdNm":"[8613]표백·염색기 조작원","dJobJCd":"8212","dJobJCdNm":"[8212]표백 및 염색 관련 기계 조작원","dJobICd":"C134","dJobICdNm":"[C134]섬유제품 염색, 정리 및 마무리 가공업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005858:1', '{"dJobCd":"K000005858","dJobCdSeq":"1","dJobNm":"화학섬유건조원","workSum":"보빈(Bobbin)이나 합성실타래의 수분을 제거하기 위해 건조기를 조작한다.","doWork":"차륜장치(Wheel)나 컨베이어(Conveyor)가 장치된 건조기의 걸대에 실타래나 보빈을 건다. 건조기의 가동시간, 온도 등을 조절하고 가동한다. 건조되어 나오는 실타래나 보빈의 건조상태를 점검한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"고온|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"투입인출","connectJob":"보빈건조원, 케이크건조원, 타래건조원","dJobECd":"8613","dJobECdNm":"[8613]표백·염색기 조작원","dJobJCd":"8212","dJobJCdNm":"[8212]표백 및 염색 관련 기계 조작원","dJobICd":"C205","dJobICdNm":"[C205]화학섬유 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002211:1', '{"dJobCd":"K000002211","dJobCdSeq":"1","dJobNm":"화학섬유품질염색판정원","workSum":"필라멘트사, 가공사 등과 같은 화학섬유의 품질을 확인하기 위하여 편직한 견본을 염색하고 판정한다.","doWork":"판정규격을 숙지하고 표준견본을 준비한다. 편직된 화학섬유의 품질을 확인하기 위해 견본을 드럼형 염색기에 넣어 정련·염색한다. 탈수기로 수분을 제거한 후 건조한다. 건조한 직물을 다시 정련한 후 표준견본과 비교하거나 육안으로 판정하여 규격에 일치하는지 확인한다. 판정결과를 기록표에 기록한다. 품질의 이상 유무를 관련 부서에 통보한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"시각|","workEnv":"대기환경미흡|다습|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"염색기능사(날염), 염색기능사(침염)","dJobECd":"8613","dJobECdNm":"[8613]표백·염색기 조작원","dJobJCd":"8212","dJobJCdNm":"[8212]표백 및 염색 관련 기계 조작원","dJobICd":"C205","dJobICdNm":"[C205]화학섬유 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002661:1', '{"dJobCd":"K000002661","dJobCdSeq":"1","dJobNm":"회전식건조기운전원","workSum":"세탁 및 염색 후에 제품의 수분을 제거하고 건조하고자 회전식 건조기를 조작한다.","doWork":"작업지시서를 확인하고 제품에 따른 건조시간 등을 숙지한다. 건조기의 작동 이상 유무를 확인한다. 건조기의 드럼통 안에 손이나 롤러장치를 이용하여 의류나 천을 투입한다. 계기판을 조작하여 온도와 건조시간을 조절한 후 기계를 가동한다. 기계의 창을 통해 제품의 건조상태를 점검한다. 건조가 완료되면 기계를 정지하고 제품을 호이스트나 손으로 직접 꺼내어 운반차에 싣거나 감개로 감는다. 의류의 크기, 모양, 색깔에 따라 분리하기도 한다. 의류의 결함을 검사하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"투입인출","similarNm":"텀블링건조원","dJobECd":"8613","dJobECdNm":"[8613]표백·염색기 조작원","dJobJCd":"8212","dJobJCdNm":"[8212]표백 및 염색 관련 기계 조작원","dJobICd":"C133","dJobICdNm":"[C133]편조원단 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001730:1', '{"dJobCd":"K000001730","dJobCdSeq":"1","dJobNm":"후세모기운전원","workSum":"염색된 양모 슬리버의 염료찌꺼기, 오염물질, 냄새 등을 제거하고 적당한 유분과 수분을 함유하도록 세탁·헹굼·건조하는 기계를 조작한다.","doWork":"굴대(Spindle)나 바닥에 볼(Ball)형의 슬리버를 놓거나 기계의 공급부분에 슬리버 통을 배치한다. 슬리버의 무게에 따라 세탁 및 헹굼 시간, 건조 온도 등을 조정한다. 기계에 있는 슬리버 끝에 새로운 슬리버를 서로 잇거나, 기계 안에 슬리버 끝단을 삽입하여 세탁, 헹굼, 압찰 롤러 및 건조대를 통과시킨다. 건조대의 온도를 조절하고 세탁 및 헹굼 용액의 순환을 조절하기 위해 밸브를 돌린다. 끊어진 슬리버를 서로 잇는다. 슬리버의 무게를 달고 포장한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"백와셔대지원, 백와셔틀보기원","dJobECd":"8613","dJobECdNm":"[8613]표백·염색기 조작원","dJobJCd":"8212","dJobJCdNm":"[8212]표백 및 염색 관련 기계 조작원","dJobICd":"C131/C134","dJobICdNm":"[C131]방적 및 가공사 제조업 / [C134]섬유제품 염색, 정리 및 마무리 가공업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004122:1', '{"dJobCd":"K000004122","dJobCdSeq":"1","dJobNm":"경편기빔교환원","workSum":"경편직물 제조공정 중 다 쓰인 빔을 내리고 정경된 빔으로 교환한다.","doWork":"정경공정을 거쳐 정경된 빔을 수령한다. 정경된 빔을 저울에 달아 중량을 검사한다. 일정 개수의 빔을 축에 끼워 연결한다. 호이스트나 기중기를 사용하여 빔이 끼워진 축을 기계의 빔 고정대에 올려놓는다. 빔 축을 고정하기 위해 수동공구를 사용하여 볼트를 조인다. 불순물을 제거하기 위해 걸레로 빔을 닦는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"투입인출","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C133","dJobICdNm":"[C133]편조원단 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002514:1', '{"dJobCd":"K000002514","dJobCdSeq":"1","dJobNm":"경편직기조정원","workSum":"여러 크기와 패턴으로 이루어진 금속체인을 설치하여 견본에 나타난 편직무늬의 밀도를 살펴보고 기계를 조정한다.","doWork":"작업명세서 및 편직무늬를 파악하고 경편직기의 이상 유무를 확인한다. 체인에 무늬판을 어떻게 배열할 것인가를 정하고 패턴체인을 조립하기 위해 판을 연결한다. 바늘과 렌치를 사용하여 결함이 있는 편성침가이드, 싱커(Sinker)를 교체한다. 기계의 설치가 완료되면 명세서와 일치하는지 알아보기 위해 시험 가동한다. 체인호이스트와 수동공구를 사용하여 경사빔의 설치를 돕고 편직된 편직물 롤을 기계에서 떼어낸다. 기름통과 솔을 사용하여 기계에 기름을 주유한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"설비보전기능사","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C133","dJobICdNm":"[C133]편조원단 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002147:1', '{"dJobCd":"K000002147","dJobCdSeq":"1","dJobNm":"경편직원","workSum":"겉옷이나 속옷에 사용되는 얇은 의류, 레이스, 망직물 등 탄성직물이나 양탄자 재료와 같은 편직물을 제조하기 위해 경편직기를 조작한다.","doWork":"편직물이 제조되는 경편직기를 관찰한다. 편직과정에서 실이 끊어지면 바늘을 사용하여 가이드에 끼운다. 편직물에 구멍, 끊어진 실(절사), 퇴색 등의 결함이 있는지 검사한다. 결함의 수요와 형태를 기록한다. 새실을 편침대 위와 아래에 손으로 넣고 바늘을 사용하여 가이드를 통해 실을 꿴다. 가위를 사용하여 여분의 실을 잘라낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","connectJob":"라셸편직원, 밀라니즈편직원, 트리코트편직원","certLic":"섬유산업기사","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C133","dJobICdNm":"[C133]편조원단 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002863:1', '{"dJobCd":"K000002863","dJobCdSeq":"1","dJobNm":"경편직통경원","workSum":"편직을 하기 위해 경편기를 준비하는 과정의 하나로 가이드를 통해 실을 꿴다.","doWork":"작업에 필요한 통경도구들을 준비하고 전경공정을 거친 경사빔을 수령한다. 기계에 부착된 빔에서 종이 덮개를 떼어내고 실 끝을 배열하기 위해 실패나 빔을 돌린다. 가위를 사용하여 경사를 붙들어 주는 테이프를 자른다. 실 끝을 슬레이포인트 위에서 고리로 만들고 그 끝을 기계 앞으로 잡아당긴다. 경사빔에 감긴 경사를 드로퍼, 종광, 바디 등에 통경도구를 사용하여 꿰어준다. 기계를 작동하고 천의 끝을 권취롤에 감는다. 끊어진 실을 손으로 잇고 기계를 청소한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"섬유산업기사","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C133","dJobICdNm":"[C133]편조원단 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002158:1', '{"dJobCd":"K000002158","dJobCdSeq":"1","dJobNm":"기계자수반장","workSum":"직물 위에 도안을 수놓는 작업에 종사하는 작업원의 활동을 감독·조정한다.","doWork":"도안 색깔에 따라 자수장치가 기동할 수 있도록 작업 전에 자수기를 검사한다. 작업계획에 따라 세부실행항목을 수립하여 작업절차 및 방법을 결정한 후 작업원이 효율적으로 작업할 수 있도록 적당한 위치에 배정하고 작업내용을 작업원에게 지시한다. 자수 작업자에게 안전교육을 실시하고 지도한다. 검사할 자수직물을 검사대 위에 펼쳐 놓고 손으로 잡아당기며 제품의 불량 여부를 검사한다. 다 쓴 북 실패나 부러진 바늘 등의 자수소품에 대한 입고 계획 등을 짠다. 자수되었거나 재봉된 부위에 뛰어넘은 바느질이 있는지 검사한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"수동조작","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C132","dJobICdNm":"[C132]직물직조 및 직물제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002495:1', '{"dJobCd":"K000002495","dJobCdSeq":"1","dJobNm":"기계자수직물검단원","workSum":"자수직물을 펼쳐 빠진 바느질이나 겹친 바느질 등 불량을 검사하고 실밥을 제거한다.","doWork":"검사할 자수직물을 검사대 위에 펼쳐 놓고 손으로 잡아당기며 제품의 불량 여부를 검사한다. 자수한 부위를 손으로 잡아 당겨 느슨한 실들을 쪽가위(손가위)로 잘라낸다. 원단 뒷면의 부직포를 떼어내거나 헝겊에 시너를 묻혀 오염물질을 닦아내기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"시범후 30일 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","similarNm":"시아게원","connectJob":"시어링원, 자수직물실밥제거원","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C132","dJobICdNm":"[C132]직물직조 및 직물제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005123:1', '{"dJobCd":"K000005123","dJobCdSeq":"1","dJobNm":"기계자수직물완성원","workSum":"레이스로 장식되어 있거나 자수한 제품을 검사하여 마무리한다.","doWork":"자수되었거나 재봉된 부위에 뛰어넘은 바느질이 있는지 검사하고 너덜한 실을 제거한다. 얼룩진 부위는 세제용액으로 문지르거나 세척솔로 제거한다. 치수, 품질 등의 제품규격을 검사한다. 결함이 있는 제품은 수리를 의뢰한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"자수직물완성보수원","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C132","dJobICdNm":"[C132]직물직조 및 직물제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002765:1', '{"dJobCd":"K000002765","dJobCdSeq":"1","dJobNm":"기모기조작원","workSum":"천을 부드럽게 하고 표면에 솜 같은 잔털을 일으켜 세우는 기계를 조작한다.","doWork":"작업지시서를 확인하고 원단의 종류 및 가공처리 시 속도 및 천의 장력 등을 파악한다. 천이 감긴 수레차를 기계의 공급대에 배치하거나 천 롤을 기계 선반대 위에 올려놓는다. 규정된 형태로 보풀 처리를 하기 위해 솔과 천의 간격을 맞추고, 천의 종류에 따라 기모기의 조정판을 조작하여 기계의 속도와 천의 장력을 조절한다. 천의 끝단을 기계에 투입한다. 기계를 가동하고 보풀 처리가 규정에 맞게 가공되는지 표준과 비교하여 검사하고 만져본다. 기계를 정지하고 직물의 각 부분의 이음매를 푼다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"섬유산업기사","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C134","dJobICdNm":"[C134]섬유제품 염색, 정리 및 마무리 가공업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002111:1', '{"dJobCd":"K000002111","dJobCdSeq":"1","dJobNm":"나름걸이원","workSum":"제직이 완료된 직기로 새로운 직물을 짜기 위해 경사를 변경·정리한다.","doWork":"직조기에서 수공구를 사용하여 경사빔, 종광, 드로퍼(Dropper), 바디를 제거한다. 필요한 조정을 하기 위해 기어, 캠, 정지장치, 북침장치 등의 직조기 부품을 검사한다. 수공구로 결함이 있는 부속품을 수리하고 장력 및 시간조절장치를 조정하는 직조기보전원의 일을 한다. 분해한 경사빔, 종광, 드로퍼, 바디, 패턴체인을 직조기에 재조립한다. 북집과 바디의 수평조절을 하고 정리한다. 직기 빔의 날실 끝을 모아 묶는다. 끊어진 실을 잇는다. 바디걸이가 잘못된 것을 종광을 통해 다시 꿴다. 직조기를 청소하고 기름을 치기도 한다. 수공구를 사용하여 북집 장치를 제거하고 대체하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|고온|다습|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"틀걸이원, 직조기보전원","certLic":"설비보전기능사","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C133","dJobICdNm":"[C133]편조원단 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004395:1', '{"dJobCd":"K000004395","dJobCdSeq":"1","dJobNm":"나름정리원","workSum":"직조에 들어가기 전에 경사의 끝을 묶어 직조기에 있는 경사의 끝과 일치되도록 실 끝을 배열한다.","doWork":"잭(Jack)을 이용하여 직조기에 빔을 장치한다. 사침배열에 따라 직조기의 마지막 경사와 새 경사의 다른 한쪽 끝을 분리하고 사침대에 가닥들을 끼워 위치가 바뀌지 않도록 한다. 끊어진 실 끝을 묶고 종광을 통해 실을 빼고 끊어진 곳을 잇는다. 이동기구로 직조기로부터 직조 빔을 운반하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|고온|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"투입인출","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C132","dJobICdNm":"[C132]직물직조 및 직물제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006602:1', '{"dJobCd":"K000006602","dJobCdSeq":"1","dJobNm":"누비질기계조작원","workSum":"장갑, 누비이불, 매트리스 커버 등의 제품을 만드는 데 사용되는 천을 누비질하는 기계를 조작한다.","doWork":"실패를 실걸이에 걸고 실 끝을 유도장치, 인장기 등을 통하여 바늘귀에 꿴다. 북 실패를 북집에 집어넣는다. 기계의 각 부분을 점검한 후 누비질할 넓게 편 천을 기계로 옮기거나 천 두루마리를 기계에 건다. 누비질할 천의 시작점을 교정하고 기계를 가동한다. 누비질한 부위를 관찰하여 끊어진 실, 고르지 못한 가장자리 등의 결함이 있는지 검사한다. 낡거나 부러진 바늘을 교체한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"퀄팅원","dJobECd":"8612","dJobECdNm":"[8612]직조기·편직기 조작원","dJobJCd":"8221","dJobJCdNm":"[8221]직조기 및 편직기 조작원","dJobICd":"C139","dJobICdNm":"[C139]기타 섬유제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;