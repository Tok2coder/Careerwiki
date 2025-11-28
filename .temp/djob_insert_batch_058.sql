INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004869:1', '{"dJobCd":"K000004869","dJobCdSeq":"1","dJobNm":"웨이퍼전극형성장비조작원","workSum":"다결정, 단결정 웨이퍼에 레이저를 이용해 전극을 분리시키고 형성하는 장비를 조작한다.","doWork":"스크린 표면 인쇄를 통해 전 단계에서 전극을 형성하기 위한 작업이 완료된 웨이퍼들을 이동시킨다. 이동이 된 웨이퍼가 담긴 카세트를 장비로 투입한다. 컴퓨터를 조작하여 레이저가 이용이 된 전극 분리 작업을 시작한다. 전극이 분리된 각 셀들을 전기적 성질에 따라 분류하고 효율별로 등급을 매기기 위해 웨이퍼전극측정원에게 보낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"반도체웨이퍼전극형성장비조작원","certLic":"화학분석기능사, 신재생에너지발전설비 기사","dJobECd":"8352","dJobECdNm":"[8352]전자 부품·제품 생산기계 조작원","dJobJCd":"8632","dJobJCdNm":"[8632]전자 부품 및 제품 제조 기계 조작원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003005:1', '{"dJobCd":"K000003005","dJobCdSeq":"1","dJobNm":"웨이퍼텍스처링장비조작원","workSum":"웨이퍼의 반사도를 낮추고 태양광의 흡수량을 증가시키기 위해 습식식각 공정을 이용하여 웨이퍼 표면을 식각하는 텍스처링 장비를 조작한다.","doWork":"전 공정의 웨이퍼 수입검사원으로부터 검사가 완료된 웨이퍼들을 이동시킨다. 이전 공정에서 웨이퍼 절삭작업 시 발생한 절단 자국 및 흠집을 에칭(Etching)시킨다. KOH(수산화칼륨)를 Bath에 Charge하고 에칭 작업이 완료된 웨이퍼가 담긴 카세트를 장비에 투입한다. 컴퓨터를 조작하여 가로줄 무늬나 피라미드 모양의 스크래칭(텍스처링) 형성작업을 시작한다. 텍스처링 작업이 완료된 웨이퍼의 에칭비율(Etch Rate), 텍스처링(Texturing) 정도를 측정한다. 완료된 카세트를 수거한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"투입인출","similarNm":"반도체웨이퍼텍스처링장비조작원","connectJob":"태양전지셀식각장비조작원, 태양전지셀확산장비조작원, 태양전지셀증착장비조작원","certLic":"화학분석기능사, 신재생에너지발전설비 기사","dJobECd":"8352","dJobECdNm":"[8352]전자 부품·제품 생산기계 조작원","dJobJCd":"8632","dJobJCdNm":"[8632]전자 부품 및 제품 제조 기계 조작원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005556:1', '{"dJobCd":"K000005556","dJobCdSeq":"1","dJobNm":"웨이퍼피에스지제거장비조작원","workSum":"웨이퍼의 도핑공정 시 표면에 생성된 PSG(형광제규산염유리)층을 제거하기 위하여 PSG 제거장비를 조작한다.","doWork":"P-N 접합 형성이 된 웨이퍼의 표면층 에칭(Etching)을 위해 웨이퍼를 이동시킨다. 불순물을 도포하여 접합을 하는 과정에서 형성이 된 PSG(형광제규산염유리)층을 제거하기 위한 준비를 한다. 웨이퍼가 담긴 카세트를 장비로 투입하고 컴퓨터를 조작하여 작업을 시작하고, 완료된 카세트를 수거한다. 표면층 에칭이 완료되면 태양광 반사방지막 형성을 위한 공정으로 이동시킨다. 장비의 유지를 위해 일정 주기로 장비청소를 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"웨이퍼PSG제거장비조작원, 반도체웨이퍼피에스지제거장비조작원, 반도체웨이퍼PSG제거장비조작원","connectJob":"태양전지셀세정장비조작원","certLic":"화학분석기능사, 신재생에너지발전설비 기사","dJobECd":"8352","dJobECdNm":"[8352]전자 부품·제품 생산기계 조작원","dJobJCd":"8632","dJobJCdNm":"[8632]전자 부품 및 제품 제조 기계 조작원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003429:1', '{"dJobCd":"K000003429","dJobCdSeq":"1","dJobNm":"자동납땜기조작원","workSum":"인쇄회로기판에 삽입된 전자부품을 인쇄회로기판에 연결하기 위해 자동으로 납땜하는 기기를 조작한다.","doWork":"일정량의 납괴를 기계의 납조에 집어넣어 전원을 공급하여 용융시킨다. 온도계, 비중계 등을 사용하여 납의 온도, 융제(Flux)의 비중을 검사하고 이송대의 작동속도 및 기계의 상태를 점검한다. 자동납땜이 끝난 인쇄회로 기판의 납땜상태를 검사하고 리드선을 제거하기 위해 자동커팅기계에 납땜이 완료된 인쇄회로기판을 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"자동디핑기조작원","dJobECd":"8352","dJobECdNm":"[8352]전자 부품·제품 생산기계 조작원","dJobJCd":"8632","dJobJCdNm":"[8632]전자 부품 및 제품 제조 기계 조작원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001976:1', '{"dJobCd":"K000001976","dJobCdSeq":"1","dJobNm":"자삽기조작원","workSum":"인쇄회로기판에 트랜지스터·다이오드·콘덴서 등 전자부품을 자동으로 삽입하는 기계를 조작한다.","doWork":"자재부서로부터 자재를 수령하여 이상 유무를 확인하고 작업지도서·프로그램철·부품목록 등을 숙지한다. 프로그램을 기계에 입력하고 전자부품자재를 제품모델에 맞게 기계에 장착한다. 인쇄회로기판에 삽입될 전자부품의 첫 좌표를 설정하고 프로그램에 입력된 삽입 위치에 파일을 보며 부품이 삽입되도록 작동시킨다. 작업 중 전자부품 자재를 수시로 확인하여 교체하고 기계의 작동상태를 관찰한다. 삽입된 전자부품을 관찰하여 역삽, 오삽, 미삽 등을 검사하고 양호하면 연속작업을 실시한다. 작업완료된 인쇄회로기판을 차기 공정으로 넘기고 작업일지를 작성한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"에스엠티(SMT)기조작원, 인쇄회로기판제조원","dJobECd":"8352","dJobECdNm":"[8352]전자 부품·제품 생산기계 조작원","dJobJCd":"8632","dJobJCdNm":"[8632]전자 부품 및 제품 제조 기계 조작원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004573:1', '{"dJobCd":"K000004573","dJobCdSeq":"1","dJobNm":"전력반도체소자제조원","workSum":"전력반도체 소자의 제조, 품질수율 및 생산성 향상 활동을 지원하기 위해 제조 및 계측검사 공정장비를 운전하여 제조공정을 수행한다.","doWork":"전력반도체 설계, 소자 및 공정연구원에 의해 정의된 공정레시피를 포함하는 제조공정 순서에 따라 해당 공정장비를 운전하여 로트 단위 수량의 웨이퍼로 제조공정을 수행한다. 공정 진행 이후, 2~5매의 샘플 웨이퍼를 순서도에 명시된 계측검사 장비에서 측정 분석하고, 측정 결과 최소, 최대 사양을 만족할 때에는 해당 로트를 후속 제조공정으로 이관, 인계한다. 만약 측정 결과 불량 발생 시에는 전력반도체 제조기술자에게 연락하여 해당 로트의 이상 발생상황을 설명하여 웨이퍼 전수 검사를 통한 불량 웨이퍼 선정, 웨이퍼 폐기 또는 이관 여부 결정을 지원한다. 제조기술자의 제조공정 불량 발생 원인분석 및 문제해결을 통해 관련 공정·장비 정상화를 지원하여 생산성 향상을 유도한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"전력반도체제조작업자","connectJob":"전력반도체사진현상제조원, 전력반도체식각제조원, 전력반도체확산제조원, 전력반도체박막제조원, 전력반도체세정연마제조원, 전력반도체조립제조원, 전력반도체검사원","dJobECd":"8352","dJobECdNm":"[8352]전자 부품·제품 생산기계 조작원","dJobJCd":"8632","dJobJCdNm":"[8632]전자 부품 및 제품 제조 기계 조작원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002038:1', '{"dJobCd":"K000002038","dJobCdSeq":"1","dJobNm":"전자부품테이핑기조작원","workSum":"자동삽입기계에 사용하기 위해 콘덴서·트랜지스터·다이오드 등 전자부품의 리드선(Lead Wire)에 테이프로 붙여주는 기계를 조작한다.","doWork":"전자부품, 공정카드, 라벨을 확인하고 테이핑기계의 스위치를 올려 히터 및 공기압력 상태를 살피고 기계를 가동한다. 리드선(Lead Wire) 및 슬리브(Sleeve) 상태를 관찰한다. 전자부품의 테이핑 수량을 확인하며, 필요시 릴(Reel), 접착테이프, 대지 등을 교환한다. 기계가 정지되면 불량상태를 확인하고 수리부서에 수리를 의뢰한다. 일정 개수의 전자부품 단위별로 라벨을 붙인다. 불량품을 수거하여 공정카드를 정리한다. 작업대와 기계 주위를 청소하고 잔품을 운반통에 넣는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","similarNm":"테이핑기조작원","connectJob":"에스엠디(SMD)테이핑기조작원","dJobECd":"8352","dJobECdNm":"[8352]전자 부품·제품 생산기계 조작원","dJobJCd":"8632","dJobJCdNm":"[8632]전자 부품 및 제품 제조 기계 조작원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006319:1', '{"dJobCd":"K000006319","dJobCdSeq":"1","dJobNm":"초음파분리원","workSum":"자기콘덴서 제조공정 중 소성로에서 경화된 자기 표면에 묻은 산화 알루미나(Alumina:알루미늄의 산화물) 분말 또는 부착된 자기들을 분리·세척하는 초음파분리기를 조작한다.","doWork":"초음파 세척통 내에 일정량의 물이 흐르도록 밸브를 조절한다. 경화된 자기의 일정량을 세척통 내에 집어넣는다. 기계를 작동시키고 육안으로 자기의 분리상태를 확인하고 분리·세척된 자기들을 건조시킨다. 작업수량 및 작업내용을 기록하고 후공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"다습|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8352","dJobECdNm":"[8352]전자 부품·제품 생산기계 조작원","dJobJCd":"8632","dJobJCdNm":"[8632]전자 부품 및 제품 제조 기계 조작원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003091:1', '{"dJobCd":"K000003091","dJobCdSeq":"1","dJobNm":"콘덴서소성원","workSum":"자기콘덴서의 성형체를 만들기 위하여 혼합·분쇄된 원료를 용량에 따른 일정 두께의 시트(Sheet)로 만들고 건조시키는 기계를 조작한다.","doWork":"기계를 작동시켜 스크루를 회전시키고 건조로에 전원을 공급하여 일정 온도로 예열시킨다. 냉각밸브를 돌려 냉각수가 순화되게 한다. 분쇄된 원료를 기계에 넣어 주고 일련의 공정 진행상황을 주시하면서 작업을 진행한다. 회전하는 컨베이어의 속도를 조절하기 위해 조절다이얼을 조정하며 시트의 두께에 따라 헤드금형의 간격을 수동바퀴로 조정한다. 다이얼계기를 사용하여 시트의 두께를 측정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|고온|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"콘덴서압출원","dJobECd":"8352","dJobECdNm":"[8352]전자 부품·제품 생산기계 조작원","dJobJCd":"8632","dJobJCdNm":"[8632]전자 부품 및 제품 제조 기계 조작원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001447:1', '{"dJobCd":"K000001447","dJobCdSeq":"1","dJobNm":"콘덴서유전체배열원","workSum":"유전체 소성작업을 편리하게 하고 불량을 감소시키기 위하여 배열기를 이용하여 성형된 콘덴서 유전체를 배열한다.","doWork":"절단 성형된 유전체를 소성작업 시 부착되지 않도록 저장상자에서 분말가루를 섞는다. 배열기의 배열판에 분말이 묻어있는 유전체를 일정량 넣는다. 기계를 가동시켜 배열판의 지정 위치에 유전체가 삽입되게 한다. 규격 이하의 유전체나 파손된 유전체는 핀셋을 사용하여 제거한다. 기계를 정지시키고 배열판을 꺼내어 저장상자에 보관한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8352","dJobECdNm":"[8352]전자 부품·제품 생산기계 조작원","dJobJCd":"8632","dJobJCdNm":"[8632]전자 부품 및 제품 제조 기계 조작원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001646:1', '{"dJobCd":"K000001646","dJobCdSeq":"1","dJobNm":"태양광모듈EL이미지측정장비운전원","workSum":"육안검사로 판단할 수 없는 태양광모듈 내부의 결함(태양전지 마이크로크랙, 태빙 불량, 버싱(Bussing)회로 불량 등) 유무를 검사할 수 있는 EL(Electro Luminesence;전계발광) 이미지(Image) 측정 장비를 운전한다.","doWork":"EL이미지 검사장비에서 제공하는 소프트웨어를 실행하고, 태양광모듈의 (+), (-) 단자를 파워서플라이(Power Supply;전압-전류 공급기)에 연결한다. EL카메라 전원을 켠 후 태양광모듈이 갖는 전압-전류 특성을 고려해서 파워서플라이에서 전압-전류를 공급한다. 소프트웨어를 이용하여 EL이미지를 측정하면 EL카메라 셔터가 동작하며, 태양광모듈 내부의 결함을 EL이미지로 확인할 수 있다. EL이미지 사진에 태양광모듈 형체가 보이지 않을 경우에는 태양광모듈의 전극 단자가 올바르게 연결되었는지 확인하고, 파워서플라이에서 공급할 전압-전류량을 조절하여 반복 측정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"힘든 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","dJobECd":"8352","dJobECdNm":"[8352]전자 부품·제품 생산기계 조작원","dJobJCd":"8632","dJobJCdNm":"[8632]전자 부품 및 제품 제조 기계 조작원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003389:1', '{"dJobCd":"K000003389","dJobCdSeq":"1","dJobNm":"태양광모듈라미네이터장비운전원","workSum":"태양광모듈 공정 중 태양광모듈의 수명을 최대화하기 위해 전면재(저철분강화유리 등)와 봉지재와 후면재(저철분강화유리, 시트 등)를 사용하여 태양전지가 수분이나 충격으로부터 보호하도록 하는 공정에 사용되는 라미네이터(Laminator) 장비를 운전한다.","doWork":"회로작업(Bussing)이 완료된 적층된 모듈을 라미네이터 로딩부에 위치시킨다. 라미네이터 사양에 따라 모듈 개수를 조절하고 공정중에 녹아내린 봉지재가 라미네이터 안쪽에 있는 다이어프램(Diaphragm)과 히팅플레이트(Heating plate)에 달라붙는 것을 방지하기 위해 테프론 시트가 감싸진 상태에서 라미네이션을 수행한다. 모듈의 크기, 두께, 사용재료에 따라서 온도, 시간, 진공, 압력 등의 파라미터를 최적화한 후 작업을 수행한다. 라미네이션이 종료되면 상온에서 냉각시킨 후 라미네이션 과정에서 녹아서 흘러 나온 봉지재와 유리 밖으로 튀어나온 후면시트를 유리사이즈에 맞도록 트리밍(Trimming)하여 라미네이션 공정을 마무리 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","dJobECd":"8352","dJobECdNm":"[8352]전자 부품·제품 생산기계 조작원","dJobJCd":"8632","dJobJCdNm":"[8632]전자 부품 및 제품 제조 기계 조작원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006209:1', '{"dJobCd":"K000006209","dJobCdSeq":"1","dJobNm":"태양광모듈레이업장비운전원","workSum":"테빙(Tabbng) 작업이 일렬로 완성된 스트링 태양전지를 모듈화 회로를 구성하기 위하여 다중열로 배열하고, 버싱(Bussing) 작업을 실시하여 회로를 구성한 후 장기간의 자연환경 및 외부충격에서 견딜 수 있도록 하기 위해 표면재료(강화유리), 봉지재, 다중열로 배열된 태양전지, 봉지재, 후면재료(유리, 백시트 등) 형태의 구조로 적층하는 레이업 장비를 운전한다.","doWork":"레이업 장비 위에 투입될 태양광모듈용 표면유리(강화유리)에 이물질, 크랙(Crack), 기포 등이 있는지를 육안으로 확인하고, 이물질이나 먼지가 있을 경우에는 알코올성분의 세정제로 닦아낸다. 진공흡작 패드를 이용하여 유리를 고정시킨 후 그 위에 봉지재 필름을 펼쳐놓는다. 별도의 작업파랫트에서 일렬로 테빙된 스트링 태양전지를 설계에 따라 배열한 후 회로작업(Bussing)을 수행하고, 스트링 태양전지 전체를 진공흡착 패드를 이용하여 동시에 들어서 표면유리와 봉지재가 적층되어 놓여진 위치에 내려놓은 후 후면 봉지재 필름을 내려놓고, 후면재료(강화유리, 백시트 등)를 그 위에 얹은 후 (+), (-) 전극 버스바(Busbar)가 노출되게 하여 다음 작업공정으로 보낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","dJobECd":"8352","dJobECdNm":"[8352]전자 부품·제품 생산기계 조작원","dJobJCd":"8632","dJobJCdNm":"[8632]전자 부품 및 제품 제조 기계 조작원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002386:1', '{"dJobCd":"K000002386","dJobCdSeq":"1","dJobNm":"태양광모듈발전성능측정장비운전원","workSum":"태양광모듈을 인공광원에 노출시켜 1,000W/㎡의 광원의 세기와 25℃의 표면온도 상태에서 전류-전압 특성 곡선(Curve)를 측정한 후 최대전류, 최대전압, 단락전류, 개방전압을 측정하여 태양광모듈의 발전성능을 측정하는 솔라시뮬레이터를 조작한다.","doWork":"솔라시뮬레이터 운전프로그램을 실행시킨 후 측정하고자 하는 태양광모듈에 대한 사양(모델명, 시리얼번호, 모듈 면적, 셀 면적, 셀 갯수, 직병렬 수 등)을 입력하고, 고정틀에 모듈 전면이 인공광원과 마주보게 고정시킨다. (+),(-) 전극을 솔라시뮬레이터 단자에 연결시킨 후 측정환경기준인 인광광원의 일사강도 1,000W/㎡, 측정시료온도 25℃ 상태에서 전류-전압 특성곡선(Curve)을 계측하여 최대출력, 최대전압, 최대전류, 단락전류, 개방전압, 곡선률, 효율 등 태양광모듈의 발전성능을 측정한다. 장비의 정확성을 기하기 위해 주기적으로 공인기관에서 공급된 레퍼런스모듈을 측정하여 지난 측정 값과 비교하여 편차가 없는지 확인 확인한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"힘든 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","dJobECd":"8352","dJobECdNm":"[8352]전자 부품·제품 생산기계 조작원","dJobJCd":"8632","dJobJCdNm":"[8632]전자 부품 및 제품 제조 기계 조작원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003038:1', '{"dJobCd":"K000003038","dJobCdSeq":"1","dJobNm":"태양광모듈테빙장비운전원","workSum":"태양광모듈 공정 중 태양전지의 (+), (-) 전극에 도체 리본(Ribbon)이나 도체 와이어(Wire)를 이용하여 태양전지와 태양전지를 직렬로 연결하는 테빙(Tabbing) 장비를 운전한다.","doWork":"태양광모듈에 사용할 태양전지를 테빙장비에서 지원하는 카세트에 넣은 후 셔틀에 장착하고 태양전지 전극 규격에 맞는 도체리본이나 도체와이어를 장착한 후 테빙작업을 수행한다. 태양전지의 개수, 태양전지와 태양전지의 간격, 용접강도에 따라서 최적의 파라미터를 셋팅하고 테빙을 시작한다. 테빙된 태양전지에 도체리본이나 도체와이어가 일렬로 잘 용접이 되었는지, 용접강도가 너무 강해 태양전지에 크랙이 가지 않았는지, 태양전지와 태양전지의 간격이 일정한지 육안으로 확인한다. 테빙을 마친 일렬로 용접된 태양전지는 다음공정인 레이업(Layup) 공정으로 넘긴다. 태양전지 사이즈가 변경되거나 전극 패턴이 변경될 경우에는 장비의 잡체인지(Job change)를 수행한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","dJobECd":"8352","dJobECdNm":"[8352]전자 부품·제품 생산기계 조작원","dJobJCd":"8632","dJobJCdNm":"[8632]전자 부품 및 제품 제조 기계 조작원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003451:1', '{"dJobCd":"K000003451","dJobCdSeq":"1","dJobNm":"태양전지제조장비유지보수원","workSum":"태양전지 제조공정에 사용되는 식각, 확산, 세정, 증착 장비 등의 장비를 주기적으로 검사하고 보수한다.","doWork":"장비운전원이 장비에 문제가 있음을 알리면 해당 장비로 가서 문제점을 파악한다. 제조장비의 운전절차에 따라 장비가 정상작동하는지 점검하고 기계적 결함과 같은 하드웨어 결함일 시에는 문제가 되는 원인을 찾아내고 부품을 교체한다. 하드웨어 결함이 아닌 소프트웨어 결함일 시에는 간단한 것은 리셋을 하고 리셋으로 해결되지 않을 때에는 소프트웨어를 다시 복원하기도 한다. 유지관리대장을 살펴보고 사용수명이 다 된 소모품은 정기적으로 바꾸어주며 필요한 부분을 청소한다. 사용된 부품명을 부품대장에 기록하고 재고량을 확인하여 부족할 때에는 태양전지제조장비관리원에게 알려 부품이 부족하지 않도록 유지한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","dJobECd":"8352","dJobECdNm":"[8352]전자 부품·제품 생산기계 조작원","dJobJCd":"8632","dJobJCdNm":"[8632]전자 부품 및 제품 제조 기계 조작원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002575:1', '{"dJobCd":"K000002575","dJobCdSeq":"1","dJobNm":"편심연마원","workSum":"TV, 무선기, 송신기 등 전자기기의 발전주파수제어용인 진동자의 수정핀을 일정 두께로 갈아내는 편심연마기를 조작한다.","doWork":"핀셋을 사용해서 도면 및 사양서에 따라 선별된 일정 두께의 수정핀을 캐리어(Carrier)의 네스크(Nesk)에 삽입한다. 네스크에 삽입된 상태를 손으로 확인하고 연마기의 물리대에 장입한다. 연마반의 수평상태와 표면을 육안검사하고 기계를 가동시킨다. 상하연마반의 간격을 조정나사로 조정하고 수정핀을 규정 두께로 갈아낸다. 검사기구를 사용하여 작업 중 수정핀의 주파수와 저항을 측정하며 마모된 연마반을 교체하기도 한다. 사용용도에 따라 면을 경사지게 갈기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8352","dJobECdNm":"[8352]전자 부품·제품 생산기계 조작원","dJobJCd":"8632","dJobJCdNm":"[8632]전자 부품 및 제품 제조 기계 조작원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005875:1', '{"dJobCd":"K000005875","dJobCdSeq":"1","dJobNm":"플라즈마영상패널격벽형성원","workSum":"PDP(Plasma Display Panel)의 상판과 하판사이의 방전공간 확보를 목적으로 RGB(red green blue) 형광체가 섞이지 않도록 하는 격벽(칸막이)을 형성한다.","doWork":"분진에 대비해 방진복 등의 방진대비 장구를 반드시 착용하고 작업장에 입장한다. 격벽페스트, 식각용 파우더를 핵심재료로 해 고압의 샌드파우더를 이용해 물리적으로 식각하는 샌드블라스터장비를 조작한다. 격벽재를 코팅하고 건조시킨 후 감광제를 도포(DPR Lamination)한다. 이후 노광, 현상, 식각, 박리, 소성 공정 등의 오랜 시간을 거치면서 격벽을 형성한다. 이러한 격벽형성과정은 PDP 제조공정상 가장 복잡하고 장시간이 소요된다. 격벽공정이 완료가 되면 형광체를 도포하기 위한 공정으로 이동시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"PDP격벽형성원, 플라스마표시장치패널격벽형성원, 피디피격벽형성원","certLic":"화학분석기능사, 전기기능사","dJobECd":"8352","dJobECdNm":"[8352]전자 부품·제품 생산기계 조작원","dJobJCd":"8632","dJobJCdNm":"[8632]전자 부품 및 제품 제조 기계 조작원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004570:1', '{"dJobCd":"K000004570","dJobCdSeq":"1","dJobNm":"플라즈마영상패널버스전극형성원","workSum":"ITO(Indium Tin Oxide)전극이 형성된 PDP(Plasma Display Panel)상판에 감광성 은(Ag) 페이스트(paste)를 사용해 BUS전극을 형성한다.","doWork":"전기전도도가 좋은 은(Ag) 분말을 용제와 바인더에 혼합하여 페이스트(paste : 건전지나 습식 전해 콘덴서에 있어서 전해액의 취급을 용이하게 하기 위해 녹말 등에 섞어서 만든 풀모양의 물질) 형태로 만든다. BUS전극을 형성하기 위하여 감광성 은(Ag) 페이스트를 재료로 페이스트 인쇄를 하기 위한 준비를 한다. 인쇄기를 조작하여 먼저 흑색 페이스트를 인쇄하고 건조기로 건조한 다음, 인쇄기를 조작하여 은(Ag) 페이스트를 인쇄하고 다시 건조한다. 노광기를 조작하여 노광작업을 하고 소성로를 작동하여 소성한다. 도포막을 건조시켜 용제를 증발시키며, 건조막 상태에서 포토리소그래피 공정을 이용해 원하는 전극 형상으로 식각한다. 고열로 소성하여 바인더를 태우고 막을 치밀하게 고착시킨다. BUS전극이 완료되면 블랙스트라이프(B/S) 형성을 위한 공정으로 이동시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"투입인출","similarNm":"PDP버스전극형성원, 플라스마표시장치패널버스전극형성원, 피디피버스전극형성원","certLic":"화학분석기능사, 전기기능사","dJobECd":"8352","dJobECdNm":"[8352]전자 부품·제품 생산기계 조작원","dJobJCd":"8632","dJobJCdNm":"[8632]전자 부품 및 제품 제조 기계 조작원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002526:1', '{"dJobCd":"K000002526","dJobCdSeq":"1","dJobNm":"플라즈마영상패널스퍼터장비조작원","workSum":"투명한 PDP(Plasma Display Panel)패널 상판 글라스에 스퍼터링(Sputtering) 장비를 이용해 투명전극(ITO : Indium Tin Oxide)을 형성하는 공정을 수행한다.","doWork":"세정을 마친 상판용 투명글라스(보통 고왜점 글라스, high strain glass)를 ITO 코팅시키기 위해 이동시킨다. 스퍼터장비의 컴퓨터를 조작하여 기판을 예열하고 스퍼터링을 시작한다. 방전전극으로 사용되는 투명전극(ITO)를 생성하기 위하여 투명전도층인 인듐(Sn), 주석(Sn) 산화물을 스퍼터링법으로 코팅을 한다. 연속적으로 글라스를 통과시키거나(인라인방식) 각각의 챔버에 글라스를 이송하여 독립적으로 공정을 진행한다(클러스터 방식). 감광물질인 DFR(Dry Film Photoresist)을 마스크로 이용해 산으로 화학적 식각을 한 후 노광, 현상, 에칭, 박리, 검사 등으로 ITO 패터닝(Patterning) 과정을 거친다. ITO 전극이 형성되면 BUS 전극의 형성을 위해 다음 공정으로 이동시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"PDP스퍼터장비조작원, 플라스마표시장치패널스퍼터장비조작원, 피디피스퍼터장비조작원","certLic":"화학분석기능사, 전기기능사","dJobECd":"8352","dJobECdNm":"[8352]전자 부품·제품 생산기계 조작원","dJobJCd":"8632","dJobJCdNm":"[8632]전자 부품 및 제품 제조 기계 조작원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001946:1', '{"dJobCd":"K000001946","dJobCdSeq":"1","dJobNm":"플라즈마영상패널어드레스전극형성원","workSum":"PDP(Plasma Display Panel) 하판에 방전 선택용 어드레스 전극을 인쇄 방식으로 형성하기 위한 공정을 수행한다.","doWork":"투명전극(ITO) 막이 없이 바로 어드레스 전극을 형성하도록 글라스를 이동시킨다. 라미네이팅 코팅 장비에 글라스를 투입하고 컴퓨터를 조작하여 감광성 은(Ag)을 인쇄한 다음 건조한다. 노광기에 건조가 완료된 글라스를 투입하고 컴퓨터를 조작하여 노광한다. 노광이 완료된 글라스를 현상하고 소성하여 어드레스 전극을 생성한다. 유전층을 인쇄하기 위한 다음 공정으로 이동시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"PDP어드레스전극형성원, 플라스마표시장치패널어드레스전극형성원, 피디피어드레스전극형성원","certLic":"화학분석기능사, 전기기능사","dJobECd":"8352","dJobECdNm":"[8352]전자 부품·제품 생산기계 조작원","dJobJCd":"8632","dJobJCdNm":"[8632]전자 부품 및 제품 제조 기계 조작원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003033:1', '{"dJobCd":"K000003033","dJobCdSeq":"1","dJobNm":"플라즈마영상패널유전체생성원","workSum":"어드레스 전극이 형성된 PDP(Plasma Display Panel) 하판에 유전체를 형성하기 위하여 인쇄, 건조, 소성을 반복 수행한다.","doWork":"어드레스 전극이 형성된 글라스에 유전층을 형성하기 위해 이동시킨다. 기법에 따라 인쇄 페이스트, 코터 페이스트를 인쇄기나 코터기에 각각 투입을 한다. 컴퓨터를 조작하여 인쇄를 시작한다. 인쇄나 코팅이 된 글라스 페이스트를 건조장비로 건조한 다음 소성로를 작동하여 소성한다. 인쇄(또는 코터)-건조-소성을 하거나 반복하여 PDP 하판 유전체를 생성한다. 생성이 된 유전체는 어드레스 전극의 절연층 역할과 하판의 벽전하를 쌓는 역할을 동시에 하므로 이물과 기포가 없고 표면상태가 양호한지 확인한다. 격벽 형성을 위한 다음 공정으로 글라스를 이동시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"투입인출","similarNm":"PDP유전체생성원, 플라스마표시장치패널유전체생성원, 피디피유전체생성원","certLic":"화학분석기능사, 전기기능사","dJobECd":"8352","dJobECdNm":"[8352]전자 부품·제품 생산기계 조작원","dJobJCd":"8632","dJobJCdNm":"[8632]전자 부품 및 제품 제조 기계 조작원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003845:1', '{"dJobCd":"K000003845","dJobCdSeq":"1","dJobNm":"플라즈마영상패널유전층보호막형성원","workSum":"전자빔 진공증착법을 이용해 PDP(Plasma Display Panel)의 보호막으로 사용되는 MgO(Magnesium oxide)막을 형성하는 공정을 수행한다.","doWork":"전 공정에서 투명유전층이 형성된 후 MgO(Magnesium oxide) 보호막을 형성시키기 위해 이동시킨다. MgO 보호막을 코팅하기 위해서는 주로 전자빔 진공증착법(E-beam Evaporation)을 이용한다. MgO 소스를 핵심재료로 하여 전자빔 증착장비를 작동시킨다. 기판을 예열한 후 MgO 소스의 표면을 가속 전자로 가열시킨 후 기판을 냉각해 증발시킨다. 이때 보호층 막이 표면 절연성이 높고 안정되도록 두께 균일도를 제어한다. 증착이 된 MgO 막은 수분을 흡수하는 성질이 있어 가능한 하판과 바로 조립을 하도록 다음 공정으로 빠르게 이동시킨다. 클린룸에서 방치를 하는 경우에는 습기가 제거된 환경에서 보관을 해야 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"PDP유전층보호막형성원, 플라스마표시장치패널유전층보호막형성원, 피디피유전층보호막형성원","certLic":"화학분석기능사, 전기기능사","dJobECd":"8352","dJobECdNm":"[8352]전자 부품·제품 생산기계 조작원","dJobJCd":"8632","dJobJCdNm":"[8632]전자 부품 및 제품 제조 기계 조작원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001941:1', '{"dJobCd":"K000001941","dJobCdSeq":"1","dJobNm":"플라즈마영상패널점등검사원","workSum":"에이징(aging) 과정 후 완성이 된 PDP(Plasma Display Panel)의 화질특성과 방전특성을 정밀 검사하여 양품만을 선별하는 점등검사를 한다.","doWork":"상하판을 봉착, 배기 완료가 된 패널의 에이징(Aging)을 하기 위해 이동시킨다. 패널에 전압을 인가해 점등여부를 테스트하는 통전검사를 한다. 패널 내부에 존재하는 불순물을 제거하고 MgO 표면의 활성화와 전기적 특성의 안정을 위해 예비 방전을 하는 에이징(Aging) 과정을 거친다. 에이징이 완료된 패널에는 일정전압을 가하여 패널의 휘도, 색온도 등을 특성평가하는 점등검사를 한다. 점등검사는 전압마진, 이상 유무 등을 검사한다. 각종 검사장비를 사용하여 패널을 켰다 껐다 하면서 패널의 방전특성, 휘도, 색온도, 균일도, 계조 및 온도특성, 패널의 화질, 셀 결함 및 외관결함 등을 검사한다. 점등검사를 통해 테스트 합격이 된 양질의 패널만을 선별하여 모듈 조립공정으로 보낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"PDP점등검사원, 플라스마표시장치패널점등검사원, 피디피점등검사원","certLic":"화학분석기능사, 전기기능사","dJobECd":"8352","dJobECdNm":"[8352]전자 부품·제품 생산기계 조작원","dJobJCd":"8632","dJobJCdNm":"[8632]전자 부품 및 제품 제조 기계 조작원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004651:1', '{"dJobCd":"K000004651","dJobCdSeq":"1","dJobNm":"플라즈마영상패널투명유전극생성원","workSum":"PDP(Plasma Display Panel) 상판의 표면에 벽전하를 형성하고 BUS 전극을 보호하기 위해 투명유전층을 형성하는 일을 한다.","doWork":"전 공정에서 블랙스트라이프(B/S)가 형성이 된 글라스에 투명유전층을 코팅하기 위한 준비를 한다. 유전체는 방전시 콘덴서로 작용하여 전류를 제한하며 메모리기능을 가진 글라스 페이스트를 사용하고, 데이터전극 보호용으로 사용되는 배면 유전층은 주로 백색재료를 사용한다. 투명유전층을 형성하기 위하여 인쇄를 여러 번 반복하거나 슬릿코터를 이용하여 한 번에 코팅을 하는 방법 등을 사용한다. 글라스 페이스트를 인쇄장비에 투입하고 컴퓨터를 조작하여 인쇄한다. 인쇄한 글라스 페이스트를 건조장비로 건조한 다음 소성로를 작동하여 소성한다. 인쇄-건조-소성을 반복하여 투명유전전극을 생성한다. 투명 유전층의 내부구조와 두께가 치밀하며 기포나 이물 등이 없는지를 확인하고 MgO 막을 형성하기 위한 공정으로 이동시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"PDP투명유전극생성원, 플라스마표시장치패널투명유전극생성원, 피디피투명유전극생성원","certLic":"화학분석기능사, 전기기능사","dJobECd":"8352","dJobECdNm":"[8352]전자 부품·제품 생산기계 조작원","dJobJCd":"8632","dJobJCdNm":"[8632]전자 부품 및 제품 제조 기계 조작원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003633:1', '{"dJobCd":"K000003633","dJobCdSeq":"1","dJobNm":"플라즈마영상패널프릿도포원","workSum":"형광체 공정이 완료된 후 형광체를 소성시키기 위하여 디스펜서를 이용한 프릿(frit : 일반적으로 유리질의 분말을 칭함) 도포를 한다.","doWork":"형광체 공정이 완료된 하판의 프릿 도포를 위해 하판을 이동시킨다. 형광체를 소성시키기 위해 유리를 용융 또는 하소한 프릿 페이스트를 디스펜서의 프릿 탱크(Frit Tank)에 넣는다. 프릿 디스펜서 장비의 작업테이블 위에 완성된 하판을 올려놓는다. 컴퓨터 프로그램을 작동시켜 프릿탱크에 압력을 가한 후 노즐을 이용하여 원하는 궤적에 연속적으로 토출시키도록 한다. 판과 하판을 결합하기 위한 실링 프릿 재료를 하관의 외곽 부위에 라인 형태로 도포를 한다. 이때 배기관도 동일한 실링 프릿 재료를 이용해 고정을 시킨다. 프릿 도포가 완료되면 상하판의 조립을 위한 모듈공정으로 이동시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"투입인출","similarNm":"PDP프릿도포원, 플라스마표시장치패널프릿도포원, 피디피프릿도포원","certLic":"화학분석기능사, 전기기능사","dJobECd":"8352","dJobECdNm":"[8352]전자 부품·제품 생산기계 조작원","dJobJCd":"8632","dJobJCdNm":"[8632]전자 부품 및 제품 제조 기계 조작원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003012:1', '{"dJobCd":"K000003012","dJobCdSeq":"1","dJobNm":"플라즈마영상패널형광체형성원","workSum":"PDP 하판의 격판들 사이에 RGB(red green blue) 형광체를 순서대로 도포하기 위한 형광체인쇄기를 조작한다.","doWork":"격벽이 형성된 하판에 형광체를 도포하기 위해 이동시킨다. 연속적인 형광체의 도포를 위해 장비를 컴퓨터로 제어·조작한다. 인쇄 매스킹을 이용한 인쇄 방식 혹은 미세한 노즐을 이용한 디스펜서 방식을 적용해 RGB(red green blue) 형광체를 순서대로 격벽 사이의 공간에 도포를 한다. 인쇄 방식은 인쇄기를 이용해 인쇄와 건조를 반복한 후 소성시키며, 디스펜싱 방식은 디스펜서를 이용해 디스펜싱과 건조를 반복한 후 소성을 시킨다. 순서는 R 형광체-G형광체-B 형광체 순으로 인쇄하고 건조한다. 특별히 디스펜싱 방식에서는 노즐의 막힘을 유의한다. 형광체를 형성한 이후에는 프릿(frit) 도포 공정으로 이동시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"PDP형광체형성원, 플라스마표시장치패널형광체형성원, 피디피형광체형성원","certLic":"화학분석기능사, 전기기능사","dJobECd":"8352","dJobECdNm":"[8352]전자 부품·제품 생산기계 조작원","dJobJCd":"8632","dJobJCdNm":"[8632]전자 부품 및 제품 제조 기계 조작원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005131:1', '{"dJobCd":"K000005131","dJobCdSeq":"1","dJobNm":"형광체제조원","workSum":"조명이나 디스플레이 등에 사용되는 형광체를 제조하는 일을 한다.","doWork":"원료약품 재고량 및 물품재고량을 파악하고 설비작동상태 및 작업진행과정 등 공정을 점검한다. 형광체를 탱크에 투입하고 형광체에 포함된 각종 유기물을 제거하기 위해 약품을 투입한다. 약품처리 후 폐기물을 제거하고 규격에 따른 PH메터기를 사용하여 PH를 일정수준으로 유지시킨다. 일련의 작업이 끝난 형광체를 잘게 부수어 트레이어에 담아 건조기에 투입한다. 진동여과기를 사용하여 고온에서 건조된 형광체를 여과한다. 완성된 형광체를 적정량으로 포장한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"형광체재생원","dJobECd":"8352","dJobECdNm":"[8352]전자 부품·제품 생산기계 조작원","dJobJCd":"8632","dJobJCdNm":"[8632]전자 부품 및 제품 제조 기계 조작원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001615:1', '{"dJobCd":"K000001615","dJobCdSeq":"1","dJobNm":"화성기조작원","workSum":"전해콘덴서를 제조하기 위하여 화성액 중에서 에칭(Etching)박 표면에 따라 산화알루미늄(Al₂O₃)의 박막을 생성하는 화성기를 조작한다.","doWork":"화성기·펌프·열처리기·권취기·정류기의 각 스위치를 켜고 화성액을 규정된 온도까지 올리고 규정된 전압이 되도록 한다. 알루미늄박을 송출부에 끼우고 각 화성조를 통과시키며 전압을 확인한다. 화성작업을 하며 알루미늄박 표면의 이상 유무를 확인한다. 순수세척조로 세척하고 건조히터를 통과시키며 건조상태를 관찰한다. 건조된 알루미늄박이 권취기에 감길 때 좌우 간격이 일정한지 확인한다. 화성이 완료된 박을 권취부에서 떼어낸다. 검사를 실시하기 위해 시료를 채취한다. 화성된 알루미늄박을 포장하고 포장지 위에 박명과 일련번호를 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|고온|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8352","dJobECdNm":"[8352]전자 부품·제품 생산기계 조작원","dJobJCd":"8632","dJobJCdNm":"[8632]전자 부품 및 제품 제조 기계 조작원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004888:1', '{"dJobCd":"K000004888","dJobCdSeq":"1","dJobNm":"가스절연개폐장치조립원","workSum":"차단기 제관, 본체 조립, 각 주변장치 조립 등의 공정을 거친 개폐장치 각 부분을 결합시키고 배선·검사하여 전체 개폐장치(GIS)를 조립한다.","doWork":"설계도면에 따라 제조된 부분품의 배열과 작업공정을 세운다. 차단기, 단로기, 접지개폐기 등의 위치와 배열을 계산한다. 차단기 본체의 상부와 하부를 각각 조립하여 결합시킨다. 콘덴서, 고정자, 가동자, 컴프레서, 케이스, 패널, 조작기 등 조작 장치와 가스밸브, 가스밀도 스위치를 각각 조립하여 결합시킨다. 조립공정 간에 크레인을 사용하여 들어 올리거나 이동장비를 사용하여 운반하기도 하며, 각종 수공구 및 용접기를 사용하여 결합시키고 차단기의 개조가 가능하도록 충분한 공간을 두어 조립한다. 배선도에 따라 전선을 연결시키고 검사·시험한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"고압전력회로차단기조립원","certLic":"전기산업기사, 전기산업기사","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C281","dJobICdNm":"[C281]전동기, 발전기 및 전기 변환ㆍ 공급ㆍ제어 장치 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006537:1', '{"dJobCd":"K000006537","dJobCdSeq":"1","dJobNm":"가정용전기기구제조현장감독자","workSum":"냉장고·선풍기·세탁기 등 가정용 전기·전자제품을 제조하는 일을 하는 가정용전기기구조립원의 활동을 감독·조정한다.","doWork":"주문서에 따라 작업지시서를 만든다. 납기일에 따라 일일생산량계획을 수립한다. 작업에 필요한 각종 공구와 기계 등을 점검하고 확인한다. 작업공정 방법과 순서를 정하여, 작업원을 배치하고 작업원들에게 지시를 한다. 불량률을 점검하고 모델변경에 따라 시방을 변경한다. 생산계획에 따른 실적을 분석하고 자재수급상태를 파악하고 조치한다. 작업자별 작업량·작업시간·진도 등을 파악하여 공정별 균형을 유지한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|","workFunc1":"조정","workFunc2":"감독","workFunc3":"수동조작","similarNm":"가정용전기제품제조반장, 가정용전기기구제조반장","connectJob":"가정용전기기구조립반장, 가정용전기기구수리반장, 가정용전기기구검사반장","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C285","dJobICdNm":"[C285]가정용 기기 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005645:1', '{"dJobCd":"K000005645","dJobCdSeq":"1","dJobNm":"가정용전기기구조립원","workSum":"표준작업공정에 따라 냉장고·선풍기·세탁기 등 가정용 전기기구제품을 제조하기 위해 관련 부품 또는 부분품을 조립·용접·시험한다.","doWork":"컨베이어벨트 옆이나 자동화된 생산라인 주위에서 작업준비를 한다. 작업지시서에 따라 조립할 제품의 부분품을 확인하고 점검한다. 작업에 필요한 장비와 작업공구를 준비한다. 수공구 또는 자동공구로 볼트, 나사 등을 연결한다. 전동기, 콘덴서, 열교환기 등을 납땜한다. 공정별로 조립 이상 유무를 확인한다. 앞 공정에서 조립하면서 문제가 없었는지 확인하고, 문제가 있으면 이를 수정하거나 앞 공정에서 오류를 잡을 수 있게 알려준다. 전압계, 전력계, 시험지그 등을 이용하여 소음, 소비전력, 전기결선 등 이상 유무를 검사한다. 제품 외관의 찍힘, 긁힘, 색상 등 외관검사를 한다. 작업 중에 문제가 발생한 제품은 별도로 마련된 수리실이나 검사실로 옮긴다. 제품의 합격, 불합격 판정 후 합격된 제품을 포장하거나 자동포장기를 조작하여 포장한다. 출하를 위하여 적재장소에 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"가정용전기제품조립원","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C285","dJobICdNm":"[C285]가정용 기기 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002378:1', '{"dJobCd":"K000002378","dJobCdSeq":"1","dJobNm":"감시용카메라제조현장감독자","workSum":"감시용 카메라를 제조하는 일을 하는 감시용카메라조립원의 활동을 감독·조정한다.","doWork":"제품생산에 대한 작업표준서를 작성하고 작업원들에게 업무를 할당한다. 생산량을 파악하고 불량에 대한 원인을 분석하고 조치한다. 공정상의 문제점이나 작업원들의 불편사항을 수시로 취합하여 조치한다. 작업내용에 따라 작업원에게 지시·배치한다. 작업의 진행상황을 파악하고 작업내용을 보고한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원 및 자재를 공급한다. 작업계획에 따라 세부실행항목을 수립하고 작업 절차 및 방법을 결정하여 작업원에게 작업내용을 지시하고 작업배치를 한다. 표준작업명세에 따라 지시된 작업이 이루어지는지 작업원과 함께 작업하며 작업상황을 관찰하고 작업내용을 점검한다. 작업원의 직무교육 및 안전위생 교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"CCTV제조반장, 감시용카메라제조반장","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C264","dJobICdNm":"[C264]통신 및 방송 장비 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006126:1', '{"dJobCd":"K000006126","dJobCdSeq":"1","dJobNm":"감시용카메라조립원","workSum":"작업지시서에 따라 각종 공구를 사용하여 감시용 카메라를 조립한다.","doWork":"작업지시서에 따라 조립공정을 숙지하고 조립 도구 및 소모품을 준비한다. 조립할 감시용 카메라의 부품을 수령하고 작업대에 배치한다. 렌즈모듈, 이미지 센서 모듈 등 각종 모듈과 부분품을 조립순서에 따라 끼워 맞추고 전기배선을 결속한다. 납땜기를 사용하여 납땜한다. 자동공구를 사용하여 나사를 체결한다. 내부 장치의 조립이 완료되면 외부케이스를 조립하고 고정한다. 조립된 제품을 적재하여 다음 공정으로 이동한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"CCTV조립원","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C264","dJobICdNm":"[C264]통신 및 방송 장비 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007060:1', '{"dJobCd":"K000007060","dJobCdSeq":"1","dJobNm":"경보기조립원","workSum":"설계도면에 따라 경보용으로 사용되는 인쇄회로기판 및 케이스 등의 반조립 부품을 조립한다.","doWork":"작업지시서와 설계도면의 작업내용을 정확히 이해한다. 인쇄회로기판에 집적회로소자(IC)·트랜지스터(TR)저항·콘덴서·진동자 등을 설계도면에 따라 삽입한다. 납땜공구를 사용하여 부분품의 선을 인쇄회로 기판에다 납땜하고 튀어나온 부분을 니퍼로 절단한다. 조립된 인쇄회로 기판의 뒷면에 절연 및 부식을 방지하기 위해 니스를 칠한다. 조립된 인쇄회로기판을 케이스에 너트로 고정시킨다. 조립된 케이스에 자동으로 경보를 울릴 수 있는 자체경보장치(접촉형태의 경보장치)를 부착·조립한다. 오실로스코프·테스터기 등을 사용하여 회로가 설계도면에 맞도록 조립되었는지 검사한다. 검사에 이상이 없으면 조립된 경보장치를 박스에 넣어 포장한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"전기기능사","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C289","dJobICdNm":"[C289]기타 전기장비 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005220:1', '{"dJobCd":"K000005220","dJobCdSeq":"1","dJobNm":"계전기조립원","workSum":"전기회로의 개폐를 제어하는 기초판, 전기자, 계철(Yoke) 등의 계전기 부품을 조립한다.","doWork":"작업표준에 따라 조립·제조할 계전기의 부품을 확인하고 점검한다. 작업표준에 따라 전자석부문, 스프링, 단자부분의 조립을 위한 작업공정을 계산한다. 단자가 조립된 계전기 기초판을 작업대 지그 위에 물려서 고정시킨다. 일정회수 코일이 감긴 보빈과 포올코어가 조립된 계철을 기초판 지정 위치에 올려놓고 압축공기 나사물리개를 사용하여 기초판과 볼트를 조여준다. 코어 측면으로 가동접촉자(Movable Contact)가 연결된 전기자를 기초판에 조립한다. 일정 모양의 코일스프링을 계철과 전기자에 연결시켜 고정시킨다. 결선방법에 따라서 납땜기구를 사용해서 가동접촉자와 기초판 리드단자에 리드 및 코일압력선을 땜질한다. 완성된 제품은 시험검사공정으로 이송시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"릴레이(Relay)부품조립원","certLic":"전자기능사","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C281","dJobICdNm":"[C281]전동기, 발전기 및 전기 변환ㆍ 공급ㆍ제어 장치 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004571:1', '{"dJobCd":"K000004571","dJobCdSeq":"1","dJobNm":"계측기기제조반장","workSum":"환경용, 의료용, 통신용, 전기관련용 등 각종 계측기기를 조립·검사하는데 일을 하는 계측기기조립원의 활동을 감독·조정한다.","doWork":"계측기기 제조공정, 계측기기 부품, 계측기기 성능 및 기능 등의 계측기기 전반에 관한 지식과 내용을 숙지한다. 생산량, 제조품목, 시간계획 등을 수립하여 계측기기 생산계획에 따라 작업원을 적정하게 배치한다. 생산계획에 따른 작업계획을 수립하고 조립부품을 불출한다. 각 생산공정을 관리·감독하며 때에 따라서는 기술지도도 병행한다. 생산공정 내의 불량이 발생할 경우 불량원인을 분석하고 문제점을 파악하여 조치한다. 각종 설비의 체크시트를 확인하고 설비의 조건을 파악하여 조치한다. 각종 관리도를 확인·점검하며 작업원들에게 안전교육을 실시한다. 작업 전·후 치구공 및 비품관리를 하며 월 또는 주 단위로 생산실적통계를 내기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","connectJob":"계측기기조립반장, 계측기기수리반장, 계측기기검사반장","certLic":"전기기능사, 전자기능사","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C272","dJobICdNm":"[C272]측정, 시험, 항해, 제어 및 기타 정밀기기 제조업; 광학기기 제외","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002499:1', '{"dJobCd":"K000002499","dJobCdSeq":"1","dJobNm":"계측기기조립원","workSum":"전압계, 전류계, 지시계, 오실로스코프(Oscilloscope), 이화학기기 등 각종 계측기기를 제조하기 위하여 수공구, 자동공구 및 설비를 사용하여 관련 부품을 조립한다.","doWork":"작업명세서에 따라 조립할 계측기기의 규격과 수량 등을 확인한다. 조립에 필요한 각 부품과 반제품의 수량을 확인하여 준비한다. 드라이버, 용접기, 검사지그 등의 공구 및 장비를 준비하여 작동 여부를 확인한다. 작업표준서 또는 회로도에 따라 기판에 부품을 순서대로 장착하고 디핑작업, 절단작업 등을 수행한다. 드라이버를 사용하여 제작, 조립된 회로기판을 내부몸체에 체결한다. 제품에 따라 부품접합 용접작업을 한다. 접착제 또는 리베팅 작업으로 문자판 또는 지시침을 부착한다. 최종조립에 들어가기 앞서 검사지그에 장착하여 검사를 실시한다. 컴퓨터 모니터를 통하여 검사결과를 파악하고 조치를 취한다. 검사가 끝나면 내부몸체를 외장케이스에 조립한다. 외장케이스와의 조립이 끝나면 외관에 필요한 각종 손잡이 등의 부품을 조립하고 조립완성품은 최종 품질검사를 위해 검사팀에 넘긴다. 계측기기에 따라 간단한 인쇄, 라벨부착, 포장업무를 수행하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C272","dJobICdNm":"[C272]측정, 시험, 항해, 제어 및 기타 정밀기기 제조업; 광학기기 제외","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005274:1', '{"dJobCd":"K000005274","dJobCdSeq":"1","dJobNm":"계측기기조정원","workSum":"전압계, 전류계, 지시계, 오실로스코프(Oscilloscope) 등 각종 계측기기와 표준기, 시험설비를 사용하여 제조된 계측기기를 검사·시험·조정한다.","doWork":"작업표준에 의하여 조정검사기준서 및 조정검사표준서를 준비하고 숙지한다. 조정검사에 필요한 표준기, 도구 및 장비를 준비하여 작동 여부를 확인한다. 시험, 조정할 계측기기의 종류에 따라 검사항목을 점검하고 검사기기 및 설비를 준비한다. 조립된 계측기기를 항온조설비에 일정 시간 담그거나 또는 시험 지그에 물려서 계측기기가 갖추어야 할 온도, 압력, 주파수 등이 허용오차 범위 내에 존재하는지를 표준기와 비교한다. 육안으로 표준기와 비교하거나 컴퓨터 프로그램을 이용하여 비교한다. 표준기에 나타난 수치 또는 모니터에 표시된 제품의 합격 여부에 따라 필요한 조정조치를 취하거나 다시 조립라인으로 되돌려 보낸다. 조정이 필요한 경우 계측기기를 표준기와 비교하면서 조정기를 조정한다. 합격된 제품은 시험성적서 또는 제품검사 체크리스트를 작성하여 품질보증 팀장의 승인을 받은 후 보관한다. 불합격된 제품에 대해서는 부적합보고서를 발행하고 부적합관리규정에 따라 폐기 또는 부품재활용으로 처리한다. 제품검사가 완료된 제품은 스티커 또는 적절한 방법으로 검사 및 시험상태를 식별한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"전자기능사","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C272","dJobICdNm":"[C272]측정, 시험, 항해, 제어 및 기타 정밀기기 제조업; 광학기기 제외","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003966:1', '{"dJobCd":"K000003966","dJobCdSeq":"1","dJobNm":"광디스크프레싱원","workSum":"스탬퍼(Stamper:압인기)를 사용하여 광디스크(CD, DVD)를 대량 복제한다.","doWork":"작업지시서를 확인하고 복제할 제품의 마스터링 스탬퍼(데이터가 입력된 니켈원판)를 수령한다. 프레싱장치의 이상 유무를 확인하고 원료(폴리카보네이트)의 수량을 확인한다. 프레싱장치의 금형에 스탬퍼를 장착한다. 용융된 원료(폴리카보네이트)를 금형에 고압으로 분사하여 투명한 디스크를 성형한다. 성형된 디스크를 건조시킨 다음 코팅기에 투입하여 알루미늄 반사막을 형성한다. 알루미늄 반사막 층을 보호하기 위하여 보호 래커를 도포하고 자외선 건조시킨다. DVD를 생산하는 경우 사출 성형된 디스크 두 장을 붙여 한 장의 DVD를 완성하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","connectJob":"CD프레싱원, DVD프레싱원","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C182","dJobICdNm":"[C182]기록매체 복제업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006641:1', '{"dJobCd":"K000006641","dJobCdSeq":"1","dJobNm":"광점퍼코드조립원","workSum":"광섬유와 광커넥터를 연결하여 광점퍼코드를 조립한다.","doWork":"작업지시서에 따라 광섬유(단일모드 또는 멀티모드 광섬유)를 준비한다. SC(Subscriber Connector or Square Connector), ST(Straight Tip), FC(Fiber transmission system Connector), LC(Lucent Connector) 타입의 커넥터 부품을 준비한다. 작업 공구를 사용하여 광섬유와 커넥터 부품을 연결하고 가공하여 광점퍼코드(Optical Connector, Optical Jumper Cord, 광커넥터, 광 점퍼코드, 광점퍼선, 광케이블커넥터 등)를 제작한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003767:1', '{"dJobCd":"K000003767","dJobCdSeq":"1","dJobNm":"광학용품조립원","workSum":"망원경·조준경 등의 광학기구를 수공구 및 자동공구를 사용하여 조립한다.","doWork":"작업명세서에 따라 조립할 광학용품의 규격과 수량, 조립방법 및 조립절차 등을 확인한다. 조립에 필요한 각 부품을 확인하여 준비한다. 초음파세척기, 진공집게도구, 렌치, 드라이버 등의 공구 및 장비를 준비하여 작동 여부를 확인한다. 초음파세척기, 압축공기를 사용하여 부분품 등의 이물질을 제거하고 세척한다. 렌즈부품을 진공집게기구를 사용하여 집어내고 광학용품 틀의 설치대에 놓는다. 부분품을 지정된 위치에 고정시키기 위하여 광학용품 틀에 고착링(Locking Ring)을 집어놓고 고정시키고 풀어지지 않게 링에 접착제를 바른다. 작업명세서에 따라 렌치와 드라이버를 사용하여 광학용품의 내부에 기계부품들을 조립한다. 광학용품의 내부표면에 부식영향을 줄이기 위하여 광학용품의 몸체에 질소가스를 채우기도 한다. 표준삼각법 공식을 계산하여 광학용품에서 시험표적을 오실로스코프 및 콜리미터(Collimeter) 등의 시험기구에 연결시킨다. 광학용품을 표적에 맞추고 눈금을 읽어 광학용품 렌즈의 광학상의 중심을 측정하고 특정한 초점배율을 확인한다. 정밀측정기구를 사용하여 광학부품 및 기구부품들을 측정하여 명세서와의 일치 여부를 확인한다. 검사 및 시험자료를 확인한다. 검사공장, 포장공정 등의 다음 공정으로 이송시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C273","dJobICdNm":"[C273]사진장비 및 광학기기 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004557:1', '{"dJobCd":"K000004557","dJobCdSeq":"1","dJobNm":"교류전동기조립원","workSum":"시방서에 따라 각 공정에서 조립된 보빈과 리드선, 브래킷, 회전자, 고정자, 슬립링 등을 결합하여 교류전동기를 조립·생산한다.","doWork":"작업표준에 따라 조립할 부분품을 확인한다. 권선기로 코일이 감겨진 보빈에 도면에 따라 리드선(Lead Wire:인입선)을 결속시키고 남땜과 튜브삽입을 하여 보빈조립을 완성한다. 회전자와 고정자를 프레스기로 압입하고 양쪽의 지지대 역할을 하는 브래킷을 자동체결기로 장착하여 전동기 본체를 조립한다. 조립이 완성되면 종합계측기기로 성능과 치수를 검사한다. 조립품의 결함 유무를 확인한다. 송풍기(Blower)와 외부케이스를 결합하여 최종 제품을 완성조립 한다. 완성된 제품은 다음 공정으로 이송시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"AC모터조립원","connectJob":"고정자조립원, 회전자조립원, BLDC모터제조원","certLic":"전기산업기사, 전기기기산업기사","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C281","dJobICdNm":"[C281]전동기, 발전기 및 전기 변환ㆍ 공급ㆍ제어 장치 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002248:1', '{"dJobCd":"K000002248","dJobCdSeq":"1","dJobNm":"기판적재원","workSum":"절연용액으로 도포·절단된 일정 크기의 인쇄회로용 기재를 지정매수로 적재하는 일을 한다.","doWork":"명세서와 작업지시서에 따라 적재할 수량과 작업방법을 숙지한다. 절연용액이 도포된 기재를 지정된 두께에 따라 작업대 위에서 일정 수량을 쌓는다. 적재된 기재 위에 얇은 구리판을 올려놓고 차기공정으로 보낸다. 측정기구를 사용하여 적재된 기재의 치수를 측정하기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001229:1', '{"dJobCd":"K000001229","dJobCdSeq":"1","dJobNm":"납땜수정원","workSum":"불합격된 인쇄회로 기판에 조립된 전자부품의 선을 절단하거나 납땜이 되지 않은 부위에 납땜을 하고 불량으로 판정된 기판을 모아 작업장소로 이동한다.","doWork":"작업지도표를 보고 공정의 위치를 확인한다. 자동으로 삽입되거나 검사과정에서 불합격된 인쇄회로 기판에 삽입되지 않은 콘덴서, 집적회로, 트랜지스터 등 전자부품을 삽입한다. 니퍼를 사용하여 절단되지 않은 기판이면 부위의 선을 절단하거나 납땜이 되지 않은 부위에 납땜공구를 사용하여 납땜한다. 완성된 기판을 검사지그에 올리고 계측기기를 사용하여 동작상태·기능상태 등을 파악하여 불량품을 선별한다. 오삽입·미삽입 등 잘못된 부품을 수정·땜납·삽입한 다음 전자부품을 자동으로 삽입하는 기계에서 잘못 삽입된 기판, 자동납땜공정에서 납땜되지 않은 기판, 검사공정에서 불합격된 기판, 수삽공정에서 불량으로 판정된 기판을 모아 작업장소로 이동한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"기판수리원, PCB후가공원, 리터치(Retouch)원","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002803:1', '{"dJobCd":"K000002803","dJobCdSeq":"1","dJobNm":"누전차단기조립원","workSum":"전류의 흐름을 제어하는 차단기 부품인 소호장치, 계폐기구, TRIP기구, 단자나사 부분 등의 테스트 기판·전자결합체·조작기판을 수동공구로 조립한다.","doWork":"작업명세서에 따라 조립한 제품의 부품을 확인한다. 조립에 필요한 작업공구를 준비한다. 조립공정 순으로 소호장치, 계폐기구, TRIP기구, 단자나사 부분 등의 테스트기판·전자결합체·조작기판을 수동공구로 조립한다. 검사기구를 사용하여 조립된 차단기를 검사하기도 한다. 수지케이스 하부에 누전차단기 단자를 조립하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"단자조립원","certLic":"전기산업기사, 전기기기산업기사","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C281","dJobICdNm":"[C281]전동기, 발전기 및 전기 변환ㆍ 공급ㆍ제어 장치 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004658:1', '{"dJobCd":"K000004658","dJobCdSeq":"1","dJobNm":"마스크가공반장","workSum":"컬러텔레비젼 수상관에 사용되는 마스크(mask)를 가공하는데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"생산계획에 따라 근무편성표를 작성하고 작업원에게 작업을 할당한다. 출근상황을 파악하여 관리부서에 보고한다. 개선제안 및 분임조 회합실적을 점검하고 결과를 상부에 보고한다. 생산실적을 분석하여 추이도를 작성하고 문제점 및 대책을 세운다. 일별 인원현황 및 작업시간보고서 등을 작성하고 원·부자재 입고계획 및 실적을 확인한다. 설비 및 생산에 대한 특성검사를 실시하거나 문제점을 파악하고 조치하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"마스크성형반장, 마스크조립반장","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2011"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004157:1', '{"dJobCd":"K000004157","dJobCdSeq":"1","dJobNm":"마스크가공원","workSum":"컬러텔레비전용 수상관에 사용되는 섀도마스크(shadow mask) 금속판을 가공하는 일을 한다.","doWork":"마스크 금속판의 내부응력을 제거하고 재질을 연화시키기 위하여 수소로를 일정한 온도까지 승온하고 가스·냉각수 등을 공급하며 마스크 투입에 사용되는 망사를 준비한다. 수소로로 이송되는 콘베이어 투입구에마스크를 망사 위에 올려 놓고 작업을 진행한다. 작업을 마친 마스크를 들어내고 성형상태를 검사한다. 묻어있는 기름불순물을 제거하기 위하여 약품처리 설비를 가동하거나 투입구와 출구에서 가공품을 올리거나 내린다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|다습|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"마스크세정원, 마스크소둔원, 마스크탈지원, 마스크프레스원, 마스크흑화로조작원, 패널투입원","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2011"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001375:1', '{"dJobCd":"K000001375","dJobCdSeq":"1","dJobNm":"막검사원","workSum":"브라운관 제조공정 중 패널마스크(panel mask)에 형성된 형광막을 검사한다.","doWork":"검사표·매직펜·아세톤·가제뭉치 등을 준비하고 조명등·현미경의 상태를 확인한다. 노광대의 계열번호를 확인하고 이송컨베이어를 통하여 이송되는 패널을 투광대에 올려놓는다. 패널의 외면을 가제와 아세톤으로 닦아준다. 현미경을 사용하여 스크린 결점규격에 의거 생산된 막 상태를 검사한다. 규격게이지를 사용하여 마스크의 규격을 검사하고 마스크부딪힘, 핀부딪힘, 찍힘 등을 검사한다. 마스크를 손으로 잡고 요철검사를 한다. 양품패널의 측면에 계열번호를 적고 이송컨베이어에 올려놓는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"투입인출","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2011"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006669:1', '{"dJobCd":"K000006669","dJobCdSeq":"1","dJobNm":"무전기조립원","workSum":"각종 전자부품이 조립된 인쇄회로기판을 일정 모양으로 사출·성형된 케이스에 조립한다.","doWork":"회로기판과 전자부품으로 결선·납땜·조립된 부품에 절연재베이스를 부착시킨다. 작업지시서에 따라 인쇄회로기판과 기타 부품들을 성형된 케이스(무전기 몸통)에 삽입하고 드라이버를 사용하여 나사로 조인다. 각종 계측기기를 사용하여 성능검사를 작업지시서에 따라 수행한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C264","dJobICdNm":"[C264]통신 및 방송 장비 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004444:1', '{"dJobCd":"K000004444","dJobCdSeq":"1","dJobNm":"문자판제조현장감독자","workSum":"시계문자판 제조공정에 관여하는 타발(打拔), 시자(時字, Index), 삽입, 용접, 광택, 도금, 인쇄, 도장하는 작업원의 활동을 감독·조정한다.","doWork":"문자판 제조공정, 문자판 부품 및 문자판기능 등의 문자판 전반에 관한 지식과 내용을 숙지한다. 생산량, 시간계획 등을 수립하여 문자판제조 계획에 따라 작업원을 적정하게 배치한다. 생산계획에 따른 작업계획을 수립하고 부품을 불출한다. 각 제조공정을 관리·감독하며 때에 따라서는 기술지도도 병행한다. 사양서 및 도면을 보고 공정표, 시방서를 만들어 작업계획을 세운다. 제품수량 및 품질을 점검하고 공정진행전표를 확인·점검·기록한다. 문자판기준도를 참조하여 검사표를 작성하여 각 수행하는 직무에 관하여 감독한다. 수행하는 직무에 관하여 훈련을 시키고 공급품 및 재료를 청구한다. 부서 상호 간 원활한 작업흐름을 위해 각 작업반장들과 협의한다. 작업원들과의 협의를 통해 고충문제를 처리하며 각 기계 및 기계장치를 설치·관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","similarNm":"문자판제조반장","connectJob":"문자판식자반장, 문자판프레스반장, 문자판도금반장, 문자판조립반장","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C274","dJobICdNm":"[C274]시계 및 시계부품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005886:1', '{"dJobCd":"K000005886","dJobCdSeq":"1","dJobNm":"문자판조립원","workSum":"연마기, 용접기, 프레스 등을 이용하여 타공·용접·부착·광택·연마작업을 하여 시계의 문자판을 제조한다.","doWork":"작업지시서와 명세서에 따라 제조할 문자판을 확인하고 작업 전 도면을 파악한다. 작업을 하기 위해 연마기, 용접기, 프레스, 접착제, 도금기 등의 장비와 공구를 준비하고 작동 여부를 확인한다. 수동공구 및 프레스를 사용하여 문자판 재료를 자른 후 족부기 및 용접기구로 문자판에 지지다리를 부착한다. 연마기를 사용하여 문자판에 광택을 내고 금, 은, 니켈 등을 문자판에 도금한다. 도금된 문자판에 숫자 또는 숫자표시를 접착제를 사용하여 부착한다. 문자판에 무늬·숫자·회사명을 인쇄하기도 한다. 문자판의 오염, 긁힌 자국, 인쇄된 무늬의 상태 및 치수 등이 명세서와 일치하는가를 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C274","dJobICdNm":"[C274]시계 및 시계부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001522:1', '{"dJobCd":"K000001522","dJobCdSeq":"1","dJobNm":"문자판타공원","workSum":"시자(時字, Index) 및 시침, 분침을 심기 위하여 탁상프레스 또는 밀링프레스를 조작하여 문자판에 구멍을 뚫는 작업을 한다.","doWork":"작업명세서에 따라 시자(時字, Index) 및 시침, 분침을 심기 위하여 타공할 문자판의 규격, 수량 등을 파악하고 탁상프레스 또는 밀링프레스(Milling Press) 등 장비의 윤활장치, 연료 등을 점검한다. 탁상프레스에 금형을 고정시킨 후 핀셋을 이용하여 문자판을 금형에 넣는다. 밀링프레스를 조작하여 문자판에 구멍을 뚫는다. 인덱스를 심기 위한 공명 위치 거리를 확대경 및 측정기를 이용하여 수시로 확인하고 작업 부위의 매끈함 여부를 확인한다. 제품에 따라 금형을 교체하기도 한다. 기계를 점검하거나 주유작업 등의 작업을 하여 기계장비를 유지보수한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"문자판공명원, 타공기조작원","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C274","dJobICdNm":"[C274]시계 및 시계부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007389:1', '{"dJobCd":"K000007389","dJobCdSeq":"1","dJobNm":"박막트랜지스터검사원","workSum":"TFT(Thin Film Transistor:박막트랜지스터)제조공정에서 단위공정의 완성도, 전기적 특성, 화학적 특성 등을 검사하여 이상 유무를 파악하고 각종 조치를 한다.","doWork":"제조 공정에서 단위 공정의 완성도를 확인하기 위하여 제품의 전기적·광학적 특성을 측정한다. 현미경 등 각종 측정장비를 사용하여 박막의 증착 두께, 식각 두께의 평가, 패턴(Pattern) 형성 확인, 전기적 특성을 검사하고 기록한다. 액정주입이 완료된 패널에 화상신호를 인가하여 불량검사를 한다. 모듈공정의 백라이트 부품 조립 후 기본적인 검사를 하고, 일정 시간의 에이징(Aging)을 거친 후 최종검사를 하여 포장 및 출하 공정으로 보낸다. 불량 여부의 원인 규명, 생산비 절감과 품질 향상을 위해 관련 부서에 검사결과를 통보하고 의견을 제출한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"투입인출","similarNm":"TFT검사원, 티에프티검사원","certLic":"전기기능사, 화학분석기능사","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003383:1', '{"dJobCd":"K000003383","dJobCdSeq":"1","dJobNm":"박막트랜지스터모듈조립원","workSum":"편광필름이 부착이 된 상하판에 TAB(Tape Automated Bonding)을 부착하고 구동회로(Driving IC)를 실장(實裝, Mounting)하며 PCB(Printed Circuit Board) 조립과 백라이트 부분을 연결하여 박막트랜지스터모듈을 완성한다.","doWork":"편광판이 부착이 된 패널을 이동시킨다. PCB회로를 연결하기 위해 자동으로 테이프를 본딩하는 TAB(Tape Automated Bonding)을 부착한다. TAB을 부착한 후 고온과 고압의 탈포공정을 통해 밀착성을 높인다. 만들어진 TAB에 PCB 기판을 부착하고 구동평가를 실시한다. 만들어진 기판에 백라이트 부분(BLU:Back Light Unit)을 조립한다. 만들어진 제품에 대한 기본적인 검사를 하고 에이징을 거친 후 최종검사를 하도록 TFT(Thin Film Transistor) 검사공정으로 이동시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"TFT모듈조립원, 티에프티모듈조립원","certLic":"전기기능사","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005309:1', '{"dJobCd":"K000005309","dJobCdSeq":"1","dJobNm":"박막트랜지스터세정원","workSum":"증착과정을 통해 만들어진 컬러필터와 TFT 글라스의 이물질을 제거하고 박막의 접착력 강화를 위한 초기세정과 현상, 식각, 박리 공정에서 세정 작업을 한다.","doWork":"클린룸에 입장하기 위하여 방진복을 착용한다. 세정을 시키고자 하는 목적에 따라 물리적 세정, 화학적 세정, 건식 세정으로 나누어 각각의 세부적인 세정방법을 적용한다. 세정기기의 컨트롤 패널에 작업을 위한 각종 정보를 입력한다. 이때 서브 픽셀의 크기가 매우 작아 작은 먼지에도 불량 화소가 발생할 수 있는 특징을 감안하여, 세밀하게 세정기기를 작동시킨다. 세정이 완료된 컬러필터와 TFT 글라스를 일정 시간 건조시킨 후 다음 공정으로 이동시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"TFT세정원, 티에프티세정원","certLic":"전기기능사, 화학분석기능사","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002723:1', '{"dJobCd":"K000002723","dJobCdSeq":"1","dJobNm":"박막트랜지스터편광판부착원","workSum":"세정작업이 완료된 패널의 상하단에 편광필름(Polarizer Film)을 부착한다.","doWork":"확대경이나 비주얼 테스트(육안검사)를 통해 세정작업이 마쳐진 액정패널의 상하판 상태를 점검한다. 이상이 없으면 상단과 하단의 편광판을 90°로 교차되도록 하여 각각에 편광필름(Polarizer Film)을 부착한다. 편광필름이 부착이 된 패널에 TAB(Tape Automated Bonding)을 부착하기 위한 다음 모듈공정으로 패널을 이동시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"TFT편광판부착원, 티에프티편광판부착원","certLic":"전기기능사","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005570:1', '{"dJobCd":"K000005570","dJobCdSeq":"1","dJobNm":"반도체장비전장조립원","workSum":"반도체장비의 전장설계 도면을 기준으로 전원소자와 배선을 결정하고, 전기안전, 전원 용량 및 품질을 고려한 배선 등급을 결정하여 전장배선 작업을 수행한다.","doWork":"반도체장비 전장도면에 근거하여 전원사양에 적합한 배선을 준비하고, 배선 도면을 보고 실제 각 성능과 공급된 전원 사양을 고려하여 전원배선 순서도에 따라 배선작업을 준비한다. 전장배선 형태, 길이를 결정하고, 전원배선 순서도를 기준으로 위험상황을 고려한 전원배선 작업을 실시해야 하며, 전원 용량 및 품질을 고려한 배선 등급을 결정하여 실제 배선작업을 실시한다. 부가 장착되는 중요 제어기, 하드웨어, 별도 장치의 전원 특성을 이해하고, 관련 전원배선을 파악한 다음, 최적의 배선작업을 수행한다. 반도체장비 전기안전 관련 KS, CE, S-Mark 표준 등을 이해하며, 장비운영에 큰 영향을 주는 노이즈, 급속 정지 등 뷸규칙 장비 동작을 고려하여 배선·전원 품질을 관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","certLic":"반도체설비보전기능사","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002607:1', '{"dJobCd":"K000002607","dJobCdSeq":"1","dJobNm":"발광관조립원","workSum":"고압나트륨 전구·메탈할라이드 전구(금속 증기의 혼합체와 할라이드 계통 원소(나트륨, 탈륨, 황 등)의 분리에서 발생하는 복사열이 가시광을 발생시키는 고압방전 등)와 같은 고압방전 등에 사용되는 발광관을 조립한다.","doWork":"용접기구를 사용해서 전극과 도입선을 용접해서 부착시킨다. 튜브삽입기를 사용해서 석영유리에 튜브를 삽입하고 도입선이 부착된 전극과 석영유리를 결합시킨다. 배기기를 사용해서 발광관 내부의 공기와 불순물을 제거하고 메탈할라이드(Metal Halide), 수은, 아르곤 등이 일정한 비율로 혼합된 가스를 주입한다. 제조된 발광관의 외관, 치수 등을 검사한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"뇌관조립원","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C284","dJobICdNm":"[C284]전구 및 조명장치 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002438:1', '{"dJobCd":"K000002438","dJobCdSeq":"1","dJobNm":"발전기조립원","workSum":"정류기, 브러시, 베어링, V 벨트풀리, 팬, 고정자(전기자), 회전자 등을 권선 및 함침하고 프레임에 장착하여 발전기 동체를 조립한다.","doWork":"작업표준에 따라 조립할 부분품을 확인한다. 동적평형기를 사용하여 회전자의 균형상태를 확인하며 불균형 문제가 발견되면 무게가 무겁거나 가벼운 부분을 가공하여 균형상태를 맞춘다. 철심, 코일, 축, 슬립링으로 구성된 로터를 조립한다. 각종 수공구와 용접기, 드릴링기 등을 사용하여 로터, 스테이터, 정류기, 브러시, 베어링, V 벨트풀리, 팬 등을 조립한다. 가공 및 제작이 끝난 각 부분품을 조립하고 배선작업을 한다. 엔진과 방열기(Radiator), 제어반 등을 부착한다. 케이스를 결합하여 최종 제품을 완성 조립한다. 전압계와 전류계로 성능 및 특성을 시험하고 시험이 끝나면 도장을 한다. 완성된 제품은 다음 공정으로 이송시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"고정자조립원, 회전자조립원, 동적평형기조작원","certLic":"전기산업기사, 전기기기산업기사","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C281","dJobICdNm":"[C281]전동기, 발전기 및 전기 변환ㆍ 공급ㆍ제어 장치 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002828:1', '{"dJobCd":"K000002828","dJobCdSeq":"1","dJobNm":"발전용연료전지스택모듈조립원","workSum":"연료전지 셀과 부속품을 조립하여 발전용 연료전지스택(Stack)모듈을 조립한다.","doWork":"발전용량에 따른 연료전지스택(Stack)모듈의 제조를 위해 제조에 필요한 자재를 준비한다. 스택의 바닥에 위치하는 전극판을 조립대에 고정시킨다. 단전지로 구성된 셀패키지를 적층한다. 적층이 완료되면 스택의 상부에 위치하는 전극판을 설치하고 가압자재를 이용하여 고정한다. 제작된 스택을 모듈 베이스에 옮겨 장착한다. 장착 후 모듈 내부를 구성하는 배관 및 계측장치를 연결한 후 모듈 외함을 크레인을 이용하여 장착한다. 완료된 스택모듈을 컨디셔닝공정으로 이송한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C282","dJobICdNm":"[C282]일차전지 및 축전지 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006597:1', '{"dJobCd":"K000006597","dJobCdSeq":"1","dJobNm":"방송통신기기제작원","workSum":"제작회로 도면에 따라 오실로스코프·납땜공구 등을 사용하여 중파·단파 등의 송신기기를 제작한다.","doWork":"설계된 회로도에 따라서 다이오드·저항·콘덴서·트랜지스터·집적회로(IC) 등 각종 부품을 인쇄회로기판의 지정된 위치에 삽입한다. 조립된 인쇄회로기판 부품을 측정기기를 사용하여 작업지시서에 따라서 측정기기를 사용하여 조립된 인쇄회로기판부품의 납땜불량·부품불량·특성정도 등을 확인한다. 회로도에 따라 용량에 적합한 전선을 부품과 부품의 단자 사이에 니퍼·압착기·납땜인두 등 공구를 사용하여 배선한다. 회로시험기를 사용하여 각 부품들 사이에 회로도에 따라 맞게 배선되었는지 단락상태를 점검한다. 각종 측정장비를 사용하여 조립된 송신기기의 출력·주파수·신호의 왜곡률 등의 특성을 작업지시서에 따라 검사한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"송신기기제작원, 수신기기제작원","certLic":"무선설비기능사","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C264","dJobICdNm":"[C264]통신 및 방송 장비 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002160:1', '{"dJobCd":"K000002160","dJobCdSeq":"1","dJobNm":"배전반조립원","workSum":"부품배치 및 배선 설계도에 따라 배전반을 조립하고 전기적인 기능을 검사·조정한다.","doWork":"도면 및 작업표준에 따라 각 부분의 작업공정계획을 계산한다. 부품의 배치 및 배선을 표시하는 설계도에 따라 수공구를 사용하여 각종 부품과 주기기를 조립하고 배선한다. 진공차단기, 진공접촉기, 보호릴레이, 전류 및 전압변성기, 퓨즈, 모듈카드 등의 각 부분별로 공정 순서에 따라 수공구 및 작업기계 등을 사용하여 제작한다. 철판을 절단하고 펀칭, 용접, 도장(Painting) 등의 공정을 거쳐 배전반 외함(Case)을 만든다. 전기적인 기능 및 성능을 검사·조정한다. 시운전을 통하여 기계의 작동 여부를 검사한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"전기산업기사, 전기기기산업기사","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C281","dJobICdNm":"[C281]전동기, 발전기 및 전기 변환ㆍ 공급ㆍ제어 장치 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004975:1', '{"dJobCd":"K000004975","dJobCdSeq":"1","dJobNm":"배전용변압기조립원","workSum":"작업표준에 따라 건식, 유입식, 몰드 변압기 등 배전용으로 사용되는 변압기의 철심과 코일을 조립하고 각종 부분품을 부착하여 조립한다.","doWork":"작업표준에 따라 조립할 부분품을 확인·검사한다. 성능이 우수한 방향성규소강판(철에 수%의 규소를 가한 규소강을 냉간 압연한 후 고온으로 어닐링한 강판)을 이용하여 5Step Lap가공방법으로 철심을 제작한다. 소둔공정을 통해 철심의 형태가 유지되면 끈을 풀어준다. 도전성이 우수한 도체로서 기계적 전기적 성능이 우수한 에폭시 수지(Epoxy Resin)로 진공주형하여 단락 기계력과 절연성이 우수한 고압코일(1차코일)과 Sheet 도체와 Pre-preg 절연지로 권선한 저압코일(2차코일)을 제작한다. 권선공정을 거친 코일의 절연성을 강화시키기 위해 진공상태에서 바니시(Varnish) 함침기에 일정 시간 동안 담근 후 건조로에서 건조시킨다. 조립대에서 코일과 철심(코어)을 결합시키고 철바인딩기로 코어조임쇠를 체결한다. 변압기의 종류에 따라 절연유를 주입하기도 한다. 용접기와 수공구를 사용하여 명판, 부싱(애자), 터미널, 외함 등의 부분품을 부착하여 완성·조립한다. 조립이 완성되면 종합계측기기로 성능과 치수를 검사한다. 조립품의 결함 유무를 확인한다. 완성된 제품은 다음 공정으로 이송시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"건식변압기조립원, 유입식변압기조립원, 몰드변압기조립원","certLic":"전기산업기사, 전기기기산업기사","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C281","dJobICdNm":"[C281]전동기, 발전기 및 전기 변환ㆍ 공급ㆍ제어 장치 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005502:1', '{"dJobCd":"K000005502","dJobCdSeq":"1","dJobNm":"배전장치제조현장감독자","workSum":"각종 전기·전자제품 및 운송장비에 장착되는 배전장치 및 절연코드 세트를 가공·조립하는 작업원의 활동을 감독·조정한다.","doWork":"작업명세서를 숙지하고 조립할 전선의 특성과 부품의 종류를 확인한다. 자동압착절단기·중간탈피기·결속기(조인트기) 등의 기계를 점검·관리한다. 컨베이어벨트의 속도를 조정하고 공정 간에 작업원을 배치한다. 원활한 작업진행을 위해 작업원의 활동을 감독·조정하고 기술적인 직무를 수행하거나 지도한다. 작업 중 위험을 방지하고 불량감소를 위해 작업원을 교육한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"수동조작","similarNm":"절연코드세트제조반장, 배전장치제조반장","connectJob":"모니터배전장치제조반장, 자동차배전장치제조반장","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005256:1', '{"dJobCd":"K000005256","dJobCdSeq":"1","dJobNm":"배전장치조립원","workSum":"조립기구들을 사용해서 자동차 및 가전제품에 장착되는 배전장치 및 전선부품을 조립한다.","doWork":"반제품 절연코드세트와 전선부품이 도착하면 컨베이어벨트의 작업대 옆에 적재한다. 컨베이어벨트를 가동시킨다. 작업지시서에 따라서 절연전선을 조립하고 조립된 배선장치를 테이프로 감아서 고정시킨다. 외관검사를 하고 이상이 발견될 경우 테이프 등으로 수정·보완하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"절연코드세트조립원","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006498:1', '{"dJobCd":"K000006498","dJobCdSeq":"1","dJobNm":"변성기조립원","workSum":"권선기를 사용하여 전압발생코일을 감고 치공구 및 각종 장비를 사용하여 변성기를 조립·검사한다.","doWork":"작업표준에 따라 조립할 부분품을 확인·점검한다. 권선기로 코일이 감겨진 보빈에 도면에 따라 리드선(인입선)을 결속시키고 납땜 기계를 사용하여 다이오드, 저항, 인덕터 등을 삽입하고 보빈 조립을 완성한다. 같은 방식으로 저전압발생 코일을 조립한다. 고전압 및 저전압 권선조립품을 결합하고, 케이스 삽입기를 사용하여 케이스를 부착한다. 조립공정을 마친 제품을 에폭시(Epoxy) 주입설비에 투입하고 주입공정과정에서 불량이 발생하는 제품을 육안으로 구별해 낸다. 외관검사를 실시하고 계측기기를 사용하여 용량이나 저항과 같은 성능검사를 실시한다. 완성된 제품은 다음 공정으로 이송시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"전기산업기사, 전기기기산업기사","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C281","dJobICdNm":"[C281]전동기, 발전기 및 전기 변환ㆍ 공급ㆍ제어 장치 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005113:1', '{"dJobCd":"K000005113","dJobCdSeq":"1","dJobNm":"보청기검사원","workSum":"보청기가 명세서에 맞게 제조되었는지를 검사하기 위하여 검사장비를 사용하여 검사한다.","doWork":"주문서에 의하여 제품의 기종과 특성을 파악하고 검사항목을 확인한다. 그에 따른 검사기준서 및 검사표준서를 준비하고 숙지한다. 검사에 필요한 RTA(Real-Time Analyser) 측정장비를 준비하고 이상 유무를 점검한다. 이상이 있거나 초기에 선정한 보청기의 특성에 맞지 않을 경우에는 보청기 내부에 이물질이 끼어 있는지 혹은 납땜이 불량인지 재검사한다. 외형적으로 이물질 및 흠집이 없는지 검사한다. 보청기제조에 문제가 있을 경우에는 제조공정으로 되돌려 보낸다. 검사가 완료된 보청기는 주문한 병원이나 각 대리점, 소비자에게 이송된다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C271","dJobICdNm":"[C271]의료용 기기 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002331:1', '{"dJobCd":"K000002331","dJobCdSeq":"1","dJobNm":"보청기조립원","workSum":"납땜기, 핸드피스(Hand Piece), 연마기 등을 사용하여 보청기를 제조하기 위하여 귓본인 셀(Shell)과 전기부품인 키트(Kit)를 조립한다.","doWork":"작업명세서에 따라 조립할 보청기의 종류와 수량 등을 확인한다. 조립에 필요한 각 부품의 수량을 확인하여 준비한다. 납땜기, 핸드피스, 현미경, 연마기 등의 공구 및 장비를 준비한다. 연마기를 이용하여 셀의 밑면을 고르게 하고 핸드피스를 이용하여 외형을 다듬는다. 강도를 유지하면서 셀의 내부를 넓게 하기 위하여 핸드피스로 내부를 고르는 작업을 수행한다. 순간접착제 또는 초음파접착제를 사용하여 전기부품인 키트와 접착한다. 셀과 기판이 조립되면 커팅기를 사용하여 기판의 불필요한 부분을 자른다. 쉘과 기판의 이음새 부위와 셀을 연마기를 사용하여 거친 면이 없도록 연마한다. 조립된 보청기 전체에 코팅액을 바르고 건조시킨다. 조립이 완성된 보청기를 검사를 위해 보청기검사원에게 이송시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C271","dJobICdNm":"[C271]의료용 기기 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007378:1', '{"dJobCd":"K000007378","dJobCdSeq":"1","dJobNm":"비디오드럼조립원","workSum":"비디오의 부품인 드럼을 조립하는 일을 한다.","doWork":"지그를 이용하여 상하부 하우징에 베어링을 압입하고 프랜지(flange)를 조립한다. 드라이버를 사용하여 관련부품을 조립한다. 드럼에 홀더를 체결하고 유동이 있는지 확인한다. 상부드럼과 하부드럼 조립품을 서로 조립하고 상부드럼을 회전시켜 하부드럼 상단에 맞닿는지 확인한다. 측정기를 사용하여 조립완성된 드럼 조립품의 상부 헤드드럼의 상하좌우 방향의 흔들림 정도를 측정한 후 허용한계 범위 내에 있는지 확인한다. 프랜지(flange)에 연결된 리드선(lead wire)을 기판에 납땜한다. 하부드럼에 드럼모터를 체결하고 칩(chip)·불순물 등 각종 이물질을 천으로 제거한다. 완성된 드럼조립품을 일정 시간 회전시켜 이상이 없는지 점검한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"비디오드럼에이징원","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C265","dJobICdNm":"[C265]영상 및 음향기기 제조업","inqYear":"2011"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005658:1', '{"dJobCd":"K000005658","dJobCdSeq":"1","dJobNm":"비디오시험원","workSum":"제조공정 중에 제품의 외관검사·동작검사 혹은 비디오측정방법 및 시험업무에 관한 지식을 이용하여 비디오제품이나 반제품을 시험한다.","doWork":"조립공정 중에 조립된 비디오 세트의 외관상 이상 유무, 재생속도, 점등상태 등을 확인하고 조정장치를 가변하며 화질상태를 관찰하여 상떨림, 노이즈(noise)상태 등을 검사한다. 검사도구를 사용하여 모터내의 이물삽입,상하부 드럼의 접촉 등의 불량을 점검한다. 영상재생상태를 육안으로 관찰하여 불량을 검사한다. 헤드드럼에 부착된 헤드의 돌출부분·높이 등을 측정기기를 사용하여 측정한다. 이물질이 있는지 검사하고 모델별로 구분하여 포장상자에 담은 후 생산수량을 기록한다. 소리를 계측기기로 측정하거나 청취하여 장음이나 떨림음이 나는지 알아내고 규격과 일치하는지 확인한 후 다음 공정으로 보낸다. 혹은 각종 시험장비와 계측기기를 사용하여 일반동작 및 성능, 감승전압, 온도상승, 정전기, 리모콘동작 등 일반시험을 실시한다. 적응환경에 따른 고온동작, 저온동작, 보존정도 등 환경시험을 한다. 계측기기를 사용하여 소비전력을 측정하고 내압·절연·저항을 점검·시험한다. 외관구조, 조정성확인, 휴즈단락, 진동, 낙하 등의 정밀분석시험을 실시한다. 시험자료를 정리·계산하고 품질평가회의를 주관한다. 견본제품의 이력을 관리하고 구매자 요구별 하자사항에 대하여 자료를 관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"수집","workFunc2":"감독","workFunc3":"제어조작","similarNm":"VTR시험원","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C265","dJobICdNm":"[C265]영상 및 음향기기 제조업","inqYear":"2011"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002888:1', '{"dJobCd":"K000002888","dJobCdSeq":"1","dJobNm":"비디오조립반장","workSum":"비디오를 조립·제작하는데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"제품모델별 규격 및 사양을 숙지하고 비디오 조립에 필요한 자재의 수량을 파악하여 부족분을 보충한다. 표준테이프나 파손 및 불량한 공구·설비를 파악하여 수리·교환·요청한다. 작업내용에 따라 작업원에게 지시·배치한다. 작업의 진행사항을 파악하고 작업내용을 보고한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원 및 자재를 공급한다. 작업계획에 따라 세부실행항목을 수립하고 작업절차 및 방법을 결정하여 작업원에게 작업내용을 지시하고 작업배치를 한다. 표준작업명세에 따라 지시된 작업이 이루어지는지 작업원과 함께 작업하며 작업상황을 관찰하고 작업내용을 점검한다. 작업원의 직무교육 및 안전위생 교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴·해결하고 문제점을 보완한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"VTR조립반장","certLic":"전자기능사","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C265","dJobICdNm":"[C265]영상 및 음향기기 제조업","inqYear":"2011"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004895:1', '{"dJobCd":"K000004895","dJobCdSeq":"1","dJobNm":"비디오조립원","workSum":"비디오 제조공정 중 덱(deck)·선·휴즈 등을 조립하고, 조립과 조정된 반조립품에 외관 자재를 체결한다.","doWork":"전동드라이버를 사용하여 각종 부품 및 부분품들을 나사로 체결한다. 전선을 정리하여 고리를 꽂고 묶는다. 정격전압에 적합한 휴즈를 삽입하고 케이스의 체결 및 탈락을 방지하기 위해 접착제를 칠한다. 비디오 카세트 도어에 스프링을 걸어 케이스에 체결한다. 전동드라이버를 사용하여 전면 패널을 체결한다. 전동드라이버를 사용하여 덱(deck)의 단자와 접지가 되는지 확인하고 버텀커버(buttom cover)를 체결한다. 알콜을 사용하여 드럼을 세척하고 구조검사를 실시한 후 톱 케이스(top case)를 씌운다. 각종 라벨을 부착한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"VTR조립원","connectJob":"비디오케이스공정원, 비디오포선작업원, 비디오덱조립원, 비디오섀시공정원, 비디오드럼조립원","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C265","dJobICdNm":"[C265]영상 및 음향기기 제조업","inqYear":"2011"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007168:1', '{"dJobCd":"K000007168","dJobCdSeq":"1","dJobNm":"사무용기기부품조립원","workSum":"작업지시서에 따라 수동공구, 전동공구 등의 각종 공구를 사용하여 사무용기기 부품을 결합, 연결, 삽입하여 각종 부분품을 조립한다.","doWork":"부품들을 고정시키거나 서로 맞추고 렌치, 집게, 드라이버 등의 각종 공구를 사용하여 부품들을 서로 조이고 결합한다. 부품들을 서로 결합하여 움직여 보면서 적절한 기능을 발휘하는가를 시험해 본다. 밀봉접착제를 사용하여 조여진 나사가 풀리지 않도록 한다. 상대운동을 하는 부분에 윤활유를 공급한다. 각도기나 게이지 등을 사용하여 부품들이 굽힘상태, 각도, 간격 등을 확인한다. 제품의 모델과 사양에 맞게 제작되었는지 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"사무용기계부품조립원, 사무용기부품조립원","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C291","dJobICdNm":"[C291]일반 목적용 기계 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006521:1', '{"dJobCd":"K000006521","dJobCdSeq":"1","dJobNm":"사무용기기조립원","workSum":"수동공구, 전동공구, 조립고정구, 시험기구 등의 각종 공구를 사용하여 복사기, 팩시밀리 등의 사무용기기를 조립한다.","doWork":"부분조립이 끝난 부품들을 설계도면에 맞게 조립설비에 배치한다. 드라이버, 렌치, 전동스크루드라이버 등의 수동 및 자동공구를 사용하여 부품들을 서로 맞추어 기계의 골격(Frame)에 붙이고 나사 등의 결합부품으로 부품들을 결합한다. 조립된 부품 또는 기계를 작동시키고 수동측정기, 고정게이지와 시험기구를 사용하여 조립제품이 도면과 일치하는가를 확인한다. 조립된 제품이 정상적으로 작동하는지를 검사한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"사무용기조립원","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C291","dJobICdNm":"[C291]일반 목적용 기계 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003197:1', '{"dJobCd":"K000003197","dJobCdSeq":"1","dJobNm":"사무용기기조립현장감독자","workSum":"복사기·팩시밀리 등의 사무용기기 제품을 조립하는 공정에 종사하는 작업원의 활동을 감독·조정한다.","doWork":"공정표·설계도면·제조규격에 따라 작업지시서를 확인하고 작업원의 작업을 지시한다. 제품에 결함이 있는 부품들을 검사하고 작업물류를 조절한다. 정밀측정기구를 사용하여 부품의 치수를 확인하고 불량품을 해당 작업장으로 반송지시한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"수동조작","similarNm":"사무용기조립반장, 사무용기기조립반장","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C291","dJobICdNm":"[C291]일반 목적용 기계 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001741:1', '{"dJobCd":"K000001741","dJobCdSeq":"1","dJobNm":"사진기검사원","workSum":"명세서와의 일치 여부를 확인하기 위해 각종 검사장비를 사용하여 조립된 사진기의 기능, 외관, 조립, 부품검사 등을 한다.","doWork":"검사장비의 이상 유무를 파악하고 검사규정을 숙지한다. 조립된 사진기의 외관을 육안으로 관찰하여 흠집, 빠진 부품, 잘못된 일련번호 등을 검사한다. 사진기의 주요 구성 항목(디지털 이미지 센서, 미러, LCD패널, 광학식 뷰파인더, 내장플래시, 모드다이얼, 기타 전자장비 등)을 각종 검사장치가 설치된 지그에 고착시켜 기능검사를 한다. 디지털센서 관련 검사기로 CCD(Charge-Coupled Device), CMOS(Complementary Metal Oxide Semiconductor) 등의 디지털 이미지 센서를 검사하고 전원을 연결하여 LCD패널의 작동 여부, 모드다이얼별 작동 여부, 기타 전자부품 등을 검사한다. 검사 중 문제가 발견되면 처리 가능한 부분은 직접 처리하고 그렇지 않은 경우 관련 전 공정으로 돌려보내거나 사진기수리원에게 통보한다. 일부 검사는 조립라인에서 사진기조립원에 의해서 직접 수행되기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"카메라검사원","connectJob":"대상에 따라 아날로그카메라검사원, 디지털카메라검사원","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C273","dJobICdNm":"[C273]사진장비 및 광학기기 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001343:1', '{"dJobCd":"K000001343","dJobCdSeq":"1","dJobNm":"사진기제조현장감독자","workSum":"사진기를 제조하는 데 종사하는 조립원, 검사원, 수리원의 활동을 감독·조정한다.","doWork":"사진기 제조공정, 사진기 각 부품, 성능 및 기능 등의 사진기 전반에 관한 지식과 내용을 숙지한다. 작업표준서에 의해 생산량, 제조품목, 시간계획 등을 수립하고 작업체크표에 따라 제조원들이 지켜야 할 사항을 준수하는지 여부를 점검한다. 일별 계획된 정상적인 생산 활동의 유지와 개선을 수행하고 작업원에게 업무에 필요한 작업지도를 한다. 작업개선에 관계되는 개선제안을 수렴한다. 일상 점검 및 조정의 확인과 지도를 하며 수시로 가동률을 파악한다. 업무에 대하여 안전한 작업방법을 준수시킨다. 작업 전·후 치구공 및 비품관리를 하며 월 또는 주 단위로 생산실적 통계를 내기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","similarNm":"카메라제조반장, 사진기제조반장","connectJob":"사진기조립반장, 사진기검사반장, 사진기수리반장","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C273","dJobICdNm":"[C273]사진장비 및 광학기기 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005689:1', '{"dJobCd":"K000005689","dJobCdSeq":"1","dJobNm":"사진기조립원","workSum":"수동 및 자동공구, 납땜용공구, 공기청소기, 진동기 등을 사용하여 본체바디(Body)에 디지털 이미지 센서, LCD패널, 미러, 내장플래시, 렌즈마운트, 부품, 광학식 뷰파인더, 기타 전자부품 등을 조립한다.","doWork":"작업명세서를 보고 조립공정을 숙지하고 조립 도구 및 공구를 준비·점검한다. 미세한 먼지도 들어가면 안 되기 때문에 클린룸에서 조립되는 디지털이미지 센서(CCD, CMOS)의 모듈부품을 비롯 각 부품들을 수령하고 부품들의 합격, 불합격 여부를 점검한다. 해당 부품을 조립순서에 따라 나사체결작업, 끼워맞춤, 납땜작업, 전기배선작업 등을 통하여 본체에 고정·부착시킨다. 규격대로 기능이 작동되는지를 각종 시험지그를 통하여 검사하거나 건전지를 직접 장착하여 작동 여부를 검사한다. 검사 시 발견되는 문제점을 해결하거나 해결하지 못하는 부분은 사진기수리원에게 전달한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"카메라조립원","connectJob":"대상에 따라 아날로그카메라검사원, 디지털카메라검사원","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C273","dJobICdNm":"[C273]사진장비 및 광학기기 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004154:1', '{"dJobCd":"K000004154","dJobCdSeq":"1","dJobNm":"사진장비조립원","workSum":"영사기, 프로젝터, 인화기, 마이크로필름 장비 등 사진장비를 수동·자동공구를 사용하여 조립하고 조정한다.","doWork":"작업지시서에 따라 제조할 영사기, 프로젝터, 인화기 등의 사진장비의 규격과 제조방법, 작업순서 등을 확인한다. 제조에 필요한 각 부품과 반제품의 수량을 확인하여 준비한다. 전동드라이버, 소형프레스, 납땜기 등의 도구 및 장비를 준비하여 작동 여부를 확인한다. 수공구, 자동공구를 사용하여 부품들을 장착시키고 볼트를 체결하여 단위구성품을 조립한다. 단위구성품이 조립되면 케이스의 적절한 장소에 끼워 맞춤작업 또는 소형프레스를 사용하여 구멍을 뚫고 관련 부품을 장착시켜 볼트체결 작업을 한다. 회로도에 따라 전기, 전압장치를 위한 배선작업을 하고 납땜기를 사용하여 회로기판을 용접한다. 단위구성품 조립 후 또는 전체 장비조립 후 전기, 전자, 광학계측기기를 사용하여 기능의 이상 유무를 검사하며 공구를 사용하여 조정한다. 제조라인에서 발생한 부품결함에 대해서 수리하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C273","dJobICdNm":"[C273]사진장비 및 광학기기 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005426:1', '{"dJobCd":"K000005426","dJobCdSeq":"1","dJobNm":"산업용세척기조립원","workSum":"제작도면에 따라 용접기를 사용하여 산업용세척기의 틀(Frame)을 제작하고 기계도면에 따라 각종 부품을 외형 틀에 조립하며 제어장치 패널을 연결한다.","doWork":"작업명세서에 따라 각 부분품을 확인한다. 조립에 필요한 작업공구를 준비하고 점검한다. 각 부분의 제작공정별로 작업을 한다. 제어장치 패널을 조립한 후 전기배선작업을 한다. 본체의 외함을 만들고 컨베이어, 자동이동장치, 모터, 실린더 등을 치수에 맞게 조립하고 볼트와 너트 또는 용접기를 사용하여 결합한다. 제어장치 패널을 본체와 연결조립하고 전기배선을 한다. 시험작동을 하여 이상이 없을 시 몸체의 외관을 도장한다. 건조 후 출하를 위하여 적재장소로 옮긴다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"전기산업기사, 전기기기산업기사","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C281","dJobICdNm":"[C281]전동기, 발전기 및 전기 변환ㆍ 공급ㆍ제어 장치 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006538:1', '{"dJobCd":"K000006538","dJobCdSeq":"1","dJobNm":"수정진동자조립원","workSum":"발진주파수 제어용으로 사용되는 수정진동자(공진자)를 조립한다.","doWork":"일정 크기의 은 또는 주파수가 장착된 수정편을 스프링형 베이스(Base)에 설치한다. 일정 모양의 외부용기를 씌우고 유도가열기로서 외부용기를 봉한다. 질소가스를 봉함된 진동자 내부에 주입하고 납땜인두로서 베이스와 외부용기를 밀폐시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"주파수증착원","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004027:1', '{"dJobCd":"K000004027","dJobCdSeq":"1","dJobNm":"스탬퍼제작원","workSum":"광디스크(CD, DVD)를 대량복제하기 위한 니켈원판인 스탬퍼(Stamper)를 제작한다.","doWork":"소다 유리를 이용해 유리의 표면을 세척하고 말린다. 유리 원판에 피트(Pit)를 만들기 위해 감광제인 포토레지스트(Photoresist)를 도포하고 건조시킨다. 글라스 마스터를 만들기 위하여 마스터소스(복제할 데이터 원본)의 디지털 신호를 광디스크 형식에 맞게 변조한다. 레이저 빔을 이용하여 디지털 신호가 새겨진 글라스 마스터를 만든다. 만들어진 글라스 마스터를 전도체로 만들기 위하여 표면에 니켈을 입힌다. 1차로 니켈도금처리를 하여 떼어낸 파더(Father)에 다시 니켈 도금처리를 하고 떼어내어 2차 니켈도금처리를 한 마더(Mother)를 만든다. 마지막으로 마더에 다시 니켈도금처리를 하고 유리 원판에서 떼어내 최종 결과물인 스탬퍼(Stamper)를 완성한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"마스터링시스템운전원","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C182","dJobICdNm":"[C182]기록매체 복제업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004231:1', '{"dJobCd":"K000004231","dJobCdSeq":"1","dJobNm":"스트링거조작원","workSum":"자궁 내 피임기구를 만들기 위해 구리철사를 플라스틱심(core)둘레에 감는 기계를 조작한다.","doWork":"심을 감는 기계에다 놓는다. 특정크기의 자궁 내 피임구(ivd)를 만들기 위해 철사를 심에 감는 기계에다 놓는다. 특정크기의 자궁내 피임구를 만들기 위해 철사를 심에 감는 기계를 작동시킨다. 자궁내 피임구를 기계에서 떼어내고 의사가 쉽게 끄집어 낼 수 있도록 바닥에 가는 철사를 붙인다. 미리 고정시킨 플러그 게이지(plug gauge)와 캘리퍼스(Calipers)를 사용하여 철사 장력을 검사한 다음 장력을 조절하기 위해 너트나 고정나사를 돌린다. 빈 구리철사 실패(spool)를 기계에서 제거하고 새 실패로 교체한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C271","dJobICdNm":"[C271]의료용 기기 제조업","inqYear":"2011"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004932:1', '{"dJobCd":"K000004932","dJobCdSeq":"1","dJobNm":"시계문자판무늬가공원","workSum":"정형틀에 프레스(Press)를 이용하여 문자판 표면에 무늬를 만든다.","doWork":"작업지시서에 따라 가공할 문자판의 규격과 모양 및 무늬 등을 확인한다. 작업을 위한 프레스, 정형틀, 액체분말연마제 등의 장비 및 도구를 점검한다. 명시된 무늬모양을 보고 작업방법을 결정한다. 각종 무늬별로 정형틀에 문자판을 넣고 프레스로 눌러 문자판 표면에 무늬를 만든다. 무늬모양에 따라 액체분말을 사용하여 여러 개의 문자판을 한 개의 지그에 고정하여 동시에 연마작업을 한다. 무늬작업이 끝난 문자판의 오물을 물로 세척한다. 가공이 끝난 문자판의 무늬 상태를 작업명세표와 비교한다. 완성된 문자판을 다음 공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C274","dJobICdNm":"[C274]시계 및 시계부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006352:1', '{"dJobCd":"K000006352","dJobCdSeq":"1","dJobNm":"시계부품도장원","workSum":"시계부품이나 문자판 표면의 변색 또는 얼룩을 방지하기 위하여 명시된 색상의 도료로 도장하는 업무를 수행한다.","doWork":"작업지시서에 따라 도장할 시계부품의 종류와 규격, 형태, 수량 등을 확인한다. 작업에 필요한 도료, 스프레이기, 건조기, 고무 롤러, 잉크, 분무기 등 원료 및 작업도구를 준비하고 작동 여부를 점검한다. 작업표준의 표준색상표에 따라 도료를 정량 계량하여 일정 배합비율로 혼합한다. 도금 문자판을 지그 위에 올리고 일정 거리를 유지시킨다. 문자판 상면에 스프레이 건(Spray Gun)을 사용하여 도장두께에 주의하여 도료를 도장한다. 도장한 문자판을 건조기에 넣고 완전히 건조시킨 후 빼낸다. 건조 시에 색상별로 건조시간을 준수하여 작업한다. 인쇄기에 인쇄지그와 인쇄원판을 설치하여 중심을 맞춘다. 인쇄원판에 잉크를 칠하고 고무 롤러를 이용하여 인쇄침을 부분 도장한다. 문자판을 보호하기 위해 분무기를 사용하여 래커(Lacquer:도료의 하나)로 도포한 후 가열한 캐비닛에서 래커를 말린다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C274","dJobICdNm":"[C274]시계 및 시계부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007011:1', '{"dJobCd":"K000007011","dJobCdSeq":"1","dJobNm":"시계제조현장감독자","workSum":"회사 표준과의 일치 여부에 관하여 각종 시계, 관련 설비 및 조립부품을 검사·시험하는 일에 종사하는 작업원의 활동을 감독·조정한다.","doWork":"검사과정 중 검사원이 판정하기 곤란할 경우 시계의 합격, 불합격 여부를 결정해준다. 표준과 일치 여부를 확인하기 위해 루프 및 계측기기를 점검하며 주기적으로 수정·보완한다. 검사의 직무교육훈련(OJT)를 실시하며 부적합품 발생에 대한 대응조치를 검토하며 전반적으로 검사와 관련된 계측기기를 관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","similarNm":"시계제조반장","connectJob":"만드는 제품에 따라 손목시계제조반장, 탁상시계제조반장, 벽시계제조반장","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C274","dJobICdNm":"[C274]시계 및 시계부품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004756:1', '{"dJobCd":"K000004756","dJobCdSeq":"1","dJobNm":"시계조립원","workSum":"손목시계, 탁상시계, 벽시계 등을 제조하기 위하여 시계제조용 공구를 사용하여 시곗줄, 케이스, 무브먼트(Movement), 용두, 회로기판 등 시계구성 부품을 조립한다.","doWork":"작업지시서와 명세서에 따라 조립할 시계의 종류와 수량을 확인하다. 시계조립에 관련한 부품 또는 부분품을 준비하고 수량을 확인한다. 전동드라이버, 핀셋, 탁상용프레스 등의 도구 및 장비를 점검·확인한다. 명세서에 따라 각종 부품 및 부분품(시곗줄, 케이스, 무브먼트, 용두, 기어, 회로기판 등)을 시계외장케이스 내에 위치시킨다. 부품에 따라 손 또는 공구를 사용하여 나사체결작업, 핀셋을 이용한 끼워넣기, 끼워맞춤 작업을 한다. 조립 후 간단한 방수시험, 외관시험, 기능시험을 한다. 기준미달한 제품은 선별하여 전 공정으로 돌려보낸다. 시계외장 후면에 라벨을 붙이고 미관상태를 확인한다. 조립이 완료된 제품은 검사공정으로 이송시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"만드는 제품에 따라 손목시계조립원, 탁상시계조립원, 벽시계조립원","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C274","dJobICdNm":"[C274]시계 및 시계부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002491:1', '{"dJobCd":"K000002491","dJobCdSeq":"1","dJobNm":"시계조립현장감독자","workSum":"시계 및 관련된 장치를 조립하고 조립된 시계를 시험하는 작업원의 활동을 감독·조정한다.","doWork":"다양한 시계에 대한 조립공정, 시계 부품 등의 시계 전반에 관한 지식과 내용을 숙지한다. 생산량, 시간계획 등을 수립한다. 각 공정에 따른 부품을 불출한다. 각 조립공정을 관리·감독하며 때에 따라서는 기술지도도 병행한다. 할당된 작업량에 따라 작업계획을 세우고 부품과 지그 등의 준비를 지시하고 점검한다. 작업계획에 따라 작업공구 및 작업원들을 선정·배치한다. 수행할 직무에 대해 작업원들을 훈련시킨다. 부서 간의 흐름작업을 조정하기 위해 다른 반장들과 협의한다. 작업원들을 감독·조정한다. 조립라인의 설치 및 개·보수와 관련하여 계획을 실시한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","similarNm":"시계조립반장","connectJob":"만드는 제품에 따라 손목시계조립반장, 탁상시계조립반장, 벽시계조립반장","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C274","dJobICdNm":"[C274]시계 및 시계부품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006494:1', '{"dJobCd":"K000006494","dJobCdSeq":"1","dJobNm":"안정기조립원","workSum":"형광등 및 사용용도에 따른 HID(High Intensity Discharge)안정기, 방폭안정기, 전자식안정기, 일체형안정기 등의 안정기를 조립한다.","doWork":"작업표준에 따라 조립할 부분품을 확인한다. 권선기로 코일이 감겨진 보빈의 도면에 절연테이프와 절연지를 감는다. 안정기 철심을 조립하기 위해 접착제와 활석분을 배합하고 코어를 케이스에서 꺼내고 배합된 재료를 넣는다. E형이나 I형 철심을 조립하기 위해 절단된 철심을 적층하거나 용접한다. 조립된 철심제품을 건조시키고 진공 함침한다. 작업대 위에 케이스를 나열하고 컴파운드를 부은 다음 조립품을 케이스에 넣고 단자에 인출선을 납땜한다. 납땜인두·니퍼 등의 공구를 사용하여 초크코일, 콘덴서·이그나이터(Igniter)·인출선 등 회로를 구성하고 함침에 의한 바니시 피막을 제거한다. 조립이 완성되면 종합계측기기로 성능과 치수를 검사한다. 조립품의 외관결함 유무를 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"전기산업기사, 전기기기산업기사","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C281","dJobICdNm":"[C281]전동기, 발전기 및 전기 변환ㆍ 공급ㆍ제어 장치 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004312:1', '{"dJobCd":"K000004312","dJobCdSeq":"1","dJobNm":"안테나조립반장","workSum":"방송수신용 안테나를 제작·조립하는데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"생산계획에 따라 작업계획서·작업지시서 등을 작성하고 작업원을 배치한다. 각종 기계 및 설비를 점검하고 시제품을 검사하기도 한다. 작업원들에게 안전교육을 실시한다. 제품에 대한 자재를 확인하고 수요에 따른 부품을 관련 부서에 요청한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"수동조작","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006246:1', '{"dJobCd":"K000006246","dJobCdSeq":"1","dJobNm":"안테나조립원","workSum":"전파를 송·수신하여 전류로 공급해 주는 안테나를 조립한다.","doWork":"급전선(고주파를 받아 흘려보내는 역할을 함)이 연결된 부분품의 지정홈에 동이나 알루미늄으로 만들어진 막대(Pole)를 끼우고 조인다. 일정 크기의 Dipole(쌍극자, 크기는 같고 부호가 반대인 두 전하가 나란히 선 배치)소자를 급전선이 조립된 막대(Pole)에 연결한다. 파라볼라 안테나의 경우는 접시 모양의 반사기를 Dipole소자, 급선전과 연결하여 조립한다. 조립된 안테나의 작동상태를 점검한다. 검사기구를 사용하여 안테나의 특성을 검사하기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002992:1', '{"dJobCd":"K000002992","dJobCdSeq":"1","dJobNm":"에이징원","workSum":"텔레비전, 비디오, 컴퓨터 등 제조된 전자제품을 일정 시간 가동시켜 이상 유무 및 내구력을 점검한다.","doWork":"컨베이어를 통해 이송된 전자제품에 전원을 공급하고 일정 시간 가동시켜 제품의 이상 유무 및 내구력 등을 점검한다. 수출할 지역의 기후 조건에 따라 에이징(Aging) 설비를 일정한 온도, 습도로 유지한다. 일정 시간이 경과한 후 제품에 전원을 제거하고 이상이 발생한 제품을 표시한 후 검사부서나 수리부서로 이송시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"에이징테스트원","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C263/C265","dJobICdNm":"[C263]컴퓨터 및 주변장치 제조업 / [C265]영상 및 음향기기 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007140:1', '{"dJobCd":"K000007140","dJobCdSeq":"1","dJobNm":"연료전지스택컨디셔닝조작원","workSum":"조립된 연료전지 스택(Stack)을 구성하는 단전지들을 활성화하고, 유기물 등의 불순물을 제거하기 위해 컨디셔닝 설비를 운전한다.","doWork":"조립된 연료전지 스택(Stack)의 연료배관과 공기배관에 컨디셔닝(Conditioning) 설비의 배관을 연결시킨다. 운전조건(온도, 압력, 습도 등)을 단계별로 증가시키면서 여러 단전지로 구성된 스택을 활성화하며, 스택 내부의 각종 유기물질 등을 제거한다. 정해진 조건에 도달하면 온도, 습도, 압력을 서서히 감소시킨 뒤 연결된 배관을 제거하고 연료전지 모듈의 성능시험을 위한 테스트 공정으로 이송시킨다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C282","dJobICdNm":"[C282]일차전지 및 축전지 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002048:1', '{"dJobCd":"K000002048","dJobCdSeq":"1","dJobNm":"연료전지주변기기조립원","workSum":"연료전지의 주변기기 설비를 조립·생산한다.","doWork":"연료전지 스택모듈로 공급되는 연료 및 산화제 공급시스템등으로 구성된 기계주변장치(MBOP: Mechanocal Balance of Plant)와 연료전지 스택모듈에서 생산된 전기를 처리하는 인버터, 스위치기어 등으로 구성된 전기주변장치(EBOP: Electrical Balace of Plant)를 조립 생산한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","similarNm":"BOP생산원, BOP조립원","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C282","dJobICdNm":"[C282]일차전지 및 축전지 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005612:1', '{"dJobCd":"K000005612","dJobCdSeq":"1","dJobNm":"유리전구베이스조립원","workSum":"봉합과 배기가 완료된 유리구의 하부에 접착제가 주입된 금속베이스를 부착하는 캡핑공정 기계를 조작한다.","doWork":"전 공정에서 접착제가 도포된 베이스를 기계의 베이스 공급대에 놓는다. 가스버너를 점화시켜 불꽃의 온도와 길이를 조절한다. 기계를 가동시켜서 베이스와 유리구의 하부가 결합되도록 하고, 가스불꽃에 의해 베이스에 도포된 접착제를 녹여서 유리구와 베이스가 접착되도록 캡핑공정을 한다. 접착된 유리전구의 베이스에 인출되어 있는 도입선을 절단하고 베이스의 하부와 측면의 접합부를 손이나 기계로 납땜한다. 완성된 유리전구의 외관, 치수, 소성온도 등을 검사하고 이상이 발견되면 수동공구를 사용해서 조정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"뇌관조립원","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C284","dJobICdNm":"[C284]전구 및 조명장치 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002280:1', '{"dJobCd":"K000002280","dJobCdSeq":"1","dJobNm":"유선전화기조립원","workSum":"전화기를 생산하기 위하여 생산라인에서 반조립품 및 완제품을 조립한다.","doWork":"각종 부품이 삽입되고 납땜되어진 인쇄회로기판을 단말기의 케이스에 조립하고 기타 부분품들을 공구를 사용하여 조립한다. 자동삽입기에 의해 삽입되지 못하는 부품소자를 인쇄회로기판에 삽입하기도 한다. 조립이 끝나면 수행한 작업이 제대로 되었는지 확인하고, 다음 조립공정으로 컨베이어를 통해 이동시킨다. 조립이 완전히 끝나면 각종 기능을 검사하는 단계로 전화기를 옮길 수 있도록 상자에 담는다. 각종 성능검사가 끝난 제품은 상자에 넣고 라벨을 붙이고 제품과 설명서와 같은 내용물을 넣은 후 포장한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"인터폰조립원, 키폰조립원, DDR조립원","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C264","dJobICdNm":"[C264]통신 및 방송 장비 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002263:1', '{"dJobCd":"K000002263","dJobCdSeq":"1","dJobNm":"유선전화기조립현장감독자","workSum":"전화기·키폰·인터폰 등을 조립하는 데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"작업량을 파악하여 작업원을 배치하고 잔업 및 특근인원을 파악하여 해당 부서에 보고한다. 작업원의 근태상황을 파악하고 작업 중에 애로사항을 상담해주고 인원변동사항을 점검·보고한다. 작업 중의 문제점을 파악하고 기록·보고한다. 표준작업 이행 여부를 확인하며 작업원들에게 작업지도를 실시한다. 일별·주별·월별 생산일지를 작성·보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"조정","workFunc2":"감독","workFunc3":"수동조작","similarNm":"유선전화기조립반장","connectJob":"인터폰조립반장, 키폰조립반장, DDD조립반장","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C264","dJobICdNm":"[C264]통신 및 방송 장비 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006721:1', '{"dJobCd":"K000006721","dJobCdSeq":"1","dJobNm":"음향기기검사원","workSum":"생산라인에서 조립된 음향기기 제품의 외관·성능·특성 등을 검사하는 일을 한다.","doWork":"제품별 검사항목이 기술된 작업명세표에 따라 각종 측정기기 및 계측기기를 사용하여 제품의 성능·특성 등을 규정된 오차범위나 조건에서 벗어나지 않는지, 원하는 기능들이 제대로 동작하는지를 확인하며 조정·시험·검사한다. 리모콘의 기능검사를 실시한다. 외관에 이상이 있는지를 검사한다. 검사된 내용을 작업일지에 기록하고 이상 유무를 감독자나 상급자에게 알려준다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"오디오검사원","connectJob":"외관검사원, 정밀측정원, 제품검사원, 출하검사원, 특성검사원, 카세트검사원, CD플레이어검사원, 오디오검사원","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C265","dJobICdNm":"[C265]영상 및 음향기기 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005976:1', '{"dJobCd":"K000005976","dJobCdSeq":"1","dJobNm":"음향기기조립원","workSum":"전동드라이버, 납땜공구 등을 사용하여 각종 부품소자와 부분품을 조립하여 음향기기를 만든다.","doWork":"제품 설계에 따라 각종 부품소자들의 전자기판 기타 부분품들을 전동드라이버와 같은 공구를 사용하여 조립한다. 계측장비를 통해 조립공정 중에 제품의 특성 및 성능을 검사하거나 조정하기도 한다. 섀시(Chassis)에 부분품들을 조립하여 완성품으로 만든다. 자동삽입기에 의해 삽입할 수 없는 부품소자들을 인쇄회로기판에 삽입하고 자동납땜기에 의해 작업하기 어려운 납땜작업이나 납땜이 불량한 부분을 수동으로 납땜작업을 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"오디오조립원","connectJob":"만드는 제품에 따라 카세트조립원, 튜너조립원, 씨디(CD)플레이어조립원, MP3조립원, DVD조립원, 미니콤포넌트조립원, 스피커조립원, 홈시어터조립원, 앰프(AMP)조립원, 리시버(Riceiver)조립원, 데크조립원","dJobECd":"8360","dJobECdNm":"[8360]전기·전자 부품·제품 조립원","dJobJCd":"8640","dJobJCdNm":"[8640]전기·전자 부품 및 제품 조립원","dJobICd":"C265","dJobICdNm":"[C265]영상 및 음향기기 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;