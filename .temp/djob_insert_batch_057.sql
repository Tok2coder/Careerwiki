INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006047:1', '{"dJobCd":"K000006047","dJobCdSeq":"1","dJobNm":"휠체어조립원","workSum":"바퀴, 핸들, 차체 등의 휠체어 부품을 조립하여 휠체어를 제작한다.","doWork":"작업도면을 확인하고 종류에 따라 부품을 준비한다. 몽키스패너, 드라이버, 리벳터 등의 조립공구를 사용하여 차체부, 견대부, 구동구, 제동부 등을 조립순서에 의해 조립한다. 휠체어 제품에 따른 각 구성품을 조립하여 완성차를 제작한다. 조립된 제품을 검사하여 불량한 곳을 수정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"의자차조립원","dJobECd":"8161","dJobECdNm":"[8161]일반기계 조립원","dJobJCd":"8544","dJobJCdNm":"[8544]일반기계 조립원","dJobICd":"C319","dJobICdNm":"[C319]그 외 기타 운송장비 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005170:1', '{"dJobCd":"K000005170","dJobCdSeq":"1","dJobNm":"도어록조립원","workSum":"일반 도어록 및 디지털 도어록을 만들기 위해 수동 및 전동공구를 사용하여 부분품을 조립한다.","doWork":"작업지시서에 따라 조립작업대에 작업에 필요한 공구 및 부품을 준비한다. 가공된 부품을 조립순서별로 분류한다. 부품을 검사하여 불량품을 선별하여 구분한다. 규격 외 부품을 줄 등의 수동공구를 사용하여 교정하기도 한다. 작업대에 도어록 케이스를 올려놓고 전동공구 등을 이용하여 내부잠금장치 등 부분품을 조립한다. 도어록의 기능에 따라 음성인식장치, 지문인식장치 등을 조립한다. 조립이 완료되면 작동상태, 외관상태 등을 검사하고 박스에 포장한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8162","dJobECdNm":"[8162]금속기계부품 조립원","dJobJCd":"8550","dJobJCdNm":"[8550]금속기계 부품 조립원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004206:1', '{"dJobCd":"K000004206","dJobCdSeq":"1","dJobNm":"림조립원","workSum":"계기, 수동공구, 동력공구 등을 사용하여 명세서에 따라 자전거의 철사바큇살을 조립한다.","doWork":"바퀴를 조립하기 위하여 철사바큇살을 바퀴 톱에 매고 바큇살의 꼭지를 테에 조인다. 바퀴의 림 측면과 림 테두리 바깥둘레에 다이얼게이지의 측정점을 대고 바퀴를 가볍게 돌려 가로·세로 흔들림을 조사한다. 게이지의 바늘이 지적하는 편차를 니플렌치를 사용하여 바큇살을 돌려 정해진 숫자에 맞춰 인장을 조정한다. 고정된 게이지를 사용하여 바퀴의 직경을 측정한다. 바퀴에 타이어를 부착하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8162","dJobECdNm":"[8162]금속기계부품 조립원","dJobJCd":"8550","dJobJCdNm":"[8550]금속기계 부품 조립원","dJobICd":"C319","dJobICdNm":"[C319]그 외 기타 운송장비 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003073:1', '{"dJobCd":"K000003073","dJobCdSeq":"1","dJobNm":"밸브검사원","workSum":"조립 완성이 된 밸브의 외관, 치수, 재질을 검사하고 각종 시험을 한다.","doWork":"작업지시서나 도면의 내용을 숙지한다. 조립하여 완성된 밸브를 검사, 시험하기 위한 각종 장비와 도구를 준비한다. 검사 및 시험은 제조공장에서 실시한다. 신축 가동관 도막은 매끈하고 흠이나 이물질의 혼입 등 사용상 해로운 결함이 없도록 외관검사를 한다. 주요부품에 대한 재질검사는 공인 기관에서 시행한 검사 성적서를 제출한다. 각 부의 치수검사는 별도의 도면에 준하여 검사한다. 수압에 의한 내압시험을 통해 각 부의 이상을 발견하고, 작동시험을 통해 신축가동관의 굴곡 및 신축이 원활하게 작동되었는지를 확인한다. 검사결과 경미한 외관 결함에 대하여는 주문자의 승낙을 얻어 보수도장을 한다. 검사 기록지를 작성한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"8162","dJobECdNm":"[8162]금속기계부품 조립원","dJobJCd":"8550","dJobJCdNm":"[8550]금속기계 부품 조립원","dJobICd":"C291","dJobICdNm":"[C291]일반 목적용 기계 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002276:1', '{"dJobCd":"K000002276","dJobCdSeq":"1","dJobNm":"밸브조립원","workSum":"밸브의 종류에 따라 밸브 손잡이와 와셔, 볼트를 조립한다.","doWork":"작업에 필요한 장비와 작업공구를 준비한다. 작업지시서에 따라 조립할 제품의 명세서를 확인검토한다. 부분품을 작업대 위에 올려놓는다. 스톱밸브, 게이트밸브, 체크밸브, 플러그밸브 등 밸브의 종류에 따라 조립할 부분품을 분리하여 정돈한다. 밸브의 바디에 핸들을 조립하고 핸들조작력을 규정에 따라 정렬한다. 디스크(파열판식 안전장치)를 조립한다. 디스크의 수밀부에 교환 가능한 합성 고무링이나 정밀 가공한 금속링을 부착한다. 와셔 및 볼트를 조립하여 완성한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8162","dJobECdNm":"[8162]금속기계부품 조립원","dJobJCd":"8550","dJobJCdNm":"[8550]금속기계 부품 조립원","dJobICd":"C291","dJobICdNm":"[C291]일반 목적용 기계 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003164:1', '{"dJobCd":"K000003164","dJobCdSeq":"1","dJobNm":"소화용밸브검사원","workSum":"완성된 소화용 밸브의 안전도와 하자 여부를 결정하기 위해 수압 및 기밀유지시험을 실시한다.","doWork":"작업지시서 및 작업표준에 따라 검사한 밸브를 용도별로 분류한다. 수압테스터기에 밸브를 설치하고 밸브에 최대허용 압력으로 수압을 가한다. 일정 압력과 시간으로 유압을 가한 후 기밀 및 밸브의 손잡이 작동상태를 점검한 후 품질관리리스트를 작성한다. LPG용 밸브를 점검하기 위해 공압 테스터기에 밸브를 설치한다. 일정 압력으로 공압을 가한 뒤 가스의 유출 여부를 확인한다. 법으로 규정한 소화 및 안전기준에 따라 제품의 불량 여부를 판단하며 불량원인을 분석하여 개선한다. 품질검사가 합격한 제품에 한하여 포장을 위해 적재한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8162","dJobECdNm":"[8162]금속기계부품 조립원","dJobJCd":"8550","dJobJCdNm":"[8550]금속기계 부품 조립원","dJobICd":"C291","dJobICdNm":"[C291]일반 목적용 기계 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002380:1', '{"dJobCd":"K000002380","dJobCdSeq":"1","dJobNm":"수술대제작원","workSum":"의료용 수술대를 제작하기 위하여 관련 부품을 제작·조립·조정한다.","doWork":"작업명세서에 따라 제작할 수술대의 규격과 형태, 수량 등을 확인한다. 망치, 동력압착기 등의 공구 및 장비와 반조립 상태의 관련 부품들을 준비한다. 망치 등을 사용하여 수술대 네 귀퉁이의 구멍에 십자필러(Cross Filler)를 연결하고 다리 및 활차, 안전레일 등을 침대틀에 부착, 연결한다. 동력압착기를 사용하여 형태를 갖도록 구부리거나, 유압장치 또는 기어조성장치를 부착하여 위치를 조정한다. 사용자의 선택 편리성을 위해 다양한 액세서리를 기능별로 사용할 수 있도록 조립 부착식으로 만들기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8162","dJobECdNm":"[8162]금속기계부품 조립원","dJobJCd":"8550","dJobJCdNm":"[8550]금속기계 부품 조립원","dJobICd":"C271","dJobICdNm":"[C271]의료용 기기 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003650:1', '{"dJobCd":"K000003650","dJobCdSeq":"1","dJobNm":"전동휠체어검사원","workSum":"명세서와 도면에 따라 전동휠체어의 각종 기기, 부품 등이 안전하게 조립이 되었는지 검사한다.","doWork":"작업지시서 및 검사절차서를 보고 검사방법을 숙지한다. 전동휠체어의 각 부분(큰바퀴, 보조바퀴, 전동모터, 측면보호대, 팔걸이, 발받침대, 손잡이, 좌석시트 등)을 육안으로 확인하고 검사한다. 전동휠체어의 각 기능(방향 및 속도컨트롤기능, 감속장치기능, 자동제어기, 경보장치)을 검사한다. 전동휠체어의 안전성에 대하여 검사내용을 정리하여 종합적으로 평가한다. 안전사항에 미달하거나 이상 유무가 발견될 경우 관계부서에 수정·보완하도록 요청한다. 검사결과를 기록양식에 기록하여 보관한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"수동조작","connectJob":"휠체어검사원","dJobECd":"8162","dJobECdNm":"[8162]금속기계부품 조립원","dJobJCd":"8550","dJobJCdNm":"[8550]금속기계 부품 조립원","dJobICd":"C319","dJobICdNm":"[C319]그 외 기타 운송장비 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001842:1', '{"dJobCd":"K000001842","dJobCdSeq":"1","dJobNm":"전동휠체어조립원","workSum":"전동휠체어를 제조하기 위하여 명세서와 도면에 따라 각 부품을 조립한다.","doWork":"작업지시서 및 조립절차서를 보고 전동휠체어의 조립방법을 확인한다. 전동휠체어를 조립하기 위하여 전동휠체어에 사용되는 각 부품(바퀴, 등받침, 좌석, 발받침 등)을 작업대에 준비한다. 조립에 필요한 공구 및 도구(용접기, 그라인더, 전동드라이버 등)를 준비한다. 용접기로 각 부품을 연결한다. 용접이 끝난 각 부품을 그라인더로 다듬는다. 전동드라이버를 사용하여 몸체, 바퀴, 핸들 등을 볼트와 너트로 조립한다. 안장, 발판 등 플라스틱 부품을 취부한다. 조립이 끝난 완성품을 시운전하여 이상 유무를 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"휠체어조립원","dJobECd":"8162","dJobECdNm":"[8162]금속기계부품 조립원","dJobJCd":"8550","dJobJCdNm":"[8550]금속기계 부품 조립원","dJobICd":"C319","dJobICdNm":"[C319]그 외 기타 운송장비 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003627:1', '{"dJobCd":"K000003627","dJobCdSeq":"1","dJobNm":"치공구제작원","workSum":"지그 및 고정구 등 치공구를 제작 및 수리한다.","doWork":"금형설계도와 작업지시서를 분석하여 제품의 형태를 확인한다. 철판 작업지시서와 설계도면을 검토하여 작업절차와 방법을 계획한다. 금속재료를 측정하고 선반, 밀링기, 보링기, 쉐이퍼, 그라인더기, 연삭기 등의 공작기계 등을 조작하여 절단, 재단, 용접, 제관 등으로 부품을 가공한다. 드릴작업, 탭작업 및 그라인딩 작업을 한다. 표면을 열처리하고 도금 후 후처리한다. 게이지, 캘리퍼스, 마이크로미터 등의 측정기구를 사용하여 가공치수와의 일치도를 확인한다. 물림장치를 사용하여 작업대에 공작물을 고정시킨 후 수동공구를 사용하여 부품을 조립한다. 마이크로미터·높이게이지 등의 측정기구로 조립품의 치수와 틈을 확인하여 제품의 품질을 검사한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"치공구수리원","certLic":"치공구설계산업기사","dJobECd":"8162","dJobECdNm":"[8162]금속기계부품 조립원","dJobJCd":"8550","dJobJCdNm":"[8550]금속기계 부품 조립원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003884:1', '{"dJobCd":"K000003884","dJobCdSeq":"1","dJobNm":"급전자동화운용원","workSum":"급전종합자동화설비의 효율적인 운용 및 사고방지를 위하여 급전자동화설비와 부대설비를 감시·운용하고 유지·보수·관리 업무를 수행한다.","doWork":"급전자동화설비의 원리, 구조, 특성과 전력계통을 숙지하고, 설비의 효율적 운영과 사고방지 및 응급조치를 한다. 급전자동화설비의 운용상태 감시 및 제반 장치를 조정하며, 관련 통신회선의 정상동작 여부를 확인한다. 급전자동화설비의 지시계기와 기록계기 및 모니터에 나타난 제반 지침량, 기록량 등을 운용일지에 기록한다. 급전자동화설비의 중앙처리장치 등의 설비사고를 미연에 방지하기 위하여 정기점검계획에 따라 장치의 이상 유무를 점검·기록한다. 이상상태 발견 시 보수 담당 부서에 보수를 의뢰하거나 자체적으로 보수한다. 급전종합자동화설비 및 부대설비 사고 시 응급복구하고, 사고내용을 중앙급전사령관에게 보고한다. 설비의 장애발생 또는 오작동 시 이상상태를 파악하여 정상이 되도록 조치하거나 주관부서에 조치를 의뢰한다. 필요시 사용할 수 있도록 공기구 및 안전장구, 보수예비품 등을 정리정돈 및 점검하고, 점검관리대장에 기록한다. 급전종합자동화설비의 운용에 따른 운영보고서 및 통계보고서를 작성하여 제출한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|다습|소음·진동|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"급전자동화설비관리원","certLic":"전기기사, 전기공사기사","dJobECd":"8330","dJobECdNm":"[8330]발전·배전 장치 조작원","dJobJCd":"8610","dJobJCdNm":"[8610]발전 및 배전장치 조작원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006009:1', '{"dJobCd":"K000006009","dJobCdSeq":"1","dJobNm":"노심관리원","workSum":"원자력 발전소에 핵연료가 도착해서 원자력 발전소를 벗어날 때 까지 핵연료의 안전성이 확보되도록 검사⋅운전⋅유지⋅관리한다.","doWork":"원자로의 정상적인 운전과 효율적인 노심관리를 위하여 원자로의 출력분포 및 연소상황을 컴퓨터로 추적·계산·분석한다. 원자로의 가동특성과 관련하여 원료를 원자로에 장전하고 원자로특성시험 등을 통하여 연료설계사양 등의 성능을 분석한다. 출력분포 측정결과로 얻어진 자료를 분석·검토하여 안전성 위반 여부를 확인한다. 전처리로 얻어진 자료를 분석하여 소모되는 원전연료를 계산한다. 원자로의 냉각수에 포함된 방사능의 준위를 동위원소를 이용하여 분석하고 원전연료의 손상률을 계산한다. 원전연료의 핵반응이 완료되면 각 집합체별로 연소이력을 계산하고 재장전 계획을 수립한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"핵연료물질취급자면허","dJobECd":"8330","dJobECdNm":"[8330]발전·배전 장치 조작원","dJobJCd":"8610","dJobJCdNm":"[8610]발전 및 배전장치 조작원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003099:1', '{"dJobCd":"K000003099","dJobCdSeq":"1","dJobNm":"무인변전소관리원","workSum":"일정 주기로 순회하면서 무인변전설비를 점검하고, 고장 발생 시 급전 지휘계통의 지시에 따라 이를 조정·제어한다.","doWork":"전격전압, 주파수, 전력량 등을 조정하여 정전이 되지 않도록 무인변전소의 변전설비를 제어한다. 변전소 각종 설비의 작동이 정상적으로 이루어지는지 작동상태 모니터를 감시한다. 외부 무단출입자로부터 무인변전소의 각종 설비를 보호하기 위하여 원격감시장치를 주시한다. 관할 지역 변전소의 변동사항을 감시하여 문제 발생 시 대처한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"전기기사, 전기공사기사, 전기산업기사, 전기공사산업기사  ","dJobECd":"8330","dJobECdNm":"[8330]발전·배전 장치 조작원","dJobJCd":"8610","dJobJCdNm":"[8610]발전 및 배전장치 조작원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005016:1', '{"dJobCd":"K000005016","dJobCdSeq":"1","dJobNm":"발전설비조정제어원","workSum":"발전기 용량과 전력수요에 따라 발전소에서 송전선까지 전력의 흐름과 분배를 일정하게 조절하기 위하여 발전제어판에 설치된 각종 계기의 지시치를 감시하고, 가동 중인 발전기의 출력, 전압, 주파수, 전류 등을 조정한다.","doWork":"조정판, 보호계전기, 발전기 및 기타 보조설비의 이상 유무를 점검하고 운전상태를 표시하는 계기의 지시치를 기록한다. 발전책임운전원과 급전지령원의 지시에 따라 발전기의 주파수, 출력, 전압, 무효전력, 역률 등을 조정하고 조정판의 계기지시치를 일지에 기록한다. 일일연료사용량, 발전량 등 발전효율 계산자료를 정리하여 담당 부서로 발송한다. 발전설비의 가동 및 긴급사고 발생 시 송배전계통과 분리하고 사고 및 장애요인을 파악하여 보수의뢰서를 작성한다. 계획예방정비 시 보수내용을 파악하여 관련 기기를 점검한다. 보수가 완료되면 현장을 확인하여 정상가동 여부를 검사한다. 발전설비의 가동 중에 발생하는 긴급상황 및 장애요인의 대응요령을 분석·검토하여 일지에 기록한다. 기타 안전·소방, 누유예방 및 에너지를 관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"제어조작","connectJob":"발전기제어반조정원, 보일러제어반조정원, 터빈제어반조정원","dJobECd":"8330","dJobECdNm":"[8330]발전·배전 장치 조작원","dJobJCd":"8610","dJobJCdNm":"[8610]발전 및 배전장치 조작원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007189:1', '{"dJobCd":"K000007189","dJobCdSeq":"1","dJobNm":"발전업무보조원","workSum":"각종 발전설비를 관리·운전하는 조작원들의 업무를 보조한다.","doWork":"수동공구와 윤활장비를 사용하여 석탄수송장비의 조절과 유지를 돕는다. 컨베이어에 운반되는 석탄의 견본을 채취하고 가동상황을 관찰한다. 펌프를 가동하거나 수문을 열고 닫으며 배출구의 밸브를 조절한다. 보일러 내부에 생성된 분진과 재를 제거하기 위하여 회처리기를 가동한다. 각종 수동공구를 사용하여 보일러 내부의 부산물을 제거한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"웅크림|","workEnv":"위험내재|고온|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"내연발전보조원, 미분기보조원, 수력발전보조원, 열병합발전보조원, 펌프운전원, 회처리원","dJobECd":"8330","dJobECdNm":"[8330]발전·배전 장치 조작원","dJobJCd":"8610","dJobJCdNm":"[8610]발전 및 배전장치 조작원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001530:1', '{"dJobCd":"K000001530","dJobCdSeq":"1","dJobNm":"발전용수설비운전원","workSum":"발전용수가 보일러의 급수수질에 적합하도록 용수를 탈염처리하는 순수제조설비를 운전·관리한다.","doWork":"공업용수나 지하수의 수질에 따라 분석자료를 검토한다. 전해질, 유기물, 미생물, 부유성 고형물질 등의 이물질을 제거하기 위하여 각종 설비 및 약품 등을 사용하여 산화법, 여과법, 침전법, 흡착법, 살균법 등의 방법으로 불순물 처리한다. 조정판의 계기를 조작하여 전처리된 여과수를 이온교환수지탑에 투입하여 각종 불순물을 제거한다. 여과처리된 순수저장탱크의 수위를 확인하여 설비별 사용량을 파악한다. 수시로 순수처리설비 및 약품저장탱크 등 관련 설비의 상태를 파악하여 작업일지에 기록한다. 원수 및 순수의 견본을 채취하여 분석실에 검사·의뢰하고, 분석된 자료를 토대로 설비를 관리·조작한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"복수탈염설비운전원, 원자력발전용수관리원, 화력발전용수관리원, 복수처리원","dJobECd":"8330","dJobECdNm":"[8330]발전·배전 장치 조작원","dJobJCd":"8610","dJobJCdNm":"[8610]발전 및 배전장치 조작원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004354:1', '{"dJobCd":"K000004354","dJobCdSeq":"1","dJobNm":"발전용연료전지모니터링원","workSum":"발전용연료전지의 운영 상태를 실시간으로 감시하고 관리한다.","doWork":"발전용연료전지의 운영 상태를 실시간으로 감시하고 관리한다. 발전량, 온도, 압력 등 주요 운전변수를 모니터링하여 이상 상황을 감지하고 대응한다. 운전 데이터를 분석해 성능 개선 방안을 도출하고, 주기적인 유지보수를 지원하여 연료전지발전소의 효율적인 운영을 보장한다. 운전 중 고장이 발생하였을 때 운전절차서에 따라 응급조치를 실시한다. 현장에 대응이 필요할 경우 발전용연료전지유지보수원과 협업하여 운전실에서 조치사항을 대응한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8330","dJobECdNm":"[8330]발전·배전 장치 조작원","dJobJCd":"8610","dJobJCdNm":"[8610]발전 및 배전장치 조작원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004298:1', '{"dJobCd":"K000004298","dJobCdSeq":"1","dJobNm":"발전운전원","workSum":"발전소의 정상적인 기동·가동·정지를 위하여 보일러, 터빈, 발전기 등의 발전설비와 보조기기의 동작상태를 점검·기록하고, 발전기의 출력·전압·주파수 등을 조정하기 위하여 각종 배전반을 제어·운전한다.","doWork":"출력, 주파수, 저압 등을 조정하여 발전설비를 제어·운전한다. 발전기, 터빈, 보일러, 송·변전설비, 전기설비 및 기타 보조기기를 순시점검하며 운전을 기록한다. 계통사고 및 기타 요인으로 발전기가 정지되면, 신속히 응급조치를 하고 상황을 보고한다. 재기동을 위한 긴급 조작으로 사고에 대처한다. 기기의 이상 유무를 확인하고 경미한 보수사항은 직접 보수한다. 자체보수가 불가능한 사항은 유지·보수 관련 부서 및 전문업체에 의뢰한다. 기동정지 및 돌발사고, 급전사정에 따른 기동 및 정지 시에는 각 단계별 주요기기를 조작하고 주요사항은 인계일지에 기록하여 인계한다. 제어·운전에 대한 기술향상을 위하여 직무교육 및 가상사고 모의훈련 등의 교육훈련에 참여한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"발전배전반조작원","connectJob":"보일러기계설비운전원, 터빈기계설비운전원, 발전보조기계설비운전원","certLic":"일반기계기사, 전기기사, 전기공사기사, 에너지관리기사, 건설안전산업기사","dJobECd":"8330","dJobECdNm":"[8330]발전·배전 장치 조작원","dJobJCd":"8610","dJobJCdNm":"[8610]발전 및 배전장치 조작원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003358:1', '{"dJobCd":"K000003358","dJobCdSeq":"1","dJobNm":"발전전기설비정비원","workSum":"발전에 사용되는 각종 전기설비 및 측정계기를 점검하여 유지·관리하고, 결함을 제거하기 위해 검사기, 계측기 등의 장비를 사용하여 정비한다.","doWork":"발전전기설비를 정기적으로 점검하고, 점검사항을 일지에 기록한다. 이상 및 장애요인이 있는 설비 또는 기기의 설계도면을 점검하여 파손상태와 파손정도를 확인한다. 전압계, 전류계, 테스터(회로시험기) 등을 사용하여 파손원인을 점검하고 장비를 사용하여 분해한다. 파손된 전기설비의 부품을 분해하여 파손원인을 규명하고 교체한다. 보수가 완료되면 시험가동을 실시하여 정상 작동 여부를 확인한 후 재조립한다. 작업에 소요된 부품의 종류, 규격 및 수량 등을 일지에 기록한다. 보수가 불가능한 전기설비는 전문업체에 의뢰하여 신속한 복구가 이루어지도록 조치하고, 공사시공을 관리·감독한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"전기산업기사, 전기공사산업기사, 에너지관리산업기사","dJobECd":"8330","dJobECdNm":"[8330]발전·배전 장치 조작원","dJobJCd":"8610","dJobJCdNm":"[8610]발전 및 배전장치 조작원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004065:1', '{"dJobCd":"K000004065","dJobCdSeq":"1","dJobNm":"발전전기설비정비현장감독자","workSum":"발전소에서 열, 전기를 생산하는 발전설비 중 전기설비의 이상 및 장애요인을 제거하고 파손된 부품을 교체·보수하는데 종사하는 작업원들의 활동을 관리·감독한다.","doWork":"작업계획에 따라 세부실행항목을 수립하여 작업 절차 및 방법을 결정한다. 작업원이 효율적으로 작업할 수 있도록 위치를 배정하고, 작업내용을 지시한다. 작업진행상황을 파악하고 작업내용을 보고한다. 이상 및 장애요인이 있는 부위의 설계도를 확인하여 보수내역 및 자재수량을 확인한다. 작업원의 작업상황을 관리·감독하고 작업공정에 있어 필요한 자재 및 기술을 지원한다. 작업원과 함께 작업하며 표준명세에 따라 지시된 작업이 이루어지는지 작업상황을 관찰하고, 작업내용을 점검한다. 작업이 완료되면 작업내용을 일지에 기록한다. 작업원에 대한 직무교육 및 안전위생교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시로 관찰과 면담을 통하여 작업원의 애로사항 및 건의사항을 수렴·해결하고 문제점을 보고한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"발전전기설비정비반장","certLic":"전기기사, 전기공사기사, 에너지관리기사","dJobECd":"8330","dJobECdNm":"[8330]발전·배전 장치 조작원","dJobJCd":"8610","dJobJCdNm":"[8610]발전 및 배전장치 조작원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002687:1', '{"dJobCd":"K000002687","dJobCdSeq":"1","dJobNm":"배전설비기술원","workSum":"배전설비의 효율적인 운영을 위하여 전산관리, 배전선로 보호협조, 배전선로 자동화 설비운영 등에 대한 기술지원을 한다.","doWork":"효율적인 배전설비 및 선로관리를 위하여 배전설비 및 기기, 수용가의 신·증설 및 폐지, 공사의 준공내역 및 설계, 정전 및 사고에 대한 통계자료 등을 관리한다. 배전설비의 신·증설에 따라 신규 수용가에 적합한 변압기 용량을 검토하여 관련 부서에 제공한다. 배전설비에 대한 각종 지적도면 제작 및 변경에 따른 제반 업무를 수행하고 유지·관리한다. 최적의 전력공급을 위하여 배전선로 자동화 설비에 대한 계획을 수립하여 설치한다. 관련 설비를 운영한다. 각종 배전선로 및 변압기의 노후, 고장 등에 대한 현장조사를 실시하여 교체 및 보수를 의뢰한다. 배전설비 및 배전선로 시공에 따른 규정준수 등을 검사하여 품질관리업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"전기산업기사, 전기공사산업기사","dJobECd":"8330","dJobECdNm":"[8330]발전·배전 장치 조작원","dJobJCd":"8610","dJobJCdNm":"[8610]발전 및 배전장치 조작원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006371:1', '{"dJobCd":"K000006371","dJobCdSeq":"1","dJobNm":"배전설비운영원","workSum":"배전설비의 효율적 운영과 양질의 전력공급을 위하여 배전선로에 설치되어 있는 각종 배전설비에 대한 유지·관리 및 운영 업무를 수행한다.","doWork":"배전설비에 대한 불량기기 교체를 위하여 선로순시원이 보고한 점검자료를 검토하고 기기의 개·보수계획을 수립하여 보고한다. 불량기기의 발생 시 현장수리 가능성, 교체 여부, 임시조치의 필요성 검토 및 전주, 변압기, 전선, 개폐기 등 부속품의 이상점검을 위하여 현장조사를 실시한다. 이상 및 장애요인이 있는 변전설비 및 부속설비는 교체 또는 수리한다. 배전설비 및 부속기기에 대한 교체 및 보수 사항이 발생하면 설치시기, 장소, 기기제원, 시공자 등에 대한 제반 이력사항을 기기카드에 기록하여 관리한다. 선로 및 관련 전력배전설비가 적정 규정대로 유지·관리될 수 있도록 배전계통 운영을 한다. 배전 설비의 개·보수에 따른 설계업무, 시공에 따른 인·허가업무 및 승인업무, 시공감독 및 감리업무를 한다. 배전선로에 설치 운영 중인 각종 배전용기기에 대한 불량현황의 분석과 자체보수를 통한 품질 향상방안을 연구·검토하고 관련 부서에 개선사항을 보고한다. 배전운영실에 대한 관리업무를 한다. 유선, 케이블 등의 통신선로 및 관련 기기에 대한 전주사용에 대한 접수·기술검토·승인 및 요금징수에 대한 업무를 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"배전기기관리원","certLic":"전기기사, 전기공사기사","dJobECd":"8330","dJobECdNm":"[8330]발전·배전 장치 조작원","dJobJCd":"8610","dJobJCdNm":"[8610]발전 및 배전장치 조작원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002207:1', '{"dJobCd":"K000002207","dJobCdSeq":"1","dJobNm":"변전설비운전원","workSum":"발전소에서 받은 고압의 전력을 배전소에 보내기 위하여 적당한 전력으로 감압하는 변전설비를 조작하는 제반 업무를 수행한다.","doWork":"변압기, 차단기, 단로기, 보호계전기 등의 변전설비를 운영·관리하기 위하여 모니터에 나타난 선로의 전압·전류·전력량, 선로, 보호계전기 등의 상태이상 및 장애요인을 감시한다. 배전선로의 이상발생이 감지되면 해당 지역의 배전담당자에게 통보하고 순시점검을 요청한다. 선로 및 변전설비의 유지·보수를 위한 정전 작업 시 전력을 차단하기 위한 휴전작업을 하고 주요사항을 급전소 및 관련 변전정비책임자에게 통보한다. 제어반에 긴급상황 신호가 나타나면 정상 작동상태가 되도록 변전설비를 조작한다. 사고발생으로 인한 제어기능의 문제점을 제거하기 위하여 수동으로 차단기를 조작한다. 변전설비의 이상 점검을 위하여 주기적으로 순회 점검한다. 부하변동 등에 대한 기록 통계를 산출하여 기록하고, 문제점 발생 시 보고서를 작성하여 보고한다. 근무 중 조치사항 및 특이사항을 기록하여 인수·인계한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"전기기사, 전기공사기사, 전기산업기사, 전기공사산업기사  ","dJobECd":"8330","dJobECdNm":"[8330]발전·배전 장치 조작원","dJobJCd":"8610","dJobJCdNm":"[8610]발전 및 배전장치 조작원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003158:1', '{"dJobCd":"K000003158","dJobCdSeq":"1","dJobNm":"송변전설비전자제어원","workSum":"관내 변전설비 및 송전설비가 안정적으로 운영되도록 감시·유지하는 전자제어, 정보통신, 원격감시제어 등의 설비를 운영·유지·관리하고 보수한다.","doWork":"송·변전설비의 안정적 운영을 위하여 전자·통신설비, 데이터통신설비, 전자응용설비, 무선설비 등의 이상 및 장애 요인을 점검하고, 원활한 작동이 이루어지도록 유지·관리한다. 송·변전 관련 각종 전자제어설비의 신·증설 및 개·보수에 따라 설계도를 작성하고, 시공 시 작업원을 감독한다. 변전소와 변전소 간의 원활한 연락을 위해 무선통신 및 내선전화를 관리하고 유지·보수한다. 관할 변전소의 원격감시장비를 운영하고 이상 및 장애 요인 발생 시 보수한다. 송전선로 및 변전설비의 전력계통보호장비를 유지·관리한다. 무인변전소의 자동제어설비 및 감시설비를 유지·관리한다. 송·변전설비의 기능개선을 위해 자료를 분석하고 검토한다. 자동제어 관련 설비의 프로그램을 개발 및 운영하고, 자료를 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"전자기사, 정보처리기사, 정보통신기사","dJobECd":"8330","dJobECdNm":"[8330]발전·배전 장치 조작원","dJobJCd":"8610","dJobJCdNm":"[8610]발전 및 배전장치 조작원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003630:1', '{"dJobCd":"K000003630","dJobCdSeq":"1","dJobNm":"수력발전운전원","workSum":"소수력발전소를 포함한 수력발전소의 정상적인 기동, 정지를 위하여 발전설비의 수치, 발전기, MCR, 배전반 계기의 지시치와 보조기기 동작상태를 점검·기록하고 발전기의 출력, 전압, 주파수 등의 조정을 위하여 각종 배전반을 제어·운전하며 건설, 현대화, O/H시 시운전한다.","doWork":"댐의 저수량 및 유입량 등을 감안하여 발전 여부를 검토하고, 발전기를 기동하여 계통에 병입하며 출력, 주파수, 전압 등을 조정한다. 운전 중 배전반, 수차, 발전기, 조속기, 유압계통, 송·변전설비 및 기타 보조기기 등을 순시점검하며 기기의 이상 유무를 확인하고 운전기록지에 기록·관리한다. 계통사고 및 기타 요인으로 발전기가 정지되면, 신속히 응급조치를 취하고 상황을 파악하여 보고하며 재기동을 위한 긴급 조작으로 사고에 대처한다. 경미한 보수사항은 직접 보수업무를 수행하고 자체보수가 불가능한 보수사항은 상위 부서에 보고하여 신속한 복구가 이루어지도록 조치한다. 보수 시 공사시공을 감독하고 공정을 파악하여 상위 부서에 보고한다. 일일기동정지 및 주말기동정지와 돌발사고 시 또는 급전 사정에 따른 기동 및 정지 시 각 단계별 주요 기기의 조작을 감독 및 지원하고 주요사항은 인계일지에 기록하여 인계한다. 강우량, 상류지역 수위와 유하량, 하류상황, 기상에 관한 정보에 따라 유하량 및 저수위 변동을 예측하고 중앙급전원 및 수력발전책임운전원에게 보고하여 지시에 따라 발전설비를 제어·운전한다. 운전·제어에 대한 기술향상을 위하여 직무교육 및 가상사고 모의훈련 등의 교육훈련에 참여한다. 기타 수력발전 건설, 현대화, O/H 시 관련된 시운전에 관한 사항을 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"수력발전장치조작원","connectJob":"양수발전수차운전원, 수력제어반운전원, 수력수차운전원, 발전운전원","certLic":"일반기계기사, 산업안전기사, 발송배전기술사, 전기기사","dJobECd":"8330","dJobECdNm":"[8330]발전·배전 장치 조작원","dJobJCd":"8610","dJobJCdNm":"[8610]발전 및 배전장치 조작원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005044:1', '{"dJobCd":"K000005044","dJobCdSeq":"1","dJobNm":"원자로운전원","workSum":"원자력 발전소의 원자로계통, 안전계통, 핵분열계통, 기타 원자로설비 등을 조절하는 주제어반을 감시·기록·제어·시험한다.","doWork":"원자로의 냉각재계통, 제어봉의 위치지시계통 등 원자로의 보호 및 조정에 관련된 설비와 감속재계통, 기기의 냉각수계통, 원자로의 보조설비 등의 운전상태를 점검하여 일지에 기록한다. 계통의 압력과 원자로의 온도를 일정하게 유지하기 위하여 핵연료의 연소상태를 조절한다. 발전소의 기동과 정지, 계통사고, 방사선사고 등의 비상사태 시에는 원자로조종사(SRO)의 지시에 따라 업무를 수행한다. 설비의 가동이상이나 돌발사고의 원인을 파악한다. 원자로의 가동상태와 출력상황을 정기적으로 일지에 기록한다. 원자로의 효율적인 운전방안을 파악·정리하여 지침서를 작성한다. 발전소 운전중 수행되어야 하는 계속적인 시험을 실시한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"원자로조정제어원, RO(Reactor Operator) ","certLic":"원자로조종사면허","dJobECd":"8330","dJobECdNm":"[8330]발전·배전 장치 조작원","dJobJCd":"8610","dJobJCdNm":"[8610]발전 및 배전장치 조작원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006907:1', '{"dJobCd":"K000006907","dJobCdSeq":"1","dJobNm":"원자로현장운전원","workSum":"원자로의 정상운전, 과도상태발생시 및 사고시 현장 기기의 조작 및 각종 설비 운전상태를 감시·기록·조정⦁시험 등 안전운전에 관한 제반업무를 수행한다.","doWork":"가동 중인 펌프, 압축기, 폐기물설비 등과 같은 보조기기의 회전속도, 음향, 온도, 압력, 냉각수, 윤활유 등을 점검·기록한다. 원자로의 가동 및 정지에 필요한 준비작업을 수행한다. 각종 측정장비나 계측기를 사용하여 원자로의 정상가동 여부를 판별하는 자료를 정리한다. 원자로 보조기기의 운전장애 요인을 파악하여 관계 부서에 보고하고 사고원인을 파악한다. 정기보수계획에 따른 보수상황을 파악하여 보수가 완료되면 정상가동 여부를 확인한다. 발전소 운전 중 수행되어야 하는 계속적인 시험을 실시한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"원자로조정사면허, 원자력기사 ","dJobECd":"8330","dJobECdNm":"[8330]발전·배전 장치 조작원","dJobJCd":"8610","dJobJCdNm":"[8610]발전 및 배전장치 조작원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006300:1', '{"dJobCd":"K000006300","dJobCdSeq":"1","dJobNm":"원전연료장전원","workSum":"최초연료 장전 및 핵반응이 완료된 원자로의 원전연료를 교체하기 위한 제반 업무를 수행한다.","doWork":"최초연료 장전 및 원자로의 원전연료 교체계획에 따라 신연료 인수 시 규격 및 수량을 확인한다. 원전연료 취급공구를 이용하여 반응이 완료된 원전연료를 원자로에서 인출하고, 각종 측정장비를 사용하여 연료의 건전성 유무를 확인한다. 신연료 및 교체대상 연료를 원자로에 장전하고 정확한 장전상태를 확인한다. 오염된 각종 측정장비와 공구의 제염작업을 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"원전연료취급원","certLic":"핵연료물질취급자면허","dJobECd":"8330","dJobECdNm":"[8330]발전·배전 장치 조작원","dJobJCd":"8610","dJobJCdNm":"[8610]발전 및 배전장치 조작원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007206:1', '{"dJobCd":"K000007206","dJobCdSeq":"1","dJobNm":"자가풍력발전기운영원","workSum":"자가 풍력발전설비를 조작·운영한다.","doWork":"풍력발전에 따라 전기계통과 발전기 운영, 조작, 응급조치 방법 등을 설비업체를 통해 교육받는다. 매뉴얼에 따라 풍력발전기의 상태를 점검하고 가동이 가능한지 확인한다. 풍황을 확인하여 발전가능한 풍황일 경우 풍력발전기를 가동하고 전력을 생산한다. 풍력발전을 중단할 경우 바람에 날개가 회전하지 않도록 제동장치를 작동시키고 풍력발전설비로부터의 전력공급계통을 차단한다. 제어판에 이상신호가 발생 시 풍력발전기의 작동을 중단하고 이상원인을 파악하여 유지보수업체에 수리를 요청한다. 간단한 고장에 대한 조치 등 유지보수 업무를 수행하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"8330","dJobECdNm":"[8330]발전·배전 장치 조작원","dJobJCd":"8610","dJobJCdNm":"[8610]발전 및 배전장치 조작원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003954:1', '{"dJobCd":"K000003954","dJobCdSeq":"1","dJobNm":"전력사령원","workSum":"열차운행에 필요한 전력설비에 대한 원격 제어를 한다.","doWork":"변전실 및 전기실 전력계통의 원활한 운용 및 원격제어장치, 컴퓨터 장치, 전원공급장치의 유지보수를 한다. 전력계통을 종합사령실에서 컴퓨터와 단말기를 이용하여 변전실 및 전기실을 원격감시제어하고 전력계통의 장애상황을 처리하고 원인을 분석한다. 전력사용량에 관련된 데이터를 수집하여 각종 통계 분석을 한다. 기계실의 컴퓨터 시스템과 주변장치를 점검하고 사령설비 및 단말장치를 보수한다. 임시연장 급전 및 임시계통을 변경한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"8330","dJobECdNm":"[8330]발전·배전 장치 조작원","dJobJCd":"8610","dJobJCdNm":"[8610]발전 및 배전장치 조작원","dJobICd":"H491","dJobICdNm":"[H491]철도 운송업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003488:1', '{"dJobCd":"K000003488","dJobCdSeq":"1","dJobNm":"중앙급전원","workSum":"안정적이고 경제적인 양질의 전력을 공급하기 위하여 발전계획과 전력공급계획을 기준으로 전력계통의 감시·제어 및 운영을 한다.","doWork":"전력수급계획과 수요변동에 대응하여 경제급전, 계통안정, 예비능력 등을 고려하여 발전기의 가동·정지를 지시하며 발전기 출력을 경제적으로 배분하여 해당 발전소에 출력조정을 지시한다. 발전 및 공급 부하의 상황에 따라 계통주파수를 규정치 이내로 유지하기 위하여 적정한 운전예비전력을 확보하고, 발전기의 출력변동특성, 조속기의 운전특성, 계통수요 변동추이를 파악하여 적절한 능동출력이 확보될 수 있도록 발전기의 운전상태를 파악한다. 발전 및 송·변전설비의 보수작업상황을 확인하여 관련 사업소와 해당 발전소 및 송전소에 통보하고, 계통구성 변경에 따른 계통전압 및 기타 변동상태를 확인하고 조작상황을 기록한다. 전력계통 사고의 상황과 원인을 파악하여 응급조치 및 복구를 지시하고 사고기록을 수집하여 검토한다. 수시로 급전상황판을 점검하여 급전전압, 계통주파수, 손실률 등을 검토하고, 상황 및 지시내용을 정리하여 보고자료를 작성한다. 담당 업무에 따라 단기전력수급 계획을 수립하고 송·변전 설비와 휴전작업에 대한 검토 및 승인하는 중앙급전사령관을 보조하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"급전사령원","dJobECd":"8330","dJobECdNm":"[8330]발전·배전 장치 조작원","dJobJCd":"8610","dJobJCdNm":"[8610]발전 및 배전장치 조작원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005579:1', '{"dJobCd":"K000005579","dJobCdSeq":"1","dJobNm":"태양열발전시스템운전원","workSum":"태양열발전시스템을 운영한다.","doWork":"작업일지를 통하여 운전 상태를 파악하고, 보호 장치 및 자동제어설비의 작동상태를 확인한다. 각종 지시계기와 기록계를 관찰, 점검, 확인 및 조정하고 현황을 기록한다. 보일러, 터빈, 발전기, 원동기를 가동·정지시키고 보조기기를 조작한다. 발전량, 송전량, 발전소 내 소비전력량, 사용 급수량 및 연료량, 증기발생량, 발전효율 등을 계산하고, 기기 운전 중에 발생하는 이상이나 고장의 원인을 분석한다. 유지·보수작업원의 안전을 위하여 고장난 회로 및 장치의 전원을 차단하거나 발전설비의 운영을 조정하고, 동시통제를 위해 다른 작업원 또는 발전소와 교신을 한다. 반사경(집광장치)을 세척하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"태양열발전운영원","dJobECd":"8330","dJobECdNm":"[8330]발전·배전 장치 조작원","dJobJCd":"8610","dJobJCdNm":"[8610]발전 및 배전장치 조작원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002634:1', '{"dJobCd":"K000002634","dJobCdSeq":"1","dJobNm":"터빈운전원","workSum":"고효율의 전력을 생산하기 위하여 발전기에 연결된 터빈 및 보조기기를 운전·조작한다.","doWork":"터빈, 급수가열기, 공기추출기, 탈기기(증기에 포함된 이물질을 제거하는 기계), 복수기 등 보조기기의 가동상태를 매시간 점검하고 각종 계기의 지시치를 관찰하여 기록한다. 가스건조기, 여과장치 등 각종 보호기기의 동작상태를 점검하고 결과를 기록한다. 터빈의 가동과 정지, 긴급사고 발생 시 터빈제어반조정원(전기)에게 연락하여 원인을 파악하고 조치를 취한다. 터빈설비의 기동·정지에 따른 설비운전을 한다. 설비의 이상 및 장애요인이 발생하면 응급조치를 한다. 정기보수공사 및 주요기기 보수 시 보수내용을 파악하여 관련 기기를 확인·조작한다. 작업내용을 작업일지에 기록하여 인계·인수한다. 기타 안전, 소방, 누유예방 및 에너지관리 업무를 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|고온|소음·진동|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"발전터빈조작원","certLic":"에너지관리산업기사","dJobECd":"8330","dJobECdNm":"[8330]발전·배전 장치 조작원","dJobJCd":"8610","dJobJCdNm":"[8610]발전 및 배전장치 조작원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003365:1', '{"dJobCd":"K000003365","dJobCdSeq":"1","dJobNm":"가스공급전기설비운용원","workSum":"가스를 공급하는 배관망 및 설비의 유지·관리와 개선을 위하여 전기설비를 운영·관리한다.","doWork":"가스공급 배관망에 부착되어 있는 각종 계측기 및 센서에 대한 정비계획을 세운다. 전기공사를 감독하고 감리한다. 체계적인 가스공급전기설비의 유지·관리를 위해서 이력관리를 한다. 용역업체를 관리한다. 설계도면, 기술서, 사양서 등을 검토하여 기술을 지원한다. 동작감지기, 폐쇄회로 카메라 등의 보안설비와 전력설비에 대한 유지·관리를 한다. 각종 전기설비에 대한 설비개선 방안을 마련한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|","workFunc1":"분석","workFunc2":"감독","workFunc3":"정밀작업","dJobECd":"8340","dJobECdNm":"[8340]전기·전자 설비 조작원","dJobJCd":"8620","dJobJCdNm":"[8620]전기 및 전자설비 조작원","dJobICd":"D352","dJobICdNm":"[D352]연료용 가스 제조 및 배관공급업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004934:1', '{"dJobCd":"K000004934","dJobCdSeq":"1","dJobNm":"가스생산전기설비운용원","workSum":"가스를 생산하기 위한 각종 전기설비의 유지·관리 및 정비를 위한 제반 업무를 수행한다.","doWork":"가스생산을 위한 전기설비의 유지·관리 및 정비에 대한 계획을 수립한다. 계획된 일정에 따라 전기설비를 점검한다. 생산기지 내의 변전소 및 발전소를 유지·관리한다. 저장탱크 등의 주요 생산설비의 센서 및 감지장치에 대한 작동상태를 점검한다. 설계도면을 검토하여 문제 해결방안을 마련한다. 전기설비와 관련된 각종 문서를 관리한다. 외부 정비업체를 감리·감독한다. 전기설비 관련 자재에 대한 품질을 검사한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"균형감각|","workFunc1":"분석","workFunc2":"감독","workFunc3":"정밀작업","dJobECd":"8340","dJobECdNm":"[8340]전기·전자 설비 조작원","dJobJCd":"8620","dJobJCdNm":"[8620]전기 및 전자설비 조작원","dJobICd":"D352","dJobICdNm":"[D352]연료용 가스 제조 및 배관공급업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006724:1', '{"dJobCd":"K000006724","dJobCdSeq":"1","dJobNm":"방사성폐기물처분시설운영원","workSum":"방사성폐기물처분시설의 계통·설비 등의 운전 및 운영하고 관리한다.","doWork":"공기조화계통, 방사성액체폐기물계통, 순수생산설비, 음용수 공급계통, 디젤발전기계통, 압축공기계통, 동굴배수계통, 화재방호계통 등을 운영한다. 설비 이상 유무를 점검하고 이상 설비의 정비를 요청한다. 정비작업 시 작업원에 대한 작업·복귀 허가를 확인하고 작업여건을 조정한다. 사고·고장 발생 시 처분시설의 비상운전을 수행한다. 안전을 위해 시설시험을 수행하고 계통 도면과 운영 절차 등을 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"일반기계기사, 공조냉동기계기사, 소방설비기사","dJobECd":"8340","dJobECdNm":"[8340]전기·전자 설비 조작원","dJobJCd":"8620","dJobJCdNm":"[8620]전기 및 전자설비 조작원","dJobICd":"E382","dJobICdNm":"[E382]폐기물 처리업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004822:1', '{"dJobCd":"K000004822","dJobCdSeq":"1","dJobNm":"전기설비공무기술원","workSum":"생산라인의 전기설비 및 장비를 설치·관리·수리한다.","doWork":"생산라인의 전기설비 및 장비를 설치한다. 생산라인에서 제품 생산 공정이 원활히 이루어지는지 중앙제어장치로 감시한다. 생산라인의 전기 등에 문제가 발생할 경우 수리한다. 생산라인의 전기설비 및 장비 등을 관리한다. 전기설비 및 장비 등의 수리, 점검 등에 관하여 일지를 작성한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|소음·진동|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"설치","similarNm":"전기설비장치공무기술원","certLic":"전기산업기사, 전기기사","dJobECd":"8340","dJobECdNm":"[8340]전기·전자 설비 조작원","dJobJCd":"8620","dJobJCdNm":"[8620]전기 및 전자설비 조작원","dJobICd":"F423","dJobICdNm":"[F423]전기 및 통신 공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005271:1', '{"dJobCd":"K000005271","dJobCdSeq":"1","dJobNm":"건전지제조현장감독자","workSum":"건전지를 제조하기 위하여 연속으로 이루어지는 각종 공정에 관여하고 기계를 조작하는 작업원의 활동을 감독·조정한다.","doWork":"작업명세서를 숙지하고 공정별로 작업원을 배치한다. 합제, 격리막, 와셔(Washer:볼트·너트 밑에 끼우는 부품), 탄소봉 등 필요한 부품의 수량을 확인한다.공정별로 기계의 준비작업을 감독하고 기계의 상태를 확인한다. 전체 프로세스가 원활하게 유지되도록 조립라인의 흐름을 관리하고 조정한다. 기계의 이상이나 전지제품의 불량이 보고되면 원인을 파악하고 조치한다. 작업원에 대한 기술교육과 안전교육을 수행한다. 필요한 작업일지를 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"유지","similarNm":"건전지제조반장","connectJob":"리튬전지조립반장, 알카라인전지조립반장, 건전지조립반장","dJobECd":"8351","dJobECdNm":"[8351]전기 부품·제품 생산기계 조작원","dJobJCd":"8631","dJobJCdNm":"[8631]전기 부품 및 제품 제조 기계 조작원","dJobICd":"C282","dJobICdNm":"[C282]일차전지 및 축전지 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006302:1', '{"dJobCd":"K000006302","dJobCdSeq":"1","dJobNm":"건전지합제제조원","workSum":"알카라인전지, 리튬전지 등을 제조하기 위해 이산화망간, 흑연, 아세틸렌 블랙, 전해액 등을 혼합하여 합제를 만드는 기계를 조작한다.","doWork":"이산화망간, 흑연, 아세틸렌 블랙, 전해액 등 건전지의 재료를 자동편량기에 투입한다. 합제혼합기를 가동시켜서 투입된 재료가 배합표에 따라 정확하게 배합되도록 정해진 시간 동안 기계를 가동시킨다. 합제선별기(스크린기)를 가동하여 생산된 분말형태의 합제를 입자의 크기에 따라 선별해서 담는다. 운반용 용기를 합제 배출구에 대기시켰다가 일정한 용량만큼의 합제를 용기에 담아서 다음 공정으로 운반한다. 합제를 경화·압착시키기 위해 건조로에서 합제를 건조시키기도 한다","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"건전지양극제조원","connectJob":"리튬전지합제제조원, 망간건전지합제제조원, 알카라인전지합제제조원","dJobECd":"8351","dJobECdNm":"[8351]전기 부품·제품 생산기계 조작원","dJobJCd":"8631","dJobJCdNm":"[8631]전기 부품 및 제품 제조 기계 조작원","dJobICd":"C282","dJobICdNm":"[C282]일차전지 및 축전지 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005874:1', '{"dJobCd":"K000005874","dJobCdSeq":"1","dJobNm":"건전지합제제조현장감독자","workSum":"알카라인전지, 리튬전지 등의 양극 재료인 합제를 제조하는데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"작업지시서와 일일생산량의 내용을 숙지한다. 합제 제조에 사용되는 재료의 편량은 정확한지, 재료의 투입순서가 작업지시서에 맞게 이루어지고 있는지를 점검한다. 작업원이 수행하는 기계의 준비작업을 감독하고 기계의 상태를 점검한다. 유해물질을 취급하는 작업원들에게 안전교육을 시킨다. 합제혼합기나 합제선별기 등의 기계에 이상이 있을 경우 원인을 분석하여 적절한 조치를 취한다. 작업일지를 작성한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"수동조작","similarNm":"건전지양극제조반장, 건전지합제제조반장","connectJob":"리튬전지합제제조반장, 망간건전지합제제조반장, 알카라인전지합제제조반장","dJobECd":"8351","dJobECdNm":"[8351]전기 부품·제품 생산기계 조작원","dJobJCd":"8631","dJobJCdNm":"[8631]전기 부품 및 제품 제조 기계 조작원","dJobICd":"C282","dJobICdNm":"[C282]일차전지 및 축전지 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001271:1', '{"dJobCd":"K000001271","dJobCdSeq":"1","dJobNm":"광섬유모재가공원","workSum":"섬유 모재(母材)를 제조하기 위하여 선반을 이용하여 석영 유리관을 가공한다.","doWork":"작업표준서에 의하여 작업공정과 가공할 섬유 모재의 규격, 형태 등을 파악, 확인한다. 가공에 필요한 석영유리관 가공선반 등의 이상 유무를 파악한다. 석영유리관 가공선반에 세척된 석영유리관을 장착하고 장비를 가동시켜 석영유리관에 배리어(Barrier)층과 코어(Core)층이 형성되는 과정을 모니터링한다. 모재제조과정이 종료된 후 장치에서 탈착하고 커팅한다. 레이저 스캐너를 사용하여 증착 여부, 두께, 길이 등을 검사한다. 검사 후 이상이 없으면 1차 모재를 2차 모재의 공간에 삽입하고 열가공하여 동일한 모재를 만드는 2차 모재 제조공정(또는 리츠공정)을 수행한다. 작업 후 석영유리관가공선반의 연결부와 가열부를 청소하고 화공약품을 보충한다. 가공 완료된 석영유리관은 광섬유 제조공정으로 이송시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8351","dJobECdNm":"[8351]전기 부품·제품 생산기계 조작원","dJobJCd":"8631","dJobJCdNm":"[8631]전기 부품 및 제품 제조 기계 조작원","dJobICd":"C283","dJobICdNm":"[C283]절연선 및 케이블 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004189:1', '{"dJobCd":"K000004189","dJobCdSeq":"1","dJobNm":"광섬유신선원","workSum":"광섬유모재로부터 광섬유를 뽑아내기 위하여 광섬유제조설비를 조작한다.","doWork":"작업공정 및 신선(伸線, Wire Drawing:강선(鋼線)·철선(鐵線)을 만들 때 다이의 구멍을 통해 뽑아내어 목적하는 모양과 치수의 선을 만드는 가공법)할 섬유모재의 규격과 제조할 광섬유의 외경, 길이 등을 파악, 확인한다. 가공에 필요한 광섬유 신선장치, 고압형 코팅기 등의 이상 유무를 파악한다. 전 공정에서 광섬유 모재를 수령한 후 광섬유제조제어장치에 모재번호, 외경, 길이 등 각종 사항을 입력하고 광섬유모재를 신선장치의 척(Chuck)에 고정시키고 장치를 가동하여 광섬유 신선작업을 수행한다. 광섬유제조설비의 고압형 코팅기에서 1·2차 코팅작업과 경화작업을 위해 제어장치를 조정하여 수행한다. 코팅작업까지 완료된 광섬유의 권취 과정을 제어패널을 통해 모니터링하며, 문제가 있을 경우 문제가 있는 것에 마킹을 한다. 신선작업이 끝나면 권취된 광섬유를 절단하고 검사작업을 위해 광섬유를 광섬유측정공정으로 이송시킨다. 작업이 완료된 후 신선장치 청소를 하고 점검한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"광섬유인선원","dJobECd":"8351","dJobECdNm":"[8351]전기 부품·제품 생산기계 조작원","dJobJCd":"8631","dJobJCdNm":"[8631]전기 부품 및 제품 제조 기계 조작원","dJobICd":"C283","dJobICdNm":"[C283]절연선 및 케이블 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005651:1', '{"dJobCd":"K000005651","dJobCdSeq":"1","dJobNm":"광섬유제조현장감독자","workSum":"석영유리관을 이용하여 광섬유를 생산하고 측정하는데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"광섬유 제조공정과 내용을 파악하고 이해한다. 각 생산공정을 관리, 감독한다. 때에 따라서 기술작업 지도도 병행한다. 작업표준서를 작성하며 작업체크표에 따라 제조원들이 지켜야 할 사항을 준수하는지 여부를 점검한다. 업무에 필요한 작업지도를 한다. 일일의 정상적인 생산 활동의 유지와 개선을 수행한다. 작업개선에 관계되는 개선제안을 원조한다. 일상 점검 및 조정의 확인과 지도를 하며 수시로 가동률을 파악한다. 작업원에게 안전교육을 실시한다. 품질향상을 위하여 작업원들을 감독·점검한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","similarNm":"광섬유제조반장","dJobECd":"8351","dJobECdNm":"[8351]전기 부품·제품 생산기계 조작원","dJobJCd":"8631","dJobJCdNm":"[8631]전기 부품 및 제품 제조 기계 조작원","dJobICd":"C283","dJobICdNm":"[C283]절연선 및 케이블 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005763:1', '{"dJobCd":"K000005763","dJobCdSeq":"1","dJobNm":"광섬유측정원","workSum":"신선(伸線)된 광섬유에 대하여 측정장비를 이용하여 구조특성 및 전송특성을 측정하고 합격 여부를 판정한다.","doWork":"측정장비의 이상 유무를 파악하고 작업표준에 따라 측정방법을 숙지한다. 측정장비의 스위치를 켜고 광섬유의 외관을 검사한다. OTDR(Optical Time Domain Reflectometer) 광손실측정기 등 측정장비를 사용하여 광섬유길이 측정, 광섬유손실측정, 코팅두께측정, 이심률, 분심률 등을 측정한다. 자료를 컴퓨터에 입력하여 종합·분석하고 그래프와 수치 등의 결과물을 출력한 후 합격 및 불합격 여부를 판정한다. 결과를 관련 부서에 통보하고 합격된 광섬유는 다음 공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"광섬유검사원","dJobECd":"8351","dJobECdNm":"[8351]전기 부품·제품 생산기계 조작원","dJobJCd":"8631","dJobJCdNm":"[8631]전기 부품 및 제품 제조 기계 조작원","dJobICd":"C283","dJobICdNm":"[C283]절연선 및 케이블 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002200:1', '{"dJobCd":"K000002200","dJobCdSeq":"1","dJobNm":"권선기조작원","workSum":"신선된 선재를 종류별로 구분하여 보빈(Bobbin)에 감는 권선기를 조작한다.","doWork":"권선기의 작동상태를 점검하고 구결별로 작업준비를 한다. 보빈을 축에 끼우고 선재의 끝을 보빈에 감는다. 기계를 작동시켜 연속으로 권선이 되게 하고 작업이 완료되면 제품의 식별을 위해 꼬리표를 부착한다. 제품을 포장하고 스티커를 부착하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"코일권선기조작원","dJobECd":"8351","dJobECdNm":"[8351]전기 부품·제품 생산기계 조작원","dJobJCd":"8631","dJobJCdNm":"[8631]전기 부품 및 제품 제조 기계 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005774:1', '{"dJobCd":"K000005774","dJobCdSeq":"1","dJobNm":"리튬이온이차전지전극제조원","workSum":"리튬2차전지의 양극, 음극 활물질을 동박이나 알루미늄박에 코팅하고 프레스슬리팅, 펀칭, 건조작업 등을 통해 전극을 제조한다.","doWork":"활물질과 바인더를 솔벤트(Solvent:다른 물질을 용해시키기 위해 사용하는 액체나 가스)에 녹여 믹서에서 양극과 음극의 코팅 슬러리(Slurry:고체와 액체의 혼합물 또는 미세한 고체입자가 물속에 현탁(懸濁)된 현탁액)를 만든다. 양극은 알루미늄 호일을, 음극은 동박을 코팅 Substrate로 하여 Slurry를 코팅한다. Dry Air(수증기를 전혀 함유하지 않은 공기)로 솔벤트(Solvent)를 증발시켜 전극을 제조하며, 이때 양면코팅과 간헐코팅을 한다. 금속호일과 전극필름의 접착력을 증대시키고 전극필름의 밀도증대를 위해 롤프레스를 이용하여 프레싱(금속, 플라스틱 등을 기계로 찍어 만드는 것)한다. 광폭의 전극을 셀의 규격에 맞추어 슬리터(Slitter)를 이용해 소폭으로 절단을 하고 셀 형상으로 펀칭을 한다. 공정 중에 혼입된 수분을 제거하기 위해 진공건조기를 이용해 진공에서 건조를 시킨다. 제조가 된 전극을 조립실로 이동시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"리튬이온전지전극제조원","certLic":"화학분석기능사","dJobECd":"8351","dJobECdNm":"[8351]전기 부품·제품 생산기계 조작원","dJobJCd":"8631","dJobJCdNm":"[8631]전기 부품 및 제품 제조 기계 조작원","dJobICd":"C282","dJobICdNm":"[C282]일차전지 및 축전지 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004661:1', '{"dJobCd":"K000004661","dJobCdSeq":"1","dJobNm":"리튬이온이차전지충방전원","workSum":"조립이 완료된 방전상태의 셀을 활성화시키기 위해 충방전과 에이징(Aging)을 통해 리튬이온2차전지를 만든다.","doWork":"조립이 완료된 방전상태의 셀을 화성장비에 위치시키고 전극을 연결하여 1차로 충전한다. 1차 충전된 음극 표면에 음극과 전해질 사이에 반응을 일으켜 SEI(Solid Electrolyte Inter-phase)를 형성한다. 충전과 방전 과정이 완료된 셀을 정해진 기간 동안 에이징(Aging)한다. 에이징 기간을 통해 전해액이 전극에 고르게 분포되도록 한다. 에이징을 통해 Ni, Fe, Cu 등의 금속불순물이 검출되는 기간을 파악하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"투입인출","similarNm":"리튬이온전지활성화원","certLic":"화학분석기능사","dJobECd":"8351","dJobECdNm":"[8351]전기 부품·제품 생산기계 조작원","dJobJCd":"8631","dJobJCdNm":"[8631]전기 부품 및 제품 제조 기계 조작원","dJobICd":"C282","dJobICdNm":"[C282]일차전지 및 축전지 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002921:1', '{"dJobCd":"K000002921","dJobCdSeq":"1","dJobNm":"리튬전지조립원","workSum":"여러 가지 조립기계로 리튬1차전지를 조립한다.","doWork":"작업명세서에 따라 가위 및 절단도구를 사용해서 리튬 은박지를 일정 크기로 절단한다. 격리막을 절단해서 일정한 모양으로 만들어주고 핫플레이트 위에 리튬 은박지를 고르게 편 다음 그 위에다 격리막을 놓고 완전하게 녹인다. 리튬메탈이 감겨있는 핀에다가 격리막을 감고 풀리지 않도록 열처리를 해준다. 개스킷(Gasket)이 결합된 음극핀(Sus-pin)을 용기(Can)에 삽입한다. 정량주입기를 사용해서 용기 속에 전해액을 주입한다. 커링기를 사용해서 조립이 다 된 용기와 선단부품을 조립·봉합한다. 초음파세척기를 사용해서 조립된 리튬전지를 세척한 후 선풍기와 건조로를 사용해서 건조시킨다. 반제품의 외관, 치수, 접착상태 등에 대해서 중간검사를 수행하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|다습|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"리튬1차전지조립원","dJobECd":"8351","dJobECdNm":"[8351]전기 부품·제품 생산기계 조작원","dJobJCd":"8631","dJobJCdNm":"[8631]전기 부품 및 제품 제조 기계 조작원","dJobICd":"C282","dJobICdNm":"[C282]일차전지 및 축전지 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006791:1', '{"dJobCd":"K000006791","dJobCdSeq":"1","dJobNm":"리튬폴리머전지조립원","workSum":"제조된 전극과 격리막을 알루미늄 팩에 포장하고 전해액을 주입하여 주로 휴대용기기에 사용되는 리튬폴리머 2차전지를 제조한다.","doWork":"수분과의 접촉을 최소화한 드라이룸에 입장을 한다. Superator Film에 전극을 일정한 간격으로 부착하고 지그재그로 형태를 만들어 테이핑하는 스태킹(Stacking) 작업을 한다. 외부와 전자흐름의 통로가 되는 양극과 음극 단자의 TAP을 부착시키는 탭 웰딩(TAP Welding) 작업을 한다. 알루미늄 호일에 전극 모양의 형상을 만들어 적층 형상으로 만들어진 베어셀(Bare Cell)을 넣은 후 밀봉을 하는 팩킹(Packing) 공정을 거쳐 케이스 안에 리튬폴리머 전해액을 주입한다. 극판에 함침을 완료하고 진공상에서 밀봉을 한 후 에이징(Aging), 충전, 방전, 최종검사 등을 하기 위한 다음 공정으로 이동시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"리튬이온전지조립원","connectJob":"리튬이온전지생산기조작원","certLic":"화학분석기능사","dJobECd":"8351","dJobECdNm":"[8351]전기 부품·제품 생산기계 조작원","dJobJCd":"8631","dJobJCdNm":"[8631]전기 부품 및 제품 제조 기계 조작원","dJobICd":"C282","dJobICdNm":"[C282]일차전지 및 축전지 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003771:1', '{"dJobCd":"K000003771","dJobCdSeq":"1","dJobNm":"마운트기조작원","workSum":"마운트기를 사용해서 스템과 필라멘트를 연결·고정시키고 스템의 리드선에 게터(전자관 내의 진공도를 높일 목적으로 관 속에 설치하는 화학물질)를 바르는 계선 공정을 담당한다.","doWork":"전 공정을 거친 스템을 컨베이어 등으로 이동시킨다. 기계의 회전판 위에 플래어, 도입선, 유리관이 조립된 스템을 놓는다. 기계의 필라멘트 공급대에 필라멘트를 놓고 마운트기를 가동시킨다. 기계를 작동해 스템에 앙카를 형성하고, 몰리브덴선을 심어 필라멘트를 걸어주도록 한다. 도입선에 질화바륨 등의 게터물질을 자동으로 도포하는 기계의 작동을 한다. 제조된 마운트의 외관, 필라멘트의 부착강도, 도포된 게터의 중량 등을 검사하기도 한다. 게터의 농도를 분석해서 희석제를 첨가하거나 저어주기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","similarNm":"계선조립원","connectJob":"게터도색원","dJobECd":"8351","dJobECdNm":"[8351]전기 부품·제품 생산기계 조작원","dJobJCd":"8631","dJobJCdNm":"[8631]전기 부품 및 제품 제조 기계 조작원","dJobICd":"C284","dJobICdNm":"[C284]전구 및 조명장치 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002029:1', '{"dJobCd":"K000002029","dJobCdSeq":"1","dJobNm":"망간건전지조립원","workSum":"봉인기, 튜브봉합기, 교압기 등 각종 기계를 조작하거나 연속적으로 탄소봉에 열처리를 해주고 접착물질을 도포하는 기계를 조작하여 망간건전지를 조립한다.","doWork":"작업명세서를 숙지하고 기계를 시험 가동시켜서 이상 유무를 검사한다. 봉인장치가 장착된 포장기계의 내부에 PVC 필름 롤을 장착한다. PVC튜브에 반제품 건전지를 집어넣고 튜브상부를 수축하고 저판과 저부 절연링을 장착해주는 기계를 작동시킨다. 외장관 봉합장치에 외장관(메탈자켓)을 투입하고 기계를 가동시켜서 튜브에 싸인 반제품 건전지에 외장관을 장착시킨다. 건전지 상부 절연링을 삽입하고 외장관 상부를 교압해주는 기계의 작동을 관찰한다. 혹은 일정한 크기로 절단된 와셔를 와셔삽입기의 공급대에 놓는다. 기계를 시험가동해서 합제가 충진된 아연관에 와셔가 정확하게 압착되고 있는가를 점검한다. 탄소봉을 기계의 자동투입구에 투입하고 기계를 시험 가동시켜서 탄소봉을 아연관에 삽입한 후 견본을 채취해서 삽입상태를 검사한다. 기계를 작동시키고 기계가 연속적으로 탄소봉을 가열하고 탄소봉의 상부에 접착제를 도포하고 수지봉구개를 삽입하는 공정을 감시한다. 반제품의 견본을 채취하여 조립 상태를 검사한다. 기계에 묻은 와셔 조각과 탄소가루 등을 청소한다. 플래트(Flat)건전지를 조립하기 위해서 전지의 양극 부문에 단자를 연결시키는 기계를 조작하기도 한다. 교압 공정이 끝난 후 견본을 추출해서 외장관의 교압상태와 부품들의 삽입상태 등을 검사하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"망가니즈건전지조립원","connectJob":"플래트건전지조립원, 건전지튜브삽입원, 건전지봉합원, 건전지와셔삽입원, 건전지탄소봉삽입원","dJobECd":"8351","dJobECdNm":"[8351]전기 부품·제품 생산기계 조작원","dJobJCd":"8631","dJobJCdNm":"[8631]전기 부품 및 제품 제조 기계 조작원","dJobICd":"C282","dJobICdNm":"[C282]일차전지 및 축전지 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004480:1', '{"dJobCd":"K000004480","dJobCdSeq":"1","dJobNm":"브러시제조원","workSum":"수동전단기·굴대·유압프레스를 사용하여 전동기 및 발전기에서 전류를 모으고 분배시켜 주는 일정 크기의 브러시를 제조한다.","doWork":"작업지시서에 따라 제조할 브러시의 명세서를 확인·검토한다. 작업에 필요한 기계장비와 작업공구를 준비한다. 도면 및 작업명세서에 따라 수동전단기를 사용하여 규정된 길이로 철망을 절단한다. 유압프레스베드 위의 고정나사를 조정하고 프레스베드에 감겨진 철망을 놓는다. 절단기를 이용하여 작업표준에 맞게 절단한다. 깃을 제작하여 보스에 용접한다. 집게를 사용하여 용해된 납에 압축된 브러시를 담그고 노출된 나락(Flap)을 조이기 위하여 땜질한다. 브러시 끝을 비스듬히 절단하기 위하여 띠톱을 사용한다. 각 공정 후 측정공구를 사용하여 작업명세서의 수치 및 규격과 비교하여 수정·보강한다. 완성된 제품은 다음 공정으로 이송시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"8351","dJobECdNm":"[8351]전기 부품·제품 생산기계 조작원","dJobJCd":"8631","dJobJCdNm":"[8631]전기 부품 및 제품 제조 기계 조작원","dJobICd":"C281","dJobICdNm":"[C281]전동기, 발전기 및 전기 변환ㆍ 공급ㆍ제어 장치 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002891:1', '{"dJobCd":"K000002891","dJobCdSeq":"1","dJobNm":"시렉스기조작원","workSum":"시렉스기를 사용해서 유리구와 프래어 스커트부를 봉지하고, 봉지된 유리구 내부를 진공시킨 후 아르곤, 네온, 증류수은 등의 불활성가스를 일정 압력으로 주입한다.","doWork":"기계의 회전판 위에 전 공정을 거친 계선된 스템을 놓고 유리구 공급대에 유리구를 놓는다. 기계를 가동시켜서 유리구와 계선된 스템을 조립하여 유리구 목 부분과 프래어 스커트부를 버너로 녹여 봉지하는 과정을 진행한다. 실링이 된 유리구의 내부 불순물을 제거하고 고진공상태로 만든다. 진공상태의 유리구에 아르곤, 네온, 증류수은 등의 불활성 가스를 일정 비율로 주입한다. 봉합된 유리구의 외관, 치수 등을 검사한다. 컨베이어 등을 이용해 다음 공정으로 이동시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"전구봉합원, 배기기조작원","dJobECd":"8351","dJobECdNm":"[8351]전기 부품·제품 생산기계 조작원","dJobJCd":"8631","dJobJCdNm":"[8631]전기 부품 및 제품 제조 기계 조작원","dJobICd":"C284","dJobICdNm":"[C284]전구 및 조명장치 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005270:1', '{"dJobCd":"K000005270","dJobCdSeq":"1","dJobNm":"알카라인전지조립원","workSum":"집전봉·두캡·개스킷 등의 부품을 조립해서 알카라인전지 제조에 사용되는 하부부품을 제조하는 기계를 조작하거나 연속 프로세스상 각종 부품을 통해 반제품 전지를 완제품으로 조립한다.","doWork":"전 공정에서 건전지합제제조원이 제적한 건전지 합제를 기계의 공급대에 투입한다. 철관 상부의 둘레를 압착해서 홈을 만들고 철관의 내부에 접착물질을 도포하는 기계를 가동시킨다. 기계를 사용해서 반제품 전지의 내부에 격리막을 삽입하고 일정한 크기로 절단된 핫-멜트(Hot-melt)가 반제품 전지의 내부에 투입·용융되도록 한다. 반제품 전지의 내부에 소량의 전해액을 주입시키기 위해 전해액 정량주입기를 가동시킨다. 아연젤 용기를 펌프에 연결시키고 젤주입기를 사용해서 일정량의 아연젤을 전지 내부에 주입시킨다. 전지의 하부부품을 봉합기의 공급대에 공급하고 봉합기를 가동시켜 하부부품과 철관을 조립·봉합한다. 중간 반제품의 외관, 치수 등을 검사하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|다습|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"플래트건전지조립원, 건전지튜브삽입원, 건전지봉합원, 건전지와셔삽입원, 건전지탄소봉삽입원","dJobECd":"8351","dJobECdNm":"[8351]전기 부품·제품 생산기계 조작원","dJobJCd":"8631","dJobJCdNm":"[8631]전기 부품 및 제품 제조 기계 조작원","dJobICd":"C282","dJobICdNm":"[C282]일차전지 및 축전지 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002407:1', '{"dJobCd":"K000002407","dJobCdSeq":"1","dJobNm":"유리관도포기조작원","workSum":"형광등을 만들기 위해 세척·건조된 유리관 내부에 형광물질을 도포시키는 코팅기를 조작한다.","doWork":"유리관세척기조작원으로부터 세척된 유리관이 기계의 컨베이어 물림쇠에 자동으로 장착되도록 기계를 조작한다. 혼합된 형광물질을 기계상부의 용액 저장통에 일정량 부어준다. 혼합 형광물질이 일정량만큼 분무되도록 하기 위해 분무노즐을 조정해준다. 기계를 작동시켜 세척된 유리관에 형광물질이 자동으로 도포되도록 해준다. 소각기(Baking)를 가동시켜서 형광물질이 일정한 두께로 도포된 유리관 내부를 건조시키고 불순물질을 제거한다. 도포된 형광물질의 두께와 도포된 유리구의 투과율을 검사하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8351","dJobECdNm":"[8351]전기 부품·제품 생산기계 조작원","dJobJCd":"8631","dJobJCdNm":"[8631]전기 부품 및 제품 제조 기계 조작원","dJobICd":"C284","dJobICdNm":"[C284]전구 및 조명장치 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004268:1', '{"dJobCd":"K000004268","dJobCdSeq":"1","dJobNm":"전선가공원","workSum":"자동차 및 가전제품에 장착되는 배전장치를 제조하기 위해서 전선을 절단·탈피·압착·방수하고 단자(Terminal)를 접속하는 기계를 조작한다.","doWork":"자동절단압착기에 절단 및 압착할 전선의 굵기, 절단할 길이, 탈피 길이 등에 관한 정보를 입력한다, 탈피에 필요한 칼날을 설치하고 압착할 단자의 종류에 따라 전선 말단부에 압착 단자를 압착하기 위한 어플리케이터(Applicator)를 설치한다. 전선롤(Roll)을 전선공급대에 장입하고 전송롤러에 전선의 앞단을 삽입한다. 압착단자롤 공급대에 공급하고 기계를 시험가동하고 기계의 작동상태를 관찰한다. 자동절단압착기로 압착되지 않는 전선은 수동압착기를 사용해서 절단·압착하고 단자를 접속한다. 중간탈피기와 결속기(조인트기)를 사용해서 전선의 중간 부위를 탈피하고 다른 전선과 연결시킨다. 전선의 압착상태·피복상태·단자의 파손 여부와 전선과 단자의 접속상태 등을 육안으로 검사한다. 수축튜브나 절연테이프를 이용하여 단자의 압축부위나 전선 간의 결속부위를 보강하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"전선절단원, 전선탈피원","dJobECd":"8351","dJobECdNm":"[8351]전기 부품·제품 생산기계 조작원","dJobJCd":"8631","dJobJCdNm":"[8631]전기 부품 및 제품 제조 기계 조작원","dJobICd":"C283","dJobICdNm":"[C283]절연선 및 케이블 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001544:1', '{"dJobCd":"K000001544","dJobCdSeq":"1","dJobNm":"전선건조주유원","workSum":"케이블의 절연저항을 높이기 위해 지권된 도체를 진공·가열·건조후 금속시스를 입힌 후 내부의 지권된 도체에 주유하는 기계를 조작한다.","doWork":"전선건조관과 진공배기장치 등의 설비를 점검하고 부대 설비의 압력 및 밸브의 작동상태를 확인한다. 지권작업이 완료된 케이블을 건조관 내에 넣는다. 진공배기장치를 가동시키고 내부 온도·온도의 증가속도·진공도 등을 확인한다. 일정 시간이 지나면 건조 작업을 완료하고 케이블의 건조상태를 확인한다. 저유탱크에 절연유를 충진하고 진공계·압력계·계기류 등의 작동상태를 확인한다. 케이블 진공기를 가동하고 진공상태를 유지하면서 적절한 절연유 주유 시점을 판단한다. 작업 표준서에 따라서 유압 수준을 설정하고 주유기를 가동시켜서 케이블에 절연유를 주유한다. 주유작업이 완료되면 배유장치를 사용해서 남은 절연유를 빼내고 진공장치와 주유기를 점검한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"케이블건조원","dJobECd":"8351","dJobECdNm":"[8351]전기 부품·제품 생산기계 조작원","dJobJCd":"8631","dJobJCdNm":"[8631]전기 부품 및 제품 제조 기계 조작원","dJobICd":"C283","dJobICdNm":"[C283]절연선 및 케이블 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003613:1', '{"dJobCd":"K000003613","dJobCdSeq":"1","dJobNm":"전선권취원","workSum":"압출작업으로 만들어진 각종 전선선재를 권취, 절단하여 반제품을 만들거나 집합, 연합(연선), 대연작업에 사용할 수 있도록 보빈(Bobbin)에 권취(Coiling)한다.","doWork":"작업지시서에 따라 압출, 절연, 검사 공정을 마친 전선선재를 준비한다. 전선선재를 권취기의 송출부에 걸고 보빈을 권취부에 장착한다. 송출보빈에서 선을 풀어 권취보빈에 연결한다. 계척기에 귄취할 길이를 입력한다. 버튼을 눌러 권취기를 작동시킨다. 권취상황을 주의 깊게 관찰하여 귄취속도, 장력을 점검한다. 수동권취기의 경우 전선을 가지런히 감기 위하여 보빈의 양끝단을 왕복 운동하는 트레비스를 수동으로 조작하기도 한다. 작업 중 절연불량, 단선 등으로 기계가 정지되면 조치한다. 계척기에 지시된 전선의 길이가 다 귄취되어 기계가 정지하면 새 보빈을 장치하고 작업을 반복한다. 작업 후 권취된 보빈을 포장, 적재 등 다음 작업장으로 이동한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8351","dJobECdNm":"[8351]전기 부품·제품 생산기계 조작원","dJobJCd":"8631","dJobJCdNm":"[8631]전기 부품 및 제품 제조 기계 조작원","dJobICd":"C283","dJobICdNm":"[C283]절연선 및 케이블 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005531:1', '{"dJobCd":"K000005531","dJobCdSeq":"1","dJobNm":"전선압출원","workSum":"고무나 플라스틱 등의 피복 재료로 전선이나 케이블을 연속 절연 또는 피복하는 기계를 조작하여 절연전선이나 케이블을 만든다.","doWork":"작업지시서에 따라 피복할 선재, 보빈, 피복재료를 준비한다. 절연압출기를 예열하고 선재와 피복재료를 공급한다. 선재 또는 연선이 감긴 보빈을 장착한다. 인쇄기의 제어판넬을 조작하여 전선의 길이, 규격 등의 인쇄를 준비한다. 온도조절기로 적정온도를 조절한다. 전선이동속도, 수압펌프압력, 압출금형 온도를 조절한다. 냉각수의 양과 온도를 점검한다. 코드류의 경우 전선피복이 잘 벗겨지게 하기 위하여 활석가루(탈피가루, 탈크가루)를 첨가하기도 한다. 전선의 외경, 편심도, 인쇄상태, 외관을 검사한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|고온|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"압출피복선제조원, 전선피복원, 전선압출기사, 절연전선제조원","connectJob":"쉬이즈원, 고무선제조원, 비닐선제조원, 가교압출원, 고무압출원, 태압출원, PVC압출원","dJobECd":"8351","dJobECdNm":"[8351]전기 부품·제품 생산기계 조작원","dJobJCd":"8631","dJobJCdNm":"[8631]전기 부품 및 제품 제조 기계 조작원","dJobICd":"C283","dJobICdNm":"[C283]절연선 및 케이블 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002598:1', '{"dJobCd":"K000002598","dJobCdSeq":"1","dJobNm":"전선연합원","workSum":"절연선을 필요 가닥수 만큼 꼬면서 선과 선 사이의 공간을 개재물로 채우고 연합된 선 위에 테이프를 사용하여 감아주는 설비를 조작한다.","doWork":"작업 표준서에 따라서 연합할 전선의 종류를 확인하고 절연된 선재가 감긴 보빈을 케이지에 장착한다. 전선 규격에 맞는 다이스(Dies)를 장착한다. 기계를 가동시키고 절연선재와 개재물이 원형으로 균일하게 연합되고 그 위에 테이프가 잘 감기는지 확인한다. 작업 중에 연합의 방향, 연합 배열, 외관, 외경 테이프가 감기는 방향 등을 주기적으로 점검한다. 연합된 전선이 명세서와 일치하는지 확인하기 위해서 마이크로미터 등으로 전선을 측정한다. 작업 후 작업내용을 기록하고 설비 상태를 점검한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8351","dJobECdNm":"[8351]전기 부품·제품 생산기계 조작원","dJobJCd":"8631","dJobJCdNm":"[8631]전기 부품 및 제품 제조 기계 조작원","dJobICd":"C283","dJobICdNm":"[C283]절연선 및 케이블 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002646:1', '{"dJobCd":"K000002646","dJobCdSeq":"1","dJobNm":"전선제조현장감독자","workSum":"전선을 제조하기 위해서 동선·알루미늄선과 같은 금속선재를 신선·연선·절연(피복)·연합하는 기계를 조작하는 작업원들의 활동을 감독·조정한다.","doWork":"작업지시서를 숙지하고 작업인원을 배치한다. 공정별로 기계의 준비작업을 감독하고 기계의 상태를 확인한다. 신입 작업원에 대한 기술 및 안전교육을 실시한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"전선제조반장","connectJob":"신선반장, 전선절연반장, 전선연선반장, 전선건조주유반장","dJobECd":"8351","dJobECdNm":"[8351]전기 부품·제품 생산기계 조작원","dJobJCd":"8631","dJobJCdNm":"[8631]전기 부품 및 제품 제조 기계 조작원","dJobICd":"C283","dJobICdNm":"[C283]절연선 및 케이블 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003364:1', '{"dJobCd":"K000003364","dJobCdSeq":"1","dJobNm":"전선지권원","workSum":"작업표준에 따라 지권기를 사용해서 도체위에 절연지를 연속적으로 감아서 절연한다.","doWork":"작업지시서에 따라 작업량과 재료를 확인, 점검한다. 지권기의 에어밸브, 에어필터의 작동상태, 유압상태 및 작동 여부를 점검한다. 사용할 패드의 장력을 측정하고 가이드 롤러의 회전상태를 확인한다. 소요절연 종이테이프와 권취용 보빈(Bobbin)을 지권기의 원판과 장착부위에 각각 붙이고 종이와 동선을 폴리셔(Polisher)를 통하고 기계를 운전하면서 뽑아낸다. OF용 전력케이블의 경우 도체드럼을 지권기의 공급대에 걸어서 도체의 단을 드럼에서 풀고, 먼저 도체의 단과 이어 절연지를 소정매수 지권기에 취부하고 기어를 바꾼다. 도체에 종이를 감을 준비를 하고, 권취보빈을 지권기의 권취스탠드에 건다. 지권기를 작동하여 종이를 감은 도체가 권취보빈에 소정의 길이만큼 감기면, 운전을 중단하고 도체를 절단하여 그 끝을 고정시키고 보빈을 권취스탠드에서 내려놓는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"힘든 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8351","dJobECdNm":"[8351]전기 부품·제품 생산기계 조작원","dJobJCd":"8631","dJobJCdNm":"[8631]전기 부품 및 제품 제조 기계 조작원","dJobICd":"C283","dJobICdNm":"[C283]절연선 및 케이블 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005355:1', '{"dJobCd":"K000005355","dJobCdSeq":"1","dJobNm":"전선지절원","workSum":"작업명세서에 따라 초고압 OF(Oil-Filled)케이블의 절연에 사용하기 위해서 절연지를 일정 폭으로 절단한다.","doWork":"작업지시서에 따라 작업량과 재료를 확인, 점검한다. 절연지 절단장치의 유압상태 및 작동 여부를 점검한다. 절연지 절단장치에 절연지의 폭과 두께에 적합한 절단 날 및 폭을 선정하여 축에 배열하고 너트와 베어링을 끼워 장착한다. 절단날의 이물림 깊이와 상태를 점검하고 조절한다. 선재의 끝단을 풀어 롤러를 통과시킨 다음 송출금형틀에 장착된 편조재료의 끝단을 당겨 선재에 묶는다. 절연지 롤을 송출축에 끼워 고정한 후절연지를 가이드 롤러에 걸어주고 절단날을 통과시켜 권취축에 풀칠하여 붙이고 불필요한 끝부분을 절단한다. 작업표준에 따라 절연지를 균일한 간격으로 절단할 수 있고, 절연지의 절단길이가 일정하도록 조정한다. 절단장치를 작동하여 절연지를 전단한다. 절단된 테이프를 기계에서 분리하고 권취축을 뽑아낸다. 작업 후 테이프의 끊어짐·주름·장력·감기는 상태를 점검한다. 절단된 절연지를 권취기에서 탈거한다. 다음 공정으로 이동한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8351","dJobECdNm":"[8351]전기 부품·제품 생산기계 조작원","dJobJCd":"8631","dJobJCdNm":"[8631]전기 부품 및 제품 제조 기계 조작원","dJobICd":"C283","dJobICdNm":"[C283]절연선 및 케이블 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003684:1', '{"dJobCd":"K000003684","dJobCdSeq":"1","dJobNm":"전선편조원","workSum":"목면, 유리섬유, 철사, 구리, 알루미늄 등의 재료를 직조하여 전선과 케이블의 피복을 형성하는 자동편조기를 조작한다.","doWork":"작업지시서에 따라 선재 및 소요자재를 확인한다. 편조기(Braiding Machine)에 선재를 장착한다. 편조기에 편조할 재료를 장착한다. 선재의 끝단을 풀어 롤러를 통과시킨 다음 송출금형틀에 장착된 편조재료의 끝단을 당겨 선재에 묶는다. 작업선재를 센터샤프트(풀림틀)에 밀어 넣고 장비를 작동한다. 연속적인 편조상태를 확인한다. 선재와 편조재가 원활히 공급되는지 확인한다. 편조된 선재를 권취기에서 탈거한다. 포장하거나 다음 공정으로 이동한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8351","dJobECdNm":"[8351]전기 부품·제품 생산기계 조작원","dJobJCd":"8631","dJobJCdNm":"[8631]전기 부품 및 제품 제조 기계 조작원","dJobICd":"C283","dJobICdNm":"[C283]절연선 및 케이블 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007238:1', '{"dJobCd":"K000007238","dJobCdSeq":"1","dJobNm":"젤리충전(충진)원","workSum":"통신케이블을 생산하기 위해서 집합 또는 연합 공정이 끝난 반제품 전선에서 테이프를 벗겨내고 침수방지용 젤리를 충전(충진)시킨 후 테이프를 감아주는 기계를 조작한다.","doWork":"작업명세서를 숙지한 후 소형기중기를 사용해서 젤리를 기계의 탱크에 넣는다. 규격에 맞는 다이스 및 젤리 충진기통의 작동밸브를 열어 젤리 다이스를 분해하고 장착한다. 젤리 충진기통의 작동벨브를 열어 젤리를 녹이고 젤리가 일정한 온도로 유지되도록 스팀 밸브를 조절한다. 선재가 감긴 보빈을 장착하고 기계를 작동시킨다. 선재에 젤리가 충진되는 상태를 관찰하고 이상 유무를 확인한다. 테이프가 감긴 보빈을 장착하고 피치의 상태를 조정한다. 심선을 젤리 다이스(Dies)에 통과시키고 충진 모터를 작동시키며 테이프가 감긴 상태를 확인한다. 공정 중에 심선의 충진상태를 수시로 확인하고 각종 계기의 작동상태를 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8351","dJobECdNm":"[8351]전기 부품·제품 생산기계 조작원","dJobJCd":"8631","dJobJCdNm":"[8631]전기 부품 및 제품 제조 기계 조작원","dJobICd":"C283","dJobICdNm":"[C283]절연선 및 케이블 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003217:1', '{"dJobCd":"K000003217","dJobCdSeq":"1","dJobNm":"철심적층원","workSum":"전동기, 발전기, 변압기 등의 부품을 제작하기 위하여 특정 형태로 찍어낸 철판을 쌓아 프레스기로 압착하여 적층한다.","doWork":"권선기의 작동상태를 점검하고 구결별로 작업준비를 한다. 보빈을 축에 끼우고 선재의 끝을 프레스 작업대 위에 올려놓는다. 전동기나 발전기의 고정자(Stator), 회전자(Rotor) 등을 만드는데 사용할 철심(코어)과 변압기 내부에 사용되는 철심을 제작하기 위해 일정한 형태의 금형틀에 따라 프레스기로 철판을 찍어낸다. 회전기의 전기자(電氣子) 철심이나 변압기의 철심(규소 강판을 0.35mm 정도의 얇은 판으로 만들어서 각각 절연 처리한 후에 몇 장이고 필요한 만큼 쌓아 전류손(損)을 적게 한 것)을 노칭기, 면취가공기를 사용하여 사각모양을 원형으로 가공하거나 철판의 모서리를 부드럽게 가공한다. 고정자나 회전자, 외함, 변압기 철심 등 제작하는 품목마다 별도의 정해진 치수와 위치에 맞추어 일정한 형태로 가공된 철심을 쌓는다. 유압프레기를 사용하여 적층된 철심을 압착하여 고정자, 회전자, 외형 등의 형태를 만든다. 완성품이 명세서와 일치하는지를 체크한다. 불량제품은 분리한다. 완성된 제품은 출하를 위하여 다음 공정으로 이송시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"철심제작원, 코어적층원, 코아적층프레스조작원","dJobECd":"8351","dJobECdNm":"[8351]전기 부품·제품 생산기계 조작원","dJobJCd":"8631","dJobJCdNm":"[8631]전기 부품 및 제품 제조 기계 조작원","dJobICd":"C281","dJobICdNm":"[C281]전동기, 발전기 및 전기 변환ㆍ 공급ㆍ제어 장치 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007221:1', '{"dJobCd":"K000007221","dJobCdSeq":"1","dJobNm":"축전지극판사상원","workSum":"축전지에 사용되는 일정 규격의 건조 플레이트 극판을 생산하기 위해서 패널 형태의 극판을 다듬고 절단하는 사상기계를 조작한다.","doWork":"지게차나 컨베이어를 사용해서 화성공정에서 건조된 건조극판을 운반한다. 작업명세서에 따라 극판을 적재하고 기계에 장착한다. 절단기를 가동시키고 극판의 절단 상태를 관찰한다. 잘못 절단된 극판을 모아서 납용해 공정으로 보내기도 한다. 수분계·초시계·마이크로미터 등을 사용해서 극판의 절단 상태 및 치수 등을 검사한다. 완성된 건조 플레이트 극판을 다음 공정인 조립공정으로 보내기 위해 핸드카에 적재한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8351","dJobECdNm":"[8351]전기 부품·제품 생산기계 조작원","dJobJCd":"8631","dJobJCdNm":"[8631]전기 부품 및 제품 제조 기계 조작원","dJobICd":"C282","dJobICdNm":"[C282]일차전지 및 축전지 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001945:1', '{"dJobCd":"K000001945","dJobCdSeq":"1","dJobNm":"축전지극판적층원","workSum":"자동 및 반자동 기계를 사용해서 음극판과 양극판을 격리막에 끼워 단으로 쌓아서 축전지 제조에 사용되는 적층셀을 만든다.","doWork":"사상공정을 통해 다듬고 절단된 플레이트 극판을 핸드카를 이용해서 운반한다. 극판적층기의 저장통에 양극판과 음극판을 적재한다. 양극판으로 향하게 되어 있는 격리막 저장통에 격리막을 놓는다. 일정 수량의 극판과 격리판을 번갈아 가며 쌓는 극판적층기를 가동시킨다. 극판과 격리막이 기준에 맞게 제대로 적층되었는가를 검사하고 이상이 발견되면 수동공구를 사용해서 기계를 조정한다. 진공청소기를 사용하여 기계에서 산화물·먼지 등을 제거한다. 적층셀을 용접하기 위한 공정으로 이동시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"축전지극판축적원","dJobECd":"8351","dJobECdNm":"[8351]전기 부품·제품 생산기계 조작원","dJobJCd":"8631","dJobJCdNm":"[8631]전기 부품 및 제품 제조 기계 조작원","dJobICd":"C282","dJobICdNm":"[C282]일차전지 및 축전지 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003244:1', '{"dJobCd":"K000003244","dJobCdSeq":"1","dJobNm":"축전지극판화성원","workSum":"극판의 화학적 에너지를 전기적 에너지로 바꿔주기 위해 화성극판을 만들기 위한 화성·수세·건조 작업을 한다.","doWork":"극판숙성실에서 숙성, 건조된 생극판을 지게차나 컨베이어로 운반한다. 생극판을 화성탱크의 전도체 베이스 위에 놓고 전해액 주입기를 사용해서 규정된 비중의 화성 산용액이 혼합된 전해액을 화성탱크에 주입한다. 화성탱크에 연결된 충전기를 가동시켜서 생극판에 전기 충전을 시킨다. 전기 충전이 완료되면 화성탱크에서 극판을 건져내고 수세탱크에서 극판을 씻어낸다. 극판이 제대로 충전이 되었는가를 육안으로 검사하고 충전이 되지 않은 극판을 골라내서 재충전을 시킨다. 화성탱크·수세탱크·건조기 사이로 극판을 이송하는 컨베이어를 관리하고 속도를 조절한다. 수세된 극판을 선반(Rack) 위에 놓고 건조기 안에 선반을 보낸다. 건조기를 가동시키고 정해진 시간 동안 극판을 건조시켜 건조극판으로 만든다. 화성 작업 도중에 화성시간·전해액의 황산비중·화성탱크의 온도 등을 검사한다. 이송장치가 설계된 수세탱크, 건조실을 관리하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|고온|다습|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8351","dJobECdNm":"[8351]전기 부품·제품 생산기계 조작원","dJobJCd":"8631","dJobJCdNm":"[8631]전기 부품 및 제품 제조 기계 조작원","dJobICd":"C282","dJobICdNm":"[C282]일차전지 및 축전지 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006488:1', '{"dJobCd":"K000006488","dJobCdSeq":"1","dJobNm":"축전지제조현장감독자","workSum":"축전지를 제조하기 위하여 주조, 극판제조, 조립, 검사하는 작업원들의 활동을 감독·조정한다.","doWork":"주문서나 작업지시서의 내용을 숙지한다. 생산계획에 따라 설비, 원료, 인원 등을 고려해서 세부 실행계획을 수립하고 작업내용을 작업원들에게 지시한다. 작업배치 및 인원을 관리하고 안전교육 및 제반 기술교육을 실시한다. 주조된 그리드(격자) 및 부품의 외관 및 치수, 전해액의 농도, 혼합된 연화물(극판활물질)의 성분 등을 확인한다. 설비를 점검하고 작업장의 안전상황을 점검한다. 작업일지를 작성한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|고온|다습|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"축전지제조반장","connectJob":"축전지극판제조반장, 축전지극판화성반장, 축전지조립반장, 축전지연화물제조반장","dJobECd":"8351","dJobECdNm":"[8351]전기 부품·제품 생산기계 조작원","dJobJCd":"8631","dJobJCdNm":"[8631]전기 부품 및 제품 제조 기계 조작원","dJobICd":"C282","dJobICdNm":"[C282]일차전지 및 축전지 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001532:1', '{"dJobCd":"K000001532","dJobCdSeq":"1","dJobNm":"축전지조립원","workSum":"스태킹(Stacking) 작업으로 얻어진 적충셀을 이용해 자동차·산업용 납축전지 및 니켈수소, 니켈카드뮴 등 기타 축전지를 조립한다.","doWork":"스태킹 작업이 완료가 된 적충셀을 이동시킨다. 용접연이나 납땜 조립기를 사용해서 축전지 납부품과 적충셀을 군용접해 군접셀을 만든다. 용접된 양극소자를 축전지 몸체(케이스)에 넣어 셀차입하고 땜납을 통해 셀연결 용접을 한다. 접착물질이나 융착기 등을 사용해서 축전지 몸체(케이스)와 축전지 커버를 접착하고 에폭시(Epoxy) 작업을 한 후 건조실에서 일정 시간 건조시킨다. 전해액이 누출되지 않도록 축전지 뚜껑에 방수링을 삽입하고 양극 포스트에 단자(Terminal)를 용접해서 붙인다. 축전지 뚜껑에 극성을 표시하고 제품의 종류에 따라서 알루미늄 봉합기를 사용해서 뚜껑에 알루미늄 테이프를 부착하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|고온|다습|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"축전지봉합원, 축전지제조기조작원","dJobECd":"8351","dJobECdNm":"[8351]전기 부품·제품 생산기계 조작원","dJobJCd":"8631","dJobJCdNm":"[8631]전기 부품 및 제품 제조 기계 조작원","dJobICd":"C282","dJobICdNm":"[C282]일차전지 및 축전지 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003518:1', '{"dJobCd":"K000003518","dJobCdSeq":"1","dJobNm":"축전지충전원","workSum":"드라이 반제품 축전지에 정제황산 전해액을 주입하고 충전시켜 주액 반제품을 만드는 액주입 기계를 조작한다.","doWork":"전해액 주입기의 탱크에 정제황산 전해액을 채운다. 전해액 정량주입기를 사용해서 일정량의 전해액을 드라이 반제품 축전지에 주입한다. 전해액의 누액을 방지하고 축전지를 밀봉하기 위해서 수공으로 밴드캡을 삽입하고, 초음파 융착기를 사용해서 축전지 상부에 상개를 융착시킨다. 밀봉된 축전지에 충전기를 연결시키고 충전시킨다. 충전의 방법은 사이클 충전, 트리클 충전, 부동 충전, 저장 중 재충전 등이 있으며, 항시 충전 시에는 정전압 충전을 한다. 실험기구들을 사용해서 충전 작업 동안 충전지 전해액의 산 비중이 적당한지 여부를 확인하고 산과 물을 혼합한다. 불충분하게 전해액이 주입된 경우 전해액을 추가로 주입한다. 일부 산업용 축전지의 제조 공정에서는 충방전기를 사용해서 충전, 방전, 충전의 정해진 사이클로 축전지를 충전시키기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|다습|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"충전기조작원","dJobECd":"8351","dJobECdNm":"[8351]전기 부품·제품 생산기계 조작원","dJobJCd":"8631","dJobJCdNm":"[8631]전기 부품 및 제품 제조 기계 조작원","dJobICd":"C282","dJobICdNm":"[C282]일차전지 및 축전지 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005640:1', '{"dJobCd":"K000005640","dJobCdSeq":"1","dJobNm":"코일권선기조작원","workSum":"코일권선기 및 코일와인딩기를 사용하여 교류전동기, 발전기, 변압기 등에 사용되는 트랜스(Trance), 솔레노이드(Solenoid), 릴레이(Relay) 등의 부품에 코일을 감는다.","doWork":"작업지시서에 따라 권선코일의 규격을 확인한다. 권선기 및 코일와인딩기의 유압 및 작동 여부를 점검한다. 작업명세서의 규격대로 코일의 길이를 조절하고 권선횟수를 정하여 권선기에 입력, 조작한다. 권선기를 작동시켜 일정 회전수가 감겼을 때 기계를 정지시키고 코일 사이나 감겨진 층위로 절연재를 싼다. 제품에 이상이 없을 시 연속작업을 한다. 큰 코일의 경우는 플라스틱재료를 코일 사이에 삽입시키기도 한다. 코일을 고정시키기 위해 테이프로 묶기도 하며, 해머와 망치로 코일을 두들겨 권선 끝을 성형하기도 한다. 코일을 석면·솜·유리운모·종이테이프로 감고 코일 위를 솔질하거나 바니시(Varnish)·에폭시(Epoxy)·왁스 안에 권선한 코일뭉치를 잠기게 하여 절연성을 높이기도 한다. 시험램프를 사용하여 권선의 연속도를 알기 위해 코일을 검사하기도 하며 절연재를 절단 및 성형하기도 한다. 완성된 제품은 다음 공정으로 이송시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"고정자코일권선기조작원","dJobECd":"8351","dJobECdNm":"[8351]전기 부품·제품 생산기계 조작원","dJobJCd":"8631","dJobJCdNm":"[8631]전기 부품 및 제품 제조 기계 조작원","dJobICd":"C281","dJobICdNm":"[C281]전동기, 발전기 및 전기 변환ㆍ 공급ㆍ제어 장치 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006004:1', '{"dJobCd":"K000006004","dJobCdSeq":"1","dJobNm":"콘덴서가공원","workSum":"자기 단일체 콘덴서(축전기)를 만들기 위하여 기질·전극·성단재료를 가공·처리한다.","doWork":"일정한 점도를 유지하기 위하여 혼합물에서 성분요소를 첨가 또는 증발시키고, 혼합물을 분쇄한 후에 자동테이프 구조장치를 사용하여 자기재료를 시트(Sheet)로 만든다. 시트를 조각으로 절단한다. 절단된 시트의 조각들을 두께와 질에 따라서 검사하고 분류한다. 실크스크린 인쇄장비를 사용하여 전극재료를 조각 위에 도포한다. 인쇄된 조각을 순서대로 쌓거나 적층하기 위해서 적층프레스를 사용하여 압착시킨다. 자동절단기를 사용하여 적층물을 작은 조각(Chip)으로 절단한다. 적층된 재료를 용융시키고 용융된 작은 조각의 정해진 끝부분에 자동침지장비를 사용하여 완성된 단일체 콘덴서 중간부분의 광을 낸다. 리드선을 접착시키거나 에폭시 재료로 콘덴서를 싸기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"콘덴서은도원, 콘덴서조립원, 콘덴서디스크삽입원","dJobECd":"8351","dJobECdNm":"[8351]전기 부품·제품 생산기계 조작원","dJobJCd":"8631","dJobJCdNm":"[8631]전기 부품 및 제품 제조 기계 조작원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003757:1', '{"dJobCd":"K000003757","dJobCdSeq":"1","dJobNm":"콘덴서점철권취원","workSum":"전해콘덴서를 제조하기 위하여 설계조건에 따라 양극·음극 알루미늄박에 일정한 간격으로 인출단자를 접속하며 전해지를 넣어 원통형 소자로 감아주는 기계를 조작한다.","doWork":"공정카드의 단자, 롤수, 전해지명 등 작업지시 내용을 파악하고 점철권취기의 카운터 및 드롭단자를 확인하고 박장길이 및 중간길이를 버니어캘리퍼스(Vernier Calipers)로 잰다. 자동공급장치에 T형 단자를 넣고 점철권취기에 양극·음극박과 전해지 및 접착테이프를 건다. 알루미늄박의 길이와 전해지의 진행롤러를 조정한다. 기계를 가동시키고 점철단자의 위치, 박장길이, 단자간격, 빠짐, 어긋남, 불량 등을 관찰한다. 이력전표를 부착하고 자동공급장치의 남은 단자를 제거한다. 완료된 소자에 라벨을 부착한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|고온|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8351","dJobECdNm":"[8351]전기 부품·제품 생산기계 조작원","dJobJCd":"8631","dJobJCdNm":"[8631]전기 부품 및 제품 제조 기계 조작원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001826:1', '{"dJobCd":"K000001826","dJobCdSeq":"1","dJobNm":"콘덴서제조현장감독자","workSum":"전해콘덴서, 자기콘덴서 등을 제조하는데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"작업계획에 따라 작업원을 배치하고 소요자재를 청구하여 각 공정별로 투입한다. 기계 및 설비를 점검하고 문제점을 파악하여 조치한다. 공정카드 및 작업일지를 기록한다. 작업내용에 따라 작업원에게 지시·배치한다. 작업의 진행상황을 파악하고 작업내용을 보고한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원 및 자재를 공급한다. 작업계획에 따라 세부실행항목을 수립하고 작업절차 및 방법을 결정하여 작업원에게 작업내용을 지시하고 작업배치를 한다. 표준작업명세에 따라 지시된 작업이 이루어지는지 작업원과 함께 작업하며 작업상황을 관찰하고 작업내용을 점검한다. 작업원의 직무교육 및 안전위생 교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴·해결하고 문제점을 보완한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|고온|소음·진동|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"콘덴서제조반장","connectJob":"콘덴서권취반장, 콘덴서소성반장, 콘덴서점철반장, 콘덴서조립반장","dJobECd":"8351","dJobECdNm":"[8351]전기 부품·제품 생산기계 조작원","dJobJCd":"8631","dJobJCdNm":"[8631]전기 부품 및 제품 제조 기계 조작원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003366:1', '{"dJobCd":"K000003366","dJobCdSeq":"1","dJobNm":"필라멘트제조원","workSum":"텅스텐·몰리브덴(Molybdenum) 등의 재료를 이용하여 형광등·백열등 같은 조명기구나 각종 전자기구의 전극에 사용되는 필라멘트를 제조한다.","doWork":"텅스텐선·몰리브덴선이 감긴 스풀(Spool)을 권선기 홀더(Holder)에 끼우고 장력을 조절한다. 핸드휠을 풀고 권선용 스풀을 끼우고 나사로 조인다. 장력을 게이지로 점검하고 장력홀더에 가중벨트를 조여 권선장력을 조절한다. 기계를 가동시켜 꼬임권선 작업을 한다. 권선된 제품을 열처리장치에 넣고 일정 시간 열처리한다. 코일링공정이 완료되면 커팅공정에서는 절단기를 가동시켜 열처리된 권선 제품을 규격에 맞게 절단한다. 용해공정에서는 절단된 권선 제품을 용해기에 투입해서 심선을 제거해 준다. 생산된 필라멘트 제품에 대한 외관·치수 등의 중간검사를 필라멘트검사원과 함께 육안이나 영상자동 측정 시스템을 통해 수행하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"전구필라멘트제조원","certLic":"전기기능사","dJobECd":"8351","dJobECdNm":"[8351]전기 부품·제품 생산기계 조작원","dJobJCd":"8631","dJobJCdNm":"[8631]전기 부품 및 제품 제조 기계 조작원","dJobICd":"C284","dJobICdNm":"[C284]전구 및 조명장치 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001962:1', '{"dJobCd":"K000001962","dJobCdSeq":"1","dJobNm":"광원구동회로제조관리원","workSum":"광원구동회로 제조장비를 운영하고 생산성 향상을 위한 엔지니어링 및 인력운영을 담당한다.","doWork":"회로부품을 PCB기판에 실장하는 각 공정을 세팅한다. 생산공정을 운영하여 제품을 생산한다. 생산성을 높이고 불량률, 제조원가를 낮추기 위한 개선 방안을 고안한다. 생산된 광원구동회로의 입출력 특성을 테스트하여 품질을 측정한다. 제품이 안정적으로 양산될 수 있도록 공정을 안정화시키고 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"소음·진동|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"PCB생산관리자","certLic":"전자응용기술사, 전자기사, 전자산업기사","dJobECd":"8352","dJobECdNm":"[8352]전자 부품·제품 생산기계 조작원","dJobJCd":"8632","dJobJCdNm":"[8632]전자 부품 및 제품 제조 기계 조작원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002118:1', '{"dJobCd":"K000002118","dJobCdSeq":"1","dJobNm":"노광원","workSum":"브라운관 전면에 사용되는 패널마스크(panel mask) 내면에 형광체를 도포·노광·현상하여 막을 형성하는 일을 한다.","doWork":"노광대를 점검하고 현상수의 분사상태 및 온도를 점검한다. 도포기의 도포상태를 확인한다. 특정 색상의 형광체가 도포된 패널이 이송대를 통하여 일정한 위치에 도착하면 형광체의 도포상태를 검사한다. 내면이 양호하면 마스크를 결합하여 패널을 노광대 위에 올려 놓고 스위치를 눌러 특정색상을 노광시킨다. 장착된 패널에서 마스크를 분리시킨 후 막에 상처가 있는지 검사한다. 불량품은 점검표에 기록하고 분리된 마스크를 이송대에 올린다. 노광대의 주변을 청소한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"슬러리도포원, 노광현상원","dJobECd":"8352","dJobECdNm":"[8352]전자 부품·제품 생산기계 조작원","dJobJCd":"8632","dJobJCdNm":"[8632]전자 부품 및 제품 제조 기계 조작원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002591:1', '{"dJobCd":"K000002591","dJobCdSeq":"1","dJobNm":"다단식프레스조작원","workSum":"인쇄회로용 절연적층판을 만들기 위하여 절연용액이 도포되어 적재된 기재를 가열·가압하여 압착시키는 다단식 유압프레스를 조작한다.","doWork":"적재된 기재와 얇은 구리판을 프레스의 적재판에 지정수량 집어넣는다. 전원을 공급하고 유압프레스를 작동시켜 지정된 온도와 압력을 유지한다. 스위치를 움직여 프레스를 작동시키고 규정된 온도와 압력으로 압착시킨다. 규정시간 후 압착된 절연적층판을 적재판에서 꺼내어 압착상태를 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8352","dJobECdNm":"[8352]전자 부품·제품 생산기계 조작원","dJobJCd":"8632","dJobJCdNm":"[8632]전자 부품 및 제품 제조 기계 조작원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006542:1', '{"dJobCd":"K000006542","dJobCdSeq":"1","dJobNm":"박막트랜지스터노광현상원","workSum":"PR코팅이 끝난 글라스에 원하는 마스크 패턴을 적용하여 자외선을 조사한 후 자외선 노출 부분만 제거하는 현상 작업을 한다.","doWork":"클린룸에 입장하기 위하여 방진복을 착용하고 에어샤워를 한다. 이전 작업을 통해 감광물질(PR)로 된 막을 형성한 글라스에 자외선을 쪼이도록 이동시킨다. 노광장비(Exposure Machine)의 오퍼레이팅 파라미터에 각종 수치와 노광시간, 자외선강도 등을 입력한다. 기기를 작동시켜 감광액이 코팅된 글라스에 원하는 마스크 패턴을 형성하기 위하여 자외선을 조사하고 감광액을 반응시킨다. 이때 마스크와 글라스의 밀착평탄도, 램프안정화에 주의하면서 패턴을 정렬하여 마스크 패턴을 형성시킨다. 노광작업이 완료되면 자외선에 반응되어 노출이 된 부분만을 현상액을 이용하여 제거하는 현상 공정(하드베이커 공정)을 통해 원하는 패턴을 형성한다. 다음 공정인 식각(에칭) 공정으로 자동이동시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"TFT노광현상원, 티에프티노광현상원","certLic":"전기기능사, 화학분석기능사","dJobECd":"8352","dJobECdNm":"[8352]전자 부품·제품 생산기계 조작원","dJobJCd":"8632","dJobJCdNm":"[8632]전자 부품 및 제품 제조 기계 조작원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002192:1', '{"dJobCd":"K000002192","dJobCdSeq":"1","dJobNm":"박막트랜지스터러빙기조작원","workSum":"인쇄가 된 배향막 위를 천(Rubbing Cloth)에 의해 일정한 힘과 속도, 방향으로 문질러 골을 만드는 러빙(Rubbing)장치를 조작한다.","doWork":"클린룸에 입장하기 위하여 방진복을 착용한다. 세정과 인쇄 공정을 거친 컬러필터와 TFT(Thin Film Transistor:박막트랜지스터)의 배향막을 러빙기기(Rubbing Machine)에 투입을 한다. 오퍼레이터 파라미터에 수치를 입력한 후 기기를 작동시켜 롤러에 감긴 러빙 포(Rubbing Cloth:러빙 천)가 배향막 위를 일정한 힘과 속도, 방향으로 회전하면서 문질러주도록 한다. 컬러필터와 TFT의 러빙 방향을 서로 직각이 되게 하여 최적의 시야각 특성을 지니게 한다. 배향막 위에 골을 만들고 액정이 배향될 수 있게 만든다. 배향력을 높이기 위해서 러빙의 세기(Rubbing Strength)를 조정하기도 한다. 실(Seal) 인쇄와 스페이서(Spacer) 산포 공정으로 이동시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"TFT러빙기조작원, 티에프티러빙기조작원","certLic":"전기기능사, 화학분석기능사","dJobECd":"8352","dJobECdNm":"[8352]전자 부품·제품 생산기계 조작원","dJobJCd":"8632","dJobJCdNm":"[8632]전자 부품 및 제품 제조 기계 조작원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002082:1', '{"dJobCd":"K000002082","dJobCdSeq":"1","dJobNm":"박막트랜지스터배향원","workSum":"초기 세정 공정을 거친 컬러필터, TFT(Thin Film Transistor:박막트랜지스터) 기판의 액정분자에 방향성을 부여하기 위하여 배향막을 형성하고 소성하는 기기를 작동한다.","doWork":"액정 분자를 일정한 방향으로 배열시키는 배향막 형성을 위해 초기 세정된 컬러필터와 TFT를 이동시킨다. 배향막 인쇄기기의 오퍼레이션 파라미터에 용해액 점도, 스핀속도, 스핀시간, 스핀단계 등을 입력한다. 기기를 작동해 스테이지가 좌우로 이동하면서 그 위에 있는 컬러필터와 TFT 기판 위에 롤러가 회전하면서 배향막을 인쇄하고 롤러와 맞닿는 부분에 일정한 방향성을 부여하도록 한다. 인쇄작업이 끝나면 소성작업을 위해 큐어링오븐(Curing Oven)의 오퍼레이팅 파라미터에 건조온도 및 시간, 경화온도 및 시간을 입력한다. 이때 얼룩방지를 위한 균일한 온도를 유지하고 세팅온도를 확인한다. 오븐을 작동시켜 핫플레이트 위의 글라스에 도포된 폴리아믹산(Poly Amic Acid) 박막을 경화시켜 폴리이미드(Polyimide) 배향막을 형성한다. 경화가 완료되면 다음 공정인 러빙공정으로 컬러필터와 TFT를 이동시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"TFT배향원, 티에프티배향원","certLic":"전기기능사, 화학분석기능사","dJobECd":"8352","dJobECdNm":"[8352]전자 부품·제품 생산기계 조작원","dJobJCd":"8632","dJobJCdNm":"[8632]전자 부품 및 제품 제조 기계 조작원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003816:1', '{"dJobCd":"K000003816","dJobCdSeq":"1","dJobNm":"박막트랜지스터셀절단원","workSum":"합착공정을 거쳐 합착된 기판을 각각의 패널로 분리하기 위해 절단선을 형성하고 규격에 맞게 절단하는 기기를 작동한다.","doWork":"전 공정을 통해 합착된 기판을 일정 시간 경화시킨 후 이동시킨다. 셀 절단선을 형성하기 위하여 이동된 기판을 스크라이브(Scribe) 장비의 진공 스테이지 위에 고정한다. 셀 절단기기(Cell Cutting Machine)의 오퍼레이팅 파라미터에 주 압력과 휠 압력 등의 수치를 입력하고 정렬 포인트를 체크한다. 기기를 가동시켜 경도가 높은 다이아몬드 휠로 글라스를 절단한 다음, 셀별로 충격을 가하여 셀 절단선대로 절단을 하는 브레이크 공정을 진행한다. 액정 주입구와 전극부는 노출을 시켜 액정 주입을 위한 공정으로 이동시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"TFT셀절단원, 티에프티셀절단원","certLic":"전기기능사","dJobECd":"8352","dJobECdNm":"[8352]전자 부품·제품 생산기계 조작원","dJobJCd":"8632","dJobJCdNm":"[8632]전자 부품 및 제품 제조 기계 조작원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006749:1', '{"dJobCd":"K000006749","dJobCdSeq":"1","dJobNm":"박막트랜지스터스페이스산포원","workSum":"TFT와 컬러필터 기판 사이에 일정한 갭을 형성하도록 TFT에 스페이서를 일정 밀도로 산포하는 기기를 작동한다.","doWork":"러빙공정을 거쳐 배향처리된 배향막을 이동시킨다. 스페이스 공정 기기(Spacer Spray Machine)의 파라미터에 산포시간, 산포압력, 스페이서 양 등을 입력하고 스페이서 솔루션에 스페이서를 충전한다. 스페이스 공정 기기를 가동시켜 TFT에 균일하게 분산되도록 스페이서를 산포한다. 실(Seal) 인쇄 공정을 마친 컬러필터와 합착을 하기 위해 다음 공정으로 이동시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"투입인출","similarNm":"TFT스페이스산포원, 티에프티스페이스산포원","certLic":"전기기능사, 화학분석기능사","dJobECd":"8352","dJobECdNm":"[8352]전자 부품·제품 생산기계 조작원","dJobJCd":"8632","dJobJCdNm":"[8632]전자 부품 및 제품 제조 기계 조작원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002322:1', '{"dJobCd":"K000002322","dJobCdSeq":"1","dJobNm":"박막트랜지스터식각원","workSum":"감광물질(PR:Photo Resist)에 의해 가려진 부분(노광공정에서 자외선을 받지 않은 부분)을 제외한 증착막을 제거한다.","doWork":"클린룸에 입장하기 위하여 방진복을 착용하고 에어샤워를 한다. 현상, 식각, 박리 자동화 설비의 오퍼레이팅 파라미터에 식각 시간, 솔루션 시간 등을 입력한다. 노광 공정을 거치면서 PR에 의해 가려진 부분을 제외한 노출 되어 있는 증착막(ITO)을 제거한다. 금속막의 경우는 용해제를 사용하는 습식식각(Wet Etching), 반도체와 절연체는 플라스마를 사용하는 건식식각(Dry Etching) 방법을 주로 적용한다. 식각 후 잔류 감광물질(PR)을 유기용제를 이용하여 제거하는 박리공정(PR Strip)을 실행시켜서 패턴형성을 완료한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"TFT식각원, 티에프티식각원","certLic":"전기기능사, 화학분석기능사","dJobECd":"8352","dJobECdNm":"[8352]전자 부품·제품 생산기계 조작원","dJobJCd":"8632","dJobJCdNm":"[8632]전자 부품 및 제품 제조 기계 조작원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003318:1', '{"dJobCd":"K000003318","dJobCdSeq":"1","dJobNm":"박막트랜지스터실형성원","workSum":"스페이서 산포된 TFT와 합착을 하기 위해 러빙과정에서 배향처리된 컬러필터의 배향막 위에 접착제인 실란트를 도포한다.","doWork":"러빙공정을 거쳐 배향처리된 배향막을 이동시킨다. 실란트 프린터 장비를 이용해 실란트 프린터 공정을 진행한다. 실 형성 기기(Seal Machine)의 니들과 배향막 간의 거리를 감안해 오퍼레이팅 파라미터에 속도와 니들 사이즈(Needle Size) 등의 정보를 입력한다. 기기를 작동시켜 실란트의 종류에 따라 열 경화형, 광 경화형 실 형성공정을 진행한다. 열이나 자외선을 이용해 일정 시간 경화시키고 스페이서 산포된 TFT와의 합착을 위한 공정으로 이동시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"TFT실형성원, 티에프티실형성원","certLic":"전기기능사","dJobECd":"8352","dJobECdNm":"[8352]전자 부품·제품 생산기계 조작원","dJobJCd":"8632","dJobJCdNm":"[8632]전자 부품 및 제품 제조 기계 조작원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003322:1', '{"dJobCd":"K000003322","dJobCdSeq":"1","dJobNm":"박막트랜지스터액정주입원","workSum":"셀의 내외부 압력차를 이용해 분리가 된 패널의 내부에 액정을 주입한다.","doWork":"액정을 주입하기 위해 일정한 크기로 절단이 된 패널을 액정주입장치의 진공 체임버(Vacuum Chamber)로 이동시킨다. 오퍼레이팅 파라미터에 탈포시간, 진공시간, 배기시간, 충전(충진)시간 등을 입력한다. 펌프를 이용해 셀의 내부를 진공으로 만든 후에 모세관 현상 및 셀 외부와의 압력차를 이용해 액정을 주입한다. 셀 내부, 구석각에 기포가 생기지 않도록 충전(충진)하고 확인한다. 액정 주입이 완료되면 주입구를 봉지하기 위한 공정으로 이동시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"투입인출","similarNm":"TFT액정주입원, 티에프티액정주입원","certLic":"전기기능사, 화학분석기능사","dJobECd":"8352","dJobECdNm":"[8352]전자 부품·제품 생산기계 조작원","dJobJCd":"8632","dJobJCdNm":"[8632]전자 부품 및 제품 제조 기계 조작원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006275:1', '{"dJobCd":"K000006275","dJobCdSeq":"1","dJobNm":"박막트랜지스터증착원","workSum":"기본적인 글라스 위에 절연체나 반도체 등을 얇게 도포하는 박막 형성 공정을 담당한다.","doWork":"클린룸에 입장하기 위하여 방진복을 착용하고 에어샤워를 한다. 기본적인 글라스에 절연체나 반도체의 증착하기 위해 플라스마화학증착(PECVD) 기기의 오퍼레이팅 파라미터에 각종 수치를 입력한다. 증착하고자 하는 화학물질을 진공상태의 챔버에 주입하고 전장(Electrical Field)을 형성하여 플라스마를 유도한다. 전장에 의해 가스분해가 일어나면 분해된 가스원자가 기판에 부착되어 박막을 증착하도록 기기를 작동한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"투입인출","similarNm":"TFT증착원, 티에프티증착원","certLic":"전기기능사, 화학분석기능사","dJobECd":"8352","dJobECdNm":"[8352]전자 부품·제품 생산기계 조작원","dJobJCd":"8632","dJobJCdNm":"[8632]전자 부품 및 제품 제조 기계 조작원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003971:1', '{"dJobCd":"K000003971","dJobCdSeq":"1","dJobNm":"박막트랜지스터협착원","workSum":"실(Seal) 형성이 된 컬러필터 기판과 스페이서 산포가 된 TFT 기판을 정밀하게 합착하는 기기를 작동한다.","doWork":"전 공정을 통해 실(Seal) 형성이 된 컬러필터 기판과 스페이서 산포가 된 TFT 기판을 각각 이동시킨다. 컬러필터와 TFT 기판을 마주 보게 하여 세밀하게 가합착을 시킨다. 합착공정기기(Assemble Machine)의 오퍼레이팅 파라미터에 가압압력, 자외선 램프 파워, 자외선 조사 시간 등의 정보를 입력한다. 기기를 작동해 가합착된 셀에 균일한 압력을 가하고 자외선을 조사하여 실(Seal)을 경화시킨다. 합착이 완료된 기판을 각각의 패널로 분리하기 위해 다음 공정으로 이동시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"TFT협착원, 티에프티협착원, 실링기조작원, 씨링기조작원","certLic":"전기기능사","dJobECd":"8352","dJobECdNm":"[8352]전자 부품·제품 생산기계 조작원","dJobJCd":"8632","dJobJCdNm":"[8632]전자 부품 및 제품 제조 기계 조작원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004611:1', '{"dJobCd":"K000004611","dJobCdSeq":"1","dJobNm":"브라운관검사원","workSum":"제조된 브라운관의 막, 내압, 패널(panel), 펀넬(funnel), 외관 등을 검사한다.","doWork":"제조된 브라운관에 소켓을 삽입한다. 정확한 검사를 하기 위하여 약품을 묻힌 가제로 패널면을 깨끗이 닦는다.브라운관에 이물질이 있는지 검사하고 적색·녹색·청색의 색상의 고름을 확인한다. 넥(neck)부위의 이상발광 상태를 검사하고 불량이 검출되면 스티커로 표시한다. 패널 부위의 상처나 찍힘이 있는지 검사하고 면보호테이프를 부착하고 진공도를 검사한다. 외관에 이상이 있는지 검사하고 불량여부를 판정한다. 불량으로 판정된 제품을 폐품과 재생으로 구분하여 관련 부서로 이동시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"TV브라운관검사원","dJobECd":"8352","dJobECdNm":"[8352]전자 부품·제품 생산기계 조작원","dJobJCd":"8632","dJobJCdNm":"[8632]전자 부품 및 제품 제조 기계 조작원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2011"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002691:1', '{"dJobCd":"K000002691","dJobCdSeq":"1","dJobNm":"브라운관배기원","workSum":"작업지침서와 브라운관(tube) 사양서에 따라 초단파선관·전자선관·음극선관에서 가스와 불순물을 제거하는데 사용하는 배기 또는 누출탐지장비를 조작한다.","doWork":"브라운관 사양서와 작업순서를 숙지하기 위해 생산계획표와 작업지침서를 읽는다. 제어장치를 조정하고 시험장비 위에 일정부품의 봉함제와 어댑터(adapter)를 설치하고 브라운관을 세운다. 운전하는 동안 계기와 기록장치를 관찰한다. 브라운관이 규정대로 배기되고 누출이 없는지 확인하기 위해 제어장치를 조정한다. 배기가 되지 않거나 새는 곳을 관에 표시하여 수리부서로 이동시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|고온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"튜브배기원, TV브라운관배기원","dJobECd":"8352","dJobECdNm":"[8352]전자 부품·제품 생산기계 조작원","dJobJCd":"8632","dJobJCdNm":"[8632]전자 부품 및 제품 제조 기계 조작원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2011"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002608:1', '{"dJobCd":"K000002608","dJobCdSeq":"1","dJobNm":"브라운관봉입원","workSum":"브라운관 제조공정 중 전자총(mount)과 튜브(tube)를 봉착하고 가공된 부분에 열을 가해 응력(외력이 재료에 작용할 때 그 내부에 생기는 저항력)을 제거하는 일을 한다.","doWork":"작업지도서를 숙지하고 작업에 사용할 기구나 장치에 이상이 없는지 점검한다. 전자총을 팩(pag)에 삽입하고 미세조정장치를 이용하여 전자총의 그리드(grid : 3극진공관의 격자모양의 극)의 구멍모양이 원형이 되도록 모니터를 보며 조정한다. 튜브를 헤드(head)에 안착시키고 서로 중앙을 맞추어 준다. 가스흡착용 금속을 삽입시킨다. 헤드를 정위치에 정지시키고 튜브에 고유번호 등을 기록한다. 헤드에서 튜브를 추출하여 적합여부를 판정한다. 추출한 튜브를 소둔로에 투입하여 일정 시간 열을 가해 응력을 제거한다. 소둔된 튜브를 검사하여 적부판정을 한 후 차기 공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"튜브봉입원, TV브라운관봉입원","dJobECd":"8352","dJobECdNm":"[8352]전자 부품·제품 생산기계 조작원","dJobJCd":"8632","dJobJCdNm":"[8632]전자 부품 및 제품 제조 기계 조작원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2011"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006519:1', '{"dJobCd":"K000006519","dJobCdSeq":"1","dJobNm":"브라운관제조반장","workSum":"브라운관의 제조공정에 종사하는 작업원의 활동을 감독·조정한다.","doWork":"작업에 필요한 작업표준지도서를 작성한다. 작업에 편리하도록 설비의 배치를 계획한다. 생산에 필요한 자재를 준비한다. 작업원들의 숙련도, 생산의 효율성 등을 고려하여 작업원들을 배치한다. 작업진행 상태를 확인·감독하고 안전에 문제점이 있는지 점검한다. 제품의 품질상태를 살피고 문제점이 발생할 시 관련 부서와 협조하여 해결한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"TV브라운관제조반장","connectJob":"브라운관검사반장, 브라운관봉착반장, 브라운관봉입반장, 브라운관배기반장","certLic":"전자기능사","dJobECd":"8352","dJobECdNm":"[8352]전자 부품·제품 생산기계 조작원","dJobJCd":"8632","dJobJCdNm":"[8632]전자 부품 및 제품 제조 기계 조작원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2011"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006429:1', '{"dJobCd":"K000006429","dJobCdSeq":"1","dJobNm":"브라운관펀넬도포원","workSum":"수상관에 쓰이는 펀넬의 내면을 일정두께의 전도성 흑연으로 도포하고, 녹색·청색·적색의 형광체를 자동진공증착기를 사용하여 알루미늄막으로 만들어 증착시키는 일을 한다.","doWork":"일정비율표에 따라 탱크에 화공약품과 물을 붓고 규정농도를 맞춘다. 건조장비에 전원을 공급하여 일정 온도를 올린다. 기계를 작동시켜 일련의 흑연 및 형광체도포·건조작업을 실시한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","similarNm":"브라운관흑연도포원, TV브라운관펀넬도포원","connectJob":"형광막증착원","dJobECd":"8352","dJobECdNm":"[8352]전자 부품·제품 생산기계 조작원","dJobJCd":"8632","dJobJCdNm":"[8632]전자 부품 및 제품 제조 기계 조작원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2011"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005018:1', '{"dJobCd":"K000005018","dJobCdSeq":"1","dJobNm":"엘이디제조원","workSum":"LED생산공정에서 각종 생산장비를 조작하여 LED를 생산한다.","doWork":"에피 웨이퍼, 칩, 패키지 공정 등 LED제조공정 라인에서 LED제조장비를 조작해 LED를 생산한다. 생산된 LED의 외관 검사 및 현미경 검사 등을 통해 불량 제품을 선별하고 검사한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"LED생산제조원","dJobECd":"8352","dJobECdNm":"[8352]전자 부품·제품 생산기계 조작원","dJobJCd":"8632","dJobJCdNm":"[8632]전자 부품 및 제품 제조 기계 조작원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002023:1', '{"dJobCd":"K000002023","dJobCdSeq":"1","dJobNm":"웨이퍼디퓨전장비조작원","workSum":"단결정 또는 다결정 웨이퍼에 불순물을 도포한 후 P-N 접합(Junction:p형 반도체와 n형 반도체를 접합한 것)을 생성하고 확산하기 위한 기기를 조작한다.","doWork":"에칭(Etching:화학적인 부식작용을 이용한 가공법)과 텍스처링(Texturing)이 완료된 웨이퍼를 P-N 접합하기 위해 이동시킨다. 웨이퍼가 담긴 카세트를 장비로 투입한다. 컴퓨터의 오퍼레이션 파라미터에 필요한 정보를 입력하고 작업을 시작한다. 전기적 절연, 확산 공정에서의 보호막, 표면 보호 및 안정화, 표면에서의 반사 방지막 역할 등을 위해 실리콘 웨이퍼 표면에 SiO₂ 막을 입힌다. 실리콘 웨이퍼 내부에 N형 및 P형 불순물을 주입하고, 정확한 캐리어타입과 저항률을 결정한다. 도핑(Doping)농도는 저항을 측정해서 관리한다. 완료된 카세트를 수거하고 표면층 에칭을 위한 공정으로 이동시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"반도체웨이퍼디퓨전장비조작원","certLic":"화학분석기능사, 신재생에너지발전설비 기사","dJobECd":"8352","dJobECdNm":"[8352]전자 부품·제품 생산기계 조작원","dJobJCd":"8632","dJobJCdNm":"[8632]전자 부품 및 제품 제조 기계 조작원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003887:1', '{"dJobCd":"K000003887","dJobCdSeq":"1","dJobNm":"웨이퍼반사방지코팅장비조작원","workSum":"단결정 또는 다결정 웨이퍼에 생성된 반사방지막을 형성하기 위하여 웨이퍼 AR-Coating(Anti-reflection Coating) 장비를 조작한다.","doWork":"표면층 에칭 공정을 완료한 웨이퍼에 태양광 반사방지막을 형성하기 위하여 이동시킨다. 웨이퍼가 담긴 카세트를 AR-Coating 장비로 투입하고 컴퓨터를 조작하여 작업을 시작한다. Puttering 기법을 이용해 웨이퍼에 반사방지막이 형성되도록 한다. 작업이 완료되면 카세트를 수거한 후 전극형성을 위한 스크린 표면인쇄 과정으로 이동시킨다. 장비의 유지를 위해 일정 주기로 장비를 청소한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"웨이퍼AR코팅장비조작원, 반도체웨이퍼AR코팅장비조작원, 반도체웨이퍼반사방지코팅장비조작원","certLic":"화학분석기능사, 신재생에너지발전설비 기사","dJobECd":"8352","dJobECdNm":"[8352]전자 부품·제품 생산기계 조작원","dJobJCd":"8632","dJobJCdNm":"[8632]전자 부품 및 제품 제조 기계 조작원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001968:1', '{"dJobCd":"K000001968","dJobCdSeq":"1","dJobNm":"웨이퍼수입검사원","workSum":"태양전지의 솔라셀 제조에 사용되는 단결정, 다결정 실리콘 웨이퍼의 상태를 검사하고 카세트에 이송한다.","doWork":"앞 단계에서 폴리실리콘 잉곳(Ingot)을 슬라이싱 작업하여 완성시킨 웨이퍼를 검사하기 위해 이동시킨다. 매거진을 이용하여 대량의 웨이퍼를 스플리터(Splitter) 등의 수입검사 장비에 동시에 투입을 한다. 컴퓨터를 조작하여 검사작업(In-coming Test)을 시작한다. 검사가 완료되면 텍스처링 및 P-N접합 형성 등을 하기 위해 다음 공정으로 웨이퍼를 이동시킨다. 정리된 카세트를 수거하고 주변을 정돈한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"웨이퍼품질검사원, 반도체웨이퍼수입검사원, 반도체웨이퍼품질검사원","certLic":"화학분석기능사, 신재생에너지발전설비 기사","dJobECd":"8352","dJobECdNm":"[8352]전자 부품·제품 생산기계 조작원","dJobJCd":"8632","dJobJCdNm":"[8632]전자 부품 및 제품 제조 기계 조작원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005914:1', '{"dJobCd":"K000005914","dJobCdSeq":"1","dJobNm":"웨이퍼전극측정원","workSum":"전극이 분리된 태양전지의 효율을 측정하고, 효율을 등급별로 분류하기 위한 셀 테스터와 태양 시뮬레이터를 조작한다.","doWork":"전 단계에서 전극이 형성된 웨이퍼들의 효율 측정과 검사 및 분류를 위해 웨이퍼를 이동시킨다. 전극이 분리된 각 셀들은 셀 테스터(Cell Tester)를 이용해 비슷한 전기적 성질을 갖는 셀끼리 분류를 한다. 태양 시뮬레이터를 이용해 완성된 태양전지를 효율별로 등급을 매기고 완성품 출고를 위한 대기를 시킨다. 측정이 완료된 카세트를 수거하고, 장비의 유지를 위하여 주기적인 청소작업을 실시한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"반도체웨이퍼전극측정원","certLic":"화학분석기능사, 전기기능사, 신재생에너지발전설비 기사","dJobECd":"8352","dJobECdNm":"[8352]전자 부품·제품 생산기계 조작원","dJobJCd":"8632","dJobJCdNm":"[8632]전자 부품 및 제품 제조 기계 조작원","dJobICd":"C261","dJobICdNm":"[C261]반도체 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;