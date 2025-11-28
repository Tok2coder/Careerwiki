INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006935:1', '{"dJobCd":"K000006935","dJobCdSeq":"1","dJobNm":"제지기술개발원","workSum":"사용성과 경제성, 최신 기술을 분석하여 새로운 제지 기술이나 제품을 연구·개발한다.","doWork":"주 원료의 가격변동 또는 저가 원료의 사용 타당성 여부와 경제성을 검토·분석한다. 질이 좋은 새로운 원료의 사용 타당성과 지질 향상에 대한 기여도 등을 분석한다. 가동되고 있는 제지기계의 효율적 운영, 원가절감 및 원료절감 방안 등에 대한 종업원의 창안이나 자료를 검토하여 비교·분석한다. 통계자료를 기준으로 제지작업 표준서를 만든다. 문제점을 제시하고 작업원에게 알린다. 새로운 기계의 도입에 따른 담당 작업원을 교육한다. 지폐, 유가증권 등 특수 용지의 물리적·화학적 특성과 위변조 방지요소 등을 분석·개발하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"교육","workFunc3":"정밀작업","connectJob":"특수제지특성연구원","certLic":"화공기술사, 화공기사, 화공산업기사, 임산가공기사","dJobECd":"1599","dJobECdNm":"[1599]기타 인쇄·목재 등 공학 기술자 및 시험원","dJobJCd":"2399","dJobJCdNm":"[2399]기타 공학 관련 기술자 및 시험원","dJobICd":"C171","dJobICdNm":"[C171]펄프, 종이 및 판지 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006329:1', '{"dJobCd":"K000006329","dJobCdSeq":"1","dJobNm":"종이제품시험원","workSum":"품질규격에 맞는 종이제품 생산을 위하여 투입되는 각종 원·부자재, 반제품 및 완성제품을 시험·검사한다.","doWork":"검사품목항목에 따라 시험·검사할 내용을 확인한다. 시험·검사하는 품목 및 방법에 따라 미생물측정기, 화학반응기, 장력측정기, 인장력측정기 등의 각종 화학·물리시험장비를 선택한다. 위생, 안정성 및 제품규격의 합격 여부 등을 검사하기 위하여 투입할 원·부자재, 공정 중 제조된 반제품 및 완성제품의 견본품을 수집하여 미생물검사, 잔류용제검사, 인쇄상태, 측면접착상태, 타발 상태 등을 검사한다. 산·염기측정기(pH meter)를 사용하여 견본의 산성도를 측정한다. 마이크로미터(Micrometer)와 전자식 저울을 사용하여 견본의 평량, 두께, 크기 등을 측정한다. 표준 화학분석법으로 펄프용액의 함량을 확인·결정한다. 현미경을 이용하여 종이의 단위 면적당 나타나는 얼룩, 주름상태 등을 파악한다. 특정한 장비를 이용하여 견본의 파열강도, 인열강도, 내절도 등을 시험한다. 백색도 측정기를 사용하여 백색도와 명도를 시험한다. 시험내용을 기록하고 지류별로 통계표를 작성한다. 제지공정별로 나오는 농도, 함수율, 온도, 투입 약품량, 압력 등의 데이터를 기계별, 지종별 등으로 통계를 내어 자료로 활용한다. 수입된 원·부자재의 품질을 검수하기 위하여 시험하기도 한다. 제지공정에 사용되는 기기의 정확성을 검사 및 보정하기도 한다. 검사결과를 기록하고 문제점을 관련 부서에 통보하여 조치하도록 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"감독","workFunc3":"정밀작업","connectJob":"카톤팩품질검사원, 위생용품품질검사원","certLic":"임산가공기사","dJobECd":"1599","dJobECdNm":"[1599]기타 인쇄·목재 등 공학 기술자 및 시험원","dJobJCd":"2399","dJobJCdNm":"[2399]기타 공학 관련 기술자 및 시험원","dJobICd":"C172/C179","dJobICdNm":"[C172]골판지, 종이 상자 및 종이 용기 제조업 / [C179]기타 종이 및 판지 제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003030:1', '{"dJobCd":"K000003030","dJobCdSeq":"1","dJobNm":"종이제품연구개발원","workSum":"위생용품, 상자 등 각종 종이제품에 대한 품질개선 및 신제품 개발, 원료 절감, 생산설비의 효율적 운영방안 등을 연구·개발하여 제안한다.","doWork":"수립된 연구계획에 관련된 주요사항을 연구개발관리자와 협의한다. 연구와 관련된 종이제품의 각종 자료를 수집하여 분석한다. 분석 자료를 근거로 제품을 개선·개발하기 위하여 원·부자재의 대체 여부, 품질향상 방안, 각종 제조설비의 효율적 운영, 원가 절감 및 원료 절감 방안 등 연구·개발한다. 작업자의 생산성 향상을 위한 의견을 받아 타당성을 검토한다. 연구·개발 중에 발생한 문제점과 완료된 연구 자료를 작성하여 연구개발관리자에게 보고한다. 통계 및 연구 자료를 기준으로 최적 생산을 위한 작업표준명세서, 품질규격서 등을 작성한다. 생산성 향상 및 품질개선을 위한 방안을 제시하고 작업원에게 알린다. 새로운 설비 및 기계의 조작법을 담당 작업자에게 교육시키기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"임산가공기사","dJobECd":"1599","dJobECdNm":"[1599]기타 인쇄·목재 등 공학 기술자 및 시험원","dJobJCd":"2399","dJobJCdNm":"[2399]기타 공학 관련 기술자 및 시험원","dJobICd":"C172/C179","dJobICdNm":"[C172]골판지, 종이 상자 및 종이 용기 제조업 / [C179]기타 종이 및 판지 제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006530:1', '{"dJobCd":"K000006530","dJobCdSeq":"1","dJobNm":"침대개발연구원","workSum":"인체에 적합한 침대를 개발하고 원자재의 물성을 시험한다.","doWork":"침대 제조 시 필요한 각종 원자재의 물성을 측정하기 위하여 만능재료시험기와 낙하중 시험기 등으로 경강선, 펠트(Felt) 등과 같은 내장재의 인장강도, 연신율, 파괴강도 등을 시험한다. 제작된 매트리스의 물성 및 인체 적합성을 측정하기 위해 내구성 시험기, 완충시험기 등을 사용하여 매트리스의 내구성 및 반발력을 측정한다. 최첨단 컴퓨터를 이용하여 매트리스 위에 누운 사람의 체압을 측정하여 매트리스의 탄력이 사람의 체압에 미치는 영향을 측정한다. 수면측정시스템을 이용하여 매트리스 사용자의 안락감을 측정 및 평가하고 최적의 침대를 개발한다. 자동침대, 환자용 특수침대 등 다양한 매트리스 제품을 개발한다. 가구디자이너와 함께 신제품을 연구·개발한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"침대시험연구원","connectJob":"인간공학기술자","dJobECd":"1599","dJobECdNm":"[1599]기타 인쇄·목재 등 공학 기술자 및 시험원","dJobJCd":"2399","dJobJCdNm":"[2399]기타 공학 관련 기술자 및 시험원","dJobICd":"C320","dJobICdNm":"[C320]가구 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003516:1', '{"dJobCd":"K000003516","dJobCdSeq":"1","dJobNm":"항로표지설치기술자","workSum":"등대, 등표, 입표, 부표, 안개신호, 전파표지, 특수신호표지 등 항행하는 선박에게 지표가 되는 항로표지시설을 설계·시공한다.","doWork":"선박의 안전, 해저지형, 수심, 저질, 장해물 등의 여건을 고려하여 해도상에 항로표지의 설치위치를 결정한다. 설치지점의 해저지형이나 지질, 수심, 조류, 파고 및 풍력 등 해상여건을 조사·검토한다. 항로표지의 형식, 개류구, 부속장치 등의 종류와 크기를 결정한다. 항로한계선, 등·부표배치선, 항로상 변칙점, 준설항로 및 협소한 자연적 항로, 법정권고 설치기준, 항만표지 배치기준 등을 검토한다. 등·부표의 중량분포, 중심·부심·경심의 높이, 진동주기, 외력에 의한 경사각, 배수체적과 흘수, 조류, 파도 등을 고려해서 등·부표의 안정성을 계산한다. 적절한 체인의 길이와 장력을 계산하고 침주의 종류와 중량을 결정한다. 규정에 따라 부표설치요구서를 주무관청에 제출하고 승인을 받는다. 설치현장에서 시공을 지휘·감독하고 관련 기술을 지원한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"항로표지기사","dJobECd":"1599","dJobECdNm":"[1599]기타 인쇄·목재 등 공학 기술자 및 시험원","dJobJCd":"2399","dJobJCdNm":"[2399]기타 공학 관련 기술자 및 시험원","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002056:1', '{"dJobCd":"K000002056","dJobCdSeq":"1","dJobNm":"항로표지시험검사원","workSum":"각종 검사기구를 사용하여 항로표지 장비 및 용품의 광학적, 전기적 특성, 열환경 적응성 등을 시험·검사하고 표준규격서에 맞게 제작되었는지 평가한다.","doWork":"항로표지장비(항로표지 기능을 수행하는 장치 또는 다른 항로표지 장비·용품과 연결되어 부가기능을 수행하는 완제품 형태의 장치), 항로표지용품(항로표지 장비의 전원장치, 장비를 구성하는 부속품)의 검사신청서를 접수한다. 사용전검사, 정기검사, 변경검사, 재검사 등 검사종류별 검사기준 및 품목별 표준규격서를 확인한다. 등명기의 광속, 수직·수평 발산각, 유효광도, 등질, 색도 등 광학적 특성을 검사한다. 등명기, 충방전조절기 등의 전기적 특성을 검사한다. 침수, 더위, 추위 등의 열악한 환경에 대한 적응성을 검사한다. 치수, 형상 등이 표준규격서에 맞게 제작되었는지 검사한다. 검사규정에 따라 합격 여부를 판정한다. 합격증을 표시하고 합격증표관리대장에 기록·관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"항로표지기사","dJobECd":"1599","dJobECdNm":"[1599]기타 인쇄·목재 등 공학 기술자 및 시험원","dJobJCd":"2399","dJobJCdNm":"[2399]기타 공학 관련 기술자 및 시험원","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006414:1', '{"dJobCd":"K000006414","dJobCdSeq":"1","dJobNm":"가정의학과전문의사","workSum":"질병의 조기발견과 관리, 질병의 예방과 건강상태의 유지를 위해 환자와 그 가족에게 지속적이고 포괄적인 의료서비스를 제공한다.","doWork":"청진기, 맥박측정기, 체온계 등 의료기구 및 진단보조기구를 사용하여 환자를 검진한다. 환자의 병력에 관한 정보를 기록하고, 여러 가지 병리검사 및 X-ray촬영 등을 지시한다. 보고서 및 검사결과를 분석하여 환자의 상태를 진단하고, 치료·처방하며, 음식조절·위생관리·운동·질병예방·금연·비만 조절·스트레스 관리 등에 관하여 조언한다. 전염병과 만성질환과 관련된 예방접종을 실시한다. 환자에게 관련 전문의를 소개·추천한다. 진료하는 세부과목에 따라 건강증진과, 건강검진과, 노인의학과, 스포츠의학과, 갱년기의학과, 여행자의학과 진료를 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"조정","workFunc2":"자문","workFunc3":"정밀작업","similarNm":"가정의학과의사","certLic":"가정의학전문의","dJobECd":"3011","dJobECdNm":"[3011]전문 의사","dJobJCd":"2411","dJobJCdNm":"[2411]전문 의사","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005227:1', '{"dJobCd":"K000005227","dJobCdSeq":"1","dJobNm":"결핵과전문의사","workSum":"폐기능검사 및 객담검사 등을 통해 폐, 신장, 뼈나 관절 등에 침투하는 결핵균에 의한 질환을 진단, 치료, 예방한다.","doWork":"환자의 병력을 듣고 청진 및 이학적 검사를 시행한다. 객담검사, 임상혈액검사, 흉부 X-ray검사와 필요한 경우 기관지 내시경검사를 의뢰한다. 검사결과를 분석하여 진단하고 치료계획을 수립한다. 약물을 처방하고 투여기간이나 수술의 필요 여부를 결정한다. 치료의 경과나 약물의 부작용 등을 관찰한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"조정","workFunc2":"자문","workFunc3":"정밀작업","similarNm":"결핵과의사","certLic":"의사, 결핵과전문의","dJobECd":"3011","dJobECdNm":"[3011]전문 의사","dJobJCd":"2411","dJobJCdNm":"[2411]전문 의사","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001626:1', '{"dJobCd":"K000001626","dJobCdSeq":"1","dJobNm":"내과전문의사","workSum":"인체 내부기관의 질병 및 장애를 진단하고 치료한다.","doWork":"소화나 호흡, 신장 등 인체 내부기관에 질병이 발생하거나 선·후천적 이상증상이 있는 환자를 진단하기 위하여 진찰하고, 방사선촬영 및 혈액검사를 지시한다. 검진결과에 따라 치료를 위한 처방을 수행하며 환자의 증상에 따른 식이요법 및 생활방식 등에 관하여 조언한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"조정","workFunc2":"자문","workFunc3":"정밀작업","similarNm":"내과의사","connectJob":"감염내과전문의사, 소화기내과전문의사, 순환기내과전문의사, 내분비내과전문의사, 류마티스내과전문의사, 신장내과전문의사, 알레르기내과전문의사, 혈액종양내과전문의사, 호흡기내과전문의사","certLic":"의사, 내과전문의","dJobECd":"3011","dJobECdNm":"[3011]전문 의사","dJobJCd":"2411","dJobJCdNm":"[2411]전문 의사","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002759:1', '{"dJobCd":"K000002759","dJobCdSeq":"1","dJobNm":"마취과전문의사","workSum":"수술 전·후 환자의 안전을 위해 환자의 신체에서 발생하는 각종 징후(Vital Sign)를 점검하고 마취를 관장한다.","doWork":"대수술 시 마취전문의로 참여하여 주치의를 보조한다. 환자의 전신상태를 검사하고 환자에게 가장 안전하며 해당 수술에 적합한 마취방법을 결정한다. 수술 전날 환자의 의무기록지를 검토한 후 마취 전 처치를 한다. 필요하다고 인정되는 경우 수술 이전에 환자와 면담한다. 국부차단 또는 전신마취가 요구되는 환자에게 의료기준에 따라 적절한 수기(手技) 및 약물을 투여하고 전신상태를 관찰한다. 마취의 형태와 정도를 기록하고 마취 전·후 및 도중에 환자의 진정상태를 기록한다. 수술 후 합병증을 평가하고 처치 및 통증관리를 수행한다. 외상, 질병, 수술 후 합병증으로 인한 심폐기능부전환자의 호흡 및 심혈관계장애를 집중적으로 처치한다. 마취통증의학과 진료를 하는 경우 원인불명 또는 원인 제거가 곤란한 통증을 해소시키고 기타 말초자율신경계 이상으로 인한 질환을 치료한다. 특정 병원에 전속되지 않고 다른 의료기관의 의뢰를 받아서 순회하기도 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"조정","workFunc2":"자문","workFunc3":"정밀작업","similarNm":"마취과의사","certLic":"마취과전문의","dJobECd":"3011","dJobECdNm":"[3011]전문 의사","dJobJCd":"2411","dJobJCdNm":"[2411]전문 의사","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004492:1', '{"dJobCd":"K000004492","dJobCdSeq":"1","dJobNm":"법의학자","workSum":"의학적, 과학적 정보와 지식을 바탕으로 범죄수사에 도움을 주거나 사인과 사망경위를 밝힌다.","doWork":"병사 이외의 모든 사망(외상, 질식, 이상온도, 기압, 장애, 기아, 중독, 주산기사망, 학대아동, 정신이상, 성범죄, 돌연사 등)의 원인을 밝히기 위해 검안 또는 부검을 실시하여 사망의 종류, 사인, 사후 경과시간, 치사방법, 사용흉기, 사용독물 등을 규명한다. 혈액, 타액, 정액, 질액, 모발, 치아 및 골격 등 인체의 분비물 또는 조직을 사용하여 혈액검사(혈청형, 백혈구형), 타액형검사, 지문분류, 모발분류 및 인류학적 검사를 실시하여 개인을 식별한다. 의료사고가 일어난 경우에 질병 또는 손상과 사인과의 관계, 의료행위와 사인과의 관계를 분석하여 의료행위의 과실 유무를 판단하기도 한다. 재판에 출석하여 의학적 진술과 판단을 증언하기도 한다. 범죄와 관련된 시체의 경우에 시체 또는 현장에서 증거물을 채취하기도 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"위험내재|","workFunc1":"조정","workFunc2":"자문","workFunc3":"정밀작업","similarNm":"법의관","dJobECd":"3011","dJobECdNm":"[3011]전문 의사","dJobJCd":"2411","dJobJCdNm":"[2411]전문 의사","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006208:1', '{"dJobCd":"K000006208","dJobCdSeq":"1","dJobNm":"병리과전문의사","workSum":"질병진단을 위해 환자로부터 채취된 조직검체, 체액검체(객담, 복수, 뇨 등), 혈액검체 등을 진단하고 결과를 담당 의사에게 통보한다.","doWork":"환자로부터 채취된 조직검체(병리검사를 위한 환부의 일부분), 체액검체(객담, 복수, 뇨 등), 혈액검체 등에 대한 조직병리검사 및 세포병리검사를 시행하여 그 결과 또는 그 결과를 토대로 한 병리진단을 해당 환자의 담당 의사에게 통보한다. 검체에 대한 진단을 위해 각종 시료를 제작하는 장비, 시약 등을 점검하고 진단에 대한 정도관리를 진행한다. 조직병리와 세포병리의 진단 및 특수염색검사, 면역염색검사, 분자병리검사, 전자현미경검사, 계측병리검사 등을 시행한다. 검체 제작에 보조적인 역할을 하는 임상병리사의 활동을 지도·감독한다. 병리학, 분자유전학, 면역병리학, 초미세병리학 관련 연구를 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"조정","workFunc2":"자문","workFunc3":"정밀작업","similarNm":"병리과의사","certLic":"의사, 임상병리과전문의","dJobECd":"3011","dJobECdNm":"[3011]전문 의사","dJobJCd":"2411","dJobJCdNm":"[2411]전문 의사","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001589:1', '{"dJobCd":"K000001589","dJobCdSeq":"1","dJobNm":"비뇨기과전문의사","workSum":"남성의 비뇨기관(신장, 요관, 방광, 요도), 부신 및 남성생식기관(고환, 부고환, 정관, 전립선, 음낭과 음경) 그리고 여성의 비뇨기관, 부신의 질환을 진단하고 치료한다.","doWork":"비뇨기계나 부신에 발생하는 종양을 진단하고 치료한다. 남성 성기능장애, 불임, 여성 성기능장애, 갱년기 증후군 등 질환을 진단하고 치료한다. 비뇨기계의 선천성 기형, 야뇨증 등 질환을 진단하고 치료한다. 배뇨곤란 및 요실금 등 소변을 보는데 있어서 발생하는 질환을 진단하고 치료한다. 내시경을 이용한 각종 비뇨기질환, 특히 요로결석을 진단하고 치료한다. 남성의 전립선비대 및 전립선암 등 전립선에 발생하는 질환을 진단하고 치료한다. 비뇨기계의 각종 감염을 진단·치료하며 성병을 치료한다. 비뇨기계에 발생하는 각종 손상을 진단하고 치료한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"조정","workFunc2":"자문","workFunc3":"정밀작업","similarNm":"비뇨기과의사","certLic":"의사, 비뇨기과전문의","dJobECd":"3011","dJobECdNm":"[3011]전문 의사","dJobJCd":"2411","dJobJCdNm":"[2411]전문 의사","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004441:1', '{"dJobCd":"K000004441","dJobCdSeq":"1","dJobNm":"산부인과전문의사","workSum":"태아 출생 전후의 임산부를 관리하고 분만을 담당하며, 전 연령의 여성을 대상으로 생식기관 및 이와 관련된 모든 질환을 진단하고 치료한다.","doWork":"임산부의 산전상담, 임산부의 산전관리를 위하여 임상병리검사, 초음파검사, 양수검사 등의 자료와 태아감시장치를 사용하여 임산부와 태아의 건강상태를 평가한다. 이를 위하여 정기적 검진을 실시하며, 이상 소견 시 약물처방 또는 외과적 처치를 한다. 신생아의 분만을 담당하고 태아와 산모의 건강을 위하여 필요시 제왕절개수술이나 기타 외과수술을 실시한다. 분만 후 간격조절이나 피임 수술을 한다. 전 연령의 여성을 대상으로 생식기관, 요도기관, 직장 및 이와 관련된 제 질환을 과거력, 이학적 소견, 임상병리검사, 방사선검사 등으로 진단하고 적절한 약물처방과 병소부위의 제거를 위한 수술을 한다. 불임 여성의 원인을 찾기 위한 임상병리검사, 방사선검사 등을 하고 이의 치료를 위한 약물처방, 외과적 수술 혹은 시술 등을 수행한다. 산모와 태아 및 신생아의 건강과 분만을 돕는다. 정부기관에 출생, 사망 및 전염병발생 등을 보고한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"조정","workFunc2":"자문","workFunc3":"정밀작업","similarNm":"산부인과의사","certLic":"의사, 산부인과전문의","dJobECd":"3011","dJobECdNm":"[3011]전문 의사","dJobJCd":"2411","dJobJCdNm":"[2411]전문 의사","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001908:1', '{"dJobCd":"K000001908","dJobCdSeq":"1","dJobNm":"성형외과전문의사","workSum":"선천적 기형 혹은 외상 및 종양 등에 의해 발생하는 신체 전반의 변형을 복구하고 기능적 결손을 교정하며, 얼굴과 신체를 아름답게 하기 위해 외과적 치료 및 비외과적 시술을 한다.","doWork":"환자를 검진하여 수술의 필요성을 확인하고 수술 시 예상되는 환자의 위험정도를 고려하여 적절한 수술절차를 결정한다. 환자의 건강상태, 약물에 대한 반응 및 병력에 관한 보고서를 검토한다. 수술에 필요한 도구, 장비, 설비 등의 살균상태와 방부제 처리방법을 확인·점검한다. 고려된 최적의 방법으로 수술을 실시한다. 치료결과를 확인하고 필요하면 재치료를 검토한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"조정","workFunc2":"자문","workFunc3":"정밀작업","similarNm":"성형외과의사","certLic":"의사, 성형외과전문의","dJobECd":"3011","dJobECdNm":"[3011]전문 의사","dJobJCd":"2411","dJobJCdNm":"[2411]전문 의사","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004726:1', '{"dJobCd":"K000004726","dJobCdSeq":"1","dJobNm":"소아과전문의사","workSum":"소아의 보건 증진과 질병의 예방 및 치료를 담당한다.","doWork":"소아를 대상으로 성성숙도검사(Tanner Stage), 골연령검사, 채혈을 통한 항원검사, 각종 혈액검사, 골수검사, 뇌파검사 등 진단을 실시하여 질병의 발생 유무를 찾아내고 적절한 치료와 처방을 한다. 세부 과목에 따라 소아심장과, 소아신장과, 소아내분비과, 소아호흡기·알레르기과, 소아감염과, 소아소화기·영양과, 소아혈액·종양과, 소아신경과, 신생아과 진료를 한다. 소아의 정상적인 성장발달을 위해 예방차원의 건강계획을 수립·실시한다. 소아의 예방을 접종과 기타 다양한 관련 의료활동을 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"조정","workFunc2":"자문","workFunc3":"정밀작업","similarNm":"소아과의사","certLic":"소아과전문의","dJobECd":"3011","dJobECdNm":"[3011]전문 의사","dJobJCd":"2411","dJobJCdNm":"[2411]전문 의사","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003009:1', '{"dJobCd":"K000003009","dJobCdSeq":"1","dJobNm":"신경과전문의사","workSum":"중추신경(뇌 및 척수)과 말초신경 및 근육계통의 내과적 질환을 진단하고 치료한다.","doWork":"문진 및 신체검사, 신경학적 검사로 환자의 병소의 위치를 파악한다. 방사선검사(단순 방사선검사, 컴퓨터단층촬영, 자기공명영상)와 신경생리검사(신경전도검사, 근전도검사, 유발전위검사, 뇌파검사), 신경초음파검사(경두개초음파검사, 경동맥초음파검사) 등으로 질병의 내용을 확인한다. 신경계의 혈관질환(뇌경색, 뇌출혈), 퇴행성질환(근위축성가쪽경화증, 치매), 발작성질환(간질, 두통, 어지러움), 이상운동질환(파킨슨병, 헌팅톤병), 대사성질환(윌슨병), 말이집탈락질환(다발성경화증), 뇌종양, 말초신경 및 근육질환(길랭바레병, 중증근육무력증, 근이양증), 감염질환(뇌염, 수막염, 뇌농양, 프리온병) 등의 각 질환에 합당한 약물을 처방하거나 내과적 치료를 한다. 노인의 자연적 퇴화로 인하여 발생할 수 있는 장애에 관하여 상담하고 정상적 혹은 이와 상응하는 일상생활이 가능하도록 전신적 건강상태 점검 및 조언과 가족상담을 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"조정","workFunc2":"자문","workFunc3":"정밀작업","similarNm":"신경과의사","certLic":"의사, 신경과전문의","dJobECd":"3011","dJobECdNm":"[3011]전문 의사","dJobJCd":"2411","dJobJCdNm":"[2411]전문 의사","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006677:1', '{"dJobCd":"K000006677","dJobCdSeq":"1","dJobNm":"안과전문의사","workSum":"눈의 선천적 이상이나 안질환 및 상해를 진단하고 치료한다.","doWork":"눈의 질병이나 상해의 증상 또는 선천적인 이상을 검진한다. 시력의 손실정도를 알아보기 위해 의료기사에게 눈의 검사를 지시한다. 진단결과에 따라 약물을 처방하거나 치료한다. 필요에 따라 외과적 수술을 실시한다. 교정안경을 처방하고, 눈의 운동 등 시력회복을 위한 치료활동을 관리하고 감독한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"조정","workFunc2":"자문","workFunc3":"정밀작업","similarNm":"안과의사","certLic":"의사, 안과전문의","dJobECd":"3011","dJobECdNm":"[3011]전문 의사","dJobJCd":"2411","dJobJCdNm":"[2411]전문 의사","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003620:1', '{"dJobCd":"K000003620","dJobCdSeq":"1","dJobNm":"예방의학과전문의사","workSum":"건강을 보호, 유지, 증진하고 질병, 장애, 조기사망을 예방하기 위해 개인, 집단, 지역사회 또는 국가 수준에서 과학적 근거에 기반한 대책을 수립하고 수행한다.","doWork":"역학·통계학적 원리와 방법을 적용하여 건강수준과 건강을 결정하는 사회경제적, 행태적, 환경적, 문화적, 유전체적 요인들을 측정하고, 분석하며, 그 결과를 해석한다.  과학적 근거에 기반하여 인구집단을 중심으로 공중보건학적 문제 해결을 위한 접근전략을 계획하고 실행평가하며, 개인 수준의 건강증진을 위한 보건의료서비스와 프로그램을 적용하며 평가한다. 국민 건강에 영향을 미치는 각종 입법 및 정책수립 과정에 전문가로서 참여하며, 적절한 지도력과 의사소통을 통한 지역사회 보건사업 책임자로서의 역할을 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"자문","workFunc3":"관련없음","similarNm":"예방의학과의사","certLic":"의사, 예방의학과전문의","dJobECd":"3011","dJobECdNm":"[3011]전문 의사","dJobJCd":"2411","dJobJCdNm":"[2411]전문 의사","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002714:1', '{"dJobCd":"K000002714","dJobCdSeq":"1","dJobNm":"외과전문의사","workSum":"소화기, 두경부, 내분비, 유방 등의 장기에 대한 수술치료의 수행 및 전반적 치료계획을 수립하고 시행한다.","doWork":"환자를 검진하여 수술의 필요성을 확인하고 수술 시 예상되는 환자의 위험정도를 고려하여 적절한 수술절차를 결정한다. 환자의 건강상태, 약물에 대한 반응 및 병력에 관한 보고서를 검토한다. 수술에 필요한 도구, 장비, 설비 등의 살균상태와 방부제 처리방법을 확인·점검한다. 고려된 최적의 방법으로 수술을 실시한다. 치료결과를 확인하고 필요하면 재치료를 검토한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"조정","workFunc2":"자문","workFunc3":"정밀작업","similarNm":"외과의사","certLic":"의사, 외과전문의","dJobECd":"3011","dJobECdNm":"[3011]전문 의사","dJobJCd":"2411","dJobJCdNm":"[2411]전문 의사","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003390:1', '{"dJobCd":"K000003390","dJobCdSeq":"1","dJobNm":"응급의학과전문의사","workSum":"응급실에 방문하는 모든 환자의 진료에 직접 또는 간접적으로 참여하여 응급처치를 수행하고 환자를 안정화시키며, 필요시 해당 분야의 전문가에게 협진을 요청한다.","doWork":"응급실에 실려 온 급성 및 중증 응급환자의 증상을 진단하고 증상에 따라 심폐소생술, 중증외상소생술 등을 이용하여 최단 시간 내에 응급처치를 수행한다. 응급 혈액검사, 현장검사(Point of Care Test), CT와 MRI 등을 포함한 응급 방사선검사 등을 시행한다. 심폐소생술과 관련된 시술, 기도 유지나 호흡 부전 치료를 위한 기관 삽관술 및 다양한 기도 확보시술 등을 시행한다. 응급 처치된 환자에 대해 결과보고서를 작성한 후 추가적인 처치가 필요하다고 인정되는 경우 관련 진료과에 인계한다. 각종 소생술, 독극물 중독증, 대량재해에 대한 임상적 연구를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"조정","workFunc2":"자문","workFunc3":"정밀작업","similarNm":"응급의학과의사","connectJob":"응급실의사","certLic":"의사, 응급의학과전문의","dJobECd":"3011","dJobECdNm":"[3011]전문 의사","dJobJCd":"2411","dJobJCdNm":"[2411]전문 의사","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002815:1', '{"dJobCd":"K000002815","dJobCdSeq":"1","dJobNm":"이비인후과전문의사","workSum":"귀, 코, 목의 질병을 진료하여 적절한 치료를 한다.","doWork":"음향측정기, 프리즘, 비경(Nose Scope), X선 투시기, X-ray 등 관련 의료장비를 사용하여 귀, 코, 목 등 관련 신체기관을 검사한다. 순음청력검사, 자발 안진, 주시 안진, 두위 안진, 전기성문도검사, 비강도검사, 후각검사, 미각검사 등을 시행한다. 질병의 진행상태에 따라 전이개 누공 절제술, 고막 절개술 및 환기관 삽입술, 등자골 수술, 유양동 절제술, 안면신경 연결술 등의 외과수술을 하거나 약물을 처방·치료한다. 청각기관의 손실이나 기타 상해에 의한 청각의 손실정도 또는 후두의 질병 및 손상으로 인한 언어의 손실정도를 알아보기 위하여 제반 검사를 지시한다. 검사결과에 따라 적절한 치료방법을 강구한다. 진료하는 세부과목에 따라 이과, 비과, 두경부외과 진료를 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"조정","workFunc2":"자문","workFunc3":"정밀작업","similarNm":"이비인후과의사","certLic":"의사, 이비인후과전문의","dJobECd":"3011","dJobECdNm":"[3011]전문 의사","dJobJCd":"2411","dJobJCdNm":"[2411]전문 의사","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003303:1', '{"dJobCd":"K000003303","dJobCdSeq":"1","dJobNm":"재활의학과전문의사","workSum":"질병과 손상에 의해 신체적, 정신적 및 사회적 기능이 저하된 사람을 대상으로 기능을 최대한 향상시켜 삶의 질을 도모하기 위한, 적절한 진단, 평가 및 치료를 시행한다.","doWork":"신경 병변(뇌졸중 및 뇌손상, 척수손상, 근육병, 뇌성마비, 치매 외), 근골격계 병변 및 통증 질환(척추, 관절, 스포츠 손상), 발달장애 및 노화, 암과 심폐질환 등으로 기능이 저하된 환자를 대상으로 다양한 검사, 평가를 시행하여 포괄적 재활치료 계획 수립을 하고, 재활치료 및 교육한다. 물리·작업치료사, 간호사, 의지보조기기사, 사회복지사, 언어재활사 등으로 구성된 다학제 재활팀의 회의를 주관한다. 처치기술, 장비사용 및 치료방법 등을 직원들에게 숙달시키기 위해 재활의료 인력을 교육한다. 재활치료의 근거 향상을 위한 연구계획을 조정하고 지역사회 교육기관 및 기업체의 재활자문 역할을 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"조정","workFunc2":"자문","workFunc3":"관련없음","similarNm":"재활의학과의사","certLic":"의사, 재활의학과전문의","dJobECd":"3011","dJobECdNm":"[3011]전문 의사","dJobJCd":"2411","dJobJCdNm":"[2411]전문 의사","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005166:1', '{"dJobCd":"K000005166","dJobCdSeq":"1","dJobNm":"정신건강의학전문의사","workSum":"인간의 스트레스 관련 질환 및 사고장애, 정서장애, 행동장애를 예방, 진단, 치료하고 재활을 돕는다.","doWork":"정신 장애와 스트레스와 연관된 다양한 신체 질환에 대한 예방적 접근을 한다. 환자와의 정신과적 면담, 정신상태 검사, 다양한 심리검사 및 뇌기능 검사를 비롯한 여러 진단검사 자료를 이용하여 스트레스 관련 질환 및 정신 장애의 내용과 정도를 진단한다. 치료계획을 수립하여 약물을 포함한 각종 생물학적 치료, 정신치료, 인지-행동치료, 가족 및 부부치료, 환경치료 등을 수행한다. 직업 재활 등의 다양한 재활 치료를 하고, 지역사회의 정신보건사업을 담당한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"자문","workFunc3":"관련없음","similarNm":"정신과의사","certLic":"의사, 정신과전문의","dJobECd":"3011","dJobECdNm":"[3011]전문 의사","dJobJCd":"2411","dJobJCdNm":"[2411]전문 의사","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002818:1', '{"dJobCd":"K000002818","dJobCdSeq":"1","dJobNm":"정형외과전문의사","workSum":"사지, 척추, 관절 및 이에 부수되는 연부조직의 이상, 기질성질환, 선천성기형, 골절 등을 진료한다.","doWork":"환자와 대면하여 문진, 촉진, 시진 등의 방법으로 간단한 진찰을 하고 X선 촬영, 자기공명영상(MRI), 컴퓨터 단층촬영(CT), 초음파검사, 방사선촬영, 혈액검사, 신경검사 등을 지시하여 진단한다. 투약이나 물리치료를 지시하고 골절환자에 대하여 견인법, 석고붕대법 등을 사용한 보존적 처치를 지시한다. 외과적 수술계획을 수립·실시한다. 인공관절 수술, 골절정복술 및 고정술, 인대 복원술 및 재건술, 관절경 수술, 척추 수술, 근골격계 수술을 한다. 진료하는 세부과목에 따라 소아정형외과, 척추외과, 수부외과, 족부외과, 견주관절외과, 슬관절외과, 고관절외과, 근골격계 종양외과 진료를 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"조정","workFunc2":"자문","workFunc3":"정밀작업","similarNm":"정형외과의사","certLic":"의사, 정형외과전문의","dJobECd":"3011","dJobECdNm":"[3011]전문 의사","dJobJCd":"2411","dJobJCdNm":"[2411]전문 의사","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001296:1', '{"dJobCd":"K000001296","dJobCdSeq":"1","dJobNm":"직업환경의학과전문의사","workSum":"산업체 근로자들의 직업성 질환과 일반환경 요인에 의해 발생하는 환경성 질환을 진단, 치료하며 관련 질환발생의 예방대책을 연구하고 조언한다.","doWork":"직업성 또는 환경성 질환자의 치료계획을 수립하고 시행한다. 채용 시 또는 근무 중 및 배치전환 등에 필요한 근로자의 건강진단을 수행하여 건강수준을 평가하고 직업병 여부를 판정한다. 유해물질에 노출될 가능성이 높은 작업장의 근로자나 일반인들에게 유해물질 및 보호구 사용 및 관리방법, 노출 시 응급처치 등을 교육한다. 사업장의 작업환경측정을 관장하며 사업장 위생상태를 총괄적으로 점검한다. 사업주 및 근로자들에게 작업수행 시 유의할 사항을 교육하고 근로자의 건강상담을 실시한다. 근로자의 장애수준을 평가하여 작업조정계획을 세워 경영진에 조언한다. 산업체 근로자들을 대상으로 정기예방접종을 실시하거나 관련 통계를 작성한다. 산업재해 보상의 업무관련성과 환경성질환의 유해환경 기여수준을 평가한다. 직업성 질환, 환경성 질환, 산업보건, 그리고 환경보건에 관한 연구를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"조정","workFunc2":"자문","workFunc3":"정밀작업","similarNm":"산업의학과의사","certLic":"산업의학전문의","dJobECd":"3011","dJobECdNm":"[3011]전문 의사","dJobJCd":"2411","dJobJCdNm":"[2411]전문 의사","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002165:1', '{"dJobCd":"K000002165","dJobCdSeq":"1","dJobNm":"진단방사선과전문의사","workSum":"X-ray, 특수조영술(인체 전 영역에서 조영제를 사용하여 X선 형광촬영으로 장기의 구조, 기능적 이상을 진단함), 초음파, 전산화단층촬영, 자기공명영상, 방사선동위원소, 중재적 치료술 등을 이용하여 환자의 질병을 진단하고 치료한다.","doWork":"인체 내부기관의 구조·기능 및 병리적 변화를 다양한 영상 검사법을 이용하여 종합·분석하여 진단한다. 검사하려는 내부기관이 검사종류에 따라 강조될 수 있도록 각종 조영제를 환자에게 먹이거나 주사한다. 방사선사에게 X-ray촬영, 전산화단층촬영, 자기공명영상, 방사선동위원소 촬영법을 지도하고 촬영을 지시하며 발생된 영상을 필름 또는 영상정보시스템(PACS:Picture Archiving and Communication System)을 이용하여 판독진단한다. 인체 내부기관의 구조, 기능에 관한 병리적 변화를 진단하기 위하여 각종 특수조영술 및 초음파검사를 한다. 각종 영상장비를 이용하여 병변의 생검을 시행한다. 다양한 도관 및 치료제를 이용하여 출혈, 혈관이상, 암조직의 혈류에 대해 중재적 치료를 하며, 각종 위장관 및 담도계에 대한 중재적 치료를 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"조정","workFunc2":"자문","workFunc3":"정밀작업","similarNm":"진단방사선과의사, 영상진단의학과의사","certLic":"의사, 진단방사선과전문의","dJobECd":"3011","dJobECdNm":"[3011]전문 의사","dJobJCd":"2411","dJobJCdNm":"[2411]전문 의사","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007084:1', '{"dJobCd":"K000007084","dJobCdSeq":"1","dJobNm":"치료방사선과전문의사","workSum":"방사선을 이용하여 각종 종양 및 관련 질환을 치료한다.","doWork":"임상의사들과 협의하여 악성종양 환자를 진단하고, 질병의 경과를 특징에 따라 구분하여 치료계획을 세운다. 환자에게 방사선을 방사하기 위하여 시뮬레이터(Simulator) 등을 이용하여 방사량, 방사시간, 방사범위를 설정하고 기계의 선정, 방사기술 등을 계획·관리한다. 3차원 입체조형 방사선 치료, 영상 유도 방사선 치료, 입자 치료, 관 내 치료, 조직 내 치료, 접촉 치료(직장암이나 항문암 등에서 저에너지 방사선 발생 장치를 종양에 직접 접촉시켜 치료하는 방법)로 양성 및 악성종양을 치료한다. 방사선조사 후 방사선 추적조사를 실시하여 종양의 진행과정을 관찰하고 적절한 치료를 받을 수 있도록 조치한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"조정","workFunc2":"자문","workFunc3":"정밀작업","similarNm":"치료방사선과의사, 방사선종양과의사, 진단방사선과의사, 영상의학과의사","certLic":"의사, 진단방사선과전문의, 방사성동위원소취급자특수면허","dJobECd":"3011","dJobECdNm":"[3011]전문 의사","dJobJCd":"2411","dJobJCdNm":"[2411]전문 의사","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001889:1', '{"dJobCd":"K000001889","dJobCdSeq":"1","dJobNm":"피부과전문의사","workSum":"피부 건강과 피부에 발생한 각종 질병을 진단하고 치료한다.","doWork":"건강한 피부를 유지하기 위한 여러 가지 검사 및 시술을 시행하며 피부의 질병을 판단하기 위하여 조직검사와 여러 가지 화학적·생물학적 분석검사를 지시한다. 검사결과에 따라 약물치료나 자외선치료 및 국소치료 등을 진단하고 처방한다. 종양, 감염에 의한 피부질환 및 기타 피부병 등을 치료하고 그 밖의 외과적 악성피부질환, 사마귀, 낭종 또는 기타 피부에 불필요한 요소 등을 수술한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"조정","workFunc2":"자문","workFunc3":"정밀작업","similarNm":"피부과의사","certLic":"의사, 피부과전문의","dJobECd":"3011","dJobECdNm":"[3011]전문 의사","dJobJCd":"2411","dJobJCdNm":"[2411]전문 의사","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005097:1', '{"dJobCd":"K000005097","dJobCdSeq":"1","dJobNm":"해부병리과전문의사","workSum":"조직검사 또는 세포검사를 통하여 질병의 원인, 장기나 조직의 변화, 사인 등을 진단·규명한다.","doWork":"환자로부터 채취된 조직절편이나 체액을 포르말린이나 알코올 등 고정액으로 처리하여 변질을 최소화한다. 포매, 박절, 염색 등의 작업을 거쳐 조직검사 또는 세포검사용 표본을 제작하거나 제작을 지시한다. 조직에서 직접 천자를 시행하고 염색작업을 지시하며 진단을 내려 수술 및 치료결정을 돕는다. 현미경 또는 전자현미경 등의 장비를 이용하여 질병에 의한 조직의 변화와 그 범위 및 정도 등을 검사·판독한다. 수술 중 응급진단이 필요할 때 생체를 채취하고 동결절편기를 이용하여 슬라이드 표본이나 동결절편을 제작하며 광학현미경을 이용하여 종양의 악성 및 양성 여부를 진단·판정한다. 각종 암 및 양성종양, 감염, 염증, 퇴행성병변에 대하여 진료하며 외과병리검사, 세포병리검사, 면역병리검사, 분자병리검사, 전자현미경검사, 부검, 미분화 종양의 감별 진단, 전이성 종양의 기원장기 추정, 림프종과 백혈병의 진단을 한다. 임상의사의 요청에 따라 임상자문을 제공한다. 진단하고 남은 환자의 조직을 보관하고 신약 개발사업에 이용하기도 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"조정","workFunc2":"자문","workFunc3":"정밀작업","similarNm":"해부병리과의사","certLic":"의사, 해부병리과전문의","dJobECd":"3011","dJobECdNm":"[3011]전문 의사","dJobJCd":"2411","dJobJCdNm":"[2411]전문 의사","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006624:1', '{"dJobCd":"K000006624","dJobCdSeq":"1","dJobNm":"핵의학과전문의사","workSum":"방사성 및 안정 핵종 또는 방사성의약품을 의학적으로 이용하여 환자들을 진단하고 치료한다.","doWork":"방사성 및 안정 핵종 또는 방사성의약품의 특성을 이용한 영상검사를 통해 종양, 심장질환, 뇌혈관질환 등을 비롯한 각종 질환을 진단한다. 체외검사를 통해 혈액 및 체액 내 각종 바이러스, 호르몬, 종양 등의 존재 여부를 검사한다. 생물학적 검사를 통해 세균 또는 세포의 활성을 검사한다. 치료가 필요하다고 인정되는 환자의 경우 개봉된 방사성핵종을 이용해서 치료한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"조정","workFunc2":"자문","workFunc3":"정밀작업","similarNm":"핵의학과의사","certLic":"의사, 핵의학과전문의","dJobECd":"3011","dJobECdNm":"[3011]전문 의사","dJobJCd":"2411","dJobJCdNm":"[2411]전문 의사","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004902:1', '{"dJobCd":"K000004902","dJobCdSeq":"1","dJobNm":"흉부외과전문의사","workSum":"심장 및 혈관, 폐 및 식도의 질환을 진단하고 외과적 치료 및 수술을 수행한다.","doWork":"환자를 진찰하고 적절한 영상 및 임상병리검사를 통해 심장 및 혈관, 폐, 식도, 횡경막, 흉벽 등 흉부에 발생하는 외과적 질환의 여부 및 정도를 진단한다. 치료계획을 수립하고 외과적 수술을 실시한다. 타 진료과로부터 수술을 의뢰받았을 경우 담당 의사와 협의하여 수술방법, 일정 등을 논의한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"조정","workFunc2":"자문","workFunc3":"정밀작업","similarNm":"흉부외과의사","certLic":"의사, 흉부외과전문의","dJobECd":"3011","dJobECdNm":"[3011]전문 의사","dJobJCd":"2411","dJobJCdNm":"[2411]전문 의사","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007148:1', '{"dJobCd":"K000007148","dJobCdSeq":"1","dJobNm":"공중보건의사","workSum":"지역사회 주민건강의 보호·증진을 위하여 환자를 진료하고 전염병 예방, 공중보건위생 등 공공의료 업무를 수행한다.","doWork":"오지, 농어촌 의료취약지역, 보건소 및 보건지소, 기타 공공의료시설에서 환자를 진료한다. 전염병 예방을 위하여 개인, 가정 및 전염지역의 격리 또는 오염제거를 지시한다. 환경 및 공중 보건위생을 위한 제반 의학적 조치를 실시하고 개선을 조언한다. 주민들의 건강상담을 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"조정","workFunc2":"자문","workFunc3":"정밀작업","certLic":"의사, 치과의사, 한의사","dJobECd":"3012","dJobECdNm":"[3012]일반 의사","dJobJCd":"2412","dJobJCdNm":"[2412]일반 의사","dJobICd":"Q863","dJobICdNm":"[Q863]공중 보건 의료업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006210:1', '{"dJobCd":"K000006210","dJobCdSeq":"1","dJobNm":"보건진료전담공무원","workSum":"의사가 없는 농·어촌 등 의료취약 지역의 보건진료소에서 주민들을 진료하고 기타 일차보건 의료업무를 수행한다.","doWork":"청진기, 맥박기록기 등 간단한 의료기구를 사용하여 환자의 부상 또는 질병상태를 진찰하고 치료하며 의약을 투여한다. 응급환자에 대한 응급처치를 한다. 질병이나 부상의 악화방지를 위한 처치를 하거나 만성병 환자의 요양을 지도·관리한다. 임산부의 분만을 돕고 전염병 예방접종을 실시한다. 환경위생, 영양개선, 가족계획 등 공중보건에 관해 주민들을 지도·상담한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"분석","workFunc2":"교육","workFunc3":"수동조작","similarNm":"보건진료원","certLic":"간호사","dJobECd":"3012","dJobECdNm":"[3012]일반 의사","dJobJCd":"2412","dJobJCdNm":"[2412]일반 의사","dJobICd":"Q863","dJobICdNm":"[Q863]공중 보건 의료업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002329:1', '{"dJobCd":"K000002329","dJobCdSeq":"1","dJobNm":"의무원","workSum":"선수관리위원의 지시에 따라 경주에 출장하는 선수의 건강상태에 대해 검사하고 경주출전 적격 여부를 판단한다.","doWork":"출주선수 및 선두유도원의 출전 적격 여부를 판단하기 위하여 외과검사, 내과검사, 안과검사, 이비인후과검사를 실시하고 적격 여부를 판단하여 관련 부서에 통보한다. 신체검사 합격기준에 적합하지 않는 경우라도 경주에 지장이 없다고 인정되는 때에는 합격으로 한다. 선수관리위원의 관리업무에 자문역할을 담당한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"조정","workFunc2":"자문","workFunc3":"정밀작업","certLic":"응급구조사","dJobECd":"3012","dJobECdNm":"[3012]일반 의사","dJobJCd":"2412","dJobJCdNm":"[2412]일반 의사","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007504:1', '{"dJobCd":"K000007504","dJobCdSeq":"1","dJobNm":"일반의사","workSum":"의료 부분의 일반적인 질환, 장애, 상해 및 질병을 진료·예방한다.","doWork":"청진기, 맥박기록기 등 간단한 의료기구를 사용하여 환자를 진찰한다. 환자의 증상에 따른 다양한 검사와 진단을 통해 치료방법 및 치료순서를 결정한다. 환자의 진단을 위하여 방사선사, 임상병리사 등의 의료기사에게 X-ray촬영, 임상검사 등을 지시한다. 검사결과를 분석하여 환자의 상태를 진단하고 치료법을 설명하거나 약물을 처방한다. 전염병 예방접종을 실시한다. 환자에게 식사, 위생, 질병예방 등에 관하여 조언한다. 병원이나 진료소에 직접 나올 수 없는 환자를 위하여 왕진을 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"조정","workFunc2":"자문","workFunc3":"정밀작업","certLic":"의사","dJobECd":"3012","dJobECdNm":"[3012]일반 의사","dJobJCd":"2412","dJobJCdNm":"[2412]일반 의사","dJobICd":"Q862","dJobICdNm":"[Q862]의원","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007542:1', '{"dJobCd":"K000007542","dJobCdSeq":"1","dJobNm":"한의사","workSum":"한방 의료의 원리를 이용해 인체의 질병 및 장애를 파악하고, 다양한 한방치료법을 이용하여 진료한다.","doWork":"환자의 상태를 망진(외관), 문진(대화), 문진(청각), 절진(진맥)을 통해서 진단한다. 질병의 종류와 성격을 고려하여 침, 뜸, 부항, 탕약, 수기요법 등의 치료법을 사용하여 치료한다. 환자에게 양생(스트레스 조절)과 섭생(영양공급)에 대해 조언을 한다. 환자에게 한약재를 처방해준다. 환자의 척추나 경혈부위 등을 손이나 기계를 이용하여 치료한다. 냉온팩을 이용한 찜질 및 다양한 기계를 사용한 물리치료를 지시한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"조정","workFunc2":"자문","workFunc3":"정밀작업","connectJob":"침구과전문의사, 한방내과전문의사, 한방부인과전문의사, 사상체질과전문의사, 한방소아과전문의사, 한방신경정신과전문의사, 한방재활의학과전문의사, 한방안·이비인후과·피부과전문의사","certLic":"한의사","dJobECd":"3013","dJobECdNm":"[3013]한의사","dJobJCd":"2413","dJobJCdNm":"[2413]한의사","dJobICd":"Q862","dJobICdNm":"[Q862]의원","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007472:1', '{"dJobCd":"K000007472","dJobCdSeq":"1","dJobNm":"치과의사","workSum":"구강과 치아의 질병을 진단하고 각종 기구를 이용하여 외과적 수술 및 약물치료를 실시한다.","doWork":"환자와의 상담을 통해 증상을 파악한다. 치아 및 구강 내의 상태를 각종 검사를 통해 진단한다. 진단결과를 환자에게 설명하고 치료계획을 세운다. 치석을 제거하고 시린 치아나 충치를 치료하고 발치한다. 잇몸의 염증을 제거하고 신경치료를 한다. 발치 후 인공치아를 이식한다. 미용 및 구강구조의 보호를 위하여 보철물을 구강 내에 설치한다. 환자에게 치아보존법 및 구강건강에 대하여 조언한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"조정","workFunc2":"자문","workFunc3":"정밀작업","connectJob":"구강악안면외과전문의사, 구강내과(구강진단과)전문의사, 치과교정과전문의사, 치과보철과전문의사, 소아치과전문의사, 치주과전문의사, 치과보존과전문의사, 예방치과전문의사, 구강병리과전문의사, 영상치의학과전문의사","certLic":"치과의사전문의","dJobECd":"3014","dJobECdNm":"[3014]치과 의사","dJobJCd":"2414","dJobJCdNm":"[2414]치과 의사","dJobICd":"Q862","dJobICdNm":"[Q862]의원","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001651:1', '{"dJobCd":"K000001651","dJobCdSeq":"1","dJobNm":"가축방역관","workSum":"가축의 전염성 질병이 발생하거나 전염되는 것을 방지하는 일을 한다.","doWork":"가축전염병 예방을 위하여 가축사육시설(축사, 부화장, 종축장 등), 작업장(도축장, 집유장 등), 창고, 차량 등에서 가축질병 예찰에 필요한 시료를 채취하고 관계자를 면담하여 방역을 지도한다. 죽거나 병든 가축에 대하여 병성감정을 실시하여 가축전염병의 발생상황, 예방주사에 따른 면역형성에 대하여 조사한다. 가축거래기록 및 검사증명서가 휴대되는지, 축산 관련 사업장에 소독설비 및 출입차량에 대한 소독이 이루어졌는지, 가축전염병이 퍼지는 것을 막기 위한 해당 가축의 격리와 가축사육시설의 폐쇄 및 살처분 조치가 이행되었는지, 가축의 사체와 오염물건 처리 등의 조치 및 발굴의 금지가 이행되었는지, 축사·선박·자동차·항공기 등의 소독실시가 이행되었는지 확인한다. 살처분, 소각, 매몰, 소독 등에 대하여 보상금을 평가한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workEnv":"대기환경미흡|","workFunc1":"분석","workFunc2":"자문","workFunc3":"정밀작업","certLic":"수의사","dJobECd":"3020","dJobECdNm":"[3020]수의사","dJobJCd":"2415","dJobJCdNm":"[2415]수의사","dJobICd":"A014","dJobICdNm":"[A014]작물재배 및 축산 관련 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006431:1', '{"dJobCd":"K000006431","dJobCdSeq":"1","dJobNm":"가축방역행정전문가","workSum":"국내에 발병되거나 발병 가능성이 있는 법정가축전염병의 예방 및 확산방지를 위해 계획을 수립하고 시행한다.","doWork":"법정가축전염병(구제역, 광우병, 브루셀라 등 법률로 지정된 가축의 전염병)의 발병을 조기에 발견하기 위해 모니터링 체계를 구축한다. 발병예방을 위해 정기적인 소독 및 백신접종을 위한 사업을 기획 및 시행한다. 전염병 발생 시 긴급방역조치를 시행한다. 시·도 담당자들에게 방역단계에 따른 행동을 지시하고 감독한다. 방역활동을 위한 제도를 마련한다. 관련 예산을 확보한다. 예방법 및 발병 시 대처법에 대한 교육을 실시한다. 각종 교육자료를 작성한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","certLic":"수의사","dJobECd":"3020","dJobECdNm":"[3020]수의사","dJobJCd":"2415","dJobJCdNm":"[2415]수의사","dJobICd":"O842","dJobICdNm":"[O842]사회 및 산업정책 행정","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001442:1', '{"dJobCd":"K000001442","dJobCdSeq":"1","dJobNm":"경마수의위원","workSum":"경마에 출주하는 마필을 검사하고, 경주 시 다친 마필을 응급처치하고 진료 및 수술한다.","doWork":"마필이 경주에 참가할 수 있는 조건에 부합되는지 판단하기 위해 마필의 체혈, 체뇨검사 등 마체검사를 실시한다. 장안소에서 경주 전후에 출주마의 건강상태를 점검하고 체중을 비교하여 컴퓨터에 입력한다. 경주 시 응급상황에 대비하여 경마장에서 대기한다. 진료의뢰가 들어온 마필을 X-ray, 초음파, 내시경 등을 이용하여 검진한다. 호흡기, 운동기 질환 등 심각한 질환이 있는 마필은 수술한다. 경주마에 대해 연구하고, 마필 보건관리를 위해 위생·방역·검역·마사소독 등을 실시·감독한다. 약품을 수급한다. 마필의 교배 및 출산과 관련하여 업무를 지원하기도 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"웅크림|손사용|시각|","workFunc1":"조정","workFunc2":"자문","workFunc3":"정밀작업","certLic":"수의사","dJobECd":"3020","dJobECdNm":"[3020]수의사","dJobJCd":"2415","dJobJCdNm":"[2415]수의사","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002620:1', '{"dJobCd":"K000002620","dJobCdSeq":"1","dJobNm":"경마약물검사원","workSum":"경주에 출주하는 마필의 약물 투입 여부를 조사하기 위하여 마필의 혈액이나 뇨 등을 각종 장비를 이용하여 이화학검사를 실시한다.","doWork":"마필의 도핑검사를 위해 채취된 마필의 혈액, 뇨 등의 시료를 질량분석기, 면역약물분석기 등의 각종 분석장비를 이용하여 경주 전후에 검사한다. 검사결과를 경마수의위원에게 통보한다. 치료용으로 투여한 마필의 약물 잔존 여부를 파악하기 위해 검사를 실시하고, 조교사 및 마필관리원에게 결과를 통보한다. 혈통 관리를 위한 유전자검사를 시행한다. 새로운 검사법, 금지약물 등을 개발한다. 생체투여실험 및 약물과 관련하여 연구한다. 약품 및 분석장비를 관리·점검한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workEnv":"대기환경미흡|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"3020","dJobECdNm":"[3020]수의사","dJobJCd":"2415","dJobJCdNm":"[2415]수의사","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002026:1', '{"dJobCd":"K000002026","dJobCdSeq":"1","dJobNm":"물고기치료사","workSum":"수족관을 경영하고 물고기 사육에 대한 전문 지식과 각종 정보를 제공하며 각종 관상용 물고기를 치료하고 판매한다.","doWork":"적당한 크기와 모양의 수조를 선택하여 여과장치, 온도계, 조명장치 등을 설치한다. 모래와 자갈을 채우고 수초를 심고 물을 채우고 필요한 약품을 첨가하여 수질을 조절한다. 어종(魚種)에 따라 수질과 수온을 조절하고 적합한 먹이를 준다. 질병과 상처를 탐지하기 위하여 물고기를 관찰하고 병에 걸린 물고기를 격리시키고 필요한 치료를 한다. 관상어를 증식시키기 위하여 어미의 산란과 치어(稚魚:사료를 스스로 섭취할 수 있을 정도의 어린 물고기)의 부화를 조장·촉진하고 부화된 치어를 돌본다. 전시·판매할 관상어를 구입하기 위하여 양어장관계자와 협의한다. 고객의 수조 및 어종(魚種) 선택을 조언하고 사육방법을 지도한다. 고객의 수조를 청소하고 병든 관상어를 치료해준다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"고온|","workFunc1":"수집","workFunc2":"자문","workFunc3":"정밀작업","similarNm":"수산질병관리사","certLic":"수산질병관리사","dJobECd":"3020","dJobECdNm":"[3020]수의사","dJobJCd":"2415","dJobJCdNm":"[2415]수의사","dJobICd":"M731","dJobICdNm":"[M731]수의업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003431:1', '{"dJobCd":"K000003431","dJobCdSeq":"1","dJobNm":"수의사(일반)","workSum":"동물의 진단과 치료에서부터 동물약품개발, 가축품종개량연구, 축산물 검역과 방역, 수의학연구 등의 업무를 수행한다.","doWork":"동물 내·외부기관의 질병, 장애 및 상처를 검사, 진단, 치료하고 수술한다. 동물의 분만을 돕는다. 축산농가의 철저한 위생관리를 통해 질병을 예방하고 폐사되는 일이 없도록 방역업무를 한다. 이와 관련하여 교육을 실시하고 검사를 수행하며 돼지 콜레라 및 광견병 등과 같은 전염병에 대한 예방접종을 실시한다. 동물의 시체를 검사하여 사인을 규명하거나 수·출입 되는 가축물과 고기, 계란, 우유, 어패류 등의 안전성을 검사하고 판정한다. 동물보호 및 사육에 관하여 조언한다. 가축의 품종개량 등에 대해 연구하고 개발한다. 동물을 매개체로 인간에게 전염되는 질병에 관해 연구하고 예방 및 치료에 필요한 약품을 연구하고 개발한다. 경마, 승마용 말을 대상으로 약품테스트나 신체검사를 수행하며, 다친 말을 치료한다. 동물원과 야생환경에서 생활하는 야생동물을 관리하고 치료한다. 검역과 방역에 대한 대책을 수립하고 시행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"손사용|시각|","workFunc1":"조정","workFunc2":"자문","workFunc3":"정밀작업","certLic":"수의사","dJobECd":"3020","dJobECdNm":"[3020]수의사","dJobJCd":"2415","dJobJCdNm":"[2415]수의사","dJobICd":"M731","dJobICdNm":"[M731]수의업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001337:1', '{"dJobCd":"K000001337","dJobCdSeq":"1","dJobNm":"임상수의사","workSum":"개, 고양이, 소, 말 등 동물의 질병과 상해를 진단하고 치료한다.","doWork":"질병의 원인을 파악하고 적정한 치료계획을 수립하기 위하여 동물을 진단한다. 고객이나 관계자에게 질문하거나 자료의 검토를 통하여 동물의 기존 병력을 파악한다. 정확한 진단을 위해 X-ray, 초음파기, 혈액검사기 등을 사용하여 검사한다. 병에 따라 약물을 처방하고 필요하면 외과수술을 집도한다. 치료경과를 관찰한다. 동물의 분만을 돕는다. 각종 예방접종을 실시한다. 진료와 관련된 약품과 물품, 장비 등을 관리한다. 동물의 빠른 회복과 질병예방을 위해 동물의 사육과 관리방법 등에 대해 조언한다. 목장이나 동물사육장 등에 직접 방문하여 치료하기도 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"손사용|시각|","workFunc1":"조정","workFunc2":"자문","workFunc3":"정밀작업","connectJob":"대동물임상수의사(소·말), 소동물임상수의사(개·고양이 등), 산업동물임상수의사(닭·돼지), 어류임상수의사, 특수동물임상수의사(야생동물 등)","certLic":"수의사","dJobECd":"3020","dJobECdNm":"[3020]수의사","dJobJCd":"2415","dJobJCdNm":"[2415]수의사","dJobICd":"M731","dJobICdNm":"[M731]수의업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003648:1', '{"dJobCd":"K000003648","dJobCdSeq":"1","dJobNm":"병원약사","workSum":"병원에서 입원환자와 외래환자를 위해 의사의 처방에 따라 약을 조제한다.","doWork":"외래환자 중 의약분업 예외 환자와 입원환자를 대상으로 처방약물에 대한 약물상호작용, 용법·용량의 적정성 여부 등을 검토하고 처방에 따라 약을 조제한다. 환자들이 유효하고도 안전하게 약물 치료를 받도록 의약품명, 약효, 사용방법, 약용량 등 복약에 관한 사항을 지도한다. 고영양수액요법환자, 임상약동학대상환자, 항응고약물치료환자, 신장질환자, 호흡기질환자, 이식환자, 암환자, 중환자 등에 대해서 임상약제업무를 수행한다. 신약 및 의약품에 관련된 각종 정보를 의료진에게 제공한다. 약물 이상반응을 모니터링한다. 항암제, 고영양수액제 등 주사제를 무균조제한다. 병원약국 제제를 만든다. 의약품 등을 구매하고 재고를 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"자문","workFunc3":"정밀작업","similarNm":"임상약사","certLic":"약사","dJobECd":"3030","dJobECdNm":"[3030]약사 및 한약사","dJobJCd":"2420","dJobJCdNm":"[2420]약사 및 한약사","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003612:1', '{"dJobCd":"K000003612","dJobCdSeq":"1","dJobNm":"약국약사","workSum":"약국에서 의사의 처방전 또는 기존의 공인된 처방에 따라 약을 조제하고 판매한다.","doWork":"고객의 처방전을 확인하여 의사의 진단과 처방이 정확한지 확인한다. 처방전에 따라 지시된 약 및 약물의 무게와 양을 측정·혼합하여 조제한다. 고객에게 조제된 약과 관련 약품에 대해 설명하고, 복용방법, 저장법, 주의사항, 부작용과 대처방안 등을 상세히 설명한다. 변질이 우려되는 의약품은 냉동이나 기타 방법으로 저장, 보관, 관리한다. 의약품의 재고를 파악하여 부족한 양을 주문한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"정밀작업","certLic":"약사","dJobECd":"3030","dJobECdNm":"[3030]약사 및 한약사","dJobJCd":"2420","dJobJCdNm":"[2420]약사 및 한약사","dJobICd":"G478","dJobICdNm":"[G478]기타 상품 전문 소매업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006857:1', '{"dJobCd":"K000006857","dJobCdSeq":"1","dJobNm":"약물감시전문가","workSum":"임상시험을 포함한 시판 전후 의약품의 부작용, 약품의 오용, 효과부족, 임신정보 등을 모니터링하고 조사하고 보고서로 작성하여 관계기관에 보고한다.","doWork":"ICH(국제의약품규제조화위원회) 및 GVP(우수 약물관리 기준) 가이드라인을 숙지하고 임상시험 성적서 및 비임상시험자료 검토 등을 통해 약품감시문서(안전관리계획 SMP, 안전성 최신보고 DSUR, 위해성 관리계획 RMP, 유익성-위해성 평가보고 PBRER 등)를 작성·검토·갱신·보관한다. 안전성 관리와 계획에 대해 관련 기관과 협의하고 정기적으로 약품감시문서를 작성하여 KIDS(한국의약품안전관리원)나 식품의약품안전처에 제출한다. 가이드라인에 따라 PMS SOP(Standard Operating Procedure)를 개발하고 개정한다. 국내외 안정성 정보를 수집하고 분석한다. 시판 후 및 임상시험 중에 일어나는 부작용, 약품의 오용, 효과부족, 임신정보 등을 모니터링하고 조사한다. 회사 내 안전성 정보 관련 문서를 검토하고 직원들에게 유해사례 등 약품감시에 관한 교육을 한다. 안전성 정보 관련 위기 발생 시 회사 및 식약처 등 관계기관과 소통·대처한다. 시판 후 안전성 정보를 수집하기 위한 관찰 연구의 전 과정을 책임지기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"LSO(Local Safety Officer), ASR(Affiliate Safety Affair)","connectJob":"PV(Pharmacovigilance)전문가, PMS(Post-Market Surveillance)전문가","certLic":"약사, 간호사","dJobECd":"3030","dJobECdNm":"[3030]약사 및 한약사","dJobJCd":"2420","dJobJCdNm":"[2420]약사 및 한약사","dJobICd":"C212","dJobICdNm":"[C212]의약품 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006218:1', '{"dJobCd":"K000006218","dJobCdSeq":"1","dJobNm":"의약품부작용피해구제조사자","workSum":"의약품 부작용 피해조사를 수행하고 조사결과를 토대로 인과관계를 분석하며 피해구제 보상금을 산정한다.","doWork":"의무기록, 부검기록 등 유관 자료를 요청하고 수집된 의무기록 및 문헌자료 상세 분석을 시행한다. 의약품부작용피해구제 신청 안건 관련 의약품과 부작용 피해의 인과관계를 조사한다. 의약품부작용 전문위원을 운영하여 의약품과 피해와의 인과관계, 지급제한 사유 여부 등을 자문 받는다. 자문결과와 조사결과를 종합하여 의견을 제시하는 보고서를 작성하여 최종적으로 심의위원회 회의에 안건으로 상정한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","certLic":"약사, 간호사","dJobECd":"3030","dJobECdNm":"[3030]약사 및 한약사","dJobJCd":"2420","dJobJCdNm":"[2420]약사 및 한약사","dJobICd":"O842","dJobICdNm":"[O842]사회 및 산업정책 행정","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005313:1', '{"dJobCd":"K000005313","dJobCdSeq":"1","dJobNm":"의약품안전정보전문가","workSum":"시판 약품의 이상사례를 접수하고 인과관계 규명을 위한 약품역학 조사·연구를 실시하며 의약품적정사용(DUR : Drug Utilization Review)정보 등을 개발하여 관련 기관과 국민에게 보급한다.","doWork":"개인, 병원, 제약사로부터 시판 약품의 이상사례를 접수한다. 약물과 이상사례의 인과성을 과학적으로 분석하기 위해 연구설계를 하며 자료를 수집한다. 수집된 자료와 이차 자료원을 활용하여 통계분석을 실시하고 결과를 산출하여 약품 이상사례의 인과관계를 판정한다. 병용 시 또는 어린이, 노인, 임부에게 투여 시 주의해야 하는 의약품 정보 등을 알리는 의약품적정사용(DUR : Drug Utilization Review)정보를 개발하여 심평원 등 관련 기관에 제공한다. 안전한 의약품 사용문화를 조성하기 위해 대국민 대상 의약품안전 자료를 개발하여 보급한다. 의약품 등 제조·수입업체 안전관리책임자를 대상으로 의약품의 시판 후 안전관리에 대한 교육을 실시한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","certLic":"약사, 의사, 간호사","dJobECd":"3030","dJobECdNm":"[3030]약사 및 한약사","dJobJCd":"2420","dJobJCdNm":"[2420]약사 및 한약사","dJobICd":"O842","dJobICdNm":"[O842]사회 및 산업정책 행정","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007284:1', '{"dJobCd":"K000007284","dJobCdSeq":"1","dJobNm":"임상연구약사","workSum":"임상시험의 원활한 진행을 위해 임상시험용의약품을 관리한다.","doWork":"임상시험용 의약품의 인수, 보관, 조제, 관리 및 반납에 대한 책임을 지고 관련 기록을 유지하며 해당사항을 주기적으로 시험책임자에게 알린다. 피험자별로 임상시험에 사용되는 의약품의 투여일자, 수량, 제조번호, 일련번호, 사용기간(유효기간), 의약품식별코드, 피험자식별코드를 기록으로 남긴다. 피험자에게 임상시험에 사용되는 의약품의 투여방법을 정확하게 설명하고 피험자가 설명대로 지시사항을 올바르게 이행하고 있는지 일정한 간격으로 확인한다. 인수받은 임상시험용의약품을 계획서 및 표준작업지침서에 따라 조제한다. 임상시험자료를 정리하고 분석한다. 임상시험방법을 기준에 맞게 작성한다. 임상시험용의약품을 임상시험관리기준에 맞게 보관 및 관리한다. 의약품의 재고가 사용기록과 일치하는지 확인한다. 임상시험이 종료하면 반납한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"협의","workFunc3":"정밀작업","certLic":"약사","dJobECd":"3030","dJobECdNm":"[3030]약사 및 한약사","dJobJCd":"2420","dJobJCdNm":"[2420]약사 및 한약사","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007474:1', '{"dJobCd":"K000007474","dJobCdSeq":"1","dJobNm":"한약사","workSum":"(한)약국에서 한약을 조제하고 판매한다.","doWork":"환자에게 병력이나 체질 등을 물어보고 조제계획을 수립한다. 탕제기를 사용하여 한약제를 탕제로 가공한다. 한약재에 따라서 탕제, 환제, 산제, 고제, 기타 제형을 만든다. 환자 및 고객에게 복용횟수, 복용량, 복용금기 등 전탕과 투약, 복약을 지도한다. 부황기, 뜸기 등 한약재 조제 관련 기구를 판매한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"한약사, 한약조제사","dJobECd":"3030","dJobECdNm":"[3030]약사 및 한약사","dJobJCd":"2420","dJobJCdNm":"[2420]약사 및 한약사","dJobICd":"G478","dJobICdNm":"[G478]기타 상품 전문 소매업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004397:1', '{"dJobCd":"K000004397","dJobCdSeq":"1","dJobNm":"한약사(일반)","workSum":"한약의 조제, 제조, 유통, 무역부터 품질관리, 연구개발 업무를 수행한다.","doWork":"환자에게 병력이나 체질 등을 물어보고 조제계획을 수립하여 한약을 조제한다. 부황기, 뜸기 등 한약재 조제 관련 기구를 판매한다. 한약재 및 한약제재를 구입·저장·공급한다. 한약재 포제를 관리하고 한약재의 제조, 제조공정, 품질 등 한약제제를 관리한다. 한약의 외관관능, 형태학적 검사, 이화학적 검사, 생물학적 검사를 수행하여 성분을 분석하고 독성이나 이물질 포함 여부를 판단한다. 한약재 및 한약제재의 개발 및 보급에 대해 연구한다. 국민보건을 위한 보건정책을 입안하고 품질심사 등의 업무를 지원한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"자문","workFunc3":"정밀작업","certLic":"한약사, 한약조제사","dJobECd":"3030","dJobECdNm":"[3030]약사 및 한약사","dJobJCd":"2420","dJobJCdNm":"[2420]약사 및 한약사","dJobICd":"G478/Q862","dJobICdNm":"[G478]기타 상품 전문 소매업 / [Q862]의원","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005529:1', '{"dJobCd":"K000005529","dJobCdSeq":"1","dJobNm":"한약업사","workSum":"한약방에서 기성 한약서의 처방 및 한의사의 처방에 의해 한약재를 혼합 및 판매한다.","doWork":"기성 한약서에 기재된 처방 또는 한약사의 처방전에 의해 한약재를 혼합판매한다. 탕제기를 사용하여 한약재를 탕제로 가공한다. 한약재에 따라서 탕제, 환제, 산제, 고제, 기타 제형을 만든다. 환자 및 고객에게 전탕, 투약, 복약을 지도한다. 부황기, 뜸기 등 한약재 조제 관련 기구를 판매한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"한약업사","dJobECd":"3030","dJobECdNm":"[3030]약사 및 한약사","dJobJCd":"2420","dJobJCdNm":"[2420]약사 및 한약사","dJobICd":"G478","dJobICdNm":"[G478]기타 상품 전문 소매업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001706:1', '{"dJobCd":"K000001706","dJobCdSeq":"1","dJobNm":"가정전문간호사","workSum":"환자가 있는 가정에 방문하여 조사 및 심사를 통해 가정간호 계획을 수립하고 간호서비스를 제공한다.","doWork":"환자의 건강상태와 정서상태, 가치관을 파악한다. 가족 및 주간호자를 조사하고 사회경제적 요구도를 파악한다. 이를 토대로 간호목표를 수립한다. 간호진단을 도출하고 간호계획을 수립한다. 환자의 특성과 요구에 맞춰 전문적인 간호 또는 주치의가 의뢰한 치료적 간호를 수행한다. 수행된 결과와 환자의 반응을 모니터링하고 간호목표의 달성정도를 평가한다. 환자, 간호제공자, 교육과정생, 일반간호사, 지역사회 주민과 보건의료인을 대상으로 간호에 대해 교육한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"수동조작","certLic":"간호사, 가정전문간호사","dJobECd":"3040","dJobECdNm":"[3040]간호사","dJobJCd":"2430","dJobJCdNm":"[2430]간호사","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007494:1', '{"dJobCd":"K000007494","dJobCdSeq":"1","dJobNm":"간호사","workSum":"병원에서 의사의 진료를 보조하거나 의사의 처방이나 규정된 간호기술에 따라 서비스를 제공하며, 가정이나 지역사회를 대상으로 건강의 회복, 유지와 증진을 돕는다.","doWork":"의사의 진료를 보조한다. 간호대상자에 대한 신체적·정서적 편안함을 제공한다. 검사 준비 및 수술 시행 전·후의 간호를 수행한다. 간호대상자를 체계적으로 관찰하고 보고한다. 간호대상자를 요양하고 요양지도 및 관리를 한다. 대상자를 상담 및 교육하고 다른 보건의료인에게 간호업무에 대해 자문한다. 비품, 소모품, 소독물, 약품, 의료장비 등을 관리한다. 감염을 관리하고 사고예방을 위해 위험요소를 확인, 점검, 예방한다. 청결상태의 점검 등 치료적 환경을 제공한다. 간호일지, 투약기록지, 일일업무보고서 등을 작성한다. 이 밖에 법에 정하는 각종 보건활동을 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"수동조작","connectJob":"가정전문간호사, 감염전문간호사, 노인전문간호사, 마취전문간호사, 아동전문간호사, 응급전문간호사, 임상전문간호사, 정신전문간호사, 종양전문간호사, 중환자전문간호사, 호스피스전문간호사, 보건전문간호사, 산업전문간호사, 교정간호사","certLic":"간호사","dJobECd":"3040","dJobECdNm":"[3040]간호사","dJobJCd":"2430","dJobJCdNm":"[2430]간호사","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003308:1', '{"dJobCd":"K000003308","dJobCdSeq":"1","dJobNm":"감염관리전문간호사","workSum":"병원 내 감염을 예방하고 관리하기 위해 감염 여부를 조사하고 예방계획을 수립·실시하며 감염관리 규정, 지침, 정책 등을 마련한다.","doWork":"감염유행 시, 직원의 감염원 노출 시, 병원 환경관리 시 역학 조사를 실시한다. 감염유행의 원인을 파악하고 해당 부서에 연락하여 감염 예방조치를 취한다. 미생물검사실에 연락하여 원인이 되는 미생물을 보관하도록 하고 관리대책을 실시한다. 감염관리 규정, 지침, 정책 등을 마련한다. 의료진 및 병원직원을 대상으로 감염 대처방법 등을 교육한다. 감염관리가 시행되고 있는지 확인하고 평가한다. 수정사항이나 문제점을 파악하여 교정한다. 감염방지 관련 물품을 청구하며 예방접종을 실시하는 등 직원의 감염예방과 관리업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","certLic":"간호사, 감염관리전문간호사","dJobECd":"3040","dJobECdNm":"[3040]간호사","dJobJCd":"2430","dJobJCdNm":"[2430]간호사","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002829:1', '{"dJobCd":"K000002829","dJobCdSeq":"1","dJobNm":"노인전문간호사","workSum":"노인전문병원, 의료복지기관, 요양원 등에서 노인의 건강관리와 병세호전을 위해 간호계획을 수립하고 각종 프로그램을 진행하여 노인을 돌본다.","doWork":"노인 및 가족과 상담을 통해 요구사항을 수렴하여 간호계획을 수립한다. 시설 및 간호에 대해 안내하고 노인의 건강관리, 회복, 질병예방 등에 관해 설명한다. 노인의 건강관리 및 병세호전을 위한 각종 재활치료 및 치료프로그램을 진행하거나 노인들의 유연한 진행을 돕는다. 상해를 입은 노인을 응급처치하고, 병원 후송 여부를 결정한다. 노인의 건강상태에 관한 자료를 기록·관리한다. 구급약품을 관리하며 의무실을 운영·관리한다. 관련 의료기관의 의사에게 건강상태 자료를 제출하여 정기적으로 건강상태를 검토한다. 노인의 건강에 이상이 생기면 병원에 의뢰하여 건강상태를 확인한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"수동조작","certLic":"간호사, 노인전문간호사","dJobECd":"3040","dJobECdNm":"[3040]간호사","dJobJCd":"2430","dJobJCdNm":"[2430]간호사","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003563:1', '{"dJobCd":"K000003563","dJobCdSeq":"1","dJobNm":"당뇨교육자","workSum":"당뇨병 고위험군(당뇨병 전단계) 또는 당뇨병을 진단받는 사람을 대상으로 질환에 대한 정보를 제공하고 효율적인 당뇨병 자가관리에 필요한 내용과 관리 목표, 그리고 교육프로그램을 구성하여 이를 통하여 교육하고 상담한다.","doWork":"당뇨병 환자의 질환관리에 영향을 주는 생활습관 전반을 상담을 통해 파악한다. 파악된 자료를 토대로 생활습관 개선을 위한 자가관리 방법에 대해 계획을 세우고 실천할 수 있도록 돕는다. 당뇨병 환자들이 질환을 스스로 관리하여 개별화된 목표 혈당치를 달성하도록 돕는다. 당뇨에 관한 교육자료를 개발하고 교육을 시행한다. 당뇨병 관련 캠프 또는 지역사회의 당뇨병 강의 등에 참여하여 교육 및 상담을 진행하며 당뇨병 주관 행사를 진행한다. 당뇨병과 관련된 임상연구에 참여하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","certLic":"의사, 간호사, 영양사, 사회복지사, 약사","dJobECd":"3040","dJobECdNm":"[3040]간호사","dJobJCd":"2430","dJobJCdNm":"[2430]간호사","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003916:1', '{"dJobCd":"K000003916","dJobCdSeq":"1","dJobNm":"마취전문간호사","workSum":"의사의 감독하에 마취시행에 필요한 장비와 물품을 준비하여 환자에게 마취를 시행하며 비정상적인 환자의 반응에 대처하고 마취회복 시 위험 증상을 관찰예방한다.","doWork":"1회 배뇨량 측정 등 마취를 위한 자료를 수집한다. 수집된 자료를 통합하고 분석하여 간호진단을 내린다. 마취 간호진단에 근거하여 응급 상황을 고려한 마취계획을 수립한다. 마취 기구, 환자 삽입 장치, 체위에 필요한 보조물품 등 마취시행에 필요한 장비 및 물품을 준비하고 환자의 혈액형과 혈액준비를 확인하는 등 마취를 준비한다. 환자에게 삽입된 여러 기구 및 카테터(기도 안의 이물질 제거 기구)의 기능을 확인하고 관리한다. 마취체위를 유지시키고 마취의 또는 외과의(집도의) 감독하에 마취를 시행한다. 침습적, 비침습적 모니터링을 실시한다. 인공호흡기 및 산소요법, 전해질 및 산-염기균형 유지와 수행요법을 제공하고 비정상적인 환자의 반응에 대처하여 적절한 마취간호를 제공한다. 환자의 마취회복 시 위험 증상을 관찰, 예방하며 통증완화를 위한 간호중재를 실시한다. 마취 간호수행 결과를 평가한다. 마취간호 대상자나 의료진에게 교육과 상담을 제공한다. 마취간호 관련한 연구를 수행한다. 마취간호 개선 작업과 보건의료 정책에 참여한다. 마취 관련 물품, 약품, 장비 등을 관리한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"수동조작","certLic":"간호사, 마취전문간호사","dJobECd":"3040","dJobECdNm":"[3040]간호사","dJobJCd":"2430","dJobJCdNm":"[2430]간호사","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002083:1', '{"dJobCd":"K000002083","dJobCdSeq":"1","dJobNm":"모유수유전문가","workSum":"산모 및 예비산모 등을 대상으로 모유수유 필요성과 방법 등을 교육하고 젖몸살, 유두막힘 등 모유수유로 발생하는 문제점에 대한 해결책을 제시한다.","doWork":"모유수유 방법 및 자세에 대해 알려주며 필요시 교정한다. 모유수유자에게 젖이 잘 나올 수 있도록 통증 없는 가슴마사지 방법을 알려준다. 모유수유자에게 가슴마사지를 해준다. 세균관리, 수유패드 착용 장단점, 연고 등 약사용 외에도 유두관리에 대한 방법 등을 조언한다. 유축기 등 모유수유 기기 등의 사용방법을 알려준다. 질병별 모유수유 방법, 모유수유 시 약 복용 가능성, 젖량이 부족한 사람에게 음식, 차 등 젖량 증가 방법을 알려준다. 산후조리원 등 관련 기관에서 모유수유 장점 및 모유수유 방법 등 산모 및 직원들에게 교육한다. 모유를 안전하게 저장하는 방법, 아기의 변 색깔 등 아기 건강 외에도 기타 모유수유에 관한 정보와 컨설팅을 제공한다. 가슴통증 등 의료적 문제가 있을 시 의료인에게 안내한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"수동조작","certLic":"간호사, 한의사, 의사","dJobECd":"3040","dJobECdNm":"[3040]간호사","dJobJCd":"2430","dJobJCdNm":"[2430]간호사","dJobICd":"S969","dJobICdNm":"[S969]그 외 기타 개인 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007490:1', '{"dJobCd":"K000007490","dJobCdSeq":"1","dJobNm":"보건교사","workSum":"초등학교 및 중·고등학교에서 학생 및 교직원의 건강에 관한 계획을 수립하고 학교의 보건활동을 수행한다.","doWork":"학생의 건강상태를 평가하기 위하여 정기적인 건강진단 또는 용의검사를 실시하고 결과를 검토한다. 돌발사고에 대한 응급처치, 질병 및 전염병에 대한 보건교육 등을 실시하고, 예방접종을 시행한다. 보건 및 의료단체와 협의하여 효율적인 건강계획을 수립하고 실시한다. 학생의 건강관찰을 담당하며, 건강에 관한 상담을 한다. 성교육, 약물오남용 예방교육, 응급처치 및 구강관리교육, 비만관리교육 등 보건교육을 실시한다. 필요시 가정방문을 통한 보건지도를 한다. 보건실의 시설, 설비, 약품 등을 관리한다. 필요시 응급처치, 의약품투여 등 기타 의료행위를 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|언어력|시각|","workFunc1":"분석","workFunc2":"교육","workFunc3":"수동조작","certLic":"보건교사","dJobECd":"3040","dJobECdNm":"[3040]간호사","dJobJCd":"2430","dJobJCdNm":"[2430]간호사","dJobICd":"P851/P852/P854","dJobICdNm":"[P851]초등 교육기관 / [P852]중등 교육기관 / [P854]특수학교, 외국인학교 및 대안학교","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002883:1', '{"dJobCd":"K000002883","dJobCdSeq":"1","dJobNm":"보건전문간호사","workSum":"지역사회 주민과 기관을 대상으로 질병예방, 보건교육, 건강증진을 위한 사업을 계획하고 실시하며 평가한다.","doWork":"안전관리, 사고관리, 감염관리, 환경관리 등 보건 대상자에게 영향을 미치는 환경적 건강 문제를 확인한다. 해결방안을 모색하고 개인, 가족, 지역사회 대상자의 질병 예방, 보건교육 사업 및 증진사업 계획을 수립한다. 건강한 환경조성을 위한 중재 및 안전하고 비용 효과적인 보건간호 중재를 실시한다. 예방접종, 집단강의, 방문교육 등 보건활동을 실시한다. 간호제공 후 효과를 평가한다. 제공된 서비스에 대한 대상자의 만족도를 평가한다. 약품 및 비품 등을 관리한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"교육","workFunc3":"수동조작","certLic":"간호사, 보건전문간호사","dJobECd":"3040","dJobECdNm":"[3040]간호사","dJobJCd":"2430","dJobJCdNm":"[2430]간호사","dJobICd":"Q863","dJobICdNm":"[Q863]공중 보건 의료업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001355:1', '{"dJobCd":"K000001355","dJobCdSeq":"1","dJobNm":"산업전문간호사","workSum":"산업체에 종사하는 근로자의 건강을 관리하고 법률에 따른 보건행정 관련 업무를 수행한다.","doWork":"산업보건계획을 수립하고 수행·평가한다. 금연운동 등 건강증진 사업을 계획하고 실행한다. 직업병 예방을 위한 사업을 수행한다. 근로자의 건강에 해로운 사업장 환경을 개선한다. 근로자 개인별 건강카드를 기록하고 유지한다. 작업장에서 환자의 발생원인을 파악하고 관련 통계를 기록·유지하며 문제해결을 위해 관련 부서에 보고 및 통보한다. 산업위생에 필요한 약품 및 장비를 보존하고 관리한다. 의료장비, 의약품, 의료비품 등을 구매하며 사업장의 구급약품 및 영양제를 근로자에게 제공하고 관리한다. 근로자를 대상으로 보호구 착용 등 보건 관련 교육을 실시한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"교육","workFunc3":"수동조작","certLic":"간호사, 산업전문간호사","dJobECd":"3040","dJobECdNm":"[3040]간호사","dJobJCd":"2430","dJobJCdNm":"[2430]간호사","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006774:1', '{"dJobCd":"K000006774","dJobCdSeq":"1","dJobNm":"산후조리원신생아관리사","workSum":"산후조리기관에서 출산 후 산모의 건강회복을 위하여 산모를 간호하고 신생아를 돌본다.","doWork":"산모의 예정일에 맞추어 입실 계획을 세우고, 예비산모에게 산전교육을 한다. 출산 후 산모와 신생아의 건강상태를 점검한다. 섭식 등의 생활계획을 세우고, 관련 프로그램, 면회시간, 공동생활의 주의점 등을 안내한다. 산모의 건강관리, 신생아 보호 등에 대한 정보를 제공하고, 요가, 마사지, 피부관리 등 산모를 위한 프로그램을 운영한다. 산모 및 신생아의 건강을 주기적으로 관찰하고 관련 사항을 영유아 건강기록부 및 임산부 건강기록부에 기록한다. 신생아의 분유를 준비하여 먹이고 산모의 모유수유 등을 지원한다. 모유수유가 어렵거나 문제가 발생 시 지원한다. 신생아의 생리적인 변화 등에 관한 산모의 문의에 응대한다. 산모와 신생아가 건강상 이상 징후를 보일 때는 산모 또는 보호자 동의 아래 의료기관에 진료를 의뢰한다. 의료기관 의료진의 왕진 시 산모 및 신생아의 건강자료를 제공하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"서비스제공","workFunc3":"수동조작","certLic":"간호사, 간호조무사","dJobECd":"3040","dJobECdNm":"[3040]간호사","dJobJCd":"2430","dJobJCdNm":"[2430]간호사","dJobICd":"S969","dJobICdNm":"[S969]그 외 기타 개인 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005945:1', '{"dJobCd":"K000005945","dJobCdSeq":"1","dJobNm":"수간호사","workSum":"환자들에게 양질의 간호를 제공하기 위하여 간호업무 전반을 기획·감독·조정한다.","doWork":"간호부서의 업무를 통괄하여 관리하고 병원관리자를 보좌하여 병원 운영에 참여한다. 간호부서의 예산을 편성·집행한다. 간호업무에 필요한 시설, 비품 및 물자의 사용기준량을 책정하고 관리체계를 정립한다. 병원의 간호활동 목표 및 방침을 직원들에게 교육한다. 환자간호에 필요한 서류양식, 보고서 등의 기록방법과 제출절차를 제도화한다. 간호학생의 임상교육방침을 학교 측과 협의·결정하기도 한다. 간호와 관련된 각종 지역사회건강사업 및 의료봉사활동에 참여하기 위해 계획하고 시행을 지시하기도 한다. 간호사업과 관련하여 전문단체의 자문에 응하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","certLic":"간호사","dJobECd":"3040","dJobECdNm":"[3040]간호사","dJobJCd":"2430","dJobJCdNm":"[2430]간호사","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003570:1', '{"dJobCd":"K000003570","dJobCdSeq":"1","dJobNm":"아동전문간호사","workSum":"아동과 가족의 건강력을 수집하고 임상적 의사결정을 통해 아동을 진단하고 간호서비스를 제공한다.","doWork":"발달상태 선별검사, 소아발육 기록 및 평가 등을 통해 신체/운동 성장발달을 확인한다. 사회심리발달과 인지도덕을 확인하고 아동과 가족의 건강력을 수집한다. 시진, 촉진, 청진, 타진 등을 통해 전신 신체검진을 한다. 영양상태와 아동 통증을 평가하여 신체검진을 수행한다. 정신 영적 건강을 사정한다. 진단검사 결과를 확인하고 자료를 분석 및 해석한다. 실제적, 잠재적 건강문제를 진단한다. 비판적 임상추론과 주소견 기술을 통해 감별하고 진단한다. 치료 및 간호 중재를 계획하고 평가한다. 기본심폐소생술(BLS)과 소아전문심폐소생술(P-ACLS)을 시행한다. 사고, 중독아동을 관리하고 지역사회 재해에 대처한다. 아동 발달단계별 건강교육 계획을 수립하고 건강교육 프로그램, 교육자료를 개발, 시행 및 평가한다. 아동 및 주양육자를 상대로 상담과 코칭을 진행한다. 병원학교 운영 프로그램을 계획하고 아동 건강 관련 인적, 물적 자원 및 재정을 관리한다. 아동간호실무표준 및 지침과 알고리즘을 개발하는 등 전문직 발전에 참여한다. 아동건강 관련 이론을 실무에 적용하고 연구를 기획 및 결과발표를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"수동조작","certLic":"간호사, 아동전문간호사","dJobECd":"3040","dJobECdNm":"[3040]간호사","dJobJCd":"2430","dJobJCdNm":"[2430]간호사","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005864:1', '{"dJobCd":"K000005864","dJobCdSeq":"1","dJobNm":"연구간호사","workSum":"책임연구자의 지휘 아래 의약품 임상시험관리기준(GCP:Good Clinical Practice)의 원칙에 따라 임상시험 자료를 수집, 기록, 유지한다.","doWork":"임상시험 시작을 위해 예산 편성, 계획서 작성, 시설 및 장비 활용가능성을 검토한다. 피험자를 모집하고 연구에 대한 동의를 얻고 피험자 일정을 관리한다. 증례기록서를 작성하고 연구비를 정산하며 IRB에 보고서를 제출한다. 식품의약품안전처(KFDA) 실사 준비 및 실사에 참여하며 연구에 따라 환자를 추적 관찰한다. 표준작업지침서(SOPs)를 개발 및 검토하고 연수교육 및 관련 학회에 참석하며 교육프로그램을 개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"수동조작","certLic":"간호사, 약사","dJobECd":"3040","dJobECdNm":"[3040]간호사","dJobJCd":"2430","dJobJCdNm":"[2430]간호사","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003182:1', '{"dJobCd":"K000003182","dJobCdSeq":"1","dJobNm":"응급전문간호사","workSum":"응급환자를 대상으로 환자의 상태에 따라 응급시술 및 처치를 시행한다.","doWork":"응급환자를 이송하고 관리한다. 응급환자를 상태의 경중에 따라 분류한다. 환자의 상태에 따라 위세척, 채혈, 응급장치 모니터링, 상급응급심폐소생술 및 각종 응급시술과 처치를 시행한다. 응급간호사, 환자, 일반인 등을 대상으로 심폐소생술 등 응급처치에 대해 교육한다. 인공호흡기 등 응급 관련 기기를 관리한다. 응급체계의 운영, 행정에 대해 연구한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"수동조작","certLic":"간호사, 응급전문간호사","dJobECd":"3040","dJobECdNm":"[3040]간호사","dJobJCd":"2430","dJobJCdNm":"[2430]간호사","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006583:1', '{"dJobCd":"K000006583","dJobCdSeq":"1","dJobNm":"의료급여관리사","workSum":"의료급여 사례관리, 의료급여 중복청구 관리 및 수급권자 상담 등 의료급여와 관련된 업무를 수행한다.","doWork":"수급권자의 건강관리 향상을 위한 교육 및 상담을 실시한다. 의료급여제도 안내 및 의료기관 이용을 위한 상담을 실시한다. 의사의 의료와 보건지도 및 약사의 복약지도에 대한 수급권자의 이행 여부를 모니터링하고 요양 방법에 대한 지도를 실시한다. 수급권자와 보장시설 등 보건복지시설을 연계한다. 의료급여관리 과다이용 사례관리, 의료급여일수 연장승인, 의료급여 중복청구 관리 등 의료급여와 관련된 업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","certLic":"간호사","dJobECd":"3040","dJobECdNm":"[3040]간호사","dJobJCd":"2430","dJobJCdNm":"[2430]간호사","dJobICd":"O845","dJobICdNm":"[O845]사회보장 행정","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005125:1', '{"dJobCd":"K000005125","dJobCdSeq":"1","dJobNm":"의약품부작용피해구제상담원","workSum":"의약품 부작용 및 피해구제에 관해 상담하고 접수하며, 심의결과를 통보한다.","doWork":"의약품 부작용 및 피해구제에 대해 상담하고 접수한다. 피해구체 신청 방법과 구비서류 등을 안내하고, 신청 대상 여부를 검토한다. 신청된 피해구제 건에 대해 의무기록 등 경과사항을 정리하여 의약품부작용피해구제조사자에게 전달한다. 의약품부작용 심의위원회 심의결과에 따라 지급 여부 및 그에 대한 사유를 신청자에게 통보하고 보상금을 지급한다. 피해구제사업에 대해 홍보하고 민원을 처리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"자문","workFunc3":"관련없음","certLic":"간호사","dJobECd":"3040","dJobECdNm":"[3040]간호사","dJobJCd":"2430","dJobJCdNm":"[2430]간호사","dJobICd":"O842","dJobICdNm":"[O842]사회 및 산업정책 행정","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005952:1', '{"dJobCd":"K000005952","dJobCdSeq":"1","dJobNm":"임상전문간호사","workSum":"환자에게서 나타나는 임상증상을 수집하고 임상 문제와 관련하여 신체검진을 진행, 해석 및 판단한다.","doWork":"환자에게서 나타나는 신체 및 정신적인 증상과 환자가 경험하고 있는 질환에 대한 과거 및 현재 관리와 질병 과정 및 합병증과 관련된 임상증상을 수집한다. 임상문제와 관련하여 신체검진을 진행하며 검사결과를 해석하고 지속적으로 주시하며 임상적 문제를 판단한다. 임상 증상을 관리하고 치료에 참여하며 약물요법을 적용한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"임상시험간호사","certLic":"간호사, 임상전문간호사","dJobECd":"3040","dJobECdNm":"[3040]간호사","dJobJCd":"2430","dJobJCdNm":"[2430]간호사","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002254:1', '{"dJobCd":"K000002254","dJobCdSeq":"1","dJobNm":"장기이식코디네이터","workSum":"장기이식을 시행하는 의료기관에서 장기 기증자와 이식 대상자를 연결하고, 장기이식과 관련된 의학적, 법적, 행정적 절차가 원활하게 이루어질 수 있도록 조정·중재하며, 장기기증 활성화를 위해 홍보기획을 한다.","doWork":"기증자 발생을 점검하고, 뇌사자가 발생하면 국립장기이식관리센터(KONOS)로 연락을 취한다. 뇌사자 이송 및 관리를 하며, 기증자 가족에게 장기기증의 동의를 받는다. 장기 기증자, 수혜자 및 가족에게 이식에 관한 정보를 제공한다. 장기수혜자 및 가족들에게 장기기증 절차를 설명하고, 수술일정과 부가적인 행정절차를 관리한다. 수술에 참여하며, 장기분배기능을 담당한다. 적출내용을 관할 지방검찰청에 보고하고, 뇌사자 관리와 관련된 각종 기록을 관리한다. 적출 장기를 이송 및 보존한다. 장기수혜자에게 이식에 관한 정보를 제공하고, 이식수술 후 재활을 돕는다. 잠재뇌사자 발굴을 위한 중환자실 방문과 가족에 대한 기증권유 상담을 한다. 장기기증 관련 자료를 수집하고, 장기기증 활성화를 위한 홍보 및 교육을 한다. 생전 및 사후 장기기증에 관하여 상담하며, 등록을 받고 등록자를 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"조정","workFunc2":"협의","workFunc3":"단순작업","similarNm":"장기이식간호사, 이식코디네이터, 이식간호코디네이터, 신장간호사","certLic":"간호사","dJobECd":"3040","dJobECdNm":"[3040]간호사","dJobJCd":"2430","dJobJCdNm":"[2430]간호사","dJobICd":"Q869","dJobICdNm":"[Q869]기타 보건업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001701:1', '{"dJobCd":"K000001701","dJobCdSeq":"1","dJobNm":"정신전문간호사","workSum":"여러 가지 기법을 이용하여 정신 간호 대상자의 스트레스를 완화, 관리하고 약물 및 심리치료법을 적용한다.","doWork":"자조그룹지도를 포함한 다양한 방법을 통하여 정신 간호 대상자의 스트레스를 완화하고 관리한다. 인지행동치료, 인간관계훈련, 직업재활, 현실요업, 정신심리극, 인간잠재력개발훈련, 미술요법, 독서요법, 음악요법, 무용요법, 환경요법, 놀이요법 등 정신간호에 필요한 치료적 활동을 수행한다. 정신장애자의 생활훈련, 작업훈련 및 개인, 가족, 집단치료를 수행한다. 정신장애자의 증상 및 약물관리를 실시한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","certLic":"간호사, 정신건강간호사","dJobECd":"3040","dJobECdNm":"[3040]간호사","dJobJCd":"2430","dJobJCdNm":"[2430]간호사","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004069:1', '{"dJobCd":"K000004069","dJobCdSeq":"1","dJobNm":"조산사","workSum":"임산부의 임신, 분만, 산후관리와 신생아 관리를 돕고 임산부와 그 가족을 대상으로 가족계획, 여성암 예방 등 여성 건강 관리에 대해 교육한다.","doWork":"임산부의 산과력 등을 문진하고 초음파검사기 등을 사용하여 임신진단, 신체검진, 혈액·소변검사, 태아건강사정, 위험요소 사정 및 교육을 한다. 분만 기구를 준비한다. 분만진행과정을 관리하고 태아심음 측정, 회음부 절개, 분만을 관리한다. 기도흡인물 제거 등 신생아 돌보기와 산모의 혈압, 자궁퇴축 관리, 젖울혈 풀기 등 산후를 관리한다. 신생아 관찰, 눈간호, 목욕시키기와 가족계획, 성교육, 여성암 예방 등 여성건강을 관리하고 교육한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"수동조작","certLic":"조산사, 간호사","dJobECd":"3040","dJobECdNm":"[3040]간호사","dJobJCd":"2430","dJobJCdNm":"[2430]간호사","dJobICd":"Q869","dJobICdNm":"[Q869]기타 보건업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005381:1', '{"dJobCd":"K000005381","dJobCdSeq":"1","dJobNm":"종양전문간호사","workSum":"환자로부터 암 위험 요인 등 자료를 수집하고 임상적 의사결정에 따라 간호서비스를 제공한다.","doWork":"환자의 생활습관, 만성감염, 유전, 지역 특성 등 암 위험 요인을 조사한다. 의식수준 진단, 시진, 청진, 촉진, 타진, 특수신체검진 등을 통해 신체검진을 수행한다. Pap Test, 유방촬영술, 잠혈검사, 직장지두검사, 위내시경, 결장경검사 등을 통해 암 조기발견 검사결과를 확인하고 해석한다. 위내시경, 위장조영술, AFP, 복부초음파검사 등을 통해 선별검사를 하고 암 발생 위험 요인을 확인한다. 이를 바탕으로 고위험집단을 결정하고 간호진단, 감별진단을 내린 후 치료계획 및 간호중재계획을 수립한다. 추후 관리체계를 기획 및 활용하고 간호수행 결과를 평가한 뒤 간호내용을 수정 및 보완한다. 암 생존자를 위한 건강증진 프로그램을 개발 및 시행하고 질병과 불구 예방 및 자가 관리에 대한 건강 상담을 제공한다. 자조그룹을 구성 및 운영 지원하고 대상자, 가족을 격려 및 지지, 사회복귀 프로그램을 개발 및 지원하는 등 코칭을 수행한다. 예산수립, 사업활동 계획 등의 기획 업무를 하고, 인력관리, 정보관리, 안전관리 및 사고관리, 감염관리, 재정관리, 물품관리를 수행한다. 종양 간호 실무 관련 자문을 구하거나 응한다. 종양전문 간호사 직무 관련 연구를 하는 등 전문직 발전에 참여한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"수동조작","certLic":"간호사, 종양전문간호사","dJobECd":"3040","dJobECdNm":"[3040]간호사","dJobJCd":"2430","dJobJCdNm":"[2430]간호사","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003134:1', '{"dJobCd":"K000003134","dJobCdSeq":"1","dJobNm":"중환자전문간호사","workSum":"중환자를 대상으로 간호를 사정하고 신체검진, 진단결과를 해석하여 적정한 간호계획을 수립하고 간호를 수행한다.","doWork":"순환, 호흡, 신경계 중환자를 비롯하여 복합적 문제를 가진 위중한 상태의 대상자에 대해 간호를 사정한다. 신체검진, 진단결과를 해석하여 적정한 간호계획을 수립한다. 계획된 간호중재 아래 중환자 치료에 적용되는 약물을 관리한다. 중환자에 적용하는 특수간호술을 시행한다. 중환자에게 발생할 수 있는 동통, 피부손상 등의 문제를 해결하고 이를 평가한다. 응급상태 시 위기에 대처하고 상급심폐소생술 및 심장재활 간호를 실시한다. 위기상태의 환자와 가족의 스트레스를 조절하고 그들이 잘 적응하도록 지지한다. 중환자실의 감염 및 환경을 관리한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"수동조작","certLic":"간호사, 중환자전문간호사","dJobECd":"3040","dJobECdNm":"[3040]간호사","dJobJCd":"2430","dJobJCdNm":"[2430]간호사","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003566:1', '{"dJobCd":"K000003566","dJobCdSeq":"1","dJobNm":"호스피스전문간호사","workSum":"말기 환자의 신체적, 정서적 안정을 위해 통증조절 및 증상완화 등 간호서비스를 제공한다.","doWork":"가족에게 임박한 임종의 징후와 가족이 해야 할 일에 대하여 알려준다. 말기환자의 처방에 따른 진단적 검사와 약물요법을 수행하고 그 효과와 부작용 관찰 및 그에 따른 중재를 실시한다. 말기환자의 통증 및 증상의 완화와 안위도모를 위한 비약물적 중재를 제공하고 말기환자에게 발생 가능한 합병증을 예방하기 위한 간호를 제공한다. 죽음 직후 가족과 함께 사후처치를 실시한다. 사별가족이 사회활동이나 관심 분야의 활동에 참여하도록 돕는다. 비정상적인 사별 문제를 가진 가족을 파악하여 적절한 중재를 제공한다. 다양한 현장에서 말기환자간호프로그램을 개발하기 위한 전략을 규명하여 수행하며 이를 평가한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"수동조작","certLic":"간호사, 호스피스전문간호사","dJobECd":"3040","dJobECdNm":"[3040]간호사","dJobJCd":"2430","dJobJCdNm":"[2430]간호사","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002546:1', '{"dJobCd":"K000002546","dJobCdSeq":"1","dJobNm":"환자안전전담인력","workSum":"의료기관 내 환자안전 및 의료 질 향상에 관한 업무를 전담하여 수행하는 자로서, 환자안전사고를 예방하고 관리하기 위한 일련의 환자안전활동을 수행한다.","doWork":"환자안전사고에 대한 정보의 수집·분석(근본원인분석, 고장유형 영향분석 등의 방법론 활용), 관리·공유 및 개선활동을 수행한다. 환자안전사고 예방 및 재발 방지를 위해 보건의료인을 교육한다. 환자와 환자 보호자의 환자안전활동을 위한 교육을 수행한다. 환자안전활동에 대해 관계자 또는 관계기관에 보고한다. 환자안전기준의 준수여부를 점검한다. 환자안전지표의 측정·점검 업무를 한다. 그 밖에 환자안전 및 의료 질 향상을 위하여 보건복지부장관이 특히 필요하다고 인정하는 사항 등을 수행한다. 환자안전을 최우선의 중요한 가치로 두고 환자안전문화가 구축될 수 있는 의료환경을 조성하기 위하여 매년 계획을 수립하고 실행한다. 기관 내 종사자를 대상으로 환자안전문화를 측정하기도 한다. 환자안전 및 의료 질 향상 관련 외부기관 및 이해 관계자의 요구에 협력대응한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"환자안전 전담자, 환자안전 전담간호사, PI(Performance Improvement)간호사, QPS(Quality Patient Safety)간호사, 환자안전 담당자","connectJob":"감염관리전문간호사","certLic":"의사, 치과의사, 한의사, 약사, 간호사","dJobECd":"3040","dJobECdNm":"[3040]간호사","dJobJCd":"2430","dJobJCdNm":"[2430]간호사","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001258:1', '{"dJobCd":"K000001258","dJobCdSeq":"1","dJobNm":"급식영양사","workSum":"급식대상자에게 균형 있는 음식물 공급을 위하여 식단을 계획하고, 조리 및 공급을 감독한다.","doWork":"급식대상자의 기호·영양가·조리능력·비용 등을 기초로 급식 운영 계획을 수립하고 식단표를 작성한다. 식품재료를 선정하고, 검수·관리한다. 조리 담당자의 조리·위생상태를 관리·감독하고 교육한다. 주방기구 및 설비의 위생을 점검한다. 조리된 음식의 조화·맛을 평가하기 위하여 검식한다. 일일 운영일지를 작성한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|다습|","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","certLic":"영양사","dJobECd":"3050","dJobECdNm":"[3050]영양사","dJobJCd":"2440","dJobJCdNm":"[2440]영양사","dJobICd":"I561","dJobICdNm":"[I561]음식점업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005681:1', '{"dJobCd":"K000005681","dJobCdSeq":"1","dJobNm":"상담영양사","workSum":"건강진단센터, 체중조절센터 등에서 환자의 영양상태를 조사하여 영양교육을 실시하고, 질병치료 및 예방을 위해 영양상담을 한다.","doWork":"진료기록을 바탕으로 식습관, 식생활 등을 평가하고, 직접 상담을 통해 영양상태를 판정한다. 개인별 영양상태 평가표를 작성한다. 개인별 섭취권장량을 처방하고, 식습관 개선 및 영양교육을 실시한다. 질환별 식사조절을 위해 상담한다. 음식의 양 및 칼로리를 계산하는 데 도움을 주기 위해 음식물 모형, 칼로리 계산표 등과 같은 관련 자료를 활용하여 상담한다. 영양 교육자료를 개발한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","certLic":"영양사","dJobECd":"3050","dJobECdNm":"[3050]영양사","dJobJCd":"2440","dJobJCdNm":"[2440]영양사","dJobICd":"Q869","dJobICdNm":"[Q869]기타 보건업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002213:1', '{"dJobCd":"K000002213","dJobCdSeq":"1","dJobNm":"영양교사","workSum":"초·중·고등학생이 균형 잡힌 식사를 할 수 있도록 식단을 계획하고, 조리 및 식재료 공급 등을 감독한다.","doWork":"학생의 기호, 영양가, 조리능력, 비용 등을 기초로 급식운영 계획을 수립하고 식단표를 작성한다. 식품재료를 선정하고, 검수·관리한다. 조리 담당자의 조리·위생 상태를 관리·감독하고 교육한다. 주방기구 및 설비의 위생을 점검한다. 조리된 음식의 조화·맛을 평가하기 위하여 검식한다. 일일 운영일지를 작성한다. 학생 및 학부모를 대상으로 영양상담을 실시하고, 교실순회를 통한 식사예절 교육을 실시한다. 게시판, 인터넷, 방송 등을 통해 식생활 정보를 제공하거나 영양 교육프로그램을 개발하여 진행하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"교육","workFunc3":"수동조작","certLic":"영양사, 영양교사","dJobECd":"3050","dJobECdNm":"[3050]영양사","dJobJCd":"2440","dJobJCdNm":"[2440]영양사","dJobICd":"P852","dJobICdNm":"[P852]중등 교육기관","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001919:1', '{"dJobCd":"K000001919","dJobCdSeq":"1","dJobNm":"임상영양사","workSum":"의료 관련 기관에서 질병치료와 예방을 위하여 급식 및 영양관리를 한다.","doWork":"환자의 진료기록과 의사처방, 영양상담으로 영양상태를 판정하고, 급식운영 계획을 수립하여 식단표를 작성한다. 식품재료를 선정하고, 검수·관리한다. 조리 담당자의 조리 및 위생상태를 관리·감독하고 교육한다. 주방기구 및 설비의 위생을 점검한다. 조리된 음식의 조화와 맛을 평가하기 위하여 검식한다. 배선원 및 배식원을 관리·감독한다. 식사회진을 하여 환자들의 식사 섭취량을 조사한다. 영양상담 및 교육을 하고, 교육자료를 제작한다. 의사의 처방에 도움이 되도록 식사처방지침서를 제작한다. 의사의 의뢰에 의해 환자의 의무기록을 작성한다. 일일 운영일지를 작성한다. 영양문제를 수집 및 분석하고 영양요구량을 산정하여 영양상태를 판정한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"교육","workFunc3":"관련없음","certLic":"영양사, 임상영양사","dJobECd":"3050","dJobECdNm":"[3050]영양사","dJobJCd":"2440","dJobJCdNm":"[2440]영양사","dJobICd":"Q869","dJobICdNm":"[Q869]기타 보건업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005865:1', '{"dJobCd":"K000005865","dJobCdSeq":"1","dJobNm":"근전도기사","workSum":"환자의 근육이나 신경계통의 질환을 진단하기 위하여 근육이나 신경의 활동전위를 기록한다.","doWork":"의사의 지시에 따라 근전도검사기(Electromyograph)의 전극을 환자의 규정된 신체부위에 부착하고 전기자극을 주어 말초신경 혹은 중추신경에 전기자극이 전달되는 속도 및 기타 반응을 기록한다. 기록된 자료를 정리·분석하여 진료에 필요한 자료로 제공한다. 환자의 규정된 신체부위에 자석으로 자극을 주어 자장이 신경을 따라 전달되는 속도를 검사·기록하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"임상병리사","dJobECd":"3061","dJobECdNm":"[3061]임상병리사","dJobJCd":"2451","dJobJCdNm":"[2451]임상병리사","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005159:1', '{"dJobCd":"K000005159","dJobCdSeq":"1","dJobNm":"뇌파기사","workSum":"신경계질환 및 뇌장애를 검진하기 위해 뇌파검사기를 사용하여 신경세포의 활동을 측정·검사하고 기록지에 기록한다.","doWork":"은제 원판이나 전극침을 전도성이 높은 접착테이프로 환자의 머리 또는 특정부위에 붙이고 뇌전도기의 스위치를 조작한다. 검사 도중 환자의 상태나 움직임을 관찰하여 분석에 도움이 되도록 그래프에 표시한다. 기계의 콘덴서를 갈아 끼우는 등 간단한 고장을 수리한다. 검사 협조가 어려운 경우 및 소아환자의 경우 수면뇌파검사를 실시하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"임상병리사","dJobECd":"3061","dJobECdNm":"[3061]임상병리사","dJobJCd":"2451","dJobJCdNm":"[2451]임상병리사","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002681:1', '{"dJobCd":"K000002681","dJobCdSeq":"1","dJobNm":"심전도기사","workSum":"심장질환의 검진을 위해 심전도기계를 사용하여 심장근육에서 발생하는 전기적 편차를 기록한다.","doWork":"환자의 일정한 신체부위에 전극을 부착하고 심전도기계의 스위치를 조작하여 심장근육의 각 부위에서 발생하는 심전도의 편차를 기록한다. 심장기 운동 및 산소결핍 등으로 심장에 부담을 가하면서 심전도를 기록한다. 검사결과를 정리하여 내과의사에게 회송한다. 검사방법에 따라 활동 중 심전도 감시기구인 홀터기록기(Holter Recording)를 환자에게 부착하거나 기립경사검사(수평상태의 기립경사 테이블에 환자를 눕히고 혈압과 심박동수를 측정한 후 검사 테이블을 세운 상태에서 혈압과 심박동수를 관찰), 운동부하심전도검사(러닝머신의 경사와 속도를 높임으로써 운동량을 증가시키면서 검사)를 하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"임상병리사","dJobECd":"3061","dJobECdNm":"[3061]임상병리사","dJobJCd":"2451","dJobJCdNm":"[2451]임상병리사","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001457:1', '{"dJobCd":"K000001457","dJobCdSeq":"1","dJobNm":"인공심폐기기사","workSum":"심장수술 또는 기타 체외순환이 필요한 수술에서 인공심폐기를 조작·운용한다.","doWork":"환자를 확인하여 질환의 상태, 수술내용 등의 자료를 미리 검토한다. 인공심폐기와 순환회로를 채울 마중액을 준비한다. 체외순환 시 인공심폐기를 작동시키고 순환혈액의 양·온도, 환자의 체온조절 등에 관한 세부사항을 수술주치의 및 담당 마취의사와 협의한다. 개심술을 진행할 경우 체외순환의 진행사항 및 수술 중 시행한 측정치를 기록한다. 수술이 종료되면 인공심폐기의 작동상태를 점검하여 정비·보수하고 필요할 경우 의료장비 관련 부서에 지원을 요청한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"3061","dJobECdNm":"[3061]임상병리사","dJobJCd":"2451","dJobJCdNm":"[2451]임상병리사","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007544:1', '{"dJobCd":"K000007544","dJobCdSeq":"1","dJobNm":"임상병리사","workSum":"질병의 진단, 치료, 예후 판정에 도움을 주기 위해 혈액이나 소변, 조직 등 인체로부터 추출된 검사물을 분석하고 인체의 생리적 변화를 검사한다.","doWork":"환자상태나 정보 그리고 검사 종류를 확인한다. 검사에 대해서 대상자에게 설명하고 혈액, 소변, 대변 등을 검체한다. 원심분리, 분주, 보관 등 검체를 전처리한다. 전자현미경을 포함한 이화학적 검사장비나 기구를 사용하여 혈액학검사, 생리기능검사, 임상화학검사, 미생물검사, 진단병리검사, 면역혈청검사, 수혈검사, 핵의학 (검사) 등을 수행한다. 검사결과를 보고하고 관리하며 통계처리 한다. 검체를 관리한다. 검사기기 및 장비, 시약을 안전하게 보관하고 성능을 유지하도록 관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"수면기사, 수면다원기사","certLic":"임상병리사","dJobECd":"3061","dJobECdNm":"[3061]임상병리사","dJobJCd":"2451","dJobJCdNm":"[2451]임상병리사","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007091:1', '{"dJobCd":"K000007091","dJobCdSeq":"1","dJobNm":"폐기능검사기사","workSum":"의사의 의뢰에 따라 환자의 폐기능을 측정하기 위하여 폐기능 검사기기를 조작한다.","doWork":"환자의 성별, 나이, 신장, 체중 등을 폐기능 검사기계에 입력한다. 검사의 종류에 따라 규정된 호흡법을 환자에게 설명하고 기계에 나타난 숫자와 호흡곡선을 관찰한다. 환자의 질환에 따라 다르게 나타나는 검사의 반응을 분석하고 치료에 필요한 자료를 기록한다. 환자의 기록카드를 관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"임상병리사","dJobECd":"3061","dJobECdNm":"[3061]임상병리사","dJobJCd":"2451","dJobJCdNm":"[2451]임상병리사","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001468:1', '{"dJobCd":"K000001468","dJobCdSeq":"1","dJobNm":"한방검사기사","workSum":"한방의료기기를 이용하여 환자들의 질병 여부를 검사한다.","doWork":"한의사의 검사지시에 따라 맥진기, 양도락기(컴퓨터 경락진단기), 심전기, 체혈진단기, 내혈류검사기 등을 사용하여 환자를 대상으로 한방검사를 실시한다. 검사결과서를 작성하여 담당 한의사에게 보고한다. 한방기기의 관리상태를 점검하고 이상이 있을 경우 수리를 의뢰한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"임상병리사","dJobECd":"3061","dJobECdNm":"[3061]임상병리사","dJobJCd":"2451","dJobJCdNm":"[2451]임상병리사","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005099:1', '{"dJobCd":"K000005099","dJobCdSeq":"1","dJobNm":"진단방사선사","workSum":"환자의 상태를 정밀하게 진단하기 위하여 X-ray검사, CT검사, MRI검사, 초음파검사, 유방검사 등을 수행하고 조영술, 확장술, 삽입술, 제거술 등 중재적 시술을 한다.","doWork":"검사의 종류를 파악하고 검사에 필요한 지식을 환자에게 제공하며 준비시킨다. 검사에 필요한 시스템, 장비, 기기, 조영제, 약제 등을 점검하고 준비한다. 의사의 지식이나 처방에 따라 검사, 진단, 치료를 위해 주사를 놓는다. 방사선 촬영(검사)이나 치료를 위해 환자의 위치와 자세를 조정한다. 적정검사조건, 조사야 조절 등 방사선 장비를 조절한다. 환자의 상태를 정밀하게 진단하기 위하여 X-ray검사, 투시조영, 혈관조영, 컴퓨터 단층촬영검사(CT), 자기공명영상 촬영검사(MRI), 초음파검사, 유방검사, 골밀도검사 등을 수행한다. 혈류 증가 및 감소 등 치료 목적에 따라 조영술, 확장술, 삽입술, 제거술 등을 활용하여 중재적 시술을 한다. 얻어진 영상을 재구성하여 저장하고 필요시 하드 카피로 출력한다. 방사선 촬영(검사) 후 방사선 필름을 현상, 정착하여 세척 및 건조시키거나 형광체로 도포된 영상판을 출력, 영상처리한다. 영상의 화질평가 및 검사장비의 성능평가를 관리한다. 디지털 영상자료를 검증하고 전송한다. 필름이나 디지털 영상데이터를 관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"방사선사","certLic":"방사선사","dJobECd":"3062","dJobECdNm":"[3062]방사선사","dJobJCd":"2452","dJobJCdNm":"[2452]방사선사","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001393:1', '{"dJobCd":"K000001393","dJobCdSeq":"1","dJobNm":"초음파검사기사","workSum":"의사의 진료활동을 위해 초음파 진단장비를 사용하여 신체 내부기관의 질병, 장애 및 태아와 태반에 대한 검사업무를 수행한다.","doWork":"의사의 검사의뢰 처방에 따라 사용될 초음파 장비를 선택하고, 환자에게 검사과정 및 절차를 설명한다. 환자가 검사에 맞는 자세를 취하도록 하며, 검사부위에 적합한 초음파 탐촉자를 선택하고 초음파용 젤을 이용하여 신체부위를 검사한다. 장비의 여러 기능들을 조정하여 신체의 해부학적 구조물이 잘 보이도록 영상을 기록한다. 장비의 모니터에 보이는 영상을 저장하고 필름이나 영상정보시스템(PACS)에 출력(전송)한다. 검사 대장에 필요 사항을 기록하고 보관, 관리한다. 영상자료를 확인하고, 필름이나 영상데이터를 관리한다. 영상의 화질평가 및 검사장비의 성능을 평가·관리한다. 의사와 협의하여 필요한 경우 추가적인 초음파검사를 시행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"방사선사","dJobECd":"3062","dJobECdNm":"[3062]방사선사","dJobJCd":"2452","dJobJCdNm":"[2452]방사선사","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007445:1', '{"dJobCd":"K000007445","dJobCdSeq":"1","dJobNm":"치료방사선사","workSum":"전리 및 비전리 방사선을 이용하여 암을 치료하기 위하여 모의치료, 치료계획수립, 방사선치료 등을 수행한다.","doWork":"악성 및 악성종양의 방사선치료에 필요한 지식과 경험을 활용하여 환자에게 제공하고 준비시킨다. 방사선치료 과정에 적용되는 장비의 유지관리를 위하여 정도관리, 품질관리, 선량관리, 안전관리를 시행한다. 방사선치료에 필요한 환자 정보 수집을 위하여 전산화단층치료촬영기(CT-Sim) 및 모의치료를 시행하며, 차폐물, 보상물질, 고정기구 등을 준비하여 제작한다. 치료시작 전 치료자세, 종양조직 및 정상조직의 위치파악 등 치료계획을 수립하거나 모의치료기를 사용하여 치료계획의 적정성을 평가한다. 방사선종양학과 전문의 등과 함께 선량계산과 최적의 방사선 치료계획을 세운다. 외부 방사선치료기를 사용하여 체외 방사선치료를 시행한다. 전문의의 처방에 따라 온열치료기를 작동하여 치료를 시행한다. 밀봉된 방사성동위원소를 종양에 근접시켜 근접치료를 시행한다. 치료 및 계획과정으로부터 얻어진 영상을 분석 관리하고 결과를 전문의에게 제공하여 치료성적 향상을 위한 자료로 활용한다. 외부방사선치료기(근접)의 안정적 운영을 위하여 전위계, 이온챔버 등을 사용하여 정도관리를 한다. 치료에 사용되는 차폐물, 보상물질, 고정기구 등을 제작한다. 전산화단층촬영기(CT-Sim), 모의치료기, 근접치료기, 화상출력장치 등의 화질 및 성능을 점검하고 관리한다. 치료 및 계획과정으로부터 얻어진 영상을 분석 관리하고 결과를 의사에게 제공하여 치료성적 향상을 위해 노력한다. 환자의 매회 치료과정 자료 및 결과를 정리·분석하여 전문의에게 제공하고 환자의 기록을 관리한다. 디지털 영상자료를 검증하고 전송한다. 필름이나 디지털 영상데이터를 획득, 분석하고 과 내의 네트워크를 관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"방사선치료사","certLic":"방사선사","dJobECd":"3062","dJobECdNm":"[3062]방사선사","dJobJCd":"2452","dJobJCdNm":"[2452]방사선사","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004373:1', '{"dJobCd":"K000004373","dJobCdSeq":"1","dJobNm":"핵의학방사선사","workSum":"방사성동위원소를 이용하여 신체의 해부학적, 생리학적, 생화학적 상태를 진단하는데 필요한 검사를 시행하고, 개봉된 방사성동위원소를 이용하여 치료를 수행한다.","doWork":"핵의학검사 및 동위원소 치료과정에 필요한 정보를 환자에게 제공한다. 핵의학검사에 이용되는 의료장비(감마카메라, PET, PET/CT, PET/MRI, 방사선 계측기 등)의 정도관리를 수행하며 방사성의약품을 준비하고 관리한다. 의사의 처방에 따라 핵의학검사(뇌혈류, 뇌조, 뇌척수액루, 심근관류, 위점막, 혈관종, 간담도, 뼈, 소화기 출혈, 혈관, 각종 종양 등), 방사성동위원소 치료를 규정된 검사 및 치료방법에 따라 시행한다. 의료장비를 이용하여 얻어진 영상은 핵의학방사선사가 컴퓨터를 이용하여 핵의학과 의사가 질병을 진단 및 치료하는 데 도움이 될 수 있도록 영상을 재구성하여 필름이나 영상정보시스템(PACS)에 저장한다. 또한 저장된 영상 및 자료를 정리·분석하고 관리한다. 핵의학 의료장비의 화질 및 성능 등의 품질관리업무를 수행하여 환자에게 불필요한 방사선 피폭을 줄이는 방사선안전관리 업무를 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"방사선치료사, 핵의학기술자","certLic":"방사선사, 방사선취급감독자면허, 방사성동위원소일반면허, 방사성동위원소취급자특수면허","dJobECd":"3062","dJobECdNm":"[3062]방사선사","dJobJCd":"2452","dJobJCdNm":"[2452]방사선사","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007577:1', '{"dJobCd":"K000007577","dJobCdSeq":"1","dJobNm":"치과기공사","workSum":"치과의사의 의뢰에 따라 구강조직의 저작기능 및 외관을 개선하기 위한 치과기공물, 충전물 등을 전산설계(CAD/CAM), 삼차원(3D프린터), 주조기 등을 이용해 디자인, 제작, 가공, 수리한다.","doWork":"치과기공물 제작의뢰서에서 치과보철물의 종류 및 사용재료, 완성시간, 구조 등을 확인한다. 치과 진료실에서 전달된 작업모형을 확인하거나 체득된 인상을 토대로 돌가루나 석고가루를 인상재에 붓고 진동기를 사용하여 모형을 제작한다. 조각도, 몰딩기, 전동기, 도재분말, 납땜기 등 공구와 재료를 이용하여 조각, 몰딩(주조), 컨투어링, 도재작업 등을 하여 도재인레이 및 관교의치(크라운 및 브리지), 도재관, 국소의치, 총의치, 어태치먼트, 교정장치 등을 제작한다.전산설계(CAD/CAM), 3D프린터를 활용하여 치과기공물을 디자인 및 가공한다. 치과기공물과 충전물이 제작의뢰서에 맞게 제작 및 수리되었는지 확인한다. 연마재, 광택재, 연마기를 사용하여 연마하고 광택을 낸다. 초음파세척기, 증기세척기를 사용하여 세척한다. 교합기를 사용하여 교합 여부를 검사한다. 치과기공물 및 충전물 제작, 수리에 사용되는 도구나 재료, 장비 등을 관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"크라운기사, 의치(총의치/국소의치)기사, 도재관(포슬린)기사, 빌드업기사, 컨투어링기사, 교정기사","certLic":"치과기공사","dJobECd":"3063","dJobECdNm":"[3063]치과기공사","dJobJCd":"2453","dJobJCdNm":"[2453]치과기공사","dJobICd":"Q869","dJobICdNm":"[Q869]기타 보건업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007253:1', '{"dJobCd":"K000007253","dJobCdSeq":"1","dJobNm":"공중구강보건치과위생사","workSum":"미취학학생·청소년을 비롯한 지역주민을 대상으로 구강보건교육 및 예방치과처치를 시행한다.","doWork":"지역사회를 대상으로 구강건강, 치주상태, 우식경험도 등 구강보건 실태를 조사하여 통계치를 기록한다. 지역주민의 구강건강 증진을 위해 구강보건 행사를 개최한다. 구강보건 홍보자료를 개발하고 지역사회에 보급한다. 노인의치보철사업 등 구강보건 사업을 계획·운영·관리·평가한다. 지역주민을 대상으로 치아 홈 메우기, 불소도포하기 등 예방치과처치를 한다. 지역주민을 대상으로 불소를 이용한 구강건강관리법 등 구강건강관리에 관하여 상담한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"교육","workFunc3":"수동조작","certLic":"치과위생사","dJobECd":"3064","dJobECdNm":"[3064]치과위생사","dJobJCd":"2454","dJobJCdNm":"[2454]치과위생사","dJobICd":"Q863","dJobICdNm":"[Q863]공중 보건 의료업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001960:1', '{"dJobCd":"K000001960","dJobCdSeq":"1","dJobNm":"관리치과위생사","workSum":"치과위생사 및 보조 인력의 인사, 교육, 노무 등을 관리하고 병원경영에 참여한다.","doWork":"연간·월간 업무를 기획한다. 환자 의료서비스, 병원 내 조직 활성화 교육프로그램 등을 설계하고 실시한다. 치과위생사를 비롯한 인력의 채용·교육 등 인사에 참여한다. 치과위생사의 전문영역별로 업무를 조정한다. 보조 인력의 업무분장 및 조직의 평가 등 노무를 관리한다. 병원 시설·장비 및 환자기록관리 등 병원경영에 참여한다. 업무에 대해 관련 부서와 협의하고, 치과위생 및 치료과정과 관련하여 환자와 상담한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","similarNm":"치과위생사실장","certLic":"치과위생사","dJobECd":"3064","dJobECdNm":"[3064]치과위생사","dJobJCd":"2454","dJobJCdNm":"[2454]치과위생사","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001621:1', '{"dJobCd":"K000001621","dJobCdSeq":"1","dJobNm":"임상치과위생사","workSum":"치과 내원자를 대상으로 예방처치업무를 수행하고, 효율적인 치과진료를 위해 치과의사의 진료에 협조한다.","doWork":"환자의 병력을 검토하여 예방처치를 위한 계획을 수립한다. 스켈링(치석제거)을 한다. 불소도포 및 치면열구전색 등 예방처치를 시행한다. 치과방사선을 촬영한다. 치주, 구강내과, 구강외과, 치과보철, 치과교정, 소아치과 등 치과의사의 진료업무를 돕는다. 감염방지를 위하여 진료기구, 재료, 물품 등을 소독·멸균하고 관리한다. 의료보험을 청구한다. 치과 치료자를 대상으로 진료 후 주의사항을 교육한다. 치과 내원자를 대상으로 개인구강건강관리를 위한 식이교육 및 구강보건교육을 실시한다. 치과위생 및 치료과정과 관련하여 환자와 상담하고, 원무처리에 관여한다. 치과진료를 위한 장비 및 기구·재료 등을 구매·관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"수집","workFunc2":"서비스제공","workFunc3":"수동조작","certLic":"치과위생사","dJobECd":"3064","dJobECdNm":"[3064]치과위생사","dJobJCd":"2454","dJobJCdNm":"[2454]치과위생사","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007000:1', '{"dJobCd":"K000007000","dJobCdSeq":"1","dJobNm":"동물재활공학사","workSum":"재활보조기구를 필요로 하는 동물들에게 의지보조기와 보장구를 제작하여 장착·수리한다.","doWork":"필요한 의지 및 보조기의 종류와 사용재료를 확인 후, 환자의 신경계, 정신상태, 근골격계, 자세, 보행을 평가한다. 동물의 평가결과를 토대로 제작 상담을 하고 의지 및 보조기 제작을 위한 계획을 수립하고 동물을 관찰·측정하고 기록한다. 적합한 소켓의 제작에 필요한 재료를 선택한 후 소켓을 얻기 위해 절단단의 조건에 맞는 본뜨기 작업을 한다. 장애에 따라 의지 재료를 고른 후 진공흡입기 등을 사용하여 소켓을 제작하고 샌드페이퍼로 다듬는다. 소켓과 상지하지 관련 부품을 조립·정렬·조정하고 현가장치를 제작·부착한다. 휠체어, 보행보조기구, 자세유지보장구 등을 재봉기, 절단기, 접착제 등을 사용하여 가공·조립하여 제작한다. 제작한 의지, 보조기 등을 동물에게 장착한 후 최종 점검을 하고 보완·수정하고 환자 및 가족에게 의지보조기와 보장구의 사용법을 교육한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"3067","dJobECdNm":"[3067]재활공학 기사","dJobJCd":"2455","dJobJCdNm":"[2455]재활공학 기사","dJobICd":"Q869","dJobICdNm":"[Q869]기타 보건업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002779:1', '{"dJobCd":"K000002779","dJobCdSeq":"1","dJobNm":"보청기셀제작원","workSum":"보청기의 구성품으로 귀속에 삽입될 귀 모양의 셀(청각)을 칼, 파라핀코팅기 등을 사용하여 제작한다.","doWork":"작업명세서에 따라 제작할 보청기셀의 규격과 수량 등을 확인한다. 제작에 필요한 이비인후과 혹은 각 대리점에서 본떠진 귀 모양 귓본의 수량을 확인하여 준비한다. 칼, 파라핀코팅기, UV액 등의 원료, 공구 및 장비를 준비하여 작동 여부를 확인한다. 본떠진 귀 모양 귓본을 작업이 가능하도록 칼로 귓본의 바닥을 편편하게 자르고 카날(Canal) 끝의 솜을 제거한다. 보청기의 종류에 따라 귓본의 불필요한 부위를 칼로 제거하거나 연마기로 다듬는다. 휴지 등으로 귓본에 묻은 이물질을 제거한 후 파라핀을 코팅하고 실리콘을 부어 음각틀을 만든다. 귓본의 표면을 매끈하게 하기 위하여 파라핀 용액의 포트에 잠시 담근 후 꺼낸다. 코팅된 귓본을 원통틀에 놓고 아가액(한천)을 부은 후 한천이 굳으면 귓본을 빼낸다. UV액을 부어 한천 덮개를 덮은 후 정해진 시간만큼 조사(照射)하여 셀을 만든다. 만들어진 셀을 다음 공정으로 인계한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"3067","dJobECdNm":"[3067]재활공학 기사","dJobJCd":"2455","dJobJCdNm":"[2455]재활공학 기사","dJobICd":"C271","dJobICdNm":"[C271]의료용 기기 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;