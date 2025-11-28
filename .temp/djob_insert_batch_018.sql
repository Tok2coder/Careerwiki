INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001479:1', '{"dJobCd":"K000001479","dJobCdSeq":"1","dJobNm":"상업교사","workSum":"상업계열 고등학교에서 학생들에게 상업에 대한 지식과 기술을 가르치기 위하여 상업 및 관련 과목을 전문으로 교육한다.","doWork":"경영실무, 기업회계, 마케팅, 사무자동화실무, 상업경제, 유통관리일반, 전자계산실무, 컴퓨터일반, 프로그래밍실무, 회계실무, 회계원리 등의 전문교과목 중 하나 또는 그 이상의 과목을 교육한다. 각 분야에 관련된 전문기술을 실습을 통한 실무위주로 가르침으로써 실기능력 배양에 중점을 둔다. 과제를 내주고 결과를 검토 및 지도한다. 시험을 출제하고 학생의 성적을 평가한다. 전문교과목에 관련된 실기교사(중등교육기관)의 직무를 수행하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","connectJob":"전문교과목에 따라 경영정보교사, 회계정보교사, 통상정보교사, 정보처리교사, 시각디자인교사, 관광경영교사, 비서교사, 사무자동화교사, 유통경영교사","certLic":"중등학교정교사","dJobECd":"2121","dJobECdNm":"[2121]중·고등학교 교사","dJobJCd":"2521","dJobJCdNm":"[2521]중·고등학교 교사","dJobICd":"P852","dJobICdNm":"[P852]중등 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006770:1', '{"dJobCd":"K000006770","dJobCdSeq":"1","dJobNm":"수산업교사","workSum":"수산·해양계열 고등학교에서 학생들에게 수산업과 해양에 대한 지식과 기술을 가르치기 위하여 수산업, 어업, 해양 및 관련 과목을 전문으로 교육한다.","doWork":"냉동설비, 선박운용, 수산경영일반, 수산일반, 수산해운정보처리, 잠수기술, 전자통신운용, 항해, 해사법규, 해사일반, 해양오염, 해양환경 등의 전문교과목 중 하나 또는 그 이상의 과목을 교육한다. 각 분야에 관련된 전문기술을 실험실습, 승선실습, 현장실습 및 견학 등 체험적인 학습을 중심으로 지도한다. 교과서 및 시청각자료 등 다양한 학습자료를 활용하여 수업을 진행한다. 과제를 내주고 결과를 검토 및 지도한다. 시험을 출제하고 학생의 성적을 평가한다. 전문교과목에 관련된 실기교사(중등교육기관)의 직무를 수행하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","connectJob":"전문교과목에 따라 어업교사, 수산양식교사, 자영수산교사, 수산식품교사, 수산물유통교사, 해양환경교사, 냉동기계교사, 동력기계교사, 해양토목교사, 항해교사, 선박운항교사, 전자통신교사","certLic":"중등학교정교사","dJobECd":"2121","dJobECdNm":"[2121]중·고등학교 교사","dJobJCd":"2521","dJobJCdNm":"[2521]중·고등학교 교사","dJobICd":"P852","dJobICdNm":"[P852]중등 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005184:1', '{"dJobCd":"K000005184","dJobCdSeq":"1","dJobNm":"수학교사","workSum":"중·고등학교에서 학생들에게 수리력과 논리적 사고력을 향상시키기 위하여 수학, 실용수학, 미분과 적분, 확률과 통계, 이산수학 및 관련 과목을 전문으로 교육한다.","doWork":"교과내용은 수와 연산, 도형, 측정, 확률과 통계, 문자와 식, 규칙성과 함수의 영역으로 구성된다. 학생들의 구체적인 경험에 근거하여 사물의 현상을 수학적으로 해석하고 조직하는 활동, 직관이나 구체적인 조작활동에 바탕을 둔 통찰 등의 수학적 경험을 통하여 수학적 개념, 원리, 법칙 등을 이해시키고 교육한다. 과제를 내주고 결과를 검토 및 지도한다. 시험을 출제하고 학생의 성적을 평가한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","certLic":"중등학교정교사","dJobECd":"2121","dJobECdNm":"[2121]중·고등학교 교사","dJobJCd":"2521","dJobJCdNm":"[2521]중·고등학교 교사","dJobICd":"P852","dJobICdNm":"[P852]중등 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004037:1', '{"dJobCd":"K000004037","dJobCdSeq":"1","dJobNm":"실기교사","workSum":"실업계 고등학교, 고등기술학교 및 일반중등학교의 부속실습시설에서 농업·공업·상업·해운·예능·가정·체육 및 기타 전문교과의 각 학과별 실기를 지도한다.","doWork":"교사와 협의하여 실험·실습에 대한 지도계획을 작성한다. 실습에 필요한 실험기기·도구 및 재료를 준비하고 점검한다. 수업계획에 따라 설비 및 기구의 사용과 보존, 부호규정, 실습절차 및 방법, 안전예방, 전문용어 등에 관하여 설명하고 기능을 시범한다. 교과서 및 시청각자료 등 다양한 학습자료를 활용하여 수업을 진행한다. 학생들의 작업을 지도하고 감독한다. 과제를 내주고 결과를 검토 및 지도한다. 기자재를 정비하고 수리하며 도구 및 기타 재료를 정돈한다. 학생의 기술에 대한 지식과 실기의 향상도를 시험하고 평가한다. 실습실의 기계 및 도구를 관리하고 유지한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"웅크림|언어력|시각|","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","connectJob":"전문교과목에 따라 건축실기교사, 공예실기교사, 교련실기교사, 금속실기교사, 기계실기교사, 기관실기교사, 농업기계실기교사, 농업토목실기교사, 디자인실기교사, 미술실기교사, 미용실기교사, 보육실기교사, 부기실기교사, 사서실기교사, 사진실기교사, 상업계산실기교사, 섬유실기교사, 수산양식실기교사, 수의실기교사, 식품가공실기교사, 실내디자인실기교사, 양재실기교사, 어업실기교사, 열처리실기교사, 용접실기교사, 워드프로세서실기교사, 원예실기교사, 음악실기교사, 무용실기교사, 체육실기교사, 이미용교사","certLic":"실기교사","dJobECd":"2121","dJobECdNm":"[2121]중·고등학교 교사","dJobJCd":"2521","dJobJCdNm":"[2521]중·고등학교 교사","dJobICd":"P852","dJobICdNm":"[P852]중등 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006711:1', '{"dJobCd":"K000006711","dJobCdSeq":"1","dJobNm":"외국어교사","workSum":"초·중·고등학교에서 학생들의 외국어능력을 키우기 위하여 외국어 및 관련 과목을 전문으로 교육한다.","doWork":"교과내용은 언어기능, 의사소통활동, 언어재료의 영역으로 구성되며 구체적으로 독해, 회화, 작문 등에 대해서 배운다. 해당 외국어로 학생들의 의사소통능력을 키우기 위해 문법과 더불어 일상회화에 비중을 두고 가르친다. 감각과 놀이중심의 체험학습, 멀티미디어를 활용한 매체학습 등 다양한 방법론을 통해 언어감각과 회화기법을 지도한다. 교과서 및 시청각자료 등 다양한 학습자료를 활용하여 수업을 진행한다. 과제를 내주고 결과를 검토 및 지도한다. 시험을 출제하고 학생의 성적을 평가한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","connectJob":"전문교과목에 따라 독일어교사, 러시아어교사, 스페인어교사, 아랍어교사, 영어교사, 일본어교사, 중국어교사, 프랑스어교사","certLic":"중등학교정교사","dJobECd":"2121","dJobECdNm":"[2121]중·고등학교 교사","dJobJCd":"2521","dJobJCdNm":"[2521]중·고등학교 교사","dJobICd":"P852","dJobICdNm":"[P852]중등 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002315:1', '{"dJobCd":"K000002315","dJobCdSeq":"1","dJobNm":"음악교사","workSum":"중·고등학교에서 학생들에게 음악적 정서와 소질을 개발하기 위하여 음악, 음악과 생활 및 관련 과목을 전문으로 교육한다.","doWork":"음악이론, 화음, 악보읽기, 가창, 작곡, 음악감상 등의 교과목을 가르치고 성악, 기악의 경우 기법과 주법을 설명하고 시범을 보인다. 리듬, 가락, 화성, 셈여림, 음색 등과 같은 다양한 악곡의 구성요소들과 전통음악에 대해 교육한다. 합창단이나 합주단을 조직하여 지도·훈련시키기도 한다. 과제를 내주고 결과를 검토 및 지도한다. 시험을 출제하고 학생의 성적을 평가한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"청각|언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","certLic":"중등학교정교사","dJobECd":"2121","dJobECdNm":"[2121]중·고등학교 교사","dJobJCd":"2521","dJobJCdNm":"[2521]중·고등학교 교사","dJobICd":"P852","dJobICdNm":"[P852]중등 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005804:1', '{"dJobCd":"K000005804","dJobCdSeq":"1","dJobNm":"체육교사","workSum":"중·고등학교에서 학생들에게 건강한 체력과 다양한 운동능력을 육성시키기 위하여 체육, 체육과 건강 및 관련 과목을 전문으로 교육한다.","doWork":"육상, 체조, 구기, 수영, 무용 등에 관한 동작원리, 기술 등을 설명하고 시범을 보인다. 게임활동, 표현활동, 보건에 관한 기본 움직임과 이론을 교육하고 학생들의 체력활동 시 동작을 관찰하고 교정한다. 운동종목의 역사와 목적을 설명한다. 학생들의 향상도를 시험하고 평가한다. 시험을 출제하고 학생의 성적을 평가한다. 축구, 배구, 야구, 태권도, 유도, 씨름 등의 종목에서 학생 선수단을 조직하여 지도·감독하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","certLic":"중등학교정교사","dJobECd":"2121","dJobECdNm":"[2121]중·고등학교 교사","dJobJCd":"2521","dJobJCdNm":"[2521]중·고등학교 교사","dJobICd":"P852","dJobICdNm":"[P852]중등 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002780:1', '{"dJobCd":"K000002780","dJobCdSeq":"1","dJobNm":"컴퓨터교사","workSum":"중·고등학교에서 학생들의 컴퓨터 구성체계의 이해와 조작방법의 습득, 정보기술에 관한 문제해결능력을 기르기 위하여 컴퓨터과목을 전문으로 교육한다.","doWork":"교과내용은 컴퓨터의 기초, 워드프로세서, 멀티미디어, PC통신과 인터넷의 영역으로 구성되어 있다. 컴퓨터의 운영체제와 다양한 소프트웨어의 사용방법을 설명한다. 문서작성과 편집방법, 그림과 표작성법을 설명하여 생활에 활용할 수 있게 한다. 소리와 영상을 포함한 멀티미디어 자료의 처리방법, PC통신·인터넷 통신망의 정보검색방법과 전자우편을 사용한 정보교환방법을 설명한다. 직접 컴퓨터를 조작하여 실습 중심으로 지도한다. 과제를 내주고 결과를 검토 및 지도한다. 시험을 출제하고 학생의 성적을 평가한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","certLic":"중등학교정교사","dJobECd":"2121","dJobECdNm":"[2121]중·고등학교 교사","dJobJCd":"2521","dJobJCdNm":"[2521]중·고등학교 교사","dJobICd":"P852","dJobICdNm":"[P852]중등 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006270:1', '{"dJobCd":"K000006270","dJobCdSeq":"1","dJobNm":"한문교사","workSum":"중·고등학교에서 학생들에게 한문을 익혀 언어생활에 활용하고 한문 문장의 독해능력을 기르게 하기 위해 한문, 한문고전 및 관련 과목을 전문으로 교육한다.","doWork":"교과내용은 한자, 한자어, 한문으로 구성되며 각종 한문기록과 고사성어, 격언, 속담, 명언·명구 등을 통해 한자 문화권의 언어와 문화를 가르친다. 기본적인 한자독해능력이 길러지면 국학 및 동양학 분야의 전적을 연구하고 교육한다. 교과서 및 시청각자료 등 다양한 학습자료를 활용하여 수업을 진행한다. 과제를 내주고 결과를 검토 및 지도한다. 시험을 출제하고 학생의 성적을 평가한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","certLic":"중등학교정교사","dJobECd":"2121","dJobECdNm":"[2121]중·고등학교 교사","dJobJCd":"2521","dJobJCdNm":"[2521]중·고등학교 교사","dJobICd":"P852","dJobICdNm":"[P852]중등 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004024:1', '{"dJobCd":"K000004024","dJobCdSeq":"1","dJobNm":"환경교사","workSum":"중고등학교에서 생태계에 대한 이해를 바탕으로 환경문제 및 환경보전에 대한 학문적·기술적 방법을 가르치기 위해 환경과목을 전문으로 교육한다.","doWork":"신문기사, TV보도자료, 인터넷자료 등의 대중매체 자료와 기관의 홍보·안내자료 등을 활용하여 학습자료를 개발하고 실생활 주변의 소재를 중심으로 공해물질의 측정 및 처리기술, 수질관리 및 폐수처리, 소음방지, 산업위생학 등을 교육한다. 토론, 역할놀이, 조사, 실험, 현장체험학습, 드라마, 연극, 놀이, 사례연구 등 다양한 학습방법을 사용하여 환경과 환경문제를 인식하도록 교육한다. 과제를 주고 결과를 검토 및 지도한다. 시험을 출제하고 학생의 성적을 평가한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","certLic":"중등학교정교사","dJobECd":"2121","dJobECdNm":"[2121]중·고등학교 교사","dJobJCd":"2521","dJobJCdNm":"[2521]중·고등학교 교사","dJobICd":"P852","dJobICdNm":"[P852]중등 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007558:1', '{"dJobCd":"K000007558","dJobCdSeq":"1","dJobNm":"초등학교교사","workSum":"초등학교에서 학생들에게 초등교육 과정을 가르치고, 바른 인성과 품행을 가지도록 지도를 한다.","doWork":"도덕, 국어, 사회, 수학, 자연, 영어, 체육, 음악, 미술 및 실과 등의 초등교과목에 대한 학습지도안을 작성한다. 수업자료를 개발하고 준비한다. 출석을 확인하고 교과서 및 시청각자료를 활용하여 수업을 진행한다. 교과목에 따라 다양한 실험·실습을 하거나 현장견학 및 야외수업을 한다. 과제를 내주고 결과를 검토 및 지도한다. 수행평가, 진단평가, 행동평가 등 다양한 방법으로 학생들을 평가하고 생활기록부를 작성한다. 학급의 훈육을 담당하며 교내외 생활을 지도한다. 교실청소 및 환경정리를 지도·감독한다. 보건 및 체육검사를 실시하여 건강기록부를 작성한다. 학생들의 학업 및 학교생활에 관한 문제, 가정생활, 교우관계 등에 대해 학부모와 상담한다. 전·입학 및 금전취급 사무를 처리한다. 학교 교육과정의 편성 및 운영에 참여하고 교직원회의에 참석하는 등 학교업무를 수행한다. 교내 클럽활동, 특별활동 및 각종 학교행사를 준비·지도한다. 학급경영록, 수행평가종합기록부 등 각종 장부 및 공문서 등을 기록·처리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|언어력|시각|","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","connectJob":"문맹의 성인 및 청소년을 위한 공민학교에서 학생을 가르치는 경우 공민학교교사","certLic":"초등학교정교사","dJobECd":"2122","dJobECdNm":"[2122]초등학교 교사","dJobJCd":"2522","dJobJCdNm":"[2522]초등학교 교사","dJobICd":"P851","dJobICdNm":"[P851]초등 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002042:1', '{"dJobCd":"K000002042","dJobCdSeq":"1","dJobNm":"초등학교영어교사","workSum":"초등학교에서 학생들에게 영어교과를 가르치고, 바른 인성과 품행을 가지도록 지도를 한다.","doWork":"영어과목에 대한 학습지도안을 작성한다. 영어교재를 개발하고 관리한다. 영어교재 및 시청각자료를 활용하여 수업을 진행한다. 과제를 내주고 결과를 검토 및 지도한다. 수행평가, 진단평가, 행동평가 등 다양한 방법으로 학생들을 평가하고 생활기록부를 작성한다. 출석을 확인하고 생활을 지도한다. 원어민영어보조교사와 협력하여 영어교육 및 업무를 처리한다. 교내의 영어 관련 행사를 추진하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|언어력|시각|","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","connectJob":"영어보조교사, 초등학교영어강사","certLic":"초등학교정교사","dJobECd":"2122","dJobECdNm":"[2122]초등학교 교사","dJobJCd":"2522","dJobJCdNm":"[2522]초등학교 교사","dJobICd":"P851","dJobICdNm":"[P851]초등 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004961:1', '{"dJobCd":"K000004961","dJobCdSeq":"1","dJobNm":"대안학교교사","workSum":"공동체 의식을 함양하고 학생 스스로 각자의 소질과 개성을 개발할 수 있도록 교육한다.","doWork":"획일적인 공교육제도에서 탈피하여 교육목적, 학생수준 등에 따라 자유롭고 다양하게 교육과정, 학습방법 등을 결정한다. 다양한 교수방식을 통해 학생 스스로 사회 공동체의 일원으로서 책임을 인지하고 자율적으로 학교생활을 할 수 있도록 지도한다. 정규교육과정 이외에 생태농업, 건축, 음악 등 다양한 체험 및 실습 교육 등 다양한 과목을 가르친다. 종교·환경·시민단체에서, 주말이나 방학에 자연답사, 체험활동, 방과 후 학습활동 등의 대안교육 프로그램을 운영하는 비상설 대안학교에서 학생들을 가르치기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","certLic":"정교사, 전문상담교사","dJobECd":"2123","dJobECdNm":"[2123]특수교육 교사","dJobJCd":"2523","dJobJCdNm":"[2523]특수교육 교사","dJobICd":"P854","dJobICdNm":"[P854]특수학교, 외국인학교 및 대안학교","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005057:1', '{"dJobCd":"K000005057","dJobCdSeq":"1","dJobNm":"맹인적응교육교사","workSum":"맹인들의 생활적응과 사회복귀를 위하여 보행훈련, 일상생활훈련, 의사소통훈련, 감각훈련 등을 지도·교육한다.","doWork":"맹인들의 안전과 독립을 위하여 실제 환경이나 꾸며진 이동환경을 통해 보행훈련을 시킨다. 맹인의 잔존감각을 평가하고 훈련시키며 안내인에 의한 보행, 맹인안전지팡이를 이용한 보행 등을 숙달시키기 위하여 도로교통법, 맹인안전지팡이 조작법, 옥내외 보행기술, 교통시설 이용법 등을 교육한다. 거실, 부엌 등 제반 시설을 갖춘 생활관에서 식사, 요리, 의복관리, 전화사용, 청소 등 일상생활을 위한 적응방법을 교육한다. 점자를 읽고 쓸 수 있도록 교육한다. TTS(Text To Speach : 맹인용 전자독서기) 등 읽는 기계의 사용을 교육하고 효과적인 청취방법 등의 의사전달기술을 교육한다. 자존감을 통한 환경인지훈련, 수지훈련, 체육 또는 오락활동 등을 실시하여 감각기관의 협응 동작을 숙달시킨다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"손사용|언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"수동조작","connectJob":"보행교사","certLic":"특수학교 정교사","dJobECd":"2123","dJobECdNm":"[2123]특수교육 교사","dJobJCd":"2523","dJobJCdNm":"[2523]특수교육 교사","dJobICd":"P854","dJobICdNm":"[P854]특수학교, 외국인학교 및 대안학교","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003908:1', '{"dJobCd":"K000003908","dJobCdSeq":"1","dJobNm":"장애인정보화교육사","workSum":"시각장애인에게 워드사용법, 프로그램작성법 등 정보화 교육을 실시한다.","doWork":"화면내용을 읽어주는 스크린리더, 센스리더(Sense Reader) 등과 모니터 화면의 글자를 확대해주는 줌텍스트의 사용법을 설명한다. 스크린리더 등을 이용하여 워드작성, 프로그램작성 등을 가르친다. 교육과정을 평가한다. 교육과 관련된 질의에 응답한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"교육","workFunc3":"수동조작","dJobECd":"2123","dJobECdNm":"[2123]특수교육 교사","dJobJCd":"2523","dJobJCdNm":"[2523]특수교육 교사","dJobICd":"Q872","dJobICdNm":"[Q872]비거주 복지시설 운영업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005993:1', '{"dJobCd":"K000005993","dJobCdSeq":"1","dJobNm":"점자지도원","workSum":"시각장애인에게 점자를 교육한다.","doWork":"가족력 등 개인정보 및 사회정보를 수집하고 상담한다. 점자교육 과정을 설명한다. 점자의 구성과 의미를 설명한다. 점자수첩 또는 점판, 점필을 사용하여 점자 쓰는 방법을 가르친다. 읽을 때는 종이를 뒤집어 점의 칸 단위와 줄 단위를 촉각으로 빨리 인식하도록 지도한다. 교육결과에 대해 평가하고 관련 질의에 응답한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"분석","workFunc2":"교육","workFunc3":"수동조작","dJobECd":"2123","dJobECdNm":"[2123]특수교육 교사","dJobJCd":"2523","dJobJCdNm":"[2523]특수교육 교사","dJobICd":"P854","dJobICdNm":"[P854]특수학교, 외국인학교 및 대안학교","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006487:1', '{"dJobCd":"K000006487","dJobCdSeq":"1","dJobNm":"특수교사","workSum":"장애를 갖고 있는 특수교육대상자의 교육수준을 진단하고 교육프로그램을 기획·운영하여 의사소통능력이나 사회생활을 증진시킨다.","doWork":"특수교육대상자 부모와의 면담이나 기초학습지능검사 등 표준화된 교육진단 도구를 사용하여 학습수준을 측정한다. 장애유형, 정도, 학습수준에 따라 교육프로그램을 기획하고 선정한다. 담임선생님이나 장애아 부모님과 장애아의 생활이나 통합 등에 대하여 상담한다. 교육프로그램을 운영하고 지역사회의 적응 증진을 위해 유치원에서 교육프로그램을 운영하거나 박물관 등을 견학한다. 놀이상황에서 보이는 행동이나 일상생활의 관찰을 통해서 프로그램의 효과를 평가한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","certLic":"특수학교 정교사","dJobECd":"2123","dJobECdNm":"[2123]특수교육 교사","dJobJCd":"2523","dJobJCdNm":"[2523]특수교육 교사","dJobICd":"P854","dJobICdNm":"[P854]특수학교, 외국인학교 및 대안학교","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004335:1', '{"dJobCd":"K000004335","dJobCdSeq":"1","dJobNm":"특수학교교사","workSum":"특수학교 등에서 신체적·정신적으로 장애를 가진 학생들을 대상으로 장애학생의 개인적 욕구, 능력, 학습수준, 신체조건 등을 고려한 교육을 한다.","doWork":"특수학교에서 또는 일반학교의 특수학급에서 지적장애, 정서장애, 청각장애, 시각장애, 지체부자유 등의 장애학생들을 교육한다. 지적장애 담당 교사는 평균 이하의 지적능력과 적응행동 결함 학생들을 대상으로 기초학습과 사회적응력 향상교육을 실시한다. 지체부자유 담당 교사는 상지, 하지 및 체간(몸통)의 일부 또는 전신의 운동기능 장애학생을 대상으로 기본교육과정을 교수하고 학생의 신체적 장애를 보상할 수 있는 여러 가지 교수학습 도구를 고안하고 사용한다. 청각장애 담당 교사는 청각장애학생을 대상으로 보청기를 이용한 청능훈련, 독화지도, 발어지도 등의 의사소통 훈련을 중점적으로 교육한다. 시각장애는 정상적인 환경에서 시력을 통한 학습에 장애가 있는 학생들을 대상으로 기본교육과정을 교수하고 점자지도, 일상생활적응훈련, 보행기술 등을 가르친다. 전공과 학생을 대상으로 마사지, 지압, 전기치료 등을 가르치기도 한다. 정서장애 담당교사는 정서표현이 극단적이거나 편향적인 장애학생들을 대상으로 사회부적응 행동을 소거하고 원활한 사회적응을 위한 훈련에 중점을 둔다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"수동조작","similarNm":"특수교육교사","connectJob":"장애아보조교사, 지적장애아교사, 정서장애아교사, 청각장애아교사, 시각장애아교사, 지체부자유아교사","certLic":"특수학교 정교사","dJobECd":"2123","dJobECdNm":"[2123]특수교육 교사","dJobJCd":"2523","dJobJCdNm":"[2523]특수교육 교사","dJobICd":"P854","dJobICdNm":"[P854]특수학교, 외국인학교 및 대안학교","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007530:1', '{"dJobCd":"K000007530","dJobCdSeq":"1","dJobNm":"유치원교사","workSum":"유치원에서 취학 전 유아들의 신체적·정신적·사회적 발달을 증진시키기 위하여 기초적인 자연과학, 사회과학, 예체능 등의 교육활동을 지도한다.","doWork":"유아의 인지발달과 학습능력 개발을 위해 사회생활 교육, 언어 교육, 교통안전 및 환경보전 교육 등을 지도한다. 유아들이 건강한 생활을 할 수 있도록 기초 체력을 기르고, 건강하고 안전한 생활습관을 가지도록 개인위생에 관한 내용과 자기보호, 안전생활 등에 관해 가르친다. 자연환경 및 사회의 적응력을 키우기 위해 현장견학, 소풍, 학예회 등의 활동을 지도한다. 자아표현과 심미적 경험향상을 위해 노래, 율동, 미술 등의 예능교육을 실시한다. 유아들의 학습상황과 생활측면을 평가하고, 유치원생활, 학습능력, 성격 등에 대해 학부모와 상의한다. 일일교육계획안, 학급경영록, 생활기록부 등 각종 장부 및 문서를 작성 및 관리한다. 통학버스에 탑승하여 원아들이 안전하게 승하차 할 수 있도록 돕기도 한다. 인근 초등학교 교사와의 간담회를 주최하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|언어력|시각|","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","connectJob":"유치원보조교사","certLic":"유치원정교사 1, 2급","dJobECd":"2130","dJobECdNm":"[2130]유치원 교사","dJobJCd":"2530","dJobJCdNm":"[2530]유치원 교사","dJobICd":"P851","dJobICdNm":"[P851]초등 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001495:1', '{"dJobCd":"K000001495","dJobCdSeq":"1","dJobNm":"유치원특기교사","workSum":"유치원에서 취학 전 유아들에게 놀이 활동을 통한 각종 특기교육을 진행한다.","doWork":"유치원, 어린이집 등에서 국악, 미술, 태권도 등의 특기교육을 통해 놀이를 통한 인성교육을 실시한다. 일일교육계획안을 작성하고, 교육 교보재 등을 구입하여 교육에 활용한다. 유아들이 흥미를 갖고 참여할 수 있는 프로그램을 개발한다. 유치원교사를 도와 방과 후 특기교육을 실시하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|언어력|시각|","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","similarNm":"유아교육전문강사","connectJob":"태권도교사, 음악교사, 미술교사","dJobECd":"2130","dJobECdNm":"[2130]유치원 교사","dJobJCd":"2530","dJobJCdNm":"[2530]유치원 교사","dJobICd":"P851","dJobICdNm":"[P851]초등 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005634:1', '{"dJobCd":"K000005634","dJobCdSeq":"1","dJobNm":"공무원학원강사","workSum":"각종 공무원시험을 준비하는 수강생들을 대상으로 공무원 시험과목에 대해 강의한다.","doWork":"일반직(기술, 연구, 행정) 또는 특정직(외무, 경찰, 소방, 교육, 군무원 등) 공무원을 지망하는 수강생들을 대상으로 공무원 시험에 대한 강의를 실시한다. 연도별 출제경향을 파악하고 강의자료를 준비한다. 출제경향에 따른 기출문제를 작성하고 문제풀이를 한다. 수강생들이 이해하기 쉬운 강의법을 개발한다. 직종별 시험과목에 따라 전문과목을 강의하기도 한다. 강의내용을 동영상으로 녹화하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","connectJob":"강의하는 과목에 따라 행정학강사, 행정법총론강사, 세법개론강사, 형법강사, 국제법개론강사, 교육학개론강사, 회계학강사, 경찰학개론강사, 형사소송법강사, 민법강사","dJobECd":"2141","dJobECdNm":"[2141]문리·어학 강사","dJobJCd":"2541","dJobJCdNm":"[2541]문리 및 어학 강사","dJobICd":"P855","dJobICdNm":"[P855]일반 교습 학원","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006121:1', '{"dJobCd":"K000006121","dJobCdSeq":"1","dJobNm":"보습학원강사","workSum":"보습학원 등에서 초·중·고등학생 등의 수강생들에게 특정 교과과목에 대해 강의한다.","doWork":"수강생들에게 초·중·고등학교 교육과정에 해당되는 교과목을 가르친다. 입시와 검정시험에 관한 출제경향 및 정보를 제공한다. 수강생들의 학습성과를 진단하기 위하여 시험을 실시·평가한다. 학습성과와 진로 등에 관해 학생 및 학부모와 상담한다. 교습과정으로 중학교 및 고등학교의 교육과정에 속하는 교과가 해당된다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","similarNm":"문리학원강사","dJobECd":"2141","dJobECdNm":"[2141]문리·어학 강사","dJobJCd":"2541","dJobJCdNm":"[2541]문리 및 어학 강사","dJobICd":"P855","dJobICdNm":"[P855]일반 교습 학원","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007093:1', '{"dJobCd":"K000007093","dJobCdSeq":"1","dJobNm":"외국어학원강사","workSum":"어학학원 등에서 수강생들에게 특정 외국어에 대한 회화나 문법에 대해 강의한다.","doWork":"수강생들에게 어학에 관련된 회화, 작문, 문법, 독해, 듣기, 번역, 통역 등의 과목을 강의한다. 발음과 억양을 교정해 준다. 시청각자료와 다양한 참여수업방식을 통해 실전적응력과 응용력을 키우고 언어감각을 익히게 지도한다. 어학, 통역, 번역 실기실습을 통해 학생들의 학습 성취도를 평가한다. 학습 및 취업에 관해 학생들과 상담한다. 인터넷을 통해 동영상 원격강의 및 수업내용에 대한 질의응답 수업을 하기도 한다. 교습과정으로 어학, 통역, 번역 등이 있다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","connectJob":"영어강사, 중국어강사, 일본어강사, 독일어강사, 프랑스어강사, 스페인어강사, 한국어강사, 한국어교원, 러시아어강사, 이태리어강사","certLic":"한국어교원자격","dJobECd":"2141","dJobECdNm":"[2141]문리·어학 강사","dJobJCd":"2541","dJobJCdNm":"[2541]문리 및 어학 강사","dJobICd":"P855","dJobICdNm":"[P855]일반 교습 학원","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006760:1', '{"dJobCd":"K000006760","dJobCdSeq":"1","dJobNm":"인문사회학원강사","workSum":"인문사회계열학원에서 수강생들에게 경제학, 법학, 회계학, 행정학, 통계학 등 각종 성인용 고시 및 입시에 출제되는 과목을 가르친다.","doWork":"각종 고시 및 입시의 인문사회계열 과목에 대한 시험 출제경향을 분석한다. 수강생들에게 경제학, 법학, 회계학, 행정학, 통계학의 과목을 하나 또는 그 이상을 이론, 학설, 사례 등을 적절히 연계하여 강의한다. 수강생들의 학습성과를 진단하기 위해 정기적인 시험을 실시·평가한다. 각종 시험에 대한 상담을 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","similarNm":"문리학원강사","connectJob":"논술강사, 독서논술지도사, 독서지도사","dJobECd":"2141","dJobECdNm":"[2141]문리·어학 강사","dJobJCd":"2541","dJobJCdNm":"[2541]문리 및 어학 강사","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006584:1', '{"dJobCd":"K000006584","dJobCdSeq":"1","dJobNm":"인터넷강의강사","workSum":"지자체에서 운영하는 인터넷 수능방송 또는 인터넷 교육학원에서 수강생들에게 특정교과에 대해 강의한다.","doWork":"수강생들에게 인터넷을 통해 중·고등학교 교육과정에 해당되는 교과목을 강의한다. 입시와 검정시험에 관한 출제경향 및 정보를 제공한다. 교습과정은 중학교, 고등학교의 교육과정 및 수학능력평가에 속하는 교과가 해당된다. 각 과목별 개념정리, 심화 및 문제풀이 등의 강의를 진행한다. 온라인상에서 학생들의 질문에 대한 답변을 한다. 자격·면허를 취득하기 위한 전문과목을 강의하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","dJobECd":"2141","dJobECdNm":"[2141]문리·어학 강사","dJobJCd":"2541","dJobJCdNm":"[2541]문리 및 어학 강사","dJobICd":"P855","dJobICdNm":"[P855]일반 교습 학원","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007235:1', '{"dJobCd":"K000007235","dJobCdSeq":"1","dJobNm":"사무학원강사","workSum":"사무관리계열학원에서 수강생들에게 특정교과에 대한 이론과 기술을 강의하고 자격·면허를 취득하기 위한 전문과목을 지도한다.","doWork":"수강생들에게 워드프로세스, 컴퓨터활용능력, PC운용 등 사무관리에 관한 과목을 가르친다. 학생들의 실기기능을 평가하여 미숙한 부분을 시정·보완한다. 수강생들의 학습성과를 진단하기 위해 정기적인 시험을 실시·평가한다. 학습과 취업에 관한 상담을 한다. 교습과정으로 워드프로세스, 컴퓨터활용능력 등이 있으며 이러한 기술 분야 중 하나 또는 그 이상을 전문으로 지도한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"수동조작","dJobECd":"2142","dJobECdNm":"[2142]컴퓨터 강사","dJobJCd":"2542","dJobJCdNm":"[2542]컴퓨터 강사","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006550:1', '{"dJobCd":"K000006550","dJobCdSeq":"1","dJobNm":"실버컴퓨터강사","workSum":"고령자들이 정보화를 통한 세대 간의 격차를 해소하고 삶의 보람을 갖도록 지원하기 위해 정보화 교육을 실시한다.","doWork":"고령자들을 대상으로 정보화 교육을 의한 연간운영 계획을 설정한다. 컴퓨터기초, 운영체제의 이해, 문서작성 요령, 정보검색 요령, 인터넷 및 이메일 사용법 등에 대해 이론적 강의를 하고, 시범적으로 보여주고 따라 하도록 지도한다. 계층별, 단계별 정보화 교육수준에 따라 차등적으로 강의한다. 각종 질문에 답변한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"제어조작","similarNm":"노인컴퓨터강사, 실버인터넷강사","dJobECd":"2142","dJobECdNm":"[2142]컴퓨터 강사","dJobJCd":"2542","dJobJCdNm":"[2542]컴퓨터 강사","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006815:1', '{"dJobCd":"K000006815","dJobCdSeq":"1","dJobNm":"정보처리기술학원강사","workSum":"정보처리기술계열학원에서 수강생들에게 특정교과에 대한 이론과 기술을 강의하고 자격·면허를 취득할 수 있도록 전문과목을 지도한다.","doWork":"수강생들에게 전산구조, PC운영체제, 시스템분석, 정보통신시스템 등에 대한 이론을 가르치고 장비·부품에 대해 설명한다. 회로구성, 동작측정, 작품제작, 모의시설 활용 및 응용프로그램 제작과 같은 실험실습을 지도·감독한다. 수강생들의 실기기능을 평가하여 미숙한 부분을 시정·보완한다. 학습 및 취업에 관해 학생들과 상담한다. 통신기기, 소프트웨어, 멀티미디어, 정보통신, 인터넷, 컴퓨터 등의 교육과정에 대해 하나 또는 그 이상을 전문으로 교육한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"제어조작","dJobECd":"2142","dJobECdNm":"[2142]컴퓨터 강사","dJobJCd":"2542","dJobJCdNm":"[2542]컴퓨터 강사","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007539:1', '{"dJobCd":"K000007539","dJobCdSeq":"1","dJobNm":"컴퓨터강사","workSum":"컴퓨터 관련 전문인력을 양성하기 위해 수강생들에게 컴퓨터 관련 하드웨어, 소프트웨어, 언어, 운영체계, 네트워크, 데이터베이스, 인터넷, 홈페이지 제작 등과 같은 과목 및 기술을 교육한다.","doWork":"교육 목적에 부합되는 훈련프로그램이나 수업과정을 개발한다. 강의시간에 수강생들을 가르친다. 수강생이 강의 중 혹은 이외의 학습과정에서 궁금했던 사항에 대한 질문에 응답한다. 수강생들이 강의시간 이외에 실습하기 위해 참고할 책의 목록을 만든다. 수강생들의 수업내용 숙지 정도를 평가하기 위해 시험을 실시하고, 채점한다. 수강생들에게 컴퓨터 혹은 향후 직업선택과 관련한 조언을 한다. 출석부 관리와 같은 행정업무를 수행한다. 다양한 자료원을 통해 최신 정보를 획득한다. 자신의 강의 분야의 새로운 지식이나 전문기술의 동향을 파악한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"제어조작","similarNm":"IT강사, 컴퓨터학원강사","connectJob":"정보통신강사, 웹디자인강사, 웹프로그래밍강사, 컴퓨터프로그래밍강사, 컴퓨터그래픽영상강사, 캐드강사, 정보통신학원강사, 컴퓨터그래픽강사","dJobECd":"2142","dJobECdNm":"[2142]컴퓨터 강사","dJobJCd":"2542","dJobJCdNm":"[2542]컴퓨터 강사","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006067:1', '{"dJobCd":"K000006067","dJobCdSeq":"1","dJobNm":"컴퓨터소프트웨어코딩강사","workSum":"초·중·고등학생들의 창의성과 논리성 증진을 위해 이들에게 컴퓨터 코딩프로그래밍 교육을 수행한다.","doWork":"컴퓨터 언어를 이해하고 창의력을 증진시키기 위해 스크래치, 파이썬, C언어 등 컴퓨터 프로그래밍을 교육한다. 블록 코딩으로 간단한 응용프로그램이나 게임을 제작하도록 이론교육을 실시한다. 순서도(알고리즘)에 맞춰 프로그램을 코딩할 수 있도록 교육한다. 프로그램을 직접 기획, 설계하고 다양한 알고리즘을 활용할 수 있도록 실습 교육한다. 기초적인 전자회로를 구성할 수 있도록 교육하고 컴퓨터 내에서 작동할 수 있도록 한다. 아두이노 키트를 사용하여 전자부품을 연결하여 실시간으로 제어할 수 있도록 교육한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"제어조작","dJobECd":"2142","dJobECdNm":"[2142]컴퓨터 강사","dJobJCd":"2542","dJobJCdNm":"[2542]컴퓨터 강사","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002419:1', '{"dJobCd":"K000002419","dJobCdSeq":"1","dJobNm":"간호보조기술학원강사","workSum":"간호보조기술계열학원에서 수강생들에게 간호조무사 및 기타 보건의료 관련 특정교과에 대한 이론과 기술을 강의하고 자격·면허를 취득에 필요한 전문과목을 지도한다.","doWork":"수강생들에게 기초간호(산부인과, 소아과, 응급처치), 전공별 간호, 약물사용법, 보건교육, 환경위생, 지역사회간호교육, 의료법규, 간호영어, 질병(전염병)간호 등에 대한 이론을 가르치고 기능을 시범한다. 실습교육의 비중이 높으며 학과교육 과정에서의 실험실습과 실제 병원파견 실습을 지도·감독한다. 수강생들의 실기기능을 평가하여 미숙한 부분을 시정·보완한다. 학습 및 취업에 관해 학생들과 상담한다. 교습과정으로 간호조무사를 전문으로 지도한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"수동조작","similarNm":"간호학원강사","certLic":"간호사","dJobECd":"2143","dJobECdNm":"[2143]기술·기능계 강사","dJobJCd":"2543","dJobJCdNm":"[2543]기술 및 기능계 강사","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005119:1', '{"dJobCd":"K000005119","dJobCdSeq":"1","dJobNm":"건설기계운전학원강사","workSum":"수강생들을 대상으로 지게차, 굴삭기, 기중기, 로더 등의 건설기계 운전에 대한 이론 및 실기에 대하여 강의한다.","doWork":"수강생들을 대상으로 지게차, 굴삭기, 기중기, 로더(Loader) 등 건설기계의 이론과 실습 강의를 진행한다. 건설기계에 대한 구조학, 법규, 안전관리, 유압, 기관, 전기, 섀시 등 이론교육을 강의한다. 시험 때와 동일한 장비로 작업현장과 같은 환경에서 실기시험 과정을 교육한다. 전년도 출제문제를 분석하여 정리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|손사용|언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"조작운전","similarNm":"중장비운전학원강사","certLic":"기중기운전기능사, 로더운전기능사, 롤러운전기능사, 모터그레이더운전기능사, 불도저운전기능사, 아스팔트피니셔운전기능사, 양화기운전기능사, 천장크레인운전기능사, 컨테이너크레인운전기능사, 타워크레인운전기능사","dJobECd":"2143","dJobECdNm":"[2143]기술·기능계 강사","dJobJCd":"2543","dJobJCdNm":"[2543]기술 및 기능계 강사","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002692:1', '{"dJobCd":"K000002692","dJobCdSeq":"1","dJobNm":"디자인학원강사","workSum":"디자인학원에서 수강생들에게 시각디자인, 편집디자인, 의상디자인 등에 관한 이론 및 실기에 대하여 강의한다.","doWork":"수강생들에게 디자인에 관한 기본적인 이론을 가르치고 기능을 시범한다. 개인적인 능력이나 관심 분야를 고려하여 실기를 지도한다. 실기실습 위주로 교육하고 실습작품으로 실기기능을 평가한다. 수강생들이 자격을 취득할 수 있도록 수험과목을 지도한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"수동조작","similarNm":"디자인강사","certLic":"제품디자인기술사, 제품디자인기사, 제품디자인산업기사","dJobECd":"2143","dJobECdNm":"[2143]기술·기능계 강사","dJobJCd":"2543","dJobJCdNm":"[2543]기술 및 기능계 강사","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002435:1', '{"dJobCd":"K000002435","dJobCdSeq":"1","dJobNm":"목재교육전문가","workSum":"목재에 대한 지식, 목재활용, 목공기술 등 목재에 대한 다양한 기능을 체험·습득 하고자하는 사람을 대상으로 목재교육을 수행한다.","doWork":"단순 목공 체험 및 전문 목공 기술까지 목재에 관한 프로그램을 기획하고 설계한다. 교육대상 및 사용 목재에 따라 수업지도안을 작성한다. 프로그램에 따라 목재의 다양한 기능을 체험·학습시키고 목재에 대한 지식을 습득할 수 있도록 교육한다. 기준, 절차, 방법 등 프로그램 평가계획에 따라 제작된 목공제품을 평가하고 교육활동을 기록한다. 강의실 및 실습장 등 교육활동 환경을 관리한다. 안전사고에 대비한 안전관리계획을 세우기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|언어력|","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"교육","workFunc3":"제어조작","similarNm":"목재교육 전담인력","connectJob":"목공지도사, 목공전문가, 목공체험지도사","certLic":"목재교육전문가","dJobECd":"2143","dJobECdNm":"[2143]기술·기능계 강사","dJobJCd":"2543","dJobJCdNm":"[2543]기술 및 기능계 강사","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002436:1', '{"dJobCd":"K000002436","dJobCdSeq":"1","dJobNm":"방송기술강사","workSum":"수강생들에게 음향 및 조명, 편집, 더빙 및 자막 등 방송기술 분야의 이론과 실기에 대해 강의한다.","doWork":"음향 및 조명에 대하여 이론교육을 실시하고 이론을 토대로 실습을 진행한다. 방송에 사용되는 각종 방송기기에 대하여 강의한다. 방송 구성이론에 대하여 강의하고 실습을 진행한다. 기본 및 응용 디지털 편집프로그램을 교육한다. 더빙 및 컴퓨터그래픽(CG)에 대한 이론교육을 실시한다. 방송더빙 및 방송자막 등의 실습을 진행한다. 수강생들에게 종합편질실과 부조정실 등 현장실습을 통하여 방송제작 현장에 대한 이해를 돕는다. 실습작품을 통해 수강생들을 평가한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|손사용|언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"수동조작","dJobECd":"2143","dJobECdNm":"[2143]기술·기능계 강사","dJobJCd":"2543","dJobJCdNm":"[2543]기술 및 기능계 강사","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004910:1', '{"dJobCd":"K000004910","dJobCdSeq":"1","dJobNm":"방송카메라강사","workSum":"수강생들을 대상으로 방송카메라를 사용한 촬영 이론 및 실무를 교육한다.","doWork":"수강생들을 대상으로 기본 영상론 및 영상 구성, 카메라 운용에 대한 기본 교육을 강의한다. ENG카메라, 6mm카메라, TV카메라, 스포츠 중계 카메라 등 각종 카메라에 대한 기초 및 이론에 대하여 강의한다. 디지털 방송에 관한 이론수업을 진행한다. 음향 및 조명에 대한 이론교육 및 실습을 진행한다. 편집에 대한 이론 및 실습교육을 진행한다. 수강생들의 방송현장 이해도를 높이기 위해 방송국 견학을 진행하기도 한다. ENG촬영 및 VJ영상물 제작을 통해 수강생들을 평가한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|손사용|언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"수동조작","dJobECd":"2143","dJobECdNm":"[2143]기술·기능계 강사","dJobJCd":"2543","dJobJCdNm":"[2543]기술 및 기능계 강사","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005998:1', '{"dJobCd":"K000005998","dJobCdSeq":"1","dJobNm":"산업기반기술학원강사","workSum":"산업기반기술 계열학원에서 수강생들에게 특정교과에 대한 이론과 기술을 강의하고 자격·면허를 취득하기 위한 전문과목을 지도한다.","doWork":"수강생들에게 기본이론, 공구 및 기계의 사용, 안전관리 등에 관하여 설명하고 시범을 보인다. 실습을 지도·감독하고 수강생들의 기능을 평가하여 약점을 보완한다. 교습과정으로 기계, 자동차, 금속, 화공 및 세라믹, 전기, 통신, 전자, 조선, 항공, 토목, 건축, 의복·섬유, 광업자원, 국토개발, 농림, 해양, 에너지, 환경, 공예, 교통, 안전관리 등이 있으며 이러한 기술 분야 중 하나 또는 그 이상을 전문으로 지도한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"정밀작업","connectJob":"지도하는 과목에 따라 기계기술학원강사, 자동차기술학원강사, 금속기술학원강사, 화공 및 세라믹기술학원강사, 전기기술학원강사, 통신기술학원강사, 전자기술학원강사, 조선기술학원강사, 항공기술학원강사, 토목기술학원강사, 건축기술학원강사, 의복·섬유기술학원강사, 광업자원기술학원강사, 국토개발기술학원강사, 농림기술학원강사, 해양기술학원강사, 에너지기술학원강사, 환경기술학원강사, 공예기술학원강사, 교통기술학원강사, 안전관리기술학원강사","dJobECd":"2143","dJobECdNm":"[2143]기술·기능계 강사","dJobJCd":"2543","dJobJCdNm":"[2543]기술 및 기능계 강사","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007068:1', '{"dJobCd":"K000007068","dJobCdSeq":"1","dJobNm":"손톱미용강사","workSum":"손, 손톱, 발, 발톱의 미용 및 관리와 관련한 이론과 실기를 지도·교육한다.","doWork":"손톱의 기초, 파일의 그릿수, 파일의 각도, 손톱의 구조 등에 관한 기초적인 이론을 지도교육한다. 각질제거법, 손맛사지법, 색칠법 등에 관한 기초적인 관리법을 지도·교육한다. 기초이론을 바탕으로 각 부위의 팁(Tip), 랩핑(Wrapping), 익스텐션(Extension)(립+가루), 아크릴릭(Acrylic)(가루+화합물) 등의 사용에 관한 기술적인 지도를 한다. 신체부위에 난 털 제거 및 위생관리에 대한 교육을 한다. 손톱, 발톱 부위에 대한 색칠과 디자인 기술, 손·발톱의 액세서리 부착 등 관련 기술을 교육한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"청각|언어력|시각|","workFunc1":"분석","workFunc2":"교육","workFunc3":"정밀작업","similarNm":"네일아트강사","connectJob":"미조술강사, 네일전문강사, 이미용강사","certLic":"실기교사(미용), 미용사(네일)","dJobECd":"2143","dJobECdNm":"[2143]기술·기능계 강사","dJobJCd":"2543","dJobJCdNm":"[2543]기술 및 기능계 강사","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006063:1', '{"dJobCd":"K000006063","dJobCdSeq":"1","dJobNm":"요리학원강사","workSum":"요리학원에서 수강생들에게 한식, 양식, 일식, 중식 등에 관련된 이론과 실기를 강의한다.","doWork":"수강생들에게 요리에 관한 기본적인 이론을 가르친다. 요리재료의 선정, 작업방법 및 절차, 도구 등에 관하여 설명하며 기능을 시범한다. 개인적인 능력이나 관심 분야를 고려하여 실기를 지도한다. 수강의 요리실습 작품을 평가하고 부족한 부분을 지도한다. 수강생들이 자격을 취득할 수 있도록 수험과목을 지도한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"수동조작","similarNm":"요리강사","certLic":"양식조리기능사, 일식조리기능사, 한식조리기능사, 중식조리기능사","dJobECd":"2143","dJobECdNm":"[2143]기술·기능계 강사","dJobJCd":"2543","dJobJCdNm":"[2543]기술 및 기능계 강사","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007702:1', '{"dJobCd":"K000007702","dJobCdSeq":"1","dJobNm":"유아목재놀이교육사","workSum":"유아를 대상으로 목재에 대한 정보 전달과 지식 발달에 적합한 놀이교육 프로그램을 기획, 설계하고 실시한다.","doWork":"목재놀이를 위하여 목재와 놀이를 포커스로 하여 교육환경을 설계하고 목재놀이키트를 준비하는 등 목재놀이 교육을 준비한다. 나무에 대한 발달 수준별 이론교육 및 놀이로 활용하기 위한 방법을 제시하고 설계된 놀이지도안에 따라 목재놀이코칭을 한다. 교육 전, 교육 중 발생할 수 있는 안전사고를 예방하는 등 안전교육을 실시한다. 교육 후 목재놀이교육 전반을 평가하고 교육활동 일지를 작성한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"언어력|","workFunc1":"수집","workFunc2":"교육","workFunc3":"수동조작","connectJob":"목재교육전문가, 유아숲지도사, 놀이지도사","certLic":"보육교사, 유치원 정교사, 유아숲지도사, 목재교육전문가","dJobECd":"2143","dJobECdNm":"[2143]기술·기능계 강사","dJobJCd":"2543","dJobJCdNm":"[2543]기술 및 기능계 강사","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2025"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002228:1', '{"dJobCd":"K000002228","dJobCdSeq":"1","dJobNm":"이미용강사","workSum":"이·미용학원에서 수강생들에게 헤어커트, 염색 등 헤어의 이·미용에 관한 이론과 실기를 강의한다.","doWork":"수강생들에게 손상된 모발의 재생, 두피의 관리, 염색, 남자커트·여자커트 등에 관한 이론을 가르친다. 이미용 공구 및 기계의 사용방법에 관하여 설명하고 실기 기능을 시범한다. 개인적인 능력이나 관심 분야를 고려하여 커트, 퍼머넌트웨이브, 휭거웨이브, 세팅, 헤어컬러링 등의 실기를 지도한다. 또한 수강생의 실습작품으로 실기기능을 평가하고 부족한 부분을 지도한다. 수강생들이 자격을 취득할 수 있도록 수험과목을 지도·감독한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"정밀작업","connectJob":"이용강사, 미용강사","certLic":"미용장, 이용사, 이용장, 미용사(일반), 실기교사(미용)","dJobECd":"2143","dJobECdNm":"[2143]기술·기능계 강사","dJobJCd":"2543","dJobJCdNm":"[2543]기술 및 기능계 강사","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006365:1', '{"dJobCd":"K000006365","dJobCdSeq":"1","dJobNm":"자동차운전학원강사","workSum":"자동차운전학원에서 수강생에게 자동차운전 이론과 기능, 교통법규 등을 가르친다.","doWork":"운전을 처음 배우거나 운전면허증을 취득하려는 교습생에게 자동차의 승차방법, 기초주행, 기초주행(정치상태 운전장치 조작, 운전상태 운전장치 조작), 도로주행 등의 실기를 지도하고 도로교통법, 운전규정, 자동차구조 등의 이론을 가르친다. 자동차에 교습생과 동승하여 운전시범을 보여주고 연습을 시킨다. 기초주행교육으로 발차, 가속, 감속, 회전운행, 정차 등을 위한 핸들과 페달조작을 교육한다. 기초주행교육으로 전조등, 방향지시등, 와이퍼, 기어변속 조작교육을 시킨다. 교차로, 철길건널목 주행 시 운전방법과 돌발사고 대응 등 운전 중 주의사항에 관해 지도한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"언어력|","workFunc1":"수집","workFunc2":"교육","workFunc3":"조작운전","similarNm":"자동차운전강사, 자동차운전교관","certLic":"자동차운전면허, 자동차운전전문강사","dJobECd":"2143","dJobECdNm":"[2143]기술·기능계 강사","dJobJCd":"2543","dJobJCdNm":"[2543]기술 및 기능계 강사","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004873:1', '{"dJobCd":"K000004873","dJobCdSeq":"1","dJobNm":"자동차정비학원강사","workSum":"자동차정비학원에서 수강생들에게 자동차의 구조와 정비를 강의한다.","doWork":"수강생들을 대상으로 자동차 고장의 원인을 찾고 이를 정비할 수 있도록 교육한다. 기관, 전기, 섀시 자동차의 각 분야에 대하여 작동원리에 대하여 이론 강의한다. 정비에 필요한 공구 사용법 및 안전교육을 실시한다. 엔진, 타이밍벨트, 연료장치, 흡배기 장치 등 기관장치에 대한 이론교육 및 분해·조립을 통한 실습강의를 한다. 발전기, 점화장치, 회로 등 전기장치에 대한 이론교육 및 실습강의를 한다. 변속기, 현가장치, 조향장치, 제동장치 등에 대한 이론교육 및 실습강의를 한다. 각 과정별로 개인별 평가를 하고 이를 교육에 반영한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|손사용|언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"수동조작","certLic":"자동차정비기능사, 자동차정비기능장, 자동차정비기사, 자동차정비산업기사, 자동차차체수리기능사, 차량기술사","dJobECd":"2143","dJobECdNm":"[2143]기술·기능계 강사","dJobJCd":"2543","dJobJCdNm":"[2543]기술 및 기능계 강사","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003988:1', '{"dJobCd":"K000003988","dJobCdSeq":"1","dJobNm":"전동차승무지도원","workSum":"전동차 승무원에 대한 자질 향상과 기술연마를 위해 운전업무 전반에 걸친 이론과 실기교양을 실시하고 승무지도 활동을 통한 사고예방업무를 수행한다.","doWork":"승무지도행로표(열차운행기록표)에 의한 취약시간대 및 취약열차에 승무하여 사고를 미연에 방지한다. 승무지도 시 기관사에게 업무상 필요한 지식을 보완하고, 습성에 의한 불안전 요인을 교정하여 주고 실무지도훈련, 졸음 및 운전사고 예방활동을 한다. 승무지도 후에는 승무지도 보고서를 작성한다. 주요 지도 사항은 전동차승무원의 지도표에 기록·유지한다. 사고원인을 분석하여 대책을 수립한다. 교육, 주행거리, 기량평가 등에 관한 전동차승무원 기록철을 작성한다. 전동차승무원에 대한 이론교육 및 운전시뮬레이터 교육을 실시한다. 전동차승무원 결원 시 또는 비상시 열차운행을 하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"조작운전","certLic":"산업안전기사, 산업안전산업기사, 철도차량운전면허","dJobECd":"2143","dJobECdNm":"[2143]기술·기능계 강사","dJobJCd":"2543","dJobJCdNm":"[2543]기술 및 기능계 강사","dJobICd":"H492","dJobICdNm":"[H492]육상 여객 운송업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003250:1', '{"dJobCd":"K000003250","dJobCdSeq":"1","dJobNm":"직업훈련교사","workSum":"직업전문학교, 직업훈련기관, 산업체 및 공공직업능력훈련시설 등에서 학생들에게 특정 직업에 필요한 기술과 기능을 가르치는 업무를 수행한다.","doWork":"특정 교과에 대해 교육 내용과 시간을 계획한다. 이론교육은 교양, 기초, 전공의 단계로 관련 분야에서 필요로 하는 이론, 방법, 절차 및 용어 등을 가르친다. 실기교육은 기본과 전공, 응용과정으로 구성되며 현장 또는 실험실에서 해당 기술에 관하여 시범을 보이고 학생들의 실습활동을 계획·지도한다. 학생들의 기술지식과 작업능력을 검사·평가한다. 근무 상황부, 교육이수자 명단 등 각종 공문서 처리와 교육일지 등의 장부를 작성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"정밀작업","similarNm":"직업능력개발훈련교사","certLic":"직업능력개발훈련교사","dJobECd":"2143","dJobECdNm":"[2143]기술·기능계 강사","dJobJCd":"2543","dJobJCdNm":"[2543]기술 및 기능계 강사","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005410:1', '{"dJobCd":"K000005410","dJobCdSeq":"1","dJobNm":"철도승무지도교관사","workSum":"기관차 승무원에게 운전이론, 기관차구조, 운전관계 규정 등을 지도·감독하는 업무를 수행한다.","doWork":"철도 사고에 대한 통계자료를 수집하여 사고예방을 위한 교육자료를 준비한다. 기관차 승무원인 기관사와 철도기관조사가 열차운전을 안전하게 수행할 수 있도록 지도한다. 강설기, 강우기, 공사 중인 선로 등의 상황하에서 열차운전에 필요한 차량의 운전방법, 신호방식, 주의사항 등을 해당 승무원에게 지도한다. 회중시계, 열차시각표, 기관사 수첩, 손전등 등 기관사의 휴대품을 점검한다. 열차에 탑승하여 승무원의 근무상태나 철도 및 기관차의 상태를 확인한다. 기관사의 결원 시 기관차를 운전하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"수동조작","certLic":"철도차량산업기사, 철도차량기사, 철도차량운전면허","dJobECd":"2143","dJobECdNm":"[2143]기술·기능계 강사","dJobJCd":"2543","dJobJCdNm":"[2543]기술 및 기능계 강사","dJobICd":"H491","dJobICdNm":"[H491]철도 운송업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002830:1', '{"dJobCd":"K000002830","dJobCdSeq":"1","dJobNm":"피부미용강사","workSum":"피부미용학원, 문화센터, 여성 능력개발원, 대학 등에서 얼굴 및 전신의 피부를 아름답게 유지·보호·개선·관리하기 위한 이론과 실기를 강의한다.","doWork":"피부미용학, 피부학, 해부생리학, 피부미용 기기학, 화장품학, 공중위생 관리학 등에 관한 기초적인 이론을 교육한다. 해면(Sponge), 팩볼, 팩, 마사지 크림, 오일, 왁스 등을 이용하여 다양한 피부타입별 관리방법을 강의한다. 클렌징, 딥 클렌징, 매뉴얼 테크닉, 팩 도포, 팔 다리 관리, 왁싱 등의 실기방법을 시범 보이고 지도한다. 교육생의 미숙한 점을 보완하기 위해 반복적으로 연습시킨다. 수강생들이 자격을 취득할 수 있도록 수험과목을 지도한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"수동조작","similarNm":"이미용강사","certLic":"실기교사(미용), 미용사(피부)","dJobECd":"2143","dJobECdNm":"[2143]기술·기능계 강사","dJobJCd":"2543","dJobJCdNm":"[2543]기술 및 기능계 강사","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001418:1', '{"dJobCd":"K000001418","dJobCdSeq":"1","dJobNm":"항공기술학원강사","workSum":"항공기술학원에서 수강생들을 대상으로 항공정비, 지상지원에 대한 이론과 항공사 현장실무에 대해 강의한다.","doWork":"수강생들을 대상으로 첨단기계 및 전자장비의 집합체인 항공기에 대한 정비 또는 조종 및 항공 분야의 지상지원에 대한 강의를 실시한다. 항공기 엔진 및 전자제어 장치들에 대하여 이론 및 실습을 통해 교육한다. 기체의 판금수리작업, 각종 용접수리작업 및 배관수리작업, 케이블 작업과 같은 기체수리 및 정비에 대한 강의를 실시한다. 지상지원 분야의 경우, 수강생에게 항공기 일반, 공항 지상안전과 항공기 운영 및 서비스, 항공운송일반에 대하여 강의한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|손사용|언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"수동조작","certLic":"항공기관기술사, 항공기사, 항공기체기술사, 항공산업기사, 항공정비사면허증, 항공기정비기능사, 항공전기·전자정비기능사","dJobECd":"2143","dJobECdNm":"[2143]기술·기능계 강사","dJobJCd":"2543","dJobJCdNm":"[2543]기술 및 기능계 강사","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003842:1', '{"dJobCd":"K000003842","dJobCdSeq":"1","dJobNm":"화장술강사","workSum":"메이크업학원, 문화센터, 대학 등에서 외모의 단점을 보완하여 아름다움을 창조하기 위한 화장(Make-up) 방법을 강의한다.","doWork":"메이크업 교육생의 소질을 관찰하여 장·단점을 파악한 후 그에 맞는 지도 방법을 연구한다. 아이섀도, 파우더, 파운데이션(Foundation), 립스틱 등 각종 화장품과 꽃, 분첩(Powder Puff), 스펀지 등의 도구를 이용하여 외모의 아름다움을 창조하기 위하여 기초화장법, 눈·눈썹화장법, 명암법, 입술화장법, 신부화장법, 광고화장법 등 기초화장법에서 고급화장법까지 시범을 보이고 지도한다. 교육생의 미숙한 점을 보완하기 위하여 반복적으로 연습시킨다. 교육과정이 끝나면 화장(Make-up)법에 대한 실기평가를 하여 교육생의 화장법에 대한 이해도와 실기력을 평가 검토한다. 신랑·신부, 패션모델, 방송인, 연예인 및 연극인 등에게 무대, 의상, 얼굴 등의 특성에 따라 전문적으로 화장(Make-up) 및 분장을 하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|언어력|시각|","workFunc1":"분석","workFunc2":"교육","workFunc3":"정밀작업","connectJob":"메이크업전문강사, 분장강사, 특수분장강사","certLic":"미용사(메이크업)","dJobECd":"2143","dJobECdNm":"[2143]기술·기능계 강사","dJobJCd":"2543","dJobJCdNm":"[2543]기술 및 기능계 강사","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006729:1', '{"dJobCd":"K000006729","dJobCdSeq":"1","dJobNm":"내레이션강사","workSum":"내레이션모델 및 내레이터 지망생, 텔레마케터, 발음교정자 등에게 발음법, 발성법, 음성조절법, 문장인용법, 문장작성법 등을 지도한다.","doWork":"내레이터 지망생 등 피교육자의 언어습관을 관찰한 후 장·단점을 파악하여 교육방향을 수립한다. 발견된 피교육자의 장점은 발전될 수 있도록 지도하고 단점은 교정방향을 검토하여 지도·교육한다. 피교육자에게 발음, 발성, 문장표현 및 인용, 호흡법 등을 보여준다. 반복을 통하여 자신 있게 문장을 표현할 수 있도록 지도한다. 마이크사용법, 자기표현법 등 다양한 기술을 지도한다. 최종시험을 통하여 합격 여부를 판정한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","similarNm":"나레이션강사","dJobECd":"2144","dJobECdNm":"[2144]예능 강사","dJobJCd":"2544","dJobJCdNm":"[2544]예능 강사","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002882:1', '{"dJobCd":"K000002882","dJobCdSeq":"1","dJobNm":"모델강사","workSum":"행사도우미, 모델, 행사도우미지망생, 모델지망생 등에게 걸음걸이 및 자세, 의상, 발성 등을 대하여 교육을 한다.","doWork":"행사도우미, 모델, 행사도우미지망생, 모델지망생 등의 걸음걸이 및 자세에 대한 관찰을 통하여 피교육생의 장·단점을 파악한다. 머리에서 다리까지 일직선이 되도록 기본자세를 지도한 후 걷는 자세에서 흐트러짐이 없도록 스태프를 지도한다. 자연스러운 걸음걸이가 되도록 교정한 후 무대배경이나 의상 종류 등에 따라 자기연출이 되도록 지도한다. 지망생 및 모델 등에게 장점을 발전시키도록 지도하고 단점은 시범과 반복교육을 통하여 올바른 걸음자세가 되도록 지도·교육한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","dJobECd":"2144","dJobECdNm":"[2144]예능 강사","dJobJCd":"2544","dJobJCdNm":"[2544]예능 강사","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002041:1', '{"dJobCd":"K000002041","dJobCdSeq":"1","dJobNm":"산업응용기술학원강사","workSum":"산업응용기술계열학원에서 수강생들에게 특정교과에 대한 이론과 기술을 강의하고 자격·면허취득에 필요한 전문과목을 지도한다.","doWork":"수강생들에게 기본이론, 재료 및 부품, 작업방법, 절차, 도구 등에 관하여 설명하고 시범을 보인다. 실습을 지도·감독하고 수강생들의 실기기능을 평가하여 미숙한 부분을 시정·보완한다. 학습 및 취업에 관해 학생들과 상담한다. 교습과정으로 식음료품, 포장, 인쇄, 사진, 피아노조율 등이 있으며 이러한 기술 분야 중 하나 또는 그 이상을 전문으로 지도한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"정밀작업","connectJob":"지도하는 과목에 따라 식음료품기술학원강사, 포장기술학원강사, 인쇄기술학원강사, 사진기술학원강사, 피아노조율기술학원강사","dJobECd":"2144","dJobECdNm":"[2144]예능 강사","dJobJCd":"2544","dJobJCdNm":"[2544]예능 강사","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006696:1', '{"dJobCd":"K000006696","dJobCdSeq":"1","dJobNm":"아트워크매니저","workSum":"모델들의 포즈를 잡아주고 더욱 다양한 자세를 만들도록 도와주는 포즈 지도를 한다.","doWork":"화보집 촬영을 위해 카메라 앵글 앞에 선 모델들의 포즈를 전문적으로 지도한다. 촬영 일정이 잡히면 촬영할 화보집이나 사진의 콘셉트에 어울리는 포즈를 연구한다. 모델의 장점을 살리고 단점은 가릴 수 있는 포즈, 보다 아름답게 보일 수 있는 포즈, 신체곡선미를 가장 잘 살릴 수 있는 방법 등에 대해 연구한다. 자신감 있는 포즈 연출을 위하여 촬영 시 모델의 컨디션을 파악하고 심리적 안정을 취하게 한다. 다양한 포즈를 지도하며, 모델 앞에서 직접 포즈를 취해 이해시키거나 포즈의 힌트를 주기도 한다. 촬영 중간에는 그동안 찍은 사진들을 모니터링하여 보다 나은 포즈를 취하도록 지도한다. 사진작가, 스태프와 함께 사전 콘셉트 회의에 참석해 아이디어를 내며 때로는 장소섭외에 동행하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","dJobECd":"2144","dJobECdNm":"[2144]예능 강사","dJobJCd":"2544","dJobJCdNm":"[2544]예능 강사","dJobICd":"M733","dJobICdNm":"[M733]사진 촬영 및 처리업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006410:1', '{"dJobCd":"K000006410","dJobCdSeq":"1","dJobNm":"예능학원강사","workSum":"예능계열학원에서 수강생들에게 특정교과에 대한 이론과 기술을 강의하고 자격·면허를 취득하기 위한 전문과목을 지도한다.","doWork":"수강생들에게 음악, 미술, 서예, 무용, 꽃꽂이 등 예능 분야의 이론과 기능을 가르친다. 수강생들의 자질을 관찰하고 관찰결과에 따라 개인별 지도계획을 세운다. 기본적인 이론수업을 가르치고 이를 바탕으로 실기 시범을 보인다. 개인적인 능력이나 흥미를 고려하여 실기를 지도한다. 실기실습 위주로 교육을 지도하고 실습작품으로 실기기능을 평가한다. 교습과정으로 공예, 국악, 전통무용, 서예, 음악, 미술, 무용, 만화, 영상, 연극, 영화, 바둑, 성우 등이 있으며, 기술 분야 중 하나 또는 그 이상을 전문으로 지도한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"청각|손사용|언어력|시각|","workFunc1":"분석","workFunc2":"교육","workFunc3":"수동조작","similarNm":"예능강사","connectJob":"공예강사, 음악강사, 보컬트레이너, 악기연주강사, 서예강사, 국악강사, 전통무용강사, 미술강사, 무용강사, 만화강사, 연기강사, 바둑강사, 요가강사, 서각강사","dJobECd":"2144","dJobECdNm":"[2144]예능 강사","dJobJCd":"2544","dJobJCdNm":"[2544]예능 강사","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005714:1', '{"dJobCd":"K000005714","dJobCdSeq":"1","dJobNm":"웅변강사","workSum":"수강생을 대상으로 일과 생활에서 효과적인 말하기를 할 수 있도록 교육을 한다.","doWork":"수강생들에게 커뮤니케이션, 연설, 프레젠테이션 시에 필요한 화법이나 일상생활에서 원활하게 말하기를 교육한다. 전문적이고 효율적으로 말하는 방법에 대하여 강의한다. 실습을 통해 표정 및 행동을 수정한다. 수강생 개인의 특징을 파악하고 내성적인 성격 개선과 자신감을 키울 수 있도록 돕는다. 개인별 평가를 통해 문제점을 파악하고 말하는 노하우를 교육한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","similarNm":"스피치강사","dJobECd":"2144","dJobECdNm":"[2144]예능 강사","dJobJCd":"2544","dJobJCdNm":"[2544]예능 강사","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002531:1', '{"dJobCd":"K000002531","dJobCdSeq":"1","dJobNm":"전통놀이강사","workSum":"청소년들을 대상으로 전통놀이 및 전통문화를 시연하고 체험활동을 진행한다.","doWork":"어린이집, 유치원, 초등학교 등을 방문하여 어린들에게 비석치기, 구슬치기, 풀잎배 만들기, 종이배 만들기, 강강술래 등의 전통놀이를 시연하고 체험활동을 진행한다. 전통놀이 외에도 가을 송편 빚기나 전래동화 읽기, 식물채집 등 다양한 전통문화 활동을 교육하기도 한다. 교구재 제작을 위해 구입이 어려운 자연재료는 직접 산과 들로 다니며 재료를 구해서 만들기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|언어력|","workFunc1":"수집","workFunc2":"교육","workFunc3":"관련없음","similarNm":"전통놀이지도사","dJobECd":"2144","dJobECdNm":"[2144]예능 강사","dJobJCd":"2544","dJobJCdNm":"[2544]예능 강사","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003427:1', '{"dJobCd":"K000003427","dJobCdSeq":"1","dJobNm":"다문화가정방문교사","workSum":"외국인 부모의 영향으로 언어 발달에 장애를 겪는 다문화가정 자녀에게 언어발달 및 학교생활 적응을 위한 서비스를 제공한다.","doWork":"다문화가정을 방문하여 주로 초등학생 자녀들을 대상으로 한국어 교육을 비롯하여 예절 등 한국문화 교육, 학교 생활지도 및 상담 등을 한다. 그 외에 교과목 학습지도나 학교과제 활동을 지원하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"수집","workFunc2":"교육","workFunc3":"관련없음","connectJob":"이주여성에게 한국어를 가르치는 경우 한국문화강사","certLic":"사회복지사(1급, 2급)","dJobECd":"2145","dJobECdNm":"[2145]학습지·교육교구 방문강사","dJobJCd":"2545","dJobJCdNm":"[2545]학습지 및 교육 교구 방문강사","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006683:1', '{"dJobCd":"K000006683","dJobCdSeq":"1","dJobNm":"사이처","workSum":"인터넷학습사이트 등에서 학생 회원들에게 교과 강의 외에 효과적인 학습을 하도록 상담·지도·관리를 한다.","doWork":"메일, 전화, 게시판을 통하여 회원들과 학습 프로그램 및 의문점에 대해 상담을 한다. 학생 회원의 학습을 지도·관리하고 학습동기를 부여한다. 학업에 관한 문제들을 학부모와 상담한다. 학부모에게 학습정보를 제공한다. 학습지도안을 작성한다. 화상수업 자료를 준비한다. 시청각자료를 활용하여 화상수업을 진행한다. 출석확인, 과제검토 등을 통해 회원들을 평가한다. 학습이 부진한 회원에게는 추가 학습정보를 제공한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"수집","workFunc2":"교육","workFunc3":"관련없음","similarNm":"사이버학습지교사","dJobECd":"2145","dJobECdNm":"[2145]학습지·교육교구 방문강사","dJobJCd":"2545","dJobJCdNm":"[2545]학습지 및 교육 교구 방문강사","dJobICd":"P857","dJobICdNm":"[P857]교육지원 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004429:1', '{"dJobCd":"K000004429","dJobCdSeq":"1","dJobNm":"학습매니저","workSum":"학생들이 효과적으로 공부할 수 있도록 학습계획을 세우고 지도한다.","doWork":"학생 및 학부모와 상담한다. 심리검사를 통하여 학생을 분석한다. 상담내용 및 분석내용을 바탕으로 학생의 성격이나 습관 등을 파악한 후 학습관리 계획을 수립한다. 학생의 학업수준을 파악하기 위하여 시험평가를 실시한다. 학습관리를 통해서 공부에 집중할 수 있도록 지원한다. 정기적으로 학생과 상담하여 상담일지를 작성한다. 새로운 입시제도에 대한 정보를 수집하고 적절한 학습방법을 연구한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","dJobECd":"2145","dJobECdNm":"[2145]학습지·교육교구 방문강사","dJobJCd":"2545","dJobJCdNm":"[2545]학습지 및 교육 교구 방문강사","dJobICd":"P857","dJobICdNm":"[P857]교육지원 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002756:1', '{"dJobCd":"K000002756","dJobCdSeq":"1","dJobNm":"학습지방문교사","workSum":"회원의 가정을 방문하여 학습지를 전달하고, 회원을 가르치며 학습과정을 지도한다.","doWork":"업무적응 기간 동안 지점을 방문하여 학습 및 회원관리에 대한 교육을 받는다. 업무지역이 배정되면 회원 및 회원부모와 가정방문 시간을 협의하고, 회원별 학습진도를 계획한다. 학습지도안을 작성하고 수업자료를 준비한다. 회원의 가정에 방문하여 학습지를 전달하고, 학습지를 활용하여 수업을 진행한다. 과제를 내주고 결과를 검토한다. 회원의 학습정도를 평가하여 학습진도 계획에 반영한다. 기존회원을 관리하며, 신규회원을 확보하기 위해 전단지를 배포하는 등의 영업을 한다. 회원의 학습지도에 대한 학부모의 상담에 응대한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"수집","workFunc2":"교육","workFunc3":"관련없음","similarNm":"학습지관리교사, 학습지교사","dJobECd":"2145","dJobECdNm":"[2145]학습지·교육교구 방문강사","dJobJCd":"2545","dJobJCdNm":"[2545]학습지 및 교육 교구 방문강사","dJobICd":"P855","dJobICdNm":"[P855]일반 교습 학원","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002787:1', '{"dJobCd":"K000002787","dJobCdSeq":"1","dJobNm":"경영관리학원강사","workSum":"경영관리계열학원에서 수강생들에게 특정교과에 대한 이론과 기술을 강의하고 자격·면허를 취득하기 위한 전문과목을 지도한다.","doWork":"수강생들에게 회계원리, 재무관리, 경제학, 통계학, 채권분석, 금융자산관리, 부동산업무 등 각종 시험에 출제되는 과목을 가르친다. 최신 시험 출제경향을 분석하고 정보를 제공한다. 수강생들의 학습성과를 진단하기 위해 정기적인 시험을 실시·평가한다. 학습과 취업, 각종 시험에 관한 상담을 한다. 교습과정으로 금융, 보험, 유통, 부동산 등이 있으며 이러한 기술 분야 중 하나 또는 그 이상을 전문으로 지도한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","dJobECd":"2149","dJobECdNm":"[2149]기타 문리·기술 및 예능 강사","dJobJCd":"2549","dJobJCdNm":"[2549]기타 문리·기술 및 예능 강사","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002970:1', '{"dJobCd":"K000002970","dJobCdSeq":"1","dJobNm":"고객서비스교육담당원","workSum":"CS(Customer Satisfaction) 의식을 강화하기 위해 고객응대기법, 창구섭외기법, 고객관리기법, 환경개선 교육을 한다.","doWork":"고객만족도 조사를 실시하여 여수신 고객에 대한 평가, 서비스 실태에 대한 평가 등 조사지표별 현황을 분석한다. 부진요인을 도출하여 영업점 환경에 맞고 전체 직원이 공감할 수 있는 개선계획을 수립한다. 직원교육으로 CS마인드 강화교육과 창구응대기법, 고객관리기법, 환경개선을 위한 투자 교육을 실시·지도한다. CS강화에 대한 조사 및 평가를 통해 사후관리를 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"조정","workFunc2":"교육","workFunc3":"관련없음","dJobECd":"2149","dJobECdNm":"[2149]기타 문리·기술 및 예능 강사","dJobJCd":"2549","dJobJCdNm":"[2549]기타 문리·기술 및 예능 강사","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002278:1', '{"dJobCd":"K000002278","dJobCdSeq":"1","dJobNm":"과학커뮤니케이터","workSum":"방과후 교실, 박물관, 강연, 언론매체 등에서 학생 및 일반인들을 대상으로 과학을 쉽게 이해시키고 알리기 위해 설명하고 기고하며 프로그램을 운영한다.","doWork":"초등학교 방과 후 교실에서 실험 및 탐구 중심의 과학수업을 진행한다. 과학관, 박물관에서 전시된 자료를 학생과 일반인에게 설명한다. 일반인이나 학생들이 과학·공학을 보다 쉽게 이해할 수 있도록 소개 방법(문서, 연극, 공개실험 등)을 구상하고 전달한다. 설명에 사용될 자료 및 도구(파워포인트 자료, 실험도구, 연극 등)를 준비한다. 정해진 장소에서 미리 구상하고 설계한 내용을 토대로 과학 관련 내용을 설명한다. 과학적 발견, 과학논쟁점 등 과학 이슈에 대해 기고문 및 강연회 등을 통해 국민들에게 설명한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"언어력|","workFunc1":"수집","workFunc2":"교육","workFunc3":"관련없음","connectJob":"과학관해설사, 방과후과학교사, 과학유튜버, 생활과학교실강사","dJobECd":"2149","dJobECdNm":"[2149]기타 문리·기술 및 예능 강사","dJobJCd":"2549","dJobJCdNm":"[2549]기타 문리·기술 및 예능 강사","dJobICd":"R902","dJobICdNm":"[R902]도서관, 사적지 및 유사 여가관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002724:1', '{"dJobCd":"K000002724","dJobCdSeq":"1","dJobNm":"교육연수기관강사","workSum":"각 소속기관으로부터 추천받은 연수대상자를 대상으로 각 과정을 교육한다.","doWork":"각 소속기관별, 과정별 연수대상자를 대상으로 교육을 실시한다. 기본적인 항목별 설명을 비롯하여 각종 정책 및 시스템 사용법, 보고서 작성법 등을 예시를 통하여 쉽게 이해하도록 설명한다. 심화과정을 통해 전문가를 양성하기도 한다. 각 과정별 애매한 부분에 대하여 재교육하고 평가한다. 각종 강의자료를 작성하고 교육용 교안 등을 배부한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","dJobECd":"2149","dJobECdNm":"[2149]기타 문리·기술 및 예능 강사","dJobJCd":"2549","dJobJCdNm":"[2549]기타 문리·기술 및 예능 강사","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003747:1', '{"dJobCd":"K000003747","dJobCdSeq":"1","dJobNm":"교통안전교육강사","workSum":"교통안전에 대해 강의하고 교육자료를 작성한다.","doWork":"신규면허 취득자, 법규위반자, 교통사고 대상자를 대상으로 교통안전에 대해 교육한다. 교통안전 교육을 위한 자료를 제작한다. 외부기관에서 요청이 있을 경우 출장강의를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","certLic":"교통안전관리자(도로)","dJobECd":"2149","dJobECdNm":"[2149]기타 문리·기술 및 예능 강사","dJobJCd":"2549","dJobJCdNm":"[2549]기타 문리·기술 및 예능 강사","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006477:1', '{"dJobCd":"K000006477","dJobCdSeq":"1","dJobNm":"교통안전교육원","workSum":"교통안전 의식전환을 통한 선진 교통문화를 이룩하기 위하여 체계적이고 과학적인 교육을 시행한다.","doWork":"교통안전교육의 기본계획을 수립하고 시행한다. 국민의 교통안전의식 함양을 위해 교통안전 교육용 전문도서 및 시청각자료를 개발·보급한다. 교통안전 연구 및 교육지원에 관한 업무를 수행한다. 교육장, 생활관 및 교육기자재를 관리한다. 교통안전관리자 자격시험에 관한 제반 업무를 수행한다. 교통사고 통계관리에 관한 업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","certLic":"교통안전관리자(도로)","dJobECd":"2149","dJobECdNm":"[2149]기타 문리·기술 및 예능 강사","dJobJCd":"2549","dJobJCdNm":"[2549]기타 문리·기술 및 예능 강사","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002686:1', '{"dJobCd":"K000002686","dJobCdSeq":"1","dJobNm":"기업체직무훈련강사","workSum":"직무능력 향상을 위하여 기업체 직원들을 대상으로 교육한다.","doWork":"인사·조직, 생산 및 품질관리, 생산기술, 유통·물류, HRD·리더십 등 각 훈련과정에 따라 기업체 직원들을 대상으로 교육한다. 직무적성검사를 통하여 개인별 업무능력 및 대인관계 능력 등 직무 적합도를 평가한다. 직업훈련 전용시설에서 집체훈련을 하거나 원격훈련(e-Learning) 등을 실시한다. 직무훈련을 실시하고 수료증을 발급하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","dJobECd":"2149","dJobECdNm":"[2149]기타 문리·기술 및 예능 강사","dJobJCd":"2549","dJobJCdNm":"[2549]기타 문리·기술 및 예능 강사","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003774:1', '{"dJobCd":"K000003774","dJobCdSeq":"1","dJobNm":"난독증학습장애지도사","workSum":"난독증으로 학습에 장애가 있는 학생들이 학업을 수행할 수 있도록 학습과정을 설계하고 학습자료를 준비하도록 돕는다.","doWork":"K-WISC-lll 지능검사와 기초학습기능검사 등을 통해 난독증학습장애를 진단한다. 난독증학습장애 학생의 부모나 교사 등에게 난독증에 관한 정보를 제공하고 대응방법을 교육한다. 뇌가 유연한 상태에서 문제가 있는 미세한 뇌기능적 부분이 발달할 수 있도록 언어치료적 접근, 신경생리학적 접근, 심리정서적 접근 등 다양한 방법으로 학습자료를 개발하고 지도한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","dJobECd":"2149","dJobECdNm":"[2149]기타 문리·기술 및 예능 강사","dJobJCd":"2549","dJobJCdNm":"[2549]기타 문리·기술 및 예능 강사","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005622:1', '{"dJobCd":"K000005622","dJobCdSeq":"1","dJobNm":"농촌교육농장운영자","workSum":"농업·농촌의 자원을 활용하여 학생들과 일반들에게 학습과 쉼을 제공하기 위하여 교육농장을 설계하고 각종 교육프로그램을 기획, 개발 및 운영한다.","doWork":"농업·농촌의 자원을 활용하여 농촌교육 농장을 설계하고 구성한다. 교육 대상 및 교육 소재 등을 토대로 프로그램을 기획하고 개발한다. 농촌교육 농장 및 프로그램에 대해 홍보한다. 학교 등 참여기관 담당자와 학습 일정과 내용 등을 논의한다. 교육농장 프로그램을 위한 교구 및 교재를 개발한다. 프로그램에 맞춰 강의, 체험활동 등 프로그램을 안전하게 운영한다. 교육농장 시설 등을 점검하고 관리한다. 교육대상의 반응 등을 고려하여 교육프로그램을 평가하고 필요시 수정한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"언어력|","workFunc1":"수집","workFunc2":"교육","workFunc3":"관련없음","similarNm":"농촌교육농장플래너, 교육농장운영자","dJobECd":"2149","dJobECdNm":"[2149]기타 문리·기술 및 예능 강사","dJobJCd":"2549","dJobJCdNm":"[2549]기타 문리·기술 및 예능 강사","dJobICd":"R902","dJobICdNm":"[R902]도서관, 사적지 및 유사 여가관련 서비스업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006692:1', '{"dJobCd":"K000006692","dJobCdSeq":"1","dJobNm":"다문화언어지도사","workSum":"다문화가족 자녀의 의사소통 문제를 평가해 적절한 언어발달 지원 및 교육을 제공한다.","doWork":"의사소통에 문제가 있는 다문화가족 자녀에 대한 상담접수를 받는다. 다문화지원센터의 언어교실에서 업무를 수행하거나, 검사도구와 교구를 지참하여 아동이 있는 집으로 직접 방문한다. 초기 면담지를 작성한다. 부모 상담과 언어평가를 실시하고, 언어평가 검사보고서를 작성한다. 검사결과에 기초하여 언어발달 지원을 위한 장·단기 수업계획서를 작성한다. 언어발달 지체가 있을 경우, 환경적·원인적 접근(출생 배경, 동반장애, 언어 환경) 및 기술적·발달적 접근(현재 언어수행 수준이나 결함분석) 등을 동시에 시행하여 문제점을 분석한다. 부모에게 아동의 언어발달을 촉진할 수 있도록 상담 및 교육방법을 제공한다. 아동이 학교생활에 원만하게 적응할 수 있도록 지도·상담한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","connectJob":"다문화가정상담지도사, 다문화가정방문교사, 한국문화강사, 결혼이민자도우미","dJobECd":"2149","dJobECdNm":"[2149]기타 문리·기술 및 예능 강사","dJobJCd":"2549","dJobJCdNm":"[2549]기타 문리·기술 및 예능 강사","dJobICd":"O845","dJobICdNm":"[O845]사회보장 행정","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001806:1', '{"dJobCd":"K000001806","dJobCdSeq":"1","dJobNm":"동화구연사","workSum":"어린이들에게 전래동화 등의 동화를 연기하듯 들려준다.","doWork":"어린이집이나 유치원, 지역 어린이도서관, 사설 학원 등에 파견을 나가 어린이들에게 전래동화나 재미있는 이야기를 등장인물의 성격과 상황에 맞게 음성에 변화를 주어 연기하듯 재미있게 들려주는 일을 한다. 이때 손인형 등 소품을 이용하여 이야기에 재미를 더하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"수집","workFunc2":"오락제공","workFunc3":"관련없음","similarNm":"동화구연가, 동화구연지도자, 북시터","dJobECd":"2149","dJobECdNm":"[2149]기타 문리·기술 및 예능 강사","dJobJCd":"2549","dJobJCdNm":"[2549]기타 문리·기술 및 예능 강사","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004330:1', '{"dJobCd":"K000004330","dJobCdSeq":"1","dJobNm":"드론교관","workSum":"신입조종자 또는 지도교관 조종사 훈련생에게 드론조종 이론과 기능 등에 대해 교육하고 비행 실습을 실시한다.","doWork":"교육을 위한 자료나 교구재를 개발하거나 만든다. 항공안전법, 무인항공기의 시스템의 구조와 작동원리 등에 대해 강의한다. 엔진시동, 이륙, 상승, 순항, 착륙 등 모든 비행단계에서 무인항공기의 실제 조종방법을 가르친다. 항공기 모의조종장치를 사용하여 단계별 혹 상황별로 조종훈련을 실시한다. 무인항공기를 원격 조종하여 실제 조종훈련을 실시한다. 훈련생을 평가한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"드론강사, 무인멀티콥터지도교관","certLic":"초경량비행장치조종자격, 드론지도조종자","dJobECd":"2149","dJobECdNm":"[2149]기타 문리·기술 및 예능 강사","dJobJCd":"2549","dJobJCdNm":"[2549]기타 문리·기술 및 예능 강사","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005922:1', '{"dJobCd":"K000005922","dJobCdSeq":"1","dJobNm":"매너강사","workSum":"기업체 및 공공기관 임직원과 개인 고객을 대상으로 고객응대 및 전화예절, 국제비지니스 및 사교행사 매너, 조직 내 인간관계 관리 등에 관한 강의를 한다.","doWork":"국제업무 종사원, 해외근무자 혹은 비즈니스 여행자 등에게 국제사회 관행과 타 문화 이해를 통한 의사소통능력 제고와 예절을 교육한다. 판매, 영업, 비서 및 서비스 관련 고객응대 직원이 고객에 대한 대화법, 전화예절, 고객접대예절, 복장과 외모관리 및 표정관리 등 갖춰야 할 서비스정신 및 각종 예절을 교육하고 관리한다. 직장인으로서 갖춰야 할 상하 간 혹은 수평 간의 관계에 있어 대화법, 전화응대법 등 기본적인 예절을 교육한다. 국제관행에 충실한 귀빈접대 절차와 요령을 교육하여 기업경쟁력을 강화시켜주기 위한 기업 의전교육 및 기업이미지 개선을 위한 프로그램을 계획하고 관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","similarNm":"매너코칭지도자, 서비스강사, CS강사, 친절강사, 매너서비스강사","connectJob":"매너컨설턴트","dJobECd":"2149","dJobECdNm":"[2149]기타 문리·기술 및 예능 강사","dJobJCd":"2549","dJobJCdNm":"[2549]기타 문리·기술 및 예능 강사","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002857:1', '{"dJobCd":"K000002857","dJobCdSeq":"1","dJobNm":"박물관교육사","workSum":"다양한 박물관에서 관련 분야의 교육프로그램을 개발하고 운영한다.","doWork":"미술, 무용, 음악, 과학, 동물, 민속, 고궁, 국가유산, 역사, 만화, 영화, 국악 등 박물관의 분야에 따라 교육주제를 정한다. 해당 분야의 표준교재, 교수법, 교육자료를 조사한다. 교육일정, 학습인원, 수준 등을 고려하여 효과적인 교수학습 모형과 전략을 개발한다. 해당 분야 교수·학습 요강을 유연하게 재구성하여 교육프로그램을 기획하고 수업지도안을 개발한다. 박물관의 자원을 응용하거나 새로운 교구·교재를 제작하여 교육여건을 조성한다. 체험, 만들기, 배우기, 답사, 관찰, 시연, 트레이닝, 창작, 실습 등 다양하고 창의적인 교육방법으로 교육을 진행한다. 교육성과를 평가하고 개선한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","similarNm":"박물관에듀케이터","certLic":"준학예사, 정학예사(1급, 2급, 3급)","dJobECd":"2149","dJobECdNm":"[2149]기타 문리·기술 및 예능 강사","dJobJCd":"2549","dJobJCdNm":"[2549]기타 문리·기술 및 예능 강사","dJobICd":"R902","dJobICdNm":"[R902]도서관, 사적지 및 유사 여가관련 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003147:1', '{"dJobCd":"K000003147","dJobCdSeq":"1","dJobNm":"브레인트레이너","workSum":"두뇌의 구조 및 기능에 대한 이해를 바탕으로 대상자의 두뇌 특성을 평가하고 두뇌능력 향상을 위한 훈련프로그램을 제시하고 지도한다.","doWork":"내담자와 상담하고 측정장비 및 상담도구를 사용하여 두뇌능력을 측정한다. 측정결과를 분석하고 평가한다. 아동, 청소년, 성인, 노인별로 두뇌능력 향상 목표를 설정하고 훈련프로그램을 기획한다. 뇌 체조, 명상·호흡 훈련, 뉴로피드백 훈련, 인지훈련 등 다양한 두뇌훈련을 실시하고 지도한다. 두뇌발달 촉진, 집중력 향상, 스트레스 관리, 인지기능 저하 예방, 기억력 향상 등 훈련성과를 평가·관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"교육","workFunc3":"정밀작업","certLic":"브레인트레이너","dJobECd":"2149","dJobECdNm":"[2149]기타 문리·기술 및 예능 강사","dJobJCd":"2549","dJobJCdNm":"[2549]기타 문리·기술 및 예능 강사","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005451:1', '{"dJobCd":"K000005451","dJobCdSeq":"1","dJobNm":"생명윤리운영원","workSum":"연구대상자의 권리와 복지를 보호하기 위한 목적으로 연구에 대한 심의, 연구의 진행과정 및 결과에 대한 조사·감독 등을 수행하는 위원회인 IRB(Institutional Review Board:기관생명윤리위원회)의 운영과 관리에 필요한 행정적인 업무를 담당한다.","doWork":"위원회 개최를 위해 위원을 소집한다. 위원회 운영을 위한 회의자료를 준비한다. 위원들이 연구의 계획 및 진행과정과 결과에 대한 심의·조사·감독하는 데 필요한 행정 업무를 지원한다. 임상시험 및 연구 종사자를 대상으로 교육을 시행한다. 취약한 연구대상자 등의 보호대책 수립, 연구자를 위한 윤리지침 마련 등의 업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"조정","workFunc2":"교육","workFunc3":"관련없음","similarNm":"생명윤리간사","dJobECd":"2149","dJobECdNm":"[2149]기타 문리·기술 및 예능 강사","dJobJCd":"2549","dJobJCdNm":"[2549]기타 문리·기술 및 예능 강사","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006128:1', '{"dJobCd":"K000006128","dJobCdSeq":"1","dJobNm":"성교육강사","workSum":"일반 기업체, 학교, 공공기관 등에서 올바른 성윤리 의식 함양을 위한 성교육을 한다.","doWork":"성(性)에 대한 생물학적 지식과 올바른 성 가치관이 형성될 수 있도록 전문적인 교육을 실시한다. 성에 관련된 상담을 한다. 학교와 기업 등에서 성(性)에 대한 올바른 생물학적, 과학적 지식을 교육한다. 학습자의 연령대별 수준에 맞는 교육프로그램을 계획한다. 교육효과를 높이기 위한 다양한 교구를 준비한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","similarNm":"성교육전문가","dJobECd":"2149","dJobECdNm":"[2149]기타 문리·기술 및 예능 강사","dJobJCd":"2549","dJobJCdNm":"[2549]기타 문리·기술 및 예능 강사","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002676:1', '{"dJobCd":"K000002676","dJobCdSeq":"1","dJobNm":"식생활지도사","workSum":"건강한 식생활을 위해 좋은 식재료 선택과 올바른 식생활습관 및 식품안전에 대해 교육한다.","doWork":"가정과 학교에서 바람직한 식생활 지식을 습득하고 올바른 식생활 습관을 형성할 수 있도록 지도한다. 학교급식 실천지도 강화를 통해 건강개선 및 성장발달을 위한 식생활 교육을 담당한다. 세대별로 바른 식생활 실천 가이드를 개발하여 제시한다. 환경 친화적인 식생활 교육을 확산하기 위하여 전통·향토음식을 체험할 수 있도록 안내하고 지도한다. 적합한 건강식품을 선별할 수 있도록 지도한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"수집","workFunc2":"교육","workFunc3":"관련없음","dJobECd":"2149","dJobECdNm":"[2149]기타 문리·기술 및 예능 강사","dJobJCd":"2549","dJobJCdNm":"[2549]기타 문리·기술 및 예능 강사","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006941:1', '{"dJobCd":"K000006941","dJobCdSeq":"1","dJobNm":"연극놀이강사","workSum":"어린아이들의 정서발달 및 사회성발달을 위한 연극놀이를 지도한다.","doWork":"주로 어린이를 대상으로 사회성, 자신감, 표현력 등을 길러주기 위해 연극적 방법론을 활용하여 연극놀이를 진행한다. 인형만들기, 인형극하기, 움직임과 마임, 역할놀이, 즉흥연기, 감정표현, 상황만들기 등 연극놀이를 통한 교육프로그램을 개발한다. 각 상황에 맞게 아이들이 느끼는 감정을 조절하거나 발산할 수 있도록 유도하며 상황에 따른 반응을 관찰한다. 아이들의 문제를 파악하고 그에 맞는 놀이를 하도록 유도해 문제를 해결하거나 긍정적인 모습으로 변화시키는 일을 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"수집","workFunc2":"교육","workFunc3":"관련없음","similarNm":"교육연극강사","dJobECd":"2149","dJobECdNm":"[2149]기타 문리·기술 및 예능 강사","dJobJCd":"2549","dJobJCdNm":"[2549]기타 문리·기술 및 예능 강사","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007174:1', '{"dJobCd":"K000007174","dJobCdSeq":"1","dJobNm":"온라인튜터","workSum":"이메일, 웹, 소셜 미디어 등을 활용하여 온라인상에서 학습자의 학습을 지원한다.","doWork":"온라인을 통해 학생들에 대한 질의응답과 보충 지도를 통해 학습 결손을 해소한다. 온라인 학습콘텐츠 등 지도자료를 준비하고 이를 활용하여 교과서 내용 등 학습자를 위한 학습지도를 한다. 과제를 관리하고 학습자가 경험하는 인지적·심리적 문제를 상담을 통해 해소한다. 학습자 질문을 종합·분석하여 학습자가 경험하는 문제와 원인에 대한 정보를 제공한다. 학생 학습이력을 관리하고 교원 등과 협의한다. 활동사항을 보고한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","certLic":"정교사, 청소년상담사","dJobECd":"2149","dJobECdNm":"[2149]기타 문리·기술 및 예능 강사","dJobJCd":"2549","dJobJCdNm":"[2549]기타 문리·기술 및 예능 강사","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001476:1', '{"dJobCd":"K000001476","dJobCdSeq":"1","dJobNm":"유아숲지도사","workSum":"유아들에게 안전하고 즐거운 숲체험 학습을 통해 오감발달과 자연의 소중함을 일깨워 주기 위해 프로그램 운영 및 개발, 유아숲 체험원 관리, 그리고 안전지도를 한다.","doWork":"유아의 특성 등을 고려하여 산림 체험 교육프로그램을 구성한다. 교육프로그램 내용에 따라 교구재를 개발하고 수업을 준비한다. 유아들은 유아숲이나 유치원 및 유아원으로 이동을 안전하게 관리한다. 유아숲체험 프로그램에 따라 유아의 숲체험 활동을 지도한다. 산림교육 시설물, 코스 및 해설 자원 등을 모니터링하고 관리하며 개발한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","similarNm":"숲선생님, 숲교사","certLic":"산림교육전문가","dJobECd":"2149","dJobECdNm":"[2149]기타 문리·기술 및 예능 강사","dJobJCd":"2549","dJobJCdNm":"[2549]기타 문리·기술 및 예능 강사","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004068:1', '{"dJobCd":"K000004068","dJobCdSeq":"1","dJobNm":"자연학습교사","workSum":"초등학생 등을 대상으로 동물, 식물, 곤충에 관한 자연학습을 지도하고 설명한다.","doWork":"계절별 자연학습 일정을 수립한다. 일 년간 교육 일정을 각종 학교에 배포한다. 자연학습에 대한 교육을 접수받는다. 학교와 협의하여 구체적인 자연학습 일정을 잡는다. 초등학생을 대상으로 동물, 식물, 곤충에 관한 자연학습을 지도하고 설명한다. 초등학생 등을 자연학습장으로 인솔한다. 학생들에게 동물, 식물, 곤충 등에 관한 지식과 자연과 인간과의 관계 등에 대해 설명한다. 학생들이 자연을 이해하고 자연과 친해지도록 각종 프로그램을 운영한다. 학생들에 대한 안전지도를 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실외","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","dJobECd":"2149","dJobECdNm":"[2149]기타 문리·기술 및 예능 강사","dJobJCd":"2549","dJobJCdNm":"[2549]기타 문리·기술 및 예능 강사","dJobICd":"R902","dJobICdNm":"[R902]도서관, 사적지 및 유사 여가관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006337:1', '{"dJobCd":"K000006337","dJobCdSeq":"1","dJobNm":"직업체험강사","workSum":"직업체험 대상자에게 체험을 안내하고 체험을 진행하며 체험 후 질의응답 등 추수활동을 한다.","doWork":"직업체험 안내를 위한 준비를 한다. 체험학생에게 직업체험에 대해 전반적으로 설명한다. 직업체험과 관련된 동영상 등 시청각자료를 소개한다. 직업체험 순서, 과정, 체험 시 안전사항 등 체험 직업을 안내한다. 체험이 원활히 이루어지도록 체험과정을 모니터링 한다. 문제가 발생할 때 조치를 취한다. 체험 후 질의응답 등 추수활동을 한다. 직업체험과 관련된 추가 정보 등을 알려준다. 일일업무보고 등 행정업무를 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"수집","workFunc2":"교육","workFunc3":"수동조작","dJobECd":"2149","dJobECdNm":"[2149]기타 문리·기술 및 예능 강사","dJobJCd":"2549","dJobJCdNm":"[2549]기타 문리·기술 및 예능 강사","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003905:1', '{"dJobCd":"K000003905","dJobCdSeq":"1","dJobNm":"직업체험매니저","workSum":"직업체험 현장과 강사를 관리감독하고 체험 시설 및 장비 등을 관리하며 직업체험 프로그램 개발 및 개정 등을 지원한다.","doWork":"직업체험 강사를 관리하고 감독한다. 직업체험 강사를 교육한다. 직업체험 장비 및 설비의 이상 유무를 점검한다. 직업체험 문제점을 분석하고 개선점을 제언한다. 직업체험 프로그램의 개발 및 개정에 참여한다. 현장에서 발견된 문제점 등을 파악하여 해결 또는 보고한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"감독","workFunc3":"제어조작","similarNm":"직업체험연구원","dJobECd":"2149","dJobECdNm":"[2149]기타 문리·기술 및 예능 강사","dJobJCd":"2549","dJobJCdNm":"[2549]기타 문리·기술 및 예능 강사","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003344:1', '{"dJobCd":"K000003344","dJobCdSeq":"1","dJobNm":"채소소믈리에","workSum":"대중을 대상으로 채소와 과일의 맛과 즐거움, 본연의 가치를 파악하여 제공하며 채소와 과일의 선정, 유통 및 보관 방법을 안내하며 레시피 등 활용방법을 제안하거나 건강한 식습관 등을 교육한다.","doWork":"대중에게 채소와 과일의 맛과 즐거움, 본연의 가치를 파악하여 제공한다. 채소와 과일을 정확하게 감별, 선정할 수 있도록 정보를 제공하고 추천 또는 안내한다. 채소와 과일의 맛과 영양 등 특성을 파악하여 활용방법과 레시피를 제안한다. 어린이와 성인을 대상으로 채소와 과일과 관련된 건강 식습관을 형성하도록 교육한다. 채소와 과일을 활용하여 미술프로그램을 개발하는 등 관련 콘텐츠를 개발한다. 채소와 과일의 산지 정보를 비롯하여 유통과 보관 등의 방법과 정보를 제공한다. 채소와 과일의 특성과 가치를 제공하는 기고와 저술, 방송 등을 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"언어력|","workFunc1":"수집","workFunc2":"교육","workFunc3":"관련없음","dJobECd":"2149","dJobECdNm":"[2149]기타 문리·기술 및 예능 강사","dJobJCd":"2549","dJobJCdNm":"[2549]기타 문리·기술 및 예능 강사","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002726:1', '{"dJobCd":"K000002726","dJobCdSeq":"1","dJobNm":"체험학습강사","workSum":"아동 및 청소년들에게 각종 캠프, 역사기행, 생태체험 등 다양하고도 전문적인 체험학습을 지도하고 인솔한다.","doWork":"사회단체, 청소년기관, 체험학습전문업체 및 협회 등에 소속되어 아동 및 청소년들을 대상으로 한 각종 현장체험학습 프로그램을 계획한다. 사전답사를 통하여 체험학습을 진행할 때 필요한 제반 사항을 체크하고 준비한다. 아동 및 청소년들의 체험학습에 필요한 다양한 정보를 수집한다. 현장체험학습 프로그램을 실제 운영한다. 현장체험학습 과정에서 학생들이 주도적으로 참여할 수 있도록 유도한다. 안전사고 예방에 필요한 지도 및 관리를 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","similarNm":"체험학습교사","dJobECd":"2149","dJobECdNm":"[2149]기타 문리·기술 및 예능 강사","dJobJCd":"2549","dJobJCdNm":"[2549]기타 문리·기술 및 예능 강사","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004141:1', '{"dJobCd":"K000004141","dJobCdSeq":"1","dJobNm":"특기적성교사","workSum":"학생들에게 특정의 특기적성 교육을 실시한다.","doWork":"학생들의 소질 및 적성을 개발할 수 있도록 취미 및 특기신장 교육을 한다. 특기적성 교육활동과 연계한 동아리를 구성하고, 각 동아리에 맞는 교육을 실시한다. 학생들의 특기 및 적성에 따라 바이올린, 플롯, 피아노 등의 음악교육, 태권도, 탁구 등의 체육교육, 프라모델, 댄스 등의 특기적성 교육 중 하나를 방과 후 시간 등 정규교육 시간 이외의 시간에 전문으로 실시한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"손사용|언어력|시각|","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","similarNm":"방과후교사","connectJob":"가르치는 과목에 따라 바이올린교사, 플롯교사, 첼로교사, 리코더교사, 성악교사, 트럼펫교사, 발레교사, 가야금교사, 대금교사, 중국어교사, 종이접기교사, 바둑교사, 미술교사, 태권도교사, 비즈공예교사, 탁구교사, 컴퓨터교사, 재즈댄스교사, 프라모델교사, 줄넘기교사, 과학공작교사, 영어보조교사, 컴퓨터보조교사, 과학보조교사","dJobECd":"2149","dJobECdNm":"[2149]기타 문리·기술 및 예능 강사","dJobJCd":"2549","dJobJCdNm":"[2549]기타 문리·기술 및 예능 강사","dJobICd":"P851","dJobICdNm":"[P851]초등 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001263:1', '{"dJobCd":"K000001263","dJobCdSeq":"1","dJobNm":"한국문화강사","workSum":"다문화센터나 한국문화센터 등에서 이주여성 및 다문화가정 어린이들, 또는 한국을 찾은 외국인들에게 한국문화를 소개하고 교육한다.","doWork":"이주여성 및 다문화가정 어린이들, 또는 한국을 찾은 외국인들을 대상으로 한국어, 한국요리, 전통예절 등 전문 분야별로 강의를 한다. 전문 분야에 따라서는 실제 체험활동을 준비하고 진행하기도 한다. 이주여성들을 대상으로는 한국정착과 자녀양육에 대한 상담을 하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"감독","workFunc3":"관련없음","dJobECd":"2149","dJobECdNm":"[2149]기타 문리·기술 및 예능 강사","dJobJCd":"2549","dJobJCdNm":"[2549]기타 문리·기술 및 예능 강사","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005446:1', '{"dJobCd":"K000005446","dJobCdSeq":"1","dJobNm":"환경교육강사","workSum":"환경오염 및 기후변화에 따른 변화와 일상생활에서의 실천 등을 이론과 사례, 체험 등을 통해 환경교육을 실시한다.","doWork":"환경과 기후변화에 대한 올바른 지식과 일상생활에서의 환경보호에 대한 가치관이 형성될 수 있도록 전문적인 교육을 실시한다. 학교와 기업 등에서 환경과 기후변화에 대한 올바른 환경적, 과학적 지식을 교육하기 위해 학습자의 연령대별 수준에 맞는 교육프로그램을 계획한다. 교육효과를 높이기 위한 다양한 교구를 준비하고 재활용, 쓰레기매립, 숲환경체험 등 다양한 체험활동을 위한 답사 등을 실시한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","certLic":"환경교육사","dJobECd":"2149","dJobECdNm":"[2149]기타 문리·기술 및 예능 강사","dJobJCd":"2549","dJobJCdNm":"[2549]기타 문리·기술 및 예능 강사","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007131:1', '{"dJobCd":"K000007131","dJobCdSeq":"1","dJobNm":"교구교재개발원","workSum":"교육 관련 출판사 및 제조회사 등에서 학생들의 학습에 유용한 교재나 교구(교육용 도구)를 개발한다.","doWork":"효과적인 교재를 만들기 위해 교육과정이나 교과서 개편, 학생 및 학부모의 의견을 조사한다. 효과적인 학습방법이나 교수법에 대해 조사·연구한다. 조사·연구를 통해 얻은 자료를 참고하여 교재의 콘셉트와 세부항목을 결정한다. 대상에 따라 직접 교재를 집필하거나 필자를 섭외한다. 회의를 통해 교재가 기획의도에 맞는지 검토하고 수정한다. 전체적인 레이아웃과 삽화, 사진에 대해 디자인 부서와 협의한다. 제작된 교재를 수정·보완한다. 교구인 경우 기획한 의도에 맞는 효과적인 교구가 나올 때까지 반복 실험한다. 최종결과물이 나오면 해당 교구에 알맞은 매뉴얼을 만든다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"협의","workFunc3":"관련없음","connectJob":"교구개발원, 교재개발원","dJobECd":"2151","dJobECdNm":"[2151]장학관·연구관 및 교육 전문가","dJobJCd":"2591","dJobJCdNm":"[2591]장학관·연구관 및 교육 관련 전문가","dJobICd":"J581","dJobICdNm":"[J581]서적, 잡지 및 기타 인쇄물 출판업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003132:1', '{"dJobCd":"K000003132","dJobCdSeq":"1","dJobNm":"교육연구관","workSum":"교육연구기관, 시청각교육원 등에서 학교교육의 문제점을 조사·연구하고, 교육연구사의 활동을 지도·감독한다.","doWork":"교육연구사의 교육연구 활동을 조직하고 운영·관리한다. 현장교육의 문제점을 조사·연구한다. 교육자료를 조사·수집하고 연구를 한다. 교육연구 등 기타 교육자료의 편찬활동에 종사한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"감독","workFunc3":"관련없음","dJobECd":"2151","dJobECdNm":"[2151]장학관·연구관 및 교육 전문가","dJobJCd":"2591","dJobJCdNm":"[2591]장학관·연구관 및 교육 관련 전문가","dJobICd":"O842","dJobICdNm":"[O842]사회 및 산업정책 행정","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001602:1', '{"dJobCd":"K000001602","dJobCdSeq":"1","dJobNm":"교육연구사","workSum":"학교교육의 이론과 실제를 조사·연구하고, 학습지도방법을 개발·보급한다.","doWork":"학교교육의 실천문제에 관하여 조사하고 새로운 교육사조 및 이론의 적용을 위한 현장연구를 수행한다. 교사의 개인연구 또는 연구지정학교의 협동적인 연구를 지원한다. 학습지도의 개선을 위하여 시청각교육을 포함한 학습지도방법을 개발한다. 교육도서 및 정보자료를 수집하여 분류·관리한다. 연구보고서, 통계자료 등 수집된 정보자료를 교사들이 활용할 수 있도록 관리한다. 각종 교원연수협의회, 연구발표회, 좌담회 등을 지원하거나 주관한다. 지방교육정책에 반영하기 위해 특정 교육문제를 연구하거나 통계자료를 작성하기도 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"2151","dJobECdNm":"[2151]장학관·연구관 및 교육 전문가","dJobJCd":"2591","dJobJCdNm":"[2591]장학관·연구관 및 교육 관련 전문가","dJobICd":"O842","dJobICdNm":"[O842]사회 및 산업정책 행정","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004793:1', '{"dJobCd":"K000004793","dJobCdSeq":"1","dJobNm":"교재연구원","workSum":"교과서 개발 및 정책에 대한 연구를 수행한다.","doWork":"각종 교과서 관련 연구의 기본계획을 수립한다. 대학교, 유관기관 등 관련 분야의 전문가로 구성된 외부연구용역 사업을 추진한다. 교과서 정책연구 분야의 경우, 국정교과서 및 민영교과서, 교과서 발행 제도에 대한 다양한 연구사업을 진행한다. 교과서 연구 분야의 경우, 각 과목별 교과서의 내용연구, 교과서의 활용도, 교과서 구성체계(대단원, 중단원, 소단원, 삽화, 예시 등 교과서 구성요소의 배치)에 대한 연구를 수행한다. 해외의 교과서 정책 및 교과서에 대한 비교연구를 수행한다. 교과서 수요조사, 교과서 감수의뢰, 교과서 가격 사정 업무를 수행한다. 교과서 연구 관련 세미나를 개최하고 각종 연구보고서를 발간한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"2151","dJobECdNm":"[2151]장학관·연구관 및 교육 전문가","dJobJCd":"2591","dJobJCdNm":"[2591]장학관·연구관 및 교육 관련 전문가","dJobICd":"M702","dJobICdNm":"[M702]인문 및 사회과학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004769:1', '{"dJobCd":"K000004769","dJobCdSeq":"1","dJobNm":"디지털교과서연구원","workSum":"디지털교과서(동영상, 애니메이션, 가상현실 등의 멀티미디어와 통합 제공하며, 다양한 상호작용 기능과 학습자의 특성과 능력 수준에 맞추어 학습할 수 있도록 구현된 학생용 교과서)를 개발한다.","doWork":"교육부, 스마트교육추진위원회, 교육청, 한국교육학술정보원 등에 소속되어 디지털교과서 개발을 위한 해외 정책동향 분석, 교육과정 기반의 교과내용에 대한 연구, 다양한 멀티미디어자료에 대한 연구, 평가문항 및 학습관리에 대한 연구, 학습내용에 대한 흥미 및 이해도에 대한 연구, 자기주도학습에 대한 연구, 교수학습 지원에 대한 연구, 시각장애인·지체부자유자 등 장애인 특성에 맞는 콘텐츠 및 학습모델 개발에 대한 연구, 디지털교과서 개발 및 적용을 위한 관련 법·제도 정비에 대한 연구 등을 수행한다. 디지털교과서를 활용한 스마트학습 모델을 개발하고, 시범사업(디지털교과서 연구학교)을 운용한다. 기존 e-교과서(PDF형식) 및 디지털교과서 시범사업을 분석한다. 디지털교과서 기술 연구진(디지털교과서 표준플랫폼 개발, 클라우드컴퓨팅시스템 개발, 스마트교육 학교인프라 구축, 교육용 정보화기기 개발 등의 연구를 수행)과 협의한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"e-교과서개발원","dJobECd":"2151","dJobECdNm":"[2151]장학관·연구관 및 교육 전문가","dJobJCd":"2591","dJobJCdNm":"[2591]장학관·연구관 및 교육 관련 전문가","dJobICd":"M702","dJobICdNm":"[M702]인문 및 사회과학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004567:1', '{"dJobCd":"K000004567","dJobCdSeq":"1","dJobNm":"원격교육연구원","workSum":"교수자와 학습자 간에 시간적·공간적 원격성을 전제로 인쇄물이나 방송·통신 및 인터넷 등과 같은 다양한 매체들을 매개로 하는 교육 방식을 연구한다.","doWork":"방송통신대학 또는 사이버대학에서 원격교육 매체의 특성에 관한 기초연구를 수행한다. 교과목 및 시범프로그램을 개발하고 운영한다. 각종 교육매체의 설계, 개발 및 활용에 관한 연구를 수행한다. 원격 교수학습방법에 관한 연구를 수행한다. 원격교육의 이념·제도에 관한 연구, 교육과정 및 교육품질 관리에 관한 연구를 수행한다. 평생교육과 원격교육에 관한 국내외 자료 및 문헌을 수집하고 관리한다. 학습자에 대한 지원방안 및 학습환경 개선에 관한 연구를 수행한다. 원격 강의 운영에 대한 평가를 실시하고 분석한다. 각종 조사통계 자료집을 발간한다. 원격교육 관련 학술지를 발간한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"협의","workFunc3":"관련없음","connectJob":"사이버대학교육연구원","dJobECd":"2151","dJobECdNm":"[2151]장학관·연구관 및 교육 전문가","dJobJCd":"2591","dJobJCdNm":"[2591]장학관·연구관 및 교육 관련 전문가","dJobICd":"M702","dJobICdNm":"[M702]인문 및 사회과학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005325:1', '{"dJobCd":"K000005325","dJobCdSeq":"1","dJobNm":"이러닝교수설계운영관리자","workSum":"이러닝(e-Learning:웹기반의 학습) 제작과정에서 교육과정을 기획하고 운영체제를 설계한다.","doWork":"이러닝의 교육과목이 선정되면 요구사항을 반영하여 교육대상, 교육방법, 효과적인 구성, 시간안배 등을 기획·설계한다. 기획안에 따라 사이버 환경에 맞게 학습내용을 가공한다. 교수설계 원리에 기초하여 내용전문가(SME:Subject Matter Expert)가 제시한 학습내용 및 학습자원 등의 학습전략과 학습방법을 수립한다. 그림, 동영상, 텍스트 등의 형태를 포함하여 전체 스토리보드를 작성한다. 디자이너, 시스템개발자, 온라인강사 등과 함께 콘텐츠를 개발한다. 개발에 참여하는 다양한 구성인력들 사이에서 중재 역할을 한다. 음성녹음, 동영상 촬영을 지시하고, 편집에 참여한다. 제작이 끝나면 검수하고 수요자의 평가를 점검한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"유러닝(U-Learning)교수설계자","certLic":"이러닝운영관리사","dJobECd":"2151","dJobECdNm":"[2151]장학관·연구관 및 교육 전문가","dJobJCd":"2591","dJobJCdNm":"[2591]장학관·연구관 및 교육 관련 전문가","dJobICd":"P85","dJobICdNm":"[P85]교육 서비스업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006088:1', '{"dJobCd":"K000006088","dJobCdSeq":"1","dJobNm":"입학사정관","workSum":"대학에서 입학사정관제도에 따라 신입생 선발 업무를 수행한다.","doWork":"해당 분야에 대한 전문성을 활용하여 대학입학 전형의 전부 또는 일부에 참여한다. 지원자의 학업성적뿐 아니라 개인 환경, 특기, 대인관계, 논리력, 창의력, 소질, 잠재력 등을 종합적으로 평가하여 선별한다. 학교생활기록부, 시험성적, 각종 서류를 검토한다. 필요시 면접을 진행하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","dJobECd":"2151","dJobECdNm":"[2151]장학관·연구관 및 교육 전문가","dJobJCd":"2591","dJobJCdNm":"[2591]장학관·연구관 및 교육 관련 전문가","dJobICd":"P853","dJobICdNm":"[P853]고등 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002253:1', '{"dJobCd":"K000002253","dJobCdSeq":"1","dJobNm":"장학관","workSum":"장학사의 장학활동을 관리·감독하며 각급 학교를 시찰하여 지도·조언한다.","doWork":"각급 학교(유치원, 초등학교, 중학교, 고등학교 등)의 교육활동을 지도·감독한다. 지방 교육시책을 기획·추진하고 교육공무원의 재교육 및 연수에 관한 계획을 수립한다. 교과용 도서의 편찬·발행·공급 등을 지도·감독한다. 각급 학교의 장학지도를 실시한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","certLic":"유치원정교사, 초등학교정교사, 중등학교정교사","dJobECd":"2151","dJobECdNm":"[2151]장학관·연구관 및 교육 전문가","dJobJCd":"2591","dJobJCdNm":"[2591]장학관·연구관 및 교육 관련 전문가","dJobICd":"O842","dJobICdNm":"[O842]사회 및 산업정책 행정","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006792:1', '{"dJobCd":"K000006792","dJobCdSeq":"1","dJobNm":"장학사","workSum":"각급 학교(유치원, 초등학교, 중학교, 고등학교 등)의 교육활동을 지도·관리한다.","doWork":"각급 학교의 학생교육이 바람직한 방향으로 실시될 수 있도록 교사들과 협의·연구·분석한다. 교수방법, 교재, 교구 등의 효과를 관찰하기 위하여 주기적으로 학교 및 학급을 방문·시찰한다. 교사의 교수방법을 평가하고 개선 및 향상을 위하여 제안·권고를 한다. 새로운 학급운영방법, 교재·교구 및 기타 보조물 등에 대한 교사들의 연구협의회를 주관한다. 신임 및 현직교원의 연수를 보조한다. 교과별, 초·중등 단계별, 교육과정, 생활지도, 교재교구 등의 교육지도 업무 중 어느 한 영역을 전담하기도 한다. 교사의 수업능력과 학습결과를 평가하고 이를 보고서로 작성하고, 각 시도 교육청 및 지역교육청에 보고한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"교육","workFunc3":"관련없음","connectJob":"중등장학사, 초등장학사","certLic":"유치원정교사, 초등학교정교사, 중등학교정교사","dJobECd":"2151","dJobECdNm":"[2151]장학관·연구관 및 교육 전문가","dJobJCd":"2591","dJobJCdNm":"[2591]장학관·연구관 및 교육 관련 전문가","dJobICd":"O842","dJobICdNm":"[O842]사회 및 산업정책 행정","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001844:1', '{"dJobCd":"K000001844","dJobCdSeq":"1","dJobNm":"창의코딩연구원","workSum":"중·고등학생의 창의력을 향상시키기 위해 코딩 관련 교육프로그램을 개발하거나 강사진을 육성한다.","doWork":"학생들의 재미와 흥미를 높이기 위한 교육프로그램을 개발한다. 스크래치, 아두이노 등 기존 프로그램을 기반으로 한 코딩교육 프로그램을 개발한다. 중고등학생의 창의력을 키울 수 있도록 주입식·암기식 교육이 아닌 교육프로그램을 개발한다. 개발 툴을 배우는 것이 아닌 알고리즘을 이해하고 창의력 있는 아이디어를 통해 알고리즘을 짤 수 있도록 커리큘럼을 기획한다. 창의코딩 교육을 위한 도구 및 강의교재를 개발한다. 코딩교육강사가 되기 위한 이들을 대상으로 강사 양성과정 커리큘럼을 통해 교육하고 육성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"제어조작","similarNm":"코딩교육프로그램개발자","dJobECd":"2151","dJobECdNm":"[2151]장학관·연구관 및 교육 전문가","dJobJCd":"2591","dJobJCdNm":"[2591]장학관·연구관 및 교육 관련 전문가","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;