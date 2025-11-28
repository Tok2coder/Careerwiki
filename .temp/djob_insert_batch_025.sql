INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001574:1', '{"dJobCd":"K000001574","dJobCdSeq":"1","dJobNm":"그래픽유저인터페이스디자이너","workSum":"GUI(Graphic User Interface:사용자가 디지털 기기와 정보를 교환할 때, 그래픽을 통해 작업할 수 있는 환경) 디자인을 개발한다.","doWork":"디자인 리서치를 통해 제품 또는 서비스(컴퓨터 소프트웨어, 디지털카메라, 휴대전화기, 네비게이션 등 GUI로 동작하는 다양한 기기)에 대하여 사용자의 요구와 목표를 파악하고 해석한다. 디자인의 개발 방향을 제시한다. 제품 또는 서비스가 사용자에게 제공하는 기능을 파악하여 GUI의 목표기능을 정의한다. 기능을 수행하기 위한 도구(메뉴, 버튼, 서비스 구조, 시각효과, 사운드 등)를 고안하고 사용자가 쉽게 사용할 수 있도록 설계한다. 각종 도안 도구 및 컴퓨터 프로그램을 사용하여 GUI 디자인 시안을 제작한다. 관계자와의 회의를 통해 디자인을 수정한다. 프로토타입을 제작하고 반복적으로 테스트하여 오류를 수정하고 개선한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"GUI디자이너, 그래픽사용자환경디자이너","certLic":"시각디자인산업기사, 컬러리스트산업기사, 웹디자인기능사, 서비스경험디자인기사","dJobECd":"4155","dJobECdNm":"[4155]미디어 콘텐츠 디자이너","dJobJCd":"2855","dJobJCdNm":"[2855]미디어 콘텐츠 디자이너","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006956:1', '{"dJobCd":"K000006956","dJobCdSeq":"1","dJobNm":"메타버스크리에이터","workSum":"메타버스의 가상공간에 메타버스 사용자들을 위한 건축물, 아바타 맵 등의 서비스를 설계하고 구현한다.","doWork":"메타버스 가상공간에서 사용자들을 위한 아바타 맵을 만든다. 맵을 따라 건축물 등과 팝업스토어, 가상공간 전시전 등 가상 전용 콘텐츠를 위한 공간을 디자인하고 구현한다. 학교, 카페 등 실제 건축물을 3D개발 툴을 사용하여 모델링한다. VR기술로 구현하여 다양한 콘텐츠를 개발한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"제어조작","connectJob":"3D그래픽디자이너, 아바타디자이너","certLic":"게임그래픽전문가, 컴퓨터그래픽스운용기능사","dJobECd":"4155","dJobECdNm":"[4155]미디어 콘텐츠 디자이너","dJobJCd":"2855","dJobJCdNm":"[2855]미디어 콘텐츠 디자이너","dJobICd":"M732","dJobICdNm":"[M732]전문 디자인업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003018:1', '{"dJobCd":"K000003018","dJobCdSeq":"1","dJobNm":"모션그래픽디자이너","workSum":"비디오, 오디오, 사진, 그래픽 이미지 등에 애니메이션 테크닉을 이용하여 움직임이 있는 그래픽을 만든다.","doWork":"프로젝트에 대한 자료조사 및 기본적인 리서치를 수행한다. 제안서를 작성한다. 고객, 제작 감독, 실무 제작자 등과 제작회의를 한다. 제작회의를 통해 정해진 프로젝트의 전반적인 방향을 토대로 디자인 콘셉트를 설정한다. 화면의 레이아웃을 설정한다. 아이디어를 스케치한다. 샘플 이미지를 만든다. 스토리보드를 개발한다. 2D 또는 3D 제작 프로그램, 그래픽 프로그램, 타이포그래피 기술, 색채, 속도, 리듬, 공간감, 액션스크립트, 디지털비디오 편집 소프트웨어 등을 활용하여 움직이는 애니메이션을 제작한다. 오디오에 맞추어 영상의 움직임을 조정한다. 디자인하는 분야에 따라 방송국, 포스트프로덕션, 광고, 애니메이션, 인터넷, 디지털방송 등에서 사용되는 모션그래픽 프로젝트를 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"Motion Graphic Designer, Moving Graphics Designer, 모션그래퍼","connectJob":"전문 영역에 따라 디지털미디어광고디자이너(Digital Media Advertising Designer), 애니메이션디자이너(Animation Designer), CF디자이너(Commercial Film Designer)","certLic":"컴퓨터그래픽스운용기능사, 웹디자인기능사","dJobECd":"4155","dJobECdNm":"[4155]미디어 콘텐츠 디자이너","dJobJCd":"2855","dJobJCdNm":"[2855]미디어 콘텐츠 디자이너","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003175:1', '{"dJobCd":"K000003175","dJobCdSeq":"1","dJobNm":"셰이더","workSum":"게임의 구성요소를 컴퓨터 그래픽스를 이용하여 시각적으로 보여주기 위해 2D 및 3D 그래픽 요소와 다양한 렌더링 효과를 보여주는 셰이더(Shader)를 설계하고 구현한다.","doWork":"게임 기획에 따라 2D 그래픽 요소를 분석하고 컴퓨터 그래픽스로 2D 평면에 구현한다. 3D 그래픽의 경우 3D 그래픽 요소와 공간 배치를 분석하고 분석된 3D 그래픽 요소를 3D 공간에 구현한다. 구현된 2D 및 3D 그래픽 요소를 게임의 플레이 규칙에 맞게 통합하여 게임 프로그램을 구현한다. 게임 기획에 따라 다양한 렌더링 효과를 분석하고 분석된 렌더링 효과를 셰이더로 설계한다. 설계된 셰이더를 코딩하여 다양한 렌더링 효과를 프로그램으로 구현한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"게임프로그래밍전문가, 정보보안산업기사, 정보보안기사, 정보처리기사, 스마트폰개발자","dJobECd":"4155","dJobECdNm":"[4155]미디어 콘텐츠 디자이너","dJobJCd":"2855","dJobJCdNm":"[2855]미디어 콘텐츠 디자이너","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001304:1', '{"dJobCd":"K000001304","dJobCdSeq":"1","dJobNm":"온에어프로모션디자이너","workSum":"방송 채널의 프로그램을 시청자에게 홍보하는 각종 영상·디자인 및 채널 광고영상, 각종 이벤트 홍보영상 등을 전문적으로 제작한다.","doWork":"OAP(On-air Promotion) 팀장(PD)의 지시에 따라, 프로모션 영상(프로그램의 예고편, 티저영상, 이벤트 프로모션, 캠페인 영상 등), 프로그램 패키지(프로그램 로고, 타이틀, 브릿지, 스텝스크롤 등 영상 내 그래픽 작업물), 네트워크 디자인(채널의 특성을 보여주는 채널 ID영상, 시청자가 현재 시청하는 채널을 알 수 있도록 화면 상단에 표시하는 Bug디자인, 다음에 방영되는 프로그램을 알려주는 Next영상, 연령고지, 블록 오픈, 상단 바, 하단 바 등 채널의 기본적인 운행 정보를 알려주는 각종 툴 패키지 등)을 기획·제안하고 포토샵, 일러스트레이터, 에프터이펙트 등의 2D 디자인 및 영상 툴, Cinema4D·3D, MAX, MAYA 등의 3D 툴, 그래픽 편집 툴, 합성 툴 등을 사용하여 제작한다. 필러 영상물(Filler:텔레비전 방송에서 프로그램 사이의 시간을 메우기 위해 사용하는 영상, 예측할 수 없는 사고의 발생 등으로 프로그램을 방송할 수 없는 경우에 다른 예비 프로그램의 적시 공급이 어려울 때 사용되기도 함), 채널 자체를 소개하고 홍보하는 영상물 등을 제작하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"청각|손사용|시각|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"OAP(On-air Promotion)","certLic":"컴퓨터그래픽스운용기능사","dJobECd":"4155","dJobECdNm":"[4155]미디어 콘텐츠 디자이너","dJobJCd":"2855","dJobJCdNm":"[2855]미디어 콘텐츠 디자이너","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007463:1', '{"dJobCd":"K000007463","dJobCdSeq":"1","dJobNm":"웹디자이너","workSum":"웹사이트 개발에 필요한 디자인 및 구성요소를 개발한다.","doWork":"웹사이트 개발 및 수정을 위한 기획안을 검토한다. 개발팀과 개발일정을 협의한다. 디자인의 콘셉트를 결정한다. 디자인의 실제 구현을 위해 개발팀과 협의한다. 웹사이트 디자인에 필요한 UI(User Interface), 플래시, 애니메이션 등을 디자인한다. 실제화면을 제작하고 수정한다. 웹사이트 구성에 필요한 요소(폰트, 아이콘, 화면 등)를 제작한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"멀티미디어디자이너","dJobECd":"4155","dJobECdNm":"[4155]미디어 콘텐츠 디자이너","dJobJCd":"2855","dJobJCdNm":"[2855]미디어 콘텐츠 디자이너","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007246:1', '{"dJobCd":"K000007246","dJobCdSeq":"1","dJobNm":"음성사용자환경디자이너","workSum":"핸드폰, 내비게이션 등의 IT 제품에 음성인식을 기반으로 한 제품 시나리오를 구상하고 제품개발자들과 함께 제품개발 과정에 참여한다.","doWork":"제품에 음성인식을 적용하기 위해 사용자 관점에서 기본조사를 실시한다. 조사결과를 바탕으로 제품의 기능 및 사양에 맞게 음성인식으로 사용 가능한 음성기능을 확정한다. 각 기능별 음성인식 시나리오를 구상한다. 도식 등을 사용하여 시나리오를 정립시킨다. 정립된 시나리오를 바탕으로 제품개발자들과의 협의를 통해 실제 개발 가능 여부를 판단하고 기술제약에 따른 최적화 작업 및 합의점을 도출한다. 개발된 제품이 시나리오대로 작동하는지 성능실험, 불량실험 등 품질검증 실험을 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"청각|언어력|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"보이스인터페이스디자이너(Voice Interface Designer)","connectJob":"음성인식 이외 소리 분야의 경우 AUI(Auditory User Interface)디자이너","certLic":"서비스경험디자인기사","dJobECd":"4155","dJobECdNm":"[4155]미디어 콘텐츠 디자이너","dJobJCd":"2855","dJobJCdNm":"[2855]미디어 콘텐츠 디자이너","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001974:1', '{"dJobCd":"K000001974","dJobCdSeq":"1","dJobNm":"인포그래픽디자이너","workSum":"각종 통계자료 및 문서자료를 효과적인 디자인으로 시각화한다.","doWork":"인포그래픽정보기획자, 클라이언트 등으로부터 표현할 데이터를 받는다. 디자인 타입을 정하기 위해서 각종 자료를 읽고 파악한다. 대상과 전달 메시지를 고려하여 적합한 디자인, 글꼴, 크기, 색채 등을 관계자와 협의하여 결정한다. 협의된 내용을 토대로 그래픽 소프트웨어, 그래픽 태블릿 등을 이용하여 디자인하여 정보를 입체적으로 표현한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"컴퓨터그래픽운용기능사, 시간디자인산업기사","dJobECd":"4155","dJobECdNm":"[4155]미디어 콘텐츠 디자이너","dJobJCd":"2855","dJobJCdNm":"[2855]미디어 콘텐츠 디자이너","dJobICd":"M732","dJobICdNm":"[M732]전문 디자인업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004405:1', '{"dJobCd":"K000004405","dJobCdSeq":"1","dJobNm":"자막디자이너","workSum":"영화나 방송드라마 제작에 필요한 자막, 그림, 광고 등에 사용되는 글자를 디자인하고, 자막발생기를 사용하여 화면에 자막을 발생시킨다.","doWork":"영화 및 드라마의 내용, 주제 등을 검토하여 방송의 특성에 적합한 그림이나 자막의 형태를 결정한다. 도형의 형태가 결정되면 글씨체, 크기, 색상 등 세부적인 사항을 방송프로듀서(방송연출가)와 협의한다. 방송국의 편집실이나 부조정실에서 프로듀서의 큐 또는 방송작가가 작성한 자막대본에 따라 자막발생기(문자발생기, 자막발생 프로그램이 구동되는 방송장비) 또는 영상편집 프로그램, 디지타이저(특수펜으로 그림을 그리는 대로 입력되는 컴퓨터 입력장치), 전자펜 등을 사용하여 자막의 문자, 도형, 크기, 색, 이동속도, 화면상의 위치, 반복 횟수, 표시시간, 이미지 등을 입력하고 화면에 발생시킨다. 장면과 다른 내용, 오기 등 자막 오류가 발생하지 않도록 주의한다. 프로그램의 종류에 따라, 뉴스 해설자막, 자막뉴스(뉴스속보), 방송안내, 광고, 예능·오락프로그램 자막, 드라마, 영화자막 등을 만든다. 청각장애인용 폐쇄자막방송(Closed Captioning, 음성이나 오디오 신호를 TV 화면에 자막으로 표시하는 서비스로, 청각장애인들을 위해 텔레비전 프로그램의 청각 메시지를 전자코드 형태로 변환 전송하여, TV 화면에 해설자막으로 나타나게 하는 기술) 자막을 만들기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"수집","workFunc2":"협의","workFunc3":"정밀작업","similarNm":"자막도안사, 방송문자그래픽요원, 그래픽디자이너","connectJob":"방송자막원","dJobECd":"4155","dJobECdNm":"[4155]미디어 콘텐츠 디자이너","dJobJCd":"2855","dJobJCdNm":"[2855]미디어 콘텐츠 디자이너","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001742:1', '{"dJobCd":"K000001742","dJobCdSeq":"1","dJobNm":"경륜선수관리원","workSum":"경주에 참가하는 경륜선수가 최고의 컨디션을 갖출 수 있도록 입소지역 내에서 선수들의 활동을 관리한다.","doWork":"경기 출주가 확정된 선수들의 명단을 확인하여 출주 가능 여부를 파악한다. 출전선수확정서를 작성하여 관계위원에게 통보한다. 선수들의 체력 및 건강상태를 체크하고 선수교육과 관련된 업무를 도와준다. 출주 당일 선수에게 출주일정을 통보하고 선수들의 유니폼, 번호 착용 및 부착상태, 안전모 착용 여부를 점검한다. 선수들의 보험 및 보상과 관련된 제반 업무 및 사고 시 응급조치와 병원 후송을 돕는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"감독","workFunc3":"관련없음","connectJob":"경정선수관리원","certLic":"경기지도사","dJobECd":"4201","dJobECdNm":"[4201]스포츠 감독 및 코치","dJobJCd":"2861","dJobJCdNm":"[2861]스포츠 감독 및 코치","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005134:1', '{"dJobCd":"K000005134","dJobCdSeq":"1","dJobNm":"운동감독","workSum":"운동선수들의 훈련을 지도하고 시합 전략을 수립하는 등 운동선수단의 운영 및 경기력 향상에 관련된 제반 사항을 총괄한다.","doWork":"선수가 최대의 기량을 발휘할 수 있도록 컨디션을 파악하고 관리한다. 선수의 기량을 평가하여 적절한 위치에 배치한다. 시합이 개최될 경기장의 위치 및 환경, 기후 등 제반 조건을 미리 파악하여 작전을 세우고 선수지도에 참고를 한다. 시합을 위하여 자기팀이나 상대팀의 전력을 평가·분석한다. 운동선수코치를 지도하여 게임기술에 관해 선수를 훈련하도록 한다. 유능한 선수를 발굴하기 위하여 관련 경기에 참가한다. 감독하는 운동경기의 종목에 따라 호칭이 부여된다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","connectJob":"검도감독, 골프감독, 근대5종감독, 농구감독, 당구감독, 럭비감독, 레슬링감독, 루지감독, 봅슬레이감독, 스켈레톤감독, 바이애슬론감독, 배구감독, 배드민턴감독, 보디빌딩감독, 복싱감독, 볼링감독, 빙상감독, 사격감독, 사이클감독, 산악감독, 세팍타크로감독, 소프트볼감독, 수상스키감독, 수영감독, 수중감독, 스쿼시감독, 스키감독, 승마감독, 씨름감독, 아이스하키감독, 야구감독, 양궁감독, 역도감독, 요트감독, 우슈감독, 유도감독, 육상감독, 인라인롤러감독, 정구감독, 조정감독, 체조감독, 축구감독, 카누감독, 컬링감독, 탁구감독, 태권도감독, 테니스감독, 트라이애슬론감독, 펜싱감독, 하키감독, 핸드볼감독, 공수도감독, 댄스스포츠감독, 택견감독","certLic":"전문스포츠지도사 1급, 전문스포츠지도사 2급","dJobECd":"4201","dJobECdNm":"[4201]스포츠 감독 및 코치","dJobJCd":"2861","dJobJCdNm":"[2861]스포츠 감독 및 코치","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001999:1', '{"dJobCd":"K000001999","dJobCdSeq":"1","dJobNm":"운동코치","workSum":"선수의 기량 향상을 위해 가르칠 운동기술의 시범을 보여주면서 선수를 개인적으로 또는 집단적으로 지도한다.","doWork":"운동수행 시 발생할 수 있는 스포츠 상해를 줄이기 위한 예방법을 지도한다. 심장마비 등 운동 시 발생할 수 있는 응급상황 대응 및 처치 과정을 지도한다. 스포츠 현장에서 발생할 수 있는 비윤리적 행태와 관련해서 스포츠에 내재된 가치와 본질을 고수할 수 있도록 스포츠윤리(스포츠맨십, 스포츠인권, 스포츠도핑)를 지도한다. 선수가 최상의 경기력을 발휘할 수 있도록 심리훈련, 체력평가, 체력육성, 컨디션 조절, 경기력 분석, 동작분석 등을 지도한다. 종목에 따라 겨루기종목, 구기종목, 조준종목, 경연종목, 라이딩종목, 체력육성종목 등을 지도하며 시범을 보이거나 연습 상대를 하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","connectJob":"검도코치, 골프코치, 근대5종코치, 농구코치, 당구코치, 럭비코치, 레슬링코치, 루지코치, 봅슬레이코치, 스켈레톤코치, 바이애슬론코치, 배구코치, 배드민턴코치, 보디빌딩코치, 복싱코치, 볼링코치, 빙상코치, 사격코치, 사이클코치, 산악코치, 세팍타크로코치, 소프트볼코치, 수상스키코치, 수영코치, 수중코치, 스쿼시코치, 스키코치, 승마코치, 씨름코치, 아이스하키코치, 야구코치, 양궁코치, 역도코치, 요트코치, 우슈코치, 유도코치, 육상코치, 인라인롤러코치, 정구코치, 조정코치, 체조코치, 축구코치, 카누코치, 컬링코치, 탁구코치, 태권도코치, 테니스코치, 트라이애슬론코치, 펜싱코치, 하키코치, 핸드볼코치, 공수도코치, 댄스스포츠코치, 택견코치","certLic":"전문스포츠지도사 1급, 전문스포츠지도사 2급","dJobECd":"4201","dJobECdNm":"[4201]스포츠 감독 및 코치","dJobJCd":"2861","dJobJCdNm":"[2861]스포츠 감독 및 코치","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001472:1', '{"dJobCd":"K000001472","dJobCdSeq":"1","dJobNm":"프로게임단감독","workSum":"프로게임단의 선수를 관리하고 훈련시키며 코치 등 관련 종사자를 감독·지휘한다.","doWork":"e스포츠 프로게임단의 코치, 선수, 사무국과 협의하여 훈련계획, 선수선발 및 퇴출, 출전선수 등을 결정한다. 상대 선수 및 게임단의 전력을 분석하고 전략을 수립한다. 선수를 훈련시키고 연습시간 배분, 건강 및 심리, 사생활 등을 관리한다. 게임단을 대표하여 인터뷰, 사진촬영 등 대외적인 활동을 한다. 선수 및 사무국과 협의하여 연봉을 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","dJobECd":"4201","dJobECdNm":"[4201]스포츠 감독 및 코치","dJobJCd":"2861","dJobJCdNm":"[2861]스포츠 감독 및 코치","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006888:1', '{"dJobCd":"K000006888","dJobCdSeq":"1","dJobNm":"프로게임단코치","workSum":"프로게임단 감독의 지휘에 따라 선수를 관리하고 훈련시킨다.","doWork":"e스포츠 프로게임단의 훈련계획, 선수선발 및 퇴출, 출전선수에 대한 의견을 제시한다. 상대 선수 및 게임단의 전력을 분석하고 전략을 수립한다. 감독의 지휘에 따라 선수들의 연습시간 및 연습상대를 배분하고, 연습에서 생성된 데이터를 분석한다. 선수들과 함께 경기에 사용될 맵을 분석한다. 선수의 성적, 일정, 건강, 생활을 관리한다. 경기 현장에서 출전선수를 관리한다. 경기결과를 기록, 분석, 보고한다. 신규 맵을 테스트하고 의견을 제시한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","dJobECd":"4201","dJobECdNm":"[4201]스포츠 감독 및 코치","dJobJCd":"2861","dJobJCdNm":"[2861]스포츠 감독 및 코치","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005775:1', '{"dJobCd":"K000005775","dJobCdSeq":"1","dJobNm":"경륜선수","workSum":"경주용 자전거를 타고 우승을 가리는 경륜에 출주한다.","doWork":"경륜의 규정 및 기술을 습득하기 위해 개인 또는 단체로 훈련한다. 경주용 자전거의 정비기술을 습득하고, 이상이 없는지 정비한다. 출발 및 경기과정을 익힐 수 있도록 훈련한다. 우승전략을 수립하고, 경륜경주에 출주한다. 녹화된 경주결과를 분석하여 문제점을 파악하고 자세를 교정하거나 훈련 시 문제점이 개선되도록 적용한다. 새로운 기술을 습득하고 체력을 관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"오락제공","workFunc3":"조작운전","certLic":"경주선수","dJobECd":"4202","dJobECdNm":"[4202]직업 운동선수","dJobJCd":"2862","dJobJCdNm":"[2862]직업 운동선수","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006358:1', '{"dJobCd":"K000006358","dJobCdSeq":"1","dJobNm":"경마선수","workSum":"경주용 말을 타고 우승을 가리는 경마에 출주한다.","doWork":"경마 규정을 습득하고, 말의 혈통 및 특성을 파악한다. 말의 경주 능력을 향상시키고 경주에 적응시키기 위해 경주마를 훈련한다. 경주에 출주하거나 훈련을 담당한 말의 건강상태를 확인하고, 최상의 상태를 유지할 수 있도록 말의 상태를 조절한다. 조교사와 함께 우승전략을 수립하고 경마 시합에 출주한다. 경주결과를 분석하고 문제점을 파악하여 참고한다. 체중 및 건강상태를 조절한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"오락제공","workFunc3":"조작운전","similarNm":"프로경마선수, 경마기수","dJobECd":"4202","dJobECdNm":"[4202]직업 운동선수","dJobJCd":"2862","dJobJCdNm":"[2862]직업 운동선수","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003193:1', '{"dJobCd":"K000003193","dJobCdSeq":"1","dJobNm":"선두유도원","workSum":"사이클 트랙경주 중 경륜경기에서 최종주회 전회의 표지선까지 심판이 미리 지시한 주행방법에 의하여 출전선수를 유도한다.","doWork":"출발선으로부터 일정거리 전방에 위치하여 출발 신호에 의거 선수와 동시에 출발한다. 최종주회 표지선까지 외대선(外帶線:스프린터라인)과 내권선(內圈線) 사이를 규정된 주행방법에 의하여 선수를 유도한다. 심판이 지시한 시기에 도달한 때에 퇴피지대로 퇴피한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"오락제공","workFunc3":"조작운전","similarNm":"선두원, 유도요원","dJobECd":"4202","dJobECdNm":"[4202]직업 운동선수","dJobJCd":"2862","dJobJCdNm":"[2862]직업 운동선수","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006078:1', '{"dJobCd":"K000006078","dJobCdSeq":"1","dJobNm":"유도마기수","workSum":"마장취체위원의 지시를 받아 경마고객에 대한 출주인사를 할 수 있도록 마필과 기수가 관람대 전면을 통과하도록 유도한다.","doWork":"승마훈련원에서 유도마용 백색마필을 인수받아 마체의 이상 유무를 확인하고 장안소에서 대기한다. 매표마감 후 유도마에 기승하여 출주 마필과 기수를 유도하여 출주인사를 시킨다. 별도로 유도 요청을 한 마필은 직접 발주지점까지 유도한다. 경기 후 검량을 실시하기 위하여 경주가 끝난 기수와 마필을 검량위원에게 인도한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실외","physicalAct":"균형감각|","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"관련없음","dJobECd":"4202","dJobECdNm":"[4202]직업 운동선수","dJobJCd":"2862","dJobJCdNm":"[2862]직업 운동선수","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002072:1', '{"dJobCd":"K000002072","dJobCdSeq":"1","dJobNm":"자동차경주선수","workSum":"레이싱팀에 소속되어 각종 자동차 경주대회(GT, 투어링A·B, F1800 등)에서 경주용 차량을 운전하여 경주를 한다.","doWork":"경주장의 상태와 상대팀의 전력 등의 자료를 수집하고 분석한다. 운동을 통해 지구력과 근력을 키우고 체력을 유지한다. 시합에 대비하여 팀원들(미케닉(레이싱전문차량정비원), 스태프, 팀장 등)과 일정에 맞추어 주행연습을 한다. 시합 전 차량테스트를 받고 시험 주행을 한다. 차에 이상이 있을 시 미케닉에게 의뢰한다. 출발 전 그리드로 이동하고 신호와 함께 출발한다. 다른 팀 선수들과 트랙에서 경주를 한다. 시합이 끝난 후 인터뷰를 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실외","workEnv":"위험내재|고온|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","similarNm":"카레이서, 드라이버","dJobECd":"4202","dJobECdNm":"[4202]직업 운동선수","dJobJCd":"2862","dJobJCdNm":"[2862]직업 운동선수","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005345:1', '{"dJobCd":"K000005345","dJobCdSeq":"1","dJobNm":"직업경주선수(일반)","workSum":"경마, 경륜 및 경정 등 경주에서 마필, 경주용 자전거 및 경주용 보트를 타고 시합에 출전한다.","doWork":"경마, 경륜 및 경정의 규정 및 기술을 습득하기 위해 개인 또는 단체로 훈련에 참가한다. 마필의 특성을 파악하고 관리하거나 자전거 및 모터보트 정비기술 등을 습득한다. 출발 및 경기과정을 익힐 수 있도록 훈련한다. 경마, 경륜 및 경정 시합에 출전한다. 경기력을 증진시키기 위해 경주결과를 분석하고 문제점을 파악하여 교정한다. 새로운 기술을 습득한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"오락제공","workFunc3":"조작운전","connectJob":"경마기수, 경륜선수, 경정선수, 자동차경주선수","certLic":"경주선수","dJobECd":"4202","dJobECdNm":"[4202]직업 운동선수","dJobJCd":"2862","dJobJCdNm":"[2862]직업 운동선수","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005207:1', '{"dJobCd":"K000005207","dJobCdSeq":"1","dJobNm":"직업운동선수(일반)","workSum":"대중에게 즐거움을 제공하기 위하여 축구, 야구, 골프, 수영 등 경기에 참가한다.","doWork":"체력을 향상시키고 운동기술을 습득하기 위하여 운동선수트레이너 또는 코치의 지도에 따라 연습한다. 경기규칙을 습득하고 개인훈련을 실시한다. 운동감독 및 코치와 상대팀 또는 상대선수의 전력 및 기술을 분석하고 그에 따른 경기작전을 수립한다. 운동경기에 참가하여 심판의 규제 및 운동감독이나 코치의 지시에 따라 경기를 진행한다. 녹화된 화면으로 경기를 분석하여 취약한 부분을 훈련한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|청각|손사용|시각|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"오락제공","workFunc3":"정밀작업","similarNm":"운동선수","connectJob":"계약형태에 따라 프로선수, 실업선수/검도선수, 골프선수, 근대5종선수, 농구선수, 당구선수, 럭비선수, 레슬링선수, 루지선수, 봅슬레이선수, 스켈레톤선수, 바이애슬론선수, 배구선수, 배드민턴선수, 보디빌딩선수, 복싱선수, 볼링선수, 빙상선수, 사격선수, 사이클선수, 산악선수, 세팍타크로선수, 소프트볼선수, 수상스키선수, 수영선수, 수중선수, 스쿼시선수, 스키선수, 승마선수, 씨름선수, 아이스하키선수, 야구선수, 양궁선수, 역도선수, 요트선수, 우슈선수, 유도선수, 육상선수, 인라인롤러선수, 정구선수, 조정선수, 체조선수, 축구선수, 카누선수, 컬링선수, 탁구선수, 태권도선수, 테니스선수, 트라이애슬론선수, 펜싱선수, 하키선수, 핸드볼선수, 공수도선수, 댄스스포츠선수, 택견선수, 피겨스케이팅선수, 종합격투기선수","certLic":"전문스포츠지도사 1급, 전문스포츠지도사 2급","dJobECd":"4202","dJobECdNm":"[4202]직업 운동선수","dJobJCd":"2862","dJobJCdNm":"[2862]직업 운동선수","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007507:1', '{"dJobCd":"K000007507","dJobCdSeq":"1","dJobNm":"프로게이머","workSum":"입상과 소속회사의 홍보를 위해 컴퓨터게임 대회에 참가하여 경기를 한다.","doWork":"게임감독, 팀원들과 함께 전략을 짜고 기술을 익히며 대회를 위해 같은 팀이나 타 소속팀의 프로게이머들과 연습한다. 전략시뮬레이션, 롤플레잉, 1인칭 액션게임, 온라인게임 등의 컴퓨터게임에 대한 기술 및 전략을 익히고 연습한다. 각종 컴퓨터게임대회에 참가하여 경기를 한다. 소속회사에서 개발한 게임소프트웨어에 대한 베타테스트를 한다. 게임소프트웨어의 출시에 따른 시연회 및 홍보를 한다. 게임방송에 출연하여 게임을 하거나 게임해설을 한다. 각종 이벤트에 참가하여 일반인들과 게임을 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"분석","workFunc2":"오락제공","workFunc3":"정밀작업","dJobECd":"4202","dJobECdNm":"[4202]직업 운동선수","dJobJCd":"2862","dJobJCdNm":"[2862]직업 운동선수","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001666:1', '{"dJobCd":"K000001666","dJobCdSeq":"1","dJobNm":"프로바둑기사","workSum":"직업적으로 각종 바둑대회에 참가하여 경기를 한다.","doWork":"언론사, 기업체 등에서 주최, 후원하는 기전에서 상대 프로바둑기사와 대국을 한다. 명국이나 기타 실전 대국을 복기하며 변화를 검토하여 패착과 승부처를 분석하고 신수를 연구한다. 바둑 전문 잡지, 교재 등에 게재되는 원고를 작성하기도 한다. 바둑 대국 방송에 출연하여 시청자들에게 대국을 해설하기도 한다. 바둑교실을 운영하여 수강생을 지도하고, 지도대국을 갖기도 한다. 개인적으로 문하생을 선발하여 지도하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"분석","workFunc2":"오락제공","workFunc3":"관련없음","similarNm":"전문바둑기사","dJobECd":"4202","dJobECdNm":"[4202]직업 운동선수","dJobJCd":"2862","dJobJCdNm":"[2862]직업 운동선수","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005370:1', '{"dJobCd":"K000005370","dJobCdSeq":"1","dJobNm":"경기기록분석원","workSum":"선수와 팀의 경기 자료를 수집, 관찰, 기록, 분석 및 평가하여 이용자의 목적에 맞게 서비스를 제공한다.","doWork":"경기를 하는 선수, 팀, 경기와 관련된 영상이나 자료를 경기기록지, 경기전산프로그램 등 지정된 기록체계에 따라 기록하고 정보화한다. 촬영장비를 사용하여 경기를 촬영한다. 촬영한 자료를 검증하여 데이터를 추출하고 해석·분류한다. 선수의 특이점, 팀 내 기여 정도, 선수의 기술 및 자세, 상대 선수 팀의 성향, 심판의 판정 동향 등을 분석한다. 경기분석 자료를 선수의 훈련계획, 경기 전략·전술, 스포츠 프로그램, 데이터베이스, 스포츠마케팅 등에 활용되도록 제공한다. 경기분석 자료를 유형별로 분류하여 데이터베이스화하고 관리·운용한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"4203","dJobECdNm":"[4203]경기 심판 및 경기 기록원","dJobJCd":"2863","dJobJCdNm":"[2863]경기 심판 및 경기 기록원","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004697:1', '{"dJobCd":"K000004697","dJobCdSeq":"1","dJobNm":"경륜자전거검차위원","workSum":"경기 전·후에 경주용 자전거가 경륜 경주에 적합한지 여부를 검사하고 판정한다.","doWork":"검사장비를 이용하여 경주에서 사용될 자전거의 가력검사, 회전검사, 조임검사, 시각검사 등 전일확정검사를 시행한다. 조건에 부합하지 않으면 부품교체 등의 조치를 지시한다. 확정검사 시 차체, 번호, 색상, 부품, 기어 등의 자전거 검사표를 작성한다. 검사의 결과를 관계위원에게 통보한다. 경주 직전에 육안으로 자전거를 최종 검사한다. 경주 후에 출주후확정검사를 시행하여 자전거의 상태를 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"웅크림|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"경주심판","dJobECd":"4203","dJobECdNm":"[4203]경기 심판 및 경기 기록원","dJobJCd":"2863","dJobJCdNm":"[2863]경기 심판 및 경기 기록원","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006148:1', '{"dJobCd":"K000006148","dJobCdSeq":"1","dJobNm":"경륜종합심판원","workSum":"결승선에 도착한 경륜선수의 도착시간을 측정하여 순위를 결정한다.","doWork":"경주에 참가하는 경륜선수의 출전 여부를 확인하고 출발을 통보한다. 심판실에 설치되어 있는 모니터를 통해 경주 및 경륜선수들의 반칙행위를 관찰한다. 녹화된 테이프를 계속 확인하고, 고속카메라로 찍힌 사진 등을 이용하여 순위를 결정한다. 경륜선수가 위반행위를 한 경우 심의를 거쳐 도착 순위를 판정한다. 경주의 진행업무를 총괄한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","certLic":"경주심판","dJobECd":"4203","dJobECdNm":"[4203]경기 심판 및 경기 기록원","dJobJCd":"2863","dJobJCdNm":"[2863]경기 심판 및 경기 기록원","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004301:1', '{"dJobCd":"K000004301","dJobCdSeq":"1","dJobNm":"경륜주로심판원","workSum":"경륜 경주 시 경주 시작을 알리고 선수의 위반행위를 감시한다.","doWork":"시합 전 경륜선수에게 유의사항을 전달하고 출발준비를 확인한다. 경륜종합심판원의 신호에 따라 출발기를 조작하여 경륜선수를 출발시킨다. 경륜선수들의 경륜장 주회수를 확인하며 주회판을 돌리고 통고한다. 마지막 주회를 타종으로 통보한다. 경주 중의 선수들의 위반행위를 감시하여 경륜종합심판원에게 알린다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실외","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","certLic":"경주심판","dJobECd":"4203","dJobECdNm":"[4203]경기 심판 및 경기 기록원","dJobJCd":"2863","dJobJCdNm":"[2863]경기 심판 및 경기 기록원","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006377:1', '{"dJobCd":"K000006377","dJobCdSeq":"1","dJobNm":"경마검량원","workSum":"경주 전·후에 출주마가 부담해야 할 경마기수의 체중과 기승장구의 무게를 계량한다.","doWork":"경주 전 부담중량이 결정된 후 정해진 중량을 맞추기 위해 경마기수들의 체중을 계량한다. 경주에 출주하는 말이 기본적으로 지니고 달려야 할 부담중량을 확인한다. 웨이트패드, 안장 및 복대 등 장구의 중량을 계산한다. 경주 후 일정 순위 안에 든 기수의 체중 및 장구의 중량을 계량하여 경주 전의 중량과 일치하는지 확인한다. 검량 시 이상이 있으면 재결위원에게 통보한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"계산","workFunc2":"말하기신호","workFunc3":"단순작업","dJobECd":"4203","dJobECdNm":"[4203]경기 심판 및 경기 기록원","dJobJCd":"2863","dJobJCdNm":"[2863]경기 심판 및 경기 기록원","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005709:1', '{"dJobCd":"K000005709","dJobCdSeq":"1","dJobNm":"경마발주위원","workSum":"말의 발주기 입장순서를 결정하고 출발위치로 말을 몰아가도록 발주보조원 및 경마기수에게 지시한다.","doWork":"발주신호에 따라 청색기를 사용해 발주를 준비시킨다. 작성된 경주마의 특성 및 성격 등을 파악한다. 말의 특성에 따라 로프, 눈가리개 등 보조도구를 사용하여 말이 발주기에 진입하도록 발주보조원에게 지시한다. 마번순대로 마필을 진입 및 배열시키도록 지시한다. 발주 준비가 완료되면 발주기가 열리도록 발주 스위치를 조작한다. 출발 문제 발생 시 경주의 불성립을 알리고, 재결위원에게 통보하여 재발주시킨다. 경주에 적합하지 않고 발주 문제가 있는 마필의 재검조치를 결정한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"수동조작","dJobECd":"4203","dJobECdNm":"[4203]경기 심판 및 경기 기록원","dJobJCd":"2863","dJobJCdNm":"[2863]경기 심판 및 경기 기록원","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005691:1', '{"dJobCd":"K000005691","dJobCdSeq":"1","dJobNm":"경마재결위원","workSum":"공정한 심판을 통해 경마경기의 착순을 확정 또는 변경하고, 경기규칙을 위반한 기수를 제재한다.","doWork":"망원경 및 경주가 녹화된 모니터로 경마경기를 관찰한다. 착순판정원이 전산으로 입력한 착순심판통지서를 보고 공정성 여부를 판단한다. 경주마 진행 방해 등 경기규칙 위반 여부를 확인하여 위반 내용에 따라 징계 또는 제재 조치를 결정한다. 사고 발생 시 기수들의 정황에 대한 설명 및 녹화필름의 정밀분석을 통해 원인을 규명하여 착순을 변경한다. 확정버튼을 눌러 고객들에게 경주 성립을 알린다. 재결제재의 기준을 정립하고 이의제기가 들어올 경우 관객을 설득한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","dJobECd":"4203","dJobECdNm":"[4203]경기 심판 및 경기 기록원","dJobJCd":"2863","dJobJCdNm":"[2863]경기 심판 및 경기 기록원","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004840:1', '{"dJobCd":"K000004840","dJobCdSeq":"1","dJobNm":"경마핸디캡전문위원","workSum":"경마경기의 박진감과 흥미 있는 경주를 위해 경주마의 능력을 고려하여 경주 시에 경주마가 지니고 달려야 할 부담중량을 부여한다.","doWork":"경주에 참가할 경주마가 접수되면 비슷한 능력을 갖추도록 접수된 말의 능력 서열에 따라 부담중량을 부여한다. 과거의 경주기록, 부담중량 극복 능력, 경주마 간의 상대성, 출주마의 성별·연령 등을 고려하여 부담중량을 부여한다. 경주마의 훈련모습, 실제 경주 및 녹화경주 등을 통해 경주마를 관찰하여 능력을 판단한다. 위원별 부담중량을 작성하여 협의한 후 확정된 부담중량을 공표한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"핸디캡중량작성원, 핸디캐퍼","dJobECd":"4203","dJobECdNm":"[4203]경기 심판 및 경기 기록원","dJobJCd":"2863","dJobJCdNm":"[2863]경기 심판 및 경기 기록원","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002226:1', '{"dJobCd":"K000002226","dJobCdSeq":"1","dJobNm":"경주편성원","workSum":"경륜 및 경정에 출주하는 선수를 선정하고 경주를 편성한다.","doWork":"경륜 및 경정선수들의 기량 및 전법, 특성, 경기성적, 훈련 및 기존의 경주내용 등을 파악하여 분석한다. 경주운영관리 관련 프로그램을 조작하여 기본적인 경주출주표를 작성한다. 각각의 기준에 적합하게 경주출주표를 조정한다. 출주 지역 및 경기일정 등을 배정하여 조를 편성한다. 경주에 대한 만족도를 파악하기 위하여 고객을 모니터링한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"4203","dJobECdNm":"[4203]경기 심판 및 경기 기록원","dJobJCd":"2863","dJobJCdNm":"[2863]경기 심판 및 경기 기록원","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004418:1', '{"dJobCd":"K000004418","dJobCdSeq":"1","dJobNm":"비디오분석관","workSum":"영상촬영 장비를 이용하여 선수들의 경기 및 훈련 모습을 촬영·편집·분석하여 감독이나 코칭스태프들에게 전달한다.","doWork":"경기장에 촬영장비를 설치해 해당 종목의 특성에 맞게 소속팀 또는 상대팀 선수들의 훈련 모습이나 경기 모습을 촬영한다. 촬영한 영상을 감독, 코칭에게 편집하여 전달한다. 축구의 경우, 포지션별(공격진, 미드필드진, 수비진 등), 상황별(공격, 수비, 세트플레이 등), 선수 개인별로 세분화해 영상자료를 편집한다. 감독이나 코칭스태프들이 분석한 영상자료를 보고 전술적 판단을 내릴 수 있도록 분석된 자료를 제공한다. 전술 분석 회의에 참석하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"언어력|시각|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"4203","dJobECdNm":"[4203]경기 심판 및 경기 기록원","dJobJCd":"2863","dJobJCdNm":"[2863]경기 심판 및 경기 기록원","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006950:1', '{"dJobCd":"K000006950","dJobCdSeq":"1","dJobNm":"스포츠애널리스트","workSum":"경기력 향상을 위해 각종 스포츠 경기의 모든 요소를 수치적 데이터로 기록하고 이를 분석하여 제공한다.","doWork":"스포츠 경기력, 건강 및 운동 정보, 스포츠 산업 시장 등 스포츠와 관련한 모든 현상을 분석한다. 종목에 따라 대형에 따른 공격 및 수미 패턴, 선수의 움직임, 세부 경지 전략 등 분석 대상이 되는 핵심 경기력 지표를 설정한다. 분석을 위한 분석기법 및 프로그램을 개발한다. 카메라를 통한 영상자료, GPS 기반 시스템 등을 통해 자료를 수집한다. 정량화된 자료를 분석프로그램을 통해 분석한다. 분석된 자료는 팀이나 선수들의 경기력 향상을 위한 정보, 팬이나 언론을 위한 공공정보 및스포츠 배팅 시장의 배팅 정보, 스포츠 산업시장에서의 의사결정 정보 등으로 제공한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"협의","workFunc3":"관련없음","similarNm":"스포츠기록분석관, 기록분석연구원","connectJob":"경기분석관, 전력분석관","dJobECd":"4203","dJobECdNm":"[4203]경기 심판 및 경기 기록원","dJobJCd":"2863","dJobJCdNm":"[2863]경기 심판 및 경기 기록원","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001665:1', '{"dJobCd":"K000001665","dJobCdSeq":"1","dJobNm":"심판","workSum":"각종 운동경기에서 규칙을 적용하여 경기를 진행한다.","doWork":"축구, 야구, 농구, 태권도 등의 각종 운동경기에 참여하여 경기상황을 파악한다. 경기 중 선수들의 동작을 관찰하여 규칙 위반을 찾아내어 벌칙을 적용한다. 경기의 흐름을 원활하게 진행하고 규칙에 따라 경기를 판정한다. 경기를 모니터링한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"시각|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"경기심판","connectJob":"축구심판, 농구심판, 배구심판, 야구심판, 씨름심판, 레슬링심판, 탁구심판, 테니스심판, 복싱심판, 하키심판, 핸드볼심판, 태권도심판","dJobECd":"4203","dJobECdNm":"[4203]경기 심판 및 경기 기록원","dJobJCd":"2863","dJobJCdNm":"[2863]경기 심판 및 경기 기록원","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002638:1', '{"dJobCd":"K000002638","dJobCdSeq":"1","dJobNm":"야구비디오판독관","workSum":"야구심판의 요청에 의해 인간의 눈으로 판단하기 어려운 순간을 카메라영상을 분석하여 판정한다.","doWork":"경기장에서 송신되는 비디오판독용 초고속카메라영상, 방송중계영상 등을 모니터한다. 경기 진행 중에 심판으로부터 비디오 판독을 요청받는다. 경기 장면을 여러 각도, 느린 화면, 확대 화면으로 반복 재생하여 홈런, 루상의 아웃과 세이프(포스아웃과 태그아웃 포함), 야수의 포구(노바운드와 원바운드 캐치 여부), 외야의 페어와 파울, 포수의 파울팁 포구(노바운드와 원바운드 캐치 여부), 몸에 맞는 공(사구) 등을 관찰한다. 복수의 판독관과 의견을 교환하고 판정을 결정한다. 판독결과를 경기장의 심판에게 전송한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"4203","dJobECdNm":"[4203]경기 심판 및 경기 기록원","dJobJCd":"2863","dJobJCdNm":"[2863]경기 심판 및 경기 기록원","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004764:1', '{"dJobCd":"K000004764","dJobCdSeq":"1","dJobNm":"운동경기기록원","workSum":"운동경기의 각종 상황을 기록하여 자료로 활용하도록 제공한다.","doWork":"운동감독으로부터 선수명단을 받는다. 기록실에서 경기를 지켜보며 심판의 판정, 선수의 개인별 기록, 득점시간 등을 기록한다. 기록상황을 전광판에 표시하거나 관중에게 알리기 위하여 경기장전광판조작원 또는 경기장아나운서에게 알린다. 육상, 축구, 농구, 야구, 수영 등 한 가지 종목을 전문으로 하여 운동선수와 팀의 기록을 분석·관리한다. 운동감독이 대응전략을 고안할 수 있도록 자료를 제공하기도 한다. 심판의 판정을 돕기 위하여 자료를 제시하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"야구기록원, 배구기록원, 농구기록원, 축구기록원","dJobECd":"4203","dJobECdNm":"[4203]경기 심판 및 경기 기록원","dJobJCd":"2863","dJobJCdNm":"[2863]경기 심판 및 경기 기록원","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002873:1', '{"dJobCd":"K000002873","dJobCdSeq":"1","dJobNm":"이스포츠심판","workSum":"e스포츠 경기에서 경기규칙을 적용하여 공정하게 경기를 진행한다.","doWork":"e스포츠 경기장 시설 및 환경을 점검하여 불공정한 요소를 배제한다. 정해진 규칙에 따라 경기를 진행한다. 경기를 판정하고 승패를 확정한다. 경기결과를 기록하고 전산에 입력한다. e스포츠 심판, 맵 제작자, 프로게임단, 협회 등 관계자와 협의하여 경기규정 및 제도를 제정 및 개정한다. 심판, 경기진행자, 선수에게 경기규칙 및 주의사항을 교육한다. 프로게이머의 자격을 관리하고 결격사유 등을 처리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"수집","workFunc2":"감독","workFunc3":"관련없음","dJobECd":"4203","dJobECdNm":"[4203]경기 심판 및 경기 기록원","dJobJCd":"2863","dJobJCdNm":"[2863]경기 심판 및 경기 기록원","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004130:1', '{"dJobCd":"K000004130","dJobCdSeq":"1","dJobNm":"착순심판보조원","workSum":"착순심판위원의 지시를 받아 경주의 착순, 착차 등을 전광게시판에 기록한다.","doWork":"단말기를 이용하여 경주진행 중의 마필의 중간순위와 결승선 도착마의 착차, 착순, 경주기록 등을 전광게시판에 기록한다. 착순심판위원이 작성한 착순심판통지서를 재결실에 전달한다. 육안으로 착순을 판정하기 곤란한 경우와 관객이 착순에 대하여 이의를 제기한 경주의 결승선 통과 순간을 찍은 사진 및 영상을 관객이 볼 수 있도록 안내판에 게시하거나 전광게시판을 통해 재생한다. 착순, 착차, 경주기록 등 제반 기록을 작성하여 유지·보관한다. 기타 착순심판위원이 지시하는 업무를 수행한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"시범후 30일 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"기록","workFunc2":"말하기신호","workFunc3":"관련없음","certLic":"경주심판","dJobECd":"4203","dJobECdNm":"[4203]경기 심판 및 경기 기록원","dJobJCd":"2863","dJobJCdNm":"[2863]경기 심판 및 경기 기록원","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004102:1', '{"dJobCd":"K000004102","dJobCdSeq":"1","dJobNm":"착순판정원","workSum":"경마에서 결승선 도착 마필의 순위 및 도착시간을 측정·기록하여 재결위원에게 통보한다.","doWork":"경주가 시작되면 출발신호를 보고 기록계를 작동시킨다. 보다 정확한 시간 측정을 위해 망원경이나 육안으로 경주를 관찰한다. 경주마가 결승선을 통과한 후 육안 및 디지털 착순판정카메라로 촬영한 사진을 판독하고 착순 및 착차를 심의 판정한다. 경주 중간순위, 착순(경주마의 순위), 착차(순위별 도착차이), 경주기록 등을 착순게시판에 게시한다. 마필의 도착순위, 경마기록 등을 착순심판통지서에 기록하고 재결위원에게 통지한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"시각|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","certLic":"경주심판","dJobECd":"4203","dJobECdNm":"[4203]경기 심판 및 경기 기록원","dJobJCd":"2863","dJobJCdNm":"[2863]경기 심판 및 경기 기록원","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006987:1', '{"dJobCd":"K000006987","dJobCdSeq":"1","dJobNm":"골프피터","workSum":"고객의 신체, 골프스윙분석 결과 등을 고려하여 클럽, 우드, 아이언 등 골프채를 추천하거나 개인에 맞춰 맞춤형 제품을 제작하거나 수리한다.","doWork":"스윙 분석장비를 통해 고객의 강도, 거리, 방향, 스윙 스피드, 정확성 등을 파악한다. 고객의 키, 팔다리 길이 등 신체특징과 파악한 고객의 스윙분석내용을 분석하여 골프채의 무게 및 길이를 진단한다. 골프채표준품의 헤드, 샤프트, 그립 등의 무게와 길이를 조절하여 무게중심을 맞춰 고객의 스윙에 어울리도록 제작하고 조립한다. 기존 고객이 사용하던 골프채를 분해하여 고객 맞춤형 제품을 제작하거나 수리하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"골프피팅전문가","dJobECd":"4204","dJobECdNm":"[4204]스포츠강사, 레크리에이션강사 및 기타 관련 전문가","dJobJCd":"2869","dJobJCdNm":"[2869]기타 스포츠 및 레크리에이션 관련 전문가","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003789:1', '{"dJobCd":"K000003789","dJobCdSeq":"1","dJobNm":"등산강사","workSum":"등산교육기관에서 산을 오르는 기술과 장비의 사용법, 등산안전 대책 등을 교육한다.","doWork":"교육반을 편성하고 관리한다. 교육교재와 실습용 장비를 관리한다. 교육일정에 따라 일반등산이론(체온보전, 에너지관리, 걷기, 입기, 먹기, 스틱사용법, 장비사용법 등), 국내외 등산의 역사, 독도법, 등산계획, 등산기록, 응급처치, 해외등반, 알피니즘, 산악문학, 산악사진, 암벽등반기술, 확보물설치기술, 짐꾸리기, 매듭법 등 다양한 등산이론을 교육한다. 산악현장에서 수강생들과 함께 보행기술, 독도법, 암벽등반, 빙벽등반, 설상등반, 야영 등 실습교육을 진행한다. 교육 중 부상 및 사고를 예방하고 안전을 관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|청각|손사용|언어력|시각|","workFunc1":"분석","workFunc2":"교육","workFunc3":"수동조작","dJobECd":"4204","dJobECdNm":"[4204]스포츠강사, 레크리에이션강사 및 기타 관련 전문가","dJobJCd":"2869","dJobJCdNm":"[2869]기타 스포츠 및 레크리에이션 관련 전문가","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003423:1', '{"dJobCd":"K000003423","dJobCdSeq":"1","dJobNm":"레크리에이션진행자","workSum":"모임 및 행사에서 오락프로그램을 계획하고 진행한다.","doWork":"기업체, 학교, 복지기관 등 레크리에이션 진행을 의뢰하는 단체와 협의하여 진행을 위한 계획표를 작성한다. 모임의 성격, 장소, 시간, 인원수, 남녀비율 등을 파악하여 프로그램을 계획한다. 오락프로그램의 사회를 보며 노래, 율동, 게임 등을 진행한다. 진행 관련 종사원의 업무를 할당하여 지시한다. 새로운 레크리에이션 프로그램을 개발하고 응용계획을 수립한다. 레크리에이션진행자가 되고자 하는 훈련생을 지도·교육한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"언어력|","workFunc1":"수집","workFunc2":"오락제공","workFunc3":"관련없음","similarNm":"레크리에이션지도자, 레크리에이션강사","dJobECd":"4204","dJobECdNm":"[4204]스포츠강사, 레크리에이션강사 및 기타 관련 전문가","dJobJCd":"2869","dJobJCdNm":"[2869]기타 스포츠 및 레크리에이션 관련 전문가","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006011:1', '{"dJobCd":"K000006011","dJobCdSeq":"1","dJobNm":"로프강사","workSum":"빌딩관리, 건설현장, 교량작업, 선박건조, 수목관리, 구조작업, 군, 경찰 등에서 로프를 사용하는 고소작업자에게 로프 관련 기술, 장비사용법 등을 교육한다.","doWork":"교육교재, 실습교재 및 장비, 실습장을 활용하여 산업용 고소작업 및 인명구조용 장비의 사용법과 응용방법을 설명한다. 추락방지, 추락계수 및 이격거리, 작업위치 확보, 로프 및 확보물 설치, 하강, 수직작업 시 위치 확보, 등/하강, 등/하강운반, 수목작업, 철탑구조물에서 등/하강, 철근배근 및 경사지붕 작업, 구조, 부상자 운반, 자가구조, 하향대피, 상향대피, 로프를 이용한 횡단 대피 방법 등 다양한 응용상황을 직접 시연하며 교육한다. 실습을 진행하며 숙달되도록 지도한다. 교육 중 부상 및 사고를 예방하고 안전을 관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"교육","workFunc3":"수동조작","similarNm":"로프액세스강사, Rope Access","dJobECd":"4204","dJobECdNm":"[4204]스포츠강사, 레크리에이션강사 및 기타 관련 전문가","dJobJCd":"2869","dJobJCdNm":"[2869]기타 스포츠 및 레크리에이션 관련 전문가","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003425:1', '{"dJobCd":"K000003425","dJobCdSeq":"1","dJobNm":"스포츠클라이밍강사","workSum":"실내외 인공암벽등반 시설에서 수강생에게 스포츠클라이밍(Sports Climbing)을 교육한다.","doWork":"스포츠클라이밍 교육반을 편성하고 교육프로그램을 운영한다. 인공암벽등반시설(산악 등지에서 경험할 수 있는 암벽을 인공구조물을 이용해 실내외에 설치한 시설물)을 관리하고 확보물, 홀드, 볼트, 매트 등 안전사항을 점검한다. 수강생에게 확보기술(로프를 함께 묶고 등반하는 사람이 추락했을 때 추락을 막기 위한 로프 조작 기술), 매듭법, 손과 발의 사용, 자세와 동작, 몸의 균형, 근력 및 지구력, 난이도 등을 훈련·지도한다. 난이도 경기, 속도 경기, 볼더링 경기 등 스포츠클라이밍 대회 규정에 따라 훈련하기도 한다. 홀드의 종류와 위치, 벽의 경사면을 활용해서 난이도를 개발하고 조정한다. 교육 중 부상 및 사고를 예방하고 안전을 관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|손사용|언어력|시각|","workFunc1":"분석","workFunc2":"교육","workFunc3":"수동조작","similarNm":"인공암장강사, 인공암벽강사, 스포츠클라이밍짐강사","dJobECd":"4204","dJobECdNm":"[4204]스포츠강사, 레크리에이션강사 및 기타 관련 전문가","dJobJCd":"2869","dJobJCdNm":"[2869]기타 스포츠 및 레크리에이션 관련 전문가","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001927:1', '{"dJobCd":"K000001927","dJobCdSeq":"1","dJobNm":"승마교관","workSum":"승마경기에 참가하는 승마선수를 대상으로 경기기술을 지도하거나 레저로 승마를 배우는 강습생을 교육한다.","doWork":"마장마술, 장애물비월경기, 크로스컨트리, 종합마술 등의 경기에 참가하는 승마선수를 지도한다. 승마강습 계획을 수립하여 일반인의 여가선용을 위한 레저승마의 이론 및 실습, 마필관리법을 가르친다. 승마선수 및 강습생을 평가 및 관리한다. 승마용 말을 조련한다. 마필의 이상징후가 파악될 경우 마필관리원에게 말을 돌보도록 지시한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","connectJob":"경마기수를 대상으로 교육하는 경우 경마교관","certLic":"경기지도사, 생활체육지도사(1급, 2급, 3급)","dJobECd":"4204","dJobECdNm":"[4204]스포츠강사, 레크리에이션강사 및 기타 관련 전문가","dJobJCd":"2869","dJobJCdNm":"[2869]기타 스포츠 및 레크리에이션 관련 전문가","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001262:1', '{"dJobCd":"K000001262","dJobCdSeq":"1","dJobNm":"운동선수트레이너","workSum":"아마추어운동선수나 직업운동선수들에게 각종 경기에서 최상의 운동능력을 발휘하도록 신체상태를 점검하고 트레이닝을 시킨다.","doWork":"운동감독이나 운동선수코치와 협의하여 종목, 포지션, 선수 개인에 따라 필요한 근육을 단련시키고 규칙적 운동이나 교정운동을 지시한다. 체력을 증진시키거나 체중을 조절하도록 식이요법을 권고한다. 상처의 통증, 근육긴장 등을 풀어주기 위하여 선수들의 몸을 손으로 주무르거나 두드린다. 선수 부상 시 의사에게 치료를 의뢰하고 진단결과에 따라 재활훈련을 계획·실시한다. 훈련 프로그램의 진행상황을 점검한다. 치료를 돕기 위하여 부상선수에게 냉온요법, 상처의 소독, 붕대를 감아주는 일과 같은 응급치료를 한다. 열치료나 전기치료를 하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","similarNm":"스포츠트레이너, 트레이너(Trainer), AT","certLic":"건강운동관리사","dJobECd":"4204","dJobECdNm":"[4204]스포츠강사, 레크리에이션강사 및 기타 관련 전문가","dJobJCd":"2869","dJobJCdNm":"[2869]기타 스포츠 및 레크리에이션 관련 전문가","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001922:1', '{"dJobCd":"K000001922","dJobCdSeq":"1","dJobNm":"웃음지도사","workSum":"일반인을 포함하여 환자들이 웃음을 통해 심신의 건강을 유지하고 병환에서 회복하도록 웃음 프로그램을 개발, 운영하고 교육한다.","doWork":"취업, 회사 내 스트레스, 다양한 대인관계에서 오는 불안과 갈등이 많은 사람에게 다양한 방법으로 웃음을 유도한다. 웃음을 통해 자신감과 긍정적인 마음가짐을 가지도록 도와준다. 마음을 건강하고 즐겁게 만들며 더불어 몸이 건강해지도록 돕는다. 웃음지도를 위한 각종 교육콘텐츠를 개발한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"수집","workFunc2":"오락제공","workFunc3":"관련없음","dJobECd":"4204","dJobECdNm":"[4204]스포츠강사, 레크리에이션강사 및 기타 관련 전문가","dJobJCd":"2869","dJobJCdNm":"[2869]기타 스포츠 및 레크리에이션 관련 전문가","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007065:1', '{"dJobCd":"K000007065","dJobCdSeq":"1","dJobNm":"인공암벽시설관리자","workSum":"인공암벽시설(실내외에 인공으로 만들어진 암벽 구조물)을 운영·관리한다.","doWork":"인공암벽시설의 운영시간을 관리하고 무단사용을 금지한다. 등반자가 안전장비(안전벨트, 로프, 퀵드로우, 암벽화, 확보기 등)를 바르게 착용 및 사용하는지 확인하고 필요시 지도한다. 확보자 없이 등반하거나, 하나의 루트에 다수의 등반자가 등반하는 등 위험한 활동을 하는 경우 안전등반을 지도한다. 홀드 및 확보물의 노후, 탈락, 손상을 점검하고 필요시 렌치를 이용하여 교체한다. 새로운 루트를 세팅하기도 한다. 시설의 환경(청소, 안전바닥 관리, 부정적치물 등 위험요소 배제 등)을 관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"단순작업","connectJob":"인공암벽안전관리자","dJobECd":"4204","dJobECdNm":"[4204]스포츠강사, 레크리에이션강사 및 기타 관련 전문가","dJobJCd":"2869","dJobJCdNm":"[2869]기타 스포츠 및 레크리에이션 관련 전문가","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002983:1', '{"dJobCd":"K000002983","dJobCdSeq":"1","dJobNm":"재활승마지도사","workSum":"신체적, 정신적 장애를 가진 사람을 대상으로 말을 활용한 활동을 지도하기 위해 재활승마의 계획, 운영, 관리, 평가 등을 수행한다.","doWork":"재활승마를 위한 운영 계획을 수립하고 대회협력을 추진하며 시행한다. 강습계획을 수립하고 준비하며 시행하고 평가한다. 재활승마 대상자를 평가하고 선정하며 일정 및 기록을 관리한다. 말의 선정부터 사양관리, 말 질병 및 예방 및 응급조치, 훈련관리, 마구관리 등을 수행한다. 자원봉사자를 모집, 교육, 운영하고 관리한다. 강습장, 방목장, 마사, 편의시설 등의 안전을 점검한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"손사용|","workFunc1":"분석","workFunc2":"교육","workFunc3":"수동조작","certLic":"재활승마지도사","dJobECd":"4204","dJobECdNm":"[4204]스포츠강사, 레크리에이션강사 및 기타 관련 전문가","dJobJCd":"2869","dJobJCdNm":"[2869]기타 스포츠 및 레크리에이션 관련 전문가","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007028:1', '{"dJobCd":"K000007028","dJobCdSeq":"1","dJobNm":"조교사","workSum":"경주를 할 수 있도록 경주마를 훈련시키고 마필의 경주능력을 향상시킬 수 있도록 사육·관리한다.","doWork":"준비운동, 보, 구보, 습보, 조교운동과 연습시합을 통하여 경주용 말이 되도록 훈련시킨다. 정상적인 발주와 경기과정을 익힐 수 있도록 경마장에서 훈련시킨다. 경주에서 탈 말을 다루는 방법을 기수에게 가르친다. 질병을 사전에 예방하기 위하여 말을 수시로 관찰하고, 전염병 예방접종과 구충제 투약이 필요하다고 판단되는 말은 보건소에 의뢰하여 수의위원의 지시에 따라 조치를 한다. 장제실에 의뢰하여 관리 마필의 장제를 실시하거나 사료, 밥통, 안장, 재킹 등의 용구를 관리한다. 마사 시설물을 효율적으로 관리하기 위하여 기수와 마필관리사를 지휘·감독한다. 출주할 마필과 기수를 경주별로 경마 시행처에 출주신청을 하며 출주를 준비한다. 출주할 마필과 기수를 점검하여 경주 후에는 마필의 이상 유무를 확인한다. 기수로 선발된 사람에게 이론교육 및 승마기술(기본마술)과 경주마술을 교육하여 기수면허를 획득할 수 있도록 교육하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","connectJob":"기수들을 대상으로 교육하는 경우 기수교관, 기수양성교관","dJobECd":"4204","dJobECdNm":"[4204]스포츠강사, 레크리에이션강사 및 기타 관련 전문가","dJobJCd":"2869","dJobJCdNm":"[2869]기타 스포츠 및 레크리에이션 관련 전문가","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002350:1', '{"dJobCd":"K000002350","dJobCdSeq":"1","dJobNm":"체육학원강사","workSum":"개인 또는 단체를 대상으로 건강유지 및 기분전환, 육체기능 강화, 힘의 증진 등을 위한 각종 운동 종목의 운동방법을 전문적으로 지도한다.","doWork":"수강생의 능력 및 수준을 평가하고 이에 따라 등급을 결정한다. 각 등급 또는 수준별로 학습 및 훈련 프로그램을 짜고 지도계획을 세운다. 안전수칙을 주지시키고, 기본자세 및 실기를 시범하여 실습·지도한다. 근육을 단련시키고 규칙적 운동이나 교정운동을 지시한다. 경기력 및 건강 향상 여부 등을 평가한다. 출석부 및 시간표를 작성하고 관리한다. 운동기구, 비품 등을 정리·관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|손사용|언어력|","workEnv":"소음·진동|","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","similarNm":"스포츠센터강사, 생활체육지도사, 스포츠강사, 스포츠지도자","connectJob":"탁구강사, 체조강사, 수영강사, 스키강사, 요트강사, 볼링강사, 골프강사, 산악강사, 행글라이딩강사, 윈드서핑강사, 빙상강사, 테니스강사, 라켓볼강사, 복싱강사, 유도강사, 검도강사, 태권도강사, 우슈강사, 보디빌딩강사, 에어로빅강사, 합기도강사, 요가강사(요가지도자), 국술강사, 궁중무술강사, 국선도강사, 킥복싱강사, 스포츠댄스강사, 태보강사, 암벽등반강사, 명상지도사","certLic":"생활스포츠지도사(1급, 2급), 장애인스포츠지도사(1급, 2급), 유소년 스포츠지도사, 노인스포츠지도사","dJobECd":"4204","dJobECdNm":"[4204]스포츠강사, 레크리에이션강사 및 기타 관련 전문가","dJobJCd":"2869","dJobJCdNm":"[2869]기타 스포츠 및 레크리에이션 관련 전문가","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004828:1', '{"dJobCd":"K000004828","dJobCdSeq":"1","dJobNm":"필라테스강사","workSum":"필라테스(Pilates) 교육프로그램을 운영하며 강습생을 지도한다.","doWork":"강습생과 상담하여 운동목표, 통증부위, 기초신체지수 등을 파악하고 적절한 운동 프로그램을 권유한다. 다양한 필라테스 교육프로그램을 개발하고 운영한다. 공, 체어, 아크, 롤러, 링, 탄성밴드, 덤밸 등 운동 도구를 활용하면서 각종 필라테스 동작을 시연한다. 호흡, 자세, 운동효과, 반복횟수 등을 설명한다. 강습생의 동작을 관찰하면서 운동을 지도한다. 주기적으로 운동성과를 평가하고 기록하여 운동목표를 달성하도록 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","similarNm":"필라테스지도사","dJobECd":"4204","dJobECdNm":"[4204]스포츠강사, 레크리에이션강사 및 기타 관련 전문가","dJobJCd":"2869","dJobJCdNm":"[2869]기타 스포츠 및 레크리에이션 관련 전문가","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005084:1', '{"dJobCd":"K000005084","dJobCdSeq":"1","dJobNm":"헬스트레이너","workSum":"헬스클럽 등에서 개인의 체력을 증진하고 신체를 단련하도록 지도한다.","doWork":"운동의학적 지식을 활용하여 개인 또는 단체의 운동을 지도한다. 개인의 신체적 특징, 환경, 운동목적을 파악하고 적절한 운동방법을 개발 및 지도한다. 각종 운동기구의 사용법을 시연하고 적절한 횟수, 무게, 자세, 순서 등에 대하여 지도한다. 각종 측정기구와 측정지표를 이용하여 운동성과를 평가하며 운동목표에 도달하도록 지속적인 관리를 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|손사용|언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","similarNm":"헬스코치, 웨이트트레이너","connectJob":"퍼스널트레이너","certLic":"생활체육지도사","dJobECd":"4204","dJobECdNm":"[4204]스포츠강사, 레크리에이션강사 및 기타 관련 전문가","dJobJCd":"2869","dJobJCdNm":"[2869]기타 스포츠 및 레크리에이션 관련 전문가","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004107:1', '{"dJobCd":"K000004107","dJobCdSeq":"1","dJobNm":"요리연구가","workSum":"새로운 음식과 새로운 메뉴를 연구·개발하여 보급하며 레스토랑 등 음식 관련 사업체를 대상으로 컨설팅 및 교육 등의 업무를 한다.","doWork":"음식을 소비하는 주 고객을 설정하고, 연령층, 소비성향, 지역적 특성 등을 분석하여 새로운 음식 또는 메뉴를 개발한다. 소비자의 기호에 맞춰 기존 음식과 메뉴를 개선한다. 한식, 전통음식, 전통 식재료, 궁중음식 등을 연구개발하고 표준화하여 국내외로 알린다. 새로운 메뉴 등을 조리사 및 일반인에게 보급하기 위하여 교육프로그램을 개발하고 교육을 진행한다. 방송 등에서 음식을 만드는 과정을 소개하는 쿠킹클래스를 진행한다. 레스토랑, 식품업체, 지자체식품부서 등을 대상으로 된장, 고추장 등 식재료를 활용한 새로운 음식을 개발하거나 개발을 위한 컨설팅을 한다. 전통음식이나 궁중음식 등 한식 세계화를 위해 정책적 조언 및 구현 등 정책적 지원하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|언어력|시각|","workEnv":"대기환경미흡|위험내재|고온|다습|","workFunc1":"종합","workFunc2":"자문","workFunc3":"정밀작업","certLic":"한식조리기능사, 양식조리기능사, 일식조리기능사, 중식조리기능사, 복어조리기능사, 한식조리산업기사, 양식조리산업기사, 일식조리산업기사, 중식조리산업기사, 복어조리산업기사 , 조리기능장","dJobECd":"5311","dJobECdNm":"[5311]주방장 및 요리 연구가","dJobJCd":"2870","dJobJCdNm":"[2870]주방장 및 요리 연구가","dJobICd":"M715","dJobICdNm":"[M715]회사 본부 및 경영 컨설팅 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005396:1', '{"dJobCd":"K000005396","dJobCdSeq":"1","dJobNm":"음식메뉴개발자","workSum":"건강, 위생, 맛 등을 고려하여 음식 메뉴를 기획·개발한다.","doWork":"음식을 소비하는 주 고객을 설정하고, 연령층, 소비성향, 지역적 특성 등을 분석한다. 동종업계 경쟁업체의 메뉴현황 및 실적을 분석한다. 사회적 트렌드나 사람들이 관심을 갖는 주제를 중심으로 음식을 분석한다. 고객의 건강, 음식의 질 등을 고려한 새로운 아이디어를 개발하여 음식메뉴를 기획한다. 재료의 영양과 맛을 살릴 수 있는 조리법을 개발하여 새로운 음식을 개발한다. 고객들의 평가를 통해 메뉴를 보완하고 조리 매뉴얼을 작성하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"대기환경미흡|위험내재|고온|다습|","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","certLic":"한식조리기능사, 한식조리산업기사, 양식조리기능사, 양식조리산업기사, 일식조리기능사, 일식조리산업기사,  중식조리기능사, 중식조리산업기사, 복어조리기능사, 복어조리산업기사, 조리기능장","dJobECd":"5311","dJobECdNm":"[5311]주방장 및 요리 연구가","dJobJCd":"2870","dJobJCdNm":"[2870]주방장 및 요리 연구가","dJobICd":"I561","dJobICdNm":"[I561]음식점업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007556:1', '{"dJobCd":"K000007556","dJobCdSeq":"1","dJobNm":"주방장","workSum":"음식점 및 사업체 식당의 주방에서 조리 및 음식 서비스를 총괄 관리한다.","doWork":"주방의 제반 시설물·기물을 유지관리하고 청결상태를 점검한다. 조리사의 요리·가공업무를 지시·감독한다. 조리사의 근무일정표 및 근무상황을 관리한다. 매월 실시되는 식자재 재고명세표를 검토·확인한다. 수시로 주방을 순시하여 기계류 및 제반 시설물의 이상 유무를 점검한다. 음식재료를 사용하는 기구 및 장소의 청결을 관리한다. 주방 및 냉장고에 보관된 모든 식재료의 상태와 부패 여부를 확인한다. 각 영업장 및 연회에 필요한 식자재를 관련 부서에 청구한다. 구매 수령된 모든 식자재의 수량 및 상태를 검수한다. 조리사들에게 메뉴의 해석·기술시범·식중독 예방 및 기본자세 등에 관하여 교육·훈련시킨다. 새로운 지식과 기능을 습득하게 되면 직원들에게 교육한다. 새로운 요리의 조리법에 대해 원가를 분석하고 가격을 산출하기도 한다. 출장연회 업무를 수행하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"대기환경미흡|위험내재|고온|다습|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"요리사, 쉐프, 셰프","connectJob":"종사하는 곳에 따라 선박조리장, 열차식당주방장","certLic":"한식조리산업기사, 양식조리산업기사, 일식조리산업기사, 중식조리산업기사, 복어조리산업기사, 한식조리기능사, 양식조리기능사, 일식조리기능사, 중식조리기능사, 복어조리기능사, 조리기능장","dJobECd":"5311","dJobECdNm":"[5311]주방장 및 요리 연구가","dJobJCd":"2870","dJobJCdNm":"[2870]주방장 및 요리 연구가","dJobICd":"I561","dJobICdNm":"[I561]음식점업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006326:1', '{"dJobCd":"K000006326","dJobCdSeq":"1","dJobNm":"총주방장","workSum":"호텔의 식당 조리부 업무와 주방을 총괄 관리하고, 조리사들을 지휘·감독한다.","doWork":"식재료비의 절감방안을 연구·개발한다. 일일 음식 준비, 일일 생산량 및 고객 주문 메뉴를 실행·관리한다. 업무개발을 위한 주방 환경개선 및 청결상태를 관리한다. 주방 식자재, 기물 및 주방 시설을 관리한다. 경쟁사에서 제공하는 음식 및 서비스 정보를 파악한다. 영업부서에 제공되는 음식의 질 및 생산량을 날마다 관리한다. 음식의 기준 관리 및 요리 기술을 개발한다. 주방의 위생 관리 및 식자재의 상태를 관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"10년 초과","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|고온|다습|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"쉐프","connectJob":"한식총주방장, 양식총주방장, 일식총주방장, 중식총주방장","certLic":"한식조리기능사, 양식조리기능사, 일식조리기능사, 중식조리기능사, 복어조리기능사, 한식조리산업기사, 양식조리산업기사, 일식조리산업기사, 중식조리산업기사, 복어조리산업기사, 조리기능장","dJobECd":"5311","dJobECdNm":"[5311]주방장 및 요리 연구가","dJobJCd":"2870","dJobJCdNm":"[2870]주방장 및 요리 연구가","dJobICd":"I561","dJobICdNm":"[I561]음식점업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003189:1', '{"dJobCd":"K000003189","dJobCdSeq":"1","dJobNm":"푸드스타일리스트","workSum":"실제 식사 또는 광고 촬영을 위해 음식이나 각종 식기를 배열하여 테이블 공간을 디자인하고 연출한다.","doWork":"국내외 요리, 식기, 소품, 인테리어 등의 관련 자료를 수집하고 분석한다. 요리의 특성과 의뢰자가 원하는 구성에 맞춰 테이블 공간을 연출한다. 음식 담당자가 조리한 요리의 특징을 고려하여 어울리는 그릇에 담는다. 테이블 주변에 어울리는 소품을 놓는다. 전체적인 세팅과 음식의 조화가 잘 이루어졌는지 확인한다. 영상물로 나오기 전 카메라에 담긴 구도를 사진작가 및 스태프들과 협의하고, 의도와 맞지 않을 경우 소품의 위치를 재배치한 후 촬영한다. 촬영이 끝난 후 소품을 정리·정돈한다. 외식업체에서 메뉴를 개발하거나, 메뉴에 어울리는 소품을 준비한다. 직접 구성에 알맞은 요리를 준비하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"수집","workFunc2":"협의","workFunc3":"수동조작","similarNm":"푸드코디네이터, 테이블코디네이터, 테이블아티스트, 테이블데코레이터","certLic":"조리사","dJobECd":"5311","dJobECdNm":"[5311]주방장 및 요리 연구가","dJobJCd":"2870","dJobJCdNm":"[2870]주방장 및 요리 연구가","dJobICd":"I561","dJobICdNm":"[I561]음식점업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006842:1', '{"dJobCd":"K000006842","dJobCdSeq":"1","dJobNm":"A&R기획자","workSum":"음반 제작에 있어 음악적 방향성을 확정하고 콘셉트에 맞는 곡을 찾고, 곡이 나오기까지 음반 및 아티스트 기획을 담당한다.","doWork":"소속 아티스트의 방향성에 부합하는 음악 콘셉트의 기획 및 레퍼토리를 발굴한다. 앨범 제작 예산을 수립하고 진행비용을 집행한다. 콘셉트에 맞는 곡을 수급하고 세션, 녹음실, 믹싱엔지니어 등을 섭외한다. 외부 아티스트, 프로듀서, 작곡·작사가 등을 발굴하고 관리한다. 음원제작, 발매일정을 관리한다. 콘서트 및 무대 관련 음악, 밴드 등 현장 음악 관련 제반 사항을 관리한다. 대외업체와  홍보·마케팅 프로모션 콘텐츠를 제작하고 진행한다. 음원을 관리하고 음원차트, 판매량, 시장 반응을 모니터링한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"청각|","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"음반PM, A&R전문가","connectJob":"음반제작프로듀서","dJobECd":"4171","dJobECdNm":"[4171]공연·영화 및 음반 기획자","dJobJCd":"2881","dJobJCdNm":"[2881]공연·영화 및 음반 기획자","dJobICd":"J592","dJobICdNm":"[J592]오디오물 출판 및 원판 녹음업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005907:1', '{"dJobCd":"K000005907","dJobCdSeq":"1","dJobNm":"공연기획자","workSum":"공연작품을 무대에 올리기 위해 작품 선정, 홍보, 마케팅, 공연결과 평가 등 제반 과정을 기획하고 추진한다.","doWork":"국내외 공연 시장동향, 대중의 기호 및 성향, 사회 트렌드 등을 조사하여 뮤지컬, 오페라, 연극, 콘서트 등 공연할 대본이나 음악을 개발한다. 외국 작품의 판권을 구입하거나 국내의 창작작품의 저작권 및 공연권을 구입하여 공연작품을 제작한다. 투자자와의 협의하에 공연일정 및 공연장소를 결정한다. 예산을 책정하며, 출연배우 및 제작인력을 섭외한다. 제작일정 및 진행사항에 대하여 제작진과 협의하고 총괄한다. 공연의 홍보 및 마케팅, 티켓판매, 관객개발 등과 관련된 업무를 담당한다. 외국공연팀(배우 및 제작인력)의 국내 공연을 기획하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"공연제작관리자","connectJob":"공연마케터, 페스티벌기획자, 연극공연기획자, 뮤지컬공연기획자","dJobECd":"4171","dJobECdNm":"[4171]공연·영화 및 음반 기획자","dJobJCd":"2881","dJobJCdNm":"[2881]공연·영화 및 음반 기획자","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005263:1', '{"dJobCd":"K000005263","dJobCdSeq":"1","dJobNm":"영화제프로그래머","workSum":"영화제의 방향설정, 출품작 선정, 각종 이벤트 계획 등 영화제 개최 전반에 대하여 총괄한다.","doWork":"영화제의 성격과 방향을 설정한다. 각종 영화 시사회, 영화제 등에 참석하여 상영 영화를 발굴한다. 출품작을 평가하여 영화제에 상영될 영화를 선정한다. 프로그램 선정, 일정관리, 홍보관리 등 영화제 개최 전반에 관한 업무를 총괄 계획 및 관리한다. 브로슈어, 설명집 등에 영화의 줄거리 및 평론을 쓴다. 영화제 관련 홍보물을 외부에 의뢰한다. 세미나, 강연, 이벤트, 감독과의 만남 등을 계획한다. 직접 관계자를 섭외하기도 한다. 관련 잡지 등에 고정 칼럼을 쓰기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"시각|","workFunc1":"분석","workFunc2":"협의","workFunc3":"관련없음","connectJob":"시사회기획자","dJobECd":"4171","dJobECdNm":"[4171]공연·영화 및 음반 기획자","dJobJCd":"2881","dJobJCdNm":"[2881]공연·영화 및 음반 기획자","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004680:1', '{"dJobCd":"K000004680","dJobCdSeq":"1","dJobNm":"영화프로듀서","workSum":"영화 제작부의 수장으로서 전체적인 예산을 기획하고 관리하며 주연배우 및 주요 스태프를 캐스팅하고 제작비를 집행한다.","doWork":"시나리오를 접수 및 선정하고 기획을 검토한다. 주연배우 및 감독, 제작 파트별 담당자를 캐스팅한다. 영화 프로젝트의 아웃라인을 작성하고 제작 포맷을 구상한다. 제작에 필요한 자금 조달 계획을 수립하고 전체 예산을 관리한다. 영화 제작 파트별로 사전 회의를 진행한다. 전체 제작공정을 검토하고 관리한다. 촬영에 사용되는 장비를 검토하고 구입 및 관리한다. 각종 계약을 체결하고 계약서를 관리한다. 제작발표회를 기획한다. 배우 및 스태프에 대한 보험에 가입한다. 감독, 스태프, 배우, 투자자 사이에서 의견을 조율하여 제작이 원활히 진행되도록 한다. 마케팅기획을 협의하여 영화의 흥행을 달성하기 위한 방안을 마련한다. 각종 소송 및 분쟁이 발생하면 해결을 위한 업무를 수행한다. 영화촬영이 끝나면 랩파티(촬영을 끝낸 뒤 하는 파티)를 진행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"언어력|시각|","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"필름프로듀서(Film Producer), 익스큐티브프로듀서(Executive Producer)","dJobECd":"4171","dJobECdNm":"[4171]공연·영화 및 음반 기획자","dJobJCd":"2881","dJobJCdNm":"[2881]공연·영화 및 음반 기획자","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005722:1', '{"dJobCd":"K000005722","dJobCdSeq":"1","dJobNm":"음반제작프로듀서","workSum":"음반을 제작하기 위한 프로그램을 기획·구성하는 제반 업무를 총괄 수행한다.","doWork":"예산과 지출, 시장성 등을 검토하여 음반제작을 위한 프로그램을 기획한다. 대중에게 인기 있는 음반을 제작하기 위하여 제작에 참여하는 작업자들의 활동을 조정한다. 기획된 프로그램에 맞는 대중가요가수를 선정한다. 선정된 대중가요가수에게 맞는 작사가, 작곡가 및 편곡가를 선정하여 노래의 가사, 곡 및 편곡을 의뢰하고 음악에 대한 논의를 한다. 준비된 작곡 및 편곡을 녹음하도록 녹음실의 음향녹음기술자에게 지시한다. 음향이 준비되면 대중가요가수에게 취입(레코드나 녹음기의 녹음판에 소리를 넣음)을 위한 연습을 의뢰하고 음높이, 밸런스 등을 최상이 되도록 감독하여 음원을 생성한다. 제작 음반에 대한 디자인 선정을 위하여 음반디자이너와 협의한다. 완성된 음반을 홍보하기 위한 방송국, 신문사, 잡지사와 같은 홍보매체에 인터뷰 등의 스케쥴을 조정한다. 각종 가요제, 방송드라마 등의 방송기획이 확정되면 방송연출가와 협의하여 음반출반에 관한 전반적인 사항을 기획·총괄하기도 한다. 작곡가와 저작원 계약을 하며 저작권협회에 관리 목록을 제출하고 방송 후에 방송횟수만큼의 저작권료를 방송사로부터 받아서 작곡가에게 사용료를 지불하는 등 저작권 관련 곡에 대한 관리 업무를 수행하는 종사원들을 감독·조정한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"청각|","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"음반기획가, 음반제작PD","dJobECd":"4171","dJobECdNm":"[4171]공연·영화 및 음반 기획자","dJobJCd":"2881","dJobJCdNm":"[2881]공연·영화 및 음반 기획자","dJobICd":"J592","dJobICdNm":"[J592]오디오물 출판 및 원판 녹음업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007032:1', '{"dJobCd":"K000007032","dJobCdSeq":"1","dJobNm":"MCN크리에이터커뮤니티매니저","workSum":"1인 창작자를 도와 채널에 동영상을 업로드하고 시청자와 소통한다.","doWork":"1인 창작자가 제작한 콘텐츠를 채널에 업로드한다. 콘텐츠의 제목, 미리보기, 헤시테그(Hashtag)를 입력한다. 시청자의 반응을 실시간으로 확인하고 댓글 등을 통해 시청자와 소통한다. 콘텐츠의 조회수, 공유수, 댓글수, 시청지속시간, 평균시청시간, 시청자 정보, 유입경로, 수익액 등을 확인하고 분석한다. 분석결과를 보고서로 작성하고 구독자 및 수익증가 방안을 모색하여 1인 창작자에게 제공한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"크리에이터채널매니저","dJobECd":"4172","dJobECdNm":"[4172]연예인매니저 및 스포츠매니저","dJobJCd":"2882","dJobJCdNm":"[2882]연예인 및 스포츠 매니저","dJobICd":"J639","dJobICdNm":"[J639]기타 정보 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006034:1', '{"dJobCd":"K000006034","dJobCdSeq":"1","dJobNm":"디지털인플루언서관리자","workSum":"파워블로거나 1인 방송 진행자 등의 인플루언서(Influencer)를 섭외하고 관리한다.","doWork":"화장품, 게임, 음식, 생활 소비용품, 여행 등 분야별 인플루언서를 섭외하고 목록으로 만든다. 소속된 인플루언서가 양질의 콘텐츠를 제작할 수 있도록 지원하고 다양한 MCN채널에 콘텐츠를 올릴 수 있도록 홍보활동을 지원한다. 소속된 인플루언서와 PPL상품 등을 마케팅 방향에 맞도록 연계하고 제작된 콘텐츠를 관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"인플루언서매니저","dJobECd":"4172","dJobECdNm":"[4172]연예인매니저 및 스포츠매니저","dJobJCd":"2882","dJobJCdNm":"[2882]연예인 및 스포츠 매니저","dJobICd":"M739","dJobICdNm":"[M739]그 외 기타 전문, 과학 및 기술 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004640:1', '{"dJobCd":"K000004640","dJobCdSeq":"1","dJobNm":"스포츠에이전트","workSum":"스포츠 선수의 협상, 계약, 이적, 마케팅 등의 업무를 대리하고 각종 관리서비스를 제공한다.","doWork":"스포츠 선수 계약에 관련된 법률, 스포츠 협회 및 단체의 규정·규약, 국내외 스포츠 시장의 동향, 경기 및 대회일정 등에 대한 자료를 수집하고 지식을 학습한다. 유능한 선수를 발굴하고 육성하며 선수의 상품성을 전망한다. 스포츠 선수 또는 스포츠 관련 협회와 계약을 체결하고 연봉협상, 광고계약, 이적, 마케팅 등의 업무를 대리하여 수행한다. 선수에게 언론홍보, 의료지원, 법률지원, 훈련프로그램 제공, 선수의 가족에 대한 지원, 스폰서쉽 및 광고모델 출연계약, 팬 관리 등의 서비스를 제공하고 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"운동선수에이전트","dJobECd":"4172","dJobECdNm":"[4172]연예인매니저 및 스포츠매니저","dJobJCd":"2882","dJobJCdNm":"[2882]연예인 및 스포츠 매니저","dJobICd":"M739","dJobICdNm":"[M739]그 외 기타 전문, 과학 및 기술 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007574:1', '{"dJobCd":"K000007574","dJobCdSeq":"1","dJobNm":"연예인매니저","workSum":"연예인의 이미지를 종합적으로 관리하고 연예인의 활동일정을 계획하며 조정한다.","doWork":"연예인의 활동일정을 관리하고 출연작품 선정을 위해 연예인과 협의한다. 출연을 제의한 영화사, 방송국, 기업체, 기타 일반 단체와 출연일정, 출연료 등을 협의하고 계약한다. 지방, 해외공연에 따른 여행일정, 교통, 숙박 등과 관련하여 세부적인 일정을 수립하고 협의한다. 대본이나 시나리오를 검토하여 담당 연예인이 해당 배역을 소화할 수 있도록 체력 또는 특기활동 등을 훈련시킨다. 극 중 인물의 성격을 효과적으로 표현할 수 있도록 언어, 연기 등을 협의한다. 연예인으로서 소질이 있는 사람을 현장에서 발굴하며, 성장할 수 있는 방안을 구상한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"연예인관리자","connectJob":"연예인과 항상 동행하는 경우 로드매니저(현장매니저), 연예인의 활동일정을 조정하는 경우 스케줄매니저","dJobECd":"4172","dJobECdNm":"[4172]연예인매니저 및 스포츠매니저","dJobJCd":"2882","dJobJCdNm":"[2882]연예인 및 스포츠 매니저","dJobICd":"M739","dJobICdNm":"[M739]그 외 기타 전문, 과학 및 기술 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006570:1', '{"dJobCd":"K000006570","dJobCdSeq":"1","dJobNm":"운동선수매니저","workSum":"운동선수 및 선수단이 최상의 운동능력을 유지하도록 트레이닝 스케줄, 휴식, 건강, 숙박, 차량 이동 등에 대한 제반 사항을 관리한다.","doWork":"개별 운동선수에 대해 트레이닝 시간, 건강상태, 휴식시간, 체중, 식사량 등을 관리하여 최상의 운동능력을 유지하도록 하고, 방송, 행사 등 개인 스케줄을 관리하기도 한다. 선수단의 장비, 숙소, 음식, 차량 등에 관리를 한다. 직업운동선수의 컨디션을 조절하기 위하여 운동선수코치 또는 운동선수트레이너와 협의하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"기록","workFunc2":"협의","workFunc3":"관련없음","similarNm":"스포츠매니저, 운동선수관리자","certLic":"경기지도사","dJobECd":"4172","dJobECdNm":"[4172]연예인매니저 및 스포츠매니저","dJobJCd":"2882","dJobJCdNm":"[2882]연예인 및 스포츠 매니저","dJobICd":"M739","dJobICdNm":"[M739]그 외 기타 전문, 과학 및 기술 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004550:1', '{"dJobCd":"K000004550","dJobCdSeq":"1","dJobNm":"운동선수스카우터","workSum":"구단과 연고를 맺은 고등학교, 대학교를 방문하여 우수한 선수를 소개받거나 발굴한다.","doWork":"고등학교, 대학교 소속의 운동선수들이 참가하는 대회 경기에 참관하여 기량이 뛰어나거나 성장잠재력이 있는 선수를 발굴·선발한다. 선수를 선정한 후 운동감독, 학교 대표, 선수 본인 및 부모와 계약기간, 연봉, 계약금 등을 협의하고 계약을 체결한다. 운동선수의 이적에 관한 일을 하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"4172","dJobECdNm":"[4172]연예인매니저 및 스포츠매니저","dJobJCd":"2882","dJobJCdNm":"[2882]연예인 및 스포츠 매니저","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002889:1', '{"dJobCd":"K000002889","dJobCdSeq":"1","dJobNm":"크리에이터파트너십매니저","workSum":"1인 창작자인 크리에이터의 발굴 및 영입하고 이들의 콘텐츠 기획 및 제작을 지원하며, 홍보, 저작권 관리, 프로모션, 수익 창출 및 마케팅 업무를 수행한다.","doWork":"공모, 이벤트 등을 통해 신규 창작자인 크리에이터를 선발하거나 유망한 1인 창작자를 발굴·육성 또는 스카우트한다. 1인 창작자인 크리에이터와 협의하여 매니지먼트 계약을 체결하고 계약의 이행 여부를 관리한다. 소속 크리에이터의 콘텐츠 및 채널을 분석하여 주요 콘텐츠를 제안한다. 촬영장비, 스튜디오, 소품, 섭외 등 제작환경을 종합적으로 지원하고 관련 사항을 조정·관리한다. 채널성장을 위한 파트너사를 개발하거나 광고유치 및 계약, 협찬, 저작권 관리, 수익관리, 플랫폼과의 소통, 마케팅 등 다양한 매니지먼트 업무를 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"크리에이터에이전트, 크리에이터매니저","dJobECd":"4172","dJobECdNm":"[4172]연예인매니저 및 스포츠매니저","dJobJCd":"2882","dJobJCdNm":"[2882]연예인 및 스포츠 매니저","dJobICd":"J639","dJobICdNm":"[J639]기타 정보 서비스업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007516:1', '{"dJobCd":"K000007516","dJobCdSeq":"1","dJobNm":"조세행정사무원","workSum":"개인 또는 사업체가 납부하는 세금, 부담금 및 기타 형태의 과징금 등의 금액을 결정하기 위하여 세금신고서, 판매영수증 및 기타 서류를 검사한다.","doWork":"각종 세법에 따라 개인 또는 사업체가 납부하는 각종 세금의 금액을 결정하기 위하여 신고서, 판매영수증, 세금계산서 및 기타 관련 서류를 검토하고, 과세자료를 추적·조사한다. 세금을 부과, 승인 결정하는 데 관련된 업무를 수행한다. 각종 세금의 결정과 납부에 관한 법령의 올바른 해석 및 국민의 권리와 의무에 관하여 단체, 기업, 시민에게 조언한다. 법령과 업무처리 규정에 따라 조세행정 업무를 계획하고 시행한다. 각종 보고서나 문서를 기안하고 시행하며 기타 조세행정 업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"조세공무원, 세무공무원","dJobECd":"0251","dJobECdNm":"[0251]조세행정 사무원","dJobJCd":"3111","dJobJCdNm":"[3111]조세행정 사무원","dJobICd":"O841","dJobICdNm":"[O841]입법 및 일반 정부 행정","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004103:1', '{"dJobCd":"K000004103","dJobCdSeq":"1","dJobNm":"공항검역관","workSum":"수출 및 수입되는 동식물 및 축산물, 해외로 나가고 들어오는 사람들과 항공기 등을 검역한다.","doWork":"항공기 안에서 항공기로 도착한 수입물품에 대한 현장검사를 시행한다. 필요할 경우, 정밀검사 및 임상검사 등을 실시하여 수입물품의 허가를 결정한다. 승객들이 작성한 휴대품신고서를 확인하여 동식물, 축산물 등의 유무를 확인한 후 품목에 따라 압류하여 검역을 이행하도록 지시한다. 반입금지품목의 경우 반송 또는 폐기조치한다. 검역대상물품은 정밀검사를 실시하여 안전성검사에 합격되면 승객에게 인도한다. 입국하는 승객에게 반열감시를 실시하고, 이상징후가 나타나면 채변검사 등을 실시한다. 일부 위험국가로 출국하는 승객들에게는 예방접종을 실시한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"농축산물검역관, 농식물검역관","certLic":"수의사(동물, 축산물검역관의 경우)","dJobECd":"0252","dJobECdNm":"[0252]관세행정 사무원","dJobJCd":"3112","dJobJCdNm":"[3112]관세행정 사무원","dJobICd":"H511","dJobICdNm":"[H511]항공 여객 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001831:1', '{"dJobCd":"K000001831","dJobCdSeq":"1","dJobNm":"공항세관원","workSum":"반입금지 품목 및 밀수 등을 단속하기 위해 항공기로 수출 및 수입되는 모든 물품과 출입객의 휴대품을 검사하고 분석한다.","doWork":"항공기를 통해 수출 및 수입되는 물품의 수출입신고를 수리하고, 필요한 경우 해당 물품을 검사·감정한다. 수입물품에 대하여 품목별로 세액을 징수하고, 사후에 세액을 심사한다. 관리대상 화물을 선별하여 검사한다. 사전에 항공사로부터 여행객의 정보를 입수하고 검사대상 여행자를 선별한다. 검사대상으로 지정된 물품에 대해 자진신고를 받거나 엑스레이 장비 등으로 검사한다. 반입제한물품, 면세초과물품 등을 선별하여 통관절차를 이행하도록 지도한다. 밀수 및 마약, 폭발물 등을 단속하고, 이를 위해 탐지견을 이용하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"수동조작","dJobECd":"0252","dJobECdNm":"[0252]관세행정 사무원","dJobJCd":"3112","dJobJCdNm":"[3112]관세행정 사무원","dJobICd":"H511","dJobICdNm":"[H511]항공 여객 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002563:1', '{"dJobCd":"K000002563","dJobCdSeq":"1","dJobNm":"보세사","workSum":"보세창고, 보세공장, 보세판매장 등 보세구역(외국물건 또는 일정한 내국물건에 대하여 관세법에 따라 관세의 부과가 유보되는 지역)에서 장치(藏置)된 물품을 관리한다.","doWork":"보세화물 및 내국물품의 반입 또는 반출에 대해 입회 및 확인한다. 보세구역 안에 장치된 물품의 관리 및 취급에 대해 입회 및 확인한다. 보세구역출입문의 개폐 및 열쇠관리를 감독한다. 보세구역의 출입자관리를 감독한다. 견품을 반출 또는 회수한다. 보수작업과 화주의 수입신고 전 장치물품 확인 시 입회·감독한다. 세관 봉인대에서 봉인을 부착하고 관리대장에 기록하여 관리한다. 환적화물 컨테이너 적출입 시 입회·감독한다. 관련 법률에 따라 내국물품 반출입관리대장, 보수작업관리대장, 환적화물의 적출입관리대장, 장치물품수입신고 전 확인대장, 세관봉인대관리대장 등 비치대장을 작성하고 전산처리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"관련없음","certLic":"보세사","dJobECd":"0252","dJobECdNm":"[0252]관세행정 사무원","dJobJCd":"3112","dJobJCdNm":"[3112]관세행정 사무원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006478:1', '{"dJobCd":"K000006478","dJobCdSeq":"1","dJobNm":"세관사무원","workSum":"수입 또는 수출하기 위하여 컨테이너부두로 반입되는 물품에 대한 세관 관련 업무를 수행한다.","doWork":"세관 관련 서류를 작성하여 세관에 제출한다. 구내 이적 컨테이너를 입력하여 터미널운영원에게 통보한다. 타 부두 반입분에 대한 하역료를 계산하고 세관에 신고한다. 수입신고필증을 접수하여 날인한다. 청구자료를 발행하여 경리사무원에게 전달한다. 정시간 외 화물취급 특별허가신청서를 작성하고 특별허가료를 납부한다. 정시간외 특별허가대장을 정리한다. 하선신고서를 작성하여 신고한다. 특별허가료를 수령하고 납부한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"세관공무원, 관세공무원, 세관검사원, 세관원","certLic":"보세사","dJobECd":"0252","dJobECdNm":"[0252]관세행정 사무원","dJobJCd":"3112","dJobJCdNm":"[3112]관세행정 사무원","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006075:1', '{"dJobCd":"K000006075","dJobCdSeq":"1","dJobNm":"출입국심사관","workSum":"공항 및 항만을 출입하는 내외국인의 신분을 확인하여 입출국을 허가한다.","doWork":"여권인식기(MRP:Machine Readable Passport)를 이용하여 입국 및 출국하는 내국인과 외국인들의 신분 및 여권에 이상이 없는지 확인한다. 항공기가 도착하기 전에 항공사로부터 탑승객의 인적사항 등 관련 정보를 미리 받아 분석한 후 입국심사를 한다. 위조 및 변조된 여권이나 비자 등을 감식하고 출국금지 및 입국금지자, 의심되는 승객 등을 심사실로 이동시켜 입국 목적 및 과거 행적 등을 조사하여 재심사한다. 출·입국 통과여객을 모니터링하여 통계를 작성하고 여권 및 사증의 위변조 수법을 연구하거나 위변조 혐의자의 동향을 파악하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"수동조작","connectJob":"여권검사공무원","dJobECd":"0252","dJobECdNm":"[0252]관세행정 사무원","dJobJCd":"3112","dJobJCdNm":"[3112]관세행정 사무원","dJobICd":"H511","dJobICdNm":"[H511]항공 여객 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007456:1', '{"dJobCd":"K000007456","dJobCdSeq":"1","dJobNm":"병무행정사무원","workSum":"국토방위의 근간이 되는 병역자원을 관리한다.","doWork":"병역법에 의거하여 징·소집 대상, 병역대체복무자, 병력동원대상 등 병역자원을 관리한다. 징병검사 및 각종 병역 관련 업무를 처분한다. 향토예비군을 편성하고 예비군 자원을 관리한다. 동원지정 예비군을 관리하고 대상 예비군에 대하여 전시병력 동원 및 훈련소집을 한다. 산업기능요원 채용업체를 지정하고 관리하는 등 병역대체복무자를 편성·관리한다. 병역의무자의 국외여행 및 국외체제 시의 허가 및 병적증명서, 복무확인서 발급 등의 업무를 수행한다. 훈련 불참 등 병역법 위반 시 고발 등의 조치를 하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"병무청공무원, 병무담당공무원","dJobECd":"0253","dJobECdNm":"[0253]병무행정 사무원","dJobJCd":"3113","dJobJCdNm":"[3113]병무행정 사무원","dJobICd":"O843","dJobICdNm":"[O843]외무 및 국방 행정","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007078:1', '{"dJobCd":"K000007078","dJobCdSeq":"1","dJobNm":"복무지도관","workSum":"사회복무요원을 관리ㆍ감독하고 복무기관의 복무관리 실태 등을 조사ㆍ평가한다.","doWork":"사회복무요원의 복무실태를 관리ㆍ감독하고 복무지도한다. 근무 태만 및 근무 기강 문란, 무단조퇴 등 근무 중 복무 의무 위반사례를 단속한다. 소속 복무기관의 복무관리 실태를 조사ㆍ평가하고 관리ㆍ감독한다. 사회복무요원의 권익보호를 위해 상담 및 고충처리 등의 업무를 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"수집","workFunc2":"감독","workFunc3":"관련없음","similarNm":"복무관리담당관","certLic":"임상심리사, 정신보건임상심리사, 사회복지사, 정신보건사회복지사, 청소년상담(지도)사","dJobECd":"0253","dJobECdNm":"[0253]병무행정 사무원","dJobJCd":"3113","dJobJCdNm":"[3113]병무행정 사무원","dJobICd":"O843","dJobICdNm":"[O843]외무 및 국방 행정","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001311:1', '{"dJobCd":"K000001311","dJobCdSeq":"1","dJobNm":"국제우편물통관사무원","workSum":"국제우편물을 분류하여 요금 및 세금고지서를 교부하고 통관서류를 작성한다.","doWork":"국제우편물 중에 과세대상 및 비과세대상 우편물을 판정하기 위하여 국제우편행낭의 통관개낭 시 세관 입회하에 관세가 적용되는 우편물과 적용되지 않는 우편물을 X-ray 투시기를 통해서 분류한다. 세관의 요청에 의해 개피(우편물의 포장을 뜯음)하여 내용물을 확인하기도 한다. 통관우편물 목록을 작성한다. 국제우편물 도착통지서를 작성하고 통관에 따르는 요금 및 세금고지서를 발행하여 수취인에게 교부한다. 통관우편물의 보류 및 해제사항을 수취인에게 통지한다. 우체국 간의 발송내역서를 작성하여 통관우편물을 배달우체국으로 발송한다. 파손, 주소불명, 수취거절 등으로 인한 발송탈락우편물을 발송인 및 수취인에게 연락하여 처리내용을 협의하고 일정기간이 경과하여도 처리되지 않는 우편물은 국고에 편입시킨다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"계산","workFunc2":"말하기신호","workFunc3":"투입인출","dJobECd":"0254","dJobECdNm":"[0254]국가·지방행정 사무원","dJobJCd":"3114","dJobJCdNm":"[3114]국가 및 지방 행정 사무원","dJobICd":"J611","dJobICdNm":"[J611]공영 우편업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005032:1', '{"dJobCd":"K000005032","dJobCdSeq":"1","dJobNm":"녹색인증제도운영원","workSum":"녹색인증요청서를 검토하고 녹색인증심의위원회를 개최하여 심사결과에 따라 소관 중앙행정기관의 장에게 인증서 발급을 요청한다.","doWork":"녹색기술인증 활성화 방안을 기획한다. 저탄소녹색성장기본법 및 녹색인증제 운영요령 등 관련 제도의 제·개정업무를 수행한다. 관계부처, 국회, 감사 등 대외업무를 수행한다. 녹색인증정보시스템을 관리한다. 녹색기술인증 안내, 신청서 검토, 접수, 평가의뢰, 평가결과 확인, 인증서 발급업무를 수행한다. 인증심의위원회를 운영한다. 녹색인증 관련 통계를 관리한다. 녹색인증회원 및 관련 전문가를 관리한다. 각종 보고서를 작성하여 배포한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"녹색건축인증지원사무원, 녹색건축인증코디네이터","dJobECd":"0254","dJobECdNm":"[0254]국가·지방행정 사무원","dJobJCd":"3114","dJobJCdNm":"[3114]국가 및 지방 행정 사무원","dJobICd":"O842","dJobICdNm":"[O842]사회 및 산업정책 행정","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006026:1', '{"dJobCd":"K000006026","dJobCdSeq":"1","dJobNm":"농업용수관리기획원","workSum":"효율적인 농업용수를 관리하기 위한 정책개발 및 제도개선을 위한 기획을 한다.","doWork":"농업생활용수를 포함한 농업용수의 이용 및 관리에 대한 중·장기계획을 수립한다. 용수관리 정책개발 및 제도개선을 위한 계획을 수립하고 시행한다. 농업용수를 이용하는 관리대상구역 및 대상에 대한 선정 및 변경에 대한 업무를 수행한다. 물관리 관련 제 법규에 대한 검토 및 개정에 관한 업무를 한다. 용수관리에 대한 현황조사 및 효율화 방안을 연구한다. 농업용수에 관한 체계적인 관리를 위한 정보의 전산화를 추진한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0254","dJobECdNm":"[0254]국가·지방행정 사무원","dJobJCd":"3114","dJobJCdNm":"[3114]국가 및 지방 행정 사무원","dJobICd":"A014","dJobICdNm":"[A014]작물재배 및 축산 관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005924:1', '{"dJobCd":"K000005924","dJobCdSeq":"1","dJobNm":"수도사업개발계획원","workSum":"용수급수현황을 조사·분석하여 광역상수도 중장기개발계획을 수립한다.","doWork":"광역상수도개발을 위한 전국의 용수수요조사(면적이나 인구를 기반으로 수요량을 예측하는 방법 또는 직접수요조사 방법을 사용) 및 수도시설 현황조사를 한다. 상수도 수요량 예측자료를 개발하고 관계부서에 보급한다. 개발에 따른 중장기계획 및 재원조달계획을 수립한다. 산업단지 개발, 공동주택단지 개발 등 특정지역의 용수공급계획을 수립하고 관계도면을 그린다. 광역상수도의 맑은 물공급을 위해 상류댐의 활용방안을 검토한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","certLic":"토목기사","dJobECd":"0254","dJobECdNm":"[0254]국가·지방행정 사무원","dJobJCd":"3114","dJobJCdNm":"[3114]국가 및 지방 행정 사무원","dJobICd":"E360","dJobICdNm":"[E360]수도업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002976:1', '{"dJobCd":"K000002976","dJobCdSeq":"1","dJobNm":"수용지보상원","workSum":"각종 공사에 따른 용지취득 및 토지수용에 따른 보상계획을 수립하고 보상대상의 선정, 보상액의 감정의뢰 및 지급, 민원처리 등 제반 업무를 수행한다.","doWork":"수용지의 지적을 확인하고 등기부를 열람하여 면적, 지목, 소유권 및 보상대상을 확인한다. 보상계획을 공고하고 토지소유자에게 개별통지를 한다. 용지수용에 따른 이의신청을 접수·처리하고 보상물건을 확정한다. 매수방법을 결정하고, 확정된 보상물건에 대하여 감정기관에 보상액의 감정을 의뢰한다. 감정된 감정가의 평균치를 산정하여 보상액을 산정한다. 산정된 보상액에 따라 소유주와 수용계약을 체결하고 보상금을 지급한다. 보상업무에 관한 각종 협의 및 민원처리, 소송업무를 담당한다. 보상용지가 수몰되는 경우에는 국가유산이나 이주민의 이전비용을 검토하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","connectJob":"수용된 부지의 사용목적에 따라 수몰지보상원, 용도에 따라 댐용지보상원, 발전소용지보상원, 신도시용지보상원, 사무소용지보상원","dJobECd":"0254","dJobECdNm":"[0254]국가·지방행정 사무원","dJobJCd":"3114","dJobJCdNm":"[3114]국가 및 지방 행정 사무원","dJobICd":"L681","dJobICdNm":"[L681]부동산 임대 및 공급업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004445:1', '{"dJobCd":"K000004445","dJobCdSeq":"1","dJobNm":"온실가스인증사무원","workSum":"기업체 등이 작성한 온실가스 인벤토리 보고서를 검증·인증하는 업무를 수행한다.","doWork":"검·인증 대상 기업체나 기관(지자체) 등과 협의해 인벤토리 검·인증 대상을 확인한다. 검증팀, 기준, 일정 등을 감안해서 검증계획을 수립한다. 문서검토와 현장평가를 통해 검증을 실시한 후, 부적합 사항 발견 시 시정조치를 지시한다. 검증보고서를 작성한 후, 기술검토를 통해 검증활동의 품질관리를 한다. 신뢰성과 객관성 있는 온실가스 배출량 산정 및 보고를 위해 검증보고서를 발행한다. 온실가스감축 교육 및 개도국 온실가스감축 지원을 위한 사무를 하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"0254","dJobECdNm":"[0254]국가·지방행정 사무원","dJobJCd":"3114","dJobJCdNm":"[3114]국가 및 지방 행정 사무원","dJobICd":"M729","dJobICdNm":"[M729]기타 과학기술 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001895:1', '{"dJobCd":"K000001895","dJobCdSeq":"1","dJobNm":"의약품심사지원원","workSum":"유통되고 있는 의약품 및 새로 허가를 신청하는 신규의약품과 신약품의 효능, 부작용, 용법 등을 평가하고 검토가 필요한 의약품목은 평가심사위원회에 상정한다.","doWork":"유통의약품의 재평가 및 새로 허가를 신청하는 신규의약품과 신약의 평가를 위한 신청서를 접수·분류하고 데이터베이스화한다. 접수된 신청서를 평가하고 미비한 서류는 보완점을 지시한다. 의약품 품목별로 조사·분석하여 평가하며 평가결과에 대해서 보고서를 작성하여 보고한다. 임상실험이 필요한 경우 관련 부서에 요청한다. 검토가 필요한 의약품목은 자료를 정리하여 평가심사위원회에 상정한다. 평가기준 변경 등 재평가 및 평가에 따른 설명회를 개최한다. 의약품의 효능, 부작용 등 국제적인 동향을 조사·분석한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","certLic":"약사, 한약사","dJobECd":"0254","dJobECdNm":"[0254]국가·지방행정 사무원","dJobJCd":"3114","dJobJCdNm":"[3114]국가 및 지방 행정 사무원","dJobICd":"O842","dJobICdNm":"[O842]사회 및 산업정책 행정","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005715:1', '{"dJobCd":"K000005715","dJobCdSeq":"1","dJobNm":"장애인보조기기지원사무원","workSum":"장애인의 직무수행에 필요한 보조공학기기 지급을 위하여 장애인의 직업능력과 직무를 평가하고 지급에 관련된 행정업무를 처리한다.","doWork":"직업훈련기관 또는 사업장 담당자로부터 장애인보조공학기기 지급신청서를 접수한다. 보조기 사용 예정 장애인의 요구를 확인하고 신체적 조건에 대해 상담한다. 근력테스트기 등을 포함한 검사 및 측정도구를 사용하여 장애인의 신체, 인지, 감각, 언어 등의 기초평가를 실시한다. 사업장을 직접 방문하여 사업장 담당자와 직무수행과 관련하여 면담한다. 장애인에게 제공할 보조공학기기를 선정하고 모의작업장에서 사용에 관련된 문제점 등을 사전 파악한다. 필요에 따라서 개조, 제작 등을 의뢰한다. 지급과 관련된 기타 행정업무를 처리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"손사용|언어력|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"작업치료사","dJobECd":"0254","dJobECdNm":"[0254]국가·지방행정 사무원","dJobJCd":"3114","dJobJCdNm":"[3114]국가 및 지방 행정 사무원","dJobICd":"O842","dJobICdNm":"[O842]사회 및 산업정책 행정","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007295:1', '{"dJobCd":"K000007295","dJobCdSeq":"1","dJobNm":"전보송수신원","workSum":"서버 및 네트워크에 연결된 컴퓨터에 전보내용을 입력하여 전보를 송신하고 수신받는다.","doWork":"미송전보를 송달순위별, 수신(접수)시간별로 구분한다. 송신절차 및 송신방법에 따라 컴퓨터에 송신 내용을 입력한다. 전문의 송신이 끝나면 완료시각·통수·송신자번호를 송신하여 수신국에 송신완료를 통보한다. 상대국 수신자로부터 수신증을 수신하고 통과번호, 통수, 수신시각, 수신자번호 등을 확인하여 송신통과기록표에 기록한다. 송신원서를 정리하여 송신함에 투입한다. 전보발신지의 규격에 준하여 수신전보를 전달한다. 전보의 내용을 확인하고, 하단에 수신시각을 기입한다. 환·대체전보에는 대조자 수기번호를 입력한다. 상대국에 수신증을 송신한다. 비상전보, 지급전보, 환전보, 대체전보, 특별서비스전보 등을 분류한다. 수신통과기록표를 작성하고 수신 완료된 전보를 수신함에 투입한다. 비상전보는 담당자에게 직접 인계한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"유지","dJobECd":"0254","dJobECdNm":"[0254]국가·지방행정 사무원","dJobJCd":"3114","dJobJCdNm":"[3114]국가 및 지방 행정 사무원","dJobICd":"J611","dJobICdNm":"[J611]공영 우편업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005963:1', '{"dJobCd":"K000005963","dJobCdSeq":"1","dJobNm":"전보접수원","workSum":"인터넷, 전화, FAX, 방문을 통해 전보를 접수하고 분류한다.","doWork":"인터넷, FAX, 전화 또는 고객의 방문에 의해 전보를 접수한다. 통신문, 성명, 주소, 발신인, 전보상품 등을 확인한다. 접수대장에 발신번호 및 접수시간을 기록한다. 기록한 접수증을 토대로 통신망을 이용하여 착신국으로 전보내용, 발신지의 주소, 성명 등을 송신한다. 각종 부가서비스(꽃배달, 선물배달 등)를 판매한다. 국내전보, 국제전보, 일반전보, 기업전보(대량전보)를 분류하여 처리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","dJobECd":"0254","dJobECdNm":"[0254]국가·지방행정 사무원","dJobJCd":"3114","dJobJCdNm":"[3114]국가 및 지방 행정 사무원","dJobICd":"J611","dJobICdNm":"[J611]공영 우편업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006651:1', '{"dJobCd":"K000006651","dJobCdSeq":"1","dJobNm":"정부행정사무원(일반)","workSum":"법률 및 규정에 근거하여 정부 및 지방정부에서 각종 행정업무를 수행하거나 승인이나 검사, 허가 등 정부행정 집행과 관련된 업무를 수행한다.","doWork":"법령과 업무처리규정에 따라 소관업무를 계획하고 시행한다. 각종 보고서나 문서를 기안, 보고하고 시행하며 기타 행정에 관련된 업무를 수행한다. 주민등록, 출생, 사망, 가족관계등록, 이혼, 호적 등과 관련된 서류 접수 및 발급 등 국가와 지방자치단체 고유의 행정업무를 수행한다. 사회복지서비스, 교통서비스 등의 각종 민원 처리 업무를 수행한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"국가행정사무원, 지방행정사무원, 국가직공무원, 지방행정직공무원, 선거공무원, 선거관리공무원, 근로감독관, 주무관, 주사(6급), 주사보(7급), 서기(8급), 서기보(9급), 국제기구행정사무원","dJobECd":"0254","dJobECdNm":"[0254]국가·지방행정 사무원","dJobJCd":"3114","dJobJCdNm":"[3114]국가 및 지방 행정 사무원","dJobICd":"O84","dJobICdNm":"[O84]공공행정, 국방 및 사회보장 행정","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001917:1', '{"dJobCd":"K000001917","dJobCdSeq":"1","dJobNm":"친환경건축물인증관리사무원","workSum":"친환경건축물인증을 취득하기 위한 제반 실무를 수행한다.","doWork":"건축물의 설계와 시공과정에서 사용하는 건축자재 등이 친환경 건축물인증 기준에 부합하는지를 확인하기 위해 관련 서류를 검토한다. 건축물의 유해물질 및 온실가스 배출 등에 대한 정보를 관련 부서와 기관에 요청하여 수집한다. 수집된 정보를 분석하여 인증정보를 정리한다. 친환경건축인증기관에 친환경건축인증을 신청한다. 인증심사 중 발생하는 추가요청에 대응한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0254","dJobECdNm":"[0254]국가·지방행정 사무원","dJobJCd":"3114","dJobJCdNm":"[3114]국가 및 지방 행정 사무원","dJobICd":"F411","dJobICdNm":"[F411]건물 건설업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003126:1', '{"dJobCd":"K000003126","dJobCdSeq":"1","dJobNm":"현장기동반운영수행원","workSum":"고질적·고의적 양육비 미이행자에 대한 자료를 축적하고, 원활한 양육비 이행을 위한 사전방문조사 및 감치명령집행 보조 등의 업무를 처리한다.","doWork":"원활한 양육비 이행을 돕기 위한 대상사건 검토·선별을 진행한다. 양육비 이행을 강제할 수 있도록 관계기관(법원, 경찰청, 기타 지방자치단체 등)의 협조를 구한다. 대상사건·관계인에 대한 사전조사 및 현장방문, 업무협력을 바탕으로 한 감치명령집행 보조활동과 감치명령 집행 이후 양육비 변제합의 지원 등의 업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"언어력|","workFunc1":"수집","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0254","dJobECdNm":"[0254]국가·지방행정 사무원","dJobJCd":"3114","dJobJCdNm":"[3114]국가 및 지방 행정 사무원","dJobICd":"O845","dJobICdNm":"[O845]사회보장 행정","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007439:1', '{"dJobCd":"K000007439","dJobCdSeq":"1","dJobNm":"공공행정사무원(일반)","workSum":"공사, 공단 및 정부출연 연구기관, 공공행정기관 등에서 법령과 업무처리 규정에 따라 각종 행정업무를 한다.","doWork":"금융, 교육, 인력양성, 자격 등 정부 위탁 사업을 기획하고 운영한다. 사업결과를 평가한다. 사업을 위한 각종 예산업무를 한다. 사업과정에서 문서관리, 문서작성, 데이터 관리, 사무자동화 관리운용 등 조직 내부와 외부에서 요청하거나 필요한 업무를 수행한다. 해당 부처 담당자와 업무와 협의하고 조율한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0255","dJobECdNm":"[0255]공공행정 사무원","dJobJCd":"3115","dJobJCdNm":"[3115]공공행정 사무원","dJobICd":"O841","dJobICdNm":"[O841]입법 및 일반 정부 행정","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005895:1', '{"dJobCd":"K000005895","dJobCdSeq":"1","dJobNm":"교통안전관리사무원","workSum":"일반운전자 및 운수업체 종사자를 대상으로 교통안전에 대한 안전수칙 및 각종 정보를 제공하고, 안전 지도 및 홍보를 담당한다.","doWork":"교통안전에 관한 기본적인 계획을 정기적으로 수립하고 관련 업무를 조정한다. 교육, 행사 관련 사업 추진결과 및 실적을 취합하고 분석하여 업체대표에 보고한다. 정부기본시책에 따라 지방자치단체, 운수업체, 터미널 등 각 분야별로 사고방지대책을 수립한 후 시행을 권고한다. 공공도로 및 철도 관련 교통사고 통계를 사고유형, 원인별로 분석하여 교육·홍보자료로 활용하고 교통사고 예방에 노력한다. 교통법규 위반차량 소지자에게 위반사항을 통보하고 주의를 당부하는 권고엽서 및 지침을 발송하여 안전운행을 유도한다. 운수업체를 대상으로 차량 및 교통안전관리와 관련된 각종 교통안전진단을 실시하여 교통사고예방대책의 기초자료로 활용한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","similarNm":"교통안전교육지도사","certLic":"교통안전관리자, 도로교통사고감정사","dJobECd":"0255","dJobECdNm":"[0255]공공행정 사무원","dJobJCd":"3115","dJobJCdNm":"[3115]공공행정 사무원","dJobICd":"O842","dJobICdNm":"[O842]사회 및 산업정책 행정","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001576:1', '{"dJobCd":"K000001576","dJobCdSeq":"1","dJobNm":"기후변화적응담당사무원","workSum":"기후변화 적응대책(기후상태가 변화하는 것에 적응하기 위해 생태계 또는 사회경제시스템이 취하는 행동)을 기획·추진·홍보한다.","doWork":"건강, 재난·재해, 농업, 산림, 해양·수산업, 물관리, 생태계, 기후변화감시 및 예측, 적응산업·에너지 등 다양한 분야에서 기후변화영향평가 및 취약성 분석을 실시한다. 기후변화 적응대책 정책자료를 기획하고 관련 기관(녹색성장위원회, 환경부, 지식경제부, 기상청 등)에 제공한다. 기후변화 적응대책 세부시행계획(폭염영향평가, 대기오염 피해저감, 기후변화 취약지역 지도작성, 작물영향평가, 산성화 피해저감, 황폐산림보전, 해수면 상승으로 인한 연안변화 관리, 물관리 취약성 완화, 생태계 보호·복원대책, 기후변화 감시·예측기술 시나리오, 에너지 분야 취약성 평가지표 개발 등) 추진에 따르는 실무를 진행한다. 기후변화 적응대책 관련 교육자료, 워크숍자료, 영향평가매뉴얼, 기후변화적응사례 등을 개발하고 배포(홍보·교육)한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0255","dJobECdNm":"[0255]공공행정 사무원","dJobJCd":"3115","dJobJCdNm":"[3115]공공행정 사무원","dJobICd":"O842","dJobICdNm":"[O842]사회 및 산업정책 행정","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005843:1', '{"dJobCd":"K000005843","dJobCdSeq":"1","dJobNm":"가스수급계획원","workSum":"가스의 안정적인 공급을 위하여 수요를 예측하고 가스수급계획을 수립한다.","doWork":"가스수요자들로부터 공급계획을 접수한다. 도시가스 수요와 발전에 필요한 가스의 수요를 예측한다. 전망모델을 이용하여 수요를 예측한다. 공급량을 맞추기 위해 수립된 계획을 시설기획팀에 통보한다. 가스 이외에 국내외 에너지의 수급실태와 추이를 분석한다. 갑작스런 변화에 대한 비상수급대책을 수립한다. 안정적이고 경제적인 가스수급을 위해 제반 업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0261","dJobECdNm":"[0261]기획·마케팅 사무원","dJobJCd":"3121","dJobJCdNm":"[3121]기획 및 마케팅 사무원","dJobICd":"D352","dJobICdNm":"[D352]연료용 가스 제조 및 배관공급업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001325:1', '{"dJobCd":"K000001325","dJobCdSeq":"1","dJobNm":"가스수요개발원","workSum":"가스의 수요를 확대시키기 위하여 영업, 판매처 개발 및 홍보 등의 가스수요 개발에 관련된 업무를 수행한다.","doWork":"도시가스, 산업용가스, 일반수용처와 같은 용도별 가스수요 증대를 위한 개발계획을 수립한다. 대규모 공장의 증설이나 연로전환계획에 대한 정보를 수집한다. 가스의 수요개발자료를 수집·관리한다. 가스에 대한 홍보자료를 배포하고 상담자료를 제작한다. 가스수요 증대를 위한 수요개발업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"균형감각|","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0261","dJobECdNm":"[0261]기획·마케팅 사무원","dJobJCd":"3121","dJobJCdNm":"[3121]기획 및 마케팅 사무원","dJobICd":"D352","dJobICdNm":"[D352]연료용 가스 제조 및 배관공급업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001526:1', '{"dJobCd":"K000001526","dJobCdSeq":"1","dJobNm":"가스판매관리원","workSum":"가스의 판매실적, 수용가 현황자료를 수집·분석하여 판매계획을 수립하고 적정 도소매가 산출을 위한 자료를 제공한다.","doWork":"장기적인 가스의 수요량을 측정하기 위하여 각종 자료를 수집하고 분석한다. 기간별로 가스의 공급량을 점검하고 판매계획을 수립한다. 가스의 판매실적 분석과 손익분석 자료를 작성하여 가스의 도소매가격 산출근거를 제공한다. 신규 수요처 개발을 위하여 관련 부서와 협조업무를 수행한다. 현장답사를 통해 수용가의 실태를 점검하고 관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0261","dJobECdNm":"[0261]기획·마케팅 사무원","dJobJCd":"3121","dJobJCdNm":"[3121]기획 및 마케팅 사무원","dJobICd":"D352","dJobICdNm":"[D352]연료용 가스 제조 및 배관공급업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002534:1', '{"dJobCd":"K000002534","dJobCdSeq":"1","dJobNm":"개인간대출서비스기획관리자","workSum":"온라인플랫폼을 통해 대출을 원하는 사람과 투자자를 중개하는 P2P대출서비스를 기획·운영한다.","doWork":"개인간대출서비스(금융기관을 거치지 않고 개인 간 대출이 가능토록 하는 인터넷 기반의 중개서비스, P2P대출) 운영정책을 수립한다. 업계의 동향, 업황 등을 조사·분석한다. 자사 P2P대출상품의 경쟁력을 확보하기 위해 대출금리, 상환방식, 대출수수료, 투자수익률, 투자수수료 등을 검토·조정한다. 온라인플랫폼을 통한 대출금모집(투자자의 투자금액)상황을 모니터링하고 촉진방안을 모색한다. 대출심사역, 온라인플랫폼운영자, 마케터, 채권관리(채권추심) 등 관련 인원의 활동을 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0261","dJobECdNm":"[0261]기획·마케팅 사무원","dJobJCd":"3121","dJobJCdNm":"[3121]기획 및 마케팅 사무원","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002097:1', '{"dJobCd":"K000002097","dJobCdSeq":"1","dJobNm":"경영혁신사무원","workSum":"조직의 경영혁신과 연구지원을 위해 계획을 수립하고 시행·평가한다.","doWork":"경영혁신과 연구지원에 필요한 기획안을 마련하기 위해 조직 내외에서 설문조사 및 사례조사를 한다. 종합계획과 세부실행계획을 수립한다. 조직원을 대상으로 주요내용과 세부추진절차를 설명하여 성공적인 결과를 이끌어낸다. 경영혁신과 연구지원방안을 수립하고 실시한다. 설문조사 및 기타의 방법으로 결과에 대한 효과를 평가한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"경영혁신기획원, 경영평가사무원","dJobECd":"0261","dJobECdNm":"[0261]기획·마케팅 사무원","dJobJCd":"3121","dJobJCdNm":"[3121]기획 및 마케팅 사무원","dJobICd":"C/G","dJobICdNm":"[C]제조업 / [G]도매 및 소매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;