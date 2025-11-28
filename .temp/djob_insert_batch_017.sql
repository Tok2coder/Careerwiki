INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002103:1', '{"dJobCd":"K000002103","dJobCdSeq":"1","dJobNm":"보청기수리원","workSum":"인두, 납, 핸드피스(Hand Piece) 등을 사용하여 보청기의 구성부품을 교체·수선·조정한다.","doWork":"작업표준에 따라 수리에 필요한 인두, 납, 핸드피스(Hand Piece), 현미경 등 공구 및 장비를 준비하고 작동 여부를 점검한다. 수리 요청된 보청기의 문제점을 파악하기 위하여 보청기를 분해한다. 보청기의 제품열화로 발생한 문제의 경우 마이크로폰, 리시버, 콘덴서 등 보청기 내부부품을 교체하거나 셀을 교체한다. 작업 실수로 발생한 용접상의 문제인 경우 현미경을 통해서 부품들을 납땜한다. 환자의 청력 변화로 발생한 경우 다시 제작하거나 또는 관련 장치의 음량, 음폭 등을 조정한다. 부품의 교체 또는 셀을 교체 후 재조립하고 수리공정을 통하여 문제점이 해결된 제품은 재검사를 통해 확인하여 관련 부서에 인계한다. 수리 관련 사항의 보고서를 작성하고 도구, 장비를 정리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"3067","dJobECdNm":"[3067]재활공학 기사","dJobJCd":"2455","dJobJCdNm":"[2455]재활공학 기사","dJobICd":"C271","dJobICdNm":"[C271]의료용 기기 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003678:1', '{"dJobCd":"K000003678","dJobCdSeq":"1","dJobNm":"의안제조원","workSum":"사고나 질병으로 안구가 제거된 환자를 위해 의사의 처방 또는 고객의 요청에 따라 인조 아크릴 눈을 제조·수리하고 환자의 안구에 장착한다.","doWork":"작업명세서에 따라 제작할 의안의 규격과 형태 등을 확인한다. 연마기, 왁스 등의 원료, 공구 및 장비를 준비한다. 제작에 필요한 환자의 안구제거 환부에 취형(Impression)을 실시한 후 몰딩 작업을 하여 의안을 만든다. 만들어진 의안에 붓과 의안용 착색제를 사용하여 동공과 홍채를 그린다. 핏줄의 경우 의료용 빨간 실을 사용하여 만든다. 색깔이 깎여지거나 지워지지 않도록 투명 플라스틱을 씌우고 재질에 따라 끓는 물에 넣어다가 찬물에 담가 굳힌다. 연마기를 사용하여 연마를 하고 왁스를 사용하여 광택을 낸다. 제품이 완성된 후 의안을 환자에게 끼워주고 홍채와 동공의 중심 및 색깔을 정상 눈과 비교한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"3067","dJobECdNm":"[3067]재활공학 기사","dJobJCd":"2455","dJobJCdNm":"[2455]재활공학 기사","dJobICd":"C271","dJobICdNm":"[C271]의료용 기기 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006701:1', '{"dJobCd":"K000006701","dJobCdSeq":"1","dJobNm":"의지보조기기사","workSum":"지체장애인들의 상실·약화된 신체기능을 대체·보완하거나 장애를 보호하는데 필요한 의지보조기를 제작·수리·판매하고 착용을 지도하는 업무를 수행한다.","doWork":"지체장애인들의 장애상태와 의지·보조기의 착용부위에 대한 의학적 검사를 실시하고 의지·보조기의 종류, 형태 및 제조방법을 결정한다. 의지의 경우는 석고붕대를 이용하여 환부의 모형을 취형하고 상실된 신체부위 사이즈를 측정해서 기록하고 사용할 부품 및 재료를 선택한다. 보조기도 정밀제작 시 석고취형을 하고 그렇지 않은 경우는 관절위치, 신체부위 사이즈 측정 및 인체윤곽 그리기 등 중요사항을 기록한다. 기존의 석고취형을 대체하는 CAD-CAM기술이 의지·보조기에도 적용되어 환부의 모형을 스캔, 측정 및 가공하기도 한다. 석고캐스트를 해부학과 생체역학적 원리에 맞게 수정하고, 수정된 석고캐스트를 라미네이트 또는 열경화성 플라스틱으로 소켓을 만든다. 사전에 선정된 부품을 소켓에 조립·연결한다. 장애인에게 미리 장착을 하여 불편한 사항이나 문제점을 수정한다. 금속보조기의 경우 용접, 리벳팅(Riveting) 작업, 연마 등의 작업을 수행한다. 의지·보조기의 외형이나 색상이 가능한 정상인체에 가깝도록 만드는 외형 복원작업과 환부에 불편함이 없이 착용되도록 마무리 작업을 한다. 제작이 완료된 의지·보조기에 대한 최종검사를 처방 의사로부터 검수받고 장애인에게 장착시킨다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"의지보조기사, 보장구기사, 보장구제조원","connectJob":"의지제조원","certLic":"의지보조기기사","dJobECd":"3067","dJobECdNm":"[3067]재활공학 기사","dJobJCd":"2455","dJobJCdNm":"[2455]재활공학 기사","dJobICd":"Q869","dJobICdNm":"[Q869]기타 보건업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004879:1', '{"dJobCd":"K000004879","dJobCdSeq":"1","dJobNm":"의지제조원","workSum":"의사의 처방과 접수에 따라 지체장애인들의 신체장애 보완에 필요한 의지와 보조기를 제작·수리하고 환부에 정착시킨다.","doWork":"의사의 처방에 따라 제작할 의족, 의수 등의 의지나 보조기의 착용부위에 대한 의학적 검사를 실시하고 의지나 척추보조기, 상·하지보조기 등 보조기의 형태나 제조방법을 결정한다. 용접기, 연마기 등의 공구 및 장비와 석고, 실리콘 등의 재료 및 부품을 준비한다. 의지의 경우는 석고붕대 혹은 실리콘을 이용하여 환부의 모형을 취형하고 상실된 신체부위 사이즈 및 아웃트라인(Outline), 중심축에서의 기울기 등을 기록하고 사용할 부품 및 재료를 선택한다. 보조기는 정밀제작 시 실리콘 혹은 석고취형을 하고 그렇지 않은 경우는 관절위치, 인체윤곽 그리기 등 중요사항을 기록한다. 석고캐스트는 석고, 석고수정 도구를 사용하여 만든다. 완성된 석고캐스트를 라미네이트 또는 카본탄소섬유로 소켓을 만든다. 소켓에 사전에 선정된 상실부위 대체부품을 조립·연결한다. 이 단계에서 장애인에게 미리 장착을 시켜 불편한 사항이나 문제점을 고친다. 금속보조기의 경우 용접, 리벳팅(Riveting) 작업, 연마 등의 작업을 수행한다. 이후 의지, 보조기의 외형의 모양이나 색상이 가능한 정상인체에 가깝도록 외형복원 작업과 환부에 불편함이 없이 착용되도록 마무리에 치중한다. 제작이 완료된 의지, 보조기에 대한 최종검사를 처방의사에게 받고 합격판정 시 장애인에게 장착한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"수동조작","similarNm":"보장구제조원","dJobECd":"3067","dJobECdNm":"[3067]재활공학 기사","dJobJCd":"2455","dJobJCdNm":"[2455]재활공학 기사","dJobICd":"C271","dJobICdNm":"[C271]의료용 기기 제조업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004271:1', '{"dJobCd":"K000004271","dJobCdSeq":"1","dJobNm":"정형외과석고기사","workSum":"정형외과의사의 지시에 따라 수동공구를 사용하여 골절환자의 환부에 깁스하거나 의족, 의지 및 기타 기구를 조립·부착한다.","doWork":"정형외과의사의 처방에 따라 환자의 상처상태를 파악하고 깁스 정도를 예측한다. 깁스하기 전에 붕대, 거즈, 고무패드 등 보호재료를 적셔서 골절부위를 싸고 모양을 만든다. 전기절단기를 사용하여 깁스를 다듬는다. 깁스를 떼어내고 정형외과의사의 지시대로 환자의 사지나 신체부위의 위치를 변경하기 위해 깁스의 위치를 바꾼다. 정형부목을 만들기 위해 플라스틱, 석고재료 등을 조립한다. 움직이기 위한 버팀대를 환자의 신체부위에 대고 특정한 인장을 유지하도록 조절한다. 목발과 지팡이를 환자에게 맞게 조절한다. 환자에게 목발을 분배한 뒤 보행을 도와주고 그 사용법과 기타 운동요법 등 주의사항을 교육한다. 견인장치 및 의수·의족과 같은 각종 보조기를 관리한다. 골절환자의 골절부위에 치료용 철사를 박아서 견인하며 무릎십자인대 파열 환자의 경우 파열 정도를 파열검사기로 검사하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"3067","dJobECdNm":"[3067]재활공학 기사","dJobJCd":"2455","dJobJCdNm":"[2455]재활공학 기사","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002557:1', '{"dJobCd":"K000002557","dJobCdSeq":"1","dJobNm":"페도티스트","workSum":"페도틱 장치를 사용해 발의 불편을 해소하는 일을 한다.","doWork":"신발, 신발 변형, 발보조기구, 기타 발에 관련된 장치를 고안하고 제작한다. 발 질환 예방을 위해 교육과 상담을 한다. 병원 족부클리닉에서 활동하는 경우, 의사가 진단한 환자의 발 상태에 따라 신발이나 인솔, 발보조기구 등을 추천하고 제작하며 피팅한다. 페도틱 숍에서 고객의 보행을 분석하거나 발이나 신발의 불편감을 경감·완화시켜 주기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"웅크림|손사용|시각|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"신발치료사, 족부기공사","dJobECd":"3067","dJobECdNm":"[3067]재활공학 기사","dJobJCd":"2455","dJobJCdNm":"[2455]재활공학 기사","dJobICd":"Q869","dJobICdNm":"[Q869]기타 보건업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007501:1', '{"dJobCd":"K000007501","dJobCdSeq":"1","dJobNm":"물리치료사","workSum":"만성통증 및 기능장애 환자를 운동요법이나 기타 기구, 장비 등을 이용한 운동훈련을 통하여 치료한다.","doWork":"의사의 처방이나 환자의 기록지, 그리고 환자의 환부나 병력 등을 확인한다. 근골격계, 신경계, 순환호흡계, 일상생활동작 등을 평가한다. 평가를 토대로 치료계획을 수립한다. 환자의 상태에 따라 수치료, 전기, 광선치료, 운동치료, 치료적 마사지, 맨손치료 등을 한다. 치료과정 등을 기록하고 정리한다. 가정환경 개선 등 보호자 교육과 자가치료 등에 대해 환자를 교육한다. 의료장비 등 기타 치료와 관련된 장비를 관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"조정","workFunc2":"교육","workFunc3":"정밀작업","connectJob":"수중재활운동사","certLic":"물리치료사","dJobECd":"3065","dJobECdNm":"[3065]물리 및 작업 치료사","dJobJCd":"2456","dJobJCdNm":"[2456]물리 및 작업 치료사","dJobICd":"Q869","dJobICdNm":"[Q869]기타 보건업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007537:1', '{"dJobCd":"K000007537","dJobCdSeq":"1","dJobNm":"작업치료사","workSum":"신체적, 정신적, 사회적 장애를 가진 모든 연령대의 사람에게 일상생활동작, 일, 여가 활동 등 일상적인 생활을 수행할 수 있고, 기능 및 발달 수준을 유지, 발전시킬 수 있도록 의미 있고 목적 있는 활동을 통하여 치료프로그램을 계획하고 수행한다.","doWork":"환자의 정보를 확인한다. 병력, 직업력 등 환자를 면담한다. 환자의 병력 등을 근거로 악력기, 인지·지각 프로그램, 도구 등을 사용하여 운동능력, 손기능 능력, 감각능력, 인지·지각능력, 구강운동기능능력, 정신·사회기술능력, 일상생활동작능력, 환경, 직업, 놀이, 여가 등을 평가한다. 평가에 의거 치료계획을 수립한다. 치료계획에 따라 환자의 신체적 능력, 지적 능력, 흥미에 맞는 활동을 선정하며, 일상생활동작훈련, 인지·지각능력향상훈련, 감각기능훈련, 손기능, 운동기능증진훈련, 구강운동기능촉진훈련, 정신·사회기술능력향상훈련, 직업적응능력향상훈련, 사회적응능력 향상훈련 등을 실시한다. 치료 과정, 경과 등을 관련 의료진과 함께 토의·평가한다. 계획, 훈련실시내용, 결과 등을 작성한다. 보호자와 환자를 대상으로 퇴원 전후 관리, 보조기, 의수족 관리방법 등을 교육한다. 환자에 필요한 보조기를 제작한다. 근로·주거 환경을 평가하고 개조·수정한다. 관련 문서와 치료기자재를 관리한다. 보험 청구를 위한 행정업무를 수행한다. 다른 의료진들에게 작업치료 관련된 연수 및 교육을 실시한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"조정","workFunc2":"교육","workFunc3":"수동조작","similarNm":"작업요법사","certLic":"작업치료사","dJobECd":"3065","dJobECdNm":"[3065]물리 및 작업 치료사","dJobJCd":"2456","dJobJCdNm":"[2456]물리 및 작업 치료사","dJobICd":"Q869","dJobICdNm":"[Q869]기타 보건업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001434:1', '{"dJobCd":"K000001434","dJobCdSeq":"1","dJobNm":"아동지능검사원","workSum":"아동의 지능, 인성, 적성 및 발달 검사를 실시한다.","doWork":"소아과의사의 지시에 따라 해당 아동의 검사를 의뢰받는다. 연령 및 발달 정도에 적합한 발달, 인성, 적성 및 지능검사 방법을 선택한 후 검사 계획 및 일정을 수립한다. 검사지, 그림책 등 검사도구를 이용하여 지능 및 기초학습기능 검사를 수행하며 발달검사와 관련된 기초적인 언어능력을 측정한다. 부모의 양육태도가 아동의 인성에 미치는 영향을 평가하기 위해서 부모자녀관계 검사를 실시한다. 평가 후 결과를 정리해서 담당 소아과의사에게 보고한다. 지능검사가 어려운 장애아동을 대상으로 발달검사를 수행하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"아동심리지도사","dJobECd":"3066","dJobECdNm":"[3066]임상심리사","dJobJCd":"2457","dJobJCdNm":"[2457]임상심리사","dJobICd":"Q869","dJobICdNm":"[Q869]기타 보건업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007529:1', '{"dJobCd":"K000007529","dJobCdSeq":"1","dJobNm":"임상심리사","workSum":"인지, 행동, 정서 및 성격 등에 있어서 정신과적 장애가 있는 개인 또는 집단을 대상으로 심리평가를 실시하여 장애의 원인 및 치료 방안을 파악하고 심리적 기법을 활용하여 치료를 한다.","doWork":"인지장애, 신경증적 장애, 정신증적 장애, 성격장애 등 정신 장애를 가진 환자 또는 일반인을 대상으로 관찰하고 인지검사, 성격검사, 신경심리검사를 실시하고 해석한다. 질환의 원인을 분석하고 치료방법, 빈도, 강도, 기간 등 적절한 치료계획을 수립한다. 정신분석, 내담자중심 상담, 행동치료, 인지치료, 인지행동치료, 심리극, 학습치료, 놀이치료 등 여러 가지 치료적 접근법을 활용하여 이상 심리와 정신 장애를 치료한다. 심리평가 결과와 치료경과에 대해 정신과 의사 등 정신보건 관련 전문가들과 함께 토론하고 공조한다. 정신 장애 및 사회부적응 등 장애의 심리적 원인과 과정을 밝혀내기 위해 연구한다. 정신병리의 진단 및 치료를 위한 방법이나 도구를 개발한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"자문","workFunc3":"관련없음","certLic":"정신건강임상심리사, 임상심리사","dJobECd":"3066","dJobECdNm":"[3066]임상심리사","dJobJCd":"2457","dJobJCdNm":"[2457]임상심리사","dJobICd":"Q869","dJobICdNm":"[Q869]기타 보건업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007564:1', '{"dJobCd":"K000007564","dJobCdSeq":"1","dJobNm":"놀이치료사","workSum":"아동들이 갖고 있는 심리적 부적응이나 발달상의 문제를 놀이라는 매체를 통해 원인을 평가하고 진단 및 치유한다.","doWork":"보호자 또는 아동과 상담하여 아동의 개인발달사항, 가족관계, 학습활동 등을 조사하고 기록한다. 각종 검사를 실시하여 심리적 문제의 유형 및 정도를 판별하고 진단한다. 의료진단서, 검사결과지, 상담기록지 등의 자료를 토대로 아동의 상태를 진단한다. 놀이기구를 설치한 놀이방에서 아동이 선택한 기구로 놀이를 진행한다. 사회관계 형성·유지에 필요한 능력을 진단하거나 이를 증진시키기 위해 집단적 치료활동을 수행한다. 놀이치료가 끝난 후에는 아동 및 보호자를 상대로 지도활동을 하고, 결과보고서를 작성한다. 아동의 상태변화를 확인하고, 추후 놀이치료의 방향을 계획한다. 교육기관, 의료기관, 아동상담센터 등의 자문역할을 수행한다. 놀이기구에 관한 정보를 수집하고, 직접 구매하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"조정","workFunc2":"교육","workFunc3":"관련없음","connectJob":"아동상담사, 아동치료사, 행동치료사, 아동심리치료사","dJobECd":"3069","dJobECdNm":"[3069]기타 치료·재활사 및 의료기사","dJobJCd":"2459","dJobJCdNm":"[2459]기타 치료·재활사 및 의료기사","dJobICd":"Q869","dJobICdNm":"[Q869]기타 보건업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004904:1', '{"dJobCd":"K000004904","dJobCdSeq":"1","dJobNm":"대체요법사","workSum":"노인전문병원에서 노인의 건강관리와 병세호전을 위해 아로마치료 등 대체요법을 계획하고 실시하여 평가한다.","doWork":"질문이나 기타 기록을 통해서 환자의 병명, 증상, 현재 상태, 욕구 등을 파악하고 의료진과 협의하여 아로마치료, 경락 등 대체요법 실시 여부를 결정한다. 치료의 우선 순위를 결정하거나 환자의 병, 증상, 체질 등에 따라 세부 치료방법을 계획하고 결정한다. 치료에 적합한 아로마를 준비하고 혼합하며 관련 장비를 준비한다. 환자에게 치료에 대해 설명하며 대체요법치료를 수행한다. 건강호전 여부 파악 등을 토대로 치료결과를 평가한다. 대체요법에 필요한 물품을 관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"교육","workFunc3":"수동조작","connectJob":"아로마치료사","dJobECd":"3069","dJobECdNm":"[3069]기타 치료·재활사 및 의료기사","dJobJCd":"2459","dJobJCdNm":"[2459]기타 치료·재활사 및 의료기사","dJobICd":"Q869","dJobICdNm":"[Q869]기타 보건업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005951:1', '{"dJobCd":"K000005951","dJobCdSeq":"1","dJobNm":"독서치료사","workSum":"사회적, 정서적 또는 개인적 문제를 안고 있는 아동과 청소년, 성인들에게 독서활동을 기획, 구성, 시행하고 결과를 평가한다.","doWork":"내담자의 심리검사 결과자료, 내담자 및 내담자 부모와의 상담, 그리고 독서치료 관련 부가검사를 실시하여 적용 프로그램을 선정한다. 내담자의 특성과 목표에 따라 독서 자료(책)를 선정하고 독서 자료를 읽어주거나 보여주며, 독서 자료의 내용을 토대로 독서치료를 한다. 치료과정을 녹음하거나 비디오로 촬영하여 치료과정을 세심히 관찰하고 치료일지를 작성한다. 검사를 통하여 내담자의 변화과정 등을 살펴보는 중간평가를 한다. 최종 결과를 검사지나 관련 전문가의 의견을 통하여 평가한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"교육","workFunc3":"관련없음","dJobECd":"3069","dJobECdNm":"[3069]기타 치료·재활사 및 의료기사","dJobJCd":"2459","dJobJCdNm":"[2459]기타 치료·재활사 및 의료기사","dJobICd":"Q869","dJobICdNm":"[Q869]기타 보건업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003287:1', '{"dJobCd":"K000003287","dJobCdSeq":"1","dJobNm":"동물매개치유사","workSum":"개, 고양이, 말, 새 등 도우미 동물들을 통해 몸과 마음에 상처가 있는 사람들이 동물과 상호작용을 하며 정신적·신체적·사회적 기능을 회복하고 심신의 재활 등을 할 수 있도록 돕는다.","doWork":"내담자와 상담하여 신체발달, 언어발달, 신변처리, 건강상태, 사회성, 주변 관계, 동물에 대한 반응 등을 파악하고 상담기록을 작성한다. 치료목표, 횟수, 기간, 도우미 동물 등을 고려하여 치료계획을 수립한다. 동물과 산책하기, 동물과 대화하기, 동물에게 자신의 비밀 말하기, 동물 안아주기, 쓰다듬기, 빗질하기, 훈련시키기, 동물 흉내내기, 동물과 놀이하기, 동물 목욕시키기, 동물에게 명령하기, 먹이주기, 동물의 감정표현 관찰하기, 동물의 행동 설명하기 등 다양한 방법으로 치료를 진행한다. 치료방법 및 반응, 치료내용, 치료사의 의견 등을 기록하고 평가한다. 치료 도우미 동물을 훈련하고 필요할 경우 치료동물을 임대하거나 분양하고 훈련 및 관리를 지원하기도 한다. 복지관, 보육시설, 장애인 생활시설 등에서 치유프로그램을 운영하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"교육","workFunc3":"수동조작","similarNm":"동물매개치료사, 동물매개심리사","dJobECd":"3069","dJobECdNm":"[3069]기타 치료·재활사 및 의료기사","dJobJCd":"2459","dJobJCdNm":"[2459]기타 치료·재활사 및 의료기사","dJobICd":"Q869","dJobICdNm":"[Q869]기타 보건업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005108:1', '{"dJobCd":"K000005108","dJobCdSeq":"1","dJobNm":"미술치료사","workSum":"사회적, 심리적, 정서적 문제를 안고 있는 내담자들의 문제를 해결하기 위하여 미술(조형)활동을 기획, 구성, 시행하고 효과를 평가한다.","doWork":"미술활동과 대화를 통해서 내담자의 심리적 문제를 진단한다. 미술에 대한 흥미, 인지적 발달, 정서상의 문제점 등을 파악한다. 진단 결과를 토대로 내담자 치료를 위한 프로그램을 결정한다. 내담자에게 그림완성하기, 풍경화구성하기 등 미술치료를 수행한다. 프로그램의 진행결과에 대해서 상담일지를 작성한다. 치료결과를 평가한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"조정","workFunc2":"교육","workFunc3":"수동조작","similarNm":"임상미술전문가","dJobECd":"3069","dJobECdNm":"[3069]기타 치료·재활사 및 의료기사","dJobJCd":"2459","dJobJCdNm":"[2459]기타 치료·재활사 및 의료기사","dJobICd":"Q869","dJobICdNm":"[Q869]기타 보건업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001601:1', '{"dJobCd":"K000001601","dJobCdSeq":"1","dJobNm":"산림치유지도사","workSum":"자연경관, 향기 등 자연의 다양한 요소를 활용하여 인체의 면역력을 높이고 건강 증진을 돕는 산림치유프로그램을 개발, 보급 및 지도한다.","doWork":"숲에 대한 다양한 정보와 지식을 수집하고 연구한다. 숲에서의 활동이 인체에 미치는 생리적, 심리적 효과를 심신 치유에 활용하는 산림치유프로그램을 기획한다. 고객이 치유의 숲에 도착하면 오리엔테이션을 진행한다. 고객과 상담하고 건강상태를 점검한다. 준비운동을 진행한다. 식물치유(산림욕, 식물관찰, 방향욕 등), 식이치유(식용 및 약용식물 탐방, 산나물식사 등), 정신치유(산림명상, 산림요가, 숲과 음악, 카운슬링 등), 운동치유(지형치유, 맨발걷기, 힐링워킹 등), 기후치유(산림욕 체조, 해풍욕, 풍욕, 일광욕 등), 물치유(크나이프식 물치유, 냉온수욕, 온천욕, 족욕 등) 등 산림치유 프로그램을 진행한다. 프로그램이 종료되면 느낌나누기, 설문조사 등을 통해 산림치유 성과를 평가한다. 치유의 숲의 시설물 및 물품을 관리한다. 기반시설(숲길, 연못, 야생화 단지 등)을 관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실외","physicalAct":"균형감각|청각|손사용|언어력|시각|","workFunc1":"조정","workFunc2":"교육","workFunc3":"관련없음","similarNm":"산림치유사, 숲치유사, 산림테라피스트","connectJob":"숲해설가, 숲길등산지도사","certLic":"산림교육전문가(산림치유지도사)","dJobECd":"3069","dJobECdNm":"[3069]기타 치료·재활사 및 의료기사","dJobJCd":"2459","dJobJCdNm":"[2459]기타 치료·재활사 및 의료기사","dJobICd":"Q869","dJobICdNm":"[Q869]기타 보건업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003775:1', '{"dJobCd":"K000003775","dJobCdSeq":"1","dJobNm":"언어재활사","workSum":"표준화된 검사와 관찰을 통해 언어장애 환자의 장애원인을 평가·진단하고 치료한다.","doWork":"환자보호자 또는 환자와 상담하여 가족력, 임신력, 태생력, 언어발달력 등을 조사·기록한다. 환자의 발음, 지능 및 어휘력 수준을 판단하기 위하여 각종 지각 및 영상 의학적 검사를 실시하여 환자의 반응을 관찰하고, 그림어휘력검사, 아동언어발달검사 등 표준화된 검사를 실시한다. 조음장애, 언어지체, 실어증, 음성장애, 유창성장애, 청각장애, 구개파열, 뇌성마비 등 언어의 장애원인과 유형 그리고 정도를 판별하고 진단한다. 장애의 정도, 유형, 그리고 부모의 요구를 파악하여 교정치료 계획을 수립·실행하고 지시·감독한다. 장난감, 그림자료, 스크립트, 녹음기, 퍼즐, 이야기발표 등을 활용하여 장애를 치료한다. 사회관계 형성·유지에 필요한 언어사용 능력을 증진시키기 위해서 집단적 치료활동을 수행한다. 치료 경과를 기록한다. 표준화된 검사도구와 자발화를 관찰하여 치료의 효과를 평가한다. 언어장애 환자, 가족, 담당 교사를 상대로 상담 또는 지도활동을 한다. 교육기관, 구강외과 및 기타 의료기관 등의 자문역할을 수행한다. 언어장애의 치료기술 개발을 위해 전문적인 연구를 수행하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"자문","workFunc3":"단순작업","similarNm":"언어요법사, 언어병리사, 음성언어치료사, 언어치료사","certLic":"언어재활사","dJobECd":"3069","dJobECdNm":"[3069]기타 치료·재활사 및 의료기사","dJobJCd":"2459","dJobJCdNm":"[2459]기타 치료·재활사 및 의료기사","dJobICd":"Q869","dJobICdNm":"[Q869]기타 보건업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003600:1', '{"dJobCd":"K000003600","dJobCdSeq":"1","dJobNm":"운동처방사","workSum":"환자의 신체 및 질병의 특성에 따라 운동치료 계획을 수립·처방하며 지도한다.","doWork":"의사의 진료기록을 검토하고 면담을 통해 운동에 따른 문제점을 파악한다. 혈압, 체성분 검사 등 기초체력을 검사한다. 심전도, 대사량 측정 등 운동능력을 검사한다. 면담결과, 진료기록 그리고 검사결과 등을 종합적으로 검토하여 운동치료계획을 수립한다. 고객 또는 환자에게 삼가야 할 운동, 운동방법, 운동횟수 등 운동에 대해 설명한다. 운동처방에 따른 실시 유무 등을 점검하고 평가한다. 운동교실을 운영하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"교육","workFunc3":"수동조작","similarNm":"임상운동사, 두뇌운동전문지도자","certLic":"건강운동관리사","dJobECd":"3069","dJobECdNm":"[3069]기타 치료·재활사 및 의료기사","dJobJCd":"2459","dJobJCdNm":"[2459]기타 치료·재활사 및 의료기사","dJobICd":"Q869","dJobICdNm":"[Q869]기타 보건업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005148:1', '{"dJobCd":"K000005148","dJobCdSeq":"1","dJobNm":"웃음치료사","workSum":"사회적, 심리적, 정서적 문제를 안고 있는 내담자들의 문제를 진단하고 웃음활동을 기획, 시행하며 결과를 평가한다.","doWork":"기존 진단지 검사와 대화를 통해서 내담자의 심리적 문제를 진단한다. 진단결과를 토대로 내담자 치료와 대처능력 증진을 유도하기 위한 웃음 프로그램을 결정한다. 내담자에게 웃음소리, 웃음운동, 웃음명상, 자기표현 등 웃음치료를 수행한다. 프로그램의 진행결과에 대해서 상담일지를 작성한다. 치료결과를 평가한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"교육","workFunc3":"관련없음","certLic":"간호사","dJobECd":"3069","dJobECdNm":"[3069]기타 치료·재활사 및 의료기사","dJobJCd":"2459","dJobJCdNm":"[2459]기타 치료·재활사 및 의료기사","dJobICd":"Q869","dJobICdNm":"[Q869]기타 보건업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001523:1', '{"dJobCd":"K000001523","dJobCdSeq":"1","dJobNm":"원예치료사","workSum":"정신적, 육체적 재활을 목적으로 노인, 장애인, 일반인 등에게 식물을 이용한 원예 활동 및 치료프로그램을 기획하고 실시·평가한다.","doWork":"내담자에게 원예치료 적합성을 검토하기 위한 진단(흥미)검사를 실시한다. 각종 검사결과를 토대로 전문가들과 원예치료의 적합성 등을 검토한다. 내담자의 연령, 장애정도, 지능정도 등을 고려하여 원예치료 프로그램이나 원예활동을 기획한다. 내담자에 대한 면밀한 관찰과 내담자 보호자와의 상담을 통해서 원예치료 방법을 선택한다. 식물재배활동, 판재에 꽃붙이기, 모종하기 등 원예활동을 실시한다. 내담자의 원예치료 결과를 평가한다. 내담자의 정신적·육체적 재활의 개선 여부에 대해 전문가들과 협의한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"교육","workFunc3":"관련없음","dJobECd":"3069","dJobECdNm":"[3069]기타 치료·재활사 및 의료기사","dJobJCd":"2459","dJobJCdNm":"[2459]기타 치료·재활사 및 의료기사","dJobICd":"Q869","dJobICdNm":"[Q869]기타 보건업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003970:1', '{"dJobCd":"K000003970","dJobCdSeq":"1","dJobNm":"음악치료사","workSum":"음악치료 방법을 통해 개인의 정신적, 신체적, 정서적 이상 상태를 복원, 유지, 향상시킨다.","doWork":"우울증, 자폐증, 기타 정신적 발육부진 환자들에 대한 정신과의사의 일차적인 진단이 이루어진 후 해당 환자의 이상 상태를 파악하여 음악치료계획을 수립한다. 환자와 함께 피아노, 오르간, 북, 징, 꽹과리 등의 악기를 이용해서 즉흥 연주 및 작곡을 하면서 환자의 음악적 표현을 이끌어내고 음악연주를 통해 나타나는 환자의 상태를 진단·평가한다. 환자의 진단결과를 정리하여 보호자에게 전달하며, 환자의 특성에 따라 음악적 치료방법을 제시한다. 환자의 치료상 개선상황을 비디오 기록, 각종 파일형태로 지속적으로 관리하며 환자의 상태변화를 주시하고 추가적인 치료방안을 모색하여 치료한다. 음악치료 방법을 개발하고 연구한다. 정신과의사와 더불어 음악치료와 관련된 임상사례를 연구하여 학회 등에 발표하기도 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"청각|","workEnv":"소음·진동|","workFunc1":"조정","workFunc2":"자문","workFunc3":"정밀작업","similarNm":"음악치료전문가","dJobECd":"3069","dJobECdNm":"[3069]기타 치료·재활사 및 의료기사","dJobJCd":"2459","dJobJCdNm":"[2459]기타 치료·재활사 및 의료기사","dJobICd":"Q869","dJobICdNm":"[Q869]기타 보건업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001578:1', '{"dJobCd":"K000001578","dJobCdSeq":"1","dJobNm":"의공사","workSum":"의료기관에서 사용하는 의료기기에 대한 유지보수 관리 업무, 고장 수리, 예방 정비, 안전 점검 및 신규 도입기기에 대한 사양 검토, 설치, 시운전 및 설치 가동 후부터 폐기 시까지의 성능 관리와 의료기기 사용자 교육 등의 업무를 수행한다.","doWork":"병원 내ㆍ외부 환경정보수집, 관리계획, 기획관리, 관리기획평가, 기획결과서 작성 등 의료기기 관리기획업무를 한다. 의료기기에 대한 구매요구사항분석, 정보수집, 구입계획 수립, 규격검토, 기술검토서 작성 등을 토대로 의료기기 구매관리를 수행한다. 내구연한에 따른 의료기기의 정도의 성능 발휘 여부를 평가하기 위하여 성능평가 계획 수립, 성능평가, 성능평가기기관리, 성능평가 결과서 작성 등을 수행한다. 임상에 필요한 의료기기의 요구사항분석, 연구개발지원, 임상시험지원, 기술정보지원, 임상기술지원결과서작성 등을 수행한다. 의료기기 기술관리 계획 수립, 외주기술용역관리, 재고자산관리, 인증관리, 기술관리결과서 작성 등 의료기기기술관리 업무를 한다. 의료기기의 사용 중에 발생할 수 있는 각종 안전사고를 예측하여 방지하는 의료기기 안전관리업무를 수행한다. 의료기기의 설치계획 수립 및 설치, 시험가동 등을 수행한다. 의료기기의 검수, 검수보고서 등을 작성 및 분석하고 그 결과를 토대로 기술검수 계획을 수립 및 실행한다. 의료기기의 성능을 보장하기 위하여 예방점검계획수립, 예방점검을 하고 그 결과를 토대로 의료기기를 유지보수 한다. 의료기기의 성능을 보장하기 위하여 의료기기 수리 및 교정을 하고 유지보수결과서를 작성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"정밀작업","similarNm":"의공기사","certLic":"의공산업기사, 의공기사","dJobECd":"3069","dJobECdNm":"[3069]기타 치료·재활사 및 의료기사","dJobJCd":"2459","dJobJCdNm":"[2459]기타 치료·재활사 및 의료기사","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007743:1', '{"dJobCd":"K000007743","dJobCdSeq":"1","dJobNm":"의학물리사","workSum":"물리학 및 의학 기반 지식과 기술을 활용하여 방사선 치료 계획, 장비 품질관리, 선량 측정 및 검증, 방사선 안전관리 업무를 수행하고, 임상의와 협력하여 환자 치료 전략 수립과 치료 의사결정 과정에 기여한다.","doWork":"방사선 치료 장비(선형가속기(LINAC), CT 모의치료기(Simulator), 영상유도 시스템(IGRT) 등)의 정밀도와 재현성 유지를 위해 주기적인 성능 평가, 기계적/선량적 정도관리(Quality Assurance, QA) 및 출력선량을 교정한다. 방사선종양학과 전문의의 처방에 따라 다중 영상(CT, MRI, PET 등) 정보를 기반으로 치료계획시스템(Treatment Planning System, TPS)을 이용하여 표적 체적(Target Volume)에 처방 선량을 조사한다. 위험 정상 장기(Organ at Risk, OAR)에는 선량을 최소화하는 환자 맞춤형(Patient-specific) 치료 계획을 수립하고 최적화한다. 고정밀 고선량 방사선치료의 경우, 고해상도 영상 융합, 정위 좌표계 설정, 치료계획 수립과 환자 고정 장치의 적용 등을 평가하고 검증한다. 영상 기반 방사선원 삽입 위치 확인, 선량 분포 평가, 방사선원 운용 시스템의 검증 등 근접 방사선 치료(Brachytherapy) 전 과정에 걸쳐 정밀한 물리적 분석과 검토를 수행한다. 임상의와 협의하여 치료 목표, 병기, 장기 기능 보존 여부 등을 고려하여 치료 전략을 수립하고, 복잡한 임상 상황에서 최적의 방사선 적용 방식을 제안한다. 치료 중·후 발생 가능한 부작용을 예측하고, 필요한 경우 선량 조정 또는 계획 변경을 통해 환자 안전을 도모한다. 수립된 치료 계획의 정확한 임상 구현을 검증하기 위해, 팬텀(Phantom)과 검출기(Detector) 기반 측정 시스템으로 환자별 특화된 정도관리를 실시한다. 측정된 선량 분포를 계획과 비교하여 허용 오차 범위를 초과하면 원인을 분석하고 시정한다. 치료 시설의 방사선 차폐 안전성을 평가하고, 작업 환경 모니터링을 통해 환자, 종사자 및 일반인의 방사선 피폭을 최적화한다. 원자력안전법 등 관련 규제 요건에 부합하는 방사선 방호 프로그램을 수립하고 안전 교육을 주관한다. 치료 계획, 선량 기록, 품질관리 결과 등 모든 환자 치료 관련 데이터를 관리하고, 의료 정보 시스템(OIS, TPS, PACS 등)의 상호 운용성(Interoperability)을 확보하고 보안을 유지한다. 첨단 방사선 치료 기술의 임상 도입과 구현에 참여하고, 관련 임상 물리학 연구개발 활동을 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"언어력|시각|","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"교육","workFunc3":"정밀작업","similarNm":"의학물리학자, 임상의학물리학자(Clinical Medical Physicist), 의학물리전문인(Clinically Qualified Medical Physicist, CQMP)","connectJob":"선량계측사(Dosimetrist)","dJobECd":"3062","dJobECdNm":"[3062]방사선사","dJobJCd":"2459","dJobJCdNm":"[2459]기타 치료·재활사 및 의료기사","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2025"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003980:1', '{"dJobCd":"K000003980","dJobCdSeq":"1","dJobNm":"재활승마치료사","workSum":"말을 매개로 환자의 증상에 따라 치료목표를 세우고 치료방법을 찾아 치료를 하며 병원과 협력하여 환자들의 상태가 좋아졌는지 파악한다.","doWork":"환자의 증상에 따라 치료목표를 세우고, 치료방법을 찾는다. 재활승마지도사, 마필관리사와 함께 한 팀이 되어 말의 상태를 살피고, 목욕, 털손질 등의 건강관리를 한다. 말이 머무는 마방의 청결 관리를 한다. 치료과정에서 말이 뛰지 않고 천천히 걸을 수 있도록 훈련을 시킨다. 승마치료 시간이 되면 말과 장구를 준비한다. 환자들의 반응을 살피며 운동의 강도 및 방향성을 지속적으로 관리해준다. 병원과 협력하여 환자들의 상태가 좋아졌는지를 파악한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|청각|손사용|","workFunc1":"조정","workFunc2":"교육","workFunc3":"관련없음","certLic":"작업치료사","dJobECd":"3069","dJobECdNm":"[3069]기타 치료·재활사 및 의료기사","dJobJCd":"2459","dJobJCdNm":"[2459]기타 치료·재활사 및 의료기사","dJobICd":"Q869","dJobICdNm":"[Q869]기타 보건업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004812:1', '{"dJobCd":"K000004812","dJobCdSeq":"1","dJobNm":"전문청능사","workSum":"청각능력 및 평형기능과 관련된 검사, 청각기기 관리, 청능 교육 및 훈련, 청력보존, 청능사 지도 및 청각 교육 및 연구개발 업무를 한다.","doWork":"각종 청각검사 장비를 점검하고 조정한다. 검사 대상자의 상태를 파악하고 이어폰을 부착시키는 등 검사에 필요한 적절한 지시와 처치를 한다. 순음청력검사와 어음청각검사를 실시하고 반응을 기록한다. 검사결과를 해석하고 대상자의 배경정보 및 시험용 보청기의 착용 평가결과를 종합적으로 고려하여 적절한 보청기를 선택한다. 선택한 보청기를 조절, 확인 및 관리하고 청능훈련을 실시하여 청각능력이 회복될 수 있도록 한다. 청력보존 활동을 계획하고 시행한다. 청각계에 관한 생리학, 병리학, 심리음향학 등을 연구하거나 의학전문단체, 특수교육단체 및 기타 전문단체의 자문역할과 보청기 개발을 위한 연구 및 자문 역할을 수행하기도 한다. 의사를 보조하여 전기생리청각검사, 평형기능검사 및 청각이식기의 조절과 관리를 실시하고 평형기능이 회복될 수 있도록 재활을 돕기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"청각|","workFunc1":"조정","workFunc2":"교육","workFunc3":"수동조작","similarNm":"청력기사, 언어청각임상가","connectJob":"청능사","dJobECd":"3069","dJobECdNm":"[3069]기타 치료·재활사 및 의료기사","dJobJCd":"2459","dJobJCdNm":"[2459]기타 치료·재활사 및 의료기사","dJobICd":"Q869","dJobICdNm":"[Q869]기타 보건업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002928:1', '{"dJobCd":"K000002928","dJobCdSeq":"1","dJobNm":"접골사","workSum":"부러진 뼈(골절), 빠진 뼈(탈골), 삔 뼈(염좌) 등이 손상된 환자를 문진하고 손으로 정복, 교정한다.","doWork":"환자의 증상을 물어보고 환자의 환부를 손으로 진단하여 원인을 찾는다. 뼈, 근육, 신경 등의 신체조직의 장애 및 손상을 손으로 치료한다. 부기를 가라앉히기 위해 소염진통제를 바르거나 물리치료기 등을 부가적으로 사용한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"도수정복사","dJobECd":"3069","dJobECdNm":"[3069]기타 치료·재활사 및 의료기사","dJobJCd":"2459","dJobJCdNm":"[2459]기타 치료·재활사 및 의료기사","dJobICd":"Q869","dJobICdNm":"[Q869]기타 보건업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005466:1', '{"dJobCd":"K000005466","dJobCdSeq":"1","dJobNm":"침구사","workSum":"문진으로 환자의 질환을 파악하고 환부에 침을 놓거나 뜸으로 치료한다.","doWork":"환자와의 상담과 진맥 등으로 환자의 질환과 질환의 경중을 파악한다. 환자의 질환에 따라 침법과 구법 등 치료방법을 선택한다. 치료를 위한 선혈을 선택한다. 환부를 알코올로 소독한다. 소독기, 멸균기를 사용하여 침을 소독한다. 침을 놓거나 뜸을 놓으며 부황기를 사용하여 부황을 뜬다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"조정","workFunc2":"자문","workFunc3":"정밀작업","dJobECd":"3069","dJobECdNm":"[3069]기타 치료·재활사 및 의료기사","dJobJCd":"2459","dJobJCdNm":"[2459]기타 치료·재활사 및 의료기사","dJobICd":"Q869","dJobICdNm":"[Q869]기타 보건업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007461:1', '{"dJobCd":"K000007461","dJobCdSeq":"1","dJobNm":"응급구조사","workSum":"응급환자 발생 시 현장으로 출동하여 필요한 조치를 취하고 병원이송 중에 환자를 간호한다.","doWork":"방제센터 또는 응급구조센터로부터 지령을 접수한다. 현장으로 출동하여 환자상태를 파악한다. 심폐소생술, 지혈, 부목, 소독 등 응급처치를 한다. 병원이송 여부를 판단하여 환자를 병원으로 이송한다. 의료진에게 환자의 상태를 설명한다. 응급구조 차량의 비품을 보충하고 기자재를 정리한다. 필요에 따라 차량을 소독한다. 각종 환자 관련 자료를 정리하고 통계를 작성한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"수동조작","certLic":"응급구조사","dJobECd":"3071","dJobECdNm":"[3071]응급구조사","dJobJCd":"2461","dJobJCdNm":"[2461]응급 구조사","dJobICd":"Q869","dJobICdNm":"[Q869]기타 보건업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005038:1', '{"dJobCd":"K000005038","dJobCdSeq":"1","dJobNm":"응급구조전문상담원","workSum":"응급환자의 상태를 전화상으로 파악하여 적절한 조치를 취하고 담당 지역의 의료자원에 대한 정보를 수집·관리한다.","doWork":"응급환자나 보호자와의 전화통화를 통해서 환자의 상태를 파악한다. 파악된 환자상태에 따라 응급처치법 등 기본적인 상담을 한다. 중증 환자의 경우 응급구조대와 연결하여 병원이송을 돕는다. 해당 지역의 의료자원(병원, 병상 수, 전문 분야, 의료장비)에 대한 정보를 수집하고 정리한다. 실시간으로 해당 지역 의료자원 현황을 파악한다. 일반인을 대상으로 응급처치법 등에 대해 교육한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","certLic":"응급구조사","dJobECd":"3071","dJobECdNm":"[3071]응급구조사","dJobJCd":"2461","dJobJCdNm":"[2461]응급 구조사","dJobICd":"Q869","dJobICdNm":"[Q869]기타 보건업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003821:1', '{"dJobCd":"K000003821","dJobCdSeq":"1","dJobNm":"일일구(119)구조대원","workSum":"각종 재난 및 재해 발생 시 신속하고 안전한 인명구조 활동을 수행한다.","doWork":"화재, 교통사고 등 각종 인명구조 상황 발생 시 차량, 헬기 등을 이용하여 긴급 출동한다. 현장에서 화재를 진압하고 인명을 구조한다. 인명구조작업 결과를 기록·유지한다. 인명구조 장비의 취급방법 등을 훈련한다. 새로 개발된 구조구난 기법을 습득한다. 관할 지역 내 주요 소방대상물에 대한 현지 적응훈련에 참가한다. 구조업무에 대해 홍보한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|고온|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"구조구급소방관","connectJob":"수상구조대원, 119항공구조대원, 항공구조사, 전탐사","certLic":"응급구조사","dJobECd":"3071","dJobECdNm":"[3071]응급구조사","dJobJCd":"2461","dJobJCdNm":"[2461]응급 구조사","dJobICd":"O844","dJobICdNm":"[O844]사법 및 공공질서 행정","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004858:1', '{"dJobCd":"K000004858","dJobCdSeq":"1","dJobNm":"소독관리자","workSum":"사업체 및 주택 등 고객의 위상상태를 점검·관리하며 구충, 살균, 소독하는 작업원들의 활동을 감독·조정한다.","doWork":"사업체, 주택, 운송시설, 공공시설물 등 고객이 요구하는 지역을 검사하여 바퀴벌레, 모기 등 해충이나 주방의 오염상태를 확인하고 오염원 및 취약지구를 확인한다. 검사결과에 따라 고객에게 필요한 소독 및 방제, 방역서비스의 내용과 방역에 필요한 절차를 설명한다. 소독방법과 소독에 필요한 약품의 종류와 양을 결정하고 구충 및 살균계획을 수립한다. 구충, 살균, 소독에 종사하는 방역원에게 작업할 장소 및 투여약품의 종류 등을 설명하고 활동을 감독한다. 고객을 대상으로 위생교육을 실시한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|","workFunc1":"수집","workFunc2":"감독","workFunc3":"수동조작","similarNm":"방제관리자, 방역관리자, 소독관리인, 위생사","certLic":"위생사","dJobECd":"3072","dJobECdNm":"[3072]위생사","dJobJCd":"2462","dJobJCdNm":"[2462]위생사","dJobICd":"N742","dJobICdNm":"[N742]건물ㆍ산업설비 청소 및 방제 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007509:1', '{"dJobCd":"K000007509","dJobCdSeq":"1","dJobNm":"안경사","workSum":"고객에게 안과와 관련된 제반 검사를 실시하고 안경 및 콘택트렌즈를 처방해주며 시력 보조구의 사용에 관하여 조언한다.","doWork":"고객의 시력 관련 문제나 안과문제를 상담하고 문진한다. 고객에게 자동시력검사기인 포롭터(Phoroptor) 등의 기계나 검안장비를 이용하여 시력검사를 실시한다. 안경, 콘택트렌즈 또는 기타 시력증진을 위한 처방을 한다. 눈동자 간의 거리 및 코의 높이 등을 피디(자)를 사용하여 측정하고 고객 얼굴에 맞는 안경테를 추천한다. 자동굴절검사기(Auto Reflector)와 각막곡률측정기(Keratomerter)를 이용하여 안구의 굴절률과 각막의 곡률을 측정한다. 시력에 맞는 렌즈를 선택하고 렌즈가공기를 사용하여 선택한 안경테에 맞추어 렌즈를 가공하여 조립한다. 안경 또는 콘택트렌즈의 세척 및 착용 방법을 설명하고 시력 보호를 위한 조명 및 시력 보조구에 관하여 조언한다. 보안경, 선글라스 및 기타 특수안경을 판매한다. 의학적 치료가 요구되는 경우 안과 치료를 권유한다. 고객의 직업, 패션 등에 적합한 안경테 선정을 위한 서비스를 제공하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"검안사","certLic":"안경사","dJobECd":"3073","dJobECdNm":"[3073]안경사","dJobJCd":"2463","dJobJCdNm":"[2463]안경사","dJobICd":"G478","dJobICdNm":"[G478]기타 상품 전문 소매업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007492:1', '{"dJobCd":"K000007492","dJobCdSeq":"1","dJobNm":"보건의료정보관리사","workSum":"보건 의료기관 이용자의 건강 및 질병에 관한 자료를 수집, 분석, 관리한다.","doWork":"환자들의 기본정보 및 의무기록 자료를 수집한다. 의무기록의 충실성과 완결성을 분석한 후 미비기록 체크리스트를 작성하여 관리한다. 질병분류번호, 사인분류번호, 의료행위분류번호, DRG분류번호 등을 부여한다. 초진기록지를 생성한다. 새로운 의무기록서식을 개발한다. 의무기록지를 정리하여 보관한다. 진료기록지를 전사한다. 수집된 정보를 컴퓨터 데이터베이스에 정리한다. 의학연구정보, 경영지원정보, 병원평가정보 등을 생성, 분석, 제공한다. 의료 정보자료를 분석하여 통계자료를 만든다. 의료기록 대출 등 의무기록 이용에 대해 지원한다. 의무기록 정보보호를 위한 의료진 서명관리 접근권한관리, 의무기록 복사·열람·정보요구에 대한 권한관리를 한다. 전자의무기록 개발, 의료자료보관체계 등 의료정보체계 구축에 참여한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"의무기록사","certLic":"보건의료정보관리사","dJobECd":"3074","dJobECdNm":"[3074]의무기록사","dJobJCd":"2464","dJobJCdNm":"[2464]의무 기록사","dJobICd":"Q869","dJobICdNm":"[Q869]기타 보건업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001765:1', '{"dJobCd":"K000001765","dJobCdSeq":"1","dJobNm":"의무기록관리자","workSum":"의무기록업무를 기획, 검토, 조정하고 의무기록사를 관리·감독한다.","doWork":"의무기록 업무를 총괄하고 업무 계획을 수립한다. 의무기록사(보건의료정보관리사)에게 업무를 배정한다. 수행된 의무기록 업무 내용을 검토하고 조정한다. 의무기록 관련 법률, 최신지견 및 각종 정보를 수집하여 의무기록 작성 및 관리 정책의 의사결정을 지원하다. 의무기록위원회 등에서 활동을 한다. 의료인 및 의무기록사를 대상으로 의무기록 작성 및 관리에 관해 교육한다. 정부부처, 유관단체 등에 의료 정보를 제공한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","certLic":"보건의료정보관리사","dJobECd":"3074","dJobECdNm":"[3074]의무기록사","dJobJCd":"2464","dJobJCdNm":"[2464]의무 기록사","dJobICd":"Q869","dJobICdNm":"[Q869]기타 보건업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007576:1', '{"dJobCd":"K000007576","dJobCdSeq":"1","dJobNm":"간호조무사","workSum":"의료기관, 요양시설, 사회복지시설 등에서 간호와 진료업무를 보조한다.","doWork":"내원 환자를 안내하고 진료를 위한 준비를 한다. 검사와 투약을 도와준다. 간호처치를 도와준다. 환자상태를 보고한다. 임종간호를 도와준다. 병원의 행정업무를 지원한다. 물품관리, 문서관리를 도와준다. 환자를 돌보거나 운동을 시켜준다. 사고예방 등 치료적 환경을 유지한다. 주사행위, 각종 의료검사 및 투약업무를 보조한다. 임산부의 상황을 관찰하고 보고한다. 신생아를 관리한다. 수술을 준비하고 보조한다. 수술실의 기구를 정리한다. 수술회복 후 환자를 관리하고 회복경과를 기록·보고한다. 정신병원의 경우 보호실 환자를 관리하며 병실 출입구 및 잠금장치를 관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"수동조작","certLic":"간호조무사","dJobECd":"3075","dJobECdNm":"[3075]간호조무사","dJobJCd":"2465","dJobJCdNm":"[2465]간호조무사","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007547:1', '{"dJobCd":"K000007547","dJobCdSeq":"1","dJobNm":"안마사","workSum":"안마, 마사지, 지압 등의 각종 수기요법 및 자극요법으로 인체에 대한 물리적 시술행위를 한다.","doWork":"과거의 병력을 포함하여 신체 이상 유무에 대해 고객과 상담한다. 손을 이용하여 피부온도, 근육의 긴장도를 파악하고 압통점에 대한 자극 등을 통해서 상태를 파악한다. 손을 이용한 수기법(주무르고, 문지르고 두드리는 등)으로 시술한다. 열이나 광선, 고주파 및 저주파치료기를 사용하여 치료한다. 고객에게 자세교정 방법, 체중감소를 위한 교정법, 그리고 운동법을 알려 준다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"안마사","dJobECd":"3076","dJobECdNm":"[3076]안마사","dJobJCd":"2466","dJobJCdNm":"[2466]안마사","dJobICd":"S961","dJobICdNm":"[S961]미용, 욕탕 및 유사 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004270:1', '{"dJobCd":"K000004270","dJobCdSeq":"1","dJobNm":"사회복지사(일반)","workSum":"학교, 병원, 수용시설, 비수용시설, 국가기관 등에서 아동, 청소년, 장애인, 노인, 여성 등을 대상으로 그들의 재활과 사회복귀를 돕기 위해 사정, 진단, 상담, 프로그램 개발, 기획, 실시, 평가, 지원, 교육 등의 업무를 수행한다.","doWork":"상담을 통해 사회복지 대상자의 욕구, 개선점, 보유 자원과 대상자 가족의 지원, 재정적인 문제 등에 대해 사정한다. 행정적, 재정적, 심리적, 사회적으로 지원해야 할 점을 파악하고 우선순위를 정한다. 심리 안정, 교육 및 훈련, 정서순화, 대인관계기술 습득, 건강유지 등 다양한 프로그램을 개발·기획하고 실시한다. 후원자나 자원봉사자를 모집하고 사회복지대상자에 대한 사회적 편견을 제거하기 위한 활동을 한다. 프로그램이나 기관에 대해 지역사회 사업장을 중심으로 홍보한다. 프로그램 및 각종 사회복지 활동 이후 그 결과에 대해 평가하고 개선책을 모색한다. 직업재활이나 취업을 위해 사업장을 개발하고 고용지원을 한다. 사회복지 대상자 가족을 대상으로 스트레스 감소, 환자 이해, 가정 내 지원 등에 대해 상담하고 프로그램을 운영한다. 수행업무에 대한 보고서를 작성하고 관련 행정업무를 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"아동사회복지사, 장애인사회복지사, 노인사회복지사, 여성사회복지사, 교화사회복지사, 활동하는 장소에 따라 학교사회복지사, 정신건강사회복지사, 의료사회복지사, 사회복지전담공무원, 재활자활사회복지사","certLic":"사회복지사(1급, 2급), 정신건강사회복지사, 직업상담사(1급, 2급)","dJobECd":"2311","dJobECdNm":"[2311]사회복지사","dJobJCd":"2471","dJobJCdNm":"[2471]사회복지사","dJobICd":"O842/Q871/Q872","dJobICdNm":"[O842]사회 및 산업정책 행정 / [Q871]거주 복지시설 운영업 / [Q872]비거주 복지시설 운영업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001980:1', '{"dJobCd":"K000001980","dJobCdSeq":"1","dJobNm":"사회복지전담공무원","workSum":"국민기초생활보장수급자 등 사회복지 대상을 선정하고 이들에게 공적부조와 복지서비스를 제공한다.","doWork":"국민기초생활보장수급자 등 사회복지 사업의 신청을 접수한다. 최저생계비, 신청자의 재산, 소득, 부양가족 등의 자료와 신청자와의 상담을 토대로 수급자를 선정한다. 수급자에게 생계, 주거, 교육, 장례, 출산 등의 급여를 지급한다. 장애인 차량지원, 경로당지원, 노인교통비지급, 소년소녀가장지원, 급식아동지원, 보육지원 사업을 기획하고 실행한다. 자활이 가능한 대상자를 선정하여 지역사회 사업장이나 관련 기관에 의뢰하여 근로할 수 있도록 지원하고 급료를 지급한다. 자원봉사자를 발굴하고 교육하며 배치한다. 지역 내 사회복지기관과 연계하고 자원봉사자를 연결한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"자문","workFunc3":"관련없음","certLic":"사회복지사","dJobECd":"2311","dJobECdNm":"[2311]사회복지사","dJobJCd":"2471","dJobJCdNm":"[2471]사회복지사","dJobICd":"O845","dJobICdNm":"[O845]사회보장 행정","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001538:1', '{"dJobCd":"K000001538","dJobCdSeq":"1","dJobNm":"아동보호전담요원","workSum":"보호대상아동의 보호체계 진입부터 분리, 보호결정 및 보호, 자립지원 및 사후관이 과정에 개입하고 모니터링 한다.","doWork":"보호대상 아동을 상담하고, 건강검진, 심리검사 가정환경을 조사한다. 조사 결과를 바탕으로 아동의 보호조치를 결정한다. 아동의 분리보호가 결정된 후, 가정 외 보호기관(가정위탁지원센터, 공동생활가정, 양육시설, 입양기관 등)과 협업하여 아동에 대한 서비스계획을 수립한다. 분리보호 서비스를 제공하며, 서비스 제공 상황과 원가정 상황 등을 정기적으로 점검한다. 모니터링 결과 서비스 제공 계획에 변경 필요성을 검토하고, 필요시 수정하여 서비스를 제공한다. 양육상황을 점검하고, 점검 결과에 대하여 보호조치 목적 달성 여부 등을 평가한다. 보호아동이 원가정에 복귀하거나 연령 도래로 아동보호서비스가 종료되는 경우 아동분리상황이 재발생하지 않도록 가정방문서비스기관(드림스타트, 희망복지원단 등)과 연계하여 아동을 지도하고 관리한다. 보호아동에 대하여 아동보호 서비스의 보호 조치를 변경 및 종결할 때 개별 아동에 대해 전문적 ·개별적 심의가 가능하도록 사례결정위원회를 소집하고 운영한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","certLic":"사회복지사(1급, 2급), 정신건강사회복지사 2급","dJobECd":"2311","dJobECdNm":"[2311]사회복지사","dJobJCd":"2471","dJobJCdNm":"[2471]사회복지사","dJobICd":"O842","dJobICdNm":"[O842]사회 및 산업정책 행정","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001535:1', '{"dJobCd":"K000001535","dJobCdSeq":"1","dJobNm":"아동학대전담공무원","workSum":"아동학대사건 피해아동을 상담 및 사건 관련자를 조사하고, 피해아동보호계획 수립·조치 및 아동학대사건 사례를 관리·점검한다.","doWork":"아동학대사건 신고를 접수하고, 현장에 출동한다. 피해아동을 상담하고 아동학대행위자 등 사건관련자를 조사한다. 아동학대 여부를 판단하고 피해아동보호계획을 수립한다. 아동보호전문기관과 연계하여 아동보호 조치한다. 국가아동학대정보시스템에 정보를 입력·관리한다. 아동보호전문기관의 신체적·정신적 아동학대 사례를 관리·점검한다. 아동학대 예방과 관련된 업무를 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","certLic":"사회복지사(1급, 2급), 정신건강사회복지사 2급","dJobECd":"2311","dJobECdNm":"[2311]사회복지사","dJobJCd":"2471","dJobJCdNm":"[2471]사회복지사","dJobICd":"O842","dJobICdNm":"[O842]사회 및 산업정책 행정","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006757:1', '{"dJobCd":"K000006757","dJobCdSeq":"1","dJobNm":"자립지원전담요원","workSum":"양육시설·공동생활가정·위탁가정에서 보호되고 있는 보호대상아동이 성인기에 자립생활을 할 수 있도록 보호되고 있는 동안에 체계적 자립준비를 할 수 있도록 지원한다.","doWork":"보호대상아동(만 15세이상)에 대해 자립기술을 평가하고, 자립지원계획을 수립한다. 보호아동을 대상으로 연령별·영역별 자립지원표준화프로그램을 운영한다. 대상아동의 자립지원 관련 현황에 대하여 DB를 입력하고 관리사항을 지자체에 보고한다. 보호종료 전 철저하게 자립준비를 하도록 지원하고, 보호종료점검 자립프로그램을 운영한다. 보호대상아동이 자립정착금을 수령하기 1개월 이전에 자립정착금 사용계획서를 자자체에 제출하고, 정착금 수령 후 계획에 맞게 사용하였는지 모니터링한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"자문","workFunc3":"관련없음","certLic":"사회복지사 2급, 직업상담사 2급, 청소년상담사 2급, 청소년지도사","dJobECd":"2311","dJobECdNm":"[2311]사회복지사","dJobJCd":"2471","dJobJCdNm":"[2471]사회복지사","dJobICd":"Q871/Q872","dJobICdNm":"[Q871]거주 복지시설 운영업 / [Q872]비거주 복지시설 운영업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006980:1', '{"dJobCd":"K000006980","dJobCdSeq":"1","dJobNm":"자립지원전담인력","workSum":"자립준비청년의 자립 정착을 위하여 교육·컨설팅하고, 자립지원통합서비스 대상자를 선정·사후관리한다.","doWork":"자립준비청년(5년 이내 보호종료아동)을 대상으로 사후관리계획수립, 자립수준평가, 자립실태조사 등 사후관리, 사후관리 데이터 입력·관리한다. 보호종료 이후, 보호아동의 자립 정착을 위하여 자립목표설정과 주거 관리 교육을 실시한다. 자립정착금사용, 재정관리 등의 컨설팅을 한다. 아동복지시설과 가정위탁 등의 보호 종료 5년 이내 자립준비청년 중 초기상담을 거쳐 자립지원통합서비스 대상자로 선정한다. 사례관리 제공, 공공·민간자원을 발굴·연계하는 등 맞춤형 자립지원통합서비스를 제공한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"자문","workFunc3":"관련없음","certLic":"사회복지사 2급, 정신건강전문요원 2급, 청소년상담사 2급, 청소년지도사","dJobECd":"2311","dJobECdNm":"[2311]사회복지사","dJobJCd":"2471","dJobJCdNm":"[2471]사회복지사","dJobICd":"Q872","dJobICdNm":"[Q872]비거주 복지시설 운영업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004833:1', '{"dJobCd":"K000004833","dJobCdSeq":"1","dJobNm":"자원봉사관리자","workSum":"자원봉사자의 홍보·모집 및 교육을 비롯하여 면접·선발·배치, 그리고 이들의 원활한 활동을 지원하기 위하여 관련 사업을 기획·조정·관리한다.","doWork":"지역사회 문제를 진단, 예방, 해결하기 위하여 자원봉사자를 모집하고 수요처를 개척한다. 자원봉사자와 지역사회의 자원봉사 욕구를 파악하고 적절한 인력을 선발, 배치하는 등 연결한다. 자원봉사자들의 지속적인 참여를 유도하고 동기를 강화시키기 위하여 다양한 교육과 훈련을 기획하고 운영한다. 사회변화와 새로운 욕구에 대응한 봉사 프로그램과 자원봉사자를 개발한다. 자원봉사활동 자료와 기록을 통계 처리하고 연간 사업보고서 등 사무적인 활동을 한다. 자원봉사활동으로 진행되는 상황들을 지역사회에 다양한 매체를 통해 알리고 전시, 행사 등을 진행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"자원봉사관리사","certLic":"사회복지사, 청소년지도사","dJobECd":"2311","dJobECdNm":"[2311]사회복지사","dJobJCd":"2471","dJobJCdNm":"[2471]사회복지사","dJobICd":"O842/Q871/Q872","dJobICdNm":"[O842]사회 및 산업정책 행정 / [Q871]거주 복지시설 운영업 / [Q872]비거주 복지시설 운영업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004845:1', '{"dJobCd":"K000004845","dJobCdSeq":"1","dJobNm":"장애인재활상담사","workSum":"개인의 손상이나 기능제한, 상황적 요인 등으로 개인 활동이나 사회참여가 어려운 사람들에게 진단과 평가, 재활상담과 사례관리, 전환기 서비스 및 직업재활 등의 전반적인 서비스를 지원한다.","doWork":"상담을 통해 이용자의 기초정보를 수집하고 각종 검사 및 직업평가 등을 통해 장애를 진단하고 평가 보고서를 작성한다. 이용자의 개인별 재활계획에 따라 필요한 전환·직업적응훈련 프로그램, 직업훈련 및 관련 정보제공, 구직탐색훈련 프로그램, 자립생활·사회적응훈련 프로그램, 보호·지원·맞춤식 고용 등 고용프로그램, 취업 후 적응지도, 장애인식 및 차별 개선 관련 프로그램 등의 재활서비스를 운영한다. 이용자의 적합한 직무 개발을 위해 지역사회 노동시장 조사, 고용주 및 인사 담당자 면담, 작업현장 관찰, 직무분석 및 직무조정(보조공학서비스), 구인·구직자 매칭, 사업주 지원 자원개발 및 정보제공, 고용주·구직자 간담회 및 교육 등을 수행한다. 재활계획 실행을 모니터링하고 재활계획서를 작성하여 사례를 관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"자문","workFunc3":"관련없음","similarNm":"직업재활사","connectJob":"장애인직업능력평가사, 직업훈련교사","certLic":"사회복지사, 장애인재활상담사","dJobECd":"2311","dJobECdNm":"[2311]사회복지사","dJobJCd":"2471","dJobJCdNm":"[2471]사회복지사","dJobICd":"Q871/Q872","dJobICdNm":"[Q871]거주 복지시설 운영업 / [Q872]비거주 복지시설 운영업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003564:1', '{"dJobCd":"K000003564","dJobCdSeq":"1","dJobNm":"주거복지사","workSum":"취약계층 등 자력으로 주거문제를 해결하기 힘든 가구를 대상으로 주거환경 개선지원, 주거복지 상담과 관련 정보제공, 그리고 주거서비스 제공 혹은 연계를 통해 주거문제해결 방안을 제공한다.","doWork":"지역의 주거복지 실태를 조사하고 분석한다. 주거복지 대상자를 발굴한다. 주택개조 지원서비스를 제공한다. 주택상태를 점검한다. 거주자의 고충을 듣고 주거 등 생활에 대해 상담한다. 주거생활에 대해 정보를 제공하고 사례관리를 한다. 공공임대 주택 간 주거이동을 지원하다. 지불 가능한 임대주택 및 자가 주택의 탐색을 지원한다. 민, 관, 공공 간의 주거복지 네트워크를 구축한다. 주거복지 서비스의 지원을 위한 외부 자원을 발굴하고 연계한다. 커뮤니티를 활성화하고 이를 위한 프로그램을 기획하고 관리한다. 주거복지 관련 주민을 교육하고 홍보한다. 공공 및 민간 임대주택을 관리한다. 주거복지 사업을 기획, 제안하고 수행하며 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"자문","workFunc3":"관련없음","certLic":"주거복지사","dJobECd":"2311","dJobECdNm":"[2311]사회복지사","dJobJCd":"2471","dJobJCdNm":"[2471]사회복지사","dJobICd":"Q871/Q872","dJobICdNm":"[Q871]거주 복지시설 운영업 / [Q872]비거주 복지시설 운영업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007179:1', '{"dJobCd":"K000007179","dJobCdSeq":"1","dJobNm":"학교사회복지사","workSum":"학교에서 일어나는 학생의 문제들을 학생-학교-가정-지역사회의 연계(방법)를 통해 예방하고 해결하며 모든 학생이 자신의 잠재력과 능력을 최대한 발휘할 수 있도록 최상의 교육환경과 공평한 교육기회를 제공한다.","doWork":"학생의 심리사회적인 문제와 학생에게 영향을 미치는 주변 환경 전체의 변화에 대한 계획을 수립 및 지원한다. 학교 내ㆍ외부 환경 및 욕구를 조사한다. 사례를 발굴 및 선정한다. 학교 내ㆍ외 네트워크 구성 및 운영한다. 학교사회복지 개입을 위한 기록 및 평가를 한다. 학교사회복지사의 전문성 강화 및 역량을 개발한다. 그 외 보건복지부장관이 정하는 학교사회복지 활동을 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"학교 내 사회복지사, 학교현장 사회복지전문가","connectJob":"교육복지사, 지역사회교육전문가, 복지상담사, 상담복지사","certLic":"학교사회복지사, 사회복지사","dJobECd":"2311","dJobECdNm":"[2311]사회복지사","dJobJCd":"2471","dJobJCdNm":"[2471]사회복지사","dJobICd":"P85","dJobICdNm":"[P85]교육 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007502:1', '{"dJobCd":"K000007502","dJobCdSeq":"1","dJobNm":"보육교사","workSum":"어린이집, 놀이방 등 보육시설이나 아동복지시설에서 영유아들을 보살피고 교육한다.","doWork":"위탁된 영유아를 연령이나 발달단계에 따라 영아반 및 유아반에 배치한다. 영유아의 신체적, 사회적, 정서적, 지적발달이 균형 있게 이루어질 수 있도록 교육방법을 찾고 적용한다. 일일, 월간, 그리고 연간 세부 보육 및 교육계획을 세운다. 유아의 정서 및 지능발달을 위하여 그림책, 장난감, 악기, 미끄럼틀, 그네 등의 설비를 준비하고 자유놀이와 집단유희를 지도한다. 일정한 시간에 영유아에게 우유나 음식을 먹인다. 취침, 목욕, 용변 등을 보살피고 생활습관을 가르친다. 수면 및 휴식시간을 조절하고 영유아들의 건강을 살핀다. 관찰 및 지도의 경과에 대해 보육일지에 기록한다. 유아들의 현장학습을 준비하고 인솔한다. 비품을 관리하고 실내외를 정리·정돈한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"언어력|","workFunc1":"수집","workFunc2":"교육","workFunc3":"수동조작","similarNm":"보육사, 어린이집교사","certLic":"보육교사","dJobECd":"2321","dJobECdNm":"[2321]보육교사","dJobJCd":"2472","dJobJCdNm":"[2472]보육교사","dJobICd":"Q871/Q872","dJobICdNm":"[Q871]거주 복지시설 운영업 / [Q872]비거주 복지시설 운영업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004481:1', '{"dJobCd":"K000004481","dJobCdSeq":"1","dJobNm":"장애인직업능력평가사","workSum":"장애인의 직업선택을 지원하기 위해 신체, 심리, 사회, 직업적 측면을 종합적으로 분석하고 평가한다.","doWork":"평가의뢰서를 바탕으로 대상자 및 가족의 면담 등을 통해 직업 재활 이론과 면담 기법을 활용하여 직업 수행평가에 필요한 대상의 정보를 수집·분석하고 그 결과를 기록한다. 대상자에게 적절한 직업평가 서비스를 제공하기 위해 대상자의 정확한 잠재 능력과 욕구를 파악할 수 있도록 평가 계획서를 작성한다. 평가 계획서에 따라 인지, 성격, 흥미, 적성검사 등 심리적 특성, 신체 능력, 손 기능, 양팔, 조립, 사무능력 등 작업능력을 파악하기 위해 각각의 평가도구들을 선정하고 평가를 수행한다. 모의 작업장이나 현장 사업체 등 다양한 상황에서 대상자의 작업 수행과 대인관계 능력을 객관적으로 측정한다. 평가 결과를 바탕으로 직업적 의사결정을 도와주며, 재활 과정에서 일어날 수 있는 모든 문제의 해결 능력을 향상시켜 줄 수 있도록 상담하고, 필요시 재활 서비스 방향에 대해 관리자와 상의한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"청각|언어력|시각|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","certLic":"직업상담사(1급, 2급), 장애인재활상담사","dJobECd":"2314","dJobECdNm":"[2314]직업상담사","dJobJCd":"2473","dJobJCdNm":"[2473]직업상담사","dJobICd":"Q872","dJobICdNm":"[Q872]비거주 복지시설 운영업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007565:1', '{"dJobCd":"K000007565","dJobCdSeq":"1","dJobNm":"직업상담사","workSum":"구직자나 미취업자에게 직업 및 취업정보를 제공하고, 직업선택, 경력설계, 구직활동 등에 대해 조언한다.","doWork":"직업의 종류, 전망, 취업기회 등에 관한 자료를 수집하고 관리한다. 구직자와 면담하거나 검사를 통하여 취미, 적성, 흥미, 능력, 성격 등의 요인을 조사한다. 적성검사, 흥미검사 등 직업심리검사를 실시하여 구직자의 적성과 흥미에 알맞은 직업정보를 제공한다. 구직자에게 적합한 취업정보를 제공하고 직업선택에 관해 조언한다. 비디오, 슬라이드 등의 시청각장비를 사용하여 직업정보 및 직업윤리 등을 교육하기도 한다. 청소년, 여성, 중고령자, 실업자 등을 위한 직업지도 프로그램 개발과 운영을 담당하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"자문","workFunc3":"관련없음","similarNm":"직업상담원","certLic":"직업상담사(1급, 2급)","dJobECd":"2314","dJobECdNm":"[2314]직업상담사","dJobJCd":"2473","dJobJCdNm":"[2473]직업상담사","dJobICd":"N751","dJobICdNm":"[N751]고용알선 및 인력공급업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005692:1', '{"dJobCd":"K000005692","dJobCdSeq":"1","dJobNm":"금연상담사","workSum":"내담자의 금연을 돕기 위해 금연상담을 진행하고 흡연에 대한 예방교육을 실시한다.","doWork":"초기상담에서 혈압, 신장, 체중, 호기일산화탄소, 니코틴의존도, 흡연력을 측정한다. 내담자의 금연의지를 확인하고 구체적인 금연방법을 결정한다. 내담자의 흡연량 등에 따라 금연보조제(껌, 패치, 사탕 등)를 제공한다. 금단증상이나 스트레스 상황을 파악하여 이에 대한 대처 방안을 제공한다. 흡연이 건강에 미치는 영향에 대해 내담자에게 설명한다. 호기일산화탄소 측정과 소변검사를 통해 금연상담 종결 여부를 판단한다. 대상별(청소년, 성인, 여성, 장애인 등) 흡연예방 및 금연교육을 실시한다. 업무에 따라 직접 찾아가는 금연상담 서비스를 제공하거나 고도흡연자 대상으로 금연캠프를 진행하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내·외","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","dJobECd":"2312","dJobECdNm":"[2312]상담 전문가","dJobJCd":"2474","dJobJCdNm":"[2474]상담 전문가","dJobICd":"Q869","dJobICdNm":"[Q869]기타 보건업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006982:1', '{"dJobCd":"K000006982","dJobCdSeq":"1","dJobNm":"금융복지상담사","workSum":"내담자가 한정된 자원을 효율적으로 사용하여 지속적인 재무 균형을 유지하도록 상담 및 교육을 하고 복지서비스 등과 연계한다.","doWork":"재무 건전성 유지 및 현금 흐름 개선을 위한 재무상담을 한다. 개인워크아웃제도, 개인회생, 개인 파산 및 면책 등 적합한 채무조정 제도 안내와 관련 서류 준비를 지원한다. 채무조정 및 채무종결을 위한 협의를 한다. 불법 추심 및 과도한 추심에 대한 대응 상담을 한다. 불법 사금융 피해 구제 상담 및 경찰 수사 의뢰 신청서 작성을 지원한다. 지역 내 복지자원 연계, 수급자격 신청 연계 외 긴급생계비 자원 등을 연계한다. 금융복지 교육, 출장 상담 및 동행 서비스를 한다. 기타 서민금융, 극저신용대출 및 지역 내 금융 자원을 연계한다. 관련 기관과의 업무 협약을 하고 사례 회의 공유 등을 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workPlace":"실내","physicalAct":"언어력|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"금융복지상담관, 금융복지상담위원, 자립지원 재무상담사","certLic":"신용상담사","dJobECd":"2312","dJobECdNm":"[2312]상담 전문가","dJobJCd":"2474","dJobJCdNm":"[2474]상담 전문가","dJobICd":"K661/O842","dJobICdNm":"[K661]금융 지원 서비스업 / [O842]사회 및 산업정책 행정","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002747:1', '{"dJobCd":"K000002747","dJobCdSeq":"1","dJobNm":"도박상담원","workSum":"도박중독을 예방하고 치유하기 위해 개인, 가정, 사회를 대상으로 전문적인 상담·치유 프로그램을 제공하고 건강한 사회구성원으로 회복하도록 지원한다.","doWork":"전화상담, 인터넷상담을 통해 도박문제 치유방안을 설명한다. 도박중독 위험군을 조기에 발견하고 개입한다. 도박중독 치유 및 재활을 위한 상담을 실시한다. 도박장애 진단기준에 따라 심각성을 파악한다. 도박중독자 개인 및 그 가족에 대해 심리상담, 치유상담을 실시한다. 인지행동치료, 동기강화치료, 재정·법률상담, 가족치료, 촉진치료, 대안치료, 자조모임 등 각종 치료·재활 프로그램을 운영한다. 도박중독 예방교육을 진행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"자문","workFunc3":"관련없음","similarNm":"도박중독상담사, 도박전문상담사","certLic":"정신건강간호사(1급, 2급), 정신건강임상심리사(1급, 2급), 정신건강사회복지사(1급, 2급)","dJobECd":"2312","dJobECdNm":"[2312]상담 전문가","dJobJCd":"2474","dJobJCdNm":"[2474]상담 전문가","dJobICd":"Q869","dJobICdNm":"[Q869]기타 보건업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005300:1', '{"dJobCd":"K000005300","dJobCdSeq":"1","dJobNm":"동물교감전문가","workSum":"반려동물과 동물의 주인과의 의사소통을 돕기 위해 동물과 교감한 후 동물 주인에게 내용을 전달한다.","doWork":"말을 하지 못하는 동물들의 마음을 알고자 하는 사람들에게 전화나 이메일로 상담을 한다. 동물을 직접 만나거나 사진 및 동영상 자료 등을 통해 교감을 한다. 문제점들을 발견하거나 파악해서 요청자에게 전달한다. 문제행동이 있을 경우 문제해결 방안을 제시한다. 상담 이외에도 방송, 강연, 동물 관련 매거진 등을 통해 동물교감에 대해 소개한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"언어력|","workFunc1":"조정","workFunc2":"자문","workFunc3":"관련없음","similarNm":"애니멀커뮤니케이터","dJobECd":"2312","dJobECdNm":"[2312]상담 전문가","dJobJCd":"2474","dJobJCdNm":"[2474]상담 전문가","dJobICd":"N759","dJobICdNm":"[N759]기타 사업지원 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006981:1', '{"dJobCd":"K000006981","dJobCdSeq":"1","dJobNm":"사전연명의료의향서상담사","workSum":"사전연명의료의향서 상담·등록을 돕고, 연명의료결정과 관련된 정보를 효과적으로 전달하는 업무를 한다.","doWork":"19세 이상의 국민이 향후 임종과정에 있는 환자가 되었을 때를 대비하여 무의미한 연명의료를 시행하지 않거나 중단할 수 있는 연명의료결정제도의 기준과 절차를 설명한다. 사전연명의료의향서 작성에 동의한 내담자를 대상으로 작성방법을 설명한다. 작성된 사전연명의료의향서를 연명의료 정보처리시스템에 등록한다. 기타 사전연명 등과 관련된 웰다잉에 관해 교육하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"조정","workFunc2":"자문","workFunc3":"관련없음","similarNm":"사전연명의료의향서 전문상담사","certLic":"간호사, 사회복지사","dJobECd":"2312","dJobECdNm":"[2312]상담 전문가","dJobJCd":"2474","dJobJCdNm":"[2474]상담 전문가","dJobICd":"Q86/Q87","dJobICdNm":"[Q86]보건업 / [Q87]사회복지 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001259:1', '{"dJobCd":"K000001259","dJobCdSeq":"1","dJobNm":"산업카운슬러","workSum":"산업현장 근로자들이 적응 및 성장 과정에서 겪는 제반 심리적 갈등과 고충 및 이에 따른 정신적 스트레스를 해결할 수 있도록 상담하고 교육한다.","doWork":"근로자를 대상으로 기업에서 발생하는 인사, 노무, 고용 등에서 발생하는 과도한 스트레스를 통제하고 예방할 수 있도록 상담하고 교육한다(EAP:Employee Assistance Program). 기업 내 뿐만 아니라 기업 외에서도 직업능력과 생활의 질 향상을 위한 경력개발에 대해 상담하고 교육한다(CDP:Career Development Program). 상사와 동료 등 직원 간의 관계 증진, 조직문화 개선, 조직 활성화 등 더 좋은 직장 환경을 만들기 위한 조직개발과 팀워크를 위한 인간관계개발을 위해 상담하고 교육한다(HRP:Human Relations Program).","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"조정","workFunc2":"자문","workFunc3":"관련없음","similarNm":"사내고충처리상담사","certLic":"임상심리사 1급, 2급","dJobECd":"2312","dJobECdNm":"[2312]상담 전문가","dJobJCd":"2474","dJobJCdNm":"[2474]상담 전문가","dJobICd":"M739","dJobICdNm":"[M739]그 외 기타 전문, 과학 및 기술 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005161:1', '{"dJobCd":"K000005161","dJobCdSeq":"1","dJobNm":"스포츠심리상담사","workSum":"상담과 교육을 통해 운동선수와 스포츠 참가자의 목표설정, 자기관리, 실수 및 불안 극복, 자신감 회복 등을 지원함으로써 운동과 스포츠의 지속 동기를 강화하고 수행능력을 향상시키도록 도와준다.","doWork":"운동선수와 스포츠 참가자의 심리적 문제의 원인을 파악하고 해결방안을 마련한다. 운동과 스포츠 수행능력 향상을 위한 교육과 상담을 실시하고, 심리기술훈련(PST:Psychological Skills Training)의 설계와 실천을 돕는다. 약물복용, 식이장애, 자신감 상실, 중도 포기 등의 위기상황에 대해 중재한다. 팀 의사소통 등 팀 조직 관리에 대한 컨설팅을 한다. 훈련 및 경기 분석을 통해 훈련 효과를 높이는 방안을 조언하며, 운동선수의 부모 및 지도자를 교육한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"조정","workFunc2":"자문","workFunc3":"관련없음","similarNm":"스포츠심리컨설턴트","dJobECd":"2312","dJobECdNm":"[2312]상담 전문가","dJobJCd":"2474","dJobJCdNm":"[2474]상담 전문가","dJobICd":"M739","dJobICdNm":"[M739]그 외 기타 전문, 과학 및 기술 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004747:1', '{"dJobCd":"K000004747","dJobCdSeq":"1","dJobNm":"아동복지지도원","workSum":"아동상담소 또는 시·군·구청에서 아동복지를 위한 상담, 조사, 위탁보호, 지도 등의 업무를 수행한다.","doWork":"아동지도에 필요한 가정환경조사, 신체검사, 심리검사 및 정신의학적 검사를 실시하여 그 결과를 통해 문제를 이해한다. 문제해결을 위하여 적절한 지도방침을 세우고 입양, 위탁 및 거택보호 등 적당한 관련 조치를 취한다. 아동 및 임산부에 대하여 전문적인 지도가 필요한 경우 개별 또는 집단지도를 실시하거나 전문가에게 의뢰하여 필요한 지도를 받도록 한다. 관할 구역 내의 보호아동의 분포상황을 파악하여 직접 지도하거나 관계기관에 보호조치를 요청하고 사후지도를 수행한다. 아동복지법인의 시설이나 업무처리에 관하여 위법 여부를 조사하고 시정사항을 지도·감독한다. 관할 구역 내의 아동보호위원들과 유대를 갖고 협의회를 개최하거나 보호대상아동에 관한 조사, 복지조치, 지도방법 등을 지도·관장한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"자문","workFunc3":"관련없음","connectJob":"입양사후관리원","dJobECd":"2312","dJobECdNm":"[2312]상담 전문가","dJobJCd":"2474","dJobJCdNm":"[2474]상담 전문가","dJobICd":"Q871/Q872","dJobICdNm":"[Q871]거주 복지시설 운영업 / [Q872]비거주 복지시설 운영업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005136:1', '{"dJobCd":"K000005136","dJobCdSeq":"1","dJobNm":"양육비이행면접교섭지원원","workSum":"자녀의 면접교섭을 희망하는 경우 또는 법원의 명령으로 면접교섭을 이행해야 하는 양육, 비양육 부모 및 자녀를 대상으로 면접교섭을 지원하는 업무를 수행한다.","doWork":"면접교섭 지원이 필요한 양육·비양육 부모 및 자녀를 대상으로 면접교섭의 일정과 내용에 대한 협의를 지원한다. 면접교섭의 원활한 이행에 필요한 심리상담 및 교육을 한다. 집단면접교섭 프로그램을 운영한다. 면접교섭에 관한 모니터링 등 관련 업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","dJobECd":"2312","dJobECdNm":"[2312]상담 전문가","dJobJCd":"2474","dJobJCdNm":"[2474]상담 전문가","dJobICd":"O845","dJobICdNm":"[O845]사회보장 행정","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003259:1', '{"dJobCd":"K000003259","dJobCdSeq":"1","dJobNm":"양육비이행모니터링수행원","workSum":"비양육 부모의 양육비 이행 여부 및 금액 확인, 양육 부모의 자녀 양육상황 파악, 이행 확보조치로의 연계, 이행 협의·유도 및 관련 협조사항 안내 등의 업무를 수행한다.","doWork":"정기적으로 양육비 이행 여부, 자녀 양육과 관련한 상황을 전화로 확인한다. 양육비 이행을 위한 협의와 이행을 유도한다. 양육비 이행확보 조치 등을 위해 협력기관과의 연계를 위한 업무를 하고 협조 사항 등을 안내한다. 양육비 이행 현황에 대한 정량적 통계분석을 실시하고 개선방안을 도출하는 등의 업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"수집","workFunc2":"교육","workFunc3":"관련없음","dJobECd":"2312","dJobECdNm":"[2312]상담 전문가","dJobJCd":"2474","dJobJCdNm":"[2474]상담 전문가","dJobICd":"O845","dJobICdNm":"[O845]사회보장 행정","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002713:1', '{"dJobCd":"K000002713","dJobCdSeq":"1","dJobNm":"이혼상담사","workSum":"갈등상태의 부부를 상담하여 이혼이 필요한 상황인지 진단하고 관계 회복의 기회를 제공하거나 경제적, 심리적 충격을 최소화하여 이혼을 준비할 수 있도록 조언하고 상담한다.","doWork":"갈등 중인 부부를 상담하고 설문지 및 테스트를 실시하여 갈등 원인을 파악하고 위기 정도를 진단한다. 관계 회복 가능성이 높은 경우, 부부 및 가족 구성원을 대상으로 부부소통교육, 행동교정, 대화교정 등 다양한 관계회복 프로그램을 진행하여 건강한 가정으로 유도한다. 당사자가 이혼을 원하거나, 이혼 이외의 대안을 찾기 어려운 경우에는 이혼 관련 법률, 절차, 재산분할, 양육권 등 합의를 진행하여 이혼소송에 이르지 않도록 유도한다. 이혼 후 예상되는 심리적, 경제적, 사회적 변화에 대한 대응방법을 조언한다. 부부 및 가족이 이혼에 이르게 된 갈등의 원인을 상호 이해하도록 하여 이혼 후 발생할 수 있는 2차적인 갈등을 예방한다. 이혼 관련 서류의 작성을 돕는다. 이혼 후 심리적 충격, 우울증, 사회 부적응, 양육, 재혼 등에 대해 관리한다. 필요에 따라 자녀, 양가 부모 등 관련 당사자를 상담하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"조정","workFunc2":"자문","workFunc3":"관련없음","similarNm":"이혼컨설턴트, 이혼플래너","connectJob":"부부상담가, 부부심리상담사","dJobECd":"2312","dJobECdNm":"[2312]상담 전문가","dJobJCd":"2474","dJobJCdNm":"[2474]상담 전문가","dJobICd":"S969","dJobICdNm":"[S969]그 외 기타 개인 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003674:1', '{"dJobCd":"K000003674","dJobCdSeq":"1","dJobNm":"전문상담교사","workSum":"중·고등학교에서 학생의 학업, 진로 및 학교생활 전반에 관해 상담하고 지도한다.","doWork":"성격, 적성, 지능, 진로 및 신체적·정서적·행동적 증상을 평가하기 위한 검사를 실시하고, 검사결과를 해석하며, 이에 따라 상담을 실시한다. 상담은 개인상담, 집단상담, 자기성장 프로그램, 대인관계 향상 프로그램 등 다양한 방식으로 진행된다. 학생의 생활지도정책 및 방법개발을 위하여 조사·연구하고 계획을 수립한다. 지역사회 관련 기관 및 학교 관련 기관과 연계하여 학생생활지도를 실시한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"조정","workFunc2":"교육","workFunc3":"관련없음","similarNm":"상담교사","connectJob":"진로진학상담교사","certLic":"전문상담교사, 임상심리사, 상담심리사, 청소년상담사","dJobECd":"2312","dJobECdNm":"[2312]상담 전문가","dJobJCd":"2474","dJobJCdNm":"[2474]상담 전문가","dJobICd":"P852","dJobICdNm":"[P852]중등 교육기관","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002664:1', '{"dJobCd":"K000002664","dJobCdSeq":"1","dJobNm":"중독상담원","workSum":"습관성 중독행동과 이로 인해 발생하는 문제에서 벗어날 수 있도록 중독자를 상담한다.","doWork":"마약, 알코올, 도박, 인터넷게임 등의 분야에서 발생하는 중독자의 재활을 위해 법적, 경제적, 의료적인 문제를 전문적으로 자문하고 지원한다. 상담 과정에서 중독으로 인한 정서적인 문제, 가족관계를 포함한 불신과 증오와 같은 대인관계 문제를 확인한다. 중독에 대한 환상을 깨뜨리거나 중독행위를 부추기는 환경을 조정하는 치료 접근도 한다. 삶에 대한 의지를 북돋아 주고 스스로 자기 삶의 주인이 되어 일어설 수 있도록 상담한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"자문","workFunc3":"관련없음","similarNm":"정신건강전문요원","connectJob":"인터넷중독상담원, 마약중독상담원, 도박중독상담원, 알콜중독상담원","certLic":"정신건강간호사, 정신건강임상심리사, 정신건강사회복지사","dJobECd":"2312","dJobECdNm":"[2312]상담 전문가","dJobJCd":"2474","dJobJCdNm":"[2474]상담 전문가","dJobICd":"Q869","dJobICdNm":"[Q869]기타 보건업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004685:1', '{"dJobCd":"K000004685","dJobCdSeq":"1","dJobNm":"청소년상담사","workSum":"청소년의 행복과 균형 있는 성장을 위하여 청소년과 그 주변인을 대상으로 전문적 상담서비스, 보호 및 위기개입, 지역사회 기관 연계, 교육과 예방활동을 통합적으로 수행한다.","doWork":"상담시작 전 내담자 이해를 위한 정보를 수집하고 평가한다. 내담자와 편안한 상담을 위해 상담환경 준비, 상담일정 관리, 오리엔테이션 수행 등의 업무를 한다. 내담자의 문제를 심층적으로 평가하고 내담자를 객관적으로 이해하기 위하여 적절한 심리검사를 선정·실시·평가하고 해석한다. 내담자의 상담 문제를 바탕으로 상담을 구조화하고 관계를 형성하며 상담 목표 및 전략을 세우며 상담을 진행하고 종결하는 등 개인심리 상담을 한다. 심리적인 문제나 개인적인 변화와 성장의 욕구를 해결하기 위하여 집단상담 프로그램을 기획·준비하고 진행· 종결하는 등 집단상담프로그램을 운영한다. 심리사회적 문제 예방 및 성장과 관련한 주제에 대하여 특정 대상의 요구를 조사한 후, 요구와 필요에 따라 심리상담 교육을 설계하고 교육을 실시한다. 폭력, 미디어중독 등 청소년이 겪고 있는 청소년의 문제를 해결하기 위해 프로그램을 기획·설계·운영한다. 내담자 보호와 상담자료의 안전한 관리, 상담현황을 파악하기 위하여 관련 법규에 맞게 상담기록을 관리한다. 상담자의 성장과 전문성 확보를 위하여 상담자 교육분석, 상담자 윤리교육, 심리상담 훈련 및 심리상담 슈퍼비전 등 상담자 교육훈련을 수행한다. 내담자에게 필요한 추가적인 도움을 제공하기 위하여 적합한 의뢰기관을 발굴하여 연계한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"조정","workFunc2":"자문","workFunc3":"관련없음","similarNm":"청소년상담자","certLic":"청소년상담사(1급, 2급, 3급)","dJobECd":"2312","dJobECdNm":"[2312]상담 전문가","dJobJCd":"2474","dJobJCdNm":"[2474]상담 전문가","dJobICd":"Q871/Q872","dJobICdNm":"[Q871]거주 복지시설 운영업 / [Q872]비거주 복지시설 운영업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004176:1', '{"dJobCd":"K000004176","dJobCdSeq":"1","dJobNm":"학습상담원","workSum":"초·중·고생을 대상으로 학습을 지도하고 청소년들의 고민을 상담한다.","doWork":"청소년들이 겪고 있는 학습문제를 상담하고, 청소년들이 바른 학습태도를 유지하도록 이끌어주고 관리한다. 상담 학생에게 학습방향을 제시하고 학업 성취도를 높이는 방법을 학생의 상황에 맞게 지도한다. 청소년의 고민사항에 대하여 조언하고, 스스로 문제를 해결할 수 있도록 유도한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"약간의 시범정도","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"2312","dJobECdNm":"[2312]상담 전문가","dJobJCd":"2474","dJobJCdNm":"[2474]상담 전문가","dJobICd":"P857","dJobICdNm":"[P857]교육지원 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007526:1', '{"dJobCd":"K000007526","dJobCdSeq":"1","dJobNm":"청소년지도사","workSum":"수련시설, 이용시설, 상담시설, 보호시설 등 청소년 관련 단체에서 청소년의 잠재능력과 학업성취 향상, 일반 및 요보호 청소년의 사회적응능력 강화를 위한 수련활동, 문화 및 교류활동 프로그램을 기획하고, 운영, 지도 및 교육한다.","doWork":"국가 청소년 육성에 적합한 정책 의제를 개발하고 현장에 적용한다. 청소년의 사회적응 능력개발과 건전 여가활용에 필요한 각종 수련활동 프로그램을 기획하고 운영한다. 청소년들의 특기적성 교육 및 재량활동에 필요한 프로그램을 제공하고 지도업무를 지원한다. 청소년의 생활적응과 사회적 고민해소를 위해 상담하고 보호활동을 수행한다. 청소년의 봉사활동, 문화활동, 수련활동의 인증을 위한 프로그램을 개발하고 지도한다. 위험 및 소외 청소년의 방과 후 활동, 체험학습활동, 신체단련활동 등을 지도한다. 쉼터, 요보호시설 등의 생활적응에 필요한 각종 지원을 수행한다. 사회부적응 청소년을 위한 전문적 프로그램을 개발하고 활동을 지원한다. 청소년 수련활동의 안전성을 확보하기 위한 시설안전 대책, 관리방안, 평가대책을 수립한다. 활동시설의 운영에 필요한 제반 행정업무를 수행하고 지원한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"교육","workFunc3":"관련없음","similarNm":"청소년지도자","connectJob":"청소년상담사","certLic":"청소년지도사(1급, 2급, 3급), 청소년상담사(1급, 2급, 3급)","dJobECd":"2313","dJobECdNm":"[2313]청소년 지도사","dJobJCd":"2475","dJobJCdNm":"[2475]청소년 지도사","dJobICd":"Q871/Q872","dJobICdNm":"[Q871]거주 복지시설 운영업 / [Q872]비거주 복지시설 운영업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007095:1', '{"dJobCd":"K000007095","dJobCdSeq":"1","dJobNm":"청소년캠프관리자","workSum":"오락 및 교육을 위한 청소년들의 캠프활동을 감독한다.","doWork":"오락 및 교육활동을 위한 캠프 프로그램을 계획한다. 캠프직원을 고용하고 감독한다. 캠프생활 및 훈련에 따르는 건강과 안전대책을 마련하고 관리한다. 캠프활동에 필요한 예산안을 작성하고 비용을 기록·관리한다. 어린이 또는 성인들을 위한 캠프활동을 감독하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"언어력|","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","certLic":"청소년지도사 1급","dJobECd":"2313","dJobECdNm":"[2313]청소년 지도사","dJobJCd":"2475","dJobJCdNm":"[2475]청소년 지도사","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006045:1', '{"dJobCd":"K000006045","dJobCdSeq":"1","dJobNm":"기금모금가","workSum":"기부금 모금을 위한 제반 업무를 수행한다.","doWork":"소액모금의 경우, 모금 목표액과 사용 목적을 명확히 수립한다. 우편 및 이메일을 통해 모금요청서 혹은 약정서 등을 발송한다. 거리모금을 진행한다. 고액모금의 경우, 기부능력, 관심 분야 등 기부자에 대한 정보를 수집하여 기부자를 발굴한다. 기부자로부터 기부를 받거나 다른 기부자를 소개받는다. 기부금을 사용 목적에 맞게 사용하거나 관련 단체에 보내기도 한다. 기부금 사용에 대한 보고서를 기부자들에게 발송한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"조정","workFunc2":"설득","workFunc3":"관련없음","similarNm":"펀드레이저","dJobECd":"2315","dJobECdNm":"[2315]시민단체 활동가","dJobJCd":"2476","dJobJCdNm":"[2476]시민 단체 활동가","dJobICd":"S949","dJobICdNm":"[S949]기타 협회 및 단체","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007114:1', '{"dJobCd":"K000007114","dJobCdSeq":"1","dJobNm":"마을활동가","workSum":"마을공동체 회복· 활성화를 위해 주민 참여를 이끌어 내고 관계를 매개하는 조력자로서, 자치·분권 실현과 마을문제 해결을 위해 각종 프로그램, 사업, 행사를 기획, 실행하고 마을조직이나 관련 공간을 구성, 운영한다.","doWork":"마을만들기를 지속하고 관련 사업의 목표를 달성하기 위해 주민 활동 사업을 기획하고 실행한다. 마을공동체의 필요성과 마을만들기 사례분석 등에 대해 마을공동체 참여자 및 관계자를 교육한다. 마을기업, 서로돌봄, 환경개선, 주민제안 사업과 같은 각종 마을만들기 지원사업의 개념과 사례, 제안서 작성 방법 등을 상담, 컨설팅한다. 주민 간 연계, 네트워크 확장을 위한 이웃관계망 형성을 촉진하면서 공무원, 의원 등 정책 이해관계자들에게 주민 의사를 대변, 전달하며 양자 사이를 중재한다. 삼삼오오 주민모임에서부터 법인, 조합, 단체 등 다양한 형태의 마을조직을 구성하여 참여하고 마을책방, 마을카페와 같은 주민공유공간을 운영·지원한다. 포럼과 토론회 등을 통해 정책 대안 개발이나 정책 형성과정에 참여한다. 마을활동의 이해를 높이고 가치를 알리기 위하여 동영상, (공동체)라디오, 책자, 소식지 등의 홍보 자료를 제작 발간한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"협의","workFunc3":"단순작업","similarNm":"마을코디네이터, 마을공동체지원활동가, 마을간사","connectJob":"사회적경제활동가, 도시재생코디네이터, 사회단체활동가","dJobECd":"2315","dJobECdNm":"[2315]시민단체 활동가","dJobJCd":"2476","dJobJCdNm":"[2476]시민 단체 활동가","dJobICd":"S949","dJobICdNm":"[S949]기타 협회 및 단체","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007485:1', '{"dJobCd":"K000007485","dJobCdSeq":"1","dJobNm":"사회단체활동가","workSum":"정치, 경제, 환경, 복지, 고용, 여성, 청소년, 건강 등 사회 전반적인 문제를 제기하고 이를 해결하기 위해 프로그램을 기획하고 실행한다.","doWork":"정치, 경제, 환경, 복지, 고용, 여성, 청소년, 건강 등 사회 전반적인 문제점을 분석하고 제기한다. 기관, 단체 또는 개인에게 필요한 사회서비스 프로그램을 개발하고 업무수행을 지원한다. 사회활동과 관련된 각종 정책을 계획하고, 예산의 편성과 집행 및 자금조달을 돕기도 한다. 교육, 홍보, 영상물제작 등을 통해서 프로그램을 실행한다. 프로그램을 평가하고 새로운 활동방향을 설정한다. 다양한 사회문제를 해결하기 위한 각종 사회활동을 연구하고 평가한다. 기관 및 단체 또는 개인들을 대상으로 자문 및 상담한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"설득","workFunc3":"관련없음","connectJob":"시민운동가, 인권운동가, 통일운동가, 환경운동가","dJobECd":"2315","dJobECdNm":"[2315]시민단체 활동가","dJobJCd":"2476","dJobJCdNm":"[2476]시민 단체 활동가","dJobICd":"S949","dJobICdNm":"[S949]기타 협회 및 단체","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005412:1', '{"dJobCd":"K000005412","dJobCdSeq":"1","dJobNm":"사회적경제활동가","workSum":"정치, 경제, 사회, 문화 등 사회 전반적인 문제를 제기하고 이를 사회적경제 관점에서 해결할 수 있는 각종 프로그램을 기획, 실행하거나 사회적경제 조직의 구성, 활성화 등을 위한 각종 지원을 한다.","doWork":"사회적경제 관점에서 사회, 조직의 문제점을 분석하고 제기한다. 제기된 문제를 해결하기 위하여 기관, 단체 또는 개인에게 필요한 사회적 경제 서비스 프로그램을 개발하고 수행한다. 사회적경제 프로그램을 평가하고 개선한다. 사회적경제 활동과 관련된 각종 정책을 수립하고, 예산 확보와 편성, 그리고 집행을 돕는다. 공모를 통한 혁신적 비즈니스 아이템 발굴, 사업비 등 재정 지원, 정책자금민간기금의 연결 등 금융 지원을 통해 사회적경제 조직(협동조합, 사회적기업, 마을기업, 자활기업 등)들의 안정적 운영 기반을 마련하고 신규 사업 기회를 만든다. 사회경제적 개념과 내용을 널리 알리기 위해 개인, 기관, 단체 등을 대상으로 교육한다. 캠페인이나 포럼 개최를 비롯하여 동영상, 소책자, 책자 등의 홍보자료를 만들어 배포하여 사회적경제에 대한 인식과 이해를 높인다. 스페인, 독일 등 해외 선진사례를 연구, 분석하여 우리나라에 부합하는 정책대안을 마련하는 연구도 한다. 기관 및 단체 또는 개인들을 대상으로 사회적경제 문제와 해결방안에 대해 자문 및 상담을 한다. 사회적경제 전문인력을 양성하기 위해 각종 프로그램을 기획하고 운영한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"설득","workFunc3":"관련없음","connectJob":"마을공동체활성화운동가, 사회혁신청년활동가, 사회적기업지원활동가, 협동조합지원활동가","dJobECd":"2315","dJobECdNm":"[2315]시민단체 활동가","dJobJCd":"2476","dJobJCdNm":"[2476]시민 단체 활동가","dJobICd":"S949","dJobICdNm":"[S949]기타 협회 및 단체","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005623:1', '{"dJobCd":"K000005623","dJobCdSeq":"1","dJobNm":"복지관보조원","workSum":"사회복지수용시설에서 수용자들에게 일상생활에 필요한 편의를 제공한다.","doWork":"양로원, 육아원 및 기타 사회복지 수용시설에서 수용자들과 함께 생활하면서 세탁, 식사, 위생, 교육, 청소, 정돈 등 생활에 필수적인 사항들을 규칙적으로 할 수 있게 수용자들을 돕는다. 기타 단순한 서비스를 제공한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"시범후 30일 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"단순작업","similarNm":"생활보조원","dJobECd":"2329","dJobECdNm":"[2329]기타 사회복지 종사원","dJobJCd":"2479","dJobJCdNm":"[2479]기타 사회복지 관련 종사원","dJobICd":"Q871","dJobICdNm":"[Q871]거주 복지시설 운영업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007541:1', '{"dJobCd":"K000007541","dJobCdSeq":"1","dJobNm":"생활지도원","workSum":"복지시설에서 아동, 여성, 장애인, 노인들의 생활 및 교육을 계획하고 지도한다.","doWork":"아동 및 노인들의 식사, 교육, 청소 등의 생활을 돕는다. 교육 및 생활을 위한 각종 프로그램에 참여할 수 있도록 인솔하고 지도한다. 학교생활 및 생활에 필요한 문구류 등을 준비한다. 청소나 침구류 등을 정리한다. 생활용품 청구하고 비품을 관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"비교","workFunc2":"교육","workFunc3":"단순작업","similarNm":"복지시설생활지도원","connectJob":"아동생활지도원, 노인생활지도원, 여성생활지도원, 장애인생활지도원","certLic":"사회복지사, 보육교사","dJobECd":"2329","dJobECdNm":"[2329]기타 사회복지 종사원","dJobJCd":"2479","dJobJCdNm":"[2479]기타 사회복지 관련 종사원","dJobICd":"Q871","dJobICdNm":"[Q871]거주 복지시설 운영업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006688:1', '{"dJobCd":"K000006688","dJobCdSeq":"1","dJobNm":"임신출산육아코치","workSum":"임신·출산한 여성을 대상으로 임신·출산·육아에 대한 전반적인 상담, 교육, 육아용품 및 관련 서비스 제공업체 소개, 친목모임 개최, 홍보 등을 제공한다.","doWork":"임신 중인 고객과 상담하여 고객의 상황과 요구사항을 파악한다. 태교방법, 임신 중 개월별 정보, 출산방법 및 원하는 출산방법이 가능한 산부인과 안내, 산후조리 방법 및 산후조리원 안내, 산후도우미, 출산용품 준비 목록, 신생아의 관리, 모유 수유 등을 안내한다. 임신출산육아 관련 인터넷 커뮤니티를 운영하고 지역별 친목모임을 구성하여 관련 정보를 교류하도록 한다. 출산 후에 100일 잔치, 돌잔치 준비를 지원하고 관련 업체를 안내한다. 예방접종표, 월령별 아기 발달 정보, 놀이방법, 교재, 교구 등 육아정보를 제공하고 안내한다. 육아 중 정보를 얻을 시간이 없는 부모를 위하여 검증된 정보를 제공한다. 전화, SNS, 커뮤니티, 면대면, 행사, 소모임, 교육 등 다양한 방법을 활용하여 상담하고 조언한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"단순작업","similarNm":"임신출산육아전문가, 맘스코치, 베이비플래너","dJobECd":"2329","dJobECdNm":"[2329]기타 사회복지 종사원","dJobJCd":"2479","dJobJCdNm":"[2479]기타 사회복지 관련 종사원","dJobICd":"Q872","dJobICdNm":"[Q872]비거주 복지시설 운영업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002544:1', '{"dJobCd":"K000002544","dJobCdSeq":"1","dJobNm":"장애인활동지원사","workSum":"장애인이 장애로 인해 활동하기 어려운 신체적 활동, 가사활동, 사회활동 등을 지원한다.","doWork":"장애인이 장애로 인해 활동하기 어려운 신체적 활동인 개인위생관리, 신체기능유지 및 증진, 식사도움, 실내이동 등을 도와주고 지원한다. 청소 및 주변 정돈, 세탁, 취사 등 가사활동을 지원한다. 등하교 및 출퇴근, 외출 시 동행하는 등 사회활동을 지원한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"관련없음","similarNm":"장애인활동보조인, 장애활동지원인,","certLic":"사회복지사, 보육교사, 요양보호사, 간호사, 간호조무사","dJobECd":"2329","dJobECdNm":"[2329]기타 사회복지 종사원","dJobJCd":"2479","dJobJCdNm":"[2479]기타 사회복지 관련 종사원","dJobICd":"T970","dJobICdNm":"[T970]가구 내 고용활동","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002409:1', '{"dJobCd":"K000002409","dJobCdSeq":"1","dJobNm":"목사","workSum":"기독교 신도의 신앙생활을 지도하고 예배를 인도하며, 기독교회의 여러 종교적 의식 및 활동을 집행하고 수행한다.","doWork":"신도들에게 영적·도덕적 도움을 주기 위하여 예배를 주관하고 교리를 해설한다. 세례, 견신례, 성찬식과 같은 종교의식을 관장한다. 신도의 가정을 심방하여 신앙심을 고취시키고 병든 사람을 위로하며 가난한 사람을 도와준다. 정신적인 결핍 또는 안식을 갈망하는 사람들을 도와주며 신앙으로 인도한다. 주일학교나 청년회와 같은 종교 교육프로그램을 지시·감독한다. 부흥회, 특별신앙 집회를 관장한다. 결혼식이나 장례식을 관장하거나, 교육기관, 의료기관, 교도소, 경찰, 군대 등에서 교육적·종교적 활동을 수행하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"자문","workFunc3":"관련없음","dJobECd":"2331","dJobECdNm":"[2331]성직자","dJobJCd":"2481","dJobJCdNm":"[2481]성직자","dJobICd":"S949","dJobICdNm":"[S949]기타 협회 및 단체","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007234:1', '{"dJobCd":"K000007234","dJobCdSeq":"1","dJobNm":"승려","workSum":"불교의 진리를 얻고 중생을 계도하기 위하여 불교의식을 집행하고 설법 또는 포교활동을 수행한다.","doWork":"재가 신자들을 위하여 부처의 진리를 가르치고 포교활동을 한다. 사찰을 관리하고 정해진 시간에 법당에 불을 밝히고 분향한다. 법종, 법고, 법어, 목탁 등을 치거나 두드리며 하루의 의식을 집행한다. 수도자로서 독경과 참선을 행한다. 구족계(具足戒)와 보살계(菩薩戒)를 받은 비구 및 비구니로서 불가의 진리를 실천한다. 신도들의 청에 의하여 죽은 자를 위한 의식, 결혼을 위한 의식 등을 행하기도 한다. 교육기관, 교도소, 경찰, 군대 등에서 교육적·종교적 활동을 수행하기도 한다. 각 종단에서 포교사, 도제양성, 역경(譯經), 종단의 관리, 인사, 재무, 사무 등의 일을 지도하거나 감시하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"자문","workFunc3":"관련없음","similarNm":"중, 스님","dJobECd":"2331","dJobECdNm":"[2331]성직자","dJobJCd":"2481","dJobJCdNm":"[2481]성직자","dJobICd":"S949","dJobICdNm":"[S949]기타 협회 및 단체","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002077:1', '{"dJobCd":"K000002077","dJobCdSeq":"1","dJobNm":"신부","workSum":"가톨릭 교리에 따라 신자 및 비신자에게 그리스도의 복음을 전하고 성직활동을 한다.","doWork":"신품성사(神品聖事)를 받은 자로서 성직 봉사를 한다. 미사를 집전하고 세례, 견진, 고백, 성체, 병자, 신품, 혼인의 칠성사를 집전한다. 신자들에게 신앙 및 정신적·도덕적 지도를 한다. 외방선교회에 소속되어 소속회의 지시를 받아 선교, 의료, 간호, 교육, 구제 활동 등을 수행하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"자문","workFunc3":"관련없음","dJobECd":"2331","dJobECdNm":"[2331]성직자","dJobJCd":"2481","dJobJCdNm":"[2481]성직자","dJobICd":"S949","dJobICdNm":"[S949]기타 협회 및 단체","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002727:1', '{"dJobCd":"K000002727","dJobCdSeq":"1","dJobNm":"종교인(일반)","workSum":"종교예식이나 의식을 집행·관장하고 신자에게 정신적·도덕적 지도를 하며 교리를 해석하고 설교한다.","doWork":"종교 교단의 의례와 의식 등 종교행사를 집행하거나 관리하며 창조, 속죄 또는 구원행사의 의식적 재연을 관장한다. 의식을 거행할 때에는 경전을 읽는다. 교육기관, 의료기관, 교도소, 경찰, 군대 등에서 교육적, 종교적 활동을 수행하기도 한다. 각종 모임이나 종교 교육프로그램을 지도·감독한다. 교단의 운영을 담당하거나 하위성직자가 종단의 관리나 인사·재무·사무 등의 일을 수행하도록 지도·관리한다. 성직자의 양성을 담당한다. 신도와 상담하여 고충을 들어주고 안식을 주며 신앙심을 고취시킨다. 병든 사람, 가난한 사람, 정신적인 결핍을 호소하거나 안식을 갈망하는 사람을 돕고 신앙으로 인도한다. 경전이나 교리를 해석하고 신도를 상대로 설교한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"자문","workFunc3":"관련없음","similarNm":"성직자","connectJob":"승려, 전교, 교무, 신부, 수녀, 목사, 교령, 전교, 선감","dJobECd":"2331","dJobECdNm":"[2331]성직자","dJobJCd":"2481","dJobJCdNm":"[2481]성직자","dJobICd":"S949","dJobICdNm":"[S949]기타 협회 및 단체","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001283:1', '{"dJobCd":"K000001283","dJobCdSeq":"1","dJobNm":"교화관","workSum":"교인 및 비교인을 교화하기 위하여 천도교의 여러 종교적 의식 및 활동을 집행하고 수행한다.","doWork":"교인 및 비교인의 교화(敎化), 포덕(布德:덕과 진리를 세상에 알리는 포교활동), 수도, 연성(鍊成:수련과 참선)에 관한 업무를 수행한다. 시일(侍日:예배일), 기념, 경축, 기도, 기타 의식, 설교, 강도에 관한 업무를 수행한다. 연원(전교인 또는 전도인과 수교인 또는 입교인의 관계)과 일반 원직(연원과 관련한 직책)에 관한 업무를 수행한다. 편찬, 저술, 간행, 도서취급에 관한 행정업무를 수행한다. 부문단체 지도 및 감독에 관한 업무를 수행한다. 교리, 교사(敎史) 연구 및 종학원(교리교육기관)에 관한 업무를 수행한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"자문","workFunc3":"관련없음","dJobECd":"2339","dJobECdNm":"[2339]기타 종교 종사원","dJobJCd":"2489","dJobJCdNm":"[2489]기타 종교 관련 종사원","dJobICd":"S949","dJobICdNm":"[S949]기타 협회 및 단체","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006028:1', '{"dJobCd":"K000006028","dJobCdSeq":"1","dJobNm":"선교사","workSum":"종교가 전파되지 않은 국내 또는 외국에 파견되어 종교 교리를 선교한다.","doWork":"종교가 알려지지 않은 국내 또는 해외 주민을 대상으로 현지에서 선교활동을 수행한다. 소속 단체 또는 교회에 선교지원 요청을 하며, 선교활동의 상황보고를 한다. 현지에 신학교를 설립하여 현지인 목회자를 양성하는 교육활동을 수행하기도 한다. 교회 및 단체에서 교육, 훈련을 받고 지원 없이 자비로 선교활동을 수행하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"자문","workFunc3":"관련없음","dJobECd":"2339","dJobECdNm":"[2339]기타 종교 종사원","dJobJCd":"2489","dJobJCdNm":"[2489]기타 종교 관련 종사원","dJobICd":"S949","dJobICdNm":"[S949]기타 협회 및 단체","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005975:1', '{"dJobCd":"K000005975","dJobCdSeq":"1","dJobNm":"수도자","workSum":"종교를 믿고 금욕적인 생활을 하며 종교적인 수련을 한다.","doWork":"수도회 등에서 수도생활을 한다. 미사 참례 및 기도, 교리, 성경, 신학 등을 공부한다. 수도자들을 위한 미사를 집전하거나 성경 연구 및 기도를 주관하기도 한다. 성당 업무 보조와 성물 제작 등의 업무를 수행한다. 성당의 행정적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"자문","workFunc3":"관련없음","connectJob":"수사, 수녀","dJobECd":"2339","dJobECdNm":"[2339]기타 종교 종사원","dJobJCd":"2489","dJobJCdNm":"[2489]기타 종교 관련 종사원","dJobICd":"S949","dJobICdNm":"[S949]기타 협회 및 단체","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002814:1', '{"dJobCd":"K000002814","dJobCdSeq":"1","dJobNm":"공학교수","workSum":"대학에서 공학 분야의 인력을 양성하기 위해 공학 분야의 이론과 지식을 강의하고 관련 학문을 연구한다.","doWork":"대학에서 대학생들을 대상으로 건축공학, 금속공학, 기계공학, 재료공학, 전기공학, 전자공학, 토목공학, 통신공학, 화학공학, 컴퓨터공학, 산업공학 등의 이론과 지식을 강의한다. 최신 장비를 이용한 실험실습 강의를 한다. 학생들의 질문에 답변하고 개인 지도를 하기도 한다. 관련 학문을 연구하고 논문을 학회지 등에 발표한다. 각종 회의에 참석하여 전문가로서 조언을 하기도 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","connectJob":"건축학분야-건축공학교수, 건축학교수, 광학공학분야-광학공학교수, 금속공학분야-금속공학교수, 금형설계학교수, 제철금속학교수, 표면처리학교수, 기계공학분야-기계공학교수, 기계학교수, 기계설계공학교수, 기전공학분야-메카트로닉스학교수, 도시공학분야-도시계획학교수, 도시공학교수, 반도체세라믹공학분야-반도체학교수, 세라믹공학교수, 산업공학분야-산업공학교수, 산업안전학교수, 소방안전관리학교수, 시스템경영공학교수, 시스템공학교수, 안전공학교수, 섬유공학분야-섬유공학교수, 천연섬유학교수, 신소재공학분야-신소재공학교수, 신소재응용학교수, 에너지공학분야-원자력공학교수, 자원공학교수, 응용공학분야-신발패션산업학교수, 안경광학교수, 인쇄학교수, 제지공학교수, 출판미디어학교수, 측지정보학교수, 특수장비학교수, 포장학교수, 화장품학교수, 응용소프트웨어분야-CAD응용시스템과학교수, 게임공학교수, 디지털미디어학교수, 디지털정보학교수, 멀티미디어정보학교수, 멀티미디어학교수, 영상콘텐츠학교수, 컴퓨터게임학교수, 자동차공학분야-자동차공학교수, 자동차정비학교수, 재료공학분야-고분자공학교수, 재료공학교수, 재료학교수, 전기공학분야-전기공학교수, 전기전자공학교수, 전기제어공학교수, 전산학컴퓨터공학분야-소프트웨어공학교수, 전산학교수, 컴퓨터공학교수, 컴퓨터과학교수, 컴퓨터보안학교수, 컴퓨터소프트웨어학교수, 컴퓨터응용설계학교수, 컴퓨터응용제어학교수, 컴퓨터전기자동화교수, 컴퓨터프로그래밍학교수, 전자공학분야-전자공학교수, 정보통신공학분야-전파공학교수, 정보통신공학교수, 지식정보학교수, 제어계측공학분야-제어계측공학교수, 조경학분야-조경학교수, 지상교통학분야-교통공학교수, 물류시스템공학교수, 철도분야-철도시설토목학교수, 철도운전기전학교수, 철도전기제어학교수, 철도차량기계학교수, 토목학분야-건설산업학교수, 건설정보학교수, 토목공학분야-토목공학교수, 항공학분야-항공우주공학교수, 해양공학분야-조선공학교수, 항해학교수, 해양공학교수, 해양시스템학교수, 화학공학분야-공업화학교수, 화학공업학교수, 화학공학교수","dJobECd":"2111","dJobECdNm":"[2111]대학 교수","dJobJCd":"2511","dJobJCdNm":"[2511]대학교수","dJobICd":"P853","dJobICdNm":"[P853]고등 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002355:1', '{"dJobCd":"K000002355","dJobCdSeq":"1","dJobNm":"교육학교수","workSum":"대학에서 초·중등교사 및 교육전문가를 양성할 목적으로 교육, 어학, 사회, 종교, 수학, 과학, 실업, 공학, 예체능 분야의 이론과 지식을 강의하고 관련 학문을 연구한다.","doWork":"대학에서 대학생들을 대상으로 교육학 전반에 관한 기초이론과 각 전공영역에서 요청되는 전문이론을 강의한다. 대학생들에게 학교현장에 적용할 수 있는 실제적 기술을 연구하고 익히도록 지도한다. 교과목으로 교육과정론, 교육공학, 유아교육학, 초등교육학, 특수교육학 등의 공통교직과목과 각 학과 전공별 필수·선택과목을 가르친다. 교육행정학, 교육철학을 연구하고 가르치기도 한다. 학생들의 질문에 답변하고 개인 지도를 하기도 한다. 관련 학문을 연구하고 논문을 학회지 등에 발표한다. 각종 회의에 참석하여 전문가로서 조언을 하기도 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","connectJob":"공학교육분야-과학교육학교수, 기술교육학교수, 전기공학교육학교수, 컴퓨터교육학교수, 교육학분야-교육공학교수, 교육심리학교수, 사회교육분야-사회교육학교수, 역사교육학교수, 윤리교육학교수, 일반사회교육학교수, 종교교육학교수, 지리교육학교수, 언어교육분야-한문교육학교수, 국어교육학교수, 독일어교육학교수, 불어교육학교수, 영어교육학교수, 예체능계교육분야-미술교육학교수, 체육교육학교수, 유아교육학분야-유아교육학교수, 자연계교육분야-농업교육학교수, 물리교육학교수, 생물교육학교수, 수학교육학교수, 지구과학교육학교수, 화학교육학교수, 초등교육학분야-아동교육학교수, 초등교육학교수, 특수교육학분야-특수교육학교수","dJobECd":"2111","dJobECdNm":"[2111]대학 교수","dJobJCd":"2511","dJobJCdNm":"[2511]대학교수","dJobICd":"P853","dJobICdNm":"[P853]고등 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001638:1', '{"dJobCd":"K000001638","dJobCdSeq":"1","dJobNm":"사회과학교수","workSum":"대학에서 대학생을 대상으로 사회학, 정치학, 문헌정보학 및 관련 분야의 이론과 지식을 강의하고 관련 학문을 연구한다.","doWork":"대학에서 대학생들을 대상으로 경영학, 경제학, 법학, 정치학, 신문방송학, 사회학, 심리학, 행정학 등 사회과학계열의 학문을 강의한다. 학생들의 질문에 답변하고 개인 지도를 하기도 한다. 개인과 사회구조, 사회현상 등을 연구대상으로 삼아 인간사회의 제 현상을 연구한다. 기초학문 외에 각종 방법론과 통계적인 접근을 통해 응용·기술적 차원으로 사회현상을 분석하기도 한다. 경험적 자료수집을 위해 제반 사회현상에 관련되는 실증자료들을 조사·분석한다. 연구 논문을 학회지 등에 발표한다. 각종 회의에 참석하여 전문가로서 조언을 하기도 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","connectJob":"가족사회복지학분야-가족복지학교수, 건강관리학교수, 노인보건복지학교수, 보건행정학교수, 사회복지학교수, 아동복지학교수, 아동학교수, 청소년지도학교수, 경영학분야-경영학교수, 수산경영학교수, 산업경영학교수, 인력개발학교수, 철도경영학교수, 품질관리학교수, 경제학교수, 농업경제학교수, 경찰분야-경찰학교수, 해양경찰학교수, 관광학-관광경영학교수, 관광통역학교수, 문화관광학교수, 컨벤션산업학교수, 항공여행학교수, 호텔경영학교수, 호텔외식경영학교수, 광고홍보학분야-광고기획학교수, 광고홍보학교수, 사회과학일반-교양학교수, 마케팅정보학교수, 문화예술마케팅학교수, 미디어학교수, 벤처창업학교수, 부동산학교수, 스포츠마케팅학교수, 전자상거래학교수, 창업경영학교수, 비서행정학교수, 사무정보학교수, 외식산업학교수, 웹마스터학교수, 장례지도학교수, 금융회계세무학분야-금융보험학교수, 세무학교수, 증권금융학교수, 회계학교수, 도시지역학분야-지역개발학교수, 무역유통학분야-국제경영 및 통상학교수, 무역학교수, 유통학교수, 법학분야-국제법무학교수, 법률학교수, 법학교수, 사회학분야-사회학교수, 언론방송매체학분야-신문방송학교수, 언론홍보학교수, 인터넷방송학교수, 정치외교학분야-외교학교수, 정치외교학교수, 항공분야-항공서비스학교수, 항공운항학교수, 행정학분야-경찰행정학교수, 경호비서행정학교수, 지방행정학교수, 행정학교수","dJobECd":"2111","dJobECdNm":"[2111]대학 교수","dJobJCd":"2511","dJobJCdNm":"[2511]대학교수","dJobICd":"P853","dJobICdNm":"[P853]고등 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003942:1', '{"dJobCd":"K000003942","dJobCdSeq":"1","dJobNm":"산학협력교수","workSum":"대학에서 산학협력 증진을 위해 교육, 연구, 창업·취업 지원, 정책 및 기획 등의 업무를 수행한다.","doWork":"기업체 근무경험을 살린 현장실무중심 강의를 기획한다. 학생들에게 현장실무중심 강의를 한다. 학생들의 성적을 평가한다. 산학협력 중심의 교과를 개편한다. 학과 수요파악을 통해 심화교과목을 개발한다. 산학공동연구에서 기업의 기술수요를 반영한 연구를 기획한다. 대학의 R&D의 성과물에 대해 특허 및 지식재산권 확보를 지원한다. 대학의 유용한 기술의 이전 및 사업화를 지원한다. 기업의 애로기술을 지도한다. 애로기술 해결을 위한 산학협력 과제를 발굴한다. 가족회사를 확보하고 관리한다. 학생들이 현장실습을 실시할 수 있는 기업체를 발굴한다. 학생상담을 통하여 알맞은 기업과 학생을 연계한다. 현장실습이 진행되고 있는 기업을 방문하여 학생 및 기업체 담당자와의 면담을 통해 학생의 현장실습 진행상황을 점검한다. 현장실습 종료 후 현장실습 결과보고서 등을 통하여 학생의 현장실습을 평가한다. 현장실습을 마친 학생들의 취업을 지속적으로 지원한다. 현장실습과 관련된 사전·사후 교육을 지원한다. 취업 및 창업동아리를 지원한다. 창업보육센터를 운영한다. 학내의 인사제도 및 조직구성을 산학협력 활성화를 위한 방향으로 개편한다. 지역 내 산학협력 유관기관과의 연계를 통해 지역사업을 기획 및 실행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","dJobECd":"2111","dJobECdNm":"[2111]대학 교수","dJobJCd":"2511","dJobJCdNm":"[2511]대학교수","dJobICd":"P853","dJobICdNm":"[P853]고등 교육기관","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004468:1', '{"dJobCd":"K000004468","dJobCdSeq":"1","dJobNm":"어문학교수","workSum":"대학에서 어학과 문학에 대한 이해를 넓히고 언어사용능력을 증진시키기 위하여 학생들에게 국어국문학, 중어중문학, 영어영문학, 불어불문학 및 관련 분야의 이론과 지식을 강의하고 관련 학문을 연구한다.","doWork":"대학에서 대학생들에게 언어학, 음성학, 음운론, 의미론, 형태론, 통사론, 문학개론, 소설, 시, 희곡, 문학사 등을 가르친다. 언어와 지식, 언어와 세계, 언어와 인간과의 관계를 규명하기 위하여 언어학문 및 언어방법을 조사한다. 대상국가의 문학, 사회, 경제, 문화, 예술 등에 대해 연구하며 어학실습을 병행한 강의를 진행한다. 학생들의 질문에 답변하고 개인 지도를 하기도 한다. 관련 학문을 연구하고 논문을 학회지 등에 발표한다. 각종 회의에 참석하여 전문가로서 조언을 하기도 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"조정","workFunc2":"자문","workFunc3":"관련없음","connectJob":"교양어문학분야-아랍어학교수, 아프리카어학교수, 터키어학교수, 포르투갈어학교수, 국어국문학분야-한국어학교수, 기타아시아어문학분야-동양어문학교수, 인도어학교수, 태국어학교수, 유럽어문학분야-유럽어학교수, 이탈리아어학교수, 폴란드어학교수, 헝가리어학교수, 독일어문학분야-독어독문학교수, 러시아어문학분야-러시아어학교수, 스페인어문학분야-스페인어학교수, 언어학분야-언어학교수, 영미어문학분야-영어학교수, 영어영문학교수, 일본어문학분야-일본어학교수, 일어일문학교수, 중국어문학분야-중국어학교수, 중어중문학교수, 한문학교수, 프랑스어문학분야-불어불문학교수","dJobECd":"2111","dJobECdNm":"[2111]대학 교수","dJobJCd":"2511","dJobJCdNm":"[2511]대학교수","dJobICd":"P853","dJobICdNm":"[P853]고등 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002609:1', '{"dJobCd":"K000002609","dJobCdSeq":"1","dJobNm":"예체능교수","workSum":"대학에서 예술의 학문적·독창적 가치를 연구·창조하고 예술 분야의 전문기능인 양성을 위해 미술계열, 음악계열, 연극영화계열, 체육계열의 이론과 지식을 강의한다.","doWork":"대학에서 대학생들을 대상으로 제반 문화예술 분야 중 해당 분야의 전문적인 이론 및 실습교육을 통해 실용적인 지식과 기능을 연마시킨다. 음악계열은 성악, 기악, 작곡, 국악이론, 관현악, 피아노, 미술계열은 미술사, 조각, 디자인, 연극영화계열은 영화이론, 영화사, 연극사, 연극이론, 희곡 등을 가르친다. 체육계열은 체육지도법, 트레이닝, 구급처치법 등의 이론 분야를 비롯해 각종 구기종목은 물론 태권도, 유도, 복싱, 레슬링, 사격, 씨름, 수영, 검도, 볼링, 골프 등 개인종목의 실기교육을 실시한다. 관련 학문을 연구하고 논문을 학회지 등에 발표한다. 각종 회의에 참석하여 전문가로서 조언을 하기도 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"청각|손사용|시각|","workFunc1":"분석","workFunc2":"교육","workFunc3":"정밀작업","connectJob":"공예분야-공예학교수, 금속공예학교수, 도자기공예학교수, 국악분야-국악학교수, 한국음악학교수, 기악분야-관현악교수, 기악교수, 피아노학교수, 기타분야-모델학교수, 보석감정학교수, 이벤트학교수, 디자인분야-웹그래픽디자인학교수, 컴퓨터그래픽학교수, 커뮤니케이션디자인학교수, 환경디자인학교수, 음향분야-음향제작학교수, 무용분야-무용학교수, 미용분야-메이크업아티스트교수, 미용학교수, 피부미용학교수, 사진만화분야-만화애니메이션학교수, 사진학교수, 사진영상학교수, 산업디자인분야-공업디자인학교수, 목조형가구학교수, 산업디자인학교수, 제품디자인학교수, 성악분야-성악교수, 순수미술분야-동양화교수, 미술학교수, 서양화교수, 예술학교수, 판화학교수, 회화학교수, 시각디자인분야-광고디자인학교수, 섬유디자인학교수, 시각디자인학교수, 일러스트레이션학교수, 연극영화분야-공연제작학교수, 뮤지컬학교수, 연극영화학교수, 연예연기학교수, 영화학교수, 코미디연기학교수, 영상예술분야-방송영상학교수, 방송제작학교수, 영상멀티미디어학교수, 영상미술학교수, 영상제작학교수, 전통예술학교수, 음악학분야-교회종교음악학교수, 대중음악학교수, 실용음악학교수, 음악학교수, 조형분야-환경조각학교수, 조소학교수, 조형디자인학교수, 조형미술학교수, 작곡분야-작곡학교수, 체육분야-댄스스포츠학교수, 레저스포츠학교수, 레크리에이션학교수, 무도학교수, 사회체육학교수, 스포츠외교학교수, 스포츠지도학교수, 체육학교수, 해양스포츠학교수, 패션디자인분야-의상디자인학교수, 코디네이션학교수, 패션악세사리디자인학교수","dJobECd":"2111","dJobECdNm":"[2111]대학 교수","dJobJCd":"2511","dJobJCdNm":"[2511]대학교수","dJobICd":"P853","dJobICdNm":"[P853]고등 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003912:1', '{"dJobCd":"K000003912","dJobCdSeq":"1","dJobNm":"의약학교수","workSum":"대학에서 의료 분야의 전문인을 양성하기 위하여 학생들에게 의학, 치의학, 수의학, 한의학, 약학, 간호학 및 관련 분야의 이론과 지식을 강의하고 관련 학문을 연구한다.","doWork":"대학에서 대학생들을 대상으로 임상의학, 해부학, 생리학, 병리학, 예방의학, 보건학, 약리학, 재활의학, 기초치료학, 간호학, 기초한의학 등 질병예방 및 치료를 위한 학술적 이론과 기술에 대해 강의한다. 학생들의 질문에 답변하고 개인 지도를 하기도 한다. 인간의 생명과 질병, 건강과 보건문제에 대해 연구한다. 연구 논문을 학회지 등에 발표한다. 각종 회의에 참석하여 전문가로서 조언을 하기도 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|언어력|시각|","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","connectJob":"간호학분야-간호학교수, 보건학분야-건강관리학교수, 공중보건학교수, 보건관리학교수, 보건행정학교수, 환경보건학교수, 수의학분야-수의학교수, 약학분야-약학교수, 제약학교수, 의료공학분야-병원관리학교수, 의료보장구학교수, 의료정보공학교수, 의료정보시스템학교수, 의무행정학교수, 의용공학교수, 의학분야-방사선학교수, 언어치료학교수, 응급구조학교수, 의예학교수, 임상병리학교수, 재활학분야-물리치료학교수, 스포츠의학교수, 작업치료학교수, 재활학교수, 치의학분야-치기공학교수, 치위생학교수, 치의예학교수, 한의학분야-한약학교수, 한의예학교수","dJobECd":"2111","dJobECdNm":"[2111]대학 교수","dJobJCd":"2511","dJobJCdNm":"[2511]대학교수","dJobICd":"P853","dJobICdNm":"[P853]고등 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005682:1', '{"dJobCd":"K000005682","dJobCdSeq":"1","dJobNm":"인문학교수","workSum":"대학에서 인문학 분야의 이해를 넓히기 위하여 학생들에게 역사학, 철학, 종교학, 인류학 및 관련 분야의 이론과 지식을 강의하고 관련 학문을 연구한다.","doWork":"대학에서 학생들에게 역사학, 고고학, 지역학, 심리학, 인류학, 문헌정보학, 종교학, 철학 등 인문학계열의 학문을 강의한다. 학생들의 질문에 답변하고 개인 지도를 하기도 한다. 연구 논문을 학회지 등에 발표한다. 각종 회의에 참석하여 전문가로서 조언을 하기도 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","connectJob":"국제지역학분야-독일학교수, 러시아학교수, 미국학교수, 북한학교수, 일본학교수, 중국학교수, 지역학교수, 프랑스학교수, 문헌정보학분야-문헌정보학교수, 박물관학교수, 심리학분야-사회복지상담학교수, 심리학교수, 역사고고학분야-고고학교수, 사학교수, 인류학분야-인류학교수, 국제문화정보학교수, 문예창작학교수, 국가유산학교수, 민속학교수, 청소년문화학교수, 종교학분야-기독교학교수, 불교학교수, 선교학교수, 신학교수, 종교학교수, 철학윤리학분야-윤리학교수, 철학교수","dJobECd":"2111","dJobECdNm":"[2111]대학 교수","dJobJCd":"2511","dJobJCdNm":"[2511]대학교수","dJobICd":"P853","dJobICdNm":"[P853]고등 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006122:1', '{"dJobCd":"K000006122","dJobCdSeq":"1","dJobNm":"자연과학교수","workSum":"대학에서 자연과학 분야의 전문가를 양성하기 위해 물리학, 수학, 화학, 생명과학, 지구과학, 환경학 등에 대한 이론과 지식을 강의하고 관련 학문을 연구한다.","doWork":"대학에서 대학생들을 대상으로 물리학, 생물학, 수학, 지질학, 천문학, 기상학, 화학, 환경학 등의 자연과학계열 학문을 강의한다. 다양한 실험실습 교육을 통하여 첨단과학의 정보와 기술을 가르친다. 학생들의 질문에 답변하고 개인 지도를 하기도 한다. 물질세계인 자연의 제반 현상을 연구 대상으로 하여 자연계 모든 현상의 기본원리를 연구한다. 실험과 수리적 방법을 통해 자연법칙을 설명하고 현상들 사이의 함수관계를 밝힌다. 연구 논문을 학회지 등에 발표한다. 각종 회의에 참석하여 전문가로서 조언을 하기도 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","similarNm":"이학교수","connectJob":"가정관리학분야-가정학교수, 소비자학교수, 농업학분야-농공학교수, 농생물학교수, 축산학교수, 농학교수, 동물수의학분야-동물자원학교수, 애완동물학교수, 물리과학분야-나노공학교수, 물리학교수, 산림원예학분야-임산공학교수, 산림자원학교수, 원예학교수, 임학교수, 조경학교수, 생명과학분야-바이오생명정보학교수, 생명공학교수, 생명자원학교수, 유전공학교수, 생물학분야-생물학교수, 수산학분야-기관공학교수, 냉동공학교수, 수산가공학교수, 수산생명의학교수, 양식학교수, 항해시스템공학교수, 해양생산학교수, 해양환경공학교수, 수학분야-수학교수, 식품영양학분야-식품가공학교수, 식품공학교수, 식품과학교수, 식품영양학교수, 식품조리학교수, 외식조리학교수, 전통조리학교수, 제과제빵학교수, 조리과학교수, 푸드스타일리스트학교수, 한방학교수, 호텔조리학교수, 의류의상학분야-의류학교수, 의상학교수, 전통의상학교수, 자원학분야-식물자원학교수, 식량자원학교수, 자원동물산업학교수, 해양자원학교수, 지구지리학분야-지구과학교수, 지구물리학교수, 지구정보공학교수, 지구해양과학교수, 지리학교수, 지적학교수, 지질학교수, 지형정보학교수, 천문기상학분야-대기과학교수, 우주과학교수, 천문학교수, 통계학분야-통계학교수, 해양학분야-물리해양학교수, 화학해양학교수, 해양생물학교수, 지질해양학교수, 화학분야-생화학교수, 정밀화학교수, 화학교수, 환경학분야-보건환경학교수, 환경공업학교수, 환경공학교수, 환경과학교수, 환경위생학교수, 환경화학교수, 자연계열일반-인터넷정보학교수, 정보보호학교수","dJobECd":"2111","dJobECdNm":"[2111]대학 교수","dJobJCd":"2511","dJobJCdNm":"[2511]대학교수","dJobICd":"P853","dJobICdNm":"[P853]고등 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007160:1', '{"dJobCd":"K000007160","dJobCdSeq":"1","dJobNm":"대학강사","workSum":"대학에서 일정 기간 동안, 전공 학문의 이론과 지식을 강의한다.","doWork":"대학의 교육시스템, 담당 전공과목의 특징 등을 살펴 강의계획을 세운다. 강의 시 필요한 관련 교육도구를 준비한다. 강의할 전반에 관한 기초이론과 각 전공영역에서 요청되는 전문이론을 교수한다. 강의를 하고, 학생들의 질문사항에 답변한다. 과제를 내주고 결과를 검토하여 학생들을 평가한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"정밀작업","similarNm":"시간강사","connectJob":"국문학강사, 토목공학강사, 물리학강사, 영문학강사, 화학공학강사, 생물학강사, 사학강사, 환경공학강사, 수학강사, 철학강사, 법학강사, 통계학강사, 무역학강사, 행정학강사, 화학강사, 경제학강사, 관현악강사, 환경학강사, 건축학강사, 국악강사, 지질학강사, 금속공학강사, 성악강사, 천문학강사, 기계공학강사, 작곡강사, 가정교육강사, 재료공학강사, 섬유공학강사, 공예학강사, 교육학강사, 자원공학강사, 미술학강사, 국어교육강사, 전기공학강사, 산업디자인학강사, 수학교육강사, 전자공학강사, 무용학강사, 영어교육강사, 컴퓨터공학강사, 체육학강사, 음악교육강사, 컴퓨터교육강사, 경호원학강사, 체육교육강사","dJobECd":"2112","dJobECdNm":"[2112]대학 시간강사","dJobJCd":"2512","dJobJCdNm":"[2512]대학 시간강사","dJobICd":"P853","dJobICdNm":"[P853]고등 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002145:1', '{"dJobCd":"K000002145","dJobCdSeq":"1","dJobNm":"가정교사","workSum":"중·고등학교에서 학생들에게 가정생활에 필요한 지식과 기술을 가르치기 위하여 가정 및 가사과목을 가르친다.","doWork":"교과내용은 가족과 일의 이해, 생활기술, 생활자원과 환경관리의 영역 등으로 구성된 교과내용을 가르친다. 가족생활, 소비생활, 식생활, 의생활, 주생활, 아동양육, 조리, 재봉, 수예 등 가정생활에 필요한 기본적인 지식과 기술을 가르친다. 실생활의 적용을 중시하는 실천교과로서 가사실습, 전통예절을 익히기 위한 생활관 실습 등을 계획·실시한다. 교과서 및 시청각자료 등 다양한 학습자료를 활용하여 수업을 진행한다. 과제를 내주고 결과를 검토 및 지도한다. 시험을 출제하고 학생의 성적을 평가한다. 교과목에 관련된 실기교사(중등교육기관)의 직무를 수행하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","certLic":"중등학교정교사","dJobECd":"2121","dJobECdNm":"[2121]중·고등학교 교사","dJobJCd":"2521","dJobJCdNm":"[2521]중·고등학교 교사","dJobICd":"P852","dJobICdNm":"[P852]중등 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004121:1', '{"dJobCd":"K000004121","dJobCdSeq":"1","dJobNm":"공업교사","workSum":"공업계열 고등학교에서 학생들에게 공업에 대한 지식과 기술을 가르치기 위하여 공업 및 관련 과목을 가르친다.","doWork":"건축구조, 공업입문, 금속재료, 기초제도, 멀티미디어, 시스템프로그래밍, 염색가공, 자동차건설기계, 전자기계제어, 전자전산응용, 정보기술기초, 컴퓨터구조, 통신시스템, 항공기일반, 환경공업일반 등의 전문교과목 중 하나 또는 그 이상의 과목을 전문으로 가르친다. 각 분야에 관련된 전문기술을 실험실습을 통하여 습득하게 함으로써 실기능력 배양에 중점을 둔다. 교과서 및 시청각자료 등 다양한 학습자료를 활용하여 수업을 진행한다. 학생들의 작업을 지도하고 감독한다. 과제를 내주고 결과를 검토 및 지도한다. 학생의 기술에 대한 지식과 실기의 향상도를 시험하고 평가한다. 전문교과목에 관련된 실기교사(중등교육기관)의 직무를 수행하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","connectJob":"전문교과목에 따라 기계교사, 전자기계교사, 금속교사, 자원교사, 전기교사, 전자교사, 통신교사, 토목교사, 건축교사, 산업디자인교사, 화학공업교사, 세라믹교사, 식품공업교사, 섬유교사, 인쇄교사, 자동차교사, 조선교사, 항공교사, 환경공업교사, 기술교사","certLic":"중등학교정교사","dJobECd":"2121","dJobECdNm":"[2121]중·고등학교 교사","dJobJCd":"2521","dJobJCdNm":"[2521]중·고등학교 교사","dJobICd":"P852","dJobICdNm":"[P852]중등 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001898:1', '{"dJobCd":"K000001898","dJobCdSeq":"1","dJobNm":"과학교사","workSum":"중·고등학교에서 학생들의 과학 분야에 대한 이해를 넓히기 위하여 과학, 생활과 과학, 물리, 화학, 생물, 지구과학 및 관련 과목을 전문으로 교육한다.","doWork":"교과내용은 에너지, 물질, 생명, 지구 등의 지식과 탐구과정 그리고 탐구활동으로 구성된다. 자연과학적 현상의 올바른 이해를 위해 실험·실습을 계획, 지도한다. 환경과 실생활 문제를 학습의 소재로 활용하고 탐구활동을 통하여 문제해결능력 육성에 중점을 둔다. 과학지식의 각 분야는 전 학년에 걸쳐서 연계성 있게 교육한다. 교과서 및 시청각자료 등 다양한 학습자료를 활용하여 수업을 진행한다. 과제를 내주고 결과를 검토 및 지도한다. 시험을 출제하고 학생의 성적을 평가한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","connectJob":"전문교과목에 따라 물리교사, 생물교사, 지구과학교사, 화학교사","certLic":"중등학교정교사","dJobECd":"2121","dJobECdNm":"[2121]중·고등학교 교사","dJobJCd":"2521","dJobJCdNm":"[2521]중·고등학교 교사","dJobICd":"P852","dJobICdNm":"[P852]중등 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004616:1', '{"dJobCd":"K000004616","dJobCdSeq":"1","dJobNm":"교양과목교사","workSum":"고등학교에서 학생들의 인문사회 분야에 대한 전반적인 이해와 교양을 넓히기 위해서 철학, 논리학, 심리학, 교육학 및 관련 과목을 전문으로 교육한다.","doWork":"인간의 행동 및 삶의 과정에 대한 전반적인 이해를 위해 해당 과목의 전공지식과 원리에 대해 교육한다. 인간적 삶의 다양한 측면을 각 전공교과별 방법론을 적용해 해석하고 교육한다. 교과서 및 시청각자료 등 다양한 학습자료를 활용하여 수업을 진행한다. 과제를 내주고 결과를 검토 및 지도한다. 시험을 출제하고 학생의 성적을 평가한다. 교과목에 따라 현장견학, 실험실습, 조사 등과 같은 현장학습을 강조하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","connectJob":"전문교과목에 따라 철학교사, 논리학교사, 심리학교사, 교육학교사, 생활경제교사, 종교교사, 생태와 환경교사, 진로와 직업교사, 윤리교사","certLic":"중등학교정교사","dJobECd":"2121","dJobECdNm":"[2121]중·고등학교 교사","dJobJCd":"2521","dJobJCdNm":"[2521]중·고등학교 교사","dJobICd":"P852","dJobICdNm":"[P852]중등 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002859:1', '{"dJobCd":"K000002859","dJobCdSeq":"1","dJobNm":"국어교사","workSum":"중·고등학교에서 학생들에게 국어 및 문학에 대한 이해를 넓히기 위하여 국어, 현대문학, 고전문학, 문법, 작문 및 관련 과목을 전문으로 교육한다.","doWork":"교과내용은 듣기, 말하기, 읽기, 쓰기, 국어지식, 문학의 영역으로 구성되며 구체적으로 국어생활, 화법, 독서, 작문, 문법, 문학 등을 가르친다. 국어사용의 실천적 능력을 신장시키기 위해서 언어표현과 창작실습을 지도한다. 교과서 및 시청각자료 등 다양한 학습자료를 활용하여 수업을 진행한다. 과제를 내주고 결과를 검토 및 지도한다. 시험을 출제하고 학생의 성적을 평가한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","certLic":"중등학교정교사","dJobECd":"2121","dJobECdNm":"[2121]중·고등학교 교사","dJobJCd":"2521","dJobJCdNm":"[2521]중·고등학교 교사","dJobICd":"P852","dJobICdNm":"[P852]중등 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005707:1', '{"dJobCd":"K000005707","dJobCdSeq":"1","dJobNm":"농업교사","workSum":"농업계열 고등학교에서 학생들에게 농업에 대한 지식과 기술을 가르치기 위하여 농업 및 관련 과목을 전문으로 교육한다.","doWork":"농업경영, 농업기계기술, 농업토목기술, 사육기술, 식품가공기술, 원예기술, 유통관리, 재배, 조경기술, 축산 등의 전문교과목 중 하나 또는 그 이상의 과목을 교육한다. 각 분야에 관련된 전문기술을 실험실습을 통하여 습득하게 함으로써 실기능력 배양에 중점을 둔다. 교과서 및 시청각자료 등 다양한 학습자료를 활용하여 수업을 진행한다. 과제를 내주고 결과를 검토 및 지도한다. 시험을 출제하고 학생의 성적을 평가한다. 전문교과목에 관련된 실기교사(중등교육기관)의 직무를 수행하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","connectJob":"전문교과목에 따라 식물자원교사, 동물자원교사, 농업경영교사, 농업토목교사, 식품가공교사, 농업기계교사, 조경교사, 농산물유통교사, 환경보존교사","certLic":"중등학교정교사","dJobECd":"2121","dJobECdNm":"[2121]중·고등학교 교사","dJobJCd":"2521","dJobJCdNm":"[2521]중·고등학교 교사","dJobICd":"P852","dJobICdNm":"[P852]중등 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003327:1', '{"dJobCd":"K000003327","dJobCdSeq":"1","dJobNm":"도덕교사","workSum":"중·고등학교에서 학생들에게 윤리의식과 철학적 사고력을 키우기 위하여 도덕, 국민윤리, 시민윤리, 윤리와 사상, 전통윤리 및 관련 과목을 전문으로 교육한다.","doWork":"교과내용은 인성교육과 민주시민교육, 통일교육, 환경교육이 핵심영역이고 구체적으로 개인생활, 가정·이웃·학교생활, 사회생활, 국가·민족생활 등을 가르친다. 윤리적 규범이나 민주적인 삶의 방식들을 학생들이 자기주도적으로 학습할 수 있도록 다양한 활동형·체험형 주제들을 제공하고 지도한다. 교과서 및 시청각자료 등 다양한 학습자료를 활용하여 수업을 진행한다. 과제를 내주고 결과를 검토 및 지도한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","certLic":"중등학교정교사","dJobECd":"2121","dJobECdNm":"[2121]중·고등학교 교사","dJobJCd":"2521","dJobJCdNm":"[2521]중·고등학교 교사","dJobICd":"P852","dJobICdNm":"[P852]중등 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003694:1', '{"dJobCd":"K000003694","dJobCdSeq":"1","dJobNm":"미술교사","workSum":"중·고등학교에서 학생들에게 대상물에 대한 시각적 표현능력, 미적정서 등을 가르치기 위하여 미술, 미술과 생활 및 관련 과목을 전문으로 교육한다.","doWork":"교과내용은 미적체험, 표현, 미술감상, 미술의 이해, 미술창작의 영역으로 구성되고 구체적으로 회화, 조소, 디자인, 서예, 감상 등에 대해서 배운다. 주제, 표현방법, 조형요소와 원리, 재료와 용구에 대한 이론적 지식과 다양한 기법을 설명하고 시범을 보인다. 과제를 내주고 결과를 검토 및 지도한다. 학생들의 작업과정을 살피고 평가·정정한다. 학생들의 미술대회, 작품전시회 등을 주관하고 특기생을 개별지도하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|시각|","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","certLic":"중등학교정교사","dJobECd":"2121","dJobECdNm":"[2121]중·고등학교 교사","dJobJCd":"2521","dJobJCdNm":"[2521]중·고등학교 교사","dJobICd":"P852","dJobICdNm":"[P852]중등 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002917:1', '{"dJobCd":"K000002917","dJobCdSeq":"1","dJobNm":"사회교사","workSum":"중·고등학교에서 학생들에게 사회 분야의 이해를 넓히기 위하여 일반사회, 세계사, 국사, 한국지리, 세계지리, 정치, 경제 및 사회문화 과목을 전문으로 교육한다.","doWork":"교과내용은 지리, 역사 및 사회과학 개념과 원리, 사회제도와 기능, 사회문제와 가치 그리고 연구방법과 절차에 관한 폭넓은 영역으로 사회현상을 종합적이고 다각적 관점으로 교육한다. 다양한 정보를 활용하여 사회현상에 관한 지식을 발견하고 문제를 해결하는데 필요한 비판적 사고력, 창의적 사고력, 판단 및 의사결정력 등의 신장을 강조하고 교육한다. 교과서 및 시청각자료 등 다양한 학습자료를 활용하여 수업을 진행한다. 과제를 내주고 결과를 검토 및 지도한다. 시험을 출제하고 학생의 성적을 평가한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","connectJob":"전문교과목에 따라 국사교사, 세계사교사, 일반사회교사, 지리교사","certLic":"중등학교정교사","dJobECd":"2121","dJobECdNm":"[2121]중·고등학교 교사","dJobJCd":"2521","dJobJCdNm":"[2521]중·고등학교 교사","dJobICd":"P852","dJobICdNm":"[P852]중등 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;