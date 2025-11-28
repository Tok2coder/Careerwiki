INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005031:1', '{"dJobCd":"K000005031","dJobCdSeq":"1","dJobNm":"쇼핑호스트","workSum":"상품판매 방송을 진행하면서 시청자에게 상품의 기능, 특성 등을 설명하고 상품의 판매를 촉진한다.","doWork":"방송프로듀서(방송연출가)와 협의하여 방송에서 소개할 판매상품의 정보를 숙지한다. 원활한 방송진행을 위해 방송 시작 전에 판매상품에 대한 시장조사를 하고, 제품의 특성을 충분히 파악한다. 방송에 함께 출연하는 기업체 담당자와 진행상황을 연습한다. 상품판매를 목적으로 방송을 진행한다. 방송 중에는 시연 등을 통해 상품의 기능을 확인하고 상품의 특성을 알려준다. 직접 시음하거나 상품을 사용하면서 소비자가 상품을 구매하도록 촉진한다. 매출현황, 주문내역 등을 모니터하여 시청자에게 전달한다. 방송 후 매출량을 확인하여 다음에 방송할 때 참고한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"비교","workFunc2":"설득","workFunc3":"관련없음","similarNm":"쇼호스트","dJobECd":"4163","dJobECdNm":"[4163]아나운서 및 리포터","dJobJCd":"2833","dJobJCdNm":"[2833]아나운서 및 리포터","dJobICd":"G479","dJobICdNm":"[G479]무점포 소매업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004594:1', '{"dJobCd":"K000004594","dJobCdSeq":"1","dJobNm":"연예프로그램진행자","workSum":"텔레비전이나 라디오에서 방송연예프로그램을 진행한다.","doWork":"연예프로그램 진행에 대한 전반적인 사항과 방송대본을 숙지한다. 연예프로그램이 원활히 이루어질 수 있도록 계획을 세운다. 작성된 방송계획 및 대본에 따라 연예인 등의 출연자를 청중에게 소개한다. 발음, 표정, 태도 등에 주의하여 연예프로그램을 진행한다. 진행상 돌발사고에 대처하여 연예프로그램이 원활히 진행되도록 한다. 갖추어 진행이 원활히 이루어지도록 유도한다. 평소에 유머 감각과 행사진행 감각을 키우도록 연습한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"청각|언어력|시각|","workFunc1":"관련없음","workFunc2":"오락제공","workFunc3":"관련없음","similarNm":"연예프로그램MC(Master of Ceremonies)","dJobECd":"4163","dJobECdNm":"[4163]아나운서 및 리포터","dJobJCd":"2833","dJobJCdNm":"[2833]아나운서 및 리포터","dJobICd":"J602","dJobICdNm":"[J602]텔레비전 방송업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006409:1', '{"dJobCd":"K000006409","dJobCdSeq":"1","dJobNm":"증권시황방송원","workSum":"사내방송이나 유선방송, 인터넷방송 등을 통해 증권관계자 및 투자자를 대상으로 시시각각 변하는 증권시황을 발표한다.","doWork":"진행순서에 따라 준비된 뉴스, 공보, 기타 고지사항을 발표한다. 증권시장 현장의 상황을 투자자에게 보도한다. 증시 관련 사항에 대해 기업분석가, 시황분석원, 투자전략가 등 전문가와 면담하여 증시전망 및 투자전략에 대해 상세히 보도한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"방송매체에 따라 사내시황방송원, 텔레비전시황방송원, 인터넷시황방송원","dJobECd":"4163","dJobECdNm":"[4163]아나운서 및 리포터","dJobJCd":"2833","dJobJCdNm":"[2833]아나운서 및 리포터","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002890:1', '{"dJobCd":"K000002890","dJobCdSeq":"1","dJobNm":"무인항공촬영기사","workSum":"촬영기술을 기초로 소형카메라가 장착된 헬기(헬리캠, 플라이캠 등)를 조종하여 각종 물체나 대상을 촬영한다.","doWork":"촬영감독과 협의하여 촬영 대본(시나리오)에 따라 장면배열을 결정하고, 촬영장비 선정 등 촬영계획을 세운다. 지방항공청, 국방부에 촬영승인을 요청하여 촬영허가를 받는다. 헬리캠 배터리 점검, 장비의 작동 점검 등을 한다. 촬영현장을 답사하여 촬영에 영향을 줄 수 있는 요인을 분석하고, 촬영에 필요한 제반 사항을 결정한다. 헬리캠을 조종하는 촬영기사와 협의하여 카메라 조종용 리모콘을 작동한다. 촬영대상, 촬영거리, 화면사이즈 등을 고려하여 촬영하며, 모니터를 통해 확인한다. 촬영한 영상은 현장에 점검 나온 관리기관 담당자에게 바로 보안검사를 받고, 문제 시 되는 부분은 삭제하여 검사를 완료한 후 납품한다. 파손된 촬영장비, 드론 등을 직접 수리하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"손사용|시각|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"플라이캠촬영기사, 드론촬영기사, 헬리캠촬영기사","connectJob":"무인항공기조종사, 방송촬영감독, 영화촬영감독","certLic":"초경량비행장치 조종사","dJobECd":"4164","dJobECdNm":"[4164]촬영 기사","dJobJCd":"2834","dJobJCdNm":"[2834]촬영기사","dJobICd":"J591/J602","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업 / [J602]텔레비전 방송업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004222:1', '{"dJobCd":"K000004222","dJobCdSeq":"1","dJobNm":"수중촬영기사","workSum":"수중촬영장비를 사용하여 수중촬영을 한다.","doWork":"물속에서 행하는 영화 촬영을 위하여 방수 카메라와 특수 렌즈, 특수 조명을 운용한다. 수중에서 카메라와 피사체 사이에 물결로 인한 해상도 저하 현상 및 수중촬영의 특수한 상황을 기술적으로 해결한다. 수심이 깊은 곳에서의 조명을 위해 배터리를 장착한 개별 램프를 사용한다. 접사 장면을 위해서는 수면 위의 발전기에 케이블을 연결하여 여러 대의 램프를 사용하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|시각|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"수중시네마토그래퍼(Underwater Cinematographer), 수중촬영감독","dJobECd":"4164","dJobECdNm":"[4164]촬영 기사","dJobJCd":"2834","dJobJCdNm":"[2834]촬영기사","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005725:1', '{"dJobCd":"K000005725","dJobCdSeq":"1","dJobNm":"스테디캠기사","workSum":"카메라를 들고 찍을 때 카메라가 흔들리는 것을 방지해 주는 신체부착용 특수받침대인 스테디캠(Steadicam)을 착용하고 촬영한다.","doWork":"베스트(Vest:사용자의 상체에 착용하는 조끼로 스테디캠 장비를 지지하는 두꺼운 천과 가죽, 알루미늄 부착물로 구성되어 있음), 암(Arm:스테디캠과 베스트를 연결하는 장치로 2개의 암으로 구성되어 있으며 진동과 떨림을 방지하는 스프링이 내장되어 있음), 슬레드(Sled:카메라와 모니터를 장착하는 장치로 밸런스 조정장치가 부착되어 있음) 등으로 구성된 스테디캠 장비와 카메라를 조립한다. 계단이나 골목, 군중 속 추적 장면 등에서 일반 카메라로는 촬영할 수 없는 유연하고 안정된 카메라 움직임을 만들어내기 위해 스테디캠을 착용하여 촬영한다. 걷거나 뛰거나 보조이동장치(세그웨이, 크레인, 전기차 등)를 사용하여 이동하며 촬영한다. 영상 장면의 흔들림을 방지하기 위해 무선 장치를 사용하여 포커스 조절을 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"균형감각|청각|손사용|언어력|시각|","workFunc1":"조정","workFunc2":"협의","workFunc3":"정밀작업","similarNm":"스테디캠오퍼레이터(Steadicam Operator)","dJobECd":"4164","dJobECdNm":"[4164]촬영 기사","dJobJCd":"2834","dJobJCdNm":"[2834]촬영기사","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002152:1', '{"dJobCd":"K000002152","dJobCdSeq":"1","dJobNm":"영화편집기사","workSum":"촬영된 영상을 재구성하여 편집한다.","doWork":"시나리오를 확인하고 영화촬영 시에 작성한 촬영기록을 검토한다. 영화감독과 협의하여 영화의 목적에 맞게 편집 방향을 설정한다. 영화감독과 협의하여 본 편집을 한 후 최종적으로 편집한다. 컴퓨터그래픽(CG) 영상효과, 자막 등을 삽입한다. 편집결과를 최종 확인하고 검토하여 필요시 수정한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"협의","workFunc3":"제어조작","connectJob":"영화현장편집기사","dJobECd":"4164","dJobECdNm":"[4164]촬영 기사","dJobJCd":"2834","dJobJCdNm":"[2834]촬영기사","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007543:1', '{"dJobCd":"K000007543","dJobCdSeq":"1","dJobNm":"촬영기사","workSum":"방송, 영화 등의 영상물을 제작하기 위해 카메라 등 촬영장비를 사용하여 각종 물체나 대상을 촬영한다.","doWork":"촬영감독, 취재기자 등과 협의하여 촬영 또는 취재 목적에 적합하게 화면의 배열을 결정한다. 방송프로듀서(방송연출가) 또는 촬영감독의 지시에 따라 화면의 노출조절, 촬영대상과 카메라의 움직임, 촬영대상과의 거리변경, 기타 제반 문제점들을 고려하여 촬영대상을 촬영한다. 촬영이 완료되면 필름에 촬영일시 및 장면 등을 기록한다. 촬영장비를 점검하고 파손된 장비를 수리하기도 한다. 촬영이 끝난 필름을 방송연출가 또는 편집기사와 함께 편집하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"시각|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"카메라맨","connectJob":"뉴스기사의 취재를 위해 인물이나 사건사고 현장을 취재하는 경우 카메라기자, 보도카메라맨, 작품을 촬영하는 활동범위에 따라 영화촬영기사, 방송카메라촬영기사, 사용하는 카메라의 종류에 따라 ENG카메라맨, 스튜디오카메라맨, 그립장(key grip), 그립(grip)","dJobECd":"4164","dJobECdNm":"[4164]촬영 기사","dJobJCd":"2834","dJobJCdNm":"[2834]촬영기사","dJobICd":"J591/J602","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업 / [J602]텔레비전 방송업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002892:1', '{"dJobCd":"K000002892","dJobCdSeq":"1","dJobNm":"게임음향기술자","workSum":"컴퓨터게임 등을 보다 즐겁고 현실감 있게 만들기 위해서 오프닝음악, 배경음악, 효과음 등을 만든다.","doWork":"게임시나리오와 그래픽을 고려하여 기본적인 사운드 콘셉트를 설정한다. 게임 콘셉트에 맞춰 컴퓨터와 사운드디자인 소프트웨어 프로그램을 이용하여 게임음악을 작곡하고 편곡한다. 음악을 녹음하고 마스터링한 후 게임에 직접 적용한다. 성우들의 녹음을 지휘하고 편집한다. 사운드 수와 길이를 고려하여 효과음을 제작한다. 제작자들과 회의를 거쳐 수정한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"청각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"게임사운드크리에이터, 사운드크리에이터, 뮤직컴포저","dJobECd":"4165","dJobECdNm":"[4165]음향·녹음 기사","dJobJCd":"2835","dJobJCdNm":"[2835]음향 및 녹음 기사","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005457:1', '{"dJobCd":"K000005457","dJobCdSeq":"1","dJobNm":"녹음기사","workSum":"녹음장비를 이용하여 영화, 드라마, 음반 등의 제작에 사용되는 소리, 음악, 목소리 등을 녹음한다.","doWork":"영화감독, 녹음기획자 및 음반기획자 등과 함께 녹음해야 할 대상, 대본 등을 확인하고 녹음 절차 및 방법 등을 논의한다. 녹음기 및 녹음장비를 조작하여 녹음할 대상을 각각 녹음한다. 믹싱장비(믹서)를 조작하여 각기 녹음된 대사, 음악, 효과음 등을 믹싱하거나 노래, 악기 연주음 등의 트랙을 믹싱하여 하나의 소리로 통합한다. 완성된 녹음내용을 수정하여 DAT(Digital Audio Tape), CD나 파일로 저장한다. 촬영된 필름에 배우들의 대사, 음향효과, 음악 등을 믹싱하는 업무를 전문으로 하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"청각|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"녹음엔지니어","connectJob":"믹싱만 전문적으로 하는 경우 믹싱엔지니어, 영화 후반 녹음을 전문적으로 하는 경우 영화녹음기사","dJobECd":"4165","dJobECdNm":"[4165]음향·녹음 기사","dJobJCd":"2835","dJobJCdNm":"[2835]음향 및 녹음 기사","dJobICd":"J591/J602","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업 / [J602]텔레비전 방송업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001744:1', '{"dJobCd":"K000001744","dJobCdSeq":"1","dJobNm":"녹음기획자","workSum":"학습교재, 음반, 홍보영상물 등을 만들기 위해 대본 작성, 참여자(성우 등) 섭외 등의 기획업무와 녹음연출을 한다.","doWork":"녹음을 의뢰한 고객과 녹음 방향, 절차, 내용 등을 협의하고, 대본을 작성한다. 녹음에 참여할 인력(성우 등)을 섭외한다. 대본을 토대로 녹음기사와 녹음 순서, 절차 등을 협의한다. 대본에 맞추어 녹음기사와 녹음참여 인력에게 지시한다. 녹음에 필요한 음악을 선정한다. 녹음기획 충족 여부, 녹음의 질 등을 검토하여 녹음기사에게 수정을 지시한다. 최종 완성된 녹음내용을 의뢰한 고객에게 송부하며 수정 부분이나 문제점 등을 협의한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"청각|","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"녹음디렉터","dJobECd":"4165","dJobECdNm":"[4165]음향·녹음 기사","dJobJCd":"2835","dJobJCdNm":"[2835]음향 및 녹음 기사","dJobICd":"J592","dJobICdNm":"[J592]오디오물 출판 및 원판 녹음업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005997:1', '{"dJobCd":"K000005997","dJobCdSeq":"1","dJobNm":"동시녹음기사","workSum":"영화나 드라마 제작현장에서 배우의 대사, 주변 소리 등을 녹음한다.","doWork":"시나리오를 읽고 장면, 등장인물의 성격, 배우의 특징 등을 파악하고 분석한다. 시나리오 및 콘티를 검토하고 영화감독, 방송프로듀서(방송연출가) 등과 함께 제작현장 녹음을 위한 계획과 촬영과정에 대해 논의한다. 현장의 주변 상황을 살펴본 후 흡음재, 붐마이크 및 와이어리스마이크 사용 여부를 결정한다. 녹음장비를 이용하여 배우들의 대화 및 현장 주변의 소리를 녹음한다. 촬영이 종료된 후 배경소리를 따로 녹음하기도 한다. 녹음이 끝나면 녹음기록장에 녹음과 관련된 내용을 기록한다. 현장녹음 관련 종사원들의 업무를 감독·조정한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"청각|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"현장녹음기사","connectJob":"붐마이크를 운용하는 경우 붐오퍼레이터","dJobECd":"4165","dJobECdNm":"[4165]음향·녹음 기사","dJobJCd":"2835","dJobJCdNm":"[2835]음향 및 녹음 기사","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004437:1', '{"dJobCd":"K000004437","dJobCdSeq":"1","dJobNm":"비디오표준테이프제작원","workSum":"비디오 제조공정에 사용되는 표준테이프를 제작하고 장비의 조정·보수·정비 업무를 수행한다.","doWork":"표준테이프제작기, 오실로스코프 등 일반 신호장비와 계측장비를 사용하여 표준테이프 제작기에 기록된 음향·영상신호를 일정수준으로 유지·조정하여 표준테이프를 제작한다. 제작기를 수리·보수하고 표준테이프에 대한 문제점이 발생하면 원인을 분석하여 해결한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"4165","dJobECdNm":"[4165]음향·녹음 기사","dJobJCd":"2835","dJobJCdNm":"[2835]음향 및 녹음 기사","dJobICd":"C182","dJobICdNm":"[C182]기록매체 복제업","inqYear":"2011","etc":"소멸(국내에서 비디오테이프 생산 중단, CD 및 DVD대체)"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003530:1', '{"dJobCd":"K000003530","dJobCdSeq":"1","dJobNm":"음반마스터링기사","workSum":"음반 제작을 위해 마스터링 장비를 이용하여 최종적으로 트랙의 음량을 조정한다.","doWork":"믹싱이 완성되어 DAT(Digital Audio Tape), CD 및 파일로 저장된 트랙을 듣고 각 트랙의 음량을 파악한다. 마스터링 장비를 조정하여 노래의 분위기에 맞게 앨범 전체 및 개별 곡에 따라 볼륨을 일정하게 조정한다. 곡을 보완하기 위해 컴프레서(Compressor:압축기), 이퀄라이저(EQ: Equalizer, 노래의 높은음 강조 장치), 이펙터(특수 소리 효과장치) 등을 이용하여 조정한다. 오래된 음반의 잡음을 제거하여 재마스터링하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"청각|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"음반믹싱엔지니어, 레코딩엔지니어","dJobECd":"4165","dJobECdNm":"[4165]음향·녹음 기사","dJobJCd":"2835","dJobJCdNm":"[2835]음향 및 녹음 기사","dJobICd":"C182","dJobICdNm":"[C182]기록매체 복제업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002927:1', '{"dJobCd":"K000002927","dJobCdSeq":"1","dJobNm":"음반마스터파일제작원","workSum":"CD, DVD와 같은 음반을 대량 복제하기 위하여 마스터링(Mastering) 또는 오소링(Authoring:자막, 언어선택 등 DVD에 텍스트와 그래픽 및 오디오 데이터를 구현하여 DVD 초기실행 메뉴를 제작) 작업을 한다.","doWork":"CD, DVD를 제작하기 위하여 마스터파일(원본파일)을 수령한다. 녹음기, 믹서, 마스터링프로그램을 사용하여 볼륨값을 조정하고 주파수 대역을 조절한다. 마스터링 파일에 잡음이 있는 경우 제거하기도 하고 곡과 곡 사이의 간격이 적절치 않은 경우 조정하기도 한다. CD, DVD의 저장용량을 초과하는 경우 파일을 분할하여 여러 장으로 제작할 수 있도록 한다. DVD의 경우 원본파일을 DVD포맷에 맞게 변환 편집하는 오소링(Authoring) 작업을 하기도 한다. 완료된 파일을 검사하여 이상이 없으면 대량복제를 위하여 스템퍼(Stamper)를 제작하는 공정으로 이동한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"청각|시각|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"4165","dJobECdNm":"[4165]음향·녹음 기사","dJobJCd":"2835","dJobJCdNm":"[2835]음향 및 녹음 기사","dJobICd":"C182","dJobICdNm":"[C182]기록매체 복제업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004486:1', '{"dJobCd":"K000004486","dJobCdSeq":"1","dJobNm":"음향기사","workSum":"음향감독의 감독하에 마이크를 순서대로 배치하고 음향상태를 조정한다.","doWork":"음향감독과 프로그램에 따른 적합한 음향시스템을 구성하고, 마이크 배치에 대하여 협의한다. 음향감독의 지시에 따라 음향기기를 준비 및 배치하고 점검한다. 악기별로 마이크를 세팅한다. 출연자들의 마이크를 운용하며 움직임에 따라 마이크의 위치를 조절한다. 스튜디오 확성 시스템을 구상한다. 무대와 객석의 확성을 담당한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"시각|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"마이크맨, 오디오맨, PA엔지니어, 음향엔지니어","dJobECd":"4165","dJobECdNm":"[4165]음향·녹음 기사","dJobJCd":"2835","dJobJCdNm":"[2835]음향 및 녹음 기사","dJobICd":"J591/J601/J602","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업 / [J601]라디오 방송업 / [J602]텔레비전 방송업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001883:1', '{"dJobCd":"K000001883","dJobCdSeq":"1","dJobNm":"음향믹싱기사","workSum":"영화 또는 방송드라마를 제작하기 위하여 녹음이 완료된 각 부문의 음원을 재생하여 균형을 맞추고 조정하여 마스터음원을 만든다.","doWork":"방송프로듀서(방송연출가) 또는 영화감독과 협의하며, 영화음악, 대사, 생 효과음향, 효과음향이 완료된 음원을 재생기로 재생한다. 콘솔(Console)을 조작하여 각 부분의 균형을 맞추고 최종적으로 녹음기를 사용하여 마스터음원을 만든다. 각종 음향장비와 음악창작도구를 사용하여 효과음향 등을 수정하기도 한다. 작업이 완료된 마스터음원을 현상소(영상과 음향을 필름 또는 디지털파일로 합치는 곳)에 보낸다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"청각|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"믹서(Mixer)","dJobECd":"4165","dJobECdNm":"[4165]음향·녹음 기사","dJobJCd":"2835","dJobJCdNm":"[2835]음향 및 녹음 기사","dJobICd":"J591/J601/J602","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업 / [J601]라디오 방송업 / [J602]텔레비전 방송업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006113:1', '{"dJobCd":"K000006113","dJobCdSeq":"1","dJobNm":"효과음향기사","workSum":"방송드라마, 다큐멘터리, 영화 등에서 소리에 대한 실재감을 부여하기 위해 효과음을 선정하고 제작한다.","doWork":"대본(시나리오)을 검토한 후 대포소리, 말 달리는 소리, 눈 밟는 소리 등 음향효과가 필요한 장면을 확인한다. 적합한 음향효과 계획을 수립하고 방송프로듀서(방송연출가) 또는 영화감독, 음향감독, 음악감독 등과 협의한다. 녹음되어 있는 음향효과 리스트를 확인 및 선별한다. 편집에 참여하여 음향효과 장비를 조작한다. 여러 물건이나 재료를 사용하여 천둥, 발자국 소리 등을 연출하여 CD, 멀티트랙터레코더 등에 녹음한다. 야외에서 자연에 관련된 소리를 녹음하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"청각|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"폴리아티스트, 음향효과기사","dJobECd":"4165","dJobECdNm":"[4165]음향·녹음 기사","dJobJCd":"2835","dJobJCdNm":"[2835]음향 및 녹음 기사","dJobICd":"J591/J601/J602","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업 / [J601]라디오 방송업 / [J602]텔레비전 방송업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004534:1', '{"dJobCd":"K000004534","dJobCdSeq":"1","dJobNm":"휴대전화벨소리제작자","workSum":"기존의 음악을 선정하거나 직접 작곡하여 휴대전화 벨소리를 제작한다.","doWork":"국내외 다양한 음악을 듣고 벨소리로 제작할 음악을 선정하거나, 휴대전화 벨소리에 적합한 곡을 구상하여 작곡한다. 벨소리로 제작할 부분을 선택하고, 건반 또는 마우스를 사용하여 음악 프로그램에 악보를 작성한다. 다양한 연주효과를 얻기 위해 음을 합성한다. 컴퓨터에 입력한 미디(MIDI)파일을 벨소리 변환 툴(Tool)을 사용하여 단말기의 음원 칩에 맞게 편집한다. 단말기의 특성을고려하여 음원 및 제한용량에 알맞게 제작되었는지 폰테스트를 한다. 음성벨 제작 시 벨소리로 제작할 음성을 원음 그대로 녹음하여 변환작업을 한다. 라이브벨 제작 시 기존의 원음을 그대로 변환한 후 완성한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"청각|손사용|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"벨소리작곡가, 벨소리PD, 모바일사운드디자이너","dJobECd":"4165","dJobECdNm":"[4165]음향·녹음 기사","dJobJCd":"2835","dJobJCdNm":"[2835]음향 및 녹음 기사","dJobICd":"J639","dJobICdNm":"[J639]기타 정보 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007128:1', '{"dJobCd":"K000007128","dJobCdSeq":"1","dJobNm":"DCP기사","workSum":"디지털로 제작된 콘텐츠를 극장 상영 포맷으로 변환하는 DCP(Digital Cinema Package)작업을 수행한다.","doWork":"콘텐츠의 용도 및 목적, 고객사의 요구사양 및 상영관의 인프라(스크린 크기 등)에 맞춰 영상의 형식, 해상도, 대역폭, 색 공간, 영상 및 오디오 Codec, 자막형식 등을 결정한다. 촬영된 콘텐츠의 Raw파일을 압축하기 위해 코덱을 설정하여 인코딩한다. 인코딩된 영상 및 음성 파일을 DCP(Digital Cinema Package)로 제작한다. 자막이 필요한 경우 가독성을 고려하여 자막을 크기를 결정하고 영상과의 동기화하여 자막을 제작한다. 제작된 자막은 DCP와 같이 배포한다. 저작권 보호를 위해 상영관의 특정 상영서버에서만 일정기간 상영이 가능하도록 암호화하여 파일을 관리하고 상영 시 복호화를 위한 보안 키 파일(KDM: Key Develivery Message)을 발행한다. 각 작업단계별로 검수작업을 실시하고 제작된 DCP는 최종적으로 상영관에서 테스트한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"청각|손사용|시각|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"디지털콘텐츠파일전문가, 스크리닝매니저, DCP매니저, DCP코디네이터, 영상콘텐츠인코딩기사, 마스터링기사","dJobECd":"4166","dJobECdNm":"[4166]영상·녹화·편집 기사","dJobJCd":"2836","dJobJCdNm":"[2836]영상·녹화 및 편집 기사","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004399:1', '{"dJobCd":"K000004399","dJobCdSeq":"1","dJobNm":"녹화기사","workSum":"텔레비전 방송의 영상신호와 음향신호를 미디어(테이프, 하드디스크)에 수록하고 재생하는 녹화기를 조작한다.","doWork":"카메라에 연결된 선로를 확인하고 녹화기의 가동상태를 확인한다. 녹화기를 조작하여 방송프로그램의 영상 및 음향신호를 저장미디어(테이프, 하드디스크, CD 등)에 수록한다. 영상의 구도 및 조명 등을 확인하기 위하여 모니터(Monitor)를 검토하고 잡음, 화면 떨림 등의 장애 원인을 제거한다. 편집기를 조작하여 방송시간에 맞도록 프로그램의 화면과 음향을 재편집하기도 하며 기기의 작동상태를 점검하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"청각|시각|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"4166","dJobECdNm":"[4166]영상·녹화·편집 기사","dJobJCd":"2836","dJobJCdNm":"[2836]영상·녹화 및 편집 기사","dJobICd":"J602","dJobICdNm":"[J602]텔레비전 방송업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003645:1', '{"dJobCd":"K000003645","dJobCdSeq":"1","dJobNm":"디지털색보정원","workSum":"촬영된 필름을 디지털로 스캐닝한 영상에 전반적인 색감이나, 특정 장면에 대한 톤을 감독이 원하는 방향으로 수정한다.","doWork":"촬영된 필름을 스캐닝하여 디지털화된 이미지로 변환한다. 촬영감독과 협업을 통해 색보정 작업을 한다. 편집된 영상을 분석하여 화이트밸런스를 확인하고 잘못된 영상의 화이트밸런스를 조절한다. 영상의 밝기를 조정하고 감독의 요구에 따라 밤 신을 낮 신으로 바꾸기도 한다. 전체적인 톤을 유지하기 위해 색을 조정하고 영상 품질 향상을 위해 노이즈 또는 픽셀이 깨진 부분을 수정한다. 가공된 소스를 순서에 맞춰 나열하거나 방송용 및 극장용 등 용도에 맞춰 데이터를 파일화하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"DI(Digital Intermediate)원","connectJob":"DCP(Digital Cinema Package:영상/음향/자막 등의 파일을 암호화하여 디지털 상영을 위해 상영관에 배포되는 DCP 파일을 만든다)기사","certLic":"컬러리스트산업기사, 컬러리스트기사","dJobECd":"4166","dJobECdNm":"[4166]영상·녹화·편집 기사","dJobJCd":"2836","dJobJCdNm":"[2836]영상·녹화 및 편집 기사","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006281:1', '{"dJobCd":"K000006281","dJobCdSeq":"1","dJobNm":"디지털영상처리전문가","workSum":"컴퓨터의 영상편집 툴을 이용하여 영상 이미지의 다양한 특수효과를 연출한다.","doWork":"디지털방식으로 촬영된 영상소스 및 아날로그 방식으로 촬영된 영상소스를 디지털 방식으로 변환하여 디지털 영상편집이 가능한 상태로 만든다. 컴퓨터 영상편집 프로그램을 사용하여 화면을 구성하고 영상을 고르게 하고 음향을 조절하는 작업을 수행한다. 편집계획에 따라 장면을 편집하고 특수효과(컴퓨터그래픽, 효과음, 자막 등)를 구현한다. 작업이 종료되면 렌더링하여 디지털파일로 저장한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내·외","physicalAct":"청각|시각|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"4166","dJobECdNm":"[4166]영상·녹화·편집 기사","dJobJCd":"2836","dJobJCdNm":"[2836]영상·녹화 및 편집 기사","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005335:1', '{"dJobCd":"K000005335","dJobCdSeq":"1","dJobNm":"방송가상스튜디오엔지니어","workSum":"가상스튜디오(Virtual Studio:실제 세트의 실사 화면에 컴퓨터 그래픽으로 만들어낸 가상의 세트) 기술을 활용하여 프로그램을 제작한다.","doWork":"프로그램 대본에 따라 가상스튜디오 제작 소프트웨어상에서 가상세트를 제작한다. 방송 진행자가 크로마키 스튜디오(청색 또는 녹색으로 만들어진 공간)에서 촬영을 하면 촬영된 영상과 컴퓨터 그래픽에서 만들어진 가상세트를 조합하여 실제 세트에서 방송이 진행되는 것과 같은 영상을 만든다. 애니메이션으로 만들어진 동영상, 생방송, 특수 영상효과 등을 활용하여 가상세트 상에서 나타내기도 한다. 제작하는 프로그램에 따라 일기예보, 선거방송, 중계방송 등 다양한 프로그램을 제작한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"4166","dJobECdNm":"[4166]영상·녹화·편집 기사","dJobJCd":"2836","dJobJCdNm":"[2836]영상·녹화 및 편집 기사","dJobICd":"J591/J602","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업 / [J602]텔레비전 방송업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005696:1', '{"dJobCd":"K000005696","dJobCdSeq":"1","dJobNm":"방송인제스트원","workSum":"방송영상 콘텐츠를 디지털 스트림의 형태로 변환해서 콘텐츠관리시스템(디지털 아카이브)에 등록한다.","doWork":"취재, 리포트, 스튜디오 촬영 등을 통해 만들어진 방송영상 콘텐츠를 접수한다. 인제스트 시스템에 테이프, 메모리 등의 원본 소스를 삽입하고 메타데이터를 입력한다. 등록 버튼을 눌러 디지털 스트림 파일을 만든다. 카탈로그 시스템(자동으로 영상을 분석해 장면 전환을 검출하고 키프레임을 추출해 검출된 장면에 대한 정보를 콘텐츠 관리 시스템에 등록), 콘텐츠 등록 시스템(문서, 그림, 시퀀스 이미지 등 다양한 자료를 서버에 등록하는 프로그램)을 사용하여 콘텐츠관리시스템(디지털아카이브 시스템:Digital Archive System, 영상이 담고 있는 세부적인 내용과 정보를 디지털화해 보관 및 관리하는 방송시스템)에 콘텐츠를 등록한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"인버터요원","dJobECd":"4166","dJobECdNm":"[4166]영상·녹화·편집 기사","dJobJCd":"2836","dJobJCdNm":"[2836]영상·녹화 및 편집 기사","dJobICd":"J591/J602","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업 / [J602]텔레비전 방송업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003236:1', '{"dJobCd":"K000003236","dJobCdSeq":"1","dJobNm":"방송편집기사","workSum":"방송프로그램의 특성에 맞게 촬영한 영상물을 재구성하여 편집한다.","doWork":"방송대본을 검토하여 전체적인 분위기 및 흐름을 파악하고 방송프로듀서(방송연출가)와 협의하여 편집방향을 결정한다. 촬영이 끝난 비디오테이프이나 메모리카드를 편집장비에 삽입시켜 영상을 관찰한다. 음악, 음향, CG(영상특수효과, 자막 등) 등 관련 분야의 담당자와 편집에 대하여 협의한다. 각각 녹음·녹화되어 있는 음악, 효과음, 특수효과 등을 하나로 종합한 후 색을 보정한다. 완성된 영상을 비디오테이프나 디지털 메모리장치에 녹화한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"편집감독","dJobECd":"4166","dJobECdNm":"[4166]영상·녹화·편집 기사","dJobJCd":"2836","dJobJCdNm":"[2836]영상·녹화 및 편집 기사","dJobICd":"J602","dJobICdNm":"[J602]텔레비전 방송업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002777:1', '{"dJobCd":"K000002777","dJobCdSeq":"1","dJobNm":"색보정기사","workSum":"색보정기를 조작하여 현상된 네거필름(negative film)의 색을 보정한다.","doWork":"러시필름(촬영 후 편집이 안 된 필름)을 제작하기 위하여 현상된 네거필름을 색보정기에 장착한다. 색보정기를 조작하여 모니터상에 나오는 영상의 색도를 조정한다. 색보정을 위해 편집이 끝난 필름을 육안으로 검사하거나 클리닝 기계를 이용하여 필름의 잡티를 제거한다. 수차례 수정작업을 거쳐 색을 재보정한다. 텔레시네(telecene: 필름에서 텔레시네 장치를 거쳐 비디오테이프로 전환) 작업을 수행할 수 있도록 리드를 잘라내고 필름을 연결한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"4166","dJobECdNm":"[4166]영상·녹화·편집 기사","dJobJCd":"2836","dJobJCdNm":"[2836]영상·녹화 및 편집 기사","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004604:1', '{"dJobCd":"K000004604","dJobCdSeq":"1","dJobNm":"웹방송엔지니어","workSum":"디지털 장비를 이용해 촬영 혹은 녹음을 하고, 웹방송 가능 형태로 파일을 편집하며, 인코딩한다.","doWork":"디지털 장비를 이용해 촬영 혹은 녹음한다. 촬영 혹은 녹음된 파일을 방송에 적합한 형태로 편집한다. 효과음과 배경음을 컴퓨터로 믹싱한다. 편집된 파일을 배포 가능 형태로 인코딩한다. 신규 방송용 장비를 도입하고 관리한다. 업계의 신기술 동향을 파악하고 연구한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"시각|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"4166","dJobECdNm":"[4166]영상·녹화·편집 기사","dJobJCd":"2836","dJobJCdNm":"[2836]영상·녹화 및 편집 기사","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002606:1', '{"dJobCd":"K000002606","dJobCdSeq":"1","dJobNm":"입체영상콘텐츠개발자","workSum":"3D입체영상기술(3D Stereoscopy)을 활용하여 다양한 3D입체영상 콘텐츠를 개발한다.","doWork":"3D입체영상 콘텐츠의 전반적인 과정에 참여하여 기획자, 연출가, 촬영기사, 편집기사 등과 협의하고 3D입체영상기술을 효율적으로 활용할 수 있도록 기술적인 조언을 한다. 편광렌즈를 사용하는 방법, 시간적으로 연상을 분할하는 방법, 눈의 초점을 흩트리는 방법 등 각종 3D입체영상기법과 기타 컴퓨터그래픽기술을 사용하여 입체영상을 구현한다. 영상제작 초기에 3D입체영상카메라로 촬영되지 않은 2D 정지 영상(Image)이나 동영상(Video) 데이터를 3D입체영상으로 재구성하기도 한다. 입체음향을 구현하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"청각|시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"입체영상연출가, 입체영상촬영기사, 입체영상편집자, 입체영상기획자, 입체영상테크니컬디렉터, 스테레오그래퍼","dJobECd":"4166","dJobECdNm":"[4166]영상·녹화·편집 기사","dJobJCd":"2836","dJobJCdNm":"[2836]영상·녹화 및 편집 기사","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002449:1', '{"dJobCd":"K000002449","dJobCdSeq":"1","dJobNm":"텔레시네마기사","workSum":"영상물을 아날로그에서 디지털로 또는 디지털에서 아날로그 방식으로 변환하여 영화관, TV, 인터넷 등에서 상영이 가능한 방식으로 만든다.<BR/><BR/>.","doWork":"네거티브 현상이 완료된 필름을 수령한다. 필름의 종류(8mm, 16mm, 36mm, 70mm)와 수량, 길이 등을 확인하고 아웃풋 소스의 종류(Beta Cam SP, Digi-Bata Tap, DVD, VHS Tape, H-dv Tape, HD-Tape, U-Matic Tape)를 확인하여 작업계획을 수립한다. 텔레시네 장비를 사용하여 필름을 스캔하고 색보정(color correction)작업 및 노출 과·부족 상태의 보정 작업을 진행하여 아웃풋 소스를 제작한다. 영화제작과정 중에 미리 비디오시스템으로 사전 편집을 하거나 필름을 비디오 상태로 확인하기도 한다. 광고, 드라마, 오락물, 기업홍보물, 뮤직비디오, 각종 영상교재 등의 영상물이 비디오카메라(가정용 홈비디오, ENG카메라 등)로 제작된 경우 필름의 형태로 전환하는 작업(디지털을 아날로그로 변환)을 하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"Telecine Colorist","connectJob":"전문분야에 따라 키네코기사, 텔레싱기사","dJobECd":"4166","dJobECdNm":"[4166]영상·녹화·편집 기사","dJobJCd":"2836","dJobJCdNm":"[2836]영상·녹화 및 편집 기사","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005572:1', '{"dJobCd":"K000005572","dJobCdSeq":"1","dJobNm":"현장편집기사","workSum":"영화 제작현장에서 녹화한 필름을 즉시 확인하여 컷을 붙이고 자르는 등의 편집을 한다.","doWork":"시나리오 검토 후 영화감독과 촬영 방향 및 콘티에 대해서 논의한다. 제작 현장에서 각 장면의 녹화가 끝나면 신속하게 편집소프트웨어를 이용해 각 컷을 순서대로 붙인다. 자연스러운 장면 연결을 위해 장면의 전환, 배우들의 의상 및 분장 등이 일관적이고 통일성이 있는지 확인한다. 영화감독과 함께 부족한 장면이 있는지 검토한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"청각|손사용|시각|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"4166","dJobECdNm":"[4166]영상·녹화·편집 기사","dJobJCd":"2836","dJobJCdNm":"[2836]영상·녹화 및 편집 기사","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002157:1', '{"dJobCd":"K000002157","dJobCdSeq":"1","dJobNm":"레이저공연기사","workSum":"유원지 내에서 레이저 장비를 이용하여 쇼를 구성하고 고객들에게 볼거리를 제공한다.","doWork":"레이저 공연 전에 공연 계획을 구상한다. 레이저 빔 프로젝트의 동작 여부를 수시로 검사하고 이상 발견 시 수리를 의뢰한다. 음향기사와의 협조 하에 레이저와 음향기능이 조화를 잘 이룰 수 있도록 조작하여 공연의 완성도를 높인다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"청각|시각|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"4167","dJobECdNm":"[4167]조명·영사 기사","dJobJCd":"2837","dJobJCdNm":"[2837]조명기사 및 영사기사","dJobICd":"R912","dJobICdNm":"[R912]유원지 및 기타 오락관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005361:1', '{"dJobCd":"K000005361","dJobCdSeq":"1","dJobNm":"영사기사","workSum":"영화를 상영하기 위하여 상영본 파일을 입력해서 화질, 음향 등을 점검하고, 상영 시에는 모니터링을 하며 영사기, 음향장비, 스피커, 영화관리시스템(TMS) 등을 유지·보수·관리한다.","doWork":"DCP(Digital Cinema Package) 상영본을 서버에 입력한다. 인제스트(Ingest:상영본을 서버에 입력)가 잘 되는지 확인하고, 문제가 있으면 파일을 새로 받거나 기술적 결함을 처리한다. 파일의 포맷(DCP, HD, HDV 등)을 확인한다. 인제스트가 완료되면 상영 정보와 상영본이 일치하는지 대조하고, 영사 테스트를 실시한다. 타임코드(TC)와 프레임 레이트, 화면비, 사운드, 자막 등을 확인한다. 영화관에서 요구되는 스케줄에 따라, SPL(Show Play List)를 만든다. 영화 상영 시 수시로 모니터링하여 필요시 조치한다. 정기점검을 실시하여 디지털영사기, 음향장비, 스피커, 영화관리시스템(TMS) 등 관련 장비를 유지·보수·관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"영사기능사, 영사산업기사","dJobECd":"4167","dJobECdNm":"[4167]조명·영사 기사","dJobJCd":"2837","dJobJCdNm":"[2837]조명기사 및 영사기사","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007473:1', '{"dJobCd":"K000007473","dJobCdSeq":"1","dJobNm":"조명기사","workSum":"조명감독의 지시하에 조명기구를 설치하고 콘솔(조명조정탁) 운용을 돕는다.","doWork":"프로그램의 분위기에 맞는 조명연출을 위하여 조명감독과 협의한다. 조명감독의 지시하에 플랫라이트, 스포트라이트, 이펙트라이트 등의 조명기구를 설치하고 운용한다. 공연 또는 촬영 중에 조명감독의 지시에 따라 콘솔을 조작한다. 작업이 종결된 후 설치된 조명을 철거한다. 컬러필터, 램프, 케이블 등의 관련 장비 및 조명기구를 정비 및 관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"시각|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"LO(Lighting Operator)","connectJob":"출연자의 움직임에 따라 움직이는 핀조명을 전문적으로 조작하는 경우 핀조명원(follow spot operator), 조명프로그래머, 조명크루","certLic":"무대예술전문인(조명)","dJobECd":"4167","dJobECdNm":"[4167]조명·영사 기사","dJobJCd":"2837","dJobJCdNm":"[2837]조명기사 및 영사기사","dJobICd":"J591/J602","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업 / [J602]텔레비전 방송업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007124:1', '{"dJobCd":"K000007124","dJobCdSeq":"1","dJobNm":"CFX아티스트","workSum":"여러 유형의 프로젝트에서 옷감, 머리카락, 털, 깃털뿐만 아니라 근육 및 피부 변형을 시뮬레이션하고 스토리의 목적에 맞는지 확인하여 캐릭터와 주변 환경을 연결한다.","doWork":"콘셉트 디자인을 이해하고 최초 디자인된 캐릭터에서 시뮬레이션에 문제가 없는지 확인하고 결정한다. 머리카락, 털 등이 시뮬레이션에 적합하고 문제가 없는지 렌더링을 통해 확인하고 그루밍(Grooming)아티스트에게 피드백한다. 모델링과 그루밍 작업이 끝나면 시뮬레이션 셋업, 마스터 파일 셋업을 진행한다. 마스터 셋업 후 애니메이션이 완료되면 각 신(Scene)의 시뮬레이션 작업을 한다. 신의 시뮬레이션이 완료되면 필요에 따라 문제 해결과 디테일을 살리기 위한 디포메이션 작업을 진행하기도 한다. 모든 시뮬레이션과 디포메이션 작업이 완료되면 각 캐릭터별 랜더링에 필요한 캐시 파일을 출력하고 랜더링 팀에 전달한다. 랜더링 시에 CFX의 문제가 발생하면 수정 및 보완 작업을 진행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"VFX아티스트, 애니메이션리깅원, 그루밍(grooming)아티스트","dJobECd":"4169","dJobECdNm":"[4169]기타 연극·영화·방송 종사원","dJobJCd":"2839","dJobJCdNm":"[2839]기타 연극·영화 및 영상 관련 종사원","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004917:1', '{"dJobCd":"K000004917","dJobCdSeq":"1","dJobNm":"VFX아티스트(일반)","workSum":"소프트웨어를 이용하여 영화, 게임 등 영상물의 모델링, 텍스쳐, 리깅, 라이팅, 합성 등 시각효과를 담당한다.","doWork":"영화를 여러 가지 테크닉과 감성으로 시각화시킨다. 시나리오, 스토리보드, 컨셉아트를 기반으로 모델을 디자인한다. 콘셉트를 시각화하기 위하여 형태감과 레이아웃을 살려 모델링한다. 모델링한 대상에 질감이나 색을 입히는 텍스쳐 작업을 한다. 움직임을 주기 위하여 컨트롤러를 제작한다. 프레임별 움직임, 모션캡처, 군중의 움직임 등 애니메이션 작업을 한다. 빛의 고도와 움직임을 구현하기 위하여 렌더링/라이팅 작업을 한다. 연기, 불, 물, 폭파 등 각종 시각효과 작업을 한다. 작업한 시각효과 이미지를 배경 및 실사 화면 등 각 레이어를 합성하고 움직임을 매칭시키고 수정한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"제어조작","connectJob":"VFX모델링아티스트, VFX리깅아티스트, VFX애니메이션아티스트, VFX매치무브아티스트, FX아티스트, VFX라이팅아티스트, VFX합성아티스트","dJobECd":"4169","dJobECdNm":"[4169]기타 연극·영화·방송 종사원","dJobJCd":"2839","dJobJCdNm":"[2839]기타 연극·영화 및 영상 관련 종사원","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007125:1', '{"dJobCd":"K000007125","dJobCdSeq":"1","dJobNm":"공연(장)안전관리자","workSum":"공연제작에 관련된 지식과 경험을 활용하여 공연제작 및 공연에 대한 안전계획을 수립하고 안전관리를 실행한다.","doWork":"공연제작 안전계획을 수립하고 재해대책계획서의 작성 및 안전보건관리 관련 문서화 작업을 수행한다. 공연장 안전조직을 구성하고 공연자 및 스태프를 대상으로 안전교육 프로그램을 운영한다. 공연장 무대장치의 방염성능 관리, 전기시설 관리 등 공연장 위험성 평가를 진행한다. 무대장치장비 반입, 설치, 공연진행, 철거, 반출 시 안전하게 진행되도록 관리한다. 공연 전후 무대시설 및 기계장치의 하중, 구조물의 균형, 안전장치 등을 관리하고 평가한다. 이상 시 조치를 취하고 개선사항을 문서화한다. 공연이 안전하고 원활하게 진행될 수 있도록 방안을 제시하고 기술협의를 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","connectJob":"공연장안전관리자","certLic":"산업안전기사, 무대예술전문인자격증(기계 또는 조명)","dJobECd":"4169","dJobECdNm":"[4169]기타 연극·영화·방송 종사원","dJobJCd":"2839","dJobJCdNm":"[2839]기타 연극·영화 및 영상 관련 종사원","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006841:1', '{"dJobCd":"K000006841","dJobCdSeq":"1","dJobNm":"공연장안내원","workSum":"공연장에서 검표, 안내, 질서유지, 관람객 불편해결 등의 업무를 수행한다.","doWork":"객석안내, 입장권 검표 및 확인 등 원활한 공연진행을 위한 업무와 관객 안전을 관리한다. 공연장 질서유지 및 공연장 내외부 청결 상태 점검 및 시설을 관리한다. 고객 불편사항 해결 등 관객서비스 제공 및 현장 민원을 관리한다. 입퇴장 및 유보석 관리 등 기타 공연진행에 관련된 전반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"공연안내원, 하우스어셔","connectJob":"하우스매니저","dJobECd":"4169","dJobECdNm":"[4169]기타 연극·영화·방송 종사원","dJobJCd":"2839","dJobJCdNm":"[2839]기타 연극·영화 및 영상 관련 종사원","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002631:1', '{"dJobCd":"K000002631","dJobCdSeq":"1","dJobNm":"대역배우","workSum":"연극, 영화, 방송, 공연, 광고 등에서 배우가 하기 힘든 고난위도의 연기를 대신한다.","doWork":"각 장면에서 연출되는 특정 상황에 맞는 복장이나 분장을 한다. PD, 영화감독, 상업용영상물제작감독, 무대감독 등의 지시에 따라 연기를 한다. 영화배우나 연극배우, 탤런트, 광고모델 등을 대신하여 고공낙하, 액션연기, 춤, 수영, 스케이팅, 승마, 자동차 고속운전 등의 특수한 기술을 요하거나 위험한 역할을 대신 연기한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"오락제공","workFunc3":"관련없음","similarNm":"스턴트맨","dJobECd":"4169","dJobECdNm":"[4169]기타 연극·영화·방송 종사원","dJobJCd":"2839","dJobJCdNm":"[2839]기타 연극·영화 및 영상 관련 종사원","dJobICd":"J591/J602","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업 / [J602]텔레비전 방송업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005002:1', '{"dJobCd":"K000005002","dJobCdSeq":"1","dJobNm":"데이터매니저","workSum":"편집, 믹싱 및 상영을 위해 촬영 시 나오는 파일 형태의 영상, 음성 데이터를 백업 및 관리하고 컨버팅한다.","doWork":"카메라 및 오디오장비에서 발생한 데이터 파일을 관리하고 백업한다. 데이터가 온전히 받아졌는지 시스템(원본 데이터대로 검수) 및 매뉴얼(노이즈 등 이상 유무를 확인하며 검수)을 검수한다. 데이터의 재활용을 위해 장기적인 아카이브(Archive) 작업을 한다. 편집 및 믹싱 작업을 위하여 담당 부서에 데이터를 전달한다. 원활한 데이터 관리를 위하여 촬영 신, 컷, 테이크를 기록한다. 촬영현장에서 후편집을 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"데이터랭글러, 디지털로더","dJobECd":"4169","dJobECdNm":"[4169]기타 연극·영화·방송 종사원","dJobJCd":"2839","dJobJCdNm":"[2839]기타 연극·영화 및 영상 관련 종사원","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001894:1', '{"dJobCd":"K000001894","dJobCdSeq":"1","dJobNm":"라인맨","workSum":"영화 및 드라마 촬영현장에서 동시녹음기사와 붐오퍼레이터를 보조한다.","doWork":"동시녹음기사와 붐오퍼레이터를 보조하여 녹음장비와 붐마이크 간에 연결된 라인을 관리한다. 위험을 방지하고 촬영앵글에 맞춰 움직이는 붐마이크가 효율적으로 움직일 수 있도록 마이크 케이블의 길이를 선정하고 조명 케이블 등과 겹치지 않도록 라인을 깔고 마이크를 세팅한다. 외부에서 들어오는 소음을 확인하고 소음의 원인을 해결한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"붐어시스턴트","dJobECd":"4169","dJobECdNm":"[4169]기타 연극·영화·방송 종사원","dJobJCd":"2839","dJobJCdNm":"[2839]기타 연극·영화 및 영상 관련 종사원","dJobICd":"J591/J602/R901","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업 / [J602]텔레비전 방송업 / [R901]창작 및 예술관련 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006250:1', '{"dJobCd":"K000006250","dJobCdSeq":"1","dJobNm":"매트페인터","workSum":"실제 사진이나 영상에 합성되는 배경 그림을 포토샵 등으로 그려 가상공간을 창조한다.","doWork":"시나리오를 분석하여 전반적인 구조나 흐름에 따라 매트 페인팅이 필요한 부분을 파악한다. 현실적으로 촬영이 불가능하거나 배우가 촬영하기 위험한 장면, 가상공간의 창조, 제작비 절감을 위해 실사와 같은 정교한 배경 그림을 그린다. 실제 배경화면을 그리거나 상황에 맞춰 포토샵으로 각종 소스를 한 컷에 배치하고 페인팅 작업을 한다. 참고자료로 사용할 촬영 소스를 수집하고 필요한 경우 직접 촬영하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"4169","dJobECdNm":"[4169]기타 연극·영화·방송 종사원","dJobJCd":"2839","dJobJCdNm":"[2839]기타 연극·영화 및 영상 관련 종사원","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001710:1', '{"dJobCd":"K000001710","dJobCdSeq":"1","dJobNm":"무대기계조정원","workSum":"무용이나 연극 등의 공연을 위해 무대기계를 설치하고 기계를 조정하여 무대장치를 전환한다.","doWork":"공연을 위한 무대디자인을 보고 무대장치물의 무게에 따른 안전성, 무대전환 시간 등을 공연제작관련자와 협의한다. 무대 세팅을 위해 조명봉·장치봉 등의 배튼(조명장치나 무대장치를 연결할 수 있도록 제작된 금속봉)에 무대장치물이 설치되도록 상부기계를 조정하고, 회전무대, 승강무대, 이동무대 등의 하부기계를 조정한다. 막의 전환, 막의 위치, 높이 등 무대장치 전환 순서를 컴퓨터에 입력한 후, 공연 리허설 및 공연 진행 중에 무대감독의 지시를 받아 무대장치를 작동시킨다. 공연종료 후 무대장치물을 철거하기 위하여 장치를 조작한다. 무대기계장치를 점검하고 유지·관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"무대예술전문인(무대기계)","dJobECd":"4169","dJobECdNm":"[4169]기타 연극·영화·방송 종사원","dJobJCd":"2839","dJobJCdNm":"[2839]기타 연극·영화 및 영상 관련 종사원","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007841:1', '{"dJobCd":"K000007841","dJobCdSeq":"1","dJobNm":"문화세트제작자","workSum":"영화, 드라마, CF, 연극, 뮤지컬 등에서 사용되는 세트를 설계도에 따라 제작, 조립 및 설치한다.","doWork":"문화세트기술자가 그린 세트 설계도면을 기준으로 목재, 금속, 전기자재 등을 가공하여 구조물을 제작한다. 촬영 또는 공연 전 모든 구조물이나 설치물을 정확한 위치에 설치한다. 세트의 시각적 완성도를 높이기 위하여 참여하는 작화, 도장, 도배, 시트 등 시각적 마감작업을 한다. 촬영 및 공연 중에도 세트를 수정한다. 촬영이 끝나면 세트를 분해하여 철거한다. 파손된 부위를 확인하여 보수한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|청각|손사용|시각|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"세트조립원, 세트설치원, 무대제작원, 무대설치원, 세트맨","dJobECd":"4169","dJobECdNm":"[4169]기타 연극·영화·방송 종사원","dJobJCd":"2839","dJobJCdNm":"[2839]기타 연극·영화 및 영상 관련 종사원","dJobICd":"J591/J602/R901","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업 / [J602]텔레비전 방송업 / [R901]창작 및 예술관련 서비스업","inqYear":"2025"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005781:1', '{"dJobCd":"K000005781","dJobCdSeq":"1","dJobNm":"방송연출보조원","workSum":"연출가 및 조연출가의 지시·감독을 받으며 방송프로그램 제작을 보조한다.","doWork":"방송프로듀서(방송연출가)의 지시를 받아 방송프로그램 제작 활동을 보조한다. 촬영일정 보조(출연자에게 녹화일정 통보, 녹화스케줄을 관계자에게 전달하고 확인함), 진행보조(연기자에게 큐사인 주기, 관객에게 박수, 웃음 등의 효과를 연출, 출연자 대기실 관리), 촬영보조(진행시각의 초읽기, 카메라의 이동에 따른 케이블 정리, 모니터의 위치이동) 등의 업무를 수행한다. 제작비 사용내역을 정리하기도 하며 제작에 필요한 외부용역을 섭외 및 관리하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"언어력|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"FD(Floor Director), 조연출보조","dJobECd":"4169","dJobECdNm":"[4169]기타 연극·영화·방송 종사원","dJobJCd":"2839","dJobJCdNm":"[2839]기타 연극·영화 및 영상 관련 종사원","dJobICd":"J602","dJobICdNm":"[J602]텔레비전 방송업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005968:1', '{"dJobCd":"K000005968","dJobCdSeq":"1","dJobNm":"보조연기자","workSum":"영화, 드라마에 단역으로 출연하여 대사 없는 단순한 연기를 한다.","doWork":"영화, 드라마 촬영장에서 시대, 배경에 적절한 의상을 지급받아 착용한다. 병사, 백성, 주민, 관객 등 많은 사람이 동원되는 장면에서 걸어가거나, 달려가거나, 죽거나, 함성을 지르거나, 가만히 서 있는 등 단순한 연기를 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"시범후 30일 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"관련없음","workFunc2":"오락제공","workFunc3":"관련없음","similarNm":"엑스트라연기자","dJobECd":"4169","dJobECdNm":"[4169]기타 연극·영화·방송 종사원","dJobJCd":"2839","dJobJCdNm":"[2839]기타 연극·영화 및 영상 관련 종사원","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004500:1', '{"dJobCd":"K000004500","dJobCdSeq":"1","dJobNm":"보조출연자섭외원","workSum":"영화, 방송촬영 등에 보조로 출연할 사람들을 섭외하여 제작업체에 소개한다.","doWork":"방송드라마, 광고 등에 조역 및 단역으로 출연을 희망하는 사람을 대상으로 인적사항 및 특이사항, 경력 등을 파악한다. 관련 데이터를 컴퓨터에 입력한다. 영화, 방송물, 광고물 제작업체와 연계하여 촬영에 필요한 인원을 파악한다. 각각의 특성에 적합한 보조출연희망자를 선별한다. 대상자에게 연락하고, 희망자에게 촬영일시 및 촬영장소를 지정하여 안내한다. 대규모의 인원 동원 시 촬영현장에 가서 직접 보조출연자들을 인솔하고 통제한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"단순작업","dJobECd":"4169","dJobECdNm":"[4169]기타 연극·영화·방송 종사원","dJobJCd":"2839","dJobJCdNm":"[2839]기타 연극·영화 및 영상 관련 종사원","dJobICd":"J591/J602","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업 / [J602]텔레비전 방송업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004546:1', '{"dJobCd":"K000004546","dJobCdSeq":"1","dJobNm":"붐오퍼레이터","workSum":"붐폴에 달려 있는 마이크를 컨트롤하여 녹음감독이 원하는 대로 배우의 대사 및 촬영현장 사운드를 수음한다.","doWork":"동시녹음 장비와 시스템을 준비한다. 배우의 촬영 동선을 파악하여 촬영 시 조명으로 생기는 마이크의 그림자가 나오지 않도록 한다. 최선의 사운드를 수음하기 위하여 배우와 근접하는 위치에 마이크를 선정하고 카메라 앵글을 피하면서 연기하는 배우 쪽 마이크가 정확한 위치에서 수음할 수 있도록 조작한다. 마이크의 조작, 관리, 동시녹음 소스의 데이터 모니터링 등을 한다. 촬영현장의 소음 등을 확인하여 원활한 촬영이 진행될 수 있도록 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"필드레코더","dJobECd":"4169","dJobECdNm":"[4169]기타 연극·영화·방송 종사원","dJobJCd":"2839","dJobJCdNm":"[2839]기타 연극·영화 및 영상 관련 종사원","dJobICd":"J591/J602/R901","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업 / [J602]텔레비전 방송업 / [R901]창작 및 예술관련 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003240:1', '{"dJobCd":"K000003240","dJobCdSeq":"1","dJobNm":"소품담당원","workSum":"영화 및 방송 등 촬영(세트)현장에 사용되는 소도구의 수집·임대·제작·배치 등 소품활용 활동을 감독·조정한다.","doWork":"대본(시나리오)을 검토하여 각 장면에서 사용될 소품을 선정한다. 방송프로듀서(방송연출가), 영화감독, 무대디자이너 등과 사용 소품에 대하여 협의한다. 사용될 소품의 임대 또는 구입을 지시한다. 소품제작원에게 소품제작을 의뢰하기도 한다. 각 장면 촬영을 위해 소품을 운반하여 세트(무대장치)에 배치한다. 촬영이 종료되면 소품관리원에게 소품 철거 및 보관을 지시한다. 소품 관련 종사원들의 활동을 조정하고 감독한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"수동조작","dJobECd":"4169","dJobECdNm":"[4169]기타 연극·영화·방송 종사원","dJobJCd":"2839","dJobJCdNm":"[2839]기타 연극·영화 및 영상 관련 종사원","dJobICd":"J591/J602/R901","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업 / [J602]텔레비전 방송업 / [R901]창작 및 예술관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002454:1', '{"dJobCd":"K000002454","dJobCdSeq":"1","dJobNm":"소품제작원","workSum":"방송프로그램, 영화, 연극 제작 시 장식으로 사용될 일반 및 특수 소품을 제작한다.","doWork":"의뢰받은 소품의 디자인이나 설계도를 검토하여 소품의 규격, 색깔, 재질, 개수 등의 세부사항을 확인한다. 목재, 플라스틱, FRP(유리섬유강화플라스틱), 스티로폼, 스펀지 등을 사용하여 규정된 치수대로 재단한다. 톱, 타카 등 각종 수동공구와 접착제를 이용해 재료를 절단하고 연결하거나 붙인다. 거친 면은 사포, 줄 등으로 연마하고, 소품의 형상을 만든다. 작품에 어울리는 색을 입히기 위해 도장하거나 시트지를 붙인다. 무대장치도장원에게 완성된 소품의 도색 및 그림을 의뢰하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"4169","dJobECdNm":"[4169]기타 연극·영화·방송 종사원","dJobJCd":"2839","dJobJCdNm":"[2839]기타 연극·영화 및 영상 관련 종사원","dJobICd":"J591/J602/R901","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업 / [J602]텔레비전 방송업 / [R901]창작 및 예술관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005174:1', '{"dJobCd":"K000005174","dJobCdSeq":"1","dJobNm":"애니메트로닉스제작자","workSum":"동물 캐릭터 등 영화 활용되는 실물모형인 애니메트로닉스 모형을 제작한다.","doWork":"만들고자 하는 모형을 모델링 프로그램과 동역학 프로그램을 사용해 문제점을 수정하고 자연스러운 움직임을 위한 시뮬레이션 작업을 한다. 흙이나 점토 등을 사용하여 원형을 조각하여 모델링한다. 모델링한 작업물에 실리콘이나 석고, FRP 등을 사용하여 형틀을 제작한다. 플라스틱 등을 사용하여 형태를 유지하는 골격을 만들고 동력장치를 고정시키고 관절을 잘라내어 구동할 수 있게 한다. 형틀에 실리콘이나 폼라텍스 등의 재료를 주입하여 스킨을 제작한다. 형틀을 가공하고 모터 등의 구동장치를 연결한다. 스킨에 페인팅 작업을 하며 동물의 경우 털을 심는 작업을 한다. 자연스럽게 움직일 수 있도록 스킨과 골격을 조립하여 완성한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"4169","dJobECdNm":"[4169]기타 연극·영화·방송 종사원","dJobJCd":"2839","dJobJCdNm":"[2839]기타 연극·영화 및 영상 관련 종사원","dJobICd":"J591/J602/R901","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업 / [J602]텔레비전 방송업 / [R901]창작 및 예술관련 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005239:1', '{"dJobCd":"K000005239","dJobCdSeq":"1","dJobNm":"영화연출스크립터","workSum":"영화촬영에서 각 장면들의 연결과 촬영 시 필름과 사운드에 기록되는 사항을 기록한다.","doWork":"촬영 분량과 필름 잔량, 촬영이 진행되기 전에 준비된 콘티를 확인한다. 매 컷이 넘어갈 때 슬레이트에 적히는 컷 번호와 콘티의 컷 번호, 스크립 페이퍼에 기록되는 컷 번호가 같은지 확인하고 변동이 있으면 기록한다. 카메라 매거진에 써진 롤 넘버를 확인하고 어느 컷이 어느 롤에 위치하는지 기록한다. 연결되는 각각의 쇼트(한 번에 촬영한 장면)가 콘티뉴이티(Continuity:영상 구성에 있어 장면과 장면을 이해하기 쉽고 부드럽게 연결하여 하나의 일관된 흐름을 갖게 하는 것)를 유지하도록 배우의 연기동작, 방향, 의상, 소품 등을 기록한다. 촬영이 다음 회차로 넘어가거나 장소이동, 시간 변화가 있을 때에는 촬영의 연속성을 위해 연기자의 의상, 분장, 소품, 세트 장치를 디지털카메라 또는 비디오카메라로 기록해 둔다. 촬영현장에 현장편집기사가 없는 경우 대신 비디오 녹화를 하고 감독이나 촬영감독이 컷의 연결을 확인하고자 할 때 제시한다. 모든 촬영 회차별 스크립트 용지를 보관하고 결속하여 편집실에 전달한다. 촬영 중 배우가 즉흥연기로 시나리오에 없는 대사를 말할 경우에는 이를 기록해 두었다가 포스트프로덕션에서 녹음대본에 기입하여 사용한다. 편집기사가 쇼트의 배열 순서를 잡는데 협력한다. 스크립트 용지를 촬영순서가 아닌 영화 진행순서로 다시 배열하고 편집에 사용될 컷이 어느 테이크를 사용했는지 기록한다. 대사 편집할 때 화면이 OK컷으로 사용한 테이크와 다를 경우 어느 테이크를 사용했는지 녹음대본에 기록한다. 연출부가 믹싱작업 전에 녹음대본을 만들 때 대사 부분을 작성한다. 최종 녹음대본을 토대로 심의대본을 만든다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"손사용|언어력|시각|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"스크립터수퍼바이저(Script Supervisor), 콘티뉴이티수퍼바이저(Continuity Supervisor)","dJobECd":"4169","dJobECdNm":"[4169]기타 연극·영화·방송 종사원","dJobJCd":"2839","dJobJCdNm":"[2839]기타 연극·영화 및 영상 관련 종사원","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004520:1', '{"dJobCd":"K000004520","dJobCdSeq":"1","dJobNm":"영화큐레이터","workSum":"관객에게 영화에 대한 해설을 통해 다양한 정보를 제공하여 영화의 감상을 돕는다.","doWork":"영화를 감상하고 영화에 관한 자료, 평론가들의 생각, 제작과 관련한 이야기 등을 정리한다. 영화에 대한 해석 및 관련 정보, 비하인드 스토리를 전달하여 관객이 더욱 심도 있게 영화를 이해할 수 있도록 돕는다. 관객에 접하기 어려운 정보를 제공하고 관객의 질문에 대한 답변을 한다. 상업영화 외에 독립·예술영화에 대한 해설을 하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"교육","workFunc3":"관련없음","dJobECd":"4169","dJobECdNm":"[4169]기타 연극·영화·방송 종사원","dJobJCd":"2839","dJobJCdNm":"[2839]기타 연극·영화 및 영상 관련 종사원","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003936:1', '{"dJobCd":"K000003936","dJobCdSeq":"1","dJobNm":"의상관리원","workSum":"연극, 영화, 방송드라마 등의 제작이나 유원지, 오락시설의 행사에 사용되는 의상과 장신구를 보관·관리한다.","doWork":"창고에 보관되어 있는 의상과 장신구를 시대별·신분별로 수량, 종류, 치수 등을 구분하여 기록·관리한다. 의상이 손상되거나 색상이 변질되지 않도록 보관창고의 온도, 습도 등을 조절한다. 출연자에게 의상과 장신구를 대여하고 수량 및 종류를 기록한다. 제작물의 특성에 따라 의상을 개조하고 손상된 부분을 수선한다. 제작에 필요한 의상을 검토하고 의상감독과 협의하여 구매요구서를 작성한다. 의상을 준비하여 출연자에게 입혀주기도 한다. 야외촬영 시 의상을 차량에 구비하여 관리하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"관련없음","dJobECd":"4169","dJobECdNm":"[4169]기타 연극·영화·방송 종사원","dJobJCd":"2839","dJobJCdNm":"[2839]기타 연극·영화 및 영상 관련 종사원","dJobICd":"J602/R901","dJobICdNm":"[J602]텔레비전 방송업 / [R901]창작 및 예술관련 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006330:1', '{"dJobCd":"K000006330","dJobCdSeq":"1","dJobNm":"의상담당원","workSum":"연극, 영화, 방송드라마 등에 출연하는 배역들의 의상과 장신구를 보관, 제작, 임대, 구매하는 업무를 총괄하고, 관련 종사원들의 활동을 감독·조정한다.","doWork":"대본을 검토하고 연출자와 협의하여 출연자의 극중역할 및 시대에 따른 의상의 형태를 파악한다. 연극, 영화, 방송드라마 등에 적합한 의상을 구상한다. 영화감독, 연극연출자, 드라마PD 등과 협의하여 의상을 확정하고 의상제작 및 임대 비용을 산정한다. 촬영일정에 따라 출연자의 의상이 극의 전개와 적합하도록 관리한다. 의상의 수선을 지시하거나, 보유하고 있는 의상의 목록을 만들어 사용 가능한 의상의 종류와 상태를 파악한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"10년 초과","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"시각|","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"4169","dJobECdNm":"[4169]기타 연극·영화·방송 종사원","dJobJCd":"2839","dJobJCdNm":"[2839]기타 연극·영화 및 영상 관련 종사원","dJobICd":"J591/J602","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업 / [J602]텔레비전 방송업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006341:1', '{"dJobCd":"K000006341","dJobCdSeq":"1","dJobNm":"조명스크립터","workSum":"촬영 중인 쇼트와 조명 세팅 장면을 사진으로 찍고 촬영 및 조명에 관련된 기록을 한다.","doWork":"촬영 중인 쇼트(한 번에 촬영한 장면)와 조명 세팅 장면을 사진으로 기록한다. 노출값, 렌즈, 필름 값 등 기본 수치를 기록한다. 조명 설치상태, 촬영 상황 등을 기록한다. 촬영 회차, 씬(scene, 장면)에 대한 설명과 노출, 감도, 렌즈치수, 카메라워킹, 반사노출, 조명기구의 점멸에 대한 정보를 기록한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|시각|","workFunc1":"기록","workFunc2":"관련없음","workFunc3":"관련없음","similarNm":"lighting scripter, electrician","dJobECd":"4169","dJobECdNm":"[4169]기타 연극·영화·방송 종사원","dJobJCd":"2839","dJobJCdNm":"[2839]기타 연극·영화 및 영상 관련 종사원","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005384:1', '{"dJobCd":"K000005384","dJobCdSeq":"1","dJobNm":"촬영장소섭외자","workSum":"방송드라마, 영화 등의 제작을 위해 촬영현장을 방문하여 건물이나 장소를 섭외한다.","doWork":"대본(시나리오)을 검토한 후 작가의 의도를 파악해 주요 촬영장소에 대하여 구상한다. 방송프로듀서(방송연출가) 또는 영화감독, 기타 제작종사원들과 주요 촬영장소에 대해 협의한다. 자료를 찾아보고 촬영 후보지역을 선정한다. 후보지역을 방문하여 촬영에 적합한 장소인지 확인하고 방송연출가 또는 영화감독 등과 협의한다. 촬영지역으로 결정되면 지역관공서 혹은 소유자에게 서면 혹은 구두로 촬영허가를 받는다. 촬영장소 계약을 위한 계약서를 작성한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실외","workFunc1":"수집","workFunc2":"협의","workFunc3":"관련없음","similarNm":"로케이션매니저, 로케이션헌터","dJobECd":"4169","dJobECdNm":"[4169]기타 연극·영화·방송 종사원","dJobJCd":"2839","dJobJCdNm":"[2839]기타 연극·영화 및 영상 관련 종사원","dJobICd":"J591/J602","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업 / [J602]텔레비전 방송업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003888:1', '{"dJobCd":"K000003888","dJobCdSeq":"1","dJobNm":"캐스팅디렉터","workSum":"오디션을 통하여 신인배우를 선발하거나 활동하고 있는 배우를 선정하여 영화의 주연 및 조연 배역에 가장 적합한 배우를 섭외한다.","doWork":"시나리오를 읽어 본 후 등장인물의 성격을 분석한다. 각 배역에 적합한 배우를 섭외하기 위해 배우들에 대한 정보를 분석한다. 신인 배우를 발탁하기 위하여 공개오디션을 주최하고, 배역 후보를 선정한다. 확정된 배우의 작품계약을 대행한다. 배우의 스케줄을 관리·조정한다. 영화제작자, 영화감독, 시나리오작가 등과 진행사항에 대하여 협의한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"4169","dJobECdNm":"[4169]기타 연극·영화·방송 종사원","dJobJCd":"2839","dJobJCdNm":"[2839]기타 연극·영화 및 영상 관련 종사원","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005607:1', '{"dJobCd":"K000005607","dJobCdSeq":"1","dJobNm":"특수효과기사","workSum":"영화, 방송드라마 등의 제작에 요구되는 각종 특수효과를 연출하기 위해 특수장비 및 혼합물을 조작 및 제조한다.","doWork":"대본(시나리오) 확인 후 장면에 사용될 무대효과의 유형을 파악하고 방송프로듀서(방송연출가) 또는 영화감독과 협의한다. 전기효과, 무대효과, 영상효과, 특수효과 등 입체감과 현실감을 살리는 효과를 내기 위하여 각종 화합물을 혼합하고 수동공구를 이용하여 나무, 금속, 플라스틱, 점토 등의 재료를 조립하고 설치한다. 특수효과를 연출하기 위하여 촬영장면에 따라 관련 장비를 이용하여 폭발, 비, 눈, 바람 등을 연출한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"청각|시각|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"무대효과원, 특수효과원","connectJob":"컴퓨터를 이용하여 특수효과를 만드는 경우 컴퓨터그래픽(CG)특수효과원, FX전문가","dJobECd":"4169","dJobECdNm":"[4169]기타 연극·영화·방송 종사원","dJobJCd":"2839","dJobJCdNm":"[2839]기타 연극·영화 및 영상 관련 종사원","dJobICd":"J591/J602","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업 / [J602]텔레비전 방송업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005145:1', '{"dJobCd":"K000005145","dJobCdSeq":"1","dJobNm":"하우스매니저","workSum":"연극 등 각종 공연장의 운영 및 관리를 총괄하고, 관련 종사원의 활동을 관리·감독한다.","doWork":"공연의 원활한 진행을 위해 공연 스태프와 공연내용, 공연시간, 휴식시간 등에 대해서 논의한다. 공연 전 공연 관련 시설의 청결이나 안전상태를 점검한다. 관객의 질서유지, 편의제공, 공연장 내 분위기 조성, 부대시설 관리 등의 업무를 수행한다. 무전기를 사용하여 매표상황, 로비상황, 장내상황 등을 관계자들과 교신한다. 공연장안내원의 업무 배치와 근무일정 계획을 수립한다. 공연장안내원(하우스어셔)들에게 공연안내에 대해 교육한다. 공연 전후에 공연프로그램에 대한 정보, 공연시간, 연주자와 간담시간 일정 등에 대해 관객들에게 방송한다. 공연시설, 서비스 등에 대한 관객의 불만을 처리한다. 공연장 및 부대시설 등을 유지·관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"공연장매니저, 극장매니저","connectJob":"공연장안내원(하우스어셔)","dJobECd":"4169","dJobECdNm":"[4169]기타 연극·영화·방송 종사원","dJobJCd":"2839","dJobJCdNm":"[2839]기타 연극·영화 및 영상 관련 종사원","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003122:1', '{"dJobCd":"K000003122","dJobCdSeq":"1","dJobNm":"그래피티아티스트","workSum":"거리의 벽 등 세상의 다양한 공간을 캔버스 삼아 스프레이 등을 활용해 벽에 그림을 그린다.","doWork":"벽화 작업의 경우, 그림구상하기, 스케치하기, 채색하기, 아웃라인 그리기, 하이라이트 표현하기, 마무리하기 등의 순서로 진행한다. 공공장소에 적합한 그림을 그려 꾸미는 공공벽화 작업, 전시회를 위한 작가의 개인 작업, 상업시설에 그래피티를 접목한 인테리어 작업 등을 한다. 각종 페스티벌의 특성에 맞춰 관객들에게 직접 그림 그리는 모습을 보여주는 라이브 페인팅 등 방송, 행사, 공연의 퍼포먼스 작업을 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"4141","dJobECdNm":"[4141]화가 및 조각가","dJobJCd":"2841","dJobJCdNm":"[2841]화가 및 조각가","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003082:1', '{"dJobCd":"K000003082","dJobCdSeq":"1","dJobNm":"생태세밀화가","workSum":"동·식물도감이나 그림책에 수록되는 생태세밀화를 그린다.","doWork":"도감의 경우, 작은 동·식물을 채집해 작업실로 가져와 관찰한다. 그림책의 경우, 그림과 함께 실릴 글의 주제와 배경을 연출하면서 관찰한다. 도감 또는 그림책의 내용과 그림의 크기를 확인한다. 각종 그림도구를 사용하여 스케치한다. 스케치를 내용에 부합되도록 배열·정리하고, 색상을 넣어 견본을 제작한다. 견본을 토대로 의뢰인과 협의하여 완성품을 제작한다. 작업이 완성되면 의뢰인에게 보여주고 수정하거나 보충한다. 야외에서 동·식물을 관찰하고 자료사진을 촬영한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"4141","dJobECdNm":"[4141]화가 및 조각가","dJobJCd":"2841","dJobJCdNm":"[2841]화가 및 조각가","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003159:1', '{"dJobCd":"K000003159","dJobCdSeq":"1","dJobNm":"서예가","workSum":"종이, 붓, 먹, 벼루 등을 사용하여 서예 작품을 창작한다.","doWork":"작품에 필요한 글귀를 선정한다. 종이를 펴고 흔들리지 않게 문진 따위로 고정한다. 벼루에 물을 넣고 먹을 갈아서 먹물을 만든다. 먹물의 농담(진하고 흐린 정도)이 적절한지 확인한다. 붓에 먹물을 묻히고 쓰고자 하는 글씨에 적합한 필법을 사용하여 진서, 초서, 예서 등의 서체로 고시(古詩), 시, 창작글 등을 예술적으로 쓴다. 붓에 먹물이 마르거나 붓끝이 흐트러지면 벼루에 다듬기도 한다. 다 쓴 종이 위의 글씨가 번지지 않도록 주의하면서 건조한다. 완성된 작품에 대하여 표구를 의뢰하기도 하고 전시회를 개최하거나 서예집을 출판하기도 한다. 서체, 필법을 연구·보전하고 제자에게 전수하기도 한다. 사군자를 그리기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"웅크림|손사용|시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"4141","dJobECdNm":"[4141]화가 및 조각가","dJobJCd":"2841","dJobJCdNm":"[2841]화가 및 조각가","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002740:1', '{"dJobCd":"K000002740","dJobCdSeq":"1","dJobNm":"요판종판조각원","workSum":"요판인쇄에 사용되는 금속판을 제작하기 위하여 원도를 요판종판에 조각하는 일을 한다.","doWork":"금속판에 원도의 윤곽선과 명암 구분선을 그린다. 환침을 이용하여 금속판에 원도의 특징을 살릴 수 있도록 점과 선으로 선구성원도를 완성한다. 선구성이 완성된 금속판에 조각도를 사용하여 직접 손으로 조각한다. 종판(Original Die)을 완성하기 위하여 조각 중인 금속판을 시쇄하고 원도와 비교하여 보충조각을 반복한다. 요판종판에 기하학적 무늬인 채문을 조각하기 위하여 채문조각기(Lathe Work, 彩紋)를 이용하여 조각하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"요판종판기계조각원","dJobECd":"4141","dJobECdNm":"[4141]화가 및 조각가","dJobJCd":"2841","dJobJCdNm":"[2841]화가 및 조각가","dJobICd":"C181","dJobICdNm":"[C181]인쇄 및 인쇄관련 산업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007571:1', '{"dJobCd":"K000007571","dJobCdSeq":"1","dJobNm":"조각가","workSum":"목재, 석재, 진흙, 금속 등의 재료를 사용하여 입체적인 조각작품을 창작한다.","doWork":"작품을 구상하고 소재의 특성에 따라 적합한 조각방법을 선정한다. 금속(청동, 철, 스테인리스스틸, 알루미늄 등), 석재, 나무, 점토, 콘크리트 등의 소재에 석공도구, 금속세공도구, 조각칼 등의 도구를 사용하여 조각한다. 조각하는 형식에 따라 환조(丸彫:완전한 입체형태를 갖추고 있는 작품), 부조(浮彫:평평한 면에 글자나 그림을 도드라지게 새긴 작품), 모빌(Mobile: 움직이는 조각작품), 오브제(Objet:전통적인 조각형식을 타파한 구성작품), 아상블라쥬(Assemblage:여러 가지 물체를 한데 모아 미술작품을 제작하는 기법) 등을 제작한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"웅크림|손사용|시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"4141","dJobECdNm":"[4141]화가 및 조각가","dJobJCd":"2841","dJobJCdNm":"[2841]화가 및 조각가","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006806:1', '{"dJobCd":"K000006806","dJobCdSeq":"1","dJobNm":"주화조각원","workSum":"주화, 메달, 훈장 등의 제작에 사용되는 극인(음각금형, 양각금형)을 제작하기 위하여 제품을 디자인한 후 석고원판을 제작한다.","doWork":"작업지시서 및 도안(디자인)을 확인한다. 석고원판 제작을 위해 도안을 축소 또는 확대 복제하거나 그려서 도안 복제필름을 작성한다. 작업용 기저판을 제작하고, 유토를 입힌 후 복제된 도안을 전사하여 성형한다. 완성된 유토 조각판 표면에 분리제를 도포하며 석고가루를 물과 혼합하여 유토판 위에 붓고 응고시킨다. 복제한 음각형 석고판을 도안에 충실하도록 세밀하게 수정·조각한다. 음각형 석고판을 표면 처리하여 양각형 석고판을 제작하고 재수정·조각한다. 완성된 석고판을 건조시켜 수분을 제거하고 파라핀을 용해하여 흡수, 침납시키고 냉각시킨다. 파라핀이 침납된 석고판에 분리제를 도포하고 광택이 나도록 솔로 문지른다. 복제 작업대의 수평을 조정하고 PVC링을 고정시킨 후 두 차례에 걸쳐 수지 및 경화제를 혼합하여 붓는다. 수지가 경화되면 석고판과 분리하여 미흡한 부분을 수정·조각하고 최종 검토한다. 축조조각기를 사용하여 수지판의 요철상태를 금속 소재에 실물 크기로 축소·조각한다. 커터의 홀더 회전중심을 구한다. 동작을 점검하여 속도를 조절한다. 원극인과 극인의 제작과정에서 나타나는 미세한 흠이나 마스터다이 커터자국 등을 수정한다. 모방밀링기나 문자각인기를 조작하여 문자용 레터링을 각인한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"소음·진동|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"극인조각원","certLic":"제품디자인기사","dJobECd":"4141","dJobECdNm":"[4141]화가 및 조각가","dJobJCd":"2841","dJobJCdNm":"[2841]화가 및 조각가","dJobICd":"C331","dJobICdNm":"[C331]귀금속 및 장신용품 제조업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007551:1', '{"dJobCd":"K000007551","dJobCdSeq":"1","dJobNm":"화가","workSum":"그림물감, 먹물, 붓 등을 사용하여 풍경화, 인물화, 정물화, 추상화 등의 예술작품을 창작한다.","doWork":"작품을 구상하고 적절한 재료(캔버스, 나무판, 유채물감, 수채물감, 연필, 파스텔, 잉크 등)를 선택한다. 공간, 크기, 색채, 원근, 농담, 질감 등 각종 표현기법을 활용하여 그림을 그린다. 작품이 완성되면 고착제를 사용하여 완성된 작품을 보호하거나 액자에 넣어서 보관하기도 한다. 개인전시회를 개최하거나 단체전시회에 참가하며 작품집을 출판 및 전시·판매하기도 한다. 형체와 색감에 대한 미술적 표현방법을 연구하고 독창적인 기법을 창안하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"한국화가, 서양화가, 수묵화가, 담채화가","dJobECd":"4141","dJobECdNm":"[4141]화가 및 조각가","dJobJCd":"2841","dJobJCdNm":"[2841]화가 및 조각가","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005081:1', '{"dJobCd":"K000005081","dJobCdSeq":"1","dJobNm":"사진기자","workSum":"신문이나 잡지에 게재하기 위하여 뉴스, 스포츠, 연예 또는 흥미를 끌 만한 사건·장소·인물 및 기타 장면을 사진으로 제공하기 위하여 사진기로 촬영한다.","doWork":"독자의 관심과 흥미를 불러일으킬 수 있는 사건·사고현장 및 장소를 찾아가거나 편집국 소속 기자의 요청에 의해 촬영 일정을 수립한다. 사건·사고의 전개과정이나 정보의 중요성에 따라 주요 장면을 사진 촬영한다. 촬영한 사진을 보정하고, 기사나 정보의 순서 등에 맞게 사진을 편집한다. 편집한 사진을 편집부에 제공한다. 정치, 경제, 사회, 문화, 스포츠, 연예 등 어느 한 분야의 사진 촬영만을 전문으로 하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"시각|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"촬영기자","connectJob":"출판물의 종류나 담당 분야에 따라 잡지사진기자, 신문사진기자","certLic":"사진기능사","dJobECd":"4142","dJobECdNm":"[4142]사진작가 및 사진사","dJobJCd":"2842","dJobJCdNm":"[2842]사진기자 및 사진가","dJobICd":"J581/J639","dJobICdNm":"[J581]서적, 잡지 및 기타 인쇄물 출판업 / [J639]기타 정보 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002081:1', '{"dJobCd":"K000002081","dJobCdSeq":"1","dJobNm":"사진사(일반)","workSum":"각종 카메라를 조작하여 컬러 혹은 흑백으로 인물 또는 각종 물체를 촬영한다.","doWork":"사진 촬영할 대상, 목적, 예상되는 조건 등을 고려하여 사용할 카메라, 렌즈, 필름 및 각종 보조도구를 선택한다. 물체나 배경을 확인하여 카메라의 위치, 각도 등을 계획한다. 촬영할 대상을 정돈하고 조명, 노출, 셔터의 속도, 초점 등을 조절한다. 필름을 현상하거나 확대한다. 컴퓨터를 이용하여 사진을 수정한다. 비디오를 촬영하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"사진가","connectJob":"촬영을 하는 목적에 따라 인상사진가, 생태사진가, 라이브러리사진작가, 사진보정원, 리터처","dJobECd":"4142","dJobECdNm":"[4142]사진작가 및 사진사","dJobJCd":"2842","dJobJCdNm":"[2842]사진기자 및 사진가","dJobICd":"M733","dJobICdNm":"[M733]사진 촬영 및 처리업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006887:1', '{"dJobCd":"K000006887","dJobCdSeq":"1","dJobNm":"상업사진작가","workSum":"각종 카메라를 조작하여 광고에 사용될 인물사진이나 상품사진 등을 촬영한다.","doWork":"사진 촬영할 대상, 예상되는 조건, 사용할 카메라, 렌즈, 필름 및 각종 보조도구의 기능에 따라 장비를 선택한다. 물체나 배경을 확인하여 카메라의 위치, 각도 등을 계획한다. 촬영할 대상을 정돈하고 조명, 노출, 셔터의 속도, 초점 등을 조절한다. 필름을 현상하거나 확대하기도 하며 현상된 필름을 수정하기도 한다. 작품사진을 촬영하기 위하여 연구와 촬영계획을 세우기도 한다. 스튜디오에서 조명기구와 카메라를 조작하여 인물을 촬영하기도 하며 문서, 자료 등의 기록물을 축소 및 확대 촬영하기도 한다. 운동경기 승부 등 육안으로 판단하기 힘든 장면을 고속카메라를 이용해 촬영하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"상업사진사, 상업사진가, 광고사진작가","connectJob":"촬영 분야에 따라 인물사진작가, 제품사진작가, 도서촬영기사, 운동경기사진사, 항공사진촬영가","dJobECd":"4142","dJobECdNm":"[4142]사진작가 및 사진사","dJobJCd":"2842","dJobJCdNm":"[2842]사진기자 및 사진가","dJobICd":"M733","dJobICdNm":"[M733]사진 촬영 및 처리업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003251:1', '{"dJobCd":"K000003251","dJobCdSeq":"1","dJobNm":"스틸사진사","workSum":"영화의 홍보 및 보도용 사진을 촬영하기 위해 영화제작 현장에서 카메라를 조작한다.","doWork":"영화기획사의 마케팅 관련 종사원과 협의하여 스틸사진 촬영계획을 세운다. 디지털카메라 또는 필름카메라의 위치, 각도 등을 고려하여 촬영할 대상의 노출, 초점 등을 조절한다. 영화를 제작하는 동안 장면, 인물 등의 사진을 촬영한다. 촬영한 사진의 NG·OK 컷을 선별하고 편집 프로그램을 이용하여 사진을 수정한다. 장면별, 촬영일별로 구분하여 파일로 저장한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"4142","dJobECdNm":"[4142]사진작가 및 사진사","dJobJCd":"2842","dJobJCdNm":"[2842]사진기자 및 사진가","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005477:1', '{"dJobCd":"K000005477","dJobCdSeq":"1","dJobNm":"예술사진작가","workSum":"예술적인 시각에서 미적 감동을 일으키는 예술성 있는 작품사진을 촬영한다.","doWork":"사회, 문화, 자연, 인간 등을 소재로 스튜디오 또는 야외에서 사진을 촬영한다. 출사(출장사진, 야외촬영)의 경우 바닷가, 산, 도시, 유적지 등의 현장을 답사하여 작품의 소재를 구상하고 사진을 촬영할 수 있는 모델이나 장소를 선정하기도 한다. 날씨, 조도, 피사체의 특징에 따라 적합한 카메라와 렌즈를 선택하고 구도를 잡아 촬영한다. 촬영된 사진을 사진보정 프로그램을 사용하여 보정하기도 한다. 완성된 사진작품을 인화한다. 사진작품을 전시하거나 사진집을 발간하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|손사용|시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"사진작가, 사진가","certLic":"사진기능사","dJobECd":"4142","dJobECdNm":"[4142]사진작가 및 사진사","dJobJCd":"2842","dJobJCdNm":"[2842]사진기자 및 사진가","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003675:1', '{"dJobCd":"K000003675","dJobCdSeq":"1","dJobNm":"동화원","workSum":"각 컷의 완성된 원화와 원화 사이의 동작을 원활하게 하기 위하여 중간 동작을 그린다.","doWork":"완성된 원화를 검토한다. 움직임의 처음과 끝 부분의 그림인 원화를 작업대(라이트 박스, 그림을 겹쳐 비추어 볼 수 있도록 조명 장치가 되어 있는 판) 위에 겹쳐놓는다. 그 위에 지정된 종이(작화지)를 놓고 원화와 원화 사이를 연결해 주는 중간 동작을 연필로 그린다. 동화작화감독의 지시하에 그림을 수정한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"동화맨, 작화가","dJobECd":"4143","dJobECdNm":"[4143]만화가 및 만화영화 작가","dJobJCd":"2843","dJobJCdNm":"[2843]만화가 및 만화영화 작가","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005558:1', '{"dJobCd":"K000005558","dJobCdSeq":"1","dJobNm":"동화작화감독","workSum":"원화에 맞게 동화가 그려졌는지 확인하기 위해 동화원이 그린 동화를 검사한다.","doWork":"총 제작기간에 영향을 주지 않도록 동화원의 작업일정을 관리한다. 여러 명의 동화원이 그린 동화를 검사하여 원화에 맞게 동화가 그려졌는지 검사한다. 중간 동작이 매끄럽게 연결되었는지, 지정된 매수를 그렸는지 검사한다. 잘못된 부분은 직접 수정하거나 동화원에게 수정을 지시한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"동화작감","dJobECd":"4143","dJobECdNm":"[4143]만화가 및 만화영화 작가","dJobJCd":"2843","dJobJCdNm":"[2843]만화가 및 만화영화 작가","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007518:1', '{"dJobCd":"K000007518","dJobCdSeq":"1","dJobNm":"만화가","workSum":"만화의 주제 및 이야기를 창작하고 이를 그림으로 그린다.","doWork":"만화로 그릴 소재를 찾고 장르를 구분하여 주제를 정하는 등 아이디어를 구상한다. 만화의 캐릭터 및 배경을 설정하여 시놉시스(시나리오 또는 대본 전체를 요약한 개요 혹은 줄거리)를 작성한다. 줄거리를 구성하고 지문과 대사를 작성하여 시나리오를 완성한다. 칸을 나누고, 페이지를 구성하여 대사를 넣고 콘티를 제작한다. 연필로 스케치한 후 세부 그림을 그리고 채색하여 수정한다. 스케치 작업 후 컴퓨터를 이용해 작업하거나 처음부터 컴퓨터 화면에 직접 만화를 그리기도 한다. 학습만화를 그리기도 하고 만화전문 잡지 및 신문에 기고하거나 만화·웹툰 전문 플랫폼에 디지털 만화(종이 등 유형물에 그려진 만화를 디지털파일 형태로 가공ㆍ처리하고 이를 디스크 등의 디지털매체나 정보통신망을 통하여 이용자에게 제공하는 만화)를 서비스하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"웹툰작가","dJobECd":"4143","dJobECdNm":"[4143]만화가 및 만화영화 작가","dJobJCd":"2843","dJobJCdNm":"[2843]만화가 및 만화영화 작가","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006297:1', '{"dJobCd":"K000006297","dJobCdSeq":"1","dJobNm":"만화데생작가","workSum":"만화 이야기를 기초로 인물과 배경, 움직임, 구도 등을 구상하고 그림으로 그려 형상화한다.","doWork":"만화 이야기를 검토한 후 인물, 배경을 중심으로 한 화풍을 정하고, 이야기에 적합한 그림의 콘셉트를 제안하고 그린다. 이야기에 적합한 형상화 구상을 하고, 컷과 연결된 컷, 한 페이지 등에 묘사할 그림을 구상하고 태블릿이나 액정 태블릿에 펜마우스를 사용하여 자세하게 그린다. 경우에 따라서 데생작가가 펜터치까지 맡기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"4143","dJobECdNm":"[4143]만화가 및 만화영화 작가","dJobJCd":"2843","dJobJCdNm":"[2843]만화가 및 만화영화 작가","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004087:1', '{"dJobCd":"K000004087","dJobCdSeq":"1","dJobNm":"만화영화검사원","workSum":"만화영화를 제작하기 위한 제작부서(원화, 동화, 배경 등)에서 작업 결과를 검사·관리한다.","doWork":"만화영화감독 또는 만화영화프로듀서로부터 작업분량, 제작의도, 진행일정 등을 지시받는다. 2D만화영화의 경우 원화, 동화, 캐릭터, 배경, 채색, 합성, 렌더링 부서에서, 3D만화영화의 경우 모델링(캐릭터를 만들어 냄), 쉐이딩(캐릭터에 재질을 주는 작업), 맵핑, 리깅(캐릭터에 뼈대를 만들어서 움직이는 부분에 포인트를 부여하는 작업), 애니메이팅(원화에 키프레임을 주고 키프레임과 키프레임 사이에 몇 장의 동화를 넣을 것인지 정함), 라이팅(애니메이팅이 끝난 캐릭터에 조명을 주어서 입체감을 부여함) 부서에서 작업한 결과물을 검사한다. 품질에 문제가 없으면 다음 부서로 작업물을 이동한다. 품질에 문제가 있는 경우에는 제작한 부서로 다시 돌려보내 수정하도록 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"4143","dJobECdNm":"[4143]만화가 및 만화영화 작가","dJobJCd":"2843","dJobJCdNm":"[2843]만화가 및 만화영화 작가","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005794:1', '{"dJobCd":"K000005794","dJobCdSeq":"1","dJobNm":"만화영화디지털페인터","workSum":"컴퓨터를 사용하여 만화영화 제작에 필요한 동화복사, 선화, 채색, 특수효과, 배경, 촬영, 편집 과정을 수행한다.","doWork":"완성된 동화를 스캐너를 사용하여 컴퓨터에 입력한다. 입력된 동화의 디지털 페인팅(Digital Painting：선화 및 채색) 작업을 수행한다. 채색 작업이 완료된 그림이 연속된 동작으로 보이도록 연결하고, 시각적인 특수효과를 더한다(Composing). 그림을 편집하고(Digital Editing) 최종 완성물을 저장매체(CD, DVD, 하드디스크 등)에 저장하여 최종적인 출력물을 제작한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"애니메이션디지털페인터(Animation Digital Painter)","dJobECd":"4143","dJobECdNm":"[4143]만화가 및 만화영화 작가","dJobJCd":"2843","dJobJCdNm":"[2843]만화가 및 만화영화 작가","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006376:1', '{"dJobCd":"K000006376","dJobCdSeq":"1","dJobNm":"만화컬러작가","workSum":"만화원고에 전문적으로 컬러링 작업을 한다.","doWork":"펜터치 원고(외형선으로 그려진 만화원고)를 받고 작업분량, 컬러팔레트, 대사를 확인한다. 원고에 적합한 컬러를 구상하고 한 두 장의 시안 작업을 한다. 만화가와 시안을 검토하고 원고의 컬러연출(원고에 사용할 전체적인 색계열, 밝기, 질감, 톤 등)을 협의한다. 컴퓨터 그래픽 프로그램을 사용하여 펜터치 원고 위에 컬러링 레이어를 만든다. 선의 끊어진 부분을 이어 붙여 면으로 완성한다. 컴퓨터 프로그램이 제공하는 각종 그림도구와 펜마우스를 사용하여 캐릭터에 지정된 컬러팔레트의 색을 칠하고 그림자와 양감(입체적인 느낌)을 만든다. 지정된 컬러팔레트가 없는 배경의 경우 전체적인 컬러연출에 어울리는 컬러를 고안하여 표현한다. 컬러를 사용한 다양한 극적 효과(빛, 어두움, 속도감, 심리표현, 폭발, 흔들림, 우주, 바닷속, 동굴 등)를 연출하기도 한다. 원고의 효과음(움직임, 속도감, 중량감 등을 나타내는 글자 또는 말풍선 외의 대사 등)을 표현한다. 식자(말풍선에 대사를 넣는 일) 작업을 하기도 한다. 프리랜서로 활동하는 경우 자신의 컬러링 포트폴리오를 제작하여 활용하기도 한다. 분업화한 웹툰 스튜디오에서는 제작 단계에 따라 밑색 채색 파트와 캐릭터 채색 파트를 나누어 진행하기도 한다. 밑색 파트의 경우, 상대적으로 단순 작업이므로 해외 기업 외주로 제작 비용을 절감하기도 한다. 반면 캐릭터 채색의 경우, 숙련지식이 요구되므로 밑색과 캐릭터 채색의 파트를 분리하여 작업을 진행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"웹툰컬러작가, 만화채색작가, 웹툰채색작가","dJobECd":"4143","dJobECdNm":"[4143]만화가 및 만화영화 작가","dJobJCd":"2843","dJobJCdNm":"[2843]만화가 및 만화영화 작가","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005666:1', '{"dJobCd":"K000005666","dJobCdSeq":"1","dJobNm":"만화펜터치작가","workSum":"만화 데생 원고에 전문적으로 펜터치(연필로 그려진 스케치 선을 정리하여 확정된 선으로 표현)를 한다.","doWork":"만화가로부터 만화 데생 원고(칸연출, 캐릭터, 배경 작업이 완료된 드로잉)를 받고 작업분량, 대사, 스토리의 전개, 세부지침 등을 확인한다. 원고에 적합한 펜터치를 구상하고 한 두 장의 시안 작업을 한다. 만화가와 시안을 검토하여 전체적인 펜터치 느낌을 결정한다. 컴퓨터 그래픽 프로그램을 사용하여 데생 원고 위에 펜터치 레이어를 만든다. 컴퓨터 프로그램이 제공하는 각종 그림도구와 펜마우스를 사용하여 여러 개의 선으로 그려진 데생 원고 위에 덧그림 방식으로 펜터치 한다. 밑그림 레이어(데생 원고)를 지우고 펜터치 레이어를 저장하여 작업을 완료한다. 수작업으로 펜터치 하는 경우 잉크와 펜, 칼, 자 등 그림도구를 사용하여 컷선을 그리고 뎃생 원고 위에 잉크와 펜으로 펜터치를 한다. 수정사항(그림을 잘못 그린 경우, 원고에 얼룩이나 오염이 발생한 경우 등)이 발생하면 수정잉크를 사용하여 수정하거나 원고를 칼로 오려내고 새로운 종이를 덧대어 수정하기도 한다. 원하는 느낌의 펜터치를 구현하기 위하여 원고 밑에 종이를 깔아서 푹신하게 하는 등 다양한 작업방법을 고안하기도 한다. 작업 중에 원고의 오류(스토리 전개에 맞지 않는 등장인물, 소품, 배경, 누락된 장면, 페이지 뒤섞임 등)를 발견하면 만화가에게 전달하여 수정되도록 하고 간단한 오류는 직접 수정한다. 프리랜서로 활동하는 경우 자신의 펜터치 포트폴리오를 제작하여 활용하기도 한다. 창작 환경에 따라서는 동일한 작가가 데생 및 펜터치를 함께 담당하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"웹툰펜터치 작가, 만화펜선작가, 웹툰펜선작가","dJobECd":"4143","dJobECdNm":"[4143]만화가 및 만화영화 작가","dJobJCd":"2843","dJobJCdNm":"[2843]만화가 및 만화영화 작가","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005130:1', '{"dJobCd":"K000005130","dJobCdSeq":"1","dJobNm":"배경화가","workSum":"움직이는 대상인 캐릭터를 제외한 배경을 그리고 채색하여 완성한다.","doWork":"배경원도와 설정을 기초로 하여 연필로 켄트지에 밑그림을 그린다. 수채화 물감, 포스터컬러, 붓 등을 사용하여 켄트지에 움직이는 대상인 캐릭터(Character)를 제외한 배경을 그린다. 기본스케치 위에 셀(Cell)을 얹어놓고 채색한다. 만화영화의 장면구성을 극대화하기 위하여 번개, 구름, 연기, 회오리 등의 특수효과를 각 장면에 첨가하며, 에어브러시(Airbrush)를 사용하여 완성된 셀에 특수효과를 가하기도 한다. 컴퓨터를 사용하는 경우에는 셀(Cell)을 사용하지 않으며 태블릿(펜마우스)를 사용해 컴퓨터상에서 밑그림을 그린다. 채색 관련 프로그램인 포토샵(Photoshop), 페인터(Painter) 등을 사용하여 채색하고 특수효과를 첨가하여 완성한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"배경맨","connectJob":"효과원","dJobECd":"4143","dJobECdNm":"[4143]만화가 및 만화영화 작가","dJobJCd":"2843","dJobJCdNm":"[2843]만화가 및 만화영화 작가","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004597:1', '{"dJobCd":"K000004597","dJobCdSeq":"1","dJobNm":"색지정자","workSum":"애니메이션에 등장하는 캐릭터에 입힐 색을 조합하여 만든다.","doWork":"캐릭터디자이너에 의해 캐릭터가 완성되면 애니메이션상에서 캐릭터의 성격을 파악한다. 컴퓨터를 이용하여 여러 색을 조합하고 다양한 캐릭터의 피부, 머리, 옷, 장식품 등의 색을 구상하여 시안을 만든다. 캐릭터디자이너 및 애니메이션연출가와 협의하여 캐릭터 및 색의 성격, 배경과의 조화 등을 고려해 최종적으로 색을 결정한다. 채색원에게 캐릭터의 샘플을 보내고 완성된 캐릭터의 색을 검사한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"분석","workFunc2":"협의","workFunc3":"정밀작업","dJobECd":"4143","dJobECdNm":"[4143]만화가 및 만화영화 작가","dJobJCd":"2843","dJobJCdNm":"[2843]만화가 및 만화영화 작가","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001764:1', '{"dJobCd":"K000001764","dJobCdSeq":"1","dJobNm":"선화원","workSum":"디지털 신호로 바꾸기 위해 종이에 그려진 완성된 동화 및 배경을 스캔하고 완전하게 그려지지 않은 선을 보충하여 그린다.","doWork":"완성된 동화 및 배경이 전달되면 레이아웃 등 전체적인 흐름을 파악한다. 기본 해상도와 셀 크기를 조정하여 정해진 순번대로 스캐너를 사용하여 스캔한다. 스캔 후 모니터를 보고 확인하여 선이 매끄럽게 이어지지 않는 부분이나 색선(그림자, 괴선 등)을 컴퓨터상에서 보충하여 그린다. 각각 지정된 파일에 저장한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"시범후 30일 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"4143","dJobECdNm":"[4143]만화가 및 만화영화 작가","dJobJCd":"2843","dJobJCdNm":"[2843]만화가 및 만화영화 작가","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001768:1', '{"dJobCd":"K000001768","dJobCdSeq":"1","dJobNm":"스톱모션애니메이션세트디자이너","workSum":"스톱모션애니메이션에서 캐릭터가 연기하는 촬영세트와 소품을 디자인한다.","doWork":"스톱모션애니메이션 스토리보드와 캐릭터를 분석한다. 촬영세트의 기술적인 제작 가능성, 사용 재질, 재료의 절감, 조명 및 촬영의 편리성, 효율적인 제작기간 등을 제작진과 협의한다. 제작할 세트의 수와 촬영계획에 따른 세트 제작순서를 결정한다. 스토리보드의 디자인을 구체적으로 하기 위한 자료조사를 한다. 전체적인 극의 흐름, 캐릭터의 동선과 연기, 스톱모션애니메이터가 손으로 캐릭터를 조작할 수 있는 공간, 캐릭터의 크기와 어울림 등을 고려하여 세트를 구상하고 각종 표현요소를 스케치 한다. 스케치가 완료되면 제작진과 협의하고 세트제작도면을 작성한다. 촬영 및 카메라의 편의성, 세트의 반복 활용을 위해 분리가 가능한 구조를 고안하기도 한다. 촬영 세트에 사용되는 소품을 디자인한다. 촬영 과정에서 제작진이 요구하는 수정사항에 대응하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","dJobECd":"4143","dJobECdNm":"[4143]만화가 및 만화영화 작가","dJobJCd":"2843","dJobJCdNm":"[2843]만화가 및 만화영화 작가","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003927:1', '{"dJobCd":"K000003927","dJobCdSeq":"1","dJobNm":"스톱모션애니메이션애니메이터","workSum":"스톱모션애니메이션에서 캐릭터의 연기를 만들어 내고 촬영한다.","doWork":"라이브 뷰가 가능한 카메라와 스톱모션 촬영 소프트웨어가 설치된 컴퓨터를 연결하여 촬영준비를 한다. 촬영 세트와 카메라를 완전히 고정하여 촬영 중에 구도가 변경되지 않도록 한다. 도프시트(Dope Sheet : 동작에 대한 메모나 섬네일 스케치, 대사, 셀 레이어, 카메라 지시서, 계수선이 표시된 시트)를 참조하여 캐릭터가 움직일 동선, 거리에 따른 시간, 움직임과 속도의 상관관계, 움직임에 필요한 포즈의 수를 계산한다. 세트 내에 캐릭터와 소품을 세팅하고 원하는 포즈를 만든다. 필요 없는 소품이나 도구가 화면에 나오지 않도록 정리한다. 컴퓨터 모니터의 라이브 뷰를 보고 조명과 카메라 앵글을 맞춘다. 카메라의 설정(조리개 값, 셔터스피드, 화이트 밸런스, 포커스 등)을 조작하고 원하는 장면을 연출한다. 첫 프레임을 여러 장 찍어 본 후 다음 장면을 한 컷씩 촬영한다. 라이브 뷰를 보면서 먼저 촬영한 이미지를 참고로 하여 다음 포즈를 만들어 내고 다시 촬영하기를 반복한다. 부드러운 동작이 구현되었는지 확인한다. 촬영세팅(조명 값, 카메라 설정값 등)을 신별로 기록하여 다음 촬영에 연속성과 신뢰성을 유지하도록 한다. 특수효과를 사용하기 위해 블루스크린 촬영을 하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"4143","dJobECdNm":"[4143]만화가 및 만화영화 작가","dJobJCd":"2843","dJobJCdNm":"[2843]만화가 및 만화영화 작가","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004145:1', '{"dJobCd":"K000004145","dJobCdSeq":"1","dJobNm":"스톱모션애니메이션조명원","workSum":"스톱모션애니메이션에 조명연출을 한다.","doWork":"스토리보드를 분석하고 제작팀과 협의하여 조명 계획을 수립한다. 촬영 세트가 조명연출에 적절한 상황인지, 조명기구를 세팅할 여건이 되는지, 사용할 수 있는 전기의 용량은 얼마인지 확인하고 사용할 조명기기와 전기용량을 결정한다. 다양한 조명기구를 사용하여 촬영에 있어서 카메라가 피사체에 대하여 가시성, 명료성, 극적효과를 얻을 수 있도록 기술적으로 빛을 통제한다. 각종 조명효과(벼락치기, 점점 밝아오기, 점점 어두워지기, 노을, 여명, 계절 분위기, 동굴, 터널 등)를 연출한다. 특수효과를 위한 블루스크린 촬영, 특수효과 촬영 등 특수한 조명상황에 기술적으로 대응한다. 촬영 회차, 신에 대한 설명, 노출, 감도, 렌즈치수, 카메라워킹, 반사노출, 조명기구의 점멸에 대한 정보를 기록하여 촬영 기간 일관된 조명을 연출한다. 스톱모션애니메이션의 특성에 따라 적합한 광원 및 보조기구를 고안하여 사용하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"4143","dJobECdNm":"[4143]만화가 및 만화영화 작가","dJobJCd":"2843","dJobJCdNm":"[2843]만화가 및 만화영화 작가","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002995:1', '{"dJobCd":"K000002995","dJobCdSeq":"1","dJobNm":"스톱모션애니메이션캐릭터디자이너","workSum":"스톱모션 애니메이션 캐릭터를 디자인한다.","doWork":"스톱모션애니메이션 캐릭터(애니메이션에서 애니메이팅을 통해 스토리를 전개할 배우)의 기술적인 제작 가능성, 연기(Acting, Animating)의 편의성, 재질 등을 고려한다. 시나리오를 분석하여 캐릭터의 성격, 표정, 손동작, 걸음걸이, 버릇, 말투 등 다양한 표현요소를 구상하고 초기 단계의 스케치를 한다. 스케치가 완료되면 라인드로잉(캐릭터의 외형을 확정하는, 외형선으로 그려진 그림)을 하고 컬러링하여 캐릭터를 완성한다. 모델시트(캐릭터의 자세, 표정 등을 자세히 표현하고 정확한 비율에 따라 전면, 후면, 측면, 전측면, 위의 시점에서 도안하며, 캐릭터에 사용된 색상과 캐릭터에 대한 설명이 포함된 그림)를 제작한다. 시나리오에 등장하는 소품(탈것, 소지품, 의상의 변경, 무기, 주요 배경 등)을 디자인하기도 한다. 감독, 시나리오작가, 캐릭터제작원 등과 회의를 통해 캐릭터를 수정 및 확정한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","dJobECd":"4143","dJobECdNm":"[4143]만화가 및 만화영화 작가","dJobJCd":"2843","dJobJCdNm":"[2843]만화가 및 만화영화 작가","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003667:1', '{"dJobCd":"K000003667","dJobCdSeq":"1","dJobNm":"스톱모션애니메이션캐릭터제작원","workSum":"스톱모션애니메이션 캐릭터를 제작한다.","doWork":"클레이, 실리콘, 폼 라텍스, 핫폼, 랩폼, 액화 플라스틱, 레진, 액화 고무 등 캐릭터의 재질에 따라 재료를 준비한다. 캐릭터 디자인 위에 트레이싱 페이퍼를 놓고 아마추어 와이어(Armature Wire : 캐릭터의 뼈대. 캐릭터의 동작을 지탱하고 유지하는 기능을 하는 3~4mm 두께의 철사 또는 알루미늄 튜브)의 제작도를 스케치한다. 몸통, 손, 관절, 발 부분을 와이어, 루프, 알루미늄 튜브, 자석, 볼트, 너트, 볼&로드, 소켓 등을 이용해서 아마추어를 제작한다. 라텍스 캐릭터를 제작하는 경우 아마추어 제작, 더미본 제작, 클레이 원형 제작, 클레이 베드 제작, 석고 몰드 제작, 라텍스 제조공정, 채색 작업을 진행하여 캐릭터를 제작한다. 클레이 캐릭터를 제작하는 경우 아마추어 와이어 스케치, 클레이 색 데이터 만들기, 아마추어와 얼굴 뼈대 제작, 클레이 입히기, 눈 그리기, 얼굴 만들기, 손 만들기, 머리카락 만들기, 세부 표현, 다듬기 과정을 진행하여 캐릭터를 제작한다. 랩 폼 캐릭터(Wrap Foam Character : 스펀지를 감아서 만든 캐릭터)의 경우 아마추어 제작, 폼 감기, 옷 입히기, 발 만들기 과정을 진행하여 캐릭터를 제작한다. 신 스킨 캐릭터(Thin Skin Character : 솜을 이용해 볼륨을 만들고 스타킹으로 표면을 감싼 후 액화 고무로 마감하는 제작방식)의 경우 아마추어 제작, 솜 붙이기, 스타킹 씌우기, 정리(다듬기), 액화 고무로 마무리 및 채색, 머리 만들기 과정을 진행하여 캐릭터를 제작한다. 캐릭터의 입, 눈 등을 다양하게 하여 표정 연기를 제작한다. 리그(공중에 떠 있는 장면을 연출하기 위하여 캐릭터를 매달 수 있는 와이어)를 제작한다. 촬영 중에 캐릭터가 손상되면 추가로 제작할 수 있도록 제작 과정을 보전한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"4143","dJobECdNm":"[4143]만화가 및 만화영화 작가","dJobJCd":"2843","dJobJCdNm":"[2843]만화가 및 만화영화 작가","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006027:1', '{"dJobCd":"K000006027","dJobCdSeq":"1","dJobNm":"애니메이션라이팅원","workSum":"애니메이션 제작 소프트웨어의 가상현실에 조명(Lighting)을 연출한다.","doWork":"애니메이션 제작 소프트웨어에 애니메이팅(Animating:연기)이 완료된 애니메이션 소스를 불러들인다. 애니메이션 레이아웃에 지정된 연출을 확인한다. 컴퓨터의 가상스튜디오에서 피사체에 대한 카메라의 종류, 위치, 수량, 앵글, 초점, 카메라 무빙 등 각종 카메라 테크닉을 지정한다. 애니메이션에 움직임을 주고 장면과 상황에 따라 조명의 종류와 수, 밝기 등 다양한 조명기법을 적용한다. 조명을 통해 오브젝트를 사실적으로 묘사하고, 실내, 실외, 창문, 우주, 해양, 동굴, 터널, 횃불, 전등 등 다양한 극 중 환경을 표현하며 극의 전개에 따라 불안감, 긴장감, 평안함, 계절감, 새벽, 밤 등의 분위기를 연출한다. 각 슛(Shoot:촬영을 시작하는 일)마다 렌더링하여 동영상으로 만들고 애니메이션감독, 애니메이션맵핑원, 애니메이션합성원(Composition) 등과 함께 동영상을 검토하여 수정한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"4143","dJobECdNm":"[4143]만화가 및 만화영화 작가","dJobJCd":"2843","dJobJCdNm":"[2843]만화가 및 만화영화 작가","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002203:1', '{"dJobCd":"K000002203","dJobCdSeq":"1","dJobNm":"애니메이션라인프로듀서","workSum":"애니메이션 제작 현장에서 제작에 관한 제반 사항을 관리하고 진행한다.","doWork":"애니메이션 프로듀서 및 애니메이션 감독의 지시에 따라 세부 제작계획을 수립하고 진행상황을 확인·보고한다. 제작계획에 따라 각 프로덕션 파트(원화, 동화, 레이아웃, 맵핑, 모델링 등의 파트) 및 각 파트별 전문업체의 분업을 연결하여 각 제작 단계의 작업물을 전·후의 제작 파트로 전달하며, 전달 과정에서 작업의 상세한 내용을 확인한다. 제작이 원활히 진행되도록 제반 업무를 수행하고 제작일정을 관리한다. 파트별로 계약을 체결하고 예산관리 및 진행비를 정산한다. 프로덕션 과정이 완료되면 편집, 특수효과, 음악, 사운드믹싱 등 포스트프로덕션 과정이 진행되도록 계약 및 진행업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","dJobECd":"4143","dJobECdNm":"[4143]만화가 및 만화영화 작가","dJobJCd":"2843","dJobJCdNm":"[2843]만화가 및 만화영화 작가","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004417:1', '{"dJobCd":"K000004417","dJobCdSeq":"1","dJobNm":"애니메이션레이아웃작가","workSum":"애니메이션 레이아웃(작품의 무대가 되는 배경을 구체적으로 설정)을 디자인한다.","doWork":"애니메이션 제작 소프트웨어에 모델링, 리깅 작업(캐릭터에 뼈대를 만들어서 움직이는 부분에 포인트를 부여하는 작업)이 완료된 오브젝트 소스(캐릭터, 배경, 소품 등)를 불러들인다. 애니메이션 스토리보드, 캐릭터 모델시트, 소품 설정표, 미술 설정표, 타임시트 등을 준비한다. 스토리보드에 맞추어서 각각의 컷과 신별로 배경 위에 오브젝트 소스를 배치하고 캐릭터의 위치, 카메라의 위치와 동선을 설정한다. 특수효과, 계절감, 얼굴의 방향과 시선방향, 빛의 유무, 빛의 방향, 카메라 사이즈, 카메라 앵글, 카메라의 기계적·광학적 요소 등 연출에 필요한 정보를 표시한다. 먼저 제작한 컷에 이어서 다음 컷을 연결하여 만들어 나가며 컷과 컷의 동질성(의상, 인물의 대비, 포즈, 장소와 위치, 소품의 배치, 배경 전환, 미술설정과의 관계 등)이 유지되도록 한다. 1초당 5~6프레임(완성된 애니메이션은 초당 30프레임)의 레이아웃을 만들고 각각의 레이아웃을 파일로 저장한다. 애니메이션 감독과 함께 완성된 레이아웃을 동영상으로 보면서 검토 및 수정한다. 각각의 레이아웃 파일을 기초로 애니메이터가 자세한 동작을 만들 수 있도록 설명한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","similarNm":"애니메이션레이아웃아티스트","dJobECd":"4143","dJobECdNm":"[4143]만화가 및 만화영화 작가","dJobJCd":"2843","dJobJCdNm":"[2843]만화가 및 만화영화 작가","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006138:1', '{"dJobCd":"K000006138","dJobCdSeq":"1","dJobNm":"애니메이션리깅원","workSum":"모델링된 오브젝트(캐릭터 등)를 의도한 모습으로 움직이기 위해서 가상의 골격을 디자인하고 제작하는 리깅(Rigging) 작업을 한다.","doWork":"애니메이션 제작 소프트웨어에 모델링된 오브젝트 소스(캐릭터, 배경, 소품 등)를 불러들인다. 오브젝트에 본(Bone : 뼈대)을 만든다. 본에 조인트를 만든다. 본과 오브젝트를 연결(웨이트 작업)한다. 본을 움직이면 오브젝트가 따라서 움직이도록 설정한다. 컨트롤러를 연결하여 제어한다. 오브젝트의 사실적인 움직임(가속, 감속, 포물선 운동, 불규칙 운동, 유연한 운동, 기계적인 운동 등) 및 캐릭터가 해부학적으로 자연스러운 동작(걷기, 던지기, 들기, 앉기, 돌기, 구부리기 등)이 되도록 반복적으로 테스트하고 수정하여 완성한다. 표정 연기와 립싱크(말하는 입 모양)를 위해 얼굴 부분에 리깅 작업을 하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"4143","dJobECdNm":"[4143]만화가 및 만화영화 작가","dJobJCd":"2843","dJobJCdNm":"[2843]만화가 및 만화영화 작가","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002959:1', '{"dJobCd":"K000002959","dJobCdSeq":"1","dJobNm":"애니메이션맵핑원","workSum":"오브젝트 표면(캐릭터, 배경, 소품 등)에 질감을 부여하는 맵핑(Mapping) 작업을 한다.","doWork":"애니메이션 제작 소프트웨어에 모델링, 리깅된 오브젝트 소스(캐릭터, 배경, 소품 등)를 불러들인다. 오브젝트의 재질(고무, 석고, 플라스틱, 유리, 금속, 유광, 무광, 투명, 동물의 털, 피부, 부드러움, 거침, 주름, 유연함, 딱딱함, 색상 등)을 파악하고 표현방법을 구상한다. 쉐이딩(Shading : 컴퓨터에 입력된 입체표면에 음영을 부여하는 처리 기술. 입체감을 주기 위해 각 면의 광원으로부터의 거리, 각도, 색채, 밝기 등을 계산하여 음영을 만들어 냄) 작업을 하여 질감을 만든다. 텍스쳐 맵핑에 소스로 사용되는 표면질감(Texture) 이미지를 조사하거나, 소스데이터에서 찾거나, 직접 그려서 만든다. 텍스쳐 맵핑(Texture Mapping : 미리 마련한 기하학적 패턴, 사진, 손그림의 도상 등을 입체의 표면에 사상하는 기법) 작업을 하여 더욱 사실적인 질감을 구현한다. 작업 결과물이 라이팅 작업 및 합성 작업에서 재질감이 사라지거나 변형되는지, 기술적으로 구현이 가능한지 확인하고 수정한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"청각|손사용|시각|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"애니메이션텍스처링원","dJobECd":"4143","dJobECdNm":"[4143]만화가 및 만화영화 작가","dJobJCd":"2843","dJobJCdNm":"[2843]만화가 및 만화영화 작가","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001548:1', '{"dJobCd":"K000001548","dJobCdSeq":"1","dJobNm":"애니메이션모델러","workSum":"캐릭터를 3차원으로 표현하는 모델링 작업을 한다.","doWork":"제작된 캐릭터와 배경·소품이 모델링 및 애니메이팅(캐릭터의 연기)에 문제가 없는지 검토한다. 문제가 있으면 캐릭터디자이너, 컨셉디자이너에게 조언하여 애니메이션 제작 단계에서 다시 모델링하는 상황을 방지한다. 모델링 할 캐릭터의 얼굴 형태, 근육 구조, 대사에 따른 입 모양, 표정, 동작의 특징 등을 파악하고 효율적인 작업 방법과 기술을 구상한다. 애니메이션 제작 소프트웨어상에 모델링 할 소스를 불러들인다. 애니메이션 제작 소프트웨어가 제공하는 다양한 기능(Nurbs, Splines, Radiosity, Polygon Count, x·y·z축, Extrusion, Boolean Operation, 기타 다양한 도구 등)과 모델링 기법을 활용하여 모델링한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"4143","dJobECdNm":"[4143]만화가 및 만화영화 작가","dJobJCd":"2843","dJobJCdNm":"[2843]만화가 및 만화영화 작가","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002685:1', '{"dJobCd":"K000002685","dJobCdSeq":"1","dJobNm":"애니메이션배경디자이너","workSum":"애니메이션의 배경을 디자인한다.","doWork":"애니메이션 스토리보드와 캐릭터를 분석한다. 제작기간 내에 효율적으로 작업하기 위해 제작진과 협의하여 배경작업 순서를 정한다. 스토리보드에서 제시하는 극 중 장면에 대한 자료조사를 하여 구체적인 표현방법을 구상한다. 전체적인 극의 흐름, 캐릭터의 연기, 음향, 대사 등을 고려하여 각 장면의 배경을 구상한다. 각종 표현요소를 스케치한 다음 채색한다. 제작진과 협의하고 수정하여 각 장면의 배경을 완성한다. 2D애니메이션의 경우, 포토샵, 일러스트레이터 등 그래픽 프로그램을 사용하여 디자인하고, 3D애니메이션의 경우, 3D오브젝트를 고려하여 디자인한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","dJobECd":"4143","dJobECdNm":"[4143]만화가 및 만화영화 작가","dJobJCd":"2843","dJobJCdNm":"[2843]만화가 및 만화영화 작가","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006998:1', '{"dJobCd":"K000006998","dJobCdSeq":"1","dJobNm":"애니메이션스토리보드작가","workSum":"애니메이션 스토리보드를 작성한다.","doWork":"애니메이션 제작진(애니메이션감독, 애니메이션프로듀서, 시나리오작가 등)과 회의를 통해 스토리의 구조, 캐릭터의 특징과 표현방법, 감독의 작품구상 등을 이해하고 분석한다. 필요한 자료조사를 한다. 스토리보드 포맷(한 장의 큰 종이를 사각형 여러 개로 나누어서 사용하거나, 장면별로 이미지카드를 한 장씩 할당하거나, 가로 또는 세로로 배열하거나, 화면의 비율 등)을 결정한다. 스토리의 각 섹션에 장면을 할당하여 하나의 장면에 하나의 숏 또는 키프레임이 되도록 구성한다. 작업 방법에 따라 컴퓨터 프로그램 또는 종이와 그림도구를 사용하여 각 장면을 드로잉한다. 각 장면에 필요한 설명, 작업지시, 사운드, 대사, 카메라의 이동 및 줌인-줌아웃, 각 연기요소의 움직임, 캐릭터의 위치와 동선, 특수효과, 컷의 길이(시간) 등을 표시한다. 그려진 스토리보드를 프로덕션 제작진(애니메이션감독, 애니메이션프로듀서, 시나리오작가, 모델링팀, 애니메이팅팀, 특수효과팀 등)과 협의하고 수정을 반복하여 완성한다. 애니메이션 감독과 함께 애니메틱스(Animatics 또는 Story Reel:애니메이션의 제작에 앞서 숏의 길이, 장면의 전환, 카메라의 각도, 전체적인 분위기 등을 테스트하기 위하여 스토리보드를 간단한 카메라 워킹과 시간에 맞추어서 제작한 동영상)를 제작하여 검토하고 수정작업을 하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","similarNm":"애니메이션스토리보드아티스트","dJobECd":"4143","dJobECdNm":"[4143]만화가 및 만화영화 작가","dJobJCd":"2843","dJobJCdNm":"[2843]만화가 및 만화영화 작가","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002869:1', '{"dJobCd":"K000002869","dJobCdSeq":"1","dJobNm":"애니메이션캐릭터디자이너","workSum":"시나리오를 분석하여 애니메이션 캐릭터를 디자인한다.","doWork":"시나리오를 분석하여 캐릭터의 성격, 표정, 손동작, 걸음걸이, 버릇, 말투, 의상 등 다양한 표현요소를 구상하고 초기 단계의 스케치를 한다. 스케치가 완료되면 라인드로잉(캐릭터의 외형을 확정하는, 외형선으로 그려진 그림)을 하고 컬러링하여 캐릭터를 완성한다. 모델시트(캐릭터의 자세, 표정 등을 자세히 표현하고 정확한 비율에 따라 전면, 후면, 측면, 전측면, 위의 시점에서 도안하며, 캐릭터에 사용된 색상과 캐릭터에 대한 설명이 포함된 그림)를 제작한다. 시나리오에 등장하는 소품(탈것, 소지품, 의상의 변경, 무기, 주요 배경 등)을 디자인하기도 한다. 애니메이션감독, 시나리오작가 등과 회의를 통해 캐릭터를 수정 및 확정한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","dJobECd":"4143","dJobECdNm":"[4143]만화가 및 만화영화 작가","dJobJCd":"2843","dJobJCdNm":"[2843]만화가 및 만화영화 작가","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002102:1', '{"dJobCd":"K000002102","dJobCdSeq":"1","dJobNm":"애니메이션프로듀서","workSum":"애니메이션을 기획하고 제작에 필요한 일정, 예산, 인력을 관리하고 책임진다.","doWork":"국내외 애니메이션 자료를 수집·분석하여 새롭게 제작할 애니메이션 작품을 기획하고 기획서를 작성한다. 프리프로덕션 단계에서 시나리오 작가, 디자이너, 스토리보드 작가 등과 함께 스토리 기획, 각본, 스토리보드, 레이아웃 등을 구상한다. 작품 기획의 기본 아이디어를 구체적인 스토리와 장면으로 발전시키는 스토리보드 작업을 추진한다. 전체적인 제작 흐름과 일정을 수립하고 제작인력의 수급 및 예산을 집행한다. 프로덕션 단계에서 일어날 수 있는 기술적, 구조적인 문제들을 미리 파악하여 제작이 순조롭게 진행되도록 예비한다. 프로덕션 단계에서는 2D의 경우 원화와 동화작업, 3D CG의 경우 모델링, 리깅 등의 제작 작업을 진행하고 관리한다. 후반 작업인 포스트프로덕션 단계에서는 음향효과, 사운드 믹싱, 편집, 특수효과 등의 제작 공정을 진행 및 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","similarNm":"애니메이션기획자","dJobECd":"4143","dJobECdNm":"[4143]만화가 및 만화영화 작가","dJobJCd":"2843","dJobJCdNm":"[2843]만화가 및 만화영화 작가","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004671:1', '{"dJobCd":"K000004671","dJobCdSeq":"1","dJobNm":"애니메이션합성원","workSum":"다양한 애니메이션 요소를 하나로 합성(Composition)하여 동영상 파일로 인코딩한다.","doWork":"애니메이션의 전체적인 흐름과 편집방향(스토리, 감독의 의도 등)을 확인한다. 편집 프로그램의 컴포지션 창에 렌더링 작업 결과로 만들어진 시퀀스(Sequence:특정 상황의 시작부터 끝까지를 묘사하는 영상 단락 구분. 몇 개의 신(Scene)이 한 시퀀스를 이룸)와 각종 특수효과(시각효과, 음향효과 등)를 불러들인다. 각각의 소스를 연결하면서 특수효과의 삽입, 장면전환, 립싱크, 음악, 장면조정, 러닝타임 조정 등의 최종편집 작업을 한다. 애니메이션 감독과 함께 검토 및 수정한다. 동영상 파일로 인코딩한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"4143","dJobECdNm":"[4143]만화가 및 만화영화 작가","dJobJCd":"2843","dJobJCdNm":"[2843]만화가 및 만화영화 작가","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007113:1', '{"dJobCd":"K000007113","dJobCdSeq":"1","dJobNm":"원화원","workSum":"콘티에 따라 캐릭터의 움직이는 장면의 주요 키(Key)가 되는 그림을 그린다.","doWork":"컴퓨터애니메이션감독, 원화작화감독 등과 애니메이션의 전개 라인이나 캐릭터의 성격 등을 파악하여 작화에 대해 논의한다. 콘티라이터가 그린 콘티를 보고 애니메이션에 등장하는 캐릭터가 행동할 동작을 구상한다. 화면의 레이아웃을 잡고 캐릭터의 모든 동작에 대하여 처음과 끝을 연필로 종이에 그린다. 원화와 원화 사이의 시간을 결정하고 타임시트를 작성한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"원화맨, 키애니메이터","dJobECd":"4143","dJobECdNm":"[4143]만화가 및 만화영화 작가","dJobJCd":"2843","dJobJCdNm":"[2843]만화가 및 만화영화 작가","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;