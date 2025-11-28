INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002093:1', '{"dJobCd":"K000002093","dJobCdSeq":"1","dJobNm":"협회사무장","workSum":"협회원의 권익옹호 및 협력증진을 위해 회의와 행사를 주관하고 협회 사무원의 활동을 감독한다.","doWork":"협회 운영과 관련된 정책을 수립한다. 협회 소속 직원의 인사와 업무를 조정한다. 협회의 기능과 역할을 알리기 위해 대외적인 홍보활동을 총괄한다. 협회 차원의 각종 행사를 총괄한다. 이사회에서 간사 역할을 수행한다. 협회 회원들을 대표해서 이들의 권익보호를 위한 업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"협회사무국장, 협회사무총장","connectJob":"회원단체사무국장","dJobECd":"0159","dJobECdNm":"[0159]기타 판매 및 고객서비스 관리자","dJobJCd":"1590","dJobJCdNm":"[1590]기타 판매 및 고객 서비스 관리자","dJobICd":"S941","dJobICdNm":"[S941]산업 및 전문가 단체","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006465:1', '{"dJobCd":"K000006465","dJobCdSeq":"1","dJobNm":"곤충연구원","workSum":"농업분야의 유용곤충 자원을 탐색·증식하고, 새로운 유용곤충을 개발한다.","doWork":"국내의 자생 유용곤충자원을 수집·탐색한다. 곤충의 분류체계를 확립한다. 곤충인공사료의 개발 및 실용화, 곤충자원의 확보, 계대(繼代:계통적으로 세대를 이어나가는 것) 사육법 확립 및 곤충자원 관리시스템 정립 등 곤충보존에 관한 연구를 한다. 유용곤충의 병해충 및 미생물 이용에 관한 기술개발을 한다. 곤충을 이용한 자연생태계 보전 및 환경평가를 한다. 유용곤충의 유전정보를 해석하고 이용기술을 개발한다. 곤충 및 관련 산물로부터의 신기능성 물질을 개발하기 위한 연구를 한다. 곤충농업의 소재발굴로 새로운 농업작목을 구축하기 위한 연구를 한다. 곤충단백질의 바이오소재 개발 및 곤충산물의 신소재 개발을 위한 소재응용연구를 한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"곤충을 연구하는 전문분야에 따라 곤충자원연구원, 곤충이용연구원, 잠업기술개발 및 잠종 생산·보급 양봉과 관련된 벌에 대한 품종개량 등에 대한 연구를 하는 경우 잠사양봉연구원","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001809:1', '{"dJobCd":"K000001809","dJobCdSeq":"1","dJobNm":"과수연구원","workSum":"과수의 품종육성 및 육종 기술개발 및 재배기술개발 등을 위한 연구를 한다.","doWork":"과수 품종육성, 유전 및 육종기술 개발에 관한 연구를 수행한다. 과수 유전자원 수집·평가 및 보존에 관한 연구를 수행하고 유전자원에 대한 정보를 관리한다. 과수 재배방법 개선, 스마트 과원 조성 기술을 개발한다. 재해경감에 관한 연구를 수행하고 기후변화 영향평가 및 대응기술을 개발한다. 과수 무병묘 생산·보급 등 번식에 관한 연구를 한다. 과수 생리장해 원인구명과 대책, 물질생산 및 성숙생리 등 생리·생태에 관한 연구를 수행한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"웅크림|시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"연구분야에 따라 과수육종연구원, 과수재배연구원","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006079:1', '{"dJobCd":"K000006079","dJobCdSeq":"1","dJobNm":"관상어종자전문가","workSum":"새로운 관상어종자를 연구하고 시험하여 개발하며 관련하여 관계자에게 교육하고 보급한다.","doWork":"새로운 관상어종자를 개발하기 위하여 관상어가 보유하고 있는 개체의 유전적 능력을 이용하여 가장 우수한 집단을 선별한다. 이들 집단의 선택적인 인위교배 또는 우량형질을 가진 다른 두 종 간의 교배를 통해 새로운 관상어종자를 개발한다. 개발된 관상어종자를 유통업자 및 양식업자 등 관계자에게 판매하거나 기술을 이전한다. 관리방법 등에 대한 교육을 실시하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workEnv":"다습|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"관상어브리더","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"A032","dJobICdNm":"[A032]양식어업 및 어업관련 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003079:1', '{"dJobCd":"K000003079","dJobCdSeq":"1","dJobNm":"국민보건연구원","workSum":"국민보건과 관련된 조사, 연구 및 보건지식을 보급한다.","doWork":"보건의료의 계획을 수립한다. 보건의료인력의 활용방법에 대하여 연구한다. 전문분야에 따라 보건통계, 보건정보과학, 질병제어, 보험체계 개발 등의 업무를 수행한다. 환경오염과 피해도를 조사·분석한다. 산업보건을 위해 실태를 조사·연구한다. 국내외 보건 관련 정보를 수집하여 정리 및 분석한다. 보건 관련 지식을 일반인들에게 교육한다. 보건 관련 홍보를 지원한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"연구분야에 따라 만성병역학연구원, 감염병역학연구원, 분자유전체역학연구원, 보건통계연구원, 보건정보관리연구원, 노인가족보건연구원, 보건영양연구원, 산업보건연구원, 환경질환평가관리연구원, 보건정책연구원, 보건경제경영연구원, 보건교육연구원","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003758:1', '{"dJobCd":"K000003758","dJobCdSeq":"1","dJobNm":"국민체력과학연구원","workSum":"기초·임상의학 및 관련 분야의 연구를 통하여 국민건강의 증진방안을 연구하고 결과를 보급·홍보한다.","doWork":"인체의 작업 및 운동의 능력, 저항력, 피로회복에 관하여 연구한다. 체력측정, 영양섭취 실태 등을 조사하여 인체의 대사 및 영양에 대하여 연구한다. 청소년 및 성인, 남녀 성별에 따른 신체발육 및 체질에 관하여 연구한다. 국민 기초체력의 향상을 위해 보건교육에 관하여 연구한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004156:1', '{"dJobCd":"K000004156","dJobCdSeq":"1","dJobNm":"나노바이오연구원","workSum":"생명체를 구성하는 바이오 물질을 나노미터 크기의 수준에서 조작·제어하기위해 연구, 개발, 시험 업무를 한다.","doWork":"단백질칩, DNA칩, 랩온어칩(Lab on a Chip:바이오칩의 일종으로 손톱만 한 크기의 칩 하나로 실험실에서 할 수 있는 연구를 수행할 수 있도록 만든 장치), 진단시약, 바이오센서기기, 의료용 미세전자기계시스템(Bio-MEMS), 나노머시닝(Nano Machining) 등 나노바이오 관련 핵심기술에 관해 연구한다. 연구를 통해 임상분석기기, 진단기기, 생체재생, 항암제, 신의약품, 펩타이드 및 단백질  등의 생산을 하기 위해 각종 응용분야에 관해 연구한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"바이오화학제품제조기사(구.생물공학기사), 화공기사, 화학분석기사","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003103:1', '{"dJobCd":"K000003103","dJobCdSeq":"1","dJobNm":"농업기술정보화연구원","workSum":"농업 관련 정보를 개발하고 정보를 농가 및 농업법인체 등에 제공하기 위한 연구를 한다.","doWork":"농업 관련 시험연구의 통계모형과 통계분석프로그램을 개발하기 위한 연구를 한다. 농업과학기술을 개발·보급하기 위한 전산시스템을 구축한다. 농업연구에 대한 각종 기술정보의 전산화 및 농업용 각종 프로그램을 개발하고 보급한다. 농촌진흥사업을 위한 전산장비의 관리 및 전산망의 운영과 교육을 한다. 농업 관련 각종 정보를 관리하고 체계적으로 보존한다. 국내외 농업기술에 관한 문헌정보를 수집하고 관리한다. 농업 관련 문헌정보의 이용 및 기술정보의 개발과 유지, 관리를 한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"농업기술정보를 개발하고 보급하기 위한 전문분야에 따라 농업정보개발연구원, 농업통계분석연구원","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003991:1', '{"dJobCd":"K000003991","dJobCdSeq":"1","dJobNm":"농업생화학연구원","workSum":"농업 관련 신물질 및 신품종에 대한 기초기술 개발을 위하여 생체의 효소특성 및 생리대상에 관한 연구를 한다.","doWork":"생체의 효소특성 및 생리대상에 관한 연구를 한다. 핵산물질의 구조, 재조합 및 전환에 관한 연구를 한다. 방사성 및 비방사성 동위원소를 이용한 작물대상에 관한 연구를 한다. 방사성물질의 이용 및 안전관리에 대한 기술지원을 한다. 약리활성물질의 개발에 따른 이용에 관한 연구를 한다. 유전자 재조합에 따른 작물의 안전성에 대한 연구를 한다. 생물자원에 관한 국제협약과 관련하여 대책 및 방안을 수립한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"농업생화학에 대한 전문연구분야에 따라 기능성물질생합성연구원, 대사조절연구원, 생물화학농약연구원, 천연물화학연구원, 농업유해물질안전성관리연구원, 농산물위생품질관리연구원, 축산물위생품질관리연구원, 잔류농약중금속독성연구원, 미생물독소연구원","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004289:1', '{"dJobCd":"K000004289","dJobCdSeq":"1","dJobNm":"농업해충연구원","workSum":"농업에 영향을 미치는 해충에 대한 종합관리기술을 개발하기 위한 연구를 한다.","doWork":"해충 및 익충의 분류, 동정 및 분포에 관한 연구를 한다. 해충의 생리, 생태 및 피해해석에 관한 연구를 한다. 해충에 대한 작물의 저항성에 관한 연구를 한다. 해충방제용 천적자원의 개발 및 이용에 관한 연구를 한다. 해충의 종합관리기술개발에 관한 연구를 한다. 해충방제 및 약제저항성에 관한 연구를 한다. 우수살충제의 선정 및 사용방법에 관한 시험과 연구를 한다. 식물기생 선충(線蟲:선형(원형)동물에 속하는 실모양의 벌레)의 분류·동정, 생리·생태 및 방제에 관한 연구를 한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"농업에 영향을 미치는 해충에 관하여 연구하는 전문분야에 따라 곤충분류연구원, 곤충생리생태연구원, 해충천적연구원, 해충방제연구원, 선충연구원","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004632:1', '{"dJobCd":"K000004632","dJobCdSeq":"1","dJobNm":"농업환경생태연구원","workSum":"각종 환경오염 및 기후변화로부터 농업환경 및 생태계를 보전하기 위한 연구를 한다.","doWork":"토양과 농작물에 대한 유해물질조사 및 안전기준을 설정한다. 각종 유해물질에 대한 농작물 피해분석을 통한 농작물 피해예방과 안전농작물 생산을 위한 연구를 한다. 농업과 관련된 폐기물 조사 및 농업적 이용성 평가와 폐기물에 의한 환경영향평가방법을 개발하여 유용한 폐자원의 농업적 활용과 관리기술의 개발 및 농업환경오염방지를 위한 연구를 한다. 친환경농업기술을 개발하고 농가에 보급한다. 농업환경변동에 따른 농업환경평가에 대한 연구를 통하여 체계적인 친환경농업관리를 개발한다. 농업환경변화에 따른 농업생태계의 영향평가, 농경지 미소동물(微小動物:육안으로 보이지 않는 동물)의 생태와 기능평가 등을 통한 농업생태계의 안정화 및 지속성 확보를 위한 기술개발을 연구한다. 기후에 따른 농업자원 분포 및 변동조사, 농경지 온실가스배출 저감기술개발 등에 대한 연구를 한다. 농업기후평가 및 감시로 농작물 생산의 안전성 확보와 기상재해에 대한 대책을 수립한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"농업환경생태를 연구하는 전문분야에 따라 농업환경오염연구원, 농업폐자원관리연구원, 농업환경영양평가연구원, 농업생태계연구원, 농업기상연구원, 식물검역연구원, 형질전환식물안정성관리연구원, 농업생태계관리연구원, 농업환경정화연구원, 농업기후변화대응연구원, 바이오메스연구원, 농업자원활용연구원","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005590:1', '{"dJobCd":"K000005590","dJobCdSeq":"1","dJobNm":"단백질의약품세포주개발원","workSum":"단백질의약품의 배양을 위해 안정성과 생산성 등을 고려한 최적화된 세포주를 연구·개발한다.","doWork":"단백질의약품의 배양에 사용되는 세포주를 개발하기 위해 목표유전자가 들어있는 재조합유전자와 선별용 유전자 벡터(유전자를 운반하는 역할을 하는 DNA 분자)를 다양한 동물세포에 이식하고, 형질전환이 안된 세포들이 못 자라는 선별조건하에서 형질전환세포들을 골라(스크리닝)낸다. 여러 세포주를 비교 시험하여 타깃단백질을 과량 발현하는 세포주를 선별하고 발현 후 보조적 단백질 발현(배지로의 배출을 용이하게 하거나, 배지 내에서 목적단백질의 분해를 막는 등의 역할을 함) 조절이 용이하고 배양 시 변형이 없고 성장성과 생산성이 높은 조건을 가진 세포주를 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"시각|","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"바이오화학제품제조기사","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"C211","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001390:1', '{"dJobCd":"K000001390","dJobCdSeq":"1","dJobNm":"단백질의약품연구원","workSum":"단백질의약품을 개발하기 위해 치료후보물질을 발굴, 변형하고 세포주를 구축하며 배양/정제하여 효능을 탐색한다.","doWork":"단백질의약품을 개발하기 위해 사람이나 다른 생물체에서 유래된 단백질, 유전자, 세포 등의 원료를 연구하여 후보물질을 선정한다. 특정 유전자의 배열순서를 바꾸거나 다른 유전자와의 조합을 통하여 지금까지와는 다른 유전자의 조합을 만들고 생물정보학(Bioinformatics), 유전체학(Genomics), 영상검사 기법 및 물성물리학(Materials Science) 등의 방법을 활용하여 후보물질이 인체 및 질병의 병태생리에 미치는 영향을 관찰하여 치료효과를 탐색한다.(생략)","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"시각|","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"단백질신약연구원, 바이오시밀러연구원, 바이오베터연구원","certLic":"바이오화학제품제조기사","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"C211","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005884:1', '{"dJobCd":"K000005884","dJobCdSeq":"1","dJobNm":"담배재배연구원","workSum":"잎담배의 생산성 및 품질향상을 위하여 재배방법의 개선, 신품종개발, 토양비료연구, 병충해방제법, 건조방법 개선 등에 대하여 시험·연구한다.","doWork":"효율적인 연구수행을 위하여 국내외 학술 및 산업정보를 수집하고 연구계획을 수립한다. 재배법 개선을 위하여 각종 시험기기를 사용하여 연초의 작황진단, 환경요인과 담배생산성과의 관계분석, 담배품종별 생산성 및 품질에 관한 실험을 수행한다. 우량품종개발을 위하여 인공교배법을 이용하여 우량계통을 선별하고 산지적응시험을 한다. 질 좋은 잎담배의 수량증대 및 생산비절감을 위한 적정비료공급의 강구와 식물의 영양생리에 관한 기초이론을 연구한다. 연초산지에서 병충해 발생실태를 조사한다. 각종 기기를 사용하여 입고병(立枯病), 공동병균, 바이러스병, 해충 및 저장 시의 해충에 관한 시험연구를 실시하고 방제법을 개발한다. 담배제조용도에 적합한 원료 잎담배를 생산하기 위한 건조장비개선, 건조엽의 품질향상, 건조비용절감에 대해 시험·연구한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"웅크림|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"연구하는 전문분야에 따라 담배병충해연구원, 담배비료토양연구원, 담배육종연구원, 잎담배건조연구원","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"C120","dJobICdNm":"[C120]담배 제조업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004032:1', '{"dJobCd":"K000004032","dJobCdSeq":"1","dJobNm":"도시농업연구원","workSum":"환경조경, 치유농업, 생활농업 발전을 위하여 환경정화식물 연구, 옥상·벽면녹화, 치유농장 조성·관리기술, 교육·치유형 농업 콘텐츠 개발, 농업활동의 교육·치유 효과 등을 연구·개발한다.","doWork":"식물을 활용한 도시공간 개선연구를 하기 위해 다양한 공간의(실내, 옥상, 입면 등) 녹화연구를 한다. 식물의 환경정화 효과 및 식물 활용 환경개선 시스템을 연구한다. 치유농업 서비스 활성화를 위한 법률 및 제도 지원 여구를 수행한다. 치유농장 조성 및 관리기술, 치유농업 운영 모델 개발 및 치유농장 자원·부자재 개발 연구를 수행한다. 치유형 농업 콘텐츠 개발 및 효과 구명 연구를 수행한다. 텃밭정원 소재발굴 및 가치평가, 도시·학교 텃밭 조성 모델 및 관리기술을 개발한다. 스마트 실내재배기 개발 및 스마트 농업연계 초중고 학교교육 활용 콘텐츠를 개발한다. 교육형 농업 콘텐츠 개발 및 농업의 교육 효과 구명 연구를 수행한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"웅크림|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001555:1', '{"dJobCd":"K000001555","dJobCdSeq":"1","dJobNm":"독성시험연구원","workSum":"화장품, 의료기기, 의약품, 나노제품, 동물용 약품 등에서 함유된 화학물질, 바이오물질(이하 물질)의 독성이 인간, 동물, 식물 등의 생리학적 기능이나 환경에 미치는 영향 등을 조사, 시험, 연구, 평가한다.","doWork":"실험동물, 인간 유래 세포 또는 조직, 식물을 대상으로 물질의 독성 측면의 영향 연구 및 시험을 기획·설계한다. 물질의 시험분석을 위한 샘플을 수집 및 가공한다. 생물학적 및 생화학적 기술을 바탕으로 시험장비, 설비 및 도구(예, 혈액학분석기, 전해질 분석기 등)를 사용하여 실험동물 등을 대상으로 안전성에 대한 평가를 위해 각종 시험을 하고 관찰한다. 시험결과를 토대로 독성유무 및 독성원인을 분석하고 해석·평가하여 보고서를 작성한다. 관련 물질의 특성에 대해 정부, 산업계에 알리고 노출 예방 방법 등에 대해 조언한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"독성전문가, 독성시험원, 독성연구원","connectJob":"의약품 비임상시험연구원, 수의학연구원, 식품학연구원, 의학연구원","certLic":"독성전문가, 독성병리전문가(학회자격)","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"ALL","dJobICdNm":"[ALL]전체","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002339:1', '{"dJobCd":"K000002339","dJobCdSeq":"1","dJobNm":"동물백신개발연구원","workSum":"동물의 질병치료와 예방에 사용되는 백신을 개발 및 연구한다.","doWork":"동물 백신을 개발하기 위해 백신개발방법을 연구하고 후보물질을 탐색한 후 세포배양등의 과정을 거쳐 백신을 제조한 다음 혈청학적인 검사결과를 토대로 백신의 효능에 대해 평가한다. 또한, 질병테스트기법 및 진단키트를 개발한다. 질병에 대해서 고객과 상담하고 적합한 백신을 추천하며 고객을 대상으로 동물백신 사용에 대하여 조언하기도 한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"수의사, 약사","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"C212","dJobICdNm":"[C212]의약품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001699:1', '{"dJobCd":"K000001699","dJobCdSeq":"1","dJobNm":"동물병리학연구원","workSum":"환경유해인자로 인한 동물의 질환발생을 예측·예방하기 위해 조사·연구한다.","doWork":"동물에 발생한 질병을 분석하기 위해 세포, 조직 및 장기에 나타나는 형태학적 및 기능적 소견을 연구하고 환경유해인자로 인한 동물의 질환발생을 예측·예방하기 위해 국내외 질병발생 정보 등을 수집하고 질병에 대한 정보를 조사한다. 질병의 방지를 위해 조류인플루엔자(AI:Avian Influenza) 등 야생동물 관련 인수공통전염병 조사·연구 등의 업무를 수행한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.’","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"수의병리학연구원","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004233:1', '{"dJobCd":"K000004233","dJobCdSeq":"1","dJobNm":"동물자원과학연구원","workSum":"동물유전자원, 동물유전·육종, 동물생명공학, 동물번식생리, 동물영양생리, 동물사료 및 조사료, 동물소재공학, 동물시설·환경 등에 대한 연구를 수행한다.","doWork":"동물유전자원(Animal Genetic Resources) 분야의 경우, 효과적인 유전개량프로그램의 이용과 유전자정보, 분자, 통계적 유전학에 관련된 기술을 응용하여 농업적으로 중요한 동물종들에 대한 효율적인 생산성 향상에 대한 연구를 수행한다. 동물유전·육종(Animal Genetics·Breeding)분야의 경우, 동물의 유전적인 특성을 이해하고 교잡 및 개량을 통해 생산성이 향상된 품종을 육성하는 기술을 연구한다. 동물생명공학(Animal Biotechnology)분야의 경우, 동물의 유전자 기능분석 및 이용, 형질전환 및 복제동물의 개발 등의 생명공학 기술을 이용한 동물 생산성향상기술을 연구한다. 동물번식생리(Animals’ Reproductive Physiology)분야의 경우, 우량특성을 유지·개선할 수 있는 효과적인 번식기술을 개발한다. 동물영양생리(Animals’ Nutrition Physiology)분야의 경우, 영양소 이용상의 분자와 세포의 생태, 소화작용, 신진대사, 사육과정기술을 포함한 동물 생산성향상을 위한 영양소 이용의 효율성 향상에 관한 연구를 수행한다. 동물사료·조사료 (Animal Feeds·Bulky Feeds) 분야의 경우, 영양효율개선 및 강화방안의 개발을 통한 축산생산성을 향상시킬 수 있는 동물사료와 조사료에 관한 연구를 수행한다. 동물소재공학(Place Engineering for Animals)분야의 경우, 인간이 정신적·육체적 건강증진을 위하여 동물을 이해하고 보호하며 첨단생명공학기술을 이용하여 동물이 가지고 있는 다양한 소재연구를 수행한다. 동물시설·환경(Facility and Environment for Animals)분야의 경우 환경친화적인 동물시설(축사) 및 환경의 개선에 관한 연구를 수행한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|청각|손사용|언어력|시각|","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"동물유전자원연구원, 동물유전육종연구원, 동물생명공학연구원, 동물번식생리연구원, 동물영양생리연구원, 동물사료연구원, 동물소재공학연구원, 동물시설환경연구원","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005586:1', '{"dJobCd":"K000005586","dJobCdSeq":"1","dJobNm":"미생물발효연구원","workSum":"발효미생물의 생산능력을 높이도록 개량하고 배양하는 기술을 연구한다.","doWork":"학회지, 전문잡지, 특허 등의 최신정보 검토 및 시장조사를 통하여 최신 기술동향을 분석한다. 최신 기술동향에 따라 실험계획을 수립하여 실험을 수행하고 결과를 분석한다. 미생물을 개량하기 위하여 돌연변이 유발원(Mutagen), 자외선(Ultra Violet Light)을 사용한 고전적인 변이유도방법을 사용하거나, DNA조작 등에 의한 변이체를 만든다. 최소배지(Minimal Medium)를 이용하여 변이된 미생물을 증식한다. 각종 분석기기(적정분석기, 고속액체크로마토그래프(HPLC:High Pressure Liquid Chromatograph), Spectrometer, 효소분석기, 아미노산분석기, 가스크로마토그래프, 적외선 분광기(NIR:Near Infra Red)를 사용하여 결과를 분석하고 적합한 미생물을 선별한다. 선별된 미생물의 최적 배양조건을 검토하고, 생산에 적합하도록 시범생산(Pilot Test)을 한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"식품기사, 바이오화학제품제조기사","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005127:1', '{"dJobCd":"K000005127","dJobCdSeq":"1","dJobNm":"미생물의약연구원","workSum":"미생물을 이용한 의약품을 개발하기 위해 미생물 발효를 이용한 연구 및 생산기술을 개발한다.","doWork":"국내외의 문헌, 논문 등 각종 정보를 통해 의약품으로 효과가 있는 동물의 분비선과 기관, 분비물의 가공품 및 추출물, 해파린과 그 염 및 기타 의료용 동물성조제품, 미생물 및 그 배양액, 동식물 세포배양액 등 대상물을 선정한다. 시장조사, 감가상각비, 원가 등을 계산하여 사업성을 검토한다. 무균시험실 및 미생물시험실에서 의약품을 추출하기 위하여 유전자 조작, 발효기술, 균주 육종기술, 회수정제, 유기정제, 단백질 정제기술을 개발한다. 스크리닝(Screening :일정한 특성을 가진 개체만을 고르는 것)을 통하여 미생물실험을 연구하고 생산기술을 개발한다. 박테리아, 바이러스 또는 기타 미생물을 함유한 항혈청, 세균백신, 독소 및 유사제품 및 생리활성물질을 연구 및 실험제조하여 양산공정에 적용한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"10년 초과","workStrong":"보통 작업","workPlace":"실내","physicalAct":"시각|","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"바이오화학제품제조기사","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"C211","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005745:1', '{"dJobCd":"K000005745","dJobCdSeq":"1","dJobNm":"미생물학연구원","workSum":"미생물의 본질과 특성을 연구하여 자연과학지식을 증진하고, 산업·의료분야에 적용하기 위하여 연구·개발한다.","doWork":"세균과 기타 미생물을 분리하고 세균배양실험을 한다. 실험결과를 검사·분석하고 세균의 성장과 번식을 촉진·통제하는 조건을 측정한다. 세균이 동물, 식물, 식품 등의 생명조직과 무생물에 미치는 영향을 확인하고 그 과정에서 발생하는 산, 알콜, 효소 및 기타 물질의 화학적 성질을 측정한다. 미생물의 생리학 및 형태학에 관한 미시적 검사, 배양특징에 관한 현미경검사 등을 수행한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"세균학자","connectJob":"세균학의 특수분야에 따라 공업세균연구원, 낙농세균연구원, 바이러스연구원, 산업세균연구원, 식품세균연구원, 약학세균연구원, 어류세균연구원, 의학세균연구원, 토양세균연구원, 수질세균연구원","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006972:1', '{"dJobCd":"K000006972","dJobCdSeq":"1","dJobNm":"바이오의약품임상·비임상연구원","workSum":"신약 후보물질에 대한 약효평가, 부작용 및 독성 평가, 약동력학적 연구, 약리작용의 설명을 위해 안정성 시험, 임상 평가, 비임상 평가 등의 업무를 수행한다.","doWork":"비임상시험에 대한 항목별 시험방법, 투여량, 시험일정, 필요 생산량을 결정하고 수행 일정, 소요자원 및 비용계획을 수립한다. in vitro 및 비임상 in vivo 흡수, 분포, 대사, 배설 시험을 수행하고, 효능평가 실험을 수행하여 평가 의약품의 약효평가, 약동력학 결과보고서를 작성한다. 산출된 비임상 약동력학적 파라미터와 약효평가 결과를 바탕으로 컴퓨터 프로그램을 활용하여 약동력학 모델링을 실시한다. 안전성 약리시험과 평가의약품의 특성 및 독성시험을 수행하고, 평가 시험물질의 안전성 여부를 판단할 수 있는 보고서를 작성한다. 임상계획서 항목의 임상시험의 명칭, 배경목적, 단계, 실시기관 정보, 참여 인력, 의뢰자 정보, 사용되는 의약품 정보를 작성 및 검토한다. 이론적 근거와 목적, 대상 환자군, 치료, 기간, 1차 평가변수 등을 간략히 요약 기술하여 보고서의 서론을 작성하고, 임상시험 설계 및 계획에 대하여 모니터링하고 실시한 내용을 작성한다. 임상시험의 유효성/안전성 평가 결과와 유익성, 위해성 관계를 바탕으로 고찰 및 결론을 작성한다. 평가된 안정성, 유익성 결과를 바탕으로 작성된 임상시험 결과보고서를 검토한다. 임상시험용 의약품이 시판 허가된 의약품으로 임상시험에 사용 가능한지 타당성 여부를 검토한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"C211/M701","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업 / [M701]자연과학 및 공학 연구개발업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007401:1', '{"dJobCd":"K000007401","dJobCdSeq":"1","dJobNm":"바이오의약품제제연구원","workSum":"원료바이오의약품의 특성, 완제바이오의약품의 조성 및 제조방법을 연구하고 최적화하기 위해 제형 개발, 구조물성 분석, 시험법 개발 등의 업무를 수행한다.","doWork":"제형 개발 계획서 작성 및 물리화학적 변화 여부에 대하여 분석하고 예비 제형, 최적화된 제형 조성을 선정한다. 제형 개발 보고서를 작성하고 용기 적합성 평가계획을 수립하여 상호 반응성 평가 후 적합성 평가 보고서를 작성한다. 구조특성 평가용 표준작업 절차서를 작성하고 단백질 의약의 아미노산 서열 분석, 고차 구조 특성 평가, 말단 아미노산의 서열을 확인한다. 물리화학적 특성 평가용 표준 작업절차서를 작성하고 당 단백질 의약의 당 함량, 당 결합 위치 등의 조성 특성 분석, 물리화학적 성질에 대한 분석결과를 문서화한다. 연구개발 및 상용화에 필요한 시험법의 종류 선정, 다양한 시험조건들에 대한 영향 실험, 시험표준품 후보군 확보, 확정, 제품 품질특성에 관련된 시험법 선정과 검증계획서에 따라 검증을 실시한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"C211","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007336:1', '{"dJobCd":"K000007336","dJobCdSeq":"1","dJobNm":"바이오의약품후보물질발굴연구원","workSum":"후보물질의 스크리닝을 통해 목표특성에 맞는 후보물질을 찾고 배양공정에서 요구되는 세포주를 확보하기 위해 생산 세포주를 개발한다.","doWork":"후보물질 선별, 개선점 파악, 개선항목 달성 여부를 확인하고 최종 후보물질을 선정한다. 유전자발현 구성체 표준작업 절차서를 작성하고, 유전자 발현체를 제조한 후 발현 구성체의 유전자 서열을 문서화한다. 마스터세포은행(MCB) 제조 및 제조용 세포은행(WCB) 제조, 세포은행 유전자발현 구성체 검증, 유지관리에 관한 표준작업 절차서를 작성한다. 바이오 의약품 구조특성 평가용 표준 작업절차서를 작성하고, 단백질 의약의 아미노산 서열 분석, 분광학적 방법으로 단백질 의약 고차 구조특성을 평가한다. 단백질 의약에서 디설파이드 위치 평가, 단백질 의약 말단 아미노산 서열 확인, 단백질의 1차 및 고차 구조특성 분석결과를 문서화한다. 분자량, 분광학적 성질, 전기 역동적 성질을 분석하여 당 단백질 의약의 당 함량, 당 결합 위치 등의 조성 특성을 파악한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","connectJob":"의약품연구원","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"C211","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002541:1', '{"dJobCd":"K000002541","dJobCdSeq":"1","dJobNm":"버섯연구원","workSum":"버섯 신품종 개발 및 재배 환경관리에 관한 연구를 한다.","doWork":"유용한 버섯유전자원 정보에 대한 체계적인 분류를 통하여 자원의 개발 및 이용에 관한 연구를 한다. 버섯유전자원의 생리, 생태 및 생화학적 특성 연구를 한다. 내병성·양질다수성의 버섯우량품종을 육성하기 위하여 형질전환 및 유전양식과 중간모본육성을 위한 연구를 한다. 유용한 버섯자원을 개발한다. 버섯류의 기능탐색 및 이용에 관한 연구를 한다. 버섯을 병해충으로부터 종합적인 방제 및 관리를 위한 연구를 한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|시각|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"버섯을 연구하는 전문분야에 따라 버섯유전육종연구원, 버섯자원개발연구원, 버섯환경연구원, 미생물자원에 대한 연구를 통하여 유용한 자원을 개발하기 위한 연구를 하는 경우 응용미생물연구원","certLic":"버섯종균기능사, 버섯산업기사, 식물보호기사","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006973:1', '{"dJobCd":"K000006973","dJobCdSeq":"1","dJobNm":"버섯육종가","workSum":"버섯의 생리, 생태학적 특성을 이해하고 새로운 품종을 개발, 육종하며, 버섯유전자원의 가치제고를 위한 연구를 한다.","doWork":"버섯유전자원을 수집, 보존하고 버섯의 포자, 자실체 등을 이용하여 교잡육종, 선발육종 등의 숙련기술을 통해 새로운 신품종을 개발 육종한다. 내병성·양질다수성의 버섯우량품종을 육성하기 위하여 형질전환 및 유전양식과 모본육성을 위한 연구를 한다. 새로운 품종의 분자생물학적 특성 또는 구별 마커 등을 개발 연구한다. 육성 모본의 체계적인 관리와 보존을 한다. 버섯자원의 생리활성 물질 탐색과 발굴 및 기능성 약리물질을 연구한다. 버섯의 새로운 소득품목을 개발한다. 버섯유전자원중 균근성(송이 등) 버섯에 대한 생리, 생태 연구를 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"버섯개발자, 버섯생리학자, 버섯생태학자","connectJob":"버섯품종개발자, 버섯분류학자","certLic":"버섯종균기능사, 버섯산업기사, 식물보호기사, 종자기술사, 종자기사","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005740:1', '{"dJobCd":"K000005740","dJobCdSeq":"1","dJobNm":"병리학연구원","workSum":"질병의 본질, 원인, 통제방법을 밝히기 위하여 발병의 상태, 병원체의 조직과 구조, 신체기관의 질병에 대한 형태 및 기능변화 등을 연구한다.","doWork":"질병의 성격, 진전단계, 감염가능성 등을 조사하기 위해 신체분비액 및 조직의 표본을 채취하여 병원체를 분리한다. 병원체의 습관, 생활주기, 영향력 등을 조사·분석하여 병원인자를 파괴하거나 통제할 수 있는 방법을 연구한다. 질병의 잠복기간, 중간숙주 및 매개체의 종류 등을 조사한다. 검시하여 사인, 병인 및 치료의 효과요인 등을 조사하기도 한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"분석","workFunc2":"자문","workFunc3":"정밀작업","connectJob":"법정병리학연구원, 식물병리학연구원, 신경병리학연구원, 외과병리학연구원, 의학병리학연구원, 조직병리학연구원","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007341:1', '{"dJobCd":"K000007341","dJobCdSeq":"1","dJobNm":"부유생물연구원","workSum":"적조, 해파리 등 부유생물에 대해 연구한다.","doWork":"적조상황자료를 수집·분석하여 적조예보를 발령한다. 시험조사선을 타고 바다에 나가 적조에 대해 조사한다. 전자현미경, 형광현미경, 수질측정기 등을 사용하여 적조생물의 생리 및 생태적 특성을 연구한다. 환경을 보존하면서 적조피해를 최소화하는 기술을 개발한다. 해파리 분포 및 생리적 특성과 이들의 이용방안에 대해 연구한다. 적조피해예방대책 등에 관한 책자를 발간한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"손사용|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002990:1', '{"dJobCd":"K000002990","dJobCdSeq":"1","dJobNm":"사상의학연구원","workSum":"사상체질감별의 객관화를 위해 한의학의 사상체질의학에 대해 연구한다.","doWork":"사상체질의학(사람의 체질을 특성에 따라 네 유형으로 나누고 그에 따라 병을 치유하는 체질의학)의 원전 및 연구결과물들을 해석·정리하며 새로운 연구방법론을 만든다. 원리론, 생리론, 병리론, 진단론 및 치료분야를 연구한다. 사상체질감별 대상자를 확보하여 동의수세보원에 근거한 체질감별작업을 한다. 체성분분석기를 이용하여 체질별 신체발달정도와 상하좌우의 균형정도를 측정한다. 체질감별 대상자의 혈액을 채취하여 혈액학적 검사와 생화학검사, 호르몬분석, 세포질분석, DNA추출 및 유전자검사를 한다. 이러한 작업을 원활히 수행하기 위해서 CBC측정기, 호르몬분석기 등과 같은 각종 측정기와 분석기를 사용한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|시각|","workFunc1":"분석","workFunc2":"협의","workFunc3":"정밀작업","certLic":"한의사","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002067:1', '{"dJobCd":"K000002067","dJobCdSeq":"1","dJobNm":"산림자원연구원","workSum":"효율적·경제적 산림경영을 위하여 임업의 경제구조 및 제도개선, 산림자원의 합리적 조사 및 관리, 임업경영의 합리화, 산지이용 및 산촌개발, 산림 및 목재문화의 정립과 계발 등에 대한 연구를 한다.","doWork":"임업경제동향, 임업투자, 임산물생산 및 수급예측, 임산물시장에 대한 연구를 한다. 임업정책에 대한 정책 및 지원제도, 육성책 등에 대한 연구를 한다. 임산물유통, 임산업구조, 임산물 물류, 해외산림자원정보에 대한 연구를 한다. 산림자원의 효율적 이용을 위하여 산림자원의 구조해석 및 배분배치, 산림자원 통계표준화, 온실가스 통계 및 저감방안 등에 대한 연구를 한다. 산림자원의 효율적 이용을 위하여 항공촬영, 산림항측, 인공위성자료 등에 의해 나온 자료를 응용하여 체계적인 종합산림정보체계를 구축·관리한다. 환경보전과 효율적인 산림자원 이용을 위한 지속가능한 산림경영전략 개발, 산림소득원 개발을 통한 산림소유자의 사회·경제적 지위향상, 산림의 합리적 보전과 이용을 위한 산지관리체계 확립, 산림의 공익기능평가 및 산림의 휴양·풍치기능에 관한 연구를 한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"연구분야에 따라 산림자원계획연구원, 산림조사연구원, 산지이용연구원, 야생동물생태보전관리연구원, 수문학연구원, 산림측정경영연구원, 산림휴양경제정책연구원","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003651:1', '{"dJobCd":"K000003651","dJobCdSeq":"1","dJobNm":"산림환경연구원","workSum":"기후변화 등에 따른 산림환경변화에 미치는 영향을 조사·분석하여 산림생태계의 보전 및 관리기술, 산지재해 방지 및 생산력 증진기술, 산림해충의 종합관리 등의 기술개발을 위한 연구를 한다.","doWork":"산림환경보전 및 공익기능 유지증진을 위한 기술개발을 위하여 산림생물다양성 보전 및 생태계 변화를 연구한다. 훼손된 생태계의 생태적 조성 및 관리기술의 체계화, 환경변화에 따른 수목의 피해원인 규명과 관리대책의 수립, 산불피해지 복구관리 및 생태계 변화 등을 위한 연구를 한다. 수목의 생장과 환경적응 특성을 밝혀 건전한 산림생태계의 유지·관리를 위한 기술을 개발하기 위하여 이상기상에 따른 수목피해 원인을 규명하여 이에 대한 대응방안을 수립한다. 도시림의 생태적 관리기술 개발 및 기상이 수목의 개화시기에 미치는 영향 등을 연구한다. 산림을 산불로부터 보호할 수 있는 효과적인 산불피해 경감기법 개발과 산불피해지의 생태계 변화에 따른 합리적 복구방안을 연구한다. 산림자원보전 및 임업생산성 향상을 위해 병해충예찰 및 발생예측모델을 개발하며, 산림생태계에 미치는 영향을 최소화할 수 있는 무공해 생물농약, 길항미생물 등을 이용한 환경친화적 방제법 및 특용작물의 병해충 방제기술을 연구한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"연구분야에 따라 산림생태연구원, 임지보전연구원, 산림생물연구원","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003874:1', '{"dJobCd":"K000003874","dJobCdSeq":"1","dJobNm":"생리학연구원","workSum":"동물, 식물 및 인체의 생물학적 기능과 작용 그리고 의학 및 관련 분야 적용에 관한 연구를 한다.","doWork":"정상적·비정상적 조건에서 동·식물의 성장, 호흡, 혈액, 분비, 이동, 임신 및 기타 기능 등을 연구한다. 현미경, X선 장비, 분광분석기 및 기타 장비들을 사용하여 내·외적 환경요인이 생명과정에 미치는 영향을 실험·조사한다. 내분비선 및 선(Gland)의 기능을 연구한다. 고도, 소음, 평형, 동작, 광도, 온도 및 습도 등 환경요소의 변화에 대한 생명반응을 조사한다. 신체조절, 영양섭취, 지구력 및 기타 관련 문제에 대하여 생리학적 지식을 적용한다. 인체의 두뇌와 감각기관 및 신경조직에 관하여 연구한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"연구분야에 따라 동물생리학연구원, 식물생리학연구원, 의학생리학연구원","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004953:1', '{"dJobCd":"K000004953","dJobCdSeq":"1","dJobNm":"생명정보연구원","workSum":"생명정보데이터를 목적에 따라 체계적으로 수집·처리·가공하고 연구한다.","doWork":"실험장비를 이용하여 신호를 수집·처리한다. 연구실에서 샘플을 추적하고 진행되는 실험을 관리한다. 공공의 데이터베이스에 데이터를 저장한다. 수집한 대용량데이터에서 패턴과 규칙을 찾는다. 새로운 데이터의 특성을 예상하고 하나의 범주로 묶는다. 복잡한 데이터세트(Data Set) 내에서 패턴매치(Pattern Match)와 특성 시그너처(Signature)를 발견하는 툴을 개발한다. 툴을 사용하여 생명체의 DNA서열로부터 주요기능을 하는 유전자를 발견한다. 발견된 유전자가 어떠한 병과 관련이 있는지 분석한다. 생명공학자 또는 생물학자와 공동으로 유전병에 관한 치료제를 연구·개발한다. 소규모연구실에는 소프트웨어를 이용해 수동으로 기록하기도 한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002032:1', '{"dJobCd":"K000002032","dJobCdSeq":"1","dJobNm":"생물분자유전연구원","workSum":"생명공학기술을 이용하여 미생물의 농업적 이용 및 산업신소재 개발을 위한 연구를 한다.","doWork":"분자생물학적 방법에 의한 미생물의 새로운 분류체계를 수립한다. 농업용 미생물자원과 유전자원의 체계적 보존관리 및 정보전산화를 위한 연구개발을 한다. 미생물로부터 유용한 유전자 분리 및 이용, 기능성 물질탐색 등의 연구를 통하여 농업 및 산업용 기능성 물질을 개발한다. 미생물의 스트레스 내성 관련 유전자 개발 및 미생물 유전자의 식물체 내 발현에 대한 연구를 한다. 유전자변형산물의 환경적응성에 대한 검증과 실용화를 통한 고부가가치가 있는 농업경영기술개발을 위한 연구를 한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|시각|","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"생물분자유전에 대한 전문분야에 따라 미생물분류연구원, 미생물유전자탐색연구원, 미생물유전자발현연구원","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003141:1', '{"dJobCd":"K000003141","dJobCdSeq":"1","dJobNm":"생물화학공정연구원","workSum":"미생물, 동물세포, 식물세포 등의 생물체 혹은 단백질, DNA(Deoxy- Ribonucleic Acid), RNA(Ribonucleic Acid) 등의 생물체 일부를 이용하여 인류에게 유익한 생산물의 제조, 서비스 및 지식창출을 위한 제반 공정 기술을 연구한다.","doWork":"발효공정기술(Fermentation process) 분야의 경우 미생물 배양 및 생산을 위한 공정 기술을 연구한다. 대사공학기술(Metabolic engineering)의 경우 미생물의 대사경로를 효율적으로 변환하는 기술을 연구한다. 효소생물 공정기술(Enzymatic process)의 경우 효소 반응에 의한 물질 생산을 위한 공정 기술을 연구한다. 생물분리정제 공정기술(Bio-separation and purification process) 분야의 경우 생화학반응 결과 생산된 물질의 분리 및 정제 공정 기술을 연구한다. 생물환경 공정 기술(Bio-environmental process) 분야의 경우 생물공학을 환경처리에 응용하는 기술을 연구한다. 나노생물 융합 공정기술(Nano- and bio-chemical process) 분야의 경우 생체 또는 비생체 나노소재 및 나노기법을 융합한 생물화학적 생산 공정 기술을 연구한다. 분자생물 공정 기술 분야의(Molecular bio-process)의 경우 세포 내외에서 생체물질을 합성/생산, 변환, 분리/정제하기 위한 공정을 분자 수준에서 분석, 제어, 조절하는 기술을 연구한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"E390/M701","dJobICdNm":"[E390]환경 정화 및 복원업 / [M701]자연과학 및 공학 연구개발업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001291:1', '{"dJobCd":"K000001291","dJobCdSeq":"1","dJobNm":"생체역학연구원","workSum":"스포츠장비(또는 운동화)와 기구를 개발하기 위해 인체운동과 스포츠용구와의 역학관계를 연구한다.","doWork":"영상분석시스템, 지면반력측정시스템, 실시간동작분석시스템 등을 사용하여 인체를 측정하고 분석한다. 인체의 운동과 스포츠용구나 운동화에 대한 관계를 연구한다. 운동기술 측정장비 및 운동용 기구를 개발한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"운동역학연구원","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002737:1', '{"dJobCd":"K000002737","dJobCdSeq":"1","dJobNm":"생태계복원관리연구원","workSum":"기후변화 및 환경오염으로 인한 생태계 영향, 훼손된 생태계 복원기술 등에 관한 연구를 수행한다.","doWork":"기후변화 및 환경오염, 도시개발 등과 같은 자연적, 인위적 간섭에 의해 훼손된 중요한 서식처나 생물종을 훼손 이전 또는 유사한 생태계의 종다양성 및 역동성을 되살리기 위해 훼손된 자연환경의 구성 및 형성과정 등 토지, 식물, 생물 등의 자연환경의 상호영향관계를 분석한다. 오염정화, 생태계복원, 먹이사슬 구축, 생태하천조성 등 관련 훼손된 생태계를 복원·복구·대체하기 위한 국내외 기술을 수집·분석한다. 효율성 높은 생태계 복원기술을 개발 및 보급하기 위해 연구를 수행한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"자연환경관리기술사, 자연생태복원기사, 자연생태복원산업기사","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004552:1', '{"dJobCd":"K000004552","dJobCdSeq":"1","dJobNm":"생화학연구원","workSum":"세포 내에서 일어나는 생명과정들의 작용 메커니즘과 이러한 과정들에 관련된 생체분자들의 구조와 기능, 합성 및 분해과정을 분자 또는 원자수준에서 규명하여 생명과정에 대한 이해를 깊게 하고, 이들 과정을 산업적으로 응용하기 위한 방법을 모색하기 위한 연구를 수행한다.","doWork":"핵산분자 생화학(Nucleic Acid Biochemistry) 분야의 경우 DNA, RNA 및 기타 핵산의 구조와 작용, 그리고 이들 사이 또는 이들과 단백질 사이에서의 상호작용, 유전자재조합, 이들 분자들의 산업적 응용 등에 관한 연구를 수행한다. \n단백질/효소분자 생화학(Protein/Enzyme Biochemistry) 분야의 경우  단백질과 효소의 구조와 작용 메커니즘, 단백질 대사 등에 관한 연구를 수행한다. 탄수화물분자 생화학(Carbohydrate Biochemistry) 분야의 경우  탄수화물의 구조와 작용 메커니즘, 탄수화물의 대사에 관한 연구를 수행한다. 지질분자 생화학(Lipid Biochemistry) 분야의 경우 Lipid분자들의 구조와 기능 및 대사, 세포막의 기능, 그리고 지질분자와 다른 분자들과의 상호작용에 관한 연구를 수행한다. 구조생화학(Structural Biochemistry)  분야의 경우 생체물질들의 구조와 기능, 생체분자들 사이의 상호작용을 X-ray, NMR, 기타의 분광학적인 방법, 그리고 컴퓨터 계산 및 modeling 등 으로 연구를 수행한다. 대사분자 생화학(Metabolic Molecule Biochemistry) 분야의 경우  세포에서 일어나는 대사 과정을 분자과학적인 관점에서 연구를 수행한다. 신경계분자 생화학(Neuro- Biochemistry)  분야의 경우  신경계와 관련된 물질들의 구조 및 대사, 작용메커니즘을 화학적인 관점에서 연구를 수행한다. 단백질체학(Proteomics) 분야의 경우  개체 또는 조직의 단백질체를 대상으로 하는 분석 및 분석 방법의 개발, 대사 상호관계, 질병의 바이오마커 발굴 등에 관한 연구를 수행한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"연구분야에 따라 단백질화학연구원, 임상화학연구원, 혈액화학연구원, 효소화학연구원, 단백질구조연구원, 핵산생화학연구원, 단백질체학연구원, 당생물학연구원, 지질생화학연구원, 구조생물학연구원","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002006:1', '{"dJobCd":"K000002006","dJobCdSeq":"1","dJobNm":"생활체육연구원","workSum":"국민의 건강과 체력관리에 필요한 연구를 수행하며 연구결과를 체육정책 입안자료로 제공하거나 생활체육현장에 적용한다.","doWork":"전 국민을 대상으로 한 표본조사를 통하여 체력 및 체격의 실태를 파악하고 평가기준치를 표준화한다. 국민체력증진을 위한 체력관리 및 생활체육프로그램을 개발한다. 국민여가에 관하여 연구한다. 국민체력진단 및 운동처방에 관하여 연구한다. 각 언론매체를 통해 건강 및 체력관리에 관한 정보를 제공하거나 생활체육에 관하여 강의한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"관련없음","certLic":"생활스포츠지도사(1급, 2급)","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007171:1', '{"dJobCd":"K000007171","dJobCdSeq":"1","dJobNm":"생활환경유해인자연구원","workSum":"생활환경 유해인자에 대한 진단·평가를 하고, 석면, 라돈, 빛공해, 소음 등의 저감, 관리 등에 관한 연구를 수행한다.","doWork":"휘발성유기화합물(VOC:Volatile Organic Compound), 미세먼지, 폼알데하이드(Formaldehyde), 곰팡이, 집먼지진드기, 바닥먼지내유해물질, 전자파, 석면, 라돈, 빛공해, 소음 등과 같은 환경오염물질, 화학물질, 물리적 요인 등의 유해물질과 매체의 파악과 관리를 위해 현장측정과 시료채취를 실시한다. 모발검사를 실시하여 인체(수용체) 중금속 축적을 확인하는 등 생활환경 유해인자가 어떤 환경매체를 통해 이동하고 노출되는지 경로를 파악하고 질병·장애 등 인체에 미치는 영향과 유해인자의 관리기법을 연구한다. 노약자와 같은 민감계층과 취약지역의 생활환경 유해인자의 저감을 위해 친환경제품의 사용을 통한 생활환경개선방법을 연구한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001467:1', '{"dJobCd":"K000001467","dJobCdSeq":"1","dJobNm":"수산공학연구원","workSum":"어업기술, 어구, 양식시설 및 어장시설 등을 공학적으로 연구하고 관련 장비나 시설 등을 개발한다.","doWork":"연구대상 어류를 선정한다. 문헌조사나 사례조사를 통해 연구·개발계획을 수립한다. 모형을 설계·제작하고 수리모형을 통해 실험한다. 연구소 내 또는 바다에서 화류수조, 수중카메라 등을 설치·조립하고 장력계, 저항동력계, 6자 유도계 등을 사용하여 실험하고 분석한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|손사용|시각|","workEnv":"다습|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"연구분야에 따라 수산생물유전육종연구원, 수산생물생리번식연구원, 수산생물사육생산연구원, 수산생물병리연구원, 수산바이오자원활용연구원, 수산양식사료연구원, 수산양식시설자재연구원","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002305:1', '{"dJobCd":"K000002305","dJobCdSeq":"1","dJobNm":"수산생물병리연구원","workSum":"수산생물의 질병원인을 규명하고 질병치료에 사용되는 약제를 연구한다.","doWork":"현장에서 죽거나 죽어가는 수산생물을 채취하여 장기를 적출한다. 장기에 발생한 세균이나 기생충을 분리·배양하여 병원체의 성상, 특성, 약제감수성 등의 동정연구를 한다. 각종 질병의 원인균을 보존하여 연구자료로 활용한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"웅크림|시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004002:1', '{"dJobCd":"K000004002","dJobCdSeq":"1","dJobNm":"수의과학연구원","workSum":"동물을 대상으로 수의 임상 전반과 이와 관련된 학문적 이론·응용에 관하여 연구한다.","doWork":"수의 전염병(Veterinary Infectious Diseases)분야의 경우, 동물의 감염성 질환(세균성, 진균성, 바이러스성 및 기생충성 질환)의 발병기전과 치료법을 연구한다. 수의 공중보건학(Veterinary Public Health)분야의 경우, 축산물을 포함한 식품위생, 인류와 동물의 질병예방, 방역 등 공중위생학적 측면의 연구, 동물질병의 위해성 평가 및 인수공통 전염병 연구를 수행한다. 수의 병리학(Veterinary Pathology)분야의 경우, 동물의 질병발생기전과 질병진단에 관한 연구를 수행한다. 수의 미생물·기생생물(Veterinary Microorganisms and Parasites)분야의 경우, 동물을 감염시키는 미생물 및 기생충의 감염기전 및 생활사를 연구한다. 수의 약리·독성학(Veterinary Pharmacology and Toxicology)분야의 경우, 동물용의약품 등 치료에 사용되는 약물의 작용기전 및 잔류물질의 규명과 효능, 독성물질의 작용기전 및 독성평가에 관한 연구를 수행한다. 수의 생리·생화학(Veterinary Physiology and Biochemistry)분야의 경우, 생명체를 구성하는 분자들의 구조와 기능, 세포내의 분자들의 형성, 변환 및 상호작용에 관한 연구와 에너지 생성, 분자생물학적 유전정보에 관한 연구, 동물세포 내 소기관의 통합적 기능 및 생리적 특성을 연구한다. 수의 해부·조직학(Veterinary Anatomy and Histology)분야의 경우, 동물의 신체를 구성하는 조직이나 기관의 형태, 위치 및 그 구조에 관한 연구, 동물체를 구성하는 각종 장기, 조직의 미세구조와 기능에 대하여 기본조직과 계통별 연구를 수행한다. 임상수의학(Clinical Veterinary Medicine)분야의 경우 환축(병든 동물)의 진료, 질병의 진단, 개체에 대한 치료계획의 수립, 입원환축에 대한 관리 등 내과학적 치료연구 및 동물에 발생하는 질환 중 외과학적 처치를 필요로 하는 질환, 마취 및 수술학의 연구, 체세포복제(Somatic Cell Nuclear Transfer), 체외수정, 불임진단 및 처치, 번식관리, 인공수정, 산과질환의 처치, 동물유전체학 연구 및 산업동물 배아발생유전학 연구를 수행한다. 실험동물학(Laboratory Animal Medicine)분야의 경우, 동물을 이용한 의학, 수의학적 실험방법과 이론연구, 비교의학 및 동물복지에 관한 연구 등을 수행한다. 동물 질병예방(Prevention of Animal Diseases)분야의 경우, 축산물을 포함한 식품위생, 인류와 동물의 질병예방, 방역 등 공중위생학적 측면의 연구, 동물 질병의 위해성 평가 및 인수공통 전염병을 연구한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"청각|손사용|시각|","workEnv":"대기환경미흡|위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"수의전염병연구원, 수의공중보건연구원, 수의병리연구원, 수의미생물기생생물연구원, 수의약리독성연구원, 수의생리생화학연구원, 수의해부조직연구원, 임상수의연구원, 실험동물연구원, 동물질병예방연구원","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005656:1', '{"dJobCd":"K000005656","dJobCdSeq":"1","dJobNm":"시설재배연구원","workSum":"고품질·고부가가치의 원예작물을 지속적·안정적으로 생산하기 위한 시설재배기술에 대해 연구를 한다.","doWork":"시설원예작물의 생산시스템 및 자동화, 재배기술, 영양생리 및 토양환경 등의 분석, 개발을 통해 고품질 원예작물을 지속적, 안정적으로 생산할 수 있는 기술을 개발한다. 원예작물 시설재배에 필요한 지능형 복합환경제어 시스템은 개발한다. 시설 구조개선 및 저비용 고효율, 내재해 온실 모델 개발, 시설물장치의 개선에 관한 연구를 수행한다. 시설원예에 소요되는 에너지 절감기술을 개발한다. 수경재배 양수분 조절 및 친환경 순환식 수경재배 기술을 개발한다. 실시간 원예작물의 성장, 재배 등에 대한 진단을 위한 작물생육 예측모델 개발 및 표준화 연구를 수행한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"웅크림|","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"원예작물의 시설재배에 대한 연구분야에 따라 시설재배환경연구원, 시설재배시스템연구원, 원예생산시설연구원","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003765:1', '{"dJobCd":"K000003765","dJobCdSeq":"1","dJobNm":"식물병리연구원","workSum":"작물에 발생하는 병해로부터 종합적인 병해관리체계를 확립하기 위한 제반 연구를 한다.","doWork":"작물에 발생하는 병해를 조사·분석하고 평가한다. 식물병원균의 분류, 동정(생물의 속명이나 종명을 결정하는 것) 및 병해진단에 관한 연구를 한다. 작물에 발생하는 각종 병의 생리, 생태 및 역학에 관한 연구를 한다. 병·약제에 대한 작물의 저항성에 관한 연구를 한다. 작물에 발생하는 병의 종합방제를 위한 기술을 개발한다. 우수살균제의 선발 및 사용방법에 관한 결과를 도출하기 위하여 시험 및 연구를 한다. 식물생장조절 및 생리활성물질의 개발 및 이용에 관한 연구를 한다. 잡초의 분류, 동정, 발생분포 및 방제에 관한 조사와 연구를 한다. 우수제초제의 선발 및 잡초종합관리기술을 개발하기 위한 연구를 한다. 작물의 보호에 관한 국제협약에 대한 연구를 한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"시각|","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"식물의 병해관리를 위한 전문분야에 따라 병해진단연구원, 진균연구원, 세균연구원, 바이러스연구원, 병해종합방제연구원, 잡초연구원","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003717:1', '{"dJobCd":"K000003717","dJobCdSeq":"1","dJobNm":"식물세포유전연구원","workSum":"식물세포 내의 생리기작(機作:식물이 생리적인 작용을 일으키는 기본적인 원리) 및 유전연구를 통한 품종 및 대량생산 기초기술을 개발한다.","doWork":"신품종으로 실용화하기 위한 세포분화에 대한 기초기술을 연구·개발한다. 환경변화에 적응할 수 있는 신품종개발을 위한 연구를 한다. 벼 유전자의 기능분석을 통한 유용유전자 선발 및 분자육종 소재를 개발하기 위한 연구를 한다. DNA 포자인자 개발을 위한 연구를 한다. 분자육종 모델시스템을 정립하기 위한 연구를 한다. 작물의 유전변이 및 돌연변이의 연관성에 대한 연구를 한다. 식물 세포단위의 유용한 유전자 개발 및 유전자지도의 작성을 위한 연구를 한다. 조직배양, 세포배양 및 세포분화의 제어에 관한 기술을 개발하기 위한 연구를 한다. 원연잡종 이용 및 세포선발방법의 개발에 따른 이용기술에 대한 연구를 한다. 작물실용유전자 중간모본(母本:번식의 근원이 되는 식물) 및 육종 신소재를 개발하기 위한 연구를 한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"자문","workFunc3":"정밀작업","connectJob":"식물세포유전에 대한 전문연구분야에 따라 식물세포분화연구원, 식물유전자기능연구원, 벼유전자지도연구원","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003533:1', '{"dJobCd":"K000003533","dJobCdSeq":"1","dJobNm":"식물환경연구원","workSum":"농작물의 수량증대 및 품질향상을 위하여 토양개량, 시비(施肥:거름주기)개선, 병충해방제법, 농산물의 저장, 가공, 이용 등에 관한 연구를 한다.","doWork":"토양개량 및 시비개선연구를 위하여 연구항목을 설정한다. 토양을 개량하고 시비하여 농작물을 재배하고 관리한다. 토양 중 화학성분의 동태 및 작물의 흡수양상을 추적한다. 방제약제를 처리하여 병해충의 생리상태를 조사하고 약효를 분석한다. 각종 연구자료를 집계하고 통계자료를 분석한다. 농산물의 저장, 가공을 연구하고 자료분석결과를 분석하여 평가한다. 시료를 수집하고 수집된 시료에서 성분을 추출·분리하고 각종 기기나 시약을 사용하여 분석·평가한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002159:1', '{"dJobCd":"K000002159","dJobCdSeq":"1","dJobNm":"야생동물생태복원사","workSum":"자연생태 관련 법·제도 및 전문지식을 이용하여 야생동물생태계 요인을 분석하고 훼손된 생태계를 복원한다.","doWork":"자연생태 관련 법·제도와 전문지식, 숙련기능을 바탕으로 현장에서 야생동물조사, 복원시공, 감독 등의 복합적인 기능을 수행한다. 환경오염과 파괴로 인한 자연생태계의 훼손을 줄이기 위해 환경친화적 환경개발, 생태계복원사업, 환경영향평가, 생태계위해성평가, 전과정평가 등을 한다. 야생동식물 서식환경을 모니터링하여 올무, 덧 등 불법엽구의 제거, 겨울 먹이주기, 밀엽단속 등 야생동물의 생태계 보존을 위한 업무도 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"관련없음","certLic":"생물분류기사(동물)","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001834:1', '{"dJobCd":"K000001834","dJobCdSeq":"1","dJobNm":"약용작물연구원","workSum":"약용작물의 생산성 및 품질향상을 위하여 재배방법의 개선, 신품종 개발, 생리장해원인과 방제법, 병충해방제법, 기능성, 신소재 탐색 및 안전성 평가 등에 대하여 시험·연구한다.","doWork":"인삼 등 약용작물의 품종육성 및 생명공학기술 개발 연구를 수행한다. 약용작물의 유전자원 수집, 평가, 보존 및 증식에 관한 연구를 수행한다. 인삼 등 약용작물의 안정생산, 스마트 농업을 위한 재배방법 개선 및 품질 향상 연구를 한다. 약용작물의 토양, 병해충 연구 및 수확 후 관리기술, 상품성 증진기술을 개발한다. 약용작물의 기능성, 신소재 탐색 및 안전성 평가를 수행한다. 약용작물의 신소재 산업화 연계기술을 개발한다. 약용작물의 가공 및 품질 평가를 수행한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"연구하는 분야에 따라 인삼병충해연구원, 인삼생리연구원, 인삼영양연구원","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007535:1', '{"dJobCd":"K000007535","dJobCdSeq":"1","dJobNm":"약학연구원","workSum":"생물체의 기관, 조직 및 생명작용에 영향을 미치는 의약품 및 기타 물질의 효과를 연구하여 의약품을 연구·개발한다.","doWork":"실험용 동물을 이용하여 혈액순환, 호흡, 소화 및 기타 생명작용과정 등 기관 및 조직의 기능에 관한 약품 및 기타 관련 물질의 효과를 실험·연구한다. 동물실험의 결과를 임상실험과 연관시켜 질병에 대한 면역이나 치료용 투약의 기준을 비교·설정한다. 식품방부제, 색소, 중독성 가스 및 해독물 등 인체에 흡수되는 물질을 분석하여 인체의 조직, 기관 및 생명작용에 미치는 영향을 측정한다. 인체의 특정기관에 영향을 미치는 의약품의 효과측정, 특수질병치료용 의약품의 개발, 독성물질의 검출 및 확인 등을 수행하기도 한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","similarNm":"약리학자, 약물학자","connectJob":"연구분야에 따라 의약품모델링연구원, 임상약리연구원, 의약품성분분석연구원, 단백질의약품연구원, 효소의약품연구원, 유전자의약품연구원, 저분자의약품연구원, 천연물의약품연구원, 치료용항체연구원, 백신연구원, 세포조직치료제연구원, 바이오생체재료연구원, 바이오인공장기연구원, 기능성화장품개발연구원","certLic":"약사","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002456:1', '{"dJobCd":"K000002456","dJobCdSeq":"1","dJobNm":"양식기술개발원","workSum":"육상 및 해양수산양식의 양식생리 및 생태를 연구하여 품종개량 및 생산성 증대기술을 개발한다.","doWork":"수산물의 생태를 파악하고 유전자를 확인하여 새로운 품종을 개발한다. 양식대상 품종에 대한 지역 간 유전자특성을 파악하고 고유품종을 보존한다. 해산어류의 품질이나 생산성을 높이기 위하여 각종 양식기법을 개발한다. 수산부산물을 이용한 새로운 사료를 개발하여 양식비용을 절감하고 유전공학기법을 응용하여 신품종을 개발한다. 값싼 배합사료를 개발하여 양식생산성을 향상시킨다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|다습|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"양식기술을 개발하는 어·패류의 종류에 따라 어류양식기술개발원, 패조류양식기술개발원","certLic":"수산양식기사","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"A032","dJobICdNm":"[A032]양식어업 및 어업관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005067:1', '{"dJobCd":"K000005067","dJobCdSeq":"1","dJobNm":"어류생태연구원","workSum":"각종 어류의 사육실험, 치어(稚漁)생산, 질병연구, 어류의 사육·전시방법 등을 연구·개발한다.","doWork":"각종 어류의 습성, 사료, 생태환경 등에 관한 자료를 수집·분석한다. 사육실험을 위하여 수족관을 설치하고 번식이 가능한 어종(魚種)을 선택하여 자연수정 및 산란을 유도한다. 수족관의 온도 및 산소농도를 조절하여 알을 부화시키고 치어를 생산한다. 신규로 구입한 어류를 예비수조에 수용하고 기생충 및 세균성질병을 예방하기 위하여 일정량의 약품을 투입한다. 어류의 질병에 대하여 연구하며 적절한 예방책과 치료약품의 안전농도에 대하여 실험한다. 해양연구기관의 연구자료를 수집·분석한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workEnv":"다습|소음·진동|","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005259:1', '{"dJobCd":"K000005259","dJobCdSeq":"1","dJobNm":"어업자원연구원","workSum":"어업자원의 생물학적 특성이나 자원변동에 대한 연구 및 조사를 통해 현재 어업자원의 수준을 평가하고 미래의 자원변동을 예측한다.","doWork":"대형선망 등 연근해 주요 어업과 고등어, 참조기, 갈치 등 주요 어업자원의 생물학적 특성 및 자원변동에 관해 연구한다. 현재의 자원수준을 평가하고 미래의 자원변동을 예측함으로써 적정이용 관리수준을 제시한다. 시험조사선에 승선하여 우리나라의 배타경제수역 주요 어종별 자원량을 어군탐지기 등을 사용하여 추정하고 생태를 규명한다. 주요 어업 및 어종에 대한 어황변동의 법칙성을 구명하고 어장탐색정보 분석으로 어류별 생산계획을 제시한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|손사용|시각|","workEnv":"다습|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"연구분야에 따라 수산자원생물연구원, 수산자원변동연구원, 수산자원생태연구원, 수산자원평가관리연구원, 수산자원예측연구원, 어장환경분석평가연구원, 어장환경복원처리연구원, 연안생태연구원, 적조구제연구원, 양식생물독성평가연구원","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007135:1', '{"dJobCd":"K000007135","dJobCdSeq":"1","dJobNm":"어업자원조사연구원","workSum":"어종(魚種)에 대한 생물학적 특성을 구명(究明)하고 관련된 동태를 분석하는 등의 업무를 수행한다.","doWork":"출어선이나 상업어선에 승선하여 어획통계, 어장환경 등의 자료를 수집한다. 수집된 자료를 어업별·시기별로 분류하여 전산화한다. 전산처리 결과를 분석하여 어업별·해역별·시기별·어종별 밀도분포 및 중심어장을 파악한다. 대상 어업자원의 자원변동, 어장환경과 풍도와의 관계, 어종별 생태학적 특성 등을 분석한다. 분석된 자료를 활용하여 어장정보를 제공하고 수산정책의 기초자료로 제공한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"연구하는 분야에 따라 연근해어업자원조사연구원, 원양어업자원조사연구원","certLic":"수산양식기사","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007408:1', '{"dJobCd":"K000007408","dJobCdSeq":"1","dJobNm":"역학조사관","workSum":"감염병의 원인과 특성을 찾아내, 감염병 유행을 차단하는 방법을 밝히는 역학조사를 진행한다.","doWork":"국내·외 감염병에 대응하기 위한 역학조사 종합계획을 수립하고 관리한다. 역학조사 실시 기준 및 방법을 개발한다. 역학조사를 수행하고 결과를 분석한다. 역학조사 기술지도 및 교육훈련을 진행한다. 감염병 관리 및 대응관련 정책을 제안하고 사업을 수행한다. 감염병에 대한 역학적인 연구를 수행한다. 감염병 대응 및 방역체계를 수립한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"감독","workFunc3":"관련없음","certLic":"의사, 치과의사, 한의사, 조산사 및 간호사, 수의사, 약사","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"O841","dJobICdNm":"[O841]입법 및 일반 정부 행정","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002343:1', '{"dJobCd":"K000002343","dJobCdSeq":"1","dJobNm":"운동생리학연구원","workSum":"인체가 정상적인 기능을 수행하는 능력을 가진 상태에서 운동자극에 대해서 반응하고 적응되는 과정을 분석·연구한다.","doWork":"운동과 신진대사, 운동과 호흡계, 운동과 신경계, 운동과 근육기능, 운동과 호흡기능, 운동과 피로, 운동과 환경 등에 대해 연구한다. 호흡가스자동분석기, 유산소운동 등 실험기자재를 사용하여 측정·분석한다. 경기력 향상을 위한 훈련방법을 개발한다. 스포츠상해 예방 및 재활, 영양 및 건강에 대해 연구한다. 기타 연구원(일반)들이 수행하는 일반적인 활동을 한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002272:1', '{"dJobCd":"K000002272","dJobCdSeq":"1","dJobNm":"원예작물환경연구원","workSum":"원예작물의 토양개량, 시비법(식물생육을 위하여 토양에 비료를 사용하는 법) 개선, 토양보존 및 원예작물의 병해충 예방과 방제에 관한 연구를 한다.","doWork":"원예작물의 수량증대 및 품질향상을 위한 토양관리를 위하여 토양수분, 관개배수, 시비기술 등에 관한 시험과 연구를 한다. 원예작물의 적정 시비량 및 시비방법을 개선·개발하기 위한 연구를 한다. 토양미생물의 농업적 이용과 토양보존에 관한 연구를 한다. 원예작물의 병해충으로부터의 예방 및 방제기술을 개발하기 위하여 원예작물에 악영향을 미치는 병해충의 분류, 동정, 생리·생태 및 저항성검정에 관한 연구를 한다. 원예재배지의 잡초에 대한 분포조사, 생리·생태 및 방제에 관한 연구를 한다. 친환경원예작물에 대한 근권(식물 뿌리둘레의 영역) 환경개선 및 지구온난화에 대비한 기술을 개발한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"원예작물의 품질기준 및 평가/품질보전 및 수확 후 생리·생태에 관한 연구를 하는 경우 원예품질보전연구원","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006407:1', '{"dJobCd":"K000006407","dJobCdSeq":"1","dJobNm":"유전공학연구원","workSum":"생물체의 유전자나 그 발현조절자를 인위적으로 조작하여 학문적·산업적으로 유용한 새로운 형질을 창출하는 기술을 연구·개발한다.","doWork":"유전자를 인위적으로 재조합하여 인류에게 유익한 의약물질, 기능성물질, 공업원료물질 등을 값싸게 생산하거나 이에 필요한 새로운 형질의 생명체를 창출, 실용화하는 방법 및 기술을 연구한다. 인체를 포함한 동물, 식물, 미생물 등의 세포 내에서 수행되는 생명체 활동의 기본 현상과 원리를 규명하는 연구를 한다. 식물이나 동물의 유전방식을 연구한다. 유전자를 재조합하여 새로운 품종을 개발한다. 유전질환과 암, 노화, 치매, 에이즈 등 질병유발에 대한 연구를 한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"위험내재|저온|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"분자유전학연구원, 세포유전학연구원, 집단인류유전학연구원, 유전체학연구원, 형질전환생물모델연구원, 유전자치료연구원","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006654:1', '{"dJobCd":"K000006654","dJobCdSeq":"1","dJobNm":"유전자감식수사연구원","workSum":"범죄 및 사고수사를 지원하기 위해 유전자감식업무를 수행한다.","doWork":"범죄 및 사고 담당자에게서 유전자검사를 의뢰받는다. 뼈, 피부조직, 모발, 체액 등에서 시료를 채취한다. 채취된 시료에서 DNA를 분리하고 불순물을 제거한다. DNA 증폭과정을 거쳐 판독한다. 검사를 위한 분석시스템을 개발하고 개량한다. 범죄예방을 위해 유전자정보 데이터베이스를 구축한다. 최신 감식기술의 동향을 파악하기 위해 자료를 수집하고 연구한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"유전자감식연구원","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"O844","dJobICdNm":"[O844]사법 및 공공질서 행정","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002919:1', '{"dJobCd":"K000002919","dJobCdSeq":"1","dJobNm":"유전자원연구원","workSum":"유전자원의 수집, 분류, 보전, 특성평가, 증식 등에 관한 연구를 한다.","doWork":"유전자원의 안전한 보존 및 정보의 체계화를 위해 연구한다. 해외의 다양한 작물유전자원을 수집·확보하고 이용체계를 확립하기 위한 연구를 한다. 유전자원의 특성을 검정하고 평가하여 이용가능성에 대한 연구를 한다. 유전자를 저온저장하고 배양하여 필요로 하는 연구단체 및 농업법인체에 분양한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|시각|","workEnv":"위험내재|저온|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"유전자원을 연구하는 전문분야에 따라 유전자원보존연구원, 유전자원평가연구원","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006992:1', '{"dJobCd":"K000006992","dJobCdSeq":"1","dJobNm":"의약품비임상시험연구원","workSum":"의약품 연구개발 계획 및 비임상시험 관리기준에 따라 임상시험 평가에 앞서 동물 등을 대상으로 약효, 독성 등을 검증하기 위한 시험 수행체계를 수립한다.","doWork":"비임상시험에 대한 항목별 시험방법, 투여량, 시험일정, 필요 생산량을 결정하고 수행 일정, 소요자원 및 비용계획을 수립한다. in vitro 및 비임상 in vivo 흡수, 분포, 대사, 배설 시험을 수행하고, 효능평가 실험을 수행하여 평가 의약품의 약효평가, 약동력학 결과보고서를 작성한다. 산출된 비임상 약동력학적 파라미터와 약효평가 결과를 바탕으로 컴퓨터 프로그램을 활용하여 약동력학 모델링을 실시한다. 안전성 약리시험과 평가의약품의 특성 및 독성시험을 수행하고, 평가 시험물질의 안전성 여부를 판단할 수 있는 보고서를 작성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"독성시험연구원","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"C211/M701","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업 / [M701]자연과학 및 공학 연구개발업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006993:1', '{"dJobCd":"K000006993","dJobCdSeq":"1","dJobNm":"의약품임상연구원","workSum":"치료제·치료기기 개발 등에 활용할 목적으로 임상 프로토콜 작성, 피험자 선정, 임상 시험, 데이터 분석, 결과보고서 작성, 신약허가 신청(NDA), 시판 후 조사한다.","doWork":"임상계획서 항목의 임상시험의 명칭, 배경목적, 단계, 실시기관 정보, 참여 인력, 의뢰자 정보, 사용되는 의약품 정보를 작성 및 검토한다. 이론적 근거와 목적, 대상 환자군, 치료, 기간, 1차 평가변수 등을 간략히 요약 기술하여 보고서의 서론을 작성하고, 임상시험 설계 및 계획에 대하여 모니터링하고 실시한 내용을 작성한다. 임상시험의 유효성/안전성 평가 결과와 유익성, 위해성 관계를 바탕으로 고찰 및 결론을 작성한다. 평가된 안정성, 유익성 결과를 바탕으로 작성된 임상시험 결과보고서를 검토한다. 임상시험용 의약품이 시판 허가된 의약품으로 임상시험에 사용 가능한지 타당성 여부를 검토한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"임상시험모니터링요원(clinical research associate)","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"C211/M701","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업 / [M701]자연과학 및 공학 연구개발업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004226:1', '{"dJobCd":"K000004226","dJobCdSeq":"1","dJobNm":"인구의학연구원","workSum":"인간생식, 수태조절 및 인구역학분야에 관하여 연구·개발한다.","doWork":"인간생식, 수태조절 및 인간분야의 임상과 기초의학적 연구를 수행하여 가족계획 및 인구조절에 대한 학문적·기술적 지원을 수행한다. 인간생식 및 가족계획에 관하여 강의한다. 가족계획상담, 불임시술, 영유아 및 모성보호, 성교육 등에 대하여 보건전문인들을 교육·훈련한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004625:1', '{"dJobCd":"K000004625","dJobCdSeq":"1","dJobNm":"인삼육종연구원","workSum":"전통육종방법과 생명공학기술을 응용하여 인삼의 신품종을 육성한다.","doWork":"전국의 산지를 대상으로 지상부생육이 왕성하고 뿌리형질이 우수한 인삼을 선발한다. 불량한 환경에서 내성을 가진 인삼을 선별하여 특성을 조사한다. 선발한 우수계통들의 형질유전현상을 구명하기 위하여 제2세대를 반복적으로 선발하여 순계화한다. 뿌리조직의 형태와 경흔적수를 조사하여 인삼뿌리의 년근을 판정한다. 인삼의 엽록체와 미토콘드리아의 특성을 구명하기 위하여 염기서열을 분석한다. 새로운 유전자를 개발하기 위하여 DNA재조합기술을 개발한다. 인삼생육을 촉진하는 물질을 개발하기 위하여 토양미생물에서 신물질을 추출한다. 홍삼의 품질에 나쁜 영향을 미치는 내공, 내백원인을 구명하고 대책을 강구한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"자문","workFunc3":"정밀작업","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006432:1', '{"dJobCd":"K000006432","dJobCdSeq":"1","dJobNm":"인체공학연구원","workSum":"재활보조기구, 인공관절과 같은 정형외과 인공대치물을 개발하기 위하여 보행속도, 이동각도 등 인체운동 특성에 관한 기초자료를 수집·분석·제공한다.","doWork":"조사할 인체운동의 특성, 대상자 선정 등 자료수집을 위한 계획을 수립한다. 인체공학측정장비조작원에게 조사항목, 조사방법 등을 지시한다. 수집된 자료를 사용하여 보행 및 자세 등을 분석한다. 수집자료를 DB로 구축한다. 개발된 재활장비나 기구를 환자에게 착용시켜 근력, 관절 간 각도, 피로누적도, 에너지소비량, 경사보행, 뛰는 보행, 계단보행 등 기능과 안정 등을 시험하고 분석한다. 사용상의 문제점 등을 개발 관련 연구원에게 제공하여 수정 및 개발에 참조하도록 한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004161:1', '{"dJobCd":"K000004161","dJobCdSeq":"1","dJobNm":"임목육종연구원","workSum":"산림자원의 생산성 향상을 위해 다양한 수종의 우량품종 육성, 임업의 산업화 촉진을 위한 신물질 생산, 산림유전자원의 보전 등에 대하여 연구한다.","doWork":"산림자원의 생산성 향상과 산지의 자원화 촉진을 위해 주요 용재수종(用材樹種)과 속성수의 우량품종 육성, 병충해 및 환경오염에 강한 저항성 품종육성 등에 대한 연구를 수행한다. 향토수종에 대한 유전적 다양성을 조사·평가하여 효과적인 보존방안 및 체계적 관리기술을 연구한다. 각종 유전정보를 신속·정확하게 이용할 수 있는 DNA표지자를 개발한다. 수종이나 품종식별용 표지유전자 개발 및 유전자지도 작성 등을 통하여 유용 유전형질의 선발과 임목육종분야에 관한 분자유전학적 연구를 한다. 생물공학기법을 이용하여 산림자원을 효율적으로 활용하고 새로운 부가가치를 창출하기 위하여 주요 산림자원의 세포 및 기관배양에 의한 바이오매스(Biomass) 대량증식 및 응용연구를 실시한다. 형질전환에 의한 신기능성 품종육성, 산림자원으로부터 유용물질 탐색 및 새로운 용도의 개발 등에 관한 연구를 한다. 주요 임산물 소득원인 유실수와 특용수, 조경수에 대한 우량품종 육성과 최적 재배기술개발을 위한 연구를 한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"연구분야에 따라 임목육종연구원, 임목유전생리연구원, 임목생물공학연구원, 특용수육종연구원","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006003:1', '{"dJobCd":"K000006003","dJobCdSeq":"1","dJobNm":"임산공학연구원","workSum":"친환경적이며 재생가능자원인 임산자원의 합리적 이용을 위한 물리·화학적 성질규명과 화학성분의 구조해석 및 효율적 가공·이용기술을 확립하기 위한 연구를 한다.","doWork":"목재의 재질·조직과 수종식별, 임산물의 표준화에 대한 연구를 한다. 국산재 활용의 다양성을 위하여 국산특용수자원의 우수재질 품종육성을 위한 용도별 재질기준을 확립하는 연구를 한다. 목조구조물의 구조·설계와 목재의 허용응력, 제재 및 건조 관련 기술개발연구를 한다. 수장용 및 구조용 집성재의 제조·이용기술, 집성재의 품질평가, 집성재 접합부의 성능평가, 집성구조물의 설계 및 축조기술 개발 및 집성재의 품질에 대한 연구를 한다. 목재의 화학적·물리적 가공기술의 개발 이용을 위하여 화학처리에 의한 목재 및 목질재료의 성능개선 및 목질신소재 개발을 위한 연구를 한다. 목재의 접합, 도장, 보존처리에 대한 연구를 한다. 목재의 화학처리에 의한 재질개량, 목재의 표면재질, 목재 성분의 기능소재에 대한 연구를 한다. 목재소재의 신기능 부여, 목재용 도료 및 도장, 목재의 조색 및 변·퇴색 방지 등에 관한 연구를 한다. 목재 및 목질재료의 생물학적 열화요인, 목재 및 목질재료의 보존처리, 목질재료의 내후성 평가 및 목재부후(목재가 썩어가는 현상) 메카니즘을 이용한 중금속류의 제거 등에 대한 연구를 한다. 각종 목질복합소재의 개발·이용, 목재접착에 관한 연구를 한다. 나무의 화학성분을 분석하여 종이, 숯과 목초액, 천연농약 등 우리 생활에 필요한 자원을 생산할 수 있는 기술과 표고나 송이와 같은 식용버섯자원을 개발하고 생산성을 높이는 기술에 관한 연구를 한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"연구분야에 따라 임산재료공학연구원, 목재가공연구원, 임산화학미생물연구원, 목재조직분류연구원, 목재물리구조역학연구원, 목재화학연구원, 목질복합재료연구원, 펄프종이연구원, 임산미생물연구원, 임산에너지연구원","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004689:1', '{"dJobCd":"K000004689","dJobCdSeq":"1","dJobNm":"임상시험모니터요원","workSum":"임상시험의 진행과정을 감독하고 확인한다.","doWork":"의뢰자의 의뢰를 받아 임상시험의 진행과정을 감독한다. 시험기관의 관리 및 임상시험 관련 필수서류를 관리한다. 해당 임상시험이 계획서, 표준작업지침서, 임상시험관리기준 및 관련 규정에 따라 실시되고 기록되는지 검토·확인한다. 임상시험이 진행되는 동안 병원에서 진행상황에 대해서 모니터링을 한다. 모니터링 이후 모니터링 동안 확인한 사항에 대한 보고서를 작성한다. 피험자의 등록상황과 적절성, 근거문서의 확인, 기본문서 보관상태 및 임상시험용 의약품의 수불상황을 확인하고 필요한 경우 이에 관하여 기관의 담당자 및 책임연구자와 논의한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"CRA, Clinical Research Associate","certLic":"간호사, 약사","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004634:1', '{"dJobCd":"K000004634","dJobCdSeq":"1","dJobNm":"임상시험책임자","workSum":"임상시험의 전 과정을 감독하고 책임진다.","doWork":"임상시험이 계획서대로 진행되는지 점검한다. 표준작업지침서 및 임상시험관리기준에 따라 실시되고 있는지 점검한다. 임상시험을 시작하기 전에 계획서, 동의서, 피험자설명서 등이 포함된 심사통보서를 심사위원회로부터 받고 이를 임상시험이 승인된 이후 시험기관의 장에게 보고한다. 임상시험을 안전하고 적절하게 실시할 수 있는 자격요건을 갖춘 적절한 수의 시험담당자와 적합한 장비 및 시설을 확보한다. 임상적으로 의미있는 실험실적 검사치의 이상을 포함하여 임상시험에서 이상이 발생할 경우 피험자가 적절한 의학적 조치를 받을 수 있도록 한다. 임상시험과 관련된 업무를 담당하거나 필요한 사항을 결정하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"의사, 치과의사, 한의사","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002410:1', '{"dJobCd":"K000002410","dJobCdSeq":"1","dJobNm":"임업시험연구원","workSum":"산림생산력 및 임업생산성 향상을 위하여 양묘, 갱신·육림, 임업기계화, 임도, 특용수종, 산림병충해 예방, 유용유전자원의 발굴보존 및 복원 등에 대한 시험·연구를 한다.","doWork":"주요 조림수종의 양묘사업기준을 정립하고 묘목규격표를 제작한다. 조림활착률 향상을 위한 양묘시업 기술개발에 관한 시험·연구를 한다. 산림자원을 증진시키기 위하여 생태적 갱신·육림시업법 개발, 고축적 다기능 목재생산림시업모델 개발, 산림생태계 특성을 이용한 산림조성기법 개발 등을 위한 시험·연구를 한다. 환경친화적이고 경제적인 녹색임도 건설을 위한 임도의 계획, 설계, 시공 및 유지관리기술에 대한 시험·연구를 한다. 우리나라 실정에 맞는 임업기계의 개량 및 개발, 임업기계의 성능 향상을 위한 시험, 연구를 통하여 산림작업의 기계화와 생산성 향상을 도모한다. 주요 조림수종에 대한 개량종자의 생산보급 및 품질향상과 유용한 향토수종을 발굴하여 신품종을 개발·보급하기 위한 시험, 연구를 한다. 난대수종의 자원화를 위한 조성 및 관리기술을 시험·연구한다. 특용임산물의 채취, 저장, 가공 및 이용기술개발을 위한 시험, 연구를 한다. 향토수종의 유용유전자원의 발굴, 보존 및 복원을 위한 시험·연구를 한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"임업분야의 생산성 증대와 기술개발을 위한 시험·연구분야에 따라 양묘시험연구원, 갱신육림시험연구원, 임도시험연구원, 임업기계시험연구원, 특수임산시험연구원","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004242:1', '{"dJobCd":"K000004242","dJobCdSeq":"1","dJobNm":"정밀농업기술자","workSum":"정밀농업(생산관리에 GIS, GPS 등의 최신기술을 접목한 과학적 농업) 관련 연구 및 기술개발, 기술보급사업 진행, 기술적용 등의 업무를 수행한다.","doWork":"정밀농업(작물의 생육상태나 위치별 토양조건에 따라 적합한 농자재 투입과 생육관리를 통하여 불필요한 농자재의 투입을 최소화함으로써 환경을 보호하면서도 수지(收支)를 최적화하는 농업기술)을 위해 농경지의 토양. 작물 등의 상태를 다양한 센서를 이용해 기초정보를 파악한다. 농업영향요인을 결정하기 위해 지리공간데이터와 함께 기초정보를 분석한다. 분석한 데이터를 농업인에게 제공한다. 농약살포 등 작업이 필요한 지역을 확인한다. 정밀농업용 기계를 관리하고, 작업정보를 분석 및 처리한다. 토지생산성과 수익성 등의 보고서를 작성한다. 기술지원을 위해 장비생산업체와 교류한다. 실험, 시범보급사업, 현장적용, 보급을 위한 농업지도 교육업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"정밀농업전문가, 정밀농업연구원, 정밀농업엔지니어, 스마트농업연구원, 스마트농업엔지니어","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"J639","dJobICdNm":"[J639]기타 정보 서비스업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006672:1', '{"dJobCd":"K000006672","dJobCdSeq":"1","dJobNm":"조경학연구원","workSum":"산림자원을 효율적으로 이용·관리하는 기술과 도시 및 자연환경을 미적·기능적으로 계획·설계·보존·복원하기 위한 기술을 연구·개발한다.","doWork":"생물자원, 무생물자원, 환경자원, 문화자원 등 산림과 관계있는 유형·무형의 자원을 대상으로 목재 및 산림부산물을 생산하는 경제적인 기능, 수원함량과 국토를 보존하고 쾌적한 환경을 조성하는 환경공익적 기능, 자연학습과 휴양, 여가공간을 제공하는 문화적인 기능을 효과적으로 강화하는 기술을 연구한다. 조경계획 및 설계(Landscape Architectural Planning and Design)분야의 경우, 토지의 합목적성을 달성하기 위해 다양한 성격과 기능, 규모의 부지에 대한 조경계획 및 설계에 관련된 연구를 한다. 조경식물·생태·복원(Landscape Plant·Ecology·Restoration)분야의 경우 자연환경의 보존, 훼손된 환경의 복원 등 친환경적 공간조성과 유지에 관련된 기술을 연구한다. 조경시공·재료(Landscape Architectural Construction and Material)분야의 경우, 조경계획 및 설계를 바탕으로 미적이며 구조적이고 경제적인 시공방법과 재료에 대한 연구를 수행한다. 조경관리학(Landscape Management)분야의 경우, 조경물 및 관련 시설물에 대한 관리기술을 연구한다. 조경정보학(Landscape Infomation)분야의 경우, GIS(Geographic Information System:지리정보시스템) 및 CAD 등의 전산기술을 이용하여 조경계획, 설계, 시공 등의 과정을 효과적으로 하는 기술을 연구한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|청각|손사용|언어력|시각|","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"조경계획연구원, 조경설계연구원, 조경식물생태복원연구원, 조경시공재료연구원, 조경관리학연구원, 조경정보학연구원","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002146:1', '{"dJobCd":"K000002146","dJobCdSeq":"1","dJobNm":"종축개량연구원","workSum":"우수한 품질의 가축 및 가금을 생산하기 위한 유전자원보전, 질병예방, 품종선정 및 보급 등에 관한 기술을 개발하기 위한 연구를 한다.","doWork":"가축 및 가금에 대한 개량계획을 수립하고, 개량방향 및 목표를 설정한다. 가축 및 가금의 유전 관련 자료를 수집하고 유전능력분석시스템을 개발하여 정확한 유전능력평가자료로 활용한다. 가축 및 가금의 유전보존 및 이용기술, 수정란 이식 및 인공수정 실용화기술의 개발을 위한 연구를 한다. 가축 및 가금의 질병예방 및 치료효과증대를 위한 저비용 치료기술을 개발한다. 한우, 육우 및 젖소의 품질개량 및 능력검정, 사양관리 등에 관한 기술개발을 위한 연구를 한다. 한우, 육우 및 젖소에 대한 심사·선발, 생산 및 보급에 관한 기술개발과 생산·보급체계 설정에 관한 연구를 한다. 한우, 육우 및 젖소에 대한 경영기술, 사육자동화, 사료이용 효율의 증진, 품종보존 및 생산 등에 관한 연구를 한다. 돼지, 토끼 등의 중소가축의 품종개량과 능력검정 등에 관한 연구를 한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|시각|","workEnv":"대기환경미흡|위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"가축 및 가금을 개량하는 연구를 하는 전문분야에 따라 종축개량검정기술연구원, 대가축개량연구원, 중소가축개량연구원","certLic":"가축인공수정사","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001301:1', '{"dJobCd":"K000001301","dJobCdSeq":"1","dJobNm":"종판별전문가","workSum":"확립된 분류시스템(종속과목강문계)를 기반으로 다양한 생물종을 식별하며 유사한 특성과 패턴을  기준으로 묶거나 새로 나누며 신종인 경우 새로운 이름을 붙인다.","doWork":"생물다양성 연구 과제계획서를 작성한다. 연구지역과 연구대상를 설계한다. 프로젝트 수행에 따른 생물다양성 현장 조사를 수행하고 채집 및 DNA 시료 분석을 한다. 조사 결과에 따른 데이터 산출 및 분석, 통계 처리 및 과학적 표본제작 등의 업무를 한다. 형태학적, 생리학적 특성을 반영하여 동물, 식물, 곤충, 바이러스 등 자연환경 생물이 확립된 분류체계에서 어디에 속하는 지 결정하는 동정(identification)업무를 한다. 신종이 있다면 이름을 명명하는 일을 한다. 보고서를 작성하고 논문을 출판한다. 프로젝트 평가 및 데이터 세트를 관리한다. 보고회에서 조사 및 연구결과를 발표하고 생물다양성 등을 강의한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"종동정전문가","connectJob":"동물종판별전문가 식물종판별전문가, 미생물 종판별전문가","certLic":"생물분류기사","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005452:1', '{"dJobCd":"K000005452","dJobCdSeq":"1","dJobNm":"진단의약개발연구원","workSum":"생명공학기술을 이용하여 질병진단을 위한 진단시약을 연구·개발한다.","doWork":"진단하고자하는 질병의 원인균을 검출할 수 있는 생명공학기술(생화학반응, 항원항체반응, 유전자증폭 기술 등)을 정한다. 진단에 사용되는 생명공학기술에 필요한 원료물질(생화학반응 효소, 항원단백질, 항체, 유전자증폭 효소, 유전자증폭 반응 시약 등)을 생산하는 최적조건을 실험하여 원료물질을 양산한다. 원료물질을 이용한 질병 진단시약 제조 최적조건을 실험하여 시제품을 제조한다. 시제품을 이용하여 감염자와 비감염자의 시료에 대한 임상시험을 수행한다. 임상시험 결과를 수집하여 인허가에 필요한 데이터를 준비하고, 양산에 필요한 기술이전을 준비한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"시각|","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","similarNm":"진단시약개발연구원","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005208:1', '{"dJobCd":"K000005208","dJobCdSeq":"1","dJobNm":"채소연구원","workSum":"채소의 품종육성 및 육종 기술개발 및 재배기술개발 등을 위한 연구를 한다.","doWork":"채소 품종육성, 유전 및 육종기술 개발에 관한 연구를 수행한다. 채소 유전자원 수집·평가 및 보존에 관한 연구를 수행하고 유전자원에 대한 정보를 관리한다. 채소 재배방법 개선, 스마트 농업 기술을 개발한다. 재해경감에 관한 연구를 수행하고 기후변화 영향평가 및 대응기술을 개발한다. 채소 생리장해 원인구명과 대책, 물질대사, 기능성 향상 등 생리·생태에 관한 연구를 수행한다. 채소 분자 육종 및 신육종 기술 개발에 관한 연구를 수행한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"채소를 연구하는 전문분야에 따라 채소육종연구원, 채소재배연구원","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003681:1', '{"dJobCd":"K000003681","dJobCdSeq":"1","dJobNm":"천연물의약연구원","workSum":"천연약물(생약)과 유용천연물을 활용하여 원료의약품, 천연항산화제, 천연항균제 등 새로운 생리활성물질을 개발하는 연구를 한다.","doWork":"대상으로 하는 원료의 동속, 근속식물들의 견본을 비교·검토한 후 원료를 선정한다. 약전에 의한 일반분석을 실시한다. 단리작업을 통해 얻어진 각각의 분취분에 대한 확인·동정·정량분석을 실시한다. 추출, 농축, 단리, 여과 등 물리·화학적 방법을 통하여 제제화(약물을 인체에 적용할 때 사용법과 적용이 쉽고 항상 일정한 유효성이 확보되도록 적당한 형상, 형태, 형식 따위를 주는 조작)한다. 천연물질을 응용하여 음료 및 차, 제과 등에 적합한 원료를 선택하여 반복실험을 통하여 식품을 개발하기도 한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"시각|","workEnv":"대기환경미흡|위험내재|","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","connectJob":"천연물식품연구원","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004668:1', '{"dJobCd":"K000004668","dJobCdSeq":"1","dJobNm":"체육의학연구원","workSum":"국민의 건강 및 체력관리와 운동선수들의 경기력 향상을 위한 의학연구를 수행한다.","doWork":"성인병 예방 및 처치를 위한 운동프로그램을 개발한다. 운동선수의 혈액학적 검사를 지원한다. 체력진단 및 운동처방에 관한 의학적 검사내용을 체계화시킨다. 운동상해에 관한 예방 및 분석과 재활에 관한 의학적인 연구를 수행한다. 매스컴을 통하여 국민의 건강 및 체력관리에 필요한 정보를 제공한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내·외","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005592:1', '{"dJobCd":"K000005592","dJobCdSeq":"1","dJobNm":"초지사료연구원","workSum":"양질의 다수성 목초와 사료작물을 재배하기 위하여 사료작물의 육종, 생산, 이용과 초지관리에 관한 연구를 한다.","doWork":"양질의 다수성 목초 및 사료작물을 생산하기 위하여 품종개량과 품종선정에 관한 연구를 한다. 초지 조성기술 및 비옥도 증진에 관한 연구를 한다. 초지의 개량, 설계 및 시설에 관한 연구를 한다. 초지의 생산성 증대 및 유지, 관리에 관한 연구를 한다. 목초 및 사료작물의 영양생리 및 생태에 관한 연구를 한다. 사료작물의 재배 및 이용기술에 관한 연구를 한다. 부존 조사료(지방, 단백질, 전분 등의 함량이 적고 섬유질이 18% 이상 되는 사료)자원의 개발과 이용에 관한 기술을 연구한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"웅크림|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"초지사료에 대한 전문연구분야에 따라 사료작물육종연구원","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002485:1', '{"dJobCd":"K000002485","dJobCdSeq":"1","dJobNm":"축산물이용연구원","workSum":"축산물의 효율적인 이용을 위하여 품질, 유통기술 및 이용에 대한 개선, 개발을 위한 연구를 한다.","doWork":"축산물의 품질을 향상시키고 안전하게 처리·가공하기 위하여 처리·가공기술을 개발한다. 축산진흥을 위하여 축산물품질에 대한 평가 및 규격화, 품질의 인증 및 안전성 등에 대한 기술을 개발한다. 축산물과 관련된 미생물과 기능성에 대한 개발을 통하여 우유 및 계란제품의 질을 향상시킨다. 우유 및 계란에 대한 품질평가기법과 품질인증 및 규격화를 확립하기 위한 연구를 한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"축산물에 대한 이용기술을 연구하는 전문분야에 따라 육류품질유통연구원","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002024:1', '{"dJobCd":"K000002024","dJobCdSeq":"1","dJobNm":"축산시설환경연구원","workSum":"축산물의 생산성 향상을 위한 축산시설 및 분뇨자원화에 관한 연구를 한다.","doWork":"축산종별에 따른 축사의 표준모델을 설정한다. 가축 및 가금의 사양관리 및 환경조절에 관한 연구를 한다. 경제적인 축산경영을 위하여 가축 및 가금의 경영 및 투자한계분석에 대한 연구를 한다. 가축 및 가금의 사양관리시설과 기계의 개발을 위한 연구를 한다. 저비용 고효율의 분뇨처리 및 자원화에 대한 연구를 통하여 축산농가의 경영개선을 지원한다. 축산환경을 개선하기 위하여 축산분뇨배출량의 저감 및 악취방지 등의 기술개발에 관한 연구를 한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"축산시설환경에 대한 전문연구분야에 따라 가축분뇨자원화연구원","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002651:1', '{"dJobCd":"K000002651","dJobCdSeq":"1","dJobNm":"축산육종번식연구원","workSum":"가축 및 가금의 유전육종 및 번식생리에 대한 연구를 한다.","doWork":"가축 및 가금의 생리유전, 형질발현기구, 유전자의 구조 및 기능 등에 대한 연구를 한다. 동물세포단위의 유용한 유전자원, 유전자의 구조분석 및 발현조작 등에 관한 연구를 한다. 가축 및 가금의 생식기능 및 내분비제어, 생식세포이식 및 가축의 수태 등에 관한 연구를 한다. 생명유전공학에 대한 시험, 연구를 통하여 신소재물질을 생산하는 가축 및 기능성 단백질을 생산한다. 복제기술을 이용하여 고능력가축을 생산한다. 우량가축의 선발효율제고를 위한 기법을 개발하기 위하여 연구를 한다. 가축 및 가금의 고유유전자의 특성규명 및 활용기법을 개발한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|시각|","workEnv":"대기환경미흡|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"가축 및 가금에 대한 육종번식을 연구하는 전문분야에 따라 축산분자유전연구원, 축산번식생리연구원","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004209:1', '{"dJobCd":"K000004209","dJobCdSeq":"1","dJobNm":"친환경농법연구원","workSum":"농사방법을 친환경적으로 바꾸는 친환경농법에 관한 연구를 한다.","doWork":"농사방법을 친환경적으로 바꾸어 친환경농업을 실현하는 농법을 연구한다. 오리나 우렁이, 새우 등을 이용한 제초법, 지렁이를 이용한 천연비료의 생산, 그린음악을 이용한 농작물의 생장촉진, 흙살림순환농법(배출된 음식물찌꺼기를 닭에게 주고, 닭의 배설물은 퇴비장에서 지렁이 등을 이용하여 퇴비화하여 순환시키는 농법), 한 경작지에 특성이 다른 두 종류 이상의 작물을 같이 재배하는 혼작(섞어짓기) 등의 친환경농법을 연구한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|시각|","workFunc1":"종합","workFunc2":"자문","workFunc3":"정밀작업","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006401:1', '{"dJobCd":"K000006401","dJobCdSeq":"1","dJobNm":"친환경농자재연구원","workSum":"토양개량자재, 작물생육자재, 병해관리자재, 충해관리자재 등의 친환경농자재를 연구·개발한다.","doWork":"인체에 유해하고 환경오염을 유발하는 기존의 화학 비료나 농약 대신에 생태계를 교란시키지 않고 토양을 개선할 수 있는 친환경 농자재(토양개량자재, 작물생육자재, 병해관리자재, 충해관리자재 등)를 연구·개발한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004164:1', '{"dJobCd":"K000004164","dJobCdSeq":"1","dJobNm":"토양관리연구원","workSum":"토양의 건전한 유지 및 관리를 위한 제반 연구를 한다.","doWork":"토양 내에서 물, 공기, 양분의 이동을 좋게 하기 위한 토양의 물리성 개선에 관한 연구를 한다. 작물생산에 알맞은 토양의 물리구조와 토양의 물리적 개량방법 및 자재개발 등에 관해 연구한다. 지리정보시스템기술(Geographic Information System)을 이용하여 토양비옥도를 전산화하여, 작물재배 적정지역을 선정한다. 농업환경보존을 위한 토양을 조사·분석한다. 토양분류를 통해 작물별 토양적성등급 및 관리기준을 설정한다. 토양별, 작물별 적정한 양분 기준을 설정한다. 토양 내에서 양분의 이동 및 변화 등에 대한 연구를 통하여 작물생산에 알맞은 토양의 화학적인 성질을 분석한다. 토양의 유실로 인한 수질오염 분석 및 위성영상자료 분석을 통한 토양의 이용변화에 대해 조사를 한다. 토양의 양분 및 수분보존을 위한 토양유실 방지에 관한 연구를 한다. 농업환경에 관한 국제협약 관련 연구를 통하여 농업환경정책 및 방향을 수립한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"토양을 연구하는 전문분야에 따라 토양물리연구원, 토양자원연구원, 토양비옥도연구원, 토양보전연구원","certLic":"토양환경기술사, 토양환경기사, 농림토양평가관리산업기사","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004223:1', '{"dJobCd":"K000004223","dJobCdSeq":"1","dJobNm":"한약재검사연구원","workSum":"한약재의 성분 및 품질을 검사하고, 한약의 품질평가 및 규격화에 대해 연구한다.","doWork":"한약재의 판별 및 검사를 위해 관능검사를 실시한다. 한약재의 성분, 위해물질 여부, 중금속 여부 등을 이화학기기를 사용하여 분석한다. 한약규격화를 위하여 한약품질관리의 객관적 기준설정에 적합하도록 감별법을 연구한다. 한약의 성분분리, 성분함량 및 패턴분석, 각종 이화학적 평가를 한다. 품질평가방법과 품질관리방안에 대한 연구를 한다. 한약의 효능에 대해 연구한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"한의사, 한약사","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005260:1', '{"dJobCd":"K000005260","dJobCdSeq":"1","dJobNm":"한약재품질규격연구원","workSum":"한약재의 효능 극대화를 위해 한약재의 수취방법, 기미이론의 과학적 증명, 한약재의 미량성분분석 등에 관한 연구를 한다.","doWork":"열추출법(적절한 온도의 열로 한약재에서 약재성분을 뽑아내는 것), 에탄올추출법(막걸리나 소주 등 알코올성분을 이용하여 약재성분을 뽑아 내는 것), 물추출법(물을 이용하여 약재성분을 뽑아내는 것) 등과 같은 한약재의 수취방법들을 대상으로 어떤 방법이 약재의 효과를 더 높일 수 있는가를 연구한다. 한약의 기미이론(한약재가 따뜻할 때와 차가울 때 그 효능이 다르다는 이론)에 대한 과학적인 분석을 실시한다. 한약재의 품질개선, 신제품개발, 원료대체, 공정개선, 기호도조사, 보존성시험, 원료등급부여 등을 목적으로 한약재의 관능적 특성(색상, 향, 맛, 식감)을 인간의 감각을 통해서 평가·해석한다. 한약재의 현재 밝혀지지 않은 성분 등을 분석하기 위해 미량물질의 성분을 연구하며, 필요에 따라 동위원소분석을 한다. 새로운 물질 혹은 신약을 개발하여 동물실험을 하고, 적용성이 검증되면 임상실험을 한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"한의사, 한약사","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003853:1', '{"dJobCd":"K000003853","dJobCdSeq":"1","dJobNm":"한약제제연구원","workSum":"각종 질환을 치료하기 의해 한약제제(한방진료에서 사용하는 한약이나 한약을 병증에 맞도록 복합시켜 만든 처방제)에 대해 시험·분석하고 연구한다.","doWork":"한약제제추출방법에 대해 연구한다. 한약제제방법에 대해 연구한다. 독소감소 및 효능증감에 대해 연구한다. 유효한 약성분을 분석한다. 치료제한 약제형(藥劑型)을 연구한다. 수치한약재 및 그 함유제제의 안전성에 대해 연구한다. 한약제제를 이용한 식품연구를 한다. 신약개발 후 동물을 대상으로 실험한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"한의사, 한약사","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001384:1', '{"dJobCd":"K000001384","dJobCdSeq":"1","dJobNm":"한의경락연구원","workSum":"의학의 경락체계를 현대과학의 분석틀로 연구·개발하고, 임상치료에 응용하는 연구를 한다.","doWork":"인체 경혈들의 연결체계와 상호작용 등을 과학적으로 규명하기 위해 경락의 전반적인 흐름도를 찾는 연구를 한다. 경락과 경혈에 대한 연구결과를 질병의 진단, 예방, 치료에 이용하는 방안을 연구한다. 실험대상자를 선정하여 경락의 경혈을 취하고(한번에 4~6개), 심전도용 전극을 테이프로 경락에 붙인 후, 심전도측정용 앰프에 전극을 연결시킨다. Physio Graph(생리그래프)로 측정 전위치를 시간에 맞춰 측정한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"한의사","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005411:1', '{"dJobCd":"K000005411","dJobCdSeq":"1","dJobNm":"한의노화연구원","workSum":"인체노화의 원인과 예방에 대해 한의학적 연구를 수행한다.","doWork":"노화를 연구하기 위한 한약재를 선별한다. 한약재를 자른 후 뜨거운 물이나 에탄올을 이용하여 필요한 성분을 추출한다. 약재성분 수취 후, 농축한 뒤 동결건조한다. 한약재를 이용한 항노화실험을 한다. 추출물을 사용하여 세포의 활성화 및 동물의 변화(운동량, 생리적 변화 등)를 관찰한다. 이를 위해서 작두, 농축기, 가열기, 고속냉동기, 냉동건조기, 초음파세척기, 무균생장촉진기, 항온수조, 이산화탄소배양기, 현미경, 원심분리기 등의 장비를 이용한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"시각|","workEnv":"대기환경미흡|위험내재|","workFunc1":"분석","workFunc2":"협의","workFunc3":"정밀작업","certLic":"한의사","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003901:1', '{"dJobCd":"K000003901","dJobCdSeq":"1","dJobNm":"한의암연구원","workSum":"암예방 및 치료를 위한 한의학적 연구를 수행한다.","doWork":"암예방 및 치료에 효과가 있는 한약재를 추출하여 농축한 다음, 동결건조한다. 뜨거운 물이나 에탄올을 이용하여 필요한 성분을 추출한다. 추출물을 동결건조한다. 암세포주(간암세포주, 위암세포주, 혈액암세포주 등)를 분양받아 배양한다. 암세포의 배양 후 한약재에서 추출한 물질을 암세포에 투여하여 암세포의 덩어리나 숫자의 증감을 관찰한다. 쥐와 같은 동물 등을 이용하여 생체에 직접 투여한 후 관찰하는 생체실험(In Vivo)과 세포에 투여하여 관찰하는 세포실험(In Vitro)을 한다. 작두, 농축기, 가열기, 고속냉동기, 냉동건조기, 초음파세척기, 무균생장촉진기, 항온수조, 이산화탄소배양기, 현미경, 원심분리기 등의 장비를 이용한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"시각|","workEnv":"대기환경미흡|위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"한의사","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004533:1', '{"dJobCd":"K000004533","dJobCdSeq":"1","dJobNm":"한의학연구원","workSum":"사상체질의학을 비롯한 한의학이론을 체계적으로 분석하고 연구방법론을 개발한다.","doWork":"생물학적·생물공학적 체질진단에 대해 연구한다. 체질약물에 대해 연구한다. 체질경락에 대해 연구한다. 체질정보기반 구축에 대해 연구한다. 변증의 진단기준을 표준화한다. 한방치료방법의 표준화에 대해 연구한다. 한의학이론의 체계적 분석 및 연구방법론을 개발한다. 한의학 고서의 번역, 복원에 대해 연구한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"연구분야에 따라 한의기초과학연구원, 한의임상과학연구원, 한약제제개발연구원, 한방용치료기기연구원, 한방용진단기기연구원, 한의정보표준화시스템연구원","certLic":"한의사","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004476:1', '{"dJobCd":"K000004476","dJobCdSeq":"1","dJobNm":"해부학연구원","workSum":"사람과 동물의 형태, 구조 및 기타 해부학적 특성 그리고 이것을 의학 및 관련 분야에 적용하기 위한 연구를 한다.","doWork":"사람과 동물의 신체를 체계적으로 해부하고 현미경을 사용하여 관찰한다. 신체기관의 상세한 구조, 조직 및 세포를 검사한다. 서로 다른 종류의 동물들에 대한 신체구조를 비교한다. 신체의 손상 및 상처부분의 재생능력, 생명체 간의 기관과 조직의 이식가능성 등을 조사하기 위하여 해부학적인 특성과 반응을 실험·연구한다. 의학에 적용하기 위하여 생물학의 기본법칙을 연구한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005076:1', '{"dJobCd":"K000005076","dJobCdSeq":"1","dJobNm":"해양바이오에너지연구원","workSum":"해양자원을 활용한 해양바이오에너지의 개발 및 생산에 관해 연구한다.","doWork":"해양자원인 우뭇가사리, 구멍파갈래 등 해조류를 포함한 해양생명을 정제·발효하여 생산하는 바이오에너지(해조류 유래바이오매스에너지, 미세조류를 이용한 바이오디젤, 바이오에탄올, 해양성조류 생채에 의한 바이오가스, 바이오수소 등)를 연구한다. 대량생산에 적합한 해조류 등 해양생물의 품종을 개량하는 연구를 한다. 해조류에 적합한 발효기술과 에너지로 정제하는 기술을 연구한다. 스피루리나 등 녹조미세조류를 이용하여 바이오에너지를 생성하는 바이오디젤에 대한 연구도 수행한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003171:1', '{"dJobCd":"K000003171","dJobCdSeq":"1","dJobNm":"해양생물유전자연구원","workSum":"해양생물의 유전정보를 검출하여 데이터베이스로 구축하고, 유전자변형수산물의 안정성을 평가한다.","doWork":"넙치, 전복 등 해양생물의 시료를 채취하여 약품처리, 원심분리기, 침전 등의 방법으로 활용하여 DNA와 RNA를 추출한다. DNA에서 염기서열을 찾아내고 유전자형을 검출하여 데이터베이스에 구축한다. 유전자형을 통해 원산지판별을 위한 유전자평가지표를 개발한다. 수산생물에서 항암활성, 황산화활성, 혈압조절활성 및 항균활성물질을 추출한다. 유전자변형수산물의 안정성을 심사한다. 유전자변형수산물의 안정성을 평가한다. 유전자변형수산물의 취급에 관한 관리지침을 제안한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"손사용|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003779:1', '{"dJobCd":"K000003779","dJobCdSeq":"1","dJobNm":"해양생태연구원","workSum":"해양생태계 및 수산자원의 변동을 조사·연구한다.","doWork":"조사선을 타고 해역에 나가 해양생태계 및 수산자원의 변동을 조사한다. 조사자료를 수집·분석하고 대응전략을 수립하기 위한 연구를 한다. 지구탐사관측 위성자료를 토대로 수온전선대 및 수온, 먹이분포 등의 해양정보를 분석·제공한다. 위성자료의 원격탐사기법 개발을 연구한다. 한반도 주변해역의 해양변동에 대해 연구한다. 해양정보나 연구결과를 책자로 발간한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"손사용|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002120:1', '{"dJobCd":"K000002120","dJobCdSeq":"1","dJobNm":"화훼연구원","workSum":"화훼작물의 품종육성 및 재배법에 관한 연구와 유전자원의 수집, 보존, 활용에 관한 연구를 수행한다.","doWork":"화훼작물 품종육성과 유전 및 육종방법 개발을 위한 연구를 수행한다. 고품질·고생산성의 화훼를 안정적으로 생산하기 위해 화훼작물의 생리·생태를 연구한다. 화훼류 및 관엽류(잎사귀의 빛깔이나 모양을 관상하기 위하여 재배하는 식물) 유전자원을 수집하고 평가, 보존 연구를 수행한다. 화훼류 및 관엽류 식물에 대한 연구를 통하여 재배방법의 개선 및 번식에 대한 기술을 개발한다. 화훼 자원 활용 경관화훼 모델 개발 및 활용, 화훼 향기·기능성 연구와 산업소재화 연구를 수행한다. 절화, 분화 등 화훼 상품화 및 유통에 관한 연구를 수행한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"화훼식물에 대한 전문연구분야에 따라 초본화훼연구원, 목본화훼연구원","dJobECd":"1221","dJobECdNm":"[1221]생명과학 연구원","dJobJCd":"2111","dJobJCdNm":"[2111]생명과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001395:1', '{"dJobCd":"K000001395","dJobCdSeq":"1","dJobNm":"고분자재료연구원","workSum":"고분자구조 및 물성, 중합체의 결정성 등에 관한 고분자재료의 구조에 관하여 연구한다","doWork":"고분자의 합성법, 중합반응 메커니즘과 반응속도, 고분자의 구조 및 분자량 결정법, 고분자의 구조와 물성 간의 상호관계 등 고분자재료의 구조에 관하여 연구한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","connectJob":"고분자계 복합소재, 복합공정, 복합구조 등에 관한 연구를 할 경우 고분자복합재료연구원, 고분자구조재료연구원, 중합반응공정기술연구원, 개질기술연구원, 전자정보용소재기술연구원, 의료용소재기술연구원, 에너지환경산업용소재기술연구원, 특수기능성소재기술연구원, 고분자재활용기술연구원, 고분자가공기술연구원, 나노소재기술연구원","dJobECd":"1211","dJobECdNm":"[1211]자연과학 연구원","dJobJCd":"2112","dJobJCdNm":"[2112]자연과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003597:1', '{"dJobCd":"K000003597","dJobCdSeq":"1","dJobNm":"고분자화학연구원","workSum":"고분자의 합성, 구조, 물성 및 고분자물질의 응용에 관하여 연구한다.","doWork":"고분자 합성(Polymer Synthesis) 분야의 경우 거대 사슬인 고분자를 합성하는 연구를 수행한다.고분자 구조/물성(Polymer Structure/Properties) 분야의 경우 고분자의 구조 및 특성을 파악하는 연구를 수행한다.고분자 물리화학(Physical Chemistry of Polymers) 분야의 경우 용액, 젤, 액상, 용융상특성 등 고분자 용액상 거동, 액체 및 용융상 흐름의 물리적 특성 등의 특징을 이해하고 응용하는 연구를 수행한다. 생체 의료용 고분자(Biomedical Polymers) 분야의 경우 치료, 진단, 보건 및 웰빙용 생체의료용 고분자의 설계 및 합성을 연구한다. 전기/전자/광특성 고분자(Electric/Electronic/Photonic Polymers) 분야의 경우 전기 및 전자, 광특성을 갖는 고분자 물질을 합성하고 특성 파악 및 응용성을 확인하는 연구를 수행한다. 기능성 고분자(Functional Polymers) 분야의 경우 고분자 물질에 기능성 부여하거나 기능을 갖고 있는 고분자 물질을 합성하고 응용하는 연구를 수행한다. 환경친화성 고분자(Environmentally Benign Polymers) 분야의 경우 생분해 고분자 재생 고분자 등의 연구를 수행한다. 에너지 고분자(Polymers for Energy) 분야의 경우 이차전지, 태양전지, 연료전지용 고분자 소재를 연구한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","connectJob":"고분자합성연구원, 고분자구조물성연구원, 고분자물리화학연구원, 전기전자광특성고분자연구원, 기능성고분자연구원, 친환경성고분자연구원, 에너지고분자연구원","dJobECd":"1211","dJobECdNm":"[1211]자연과학 연구원","dJobJCd":"2112","dJobJCdNm":"[2112]자연과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;