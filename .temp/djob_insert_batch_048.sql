INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002379:1', '{"dJobCd":"K000002379","dJobCdSeq":"1","dJobNm":"매트리스커버누비원","workSum":"매트리스의 스펀지, 패딩, 원단을 재봉기계로 누빈다.","doWork":"작업하고자 하는 등급에 맞도록 재료를 준비한 후 부직포를 가장 아래로 설치하고 그 위로 스펀지, 패딩, 원단 순으로 배열한다. 재료를 재봉기 본체의 바늘대 누름판 사이로 끼운다. 작업하고자 하는 패턴과 바늘의 위치가 일치하도록 설치한 후 제어장치의 컴퓨터에 작업하고자 하는 규격의 치수를 입력한다. 한 장의 커버가 절단되어 컨베이어에 떨어지면 커버의 치수를 확인한다. 치수가 이상이 없으면 연속적으로 누비작업과 절단작업이 진행되도록 하며 수시로 누비상태 및 절단치수를 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8649","dJobECdNm":"[8649]기타 직물·신발 기계 조작원 및 조립원","dJobJCd":"8229","dJobJCdNm":"[8229]기타 직물·신발 관련 기계 조작원 및 조립원","dJobICd":"C320","dJobICdNm":"[C320]가구 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002222:1', '{"dJobCd":"K000002222","dJobCdSeq":"1","dJobNm":"모피드럼조작원","workSum":"모피의 재질을 부드럽게 하고자 화학약품을 처방해 드럼기계를 돌린다.","doWork":"재봉이 완료된 모피의 잔털을 제거하고 딱딱한 재질을 풀어주기 위해 윤활제와 같은 화학약품을 처방해 드럼기계를 돌리거나 퍼크로 세탁을 한다. 모피의 종류와 성별에 따라 조작시간을 달리한다. 작업이 완료된 후 작업지시서와 제품을 비교하여 작업이 제대로 되었는지를 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8649","dJobECdNm":"[8649]기타 직물·신발 기계 조작원 및 조립원","dJobJCd":"8229","dJobJCdNm":"[8229]기타 직물·신발 관련 기계 조작원 및 조립원","dJobICd":"C142","dJobICdNm":"[C142]모피제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003838:1', '{"dJobCd":"K000003838","dJobCdSeq":"1","dJobNm":"모피선별원","workSum":"모피 원피를 부피, 색상, 질감, 명암, 종류 등에 맞춰 한 벌 분량을 묶어 분류하고 다시 부위별로 원피를 골라 분류하는 작업을 수행한다.","doWork":"작업지시서를 숙지하고 원피를 선별대 위에 올려놓는다. 털 길이, 모질, 명암, 광택, 부피, 전체 길이 등이 같은 것끼리 분류하고 번호를 매긴다. 패턴에 준하여 소요량을 계산하고 필요한 수량만큼 골라서 배열한다. 판장 시 등털 중심이 비뚤어지지 않도록 중심선을 표시하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"시각|","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"모피매칭원","dJobECd":"8649","dJobECdNm":"[8649]기타 직물·신발 기계 조작원 및 조립원","dJobJCd":"8229","dJobJCdNm":"[8229]기타 직물·신발 관련 기계 조작원 및 조립원","dJobICd":"C142","dJobICdNm":"[C142]모피제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004636:1', '{"dJobCd":"K000004636","dJobCdSeq":"1","dJobNm":"모피판장원","workSum":"모피 원피를 펼쳐 적당한 형태로 판장하기 위해 스테이플러로 박아 고정한다.","doWork":"재봉이 완료된 모피 원피를 수령 받아 작업대에 올려놓는다. 브러시를 물에 적셔 솔질한다. 물에 적신 원피를 판장(패턴에 맞춰 형태를 잡기위하여 원피의 가장자리에 스테이플러를 박는 것)한다. 고정한 원피를 건조실에 넣어 건조하거나 자연건조 시킨다. 건조실에서 원피를 꺼내어 작업대에 놓는다. 원피에서 스테이플러의 핀을 제거하고 스팀기로 털을 편다. 작업이 완료된 원피를 다음 공정으로 이송시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|다습|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8649","dJobECdNm":"[8649]기타 직물·신발 기계 조작원 및 조립원","dJobJCd":"8229","dJobJCdNm":"[8229]기타 직물·신발 관련 기계 조작원 및 조립원","dJobICd":"C142","dJobICdNm":"[C142]모피제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005821:1', '{"dJobCd":"K000005821","dJobCdSeq":"1","dJobNm":"문양지펀칭기조작원","workSum":"카펫에 무늬를 내는 데 사용되는 문지(패턴카드)를 제작하기 위해 컴퓨터 및 펀칭기계를 조작한다.","doWork":"펀칭이 안 된 문지(패턴카드)를 펀칭기에 끼운다. 컴퓨터프로그램을 사용하여 생산할 카펫무늬대로 문지를 펀칭하도록 펀칭기를 작동한다. 펀칭되어 나오는 여러 장의 문지를 문지연결기(Card Lacing Machine)에 순서대로 넣어 연결한다. 프로그램을 조작하여 새로운 무늬를 만들기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"펀칭원","dJobECd":"8649","dJobECdNm":"[8649]기타 직물·신발 기계 조작원 및 조립원","dJobJCd":"8229","dJobJCdNm":"[8229]기타 직물·신발 관련 기계 조작원 및 조립원","dJobICd":"C139","dJobICdNm":"[C139]기타 섬유제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005627:1', '{"dJobCd":"K000005627","dJobCdSeq":"1","dJobNm":"밧줄제조기조작원","workSum":"섬유가닥들을 꼬아 밧줄을 만들어 릴(실이나 줄을 감는 얼레：Reel)에 감는 기계를 조작한다.","doWork":"작업지시서를 확인하고 제작할 밧줄의 굵기, 길이 등을 숙지한다. 밧줄의 굵기에 따라 적당한 릴을 선정하고 호이스트를 사용하여 기계에 장착한다. 선정된 섬유원사를 릴가이드를 통해 연사장치에 이르게 하고, 릴에 부착된 앞의 밧줄 가닥에 이어 붙인다. 기계를 시동하고 재료가 잘못 꼬여지거나 잘못 감기는 것을 관찰한다. 계수기가 규정량의 밧줄이 감긴 것을 나타내면 기계를 정지한다. 칼로 밧줄을 자르고 밧줄 고리를 줄로 묶어서 풀어지지 않도록 한다. 다 감긴 릴을 새것과 교체한다. 밧줄의 무게를 계량하기도 한다. 납땜인두나 가위로 밧줄의 거친 부분을 태우거나 잘라내기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"로프제조원, 로프제조기조작원","connectJob":"로프권선원, 로프연사원, 로프제강기조작원","dJobECd":"8649","dJobECdNm":"[8649]기타 직물·신발 기계 조작원 및 조립원","dJobJCd":"8229","dJobJCdNm":"[8229]기타 직물·신발 관련 기계 조작원 및 조립원","dJobICd":"C139","dJobICdNm":"[C139]기타 섬유제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005469:1', '{"dJobCd":"K000005469","dJobCdSeq":"1","dJobNm":"밧줄타래기조작원","workSum":"밧줄을 출하하거나 운반하기 전에 타래 형태로 감는 기계를 조작한다.","doWork":"밧줄의 굵기에 적합한 릴(Reel)을 선정하고 렌치를 사용하여 스핀들에 끼운다. 칼로 밧줄의 느슨한 끈 가닥을 자르고 끝에 테이프를 붙여 풀어지지 않도록 한다. 밧줄 끝을 릴에 묶고 기계를 시동한다. 고르게 감겨지도록 릴에 밧줄을 안내한다. 기계를 정지하고 감겨진 고리가 풀어지지 않도록 끈으로 묶는다. 호이스트를 사용하여 손수레에 밧줄을 내린다. 고리에서 릴을 빼낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"로프감기원, 로프타래원, 로프타래기조작원","dJobECd":"8649","dJobECdNm":"[8649]기타 직물·신발 기계 조작원 및 조립원","dJobJCd":"8229","dJobJCdNm":"[8229]기타 직물·신발 관련 기계 조작원 및 조립원","dJobICd":"C139","dJobICdNm":"[C139]기타 섬유제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005857:1', '{"dJobCd":"K000005857","dJobCdSeq":"1","dJobNm":"버핑기조작원","workSum":"합성피혁류의 표면을 매끈하게 연마하거나 두께를 조정하기 위해 버핑기를 조작한다.","doWork":"작업지시서를 확인하고 가공할 제품에 따라 사포를 선정하고 가공할 두께를 확인한다. 사용 중인 사포의 상태를 다이얼게이지(Dial Gauge)로 확인하고 사포의 교체 여부를 확인한다. 재단된 사포의 장력을 유지하면서 연마기에 감는다. 두께의 기준을 조정하고 시험한다. 기계를 작동하여 표면이나 두께를 조정·연마한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8649","dJobECdNm":"[8649]기타 직물·신발 기계 조작원 및 조립원","dJobJCd":"8229","dJobJCdNm":"[8229]기타 직물·신발 관련 기계 조작원 및 조립원","dJobICd":"C139","dJobICdNm":"[C139]기타 섬유제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004767:1', '{"dJobCd":"K000004767","dJobCdSeq":"1","dJobNm":"보망원","workSum":"제망기에 의해 일정 규격으로 제망된 그물을 수선한다.","doWork":"검사과정에서 수선이 필요하다고 판단된 그물을 보망작업대에 올려놓는다. 그물검사원이 표시한 부위를 찾아 수선바늘을 사용하여 수선하거나 플라스틱 보망도구로 끊어진 실 끝을 당겨서 손으로 이어준다. 수선이 완료된 그물을 다시 검사공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"그물수선원","dJobECd":"8649","dJobECdNm":"[8649]기타 직물·신발 기계 조작원 및 조립원","dJobJCd":"8229","dJobJCdNm":"[8229]기타 직물·신발 관련 기계 조작원 및 조립원","dJobICd":"C139","dJobICdNm":"[C139]기타 섬유제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002354:1', '{"dJobCd":"K000002354","dJobCdSeq":"1","dJobNm":"선견원","workSum":"건견장에서 운반된 고치를 선별해서 불량고치를 제거하고 견질을 균등하게 하기 위해 고치의 형태나 대소를 분류한다.","doWork":"채광장치를 통해 고치를 투시하여 죽은 고치를 골라낸다. 견립 선별기 또는 선견기를 사용하여 고치의 대소를 분류한다. 일일 작업량을 기록하고 주변을 청결히 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8649","dJobECdNm":"[8649]기타 직물·신발 기계 조작원 및 조립원","dJobJCd":"8229","dJobJCdNm":"[8229]기타 직물·신발 관련 기계 조작원 및 조립원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005789:1', '{"dJobCd":"K000005789","dJobCdSeq":"1","dJobNm":"섬유절단원","workSum":"장갑 또는 직물 등의 섬유제품 용도에 따라 종·횡면을 절단하는 절단기를 조작한다.","doWork":"컨베이어 위에 겹층 재료(원단)를 펼쳐 놓고 작업대로 이송한다. 두께측정기로 두께를 측정하고, 칼을 연마한다. 부직포가 감긴 롤(Roll)을 절단기에 건다. 칼날의 간격, 진행거리, 장력 등을 조절한다. 여러 가지 부품의 형상을 한 금형을 올려놓고 프레스를 가동한다. 절단된 부품의 형상을 확인한다. 혹은 작업대 위에 절단할 천을 겹치는 부분이 없도록 펼쳐 놓는다. 기계의 열선 작동레버를 조작하여 기계를 가동한다. 페달을 밟아 열선을 가동하여 천의 재단부 위에 올린다. 절단상태를 점검한다. 혹은 지지대 위에 재료 롤을 놓고 급송장치 안에 끈단을 끼운다. 절단되는 라벨의 지정숫자 계기를 조정하는 다이얼을 돌린다. 절단된 제품의 치수, 두께를 체크한다. 기계를 가동하고 잘못 절단되는 것을 찾기 위해 절단작업을 관찰한다. 잘못 절단된 라벨을 찾아내고 기계를 조정하기 위해 보전부서에 연락한다. 상자 안에 라벨을 정해진 수만큼 넣고 포장한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"섬유절단기조작원","connectJob":"규격절단기조작원, 담요절단원, 라벨절단원, 면절단기조작원, 자루절단원","dJobECd":"8649","dJobECdNm":"[8649]기타 직물·신발 기계 조작원 및 조립원","dJobJCd":"8229","dJobJCdNm":"[8229]기타 직물·신발 관련 기계 조작원 및 조립원","dJobICd":"C139","dJobICdNm":"[C139]기타 섬유제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006290:1', '{"dJobCd":"K000006290","dJobCdSeq":"1","dJobNm":"셔츠홀딩기조작원","workSum":"셔츠를 자동으로 접는 기계를 관리하고 조작한다.","doWork":"기계의 작업대 위에 셔츠를 놓고 소매단과 칼라를 부착된 죔틀에 넣어 손으로 누른 후 죔틀을 고정시켜 닫는다. 접기 날이 셔츠에까지 내려오도록 버튼을 누르고 기계의 접기 막대와 원반을 작동시켜 접기 날로 셔츠의 몸판과 소매를 접는다. 접기 날과 원반을 기계 속으로 들여보내고 페달을 눌러 가열된 칼라손질 조임쇠를 연다. 칼라 밑에 보강판지를 넣어 칼라의 모양이 유지되도록 한다. 셔츠를 접기 전에 셔츠 속에 판지를 넣어 셔츠의 접혀진 상태를 유지시킨다. 접혀진 셔츠 밑에 잘려진 종이테이프를 넣고 셔츠를 묶어 상자에 넣기도 한다. 치수별로 셔츠들을 분리하여 쌓아두기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8649","dJobECdNm":"[8649]기타 직물·신발 기계 조작원 및 조립원","dJobJCd":"8229","dJobJCdNm":"[8229]기타 직물·신발 관련 기계 조작원 및 조립원","dJobICd":"C141","dJobICdNm":"[C141]봉제의복 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006844:1', '{"dJobCd":"K000006844","dJobCdSeq":"1","dJobNm":"신발가죽분할원","workSum":"부분품을 균일한 두께로 만들거나 2개 이상의 층으로 되어 있는 가죽을 자르기 위하여 재단하는 기계를 조작한다.","doWork":"작업지시서를 확인하고 분할할 가죽 부분품의 두께를 숙지한다. 칼날과 롤러를 조정하는 고정나사나 수동바퀴를 돌려 일정 두께로 조정한다. 부분품을 칼날에 대고 롤러 사이에 부분품을 넣는다. 기계 유도장치에 부분품을 대고 기계를 작동시켜 칼날을 강압시킨다. 부분품이 정확한 두께로 잘라졌는지 계기를 사용하여 확인한다. 기계의 칼날을 연마하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"투입인출","similarNm":"세피재단원","certLic":"신발제조기능사","dJobECd":"8649","dJobECdNm":"[8649]기타 직물·신발 기계 조작원 및 조립원","dJobJCd":"8229","dJobJCdNm":"[8229]기타 직물·신발 관련 기계 조작원 및 조립원","dJobICd":"C152","dJobICdNm":"[C152]신발 및 신발 부분품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001668:1', '{"dJobCd":"K000001668","dJobCdSeq":"1","dJobNm":"심지부착원","workSum":"의류의 외관상 안정감과 힘받이를 위해 심지를 부착하여 압착하는 기계를 조작한다.","doWork":"작업지시서를 보고 시즌별 원단소재에 따라 심지 종류를 선택한다. 온도, 시간, 압축정도를 테스트한 후 휴징기의 작동스위치를 조작한다. 의복의 앞판, 깃, 어깨 등 기타 심지를 부착해야 하는 재단물에 재단할 심지를 포개고 휴징기를 통과시킨다. 접착의 강도를 높이기 위하여 가습기를 통과시키기도 한다. 휴징기를 통과한 부품을 크기별, 색상별로 정리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"성형압착원, 열접착테이프원","dJobECd":"8649","dJobECdNm":"[8649]기타 직물·신발 기계 조작원 및 조립원","dJobJCd":"8229","dJobJCdNm":"[8229]기타 직물·신발 관련 기계 조작원 및 조립원","dJobICd":"C141","dJobICdNm":"[C141]봉제의복 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004276:1', '{"dJobCd":"K000004276","dJobCdSeq":"1","dJobNm":"아리안스기조작원","workSum":"갑피와 밑창을 접착제로 붙인 구두를 꿰매기 위하여 아리안스기계를 조작한다.","doWork":"일정 온도로 송진과 식물유를 조합하여 용해한 액을 마사에 충분히 흡수시켜 만든 봉합사를 기계에 장치한다. 창을 위로 하여 앞코를 잡아 소뿔모양의 받침대 끝이 구두 속 깊은 곳까지 잘 받칠 수 있도록 골을 뺀 구두를 뒤집어씌운다. 노루발(누름쇠)을 내려 본창의 홈을 눌러 받침대와 맞물린다. 상하의 실을 잡아낸 후 기계를 돌려 홈을 따라 뒤꿈치에서 시작하여 앞코 쪽으로 돌려가며 꿰맨다. 기계를 멈추고 상하의 실을 자른 후 노루발을 올려 구두를 빼낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"투입인출","certLic":"신발제조기능사","dJobECd":"8649","dJobECdNm":"[8649]기타 직물·신발 기계 조작원 및 조립원","dJobJCd":"8229","dJobJCdNm":"[8229]기타 직물·신발 관련 기계 조작원 및 조립원","dJobICd":"C152","dJobICdNm":"[C152]신발 및 신발 부분품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001611:1', '{"dJobCd":"K000001611","dJobCdSeq":"1","dJobNm":"연단기조작원","workSum":"원단을 펼쳐 자르기 용이하도록 테이블 위에 원단을 펼치는 기계를 조작한다.","doWork":"작업지시서를 확인 후 작업에 필요한 원단을 수령하고 기계의 작동 여부를 확인한다. 원단을 연단기 보조테이블에 올려놓고 원단의 가장자리와 테이블 위의 표시가 일치하도록 손잡이를 돌린다. 원단이 테이블 끝에 걸리게 한다. 연단기 작동스위치를 조작한다. 원단이 펼쳐지면 착색, 구멍 등의 결점을 찾아 손가위로 제거한다. 원단이 재단하기 적당한 높이로 쌓이면 롤(Roll)로부터 원단을 자른다. 펼쳐진 원단을 자르는 재단원의 일을 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"시범후 30일 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","similarNm":"연단원, 연전원","dJobECd":"8649","dJobECdNm":"[8649]기타 직물·신발 기계 조작원 및 조립원","dJobJCd":"8229","dJobJCdNm":"[8229]기타 직물·신발 관련 기계 조작원 및 조립원","dJobICd":"C141","dJobICdNm":"[C141]봉제의복 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001401:1', '{"dJobCd":"K000001401","dJobCdSeq":"1","dJobNm":"원단재단기조작원","workSum":"연단한 원단을 자동으로 재단하는 자동재단기를 조작한다.","doWork":"작업지시서를 확인한 후 작업에 필요한 패턴모형을 확인한다. 기계의 이상 유무를 확인한 후 컴퓨터에 재단될 패턴모양을 입력한다. 연단된 원단을 재단기로 옮긴다. 기장과 폭을 확인한 후 패턴모형과 연단된 원단을 고정시킨다. 자동재단기를 작동하고 재단 상태를 관찰한다. 재단된 원단을 작업지시서와 비교·검토한다. 재단물을 정리·정돈하고 다음 공정으로 이송시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","similarNm":"컴퓨터재단기조작원","dJobECd":"8649","dJobECdNm":"[8649]기타 직물·신발 기계 조작원 및 조립원","dJobJCd":"8229","dJobJCdNm":"[8229]기타 직물·신발 관련 기계 조작원 및 조립원","dJobICd":"C141","dJobICdNm":"[C141]봉제의복 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006366:1', '{"dJobCd":"K000006366","dJobCdSeq":"1","dJobNm":"원모선별반장","workSum":"원모를 검사하여 형태 및 품목별로 구분하고 섬유의 번수 선별작업을 하는 데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"표준작업명세 및 생산량에 따라 작업계획을 세우고 세부실행항목을 수립하여 작업절차 및 방법을 결정한다. 작업계획에 따라 원모의 형태 및 품목별로 선별토록 작업원을 지시·배치한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원을 한다. 선별된 원모를 번수별로 재검사하여 창고에 보관토록 한다. 재검사 결과에 따라 개인별 선별작업을 지시하고, 이상 원모를 조사·보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"조정","workFunc2":"감독","workFunc3":"수동조작","certLic":"섬유산업기사","dJobECd":"8649","dJobECdNm":"[8649]기타 직물·신발 기계 조작원 및 조립원","dJobJCd":"8229","dJobJCdNm":"[8229]기타 직물·신발 관련 기계 조작원 및 조립원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005734:1', '{"dJobCd":"K000005734","dJobCdSeq":"1","dJobNm":"원모선별원","workSum":"섬유의 길이, 색깔, 순도를 육안, 감촉, 경험, 지시서에 따라 번수별, 품목별로 선별한다.","doWork":"작업지시서에 따라 원료를 운반하여 정리·적재한다. 먼지를 제거하기 위해 망이 설치된 작업대 위에 원료를 흔들어 펼쳐놓는다. 가시, 막대기, 끈과 같은 이물질을 제거한다, 원료를 여러 구분으로 나누고 품질에 따라서 각 부분품을 검사하고 분류한다. 원료를 포장한 마대를 정리하여 운반하고 작업장 주위를 청소한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"선모원","dJobECd":"8649","dJobECdNm":"[8649]기타 직물·신발 기계 조작원 및 조립원","dJobJCd":"8229","dJobJCdNm":"[8229]기타 직물·신발 관련 기계 조작원 및 조립원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006223:1', '{"dJobCd":"K000006223","dJobCdSeq":"1","dJobNm":"원피건조원","workSum":"화학 처리된 원피의 수분을 제거하고자 건조기를 조작한다.","doWork":"건조기의 이상 유무를 확인한다. 작업지시서를 확인하여 건조시킬 원피와 톱밥의 비율, 건조시간 등을 정한다. 화학 처리된 상태의 원피와 톱밥을 건조기에 투입하고 작동한다. 건조가 완료되면 원피를 꺼내 건조 상태를 확인한다. 수분이 제거된 원피를 다음 공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|다습|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8649","dJobECdNm":"[8649]기타 직물·신발 기계 조작원 및 조립원","dJobJCd":"8229","dJobJCdNm":"[8229]기타 직물·신발 관련 기계 조작원 및 조립원","dJobICd":"C142","dJobICdNm":"[C142]모피제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003422:1', '{"dJobCd":"K000003422","dJobCdSeq":"1","dJobNm":"원피깎기원","workSum":"기름이 침투되어 연화된 원피를 평평하게 늘려 가죽 면을 깎는다.","doWork":"작업명세서를 확인하여 원피의 종류에 따라 작업공정을 숙지한다. 스카이빙기의 작동유무를 확인한다. 원피의 가죽 면을 스카이빙기(Skiving)에 접촉시켜 가죽의 지방층과 두꺼운 면을 깎아낸다. 건조작업 후, 스트레칭 공정 후 등 각 공정 간에 2~3회 정도 반복하여 작업을 반복하여 수행한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|다습|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8649","dJobECdNm":"[8649]기타 직물·신발 기계 조작원 및 조립원","dJobJCd":"8229","dJobJCdNm":"[8229]기타 직물·신발 관련 기계 조작원 및 조립원","dJobICd":"C142","dJobICdNm":"[C142]모피제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001754:1', '{"dJobCd":"K000001754","dJobCdSeq":"1","dJobNm":"원피분할원","workSum":"원피를 여러 층으로 분할하는 기계를 조작한다.","doWork":"생산품목에 따라 작업지시서를 보고 가죽의 두께를 확인한다. 원피의 두께에 따라 기계의 핸들 및 고정나사를 조절한다. 기계벨트, 칼, 롤러 등 각 부품들이 원하는 위치로 조정되었는지 확인한다. 기계 롤러 사이로 원피를 넣고 기계스위치를 조작한다. 잘려진 원피의 은면(Grain)층 두께를 측정기계로 확인한다. 운반용구에 적재한다. 원피를 자르기 전에 부드럽게 하기 위해 물에 적시기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|다습|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"세밍작업원, 시보리작업원","dJobECd":"8649","dJobECdNm":"[8649]기타 직물·신발 기계 조작원 및 조립원","dJobJCd":"8229","dJobJCdNm":"[8229]기타 직물·신발 관련 기계 조작원 및 조립원","dJobICd":"C151","dJobICdNm":"[C151]가죽, 가방 및 유사제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003584:1', '{"dJobCd":"K000003584","dJobCdSeq":"1","dJobNm":"원피선별원","workSum":"원피의 모질상태에 따라 등급을 결정하고 분류한다.","doWork":"작업표준서를 확인하여 원피 등급기준을 숙지한다. 작업대 위에 원피를 한 묶음씩 포개어 놓는다. 원피의 분할로 만들어진 은면(Grain)층의 상태를 한 장씩 육안으로 검사한다. 오염 여부, 상처, 주름, 핀홀자국, 색상, 처리상태 및 주름을 검사하고 상급에서 하급으로 등급을 분류한다. 등급이 분류된 원피를 해당 행거에 걸어 적재한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"시각|","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8649","dJobECdNm":"[8649]기타 직물·신발 기계 조작원 및 조립원","dJobJCd":"8229","dJobJCdNm":"[8229]기타 직물·신발 관련 기계 조작원 및 조립원","dJobICd":"C151","dJobICdNm":"[C151]가죽, 가방 및 유사제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006333:1', '{"dJobCd":"K000006333","dJobCdSeq":"1","dJobNm":"원피제육제모원","workSum":"원피의 육질 및 기름덩이를 제거하는 기계(Fleshing Machine)를 조작한다.","doWork":"석회침(Liming)공정을 거친 원피를 수령한다. 기계를 작동시키고 육면을 칼날방향으로 놓는다. 원피의 머리 쪽을 반 정도 제육·제모하고 반대로 돌려서 나머지 부분을 제육·제모한다. 가장자리에 붙은 기름 및 기타 불필요한 부분을 칼로 제거한다. 털이 안으로 가게 하여 적재 통에 적재한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|다습|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"할피원","dJobECd":"8649","dJobECdNm":"[8649]기타 직물·신발 기계 조작원 및 조립원","dJobJCd":"8229","dJobJCdNm":"[8229]기타 직물·신발 관련 기계 조작원 및 조립원","dJobICd":"C151","dJobICdNm":"[C151]가죽, 가방 및 유사제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001902:1', '{"dJobCd":"K000001902","dJobCdSeq":"1","dJobNm":"원피톱밥태고조작원","workSum":"가죽의 유연성을 갖게 하고자 톱밥태고를 조작한다.","doWork":"톱밥태고의 작동상태를 파악한다. 톱밥 등의 부자재를 준비한다. 깎기작업이 완료된 원피를 수령한다. 원피가죽면의 유연성을 갖게 하고자 약간의 화학약품과 톱밥을 넣은 태고에 원피를 넣고 회전시켜준다. 태고의 회전상태를 관찰한다. 1차 공정이 끝나면 원피를 꺼내고 새로운 톱밥을 넣고 다시 태고를 회전시킨다. 작업이 완료되면 원피의 유연성을 확인한 후 다음 공정으로 이송시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8649","dJobECdNm":"[8649]기타 직물·신발 기계 조작원 및 조립원","dJobJCd":"8229","dJobJCdNm":"[8229]기타 직물·신발 관련 기계 조작원 및 조립원","dJobICd":"C142","dJobICdNm":"[C142]모피제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005264:1', '{"dJobCd":"K000005264","dJobCdSeq":"1","dJobNm":"원피화학처리원","workSum":"가공되지 않은 건조된 상태의 원피(Raw Skin)의 기름을 제거하기 위해 화학처리를 한다.","doWork":"건조된 상태의 원피를 수령 받아 털 쪽의 불순물을 제거한다. 원피의 기름제거및 화학약품의 침투를 용이하게 하고자 소금과 약품을 넣은 물 태고에 투입한다. 처리 원피를 꺼내어 세척시킨다. 원피의 상품적 가치를 높이기 위하여 가죽표면에 화학처리 및 ACID(산)기를 침투시켜 가죽의 조직을 이완시켜 준다. 백반을 사용하여 가죽조직을 장기간 보관에도 부패되지 않도록 방부처리 한다. 작업이 완료된 원피를 다음 공정으로 이송시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|다습|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"소킹원","dJobECd":"8649","dJobECdNm":"[8649]기타 직물·신발 기계 조작원 및 조립원","dJobJCd":"8229","dJobJCdNm":"[8229]기타 직물·신발 관련 기계 조작원 및 조립원","dJobICd":"C142","dJobICdNm":"[C142]모피제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001287:1', '{"dJobCd":"K000001287","dJobCdSeq":"1","dJobNm":"이불면입원","workSum":"이불을 제조하기 위해 일정 두께의 솜에 안감을 씌우는 일을 한다.","doWork":"이불안감을 작업대 위에 펼친다. 규정된 두께와 양의 솜을 작업대의 이불안감 위에 고르게 펴놓는다. 이불안감의 모서리를 접고 안감의 입구를 통하여 뒤집는다. 뒤집어진 솜과 안감을 바르게 펴서 고르게 한다. 안감이 씌워진 이불을 접어 묶어 놓는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8649","dJobECdNm":"[8649]기타 직물·신발 기계 조작원 및 조립원","dJobJCd":"8229","dJobJCdNm":"[8229]기타 직물·신발 관련 기계 조작원 및 조립원","dJobICd":"C132","dJobICdNm":"[C132]직물직조 및 직물제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007162:1', '{"dJobCd":"K000007162","dJobCdSeq":"1","dJobNm":"자동차시트제조원","workSum":"원단을 재단하고 봉제하여 자동차 시트커버 및 허리 쿠션 등을 제조한다.","doWork":"업체에서 원단(합성피혁 또는 천연가죽)과 스펀지, 고무밴드 등과 같은 부자재가 입고되면 심미적인 효과를 높이기 위해 열처리 등 화학적, 물리적 방법으로 원단을 가공 처리한다. 컴퓨터(CAD, CAM)로 작성된 설계도면에 따라 원단을 재단용 칼로 정밀하게 재단하고 재단된 원단을 재봉틀(본봉, 쌍침 등)로 봉제한다. 차량 의자에 결속하기 위한 지퍼, 끈, 벨크로 등을 부착한다. 차종, 원단 재질에 따라 봉제방법을 변형, 완성된 제품을 자동차시트품질검사원에게 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8649","dJobECdNm":"[8649]기타 직물·신발 기계 조작원 및 조립원","dJobJCd":"8229","dJobJCdNm":"[8229]기타 직물·신발 관련 기계 조작원 및 조립원","dJobICd":"C303","dJobICdNm":"[C303]자동차 신품 부품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005964:1', '{"dJobCd":"K000005964","dJobCdSeq":"1","dJobNm":"자루제조반장","workSum":"직물자루를 제조하기 위해 절단, 재봉, 검사 및 뒤집는 일을 하는 작업원의 활동을 감독·조정한다.","doWork":"명세서와의 일치 여부를 확인하기 위해 여러 공정단계의 자루를 측정하고 검사한다. 자루의 규격을 바꾸기 위해 기계조절을 지시하거나 작업절차를 바꾼다. 작업의 진행사항을 파악하고 작업내용을 보고한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원 및 자재를 공급한다. 작업계획에 따라 세부실행항목을 수립하고 작업절차 및 방법을 결정하여 작업원에게 작업내용을 지시하고 작업을 배치한다. 표준작업명세에 따라 지시된 작업이 이루어지는지 작업상황을 관찰하며 작업내용을 점검한다. 작업원의 직무교육 및 안전위생교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴·해결하고 문제점을 보완한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"수동조작","dJobECd":"8649","dJobECdNm":"[8649]기타 직물·신발 기계 조작원 및 조립원","dJobJCd":"8229","dJobJCdNm":"[8229]기타 직물·신발 관련 기계 조작원 및 조립원","dJobICd":"C132","dJobICdNm":"[C132]직물직조 및 직물제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001716:1', '{"dJobCd":"K000001716","dJobCdSeq":"1","dJobNm":"재봉틀지도원","workSum":"봉재기술에 관한 지식을 이용하여 각종 재봉틀을 다루는 방법을 작업원에게 가르친다.","doWork":"작업원에게 재봉틀의 부품 및 기능을 설명한다. 작업원에게 실 꿰는 법, 바늘 갈아 끼우는 법, 유도장치 바꾸는 법, 기름 치는 법, 기계작동법 등을 설명하고 교육시킨다. 작업공정에 따라 필요한 봉재기술을 교육한다. 작업원과 작업을 병행하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"교육","workFunc3":"수동조작","certLic":"양복기능사, 양장기능사","dJobECd":"8649","dJobECdNm":"[8649]기타 직물·신발 기계 조작원 및 조립원","dJobJCd":"8229","dJobJCdNm":"[8229]기타 직물·신발 관련 기계 조작원 및 조립원","dJobICd":"C141/C144","dJobICdNm":"[C141]봉제의복 제조업 / [C144]의복 액세서리 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004996:1', '{"dJobCd":"K000004996","dJobCdSeq":"1","dJobNm":"재용선별원","workSum":"소면, 연조, 조방, 정방공정에서 발생한 낙면을 다시 사용하기 위해 분류하고 불순물을 제거한다.","doWork":"각 공정에서 들어온 낙면을 작업대에 올려놓는다. 낙면을 사용용도에 따라 굵기, 색상, 염색성, 길이 등으로 구분하여 재활용 섬유를 분류한다. 섬유 중에 포함된 불순물(쇠붙이, 기름오염, 실발)을 제거한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8649","dJobECdNm":"[8649]기타 직물·신발 기계 조작원 및 조립원","dJobJCd":"8229","dJobJCdNm":"[8229]기타 직물·신발 관련 기계 조작원 및 조립원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002881:1', '{"dJobCd":"K000002881","dJobCdSeq":"1","dJobNm":"저인망제조원","workSum":"저인망을 제조하기 위해 망 부분품 모형을 그리고 수동공구를 사용하여 부분품을 부착한다.","doWork":"필요한 그물눈의 수를 세고 기본도에 따라 자, 연필, 크레용을 사용하여 종이 위에 망 부분품의 모형을 그린다. 가위로 종이모형을 자른다. 작업대나 바닥에 망을 만들 재료를 펼쳐 놓고 종이모형에 따라 가위로 망 부분품을 자른다. 망 부분품을 핀이나 틀에 걸어 솔기가 일직선이 되도록 손과 발로 솔기를 잡는다. 북을 이용하여 그물눈의 부분품을 꿰매고 솔기가 단단하게 묶이도록 그물눈의 매듭 주위를 반맺음으로 묶는다. 끈을 이용해서 버팀망으로부터 고기를 갑판에 풀어놓는 트랩으로 사용되는 자루를 망의 일정 부위에 부착한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"쓰레그물제조원, 트롤망제조원","dJobECd":"8649","dJobECdNm":"[8649]기타 직물·신발 기계 조작원 및 조립원","dJobJCd":"8229","dJobJCdNm":"[8229]기타 직물·신발 관련 기계 조작원 및 조립원","dJobICd":"C139","dJobICdNm":"[C139]기타 섬유제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005327:1', '{"dJobCd":"K000005327","dJobCdSeq":"1","dJobNm":"줄부착원","workSum":"자루의 가장자리에 주름잡은 줄을 집어넣고 뒤집는 기계를 다룬다.","doWork":"연결실에 의해 연결된 자루를 공급통 위에 오게 하고 기계의 공급 에이프런 위에 자루 끝을 건다. 레버를 움직여 기계를 가동하고 자동으로 자루 사이에 연결할 실을 가장자리 안에 주름잡은 줄에 끼워 자루를 뒤집는다. 기계의 방출단으로부터 자루를 꺼내고 술을 다는 데 결함이 없는지를 검사한 다음 포장하기 위해 상자에 자루를 넣는다. 줄을 다는 바늘에 실을 꿰기 위해 실을 뽑아 기계의 가이드와 바늘귀에 건다. 가공한 자루의 수를 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"시범후 30일 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8649","dJobECdNm":"[8649]기타 직물·신발 기계 조작원 및 조립원","dJobJCd":"8229","dJobJCdNm":"[8229]기타 직물·신발 관련 기계 조작원 및 조립원","dJobICd":"C139","dJobICdNm":"[C139]기타 섬유제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005456:1', '{"dJobCd":"K000005456","dJobCdSeq":"1","dJobNm":"천막제조반장","workSum":"범포, 합성섬유 및 비닐로 만들어진 차일, 선박덮개, 휘장 및 바탕천, 방수포, 텐트 등을 제조하고 수리하는 데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"재료의 재단, 절단, 조립 및 바느질에 종사하는 작업원을 감독한다. 표준작업계획 및 생산량 등에 의해 생산계획을 수립하고 작업내용을 작업원에게 지시한다. 작업도구의 이상 유무를 확인하고 안전교육을 실시한다. 제품 표준과 완성품을 비교하여 구멍이나 빠뜨린 결함이 있는지 제품을 검사한다. 손상되거나 낡은 물품을 수선하는 일의 비용을 견적한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"수동조작","similarNm":"텐트제조반장","dJobECd":"8649","dJobECdNm":"[8649]기타 직물·신발 기계 조작원 및 조립원","dJobJCd":"8229","dJobJCdNm":"[8229]기타 직물·신발 관련 기계 조작원 및 조립원","dJobICd":"C132","dJobICdNm":"[C132]직물직조 및 직물제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003353:1', '{"dJobCd":"K000003353","dJobCdSeq":"1","dJobNm":"천막제조원","workSum":"방수 처리한 직물, 플라스틱, 고무 및 기타 재료 위에 도안하고 천막, 텐트 및 방수포를 제조·조립한다.","doWork":"분필이나 매직 등을 사용해 도면에 따라 재료 위에 재단자를 대어 도면을 그리고 가위나 동력절단기를 사용하여 재료를 자른다. 부품들을 동력재봉기로 봉합한다. 펀칭기(구멍 뚫는 기계)를 가동하여 필요한 부분에 구멍을 뚫고 밧줄 고리, 금속부속품 및 죔쇠 등을 장치한다. 밧줄 고리를 수동으로 보합할 경우 재료 위에 밧줄 고리구멍의 치수를 측정하고 표시하며 나무메(나무로 된 망치종류:Mallet), 펀치, 단단한 나무토막, 골무, 실 등을 사용하여 아연철 고리를 구멍 가장자리에 봉합한다. 줄이나 케이블을 완성부품에 고착한다. 완성품을 검사한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"텐트제조원","dJobECd":"8649","dJobECdNm":"[8649]기타 직물·신발 기계 조작원 및 조립원","dJobJCd":"8229","dJobJCdNm":"[8229]기타 직물·신발 관련 기계 조작원 및 조립원","dJobICd":"C132","dJobICdNm":"[C132]직물직조 및 직물제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005661:1', '{"dJobCd":"K000005661","dJobCdSeq":"1","dJobNm":"침구제조반장","workSum":"베개, 방석, 이불 등 침구제품을 제조하는 작업원의 활동을 감독·조정한다.","doWork":"베개, 방석, 이불 등 침구류 제품의 종류별 제조량에 따라 생산계획을 수립한다. 생산계획에 따라 일별 제조물량 등 세부생산계획을 수립하여 작업절차 및 방법을 결정한다. 작업원에게 작업배치를 하고 작업내용을 지시한다. 작업공정에 필요한 자재 및 기술을 지원한다. 작업원에 대한 직무교육 및 안전교육을 실행하여 직무수행능력을 향상시키고 안전재해를 예방한다. 결함이 있는 바느질, 헐거운 실, 변색, 자투리 등을 찾기 위해 침구류를 검사한다. 작업대 위에 제품을 펼쳐 놓고 줄자를 사용하여 제품의 치수를 측정한다. 제품규격에 부합하도록 생산되었는지 검사하여 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"수동조작","similarNm":"침구봉제반장","certLic":"섬유산업기사","dJobECd":"8649","dJobECdNm":"[8649]기타 직물·신발 기계 조작원 및 조립원","dJobJCd":"8229","dJobJCdNm":"[8229]기타 직물·신발 관련 기계 조작원 및 조립원","dJobICd":"C132","dJobICdNm":"[C132]직물직조 및 직물제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002014:1', '{"dJobCd":"K000002014","dJobCdSeq":"1","dJobNm":"품선원","workSum":"섬유의 특성, 등급, 질 등 원면의 품질과 등급을 결정하는 기준에 따라 면을 분류한다.","doWork":"원면에서 시료를 채취하여 다래(목화의 덜 익은 열매), 씨, 가지, 모래, 먼지, 잎, 넵(Nep)등의 불순물의 비율을 육안으로 검사한다. 원면에서 일정량의 섬유를 뽑아 장방형 형태로 만들어 검은 바탕의 측정대에 놓고, 면 등급원칙에 따라 길이를 측정한다. 서로 연결된 섬유의 질, 섬유소의 적합성, 검사결과 등을 보면서 등급, 섬유길이 및 특성을 결정하고 등급기준에 따라 섬유를 분류한다. 섬유의 꼬임이나 매끄러움을 확인하기 위해 현미경으로 섬유질을 검사하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"면분류원","certLic":"섬유산업기사","dJobECd":"8649","dJobECdNm":"[8649]기타 직물·신발 기계 조작원 및 조립원","dJobJCd":"8229","dJobJCdNm":"[8229]기타 직물·신발 관련 기계 조작원 및 조립원","dJobICd":"C131","dJobICdNm":"[C131]방적 및 가공사 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001886:1', '{"dJobCd":"K000001886","dJobCdSeq":"1","dJobNm":"프레스재단사","workSum":"일정한 높이로 연단된 원단을 재단하기 위해 프레스를 조작한다.","doWork":"작업지시서를 확인한 후 프레스의 작동상태를 확인한다. 재단할 모양의 철형을 준비한다. 원단을 프레스기에 올려놓고 그 위에 철형을 놓는다. 프레스를 작동하여 철형에 따라 원단을 재단한다. 재단물의 종류 및 크기별로 분류하고 꼬리표를 부착하여 번호를 표시한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"유압철형재단원, 철형재단원","dJobECd":"8649","dJobECdNm":"[8649]기타 직물·신발 기계 조작원 및 조립원","dJobJCd":"8229","dJobJCdNm":"[8229]기타 직물·신발 관련 기계 조작원 및 조립원","dJobICd":"C141/C144","dJobICdNm":"[C141]봉제의복 제조업 / [C144]의복 액세서리 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003413:1', '{"dJobCd":"K000003413","dJobCdSeq":"1","dJobNm":"회전드럼반장","workSum":"회전드럼통을 조작하는 작업원의 활동을 감독·조정한다.","doWork":"각 공정에 따라 작업지시서를 확인하고 작업계획을 수립한다. 작업계획에 따라 세부실행항목을 수립한다. 작업절차 및 방법을 결정하여 작업원에게 작업내용을 지시하고 작업배치를 한다. 작업지시서에 따라 각종 약품 및 자재를 청구하여 공급한다. 작업의 진행사항을 파악하고 작업내용을 보고한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원 및 자재를 공급한다. 표준작업명세에 따라 지시된 작업이 이루어지는지 작업원과 함께 작업한다. 작업원의 직무교육 및 안전위생교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴·해결하고 문제점을 보완한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|다습|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","dJobECd":"8649","dJobECdNm":"[8649]기타 직물·신발 기계 조작원 및 조립원","dJobJCd":"8229","dJobJCdNm":"[8229]기타 직물·신발 관련 기계 조작원 및 조립원","dJobICd":"C151","dJobICdNm":"[C151]가죽, 가방 및 유사제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006215:1', '{"dJobCd":"K000006215","dJobCdSeq":"1","dJobNm":"회전드럼조작원","workSum":"원피를 육질에서 가죽으로 가공하기 위해 여러 공정의 회전 드럼통을 조작한다.","doWork":"생산할 원피의 종류에 따라 작업지시서를 확인하고 물의 온도, 가동시간, 약품의 종류 등을 숙지한다. 수세(Soaking), 석회(Liming), 탈회(Deliming), 유제(Tanning), 염색(Dyeing), 무두질(Milling), 광택(Polishing)공정에서 해당 작업지시서에 따라 각종 약품을 계량한다. 드럼통에 처방된 약품과 가죽을 넣는다. 드럼통의 온·냉수 스위치를 조절하여 지정온도의 물을 채운다. 온도계로 온도를 확인한다. 드럼통의 문을 닫는다. 드럼통의 시간 스위치를 조작하고 드럼통을 회전시킨다. 일정 시간이 지나면 드럼통 문을 열고 약품을 배출한다. 드럼통에서 가죽을 꺼내어 걸대 위에 걸어 놓는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"힘든 작업","workPlace":"실내","workEnv":"대기환경미흡|다습|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8649","dJobECdNm":"[8649]기타 직물·신발 기계 조작원 및 조립원","dJobJCd":"8229","dJobJCdNm":"[8229]기타 직물·신발 관련 기계 조작원 및 조립원","dJobICd":"C151","dJobICdNm":"[C151]가죽, 가방 및 유사제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006029:1', '{"dJobCd":"K000006029","dJobCdSeq":"1","dJobNm":"다림질기조작원","workSum":"의복의 표면을 부드럽게 하고 모양을 바로잡기 위하여 프레스를 조작한다.","doWork":"프레스 위에 의복을 펴서 놓는다. 의복을 잡아당기면서 페달을 밟아 의류를 고정시킨다. 증기가 나오도록 프레스 버튼을 누른다. 일정 시간이 경과한 후 프레스 버튼을 끈다. 의류를 빼내기 위하여 페달을 놓는다. 작업일지에 기록하고 작업지시서를 확인한 후 다음 물량을 처리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"힘든 작업","workPlace":"실내","workEnv":"대기환경미흡|고온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"스팀다림질원","connectJob":"가죽다림질원","dJobECd":"8643","dJobECdNm":"[8643]세탁 기계 조작원","dJobJCd":"8230","dJobJCdNm":"[8230]세탁 관련 기계 조작원","dJobICd":"C141/S969","dJobICdNm":"[C141]봉제의복 제조업 / [S969]그 외 기타 개인 서비스업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006392:1', '{"dJobCd":"K000006392","dJobCdSeq":"1","dJobNm":"다림질반장","workSum":"의복을 다리는 일에 종사하는 작업원의 활동을 감독·조정한다.","doWork":"다리미 기계의 조작 및 설치방법을 교육시킨다. 다림질된 의복을 점검하고 이상이 있으면 다림질 방법을 수정하도록 지시한다. 작업내용에 따라 작업원에게 지시·배치한다. 작업의 진행사항을 파악하고 작업내용을 보고한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원 및 자재를 공급한다. 작업계획에 따라 세부실행항목을 수립하고 작업절차 및 방법을 결정하여 작업원에게 작업내용을 지시하고 작업배치를 한다. 표준작업명세에 따라 지시된 작업이 이루어지는지 작업원과 함께 작업하며 작업상황을 관찰하고 작업내용을 점검한다. 작업원의 직무교육 및 안전위생교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴·해결하고 문제점을 보완한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|고온|","workFunc1":"조정","workFunc2":"감독","workFunc3":"수동조작","dJobECd":"8643","dJobECdNm":"[8643]세탁 기계 조작원","dJobJCd":"8230","dJobJCdNm":"[8230]세탁 관련 기계 조작원","dJobICd":"C141/S969","dJobICdNm":"[C141]봉제의복 제조업 / [S969]그 외 기타 개인 서비스업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005873:1', '{"dJobCd":"K000005873","dJobCdSeq":"1","dJobNm":"다림질원","workSum":"가압기, 증기다리미, 전기다리미 등을 사용하여 세탁물의 형태를 바로잡아 광택과 탄력을 주고 주름을 잡는다.","doWork":"세탁·건조한 세탁물의 종류와 형태에 따라 마무리하기 위한 방법과 기계의 종류, 다리미의 온도 등을 결정한다. 세탁물을 가압기 또는 기타 마무리용 기계에 펴놓고 기계를 조작하여 주름을 잡는다. 세탁물의 형태에 따라 여러 가지 형태의 받침판을 사용하여 광택 및 탄력을 준다. 다림질이 끝나면 의류의 각 부위를 점검하여 다림질 상태를 확인하고 옷걸이에 건다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|고온|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"세탁물마무리원","dJobECd":"8643","dJobECdNm":"[8643]세탁 기계 조작원","dJobJCd":"8230","dJobJCdNm":"[8230]세탁 관련 기계 조작원","dJobICd":"C141/S969","dJobICdNm":"[C141]봉제의복 제조업 / [S969]그 외 기타 개인 서비스업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004175:1', '{"dJobCd":"K000004175","dJobCdSeq":"1","dJobNm":"대형세탁기조작원","workSum":"대량의 세탁물을 세탁기 안에 집어넣고 세탁물의 특성에 따라 세탁시간과 세제를 조정한다.","doWork":"연속식 세탁기(터널세탁기)라고 불리는 대형세탁기에 세탁물을 주기적으로 투입한다. 세탁물의 강도나 때의 농도에 따라 세탁시간을 조정하고 세제량을 조절한다. 세탁물의 특성에 따라 염소계 표백제, 섬유유연제, 중화제 등을 사용한다. 세탁이 완료된 후 세탁물을 다음 공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"시범후 30일 이하","workStrong":"힘든 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"유지","dJobECd":"8643","dJobECdNm":"[8643]세탁 기계 조작원","dJobJCd":"8230","dJobJCdNm":"[8230]세탁 관련 기계 조작원","dJobICd":"S969","dJobICdNm":"[S969]그 외 기타 개인 서비스업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002217:1', '{"dJobCd":"K000002217","dJobCdSeq":"1","dJobNm":"드라이클리닝원","workSum":"유기용제를 사용하여 양복, 드레스, 모포 등 물세탁을 할 수 없는 섬유제품들을 세탁하고자 드라이클리닝기를 조작한다.","doWork":"세탁물의 종류와 양에 따라 용제의 농도와 드라이클리닝기의 조작방법을 검토한다. 세탁하기에 알맞은 상태로 유량, 유속, 산가, 투과율, 세제 등을 조정한다. 세탁과정에서 제거하기 어려운 얼룩을 제거하고자 용제와 세제를 사용하여 얼룩을 제거한다. 세탁물을 드라이클리닝기에 넣고 결정된 세탁방법, 시간, 회전수 등을 조정하는 기계를 가동한다. 세탁이 완료되면 세탁물을 확인하여 상태를 검사하고 용제를 회수하고자 드라이클리닝기의 여과장치를 조작한다. 용제의 여과가 완료되면 건조장치를 가동하여 물기를 제거한다. 물과 세제를 사용하여 내의, 양말, 운동복 등의 섬유제품을 세탁하기도 한다. 모피제품, 가죽제품, 카펫 등의 품목을 전문적으로 세탁하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|다습|소음·진동|","workFunc1":"수집","workFunc2":"서비스제공","workFunc3":"제어조작","certLic":"세탁기능사","dJobECd":"8643","dJobECdNm":"[8643]세탁 기계 조작원","dJobJCd":"8230","dJobJCdNm":"[8230]세탁 관련 기계 조작원","dJobICd":"S969","dJobICdNm":"[S969]그 외 기타 개인 서비스업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006579:1', '{"dJobCd":"K000006579","dJobCdSeq":"1","dJobNm":"살균세탁원","workSum":"가정, 건물, 사업장을 대상으로 장난감, 운동화, 소파 등에 포함된 먼지, 진드기 등을 스팀청소기, 자외선살균기, 세탁기, 항균제 등을 사용하여 살균 및 청소한다.","doWork":"살균, 청소 대상 품목을 고객과 협의한다. 사용할 살균기, 청소기, 세탁기를 준비한다. 살균기, 청소기, 세탁기에 장난감, 신발 등을 넣고 기기를 가동한다. 기기를 사용하여 대상품에 직접 분무한다. 청소기, 세탁기, 살균기의 가동상태를 모니터링한다. 청소, 살균 여부에 대하여 검사한다. 살균기, 청소기, 세탁기를 점검한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"시범후 30일 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"웅크림|","workFunc1":"수집","workFunc2":"서비스제공","workFunc3":"유지","dJobECd":"8643","dJobECdNm":"[8643]세탁 기계 조작원","dJobJCd":"8230","dJobJCdNm":"[8230]세탁 관련 기계 조작원","dJobICd":"S969","dJobICdNm":"[S969]그 외 기타 개인 서비스업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005981:1', '{"dJobCd":"K000005981","dJobCdSeq":"1","dJobNm":"가스공급관리원","workSum":"수용가에 가스를 감압해서 안전하게 공급하고자 제어패널을 조정해 공급설비를 조작·관리한다.","doWork":"가스 공급설비의 전원 상태, 계기패널, 밸브조정패널을 점검한다. 가스 누출을 알리는 경보기의 작동 여부를 확인한다. 생산된 가스를 일정 압력으로 감압하여 수용가(일반, 업무용, 산업용)에 보내기 위하여 공급설비의 제어패널에 온도, 유량, 압력 등의 수치를 입력한다. 각종 밸브, 가스필터(정압기 및 유량계 등의 설비가 수송가스 중의 이 물질에 의해 손상되는 것을 막기 위해 가스를 여과하는 설비), 가스히터(정압기를 통한 감압 시 발생하는 온도 강하에 따른 가스의 상태변화 및 주변기기와 배관시설이 저온에서 손상되는 것을 방지하기 위해 수송가스를 가열하는 설비), 정압기(고압으로 수송된 가스를 미리 설정된 압력으로 감압하는 설비), 계량기(수요처에 공급되는 가스의 유량을 측정하기 위한 설비) 등의 가스 공급설비를 제어패널의 수치에 맞도록 조작·관리한다. 가스공급설비 제어패널의 이상 및 장애요인이 발생하면 공급설비를 현장 조작원에게 점검하도록 하고 조치사항을 보고하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"가스감압설비조작원","certLic":"가스기능사, 가스산업기사","dJobECd":"8511","dJobECdNm":"[8511]석유·천연가스 제조 제어장치 조작원","dJobJCd":"8311","dJobJCdNm":"[8311]석유 및 천연가스 제조 관련 제어 장치 조작원","dJobICd":"D352","dJobICdNm":"[D352]연료용 가스 제조 및 배관공급업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006186:1', '{"dJobCd":"K000006186","dJobCdSeq":"1","dJobNm":"가스생산설비기계관리원","workSum":"가스를 안전하게 생산하기 위한 하역·저장·액화·공급 관련 기계설비의 유지·관리 및 설비 개선 업무를 한다.","doWork":"가스 생산을 위한 하역·저장 설비(하역배관, 저장탱크 등), 액화·생산 설비(증발가스 압축기, 재액화설비, 2차 펌프, 해수식기화기, 연소식기화기 등)를 점검하고 유지·관리한다. 각종 기계설비의 정비계획을 수립하고 일상점검, 계획점검, 돌발사고 시 점검 등을 통하여 설비의 이상 및 장애요인을 제거하기 위한 정비를 수행하고 문제가 발생한 설비의 이력관리를 통하여 체계적인 관리가 이루어지도록 한다. 예방정비 및 계획정비를 통하여 설비의 이상 및 장애요인을 제거하여 정상적인 작동과 재해를 미연에 방지한다. 각종 기계설비에 대한 설계도면, 시방서, 기술서, 절차서 등을 체계적으로 관리하고, 정비에 따른 문제점을 제시하여 설비개선을 위한 방안을 강구한다. 가스 생산에 따른 각종 기계설비의 신·증설 및 개·보수 공사에 따른 시공감독 및 감리업무와 공사공정관리를 한다. 각종 공사에 따른 용역 관련 기술행정 업무를 수행한다. 각종 설비자재에 대한 품질검사를 실시한다. 각종 국내외 기술자료를 수집하고 설비개선을 위한 연구를 한다. 가스생산 기계설비를 정확하고 효율적으로 유지·관리하고자 전문적인 담당 분야를 설정하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"설비개선기계원, 유틸리티기계원, 프로세스기계원","certLic":"가스기사, 일반기계기사, 건설기계설비기사, 용접기사","dJobECd":"8511","dJobECdNm":"[8511]석유·천연가스 제조 제어장치 조작원","dJobJCd":"8311","dJobJCdNm":"[8311]석유 및 천연가스 제조 관련 제어 장치 조작원","dJobICd":"D352","dJobICdNm":"[D352]연료용 가스 제조 및 배관공급업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002612:1', '{"dJobCd":"K000002612","dJobCdSeq":"1","dJobNm":"가스생산설비현장운전원","workSum":"가스를 안전하게 생산하기 위해 필요한 각종 설비의 이상요인 및 작동상태를 감시하고 현장에서 운전한다.","doWork":"가스생산중앙조정원으로부터 생산계획과 주요 작업내용을 전달받는다. 설비의 작동상태를 현장에서 확인하고 점검한다. 생산설비를 기동하고 정비하고자 작업절차에 따라 작업을 준비한다. 중앙조정실에서 제어되지 않는 주요 전원을 조작한다. 생산설비의 운전상황 및 작동상태를 감시한다. 주요작업 내용과 특이사항을 작업일지에 기록한다. 중앙조정실에 주요사항을 보고한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|","workEnv":"대기환경미흡|위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"조작운전","connectJob":"기화설비운전원, 송출설비운전원, 승압설비운전원, 저장설비운전원, 하역설비운전원, 해수설비운전원","dJobECd":"8511","dJobECdNm":"[8511]석유·천연가스 제조 제어장치 조작원","dJobJCd":"8311","dJobJCdNm":"[8311]석유 및 천연가스 제조 관련 제어 장치 조작원","dJobICd":"D352","dJobICdNm":"[D352]연료용 가스 제조 및 배관공급업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003107:1', '{"dJobCd":"K000003107","dJobCdSeq":"1","dJobNm":"가스생산중앙조정원","workSum":"가스를 안전하게 수요자에게 보내기 위한 각종 부속설비를 점검하고 중앙조종실의 계기반을 제어한다.","doWork":"가스생산량, 압력, 온도 등의 작업내용 및 생산계획을 중앙조종실에서 지시받는다. 생산설비의 운전상황 및 작동상태를 감시한다. 작업내용과 주요사항은 현장 작업자에게 전달한다. 모니터 및 계기판을 통해 생산설비의 유량, 온도, 압력 및 가동상태를 감시한다. 생산공정계통의 주요 설비부분의 운전사항을 지속적으로 감시하고 기록한다. 현장의 작업내용, 운전변화사항, 주요 지시사항 등을 다음 근무자에게 인계한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"기화송출설비원, 유틸리티중앙조정원, 하역저장설비원","certLic":"위험물기능사, 가스기능사","dJobECd":"8511","dJobECdNm":"[8511]석유·천연가스 제조 제어장치 조작원","dJobJCd":"8311","dJobJCdNm":"[8311]석유 및 천연가스 제조 관련 제어 장치 조작원","dJobICd":"D352","dJobICdNm":"[D352]연료용 가스 제조 및 배관공급업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003814:1', '{"dJobCd":"K000003814","dJobCdSeq":"1","dJobNm":"그리스제조원","workSum":"그리스(Grease)를 제조하기 위한 공정인 용해조, 반응조 및 냉각조 등을 조작하여 그리스제품을 생산한다.","doWork":"작업표준에 따라 그리스(Grease:기계의 마찰부분에 쓰는 끈적끈적한 윤활유) 원료 및 첨가제의 저장탱크를 확인하고 각각의 밸브를 조작하여 유량계를 확인하면서 일정량을 용해조탱크에 투입한다. 원료와 첨가제가 완전히 용해된 후 잔류오일을 투입한다. 용해조의 용해액을 반응탱크로 이송한다. 투입량은 유량계를 통하여 제어하고 반응탱크 내의 온도, 시간 등을 조정판에 입력한 후 가동한다. 반응이 완료되면 반응기 내부를 일정 온도와 압력으로 조정하여 수분을 배출시킨다. 수분이 모두 제거되었으면 기타 첨가제를 계량하여 반응조에 투입하고 스팀밸브를 조작하여 일정 온도까지 올린다. 일정 시간 온도를 유지한 후 냉각탱크로 이송한다. 냉각수 밸브를 열고 일정 온도까지 급냉한다. 냉각조 내의 냉각수 순환을 위하여 리사이클(Recycle) 조작을 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8511","dJobECdNm":"[8511]석유·천연가스 제조 제어장치 조작원","dJobJCd":"8311","dJobJCdNm":"[8311]석유 및 천연가스 제조 관련 제어 장치 조작원","dJobICd":"C192","dJobICdNm":"[C192]석유 정제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002390:1', '{"dJobCd":"K000002390","dJobCdSeq":"1","dJobNm":"매립가스발전장치조작원","workSum":"매립가스(Landfill Gas)를 이용하여 전력을 생산하기 위해 보일러와 스팀 터빈기를 조작하고 생산된 전력을 승압하여 송전한다.","doWork":"전처리 과정을 거친 매립가스를 이용하여 전력을 생산하기 위해 보일러, 스팀터빈기, 발전기 및 각종 보조기기(버너, 공기예열기, 복수기, 냉각기)를 조작제어하고 생산된 전력을 변압기를 통해 승압하여 송전한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"발전시설운전원","dJobECd":"8511","dJobECdNm":"[8511]석유·천연가스 제조 제어장치 조작원","dJobJCd":"8311","dJobJCdNm":"[8311]석유 및 천연가스 제조 관련 제어 장치 조작원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005970:1', '{"dJobCd":"K000005970","dJobCdSeq":"1","dJobNm":"매립가스정제원","workSum":"매립가스를 정제하기 위해 불순물(H2S:황화수소) 제거 설비(Gas Treatment System:전처리시설)를 운전·관리한다.","doWork":"포집된 매립가스(Landfill Gas)를 사용시설로 공급하기 전 황화수소를 제거하기 위한 전처리설비를 운전관리한다. 설비의 가동상태를 모니터링하고 이상이 발생하면 조치한다. 메탄으로 인한 폭발과 화재 위험, 바이오가스 플랜트의 안전운영을 위해 포집된 메탄가스를 간이소각기나 중앙소각장치를 이용해서 소각 처리한다. 정제가 완료된 가스는 공급시설로 이송시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8511","dJobECdNm":"[8511]석유·천연가스 제조 제어장치 조작원","dJobJCd":"8311","dJobJCdNm":"[8311]석유 및 천연가스 제조 관련 제어 장치 조작원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004420:1', '{"dJobCd":"K000004420","dJobCdSeq":"1","dJobNm":"바이오가스플랜트유지관리원","workSum":"바이오가스를 이용해 전력을 생산하는 바이오가스 플랜트의 각종 시설과 설비를 유지·관리한다.","doWork":"간이소각기, 탈취분사 시설, 전력생산시설, 외곽헤더관 등 바이오가스를 이용해 전력을 생산하기 위한 플랜트 설비의 시설 유지관리를 한다. 보일러, 터빈, 급수펌프, 순환수펌프, 복수펌프, 냉각탑, 폐수처리 계통 등 각종 설비에 이상이 없는지 점검하고, 고장이 발생하면 바이오가스플랜트설비기술자에게 보고한다. 소방시설, 안전 및 재해방지 관리를 한다. 악취 제거시설을 이용해 악취를 제거하고 오염을 관리하는 등 주변환경 정비활동을 한다. 나무와 꽃을 심어 녹지를 조성하는 등 환경개선사업을 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"LFG발전시설관리자","dJobECd":"8511","dJobECdNm":"[8511]석유·천연가스 제조 제어장치 조작원","dJobJCd":"8311","dJobJCdNm":"[8311]석유 및 천연가스 제조 관련 제어 장치 조작원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007304:1', '{"dJobCd":"K000007304","dJobCdSeq":"1","dJobNm":"석유화학공정제어원","workSum":"석유 화학제품을 생산하기 위해 생산계획 및 작업표준에 따라 공정을 안전하고 효율적으로 운전한다.","doWork":"조정실(Control Room) 에서 해당 공정을 DCS(공정제어시스템) 및 담당 조작설비를 작업표준(정상운전 작업절차 및 이상 시 조치작업 절차)에 따라 안전하고 최적조건이 유지되도록 조절하여 해당 제품을 안정적으로 생산한다. 이상상황 발생 시에는 신속한 보고 및 조치를 실시하고 원인분석을 실시한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"석유화학보드맨, 석유화학장치운전원","dJobECd":"8511","dJobECdNm":"[8511]석유·천연가스 제조 제어장치 조작원","dJobJCd":"8311","dJobJCdNm":"[8311]석유 및 천연가스 제조 관련 제어 장치 조작원","dJobICd":"C201","dJobICdNm":"[C201]기초 화학물질 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007317:1', '{"dJobCd":"K000007317","dJobCdSeq":"1","dJobNm":"석유화학현장공정관리원","workSum":"효율적인 공정운전을 위하여 공정개선 계획에 따라 공정지표를 관리하고 공정 이상을 파악하여 공정을 개선하는 업무를 수행한다.","doWork":"비정상 운전 대응절차를 수립하기 위해 공정이상의 발생원인을 파악하고 개선안을 수립· 적용하여 공정 비상상황에 빠르게 대응한다. 공정지표 항목을 선정하고, 모니터링을 통해 이상 지표를 파악하고 공정운전을 정상화 조치한다. 공정개선안을 도출하며 평가를 진행하고 공정개선계획을 실행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"석유화학공정관리기사, 석유화학생산기사","dJobECd":"8511","dJobECdNm":"[8511]석유·천연가스 제조 제어장치 조작원","dJobJCd":"8311","dJobJCdNm":"[8311]석유 및 천연가스 제조 관련 제어 장치 조작원","dJobICd":"C201","dJobICdNm":"[C201]기초 화학물질 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003215:1', '{"dJobCd":"K000003215","dJobCdSeq":"1","dJobNm":"석탄가스정제원","workSum":"석탄가스에 함유된 불순물인 타르, 황화수소, 암모니아, 벤졸 등을 회수하여 타르, 유황, 조경유, 가스 등을 생산하기 위해 냉각탑, 전기집진기, 포집탑, 증류탑, 가열로, 촉매반응로와 유틸리티 설비 등 관련 설비를 조작한다.","doWork":"코크스로에서 발생한 가스를 송풍장치를 통해 흡입하여 가스 정제 설비로 보내면서 가스에 포함된 불순물(타르, 황화수소, 암모니아, 벤졸)을 제거한다. 고온의 발생가스를 냉각과정을 통해 함유된 타르가 회수하고 나머지 미스트는 전기집진기에서 제거한다. 황화수소와 암모니아는 포집탑에서 포집액(연수, 안수)에 의해 황화수소와 암모니아를 제거하고 벤졸포집탑으로 보내지며, 회수된 황화수소와 암모니아는 증류공정을 거쳐 탈황설비에서 고온으로 올려 암모니아는 질소와 수소로 분리하고, 황화수소는 촉매와 반응시켜 유황을 생산한다. 벤졸포집탑에서는 흡수유를 이용하여 벤졸을 제거하며 정제된 가스는 가스홀더로 보내진다. 흡수유에 함유된 벤졸은 증류탑에서 증류시킨 후 냉각시켜 조경유(벤졸)를 생산한다. 각 설비를 관찰하고 유량, 압력, 온도 등을 확인하고 조절하며 이상이 있을 경우 보수 및 교체작업 등을 실시한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"위험물기능사, 가스기능사","dJobECd":"8511","dJobECdNm":"[8511]석유·천연가스 제조 제어장치 조작원","dJobJCd":"8311","dJobJCdNm":"[8311]석유 및 천연가스 제조 관련 제어 장치 조작원","dJobICd":"C191","dJobICdNm":"[C191]코크스 및 연탄 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005498:1', '{"dJobCd":"K000005498","dJobCdSeq":"1","dJobNm":"아스팔트제조원","workSum":"산업용, 도로포장용 및 기타 특수아스팔트를 제조하기 위하여 아스팔트 원료와 용제∙골재∙각종 첨가제 등을 혼합하고 반응하는 장비를 조작한다.","doWork":"원유를 상압증류(Crude Distillation) 혹은 감압증류(Vacuum Distillation)하고 남은 아스팔트를 저장탱크로부터 반응탱크로 일정량을 이송한다. 펌프를 작동시켜 반응탱크에 공기를 주입하고 일정 시간 동안 반응토록 한다. 시험시료을 채취하여 시험실에 시험의뢰하고 시험결과에 따라 반응을 계속하거나 펌프를 작동하여 저장탱크로 이송한다. 특수한 용도로 사용되는 아스팔트를 제조하기 위하여 용제 및 첨가제 등을 넣고 혼합한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|","workEnv":"대기환경미흡|위험내재|고온|다습|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8511","dJobECdNm":"[8511]석유·천연가스 제조 제어장치 조작원","dJobJCd":"8311","dJobJCdNm":"[8311]석유 및 천연가스 제조 관련 제어 장치 조작원","dJobICd":"C192","dJobICdNm":"[C192]석유 정제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001338:1', '{"dJobCd":"K000001338","dJobCdSeq":"1","dJobNm":"아스팔트제조현장감독자","workSum":"산업용, 도로포장용 및 기타 특수아스팔트를 제조하기 위하여 아스팔트 원료와 용제 등을 혼합·반응시켜 아스팔트를 제조하는 작업원을 관리감독하고 문제 발생시 조정한다.","doWork":"아스팔트 원료와 용제 등을 준비하고 배합비를 결정한다. 혼합기와 반응기의 작동상태를 점검한다. 작업계획에 따라 세부실행항목을 수립하여 작업절차 및 방법을 결정하고 작업원에게 지시한다. 작업원에 대한 직무교육 및 산업안전보건 교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴하고 문제점을 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"수동조작","similarNm":"아스팔트제조반장","dJobECd":"8511","dJobECdNm":"[8511]석유·천연가스 제조 제어장치 조작원","dJobJCd":"8311","dJobJCdNm":"[8311]석유 및 천연가스 제조 관련 제어 장치 조작원","dJobICd":"C192","dJobICdNm":"[C192]석유 정제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003825:1', '{"dJobCd":"K000003825","dJobCdSeq":"1","dJobNm":"유류출하운전원","workSum":"정유공장에서 생산한 유류를 선박, 유조차량, 유조화차(油槽貨車:유류를 실어 나르는 철도화물차량), 송유관 등에 싣거나 이송하기 위하여 펌프 및 출하장치(Loading Arm)를 조작하고 출하현황을 파악한다.","doWork":"유류출하장의 출하지시서에 따라 출하할 저장탱크 또는 송유관을 확인한다. 펌프의 가동상태를 확인하고 작업에 필요한 장비를 점검한다. 펌프 및 출하장치(Loading Arm)를 가동하여 제품의 출하 및 유입을 조절하고 압력계, 유량계 등을 점검하여 계기의 수치를 기록한다. 유류출하장에서 취급하는 각종 유류는 인화, 폭발 위험이 있으므로 안전규정을 철저히 준수하여 작업한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실외","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"위험물기능사","dJobECd":"8511","dJobECdNm":"[8511]석유·천연가스 제조 제어장치 조작원","dJobJCd":"8311","dJobJCdNm":"[8311]석유 및 천연가스 제조 관련 제어 장치 조작원","dJobICd":"C192","dJobICdNm":"[C192]석유 정제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003569:1', '{"dJobCd":"K000003569","dJobCdSeq":"1","dJobNm":"유류출하현장감독자","workSum":"정유공장에서 생산한 유류를 선박, 유조차량, 유조화차, 송유관 등에 싣거나 이송하고자 펌프 및 출하장치(Loading Arm)를 조작하는 종업원을 감독·조정한다.","doWork":"유류출하소 운영계획을 점검하고 유류 및 각종 첨가제의 출하량, 입고량, 저장탱크의 저장량 등을 점검한다. 인원계획을 수립하고 작업절차 및 방법을 결정하며 작업원에게 지시한다. 작업원에 대한 직무교육 및 안전위생교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴하고 문제점을 보고한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","similarNm":"유류출하반장","dJobECd":"8511","dJobECdNm":"[8511]석유·천연가스 제조 제어장치 조작원","dJobJCd":"8311","dJobJCdNm":"[8311]석유 및 천연가스 제조 관련 제어 장치 조작원","dJobICd":"C192","dJobICdNm":"[C192]석유 정제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003201:1', '{"dJobCd":"K000003201","dJobCdSeq":"1","dJobNm":"윤활유제조원","workSum":"공업용, 차량용, 항공기, 선박용 등의 윤활유를 제조하고자 저장·이송 및 배합하는 장비들을 조작·관리한다.","doWork":"제조할 윤활유에 따라 광유계, 지방유계, 실리콘오일계, 디에스테르오일계 등 윤활기유(Base Oil)와 산화방지제, 청정분산제, 유성향상제, 극압제, 부식방지제, 방청제, 소포제, 점도지수 향상제, 유동점 강하제, 유화제, 착색제 등 첨가제의 종류와 양을 결정한다. 펌프와 밸브를 조작하여 기유와 첨가제를 배합탱크에 주입한다. 온도조절장치를 조절하여 배합탱크에 증기 또는 가스를 통과시켜 일정한 온도를 유지한다. 교반기를 작동시켜 일정 시간 동안 배합시킨다. 반응조건, 생산량 등을 기록 관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"고온|다습|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8511","dJobECdNm":"[8511]석유·천연가스 제조 제어장치 조작원","dJobJCd":"8311","dJobJCdNm":"[8311]석유 및 천연가스 제조 관련 제어 장치 조작원","dJobICd":"C192","dJobICdNm":"[C192]석유 정제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004342:1', '{"dJobCd":"K000004342","dJobCdSeq":"1","dJobNm":"윤활유제조현장감독자","workSum":"공업용, 차량용, 항공기, 선박용 등의 윤활유를 제조하기 위하여 저장·이송·배합하는 장비들을 조작·관리하는 작업원의 활동을 관리감독하고 문제 발생시 조정한다.","doWork":"공장운영계획에 따라 인원배치를 점검하고 조정한다. 각종 계기를 검사하여 저장탱크에 보관된 원료 및 첨가제 종류와 양을 확인한다. 용해조의 잔류유량을 확인하고, 혼합탱크로 이송할 원료 및 첨가제의 양을 정하여 저장탱크로부터 혼합탱크로의 이송을 지시한다. 계기판에 혼합탱크 온도, 혼합시간, 압력 등을 입력하여 가동시킨다. 작업이 완료되면 시험시료를 채취하여 시험분석을 의뢰한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|고온|다습|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","similarNm":"윤활유제조반장","dJobECd":"8511","dJobECdNm":"[8511]석유·천연가스 제조 제어장치 조작원","dJobJCd":"8311","dJobJCdNm":"[8311]석유 및 천연가스 제조 관련 제어 장치 조작원","dJobICd":"C192","dJobICdNm":"[C192]석유 정제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006974:1', '{"dJobCd":"K000006974","dJobCdSeq":"1","dJobNm":"저유반장","workSum":"정유공장 또는 석유화학공장의 가공·저장·운반·운송장비를 통해 원유, 반가공 석유제품, 완전가공 석유제품 등을 저장 및 이송을 담당하며 작업원의 활동을 감독·조정한다","doWork":"저장 및 이송해야 될 탱크 및 송유관을 결정하고 작업에 필요한 장비 및 펌프류의 연결·작동상태를 점검한다. \n출하 및 송유제품의 유입을 조절하도록 압력계, 유량계 등을 관찰한다. \n저장탱크의 저유량을 확인하고 온도,압력을 관리한다. \n균열 또는 누출과 같은 이상을 찾아내기 위하여 송유관, 밸브 또는 플랜지(Flange:관의 연결부위)를 검사 및 유지보수에 대한 관리를 책임진다.\n관리요원에게 누출 및 이상상황을 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"수동조작","certLic":"위험물기능사, 가스기능사","dJobECd":"8511","dJobECdNm":"[8511]석유·천연가스 제조 제어장치 조작원","dJobJCd":"8311","dJobJCdNm":"[8311]석유 및 천연가스 제조 관련 제어 장치 조작원","dJobICd":"C192","dJobICdNm":"[C192]석유 정제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004849:1', '{"dJobCd":"K000004849","dJobCdSeq":"1","dJobNm":"저유소출하원","workSum":"저유소에 규정된 기준에 의거하여 선박, 유조차량, 유조화차, 송유관, 저장탱크의 유류의 양을 측정하고 석유제품의 입, 출하를 조절하며, 시설물의 안전을 담당한다","doWork":"작업에 필요한 장비 및 펌프류의 연결·작동상태를 점검한다. 펌프를 작동시켜 출하 및 송유제품의 유입을 조절하도록 밸브를 작동하며, 압력계, 유량계 등을 관찰한다. 게이지 등의 측정기구를 사용하여 저장탱크의 유류량을 재거나 온도를 측정한다. 유류의 시료를 채취하여 물·침전물·이물질 등이 있는지 검사한다. 계획에 의해서 탱크 밖으로나 안으로의 기름 유출입의 속도를 결정한다. 기름탱크 내의 양을 알기 위해서 일정 시간 간격으로 자동게이지를 판독한다. 누출과 같은 고장을 찾아내기 위하여 송유관, 밸브 또는 플랜지(Flange:관의 연결부위)를 검사한다. 렌치로 연결부분을 조이며 밸브에 윤활유나 기름을 칠한다. 관리요원에게 누출과 이상 사항을 보고한다. 재고유지 및 현황파악을 위해 자동계측기의 수치 및 송유량을 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"힘든 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"위험물기능사, 가스기능사","dJobECd":"8511","dJobECdNm":"[8511]석유·천연가스 제조 제어장치 조작원","dJobJCd":"8311","dJobJCdNm":"[8311]석유 및 천연가스 제조 관련 제어 장치 조작원","dJobICd":"C192","dJobICdNm":"[C192]석유 정제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005700:1', '{"dJobCd":"K000005700","dJobCdSeq":"1","dJobNm":"저유소출하현장감독자","workSum":"저유소의 시설물을 활용하여 석유제품의 반입, 출하업무 및 시설물의 안전을 담당하며 작업원의 활동을 감독·조정한다.","doWork":"저장탱크내의 제품의 품질을 확보하고 계획된 입출하에 맞게 저유소의 시설물을 안전하게 운영한다. 저장탱크 내의 물량을 관리 및 안전을 확보하기 위한 온도, 압력 등을  관리한다. 작업원과 함께 균열, 누출과 같은 이상을 찾아내기 위하여 수시 및 주기적으로 송유관, 밸브 또는 플랜지(Flange:관의 연결부위) 점검 등을 실시 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"수동조작","similarNm":"저유소출하반장","certLic":"위험물기능사, 가스기능사","dJobECd":"8511","dJobECdNm":"[8511]석유·천연가스 제조 제어장치 조작원","dJobJCd":"8311","dJobJCdNm":"[8311]석유 및 천연가스 제조 관련 제어 장치 조작원","dJobICd":"C192","dJobICdNm":"[C192]석유 정제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004309:1', '{"dJobCd":"K000004309","dJobCdSeq":"1","dJobNm":"저유장치운전원","workSum":"저유장치 공정의 관련 설비를 조작하여 반제품에 첨가제, 화학약품 등을 혼합 및 저장, 운송하는 업무를 담당한다.","doWork":"작업표준을 기준으로 혼합해야 할 성분과 양을 확인한다. 펌프를 작동하고 유량계와 압력계를 관찰한다. 각종 탱크의 액 수위 및 품질수준을 점검한다. 밸브를 열어 기계의 조정장치를 돌리고 펌프를 작동하여 지시된 속도로 이송한다. 혼합물이 탱크에 주입되면 이송파이프의 밸브를 잠그고 혼합물을 교반한다. 시료를 채취하여 시험 의뢰한다. 고장과 누출을 탐지하기 위하여 장비의 작동을 관찰한다. 혼합물과 사용할 재료의 양을 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"위험물 기능사","dJobECd":"8511","dJobECdNm":"[8511]석유·천연가스 제조 제어장치 조작원","dJobJCd":"8311","dJobJCdNm":"[8311]석유 및 천연가스 제조 관련 제어 장치 조작원","dJobICd":"C192","dJobICdNm":"[C192]석유 정제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003605:1', '{"dJobCd":"K000003605","dJobCdSeq":"1","dJobNm":"저장탱크중앙조정실조작원","workSum":"가스를 저장한 후 필요할 때 사용처로 보내기 위해 가스저장탱크 중앙조정실의 제어장치를 조정한다.","doWork":"중앙조정실의 계기판을 관찰하여 장비의 정상가동 여부를 확인한다. 가스의 누출 및 화재를 감시하기 위한 안전 감시설비를 확인한다. 기계의 이상이나 지시치의 변경을 위하여 계기판의 레버를 돌리거나 버튼을 누른다. 설비점검표에 따라 설비의 상태를 파악한다. 설비운전 시 나타난 문제점을 분석하여 대책을 수립한다. 자재수급 계획서를 자재부에 송부하여 구매를 의뢰한다. 설비개선공사 현황을 파악하고 관리한다. 조정실의 작업내용을 작업일지에 기록한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8511","dJobECdNm":"[8511]석유·천연가스 제조 제어장치 조작원","dJobJCd":"8311","dJobJCdNm":"[8311]석유 및 천연가스 제조 관련 제어 장치 조작원","dJobICd":"D352","dJobICdNm":"[D352]연료용 가스 제조 및 배관공급업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003976:1', '{"dJobCd":"K000003976","dJobCdSeq":"1","dJobNm":"정유장치제어판조작원","workSum":"생산계획 및 작업표준 (정상운전 작업표준, 이상시 조치작업 표준 등) 에 따라 공정을 효율적, 안전하게 최적으로 운전하는 관리 책임을 가진다.","doWork":"정유장치의 작동상태를 확인하기 위하여 제어판의 계수기를 관찰하고 수치를 기록한다. 온도, 압력, 진공, 반응시간, 촉매, 화공약품 등의 흐름을 조절하고 제어하기 위하여 제어판을 조작한다. 제어판에 나타난 수치나 경고등을 보고 정유장치현장조작원에게 연락하여 현장장치를 조절·조작하도록 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"정유장치보드맨(Board Man)","certLic":"위험물기능사, 가스기능사","dJobECd":"8511","dJobECdNm":"[8511]석유·천연가스 제조 제어장치 조작원","dJobJCd":"8311","dJobJCdNm":"[8311]석유 및 천연가스 제조 관련 제어 장치 조작원","dJobICd":"C192","dJobICdNm":"[C192]석유 정제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006892:1', '{"dJobCd":"K000006892","dJobCdSeq":"1","dJobNm":"정유장치현장감독자","workSum":"석유류 제품을 제조하는 데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"생산계획 및 작업표준에 따라 공정을 효율적, 안전하게 최적으로 운전하는 관리 책임을 가진다.\n정유공정의 장치조작을 정유장치제어판조작원에게 지시한다. \n기록기기, 유량계 차트, 운전기록표, 실험분석보고서를 검토하여 가공 중에 안전하고 효율적으로 조정할 수 있도록 지시한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","similarNm":"정유장치반장","certLic":"위험물기능사, 가스기능사","dJobECd":"8511","dJobECdNm":"[8511]석유·천연가스 제조 제어장치 조작원","dJobJCd":"8311","dJobJCdNm":"[8311]석유 및 천연가스 제조 관련 제어 장치 조작원","dJobICd":"C192","dJobICdNm":"[C192]석유 정제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006439:1', '{"dJobCd":"K000006439","dJobCdSeq":"1","dJobNm":"정유장치현장조작원","workSum":"직무기술서 및 정유장치제어판조작원의 지시에 따라 정유공장 설비가 안정되고 효율적으로 운전 될 수 있도록 현장설비를 조작하며, 아울러 정기 현장 순찰시 이상 상황 보고 및 조치","doWork":"공장지역을 순회하면서 고장과 누설을 탐지하기 위하여 펌프·파이프·가공처리 장비를 검사한다. 온도·압력 등을 계기를 사용하여 측정하고 자료를 기록한다. 정유장치제어판조작원의 지시에 따라 밸브를 돌리고 펌프를 작동하여 온도·압력·흐름·비율 등을 조절한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실외","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"정유장치오퍼레이터(Operator)","certLic":"위험물기능사, 가스기능사","dJobECd":"8511","dJobECdNm":"[8511]석유·천연가스 제조 제어장치 조작원","dJobJCd":"8311","dJobJCdNm":"[8311]석유 및 천연가스 제조 관련 제어 장치 조작원","dJobICd":"C192","dJobICdNm":"[C192]석유 정제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002521:1', '{"dJobCd":"K000002521","dJobCdSeq":"1","dJobNm":"가소화조작원","workSum":"고무원료와 안료를 혼합하여 가소화(소련)시키는 기계를 조작·관리한다.","doWork":"작업지시서의 원료 배합비율에 따라 유분, 탄산칼슘, 안료를 배합통에 넣고 막대기 등으로 저어서 혼합한다. 배합한 원료를 가소화(소련, 내림작업, Mastication)하고자 기계에 투입한다. 일반적으로 천연고무는 기계적(물리적) 전단력을 이용한 저온의 오픈롤(Open Roll)에서, 합성고무는 화학적 해중합(解重合)을 이용한 고온의 반바리믹서(Banbury Mixer)에서 가소화 작업을 한다. 원료가 완전히 가소화될 때까지 일정 시간 기계를 가동 후, 가소화된 원료를 꺼내어 절단기를 사용하여 일정한 크기로 자른다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002540:1', '{"dJobCd":"K000002540","dJobCdSeq":"1","dJobNm":"가스여과기조작원","workSum":"배소로(焙燒爐)에서 흡입된 가스 중의 분진, 연무 및 각종 불순물을 제거하는 여과기를 조작한다.","doWork":"여과조에 주입되는 압축공기의 압력을 조절하고 확인한다. 스크린컨베이어의 회전방향을 정하고 정상가동 여부를 확인한다. 여과기에 공기가 혼입되는 것을 방지하고자 패킹을 점검·교체한다. 작업표준에 따라 규조토와 여액을 혼합조에 투입하고 슬러리를 만든다. 여과기의 작동스위치를 넣고 정상가동 상태를 확인한다. 여과기 내압을 조절하고 잔액을 배출시킨다. 박판을 알칼리용액으로 중화시킨 후 수세한다. 각 탱크에 쌓인 침전물을 배출시킨다. 작업내용 및 작업상황을 작업일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C242","dJobICdNm":"[C242]1차 비철금속 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002677:1', '{"dJobCd":"K000002677","dJobCdSeq":"1","dJobNm":"계면활성제제조현장감독자","workSum":"각종 계면활성제를 제조하는데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"제조하고자 하는 각종 계면활성제(음이온, 양이온, 양쪽성, 수용성 등)의 생산량을 파악하고 필요한 원부재료의 수량을 작업원에게 준비시킨다. 작업원에게 안전과 관련된 규정을 교육시킨 후 업무 분장을 시킨다. 원료의 투입 현황을 파악하고, 각 계면활성제 제품의 종류별로 생산 확인을 하면서 적정 생산량을 관리한다. 작업장의 장치 및 기기에 대해 이상 여부를 확인하고 조작원들에게 제반 사항에 대해 조치를 취하도록 하며, 문제점을 파악해 상부에 보고를 한 후 지시를 받는다. 작업장 주변의 정리정돈 상태를 점검하고 개선을 한다. 환경에 대한 법적 규정에 따라 안전 운전을 하고 규정 준수 여부를 철저히 확인한다. 공정 위험 요소를 발견해 보고를 하기도 한다. 수시면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴하고 문제점을 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"유화제제조반장, 계면활성제제조반장","certLic":"위험물기능사, 위험물산업기사","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C204","dJobICdNm":"[C204]기타 화학제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006098:1', '{"dJobCd":"K000006098","dJobCdSeq":"1","dJobNm":"고무접착제혼합원","workSum":"고무접착제를 제조하기 위하여 고무 원료와 각종 배합제를 혼합하는 장치를 조작한다.","doWork":"물성검사가 완료된 원료와 각종 배합제를 호이스트나 지게차 등을 사용하여 저장소로부터 혼합기로 운반한다. 작업표준에 명시된 순서대로 원료와 각종 배합제를 저울 또는 유량계를 사용하여 계량한 후 손이나 호이스트를 이용해 혼합기에 투입한다. 이때 사용하기에 용이한 크기로 미리 절단을 하고 세척을 한다. 혼합기의 조정 판에 교반시간, 교반속도 등을 입력한 후 일정 시간 교반한다. 혼합이 완료되면 냉각수밸브를 열어 일정 온도로 냉각시킨다. 견본을 채취하여 점도, 색상 등 간단한 검사를 실시하고 일부는 품질검사부로 보낸다. 합격이 되면 혼합기 하단의 배출밸브를 열고 고무접착제를 대차에 담아 숙성실로 운반한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"힘든 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003837:1', '{"dJobCd":"K000003837","dJobCdSeq":"1","dJobNm":"고상수화제제조원","workSum":"수화제 형태의 살충제·살균제·제초제를 제조하기 위하여 고상·액상 원제와 각종 부제를 혼합·분쇄하는 기계를 조작·관리한다.","doWork":"고상원제는 호이스트와 리프트, 액상원제는 펌프를 사용하여 저장탱크로부터 이송하여 1차 혼합기에 투입한다. 습윤제, 분산제, 유동성 증진제, 흡착제, 증량제 등의 부제를 배합비율에 따라 함께 혼합기에 투입한다. 이때 원·부제를 전량 투입한다는 특징이 있다. 혼합기의 조정판에 혼합조건을 입력하고 가동한다. 일정 시간 혼합기를 가동하고 견본을 채취하여 혼합이 작업표준과 동일하게 되었는지 검사한다. 혼합기 하단의 배출밸브를 열어 분쇄기로 혼합물을 투입한다. 분쇄기의 종류에 따라 분쇄날의 간격을 작업표준에 명시된 방법으로 조절한다. 분쇄기를 가동하고 입도를 확인하여 분쇄날을 재조정한다. 1차 분쇄기에 투입되는 혼합물은 다시 분쇄기 호퍼에 붓고 재분쇄한다. 입도가 제품규격과 일치하면 2차 혼합기로 이송하고자 배출밸브를 열고 펌프를 가동한다. 2차 혼합이 완료되면 견본을 채취하여 제품표준과 비교하고 일부는 품질검사부로 보낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C204","dJobICdNm":"[C204]기타 화학제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003400:1', '{"dJobCd":"K000003400","dJobCdSeq":"1","dJobNm":"구연산농축기조작원","workSum":"고농도의 액상 구연산(시트르산)을 제조하기 위하여 저농도 액상 구연산을 농축하는 농축기를 조작·관리한다.","doWork":"저농도 액상 구연산(음식이나 음료수에 산성이나 신맛을 첨가하기 위해 사용)이 적정량 투입되었는지 농축기의 유량계를 살핀다. 농축기를 가동한 후 농축기 내부의 온도·압력 등이 일정하게 유지되는지 관찰한다. 온도계와 압력계를 수시로 확인하고 필요시 조정판의 수치를 변경하여 운전상태를 작업표준에 맞게 설정한다. 농축이 완료되면 견본을 채취하여 구연산의 농도를 검사하고 견본의 일부를 실험실로 보낸다. 농축이 완료된 액상 구연산을 펌프를 가동하여 저장탱크로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"식품산업기사, 식품가공기능사","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005639:1', '{"dJobCd":"K000005639","dJobCdSeq":"1","dJobNm":"구연산반응기조작원","workSum":"구연산칼륨으로부터 구연산을 추출하기 위하여 분해관·반응기 등의 장치를 조작·관리한다.","doWork":"작업표준에 따라 일정량의 구연산칼륨과 물을 분해관에 투입하고 온도를 높여 분해관이 적정온도에 도달하는지 관찰한다. 알맞게 희석된 황산을 작업표준에 따라 분해관에 투입한 후 교반기가 원활히 작동하는지 살핀다. 불순물을 걸러내기 위하여 활성탄(活性炭:주성분이 탄소이며 다공성으로, 표면적이 넓어 흡착성이 강하고, 화학 반응이 빨리 일어나는 물질)을 투입한다. 반응이 완료되면 견본을 채취하여 반응상태를 검사한다. 추출된 구연산액은 저장탱크로 이송하며 침전된 잔유물은 제거한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"식품산업기사, 식품가공기능사","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006922:1', '{"dJobCd":"K000006922","dJobCdSeq":"1","dJobNm":"구연산여과기조작원","workSum":"농축된 액상 구연산(시트르산)의 이물질을 제거하는 필터여과기를 조작·관리한다.","doWork":"농축된 구연산(음식이나 음료수에 산성이나 신맛을 첨가하기 위해 사용) 용액의 온도·농도를 검사하여 제품표준과 비교한다. 여과기에 설치된 여과포의 상태를 수시로 점검하여 교체한 후 여과기가 정상적으로 작동하는지 점검한다. 저장탱크의 배출밸브를 열고 펌프를 가동하여 여과기에 농축된 구연산액을 투입한다. 여과된 구연산액의 견본을 채취하여 이물질의 함유 여부를 검사하고 견본의 일부를 실험실로 보낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"식품산업기사, 식품가공기능사","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005075:1', '{"dJobCd":"K000005075","dJobCdSeq":"1","dJobNm":"글루타민산나트륨건조원","workSum":"화학조미료를 제조하기 위하여 글루타민산나트륨(MSG) 결정액의 수분을 제거하는 원심분리기와 건조기를 조작·관리한다.","doWork":"글루타민산나트륨(MSG:Monosodium Glutamate) 결정액 저장탱크의 밸브를 돌려 원심분리기의 호퍼(Hopper)에 결정액을 주입한다. 원심분리기의 회전속도를 조절하고 분리기를 가동하여 일정량의 수분을 제거한다. 열교환기, 여과필터, 공기팬을 가동하여 고온의 열풍을 건조기 내부로 순환시킨다. 원심분리된 글루타민산나트륨 결정을 일정량씩 건조기 내부로 투하하여 결정 중의 수분을 고온의 열풍으로 제거한다. 규정온도의 열풍을 유지하고자 온도계를 관찰하고, 열교환기의 열량을 조절하고자 증기밸브를 조절한다. 공기흡입측의 여과필터를 주기적으로 교환하여 이물질의 혼입을 방지한다. 건조된 글루타민산나트륨을 입자크기별로 분류하기 위해 사별기로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"식품산업기사, 식품가공기능사","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005584:1', '{"dJobCd":"K000005584","dJobCdSeq":"1","dJobNm":"글루타민산나트륨사별원","workSum":"화학조미료를 제조하기 위하여 건조된 글루타민산나트륨(MSG)을 입자크기별로 분리하는 기계를 조작·관리한다.","doWork":"건조된 글루타민산나트륨(MSG:Monosodium Glutamate)을 입자크기별로 분리하고자 진동체 위에 구멍이 큰 체부터 작은 체 순으로 금속망을 설치한다. 글루타민산나트륨 저장탱크의 배출구를 열고 진동체를 가동한다. 배출밸브를 조절하여 진동체로 투입되는 글루타민산나트륨의 투입량을 조절한다. 분리된 글루타민산나트륨의 견본을 채취하여 제품표준과 입자크기를 비교·검사한다. 진동체에서 입자크기별로 분리된 글루타민산나트륨을 컨베이어를 통해 각각의 저장탱크로 자동 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"식품산업기사, 식품가공기능사","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004171:1', '{"dJobCd":"K000004171","dJobCdSeq":"1","dJobNm":"글루타민산분리기조작원","workSum":"화학조미료를 제조하기 위하여 반중화된 원료액에서 글루타민산 모액을 분리하는 기계를 조작·관리한다.","doWork":"원심분리기 내부에 일정량의 물과 반중화된 원료액을 투입한 후 원심분리기를 가동시킨다. 작동 중인 원심분리기의 회전속도를 살피고, 과부하가 걸리지 않는지 점검·확인한다. 분리된 글루타민산의 견본을 채취하여 농도·산도 등을 검사한다. 분리가 완료된 글루타민산액을 중화공정으로 이송하기 위하여 원심분리기의 배출밸브를 조절한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"식품산업기사, 식품가공기능사","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005782:1', '{"dJobCd":"K000005782","dJobCdSeq":"1","dJobNm":"기판원료혼합원","workSum":"인쇄회로용 절연 적층판을 제조하기 위해 사용되는 화공약품, 용제 등을 혼합하는 탱크를 관리한다.","doWork":"혼합비율표에 따라 주·부원료를 저울로 계량한다. 일정량의 원료를 탱크에 쏟아붓는다. 스위치를 돌려서 탱크의 교반기를 작동시키고 시간조절기를 조정하여 지정시간 동안 배합한다. 혼합된 원료를 검사장비를 이용하여 점도를 확인하고 밸브를 열어 공정에 사용될 수 있도록 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006229:1', '{"dJobCd":"K000006229","dJobCdSeq":"1","dJobNm":"내장재도료배합원","workSum":"내장재 도장에 필요한 도료를 제조하기 위해 원료를 배합하고 교반한다.","doWork":"작업지시서에 따라 배합에 필요한 도료와 부자재를 준비한다. 준비된 원자재(도료), 부자재(물, 중점제, 분산제, 안료)를 정량공급장치로 계량하여 교반기에 투입한다. 교반기를 작동하여 일정 시간 교반한다. 교반상태를 육안으로 확인하고, 압송장비의 압력을 확인한 후 파이프라인으로 도장부서의 저장탱크로 보내거나 통에 받아 사용장소로 운반한다. 도료사용량을 산출하고 작업일지에 기록한다. 교반기의 내부를 세척한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"유지","connectJob":"기포콘크리트배합원, 특수도료배합원","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C239","dJobICdNm":"[C239]기타 비금속 광물제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001900:1', '{"dJobCd":"K000001900","dJobCdSeq":"1","dJobNm":"다중효용증발기조작원","workSum":"탈색된 전분당화액을 농축하여 일정 농도의 당화액으로 제조하기 위하여 하나 또는 여러 개의 증발관을 조작·관리한다.","doWork":"펌프를 가동하고 증발기의 투입부를 통해 탈색된 전분당화액을 내부로 투입한다. 투입부 밸브를 닫고 투입량을 점검한 후, 진공펌프를 가동한다. 증발관을 일정 온도로 가열하기 위하여 증기밸브를 열고, 순환관에 증기를 투입한다. 온도계, 압력계, 진공계 등을 관찰한다. 견본을 채취하고 농도를 제품 표준과 비교·검사한다. 규정농도로 농축되면 증발기의 작동을 멈추고 배출밸브를 열어 다음 공정으로 이송한다. 자동화된 기계의 조정판에 투입량, 진공도, 순환시간, 농도 등을 입력하여 농축되는 과정을 관찰·조절하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|다습|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"다중효용관조작원, 효용관조정판조작원","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C106","dJobICdNm":"[C106]곡물가공품, 전분 및 전분제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007038:1', '{"dJobCd":"K000007038","dJobCdSeq":"1","dJobNm":"도료배합원","workSum":"페인트를 제조하기 위하여 원료 및 첨가제를 배합·분산하는 장치를 조작·관리한다.","doWork":"원료를 배합기로 이송하기 위하여 저장탱크와 공업용수탱크에 연결된 파이프를 확인하고 유량계를 점검한다. 작업지시서에 명시된 각종 수지·조제 등을 저울을 사용하거나 유량계의 눈금을 확인하면서 밸브를 열어 배합순서에 따라 저장탱크에 투입한다. 첨가제가 드럼통에 담겨 있을 경우에는 호이스트를 걸어 투입구에 위치시키고 손으로 기울여 투입한다. 상부의 교반기 축을 배합기 안으로 내린다. 투입이 완료되면 배합기를 저속으로 교반하면서 일정 시간 배합한다. 일정 시간 배합이 완료되면 배합기를 정지시키고 액상 또는 분말의 분산제를 배합비에 따라 계량한 후 투입한다. 분산제가 고르게 작용하도록 교반속도를 고속으로 조정하고 교반한다. 일정 시간 고속교반 후 견본을 채취하고 입도계를 사용하여 분산상태를 검사한다. 점검이 완료되면 조합공정으로 이송하기 위하여 밸브를 열고 펌프를 가동한다. 작업일지를 작성한다. 교반기를 위로 올리고 교반기에 묻은 이물질은 물을 뿌려 깨끗이 닦아낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|시각|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"유지","similarNm":"수성페인트제조원","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C204","dJobICdNm":"[C204]기타 화학제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006133:1', '{"dJobCd":"K000006133","dJobCdSeq":"1","dJobNm":"도료분산기조작원","workSum":"프리믹스(Premix)된 도료 원료(수지, 안료, 용제, 첨가제)에 분산제를 투입해 균일한 상태로 분산을 시키는 분산기를 조작·관리한다.","doWork":"프리믹스(Premix)된 도료 원료(수지, 안료, 용제 등)의 양과 반응상태를 확인하여 분산횟수를 결정한 후 분산기의 패널에 입력한다. 볼밀, 샌드밀(볼밀이 Batch식으로 되어 있어 연속적인 분산을 행하는 장치) 등의 분산기 드럼에 원료가 자동적으로 투입이 되면서 분산기가 회전되도록 가동한다. 이때 미디어(Media:철 또는 알루미늄 구)가 들어있는 드럼 내용물이 운동을 하여 여기서 생기는 전단력을 이용하여 분산 과정이 행해진다. 분산이 완료되면 견본을 채취하고 제품표준과 비교한다. 분산이 완료된 하단의 배출밸브를 열고 펌프를 가동하여 반제품을 조색과 검사 공정으로 이송한다. 이송이 완료되면 분산기에 세척제를 투입하고 솔을 사용하여 깨끗이 세척한다. 작업 완료 후 분산횟수를 작업일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"도료분산원","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C204","dJobICdNm":"[C204]기타 화학제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002603:1', '{"dJobCd":"K000002603","dJobCdSeq":"1","dJobNm":"도료제조원","workSum":"각종 도료(페인트, 바니시, 에나멜, 래커 등)와 유사 피막 형성용 제품을 제조하고자 합성수지, 안료, 용제, 첨가제 등을 배합비율에 따라 혼합·분산·조정하는 용해기를 조작·관리한다.","doWork":"용해탱크에 연결된 유량계의 눈금을 확인하면서 밸브를 돌려 일정량의 물을 탱크에 주입한다. 저장탱크로부터 이송이 된 수지원료, 용제 등을 배합비율에 맞게 탱크에 주입해 물과 혼합한다. 배합 기준에 따른 일정량의 안료를 계량하여 넣은 후 용해장치의 교반기를 고속으로 작동시켜 혼합된 원료를 분산시킨다. 바니시(Vanish)를 일정 시간 교반 후 교반기를 중지하고 용해조 밑의 밸브를 열고 펌프를 가동하여 분산된 용액을 저장탱크로 이송시킨다. 저장탱크의 교반기를 서서히 작동시키고 작업지시서에 명시된 각종 수지·조제 등을 저울을 사용하거나 유량계의 눈금을 확인하면서 저장탱크에 투입한다. 일정 시간이 경과되면 교반을 중지하고 견본을 채취하여 검사실에 점성검사를 의뢰한다. 검사결과에 따라 필요한 원료, 부원료, 조제 또는 물을 첨가하고 다시 교반하여 검사 의뢰한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"래커제조원, 수성페인트제조원, 와니스제조원, 퍼티제조원, 희석제제조원","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C204","dJobICdNm":"[C204]기타 화학제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006884:1', '{"dJobCd":"K000006884","dJobCdSeq":"1","dJobNm":"도료제조현장감독자","workSum":"각종 도료(페인트, 바니시, 에나멜, 래커 등)와 유사 피막 형성용 제품을 제조하고자 배합·분산·용해·조색·여과·포장 공정에 종사하는 작업원의 활동을 감독·조정한다.","doWork":"제조를 하고자 하는 제품과 작업공정에 따라 작업원을 배치한다. 저장탱크, 용해탱크, 지게차, 승강기, 호이스트, 교반기 등 제조설비와 각종 장치의 안전 유무를 확인한 후 결함이 있으면 수리나 교체를 지시한다. 작업원의 생산계획에 따라 원료의 준비상태를 확인한다. 표준작업명세에 따라 지시된 작업이 이루어지는지 작업원과 함께 작업하면서 작업내용을 점검한다. 도료의 제조과정에서 발생이 될 수 있는 유해물질(안료의 크로뮴산납 등) 노출을 최소화하고 소음과 분진 등 각종 위험인자들을 방지하기 위한 대책을 마련한다. 철저한 안전위생 교육을 통하여 중금속 중독, 화학물질에 의한 상해, 기계로 인한 상해 등을 미연에 방지한다. 수시면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴·해결하고 문제점을 보완한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"도료제조반장","connectJob":"래커제조반장, 에나멜제조반장, 페인트제조반장","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C204","dJobICdNm":"[C204]기타 화학제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002580:1', '{"dJobCd":"K000002580","dJobCdSeq":"1","dJobNm":"도료조색원","workSum":"제조된 도료에 용제와 수지를 첨가해 소비자가 요구하는 표준견본판 색상으로 일치시키는 작업을 반복한다.","doWork":"마감이 완료된 도료의 색상을 표준견본판과 비교후 색상을 맞추기 위하여 필요한 원색을 계량하여 소량씩 투입한다. 수시로 교반하면서 반제품이 완전히 섞이게 한 후 다시 표준색상과 비교하는 작업을 반복한다. 이렇게 도장판을 표준견본판과 비교하는 방식을 반복하면서 미조정 작업을 통하여 조색을 한다. 소비자가 원하는 제품을 쉽고 빠르게 제조하기 위해서 각 제품의 품종에 따라 원색 에나멜(Enamel) 조색방식, 또는 원색 밀베이스(Mill Base) 조색방법을 미리 만들어 두기도 한다. 조색이 끝나면 조색에 소요된 원색사용량을 기록표에 기록한다. 견본을 채취하여 제품의 실험을 검사실에 의뢰한다. 최종 주석판을 표준색상카드와 같이 냉암소에 보관한다. 견본 무게를 달아 단위 부피당 안료의 비중에 의한 무게를 산출하는 경우도 있다. 점성도계를 사용하여 점도를 시험하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"웅크림|시각|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"마무리혼합원, 색조원, 도료조색사","connectJob":"레커조색원, 에나멜조색원, 페인트조색원","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C204","dJobICdNm":"[C204]기타 화학제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002922:1', '{"dJobCd":"K000002922","dJobCdSeq":"1","dJobNm":"도료조정원","workSum":"전 공정(배합, 분산)을 거친 각종 도료 제품을 표준과 비교하여 원료 및 첨가제를 교반해 조정한다.","doWork":"품질관리부서에서 작성을 한 교정지시서를 검토해 조정작업에 투입할 원료 및 첨가제를 준비한다. 분산 공정을 마친 반제품 도료를 조합탱크에 충진(Filling)하기 위해 밸브를 열고 펌프를 가동한다. 조정작업에 투입할 원료 및 첨가제를 밸브를 열어 투입하거나 소량씩 계량하여 투입한다. 유량계를 확인한 후 교반하여 투입 후의 변화를 관찰한다. 조합이 완료되면 밸브를 열고 펌프를 가동하여 조색공정으로 이송한다. 견본을 채취하여 품질관리부서로 보낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|시각|","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C204","dJobICdNm":"[C204]기타 화학제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006360:1', '{"dJobCd":"K000006360","dJobCdSeq":"1","dJobNm":"도말식입제제조원","workSum":"도말식 입제 제형의 살충제·살균제·제초제를 제조하기 위하여 분상혼합기, 용액혼합기, 건조기 등을 조작·관리한다.","doWork":"일정량의 모래를 호퍼중량계로 계량하여 혼합기에 투입한다. 혼합기의 조정판에 혼합조건을 입력하고 가동한다. 분상의 원제, 보조제, 증량제를 계량하여 분상혼합기에 투입하고 혼합한다. 혼합 도중에 접착용 용액을 스프레이로 분사시켜 가비중이 높은 과립 형태로 조제를 한다. 혼합기를 교반하면서 분상의 원료와 부원료를 계량하여 투입한다. 필요시 건조기로 운반하고 건조시킨다. 건조가 완료되면 대차 및 용기에 담아 저장조로 이송·보관한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C204","dJobICdNm":"[C204]기타 화학제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006850:1', '{"dJobCd":"K000006850","dJobCdSeq":"1","dJobNm":"모노머혼합원","workSum":"수용성 에멀전 접착제를 제조하기 위하여 원료와 기타 첨가제를 혼합하는 장치를 조작·관리한다.","doWork":"작업지시서에 따라 저장탱크로부터 원료와 기타 첨가제를 운반해 온다. 작업지시서에 명시된 배합비율에 따라 모든 원료를 혼합기에 투입한다. 탱크 용량에 따라 호이스트나 리프트를 사용하기도 한다. 혼합기의 조정판에 혼합조건을 입력한다. 급수밸브를 열어 일정량의 물을 혼합탱크에 충진한다. 유화제를 계량하여 투입한 후(물, 기름의 저항성 저하의 원인이 될 수 있으므로 과다한 사용은 자제를 한다), 혼합기를 가동하고 물과 원료가 잘 섞이는지 관찰한다. 혼합 및 1차 유화작업이 완료되면 중합반응공정으로 이송하기 위하여 혼합기 하단에 있는 배출밸브를 열고 이송호스를 연결한 후 펌프를 가동하여 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C204","dJobICdNm":"[C204]기타 화학제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005933:1', '{"dJobCd":"K000005933","dJobCdSeq":"1","dJobNm":"물감교반원","workSum":"물감 페이스트(Paste)를 제조하기 위하여 안료를 전색제에 분산시키는 물감교반기를 조작·관리한다.","doWork":"교반기의 임펠러가 배합조의 바닥에 닿지 않도록 적당한 높이로 내린다. 배합된 물질을 계량하여 배합탱크에 투입하고 교반조건을 입력한 후 교반기를 가동한다. 교반 도중에는 배합물들이 잘 섞이는지 수시로 확인한다. 교반탱크에 묻어 있는 안료, 배합물을 플라스틱 주걱으로 가운데로 모으고 안료 가루가 보이지 않을 때까지 교반을 계속한다. 일정 시간 교반이 진행된 후 교반기를 멈추고 견본 채취를 한 후 교반상태를 점검한다. 이상이 없으면 교반 과정을 거친 페이스트(Paste) 상태의 물감은 롤러를 이용해 고른 입자로 만드는 롤링공정으로 이송을 시킨다. 작업완료 후 교반기 날개를 세척한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C204","dJobICdNm":"[C204]기타 화학제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001292:1', '{"dJobCd":"K000001292","dJobCdSeq":"1","dJobNm":"물감롤링기조작원","workSum":"롤링기를 사용하여 연육과 배합이 완료가 된 페이스트(Paste) 상태의 물감을 곱게 가는 일을 한다.","doWork":"롤러의 작동 상태 및 청결 상태를 점검한다. 롤러의 간격을 제품에 따라 조정한다. 페이스트(Paste) 상태의 배합물을 롤러의 호퍼(Hopper:분립체의 저장 및 공급장치)에 투입하고 플라스틱 주걱으로 잘 섞어 준다. 롤러를 작동시킨 후 롤러를 통과해서 나오는 배합물의 상태를 살펴서 롤링횟수를 결정한다. 보통 페이스트(Paste) 상태의 물감을 1차 롤링한 후 숙성기간을 거쳐 2차 롤링을 한다. 롤링이 끝난 배합물은 대차에 담는다. 입도계를 사용하여 입도 측정을 한다. 입도가 맞지 않을 경우에는 수시로 롤러 간격을 조정한다. 작업일지에 제품번호와 롤링횟수 그리고 작업물량을 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C204","dJobICdNm":"[C204]기타 화학제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006490:1', '{"dJobCd":"K000006490","dJobCdSeq":"1","dJobNm":"바니시제조원","workSum":"전선제조 공정 중 전선절연 작업에 사용되는 바니시(Varnish)를 제조하기 위해서 각종 화학 수지, 촉매, 용제와 착색염료 등을 배합비, 배합온도, 배합시간 등에 맞춰서 배합한다.","doWork":"배합기의 필터·펌프·스팀 등을 점검하고 소형 케틀(Kettle)에 염료의 용재를 배합비에 따라 개량·투입·교반하여 착생원액을 만든다. 크레졸, 자일렌, 솔벤트, 레진 등의 재료를 저울로 계측한 후 배합비율에 맞춰서 배합기에 투입한다. 배합기를 가동시키고 배합기 내부의 반응 상태를 관찰하고 내부 온도를 조정한다. 점도계, 오븐, 저울 등을 사용해서 배합된 바니시의 점도, 비중 등을 검사한다. 시료를 채취하여 점도를 확인한다. 화학분해 장치를 사용해서 바니시의 화학적 성분이 명세서와 일치하는지 검사한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"니스제조원","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C204","dJobICdNm":"[C204]기타 화학제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006179:1', '{"dJobCd":"K000006179","dJobCdSeq":"1","dJobNm":"바이오농약제조원","workSum":"발효, 배양, 추출, 정제, 제형화 등을 통해 바이오농약을 제조한다.","doWork":"작업지시서에 따라 유효미생물을 준비한다. 제품에 따라 냉동된 미생물을 해동하여 플라스크에 배지를 넣어 배양하기도 한다. 산소요구도, 배양온도 등 배양 조건을 확인하고 배양기(발효기)를 설정한다. 배양에 필요한 배지를 배양기에 넣고 일정 시간 배양한다. 유효활성물질을 추출, 정제한 뒤 영양물질 등의 부자재와 혼합한다. 제품의 종류에 따라 식물추출물, 식물성오일 등과 제형화하여 포장한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"생물농약제조원","connectJob":"미생물농약제조원, 생화학농약제조원","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C204","dJobICdNm":"[C204]기타 화학제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003384:1', '{"dJobCd":"K000003384","dJobCdSeq":"1","dJobNm":"반응기조작원","workSum":"정제유(精製油, Refined Oil:불순물을 제거한 유지)를 해수에 반응시켜 불필요한 물질을 제거하고 여과하여 케이크상태로 만드는 장치를 조작·관리한다.","doWork":"정제된 석회유(石灰乳, Milk of Lime)의 양에 따라 반응시킬 해수의 양을 결정한다. 자동제어실(Control Room)에서 스위치·밸브·레버·버튼을 조작하여 석회유를 준비된 탈탄산 해수에 첨가하여 반응시키고, 반응에 의해 생성된 물질에 침강제를 첨가하여 침강속도를 촉진시킨다. 침전된 슬러리(Slurry)에 해수나 공업용수를 투입하여 불순물을 제거한다. 이송펌프를 작동하여 침전된 슬러리를 진공여과기에 투입하여 케이크(Cake)상태로 만들고, 소결성을 좋게 하기 위하여 강화제를 첨가한다. 강화제가 첨가된 케이크를 건조기로 이송한다. 해수 및 슬러리의 화학성분을 주기적으로 채취하여 분석한다. 작업내용이나 분석내용을 작업일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C233","dJobICdNm":"[C233]시멘트, 석회, 플라스터 및 그 제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007342:1', '{"dJobCd":"K000007342","dJobCdSeq":"1","dJobNm":"반응조관리원","workSum":"자성산화철과 같은 화학물질을 제조하기 위하여 원료를 반응시키는 탱크를 조작·관리한다.","doWork":"자기테이프에 쓰이는 자성산화철을 만들기 위해 지침서의 규정에 따라 반응조에 황산철 등의 원료를 투입한다. 투입된 원료에 일정한 온도, 압력, 촉매 등 여러 가지 반응조건을 유지하여 굽는다. 일정 시간마다 반응탱크를 확인하여 반응의 진행상황을 점검한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C222","dJobICdNm":"[C222]플라스틱제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005459:1', '{"dJobCd":"K000005459","dJobCdSeq":"1","dJobNm":"발색반응공정원","workSum":"크로뮴산납을 생성하기 위해 질산납 용해 공정과 중크롬산소다 용해 공정을 각각 거친 원료를 혼합·반응시키는 반응장치를 조작·관리한다.","doWork":"작업지시서에 따라 용해된 질산납과 중소다의 양과 순도를 확인한다. 용해조액 이송호스가 반응기 내부에 투입되었는지 확인한다. 용해된 원료를 반응조에 투입한 다음 공급수 밸브를 열어 전체 용량을 작업지시서에 명시된 용량으로 맞춘다. 공급수 밸브를 열어 일정량의 물을 충진한다. 반응기의 조정판에 온도 및 교반속도 등을 입력한 후 가동한다. 기타 첨가제 및 소금을 작업지시서에 따라 순서대로 계량하여 투입하고 일정 시간 반응시킨다. 견본을 채취하여 pH를 측정하고 제품규격에 맞도록 가성소다를 소량씩 첨가하여 적정한다. 일정 시간 반응을 시킨 후 반응기를 정지시킨다. 컨베이어 벨트 등을 이용해 최종 산물을 여과, 건조 공정으로 이송시킨다. 작업 중에는 반응조에서 발생이 되는 수증기, 산 가스 등이 배기라인을 통해서 잘 배출이 되는지를 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"중소다용해공정원, 질산납용해공정원","dJobECd":"8512","dJobECdNm":"[8512]화학물 가공장치 조작원","dJobJCd":"8312","dJobJCdNm":"[8312]화학물 가공 장치 조작원","dJobICd":"C204","dJobICdNm":"[C204]기타 화학제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;