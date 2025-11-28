INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003377:1', '{"dJobCd":"K000003377","dJobCdSeq":"1","dJobNm":"가죽재단사","workSum":"가죽을 펼쳐 재단할 부분을 표시하고 절단기구를 사용하여 패턴에 맞게 재단한다.","doWork":"재단할 제품별 패턴지를 수령한다. 재단에 필요한 쇠자 및 재단용 칼, 가위 등의 도구 또는 재단기 등의 장비를 준비한다. 재단대에 가죽을 펴놓고 패턴을 올려놓는다. 가죽 위에 재단할 모양의 윤곽선을 연필, 초크로 표시한다. 윤곽선을 따라 재단용 칼이나 가위로 자른다. 수량이 많은 경우에는 수동식 재단기를 사용하거나 철형으로 본을 떠 프레스기로 재단한다. 재단된 가죽을 형태별 색상별로 정리하여 꼬리표를 붙인다. 재단이 완료된 가죽을 가죽재봉공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8622","dJobECdNm":"[8622]재단사","dJobJCd":"7212","dJobJCdNm":"[7212]재단사","dJobICd":"C151","dJobICdNm":"[C151]가죽, 가방 및 유사제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001869:1', '{"dJobCd":"K000001869","dJobCdSeq":"1","dJobNm":"갑피재단사","workSum":"구두제조에 필요한 부분품을 제조하고자 유압프레스, 밴드나이프, 칼 등을 사용하여 재단한다.","doWork":"작업지시서를 읽고 가죽의 질, 색상 등을 확인하고 가죽을 선별한다. 가죽의 두께, 흠, 균열, 유연성, 광택, 이면탈색 등을 가죽부위별로 점검하고 재단 판 또는 프레스의 재단판에 가죽을 올려놓는다. 작업지시서에 지시된 디자인 및 가죽의 특성에 따라 패턴모형대로 칼 또는 밴드나이프로 재단한다. 프레스재단의 경우 철형을 선택하고 가죽의 특성에 따라 철형의 방향을 결정하여 재단 판에 있는 가죽 위에 올려놓는다. 스위치를 돌려 재단압력범위를 조정하고 철형의 폭에 맞추어 재단판까지의 폭을 조절하고자 폭 조정 스위치를 돌린다. 작업스위치를 눌러 프레스기를 상하 작동시켜 가죽을 절단한다. 재단된 가죽의 부품을 부품별, 사이즈별, 색상별, 가죽종류별로 구별하여 짝을 맞추기 위하여 부분품에 부분품 번호가 적힌 꼬리표를 부착한다. 재단하고 남은 가죽을 살펴보고 편피로 사용할 수 있도록 선별·보관한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"갑혁재단사","connectJob":"밴드나이프재단사, 프레스재단사","dJobECd":"8622","dJobECdNm":"[8622]재단사","dJobJCd":"7212","dJobJCdNm":"[7212]재단사","dJobICd":"C152","dJobICdNm":"[C152]신발 및 신발 부분품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002899:1', '{"dJobCd":"K000002899","dJobCdSeq":"1","dJobNm":"모피재단사","workSum":"판장이 끝난 모피를 재단용 칼로 규격에 맞게 자른다.","doWork":"선별과정을 거친 원피의 머리, 꼬리, 다리 등 불필요한 부분을 잘라낸다. 작업지시서에 따라 패턴에 맞는 기장대로 늘릴 수 있도록 형태에 따라 칼로 자른다. 자른 모양을 패턴에 맞게 이어붙일 수 있도록 장방형 조각으로 자른다. 잘린 모피의 모양이나 길이가 작업지시서와 일치하는지 확인한다. 모피의 안감을 재단하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"모피성형원","dJobECd":"8622","dJobECdNm":"[8622]재단사","dJobJCd":"7212","dJobJCdNm":"[7212]재단사","dJobICd":"C142","dJobICdNm":"[C142]모피제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001567:1', '{"dJobCd":"K000001567","dJobCdSeq":"1","dJobNm":"신발재단사","workSum":"제품규격서에 기준하여 원단과 가죽 등 겉감과 안감을 패턴 게이지에 맞추어 재단 발형으로 부품을 재단한다.","doWork":"제품규격서에 따라 신발자재의 특성과 요구 사항, 그리고 그 부자재의 특성을 판단한다. 제품규격서의 재단 배치도에 따라 그 자재 특성에 맞추어 가죽, 원단, 등 겉감과 안감을 각각 재단하기도 하다. 겉감과 안감의 합포된 자재를 그 신발의 특성에 따라 재단 발형으로 재단한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"중창가공원, 신발가죽분할원, 갑피가공원","dJobECd":"8622","dJobECdNm":"[8622]재단사","dJobJCd":"7212","dJobJCdNm":"[7212]재단사","dJobICd":"C152","dJobICdNm":"[C152]신발 및 신발 부분품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003611:1', '{"dJobCd":"K000003611","dJobCdSeq":"1","dJobNm":"재단검사원","workSum":"신발의 제조하기 위한 공정 중 필요한 신발가죽의 조각을 검사한다.","doWork":"재단물을 검사대 위에 올려놓는다. 흠, 규격미달, 색상차이, 방향이 틀린 것 등 불량부위를 은펜으로 표시한다. 검사한 재단물을 규격별, 부위별로 끈으로 묶어 정리한다. 작업일지에 기록하고 파지 및 잔사 등을 처리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"신발제조기능사","dJobECd":"8622","dJobECdNm":"[8622]재단사","dJobJCd":"7212","dJobJCdNm":"[7212]재단사","dJobICd":"C152","dJobICdNm":"[C152]신발 및 신발 부분품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002897:1', '{"dJobCd":"K000002897","dJobCdSeq":"1","dJobNm":"재단반장","workSum":"원단을 재단하는 일에 종사하는 작업원의 활동을 감독·조정한다.","doWork":"사용될 원단의 양과 절단모형(형판)을 결정한다. 패턴에 따른 표시선과 재단물의 절단선이 일치하는지 검사한다. 작업계획에 따라 세부실행항목을 수립하여 작업절차 및 방법을 결정한 후 작업원이 효율적으로 작업할 수 있도록 적당한 위치에 배정하고 작업내용을 작업원에게 지시한다. 작업진행상황을 파악하고 작업내용을 보고한다. 작업원의 작업상황을 관리·감독하고 작업공정에 있어 필요한 자재지원 및 기술을 지원한다. 표준명세에 따라 지시된 작업이 이루어지는지 작업원과 함께 작업하며 작업상황을 관찰하고 작업내용을 점검한다. 작업원에 대한 직무교육 및 안전위생교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시로 관찰과 면담을 통하여 작업원의 애로 및 건의사항을 수렴·해결하고 문제점을 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"수동조작","certLic":"양복기능사","dJobECd":"8622","dJobECdNm":"[8622]재단사","dJobJCd":"7212","dJobJCdNm":"[7212]재단사","dJobICd":"C141/C144","dJobICdNm":"[C141]봉제의복 제조업 / [C144]의복 액세서리 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002908:1', '{"dJobCd":"K000002908","dJobCdSeq":"1","dJobNm":"재단사(일반)","workSum":"의복류·모자류 등을 패턴모형에 맞춰 재단용 가위나 칼 또는 전기재단기로 재단한다.","doWork":"생산의뢰서 또는 작업지시서를 확인한 후 원단 및 부자재를 수령한다. 원단의 소모량을 최소화한 패턴모형을 패턴사에게 받는다. 작업대 위에 원단을 포개놓고 패턴모양대로 재단용 초크 또는 연필로 표시한다. 표시 선을 따라 가위나 칼로 재단하고 대량생산인 경우 전기재단기 또는 레이저로 절단하기도 한다. 색상에 따라 원단부품을 짝짓기도 한다. 부품 위에 확인번호를 표시하기도 한다. 재단대 위에 원단을 펼치는 연단원의 일을 하기도 한다. 재단이 완료된 각 원단 부분품은 재봉라인 등의 다음 공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"밴드나이프조작원","dJobECd":"8622","dJobECdNm":"[8622]재단사","dJobJCd":"7212","dJobJCdNm":"[7212]재단사","dJobICd":"C141/C144","dJobICdNm":"[C141]봉제의복 제조업 / [C144]의복 액세서리 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006991:1', '{"dJobCd":"K000006991","dJobCdSeq":"1","dJobNm":"침구재단사","workSum":"작업테이블에 직물류를 펼치고 핀 또는 분필로 재단선을 표시하고 침구류를 치수에 맞게 재단한다.","doWork":"치수가 표시된 작업테이블 위에 재단할 직물을 펼쳐 놓는다. 규정치수로 재단하기 위해 핀이나 분필로 표시한다. 표시된 부위를 따라 가위나 전동식 재단기로 재단한다. 재봉이 용이하도록 가장자리를 접기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8622","dJobECdNm":"[8622]재단사","dJobJCd":"7212","dJobJCdNm":"[7212]재단사","dJobICd":"C132","dJobICdNm":"[C132]직물직조 및 직물제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002011:1', '{"dJobCd":"K000002011","dJobCdSeq":"1","dJobNm":"가죽수재봉사","workSum":"가죽의류의 단추달기와 기타 부속품을 손으로 재봉한다.","doWork":"작업지시서를 확인하고 재봉이 완료된 가죽의류에 부속품을 달기 위한 구멍 자리를 표시한다. 송곳으로 구멍을 뚫는다. 끝이 뾰족한 도구로 실을 구멍에 밀어 넣는다. 바늘이나 갈고리 모양의 도구를 이용하여 뚫은 구멍을 통해서 실을 잡아당겨 실을 꿴다. 구멍에 꿰어진 실에 단추 또는 부속품을 달고 잡아당겨 매듭져 완성시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"가죽의류완성원","certLic":"양복기능사, 양장기능사","dJobECd":"8623","dJobECdNm":"[8623]재봉사","dJobJCd":"7213","dJobJCdNm":"[7213]재봉사","dJobICd":"C151","dJobICdNm":"[C151]가죽, 가방 및 유사제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005780:1', '{"dJobCd":"K000005780","dJobCdSeq":"1","dJobNm":"가죽제품재봉사","workSum":"가죽의류를 포함한 가죽제품의 각 부위들을 재봉하기 위해 재봉틀을 조작한다.","doWork":"각 부위의 재단물과 부속물을 준비한다. 선별된 원피를 형태에 따라 패턴에 맞는 기장을 뽑을 수 있게 칼로 자른다. 불필요한 부분을 칼을 사용하여 잘라낸다. 가죽의 색상에 따라 실의 종류, 실의 조임 상태를 결정한다. 재봉틀의 가동페달을 밟아 재단물과 부속물을 재봉질한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"가죽수재봉사","certLic":"양복기능사, 양장기능사","dJobECd":"8623","dJobECdNm":"[8623]재봉사","dJobJCd":"7213","dJobJCdNm":"[7213]재봉사","dJobICd":"C151","dJobICdNm":"[C151]가죽, 가방 및 유사제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005565:1', '{"dJobCd":"K000005565","dJobCdSeq":"1","dJobNm":"공봉합원","workSum":"실밥이 들어간 각종 공을 제조하기 위하여 일정한 크기로 재단된 여러 쪽의 가죽을 실로 봉합한다.","doWork":"일정한 크기로 재단된 가죽을 기계의 고정틀에 끼운다. 실에 밀(실이 잘 빠지도록 하는 윤활제)을 칠하여 자연 건조시킨다. 바늘에 실을 끼운 후 손으로 실을 잡아당기면서 꿰맨다. 공의 종류에 따라 봉합된 끝부분을 순간접착제로 붙인 후 마무리하기 위해 망치로 두드리기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"공재봉원","dJobECd":"8623","dJobECdNm":"[8623]재봉사","dJobJCd":"7213","dJobJCdNm":"[7213]재봉사","dJobICd":"C333","dJobICdNm":"[C333]운동 및 경기용구 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005882:1', '{"dJobCd":"K000005882","dJobCdSeq":"1","dJobNm":"기계자수원","workSum":"자수재봉틀을 사용하여 직물이나 옷감에 무늬 또는 문자를 수놓는다.","doWork":"도안에 표시된 색깔의 실패를 스핀들에 놓고 실 끝을 가이드, 인장장치, 바늘귀를 통하여 꿴다. 노루발을 들어 올려 직물재료를 밀어 넣는다. 직물을 팽팽히 한 후 페달을 밟아 기계를 작동하고 무늬의 모양에 따라 일정한 형태로 수를 놓는다. 다 쓴 북 실패를 교환하거나 부러진 바늘을 교환한다. 늘어진 실 끝을 자른다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"자수재봉원","connectJob":"자수직물보수원","dJobECd":"8623","dJobECdNm":"[8623]재봉사","dJobJCd":"7213","dJobJCdNm":"[7213]재봉사","dJobICd":"C132","dJobICdNm":"[C132]직물직조 및 직물제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005172:1', '{"dJobCd":"K000005172","dJobCdSeq":"1","dJobNm":"매트리스커버봉제원","workSum":"매트리스 커버의 사면을 봉제하고 매트리스의 상·하면 커버를 부착한다.","doWork":"봉제작업을 하기 전 각 미싱의 상태를 점검하고 커버 운반기에서 작업하고자 하는 커버를 미싱작업대로 운반, 이동시킨다. 미싱기 바늘의 올림·내림 운전대로 바늘이 커버를 누르도록 한 다음 커버의 사면을 봉제한다. 재봉실을 설치하고 작업하고자 하는 봉합테이프를 봉합기에 설치한다. 접착용기의 분사기를 사용하여 조립품의 전면 위에 접착제를 고르게 분사하고 하면용 커버를 부착한다. 한쪽 면의 커버 부착이 완료되면 뒤집고 상면용 커버를 부착한다. 부착 작업이 모두 완료되면 같은 규격의 옆단 커버를 씌운다. 커버 부착작업이 모두 완료되면 컨베이어에 올려 봉합공정실로 이송시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8623","dJobECdNm":"[8623]재봉사","dJobJCd":"7213","dJobJCdNm":"[7213]재봉사","dJobICd":"C320","dJobICdNm":"[C320]가구 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002505:1', '{"dJobCd":"K000002505","dJobCdSeq":"1","dJobNm":"모자재봉사","workSum":"모자를 제조하기 위해 재단된 부분품들을 디자인에 맞춰 재봉한다.","doWork":"작업지시서에 따라 부분 재단된 모자 부분품들을 확인한다. 재봉틀을 조작하여 모자의 앞, 옆, 뒷부분의 각 부분품을 중심부로 모아 재봉하고 내피, 모자챙 및 라벨을 재봉한다. 모자에 따라 펀치기계를 이용해 크기조절 구멍을 내고 구멍 주위를 재봉틀로 박거나 철 링을 박고 크기조절용 파스너나 벨크로(Velcro) 등 부속물을 부착한다. 모자의 정수리 부분과 가장자리 테두리에 심지를 둘러가며 박는다. 완성된 모자는 다림질 및 검사를 위한 다음 공정으로 보낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"양복기능사, 양장기능사","dJobECd":"8623","dJobECdNm":"[8623]재봉사","dJobJCd":"7213","dJobJCdNm":"[7213]재봉사","dJobICd":"C144","dJobICdNm":"[C144]의복 액세서리 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005407:1', '{"dJobCd":"K000005407","dJobCdSeq":"1","dJobNm":"모피재봉사","workSum":"재단이 끝난 부위별 반제품을 결합하여 재봉틀로 옷을 만든다.","doWork":"작업지시서와 패턴, 재단이 끝난 모피 반제품을 준비하고 재봉틀의 이상 유무를 확인한다. 실패걸이에 실을 끼우고 안내대, 신장장치 바늘귀 사이로 실을 잡아당겨 연결한다. 재봉틀의 실 꼬임 상태를 확인한다. 재단된 모피 반제품을 패턴의 크기만큼 길이를 늘이거나 폭을 넓혀 재봉한다. 패턴모양대로 재봉이 끝난 부분품을 각 부위별로 조립하여 재봉한다. 부러지거나 못 쓰는 바늘을 교체하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"모피미싱사","connectJob":"모피수재봉원","certLic":"양복기능사, 양장기능사","dJobECd":"8623","dJobECdNm":"[8623]재봉사","dJobJCd":"7213","dJobJCdNm":"[7213]재봉사","dJobICd":"C142","dJobICdNm":"[C142]모피제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005308:1', '{"dJobCd":"K000005308","dJobCdSeq":"1","dJobNm":"봉제반장","workSum":"의류 등을 봉제하는 데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"봉제 전반에 관한 지식 및 내용을 숙지하고 생산량에 맞춰 작업계획을 수립한다. 작업계획에 따라 작업공구 및 작업원을 선정·배치한다. 수행할 직무에 대하여 작업원을 교육시킨다. 봉제 부분품을 검사하여 발견된 불량품 및 시정해야 할 공정에 대해서는 수정하도록 지시한다. 작업원을 관리·감독하며 부서 간의 작업 흐름을 조정하기 위해 다른 반장들과 협의한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","certLic":"양복기능사, 양장기능사","dJobECd":"8623","dJobECdNm":"[8623]재봉사","dJobJCd":"7213","dJobJCdNm":"[7213]재봉사","dJobICd":"C141","dJobICdNm":"[C141]봉제의복 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006931:1', '{"dJobCd":"K000006931","dJobCdSeq":"1","dJobNm":"봉제완구재봉사","workSum":"봉제완구를 제조하고자 재봉틀을 사용해 완구의 각종 부품을 재봉한다.","doWork":"실패걸이에 실패를 끼운다. 안내대, 신장장치, 바늘귀 사이로 실을 잡아당긴다. 북 속에 실패를 넣고 북구멍 사이로 실을 잡아당긴다. 기계의 투입구에 재료를 놓는다. 페달을 누르거나 손잡이를 움직여 노루발을 올린다. 재봉하기 전에 봉제완구(여러 가지 동물이나 사람, 캐릭터 모양으로 천을 재봉하고 속에 솜이나 털실 조각 따위를 채워 넣어 입체감이 있도록 만든 장난감)의 귀, 머리, 몸통 부분을 조립하여 맞춘다. 각 부품을 조립하여 바느질하고 개개의 조립품을 결합하여 재봉한다. 바늘 밑으로 직물 끝을 맞추어 재료를 집어넣고 노루발을 내린다. 재료가 떨어지거나 실이 끊어지면 기계를 정지하고 실을 잇거나 재료를 공급한다. 재봉된 재료를 가위나 칼로 일정한 모양과 자른다. 파손된 바늘은 수동공구를 사용하여 교체한다. 기계에 기름을 치기도 하며 기계에 붙어있는 여분의 실을 칼이나 가위로 잘라내기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8623","dJobECdNm":"[8623]재봉사","dJobJCd":"7213","dJobJCdNm":"[7213]재봉사","dJobICd":"C334","dJobICdNm":"[C334]인형, 장난감 및 오락용품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001970:1', '{"dJobCd":"K000001970","dJobCdSeq":"1","dJobNm":"봉제완구제조원","workSum":"봉제완구를 재봉·충전·조형하고 몸체에 눈, 코, 입 등의 부착물을 결합한다.","doWork":"봉제완구 속에 넣은 스펀지, 솜, 털실 등의 내용물이 튀어나오지 않도록 송곳을 사용하여 골라주고 바늘을 꿰맨다. 머리털이나 털 부분을 빗으로 빗어 정리하고 먼지나 실밥을 제거한다. 봉제완구의 특정 부위에 원하는 색상을 내기 위해 분무기로 뿌린다. 왁스를 사용하여 눈, 코, 입 등에 광택을 낸다. 부착물이 이상이 없는지 작업표준과 비교하면서 육안으로 검사한다. 프레스기계에 부착물을 놓고 스위치를 가동하여 눈, 코, 입 등의 부착물을 고정한다. 송곳을 사용하여 튀어나온 부분을 밀어 넣어 마무리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"봉제완구완성원","dJobECd":"8623","dJobECdNm":"[8623]재봉사","dJobJCd":"7213","dJobJCdNm":"[7213]재봉사","dJobICd":"C334","dJobICdNm":"[C334]인형, 장난감 및 오락용품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004818:1', '{"dJobCd":"K000004818","dJobCdSeq":"1","dJobNm":"아일릿원","workSum":"부품을 부착하기 위해 제품에 구멍을 뚫고 아일릿(Eyelet) 재봉틀로 구멍 주위를 박는다.","doWork":"작업지시서를 보고 각종 부분품이 부착될 구멍의 위치 및 개수 등을 파악한다. 펀칭프레스에 재단물을 올려놓는다. 펀칭기를 작동하여 구멍을 뚫는다. 재단물의 구멍 주위를 아일릿(Eyelet) 재봉틀로 박아 올이 풀리지 않게 한다. 자동으로 여러 개의 금속 아일릿을 고착하는 기계를 조작하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"아일릿펀치원","dJobECd":"8623","dJobECdNm":"[8623]재봉사","dJobJCd":"7213","dJobJCdNm":"[7213]재봉사","dJobICd":"C141","dJobICdNm":"[C141]봉제의복 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005237:1', '{"dJobCd":"K000005237","dJobCdSeq":"1","dJobNm":"양말재봉사","workSum":"편직된 양말의 발가락 부분이나 벌어진 입구를 닫기 위해 재봉기를 조작한다.","doWork":"작업지시서를 확인하여 양말의 전체 디자인 및 모양을 확인한다. 재봉틀의 작동 이상 유무를 확인한다. 원통형으로 편직된 양말을 수령한다. 양말의 발가락 부분을 재봉기의 노루발 밑에 오게 한다. 기계를 작동하여 양말의 발가락 부분을 재봉한다. 재봉상태를 점검한다. 양말의 발가락 부분을 닫는 재봉기의 바늘 밑으로 자동으로 재료를 이송하는 기계장치를 조작하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"양말마무리원","certLic":"양복기능사, 양장기능사","dJobECd":"8623","dJobECdNm":"[8623]재봉사","dJobJCd":"7213","dJobJCdNm":"[7213]재봉사","dJobICd":"C144","dJobICdNm":"[C144]의복 액세서리 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004682:1', '{"dJobCd":"K000004682","dJobCdSeq":"1","dJobNm":"오버로크재봉사","workSum":"의복에 의류부분품, 끈, 장식 등을 붙이거나 올이 풀어지는 것을 방지하기 위해 오버로크재봉틀을 조작한다.","doWork":"오버로크재봉틀의 이상 유무를 파악하고 작업지시서에 표시된 내용에 의해 의류의 각 부위에 휘갑치기(오버로크) 재봉을 한다. 소매단, 스커트단 등 의류 끝부분을 마무리한다. 재봉틀을 사용하여 허리선 및 각 부위의 봉제 솔기와 주름 접힌 부위를 마무리한다. 의류부분품, 끈, 장식 등을 접합하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"휘갑치기재봉사","certLic":"양복기능사, 양장기능사","dJobECd":"8623","dJobECdNm":"[8623]재봉사","dJobJCd":"7213","dJobJCdNm":"[7213]재봉사","dJobICd":"C141/C144","dJobICdNm":"[C141]봉제의복 제조업 / [C144]의복 액세서리 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002022:1', '{"dJobCd":"K000002022","dJobCdSeq":"1","dJobNm":"자수연폭원","workSum":"자수기계의 바탕천을 준비하기 위해 재단된 원단을 일정한 간격으로 잇는다.","doWork":"자수용 원단을 기계의 용량에 맞도록 일정 재단한다. 원단의 전·후면을 확인하고 재봉기를 사용하여 한 절씩 잇는다. 작업이 완료된 후 제품의 외관상 결함을 검사하고 작업일지에 기록한다. 작업장 주위를 청결히 정리하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8623","dJobECdNm":"[8623]재봉사","dJobJCd":"7213","dJobJCdNm":"[7213]재봉사","dJobICd":"C132","dJobICdNm":"[C132]직물직조 및 직물제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006681:1', '{"dJobCd":"K000006681","dJobCdSeq":"1","dJobNm":"자수제직준비원","workSum":"자수를 놓기 위하여 기계에 바늘, 실패를 설치·조정하고 제품을 틀에 끼운다.","doWork":"자수할 제품의 도안을 확인하고 자수모양이나 색상에 따라 실패를 교환한다. 북 실패를 북 집에 집어넣고 바늘귀에 실을 꿴다. 원단을 자수기계의 걸쇠에 걸고 팽팽하게 잡아당겨 핀으로 고정한다. 양말, 장갑 등의 제품은 작업대의 틀에 끼우고 자수부위를 바늘 아래로 맞춘다. 낡거나 파손된 바늘을 교환한다. 바늘과 수놓은 제품 사이의 실을 절단한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"시범후 30일 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","connectJob":"바늘교환원, 봉사교환원, 북실교환원, 상단원","dJobECd":"8623","dJobECdNm":"[8623]재봉사","dJobJCd":"7213","dJobJCdNm":"[7213]재봉사","dJobICd":"C132","dJobICdNm":"[C132]직물직조 및 직물제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003485:1', '{"dJobCd":"K000003485","dJobCdSeq":"1","dJobNm":"장갑재봉사","workSum":"편조작업이 완료된 장갑의 손목부분을 마무리하고 상표를 부착한다.","doWork":"장갑 제품에 따라 장갑을 작업대에 올려놓고 재봉기의 노루발을 올려 고무줄과 같이 재봉한다. 장갑 손목부분을 오버로크 기계로 재봉하여 마무리하기도 한다. 재봉이 끝나기 전에 상표를 삽입한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"장갑마무리원","connectJob":"양말재봉사","dJobECd":"8623","dJobECdNm":"[8623]재봉사","dJobJCd":"7213","dJobJCdNm":"[7213]재봉사","dJobICd":"C144","dJobICdNm":"[C144]의복 액세서리 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002385:1', '{"dJobCd":"K000002385","dJobCdSeq":"1","dJobNm":"장갑제조반장","workSum":"장갑을 재봉, 세공, 압착하는 데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"불규칙한 바느질 및 염색, 얼룩 등의 결함을 점검한다. 작업계획에 따라 세부실행항목을 수립하여 작업절차 및 방법을 결정한 후 작업원이 효율적으로 작업할 수 있도록 적당한 위치에 배정하고 작업내용을 작업원에게 지시한다. 작업진행상황을 파악하고 작업내용을 보고한다. 작업공정에 있어 필요한 자재지원 및 기술을 지원한다. 표준명세에 따라 지시된 작업이 이루어지는지 작업원과 함께 작업하며 작업상황을 관찰하고 작업내용을 점검한다. 작업원에 대한 직무교육 및 안전위생교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시로 관찰과 면담을 통하여 작업원의 애로 및 건의사항을 수렴·해결하고 문제점을 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","dJobECd":"8623","dJobECdNm":"[8623]재봉사","dJobJCd":"7213","dJobJCdNm":"[7213]재봉사","dJobICd":"C144","dJobICdNm":"[C144]의복 액세서리 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004789:1', '{"dJobCd":"K000004789","dJobCdSeq":"1","dJobNm":"재봉반장","workSum":"기계의 기능 및 공정에 대한 지식을 이용하여 기계 및 재봉틀을 조작하는 방법을 작업원에게 교육한다.","doWork":"재봉틀 전반에 관한 지식과 내용을 숙지하고 생산량 및 시간계획 등을 수립하여 작업계획을 세운다. 작업계획에 따라 세부실행항목을 수립하여 작업절차 및 방법을 결정한 후 작업원이 효율적으로 작업할 수 있도록 적당한 위치에 배정하고 작업내용을 작업원에게 지시한다. 작업진행상황을 파악하고 작업내용을 보고한다. 작업원의 작업상황을 관리·감독하고 작업공정에 있어 필요한 자재지원 및 기술을 지원한다. 결함이 발생하면 원인을 찾아 해결방법을 지도한다. 작업원의 생산량을 기록한다. 직무전환의 필요에 따라 작업원을 재배치시킨다. 작업원과 작업을 병행하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","similarNm":"미싱기사, 미싱반장","certLic":"양복기능사, 양장기능사","dJobECd":"8623","dJobECdNm":"[8623]재봉사","dJobJCd":"7213","dJobJCdNm":"[7213]재봉사","dJobICd":"C141/C144","dJobICdNm":"[C141]봉제의복 제조업 / [C144]의복 액세서리 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002628:1', '{"dJobCd":"K000002628","dJobCdSeq":"1","dJobNm":"재봉사(일반)","workSum":"의복 및 각종 부속품을 조립하고 부착하고자 재봉틀을 조작한다.","doWork":"실패걸이에 실패를 끼운다. 안내대, 신장장치, 바늘귀 사이로 실을 잡아당긴다. 북 속에 실패를 넣고 북구멍 사이로 실을 잡아당긴다. 기계의 투입구에 재료를 놓는다. 페달을 누르거나 손잡이를 움직여 노루발을 올린다. 바늘 밑으로 직물 끝을 맞추어 재료를 집어넣고 노루발을 내린다. 재료가 떨어지거나 실이 끊어지면 기계를 정지하고 실을 잇거나 재료를 공급한다. 재봉된 재료를 가위나 칼로 일정한 모양과 자른다. 파손된 바늘은 수동공구를 사용하여 교체한다. 기계에 기름을 치기도 하며 기계에 붙어 있는 여분의 실을 칼이나 가위로 잘라내기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"미싱공, 미싱사","certLic":"양복기능사, 양장기능사","dJobECd":"8623","dJobECdNm":"[8623]재봉사","dJobJCd":"7213","dJobJCdNm":"[7213]재봉사","dJobICd":"C141/C144","dJobICdNm":"[C141]봉제의복 제조업 / [C144]의복 액세서리 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002876:1', '{"dJobCd":"K000002876","dJobCdSeq":"1","dJobNm":"직물제품검사원","workSum":"침구류나 가정용품 등 직물제품의 얼룩, 파손 등의 결함이나 규격을 검사한다.","doWork":"작업대 위에 제품을 펼쳐 놓고 바느질 상태, 헐거운 실, 변색, 자투리 등 결함을 찾기 위해 검사한다. 줄자를 사용하여 제품의 치수를 측정하고 제품 표준과 비교한다. 가위로 늘어진 실을 절단하고 분필이나 스티커 등을 사용하여 결함부위를 표시한다. 제품규격에 따라 접어 포장하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8623","dJobECdNm":"[8623]재봉사","dJobJCd":"7213","dJobJCdNm":"[7213]재봉사","dJobICd":"C132","dJobICdNm":"[C132]직물직조 및 직물제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003832:1', '{"dJobCd":"K000003832","dJobCdSeq":"1","dJobNm":"침구재봉사","workSum":"침대커버, 베개, 방석, 이불 등 침구제품을 봉제하고, 레이스 등의 장식품을 달기 위해 재봉질을 한다.","doWork":"침구제품의 겉감을 봉제한다. 작업지시서 혹은 주문자의 요구에 부합하게 제품의 가장자리나 특정한 부위에 레이스나 상표 또는 끈 등을 봉제한다. 봉제가 완료된 후 작업일지나 주문서에 작업의 내용을 기록하여 다음 부서로 이송하거나 주문자에게 알린다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"침구봉제원, 침구봉제사","certLic":"봉제기능사","dJobECd":"8623","dJobECdNm":"[8623]재봉사","dJobJCd":"7213","dJobJCdNm":"[7213]재봉사","dJobICd":"C132","dJobICdNm":"[C132]직물직조 및 직물제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003206:1', '{"dJobCd":"K000003206","dJobCdSeq":"1","dJobNm":"카펫재봉사","workSum":"카펫의 테두리가 엉클어지는 것을 방지하기 위해 세폭직물(레이스)을 접합하거나 가장자리를 오버로크(Overlock)하는 재봉기를 조작한다.","doWork":"카펫 가장자리가 엉클어지는 것을 방지하기 위해 가장자리에 빠져나온 실들을 중간중간 묶는다. 카펫 길이에 맞게 레이스를 두르고 재봉기를 조작하여 재봉한다. 카펫 가장자리가 풀리지 않도록 레이스를 대지 않고 가장자리를 재봉하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"카펫오버로크원","certLic":"봉제기능사","dJobECd":"8623","dJobECdNm":"[8623]재봉사","dJobJCd":"7213","dJobJCdNm":"[7213]재봉사","dJobICd":"C139","dJobICdNm":"[C139]기타 섬유제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005872:1', '{"dJobCd":"K000005872","dJobCdSeq":"1","dJobNm":"갑피재봉사","workSum":"제품규격서에 따라 재단·가공된 갑피용 겉감과 안감을 재봉기로 연결·봉합하여 갑피를 완성한다.","doWork":"제화용 실이 감긴 실패를 꽂고 실을 안내대를 통해 바늘귀에 끼운다. 북에 실을 감아 밑실을 장치하여 상하 각 실의 장력을 조절한다. 발등덮개(Vamp)를 옆날개(Quarter)에 붙이고 고르게 재봉한다. 뒤축덮개 뒤쪽을 재봉하여 망치로 갈라놓고 천을 풀로 붙인 뒤 재단된 가죽을 맞대어 꿰맨다. 안감을 뒷날개와 같이 붙이고 접힌 곳을 재봉기로 꿰맨다. 끈 꿰는 부분을 재봉할 때는 앞덮개 가죽을 물려 꿰매고 덧가죽과 앞날개를 꿰맨 것을 치수에 맞추어 붙인 다음 앞날개의 접은 부분을 재봉기로 꿰맨다. 빈 실패나 부러진 바늘을 갈아 끼운다. 일정 단위로 짝을 맞추어 정리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"갑피봉제원, 갑혁봉제원, 갑혁재봉사","connectJob":"갑피장식원, 갑피펀칭원, 갑피표시원","dJobECd":"8641","dJobECdNm":"[8641]제화원","dJobJCd":"7214","dJobJCdNm":"[7214]제화원","dJobICd":"C152","dJobICdNm":"[C152]신발 및 신발 부분품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006339:1', '{"dJobCd":"K000006339","dJobCdSeq":"1","dJobNm":"구두제화원","workSum":"고객의 요구에 따라 치수를 재고 가죽을 재단하여 구두를 만든다.","doWork":"고객과 디자인 등에 대하여 상담한다. 발 치수를 재고 치수별, 디자인별로 구두골을 선택한다. 가죽 위에 본을 놓고 연필로 그린다. 갑피의 겉감, 안감, 창감을 기계나 손칼, 가위 등으로 재단한다. 겉감과 안감의 꿰맬 부위를 칼로 얇게 깎아 접고 가죽재봉틀로 꿰맨다. 골과 중창을 붙이기 위해 못을 박는다. 갑피를 구두골에 씌우고 갑피집게로 못을 박거나 철사로 얽어 고정한다. 갑피와 창을 기계 또는 손으로 꿰맨다. 굽을 달고 굽창에 못을 박는다. 사포로 문지르고 인두로 윤을 낸다. 구두에서 구두골을 뺀 다음 망치로 다듬질한다. 필요한 곳에 잉크, 왁스, 물감 등을 바르고 구두약을 발라 광택을 낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"수제화제작원","certLic":"신발제조기능사","dJobECd":"8641","dJobECdNm":"[8641]제화원","dJobJCd":"7214","dJobJCdNm":"[7214]제화원","dJobICd":"C152","dJobICdNm":"[C152]신발 및 신발 부분품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003280:1', '{"dJobCd":"K000003280","dJobCdSeq":"1","dJobNm":"등산화수선원","workSum":"고객의 의뢰에 따라 각종 등산화를 수선한다.","doWork":"수선할 등산화의 종류와 상태, 수선의뢰 내역을 확인한다. 등산화의 종류와 제조사 및 제품별로 다양한 수선용 소재를 준비한다. 칼, 가위, 집게, 망치, 사포, 연마기, 가열기 등을 사용하여 손상된 부분을 제거하고 새로운 소재를 부착하여 등산화 고유의 상태로 복원한다. 수선 부위 및 방법에 따라 창갈이, 접착수선, 제봉수선, 벨크로교체, 웨빙교체, 가죽덧댐, 패드수선, 연화작업, 고리수선, 랜드교체, 토캡교체, 중창추가, 선심복원(앞꿈치), 월형복원(뒤꿈치) 등 다양한 수선작업을 한다. 암벽화, 빙벽화 등 특수화를 전문으로 수선하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"암벽화수선원, 특수화수선원","dJobECd":"8641","dJobECdNm":"[8641]제화원","dJobJCd":"7214","dJobJCdNm":"[7214]제화원","dJobICd":"C152","dJobICdNm":"[C152]신발 및 신발 부분품 제조업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005380:1', '{"dJobCd":"K000005380","dJobCdSeq":"1","dJobNm":"신발제화원","workSum":"갑피와 창을 조립하여 완성 신발을 만든다.","doWork":"제화 작업규격서의 분석을 통해 작업규격서에서 요구하는 갑피와 창 조립공정을 이해하고, 사용할 수 있는 용제와 접착제의 종류와 사용법을 분별하여 제화공정을 수행한다. 제품 완성을 위한 제화물 준비로 갑피와 라스트(신골)을 준비하고, 정확한 게이지작업을 한다. 다양한 제화기계를 조작하여 갑피와 창을 조립하여 완성신발을 생산한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"신발조립원","connectJob":"구두제화원, 갑피측면성형원, 겉창부착원, 중착부착원, 외저부착원, 외피부착원, 겉장압착원, 힐라스팅원, 뒤축보강부착원, 기모원, 뒤축성형원, 앞골성형원, 앞골수정원, 신발테이프접착원, 선심부착원, 사상압축원, 신발마무리원, 디핑작업원, 신발부분품다림질원, 신발분류원","certLic":"신발제조기능사","dJobECd":"8641","dJobECdNm":"[8641]제화원","dJobJCd":"7214","dJobJCdNm":"[7214]제화원","dJobICd":"C152","dJobICdNm":"[C152]신발 및 신발 부분품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004451:1', '{"dJobCd":"K000004451","dJobCdSeq":"1","dJobNm":"암벽화수선원","workSum":"고객의 의뢰에 따라 암벽화(Climbing Boots:암벽등반 전용의 등산화)를 수선한다.","doWork":"고객으로부터 수선의뢰를 받고 암벽화의 상태를 확인한다. 다목적용, 일반용, 스포츠클라이밍용, 에징용, 프릭션용, 크랙등반용 등 암벽화의 종류와 제조사 및 제품별로 다양한 수선용 소재를 준비한다. 밑창의 마모 정도, 손상부분을 확인하고 수선방법을 결정한다. 수선틀에 암벽화를 고정하고 수선 중에 족형이 변형되지 않도록 한다. 칼, 가위, 집게, 망치, 사포, 연마기 등을 사용하여 손상된 부분을 제거한다. 접착제를 사용하여 새로운 밑창을 부착하고 제품 고유의 상태로 복원한다. 수선 부위에 따라 접착제로 고정하거나 액세서리를 교체하거나 가죽이나 천을 덧대어 실로 꿰매기도 한다. 고객의 요구에 따라 변형된 족형을 복원하기도 하고 길이, 폭 등을 조절하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"8641","dJobECdNm":"[8641]제화원","dJobJCd":"7214","dJobJCdNm":"[7214]제화원","dJobICd":"C152","dJobICdNm":"[C152]신발 및 신발 부분품 제조업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001674:1', '{"dJobCd":"K000001674","dJobCdSeq":"1","dJobNm":"가발미용원","workSum":"가발을 제조하고자 엮어진 모발을 말고 풀어서 가발 스타일을 만든다.","doWork":"엮어진 모발을 작업대에 놓는다. 분사기계를 사용하여 모발에 분무한다. 분무가 끝난 모발을 빗으로 빗질하고 일정 규격의 롤러파이프에 말아 준다(말기 작업:Rolling). 모발이 감겨진 롤러파이프 위에 종이를 감고 풀리지 않도록 양끝에 고무줄을 끼운다. 롤러파이프들을 적재기(Loading Car)에 순서대로 쌓은 후 건조기(Dry Box)에 투입한다. 재료의 종류, 색상에 따라 건조기의 온도와 시간 스위치를 조정하고 기계 작동 스위치를 조작한다. 일정한 시간 동안 열처리가 끝나면 적재기를 건조기에서 끌어내려 외부온도 이하로 롤러의 열기를 식힌다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"가발세팅원, 컬작업원","dJobECd":"8629","dJobECdNm":"[8629]기타 섬유·가죽 기능원","dJobJCd":"7219","dJobJCdNm":"[7219]기타 섬유 및 가죽 관련 기능 종사원","dJobICd":"C339","dJobICdNm":"[C339]그 외 기타 제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007143:1', '{"dJobCd":"K000007143","dJobCdSeq":"1","dJobNm":"가발혼모원","workSum":"가발을 제조하고자 원사별, 색상별 혼모작업을 한다.","doWork":"제조하고자 하는 가발의 모양과 색상 등에 따라 두 종류 이상의 원모(머리카락)를 선택한다. 선택한 원모의 무게를 저울로 잰다. 선택한 원모를 제품 표준에 맞게 혼합한 후 빗질을 한다. 긴 모장은 원모의 뻣뻣한 상태를 부드럽게 하기 위해 하클(Huckle)기에다 여러 번 홀태질하는 하클작업을 한다. 빗질과 하클이 끝난 혼모를 모양과 색상별로 정리하여 바구니에 담는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"가발정모원, 정모사","dJobECd":"8629","dJobECdNm":"[8629]기타 섬유·가죽 기능원","dJobJCd":"7219","dJobJCdNm":"[7219]기타 섬유 및 가죽 관련 기능 종사원","dJobICd":"C339","dJobICdNm":"[C339]그 외 기타 제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001412:1', '{"dJobCd":"K000001412","dJobCdSeq":"1","dJobNm":"뜨개질원","workSum":"편물의류의 치수에 따라 실과 뜨개바늘을 사용하여 뜨개질한다.","doWork":"뜨개질할 제품에 따라 바늘의 크기, 실의 종류, 색깔 등을 선택한다. 코바늘, 둥근바늘, 쌍대바늘, 아프간바늘, 네대바늘 등을 사용하여 손으로 스웨터, 레이스 등의 의류나 장식품을 뜨개질한다. 짠 물품의 끝부분의 실을 감거나 다른 부분과 이어서 마무리한다. 잘못 짜여진 부분의 실을 풀고 다시 짠다. 제품의 형태별로 구분하거나 수량을 세기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8629","dJobECdNm":"[8629]기타 섬유·가죽 기능원","dJobJCd":"7219","dJobJCdNm":"[7219]기타 섬유 및 가죽 관련 기능 종사원","dJobICd":"C143/C144","dJobICdNm":"[C143]편조의복 제조업 / [C144]의복 액세서리 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007217:1', '{"dJobCd":"K000007217","dJobCdSeq":"1","dJobNm":"모자제조원","workSum":"신사모, 숙녀모, 유아모, 운동모, 등산모, 군경모, 수위모 등 각종 모자를 만든다.","doWork":"작업지시서에 따라 모자제조에 필요한 패턴용지, 가위, 칼, 전동식 재단기 등을 준비한다. 필요에 따라 프레스 재단에 필요한 프레스, 철형 등을 준비하여 이상 유무를 확인한다. 모자의 디자인, 크기, 용도 등에 따라 패턴 용지 위에 연필로 본을 제도하거나 원단 위에 모자의 패턴모형을 놓고 재단용 칼 또는 전동식 재단기를 사용하여 원단을 재단한다. 수량이 많은 경우 철형으로 제작된 패턴모형을 원단 위에 놓고 프레스로 찍어 한 번에 재단하기도 한다. 성형, 모체정리, 다림질 등의 작업을 수행한다. 생산 의뢰에 따라 부속품 등을 달기도 한다. 실밥 정리 등의 마무리 작업을 하고 불량품을 검사한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"모자완성원, 모자재단원, 모자패턴원","certLic":"양복기능사, 양장기능사","dJobECd":"8629","dJobECdNm":"[8629]기타 섬유·가죽 기능원","dJobJCd":"7219","dJobJCdNm":"[7219]기타 섬유 및 가죽 관련 기능 종사원","dJobICd":"C144","dJobICdNm":"[C144]의복 액세서리 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003860:1', '{"dJobCd":"K000003860","dJobCdSeq":"1","dJobNm":"바닥천부착원","workSum":"기어펌프, 분무기, 솔, 바가지 등을 사용하여 섬유사가 천에서 빠지지 않게 양탄자의 뒷면에 라텍스를 바르고 바닥천(Jute)을 부착하여 섬유사를 고정한다.","doWork":"양탄자의 밑면을 위쪽으로 하여 작업대에 올려놓고고정 못을 사용하여 가장자리를 고정한다. 기어펌프, 분무기, 솔, 바가지 등을 사용하여 안감에 라텍스를 분무하거나 칠하고 바르게 편다. 그 위에 천을 덮고 밑면과 후포가 접착되도록 밀대로 밀고 천 가장자리를 가위로 자른다. 양탄자를 건조하기 위해 트랙설비가 된 건조기의 속도와 온도를 조절하는 손잡이나 레버를 조작한다. 다음 공정을 위해 양탄자를 틀에서 떼어 바닥에 놓는다. 양탄자와 바닥천을접착제를 사용하지 않고 열로 접착하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|고온|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"라미네이팅작업원, 마대부착원, 아마포부착원, 주트부착원, 후포부착원","dJobECd":"8629","dJobECdNm":"[8629]기타 섬유·가죽 기능원","dJobJCd":"7219","dJobJCdNm":"[7219]기타 섬유 및 가죽 관련 기능 종사원","dJobICd":"C139","dJobICdNm":"[C139]기타 섬유제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002551:1', '{"dJobCd":"K000002551","dJobCdSeq":"1","dJobNm":"소품용가발제작원","workSum":"대본을 검토해 드라마의 특성, 등장인물의 성격과 분위기에 맞는 가발을 제작한다.","doWork":"등장인물(Character)이 선정된 후 등장인물의 직접적인 머리손질이 곤란한 경우 방송연출가, 배우 등과 협의하여 모발의 스타일을 결정한다. 사극, 현대극 등 드라마의 성격에 알맞게 가발을 제작한다. 제작된 가발이 등장인물과 어울리는지 컴퓨터를 통해 시뮬레이션한다. 수제바늘로 인모(人毛), 인조모(人造毛)를 캡에 하나하나 심으며, 머리 전체 또는 일부분을 캡으로 씌운다. 가발의 커트, 파마 등을 한다. 생사(生絲)를 염색하고 손질하여 수염을 제작한다. 가발이 완성된 후 방송연출가, 분장사와 협의하여 가발을 수정·보완한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"웅크림|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"수제가발제작원","connectJob":"가발완성원","dJobECd":"8629","dJobECdNm":"[8629]기타 섬유·가죽 기능원","dJobJCd":"7219","dJobJCdNm":"[7219]기타 섬유 및 가죽 관련 기능 종사원","dJobICd":"C339","dJobICdNm":"[C339]그 외 기타 제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004117:1', '{"dJobCd":"K000004117","dJobCdSeq":"1","dJobNm":"손자수원","workSum":"직물재료 위에 도안하거나 도안 위에 손으로 자수한다.","doWork":"직물이 팽팽해지도록 직물 위를 자수띠로 조른다. 도안대로 규정된 실의 색깔과 종류에 따라 바늘로 꿰어간다. 직물이 팽팽하게 유지되도록 틀에 직물을 걸기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"손장식원, 수자수원","dJobECd":"8629","dJobECdNm":"[8629]기타 섬유·가죽 기능원","dJobJCd":"7219","dJobJCdNm":"[7219]기타 섬유 및 가죽 관련 기능 종사원","dJobICd":"C132","dJobICdNm":"[C132]직물직조 및 직물제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006751:1', '{"dJobCd":"K000006751","dJobCdSeq":"1","dJobNm":"수단제조원","workSum":"수동식 베틀을 사용하여 직물에 무늬를 넣기 위해 가직물을 제조하거나 무늬가 있는 견직물을 제조한다.","doWork":"도안을 숙지하고 도안에 따른 자재를 준비한다. 실이 감긴 빔을 직기 뒤쪽에 설치한다. 빔으로부터 실 끝을 찾아 순서에 따라 종광에 끼운다. 종광에서 뽑아낸 실을 도안의 무늬에 따라 바디에 끼우고 권취빔에 일정 횟수 감은 다음 묶는다. 북에 북실을 끼우고 도안에 따라 페달을 밟아 종광을 움직이면서 면사나 호부된 생사를 끼운 바디에 투입된 위사를 손으로 친다. 무늬를 넣기 위해 무늬모형 판을 짜이는 직물 위에 놓고 경사에 위사를 투입할 위치를 찾는다. 대빗을 사용하여 직물이 탄탄히 짜이도록 위사를 민다. 무늬를 바꾸기 위해 바디 앞쪽에서 경사를 끊고 실을 연결한 다음 바디에 끼우기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"가직물직조원","dJobECd":"8629","dJobECdNm":"[8629]기타 섬유·가죽 기능원","dJobJCd":"7219","dJobJCdNm":"[7219]기타 섬유 및 가죽 관련 기능 종사원","dJobICd":"C132","dJobICdNm":"[C132]직물직조 및 직물제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002898:1', '{"dJobCd":"K000002898","dJobCdSeq":"1","dJobNm":"수동스크린날염원","workSum":"스크린, 고무롤러를 사용하여 직물, 시트 등에 도안을 날염한다.","doWork":"견본도안을 확인하고 도안 모양의 스크린을 준비한다. 모형복사를 하고자 일정한 간격을 두고 날염작업대의 가장자리를 따라 안내대를 조정한다. 직물 위의 안내대 쪽에 스크린을 맞추어 놓고 스크린에 해당 색상페이스트(색풀)를 붓는다. 고무롤러를 당겨 스크린의 개방부분에 색상페이스트가 스치며 내려가게 하여 도안을 인쇄한다. 작업이 완료되면 물과 용제로 스크린을 닦아 색상페이스트를 제거한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"염색기능사(날염)","dJobECd":"8629","dJobECdNm":"[8629]기타 섬유·가죽 기능원","dJobJCd":"7219","dJobJCdNm":"[7219]기타 섬유 및 가죽 관련 기능 종사원","dJobICd":"C134","dJobICdNm":"[C134]섬유제품 염색, 정리 및 마무리 가공업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002181:1', '{"dJobCd":"K000002181","dJobCdSeq":"1","dJobNm":"수편물원","workSum":"수동식 편물기계를 사용하여 의복의 부분품, 장갑 등을 짜는 기계를 조작한다.","doWork":"제품도면이나 견본을 확인하고 실패를 실걸이에 끼우고 실 끝을 찾아 유도장치를 통해 급사구에 투입한다. 모형에 의해 일련의 작업을 하는 바늘을 정렬한다. 기계의 바늘판을 분리하는 지렛대를 움직인다. 바늘판 사이에 금속빗을 설치하거나 뜨개질된 물품의 조각을 기계의 바늘 사이에 걸어둔다. 기계의 움직임대를 손으로 쥐고 좌우로 움직여 물품을 짠다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"수동편직기조작원","connectJob":"의류편물원, 장갑편물원","certLic":"섬유산업기사","dJobECd":"8629","dJobECdNm":"[8629]기타 섬유·가죽 기능원","dJobJCd":"7219","dJobJCdNm":"[7219]기타 섬유 및 가죽 관련 기능 종사원","dJobICd":"C143","dJobICdNm":"[C143]편조의복 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001458:1', '{"dJobCd":"K000001458","dJobCdSeq":"1","dJobNm":"스크린날염반장","workSum":"천에 스크린날염을 하는 작업원의 활동을 감독·조정한다.","doWork":"작업의 형태 및 분량, 기계 및 인원의 이용가능성을 정하기 위해 생산계획서 및 날염주문서를 분석한다. 견본날염, 생산계획, 스크린제작, 색깔혼합검사, 포장 등의 활동과 스크린 날염작업을 조정하기 위해 타 부서 반장과 상의한다. 작업계획에 따라 세부실행항목을 작성하여 작업절차 및 방법을 결정한 후 작업원이 효율적으로 작업할 수 있도록 적당한 위치에 배정하고 작업내용을 작업원에게 지시한다. 작업공정에 있어 필요한 자재지원 및 기술을 지원한다. 표준명세에 따라 지시된 작업이 이루어지는지 작업원과 함께 작업하며 작업상황을 관찰하며 작업내용을 점검한다. 작업원에 대한 직무교육 및 안전위생교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시로 관찰과 면담을 통하여 작업원의 애로 및 건의사항을 수렴·해결하고 문제점을 보고한다. 작업진행상황을 파악하고 작업내용을 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"수동조작","certLic":"염색기능사(날염)","dJobECd":"8629","dJobECdNm":"[8629]기타 섬유·가죽 기능원","dJobJCd":"7219","dJobJCdNm":"[7219]기타 섬유 및 가죽 관련 기능 종사원","dJobICd":"C134","dJobICdNm":"[C134]섬유제품 염색, 정리 및 마무리 가공업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006727:1', '{"dJobCd":"K000006727","dJobCdSeq":"1","dJobNm":"융단검사원","workSum":"직조상의 결함, 절단되지 않은 실밥, 헐거운 실 등을 찾아내기 위해 융단을 검사한다.","doWork":"작업대 위에 융단을 펴놓고 얼룩, 퇴색, 빠뜨린 땀, 구멍, 헐겁게 짜인 곳, 자르지 않은 실밥, 주름, 먼지, 매듭, 얼룩 등의 결함이 있는지 검사한다. 융단이 수선될 수 있는지를 결정하고 품질에 따라 분류한다. 융단의 수량과 결함에 대한 보고서를 작성한다. 융단의 색과 실에 어울리는 실을 사용하여 땀을 때우기도 한다. 세탁용제나 천으로 얼룩을 지우기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"카펫검사원","dJobECd":"8629","dJobECdNm":"[8629]기타 섬유·가죽 기능원","dJobJCd":"7219","dJobJCdNm":"[7219]기타 섬유 및 가죽 관련 기능 종사원","dJobICd":"C139","dJobICdNm":"[C139]기타 섬유제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003919:1', '{"dJobCd":"K000003919","dJobCdSeq":"1","dJobNm":"융단보수원","workSum":"잘못 짜거나 빠진 땀 등을 찾아 카펫이나 융단을 보수한다.","doWork":"동력장치를 이용한 검사대에서 불완전한 곳, 빠진 땀 등 결점을 찾아내거나 융단검사원이 표시한 곳을 살핀다. 수선 도구나 가위를 사용하여 자르지 않은 실, 헐거운 실 끝 등을 잘라낸다. 융단과 어울리는 색깔의 실을 선택하여 코바늘에 꿰거나 수선장치를 이용하여 땀이 빠진 곳의 바닥 천에 실을 건다. 얼룩을 제거하기 위해 천이나 세탁용제로 얼룩 부위를 문지른다. 융단의 뒷면에 천 조각을 대어 붙이기도 한다. 잘못된 공정을 관련 부서에 알리기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"카펫보수원","dJobECd":"8629","dJobECdNm":"[8629]기타 섬유·가죽 기능원","dJobJCd":"7219","dJobJCdNm":"[7219]기타 섬유 및 가죽 관련 기능 종사원","dJobICd":"C139","dJobICdNm":"[C139]기타 섬유제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006769:1', '{"dJobCd":"K000006769","dJobCdSeq":"1","dJobNm":"전통천연염색원","workSum":"천연염료를 사용하여 전통색인 오방색을 직물에 염색한다.","doWork":"잿물에 담근 천을 시루에 수차례 찌는 마전작업을 통해 직물을 표백한다. 표백된 직물을 세척하여 잿물을 제거하고 건조한다. 치자, 물푸레나무, 홍화, 쪽 등의 천연염료에 물과 석회가루, 잿물 등의 매염제를 혼합하여 염액을 조제한다. 조제된 염액에 직물을 넣고 물들인다. 물들이는 횟수에 따라 색의 농도를 조절한다. 염색 후 건조를 거쳐 흐르는 물에 씻어 잡때를 제거한다. 복합염색을 하고자 간색을 내기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"고온|다습|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"갈옷염색원","dJobECd":"8629","dJobECdNm":"[8629]기타 섬유·가죽 기능원","dJobJCd":"7219","dJobJCdNm":"[7219]기타 섬유 및 가죽 관련 기능 종사원","dJobICd":"C134","dJobICdNm":"[C134]섬유제품 염색, 정리 및 마무리 가공업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003119:1', '{"dJobCd":"K000003119","dJobCdSeq":"1","dJobNm":"직조원","workSum":"수동직조기를 사용하여 융단이나 삼베, 견직물 등을 직조한다.","doWork":"작업지시서 또는 도안을 확인하고 생산할 제품에 따라 색상별, 굵기별 실을 준비한다. 일정형태로 직물을 짜기 위해 경사를 직조기 부품을 통해 기계에 건다. 북에 위사가 감긴 실패를 끼우고 페달을 밟아 경사의 개구를 통해 북을 밀어 넣는다. 직물의 조직을 조밀하게 짜기 위해 바디를 사용하여 위사를 손으로 당긴다. 수동으로 직조기를 작동하고 경사나 위사가 끊어지는 등 직조상 결함을 찾아내고 수정한다. 끊어진 경사를 잇는다. 끊어지거나 소모된 위사를 뽑아내고 새 위사를 교환한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"수동직수원","dJobECd":"8629","dJobECdNm":"[8629]기타 섬유·가죽 기능원","dJobJCd":"7219","dJobJCdNm":"[7219]기타 섬유 및 가죽 관련 기능 종사원","dJobICd":"C132","dJobICdNm":"[C132]직물직조 및 직물제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006742:1', '{"dJobCd":"K000006742","dJobCdSeq":"1","dJobNm":"초경벽지염색원","workSum":"갈포, 황마 등의 원료를 짜서 만든 초경벽지를 작업지시서에 맞는 색상으로 염색하고자 칠하는 작업을 한다.","doWork":"작업지시서에 요구된 벽지의 색상 및 주문사항을 확인한다. 요구된 색상으로 염색하고자 염료통에 염료와 물을 혼합하여 조색한다. 염색대에 재단된 초경벽지를 펴고 수염솔로 초경벽지 위에 염료를 칠한다. 건조봉에 염색된 벽지를 걸어서 건조대에 건다. 건조가 완료된 갈포벽지의 염색 상태를 점검한다. 지사벽지를 제조하고자 종이를 여러 가지 색상으로 염색을 하기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|다습|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"8629","dJobECdNm":"[8629]기타 섬유·가죽 기능원","dJobJCd":"7219","dJobJCdNm":"[7219]기타 섬유 및 가죽 관련 기능 종사원","dJobICd":"C134","dJobICdNm":"[C134]섬유제품 염색, 정리 및 마무리 가공업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007457:1', '{"dJobCd":"K000007457","dJobCdSeq":"1","dJobNm":"한복제조원","workSum":"고객과의 상의를 통해 남자한복, 여자한복, 두루마기, 아동한복, 계량한복, 퓨전한복 등의 의복을 맞춤 제작한다.","doWork":"한복 제조 시 고객과의 상의에 따라 원단의 종류, 색상, 실용성, 디자인을 고른다. 줄자를 사용하여 고객의 치수를 재고 명세서에 규격, 색상, 직물의 종류, 본 등을 기록한다. 명세서에 따라 재단대 위에 원단을 펼쳐놓고 연필, 초크, 송곳을 사용하여 표시한다. 표시라인에 따라 가위로 재단한다. 한복은 직선재단(또는 평행재단)이라 일정 폭씩 접어서 표시없이 바로 재단하기도 한다. 각 재단 부위를 재봉틀로 재봉하거나 손바느질로 꿰맨다. 가위나 칼로 불필요한 실을 제거하고 다림질한다. 단추나 각종 장식물들을 손바느질하여 한복을 완성한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"한복기능사, 한복기능장","dJobECd":"8631","dJobECdNm":"[8631]한복 제조원","dJobJCd":"7221","dJobJCdNm":"[7221]한복 제조원","dJobICd":"C141","dJobICdNm":"[C141]봉제의복 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006527:1', '{"dJobCd":"K000006527","dJobCdSeq":"1","dJobNm":"양복사","workSum":"고객의 요구에 따라 양복, 신사용 외투 등 남성용 의복을 제작한다.","doWork":"고객과의 상담을 통해 양복의 디자인 및 스타일, 양복의 원단, 색상 등을 고른다. 고객의 신체적인 특성과 체형 등을 파악하고자 줄자를 사용하여 치수를 재고 기록한다. 치수에 따라 패턴용 자를 이용하여 제도하여 패턴을 제작한다. 패턴과정이 끝나면 고객이 선택한 원단에 가위를 사용하여 패턴모형대로 재단한다. 반쪽 분량을 두 장씩 포개어 놓고 초크 표시된 부분을 겹실뜨기한다. 원단을 시침질로 꿰매어 견본 옷을 만든 후 고객의 몸에 맞게 가봉하여 치수 및 디자인을 점검한다. 견본 옷을 분해하고 수정된 내용을 반영해 패턴을 수정한다. 미싱작업 전 안·겉감, 주머니 속, 스티치, 심지 등을 시침질하여 꿰맨다. 미싱으로 각 부위를 봉제한다. 봉제가 끝나면 시침질 실을 제거하고 시접·봉제선을 정리한 후 다림질하여 완성한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"맞춤양복사, 양복제조원, 주문양복사","certLic":"양복기능사","dJobECd":"8632","dJobECdNm":"[8632]양장·양복 제조원","dJobJCd":"7222","dJobJCdNm":"[7222]양장 및 양복 제조원","dJobICd":"C141","dJobICdNm":"[C141]봉제의복 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002460:1', '{"dJobCd":"K000002460","dJobCdSeq":"1","dJobNm":"양장사","workSum":"고객의 요구에 따라 다양한 품목의 여성용 의복을 제작한다.","doWork":"국내외 자료를 수집하여 패션유행 경향을 파악하고 디자인을 개발하거나 기존 양식을 복제한다. 원단의 종류, 색상 및 스타일을 고객과 상의한다. 줄자로 치수를 재고 기록한다. 패턴용지 위에 연필로 고객의 치수대로 본을 제도하여 패턴모형을 제작한다. 원단 위에 패턴모형을 올려놓고 초크로 표시, 가위로 재단한다. 재단된 원단들을 시침질로 꿰매어 견본 옷을 만든다. 고객에게 가봉하여 치수 및 디자인을 점검한다. 견본 옷을 분해하고 패턴을 수정한다. 미싱으로 각 부위를 봉제한다. 스티치, 치마단, 단추 달기 등을 손바느질하고 다림질하여 의복을 완성한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"맞춤양장사, 양장제조원, 주문양장사","certLic":"양장기능사","dJobECd":"8632","dJobECdNm":"[8632]양장·양복 제조원","dJobJCd":"7222","dJobJCdNm":"[7222]양장 및 양복 제조원","dJobICd":"C141","dJobICdNm":"[C141]봉제의복 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004966:1', '{"dJobCd":"K000004966","dJobCdSeq":"1","dJobNm":"웨딩드레스제조원","workSum":"고객의 주문이나 디자인명세서에 따라 웨딩드레스를 제작한다.","doWork":"고객과 디자인 및 원단의 종류, 레이스의 종류 등에 관해 상의한다. 줄자를 사용하여 고객의 치수를 재고 명세서에 규격, 원단의 종류, 패턴 등을 기록한다. 명세서에 따라 패턴용지 위에 디자인, 치수에 따른 모형을 연필로 제도하여 패턴모형을 제작한다. 패턴모형을 본으로 하여 견본 옷을 제작한다. 견본 옷을 손님에게 입혀보고 수정·보완한 후 패턴을 수정·완성한다. 원단 위에 패턴모형을 놓고 가위로 재단한다. 재단한 원단을 미싱으로 봉제한다. 치맛단과 레이스 및 각종 장식물 등을 손바느질로 꿰맨다. 가위나 칼로 불필요한 실을 제거하고 다림질한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"양장기능사","dJobECd":"8632","dJobECdNm":"[8632]양장·양복 제조원","dJobJCd":"7222","dJobJCdNm":"[7222]양장 및 양복 제조원","dJobICd":"C141","dJobICdNm":"[C141]봉제의복 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003094:1', '{"dJobCd":"K000003094","dJobCdSeq":"1","dJobNm":"모피의류완성원","workSum":"수봉이 끝난 제품에 부착물을 달고 잡털을 제거한 후 다림질하여 모피의복을 마무리한다.","doWork":"완성된 모피의류에 라벨 및 부착물을 단다. 에어스프레이(Air Spray)를 사용해 이물질 및 잡털을 제거한다. 털을 살리기 위하여 솔질하고 스팀다리미로 다림질한다. 완성된 모피제품을 마네킹이나 옷걸이에 걸고 빗이나 브러시로 빗어 재봉상태, 모질상태 등을 육안으로 점검한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"모피제품마무리원","dJobECd":"8633","dJobECdNm":"[8633]모피·가죽의복 제조원","dJobJCd":"7223","dJobJCdNm":"[7223]모피 및 가죽 의복 제조원","dJobICd":"C142","dJobICdNm":"[C142]모피제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004972:1', '{"dJobCd":"K000004972","dJobCdSeq":"1","dJobNm":"가죽제품수선원","workSum":"가방, 지갑, 벨트 등 가죽제품을 수선, 리폼, 염색 등을 한다.","doWork":"고객과 제품의 수선 부분, 수선 방법, 수선 완료일자 등에 대하여 협의한다. 수선 부분을 초크로 표시하거나 핀으로 꼽아 표시한다. 고객의 요구에 따라 수선 부분에 가죽을 대거나 손잡이를 교체하고 재봉틀을 사용하여 박음질한다. 염색이 필요한 경우 색상을 선정하여 염색을 한다. 모난 부분 등은 연마기를 사용하여 매끄럽게 한다. 수선된 제품을 쪽가위를 사용하여 박음질한 부분을 다듬어서 수선을 완료한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"손사용|시각|","workEnv":"소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"8634","dJobECdNm":"[8634]의복·가죽·모피 수선원","dJobJCd":"7224","dJobJCdNm":"[7224]의복·가죽 및 모피 수선원","dJobICd":"S953","dJobICdNm":"[S953]개인 및 가정용품 수리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005232:1', '{"dJobCd":"K000005232","dJobCdSeq":"1","dJobNm":"구두수선원","workSum":"고객의 요구에 따라 파손되거나 낡은 구두굽을 교체하고 갈라진 부위를 수선한다.","doWork":"소비자의 요구에 따라 구두의 파손부위를 수선해주거나 구두굽을 교체한다. 구두굽을 교체하고자 구두를 수선틀에 끼우고 집게와 칼을 사용하여 뒷굽 창을 분리한다. 칼과 사포를 사용하여 구두의 고무창이나 뒷굽 창에 붙어 있는 이물질을 제거하고 본드를 바른다. 뒷굽 창을 구두에 끼우고 망치로 두드려 밀착한다. 연마기를 사용하여 불필요한 부위를 연마하고 구두약을 도포하여 광택을 낸다. 구두의 찢어진 부위를 꿰매고 갑피에 난 구멍에 가죽조각을 대어 재봉질 한다. 제품의 재질에 따라 동일 재질의 벨트나 가방, 지갑 등의 제품을 수선하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"8634","dJobECdNm":"[8634]의복·가죽·모피 수선원","dJobJCd":"7224","dJobJCdNm":"[7224]의복·가죽 및 모피 수선원","dJobICd":"S953","dJobICdNm":"[S953]개인 및 가정용품 수리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001332:1', '{"dJobCd":"K000001332","dJobCdSeq":"1","dJobNm":"의류수선원","workSum":"재봉틀, 실, 자, 가위 등을 사용하여 의류를 수선한다.","doWork":"고객과 의류의 수선 부분, 수선 방법, 수선 완료일자 등에 대하여 협의한다. 수선 부분을 초크로 표시하거나 핀으로 꼽아 표시한다. 고객의 요구에 따라 의류의 기장이나 폭을 늘리거나 줄이고 단추를 달거나 지퍼 등을 박음질한다. 수선 부분에 천을 대고 재봉틀을 사용하여 박음질한다. 수선된 의류를 다림질하거나 쪽가위를 사용하여 박음질한 부분을 다듬어서 수선을 완료한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"웅크림|손사용|시각|","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"가죽의류수선원, 리폼디자이너, 모피의류수선원","certLic":"양장기능사","dJobECd":"8634","dJobECdNm":"[8634]의복·가죽·모피 수선원","dJobJCd":"7224","dJobJCdNm":"[7224]의복·가죽 및 모피 수선원","dJobICd":"S953","dJobICdNm":"[S953]개인 및 가정용품 수리업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001413:1', '{"dJobCd":"K000001413","dJobCdSeq":"1","dJobNm":"양말검사원","workSum":"새로운 스타일의 양말에 관한 품질기준을 세우는 데 필요한 자료를 얻거나 공장품질기준과 일치하는지 점검하기 위해 편직된 양말의 결함을 검사한다.","doWork":"작업표준에 의하여 검사기준서를 준비하고 숙지한다. 검사에 필요한 쪽가위, 줄자, 신장 기계, 신장굴곡기계, 바늘땀 기계, 확대경 등 검사기구 및 검사재료를 준비하여 이상 유무를 확인한다. 양말을 검사대에 끼우고 구멍, 세로 풀리기, 잘못된 고리나 이음 등의 결함을 검사한다. 줄자를 이용하여 양말의 전체 길이와 각 부분의 치수를 측정한다. 신장기계로 각 부분의 신장 길이를 측정하고 신장굴곡기계로 신장력을 측정한다. 바늘땀 기계를 사용하여 일정 면적당 바늘땀의 수를 알아본다. 결함의 종류에 따라 양말을 분류한다. 견본양말과 반품된 양말의 짜기, 잇기, 편성, 염색 등을 확대경을 사용하여 비교·검사한다. 생산방법 및 제조기계 등을 관찰하여 결함의 원인을 찾고 결함부분을 기록한다. 염색이 필요한 경우 일정 매수씩 세어 자루에 담아 염색공정으로 보내기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"생지검사원, 스타킹검사원","connectJob":"긴양말검사원, 남자양말검사원, 타이즈검사원","dJobECd":"8639","dJobECdNm":"[8639]기타 의복 제조원","dJobJCd":"7229","dJobJCdNm":"[7229]기타 의복 제조 관련 기능 종사원","dJobICd":"C144","dJobICdNm":"[C144]의복 액세서리 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002945:1', '{"dJobCd":"K000002945","dJobCdSeq":"1","dJobNm":"유니폼관리인","workSum":"행사진행을 도와주는 행사도우미의 유니폼 및 액세서리 등을 제작·관리·대여하는 업무를 한다.","doWork":"행사진행에 요구되는 유니폼 및 액세서리를 주문에 따라 제작한다. 행사 시 찢기거나 풀린 유니폼을 수선하고 장식물의 관리를 한다. 대여한 유니폼 및 장식물을 회수하고 수량을 파악하며, 이상 유무를 확인하고 관리한다. 얼룩이 묻거나 더러워진 유니폼 등의 세탁을 의뢰한다. 유니폼을 외부거래처에 대여하기 위하여 입출 및 운송업무를 하며 거래처를 관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8639","dJobECdNm":"[8639]기타 의복 제조원","dJobJCd":"7229","dJobJCdNm":"[7229]기타 의복 제조 관련 기능 종사원","dJobICd":"C144","dJobICdNm":"[C144]의복 액세서리 제조업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001369:1', '{"dJobCd":"K000001369","dJobCdSeq":"1","dJobNm":"의류견본제작원","workSum":"원형본, 스케치, 작업지시서에 따라 새로운 모양의 견본의복을 제작한다.","doWork":"신제품 개발 시 견본의복의 의뢰가 들어오면 작업지시서를 확인 후 원단, 부자재 및 작업도구를 확인한다. 패턴실로부터 기본형 패턴을 수령한다. 원단을 패턴대로 자르고 안감, 심지, 주머니 등을 재단한다. 재단이 끝난 각 부분품을 재봉틀을 사용하여 조립한다. 단추 등 장식물을 부착한다. 완성된 제품을 작업지시서와 비교·검사하고 수정부분을 보완한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"견본의복제작원, 샘플사, 샘플제작원","connectJob":"핸드백샘플사, 가방샘플사, 의료샘플사","dJobECd":"8639","dJobECdNm":"[8639]기타 의복 제조원","dJobJCd":"7229","dJobJCdNm":"[7229]기타 의복 제조 관련 기능 종사원","dJobICd":"C141","dJobICdNm":"[C141]봉제의복 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005757:1', '{"dJobCd":"K000005757","dJobCdSeq":"1","dJobNm":"의복검사원","workSum":"의복제조의 중간공정 또는 마무리공정에서 재단물, 봉제품, 완제품 등의 결함을 검사한다.","doWork":"작업표준에 의하여 제품에 따른 검사항목을 확인하고 그에 따른 검사기준서 및 검사표준서를 준비하고 숙지한다. 검사에 필요한 장비를 준비하고 이상 유무를 점검한다. 원단의 소모량을 최소화하기 위해 천에 패턴을 배열하고 패턴의 수를 센다. 의복의 부착물이 제대로 부착되었는지 검사한다. 의복 가장자리의 마무리상태 및 줄무늬나 격자무늬 등의 텍스트타일 무늬모양을 검사한다. 솔기의 주름, 헐거운 바느질, 포장상태 등 결함 여부를 육안으로 검사한다. 완성된 의복이 표준치수에 맞는가를 줄자로 측정한다. 결함이 있는 부분에 표시하고 해당부서로 보낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8639","dJobECdNm":"[8639]기타 의복 제조원","dJobJCd":"7229","dJobJCdNm":"[7229]기타 의복 제조 관련 기능 종사원","dJobICd":"C141","dJobICdNm":"[C141]봉제의복 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005539:1', '{"dJobCd":"K000005539","dJobCdSeq":"1","dJobNm":"의복완성반장","workSum":"의복을 끝손질하고 마무리하는 작업원의 활동을 감독·조정한다.","doWork":"의복의 마무리 공정에 관한 전반적인 지식과 내용을 숙지한다. 생산량, 시간계획 등을 수립하여 작업지침을 만들고 이에 따라 작업원을 적정하게 배치한다. 작업장비 등을 점검한다. 표준명세서에 따라 각 공정을 관리·감독한다. 작업지침에 따라 제사처리, 단춧구멍, 단추달기, 포장 등의 상태를 점검한다. 작업공정에 있어 필요한 자재지원 및 기술을 지원한다. 작업원에 대한 직무교육 및 안전위생교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시로 관찰과 면담을 통하여 작업원의 애로 및 건의사항을 수렴·해결하고 문제점을 보고한다. 작업원과 작업을 병행하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"수동조작","certLic":"양복기능사, 양장기능사","dJobECd":"8639","dJobECdNm":"[8639]기타 의복 제조원","dJobJCd":"7229","dJobJCdNm":"[7229]기타 의복 제조 관련 기능 종사원","dJobICd":"C141","dJobICdNm":"[C141]봉제의복 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001409:1', '{"dJobCd":"K000001409","dJobCdSeq":"1","dJobNm":"의복완성원","workSum":"의복의 각 부분품을 결합하거나 보강하여 마무리·완성한다.","doWork":"옷의 구멍에 단추, 스냅, 벨트장식 등 부분품을 부착한다. 허리부위에 벨트 고리를 부착한다. 단추 혹은 벨트를 벨트 고리에 끼우고 잠그거나 멜빵 등을 부착한다. 불필요한 실밥을 제거한다. 완성된 의복을 사이즈와 색상별로 분류하고 라벨이나 태그를 부착한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"의복마무리원","certLic":"양복기능사, 양장기능사","dJobECd":"8639","dJobECdNm":"[8639]기타 의복 제조원","dJobJCd":"7229","dJobJCdNm":"[7229]기타 의복 제조 관련 기능 종사원","dJobICd":"C141","dJobICdNm":"[C141]봉제의복 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004575:1', '{"dJobCd":"K000004575","dJobCdSeq":"1","dJobNm":"단판선별검사원","workSum":"합판을 제조하기 위해 건조와 재단이 된 단판을 규정된 등급에 따라 선별하여 구분·적재하고, 건조된 제품의 겉모양, 건조상태 등을 검사한다.","doWork":"적재대에 적재된 단판을 동료 작업원과 마주잡고 모서리 파손이나 편매(한 장의 중판을 이어붙이기 위해 절단된 단판)가 발생하지 않도록 선별대로 운반한다. 단판을 서로 마주잡고 한 장씩 넘기면서 등급별로 구분 적재한다. 등급별로 구분 적재된 단판(갑판재, 을판재, 보수재, 테이프재, 포장재)은 각각 다음 작업공정으로 운반한다. 접히거나 겹쳐서 불량이 발생하는 것을 방지하고, 치수가 부족하거나 편매가 삽입된 단판을 성형기(컴포저:Composer)로 보내 제거한다. 건조기에서 건조되어 나온 제품의 견본을 일정 시간마다 단판 선별장에서 채취하여 겉모양, 휨, 건조 상태 등을 검사규정에 따라 육안으로 판정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"유지","dJobECd":"8833","dJobECdNm":"[8833]목제품 제조원","dJobJCd":"7301","dJobJCdNm":"[7301]목제품 제조 관련 종사원","dJobICd":"C162","dJobICdNm":"[C162]나무제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007360:1', '{"dJobCd":"K000007360","dJobCdSeq":"1","dJobNm":"목공소작업원","workSum":"목제품을 생산하기 위하여 목재를 관리·선정·가공·완성하는 작업을 수행하거나 보조한다.","doWork":"목재의 관리를 위하여 공기가 유통되도록 제재목 사이에 지지목을 배치하고 자연건조 기간 동안 더미를 함께 묶어 놓는다. 목재의 균열을 방지하기 위하여 강철 띠를 제재목이나 침목에 망치로 박아서 건조 중에 균열을 막고, 균열이 발생한 제재목에 볼트나 맞춤목을 삽입하여 갈라진 부분이 떨어져 나가지 않게 조치한다. 목재를 재사용하기 위하여 못과 다른 금속물을 목재에서 제거한다. 반죽이나 퍼티 또는 기타 재료를 솔, 보수용 칼 및 손가락을 사용하여 목재기공이나 구멍 또는 다른 오목한 자국들을 채운다. 솔벤트나 강철모, 솔과 천을 사용하여 페인트, 래커 또는 다른 마무리 물질을 제거하고, 거친 곳은 사포나 연마기로 문질러서 사용가능한 상태로 마무리한다. 목제품의 제작을 위하여 도면에 따라 재목에 필기구, 못, 줄자, 선형자 등으로 작업선을 표시한다. 각종 목공기계를 사용하여 재목을 가공하거나 목공기계 조작자를 보조한다. 망치, 못, 톱, 대패, 아교, 사포 등을 사용하여 부분품을 조립한다. 제품에 따라 가죽을 씌우거나, 장식을 붙이거나, 도장하여 제품을 완성한다. 각종 완성품이나 재료의 검사를 위하여 측정도구를 사용하여 결함, 마무리와 등급·치수가 정확한지 확인하고 문제가 있으면 조치한다. 생산하는 제품에 따라 제품에 등급을 표시하거나, 가공이나 검사한 유닛(Unit)의 무게를 측정하여 기록하기도 한다. 커터헤드(Cutter Heads)와 날을 바꾸고 벨트를 조절하며 작업 장소에 목공기계를 설치하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8833","dJobECdNm":"[8833]목제품 제조원","dJobJCd":"7301","dJobJCdNm":"[7301]목제품 제조 관련 종사원","dJobICd":"C162","dJobICdNm":"[C162]나무제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005100:1', '{"dJobCd":"K000005100","dJobCdSeq":"1","dJobNm":"목제품광택원","workSum":"피아노 외장, 건반, 라켓 등 기타 목제품의 흠을 제거하고 광택을 낸다.","doWork":"가공할 소재에 따라 적절한 광택방법을 선정한다. 압축공기를 사용하여 표면의 먼지를 제거한다. 붓이나 솔을 사용하여 결함이 있는 부분에 분말을 바른다. 회전하는 융 버프(Buff) 기계를 사용하여 먼지나 이물질을 깨끗이 닦아낸다. 소재의 형태에 따라 광택휠에 맞대어 광택을 내거나 연마반을 사용하여 광택을 낸다. 광택작업을 하기 전에 흠집이나 이물질이 있는 부분을 수동 사포연마기를 사용하여 손으로 연마하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|시각|","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"목제품광택연마원, 목제품버핑원, 목제품사상원","dJobECd":"8833","dJobECdNm":"[8833]목제품 제조원","dJobJCd":"7301","dJobJCdNm":"[7301]목제품 제조 관련 종사원","dJobICd":"C320","dJobICdNm":"[C320]가구 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005291:1', '{"dJobCd":"K000005291","dJobCdSeq":"1","dJobNm":"목함제작원","workSum":"대패 등을 사용하여 물품보관이나 장식용 등의 목함을 제조한다.","doWork":"수동대패로 나무의 모서리를 깎는다. 사포를 사용해 거친 나무단면을 연마한다. 상자 또는 기구함 등의 표면에 래커나 페인트를 칠한다. 부품을 끼워줄 홈을 파기 위해 드릴을 다룬다. 걸쇠, 꺾쇠, 손잡이, 장식물 등 부착물을 부착하고 제조업체를 표시하기 위해 인두 등으로 철인을 찍는다. 완성된 상자를 종이상자나 비닐로 포장한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","connectJob":"목함도장원, 장식물부착원","certLic":"목공예기능사","dJobECd":"8833","dJobECdNm":"[8833]목제품 제조원","dJobJCd":"7301","dJobJCdNm":"[7301]목제품 제조 관련 종사원","dJobICd":"C162","dJobICdNm":"[C162]나무제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004364:1', '{"dJobCd":"K000004364","dJobCdSeq":"1","dJobNm":"원목검사원","workSum":"합판제조 시 박피된 원목의 겉모양, 지름, 길이 등을 검사하여 합판재로서 사용 적부를 판정한다.","doWork":"로그컨베이어(Log Conveyer) 위에 있는 박피된 원목의 겉모양을 육안으로 검사한다. 원목의 단면을 자로 측정하여 평균 직경을 산출하고 기준치에 미달하면 용도를 변경한다. 개개의 원목에 대한 검사결과를 조목검사일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"손사용|시각|","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","dJobECd":"8833","dJobECdNm":"[8833]목제품 제조원","dJobJCd":"7301","dJobJCdNm":"[7301]목제품 제조 관련 종사원","dJobICd":"C162","dJobICdNm":"[C162]나무제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003173:1', '{"dJobCd":"K000003173","dJobCdSeq":"1","dJobNm":"원목방부처리원","workSum":"광산 갱내 등에서 사용되는 원목의 부패를 방지하기 위하여 원목을 방부처리 한다.","doWork":"작업일지를 확인하고 작업의 세부계획을 수립한다. 요구되는 방부제를 준비하고 장비 및 도구를 확인·점검한다. 자귀(나무를 깎아 다듬는 연장)나 도끼로 원목의 껍질을 벗긴다. 껍질을 벗긴 원목을 응달에서 일정 함수율(전건재 중량에 대한 함수량의 백분율)까지 건조시킨다. 원목 표면에 솔을 사용하여 방부제를 균일하게 칠한다. 작업지시서나 작업표준에 따라 방부액의 농도를 맞추어 방부탱크에 붓는다. 방부액의 온도를 조절하고 방부액이 원목에 충분히 스며들도록 일정 시간 원목을 탱크에 담근다. 샘플을 채취하여 원목의 방부상태를 확인한다. 탱크에 방부액과 갱목을 넣고 밀폐한다. 압축공기를 이용하여 원목에 방부액을 압입시킨다. 샘플을 채취하여 압입상태를 점검한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"원목투입원","certLic":"지게차운전기능사","dJobECd":"8833","dJobECdNm":"[8833]목제품 제조원","dJobJCd":"7301","dJobJCdNm":"[7301]목제품 제조 관련 종사원","dJobICd":"C161","dJobICdNm":"[C161]제재 및 목재 가공업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001422:1', '{"dJobCd":"K000001422","dJobCdSeq":"1","dJobNm":"조각마무리원","workSum":"조각 또는 절단된 나무기물 및 완성품의 표면을 검사하고 매끄럽게 다듬는다.","doWork":"조각도의 자국이나 나무표면의 보풀 등 결함을 검사한다. 결함이나 사용할 성형공구의 종류에 따라 나무기물을 분류한다. 조각도 자국이나 표면의 보풀을 제거하기 위해 회전연마기로 다듬는다. 각이 지거나 좁은 부분을 매끄럽게 다듬기 위해 사포로 문지르고 표면연마정도에 따라 더 고운 사포로 반복하여 문지른다. 조립부분의 못 자국이나 파인 흠 등을 메우기 위하여 나무기물과 동일한 색상의 도료를 칠하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|시각|","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","certLic":"목공예기능사","dJobECd":"8833","dJobECdNm":"[8833]목제품 제조원","dJobJCd":"7301","dJobJCdNm":"[7301]목제품 제조 관련 종사원","dJobICd":"C162","dJobICdNm":"[C162]나무제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006587:1', '{"dJobCd":"K000006587","dJobCdSeq":"1","dJobNm":"포장용목재상자제작원","workSum":"수동공구나 동력공구를 사용하여 판재와 각재를 자르고, 다듬어서 포장용 목재상자의 부분품을 제작한다.","doWork":"자, 연필을 사용하여 판재와 각재를 일정한 길이로 측정하여 표시한다. 전기톱이나 수동톱을 사용하여 판재와 각재를 절단한다. 절단된 판재가 힘을 받을 수 있도록 각재를 덧대어 타카(못박기용 기계)나 망치 등으로 못질한다. 제작된 각각의 목재상자용 부분품을 포장용목재상자조립원에게 인도한다. 수동공구를 사용하여 중고 상자나 손상된 상자를 수선하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|손사용|","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","certLic":"목공예기능사","dJobECd":"8833","dJobECdNm":"[8833]목제품 제조원","dJobJCd":"7301","dJobJCdNm":"[7301]목제품 제조 관련 종사원","dJobICd":"C162","dJobICdNm":"[C162]나무제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006261:1', '{"dJobCd":"K000006261","dJobCdSeq":"1","dJobNm":"포장용목재상자조립원","workSum":"목재상자용 부분품을 조립하여 수출용 화물 등 대형화물을 포장한다.","doWork":"포장용 목재받침대 위에 화물을 지게차나 손으로 올려놓는다. 받침대에 상품이 움직이지 않도록 못으로 고정각목을 견고히 박는다. 비닐로 습기가 침투되지 않도록 테이프로 밀봉한다. 외부 합판과 비닐포장된 상품 사이에 스티로폼을 사방에 넣는다. 사면과 상부의 뚜껑을 타카(못박기용 기계)로 못을 견고히 박는다. 상자 외부에 제품규격 표시를 마킹한다. 수동밴딩기를 사용하여 철재 띠로 묶는다. 제품에 따라 실리카겔 등의 방습제를 넣기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"단순작업","dJobECd":"8833","dJobECdNm":"[8833]목제품 제조원","dJobJCd":"7301","dJobJCdNm":"[7301]목제품 제조 관련 종사원","dJobICd":"C162","dJobICdNm":"[C162]나무제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004914:1', '{"dJobCd":"K000004914","dJobCdSeq":"1","dJobNm":"합판등급원","workSum":"작업표준서에 의하여 합판의 품질상태를 검사하고 등급을 매긴다.","doWork":"합판 판면 및 겉모양의 옹이, 갈라짐, 퍼터자국 등 외관을 검사한다. 합판의 밀도, 함수율, 접착성 및 강도, 포름알데히드 방출량 등 품질항목에 적합한지 검사한다. 개개의 합판 또는 적재해 놓은 합판 위에 품질등급을 표시하고 기준치에 미달하면 불량처리로 표시하여 관련 부서에통보한다. 합격품은 제품의 파손을 방지하기 위해 상하에 폐판을 덮어 포장한다. 규격별 검사, 매수 및 합격, 불량품 매수를 검사일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","connectJob":"파티클보드등급원, 하드보드등급원","certLic":"목재가공기능사, 펄프종이제조기능사","dJobECd":"8833","dJobECdNm":"[8833]목제품 제조원","dJobJCd":"7301","dJobJCdNm":"[7301]목제품 제조 관련 종사원","dJobICd":"C162","dJobICdNm":"[C162]나무제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005287:1', '{"dJobCd":"K000005287","dJobCdSeq":"1","dJobNm":"가구수리원","workSum":"고객의 요구에 따라 가구의 부품을 교환하거나 수리한다.","doWork":"고객으로부터 불만, 부가서비스 등을 접수하여 방문 계획을 수립하고 옷장, 책상, 소파 등 가구의 파손 부위를 수리한다. 대패, 끌 등의 목공구와 수동공구를 사용하여 파손된 부위에 맞는 부품을 제작하고, 못이나 접착제를 사용하여 조립한다. 오염되거나 파손된 소파의 천을 교체하고 가구표면의 장식이나 자개 등을 모양에 맞게 부착한다. 각종 도료를 혼합하여 가구의 색상과 맞추고 붓이나 스프레이를 사용하여 도색한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|시각|","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"가구수선원","connectJob":"소파천교체원","certLic":"가구제작기능사","dJobECd":"8831","dJobECdNm":"[8831]가구 제조·수리원","dJobJCd":"7302","dJobJCdNm":"[7302]가구 제조 및 수리원","dJobICd":"C320","dJobICdNm":"[C320]가구 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005479:1', '{"dJobCd":"K000005479","dJobCdSeq":"1","dJobNm":"금속가구제작원","workSum":"절단, 절곡, 용접, 단조 등의 작업을 통해 캐비닛, 책상, 로커 등의 금속가구를 제작한다.","doWork":"제작에 필요한 장비 및 도구의 동작 이상 유무를 확인하고 설계도면을 점검한다. 절단기와 망치 등 공작기계를 이용하여 금속재료를 설계도면에서 요구하는 형상과 치수대로 절단한다. 버니어캘리퍼스 등 측정 장비로 철판에 치수를 표시한 후 절곡기로 정밀하게 구부리거나 휜다. 프레스기에 삽입하여 압축한 후 도면에 따라 금속판을 전기용접기 등으로 접합하고 전동드릴, 탁상드릴 등으로 구멍을 내어 금속부품 등을 끼워 맞춘다. 수동 및 압축공기 망치를 사용하여 부품을 고정시키고 집게, 렌치 등의 수공구를 사용하여 부품들을 볼트로 죄거나 나사로 조인다. 완성된 제품은 종이로 싸거나 상자에 포장한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|고온|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","certLic":"가구제작기능사","dJobECd":"8831","dJobECdNm":"[8831]가구 제조·수리원","dJobJCd":"7302","dJobJCdNm":"[7302]가구 제조 및 수리원","dJobICd":"C320","dJobICdNm":"[C320]가구 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006871:1', '{"dJobCd":"K000006871","dJobCdSeq":"1","dJobNm":"등가구제작원","workSum":"등나무 줄기를 가공하여 의자, 탁자 등의 등가구를 제작한다.","doWork":"고품질의 등나무를 선별하여 마디 부분을 칼로 깎아내고 사포로 연마한다. 열을 가해서 재료를 휘어 제품의 형태를 만들고 거친 부분이 있으면 사포로 다시 연마한다. 골격형성 및 부분품 연결을 위해 못으로 박거나 연결 부위를 등나무 껍질로 감는다. 앉는 부분, 등을 기대는 부분 등을 제작하기 위해 등나무 재료를 편조하고 골격에 대어 조립한다. 가는 사포를 사용하여 표면을 부드럽게 연마하고 필요에 따라 염색한 후 털끝 같은 거친 부분을 불로 태워 제거한다. 우레탄과 경화제를 혼합한 도료를 스프레이나 붓으로 덧칠하여 코팅을 하고 건조시킨다. 최종적으로 사포로 표면을 다시 연마하고 덧칠로 광택을 낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|고온|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","certLic":"가구제작기능사","dJobECd":"8831","dJobECdNm":"[8831]가구 제조·수리원","dJobJCd":"7302","dJobJCdNm":"[7302]가구 제조 및 수리원","dJobICd":"C320","dJobICdNm":"[C320]가구 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005788:1', '{"dJobCd":"K000005788","dJobCdSeq":"1","dJobNm":"영유아안전장치설치원","workSum":"영유아시설이나 유아를 둔 가정집을 방문하여 영유아에게 위해를 가할 수 있는 내·외부의 위험요소를 탐색하여 제거하거나 안전장치 및 시설물을 시공한다.","doWork":"영유아시설(어린이집, 놀이방, 학원, 학교 등) 관리자의 의뢰에 따라 현장을 방문하여 위험요소를 파악한다. 견적서를 작성하고 시공일정, 금액 등을 협의한다. 견적서(시방서)에 따라 출입문의 손끼임 방지, 도어 손보호대, 모서리·코너 보호대, 계단 미끄럼 방지판, 미끄럼방지매트, 바닥·벽매트, 문닫힘 방지, 전기콘센트 커버, 안전문 등 다양한 안전 물품·자재를 현장에서 시공한다. 자가 설치하는 고객에게 안전용품을 판매하거나 시공방법을 설명하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"손사용|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8831","dJobECdNm":"[8831]가구 제조·수리원","dJobJCd":"7302","dJobJCdNm":"[7302]가구 제조 및 수리원","dJobICd":"S969","dJobICdNm":"[S969]그 외 기타 개인 서비스업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006499:1', '{"dJobCd":"K000006499","dJobCdSeq":"1","dJobNm":"건반악기가공반장","workSum":"피아노, 오르간, 아코디언, 멜로디언 등 건반악기 제조 시 각종 부품을 제조하고 가공하는 데 관련된 작업원의 활동을 감독·조정한다.","doWork":"입고된 자재가 작업표준서의 규격과 일치하는지를 확인한다. 생산계획에 따라 부품이 생산되는지 생산량을 점검한다. 가공한 부품이 표준규격과 일치하는지 검사하여 이상이 있으면 해당 부서로 보낸다. 기타 작업원의 활동을 감독·조정하고 작업과 관련된 교육을 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"청각|손사용|언어력|시각|","workFunc1":"조정","workFunc2":"감독","workFunc3":"수동조작","dJobECd":"8851","dJobECdNm":"[8851]악기 제조원 및 조율사","dJobJCd":"7303","dJobJCdNm":"[7303]악기 제조 및 조율사","dJobICd":"C332","dJobICdNm":"[C332]악기 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003534:1', '{"dJobCd":"K000003534","dJobCdSeq":"1","dJobNm":"건반악기건반조정원","workSum":"피아노, 아코디언, 멜로디언 등 건반악기의 건반을 수동공구를 사용하여 조정하고 조립한다.","doWork":"입고된 건반의 상태를 점검한다. 사포기계를 사용하여 불량건반을 사포질 한다. 건반의 앞면과 윗면을 수평으로 맞추기 위해 밸런스 핀(Balance Pin)과 프런트 핀(Front Pin)을 수동공구를 사용하여 전·후·좌·우로 조정한다. 손으로 건반을 눌러 상하작동 상태를 점검한다. 건반에 이상이 있을 때는 프런트 핀을 돌려준다. 건반에 일정 무게의 추를 올려놓아 건반의 무게를 측정하고 밸브스프링을 앞으로 당겨주거나 펜치를 사용하여 구부린다. 건반을 악기의 본체에 삽입하여 조임 나사를 조여 고정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"피아노조율산업기사, 피아노조율기능사","dJobECd":"8851","dJobECdNm":"[8851]악기 제조원 및 조율사","dJobJCd":"7303","dJobJCdNm":"[7303]악기 제조 및 조율사","dJobICd":"C332","dJobICdNm":"[C332]악기 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002962:1', '{"dJobCd":"K000002962","dJobCdSeq":"1","dJobNm":"건반악기검사원","workSum":"제조된 피아노, 아코디언, 멜로디언 등 건반악기를 작업표준서의 검사규격에 따라 육안이나 측정기기를 사용하여 검사한다.","doWork":"작업표준서에 명시된 검사규격을 숙지한다. 건반악기의 외장의 비틀림, 균열, 표면의 도장상태 등을 육안으로 검사한다. 다리, 페달, 지주, 프레임, 향판, 브리지, 튜닝핀, 액션 등의 규격을 검사한다. 조율 상태, 음정의 유지, 액션의 연관운동, 페달상태 등을 검사한다. 외장, 내장 등이 규격대로 가공되었는지 줄자, 버니어캘리퍼스, 게이지 등으로 측정한다. 측정 자료에 따라 제품을 판정하고 검사표를 작성한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"청각|손사용|시각|","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"피아노조율산업기사, 피아노조율기능사","dJobECd":"8851","dJobECdNm":"[8851]악기 제조원 및 조율사","dJobJCd":"7303","dJobJCdNm":"[7303]악기 제조 및 조율사","dJobICd":"C332","dJobICdNm":"[C332]악기 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003211:1', '{"dJobCd":"K000003211","dJobCdSeq":"1","dJobNm":"건반악기부품검사원","workSum":"피아노, 아코디언, 멜로디언 등 건반악기 부품 중 스켈레톤, 액션 등을 등급에 따라 구분하고 불량품을 검사한다.","doWork":"입고된 스켈레톤, 액션, 건반 등 부품을 작업대에 준비한다. 부품의 재질, 색상, 무늬 갈라짐, 흠, 두께, 나뭇결, 옹이 등을 육안으로 검사하여 등급에 따라 구분하고 불량품을 분류한다. 선별한 부품은 연필로 표시하여 운반상자에 담는다. 이상이 있을 시 해당 부서에 연락하여 다시 도장하도록 의뢰하거나 반품을 의뢰한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|청각|손사용|시각|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"연동장치부품검사원, 튜닝핀검사원, 향판검사원","certLic":"피아노조율산업기사, 피아노조율기능사","dJobECd":"8851","dJobECdNm":"[8851]악기 제조원 및 조율사","dJobJCd":"7303","dJobJCdNm":"[7303]악기 제조 및 조율사","dJobICd":"C332","dJobICdNm":"[C332]악기 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005178:1', '{"dJobCd":"K000005178","dJobCdSeq":"1","dJobNm":"건반악기부품조립원","workSum":"피아노, 오르간, 아코디언, 멜로디언 등 건반악기 제조 시 댐퍼(Damper), 해머(Hammer), 건반(Key) 등의 내장부품을 조립한다.","doWork":"작업지시서에 따라 재료를 수령하고 조립순서를 파악한다. 액션의 댐퍼 와이어를 사용하여 댐퍼를 접착한다. 버트 우드(Butt Wood)에 해머를 꽂고 정확하게 맞춘다. 건반의 좌우 구멍에 캡스턴 와이어(Capston Wire)를 끼우고 압입기계를 사용하여 압입을 한다. 압입한 캡스턴 와이어에 캡스턴 블록(Capston Block)을 박는다. 건반을 건반대 위에 올려놓고 윕펜(Wippen) 사이에 맞춘다. 건반대와 키프레임에 나사못을 박아 고정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|시각|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8851","dJobECdNm":"[8851]악기 제조원 및 조율사","dJobJCd":"7303","dJobJCdNm":"[7303]악기 제조 및 조율사","dJobICd":"C332","dJobICdNm":"[C332]악기 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006040:1', '{"dJobCd":"K000006040","dJobCdSeq":"1","dJobNm":"건반악기수리원","workSum":"피아노, 오르간, 아코디언, 멜로디언 등 건반악기의 고장 난 부분을 수선하기 위하여 저음 및 최고음장치, 송풍기, 리드판, 건판 등의 부품을 분해하여 수리한다.","doWork":"피아노, 오르간, 아코디언, 멜로디언 등 건반악기의 결함을 알아내기 위해 직접 연주하여 본다. 수동공구를 사용하여 부품을 분해하여 결함이 있는 부분을 찾아내어 조정한다. 이상이 있는 리드(Reed:떨림판)를 새로운 리드로 교환한다. 목공기계와 수동공구를 사용하여 대체용 목재 부품을 만든다. 결함이 있는 금속부품을 용접기를 사용하여 용접하거나 새 부품으로 교체한다. 수선이 끝난 악기부품을 수동공구를 사용하여 재조립하고 연주를 해보아 정확한 음이 나오는지 판단한다. 악기를 광택내기 위해 연마 휠이나 광택공구를 사용한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"청각|손사용|시각|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"8851","dJobECdNm":"[8851]악기 제조원 및 조율사","dJobJCd":"7303","dJobJCdNm":"[7303]악기 제조 및 조율사","dJobICd":"C332","dJobICdNm":"[C332]악기 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003691:1', '{"dJobCd":"K000003691","dJobCdSeq":"1","dJobNm":"건반악기외장조립원","workSum":"피아노, 아코디언, 멜로디언 등 건반악기의 외장 및 부품을 각종 공구를 사용하여 조립하는 데 관련된 업무를 수행한다.","doWork":"피아노, 아코디언, 멜로디언 등 건반악기의 외장부품의 접착이 용이하도록 적외선 열판가열기를 사용하여 일정 시간 동안 예열한다. 손공구, 띠톱, 지그, 드릴기계, 벨트사포기계를 사용하여 건반대, 페달부분, 뚜껑, 다리 등에 구멍을 뚫고 연마하여 부품을 조립한다. 펠트(Felt)에 풀칠을 하여 밑판의 페달이 닿는 부분에 접착한다. 페달판, 악보대, 건반뚜껑, 금속물, 장식부품 등을 접착제, 손공구, 동력공구를 사용하여 부착한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"단판접착원, 뚜껑조립원, 무늬목접착원, 상표접착원, 외장조립원, 지주맞춤원, 페달조립원","dJobECd":"8851","dJobECdNm":"[8851]악기 제조원 및 조율사","dJobJCd":"7303","dJobJCdNm":"[7303]악기 제조 및 조율사","dJobICd":"C332","dJobICdNm":"[C332]악기 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007199:1', '{"dJobCd":"K000007199","dJobCdSeq":"1","dJobNm":"건반악기조율원","workSum":"피아노의 해머 펠트를 조정하고 소리굽쇠 등을 사용하여 음을 조율한다.","doWork":"피아노의 중음부 세 선 중에서 가운데 음반소리가 나도록 웨지(Wedge:소리가 나지 않도록 음을 차단하는 기구)를 양선에 끼운다. 손으로 건반을 치며 소리굽쇠의 소리를 들어보거나 튜너(Tuner음의 파장을 감지하는 기계)를 관찰해 비교한다. 원음이 나오지 않으면 수동공구를 사용하여 튜닝핀(Tuning Pin)을 돌려 음을 맞춘다. 웨지(Wedge)를 빼고 나머지 두 줄의 음을 맞춘다. 조율순서에 따라 저음·고음부분을 같은 방법으로 조율한다. 조율포크(Fork)와 공구를 사용하여 피아노, 오르간, 아코디언, 멜로디언 등 건반악기를 조율하기도 한다. 건반을 같은 힘으로 차례로 두드려가며 음색, 음량, 음계 등을 확인하여 음을 표시한다. 펠트의 경도를 확인하여 피커로 펠트를 찌르거나 사포로 펠트를 연마하여 경도를 조절한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"웅크림|청각|손사용|시각|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"건반악기정음원","connectJob":"피아노조율사","certLic":"피아노조율산업기사, 피아노조율기능사","dJobECd":"8851","dJobECdNm":"[8851]악기 제조원 및 조율사","dJobJCd":"7303","dJobJCdNm":"[7303]악기 제조 및 조율사","dJobICd":"C332","dJobICdNm":"[C332]악기 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005785:1', '{"dJobCd":"K000005785","dJobCdSeq":"1","dJobNm":"건반악기프레임제작원","workSum":"피아노 제조 시 현의 장력을 받드는 프레임을 제작한다.","doWork":"망치를 사용하여 용해로 내부 내화물의 침식부분을 제거한다. 인조규사와 모르타르를 삽으로 배합하고 미장도구를 이용하여 용해로 내부바닥을 바른다. 잡사와 모르타르를 혼합해 취가로 내부를 손으로 바르고 흑연을 헝겊이나 붓으로 문지른다. 취가로를 건조대에 올려놓고 건조시킨다. 용해로 내부에 장작과 코크스를 삽으로 투입한다. 장입물(코크스, 석회석, 규소철)을 손수레에 실어 수동저울로 측정한다. 엘리베이터로 운반된 장입물을 삽으로 취가로에 투입한다. 취가로를 용해로 출탕구 앞에 놓고 용해 여부를 육안으로 검사한다. 출탕구멍을 열어 쇳물을 출탕시킨다. 에어호스로 형틀을 청소한다. 이형제를 스프레이건으로 도포하고 자동성형기로 필름을 건조시킨다. 주물상자를 형틀에 맞추어 주물사를 투입한다. 주물사를 고르게 하고 필름을 씌워 진공상태가 되게 한다. 호이스트로 쇳물통을 운반하여 취가로에 담겨진 쇳물을 투입한다. 쇳물이 응고되면 형틀을 해체한다. 해체된 프레임의 쇠찌꺼기를 연마기로 제거한다. 금속부품(튜닝핀, 힛치핀, 브릿지핀) 구멍을 드릴로 가공한다. 연마기로 금속부품 표면을 연마하고 스프레이건으로 도장을 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|시각|","workEnv":"대기환경미흡|위험내재|고온|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8851","dJobECdNm":"[8851]악기 제조원 및 조율사","dJobJCd":"7303","dJobJCdNm":"[7303]악기 제조 및 조율사","dJobICd":"C332","dJobICdNm":"[C332]악기 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005150:1', '{"dJobCd":"K000005150","dJobCdSeq":"1","dJobNm":"관악기수리원","workSum":"금관 및 목관악기의 상태를 점검하고 수동공구를 사용하여 수리한다.","doWork":"악기의 결함을 알아내기 위해 부품을 움직이거나 음계를 눌러본다. 로드핀(Rodpin), 키, 피스톤 등 부품을 빼내어 수동공구를 사용하여 다시 성형한다. 연마기를 사용하여 부품의 흠을 제거한다. 결함이 있는 부위는 땜질하여 금관악기의 틈 위에 덧붙이고 줄질을 한다. 목관악기의 리드를 확인하고 새 것으로 교체한다. 래커 피복물과 녹을 제거하기 위해 래커제거용액과 시너용액으로 금속을 씻어낸다. 연마기를 사용하여 악기의 밸브에 달라붙은 오물을 제거한다. 악기를 광택내기 위해 연마 휠이나 광택공구를 사용한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"청각|손사용|시각|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"금관악기수리원, 목관악기수리원","dJobECd":"8851","dJobECdNm":"[8851]악기 제조원 및 조율사","dJobJCd":"7303","dJobJCdNm":"[7303]악기 제조 및 조율사","dJobICd":"C332","dJobICdNm":"[C332]악기 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003665:1', '{"dJobCd":"K000003665","dJobCdSeq":"1","dJobNm":"국악금부악기제조원","workSum":"합금(주로 놋쇠)을 사용하여 꽹과리, 징, 바라 등을 제조한다.","doWork":"악기의 종류에 따라 일정량의 금속(구리, 주석, 금)을 저울에 달아 금속을 녹이는 용광로에 투입하여 배합한다. 배합한 금속을 일정 모양의 형틀에 부어 냉각시킨다. 냉각한 금속을 악기의 종류와 크기에 따라 띠톱이나 띠톱기계를 사용하여 절단한다. 작업대 위에 금속을 올려놓고 여러 종류의 망치를 사용하여 두드리거나 불에 달구면서 악기의 모양을 만든다. 꽹과리, 징, 바라 등 금부악기를 직접 연주하여 소리를 듣고 망치로 두드리면서 음을 조절한다. 드릴이나 망치와 정을 사용하여 손잡이 구멍을 뚫는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"청각|손사용|시각|","workEnv":"대기환경미흡|위험내재|고온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"꽹과리제조원, 바라제조원, 징제조원, 편종제조원, 나발제조원","dJobECd":"8851","dJobECdNm":"[8851]악기 제조원 및 조율사","dJobJCd":"7303","dJobJCdNm":"[7303]악기 제조 및 조율사","dJobICd":"C332","dJobICdNm":"[C332]악기 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002328:1', '{"dJobCd":"K000002328","dJobCdSeq":"1","dJobNm":"금관악기제조원","workSum":"손공구나 금속가공기계를 사용하여 금속재료로 된 금관악기를 제작한다.","doWork":"놋쇠나 기타 이와 유사한 합금체로 된 금속관 등을 금속가공기계를 사용하여 절단한다. 금속관을 일정모양으로 만들기 위해 압연기를 사용하여 압연한다. 밸브와 피스톤 등의 각종 부품을 선반을 사용하여 일정한 모양으로 만든다. 줄질, 연마, 땜질 등으로 각 부품을 조립한다. 조립한 악기를 시험하고 손공구를 사용하여 조정한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"청각|손사용|시각|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"8851","dJobECdNm":"[8851]악기 제조원 및 조율사","dJobJCd":"7303","dJobJCdNm":"[7303]악기 제조 및 조율사","dJobICd":"C332/C339","dJobICdNm":"[C332]악기 제조업 / [C339]그 외 기타 제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004605:1', '{"dJobCd":"K000004605","dJobCdSeq":"1","dJobNm":"기타넥가공원","workSum":"수동공구로 목재를 성형하여 기타 넥을 가공한다.","doWork":"육안으로 입고된 목재의 상태를 점검한다. 작업계획서에 따라 목재에 도본 한다. 톱, 띠톱기계 등 절단공구를 사용하여 나무를 알맞은 형태로 성형한다. 수동공구를 사용하여 나무를 파내 트러스(Truss) 막대를 삽입할 홈을 가공한다. 드릴 등 수동공구를 사용하여 줄감개를 삽입할 구멍을 뚫는다. 사포나 벨트사포기를 사용하여 연마한다. 지판에 쓰일 목재를 사포를 사용하여 연마한다. 측정도구로 프레트(Fret)를 삽입할 홈을 측정하고 수동공구로 파낸다. 프레트를 삽입하고 절단도구로 절단한다. 사포로 연마하여 넥을 완성한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"기타철심홈가공원","dJobECd":"8851","dJobECdNm":"[8851]악기 제조원 및 조율사","dJobJCd":"7303","dJobJCdNm":"[7303]악기 제조 및 조율사","dJobICd":"C332","dJobICdNm":"[C332]악기 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005926:1', '{"dJobCd":"K000005926","dJobCdSeq":"1","dJobNm":"기타제작원","workSum":"기타를 제조하기 위해 목재를 가공하고, 부품을 성형하며 바니시, 셀락을 이용하여 도장하고 완성된 악기를 직접 연주하여 점검한다.","doWork":"앞·뒤판, 옆판, 넥에 쓰일 목재를 선별한다. 제조계획에 따라 나무에 형태를 도본(圖本)하고 띠톱, 대패 등 목공구를 사용해 일정한 두께로 가공하고 게이지로 두께를 측정한다. 측정도구를 사용하여 앞판에 구멍을 가공한다. 뒤판의 안쪽 면에 상목, 부챗살을 접착할 위치를 도본한다. 상목, 부챗살에 쓰일 목재를 선별하고 알맞은 크기로 성형한다. 도본한 위치에 접착하고 일정 시간 프레스한다. 접착된 상목, 부챗살을 목공구를 사용하여 알맞은 형태로 깎아낸다. 옆판에 쓰일 목재를 울림통 형태의 형틀을 한 열성형기에 투입한 후 레버를 조작하여 일정 시간 열을 가해 프레스한다. 옆판 조각을 나무 블록을 사용하여 접착시킨다. 앞·뒤판을 옆판에 접착한 후 고정공구로 일정 시간 고정시킨다. 넥을 제조하기 위해 목재를 수동공구를 사용하여 가공한다. 사포를 사용하여 앞면을 연마한다. 목공구를 사용하여 알맞은 곡률로 뒷면을 깎아낸다. 드릴을 사용하여 줄감개를 삽입할 구멍을 뚫는다. 지판에 쓰일 목재를 선별 후 수동공구를 사용하여 가공 후 연마한다. 지판을 넥에 접착하고 음쇠를 삽입할 홈을 가공한다. 울림통에 넥을 접착할 나무 블록을 접착 후 연마한다. 넥을 접착하고 지판에 음쇠를 삽입할 홈을 가공한다. 바니시, 셀락 등 도료를 사용하여 도장 후 일정 시간 건조시킨다. 앞판에 브리지를 접착할 홈을 깎아낸다. 브리지에 쓰일 목재를 선별 후 알맞은 형태로 가공한다. 브리지를 정해진 위치에 접착한다. 줄감개를 부착하고 현을 매달아 음을 조율한다. 완성된 악기를 직접 연주해 상태를 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"청각|손사용|시각|","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8851","dJobECdNm":"[8851]악기 제조원 및 조율사","dJobJCd":"7303","dJobJCdNm":"[7303]악기 제조 및 조율사","dJobICd":"C332","dJobICdNm":"[C332]악기 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004923:1', '{"dJobCd":"K000004923","dJobCdSeq":"1","dJobNm":"리드절삭원","workSum":"하모니카, 아코디언 등 리드악기의 떨림판을 만들기 위하여 황동판을 일정 두께로 절삭한다.","doWork":"절삭용 바이트를 절삭기에 고정, 바이스를 조정한다. 절삭한 재료의 끝을 가공이 용이하도록 L자로 구부린다. 회전 작업대에 재료를 부착, 기계 가동스위치를 누른다. 절삭기의 핸들을 돌려 재료를 일정 두께로 가공한다. 일정한 두께로 가공되었는지를 마이크로미터나 게이지를 사용해 수시로 확인한다. 가공이 끝난 재료를 운반상자에 담는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8851","dJobECdNm":"[8851]악기 제조원 및 조율사","dJobJCd":"7303","dJobJCdNm":"[7303]악기 제조 및 조율사","dJobICd":"C332","dJobICdNm":"[C332]악기 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001516:1', '{"dJobCd":"K000001516","dJobCdSeq":"1","dJobNm":"리드조정원","workSum":"멜로디언이나 하모니카 등 리드악기의 떨림판(Reed)을 조정한다.","doWork":"조명기로 떨림판이 부착된 플레이트(Plate:금속판)를 비춘다. 플레이트의 구멍과 떨림판(Reed)이 일치하지 않는 부분은 줄을 사용하여 연마한다. 떨림판을 튕겨서 이상이 있으면 지그(Jig:송곳 따위를 구멍 뚫을 위치에 정확히 갖다 대주는 공작기구)와 토크렌치를 사용하여 리드의 부착위치를 교정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"청각|손사용|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8851","dJobECdNm":"[8851]악기 제조원 및 조율사","dJobJCd":"7303","dJobJCdNm":"[7303]악기 제조 및 조율사","dJobICd":"C332","dJobICdNm":"[C332]악기 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002285:1', '{"dJobCd":"K000002285","dJobCdSeq":"1","dJobNm":"리코더조립원","workSum":"완성된 리코더 각 부분을 육안으로 점검하고 조립하는 업무를 수행한다.","doWork":"리코더 각 부품(두부관, 중부관, 족부관, 입마개 등)의 면을 사포로 다듬는다. 각 부품의 연결부위를 초음파접착기를 사용하여 조립한다. 조립한 리코더를 입으로 불어서 음정검사를 한다. 케이스에 리코더, 설명서, 소재봉 및 크림봉을 넣은 후 지퍼를 닫는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"청각|손사용|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","dJobECd":"8851","dJobECdNm":"[8851]악기 제조원 및 조율사","dJobJCd":"7303","dJobJCdNm":"[7303]악기 제조 및 조율사","dJobICd":"C332","dJobICdNm":"[C332]악기 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002697:1', '{"dJobCd":"K000002697","dJobCdSeq":"1","dJobNm":"목관악기제조원","workSum":"나무나 에보나이트 등의 비금속재료를 사용하여 목관악기를 제조한다.","doWork":"목관악기 제조에 필요한 재료를 준비한다. 선반, 연마기 등의 동력공구나 수공구를 사용하여 부품을 절삭 가공한다. 접착제와 나사못 등으로 각 부품을 고정한다. 악기를 시험하고 필요한 경우 음정을 조정한다. 금속부품을 만들기도 하고 특별한 형태의 목관악기를 만들기도 하며 수리를 하기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"청각|손사용|시각|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"8851","dJobECdNm":"[8851]악기 제조원 및 조율사","dJobJCd":"7303","dJobJCdNm":"[7303]악기 제조 및 조율사","dJobICd":"C332/C339","dJobICdNm":"[C332]악기 제조업 / [C339]그 외 기타 제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003914:1', '{"dJobCd":"K000003914","dJobCdSeq":"1","dJobNm":"악기수리원","workSum":"관악기, 현악기, 타악기 등의 파손된 부위를 정비 또는 교체한다.","doWork":"수리를 의뢰한 악기의 파손된 부위를 확인하기 위하여 악기를 연주하거나 소리를 점검한다. 분해가 가능한 악기는 드라이버 등을 사용하여 분해 후 결함 부품을 교체한다. 각종 접착제 등을 사용하여 틈이나 구멍 난 부위를 수리한다. 악기의 종류에 따라 연마 휠이나 광택공구를 사용하여 악기의 표면을 연마 또는 광택작업을 한다. 악기를 연주하며 원음으로 조율한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8851","dJobECdNm":"[8851]악기 제조원 및 조율사","dJobJCd":"7303","dJobJCdNm":"[7303]악기 제조 및 조율사","dJobICd":"S953","dJobICdNm":"[S953]개인 및 가정용품 수리업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001909:1', '{"dJobCd":"K000001909","dJobCdSeq":"1","dJobNm":"악기품질시험원","workSum":"우수한 품질의 악기를 제조하기 위하여 악기의 시험표준에 따라 원부자재와 제품을 시험기나 측정기로 시험한다.","doWork":"각종 시험표준에 따라 시험조건에 적합한 시험기나 측정기를 준비한다. 시험방법에 따라 시험기나 측정기를 조작하여 함수율 측정, 내건성, 내습성, 내후성, 내구성, 목재의 휨·틀어짐 등을 시험하고 시험성적표를 작성한다. 측정결과에 따라 작업장 내부의 온도, 습도를 조절한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"8851","dJobECdNm":"[8851]악기 제조원 및 조율사","dJobJCd":"7303","dJobJCdNm":"[7303]악기 제조 및 조율사","dJobICd":"C332","dJobICdNm":"[C332]악기 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002795:1', '{"dJobCd":"K000002795","dJobCdSeq":"1","dJobNm":"전자기타몸통가공원","workSum":"전자기타의 몸통을 가공하기 위해 수동공구로 목재를 가공한다.","doWork":"입고된 목재의 건조 상태를 확인한다. 작업계획서에 따라 목재를 도본한다. 수동공구를 사용하여 나무를 알맞은 형태로 가공한다. 내부 배선도를 확인하고 수동공구로 부품이 들어갈 자리를 깎는다. 측정도구로 치수를 측정하여 넥을 끼워 맞출 홈을 파낸다. 사포, 벨트연마기 등 연마도구를 사용하여 연마하여 몸통을 완성한다. 육안으로 완성된 몸통의 상태를 점검한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8851","dJobECdNm":"[8851]악기 제조원 및 조율사","dJobJCd":"7303","dJobJCdNm":"[7303]악기 제조 및 조율사","dJobICd":"C332","dJobICdNm":"[C332]악기 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;