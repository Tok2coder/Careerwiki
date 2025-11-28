INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007347:1', '{"dJobCd":"K000007347","dJobCdSeq":"1","dJobNm":"바이오화학제품분리정제공정관리자","workSum":"바이오화학제품의 생산 활동이 효율적으로 이루어질 수 있도록 분리정제, 회수 등의 업무를 수행하고 생산 담당자의 업무를 관리·감독하는 일을 수행한다.","doWork":"생산물, 생산균주로부터 최종산물의 물리화학적 분리정제 조건을 설정하고 최종산물의 분리정제 계획을 수립한다. 세포배양액에서 생산균주와 여과액을 분리하여 최종산물을 제외한 부산물을 폐기 및 저장한다. 정제공정을 위한 농축액 시료 채취 및 농도를 분석하고 결정 석출을 위한 결정기, 증류기 운전과 크로마토그래피를 실시한다. 농축공정을 위한 시료 채취 및 농도를 분석하고 농축기 운전, 농축작업 수행, 농축결과 작성 및 배양액의 성상을 파악하여 원심분리, 여과 등 균체 회수방법 선택에 따른 운전조건을 도출한다. 균체의 양 측정, 균체 분리 상태를 점검하고 균체분리 설비 운전과 여과를 통한 분리작업의 수행 및 결과보고서를 작성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"정밀작업","certLic":"바이오화학제품제조기사, 바이오화학제품제조산업기사","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C211","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007313:1', '{"dJobCd":"K000007313","dJobCdSeq":"1","dJobNm":"바이오화학제품안정성평가자","workSum":"바이오 화학 목표 물질의 생산·유통·폐기 전 과정에 걸쳐서 발생하는 투입물과 산출물에 의한 잠재적 환경 영향을 정성적·정량적으로 평가하는 업무를 수행한다.","doWork":"바이오화학제품 특성에 따른 안정성에 대한 적합성 여부 판단, 안정성 평가보고서를 작성한다. 목표 물질의 투입물과 산출물의 생산계획에 따른 환경조사를 실시하고 관련 내용을 분석한다. 조사 분석 자료를 토대로 건강 영향평가를 실시하고 인체건강에 대한 건강결정요인별 예측결과를 활용해 환경의 위해 여부를 평가한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"협의","workFunc3":"정밀작업","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C211","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007349:1', '{"dJobCd":"K000007349","dJobCdSeq":"1","dJobNm":"바이오화학제품전환공정관리자","workSum":"생촉매 또는 화학촉매를 사용하여 원하는 물질로 발효 및 효소전환 공정 등의 생물학 전환 등의 업무를 수행하고 생산 담당자의 업무를 관리·감독하는 업무를 수행한다.","doWork":"생촉매 준비를 위한 생촉매 활성 및 농도를 측정하고 생촉매 고정화 및 반응조건을 설정하고, 반응 후 기질 농도 및 생산물 농도를 분석하며 반응조건을 조절한다. 화학촉매 준비를 위한 화학촉매 활성 측정 및 고정화, 비표면적을 측정하여 고정화 정도를 평가한다. 전환공정 운전을 위한 반응조건을 설정하고 전·후 기질농도 및 반응물의 농도를 분석하여, 조건을 선택하고 계산한다. 생촉매 반응조건 설정, 활성 측정, 단백질 측정법을 이용한 생촉매 농도 측정, 생촉매 고정화, 공정운전을 위해 생촉매와 반응물질을 정량 투입하고, 반응 후 기질농도 및 생산물의 농도를 분석한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"정밀작업","certLic":"바이오화학제품제조기사, 바이오화학제품제조산업기사, 화공기사","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C211","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007350:1', '{"dJobCd":"K000007350","dJobCdSeq":"1","dJobNm":"바이오화학제품중합공정관리자","workSum":"화학적 또는 생물학적 중합 반응을 통해 고분자 물질을 제조하기 위한 바이오고분자 중합과 바이오플라스틱 생물학적 생산 담당자의 업무를 관리·감독하는 일을 수행한다.","doWork":"제품생산량에 따른 원·부재료 투입량을 산출하고 중합 조업조건을 확인하고 반응기 운전 및 관리를 통한 중합을 위한 시료 채취, 품질분석 의뢰, 중합공정 보고서를 작성한다. 바이오플라스틱의 생물학적 생산공정과 생산배양의 차이점을 구분하고 생산용 미생물 균주특성을 파악한다. 종배양, 본배양 배지조성을 설정하여 바이오플라스틱의 생물학적 생산을 위한 운전조건 설정 및 배양기 운전조건을 확인한다. 바이오플라스틱 생산(정도) 확인 및 생산조건을 변경하여 공정 운전조건을 기록한다. 바이오플라스틱 생산일지 및 생산보고서 작성 후 바이오플라스틱의 생물학적 생산결과를 검증한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"정밀작업","certLic":"바이오화학제품제조기사, 바이오화학제품제조산업기사","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C211","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005039:1', '{"dJobCd":"K000005039","dJobCdSeq":"1","dJobNm":"비료제조연구원","workSum":"각종 화학비료를 제조하기 위해 원료 및 배합을 시험·분석하고, 공정 개선 및 신기술 도입 등의 연구를 한다.","doWork":"질소질 비료, 복합 비료 등 각종 화학비료를 제조하기 위한 원료(암모니아, 황산, 인산 등)를 시험·분석하고 새로운 혼합비를 연구해 신제품의 개발을 한다. 원료의 투입으로부터 제조(중화반응, 제립, 건조, 선별, 냉각 및 코팅, 더스트 회수), 저장, 출하에 이르는 전 공정의 효율성을 연구한다. 대단위 단지(Complex)에서는 각 공장들의 공정연계도를 효율적으로 연구·관리하여 생산의 효율성을 높이기 위한 연구를 한다. 공정별로 발생할 수 있는 위험요소 및 사고유형을 분석하고 이에 대한 대응책을 마련한다. 환경과 안전 측면에서 최신 공정을 반영하기 위한 연구 등을 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"비료제조기술자","certLic":"화공기사, 위험물산업기사, 품질경영산업기사,화공기술사, 품질경영기사, 품질관리기술사","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C203","dJobICdNm":"[C203]비료, 농약 및 살균, 살충제 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007351:1', '{"dJobCd":"K000007351","dJobCdSeq":"1","dJobNm":"석유화학공정관리자","workSum":"제품의 수량, 품질 수준 등을 일정 시간 내에 효율적으로 달성하기 위해 공정 개선계획을 수립하고 위험성 평가 및 통계관리를 수행한다.","doWork":"공정개선계획 수립을 위해 공정편성표를 검토하고 공정 도면관리, 변경관리 업무를 수행한다. 공정개선 결과평가서를 작성하기 위해 공정지표를 통계처리하고 이상 지표를 분석한다. 공정 개선계획의 정상화를 위해 위험성 평가대상의 파악 및 위험성을 평가하고 위험성 평가결과를 적용하여 PSM을 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C201","dJobICdNm":"[C201]기초 화학물질 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007357:1', '{"dJobCd":"K000007357","dJobCdSeq":"1","dJobNm":"석유화학공정연구개발자","workSum":"화학 소재의 제조 경쟁력 향상과 연구개발 제품의 상업화를 위하여 공정 모사 및 반응기 설계 기술을 활용하여 공정 최적화, 공정설계 및 스케일업, 신공정 기술 개발 등의 업무를 수행한다.","doWork":"석유화학제품 생산의 경제적 운영에 필요한 공정기술 연구를 위해 공정 흐름 및 단위공정을 파악하고 공정 시뮬레이션을 실시한다. 공정개발 계획을 수립하고 공정테스트를 거쳐 공정 상세설계를 한다. 공정 최적화를 위하여 각종 자료를 수집하고 연구하며, 최적 운전조건을 도출하고 최적 생산계획을 수립한다. 스케일업 공정개발 계획과 스케일업 단위공정 및 장치를 설계하고, 신규공정 개발 계획을 수립하고 신규공정을 개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C201","dJobICdNm":"[C201]기초 화학물질 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007358:1', '{"dJobCd":"K000007358","dJobCdSeq":"1","dJobNm":"석유화학공정연구원","workSum":"석유화학 기존 공정의 개선 및 연구과제의 상업화 공정설계를 위하여 공정개발 계획에 따라 공정 실험, 데이터 해석, 공정 진단 등의 업무를 수행한다.","doWork":"실험장비 및 분석기기를 조작하여 공정을 관측하고 제어한다. 랩 공정조건을 파악하고 랩 실험을 준비하여 실시한다. 공정데이터 결과를 종합하고, 공정 분석 항목과 방법을 파악하고 진단한다. 공정분석실험을 하고 공정 데이터를 분석한다. 생산공정이나 장치에 문제가 발생하면 문제의 원인을 신속하게 발견하여 연속적인 생산에 차질을 주지 않도록 적절한 조치를 취한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"화공기술사, 화공기사, 화학분석기사","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C201/M","dJobICdNm":"[C201]기초 화학물질 제조업 / [M]전문, 과학 및 기술 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007359:1', '{"dJobCd":"K000007359","dJobCdSeq":"1","dJobNm":"석유화학소재연구개발자","workSum":"석유화학 기업의 지속성장을 위해 유기 물질의 합성, 구조, 물성, 가공 등 관련 분야의 융·복합 기술을 기반으로 소재개발 계획을 수립하여 유망 신소재 도출, 분석, 평가 등의 업무를 수행한다.","doWork":"석유화학 소재의 특성을 평가하고 구조해석 및 설계를 수행한다. 양산라인 설비 및 공정을 파악하고, 시제품 제조 및 평가 및 장기 내구신뢰성을 평가한다. 설계 요구조건 파악과 구조해석 소프트웨어 교육을 수행한다. 생산팀 및 QA팀과 협의하고, 시양산 운전조건을 설정하여 시제품 품질평가와 시제품 안정성을 평가한다. 고객의 니즈 및 개발정보를 파악하고 가공기술을 지원하며 제조원가를 산정한다. 개발목표 및 계획의 수립과 사업화 방안을 수립한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C201","dJobICdNm":"[C201]기초 화학물질 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007425:1', '{"dJobCd":"K000007425","dJobCdSeq":"1","dJobNm":"석유화학소재연구원","workSum":"석유화학 소재의 개선 및 개발을 위해 소재개발 계획에 따라 소재의 합성, 가공 및 물성 등의 실험 업무를 수행한다.","doWork":"화학물질 정보를 검색하고 화학물질 관련 법령을 파악한다. 화학물질 관리시스템을 활용하고 신규화학물질을 등록하며 신규물질의 유해성 및 안정성을 평가한다. 합성 랩 실험을 준비하고 예비실험을 거쳐 공정실험을 수행한다. 수행한 결과를 토대로 합성공정조건을 최적화하고 실험결과를 종합한다. 포뮬레이션 랩 실험을 준비하고 예비실험을 거쳐 포뮬레이션 랩 처방 원재료 최적화 실험과 공정최적화 실험을 실시하고, 결과를 종합하고 데이터처리하여 관리한다. 시료 준비 및 시편을 제작하고 환경시험조건을 파악하여 소재개발 계획에 따라 실험업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C201/M","dJobICdNm":"[C201]기초 화학물질 제조업 / [M]전문, 과학 및 기술 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005284:1', '{"dJobCd":"K000005284","dJobCdSeq":"1","dJobNm":"석탄가스정제기술연구원","workSum":"석탄가스의 분진, 유해가스 등의 불순물을 정제하기 위한 가스정제기술을 연구·개발한다.","doWork":"석탄을 가스화하기 위해 석탄 가스화장치(Coal Gasification)를 통해 생성된 석탄가스 내의 분진, 산성가스(H2S, COS, CO2), 암모니아, 타르 및 알칼리금속화합물 등 불순물의 정제기술과 공정을 연구·개발한다. 효율적인 정제시스템을 위해 필터나 수증기 등을 이용한 집진기술과 화학반응을 통한 정제기술, 집진장치, 가스정제법과 유황성분의 탈황공정을 연구·개발한다. 정제된 가스의 품질을 검사하고 연소효율 증대와 오염물질 발생 저감을 위해 정제공정의 개선 방안을 모색한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workEnv":"위험내재|소음·진동|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"D352","dJobICdNm":"[D352]연료용 가스 제조 및 배관공급업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005735:1', '{"dJobCd":"K000005735","dJobCdSeq":"1","dJobNm":"석탄가스화기술연구원","workSum":"석탄을 산화제와 반응시켜 기체연료, 합성원료용 가스를 생산하는 석탄가스화기술을 연구·개발한다.","doWork":"석탄을 가스화하기 위해 분쇄된 석탄을 슬러리 또는 미분한 형태로 공급하기 위한 분쇄, 건조시스템을 연구·개발한다. 산화제인 산소를 공급하기 위한 공기 분리시스템(ASU:Air Separation Unit), 미분화된 석탄과 산소를 혼합하여 고온에서 합성가스를 생성하는 가스화기의 공정기술과 시스템을 연구·개발한다. 가스화시스템의 효율을 증대하기 위해 산화제와 가스화기 내 증기의 온도조정 등을 통한 흡열반응을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"D352","dJobICdNm":"[D352]연료용 가스 제조 및 배관공급업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006092:1', '{"dJobCd":"K000006092","dJobCdSeq":"1","dJobNm":"수돗물전과정평가연구원","workSum":"수돗물 공급과정에서 환경에 미치는 영향을 총체적으로 평가하기 위한 전과정평가(LCA:Life Cycle Assessment)를 실시하고 평가기법을 연구한다.","doWork":"수돗물을 생산하고 공급하는 전 과정에서 발생하는 환경오염 요인을 정량화하여 평가하고 이를 저감·개선하는 연구를 한다. 전 과정 환경성 평가를 하기 위하여 환경영향에 대한 자원소모, 지구온난화 등 영향 및 범주별 기여도를 분석하여 어떠한 것이 가장 큰 환경부하가 되는지 분석한다. 환경영향도가 가장 큰 공정을 찾아 최적방안을 도출하고 수돗물 생산공정을 친환경적으로 개선한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"수질환경산업기사, 수질환경기사, 정수시설운영관리사","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"M729/O842","dJobICdNm":"[M729]기타 과학기술 서비스업 / [O842]사회 및 산업정책 행정","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001323:1', '{"dJobCd":"K000001323","dJobCdSeq":"1","dJobNm":"수소생산시스템연구원","workSum":"수소를 생산하기 위한 제조기술과 공정, 설비시스템을 연구·개발한다.","doWork":"효율적인 제조를 위해 화석연료(천연가스 등)를 열분해 등의 방식으로 개질하는 촉매반응기와 정제기를 연구·개발한다. 신·재생에너지를 활용, 물을 전기분해하여 수소를 생산하기 위한 고분자전해질, 알칼리수용액, 고온수증기 등의 시스템 및 광섬유 광학반응기나 편한형 반응기 등을 이용한 광촉방식, 유기물로부터 생물학적 반응으로 수소를 분리방식 등에 따라 적합한 시스템 및 시스템 구성품, 그리고 전체 시스템을 관리할 수 있는 제어시스템을 설계한다. 석유화학 등 다양한 공정에서 발생하는 수소혼합가스부터 수소를 회수·정제하기 위해 수소PSA(Pressure Swing Adsorption)시스템을 연구한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005282:1', '{"dJobCd":"K000005282","dJobCdSeq":"1","dJobNm":"수소에너지연구원","workSum":"수소 생산을 위해 화석연료 개질과 물분해를 통한 수소 제조기술, 핵심 요소 기술, 통합시스템을 연구·개발한다.","doWork":"물 전기분해에 의한 수소 제조기술(PEM형수전해, 고온수증기전해, 알칼라인수전해 등), 열화학 사이클(태양 열화학, 열화학적 메탄 개질, 하이브리드-황 공정 등)을 이용한 물 분해 수소 제조기술, SI 사이클을 이용한 원자력 수소 제조기술을 연구·개발한다. 개질기 및 촉매연소기, 천연가스를 이용한 고효율 수소 및 합성가스 제조방법을 연구한다. 수소 스테이션용 천연가스 수증기 개질 수소 제조시스템을 연구·개발한다. 고압가스, 액체수소 등 효율적인 수소 저장방식을 연구·개발한다. 수소의 저장, 방출 특성을 평가하고 관련 기술을 연구한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001598:1', '{"dJobCd":"K000001598","dJobCdSeq":"1","dJobNm":"수소연료전지 개발자","workSum":"수소연료전지 제작 기획을 기반으로 단위전지, 스택, 공기공급계, 열관리계, 열회수장치, 연료공급계, 수소연료전지 제어기 등을 설계·제작하는 업무를 수행한다.","doWork":"수소연료전지 제작기획서에 따라 단위전지, 분리판, 냉각판, 매니폴드 및 지지구조체 등을 설계·제작하며, 수소연료전지에 공급되는 공기압력·가습 조절에 따라 수소연료전지의 성능, 수명을 최적화하기 위한 공기공급계를 설계, 생산, 품질관리를 한다. 수소연료전지의 종류와 용량에 따라 발생하는 열을 제어하기 위한 열관리 장치와 주변기기를 설계·선정하고, 제작된 수소연료전지 열관리계의 품질을 검사 및 평가한다. 수소연료전지 종류와 용량에 따라 발생하는 열원을 계산, 예측하고 열원을 온수로 저장, 이용하는 기계적 구성 부품과 전기적 제어방법을 고려하여 열회수장치를 설계·제작한다. 수소연료전지 사용 특성에 따른 적정한 수소연료 공급방식에 따라 운전하는데 필요한 수소를 제조하고 공급하기 위해 공정 작업절차서에 따라 추출형과 저장형 연료공급계를 설계하고 제작한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"화학분석기사, 위험물 산업기사","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C204","dJobICdNm":"[C204]기타 화학제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002586:1', '{"dJobCd":"K000002586","dJobCdSeq":"1","dJobNm":"신발화공전문가","workSum":"신발제조에 필요한 소재와 부품에 요구되는 물성의 기준을 평가해 품질을 관리하고, 여러 가지 시험 항목과 시험기기의 운용의 종류를 관리 및 창 배합기를 관리하며 신발제조를 위한 접착 공정의 표준을 결정하고 관리한다.","doWork":"신발 생산 업체에서 신발제조에 필요한 소재와 부품 상태에서 필요한 물성과 화학성를 평가해 품질을 관리한다. 자재 상태의 갑피와 창에 대한 여러 가지 시험 항목과 시험기기의 운용 및 관리를 한다. 신발제조 과정에서 발생하는 여러 가지 요인의 영향을 분석해서 품질의 화학적 품질 기준을 관리한다. 창 배합기를 관리하고, 신발제조를 위한 접착 공정의 표준을 결정하고 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"배합사, 신발 CE","connectJob":"신발CE","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C152","dJobICdNm":"[C152]신발 및 신발 부분품 제조업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006879:1', '{"dJobCd":"K000006879","dJobCdSeq":"1","dJobNm":"에너지저장연구원","workSum":"생산된 전력을 보관하고 소비 부하가 높을 때 사용할 수 있도록 해주는 에너지저장시스템을 연구·개발한다.","doWork":"전력을 효율적으로 사용하기 위해 전력을 저장해 두었다 필요할 때 사용할 수 있도록 하는 에너지저장시스템을 연구·개발한다. 기존 발전 전력과 신·재생에너지 연계형 에너지저장시스템을 연구·개발한다. 발전 및 송전시스템과 연계하여 전기 에너지를 효율적으로 저장하고 필요할 때 송출 할 수 있는 효율적인 양방향시스템을 개발하고 단위면적당 저장용량을 늘릴 수 있는 시스템 구성을 연구한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"ESS(Energy Storage System)연구원","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002182:1', '{"dJobCd":"K000002182","dJobCdSeq":"1","dJobNm":"연료전지소재부품연구원","workSum":"연료전지를 구성하는 촉매, 전해질, 전해질-전극 복합체, 가스켓, 분리판 소재 및 부품 등을 연구·개발한다.","doWork":"연료전지 소재, 부품 관련 국내외 논문, 특허를 읽고 분석한다. 연료전지 촉매, 전해질, 전해질-전극 복합체, 가스켓, 분리판 등 연료전지 구성 소재 및 부품 등을 계산과학, 실험 방법으로 연구개발 한다. 실험을 통해 성능, 내구성을 평가한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"고분자전해질형연료전지셀연구원, 용융탄산염형연료전지셀연구원","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C282","dJobICdNm":"[C282]일차전지 및 축전지 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001885:1', '{"dJobCd":"K000001885","dJobCdSeq":"1","dJobNm":"연료전지스택연구원","workSum":"연료전지(Fuel Cell) 단전지(셀, Cell)를 적층시킨 스택(Stack)을 연구·개발한다.","doWork":"개발된 단전지를 활용하여 스택의 출력과 효율을 향상시키는 스택기술을 연구·개발한다. 전기화학반응의 효율과 내구성을 강화하기 위한 새로운 스택 구조 및 설계 방법 등을 연구한다. 단전지의 성능을 극대화하기 위해 스택 내부의 유로 설계, 체결 압력 최적화, 열 관리 시스템 설계 등을 연구한다. 연료전지단전지연구원들과 협업하여 전해질, 전극, 분리판 등 재료 특성 분석 및 개선, 실험을 통한 성능 검증과 분석, 성능 저하 원인 파악 및 최적화 방안 도출 등을 연구한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"연료전지스택개발자, 연료전지스택설계자","connectJob":"고체산화물연료전지연구원, 용융탄산염연료전지연구원","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C282","dJobICdNm":"[C282]일차전지 및 축전지 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002542:1', '{"dJobCd":"K000002542","dJobCdSeq":"1","dJobNm":"염료개발연구원","workSum":"염료(染料), 염료 중간체(중간물질), 가공제 등을 개발하고 염료의 색, 견뢰도, 용해도, 염착성 등을 연구한다.","doWork":"염료의 출발물질인 방향족 탄화수소(벤젠, 톨루엔, 나프탈렌, 안트라센 등)에 대하여 연구한다. 화학적 조작(니트로화, 술폰화, 염소화, 아실화 등)을 통해서 염료 중간물질(아닐린, 알킬아닐린, 아실아닐린, 클로로아닐린, 니트로아닐린, 알콕시아닐린, 많은 종류의 술폰화된 아미노나프탈렌과 히드록시나프탈렌, 아미노안트라퀴논과 히드록시안트라퀴논 등)을 생성하는 연구를 한다. 염료 중간물질을 이용해서 최종적인 염료(분산염료, 반응성염료, 산성염료, 배트염료, 양이온염료, 형광증백제 등)를 개발한다. 염료의 색, 견뢰도(세탁과 마찰, 땀, 광조사 등에 의해서 변색·퇴색하지 않는 성질), 용해도, 염착성(섬유에 효과적으로 염착하는 성질) 등에 대하여 연구한다. 염료의 생산공정 및 염색 가공공정에서 발생되는 공해물질의 감소 방법을 연구·개발한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"웅크림|시각|","workEnv":"대기환경미흡|위험내재|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"염료개발원, 염료합성연구원","certLic":"섬유기사, 섬유산업기사","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C204/M701","dJobICdNm":"[C204]기타 화학제품 제조업 / [M701]자연과학 및 공학 연구개발업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006630:1', '{"dJobCd":"K000006630","dJobCdSeq":"1","dJobNm":"온실가스저감기술연구원","workSum":"이산화탄소 처리를 위한 포집 기술 및 온실가스 배출 원천 저감기술, 온실가스처리 기술, 석탄 사용에 따른 오염물질 배출 저감기술 등을 연구·개발한다.","doWork":"흡수, 흡착, 막분리를 이용한 연소 후 CO₂ 포집 기술, 연소 전 CO₂ 포집기술을 연구·개발한다. 순산소 연소 CO₂ 포집용 산소 제조기술을 연구·개발한다. 발전, 철강, 시멘트 등 대용량 CO₂ 배출원에 CO₂ 포집기술을 적용하고 관련된 설비와 장비, 온실가스 분리를 위한 효율적 공정을 연구·개발한다. 온실가스 배출 원천 저감기술, 신개념 온실가스 처리기술, 석탄 사용에 따른 오염 물질 배출 저감기술 등을 연구·개발한다. 온실가스 저감기술의 조사·분석 및 배출계수 개발을 통해 국가 기후변화 대응 기술정책에 활용하고, 개발된 온실가스 처리기술을 청정개발체제(CDM) 사업에 활용한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003898:1', '{"dJobCd":"K000003898","dJobCdSeq":"1","dJobNm":"온실가스포집기술연구원","workSum":"온실가스 저감을 위해 이산화탄소(CO₂)의 CCS(Carbon Capture & Storage:포집·수송·저장, 이산화탄소를 대량발생원으로부터 포집한 후 압축·수송과정을 거쳐 육상 또는 기타 방법으로 저장하거나 유용한 물질로 전환하는 일련의 과정) 관련 장비를 연구·개발한다.","doWork":"이산화탄소의 연소 전 포집기술(연소 전 처리 반응시스템, 연소 전 처리 회수공정), 연소 중, 연소 후 포집기술(습식흡수기술, 건식흡수기술, 흡착기술, 분리막기술) 관련 플랜트 설비 및 흡수제를 이용한 이산화탄소 포집 장비를 연구·개발한다. 고농도로 포집된 이산화탄소를 탱크로리, 파이프라인, 선박 등을 통해 저장소 또는 전환 플랜트로 이송하는 과정 중에 필요한 이산화탄소 수송 장비를 연구·개발한다. 이산화탄소(CO₂)의 저장기술(지중 저장기술, 화학적·생물학적 방법을 통해 화학소재 또는 연료 등으로 전환·재활용하는 기타 저장기술)플랜트 관련 설비 및 장비를 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"이산화탄소포집기술연구원","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004255:1', '{"dJobCd":"K000004255","dJobCdSeq":"1","dJobNm":"유기재료피복연구원","workSum":"강판에 유기물질을 피복(Coating)하여 도장성과 내구성을 높이기 위한 연구를 수행한다.","doWork":"합성하고자 하는 수지의 견본(Sample)을 전처리하여 분자구조를 파악한다. 합성하고자 하는 물질의 단량체(Monomer)들을 선정하여 반응조건에 맞게 반응시킨다. 강판에 합성한 유기물질을 피복(Rolling Coating)한 다음 수지의 충격내구성, 염분내구성, 표면유연성 등을 시험한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006861:1', '{"dJobCd":"K000006861","dJobCdSeq":"1","dJobNm":"유기합성의약연구원","workSum":"유기합성의 약품을 개발하기 위한 연구를 한다.","doWork":"대상으로 하는 약물의 원료를 비교·검토한 후 국내외 문헌, 특허 등의 정보를 통해 사업성을 검토하여 원료를 선정한다. 선정된 물질의 합성과정을 설계하여 합성공정을 개발한다. 생산의 질을 높이고 과정을 간소화하여 생산능력을 높이며, 비용을 낮추기 위하여 합성실험을 통하여 양산화 공정을 설계한다. 물질을 만들기 위해 각종 화공약품을 이용하여 반응 온도, 시간 등의 최적요인을 탐구하고 독자적인 반응과정을 개발한다. 반응물의 이성실체(Isomer), 불순물(Impurity)의 유무를 고속액체크로마토그래프(HPLC), 가스크로마토그래프(GC), 핵자기공명분광기(NMR), 적외선분광기(IR)등의 분석기를 이용하여 분석한다. 새롭게 시도된 공정상의 실험실 연구가 끝나면 반응기, 냉각기, 원심분리기, 재결정, 여과기, 건조기, 분쇄기, 입자화기 실험을 통하여 예비 공정시험을 한다. 시료를 채취하여 분석기로 분석하고 해석하여 보완책을 연구하기도 한다. 자문, 교육 등 생산공정 개발을 현장에 지원하기도 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C211","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007426:1', '{"dJobCd":"K000007426","dJobCdSeq":"1","dJobNm":"의약품분석연구원","workSum":"의약품의 품질을 평가하기 위해 약물의 목표품질에 적합하게 유효성, 안전성, 안정성이 확보될 수 있는지 분석하고 품질관리를 위한 평가방법, 기준을 설정한다.","doWork":"원료, 대조약, 공정서, 논문 등을 통해 분석법 문헌연구를 진행하고 분석연구 계획, 초기 연구를 위한 시험방법을 작성한다. 제품개발의 품질 목표 설정, 배합 적합성 및 가혹시험, 제품의 안정영향성 분석, 첨가제 선정, 배합비율, 허가 시 제출 범위 등을 고려하여 위험성을 평가한다. 전처리 방법, 기기분석 조건에 따른 분석연구, 용출기준설정 근거를 위한 예비 또는 본 시험을 수행한다. 분석법 밸리데이션 시험 수행 및 트러블슈팅, 통계적 자료 도출 및 Raw data를 관리한다. 분석법 기술이전을 위한 샘플 선정, 기기, 시약, 용매, 표준정보를 취합한다. 비교용출 시험 실시 및 트러블슈팅과 비교용출 시험 배치들의 제조 정보 및 성적서를 확인한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C211","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006600:1', '{"dJobCd":"K000006600","dJobCdSeq":"1","dJobNm":"의약품연구원","workSum":"의약품과 관련한 원료개발, 공정개선, 신기술도입 등을 통한 신약, 신물질 등의 신제품개발을 위해서 시험·분석·연구 개발한다.","doWork":"일반의약품, 원료의약품, 생약제제, 생물학적제제, 의약품정제 등 의약품과 관련한 신제품을 개발하기 위하여 국내외 각종 전문적인 자료 및 정보를 수집한다. 제품과 원료를 시험·분석하여 새로운 품질로 개량하는 연구 및 제품제조의 경제성을 높이기 위한 연구를 한다. 원료로부터 완제품 생산까지의 시험법을 조사하여 이화학적, 미생물학적 시험 및 동물학적 시험을 수행한다. 각종 시험 및 분석에 의해 제품구조, 공정, 제조방법 등 제품제조시스템의 기준을 확립한다. 신제품의 양산체제를 갖추면 제품의 생산내역을 관련 제조부서로부터 인수받아 개발품의 생산공정 상의 문제점 및 보완방법을 연구한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"의약품화학공학기술자","connectJob":"첩부의약품연구원","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C211/C212/C213","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업 / [C212]의약품 제조업 / [C213]의료용품 및 기타 의약 관련제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007326:1', '{"dJobCd":"K000007326","dJobCdSeq":"1","dJobNm":"의약품제제연구원","workSum":"약물의 치료 효과를 얻기 위해 약물의 성상과 물리화학적 성질, 재료, 가공법, 약효, 안전성, 투여 방법 등을 종합적으로 검토하여 적합하게 배합하고 가공한다.","doWork":"원료의약품의 제조처별 물리화학적 특성을 파악하고 배합적합성 평가를 위한 기능별 부형제 선정 및 통계처리를 수행한다. 제형개발을 위한 기능성 부형제 비교연구, 대조약 또는 기존 제품의 함량, 용출 등 물리화학적 평가를 진행한다. 의약품 제조 및 공정개선 연구, Quality by Design(QbD) 기법을 이용한 공정 최적화 연구, Design of Experiment 기법을 이용한 연구 과정의 계획 및 통계처리를 수행한다. 개발 대상 의약품의 유효기간 산정을 위한 안정성 연구, 의약품 검증을 위한 분석법, 밸리데이션 연구, 제조시설로의 기술이전을 위한 파일럿 스케일(pilot scale, 또는 pilot plant: 실제 플랜트 운영을 위해 확인하기 위한 시험) 연구와 의약품 제조공정의 재현성 평가를 진행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C211","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006959:1', '{"dJobCd":"K000006959","dJobCdSeq":"1","dJobNm":"의약품합성연구원","workSum":"의약품의 안전성과 유효성을 증명하기 위하여, 의약품의 목표 특성에 맞는 화합물을 찾기 위해 개발 대상물질을 선별검사하고 최적화하는 업무를 수행한다.","doWork":"합성반응 스킴을 기준으로 공정조건 최적화실험, 분석실험, 성능평가와 실험방안을 설정하고, 반응기를 디자인하며 실험 장비를 선정한다. 실험의 우선순위와 소요시간을 고려하여 전체실험의 소요일정을 계획하고, 합성제품의 안정성을 확보, 수율을 극대화할 수 있는 합성 공정조건을 선정한다. 확정된 합성공정을 통해 얻어진 합성제품에 대한 제품규격을 작성, 분석시험법의 신뢰성 확보를 위해 밸리데이션을 진행하고, 표준분석방법을 기록한다. 합성시료 분석데이터를 통계적으로 처리하고 제품규격 작성을 위한 데이터 변동범위를 설정한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C211","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001542:1', '{"dJobCd":"K000001542","dJobCdSeq":"1","dJobNm":"이차전지관리시스템개발자","workSum":"리튬이온전지의 모듈과 팩을 구성하는 셀(Cell)의 작동상태를 모니터링하고 제어하는 전지관리시스템(BMS:Battery Management System)을 설계·개발한다.","doWork":"리튬이온배터리 모듈과 팩을 구성하고 있는 셀(Cell)의 오사용 방지(Protection)기능과 단위전지 간의 균등화(Balancing), 에너지 잔량 측정, 온도유지관리, 시스템모니터링 기능을 개발한다. 셀의 상태를 측정하는 센서와 센서의 측정값을 수신하여 응용제품의 제어시스템에 전달하는 기능을 구현한다. 시스템의 온도 및 충전상태 등이 설정된 값을 초과하면 이상신호를 발생시키고 셀 간의 전력회로를 차단·개방하는 회로를 구축하고 제어하는 프로그램을 작성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C282","dJobICdNm":"[C282]일차전지 및 축전지 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003847:1', '{"dJobCd":"K000003847","dJobCdSeq":"1","dJobNm":"작물보호제연구원","workSum":"작물보호제의 이화학, 독성, 잔류성, 생물활성을 평가하여, 우수하고 안전한 작물보호제 사용기술을 연구·개발한다.","doWork":"작물 재배 중에 발생하는 병해충 및 잡초를 파악한다. 작물에 따라 병해충과 잡초의 피해 정도를 파악하고 발생 시기와 방제 적기에 관한 자료를 수집한다. 병충해의 동시방제 가능성, 약효 증진, 작물보호제 비용 절감, 노동력의 절감, 인간이나 가축에 대한 안전성 및 환경보전 가능성 등을 고려하여 각종 실험기기나 작물보호제의 원·부자재를 혼합하여 작물보호제를 개발한다. 작물보호제 제조 시 사용되는 여러 가지 부자재의 화학적 특성을 조사하고, 원제에 함유되어 있는 불순물의 종류와 함량을 분석하여 작물보호제 제품의 안전성을 확보한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"시각|","workEnv":"대기환경미흡|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"농약연구원(일반)","connectJob":"환경농약잔류연구원, 농약안전성평가연구원, 작물농약잔류연구원","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C204/M701","dJobICdNm":"[C204]기타 화학제품 제조업 / [M701]자연과학 및 공학 연구개발업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004227:1', '{"dJobCd":"K000004227","dJobCdSeq":"1","dJobNm":"작물보호제활성연구원","workSum":"환경조화형 작물보호제를 개발하기 위하여 유기합성 화합물, 천연물, 미생물 등 활성 미지물의 작물보호제로서의 이용가능성을 평가하고, 시료의 농업생물에 대한 생리·생태·생화학적인 특성 규명을 연구한다.","doWork":"농업유해 생물의 유해성과 방제의 경제적 가치를 조사하여 그 종을 균일한 실험재료로 확보하여 유지·증식한다. 활성미지물의 유해생물에 대한 방제 여부와 방제가능 약량(藥量:약을 쓰는 분량)을 조사한다. 유해생물에 활성을 나타내는 물질에 대하여 그 작용특성과 활성의 변동요인을 다각도로 검토하여 생물적 효과의 장·단점을 평가한다. 약제의 처리적기, 처리방법, 토양 중의 분해대사, 제형 등을 실제 약제가 사용될 야외 포장조건에서 검토한다. 작용점에서의 감수성 및 약제의 흡수, 이행, 대사성을 조사하여 표적생물과 비표적생물 간의 선택성을 규명하고, 저항성종의 출현에 대비한다. 표적생물에 대한 증상과 물질의 구조로부터 작용가능 기작을 선정하고 이와 관련된 생리화학적 실험을 통하여 작용기작을 규명한다. 물질의 구조와 생리활성과의 관계를 작용수준점에서 평가하여 적합한 화합물의 합성을 유도하고 생물의 생리화학적 정보로부터 새로운 작용점의 탐색과 그 검정기술을 확립한다. 합성물 및 자연계로부터의 새로운 모핵(母核)을 탐색함으로써 환경조화형 농약의 개발을 선도한다. 농업생물의 생명현상을 규명하고 기능의 활용성을 다각도로 연구한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"시각|","workEnv":"대기환경미흡|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"농약활성연구원","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C204/M701","dJobICdNm":"[C204]기타 화학제품 제조업 / [M701]자연과학 및 공학 연구개발업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006313:1', '{"dJobCd":"K000006313","dJobCdSeq":"1","dJobNm":"접착제연구원","workSum":"두개의 피접착면을 접착시키는 무용제형(Hot Melt) 및 용제형(Bond) 점·접착제를 연구·개발한다.","doWork":"인장강도, 증발성질, 유연성 등 접착제의 기본적인 성질을 분석한다. 열가소성 접착제와 열경화성 접착제, 천연접착제에 대한 연구·개발을 한다. 피접착면에 적용이 가능한 폴리머(Polymer)를 선정하고 브랜딩의 요소를 파악한 후, 관련 자료를 조사한다. 기초배합식과 적용 후 도출될 문제점을 검토·보완한다. 최종 배합식을 완성한 후 특성에 따른 적합시험을 실시한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C204","dJobICdNm":"[C204]기타 화학제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006960:1', '{"dJobCd":"K000006960","dJobCdSeq":"1","dJobNm":"정밀화학공정관리자","workSum":"정밀화학 제품의 수량, 품질 수준 등을 일정 시간 내에 효율적으로 달성하기 위해 공정 및 설비에 대한 지식과 기술을 이용하여 공정관리항목 설정, 작업표준설정, 공정성과관리 등의 업무를 수행한다.","doWork":"제조설비 결정과 공정 배치계획을 세우고 공정을 관리한다. 공정관리 항목을 설정하고 공정상태를 판단하여 공정 이상발생 시 적절한 조치를 취하고 공정조건의 최적화를 유지한다. 표준작업을 설정하고 제조작업표준서를 작성한다. 공정 개선계획의 수립과 개선 효과를 분석하고 공정관리 성과 항목을 설정하여 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C203/C204","dJobICdNm":"[C203]비료, 농약 및 살균, 살충제 제조업 / [C204]기타 화학제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006984:1', '{"dJobCd":"K000006984","dJobCdSeq":"1","dJobNm":"정밀화학공정실험연구원","workSum":"정밀화학제품제조의 효율적인 공정 개발을 위하여 공정연구개발 계획에 따라 공정개발실험과 관련된 직무를 수행하고 공정최적화 실험 및 스케일업 실험 등의 업무를 수행한다.","doWork":"공정실험 설비 관리와 공정실험을 위해 원료를 준비하고 설비를 점검하며 공정 최적 조건을 확인한다. 공정최적화 실험을 실시하고 공정 스케일업 실험을 실시한다. 공정실험결과를 정리하며 공정개선 제품의 품질을 평가한다. 공정실험결과에 대한 공정실험보고서를 작성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C203/C204","dJobICdNm":"[C203]비료, 농약 및 살균, 살충제 제조업 / [C204]기타 화학제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006985:1', '{"dJobCd":"K000006985","dJobCdSeq":"1","dJobNm":"정밀화학공정연구개발자","workSum":"정밀화학 제품의 성능 및 제조 경쟁력을 높이기 위하여 연구개발 계획을 수립하고, 공정설계 및 최적화 등을 통해 효율적인 공정을 유지하며 공정연구 담당자에게 공정연구개발 분야의 지식을 전달하고 업무를 감독한다.","doWork":"공정기술 동향을 조사·분석하고 공정연구개발 계획을 수립한다. 현재 공정의 문제점을 파악하고 공정개선 목표 수율의 확인과 공정개선 목표 품질을 확인한다. 공정 조건을 재설정한 공정설계 및 최적화 상태를 실행하고 유지한다. 공정흐름도를 작성하고 단계별 실험 조건을 확인하며 공정 스케일업을 실행한다. 양산공정의 최종 확인과 공정개선의 효과를 분석한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C203/C204","dJobICdNm":"[C203]비료, 농약 및 살균, 살충제 제조업 / [C204]기타 화학제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007003:1', '{"dJobCd":"K000007003","dJobCdSeq":"1","dJobNm":"정밀화학분석실험연구원","workSum":"정밀화학 분석실험의 신뢰성 있는 분석법을 연구·개발하기 위하여 분석실험과 관련된 전반적인 직무를 수행하며 분석연구 계획에 따라 이화학분석 및 기기분석 실험 등의 업무를 수행한다.","doWork":"분석실험 실시를 위한 시약·기기·장비 및 시약문서를 관리한다. 분석업무지시서를 확인하고 분석시료의 특성을 확인하며 분석실험을 위한 준비를 한다. 습식분석실험과 건식분석실험을 실시하며 시료의 전처리를 수행한다. 이화학분석 실험, 기기분석실험을 진행하며 분석 후 분석결과 보고서를 작성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C203/C204","dJobICdNm":"[C203]비료, 농약 및 살균, 살충제 제조업 / [C204]기타 화학제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007004:1', '{"dJobCd":"K000007004","dJobCdSeq":"1","dJobNm":"정밀화학분석연구개발자","workSum":"정밀화학 물질의 물리·화학적 특성을 분석하기 위하여 분석연구 계획을 수립하고, 분석방법 개발 및 밸리데이션 등을 통해 신뢰성 있는 분석법을 연구개발 하며 분석실험 담당자에게 분석연구 분야에 대한 지식을 전달하고 업무를 감독하는 일을 수행한다.","doWork":"정밀화학 분석기술 동향을 조사·분석하고 분석연구 중·장기계획(로드맵)을 수립한다. 분석연구 계획 및 목표를 설정하고 분석조건을 설정하고 분석방법을 개발한다. 분석방법의 신뢰성을 확인하고 분석방법 밸리데이션을 실행한다. 분석결과를 분석하여 신뢰성을 검증하며, 분석기기의 적격성 평가를 실행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C203/C204","dJobICdNm":"[C203]비료, 농약 및 살균, 살충제 제조업 / [C204]기타 화학제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007005:1', '{"dJobCd":"K000007005","dJobCdSeq":"1","dJobNm":"정밀화학안전성유효성연구원","workSum":"정밀화학제품의 인체에 대한 자극과 독성 최소화 및 기능적 효과를 확보하기 위하여 안전성·유효성 평가기술에 대한 동향 조사와 분석을 통해 연구개발 계획, 평가방법 개발 등을 수행한다.","doWork":"정밀화학제품의 안전성·유효성 평가기술 동향을 조사·분석하고 안전성·유효성 연구에 대한 중·장기계획(로드맵)의 수립과 안전성·유효성 연구 계획 및 목표를 설정한다. 효력 시험방법 설정과 미생물 시험방법 설정 등 안전성·유효성 평가방법을 개발하고 데이터 통계분석 등 안전성·유효성 평가 결과의 분석을 통해 안전성·유효성 평가방법의 신뢰성을 확인한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C203/C204","dJobICdNm":"[C203]비료, 농약 및 살균, 살충제 제조업 / [C204]기타 화학제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007006:1', '{"dJobCd":"K000007006","dJobCdSeq":"1","dJobNm":"정밀화학포뮬레이션실험연구원","workSum":"기업의 정밀화학 포뮬레이션 물질을 개발하기 위하여 연구개발 계획에 따라 원재료 및 공정 최적화 실험, 규격 및 성능평가 실험 등 포뮬레이션과 관련된 전반적인 업무를 수행한다.","doWork":"포뮬레이션 실험장비를 관리하고 실험을 위한 준비 및 포뮬레이션 예비 처방 실험을 한다. 포뮬레이션 원재료 최적화 실험과 포뮬레이션 기본공정 실험, 포뮬레이션 공정최적화 실험, 포뮬레이션 제품규격 검사 실험, 포뮬레이션 제품 성능평가실험을 수행하고 포뮬레이션 실험결과의 기본 통계 분석을 하며 실험결과를 정리한다. 실험결과에 따라 양산공정 실험을 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C203/C204","dJobICdNm":"[C203]비료, 농약 및 살균, 살충제 제조업 / [C204]기타 화학제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006754:1', '{"dJobCd":"K000006754","dJobCdSeq":"1","dJobNm":"정밀화학포뮬레이션연구개발자","workSum":"정밀화학 포뮬레이션 물질과 관련된 새로운 물질을 개발하기 위하여 연구 계획을 수립하고, 포뮬레이션 설계, 최적화 연구 등을 통해 포뮬레이션 물질을 연구개발하고 원재료 및 공정 최적화 실험, 규격 및 성능평가 실험 등을 수행·지시·감독한다.","doWork":"포뮬레이션 정밀화학 및 포뮬레이션 기술동향을 조사·분석하고 포뮬레이션 연구·개발 계획을 수립한다. 포뮬레이션 기본 설계와 포뮬레이션 원재료 최적화를 연구하고 공정 최적화 연구를 통해 포뮬레이션 원재료 최적화 및 공정최적화 방법을 설정한다. 포뮬레이션 제품의 규격 설정과 포뮬레이션 성능규격을 설정하고 작성하며 포뮬레이션 연구개발 결과를 정리한다. 포뮬레이션 연구개발 결과를 반영하여 양산화 실험계획을 수립하고 양산화를 실행하며 생산부문을 이관한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C203/C204","dJobICdNm":"[C203]비료, 농약 및 살균, 살충제 제조업 / [C204]기타 화학제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006755:1', '{"dJobCd":"K000006755","dJobCdSeq":"1","dJobNm":"정밀화학합성실험연구원","workSum":"정밀화학 합성물질을 개발하기 위하여 연구개발 계획에 따라 공정 최적화 실험, 규격 및 성능평가 실험 등 합성실험과 관련된 전반적인 업무를 수행한다.","doWork":"합성공정 최적화 실험과 합성제품 규격·성능을 확인하기 위해 실험 준비를 한다. 규격을 분석하고 성능을 평가한다. 합성실험 후 실험결과를 분석하고 정리한다. 합성결과에 따라 최적의 합성공정을 확인한다. 합성수율을 정리하고 합성연구 개발 결과에 따라 양산화 실험을 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C203/C204","dJobICdNm":"[C203]비료, 농약 및 살균, 살충제 제조업 / [C204]기타 화학제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007416:1', '{"dJobCd":"K000007416","dJobCdSeq":"1","dJobNm":"정밀화학합성연구개발자","workSum":"정밀화학 합성물질과 관련한 새로운 물질을 개발하기 위하여 연구 계획을 수립하고 반응 설계, 규격 및 성능평가 실험 등을 수행하며 합성실험 담당자와 협업 하여 목표 정밀화학 합성물질을 연구·개발한다.","doWork":"정밀화학 합성 기술동향을 조사·분석하고 합성연구개발 계획을 수립한다. 합성 반응 설계와 화학구조를 설계하며 목표 품질을 설정하고 합성실험계획을 수립한다. 최적화된 실험방법을 선정하고 성능항목을 설정하며 항목별 평가 기준을 선정한다. 합성제품 성능규격 및 평가 방법을 작성하고 합성연구 개발을 수행하며 합성연구개발 결과를 정리한다. 합성실험 담당자에게 합성연구개발의 지식을 전달하고 업무를 지시·감독한다. 합성연구개발결과 양산화 추진과 사업화 여부를 결정하고 시험생산을 진행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C203/C204","dJobICdNm":"[C203]비료, 농약 및 살균, 살충제 제조업 / [C204]기타 화학제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007417:1', '{"dJobCd":"K000007417","dJobCdSeq":"1","dJobNm":"정밀화학합성제조관리자","workSum":"도료, 접착제, 색소 등의 정밀화학 합성제품제조를 위해 생산계획에 따라 제조설비, 제조인력, 원재료 등의 자원을 활용하여 제조계획을 수립하고 품질규격에 따라 합성작업을 지시·감독하며 그 성과를 분석·관리한다.","doWork":"합성제조 생산 일정을 계획하고 관리하며 작업자들이 혼합제조를 수행하도록 작업지시서를 작성한다. 공정제품과 완제품의 제조 규격을 설정하고 공정에 필요한 설비와 적절한 인원배치를 한다. 제조공정 중 이상발생시 작업자에게 조치사항을 지시하며 합성제조 작업의 수율관리와 생산관리를 한다. 합성제조 생산 자재수급 계획을 수립한다. 합성제조 표준서를 작성하고 합성작업 관리 및 합성제조 안전·환경·보건·위생 관리를 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C203/C204","dJobICdNm":"[C203]비료, 농약 및 살균, 살충제 제조업 / [C204]기타 화학제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007296:1', '{"dJobCd":"K000007296","dJobCdSeq":"1","dJobNm":"정밀화학혼합제조관리자","workSum":"기업의 화장품, 계면활성제 등 정밀화학 혼합제조제품을 효율적으로 생산하기 위하여 제조설비, 제조인력, 원재료 등의 자원을 활용하여 제조계획을 수립하고 혼합제조를 수행·지시·감독하고 그 성과를 분석·관리한다.","doWork":"정밀화학 혼합제조 생산 일정을 계획하고 설비와 작업원을 배치한다. 제조원들이 작업을 수행할 수 있도록 작업지시서를 작성하고 작업관리를 한다. 공정제품과 완제품 제조규격을 설정하고 제조공정 중 이상발생 시 조치사항을 결정한다. 공정의 품질관리와 수율관리 및 생산성을 관리하고 안전·환경·보건·위생 규정을 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C203/C204","dJobICdNm":"[C203]비료, 농약 및 살균, 살충제 제조업 / [C204]기타 화학제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004694:1', '{"dJobCd":"K000004694","dJobCdSeq":"1","dJobNm":"정유공정개발연구원","workSum":"정유공정 설비의 노후화를 방지하고 고부가가치를 실현하기 위해 고부식성·고온·고압공정·공정별 촉매를 연구·개발하여 설비의 안전성을 평가·확보한다.","doWork":"인장시험기, 경도시험기 및 전기화학 실험장치 등을 통하여 성분분석, 파면분석을 실시하여 정유공정 설비재료의 물성을 파악한다. 모사시험을 통하여 위험요인에 대한 정확한 원인을 규명하고 대책을 마련한다. 공정에 사용되는 배관의 안전성을 평가한다. 배관모재의 열처리 범위를 위한 모사시험, 용접부 모사시험, 예민화 측정을 위한 전기화학시험등을 실시한다. 부식성 원유에 따른 각 공정의 유체를 채집하여 부식성을 평가한다. 고압공정 시험을 통하여 고부식성 원유를 평가한다. 새로운 촉매에 의한 공정 효율화를 평가한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"부식공학연구원","certLic":"화공기사, 화공기술사","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C192","dJobICdNm":"[C192]석유 정제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001972:1', '{"dJobCd":"K000001972","dJobCdSeq":"1","dJobNm":"정유제품시험분석원","workSum":"석유정제 공정의 중간제품 및 최종제품인 화합물 원제, LPG, 연료유, 윤활유 및 그리스 등에 대해서 시약, 초자류(비커, 플라스크, 시험관 등) 및 시험분석기기를 사용하여 시험, 분석을 실시하고 물리적 화학적 특성을 기준치와 비교·분석한다.","doWork":"시험시료를 채취한 후 시약, 초자류 및 시험분석기기 등을 이용하여 시험을 실시한다. 제품별 특성에 따라 점도, 인화점, 순도, 색도, 산도, 염도 및 불순물 함량 등의 다양한 물리적, 화학적 특성을 확인한다. 출하되는 제품에 대한 품질검사를 실시하며, 합격한 경우 시험성적서, 검사성적서를 발급하여 제품이 출하될 수 있도록 허가한다. 제품에 대한 시험 데이터를 품질관리 분석기법에 의하여 분석하고 생산능력지수 등 분석결과를 생산부서에 제시하여 공정개선의 동기를 부여한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"품질경영기사, 품질경영산업기사, 분석화학기사","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C192","dJobICdNm":"[C192]석유 정제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007190:1', '{"dJobCd":"K000007190","dJobCdSeq":"1","dJobNm":"청정석탄연구원","workSum":"석탄을 고부가가치의 청정연료로 활용하기 위해 저등급 석탄을 액체연료(가솔린, 디젤 등)와 전기로 생산하는 기술을 연구·개발한다.","doWork":"석탄에서 액체연료(가솔린, 디젤 등)를 생산하는 석탄가스 정제 및 액화(CTL:Coal-To-Liquids) 기술을 연구·개발한다. 저등급 석탄을 가스화하여 청정에너지로 활용하는 저급탄가스화기술을 연구·개발한다. 탈회 및 열분해 등을 통한 석탄의 청정에너지화, 가스합성연료(GTL:Gas-To-Liquids) 기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005770:1', '{"dJobCd":"K000005770","dJobCdSeq":"1","dJobNm":"타이어개발연구원","workSum":"타이어의 재료(고무, 약품류, 보강재, 충진제, 지연제, 촉진제, 오일류 등), 컴파운드, 공정구조, 물석특성, 회전저항 및 밸런스, 패턴 및 구조, 소음, 주행성능 등을 연구하고, 효율적인 제조공정을 분석·개발한다.","doWork":"타이어 원부재료(천연고무, 합성고무, 카본블랙, 실리카, 프로세스오일, 노화방지제, 가류제, 접착제 등) 특성을 연구하고 신재료를 개발한 후 적응성을 평가한다. 스틸코드, 직물코드, 스틸 와이어 등 타이어 구조의 보강 재료인 섬유 및 강선코드에 관하여 연구한다. 원재료별 세부특성에 따른 컴파운드의 물성을 규명하고 배합기술 및 시험데이터를 해석한다. 저발열성, 고내구성, 저회전저항, 내마모성 등의 특성을 가진 타이어의 구조 및 설계요소, 내구력 및 회전저항 예측수단에 관하여 연구·개발한다. 타이어의 구조 해석기법, 해석시스템 및 해석기술 등을 연구·개발한다. 고무배합, 압출, 압연, 비드, 재단, 성형 및 가류 등 타이어 제조공정의 수치해석기법을 연구하며, 타이어 설계시스템을 개발·개선한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"컴파운드개발연구원","connectJob":"타이어구조연구원, 타이어재료연구원, 타이어 특성연구원","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007801:1', '{"dJobCd":"K000007801","dJobCdSeq":"1","dJobNm":"탄소포집저장운송전환기술자","workSum":"화석연료가 연소할 때 배출되는 이산화탄소의 포집기술을 연구⋅개발한다.","doWork":"발전소나 산업현장 등에서 산업 공정 중 발생하는 이산화탄소를 분리하고 회수하는 기술을 연구⋅개발한다. 공기 중 또는 배출원에서 발생하는 이산화탄소를 포집하는 기술을 개발한다. 포집된 이산화탄소를 저장소 또는 플랜트로 운송하는 방법을 연구한다. 운송과정에서 발생할 수 있는 누출 등의 안전 문제에 대한 해결책 방안을 마련한다. 포집된 이산화탄소를 저장할 수 있는 지질학적 저장층(지하 심부 염수층, 폐유가스전 등)이나 해양 깊은 곳을 탐색하고 저장소를 설계한다. 이산화탄소가 대기 중으로 다시 배출되지 않도록 저장 안정성을 확보하는 기술을 개발한다. 화학적 또는 생물학적 방법을 통해 이산화탄소를 유용한 물질로 전환하거나 재활용하는 기술을 개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2025"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005356:1', '{"dJobCd":"K000005356","dJobCdSeq":"1","dJobNm":"폐자원에너지연구원","workSum":"다양한 종류의 가연성·유기성 폐기물을 환경친화적으로 처리하여 에너지화하기 위한 핵심기술을 연구·개발한다.","doWork":"고분자 폐기물로부터 고급 연료유 생산을 실용화하기 위한 공정 및 기술을 연구·개발한다. 고형연료(RDF)의 제조 및 연소, 고분자 폐기물의 열분해 및 고효율 탈염 요소기술을 연구·개발한다. 유기성 폐기물 에너지화, 비재래형 석유계 연료로부터 합성석유 생산, Non-CO₂ 온실가스 저감, 유기성 폐기물로부터 생물적 수소 및 오일을 생산하는 등 다양한 종류의 가연성·유기성 폐기물을 환경친화적으로 처리하여 에너지화하기 위한 핵심기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001799:1', '{"dJobCd":"K000001799","dJobCdSeq":"1","dJobNm":"폭발응용연구원","workSum":"화약 및 폭약의 충전기술, 화공품의 개발기술 등을 각종 산업기술에 응용하는 방법을 연구한다.","doWork":"폭약을 이용한 이종재료의 접합기술, 가스제너레이터의 기술을 응용한 자동차용 에어백의 부품장치, 사용상의 안전성과 정밀성을 향상시킨 전자뇌관, 고연소 자기합성기술, 폭약의 폭발파를 이용한 다이아몬드의 합성, 성형장약의 원리를 이용한 폭발절단 테이프 등을 연구·개발한다. 과학위성 및 통신위성의 발사체, 액체로켓 추진기관, 분사제어로켓 및 분리부분폭발볼트 등을 연구·개발한다. 폭약을 사용한 국내외 기술동향과 응용사례를 수집하고 새로운 응용분야를 개발한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007297:1', '{"dJobCd":"K000007297","dJobCdSeq":"1","dJobNm":"플라스틱배합설계자","workSum":"플라스틱 배합설계에 대하여 제한된 권한 내에서 컴파운딩 분야의 고분자화합물 기초이론 및 현장 실무지식을 사용하여 전반적인 배합설계 업무를 수행한다.","doWork":"플라스틱 배합설계를 위해 고객요구사항, 생산 설비와 자체 기술력을 파악하여 납기를 결정하며 컴파운딩 사양서를 검토한다. 원하는 물성이나 제품을 생산하기 위하여 원부재료를 선정하고 시험 생산된 시제품의 물성을 평가하여 배합조성을 결정하는 배합설계를 수행한다. 컴파운딩방법 선정, 앞공정 선정, 혼합기 최적화를 통해 최적의 컴파운딩 조건을 선정한다. 컴파운딩 사후관리를 위해 수집된 제품평가의 결과를 반영하여 배합설계와 공정설계를 개선하고 기술을 지원한다. 컴파운딩 제품의 품질을 유지하기 위하여 원부재료와 컴파운딩 제품을 검사하고 물성평가와 통계적 품질검사를 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C222","dJobICdNm":"[C222]플라스틱제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007298:1', '{"dJobCd":"K000007298","dJobCdSeq":"1","dJobNm":"플라스틱성형공정관리자","workSum":"플라스틱 성형공정에 대하여 제한된 권한 내에서 금형 및 제품성형 기술 및 현장 실무지식을 사용하여 사양서 검토, 조건설정 등 전반적인 성형공정관리 업무를 수행한다.","doWork":"플라스틱의 압출 제조를 위하여 압출제품 사양서를 검토하고 원가, 공정, 납기를 결정한다. 사출성형 작업을 위해 사출성형 사양서를 검토하여 성형공법을 결정하고 외주관리, 납기 조정 등을 수행한다. 성형품의 특징을 분석하고 성형재료, 성형기, 성형공법을 선정하고 원가를 분석한다. 성형 해석조건을 활용하여 성형조건을 설정하고, 외관품질관리 등을 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C222","dJobICdNm":"[C222]플라스틱제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007368:1', '{"dJobCd":"K000007368","dJobCdSeq":"1","dJobNm":"플라스틱소재연구개발자","workSum":"플라스틱 소재 관련 고분자 제조기술이나 소재의 성질과 특성을 활용하여 비일상적인 문제를 해결하고 소재연구 실험 담당자에게 관련 지식을 전달하고 독립적인 책임과 권한 내에서 업무를 감독한다.","doWork":"플라스틱 소재를 개발하기 위해 플라스틱제품의 시장 구조 및 동향을 분석하고, 이를 토대로 시장을 전망한다. 고객형태를 파악하고 고객으로부터 구매결정 요인 도출 및 고객 불만에 대한 정보를 분석한다. 플라스틱 소재에 대한 기술개발 현황과 미래를 파악하기 위하여 기술문헌·지식재산권·신소재 기술동향을 분석하고 기술을 예측한다. 플라스틱 소재연구개발을 위하여 대상 플라스틱 소재의 개발, 제조, 수입, 유통, 폐기의 전 과정 (Life Cycle)과 관련된 국·내외 법적규제, 정부정책, 이해관계자를 파악한다. 외부환경·내부역량 분석결과와 아이디어 도출 작업으로부터 플라스틱 소재개발 후보군들을 탐색·발굴하고 이들의 우선순위를 평가한다. 플라스틱 소재의 안전성을 확보하기 위하여 플라스틱 소재가 미치는 인체ㆍ환경 안전성을 분석하고 플라스틱 소재의 지속가능성 여부를 분석한다. 플라스틱 소재의 기술적 타당성을 파악하기 위하여 고객요구사항을 반영하는 프로토타입 제품을 설계하고 제조하고 품질특성을 평가한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"화학분석기사, 화공기사, 화공기술사","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C222","dJobICdNm":"[C222]플라스틱제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007369:1', '{"dJobCd":"K000007369","dJobCdSeq":"1","dJobNm":"플라스틱소재연구원","workSum":"플라스틱 소재의 물리/화학적 물성측정 방법(점도, 비열, 열전도 등) 및 현장 실무지식을 사용하여 주어진 권한 내에서 소재연구에 필요한 실험을 수행한다.","doWork":"플라스틱 화학특성분석을 하기 위해 고분자 물질의 표면 구조 및 조성에 대한 분석과 열적특성, 기계적 특성 등의 물성분석과 화합물의 특성을 확인하고 분석하여 데이터를 확인한다. 플라스틱 소재의 기술적 타당성을 파악하기 위하여 고객요구사항을 반영하는 프로토타입 제품을 설계하고 제조하고 품질특성을 평가한다. 플라스틱의 고유한 특성을 사전에 예측하기 위해 (온도, 압력, 전단율과 같은) 물리적 변화에 따른 성형구간, 비열, 열전도도, 비체적, 수축률, 인장강도와 같은 물리적 특성을 검사를 통해서 분석한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"화학분석기사, 화공기사","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C222","dJobICdNm":"[C222]플라스틱제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007370:1', '{"dJobCd":"K000007370","dJobCdSeq":"1","dJobNm":"플라스틱제품개발자","workSum":"플라스틱 제품개발의 기본이론 및 현장 실무지식을 사용하여 공정설계 등 제한된 권한 내에서 제품개발 업무를 수행하고 플라스틱 제품설계 담당자에게 관련 지식을 전달하고 업무를 감독한다.","doWork":"플라스틱성형품 생산을 위하여 일반 중공성형, 사출 중공성형, 일반 진공 성형 및 압축 진공 성형을 활용하여 공정을 설계한다. 정해진 가공실험 계획 및 방법에 따라 가공공정조건을 파악하고, 가공공정실험을 준비하여, 가공 공정실험을 수행한다. 정해진 스케일업 실험 계획 및 방법에 따라 스케일업 운전을 준비·수행하고 스케일업 시료를 분석한다. 정해진 시료 분석실험 계획 및 방법에 따라 분석항목과 분석방법을 파악하고, 분석실험을 준비하여 분석실험을 수행한다. 개발된 제품의 품질수준을 평가하기 위하여 성능, 안정성·안전성, 사용성을 평가한다. 컴퓨터 시뮬레이션 기법으로 가상의 공간에서 제품을 제작하고 실험하여 설계 및 품질 최적화 등을 구현하는 해석기술 업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C222","dJobICdNm":"[C222]플라스틱제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007371:1', '{"dJobCd":"K000007371","dJobCdSeq":"1","dJobNm":"플라스틱제품기획자","workSum":"플라스틱 제품개발의 심화된 전문지식을 활용하여 제품기획 업무를 수행하고 제품개발 및 설계 담당자에게 관련 지식을 전달하고 독립적인 책임과 권한 내에서 업무를 감독한다.","doWork":"플라스틱 제품연구개발을 위하여 실험방향을 설정하고, 실험 일정계획을 수립한다. 가공공정 시뮬레이션과 최적화 실험을 수행하고, 랩 가공공정 개발결과를 종합하며 스케일업 공정개발을 계획하고 스케일업 실험관리 및 실험결과를 종합한다. 제품기준서, 제조지시서, 품질관리기준서를 작성하고 관련부서에 이관한다. 고객 요구사항 분석을 통해 연구개발 목표를 설정하고 연구개발 리스크를 파악하여 연구개발 수행체계를 수립한다. 플라스틱제품 연구과제 관리방법을 확정하고 과제의 중간 및 종료 평가를 수행하며 연구단계별 노하우, 지식재산권, 허가 및 인증을 확보한다. 시료의 분석실험 항목과 분석방법을 검토·확정하고, 분석실험 결과 데이터를 해석한다. 플라스틱 성형공법을 결정하고 외주관리, 납기 조정 등을 수행하며, 성형품의 특징을 분석하고 성형재료, 성형기, 성형공법을 선정하고 원가를 분석한다. 플라스틱성형 해석조건을 활용하여 성형조건 설정, 외관품질관리 등을 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C222","dJobICdNm":"[C222]플라스틱제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007377:1', '{"dJobCd":"K000007377","dJobCdSeq":"1","dJobNm":"플라스틱제품설계자","workSum":"표준화된 업무 범위 내에서 제품개발의 기초이론 및 제한적 현장 실무지식을 사용하여 플라스틱 성형품 설계 업무를 수행하고 업무 수행 중 발생하는 특정한 문제를 해결한다.","doWork":"중공·진공성형 성형품 설계를 위해 성형품 형상을 파악하고 플라스틱 코팅 제품의 목표 물성선정, 제품 모델링, 설계검증, 평가방법 선정을 수행한다. 디자인 아이디어 발상 단계에서 선정된 아이디어를 컴퓨터를 포함한 유사 도구를 이용하여 가상 공간상에 사실적이고 정밀하게 구현하여 디자인 및 구체화 모델링을 한다. 플라스틱 성형품을 모델링하고 성형품의 형상과 특성을 설계한다. 시각화된 아이디어 스케치에 소재, 질감, 작동원리, 양산방법에  대한 구체적인 방안 등을 표현하고 아이디어를 전개하여 플라스틱 제품 디자인 아이디어를 구체화한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C222","dJobICdNm":"[C222]플라스틱제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004733:1', '{"dJobCd":"K000004733","dJobCdSeq":"1","dJobNm":"플라스틱제품연구원","workSum":"플라스틱 원료와 각종 배합제를 이용해 새로운 합성물질을 연구하고 각종 플라스틱 제품의 제조공정을 연구·분석한다.","doWork":"규정된 물리적, 기계적, 내환경적 물성시험을 통한 플라스틱 제품의 비중, 수분 흡수율, 성형수축률, 인장강도, 골국강도, 충격강도, 열변형 온도 등의 시험자료를 분석·연구한다. 제품원료의 비교, 분석과 새로운 형태의 디자인을 통하여 새로운 제품을 개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"플라스틱개발자","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C222","dJobICdNm":"[C222]플라스틱제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004915:1', '{"dJobCd":"K000004915","dJobCdSeq":"1","dJobNm":"하수슬러지연료화연구원","workSum":"하수슬러지 연료화 시 가장 큰 문제점인 함수율 조정 및 탄화도의 균질성을 개선하기 위한 연구를 한다.","doWork":"저발열량 덩어리 형태의 하수슬러지 함수율과 물리적 특성을 분석한다. 다양한 입자크기로 건조된 하수슬러지의 함수율을 측정하여 입자크기, 건조시간, 건조온도에 따른 에너지 효율성을 분석한다. 건조에너지 효율을 향상시키기 위해 가장 적당한 미립화율을 계산한다. 입자상태로 건조된 하수슬러지 탄화도의 균질성을 갖기 위해 건조기와 열풍기의 최적 온도와 시간을 추론한다. 입자상태의 하수슬러지 함수율과 탄화도를 분석하고 에너지효율을 극대화하기 위해 폐기물자원화설계기술자와 설계부분을 협의한다. 최종 생산물인 분말슬러지 열량을 측정하여 적정성을 판정한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005455:1', '{"dJobCd":"K000005455","dJobCdSeq":"1","dJobNm":"합성수지개발연구원","workSum":"각종 합성수지(열경화성, 열가소성)의 원리와 반응법을 연구하고 이를 응용해 다양한 합성수지 제품을 개발하는 데 적용한다.","doWork":"석유, 석탄, 천연가스 같은 화석자원을 원료로 한 저분자량의 화합물로부터 중합, 축합중합, 첨가중합 등에 의해 얻어지는 고분자량의 합성수지를 개발한다. 다관능성 화합물 간의 반응에 의해 저분자 부산물을 이탈시키면서 고분자로 생성하는 중축합반응, 불초화 결합이나 환상구조를 갖는 단량체의 연쇄적 부가반응을 이용한 중합반응 등 여러 가지 방법에 의해 갖가지 분자량을 갖는 중합동족체의 혼합물(합성수지)을 개발한다. 개발된 합성수지를 이용해서 제품에 응용해 적용한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"플라스틱화학연구원","connectJob":"엔지니어링플라스틱개발원","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C222/M701","dJobICdNm":"[C222]플라스틱제품 제조업 / [M701]자연과학 및 공학 연구개발업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003168:1', '{"dJobCd":"K000003168","dJobCdSeq":"1","dJobNm":"해수담수화공정기술연구원","workSum":"해수에서 염분과 불순물을 제거하여 담수화하기 위한 저에너지 고효율 담수화 공정 및 기술을 연구·개발한다.","doWork":"해수나 반염수(기수:Brackish Water)로부터 염분 및 기타 화학물질을 제거하여 담수를 생산하기 위한 신 공정 및 기술을 연구·개발한다. 열기반(다단증발식:Multistage Evaporating Type, 다중효용식:Multiple Effect Distillation 등)방식 담수화 공정에서 발생하는 고온과 에너지 사용량을 줄이기 위한 고효율의 담수화 설계 및 공정을 연구한다. 막기반(역삼투막방식:Reverse Osmosis, 정삼투막방식:Forward Osmosis 등)방식 담수화 공정은 요소기술로 에너지 회수율을 높여 에너지 사용량을 저감하기 위한 에너지회수장치와 펌프의 효율을 향상시키는 기술과 멤브레인 트레인(Membrane Train)의 설계 및 공정 개선을 통한 에너지절감 방안을 연구·개발한다. 담수화 과정에 필요한 에너지를 신재생에너지로 대체하는 기술개발과 막 투과성능을 획기적으로 향상시킴으로써 담수화 공정에서의 에너지 사용량을 절감하기 위해 고효율의 멤브레인(그래핀, 아쿠아포린, 카본나노튜브)을 적용한 공정을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006619:1', '{"dJobCd":"K000006619","dJobCdSeq":"1","dJobNm":"화공기술자","workSum":"화학 분야의 전문적인 지식을 적용하여 에너지·환경부분 등의 관련 자료를 조사·분석·연구·검토하여 중장기 계획 수립 및 정책입안과 기술을 지원한다. 대체에너지 및 제철부산물의 고부가가치화 추진 등을 위한 화공사업 수행을 위한 설비기획, 연구관리 및 기술개발 업무를 수행한다.","doWork":"사업체 내외의 에너지, 환경, 화성 등 화공 관련 설비의 기술정보를 수집·분석한다. 중장기 계획을 수립하고 제반 기술에 관한 관련 법규, 대체에너지 개발, 제도적 개선방안 등의 기술발전 방향을 제시하고 기술정책을 입안한다. 에너지 절약 및 에너지 회수를 위한 신기술을 조사·분석하고, 타당성을 검토하여 보고하며 기술도입 업무 추진 및 관련기술 개발을 위한 연구관리 업무를 수행한다. 열 설비의 조업실적 분석과 에너지수급현황을 종합·분석하여 설비개선방안 도출 및 관리방안을 연구한다. 에너지이용설비의 현황과 장래동향을 분석·검토하고 석탄계, 가스류의 대체에너지 개발 업무를 주관하여 기술적, 경제적 타당성을 종합 판단 후 건의한다. 제철부생가스 및 화성부산물의 고부가가치화를 위한 유효성분의 분리를 위한 기술 및 사업화 추진을 위한 연구관리 업무를 한다. 사내관련 설비의 현장관찰 및 자료조사를 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"화학공학기술자","connectJob":"화공연구원","certLic":"화공기사, 화공기술사","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004667:1', '{"dJobCd":"K000004667","dJobCdSeq":"1","dJobNm":"화장품개발연구원","workSum":"화장품의 원료 및 소재개발, 제형개발, 임상평가, 제품 및 원료분석 등을 통해 화장품을 개발한다.","doWork":"화학공학, 화학, 재료, 미생물학, 생화학 등의 지식을 바탕으로 인체의 청결과 미화에 도움이 되고 피부, 모발의 건강을 증진하기 위한 화장품과 미백, 자외선차단, 주름 개선 등의 효능을 가진 기능성화장품을 연구·개발한다. 화장품 원료로 적합한 소재와 효능물질을 탐색·분석하고 가용화, 유화, 분산을 활용한 제형을 연구한다. 제품별 특성에 맞는 성능과 색조, 향을 개발하고 보관조건에 따른 안정성, 사용성과 사용 화장품의 유효성과 인체에 미칠 수 있는 각종 부작용(자극성, 알레르기성, 감각자극성, 안자극성 등)을 비임상시험, 임상평가 등을 통해 확인한다. 제형에 따라 보관 및 사용의 편리성을 높이거나 포장용기에 맞춰 생산성을 높이기 위해 반제품의 특성을 개선하는 연구를 하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"화장품개발자","connectJob":"기초화장품연구원, 계면활성제연구원, 색조화장품연구원, 피부외용제연구원, 향료화장품연구원","certLic":"맞춤형화장품조제관리사","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C204","dJobICdNm":"[C204]기타 화학제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001914:1', '{"dJobCd":"K000001914","dJobCdSeq":"1","dJobNm":"화장품기술자","workSum":"기초화장품, 색조화장품, 두발화장품을 양산하기 위한 제조기술과 제품생산 공정을 효율적으로 설계·개선한다.","doWork":"화장품을 생산하기 위해 생산규모에 적합한 효율적인 제조방식과 제조기기의 적용 등 공정설계를 수행한다. 위생적인 제조환경과 품질규격에 적합한 화장품 생산을 위해 관련 기술과 기기에 대한 정보를 수집·개발한다. 새로운 화장품 제조방식에 대한 정보를 수집한다. 원·부자재의 보관에서부터 칭량, 혼합, 가용화, 유화, 분산 등 반제품의 제조와 성형, 충진 등 제품의 포장단계에 사용되는 각종 자재와 제조기기의 동향 등을 파악한다. 생산공정의 운전자료, 기기데이터 등을 수집한다. 수집된 데이터를 분석하여 제조공정의 문제점을 도출하고 해결·개선방법을 개발한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"화장품제조기술자, 화장품생산기술자","connectJob":"비누기술자, 화장품공정개발자","certLic":"화공기사, 화공기술사, 품질경영산업기사","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C204","dJobICdNm":"[C204]기타 화학제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003547:1', '{"dJobCd":"K000003547","dJobCdSeq":"1","dJobNm":"화장품미생물시험연구원","workSum":"화장품의 미생물에 의한 변질을 방지하고 사용시 안전성이 우수한 방부효력 체계를 연구·개발한다.","doWork":"화장품의 산화와 변질 방지를 위해 사용되는 보존제(산화방지제, 살균제 등)에 대한 연구를 하고, 여러 종류의 보존제를 조합하여 방부력을 실험한다. 각 보존제에 대한 실험결과를 분석한 후, 보존제의 종류 및 함량을 결정한다. 개발시험 처방과 최종 처방을 비교하고 그 차이점을 분석하여 최종 방부력 시험을 실시하고 시험결과를 분석한 후, 보존제 종류 및 함량을 최종 결정한다. 각종 보존제가 인체에 미치는 유해성을 평가하여 제품의 안전성을 향상시킨다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workEnv":"대기환경미흡|위험내재|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C204","dJobICdNm":"[C204]기타 화학제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005896:1', '{"dJobCd":"K000005896","dJobCdSeq":"1","dJobNm":"화학공정기술자","workSum":"화학제품 생산의 경제적 운영에 필요한 새로운 합성방법, 단위장치기술, 공정기술 등에 관하여 연구·개발한다.","doWork":"화학공정장치 설계 및 공장 기본설계를 연구한다. 운전자료, 장치데이터, 반응자료 등을 수집·정리한다. 각종 반응기, 자동화모델링(Modeling) 및 시뮬레이션(Simulation)등을 통하여 화학공정의 최적화에 관하여 연구한다. 화학제품의 순도 및 성능향상을 위한 단위장치를 설계한다. 유기 및 무기 단량체 제조, 고분자합성, 새로운 촉매공정, 반응공학 및 분리정제 등의 화학공정 개발, 개선에 관하여 연구한다. 폐열을 회수하여 이용하기 위한 기본설계에 관하여 연구한다. 화학공정을 비교·검토하고, 공장을 위하여 공정설명서, 기기사양서 및 설비조작요령 등을 작성한다. 화학공장 및 일반공장의 관련 공정기술에 대한 자문을 한다. 시운전을 하여 공정에 대한 문제점을 해결한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C201/C203","dJobICdNm":"[C201]기초 화학물질 제조업 / [C203]비료, 농약 및 살균, 살충제 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005461:1', '{"dJobCd":"K000005461","dJobCdSeq":"1","dJobNm":"화학분석연구원","workSum":"화학분석 계획을 수립하고, 전 처리와 유기·무기·습식 분석을 수행하며 분석 결과의 해석 및 평가를 한다.","doWork":"화학 관련 산업 제품이나 의약품, 식품, 고분자, 반도체, 신소재 등 광범위한 분야의 화학제품이나 원료에 함유되어 있는 유기 및 무기 화합물들의 화학적 조성 및 성분 함량을 분석한다. 제품 및 원료의 품질을 평가한다. 제품 생산 공정의 이상 유무를 파악한다. 신제품을 연구·개발하는 데 필요한 정보를 제공한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"발전수화학분석연구원","certLic":"화학분석기사","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002711:1', '{"dJobCd":"K000002711","dJobCdSeq":"1","dJobNm":"화학작물보호제연구원","workSum":"화학작물보호제를 제조하기 위하여 농업용 약제의 합성법, 물리적·화학적 성질, 생리적 작용 및 작용 특성에 대해 연구·개발한다.","doWork":"유기중간체의 합성법을 연구하여 농약원제를 개발한다. 제초제, 살충제, 살균제, 식물생장 조절제 등 새로운 저공해 농약 및 중간체를 연구·개발한다. 유기화합물의 합성 및 응용에 관하여 연구한다. 토양화학성에 관한 기초기술 확립(우리나라 산성토양의 pH 완충 특성과 용액의 이온조성 추정모델 개발), 토양과 작물특성에 알맞은 토양비옥도 관리기술 개발, 토양분석방법 개선, 생리적 작용 및 작용 특성에 관한 연구 등을 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"화학농약연구원","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C204/M701","dJobICdNm":"[C204]기타 화학제품 제조업 / [M701]자연과학 및 공학 연구개발업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007339:1', '{"dJobCd":"K000007339","dJobCdSeq":"1","dJobNm":"고무배합설계자","workSum":"고무제품에서 요구되는 특성을 만족시키기 위하여 제한된 권한 내에서 배합설계 기본이론 및 현장 실무지식을 사용하여 고무배합표 작성, 배합설계 업무를 수행하고 고무배합시험원에게 해당 분야의 지식을 전달하고 업무를 감독한다.","doWork":"고객의 요구사항을 검토하여 고무배합 설계를 실시하기 전에 품질·가격·납기·생산능력 등을 종합적으로 분석하여 고무배양 요구사양을 검토한다. 고무제품에 대한 요구사항을 만족시키는 고무배합물의 조성을 설계하여 고무배합표를 작성한다. 최적의 배합비를 도출하기 위해 원료고무 선정, 충전제 선정, 배합약품 선정, 가교제 선정, 함량 최적화 등 고무배합설계 작업을 수행한다. 최적의 고무배합물을 제조하기 위하여 고무배합기를 선정하고, 고무배합기의 CMB·FMB 운전 조건 등 고무배합 조건을 설정한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"1542","dJobECdNm":"[1542]화학공학 시험원","dJobJCd":"2322","dJobJCdNm":"[2322]화학공학 시험원","dJobICd":"C/C221","dJobICdNm":"[C]제조업 / [C221]고무제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007334:1', '{"dJobCd":"K000007334","dJobCdSeq":"1","dJobNm":"고무배합시험원","workSum":"고무제품에서 요구되는 특성을 만족시키기 위하여 업무지시서에 정해진 고무배합물 물성평가, 시험배합, 고무배합 조건설정 등을 수행하고, 업무 시 발생하는 일상적 문제를 해결한다.","doWork":"고무제품에서 요구되는 특성을 만족시키기 위해 배합시험 분야의 기초이론 및 기초적인 실무지식을 사용하여 고무시험 배합 등을 수행한다. 고무배합물의 특성을 평가하기 위하여 배합된 고무를 검사하고 미가교상태와 가교상태의 물성을 평가한다. 최적의 고무배합물을 제조하기 위하여 고무배합기 선정, 고무배합기의 CMBCarbon Master Batch, 천연, 합성고무에 Carbon, Oil, 보강제, 활성제를 배합하여 혼합한  반제품 상태의 배합고무)·FMB(Final Master Batch, CMB상태의 컴파운드에 유황 및 촉진제를 촉입하여 고객이 원료로 사용할 수 있게 만든 배합 고무) 운전 조건을 설정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1542","dJobECdNm":"[1542]화학공학 시험원","dJobJCd":"2322","dJobJCdNm":"[2322]화학공학 시험원","dJobICd":"C/C221","dJobICdNm":"[C]제조업 / [C221]고무제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007335:1', '{"dJobCd":"K000007335","dJobCdSeq":"1","dJobNm":"고무성능시험원","workSum":"고무제품 제조개발 및 제품의 성능을 개선하기 위해 업무 감독자의 일반적인 지시 및 감독을 받아 고무시제품 제작, 시제품 성능평가 업무를 수행하고 업무 시 발생하는 일상적 문제를 해결한다.","doWork":"고무제품 양산을 위한 작업 조건을 설정하며, 성능시험 분야의 기초이론 및 기초적인 성능시험 실무지식을 사용하여 고무 제품의 요구특성에 부합하는 최적의 시제품을 제작한다. 제작된 고무시제품의 성능을 평가하기 위해 시제품 성능평가, 시험설비 점검 등을 수행한다. 압출성형, 사출성형, 캘린더링, 프레스 성형 등의 공법 및 가교방법을 선택하여 고무제품을 생산한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1542","dJobECdNm":"[1542]화학공학 시험원","dJobJCd":"2322","dJobJCdNm":"[2322]화학공학 시험원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002173:1', '{"dJobCd":"K000002173","dJobCdSeq":"1","dJobNm":"고무제품검사원","workSum":"분쇄된 고무화합물 또는 완성된 고무제품의 견본을 각종 시험기기를 사용해 시험하고, 제품표준과 일치하는지 비교·분석한다.","doWork":"견본들을 소량 채취한 후 각종 시험기기(비중계, 경도계, 투영기, 적외선분석기, 화학분석시험장치, 인장-신율시험기 등)를 사용하여 재료의 화학성분을 분석한다. 수분, 회분, 체 잔분 등 수입검사 항목에 따라 시험을 하여 사용 여부를 결정한다. 혼련 공정 중에 고무원료를 채취하여 무늬, 점도, 가황시간, 비중 등을 검사하고 프레스에서 시험편을 가황하여 경도, 인장강도시험, 노화시험 등 각종 시험을 한다. 완제품의 인장강도, 박리, 노화 등을 각종 시험 장비를 사용하여 시험한다. 관리시험에 사용하도록 시험결과를 기록한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"고무시험원","certLic":"화공기사","dJobECd":"1542","dJobECdNm":"[1542]화학공학 시험원","dJobJCd":"2322","dJobJCdNm":"[2322]화학공학 시험원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003479:1', '{"dJobCd":"K000003479","dJobCdSeq":"1","dJobNm":"고무제품시험분석원","workSum":"분쇄된 고무화합물 또는 완성된 고무제품의 견본을 각종 시험기기를 사용해 시험하고, 제품표준과 일치하는지 비교·분석한다.","doWork":"견본들을 소량 채취한 후 각종 시험기기(비중계, 경도계, 투영기, 적외선분석기, 화학분석시험장치, 인장-신율시험기 등)를 사용하여 재료의 화학성분을 분석한다. 수분, 회분, 체 잔분 등 수입검사 항목에 따라 시험을 하여 사용 여부를 결정한다. 혼련 공정 중에 고무원료를 채취하여 무늬, 점도, 가황시간, 비중 등을 검사하고 프레스에서 시험편을 가황하여 경도, 인장강도시험, 노화시험 등 각종 시험을 한다. 완제품의 인장강도, 박리, 노화 등을 각종 시험 장비를 사용하여 시험한다. 관리시험에 사용하도록 시험결과를 기록한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"위험물산업기사","dJobECd":"1542","dJobECdNm":"[1542]화학공학 시험원","dJobJCd":"2322","dJobJCdNm":"[2322]화학공학 시험원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007437:1', '{"dJobCd":"K000007437","dJobCdSeq":"1","dJobNm":"고무품질검사원","workSum":"고무배합 및 제품제조 분야의 기초이론 및 품질검사 실무지식을 사용하여 고무배합물의 물성평가, 배합고무 관리 등 정해진 품질검사 업무를 수행하고 품질검사와 관련하여 문제가 발생했을 경우 감독자의 지시나 작업지시서에 따라 문제를 해결한다.","doWork":"고무배합물의 특성을 평가하기 위하여 배합된 고무를 검사하고 미가교상태와 가교상태의 물성을 평가한다. 품질규격에 따른 품질시험을 실시하고 결과를 정리하여 보고하기 위해 원부재료 검사, 고무배합물 품질검사 등의 작업을 수행하고 결과를 보고한다. 고무제품제조를 위하여 배합고무의 종류별 관리항목을 파악하고, 수입검사를 통하여 재고를 관리한다. 고무제품의 품질을 유지하기 위하여 원부재료와 고무배합물의 품질을 검사하고 품질관리자의 부적합 대책에 따라 관련사항을 개선한다. 고무제품의 품질관리 항목과 규격을 확인하고, 품질관리자의 품질분석 결과 수립된 개선안에 따라 작업을 개선한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"고무시험원","certLic":"화공기사","dJobECd":"1542","dJobECdNm":"[1542]화학공학 시험원","dJobJCd":"2322","dJobJCdNm":"[2322]화학공학 시험원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006134:1', '{"dJobCd":"K000006134","dJobCdSeq":"1","dJobNm":"농약품질관리원","workSum":"농약의 품질을 관리하기 위하여 이화학, 유효성분, 물리성 등의 검사 기준 및 방법을 설정하고 농약의 품질관리를 위한 제반 업무를 수행한다.","doWork":"시중에 유통 중인 농약의 시료를 채취한다. 분석기관에 시료 분석을 의뢰하여 품목고시용 농약의 검사 및 농약원제의 유해성분을 검사한다. 검사 결과, 불합격 농약은 시·도 및 해당 제조업자에 내용을 통보하여 봉인 및 전량 수거 조치를 하고, 불합격 농약 제조 및 수입업자에 대해 행정조치를 하도록 통보한다. 불합격 농약 제조 및 수입업자의 명단도 공개한다. 수출용 농약의 제조능력을 조사하고, 원자재소요량 증명서를 발급한다. 농약의 이화학적 분석방법을 설정하고 고시한다. 농약제조시설을 조사하여 적합 여부를 판정한다. 무등록 제조업체(수입업체), 판매업소를 단속해 시도지사에 통보하고 행정조치 및 고발 등을 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"웅크림|시각|","workEnv":"대기환경미흡|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"농약품질보증원","connectJob":"농약효과검사원","certLic":"농산물품질관리사, 품질경영기사, 품질경영산업기사","dJobECd":"1542","dJobECdNm":"[1542]화학공학 시험원","dJobJCd":"2322","dJobJCdNm":"[2322]화학공학 시험원","dJobICd":"C204/O842","dJobICdNm":"[C204]기타 화학제품 제조업 / [O842]사회 및 산업정책 행정","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004741:1', '{"dJobCd":"K000004741","dJobCdSeq":"1","dJobNm":"도료감리원","workSum":"시방서에 따라 도장작업이 이루어지고 있는지 검사·관리·감독한다.","doWork":"시방서상의 도장사양을 확인한다. 도장감리기기(건조도막 및 습도막 측정기, 표면조도 측정기, 습도측정기, 표면온도측정기, 건조도막 측정기, 핀홀검사기, 이슬점계산척 등)를 사용하여 도장작업장에 입회하여 이상적인 도장사양의 성취를 위해 도장절차의 모든 과정을 점검한다. 도장 부위의 전 처리, 도료의 종류, 도장방식, 도장 진행 및 도장결과 등을 검사하여 공정별(표면처리, 중도, 상도 등) 도장검사성적서를 작성한다. 문제가 발생하면 추가도장을 지시·감독한다. 도장에 필요한 기술적 조언을 수행하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"도장감리사, 도장감리원","dJobECd":"1542","dJobECdNm":"[1542]화학공학 시험원","dJobJCd":"2322","dJobJCdNm":"[2322]화학공학 시험원","dJobICd":"C/F","dJobICdNm":"[C]제조업 / [F]건설업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007809:1', '{"dJobCd":"K000007809","dJobCdSeq":"1","dJobNm":"방사성폐기물핵종분석원","workSum":"원전 및 비원전에서 발생하는 방사성폐기물의 처분을 목표로 폐기물의 특성규명을 위해 핵종분석 관련 제반 업무를 수행한다.","doWork":"방사성폐기물의 특성규명을 위해 분석하고자 하는 핵종들에 대해 전반적인 핵종분석 계획을 수립하되, 핵종분석 품질 보증을 위한 분석절차서 지침에 따라 수립한다. 채취된 대표시료로부터 핵종분석에 적합한 전처리를 시행하며, 핵종별 측정을 위한 적합한 분리과정을 수행한다. 분리된 핵종을 적합한 측정장비를 활용하여 분석을 수행한다. 핵종분석 결과의 신뢰성 확보를 위해 평가를 수행하며, 절차에 따른 적합성을 입증해야 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"대기환경미흡|위험내재|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"방사성동위원소취급자일반면허","dJobECd":"1542","dJobECdNm":"[1542]화학공학 시험원","dJobJCd":"2322","dJobJCdNm":"[2322]화학공학 시험원","dJobICd":"E382","dJobICdNm":"[E382]폐기물 처리업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004696:1', '{"dJobCd":"K000004696","dJobCdSeq":"1","dJobNm":"비료품질관리원","workSum":"비료의 품질관리 기준을 마련한 후 이화학·유해성분 검사 등을 통해 기준에 부합하는지 확인하고 적절한 조치를 취한다.","doWork":"비료의 생산허가, 품목추가, 허가사항 변경으로 품목에 대한 검사성적을 확인하고 결과를 통보한다. 비료의 품질관리를 위하여 비료생산회사의 시설유지 여부 등 실태를 점검한다. 시중에 판매 중인 유통비료의 시료를 채취하여 검사기관에 이화학적 검사를 의뢰하여 규격이나 성분의 적합 여부를 판정한다. 검사 결과 유해성분 초과 및 주성분 미달 등으로 판정되면 행정처분 및 회수·폐기 등 비료관리법에 의거 의법 조치토록 한다. 비료 검사에 관한 방법 및 기준을 설정하고 고시한다. 비료 포장대의 품질검사 방법에 대한 사항을 규정하고 고시한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"웅크림|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"비료시험분석원, 비료품질시험원","connectJob":"비료효과검사원","dJobECd":"1542","dJobECdNm":"[1542]화학공학 시험원","dJobJCd":"2322","dJobJCdNm":"[2322]화학공학 시험원","dJobICd":"O842","dJobICdNm":"[O842]사회 및 산업정책 행정","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001486:1', '{"dJobCd":"K000001486","dJobCdSeq":"1","dJobNm":"석유및석유대체연료검사원","workSum":"석유 및 석유대체연료의 시험분석 및 감정을 통하여 품질향상을 위한 품질검사를 수행하고, 가짜석유제품 여부 등을 확인하는 작업을 수행한다.","doWork":"석유제품(액화석유가스, 휘발유, 등유, 경유, 중유, 윤활유와 이에 준하는 탄화수소유인 항공유, 용제, 아스팔트, 나프타, 윤활기유, 석유중간제품 및 부생연료유), 석유화학제품 및 석유대체연료 등에 대한 물리적 및 화학적 특성을 표준규격에 따라 시험한다. 국내 석유시장 유통질서 확립을 위해 시험결과를 품질기준과 비교하고, 가짜석유제품 여부 등을 판정한다. 문제가 발견되면 관련기관에 통지한다. 품질검사계획을 수립하고 석유사업자(정유사, 대리점, 주유소 등)에 대한 정기검사 또는 수시검사를 실시하여 검사기료를 채취하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"화학분석기사, 위험물산업기사, 화공기사, 가스기사","dJobECd":"1542","dJobECdNm":"[1542]화학공학 시험원","dJobJCd":"2322","dJobJCdNm":"[2322]화학공학 시험원","dJobICd":"C192","dJobICdNm":"[C192]석유 정제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007321:1', '{"dJobCd":"K000007321","dJobCdSeq":"1","dJobNm":"석유화학고객지원기술자","workSum":"제품에 대한 고객의 신뢰성 향상을 지원하기 위하여 전문적 지식이나 기술을 활용하여 고객요구 분석, 불만 대응, 교육 등을 수행한다.","doWork":"석유화학제품별 기술적 고객요구사항을 파악하기 위해 고객 불만사항을 조사하고 분석해서 고객 요구 목표물성을 도출한다. 불만 고객을 응대하기 위해 고객 불만의 원인분석 및 해결방안을 도출하고 고객기술 수준과 문제점 등의 교육수요를 파악하여 기술지도를 한다. 고객교육 계획서를 작성하고 소프트웨어를 활용한 고객교육자료를 작성하고 프리젠테이션을 실시하며, 교육결과에 대한 이력관리 업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"1542","dJobECdNm":"[1542]화학공학 시험원","dJobJCd":"2322","dJobJCdNm":"[2322]화학공학 시험원","dJobICd":"C201","dJobICdNm":"[C201]기초 화학물질 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007322:1', '{"dJobCd":"K000007322","dJobCdSeq":"1","dJobNm":"석유화학물질분석원","workSum":"석유화학제품의 원재료, 자사 및 경쟁사 제품 등의 성분과 특성을 파악하기 위해 다양한 분석 장비 및 기술을 활용하여 무기분석, 유기분석, 광학분석 등의 실험업무를 수행한다.","doWork":"석유화학제품에 대한 실험조건을 검토하며, 시료 전처리 및 분석기기 장비 등에 대한 분석기준, 절차 및 기기분석 교육 등 교육프로그램을 수립하고 수행한다. 분석 장비 실험을 실시하고 관리한다. 습식분석 및 기기분석 교육 등 교육 프로그램을 수립하고 수행한다. 분석 시험장비의 원리 및 운영관리 교육과 데이터 처리 및 분석보고서 작성 교육을 수행한다. 분석기기를 활용하여 무기분석, 유기분석, 유변물성 분석, 고분자 구조분석을 실시한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"석유화학제품시험분석원","certLic":"화학분석기사","dJobECd":"1542","dJobECdNm":"[1542]화학공학 시험원","dJobJCd":"2322","dJobJCdNm":"[2322]화학공학 시험원","dJobICd":"C201","dJobICdNm":"[C201]기초 화학물질 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005917:1', '{"dJobCd":"K000005917","dJobCdSeq":"1","dJobNm":"석유화학제품시험분석원","workSum":"각종 석유화학 제품을 제조하기 위해 원료 및 배합을 시험·분석한다.","doWork":"석유화학제품기술자의 지시에 따라 석유화학제품 및 공정 분석을 위한 계획을 수립한다. 원료를 검사하여 제품제조에 적합한지 판단하고, 공정에서 발생하는 문제를 파악한다. 대단위 단지(Complex)에서는 각 공장들의 공정연계도를 효율적으로 연구하고 관리해 생산의 효율성을 높이기 위한 연구를 한다. 완성된 제품을 시험분석기기를 이용해 시험·분석한다. 제품에 이상이 발견되면 해당 부서에 통보하여 조치를 취하도록 한다. 공정별로 발생될 수 있는 위험요소 및 사고유형을 분석하고 이에 대한 대응책을 마련한다. 환경과 안전 측면에서 최신 공정을 잘 반영하기 위한 연구 등을 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"화공기사, 품질경영산업기사, 위험물산업기사, 화공기술사, 품질경영기사, 품질관리기술사","dJobECd":"1542","dJobECdNm":"[1542]화학공학 시험원","dJobJCd":"2322","dJobJCdNm":"[2322]화학공학 시험원","dJobICd":"C201/C202/C203","dJobICdNm":"[C201]기초 화학물질 제조업 / [C202]합성고무 및 플라스틱 물질 제조업 / [C203]비료, 농약 및 살균, 살충제 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007323:1', '{"dJobCd":"K000007323","dJobCdSeq":"1","dJobNm":"석유화학품질검사원","workSum":"제품품질의 품질 요구조건에 적합한 검사방법과 시험 및 분석기기를 활용하여 원부재료, 공정 및 제품품질을 분석한다.","doWork":"제품분석 표준절차에 따라 제품품질, 중간제품품질, 원부재료품질의 시료에 따라 검사항목을 준비한다. 공정·제품·품질상태를 분석하고 분석데이터를 수집하여 검증한다. 시험·분석기기 관리절차를 확인하고 검정과 교정을 통해 시험·분석기기를 유지·보수한다. 시험·분석기기의 소모품 관리를 위해 시험·분석기기 관리대장을 작성한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1542","dJobECdNm":"[1542]화학공학 시험원","dJobJCd":"2322","dJobJCdNm":"[2322]화학공학 시험원","dJobICd":"C201","dJobICdNm":"[C201]기초 화학물질 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001276:1', '{"dJobCd":"K000001276","dJobCdSeq":"1","dJobNm":"수소연료전지시스템운영관리자","workSum":"수소연료전지 시스템의 평가와 품질검사 및 유지보수를 통해 각 시스템의 정상 작동 및 운전조건의 최적화와 효율을 개선하는 업무를 수행한다.","doWork":"수소연료전지 시스템의 운전조건을 최적화하고 효율을 개선하기 위하여 수소연료전지 시스템 특성에 따라 각 부품의 정상 작동 상태를 확인할 수 있는 시험 계획을 작성하고 시험절차에 따라 운전성, 기본성능, 연비·출력 등 시스템을 평가한다. 제조된 수소연료전지 제품의 상태를 확인하고 관련 법규 및 인증 기준에 근거한 성능 확인을 통해 품질 검수를 한다. 시스템을 사용 적합 상태로 운용하기 위해 수소연료전지의 종류와 용량에 따라 자체적으로 수시점검과 정기점검을 수행하여, 식별된 문제를 해결하고 관련법에 따라 정상적으로 시스템을 유지보수한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"화학분석기사, 위험물 산업기사","dJobECd":"1542","dJobECdNm":"[1542]화학공학 시험원","dJobJCd":"2322","dJobJCdNm":"[2322]화학공학 시험원","dJobICd":"C204","dJobICdNm":"[C204]기타 화학제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001771:1', '{"dJobCd":"K000001771","dJobCdSeq":"1","dJobNm":"원유품질검사원","workSum":"원유 정제를 위하여 도입된 주원료인 원유가 선박으로부터 저장장소인 저유탱크에 저장(Unloading) 되기 전에 원료규격에 적합한지 여부와 물량을 시험·검사한다.","doWork":"원유검사를 위하여 선박, 송유관, 저유탱크 등에서 시험시료를 채취한다. 시약, 초자기구(비커, 플라스크, 시험관 등) 및 시험분석기기 등을 사용하여 순도, 불순물의 함유량 및 침전물에 대한 시험을 실시하고 물량을 확인한다. 실시된 시험결과를 원료규격과 비교하여 시험성적서 및 검사성적서를 발급하며, 저유소에 저장(Unloading) 여부를 결정하기 위한 품질기준적합여부을 제시 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|","workEnv":"대기환경미흡|위험내재|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"검량사, 감정사","dJobECd":"1542","dJobECdNm":"[1542]화학공학 시험원","dJobJCd":"2322","dJobJCdNm":"[2322]화학공학 시험원","dJobICd":"C192","dJobICdNm":"[C192]석유 정제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003002:1', '{"dJobCd":"K000003002","dJobCdSeq":"1","dJobNm":"유기용제분석원","workSum":"폐 유기용제 증류 처리 전후의 농도를 각각 측정하여 증류장치의 효율 및 증류된 유기용제의 순도를 파악한다.","doWork":"수거된 폐 유기용제의 성분분석을 위해서 시료를 채취한다. 가스크로마토그래프(Gas Chromatograph)와 수분측정기(Karl Fisher)를 이용하여 함유되어 있는 화합물을 정성, 정량 분석하고 수분함량을 측정한다. 폐 유기용액이 산성일 경우 완충용액을 가해서 중성화 혹은 약알칼리화시키고 수소이온농도를 측정한다. 최종 정제된 유기용제를 소량 채취하여 분석장비로 정량, 정성 분석하고 불순물의 함량을 측정한다. 증류처리전의 농도와 비교하여 증류시설의 효율 및 불순물의 함량을 계산한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"대기환경기사, 수질환경기사, 대기관리기술사, 대기환경산업기사, 수질관리기술사, 수질환경기사","dJobECd":"1542","dJobECdNm":"[1542]화학공학 시험원","dJobJCd":"2322","dJobJCdNm":"[2322]화학공학 시험원","dJobICd":"E383","dJobICdNm":"[E383]해체, 선별 및 원료 재생업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004687:1', '{"dJobCd":"K000004687","dJobCdSeq":"1","dJobNm":"의약품시험분석원","workSum":"의약품제조를 위한 원료, 반제품, 완제품의 성분, 습도 등을 측정 분석하여 품질을 관리한다.","doWork":"의약품연구원의 지시에 따라 미생물, 효소, 바이러스, 기타 화합물 등 약품의 원료 및 제품의 생물학적, 이화학적 시험과 기준 시험 및 안정성 시험을 수행하기 위한 계획을 수립한다. 원료, 중간물질 및 제조된 약품의 시료를 채취하여 분석기기를 이용하여 분석한다. 품명, 제조번호 또는 관리번호 제조일, 시험지시번호, 지시자 및 지시일, 시험항목 및 시험기준에 따라 시험한다. 시료의 채취자, 채취량, 채취장소, 채취방법 및 주의 사항(무균 여부 등), 채취 시 오염방지 대책을 계획하고 시행한다. 시험 후 분석된 자료를 관련 부서에 통보하여 결과 및 문제점을 제시한다. 분석시험방법 개선 및 사용도구, 계측기기의 검사, 점검 및 보정업무도 수행한다. 주성분 및 완제품 등 보관용 검체를 관리하고, 표준품 및 시약을 관리한다. 위탁시험 또는 위탁제조하는 경우 검체의 송부방법 및 시험결과의 판정방법을 기록하여 보관한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"의약품품질관리원","dJobECd":"1542","dJobECdNm":"[1542]화학공학 시험원","dJobJCd":"2322","dJobJCdNm":"[2322]화학공학 시험원","dJobICd":"C211/C212/C213","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업 / [C212]의약품 제조업 / [C213]의료용품 및 기타 의약 관련제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001600:1', '{"dJobCd":"K000001600","dJobCdSeq":"1","dJobNm":"잉크검사원","workSum":"잉크를 만들기 위한 바니시 공정, 조정 공정에서 각종 측정기기를 이용한 시험(Tack, Flow, 점도, 뒤 묻음, 습수 적성 능력, 유리판 유동성 시험)과 검사를 하고 교정을 지시한다.","doWork":"연육(바니시)공정 또는 조정공정에서 채취된 견본을 받아 제품번호 및 검사일자를 작업일지에 기록하고 견본에 표시한다. 견본을 이용해 측정기(Ink-o-Meter)로 택(Tack)을 측정하고, 유리판으로 소량의 잉크를 누르는 검사를 통해 잉크가 퍼지는 반경을 측정해 잉크의 유동성을 평가한다. 점도계를 사용해 점도를 측정하고, RI 테스터를 사용하여 뒤 묻음(Set-off)이 일어나는 정도를 측정한다. 듀크시험기(Duke Emulsification Tester)를 사용하여 습수 적성 능력을 측정하고, 각도의 유리판에 같은 양의 잉크를 흘러내리게 해 잉크 자체의 유동성을 측정한다. 이러한 다양한 검사와 시험을 통해 견본이 제품규격과 동일한지를 평가한다. 검사결과가 이상이 없으면 잉크조정원에게 합격 통보를 해 포장 공정으로 이송하게 하고, 검사결과가 제품규격과 차이가 발생하면 교정지시서를 작성하여 보낸다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1542","dJobECdNm":"[1542]화학공학 시험원","dJobJCd":"2322","dJobJCdNm":"[2322]화학공학 시험원","dJobICd":"C204","dJobICdNm":"[C204]기타 화학제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007324:1', '{"dJobCd":"K000007324","dJobCdSeq":"1","dJobNm":"정밀화학안전유효성시험원","workSum":"정밀화학제품의 인체에 대한 자극과 독성 최소화 및 기능적 효과를 확보하기 위하여 연구개발 계획에 따라 안전성 및 유효성 실험을 수행한다.","doWork":"정밀화학제품의 안전성·유효성 실험을 위한 시약·기기·장비를 관리한다. 정밀화학제품의 안전성과 유효성 실험 평가를 준비하고 안전성 평가과 유효성 평가 실험을 수행한다. 일반독성시험, 인체첩포시험, 이화학시험, 미생물 시험, 효력 시험을 실시하며 실험결과를 확인하고 정리한다. 인체 자극에 대한 독성 및 안전성과 유효성 평가를 위한 인체적용시험을 수행하고 실험결과 보고서를 작성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1542","dJobECdNm":"[1542]화학공학 시험원","dJobJCd":"2322","dJobJCdNm":"[2322]화학공학 시험원","dJobICd":"C203/C204","dJobICdNm":"[C203]비료, 농약 및 살균, 살충제 제조업 / [C204]기타 화학제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007325:1', '{"dJobCd":"K000007325","dJobCdSeq":"1","dJobNm":"정밀화학품질검사원","workSum":"정밀화학 생산 제품 중 품질 부적합품이 고객에게 유출되는 것을 방지하기 위하여 이화학분석, 기기분석, 생화학분석 등을 통해 품질 부적합품을 선별하는 작업을 수행한다.","doWork":"품질검사에 필요한 시약·기기·장비 및 검사 장비를 유지 관리한다. 작업지시서에 따라 이화학분석 품질검사를 통해 부적합품을 선별한다. 기기분석 품질검사를 하여 부적합품을 선별한다. 생화학분석 품질검사를 통해 부적합품을 선별한다. 품질검사의 종류와 검사 실시에 따른 품질검사에 대한 시험결과를 정리하여 보관한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1542","dJobECdNm":"[1542]화학공학 시험원","dJobJCd":"2322","dJobJCdNm":"[2322]화학공학 시험원","dJobICd":"C203/C204","dJobICdNm":"[C203]비료, 농약 및 살균, 살충제 제조업 / [C204]기타 화학제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006162:1', '{"dJobCd":"K000006162","dJobCdSeq":"1","dJobNm":"타이어시험원","workSum":"가류공정(가황)에서 완성된 타이어가 제품표준에 맞는지 각종 시험, 검사를 하고 합격 여부를 판정한다.","doWork":"호이스트나 장비를 사용하여 제조된 타이어를 평형대(원형판) 위에 올려놓는다. 타이어를 안전하게 고정시키킨 다음 동적. 정적인 상태에서 타이어의 중량 분포를 점검하는 중량 균일성 검사(Uniforty Balance)를 실시한다. 적정 공기압을 투입한 상태에서 회전 시 중량 균일성을 측정하는 정적 밸런스 검사를 실시한다. 지면과 접촉 시 힘의 변화량을 검사하는 균일성 검사를 실시한다. 타이어 내부의 캡 플라이 및 벨트의 균일 상태, 이물질의 혼입 여부를 판단하기 위한 X-레이(PC-R 제외) 검사를 한다. 시험기기를 사용하여 타이어의 내구성, 발열, 소모, 수명 등을 검사한다. 검사에 합격된 타이어는 입고를 위한 공정으로 보내고 합격품 타이어에 식별용 표식을 붙이기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"타이어성능검사원","dJobECd":"1542","dJobECdNm":"[1542]화학공학 시험원","dJobJCd":"2322","dJobJCdNm":"[2322]화학공학 시험원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004197:1', '{"dJobCd":"K000004197","dJobCdSeq":"1","dJobNm":"플라스틱제품시험원","workSum":"플라스틱 제품을 제조하기 위하여 각종 원료를 분석하고, 플라스틱 제품의 재질과 규격 등을 시험·분석한다.","doWork":"플라스틱 완제품의 견본을 채취하여 제품의 비중, 수분 흡수율, 성형수축률, 인장강도, 골국강도, 충격강도, 열 변형 온도 등의 물성을 각종 시험기구를 사용하여 시험·분석한다. 성형 완료된 제품의 외형적 규격을 자, 마이크로미터 등의 측정기기를 사용하여 제품규격과 비교하여 검사한다. 제품 생산능력 향상을 위하여 생산과정을 연구·분석한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1542","dJobECdNm":"[1542]화학공학 시험원","dJobJCd":"2322","dJobJCdNm":"[2322]화학공학 시험원","dJobICd":"C222","dJobICdNm":"[C222]플라스틱제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007310:1', '{"dJobCd":"K000007310","dJobCdSeq":"1","dJobNm":"플라스틱품질검사원","workSum":"플라스틱 품질관리자의 일반적인 지시 및 감독을 받아 품질검사의 기초이론 및 기초적인 현장 실무지식을 사용하여 정해진 품질검사 업무를 수행하고 품질검사와 관련하여 문제가 발생했을 경우 감독자의 지시나 작업지시서에 따라 문제를 해결한다.","doWork":"플라스틱 압출제품 공정관리를 위하여 측정장비를 준비하고, 제품 형상 검사와 공정을 점검하고 검사결과를 보고한다. 성형품의 품질향상을 위하여 금형온도의 적정성 판단, 치수 검사 등 성적서를 기록한다. 중공·진공제품의 품질향상을 위하여 장비 선정, 성형조건 설정, 제품 검사, 작업공정을 점검하고 검사결과를 보고한다. 코팅 제품을 제조하기 위하여 지정된 검사 장비를 사용하여 검사하고 결과를 보고한다. 플라스틱제품의 물성·성분을 정성적·정량적으로 분석하기 위해 시약·기기·장비의 유지·관리, 소모품을 관리하고 관리대장 작성 등을 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"1542","dJobECdNm":"[1542]화학공학 시험원","dJobJCd":"2322","dJobJCdNm":"[2322]화학공학 시험원","dJobICd":"C222","dJobICdNm":"[C222]플라스틱제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004887:1', '{"dJobCd":"K000004887","dJobCdSeq":"1","dJobNm":"화장품시험원","workSum":"기초 화장품, 색조 화장품, 두발 화장품 등의 각종 화장품을 만드는 공정에서 화장품 원료와 견본을 채취해 시험분석하여 품질규격에 적합한지 확인하고 로트별 품질이 유지될 수 있도록 관리한다.","doWork":"가스크로마토그래프, 액체크로마토그래프 적외선측정기기, pH미터기 등 각종 시험검사 기기를 이용해 화장품 원료의 순도, 이화학 성분, 수소이온농도(pH) 등을 측정하여 제품 생산에 문제가 없는지 분석한다. 제조된 제품의 색상과 향 등을 관능검사하고 색상측정기를 이용해 분석한다. 제조과정 중 채취한 시료가 품질기준에 적합한지 검사하고 문제가 발견되면 생산공정과 연구부서에 통지한다. 시험검사 기기를 관리하고 제품의 특성에 맞는 시험분석 방법을 연구·개발하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"화장품시험검사원, 화장품품질시험원","connectJob":"화장품미생물시험원","certLic":"화공기사, 화공기술사","dJobECd":"1542","dJobECdNm":"[1542]화학공학 시험원","dJobJCd":"2322","dJobJCdNm":"[2322]화학공학 시험원","dJobICd":"C204","dJobICdNm":"[C204]기타 화학제품 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002599:1', '{"dJobCd":"K000002599","dJobCdSeq":"1","dJobNm":"화학분석시험원","workSum":"화학공학의 원리와 기술을 응용하여 원료, 중간제품, 최종제품 등이 작업표준과 일치하는지 시험·분석한다.","doWork":"제품생산에 따른 스케치, 도표, 공정도 등을 준비하고 공학적 자료를 수집·기록한다. 각종 실험기구를 사용하여 화학적인 방법으로 원료, 부원료, 반제품, 최종제품을 시험·분석하여 성분, 특성 등을 파악한다. 시험분석한 각종 결과치를 시험분석 작업표준서에 기록·작성하고 생산표준과 일치하는지 비교하고 결과를 통보한다. 화학공정을 관찰하고 수정을 제안한다. 새로운 제품의 개발 또는 개선을 위하여 장치를 제작·설치·수정하는 일에 참여한다. 개발한 장치를 시험하고 표준 운전 과정을 결정한다. 취급 시험장비 및 장치를 점검하고 간단한 수리보수작업을 한다. 실험자료를 수집하고 정리하며 제반 실험연구를 보조한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"화학분석원, 화학실험실시험원","connectJob":"기기분석시험원, 습식분석시험원, 화학견본시험원, 화학공정분석원, 화학제품분석원","certLic":"화학분석기사","dJobECd":"1542","dJobECdNm":"[1542]화학공학 시험원","dJobJCd":"2322","dJobJCdNm":"[2322]화학공학 시험원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005680:1', '{"dJobCd":"K000005680","dJobCdSeq":"1","dJobNm":"환경방사선평가원","workSum":"환경방사선⋅방사능 분석을 통해 원자력 이용시설(원자력발전소, 방사성폐기물 처리장 등) 주변 지역주민에게 노출되는 피폭방사선량을 평가한다.","doWork":"조사계획을 수립하고 원자력이용시설 부지주변 환경방사능 분석을 위해 환경방사능 분석용 시료(공기, 육상, 해상)를 채취하고 전처리하여 분석하고 보고서를 작성한다. 검사를 위한 계측장비를 관리하고 검사의 정확도를 높이기 위해 교차분석을 수행한다. 원자력이용시설 부지주변에 설치된 계측장비를 모니터링하고 지역주민의 피폭선량을 평가한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"분석","workFunc2":"협의","workFunc3":"관련없음","certLic":"화학분석기사, 방사성동위원소취급자일반면허","dJobECd":"1542","dJobECdNm":"[1542]화학공학 시험원","dJobJCd":"2322","dJobJCdNm":"[2322]화학공학 시험원","dJobICd":"E382","dJobICdNm":"[E382]폐기물 처리업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001660:1', '{"dJobCd":"K000001660","dJobCdSeq":"1","dJobNm":"가스설비방식관리원","workSum":"각종 가스생산설비 및 배관의 부식을 방지하기 위하여 부식상태를 검사하고 부식방지 방안을 수립하여 방식기능을 향상한다.","doWork":"가스생산설비 및 배관의 부식상태를 점검하고 부식의 원인을 분석한다. 부식된 설비와 배관의 부식정도를 부식관리기준과 비교·분석한다. 점검내용을 관련 부서에 통보하여 수리하거나 교체하도록 한다. 설비의 방식 관련 자료를 수집·검토하여 방식방안을 수립한다. 각종 설비의 보수지침서를 검토·보완하여 가스설비의 성능극대화방안을 수립한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"표면처리산업기사, 표면처리기술사, 금속재료산업기사, 금속재료기사, 금속재료기술사, 금속재료가공기술사","dJobECd":"1521","dJobECdNm":"[1521]금속·재료공학 기술자 및 연구원","dJobJCd":"2331","dJobJCdNm":"[2331]금속·재료 공학 연구원 및 기술자","dJobICd":"D352","dJobICdNm":"[D352]연료용 가스 제조 및 배관공급업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002844:1', '{"dJobCd":"K000002844","dJobCdSeq":"1","dJobNm":"가스설비방식연구원","workSum":"가스를 생산·공급하기 위한 각종 설비 및 배관재료의 물성, 부식방지를 위한 재료와 방법을 연구·개발한다.","doWork":"가스를 생산·공급하는 설비 및 배관의 부식원인을 규명하고 예방하기 위한 방안을 연구한다. 각종 설비와 배관재료에 대한 물성 및 용접 특성을 연구하여 부식을 막기 위한 방법을 연구한다. 방식기술을 개발하기 위하여 금속의 특성, 표면코팅방법 등에 대한 연구를 한다. 각종 설비와 배관의 물성 및 부식에 대한 진단을 위하여 비파괴기술에 대한 연구를 한다. 설비와 배관을 구성하는 재료의 성능개선을 위한 연구를 한다. 부식속도를 측정하여 저장탱크 및 생산설비, 배관의 건전성과 수명평가기술을 연구·개발한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workEnv":"대기환경미흡|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"금속재료산업기사, 금속재료기사, 금속재료기술사, 금속재료가공기술사","dJobECd":"1521","dJobECdNm":"[1521]금속·재료공학 기술자 및 연구원","dJobJCd":"2331","dJobJCdNm":"[2331]금속·재료 공학 연구원 및 기술자","dJobICd":"D352","dJobICdNm":"[D352]연료용 가스 제조 및 배관공급업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;