INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006511:1', '{"dJobCd":"K000006511","dJobCdSeq":"1","dJobNm":"원화작화감독","workSum":"그림의 통일성을 위해 원화원이 그린 그림을 검사하고 수정한다.","doWork":"애니메이션연출가 및 감독과 함께 작업일정 및 진행방향에 대해 협의한다. 여러 원화원이 그린 그림을 취합하여 검사하고, 미비한 부분을 수정한다. 서로 상이한 그림들이 일관적이고 통일성이 있도록 원화원에게 수정을 지시하거나 직접 수정한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"원화작감","dJobECd":"4143","dJobECdNm":"[4143]만화가 및 만화영화 작가","dJobJCd":"2843","dJobJCdNm":"[2843]만화가 및 만화영화 작가","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001512:1', '{"dJobCd":"K000001512","dJobCdSeq":"1","dJobNm":"웹툰배경작가","workSum":"웹툰의 배경을 제작하고 원고 내에 배경을 삽입한다.","doWork":"웹툰의 배경을 웹툰 작업 툴(tool)을 활용하여 제작하고, 원고 내에 배경을 삽입한다. 건물 등의 공간 배경 및 각종 소재 제작과 배치, 배경 채색 및 보정 작업 등을 담당한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"만화배경작가","dJobECd":"4143","dJobECdNm":"[4143]만화가 및 만화영화 작가","dJobJCd":"2843","dJobJCdNm":"[2843]만화가 및 만화영화 작가","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001277:1', '{"dJobCd":"K000001277","dJobCdSeq":"1","dJobNm":"웹툰후보정작가","workSum":"웹툰 원고의 완성도를 높이는 각종 만화적 효과를 작업한다.","doWork":"웹툰 원고에 후보정으로 다양한 만화적 효과(효과음, 배경 효과, 빛 효과, 집중선 효과 등의 각종 이펙트, 텍스처, 필터)를 작업하여 원고의 완성도를 높인다. 또한 말풍선, 대사의 식자 작업 등을 하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"만화후보정작가","dJobECd":"4143","dJobECdNm":"[4143]만화가 및 만화영화 작가","dJobJCd":"2843","dJobJCdNm":"[2843]만화가 및 만화영화 작가","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006267:1', '{"dJobCd":"K000006267","dJobCdSeq":"1","dJobNm":"입체영상애니메이터","workSum":"오브젝트(모델링, 리깅, 맵핑 작업이 완료된 캐릭터, 소품, 배경)에 움직임(Animating)을 만든다.","doWork":"애니메이션 제작 소프트웨어에 애니메이션 레이아웃 소스를 불러들인다. 작업 내용을 확인하고 신과 신 사이의 움직임을 만든다. 오브젝트의 모션컨트롤러를 조작하여 기본 동작을 만들고 모션 중간에 키값을 만들어 점차 자연스러운 동작을 구현한다. 함수곡선과 모션컨트롤 기법을 사용하여 오브젝트의 사실적인 움직임(가속, 감속, 포물선 운동, 불규칙 운동, 유연한 운동, 기계적인 운동 등)을 구현한다. 포워드 키네마틱스(Forward Kinematics:하나의 관절만 독립적으로 움직이는 기법), 인버스 키네마틱스(Inverse Kinetics:하나의 관절이 움직였을 때 다른 관절이 그 관절에 의해서 움직이는 기법), 멀티컨드롤 포인트(Multi Control Point:여러 개의 관절을 동시에 제어하는 기법), 픽스 컨트롤 포인트(Fix Control Point:사용자의 임의 조작에 의해서만 움직임을 갖는 기법) 등을 사용하여 캐릭터가 해부학적으로 자연스러운 동작(걷기, 던지기, 들기, 앉기, 돌기, 구부리기 등)이 되도록 세밀하게 조절하고 반복적으로 테스트하여 동작을 완성한다. 표정과 감정(Facial Animation)을 만드는 경우에는 형상 애니메이션(Shape Animation), 모핑(Morphing), 본(Bone) 등의 제작기법을 사용하여 기본이 되는 표정을 중심으로 다른 여러 가지 표정을 제작하여 사용한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"3D애니메이터","connectJob":"2D애니메이터","dJobECd":"4143","dJobECdNm":"[4143]만화가 및 만화영화 작가","dJobJCd":"2843","dJobJCdNm":"[2843]만화가 및 만화영화 작가","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006719:1', '{"dJobCd":"K000006719","dJobCdSeq":"1","dJobNm":"채색검사원","workSum":"지정된 색이 사용되었는지 확인하기 위하여 채색이 완료된 그림을 모니터상에서 검사한다.","doWork":"움직이는 대상인 캐릭터별로 지정된 색을 넣도록 채색원에게 지시한다. 채색이 완료된 그림을 모니터상에서 연속적인 동작으로 보면서 잘못된 부분이 있는지 검사한다. 채색이 잘못된 부분을 확인해 수정하거나 채색원에게 수정을 지시한다. 채색할 색을 지정하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"애니메이션컬러체커","certLic":"컬러리스트기사, 컬러리스트산업기사","dJobECd":"4143","dJobECdNm":"[4143]만화가 및 만화영화 작가","dJobJCd":"2843","dJobJCdNm":"[2843]만화가 및 만화영화 작가","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004529:1', '{"dJobCd":"K000004529","dJobCdSeq":"1","dJobNm":"채색원","workSum":"컴퓨터그래픽프로그램을 이용해 그림에 정해진 색을 입힌다.","doWork":"선화가 완료된 동화그림 파일을 열어 동화의 선이 매끄럽게 연결되었는지 확인한다. 컴퓨터그래픽 프로그램을 이용하여 그림선을 완전하게 정리한다. 색지정인이 정해준 색의 샘플과 비교하며 정해진 색을 찾아 입력해 채색한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"채색맨, 컬러페인터","certLic":"컬러리스트기사, 컬러리스트산업기사","dJobECd":"4143","dJobECdNm":"[4143]만화가 및 만화영화 작가","dJobJCd":"2843","dJobJCdNm":"[2843]만화가 및 만화영화 작가","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001360:1', '{"dJobCd":"K000001360","dJobCdSeq":"1","dJobNm":"클레이애니메이터","workSum":"클레이를 이용하여 캐릭터를 제작하고 촬영한다.","doWork":"클레이(Clay:진흙 등 점성 있는 소재)를 섞어서 원하는 색을 만든다. 결정된 캐릭터디자인을 토대로 알루미늄이나 스티로폼 등을 이용하여 뼈대를 만든다. 뼈대에 살을 붙인다. 구슬 등 적당한 재료를 사용하여 눈썹, 눈알 등 세세한 부분을 표현한다. 모델이 만들어진 후 촬영을 위한 컷에 해당하는 시트를 만든다. 촬영계획을 시트를 통해 구체적으로 정하고 계획대로 인형에 동작을 주면서 단계적으로 고정시켜 순간순간 연속적으로 촬영한다. 런치박스를 이용하여 촬영결과를 확인하고 수정한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"4143","dJobECdNm":"[4143]만화가 및 만화영화 작가","dJobJCd":"2843","dJobJCdNm":"[2843]만화가 및 만화영화 작가","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004234:1', '{"dJobCd":"K000004234","dJobCdSeq":"1","dJobNm":"퍼핏애니메이터","workSum":"인형을 사용한 영화를 제작한다.","doWork":"기본적인 이야기를 시나리오로 만들고 촬영의 전체적인 흐름에 따라 연출용 대본을 만든다. 촬영에 필요한 인형을 만들고 세트를 제작한다. 촬영 콘티를 바탕으로 세트 안에서 인형을 움직여 필요한 동작을 만들어 내고 장면별로 촬영을 한다. 찍은 수많은 사진 가운데 사용 가능한 컷들을 선택한다. 선택한 사진 한 장 한 장을 이어 붙여 연결 동작을 만든다. 전체 흐름에 맞춰 음악과 효과음을 넣는다. 자막이나 컴퓨터그래픽을 더해 전반적인 편집 작업을 마친다. 제작 규모에 따라 시나리오 작성, 촬영, 퍼핏(인형) 제작, 세트장 제작 과정의 모든 일을 수행하거나, 전문 분야별로 분담하여 일을 하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","dJobECd":"4143","dJobECdNm":"[4143]만화가 및 만화영화 작가","dJobJCd":"2843","dJobJCdNm":"[2843]만화가 및 만화영화 작가","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003700:1', '{"dJobCd":"K000003700","dJobCdSeq":"1","dJobNm":"국악기연주자","workSum":"청중을 대상으로 가야금, 거문고, 해금, 아쟁, 장구, 북, 대금, 피리 등의 국악기를 연주한다.","doWork":"연주에 사용될 악기를 조율한다. 악보를 익히거나 연주할 수 있도록 악곡연습을 반복한다. 연주회가 있을 경우 연주 리허설을 한다. 국악관현악단 등의 일원으로서 악단의 지시에 따라 가야금, 거문고, 해금, 아쟁, 장구, 북, 대금, 피리 등의 국악기를 연주한다. 국악연주 단체에 소속되어 있는 경우 정기·비정기 연주회를 비롯해 각종 행사 및 타 단체와의 협연 등에서 국악기를 연주한다. 단독으로 개인연주회 등에서 국악기를 연주한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"청각|손사용|","workFunc1":"종합","workFunc2":"오락제공","workFunc3":"정밀작업","similarNm":"국악사, 국악연주가","connectJob":"국악현악기연주자, 국악관악기연주자, 국악타악기연주자","dJobECd":"4144","dJobECdNm":"[4144]국악인 및 전통 예능인","dJobJCd":"2844","dJobJCdNm":"[2844]국악 및 전통 예능인","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006363:1', '{"dJobCd":"K000006363","dJobCdSeq":"1","dJobNm":"국악성악가","workSum":"청중을 대상으로 각종 국악기의 장단에 맞춰 가곡, 가사, 시조, 판소리, 민요 등을 부른다.","doWork":"원활한 소리를 내기 위해 발성 연습을 한다. 악보를 익히거나 악곡을 연습한다. 발표회 등을 위해 리허설을 한다. 청중들을 대상으로 가야금, 거문고, 해금, 아쟁, 장구, 북, 대금, 피리 등의 국악기 장단에 맞춰 가곡, 가사, 시조를 노래하거나 판소리, 민요, 창극 등을 부른다. 연주단체와 함께 공연을 하거나 개인공연을 한다. 작곡이나 편곡을 하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"청각|","workFunc1":"종합","workFunc2":"오락제공","workFunc3":"관련없음","connectJob":"민요성악가, 창극성악가, 판소리성악가, 시조성악가, 가곡성악가","dJobECd":"4144","dJobECdNm":"[4144]국악인 및 전통 예능인","dJobJCd":"2844","dJobJCdNm":"[2844]국악 및 전통 예능인","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006380:1', '{"dJobCd":"K000006380","dJobCdSeq":"1","dJobNm":"경음악단지휘자","workSum":"청중을 대상으로 악단과 같은 기악연주단의 연주를 지도하고 지휘를 한다.","doWork":"악기연주 심사(오디션)를 실시하여 기악연주자를 모집한다. 연주자들의 재능과 능력에 알맞은 연주곡을 선정한다. 화음이 균형과 조화를 이룰 수 있도록 기악연주자의 위치를 적절히 배정한다. 기악연주자에게 연주를 가르치며, 기악연주자 개개인의 재능을 최대한 이용하여 시연(리허설) 및 실제 공연을 지휘한다. 인원 구성 및 악기 구성에 따라 편곡작업을 하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"청각|손사용|","workFunc1":"종합","workFunc2":"오락제공","workFunc3":"관련없음","dJobECd":"4145","dJobECdNm":"[4145]지휘자, 작곡가 및 연주가","dJobJCd":"2845","dJobJCdNm":"[2845]지휘자·작곡가 및 연주가","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004838:1', '{"dJobCd":"K000004838","dJobCdSeq":"1","dJobNm":"기악연주자","workSum":"청중을 대상으로 오케스트라, 밴드 등 악단의 일원으로 관악기, 현악기, 타악기 등의 각종 악기를 연주하거나 단독으로 악기를 연주한다.","doWork":"연주에 사용될 악기를 조율한다. 악보를 익히거나 연주할 수 있도록 악곡연습을 반복한다. 연주회가 있을 경우 연주 리허설을 한다. 정기 및 비정기 연주회에서 기악연주단의 일원으로서 악단의 지시에 따라 혹은 개인연주회에서 관악기, 현악기, 타악기 등의 각종 악기 등을 연주한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"청각|","workFunc1":"종합","workFunc2":"오락제공","workFunc3":"정밀작업","connectJob":"관악기연주자, 현악기연주자, 타악기연주자","dJobECd":"4145","dJobECdNm":"[4145]지휘자, 작곡가 및 연주가","dJobJCd":"2845","dJobJCdNm":"[2845]지휘자·작곡가 및 연주가","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007094:1', '{"dJobCd":"K000007094","dJobCdSeq":"1","dJobNm":"대중악기연주자","workSum":"기타, 드럼, 베이스, 피아노, 신디사이저 등의 대중악기를 직업적으로 연주한다.","doWork":"대중가요가수의 공연이나 밴드 공연을 위해 악보를 익혀 연주할 수 있도록 연습한다. 밴드의 일원 또는 단독으로 각종 연주회 및 행사에서 기타, 드럼, 베이스, 피아노, 신디사이저 등의 악기를 연주한다. 대중가요가수의 음반을 녹음하기 위해 녹음스튜디오에서 노래 반주로 삽입되는 악기를 연주한다. 악보를 직접 편곡하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"청각|손사용|","workFunc1":"종합","workFunc2":"오락제공","workFunc3":"정밀작업","connectJob":"음반 제작을 위해 녹음실 또는 공연장에서 악기 연주를 전문으로 하는 경우 세션맨(Session Man)","dJobECd":"4145","dJobECdNm":"[4145]지휘자, 작곡가 및 연주가","dJobJCd":"2845","dJobJCdNm":"[2845]지휘자·작곡가 및 연주가","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005165:1', '{"dJobCd":"K000005165","dJobCdSeq":"1","dJobNm":"악단지휘자","workSum":"관악기, 현악기 및 타악기를 연주하는 관현악단을 지휘한다.","doWork":"관현악단을 구성하기 위하여 기악연주자의 연주를 심사한다. 계획된 공연에 적합하고 연주자들의 재능과 능력에 알맞은 연주곡을 선정한다. 각 악기의 화음이 균형과 조화를 이룰 수 있도록 연주자들을 편성한다. 악곡의 해석, 음악이론, 악기의 특성, 연주자의 재능 등을 고려하여 음색과 화음이 조화를 이루고 리듬, 빠르기, 강약 등의 음악적 효과를 낼 수 있도록 연주자들을 연습시키고 지휘한다. 연주 시에 악곡의 시작을 알리고, 지휘봉 또는 양팔로 악곡의 빠르기와 박자를 나타낸다. 악상을 표현하며 악단의 연주가 조화를 이루도록 통일성을 부여한다. 악곡의 끝마침을 알린다. 악보를 편곡하기도 하고 지방 또는 해외연주계획을 수립하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"청각|손사용|","workFunc1":"종합","workFunc2":"오락제공","workFunc3":"관련없음","similarNm":"악단장, 오케스트라지휘자, 교향악단지휘자","dJobECd":"4145","dJobECdNm":"[4145]지휘자, 작곡가 및 연주가","dJobJCd":"2845","dJobJCdNm":"[2845]지휘자·작곡가 및 연주가","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007583:1', '{"dJobCd":"K000007583","dJobCdSeq":"1","dJobNm":"작곡가","workSum":"각종 음악작품의 창작을 위해 곡을 작곡한다.","doWork":"음악의 장르를 구분하여 작곡의 전체적인 흐름을 계획한다. 음악의 가사를 파악한 후 가사와 적합한 곡을 구상한다. 멜로디, 리듬, 화음, 음악이론 등의 기초적인 지식을 이용하여 자신의 감정을 표현하도록 악보에 그리거나 컴퓨터의 음악프로그램을 이용해 직접 작곡한다. 작사가, 편곡가 등과 곡에 대하여 논의하고, 작곡한 곡을 녹음할 때 녹음방향에 대하여 조언한다. 대중가요가수의 음반, 영화 및 드라마의 OST음반, 가곡, 합창곡, 교향곡 등 특정 분야를 전문적으로 작곡하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"청각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"새로운 창작국악을 작곡하는 경우 국악작곡가","dJobECd":"4145","dJobECdNm":"[4145]지휘자, 작곡가 및 연주가","dJobJCd":"2845","dJobJCdNm":"[2845]지휘자·작곡가 및 연주가","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003655:1', '{"dJobCd":"K000003655","dJobCdSeq":"1","dJobNm":"편곡가","workSum":"작곡한 음악을 관현악단이나 피아노, 기타 등으로 연주할 수 있도록 편곡한다.","doWork":"원하는 음악의 효과를 얻기 위하여 목소리, 악기, 화음, 리듬, 박자 등의 조화를 확인하고 음악이론, 성악, 기악 등에 관한 지식을 기초로 음악의 분위기에 맞도록 편곡한다. 음의 합성이나 관현악단의 연주효과를 얻기 위하여 컴퓨터 편곡프로그램을 사용하여 연주하기도 한다. 편곡하는 목적에 따라서 관현악단, 밴드뮤직, 대중가요, 광고음악, 영화음악, 국악 등을 편곡하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"청각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"편곡하는 목적에 따라 국악편곡가, 대중음악편곡가, 광고음악편곡가, 영화음악편곡가","dJobECd":"4145","dJobECdNm":"[4145]지휘자, 작곡가 및 연주가","dJobJCd":"2845","dJobJCdNm":"[2845]지휘자·작곡가 및 연주가","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002632:1', '{"dJobCd":"K000002632","dJobCdSeq":"1","dJobNm":"합창단지휘자","workSum":"화음을 연출하기 위하여 합창단을 지휘하고 합창단원 및 합창단을 통솔한다.","doWork":"단무장과 함께 협의하여 특별공연, 정기공연 등 공연을 계획한다. 평가를 통해 합창단원을 선발한다. 합창단원들의 능력 및 재능을 고려하여 합창곡을 선곡한다. 발성법, 음색 등 단원 개개인의 성향을 파악한다. 지휘법, 음악이론, 발성법 등을 기초로 하여 다른 단원들과 화합할 수 있도록 지도한다. 합창단원과 함께 기악연주자를 지휘하기도 하며 악보를 편곡하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"청각|","workFunc1":"종합","workFunc2":"오락제공","workFunc3":"관련없음","similarNm":"컨덕터, 합창단장","dJobECd":"4145","dJobECdNm":"[4145]지휘자, 작곡가 및 연주가","dJobJCd":"2845","dJobJCdNm":"[2845]지휘자·작곡가 및 연주가","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004963:1', '{"dJobCd":"K000004963","dJobCdSeq":"1","dJobNm":"행사음악가","workSum":"각종 행사에서 사용될 음악을 선곡, 편집, 제작한다.","doWork":"행사연출가의 요구에 따라 음악을 상황에 맞게 준비한다. 음향감독, 무대감독 등과 협의하여 주된 음악을 선곡하여 행사장에서 사용될 음악을 구성한다. 상업행사에서 사용될 음원의 저작권자와 협의하여 사용권리를 취득한다. 음악을 행사장에서 순서와 상황에 맞게 공연할 수 있도록 한다. 편곡가에게 분위기에 맞는 편곡을 의뢰하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내·외","physicalAct":"청각|","workFunc1":"조정","workFunc2":"협의","workFunc3":"수동조작","dJobECd":"4145","dJobECdNm":"[4145]지휘자, 작곡가 및 연주가","dJobJCd":"2845","dJobJCdNm":"[2845]지휘자·작곡가 및 연주가","dJobICd":"N759","dJobICdNm":"[N759]기타 사업지원 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002467:1', '{"dJobCd":"K000002467","dJobCdSeq":"1","dJobNm":"대중가수","workSum":"대중의 즐거움을 위해 발라드, 댄스, 힙합, 록, R&B, 트로트 등의 대중가요를 부른다.","doWork":"힙합, 댄스, 발라드, 락, 트로트 등 다양한 장르의 작사·작곡된 악보를 보고 노래의 특징을 파악한다. 피아노, 기타 등의 반주에 맞추어 리듬을 확인하고 노래를 연습한다. 텔레비전 생방송 및 녹화방송에 출연하여 노래를 부른다. 콘서트를 개최하여 음악에 맞추어 노래를 부른다. 음반을 제작하기 위해 녹음실에서 노래를 녹음한다. 춤을 추기도 하고, 작사·작곡·편곡을 하기도 하며, 기타 연애·오락프로그램에 출연하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"청각|","workFunc1":"종합","workFunc2":"오락제공","workFunc3":"관련없음","similarNm":"대중가요가수, 가수","connectJob":"레퍼, 코러스, 트로트가수, 록커, 발라더, 전통가요가수, 트로트가수","dJobECd":"4146","dJobECdNm":"[4146]가수 및 성악가","dJobJCd":"2846","dJobJCdNm":"[2846]가수 및 성악가","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007505:1', '{"dJobCd":"K000007505","dJobCdSeq":"1","dJobNm":"성악가","workSum":"연주회나 독창회 등에서 피아노 반주 또는 관현악단의 연주에 맞추어 독창, 합창, 중창의 형태로 정통 고전음악 및 가곡을 노래한다.","doWork":"원활한 소리를 내기 위해 발성연습을 한다. 악보를 익히거나 악곡을 연습한다. 발표회 등을 위해 리허설을 한다. 화음, 멜로디, 리듬, 발성에 대한 지식을 기초로 피아노 반주 또는 관현악단의 연주에 맞추어 노래한다. 다른 성악가 및 반주자와 음색을 조정한다. 독창 또는 합창단원으로서 노래를 한다. 오페라의 등장인물로 출연하여 대사를 음악에 맞추어 표현하기도 한다. 작곡이나 편곡을 하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"청각|","workFunc1":"종합","workFunc2":"오락제공","workFunc3":"관련없음","connectJob":"소프라노, 알토, 테너, 베이스, 바리톤, 오페라가수","dJobECd":"4146","dJobECdNm":"[4146]가수 및 성악가","dJobJCd":"2846","dJobJCdNm":"[2846]가수 및 성악가","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004542:1', '{"dJobCd":"K000004542","dJobCdSeq":"1","dJobNm":"합창단원","workSum":"합창단의 일원으로서 청중을 대상으로 노래를 한다.","doWork":"정기공연, 특별공연, 기획공연 등 공연을 위해 소프라노, 테너, 베이스, 알토 등의 한 부분을 담당하여 악보를 익힌다. 고대음악에서부터 현대음악까지 음악의 역사적·문화적 배경을 배우고 그에 맞는 발성, 화음, 멜로디, 리듬 등을 익힌다. 합창단지휘자의 지시에 따라 노래를 연습한다. 반주 및 지휘에 맞추어 합창곡을 부른다. 무용을 가미하여 노래하기도 한다. 가수와 함께 출연하여 화음을 넣기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"청각|","workFunc1":"분석","workFunc2":"오락제공","workFunc3":"관련없음","connectJob":"백코러스를 전문으로 노래하는 경우 백보컬리스트","dJobECd":"4146","dJobECdNm":"[4146]가수 및 성악가","dJobJCd":"2846","dJobJCdNm":"[2846]가수 및 성악가","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007511:1', '{"dJobCd":"K000007511","dJobCdSeq":"1","dJobNm":"대중무용수","workSum":"관객을 대상으로 대중음악에 맞추어 춤을 춘다.","doWork":"안무가에게 춤 동작을 배우고 음악에 맞추어 동작을 연습한다. 혼자 또는 단체로 관객에게 여흥을 제공하기 위하여 대중음악에 맞추어 힙합댄스, 재즈댄스, 볼륨댄스, 밸리댄스, 스포츠댄스 등의 춤을 춘다. 가수들과 함께 공연을 하기도 한다. 각종 댄스대회에 참가하여 춤을 추기도 한다. 댄스학원에서 춤을 가르치기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workFunc1":"종합","workFunc2":"오락제공","workFunc3":"관련없음","similarNm":"댄서(Dancer)","connectJob":"대중가요가수의 노래에 맞추어 춤을 추는 경우 백댄서, 댄스 종류에 따라 볼륨댄서, 스포츠댄서, 밸리댄서, 힙합댄서, 재즈댄서, 비보이, 비걸","dJobECd":"4147","dJobECdNm":"[4147]무용가 및 안무가","dJobJCd":"2847","dJobJCdNm":"[2847]무용가 및 안무가","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007546:1', '{"dJobCd":"K000007546","dJobCdSeq":"1","dJobNm":"무용가","workSum":"청중의 공연을 위해 혼자 또는 단체로 무용을 한다.","doWork":"한국무용, 발레, 현대무용 등 안무가가 고안한 무용에 따라 무용 동작을 연습한다. 안무의 주제 및 스토리를 이해하며 안무가의 지도를 받는다. 음악에 맞추어 일정한 동작을 취하여 예술적인 작품을 행위의 언어로 표출한다. 창작품 또는 고전작품을 공연하고, 국내 및 해외의 무용페스티벌에 참가하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|","workFunc1":"종합","workFunc2":"오락제공","workFunc3":"관련없음","connectJob":"현대무용가, 발레리나, 한국무용가","dJobECd":"4147","dJobECdNm":"[4147]무용가 및 안무가","dJobJCd":"2847","dJobJCdNm":"[2847]무용가 및 안무가","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007479:1', '{"dJobCd":"K000007479","dJobCdSeq":"1","dJobNm":"안무가","workSum":"방송, 무대 등에서 공연하기 위한 춤(무용)을 고안하고, 창작한 춤을 대중무용수 및 무용가에게 가르친다.","doWork":"공연제작자 또는 방송프로듀서(방송연출가) 등과 공연 방향 및 콘셉트에 대해 협의한다. 공연 목적에 맞게 음악을 선정한다. 감정을 표현할 춤 동작을 구상한다. 공연에 참여할 무용수 또는 무용가를 구성하여 안무한 춤을 가르치고 연습시킨다. 무용을 연구하고 개발한다. 공연 시 직접 출연하여 춤을 추기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|","workFunc1":"종합","workFunc2":"교육","workFunc3":"관련없음","connectJob":"가수들의 댄스안무를 담당하는 경우 방송안무가","dJobECd":"4147","dJobECdNm":"[4147]무용가 및 안무가","dJobJCd":"2847","dJobJCdNm":"[2847]무용가 및 안무가","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007220:1', '{"dJobCd":"K000007220","dJobCdSeq":"1","dJobNm":"퍼레이드연기자","workSum":"유원지나 놀이공원 등의 각종 공연에서 관람객을 대상으로 캐릭터 공연, 퍼레이드 공연, 무대 연기 등을 한다.","doWork":"캐릭터인형을 쓰고 인형극 등을 연기하는 캐릭터연기자, 춤을 추는 댄서, 음악공연을 하는 밴드, 그리고 연극이나 뮤지컬 등의 공연을 하는 연기자로 구분하여 공연기획자와 안무가의 지도를 받아 공연 및 퍼레이드를 위한 연기 및 안무를 연습한다. 각자 정해진 역할에 따라 무대에서 공연을 하거나, 유원지 퍼레이드에 함께 등장하여 공연을 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workFunc1":"비교","workFunc2":"오락제공","workFunc3":"관련없음","dJobECd":"4147","dJobECdNm":"[4147]무용가 및 안무가","dJobJCd":"2847","dJobJCdNm":"[2847]무용가 및 안무가","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004091:1', '{"dJobCd":"K000004091","dJobCdSeq":"1","dJobNm":"견조련사","workSum":"개를 이용 목적에 맞게 훈련한다.","doWork":"훈련 대상 개들과 친화과정을 거쳐서 신뢰관계를 쌓는다. 용변가리기, 기본적인 동작(앉기, 일어서기, 정지 등) 수행하기 등 복종하는 훈련을 실시한다. 개의 특성을 파악하여 보청견, 맹인안내견, 경비견, 마약탐지견 등 목적에 맞는 개를 선발한다. 각종 훈련 도구 등을 이용해 집중적으로 훈련시킨다. 개의 건강상태를 점검하고 관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"시각|","workFunc1":"수집","workFunc2":"교육","workFunc3":"단순작업","similarNm":"애견트레이너, 핸들러","connectJob":"특수견훈련사, 안내견훈련사","dJobECd":"4149","dJobECdNm":"[4149]기타 시각 및 공연 예술가","dJobJCd":"2849","dJobJCdNm":"[2849]기타 시각 및 공연 예술가","dJobICd":"S969","dJobICdNm":"[S969]그 외 기타 개인 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005856:1', '{"dJobCd":"K000005856","dJobCdSeq":"1","dJobNm":"곡예사","workSum":"관객을 대상으로 혼자 또는 단체의 일원으로 신체와 사물을 이용한 각종 묘기를 실시한다.","doWork":"공연 전에 자신의 전문 묘기를 연습한다. 관객 앞에서 자신의 전문 분야에 따라 신체를 이용한 묘기(뛰어넘기, 공중곡예, 그네뛰기, 균형잡기, 근력묘기 등), 기구 또는 도구를 이용한 묘기(밥상돌리기, 훌라후프돌리기, 모자저글링, 검무, 마술 등), 동물을 이용한 묘기(말, 곰, 호랑이, 개 등), 고공묘기(높은 줄 위에 서서 공중회전, 외발자전거타기, 오토바이타기, 그네 옮겨타기 등) 등을 실시한다. 새로운 묘기를 창안하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|손사용|시각|","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"오락제공","workFunc3":"관련없음","connectJob":"공중곡예사","dJobECd":"4149","dJobECdNm":"[4149]기타 시각 및 공연 예술가","dJobJCd":"2849","dJobJCdNm":"[2849]기타 시각 및 공연 예술가","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003144:1', '{"dJobCd":"K000003144","dJobCdSeq":"1","dJobNm":"동물조련사","workSum":"동물원의 동물을 사육·관리하거나, 공연이나 인명구조, 맹인안내 등 특수한 목적을 위해 동물을 훈련시킨다.","doWork":"물개, 돌고래, 개, 원숭이, 말, 사자 등 조련할 동물의 특성에 대하여 학습하여 동물의 성격을 파악한다. 조련할 동물의 특성과 훈련 목적을 토대로 동물 훈련계획을 수립한다. 채찍이나 호루라기, 먹이 등을 이용하여 반복적인 훈련을 실시한다. 공연 시 동물이 각종 행동을 취하도록 유도한다. 동물의 건강상태를 파악하고, 이상이 있을 경우 수의사에게 알린다. 조련하는 동물을 사육하거나 보살피기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"웅크림|","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"교육","workFunc3":"수동조작","connectJob":"말조련사, 원숭이조련사, 코끼리조련사, 돌고래조련사","dJobECd":"4149","dJobECdNm":"[4149]기타 시각 및 공연 예술가","dJobJCd":"2849","dJobJCdNm":"[2849]기타 시각 및 공연 예술가","dJobICd":"R902","dJobICdNm":"[R902]도서관, 사적지 및 유사 여가관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003046:1', '{"dJobCd":"K000003046","dJobCdSeq":"1","dJobNm":"마술사","workSum":"관객들 앞에서 동전, 카드 등의 각종 마술도구들을 사용하여 마술공연을 한다.","doWork":"공연 의뢰를 받으면, 마술의 종류와 도구, 공연진행순서, 음악선곡 등을 계획한다. 계획에 맞게 마술공연을 연습한다. 동전이나 카드, 생활용품, 비둘기, 각종 마술도구들을 사용하여 공연한다. 공연이 없을 때는 기존에 익힌 마술들을 완벽히 연출하기 위해 연습한다. 새로운 마술기술을 개발하고 마술도구를 연구·제작한다. 학교나 단체, 개인을 대상으로 학원, 온라인 등에서 마술을 강의하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"종합","workFunc2":"오락제공","workFunc3":"정밀작업","dJobECd":"4149","dJobECdNm":"[4149]기타 시각 및 공연 예술가","dJobJCd":"2849","dJobJCdNm":"[2849]기타 시각 및 공연 예술가","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002854:1', '{"dJobCd":"K000002854","dJobCdSeq":"1","dJobNm":"버블리스트","workSum":"비눗방울을 이용한 공연을 한다.","doWork":"관객의 특성에 따라 다양한 버블쇼 프로그램을 구성한다. 사전에 공연장소의 환경을 파악하여 온도, 습도, 바람 등 비눗방울에 영향 미치는 요인을 고려한다. 비눗방울 용액과 다양한 크기 및 모양의 비눗방울을 만들 플라스틱 또는 철사 소재의 링 등과 같은 도구를 준비한다. 관객들 앞에서 연기를 곁들인 비눗방울 공연을 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"손사용|","workFunc1":"종합","workFunc2":"오락제공","workFunc3":"정밀작업","dJobECd":"4149","dJobECdNm":"[4149]기타 시각 및 공연 예술가","dJobJCd":"2849","dJobJCdNm":"[2849]기타 시각 및 공연 예술가","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001294:1', '{"dJobCd":"K000001294","dJobCdSeq":"1","dJobNm":"불꽃연출가","workSum":"불꽃축제를 기획하고 연출한다.","doWork":"불꽃축제의 기획 의뢰가 들어오면 현장답사를 통해 발사장소를 정한다. 어느 정도 안전거리를 두고 얼마나 견고하게 불꽃을 설치할 수 있는지를 고려해 발사장소를 선정한다. 회의를 거쳐 어떤 테마로 아름다운 불꽃을 연출할 것인지를 정하고 이에 맞는 음악을 선정하고 편집한다. 음악 선정이 끝나면 음악에 맞춰 적절한 모양을 내는 불꽃을 구상하고 불꽃을 점화할 때의 시간 간격과 어떤 형태로 불꽃을 배치할 것인지를 정하는 등의 전체적인 불꽃축제 연출을 기획한다. 불꽃축제의 허가서류를 준비해 관할 경찰서장의 허가를 받는다. 행사 당일 화약고에서 사용할 화약을 반출해 불꽃축제 현장으로 이동한다. 기획에 따라 현장에서 불꽃축제를 위한 화약과 발사 장치를 설치하고, 화재예방 및 안전 활동을 한다. 불꽃축제 시작 시간이 맞춰 불꽃과 연결된 버튼을 눌러 불꽃 공연을 시작한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실외","workEnv":"위험내재|","workFunc1":"조정","workFunc2":"협의","workFunc3":"제어조작","dJobECd":"4149","dJobECdNm":"[4149]기타 시각 및 공연 예술가","dJobJCd":"2849","dJobJCdNm":"[2849]기타 시각 및 공연 예술가","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005932:1', '{"dJobCd":"K000005932","dJobCdSeq":"1","dJobNm":"수족관다이버","workSum":"사육어류의 먹이주기, 관찰활동 및 관중을 위하여 물개, 돌고래 등의 묘기를 연출한다.","doWork":"어류사육사의 처방에 따라 먹이를 준비한다. 잠수도구를 착용하고 수조에 잠수하여 어류에게 먹이를 준다. 어류의 활동을 수중에서 관찰하여 어류의 활동 및 외형 등을 어류사육사에게 보고한다. 관객들이 볼 수 있도록 물개, 돌고래 등의 훈련된 동물의 농구, 고리걸기, 뛰어넘기 등의 묘기공연을 연출한다. 수조 내부의 이물질을 제거하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|청각|손사용|시각|","workEnv":"위험내재|저온|다습|","workFunc1":"분석","workFunc2":"오락제공","workFunc3":"단순작업","similarNm":"수중다이버","connectJob":"쇼다이버","certLic":"잠수기능사, 스킨스쿠버","dJobECd":"4149","dJobECdNm":"[4149]기타 시각 및 공연 예술가","dJobJCd":"2849","dJobJCdNm":"[2849]기타 시각 및 공연 예술가","dJobICd":"R902","dJobICdNm":"[R902]도서관, 사적지 및 유사 여가관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001696:1', '{"dJobCd":"K000001696","dJobCdSeq":"1","dJobNm":"아쿠아리스트","workSum":"대형수족관에서 고객에게 보여줄 수중생물을 사육, 관리, 연구하며 전시회 등을 기획한다.","doWork":"수족관 내의 수질 등을 감시한다. 수족관의 수질을 관리하기 위해 사용되는 여과장치 등을 조작·유지한다. 수질을 변경하기 위하여 수질이동 펌프 관련 장치를 조작하거나 화학약품을 투여한다. 수중생물의 먹이를 준비하고 먹이를 준다. 수중생물의 질병을 치료한다(바이러스성 질병의 경우 수의사가 치료한다). 불가사리, 물고기, 플랑크톤 등을 바다에서 직접 채집한다. 수달 등 동물들의 쇼를 고객과 함께 진행한다. 현장에서 고객들의 수중생물에 대한 질문에 대답을 하고 생물학적 지식 등을 고객에게 소개한다. 물고기 등과 같은 수중생물의 소개 자료를 작성한다. 수중생물의 도입을 위한 기획업무와 검역 등을 수행한다. 각종 전시회 등을 기획하기 위하여 수송문제, 안전 사육가능 여부 등을 확인하고 정보를 수집한다. 수족관을 청소한다. 수달 등 수중동물을 인공적으로 포육하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|청각|손사용|시각|","workEnv":"다습|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"수중생물전문가, 수족관관리자","connectJob":"어류사육사","certLic":"수산양식기사, 수산질병관리사","dJobECd":"4149","dJobECdNm":"[4149]기타 시각 및 공연 예술가","dJobJCd":"2849","dJobJCdNm":"[2849]기타 시각 및 공연 예술가","dJobICd":"R902","dJobICdNm":"[R902]도서관, 사적지 및 유사 여가관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006287:1', '{"dJobCd":"K000006287","dJobCdSeq":"1","dJobNm":"인형조종사","workSum":"인형극을 공연하기 위하여 인형을 제작하고 인형을 조정하여 인형극을 공연한다.","doWork":"대본(시나리오)을 검토하고 연출가와 협의하여 인형의 형태를 결정한다. 각종 수동공구를 사용하여 나무, 천, 종이, 철사, 플라스틱 등의 재료를 가공하여 인형을 제작한다. 인형을 조종할 수 있도록 손끝, 머리, 발등에 철사 또는 투명한 줄을 연결한다. 공연준비가 완료되면 무대의 위·아래에서 철사나 줄을 사용하여 인형을 조종한다. 대본에 따른 줄거리를 연결시키기 위하여 대사나 노래를 부른다. 조종하는 인형의 형태에 따라 사인형극(絲人形劇:줄을 이용해서 조종), 지인형극(指人形劇:손가락을 인형의 목에 넣고 막위로 나타내어 조작), 그림자인형극(인형의 그림자로 연기)의 인형을 조종한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"웅크림|손사용|시각|","workFunc1":"수집","workFunc2":"오락제공","workFunc3":"수동조작","dJobECd":"4149","dJobECdNm":"[4149]기타 시각 및 공연 예술가","dJobJCd":"2849","dJobJCdNm":"[2849]기타 시각 및 공연 예술가","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004716:1', '{"dJobCd":"K000004716","dJobCdSeq":"1","dJobNm":"풍선아티스트","workSum":"여러 가지 풍선으로 동물이나 아치 등을 만들어 행사장을 장식한다.","doWork":"풍선을 장식할 행사장과 행사 콘셉트, 고객이 원하는 장식형태에 대하여 고객과 상의한 후 구체적인 장식품을 구상하고 디자인한다. 행사일에 맞추어 손펌프 및 인플레이터를 이용하여 요술(막대)풍선, 원형풍선, 하트풍선 등을 불고 서로 연결한다. 색조합과 크기를 비교하면서 풍선의 균형 및 모양을 완성시킨다. 장식용도에 따라 풍선에 헬륨가스를 주입한다. 풍선을 불지 않고 장식품을 만든다. 장식품이 완성되면 행사장으로 옮겨 구상한 형태대로 장식한다. 풍선아트를 배우고자 하는 사람을 가르치기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"손사용|","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","similarNm":"풍선장식가","dJobECd":"4149","dJobECdNm":"[4149]기타 시각 및 공연 예술가","dJobJCd":"2849","dJobJCdNm":"[2849]기타 시각 및 공연 예술가","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007581:1', '{"dJobCd":"K000007581","dJobCdSeq":"1","dJobNm":"3D프린팅모델러","workSum":"3D프린터로 제품을 만들기 위하여 프로그램을 활용한 3D모델링을 한다.","doWork":"3D프린터 제작프로세스를 이해하고 2차원 디자인 도안을 3차원 제품으로 출력하기 위해 3D모델링 작업을 실시한다. 출력하는 제품 특성 및 소재에 따라 아웃라인을 이용한 NURBS모델링, 면을 이용한 POLYGON모델링 작업을 수행한다. 3차원 스캐닝을 활용하여 모델링을 위한 기초 데이터를 얻기도 한다. 프로토타입 출력을 위한 3D모델링 시제품을 설계한다. 콘텐츠 제작을 위한 고급 응용 3D모델링의 설계와 미니어처 및 완제품을 위한 3D모델링 디자인을 설계한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"3D프린터운영기능사","dJobECd":"1591","dJobECdNm":"[1591]제도사","dJobJCd":"2851","dJobJCdNm":"[2851]제품 디자이너","dJobICd":"M732","dJobICdNm":"[M732]전문 디자인업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001608:1', '{"dJobCd":"K000001608","dJobCdSeq":"1","dJobNm":"가구디자이너","workSum":"시장조사를 통해서 경쟁력 있는 가구를 개발하고 디자인한다.","doWork":"대리점, 국내외 전시장 등에서 시장조사를 하고 신제품 개발 계획을 수립한다. 아이디어 회의를 개최하여 가구디자인의 콘셉트를 선정한다. 선정된 디자인 콘셉트에 따라 도면을 작성한다. 제품의 생산성을 고려하여 시조도면을 작성한다. 원·부자재 수급 및 예상가격을 산출한다. 시조품을 제작하여 평가하고 문제점을 생산도면에 기재한다. 시조품의 품질을 평가하기 위해 신자재, 신공법에 따른 실험을 한다. 시험 결과 및 생산성을 고려하여 캐드(CAD) 등을 이용하여 최적의 생산도면을 작성한다. 목재 및 합판의 종류 등 가구생산에 필요한 각종 재료의 세부사항을 조사한다. 시판될 견본품이 완성되면 전시회를 개최하여 소비자의 의견을 수렴한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","certLic":"제품디자인기술사, 제품디자인기사","dJobECd":"4151","dJobECdNm":"[4151]제품 디자이너","dJobJCd":"2851","dJobJCdNm":"[2851]제품 디자이너","dJobICd":"C320/M732","dJobICdNm":"[C320]가구 제조업 / [M732]전문 디자인업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002987:1', '{"dJobCd":"K000002987","dJobCdSeq":"1","dJobNm":"도자공예디자이너","workSum":"컵, 주전자, 접시, 화분, 항아리, 도기인형 등 도자기를 소재로 하는 다양한 도자공예 제품을 디자인한다.","doWork":"개발할 도자공예품(도자기를 소재로 하는 다양한 공예제품)의 디자인 콘셉트를 설정한다. 아이디어 초안을 스케치로 기록하고 수정을 반복하여 디자인을 개발한다. 개발한 디자인에 따라 점토나 판지, 석고, RP(Rapid Prototyping:CAD 파일 또는 디지털방식으로 스캔 된 데이터로부터 3차원의 시제품을 직접 만드는 기술) 등을 사용하여 축소모형 또는 실제 크기의 견본을 제작한다. 모형·견본을 사용하여 디자인 프레젠테이션을 하기도 한다. 제작(제품화)에 필요한 사항(크기, 비례, 재질, 공정 등)을 수정·협의한다. 제작이 결정되면 시작품 제작 및 대량생산을 위한 제품도면을 작성한다. 제품의 종류에 따라 흙가래성형, 점토판성형, 물레성형, 형판성형, 석고제형, 기압성형, 주입성형, 기계물레성형 등의 제작기법을 사용하여 소량의 시제품을 생산한다. 시제품에 문제가 없으면 대량생산을 하도록 허락한다. 소량의 제품을 수작업으로 생산하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","similarNm":"크래프트디자이너(Craft Designer)","certLic":"제품디자인기사, 제품디자인산업기사, 도자공예기능사","dJobECd":"4151","dJobECdNm":"[4151]제품 디자이너","dJobJCd":"2851","dJobJCdNm":"[2851]제품 디자이너","dJobICd":"C232","dJobICdNm":"[C232]내화, 비내화 요업제품 제조업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001865:1', '{"dJobCd":"K000001865","dJobCdSeq":"1","dJobNm":"아트토이디렉터","workSum":"아트토이(기존 장난감에 아티스트나 디자이너의 그림을 입히거나, 디자인에 일부 변형을 입힌 장난감) 제작 사업을 기획하고 추진한다.","doWork":"잡지나 웹진 등을 보면서 자료를 수집하고 아트토이로 개발할 아이템을 구상한다. 고객의 의뢰에 따라 작업하는 경우, 고객과 협의하여 기획서를 만들기도 한다. 콘셉트를 설정하고 다양한 작가들이 입체적인 플랫폼 토이(Platform Toy)에 그림을 그릴 수 있도록 기획하고 추진한다. 컴퓨터 그래픽 프로그램을 사용하여 가상으로 디자인을 입혀보기도 한다. 아트토이를 제작할 공장을 섭외한다. 제품이 생산되면 보도자료나 홈페이지, 블로그 등을 통해 홍보한다. 전시회를 기획하기도 한다. 콘셉트를 브랜드화하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"조정","workFunc2":"협의","workFunc3":"정밀작업","dJobECd":"4151","dJobECdNm":"[4151]제품 디자이너","dJobJCd":"2851","dJobJCdNm":"[2851]제품 디자이너","dJobICd":"M732","dJobICdNm":"[M732]전문 디자인업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005562:1', '{"dJobCd":"K000005562","dJobCdSeq":"1","dJobNm":"자동차디자이너","workSum":"기존 자동차의 외형과 내장을 새로이 바꾸거나 새로운 차를 개발하기 위해 자동차 외형과 내장의 디자인을 연구·개발한다.","doWork":"회의와 시장조사 자료를 통해 생산할 차종의 종류와 크기를 결정한다. 경쟁회사의 차량 등을 조사하고 소비자의 욕구와 시장상황 등을 분석하여 기초자료를 생산한다. 기초자료를 바탕으로 아이디어를 스케치하여 그림으로 나타내며, 색연필, 마카펜, 각종 그래픽프로그램을 이용하여 구체적으로 그림을 그린다. 자동차의 내외장에 쓰이는 섬유, 플라스틱, 우드그레인 등과 같은 모든 자재 즉, 시트의 색상과 재질, 조명기구의 색상, 자동차 외형의 색깔 및 재질 등에 대해 연구·개발한다. 새로운 디자인에 대한 기본 개념설계가 완성되면 새로운 디자인이 적용된 차량의 각종 법률적인 규정의 준수 여부 및 각종 공학적 측면에서의 적합성을 검토한다. 최종 완성된 자동차의 원활한 판매를 위해 대량생산 이전의 단계에서 디자인이 완성된 차량의 각종 사양과 모양을 검토한 뒤, 신차나 개량된 차가 각 국가의 규정을 준수하였는지 여부를 판단한다. 인체공학, 유체공학과 같은 각종 공학적 측면에서 적합한지를 검토하여 대량생산 등의 상품화 이후에 발생할 수 있는 문제점에 대해서 미리 대비한다. 품평회를 열어 평가단에 의해 최종확정 후 관련 자료를 기술진에게 통보한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"전문영역에 따라 자동차외형디자이너, 자동차내장디자이너","dJobECd":"4151","dJobECdNm":"[4151]제품 디자이너","dJobJCd":"2851","dJobJCdNm":"[2851]제품 디자이너","dJobICd":"C302/M732","dJobICdNm":"[C302]자동차 차체 및 트레일러 제조업 / [M732]전문 디자인업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002452:1', '{"dJobCd":"K000002452","dJobCdSeq":"1","dJobNm":"자동차외형도면화전문가","workSum":"새로운 디자인으로 모델이 완성된 차량의 외관을 객관적인 수치로 나타내기 위해 3차원 수치화 작업을 한다.","doWork":"디자이너들이 개발한 새로운 모델의 차량을 3차원측정기(3-Dimensional Measuring Machine)를 이용하여 부분별로 수치화하여 컴퓨터로 재구성한다. 디자인이 완성된 차량을 상업용으로 생산하기 위해, 제품의 규격 등에 대한 표준화된 컴퓨터자료를 만든다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"제품디자인기사","dJobECd":"4151","dJobECdNm":"[4151]제품 디자이너","dJobJCd":"2851","dJobJCdNm":"[2851]제품 디자이너","dJobICd":"C302/M732","dJobICdNm":"[C302]자동차 차체 및 트레일러 제조업 / [M732]전문 디자인업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005001:1', '{"dJobCd":"K000005001","dJobCdSeq":"1","dJobNm":"제품디자이너(일반)","workSum":"제조될 상품의 형태를 구상하고 손, 기계, 컴퓨터 등 다양한 도구를 사용하여 디자인한다.","doWork":"디자인의 개념을 수립하기 위한 각종 자료를 수집하고 제품제조기술자, 판매 담당자, 경영주 및 기타 관련된 사람들과 협의한다. 제품의 모양 및 기능, 편리성, 제품의 원료, 제품생산기술, 생산원가, 생산방법, 시장특성, 고객의 요구사항 등을 고려하여 디자인에 대한 아이디어를 개발한다. 조사된 자료를 이용하여 제품의 형태를 구상하고 디자인된 결과를 그림으로 표현한다. 디자인 회의에 참석하여 디자인을 수정하거나 변경에 대해 협의한다. 손, 기계, 컴퓨터 등 다양한 도구를 사용하여 유사한 여러 모양의 디자인을 작성한다. 명세서를 작성하고 디자인의 스케치나 명세서를 보고 작업도를 작성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"제품에 따라 생활용품디자이너, 산업기기디자이너, 의료기기디자이너, 문구디자이너, 팬시디자이너, 완구디자이너, 액세서리디자이너, 전기전자제품디자이너, 가방디자이너, 안경디자이너, 모자디자이너","certLic":"제품디자인산업기사","dJobECd":"4151","dJobECdNm":"[4151]제품 디자이너","dJobJCd":"2851","dJobJCdNm":"[2851]제품 디자이너","dJobICd":"M732","dJobICdNm":"[M732]전문 디자인업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001553:1', '{"dJobCd":"K000001553","dJobCdSeq":"1","dJobNm":"주얼리디자이너","workSum":"목걸이, 팔찌, 귀걸이, 펜던트, 브로치, 넥타이핀과 커프링크 등 액세서리(장신구) 제품을 디자인한다.","doWork":"잡지, 전문지, 전시회, 인터넷, 전문 매장 등을 통해 디자인 트렌드를 파악하고 국내외 시장조사를 하여 상품성이 있는 디자인을 탐색한다. 제품을 구상하고 아이디어를 스케치한다. 보석, 귀금속 등 소재를 결정한다. 각종 작도 도구 및 그래픽 프로그램을 사용하여 렌더링(아직 제작되지 않은 제품을 제3자에게 제시하거나 이해시키기 위해 실제와 같이 표현하는 완성 예상도, 세공에 대한 정밀한 묘사)을 한다. 보석을 표현하는 경우 패싯(Facet:보석의 깎인 면), 마퀴즈(Marquise), 오벌(Oval), 페어(Pear), 바게트(Baguette), 테퍼드바게트(Taperd Baguette) 등의 형태를 작도하고 명암과 채색, 세팅부(연마된 보석을 바탕 금속에 고정시킴) 디자인을 더해 입체감 있게 표현한다. 금속을 표현하는 경우 평면(Flat), 곡면(Domed), 평면이 휘어진 형태(Flat, Curved)를 기본으로 다양하고 복잡한 형태를 작도하며 작도된 바탕 금속에 백색금속(White Metal)과 14K, 18K, 24K의 노랑색 금속(Yellow Metal)의 채색을 하고, 광택과 질감을 실물과 같이 표현한다. 보석과 금속의 표현기법 및 투시도법을 활용하여 반지, 목걸이, 팔찌, 귀걸이, 펜던트, 브로치, 넥타이핀 등 다양한 액세서리의 최종 디자인(렌더링)을 완성한다. 세공이 가능하도록 각 부분의 치수를 표시한 도면을 작성한다. 세공 기술자와 협의하고 제품의 대량생산과 판매를 위해 검토 및 승인을 받는다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"위험내재|고온|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"보석디자이너","connectJob":"귀금속디자이너, 옥디자이너, 장신구디자이너","dJobECd":"4151","dJobECdNm":"[4151]제품 디자이너","dJobJCd":"2851","dJobJCdNm":"[2851]제품 디자이너","dJobICd":"C331","dJobICdNm":"[C331]귀금속 및 장신용품 제조업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004755:1', '{"dJobCd":"K000004755","dJobCdSeq":"1","dJobNm":"포장용기설계원","workSum":"종이·합성수지·골판지 등의 각종 재료를 이용하여 포장할 물품의 특성 및 목적에 맞게 상자·종이백 등의 각종 포장용기로 제조하기 위한 설계업무를 한다.","doWork":"제품 사양서를 확인하고 포장특성(형태, 중량, 내용물 종류, 취급주의 사항, 충전물의 종류, 자동포장 방법 등)을 확인한다. CAD 프로그램을 사용하여 전개도를 제도한다. 종이나 판지 등 포장재료 위에 전개도를 실물과 같은 크기로 현도한다. 공구를 이용하여 절단·조립하여 견본을 제작한다. 시험장치를 이용하여 장력·힘·압력 등이 포장용기의 내구성과 같은 조건인지 확인한다. 검사결과를 기록한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"4151","dJobECdNm":"[4151]제품 디자이너","dJobJCd":"2851","dJobJCdNm":"[2851]제품 디자이너","dJobICd":"C172","dJobICdNm":"[C172]골판지, 종이 상자 및 종이 용기 제조업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004900:1', '{"dJobCd":"K000004900","dJobCdSeq":"1","dJobNm":"휴대폰디자이너","workSum":"휴대폰의 디자인을 형상화하기 위해 디자인 렌더링을 진행하고 목업(Mock-up)을 제작한다.","doWork":"휴대폰에 대한 시장환경의 이해를 바탕으로 경쟁사와 경쟁제품의 현황, 시장 환경, 디자인 트렌드 등을 파악하고 조사한다. 디자인 트렌드의 진화 방향과 사용자 분석을 거쳐 구체적 디자인 개발 방향을 도출할 수 있도록 기초자료를 확보한다. 분석 결과를 종합하여 휴대폰 개발에 필요한 차별화 요소를 결정하여 휴대폰 디자인 전략을 수립한다. 휴대폰에 필요한 차별화 요소와 경쟁 포인트 등의 구체적 사양을 바탕으로 디자인에 대한 아이디어를 전개한다. 다양한 표현기법을 이용하여 구체화된 아이디어를 시각화한다. 시각화된 아이디어 스케치에 소재와 질감, 작동원리와 양산방법에 적합한 구체적인 방안 등을 기반으로 아이디어를 구체화한다. 컴퓨터를 포함한 유사도구를 이용하여 제품을 표현하고 정밀하게 모델링하여 구현한다. 모델링된 자료를 바탕으로 실제 적용될 수 있는 색상, 재료 등을 구체화하여 디자인 렌더링을 진행한다. 다양한 제작기법을 통해 소재와 색상, 구조와 동작 등을 고려하고, 기구 설계와 금형 설계를 구현을 위한 모형을 제작하고 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"핸드폰디자이너","certLic":"제품디자인산업기사","dJobECd":"4151","dJobECdNm":"[4151]제품 디자이너","dJobJCd":"2851","dJobJCdNm":"[2851]제품 디자이너","dJobICd":"C264/M732","dJobICdNm":"[C264]통신 및 방송 장비 제조업 / [M732]전문 디자인업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003227:1', '{"dJobCd":"K000003227","dJobCdSeq":"1","dJobNm":"가발디자이너","workSum":"고객에게 맞는 소재와 유형의 가발을 디자인한다.","doWork":"고객 상담 및 두피분석을 통해 가발 유형을 결정한다. 고객에게 가장 잘 맞는 모발 및 스킨 소재를 선택한다. 비닐을 사용하여 고객의 두피 패턴을 뜬다. 패턴과 작업지시서를 가발제조원에게 보낸다. 제조된 가발을 고객에게 착용시키고 기존 머리카락과 얼굴형에 맞게 모발을 정리한다. 고객의 요구에 따라 가발을 염색하거나 스타일을 연출한다. 가발사용법 및 유의사항을 안내하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"정밀작업","dJobECd":"4152","dJobECdNm":"[4152]패션 디자이너","dJobJCd":"2852","dJobJCdNm":"[2852]패션 디자이너","dJobICd":"S969","dJobICdNm":"[S969]그 외 기타 개인 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003434:1', '{"dJobCd":"K000003434","dJobCdSeq":"1","dJobNm":"디지털이미지디자이너","workSum":"디지털염색(DTP)을 위한 문양(디지털이미지)의 패턴, 컬러 등을 디자인한다.","doWork":"원단 소재 특성에 따라 고객이 요청한 디지털화된 원시료의 문양 디자인 구성을 분석한다. 문양 디자인 프로그램을 활용하여 고객 요청에 부합하는 패턴디자인을 개발하여 제시한다. 국내 시장 및 해외 시장의 소비자 취향, 디자인 트렌드 등을 조사하고 분석한다. 분석된 자료의 체계적인 디자인 DB관리로 수요에 대응한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","certLic":"제품디자인기사, 제품디자인산업기사","dJobECd":"4152","dJobECdNm":"[4152]패션 디자이너","dJobJCd":"2852","dJobJCdNm":"[2852]패션 디자이너","dJobICd":"C139","dJobICdNm":"[C139]기타 섬유제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001470:1', '{"dJobCd":"K000001470","dJobCdSeq":"1","dJobNm":"모조장신용품디자이너","workSum":"귀금속, 보석 이외의 각종 재료를 사용하여 모조장신용품을 디자인하고 제품화한다.","doWork":"개발할 액세서리 제품의 모양 및 기능, 편리성, 재료, 생산방법, 생산원가, 시장특성, 고객의 요구사항 등을 고려하여 디자인 콘셉트를 설정한다. 아이디어 초안을 스케치하고 수정을 거쳐 디자인을 완성한다. 견본을 제작하고 수정한다. 제품화가 결정되면 제작 담당자와 재료, 재질, 공정, 제조방법 등을 협의하고 생산도면을 작성한다. 플라스틱 소재의 간단한 장신구, 각종 모조장신용품(목걸이, 팔찌, 브로치 등), 영화·드라마 등에 사용되는 장신구 소품, 다른 제품의 부분품 등을 디자인하기도 한다. 소량의 제품을 수작업으로 생산하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"액세서리디자이너","certLic":"제품디자인기사, 제품디자인산업기사","dJobECd":"4152","dJobECdNm":"[4152]패션 디자이너","dJobJCd":"2852","dJobJCdNm":"[2852]패션 디자이너","dJobICd":"C331","dJobICdNm":"[C331]귀금속 및 장신용품 제조업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004891:1', '{"dJobCd":"K000004891","dJobCdSeq":"1","dJobNm":"소잉디자이너","workSum":"침장, 액세서리, 가방, 관련 각종 소품 등을 디자인하고 재봉기로 제작한다.","doWork":"심미적 아름다움, 아이디어의 참신함, 사용의 편리성을 고려하여 디자인한다. 재봉틀의 종류와 다양한 원단, 바늘, 실, 부자재를 각각 이해하고 선별한다. 다양한 포켓, 앞 트임과 소매 트임, 허리 벨트, 단 처리, 소매, 칼라를 적절하게 작업하고 제작한다. 쿠션, 지갑, 가방 등 소품류는 물론 의류 등을 창의적으로 디자인하고 재단하며 재봉하고 제작한다. 필요에 따라 턱, 주름, 개더, 셔링, 러플, 스모킹, 파이핑, 패고팅, 퀼팅 등의 장식봉을 작업하고 제작하기도 한다. 필요한 작업지시서, 도면은 물론 패턴 등을 적절하게 작성하고 제작한다. 공방을 창업하여 운영하고 마케팅한다. 강의를 위한 커리큘럼, 계획표를 작성하고 수강생을 교육하고 관리하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"소음·진동|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"4152","dJobECdNm":"[4152]패션 디자이너","dJobJCd":"2852","dJobJCdNm":"[2852]패션 디자이너","dJobICd":"M732","dJobICdNm":"[M732]전문 디자인업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002195:1', '{"dJobCd":"K000002195","dJobCdSeq":"1","dJobNm":"소재디자이너","workSum":"의복의 디자인에 맞는 원단 소재를 결정한다.","doWork":"각종 국내외 정보를 수집, 분석하여 최신 유행 및 트렌드 등의 시장경향을 파악한다. 계절별 소재를 기획하여 주력 아이템을 시즌에 맞게 선정한다. 디자인이 결정되면 디자인에 맞는 원단 소재를 취합한다. 방직하는 협력업체에 원단생산을 주문(시직)한다. 시직 원단을 검토하여 품목별 최종소재와 색상을 결정하고 이에 따라 작업지시서를 작성하여 패턴실로 넘긴다. 제품이 완성된 후 원단검사 또는 봉제기술상의 문제점을 찾아내어 원단을 가공처리하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"의류기사, 섬유디자인산업기사","dJobECd":"4152","dJobECdNm":"[4152]패션 디자이너","dJobJCd":"2852","dJobJCdNm":"[2852]패션 디자이너","dJobICd":"C141","dJobICdNm":"[C141]봉제의복 제조업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004269:1', '{"dJobCd":"K000004269","dJobCdSeq":"1","dJobNm":"속옷디자이너","workSum":"시장조사와 트렌드를 예측하여 남녀 속옷 제품을 기획 및 디자인한다.","doWork":"국내외 관련 자료를 수집하고 분석한다. 시즌 경향(트렌드)을 분석하여 속옷 제품을 기획한다. 체형, 사이즈 등을 고려하여 브랜드의 고유 사이즈를 선정한다. 스타일, 색상, 구성 등 디자인의 아이템을 결정한다. 디자인 수량을 계획하고, 디자인을 스케치한다. 의상 제조에 필요한 원부자재, 부속품 등을 선택한다. 사이즈 및 물량을 확정하고, 판매량이 많은 품목에 대해 추가생산을 지시한다. 원부자재 수급을 위하여 관련 업체를 방문하고 상담한다. 디자인에 알맞게 패턴(Pattern:종이본)을 뜨고, 그레이딩(입체재단 또는 평면제도에 의해서 된 한 가지 사이즈의 패턴을 등차적으로 확대하거나 축소하는 작업)을 한다. 견본의상을 제작하기 위해 재단, 봉재 담당자와 협의한다. 견본의상이 제작되면 마네킹에 입혀보고 피팅 및 수정작업을 한다. 패키지 상품을 기획하고, 태그(꼬리표)를 개발한다. 완성품이 나오면 검품한다. 매장에서의 판매를 돕기 위해 원단 및 소재의 특성, 디자인의 특성 등의 내용이 담긴 상품 설명서를 제작한다. 원단 동향을 살피기 위해 시장조사를 하고, 소재 전시회 등에 참석한다. 타사 브랜드 제품을 분석하고 동향을 조사한다. 소비자들의 의견을 수렴하여 향후 디자인에 참고한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"이너웨어디자이너","connectJob":"소비자의 의뢰에 따라 특정 고객의 사이즈에 맞추어 속옷을 제작하는 맞춤속옷디자이너","dJobECd":"4152","dJobECdNm":"[4152]패션 디자이너","dJobJCd":"2852","dJobJCdNm":"[2852]패션 디자이너","dJobICd":"C141","dJobICdNm":"[C141]봉제의복 제조업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006565:1', '{"dJobCd":"K000006565","dJobCdSeq":"1","dJobNm":"신발디자이너","workSum":"시장조사와 트렌드를 예측하여 성별, 기능별로 각종 신발을 개발 및 디자인한다.","doWork":"새로운 디자인의 신발을 선보이기 위해 잡지나 인터넷을 통해 패션 경향을 파악한다. 소재, 색상 등 국내외 시장조사를 거친 후 신제품의 콘셉트를 정한다. 신발 신제품에 사용될 소재를 선택한다. 소재에 맞는 디자인을 스케치한다. 디자인에 맞는 굽과 코사개 등의 부자재를 선택한다. 신발을 도식화하여 어떤 소재와 부자재, 굽, 라스트(구두골) 등이 설명되어 있는 샘플제작요청서(Tech Package)를 개발 담당자에게 보낸다. 개발 담당자들이 신발의 샘플을 제작하면 피팅을 하여 착용감, 신었을 때의 모양 등을 확인한다. 수정·보완해야 할 점이 발생하면 재제작을 요청한다. 최종 샘플이 완성되면 품평회를 열어 어떤 색상과 소재를 적용하여 생산할 것인지를 결정한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"구두디자이너","connectJob":"운동화디자이너","certLic":"제품디자인기사, 제품디자인산업기사","dJobECd":"4152","dJobECdNm":"[4152]패션 디자이너","dJobJCd":"2852","dJobJCdNm":"[2852]패션 디자이너","dJobICd":"C152","dJobICdNm":"[C152]신발 및 신발 부분품 제조업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003940:1', '{"dJobCd":"K000003940","dJobCdSeq":"1","dJobNm":"애견옷디자이너","workSum":"애견의 옷을 디자인하고 제작한다.","doWork":"품목을 결정하여 애견옷을 디자인하고, 원단 및 부속품을 선택하여 견본 의상을 제작한다. 이를 마네킹 혹은 직접 애완동물에게 입혀보고 수정을 한 후, 최종 디자인을 확정한다. 디자인에 따라 애견옷을 제작한다. 만든 애견옷을 온라인으로 판매하기도 한다. 고객의 의뢰에 따라 애완동물에게 어울리는 옷을 특수제작하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"4152","dJobECdNm":"[4152]패션 디자이너","dJobJCd":"2852","dJobJCdNm":"[2852]패션 디자이너","dJobICd":"C141","dJobICdNm":"[C141]봉제의복 제조업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005598:1', '{"dJobCd":"K000005598","dJobCdSeq":"1","dJobNm":"융단디자이너","workSum":"새로운 도안의 융단을 제조하기 위하여 디자인한다.","doWork":"새로운 융단을 제조하기 위하여 국내·외의 패션 관련 자료를 수집·분석한다. 새롭게 구성된 디자인을 스케치하고, 융단제조에 필요한 재료를 선택한다. 융단견본을 제작하기 위하여 제작에 관련된 담당자와 협의한다. 제작된 견본품에 대한 품평회를 주관한다. 품평회에서 제안·건의된 내용을 참고하여 견본을 수정하거나 변경한다. 제품생산에 필요한 융단의 색상, 구성, 종류 등이 기재된 명세서를 작성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"카펫디자이너, 융단자리디자이너, 러그디자이너","certLic":"섬유디자인산업기사","dJobECd":"4152","dJobECdNm":"[4152]패션 디자이너","dJobJCd":"2852","dJobJCdNm":"[2852]패션 디자이너","dJobICd":"C139","dJobICdNm":"[C139]기타 섬유제품 제조업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007454:1', '{"dJobCd":"K000007454","dJobCdSeq":"1","dJobNm":"의상디자이너","workSum":"시장조사와 패션경향을 예측하여 성별, 연령별, 기능별로 각종 의상을 디자인한다.","doWork":"신제품을 개발하기 위하여 각종 국내외 패션 관련 자료를 통해 소재, 색상 등의 시장 경향을 분석·파악한다. 의상디자인을 스케치하여 디자인에 따라 작업지시서를 작성한다. 의상 제작에 필요한 각종 옷감 및 부속품 등을 선택한다. 디자인에 알맞게 본(패턴)을 뜨고, 필요한 장신구를 디자인하고 제작한다. 견본의상을 제작하기 위하여 재단·재봉 담당자와 협의한다. 제작된 견본품을 모델이나 마네킹에 입혀보고 지적된 문제점을 보완하여 최종 품목별 디자인을 결정한다. 완성품이 나오면 검품을 한다. 디스플레이나 코디를 조언하는 등 매장관리를 한다. 소비자들의 의견을 수렴하여 향후 디자인에 참고한다. 상품전시회나 패션쇼에 의상을 출품하거나 행사를 개최하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"패션디자이너","connectJob":"소비자의 연령·성별 등의 분류에 따라 남성복디자이너, 아동복디자이너, 여성복디자이너, 디자인하는 제품에 따라 가죽디자이너, 모피의류디자이너, 무대의상디자이너, 애완동물 옷을 디자인 및 제작하는 경우 애완동물옷디자이너","certLic":"의류기사, 섬유디자인산업기사, 패션디자인산업기사","dJobECd":"4152","dJobECdNm":"[4152]패션 디자이너","dJobJCd":"2852","dJobJCdNm":"[2852]패션 디자이너","dJobICd":"C141","dJobICdNm":"[C141]봉제의복 제조업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006266:1', '{"dJobCd":"K000006266","dJobCdSeq":"1","dJobNm":"텍스타일디자이너","workSum":"각종 천이나 섬유제품 개발을 위해 실의 종류, 제직 방법, 패턴, 컬러 등에 관한 디자인을 한다.","doWork":"소비자의 취향, 생활패턴, 유행의 흐름, 국가별 문화 등을 조사하고 분석한다. 향후 유행할 천의 소재 및 색상, 문양 등의 디자인 요소를 예측하여 선정한다. 타깃설정, 아이템 방향설정, 개발일정 작성 등 상품을 기획한다. 제품디자이너, 의상디자이너와 함께 텍스타일 디자인에 대해서 협의한다. 실의 굵기, 종류, 색상을 선택한다. 손으로 스케치하거나 디자인소프트웨어를 사용하여 기본문양을 디자인한다. 시제품이나 샘플 제작을 의뢰하거나 직접 만든다. 제품디자이너나 의상디자이너 등과 시제품의 결과에 대해 협의한다. 문제점을 파악하여 수정한다. 원단을 선정하는 과정에서 옷감디자인을 선택한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"니트디자이너, 직조디자이너, 프린팅(날염)디자이너, 융단디자이너","certLic":"섬유디자인산업기사","dJobECd":"4152","dJobECdNm":"[4152]패션 디자이너","dJobJCd":"2852","dJobJCdNm":"[2852]패션 디자이너","dJobICd":"C132","dJobICdNm":"[C132]직물직조 및 직물제품 제조업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003319:1', '{"dJobCd":"K000003319","dJobCdSeq":"1","dJobNm":"한복연구가","workSum":"궁중복식 등 전통한복의 복원과 한복의 개량과 보급에 대해 연구하고 각종 한복을 제작한다.","doWork":"한복의 대중화를 위해 생활한복 등에 대해 연구하여 제작한다. 궁중복식 등 고대 한복 등을 연구하며 재현한다. 복주머니 등 규방공예품에 대해 연구하며 제작한다. 패션쇼 등에 참가하여 한복의 우수성을 알린다. 새로운 개념의 한복, 규방공예품 등을 만든다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"한복디자이너","certLic":"한복기능사, 한복산업기사, 한복기능장","dJobECd":"4152","dJobECdNm":"[4152]패션 디자이너","dJobJCd":"2852","dJobJCdNm":"[2852]패션 디자이너","dJobICd":"C141","dJobICdNm":"[C141]봉제의복 제조업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007243:1', '{"dJobCd":"K000007243","dJobCdSeq":"1","dJobNm":"경관디자이너","workSum":"지역의 역사적 배경, 지리적 특성 및 주변환경을 심층적으로 분석하여 지역을 상징하는 콘셉트를 찾고, 공간을 효율적이고 아름답게 꾸미기 위해 기획하고 디자인한다.","doWork":"자원의 중요도와 가치 등을 기준으로 경관자원(자연경관자원, 산림경관자원, 농산어촌경관자원, 시가지경관자원, 역사문화경관자원 등)을 조사하고 평가한다. 평가 결과에 따라 경관디자인의 목적 및 기본방향, 지역 특성을 반영한 경관계획을 수립한다. 건축물, 색채, 오픈스페이스, 사인, 옥외광고물 및 야간경관 등 세부계획에 따라 기본설계 및 실시설계를 수행한다. 색채 및 조명 등을 표시한 기본설계도서, 컴퓨터시뮬레이션 등을 제작하고 클라이언트 및 관할 행정관청과 협의·조정한다. 경관위원회의 등 각종 심의/자문 의견에 따라 반영결과를 회신한다. 디자인의 이행과정을 관리하고 감수한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","similarNm":"경관계획가, 환경디자이너, 산림경관디자이너, 수경관디자이너, 역사문화경관디자이너, 가로경관디자이너","connectJob":"색채디자이너, 건축디자이너, 경관조명디자이너, 시설물디자이너","certLic":"컬러리스트, 도시계획기사, 조경기사, 조명기사","dJobECd":"4153","dJobECdNm":"[4153]실내장식 디자이너","dJobJCd":"2853","dJobJCdNm":"[2853]실내장식 디자이너","dJobICd":"M732","dJobICdNm":"[M732]전문 디자인업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007244:1', '{"dJobCd":"K000007244","dJobCdSeq":"1","dJobNm":"공공디자이너","workSum":"공공기관이 조성·제작·설치·운영 또는 관리하는 공공시설물에 대하여 공공성과 심미성 향상을 위하여 디자인한다.","doWork":"공공디자인 진흥계획 및 가이드라인 등을 수립한다. 각종 공공 디자인 현황을 조사하고 기획·설계한다. 공공공간(보도, 자전거도로, 횡단도, 어린이보호구역, 공원, 광장 등), 공공건축물, 공공시설물(가로등, 버스정류장, 볼라드, 벤치 등), 공공정보매체, 유니버설디자인, 범죄예방도시환경디자인 등 공공디자인 관련 사업의 기본설계 및 실시설계를 수행한다. 실시설계를 바탕으로 현장에서 설치 및 시공과정을 감독한다. 설계 및 디자인 내용이 현장에서 올바르게 제작·설치·시공되었는지 감리감독한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","similarNm":"유니버셜디자이너","certLic":"도시계획기사, 도시계획기술사","dJobECd":"4153","dJobECdNm":"[4153]실내장식 디자이너","dJobJCd":"2853","dJobJCdNm":"[2853]실내장식 디자이너","dJobICd":"M732","dJobICdNm":"[M732]전문 디자인업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003671:1', '{"dJobCd":"K000003671","dJobCdSeq":"1","dJobNm":"도시디자이너","workSum":"도시환경 색채, 도시안내시스템, 공공시설물 등 도시공간의 다양한 요소를 디자인한다.","doWork":"주민대표, 총괄계획가, 의뢰 행정단체, 시공용역사 등으로 구성된 도시환경 개선 프로젝트 회의에 참석하여 대략적인 진행 및 추진전략을 파악한다. 지역주민들의 요구사항 및 의견을 확인한다. 현장조사 내용 및 구상한 아이디어를 지도에 표시한다. 스케치를 통해 아이디어를 형상화한다. 현재 지역환경이 처한 문제점과 미래 개선점을 지역주민에게 발표하고 설명한다. 도시환경심리 및 인간 중심의 디자인, 지역·사회의 문화와 역사, 행정 사례, 관련 법규, 도시브랜드, 도시경관 등 다양한 요소를 고려하여 도시환경 색채, 도시안내시스템, 공공시설물 등에 대한 디자인 기획안을 작성한다. 구체적인 디자인에 착수하여 조감도 및 2D, 3D 모델링 한다. 축소모형을 제작하고 평가·수정하기도 한다. 최종 디자인이 결정되면 시공을 위한 설계도를 의뢰하거나 직접 작성한다. 시공 과정을 감독하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"Urban Designer, 도시환경디자이너(City Environment Designer)","connectJob":"도시 내부를 연결하는 길가(街路)에 건설하고 설치한 인공물(길가에 있는 건물/미술작품/동상/벤치/우체통/쓰레기통/공중전화/길안내표지판 등)을 디자인하는 경우 시설물디자이너(Street Furniture Designer)","dJobECd":"4153","dJobECdNm":"[4153]실내장식 디자이너","dJobJCd":"2853","dJobJCdNm":"[2853]실내장식 디자이너","dJobICd":"M732","dJobICdNm":"[M732]전문 디자인업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006468:1', '{"dJobCd":"K000006468","dJobCdSeq":"1","dJobNm":"디스플레이디자이너","workSum":"매출을 올리기 위해 상품판매 전략을 반영하여 매장에 상품을 진열하고 장식한다.","doWork":"외부장식(쇼윈도 디스플레이)의 경우, 맡은 상품과 브랜드를 파악하여 상품디자인의 의도와 목적, 상품판매전략 등의 정보를 수집한다. 상품과 브랜드 이미지를 광고하고, 정확히 전달할 수 있도록 소품선정과 설치방법 등 전체적인 시안을 구성한다. 만든 시안을 바탕으로 백화점 담당자나 매장 담당자와 상의하여 수정·보완한다. 확정된 시안대로 필요한 소품 및 물품들을 구매·제작하고 쇼윈도에 시공·설치한다. 내부장식의 경우, 상품디자인, 판매전략뿐 아니라 매장 인테리어와 구조, 고객의 동선을 꼼꼼히 파악한다. 전체적인 연출에서 포인트가 되는 부분을 설정하고 기획한다. 연출 포인트를 최대한 살리고, 구매욕구를 불러일으키도록 상품진열을 기획한다. 기획 내용을 매장 담당자나 브랜드 담당자 등과 의논하여 확정한다. 결정된 기획에 따라 필요한 소품 및 물품들을 구매·제작하고 매장 내에 설치한다. 내·외부 장식이 완료된 후, 사후 유지·관리를 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내·외","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"설득","workFunc3":"정밀작업","similarNm":"비주얼머천다이저(Visual Merchandiser), 디스플레이어","connectJob":"전문영역에 따라 쇼윈도디스플레이디자이너, 상품연출전문가(상품코디네이터)","dJobECd":"4153","dJobECdNm":"[4153]실내장식 디자이너","dJobJCd":"2853","dJobJCdNm":"[2853]실내장식 디자이너","dJobICd":"M732","dJobICdNm":"[M732]전문 디자인업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003279:1', '{"dJobCd":"K000003279","dJobCdSeq":"1","dJobNm":"라이프스타일리스트","workSum":"집 내부의 공간들과 집 외부의 세부적인 부분을 살기 좋고 보기 좋게 스타일링 한다.","doWork":"고객의 요구 또는 마감재나 구조 등 전체적인 집의 공간을 고려하여 연출할 공간을 기획한다. 공간 디자인뿐만 아니라 공간 데커레이션이나 커튼, 쿠션, 장식품 등을 활용하여 집 내부의 분위기를 스타일링 한다. 고객의 성향이나 생활양식을 반영한 스타일링 또는 아이디어를 제안한다. 고객이 원하는 소품이나 제품을 찾고 이를 반영하여 스타일을 연출하기도 한다. 신소재나 최신 트렌드를 사용하여 새로운 스타일을 연출하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"협의","workFunc3":"관련없음","similarNm":"인테리어스타일리스트","dJobECd":"4153","dJobECdNm":"[4153]실내장식 디자이너","dJobJCd":"2853","dJobJCdNm":"[2853]실내장식 디자이너","dJobICd":"M732","dJobICdNm":"[M732]전문 디자인업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006955:1', '{"dJobCd":"K000006955","dJobCdSeq":"1","dJobNm":"무대조명디자이너","workSum":"무대에서 빛의 사용 계획을 구성하고 극에서 필요한 구체적인 기능을 만족시키기 위해 조명을 이용하여 빛을 조절한다.","doWork":"작품을 분석하고 무대를 연출하는 연출가와 협의하여 무대를 구성한다. 스태프와의 회의를 통해 작품의 전반적인 콘셉트를 확인하고 적당한 색과 수준의 빛의 연출을 계획한다. 연출계획에 따라 조명기구의 위치, 효과 및 통제방법 등을 도면으로 작성한다. 공연자의 감정을 전달하고 관객이 공연에 집중할 수 있도록 동선을 체크하고 적절한 구도의 조명을 설치한다. 설치 후 작동여부를 확인한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","connectJob":"건축조명디자이너, 조명디자이너, 무대조명오퍼레이터","dJobECd":"4153","dJobECdNm":"[4153]실내장식 디자이너","dJobJCd":"2853","dJobJCdNm":"[2853]실내장식 디자이너","dJobICd":"M732/R901","dJobICdNm":"[M732]전문 디자인업 / [R901]창작 및 예술관련 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007498:1', '{"dJobCd":"K000007498","dJobCdSeq":"1","dJobNm":"실내장식디자이너","workSum":"주택, 상가, 사무용 건물 등의 내부장식을 계획하여 디자인하고 배치한다.","doWork":"내부시설에 대한 고객의 기호, 내부시설의 목적과 기능, 주어진 예산, 건축의 형태, 기타 내부환경에 영향을 미치는 요인에 대한 구체적인 자료를 조사하여 고객과 협의한다. 내부장식에 대한 조사결과를 종합하고 생산성의 향상, 판매촉진, 입주자의 생활양식 등 실질적인 상황을 검토하여 구체적인 계획을 수립한다. 공간의 이용계획, 가구나 시설의 배치와 이용, 색상의 배치 및 조성 등 내부에 필요한 사항을 고객과 협의한다. 고객의 요구에 맞는 디자인이 완성되면 정확한 도면을 작성하여 시공업자에 전달하고 작업현장을 감독·관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"대기환경미흡|","workFunc1":"종합","workFunc2":"협의","workFunc3":"관련없음","certLic":"실내건축산업기사","dJobECd":"4153","dJobECdNm":"[4153]실내장식 디자이너","dJobJCd":"2853","dJobJCdNm":"[2853]실내장식 디자이너","dJobICd":"M732","dJobICdNm":"[M732]전문 디자인업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003409:1', '{"dJobCd":"K000003409","dJobCdSeq":"1","dJobNm":"음악분수연출자","workSum":"분수시설을 이용해 예술적인 분수를 연출·기획한다.","doWork":"분수의 펌프 대수나 노즐 종류, 조명 및 전기시설 등을 파악하여 가능한 연출 방법을 구상한다. 클래식, 팝, 가요, 재즈 등의 다양한 장르 중에서도 많은 사람들이 좋아하고 오래 들어도 질리지 않는 곡을 위주로 선정하거나 해당 장소에 어울리는 음악을 선정한다. 음악을 연출에 적합하게 편집한다. 음악, 조명, 분수를 적절히 조합하여 다양한 모양과 움직임의 분수를 연출한다. 분수시설에 여러 곡의 연출 프로그램을 입력하고 정해진 시간에 작동되게 하거나 원격으로 조정한다. 특별한 이벤트를 수행하는 경우 실시간으로 음악분수를 조정하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"청각|시각|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"설치","dJobECd":"4153","dJobECdNm":"[4153]실내장식 디자이너","dJobJCd":"2853","dJobJCdNm":"[2853]실내장식 디자이너","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003556:1', '{"dJobCd":"K000003556","dJobCdSeq":"1","dJobNm":"인테리어디자이너","workSum":"상가 및 주택 등 건물 내부공간의 구조 및 시설의 배치 등을 구상하여 디자인한다.","doWork":"고객의 요구사항 및 특성을 파악하고, 건물의 목적과 기능, 예산 및 건축형태 등 내부 시설에 영향을 주는 요인을 조사한다. 건물의 용도에 따른 이용자의 특성을 파악한다. 자료를 종합하여 인테리어 설계 방향을 수립하고 고객과 협의한다. 공간 구조, 가구나 시설의 배치 및 이용, 색상 등 구체적인 계획에 대하여 고객과 협의한다. 실내공간을 대략적으로 디자인하여 고객과 협의가 이루어지면 세부 도면을 작성한다. 조명, 가구 등의 디스플레이 업체를 선정하고 실내장식에 관해 협의한다. 설계에 따라 시공되고 있는지 작업현장을 감독·관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"설득","workFunc3":"정밀작업","similarNm":"실내건축디자이너, 실내건축가","connectJob":"매장 등 상업공간을 디자인 하는 경우 상업공간디자이너(Shop Designer), 거주공간을 디자인 하는 경우 거주공간디자이너(Residence Designer)","certLic":"실내건축기사, 실내건축산업기사, 실내건축기능사","dJobECd":"4153","dJobECdNm":"[4153]실내장식 디자이너","dJobJCd":"2853","dJobJCdNm":"[2853]실내장식 디자이너","dJobICd":"M732","dJobICdNm":"[M732]전문 디자인업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007252:1', '{"dJobCd":"K000007252","dJobCdSeq":"1","dJobNm":"인테리어코디네이터","workSum":"건물의 내부를 장식하기 위하여 가구, 벽지, 소품 등을 결정하고 디자인한다.","doWork":"주택, 모델하우스, 리조트, 호텔 등 장식하고자 하는 건물에 대한 특성을 조사한다. 고객의 성향 및 요구사항을 파악하여 전체적인 콘셉트를 정하여 고객 및 인테리어디자이너와 상의한다. 인테리어디자이너가 작성한 실내도면을 전달받고 각 공간의 위치 및 전기설비 위치 등을 참고한다. 가구, 소파, 벽지, 커튼, 조명, 그림, 소품 등을 세부적으로 결정한다. 컴퓨터그래픽프로그램을 이용하여 이미지보드를 제작한다. 고객 및 인테리어디자이너와 최종적으로 협의하여 관련 업체를 선정하여 주거나 관련 물품을 직접 구매한다. 소품을 디자인하여 제작을 의뢰한다. 시공현장에 방문하여 도면대로 진행되고 있는지 감리한다. 시장조사를 위하여 박람회 및 전시장을 방문한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"시각|","workFunc1":"종합","workFunc2":"설득","workFunc3":"정밀작업","dJobECd":"4153","dJobECdNm":"[4153]실내장식 디자이너","dJobJCd":"2853","dJobJCdNm":"[2853]실내장식 디자이너","dJobICd":"M732","dJobICdNm":"[M732]전문 디자인업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004359:1', '{"dJobCd":"K000004359","dJobCdSeq":"1","dJobNm":"전시디자이너","workSum":"박물관, 과학관, 미술관, 기업 전시관, 기업 시연회, 쇼룸, 순회전시 등 대중을 상대로 전시하는 공간을 디자인한다.","doWork":"전시기획에 참여하여 전시 목적, 관람객 층, 전시공간의 구조 등을 파악한다. 주최자가 전달하고자 하는 메시지가 관람객들에게 효과적, 직관적이며 흥미롭게 전달되도록 스토리텔링(전시 스토리, 관람객의 동선 등)을 개발하고 문서화 한다. 전시 스토리에 구체적인 형태와 방향을 부여하여 전시 콘셉트(대락적인 드로잉)를 개발한다. 소재, 색상, 특수장비, 그래픽, 마감재, 기자재, 제작 사양, 미디어적 요소, 기술적 요소, 조명, 음향, 예산 등 세부적인 전시구성물을 고안 및 결정하여 디자인 계획안(세부사항을 그림으로 명시)을 수립한다. 제작 시공도, 준공 도면, 소재목록 등 시공에 필요한 문서를 작성하고 현장제작 담당자와 협의·수정한다. 모형을 제작하고 공개하여 관람객의 반응을 미리 평가하고 디자인을 수정하기도 한다. 시공 현장에서 시공과정을 진행 및 감독한다. 전시기간 중 전시물, 설치물을 유지 및 보수한다. 실제 전시에서 관람객의 전시 감상 시간, 전시 공간 내의 동선, 관람객의 반응을 조사하여 평가자료를 작성하기도 한다. 완료된 전시디자인 결과를 수렴하여 포트폴리오를 제작하고 발표하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","similarNm":"Exhibition Designer","certLic":"시각디자인기사, 시각디자인산업기사","dJobECd":"4153","dJobECdNm":"[4153]실내장식 디자이너","dJobJCd":"2853","dJobJCdNm":"[2853]실내장식 디자이너","dJobICd":"M732","dJobICdNm":"[M732]전문 디자인업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005389:1', '{"dJobCd":"K000005389","dJobCdSeq":"1","dJobNm":"조명디자이너","workSum":"건축물의 조명을 디자인한다.","doWork":"건축설계사나 고객의 요구에 맞게 또는 기존 건축물의 특징을 가장 잘 살릴 수 있도록 조명연출 계획을 세운다. 조명에 따른 법적인 문제나 사람들에게 미치는 심리적, 환경적 영향을 고려한다. 연출계획에 따라 조명기구의 위치, 효과 및 통제방법 등을 도면으로 작성한다. 조명기구 설치 시에 감리를 한다. 설치가 완료되면 시험 작동을 하고 문제점을 수정한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"손사용|시각|","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"4153","dJobECdNm":"[4153]실내장식 디자이너","dJobJCd":"2853","dJobJCdNm":"[2853]실내장식 디자이너","dJobICd":"M732","dJobICdNm":"[M732]전문 디자인업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006492:1', '{"dJobCd":"K000006492","dJobCdSeq":"1","dJobNm":"호텔행사장식가","workSum":"호텔의 각종 행사를 위해 조각물, 포스터 등의 장식물을 디자인하고 제작한다.","doWork":"호텔의 계절행사 등을 위해 시장조사를 한다. 호텔이나 식음료부 판촉을 위한 각종 장식품을 디자인하고 제작한다. 호텔행사에 필요한 표지판이나 포스터 등을 구상하고 제작한다. 행사 및 각종 연회에 필요한 얼음조각 및 장식을 준비하고 제작한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"호텔아티스트","dJobECd":"4153","dJobECdNm":"[4153]실내장식 디자이너","dJobJCd":"2853","dJobJCdNm":"[2853]실내장식 디자이너","dJobICd":"I551","dJobICdNm":"[I551]일반 및 생활 숙박시설 운영업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002516:1', '{"dJobCd":"K000002516","dJobCdSeq":"1","dJobNm":"PPT편집디자이너","workSum":"고객의 요구를 반영하여 파워포인트 자료 등을 작성하거나 편집한다.","doWork":"제안서, 보고서, 소개자료 등 프레젠테이션 자료를 작성하거나 편집한다. 고객의 요구에 맞춰 디자인 콘셉트를 도출하고 프레젠테이션을 디자인한다. 파워포인트의 각 슬라이드에 필요한 이미지를 포토샵을 이용하여 디자인하고 삽입한다. 초안이 작성되면 고객에게 확인을 받고 고객의 요청에 따라 수정작업을 실시한다. 일러스트레이터를 이용하여 작업을 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"프레젠테이션디자이너, PT디자이너","dJobECd":"4154","dJobECdNm":"[4154]시각 디자이너","dJobJCd":"2854","dJobJCdNm":"[2854]시각 디자이너","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004377:1', '{"dJobCd":"K000004377","dJobCdSeq":"1","dJobNm":"간판디자이너","workSum":"옥외광고물(간판)을 디자인한다.","doWork":"고객과 면담하여 옥외광고물의 형태와 광고의 목적 등을 협의한다. 현장 조사를 통해 주변 건물 및 건물의 현황, 주변 간판, 설치할 위치, 높이, 크기, 부착방법 등을 파악한다. 설치형태(옥탑광고, 옥상광고, 벽면광고, 야립광고 등), 네온(점멸 네온, 단순 네온, 파노라마 네온 등) 및 조명장치 사용 여부, 간판에 사용될 문구, 업종, 광고목표, 광고물 관련 규정 및 인허가 관련 사항, 주변 경관, 가시성, 시인성, 색채, 게시시간, 전기사용방식, 재료, 광고효과, 제작비용, 시장성 등을 종합적으로 검토한다. 각종 도안도구 및 컴퓨터 그래픽프로그램을 사용하여 디자인 시안을 제작한다. 고객 또는 다른 디자이너와 회의를 통해 시안을 검토하고 수정하여 완성한다. 제작 및 설치 실무자와 사용재료, 제작기법, 부착방법 등을 협의하고 현장에서 설치를 감독한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"사인디자이너(Sign Designer)","certLic":"시각디자인기사, 시각디자인산업기사","dJobECd":"4154","dJobECdNm":"[4154]시각 디자이너","dJobJCd":"2854","dJobJCdNm":"[2854]시각 디자이너","dJobICd":"M732","dJobICdNm":"[M732]전문 디자인업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006274:1', '{"dJobCd":"K000006274","dJobCdSeq":"1","dJobNm":"광고그래픽디자이너","workSum":"인쇄매체 광고물의 표현전략을 구상하고, 이에 관련된 시각적 표현전략을 수립하여 광고물을 작성한다.","doWork":"관련 스태프와 협동으로 혹은 독자적으로 광고표현전략과 아이디어를 찾아내며, 도출된 아이디어를 시각화하여 상품의 가치 및 기업의 정신을 소비자에게 전달한다. 상품 혹은 용역에 관한 정보를 얻고 광고물의 시각적 효과를 토의하기 위해서 광고주 및 광고시장조사원, 광고주담당자, 상업용영상물제작감독, 광고문안작성원 등 광고제작과 관련된 사람들과 협의한다. 각종 도안집이나 사진첩을 참조하여 아이디어를 얻는다. 복수의 디자인 기획안을 작성하여 광고주담당자, 상업용영상물제작감독, 광고문안작성원 등과 협의한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"분석","workFunc2":"협의","workFunc3":"정밀작업","certLic":"컴퓨터그래픽스운용기능사","dJobECd":"4154","dJobECdNm":"[4154]시각 디자이너","dJobJCd":"2854","dJobJCdNm":"[2854]시각 디자이너","dJobICd":"M713","dJobICdNm":"[M713]광고업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003214:1', '{"dJobCd":"K000003214","dJobCdSeq":"1","dJobNm":"광고디자이너","workSum":"제품에 따른 적합한 광고매체를 선택하여 크리에이티브(CR:creative, 광고의 창조적인 제작 표현행위) 전략을 계획하고 영상 및 인쇄매체의 광고 비주얼을 구성한다.","doWork":"제품이나 서비스 등 광고할 대상의 특성 및 소비자의 유형, 시장동향 등 대상물에 영향을 줄 수 있는 요인을 분석한다. 광고주의 요구사항을 참고하여 광고표현전략 및 아이디어를 구상한다. 광고문안작성원(카피라이터), 상업용영상물제작감독(PD) 등과 협의하여 광고물의 시각적 효과를 최대화시킬 수 있는 광고매체 및 비주얼을 선정한다. TV, 신문, 라디오, 잡지, 옥외광고 등 선택된 광고매체에 적합하게 디자인한다. 광고주와 협의하여 카피까지 혼합된 최종 광고시안을 확정·제작한다. 광고물 제작 및 촬영 시 참여하여 의도한 방향으로 광고물이 제작되도록 협의하고 제안한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"시각|","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","similarNm":"아트플래너, 아트디렉터, 크리에이티브디렉터","dJobECd":"4154","dJobECdNm":"[4154]시각 디자이너","dJobJCd":"2854","dJobJCdNm":"[2854]시각 디자이너","dJobICd":"M713","dJobICdNm":"[M713]광고업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004592:1', '{"dJobCd":"K000004592","dJobCdSeq":"1","dJobNm":"메디컬일러스트레이터","workSum":"의학·의료용 그림이나 문양을 도안하고 제작한다.","doWork":"의학논문, 학술대회 발표자료, 의학서적, 환자교육용 자료, 의학강의용 자료 등의 목적에 따라 의뢰인(의사 및 의료전문가)과 일러스트레이션의 방향 및 주제에 대하여 논의한다. 표현할 대상과 목적에 부합하도록 구도, 공간, 표현방법 등을 구상한다. 각종 도안용 도구와 컴퓨터프로그램을 사용하여 스케치하고 색상을 넣어 견본을 제작한다. 견본을 토대로 의뢰인과 협의하여 완성품을 제작한다. 일러스트레이션 작업이 완성되면 의뢰인에게 검토 받은 후, 수정 및 보완한다. 의학논문용 이미지를 제작하는 경우, 연구주제를 시각적으로 적절히 표현한다. 환자교육용 이미지를 제작하는 경우, 신체조직 및 치료방법에 대하여 환자가 거부감이 들지 않도록 순화하여 표현한다. 수술사진, 그림, 현미경사진, 해부학 이미지 등을 기초로 작업하기도 한다. 의과대학의 해부학 실습에 참여하여 실습하거나 실습을 지원하기도 한다. 의학논문에 삽입되는 그래프나 다이어그램을 디자인하거나 의료용 카툰(한 컷 만화)을 제작하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"4154","dJobECdNm":"[4154]시각 디자이너","dJobJCd":"2854","dJobJCdNm":"[2854]시각 디자이너","dJobICd":"M732","dJobICdNm":"[M732]전문 디자인업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003551:1', '{"dJobCd":"K000003551","dJobCdSeq":"1","dJobNm":"미디어파사드디자이너","workSum":"미디어 파사드(Media-Facade:건물 외벽 등에 LED 조명을 설치해 미디어 기능을 구현함)의 설계를 담당한다.","doWork":"설계 의뢰를 받은 건축도면을 꼼꼼히 검토해 미디어 파사드를 적용할 구역을 확인한다. 현장을 방문해 주변 상황과 환경 분석을 한다. 주변 건물과의 조화, 주변 조명의 영향, 다른 건물과 차별화, 주간의 주변 경관과 야간의 경관의 차이, 미디어 파사드를 설치했을 때의 가시권 등에 대한 평가를 한다. 도면 검토와 환경 분석을 바탕으로 설계제안서를 작성한다. 고객에 대한 시연과 수정을 거쳐 제안서를 수정한다. 현장에서 실제 시공 시, 현장감독을 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"4154","dJobECdNm":"[4154]시각 디자이너","dJobJCd":"2854","dJobJCdNm":"[2854]시각 디자이너","dJobICd":"M713","dJobICdNm":"[M713]광고업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006625:1', '{"dJobCd":"K000006625","dJobCdSeq":"1","dJobNm":"벽지디자이너","workSum":"시장조사와 생산성 등을 고려하여 벽지를 디자인한다.","doWork":"벽지 신제품을 개발하기 위하여 국내·외의 벽지에 대한 정보를 수집·분석한다. 계절·자사의 인쇄능력·기계수준 등을 고려하여 새롭게 만들 벽지를 디자인한다. 견본품을 만들어 품평회를 실시한다. 품평회에서 제안·건의된 내용을 참고하여 견본 책을 수정하거나 변경한다. 제품생산에 필요한 벽지의 색상·인쇄방법·구성·종류 등을 생산 공정 근무자와 상의한다. 명세서를 작성한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"제품디자인산업기사","dJobECd":"4154","dJobECdNm":"[4154]시각 디자이너","dJobJCd":"2854","dJobJCdNm":"[2854]시각 디자이너","dJobICd":"C179","dJobICdNm":"[C179]기타 종이 및 판지 제품 제조업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004715:1', '{"dJobCd":"K000004715","dJobCdSeq":"1","dJobNm":"북디자이너","workSum":"독자의 성향과 저자의 메시지 등을 고려하여 책의 표지 및 내지를 디자인한다.","doWork":"북 디자인의 흐름, 교구 등에 대한 시장조사를 한다. 소비자의 욕구에 맞는 디자인의 방향을 설정하고 기획한다. 삽화, 글의 배열, 글꼴의 크기, 색, 음영 등을 선정하고 디자인에 소요되는 비용 등을 추산하여 고객에게 제안한다. 기본아이디어를 토대로 책의 표지, 내지를 디자인하고 글의 위치 등을 배열한다. 여러 개의 디자인 안을 수립하여 내부 전문가 및 고객과 협의하여 최종 디자인을 선정한다. 디자이너의 의도에 따라 색채, 배열 등이 나올 수 있도록 인쇄결과물을 모니터링한다. 책에 들어갈 삽화 및 캐릭터를 제작하기 위해 만화가, 캘리그라퍼 등을 섭외하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"책디자이너","connectJob":"북아티스트","dJobECd":"4154","dJobECdNm":"[4154]시각 디자이너","dJobJCd":"2854","dJobJCdNm":"[2854]시각 디자이너","dJobICd":"M732","dJobICdNm":"[M732]전문 디자인업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002771:1', '{"dJobCd":"K000002771","dJobCdSeq":"1","dJobNm":"선물포장디자이너","workSum":"선물의 가치를 높이기 위하여 선물에 다양한 장식을 디자인하고 배치한다.","doWork":"선물의 목적과 대상 등 선물포장에 대한 고객의 요구를 파악한다. 선물포장을 더욱 미적으로 만들기 위하여 리본, 포장지, 풍선 등 소재와 색상을 선정한다. 손이나 칼, 가위 등을 사용하여 선물을 아름답게 꾸며줄 장식을 만든다. 본드나 매듭 등을 사용하여 선물에 부착한다. 치장된 선물포장을 고객과 함께 검토하고 수정한다. 광고나 공간을 채워줄 소품을 제작하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"수동조작","dJobECd":"4154","dJobECdNm":"[4154]시각 디자이너","dJobJCd":"2854","dJobJCdNm":"[2854]시각 디자이너","dJobICd":"G478","dJobICdNm":"[G478]기타 상품 전문 소매업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004734:1', '{"dJobCd":"K000004734","dJobCdSeq":"1","dJobNm":"아이덴티티디자이너","workSum":"기업, 제품 및 서비스 등과 같은 유형·무형의 이미지를 부각시킬 수 있는 로고나 상징(심볼)마크 등을 디자인한다.","doWork":"CI(Corporate Identity) 및 BI(Brand Identity)를 제작하고자 하는 회사 또는 기관의 요구사항, 기호, 특성, 환경, 이미지 등을 파악하기 위해 의뢰업체를 방문하여 조사한다. 기업 및 제품의 이미지에 적합한 디자인 전략을 수립한다. 다양한 아이디어를 구상하고 표현하며 고객과 협의한 후 컴퓨터그래픽프로그램을 이용하여 심볼마크, 로고타입, 색상, 서체 캐릭터 등 기본디자인시스템을 제작한다. 명함, 봉투 등의 서식류, 차량류, 사인류, 홍보물류 등에 개발된 디자인을 활용할 수 있도록 응용시스템을 개발한다. 고객이 디자인 시스템을 활용할 수 있도록 관리매뉴얼을 제작하거나 일관된 이미지를 유지할 수 있도록 디자인을 통해 관리하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"CI디자이너","dJobECd":"4154","dJobECdNm":"[4154]시각 디자이너","dJobJCd":"2854","dJobJCdNm":"[2854]시각 디자이너","dJobICd":"M732","dJobICdNm":"[M732]전문 디자인업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006937:1', '{"dJobCd":"K000006937","dJobCdSeq":"1","dJobNm":"옥외광고판설계원","workSum":"건물 외벽이나 옥상 등에 설치하는 옥외광고물을 설계하거나 옥외광고판을 설치할 구조물을 설계한다.","doWork":"옥외 광고물의 설치 공간을 보유한 소유주나 업체의 요청에 의해 현장을 방문한 뒤 광고물 설치에 적절한 크기와 위치를 확인한다. 캐드(CAD)를 이용하여 건축물의 외부면 및 내부면 광고판, 광고용 야외구조물 등을 설계한다. 설계 후 원가 견적서를 작성한다. 광고판이나 관련 시설물을 제작할 시공업체를 선정하여 발주한다. 시공업체가 공사하는 동안 설계자의 의도에 맞게 제작·설치되었는지 확인하는 등 시공업체의 진행상황을 관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"옥외광고사","dJobECd":"4154","dJobECdNm":"[4154]시각 디자이너","dJobJCd":"2854","dJobJCdNm":"[2854]시각 디자이너","dJobICd":"M713","dJobICdNm":"[M713]광고업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002688:1', '{"dJobCd":"K000002688","dJobCdSeq":"1","dJobNm":"유가증권디자이너","workSum":"컴퓨터그래픽을 이용하여 화폐 및 각종 유가증권의 원도를 디자인한다.","doWork":"보안용지설계 및 인쇄방법, 위변조방지기법에 대하여 숙지한다. 화폐, 상품권, 수표, 어음 등 각종 유가증권 및 보안인쇄물에 대한 작업지시서를 확인한다. 컴퓨터그래픽의 기본디자인을 바탕에 제작할 유가증권의 특징 및 성격에 맞도록 원도를 제작하기 위하여 기하학적 무늬인 채문과 그림을 디자인한다. 시안을 제작한다. 검토된 시안을 수정하여 인쇄에 적합한 원도를 제작한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"시안컴퓨터그래픽사, 채문원도컴퓨터그래픽사","certLic":"시각디자인산업기사, 컬러리스트산업기사","dJobECd":"4154","dJobECdNm":"[4154]시각 디자이너","dJobJCd":"2854","dJobJCdNm":"[2854]시각 디자이너","dJobICd":"C181","dJobICdNm":"[C181]인쇄 및 인쇄관련 산업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003219:1', '{"dJobCd":"K000003219","dJobCdSeq":"1","dJobNm":"음반케이스디자이너","workSum":"음악 테이프 및 CD·DVD와 같은 음반의 표지, 케이스 등에 음악의 장르나 가수의 특성을 시각적으로 표현할 수 있는 디자인을 한다.","doWork":"음반제작에 대한 계획이 수립되면 음반제작연출가에게 제작에 따른 제반 사항을 전달받고, 그에 필요한 협의를 한다. 음반 및 음악의 특성을 파악하여 디자인할 방향을 설정한다. 설정된 방향에 따라 각종 음반 표지자료를 도·소매 음반판매소, 서점 등에서 수집한다. 수집된 자료를 가지고 음악 및 가수의 특성이나 성격에 맞는 디자인을 시안하여 제시하고 수정한다. 수정되어 완료된 표지 및 케이스 등의 디자인을 인쇄필름으로 제작하거나 CTP(Computer To Plate) 출력한다. 제작된 인쇄필름을 인쇄소에 제공하고 인쇄제작을 한다. 인쇄과정에 나타난 문제점을 인쇄소와 협의하여 최종생산품으로 제작한다. 홍보용 포스터 및 팸플릿, 카탈로그와 같은 사보, 포장용 디자인 등을 제작하기도 한다. 웹용 홍보물(웹배너, 웹전단 등)을 디자인하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"4154","dJobECdNm":"[4154]시각 디자이너","dJobJCd":"2854","dJobJCdNm":"[2854]시각 디자이너","dJobICd":"C182","dJobICdNm":"[C182]기록매체 복제업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005601:1', '{"dJobCd":"K000005601","dJobCdSeq":"1","dJobNm":"일러스트레이터","workSum":"광고나 영상매체의 그림이나 문양을 도안하고 제작한다.","doWork":"도안 대상의 스타일이나 주제를 연구한다. 관련 시장의 추세 및 고객의 기호 등을 조사한다. 작성할 내용과 크기를 확인한다. 각종 도안도구 및 그래픽 프로그램을 사용하여 그림, 문자 등을 제도 혹은 스케치한다. 도안된 그림 혹은 문자를 내용에 부합되도록 배열·정리하고 색상을 넣어 견본을 제작한다. 이를 토대로 의뢰자와 협의하여 기호, 문양, 도안 등의 완성품을 제작한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"테크니컬일러스트레이터","dJobECd":"4154","dJobECdNm":"[4154]시각 디자이너","dJobJCd":"2854","dJobJCdNm":"[2854]시각 디자이너","dJobICd":"M732","dJobICdNm":"[M732]전문 디자인업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003149:1', '{"dJobCd":"K000003149","dJobCdSeq":"1","dJobNm":"캐릭터디자이너","workSum":"인물 또는 동물 등을 대상으로 특징적 혹은 상징적으로 표현한 일러스트레이션 형태의 캐릭터를 디자인한다.","doWork":"서적, 인터넷, 시장조사 등의 방법을 이용하여 온라인·오프라인상에서 유행하고 있는 캐릭터나 디자인의 흐름을 조사하고 분석한다. 대상에 대하여 스타일이나 주제를 연구한다. 시장조사를 통하여 영업 담당자, 상품 제작진과 함께 상품화할 아이템의 구상회의를 진행한다. 선정된 아이템에 대해서 세부적인 제품 사양에 대한 시각적인 정의를 내린다. 상품 제작진과 가격 및 제작비용에 대하여 협의하여 최종적인 아이템의 사양을 결정한다. 결정된 아이템을 라이트박스, 트레이싱지, 펜, 잉크, 붓 등이나 컴퓨터를 사용하여 필름이나 다른 매체에 도안을 하여 제품이 완성될 수 있도록 디자인한다. 때로는 직접 손으로 스케치한다. 상품 제작업체에 캐릭터에 대한 각종 디자인 자료 및 정보를 제공한다. 도안된 디자인을 내용에 부합되도록 배열·정리하고, 색상을 넣어 견본을 제작한다. 이를 토대로 협의하여 기호, 문양, 도안 등의 완성품을 제작한다. 제작된 상품이 캐릭터의 이미지에 적합하게 디자인되었는지 검사한다. 제품 판매 매장의 디자인과 제품의 전시에 대한 서비스를 제공하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"캐릭터아티스트","connectJob":"아바타디자이너, 캐리커처디자이너, 팬시캐릭터디자이너","dJobECd":"4154","dJobECdNm":"[4154]시각 디자이너","dJobJCd":"2854","dJobJCdNm":"[2854]시각 디자이너","dJobICd":"J591/M732","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업 / [M732]전문 디자인업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006473:1', '{"dJobCd":"K000006473","dJobCdSeq":"1","dJobNm":"캘리그라퍼","workSum":"붓을 이용하여 헤드라인, 타이틀, 로고 등의 글씨를 써서 작품화한다.","doWork":"제품 및 광고에 쓰일 캘리그라피(Calligraphy) 의뢰가 들어오면 제품이나 광고의 특성, 의미, 목적 등을 고려하여 글씨의 콘셉트를 결정한다. 붓을 사용하여 다양한 형태의 글씨를 써본 후 고객과 협의하여 최종적으로 글씨의 시안을 결정한다. 글씨를 스캔하고 컴퓨터그래픽 프로그램을 이용하여 틀이나 굵기, 간격, 흐름 등을 정리한다. 고객에게 결과물을 전달하고 고객의 요청에 따라 수정한다. 전각 업무나 먹그림을 그리기도 한다. 전시회를 개최하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"4154","dJobECdNm":"[4154]시각 디자이너","dJobJCd":"2854","dJobJCdNm":"[2854]시각 디자이너","dJobICd":"M732","dJobICdNm":"[M732]전문 디자인업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004046:1', '{"dJobCd":"K000004046","dJobCdSeq":"1","dJobNm":"컬러리스트","workSum":"상품의 부가가치를 높이기 위해 각종 상품의 색상을 결정하고 연출한다.","doWork":"색채와 관련된 자료를 수집하여 최신경향 및 유행 색상을 분석한다. 제품의 디자인 및 소재가 결정되면, 상품의 매출 극대화를 위해 상품의 색상을 조사 및 분석하여 결정한다. 소비자 선호조사 등을 실시하여 유행 색상을 예측한다. 색채규정을 검토 및 적용하여 상품의 색상을 기획한다. 색채를 배합하여 새로운 색채를 만든다. 만들어진 색채를 측정하고, 관리한다. 완성품이 나오면 색상에 대한 검품을 한다. 소비자들의 의견을 수렴하여 향후 색채 선택에 참고한다. 패션 디자인 분야의 경우 전체적인 정보(트렌드)를 제공하며, 소재디자이너가 선택한 원단을 고려하여 색상을 선택한다. 직접 상품의 물량을 결정하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"컬러코디네이터","connectJob":"종사하는 분야에 따라 패션컬러리스트, 화장품컬러리스트, 디지털색보정원","certLic":"컬러리스트기사, 컬러리스트산업기사","dJobECd":"4154","dJobECdNm":"[4154]시각 디자이너","dJobJCd":"2854","dJobJCdNm":"[2854]시각 디자이너","dJobICd":"M732","dJobICdNm":"[M732]전문 디자인업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006634:1', '{"dJobCd":"K000006634","dJobCdSeq":"1","dJobNm":"퍼스널컬러진단가","workSum":"고객 개인의 피부 톤을 진단하고 이에 맞는 옷 색깔, 색조 화장, 네일, 향수 등을 추천해준다.","doWork":"고객 얼굴의 베이스 컬러를 판단하기 위하여 화장을 지우고 진단에 영향이 없도록 흰색 두건이나 천을 덧댄다. 눈동자 및 피부 톤에 맞는 쿨 톤(블루 베이스) 및 웜 톤(노란 베이스)를 확인하고 이 중 고객에게 가장 잘 어울리는 색을 골라 최종적으로 고객의 컬러를 진단한다. 진단받은 고객의 컬러에 맞는 메이크업, 헤어컬러 등을 추천하고 액세서리, 네일 컬러, 향수 등 고객에게 맞는 스타일링을 추천해주기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"4154","dJobECdNm":"[4154]시각 디자이너","dJobJCd":"2854","dJobJCdNm":"[2854]시각 디자이너","dJobICd":"M732","dJobICdNm":"[M732]전문 디자인업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006854:1', '{"dJobCd":"K000006854","dJobCdSeq":"1","dJobNm":"편집디자이너","workSum":"각종 인쇄물의 표지 및 본문을 구성하고 디자인한다.","doWork":"출판하고자 하는 인쇄물의 내용 및 고객의 요구를 파악하고 표지 및 본문 구성에 대한 디자인을 구상한다. 책자, 포스터, 브로슈어 등 출판물의 시각적 효과를 부각시키기 위해 지면 구성안을 기획한다. 지면에 포함될 그림, 사진 등을 제작 또는 구매한다. 컴퓨터 편집프로그램을 이용하여 사진이나 그림, 글자형태 및 색깔, 크기 등을 조정하고 편집한다. 디자인 시안에 대하여 고객과 협의하고, 요구사항을 참고하여 수정·보완한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"출판물디자이너","dJobECd":"4154","dJobECdNm":"[4154]시각 디자이너","dJobJCd":"2854","dJobJCdNm":"[2854]시각 디자이너","dJobICd":"J581","dJobICdNm":"[J581]서적, 잡지 및 기타 인쇄물 출판업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004885:1', '{"dJobCd":"K000004885","dJobCdSeq":"1","dJobNm":"포장디자이너","workSum":"식품, 음료수, 화장품, 약품, 기계류 등의 포장지와 포장상자를 디자인한다.","doWork":"포장에 필요한 세부사항과 제품시장의 상황을 파악하기 위하여 제품제조기술자, 판매 담당자, 경영주 및 기타 관련된 사람들과 협의한다. 취급·보관의 편리성, 제품의 광고, 포장비용 절감 등의 요인을 고려하여 해당 제품의 포장상자 및 포장지를 디자인한다. 포장에 사용할 재질에 따라 종이, 나무, 유리, 플라스틱, 금속, 도자기 등으로 모형을 만든다. 포장지에 인쇄할 각종 상표나 도안을 디자인하고 색상을 선정한다. 관계자의 요구에 따라 모형이나 도안을 변경·수정한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"제품디자인기사, 시각디자인기사, 컬러리스트기사","dJobECd":"4154","dJobECdNm":"[4154]시각 디자이너","dJobJCd":"2854","dJobJCdNm":"[2854]시각 디자이너","dJobICd":"M732","dJobICdNm":"[M732]전문 디자인업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003911:1', '{"dJobCd":"K000003911","dJobCdSeq":"1","dJobNm":"폰트디자이너","workSum":"컴퓨터나 휴대전화 등에 사용할 한글, 영문, 기호의 글자꼴(폰트)을 디자인한다.","doWork":"글자체에 대한 소비자 선호, 브랜드 경향 등의 시장조사를 한다. 거리의 간판을 사진 촬영하거나 잡지 등을 통해 자료조사를 한다. 개발할 폰트의 용도(인쇄, 영상매체, 컴퓨터, 휴대전화, 게임, 브랜드 로고 등), 글자의 형태, 미적 이미지, 가독성 문제 등을 결정한다. 자료조사와 기본방침을 바탕으로 여러 개의 아이디어 스케치를 하여 그중에서 아이디어를 선택하고 개선할 부분들을 수정한다. 기본 골격이 되는 몇 자를 그래프 용지(모눈종이) 위에서 직접 연필로 정밀하게 그리고 다듬어 원도를 제작한다. 원도를 스캔하여 글자의 아웃라인을 따서 폰트디자인프로그램 상에 올린다. 정밀하고 통일성 있는 글자꼴을 위한 모듈로 사용할 열 개 정도의 기본 뼈대글자를 디자인한다. 모듈을 프로그램 작업화면의 백그라운드나 그리드 계층 화면에 불러들여 깔아 놓고 기본 자모를 디자인하여 메뉴 테이블을 만든다. 메뉴 테이블에서 기본 자모를 불러들여 KS표준코드 기준으로 2,350자를 완성한다. 한 문장 정도를 견본으로 조판하여 글자 크기, 굵기, 비례, 자간, 균형, 가독성 등을 검토하여 수정한다. 영문과 숫자, 기호를 완성하고 한글과 조판하여 한글과의 조화가 적절한지를 검토하여 수정한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"서체디자이너, 활자디자이너, 글자디자이너","certLic":"시각디자인산업기사","dJobECd":"4154","dJobECdNm":"[4154]시각 디자이너","dJobJCd":"2854","dJobJCdNm":"[2854]시각 디자이너","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003855:1', '{"dJobCd":"K000003855","dJobCdSeq":"1","dJobNm":"피오피(POP)디자이너","workSum":"구매시점광고(POP:Point of Purchase Advertising)를 디자인하고 제작한다.","doWork":"광고주로부터 주문이 들어오면 광고물의 목적, 개념 등을 소비자에게 효과적으로 전달할 수 있도록 광고문안, 색상, 광고형태 등을 구상한다. 각종 도안집이나 사진첩 등을 참조하여 아이디어를 얻는다. 도안작업을 시작으로 컬러링, 레이아웃, 칠작업 등 다양한 기법을 이용하여 제작한다. 완성된 광고물을 광고주에게 전달한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"구매시점광고제작원, POP제작원","dJobECd":"4154","dJobECdNm":"[4154]시각 디자이너","dJobJCd":"2854","dJobJCdNm":"[2854]시각 디자이너","dJobICd":"M732","dJobICdNm":"[M732]전문 디자인업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003784:1', '{"dJobCd":"K000003784","dJobCdSeq":"1","dJobNm":"홈데코레이터","workSum":"주거 내 장식을 위해 컬러상담 도구를 통해 고객의 취향을 분석하고 고객과 협의를 거쳐 적합한 컬러를 선정한다.","doWork":"실내 장식을 원하는 고객과의 미팅을 계획한다. 고객의 집에 방문하여 컬러상담 도구를 활용하여 고객의 색채 성향을 분석한다. 다양한 컬러 배색을 제안하고 고객과의 협의를 거쳐 최종 결정한다. 상담결과를 시공 담당자에게 전달한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"언어력|시각|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"컬러컨설턴트","certLic":"컬러리스트기사, 컬러리스트산업기사","dJobECd":"4154","dJobECdNm":"[4154]시각 디자이너","dJobJCd":"2854","dJobJCdNm":"[2854]시각 디자이너","dJobICd":"C204","dJobICdNm":"[C204]기타 화학제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001812:1', '{"dJobCd":"K000001812","dJobCdSeq":"1","dJobNm":"게임UI디자이너","workSum":"게임 사용자에게 유용한 플레이 경험을 제공할 수 있도록 게임에 등장하는 다양한 정보를 시각적으로 표현한다.","doWork":"기획 내용과 개발환경을 고려하여 게임플레이에 필요한 UI를 목록화하고, 레이아웃 구조를 설계한다. 설계한 구조에 적합한 UI 그래픽 리소스를 인터렉션을 통한 단계적인 변화를 고려하여 설계하고 디자인한다. 디자인을 바탕으로 게임 내 요소에 필요한 아이콘과 상징적인 요소들을 이미지로 표현하여 제작한다. 제작한 그래픽 리소스를 게임 화면에 배치하여 적용하고 개량한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"게임그래픽전문가, 서비스경험디자인기사","dJobECd":"4155","dJobECdNm":"[4155]미디어 콘텐츠 디자이너","dJobJCd":"2855","dJobJCdNm":"[2855]미디어 콘텐츠 디자이너","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007567:1', '{"dJobCd":"K000007567","dJobCdSeq":"1","dJobNm":"게임그래픽디자이너","workSum":"컴퓨터게임 등에 등장하는 각종 캐릭터와 배경, 아이템 등을 디자인한다.","doWork":"게임기획자와 게임시나리오작가가 구상한 내용을 참고로 캐릭터와 배경화면 등을 구상한다. 스케치 작업을 거쳐 색을 입힌다(컬러링 작업). 작업계획을 세운 후 그래픽 소프트웨어를 이용해 캐릭터의 모습과 주요 움직임, 아이템, 배경화면을 구성하여 모니터에 그려 넣는다. 게임 제작이 완성된 후 캐릭터나 배경이 어색한 곳은 수정하고 보완한다. 게임상에 보이는 메뉴, 창, 설정 창 등의 인터페이스(Interface:서로 다른 시스템을 연결해 주는 부분)를 제작한다. 원화가가 그린 캐릭터나 배경을 3D프로그램을 이용하여 만든다. 모델러가 만들어 놓은 입체물에 색감이나 질감을 입힌다. 반복되는 동작을 정교화한다. 마법이나 기술 등 각종 효과를 제작한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"제어조작","connectJob":"2D그래픽디자이너, 3D그래픽디자이너, 맵퍼, 애니메이터, 이펙트디자이너","certLic":"게임그래픽전문가, 컴퓨터그래픽스운용기능사","dJobECd":"4155","dJobECdNm":"[4155]미디어 콘텐츠 디자이너","dJobJCd":"2855","dJobJCdNm":"[2855]미디어 콘텐츠 디자이너","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004326:1', '{"dJobCd":"K000004326","dJobCdSeq":"1","dJobNm":"게임모델디자이너","workSum":"게임 원화 디자인을 바탕으로 캐릭터를 설계하고 실제 게임 제작에 사용할 수 있는 캐릭터 모델 데이터로 제작한다.","doWork":"게임 개발 기획 방향과 개발환경을 고려하여 원화 디자인을 분석하고 이해한다. 게임 화면 구성과 카메라 시점에 따라 캐릭터의 기본 형태와 행동에 따른 캐릭터의 형태를 설계한다. 게임의 분위기에 따라 캐릭터의 색상과 질감 등을 설계한다. 설계한 캐릭터를 바탕으로 제작에 필요한 기술을 결정한다. 기술에 따라 필요한 도트 구성(2D), 노멀맵, 폴리곤 수량, 텍스처 크기 같은 사항을 결정한다. 제작 원화와 기술적 사항을 바탕으로 게임에 적용하기 위한 캐릭터를 제작한다. 제작한 캐릭터의 질감과 색상을 연출한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"게임모델러, 캐릭터디자이너","connectJob":"2D게임모델디자이너, 3D게임모델디자이너","certLic":"게임그래픽전문가","dJobECd":"4155","dJobECdNm":"[4155]미디어 콘텐츠 디자이너","dJobJCd":"2855","dJobJCdNm":"[2855]미디어 콘텐츠 디자이너","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006825:1', '{"dJobCd":"K000006825","dJobCdSeq":"1","dJobNm":"게임배경원화디자이너","workSum":"게임 개발에 필요한 콘셉트 기획을 시각화하기 위하여 창의적인 아이디어를 시각화하여 배경의 콘셉트 원화와 제작용 원화를 제작한다.","doWork":"게임의 방향성을 바탕으로 다양한 자료를 수집하고 창의적인 아이디어를 도출하며 유사 디자인의 문제점, 개선점을 파악하여 콘셉트와 연계하여 구체화한다. 설정된 콘셉트를 이해하여 다양한 디자인 요소를 활용한 아이디어 스케치를 진행한다. 게임의 일관된 방향성에 맞추어 배경 콘셉트와 오브젝트 등의 요소에 대한 원화를 개발할 수 있다. 게임의 홍보를 위하여 아트 콘셉트를 효과적으로 보여줄 수 있는 일러스트를 그린다. 게임 내 리소스 제작에 참고가 되는 측면, 후면이 포함된 턴어라운드 이미지와 세부적인 구조 및 부위별 질감을 설명하는 배경 제작 시트를 제작하여 담당자에게 전달한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"게임그래픽전문가","dJobECd":"4155","dJobECdNm":"[4155]미디어 콘텐츠 디자이너","dJobJCd":"2855","dJobJCdNm":"[2855]미디어 콘텐츠 디자이너","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002640:1', '{"dJobCd":"K000002640","dJobCdSeq":"1","dJobNm":"게임애니메이션디자이너","workSum":"게임 개발에 활용할 수 있도록 기획 내용을 바탕으로 모델로 만들어진 그래픽 데이터를 활용하여 캐릭터, 배경의 움직임을 설계하고 제작한다.","doWork":"기획 내용과 개발환경을 고려하여 애니메이션을 개발하는 기술 환경을 협의한다. 게임 기획 내용을 바탕으로 애니메이션의 종류와 구성을 목록화한다. 게임 카메라 시점, 해상도, 픽셀 크기, 폴리곤 수와 같은 기술적인 사항을 고려하여 제작에 필요한 기술과 제작일정을 계획한다. 게임의 동작 분석을 바탕으로 애니메이션을 설정한다. 설정된 목록을 바탕으로 각 움직임에 적합한 애니메이션 구조를 제작한다. 구조에 맞추어 적합한 스킨을 제작한다. 시점 변환을 통해 객체의 움직임을 파악하고 속도와 모션의 성격을 부여하여 애니메이션을 제작한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"2D게임애니메이션디자이너, 3D게임애니메이션디자이너","certLic":"게임그래픽전문가","dJobECd":"4155","dJobECdNm":"[4155]미디어 콘텐츠 디자이너","dJobJCd":"2855","dJobJCdNm":"[2855]미디어 콘텐츠 디자이너","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2019","etc":"자격/면허 추가"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003581:1', '{"dJobCd":"K000003581","dJobCdSeq":"1","dJobNm":"게임이펙트디자이너","workSum":"게임 사용자에게 유용한 플레이 경험을 제공할 수 있도록 게임 속의 여러 객체에 대해 이펙트 있는 효과를 설계하고 제작한다.","doWork":"기획 내용과 개발환경을 고려하여 게임 이펙트 디자인을 개발하는 기술 환경을 협의한다. 게임 기획 내용을 바탕으로 이펙트를 적용해야 하는 객체들에 대한 목록을 정리하고, 필요한 작업량과 스케줄을 산출한다. 게임 카메라 시점 같은 기술적인 사항을 고려하여 이펙트 구현 원화를 바탕으로 시각적으로 적절한 효과를 설계한다. 설계 내용을 바탕으로 게임에 적용되는 여러 이펙트를 디자인하고 제작한다. 플레이 내용에 따라서 제작한 이펙트를 적용하고 분석하여 시각적 효과를 최대화할 수 있도록 조정한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"4155","dJobECdNm":"[4155]미디어 콘텐츠 디자이너","dJobJCd":"2855","dJobJCdNm":"[2855]미디어 콘텐츠 디자이너","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004624:1', '{"dJobCd":"K000004624","dJobCdSeq":"1","dJobNm":"게임캐릭터원화디자이너","workSum":"게임 개발에 필요한 콘셉트 기획을 시각화하기 위하여 창의적인 아이디어를 시각화하여 캐릭터의 콘셉트 원화와 제작용 원화를 제작한다.","doWork":"게임의 방향성을 바탕으로 다양한 자료를 수집하고 창의적인 아이디어를 도출하여 콘셉트와 연계하여 구체화한다. 설정된 콘셉트를 이해하여 다양한 디자인 요소를 활용한 아이디어 스케치를 진행한다. 게임의 일관된 방향성에 맞추어 게임 캐릭터를 스케치하고, 기획에 따라 색상과 분위기를 고려하여 캐릭터의 성격과 행동을 표현할 수 있는 제작 원화를 작성한다. 원화를 바탕으로 구체적인 캐릭터 디자인 작업에 필요한 정면, 측면, 후면 등으로 구성된 콘셉트 시트를 제작하여 담당자에게 전달한다. 게임 특성과 장르에 부합하는 다양한 형태의 응용형 캐릭터를 설정한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"게임일러스트레이터","certLic":"게임그래픽전문가","dJobECd":"4155","dJobECdNm":"[4155]미디어 콘텐츠 디자이너","dJobJCd":"2855","dJobJCdNm":"[2855]미디어 콘텐츠 디자이너","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2019","etc":"자격/면허 추가"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;