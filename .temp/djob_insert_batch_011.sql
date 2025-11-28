INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004479:1', '{"dJobCd":"K000004479","dJobCdSeq":"1","dJobNm":"스마트그리드표준화연구원","workSum":"스마트그리드의 각종 설비, 통신 등의 표준화를 연구하고 국가 및 국제표준의 수립을 위한 업무를 수행한다.","doWork":"스마트그리드와 관련된 제품의 인터페이스, 전력선을 통환 통신의 통신규약, 정보의 처리방식과 관련된 개발주체와 여러 나라의 규격을 조사·분석하여 가장 적합한 표준안을 제시한다. 스마트그리드와 관련된 산업체 및 기관들의 의견을 취합하여 국내표준안을 수립하고 표준기관에 제출한다. 이를 바탕으로 국제표준화기관에 스마트그리드 관련표준안을 제출하고 제출된 표준안이 국제표준으로 채택될 수 있도록 홍보와 기술교류활동을 추진한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"지능형전력망표준화연구원","connectJob":"스마트그리드연구원, 국가표준코디네이터, 표준개발자","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005268:1', '{"dJobCd":"K000005268","dJobCdSeq":"1","dJobNm":"시계품질검사원","workSum":"육안 또는 관련 계측기기를 사용하여 외관, 수압·방수, 기능검사 등 시계의 조립상태 및 기능의 결함을 검사한다.","doWork":"검사표준서 및 검사기준서를 숙지하고 검사에 필요한 압력계, 수압방수기, 현미경 등 계측기기 및 검사도구를 준비한다. 육안 또는 현미경을 사용하여 외관상 표면오점, 부러지거나 긁힌 자국, 잘못된 도금, 외장의 빡빡함, 이물질의 여부 등을 검사한다. 압력계, 수압방수기를 조정하여 수압방수검사, 가압시험, 가열시험, 응축시험 등을 수행한다. 기능검사 지그를 사용하여 시계의 정지, 용두기능, 날짜, 요일기능, 침기능, 버튼기능, 회로기판, 방수기능에 중요한 고무패킹(O-Ring) 등의 결합상태 및 뒤뚜껑의 조립상태 등을 확인한다. 불량이 발견된 경우 시계검사반장에 보고하거나 관련 부서에 넘기는 등 적절한 조치를 취한다. 검사 완료된 시계의 수량을 기록하고 포장공정으로 이송시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"시계검사원","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"C274","dJobICdNm":"[C274]시계 및 시계부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005866:1', '{"dJobCd":"K000005866","dJobCdSeq":"1","dJobNm":"신재생하이브리드시스템개발자","workSum":"지열, 태양열, 태양광, 풍력 등의 신재생에너지를 융합하는 신재생하이브리드시스템(Hybrid System)을 설계·개발한다.","doWork":"신재생에너지(지열, 태양열, 태양광, 풍력 등)을 활용한 생산개념의 액티브기술과 자연형 태양열기술, 배열회수기술 등 패시브기술을 접목시킨다. 건물일체형 태양열시스템, 태양광시스템, 지열히트펌프시스템을 연계시키는 방안을 고안한다. 지붕면적이 태양광 발전모듈과 태양열 집열기를 모두 설치하기 부족한 경우 태양광 발전모듈을 지붕일체형으로 설치하고 주택의 남측 벽면에는 태양열 집열시스템을 벽면일체형으로 설치하는 등 주택의 구조를 고려하여 설계한다. 냉난방과 온수급탕용은 부하가 많이 걸리기 때문에 두 가지 이상의 에너지원을 하나의 최적시스템으로 구성하는 방법을 개발한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007187:1', '{"dJobCd":"K000007187","dJobCdSeq":"1","dJobNm":"엘이디조명광학설계기술자","workSum":"엘이디 조명의 광효율 향상 및 배광 특성을 확보하기 위한 렌즈, 반사판, 확산판 등 조명제품에서 요구되는 광학특성을 설계한다.","doWork":"엘이디패키지(LED Package)의 광학적 특성 중 광속, 색온도, 광효율, 지향각 등 광학적 특성을 높이기 위한 광학 구조를 설계한다. 또한, 이를 이용한 엘이디 조명 제품을 개발하기 위해 엘이디 패키지의 배열 방법에 따른 광원 모듈 설계하고, 사용 환경 및 목적에 맞는 광효율과 배광(配光:Light Distribution) 특성을 구현하기 위한 광학 설계를 진행한다. 광학설계 프로그램을 사용하여 엘이디패키지 배열방법, 렌즈(Lens), 반사판, 확산판 등을 설계하고, 이를 엘이디 조명 제품에 적용하여 조명 광학 구조를 설계한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"LED조명광학설계기술자","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"C284","dJobICdNm":"[C284]전구 및 조명장치 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003653:1', '{"dJobCd":"K000003653","dJobCdSeq":"1","dJobNm":"엘이디조명제품방열설계기술자","workSum":"엘이디(LED)조명기구에 방열을 위한 방열체, 방열판, 쿨러 등의 방열소재를 이용한 제품의 방열기능을 설계한다.","doWork":"엘이디(LED)조명기구의 수명과 성능향상 및 엘이디에서 발생하는 고열을 방열시키기 위해, 제품에 적용가능한 방열기술을 이용하여 최대한의 방열효과를 얻을 수 있도록 방열체, 방열판, 쿨러의 구조와 배치 등 방열기능을 설계한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"LED조명제품방열설계기술자","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"C284","dJobICdNm":"[C284]전구 및 조명장치 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001777:1', '{"dJobCd":"K000001777","dJobCdSeq":"1","dJobNm":"연료전지시스템연구원","workSum":"연료전지시스템기술을 종합적으로 연구하고, 연료전지의 효율을 향상 시킬 수 있는 시스템을 연구·개발한다.","doWork":"연료전지스택모듈, 주변기기(BOP)로 구성된 연료전지시스템의 성능 및 효율을 향상시키는 연구를 수행한다. 다양한 환경 조건에 따른 연료전지시스템을 평가하고 최적 운전기술을 개발한다. 타 시스템과의 통합설계를 위한 전체 시스템의 효율 최적화 연구를 수행한다. 연료전지를 활용하는 수송용, 건물용, 발전용 등의 다양한 연료전지시스템의 적용을 위해 관련기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"연료전지발전시스템연구원, 연료전지공정개발연구원, 연료전지시스템엔지니어, 연료전지시스템개발자, 연료전지시스템설계자","connectJob":"건물용연료전지시스템연구원, 자동차용연료전지시스템연구원, 휴대용연료전지시스템연구원","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"C282","dJobICdNm":"[C282]일차전지 및 축전지 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006628:1', '{"dJobCd":"K000006628","dJobCdSeq":"1","dJobNm":"연소신발전연구원","workSum":"발전설비 중 연소계통 및 연료에 대한 타당성 검토와 효율성 극대화, 신연료 및 대체에너지 개발, 신발전기술 등에 관한 연구업무를 수행한다.","doWork":"발전용 연료의 연소특성평가와 보일러의 연소해석 및 예측기술의 연구 등을 통한 연료 및 연소기술을 개발한다. 환경오염물질 배출 저감방안 확립을 위해 시험연소로를 이용한 연소특성 평가연구와 다양한 성상의 발전용탄 혼소특성 평가시험을 수행한다. 석탄가스화 복합발전, 가압유동층, 순환유도층 운전특성 등에 관한 기술개발을 위한 석탄전환이용기술을 연구·개발한다. 연료전지를 개발하기 위하여 용융탄산염, 인산염, 고체전해질 등을 연구한다. 석탄, 석유 등 수입의존성 에너지자원을 대체하는 발전방식개발을 위하여 풍력, 태양광 등의 천연자원을 이용한 대체에너지 이용 발전을 연구한다. 석탄가스화 복합발전기술, 가압유동층 복합발전기술 등의 신발전기술에 관해 연구한다. 석탄회를 콘크리트 혼화제로 재활용하기 위한 석탄회 정제기술을 연구한다. 기타 연구원(일반)들이 수행하는 일반적인 활동을 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","certLic":"전기기사","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004185:1', '{"dJobCd":"K000004185","dJobCdSeq":"1","dJobNm":"열전기시설관리원","workSum":"열병합발전소 내의 모든 열·전기 생산시설을 관리 및 운영한다.","doWork":"보일러, 터빈과 같은 발전설비와 열펌프, 열교환기 등과 같은 열발생설비, 열수송관, 순환펌프 등의 열수송배관설비를 관리하고 가동상태를 감독한다. 지역사회 내에서 필요한 열·전기의 수요조사를 통하여 열·전기의 생산 및 공급계획을 수립한다. 열발전설비의 운전실적을 분석하고, 계절적 특성에 따라 발생할 수 있는 열·전기 공급의 중단사태를 파악하여 대책을 수립한다. 수요자의 열사용시설기준을 관리한다. 주택, 공공건물, 공장 등에 설치된 열·전기계량기를 점검하며, 운영상황을 파악한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|고온|","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"D353","dJobICdNm":"[D353]증기, 냉·온수 및 공기조절 공급업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004599:1', '{"dJobCd":"K000004599","dJobCdSeq":"1","dJobNm":"온라인전기자동차연구원","workSum":"온라인 전기자동차에 전력을 전송하는 온라인 급전장치 및 집전장치시스템 등을 연구·개발한다.","doWork":"자체 배터리를 이용하여 주행하는 일반 전기자동차와 달리, 정차 또는 주행 중에 도로에 매설된 전력선으로부터 무선으로 전력을 전송받아 구동에너지로 사용하거나 배터리를 충전하는 방식의 온라인 전기자동차(OnLine Electric Vehicle:OLEV)를 개발하는 일을 한다. 온라인 전기자동차에 전력을 전송하는 장치인 온라인급전장치와 집전장치시스템을 연구한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005305:1', '{"dJobCd":"K000005305","dJobCdSeq":"1","dJobNm":"원자력설비설계원","workSum":"원자력발전소의 원자로, 전기·기계·계기설비, 중수설비 등을 신·증설 또는 개·보수하기 위하여 설계도와 사양서를 작성한다.","doWork":"원자력발전소의 신·증설공사에 관한 원자력설비의 타당성보고서를 검토하고 사양서를 작성한다. 공사에 관계되는 제반 자료를 수집·분석하여 개략적인 공사계획 및 설계도서를 작성하고 공사비를 산출하여 인허가수속에 필요한 서류를 작성한다. 수집자료와 개략적인 공사계획을 기준으로 현장시공에 적합하도록 세부설계도를 작성한다. 공사계획과 설계사항이 원자력관계법규 또는 공사관리규정에 적합한지 판단한다. 신·증설 또는 개·보수공사를 지도하고 감독한다. 공사시행과정에서 발생되는 계획·설계·공사상의 문제점을 검토하여 수정·보완한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|시각|","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","connectJob":"배전설비설계원, 수력발전설비설계원, 화력발전설비설계원, 원자력계기설계원, 원자력기계설계원, 원자력전기설계원, 원자력중수설비설계원, 원자로설비설계원, 원자력설비공사관리원","certLic":"원자력발전기술사, 원자력기사","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004277:1', '{"dJobCd":"K000004277","dJobCdSeq":"1","dJobNm":"원전계전기술연구원","workSum":"원자력발전설비의 최적운영 및 제어를 위한 각종 계전설비와 시스템의 개선, 개발, 정비에 대한 연구업무를 수행한다.","doWork":"원자력발전설비의 최적운영을 위한 계측제어설비 및 정비의 기술개발에 대해 연구한다. 원자력발전소의 계측설비가 안정적이고 효율적으로 운영되도록 개선하기 위하여 주요 기기의 성능평가, 디지털제어시스템을 개발·연구한다. 발전소에 영향을 미치는 기기들의 신뢰도 개선을 위한 정비효율성 증진분야, 열성능 향상분야의 연구를 수행한다. 관련 전기설비의 운영 및 정비기술을 지원하고, 설비개선 및 개발을 위해 연구한다. 원자력발전소의 최적 운영조건을 이루기 위한 인간공학 및 인공지능에 대해 연구한다. 원자력발전설비 운영자의 운영능력향상을 위하여 플랜트시뮬레이터(Plant Simulator)를 개발한다. 방사선이 노출되는 위험지역에서 작업할 로봇을 개발·연구한다. 원자력발전소의 전기 및 계측설비에 대한 설계서 등을 제작한다. 기타 원자력 계전기술에 대한 기술향상 및 기술개발연구를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002469:1', '{"dJobCd":"K000002469","dJobCdSeq":"1","dJobNm":"원전안전분석기술연구원","workSum":"원자력발전소의 안전성 확보를 위하여 설계도면 및 기존설비에 대한 타당성, 안정성을 검사하고, 문제발생에 따른 해결방안을 연구한다.","doWork":"원자력발전소의 핵연료, 원자로와 같은 핵심계통의 안전상태를 확인한다. 사고가 일어나지 않도록 운전범위를 제한하며, 원자로를 보호하는 안전계통의 성능이 충분한지 확인한다. 방사능 노출과 같은 각종 사고, 안전에 대한 정확한 해석을 위해 코드개량을 연구한다. 원자력발전소의 설계기준사고 및 계통성능해석을 위해 분석한다. 원자력설비에 발생할 각종 사고를 대비하기 위해 시나리오를 작성하여 사고대처방안을 수립하고, 안전성 확보를 위한 안전성을 평가한다. 방사선이 외부로 누출되지 않도록 대처기술을 개발하고, 각종 현황을 분석하여 대안을 제시한다. 원자로 이외의 감속재 및 냉각재가 흐르는 각종 배관, 밸브, 펌프 등의 부속설비에 대한 실증시험 및 안전성을 분석한다. 각종 원자력설비에 대한 기기진단 및 건전성을 평가한다. 원자력발전설비의 사고예방을 위한 장비개발, 기계설계 및 기기유체, 안전성 분석에 대해 연구한다. 기타 연구원(일반)들이 수행하는 일반적인 활동을 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"방사선비파괴검사기사","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002904:1', '{"dJobCd":"K000002904","dJobCdSeq":"1","dJobNm":"전기기술자","workSum":"발송배전, 건축전기설비, 산업전기설비, 변압기 제조업 등에서 관련 전기분야의 장·단기 기술정책 입안, 산업표준화 및 기술규격표준 등의 조정·보완, 전기설비의 설계, 시공, 관리 등의 업무를 수행한다.","doWork":"전기분야에 대한 각종 자료를 수집·분석하여 각 프로젝트에 맞는 장단기 기술정책을 입안한다. 전기분야의 계획, 설계, 감리, 감독 등의 기술용역을 수행한다. 과학기술정보를 수집·조사하여 생산 및 설비기술향상을 위한 방안을 연구한다. 산업표준화 및 사내기술규격표준 등의 제정·조정업무를 수행한다. 전기부문의 각종 설비계획, 건설계획, 정비계획 등 각종 기술적 조정업무를 수행한다. 기존설비의 시설용량, 규격, 형식 등을 검토하여 설비개선방안을 연구한다. 확장·증설하는 전기설비계획과 기존 설비와의 상관관계를 종합적으로 판단하여 보고한다. 기술 및 설비관리제도를 설정하고 총괄한다. 확장설비 건설을 위한 용역의 범위, 건설요원의 소요판단 및 조정, 구입사양서 검토 및 조정 등 필요한 기술적 지원업무를 수행한다. 설계용역 발주를 위해 설계자료를 검토하고 설계기준을 수립하며 보완한다. 설계실적을 분석·검토하고 설계 및 기준정립을 위해 현장조사를 실시한다. 전기설비에 대한 기술적인 사항을 교육한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"전기안전기술자, 전기감리기술자","certLic":"전기기사","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"C281","dJobICdNm":"[C281]전동기, 발전기 및 전기 변환ㆍ 공급ㆍ제어 장치 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007491:1', '{"dJobCd":"K000007491","dJobCdSeq":"1","dJobNm":"전기안전기술자","workSum":"전기설비 및 장비의 안전과 관련하여 연구·개발한다.","doWork":"전기설비 및 장비검사 및 점검기술을 개발한다. 검사 및 점검을 통한 이상 유무 판정기준을 개발한다. 안전검사 및 점검을 위한 장비를 연구하고 개발한다. 전기설비 및 장비검사 및 점검수행자의 전기안전사고 예방기술을 개발한다. 전기설비의 전기안전상태 진단기술 및 정밀 진단장치를 연구하고 개발한다. 전기설비의 모니터링기술과 자율전기안전관리기술 등을 연구하고 개발한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"설치","similarNm":"전기안전연구원","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"C281","dJobICdNm":"[C281]전동기, 발전기 및 전기 변환ㆍ 공급ㆍ제어 장치 제조업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001918:1', '{"dJobCd":"K000001918","dJobCdSeq":"1","dJobNm":"전기이용기술연구원","workSum":"생산된 전력을 효율적으로 이용할 수 있는 전기이용기술에 대한 개발 및 응용기술을 연구한다.","doWork":"빙축열 및 히트펌프시스템과 축열식 난방시스템에 대한 설계 및 성능평가기술을 개발한다. 전기수요관리기술을 향상시키기 위하여 축열시스템 제어기술, 축전시스템 및 고효율기기의 개발, 직접부하제어기술 개발 등에 대한 연구를 한다. 초전도 재료공정기술 및 초전도 플라이휠(Flywheel) 에너지 저장기술을 이용한 전력저장기술을 개발하기 위하여 연구를 한다. 초전도 전력기기에 대한 시스템 과도 및 이상상태를 해결하기 위하여 진단하고 해석한다. 초전도 전력기기에 대한 기술개발을 위하여 선로주변 전자장 해석 및 자성체 분석, 극저온 장치 및 설비성능평가, 초전도 전력기기 응용기술 등을 연구한다. 기타 전기이용기술을 개발하기 위하여 연구를 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001950:1', '{"dJobCd":"K000001950","dJobCdSeq":"1","dJobNm":"전기자동차전장품설계자","workSum":"전기자동차의 전장부품을 완성차 회사별로 고객맞춤형(커스트마이징:Customizing) 제품이 될 수 있도록 설계한다.","doWork":"파워컨트롤유닛(PCU), 전기자동차릴레이(EV-Relay) 등 전기자동차 전장부품을 적용할 완성차의 설계 사양에 맞춰 제품의 크기와 규격으로 설계하기 위해 시방서와 완성차의 계통도를 분석하고 시제품을 설계한다. 설계기술자는 성능시험을 완료한 후 양산설계를 통해 차량 모델별 제품이 될 수 있도록 설계한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"C303","dJobICdNm":"[C303]자동차 신품 부품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005040:1', '{"dJobCd":"K000005040","dJobCdSeq":"1","dJobNm":"전기자동차전장품연구원","workSum":"파워컨트롤유닛(PCU), 전기자동차릴레이(EV-Relay) 등과 같은 전기자동차 전장부품을 연구·개발한다.","doWork":"구동용 파워컨트롤유닛의 경우, 전기자동차의 구동모터를 제어하는 인버터와 전원을 공급하기 위한 전력변환부품 등 핵심전장부품을 연구한다. 전기자동차는 구동용 모터를 사용하여 주행하기 때문에 운전자가 최적의 주행을 할 수 있도록 구동모터 및 인버터 제어를 통해 자동차의 가감속을 실현한다. 구동용 전장부품은 차량의 동력성능 및 에너지 효율을 극대화하기 위해 고효율화, 경량화, 일체화를 연구한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"C303","dJobICdNm":"[C303]자동차 신품 부품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002224:1', '{"dJobCd":"K000002224","dJobCdSeq":"1","dJobNm":"전기자동차컨트롤러개발자","workSum":"트랜지스터, 저항 등의 전력소재를 이용하여 모터를 동작하는 제어회로설계와 제어프로그램개발을 통해 전기자동차(EV:Electric Vehicle) 컨트롤러를 연구·개발한다.","doWork":"트랜지스터, 저항 등의 전력소재를 이용하여 모터를 동작하는 제어회로설계와 제어프로그램개발하여 운전자의 조작과 도로상황에 따라 최적화된 주행이 될 수 있도록 전기자동차(EV) 컨트롤러를 개발한다. 개발자는 전기자동차의 운전 조작을 통해 차량의 성능과 효율을 향상시킬 방법을 연구한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"C303","dJobICdNm":"[C303]자동차 신품 부품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002432:1', '{"dJobCd":"K000002432","dJobCdSeq":"1","dJobNm":"전기자전거기술자","workSum":"전기자전거제품을 설계 및 개발하고, 제조과정에서 기술적 자문을 한다.","doWork":"국내외의 각종 납축전지의 자료를 수집·종합한다. 소요부품의 구입예산을 산정한다. 개발장비 및 도구를 준비하고 새로운 납축전지의 기술적인 모델을 개발한다. 필드테스트를 통한 여러 차례의 수정 및 보완을 거쳐 제품을 연구한다. 전기자전거의 납축전지의 전압을 최적상태로 유지할 수 있는 장비를 연구·개발한다. 과충전으로 인한 축전지 사고가 발생하지 않도록 납축전지에 타이머를 부착하는 등의 연구 및 개발을 한다. 전기자전거의 납산 축전지의 수명을 연장한 기술적인 메커니즘을 규명하고 장비에 적용한다. 제품의 다양한 기능을 과학적 수치로 계산하여 제품의 안정성을 증명한다. 개발결과물을 설계부서에 넘겨 설계과정에 자문을 하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"전기응용기술사, 전기기사, 전기산업기사","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"C319","dJobICdNm":"[C319]그 외 기타 운송장비 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007061:1', '{"dJobCd":"K000007061","dJobCdSeq":"1","dJobNm":"전기장비설계기술자","workSum":"새로운 전기장비나 기능이 바뀐 제품을 설계하고, 기술적 검증을 하여 양산용 도면을 작성한다.","doWork":"새로운 종류의 전기장비, 기존 제품의 변경된 기능 또는 양산되고 있는 제품을 설계하기 위하여 각종 첨단기술정보를 수집하고 검토하여 기술연구, 테스트, 실험 등의 업무를 수행한다. 각종 전기장비의 기능, 수명과 관련한 개발계획에 대한 설계사양서를 작성한다. 설계모형제작을 위한 금형을 주문하고 그에 따른 모형을 제작한다. 개발계획서와 모형을 심사받는다. CAD를 이용하여 본 설계도면을 작성한다. 제작된 전기장비의 개발제품에 대한 부품의 성능이나 치수, 생산성 등을 검증한다. 설계도면으로 인한 제품의 하자부분은 재검토하여 수정하고 재발주한다. 최종검사에 합격한 제품에 대한 양산도면을 작성하여 발주한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"전기제품설계기술자, 전기장비개발기술자, 전기제품개발기술자","connectJob":"부품을 설계하면 전기부품설계기술자, 전기회로를 설계하면 전기회로설계기술자, 만드는 제품에 따라 전동기설계기술자, 발전기설계기술자, 변압기설계기술자, 전원공급장치설계기술자, 전력회로차단기설계기술자, 배전반설계기술자, 경보장치설계기술자","certLic":"기계설계산업기사, 전기응용기술사, 전기기사, 전기산업기사","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"C281","dJobICdNm":"[C281]전동기, 발전기 및 전기 변환ㆍ 공급ㆍ제어 장치 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003740:1', '{"dJobCd":"K000003740","dJobCdSeq":"1","dJobNm":"전기저장장치시설기술자","workSum":"전기저장장치를 계통연계, 상용부하전원, 비상용전원 등에 사용할 수 있도록 설계 및 시공하고 안전을 관리한다.","doWork":"전기저장장치(이차전지, 플라이휠, 압축공기 등을 이용한 전기저장장치) 수용가의 부하용량을 산정한다. 시공할 전기저장장치의 용량을 산정한다. 수용가 시설관리자와 사용전원, 계통연계, 보호협조를 협의한다. 신재생에너지 또는 계통으로부터 전기저장장치에 전원을 공급하여 피크 부하 시 사용전원용, 비상전원용, 계통연계용으로 사용할 수 있도록 설계하고 설계도를 작성한다. 설계도에 따라 전기저장장치를 시공한다. 안전점검 및 성능을 시험하고 문제가 발생하면 조치한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"F423/M721","dJobICdNm":"[F423]전기 및 통신 공사업 / [M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001695:1', '{"dJobCd":"K000001695","dJobCdSeq":"1","dJobNm":"전동기개발원","workSum":"전기에너지를 기계에너지로 변환시키기 위하여 유도전동기, 부러시전동기, 부러시레스 전동기, 직류전동기 등 각종 전동기를 연구·개발한다.","doWork":"전동기의 개발 및 제조를 위한 각종 기술정보를 수집하고 검토하여 기술연구, 테스트, 실험 등의 업무를 수행한다. 제품을 점검하고 테스트하기 위한 기준을 설정한다. 효율성을 높이기 위하여 절연체, 구동축, 도체의 굵기 및 길이, 회전수 등을 결정한다. 사용하는 장소에 따라 방폭, 방수 등 특수한 조건에 대해 실험하고 연구한다. 인가하는 전압의 크기나 신호에 따라 일정한 각도로 회전하는 서보모터(Servo Motor)와 속도와 방향을 제어하는 스테핑모터(Stepping Motor:펄스신호를 줄 때마다 일정한 각도씩 회전하는 모터)를 개발한다. 부품을 설계하고 금형 및 부품을 개발한다. 각종 품질 관련 기준(전기안전기준) 적합성 검사를 의뢰하여 안전성을 검사한다. 완성된 제품의 최종검사 및 실험을 하고 이상이 발견될 시에는 수정 및 보완한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"모터개발자, 전동기개발기술자","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"C281","dJobICdNm":"[C281]전동기, 발전기 및 전기 변환ㆍ 공급ㆍ제어 장치 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004737:1', '{"dJobCd":"K000004737","dJobCdSeq":"1","dJobNm":"전력계통보호원","workSum":"발전기 및 송·변전설비 관련 계통보호설비의 운용에 따른 효율성과 안전성 확보를 위하여 계통보호업무를 수행한다.","doWork":"발전기 및 송·변전설비 관련 계통보호설비를 운용·조정한다. 보호계전기 정정 및 운전에 대한 기준을 수립하여 전력계통에 적합하도록 조정한다. 전력계통의 안정성 확보를 위한 보호계전방식 결정, 신증설 전력설비 보호배전반의 시설계획 수립, 계통보호설비 기술규격 제정 및 관리업무를 수행한다. 각종 보호계전기의 정정치를 검토·조정한다. 보호계전기의 동작을 분석하고, 고장조사 및 분석, 통계를 작성한다. 전력계통 고장분석, 보호설비의 개선, 보호계전기 관련 스위치 개발을 위해 연구한다. 계통보호설비의 성능개선을 위해 검토한다. 전력계통의 고장현상을 분석하여 개선방향을 제시하기 위한 제반 업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"전기기사, 전기공사기사","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004134:1', '{"dJobCd":"K000004134","dJobCdSeq":"1","dJobNm":"전력계통안정화연구원","workSum":"생산된 전력을 소비자에게 안정적으로 공급하기 위하여 발전설비, 송·변전설비 등 전력계통안정화에 대한 연구를 한다.","doWork":"전력계통안정화를 위한 전력수급, 제어 및 계통보호에 대하여 연구한다. 전력계통해석 및 안정운용, 전력계통기획, 대용량 전력변환기술, 유연송전기술(FACTS:Flexible AC Transmission System), 전력품질향상기술 등의 개발에 대해 연구한다. 전력계통에서 발생할 수 있는 각종 이상을 조기에 발견·해결하기 위하여 다양한 가변요소를 대입하여 응용연구를 한다. 이상발생 시 정상적인 작동이 이루어지도록 유연가변설비 및 전력품질향상기기 개발을 위해 연구한다. 전력계통안정화에 대한 신뢰도 구축을 위해 제반 연구를 한다. 순간전압변동현상 등 기타 전력계통안정화를 위하여 연구 및 개발한다. 기타 연구원(일반)들이 수행하는 일반적인 활동을 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"발송배전기술사, 전기기사, 전기공사기사","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001280:1', '{"dJobCd":"K000001280","dJobCdSeq":"1","dJobNm":"전력계통운용계획원","workSum":"안정적인 전력수급을 위하여 전력계통의 안정성 분석, 운용기술 분석 및 조사, 신기술 적용 및 계통전압 및 주파수의 품질을 관리하며 전력수급 및 발전계획을 수립한다.","doWork":"전력계통의 운용업무를 위한 규정을 관리한다. 전력계통의 고장분석을 통해 예방 및 대책안을 수립한다. 민간전기사업자 및 중요 자가발전 수용가와의 수급운용업무를 수행한다. 송·변전 및 배전분야의 전력손실에 대한 대책 및 방안을 수립하고, 종합적으로 관리한다. 신규수용에 따른 전력공급방안을 검토한다. 연간 전력수급운용계획을 수립하고, 지역별 전력수급안정운용에 대하여 검토한다. 전력수급운용관리를 위한 통계관리업무를 수행한다. 전력계통 안정성분석 및 운용기준을 세워 장·중·단기 전력계통 안전운용방안을 수립하고, 전력설비 신증설에 따른 계통구성을 검토한다. 전력계통의 안정성 확보를 위하여 안정화 장치 적용검토 및 시설계획을 수립한다. 안정적인 전력수급을 위하여 전압조정용 조상설비를 운용배치하고, 계통전압 및 주파수 품질관리에 대한 총괄업무를 수행한다. 계통운용 신기술 개발 및 적용방안을 수립하고 해외전력 신기술 정보수집 및 관리를 통하여 전력계통운영의 효율성을 제고한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","connectJob":"급전계획원, 전력수급운용계획원, 급전기술계획원","certLic":"발송배전기술사, 전기기사, 전기공사기사","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003604:1', '{"dJobCd":"K000003604","dJobCdSeq":"1","dJobNm":"전력기기연구원","workSum":"초고압송전용 변압기 및 제어장치, 고압제어용 반도체소자, 각종 전기설비의 수명연장을 위한 진단장비를 연구·개발한다.","doWork":"중전기기의 국산화를 위해 설계 및 송변전기기의 가스절연 개폐장치에 사용되는 가스변압기, 전력용 반도체소자를 이용한 새로운 전력기기 등 전력기기의 개발 및 제조를 위한 각종 기술정보를 수집·검토하여 기술연구, 테스트, 실험 등의 업무를 수행한다. 전력설비의 전기절연 진단기법을 개발하여 노후전기설비의 수명연장을 위한 정밀 전기절연 진단, 발전기의 수명예측 등에 관한 연구를 수행한다. 부품을 설계하고 개발한다. 제품을 점검하고 테스트하기 위한 기준을 설정한다. 테스트 및 품질에 관련한 장비를 구성하고 각종 품질 관련 기준(전기안전기준)의 안전성 및 적합성 여부를 분석하고 검사한다. 연구·개발된 제품제조를 위해 공정설계관리자와 협의하여 적절한 공정계획을 세운다. 완성된 제품의 최종검사 및 실험을 통하여 안정성을 검토하고 이상이 발견될 시에는 수정 및 보완한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"전력설비진단연구원","certLic":"전기응용기술사, 전기기사, 전기산업기사","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"C281","dJobICdNm":"[C281]전동기, 발전기 및 전기 변환ㆍ 공급ㆍ제어 장치 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002371:1', '{"dJobCd":"K000002371","dJobCdSeq":"1","dJobNm":"전력변환장치연구원","workSum":"작업표준에 따라 교류를 직류로 또는 직류를 교류로 변환하는 각종 정류기를 연구·개발한다.","doWork":"전력변환장치의 개발 및 제조를 위한 각종 첨단기술정보를 수집하고 검토하여 기술연구, 테스트, 실험 등의 업무를 수행한다. 다이오드정류기, 제어정류기, DC쵸퍼(Chopper:직류-교류 변환기의 일종), 인터버, 교류전압제어기, 트라이액(Triac:양방향성의 전류제어가 행하여지는 반도체 제어부품), 고압트랜지스터, 고압다이오드, 싸이리스터(Thyristor:트랜지스터 2개를 역방향으로 연결한 반도체) 등을 이용하여 전원을 변환하는 기술 및 제어장치를 연구·개발한다. 제품개발을 위하여 각종 기능, 수명 및 재생과 관련한 연구 및 실험 등의 업무를 수행한다. 부품을 설계하고 금형 및 부품을 개발한다. 전력변환장치에 각종 축전지를 연결하여 무정전전원장치를 개발하기도 하고, 심야전력을 충전하는 설비를 연구하기도 한다. 제품을 점검하고 테스트하기 위한 기준을 설정한다. 테스트 및 품질에 관련한 장비를 구성하고 각종 품질 관련 기준(전기안전기준)을 의뢰하여 안전성 및 적합성 여부를 검사한다. 연구·개발된 제품제조를 위해 공정설계관리자와 협의하여 적절한 공정계획을 세운다. 완성된 제품의 최종검사 및 실험을 통하여 안정성을 검토하고 이상이 발견될 시에는 수정 및 보완한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"무정전전원장치개발원","certLic":"전기응용기술사, 전기기사, 전기산업기사","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"C281","dJobICdNm":"[C281]전동기, 발전기 및 전기 변환ㆍ 공급ㆍ제어 장치 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004179:1', '{"dJobCd":"K000004179","dJobCdSeq":"1","dJobNm":"전력설비기술연구원","workSum":"발전소 및 송·변전소 등의 전력계통설비에 발생하는 각종 문제점 해결을 위한 기술지원과 성능분석을 통한 기술개선 및 기술개발을 위한 연구를 한다.","doWork":"변압기, 차단기 등 전력계통설비에 발생하는 이상 및 고장에 대한 문제해결을 위하여 기술지원을 한다. 전력계통의 이상, 설비의 성능개선 및 수명연장 등을 위하여 전력설비의 진단, 성능시험, 보호계통시험 및 전력계통 고장분석을 한다. 전력설비의 설계도면에 대한 타당성검사를 한다. 기타 전력설비의 기술향상 및 문제점 해결을 위한 연구와 현장기술지원을 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"전기기사, 전기공사기사, 발송배전기술사","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004622:1', '{"dJobCd":"K000004622","dJobCdSeq":"1","dJobNm":"전력통신기술연구원","workSum":"전력설비의 효율적 운영과 관리를 위한 전자통신분야의 기술향상 및 개선을 위한 연구를 한다.","doWork":"전력설비의 효율적 운영을 위한 정보통신망을 관리한다. 전력설비의 자동화시스템을 구축하기 위하여 전력자동화, 전력통신 신기술, 전력선통신(PLC:Power Line Communication)기술, 위성통신망 응용기술, 배전자동화통신 등에 대한 기술개발을 연구한다. 광전자 응용 및 전자파 대책을 위한 연구를 한다. 전력선통신망, 원격검침 등 전력통신의 개선을 위해 연구한다. 기타 전력설비의 효율적 운영과 관리를 위한 정보통신기술개발에 대해 연구한다. 현장의 전력통신기술업무를 지원한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"전기통신설계원, 전기통신설계기술자","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002994:1', '{"dJobCd":"K000002994","dJobCdSeq":"1","dJobNm":"조명설비연구원","workSum":"백열등, 형광등, 수은등 등의 조명기구의 조도, 광도, 휘도 등을 연구·분석하여 설치장소에 적합한 조명설비를 설계하고, 조명기술의 발전에 따른 새로운 방식의 조명설비를 연구·개발한다.","doWork":"각 조명기구의 조도, 광도, 휘도, 소비전력 등을 확인하여 설치장소에 적합한 기구를 선택하고 제어장치를 설계한다. 필요시 현장을 방문해 구체적인 계획을 수립하고, 설치장소의 환경에 맞게 눈부심, 눈의 피로감 등을 검사하여 원인을 파악하여 개선방법을 연구한다. 엘이디조명과 형광등과 같이 실내에서 사용되는 조명과 가로등, 보안등과 같이 실외에서 사용되는 조명을 연구한다. 특수 조명으로 레이저를 이용한 무대조명, 입체영상조명 등에 사용되는 조명장치 및 제어설비를 연구하기도 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"시각|","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"레이저조명설비연구원","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"C284","dJobICdNm":"[C284]전구 및 조명장치 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001944:1', '{"dJobCd":"K000001944","dJobCdSeq":"1","dJobNm":"조명연구원","workSum":"조명을 구성하는 광원, 기구, 회로 등의 각종 부품과 조명제품의 전기적/광학적 특성, 효율, 신뢰성, 수명 등을 연구·개발하여 성능과 품질을 개선한다.","doWork":"기계, 전기, 화학, 광학에 관한 지식을 이용하여 조명에 대한 관련 서적·정보 등의 자료를 수집·분석한다. 조명 제품별 제조계획서를 작성하며 제조에 필요한 자재, 장비, 도구의 개선을 위해 연구한다. 소재/부품 및 조명기구의 성능과 품질개선을 위해 연구하고 공정기술 및 자동화 등을 연구한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"시각|","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"등기구연구원","connectJob":"조명기구연구원","certLic":"전기산업기사, 전기응용기술사, 전기기사","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"C284","dJobICdNm":"[C284]전구 및 조명장치 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006013:1', '{"dJobCd":"K000006013","dJobCdSeq":"1","dJobNm":"태양광발전설비구성제품성능평가원","workSum":"태양광발전시스템을 구성하는 제품인 태양광모듈, 인버터, 접속함에 대한 인증시험을 실시한다.","doWork":"태양광발전시스템을 구성하는 제품(예: 태양광모듈, 인버터, 접속함)이 일정기간 효율적으로 작동하는지 보증하기 위한 테스트를 수행한다. 생산된 태양광제품의 신뢰성을 확인하기 위하여 성능과 내구성, 안정성 평가를 실시한다. 국제기준에 따라 태양광제품의 신뢰성을 검증하고 이를 기초로 국제공인인증 획득을 진행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"태양광발전부품신뢰성평가원","connectJob":"태양광모듈시험평가원, 인버터시험평가원, 접속함시험평가원","certLic":"전기응용기술사, 전기기사, 전기산업기사","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"C281","dJobICdNm":"[C281]전동기, 발전기 및 전기 변환ㆍ 공급ㆍ제어 장치 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006750:1', '{"dJobCd":"K000006750","dJobCdSeq":"1","dJobNm":"태양광발전설비기술개발연구원","workSum":"태양광발전시스템 기획·설계·설치·운영에 관련된 기술을 연구 및 개발한다.","doWork":"태양광발전시스템(태양광발전 모듈, 전력제어장치, 인버터 등)의 상태를 감시하고 컨트롤하는 모니터링 장치, 태양광 모듈을 지지하는 지지 구조물 등 태양광발전시스템의 핵심 부품을 연구·개발한다. 사용 목적에 적합한 통합 시스템 설계 기술을 개발하고, 시스템 이용률과 시스템 수명 향상을 위한 설계·설치 기술을 개발한다. 시스템의 안정적 운영을 위한 검사기술과 AI 기술을 개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"태양광발전설비연구원 ","certLic":"전기응용기술사, 신재생에너지발전설비기사(태양광), 신재생에너지발전설비산업기사(태양광)","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"C281","dJobICdNm":"[C281]전동기, 발전기 및 전기 변환ㆍ 공급ㆍ제어 장치 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005808:1', '{"dJobCd":"K000005808","dJobCdSeq":"1","dJobNm":"태양광발전설비설계기술자","workSum":"태양광발전시스템의 설치장소, 설치목적에 따라 제품 선정, 어레이 배치, 토목, 건축, 구조물, 창호, 전기 등 효율적이고 경제적인 시스템을 설계한다.","doWork":"지상용, 수·해상용, 건물설치용, 건축자재용 등 태양광발전시스템의 설치 장소 및 설치 목적에 따라 시스템 형식과 구성을 설계한다. 시스템 구성기기의 특성을 파악하고 설치장소와 설치방식, 방위각, 경사각을 선정하여 설치가능면적을 산정한다. 태양전지 모듈을 선정하고 최적의 어레이(Array:구조나 기능면에서 공통적으로 사용되는 요소와 장치 또는 패널 등을 복수 개 조합한 것)를 배치하고 토목, 건축, 구조물, 창호, 전기 등 효율적이고 경제적인 시스템을 설계한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"태양광발전설비설계사","certLic":"신재생에너지발전설비기사(태양광), 신재생에너지발전설비산업기사(태양광)","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"C281","dJobICdNm":"[C281]전동기, 발전기 및 전기 변환ㆍ 공급ㆍ제어 장치 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001793:1', '{"dJobCd":"K000001793","dJobCdSeq":"1","dJobNm":"태양열발전시스템기술자","workSum":"태양열발전시스템을 설계·개발하고, 제조 및 설치를 감독한다.","doWork":"태양열발전시스템과 관련된 국내외 논문과 기술동향, 정부의 신·재생에너지 관련 정책 등을 분석하여 태양광발전시스템의 개발방향을 정한다. 태양열발전소 건설을 위한 입지선정 및 공정설계를 한다. 태양열발전시스템 및 구성품인 집광부, 축열부, 제어장치 등을 설계 및 개발한다. 제품 설계, 개발과정 중에 규격인증사항을 검토하여 파일럿 실험을 통해 오류를 사전에 발견하고 수정한다. 태양열발전시스템의 제조 및 설치를 감독한다. 태양열발전시스템의 타당성, 경제성, 효율성 등을 분석하기도 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"손사용|","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"태양열발전시스템개발자","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"C281","dJobICdNm":"[C281]전동기, 발전기 및 전기 변환ㆍ 공급ㆍ제어 장치 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004698:1', '{"dJobCd":"K000004698","dJobCdSeq":"1","dJobNm":"태양열시스템연구개발자","workSum":"태양에너지를 직접 흡수하여 이용가능한 열에너지로 전환됨으로써 온수, 난방, 냉방 등에 사용하는 태양열시스템을 연구·개발한다.","doWork":"집열부, 축열부, 이용부, 제어부, 모니터링시스템으로 구성된 태양열시스템의 구성을 설계한다. 진공관형 집열관 등 향상된 집열시스템을 개발하여 겨울철 집열부의 열손실을 방지한다. 파라볼릭(Parabolic:폭이 좁고 강한 광선을 투사하는 집광기)타입의 태양추적 접시(Dish)형 반사경 등을 연구하여 집열효율을 최대한으로 증대시키기 위한 시스템을 개발한다. 냉·난방이 동시에 이루어지는 하이브리드(Hybrid) 태양열시스템을 개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"태양열발전설비설계기술자","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"C281","dJobICdNm":"[C281]전동기, 발전기 및 전기 변환ㆍ 공급ㆍ제어 장치 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003391:1', '{"dJobCd":"K000003391","dJobCdSeq":"1","dJobNm":"터빈설계기술자","workSum":"전력을 생산하는 각종 설비 중 터빈 및 보조설비의 설계, 유지, 보수에 대한 제반 업무와 기술지원을 한다.","doWork":"터빈 및 부속설비에 대한 정비계획을 수립하고 계획에 따라 예방정비 및 경상정비를 실시한다. 터빈 및 부속설비의 정상적인 가동을 위하여 누설, 진동, 온도 등의 일상점검을 실시하고 이상 및 장애요인을 파악한다. 터빈 및 부속설비의 효율적 운영을 위해 국내외 기술자료를 분석하고 개선방향을 검토한다. 유지관리를 위한 소요자재를 파악한다. 개·보수 및 신·증설공사에 따른 기술관리, 공사감독 및 작업진행사항 기록유지 등의 업무를 수행한다. 수처리 설비에 대한 유지·보수기술을 제공하고 설계서를 작성한다. 유지보수공사의 감독·감리를 한다. 터빈설비를 보조하는 보일러설비를 유지·관리한다. 연료저장조, 소화설비 등에 대한 계획을 수립하고 설계도를 작성한다. 시공 시 감리·감독을 하고 유지·관리한다. 냉각탑 및 폐수처리설비를 유지·관리한다. 기타 터빈 및 관련 부속기기의 원활한 가동을 위한 유지·관리업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"가스터빈설계유지원, 증기터빈설계유지원","certLic":"일반기계기사, 건설기계기사","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"C281","dJobICdNm":"[C281]전동기, 발전기 및 전기 변환ㆍ 공급ㆍ제어 장치 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005597:1', '{"dJobCd":"K000005597","dJobCdSeq":"1","dJobNm":"풍력발전기전기설계기술자","workSum":"증속기(Gear Box)로부터 전달받은 기계적 에너지를 전기적 에너지로 변환시키는 발전기(Generator) 등 전기에너지로 바꾸어 주는 전기적 부품을 설계한다.","doWork":"전기식 모터드라이브로 블레이드 각도를 연속제어하여 전력생산을 높인다. 낮은 부하에서도 운전효율이 높은 영구자석형 동력발전기를 설계한다. 최상의 요잉(Yawing:상하방향을 향한 축회전의 진동)가동력을 위한 인버터 전기제어모터의 숫자와 출력을 결정한다. 풀파워컨버터 방식으로 전기계통의 불안정 요소를 극복한다. 인버터와 컨버터를 제어하는 프로그램을 업데이트한다. 저풍속에서 더 좋은 효율을 가지는 발전기를 선택하고 발전기의 유지보수가 쉽도록 설계한다. 컨버터의 송전망 연결호환성을 높이고 송전망 저전압 발생 시 발전기를 보호할 수 있는 기능을 적용시킨다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"풍력발전설비설계기술자","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"C281","dJobICdNm":"[C281]전동기, 발전기 및 전기 변환ㆍ 공급ㆍ제어 장치 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006198:1', '{"dJobCd":"K000006198","dJobCdSeq":"1","dJobNm":"풍력발전단지설계기술자","workSum":"풍력발전단지 건설을 위한 대상지역의 특성, 풍량자원, 경제성 분석을 통해 최적의 풍력단지를 계획 및 설계한다.","doWork":"풍력발전단지의 배치계획을 수립하기 위해 1년 이상 동안 풍력발전기 허브 높이 부근에서 풍황을 측정한다. 풍황에 대한 연속데이터를 취득하여 방위별 풍속, 풍량, 에너지밀도, 난류강도, 극한풍속 등을 기록한다. 풍속데이터 분석, 윈드프로파일 산정을 위한 표면조도 분석, 적용 풍력발전기 선정, 후류효과를 감안한 이격 등을 분석하여 연간발전량, 단지효율, 이용률 등 발전단지 운전성능을 예측한다. 파일럿 타워를 세운 후 약 1년 정도의 데이터를 국제인증기관에 보내 데이터를 검증한 후 파일럿 풍력발전기에 대한 인증을 받는다. 적용 풍력발전기의 기종을 평가하고 구조물에 대한 설계를 검토한다. 그리드 커넥션(발전소 등에서 생산된 전력을 전력망에 공급하는 것)에 대한 설계를 살펴보고 공사비를 산정하여 경제성을 분석한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"종합","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"F412","dJobICdNm":"[F412]토목 건설업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004820:1', '{"dJobCd":"K000004820","dJobCdSeq":"1","dJobNm":"해상그리드설계기술자","workSum":"해저전력케이블 및 육상전력케이블 포설을 포함한 전력선망 설계와 풍력단지 내 해상변전소 설계 등 해상풍력단지의 전력계통을 연계하는 해상그리드를 설계한다.","doWork":"해상풍력단지 계통연계를 위해 전력선, 전력망, 해상변전소를 설계한다. 육상 전력망 계통연계를 위해 해저케이블 및 육상케이블을 포설하고 계측제어계획을 세운다. 해저파워케이블 설치 시 주변의 지형조건을 조사하여 작업가능 조건을 평가한다. 변전소에 사용될 제너레이터, 컨버터, 트랜스포머 등의 용량을 결정한다. 윈드터빈 간 전력선을 연결한다. 인터넷을 이용하여 스카다(SCADA)에 데이터가 전송되도록 설계한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"발송배전기술사, 전기기사","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"C281","dJobICdNm":"[C281]전동기, 발전기 및 전기 변환ㆍ 공급ㆍ제어 장치 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001260:1', '{"dJobCd":"K000001260","dJobCdSeq":"1","dJobNm":"해양에너지시스템기술자","workSum":"해양에너지를 활용한 발전시스템 및 관련 설비에 대한 설계, 제작, 시공 등 기술적 업무를 수행한다.","doWork":"조력발전시스템(댐과 같이 방조제 안과 밖의 수위 차를 이용하여 발전) 및 이에 필요한 수차발전기를 설계·개발한다. 해안고정식 파력발전 또는 부유식 파력발전에 적합한 발전시스템을 설계·개발한다. 해양온도차발전(따뜻한 표층수로 프레온과 같은 냉매를 가열해 터빈을 돌리고 차가운 심층수로 다시 냉각해 재활용하여 발전)에 적합한 장치 및 시스템을 설계·개발한다. 조력발전시스템의 효율성을 높이기 위한 연안구조물의 설계를 하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"손사용|","workEnv":"위험내재|다습|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"발송배전기술사, 전기기사","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"C281","dJobICdNm":"[C281]전동기, 발전기 및 전기 변환ㆍ 공급ㆍ제어 장치 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003984:1', '{"dJobCd":"K000003984","dJobCdSeq":"1","dJobNm":"해양플랜트계장설계사","workSum":"해양플랜트구조물에 설치될 계기장치의 위치 및 상세사양에 문서 및 도면을 작성하고 검증한다.","doWork":"기본설계단계에서 작성된 PFD(Process Flow Diagram), P&ID(Piping & Instrument Diagram), Data Sheet를 기본으로 Instrument Index, RFQ(Requisition For Quotation), TBE(Technical Bid Evaluation), Vendor Print Review, Loop Drawing, Hook Up Drawing, Instrument Location Plan Drawing, Control Room Layout Drawing, Cable & Conduit Layout Drawing, Wiring Inter-Connection Drawing, Typical Detail Drawing, Instrument Construction Specification을 작성하고 검토한다. 필요에 따라 설계를 수정하는 작업을 진행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내·외","physicalAct":"손사용|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"C311/F412","dJobICdNm":"[C311]선박 및 보트 건조업 / [F412]토목 건설업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002232:1', '{"dJobCd":"K000002232","dJobCdSeq":"1","dJobNm":"해양플랜트전기전자관리자","workSum":"해양플랜트의 전자·전기, 통신 장비의 유지 및 보수업무를 수행한다.","doWork":"해양플랜트 내 장비구동 중 발생하는 전기·전자 관련 문제점에 대해 보고를 받고 이에 대한 조치를 취한다. 각 작업이 이루어지기 전 안전관리담당자에게 작업승인서를 작성 및 제출해 허가를 받는다. 필요에 따라 기계관리자 및 운전자와 협의 하에 유지 및 보수작업을 진행한다. 발전기, 고·저압 배전반, 추진장치 등 전기분야, 기계 전원장치 및 DP시스템, 항해장비 등의 전자장치의 제어시스템 및 통신장비를 유지·보수한다. 보수 후 작동 여부를 점검한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"C311/F412","dJobICdNm":"[C311]선박 및 보트 건조업 / [F412]토목 건설업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006798:1', '{"dJobCd":"K000006798","dJobCdSeq":"1","dJobNm":"해양플랜트전장설계사","workSum":"해양플랜트구조물에 설치될 전기장치의 위치 및 상세사양에 대해 설계 및 검증을 담당한다.","doWork":"건조사양서를 기반으로 의장품구매서 작성과 선박 내의 전기의장품의 시스템별 도면작성, 상세배치설계를 하고 배가 인도되기 전까지 제반 사항을 수행한다. 발전기를 통해 전기를 생성한 다음 배전반을 통해 전원을 필요로 하는 장비에 공급하는 전력시스템(발전기:Main Switch Board, Emergency Switch Board, 각종 Power Distribution Board), 선박의 자동화에 필요한 알람 및 자동제거가 가능하도록 하는 제어장치시스템(알람감지시스템, 브릿지 항조종시스템 및 각종 센서 및 알람 등), 선박 자동운항을 위해 필요한 항통장비 및 통신장비시스템(선내전화, 무전기, 스피커, ECDIS, GMDSS 등), 선박의 각종 구역에 조도를 조절하는 조명시스템, 화재발생 시 선박의 안전을 위해 각종 화재감지기 및 경보음 발생이 되도록 하는 소화설비시스템 등으로 구분하여 설계업무를 수행한다. 설계 후 검증을 통해 설계를 수정한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내·외","physicalAct":"손사용|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"1531","dJobECdNm":"[1531]전기공학 기술자 및 연구원","dJobJCd":"2341","dJobJCdNm":"[2341]전기공학 기술자 및 연구원","dJobICd":"C311/F412","dJobICdNm":"[C311]선박 및 보트 건조업 / [F412]토목 건설업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003157:1', '{"dJobCd":"K000003157","dJobCdSeq":"1","dJobNm":"가상훈련디바이스개발자","workSum":"가상훈련 콘텐츠를 운영하기 위해 장착형 또는 비장착형 디바이스를 개발한다.","doWork":"운영하고자 하는 가상훈련 콘텐츠의 요구사항을 반영하고 기능과 성능을 확보할 수 있도록 디바이스를 설계한다. 설계에 따라 작업방법과 부품을 수급하고 콘텐츠의 요구사항에 최적화된 디바이스를 제작한다. 제작이 완료된 디바이스의 테스트를 진행하여 설계조건의 충족 여부와 신뢰성을 평가한다. 문제발생 시 문제점을 파악하고 개선사항 및 평가된 내용을 보고서로 작성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"협의","workFunc3":"정밀작업","similarNm":"가상훈련하드웨어개발자","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003178:1', '{"dJobCd":"K000003178","dJobCdSeq":"1","dJobNm":"건물용연료전지제어시스템개발자","workSum":"건물에 설치된 연료전지 시스템의 효율적이고 안전한 운영을 위해 제어 시스템을 설계·개발·유지한다.","doWork":"건물 내 연료전지 시스템의 효율적이고 안전한 운영을 위해 제어 알고리즘을 설계하고 시스템을 개발한다. 건물용 연료전지의 출력을 최적화하고, 시스템을 기존 전력망 및 공조시스템(HVAC)과 통합하여 운영한다. 실시간 데이터 수집과 분석을 통해 시스템 성능을 개선하며, 지속적인 모니터링과 유지보수로 안정성을 확보한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C281/C282","dJobICdNm":"[C281]전동기, 발전기 및 전기 변환ㆍ 공급ㆍ제어 장치 제조업 / [C282]일차전지 및 축전지 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003812:1', '{"dJobCd":"K000003812","dJobCdSeq":"1","dJobNm":"계측기기기술자","workSum":"정밀전자계측기기, 통신용계측기기, 환경용계측기기, 의료용계측기기 등을 연구·개발하며 제품양산을 위해 생산라인에서 감독·지원·조언한다.","doWork":"새로운 계측기 개발을 위하여 국내외의 기술정보자료를 수집·연구한다. 기존 제품의 품질시험을 한다. 기존 제품의 문제점 및 개선점을 파악하고 새로운 제품에 적용한다. 신제품의 회로를 설계하고 금형 및 부품을 개발하거나 제작을 의뢰한다. 시작품의 성능 및 신뢰성 평가를 실시한다. 시작품의 성능이 원하는 방향에 부합할 경우 생산계획을 수립한다. 생산공정관리자와 협의하여 제품 양산을 추진하고 공정을 개선한다. 설계도면의 표준화작업, 특허관리, 품질관리 등 기술정보관리업무를 수행한다. 개발 및 연구자료를 기록하고 보관하여 다른 제품의 개발자료로 활용한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"계측기기연구원, 계측기기개발자","certLic":"산업계측제어기술사, 전자기사","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C272","dJobICdNm":"[C272]측정, 시험, 항해, 제어 및 기타 정밀기기 제조업; 광학기기 제외","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005436:1', '{"dJobCd":"K000005436","dJobCdSeq":"1","dJobNm":"공정장비제어프로그램개발자","workSum":"제품제조에 사용되는 공정장비를 조작·제어하기 위한 프로그램을 개발한다.","doWork":"공정장비의 개발목표를 파악하고 필요한 기능을 분석한다. 제어프로그램의 개발에 필요한 일정을 수립한다. 공정장비 전체를 제어하기 위한 알고리즘(Algorithm)을 구축하고 프로그램언어(Program Language), 소프트웨어개발 키트(SDK:Software Development Kit), 표준프로토콜 등을 파악한다. 모터의 제어, 센서의 계측정보 수집, 전기신호의 제어 등을 통해 세부기능을 제어할 수 있도록 프로그램을 제작한다. 공정장비의 각종 기능을 제어할 수 있는 인터페이스를 설계·개발한다. 기존 공정장비에 대한 제어프로그램의 유지보수 및 생산된 공정장비에 대한 제어프로그램의 설치와 조정을 수행하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"장비제어소프트웨어개발자","certLic":"정보처리기능사, 임베디드기사","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C292","dJobICdNm":"[C292]특수 목적용 기계 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006966:1', '{"dJobCd":"K000006966","dJobCdSeq":"1","dJobNm":"광능동부품개발자","workSum":"광능동부품을 개발하고 시제품 제작 및 시험, 평가, 인증, 양산이관업무를 진행한다.","doWork":"광능동부품을 개발하기 위한 기술동향 및 타당성 검토 후 선정된 부품개발을 위해 계획을 수립한다. 광능동부품(光能動部品:Optical Active Component, 전원의 공급에 의해서 본연의 특성을 발휘하는 광부품, 광트랜시버, 광변조기, 증폭기, 광원-Laser Diode, 광 검출기-Photo Diode)의 요구 스펙에 맞는 부품을 설계⋅개발한다. 시제품 제작을 통해 특성을 평가하고 문제점을 분석하여 최적화 설계한다. 최종 제품에 대한 특성 평가, 시험, 인증을 하고, 제품 생산을 위한 제조 공정 조건 및 특성에 대한 양산이관업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"전자응용기술사, 전자기사, 전자산업기사","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004547:1', '{"dJobCd":"K000004547","dJobCdSeq":"1","dJobNm":"광반도체소자연구원","workSum":"광통신용 모듈, 광검출기, 광증폭기, 광신호처리기, 광변조기, 광검출기, LED 조명기구, 태양광 모듈 등에 사용되는 각종 광반도체소자를 전기적, 구조적 관점에서 연구·개발한다.","doWork":"광신호를 전기신호로, 전기신호를 광신호로 전환할 수 있는 광반도체 소자특성을 연구한다. 고객이 요구하는 광반도체 소자특성을 만족하는 회로설계를 지원한다. 각종 응용제품별 회로설계기준으로 광반도체 소자 제조공정을 사진현상, 식각, 확산 및 박막 등 단위공정연구원과 협의하여 결정한다. 광반도체 소자의 특성평가, 실장평가, 환경시험, 수명시험, 내성시험과 같은 불량분석업무를 통해 제품 신뢰도를 검사한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"광반도체 연구원","connectJob":"광소자연구원, 태양광소자연구원, LED소자연구원","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002100:1', '{"dJobCd":"K000002100","dJobCdSeq":"1","dJobNm":"광반도체제조기술자","workSum":"광통신용 모듈, 광검출기, 조명기구, 태양광 모듈 등에 사용되는 각종 광반도체 제조를 위한 생산관리, 제조공정, 시설·장비운영, 검사, 불량분석 및 문제해결 등의 업무를 지원·관리한다.","doWork":"광신호를 전기신호로, 전기신호를 광신호로 전환할 수 있는 광반도체 소자기술, 제조공정, 생산장비, 소자 품질검사 및 관리지식을 활용하여 광반도체 생산 관련 직무전체를 총괄, 지원 및 관리한다. 광반도체 공정기술자, 장비기술자, 제조원과 공동으로 생산, 검사 및 품질관리업무를 수행한다. 광반도체 소자 품질수율 및 생산성 향상을 위해 사진현상, 식각, 확산, 박막, 세정, 연마, 조립 및 검사 공정·장비기술자와 공동으로 문제점 도출, 원인분석, 개선작업을 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"광반도체기술자","connectJob":"광반도체공정기술자, 광반도체장비기술자, 광반도체제조반장 등","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002214:1', '{"dJobCd":"K000002214","dJobCdSeq":"1","dJobNm":"광수동부품개발자","workSum":"광수동부품을 개발하고 시제품 제작 및 시험, 평가, 인증, 양산이관업무를 진행한다.","doWork":"광수동부품을 개발하기 위한 기술동향 및 타당성 검토 후 선정된 부품개발을 위해 계획을 수립한다. 광수동부품(光受動部品:Optical Passive Component, 별도의 전원을 공급하지 않고도 본연의 특성을 발휘하는 광부품. 광커플러, 스플리터, AWG, 광어댑터, 광감쇠기, 광커넥터 등의 요구 스펙에 맞는 부품을 설계⋅개발한다. 시제품 제작을 통해 특성을 평가하고 문제점을 분석하여 최적화 설계를 진행한다. 최종 제품에 대한 특성 평가, 시험, 인증을 수행하고, 제품 생산을 위한 제조 공정 조건 및 특성에 대한 양산이관업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"전자응용기술사, 전자기사, 전자산업기사","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005139:1', '{"dJobCd":"K000005139","dJobCdSeq":"1","dJobNm":"광원구동회로개발품질평가원","workSum":"개발된 광원구동회로의 품질을 평가한다.","doWork":"광원구동회로 제품, 블록, 단품 등에 대해 주어진 제품스펙과 부품스펙, 데이터시트, 기술적으로 협의된 노하우를 바탕으로 평가한다. 구동회로가 스펙에 맞게 설계되었는지를 검증한다. 각 회로의 입출력 특성평가 및 내부 회로블록 및 단위부품의 특성에 맞게 설계되었는지를 검증한다. 설계자에게 평가결과를 전달한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"전자응용기술사, 전자기사, 전자산업기사, 광학기사","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004502:1', '{"dJobCd":"K000004502","dJobCdSeq":"1","dJobNm":"광원구동회로부품조달원","workSum":"설계자가 선정한 스펙에 부합하는 부품을 조달한다.","doWork":"설계자가 선정한 부품스펙을 확인한다. 부품을 조달하기 위하여 유사부품이 사내에 있는지 확인하고 생산공정에 공급한다. 신규부품일 경우 부품의 생산이 가능한 기업을 파악하고 기업의 재무, 생산능력, 품질관리능력, 납기대응력 등을 종합적으로 판단하여 부품개발을 발주한다. 수급할 부품의 단가에 대해 협상한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"전자응용산업기술사, 전자기사, 전자산업기사","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004772:1', '{"dJobCd":"K000004772","dJobCdSeq":"1","dJobNm":"광원구동회로신뢰성시험원","workSum":"정해진 규격 또는 개발자가 협의한 기준에 따라 광원구동회로 모듈, 부품 등에 대한 신뢰성을 시험한다.","doWork":"시험할 광원구동회로 모듈, 부품의 개발규격을 확인한다. 환경시험계측기기 및 시험기구를 사용하여 광원구동회로의 실제 사용조건을 토대로 장기사용 시 발생가능한 문제점을 단시간에 실험실 수준에서 예측하는 기법을 개발한다. 광원구동회로의 신뢰성 시험을 실시한다. 시험결과를 분석하여 보증기간 이내에 고장발생 가능성이 있는 부분을 파악한다. 시험성적서를 작성하고 설계자에게 전달한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"전자응용기술사, 전자기사, 전자산업기사","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004941:1', '{"dJobCd":"K000004941","dJobCdSeq":"1","dJobNm":"광통신광원설계기술자","workSum":"광통신용 광원을 설계하고 시제품을 개발한다.","doWork":"광원을 구동하기 위한 콘셉트를 결정한다. 스펙을 협의하고 결정한다. 광통신용 광원(광발생), 광변조기(광전송매체에 맞게 광신호 변조), 구동회로(안정된 광출력 및 발진파장 유지), 온도안정화회로 등의 블록설계와 세부설계(회로설계와 PCB설계)를 한다. 설계된 회로를 자체평가한다. 시제품을 제작하여 최종품평회를 한다. 제품양산을 위해 기술문서작성 등 이관 전 단계까지 기술지원을 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"광학연구원, 광엔지니어, 광회로설계기술자","certLic":"전자응용기술사, 전자기사, 전자산업기사","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004322:1', '{"dJobCd":"K000004322","dJobCdSeq":"1","dJobNm":"광트랜시버모듈개발자","workSum":"광통신용 송수신 모듈을 개발한다.","doWork":"고객의 요구분석을 통해 광트랜시버모듈의 개발계획을 수립한다. 광통신용 송수신모듈(100M, 1G, 10G급) 또는 그 이상의 전송속도를 제공하는 광트랜시버(Optical Transceiver:하나의 유닛으로 광송신과 수신기능을 동시에 수행하는 장치)를 개발한다. 성능을 시험한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"전자응용기술사, 전자기사, 전자산업기사, 광학기사","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004816:1', '{"dJobCd":"K000004816","dJobCdSeq":"1","dJobNm":"금융자동화기기인식요소개발원","workSum":"금융자동화기기의 신뢰성 및 효율성을 극대화하기 위해 기기 인식요소의 분석, 개선 및 개발을 위한 연구를 한다.","doWork":"각종 금융자동화기기(Automatic Teller Machine) 및 주변장치에 대한 자료를 수집·분석한다. 세계 각국의 유통 은행권을 수집하여 기기식별기능 및 품질분석을 실시한다. 기기 인식시스템(기기 인식요소는 자성요소, 형광요소, 적외선 인식요소, 초음파 등)의 각 요소를 자성인식기, 형광분석기, 적외선 분석기 등 각종 시험장비를 이용하여 시험·분석하여 개발한다. 자성의 강도측정, 자성패턴(문자화, 숫자, 바코드)의 개발, 인식기의 시간측정을 통하여 고속으로 인식이 되도록 한다. 적외선 강도, 형광물질의 강도와 패턴을 연구한다. 유가증권에 사용되는 제지 등 각종 재료의 물리·화학적 검사를 실시하여 재료를 선정하고 기기식별 특성과 내구성 및 안전성 시험을 한다. 기기 언어를 효율적으로 설계하고 유가증권의 배치방법을 개발하여 기기 식별기능을 검증한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C263","dJobICdNm":"[C263]컴퓨터 및 주변장치 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002494:1', '{"dJobCd":"K000002494","dJobCdSeq":"1","dJobNm":"멀티미디어연구원","workSum":"멀티미디어서비스를 제공하기 위한 멀티미디어처리기술, 멀티미디어 콘텐츠, 멀티미디어 기기 등을 연구·개발한다.","doWork":"영상신호 처리기술, 음향신호 처리기술, 통신기술을 바탕으로 멀티미디어신호를 입·출력할 수 있는 멀티미디어하드웨어를 설계한다. 멀티미디어 응용서비스 기술을 연구·개발한다. 개발된 시제품을 검사하여 기기의 성능을 점검한다. 적합한 제조공법에 따른 양산제품이 나오기까지 수정·보완한다. 양산된 제품의 오류를 수정하거나 기술지원업무를 하기도 한다. 정보검색 엔진 및 서비스, 전자상거래기술 및 서비스 개발에 대하여 연구한다. 영상서비스를 연구·개발한다. 음성언어기술 연구 및 응용서비스를 개발한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"영상시스템연구원, 영상통신연구원, 음향시스템연구원, 사운드(Sound)카드개발자, 음성처리보드개발자, 영상처리보드개발자, 통신보드개발자","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005328:1', '{"dJobCd":"K000005328","dJobCdSeq":"1","dJobNm":"메모리반도체소자 공정연구원","workSum":"메모리반도체 소자회로설계를 반영하는 Photo Mask 제조공정, 소자회로 성능목표를 구현하기 위한 다양한 회로배선구조의 소자제조공정을 연구·개발한다.","doWork":"메모리반도체소자 회로설계 사양에 따라 다양한 재료와 배선선폭을 가지는 Photo Mask를 사진현상공정연구원과 함께 연구·개발한다. 고객이 요구하는 소자회로 성능목표를 기준으로 사진현상, 식각, 이온주입, 확산, 화학기상증착, 금속막증착, 세정, 연마 및 계측검사공정을 조합한 소자제조공정(Process Integration)을 단위공정연구원과 공동으로 연구·개발한다. DRAM 소자의 Isolation, Gate, Bit Line, Capacitor, Interconnect 등 회로배선을 다양한 소재, 구조를 이용하여 연구·개발한다. 이후 메모리반도체소자 조립 및 검사공정을 통해 소자의 전기적, 구조적 특성의 유효성 여부를 검증한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체소자공정연구원","connectJob":"DRAM소자공정연구원, Flash소자공정연구원, SRAM소자공정연구원, 차세대메모리반도체소자공정연구원","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002134:1', '{"dJobCd":"K000002134","dJobCdSeq":"1","dJobNm":"메모리반도체소자연구원","workSum":"PC, 휴대폰 및 서버 용도의 DRAM, 데이터 저장 응용 Flash, PRAM, MRAM 등 차세대 메모리, SRAM 등 각종 메모리반도체 설계를 지원하고, 전기적 관점에서 연구·개발한다.","doWork":"각종 응용제품별 회로설계연구원과 함께 고객이 요구하는 소자회로 성능사양에 적합한 회로설계를 지원한다. 제품별 소자회로의 전기적 특성목표를 사진현상, 식각, 확산 및 박막 등 단위공정연구원에게 제안한다. 메모리반도체소자의 특성평가, 실장평가, 환경시험, 수명시험, 내성시험과 같은 불량분석업무를 통해 제품 신뢰도를 검사한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체소자연구원","connectJob":"DRAM소자연구원, Flash소자연구원, SRAM소자연구원, 차세대메모리반도체소자연구원","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002132:1', '{"dJobCd":"K000002132","dJobCdSeq":"1","dJobNm":"메모리반도체제조기술자","workSum":"DRAM, Flash, SRAM, PRAM, MRAM 등 메모리반도체 제조를 위한 생산관리, 제조공정, 시설·장비운영, 검사, 불량분석 및 문제해결 등의 업무를 지원·관리한다.","doWork":"PC, 노트북, 모바일 및 서버에 사용되는 DRAM소자, 디지털기기 저장매체로 사용되는 ROM 및 Flash소자, FeRAM, PRAM, MRAM 및 ReRAM 등 이머징 메모리소자, SRAM 등 메모리반도체의 소자기술, 제조공정, 생산장비, 품질검사 및 관리지식을 활용하여 메모리반도체 생산 관련 직무전체를 총괄, 지원 및 관리한다. 메모리반도체 공정기술자, 장비기술자, 제조원과 공동으로 생산, 검사 및 품질관리업무를 수행한다. 메모리반도체 소자 품질수율 및 생산성 향상을 위해 사진현상, 식각, 확산, 박막, 세정, 연마, 조립 및 검사공정·장비기술자와 공동으로 문제점 도출, 원인분석, 개선작업을 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"메모리반도체기술자","connectJob":"메모리반도체공정기술자, 메모리반도체장비기술자, 메모리반도체제조반장 등","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005188:1', '{"dJobCd":"K000005188","dJobCdSeq":"1","dJobNm":"반도체계측검사공정기술자","workSum":"반도체 품질수율 및 생산성 향상을 위해 소자제조 및 장비기술자와 협의하여 계측검사 공정기술을 평가·개선·인증·유지 관리한다.","doWork":"반도체소자 제조, 공정, 장비기술자와 협력하여 계측검사공정 목표를 정의하고, 반도체소자 생산기술에 응용한다. 계측검사 관련 부품, 시설, 장치, 장비, 공정기술지식을 기반으로 제조, 공정, 장비기술자와 협력하여 단위공정 검사방법을 결정·검증·개선·유지 관리한다. 계측검사 관련 핵심부품, 장비를 설치·평가·개선·인증, 생산·유지 관리하며, 모든 정보 및 기술을 문서화하여 공유한다. 국내외 계측검사 관련 부품·장비업체로부터 획득한 정보 및 제품을 정기적으로 시험평가·인증·응용하여 원가절감 및 개조개선활동을 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체공정기술자","connectJob":"반도체MI공정기술자","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004927:1', '{"dJobCd":"K000004927","dJobCdSeq":"1","dJobNm":"반도체계측검사공정연구원","workSum":"반도체 기술로드맵 및 고객 요구성능을 이해·응용하여 소자공정연구원과 함께 차세대 소자배선구조의 단위공정 특성검증을 위한 계측검사공정을 연구·개발한다.","doWork":"반도체소자공정연구원과 공동으로 단위공정 목표수립을 지원하고, 관련 계측검사 연구·개발활동을 수행한다. 소자공정연구원을 중심으로 사진현상, 식각, 이온주입, 박막, 확산, 세정 및 연마공정연구원과 긴밀한 공동연구를 통해 최적의 계측검사 공정특성을 보유한 소자회로 배선구조 및 특성개발을 지원한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 계측검사 공정 및 장비기술을 시험평가하고, 최적화하는 연구·개발활동을 단독 또는 공동으로 수행한다. 계측검사 공정개발과정에는 반도체 생산라인 이관 시 최고의 품질 및 생산성을 고려한 공정 및 장비기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체공정연구원","connectJob":"반도체MI공정연구원","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005600:1', '{"dJobCd":"K000005600","dJobCdSeq":"1","dJobNm":"반도체계측검사장비공정연구원","workSum":"반도체 기술로드맵 및 고객 요구성능을 이해하고, 기구, 광학 및 소프트웨어설계연구원과 함께 계측검사장비를 기획, 기초 및 생산 성능평가를 수행하여 최적의 공정·장비기술을 개발한다.","doWork":"반도체장비 기구, 소프트웨어 및 광학설계연구원과 함께 이송, 광학측정 모듈 각각의 목표성능을 정의하고, 전체 및 세부구성을 기획한다. 시험장비의 설치 후, 핵심요소기술 중심으로 단독 또는 종합적으로 기초 공정성능평가를 진행한다. 기초평가를 통해 개선이 필요한 부품 및 장치를 선정하여 담당기구 및 광학설계연구원에게 신규부품 및 장치개발을 요청한다. 이러한 과정을 반복 진행하여 고객이 요구하는 공정·장비성능목표를 만족하는 계측검사장비를 개발한다. 계측검사장비의 기획, 제작 및 시험평가결과를 고객과 지속·공유하여 고객사 생산라인에서 공정 및 장비 신뢰성 평가계약을 유도한다. 고객과 계약에 따라 종합품질 및 생산성 검증평가를 실시하여 계측검사장비 인증을 획득한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 광학 관련 부품, 장치, 장비 및 공정기술을 시험평가하고, 최적화하는 연구·개발활동을 단독 또는 공동으로 수행한다. 계측검사장비 개발과정에는 경쟁사 대비 비교우위, 반도체 생산라인 기준공정 및 장비 신뢰성 목표달성을 고려한 부품, 장치, 장비 및 공정기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체공정연구원","connectJob":"DEFECT검출장비공정연구원, 금속불순물검출장비공정연구원, SEM장비공정연구원, TEM장비공정연구원 등","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002412:1', '{"dJobCd":"K000002412","dJobCdSeq":"1","dJobNm":"반도체계측검사장비부분품연구원","workSum":"반도체 기술로드맵 및 고객 요구성능을 이해하고, 계측검사장비에 필요한 부분품을 설계, 기초 및 양산평가를 수행하여 최적의 부분품을 연구·개발한다.","doWork":"반도체 계측검사장비의 기구설계, 광학설계, 소프트웨어설계 및 공정연구원과 공동으로 구상한 기초설계를 기준으로 부분품 기능을 정의하고, 상세사양을 결정한 다음, 최적의 재료, 부품 등을 선정한다. 상세사양 기준으로 선정된 재료, 부품들 중에서 유체, 진동, 열 및 광 역학 해석이 필요한 부품들을 분류하고, 각 부품 특성에 적합한 해석프로그램을 선정하여 실행한다. 각 부품별 해석결과를 바탕으로 부품 적합성 여부를 판단하며, 부품 재선정 및 해석작업을 반복하여 최종 부분품 사양을 결정한다. 최종 사양을 기준으로 계측검사장비의 기구 및 유틸리티를 고려한 상세설계를 진행하여 도면을 작성한다. 부분품의 조립, 시험성능평가 및 장비회사 현장평가를 통해 발견되는 기구설계 오류 분석으로 부분품 설계개선을 지원한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 다양한 재료, 부품기술을 시험평가하고, 최적화하는 연구·개발활동을 단독 또는 공동으로 수행한다. 반도체계측검사장비의 부분품 개발과정에는 부품 조립의 편이성, 제조원가 절감, 공정 및 장비 신뢰성을 보증하는 재료, 부품기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체부품연구원","connectJob":"DEFECT검출장비부분품연구원, 금속불순물검출장비부분품연구원, SEM장비부분품연구원, TEM장비부분품연구원 등","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005106:1', '{"dJobCd":"K000005106","dJobCdSeq":"1","dJobNm":"반도체금속막증착공정기술자","workSum":"반도체 품질수율 및 생산성 향상을 위해 소자제조 및 장비기술자와 협의하여 금속막증착 공정기술을 평가·개선·인증·유지 관리한다.","doWork":"반도체소자 제조, 공정, 장비기술자와 협력하여 금속막증착공정 목표를 정의하고, 반도체소자 생산기술에 응용한다. 금속막증착 관련 소재, 부품, 시설, 장치, 장비, 공정 기술지식을 기반으로 제조, 공정, 장비기술자와 협력하여 제품생산 순서도를 결정·검증·개선·유지 관리한다. 금속막증착 관련 핵심소재, 부품, 장비를 설치·평가·개선·인증·생산·유지 관리하며, 모든 정보 및 기술을 문서화하여 공유한다. 국내외 금속막증착 관련 소재·부품·장비업체로부터 획득한 정보 및 제품을 정기적으로 시험평가·인증·응용하여 원가절감 및 개조개선활동을 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체 공정기술자","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005211:1', '{"dJobCd":"K000005211","dJobCdSeq":"1","dJobNm":"반도체금속막증착공정연구원","workSum":"반도체 기술로드맵 및 고객 요구성능을 이해·응용하여 소자공정연구원과 함께 차세대 소자배선구조 형성을 위한 금속막증착공정을 연구·개발한다.","doWork":"반도체소자공정연구원과 공동으로 금속막증착공정 목표를 수립하고, 관련 연구·개발활동을 수행한다. 소자공정연구원을 중심으로 사진현상, 식각, 이온주입, 확산, 세정 및 연마공정연구원과 긴밀한 공동연구를 통해 최적의 금속막증착 공정특성을 보유한 소자회로 배선구조 및 특성을 개발한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 다양한 소재, 부품, 공정 및 장비 기술을 시험평가하고, 최적화하는 연구·개발활동을 단독 또는 공동으로 수행한다. 금속막증착 공정개발과정에는 반도체 생산라인 이관 시 최고의 품질 및 생산성을 고려한 소재, 부품, 공정 및 장비기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체공정연구원","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004296:1', '{"dJobCd":"K000004296","dJobCdSeq":"1","dJobNm":"반도체금속막증착장비공정연구원","workSum":"반도체 기술로드맵 및 고객 요구성능을 이해하고, 기구 및 소프트웨어설계연구원과 함께 금속막증착장비를 기획, 기초 및 생산 성능평가를 수행하여 최적의 공정·장비기술을 개발한다.","doWork":"반도체장비 기구·소프트웨어설계연구원과 함께 이송, 공정, 냉각모듈 각각의 목표성능을 정의하고, 전체 및 세부구성을 기획한다. 시험장비의 설치 후, 핵심요소기술 중심으로 단독 또는 종합적으로 기초 공정성능평가를 진행한다. 기초평가를 통해 개선이 필요한 부품 및 장치를 선정하여 담당 기구설계연구원에게 신규부품 및 장치개발을 요청한다. 이러한 과정을 반복 진행하여 고객이 요구하는 공정·장비성능목표를 만족하는 금속막증착장비를 개발한다. 금속막증착장비의 기획, 제작 및 시험평가결과를 고객과 지속·공유하여 고객사 생산라인에서 공정 및 장비 신뢰성 평가계약을 유도한다. 고객과 계약에 따라 종합품질 및 생산성 검증평가를 실시하여 금속막증착장비 인증을 획득한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 다양한 재료, 부품, 장치, 장비 및 공정기술을 시험평가하고, 최적화하는 연구·개발활동을 단독 또는 공동으로 수행한다. 금속막증착장비 개발과정에는 경쟁사 대비 비교우위, 반도체 생산라인 기준 공정 및 장비 신뢰성 목표달성을 고려한 재료, 부품, 장치, 장비 및 공정기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체공정연구원","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002154:1', '{"dJobCd":"K000002154","dJobCdSeq":"1","dJobNm":"반도체금속막증착장비부분품연구원","workSum":"반도체 기술로드맵 및 고객 요구성능을 이해하고, 금속막증착장비에 필요한 부분품을 설계, 기초 및 양산평가를 수행하여 최적의 부분품을 연구·개발한다.","doWork":"반도체 금속막증착장비의 기구설계, 소프트웨어설계 및 공정연구원과 공동으로 구상한 기초설계를 기준으로 부분품 기능을 정의하고, 상세사양을 결정한 다음, 최적의 재료, 부품 등을 선정한다. 상세사양 기준으로 선정된 재료, 부품들 중에서 유체, 진동, 열 및 광 역학 해석이 필요한 부품들을 분류하고, 각 부품특성에 적합한 해석프로그램을 선정하여 실행한다. 각 부품별 해석결과를 바탕으로 부품 적합성 여부를 판단하며, 부품 재선정 및 해석작업을 반복하여 최종 부분품 사양을 결정한다. 최종 사양을 기준으로 금속막증착장비의 기구 및 유틸리티를 고려한 상세설계를 진행하여 도면을 작성한다. 부분품의 조립, 시험성능평가 및 장비회사 현장평가를 통해 발견되는 기구설계 오류 분석으로 부분품 설계개선을 지원한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 다양한 재료, 부품기술을 시험평가하고, 최적화하는 연구·개발활동을 단독 또는 공동으로 수행한다. 반도체금속막증착장비의 부분품 개발과정에는 부품조립의 편이성, 제조원가 절감, 공정 및 장비 신뢰성을 보증하는 재료, 부품기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체부품연구원","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005358:1', '{"dJobCd":"K000005358","dJobCdSeq":"1","dJobNm":"반도체디지털회로설계연구원","workSum":"반도체소자 기술로드맵 및 고객 요구성능을 이해하고, 코딩, 시뮬레이션, 합성, 검증, 포스트 시뮬레이션 해석을 수행하여 회로동작·특성을 확인·검증함으로써 디지털회로를 설계한다.","doWork":"반도체 기술규격에 따라 HDL(하드웨어 기술언어)을 사용하고, 기술규격의 기능에 따라 시스템과 호환되도록 입출력회로를 선정한다. 시뮬레이션 환경을 구축하여 시뮬레이션을 수행하고 그 결과를 규격서와 비교하며, 시뮬레이션 결과를 분석정보를 이용하여 HDL코드를 수정한다. 합성환경을 구축하고 합성툴을 이용하여 HDL코드를 게이트 수준의 네트리스트로 변환한다. 설계제약조건을 고려하여 위반 여부를 검사하고 설계검증을 위한 표준 지연시간 등의 물리적 특성을 추출한다. 시스템 설계의 계층화를 통해 설계의 복잡도 증가에 대응하고 반도체 설계의 생산성 향상을 유도한다. 레이아웃이 완료된 회로의 검증을 위한 시뮬레이션 환경을 구축하여 시뮬레이션을 수행한다. 시뮬레이션 결과를 분석하여 오류를 수정하고 설계에 반영한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 다양한 디지털 회로설계기술을 시험평가하고, 최적화하는 연구·개발활동을 단독 또는 공동으로 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체설계연구원, 메모리설계연구원, 시스템LSI설계연구원","connectJob":"전자회로설계사","certLic":"전자기사","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006349:1', '{"dJobCd":"K000006349","dJobCdSeq":"1","dJobNm":"반도체레이아웃설계기술자","workSum":"반도체소자 기술로드맵 및 고객 요구성능을 이해하고, 마스크제작 데이터를 확보하기 위해 반도체소자·기능블록을 배치·배선, 검증하여 반도체레이아웃을 설계한다.","doWork":"반도체 아날로그 블록 및 디지털 블록, 입·출력 패드에 대한 배치계획을 수립하고 신호배선, 전원배선에 대한 계획을 수립한다. 고객요구사항을 반영할 수 있도록 적합한 툴을 선정하여 레이아웃에 필요한 요소를 파악한다. 공정의 설계규칙에 따라 소자 레이아웃을 수행하고, 레이아웃상에서 기능 블록을 배치 및 배선한다. 반도체 공정의 설계 요구사항에 따라 자동배치배선을 위한 환경을 구축한다. 로직 블록들의 평면 배치계획을 하며, 로직셀들이 작동할 수 있도록 자동적으로 배치한다. 레이아웃 검증을 위해 적합한 툴을 선정하고 적용한다. 검증결과에 따라 발견된 오류에 대한 수정사항을 반영한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 다양한 레이아웃 설계기술을 시험평가하고, 최적화하는 연구·개발활동을 단독 또는 공동으로 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|언어력|시각|","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체설계연구원","certLic":"반도체설계산업기사","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003233:1', '{"dJobCd":"K000003233","dJobCdSeq":"1","dJobNm":"반도체사진현상공정기술자","workSum":"반도체 품질수율 및 생산성 향상을 위해 소자제조 및 장비기술자와 협의하여 사진현상 공정기술을 평가·개선·인증·유지 관리한다.","doWork":"반도체소자 제조, 공정, 장비기술자와 협력하여 사진현상공정 목표를 정의하고, 반도체소자 생산기술에 응용한다. 사진현상 관련 소재, 부품, 시설, 장치, 장비, 공정기술지식을 기반으로 제조, 공정, 장비기술자와 협력하여 제품생산순서도를 결정·검증·개선·유지 관리한다. 사진현상 관련 핵심 소재, 부품, 장비를 설치·평가·개선·인증·생산·유지 관리하며, 모든 정보 및 기술을 문서화하여 공유한다. 국내외 사진현상기술 관련 소재·부품·장비업체로부터 획득한 정보 및 제품을 정기적으로 시험평가·인증·응용하여 원가절감 및 개조개선활동을 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체공정기술자","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006278:1', '{"dJobCd":"K000006278","dJobCdSeq":"1","dJobNm":"반도체사진현상공정연구원","workSum":"반도체 기술로드맵 및 고객 요구성능을 이해·응용하여 소자공정연구원과 함께 Photo Mask 제조공정 및 소자배선구조에 적합한 차세대 사진현상공정을 연구·개발한다.","doWork":"반도체소자공정연구원과 함께 사진현상공정 목표를 수립하고, 관련 연구·개발활동을 수행한다. 소자공정연구원을 중심으로 식각, 이온주입, 확산, 박막, 세정 및 연마공정연구원과 긴밀한 공동연구를 통해 최적의 사진현상 공정특성을 보유한 소자회로 배선구조 및 특성을 개발한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 다양한 소재, 부품, 공정 및 장비기술을 시험평가하고, 최적화하는 연구·개발활동을 단독 또는 공동으로 수행한다. 사진현상 공정개발과정에는 반도체 생산라인 이관 시 최고의 품질 및 생산성을 고려한 소재, 부품, 공정 및 장비기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체공정연구원","connectJob":"반도체포토공정연구원","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003512:1', '{"dJobCd":"K000003512","dJobCdSeq":"1","dJobNm":"반도체사진현상장비공정연구원","workSum":"반도체 기술로드맵 및 고객 요구성능을 이해하고, 기구 및 소프트웨어설계연구원과 함께 사진현상장비를 기획, 기초 및 생산 성능평가를 수행하여 최적의 공정·장비기술을 개발한다.","doWork":"반도체장비 기구·소프트웨어설계연구원과 함께 PR 코팅, 노광, 현상 장치부 각각의 목표성능을 정의하고, 전체 및 세부구성을 기획한다. 시험장비의 설치 후, 핵심요소기술 중심으로 단독 또는 종합적으로 기초 공정성능평가를 진행한다. 기초평가를 통해 개선이 필요한 부품 및 장치를 선정하여 담당 기구설계연구원에게 신규부품 및 장치개발을 요청한다. 이러한 과정을 반복 진행하여 고객이 요구하는 공정·장비성능목표를 만족하는 사진현상장비를 개발한다. 사진현상장비의 기획, 제작 및 시험평가결과를 고객과 지속·공유하여 고객사 생산라인에서 공정 및 장비 신뢰성 평가계약을 유도한다. 고객과 계약에 따라 종합품질 및 생산성 검증평가를 실시하여 사진현상장비 인증을 획득한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 다양한 재료, 부품, 장치, 장비 및 공정기술을 시험평가하고, 최적화하는 연구·개발활동을 단독 또는 공동으로 수행한다. 사진현상장비 개발과정에는 경쟁사 대비 비교우위, 반도체 생산라인 기준 공정 및 장비 신뢰성 목표달성을 고려한 재료, 부품, 장치, 장비 및 공정기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체공정연구원","connectJob":"반도체포토장비공정연구원","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007228:1', '{"dJobCd":"K000007228","dJobCdSeq":"1","dJobNm":"반도체사진현상장비부분품연구원","workSum":"반도체 기술로드맵 및 고객 요구성능을 이해하고, 사진현상장비에 필요한 부분품을 설계, 기초 및 양산평가를 수행하여 최적의 부분품을 연구·개발한다.","doWork":"반도체 사진현상장비의 기구설계, 소프트웨어설계 및 공정연구원과 공동으로 구상한 기초설계를 기준으로 부분품 기능을 정의하고, 상세사양을 결정한 다음, 최적의 재료, 부품 등을 선정한다. 상세사양 기준으로 선정된 재료, 부품들 중에서 유체, 진동, 열 및 광 역학 해석이 필요한 부품들을 분류하고, 각 부품 특성에 적합한 해석프로그램을 선정하여 실행한다. 각 부품별 해석결과를 바탕으로 부품 적합성 여부를 판단하며, 부품 재선정 및 해석작업을 반복하여 최종 부분품 사양을 결정한다. 최종 사양을 기준으로 사진현상장비의 기구 및 유틸리티를 고려한 상세 설계를 진행하여 도면을 작성한다. 부분품의 조립, 시험성능평가 및 장비회사 현장평가를 통해 발견되는 기구설계 오류 분석으로 부분품 설계개선을 지원한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 다양한 재료, 부품기술을 시험평가하고, 최적화하는 연구·개발활동을 단독 또는 공동으로 수행한다. 반도체사진현상장비의 부분품 개발과정에는 부품 조립의 편이성, 제조원가 절감, 공정 및 장비 신뢰성을 보증하는 재료, 부품기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체부품연구원","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004019:1', '{"dJobCd":"K000004019","dJobCdSeq":"1","dJobNm":"반도체세정공정기술자","workSum":"반도체 품질수율 및 생산성 향상을 위해 소자제조 및 장비기술자와 협의하여 세정 공정기술을 평가·개선·인증·유지 관리한다.","doWork":"반도체소자 제조, 공정, 장비기술자와와 협력하여 세정공정 목표를 정의하고, 반도체소자 생산기술에 응용한다. 세정 관련 소재, 부품, 시설, 장치, 장비, 공정기술지식을 기반으로 제조, 공정, 장비기술자와와 협력하여 제품생산순서도를 결정·검증·개선·유지 관리한다. 세정 관련 핵심 소재, 부품, 장비를 설치·평가·개선·인증·생산·유지 관리하며, 모든 정보 및 기술을 문서화하여 공유한다. 국내외 세정 관련 소재·부품·장비업체로부터 획득한 정보 및 제품을 정기적으로 시험평가·인증·응용하여 원가절감 및 개조개선활동을 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체공정기술자","connectJob":"반도체Cleaning공정기술자","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004030:1', '{"dJobCd":"K000004030","dJobCdSeq":"1","dJobNm":"반도체세정공정연구원","workSum":"반도체 기술로드맵 및 고객 요구성능을 이해·응용하여 소자공정연구원과 함께 차세대 소자배선구조 형성을 위한 세정공정을 연구·개발한다.","doWork":"반도체소자공정연구원과 공동으로 세정공정 목표를 수립하고, 관련 연구·개발활동을 수행한다. 소자공정연구원을 중심으로 사진현상, 식각, 이온주입, 박막, 확산 및 연마공정연구원과 긴밀한 공동연구를 통해 최적의 세정 공정특성을 보유한 소자회로 배선구조 및 특성을 개발한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 다양한 소재, 부품, 공정 및 장비기술을 시험평가하고, 최적화하는 연구·개발활동을 단독 또는 공동으로 수행한다. 세정 공정개발과정에는 반도체 생산라인 이관 시 최고의 품질 및 생산성을 고려한 소재, 부품, 공정 및 장비기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체공정연구원","connectJob":"반도체Cleaning공정연구원","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003748:1', '{"dJobCd":"K000003748","dJobCdSeq":"1","dJobNm":"반도체세정장비공정연구원","workSum":"반도체 기술로드맵 및 고객 요구성능을 이해하고, 기구 및 소프트웨어설계연구원과 함께 세정장비를 기획, 기초 및 생산 성능평가를 수행하여 최적의 공정·장비기술을 개발한다.","doWork":"반도체장비 기구·소프트웨어설계연구원과 함께 Chemical, 공정 Bath 또는 Chamber, 초순수 Bath, IPA Bath 각각의 목표성능을 정의하고, 전체 및 세부구성을 기획한다. 시험장비의 설치 후, 핵심요소기술 중심으로 단독 또는 종합적으로 기초 공정성능평가를 진행한다. 기초평가를 통해 개선이 필요한 부품 및 장치를 선정하여 담당 기구설계연구원에게 신규부품 및 장치개발을 요청한다. 이러한 과정을 반복 진행하여 고객이 요구하는 공정·장비성능목표를 만족하는 세정장비를 개발한다. 세정장비의 기획, 제작 및 시험평가결과를 고객과 지속·공유하여 고객사 생산라인에서 공정 및 장비 신뢰성 평가계약을 유도한다. 고객과 계약에 따라 종합품질 및 생산성 검증평가를 실시하여 세정장비 인증을 획득한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 다양한 재료, 부품, 장치, 장비 및 공정기술을 시험평가하고, 최적화하는 연구·개발활동을 단독 또는 공동으로 수행한다. 세정장비 개발과정에는 경쟁사 대비 비교우위, 반도체 생산라인 기준 공정 및 장비 신뢰성 목표달성을 고려한 재료, 부품, 장치, 장비 및 공정기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체공정연구원","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003362:1', '{"dJobCd":"K000003362","dJobCdSeq":"1","dJobNm":"반도체세정장비부분품연구원","workSum":"반도체 기술로드맵 및 고객 요구성능을 이해하고, 세정장비에 필요한 부분품을 설계, 기초 및 양산평가를 수행하여 최적의 부분품을 연구·개발한다.","doWork":"반도체 세정장비의 기구설계, 소프트웨어설계 및 공정연구원과 공동으로 구상한 기초설계를 기준으로 부분품 기능을 정의하고, 상세사양을 결정한 다음, 최적의 재료, 부품 등을 선정한다. 상세사양 기준으로 선정된 재료, 부품들 중에서 유체, 진동, 열 역학 해석이 필요한 부품들을 분류하고, 각 부품특성에 적합한 해석프로그램을 선정하여 실행한다. 각 부품별 해석결과를 바탕으로 부품 적합성 여부를 판단하며, 부품 재선정 및 해석작업을 반복하여 최종 부분품 사양을 결정한다. 최종 사양을 기준으로 세정장비의 기구 및 유틸리티를 고려한 상세설계를 진행하여 도면을 작성한다. 부분품의 조립, 시험성능평가 및 장비회사 현장평가를 통해 발견되는 기구설계 오류 분석으로 부분품 설계개선을 지원한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 다양한 재료, 부품기술을 시험평가하고, 최적화하는 연구·개발활동을 단독 또는 공동으로 수행한다. 반도체세정장비의 부분품 개발과정에는 부품조립의 편이성, 제조원가 절감, 공정 및 장비 신뢰성을 보증하는 재료, 부품기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체부품연구원","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006395:1', '{"dJobCd":"K000006395","dJobCdSeq":"1","dJobNm":"반도체소자웨이퍼검사공정기술자","workSum":"반도체소자웨이퍼의 품질수율 및 생산성 향상을 위해 검사기술자와 협의하여 소자웨이퍼의 전기적 특성을 평가·개선·인증·유지 관리한다.","doWork":"반도체소자 특성, 품질수율 및 생산성 향상을 위해 소자품질, 프로브설계, 검사프로그램, 장비기술자와 협력하여 소자웨이퍼검사공정 목표를 정의하고, 반도체 검사기술에 응용한다. 소자웨이퍼검사 관련 프로브, 검사프로그램, 장비 기술지식을 기반으로 소자품질, 프로브설계, 검사프로그램, 검사장비기술자와 협력하여 소자웨이퍼의 전기적 특성검사 순서도를 결정·검증·개선·유지 관리한다. 소자웨이퍼검사 관련 프로브, 검사프로그램, 장비를 설치·평가·개선·인증·유지 관리하며, 모든 정보 및 기술을 문서화하여 공유한다. 국내외 소자웨이퍼검사 관련 프로브·검사프로그램·장비업체로부터 획득한 정보 및 제품을 정기적으로 시험평가·인증·응용하여 원가절감 및 개조개선활동을 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체검사기술자","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004485:1', '{"dJobCd":"K000004485","dJobCdSeq":"1","dJobNm":"반도체소자웨이퍼검사공정연구원","workSum":"반도체 검사기술로드맵 및 고객 요구성능을 이해·응용하여 소자공정연구원과 함께 최적의 소자웨이퍼검사 공정을 연구·개발하여 반도체 검사기술개발을 지원한다.","doWork":"반도체소자공정연구원과 공동으로 소자웨이퍼감사 공정목표를 수립하고, 관련 연구·개발활동을 수행한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 다양한 소자웨이퍼검사 부품, 공정 및 장비기술을 시험평가하고, 최적화하는 연구·개발활동을 단독 또는 공동으로 수행한다. 소자웨이퍼검사 공정개발과정에는 반도체 검사라인 이관 시 최고의 품질 및 생산성을 고려한 부품, 공정 및 장비기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체검사연구원","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004370:1', '{"dJobCd":"K000004370","dJobCdSeq":"1","dJobNm":"반도체소자웨이퍼검사장비공정연구원","workSum":"반도체 검사기술로드맵 및 고객 요구성능을 이해하고, 기구, 회로설계연구원과 함께 소자웨이퍼검사장비를 기획, 기초 및 생산 성능평가를 수행하여 최적의 공정·장비기술을 개발한다.","doWork":"반도체장비기구 및 소자회로설계연구원과 함께 이송, 검사 모듈 각각의 목표성능을 정의하고, 전체 및 세부구성을 기획한다. 시험장비의 설치 후, 핵심요소기술 중심으로 단독 또는 종합적으로 기초 공정성능평가를 진행한다. 기초평가를 통해 개선이 필요한 부품 및 장치를 선정하여 담당 기구 및 회로설계연구원에게 신규부품 및 장치개발을 요청한다. 이러한 과정을 반복 진행하여 고객이 요구하는 공정·장비성능목표를 만족하는 소자웨이퍼검사장비를 개발한다. 소자웨이퍼검사장비의 기획, 제작 및 시험평가결과를 고객과 지속·공유하여 고객사 생산라인에서 공정 및 장비 신뢰성 평가계약을 유도한다. 고객과 계약에 따라 종합품질 및 생산성 검증평가를 실시하여 소자웨이퍼검사장비 인증을 획득한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 다양한 사양의 프로브 카드, 핸들러, 주검사기 및 공정기술을 시험평가하고, 최적화하는 연구·개발활동을 단독 또는 공동으로 수행한다. 소자웨이퍼검사장비 개발과정에는 경쟁사 대비 비교우위, 반도체 생산라인 기준 공정 및 장비 신뢰성 목표달성을 고려한 부품, 장치, 장비 및 공정기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체공정연구원","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005046:1', '{"dJobCd":"K000005046","dJobCdSeq":"1","dJobNm":"반도체소자웨이퍼검사장비부분품연구원","workSum":"반도체 검사기술로드맵 및 고객 요구성능을 이해하고, 소자웨이퍼검사장비에 필요한 부분품을 설계, 기초 및 양산평가를 수행하여 최적의 부분품을 연구·개발한다.","doWork":"반도체 소자웨이퍼검사장비의 기구설계, 회로설계 및 공정연구원과 공동으로 구상한 기초설계를 기준으로 부분품 기능을 정의하고, 상세사양을 결정한 다음, 최적의 재료, 부품 등을 선정한다. 상세사양 기준으로 선정된 재료, 부품들 중에서 유체, 진동 및 열 역학 해석이 필요한 부품들을 분류하고, 각 부품특성에 적합한 해석프로그램을 선정하여 실행한다. 각 부품별 해석결과를 바탕으로 부품 적합성 여부를 판단하며, 부품 재선정 및 해석작업을 반복하여 최종 부분품 사양을 결정한다. 최종 사양을 기준으로 소자웨이퍼검사장비의 기구 및 유틸리티를 고려한 상세설계를 진행하여 도면을 작성한다. 부분품의 조립, 시험성능평가 및 장비회사 현장평가를 통해 발견되는 기구설계 오류 분석으로 부분품 설계개선을 지원한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 다양한 재료, 부품기술을 시험평가하고, 최적화하는 연구·개발활동을 단독 또는 공동으로 수행한다. 소자웨이퍼검사장비의 부분품 개발과정에는 부품 조립의 편이성, 제조원가 절감, 공정 및 장비 신뢰성을 보증하는 재료, 부품기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체부품연구원","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002121:1', '{"dJobCd":"K000002121","dJobCdSeq":"1","dJobNm":"반도체소자패키지검사공정기술자","workSum":"반도체소자패키지의 품질수율 및 생산성 향상을 위해 검사기술자와 협의하여 소자패키지의 전기적 특성을 평가·개선·인증·유지 관리한다.","doWork":"반도체소자 특성, 품질수율 및 생산성 향상을 위해 소자품질, 보드설계, 검사프로그램, 장비기술자와 협력하여 소자패키지검사공정 목표를 정의하고, 반도체 검사기술에 응용한다. 소자패키지검사 관련 소켓, 보드, 검사프로그램, 장비 기술지식을 기반으로 소자품질, 보드설계, 검사프로그램, 검사장비기술자와 협력하여 소자패키지의 전기적 특성검사 순서도를 결정·검증·개선·유지 관리한다. 소자패키지검사 관련 보드, 검사프로그램, 장비를 설치·평가·개선·인증·유지 관리하며 모든 정보 및 기술을 문서화하여 공유한다. 국내외 소자패키지검사 관련 보드·검사프로그램·장비업체로부터 획득한 정보 및 제품을 정기적으로 시험평가·인증·응용하여 원가절감 및 개조개선활동을 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체검사기술자","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005342:1', '{"dJobCd":"K000005342","dJobCdSeq":"1","dJobNm":"반도체소자패키지검사공정연구원","workSum":"반도체 검사기술로드맵 및 고객 요구성능을 이해·응용하여 소자공정연구원과 함께 최적의 소자패키지검사 공정을 연구·개발하여 반도체 검사기술개발을 지원한다.","doWork":"반도체소자공정연구원과 공동으로 소자패키지감사 공정목표를 수립하고, 관련 연구·개발활동을 수행한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 다양한 소자패키지검사 부품, 공정 및 장비기술을 시험평가하고, 최적화하는 연구·개발활동을 단독 또는 공동으로 수행한다. 소자패키지검사 공정개발과정에는 반도체 검사라인 이관 시 최고의 품질 및 생산성을 고려한 부품, 공정 및 장비기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체검사연구원","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004419:1', '{"dJobCd":"K000004419","dJobCdSeq":"1","dJobNm":"반도체소자패키지검사장비공정연구원","workSum":"반도체 검사기술로드맵 및 고객 요구성능을 이해하고, 기구, 보드설계연구원과 함께 소자패키지검사장비를 기획, 기초 및 생산 성능평가를 수행하여 최적의 공정·장비기술을 개발한다.","doWork":"반도체장비 기구 및 보드설계연구원과 함께 이송, 검사 모듈 각각의 목표성능을 정의하고, 전체 및 세부구성을 기획한다. 시험장비의 설치 후, 핵심요소기술 중심으로 단독 또는 종합적으로 기초 공정성능평가를 진행한다. 기초평가를 통해 개선이 필요한 부품 및 장치를 선정하여 담당 기구 및 보드설계연구원에게 신규부품 및 장치개발을 요청한다. 이러한 과정을 반복 진행하여 고객이 요구하는 공정·장비성능목표를 만족하는 소자패키지검사장비를 개발한다. 소자패키지검사장비의 기획, 제작 및 시험평가 결과를 고객과 지속·공유하여 고객사 생산라인에서 공정 및 장비 신뢰성 평가계약을 유도한다. 고객과 계약에 따라 종합품질 및 생산성 검증평가를 실시하여 소자패키지검사장비 인증을 획득한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 다양한 사양의 소켓, 보드, 핸들러, 주검사기 및 공정기술을 시험평가하고, 최적화하는 연구·개발활동을 단독 또는 공동으로 수행한다. 소자패키지검사장비 개발과정에는 경쟁사 대비 비교우위, 반도체 생산라인 기준 공정 및 장비 신뢰성 목표달성을 고려한 부품, 장치, 장비 및 공정기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체공정연구원","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002695:1', '{"dJobCd":"K000002695","dJobCdSeq":"1","dJobNm":"반도체소자패키지검사장비부분품연구원","workSum":"반도체 검사기술로드맵 및 고객 요구성능을 이해하고, 소자패키지검사장비에 필요한 부분품을 설계, 기초 및 양산평가를 수행하여 최적의 부분품을 연구·개발한다.","doWork":"반도체소자 패키지검사장비의 기구설계, 회로설계 및 공정연구원과 공동으로 구상한 기초설계를 기준으로 부분품 기능을 정의하고, 상세사양을 결정한 다음, 최적의 재료, 부품 등을 선정한다. 상세사양 기준으로 선정된 재료, 부품들 중에서 유체, 진동 및 열 역학 해석이 필요한 부품들을 분류하고, 각 부품특성에 적합한 해석프로그램을 선정하여 실행한다. 각 부품별 해석결과를 바탕으로 부품 적합성 여부를 판단하며, 부품 재선정 및 해석작업을 반복하여 최종 부분품 사양을 결정한다. 최종 사양을 기준으로 소자패키지검사장비의 기구 및 유틸리티를 고려한 상세설계를 진행하여 도면을 작성한다. 부분품의 조립, 시험성능평가 및 장비회사 현장평가를 통해 발견되는 기구설계 오류분석으로 부분품 설계개선을 지원한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 다양한 재료, 부품기술을 시험평가하고, 최적화하는 연구·개발활동을 단독 또는 공동으로 수행한다. 소자패키지검사장비의 부분품 개발과정에는 부품 조립의 편이성, 제조원가 절감, 공정 및 장비 신뢰성을 보증하는 재료, 부품기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체부품연구원","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002672:1', '{"dJobCd":"K000002672","dJobCdSeq":"1","dJobNm":"반도체소자품질공정기술자","workSum":"반도체소자 신뢰성 향상을 위해 검사기술자와 협의하여 소자패키지의 환경, 수명, 전기적 특성 등 신뢰성 기술을 평가·개선·인증·유지 관리한다.","doWork":"반도체소자가 가지는 수명 예측, 동작조건 및 사용 환경 관련 규격을 만족하는지를 판단하기 위해 시험평가 프로그램, 장비기술자와 헙력하여 전기적 및 물리적 시험평가방법을 결정·검증·개선·유지 관리한다. 물리적 환경시험인 고온, 고습, 고압, 온도 사이클, 열 충격 시험을 수행하고, 수명 가속 시험평가를 위한 고온, 고전압 동작시험을 수행한다. ESD(EMS), EMI 유형별 메커니즘을 이해하고, 전기적 특성 시험평가를 수행하고, 각종 소자품질 시험결과가 국제규격표준, 전기적 특성, 고객 요구성능을 만족시키는지 를 판단한다. 소자품질검사 관련 시험평가 프로그램, 장비를 설치·평가·개선·인증·유지 관리하며, 모든 정보 및 기술을 문서화하여 공유한다. 국내외 소자품질검사 관련 시험평가 프로그램, 장비업체로부터 획득한 정보 및 제품을 정기적으로 평가·인증·응용하여 원가절감 및 개조개선활동을 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체품질기술자","connectJob":"반도체소자신뢰성평가기술자, 반도체소자성능검증기술자","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006146:1', '{"dJobCd":"K000006146","dJobCdSeq":"1","dJobNm":"반도체소자품질공정연구원","workSum":"반도체소자의 국제표준, 고객 요구성능을 이해하고, 환경, 수명, 전기적 특성시험 등 소자의 신뢰성 평가 공정기술을 연구·개발한다.","doWork":"반도체소자가 가지는 수명 예측기간, 동작조건 및 사용환경 관련 규격을 만족하는지를 판단하기 위한 전기적 가속 및 물리적 파괴시험 등의 평가기술을 연구·개발한다. 물리적 환경시험인 고온, 고습, 고압, 온도 사이클, 열 충격 시험 등에 대한 평가항목, 목적 및 방법을 정의하고, 수명가속 시험평가를 위한 고온, 고전압 동작시험 항목, 목적 및 방법을 정의하며, EMI, EMS(ESD) 유형별 메커니즘을 이해하고, 전기적 특성 시험평가 항목, 목적 및 방법을 정의한다. 각종 소자품질 시험결과가 국제규격표준, 전기적 특성, 고객 요구성능을 만족시키는지를 판단하고, 회로설계 오류분석을 통해 설계를 검증하여 개선을 지원하며, 또한 제조공정 불량분석을 통한 공정개선을 지원한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 다양한 소자품질 공정 및 장비기술을 시험평가하고, 최적화하는 연구·개발활동을 단독 또는 공동으로 수행한다. 소자품질 공정개발과정에는 반도체 검사라인 이관 시 최고의 품질 및 생산성을 고려한 공정 및 장비기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체품질연구원","connectJob":"반도체신뢰성평가공정연구원, 반도체소자성능검증공정연구원","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001647:1', '{"dJobCd":"K000001647","dJobCdSeq":"1","dJobNm":"반도체식각공정기술자","workSum":"반도체 품질수율 및 생산성 향상을 위해 소자제조 및 장비기술자와 협의하여 식각 공정기술을 평가·개선·인증·유지 관리한다.","doWork":"반도체소자 제조, 공정, 장비기술자와 협력하여 식각공정 목표를 정의하고, 반도체소자 생산기술에 응용한다. 식각 관련 소재, 부품, 시설, 장치, 장비, 공정 기술지식을 기반으로 제조, 공정, 장비기술자와 협력하여 제품생산 순서도를 결정·검증·개선·유지 관리한다. 식각 관련 핵심 소재, 부품, 장비를 설치·평가·개선·인증·생산·유지 관리하며, 모든 정보 및 기술을 문서화하여 공유한다. 국내외 식각기술 관련 소재·부품·장비업체로부터 획득한 정보 및 제품을 정기적으로 시험평가·인증·응용하여 원가절감 및 개조개선활동을 지원한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체공정기술자","connectJob":"반도체Ashing공정기술자","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003800:1', '{"dJobCd":"K000003800","dJobCdSeq":"1","dJobNm":"반도체식각공정연구원","workSum":"반도체 기술로드맵 및 고객 요구성능을 이해·응용하여 소자공정연구원과 함께 차세대 소자배선구조 형성을 위한 식각공정을 연구·개발한다.","doWork":"반도체소자공정연구원과 공동으로 식각공정 목표를 수립하고, 관련 연구·개발활동을 수행한다. 소자공정연구원을 중심으로 사진현상, 이온주입, 확산, 박막, 세정 및 연마 공정연구원과 긴밀한 공동 연구를 통해 최적의 식각 공정특성을 보유한 소자회로 배선구조 및 특성을 개발한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 다양한 소재, 부품, 공정 및 장비기술을 시험평가하고, 최적화하는 연구·개발활동을 단독 또는 공동으로 수행한다. 식각 공정개발과정에는 반도체 생산라인 이관 시 최고의 품질 및 생산성을 고려한 소재, 부품, 공정 및 장비기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체공정연구원","connectJob":"반도체Ashing공정연구원","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002653:1', '{"dJobCd":"K000002653","dJobCdSeq":"1","dJobNm":"반도체식각장비공정연구원","workSum":"반도체 기술로드맵 및 고객 요구성능을 이해하고, 기구 및 소프트웨어설계연구원과 함께 식각장비를 기획, 기초 및 생산 성능평가를 수행하여 최적의 공정·장비기술을 개발한다.","doWork":"반도체장비 기구·소프트웨어설계연구원과 함께 이송, 공정, 냉각부 각각의 목표성능을 정의하고, 전체 및 세부구성을 기획한다. 시험장비의 설치 후, 핵심요소기술 중심으로 단독 또는 종합적으로 기초 공정성능평가를 진행한다. 기초평가를 통해 개선이 필요한 부품 및 장치를 선정하여 담당 기구설계연구원에게 신규부품 및 장치개발을 요청한다. 이러한 과정을 반복 진행하여 고객이 요구하는 공정·장비성능목표를 만족하는 식각장비를 개발한다. 식각장비의 기획, 제작 및 시험평가 결과를 고객과 지속·공유하여 고객사 생산라인에서 공정 및 장비 신뢰성 평가계약을 유도한다. 고객과 계약에 따라 종합품질 및 생산성 검증평가를 실시하여 식각장비 인증을 획득한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 다양한 재료, 부품, 장치, 장비 및 공정기술을 시험평가하고, 최적화하는 연구·개발활동을 단독 또는 공동으로 수행한다. 식각장비 개발과정에는 경쟁사 대비 비교우위, 반도체 생산 기준 공정 및 장비 신뢰성 목표달성을 고려한 재료, 부품, 장치, 장비 및 공정기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체공정연구원","connectJob":"반도체Ashing공정연구원","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002061:1', '{"dJobCd":"K000002061","dJobCdSeq":"1","dJobNm":"반도체식각장비부분품연구원","workSum":"반도체 기술로드맵 및 고객 요구성능을 이해하고, 식각장비에 필요한 부분품을 설계, 기초 및 양산평가를 수행하여 최적의 부분품을 연구·개발한다.","doWork":"반도체 식각장비의 기구설계, 소프트웨어설계 및 공정연구원과 공동으로 구상한 기초설계를 기준으로 부분품 기능을 정의하고, 상세사양을 결정한 다음, 최적의 재료, 부품 등을 선정한다. 상세사양 기준으로 선정된 재료, 부품 중 유체, 진동, 열 및 광 역학 해석이 필요한 부품들을 분류하고, 각 부품특성에 적합한 해석프로그램을 선정하여 실행한다. 각 부품별 해석결과를 바탕으로 부품 적합성 여부를 판단하며, 부품 재선정 및 해석작업을 반복하여 최종 부분품 사양을 결정한다. 최종 사양을 기준으로 식각장비의 기구 및 유틸리티를 고려한 상세설계를 진행하여 도면을 작성한다. 부분품의 조립, 시험성능평가 및 장비회사 현장평가를 통해 발견되는 기구설계 오류분석으로 부분품 설계개선을 지원한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 다양한 재료, 부품기술을 시험평가하고, 최적화하는 연구·개발활동을 단독 또는 공동으로 수행한다. 반도체식각장비의 부분품 개발과정에는 부품 조립의 편이성, 제조원가 절감, 공정 및 장비 신뢰성을 보증하는 재료, 부품기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체부품연구원","connectJob":"반도체Ashing장비 부분품설계연구원","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004170:1', '{"dJobCd":"K000004170","dJobCdSeq":"1","dJobNm":"반도체아날로그회로설계연구원","workSum":"반도체소자 기술로드맵 및 고객 요구성능을 이해하고, 소자공정 및 패키지 특성을 분석하여 아날로그 회로를 구성, 검증, 측정작업을 통해 최적의 아날로그 회로를 설계한다.","doWork":"반도체 아날로그회로설계규격서에 따라 회로설계가 가능한 제조공정을 선정한다. 구현 칩의 시스템에 대한 이해를 통해 설계회로에 대한 적절한 기능 블록 단위로 표현한다. 각 세부 블록에 대해서 주어진 설계목표에 따라 기능 및 특성을 만족하는 회로를 구성한다. 시뮬레이션 툴을 이용하여 구성한 회로의 전기적 특성 및 기능, 성능을 검증하고 출력된 그래프 분석을 통해 구성 회로를 최적화한다. 개발 칩의 전기·기계적 특성을 고려하여 성능 열화가 없는 적합한 패키지를 선택한다. 레이아웃 배치에 따른 실재 구현 회로의 최적 상황을 고려하여 반도체레이아웃설계기술자와 협업을 하여 구현한 레이아웃 결과물로부터 추출한 물리적 특성을 반영하여 최종 시뮬레이션 분석을 수행한다. 시뮬레이션을 통해 최종 최적화한 설계결과물을 구현한다. 반도체 공정 및 패키지 공정을 통해 입수한 시제품의 측정 및 성능확인을 진행한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 다양한 아날로그 회로설계 기술을 시험평가하고, 최적화하는 연구·개발활동을 단독 또는 공동으로 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체설계연구원, 메모리설계연구원, 시스템LSI설계연구원","certLic":"전자 기사","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002016:1', '{"dJobCd":"K000002016","dJobCdSeq":"1","dJobNm":"반도체아키텍처설계연구원","workSum":"반도체소자 기술로드맵 및 고객 요구성능을 이해하고, 상위수준의 모델 분석으로 설계사양을 정의하고, 소자개발을 고려한 시스템 레벨 사양을 결정하여 반도체 아키텍처를 설계한다.","doWork":"반도체 아키텍처 전체 개발계획에서 각 단계별 설계내용을 작성하고, 개발단계별로 설계방법을 설정하며, 위험요소 예측 및 대응방안을 제시한다. 개발 부서별 또는 인원별 업무를 결정하고 개발계획 및 일정을 수립한다. 아키텍처 설계사양에 따라 반도체 제품의 전체 블록도와 제조공정을 결정하며, 설계 알고리즘 및 IP 확보방안을 결정한다. 설정된 아키텍처를 분석하여 장단점을 결정하며, 세부설계 블록 간 인터페이스를 결정한다. 기능 블록 설계 및 IP를 결정하며, 하드웨어로 설계하는 블록과 연계되는 소프트웨어 운영방법을 결정한다. 설계 검증에 필요한 검증 시스템을 결정하며, 구현기능에 따른 각 세부 블록 간의 동작 시나리오를 확정한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 다양한 아키텍처 설계기술을 시험평가하고, 최적화하는 연구·개발활동을 단독 또는 공동으로 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체설계연구원","certLic":"전자 기사","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003941:1', '{"dJobCd":"K000003941","dJobCdSeq":"1","dJobNm":"반도체연삭공정기술자","workSum":"반도체 품질수율 및 생산성 향상을 위해 조립 및 장비기술자와 협의하여 연삭 공정기술을 평가·개선·인증·유지 관리한다.","doWork":"반도체 조립, 장비기술자와 협력하여 연삭공정 목표를 정의하고, 반도체조립 생산기술에 응용한다. 연삭 관련 소재, 부품, 시설, 장치, 장비, 공정 기술지식을 기반으로 제품생산 순서도를 결정·검증·개선·유지 관리한다. 연삭 관련 핵심 소재, 부품, 장비를 설치·평가·개선·인증·생산·유지 관리하며, 모든 정보 및 기술을 문서화하여 공유한다. 국내외 연삭 관련 소재·부품·장비업체로부터 획득한 정보 및 제품을 정기적으로 시험평가·인증·응용하여 원가절감 및 개조개선활동을 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체공정기술자","connectJob":"반도체그라인딩공정기술자","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004430:1', '{"dJobCd":"K000004430","dJobCdSeq":"1","dJobNm":"반도체연삭공정연구원","workSum":"반도체 조립기술로드맵 및 고객 요구성능을 이해·응용하여 소자공정연구원과 함께 기판 두께조절을 위한 연삭공정을 연구·개발하여 차세대 반도체 조립기술개발을 지원한다.","doWork":"반도체 조립설계 및 소자공정연구원과 연삭공정 목표를 수립하고, 관련 연구·개발활동을 수행한다. 칩 절단, 접합, 본딩, 몰딩공정연구원과 긴밀한 협력을 통해 최적의 연삭 공정특성을 보유한 조립기술 및 소자를 개발한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 다양한 연삭 소재, 부품, 공정 및 장비기술을 시험평가하고, 최적화하는 연구·개발활동을 단독 또는 공동으로 수행한다. 연삭 공정개발과정에는 반도체 조립라인 이관 시 최고의 품질 및 생산성을 고려한 소재, 부품, 공정 및 장비기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체조립연구원","connectJob":"반도체백그라인딩 공정연구원","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005180:1', '{"dJobCd":"K000005180","dJobCdSeq":"1","dJobNm":"반도체연삭장비공정연구원","workSum":"반도체 조립기술로드맵 및 고객 요구성능을 이해하고, 기구 및 소프트웨어설계연구원과 함께 연삭장비를 기획, 기초 및 생산 성능평가를 수행하여 최적의 공정·장비기술을 개발한다.","doWork":"반도체장비 기구설계연구원과 함께 이송, 연삭, 후세정 모듈 각각의 목표성능을 정의하고, 전체 및 세부구성을 기획한다. 시험장비의 설치 후, 핵심요소기술 중심으로 단독 또는 종합적으로 기초 공정성능평가를 진행한다. 기초평가를 통해 개선이 필요한 부품 및 장치를 선정하여 담당 기구설계연구원에게 신규부품 및 장치개발을 요청한다. 이러한 과정을 반복 진행하여 고객이 요구하는 공정·장비성능목표를 만족하는 기판연삭장비를 개발한다. 기판연삭장비의 기획, 제작 및 시험평가 결과를 고객과 지속·공유하여 고객사 생산라인에서 공정 및 장비 신뢰성 평가계약을 유도한다. 고객과 계약에 따라 종합품질 및 생산성 검증평가를 실시하여 기판연삭장비 인증을 획득한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 다양한 연삭 소재, 부품, 장치, 장비 및 공정기술을 시험평가하고, 최적화하는 연구·개발활동을 단독 또는 공동으로 수행한다. 기판연삭장비 개발과정에는 경쟁사 대비 비교우위, 반도체 생산라인 기준 공정 및 장비 신뢰성 목표달성을 고려한 소재, 부품, 장치, 장비 및 공정기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체공정연구원","connectJob":"반도체그라인딩장비공정연구원","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007007:1', '{"dJobCd":"K000007007","dJobCdSeq":"1","dJobNm":"반도체연삭장비부분품연구원","workSum":"반도체 조립기술로드맵 및 고객 요구성능을 이해하고, 연삭장비에 필요한 부분품을 설계, 기초 및 양산평가를 수행하여 최적의 부분품을 연구·개발한다.","doWork":"반도체 기판연삭장비의 기구설계 및 공정연구원과 공동으로 구상한 기초설계를 기준으로 부분품 기능을 정의하고, 상세사양을 결정한 다음, 최적의 재료, 부품 등을 선정한다. 상세사양 기준으로 선정된 재료, 부품들 중에서 유체, 진동 및 열 역학 해석이 필요한 부품들을 분류하고, 각 부품특성에 적합한 해석프로그램을 선정하여 실행한다. 각 부품별 해석결과를 바탕으로 부품 적합성 여부를 판단하며, 부품 재선정 및 해석작업을 반복하여 최종 부분품 사양을 결정한다. 최종 사양을 기준으로 기판연삭장비의 기구 및 유틸리티를 고려한 상세설계를 진행하여 도면을 작성한다. 부분품의 조립, 시험성능평가 및 장비회사 현장평가를 통해 발견되는 기구설계 오류분석으로 부분품 설계개선을 지원한다. 국내외 학회, 세미나, 연구기관 및 제조업체로부터 획득한 정보 및 제품을 기반으로 다양한 재료, 부품기술을 시험평가하고, 최적화하는 연구·개발활동을 단독 또는 공동으로 수행한다. 기판연삭장비의 부분품 개발과정에는 부품 조립의 편이성, 제조원가 절감, 공정 및 장비 신뢰성을 보증하는 재료, 부품기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"반도체부품연구원","connectJob":"반도체그라인딩장비 부분품연구원","dJobECd":"1532","dJobECdNm":"[1532]전자공학 기술자 및 연구원","dJobJCd":"2342","dJobJCdNm":"[2342]전자공학 기술자 및 연구원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;