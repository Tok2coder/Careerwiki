INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007112:1', '{"dJobCd":"K000007112","dJobCdSeq":"1","dJobNm":"돗자리제조원","workSum":"완초(왕골)나 짚을 엮어 돗자리를 제조한다.","doWork":"완초(왕골)나 짚을 손과 칼을 사용하여 일정 크기로 찢고 묶음으로 묶어 건조하고, 일정 수분을 유지하기 위해 이슬을 맞힌다. 완초를 염색하거나 일정 굵기로 만들기 위해 손으로 훑어서 펴거나 칼로 불순물을 긁어낸다. 무늬를 넣기 위해 손질된 완초를 염색한다. 고드래(쇠로 된 작은 실패)에 일정량의 나일론실을 감고 매듭을 지어 자리를 홈에 걸친다. 준비된 완초를 자리틀 위에 놓고 질이 낮은 완초를 안감으로 넣은 다음 고드래를 앞쪽이나 뒤쪽으로 넘겨 자리를 맨다. 염색한 완초를 사이사이에 넣어 경험이나 구상에 따라 무늬를 넣는다. 끝부분을 마무리하기 위해 칼을 사용하여 다듬고 접어 넣고 묶는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"용문석제조원, 인피석제조원, 화문석제조원","dJobECd":"8841","dJobECdNm":"[8841]공예원","dJobJCd":"7911","dJobJCdNm":"[7911]공예원","dJobICd":"C163","dJobICdNm":"[C163]코르크 및 조물 제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006164:1', '{"dJobCd":"K000006164","dJobCdSeq":"1","dJobNm":"모사공","workSum":"불화, 민화, 벽화, 풍속화 등 모사할 작품을 분석하여 현상모사, 복원모사, 고색복원모사 등 작업방법을 선정하고 모사의 형상과 색채를 분석하여 섬세한 선묘사를 하여 모사본을 제작한다.","doWork":"모사할 작품을 분석하여 현상모사, 복원모사, 고색복원모사, 부분모사 등 작업방법을 결정한다. 작품의 재료와 상태를 조사한다. 동일한 기법과 동일한 재료를 사용하여 작업을 한다. 작품의 제작 시에 먹선의 두께, 안료의 박락표현 등 매우 섬세하고 정밀하게 작업한다. 채색의 사용 시에는 원작에서의 재료를 정확히 파악하여 동일한 재료를 사용한다. 자문위원들과의 의견을 참조하여 작업의 결과를 조율한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"국가유산수리기능자(모사공)","dJobECd":"8841","dJobECdNm":"[8841]공예원","dJobJCd":"7911","dJobJCdNm":"[7911]공예원","dJobICd":"C339","dJobICdNm":"[C339]그 외 기타 제품 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003374:1', '{"dJobCd":"K000003374","dJobCdSeq":"1","dJobNm":"목조각원","workSum":"조각칼로 도안부분을 파서 목재에 문양을 조각한다.","doWork":"조각할 목재를 준비하고, 마름질 치수에 맞추어 톱으로 자르고 대패로 다듬는다. 조각할 도안을 목재표면에 모사한다. 도안형태의 선과 면을 분석하여 조각할 부분을 표시하고 외형에 조각도로 선을 긋는다. 평칼, 창칼, 삼각칼, 둥근칼 등 각종 조각칼을 사용하여 평면, 곡면, 곡선, 홈 등을 조각한다. 측정기로 측정하여 도면에 규정된 깊이로 조각면을 파낸다. 조각이 완료되면 조각칼이나 사포 등을 사용하여 다듬는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|시각|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"심조원, 목조각공, 목재조각원","connectJob":"양각원, 음각원","certLic":"목공예기능사, 국가유산수리기능자(목조각공)","dJobECd":"8841","dJobECdNm":"[8841]공예원","dJobJCd":"7911","dJobJCdNm":"[7911]공예원","dJobICd":"C320","dJobICdNm":"[C320]가구 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005925:1', '{"dJobCd":"K000005925","dJobCdSeq":"1","dJobNm":"물레성형원","workSum":"공예도자기나 소량의 도자기를 성형하기 위해 발이나 전동으로 물레를 돌려 기물을 성형한다.","doWork":"작업주문서에 따라 성형할 도자기 및 공예품의 모양과 크기, 규격을 확인한다. 물레(발물레, 손물레, 전동물레)의 작동 여부를 확인한다. 작업도구(곰방대, 도개, 방망이, 예세, 쫄데 등)를 준비한다. 반죽된 소지(점토, 흙덩어리)를 작업대 위에 놓고 적당량을 잘라 물레의 상부중심에 올려놓는다. 발로 밟거나 손으로 돌리거나 전동으로 물레를 회전시키며 물로 적신 손으로 소지를 만져서 성형체의 두께를 적당히 조절한다. 근계(곰방대 모양의 내부 다듬기)를 이용하여 내부를 매끄럽게 다듬고, 예세를 이용하여 성형물의 깊은 곳을 다듬으며 곰방대를 이용하여 주둥이가 길고 끝이 뾰족한 입구를 만들기도 한다. 목적하는 형태로 기물을 성형하기 위하여 물레를 회전시켜 성형을 완성한다. 성형된 기물을 적당히 건조시키고 반건조 상태에서 뒤집어 성형물의 밑부분이 갈라지지 않게 하기 위하여 굽부분을 칼로 잘라내는 굽깎기 작업을 한다. 성형체와 물레를 분리시키고, 굽부분을 칼로 다듬는다. 완성된 성형물을 그늘에 건조하기 위하여 지정된 장소에 적재한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|시각|","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"도자기공, 도공","certLic":"도자공예기능사","dJobECd":"8841","dJobECdNm":"[8841]공예원","dJobJCd":"7911","dJobJCdNm":"[7911]공예원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003629:1', '{"dJobCd":"K000003629","dJobCdSeq":"1","dJobNm":"부채제조원","workSum":"원단절단기, 재단용 칼 등을 사용하여 원단을 재단하고 수술, 매듭, 염주 등을 부착하여 부채를 제조한다.","doWork":"일반부채나 접부채를 만들기 위하여 면이나 실크, 종이 등의 원단을 원단절단기나 재단용 칼을 사용하여 부채꼴 모양으로 재단한다. 대나무를 제작할 부채 치수에 따라 기계나 칼로 절단하고 폭을 가늘게 다듬는다. 부채꼴로 재단한 원단 위에 접착제를 칠하고 제조된 부챗살을 일정 간격으로 배열하여 붙인다. 속살이 모아진 끝부분에 살이 떨어짐과 포개짐을 방지하기 위하여 조개지를 붙여 고정한다. 이 반제품을 압착기로 압착한 후에 건조기에 건조하거나 자연건조를 한다. 부채 손잡이에 수술이나 매듭, 염주 등의 장식용 끈을 달고 상표를 부착한다. 접부채를 제조할 경우에는 재단한 부채꼴 원단을 손으로 접어서 주름을 만드는 일을 하기도 한다. 완성된 부채에 그림을 그려 넣기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"접부채제조원, 합죽선제조원","certLic":"목공예기능사","dJobECd":"8841","dJobECdNm":"[8841]공예원","dJobJCd":"7911","dJobJCdNm":"[7911]공예원","dJobICd":"C162","dJobICdNm":"[C162]나무제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006315:1', '{"dJobCd":"K000006315","dJobCdSeq":"1","dJobNm":"상감원","workSum":"목공예품에 상감(象嵌)효과를 주기 위해 바탕목을 음각하여 상감재를 접착·조립한다.","doWork":"조각에 필요한 목재와 조각공구 및 실톱을 준비한다. 조각할 문양을 재료에 옮겨 그린다. 상감할 부위를 음각으로 조각한다. 상감재를 도안에 따라 실톱으로 잘라내고, 상감재를 바탕목에 맞춰 본다. 조각된 상감제에 접착제를 바른다. 상감재를 바탕목에 정확히 밀어넣고 망치로 가볍게 두드린다. 밀려 나오는 접착제를 물솔로 문질러 제거한다. 견고하게 접착되도록 클램프(죔쇠:Clamp)로 고정한다. 조각된 부위를 평칼로 다듬고 사포로 문지른다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|시각|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"양각원, 음각원","certLic":"목공예기능사","dJobECd":"8841","dJobECdNm":"[8841]공예원","dJobJCd":"7911","dJobJCdNm":"[7911]공예원","dJobICd":"C162","dJobICdNm":"[C162]나무제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004260:1', '{"dJobCd":"K000004260","dJobCdSeq":"1","dJobNm":"석고형제작원","workSum":"내화 제품이나 도자기 제품의 대량생산에 필요한 석고형을 제작한다.","doWork":"도면 및 작업표준서에 따라 환조석고형 또는 부조석고형의 종류와 규격 및 형태를 확인한다. 작업에 필요한 석고가루, 거즈, 주걱, 그릇 등 도구 및 공구를 준비한다. 도면을 파악하여 석고 형태와 사용될 석고 양을 파악한다. 적당량의 석고와 물을 계량하여 혼합하고 진공교반기로 교반한다. 환조석고형은 물레에 둘레막이를 하고 석고슬립(Slip:현탁액)을 붓는다. 석고가 굳은 후 둘레막이를 제거한다. 규격에 따라 성형된 석고기물을 칼을 사용하여 정형한다. 고운 사포로 마무리 작업을 하고 이형제(잘 떨어지게 도와주는 역할을 하는 물질)를 바른다. 완성된 원형 위에 다시 둘레막이를 하고 다시 석고슬립을 부어 사용형을 만든다. 완성된 사용형에 둘레막이를 하고 같은 방법으로 케이스형을 생산한다. 사용형 안쪽에 이형제를 바른 후 석고슬립을 부어 모형을 만들고 원형을 보관한다. 모형과 케이스형을 건조시킨 후 결합 부위를 맞추어 조립한다. 석고슬립을 만들어 모형과 케이스형의 주입구에 붓고 좌우로 흔들어 준다. 일정 시간이 경과되면 케이스형을 떼어내고 사용형을 빼내어 손질하고 건조시킨다. 부조석고형은 점토로 원형을 만들고 석고가 점토원형에서 잘 떨어질수 있도록 여러 조각으로 나눈 뒤 쪼갬볼(일반 플라스틱 종류)을 꽂는다. 점토원형에다가 석고를 발라 외형을 뜬다. 굳으면 쪼갬볼로 조각을 나눈 것이 안 깨지도록 점토원형조각을 빼낸다. 점토원형을 석고 외형에서 모두 제거한다. 외형 석고에 비눗물이나 규산(이탈제 역할)을 바른다. 외형 석고에 다시 석고슬립을 부어 내형을 만든다. 외형을 깨어 완성한다. 완성된 석고형은 보관하여 제품성형에 준비한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8841","dJobECdNm":"[8841]공예원","dJobJCd":"7911","dJobJCdNm":"[7911]공예원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006557:1', '{"dJobCd":"K000006557","dJobCdSeq":"1","dJobNm":"석제품제작원","workSum":"장식용 건축석재, 석상, 기념비, 장식품 등을 제작하기 위해 제품이 요구하는 규격과 주제에 알맞은 도안을 구상하고 작업계획을 수립하여 석제품을 제작한다.","doWork":"의뢰인과 제작할 제품의 용도, 주제, 표현방법, 재료의 크기, 재질, 색, 모양, 표현기법을 상담하고 작성한 제품도안을 협의하여 확정한다. 제품제작의 난이도, 재료의 크기 등을 고려하여 제작비용, 납기일을 산출하여 작업에 착수한다. 작업인원, 작업장비, 표면처리기법, 표현기법을 고려하여 작업계획을 수립한다. 석재의 가공 전 상태를 심미적으로 관찰하여 주제를 상정하기도 한다. 암석조각원, 석제품연마원, 석재절단기조작원, 석재천공원, 평삭기조작원, 할석원 등과 함께 석제품을 제작한다. 제품에 따라 모형을 제작하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"손사용|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"석제품디자이너","connectJob":"건축용석제품제작원, 기념비제작원, 석공예품제작원, 석상제작원","certLic":"석공예기능사","dJobECd":"8841","dJobECdNm":"[8841]공예원","dJobJCd":"7911","dJobJCdNm":"[7911]공예원","dJobICd":"C239","dJobICdNm":"[C239]기타 비금속 광물제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007029:1', '{"dJobCd":"K000007029","dJobCdSeq":"1","dJobNm":"선물큐레이터","workSum":"사회적이고 상대적인 관계나 상황 등을 고려해 선물을 기획, 제안, 추천, 제작, 포장, 디자인을 직접 수행하거나 기획조정한다.","doWork":"인터뷰, 사전조사, 데이터 분석 등을 통해 선물을 주고받는 대상, 시기, 상황, 관계, 이유 등을 파악한다. 파악한 내용에 따라 선물의 콘셉트, 스토리 등을 정하고 거기에 맞는 선물을 추천하거나 제작 여부를 검토한다. 기성품 혹은 제작을 의뢰할 수 있는 품목이 있는 경우 추천한다. 기성품으로 대체할 수 없는 경우 품목을 기획하여 제작한다. 여러 품목을 하나의 주제 또는 콘텐츠로 묶어 선물을 기획하거나 스토리텔링이 가능한 패키징 디자인을 기획, 제작해 선물하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"조정","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"기프트 큐레이터, 프레젠트 큐레이터, 선물 기획자, 선물 추천사, 기프트 스토리텔러","dJobECd":"8841","dJobECdNm":"[8841]공예원","dJobJCd":"7911","dJobJCdNm":"[7911]공예원","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2020"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004827:1', '{"dJobCd":"K000004827","dJobCdSeq":"1","dJobNm":"섬유공예가","workSum":"섬유 재료를 가공하고 가공된 소재로 섬유공예품을 만든다.","doWork":"디자인을 개발하고 섬유의 종류에 따라 재료를 선택한다. 원부자재의 특성을 파악하여 재료를 선택하고 조합한다. 소재별 가공제를 준비하고 소재를 균일하게 가공한다. 디자인에 따라 다양한 가공방법을 사용하여 제품을 완성한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"8841","dJobECdNm":"[8841]공예원","dJobJCd":"7911","dJobJCdNm":"[7911]공예원","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006237:1', '{"dJobCd":"K000006237","dJobCdSeq":"1","dJobNm":"수타성형원","workSum":"소량 다품종의 내화물을 성형하기 위해 압축공기와 나무해머로 압착하여 성형한다.","doWork":"작업지시에 따라 성형물의 종류와 규격, 형태를 확인한 후 성형에 필요한 배합토와 형틀을 준비한다. 혼합된 배합토를 삽으로 떠서 형틀에 투입한다. 에어레머(Airrammer:다짐기)를 작동하여 배합토를 압착하고, 나무망치로 두드려 배토를 밀어 넣는다. 흙손에 물을 발라 성형체의 노출된 표면을 매끄럽게 다듬는다. 형틀을 뒤집어 성형체와 형틀을 분리하고, 성형체에 제품의 치수를 표시한다. 성형된 내화물을 금속 적재판에 적재하여 건조 작업장으로 운반한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|시각|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"제형원","dJobECd":"8841","dJobECdNm":"[8841]공예원","dJobJCd":"7911","dJobJCdNm":"[7911]공예원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005079:1', '{"dJobCd":"K000005079","dJobCdSeq":"1","dJobNm":"슈가크래프터","workSum":"설탕가루를 반죽하여 색을 넣고 모양을 만들어 각종 기념일 케이크, 생활 소품 등을 만든다.","doWork":"개인, 웨딩업체, 돌잔치대행업체, 제과점 등으로부터 주문을 받는다. 설탕가루에 달걀흰자, 젤라틴 등의 재료를 섞어 목적에 맞는 반죽(Paste)을 만든다. 꽃을 만들어 장식하는 데에는 탄력 있고 힘 있는 반죽(Flower Paste)을, 각종 장식품을 올리는 데에는 좀 무른 반죽(Sugar Paste)을 만든다. 반죽에 식용색소를 첨가하고 각종 도구와 기법을 활용하여 케이크 위의 장식품을 만든다. 공방이나 문화센터, 요리학원 등에서 교육생을 대상으로 강의를 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"슈가크래프트아티스트(Sugarcraft Artist), 설탕공예가","certLic":"제과기능장, 제과기능사","dJobECd":"8841","dJobECdNm":"[8841]공예원","dJobJCd":"7911","dJobJCdNm":"[7911]공예원","dJobICd":"I561","dJobICdNm":"[I561]음식점업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003535:1', '{"dJobCd":"K000003535","dJobCdSeq":"1","dJobNm":"예술제본가","workSum":"보관할 가치가 있는 책을 보수 또는 복원하여 견고하고 아름답게 만드는 일을한다.","doWork":"출판사에서 특별히 의뢰한 제본, 성경(성경 필사본) 제본, 개인저작물 제본 등을 주문 받는다. 의뢰자와 제본 방향에 대해 의논한다. 제본할 책이 결정되면 기존의 책을 분해해 나누고 묶음으로 나뉜 책들의 등 부분이 찢어졌거나 지저분해지지 않았는지 확인해 이를 고르게 정리한다. 정리한 책 묶음을 프레스기(압축기계)에 넣고 최대한 부피를 압축해 누른다. 재단기로 모서리 부분을 고르게 자른다. 책 등에 구멍을 뚫는다. 구멍을 실로 꿰맨다. 꿰맨 부분이 보이는 책 등을 둥글리고 책과 판지를 연결한다. 비단실로 종이심을 감아서 엮는다. 책의 등과 표지를 평평하게 하기 위해 사포로 갈아 낸다. 가죽의 접는 부분을 얇게 갈아서 표지를 싼다. 표지와 본문 사이에 면지를 붙여서 마무리한다. 사진, 일러스트, 판화작품 등을 견고한 포트폴리오로 만들기도 한다. 박물관에서 전시되는 고서적을 복원하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"8841","dJobECdNm":"[8841]공예원","dJobJCd":"7911","dJobJCdNm":"[7911]공예원","dJobICd":"C181","dJobICdNm":"[C181]인쇄 및 인쇄관련 산업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004431:1', '{"dJobCd":"K000004431","dJobCdSeq":"1","dJobNm":"외국민속공예가","workSum":"가구나 생활용품을 다른 나라의 전통 문양이나 색으로 장식하여 민속공예품을 제작한다.","doWork":"MDF(중간 정도의 밀도와 두께를 가진 합판)나 그밖에 나무로 된 제품에 석고가루를 개어 놓은 젯소(페인트나 물감을 바르기 전 표면을 평평하게 만들어주는 것)를 칠한다. 표면을 부드럽게 만들기 위해 사포로 문지른다. 사포로 문지른 다음엔 원하는 색상으로 바탕색을 칠한 뒤 직물을 재단할 때 사용하는 초크펜을 이용해 밑그림을 그리거나 먹지를 사용해 밑그림을 옮기기도 한다. 밑그림을 기초로 브러시를 이용해 그림을 그린 뒤 마감재를 칠한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"포크아티스트","dJobECd":"8841","dJobECdNm":"[8841]공예원","dJobJCd":"7911","dJobJCdNm":"[7911]공예원","dJobICd":"C162","dJobICdNm":"[C162]나무제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005357:1', '{"dJobCd":"K000005357","dJobCdSeq":"1","dJobNm":"원형제작원","workSum":"개발 또는 주문된 형태 중 원기둥의 변형체를 제외한 모든 원형도자기류 및 요업제품류를 만든다.","doWork":"작업명세서에 따라 성형할 원형물의 규격과 형태를 확인한다. 원형 제작에 필요한 공구와 재료(점토, 석고)를 준비한다. 주어진 도면의 형상과 규격에 맞추어 손으로 빚거나 조각도로 조각하여, 도면과 일치하는지 확인하며 원형을 제작한다. 완성된 성형물을 다음 공정을 위하여 이송한다. 공구와 작업대를 세척하여 정돈한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|시각|","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"도자공예기능사","dJobECd":"8841","dJobECdNm":"[8841]공예원","dJobJCd":"7911","dJobJCdNm":"[7911]공예원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003437:1', '{"dJobCd":"K000003437","dJobCdSeq":"1","dJobNm":"유약처리원","workSum":"성형된 제품의 전면 또는 일부 면에 고르게 색상을 입히기 위하여 성형품에 유약을 입힌다.","doWork":"작업주문서에 따라 시유물의 종류와 형태, 규격을 확인한다. 소량의 자기제품에 시유작업을 위해 성형물에 맞는 청자유, 진사유 등의 색유 및 이장으로 만든 유약을 준비한다. 유약 및 색유의 색깔과 점성상태를 확인한다. 시유작업에 필요한 공구를 준비하여 작업대에 정리하여 놓는다. 유약통에 성형물이 충분히 잠길 정도로 유약을 붓는다. 시유할 반제품에 묻은 먼지를 압축공기나 솔로 제거하고 성형하여 건조된 또는 초벌구이공정을 마친 시유할 제품을 담궈 소지의 흡수성을 이용하여 소지체 표면에 유약을 입혀 시유한다. 시유된 면을 긁어 시유된 두께를 확인한다. 시유두께가 알맞으면 손이나 집게로 성형품을 집어 유약에 담근 후 꺼내어 철망 위에 올려놓아 그늘에서 자연 건조시킨다. 오목한 부분에 고여 있는 유약은 붓으로 닦아낸다. 유약이 손에 묻어나지 않을 정도로 건조되면 물에 적신 스펀지 위에 올려놓고 굽에 묻은 유약을 닦아낸다. 널빤지 위에 시유된 제품을 배열하고, 적재판 위에 올려놓는다. 건조가 완료되면 시유 및 건조를 2~3회 반복한다. 작업이 완료되면 시유된 성형물을 그늘에 적재하여 건조한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"시유원","certLic":"도자공예기능사","dJobECd":"8841","dJobECdNm":"[8841]공예원","dJobJCd":"7911","dJobJCdNm":"[7911]공예원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005086:1', '{"dJobCd":"K000005086","dJobCdSeq":"1","dJobNm":"음식물모형제작원","workSum":"화학원료를 사용하여 본을 뜨고, 색칠을 하여 음식물 모형을 실제와 흡사하게 만든다.","doWork":"제작될 음식물 모양을 확인하기 위해 점포를 직접 방문하거나 음식물을 인수 받는다. 음식의 형태를 잡은 후 염화비닐 수지, 실리콘 등을 부어 본을 뜬다. 음료와 같이 시간이 지나면 색이 변하는 음식의 경우에는 사진을 찍어두며 제작 시 활용한다. 대상물이 없는 경우에는 경험을 바탕으로 스케치하여 본을 만든다. 다량을 제작해야 하는 경우 금형을 의뢰한다. 음식물의 특징에 따라 기본재료를 달리 선택하여 제작하고, 음식물 모형의 표면을 유연하게 만들기 위해 합성재질과 석유 혹은 신나 등을 첨부한다. 제작할 모형에 따라 두께를 조절하고, 오븐의 온도와 시간을 맞춘다. 오븐에서 꺼낸 모형을 유화물감 등을 사용하여 색칠한다. 소재 개발을 위해 시장조사를 하고, 정보를 수집한다. 정교함이 요구되는 모형의 경우 조각사에게 의뢰하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"대기환경미흡|위험내재|고온|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"푸드모델스타일리스트","dJobECd":"8841","dJobECdNm":"[8841]공예원","dJobJCd":"7911","dJobJCdNm":"[7911]공예원","dJobICd":"C339","dJobICdNm":"[C339]그 외 기타 제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002825:1', '{"dJobCd":"K000002825","dJobCdSeq":"1","dJobNm":"자개세공원","workSum":"각종 공구를 사용하여 조개껍질을 여러 가지 모양으로 가공하고 목재 또는 금속재료 표면에 붙여 장식할 수 있도록 제작한다.","doWork":"조개껍질을 선별하여 표면을 그라인더로 갈아 두께를 일정하게 한다. 일정한 넓이로 선을 긋고 기계톱으로 선을 따라 절단한다. 절단한 양면을 연삭기로 깎고 내면을 그라인더로 연마한다. 일정한 크기로 연마되면 실톱을 사용하여 새나 사슴, 나무 등의 여러 가지 모양으로 가공한다. 미리 본을 그려둔 기름종이 등의 얇은 종이에 풀을 바르고 가공한 자개를 손으로 붙인다. 종이에 붙인 자개에 아교 등의 접착제를 발라서 문짝 등의 백골에 부착하여 무늬를 만든다. 완전히 부착되면 종이에 물을 흥건히 적시어 종이를 손으로 떼어낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|시각|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"나전원, 자개부","dJobECd":"8841","dJobECdNm":"[8841]공예원","dJobJCd":"7911","dJobJCdNm":"[7911]공예원","dJobICd":"C320","dJobICdNm":"[C320]가구 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004406:1', '{"dJobCd":"K000004406","dJobCdSeq":"1","dJobNm":"장난감모형제작원","workSum":"각종 기계와 수동공구를 사용하여 제조하고자 하는 장난감의 모형을 제작한다.","doWork":"설계도면의 명세서에 따라 알루미늄, 나무, 섬유유리 등의 재료를 선택한다. 측정 및 제도기구를 사용하여 재료 위에 부품의 모양을 그린다. 사용할 수지의 형판을 도안하고 각종 성형기계로 형을 만든다. 부품을 절단·성형·연마하기 위해 주물기계, 드릴프레스, 선반, 밀링기계, 플라스틱성형기, 연마기 등 각종 기계를 조작한다. 아교, 볼트, 못, 꺾쇠 등을 사용하여 부품을 조립하고 고정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"장난감모델러, 프라모델러","dJobECd":"8841","dJobECdNm":"[8841]공예원","dJobJCd":"7911","dJobJCdNm":"[7911]공예원","dJobICd":"C334","dJobICdNm":"[C334]인형, 장난감 및 오락용품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005281:1', '{"dJobCd":"K000005281","dJobCdSeq":"1","dJobNm":"전동물레성형원","workSum":"제품 생산에 필요한 석고형을 기계의 물레에 장치하고 성형칼을 사용하여 기물을 성형한다.","doWork":"작업지시서에 따른 대칭형 형태를 대량으로 만들기 위하여 성형물의 종류와 규격 및 형태를 확인한다. 빗칼, 전잡이, 스펀지 붓 등 작업에 필요한 도구를 준비하고 전동물레의 작동상태를 점검한다. 석고형을 물레의 받침틀 위에 중심을 맞추어 올려놓고 제품규격에 맞추어 석고형과의 간격을 조정하고 성형손잡이에 성형칼을 고정한다. 전동물레의 스위치를 가동한다. 반죽된 소지토를 적당량 잘라내어 석고형 바닥에 밀착되도록 밀어 넣는다. 손으로 성형칼을 서서히 내려 소지토에 대고 성형을 한다. 붓에 물을 묻혀 성형되는 소지 위에 한두 방울 떨어뜨려 성형체의 표면을 매끄럽게 한다. 석고형 위로 올라온 소지토는 가는 철사로 잘라낸다. 성형이 끝나면 성형칼을 들어 올리고 페달을 놓아 물레를 정지시킨다. 석고형에 성형된 기물을 석고형과 함께 물레에서 들어낸다. 기물 밑 부분이 갈라지는 것을 방지하기 위하여 굽깎기작업을 한다. 완성된 성형물을 1차 소성공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"도자공예기능사","dJobECd":"8841","dJobECdNm":"[8841]공예원","dJobJCd":"7911","dJobJCdNm":"[7911]공예원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004061:1', '{"dJobCd":"K000004061","dJobCdSeq":"1","dJobNm":"전사지부착원","workSum":"손이나 기계장치로 문양을 그려 넣기 힘든 복잡한 형상의 도안이나, 대량생산이 필요한 경우 종이나 비닐에 인쇄한 전사지를 이용하여 장식할 수 있도록 기물에 전사지를 부착한다.","doWork":"작업지시서에 따라 2차 장식 후 재벌구이공정을 끝낸 전사할 도자기의 종류 및 규격, 형태 등을 확인하고 장식할 도자기에 맞는 전사지를 준비하여 전사지를 부착할 위치 및 주의사항을 확인한다. 전사지 부착에 필요한 붓, 물통 등의 공구를 준비한다. 전사지를 부착할 위치를 확인한 후 전사지를 도자기의 부착부위에 구겨지지 않도록 주의하여 올려놓는다. 붓에 물을 묻혀 전사지 위에 칠한다. 염료가 장식할 도자기의 표면에 묻어나면 전사지 종이를 묻혀 전사지 종이를 떼 낸다. 전사지 부착작업이 끝난 도자기를 적재함에 올려놓는다. 비닐전사지 사용 시에는 전사지에 물을 묻혀 부착한 후, 도구(스퀴즈)를 이용하여 물기를 제거한 다음에 바로 전사지 소성공정으로 이송한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"전사장식원","certLic":"도자공예기능사","dJobECd":"8841","dJobECdNm":"[8841]공예원","dJobJCd":"7911","dJobJCdNm":"[7911]공예원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001321:1', '{"dJobCd":"K000001321","dJobCdSeq":"1","dJobNm":"정형원","workSum":"성형된 도자기류의 표면을 손으로 매끄럽게 다듬는다.","doWork":"작업지시서에 따라 정형할 도자기의 종류와 정형부위 및 방법 등을 확인한다. 성형된 반제품을 운반하여 회전판에 올려놓는다. 회전하는 성형된 기물을 검사하고 흠이나 형틀자국 등을 손칼이나 연마포로 다듬는다. 스펀지나 거즈에 물을 묻혀 성형된 기물을 닦는다. 정형이 완료되면 최종 정형검사를 한다. 파손된 제품은 별도로 분리해 낸다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"다습|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"도자공예기능사","dJobECd":"8841","dJobECdNm":"[8841]공예원","dJobJCd":"7911","dJobJCdNm":"[7911]공예원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006659:1', '{"dJobCd":"K000006659","dJobCdSeq":"1","dJobNm":"조화제작원","workSum":"천이나 종이, 비닐 등의 재료를 이용해 잎, 줄기 등의 모양을 만든 후 이를 조립해 조화(造花)를 만든다.","doWork":"제조하고자 하는 조화 형태에 따른 금형을 준비한다. 폴리에틸렌(Poly-etylene:열가소성 플라스틱의 일종)에 안료를 넣고 막대기로 저어 혼합한다. 착색된 원료를 사출기의 호퍼(Hopper)에 부어 넣는다. 조화 형태에 따라 금형을 사출기에 부착한다. 사출된 반제품을 손이나 꼬임기를 사용하여 잎, 줄기 등의 모양에 따라 조립한다. 조립한 완제품을 육안으로 검사하여 완성품은 비닐포장지로 포장한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"천조화제작원","dJobECd":"8841","dJobECdNm":"[8841]공예원","dJobJCd":"7911","dJobJCdNm":"[7911]공예원","dJobICd":"C339","dJobICdNm":"[C339]그 외 기타 제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006649:1', '{"dJobCd":"K000006649","dJobCdSeq":"1","dJobNm":"죽제품제조원","workSum":"바구니, 소쿠리, 장식용 죽세공품 등을 제작하기 위해 대나무를 절단하고 편조한다.","doWork":"톱 등 수동공구를 사용하여 제작할 제품의 치수에 맞추어 대나무를 절단하고 칼이나 대패로 절단된 대나무의 마디를 다듬는다. 칼로 대나무를 일정 치수로 쪼갠다. 대나무의 속을 벗겨 내고 쪽 고르기와 면을 다듬어 일정한 폭과 두께로 만든다. 제작할 죽제품의 형에 맞추어 일정한 순서로 편조한다. 삐져나온 대살은 작은 칼이나 가위로 잘라 안으로 끼워 넣는다. 손잡이나 다리 등의 부분품을 붙이기도 하고, 심재를 끼워 형태를 보강하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"죽공예원, 죽제품편조원","connectJob":"대바구니제작원, 대소쿠리제작원, 장식용죽제품제작원, 죽부인제작원","certLic":"목공예기능사","dJobECd":"8841","dJobECdNm":"[8841]공예원","dJobJCd":"7911","dJobJCdNm":"[7911]공예원","dJobICd":"C162","dJobICdNm":"[C162]나무제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004321:1', '{"dJobCd":"K000004321","dJobCdSeq":"1","dJobNm":"지리모형제작원","workSum":"종이나 기타 재료를 사용해 입체적인 지세나 지층을 표현하면서 지리모형(지형모형)을 제작한다.","doWork":"원본지도를 복사한다. 사본지도의 밑에 우드락을 깔고 그 사이에 먹지를 놓는다. 지도의 등고선 모양을 따라서 볼펜으로 그린다. 지도의 등고선별로 하나씩 같은 작업을 반복하고 그려진 우드락에는 등고선 높이나 일련번호 등을 표시해 분류한다. 그려진 등고선 모양에 따라 특수한 인두나 칼로 우드락을 오려낸다. 오려낸 우드락을 큰 것부터 아래에 놓고 접착제를 이용해 순서대로 합판에 붙여 올려 바다와 육지, 산 등의 굴곡 및 고저를 만든다. 계단모양의 층계가 생긴 부분은 종이를 풀과 혼합하여 고랑진 곳을 메우고 건조시킨다. 건조된 모형은 도장과 채색을 하여 완성한다. 오토캐드(AutoCAD)와 3D 컬러 프린터를 이용해서 디오라마(Diorama)의 지형을 만들기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|시각|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"입체지도원","certLic":"제품응용모델링기능사","dJobECd":"8841","dJobECdNm":"[8841]공예원","dJobJCd":"7911","dJobJCdNm":"[7911]공예원","dJobICd":"C339","dJobICdNm":"[C339]그 외 기타 제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005950:1', '{"dJobCd":"K000005950","dJobCdSeq":"1","dJobNm":"철물공","workSum":"문화재 원형 보존을 위해 철물들의 제작과 보수, 그리고 그 외 다른 업무를 수행한다.","doWork":"용도에 따라 도면과 목공, 창호, 지붕철물 등으로 구분하고 적절한 사용법을 확인한다. 문화재 수리, 복원 시 분실되거나 파손되어 재사용이 불가한 것은 재질, 모양, 규격, 색상 마무리 정도 등을 기존 철물의 형태에 따라 제작한다. 창호, 성문 등에 사용하는 철물이 지지력과 기능상의 문제가 있는 경우에는 담당원의 승인을 받아 문화재와 조화되는 철물로 보강한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"대장장이","certLic":"문화재수리기능자(철물공)","dJobECd":"8841","dJobECdNm":"[8841]공예원","dJobJCd":"7911","dJobJCdNm":"[7911]공예원","dJobICd":"C259","dJobICdNm":"[C259]기타 금속 가공제품 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006783:1', '{"dJobCd":"K000006783","dJobCdSeq":"1","dJobNm":"축소모형설치원","workSum":"배경 및 특수효과를 영상화하는 데 사용되는 영화제작용세트(무대장치)의 축소모형장치(Miniature Set)를 설치한다.","doWork":"촬영하는 범위와 규모에 따라 축소모형의 비율을 결정하고 설계한다. 설계도에 따라 수동공구를 사용하여 목재, 플라스틱 등 재료를 규격대로 절단한다. 아교, 못, 압정 등을 사용하여 절단한 재료를 조립한다. 모형이 완성되면 사포를 사용하여 거친 부분을 연마하고 페인트로 도장한다. 나무, 덤불 등의 효과를 연출하기 위하여 점토, 실, 석고 등을 사용하여 모형을 제작하고 스프레이형 페인트로 도장한다. 축소모형의 주변에 나무, 덤불 등을 적절히 배치하여 무대장치와 똑같은 효과를 연출한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|시각|","workEnv":"대기환경미흡|위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"제품응용모델링기능사","dJobECd":"8841","dJobECdNm":"[8841]공예원","dJobJCd":"7911","dJobJCdNm":"[7911]공예원","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005668:1', '{"dJobCd":"K000005668","dJobCdSeq":"1","dJobNm":"칠공예가","workSum":"옻칠을 통해 다양한 공예품을 채색한다.","doWork":"목재나 진흙 등의 기물 위에 옹이나 흠이 난 곳을 고운 톱밥과 생칠 등으로 표면을 고르고 생칠을 묽게 바른다. 다시 생칠과 찹쌀풀을 섞어 베나 모시헝겊으로 천바르기를 한다. 숯가루와 패분의 혼합물을 칠과 섞어 천의 눈매를 메운 후 갈아낸다. 정제칠과 초벌칠을 한다. 칠하기를 반복하고 건조시킨 후 닦아내고 문질러 광을 낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"칠공","certLic":"문화재수리기능자(칠공)","dJobECd":"8841","dJobECdNm":"[8841]공예원","dJobJCd":"7911","dJobJCdNm":"[7911]공예원","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007222:1', '{"dJobCd":"K000007222","dJobCdSeq":"1","dJobNm":"테라코타형틀제작원","workSum":"테라코타(Terra Cotta)를 성형하기 위해 석고 형틀을 제작한다.","doWork":"성형할 테라코타(Terra Cotta:진흙으로 구워 만든 토기)의 원형에 따라 석고형틀의 모양 및 크기를 계산하고 확인한다. 작업에 필요한 석고분말과 목재 형틀, 점토 등 부자재와 도구를 준비한다. 목재 형틀 속에 점토를 채우고 점토 표면을 형판으로 밀어 제품의 전·후·측면의 형을 뜬다. 굳어진 형 위에 비눗물 등 분리제를 칠하고 반죽한 석고를 부어서 형틀을 제작한다. 석고가 완전히 경화되면 전·후·측면의 석고를 결합하고 결합부분을 봉합하고 다듬는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"도자공예기능사","dJobECd":"8841","dJobECdNm":"[8841]공예원","dJobJCd":"7911","dJobJCdNm":"[7911]공예원","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005878:1', '{"dJobCd":"K000005878","dJobCdSeq":"1","dJobNm":"토피어리디자이너","workSum":"물이끼(수태)와 각종 식물을 이용하여 동물이나 새, 캐릭터 등 모형을 제작한다.","doWork":"만들고자 하는 토피어리(Topiary:자연 그대로의 식물을 여러 가지 동물 모양으로 자르고 다듬어 보기 좋게 만드는 기술 또는 작품)의 주제 및 모형을 구상한다. 제작의뢰가 들어올 경우 고객이 어떠한 작품을 원하는지 상담하고, 아이디어 회의를 하거나 디자인을 결정한다. 직접 디자인을 그리거나 컴퓨터 3D그래픽 프로그램을 이용하여 디자인한다. 디자인에 따라 철사를 이용해 모형 틀을 제작한다. 수태(물에서 자라는 이끼)를 채우고 관수시설이나 실내외 용도에 적합한 식물을 심어 모형을 완성한다. 공원이나 박람회 등에 전시할 경우 토피어리를 현장으로 옮긴 후 설치한다. 토피어리가 손상된 경우 손상된 부위만 다시 식재한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"모스토피어리디자이너","dJobECd":"8841","dJobECdNm":"[8841]공예원","dJobJCd":"7911","dJobJCdNm":"[7911]공예원","dJobICd":"A011","dJobICdNm":"[A011]작물 재배업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002216:1', '{"dJobCd":"K000002216","dJobCdSeq":"1","dJobNm":"표구장","workSum":"작품을 감상하고 보존, 보관 등을 위해 그림과 글씨, 자수, 탁본작품 등에 종이나 비단 등을 붙여 병풍, 액자, 족자, 서화첩, 포갑 등을 제작한다.","doWork":"제작 형태에 따라 수행직무가 상이하나 병풍의 경우는 다음과 같다. 목공구를 사용하여 나무로 병풍틀과 테를 짠다. 틀에 초배를 하고 돌쩌귀를 붙여 틀을 연결한다. 연결한 병풍틀 안쪽, 작품을 붙일 면에 띄어 붙이기를 한다. 서화 등의 작품을 배접하여 건조대에 붙여 말린다. 작품의 미적 가치를 높일 수 있는 무늬와 색을 갖춘 비단을 선택하여 틀에 맞추어 재단한다. 틀에 작품을 풀로 붙이고 작품 둘레에 재단한 비단을 풀로 붙인다. 틀의 바깥 면과 둘레에 광목을 붙인다. 작품과 비단을 붙인 면에 색지나 비단을 사용하여 외선을 붙인다. 병풍틀 둘레에 테를 못으로 박아 고정시킨다. 병풍, 액자, 족자 등을 제작하는 것 외에도 낡거나 훼손된 작품의 보완과 재생작업도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"표구공, 배첩장, 표구장, 장황공","certLic":"문화재수리기능자(표구공)","dJobECd":"8841","dJobECdNm":"[8841]공예원","dJobJCd":"7911","dJobJCdNm":"[7911]공예원","dJobICd":"C339","dJobICdNm":"[C339]그 외 기타 제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003128:1', '{"dJobCd":"K000003128","dJobCdSeq":"1","dJobNm":"한지제조원","workSum":"전통 한지(韓紙)를 만들기 위하여 닥나무로 종이를 떠서 가공한다.","doWork":"지통에 물과 원료를 넣고 막대로 잘 저어 고르게 분산시킨 후 섬유끼리의 분산과 종이 뜰 때 발에서 물 빠짐을 조절할 수 있도록 닥풀즙(황초기뿌리의 액)을 넣고 다시 잘 저어 준다. 지통에 발을 담가 전·후·좌·우로 흔들어 종이를 떠내고, 떠낸 종이 사이에는 베게(왕골, 합성수지 끈 등의 재질로 떠낸 종이 사이사이에 끼워서 한 장씩 종이를 떠내기 쉽게 한 것)를 끼워서 나중에 한 장씩 떠내기 쉽게 한다. 떠낸 종이를 쌓아가다가 일정한 높이가 되면 널빤지 사이에 넣은 후, 무거운 돌이나 지렛대를 사용해 물을 빼준다. 종이의 사용 목적에 따라 약간 덜 마른 종이를 포개거나 풀칠을 하여 붙여 디딜방아나 방망이로 두들겨서 종이가 치밀하고 매끄러우며 윤기가 나도록 한다. 자연소재인 식물의 뿌리, 줄기, 잎 등에서 얻는 천연염료를 물에 끊여 종이를 각종 색상으로 염색한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"손사용|","workEnv":"다습|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"한지제지원","dJobECd":"8841","dJobECdNm":"[8841]공예원","dJobJCd":"7911","dJobJCdNm":"[7911]공예원","dJobICd":"C171","dJobICdNm":"[C171]펄프, 종이 및 판지 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002308:1', '{"dJobCd":"K000002308","dJobCdSeq":"1","dJobNm":"화공","workSum":"전통한식 기법으로 단청문양(丹靑紋樣), 별화(別畵), 벽화(壁) 등을 목조구조물이나 벽 등에 채색한다.","doWork":"단청문양의 퇴락 상태와 기존 문양조사를 위한 현장조사를 한다. 단청문양의 초본도, 모사도 및 견본도를 작성한다. 출초, 조채 및 접착제를 조합한다. 단청을 위해 면 닦기, 물씻기 및 건조 등 바탕면을 만든다. 바탕면에 시공 전에 아교를 2회 이상 충분히 포수한다. 가칠(바탕칠), 타분(타초), 채색(시채), 먹기화(시분), 분점찍기 등 채색을 한다. 도채완료후전반적인상태를점검하고빛이나 선이빠졌거나잘못된부분은수정하고보완한다. 우기 시를 제외하고 빗물이들이치는기둥과 같은 부분에 2회 이상 들기름을도포한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"손사용|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"단청원, 화원, 단청화원, 단청화공","connectJob":"특수화공(불화원, 별화원, 벽화원)","certLic":"문화재수리기능자(화공)","dJobECd":"8841","dJobECdNm":"[8841]공예원","dJobJCd":"7911","dJobJCdNm":"[7911]공예원","dJobICd":"F411","dJobICdNm":"[F411]건물 건설업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003271:1', '{"dJobCd":"K000003271","dJobCdSeq":"1","dJobNm":"화훼장식가","workSum":"꽃을 포장하여 판매하거나 행사장에 화훼장식을 하는 등 용도에 적합하고 아름답게 꽃을 연출한다.","doWork":"도매업체로부터 화훼를 구입하여 소비자에게 판매한다. 판매량과 재고량을 파악하여 필요한 화훼를 주문한다. 화훼가 시들지 않도록 적정한 온도와 습도를 갖추어 보관한다. 화훼에 물을 주고 관리한다. 화훼에 대한 지식을 기초로 고객의 의도, 목적에 알맞은 꽃을 추천한다. 분재가위를 사용하여 화훼를 적당한 크기로 자르고, 줄, 포장지, 상자, 받침대 등으로 꽃바구니 및 화환을 만들거나 장식한다. 화훼장식을 한 후 해당 장소로 운반하거나, 행사장에서 직접 화훼를 장식한다. 행사의 특성을 살펴 장식계획을 세운다. 고객과 협의하여 행사장에 화훼를 장식한다. 행사 중에 화훼장식을 유지·관리하며, 행사가 끝나면 직접 철거한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"플라워디자이너, 플라워코디네이터, 플로리스트","connectJob":"꽃판매원","certLic":"화훼장식기사, 화훼장식산업기사, 화훼장식기능사","dJobECd":"8841","dJobECdNm":"[8841]공예원","dJobJCd":"7911","dJobJCdNm":"[7911]공예원","dJobICd":"G478","dJobICdNm":"[G478]기타 상품 전문 소매업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002649:1', '{"dJobCd":"K000002649","dJobCdSeq":"1","dJobNm":"활제조원","workSum":"궁도용 활을 제조하고 탄력을 검사한다.","doWork":"제조하고자 하는 활의 형태에 맞는 작업대를 골라서 프레스기에 볼트로 조인다. 압착프레스와 활 안쪽에 접착제가 묻지 않도록 종이를 깐다. 적층가공을 하기 위해 절단한 목재 및 섬유유리 부분품에 에폭시 수지를 바른다. 활날개 전체를 고정, 압착시키기 위해 프레스 사이에 있는 공기튜브에 공기를 주입한다. 활의 윤곽선을 성형하기 위해 가열히터에 전원을 넣고 일정 시간 동안 활을 열처리한다. 연마휠과 사포지를 사용하여 활고자(활채의 끝에 시위를 거는 부분)를 일정한 모양으로 연마한다. 활이 뒤틀리거나 휘어진 상태를 육안으로 검사한다. 용수철 저울이나 측정기구를 사용하여 활의 탄력을 검사한다. 동력광택기구를 사용하여 검사가 끝난 활을 깨끗이 닦는다. 활 몸체에 탄력정도, 분류기호 등을 기입하고 무늬·실크인쇄를 넣어 장식한다. 활의 표면을 보호하기 위해 스프레이로 니스칠을 한다. 손잡이와 활날개 부분을 접착제를 사용하여 결합한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"양궁제조원","connectJob":"활날개접착원, 활도장원, 활면연마원, 활조립원, 석궁제조원","dJobECd":"8841","dJobECdNm":"[8841]공예원","dJobJCd":"7911","dJobJCdNm":"[7911]공예원","dJobICd":"C333","dJobICdNm":"[C333]운동 및 경기용구 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003649:1', '{"dJobCd":"K000003649","dJobCdSeq":"1","dJobNm":"국가유산수리도금공","workSum":"유물, 기물, 불상 등에 금박이나 금가루를 입혀서 장식한다.","doWork":"도금이 입혀질 부분에 초칠(옻칠)한다. 마른 다음 연마질을 해 면을 고르게 한다. 2차 칠을 한 다음 모시배접을 한다. 토화칠(옻+황토+찹쌀) 로 눈매 메우기를 1회, 2회, 3회 한다. 연한 옻칠을 하고 마른 후 연마질을 2~3회 반복하여 한다. 면을 매끈하게 잡는다. 그 위에 상칠을 1회 한 다음 연마질 후 또 상칠하고 꾸들꾸들 마르면 금박을 입힌다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"대기환경미흡|위험내재|다습|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"도금공, 수은도금공, 옻칠도금공","certLic":"국가유산수리기능자(도금공)","dJobECd":"8842","dJobECdNm":"[8842]귀금속·보석 세공원","dJobJCd":"7912","dJobJCdNm":"[7912]귀금속 및 보석 세공원","dJobICd":"C331","dJobICdNm":"[C331]귀금속 및 장신용품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002850:1', '{"dJobCd":"K000002850","dJobCdSeq":"1","dJobNm":"귀금속가공원","workSum":"금, 은 등 귀금속을 제품으로 만들기 위해 형태에 따라 금선, 백금선, 은선 등으로 성형한다.","doWork":"금, 백금, 은 등의 금속선을 토치로 달군다. 작업하려는 형태에 따라 뾰족한 끝부분을 다이 구멍에 끼워넣는다. 구멍 틀을 통과한 철선을 손으로 잡아당겨 원형, 반원형, 정사각형 또는 직사각형의 선을 성형한다. 공구를 사용하여 선의 표면에 장식도안을 음각하거나 양각롤러가 장치된 선 인출기를 사용하여 양각장식무늬를 새긴다. 리본 모양의 선을 인출·성형하고 양각하기 위해 롤링기를 조작한다. 마이크로미터를 사용하여 인출된 철선의 치수를 측정한다. 롤링기의 압력롤러 사이에 귀금속을 놓는다. 롤러 사이의 거리를 조정하기 위해 핸들과 눈금시계를 돌린다. 레버를 조작하여 롤링기를 시험 가동한다. 롤링기를 통과한 귀금속을 게이지로 두께를 측정한다. 작업표준서와 두께가 다르면 압력롤러를 재조정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"대기환경미흡|고온|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"귀금속인발원, 귀금속전박원","certLic":"귀금속가공기능장, 귀금속가공기능사, 귀금속가공산업기사","dJobECd":"8842","dJobECdNm":"[8842]귀금속·보석 세공원","dJobJCd":"7912","dJobJCdNm":"[7912]귀금속 및 보석 세공원","dJobICd":"C331","dJobICdNm":"[C331]귀금속 및 장신용품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006359:1', '{"dJobCd":"K000006359","dJobCdSeq":"1","dJobNm":"귀금속검사원","workSum":"귀금속 제품의 함량, 성분 등을 시금석(試金石:Touchstone)을 사용하여 검사한다.","doWork":"전자저울이나 천칭을 사용하여 검사할 귀금속의 무게를 계량한다. 시금석(試金石:Touchstone:금과 은의 순도를 조사하는 데 사용되는 흑색의 규산질암석)을 작업대에 올려놓고 시금석의 표면에 기름을 바른다. 순도를 알고 있는 금속시료를 시금석에 문질러 옆에 놓고, 시금할 금속을 시금석 위에서 문지른다. 시금석 위에 남겨진 금속의 조흔색(條痕色)을 질산으로 처리한다. 조흔색을 서로 비교하여 순수한 금속과 불순물이 섞인 금속을 구별한다. 귀금속의 반응 속도가 비슷할 때까지 실험을 반복한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"귀금속가공기능사, 보석가공기능사, 보석감정사, 보석감정산업기사","dJobECd":"8842","dJobECdNm":"[8842]귀금속·보석 세공원","dJobJCd":"7912","dJobJCdNm":"[7912]귀금속 및 보석 세공원","dJobICd":"C331","dJobICdNm":"[C331]귀금속 및 장신용품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006797:1', '{"dJobCd":"K000006797","dJobCdSeq":"1","dJobNm":"귀금속도금원","workSum":"보석제품의 표면에 여러 가지 색상을 내고 특수부분을 보호하기 위해 도금을 한다.","doWork":"작업지시서를 확인하여 도금할 제품에 따라 도금시간 및 색상 등을 확인한다. 전기도금기의 작동유무를 확인한다. 도금할 금속을 전기도금기의 음극에 연결한다. 스테인리스나 황동을 동선에 연결하여 전기도금기의 양극을 연결한다. 양극과 음극을 화학용액 속에 담근다. 전기도금기의 조정판을 조작하고 전원을 넣는다. 수시로 도금시간, 화학용액의 색상 등을 확인하여 도금 상태를 점검한다. 일정 시간이 지난 후 전원스위치를 내리고 도금된 제품을 물에 세척한다. 도금한 부위의 손상을 막기 위해 래커나 왁스용액을 보석에 바르거나 떨어뜨리기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"대기환경미흡|위험내재|다습|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"귀금속가공기능장, 귀금속가공기능사, 귀금속가공산업기사, 국가유산수리기능자(도금공)","dJobECd":"8842","dJobECdNm":"[8842]귀금속·보석 세공원","dJobJCd":"7912","dJobJCdNm":"[7912]귀금속 및 보석 세공원","dJobICd":"C331","dJobICdNm":"[C331]귀금속 및 장신용품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001267:1', '{"dJobCd":"K000001267","dJobCdSeq":"1","dJobNm":"귀금속모형제작원","workSum":"귀금속 주형을 만드는 데 사용되는 금속모형을 제작한다.","doWork":"작업지시서에 따라 금속재료에 조각칼로 디자인한다. 금속 공예용 수동톱으로 금속을 디자인과 같이 자르고 줄을 사용하여 모서리를 다듬는다. 절단한 금속모형이 작업지시서의 치수와 일치한지 측정게이지로 검사한다. 특정한 입체디자인을 내기 위해 수동공구로 모형을 두드리고 다듬는다. 수동드릴로 모형에 구멍을 뚫는다. 각 부품을 서로 맞추고 땜질한다. 연마기로 금속모형을 다듬는다. 공구를 날카롭게 갈기도 하고 디자인 명세서를 수정하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"시각|","workEnv":"소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"귀금속원형제작원","connectJob":"보석모형제작원, 보석원형제작원, 장신구모형제작원","certLic":"귀금속가공기능장, 귀금속가공기능사, 귀금속가공산업기사","dJobECd":"8842","dJobECdNm":"[8842]귀금속·보석 세공원","dJobJCd":"7912","dJobJCdNm":"[7912]귀금속 및 보석 세공원","dJobICd":"C331","dJobICdNm":"[C331]귀금속 및 장신용품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001662:1', '{"dJobCd":"K000001662","dJobCdSeq":"1","dJobNm":"귀금속분석원","workSum":"광석에서 분리된 지금(Base Metal)을 용해하여 소정의 합금성분이 되도록 성분·함량별로 분리·배합한다.","doWork":"작업에 필요한 장비, 도구 및 각종 화학약품을 준비한다. 광석에서 분리된 덩어리인 지금(Base Metal)을 분리기로 금, 은, 구리 등으로 분리한다. 재료를 용광로에 넣고 불필요한 성분을 산화하여 제거하기 위하여 초산, 염산 등의 화공약품을 넣는다. 기계를 가공하여 귀금속 원료를 성분별로 분리·추출하고 재합성한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"대기환경미흡|위험내재|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"조작운전","certLic":"귀금속가공기능장, 귀금속가공기능사, 귀금속가공산업기사","dJobECd":"8842","dJobECdNm":"[8842]귀금속·보석 세공원","dJobJCd":"7912","dJobJCdNm":"[7912]귀금속 및 보석 세공원","dJobICd":"C331","dJobICdNm":"[C331]귀금속 및 장신용품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006307:1', '{"dJobCd":"K000006307","dJobCdSeq":"1","dJobNm":"귀금속성형원","workSum":"금, 은, 백금 등을 반지굴대와 생가죽망치를 사용하여 원형으로 성형한다.","doWork":"작업표준서를 확인하고 반지재료 및 작업도구를 준비한다. 반지재료의 끝을 사포로 매끈하고 곧게 다듬는다. 반지재료를 반지굽힘 장치에 놓고 재료가 반원형이 되도록 레버를 잡아당긴다. 생가죽망치를 사용하여 재료를 두드려 원형으로 만든다. 치수를 측정하는 반지굴대에 반지를 넣어 작업표준서와 일치하는지 검사한다. 이상이 있으면 다시 성형한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"귀금속만곡작업원","connectJob":"반지성형원, 목걸이성형원","certLic":"귀금속가공기능장, 귀금속가공기능사, 귀금속가공산업기사","dJobECd":"8842","dJobECdNm":"[8842]귀금속·보석 세공원","dJobJCd":"7912","dJobJCdNm":"[7912]귀금속 및 보석 세공원","dJobICd":"C331","dJobICdNm":"[C331]귀금속 및 장신용품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002799:1', '{"dJobCd":"K000002799","dJobCdSeq":"1","dJobNm":"귀금속세공원","workSum":"금, 은 등의 귀금속을 손이나 동력공구로 세공하여 목걸이, 반지 등을 제작한다.","doWork":"작업명세서를 확인하여 제품별 디자인, 재료 등을 점검한다. 작업에 필요한 공구를 준비한다. 세공할 모양, 형태에 따라 금, 은 등의 귀금속재료를 저울로 계량한다. 망치, 줄 등 수공구를 사용하여 귀금속 재료를 펴고 구부린다. 동력공구를 사용하여 구멍을 뚫거나 잘라내어 성형한다. 땜질용 토치를 사용하여 귀금속을 달구어 땜질한다. 땜질된 이음매와 거친 곳을 손줄과 금강사 사포를 사용하여 표면을 매끄럽게 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"귀금속조각원","connectJob":"금세공원, 백금세공원, 은세공원, 장신구세공원","certLic":"귀금속가공기능장, 귀금속가공기능사, 귀금속가공산업기사","dJobECd":"8842","dJobECdNm":"[8842]귀금속·보석 세공원","dJobJCd":"7912","dJobJCdNm":"[7912]귀금속 및 보석 세공원","dJobICd":"C331","dJobICdNm":"[C331]귀금속 및 장신용품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002656:1', '{"dJobCd":"K000002656","dJobCdSeq":"1","dJobNm":"귀금속소둔원","workSum":"전기 및 가스로를 사용하여 금, 은 등의 귀금속을 열처리한다.","doWork":"작업지시서를 확인하여 제품별 온도 및 시간 등을 확인한다. 전기로의 자동온도조정기를 일정 온도로 조정한다. 강철함 속에 금, 은 등의 귀금속을 채워 넣는다. 집게를 사용하여 가마 속에 강철함을 넣는다. 일정 시간이 경과한 후 강철함을 꺼낸다. 강철함에서 귀금속을 꺼내어 물속에 담근다. 귀금속을 화학용액 및 물통에 넣어 일정 시간 경과 후 꺼내어 귀금속에 묻은 산화물이나 찌꺼기를 세척하기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|고온|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"귀금속가공기능장, 귀금속가공기능사, 귀금속가공산업기사","dJobECd":"8842","dJobECdNm":"[8842]귀금속·보석 세공원","dJobJCd":"7912","dJobJCdNm":"[7912]귀금속 및 보석 세공원","dJobICd":"C331","dJobICdNm":"[C331]귀금속 및 장신용품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003705:1', '{"dJobCd":"K000003705","dJobCdSeq":"1","dJobNm":"귀금속수리원","workSum":"각종 보석이나 귀금속 제품 또는 장신구의 손상 및 파손부위를 검사하고 수리한다.","doWork":"수리를 의뢰한 귀금속의 가치, 순도, 물리적 구조, 색 등급 및 기타 관련 요소를 판단하기 위해 특성을 검사한다. 귀금속, 보석, 장신구를 세공하기 위해 수공구, 동력공구, 광학기구 및 관련 장비를 준비한다. 손상부위에 따라 귀금속 재료를 주조, 조각, 용접하여 특정한 형태로 재가공한다. 수리된 제품의 견적을 산출하고 소비자에게 통보한다. 보석을 접착 또는 고정시키고 광택을 내기도 하며 각종 모조장신구 및 기념트로피 등에 대한 수리를 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"귀금속가공기능사, 보석가공기능사","dJobECd":"8842","dJobECdNm":"[8842]귀금속·보석 세공원","dJobJCd":"7912","dJobJCdNm":"[7912]귀금속 및 보석 세공원","dJobICd":"S953","dJobICdNm":"[S953]개인 및 가정용품 수리업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002696:1', '{"dJobCd":"K000002696","dJobCdSeq":"1","dJobNm":"귀금속용해원","workSum":"장신구를 만드는 데 사용되는 금속을 제조하기 위하여 금 또는 금은의 합금을 용해한다.","doWork":"작업지시서에 따라 금, 은 등의 금속을 저울이나 계량용기를 사용하여 일정 비율로 측정한다. 계량한 금, 은 등의 금속을 점토 가마나 용해로에 넣는다. 금속을 용해시키기 위하여 토치를 사용하여 가열한다. 지시된 온도에 도달되었는지 확인하기 위하여 금속의 색상변화를 관찰한다. 금속덩어리가 있는지를 흑연봉으로 저어서 살펴본다. 용해된 금속을 형틀에 붓거나 물에 넣어 식힌다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"위험내재|고온|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"보석용해원","connectJob":"원심주조원","certLic":"귀금속가공기능사","dJobECd":"8842","dJobECdNm":"[8842]귀금속·보석 세공원","dJobJCd":"7912","dJobJCdNm":"[7912]귀금속 및 보석 세공원","dJobICd":"C331","dJobICdNm":"[C331]귀금속 및 장신용품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005508:1', '{"dJobCd":"K000005508","dJobCdSeq":"1","dJobNm":"귀금속조각원","workSum":"귀금속품과 장신구에 글씨와 모양 등을 새겨 넣는다.","doWork":"가공할 제품 또는 재료를 바이스에 끼워 고정한다. 광택제를 사용하여 제품의 표면을 닦는다. 조각용 공구의 끝에 다이아몬드 가루를 묻힌다. 재료의 표면에 글씨와 모양, 형태를 새겨 넣거나 다이아몬드 등의 보석을 석(石)물림하여 끼운다. 글자세공기계를 사용하여 세공하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"보석조각원","certLic":"귀금속가공기능장, 귀금속가공기능사, 귀금속가공산업기사, 보석가공기능사","dJobECd":"8842","dJobECdNm":"[8842]귀금속·보석 세공원","dJobJCd":"7912","dJobJCdNm":"[7912]귀금속 및 보석 세공원","dJobICd":"C331","dJobICdNm":"[C331]귀금속 및 장신용품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006834:1', '{"dJobCd":"K000006834","dJobCdSeq":"1","dJobNm":"금속장식세공원","workSum":"목재, 금속, 합성수지, 가죽, 대나무 등의 바탕에 금속선으로 각종 형태의 무늬를 세공한다.","doWork":"은, 동, 황동 등과 같은 금속선을 이용하여 꽃무늬의 가지나 덩굴모양을 만든다. 금속철판(구리, 니켈)을 이용하여 각종 동물문양의 신주(금속 장신구)를 만든다. 금속선과 금속철판으로 만든 각종 장식물을 장식한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"자개세공원","certLic":"가구제작기능사","dJobECd":"8842","dJobECdNm":"[8842]귀금속·보석 세공원","dJobJCd":"7912","dJobJCdNm":"[7912]귀금속 및 보석 세공원","dJobICd":"C320","dJobICdNm":"[C320]가구 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003304:1', '{"dJobCd":"K000003304","dJobCdSeq":"1","dJobNm":"보석검사원","workSum":"다이아몬드와 같은 완성한 보석을 확대경을 사용하여 불순물, 깨짐, 표면상태, 규격, 크기, 연마, 색상, 투명도 등을 검사하여 등급별로 분류한다.","doWork":"유산용액과 초산가루를 유리용기에 넣고 알코올램프로 가열한다. 가열된 유리용기에 연마된 보석을 넣어 세척한다. 현미경으로 보석 속의 내포물의 상태(Clarity)를 살펴서 감정표지에다 등급을 기록한다. 루페(Loupe:보석세공확대경)로 연마 상태를 점검하여 면의 각도, 크기, 깊이, 넓이 등을 감정표지에 기록한다. 컬러 마스터기 위에 올려놓고 표준 컬러 마스터스톤을 넣어 비교하여 색상 순으로 표기한다. 보석의 규격이 작업지시서와 일치하는지 다이얼게이지나 버니어캘리퍼스를 이용하여 측정한다. 검사규정에 의거하여 불량으로 처리된 보석은 결함사항을 기록하여 해당 부서로 보낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"보석감정사","certLic":"보석감정사","dJobECd":"8842","dJobECdNm":"[8842]귀금속·보석 세공원","dJobJCd":"7912","dJobJCdNm":"[7912]귀금속 및 보석 세공원","dJobICd":"C331/M739","dJobICdNm":"[C331]귀금속 및 장신용품 제조업 / [M739]그 외 기타 전문, 과학 및 기술 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007040:1', '{"dJobCd":"K000007040","dJobCdSeq":"1","dJobNm":"보석선별원","workSum":"보석류 원석을 상품성과 감량을 고려하여 루페와 게이지를 사용하여 색상, 흠, 결정, 형태, 크기 등을 분류한다.","doWork":"원석을 깨끗한 물에 씻은 다음 선별작업대에 놓는다. 원석에 조명을 비추어 색상, 크기, 모양 등에 따라 분류한다. 육안으로 원석의 결정형태, 투명도, 내포물 등의 결함상태를 관찰한다. 확대경이나 루페(Loupe:보석세공확대경)를 사용하여 원석의 투명도, 색상, 결정형태 등을 관찰하여 원석을 분류한다. 게이지를 사용하여 원석의 크기를 측정하고 연마방향을 결정한다. 원석에 이물질이 있으면 망치로 원석의 한쪽 면을 타격하여 이물질의 종류를 확인한다. 용도에 따라 원석을 구분하고 저울로 중량을 측정하여 기록표에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"원석선별원","certLic":"보석감정사, 보석가공기능사","dJobECd":"8842","dJobECdNm":"[8842]귀금속·보석 세공원","dJobJCd":"7912","dJobJCdNm":"[7912]귀금속 및 보석 세공원","dJobICd":"C331/M739","dJobICdNm":"[C331]귀금속 및 장신용품 제조업 / [M739]그 외 기타 전문, 과학 및 기술 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003583:1', '{"dJobCd":"K000003583","dJobCdSeq":"1","dJobNm":"보석연마원","workSum":"다이아몬드와 같은 보석류나 장신구류를 일정한 형태로 연마판과 핸드피스를 사용하여 연마한다.","doWork":"작업지시서를 확인하여 연마할 디자인 및 작업순서 등을 숙지한다. 다이아몬드가루와 물 또는 기름을 혼합하여 연마판에 바른다. 스위치를 조작하여 연마판을 회전시킨다. 원석이 접지된 폿(Pot)을 다이아몬드 핸드피스에 끼운다. 원석을 일정 각도로 깎기 위해 핸드피스의 눈금을 맞추고 회전하는 연마판에 손으로 일정한 힘을 가해 연마한다. 작업순서에 따라 사면, 팔면, 십육면, 밑면, 윗면을 루페(Loupe:보석세공확대경)로 연마 상태를 확인하면서 연마한다. 연마가 완료된 보석류나 장신구류를 다음 공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"보석연삭원, 보석광택원, 보석세공원, 다이아몬드연마원, 수정연마원, 장신구광택원","certLic":"보석가공기능사","dJobECd":"8842","dJobECdNm":"[8842]귀금속·보석 세공원","dJobJCd":"7912","dJobJCdNm":"[7912]귀금속 및 보석 세공원","dJobICd":"C331","dJobICdNm":"[C331]귀금속 및 장신용품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004013:1', '{"dJobCd":"K000004013","dJobCdSeq":"1","dJobNm":"보석용해원","workSum":"보석장신구를 만드는 데 사용되는 금속을 제조하기 위하여 금이나 은 또는 이들의 합금을 용해시키는 일을 한다.","doWork":"작업표준에 맞는 비율로 금, 은이나 이들의 합금을 저울, 계량용기를 사용하여 계량한다. 계량한 금속을 점토가마나 용해로에 넣는다. 금속을 용해시키기 위하여 토치를 사용하여 가열한다. 작업표준에 따라 정해진 온도에 도달되었는지 확인하기 위하여 금속의 색상변화를 관찰한다. 금속덩어리가 있는지를 흑연봉으로 저어서 살펴본다. 용해된 금속을 형틀에 붓거나 물에 넣어 식힌다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"원심주조원","certLic":"귀금속가공기능사, 보석가공기능사, 보석감정사","dJobECd":"8842","dJobECdNm":"[8842]귀금속·보석 세공원","dJobJCd":"7912","dJobJCdNm":"[7912]귀금속 및 보석 세공원","dJobICd":"C331","dJobICdNm":"[C331]귀금속 및 장신용품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003759:1', '{"dJobCd":"K000003759","dJobCdSeq":"1","dJobNm":"보석절단원","workSum":"원형톱을 사용하여 보석원석을 결정축의 절단방향과 절단표시에 따라 절단한다.","doWork":"보석원석을 조명등에 비추어 루페로 원석에 내포된 불순물의 형태나 크기를 측정하고 기록한다. 원형톱 기계에 제품 종류별로 톱을 끼우고 냉각수밸브를 열어 절단면에 뿌리고 스위치를 눌러 기계를 가동한다. 측정한 수치를 기준으로 원석의 가장자리를 절단한다. 가공할 보석의 크기와 형태에 따라 규격별로 절단한다. 절단한 원석을 규격별로 구분하고 저울로 중량을 측정하여 기록표에 기록한다. 원형톱에 다이아몬드 파우더를 바르기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"보석대절단원, 보석소절단원","certLic":"보석가공기능사","dJobECd":"8842","dJobECdNm":"[8842]귀금속·보석 세공원","dJobJCd":"7912","dJobJCdNm":"[7912]귀금속 및 보석 세공원","dJobICd":"C331","dJobICdNm":"[C331]귀금속 및 장신용품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005863:1', '{"dJobCd":"K000005863","dJobCdSeq":"1","dJobNm":"보석조립원","workSum":"반지, 팔찌, 목걸이 등의 제품을 수동공구를 사용하여 다이아몬드, 루비 등의 보석을 세팅한다.","doWork":"제품을 바이스에 물린다. 보석의 크기에 따라 줄, 끌, 수동드릴, 전기드릴을 사용하여 자르고 구멍을 만들어 다듬는다. 제품 위에 보석을 놓고 보석의 테두리를 세운다. 세팅공구와 해머로 세팅의 가장자리를 두드려 보석을 금속에 부착시키면서 제 위치에 고정한다. 금강사 줄과 뾰족한 강철공구를 사용하여 가장자리를 매끈하게 한다. 확대경이나 루페(Loupe:보석세공확대경)를 사용하여 조립된 제품을 검사한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"귀금속조립원","connectJob":"다이아몬드조립원, 루비조립원","certLic":"귀금속가공기능사, 보석가공기능사","dJobECd":"8842","dJobECdNm":"[8842]귀금속·보석 세공원","dJobJCd":"7912","dJobJCdNm":"[7912]귀금속 및 보석 세공원","dJobICd":"C331","dJobICdNm":"[C331]귀금속 및 장신용품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003929:1', '{"dJobCd":"K000003929","dJobCdSeq":"1","dJobNm":"보석천공원","workSum":"일정 크기와 모양으로 절단된 보석류에 구멍을 뚫기 위해 초음파천공기를 조작한다.","doWork":"작업지시서를 확인하여 작업내용을 숙지한다. 초음파천공기, 연마제 등 장비 및 도구를 준비한다. 천공형태에 따라 초음파천공기에 바늘을 고정한다. 연마제와 물을 혼합하여 초음파천공기의 주입구에 넣는다. 보석원석의 성질에 따라 초음파천공기의 진동주파수를 조정한다. 천공기의 작동스위치를 눌러 기계를 가동한다. 보석의 천공부위에 바늘의 끝을 정확히 대고 규정된 깊이까지 천공한다. 바늘을 보석으로부터 빼내기 위해 핸들을 돌린다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"초음파천공원","certLic":"보석가공기능사","dJobECd":"8842","dJobECdNm":"[8842]귀금속·보석 세공원","dJobJCd":"7912","dJobJCdNm":"[7912]귀금속 및 보석 세공원","dJobICd":"C331","dJobICdNm":"[C331]귀금속 및 장신용품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004047:1', '{"dJobCd":"K000004047","dJobCdSeq":"1","dJobNm":"장신구검사원","workSum":"완성된 제품의 크기, 형태, 색상 등이 작업지시서와 일치하는지 검사한다.","doWork":"완성된 제품을 검사작업대에 올려놓는다. 마이크로미터, 버니어캘리퍼스 등을 사용하여 제품의 규격을 검사한다. 불순물, 색상, 흠, 긁힘 상태 등을 확대경이나 루페(Loupe:보석세공확대경)를 사용하여 검사한다. 저울로 무게를 측정한다. 불합격품은 분류하여 해당 부서로 보낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8842","dJobECdNm":"[8842]귀금속·보석 세공원","dJobJCd":"7912","dJobJCdNm":"[7912]귀금속 및 보석 세공원","dJobICd":"C331","dJobICdNm":"[C331]귀금속 및 장신용품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002003:1', '{"dJobCd":"K000002003","dJobCdSeq":"1","dJobNm":"장신구다듬질원","workSum":"주조된 신변장신구를 줄이나 사포 등을 사용하여 표면을 다듬질한다.","doWork":"화학약품을 혼합한 통에 신변장신구를 넣어 피막을 제거한다. 줄이나 연삭숫돌을 사용하여 거친 모서리를 다듬는다. 사포를 사용하여 표면을 부드럽게 한다. 금속의 함량이나 상표를 표시한 각인을 찍는다. 대량으로 장신구를 광택·연마하기 위해 회전통에 연마제나 광택제를 넣고 회전시켜 광택을 내기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"위험내재|고온|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8842","dJobECdNm":"[8842]귀금속·보석 세공원","dJobJCd":"7912","dJobJCdNm":"[7912]귀금속 및 보석 세공원","dJobICd":"C331","dJobICdNm":"[C331]귀금속 및 장신용품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002539:1', '{"dJobCd":"K000002539","dJobCdSeq":"1","dJobNm":"장신구석고형틀제작원","workSum":"반지, 귀고리 등의 신변장신구를 제조하는 석고형틀을 만든다.","doWork":"사출된 왁스(Wax)모형을 고무받침대 위의 왁스 막대에 전기인두로 접착한다. 접착이 끝난 왁스모형을 플라스크(Flask:주물용 석고거푸집) 속에 넣는다. 석고를 물과 혼합하여 플라스크 속에 채운다. 진공펌프와 진공기를 사용하여 플라스크 속에 있는 공기를 제거한다. 석고를 말리기 위해 플라스크를 일정한 그늘에 놓는다. 왁스를 용해시키기 위하여 전기가마에 넣는다. 전기가마에서 석고형틀을 꺼내고 자연 상태에서 건조시킨 후 물에 넣어 석고를 제거한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","similarNm":"왁스성형원","certLic":"귀금속가공기능장, 귀금속가공기능사, 귀금속가공산업기사","dJobECd":"8842","dJobECdNm":"[8842]귀금속·보석 세공원","dJobJCd":"7912","dJobJCdNm":"[7912]귀금속 및 보석 세공원","dJobICd":"C331","dJobICdNm":"[C331]귀금속 및 장신용품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004753:1', '{"dJobCd":"K000004753","dJobCdSeq":"1","dJobNm":"장신구수리원","workSum":"파손된 반지, 팔찌, 목걸이, 귀고리 등의 장신구를 수리한다.","doWork":"크기를 조절하기 위하여 반지, 팔찌 등의 장신구를 금속 봉에 걸고 두드린다. 사이즈가 적은 경우 절단 후 크기에 맞게 만든 덧댐 귀금속을 용접한다. 줄과 사포로 이음새를 정리한 후 파손된 장신구의 고리를 확인하고 같은 종류의 부품을 사용하여 연결한다. 장신구에서 분리된 보석의 부착위치를 확인하고 접착제, 핀셋, 미세가공용 칼 등을 사용하여 보석을 부착한다. 연마기를 가동하고 광택제를 사용하여 거친 부위를 연마한다. 도안에 따라 각종 제품을 제조하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"귀금속가공기능사, 보석가공기능사, 보석감정사","dJobECd":"8842","dJobECdNm":"[8842]귀금속·보석 세공원","dJobJCd":"7912","dJobJCdNm":"[7912]귀금속 및 보석 세공원","dJobICd":"C331","dJobICdNm":"[C331]귀금속 및 장신용품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006553:1', '{"dJobCd":"K000006553","dJobCdSeq":"1","dJobNm":"장신구제조반장","workSum":"반지, 팔찌 등의 장신구를 제조하는 데 종사하는 작업원의 활동을 감독·조정한다.","doWork":"제품의 색상·표면상태 등이 작업지시서와 일치하는지 루페(Loupe:보석세공확대경) 등을 사용하여 품질상태를 검사한다. 작업내용을 작업원에게 지시·배치한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원 및 자재를 공급한다. 표준명세에 따라 지시된 작업이 이루어지는지 작업원과 함께 작업하며 작업상황을 관찰하고 작업내용을 점검한다. 작업원에 대한 직무교육 및 안전위생교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시 관찰과 면담을 통하여 작업원의 애로 및 건의사항을 수렴·해결하고 문제점을 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","connectJob":"보석가공반장, 보석세공반장, 귀금속가공반장","dJobECd":"8842","dJobECdNm":"[8842]귀금속·보석 세공원","dJobJCd":"7912","dJobJCdNm":"[7912]귀금속 및 보석 세공원","dJobICd":"C331","dJobICdNm":"[C331]귀금속 및 장신용품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002585:1', '{"dJobCd":"K000002585","dJobCdSeq":"1","dJobNm":"체인제작원","workSum":"금속선을 사용하여 각종 형태의 체인을 만든다.","doWork":"체인꼬임기계에 금속선을 연결하고 기계스위치를 작동한다. 자동으로 체인이 일정량 생산되면 기계의 작동스위치를 내린다. 제품을 규정된 온도로 가열한 후 물, 화학용제에 넣어 열처리한다. 체인을 세척용액통에 담궈 세척한다. 연마제나 펠트광택제를 사용하여 체인을 닦아 윤을 낸다. 필요에 따라 자동절단기로 체인을 절단하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"8842","dJobECdNm":"[8842]귀금속·보석 세공원","dJobJCd":"7912","dJobJCdNm":"[7912]귀금속 및 보석 세공원","dJobICd":"C271","dJobICdNm":"[C271]의료용 기기 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001430:1', '{"dJobCd":"K000001430","dJobCdSeq":"1","dJobNm":"회전연마기조작원","workSum":"보석용 원석이나 가공된 보석을 연마하고 광택을 내기 위하여 각종 연마기를 조작한다.","doWork":"회전통연마기에 연마제(카보런덤), 광택제(산화크롬), 합성세제, 물 등을 투입한다. 보석용 원석이나 가공된 보석을 연마기에 넣는다. 보석의 종류에 따라 회전속도를 조정한다. 회전통연마기의 가동스위치를 조작한다. 일정한 시간을 사용하면 연마제나 광택제를 교환한다. 보석과 가공제를 분리시키고 물로 세척한다. 보석의 연마상태와 광택정도를 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","connectJob":"바렐연마원, 텀블러연마원, 브라스터연마기조작원","certLic":"귀금속가공기능사, 보석가공기능사, 보석감정사","dJobECd":"8842","dJobECdNm":"[8842]귀금속·보석 세공원","dJobJCd":"7912","dJobJCdNm":"[7912]귀금속 및 보석 세공원","dJobICd":"C339","dJobICdNm":"[C339]그 외 기타 제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007269:1', '{"dJobCd":"K000007269","dJobCdSeq":"1","dJobNm":"가스관설치원","workSum":"가스공급을 위한 관로를 설치 시공한다.","doWork":"가스공급을 위하여 각종 배관을 연결한다. 수평기를 사용하여 배관의 수평을 측정하고 조정한다. 여러 방향으로 가스를 보내기 위하여 다양한 연결장치를 설치한다. 배관의 연결을 위해 구멍을 뚫고 다른 관을 부착한다. 가스관 설치 후 기밀시험을 수행한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"가스배관원, 가스배관공, 가스배관설치원","certLic":"배관기능사, 가스기능사","dJobECd":"7031","dJobECdNm":"[7031]건설 배관공","dJobJCd":"7921","dJobJCdNm":"[7921]건설 배관공","dJobICd":"F412","dJobICdNm":"[F412]토목 건설업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004423:1', '{"dJobCd":"K000004423","dJobCdSeq":"1","dJobNm":"가스인입배관공","workSum":"가스를 수송·공급하는 주배관 및 인입배관을 설치·연결한다.","doWork":"설계도면과 시방서를 파악하여 관의 재질과 규격, 배관부속, 배관경로 등을 파악하고 작업을 준비한다. 가스관의 내부를 검사하고 이물질을 제거한 후 배관을 시공한다. 굴삭기운전원이나 기중기조종원에게 수신호하여 관을 배관루트에 따라 배열한다. 용접이음부의 녹을 방지하기 위하여 플라스틱 테이프, 고무시트, 열수축 튜브를 감는다. 당일의 배관작업이 완료되면 이물질의 유입을 방지하는 작업을 수행한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"가스배관원, 가스배관공, 가스배관설치원","connectJob":"가스설치원, 가스시공원","certLic":"배관기능사, 용접기능사","dJobECd":"7031","dJobECdNm":"[7031]건설 배관공","dJobJCd":"7921","dJobJCdNm":"[7921]건설 배관공","dJobICd":"F422","dJobICdNm":"[F422]건물설비 설치 공사업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004524:1', '{"dJobCd":"K000004524","dJobCdSeq":"1","dJobNm":"건축배관공","workSum":"주택, 빌딩, 공장 등의 건축물에 급수, 급탕, 배수, 오수, 통기배관, 냉난방 배관 등을 관련 장비와 연결하고 배관한다.","doWork":"설계도면을 검토하여 금속관, 비금속관 등 설치할 시설물의 위치를 점검 및 표시한다. 슬라브, 벽체 등 건축구조물에 배관지지대를 설치하기 위하여 전동드릴, 정, 망치, 타정공구 등을 이용하여 앵글이나 환봉, 행거 등의 배관지지대를 설치한다. 설계도면에 따라 배관루트 상의 치수에 맞추어 절단한다. 파이프 머신을 사용하여 파이프에 나사를 가공하고 절단한다. 재단·성형된 관을 배관루트를 따라 나사·볼트, 용접, 엘보우(ㄱ자형, T자형 등의 연결관) 등을 이용하여 연결한다. 위생, 냉·난방, 급·배수시설에 필요한 계기·밸브, 방진장치, 부속기구 등을 설치하여 관과 연결한다. 위생도기 등을 설치하고 백시멘트·모르타르·접착제 등을 이용하여 마무리 작업을 한다. 관 표면을 청소하고 부식방지를 위하여 방청페인트(화학적으로 녹의 발생을 막는 도료)를 칠한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"건축배관원, 건축설비배관원, 건축설비배관공, 건축배관사","connectJob":"위생배관원, 상하수배관원, 소방배관원, 오수처리배관원, 난방배관원, 냉방배관원","certLic":"배관기능사","dJobECd":"7031","dJobECdNm":"[7031]건설 배관공","dJobJCd":"7921","dJobJCdNm":"[7921]건설 배관공","dJobICd":"F422","dJobICdNm":"[F422]건물설비 설치 공사업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001829:1', '{"dJobCd":"K000001829","dJobCdSeq":"1","dJobNm":"건축배관반장","workSum":"주택, 빌딩, 공장 등의 건축물에 급수, 급탕, 배수, 오수, 통기배관, 냉난방 배관 등을 관련 장비와 연결하고 배관하는 작업을 관리하며, 건축배관공의 활동을 감독 조정한다.","doWork":"건축도면과 배관도면을 해독하여 배관라인의 구성 및 설비물의 적합성을 판정하고, 시공도면에 따라 배관의 위치를 정한다. 작업계획에 따라 세부실행항목을 수립하여 작업절차 및 방법을 결정한다. 작업원에게 작업내용을 지시하고 작업배치를 한다. 작업원의 작업상황을 관리·감독하고 작업공정에 있어 필요한 자재 및 기술을 지원한다. 배관이 설치되면 누설 여부를 수압시험기 및 각종 기기로 검사한다. 수시로 관찰과 면담을 통하여 작업원의 애로사항 및 건의사항을 수렴·해결하고 문제점을 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"건축설비배관반장","certLic":"배관기능사","dJobECd":"7031","dJobECdNm":"[7031]건설 배관공","dJobJCd":"7921","dJobJCdNm":"[7921]건설 배관공","dJobICd":"F422","dJobICdNm":"[F422]건물설비 설치 공사업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004212:1', '{"dJobCd":"K000004212","dJobCdSeq":"1","dJobNm":"광산배관공","workSum":"유용광물을 채광·채탄하기 위한 지하광산에 공기, 용수, 전기 등을 공급 및 배수하기 위하여 설비용 금속이나 비금속 관을 결합하여 설치한다.","doWork":"설계도면과 시방서를 파악하여 관의 재질과 규격, 배관부속, 배관경로 등을 파악하고 작업을 준비한다. 광차를 이용하여 관을 배관장소로 운반한다. 관 속의 잔류 공기와 물을 제거한다. 배관을 수평, 수직으로 배열하고 나사, 용접, 특수 이음쇠 등을 통해 배관을 조립한다. 관의 누수와 누기 여부를 검사한다. 장치나 펌프 등에 배관을 연결하고 계측기를 설치한다. 광산배관시설을 확인·점검하고 파손부분은 교체·수리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"기공, 선관원, 광산배관원, 광산배관기능원","connectJob":"광산배관보수원","certLic":"용접기능사, 배관기능사","dJobECd":"7031","dJobECdNm":"[7031]건설 배관공","dJobJCd":"7921","dJobJCdNm":"[7921]건설 배관공","dJobICd":"B051/B061/B062","dJobICdNm":"[B051]석탄 광업 / [B061]철 광업 / [B062]비철금속 광업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005167:1', '{"dJobCd":"K000005167","dJobCdSeq":"1","dJobNm":"급수관보수원","workSum":"용수의 원활한 흐름을 유지하기 위하여 파손되거나 노후화된 관을 교체하거나 수리한다.","doWork":"관로의 수리나 교체할 곳을 확인하고 단수계획을 수립한다. 관로의 수리나 교체에 필요한 포크레인, 용접기, 예비관, 삽, 곡괭이, 착암기 등의 장비를 준비한다. 이상이 발생한 지점을 파서 관을 교체하거나 수리한다. 보수가 완료되면 굴착부분을 메우고 정리작업을 한다. 공사 중 차량 및 통행인의 안전사고를 예방하기 위하여 줄을 치거나 안내표지판을 세운다. 누수 또는 노후 급수관을 교체하는 옥내급수관 교체공사를 하거나 동파로 인해 파손된 계량기를 교체하기도 한다. 작업내용을 기록·정리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"수도계량기설치원, 수도계량기교체원, 관부설원","certLic":"배관기능사","dJobECd":"7031","dJobECdNm":"[7031]건설 배관공","dJobJCd":"7921","dJobJCdNm":"[7921]건설 배관공","dJobICd":"E360","dJobICdNm":"[E360]수도업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001926:1', '{"dJobCd":"K000001926","dJobCdSeq":"1","dJobNm":"덕트공","workSum":"금속박판을 성형·가공하여 공조설비, 냉·난방설비, 환기설비 등의 공기통로를 설치한다.","doWork":"설계도면이나 시방서를 검토하고, 설치할 시설물(Duct:덕트, 공기나 기타 유체가 흐르는 통로 및 구조물)의 위치를 점검 및 표시한다. 치수에 맞게 제작된 덕트를 설비도면의 위치에 맞게 배치하거나, 동력프레스나 기타 공구를 이용하여 금속판(함석 등)을 마킹선에 따라 직접 재단하고 제작한다. 타정공구나 각종 드릴을 사용하여 행거(서포트) 등 덕트지지대를 설치한다. 덕트를 설치하기 위하여 리프트나 윈치(Winch:로프를 원통에 감아올려 중량물을 끌어 올리거나 도르래를 끼워 매다는 기중기의 일종)를 이용하여 시공할 위치까지 들어 올려 설치한다. 볼트·너트·고무패킹 등을 이용하여 연결부위를 연결한다. 덕트를 송풍기와 연결하고 덕트중간에 공기의 흡입, 취출구를 만들고 연결한다. 덕트 설치의 이상 유무를 검사·조정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"덕트원, 덕트설치공, 덕트설치원, 배기덕트, 배기덕트설치공, 배기덕트설치원","connectJob":"플랜트덕트공","certLic":"판금제관기능사, 공조냉동기계기능사","dJobECd":"7031","dJobECdNm":"[7031]건설 배관공","dJobJCd":"7921","dJobJCdNm":"[7921]건설 배관공","dJobICd":"F422","dJobICdNm":"[F422]건물설비 설치 공사업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004705:1', '{"dJobCd":"K000004705","dJobCdSeq":"1","dJobNm":"덕트반장","workSum":"금속박판을 성형·가공하여 공조설비, 냉·난방설비, 환기설비 등의 공기통로를 조립하는 작업을 관리하며, 덕트공의 활동을 감독·조정한다.","doWork":"설계도면을 보고 작업내용을 파악하여 자재준비 및 덕트인력을 배치한다. 작업계획에 따라 세부실행항목을 수립하여 작업절차 및 방법을 결정한다. 작업원에게 지시하고 작업배치를 한다. 표준명세에 따라 지시된 작업이 이루어지는지 작업원과 함께 작업하면서 작업내용을 점검한다. 작업진행상황을 파악하고 작업내용을 보고한다. 작업원의 작업상황을 관리·감독하고 작업 시 필요한 자재, 공구 및 기술을 지원한다. 배기구 및 작업장의 환경설비의 이상 유무, 작업환경상의 애로점 등 작업원의 애로사항 및 건의사항을 수렴·해결하고 문제점을 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"덕트설치반장","certLic":"판금제관기능사","dJobECd":"7031","dJobECdNm":"[7031]건설 배관공","dJobJCd":"7921","dJobJCdNm":"[7921]건설 배관공","dJobICd":"F422","dJobICdNm":"[F422]건물설비 설치 공사업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005074:1', '{"dJobCd":"K000005074","dJobCdSeq":"1","dJobNm":"수용가가스설비설치원","workSum":"일반 수용가(가정용, 영업용), 산업용 수용가에 가스설비 및 가스기구를 설치하고 배관한다.","doWork":"가스시설을 할 장소의 구조를 점검한다. 가스기구와 설비를 안전한 위치에 놓고 고정한다. 이때 일반수용가(가정용, 영업용)는 지역정압기에 맞는 계량기를, 산업용 수용가에는 수용가의 요구압력을 측정할 수 있는 계량기를 설치한다. 사용하기 편리한 곳에 안전차단기를 설치하고 가스기구를 호스나 배관으로 연결한다. 공구를 이용하여 배관이나 호스를 고정한다. 배관 연결 후 기밀시험을 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"가스설치기사, 가정용가스설비설치기사","certLic":"가스기능사, 배관기능사","dJobECd":"7031","dJobECdNm":"[7031]건설 배관공","dJobJCd":"7921","dJobJCdNm":"[7921]건설 배관공","dJobICd":"D352","dJobICdNm":"[D352]연료용 가스 제조 및 배관공급업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005862:1', '{"dJobCd":"K000005862","dJobCdSeq":"1","dJobNm":"연도반장","workSum":"주택, 빌딩, 소각로, 공장 등 건축물의 보일러 가동 시 연기가 나오는 배기관을 설치하는 작업을 관리하며, 연도원의 활동을 감독·조정한다.","doWork":"작업시작 전에 설계도와 작업내용을 파악한다. 작업계획에 따라 세부실행항목을 수립하고 작업절차 및 방법을 결정하여 작업원들에게 지시한다. 지시된 작업이 이루어지는지 작업상황을 점검한다. 필요한 장비나 자재를 주문한다. 작업진행상황을 파악하고 작업내용을 공사현장관리자에게 보고한다. 작업상 발생되는 기술적인 문제를 해결하고 작업이 진행되는 동안 작업원의 활동을 감독·조정한다. 수시 관찰과 면담을 통하여 작업원의 애로사항 및 건의사항을 수렴·해결하고 문제점을 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"연돌반장, 연도설치반장, 연돌설치반장","dJobECd":"7031","dJobECdNm":"[7031]건설 배관공","dJobJCd":"7921","dJobJCdNm":"[7921]건설 배관공","dJobICd":"F422","dJobICdNm":"[F422]건물설비 설치 공사업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006130:1', '{"dJobCd":"K000006130","dJobCdSeq":"1","dJobNm":"연도원","workSum":"주택, 빌딩, 소각로, 공장 등 건축물의 보일러 가동 시 나오는 연기를 분출하기 위하여 수평 또는 수직으로 배기관을 설치한다.","doWork":"설계도면을 검토하고 작업현장의 상황을 파악한다. 연도설치 작업을 위하여 안전비계작업대를 설치하고 자재를 운반한다. 배관의 지름 둘레의 크기에 따라 윈치(Winch:로프를 원통에 감아올려 중량물을 끌어 올리거나 도르래를 끼워 매다는 기중기의 일종), 체인블록 및 기중기 등을 이용하여 조립한다. 연도의 하중을 지지하기 위하여 지지관 및 지지대를 설치한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"균형감각|","workEnv":"대기환경미흡|위험내재|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"연돌원, 연도설치원, 연도설치공, 연돌설치원, 연돌설치공","connectJob":"연도설치원, 연도설치공","dJobECd":"7031","dJobECdNm":"[7031]건설 배관공","dJobJCd":"7921","dJobJCdNm":"[7921]건설 배관공","dJobICd":"F422","dJobICdNm":"[F422]건물설비 설치 공사업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005851:1', '{"dJobCd":"K000005851","dJobCdSeq":"1","dJobNm":"홈통설치원","workSum":"건축구조물 및 조립식 주택의 지붕 등에 빗물을 배출시키기 위한 홈통(Gutter:건축물의 지붕 빗물을 받아서 배출시키는 반원형 통이나 관(管))을 설치한다.","doWork":"설계도면을 보고 필요한 양의 자재를 준비하고 이상 유무를 파악한다. 시공 길이에 맞춰 처마홈통을 이음대, 접착제 등을 사용하여 연결하고 금속제 지지기구를 사용하여 고정시킨다. 선홈통은 연결부위 한쪽면을 토치램프나 전열기로 가열한 후 유연하게 만들어 다른 한쪽 면에 접착제를 바르고 연결한다. 선홈통과 처마홈통이 연결되는 부위에 깔때기홈통을 설치한다. 홈통 설치가 완료되면 설치부위를 검사한다. 가장자리의 물 빠지는 구멍에 배수관을 연결하고 배수상태를 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"물받이홈통설치원, 물받이홈통설치공, 처마홈통설치원, 처마홈통설치공","dJobECd":"7031","dJobECdNm":"[7031]건설 배관공","dJobJCd":"7921","dJobJCdNm":"[7921]건설 배관공","dJobICd":"F424","dJobICdNm":"[F424]실내건축 및 건축마무리 공사업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007014:1', '{"dJobCd":"K000007014","dJobCdSeq":"1","dJobNm":"흄관원","workSum":"배수를 위하여 콘크리트 흄관을 결합·매설한다.","doWork":"기초바닥에 일정 두께로 잡석을 깔고 평탄하게 다진다. 잡석 위에 일정 간격으로 콘크리트를 타설하고 바이브레이터로 완전히 충진시킨다. 소켓부, 스피고트부 등 관의 내외부를 청소하고 고무링을 장착한다. 와이어로 관을 체결하고 기중기조종원에게 신호하여 조심스럽게 매설 위치에 내린다. 소켓부와 고무링에 윤활제를 바른다. 관의 구경에 따라 레버블록(Lever Block)을 설치하여 관을 접합하고 스피코트(Spigot)부에 기준선을 그려 완전히 접합되었는지 확인한다. 완전히 접합이 끝난 후 걸쇠장치를 떼어내고 관을 고정시킨다. 관 고정 후 채움콘크리트로 관의 양쪽부분을 균등하게 채운다. 양질의 흙을 적정량씩 채운다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"흄관배관공, 옥외배관공, 콘크리트흄관설치원, 콘크리트흄관설치공, 흄관배관원","connectJob":"배수파이프설치원","certLic":"배관기능사","dJobECd":"7031","dJobECdNm":"[7031]건설 배관공","dJobJCd":"7921","dJobJCdNm":"[7921]건설 배관공","dJobICd":"F412","dJobICdNm":"[F412]토목 건설업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007496:1', '{"dJobCd":"K000007496","dJobCdSeq":"1","dJobNm":"공업배관공","workSum":"연소기구 등 각종 산업장비와 정유, 발전, 난방 등의 산업시설 및 원유, 가스, 증기, 화학용액을 수송 또는 공급하기 위한 금속관 및 비금속관을 설치하고 연결한다.","doWork":"설계도면과 작업시방서에 따라 조립할 배관의 용도 및 위치와 구조를 확인하여 숙지한다. 작업공구를 준비하고 점검한다. 용도에 따른 관의 종류를 구별하여 선택한다. 도면 및 배관의 위치에 따라 마킹한다. 관의 길이를 규격대로 수직으로 절단한다. 곡선배관은 공구를 사용하여 구부리거나 ㄱ자형의 엘보밸브를 사용한다. 관의 이음부분은 가스캣, 커플링, 볼트, 나사, 플랜지(Flange), 피팅(Fitting), 티, 맞대기용접 등을 하여 접합한다. 게이트밸브를 조립하여 유체의 제어장치를 설치한다. 도면에 따라 압축기, 계량기 등을 조립·설치한다. 수평기를 이용하여 관의 수평상태를 조정한다. 접합부분의 누수압력 및 제한압력, 유체의 누출 여부 등을 시험·검사한다. 배관의 구조가 도면과 일치하는지 검사한다. 작업내용을 작업일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"공업배관원, 산업배관원, 산업배관공, 공업배관기능원, 공업배관사","connectJob":"플랜트배관공, 플랜트배관원, 공장배관원, 기계배관원","certLic":"판금제관기능사, 배관기능사","dJobECd":"7032","dJobECdNm":"[7032]공업 배관공","dJobJCd":"7922","dJobJCdNm":"[7922]공업 배관공","dJobICd":"F412","dJobICdNm":"[F412]토목 건설업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002624:1', '{"dJobCd":"K000002624","dJobCdSeq":"1","dJobNm":"배관설치원","workSum":"선박 및 해양구조물의 해수, 각종 가스, 증기, 온수, 위생, 냉동, 수압, 기압, 유압, 화물용 기름관 또는 가스 수송관 및 원료 및 윤활용 관계 배관설비 등을 조립·설치한다.","doWork":"도면에 맞추어 구멍과 방해물을 참작하여 파이프와 부(속)품의 조립을 계획한다. 격벽과 갑판에 파이프를 설치할 구멍을 뚫는다. 파이프의 밸브, 트랩, 온도조절장치와 같은 파이프 부속 기구류를 절단하고 나사를 내기 위하여 기계를 조작한다. 파이프를 찌그러지지않게 도면에 표기된 형태로 구부린다. 파이프를 지지하기 위하여 브래킷을 설치하고 용접한다. 렌치를 사용하여 냉각장치, 조리시설, 펌프, 탱크에 파이프를 연결하고, 연결부를 밀봉하기 위하여 토치로 이음매를 용접한다. 밸브를 끼우고 조정한다. 명세서에 맞게 설치되었는지, 새는 곳이 있는지 확인하기 위하여 수압시험장비나 기타 압력시험장비로 설치된 배관을 검사한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|청각|손사용|시각|","workEnv":"대기환경미흡|위험내재|고온|저온|다습|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"배관사, 선박배관원, 조선배관원, 조선배관공","connectJob":"가설배관원, 공업배관원, 냉동배관원, 위생배관원, 조선기자재배관원, 엔진배관사, 배관제작원, 비철관제작원, 조선배관사","certLic":"배관기능장/산업기사/기능사, 에너지관리기능장/산업기사/기능사, 공조냉동기계산업기사/기능사","dJobECd":"7032","dJobECdNm":"[7032]공업 배관공","dJobJCd":"7922","dJobJCdNm":"[7922]공업 배관공","dJobICd":"C311","dJobICdNm":"[C311]선박 및 보트 건조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004140:1', '{"dJobCd":"K000004140","dJobCdSeq":"1","dJobNm":"철도차량배관공","workSum":"철도차량의 제동장치, 전선, 냉각수, 위생시설 등을 설치하기 위하여 파이프를 연결하는 배관작업을 한다.","doWork":"철도차량의 배관을 위하여 배관도면을 수령하여 확인한다. 배관도면 및 작업시방서에 따라 표준규격의 파이프를 선정하여 준비한다. 작업에 필요한 공구(절단기, 확관기, 용접기, 파이프벤더, 누출탐지기, 렌치, 수압테스터기)를 준비한다. 작업시방서에 따라 파이프의 종류·크기 등을 선정하여 절단표준서에 맞게 절단선을 그린다. 파이프를 절단기를 이용하여 절단한다. 절단면의 군더더기를 제거하기 위하여 내외면 가공기를 사용하여 제거한다. 압축공기를 불어 넣어 파이프 안의 이물질을 제거한다. 파이프의 나사길이를 결정하고 파이프머신을 사용하여 나사를 깎는다. 공작도면를 읽고 파이프를 굴곡시킬 각도를 결정한다. 굴곡기를 사용하여 굴곡한다. 파이프를 부착할 위치에 U자형 볼트, 소켓 등 부속을 사용하여 부착한다. 압축공기를 배관된 파이프에 충전시킨 후 연결부위에 붓을 사용하여 비눗물을 도포하여 공기가 새는 곳을 점검한다. 결함이 있는 부분 등을 교체·수리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"철도차량배관원","certLic":"철도차량정비기능장, 철도차량기사, 철도차량산업기사, 철도차량기능사","dJobECd":"7032","dJobECdNm":"[7032]공업 배관공","dJobJCd":"7922","dJobJCdNm":"[7922]공업 배관공","dJobICd":"C312","dJobICdNm":"[C312]철도장비 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001534:1', '{"dJobCd":"K000001534","dJobCdSeq":"1","dJobNm":"플랜지설치원","workSum":"고객, 검사기관 또는 관련 법규 및 시스템 별 파이프 이음부를 규정하는 작업절차에 의거하여 플랜지 연결 작업한다.","doWork":"시스템 개별 장비의 제원, 설계도, 검사 관련 규정 등을 파악한다. 플랜지 조임 부분을 수학적 계산 방식으로 볼트, 가스켓, 플랜지의 종류에 따른 토크(힘) 값을 계산하여 핸드 툴 또는 유압 툴을 사용하여 단계별 쪼임을 실시한다. 플랜지 체결 전 플랜지 면(face) 확인 후 면이 안 좋을 때에는 작은 홈을 파는 세레이션(Serration)작업을 한다. 볼트, 너트에는 고착방지제인 모리커터(Molykote)를 바른다. 볼트의 쪼임 순서는 대각선, 별모양을 기본으로 하고 토크 값은 단계별로 올리도록 한다. 플랜지 연결 작업이 마무리되면 플랜지에 테그(tag)를 붙여 파이프 정보, 토크 값, 작업 수행자, 작업일자 등 정보를 기입한다. FMS 검사이력서를 작성하고 인도한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|손사용|시각|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"FMS(Flange Management System)엔지니어","dJobECd":"7032","dJobECdNm":"[7032]공업 배관공","dJobJCd":"7922","dJobJCdNm":"[7922]공업 배관공","dJobICd":"C311","dJobICdNm":"[C311]선박 및 보트 건조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006643:1', '{"dJobCd":"K000006643","dJobCdSeq":"1","dJobNm":"항공기유압기계원","workSum":"항공기의 배관 및 유압 부품을 기술도면에 따라 배치·조립·설치하고 시험한다.","doWork":"기술도면을 보면서 항공기에 사용되는 각종 배관 및 유압 부품(펌프, 밸브, 연료 및 윤활유라인, 랜딩기어작동기계, 브레이크장치)의 장착 위치를 파악한다. 부품을 설치할 프레임의 위치에 구멍을 뚫고 브래킷(Bracket), 보강재, 덧대는 조각, 쐐기 등의 부품을 조립하기 위하여 아버프레스(Arbor Press:인력으로 작은 축을 조작하여 스핀들을 승강시키는 소형 프레스), 동력절단기, 펀치프레스(Punch Press:보통 얇은 철판과 같은 재료가 들어 있는 금형에 압력을 가해 그 크기와 형상을 바꾸는 프레스) 등의 기계를 조작한다. 기체, 날개, 꼬리 등의 구조물에 부품이나 조립품을 볼트나사로 조이고 용접할 곳에 부품을 꺾쇠로 조여 놓는다. 실린더의 동작거리, 밸브, 제륜장치, 기압펌프의 작동을 조정하기 위하여 고정나사와 조임너트를 조인다. 설치된 부분이 기술도면과 일치하는지 실제 비행과 같은 조건하에서 기능을 시험한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"공유압기능사, 항공기정비기능사, 항공전기·전자정비기능사","dJobECd":"7032","dJobECdNm":"[7032]공업 배관공","dJobJCd":"7922","dJobJCdNm":"[7922]공업 배관공","dJobICd":"C313","dJobICdNm":"[C313]항공기, 우주선 및 부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006354:1', '{"dJobCd":"K000006354","dJobCdSeq":"1","dJobNm":"항공기유압배관공","workSum":"항공기 유압 시스템에 사용되는 파이프, 튜브, 호스 등을 항공기 내부의 구조물에 장착하고, 클램프 등을 이용해 본체와 연결한다.","doWork":"작업표준서나 유압 회로도를 보고 작업에 필요한 공구와 부품을 준비한다. 유압관(파이프, 튜브, 호스 등)을 항공기 본체의 정해진 위치에 놓고, 각 유압관의 피팅(Fittings:항공기 본체에 구성품을 연결하는 데 사용하는 부착장비)을 느슨하게 연결한다. 피팅을 조이기 전에 유압관의 위치가 도면에 정확하게 맞는지 확인하고, 클램프(Clamp:체결하는 부품 또는 도구)를 이용해 유압관을 결합시킨다. 결합된 유압관 상태를 확인하고 정해진 토크(Torque:물체에 작용하여 물체를 회전시키는 원인이 되는 물리량)를 적용하여 피팅을 완전히 조인다. 조여진 배관 내부의 누설 여부를 확인한다. 유압관과 주변품의 간섭, 규정된 간격 준수 여부 및 부품의 손상 유무를 확인한다. 작업 주위를 정리·정돈한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"항공기유압배관원, 항공기배관공","connectJob":"항공기유압배관검사원, 항공기유압기계원","certLic":"항공기관사, 항공기정비기능사","dJobECd":"7032","dJobECdNm":"[7032]공업 배관공","dJobJCd":"7922","dJobJCdNm":"[7922]공업 배관공","dJobICd":"C313","dJobICdNm":"[C313]항공기, 우주선 및 부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006046:1', '{"dJobCd":"K000006046","dJobCdSeq":"1","dJobNm":"관로시설점검원","workSum":"관로사고의 예방과 조기발견을 위하여 관로를 순시하여 점검한다.","doWork":"수도관로경로도면(토목설비 현황을 전체적으로 파악하여 지하관로의 상호관계를 지형도에 기록한 도면)에 따라 관로를 순찰한다. 금속관로탐지기, 관로누수탐지기, 초음파유량계 등의 검사장비를 사용하여 지상 및 지하의 누수, 관로의 함몰, 관로부지의 불법점용, 전화, 전기, 가스 등의 공사로 인한 관로 파손 여부를 점검한다. 각종 시설 뚜껑의 손궤나 분실 여부를 확인하고 이상이 발견되면 응급조치를 한다. 서지탱크(Surge Tank:물의 송수압을 높이기 위하여 높은 곳에 위치한 탱크)의 수위저하 등을 점검한다. 복구차량이 항시 통행할 수 있도록 장애물을 제거한다. 관로 경계석의 위치변동 여부 및 손궤, 분실 등의 여부를 확인한다. 사고 시 응급조치나 사고지점의 발견이 용이하도록 관로 주변 지형지물의 변화상태를 측정하여 도면에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실외","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","connectJob":"누수탐사원","dJobECd":"7039","dJobECdNm":"[7039]기타 배관공","dJobJCd":"7929","dJobJCdNm":"[7929]기타 배관공","dJobICd":"E360","dJobICdNm":"[E360]수도업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003078:1', '{"dJobCd":"K000003078","dJobCdSeq":"1","dJobNm":"멸균관리사","workSum":"병원에서 환자처치 및 수술에 필요한 기구·유텐실 및 소모품을 세척·가공·포장·멸균하여 청정구역에 보관하며 각 병실과 임상과로 공급한다.","doWork":"환자에게 사용한 물품을 반납받아 세척방법에 따라 분류한다. 세척기(Cart Washer, Washer Disinfector)를 사용하거나 수동으로 외과용기구와 기타 의료기구를 세척한다. 세척된 기구의 물기를 제거하고, 파손된 기구와 수선이 필요한 기구를 골라낸다. 살균 처리된 물품을 지시된 명부 또는 표시에 따라서 팩(Pack)으로 꾸리고 방포나 파우치, 부직포로 포장한 후 꼬리표와 멸균 지시계를 부착한다. 고압증기멸균기나 EO가스멸균기, 건열멸균기 등을 사용하여 의료장비·기구와 소모품 등 공급품을 멸균한다. 멸균이 끝난 후 멸균대장에 기록하며 멸균물품 창고에 보관한다. 물품운반용 승강기나 운반차를 이용하여 각 병실, 수술실, 진료실 등으로 멸균물품을 운반하고 사용한 물품을 받아온다. 청구서를 기록하고 공급품 대금을 정산한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"단순작업","similarNm":"중앙소독실종사원","dJobECd":"5613","dJobECdNm":"[5613]배관 세정원 및 방역원","dJobJCd":"7991","dJobJCdNm":"[7991]배관 세정원 및 방역원","dJobICd":"Q869","dJobICdNm":"[Q869]기타 보건업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007563:1', '{"dJobCd":"K000007563","dJobCdSeq":"1","dJobNm":"방역원","workSum":"주택가, 사업체 등의 오염, 질병, 전염병 등을 예방·소독 및 관리한다.","doWork":"방역대상이나 시설, 목표 등을 확인하고 방역계획을 수립한다. 위생사의 작업지시에 따라 배합할 약품의 종류와 배합비 등을 확인한다. 분무장치 및 살균장치를 점검하고 배합한 약품을 투입한다. 주택가나 사업체의 배수시설, 쓰레기통, 급수시설 등 오염 가능성이 높은 부위를 중심으로 살균 또는 소독약품을 분무하거나 살포한다. 방역 이후 상태를 모니터링하고 평가 및 조치한다. 방역설비, 장비 등을 유지관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"방제원, 방제기사, 토탈위생컨설턴트","connectJob":"코로나방역활동지원원","certLic":"위생사","dJobECd":"5613","dJobECdNm":"[5613]배관 세정원 및 방역원","dJobJCd":"7991","dJobJCdNm":"[7991]배관 세정원 및 방역원","dJobICd":"N742","dJobICdNm":"[N742]건물ㆍ산업설비 청소 및 방제 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004743:1', '{"dJobCd":"K000004743","dJobCdSeq":"1","dJobNm":"위생청소원","workSum":"물탱크, 저수조, 건물 등을 청결하게 청소하고 위생관리를 한다.","doWork":"청소에 필요한 물품을 준비한다. 청소세제, 빗자루, 걸레, 청소기계 등을 사용하여 화장실, 실내 등을 쓸고 닦는다. 청소 후 청결상태를 평가한다. 청소도구를 정리하고 관리한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"시범후 30일 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"웅크림|","workEnv":"위험내재|다습|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","dJobECd":"5613","dJobECdNm":"[5613]배관 세정원 및 방역원","dJobJCd":"7991","dJobJCdNm":"[7991]배관 세정원 및 방역원","dJobICd":"E370","dJobICdNm":"[E370]하수, 폐수 및 분뇨 처리업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006615:1', '{"dJobCd":"K000006615","dJobCdSeq":"1","dJobNm":"유품정리사","workSum":"유족 및 의뢰인을 대신하여 고인의 유품, 재산 등을 정리하고, 사망한 장소에 남겨진 오염물을 처리한다.","doWork":"유품정리 의뢰가 들어오면 현장 방문 등 구체적인 상황 분석을 통해 투입할 분야별 작업 인원과 필요 장비 등을 파악하여 견적을 낸다. 병균, 악취를 제거하는 일부터 시작해 유품에 묻은 혈흔, 분비물, 인체조직 등 악성 폐기물의 위생적 처리, 자외선·오존 살균과 탈취 등 일련의 순서에 따라 유품을 정리한다. 현금, 유가증권 등의 귀중품은 상속자에게 정상적인 상태로 전달하고, 각종 가재도구는 사용 가능 여부나 의뢰인의 뜻에 따라 재활용 센터에 매각하거나 유족에게 전달한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|손사용|","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"수동조작","dJobECd":"5613","dJobECdNm":"[5613]배관 세정원 및 방역원","dJobJCd":"7991","dJobJCdNm":"[7991]배관 세정원 및 방역원","dJobICd":"N742","dJobICdNm":"[N742]건물ㆍ산업설비 청소 및 방제 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005363:1', '{"dJobCd":"K000005363","dJobCdSeq":"1","dJobNm":"해충퇴치원","workSum":"해충의 종류 및 서식지를 파악하여 방제한다.","doWork":"해충제거 대상지를 실사 후 해충종류, 예상개체 수, 이동경로 및 서식지 등을 파악하여 방역지역을 결정한다. 해충의 종류 대상지에 따라 필요한 장비 및 약품을 준비한다. 제거대상 해충에 알맞은 방제방법을 이용하여 제거한다. 해충의 알이나 서식지 등에 대한 방제를 한다. 고객에게 해충종류, 서식지, 추가 방제 등의 관련 보고서를 작성하여 제출한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"해충방제전문가","dJobECd":"5613","dJobECdNm":"[5613]배관 세정원 및 방역원","dJobJCd":"7991","dJobJCdNm":"[7991]배관 세정원 및 방역원","dJobICd":"N742","dJobICdNm":"[N742]건물ㆍ산업설비 청소 및 방제 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006652:1', '{"dJobCd":"K000006652","dJobCdSeq":"1","dJobNm":"거울장식물부착원","workSum":"수동공구, 전기기구, 리벳기를 사용하여 거울 뒷면에 고리, 장식핀, 걸이 등을 부착한다.","doWork":"작업지시서에 따라 장식할 거울의 종류 및 형태, 규격을 확인한다. 꺾쇠, 커터기, 리벳기, 전동드릴, 전동드라이버 등의 도구를 준비한다. 조립된 거울을 작업대 위에 뒤집어 올려놓는다. 거울을 보호하는 뒷면의 합판과 형틀을 커터기로 고정한다. 마킹된 형틀 부분에 전동드릴로 구멍을 내거나 전동드라이버로 나사못을 박는다. 장식핀이나 걸이를 부착한다. 완성된 거울의 형태를 점검한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8853","dJobECdNm":"[8853]유리기능, 복사, 수제 제본 등 기타 기능 종사원","dJobJCd":"7999","dJobJCdNm":"[7999]기타 기능 관련 종사원","dJobICd":"C231","dJobICdNm":"[C231]유리 및 유리제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005609:1', '{"dJobCd":"K000005609","dJobCdSeq":"1","dJobNm":"거울조립원","workSum":"여러 형태의 거울을 종류에 따라 목재, 플라스틱, 금속 등의 틀에 끼워 조립한다.","doWork":"작업명세서에 따라 조립할 거울의 종류 및 형태, 규격을 확인한다. 거울을 끼울틀 및 뒤판의 규격과 재질을 준비하고 확인한다. 전동드라이버, 전동드릴, 커터기, 꺾쇠 등의 조립기구를 준비하고 점검한다. 나사못, 못, 걸개 등의 부자재를 준비한다. 조립 전 거울의 품질이 불량인 것은 구별하여 분리한다. 성형된 거울을 준비된 틀 안에 넣는다. 골판지, 나무판지, 플라스틱판 등으로 거울의 뒷면을 덮는다. 거울의 뒤판이 빠지지 않도록 고정쇠를 박거나, 거울의 틀에 커터를 박아 고정한다. 형틀걸이를 마킹(Marking)하고 드릴로 구멍을 뚫어 걸개를 부착한다. 거울이 파손되지 않도록 주의한다. 완성된 거울의 조립상태를 점검한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8853","dJobECdNm":"[8853]유리기능, 복사, 수제 제본 등 기타 기능 종사원","dJobJCd":"7999","dJobJCdNm":"[7999]기타 기능 관련 종사원","dJobICd":"C231","dJobICdNm":"[C231]유리 및 유리제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005302:1', '{"dJobCd":"K000005302","dJobCdSeq":"1","dJobNm":"렌즈사진식자원","workSum":"현미경, 쌍안경 등 광학렌즈에 물체 측정 눈금이나 조준선 등을 사진 및 식각(Etching)공정을 통해 새긴다.","doWork":"작업표준서를 숙지한다. 식각공정에 필요한 감광액, 현상액, 에칭액, 스피너, 오븐기, 노광장치 등의 재료 및 장비를 준비하여 작동 여부를 확인한다. 작업 전 청정룸에서 가공, 연마된 렌즈의 표면을 깨끗이 세척한다. 코팅렌즈를 스피너 위에 올려놓고 렌즈를 회전시키면서 원심력을 이용하여 일정한 두께로 감광액을 표면에 도포하거나 스프레이로 뿌리고 용액에 담근다. 가공표면과 감광액과의 밀착성을 좋게 하기 위하여 오븐기에서 굽는다. 감광액에 도포된 렌즈표면을 노광장치를 사용하여 빛을 쬐어서 렌즈 위의 감광액을 선택적으로 반응하게 한다. 선택적으로 감광된 렌즈위에 현상액을 뿌리거나 현상액에 담그어 감광된 부분을 제거한다. 에칭(Etching)액에 넣어 최종적으로 완성되면 세척기에서 세척한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8853","dJobECdNm":"[8853]유리기능, 복사, 수제 제본 등 기타 기능 종사원","dJobJCd":"7999","dJobJCdNm":"[7999]기타 기능 관련 종사원","dJobICd":"C273","dJobICdNm":"[C273]사진장비 및 광학기기 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007224:1', '{"dJobCd":"K000007224","dJobCdSeq":"1","dJobNm":"보온병진공기조작원","workSum":"보온병의 단열효과를 높이기 위하여 속병과 겉병 사이의 공기를 뽑아내 진공상태로 만든다.","doWork":"보온병의 용량과 크기 및 수량을 확인한다. 진공기의 윤활유, 흡입호스 및 공기흡인기, 가스토치의 작동 여부를 확인 점검한 후 보온병을 진공작업대의 지그에 로딩한다. 공기흡인기의 호스를 보온병의 유리관 또는 스테인리스관에 끼운다. 흡인기의 펌프를 가동시켜 보온병의 겉병과 속병 안의 공기를 뽑아낸다. 압력측정기로 진공상태를 확인, 검사 후 펌프를 정지한다. 보온병 속병의 유리관을 가스토치로 가열하여 관을 녹여 밀봉한다(스테인리스 보온병의 경우 입구측을 용접이음 함). 흡인기의 호수를 뽑는다. 작업이 완료된 보온병을 운반 상자에 담는다. 다음 공정을 위하여 공기흡인기 및 부속품을 정리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|다습|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8853","dJobECdNm":"[8853]유리기능, 복사, 수제 제본 등 기타 기능 종사원","dJobJCd":"7999","dJobJCdNm":"[7999]기타 기능 관련 종사원","dJobICd":"C231","dJobICdNm":"[C231]유리 및 유리제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005151:1', '{"dJobCd":"K000005151","dJobCdSeq":"1","dJobNm":"복층유리봉합제충전원","workSum":"복층유리 가공을 위한 스페이서(Spacer:유리의 양면을 고정하기 위한 틀)와 유리가 조립, 압착된 복층유리에 봉합제(접착제)를 충진하여 양쪽유리와 스페이서 사이의 틈을 밀폐하고 봉합한다.","doWork":"작업지시서에 따라 봉합할 복층유리의 종류 및 구성비를 확인한다. 봉합할 복층유리의 수량에 따라 봉합제(접착제)의 양을 계산한다. 봉합제(접착제)의 양이 충분한지 점검한다. 봉합기의 작동 여부 및 그 외 부속장치를 점검한다. 배합비율에 따라 봉합제(접착제)를 믹서기로 혼합한다. 혼합된 접착제를 봉합기에 투입한다. 자동롤러에 복층유리를 올려놓는다. 봉합기를 가동시켜 스페이서와 양쪽유리를 완전히 밀폐, 접착시켜 봉합한다. 봉합상태를 점검한다. 봉합된 복층유리의 수량을 작업표에 기록한다. 봉합된 제품을 쿠션이 있는 팔레트(Pallet:적재대)유리의 양면을 고정하기 위한 틀에 적재하여 대기 중에 하루 동안 경화한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"치어콜작업원, 복층유리마무리작업원","dJobECd":"8853","dJobECdNm":"[8853]유리기능, 복사, 수제 제본 등 기타 기능 종사원","dJobJCd":"7999","dJobJCdNm":"[7999]기타 기능 관련 종사원","dJobICd":"C231","dJobICdNm":"[C231]유리 및 유리제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002398:1', '{"dJobCd":"K000002398","dJobCdSeq":"1","dJobNm":"솔마무리원","workSum":"제조된 화장솔, 빗자루솔, 구두솔 등의 모를 구관에 넣고 검사한다.","doWork":"구관(Ferrule) 끝 구멍 속에 강력접착제를 바른다. 손잡이를 구관 구멍 속으로 밀어 넣어 결합한다. 결합상태를 확인하고, 완성된 솔의 구관과 손잡이 결합부위의 이상 유무, 모 상태 및 손잡이의 인쇄상태 등을 검사한다. 헝겊에 약품을 발라 솔 표면을 닦아 흠을 제거하고 광택을 낸다. 완성된 제품을 포장하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"시범후 30일 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","dJobECd":"8853","dJobECdNm":"[8853]유리기능, 복사, 수제 제본 등 기타 기능 종사원","dJobJCd":"7999","dJobJCdNm":"[7999]기타 기능 관련 종사원","dJobICd":"C339","dJobICdNm":"[C339]그 외 기타 제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001628:1', '{"dJobCd":"K000001628","dJobCdSeq":"1","dJobNm":"솔제작원","workSum":"화장솔, 빗자루솔, 구두솔 등을 제작하기 위하여 모를 절단하고 묶어 접착제로 고정한다.","doWork":"모를 단단하게 모아 양쪽을 고무줄로 묶는다. 묶은 모를 절단기 위에 올려놓고 묶어진 고무줄 중간부위에 칼날이 오게 한다. 핸들을 조작하여 칼날을 내려 절단한 후 다시 핸들을 올린다. 절단된 모가 풀어지지 않는지 고무줄 상태를 점검한다. 모의 중량을 저울로 측정한다. 모를 구관(Ferrule)에 넣기 위해 정모기(모를 가지런히 정렬시키는 통)를 사용하여 모를 통에 넣고 두드린다. 통 속으로 일정량의 모가 들어가면 모의 뒤쪽 끝부분을 실로 단단하게 묶는다. 구관에 정모된 모를 넣은 후, 자로 모의 길이를 측정한다. 구관 끝 부분에 모가 빠지지 않도록 접착제를 투입한다. 접착제가 흘러나오지 않도록 구관을 세워 놓고 완전히 굳을 때까지 자연 건조한다. 착관이 된 꺼칠꺼칠한 모를 손으로 잡고 구관을 돌려가면서 칼로 다듬는다. 잘라진 모를 제거하기 위해 테이프 전면에 모의 부분을 눌러주어 파모가 테이프에 붙게 한다. 구관 끝 구멍 속에 접착제를 바른다. 손잡이를 구멍 속에 밀어 넣어 결합한다. 헝겊에 약품을 발라 화장솔 표면을 닦아 광을 낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","connectJob":"모무게측정원, 모절단원, 정모원, 착관원, 커팅원, 파모제거원","dJobECd":"8853","dJobECdNm":"[8853]유리기능, 복사, 수제 제본 등 기타 기능 종사원","dJobJCd":"7999","dJobJCdNm":"[7999]기타 기능 관련 종사원","dJobICd":"C339","dJobICdNm":"[C339]그 외 기타 제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005272:1', '{"dJobCd":"K000005272","dJobCdSeq":"1","dJobNm":"스포츠용품수리원","workSum":"소비자로부터 축구화, 테니스라켓, 골프채, 야구공 등 스포츠용품의 수선을 의뢰받아 육안 및 착용 등으로 테스트하여 문제점을 확인하고 제품을 수선한다.","doWork":"수선을 의뢰받은 스포츠용품을 확인한다. 제품에 따라 시험기를 작동하여 제품의 품질 및 손상 여부를 판정하고 착용 또는 육안으로 이상 유무를 확인한다. 시험결과에 따라 제품 수선의 무상, 유상 여부를 결정하며 소비자에게 설명하고 소비자의 의견에 따라 수선한다. 수선이 완료된 제품을 소비자에게 발송하며 수리내역을 작성한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"축구화수리원, 테니스라켓수리원, 야구용품수리원, 골프채수리원","dJobECd":"8853","dJobECdNm":"[8853]유리기능, 복사, 수제 제본 등 기타 기능 종사원","dJobJCd":"7999","dJobJCdNm":"[7999]기타 기능 관련 종사원","dJobICd":"S953","dJobICdNm":"[S953]개인 및 가정용품 수리업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004918:1', '{"dJobCd":"K000004918","dJobCdSeq":"1","dJobNm":"안경테수리원","workSum":"안경테 조립, 도금 작업 또는 판매제품 중 수리가 필요한 제품에 대하여 관련 도구 및 설비를 사용하여 수리한다.","doWork":"검사공정 또는 고객이 의뢰한 안경테 중 수리가 요구된 안경테를 수리서 또는 명세서를 확인하고 수리에 필요한 도구를 준비하고 점검한다. 간단히 수리 가능 부분과 현 공정에선 수리 불가능한 부분을 구분한다. 수리나 교체가 가능한 부분은 드라이버 등으로 수리를 하며 안경다리 팁을 비롯한 액세서리 부품을 교체한다. 현 공정에서 수리가 불가능한 용접, 도금 등의 부분은 관련 공정에 넘겨 수리업무를 수행토록 한다. 변색된 안경테의 경우 도금설비를 이용하여 작업한다. 절단부위의 경우 용접기를 사용하여 용접한다. 수리가 끝난 안경테의 수리결과를 확인한다. 수리 결과보고서를 작성하여 관련 부서에 통보하고 관련 자료를 관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8853","dJobECdNm":"[8853]유리기능, 복사, 수제 제본 등 기타 기능 종사원","dJobJCd":"7999","dJobJCdNm":"[7999]기타 기능 관련 종사원","dJobICd":"C271","dJobICdNm":"[C271]의료용 기기 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004016:1', '{"dJobCd":"K000004016","dJobCdSeq":"1","dJobNm":"유리가열절단원","workSum":"성형된 판유리, 유리공예품 등 유리제품의 불필요한 부분을 제거하기 위해 작업지시서에 따라 전기선이나 토치(Torch)를 사용하여 절단한다.","doWork":"성형된 유리제품을 수령하고 작업지시서에 따라 절단할 부위 및 치수를 육안 또는 측정기를 사용하여 확인한다. 토치 등 절단장비를 준비하여 점검하고 장갑 등 안전장비를 착용한다. 제품규격에 따라 토치나 전기 열선(니크롬선)의 높낮이를 조절한다. 토치를 점화하거나 니크롬선에 전원을 넣어 작업준비를 한다. 작업지시서에 따라 절단선을 마킹(Marking:표시)한다. 절단보조대 또는 절단기의 물레 위에 절단할 유리성형물을 손 또는 압착기를 이용하여 올려놓는다. 물레를 회전하여 토치 불꽃이나 전기 니크롬선을 절단위치에 접촉시킨다. 헝겊을 감은 막대기를 물에 적셔 열을 가한 부분에 칠하여 절단한다. 절단한 불필요한 부분을 손으로 떼어낸다. 절단 부위의 이상 여부를 검사한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|","workEnv":"위험내재|고온|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"유리절단원","dJobECd":"8853","dJobECdNm":"[8853]유리기능, 복사, 수제 제본 등 기타 기능 종사원","dJobJCd":"7999","dJobJCdNm":"[7999]기타 기능 관련 종사원","dJobICd":"C231","dJobICdNm":"[C231]유리 및 유리제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005365:1', '{"dJobCd":"K000005365","dJobCdSeq":"1","dJobNm":"유리가열정형원","workSum":"성형 또는 가공된 유리제품의 절단면과 연마부분의 거친 부위를 가스불꽃으로 연화시켜 매끄럽고 부드럽게 가공한다.","doWork":"성형된 유리제품을 수령하고 작업지시서에 따라 정형할 부위 및 치수를 육안으로 확인한다. 정형할 부위를 세척한다. 장비 및 장치의 작동을 점검한다. 장갑 등 안전장비를 착용한다. 제품규격에 따라 토치의 높낮이를 조절한다. 가스버너를 점화하여 작업을 준비한다. 작업보조대 또는 물레 위에 정형할 유리성형물을 압착기 등을 이용하여 올려놓는다. 물레를 회전하여 모서리 등 날카로운 부분을 각면, 마루면, 시라면, 도리스, 맘보 등의 형태로 정형한다. 금형 접합부에 의해 생긴 자국을 불꽃으로 녹이고 다듬으면서 정형되는 과정을 주시하며 관찰한다. 정형 부위의 가공상태를 검사한다. 집게를 사용하여 정형된 유리 가공물을 집어낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|고온|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8853","dJobECdNm":"[8853]유리기능, 복사, 수제 제본 등 기타 기능 종사원","dJobJCd":"7999","dJobJCdNm":"[7999]기타 기능 관련 종사원","dJobICd":"C231","dJobICdNm":"[C231]유리 및 유리제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003529:1', '{"dJobCd":"K000003529","dJobCdSeq":"1","dJobNm":"유리성형보조원","workSum":"취관(성형봉)과 금형을 이용하여 유리를 성형하는 유리인공식성형원을 보조한다.","doWork":"작업지시서에 따라 성형할 제품의 모양과 규격을 확인한다. 형틀금형, 집게 등 도구와 장비를 준비한다. 유리인공식성형원이 성형을 위해 취관(성형봉)을 금형에 넣기 위하여 금형을 열어준다. 유리인공식성형원이 1차 성형된 원구를 금형안에 넣으면 금형을 닫아준다. 성형이 완료되면 금형을 열어 집게로 유리성형물을 꺼낸다. 유리성형원이 성형상태를 검사하고 이상이 없을 시 작업지시서에 따라 불필요한 부분을 유리절단칼로 절단하여 다듬는다. 완성된 유리성형의 성형상태를 검사한다. 형틀이 열린 상태에서 물을 부어 금형을 식힌다. 금형의 상태를 수시로 관리하며 이상이 있는 부분은 수리를 요청한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|고온|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8853","dJobECdNm":"[8853]유리기능, 복사, 수제 제본 등 기타 기능 종사원","dJobJCd":"7999","dJobJCdNm":"[7999]기타 기능 관련 종사원","dJobICd":"C231","dJobICdNm":"[C231]유리 및 유리제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005276:1', '{"dJobCd":"K000005276","dJobCdSeq":"1","dJobNm":"유리스페이서성형원","workSum":"복층 유리제품의 유리 양면 사이에 삽입할 알루미늄 스페이서(Spacer:유리의 양면을 고정하기 위한 틀)를 제품 규격에 맞추어 절단하고 조립한다.","doWork":"작업명세서에 따라 가공할 스페이서의 종류와 규격을 확인한다. 가공할 복층유리의 수량에 따라 스페이서의 수량을 계산한다. 흡습제의 양이 충분한지 점검한다. 절단기 및 벤딩장치의 작동 여부를 점검한다. 스페이서를 자동절단기의 작업대 위에 올려놓는다. 자동절단기를 이용하여 스페이서를 규격에 맞게 절단한다. 절단된 스페이서를 벤딩한다. 스트레이트 키를 삽입하여 스페이서를 사각형 모양으로 정형한다. 흡습제(밀폐공간에서 건조상태를 유지시키는 물질)를 충전한다. 충전된 스페이서를 부틸기에 넣어 양면에 1차 접착제를 도포하여 부틸작업을 한다. 완성된 스페이서의 수량을 작업표에 기록한다. 작업정리를 위한 장비 및 장치를 점검하며 흡습제를 대기 중에 노출되지 않도록 드라이오븐에 관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"스페이서절단원, 스페이서조립원","dJobECd":"8853","dJobECdNm":"[8853]유리기능, 복사, 수제 제본 등 기타 기능 종사원","dJobJCd":"7999","dJobJCdNm":"[7999]기타 기능 관련 종사원","dJobICd":"C231","dJobICdNm":"[C231]유리 및 유리제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;