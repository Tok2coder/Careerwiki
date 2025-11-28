INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001398:1', '{"dJobCd":"K000001398","dJobCdSeq":"1","dJobNm":"고체화학연구원","workSum":"고체 무기 화합물 등의 합성, 구조, 및 물리-화학적 특성 등에 대한 문제를 연구한다.","doWork":"무기물질의 정확한 구조와 결정성장의 원리, 대칭요소, 결정의 표현 등을 분석한다. 무기고체화합물을 응용하여 발광재료, 자성재료, 초전도재료 등을 개발한다. 전기화학공정을 연구·개발한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","dJobECd":"1211","dJobECdNm":"[1211]자연과학 연구원","dJobJCd":"2112","dJobJCdNm":"[2112]자연과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006504:1', '{"dJobCd":"K000006504","dJobCdSeq":"1","dJobNm":"광산지질조사원","workSum":"지하자원의 채굴 및 광구관리를 위하여 지질의 광상을 조사한다.","doWork":"탐사자료, 지질도 등을 검토하여 조사대상지역을 선정한다. 광맥발달상태 및 지질구조를 파악한다. 유용한 광물매장이 예상되는 지역의 광석견본을 채취한다. 시추위치를 선정하여 시추기술자에게 시추를 의뢰한다. 광맥의 연장, 심도, 부존면적, 증가율, 두께를 산출하고, 매장량 및 가채량을 산정한다. 지질조사 및 시추결과를 토대로 주상도, 지질단면도 등을 작성한다. 지질광상(鑛床:광물자원이 암석 속에 자연 상태로 집중되어 있는 것)조사보고서를 작성한다. 광구 또는 갱별 지질구조를 조사하고 출광량을 확인한다. 생산량의 증가 및 감소요인을 파악하여 광구를 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"분석","workFunc2":"협의","workFunc3":"정밀작업","similarNm":"광상조사원","connectJob":"조사하는 광상의 종류에 따라 금속광상조사원, 비금속광상조사원, 석탄광상조사원, 석회석광상조사원","dJobECd":"1211","dJobECdNm":"[1211]자연과학 연구원","dJobJCd":"2112","dJobJCdNm":"[2112]자연과학 연구원","dJobICd":"M729","dJobICdNm":"[M729]기타 과학기술 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005760:1', '{"dJobCd":"K000005760","dJobCdSeq":"1","dJobNm":"광화학연구원","workSum":"빛에 의해 야기되는 분자의 물리, 화학적 특성조사 및 분자의 물리화학적 변화를 통해 발생하는 현상과 소재를 연구한다.","doWork":"빛에 의해 야기되는 분자의 물리화학적 특성을 조사한다. 분자의 물리화학적 변화를 통해 빛을 발생하는 현상과 소재를 연구한다. 유기광화학(Organic Photochemistry)분야의 경우, 유기화합물들과 빛의 상호작용과 그에 의한 새로운 화합물의 합성 및 그 반응 메커니즘을 연구한다. 무기광화학(Inorganic Photochemistry)분야의 경우, 무기화합물과 광양자의 상호작용과 그 메커니즘, 광촉매의 합성 및 특성분석과 응용성을 연구한다. 생물광화학(Biological Photochemistry)분야의 경우, 식물 및 동물조직과 광양자의 상호작용과 그 메커니즘을 분자수준에서 이해하고 생체모방 광 수용체의 설계합성과 응용을 연구한다. 고분자광화학(Polymer Photochemistry)분야의 경우, 유기화합물의 광화학적 반응을 이용하여 고분자를 합성하고, 고분자의 광분해와 그 반응 메커니즘을 이해하며 이를 반도체 및 환경산업에 응용하는 연구를 한다. 물리광화학(Physical Photochemistry)분야의 경우 빛에 의한 유기, 무기, 고분자 및 생체물질들의 광에너지 흡수 및 전달, 전자이동, 분자구조 및 전자구조의 동역학적 변화 등의 물리화학적 성질을 연구한다. 광소재화학(Materials Photochemistry)분야의 경우, 광감성 물질들의 광유발 전하발생 및 전달현상의 메커니즘과 동역학적 성질을 전기화학적 방법으로 규명하며, 광·전자기능을 갖는 유기, 무기 및 고분자물질과 나노물질을 합성 및 설계하고 그 특성과 응용성을 연구한다. 태양에너지화학(Solar Energy Chemistry)분야의 경우, 차세대 대체에너지원으로의 태양에너지를 효율적으로 전환하고 저장할 수 있는 물질과 시스템을 설계 합성하고 그 메커니즘 규명과 응용성을 연구한다. 전기광화학(Electrophotochemistry)분야의 경우, 전기적인 에너지를 이용하여 빛을 발생시키는 현상과 장치를 연구한다. 단일분자 및 단일나노입자들의 광물리 및 광화학적 특성을 분석하고 연구한다. 광이용 및 광발생 관련 제반 광화학분야의 연구를 수행하기도 한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|언어력|시각|","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"협의","workFunc3":"정밀작업","connectJob":"유기광화학연구원, 무기광화학연구원, 생물광화학연구원, 고분자광화학연구원, 물리광화학연구원, 광소재화학연구원, 태양에너지화학연구원, 전기광화학연구원","dJobECd":"1211","dJobECdNm":"[1211]자연과학 연구원","dJobJCd":"2112","dJobJCdNm":"[2112]자연과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006280:1', '{"dJobCd":"K000006280","dJobCdSeq":"1","dJobNm":"극지과학연구원","workSum":"남·북극의 독특한 지리적, 환경적 특성을 대상으로 빙하, 대기, 지질, 해양, 생물학적 요소들 간의 상호작용이나 과정을 연구하고 미래의 극지자원 및 공간활용의 극대화를 연구한다.","doWork":"빙하학(Glaciology)분야의 경우, 남극과 북극의 극지지역과 고산지대에 분포하는 모든 형태의 얼음을 대상으로 기후학적, 대기화학적, 지질학적, 기상학적, 지구물리학적, 결정학적 특성을 규명하는 다학제적 연구를 수행한다. 동토학(Permafrost)분야의 경우, 극지역 동토의 역학적 특성규명과 지구 기후변화와 관련된 동토의 물리, 화학, 생물학적 변동을 추적하는 연구를 수행한다. 극지환경감시·극지생지화학순환(Polar Environmental Monitoring and Polar Biogeochemical Cycles)분야의 경우, 극지 기후변화와 관련한 대기특성, 온난화 및 극진동과의 영향, 고기후·고해양, 대기-해양 간의 물질순환의 감시 및 응용, 극대기순환의 모델링 등을 포함하는 다학제적 연구를 수행한다. 극지 생물자원 탐사·수집·활용(Utilization of Polar Bioresources)분야의 경우, 극한환경에 서식하는 생물자원을 직접적으로 이용하거나 이들 생물로부터 신소재 및 신물질 등을 개발하여 자원화할 수 있는 기술개발에 대한 연구를 수행한다. 극지광물자원탐사(Utilization of Polar Mineral Resources)분야의 경우, 극한지를 대상으로 석탄, 석유, 천연가스, 가스수화물 등 에너지자원의 분포를 파악하고 고부가가치 희유금속광물의 성인을 연구하고, 극한지의 대체에너지(빙하, 태양열, 풍력 등) 개발을 위한 기반 기술분야에 대한 연구를 수행한다. 극지생태계모니터링(Polar Ecosystem Monitoring)분야의 경우, 현재 일어나고 있는 전지구적 환경변화(지구온난화, 오존층 파괴 등)와 극지에서의 인간활동으로 인한 환경오염을 정기적으로 감시하고 생태계에 대한 영향을 진단 예측하는 연구를 수행한다. 극지 우주과학(Polar Space Science) 분야의 경우, 오로라 등의 극권에서 독특하게 일어나는 물리현상을 이해하고 열권과 중간권의 물리적 특성 및 온도분포, 우주기상을 관측하고 해석하는 연구를 수행한다. 극지저온생물학·적응생리(Cryobiology and Physiology)분야의 경우, 극한지에 서식하는 생물들의 환경적응 생리기작과 대량배양기술연구, 결빙방지물질의 분리정제 및 구조결정 등에 대한 연구를 수행한다. 극지인프라구축 및 활용(Polar Infrastructure Construction and Use)분야의 경우, 극지연구를 위해 필요한 기지의 건설, 운용, 유지, 물류, 항만 등에 대한 연구를 수행한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"균형감각|손사용|시각|","workEnv":"대기환경미흡|위험내재|저온|다습|","workFunc1":"분석","workFunc2":"협의","workFunc3":"정밀작업","connectJob":"빙하학연구원, 동토학연구원, 극지환경감시연구원, 극지생물자원탐사연구원, 극지광물자원탐사연구원, 극지생태계연구원, 극지해양연구원, 극지우주과학연구원, 극지저온생물학연구원","dJobECd":"1211","dJobECdNm":"[1211]자연과학 연구원","dJobJCd":"2112","dJobJCdNm":"[2112]자연과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001794:1', '{"dJobCd":"K000001794","dJobCdSeq":"1","dJobNm":"기상연구원","workSum":"기상전반 및 기후특성을 조사·분석하고, 예보기법을 연구·개발한다.","doWork":"대기의 종관적·역학적 구조, 수치예보 모형, 해양기상 및 태풍에 관하여 연구한다. 해양기상 관측을 위해 설치된 부이로부터 각종 관측자료를 수집한다. 위성, 레이더 등 원격탐사에 의한 활용기술과 예보적용에 관하여 연구한다. 원격탐사장비의 특성과 중규모 기상현상 및 구름물리에 관하여 연구한다. 이동식 기상레이다의 운영 및 고층대기에 관하여 연구한다. 환경·수문(水文)·농업·생물기상, 대기난류, 대기화학, 기후변화 등 응용기상에 관하여 연구한다. 기상측기의 정밀도 향상 등 기상계측 기술개발에 관하여 연구한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","similarNm":"기상학연구원","connectJob":"연구분야에 따라 기상계측연구원, 예보연구원, 원격탐사연구원, 응용기상연구원, 기상관측분석기술연구원, 기상원격탐사기술연구원, 기상예보기술연구원, 기상조절연구원, 수치예보연구원, 농업기상연구원, 해양기상연구원, 보건기상연구원, 산업기상연구원, 항공기상연구원, 생명기상연구원","certLic":"기상예보기술사, 기상기사, 기상감정기사","dJobECd":"1211","dJobECdNm":"[1211]자연과학 연구원","dJobJCd":"2112","dJobJCdNm":"[2112]자연과학 연구원","dJobICd":"M701/O841","dJobICdNm":"[M701]자연과학 및 공학 연구개발업 / [O841]입법 및 일반 정부 행정","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003343:1', '{"dJobCd":"K000003343","dJobCdSeq":"1","dJobNm":"기상컨설턴트","workSum":"기상정보를 필요로 하는 기업을 대상으로 기상정보와 이윤창출과의 관계, 날씨위험관리, 날씨영향분석 등에 정보를 분석하여 제공한다.","doWork":"고객을 대상으로 요구분석을 실시하여 기업에 필요한 기상정보를 파악한다. 날씨와 이윤창출의 관계, 날씨위험의 결과분석, 날씨의 영향관계 등을 분석하여 고객에게 제안한다. 기상정보 제공에 관한 정보를 수집한다. 웹 등 각종 매체로 제공할 수 있는 기상정보 콘텐츠를 기획한다. 시뮬레이션 등의 영향예측평가시스템으로 기상과 대지질의 영향을 분석하고 이를 고객에게 제공한다. 시스템의 오류를 개선하거나 고객의 불만을 해소하는 방식 등으로 사후 고객관리를 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","similarNm":"날씨경영컨설턴트","certLic":"기상예보기술사, 기상기사, 기상감정기사","dJobECd":"1211","dJobECdNm":"[1211]자연과학 연구원","dJobJCd":"2112","dJobJCdNm":"[2112]자연과학 연구원","dJobICd":"M739","dJobICdNm":"[M739]그 외 기타 전문, 과학 및 기술 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006061:1', '{"dJobCd":"K000006061","dJobCdSeq":"1","dJobNm":"기후변화연구원","workSum":"기후변화의 원인을 분석하고 기후변화에 따른 적응, 온실가스 저감 등의 대응책을 연구한다.","doWork":"지구온난화 등에 따라 장기간에 걸쳐 진행되는 기후의 변화를 예측하고 온실가스와 같이 인위적인 기후변화요인을 파악하기 위한 조사 및 연구를 한다. 온난화, 태풍, 가뭄, 해수온도의 상승 등의 기후변화가 일상생활에 미치는 영향을 평가하여 좋지 않은 영향에 대해 대응책을 수립한다. 온난화와 기후변화에 대한 대응방법을 교육한다. 기후변화요인을 억제하기 위해 온실가스저감 등과 같은 연구를 한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"기상예보기술사, 기상기사, 기상감정기사","dJobECd":"1211","dJobECdNm":"[1211]자연과학 연구원","dJobJCd":"2112","dJobJCdNm":"[2112]자연과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001456:1', '{"dJobCd":"K000001456","dJobCdSeq":"1","dJobNm":"나노화학연구원","workSum":"나노미터 수준의 크기를 가지는 유기 및 무기합성 고분입자의 합성과 물성, 그리고 그 활용을 연구한다.","doWork":"나노소재화학(Nanomaterials Chemistry)분야의 경우, 나노 크기의 소재를 합성하고 활용하는 연구를 수행한다. 나노물성화학(Properties of Nanomaterials)분야의 경우, 나노입자의 물성을 조사하거나 조사하는 방법을 개발하는 연구를 수행한다. 나노의약화학(Nanomedicinal Chemistry)분야의 경우, 나노 크기의 약물을 합성하고, 이를 전달하는 방법을 연구하고 나노입자의 생리활성 등을 연구한다. 무기나노화학(Inorganic Nanochemistry)분야의 경우, 나노 크기의 무기질입자를 합성하고 응용하는 연구를 수행한다. 나노고분자화학(Nanopolymers)분야의 경우, 나노 크기의 고분자 입자를 합성하고 응용하는 연구를 수행한다. 나노바이오화학(Nanobiochemistry)분야의 경우, 나노입자에 생화합물을 접합시키거나 생체나노입자에 합성나노입자를 결합시키는 등 합성나노물질과 생체물질 사이의 상호작용을 연구하고 응용하는 연구를 수행한다. 나노광화학(Nanophotochemistry)분야의 경우, 나노입자와 빛과의 상호작용, 빛 발생현상 등을 연구하고 응용한다. 나노구조화학(Nanostructures)분야의 경우, 나노입자의 구조를 연구한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|언어력|시각|","workEnv":"대기환경미흡|위험내재|","workFunc1":"분석","workFunc2":"협의","workFunc3":"정밀작업","connectJob":"나노소재화학연구원, 나노물성화학연구원, 나노의약화학연구원, 무기나노화학연구원, 나노고분자화학연구원, 나노바이오화학연구원, 나노광화학연구원, 나노구조화학연구원","dJobECd":"1211","dJobECdNm":"[1211]자연과학 연구원","dJobJCd":"2112","dJobJCdNm":"[2112]자연과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004800:1', '{"dJobCd":"K000004800","dJobCdSeq":"1","dJobNm":"노심계통해석연구원","workSum":"원자로 및 핵연료에 대한 제어, 감시, 보호 및 원소변동과 핵반응 정도 등에 대한 기술적인 사항을 진단·분석·평가하기 위한 연구·개발 업무를 수행한다.","doWork":"핵분열 반응이 이루어지는 부분인 노심의 안전성 확보 및 경제적 연소를 위한 노심설계 및 운전상황 분석에 대한 업무를 수행한다. 노심보호 및 감시업무를 한다. 중수로에 대한 연구, 개발을 통하여 중수가 핵연료의 감속재 및 냉각재의 역할을 할 수 있도록 관리한다. 연료개발 및 연료주기를 분석하여 원자력발전이 안정적이고 경제적으로 이루어지도록 연구한다. 원자력발전 운영에 따른 방사성 물질의 노출로부터 사람을 보호하기 위한 차폐기술, 임계로 해석, 방사선원항 분석에 관한 연구업무를 한다. 원자력발전의 계통열을 이용한 수력연구를 한다. 기타 노심계통에 관한 연구·개발업무를 수행한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","dJobECd":"1211","dJobECdNm":"[1211]자연과학 연구원","dJobJCd":"2112","dJobJCdNm":"[2112]자연과학 연구원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006690:1', '{"dJobCd":"K000006690","dJobCdSeq":"1","dJobNm":"농어업온실가스연구원","workSum":"농림어업분야 온실가스 배출량 평가, 온실가스 저감을 위한 재배기술개발 및 관련 연구를 한다.","doWork":"물관리 개선, 가축분뇨 처리향상, 지열활용 등 농림어업분야의 온실가스배출 원천저감을 위한 기술개발을 한다. 의무감축 목표를 달성하기 위한 저탄소 농법도입, 시설원예 에너지절감, 도시농업활성화, 반추가축의 장내발효개선, 분뇨의 적정처리 등을 연구한다. 밭과 논에서 발생하는 아산화질소의 배출현황, 특성, 배출량 평가방법을 분석해 농식품분야의 온실가스를 줄이기 위한 재배기술 등을 연구·개발한다. 유기물 사용, 경운관리, 물관리, 질산화억제제 사용, 작부체계 등 아산화질소 발생감축을 위한 재배기술연구를 한다. 녹비비료를 이용해서 화학비료의 부작용을 줄이는 방법을 연구하고 효과를 분석한다. 관개수의 사용량을 줄이면서도 아산화질소를 낮추고 일정한 토양수분장력을 유지할 수 있는 방법을 연구한다. 탄소상쇄제도, 저탄소인증제 등을 연구하고 농림어업분야의 온실가스감축을 위한 정책을 개발한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1211","dJobECdNm":"[1211]자연과학 연구원","dJobJCd":"2112","dJobJCdNm":"[2112]자연과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006698:1', '{"dJobCd":"K000006698","dJobCdSeq":"1","dJobNm":"단백질화학연구원","workSum":"유전자재조합기술을 이용한 면역조절제, 백신, 치료용효소제제, 펩타이드호르몬 등 신의약품과 의학적으로 유용한 단백질을 개발하고 역가측정 등의 연구를 수행한다.","doWork":"유전인자를 조작하여 동물세포 또는 미생물의 형질을 전환시킨다. 형질이 전환된 동물세포 또는 미생물을 배양한다. 만들고자 하는 단백질의 구조와 기능을 조사한다. 동물세포 또는 미생물배양을 통해 만들어진 단백질을 크로마토그래피(Chromatography)를 통해 정제한다. 정제된 단백질의 역가를 여러 가지 방법을 통해 측정한다. 화학적 방법에 의하여 펩타이드를 합성하고 분리·정제한다. 쥐, 토끼 등 실험동물에게 항원을 주사하여 항체를 생산한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"대기환경미흡|위험내재|","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","dJobECd":"1211","dJobECdNm":"[1211]자연과학 연구원","dJobJCd":"2112","dJobJCdNm":"[2112]자연과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003554:1', '{"dJobCd":"K000003554","dJobCdSeq":"1","dJobNm":"무기화학연구원","workSum":"주기율표에 나열된 다양한 원소를 함유하는 화합물의 합성과 구조분석, 물리-화학적 성질 규명, 반응 메커니즘 규명 및 응용을 연구한다.","doWork":"분리분석화학(Analytical Separations Methods) 분야의 경우 크로마토그래피, 전기영동 등을 이용하여 혼합물을 분리하여 정성 및 정량적으로 분석하고, 이러한 분리분석 방법을 개선하거나 새로운 분리분석 방법을 개발하는 연구를 수행한다. 분광분석화학((Spectrometry) 분야의 경우 빛과 물질과의 상호작용을 이용하여 분자의 구조를 결정하거나 정량적 분석하고, 그러한 방법을 개발하는 연구를 수행한다. 표면분석화학(Surface analysis) 분야의 경우 고체 표면의 구조 및 조성을 다양한 기기를 이용하여 분석하거나 그러한 방법을 개발하는 연구를 수행한다. 구조분석화학((Molecular Structure Analysis)분야는 분자의 구조를 분석하는 연구를 수행한다. 환경분석화학(Environmental Analytical Chemistry)의 경우 환경유해 물질을 분석하거나 그러한 방법을 개발하는 연구를 수행한다. 질량분석학(Mass spectrometry) 분야는 Mass spectrometer를 이용하여 화합물의 분자량을측정하거나 구조를 분석하고, 그러한 방법을 개발하는 연구를 수행한다. 화학기기학(Chemical Instrumentation) 분야는  화학분석에 사용되는 분석기기의 개선 및 개발을 연구한다. 생분석화학(Bioanalytical Chemistry) 분야는 생물질(Biomaterials)의 성질과 양을 결정하거나 그러한 방법을 개발하는 연구를 수행한다. 마이크로칩 화학분석(Chemical Analysis on Microchips) 분야는 화학분석용마이크로칩을 개발하거나 응용하는 연구를 수행한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","connectJob":"이론무기화학연구원, 무기초분자화학연구원, 유기금속화학연구원, 생무기화학연구원, 고체무기화학연구원, 무기소재화학연구원, 촉매화학연구원, 무기의약화학연구원","dJobECd":"1211","dJobECdNm":"[1211]자연과학 연구원","dJobJCd":"2112","dJobJCdNm":"[2112]자연과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001594:1', '{"dJobCd":"K000001594","dJobCdSeq":"1","dJobNm":"물리표준연구원","workSum":"질량, 힘, 온·습도, 유체유동, 음향진동, 진공기술분야의 국가표준을 확립·보급하기 위한 첨단측정기술을 연구하고, 산업체에서 의뢰하는 측정장비에 대하여 교정·시험한다.","doWork":"질량, 힘, 온·습도, 유체유동, 음향진동, 진공기술분야의 국가표준의 국제적 동등성 유지를 위한 국제도량형위원회, 국제측정연합 등에 참여하고 공동연구를 한다. 외부기관에서 의뢰한 측정기기를 원기와 비교하여 교정하고 시험·검사한다. 측정표준용 핵심소자 개발, 나노 및 신기술 융합 등 첨단기술을 연구한다. 혈압계, 혈당측정기, 보청기 등 계측기술을 개발한다. 극청정 진공부품, 시스템 및 공정의 신뢰성 제고를 위한 종합평가장치를 구축한다. 물리분야의 국가표준을 보급시키기 위해 산업계 및 과학계 실무자를 대상으로 교육한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1211","dJobECdNm":"[1211]자연과학 연구원","dJobJCd":"2112","dJobJCdNm":"[2112]자연과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007568:1', '{"dJobCd":"K000007568","dJobCdSeq":"1","dJobNm":"물리학연구원","workSum":"자연현상을 관찰·실험하여 물리학의 원리, 기법을 연구·개발하고 산업, 의료, 군사분야에 응용하기 위하여 연구한다.","doWork":"분자증폭기(Maser), 레이저(Razer), 원자핵파괴장치(Cyclotron), 전자가속장치(Betatron), 망원경, 질량분석기, 전자현미경 등의 장비를 사용하여 물질의 구조적 특성, 에너지의 변환 및 전달, 물질과 에너지와의 관계 및 기타 물리학적 현상을 관찰·실험한다. 수학적 기법과 모델을 이용하여 조사 및 실험결과를 평가하고 결론을 공표한다. 물질에 관한 물리학적 검증절차를 고안한다. 고형물질의 구조와 특성을 조사하기 위해 온도, 압력, 응력 등 제반 환경조건을 변화시켜 실험·시험하고 반응을 연구·분석한다. 물리학논문 및 보고서를 작성한다. 물리학의 특정분야를 전문으로 연구하기도 한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"물리학자","connectJob":"광물리학연구원, 보건물리학연구원, 역학물리학연구원, 열물리학연구원, 음향물리학연구원, 전자물리학연구원, 핵물리학 연구원","dJobECd":"1211","dJobECdNm":"[1211]자연과학 연구원","dJobJCd":"2112","dJobJCdNm":"[2112]자연과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002641:1', '{"dJobCd":"K000002641","dJobCdSeq":"1","dJobNm":"방사선연구원","workSum":"원자력발전소의 방사선안전 및 주변환경보전을 위한 연구 및 개발업무를 수행한다.","doWork":"원자력발전소 종사원의 방사선피폭평가, 방사선량 저감화 및 발전소 유출물 관리 등 방사선 안전성 확보를 위해 연구한다. 환경방사선 감시 및 영향평가, 방사선 비상대응기술에 대한 연구업무를 수행한다. 계통재질의 건전성 확보 및 방사선량 저감화를 위해 경수로계통 내 아연주입 기술, 이산화탄소 저감기술, 계통화학 제염공정 및 장치, 고도 수처리기술, 증기발생기 세정기술, 고효율 담수화기술, 폐수처리공정 등의 연구·개발업무를 수행한다. 발전소의 배기가스로부터 이산화탄소를 효율적으로 분리회수하고 처분할 수 있는 기반기술을 연구·개발한다. 환경생태계의 영향 최소화 방안연구, 환경오염 저감기술 등의 연구·개발업무를 수행한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","certLic":"방사성동위원소취급면허, 핵연료물질취급면허, 원자력기사, 방사선관리기술사","dJobECd":"1211","dJobECdNm":"[1211]자연과학 연구원","dJobJCd":"2112","dJobJCdNm":"[2112]자연과학 연구원","dJobICd":"D351/M701","dJobICdNm":"[D351]전기업 / [M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004056:1', '{"dJobCd":"K000004056","dJobCdSeq":"1","dJobNm":"산업수학모더레이터","workSum":"산업현장에서 필요로 하는 문제를 수학적 지식과 방법으로 해결한다.","doWork":"기업체의 문제를 접수한다. 기업체의 담당자와 면담을 통해 수학적으로 해결이 가능한 문제 또는 공공적 차원의 문제 여부를 파악한다. 기업체의 문제를 기업관계자와 함께 정의하고 문제해결을 위한 세미나를 진행한다. 단기해결이 가능한 문제의 경우 문제해결방법에 따라 해결책을 마련하여 문제를 해결한다. 해결된 문제의 보고서를 기업체에 보낸다. 문제해결을 위해 전문가그룹 형성의 필요성이 있으면 중재자 역할을 하기도 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"자문","workFunc3":"관련없음","similarNm":"수학모더레이터, 산업수학코디네이터, 산업수학컨설턴트","dJobECd":"1211","dJobECdNm":"[1211]자연과학 연구원","dJobJCd":"2112","dJobJCdNm":"[2112]자연과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006789:1', '{"dJobCd":"K000006789","dJobCdSeq":"1","dJobNm":"수학연구원","workSum":"기초수학분야나 과학·경영학 또는 기타 분야에 수학적 기술을 적용하거나 수학적 방법에 의하여 여러 분야의 문제점을 해결하기 위한 연구를 한다.","doWork":"대수·기하·진법이론, 논리학, 위상수학 등 수학분야의 기초이론을 연구하고 가설 또는 선택이론을 시험·연구한다. 과학, 공학, 군사계획, 전산자료처리, 경영학 등 다양한 분야의 수학적 적용가능성을 개발한다. 물리학, 공학, 천문학, 생물학, 경제학, 산업경영학 및 기타 기능적 분야에서 수학적 지식을 적용한다. 수학적인 방법 및 응용과 관련된 연구자들에게 조언을 하기도 한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"전문적으로 연구하는 분야에 따라 순수수학연구원, 응용수학연구원","dJobECd":"1211","dJobECdNm":"[1211]자연과학 연구원","dJobJCd":"2112","dJobJCdNm":"[2112]자연과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005676:1', '{"dJobCd":"K000005676","dJobCdSeq":"1","dJobNm":"연구원(일반)","workSum":"전문적인 지식을 갖고 인문, 사회, 자연 등 관련 학문을 연구하며 이를 토대로 새로운 지식을 발견하고 제품, 공정, 서비스를 개발 및 개선한다.","doWork":"문헌조사를 통해 연구주제를 선정한다. 연구목적, 방법, 일정 등이 포함된 연구제안서를 작성한다. 연구소, 정부기관 및 관련 단체에서 연구제안서를 발표한다. 각종 장비, 설비, 재료, 기계 등을 사용하여 실험·분석한다. 연구결과를 토대로 제품이나 서비스 등을 개발한다. 최종 연구결과를 보고서로 작성한다. 학회, 연구기관 및 공청회 등에서 연구결과를 발표하거나 토론한다. 연구결과의 시사점 등을 전달하거나 강의한다. 각종 정책, 연구 등에 대해 자문한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내·외","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"1211","dJobECdNm":"[1211]자연과학 연구원","dJobJCd":"2112","dJobJCdNm":"[2112]자연과학 연구원","dJobICd":"C","dJobICdNm":"[C]제조업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006072:1', '{"dJobCd":"K000006072","dJobCdSeq":"1","dJobNm":"우주전파환경예보관","workSum":"태양활동에 의한 우주전파환경 변화로 방송·통신, 위성, 항공, 항법, 전력 등의 피해를 일으키는 우주전파재난에 대응하고자 실시간 우주전파환경 변화를 관측하여 예측하고 경보를 발령한다.","doWork":"흑점, 태양 X선, 태양전파 등의 자료를 이용하여 태양 흑점에 의한 흑점 폭발 현상을 분석 및 예측한다(태양흑점폭발(R)). 흑점, 코로나물질방출 고에너지 양성자 등의 자료를 이용하여 고에너지 양성자의 증가 현상을 분석 및 예측한다(태양입자유입(S)). 코로나물질방출, 필라멘트, 태양풍 밀도·속도, 행성간 자기장, 지구자기장 등의 자료를 이용하여 태양활동에 의한 지구자기장 변화를 분석 및 예측(지자기교란(G))한다, 태양 X선, HF 전리권 관측, 전리권총전자량 등의 자료 이용하여 태양활동에 의한 한반도 전리권 변화를 분석 및 예측한다(전리권교란(I)).","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","dJobECd":"1211","dJobECdNm":"[1211]자연과학 연구원","dJobJCd":"2112","dJobJCdNm":"[2112]자연과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005173:1', '{"dJobCd":"K000005173","dJobCdSeq":"1","dJobNm":"유기분석연구원","workSum":"유기 및 가스, 생화학물질의 분석에 관련된 측정법 개발과 표준기준물을 개발·보급한다.","doWork":"각종 표준가스, 임상검사용 혈청표준기준물, 유해환경오염유기물질측정용 표준기준물 등 인증표준기준물질을 개발·보급한다. 유기, 생화학 및 가스분석법을 개발한다. 미량가스분석기술을 개발한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","dJobECd":"1211","dJobECdNm":"[1211]자연과학 연구원","dJobJCd":"2112","dJobJCdNm":"[2112]자연과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007182:1', '{"dJobCd":"K000007182","dJobCdSeq":"1","dJobNm":"유기화학연구원","workSum":"유기물질의 합성, 반응성조사, 구조분석, 시약 개발, 반응메커니즘 규명 및 응용을 연구한다.","doWork":"천연물화학(Natural Products Chemistry) 분야의 경우 자연에서 효용성 있는 물질을분리하거나 합성하는 연구를 수행한다. 유기합성/전합성(Organic Synthesis/Total Synthesis): 분야의 경우 화합물의 기능기를이용하거나 혹은 전자의 변화를 기초로 하여 목표로 하는 물질을 만들어나가는 연구를 수행한다. 유기합성방법론(Synthetic Methodology) 분야의 경우 유기화합물을 만들기 위한 다양한 실험방법 및 반응물질을 개발하는 연구를 수행한다. \n이론/물리 유기화학((Synthetic Methodology)의 경우 계산이나 이론에 중점을 두어 유기화합물의 구조, 에너지 및 반응의 특성을 연구하고, 유기화학 반응의 메커니즘을 규명하거나 모델분자를 통하여 이론을\n증명하거나 새로운 이론을 확립하는 연구를 수행한다. 유기초분자화학(Organic Supramolecular Chemistry)의 경우 분자들이 이루는 구조물 혹은 화합체의 설계, 합성 및 특성을 다루는 연구를 수행한다. 유기금속시약화학(Organometallic Reagents Chemistry)의 경우 유기금속화합물로이루어진 시약을 개발하고 이를 이용하여 유기물질을 합성하는 연구를 수행한다. 생유기화학(Bioorganic Chemistry)의 경우 생체물질 및 유사한 화학물질을 설계하고 합성하여 분석하는 연구를 수행한다. 의약/조합 화학(Medicinal/Combinatorial Chemistry)의 분야의 경우 신약 합성 등 의약용 물질을 설계하고 합성하여 생리 활성물질의 발견이나 의약용 응용성을 추구하는 연구를 수행한다. \n유기재료화학(Organic materials chemistry) 분야의 경우 신기능 소재로서 이용할 수 있는 유기분자의 합성 및 특성 연구를 수행한다. 유화학(Emulsification chemistry) 분야의 경우 계면활성제의 합성, 특성 및 응용을 연구한다.\n그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","connectJob":"유기물의 합성메카니즘 및 응용 등의 합성에 관해 연구하는 경우 유기합성연구원, 연구하는 분야에 따라 천연물화학연구원, 유기초분자화학연구원, 유기금속시약화학연구원, 생유기화학연구원, 유기재료화학연구원","dJobECd":"1211","dJobECdNm":"[1211]자연과학 연구원","dJobJCd":"2112","dJobJCdNm":"[2112]자연과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004830:1', '{"dJobCd":"K000004830","dJobCdSeq":"1","dJobNm":"융합화학연구원","workSum":"화학과 인접학문과의 경계에서 도출된 새로운 지식을 기반으로 다양한 응용분야에 대한 분자과학적인 기초지식과 원천기술을 연구·개발한다.","doWork":"환경화학(Environmental Chemistry)분야의 경우, 화합물들이 환경에 미치는 영향을 분석하고, 미량의 환경오염물질을 검출하는 방법을 개발하며 환경친화적인 화합물을 설계하고 합성하는 연구를 수행한다. 화학생물학(Chemical Biology)분야의 경우, 화학과 생물학의 융합학문으로서 분자수준에서 화학적 방법을 이용하여 생물학적 문제점들을 해결하는 연구를 수행한다. 화학유전체학(Chemical Genetics and Genomics)분야의 경우, 저분자화합물의 체계적인 활용을 통해서 단백질기능, 표현형 및 생체기능 조절물질을 도출해내는 연구를 수행한다. 화학정보학(Cheminformatics)분야의 경우, 방대한 화합물질로 이루어진 화학공간(Chemical Space)를 구성하는 분자계의 구조, 분광학적 특성, 화학반응과 반응성, 생리활성 등에 대한 화학정보의 저장, 조작, 표현과 응용에 관한 연구를 수행한다. 계산화학(Computational Chemistry)분야의 경우, 분자계의 특성과 거동을 기술하는 이론적 개념에 근거하여 컴퓨터를 이용한 다양한 계산방법론을 적용하여 분자 및 분자계의 구조와 동역학을 다루어 여러 분야에서 응용을 추구하는 연구를 수행한다. 화학적 바이오칩(Chemical Biochip)분야의 경우, 칩 표면 위에 NDA, 단백질, 저분자화합물들을 고정시키는 방법을 개발하고 이를 이용하여 다수의 상호작용을 동시에 특정하고 검색할 수 있는 방법을 개발하며 진단 등에 활용할 수 있는 연구를 수행한다. 고효율생리활성검색(High-throughput Screening Methods)분야의 경우, 다양한 경로를 통해서 구축된 저분자화합물 라이브러리의 생리활성도를 고속으로 검색하는 시스템을 개발하고 이를 응용하여 생리활성물질을 도출하는 연구를 수행한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|언어력|시각|","workEnv":"대기환경미흡|위험내재|","workFunc1":"분석","workFunc2":"협의","workFunc3":"정밀작업","connectJob":"환경화학연구원, 화학생물학연구원, 화학유전체학연구원, 화학정보학연구원, 계산화학연구원, 바이오칩연구원, 핵방사화학연구원","dJobECd":"1211","dJobECdNm":"[1211]자연과학 연구원","dJobJCd":"2112","dJobJCdNm":"[2112]자연과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001833:1', '{"dJobCd":"K000001833","dJobCdSeq":"1","dJobNm":"의료보건통계전문가","workSum":"신약개발, 치료법 효과측정, 질병유발인자 추출, 환자의 생존기간 등 보건, 의학 임상 및 생물분야 연구에서 통계적 이론과 기법을 활용하여 연구를 설계하고 분석하며 조언한다.","doWork":"연구자의 연구계획을 토대로 연구대상 선정, 가설설정, 샘플링 방법, 통계분석기법 등 통계분석을 위한 연구설계를 수행한다. 관련 통계패키지 등을 활용하여 조사된 결과를 분석한다. 분석결과를 토대로 모델링을 한다. 샘플링방법, 가설, 분석결과 등을 담은 통계보고서를 작성한다. 연구설계, 자료구축방법, 통계분석방법, 통계소프트웨어 사용방법 등에 대해 연구자 등에게 조언한다. 통계패키지 사용법, 통계이론과 기법 등에 대해 교육한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","connectJob":"임상시험통계연구원, 의약통계연구원, 임상통계전문가","dJobECd":"1211","dJobECdNm":"[1211]자연과학 연구원","dJobJCd":"2112","dJobJCdNm":"[2112]자연과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002400:1', '{"dJobCd":"K000002400","dJobCdSeq":"1","dJobNm":"인공어초개발자","workSum":"인공어초(해양생태계의 복원을 위해 어류, 패류, 해조류 등의 서식을 목적으로 콘크리트나 세라믹, 철재 등의 재료로 만들어 바다에 설치하는 인공구조물)를 연구·개발한다.","doWork":"인공어초의 구조와 재질, 대상 생물(어류, 패류, 해조류) 검토, 대상 어종의 어장조성 적합 여부, 유해물질의 용출 여부, 주변환경과의 조화성, 어초의 안정성, 제작 및 시설비의 적정성 등을 평가한다. 수리모형실험을 통해 설계된 어초의 구조적 내구성 및 안정성, 환경에 대한 영향 등을 평가한다. 연구어초과정을 통해 생태적 효과 및 안정성을 실험·평가한다. 시험어초단계를 통해 시설적합성, 경제성, 물량 적정성, 기능 및 효과, 내구성 및 안정성을 평가받는다. 평가결과에 따라 부적격 판정이 나오면 부적합한 항목을 보완·수정한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","similarNm":"인공어초연구개발자","dJobECd":"1211","dJobECdNm":"[1211]자연과학 연구원","dJobJCd":"2112","dJobJCdNm":"[2112]자연과학 연구원","dJobICd":"C201","dJobICdNm":"[C201]기초 화학물질 제조업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002783:1', '{"dJobCd":"K000002783","dJobCdSeq":"1","dJobNm":"인지과학연구원","workSum":"컴퓨터 모사, 신경영상학, 정신물리학, 프로토콜 분석 등의 연구방법을 사용하여 인간의 인지와 감성, 기타 응용분야를 다학제적인 접근방법을 통해 연구한다.","doWork":"인간의 인지에 대하여 연구하는 경우, 인간의 감각·지각·주의 정보처리, 운동조절 정보처리, 학습·기억 정보처리, 언어 정보처리, 고등사고 정보처리, 인지신경 정보처리, 인지과학응용 등에 대한 연구를 수행한다. 인간의 감성에 대하여 연구하는 경우, 감성측정·평가·이론, 감성심리·생리, 감성디자인·콘텐츠, 감성융합, 감성의류·산업·환경 등에 대한 연구를 수행한다. 철학, 심리학, 언어학 등 다양한 인접학문을 응용하여 다학제적인 연구를 수행한다. 연구를 수행하기 위하여 컴퓨터 모사, 신경영상학, 정신물리학, 프로토콜 분석 등의 연구방법을 사용한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"청각|언어력|시각|","workFunc1":"분석","workFunc2":"협의","workFunc3":"정밀작업","similarNm":"감성과학연구원","connectJob":"감각정보처리연구원, 운동조절정보처리연구원, 학습기억정보처리연구원, 언어정보처리연구원, 고등사고정보처리연구원, 인지신경정보처리연구원, 응용인지과학연구원, 감성측정평가연구원, 감성심리생리연구원, 감성디자인콘텐츠연구원","dJobECd":"1211","dJobECdNm":"[1211]자연과학 연구원","dJobJCd":"2112","dJobJCdNm":"[2112]자연과학 연구원","dJobICd":"M701/M702","dJobICdNm":"[M701]자연과학 및 공학 연구개발업 / [M702]인문 및 사회과학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003269:1', '{"dJobCd":"K000003269","dJobCdSeq":"1","dJobNm":"적정기술전문가","workSum":"한 공동체의 문화적, 정치적, 환경적 면을 고려하여 적용되는 적정기술(그 기술이 사용되는 사회공동체의 정치적, 문화적, 환경적 조건을 고려해 해당 지역에서 지속적인 생산과 소비가 가능하도록 만들어진 기술로 인간의 삶과 질을 궁극적으로 향상시킬 수 있는 기술)을 연구하거나 교육 및 컨설팅한다.","doWork":"지역사회의 인프라 수준을 고려하여 기술 필요계층을 파악하고 다양한 분야에 필요한 적정기술을 연구한다. 적정기술을 활용한 자립형 제품을 개발할 수 있는 프로세스에 대해 연구한다. 저렴한 비용으로 현지상황에 맞는 재료 및 기술로 사용자가 스스로 제조할 수 있는 적정기술을 개발하고 교육한다. 적정기술로 사회적, 환경적 문제 등을 해결할 수 있는 방법에 대해 컨설팅한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"종합","workFunc2":"자문","workFunc3":"제어조작","similarNm":"대안기술전문가, 중간기술전문가","dJobECd":"1211","dJobECdNm":"[1211]자연과학 연구원","dJobJCd":"2112","dJobJCdNm":"[2112]자연과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006730:1', '{"dJobCd":"K000006730","dJobCdSeq":"1","dJobNm":"전기화학연구원","workSum":"화학반응을 통해 전기에너지를 발생시키거나 또는 전기에너지를 이용해 화학반응을 일으키는 현상을 연구하고 관련 장치를 개발하며, 이러한 현상과 장치를 응용하는 연구를 수행한다.","doWork":"물리전기화학(Physical Electrochemistry)분야의 경우, 모든 형태의 전해질 및 계면의 열역학적 성질을 포함한 여러 가지 물리화학적 성질을 이해하기 위한 연구를 수행한다. 분석전기화학(Analytical Electrochemistry)분야의 경우, 전기화학방법을 이용한 물질의 정성, 정량분석법 및 장치를 개발하는 연구를 수행한다. 분자전기화학(Molecular Electrochemistry)분야의 경우, 간단한 무기·유기화합물 및 거대화합물을 포함하는 전극반응과정에 대한 메커니즘을 연구한다. 에너지변환 및 저장전기화학(Energy Conversion and Storage Electrochemistry)분야의 경우, 배터리, 수소전지, 연료전지, 2차전지, 태양전지, 축전지, 초고용량 커패시터를 포함한 모든 전기화학적 과정을 포함하는 에너지의 저장, 변환생성에 관해 연구한다. 부식 및 표면처리(Corrosion and Surface Treatment)분야의 경우, 부식, 전극석출 및 표면처리, 용해과정, 전기화학적 방법을 이용한 표면처리에 관한 연구를 수행한다. 산업전기화학 및 전기화학공정(Industrial Electrochemistry and Electrochemical Processing)분야의 경우, 산업과 관련된 전기화학공정 기술 및 기초분야를 포함하는 분야를 연구한다. 생전기화학(Bioelectrochemistry)분야의 경우, 생체에서 일어나는 산화환원과정을 포함하여 생물, 의약과 관련된 전기화학에 관련된 연구를 수행한다. 전기재료화학(Materials for Electrochemistry)분야의 경우, 금속과 반도체물질 등을 포함한 전자, 전기재료 및 전극물질의 특성과 제조에 관한 연구를 수행한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|언어력|시각|","workEnv":"대기환경미흡|위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"물리전기화학연구원, 분석전기화학연구원, 분자전기화학연구원, 에너지변환저장전기화학연구원, 생전기화학연구원, 전기재료화학연구원","dJobECd":"1211","dJobECdNm":"[1211]자연과학 연구원","dJobJCd":"2112","dJobJCdNm":"[2112]자연과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005442:1', '{"dJobCd":"K000005442","dJobCdSeq":"1","dJobNm":"전자계산이론연구원","workSum":"계산기하학, 수학적 논리, 계산복잡도 등의 컴퓨터과학이론을 연구한다.","doWork":"각종 자료를 처리하기 위하여 컴퓨터 계산방법을 적용하고 처리과정을 추적한다. 컴퓨터의 처리절차를 분석하여 새로운 형태의 논리구조를 설정하고, 적합한 계산이론을 연구하여 알고리즘(Algorithm)을 개발한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"전자계산기기사, 전자계산기제어산업기사","dJobECd":"1211","dJobECdNm":"[1211]자연과학 연구원","dJobJCd":"2112","dJobJCdNm":"[2112]자연과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004842:1', '{"dJobCd":"K000004842","dJobCdSeq":"1","dJobNm":"지구물리학연구원","workSum":"물리학적 방법을 이용하여 지구내부 현상의 물리적 반응 또는 이에 따른 이상(Anomaly)을 측정하여 분석 및 해석하는 연구를 수행한다.","doWork":"지열·지구내부물리·지구동력학(Geothermics:Physics of Earth Interior and Geodynamics)분야의 경우, 지구의 역학적 반응을 일으키는 원동력인 중력과 지구내부의 열에 의하여 지구 구성물질이 이동하고 상호반응을 하며 지구의 형태 및 내부구조를 결정하는 현상에 대한 연구를 수행한다. 지진학(Seismology)분야의 경우, 지진(Earthquake:지각물질에 축적된 응력에너지의 비선형적인 급격한 발산인 단층운동에 의하여 주로 발생)을 연구하기 위하여 지진의 발생기작, 지진파의 전달현상, 전달매질의 구조와 물리적 특성에 대한 연구를 수행하며, 시공간(Space-Time)에 있어서 정량적인 지진예측(Earthquake Prediction)을 목표로 다양한 응용분야에서 연구를 수행한다. 중력·지자기·측지학(Gravity:Geomagnetism and Geodesy)분야의 경우, 우주선(Cosmic Ray)과 태양풍(Solar Wind)을 차단하여 지구환경을 보호하는 지자기장에 대한 연구를 수행하며 중력 및 측지학을 바탕으로 하거나 이에 적용한다. 지전자기학(Geoelectromagnetism)분야의 경우, 지구구성물질의 전자기적 반응을 대상으로, 전자기학적 반응을 관측하여 분석 및 해석함으로써 지구내부구조 또는 환경변화를 밝히는 연구를 수행한다. 지전류(Magnetotelluric), 전기비저항(Resistivity), 전자기(EM), 지반투과레이더(GPR) 등이 활용되며, 응용지구물리학 분야에 응용하기도 한다. 응용·환경지구물리학(Applied Geophysics and Environmental Geophysics)분야의 경우, 지구물리학적 방법을 자원탐사, 국토개발 및 자연재해(Natural Hazard) 예측에 이용하며, 주로 탄성파탐사(Seismic Exploration)연구를 수행한다. 환경지구물리학 연구에서는 전통적인 지구물리학적 방법을 환경문제에 적용하며 오염물질의 물리적 성질과 반응을 이용하여 지하에서 오염물질의 이동 및 확산을 추적하는 기술과 이를 격리시키고 제거하는 기술개발 및 연구를 수행한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"균형감각|손사용|시각|","workEnv":"대기환경미흡|위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"지열연구원, 지진학연구원, 지전자기학연구원, 환경지구물리학연구원","dJobECd":"1211","dJobECdNm":"[1211]자연과학 연구원","dJobJCd":"2112","dJobJCdNm":"[2112]자연과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001774:1', '{"dJobCd":"K000001774","dJobCdSeq":"1","dJobNm":"지구화학연구원","workSum":"지구상에서 일어나는 각종 자연적 및 인위적인 현상들을 화학적인 수단을 통하여 해석하는 연구를 수행한다.","doWork":"지구연대학(Geochronology)분야의 경우, 절대연령 및 상대연령 측정을 통해 지구작용의 역사를 해석하는 연구를 수행한다. 지하유체지구화학(Aqueous Geochemistry)분야의 경우, 지하수 등 지구환경에서의 수용액 내 다양한 현상을 화학적인 측면에서 접근하고 해석하는 연구를 수행한다. 환경지구화학(Environmental Geochemistry)분야의 경우, 다양한 지구환경문제를 지구화학적인 측면에서 접근하고 이의 해결을 모색하는 연구를 수행한다. 연구를 위하여 각종 지구화학 분석기기 및 야외조사 장비, 지구환경 구성물질을 활용한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"균형감각|손사용|시각|","workEnv":"대기환경미흡|위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"지구연대학연구원, 지하유체지구화학연구원, 환경지구화학연구원","dJobECd":"1211","dJobECdNm":"[1211]자연과학 연구원","dJobJCd":"2112","dJobJCdNm":"[2112]자연과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001499:1', '{"dJobCd":"K000001499","dJobCdSeq":"1","dJobNm":"지질자원연구원","workSum":"지질 및 지하자원 전반에 대한 연구·개발업무를 한다.","doWork":"지질도 작성, 지질 및 지구조 등 지질기반정보연구를 한다. 지하수오염 방지 및 자연저감, 지하수 환경보존 등의 지하수 관련 연구를 한다. 지질재해방지, 지진관측 및 특성규명, 지질환경 오염 및 광산재해방지 등 지질환경재해 연구를 한다. 자원탐사 및 산업자원, 에너지자원을 개발하는 업무를 수행한다. 지반구조물 설계 및 안전진단업무를 한다. 석유탐사, 해저지질도 작성 등 석유해저자원을 연구한다. 광물자원의 질의 향상이나 고순도 분리정제, 고기능성 원료소재 개발 등 자원활용소재를 연구한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"언어력|시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"지질기반정보연구원, 지하수지열연구원, 지질환경재해연구원, 지반안전연구원, 석유해저자원연구원, 자원활용소재연구원","dJobECd":"1211","dJobECdNm":"[1211]자연과학 연구원","dJobJCd":"2112","dJobJCdNm":"[2112]자연과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007531:1', '{"dJobCd":"K000007531","dJobCdSeq":"1","dJobNm":"지질학연구원","workSum":"지구상에서 일어나는 제현상을 지구작용의 원리(지각, 맨틀 및 핵 그리고 이와 연계된 지구 구성물질의 특징과 생성, 소멸 및 순환)를 근간으로 하여 연구한다.","doWork":"광물학(Mineralogy)분야의 경우, 지각의 최소 구성단위인 광물의 생성과 소멸, 그리고 화학조성에 따른 물리화학적 성질을 규명하고, 이의 산업적 응용 등에 관한 연구를 수행한다. 암석학(Petrology)분야의 경우, 광물이 모여 이루어진 암석의 기원, 산출 양상, 구조 및 조직, 순환, 그리고 산업적 응용 등에 관한 연구를 수행한다. 광상·자원지질학(Economic Geology)분야의 경우, 경제적 또는 산업적으로 가치있는 지구구성 물질(금속, 비금속, 건축자재 및 골재, 화석 연료 및 물)과 이와 관계된 각종 현상 및 작용 등에 대한 연구를 수행한다. 구조지질학(Structural Geology)분야의 경우, 지구 구성물질 내 구조를 기술하고 해석하며 물질의 변형과 이로 인한 조직 및 구조의 변화를 관찰하고 변형의 원인이 되는 응력의 발생원인과 기작을 해석하는 연구를 수행한다. 층서·퇴적·화석·지사학(Stratigraphy, Sedimentology, Fossils and Historical Geology)분야의 경우, 지층의 생성원인, 분포, 조성, 선후 및 상관관계에 대한 연구, 퇴적물의 조성, 생성원인, 운반, 퇴적 기작의 기재 및 해석에 대한 연구, 지층 내 화석을 살펴 과거 지구상의 생물들에 대한 지식을 축적함으로써 과거 지구환경을 이해하고, 이를 현재의 지구환경과 비교하여 미래의 지구진화를 해석하는 연구, 지질작용의 시간적 선후관계와 지구의 자연과학적 역사에 대한 연구를 수행한다. 화산·제4기지질학(Volcanology and Quaternary Geology)분야의 경우, 화산, 용암, 마그마 및 이와 관련된 현상들에 대한 연구와 가장 최근의 지질시대인 제4기의 모든 지질 작용에 대한 연구를 수행한다. 응용지질학·지질공학(Applied Geology and Engineering Geology)분야의 경우, 지질학적인 지식을 실생활이나 산업적인 측면으로 응용하는 연구를 수행하고, 지구를 대상으로 하는 공학에 있어서 지질재해, 기타 지질 관련 문제점을 공학적으로 해결하는 연구를 수행한다. 지형지구과학, 수문학, 수리지구과학, 지구유물·자연사학, 인공위성 지구과학, 지구행성학, 지구과학 기술 기반구축·관리기술에 대한 연구를 수행하기도 한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"균형감각|손사용|시각|","workEnv":"대기환경미흡|위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"광물학연구원, 암석학연구원, 광상연구원, 자원지질학연구원, 구조지질학연구원, 응용지질학연구원, 지질공학연구원","dJobECd":"1211","dJobECdNm":"[1211]자연과학 연구원","dJobJCd":"2112","dJobJCdNm":"[2112]자연과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006161:1', '{"dJobCd":"K000006161","dJobCdSeq":"1","dJobNm":"천문학연구원","workSum":"지구를 포함한 우주전체와 별, 태양 등을 관측하여 생성과 진화의 원리, 성질 등을 연구·분석한다.","doWork":"광학망원경, 전파망원경 등의 기구를 사용하여 천체현상을 관찰하거나 인공위성 등을 통해 수집된 관측자료를 분석하여 이론을 개발한다. 광학망원경, 전파망원경 등 천문학기기의 개발과 한국우주전파관측망 등 시스템을 구축한다. 달력 발간을 위한 월력요항을 발표한다. 일월출몰 시각, 각 행성의 위치 출목시각, 음양력 대조표 등을 수록한 역사를 발간한다. 우리나라 고대 천문유물의 복원, 고대 천문 관련 기록에 관한 연구를 수행한다. GPS를 이용한 지구자전, 지각운동, 대류층 및 이온층 등에 관한 연구를 수행한다. 기타 연구원(일반)들이 수행하는 일반적인 활동을 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"광학천문연구원, 전파천문연구원, 우주과학연구원, 응용천문연구원","dJobECd":"1211","dJobECdNm":"[1211]자연과학 연구원","dJobJCd":"2112","dJobJCdNm":"[2112]자연과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005059:1', '{"dJobCd":"K000005059","dJobCdSeq":"1","dJobNm":"측정표준시험평가기술연구원","workSum":"미터법에 따른 측정단위를 국제적으로 통일한 체계인 국제단위계(SI)를 표시하는 측정표준기술과 산업체 등 수요자에 대한 측정표준기술의 보급에 관련되는 교정시험평가 기술과 표준물질의 제조·분석·평가기술을 연구·개발한다.","doWork":"물리·기계 측정표준(Physical and Mechanical Measurement Standards)분야의 경우, 질량, 힘, 압력, 밀도, 부피, 온도, 습도, 열물성, 음향, 진동, 초음파, 유량, 유속, 점도, 진공 분야의 측정표준기술에 대한 연구를 수행한다. 전자기측정표준(Electromagnetic Measurement Standards)분야의 경우, 전기·자기·전자파분야의 측정표준을 확립하고 유지하는 기술 및 초정밀전자소자나 초전도체 등을 응용한 측정기술에 대한 연구를 수행한다. 광응용 측정표준(Measurement Standards Using Optical Technology)분야의 경우, 길이 표준, 시간주파수 표준, 광도복사도 표준, 광고온 표준, 광부품 및 광학기기 평가 등과 같이 광기술을 응용하는 측정표준기술에 대한 연구를 수행한다. 삶의 질 측정표준(Measurement Standards for Quality of Life)분야의 경우, 삶의 질 향상과 관련된 각종 측정표준기술에 대한 연구를 수행한다. 융합기술 측정표준(Measurement Standards for Fusion Technology)분야의 경우, 다학제간 융합이 필요한 각종 기술분야의 측정표준기술에 대한 연구를 수행한다. 교정시험평가(Calibration and Test Evaluation)분야의 경우, 측정표준기술을 현장의 수요자까지 보급하는 데 관련된 측정기기 교정기술과 각종 시험분석 평가기술에 대한 연구를 수행한다. 인증표준물질(Certified Reference Material)분야의 경우, 시험방법의 유효화 및 측정장비의 교정용으로 사용되는 표준물질과 관련된 기술에 대한 연구를 수행한다. 참조표준(Standard Reference Data)분야의 경우, 각종 데이터나 통계 등을 과학기술, 산업 및 사회 모든 분야에서 반복적으로 사용할 수 있도록 정확도와 신뢰도를 평가하여 공인하는 기술에 대한 연구를 수행한다. 신뢰성·비파괴평가(Reliability and Nondestructive Evaluation)분야의 경우, 산업제품의 신뢰성과 관련된 제반 평가기술 및 비파괴적으로 소재, 부품, 설비 등을 평가하는 기술에 대한 연구를 수행한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"대기환경미흡|위험내재|","workFunc1":"분석","workFunc2":"협의","workFunc3":"정밀작업","connectJob":"물리기계측정표준연구원, 전자기측정표준연구원, 광응용측정표준연구원, 삶의질측정표준연구원, 융합기술측정표준연구원, 교정시험평가연구원, 인증표준물질연구원","dJobECd":"1211","dJobECdNm":"[1211]자연과학 연구원","dJobJCd":"2112","dJobJCdNm":"[2112]자연과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004050:1', '{"dJobCd":"K000004050","dJobCdSeq":"1","dJobNm":"통계학연구원","workSum":"통계방법의 자문, 통계조사의 계획·실시, 통계자료의 조직, 분석, 해석 등의 업무를 수행한다.","doWork":"통계학의 기초가 되는 수학이론과 증명을 연구한다. 계수적 자료를 구하고 평가하는 새롭고 개선된 방법을 개발한다. 특정된 목적을 위하여 특수한 통계방법의 적용 여부와 능률에 관하여 자문한다. 표본조사와 기타 통계조사를 계획하고, 조사표를 설계하며 조사를 실시한다. 조사된 자료를 평가·조직·분석·해석하며 이용자에게 적합한 형식으로 제시하여 준다. 방법론적 문제, 결과자료의 해석과 평가에 대한 보고서를 작성한다. 생물학, 농학, 인구통계학, 보건학, 교육학, 자연과학, 공학, 경제학, 재정학 등 특정분야에서 통계적 응용을 전문적으로 연구하기도 한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"전문분야에 따라 분석통계학연구원, 사회통계학연구원, 수리통계학연구원, 인구통계학연구원, 자연과학통계학연구원, 임상통계연구원","dJobECd":"1211","dJobECdNm":"[1211]자연과학 연구원","dJobJCd":"2112","dJobJCdNm":"[2112]자연과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003221:1', '{"dJobCd":"K000003221","dJobCdSeq":"1","dJobNm":"항공기상전문가","workSum":"항공기상을 관측하고 관련 자료를 수집·가공·생산하여 항공회사 등에 제공한다.","doWork":"관측장비를 이용하여 지구의 대기상태를 입체적으로 측정한다. 기상위성과 레이더 등을 활용하여 공기의 흐름과 성질을 파악한다. 기상예보용 슈퍼컴퓨터에 자료를 입력하여 예보자료를 생산한다. 국제적 운항지원을 위해 외국과 항공기상정보를 교환한다. 항공기상 관측자료와 수치예측자료 등을 바탕으로 항공기 운항에 필요한 항공기상정보를 생산한다. 항공기의 안전운항을 지원하기 위하여 항공사, 운항관계자, 관련 기관 홈페이지 및 항공고정통신망에 항공기상정보를 제공한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"제어조작","connectJob":"항공기상예보관","certLic":"기상예보기술사, 기상기사, 기상감정기사","dJobECd":"1211","dJobECdNm":"[1211]자연과학 연구원","dJobJCd":"2112","dJobJCdNm":"[2112]자연과학 연구원","dJobICd":"O841","dJobICdNm":"[O841]입법 및 일반 정부 행정","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002755:1', '{"dJobCd":"K000002755","dJobCdSeq":"1","dJobNm":"해상풍력단지평가원","workSum":"풍향분석 데이터, 해저지반조사 분석데이터, 해양환경조사 데이터, 발전성능 예측데이터, 발전단지 배치도 등의 자료를 수집하여 해상풍력단지 조성의 경제성을 평가한다.","doWork":"기상탑을 설치하여 최소 1년 이상의 풍황자료를 수집한다. 장기 기상자료와 태풍등 기상청 및 위성자료를 수집하고 분석한다. 인근 변전소 현황 등 전력선 연계에 대해 분석한다. 방위별 풍속, 풍향, 에너지밀도, 난류강도, 극한풍속, 후류효과 등에 대한 풍력자원을 평가한다. 시뮬레이션을 통해 발전량을 예측하고 풍력단지에 대한 전체적인 경제성 분석을 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1211","dJobECdNm":"[1211]자연과학 연구원","dJobJCd":"2112","dJobJCdNm":"[2112]자연과학 연구원","dJobICd":"D351","dJobICdNm":"[D351]전기업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006739:1', '{"dJobCd":"K000006739","dJobCdSeq":"1","dJobNm":"해양연구원","workSum":"해양과학기술 및 해양정책에 관한 연구수행과 그 성과를 보급하며 해양자원개발과 해양환경보전을 위한 연구를 한다.","doWork":"한반도 주변해역과 북서태평양의 해양물리적 특성을 조사한다. 해수순환과의 역학구조를 규명한다. 해양환경보전, 기후환경변화, 해양오염방지 등의 연구를 한다. 주변해역의 해양화학적 특성을 규명한다. 해양생물로부터 신물질을 개발하기 위한 연구를 한다. 해양생태계 구성요인의 시·공간적 변화와 이들 간의 상호관계를 규명한다. 해양생물환경보전, 해양생물자원의 합리적 관리기법, 생물공학을 이용한 유용생물의 생산성 향상에 관한 연구를 한다. 해양지질환경의 변화와 해저자원 개발을 위한 기초 및 응용과학에 대한 조사·연구를 한다. 해양에너지 자원 및 공간자원의 개발과 이용에 관련된 공학기술을 연구·개발한다. 연안환경요소의 변화양상 및 예측기술을 개발한다. 연안재해 예보 및 방제기술을 개발한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"해양환경연구원","connectJob":"연구분야에 따라 해양공학연구원, 해양물리연구원, 해양생물연구원, 해양정책연구원, 해양지질연구원, 해양화학연구원","dJobECd":"1211","dJobECdNm":"[1211]자연과학 연구원","dJobJCd":"2112","dJobJCdNm":"[2112]자연과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006177:1', '{"dJobCd":"K000006177","dJobCdSeq":"1","dJobNm":"해황조사연구원","workSum":"연근해의 시기별, 해역별 해황(해수의 수온, 염분, 밀도 등의 분포양상)의 변동 등을 조사·연구한다.","doWork":"연근해의 각 조사정점에서 표준층별로 시료를 채취한다. 온도계, 투명도판, 수색계를 사용하여 수색, 탁도 등을 관측한다. 용존산소나 영양염류 등의 분석을 위한 시료는 실험실로 옮긴다. 수집된 시료를 분광광도계, 현미경, 형광광도계, 염분분석기, 자동적정기 등을 사용하여 분석한다. 분석된 자료를 해황예보 등의 자료로 제공한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"웅크림|시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"1211","dJobECdNm":"[1211]자연과학 연구원","dJobJCd":"2112","dJobJCdNm":"[2112]자연과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001856:1', '{"dJobCd":"K000001856","dJobCdSeq":"1","dJobNm":"핵연료연구원","workSum":"핵반응을 지속적으로 발생시키기 위한 핵연료설계 및 핵연료 성형가공을 위한 핵연료재료의 기술을 연구한다.","doWork":"핵연료주기, 방사선 산물관리 및 처분, 처분장의 안전성 평가, 사용 후 핵연료의 재처리 및 중간저장, 냉각재화학, 동위원소의 분리, 수질관리 및 제염기법, 신형원자로 환경영향평가 등 핵화학 및 방사선관리를 한다. 핵연료 설계 및 성능평가기술(가동원전, 연구로, 미래원자력시스템용 핵연료의 설계 및 조사전후의 핵연료 성능분석평가기술)을 연구·개발한다. 핵연료제조기술(가압경수로, 가압중수로, 고속로, 고온 가스로 및 연구용원자로 등)을 연구·개발한다. 원자력재료개발기술(가압경중수로, 고속로, 고온가스로, 핵융합로, 연구용원자로 등 다양한 원자력시스템의 설계 및 건설에 필요한 원자력용 구조재료기술)을 연구·개발한다. 원자력재료 신뢰성 평가기술(가동원전, 연구로 및 미래원자력시스템의 운전환경에서 재료의 성능시험 및 신뢰성 평가기술)을 연구·개발한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"핵연료설계기술연구원, 핵연료제조기술연구원, 원자력재료개발기술연구원, 원자력재료성능검증평가연구원","certLic":"핵연료물질취급면허(감독자, 취급자)","dJobECd":"1211","dJobECdNm":"[1211]자연과학 연구원","dJobJCd":"2112","dJobJCdNm":"[2112]자연과학 연구원","dJobICd":"C201","dJobICdNm":"[C201]기초 화학물질 제조업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002012:1', '{"dJobCd":"K000002012","dJobCdSeq":"1","dJobNm":"핵융합로연구개발자","workSum":"핵융합로(제어된 핵융합 반응을 일으켜 거기에서 얻어지는 에너지를 발전 등에 이용하기 위한 시스템)의 구조, 재료, 운영방법 등을 연구·개발한다.","doWork":"자연상태에서는 불가능한 연속적이고 지속적인 핵융합이 가능한 환경을 조성하기 위해 플라스마의 공급과 가열, 플라스마를 가두는 장치인 토카막(TOKAMAK) 운전모드 및 운전기술, 핵융합반응에서 생성되는 고에너지 알파입자 등에 따른 플라스마의 안정성을 검증한다. 고성능 플라스마의 안정적 운영과 제어기술에 대해 연구한다. 핵융합 반응에서 발생되는 고밀도 중성자의 영향으로 인한 핵융합 발전로용 진공용기, 블랑켓, 다이버터 등 부품재료의 물성과 특성의 변화 및 부품수명에 끼치는 영향을 연구하여 안정적인 핵융합로에 적합한 안정적인 부품 및 재료를 개발한다. 핵융합로 운영을 위한 전력공급기술을 개발하고 핵융합으로 인해 발생된 에너지를 효율적으로 발전에 적용시키기 위한 발전시스템에 대해 연구·개발한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"1211","dJobECdNm":"[1211]자연과학 연구원","dJobJCd":"2112","dJobJCdNm":"[2112]자연과학 연구원","dJobICd":"C201","dJobICdNm":"[C201]기초 화학물질 제조업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001537:1', '{"dJobCd":"K000001537","dJobCdSeq":"1","dJobNm":"화학정보학자","workSum":"화학원리(생물학, 제약 또는 고분자포함)에 대한 지식을 토대로 소프트웨어 사용 및 개발, 데이터베이스 설계, 통계분석, 수학적 방법론 등을 활용하여 신약개발, 재료과학, 생물학적 연구 등의 화학 분야의 다양한 문제를 해결한다.","doWork":"분자구조, 반응 경로, 분자 상호 작용 또는 기타 현상에 대한 데이터를 효율적으로 보관하고 검색하기 위한 방법 및 기능을 개발한다. 실험실 연구원과 협력하여 데이터 탐색 및 검색방법을 도출하고 적용하여 문제를 해결한다. 화합물에 대한 정보를 수집, 저장, 색인화, 검색, 추출 등을 하기 위한 컴퓨터 프로그램 작업을 한다. 수학적 기법을 사용하여 대규모 데이터베이스에서 화학적 특성을 분류하고 추세를 분석한다. 화학데이터분석방법, 컴퓨터시각화 등 관련 내용에 대해 교육훈련을 제공한다. 관련 자문을 제공하며 조사결과에 대해 보고서로 작성하고 발표한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"분자설계전문가, 분자모델링전문가","dJobECd":"1211","dJobECdNm":"[1211]자연과학 연구원","dJobJCd":"2112","dJobJCdNm":"[2112]자연과학 연구원","dJobICd":"C212/M701","dJobICdNm":"[C212]의약품 제조업 / [M701]자연과학 및 공학 연구개발업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006905:1', '{"dJobCd":"K000006905","dJobCdSeq":"1","dJobNm":"게이미피케이션전문가","workSum":"사회적으로 바람직한 행동을 유도하기 위하여 인간의 경쟁심리, 보상 및 즐거움 추구의 원리를 적용하여 마케팅, 교육, 웹 등에 적합한 게임프로그램을 설계한다.","doWork":"게임 외적인 분야에서 문제해결, 지식전달, 행동 및 관심유도 등 다양한 목적을 위해 게임의 메커니즘과 사고방식을 접목시킨다. 필요에 따라 순위표 등을 제공하여 경쟁심을 이끌어내거나 행동에 대한 보상을 가상으로 지급하는 등의 게임형태의 시스템을 설계한다. 사용자의 흥미와 능동적인 참여를 유도하기 위하여 역할수행이나 시뮬레이션 방식의 게임을 개발한다. 심리치료를 목적으로 하는 게임이나 창의적인 기술개발 실험을 위한 시뮬레이션 게임 등 전문적인 게이미피케이션을 연구하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"교육","workFunc3":"관련없음","similarNm":"게임화전문가","dJobECd":"1101","dJobECdNm":"[1101]인문과학 연구원","dJobJCd":"2121","dJobJCdNm":"[2121]인문과학 연구원","dJobICd":"M702","dJobICdNm":"[M702]인문 및 사회과학 연구개발업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007180:1', '{"dJobCd":"K000007180","dJobCdSeq":"1","dJobNm":"고전번역가","workSum":"개인문집, 역사문헌 등 한문으로 작성된 고전문헌을 정독하고 교감하여 현대 한국어로 옮긴다.","doWork":"번역할 원문을 통독한다. 원본과 이본을 비교하여 교감한다. 초서로 작성된 원문의 경우, 해서로 바꾸는 ‘탈초’작업을 진행하기도 한다. 교감한 내용을 주석하고, 한문 원문을 현대 문장부호를 써서 현대화하는 작업(표점)을 수행한다. 번역에 필요한 역사, 문학, 철학, 용어 등을 찾아 학습한다. 원문을 연구하여 본래의 사상과 감정을 그대로 살려 번역문을 작성한다. 내·외부 전문가로부터 번역결과를 평가받고 수정·보완하고 교정작업을 거쳐 최종 번역을 완성한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"고전번역사","dJobECd":"1101","dJobECdNm":"[1101]인문과학 연구원","dJobJCd":"2121","dJobJCdNm":"[2121]인문과학 연구원","dJobICd":"M702","dJobICdNm":"[M702]인문 및 사회과학 연구개발업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007522:1', '{"dJobCd":"K000007522","dJobCdSeq":"1","dJobNm":"교육학연구원","workSum":"교육문제의 개선과 발전을 위하여 교육제도, 교육과정, 교수방법, 교육평가 등에 관한 연구를 한다.","doWork":"철학, 심리학, 사회학, 행정학, 경제학 등의 전문지식을 응용하여 교육을 주제로 한 연구방법 및 절차를 개발한다. 교육제도 및 환경개선, 교육과정의 조직 및 개편, 교수방법 개발, 교육격차 해소, 학교의 교육계획, 교육평가 등에 대한 자료를 조사·수집·분석한다. 연구결과를 작성하여 출판하거나 관련 기관 또는 학교에 각종 개선안을 제언한다. 정부기관이나 전문단체에 전문적인 지식을 제공하기도 하며 자문을 하기도 한다. 교육철학, 교육심리학, 교육사회학, 교육행정학, 교육과정, 교육공학 등을 전문으로 연구하기도 한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"1101","dJobECdNm":"[1101]인문과학 연구원","dJobJCd":"2121","dJobJCdNm":"[2121]인문과학 연구원","dJobICd":"M702","dJobICdNm":"[M702]인문 및 사회과학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005800:1', '{"dJobCd":"K000005800","dJobCdSeq":"1","dJobNm":"문학연구원","workSum":"사상이나 감정을 언어로 표현한 예술 및 예술작품(시, 소설, 희곡, 수필, 평론)을 연구한다.","doWork":"문학이론, 문학사, 문예창작, 작가론, 비교문학, 운문, 산문, 소설, 평론, 희곡, 구비문학, 아동문학, 영상문학, 번역문학, 문학교육 등 다양한 문학연구 분야에 대해 연구한다. 전문연구분야에 따라 국문학(국문학사, 고전산문, 고전시가, 고전비평, 구비문학, 현대소설, 현대시, 현대희곡, 비교문학, 문학비평, 문화론, 작문 등), 한문학(한시, 한문산문, 한문소설, 한문비평, 한국경학, 한자학·어학, 한국서예학, 한문교육 등), 중문학(중국산문, 중국시, 중국희곡, 중국고전문학, 중국소설, 사곡, 중국현대문학, 문학비평, 비교문학, 경학, 중국문화, 중국서지학, 중국서예학 등), 일본문학(일본극문학, 일본문학비평, 일본비교문학, 일본고전산문, 일본고전운문, 일본근현대산문문학, 일본근현대시가문학, 일본문화 등), 영문학(현대영미시, 현대영미소설, 현대영미희곡, 영미문학비평, 비교영문학, 중세영문학, 셰익스피어, 르네상스영문학, 17·18·19세기 영문학 등), 프랑스문학(프랑스소설, 프랑스희곡, 프랑스문학비평, 프랑스비교문학 등), 독일문학(독일소설, 독일희곡, 독일 시, 독일문예학, 독일문학사, 독일문학비평, 독일비교문학, 독일구비문학 등), 스페인문학(스페인중남미 시, 스페인중남미 소설, 스페인중남미 희곡, 스페인중남미 문학비평, 스페인중남미 비교문학 등), 러시아문학(러시아 시, 러시아 소설, 러시아 희곡, 러시아 평론, 러시아문학사, 러시아비교문학, 러시아문학이론 등), 동서양 고전문학(그리스고전문학, 라틴고전문학, 고대인도문학 등), 기타 동서양문학(북한문학, 인도문학, 아랍문학, 태국문학, 베트남문학, 몽골문학, 이탈리아문학, 폴란드문학, 루마니아문학, 체코문학, 유고문학, 헝가리문학, 네덜란드문학, 스웨덴문학, 아프리카문학 등) 분야에 대한 연구를 수행한다. 연구논문집 발간, 학술서적 발행, 연구발표회, 강연회, 학술대회 등을 통해 연구성과를 발표한다. 다른 인문학 분야와 학제 간 연계 연구를 수행하기도 한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"문학사연구원, 문예창작연구원, 비교문학연구원, 운문연구원, 산문연구원, 소설연구원, 평론연구원, 희곡연구원, 구비문학연구원, 아동문학연구원, 영상문학연구원, 번역문화연구원, 문학교육연구원, 연구분야에 따라 프랑스문학연구원, 독일문학연구원, 국문학연구원, 스페인문학연구원, 한문학연구원, 러시아문학연구원, 중문학연구원, 동서양고전문학연구원, 동서양문학연구원, 일본문학연구원, 영문학연구원","dJobECd":"1101","dJobECdNm":"[1101]인문과학 연구원","dJobJCd":"2121","dJobJCdNm":"[2121]인문과학 연구원","dJobICd":"M702","dJobICdNm":"[M702]인문 및 사회과학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001493:1', '{"dJobCd":"K000001493","dJobCdSeq":"1","dJobNm":"생명윤리연구원","workSum":"유전자 재조합, 세포융합, 인공수정, 생물복제 등과 같은 생명과학의 연구결과가 인류에 미치는 영향을 도덕적, 윤리적 측면에서 연구한다.","doWork":"낙태, 인간복제, 동물실험, 유전학, 의료윤리, 장기기증, 안락사 등 생명에 관련된 윤리·도덕적 문제에 대하여 다학제적(윤리학, 정치학, 법학, 철학, 의학 등) 관점에서 연구한다. 배아, 생식세포, 줄기세포 등의 이용 및 연구와 관련된 정책개발을 한다. 생식세포 불법거래를 모니터링한다. 유전자 및 유전정보의 활용, 유전자 검사 및 연구, 유전자 은행, 유전자 치료 등에 관련한 정책개발 및 지원업무를 한다. 생명윤리 및 안전과 관련된 자료를 조사한다. 생명윤리 및 안전과 관련된 국내외 네트워크 구축 및 지원, 지식센터 운영, 병원윤리위원회 운영 등 의료윤리분야의 지원업무를 수행한다. 장기, 인체조직, 혈액, 조혈모세포 등의 기증과 이식정책에 관한 생명윤리 및 안전에 대한 연구를 수행한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"협의","workFunc3":"정밀작업","connectJob":"환경생태윤리연구원, 의료윤리연구원","dJobECd":"1101","dJobECdNm":"[1101]인문과학 연구원","dJobJCd":"2121","dJobJCdNm":"[2121]인문과학 연구원","dJobICd":"M702","dJobICdNm":"[M702]인문 및 사회과학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003575:1', '{"dJobCd":"K000003575","dJobCdSeq":"1","dJobNm":"서지학연구원","workSum":"한서, 양서, 한서(漢書) 등을 대상으로 그 기원과 역사, 내용의 이해를 밝히기 위해 도서의 전달경로를 조사·분석·연구한다.","doWork":"한서, 양서, 한서(漢書) 등 도서자료를 수집한다. 내용을 식별하고 그 특징을 기술하고 일정한 체계로 배열한다. 도서의 물리적 사실을 연구하고, 망실된 문헌을 복원한다. 특정판의 모든 도서를 조사하여 인쇄인과 출판인이 처음에 내려고 하였던 이상본의 물리적인 상태를 확정한다. 인쇄된 문자와 쓰인 물건의 같고 다름을 분석한다. 도서의 작성연대를 파악한다. 도서를 분석하고 역사적 가치를 부여한다. 한서(漢書)를 한서로 번역한다. 도서의 조사·분석·연구결과를 전산화하기 위한 시스템을 설계한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"협의","workFunc3":"정밀작업","dJobECd":"1101","dJobECdNm":"[1101]인문과학 연구원","dJobJCd":"2121","dJobJCdNm":"[2121]인문과학 연구원","dJobICd":"M702","dJobICdNm":"[M702]인문 및 사회과학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004390:1', '{"dJobCd":"K000004390","dJobCdSeq":"1","dJobNm":"심리검사개발원","workSum":"각종 심리검사를 개발·개정하여 학생, 구직자, 구인자, 고용주, 상담원 등에게 보급한다.","doWork":"심리검사 개발 및 수정에 요구되는 예산, 일정, 참여자 등 개발기획을 수립한다. 검사에 사용될 문항을 개발한다. 수립된 사업계획과 검사개발에 사용될 문항의 적합 여부에 대해서 전문가와 함께 검토한다. 개발된 검사를 규준집단에 실시하여 타당성과 신뢰성 등을 검토한다. 개발 보고서를 작성하거나 검사 관련 책자를 발간한다. 개발된 검사를 관련 담당자에게 교육한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"종합","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"1101","dJobECdNm":"[1101]인문과학 연구원","dJobJCd":"2121","dJobJCdNm":"[2121]인문과학 연구원","dJobICd":"M702","dJobICdNm":"[M702]인문 및 사회과학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007559:1', '{"dJobCd":"K000007559","dJobCdSeq":"1","dJobNm":"심리학연구원","workSum":"인간의 행동과 심리과정을 비롯하여 의학·교육·산업 등의 분야에서 심리적 문제를 진단하고 해결방안을 제시한다.","doWork":"인간의 행동과 심리과정에 대한 과학적 연구를 기반으로 각종 상담 및 심리검사를 개발하고 실시한다. 인간의 행동에 관한 실험과 관찰을 계획·시행하여 정신 및 육체적 특징을 측정한다. 개인의 정신이나 행동장애를 진단하고 치료한다. 산업조직의 능률향상을 위한 연구를 한다. 형질유전의 결과, 환경 및 개인의 사상과 행동에 관한 기타 요소를 분석한다. 정서·성격장애와 사회 및 직장환경에서의 부적응 등을 진단·치료 및 예방한다. 지능, 적성, 인성 및 기타 인간의 성격을 측정하는 검사를 개발하고 시행한다. 검사에서 얻은 검사자료를 해석하고 상담한다. 심리학적 문제, 아동의 사회발전, 직업상담, 교육 등의 분야에서 심리학적 이론의 응용을 전문으로 하기도 한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"청각|언어력|","workFunc1":"종합","workFunc2":"자문","workFunc3":"관련없음","connectJob":"연구 분야에 따라 교육심리학연구원, 발달심리학연구원, 사회심리학연구원, 산업심리학연구원, 상담심리학연구원, 실험심리학연구원, 아동심리학연구원","dJobECd":"1101","dJobECdNm":"[1101]인문과학 연구원","dJobJCd":"2121","dJobJCdNm":"[2121]인문과학 연구원","dJobICd":"M702","dJobICdNm":"[M702]인문 및 사회과학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007512:1', '{"dJobCd":"K000007512","dJobCdSeq":"1","dJobNm":"언어학연구원","workSum":"특정한 언어나 언어집단의 구조·변천·발달에 관련된 연구 외에 국민의 국어생활 향상을 위한 연구를 한다.","doWork":"고대어와 현대어의 비교, 분석을 통하여 단어와 문장구조의 기원과 변천을 조사한다. 형태론, 의미론, 음운론, 강세, 문법, 단어 및 언어구조의 특성을 연구한다. 어족과 어원에 따라 고어와 현대어를 비교·분류한다. 역사적·고고학적 유물에서 발견되는 견본으로부터 고어를 재구성하고 해독한다. 언어의 발생과 기원, 의사소통체계 등을 연구한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"청각|언어력|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"학예연구사(국어)","connectJob":"어원학·음성학·음운론·형태론 등과 같은 특정분야를 전문적으로 연구하는 경우 어원학연구원, 음성학연구원, 음운학연구원, 국어의 바른 사용과 발전을 위하여 한국어를 전문적으로 연구하는 경우 국어학연구원, 연구분야에 따라 언어학사연구원, 언어일반연구원, 기호연구원, 코퍼스연구원, 비교언어연구원, 사회언어연구원, 인지언어연구원, 응용언어연구원, 전산언어연구원, 심리언어연구원, 대조언어연구원, 언어인식연구원, 언어습득연구원, 언어교육연구원, 프랑스어연구원, 독일어연구원, 스페인어연구원, 국어연구원, 러시아어연구원, 동서양고전어연구원, 중국어연구원, 기타동서양언어연구원, 일본어연구원, 영어연구원, 통번역연구원","dJobECd":"1101","dJobECdNm":"[1101]인문과학 연구원","dJobJCd":"2121","dJobJCdNm":"[2121]인문과학 연구원","dJobICd":"M702","dJobICdNm":"[M702]인문 및 사회과학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007493:1', '{"dJobCd":"K000007493","dJobCdSeq":"1","dJobNm":"역사학연구원","workSum":"선사시대로부터 현대에 걸쳐서 정치, 경제, 사회, 문화 등의 인간활동을 주제로 조사·연구한다.","doWork":"기록보관소, 도서관 또는 개인이 소장하고 있는 자료들로부터 유용한 자료를 수집한다. 다른 사학자나 고고학자 등 관련 연구자의 업적을 연구한다. 자료를 분석하고 신빙성에 비추어 평가한다. 역사관의 흐름, 역사의 시대구분, 역사연구의 역사, 역사의 인식문제 등을 연구하여 현대사학의 과제를 인식한다. 사료의 비판과 역사이론에 있어서의 문제를 연구한다. 특수한 지역, 시대, 민족, 국가의 역사나 정치사, 경제사, 사회사, 문화사와 같은 전문분야를 연구하기도 한다. 개인, 기구, 상업조직체를 위하여 산업의 기술혁신, 특정시대의 사회관습이나 습관 등에 관한 주제를 연구하기도 한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"청각|언어력|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"연구분야에 따라 사학이론연구원, 사상사연구원, 정치사연구원, 경제사연구원, 사회사연구원, 문화사연구원, 군사사연구원, 역사교육연구원, 한국사연구원, 동양사연구원, 서양사연구원, 고고학연구원, 미술사연구원, 음악사연구원","dJobECd":"1101","dJobECdNm":"[1101]인문과학 연구원","dJobJCd":"2121","dJobJCdNm":"[2121]인문과학 연구원","dJobICd":"M702","dJobICdNm":"[M702]인문 및 사회과학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006964:1', '{"dJobCd":"K000006964","dJobCdSeq":"1","dJobNm":"유적발굴원","workSum":"매장되어 있는 유적이나 유물에 대해 발굴·조사하고 발굴유물을 연구한다.","doWork":"역사자료, 문헌 등을 연구·분석하여 유적지의 위치 및 지역을 확인한다. 현장의 지표조사를 실시한다. 고고학, 역사학, 지질학, 민속학, 고생물학자 등과 협의하여 발굴방법 및 절차 등을 결정한다. 현장을 답사하여 매장유산이 분포할 가능성이 높은 지역을 대상으로 선별적인 시굴조사를 실시한다. 발굴순서를 논의한다. 삽, 곡괭이, 긁는 기구, 먼지 터는 기구 등을 사용하여 매장유산을 발굴한다. 도자기, 장신구 등의 유물이 발견되면 발굴위치, 수량, 종류 등을 정리하여 기록하고 사진을 촬영한다. 발굴조사가 완료되면 발굴조사보고서를 간행하여 최신정보를 학계에 소개하기도 한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"자문","workFunc3":"정밀작업","dJobECd":"1101","dJobECdNm":"[1101]인문과학 연구원","dJobJCd":"2121","dJobJCdNm":"[2121]인문과학 연구원","dJobICd":"M702","dJobICdNm":"[M702]인문 및 사회과학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006147:1', '{"dJobCd":"K000006147","dJobCdSeq":"1","dJobNm":"정신문화연구원","workSum":"한국의 과거와 현재의 상황을 인식하고 미래 한국의 좌표를 설정하기 위해 한국문화를 학술적으로 연구한다.","doWork":"고전자료 등 전통문화의 유산을 현대 한국의 사회적 상황과 학문적 관점에서 새로 해석한다. 한국학 관련 자료를 정리한다. 민족문화유산을 발굴·정리한다. 한국 전통사상을 현대적 시각에서 재조명하여 국민사상과 가치관을 정립하는 업무를 한다. 산업사회의 발달에 따른 가치관의 혼란을 극복하고 도덕성을 회복하기 위하여 전통사상과 현대사상을 체계화한다. 국제화의 현대적 추세 속에서 한국의 사회와 문화가 당면하고 있는 과제들을 파악한다. 민주화의 추세 속에서 야기되는 한국사회의 현실문제해결을 위한 연구를 수행한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"연구분야에 따라 한국교육윤리연구원, 한국사연구원, 한국사회민속연구원, 한국어문연구원, 한국예술연구원, 한국정치경제연구원, 한국종교철학연구원, 민속연구원, 철학연구원, 종교일반연구원, 한국철학연구원, 동양철학연구원, 한국종교연구원, 동양종교연구원, 서양철학연구원, 서양종교연구원, 미학연구원, 윤리학연구원","dJobECd":"1101","dJobECdNm":"[1101]인문과학 연구원","dJobJCd":"2121","dJobJCdNm":"[2121]인문과학 연구원","dJobICd":"M702","dJobICdNm":"[M702]인문 및 사회과학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001935:1', '{"dJobCd":"K000001935","dJobCdSeq":"1","dJobNm":"체육심리학연구원","workSum":"체육현장에서 나타나는 인간의 행동과 이에 영향을 미치는 여러 가지 변인들을 심리학적, 사회학적으로 분석한다.","doWork":"인간의 행동과 심리작용(인지, 정서, 동기유발 등)과의 관계를 운동선수 및 지도자들에게 교육한다. 각종 질문지 및 기자재를 사용하여 체육현장에서 나타나는 심리문제를 조사·분석한다. 상담이나 훈련프로그램을 통하여 운동선수들의 의욕부진 및 불안을 해소하고 동기유발이나 주의, 집중력을 향상시킨다. 리더십, 일탈행동, 대화기술 등 운동선수와 지도자 간의 심리적인 문제를 해결한다. 운동학습모형을 개발한다. 경기력 향상을 위한 정신훈련기법을 개발한다. 효율적인 지도를 위한 코칭기법을 개발한다. 체육집단, 체육사회화, 체육의 사회적 차별에 관하여 연구한다. 운동선수의 상담에 관하여 연구한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"언어력|","workFunc1":"종합","workFunc2":"자문","workFunc3":"관련없음","dJobECd":"1101","dJobECdNm":"[1101]인문과학 연구원","dJobJCd":"2121","dJobJCdNm":"[2121]인문과학 연구원","dJobICd":"M702","dJobICdNm":"[M702]인문 및 사회과학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006152:1', '{"dJobCd":"K000006152","dJobCdSeq":"1","dJobNm":"거시경제연구원","workSum":"국내외 경제동향 및 경제여건을 지속적으로 점검·분석하여 경제현황 및 정책기조를 분석·평가하고 거시경제의 정책방향을 제시한다.","doWork":"국내외 경제동향 및 경제전망을 주기적으로 분석·발표한다. 현재의 주요 경제쟁점들을 분석·진단하여 정책대안을 제시함으로써 정책자료로 활용토록 한다. 환율변동이 설비투자에 미치는 영향, 외채가 경상수지에 미치는 영향 등과 같은 국내외의 경제변동을 조사·분석하여 한국경제에 거시적인 측면을 전망한다. 경제전망 및 정책효과 분석의 정확도와 신뢰도를 높이기 위하여 장·단기 거시계량모형을 개발·보완한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","connectJob":"연구분야에 따라 경제성장연구원, 경제발전연구원, 개발경제연구원, 경제변동연구원, 금융경제연구원","dJobECd":"1102","dJobECdNm":"[1102]사회과학 연구원","dJobJCd":"2122","dJobJCdNm":"[2122]사회과학 연구원","dJobICd":"M702","dJobICdNm":"[M702]인문 및 사회과학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003880:1', '{"dJobCd":"K000003880","dJobCdSeq":"1","dJobNm":"경제분석가","workSum":"기업분석 및 금융시장분석의 기반을 제공하기 위해 국내외 경제현황을 조사·분석·전망한다.","doWork":"국내외 경제정책 및 금융정책 동향, 세계경제시장의 동향을 조사·분석한다. 한국은행 및 국내외 경제연구소에서 발간한 경제동향서, 각 금융기관의 금융정책, 국내외 경제지표, 환율동향예측자료 등의 정보와 자료를 수집·분석하여 경제를 예측한다. 경제, 금융 관련 학술회에 참가하여 정보를 수집한다. 경제동향을 파악하기 위하여 최근 경제이슈를 선정하여 변화의 원인과 내용에 대해 분석한다. 최근의 변화와 향후 변화가 예상되는 항목을 선정하고 예상되는 변화의 크기와 시점을 선정한다. 향후 경제에 대한 전망을 하고 진행 시나리오를 작성한다. 연구결과를 대중에게 알리기 위하여 경제전문서적을 출간하거나 각종 강의와 강연을 하고 인터넷 온라인상에 분석결과를 알리기도 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","connectJob":"연구분야에 따라 에너지경제연구원, 환경경제연구원, 문화경제연구원, 서비스경제연구원, 교통경제연구원, 디지털경제연구원, 농업경제연구원, 의료경제연구원, 지역경제연구원, 대외경제연구원","dJobECd":"1102","dJobECdNm":"[1102]사회과학 연구원","dJobJCd":"2122","dJobJCdNm":"[2122]사회과학 연구원","dJobICd":"M702","dJobICdNm":"[M702]인문 및 사회과학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005344:1', '{"dJobCd":"K000005344","dJobCdSeq":"1","dJobNm":"고용보험통계분석원","workSum":"고용보험 통계를 분석하여 노동이동, 일자리 변동 등 노동시장정보를 제공하고 개선점을 파악한다.","doWork":"고용센터와 근로복지공단에서 입력되고 한국고용정보원에서 전산집계된 고용보험 데이터의 입력 및 집계상의 오류 여부를 파악한다. 집계된 고용보험 통계를 바탕으로 고용보험의 적용 및 고용보험 3개 사업(구직급여, 고용안정사업, 직업능력개발사업)의 실적을 기간별로 분석한다. 고용보험 통계를 응용하여 구직급여, 수급자 구조분석, 노동력 이동현황 등을 분석한다. 분석한 내용에 대해 월별, 분기 및 연별로 원고를 작성하여 책자로 발간하고 배포한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","dJobECd":"1102","dJobECdNm":"[1102]사회과학 연구원","dJobJCd":"2122","dJobJCdNm":"[2122]사회과학 연구원","dJobICd":"M702","dJobICdNm":"[M702]인문 및 사회과학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006192:1', '{"dJobCd":"K000006192","dJobCdSeq":"1","dJobNm":"국방정책연구원","workSum":"국가방위를 위한 안보전략, 군사발전, 국방인력, 국방자원, 전력투자분석 등의 정책과 제도를 연구하고 국방정책수립을 지원한다.","doWork":"안보전략 환경을 분석하여 국가차원의 안보전략, 국방정책 기조 및 정책방향을 설계하고 정책수립을 지원한다. 국방정책 기조를 뒷받침하기 위하여 군사전략, 군구조, 미래작전수행, 국방정보화, 국방모의모델에 관련된 연구를 수행하고 국방 정책결정을 지원한다. 국가발전 방향에 부응하는 국방인력 운영 개념 및 체제 연구, 전투력 제고 중심의 국방인력 운영 전략 및 정책 연구, 선진 병영문화 선도를 위한 정책 및 제도 연구 등 국방 인력의 선진화를 위한 정책과 제도를 연구하고 개발한다. 국방자원의 효율적인 관리 및 계획을 위하여 전략 및 정책 연구 및 개발을 한다. 전력투자사업 소요 및 획득 단계의 합리적 의사결정을 위한 분석지원 업무를 한다. 기타 연구원이 수행하는 조사, 분석, 보고서 작성, 발표 등의 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"자문","workFunc3":"관련없음","connectJob":"안보전략연구원, 군사발전연구원, 국방인력연구원, 국방자원연구원","dJobECd":"1102","dJobECdNm":"[1102]사회과학 연구원","dJobJCd":"2122","dJobJCdNm":"[2122]사회과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004398:1', '{"dJobCd":"K000004398","dJobCdSeq":"1","dJobNm":"국제경제분석가","workSum":"국제경제기구(WTO, OECD, APEC, UNCTAD 등)의 관련자와 협의하여 자료를 교환·수집하고, 관련 자료를 분석·배포·발간한다.","doWork":"국제경제기구 등에서 논의되는 국제경제·무역 관련 이슈 등 다자간 통상 현안에 대한 동향을 수집·분석한다. 국제경제 관련 각종 통계자료를 분석한다. 국제경제 관련 자료를 기업 등에 배포하며, 정부의 주요 정책결정 시 참고자료로 제출하기도 한다. 현안사항에 대한 의제를 정리하여 배포한다. 일간 단위로 인터넷, 잡지, 유관 국제기구에서 발간되는 자료 등을 종합적으로 정리하여 요약한 후 한글화하여 유관 일간지나 월간지 등의 잡지에 게재하거나 단행본 보고서를 발간한다. 정부나 수요업체에 자료를 배포한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","connectJob":"연구분야에 따라 국제경제연구원, 대외경제연구원","dJobECd":"1102","dJobECdNm":"[1102]사회과학 연구원","dJobJCd":"2122","dJobJCdNm":"[2122]사회과학 연구원","dJobICd":"M702","dJobICdNm":"[M702]인문 및 사회과학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004004:1', '{"dJobCd":"K000004004","dJobCdSeq":"1","dJobNm":"금융연구원","workSum":"국내외 경제환경 변화에 대응하여 금융산업의 업무조정 및 각종 금융제도의 선진화방안을 연구한다.","doWork":"금융의 자율화와 국제화 등 국내외 경제환경 변화에 따른 금융산업 업무영역의 조정, 신금융상품의 도입, 금융시장 및 금융산업의 개방 등에 관한 정책연구를 수행한다. 금융 관련 각종 제도와 관행을 선진화할 수 있는 방안을 검토·제시한다. 금융 관련 각종 정책을 분석·연구·평가한다. 통화신용정책의 개선방안, 금융개혁의 추진방향, 중소기업, 금융제도의 발전방안 등 현안 금융 관련 문제에 대해 연구한다. 금융 관련 각종 통계자료를 분석한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","dJobECd":"1102","dJobECdNm":"[1102]사회과학 연구원","dJobJCd":"2122","dJobJCdNm":"[2122]사회과학 연구원","dJobICd":"M702","dJobICdNm":"[M702]인문 및 사회과학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005755:1', '{"dJobCd":"K000005755","dJobCdSeq":"1","dJobNm":"노동연구원","workSum":"노동과 일자리, 노동자의 복지 등 노동 및 일자리정책에 관련된 연구를 한다.","doWork":"주로 정부의 노동정책 전반에 관한 사항을 연구한다. 산업별 노조건설과 노동조합 정책과제, 노조 조직력과 노동조합의 정치활동, 노사관계 등을 연구한다. 노동정책 개발과 노동문제에 관한 일반 국민의 인식제고에 기여하기 위해 노동과 일자리에 대한 문제를 연구한다. 노동 관련 각종 통계자료를 분석한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"1102","dJobECdNm":"[1102]사회과학 연구원","dJobJCd":"2122","dJobJCdNm":"[2122]사회과학 연구원","dJobICd":"M702","dJobICdNm":"[M702]인문 및 사회과학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005336:1', '{"dJobCd":"K000005336","dJobCdSeq":"1","dJobNm":"농업경영연구원","workSum":"농업을 경영하는 농가 및 농업법인체의 경영관리기술과 작물별 경영기술을 연구·개발하고, 이를 보급한다.","doWork":"농업 관련 각종 시험연구 결과의 경제성을 분석한다. 농업법인체의 경영관리기술을 개발하고 보급하기 위한 연구를 한다. 작목별 경영기술의 개발과 보급을 위한 연구를 한다. 농가경영에 대한 농업법인체 및 농가의 문의사항에 대한 상담 및 지도자료를 개발하고 보급한다. 농가의 농축산물 판매활동을 분석하고 개선방향을 연구한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|","workFunc1":"종합","workFunc2":"자문","workFunc3":"정밀작업","connectJob":"농업경영개선을 위한 전문분야에 따라 농업경영구조연구원, 작물경영연구원, 과수화훼경영연구원, 채소경영연구원, 축산경영연구원, 농가경영정보연구원","dJobECd":"1102","dJobECdNm":"[1102]사회과학 연구원","dJobJCd":"2122","dJobJCdNm":"[2122]사회과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001921:1', '{"dJobCd":"K000001921","dJobCdSeq":"1","dJobNm":"농촌생활연구원","workSum":"농촌의 가정·생활문화, 생활환경 및 농업환경에 대한 보존과 개선에 관한 연구를 한다.","doWork":"농촌가족 및 농촌가정관리에 관한 연구를 한다. 전통토착지식의 활용, 개발 및 농촌생활문화에 대한 연구를 한다. 농산물조리법의 개발 및 과학성에 관한 연구를 한다. 농산식품자원의 영양 및 생리효과를 연구한다. 농업인의 영양실태 및 섭취식품성분 분석에 관한 연구를 한다. 농촌 여성의 삶의 질을 향상시키기 위한 연구를 한다. 농촌의 주거 및 생활환경의 개선, 보전에 관한 연구를 한다. 농업인의 건강관리 및 농작업 환경에 관한 연구를 한다. 농촌생활과학에 관한 기술정보 및 교재에 관한 연구를 한다. 농촌환경의 공익적 가치개발에 관한 연구를 한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|","workFunc1":"종합","workFunc2":"자문","workFunc3":"정밀작업","similarNm":"농촌연구사, 농촌연구관","connectJob":"농촌생활에 대한 전문연구분야에 따라 농촌가정경영연구원, 농촌생활환경연구원","dJobECd":"1102","dJobECdNm":"[1102]사회과학 연구원","dJobJCd":"2122","dJobJCdNm":"[2122]사회과학 연구원","dJobICd":"M702","dJobICdNm":"[M702]인문 및 사회과학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006448:1', '{"dJobCd":"K000006448","dJobCdSeq":"1","dJobNm":"미래학자","workSum":"미래사회와 인간의 존재양식에 대해 사회과학과 자연과학 등 여러 학문 간의 학제적(學際的:Interdisciplinary) 연구를 수행하고, 미래사회를 예견하여 발표한다.","doWork":"여러 학문적 지식을 바탕으로 미래 지구와 사회, 과학기술 등에 대해 발생가능한 다양한 예상시나리오를 예측하고, 미래에 닥칠지 모르는 위험에 대비한 연구를 수행한다. 미래에 대한 예측, 사회안정과 변화, 미래조사연구의 전개과정 등을 설명한다. 미래에 대한 통찰력을 사람들에게 제공하기 위해 장기적 관점에서의 계획과 시스템적인 트렌드 분석, 시나리오 개발, 전망을 연구한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"종합","workFunc2":"자문","workFunc3":"관련없음","dJobECd":"1102","dJobECdNm":"[1102]사회과학 연구원","dJobJCd":"2122","dJobJCdNm":"[2122]사회과학 연구원","dJobICd":"M702","dJobICdNm":"[M702]인문 및 사회과학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002018:1', '{"dJobCd":"K000002018","dJobCdSeq":"1","dJobNm":"법경제연구원","workSum":"경제활동에 대한 규제와 자유시장 경쟁정책 사이의 접합점을 찾기 위한 경쟁촉진 관련 정책 및 법을 연구한다.","doWork":"독과점규제, 기업결합규제, 소비자정책, 경쟁정책(Competition Policy)의 국제규범화에 따른 대책 방안 등 경제정책 전반에 대해 분석 및 연구를 한다. 국제규범 및 제도에 대한 분석 및 연구를 통하여 경쟁정책의 대응방향 및 경쟁정책의 각종 현안문제에 대한 정책대안을 제시한다. 기업의 소유·지배구조 문제, 출자규제, 내부법례규제, 지주회사 허용 여부와 같은 기업조직의 문제 등 우리나라 기업정책에 대해 연구를 하고, 기업정책 방향을 제시한다. 우리나라 경제의 국제화, 개방화에 대응하여 공정한 국제법례관행의 정착에 대해 연구한다. 규제완화, 민영화 등을 통한 경쟁적 시장구조의 정착에 관한 연구를 한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","dJobECd":"1102","dJobECdNm":"[1102]사회과학 연구원","dJobJCd":"2122","dJobJCdNm":"[2122]사회과학 연구원","dJobICd":"M702","dJobICdNm":"[M702]인문 및 사회과학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007083:1', '{"dJobCd":"K000007083","dJobCdSeq":"1","dJobNm":"법학연구원","workSum":"합리적인 사법제도 구현을 위해 법학 또는 사법제도 전반에 관한 연구를 한다.","doWork":"각종 법률의 실태와 법조인 및 국민의 법의식에 대해 조사·분석한다. 사법제도 및 정책에 관해 연구한다. 법원 등 사법기관의 운용 효율성과 개선방안에 관해 연구한다. 법률의 운용과 형량실무에 관해 연구한다. 우리나라와 외국의 사법제도를 비교·연구한다. 국민의 사법이해와 신뢰제고를 위한 교육프로그램을 개발하기도 한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"종합","workFunc2":"자문","workFunc3":"관련없음","connectJob":"사법정책연구원","dJobECd":"1102","dJobECdNm":"[1102]사회과학 연구원","dJobJCd":"2122","dJobJCdNm":"[2122]사회과학 연구원","dJobICd":"M702","dJobICdNm":"[M702]인문 및 사회과학 연구개발업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005624:1', '{"dJobCd":"K000005624","dJobCdSeq":"1","dJobNm":"보건정책연구원","workSum":"장·단기 보건 관련 정책개발 및 계획수립에 관하여 연구한다.","doWork":"국내외 보건의료정책의 동향을 분석한다. 보건의료제도의 개선 및 보건정보관리방안을 연구한다. 보건인력, 시설 및 장비의 수급과 관리방안을 연구한다. 만성질환 및 노약자 보건관리방안을 연구한다. 국민영양 및 모자보건분야의 정책개발에 관하여 연구한다. 국민건강 증진을 위한 정책을 연구·개발한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"자문","workFunc3":"관련없음","dJobECd":"1102","dJobECdNm":"[1102]사회과학 연구원","dJobJCd":"2122","dJobJCdNm":"[2122]사회과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003856:1', '{"dJobCd":"K000003856","dJobCdSeq":"1","dJobNm":"부동산연구원","workSum":"부동산 시세 및 동향, 정책, 제도 등에 대해 연구한다.","doWork":"부동산 산업, 정책, 금융(리츠, 부동산 펀드 등) 등을 조사하고 연구한다. 부동산시가조사표 등의 부동산 관련 데이터를 통합·분석하여 부동산 시세를 산정한다. 부동산 실거래 가격지수를 작성하고 부동산 관련 통계정보를 조사하여 부동산시장을 분석하고 향후 동향을 전망한다. 부동산 거래현황 통계 및 미분양 통계 등 거래정보를 연구·조사한다. 부동산 이용·개발 및 거래규제 정책, 부동산 공시가격 및 부동산 조세제도 등 부동산 공시 관련 연구를 한다. 부동산시장의 동향 분석 및 전망, 부동산 투자 및 개발분석 등에 관한 연구를 한다. 감정평가이론과 기법, 감정평가제도와 감정평가기준, 수용 및 보상제도에 관하여 연구한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"1102","dJobECdNm":"[1102]사회과학 연구원","dJobJCd":"2122","dJobJCdNm":"[2122]사회과학 연구원","dJobICd":"L682","dJobICdNm":"[L682]부동산 관련 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002464:1', '{"dJobCd":"K000002464","dJobCdSeq":"1","dJobNm":"북한경제연구원","workSum":"북한 관련 경제문제를 분석·연구하여, 정부의 대북한 경제정책의 설정 및 운영방향을 제시한다.","doWork":"북한 관련 자료를 수집·정리하고 북한 경제체제의 구조와 북한경제의 동향을 분석한다. 북한의 경제실태를 분석하여 북한경제를 전망한다. 북한 대외 경제부문의 변화와 북한지역 투자환경, 동북아지역의 경제추진상황 등을 분석한다. 기업의 대북진출방안과 북한과의 경협 관련 제도적 장치, 남북경협 관련 국내제도의 정비 등 남북경협의 촉진방안과 관련한 연구를 한다. 남북경제의 각 부문별 제도통합방안, 통일 후 우리경제의 운영방안, 독일통일 및 사회주의 국가들의 체제전환 사례분석 등 통일에 대비한 연구를 하고, 우리나라의 정책방향을 제시한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","dJobECd":"1102","dJobECdNm":"[1102]사회과학 연구원","dJobJCd":"2122","dJobJCdNm":"[2122]사회과학 연구원","dJobICd":"M702","dJobICdNm":"[M702]인문 및 사회과학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003934:1', '{"dJobCd":"K000003934","dJobCdSeq":"1","dJobNm":"사회복지정책연구원","workSum":"사회복지제도 및 정책을 분석하고 대책수립을 위한 연구를 한다.","doWork":"사회보험(국민연금, 의료보험, 산업재해보상보험, 고용보험), 공적부조(생활보호, 의료보호, 기타 관련 제도), 사회복지사업(청소년복지, 아동복지, 노인복지, 장애인복지, 부녀복지, 기타 사회복지사업)과 그 밖에 주택, 환경, 고용, 교통, 보건 등 사회복지 관련 분야의 정책 및 제도를 분석하고 문제점을 진단한다. 한국형 복지국가모델을 정립한다. 사회사업 실천모델을 개발한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"1102","dJobECdNm":"[1102]사회과학 연구원","dJobJCd":"2122","dJobJCdNm":"[2122]사회과학 연구원","dJobICd":"M702","dJobICdNm":"[M702]인문 및 사회과학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001783:1', '{"dJobCd":"K000001783","dJobCdSeq":"1","dJobNm":"산업노동정책연구원","workSum":"산업구조의 변화와 방향을 분석하고, 그에 따른 무역구조 및 노동구조의 변화를 예측하는 연구를 한다.","doWork":"산업구조의 형태와 산업구조 변화에 영향을 주는 제반 요인을 분석하고, 이러한 요인이 중장기적인 산업구조의 변화에 미치는 영향을 전망한다. 산업구조의 변화로 가져올 무역구조 및 노동구조의 변화를 예측하기 위한 분석을 한다. 해외투자, 인수합병(M&A), 발전방향, 중·장기적인 산업구조 조정방향 등에 대한 기업체의 자문에 대한 분석을 한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","dJobECd":"1102","dJobECdNm":"[1102]사회과학 연구원","dJobJCd":"2122","dJobJCdNm":"[2122]사회과학 연구원","dJobICd":"M702","dJobICdNm":"[M702]인문 및 사회과학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002429:1', '{"dJobCd":"K000002429","dJobCdSeq":"1","dJobNm":"산업조사분석원","workSum":"산업환경 및 산업지표의 변화, 기업의 자금수요 등을 파악하여 국내 경기동향과 기업재무 관련 현안사항을 분석·예측하고, 자금수급의 기초자료 및 개별산업등급화자료를 생산하는 업무를 수행한다.","doWork":"업종별 산업동향조사 등을 실시하여 산업보고서를 작성한다. 산업별 매출액과 영업이익 증가율, 컨센서스(Consensus:실적추정치) 증가율, 외형성장률, 수익성을 분석하여 평가한다. 특정산업 및 특정주제에 관한 산업분석연구를 진행한다. 기업체의 매출액, 영업이익, 순이익, 주식시세, 주가상승 여력, 실적 컨센서스 등을 조사·분석하여 기업신용평가를 위한 개별산업등급화자료를 작성한다. 기업의 설비투자계획과 산업경기전망에 대해 조사하여 대외기관에 관련 자료를 제공한다. 향후 산업분석연구의 계획을 수립한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"1102","dJobECdNm":"[1102]사회과학 연구원","dJobJCd":"2122","dJobJCdNm":"[2122]사회과학 연구원","dJobICd":"M702","dJobICdNm":"[M702]인문 및 사회과학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002784:1', '{"dJobCd":"K000002784","dJobCdSeq":"1","dJobNm":"스포츠사회학연구원","workSum":"스포츠의 사회적 기능이나 사회와의 관련성, 스포츠팀의 조직사회 등에 대해 연구한다.","doWork":"스포츠 장면에서 일어나는 행동유형 및 사회화과정과의 관계에 대해 연구한다. 스포츠의 사회적 기능에 대해서 연구한다. 스포츠와 관련된 사회구조에 대해 연구한다. 스포츠와 미디어와의 관계에 대해 연구한다. 스포츠팀 내의 구성원 간의 응집, 역학, 폭력 등에 대해서 연구한다. 기타 연구원(일반)들이 수행하는 일반적인 활동을 한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"1102","dJobECdNm":"[1102]사회과학 연구원","dJobJCd":"2122","dJobJCdNm":"[2122]사회과학 연구원","dJobICd":"M702","dJobICdNm":"[M702]인문 및 사회과학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005393:1', '{"dJobCd":"K000005393","dJobCdSeq":"1","dJobNm":"스포츠정책연구원","workSum":"스포츠정책수립에 관한 기초연구를 수행한다.","doWork":"국민체육진흥법에 따른 국민체육진흥계획의 수립 및 평가에 대해 연구한다. 법, 재원, 인력, 조직, 시설 등 체육기반조성에 관해 연구한다. 전문체육, 생활체육, 학교체육 진흥을 위한 부문별 정책에 관해 연구한다. 체육지표개발 및 관련 통계자료를 조사하고 분석한다. 스포츠의 사회경제적 효과에 대해 연구한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"1102","dJobECdNm":"[1102]사회과학 연구원","dJobJCd":"2122","dJobJCdNm":"[2122]사회과학 연구원","dJobICd":"M702","dJobICdNm":"[M702]인문 및 사회과학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004905:1', '{"dJobCd":"K000004905","dJobCdSeq":"1","dJobNm":"언론정책연구원","workSum":"언론(신문, 방송, 인터넷 매체)현상 전반에 대한 조사·분석을 통해 언론에 관련된 정책수립에 도움이 되는 기초연구를 실시한다.","doWork":"각종 언론 관련 정책을 연구·개발한다. 현재 실시되고 있는 다양한 언론사업에 대해서 연구한다. 뉴미디어를 포함한 다양한 미디어서비스에 대해 연구하고 정책보고서를 작성한다. 언론 관련법, 언론 관련 산업 등에 관련한 정책방향을 제시한다. 사안에 따라 회의를 소집하여 의견을 교환하기도 한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"1102","dJobECdNm":"[1102]사회과학 연구원","dJobJCd":"2122","dJobJCdNm":"[2122]사회과학 연구원","dJobICd":"M702","dJobICdNm":"[M702]인문 및 사회과학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002703:1', '{"dJobCd":"K000002703","dJobCdSeq":"1","dJobNm":"에너지정책연구원","workSum":"국가에너지분야에 대한 정책 및 전략수립에 대해 연구한다.","doWork":"전문가의 의견수렴을 위해 설문조사 및 자문회의를 개최한다. 관련 분야에 대한 문헌조사 등 연구를 위한 사전조사를 한다. 기간별 연구과제 기술 등 연구계획을 수립한다. 국가에너지기술의 선진화전략을 수립한다. 관련 사업의 경제성을 평가한다. 수립된 결과를 토대로 자문회의를 개최하고 문제점을 수정·보완한다. 연구결과에 대해 보고서를 작성한다. 연구결과를 학회나 공청회 등에서 발표한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"관련없음","dJobECd":"1102","dJobECdNm":"[1102]사회과학 연구원","dJobJCd":"2122","dJobJCdNm":"[2122]사회과학 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007010:1', '{"dJobCd":"K000007010","dJobCdSeq":"1","dJobNm":"연금재정추계분석원","workSum":"국민연금의 원활한 재정운영을 위해 국민연금의 중·장기 재정추계액을 산정하고 재정추계시스템을 구축·관리한다.","doWork":"연금재정의 추계액을 산정하기 위한 연금수리모형(연금재정방식모델)을 개발한다. 연금산정을 위한 제반 연금수리모형을 적용하여, 국민연금 표준요율(소득에 대해 비과세수당을 제외한 나머지 금액에 대해 정해진 비율)과 과거근무채무요율 및 책임준비금 등을 분석·산정한다. 연금보험의 다원화된 연금계산기초율(예정이율, 예정사망률, 예정사업비율, 예정승급률 등)을 감안하여 추계한다. 재정계산제도를 연구하고, 관련된 인구·경제·사회통계분석을 수행한다. 재정추계시스템을 구축하고 관리한다. 재정추계 관련 확률변수를 개발하고 기타 연금재정운용연구를 지원한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","dJobECd":"1102","dJobECdNm":"[1102]사회과학 연구원","dJobJCd":"2122","dJobJCdNm":"[2122]사회과학 연구원","dJobICd":"K653","dJobICdNm":"[K653]연금 및 공제업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003734:1', '{"dJobCd":"K000003734","dJobCdSeq":"1","dJobNm":"연금제도연구원","workSum":"국민연금제도 및 정책에 관한 연구를 수행한다.","doWork":"사업장 및 지역가입자의 연금보험료 부과체계, 노령연금, 장애연금, 유족연금의 연금급여체계, 소득대체율 등의 실무적용 등에 관한 연구를 한다. 복지사업의 정책방향에 대한 조사 및 타당성을 분석한다. 연금재정 안정화방안(재정운용제도 등)에 대한 연구를 한다. 사회보험제도의 전반적인 발전방안 및 개선과 관련하여 연구한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","dJobECd":"1102","dJobECdNm":"[1102]사회과학 연구원","dJobJCd":"2122","dJobJCdNm":"[2122]사회과학 연구원","dJobICd":"K653","dJobICdNm":"[K653]연금 및 공제업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005288:1', '{"dJobCd":"K000005288","dJobCdSeq":"1","dJobNm":"연기금정책평가원","workSum":"중장기 연기금운용방안에 대해 연구하고 기금운영 성과평가를 한다.","doWork":"향후 연금급여를 위한 책임준비금인 기금의 실질가치를 유지하고 안정적으로 증식시킬 수 있는 중장기계획을 수립한다. 연기금자산의 전략적 배분방안, 기금운용의 효율화 방안, 기금운용의 위험관리방안, 기금 운용성과 평가의 기준과 평가기법 등에 대해 연구한다. 기금운용성과평가시스템을 구축하고 관리한다. 기금운용결과에 대한 성과평가를 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","dJobECd":"1102","dJobECdNm":"[1102]사회과학 연구원","dJobJCd":"2122","dJobJCdNm":"[2122]사회과학 연구원","dJobICd":"K653","dJobICdNm":"[K653]연금 및 공제업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006114:1', '{"dJobCd":"K000006114","dJobCdSeq":"1","dJobNm":"은행경영전략연구원","workSum":"은행에 소속되어 경영환경분석 및 예측, 장기발전전략의 연구, 국내외 경제·금융·자본시장의 조사 연구 등 은행의 중장기경영전략 및 기업금융, 개인금융 등에 대한 연구를 수행한다.","doWork":"은행 경영환경을 분석·예측하고, 장기발전전략을 연구한다. 국내외 기관·기구, 외부전문가와 협력하고 국제학술행사를 주관한다. 조사·연구 자료의 전산화업무를 수행한다. 국내외 경제, 금융 및 자본시장의 조사 연구를 수행한다. 기업금융 및 국내외 산업동향(제품 포함)의 조사 연구를 수행한다. 경제 및 금융 지표의 예측 및 예측기법의 조사 연구를 수행한다. 동북아 등 이머징마켓 조사 연구를 수행한다. 통계업무 기획과 통할, 통계자료 관리업무를 수행한다. 종합RM(Relationship Manager), 컨설팅업무 지원(인적자원 및 업무 노하우) 등의 업무를 수행하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","dJobECd":"1102","dJobECdNm":"[1102]사회과학 연구원","dJobJCd":"2122","dJobJCdNm":"[2122]사회과학 연구원","dJobICd":"K641","dJobICdNm":"[K641]은행 및 저축기관","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002878:1', '{"dJobCd":"K000002878","dJobCdSeq":"1","dJobNm":"재정복지정책연구원","workSum":"성장잠재력 확충, 사회발전촉진 등의 목적으로 정부재정수지와 사회복지분야의 역할 간 관계를 연구하고 재정복지 정책방향을 제시한다.","doWork":"재정지출, 재정수입 등의 재정부문과 의료, 연금, 공적부조 등 사회복지 분야의 정부역할에 대한 문제점을 분석·파악하고 정책방향을 제시한다. 정부개혁에 관한 학제적 접근을 통하여 문제점을 파악하여 방향을 제시한다. 선진국의 정부개혁사례를 연구·분석·소개하고 우리나라에 주는 시사점을 도출한다. 연초 세입에 대한 전망을 통하여 차년도 예산편성방향을 제시한다. 정부의 제정문제에 대한 주요 현안과제를 정부토론회를 통하여 협조하기도 한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","dJobECd":"1102","dJobECdNm":"[1102]사회과학 연구원","dJobJCd":"2122","dJobJCdNm":"[2122]사회과학 연구원","dJobICd":"M702","dJobICdNm":"[M702]인문 및 사회과학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006174:1', '{"dJobCd":"K000006174","dJobCdSeq":"1","dJobNm":"주택정책연구원","workSum":"주거안정과 주거수준의 향상을 도모하는 주택정책에 관하여 연구한다.","doWork":"주택시장의 구조와 동향을 분석하고 경기를 예측한다. 시장규제정책의 파급효과를 분석한다. 거시경제 내에서의 주택금융 및 조세의 역할을 정립한다. 정책수단으로서 주택금융 및 조세기능 합리화방안을 연구한다. 주택금융 재원확보 및 운용에 관하여 연구한다. 공공임대 주택정책을 평가하거나 저소득층을 위한 주택공급·관리 및 민간임대 주택산업의 육성방안을 연구한다. 주택재개발 정책수립 및 대도시 택지확보 방안을 연구한다. 택지공급체계를 분석한다. 주택산업의 생산성 및 경쟁력 제고방안을 연구한다. 주택의 질적수준 확보방안을 연구한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|손사용|시각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"1102","dJobECdNm":"[1102]사회과학 연구원","dJobJCd":"2122","dJobJCdNm":"[2122]사회과학 연구원","dJobICd":"M702","dJobICdNm":"[M702]인문 및 사회과학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005934:1', '{"dJobCd":"K000005934","dJobCdSeq":"1","dJobNm":"지역환경정책연구원","workSum":"사회간접자본의 확충 등 지역발전의 기초적 문제와 장기적 수급전략 등을 연구하고 지역 간 균형발전을 위한 정책을 제시한다.","doWork":"지방자치에 따른 지역의 발전 및 지역 간 균형발전을 위한 지역 내의 토지 및 주택 관련 부동산정책에 관한 연구를 한다. 지방자치 하에서 적합하고 타당한 지역계획을 수립할 수 있는 방향을 제시한다. 지역발전에 따라 발생할 수 있는 환경오염의 방지와 환경보전의 측면에서 환경정책을 수립할 수 있는 방향을 제시한다. 국제대회유치, 국제박람회개최, 공단조성 및 지역개발에 따라 지역 및 국가경제에 미칠 영향(효과)을 분석·연구하며, 발전방향을 제시한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"1102","dJobECdNm":"[1102]사회과학 연구원","dJobJCd":"2122","dJobJCdNm":"[2122]사회과학 연구원","dJobICd":"M702","dJobICdNm":"[M702]인문 및 사회과학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002259:1', '{"dJobCd":"K000002259","dJobCdSeq":"1","dJobNm":"토지정책연구원","workSum":"제한된 토지자원의 효율적인 이용과 관리를 위한 정책을 연구한다.","doWork":"개발이익환수제도, 토지거래허가제 등 각종 토지제도를 평가·개선한다. 토지정책 효과제고를 위한 조세제도에 관하여 연구한다. 지가추이 및 시장동향을 분석한다. 토지시장 구조분석을 위한 모형을 개발한다. 토지이용 계획체계 및 유형별 토지개발 방식에 대한 개선방안을 연구한다. 부동산 시장정보의 축적 및 활용방안을 연구한다. 공시지가 조사·평가체계의 장기적 발전방향을 연구한다. 토지 관련 법제의 정비방안을 연구한다. 토지소유권의 기능적 분화방향에 관하여 연구한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"자문","workFunc3":"관련없음","dJobECd":"1102","dJobECdNm":"[1102]사회과학 연구원","dJobJCd":"2122","dJobJCdNm":"[2122]사회과학 연구원","dJobICd":"M702","dJobICdNm":"[M702]인문 및 사회과학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005659:1', '{"dJobCd":"K000005659","dJobCdSeq":"1","dJobNm":"풍수지리학자","workSum":"풍수지리학적인 방법으로 명당(明堂) 길지(吉地)를 찾고 인간의 길흉화복(吉凶禍福)에 연결할 수 있는 원리를 조사·연구한다.","doWork":"음양오행설과 풍수지리학의 이론체계를 바탕으로 토지의 원리를 규명하기 위한 연구를 한다. 집, 건물 등의 토지를 감별하고 명당인지 아닌지를 구별한다. 전국을 돌아다니며 땅, 강, 산과의 연관관계를 확인하여 지역적으로 명당을 구분하고 정리한다. 나경(또는 패철佩鐵:무덤 자리나 집터를 정할 때 사용하는 나침반으로 한복판에 나침반이 있고 그것을 중심으로 중심에서 멀어질수록 커지는 여러 층의 원이 그려졌으며 이 원들과 바퀴살 모양의 직선들이 서로 만나는 지점에 방위표시의 한자(漢字)가 표시되어 있음), 수맥봉, 수맥추 등의 각 도구를 이용해 명당을 발견하고 매장과 이장에 대한 풍수컨설팅을 한다. 개인고객의 의뢰를 받아 명당을 찾아주기도 한다. 강의나 교육을 통하여 연구결과를 강의한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"언어력|시각|","workFunc1":"종합","workFunc2":"자문","workFunc3":"관련없음","dJobECd":"1102","dJobECdNm":"[1102]사회과학 연구원","dJobJCd":"2122","dJobJCdNm":"[2122]사회과학 연구원","dJobICd":"M702","dJobICdNm":"[M702]인문 및 사회과학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002955:1', '{"dJobCd":"K000002955","dJobCdSeq":"1","dJobNm":"해외시장정보분석원","workSum":"담당하는 해외지역의 통상정보를 수집·요약·분석하고, 그 정보를 종합관리한다.","doWork":"각 국가의 거시경제 및 외국과 한국의 쌍방향 투자, 무역 등의 통상정책전반에 대한 정보를 조사하고 관리한다. 국내의 정부 및 업체에서 요구가 있을 때 해외주재무역관이나 시장조사회사 담당자와 협의하여 필요한 정보를 함께 수집·분석하여 작성한 보고서를 정부, 업체, 언론 등에 배포한다. 통상 관련 자료를 시의성 있게 갱신하기 위해 국내외에서 발간되는 신문, 잡지, 인터넷 매체를 분석하여 데이터베이스를 구축한다. 해외시장에 관심이 있는 국내업체들을 대상으로 세미나 및 통상 관련 상담을 한다. 한국에 주재하고 있는 외국대사관의 상무관들과 긴밀한 접촉을 통해 각국의 통상 및 시장을 파악하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"관련없음","dJobECd":"1102","dJobECdNm":"[1102]사회과학 연구원","dJobJCd":"2122","dJobJCdNm":"[2122]사회과학 연구원","dJobICd":"M714","dJobICdNm":"[M714]시장조사 및 여론조사업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002694:1', '{"dJobCd":"K000002694","dJobCdSeq":"1","dJobNm":"가축위생시험원","workSum":"가축방역 및 질병진단을 위한 각종 검사를 수행한다.","doWork":"육즙배지(Bouillon), 배아(Embryo Chicks) 및 기타 세균매체를 동물에 접종한다. 일정기간 동안 세균을 배양하여 규정된 실험방법으로 백신 및 혈청을 준비한다. 백신을 검사하여 세균 및 바이러스의 활동이 중지되는 것을 조사한다. 검사에 사용되는 시약과 용액을 준비한다. 우유 및 낙농제품의 품질 또는 순도를 검사하여 기준에 부합되는지를 조사하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"시각|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"1222","dJobECdNm":"[1222]생명과학 시험원","dJobJCd":"2131","dJobJCdNm":"[2131]생명과학 시험원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002074:1', '{"dJobCd":"K000002074","dJobCdSeq":"1","dJobNm":"나무의사","workSum":"나무에 발생하는 생물적, 비생물적 요인 등의 피해에 대한 예찰, 진단, 계획, 설계, 처방, 치료, 평가 등을 통해 나무의 건강성을 유지하도록 한다.","doWork":"산림 및 생활권 나무관리주체(지자체 등) 등과 나무진료 관련 계약을 체결한다. 나무의 피해상태 및 발생시기, 최대피해기 등을 확인하기 위해 예찰을 한다. 피해를 입은 나무를 식별하고, 피해증상을 통해 병해충을 구분한 후, 방제계획 및 연간관리계획을 수립한다. 곤충이나 병원균 등에 의한 생물적 나무피해의 원인을 조사하고 처방을 통해 치료한 후 지속적인 건강성을 유지토록 한다. 토양, 대기, 기후 등에 의한 비생물적 나무피해원인을 조사하고 처방을 통해 치료한 후 지속적인 건강성을 유지토록 한다. 병해충을 방제하기 위해 약제를 살포한다. 줄기나 뿌리에 상처나 상해가 있는 부분의 외과적 처치를 한다. 토양상태를 점검하여 뿌리가 자라는 데 알맞은 토양환경을 개선한다. 위험한 가지나 필요 없는 가지를 제거한다. 위험요소를 저감시키기 위해 당김줄 및 지지대 등을 설치한다. 위험한 나무를 선정하고 제거한다. 나무가 최상의 건강상태로 자랄 수 있도록 관리 및 유지한다. 보호수의 이전, 질병 예방 및 치료, 주변 농작물 보호 등을 위한 진단·처방을 실시한다. 나무진단, 처방 및 치료에 소요되는 경비를 산출하여 설계서 및 관련 서류를 작성한다. 진단 및 치료에 필요한 다양한 장비를 사용한다. 진단, 처방 및 치료에 따른 결과와 평가항목을 보고서로 작성한다. 처방전에 표시된 농약의 명칭ㆍ용법·용량 등에 대한 문의에는 응답하여야 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"손사용|언어력|시각|","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"조경관리유지원","connectJob":"국가유산식물보호기술자, 국가유산식물보호기능자","certLic":"수목보호기술자, 식물보호기사, 식물보호산업기사, 국가유산수리기술자(식물보호), 국가유산수리기능자(식물보호공), 나무의사, 수목치료기술자, 산림기술사, 산림(산업)기사, 조경(산업)기사","dJobECd":"1222","dJobECdNm":"[1222]생명과학 시험원","dJobJCd":"2131","dJobJCdNm":"[2131]생명과학 시험원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005088:1', '{"dJobCd":"K000005088","dJobCdSeq":"1","dJobNm":"도시농업전문가","workSum":"도시농업기술을 연구·개발하며 도시농업인에게 교육한다.","doWork":"해외의 도시농업사례를 연구하여 우리나라에 적합한 도시농업방안을 구상한다. 텃밭농사, 주말농장, 상자텃밭, 옥상텃밭 등 도시농업기술을 연구하고 개발한다. 농장에서 식물을 재배하고 각종 농법을 시험한다. 도시농업 관련 기자재를 개발 및 개량한다. 도시농업의 확산을 위하여 텃밭강사를 교육·양성한다. 도시농업 희망자에게 농사방법을 교육하거나, 농사정보를 제공하고 새로운 기자재를 보급한다. 학교급식 퇴비화 사업 등 도시농업 관련 사업을 구상하고 실시한다. 지방자치단체와 협력하여 도시농업정책에 대하여 조언하고 관련 법규를 정비하는 데 기여하기도 한다. 농업 관련 영리법인 또는 비영리단체를 설립하거나 협동조합을 운영하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"웅크림|손사용|","workFunc1":"분석","workFunc2":"교육","workFunc3":"정밀작업","connectJob":"도시농업활동가, 도시농부","dJobECd":"1222","dJobECdNm":"[1222]생명과학 시험원","dJobJCd":"2131","dJobJCdNm":"[2131]생명과학 시험원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006184:1', '{"dJobCd":"K000006184","dJobCdSeq":"1","dJobNm":"도축실험실검사원","workSum":"도축된 소와 돼지의 지육 및 시설물에 대하여 항생제 및 세균 등의 검사를 실시한다.","doWork":"HACCP(위해요소중점관리기준)에 의하여 소, 돼지 등 지육(도살방혈, 박피, 두부절단, 뒷다리절단, 꼬리를 제거한 것)의 미생물 및 작업장의 낙하오염도 등 각종 검사를 실시한다. 도축물을 표집(Sampling)하여 수소이온농도(pH), 잔류항생물질 검사 등의 이화학적 검사를 실시한다. 살모넬라, 포도상구균 등의 축산물유래성 병원성 세균을 검사한다. 최종 제품의 관리·검사 뿐 아니라 각 공정단계별 관리·검사를 하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"수의사, 임상병리사","dJobECd":"1222","dJobECdNm":"[1222]생명과학 시험원","dJobJCd":"2131","dJobJCdNm":"[2131]생명과학 시험원","dJobICd":"C101","dJobICdNm":"[C101]도축, 육류 가공 및 저장 처리업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004155:1', '{"dJobCd":"K000004155","dJobCdSeq":"1","dJobNm":"동물백신품질관리원","workSum":"제조된 동물 백신의 품질확보를 위해 시험 및 검사를 한다.","doWork":"시험 항목을 점검하고 관련 기기를 준비한다. 제조 백신을 사용하여 특성시험, 무균(순수, 세균)시험, 함습도 시험, 균수 시험, 불활화 시험, 방부제 정량, 삼투압 등 일반 시험을 한다. 백신의 특성에 따라 미입바이러스 부정시험, 바이러스 함량시험 등 역가시험을 한다. 제품의 안전성을 확인하기 위해 시험동물과 목적동물을 대상으로 실험한다. 실험결과를 기준치와 비교하고 시험성적 종합판정을 내린다. 시험결과에 대한 보고서 및 성적서를 작성한다. 시험기기를 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"제어조작","dJobECd":"1222","dJobECdNm":"[1222]생명과학 시험원","dJobJCd":"2131","dJobJCdNm":"[2131]생명과학 시험원","dJobICd":"C212","dJobICdNm":"[C212]의약품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003048:1', '{"dJobCd":"K000003048","dJobCdSeq":"1","dJobNm":"미생물발효시험원","workSum":"발효미생물의 생산능력을 높이도록 개량 및 배양하는 기술을 연구하는 미생물발효연구원을 보조하여 관련 실험을 수행한다.","doWork":"배양된 균주를 변이유기제인 자외선(UVL:Ultra Voilet Light), 돌연변이 유발원(Mutagen) 등의 화학물질로 처리하여 변이를 발생시킨다. 성분표를 보고 필요한 화학물질을 계량하여 섞으며 수소농도(pH)를 조절하고 고압멸균기(Autoclave) 안에서 멸균하여 배지(Medium)를 만든다. 만들어진 배지에 백금선을 이용하여 긁기법(Streaking)으로 균주를 접종한다. 접종된 배지는 배양기에 넣고 온도를 조절하여 배양한다. 배양액을 광학밀도(Optical Density), 고속액체크로마토그래프(HPLC), 적외선분광기(NIR), 효소분석 등의 분석방법을 이용하여 분석하고 분석과정을 기록 정리한다. 모의생산실험을 하기도 한다. 발효조를 작동하고 스팀, 냉각수, 공기압 등을 조절하여 결과물을 분석한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"식품산업기사, 식품기사, 식품기술사, 식품가공기능사","dJobECd":"1222","dJobECdNm":"[1222]생명과학 시험원","dJobJCd":"2131","dJobJCdNm":"[2131]생명과학 시험원","dJobICd":"M729","dJobICdNm":"[M729]기타 과학기술 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007087:1', '{"dJobCd":"K000007087","dJobCdSeq":"1","dJobNm":"바이오화학제품균주관리원","workSum":"미생물 계량을 위한 원료·중간산물·목적물을 관리하기 위해 균주보관, 균주관리대장 관리, 균주활성 확인, 오염여부 확인 등의 업무를 수행한다.","doWork":"균주보관조건 및 동결건조 작업조건을 결정하고 보존될 미생물을 배양하여 동결건조를 준비 및 수행한다. 미생물의 배양조건을 결정하고, 액체배지와 고체배지에 접종 및 배양한 후 정상성장 여부를 확인한다. 냄새, 색깔, 거품상태 등 배양상태를 확인하여 오염 가능성을 판단하고 현미경 검경을 통해 채취 샘플의 오염균 존재여부를 확인하거나, 고체배양법으로 채취 샘플의 오염여부를 확인한다. 주 생산균주와 작업생산균주를 구분하여 보관하고 균주의 특성, 보존기간, 배양방법에 따라 균주보관방법을 결정한다. 균주관리번호를 부여하여 균주관리대장을 작성하고, 균주 사용변동에 따른 균주사용내역 대장을 작성한다. 재생 균주 활성평가 결과에 따라 재보관 여부를 결정한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1222","dJobECdNm":"[1222]생명과학 시험원","dJobJCd":"2131","dJobJCdNm":"[2131]생명과학 시험원","dJobICd":"C211","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007089:1', '{"dJobCd":"K000007089","dJobCdSeq":"1","dJobNm":"바이오화학제품배양원","workSum":"미생물을 배양용기에서 증식시키고 목적산물을 대량 생산하기 위해 배양원료준비, 배양시스템 멸균, 배양 등의 업무를 수행한다.","doWork":"칭량일지를 작성하여 원료 순서에 따라 조제조에 투입하고 각종 원료를 혼합하여 용해 상태를 확인한다. 용해된 원료 혼합액을 pH, 온도, 액량을 통해 분석하고 원료 용해액을 준비하고 기록 및 보고한다. 멸균기 운전 주의사항을 확인하여 근무자 인수인계사항에 따라 멸균기의 상태를 조사하고 확인하며 멸균기 이상상태를 정상화, 멸균기 점검일지를 작성 및 공유한다. 배지 멸균조건, 멸균기와 발효기의 공멸균상태, 배지조제조의 배지조제완료 상태를 확인한다. 장비운영에 필요한 유틸리티 압력, 온도 등 공급조건과 유틸리티 정상 공급 여부, 배양 장비운영에 필요한 청결, 정리정돈, 긴급정지, 응급조치 제반 준비 여부를 확인한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"바이오화학제품제조기사, 바이오화학제품제조산업기사","dJobECd":"1222","dJobECdNm":"[1222]생명과학 시험원","dJobJCd":"2131","dJobJCdNm":"[2131]생명과학 시험원","dJobICd":"C211","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007088:1', '{"dJobCd":"K000007088","dJobCdSeq":"1","dJobNm":"수목치료기술자","workSum":"나무의사의 처방전을 이해하고, 그에 따라 수목에 농약을 살포하거나, 가지치기 작업 등을 수행한다.","doWork":"나무의사의 진단·처방에 따라 직접 수목의 병충해를 예방, 치료, 관리한다. 수목에 생육을 위해 가지를 자른다. 해충과 질병을 막기 위해 수동 및 기계식 분무기를 이용하여 수목에 농약을 분무한다. 상처를 통해서 각종 미생물의 침입을 방지하고, 상처를 치료해서 새살(상구조직) 형성을 촉진시켜 상처가 아물도록 하는 등 외과수술을 수행한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|손사용|시각|","workEnv":"대기환경미흡|위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"1222","dJobECdNm":"[1222]생명과학 시험원","dJobJCd":"2131","dJobJCdNm":"[2131]생명과학 시험원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006782:1', '{"dJobCd":"K000006782","dJobCdSeq":"1","dJobNm":"유전체분석사","workSum":"생물의 유전체정보를 조합하고 효과적인 분석법을 개발하여 분석한다.","doWork":"시료의 분석기기데이터를 확인하고 설계된 정확도를 검증한다. 수학, 통계학, 프로그래밍 언어 등의 다양한 전산도구(Tool:프로그래밍 언어, 스크립터, 분석, 통계프로그램 등 다양한 종류가 사용됨)를 사용하여 분석방식에 적합한 알고리즘을 적용한다. 기본데이터 분석(매칭, 정렬, 필터링, 분류)을 수행하여 염기서열을 완성하고 조합이 완료되면 분석요구조건에 따라 구조분석(Structure Analysis), 기능해석(Functional Analysis), 대사경로 분석(Pathway Analysis) 등을 위해 통계 및 확률 알고리즘을 적용한다. 대조군데이터베이스(DB:Database)와 변이 및 발현에 대한 정보를 비교·분석한다. 분석이 완료된 결과물은 시스템에 등록하고 관련 부서에 통지한다. 분석의 정확도를 높이기 위해 새로운 분석방식을 적용하거나 반복적인 분석을 통해 새로운 알고리즘을 개발하거나 개선점을 도출하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"1222","dJobECdNm":"[1222]생명과학 시험원","dJobJCd":"2131","dJobJCdNm":"[2131]생명과학 시험원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003915:1', '{"dJobCd":"K000003915","dJobCdSeq":"1","dJobNm":"유전체시험원","workSum":"생물의 유전체정보를 얻기 위해 시료를 처리하고 분석기기를 조작한다.","doWork":"생물체에서 채취한 시료를 이화학적 방식과 기기(원심분리기, 핵산추출기, PCR)를 활용하여 핵산을 축출하고 정제한 뒤 디앤에이(DNA)에 프리머(Primer)를 부착하여 라이브러리(Library)를 제작한다. 증폭기를 이용하여 증폭하고 플로어셀(Flow-cell:Library가 고정된 차세대연기분석장비용 패널)을 준비한다. 분석방식에 따라 분석장비를 설정하고 플로어셀을 삽입한 뒤 가동시킨다. 분석과정에서 오류발생 여부를 모니터링하고 문제가 발생하면 조치한다. 분석이 완료되면 플로어셀을 제거한다. 분석된 데이터가 관리시스템에 정상적으로 저장되었는지 확인한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"1222","dJobECdNm":"[1222]생명과학 시험원","dJobJCd":"2131","dJobJCdNm":"[2131]생명과학 시험원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005815:1', '{"dJobCd":"K000005815","dJobCdSeq":"1","dJobNm":"의료용구생물학시험원","workSum":"수액세트, 1회용 주사기 등과 같이 인체에 삽입·접촉하는 의료용구의 이상 유무를 검사하기 위하여 발열성시험, 독성시험 등의 생물학적 시험을 한다.","doWork":"시험매뉴얼에 따라 시험검사에 필요한 pH미터, 전자저울(잔류물측정계기), 시험관, 시약 등 시험기구 및 시험재료를 준비한다. 제조된 의료용구를 생리식염수에 넣은 후 일정시간이 지난 후 시험관에 부어 검액을 만든다. 검액을 쥐 또는 토끼 등의 실험용 동물에 투여하여 발열 여부, 독성 여부 등을 관찰·판단하여 결과를 낸다. 관찰결과를 일지에 적고 상부에 보고한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"1222","dJobECdNm":"[1222]생명과학 시험원","dJobJCd":"2131","dJobJCdNm":"[2131]생명과학 시험원","dJobICd":"C271","dJobICdNm":"[C271]의료용 기기 제조업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006693:1', '{"dJobCd":"K000006693","dJobCdSeq":"1","dJobNm":"임상시험코디네이터","workSum":"임상시험과 관련된 일정을 관리하고 진행한다.","doWork":"연구책임자의 위임 및 합의 하에 임상시험에 참여하는 환자와 일반인들이 시험에 적합한지 검증한다. 임상시험과 관련된 모든 일정을 관리하고 진행한다. 연구계획서를 검토하고 임상시험 수행 관련 일정표와 안내문을 개발한다. 시험대상자에게 연구에 대해 설명하여 동의를 받는다. 시험약을 투약한 후 관찰한 내용을 기록한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"협의","workFunc3":"수동조작","similarNm":"임상연구간호사, CRC(Clinical Research Coordinator)","dJobECd":"1222","dJobECdNm":"[1222]생명과학 시험원","dJobJCd":"2131","dJobJCdNm":"[2131]생명과학 시험원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;