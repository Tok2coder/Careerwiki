INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002287:1', '{"dJobCd":"K000002287","dJobCdSeq":"1","dJobNm":"혈액관리원","workSum":"혈액의 원활한 수급조절을 위하여 혈액의 출고·반납·관리업무를 수행한다.","doWork":"채혈되어 혈액원으로 운송된 혈액을 전산에 등록한다. 혈액검사규정에 따라 혈액형검사, B형간염검사, C형간염검사, 간기능검사, 매독항체검사, 에이즈검사 등을 한다. 혈액검사를 거쳐 안전성이 확인된 혈액을 냉장 또는 냉동저장장비에 저장한다. 혈액의 각 성분들이 적정한 상태에 있는지 확인하기 위하여 규정된 시간에 정기적으로 검사한다. 혈액을 규정온도로 유지시키기 위하여 저장장비의 온도조절기를 점검한다. 혈액 및 보관용기를 검사하여 부패, 침전 및 변색된 것은 폐기한다. 의료기관의 수혈요구서를 접수해서 필요한 혈액을 분석·조사하여 반출하고 반납된 혈액을 적절하게 처리한다. 플라스틱혈액백, 수혈세트 및 각종 혈액원 소모품의 재고량을 파악하고 부족분은 창고에서 공급받는다. 수혈용 이외의 혈액은 원심분리기를 사용하여 혈소판, 혈장, 적혈구 등으로 분리하여 의약품 제조용으로 사용되도록 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"임상병리사","dJobECd":"1222","dJobECdNm":"[1222]생명과학 시험원","dJobJCd":"2131","dJobJCdNm":"[2131]생명과학 시험원","dJobICd":"Q869","dJobICdNm":"[Q869]기타 보건업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007161:1', '{"dJobCd":"K000007161","dJobCdSeq":"1","dJobNm":"농산물규격관리원","workSum":"농산물의 유통능률 향상 및 공정거래를 위하여 곡류, 과실류, 채소류 등의 등급 기준과 포장재 규격에 관한 기초자료를 조사하고, 농산물의 규격관리를 위한 제반 업무를 수행한다.","doWork":"산지나 공판장 등에서 농산물 감정방법이나 유통정보 조사요령에 따라 규격을 도출하여 표준출하규격 제정 및 개정에 반영한다. 품목별 유통단위나 유통과정에서 손상을 방지할 수 있는 포장재의 강도, 신선도 유지에 필요한 포장방법을 연구한다. 적당 단위량과 포장재 치수를 도출하여 규격에 반영한다. 특정지역에서 생산되거나 특징적으로 재배된 농산물 중에서 고품질이고 특색이 있는 농산물을 대상으로 품질인정마크를 인정해 준다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"감독","workFunc3":"정밀작업","dJobECd":"1223","dJobECdNm":"[1223]농림어업 시험원","dJobJCd":"2132","dJobJCdNm":"[2132]농림·어업 관련 시험원","dJobICd":"O842","dJobICdNm":"[O842]사회 및 산업정책 행정","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004870:1', '{"dJobCd":"K000004870","dJobCdSeq":"1","dJobNm":"농산물안전성검사원","workSum":"농산물 또는 농산물 생산에 사용하는 농지, 용수, 자재 등에 잔류하거나 포함되어 있는 유해물질에 대한 안전성을 조사한다.","doWork":"농산물유통업체로부터 농산물의 잔류농약안전성에 대한 검사의뢰를 받아 검사계획을 수립한다. 출하전 산지나 판매 전 유통업체에서 시료를 채취한다. 산지에서 시료를 채취하는 경우 불시에 검사대상자에게 방문통보를 한 후 검사할 시료를 채취하여 검사대상 농업인이 공동서명을 하여 시료를 비닐팩에 밀봉한다. 시료수거내역서를 발급하여 한 장은 시료를 밀봉한 팩에 붙이고 한 장은 농업인에게 준다. 채취한 시료를 검사센터에 제출하여 다양한 검사(GC-MS/MS, GC-MS, GC-ECD, GC-NPD, HPLC 등)를 통한 잔류농약분석을 의뢰한다. 분석결과를 식품농약잔류허용기준치에 따라 성적서를 작성하여 의뢰인에게 보낸다. 잔류농약이 허용치보다 높을 때에는 불합격성적서를 발송하여 적절한 조치가 이루어지도록 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1223","dJobECdNm":"[1223]농림어업 시험원","dJobJCd":"2132","dJobJCdNm":"[2132]농림·어업 관련 시험원","dJobICd":"O842","dJobICdNm":"[O842]사회 및 산업정책 행정","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003538:1', '{"dJobCd":"K000003538","dJobCdSeq":"1","dJobNm":"농산물조사원","workSum":"농산물의 원산지표시관리, 국적식별방법 개발, 농산물의 소요량 및 작황조사, 저장곡 물의 병해충발생 상황조사 등의 업무를 수행한다.","doWork":"농·축·임산물의 국적식별을 위하여 이화학적 분석과 육안식별방법을 연구·개발한다. 원산지나 생산지를 표시하도록 지도한다. 농산물의 소요량을 조사하여 수출입농산물의 국내 부정유통을 방지한다. 주요 농산물의 작황을 시기별로 파악하여 농산물 검사 및 유통관리자료로 활용한다. 보관된 정부양곡에 발생하는 해충의 종류와 발생상황을 조사하여 저장양곡이나 부산물 등에서 발생하는 해충의 방제 및 예방의 기초자료로 활용한다. 해충으로 인한 경제적 손실량을 조사하여 농산물수급의 자료로 활용한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"1223","dJobECdNm":"[1223]농림어업 시험원","dJobJCd":"2132","dJobJCdNm":"[2132]농림·어업 관련 시험원","dJobICd":"O842","dJobICdNm":"[O842]사회 및 산업정책 행정","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006271:1', '{"dJobCd":"K000006271","dJobCdSeq":"1","dJobNm":"농업용수관리자","workSum":"농작물 재배에 필요한 농업용수를 공급하기 위하여 용수 및 수리시설물을 관리한다.","doWork":"수리시설물에 저장된 유량 및 저수량을 관리한다. 농업용수의 수질을 관리한다. 기상분석 및 기상예측 자료를 수집하여 수리시설물에 저장된 용수를 적절하게 관리한다. 수리시설물의 안전점검을 통한 안전관리를 한다. 시설물의 개·보수에 대한 계획을 수립하고 공사관리를 한다. 재해로 인한 시설물의 피해를 복구하기 위한 계획을 수립하고 시행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|","workFunc1":"조정","workFunc2":"협의","workFunc3":"정밀작업","dJobECd":"1223","dJobECdNm":"[1223]농림어업 시험원","dJobJCd":"2132","dJobJCdNm":"[2132]농림·어업 관련 시험원","dJobICd":"A014","dJobICdNm":"[A014]작물재배 및 축산 관련 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003106:1', '{"dJobCd":"K000003106","dJobCdSeq":"1","dJobNm":"농촌지도사","workSum":"농가를 대상으로 농업소득증대, 작물생산기반의 확충, 농업생산성 향상을 위해 재배기술 및 우량품종 등에 관한 교육·홍보를 실시하고 지도한다.","doWork":"농촌지도사업에 대한 장·단기발전계획을 세운다. 농업농가의 발전을 위하여 농기계, 시설사업, 특용작물재배, 농촌연료, 재배기술 등을 조사한다. 지도사업에 필요한 자료와 통계를 만든다. 홍보교육을 통하여 각종 작물재배방법을 지도하고 신품종을 보급한다. 병충해의 피해를 최소화시키기 위하여 방제적기와 방제법을 보급하고 농약안전사용을 지도한다. 농민과 농촌청소년 또는 농민후계자들을 대상으로 의식개발, 영농기술 및 경영능력 향상, 지도력의 배양을 위하여 전문교육을 실시하고 농업경영에 따른 개선점을 지도한다. 각종 농업용기계의 안전사용을 위하여 기계의 구조와 작동원리, 조정방법을 교육한다. 농민들의 건강향상을 위하여 편리하고 위생적인 생활에 대하여 교육한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"언어력|","workFunc1":"수집","workFunc2":"교육","workFunc3":"관련없음","similarNm":"농촌지도원","connectJob":"지도하는 분야에 따라 축산물지도원, 농촌생활지도사, 농업지도원, 농업기계지도원, 원예작물지도원","dJobECd":"1223","dJobECdNm":"[1223]농림어업 시험원","dJobJCd":"2132","dJobJCdNm":"[2132]농림·어업 관련 시험원","dJobICd":"O842","dJobICdNm":"[O842]사회 및 산업정책 행정","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004297:1', '{"dJobCd":"K000004297","dJobCdSeq":"1","dJobNm":"사료검사원","workSum":"배합사료, 펠릿(Pellet)사료의 품질이 완성기준에 적합한지를 검사·분석한다.","doWork":"제조 중이거나 제조된 사료제품을 육안으로 관찰하면서 신선도, 변질, 불순물의 혼합 여부, 수분함량 등을 검사한다. 채취한 견본의 품질을 검사하기 위하여 실험기구를 사용하여 분석한다. 사료의 포장상태를 검사한다. 검사·분석한 자료를 정리한다. 생산된 사료의 출하량 및 재고량을 관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"품질관리기술사, 품질경영기사, 품질경영산업기사","dJobECd":"1223","dJobECdNm":"[1223]농림어업 시험원","dJobJCd":"2132","dJobJCdNm":"[2132]농림·어업 관련 시험원","dJobICd":"C108","dJobICdNm":"[C108]동물용 사료 및 조제식품 제조업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001981:1', '{"dJobCd":"K000001981","dJobCdSeq":"1","dJobNm":"산림경영계획편성원","workSum":"소유산림의 지리상황과 현재의 산림현황을 조사·파악하고 임상별로 산림을 구획하여 연차적으로 현실림을 법정림상태로 유도하는 산림경영계획을 수립한다.","doWork":"산림의 경영상 편의를 위하여 영구림을 설정한다. 천연림(수령, 수종, 작업종)을 고려하여 임반(林班:면적, 지형을 고려하여 설정한 영구적 성질을 가진 기초적인 임지구획단위)을 구획한다. 임반별로 임상(林相:산림을 구성하는 수종)에 따라 여러 개의 소반(小班：임반 내에서 그 상태 및 취급에 차이를 둔 부분)으로 구획을 확정한다. 소반별로 지황조사(地況調査：임지의 생산력 및 경제적 가치의 판단자료를 위한 대상임지의 기후, 지세, 방위, 경사, 토성, 토양심도, 토양습도, 지위, 지리 등의 조사)와 임황조사(林況調査：산림의 상태를 조사하고 현재 생산력을 명확히 하며, 장차 영림방법을 결정하는 자료를 얻기 위한 조사)를 실시하여 임목축적조사자료를 만든다. 조사된 자료를 이용하여 도면에 임·소반구획을 표시하고 침엽수림, 활엽수림, 혼효림 등을 색깔별로 표시하고, 임목의 수령, 소밀도, 임상도(林相圖：임상별, 영급별, 입목의 구성상태와 임도, 방화선, 묘포 등의 시설현황을 표시하여 전체산림을 일목요연하게 구별할 수 있도록 작성된 도면)를 작성한다. 소반별로 면적을 계산하여 임목지, 미임목지의 면적을 기재하고 임황, 지황 및 재적 등의 생장량을 산출하여 산림조사부를 작성한다. 미임목지와 벌채지에 적당한 수종을 선택하여 조림계획을 세운다. 임목(林木：천연림, 인공림을 포함하여 임지에 생육하고 있는 개개의 수목을 말함)의 생장촉진과 우량재의 생산을 위하여 무육(밑깎기, 덩굴치기, 제벌작업 및 간벌, 가지치기작업)계획을 세운다. 산림 내의 임목을 연속적으로 생산할 수 있도록 벌채계획을 세운다. 벌채된 목재를 운반할 수 있도록 임도시설계획과 산화방지를 위하여 방화선시설계획을 수립한다. 각종 사업을 결정하고 경영방법 및 생산재의 판매시장을 계획한다. 작성된 임상도, 산림조사부, 조림벌채계획부, 사업안설명서를 종합한 산림경영계획서를 관할기관에 제출하여 인가를 받는다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"1223","dJobECdNm":"[1223]농림어업 시험원","dJobJCd":"2132","dJobJCdNm":"[2132]농림·어업 관련 시험원","dJobICd":"A020","dJobICdNm":"[A020]임업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007272:1', '{"dJobCd":"K000007272","dJobCdSeq":"1","dJobNm":"산림기술자","workSum":"산림조사, 산림경영계획서 작성 및 조림, 숲가꾸기, 벌채 등의 산림조성사업, 산림병충해방제사업, 산림욕장의 조성사업, 도시숲 등 조성관리사업, 임도, 사방, 산림복구복원사업에서 설계, 시공 및 감리 업무를 한다.","doWork":"지황조사(임목의 생육에 영향을 미치는 지형적, 환경적 특성 등을 조사), 임황조사(현재 산림의 상태를 조사하고 현재의 생산력 등을 고려하여 앞으로 경영계획구내에서의 산림경영방법을 결정할 자료를 얻기 위한 조사) 등의 산림조사를  한다. 대상 산림을 지속적이고 효율적으로 이용하기 위하여 10년 단위종합계획을 수립할 수 있도록 각종 조사 자료를 종합 분석하여 사업시기와 사업량을 계획하여 산림경영계획서를 작성한다. 대상지 선정, 대상지 표준지조사, 사업종류 결정, 시방서 작성, 원가계산서 작성, 설계도 작성 등 산림조성사업의 설계업무를 한다. 실시설계 사전 검토, 품질관리, 공정관리, 중간감리보고서 작성, 예비사업 완료검사, 감리완료 보고서를 작성 등 산림조성산업의 감리업무를 한다. 임도에 필요한 세부설계도서, 임도 설계설명서, 설계 자료 작성을 한다. 임도시공을 위한 시공계획수립, 임도시공측량 및 임도저장목 작업을 한다. 임도 토공사, 구조물공사 등 임도공사를 관리감독한다. 사방계획을 수립한다. 사방지 조사측량을 한다. 사방지 설계도서를 작성한다. 사방지 시공을 위해 착공서류 작성하기, 시공계획수립하기, 사방지시공측량하기 등 준비작업을 한다. 사방지 시공을 관리, 감독한다. 산지 복구복원 공사를 준비한다. 복구복원 시공측량, 시공관리감독, 시공감리업무를 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실외","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"산림기술자","certLic":"산림기술사(기사, 산업기사), 토목기사(산업기사), 자연생태복원기사(산업기사), 산림공학기술자, 산림경영기술자, 녹지조경기술자","dJobECd":"1223","dJobECdNm":"[1223]농림어업 시험원","dJobJCd":"2132","dJobJCdNm":"[2132]농림·어업 관련 시험원","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001351:1', '{"dJobCd":"K000001351","dJobCdSeq":"1","dJobNm":"산림조사원","workSum":"영림계획편성을 위하여 임지의 실태, 면적, 방위, 경사, 토질, 습도, 수종, 혼효율, 수령, 수고, 입목도, 재적 등을 조사한다.","doWork":"산림 내의 일정면적을 기준으로 하여 임반을 편성한다. 인공림, 천연림, 나무의 종류, 수령, 교통편의 등을 고려하여 소반(小班:산림시업상 일시적으로 구획하는 최소의 구획단위)을 구획한다. 각 소반별로 측량을 실시하여 면적을 확정한다. 조사하고자 하는 산림 내의 경사도, 토성, 토양의 깊이, 습도 등의 지황을 조사한다. 각 소반별로 표준지를 설정하고 표준지 중앙선상에 줄을 띄운 후, 줄자, 윤척(캘리퍼스), 수고측정기(크리노메타)를 사용하여 나무의 가슴높이 직경(흉고직경)과 수고를 조사한다. 재적표에 따라 표준지 내의 조사된 재적으로 소반 내 전체 재적을 구한다. 산림조사자료를 기초로 하여 당해 산림에 대한 영림계획을 수립한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|시각|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"1223","dJobECdNm":"[1223]농림어업 시험원","dJobJCd":"2132","dJobJCdNm":"[2132]농림·어업 관련 시험원","dJobICd":"A020","dJobICdNm":"[A020]임업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006203:1', '{"dJobCd":"K000006203","dJobCdSeq":"1","dJobNm":"수산종묘관리기사","workSum":"양식업을 위한 수산종묘를 생산하기 위하여 육상 또는 해상의 일정시설에서 종묘를 배양·관리한다.","doWork":"대상 품종에 따른 시설물설치계획, 세부시설물 규모, 기구 및 장비구입 계획, 플랑크톤, 배합사료, 생사료 등 먹이 및 영양공급계획 등의 생산관리계획을 수산종묘생산업자와 협의하여 수립한다. 사육이나 종묘생산시설물을 수산종묘생산업자를 지휘·감독하여 설치한다. 종묘생산용 어미를 사육동의 규모에 따라 일정수량씩 넣는다. 품종에 맞는 먹이와 영양공급계획을 세우고 사료를 조제·배합하여 공급한다. 번식을 시키기 위하여 어미로부터 채란하고 수정·부화시킨다. 현미경, 광도계, 수온계, 비중계 등을 사용하여 수온, 투명도, 종묘상태를 수시로 파악하며 건강상태를 진단한다. 필요에 따라 약품, 영양제 등을 투여하여 치료한다. 품종에 따라 자연 또는 인공적으로 채묘(採苗:천연 종묘생산의 한 과정)하고 일정기간 사육한다. 종업원들을 지휘하여 행망, 틀, 바구니, 크레인 등을 사용하여 종묘나 사상체를 채취하고 분류, 포장하는 일을 감독한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"감독","workFunc3":"유지","connectJob":"생산하는 수산종묘의 종류에 따라 어류종묘관리기사, 패류종묘관리기사, 해조류종묘관리기사, 시험하는 분야에 따라 수산양식시험원","dJobECd":"1223","dJobECdNm":"[1223]농림어업 시험원","dJobJCd":"2132","dJobJCdNm":"[2132]농림·어업 관련 시험원","dJobICd":"A032","dJobICdNm":"[A032]양식어업 및 어업관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007409:1', '{"dJobCd":"K000007409","dJobCdSeq":"1","dJobNm":"식물공장생산관리자","workSum":"식물공장에서 식물재배관리, 재배시설관리, 위성 농장 재배관리, 재배/생산관리 등을 한다.","doWork":"모니터링과 제어요소에 따른 환경계측인자를 선정한다. 시설유형 및 규모에 따라 냉난방기, 양액기 등 환경조절장치의 수준을 결정한다. 작물의 생육단계별 최적 생육환경 조건을 제공하기 위해 환경제어기의 설정값을 관리한다. 작물 생육의 주기적 측정, 수확량 측정 및 농작업 일지 작성을 통해 데이터를 축적한다. 데이터를 분석하여 작물의 생리장해 등의 원인을 추적한다. 생육, 수확량, 환경정보를 비교 분석하여 내부환경 및 작업관리 전략을 수립한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"시설원예기사","dJobECd":"1223","dJobECdNm":"[1223]농림어업 시험원","dJobJCd":"2132","dJobJCdNm":"[2132]농림·어업 관련 시험원","dJobICd":"C103","dJobICdNm":"[C103]과실, 채소 가공 및 저장 처리업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007385:1', '{"dJobCd":"K000007385","dJobCdSeq":"1","dJobNm":"식물공장설계자","workSum":"식물공장 설치를 위한 세부계획을 세우고 식물 재배에 필요한 시스템을 설계한다.","doWork":"실물공장의 위치, 운영 면적, 적용 작물 선정 등 설치에 대한 전반적인 계획 수립 및 타당성을 분석한다. LED조명, 온도와 습도, 이산화탄소 농도, 배양액 등을 고려하여 자동제어장치, 공조 장치 등 식물 성장에 필요한 조건을 제어하는 시스템을 개발한다. 설계에 따른 재배 베드, 배관 및 전기시설, 조명 등의 시공과 시험운영을 하고 안정성 점검을 한다. 실무자 대상 운영교육을 실시한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"교육","workFunc3":"정밀작업","similarNm":"인도어팜기획자","dJobECd":"1223","dJobECdNm":"[1223]농림어업 시험원","dJobJCd":"2132","dJobJCdNm":"[2132]농림·어업 관련 시험원","dJobICd":"C103","dJobICdNm":"[C103]과실, 채소 가공 및 저장 처리업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004710:1', '{"dJobCd":"K000004710","dJobCdSeq":"1","dJobNm":"어구어법기술개발원","workSum":"어획량을 높일 수 있는 어구(漁具)나 어법(漁法:수산동식물의 포획이나 채취에 쓰이는 수단방법)을 개발한다.","doWork":"특정 어구·어법의 실태를 파악하기 위하여 현지에 출장하여 조사를 한다. 모형어구를 제작하여 수조시험을 실시하고 시험결과를 분석한다. 모형어구의 시험결과를 참조하여 실물 어구제작을 위하여 설계도를 만든다. 대상 어업의 주요 조업장에서 망의 전개상태, 어구의 운용 및 어획실험을 실시한다. 수집한 자료를 컴퓨터로 처리하여 분석한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workEnv":"대기환경미흡|다습|소음·진동|","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","dJobECd":"1223","dJobECdNm":"[1223]농림어업 시험원","dJobJCd":"2132","dJobJCdNm":"[2132]농림·어업 관련 시험원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006660:1', '{"dJobCd":"K000006660","dJobCdSeq":"1","dJobNm":"어촌지도사","workSum":"어민들을 대상으로 어업정보 및 기술을 지도·보급하고, 각종 수산 관련 병·재해 예방지도를 한다.","doWork":"양식저장관리 및 병·재해 예방을 지도한다. 양식기술을 개발한다. 어병예찰진단반을 운영하여 어병관리 및 대처방법 등을 지도한다. 적조나 비브리오 등 어류 관련 질병에 관련된 샘플을 채취하여 실험·분석한다. 어업 인력을 육성하기 위해 계획을 수립하고 교육한다. 어촌정보화 인프라를 구축하고 운영한다. 어업통계조사를 실시하고 자료를 작성·보고한다. 수산기술 홍보를 위해 간행물을 발간한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"언어력|","workFunc1":"수집","workFunc2":"교육","workFunc3":"관련없음","similarNm":"어촌지도원","dJobECd":"1223","dJobECdNm":"[1223]농림어업 시험원","dJobJCd":"2132","dJobJCdNm":"[2132]농림·어업 관련 시험원","dJobICd":"O842","dJobICdNm":"[O842]사회 및 산업정책 행정","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007102:1', '{"dJobCd":"K000007102","dJobCdSeq":"1","dJobNm":"원예종묘시험원","workSum":"기후, 영농, 작물재배 조건에 맞는 원예작물의 품종을 개발·보급한다.","doWork":"새로운 품종육성을 위하여 품종 간, 유전자원 간 교배에 대해 연구한다. 토양, 기온 등의 적합한 재배조건을 조성하여 시험재배를 통하여 품종을 개량한다. 개량된 품종을 생산하여 보급한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"유지","connectJob":"화훼재배시험원, 채소재배시험원, 원예작물시험원","dJobECd":"1223","dJobECdNm":"[1223]농림어업 시험원","dJobJCd":"2132","dJobJCdNm":"[2132]농림·어업 관련 시험원","dJobICd":"A011","dJobICdNm":"[A011]작물 재배업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006144:1', '{"dJobCd":"K000006144","dJobCdSeq":"1","dJobNm":"임목조사원","workSum":"산림 내에 있는 임분재적을 측정하기 위하여 일정 면적 내의 임목을 조사한다.","doWork":"조사를 의뢰받은 산림지역을 순찰하여 표준지를 선정한다. 표준지 내의 임목에 대하여 직경을 측정하고, 수고는 수고곡선법에 의하여 측정하는 임분재적(林分材積:임분 내의 각 입목재적의 합계) 측정방법으로 측정한다. 윤척(輪尺:Calipers, 임목의 지름을 측정하는 기구)이나 줄자를 사용하여 흉고직경(胸高直徑:Diameter at Breast Height, 가슴 높이, 지표면으로부터 1.2m에서 잰 지름을 뜻함)을 측정한다. 경사진 임지 내에서는 상부를 먼저 측정한 후, 하부를 측정하여 측정내용을 작성한다. 조사된 임분을 계산하여 산림 내의 총 임분재적을 구한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"균형감각|시각|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"1223","dJobECdNm":"[1223]농림어업 시험원","dJobJCd":"2132","dJobJCdNm":"[2132]농림·어업 관련 시험원","dJobICd":"A020","dJobICdNm":"[A020]임업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002524:1', '{"dJobCd":"K000002524","dJobCdSeq":"1","dJobNm":"작물시험원","workSum":"각종 작물을 연구하는 연구원을 보조하여 작물에 대한 연구 및 조사를 수행한다.","doWork":"연구원의 지시에 따라 방법, 일정, 순서 등을 고려하여 종자의 발아, 초목의 발육, 토양과 기후에 따른 작물의 적응성, 질병과 곤충류에 대한 저항성, 수확량, 수확물의 품질 및 기타 작물의 특성 등의 자료를 조사·분석하기 위한 각종 시험을 한다. 작물의 파종, 경작, 수확, 저장, 윤작효과, 배수법, 관개 및 기후조건 등을 조사·분석하기 위한 시험을 한다. 경지의 이용성 향상 및 단기간에 생육이 가능한 신품종 개발을 위한 연구를 실시한다. 연구결과를 정리하여 보고한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|","workEnv":"저온|다습|소음·진동|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"농작물연구시험원, 임업시험원, 농경시험원, 식량작물과학시험원, 산림자원시험원, 농생물학시험원, 농업생태환경시험원, 동물자원과학시험원","dJobECd":"1223","dJobECdNm":"[1223]농림어업 시험원","dJobJCd":"2132","dJobJCdNm":"[2132]농림·어업 관련 시험원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003725:1', '{"dJobCd":"K000003725","dJobCdSeq":"1","dJobNm":"종자검정원","workSum":"좋은 종자를 판별하기 위하여 종자가 종자순도(種子純度:단일품종의 종자에 이종의 종자가 섞이지 않고 순수한 정도)기준에 맞는지를 검사한다.","doWork":"종자의 순도기준을 숙지한다. 검사대상 종자를 선정한다. 좋은 종자를 선정하기 위하여 육종대상 종자의 선정, 파종 및 생산과정을 확인한다. 원원종(품종 고유의 특성을 보유하고 종자의 증식에 기본이 되는 종자), 원종, 시판용 종자의 발아율을 조사한다. 종묘에 이물질이 포함되어 있는지에 대한 순결도를 조사한다. 검사대상 종자가 파종되어 성장하면 잎, 줄기, 열매 등을 육안으로 검사한다. 생산된 종자의 단백질 분석을 위하여 전기영동분석기를 이용하여 검사하고, 종자의 순도가 기준에 적합한지를 검사한다. 수분측정기를 사용하여 수분함량을 검사한다. 우량한 종묘를 생산 공급하기 위하여 균류를 파악하고 검사한다. 종자순도 검사사항을 정리하여 기록한다. 선정된 종자의 검사결과를 관련 부서에 보고한다. 종묘원에서 우수한 종자를 선별하기 위하여 종묘의 상태와 발아율을 검사하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|시각|","workEnv":"대기환경미흡|위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"종자순도검사원","connectJob":"종묘를 검사하는 경우 종묘검사원","certLic":"종자기능사, 종자기사, 종자기술사, 종자산업기사","dJobECd":"1223","dJobECdNm":"[1223]농림어업 시험원","dJobJCd":"2132","dJobJCdNm":"[2132]농림·어업 관련 시험원","dJobICd":"M729","dJobICdNm":"[M729]기타 과학기술 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007205:1', '{"dJobCd":"K000007205","dJobCdSeq":"1","dJobNm":"초음파육질진단사","workSum":"초음파촬영장치를 활용하여 사육 중인 육우의 육질을 측정하고 출하 시 고급육 생산을 위한 사양관리(斜陽管理:Feeding and Management)방법을 조언한다.","doWork":"농가로부터 신청을 받고 사육두수, 출하결과, 개체정보 등 사육현황을 파악한다. 농가에 방문하여 소의 개체정보를 확인하고 검사를 위해 줄로 묶는다. 소의 검사할 부분에 이물질을 제거하고 기름을 바른다. 초음파검사장비의 탐측기를 소의 검사부위에 접촉하여 초음파영상을 촬영한다. 촬영물을 판독하여 등지방두께, 단면적, 근지방도 등을 기록한다. 개체의 개월령과 무게를 측정한다. 촬영결과를 전산에 입력한다. 1차 검사, 2차 검사를 실시하여 육질등급의 변화를 분석한다. 개체별 사양프로그램에 따라 육질등급 또는 성장을 최대화하여 출하 시 수익을 높일 수 있도록 조언한다. 초음파검사장비를 활용하여 개체의 임신 여부를 확인하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"동물초음파진단사","dJobECd":"1223","dJobECdNm":"[1223]농림어업 시험원","dJobJCd":"2132","dJobJCdNm":"[2132]농림·어업 관련 시험원","dJobICd":"A012","dJobICdNm":"[A012]축산업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003707:1', '{"dJobCd":"K000003707","dJobCdSeq":"1","dJobNm":"축산업지도사","workSum":"축산업의 진흥을 위하여 새로운 축산기술 및 방법을 축산농가에 보급·지도한다.","doWork":"축산에 관한 자료를 수집·분석·평가한다. 관련 업무에 관한 전문지식, 새로운 연구결과, 연구문헌, 시험결과 등을 활용하여 새로운 기술보급을 위한 기술지도지침을 작성하고, 시범마을을 지정한다. 새로운 우량품종을 보급하고 사양관리를 지도한다. 새로운 보급사료 및 사료용 풀의 재배방법에 관한 기술지도를 한다. 신문, 방송, 잡지 등을 통하여 축산에 관한 기술 및 정보를 전달한다. 회의소집이나 세미나 등을 통하여 농민을 교육하고 영농상담을 한다. 실행내용을 평가·분석하여 도출된 문제점에 대한 개선방향을 수립한다. 현지 축산농가를 방문하여 소, 돼지, 가금 및 기타 가축들의 사료급여문제에 관해 토론하고 새로운 기술을 권장한다. 질병의 발생이나 전염방지 또는 건강을 유지하기 위하여 가축 및 가금을 검사하고 약물치료처방과 방법을 지도한다. 경제적이고 효율적인 농장운영방법에 관한 조언을 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"언어력|","workFunc1":"수집","workFunc2":"교육","workFunc3":"관련없음","similarNm":"축산업지도원","connectJob":"양잠기술지도원","dJobECd":"1223","dJobECdNm":"[1223]농림어업 시험원","dJobJCd":"2132","dJobJCdNm":"[2132]농림·어업 관련 시험원","dJobICd":"O842","dJobICdNm":"[O842]사회 및 산업정책 행정","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004344:1', '{"dJobCd":"K000004344","dJobCdSeq":"1","dJobNm":"친환경농산물인증심사원","workSum":"친환경농업육성법 시행규칙에 따라 유기농림산물, 유기축산, 무농약농산물, 무항생제축산물, 저농약농산물, 재포장과정 등 6개에 해당하는 친환경농산물인증 신청업체의 서류 및 현장조사를 통해 적합성 여부를 심사한다.","doWork":"친환경농산물인증을 받기 위한 신청서가 접수되면 심사계획을 수립하고 그 내용을 신청인에게 통보한다. 서류심사를 통해 과거 인증실적 여부를 조사한다. 인증신청서 및 첨부서류의 제출과 작성의 적정성을 검토하여 인증신청서류가 미흡한 경우에는 문서로 보완을 요청한다. 서류심사가 끝나면 현장심사를 개별생산자단위로 실시하여 경영관리, 재배포장, 용수, 종자, 재배방법, 생산관리 등이 인증기준에 적합한지 여부를 심사한다. 분석이 필요하다고 판단되는 경우 신청자의 입회 하에 재배포장의 토양 및 재배용수토비, 생산물 등의 분석을 의뢰한다. 문서심사와 현장심사가 끝나면 인증심의위원회를 열어 심의하고 인증의 승인 여부를 판정한다. 인증적합으로 판정한 경우에는 신청인에게 친환경농산물인증서를 교부한다. 인증부적합으로 판정되었을 때에는 그 사유를 명시하여 신청인에게 서면으로 통지한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"1223","dJobECdNm":"[1223]농림어업 시험원","dJobJCd":"2132","dJobJCdNm":"[2132]농림·어업 관련 시험원","dJobICd":"M729","dJobICdNm":"[M729]기타 과학기술 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004603:1', '{"dJobCd":"K000004603","dJobCdSeq":"1","dJobNm":"친환경농자재시험원","workSum":"친환경농업에 사용할 수 있는 자재를 객관적인 등록기준에 맞게 시험한다.","doWork":"친환경유기농자재 등록시험연구기관에 근무하는 경우, 친환경유기농자재의 품질 및 안전성을 시험하기 위해 작물병해충 관리용 자재 효과시험, 비료용 자재의 시험, 오염미생물 검사시험, 유효미생물 동정시험 등을 수행한다. 농약품목등록시험연구기관에 근무하는 경우, 살균제, 살충제, 제초제, 생장조정제 등의 농약품목등록을 위한 시험을 한다. 농작물이나 토양, 수중(水中), 농작업자 등에 대한 농약잔류분석시험, 국내 생산 혹은 수출입 농산물의 유통 전 잔류농약검사시험 등을 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"1223","dJobECdNm":"[1223]농림어업 시험원","dJobJCd":"2132","dJobJCdNm":"[2132]농림·어업 관련 시험원","dJobICd":"M729","dJobICdNm":"[M729]기타 과학기술 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001993:1', '{"dJobCd":"K000001993","dJobCdSeq":"1","dJobNm":"항공산림조사원","workSum":"산림기본계획을 수립하기 위하여 전국 산림에 대한 항공사진을 촬영하여 산림자원 및 수종의 분포상황을 조사한다.","doWork":"전국 산림자원을 조사하기 위하여 항공사진 촬영계획을 세운다. 비행기 내에 카메라를 설치하고, 예정비행코스, 비행속도, 고도, 촬영지역 등에 대해 비행기 조종사와 협의한다. 촬영의 효과를 높이고, 예정된 지역을 모두 촬영할 수 있도록 표준촬영조건표를 보고 촬영시간, 노출도 등의 촬영에 필요한 제반 사항을 결정한다. 기후조건을 확인하여 촬영일시를 정한다. 카메라의 셔터속도, 렌즈구경, 초점 등을 조절하고 산림을 촬영한다. 촬영된 사진을 결합시켜 사진을 제작하고 판독하여 산림지도를 작성한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"1223","dJobECdNm":"[1223]농림어업 시험원","dJobJCd":"2132","dJobJCdNm":"[2132]농림·어업 관련 시험원","dJobICd":"A020","dJobICdNm":"[A020]임업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001680:1', '{"dJobCd":"K000001680","dJobCdSeq":"1","dJobNm":"광물감정원","workSum":"암석 및 광산의 규모, 생성환경, 경제성 등을 판단할 수 있도록 광물 고유의 물리·화학적 성질을 이용하여 각종 광물을 분석·감정한다.","doWork":"광산이나 야외에서 채취한 시료를 절단·연마하여 박편 또는 연마편으로 가공한다. 분말화된 시료는 천평을 사용하여 평량하고 화학약품을 사용하여 시료를 용해시킨다. 박편을 감정하기 위하여 편광판이 제거된 상태의 편광굴절현미경을 사용하여 광물의 결정, 굴절률 차이 등을 측정한다. 편광판을 부착한 상태에서 복굴절률, 소광각, 쌍정현상, 간섭권, 광물 내에서 빛의 진동방향 등을 측정한다. 연마편을 감정하기 위해 편광반사현미경을 사용하여 편광판을 제거한 상태에서 반사된 가시광선의 색상, 광물의 벽개, 반사율 등을 측정한다. 편광판을 제거한 상태에서 광물의 등방성과 이방성을 측정한다. X-선 회절기를 사용하여 X-선 회절분석을 감정한다. 열분석기를 사용하여 비금속광물의 시차열분석과 중량감소율 등을 측정한다. 자석펜, 조흔판, 비중병, 시약, 입체현미경 등을 사용하여 광물의 물리·화학적 성질을 규명한다. X-선 형광분석기, 원자발광분광분석기, 원자흡광분석기 등의 분석기기를 사용하여 광석을 정량·정성 분석한다. 광물 채취현장의 항공사진, 열감지사진 등을 검토하여 광물의 매장규모 및 생성환경 등을 분석한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"1212","dJobECdNm":"[1212]자연과학 시험원","dJobJCd":"2133","dJobJCdNm":"[2133]자연과학 시험원","dJobICd":"M729","dJobICdNm":"[M729]기타 과학기술 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001389:1', '{"dJobCd":"K000001389","dJobCdSeq":"1","dJobNm":"광물분석원","workSum":"광석에 함유된 유용광물의 성분과 양을 확인하기 위하여 각종 분석법과 분석기기를 사용하여 정량·정성분석을 한다.","doWork":"광산에서 채취된 시료를 분석이 용이한 상태로 만들기 위하여 건조기에 넣어 수분을 제거하고, 파쇄 및 분쇄한다. 분말화된 시료를 저울을 사용하여 정량화하고 화학약품을 사용하여 시료를 용해시킨다. 시약을 첨가하여 시료 내에 포함된 성분을 확인하고 탈수·여과하여 성분별로 분리한다. 칼로리미터(열량계), 유황분석기, 자동석탄분리기 등을 사용하여 광석에 함유된 수분, 열량, 유황분, 회분 등을 분석한다. X-선 형광분석기, 원자발광분광분석기, 원자흡광분석기 등의 분석기기를 사용하여 광석을 정량·정성분석한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"1212","dJobECdNm":"[1212]자연과학 시험원","dJobJCd":"2133","dJobJCdNm":"[2133]자연과학 시험원","dJobICd":"M729","dJobICdNm":"[M729]기타 과학기술 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006977:1', '{"dJobCd":"K000006977","dJobCdSeq":"1","dJobNm":"기상감정사","workSum":"기상현상자료가 없는 지점에 대하여 인근지역의 관측자료나 수치해석자료 등을 기초로 과학적인 분석을 하여 합리적으로 추정하고 기상현상의 실상을 복원한다.","doWork":"공공부문과 민간부문에서 수집된 각종 기상정보를 분석하여 보험 및 금융분야 등의 분쟁발생 시 의사결정에 활용할 수 있도록 상세한 일기상태에 관한 종합보고서를 작성한다. 특정지역 및 기간의 기상현상에 대한 실제기록이 부재한 경우 해당 기상현상을 과학적으로 추정하고 그 기상현상이 특정사건에 미칠 수 있는 영향을 감정평가한 의견을 제시한다. 특정장소에서 주어진 기간 동안 발생한 일기상황을 재구성하여 일기브리핑을 한다. 국내 기상관측지점의 월별 기상자료를 정리하여 보고서를 작성한다. 사건장소에서 가장 가까운 기상관측소의 관측자료를 제공한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","connectJob":"날씨경영컨설턴트","certLic":"기상감정기사","dJobECd":"1212","dJobECdNm":"[1212]자연과학 시험원","dJobJCd":"2133","dJobJCdNm":"[2133]자연과학 시험원","dJobICd":"M739","dJobICdNm":"[M739]그 외 기타 전문, 과학 및 기술 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001561:1', '{"dJobCd":"K000001561","dJobCdSeq":"1","dJobNm":"기상예보관","workSum":"위성사진 등 각종 기상관측자료를 분석하여 기상전망을 발표하며 수요자에게 공급한다.","doWork":"위성사진 및 각종 기상관측자료를 취합하여 분석하고 이를 바탕으로 일기예보를 한다. 기상상황이 변화는 경우 경고예보 및 예보수정을 한다. 기류의 방향, 속도, 기압, 온도, 습도 등을 종합하여 수치모델화하고 분석한다. 분석된 기상전망자료를 항공사 등에 제공한다. 관측자료를 분석하여 장·단기 일기예보 및 기상현상에 대한 각종 주의보 및 경보 등 기상전망을 발표한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"제어조작","similarNm":"민간기상예보사","certLic":"기상예보기술사, 기상기사, 기상예보사","dJobECd":"1212","dJobECdNm":"[1212]자연과학 시험원","dJobJCd":"2133","dJobJCdNm":"[2133]자연과학 시험원","dJobICd":"M739","dJobICdNm":"[M739]그 외 기타 전문, 과학 및 기술 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006309:1', '{"dJobCd":"K000006309","dJobCdSeq":"1","dJobNm":"물리시험원","workSum":"각종 실험기계의 조작방법 및 조작절차에 따라 금속시료, 중간물, 완성제품 등의 장력, 경도, 연성 및 기타 물리적 특성을 시험·측정·분석한다.","doWork":"시험에 필요한 인장기, 충격시험기, 현미경 등 각종 실험기기의 이상 여부를 확인하고 시험에 필요한 각종 소요자재를 준비한다. 시료를 조제하기 위한 소재의 표본을 추출(Sampling)하여 분쇄·가공·혼합하고 시험용 소재를 절단하여 소정의 규격으로 가공한다. 공정분석(공정 간에 발생되는 제품성분 분석), 의뢰분석(의뢰서에 의한 자재, 부원료 등을 분석), 일반분석(제품화된 최종물에 대한 일차적 분석) 등 각종 분석의뢰를 받으면 각종 시험용 기기 및 장치를 운전·조작하여 분석하여 결과를 통보한다. 각종 시험분석결과에 대한 시험·분석 작업표준서를 작성한다. 간단한 실험장치를 제작·설치한다. 취급기기 및 장치의 일상점검과 간단한 수리 보수작업을 한다. 실험자료를 수집·정리하고 제반 실험연구를 보조한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"시험하는 전문분야에 따라 재료분석시험원, 조직분석시험원, 정밀측정분석시험원, 시험방법이나 목적에 따라 경도시험원, 하중시험원","certLic":"금속재료산업기사, 금속재료기술사, 금속재료시험기능사","dJobECd":"1212","dJobECdNm":"[1212]자연과학 시험원","dJobJCd":"2133","dJobJCdNm":"[2133]자연과학 시험원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004042:1', '{"dJobCd":"K000004042","dJobCdSeq":"1","dJobNm":"발전소연료분석원","workSum":"무연탄, 유연탄, 중유, 경유 및 LNG 등 발전소의 발전설비에 필요한 연료성분을 분석하여 발전연료로서의 타당성을 분석하는 업무를 수행한다.","doWork":"발전연료의 성분을 분석하기 위하여 시료를 채취하고, 예비검사를 하여 결과를 검수부서에 통보한다. 연료의 분석을 위한 시료를 조제하고 이를 관리한다. 연료에 대한 입하탄(유) 분석, 소비탄(유) 분석, 수당량 측정 등을 통하여 발열량 분석을 한다. 수분측정, 공업분석, 유황분 분석, 입도측정, 점도 및 인화점 분석 등을 통하여 연료로서의 타당성을 분석한다. 연료의 성분에 대한 검사결과를 검수보고서에 기록하여 발전연료관리원과 관련 부서에 통보한다. 재고탄 검사, 윤활유 및 유류분석을 실시하여 타당성 검사를 한다. 기타 연료분석과 관련된 업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"에너지관리기사, 에너지관리산업기사","dJobECd":"1212","dJobECdNm":"[1212]자연과학 시험원","dJobJCd":"2133","dJobJCdNm":"[2133]자연과학 시험원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005129:1', '{"dJobCd":"K000005129","dJobCdSeq":"1","dJobNm":"발전용수분석원","workSum":"전력생산에 필요한 용수의 성분을 분석하여 발전용수로의 적합성을 검사하고, 성분을 조정·관리하는 업무를 수행한다.","doWork":"발전용수(순수) 및 관계용수의 견본을 수집하여 성분을 분석한다. 분석한 자료를 토대로 불순물을 제거할 수 있는 대책을 수립한다. 각 설비의 부식원인 및 방지대책을 세우기 위하여 발전자재에 대한 재질분석, 결정구조분석, 부식전위, 부식율 등을 시험하여 부식환경의 원인을 조사한다. 각종 부식용액에 방식자재를 투입하여 부식전위, 전류, 부식률 등을 측정한다. 설계 및 정비부서에서 적당한 자재를 선정할 수 있도록 자료를 작성한다. 주기적으로 각종 용수의 분석자료를 검토하여 오염의 원인 및 제거방법 등을 정리하고 지침서를 작성한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|고온|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"분석·관리하는 용수의 종류에 따라 수력발전용수분석원, 원자력발전용수분석원, 화력발전용수분석원","dJobECd":"1212","dJobECdNm":"[1212]자연과학 시험원","dJobJCd":"2133","dJobJCdNm":"[2133]자연과학 시험원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007806:1', '{"dJobCd":"K000007806","dJobCdSeq":"1","dJobNm":"방사선량판독자","workSum":"원자력이용시설의 방사선작업자 개인피폭선량을 판독하기 위하여 개인선량계 판독장치, 시설 운용 및 판독, 성능검사를 한다.","doWork":"방사선작업종사자의 피폭 값을 판독하고 그 결과를 기록·관리·보고한다. 판독업무 수행을 위하여 판독기기를 유지 관리 및 검교정하고, 기기안정성을 확보한다. 선량계에 대한 정확성 확보를 위하여 주기적으로 성능검사를 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"방사선관리기술사, 원자력기사","dJobECd":"1212","dJobECdNm":"[1212]자연과학 시험원","dJobJCd":"2133","dJobJCdNm":"[2133]자연과학 시험원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003977:1', '{"dJobCd":"K000003977","dJobCdSeq":"1","dJobNm":"연구장비전문가","workSum":"과학기술 연구개발에 사용되는 전문장비의 운용, 데이터 산출 및 해석, 장비관리 등 업무를 수행한다.","doWork":"연구장비운영업무를 수행하는 경우 연구장비에 대한 소정의 교육을 이수하여 전문지식 및 기술을 보유하고, 장비를 운용하여 데이터를 산출하고 해석한다. 연구장비 유지보수 및 관리업무를 수행하는 경우 연구장비의 유지 및 보수업무를 전담하며, 진단, 부품교체, 고장수리 등 장비의 수리를 지원한다. 분석과학업무를 수행하는 경우 분석과학분야의 지식을 바탕으로 연구장비의 운용 및 연구장비를 활용한 분석기법의 개발, 장비의 개조·개량, 활용기법 개발 등의 연구를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1212","dJobECdNm":"[1212]자연과학 시험원","dJobJCd":"2133","dJobJCdNm":"[2133]자연과학 시험원","dJobICd":"M701/M702","dJobICdNm":"[M701]자연과학 및 공학 연구개발업 / [M702]인문 및 사회과학 연구개발업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002430:1', '{"dJobCd":"K000002430","dJobCdSeq":"1","dJobNm":"의료용구화학시험원","workSum":"수액세트, 주사기 등과 같이 인체에 주입·접촉하는 의료용구의 이상 유무를 검사하기 위하여 용출물시험(Migration Testing)을 한다.","doWork":"매뉴얼에 따라 시험검사에 필요한 pH미터, 전자저울(잔류물측정계기), 시험관, 시약 등 시험기구 및 시험재료를 준비한다. 수액세트, 주사기 등의 구성품을 일정한 크기로 잘라 시험관에 넣고 물을 넣어서 가열한 다음 실온이 될 때까지 방치하여 검액을 만든다. 위와 같은 방법으로 물을 사용하여 별도의 공시험액을 만들어 성상, pH, 중금속, 과망산칼륨 환원성물질, 증발잔류물 등의 시험을 실시한다. 각 시험의 기준치를 허용기준치와 비교하여 합격 여부를 판단한다. 불합격한 경우에는 상급자에게 보고하여 조치를 취하게 하고 시험결과를 기록한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"1212","dJobECdNm":"[1212]자연과학 시험원","dJobJCd":"2133","dJobJCdNm":"[2133]자연과학 시험원","dJobICd":"C271","dJobICdNm":"[C271]의료용 기기 제조업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005599:1', '{"dJobCd":"K000005599","dJobCdSeq":"1","dJobNm":"지질분석원","workSum":"댐, 교량, 터널, 주택, 고층건물 등을 건설하기 전에 기초설계 및 기초시공을 위하여 지반의 강도, 지각의 성분과 구조, 암석, 지하수 흐름 및 분포를 조사·분석한다.","doWork":"지질조사 위치를 선정하고 기존 지질도를 참고하여 보링(Boring)위치와 심도를 예상하고 작업방법, 장비종류, 비트선정, 구멍(Hole)크기 등 작업계획을 세운다. 보링반장이나 보링기운전원의 작업을 지시·감독한다. 채취된 시료(Core)를 육안으로 관찰하여 암석명, 심도, 암석색깔, 경도, 강도, 풍화정도, 균열각도(조인트)와 크랙(불규칙한 파열)의 방향성 및 크기를 분석한다. 절단기, 연마기 등을 사용하여 시료를 얇게 갈아 유리편(Slider Grass)에 붙여 현미경을 이용하여 암석의 변성정도, 입자크기, 구성성분을 알아낸다. 시료의 분석자료에 따라 지질도를 주상도(Rogging Paper)에 작성하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"지질조사기사","certLic":"응용지질기사","dJobECd":"1212","dJobECdNm":"[1212]자연과학 시험원","dJobJCd":"2133","dJobJCdNm":"[2133]자연과학 시험원","dJobICd":"F412","dJobICdNm":"[F412]토목 건설업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001575:1', '{"dJobCd":"K000001575","dJobCdSeq":"1","dJobNm":"광자기기록장치개발원","workSum":"컴퓨터, 멀티미디어장치 등에 사용되는 하드디스크 드라이브, 광자기디스크 드라이브 등의 기록장치를 연구·개발한다.","doWork":"음향, 영상, 데이터 등의 정보를 기록하는 매체(하드디스크, CD, DVD, 블루레이미디어)에 따라 관련 센서기술, 전기전자회로처리 및 모터제어기술을 사용하여 기록매체를 구동시키는 회로를 개발한다. 디지털·아날로그 신호처리기술 및 압축처리기술을 이용하여 고밀도의 데이터를 읽고 쓸 수 있는 기록장치를 개발한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"자기기록장치개발원","connectJob":"디스크드라이브개발원, 하드디스크개발원, ODD개발원, 하드디스크개발자","certLic":"전자기사","dJobECd":"1311","dJobECdNm":"[1311]컴퓨터 하드웨어 기술자 및 연구원","dJobJCd":"2211","dJobJCdNm":"[2211]컴퓨터 하드웨어 기술자 및 연구원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004916:1', '{"dJobCd":"K000004916","dJobCdSeq":"1","dJobNm":"컴퓨터메인보드설계기술자","workSum":"중앙처리장치(CPU), 입력장치, 출력장치, 기록장치, 전송장치를 효율적으로 연결하기 위하여 컴퓨터의 메인보드를 연구하여 설계한다.","doWork":"연산장치의 종류에 따라 각종 반도체의 종류와 규격을 결정한다. 마이크로프로세서, 보조프로세서, 메모리, 바이오스, 확장슬롯, 접속회로, 칩세트 등 여러 회로를 배치한다. 각종 컴퓨터 주변기기와의 호환성을 기초로, 회로 사이의 영향을 최소화한 안정적이고 경제적인 구조로 메인보드를 설계한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"컴퓨터메인보드개발원","dJobECd":"1311","dJobECdNm":"[1311]컴퓨터 하드웨어 기술자 및 연구원","dJobJCd":"2211","dJobJCdNm":"[2211]컴퓨터 하드웨어 기술자 및 연구원","dJobICd":"C263","dJobICdNm":"[C263]컴퓨터 및 주변장치 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006895:1', '{"dJobCd":"K000006895","dJobCdSeq":"1","dJobNm":"컴퓨터하드웨어설계기술자","workSum":"컴퓨터하드웨어 시스템을 설계하고, 설치 및 테스트를 한다.","doWork":"컴퓨터 이용자들의 의견을 듣고 새로운 제품을 개발하거나 제품 업그레이드에 반영한다. 컴퓨터시스템, 주변장치 및 액세서리 등 컴퓨터 하드웨어장치에 대한 전문적 지식을 바탕으로 컴퓨터하드웨어를 설계하고 개발한다. 시스템과 보드에 대해 전기적, 환경적 스트레스의 노출에 따른 기능적 작동성에 대해 시험한다. 칩, 조정장치와 같은 컴퓨터하드웨어의 제조를 감독한다. 구조입력, PC보드플로어계획, 고속신호분석 등을 수행한다. 로직디자인과 시뮬레이션을 이용하여 하드웨어제품을 검사한다. 개발프로젝트와 관련된 회의에 참석하고 보고서를 작성하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"컴퓨터하드웨어엔지니어","certLic":"전자기사, 전자계산기기사","dJobECd":"1311","dJobECdNm":"[1311]컴퓨터 하드웨어 기술자 및 연구원","dJobJCd":"2211","dJobJCdNm":"[2211]컴퓨터 하드웨어 기술자 및 연구원","dJobICd":"C263","dJobICdNm":"[C263]컴퓨터 및 주변장치 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004709:1', '{"dJobCd":"K000004709","dJobCdSeq":"1","dJobNm":"휴대폰하드웨어개발자","workSum":"휴대폰의 기능과 사양을 구현하기 위해 하드웨어를 개발하고 시험·관리한다.","doWork":"휴대폰하드웨어 개발을 위해 기능규격과 관련 인증을 파악하고 사양명세서를 작성한다. 사양명세서를 근거로 부품성능을 파악하고 부품단가를 분석하여 최적부품을 선정한다. 휴대폰하드웨어 개발에 필요한 설계기준을 설정하고 연구인력, 보유기술과 설비 등의 내부자원을 분석한다. 설계지침서와 사양명세서를 활용하여 RF부, 전원부, 센서부 등을 설계한다. 설계지침서와 사양명세서를 활용하여 디스플레이부, 인터페이스 등을 설계한다. 설계된 부분회로에 대하여 시뮬레이션을 진행하고 검증용 보드를 제작하여 시험한 결과를 근거로 문제점을 도출하고 보완한다. 주요부분에 대한 PCB를 설계하고 제작된 시제품을 시험한다. 시제품의 품질을 확보하기 위하여 시험환경에서 성능시험, 안전성시험, 환경시험을 수행한다. 관련 인증기관을 선정하고 인증절차에 따라 인증계획을 수립하여 하드웨어에 필요한 인증획득을 수행한다. 관련된 기술문서와 개발완료보고서를 작성하고 관련 자료를 배포한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"휴대폰하드웨어엔지니어, 휴대폰회로설계기술자, 휴대폰PCB설계기술자","dJobECd":"1311","dJobECdNm":"[1311]컴퓨터 하드웨어 기술자 및 연구원","dJobJCd":"2211","dJobJCdNm":"[2211]컴퓨터 하드웨어 기술자 및 연구원","dJobICd":"C264","dJobICdNm":"[C264]통신 및 방송 장비 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001657:1', '{"dJobCd":"K000001657","dJobCdSeq":"1","dJobNm":"광통신시스템개발자","workSum":"광모듈을 이용한 가입자망 또는 전송망용 광통신용시스템을 설계 및 개발한다.","doWork":"광통신시스템을 개발하기 위해 광 송신기, 광섬유, 광 수신기, 기타 소자들에 의해 두 지점 간(Point-to-Point)에 구성된 광통신용 링크, 동작 파장, 광원의 종류(LD, LED), 수광소자의 종류(APD, PIN), 목표 데이터율(전송속도), 목표 BER(비트오류율), 전송 거리, 광섬유 종류(SMF, MMF 등)를 결정한다. 전력 설계(Link Power Budget:광 손실을 극복하기 위한 전력설계, 예상 수명기간 동안 수신기 감도 이상으로 광신호전력을 수신기에 공급하려는 것)를 한다. 상승시간 설계(Rise Time Budget:또는 대역폭 설계, 광 분산에 의한 대역폭 한계를 극복하기 위한 것, 목표 비트율에서 제대로 동작 가능토록 설계하는 것)를 한다. 시제품을 개발한다. 시제품에 대한 성능 시험을 한다. 양산 이관까지 기술지원을 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"전자응용산업기술사, 전자기사, 전자산업기사","dJobECd":"1312","dJobECdNm":"[1312]통신공학 기술자 및 연구원","dJobJCd":"2212","dJobJCdNm":"[2212]통신공학 기술자 및 연구원","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006505:1', '{"dJobCd":"K000006505","dJobCdSeq":"1","dJobNm":"광통신연구원","workSum":"광통신, 광센서 및 광정보처리에 사용할 소자 및 시스템의 해석, 설계 및 측정기술을 연구·개발한다.","doWork":"광통신, 광파의 성질과 집광, 발광과 레이저, 광통신의 광원, 광변조 및 복조, 광섬유의 전송로 등을 연구한다. 광통신용 집적광학 신호처리소자, 전압측정용 광센서, 비선형 광학소자, 반도체 레이저의 초단펄스 생성 및 주파수 안정화기술 등을 연구한다. 광통신 관련 신소재를 개발한다. 광통신에 사용되는 각종 설비를 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","similarNm":"광파연구원","certLic":"정보통신기술사, 정보통신기사, 정보통신산업산업기사, 통신설비기능장","dJobECd":"1312","dJobECdNm":"[1312]통신공학 기술자 및 연구원","dJobJCd":"2212","dJobJCdNm":"[2212]통신공학 기술자 및 연구원","dJobICd":"C264","dJobICdNm":"[C264]통신 및 방송 장비 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005596:1', '{"dJobCd":"K000005596","dJobCdSeq":"1","dJobNm":"교환시설기술자","workSum":"시내외 또는 국제교환시설의 안정적 운용을 위한 제반 관리업무를 수행한다.","doWork":"전화망을 활용한 지능망사업을 추진한다. 중장기 동기신호망 구축계획을 수립하며, 동기신호망을 보강·개선한다. 전화 관련 서비스시설에 대한 투자 및 사업추진계획을 수립한다. 국간중계교환회선 시설투자 및 종합정보통신망(ISDN)시설투자 계획을 수립·집행한다. 교환기 운용기술발전을 위해 운용보전발전계획 수립 및 운용기술을 개발한다. 운용보전시설의 대·개체 기준, 공기구 및 측정기 보유기준, 운용보전지침 등 각종 기준 및 지침을 관리한다. 교환시설의 집중화 추진과 집중운용시스템개발 및 개선, 교환시설 대형고장 예방대책 등 교환시설의 안정적 운용을 위한 업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"정밀작업","certLic":"정보통신기술사, 정보통신기사, 정보통신산업기사, 통신기기기능사","dJobECd":"1312","dJobECdNm":"[1312]통신공학 기술자 및 연구원","dJobJCd":"2212","dJobJCdNm":"[2212]통신공학 기술자 및 연구원","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003044:1', '{"dJobCd":"K000003044","dJobCdSeq":"1","dJobNm":"교환장비기술자","workSum":"교환기 또는 기지국 장비의 안정적 운용과 증설에 필요한 제반 기술적 업무를 수행한다.","doWork":"교환기에 부가서비스 장비, 단문메시지서비스, 인터넷전화 등을 증설한다. 증설로 인한 버그 발생 시 원인을 파악하고 교환기 제조사에 조치를 요구한다. 기존 사용 교환기를 시험 가동하고 각종 명령어를 실행하여 적응시험을 한다. 작동의 이상 유무를 판단하여 전 기종에 새로운 프로그램을 적용한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"통신기기기능사, 정보통신기술사, 정보통신기사, 정보통신산업기사","dJobECd":"1312","dJobECdNm":"[1312]통신공학 기술자 및 연구원","dJobJCd":"2212","dJobJCdNm":"[2212]통신공학 기술자 및 연구원","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005500:1', '{"dJobCd":"K000005500","dJobCdSeq":"1","dJobNm":"도로영업시스템관리자","workSum":"고속도로 통행요금징수설비의 시설계획 및 관리계획 등을 수립한다.","doWork":"요금징수설비 소프트웨어를 개발, 운영 및 관리한다. 요금징수설비의 기계화 계획 및 시행업무를 담당한다. 논스톱 요금징수설비(NTCS:Non-stop Toll Collection System, Hi-pass System)에 대한 계획을 수립하고 설계한다. 제한차량 단속설비를 설치하고 관리한다. 소관시설의 자동화와 관련된 신기술을 조사·분석하고 이를 활용한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"고속도로통행요금징수시스템관리자","dJobECd":"1312","dJobECdNm":"[1312]통신공학 기술자 및 연구원","dJobJCd":"2212","dJobJCdNm":"[2212]통신공학 기술자 및 연구원","dJobICd":"H492/H493","dJobICdNm":"[H492]육상 여객 운송업 / [H493]도로 화물 운송업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003260:1', '{"dJobCd":"K000003260","dJobCdSeq":"1","dJobNm":"도청탐지전문가","workSum":"각종 도청방지장비를 사용하여 도청탐색서비스를 제공한다.","doWork":"의뢰인과의 상담을 통해 도청정보의 특성, 도청현장의 특성 등을 파악한다. 광역수신기, 감쇄기, 전화분석기, 케이블분석기, 전자회로탐지기 등 각종 장비를 사용하여 무선 및 유선도청장비의 설치 여부를 검색 및 탐지한다. 발견된 도청장비를 제거한다. 탐색이 완료되면 탐색결과에 대해 보고서를 작성한다. 도청방지장비를 설치하고 유지·보수업무를 하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"청각|손사용|시각|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"통신보안전문가","certLic":"전기기사, 전기산업기사, 전자기사, 전자산업기사, 정보통신기사, 전파통신산업기사","dJobECd":"1312","dJobECdNm":"[1312]통신공학 기술자 및 연구원","dJobJCd":"2212","dJobJCdNm":"[2212]통신공학 기술자 및 연구원","dJobICd":"N753","dJobICdNm":"[N753]경비, 경호 및 탐정업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002275:1', '{"dJobCd":"K000002275","dJobCdSeq":"1","dJobNm":"망관리기술연구원","workSum":"통신망을 상호연동시키고 총체적으로 관리하기 위하여 교환망, 전송망, 선로망 관리에 대한 연구를 수행하고, 지능망, 데이터통신망, 초고속정보통신망, 위성통신망, 무선통신망 등에 관련된 종합적인 망관리기술(Network Management)을 연구·개발한다.","doWork":"운용 중인 다양한 교환망의 종합관리기능과 타 망관리시스템과의 유기적 연동을 비롯한 종합적인 통신망관리체제(어떠한 상황에서도 통신망의 용량을 최대한 이용할 수 있도록 통신망의 성능을 감시하고, 필요에 따라 트래픽의 유입을 제어하는 조치를 취하는 기능)의 구축에 관해 연구·개발한다. 통신망관리 및 운용보전코드 표준화와 관련 시스템을 개발한다. 각종 전송망 및 시설운용관리를 위한 집중적인 관리감시 제어기술을 연구한다. 교환, 전송, 선로 관련 집중운용보전시스템을 개발한다. 데이터망 운용관리기술을 개발한다. 운용 관련 진단 및 운용효율화 방안, 시스템 간 연동 등에 관한 연구한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"청각|손사용|시각|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"제어조작","connectJob":"통신지능망연구원","certLic":"정보통신기술사, 정보통신기사, 정보통신산업기사","dJobECd":"1312","dJobECdNm":"[1312]통신공학 기술자 및 연구원","dJobJCd":"2212","dJobJCdNm":"[2212]통신공학 기술자 및 연구원","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001570:1', '{"dJobCd":"K000001570","dJobCdSeq":"1","dJobNm":"무선시설기술자","workSum":"시내외 무선망 구축을 위한 중장기 및 연도계획 수립, 무선시설 건설 및 공급계획 수립, 시공품질관리 및 공정관리, 무선시설의 기술기준, 표준공법, 규격을 제·개정한다.","doWork":"무선시설의 운영보전계획을 수립하고 관리한다. 공급회선 집계, 시설 수요공급 계획 및 예산을 바탕으로 무선통신망 건설계획을 수립한다. 특수무선에 대한 투자계획을 수립한다. 각종 연구과제 수립 및 추진을 통하여 무선통신기술을 개발한다. 시내외 무선시설의 원활한 운용을 위한 운용보전 계획수립, 운용보전 기술기준 및 각종 제도개선, 운용인력 양성 및 유지보수용 측정기 기준설정, 노후시설의 대체 등 제반 업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"무선설비기사, 무선설비산업기사, 무선설비기능사, 전파통신기사","dJobECd":"1312","dJobECdNm":"[1312]통신공학 기술자 및 연구원","dJobJCd":"2212","dJobJCdNm":"[2212]통신공학 기술자 및 연구원","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003131:1', '{"dJobCd":"K000003131","dJobCdSeq":"1","dJobNm":"무선인터넷연구원","workSum":"무선인터넷을 구축하기 위한 애플리케이션 플랫폼, 인프라, 단말기 등에 관한 연구를 수행한다.","doWork":"게임, 방송, 전자상거래, 멀티미디어, 메시지, 커뮤니티 위치정보 등과 관련된 애플리케이션 플랫폼의 개발을 연구한다. 무선인터넷의 네트워크를 설계하고 연동시킨다. 증권, 오락, 게임, 멀티미디어, 전자상거래 등을 위한 무선인터넷 단말기를 연구한다. 무선인터넷 플랫폼의 트래픽을 예측하고 용량을 기획한다. 무선인터넷 인프라의 통합을 연구한다. 무선인터넷의 품질관리기술을 연구한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"정보통신기술사, 정보통신기사, 정보통신산업기사","dJobECd":"1312","dJobECdNm":"[1312]통신공학 기술자 및 연구원","dJobJCd":"2212","dJobJCdNm":"[2212]통신공학 기술자 및 연구원","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005409:1', '{"dJobCd":"K000005409","dJobCdSeq":"1","dJobNm":"무선중계시설기술자","workSum":"기지국의 신설을 위하여 전파를 측정하여 설치장소를 선정하고, 통신중계국 시설용량을 설정하며 공사를 관리한다.","doWork":"통신중계시설계획을 수립한다. 기지국을 신설하기 유리한 지역인 높은 곳을 임의로 선정한다. 무선환경측정장비(EMDM:Enhanced Mobile Diagnostic Monitor)를 이용하여 이동전화신호를 발사하고 차량에서 신호세기를 측정한다. 적절한 위치가 선정되면 계약을 무선망관제원에게 요구한다. 트래픽분석에 의한 사용량을 산출하여 기지국 용량을 결정한다. 원가분석을 통해 기지국의 개폐, 보정을 결정한다. 장비의 규격 및 설계대로 시공되었는지 설치공사를 감독한다. 장비설치 완료 시 인수시험을 하고 기지국운용원에 통보한다. 무선국 허가검사를 받는다. 중계기의 시설공사를 한다. 서비스지역을 측정하고 전파지도를 작성하여 관리한다. 기지국공용화업무를 수행한다. 타 회사지역의 기지국공용화를 위하여 문서를 발송하고 허가를 취득하여 기지국 장비를 설치한다. 타 회사가 기지국 이용을 요구하면 타당성을 검토하고 기지국 장비에 영향을 주는지를 확인한다. 기지국에서 교환기에 이르는 전송로를 확보한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"무선전화기술원","certLic":"무선설비기사, 무선설비산업기사, 무선설비기능사, 전파통신기사","dJobECd":"1312","dJobECdNm":"[1312]통신공학 기술자 및 연구원","dJobJCd":"2212","dJobJCdNm":"[2212]통신공학 기술자 및 연구원","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005195:1', '{"dJobCd":"K000005195","dJobCdSeq":"1","dJobNm":"무선통신망관리원","workSum":"무선통신망 또는 이동통신망을 점검 및 관리하고 장애진단을 하여 복구한다.","doWork":"무인기지국을 운영하고 운영실태를 파악한다. 장애발생 시 대형 장애방지를 위한 신속한 복구체계를 확립한다. 주요 네트워크 구성요소 트래픽 폭주 및 전산시스템의 과부하 발생 시 라우팅, 전화차단 등의 커맨드를 시스템에 내림으로써 사고파급을 억제한다. 전국망 소통상태 및 장애를 실시간 감시제어하고 장애사항을 데이터베이스화하여 관리한다. 주요 장애에 대한 트러블 보고서를 작성하고 분석하여 대책을 수립한다. 망구성 요소에 대한 실시간 시험 및 진단을 하고 원격제어를 한다. 중장기통신망(지능망, 신호망)계획을 수립한다. 교환장비, 신호장비의 시험을 지원하고 계획을 한다. 교환장비 성능을 개선한다. 고객의 평균사용시간, 접속횟수 등의 분석과 가입자 수의 예측데이터 송신지역통계를 이용하여 장비 설계용량기준을 설정하고 교환망 설계기준, 신호망 구성계획, 상호접속망 계획을 수립한다. 번호계획을 수립하고 중장기 통신망 및 교환망을 계획한다. 각종 네트워크구성요소(NE)에 접속하여 시험하고 보완한다. 신호망 연동 및 공통선신호방식적용을 지원한다. 음성메시지서비스(VMS:Voice Message Service), 단문메시지서비스(SMS:Short Message Service), 가입자위치등록(HLR:Home Location Register) 등의 부가장비들의 용량분석 및 증설을 한다. 다양한 이동통신시스템의 부가서비스 연동을 추진한다. 가상사설망(VPN:Virtual Private Network) 서비스 기능추가를 추진한다. 기지국데이터를 설계하고 라우팅테이블(Routing Table)의 설정 지침을 수립한다. 중장기 회선수요를 산출한다. 전송로의 구성을 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"무선설비기사, 무선설비산업기사, 무선설비기능사, 정보통신기사, 정보통신산업기사, 정보통신기능사, 전파통신기사, 전파통신산업기사, 전파통신기능사","dJobECd":"1312","dJobECdNm":"[1312]통신공학 기술자 및 연구원","dJobJCd":"2212","dJobJCdNm":"[2212]통신공학 기술자 및 연구원","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006362:1', '{"dJobCd":"K000006362","dJobCdSeq":"1","dJobNm":"무선통신연구원","workSum":"차세대이동통신 기술, 무선전송 기술, 무선망 기술 등 무선통신 분야 전반에 걸쳐 연구·개발한다.","doWork":"기존망과의 연동을 통한 초고속서비스 제공을 목표로 하는 차세대 이동통신서비스(IMT2000), 블루투스(Bluetooth:기존의 통신기기, 가전 및 사무실기기들의 종류와 상관없이 Multi-Purpose한 접속을 가능토록 하는 근거리무선통신기술) 등의 신기술을 연구·개발한다. 유선선로 구축이 어려운 지역에 서비스를 제공하기 위하여 기존의 유선선로에 무선전송기술을 사용한다. 사무실이나 주택의 단말장치에 음성, 데이터, 동영상 등을 제공하는 초고속무선용시스템을 개발한다. 무선사업지원과 효율적인 설비투자방향 제시, 서비스 품질향상을 위한 무선망 설계 및 최적화 시스템 개발, 무선통신망의 진화 및 발전방안에 대한 연구, 무선망의 안정적인 운용을 위한 무선망 운용체계 수립, 운용관리시스템 연구 등을 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"통신신호처리연구원","certLic":"무선설비기사, 무선설비산업기사, 무선설비기능사, 전파통신기사","dJobECd":"1312","dJobECdNm":"[1312]통신공학 기술자 및 연구원","dJobJCd":"2212","dJobJCdNm":"[2212]통신공학 기술자 및 연구원","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004893:1', '{"dJobCd":"K000004893","dJobCdSeq":"1","dJobNm":"무전기기술자","workSum":"전기·전자기기에 관한 지식을 활용하여 민간용·산업용 무전기기를 설계·제작한다.","doWork":"제품생산에 대한 정보를 입수하고 확인한다. 새로운 모델을 제작하기 위한 부품의 종류 및 사양, 제품명세서 등을 작성하고, 회로도를 작성한다. 제작된 견본의 전기적·기구적 문제점을 점검하고 특성을 시험하고 문제점을 해결한다. 대량생산을 위한 작업공정도, 작업지도서 등을 작성하고 고정구를 제작한다. 계측기기를 공정에 따라 재조정한다. 생산 시 문제점을 파악하고 조치한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"무선설비기사, 무선설비산업기사, 무선설비기능사, 전자기사, 전파전자기사, 전파전자산업기사","dJobECd":"1312","dJobECdNm":"[1312]통신공학 기술자 및 연구원","dJobJCd":"2212","dJobJCdNm":"[2212]통신공학 기술자 및 연구원","dJobICd":"C264","dJobICdNm":"[C264]통신 및 방송 장비 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003864:1', '{"dJobCd":"K000003864","dJobCdSeq":"1","dJobNm":"방송기술연구원","workSum":"라디오 또는 텔레비전 방송의 시스템 및 제작기법을 연구·개발한다.","doWork":"외국의 신기술 방송매체에 대한 자료를 수집하여 국내의 방송기술과 비교·검토한다. 신기술의 국내 적용방법을 모색하고 송출과 제작에 관련된 방송시스템을 연구·개발한다. 새로운 조명기기, 영상기기, 음향기기 등과 이에 따른 제작기법을 연구·개발한다. 융합형 TV포털 연구(지상파 데이터TV망과 인터넷망을 결합), 모바일 및 DTV방송 연구(데이터 TV 중계기, 차세대 모바일방송), 콘텐츠 인프라 연구(디지털콘텐츠 활용기술, IP미디어 응용기술), 실감방송 연구(HD급 3차원 입체영상, 초고화질 송수신규격 (UHDTV:Ultra High Definition TV)) 등에 대한 연구를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"1312","dJobECdNm":"[1312]통신공학 기술자 및 연구원","dJobJCd":"2212","dJobJCdNm":"[2212]통신공학 기술자 및 연구원","dJobICd":"J601/J602","dJobICdNm":"[J601]라디오 방송업 / [J602]텔레비전 방송업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002926:1', '{"dJobCd":"K000002926","dJobCdSeq":"1","dJobNm":"방송대외협력기술자","workSum":"방송기술의 발전을 위하여 방송 관련 국제회의 업무와 외국 방송사와의 교류업무를 수행한다.","doWork":"국내외 방송기술분야의 신기술에 대한 정보교류 및 방송기술개발 관련 경험을 공유하기 위하여 국내외 방송 관련 회의에 참석한다. 방송기술 교류업무를 수행한다. 대외적 홍보업무 및 업무협조를 위해 외국방송국과 교류한다. 국제회의, 방송장비전시회, 제작사 연수, 방송기술분야 연수 등에 대한 출장업무를 수행한다. 외국방송사와 정보교류 및 업무협조체제를 유지한다. 방송기술정보지 발간업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"1312","dJobECdNm":"[1312]통신공학 기술자 및 연구원","dJobJCd":"2212","dJobJCdNm":"[2212]통신공학 기술자 및 연구원","dJobICd":"J601/J602","dJobICdNm":"[J601]라디오 방송업 / [J602]텔레비전 방송업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004238:1', '{"dJobCd":"K000004238","dJobCdSeq":"1","dJobNm":"방송망운영기사","workSum":"중앙방송국과 지방방송국이 같은 방송을 송출할 수 있도록 유무선으로 연결된 방송망을 운영 및 관리한다.","doWork":"전국방송망시설을 사용하여 방송신호를 송출한다. 방송신호의 루트를 선정한다. 방송 서비스구역을 선정한다. 난시청지역을 조사하고 난시청 해소업무를 수행한다. 방송국 침수와 같은 비상사태 발생 시에 이동송신차를 투입시키는 등 비상대책을 수립한다. 해외방송루트를 조정한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"1312","dJobECdNm":"[1312]통신공학 기술자 및 연구원","dJobJCd":"2212","dJobJCdNm":"[2212]통신공학 기술자 및 연구원","dJobICd":"J601/J602","dJobICdNm":"[J601]라디오 방송업 / [J602]텔레비전 방송업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003170:1', '{"dJobCd":"K000003170","dJobCdSeq":"1","dJobNm":"방송설비기술자","workSum":"라디오와 텔레비전 방송설비의 구입·설치·보수에 관련된 활동을 지시·조정한다.","doWork":"방송설비 및 방송방식의 효율성, 기술적인 개선 등을 고려하여 새로운 방송설비의 증설 또는 구입의 타당성을 평가한다. 새로운 방송설비의 개발에 따른 관련 장비의 배치, 회로설계에 관련된 활동을 수행하거나 지시한다. 각종 계측장비를 사용하여 스튜디오설비, 국내외 중계설비, 프로그램운영설비 등의 정상작동 여부를 점검하고 이상이 발생하면 보수를 지시하거나 직접 수리하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"방송통신기사","dJobECd":"1312","dJobECdNm":"[1312]통신공학 기술자 및 연구원","dJobJCd":"2212","dJobJCdNm":"[2212]통신공학 기술자 및 연구원","dJobICd":"J601/J602","dJobICdNm":"[J601]라디오 방송업 / [J602]텔레비전 방송업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002961:1', '{"dJobCd":"K000002961","dJobCdSeq":"1","dJobNm":"방송통신기기설계원","workSum":"방송용 통신기기(중파, 단파 등)를 제작하기 위한 주파수별·용량별 회로도를 설계한다.","doWork":"수주된 방송통신설비의 주파수, 용량에 따라 기술자료, 서적, 무선설비에 관한 지식 등을 이용하여 개략도를 작성한다. 설비의 크기에 따라 설비케이스 도면을 작성한다. 작성된 개략도에 따라 상세회로 도면을 작성하고 회로설계 및 회로기판(PCB)을 설계한다. 제작된 부품이나 구매한 기기, 부품 등을 시험한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"송신기기설계원, 방송설비설계원","certLic":"방송통신기사, 방송통신산업기사","dJobECd":"1312","dJobECdNm":"[1312]통신공학 기술자 및 연구원","dJobJCd":"2212","dJobJCdNm":"[2212]통신공학 기술자 및 연구원","dJobICd":"C264","dJobICdNm":"[C264]통신 및 방송 장비 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002068:1', '{"dJobCd":"K000002068","dJobCdSeq":"1","dJobNm":"보안시스템기술자","workSum":"보안관제기기, 유무선망 등의 보안시스템을 설치하고 관리한다.","doWork":"신호해독기(Decoder), 무정전전원장치(UPS) 등의 관제기기를 관리한다. 무선국 및 이동무선국 무선망의 신규·변경허가와 검사, 설치 등의 관리업무를 수행한다. 유선통신망에 대하여 특정통신회선 사용청약서를 작성하여 통신회사와 전용선계약을 맺는다. 계약을 맺은 유선통신망을 관리한다. 신호해독기의 회선개통을 점검하고 단자에 이상이 발생하면 문제점을 처리한다. 단자함의 해독기(MDF Decoder)를 관리한다. 보안시스템의 일반하자를 보수하고 악성오류를 처리한다. 상주기계(Local) 및 순수기계(Rental)를 관리한다. 기기를 관리하고 철거하거나 사례집을 발간하고, 협력업체의 직원에게 기술에 대한 내용을 설명하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"1312","dJobECdNm":"[1312]통신공학 기술자 및 연구원","dJobJCd":"2212","dJobJCdNm":"[2212]통신공학 기술자 및 연구원","dJobICd":"N753","dJobICdNm":"[N753]경비, 경호 및 탐정업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003330:1', '{"dJobCd":"K000003330","dJobCdSeq":"1","dJobNm":"사물인터넷개발자","workSum":"사물에 센서와 통신기능을 내장해 사물끼리 인터넷을 통해 실시간으로 데이터를 주고받는 기술이나 환경을 개발한다.","doWork":"센서와 스마트기기를 결합하여 개인에게 필요한 용도로 사용할 수 있도록 개발한다. USB, 블루투스, Wifi, NFC(Near Field Communication:근거리 통신망) 등의 네트워크를 활용하여 센서와 사물인터넷의 서비스 인터페이스 기술을 개발한다. 체중, 혈당, 혈압 등 환자와 관련된 생체정보를 유무선통신을 통해 스마트폰으로 전송할 수 있도록 하는 애플리케이션 등을 개발한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"1312","dJobECdNm":"[1312]통신공학 기술자 및 연구원","dJobJCd":"2212","dJobJCdNm":"[2212]통신공학 기술자 및 연구원","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003769:1', '{"dJobCd":"K000003769","dJobCdSeq":"1","dJobNm":"셋톱박스개발자","workSum":"초고속인터넷을 이용하여 정보서비스, 동영상 콘텐츠 및 방송 등을 텔레비전으로 수신하기 위한 IPTV(Internet Protocol TeleVision) 셋톱박스(Set Top Box:디지털망을 통해 비디오서버로부터 전송된 압축신호를 원래의 영상 및 음성신호로 복원해 주는 장치)를 개발한다.","doWork":"하드웨어개발자는 마이크로프로세서, SoC(System on a Chip) 등을 기반으로 하는 셋톱박스 하드웨어를 설계한다. 개발된 셋톱박스(Set Top Box)가 악조건 속에서도 안정적이고 오랫동안 작동하는지 고온테스트, 에이징 테스트(Aging Test:제품 출하 전에 고압 등 한계상황에서 견뎌낼 수 있는지 확인하는 가혹검사) 등의 각종 테스트를 통하여 하드웨어의 안정성을 평가한다. 화질, 음질과 같은 품질을 테스트하고 개선하는 일을 하기도 한다. 소프트웨어개발자는 셋톱박스의 하드웨어에 저장되어 하드웨어를 제어하는 펌웨어를 비롯해 동영상, 게임, 인터넷전화 등이 구동될 수 있도록 하는 응용소프트웨어를 개발하며, 디버깅(Debugging:오류 수정)을 통해 개발된 소프트웨어가 올바로 작동되도록 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"IPTV셋톱박스개발자, 셋톱박스설계운영기술자","connectJob":"디지털방송장비개발자, IPTV개발자, 디지털수신기개발원","certLic":"전자기사, 무선설비기사, 정보처리기사","dJobECd":"1312","dJobECdNm":"[1312]통신공학 기술자 및 연구원","dJobJCd":"2212","dJobJCdNm":"[2212]통신공학 기술자 및 연구원","dJobICd":"C265","dJobICdNm":"[C265]영상 및 음향기기 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004315:1', '{"dJobCd":"K000004315","dJobCdSeq":"1","dJobNm":"영상통신연구원","workSum":"영상정보의 효과적인 전달 및 저장을 위한 신호처리기법과 전송시스템을 연구·개발한다.","doWork":"텔레비전 신호의 데이터압축, 영상신호처리 및 패턴인식, 전송선로부호, 고선명텔레비전(HDTV)신호압축, 멀티미디어(Multimedia)통신, 화상통신 등 광대역 통신시스템과 실시간 영상신호처리기법 등을 연구한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"1312","dJobECdNm":"[1312]통신공학 기술자 및 연구원","dJobJCd":"2212","dJobJCdNm":"[2212]통신공학 기술자 및 연구원","dJobICd":"C265","dJobICdNm":"[C265]영상 및 음향기기 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003910:1', '{"dJobCd":"K000003910","dJobCdSeq":"1","dJobNm":"위성통신망감리원","workSum":"발주자를 대신하여 위성통신망 시공자를 기술지도하고 설계도서 및 관계법령에 따라 품질관리, 공정관리, 공사비관리 등을 감리한다.","doWork":"위성통신망사업 발주자의 요구사항 및 설계도서와 현지여건 등을 사업목적과 비교, 분석하여 사업관리계획서를 작성한다. 위성통신망 설계도서(설계도서, 내역서, 설계설명서, 시방서 등)를 검토한다. 국내외 위성통신망 관련 법령 및 표준, 기술기준을 검토한다. 위성통신망 구축 공사의 착공, 시공, 준공단계에서 착공계 검토, 일상감리, 준공검사 관련 업무를 진행하여 품질관리, 공정관리, 공사비관리 등을 감독하고 기술지원을 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"1312","dJobECdNm":"[1312]통신공학 기술자 및 연구원","dJobJCd":"2212","dJobJCdNm":"[2212]통신공학 기술자 및 연구원","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001604:1', '{"dJobCd":"K000001604","dJobCdSeq":"1","dJobNm":"위성통신망설계기술자","workSum":"위성통신망시스템의 지상국 및 중계국과 위성체의 원활한 네트워크서비스를 제공하기 위한 위성통신망을 설계한다.","doWork":"위성통신망의 운영을 위한 사용주파수, 시스템장비 구성, 링크해석, 서비스 및 응용분야, 관련 기술기준 및 법규, 최신기술동향 등을 파악한다. 위성통신망서비스의 목적별로 시스템 구성방식, 서비스 구축방안을 검토하고, 적합한 하드웨어를 결정한다. 설계할 위성통신망의 적법성, 경제성, 기술적 타당성을 검토한다. 위성탑재체의 통신부속시스템(위성안테나, 중계기), 자세 및 궤도제어, 원격상태, 전력 및 온도제어시스템, 원격상태추적, 위성제어센터, 궤도 내 시험, 지구국의 안테나, 안테나 추적방식 등을 설계한다. 설계도서를 작성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"1312","dJobECdNm":"[1312]통신공학 기술자 및 연구원","dJobJCd":"2212","dJobJCdNm":"[2212]통신공학 기술자 및 연구원","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001445:1', '{"dJobCd":"K000001445","dJobCdSeq":"1","dJobNm":"위성통신망시공기술자","workSum":"위성통신망시스템의 지상국 및 중계국의 네트워크 개통 및 서비스 구현을 위한 네트워크망을 구축·시공한다.","doWork":"위성통신망을 구축하기 위한 구매사양서를 분석한다. 환경영향(위성지구국 구축 시 주파수 송수신에 필요한 환경, 지구국 공사 시 민원, 환경악화에 따른 우회루트 확보기술 등)을 분석한다. 전송 및 교환시스템 구축공사(안테나시스템 공사, 전송로 공사, 통신장비실 공사, 위성통신망 교환시스템 및 관련 네트워크 공사 등)를 진행한다. 연계서비스망시스템을 구축공사를 진행한다. 시운전시험(지구국 간 개통 및 용량 점검, 안테나트레킹 및 송수신레벨, 주전송로 테스트, 전파혼신, 전원안전성 점검 등)을 한다. 준공 관련 업무(준공계, 내역서, 도면, 사진첩, 성능테스트보고서 작성 등)를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"1312","dJobECdNm":"[1312]통신공학 기술자 및 연구원","dJobJCd":"2212","dJobJCdNm":"[2212]통신공학 기술자 및 연구원","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004642:1', '{"dJobCd":"K000004642","dJobCdSeq":"1","dJobNm":"위성통신망운용원","workSum":"인공위성을 이용한 통신망을 운용한다.","doWork":"위성체를 발사하기 전 중계기를 지상에서 테스트한다. 위성발사 후 궤도상의 중계기 성능을 테스트한다. 신규서비스의 발생 시 주파수대역과 파워를 배분하여 전송계획을 수립한다. 각 지국의 인증시험을 하고 송출장비의 안전도를 시험하는 개통시험을 실시한다. 인공위성에 캐리어로 탑재된 중계기의 성능을 시간대별로 분석·감시한다. 지국별로 정해진 주파수 파워의 운용상태를 CSM(Communication System Monitor)을 통해 감시하고 관리한다. 정해진 주파수와 파워의 범위를 넘어 사용하는 지국에 대한 적발과 사후조치를 실시한다. 실험, 연구 등 불법캐리어에 대한 탐지시험을 하고, 적발 시 적절한 조치를 실시한다. 가입자의 커리어 및 지구국의 이력에 대한 관리를 한다. 위성망 운용상의 문제점을 분석한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"방송통신기사","dJobECd":"1312","dJobECdNm":"[1312]통신공학 기술자 및 연구원","dJobJCd":"2212","dJobJCdNm":"[2212]통신공학 기술자 및 연구원","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002929:1', '{"dJobCd":"K000002929","dJobCdSeq":"1","dJobNm":"위성통신설비연구원","workSum":"위성의 관제 및 제어기술, 위성신호의 전송방법, 신호처리기술 등을 연구·개발한다.","doWork":"위성신호의 전송특성, 위성통신의 특성 및 위성주파수 활용, 위성안테나의 설계 및 제작, 위성관제 및 위성망제어기술, 차세대 위성용 관제설비, 중계기와 지상국과의 회선제어기술 등을 연구·개발한다. 위성의 자세 및 기능, 위성통신서비스에 관련된 각종 설비 등을 연구·개발하기도 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"지상시스템연구원","dJobECd":"1312","dJobECdNm":"[1312]통신공학 기술자 및 연구원","dJobJCd":"2212","dJobJCdNm":"[2212]통신공학 기술자 및 연구원","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006909:1', '{"dJobCd":"K000006909","dJobCdSeq":"1","dJobNm":"이동통신단말기구시험원","workSum":"이동통신 단말기구의 조립과정에서 발생하는 불량과 기구의 신뢰성을 시험한다.","doWork":"신뢰성 기준과 시험장비 및 시험방법을 숙지한다. 이동통신단말기구에 대해 낙하 시 화면이나 기구의 벌어짐 등이 발생하는지(낙하시험), 고온·고습·저온을 반복하여 기구의 뒤틀림·변색·벌어짐 등이 발생하는지(열충격시험), 기구 틈새로 먼지 등이 유입되어 화면 및 카메라 등에 들어가는지(분진시험)를 시험한다. 이동통신단말기구에 대해 염분을 포함한 대기에 대한 제품의 저항성·내열화성·보호피막의 품질·균일성 시험(염수분무시험), 힌지(Hinge)의 내구성시험(개폐시험)을 실시한다. 시험이 끝나면 신뢰성 시험보고서를 작성한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"1312","dJobECdNm":"[1312]통신공학 기술자 및 연구원","dJobJCd":"2212","dJobJCdNm":"[2212]통신공학 기술자 및 연구원","dJobICd":"C264","dJobICdNm":"[C264]통신 및 방송 장비 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005796:1', '{"dJobCd":"K000005796","dJobCdSeq":"1","dJobNm":"이동통신단말보드개발자","workSum":"이동통신 단말제품에 사용되는 회로를 설계하고 인쇄회로기판(PCB:Printed Circuit Board)을 개발한다.","doWork":"이동통신 단말제품의 기획의도에 맞는 베이스밴드(Baseband:특정 반송파를 변조하기 위해 사용되는 모든 신호에 의해 얻어지는 주파수 대역. 기저대역) 부품을 선정한다. 블록다이어그램(자동제어계의 각 요소를 블록으로 나타내어 입출력신호 사이의 관계를 나타내는 계통도)을 작성한다. 회로를 설계하고 회로도를 작성한다. 설계된 부품들의 사이즈 및 회로 난이도를 고려한 인쇄회로기판(PCB:Printed Circuit Board)을 결정한다. 부품목록을 작성한다. 부품을 배치한다. 인쇄회로기판(PCB) 패턴을 레이아웃하고 전원 회로단패턴, 주요 시그널패턴, 전자파장애 방지패턴, 정전기 방지패턴 등 각종 패턴을 설계한다. 인쇄회로기판(PCB) 보드재질 및 유전율에 따른 기판을 선정하고 부품특성, 부품 간 간섭 및 전원 노이즈, 열발생 등을 고려해서 인쇄회로기판(PCB)을 완성한다. 완성된 인쇄회로기판(PCB)의 성능개선 및 성능 테스트를 실시한다. KCC인증(방송통신기기인증) 및 해외인증을 취득하기 위하여 인증에 필요한 서류를 작성하고 테스트 시료를 준비한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"통신회로설계기술자, PCB개발자, PCB회로설계기술자","dJobECd":"1312","dJobECdNm":"[1312]통신공학 기술자 및 연구원","dJobJCd":"2212","dJobJCdNm":"[2212]통신공학 기술자 및 연구원","dJobICd":"C264","dJobICdNm":"[C264]통신 및 방송 장비 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004375:1', '{"dJobCd":"K000004375","dJobCdSeq":"1","dJobNm":"이동통신단말사용자인터페이스개발자","workSum":"이동통신 단말의 입출력 특성 및 목적에 따라 사용자인터페이스(UI:User Interface) 시나리오, 단말통합 그래픽사용자인터페이스(GUI:Graphical User Interface), 응용 중심 그래픽유저인터페이스(GUI), Non-Graphic GUI를 개발하고 검증한다.","doWork":"이동통신 단말의 기능, 요구조건, 제약사항(그래픽 전용 프로세서의 존재 유무, 화면사양, 이동통신서비스 사업자의 요구조건, 기타 단말기 자원의 제약 등)을 분석하고 개발할 사용자인터페이스(UI:User Interface)의 목표기능을 정의한다. API(Application Programming Interface), 하드웨어 디버깅(Debugging:오류 수정) 장비, 개발호스트시스템, 그래픽사용자인터페이스(GUI) 설명자료, 웹캠, 단말에뮬레이터(Emulator:어떤 하드웨어나 소프트웨어의 기능을 다른 종류의 하드웨어나 소프트웨어로 모방하여 실현시키기 위한 장치나 프로그램), 단말시료 및 참조하드웨어를 이용하여 사용자인터페이스(UI) 시나리오, 단말통합 GUI, 응용중심 GUI, Non-Graphic UI를 구현하고 검증한다. 소스코드, 기능명세서, 검증방법 및 세부설계사양서를 작성한다. 단말의 디자인, 기능, 성능을 고려하여 단말자원 활용의 최적화 방안을 마련한다. 사용자인터페이스(UI) 개발 중에 발생한 문제점을 단말디자이너 또는 이동통신서비스 제공자와 협의하여 해결하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"서비스경험디자인기사","dJobECd":"1312","dJobECdNm":"[1312]통신공학 기술자 및 연구원","dJobJCd":"2212","dJobJCdNm":"[2212]통신공학 기술자 및 연구원","dJobICd":"C264","dJobICdNm":"[C264]통신 및 방송 장비 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007101:1', '{"dJobCd":"K000007101","dJobCdSeq":"1","dJobNm":"이동통신단말시스템개발자","workSum":"이동통신 단말의 기능 및 성능이 최적화된 시스템을 개발한다.","doWork":"이동통신 단말의 기능, 요구조건, 제약사항(데이터통신서비스의 대역폭, 프로세서 구성, 단말소프트웨어 플랫폼의 기반운영체제 등)을 분석한다. 지원솔루션 포팅, 커널 프로그래밍, OS 및 플랫폼 설정, 소프트웨어 업그레이드, 디바이스 드라이버, 하드웨어 애플리케이션, 전력소모 관리, 멀티미디어 장치 지원기술, 스토리지 지원기술, 직렬(Serial)인터페이스 지원기술, 오디오 장치 지원기술 등을 활용하여 단말의 성능이 최적화된 시스템을 구성한다. 각종 성능측정장비를 사용하여 성능을 검증하고 기능을 테스트한다. 오류발견 시 수정과 재시험을 반복한다. 각 기술별 소스코드, 기능명세서, 검증방법 및 세부설계사양서를 작성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1312","dJobECdNm":"[1312]통신공학 기술자 및 연구원","dJobJCd":"2212","dJobJCdNm":"[2212]통신공학 기술자 및 연구원","dJobICd":"C264","dJobICdNm":"[C264]통신 및 방송 장비 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002602:1', '{"dJobCd":"K000002602","dJobCdSeq":"1","dJobNm":"이동통신단말안테나개발자","workSum":"이동통신 단말제품에 사용되는 안테나를 설계하고, 회로설계 및 인쇄회로기판(PCB:Printed Circuit Board)을 개발 및 제작한다.","doWork":"이동통신 단말제품의 기획의도에 맞는 RF부품을 선정한다. 블록다이어그램(자동제어계의 각 요소를 블록으로 나타내어 입출력신호 사이의 관계를 나타내는 계통도)을 작성한다. 안테나를 설계한다. 회로를 설계하고 회로도를 작성한다. 설계된 부품들의 사이즈 및 회로 난이도를 고려한 인쇄회로기판(PCB:Printed Circuit Board)사양을 결정한다. 부품목록을 작성한다. 부품을 배치한다. 인쇄회로기판(PCB) 패턴을 레이아웃하고 전원 회로단패턴, 주요 시그널패턴, 전자파장애 방지패턴, 정전기 방지패턴 등 각종 패턴을 설계한다. 인쇄회로기판(PCB) 재질 및 유전율에 따른 기판을 선정하고 부품특성, 부품 간 간섭 및 전원 노이즈, 열발생 등을 고려해서 인쇄회로기판(PCB)을 완성한다. 완성된 보드(Board)의 성능을 개선한다. 송수신기에 대한 스퓨리어스(Spurious:무선송신기로 목적하는 주파수 이외의 불필요한 신호가 정해진 대역 밖에 나오는 것) 테스트, 송신전력 변화량 테스트, 온도환경에서의 송신전력 변화량 및 스퓨리어스 테스트, SAR(Specific Absorption Rate:전자파흡수율) 테스트, 송수신기 구현기능 테스트, 낙하 테스트, 통신사업자 망을 이용 시 통화에 문제가 없는지 안테나 성능검증을 실시한다. KCC 인증(방송통신기기인증) 및 해외 인증에 필요한 서류를 작성하고 테스트시료를 준비한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"모바일안테나개발자, PCB개발자","connectJob":"RF기술자","dJobECd":"1312","dJobECdNm":"[1312]통신공학 기술자 및 연구원","dJobJCd":"2212","dJobJCdNm":"[2212]통신공학 기술자 및 연구원","dJobICd":"C264","dJobICdNm":"[C264]통신 및 방송 장비 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001464:1', '{"dJobCd":"K000001464","dJobCdSeq":"1","dJobNm":"이동통신단말통신기능개발자","workSum":"이동통신 단말에 통신기능을 구현하기 위하여 모뎀 프로토콜 및 각종 통신기술을 개발하고 검증한다.","doWork":"이동통신 단말의 기능, 요구조건, 제약사항(데이터통신서비스의 대역폭, 하드웨어 구성, 보안취약성 등)을 분석한다. 이동통신표준 및 기술표준을 숙지한다. 모뎀 프로토콜을 개발하는 경우 이동통신 프로토콜의 구조, 검증방법, 단말소프트웨어 구조, 프로토콜과 일반단말 응용소프트웨어의 연동방식, 프로토콜 모뎀 하드웨어 구조에 대한 지식을 활용하여 개발한다. VoIP(Voice over Internet Protocol)를 개발하는 경우 데이터통신 및 TCP/IP네트워크, VoIP모듈 및 API와 응용 사이의 인터페이스, 공개소프트웨어 VoIP솔루션에 대한 지식을 활용하여 개발한다. WiFi(무선접속장치(AP)가 설치된 곳의 일정거리 안에서 초고속인터넷을 할 수 있는 근거리통신망)모듈을 개발하는 경우 데이터통신 및 TCP/IP네트워크, WiFi표준, WiFi지원 하드웨어의 기능 및 CPU 사이의 인터페이스, WiFi지원 소프트웨어 및 관련 도구에 대한 지식을 활용하여 개발한다. PAN기술(PAN:Personal Area Network:개인통신망, IrDA:Infrared Data Association:국제적외선통신데이터협회, Blutooth:근거리 무선통신규격의 하나로 반경 10∼100m 안에서 각종 전자·정보통신 기기를 무선으로 연결·제어하는 기술규격)을 개발하는 경우 PAN기술표준 및 처리방식, 인증절차, 기술처리를 위한 소프트웨어 계층구조에 대한 지식을 활용하여 개발한다. RFID/NFC기술(RFID:Radio Frequency IDentification, IC칩을 내장해 무선으로 관련 정보를 관리하는 인식기술, NFC:Near Field Communication, 13.56Mz 주파수대역을 사용하는 비접촉식 근거리 무선통신 모듈로 10cm의 가까운 거리에서 단말기 간 데이터를 전송하는 기술)을 개발하는 경우 이동통신 단말에서 RFID/NFC 활용방법, 관련 표준, 관련 하드웨어, 활용서비스의 종류 및 구현방법에 관한 지식을 활용하여 개발한다. TCP/IP 응용소프트웨어를 개발하는 경우 네트워크 계층구조, TCP/IP 프로토콜, 운영체제 내 TCP/IP 지원 계층구조, 소켓프로그래밍에 대한 지식을 활용하여 개발한다. 각종 통신기술의 개발이 완료되면 소스코드, 기능명세서, 검증방법 및 세부설계사양서를 작성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1312","dJobECdNm":"[1312]통신공학 기술자 및 연구원","dJobJCd":"2212","dJobJCdNm":"[2212]통신공학 기술자 및 연구원","dJobICd":"C264","dJobICdNm":"[C264]통신 및 방송 장비 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001857:1', '{"dJobCd":"K000001857","dJobCdSeq":"1","dJobNm":"이동통신서비스설계자","workSum":"이동통신서비스를 제공하기 위한 이동통신시스템, 무선망, 부가서비스망 및 네트워크 보안부문에 대한 기본설계를 한다.","doWork":"이동통신시스템부분을 설계하는 경우 전체 가입자 수, 가입자당 음성 및 데이터 트래픽을 예측한다. BHCA(Busy Hour Call Attempts:통화량이 가장 많은 시간대의 1시간 동안에 교환기가 처리할 수 있는 호 접속시도 횟수), 얼랑(Erlang:하나의 회선이나 기기를 1시간 이용했을 경우의 통신량)값을 산정하여 이동통신시스템의 처리능력 및 용량을 결정한다. 이동통신 네트워크 노드유형(코어망, 엑세스망, 부가서비스망)에 따라 적정노드 수를 산정한다. 노드 간 인터페이스와 전송 대역폭, 품질 요구사항을 고려하여 네트워크를 설계한다. 이동통신 무선망부분을 설계하는 경우 이동통신서비스 커버리지, 서비스 등급, 서비스 품질을 고려하여 무선망의 품질목표를 설정하고 서비스 커버리지와 트래픽을 기반으로 소요 기지국 수를 산출한다. 기지국별 시스템 파라미터를 이용하여 지형 데이터베이스 기반 전파모델 시뮬레이션을 수행한다. 전파환경분석을 통해 품질목표를 만족하는 기지국 위치를 결정한다. 부가서비스망을 설계하는 경우 부가서비스망이 제공할 주요기능과 성능을 정의하고 부가서비스망 시스템과 이동통신코어망, 외부연동시스템과의 인터페이스를 설계한다. 네트워크 보안부분을 설계하는 경우 다양한 시스템에 대한 이동통신사, 장비제조사, 솔루션 개발사 간에 협력하여 보안설계를 검토하고 위협요소별 대응 시나리오, 보완관제시스템, 보안사고 발생 시 재난복구시스템, 테이터 백업, 데이터 이중화, 시스템 이중화, 네트워크 이중화 등의 설계를 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"정보관리기술사, 정보처리기사, 정보처리산업기사","dJobECd":"1312","dJobECdNm":"[1312]통신공학 기술자 및 연구원","dJobJCd":"2212","dJobJCdNm":"[2212]통신공학 기술자 및 연구원","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002785:1', '{"dJobCd":"K000002785","dJobCdSeq":"1","dJobNm":"이동통신서비스운용원","workSum":"이동통신서비스를 제공하기 위하여 통합망, 이동통신교환망, 전송망, 엑세스망 장비를 운용한다.","doWork":"장비별(교환, 전송, 엑세스), 라우터, 스위치장비의 하드웨어, 소프트웨어 및 장비와 연동되는 프로토콜(Protocol)을 이해하고 숙지한다. 장비별 운용매뉴얼, 시스템규격, 기능설명서를 숙지한다. 교환망을 운용하는 경우 국 데이터의 입력, 변경, 삭제, 파라미터 변경을 해독하고 실행한다. 상호접속망, 내부망, 신호망을 연동하는 작업을 수행한다. 주기적인 점검항목을 선정하고 수행한다. 시스템에 새로운 서비스 기능이 추가되면 신규기능을 적용하고 실행한다. 전송망을 운용하는 경우 광단국장비의 운용상태를 모니터링하며 광선로시스템을 운용하고 성능을 개선한다. 전송시스템의 관리 및 고장조치를 한다. 기지국 수용회선, 국간회선 신설, 증설, 감설을 시행한다. 엑세스망을 운용하는 경우 엑세스(기지국, 중계기)장비의 고장조치와 대책을 수립하고 통화품질을 분석하여 품질을 개선한다. 트래픽이 급격히 상승하는 특정이벤트에 대한 대책을 수립하고 시행한다. 각 부문의 전송장비 부대시설(정류기, 축전지, UPS, 냉방기 등)을 운용한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"정보관리기술사, 정보처리기사, 정보처리산업기사","dJobECd":"1312","dJobECdNm":"[1312]통신공학 기술자 및 연구원","dJobJCd":"2212","dJobJCdNm":"[2212]통신공학 기술자 및 연구원","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005940:1', '{"dJobCd":"K000005940","dJobCdSeq":"1","dJobNm":"인공위성관제원","workSum":"인공위성에 대한 관제를 실시하고 커맨드(명령)를 접수받아 인공위성을 제어한다.","doWork":"인공위성의 궤도나 상태 등에 이상이 있는지에 관해 모니터링을 실시한다. 인공위성분석원으로부터 궤도변경이나 자세제어에 관한 MAS(Mission Analysis Software)에 의한 명령과정(Command Procedure)을 접수하고 확인하여 인공위성제어센터(SCC)를 통해 실행한다. 궤도나 상태에 모니터링 결과 이상징후가 발견되면 인공위성분석원에게 연락하여 적절한 조치를 강구하게 한다. 위성방송 부송신국시설에 대한 정기점검을 실시하고 위성방송송신국의 오작동 시 위성방송을 실시한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"위성통신망관제원","dJobECd":"1312","dJobECdNm":"[1312]통신공학 기술자 및 연구원","dJobJCd":"2212","dJobJCdNm":"[2212]통신공학 기술자 및 연구원","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005078:1', '{"dJobCd":"K000005078","dJobCdSeq":"1","dJobNm":"인공위성분석원","workSum":"인공위성의 움직임과 우주환경을 분석하고 위치수정 및 자세제어를 위한 커맨드(명령)를 작성한다.","doWork":"정지궤도에서 달, 태양, 지구의 인력에 의해 움직이는 위성궤도를 지상안테나를 통해 전파반송을 하고 위상차(Phase Difference:파동의 한 성분인 위상값의 차이)를 이용하여 측정한다. MAS(Mission Analysis Software)를 이용하여 위성궤도 조정명령과정을 기획하고 인공위성관제원에게 전달한다. 전파연구소로부터 태양활동에 대한 예보를 접수하고 미국의 NOAA사이트 등으로부터 태양풍, 태양폭풍 등의 예보를 미리 파악한다. 태양풍, 태양폭풍 또는 태양의 위치에 따른 인공위성의 온도환경 등을 고려하여 자세제어(인공위성이 지구, 태양 등의 궤도중심에 대하여 특정면을 유지하기 위해서 그 자세를 제어할 필요가 있으며 로켓트의 유도제어장치에 의한 자세제어와 인공위성의 자세제어 등이 있다)를 한다. 인공위성의 각종 상태를 알려주는 텔레메트리(전파를 이용하여 원격지점에 있어서 측정기의 측정결과를 자동으로 표시하고 또 기록하기 위한 통신설비)의 데이터를 분석하고, 이상징후 발생 시 적절한 조치를 실시한다. 실제 MAS를 통한 자세제어나 궤도변경 작업 전 동적시뮬레이터(DSS:Dynamic Simulator System)를 이용하여 시험을 실시한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"1312","dJobECdNm":"[1312]통신공학 기술자 및 연구원","dJobJCd":"2212","dJobJCdNm":"[2212]통신공학 기술자 및 연구원","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001580:1', '{"dJobCd":"K000001580","dJobCdSeq":"1","dJobNm":"자율주행하드웨어개발자","workSum":"자율주행에 필요한 인지, 판단, 제어를 수행하기 위하여 작성된 개발계획서와 사양명세서를 근거로 회로를 설계하고 검토하여 모듈을 제작한다.","doWork":"자율주행 자동차의 주행환경에서 안전하고 효율적인 주행을 위하여 요소센서 및 무선통신 기반으로 판단 및 제어가 가능한 하드웨어를 개발한다. 주행환경 인지모듈에서 인지한 공간정보 및 자세정보를 이용하여 정밀지도에서 자율주행 자동차를 위치(매핑) 가능한 하드웨어 모듈을 개발한다. 자동차 동적 움직임을 제어하기 위한 종방향 제어, 횡방향 제어, 종횡방향 통합제어를 위한 하드웨어 모듈을 개발한다. 자율주행에 필요한 차량 내부의 통신 네트워크와 안전한 데이터 전송 및 수신을 하기 위한 차량 내 통신모듈, 데이터 통신모듈, 차량 보안모듈을 개발하고 차량 통신모듈을 시험한다. 운전자 상태를 감시하는 모듈을 이용하여 자율주행차와 운전자가 상호작용을 할 수 있는 입력, 출력 하드웨어 모듈을 개발한다. 모듈에 대한 신뢰성 확보를 위해] 자율주행 조건에 따라 성능평가기준을 계획하고 데이터를 수집한 후 분석하고 평가한다. 자율주행 자동차에 탑재된 등화, 안전, 편의, 모듈이 자율주행의 다양한 환경 조건에서 정상적으로 작동유무를 시험하고 점검한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"기계설계산업기사, 기계설계기사, 그린전동자동차기사, 자동차정비산업기사, 자동차정비기사, 빅데이터분석기사, 정보처리산업기사, 정보처리기사, 정보통신산업기사, 정보통신기사","dJobECd":"1312","dJobECdNm":"[1312]통신공학 기술자 및 연구원","dJobJCd":"2212","dJobJCdNm":"[2212]통신공학 기술자 및 연구원","dJobICd":"J620","dJobICdNm":"[J620]컴퓨터 프로그래밍, 시스템 통합 및 관리업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001675:1', '{"dJobCd":"K000001675","dJobCdSeq":"1","dJobNm":"전송로연구원","workSum":"초고속통신시대에 적합한 전송로망 기반시설을 구축하기 위하여 전송로망의 고도화, 광통신기술, 선로건설기술 등을 연구·개발한다.","doWork":"데이터 통신에 대한 수요의 다양화, 고도화에 대처하기 위하여 전송기술을 확보하고 전송로 고도화에 관한 연구, 개발을 한다. 기간전송망을 점진적으로 고도화하기 위한 계획수립과 전달망의 망관리 체계를 연구한다. 디지털 전송로와 교환기의 결합으로 구성된 데이터 교환망 등 변화하는 통신환경에 부합하는 망체계를 연구한다. 케이블 및 각종 선로용품들이 설치되어 있는 토목구조물의 안전성이나 편리성, 효율성을 연구하고 노후한 설비의 안전진단과 보수공법, 건설업무의 기계화 등을 연구한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"광통신연구원","certLic":"정보통신기술사, 정보통신기사, 정보통신산업기사","dJobECd":"1312","dJobECdNm":"[1312]통신공학 기술자 및 연구원","dJobJCd":"2212","dJobJCdNm":"[2212]통신공학 기술자 및 연구원","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006123:1', '{"dJobCd":"K000006123","dJobCdSeq":"1","dJobNm":"전송시설기술자","workSum":"전송시설의 건설공사를 관리하고, 건설된 전송시설의 안정적 운영관리업무를 수행하고, 전송 관련 기술개발 및 표준화 관련 업무를 수행한다.","doWork":"전송시설 설비투자 기본계획, 신기술개발 및 서비스수요와 연계한 건설계획 등을 수립한다. 전송망시설 확충과 장비표준화, 국산화 및 고도화 실행계획을 수행한다. 투자공사 집행의 효율적 관리를 위하여 전송시설의 건설공사 집행실적을 종합적으로 관리한다. 국가 주요행사 통신지원 등 공공통신 지원업무를 수행한다. 전송시설의 안정적 운용과 통신품질 확보를 위하여 운용보존계획을 수립한다. 전송시설 운용인력 양성 및 노후시설의 대체업무를 수행한다. 케이블TV 전송망을 운용·보전하기도 한다. 전송집중 운용보전시스템 구축, 기술표준, 운용표준, 제품표준 등 각종 표준의 제·개정 관련 업무를 하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","certLic":"정보통신기사, 정보통신산업기사","dJobECd":"1312","dJobECdNm":"[1312]통신공학 기술자 및 연구원","dJobJCd":"2212","dJobJCdNm":"[2212]통신공학 기술자 및 연구원","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001867:1', '{"dJobCd":"K000001867","dJobCdSeq":"1","dJobNm":"전용회선보안관리원","workSum":"(주)KT 또는 망임대사업자에 소속되어 고객에게 제공되는 전용회선(임대회선) 서비스가 보안상태를 유지할 수 있도록 보안정책, 보안환경을 구성하고 원격으로 보안감시를 한다.","doWork":"검토하고 보안요소를 도출한다. 보안요소에 대한 보안범위를 정하고 보안계획 및 보안자원을 할당한다. 보안정책에 따라 보안환경을 구성하고 보안장비를 설치한다. 보안환경을 시험·점검한다. 보안장비 및 도구를 사용하여 원격에서 감시하고 보안위협을 예측한다. 예측된 보안위협에 따라 취약점을 분석하고 대응한다. 보안사고 방지를 위한 대응방안을 마련한다. 보안현황 관리항목에 따라 상태를 감시하고 기록한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"1312","dJobECdNm":"[1312]통신공학 기술자 및 연구원","dJobJCd":"2212","dJobJCdNm":"[2212]통신공학 기술자 및 연구원","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006015:1', '{"dJobCd":"K000006015","dJobCdSeq":"1","dJobNm":"전용회선서비스회선망관리원","workSum":"전용회선서비스를 이용하는 고객에게 서비스가 정상적으로 공급되도록 운영하고 관리한다.","doWork":"전용회선서비스 현황 및 관리기준을 파악하고 서비스관리기준 및 관리계획을 수립한다. 품질목표 및 품질지표에 따라 서비스품질을 측정하며 미달성 시에 품질향상방안을 마련한다. 망관리기준에 따라 전용회선망의 설비 및 경로설정, 회선망의 IP자원할당, 장비설정값 입력, 회선망 경로상태 감시 및 부하예측, IP자원 수요예측 및 경로재할당작업을 수행한다. 전용회선망시험 및 점검항목에 따라 주기적으로 시험 및 점검을 실시하고 결과를 기록한다. 망관리시스템을 운용하고 유지·보수한다. 망관리시스템을 사용하여 전용회선서비스의 예상문제점을 도출하고 예방정비를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"1312","dJobECdNm":"[1312]통신공학 기술자 및 연구원","dJobJCd":"2212","dJobJCdNm":"[2212]통신공학 기술자 및 연구원","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006095:1', '{"dJobCd":"K000006095","dJobCdSeq":"1","dJobNm":"전용회선시험원","workSum":"통신전용회선의 고장상황을 접수받아 각종 시험을 통해 고장 원인을 파악한 후 수리를 지시한다.","doWork":"전용회선고객의 신규, 전입을 접수받아 전송실(PCM)과 가입자 간의 라인을 연결하고 시험한다. 전용선고객의 속도, 가입자명, 가입자주소, 케이블번호 등 자료를 입력한다. 전용선의 고장상황을 전용회선 집중운용 시스템으로부터 접수받는다. 전용선용 회선시험대를 이용하여 회선의 손실, 누하, 잡음 등을 측정하고 고장원인을 외선(전화국외부) 또는 국내(전화국내부)의 경우로 나누어 파악한다. 국외의 경우 가입자와 국선 MDF(주배선반)를 일대일로 연결하여 회선시험을 한다. 국내의 경우 국내전송실(PCM)과 시험실 사이를 시험하여 고장을 파악하고 수리를 지시한다. 전용회선 집중운용 시스템을 이용하여 고장상황에 대한 수리내역을 입력한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"수동조작","certLic":"정보통신기사, 정보통신산업기사, 통신선로산업기사, 통신선로기능사, 통신기기기능사","dJobECd":"1312","dJobECdNm":"[1312]통신공학 기술자 및 연구원","dJobJCd":"2212","dJobJCdNm":"[2212]통신공학 기술자 및 연구원","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002916:1', '{"dJobCd":"K000002916","dJobCdSeq":"1","dJobNm":"정보통신감리원","workSum":"정보통신시설물의 설치·보수공사에서 공사전반에 대한 관리(품질관리, 시공관리, 자재관리, 환경관리, 안전관리 등)를 하며 설계도서 및 기타 관계 서류의 내용대로 시공되었는지 감독·확인한다.","doWork":"감리업무 수행에 요구되는 절차와 세부내용을 발주자, 건설사, 공사업자 등과 협의한다. 공사시공에 사용되는 설계도면의 관련 법규에 대한 충족 여부, 시공 적합성 여부를 검토한다. 공사계약서상에 나타난 정보통신설비의 규격, 수량 등의 일치 여부를 확인하고 품질확보에 적합한지를 검토·확인·점검·승인한다. 공사 또는 감리에 관한 변경설계도서, 계획서, 보고서 및 감리결과보고서를 작성한다. 문제점이 발생할 경우 재시공을 지시하거나 중지시키며 발주자에게 보고한다. 재해예방대책 및 작업자의 안전 등을 점검하며 이에 대해 기술지도를 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","certLic":"정보통신기술사, 정보통신기사, 정보통신산업기사","dJobECd":"1312","dJobECdNm":"[1312]통신공학 기술자 및 연구원","dJobJCd":"2212","dJobJCdNm":"[2212]통신공학 기술자 및 연구원","dJobICd":"F423","dJobICdNm":"[F423]전기 및 통신 공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007691:1', '{"dJobCd":"K000007691","dJobCdSeq":"1","dJobNm":"지능형교통체계시공가","workSum":"설계서를 기반으로 지능형교통체계 시스템(현장 및 센터시스템) 및 서비스를 구축하고 설치된 장비 및 서비스를 인증⋅검증 및 각종 장비 설치 확인, 안전관리, 품질관리, 공정관리, 보안관리를 수행하며, 구축 사업 준공 후 교통체계지능화 사업의 구축효과를 객관적으로 검증하는 효과분석을 수행한다.","doWork":"설계도서를 기반으로 지능형교통체계 서비스를 제공하기 위하여 요구되는 현장장비 및 센터시스템(H/W, S/W, N/W, 보안 등)를 설치, 구축하고 정상적으로 설치가 되었는지 확인한다. 개발된 지능형교통체계 현장 설비⋅센터시스템의 성능평가 기준을 파악하고, 규정 기준에 적합한지 테스트하고 분석한다. 지능형교통개발⋅구축 시 수요처의 요구사항을 분석하여 기자재관리, 성능관리, 준공검사를 통해 납품되는 시스템의 품질과 성공적인 프로젝트를 위하여 착수부터 종료까지의 공정을 관리한다. 시스템 구축 개발 시 적용해야 할 기술적⋅물리적⋅인적 보안을 관리한다. 효과평가지표를 선정하고 지능형교통시스템 구축 전과 후의 효과척도별 조사 분석을 통하여 교통체계지능화사업의 효과를 객관적으로 검증한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"지능형교통체계구축가","certLic":"정보처리기사, 정보통신기사, 교통기사, 무선설비기사, 전기기사, 정보통신기술사","dJobECd":"1312","dJobECdNm":"[1312]통신공학 기술자 및 연구원","dJobJCd":"2212","dJobJCdNm":"[2212]통신공학 기술자 및 연구원","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2025"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003746:1', '{"dJobCd":"K000003746","dJobCdSeq":"1","dJobNm":"철도통신설비기술원","workSum":"철도통신설비의 운용·조작·성능시험 및 검사, 통신설비의 유지, 보수 및 소속 내 현품관리에 관한 업무를 수행한다.","doWork":"철도통신설비의 조사, 설계, 시공감독 및 책임검사 및 기타의 기술업무를 수행한다. 사업소 내의 일반서무 및 물품의 관리업무를 담당한다. 통신설비에 관한 유지, 보수와 공사의 시공에 따른 부대업무를 담당한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실외","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"철도통신장비유지보수원, 철도통신시시설유지보수원","certLic":"전자산업기사, 정보통신산업기사","dJobECd":"1312","dJobECdNm":"[1312]통신공학 기술자 및 연구원","dJobJCd":"2212","dJobJCdNm":"[2212]통신공학 기술자 및 연구원","dJobICd":"H491","dJobICdNm":"[H491]철도 운송업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005708:1', '{"dJobCd":"K000005708","dJobCdSeq":"1","dJobNm":"케이블방송단말기개발원","workSum":"케이블방송단말기를 기획·개발한다.","doWork":"현재 운용 중인 케이블방송단말기 및 단말기 운용현황을 검토하여 안정성, 기능, 성능, 운용 중인 주파수대역, 단말기소프트웨어, 운용 시 발생한 문제점 및 개선조치이력 등을 분석한다. 기술요소분석보고서를 작성한다. 국내외기술표준 및 최신기술을 수집하고 분석한다. 서비스별(상품별 단말기) 요구사항을 정의하고 기본기능, 특수기능, 프로세스 등을 검토하여 시나리오를 작성한다. 단말기소프트웨어 및 운영체제를 검토하고 관련 표준에 따라 동작상태를 시험한다. 상품별 요구사항 및 SAT(Site Acceptance Test:제품이 발주자의 요구대로 만들어졌는가를 조사하는 시험)정의서(최종품질정의서)를 작성한다. 시제품 제작을 진행하고 검증한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1312","dJobECdNm":"[1312]통신공학 기술자 및 연구원","dJobJCd":"2212","dJobJCdNm":"[2212]통신공학 기술자 및 연구원","dJobICd":"C264","dJobICdNm":"[C264]통신 및 방송 장비 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006979:1', '{"dJobCd":"K000006979","dJobCdSeq":"1","dJobNm":"케이블방송전송선로설비기획원","workSum":"케이블방송 전송선로설비 구축공사를 기획하고 진행한다.","doWork":"전송선로설비 구축공사지역을 실사하여 구축공사에 필요한 의무제공사업자(한전, KT)의 설비(전신주, 통신선로, 통신시설 등)를 파악하고, 시설임차협의를 한다. 가입자건물에 장비를 설치하거나 선로를 인입하는 경우 건물주와 시설동의를 위한 협의를 한다. 구축지역에 타사의 시설구축현황, 서비스제공현황을 파악한다. 현장여건을 고려하여 전송선로설비 구축 설계도면을 검토하고, 필요한 경우 설계변경을 요청한다. 공사 관련 행정업무(설비임차계약, 배전공가설비 임차승인, 굴착심의, 각종 공문서 등)을 진행한다. 구축공사공정을 계획하고, 공정표, 품질관리, 안전관리계획을 수립하여 공사를 진행한다. 공사가 표준시공법으로 진행되도록 지도·감독한다. 시공상태를 검수하고 계측기를 사용하여 아날로그·디지털신호를 측정하여 준공검수를 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"1312","dJobECdNm":"[1312]통신공학 기술자 및 연구원","dJobJCd":"2212","dJobJCdNm":"[2212]통신공학 기술자 및 연구원","dJobICd":"J602","dJobICdNm":"[J602]텔레비전 방송업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007170:1', '{"dJobCd":"K000007170","dJobCdSeq":"1","dJobNm":"통신경영기획원","workSum":"인터넷이용자에게 제공되는 각종 통신서비스의 발전 방향을 기획하고 서비스상품을 개발한다.","doWork":"인터넷의 웹(Web)서비스 및 각종 전문잡지 등을 통해 최신정보를 수집한다. 인터넷 웹서비스 내의 개별서비스들의 전체적인 발전방향을 설정한다. 전체서 비스의 발전방향에 따른 기타서비스들의 발전구도를 결정한다. 커뮤니티, 콘텐츠 등 각 서비스군별 간 조화와 균형개발을 기획한다. 주요서비스개발부서에 해당되지 않는 이용자가입서비스, 색인서비스 등 특수서비스상품을 개발한다. 각종 서비스들의 표준화를 계획하고, 전용소프트웨어를 기획한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"1312","dJobECdNm":"[1312]통신공학 기술자 및 연구원","dJobJCd":"2212","dJobJCdNm":"[2212]통신공학 기술자 및 연구원","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001715:1', '{"dJobCd":"K000001715","dJobCdSeq":"1","dJobNm":"통신공학연구원(일반)","workSum":"컴퓨터통신, 휴대용전화, 호출기 등의 각종 통신신호의 교환기술 및 시스템의 구조를 연구·개발한다.","doWork":"물리학, 수학 및 컴퓨터의 구조와 원리에 대한 지식을 바탕으로 전화교환방식 및 시스템 구조, 교환기시스템의 시험 및 운영관리, 교환설비의 프로그램 및 프로그램언어, 교환기의 제어설비, 운영체계 및 데이터베이스, 개인통신망 및 전송기술 등을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"통신계통연구원","connectJob":"무선통신계통연구원","certLic":"정보통신기술사, 정보통신기사, 정보통신산업기사, 통신설비기능장, 전파통신기사, 전파통신산업기사, 전파전자기사, 전파통신산업기사, 방송통신기사, 방송통신산업기사","dJobECd":"1312","dJobECdNm":"[1312]통신공학 기술자 및 연구원","dJobJCd":"2212","dJobJCdNm":"[2212]통신공학 기술자 및 연구원","dJobICd":"C264","dJobICdNm":"[C264]통신 및 방송 장비 제조업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002583:1', '{"dJobCd":"K000002583","dJobCdSeq":"1","dJobNm":"통신기술표준화연구원","workSum":"전기통신기술의 표준안을 개발하고, 표준에 따라 개발된 제품에 대한 품질보증 및 개발확인시험을 실시한다.","doWork":"신규서비스 제공 및 신기술 도입 시 기술개발과 표준, 특허와의 연계성을 분석하여 표준화추진전략을 수립한다. 관련 기술의 표준, 경제성, 기술성 및 성과를 연구·분석하고 표준안을 개발한다. 표준에 따라 개발된 제품의 효율성 및 실용성을 조사하기 위하여 연구개발 품질보증 및 개발확인시험을 실시한다. 정보통신서비스 및 통신망장비의 동작 여부 확인, 장비의 호환성 확보, 신뢰성 있는 통신망 구현을 위하여 통신프로토콜 적합성 및 상호운용성시험을 실시한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"국제표준코디네이터, 표준개발자","certLic":"정보통신기술사, 정보통신기사, 정보통신산업기사","dJobECd":"1312","dJobECdNm":"[1312]통신공학 기술자 및 연구원","dJobJCd":"2212","dJobJCdNm":"[2212]통신공학 기술자 및 연구원","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004967:1', '{"dJobCd":"K000004967","dJobCdSeq":"1","dJobNm":"통신망개발기획원","workSum":"전파자원의 효율적인 관리를 위해 통신망 연동 및 통합계획을 수립하고 차세대 전송망발전계획 등을 수립한다.","doWork":"교환망 계위별 루팅체계와 현황을 분석하고 접속트래픽(Traffic:통화량) 및 시외트래픽의 증가에 따른 시내외 망의 구조를 개선한다. 멀티미디어시대에 대비하여 공중전화망(PSTN:Public Switched Telephone Network)에서의 데이터트래픽의 증가에 대비한 교환망 구조개선 및 고도화를 실시한다. 집중과금방식(CAMA:Centralized Automatic Message Accounting System, 전자교환기에서 발생하는 요금부과데이터를 전산국의 요금부과 수집장치까지 실시간으로 신뢰성을 유지하며 온라인 자동전송하여 요금처리업무의 자동화 및 일일단위의 요금처리를 가능하게 하는 방식)에 의한 과금계획을 수립한다. 상호접속제공교환기에 타 사업자 서비스에 대한 과금계획을 수립한다. 전화국 간 전송망의 관로통신구 등 기초시설 중장기발전계획을 수립하고 차세대 전송망발전계획을 수립한다. 음성 및 영상데이터 등 다양한 형태의 정보를 전송할 수 있는 광대역통합망(BcN:Broadband convergence Network)을 개발 및 기획한다. IPV6, 4G 등 차세대 네트워크 기술을 개발한다. 유선방송(CATV:CAble TV)전송망, 국제전송망·가입자망, 지능망 및 신호망의 중장기계획을 수립한다. 주파수자원의 이용계획을 수립하고 무선국관리 전산시스템의 구축을 추진한다. 번호계획을 수립한다. 공중통신망의 통화권, 시내전화망, 시외통신망, 국제통신망, 데이터통신망에 대한 루팅체계 및 통신망의 현황을 분석하여 상호접속 표준모델을 설정하며 상호접속계획을 수립한다. 초고속통신, 무선인터넷의 신규고객의 증가에 따른 전용회선의 증설을 검토하고 관련 자료를 수집·분석하여 각 지역의 특성에 따른 선로의 가설계획을 수립한다. 각종 중계설비의 설치에 관련된 기술적인 타당성을 검토하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"통신망발전계획사무원","connectJob":"초고속통신망관리원, 피씨통신망관리원","certLic":"정보통신기술사, 정보통신기사, 정보통신산업기사","dJobECd":"1312","dJobECdNm":"[1312]통신공학 기술자 및 연구원","dJobJCd":"2212","dJobJCdNm":"[2212]통신공학 기술자 및 연구원","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002184:1', '{"dJobCd":"K000002184","dJobCdSeq":"1","dJobNm":"통신망관리기획원","workSum":"통신망의 효율성과 성능향상을 위하여 통신망 관리체제를 기획하고 망관리시설의 구축업무를 수행하며, 통신망의 품질을 평가한다.","doWork":"통신망관리체제 구축을 계획한다. 통신망 운용관리시스템의 표준화를 기획한다. 망관리지침과 트래픽관리기준을 설정한다. 종합망관리센터를 구축 및 운용한다. 지역망관리센터와 국제망관리센터를 구축하고 보강한다. 운용시스템 실태를 진단하고 장기발전계획을 수립한다. 단대단(End-to-End:단말장치에서 단말장치로의 통신으로, 전화나 팩시밀리 등과 같이 호스트컴퓨터의 제어를 받지 않는 것) 통신망 접속성능을 분석·진단하여 트래픽을 관리한다. 망관리시설을 개발·구축·개량한다. 단대단(End-to-End) 통신망 품질측정 및 평가기술을 개발한다. 교환기의 트래픽관리를 전산화한다. 트래픽관리시설의 정보표준화와 데이터베이스표준화를 추진한다. 트래픽관리시설 운용자료를 온라인으로 제공하고 기술지원 및 관리를 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","certLic":"정보통신기술사, 정보통신기사, 정보통신산업기사","dJobECd":"1312","dJobECdNm":"[1312]통신공학 기술자 및 연구원","dJobJCd":"2212","dJobJCdNm":"[2212]통신공학 기술자 및 연구원","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006411:1', '{"dJobCd":"K000006411","dJobCdSeq":"1","dJobNm":"통신망연구원","workSum":"통신망의 통신회선, 운영체계나 성능기준, 수요예측 등에 관한 연구를 한다.","doWork":"통신회선, 통신망 노드 인터페이스, 통신서비스 공개규정, 통신망 성능기준, 통신망 운영체계, 통합접속장치 등에 대한 연구를 수행한다. 통신망 구조진단 및 설비투자 효율성 제고에 관한 연구를 한다. 통신망 수요예측 및 계획에 관한 연구를 한다. 통신망 품질향상, 상호접속, 신뢰도, 소통향상대책에 관한 연구를 한다. 차세대 교환기술 및 지능망서비스에 관한 연구, 개발을 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"광대역통신망연구원, 정보통신망연구원, 통신계통연구원","certLic":"정보통신기술사, 정보통신기사, 정보통신산업기사","dJobECd":"1312","dJobECdNm":"[1312]통신공학 기술자 및 연구원","dJobJCd":"2212","dJobJCdNm":"[2212]통신공학 기술자 및 연구원","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005192:1', '{"dJobCd":"K000005192","dJobCdSeq":"1","dJobNm":"통신망운용기획원","workSum":"통신망의 안정적 운용과 통신품질 향상을 위하여 통신망 운용계획을 수립하고, 통신망 운용조직 및 운용체계를 개선하며, 통신망의 품질을 관리한다.","doWork":"국내외 통신운용체의 통신망 운용관리자료를 조사하고 네트워크 운용보전현황을 수집하여 중장기 운용보전계획을 수립한다. 집중운용보전 센터 및 시스템의 기능 및 역할을 정립하고 집중전화국과 수용국의 업무영역 조정계획을 수립한다. 전화국의 광역집중화 운용계획을 수립한다. 전문통신기술인력의 육성 및 활용계획을 수립한다. 네트워크시설 운용인력을 산출한다. 통신망 품질관리시스템 운용계획 및 운용요원의 관리를 한다. 품질관리실태를 조사하고 교육을 실시한다. 품질관리규정을 제정한다. 고객품질보상제도를 수립한다. 통화트래픽을 관리하여 전화국 간 중계손실구간을 개선한다. 통화완료율 향상방안 및 과부하구간 해소대책을 수립한다. 재해 시 상황실을 운용하고 전송로절체계획 수립을 위한 기준을 작성하며 국소별 기능마비 시 긴급소통대책을 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","certLic":"정보통신기술사, 정보통신기사, 정보통신산업기사","dJobECd":"1312","dJobECdNm":"[1312]통신공학 기술자 및 연구원","dJobJCd":"2212","dJobJCdNm":"[2212]통신공학 기술자 및 연구원","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004428:1', '{"dJobCd":"K000004428","dJobCdSeq":"1","dJobNm":"통신서비스개발원","workSum":"유선·무선상품에 대한 신규 및 부가서비스를 개발·보급한다.","doWork":"월드뉴스, 해외전기통신동향 및 경쟁사의 동향을 모니터링하여 사업성을 갖춘 아이디어를 도출한다. 선별아이디어의 사업타당성 및 사업 적용가능성을 검토한다. 신규서비스 도입계획을 수립한다. 브랜드명을 설정하고 새로운 기능 및 영업전산개발을 관리한다. 이용요금을 분석·검토하여 서비스 제공계획을 수립한다. 기능개발 시 요구사항을 검토하여 품질목표를 설정한다. 유무선통신상품 신규서비스의 안정성, 인지도 확보를 위한 시범서비스 및 시험을 실시한다. 시범서비스를 통하여 고객의 이용성향을 조사하여 판촉활동 및 상용화계획에 반영한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","connectJob":"유선통신상품개발원, 무선통신상품개발원, 정보통신상품개발원, 통신상품개발원","dJobECd":"1312","dJobECdNm":"[1312]통신공학 기술자 및 연구원","dJobJCd":"2212","dJobJCdNm":"[2212]통신공학 기술자 및 연구원","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002981:1', '{"dJobCd":"K000002981","dJobCdSeq":"1","dJobNm":"통신서비스메뉴관리원","workSum":"통신서비스의 디렉토리(Directory) 구조를 기획·설계하고 관리한다.","doWork":"통신서비스의 개별서비스메뉴를 분야별로 분류하고 개별상품의 메뉴를 등록할 수 있도록 설계한다. 통신서비스메뉴 관리의 로직(Logic)에 따라 항목관리(Index Management)프로그램을 이용하여 항목을 관리(항목의 생성, 수정, 삭제 등)한다. 새로운 상품을 정보제공자관리원, 웹서비스기획원 등으로부터 받아 서비스 내의 분류상품명을 결정하여 구조 내에 삽입한다. 메뉴의 개편에 따라 하위디렉토리(Sub-Directory)를 만들거나 통폐합하고 중요도에 따라 재배열을 한다. 상품의 가치가 없어지거나 정보제공자(IP:Information Provider)의 계약해지에 따라 항목관리프로그램을 통해 삭제한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","connectJob":"분야에 따라 인터넷서비스메뉴관리원","dJobECd":"1312","dJobECdNm":"[1312]통신공학 기술자 및 연구원","dJobJCd":"2212","dJobJCdNm":"[2212]통신공학 기술자 및 연구원","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004576:1', '{"dJobCd":"K000004576","dJobCdSeq":"1","dJobNm":"통신선로설비기술자","workSum":"통신선로시설의 설치 및 운용보전계획을 수립하고, 통신선로를 설계하며, 통신선로공사를 지휘·감독한다.","doWork":"전송로의 고도화, 고품질화를 위한 설비투자기본계획을 수립하고 건설계획수립 및 조정, 품질관리 그리고 전송망기자재의 기술기준, 공법, 품질, 규격 제·개정 등의 업무를 수행한다. 통신수요를 예측하여 통신선로의 종류 및 규격 등을 계산한다. 도로의 여건, 지형 등을 확인하여 선로의 방법(가공선로 또는 지중선로)을 결정한다. 선로의 기초설계가 완료되면 현장을 조사하여 세부적인 문제점을 분석한다. 현장에서 조사한 자료를 토대로 설계도 및 보고자료를 작성한다. 공사현장에서 작업원의 활동을 감독하고 현장에서 발생하는 각종 장애원인을 파악하여 대책을 수립한다. 새로운 자재 및 장비의 규격, 설계기준, 표준공법, 표준품질을 제·개정하는 등 전송로 고도화에 대한 제반 업무를 수행한다. 선로시설의 안정화 및 효율적 운용을 위하여 운용보전계획 및 지침을 수립하고, 선로시설의 관리 및 유지보수, 유지보수인력 양성, 유지용 장비 및 측정기 기준 등을 설정한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","certLic":"정보통신기사, 정보통신산업기사","dJobECd":"1312","dJobECdNm":"[1312]통신공학 기술자 및 연구원","dJobJCd":"2212","dJobJCdNm":"[2212]통신공학 기술자 및 연구원","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004052:1', '{"dJobCd":"K000004052","dJobCdSeq":"1","dJobNm":"통신시스템기획원","workSum":"인터넷 및 통신시스템의 증설 및 개선·유지보수에 관련된 기획업무를 수행하고 네트워크 계정을 관리한다.","doWork":"클라이언트 모뎀접속지(FEP:Front End Process)와 데이터베이스서버(BEP:Back End Process)에 필요한 장비 및 이용자 수에 관한 데이터를 분석한다. 장비의 과부족을 파악하여 증설 및 보완작업을 한다. 각종 인터넷서비스에 필요한 신규장비를 관련 업체의 엔지니어를 통해 서비스에 맞게 테스트하여 구입한다. 이용자 수의 증가에 따른 시스템의 증설이 이루어짐에 따라 필요한 모뎀회선의 환경에 적합하도록 모뎀이나 라우팅(Routing)장비를 증설·개선한다. 장비의 유지보수비용 및 기타사항을 고려하여 요금체계를 기획한다. 사내인트라넷(Intranet) 네트워크(Network)의 계정(IP Domain:Internet Protocol Domain)을 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","connectJob":"인터넷통신시스템기획원","certLic":"정보통신기사, 정보통신산업기사","dJobECd":"1312","dJobECdNm":"[1312]통신공학 기술자 및 연구원","dJobJCd":"2212","dJobJCdNm":"[2212]통신공학 기술자 및 연구원","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006262:1', '{"dJobCd":"K000006262","dJobCdSeq":"1","dJobNm":"회선관리원","workSum":"통신용 공중회선, 전용회선, 다국접속회선, 시외회선 등에 대한 소통저해요인 방지, 고장처리 등 통신회선의 효율적 운용 및 관리업무를 수행한다.","doWork":"기상현황을 관리하고, 재해 시 지역방재계획을 수립한다. 회선구성, 변경, 해지를 한다. 전용회선, 공중회선, 다국접속회선, 시외회선, 티원(T1)급 이상의 전용회선 등을 전산으로 관리한다. 국간중계회선 종합관리시스템(TRUMAN:TRUnk MANagement System)을 통해 회선현황을 데이터베이스화하고 관리한다. 전송로 변동사항을 수시로 보고하며 주요행사에 통신지원을 한다. 디지털전송로집중운용시스템(DTMS:Digital Transmission Net-work Management System) 데이터를 이용하여 시설·회선별 통계를 분석한다. 전송로의 경보를 감시하고 회선고장을 접수하여 고장처리한다. 대형고장에 대한 예방대책을 수립한다. 통신회선 품질관리를 위하여 품질조사시험대상 회선을 관리한다. 통신회선 품질조사시험계획을 수립하고 티원(T1)급 이상의 전용회선의 정밀품질측정을 한다. 정기품질 조사시험을 하고 불량회선에 대한 수리의뢰를 한다. 민원이 발생한 회선의 품질조사시험을 하고 분석한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"고객전송시설운용원","certLic":"정보통신기사, 정보통신산업기사, 통신선로산업기사, 통신선로기능사, 통신기기기능사","dJobECd":"1312","dJobECdNm":"[1312]통신공학 기술자 및 연구원","dJobJCd":"2212","dJobJCdNm":"[2212]통신공학 기술자 및 연구원","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005841:1', '{"dJobCd":"K000005841","dJobCdSeq":"1","dJobNm":"휴대폰프로젝트매니저","workSum":"성공적인 휴대폰프로젝트 개발과 완료를 위해 전체적인 수행계획을 수립하고 통제·관리한다.","doWork":"휴대폰프로젝트를 착수하기 위하여 사전프로젝트 환경분석, 타당성조사를 수행하고 프로젝트 성공에 필요한 기준을 수립한다. 다양한 프로젝트관리활동들을 정의하고 조정하여 이해관계자의 요구사항을 관리하다. 프로젝트를 성공적으로 완료하기 위해 프로젝트에 포함할 사항과 제외할 작업을 정의하고 통제한다. 단위활동들의 순서를 정하고 각 활동의 수행에 필요한 자원을 할당한다. 프로젝트 전체일정을 수립하고 이를 주기적으로 평가하여 관리한다. 프로젝트 목표에 영향을 미칠 수 있는 위험(Risk)을 식별하고 평가하여 대응한다. 프로젝트에 필요한 조달계획을 수립하고 선정하여 관리한다. 프로젝트 이해관계자들의 의사소통방안을 수립하고, 만족하는지 모니터링하고 조정한다. 프로젝트 수행을 위해 필요한 인적자원을 효과적이고 효율적인 프로세스를 통해 통제하고 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"1312","dJobECdNm":"[1312]통신공학 기술자 및 연구원","dJobJCd":"2212","dJobJCdNm":"[2212]통신공학 기술자 및 연구원","dJobICd":"C264","dJobICdNm":"[C264]통신 및 방송 장비 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;