INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002397:1', '{"dJobCd":"K000002397","dJobCdSeq":"1","dJobNm":"평생교육사","workSum":"평생교육프로그램을 기획·개발·운영·평가하며 관련 기관과 네트워킹을 형성하고 학습자의 상담, 교육컨설팅 등을 수행한다.","doWork":"사회와 조직의 요구를 분석하여 교육프로그램을 기획한다. 프로그램 개발의 타당성을 검토한다. 전문가들과 협의하여 프로그램 내용과 일정 등을 결정하는 등 프로그램을 설계하고 개발한다. 강사섭외, 시설 및 매체확보 등 프로그램을 운영하고 교육성과를 분석한다. 유사 및 관련 기관과 네트워킹을 형성하고 행사를 함께 기획하고 진행한다. 교수자료를 수집하고 개발한다. 학습자를 진단하고 정보를 제공하는 등 학습 상담을 한다. 교육문제를 진단하고 해결 방안을 제시하는 등 교육 컨설팅을 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"사회교육전문요원, 평생프로그램간사, 평생교육매니저","certLic":"평생교육사","dJobECd":"2151","dJobECdNm":"[2151]장학관·연구관 및 교육 전문가","dJobJCd":"2591","dJobJCdNm":"[2591]장학관·연구관 및 교육 관련 전문가","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003075:1', '{"dJobCd":"K000003075","dJobCdSeq":"1","dJobNm":"대학조교","workSum":"대학에서 교수의 지도를 받아 학술연구 및 학사업무를 보조한다.","doWork":"대학의 학과사무실 또는 연구실에 배치되어 교수의 지도하에 실험 및 강의를 위한 학술연구 활동을 보조한다. 교수를 도와서 학생들의 시험을 감독한다. 학사업무와 학생활동을 보조한다. 대형 강의장에 좌석표를 작성하고, 수업기자재를 설치하며 출석을 확인한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"사무조교, 실습조교, 연구조교, 교육조교","dJobECd":"2152","dJobECdNm":"[2152]대학 교육 조교(연구 조교(RA) 포함)","dJobJCd":"2592","dJobJCdNm":"[2592]대학 교육 조교","dJobICd":"P853","dJobICdNm":"[P853]고등 교육기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003768:1', '{"dJobCd":"K000003768","dJobCdSeq":"1","dJobNm":"이공계연구보조원","workSum":"이공계 분야의 연구소에서 각종 연구를 보조한다.","doWork":"이공계열(물리, 화학, 생물, 전기, 전자, 기계, 금속, 건축, 도시계획, 토목, 산업공학, 농업생명과학 등) 분야의 실험실, 제품개발실, 대학 연구실 등에서 연구원의 지시에 따라 각종 계측기, 시험장비, 시약, 컴퓨터 프로그램, 시험도구, 연구데이터 등을 사용하여 연구수행을 보조한다. 연구자료 및 데이터를 수집하고 정리한다. 논문 작성, 보고서 작성, 제품개발 등 연구 진행과정에서 수반되는 각종 업무를 보조한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"자연과학연구보조","dJobECd":"2152","dJobECdNm":"[2152]대학 교육 조교(연구 조교(RA) 포함)","dJobJCd":"2592","dJobJCdNm":"[2592]대학 교육 조교","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002621:1', '{"dJobCd":"K000002621","dJobCdSeq":"1","dJobNm":"인문사회계연구보조원","workSum":"인문사회계 분야의 연구소에서 각종 연구를 보조한다.","doWork":"인문사회계열(국문학, 영문학, 사학, 철학, 정치학, 경제학, 사회학 등) 분야의 연구실, 리서치회사, 마케팅회사, 관공서 연구기관, 대학 등에서 그 분야 연구원의 지시에 따라 정성적, 정량적 연구기법을 사용하여 각종 연구수행을 보조한다. 연구자료 및 데이터를 수집하고 정리한다. 논문 작성, 보고서 작성, 발표, 도서발간 등 연구 진행과정에서 수반되는 각종 업무를 보조한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"관련없음","similarNm":"사회과학연구보조","dJobECd":"2152","dJobECdNm":"[2152]대학 교육 조교(연구 조교(RA) 포함)","dJobJCd":"2592","dJobJCdNm":"[2592]대학 교육 조교","dJobICd":"M702","dJobICdNm":"[M702]인문 및 사회과학 연구개발업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007573:1', '{"dJobCd":"K000007573","dJobCdSeq":"1","dJobNm":"검사","workSum":"범죄를 수사하고 공소를 제기하며 그 유지에 필요한 사항에 관한 일을 수행한다.","doWork":"범죄 사건을 수사하고, 범죄 여부를 판단하기 위해 피의자를 법원에 기소하는 일을 담당한다. 형사 사건의 경우 사법 경찰관 등을 지휘하여 사건의 제반 사항을 조사하고, 또 사건 관련 증거를 수집하고 이를 분석하며 사건에 적용할 규정이나 기타 법적 문제를 검토한 후 공소를 제기한다. 사건의 범죄 여부를 판단하기 위해 법원에 피의자를 기소하며, 사건에 적용할 법적 규정이나 기타 법적 문제를 검토한다. 민사사건에 관하여, 금치산·한정치산 선고의 신청권, 부재자의 재산관리 관여권, 회사의 해산명령 청구권, 외국회사 지점의 폐쇄명령 청구권 등을 행사하기도 한다. 해당 사건에 관한 타당한 결정이나 방침, 규정 및 기타 법적 문제를 검토한 후 공소를 제기하고 피고를 기소 또는 방면하기 위한 증거를 제시한다. 법원에 정당한 법령의 적용을 청구한다. 국가를 당사자 또는 참가인으로 하는 소송을 수행하거나 행정소송의 수행을 지휘·감독한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","certLic":"변호사","dJobECd":"2211","dJobECdNm":"[2211]판사 및 검사","dJobJCd":"2611","dJobJCdNm":"[2611]판사 및 검사","dJobICd":"O844","dJobICdNm":"[O844]사법 및 공공질서 행정","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007527:1', '{"dJobCd":"K000007527","dJobCdSeq":"1","dJobNm":"판사","workSum":"재판을 진행하며, 변호사와 검사의 논쟁, 변호사 및 증인의 진술, 사건증거 등 재판에 관련된 자료들을 검토하고 법률에 근거해 판결을 내린다.","doWork":"재판과 관련하여 공판기일 진행과 증인의 채택, 증거의 채택방식 및 기타 재판절차를 정하는 일을 한다. 재판이 진행될 때는 변호사와 검사의 논쟁을 경청하고 증인의 진술과 법정에 제출된 증거를 검토하고 추론한다. 민사나 형사에서 소송이 제기되면 법률을 적용하여 원고와 피고 사이의 민사 분쟁을 해결하거나 기소된 형사사건의 범죄 여부를 판단한다. 검사의 요청이 있을 때에는 적합성 여부를 판단하여 영장을 발부하기도 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"조정","workFunc2":"자문","workFunc3":"관련없음","similarNm":"법관","connectJob":"재판연구원","certLic":"변호사","dJobECd":"2211","dJobECdNm":"[2211]판사 및 검사","dJobJCd":"2611","dJobJCdNm":"[2611]판사 및 검사","dJobICd":"O844","dJobICdNm":"[O844]사법 및 공공질서 행정","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005405:1', '{"dJobCd":"K000005405","dJobCdSeq":"1","dJobNm":"공증인","workSum":"당사자 혹은 기타 관계인의 촉탁에 의하여 법률행위와 기타 사건에 대한 공정증서를 작성, 사서증서에 대한 인증, 확정일자의 확인, 기타 정관에 대한 인증 등의 업무를 상담하고 처리한다.","doWork":"당사자 혹은 기타 관계인으로부터 법률행위에 관하여 공증을 촉탁받으면 위탁받은 사실내용을 관계인에게 설명을 듣고 관계서류를 심사·검토하며 잘못이 있는가를 확인한다. 확인내용에 대한 인증을 위하여 소정양식의 공정증서를 작성하고 사서증서·정관 등에 인증한다. 증서작성·인증을 한 경우에는 각각의 원부에 기재한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","certLic":"변호사","dJobECd":"2212","dJobECdNm":"[2212]변호사","dJobJCd":"2612","dJobJCdNm":"[2612]변호사","dJobICd":"M711","dJobICdNm":"[M711]법무관련 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007482:1', '{"dJobCd":"K000007482","dJobCdSeq":"1","dJobNm":"변호사","workSum":"당사자 혹은 기타 관계인이나 단체의 의뢰에 의하여 소송에 관한 행위 및 행정처분의 청구에 관한 대리행위와 기타 일반법률 업무를 수행한다.","doWork":"사건 당사자 및 대리인과 상담한다. 상담 결과에 따라 사건의 종류(민사소송사건, 조정사건, 비송사건, 행정소송사건 등)를 판단하고 수임한다. 사건 당사자의 대리인으로 소·심판 등의 제기와 취하, 조정, 이의 등을 신청하고 등기나 기타신청, 화해 등의 절차를 수행한다. 형사소송 시에는 피고인 또는 피의자 등과의 접견, 관계서류 또는 증거물의 열람 및 등사, 구속취소 또는 보석과 증거보존의 청구, 구속영장실질심사 및 구속적부심의 청구, 피의자·피고인의 변호인으로서 법정에서 당사자를 대리하여 변론 등의 업무를 수행한다. 변론에 필요한 자료를 수집하고 정리한다. 심급에 따라 항소·상고 등의 절차를 진행하며, 각종 법률에 관하여 상담한다. 이 외에도 증서에 관한 인증업무를 담당하는 공증업무도 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"사내변호사","connectJob":"민사변호사, 형사변호사, 가사변호사, 행정변호사, 국제통상전문변호사, 재판연구원","certLic":"변호사","dJobECd":"2212","dJobECdNm":"[2212]변호사","dJobJCd":"2612","dJobJCdNm":"[2612]변호사","dJobICd":"M711","dJobICdNm":"[M711]법무관련 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002025:1', '{"dJobCd":"K000002025","dJobCdSeq":"1","dJobNm":"법무사","workSum":"관계법령에 따라 법원, 검찰청 등의 기관에 제출할 서류와 법무와 관련한 서류를 의뢰인을 대신하여 작성하고 신청한다.","doWork":"상담이나 문서의 접수를 통해서 의뢰사항을 파악한다. 관련 법령에 따라 법원과 검찰에 제출하는 서류와 등기 및 등록에 필요한 서류를 작성하고 제출한다. 등기 및 공탁사건의 신청 및 수속을 대리한다. 경매 및 공매사건에서 재산취득에 관한 매수신청 및 입찰신청을 대리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"자문","workFunc3":"관련없음","certLic":"법무사","dJobECd":"2213","dJobECdNm":"[2213]법무사 및 집행관","dJobJCd":"2613","dJobJCdNm":"[2613]법무사 및 집행관","dJobICd":"M711","dJobICdNm":"[M711]법무관련 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005635:1', '{"dJobCd":"K000005635","dJobCdSeq":"1","dJobNm":"집행관","workSum":"지방법원 및 지원에서 서류와 물품의 송달 등 재판 집행 및 몰수물품의 회수 또는 매각, 영장 집행 등의 사무를 담당한다.","doWork":"법원이나 검찰청의 명령에 따라 돈을 빌리고도 갚지 못한 사람들의 재산을 회수하거나, 집과 토지 등의 부동산을 경매에 붙여 돈으로 바꿔 돈을 빌려준 사람에게 돌려주는 일을 한다. 부동산 외에도 돈을 갚아야 할 사람들 소유의 냉장고, 텔레비전, 가구 등의 가재도구와 사무실의 가구나 물건 등을 가압류하여 마음대로 처분하지 못하도록 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","similarNm":"집달관","dJobECd":"2213","dJobECdNm":"[2213]법무사 및 집행관","dJobJCd":"2613","dJobJCdNm":"[2613]법무사 및 집행관","dJobICd":"O844","dJobICdNm":"[O844]사법 및 공공질서 행정","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007470:1', '{"dJobCd":"K000007470","dJobCdSeq":"1","dJobNm":"변리사","workSum":"새로운 기술, 발명, 디자인, 상표 등의 권리취득을 위한 상담과 지원을 해주고, 특허의 취득 및 권리보호를 위한 업무를 대행한다.","doWork":"관련 법(실용신안법, 의장법, 상표법, 발명보호법 등)에 의거하여 특허소유권에 관련한 업무를 대행한다. 특허취득과 관련한 기술내용을 청취하고 유사 특허에 대해 파악한다. 의뢰자와의 상담을 통하여 자료를 작성한다. 출원서의 작성 및 접수를 통한 특허 취득업무를 대행한다. 타인의 의한 권리 침해나 특허발급 거부 등의 특허분쟁에 대한 소송을 대리한다. 각국의 특허 독립원칙에 따라 관련 특허에 대한 국제 업무를 대행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"특허대리인","certLic":"변리사","dJobECd":"2214","dJobECdNm":"[2214]변리사","dJobJCd":"2614","dJobJCdNm":"[2614]변리사","dJobICd":"M711","dJobICdNm":"[M711]법무관련 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002363:1', '{"dJobCd":"K000002363","dJobCdSeq":"1","dJobNm":"외국변호사","workSum":"미국, 영국 등 외국법의 전문지식을 토대로 국내기업 등을 대상으로 특허 및 계약체결 등을 법률적으로 조언하고 소송발생 시 대응방안을 모색하는 등 서비스를 제공한다.","doWork":"국제 거래와 글로벌 사업 관련 계약을 검토하고 협상을 지원한다. 프로젝트성 사업 및 글로벌 투자 사업에 대한 법무지원을 한다. 법률적 제도적 이슈 및 중요의사 결정 사항 등에 대해 법률적 검토를 한다. 국제거래 또는 해외사업 관련 분쟁에 대해 대응업무를 한다. 기업 내 계약시스템을 관리하거나 외부 법률 용역계약을 관리한다. 미국, 영국, 베트남 등 원자격국의 법령에 대해 자문한다. 원자격국인 당사자인 조약 및 일반적으로 승인된 국제관습법에 대해 자문한다. 국재중재 사건을 대리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"조정","workFunc2":"자문","workFunc3":"관련없음","connectJob":"외국자문법사, 미국변호사, 영국변호사 등","certLic":"미국변호사, 영국변호사","dJobECd":"2219","dJobECdNm":"[2219]기타 법률 전문가","dJobJCd":"2619","dJobJCdNm":"[2619]기타 법률 전문가","dJobICd":"M711","dJobICdNm":"[M711]법무관련 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004782:1', '{"dJobCd":"K000004782","dJobCdSeq":"1","dJobNm":"가정법원조사관","workSum":"가사소송법, 입양특례법 및 가정폭력범죄의 처벌 등에 관한 특례법에 따른 가사사건, 소년보호사건 및 가정보호사건의 조사업무를 수행한다.","doWork":"가사사건(이혼, 위자료 및 재산분할, 친권자 지정 및 변경, 입양, 성년후견 등)에서 당사자의 성격, 학력, 경력, 생활상태, 재산상태, 성격, 건강 및 가정환경, 심신상태, 가족관계 및 역동 등 사안의 분쟁의 원인을 조사한다. 소년법에 의하여 반사회성이 있는 소년에 대한 환경조정과 품행교정을 위한 보호처분의 기초가 되는 소년의 성장과정, 환경, 성격, 정신상태, 비행동기 등 제반사정 등을 조사한다. 가정폭력사건이나 아동학대 사건에서 가정의 평화와 안정을 회복하고, 피해자와 가족구성원의 인권을 보호하기 위하여 행위자 및 피해자 등의 성행, 경력, 가정상황, 폭력범죄의 동기와 원인 및 실태 등을 조사한다. 직접 면접하여 조사하거나 심리검사 도구를 활용하여 심리평가하거나 집이나 관련기관에 방문하여 조사한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"협의","workFunc3":"관련없음","similarNm":"가사조사관, 소년보호조사관, 가정보호조사관, 아동보호조사관","certLic":"정신건강임상심리사, 변호사, 감정평가사, 공인회계사, 법무사, 공인중개사, 사회복지사","dJobECd":"0210","dJobECdNm":"[0210]정부·공공행정 전문가","dJobJCd":"2620","dJobJCdNm":"[2620]정부 및 공공 행정 전문가","dJobICd":"O841","dJobICdNm":"[O841]입법 및 일반 정부 행정","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004654:1', '{"dJobCd":"K000004654","dJobCdSeq":"1","dJobNm":"공공갈등조정사","workSum":"지자체의 정책이나 지역사회, 시·군 등 지자체 간 현안갈등 조정 및 중재, 관리업무를 한다.","doWork":"갈등이 발생한 정책과 사업을 심의하고 관리가 필요한 사업 및 정책을 대상으로 갈등예방과 해결을 시도한다. 갈등예방이 있을 경우 갈등영향분석시스템을 통해 갈등이 발생한 현장에서 이해관계자를 대상으로 이해관심사를 파악한다. 이를 토대로 갈등을 분석하고 드러나지 않는 이해관계자의 분포도를 파악하여 갈등예방 및 갈등발생 시 전략적 방향을 제시한다. 정책의 추진가능성을 판단하여 불필요한 정책수행비용을 사전에 예방한다. 의료, 환경, 소비자 등 분야별 분쟁조정위원회에서 조정에 대한 동의, 사전준비 등 조정과정을 진행하거나 대행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"공공갈등전문가, 갈등관리전문가","dJobECd":"0210","dJobECdNm":"[0210]정부·공공행정 전문가","dJobJCd":"2620","dJobJCdNm":"[2620]정부 및 공공 행정 전문가","dJobICd":"O841","dJobICdNm":"[O841]입법 및 일반 정부 행정","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003680:1', '{"dJobCd":"K000003680","dJobCdSeq":"1","dJobNm":"공공행정전문가(일반)","workSum":"정부산하단체 및 공공기관에서 공공행정업무와 관련된 의사결정을 하고 실무적인 책임을 진다.","doWork":"공공행정과 관련하여 경영목표 달성을 위한 계획을 수립하고, 효율적인 자원 배분을 통해 경영진의 의사결정 등을 지원한다. 소속기관 및 부서에서 경영기획, 홍보, 정부 위임사무의 집행업무를 수행한다. 담당업무에 따라 총무, 인사, 구매 및 회계, 재정, 세무, 보건, 교육, 고용, 경영기획, 홍보, 판매관리, 생산관리 등의 업무를 수행한다. 정부부처의 관계자와 업무를 협의하고 논의한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0210","dJobECdNm":"[0210]정부·공공행정 전문가","dJobJCd":"2620","dJobJCdNm":"[2620]정부 및 공공 행정 전문가","dJobICd":"O841","dJobICdNm":"[O841]입법 및 일반 정부 행정","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003124:1', '{"dJobCd":"K000003124","dJobCdSeq":"1","dJobNm":"공중보건전문가","workSum":"지역사회, 학교, 기타 시설 및 단체 등의 보건위생계획 및 환경정화계획을 수립하고 집행한다.","doWork":"지역사회, 학교, 기타 시설 및 단체 등의 보건위생계획을 수립·실시한다. 음식물의 가공 및 제공, 고형폐기물의 수집 및 처분, 오물처리, 수도관 부설 등에 관련된 건강 및 위생기준을 설정한다. 오락장소, 병원, 기타시설의 소음, 환기, 공기 및 방사선오염 등에 관한 규정을 수립·집행한다. 정부, 지역사회, 산업체, 기타 시설 및 단체 등과 협의하여 환경정화를 위한 계획을 수립·발전시킨다. 유행성질병에 관한 조사 및 예방업무를 관련 기관과 협조하여 수행한다. 환경에 관한 법률 및 규정의 보완, 발전을 위하여 민간단체와 정부기관에 자문을 제공한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"공중위생전문가","dJobECd":"0210","dJobECdNm":"[0210]정부·공공행정 전문가","dJobJCd":"2620","dJobJCdNm":"[2620]정부 및 공공 행정 전문가","dJobICd":"O842","dJobICdNm":"[O842]사회 및 산업정책 행정","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004829:1', '{"dJobCd":"K000004829","dJobCdSeq":"1","dJobNm":"녹색인증제도기획원","workSum":"녹색인증제도의 수요조사, 인증대상, 문제점 파악 및 개선 등을 통해 녹색인증제도의 운영을 기획한다.","doWork":"녹색인증제도의 활성화를 위해 인증수요를 파악한다. 기술과 환경의 변화 동향을 조사하고 관련 분야의 전문가에게 자문을 구하여 인증분야를 제·개정한다. 인증제도 운영상의 문제점에 대한 개선방안을 기획한다. 관련 매체나 전시회 등에 참여하여 대외홍보활동을 한다. 녹색인증제도 관련 교육을 진행하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0210","dJobECdNm":"[0210]정부·공공행정 전문가","dJobJCd":"2620","dJobJCdNm":"[2620]정부 및 공공 행정 전문가","dJobICd":"O842","dJobICdNm":"[O842]사회 및 산업정책 행정","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007195:1', '{"dJobCd":"K000007195","dJobCdSeq":"1","dJobNm":"비상계획관","workSum":"국가에서 지정한 기업 및 기관에서 국가의 비상사태를 대비하여 동원지침에 따라 계획을 수립하고 조정 및 실시한다.","doWork":"국가에 전쟁이나 긴급사태가 발생할 상황에 대비해 시설방호, 중요문건이나 시스템 등의 보안업무, 비상대비업무를 계획하고 지도한다. 비상사태에 대비한 교육 및 훈련을 계획·수립하고, 일정에 따라 훈련을 실시한다. 그 밖에 직장예비군 및 민방위 관리를 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0210","dJobECdNm":"[0210]정부·공공행정 전문가","dJobJCd":"2620","dJobJCdNm":"[2620]정부 및 공공 행정 전문가","dJobICd":"O843","dJobICdNm":"[O843]외무 및 국방 행정","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007403:1', '{"dJobCd":"K000007403","dJobCdSeq":"1","dJobNm":"외교관","workSum":"본국을 대표하여 외국에 파견되어 각종 외교업무를 수행한다.","doWork":"부임한 나라의 정치적 상황, 경제통상정보, 생활정보 등을 수집, 분석하여 본국의 정부나 기업에 알린다. 본국을 대신해 본국의 이익과 정책을 옹호하는 교섭을 한다. 본국의 전통 및 문화를 알리는 문화 홍보활동을 한다. 자국을 대신해 주재국에게 외교적 문제에 대해 항의하고, 자국의 정책을 소개한다. 부임한 나라의 자국민을 대상으로 출생 및 혼인신고, 여권 발급과 연장, 각종 증명서 발급 등의 업무를 수행한다. 자국민이 위험에 처해있을 때 그들을 보호하기 위한 제반 활동을 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","connectJob":"대사, 총영사, 공사, 영사","dJobECd":"0210","dJobECdNm":"[0210]정부·공공행정 전문가","dJobJCd":"2620","dJobJCdNm":"[2620]정부 및 공공 행정 전문가","dJobICd":"O843","dJobICdNm":"[O843]외무 및 국방 행정","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006554:1', '{"dJobCd":"K000006554","dJobCdSeq":"1","dJobNm":"운항자격심사관","workSum":"항공기 조종사의 운항자격을 심사한다.","doWork":"운항자격심사와 관련하여 항공운송사업자(항공훈련기관 포함)별로 년/월간 심사계획을 수립한다. (고정익항공기, 회전익항공기) 조종사의 채용, 초기, 승격, 전환 등 운항자격 인정심사, 정기심사 및 수시심사를 수행한다. 항공사 및 항공훈련기관 소속 위촉심사관에 대한 위촉심사, 정기심사 및 수시심사를 수행한다. 모의비행장치 훈련프로파일(Profile)을 점검한다. 지식 및 기량심사 후 피심사자에게 심사 결과에 대하여 설명(디브리핑)하다. 심사업무 수행내용 및 결과를 업무관리 시스템에 등재한다. 개인 훈련현황을 개인훈련기록부에 기록 유지한다. 항공안전 관련 법령, 기준 등의 연구개발 및 제도 개선업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"고정익항공기 운항자격심사관, 회전익항공기 운항자격심사관","certLic":"운송용조종사","dJobECd":"0210","dJobECdNm":"[0210]정부·공공행정 전문가","dJobJCd":"2620","dJobJCdNm":"[2620]정부 및 공공 행정 전문가","dJobICd":"H511/H512","dJobICdNm":"[H511]항공 여객 운송업 / [H512]항공 화물 운송업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001455:1', '{"dJobCd":"K000001455","dJobCdSeq":"1","dJobNm":"정부행정전문가(일반)","workSum":"중앙 및 지방행정기관의 부서에서 정부 업무와 관련된 정책을 기획하고 의사결정을 하며 실무적인 책임을 진다.","doWork":"고위공무원으로부터 위임받은 직무를 수행하며 예하직원을 운용한다. 총무, 인사, 구매 및 회계 관련 업무를 기획한다. 소속기관 및 부서에서 경영기획, 홍보, 정부 위임사무의 집행업무를 수행한다. 담당업무에 따라 총무, 인사, 구매 및 회계, 재정, 세무, 보건, 교육, 고용, 경영기획, 홍보, 판매관리, 생산관리 등의 업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"정부정책기획전문가, 공공행정기획전문가, 정부집행행정전문가, 정부정책전문가","connectJob":"정책서기관, 행정서기관, 국회의원보좌관, 국회의원비서관, 의회의원비서관, 4급공무원, 5급공무원, 청와대비서관, 외교관 등","dJobECd":"0210","dJobECdNm":"[0210]정부·공공행정 전문가","dJobJCd":"2620","dJobJCdNm":"[2620]정부 및 공공 행정 전문가","dJobICd":"O841","dJobICdNm":"[O841]입법 및 일반 정부 행정","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006555:1', '{"dJobCd":"K000006555","dJobCdSeq":"1","dJobNm":"항공안전감독관","workSum":"항공기 감항 또는 운항분야의 인가·증명·승인 또는 항공안전저해요소를 제거하는 안전활동을 수행한다.","doWork":"점검대상, 점검분야 및 점검항목, 점검기간 및 장소 등 연간 및 월간점검계획을 수립한다. 업무매뉴얼의 점검표에 따라 상시점검을 수행한다. 항공사 운항규정 및 정비규정 등의 인가, 신고, 승인사항에 대한 기술 검토를 한다. 반복 지적되는 사항으로 체계적이고 심도있는 점검이 필요한 경우 중점관리항목으로 선정하여 안전점검을 실시한다. 항공사고나 항공안전이 우려되는 경우 등에는 집중점검 및 잠재위험점검을 실시한다. 점검계획을 사업자에게 통지하고 점검을 수행한다. 점검결과 항공안전저해요소를 발견한 경우 사업자의 장이나 관계직원에게 시정지시 및 개선권고서를 발부하고 국토교통부장관 또는 지방항공청장에게 보고한다. 시정지시 및 개선권고서 발부 현황, 발부받은 대상자의 조치결과 확인, 사용한 점검표를 통합항공안전정보시스템에 입력한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"책임운항감독관(POI), 책임감항감독관(PMI)","certLic":"운송용조종사","dJobECd":"0210","dJobECdNm":"[0210]정부·공공행정 전문가","dJobJCd":"2620","dJobJCdNm":"[2620]정부 및 공공 행정 전문가","dJobICd":"H529/O842","dJobICdNm":"[H529]기타 운송관련 서비스업 / [O842]사회 및 산업정책 행정","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006556:1', '{"dJobCd":"K000006556","dJobCdSeq":"1","dJobNm":"항만통제관","workSum":"입항하는 외국선박 가운데 고위험 선박을 식별하고 점검하며 점검 결과, 안전과 환경기준에 미달되는 선박에 대하여 결함사항 시정을 요구한다.","doWork":"항만 및 계류시설에 있는 외국적 선박에 대하여 자국 연안에서의 사고를 방지하고 해운산업을 보호할 목적으로 선박의 상태를 점검하고 결함 사항에 대하여 시정조치를 요구한다. 외국적 선박을 점검하여 기준미달선(Sub-standard vessel)을 식별한다. 선박의 감항성, 인명의 안전 및 해양환경에 중대한 지장을 초래하는 결함사항을 식별한다. 결함사항이 발견된 선박에 대하여 출항정지 등을 통해 시정조치 요구하며 결함이 개선될 때까지 해당 선박 출항을 금지한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workFunc1":"조정","workFunc2":"감독","workFunc3":"조작운전","certLic":"2급 해기사, 3급 해기사, 조선산업기사, 조선·기계·산업설비기술사","dJobECd":"0210","dJobECdNm":"[0210]정부·공공행정 전문가","dJobJCd":"2620","dJobJCdNm":"[2620]정부 및 공공 행정 전문가","dJobICd":"O842","dJobICdNm":"[O842]사회 및 산업정책 행정","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006983:1', '{"dJobCd":"K000006983","dJobCdSeq":"1","dJobNm":"해사안전감독관","workSum":"사업장 및 선박의 선체, 기관·하역·소화·안전설비, 기기 정비 상태, 정비 시스템 등의 적정성에 대해 지도하고 감독한다.","doWork":"선박이나 사업장에 대한 출입검사, 해사안전관리 상태의 확인·조사·점검, 선장·선박소유자 등 관계인의 출석·진술요구, 서류 제출 등 해사안전관리에 관한 업무를 수행하고 보고한다. 해사안전관리에 영향을 미치는 결함사항에 대한 시정조치 개선을 명령한다. 개선명령 사항 중 선박시설의 보완이나 대체가 필요한 긴급한 사항 등이 발견된 경우 항행정지를 명령한다. 여객선 특별점검, 운항관리자의 보고접수, 운항관리규정 심사·변경요구, 운항관리규정 이행상태 보고를 접수한다. 선박 안전운항 및 선원관련 사항, 여객선의 경우 운항관리자, 운항관리지침 심사 및 선장 적성검사를 수행한다. 운항관리자에 대한 지도·감독, 종선 운항 지도·감독, 기타 해운법령에 따라 여객선안전관리에 필요한 지도·감독업무를 수행한다. 선박 동승점검, 구명설비 시연 등 승객·선원들의 안전의식 증진과 해양사고 예방을 위한 교육 및 훈련을 실시한다. 감독결과 내용을 분석하고 차기년도 중점감독사항을 수립한다. 안전관리 취약선박에 대한 불시점검을 실시한다. 해사안전관리 제도 전반에 대한 개선 의견을 개시한다. 해양사고 예방을 위한 관계기관 합동특별점검을 지원하고 업무협조를 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","connectJob":"운항감독관, 감항감독관, 여객선감독관, 화물선감독관, 원양어선감독관","certLic":"해기사면허증","dJobECd":"0210","dJobECdNm":"[0210]정부·공공행정 전문가","dJobJCd":"2620","dJobJCdNm":"[2620]정부 및 공공 행정 전문가","dJobICd":"O842","dJobICdNm":"[O842]사회 및 산업정책 행정","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007562:1', '{"dJobCd":"K000007562","dJobCdSeq":"1","dJobNm":"노무사","workSum":"사업장의 노사관계 대한 사항을 진단하고 분석하여 합리적인 방안을 제시하고 채용에서 퇴직까지의 근로자의 모든 법률문제를 담당한다.","doWork":"노동위원회 구제신청(개별 근로자에 대한 부당해고, 징계, 전직, 감봉, 비정규직 차별시정 등) 대리업무, 산업재해 신청 대리업무, 임금체불 진정 및 대리업무, 체당금 신청 및 대리업무를 수행한다. 노사 간 분쟁 발생 시 노사분쟁 조정 및 중재업무를 수행한다. 기업 및 노조에 대한 법률 및 정책자문을 한다. 인사관리컨설팅, 조직역량개발, 조직문화개선 등 경영조직컨설팅, 노무관리 진단, 노사컨설팅(단체교섭 대리 및 단체협약 분석), 급여 및 4대보험 사무대행, 고용컨설팅(채용, 모집대행)업무, 사업장 안전·보건에 대한 점검 및 자문을 수행한다. 직장 내 성희롱, 직장 내 괴롭힘 조사, 예방교육, 신고 등을 수행한다. 정부에서 제공하는 각종 지원금(중소기업지원금, 신규고용촉진장려금, 고령자고용촉진장려금, 모성보호관련지원금, 고용유지지원금 등) 신청에 관련된 서비스를 제공한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"공인노무사","connectJob":"노사관계전문가","certLic":"공인노무사","dJobECd":"0222","dJobECdNm":"[0222]인사·노무 전문가","dJobJCd":"2711","dJobJCdNm":"[2711]인사 및 노사 관련 전문가","dJobICd":"M711","dJobICdNm":"[M711]법무관련 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007364:1', '{"dJobCd":"K000007364","dJobCdSeq":"1","dJobNm":"라이프코치","workSum":"청소년, 대학청년, 주부, 직장인, 은퇴자 등 개인을 대상으로 삶의 모든 영역에서 코칭 고객 스스로가 행복을 증진할 수 있도록 건강, 재무, 여가취미, 가족, 사회 참여, 관계와 소통, 삶의 목표와 의미, 정체성 등의 이슈에 초점을 두고 코칭 기법(관찰, 질문, 경청, 인정과 지지, 피드백, 메시징 등)을 활용하여 코칭한다.","doWork":"최근에 일어난 일, 변화, 기분 등에 대해 대화를 나누며 코칭 고객과 신뢰 관계를 형성한다. 인터뷰 또는 진단을 통해 코칭 고객의 이슈 및 니즈를 파악하고 분석한다. 코칭 고객이 현재 처한 문제나 상황, 코칭 고객 스스로가 생각하는 바람직한 삶의 방향, 코칭 고객의 미래 목표 등에 대해서 질문한다. 질문을 통해 코칭 고객의 강점을 발견하고 코칭 고객 스스로 의식이나 관점을 전환할 수 있도록 돕는다. 건강, 재무, 여가취미, 가족, 사회 참여, 관계와 소통, 삶의 목표와 의미, 정체성 등의 목표를 달성하기 위한 실행 계획을 코칭 고객이 스스로 수립할 수 있도록 질문한다. 코칭 고객 스스로가 각 실행 계획을 구체적으로 실천할 수 있도록 질문한다. 모니터링을 통해 코칭 고객의 계획 실행 여부 혹은 진척도를 점검한다. 피드백(응원, 지지, 개선 상황 모색, 후원 환경 확인 등)을 통해 스스로가 수립한 실행 계획을 코칭 고객이 지속적으로 실행에 옮길 수 있도록 돕는다. 필요 시 각종 성격유형검사를 실시하기도 한다. 코칭 고객을 대상으로 코칭 과정을 몇 달간 실시한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"조정","workFunc2":"자문","workFunc3":"관련없음","similarNm":"생활코치, 생애코치, 인생코치, 멘탈코치","connectJob":"비즈니스코치, 커리어코치","dJobECd":"0222","dJobECdNm":"[0222]인사·노무 전문가","dJobJCd":"2711","dJobJCdNm":"[2711]인사 및 노사 관련 전문가","dJobICd":"M715","dJobICdNm":"[M715]회사 본부 및 경영 컨설팅 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007363:1', '{"dJobCd":"K000007363","dJobCdSeq":"1","dJobNm":"비즈니스코치","workSum":"민간 기업 및 공공 조직의 최고경영자, 임원, 중간관리자 등 조직의 구성원 등을 대상으로 리더십, 직무 성과, 조직 문화, 전략, 직무 역량 등 지속적인 성장을 추구하는 조직(기업/기관)의 운영과 성과에 영향을 주는 비즈니스 이슈에 초점을 두고 코칭 기법(관찰, 질문, 경청, 인정과 지지, 피드백, 메시징 등)을 활용하여 코칭한다.","doWork":"고객 기관에게 코칭 범위, 기간, 방법, 규모, 비용 등을 포함한 제안을 한다. 제안 내용을 토대로 고객 기관과 협의하여 계약을 체결한다. 코칭 고객 및 이해관계자와의 진단 및 인터뷰를 통해 고객의 코칭 이슈를 도출한다. 코칭 이슈를 기초로 코칭에 대한 동의를 구하고, 코칭 주제, 목표, 다회기 일정 등을 합의한다. 관찰, 질문, 경청, 인정과 지지, 피드백, 메시징 등의 코칭 기술 및 도구를 활용하여 코칭 주제에 대한 고객의 관점 전환 및 통찰을 끌어낸다. 관점 전환 및 통찰을 기반으로 실행 계획을 수립하도록 돕는다. 고객의 실행력을 높이기 위한 후원 환경을 조성한다. 고객의 실행을 촉진하기 위하여 매회기 사이에 Remind Call 등 모니터링을 실시한다. 실행 결과를 점검하고 성찰하도록 돕는다. 코칭 목표 달성 정도를 점검하여 향후 코칭에 반영하도록 지원한다. 코칭을 진행하는 동안 코칭 과정과 코칭 성과를 관리한다. 사후 진단 및 인터뷰 등을 통하여 코칭 성과를 측정한다. 고객의 코칭 성과 보고서 작성을 돕는다. 고객과 협의하여 이해관계자와 공유한다. 후속 코칭 지원 여부를 논의한다. 이 모든 과정을 코치 윤리 규정에 따라 시행한다. 코칭 프로그램을 개발하고 필요한 학습을 지원한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"조정","workFunc2":"자문","workFunc3":"관련없음","similarNm":"조직개발코치, 경영자코치, 리더십코치, 성과코치, 창업코치","connectJob":"라이프코치, 커리어코치","dJobECd":"0222","dJobECdNm":"[0222]인사·노무 전문가","dJobJCd":"2711","dJobJCdNm":"[2711]인사 및 노사 관련 전문가","dJobICd":"M715","dJobICdNm":"[M715]회사 본부 및 경영 컨설팅 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007116:1', '{"dJobCd":"K000007116","dJobCdSeq":"1","dJobNm":"스크럼마스터","workSum":"애자일을 위한 가이드를 기반으로 세부 규칙을 정하고 팀(스크럼)을 지원한다.","doWork":"개발 팀의 업무 효율을 높이고 애자일(Agile)한 환경을 구축하여 지속적인 성장을 위한 지침을 마련하고 가이드를 제시한다. 제품의 품질을 향상시키기 위해 다양하고 효율적인 방법론으로 제품 개발 프로세스를 관리한다. 제품개발자(PO: Product Owner)가 투자수익률을 극대화하거나 목표를 달성할 수 있도록 지원한다. 제품개발자가 백로그를 준비할 수 있도록 돕는다. 프로세스의 원활한 진행과 점검을 위해 매일 스크럼 회의를 주도한다. 스프린트 계획(스프린트 하나를 대상으로 단기일정을 수립하는 것)과 리뷰 회의를 조직하여 내부 커뮤니케이션을 촉진한다. 프로젝트 마감일을 인지하고 빠르게 도달할 수 있도록 촉진한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"교육","workFunc3":"관련없음","dJobECd":"0222","dJobECdNm":"[0222]인사·노무 전문가","dJobJCd":"2711","dJobJCdNm":"[2711]인사 및 노사 관련 전문가","dJobICd":"M715","dJobICdNm":"[M715]회사 본부 및 경영 컨설팅 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007136:1', '{"dJobCd":"K000007136","dJobCdSeq":"1","dJobNm":"애자일코치","workSum":"애자일 방법론(소프트웨어 개발의 불확실성이 높아지면서 새롭게 등장한 개발 방식)을 조직에 전파하고 동기를 부여하여 효과적인(민첩한) 조직이 되도록 코치한다.","doWork":"기업 내 문화를 성숙하게 변화시키기 위한 전략을 수립하고 실행한다. 업무방식을 관찰하고 애자일 마인트셋, 가치, 원칙, 실천방법을 이해하고 실행할 수 있도록 코치한다. SDLC(Software Development Life Cycle)를 더욱 민첩하게 하기 위한 문화, 표준, 도구, 프로세스, 실천법을 발굴하고 적용한다. 조직과 구성원 간 피트백 루프(Feedback Loop)를 원활하게 만들어 제품과 구성원의 성장을 촉진시킨다. 협업 도구(JIRA, Confluence 등)를 안정적으로 운영한다. 애자일 적용 사례들을 발굴하고 사내에 전파한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"교육","workFunc3":"관련없음","dJobECd":"0222","dJobECdNm":"[0222]인사·노무 전문가","dJobJCd":"2711","dJobJCdNm":"[2711]인사 및 노사 관련 전문가","dJobICd":"M715","dJobICdNm":"[M715]회사 본부 및 경영 컨설팅 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007137:1', '{"dJobCd":"K000007137","dJobCdSeq":"1","dJobNm":"인재추천전문가","workSum":"기업의 임원이나 기술자 등 고급인력을 필요로 하는 업체에 원하는 인력의 발굴에서부터 평가, 추천까지 조사과정을 거쳐 적정인력을 소개한다.","doWork":"의뢰업체를 방문하여 요구하는 인재의 능력, 성격, 경력, 제시연봉 등을 파악한다. 의뢰업체의 비전, 조직구조, 조직문화, 경력경로 등을 파악한다. 기존 자료나 인재탐색을 통해 의뢰업체에서 요구하는 인재와 부합하는 인재를 몇 배수 선발한다. 대상자와 접촉하여 스카우트 제의를 표시한다. 후보대상자를 대상으로 업무수행능력과 인성을 중심으로 인터뷰한다. 후보자 중 추천할 사람을 선정하여 대상자의 경력, 학력, 인성, 전직이유, 희망연봉 등을 기술하여 의뢰업체에 송부한다. 의뢰업체에서 긍정적인 반응을 보인 후보자와 연봉 등을 협상하고 조정한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"고급인력알선원, 헤드헌터","dJobECd":"0222","dJobECdNm":"[0222]인사·노무 전문가","dJobJCd":"2711","dJobJCdNm":"[2711]인사 및 노사 관련 전문가","dJobICd":"N751","dJobICdNm":"[N751]고용알선 및 인력공급업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004045:1', '{"dJobCd":"K000004045","dJobCdSeq":"1","dJobNm":"인재평가사","workSum":"채용, 평가, 승진, 배치 등의 조직 내 주요 인사결정을 위해 인터뷰, 심리검사, 시뮬레이션 등의 심리측정학적 도구를 활용, 평가대상자들의 역량을 정교하게 평가하여 보고서를 작성하고 피드백을 제공한다.","doWork":"평가대상 조직 및 평가대상자들의 직무, 직급, 역할 등의 특성을 이해하고, 평가하고자 하는 역량, 평가절차, 평가도구를 심층적으로 파악하고 숙지한다. 정해진 평가절차에 따라 평가도구를 활용하여 평가대상자의 역량 관련 정보를 수집하고 평가한다. 신입직원 및 경력직원 채용을 위한 인터뷰에 면접관으로 직접 참여하거나, 면접관들을 대상으로 면접교육을 실시한다. 재직자, 승진후보자, 보직후보자를 대상으로 한 역량평가에 평가위원으로 참여하거나, 평가 대비 사전교육의 강사로 활동한다. 재직자, 승진후보자, 보직후보자의 역량개발을 위한 역량교육의 이론강의를 담당하거나 실습과정의 퍼실리테이터로 활동한다. 평가결과를 정리하여 평가대상자의 역량에 대한 점수, 행동특징, 강약점 등을 문서로 작성하고, 필요시 이를 직접 피드백한다. 역량평가 후 지원자, 재직자, 승진후보자, 보직후보자 대상의 인터뷰 및 역량평가 결과를 보고서로 작성한다. 평가보고서 작성 후 평가결과를 개인 또는 집단으로 평가대상자에게 피드백을 제공한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","similarNm":"인사면접관, 어쌔서(Assessor)","connectJob":"인사면접관","dJobECd":"0222","dJobECdNm":"[0222]인사·노무 전문가","dJobJCd":"2711","dJobJCdNm":"[2711]인사 및 노사 관련 전문가","dJobICd":"M715","dJobICdNm":"[M715]회사 본부 및 경영 컨설팅 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006338:1', '{"dJobCd":"K000006338","dJobCdSeq":"1","dJobNm":"인적자원컨설턴트","workSum":"인적자원관리와 인적자원개발을 위한 각종 프로그램을 설계하고 조직의 변화 및 근로자와 관리자의 업무성과 향상에 대해 컨설팅한다.","doWork":"컨설팅 의뢰자(기업)와 상담하여 요구사항을 접수한다. 컨설팅 대상 기업의 문화, 조직, 대내외 경영여건 등을 조사하고 분석한다. 분석한 자료를 토대로 컨설팅 프로그램 개발계획을 수립한다. 모델(역량, 평가, 이·전직 모델)개발 방법을 선정하고 설문지를 개발하거나 직무분석을 실시한다. 인적자원의 효율적인 관리와 업무향상을 위한 인사체계, 임금체계, 역량모델, 평가모델, 이·전직모델 등을 개발하여 제공한다. 교육훈련 프로그램을 설계 및 개발하고 근로자나 사업담당자, 관리자를 대상으로 직무능력 향상을 위한 교육을 실시한다. 교육을 위한 교재를 개발하기도 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","similarNm":"인적자원전문가, 인사컨설턴트, 인사조직컨설턴트","connectJob":"인적자원관리(HRM)컨설턴트, 인적자원개발(HRD)컨설턴트","certLic":"경영지도사(인적자원관리)","dJobECd":"0222","dJobECdNm":"[0222]인사·노무 전문가","dJobJCd":"2711","dJobJCdNm":"[2711]인사 및 노사 관련 전문가","dJobICd":"M715","dJobICdNm":"[M715]회사 본부 및 경영 컨설팅 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007017:1', '{"dJobCd":"K000007017","dJobCdSeq":"1","dJobNm":"전직지원전문가","workSum":"고객의 요구를 분석하여 전직지원을 기획하고 전직대상자의 역량을 진단하고 목표를 수립하며 이에 따른 변화관리, 생예설계, 취창업 등을 지원한다.","doWork":"전직지원서비스 대상 기업과 개인에 대한 정보를 수집하고 서비스를 전략적으로 제안하여 고객을 발굴하고 확대한다. 서비스 지원을 위해 대상기업과 해당 산업의 전직시장 환경 및 정부 정책, 대상기업의 서비스 요구와 그 의도를 분석적으로 파악하고 명료화한다. 전직지원 서비스의 범위를 설정하고 범위에 따라 사업계획서를 작성하여 고객사와 협의하고 전직지원 서비스 계획서를 확정한다. 초기면담, 변화동기지원, 전직논점진단, 전직역량분석 등을 통해 전직목표설정을 한다. 전직목표설정에 기반하여 전직 재취업상담, 창업상담, 훈련상담을 한다. 직업에서 오는 심리적 논점에 대한 개입이 필요하다고 판단된 전직지원 대상자의 호소 문제를 통하여 가설을 설정하고 상담목표에 따라 기법과 전략을 통하여 직업심리 치료 등을 실시한다. 전직지원 상담원의 역량강화 및 전직지원상담의 질적 제고를 위해 전직지원상담의 과정에서 드러난 전략과 목표, 개입과 상담기법, 상담결과 등에 대하여 피감독자를 도와 점검하고 평가한다. 전직정보를 수집ㆍ분석하며 이를 가공ㆍ체계화한다. 전직목표 달성자를 대상으로 직무만족과 적응에 관한 문제를 진단하고 갈등관리, 스트레스관리 등을 통해 안정적인 직업적응을 돕는다. 전직목표를 달성하지 못한 전직대상자에 대하여는 추가적인 전직정보를 제공하고 전직지원 상담을 진행한다. 전직지원 사업 운영에 필요한 문서 및 사무ㆍ시설ㆍ전산망 등의 일반 행정업무 및 관리를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"커리어컨설턴트","certLic":"직업상담사(1급, 2급)","dJobECd":"0222","dJobECdNm":"[0222]인사·노무 전문가","dJobJCd":"2711","dJobJCdNm":"[2711]인사 및 노사 관련 전문가","dJobICd":"N751","dJobICdNm":"[N751]고용알선 및 인력공급업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002789:1', '{"dJobCd":"K000002789","dJobCdSeq":"1","dJobNm":"직무분석가","workSum":"조직적인 인사관리, 합리적인 직무평가, 과학적인 교육훈련 등을 목적으로 사업체 및 공공기관 등에서 수행되는 업무의 내용, 수행요건, 근로조건 등과 같은 기술적인 정보를 조사·분석·평가한다.","doWork":"연구 및 조사계획 수립을 위하여 사업체 또는 공공기관의 임원이나 담당자와 협의한다. 조사 및 분석을 수행하기 위하여 조사·분석방법을 연구하고 기준을 수립한다. 수행직무의 내용과 특성, 조직체의 경향, 직무수행요건 등을 분석하기 위하여 직무조사 및 분석양식을 개발한다. 수행업무, 작업형태와 양, 직무 간의 상호관계, 근로조건, 요구되는 지식, 태도, 기술 등을 면접, 관찰, 설문, 작업기록법 등의 직무분석기법을 활용하여 조사·기록한다. 조사한 자료를 종합하여 정리·평가한다. 분석내용을 기준으로 인사관리나 교육훈련 등에 필요한 기술적인 정보를 제공한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"직무분석전문가","dJobECd":"0222","dJobECdNm":"[0222]인사·노무 전문가","dJobJCd":"2711","dJobJCdNm":"[2711]인사 및 노사 관련 전문가","dJobICd":"M702","dJobICdNm":"[M702]인문 및 사회과학 연구개발업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006160:1', '{"dJobCd":"K000006160","dJobCdSeq":"1","dJobNm":"직업연구원","workSum":"국민들이 정보에 기초하여 올바른 진로를 설계하고 각종 직업 기반 정책 수립을 위해 직업정보를 수집,분석, 가공하여 개발하고 적합직업 발굴, 창직, 신직업 등 직업과 관련 정책 및 기초 연구를 한다.","doWork":"예산, 일정, 조사분야, 조사대상자 등을 고려하여 직업 연구계획을 수립한다. 연구계획을 검토하여 타당성, 시의성, 개발될 정보의 신뢰성을 제고한다. 인터넷, 문헌조사 등을 통해 조사할 직업(직종)에 대한 사전조사를 한다. 설문조사, 간담회 등의 방법을 통하여 직종(직업)의 현황을 수집한다. 직무분석, 전문가인터뷰, 설문조사 등의 방법으로 구체적인 직업정보를 수집한다. 수집된 정보를 연구 목적에 맞게 정리한다. 정리된 직업정보를 인터넷, 책자 등에 수록하고 보급한다. 직업정보를 활용하여 취업프로그램, 진로지도프로그램 등을 개발하기도 한다. 정보를 토대로 청년, 여성, 신중년 등 계층별 적합직종 발굴하거나 창직, 신직업 등 직업과 관련된 정책 및 기초 연구를 수행한다. 기타 진로지도프로그램을 개발 및 개정하기도 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"직업연구가, 직업연구전문가, 직업정보개발자","dJobECd":"0222","dJobECdNm":"[0222]인사·노무 전문가","dJobJCd":"2711","dJobJCdNm":"[2711]인사 및 노사 관련 전문가","dJobICd":"M702","dJobICdNm":"[M702]인문 및 사회과학 연구개발업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006927:1', '{"dJobCd":"K000006927","dJobCdSeq":"1","dJobNm":"취업컨설턴트","workSum":"청년층을 중심으로 구직자가 취업할 수 있도록 기업, 직업, 채용정보를 수집하고 자기소개서 작성, 면접 방법 등 취업 지도 및 취업에 대해 조언하고 교육한다.","doWork":"직업적성, 직업흥미 등 진로탐색과 심리 검사를 실시하여 직업진로 기초자료를 작성한다. 취업 및 진로목표를 달성을 위한 세부적인 취업진로 및 취업계획서를 작성한다. 구직자의 취업자원 분석과 평가를 통해 취업 경쟁력 파악과 대응전략을 수립한다. 전공, 경력 등 구직자가 보유한 취업자원을 분석하여 적합한 직무와 직무포트폴리오를 구성한다. 채용목적과 평가기준에 맞는 지원서, 자기소개서, 경력기술서 작성 등 기업 서류전형에 필요한 전반적 사항에 대해 교육한다. 또한 서류전형 모의평가를 통해  지원서 경쟁력을 파악하여 부족한 부분을 개선한다. 인적성 평가에 대한 전문적 조언과 필요한 교육을 진행한다. 면접에 대한 기본 이해와 일반면접, 영상면접, AI 면접 등 면접유형별 전문적 교육을 진행하며, 개인별 모의평가를 통해 경쟁력을 강화시키고 부족한 부분을 보완한다. 기업 채용제도, 채용트렌드, 채용프로세스, 평가방식, 채용규모와 목적, 기업정보, 직무정보, 기업가치관 등 정보를 수집 및 분석하여 구직자에게 지원하고 교육한다. 구직자의 취업스트레스, 취업불안 등 심리적 요인들을 상담을 통해 파악하여 개선시키고 극복할 수 있도록 조언 및 지도한다. 구직자의 취업목표, 태도, 가치관, 취업인식을 개선시켜 새로운 취업환경을 조성한다. 구직계층별 적합한 취업콘텐츠, 취업프로그램을 개발하여 지원하고 대상별 맞춤교육을 한다. 구직자에 도움되는 취업 및 일자리 관련 정책과 정보를 조사하여 지원한다. 구직자 및 취업정책에 도움되는 취업관련 분야에 대해 도서출판, 기고, 제언, 영상매체 등을 운영하거나 참여한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0222","dJobECdNm":"[0222]인사·노무 전문가","dJobJCd":"2711","dJobJCdNm":"[2711]인사 및 노사 관련 전문가","dJobICd":"N751","dJobICdNm":"[N751]고용알선 및 인력공급업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007424:1', '{"dJobCd":"K000007424","dJobCdSeq":"1","dJobNm":"커리어코치","workSum":"초중등 학생, 대학생, 직장인, 은퇴자, 청소년, 청장년, 신중년 등을 대상으로 직업의 가치와 의미를 찾아가는 것을 목적으로 진로 설계, 경력 개발, 역량 개발 등의 이슈에 초점을 두고 코칭 기법(관찰, 질문, 경청, 인정과 지지, 피드백, 메시징 등)을 활용하여 코칭한다.","doWork":"고객에게 코칭을 제안(기간, 방법, 비용 등)하고, 코칭 동의 및 계약을 체결한다. 초중등 학생을 대상으로 학습 및 진로를 선택할 수 있도록 돕는다. 대학생 및 취업 준비생을 대상으로 취업과 관련된 지원 서류 작성과 면접 요령을 익힐 수 있도록 돕는다. 직장인의 승진이직경력 관리경력 전환 등의 경력 설계와 전직 지원을 위해 필요한 역량을 계발할 수 있도록 돕는다. 은퇴자가 자신의 경력과 역량에 부합하는 직업을 찾아 제2의 인생을 설계할 수 있도록 돕는다. 사명 선언서 등의 작업을 통해 고객이 자신의 생애 목표와 방향을 수립하도록 돕는다. 관찰, 질문, 경청, 인정과 지지, 피드백, 메시징 등의 코칭 기법 및 도구를 활용하여 고객이 자신의 진로를 주체적으로 정할 수 있도록 자각과 통찰을 이끌어낸다. 직업 흥미, 적성, 성격, 직업 가치관 등의 진단을 통해 고객이 적합한 직업 목록을 찾을 수 있도록 돕는다. 고객이 자신의 재능, 강점, 사회 기여도 및 수입 규모 등을 고려하여 직업 목록 중에서 적합한 희망 직업을 선택할 수 있도록 돕는다. 고객의 경력 관리 및 생애 목표를 토대로 자신의 커리어 로드맵을 고객 스스로 수립할 수 있게 한다. 수립한 커리어 로드맵에 따라 구체적인 실행 계획을 작성하고 실천할 수 있도록 돕는다. 모니터링을 통해 고객의 실행 여부 또는 진척도를 점검한다. 피드백(응원, 지지, 개선 방안 모색, 후원 환경 확인 등)을 통해 계획을 지속적으로 실천할 수 있도록 돕는다. 코칭 성과를 측정하고 고객의 코칭 만족도를 조사한다. 고객이 커리어 로드맵을 따라 지속적으로 자신의 역량을 개발해 나아갈 수 있도록 돕는다. 커리어 코칭의 모든 과정을 윤리 규정에 따라 진행한다. 코칭 프로그램을 개발하고, 필요한 학습을 지원한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"조정","workFunc2":"자문","workFunc3":"관련없음","similarNm":"커리어컨설턴트, 경력관리전문가, 직업지도전문가, 전직지원전문가","connectJob":"비즈니스코치, 라이프코치","dJobECd":"0222","dJobECdNm":"[0222]인사·노무 전문가","dJobJCd":"2711","dJobJCdNm":"[2711]인사 및 노사 관련 전문가","dJobICd":"N751","dJobICdNm":"[N751]고용알선 및 인력공급업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003895:1', '{"dJobCd":"K000003895","dJobCdSeq":"1","dJobNm":"퍼실리테이터","workSum":"조직체의 역량개발, 개인변화, 문제해결, 갈등관리, 전략수립, 조직개발, 조직문화, 지역개발, 정책수립 등을 지원하기 위하여 의뢰자의 니즈를 파악하고 퍼실리테이션 운영방안을 마련하여 구성원의 의견을 반영하여 최적의 해결책을 제시한다.","doWork":"고객이 퍼실리테이션을 요청 시 고객의 니즈(역량개발, 전략수립, 지역개발 등)와 상황(시간, 인원, 결과 등)을 정확히 파악한다. 고객의 니즈를 토대로 목적 달성을 위한 세부적인 프로세스와 활동을 계획한다. 다양한 퍼실리테이션의 역량과 기법을 활용하여 설계를 한다. 설계를 바탕으로 주제에 대한 아이디어를 도출 후 통합하고 의사결정을 통해 합의를 만들어 최적의 결과물을 도출한다. 추수활동(Follow-up)을 계획하고 고객과 협의하여 결과물이 실현될 수 있도록 지원한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"갈등조정자, 모더레이터","dJobECd":"0222","dJobECdNm":"[0222]인사·노무 전문가","dJobJCd":"2711","dJobJCdNm":"[2711]인사 및 노사 관련 전문가","dJobICd":"M715","dJobICdNm":"[M715]회사 본부 및 경영 컨설팅 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007449:1', '{"dJobCd":"K000007449","dJobCdSeq":"1","dJobNm":"회계사","workSum":"회계에 관한 용역업무를 계획 및 관리하고, 의뢰인의 위임에 따라 재무회계서류의 작성, 기업의 소득세보고서 작성, 재무회계감사 또는 증명을 하며, 재무서류의 조정, 재무조사 및 기타 회계사무에 관한 상담을 한다.","doWork":"법정기업, 특수목적기업의 회계시스템을 계획·설정·관리한다. 개인, 부서, 회사나 기타 사업체의 재무정보를 작성한다. 회계기록을 조사하고 재무제표 및 보고서를 작성한다. 비용조사 결과보고서 작성 및 내부규제절차를 만들고 유지·관리한다. 재무거래계산서 및 기록들을 조사하고 회계보고서를 통해 소득세신고서를 작성한다. 재무제표 및 보고서를 분석하고 재무 및 세금에 대한 자문을 한다. 각 서류의 기재사항을 대조하고 오차가 발견되면 원인을 조사하여 조정한다. 일지, 원장기입, 은행계산서, 납세신고서 등의 회계 및 재무기록에 대해 사업체의 회계기준, 절차 및 내부규정의 일치 여부, 재무기록의 정확성 여부를 확인하기 위해 조사·분석한다. 회계감사결과에 대한 상세보고서를 작성하고 개인이나 사업체의 회계 및 경영실무를 개선하기 위한 권고안을 만든다. 소득세법 규정이나 기타 요건에 맞는지 확인하기 위해 사업현장 감사를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"교육","workFunc3":"관련없음","similarNm":"공인회계사(CPA)","connectJob":"회계감사역, 재무감사역","certLic":"공인회계사(CPA)","dJobECd":"0231","dJobECdNm":"[0231]회계사","dJobJCd":"2712","dJobJCdNm":"[2712]회계사","dJobICd":"M712","dJobICdNm":"[M712]회계 및 세무관련 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007525:1', '{"dJobCd":"K000007525","dJobCdSeq":"1","dJobNm":"세무사","workSum":"납세자 등의 위임을 받아 조세에 관한 신고·신청·청구, 세무조정계산서 및 세무 관련 서류를 작성하며, 조세신고를 위한 회계장부의 작성, 조세신고서류의 확인, 과세관청의 세무조사 등에 따른 의견진술대리, 기업(재무)진단, 조세에 관한 상담·자문, 성실신고에 관한 확인 등 세무에 관한 일체의 업무를 수행한다.","doWork":"세무사법에 따라 세무사로 등록하며 세무사 직무를 수행하기 위한 사무소를 개설한다. 납세자의 권익을 보호하고 납세의무의 성실한 이행에 이바지하기 위하여 납세자 등의 위임을 받아 세무 관련 업무를 수행한다. 세무사법, 세법, 기타 관계법규에 따라 소득세, 법인세, 상속세, 증여세, 종합부동산세, 부가가치세, 개별소비세 등 국세와 지방세에 대하여 신고·신청·청구(과세전적부심사청구, 이의신청, 심사청구 및 심판청구 등) 업무를 수행한다. 세무조정계산서 및 세무 관련 서류를 작성한다. 조세신고를 위한 회계장부의 작성, 조세신고서류의 확인, 과세관청의 세무조사 등에 따른 의견진술대리, 조세에 관한 상담·자문, 성실신고에 관한 확인 등 세무에 관한 전반적인 업무를 수행한다. 개발부담금에 대한 행정심판청구의 대리, 개별공시지가 및 주택가격 공시에 관한 이의신청을 수행한다. 납세자 등에 대한 세무계획, 세무컨설팅, 기업(재무)진단 등 세무와 회계(재무) 전반에 대한 업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"교육","workFunc3":"관련없음","certLic":"세무사","dJobECd":"0232","dJobECdNm":"[0232]세무사","dJobJCd":"2713","dJobJCdNm":"[2713]세무사","dJobICd":"M712","dJobICdNm":"[M712]회계 및 세무관련 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007500:1', '{"dJobCd":"K000007500","dJobCdSeq":"1","dJobNm":"관세사","workSum":"관세법과 관련 법령에 근거하여 수출 및 수입과 관련된 통관업무를 수행한다.","doWork":"수출·입에 따른 교역대상국의 수입 및 수출에 대한 통관정보를 제공한다. 수출에 필요한 서류(인보이스, 물품명세서 등)를 작성한다. 수출통관에 필요한 서류를 작성하고 신고수리필증을 교부한다. 관세 환급에 필요한 서류를 작성하고 신청한다. 수입물품에 대한 관세 및 통관정보(품목별 제세율, 원산지표시 등)를 제공한다. 수입물품인수를 위한 서류를 구비하고 수입통관을 위해 품목별 세번 및 세율의 분류와 세액을 계산한다. 각종 이의신청 및 심사청구 또는 심판청구를 대행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"교육","workFunc3":"관련없음","certLic":"관세사","dJobECd":"0233","dJobECdNm":"[0233]관세사","dJobJCd":"2714","dJobJCdNm":"[2714]관세사","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003482:1', '{"dJobCd":"K000003482","dJobCdSeq":"1","dJobNm":"가맹거래사","workSum":"가맹본부와 가맹점사업자를 대상으로 경영 및 법률 자문을 비롯하여 정보공개서와 가맹계약서 및 기타 특약 등 작성 및 수정, 그리고 분쟁조정의 신청을 대리한다.","doWork":"가맹본부와 가맹점사업자를 대상으로 가맹사업의 사업성을 검토하고 자문한다. 정보공개서(가맹본부의 사업현황, 임원경력, 가맹점사업자의 부담, 영업활동의 조건, 가맹점사업자에 대한 교육·지도, 가맹계약의 해제·갱신, 기타 해당 가맹사업에 관하여 책자로 편철한 문서)와 가맹계약서 등을 작성하거나 수정하며 이에 대해 자문한다. 가맹사업자의 부담, 가맹사업 영업활동 조건 등에 대해 자문한다. 가맹사업당사자에 대해 교육과 훈련을 하며 이에 대해 자문한다. 가맹사업거래의 분쟁조정 신청을 대행한다. 정보공개서, 가맹계약서 및 기타 특약 등의 신청을 대행한다. 분쟁조정 과정에 동석하여 의견을 진술한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","similarNm":"프랜차이즈전문가, FE(Franchise Expert)","certLic":"가맹거래사","dJobECd":"0221","dJobECdNm":"[0221]경영·진단 전문가","dJobJCd":"2715","dJobJCdNm":"[2715]경영 및 진단 전문가","dJobICd":"M715","dJobICdNm":"[M715]회사 본부 및 경영 컨설팅 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004656:1', '{"dJobCd":"K000004656","dJobCdSeq":"1","dJobNm":"경영컨설턴트","workSum":"기업 경영을 구성하는 여러 요소(재무, 회계, 인사, 미래비전, 유통 등)에 대한 분석을 통하여 기업의 경영상 문제점을 밝히고 해결방안을 제시한다.","doWork":"고객과의 인터뷰를 통해 요구사항, 추진목적, 컨설팅 범위, 기간, 예산 등에 대한 정보를 수집한다. 인터뷰 내용을 정리하여 작성한 간이제안서를 고객에게 제공한다. 고객의 의견을 반영하여 사업제안서를 작성한다. 계약 후 착수보고회를 시행한다. 인터뷰, 워크숍, 벤치마킹 등의 기법을 활용하여 경영진단 및 분석을 하여 문제점을 제시한다. 이를 토대로 개선방안을 제시하고 개선을 위한 교육과 지도를 수행한다. 문제점, 개선방안을 중심으로 보고서를 작성하고 발주처의 의사결정자 또는 사업담당자에게 보고한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","similarNm":"기업경영컨설턴트, 경영분석가, 경영전략가, 경영진단전문가, 경영자문가","connectJob":"경영지도사, 6시그마컨설턴트, 기업행정진단전문가, 기업행정전문가, 비즈니스코치, 기술거래사, 기술가치평가사, 품질경영컨설턴트","certLic":"경영지도사, 기술지도사, 회계사","dJobECd":"0221","dJobECdNm":"[0221]경영·진단 전문가","dJobJCd":"2715","dJobJCdNm":"[2715]경영 및 진단 전문가","dJobICd":"M715","dJobICdNm":"[M715]회사 본부 및 경영 컨설팅 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003360:1', '{"dJobCd":"K000003360","dJobCdSeq":"1","dJobNm":"공급망관리컨설턴트","workSum":"고객사의 공급망관리(SCM:Supply Chain Management) 전반에 대해 문제를 진단하고 개선과제를 도출하여 해결방안을 제시한다.","doWork":"고객사의 요구를 파악하고 구매·조달관리 효율화, 재고최적화·재고보충계획, 공급망 네트워크, 공급망 가시성(Visibility), 영업 및 운영계획(S&OP), 수요관리, 수배송관리, 공급업체 및 협력업체와의 협업관리, 창고관리, 생산계획 및 라인스케줄링, IT시스템(ERP, SCM, SCE, WMS 등) 고도화 등 공급망관리(SCM:Supply Chain Management, 제품 및 서비스의 공급자에서부터 생산, 유통을 거쳐 최종 소비자까지의 모든 자원을 통합된 개념으로 관리하여 공급망의 전체에 걸쳐 자재, 정보 등의 흐름을 통합하고 연계하여 최적화하는 경영시스템) 관련 문제를 파악한다. 프로젝트팀을 구축하고 계약을 체결하는 등 작업에 착수한다. 의뢰인이 직면한 현안과 다양한 목표에 대해 심층적으로 정보를 수집해 문제를 파악하고 원인을 규명한다. 진단단계를 통해 파악된 문제와 원인을 바탕으로 프로세스 혁신(PI:Process Innovation), 창고 최적화 방안 수립 등 대안을 도출하고 실행계획을 수립한다. 수립된 실행계획에 따라 실행을 지원하고 해결대안을 조정하며 교육·훈련을 실시한다. 평가결과를 검토하며 최종 보고서를 작성하는 등 컨설팅 프로젝트를 완료한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"자문","workFunc3":"관련없음","similarNm":"SCM컨설턴트","certLic":"물류관리사, 국제무역사, 유통관리사","dJobECd":"0221","dJobECdNm":"[0221]경영·진단 전문가","dJobJCd":"2715","dJobJCdNm":"[2715]경영 및 진단 전문가","dJobICd":"M715","dJobICdNm":"[M715]회사 본부 및 경영 컨설팅 서비스업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002282:1', '{"dJobCd":"K000002282","dJobCdSeq":"1","dJobNm":"국제표준기구(ISO)인증심사원","workSum":"인증기관에 소속되어 기업이 신청한 조직의 경영시스템이 국제표준기구에서 정한 표준에 적합한지 확인하고 평가한다.","doWork":"인증획득에 관한 절차나 비용 등을 상담하고, 인증심사를 제안한다. 기업체에서 ISO규격을 토대로 구축해 놓은 경영자책임, 품질시스템, 관리, 공정관리 등 회사업무절차서가 ISO규격에 적합한지 검토·심사한다. 기업체에서 요청 시 본사와 현장을 방문하여 본심사와 동일하게 심사하여 문제점과 개선방안을 제시한다. 기업체의 업무절차에 따라 수행여부를 심사하여 부적합 발생 시 시정조치를 내린다. 시정조치가 완료되면 확인심사 후 운영위원회에 인증추천을 한다. 인증받은 기업에 대해 본심사와 동일한 절차로 연간 1회 이상 사후관리 심사를 한다. 인증서의 유효기간이 만료되면 재심사를 실시한다.인증심사 결과 보고서를 작성한다. 인증심사 관련 교육 및 컨설팅을 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"인증심사원","connectJob":"품질관리시스템인증심사원, 환경관리시스템인증심사원, 식품안전경영시스템인증심사원, 자동차산업품질시스템인증심사원, 의료기기품질시스템인증심사원, 정보보호경영시스템인증심사원, 친환경제품인증심사원, 친환경농산물인증심사원, 할랄인증심사원","dJobECd":"0221","dJobECdNm":"[0221]경영·진단 전문가","dJobJCd":"2715","dJobJCdNm":"[2715]경영 및 진단 전문가","dJobICd":"M715","dJobICdNm":"[M715]회사 본부 및 경영 컨설팅 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007288:1', '{"dJobCd":"K000007288","dJobCdSeq":"1","dJobNm":"기술거래사","workSum":"기술의 이전 및 사업화를 상담·자문·지도하고 기술이전을 중개 및 알선한다.","doWork":"기술공급자와 도입자 사이의 기술거래 필요성, 우선순위, 시급성 등을 검토하여 기술거래의 목표를 설정한다. 기술이전 상대, 이전 기술의 가치, 요구조건, 경쟁력, 도입조건 등을 검토하여 기술이전 전략을 수립한다. 발명자, 유관기관, 인터넷, 기술전시회, 설명회, 상담회 등을 통해 기술수요자 및 기술보유자를 조사·분석한다. 사업화를 통해 발생할 수 있는 기술의 경제적 가치를 가액, 등급 또는 점수로 평가한다. 기술의 지식재산권 여부, 즉시 상품화 가능성, 비밀 등을 고려하여 기술이전 조건을 협상한다. 기술공급자와 도입자의 권리능력, 행위능력을 고려하여 양도, 실시권 허락, 기술지도, 공동연구, 합작투자 또는 인수·합병 등의 기술이전 계약 체결을 중개한다. 기술 관련 자료를 제공하고 기술권리이전 서류를 교부한다. 기술료의 지급을 확인하고 기타 의무 보고사항을 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"기술이전전문가, 기술가치평가사","connectJob":"지식재산컨설턴트, 특허전문위원","certLic":"변호사, 변리사, 공인회계사, 기술사","dJobECd":"0221","dJobECdNm":"[0221]경영·진단 전문가","dJobJCd":"2715","dJobJCdNm":"[2715]경영 및 진단 전문가","dJobICd":"M701/M729","dJobICdNm":"[M701]자연과학 및 공학 연구개발업 / [M729]기타 과학기술 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005879:1', '{"dJobCd":"K000005879","dJobCdSeq":"1","dJobNm":"물류컨설턴트","workSum":"물류거점통합, 물류설비 자동화, 수배송 효율화 등 고객사의 물류문제에 대하여 진단하고 개선과제를 도출하여 해결방안을 제시한다.","doWork":"고객사의 요구를 파악하고 ①물류설비자동화, 안전관리 등 물류센터 구축 및 통합, ②증차, 감차, 대형화, 소형화, 공동화, 물류루트 최적화, 배차 등 수·배송 효율화, ③적정재고, ABC관리, 안전재고관리 등 물류센터의 재고관리 향상, ④물류 신규 루트구축, 냉장·냉동 콜드체인시스템 구축, 복합운송체계 구축 등 물류와 관련된 문제를 파악한다. 프로젝트팀을 구축하고 계약을 체결하는 등 작업에 착수한다. 의뢰인이 직면한 현안과 다양한 목표에 대해 심층적으로 정보를 수집해 문제를 파악하고 원인을 규명한다. 진단단계를 통해 파악된 문제와 원인을 바탕으로 대안을 도출하고 실행계획을 수립한다. 수립된 실행계획에 따라 실행을 지원하고 해결대안을 조정하며 교육·훈련을 실시한다. 평가결과를 검토하며 최종 보고서를 작성하는 등 컨설팅 프로젝트를 완료한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"자문","workFunc3":"관련없음","certLic":"물류관리사, 국제무역사, 유통관리사","dJobECd":"0221","dJobECdNm":"[0221]경영·진단 전문가","dJobJCd":"2715","dJobJCdNm":"[2715]경영 및 진단 전문가","dJobICd":"M715","dJobICdNm":"[M715]회사 본부 및 경영 컨설팅 서비스업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007400:1', '{"dJobCd":"K000007400","dJobCdSeq":"1","dJobNm":"바이오의약품인허가관리자","workSum":"바이오의약품을 허가, 발매할 수 있도록 등록에 필요한 허가서류 및 자료를 작성하여 국·내외 의약품의 적합성을 인정 및 허가하는 업무를 수행한다.","doWork":"의약품 임상시험과 임상시험계획승인에 필요한 신약 등 품목 허가, 제품 도입 시 국·내외 바이오의약품의 허가신청과 관련된 규정, 바이오의약품의 허가신청, 제품 광고 관련 규정 점검, 약가 사후관리, 표시기재 사항에 대한 자료를 수집한다. 국내·외 바이오의약업의 트렌드 및 제품특성을 파악하고, 제품 개발의 목표 설정과 각종 허가 규정에 적합한 개발전략 및 계획을 수립한다. 각국의 의약품 인허가 절차를 파악하고 규정에 맞는 구조물성, 안정성, 독성, 약리작용, 임상시험성적 등의 자료를 작성한다. 신청 제품에 관한 문제해결방안을 마련하고, 허가 의약품의 허가사항에 관한 지속적인 관리 업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"의약품인허가전문가","connectJob":"바이오의약품RA전문가, 바이오의약품규제과학전문가","dJobECd":"0221","dJobECdNm":"[0221]경영·진단 전문가","dJobJCd":"2715","dJobJCdNm":"[2715]경영 및 진단 전문가","dJobICd":"C211/M701","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업 / [M701]자연과학 및 공학 연구개발업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003729:1', '{"dJobCd":"K000003729","dJobCdSeq":"1","dJobNm":"사용자경험기획자","workSum":"사용자의 니즈를 파악하고 통찰력을 발휘하여 제품의 전체적인 흐름(Flow)을 디자인하고 서비스를 기획한다.","doWork":"사용자 친화적인 웹사이트와 모바일폰 등 제품을 개발하기 위해 문제점을 분석한다. 고객을 대상으로 사용자 친화성을 평가하기 위해 심층 인터뷰를 수행한다. 고객에게 개선된 사용자 경험을 제공하고 사용성 테스트를 실시한다. 제공된 사용자 경험에 따른 태도 및 상황적 인지 등을 평가한다. 사용자 경험이 반영된 서비스, 콘텐츠, 제품의 설계방안을 제시한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","similarNm":"UX디자이너, UX컨설턴트, UX기획자","dJobECd":"0221","dJobECdNm":"[0221]경영·진단 전문가","dJobJCd":"2715","dJobJCdNm":"[2715]경영 및 진단 전문가","dJobICd":"N759","dJobICdNm":"[N759]기타 사업지원 서비스업","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001624:1', '{"dJobCd":"K000001624","dJobCdSeq":"1","dJobNm":"사회적책임경영컨설턴트","workSum":"기업의 사회적책임경영(CSR:Corporate Social Responsibility) 추진 정도를 진단하고, 이를 위한 솔루션을 제공한다.","doWork":"기업의 사회적책임경영에 따른 경제적 가치와 더불어 윤리적, 사회적, 환경적 가치를 극대화할 수 있도록 프로세스, 경영, 전략, 교육 등 전반에 대해 조언한다. 사회적책임경영에 대한 국제적 기준인 ‘ISO 26000’에 대응하는 업무를 수행하기도 한다. 기업의 사회적책임경영 전략 수립을 위한 컨설팅업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","similarNm":"CSR컨설턴트","connectJob":"자원과 에너지를 절약하고 효율적으로 이용하기 위한 경영컨설팅을 전문으로 하는 경우 녹색경영컨설턴트","dJobECd":"0221","dJobECdNm":"[0221]경영·진단 전문가","dJobJCd":"2715","dJobJCdNm":"[2715]경영 및 진단 전문가","dJobICd":"M715","dJobICdNm":"[M715]회사 본부 및 경영 컨설팅 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004516:1', '{"dJobCd":"K000004516","dJobCdSeq":"1","dJobNm":"생산관리컨설턴트","workSum":"기업의 생산성을 높이기 위하여 생산현장의 문제점을 분석하고 개선방안을 제시한다.","doWork":"기업체의 문제점에 대하여 상담하고 진단의 목적, 내용, 범위, 기간, 소요예산 등을 협의한다. 생산현장에서 자료분석, 의식조사, 면담, 현장관찰 등의 분석기법을 진행한다. 생산계획, 작업연구, 순서계획, 일정계획, 공정관리 등에 걸쳐 문제점을 도출·정리하고 진단방향을 협의·설정한다. 문제점별로 개선안을 수립하고 적용한 후 문제점을 해소하여 생산성을 향상시킨다. 새로 개발된 분석기법, 진단 및 지도사례를 정리하여 공개교육이나 사내교육을 통해 전파한다. 관련 세미나에 참여하거나 개최하기도 한다. 원가조사, 학술용역 및 정책 관련 용역업무를 수행하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","certLic":"품질관리기술사, 품질경영기사, 품질경영산업기사, 경영지도사(생산관리)","dJobECd":"0221","dJobECdNm":"[0221]경영·진단 전문가","dJobJCd":"2715","dJobJCdNm":"[2715]경영 및 진단 전문가","dJobICd":"M715","dJobICdNm":"[M715]회사 본부 및 경영 컨설팅 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007402:1', '{"dJobCd":"K000007402","dJobCdSeq":"1","dJobNm":"석유화학인허가사무원","workSum":"석유화학제품 사업장의 안전보건 및 환경 법규 검토 및 대응을 위해 안전·보건·환경법규의 준수 및 안전·보건·환경시스템을 운영하고 대외기관 정기감사 관리업무, 인허가 업무처리 및 관리 등을 수행한다.","doWork":"안전·보건·환경 법규를 교육하고, 안전·보건·환경 사내규정을 제·개정 하며, 법규 및 규정 등의 준수 여부를 관리한다. 내부감사와 대외기관의 정기 감사를 실시하고 관리한다. 감사결과 지적사항에 대하여 수정 및 대응 등의 조치를 취하고, 안전·보건·환경 시스템관리 및 행정업무를 수행하며 관리한다. 인·허가 법령을 검토하고 절차를 파악하며 인·허가 관리와 인증유지를 위한 사후관리를 한다. 석유화학 관련 정책 방향과 법적 문제점들을 파악하여 해결하고 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"석유화학대외업무협력원, 석유화학안전환경관리기사","dJobECd":"0221","dJobECdNm":"[0221]경영·진단 전문가","dJobJCd":"2715","dJobJCdNm":"[2715]경영 및 진단 전문가","dJobICd":"C201/M","dJobICdNm":"[C201]기초 화학물질 제조업 / [M]전문, 과학 및 기술 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006324:1', '{"dJobCd":"K000006324","dJobCdSeq":"1","dJobNm":"섬유기술컨설턴트","workSum":"기업체를 대상으로 섬유기술 및 공정 개선, 신기술 공정 적용 등에 대해 컨설팅을 한다.","doWork":"섬유 및 섬유산업에 필요한 소재, 생산방식, 염색기술, 기계기술, 화학물질 등 첨단 섬유기술에 대하여 조언을 한다. 새로운 기술이 개발되면 기업체에 신기술에 대한 기술적 지원을 한다. 기업체의 경쟁력 강화를 위하여 설비, 소재 및 기술 등 생산공정 전반에 대한 조언을 하기도 한다. 화학섬유 등 섬유조제 분야 및 염색의 경우 화학물질의 배합 및 제조 등에 대한 기술지원을 한다. 친환경 소재 등에 대한 기술마케팅을 하며 대량생산을 위한 편직기, 염색기 등 설비에 대한 기술지원을 한다. 기업의 요구에 의해 개발된 기술에 대하여 실제 생산공정에 맞춰 컨설팅을 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","similarNm":"편직기술컨설턴트, 염색기술컨설턴트, 섬유기계기술컨설턴트","certLic":"섬유기술사","dJobECd":"0221","dJobECdNm":"[0221]경영·진단 전문가","dJobJCd":"2715","dJobJCdNm":"[2715]경영 및 진단 전문가","dJobICd":"M729","dJobICdNm":"[M729]기타 과학기술 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004008:1', '{"dJobCd":"K000004008","dJobCdSeq":"1","dJobNm":"수출입안전관리우수업체공인심사원","workSum":"AEO(Authorized Economic Operator:수출입 안전관리 우수 공인업체) 인증심사를 위해 서류심사 및 예비심사를 수행한다.","doWork":"공인을 획득하고자 하는 업체의 수출입관리 현황의 공인기준 적합성을 공인신청 전 점검하고 상담한다. 공인신청 시 서류심사를 수행한다. 공인업체가 공인 유효기간 만료에 따라 갱신하고자 하는 경우 서류심사를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"AEO심사원","certLic":"관세사","dJobECd":"0221","dJobECdNm":"[0221]경영·진단 전문가","dJobJCd":"2715","dJobJCdNm":"[2715]경영 및 진단 전문가","dJobICd":"S941","dJobICdNm":"[S941]산업 및 전문가 단체","inqYear":"2015"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003697:1', '{"dJobCd":"K000003697","dJobCdSeq":"1","dJobNm":"스마트팜컨설턴트","workSum":"시설원예 및 축산 농가를 대상으로 사물인터넷 등 ICT를 활용하여 농가시설을 현대화하고 이를 통해 지속적인 성장 및 수익창출을 지원하기 위해 스마트팜의 설계, 구축, 운영 등에 관하여 조언하고 지도한다.","doWork":"고객과의 인터뷰를 통해 요구사항, 컨설팅 범위, 기간, 예산 등의 정보를 수집한다. 인터뷰 내용을 정리하여 세부사업계획서를 작성한다. 인터뷰, 워크숍, 벤치마킹 등의 다양한 방법으로 농가의 특성(작물, 가축종류 등)과 시설(비닐하우스, 축사 등), 재정상태 등 여건을 고려한 최적의 스마트팜 구축방법, ICT융복합 도입장비, 통신방식 및 서비스형태 등을 분석하여 도출한다. 정보통신기술자와 협업하여 스마트팜시스템 구축을 지원하고 지원 후 스마트팜 활용방법 등을 농가에 조언한다. 농가를 방문하여 컨설팅한 후 사전컨설팅, 시설설치컨설팅, 시설점검컨설팅 등의 컨설팅 결과보고서를 작성하고 보고한다. 스마트팜시스템의 활용 후 수익창출의 변화 등을 모니터링하여 필요시 개선방안을 모색한다. 구축된 스마트팜시스템에서 수집한 정보를 분석하고 이를 위한 방법 등을 연구하기도 한다. 스마트팜의 필요성 및 효과 등에 대해서 농민과 관련자에게 교육하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"시설원예스마트팜컨설턴트, 축산스마트팜컨설턴트, 스마트팜구축전문가(정보통신)","certLic":"경영지도사, 기술지도사, 수의사, 회계사, 변리사. 농화학기술사, 시설원예기술사, 종자기술사, 축산기술사, 정보처리기술사","dJobECd":"0221","dJobECdNm":"[0221]경영·진단 전문가","dJobJCd":"2715","dJobJCdNm":"[2715]경영 및 진단 전문가","dJobICd":"M715","dJobICdNm":"[M715]회사 본부 및 경영 컨설팅 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007214:1', '{"dJobCd":"K000007214","dJobCdSeq":"1","dJobNm":"에너지진단사","workSum":"에너지 사용 시설 전반에 걸쳐 에너지 이용 현황 파악, 손실요인 발견 및 에너지절감을 위한 최적 개선안을 도출하기 위해 보일러, 냉난방공조시스템, 열수송설비 등의 열 진단을 하고 수배전 설비 및 각종 전기사용 설비에 대해 전기 진단을 한다.","doWork":"에너지 사용 실태를 파악하기 위해 에너지 설비와 구성, 사업체의 공정 등을 조사하고 고객의 요구사항을 분석하여 진단대상을 선정한다. 공정분석과 열설비 측정, 전기설비 측정, 에너지 밸런스 작성, 문제점 도출, 공정 제약조건을 분석한다. 기기의 성능과 손실요인을 점검하고 효율적인 운영 방법을 제시하거나 공정개선, 신기술 적용, 고효율설비 도입 등의 개선방안을 제안한다. 기술 분석, 경제성 분석 등을 통해 실시 가능한 개선안을 확정하고 실시 효과 예측 개선방안을 정리한다. 설명회 개최 및 보고서 작성 등을 하고 관계자에게 진단 결과를 보고한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"수동조작","connectJob":"에너지컨설턴트","certLic":"에너지관리기사, 에너지관리산업기사, 에너지진단사","dJobECd":"0221","dJobECdNm":"[0221]경영·진단 전문가","dJobJCd":"2715","dJobJCdNm":"[2715]경영 및 진단 전문가","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005421:1', '{"dJobCd":"K000005421","dJobCdSeq":"1","dJobNm":"온실가스에너지목표관리제검증심사원","workSum":"관리업체가 산정한 온실가스 배출량과 감축량이 관련 법령·지침에 따라 적합하게 이루어졌는지를 검토·확인한다.","doWork":"온실가스·에너지 목표관리제에 따라 관리대상 업체가 제출한 온실가스 배출기준량, 배출활동에 따른 배출량, 에너지소비량 등에 대한 온실가스배출량 및 에너지사용량명세서를 검증한다. 검증대상의 현황 및 위험(리스크)분석을 하고 측정데이터 수집계획 등을 고려하여 검증계획을 수립한다. 현장검증을 통해 제출된 명세서를 분석하여 온실가스배출량 및 에너지사용량 산정, 보고의 완전성, 일관성, 투명성, 적확성, 적절성 등을 검증한다. 검증보고서를 작성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"온실가스검증심사원, 온실가스인증심사원","dJobECd":"0221","dJobECdNm":"[0221]경영·진단 전문가","dJobJCd":"2715","dJobJCdNm":"[2715]경영 및 진단 전문가","dJobICd":"M715","dJobICdNm":"[M715]회사 본부 및 경영 컨설팅 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006804:1', '{"dJobCd":"K000006804","dJobCdSeq":"1","dJobNm":"온실가스인벤토리검증심사원","workSum":"온실가스 배출량의 산정이 고시 지침에서 정하는 절차와 기준 등에 적합하게 이루어졌는지를 검토·확인하는 검증 업무를 수행한다.","doWork":"온실가스 배출권거래제 및 온실가스 에너지 목표관리제의 배출량 보고서의 적절성을 확인하기 위해 검증대상의 조직, 운영현황, 공정, 에너지사용, 배출원, 흡수원을 파악하고 확인한다. 검증대상의 조직경계와 운영경계, 모든 배출원의 산정, 보고, 변동 여부에 대하여 확인한다. 온실가스 배출원에 대한 배출량 산정 시 지침에 따라 적합한 배출계수와 산정방법이 적용되었는지 확인한다. 배출량 산정에 필요한 데이터가 정확하게 측정되고 보고되었는지 확인한다. 검증과정에서 발견된 오류사항의 수정을 요청하고 보완이 완료된 최종 배출량 보고서에 대해 검증보고서를 작성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"온실가스배출량검증심사원","dJobECd":"0221","dJobECdNm":"[0221]경영·진단 전문가","dJobJCd":"2715","dJobJCdNm":"[2715]경영 및 진단 전문가","dJobICd":"M715","dJobICdNm":"[M715]회사 본부 및 경영 컨설팅 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002574:1', '{"dJobCd":"K000002574","dJobCdSeq":"1","dJobNm":"의료기기규제과학전문가","workSum":"의료기기 설계·개발부터 임상시험, 제품화, 생산, 시판 후 관리 등 의료기기 제품 전(全)주기에 필요한 법적·과학적 규제기준에 근거하여, 국내외 적합성 인정(GMP) 및 인허가, 임상시험 지원과 판매 등 사후관리업무를 담당하고 규제 당국과의 의사소통 창구역할을 한다.","doWork":"국내외 의료기기 분야 트렌드 및 제품개발 특성을 파악하여 개발목표를 설정하고 국가별 인허가 규정에 적합한 개발전략 및 계획을 수립한다. 수립한 개발계획에 따라, 유관부서와의 업무를 조율하고 효율적인 제품개발을 진행하는 데 지원한다. 국가별 허가 등록절차가 상이하기 때문에 이를 파악하고 등록에 필요한 허가서류를 작성, 제출하여 허가를 진행한다. 의료기기 임상시험을 지원한다. 등록진행제품의 문의사항에 대한 답변 및 해결방안을 준비하여 개발일정 내 허가를 달성하고 제품출시를 관리한다. 시판된 의료기기의 안전 등을 지속적으로 관리한다. 의료기기와 관련된 국내외 법률적 변화 등을 지속적으로 모니터링하고 필요시 관련 부서에 전달하거나 교육한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"의료기기RA전문가","certLic":"의료기기RA전문가","dJobECd":"0221","dJobECdNm":"[0221]경영·진단 전문가","dJobJCd":"2715","dJobJCdNm":"[2715]경영 및 진단 전문가","dJobICd":"C271/G478","dJobICdNm":"[C271]의료용 기기 제조업 / [G478]기타 상품 전문 소매업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007020:1', '{"dJobCd":"K000007020","dJobCdSeq":"1","dJobNm":"의료컨설턴트","workSum":"국내 의료기관의 설립, 의료기관의 경영환경 개선, 의료기관의 해외진출 등을 지원하기 위해 고객분석, 시장조사, 법률 및 제도 검토, 재정상황 분석 등을 하고 추진방향 및 전략 및 과제 등을 도출하고 자문하며 실행을 점검한다.","doWork":"고객과의 인터뷰를 통해 요구사항, 추진목적, 컨설팅 범위, 기간, 예산 등에 대한 정보를 수집한다. 인터뷰 내용을 정리하여 작성한 간이제안서를 고객에게 제공한다. 국내외 시장환경을 조사한다. 의료기관 설립(인허가 포함)을 위한 법, 제도 등을 검토한다. 의료기관 설립을 위한 투자유치, 재정마련 등을 검토한다. 의료기관 설립 등 해외진출을 위한 조사를 한다. 인터뷰, 워크숍, 벤치마킹 등의 기법을 활용하여 경영진단 및 분석을 하여 문제점을 제시한다. 의료기관 경영 개선방안을 제시하고 개선을 위한 교육과 지도를 수행한다. 기존 의료기관의 문제점, 추진방향 및 전략, 개선 방향 등을 중심으로 보고서를 작성하고 발주처의 의사결정자 또는 사업담당자에게 보고한다. 실행에 대한 점검 및 피드백을 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"의료경영컨설턴트, 의료해외컨설턴트","dJobECd":"0221","dJobECdNm":"[0221]경영·진단 전문가","dJobJCd":"2715","dJobJCdNm":"[2715]경영 및 진단 전문가","dJobICd":"M715","dJobICdNm":"[M715]회사 본부 및 경영 컨설팅 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003809:1', '{"dJobCd":"K000003809","dJobCdSeq":"1","dJobNm":"의사결정분석전문가","workSum":"마케팅전략과 실행계획을 수립하기 위해 고객자료를 신경망, 결정트리 기법 등을 사용하여 분석함으로써 고객 욕구 분석, 신용카드 사용금액 예측, 고객 충성도 평가 등을 수행한다.","doWork":"신경망, 결정트리 기법을 사용하여 데이터웨어하우스의 고객자료를 분석한다. 평가 및 분석을 위한 예측 및 평가 모델(규칙)을 만든다. 모델을 사용하여 고객 욕구 분석, 고객 가치 평가, 향후 신용카드 사용금액의 예측, 고객 충성도 평가 등을 한다. 기간별로 예측과 실제 결과를 비교·분석하여 모델을 수정한다. 분석자료를 월별로 작성한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"단순작업","connectJob":"분석CRM전문가, 데이터마이닝전문가","dJobECd":"0221","dJobECdNm":"[0221]경영·진단 전문가","dJobJCd":"2715","dJobJCdNm":"[2715]경영 및 진단 전문가","dJobICd":"M715","dJobICdNm":"[M715]회사 본부 및 경영 컨설팅 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007293:1', '{"dJobCd":"K000007293","dJobCdSeq":"1","dJobNm":"의약품약가담당자","workSum":"의약품 허가 후 시중에 판매할 의약품 가격을 정하고 신약 등 전문의약품의 경우 보건당국과 약가 협상을 진행한다.","doWork":"의약품 허가 후 판매할 약가를 결정하기 위해 관련 자료를 수집분석한다. 임상적 유용성, 비용효과성, 재외국 등재 현황 등을 고려하여 약가를 결정한다. 신약 등 약가협의가 필요한 경우 임상적 유용성, 비용효과성, 재외국 등재현황자료와 임상문헌 등의 자료를 수집하여 심평원에 신약 급여결정 신청을 한다. 급여 적정성을 인정받은 후에 건강보험공단과 약가 협상을 한다. 약가 정책 및 약가 관련 규정에 대해 유관부서에 공유 및 교육을 실시한다. 복지부의 약가 관련 고시와 지침이 개정되는 부분을 모니터링하여 회사 제품의 약가 변동이 예상될 경우 미리 내용을 내부적으로 공유하고 대응한다. 기존 보험등재 의약품의 약가사후관리를 실시한다. 약제의 허가적응증 중 요양급여가 인정되는 기준 및 범위를 확대하는 급여기준확대 업무를 담당한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"MA약가담당자, Market Access담당자","certLic":"약사, 간호사","dJobECd":"0221","dJobECdNm":"[0221]경영·진단 전문가","dJobJCd":"2715","dJobJCdNm":"[2715]경영 및 진단 전문가","dJobICd":"C212/M701","dJobICdNm":"[C212]의약품 제조업 / [M701]자연과학 및 공학 연구개발업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007421:1', '{"dJobCd":"K000007421","dJobCdSeq":"1","dJobNm":"의약품인허가관리자","workSum":"규제기관으로부터 의약품제조 및 유통에 대한 인허가를 받기 위해 의약품 인허가 규정파악, 해외 의약품규격·기준을 파악한다.","doWork":"개발에 앞서 규정에 필요한 약리, 안전성, 독성, 유효성 관련 자료 확인과 개발, 임상, 허가 전략 계획을 수립한다. 연구 개발품목의 도출, 기획, 허가 및 시장 진입관련 전략을 수립하고, 사전개발계획안 수립과 자료를 작성한다. IND(Investigation New Drug: 임상시험용으로 승인된 의약품) 제출과 사전 기시(기준 및 시험법) 또는 안유(안정성유효성)를 위한 자료를 취합, 정리, 검토, 대응한다. 임상팀과 임상시험 전략 수립, 필요 요건 확인, 문서제출 및 대응방안을 수립한다. 취합된 허가자료 (CTD, Common Technical Document, 의약품 국제공통 기술문서: 비임상, 임상, 품질) 검토 및 식약처에 대응하고 검토한다. 약가 획득을 위한 전략 검토 및 개량신약, 제네릭, 허가 시점, 특허 전략을 지원한다. 약사법 관리 규정 개정에 따른 Follow up, 업허가 관리, 위험성 평가를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"의약품RA전문가, 의약품규제과학전문가","dJobECd":"0221","dJobECdNm":"[0221]경영·진단 전문가","dJobJCd":"2715","dJobJCdNm":"[2715]경영 및 진단 전문가","dJobICd":"C211","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005966:1', '{"dJobCd":"K000005966","dJobCdSeq":"1","dJobNm":"전사적자원관리시스템컨설턴트","workSum":"기업 내 자원 등을 분석하고 전사적자원관리시스템 설계 및 구축에 관한 솔루션을 제공한다.","doWork":"새로운 전사적자원관리(ERP) 패키지의 특성 및 활용법에 대해 숙지한다. 각종 경영컨설팅 기법에 대해 연구한다. 고객을 대상으로 ERP 패키지에 대해 설명한다. 인사, 회계, 재무, 유통 등 기업의 경영자원을 세부적으로 파악한다. 기본 전사적자원관리(ERP) 패키지와 대상 기업의 환경 및 구조차이를 파악한다. 분석결과를 정리하여 제안서를 작성한다. 개발 금액을 산정한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","similarNm":"ERP전문가","connectJob":"ERP개발자","dJobECd":"0221","dJobECdNm":"[0221]경영·진단 전문가","dJobJCd":"2715","dJobJCdNm":"[2715]경영 및 진단 전문가","dJobICd":"M715","dJobICdNm":"[M715]회사 본부 및 경영 컨설팅 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004079:1', '{"dJobCd":"K000004079","dJobCdSeq":"1","dJobNm":"전자상거래컨설턴트","workSum":"정부, 기업, 개인 등 경제 주체들이 네트워크를 통해 전자적 방식으로 상품 및 서비스를 교환하는 전자상거래시스템을 개발 및 운용한다.","doWork":"가상공간에 시장을 구축하는 데 필요한 기술, 물류 및 마케팅 등 경영분야와 관련 법률에 대한 지식을 바탕으로 전자상거래시스템 개발의 전 과정에 관여한다. 전자상거래의 법률적 문제를 검토한다. 전자상거래 사이트를 구축한다. 전자상거래 사이트의 운영, 관리를 감독한다. 구매 업체 및 소비자의 요구를 반영하는 마케팅전략을 수립한다. 전자상거래 구축에 대한 컨설팅을 수행한다. 경영자에게 전자상거래에 관련된 전반적인 업무를 보고한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"보통 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","certLic":"전자상거래운용사, 전자상거래관리사(1급, 2급)","dJobECd":"0221","dJobECdNm":"[0221]경영·진단 전문가","dJobJCd":"2715","dJobJCdNm":"[2715]경영 및 진단 전문가","dJobICd":"G479","dJobICdNm":"[G479]무점포 소매업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007422:1', '{"dJobCd":"K000007422","dJobCdSeq":"1","dJobNm":"정밀화학인·허가관리자","workSum":"정밀화학 인·허가와 관련한 규제기관으로부터 제조 및 유통의 인허가를 받기 위해 관련 법규에 따라 개발제품의 허가·인증, 화학물질에 대한 등록 및 관리 업무를 수행한다.","doWork":"인·허가 심사 관련 법규를 파악 및 검토하고 대응한다. 인·허가 심사 관련 법규의 개정의견을 작성한다. 인·허가와 관련한 내부감사를 수행한다. 개발제품 허가 및 인증과 관련한 업무를 수행하고 허가접수 및 보고업무를 수행한다. 개발제품에 대한 허가 및 인증에 대한 보완조치를 하고 결과에 대응한다. 정밀화학물질과 관련한 규제정보를 파악하고 정밀화학물질에 대한  물리·화학적 특성, 안전성, 규제관련 법규, 정밀화학물질의 정보검색 방법 등을 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"정밀화학인·허가심시원","dJobECd":"0221","dJobECdNm":"[0221]경영·진단 전문가","dJobJCd":"2715","dJobJCdNm":"[2715]경영 및 진단 전문가","dJobICd":"C203/C204","dJobICdNm":"[C203]비료, 농약 및 살균, 살충제 제조업 / [C204]기타 화학제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002739:1', '{"dJobCd":"K000002739","dJobCdSeq":"1","dJobNm":"제약의사","workSum":"의약품, 백신, 의료기기, 진단기기 등의 연구, 개발, 평가, 허가, 모니터링, 의약정보 제공과 관련 전문가로서의 의학적, 과학적, 윤리적 의견 등 자문을 제공한다.","doWork":"신약이나 기존 약물의 연구 혹은 신약개발을 위한 임상시험의 디자인 및 관리, 안전성 및 유효성 평가, 신약허가 신청, 안전성 정보 모니터링, 마케팅 등의 영역에서 자문을 제공한다. 질병의 예방이나 치료, 진단에서 아직 충족되지 못한 의학적 요구(Unmet Medical Needs)에 대한 정보를 제공한다. 의약품 등의 광고물과 판촉활동의 내용이 과학적이며 각국의 윤리강령이나 법규정에 어긋나지 않는지 분석한다. 매체나 학술행사를 통한 전문적 소통을 하고 제품이나 질환과 관련한 불만이나 문의에 대해 회사가 제공할 답변을 검토한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"FBM(Field Based Medicine), 메디컬어드바이저(Medical Advisor) 메디컬디렉터(Medical Director)","certLic":"의사","dJobECd":"0221","dJobECdNm":"[0221]경영·진단 전문가","dJobJCd":"2715","dJobJCdNm":"[2715]경영 및 진단 전문가","dJobICd":"C212","dJobICdNm":"[C212]의약품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005359:1', '{"dJobCd":"K000005359","dJobCdSeq":"1","dJobNm":"제품환경컨설턴트","workSum":"기업의 요구에 따라 제품개발과 생산, 폐기까지 제품의 전 생애에 걸친 친환경 전략을 분석·평가하고 대안을 제시한다.","doWork":"기업의 제품개발 부서 또는 관련 담당자와 협의하여 상품기획, 제품설계, 디자인, 생산, 마케팅, 폐기 및 회수, 재활용, 재사용 등 제품개발의 모든 단계를 환경적 관점에서 분석·평가한다. 친환경 기술과 아이디어를 제공한다. 특정 제품의 경우 환경표지인증 제도 등 친환경 제품으로 인증받을 수 있는 방법을 함께 제시하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"에코디자인컨설턴트","dJobECd":"0221","dJobECdNm":"[0221]경영·진단 전문가","dJobJCd":"2715","dJobJCdNm":"[2715]경영 및 진단 전문가","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006369:1', '{"dJobCd":"K000006369","dJobCdSeq":"1","dJobNm":"지속가능전문가","workSum":"경영에 영향을 미치는 환경문제, 사회문제, 지배구조, 기업 윤리 등을 종합적으로 고려하여 기업의 지속가능성을 추구하기 위한 사업을 기획·개발·운영한다.","doWork":"기업의 지속가능경영보고서를 발간하기 위한 기획, 작성, 검증 관련 자문 및 컨설팅을 한다. 기업에게 의뢰받은 프로젝트를 수행하기 위해 목표설정, 사업전략 등을 구상한다. 지속가능 프로젝트에 사용될 자금확보를 위해 행정지원 및 관련 신청서 등을 작성한다. 지속가능경영 관련 법률, 기술적인 사항, 마케팅 등을 연구하거나 검토한다. 새로운 지속가능지표를 확인하거나 개발하며, 지속가능경영 활동을 평가한다. 지속가능경영의 효과를 알리기 위한 보고서나 발표자료를 개발한다. 지속가능경영 확산 제안 또는 정책을 개정하거나 개정을 지원한다. 지속가능경영(ESG)보고서를 작성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"지속가능경영전문가, ESG전문가, ESG사무원","connectJob":"지속가능컨설턴트","dJobECd":"0221","dJobECdNm":"[0221]경영·진단 전문가","dJobJCd":"2715","dJobJCdNm":"[2715]경영 및 진단 전문가","dJobICd":"M715","dJobICdNm":"[M715]회사 본부 및 경영 컨설팅 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007198:1', '{"dJobCd":"K000007198","dJobCdSeq":"1","dJobNm":"창업기획자","workSum":"초기 창업기업을 발굴해서 엔젤투자, 사업공간 제공, 멘토링 제공 등 종합보육서비스를 제공한다.","doWork":"대중매체 등 홍보채널을 활용하여 사업홍보(액셀러레이터 및 스타트업 홍보)를 하고 스타트업을 선발한다. 선발된 스타트업을 위한 입주공간, 협업공간, 강의장 등을 운영하고 안내하는 등 지원한다. 스타트업에 직접 초기투자를 한다. 선발기업의 특징, 요구사항, 성장단계를 고려한 맞춤형 창업교육, 멘토링 및 컨설팅을 지원한다. 데모데이 개최 등 후속투자 유치를 지원한다. 선발기업의 국내외 시장창출을 지원하기 위한 투자자, 고객, 파트너사, 졸업기업, 스타트업 지원기관 등과의 네트워킹을 지원한다. 졸업기업 및 선발기업 등 동문기업에 대한 후속투자 유치, 상호협력 등 후속 지원을 한다. 성과목표 달성을 위한 관리(투자유치, 판로개척, 고용창출, 지식재산권 확보 등)를 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내·외","physicalAct":"언어력|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"엑셀러레이터, 엑셀러레이팅매니저","dJobECd":"0221","dJobECdNm":"[0221]경영·진단 전문가","dJobJCd":"2715","dJobJCdNm":"[2715]경영 및 진단 전문가","dJobICd":"N759","dJobICdNm":"[N759]기타 사업지원 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002823:1', '{"dJobCd":"K000002823","dJobCdSeq":"1","dJobNm":"창업보육매니저","workSum":"창업보육센터 입주기업을 대상으로 기술, 경영, 마케팅, 인증분야 획득, 지적재산권 획득 등에 대해 조언하고 지도한다.","doWork":"각 창업보육센터에 적합한 기술창업 기업을 발굴하고 창업기업의 자가진단을 통해 강약점을 분석하여 창업기업에 적합한 중장기적 지원전략을 수립한다. 창업기업의 성장단계에 따라 창업교육, 기업가정신, 법인설립, 사업타당성 분석, 사업계획서 작성, 법률지원, 회계재무교육, 시장분석, 기술분석, 연구장비 공용활용, 기업부설연구소, 정부R&D, 지식재산권, 사업 인허가, 공장설립, 기술이전, 투자유치, 해외진출 등의 업무를 창업보육센터 내외부 전문가와 연계하여 지원한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"BI매니저, 창업보육전문매니저","dJobECd":"0221","dJobECdNm":"[0221]경영·진단 전문가","dJobJCd":"2715","dJobJCdNm":"[2715]경영 및 진단 전문가","dJobICd":"N759","dJobICdNm":"[N759]기타 사업지원 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003487:1', '{"dJobCd":"K000003487","dJobCdSeq":"1","dJobNm":"창업컨설턴트","workSum":"창업준비자를 대상으로 창업종목, 비용, 시설인허가, 메뉴선정 및 구성, 점포개설 등 창업에 대한 전반적인 사항을 상담하고 조언한다.","doWork":"창업을 원하는 고객에게 상담을 해주고 창업계획을 돕는다. 산업전망 및 업종, 비용, 상권이나 수익성 등을 분석한다. 고객의 특성과 적성, 흥미 등을 고려하여 업종을 선택한다. 점포입지를 조사하여 구매한다. 인테리어 및 점포시공과 홍보 및 마케팅을 돕는다. 업종이 프랜차이즈인 경우 가맹본부를 선정하여 계약한 후 창업 관련 교육을 한다. 입지개발 전문가, 홍보전문가, 회계사, 인테리어전문가, 변호사 등 창업에 필요한 전문가를 모아 의견을 구하거나 업무를 배분하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내·외","physicalAct":"언어력|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"창업아이디어컨설턴트","connectJob":"프랜차이즈컨설턴트, 폐업컨설턴트","certLic":"가맹거래사","dJobECd":"0221","dJobECdNm":"[0221]경영·진단 전문가","dJobJCd":"2715","dJobJCdNm":"[2715]경영 및 진단 전문가","dJobICd":"M715","dJobICdNm":"[M715]회사 본부 및 경영 컨설팅 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007127:1', '{"dJobCd":"K000007127","dJobCdSeq":"1","dJobNm":"청정개발체제심사원","workSum":"타당성검토, 감축량검증 등을 통해 청정개발체제(CDM)사업의 신뢰성, 성실성, 투명성, 일관성의 확보 여부를 파악하고 보증한다.","doWork":"청정개발체제(CDM)사업 운영기구(DOE:Designated Operational Entity)에 제출된 사업설계문서(PDD:Project Design Document)의 베이스라인(Base-Line) 방법론과 배출전망치(BAU:Business As Usual) 설정 등이 주어진 요건(완전성, 일관성, 정확성, 적합성, 투명성, 보수성 등)을 만족하는지 타당성 검토(Validation)를 실시하고 심사보고서를 작성한다. 청정개발체제(CDM)사업을 통해 감축되는 온실가스의 감축량 측정을 위한 모니터링 업무, 계측장비의 설치·운영 및 측정업무, 수집된 감축량 데이터의 이상 유무에 대해 감축량검증(Verification)업무를 수행한다. 검증 및 인증보고서를 작성하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"시디엠(CDM)사업심사원","dJobECd":"0221","dJobECdNm":"[0221]경영·진단 전문가","dJobJCd":"2715","dJobJCdNm":"[2715]경영 및 진단 전문가","dJobICd":"M715","dJobICdNm":"[M715]회사 본부 및 경영 컨설팅 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001907:1', '{"dJobCd":"K000001907","dJobCdSeq":"1","dJobNm":"친환경마케팅컨설턴트","workSum":"친환경제품 기획, 제조, 판매전략 등에 대한 컨설팅 외에 지속가능한 친환경적 기업전략 수립 등 기업의 친환경마케팅 전반에 대해 자문을 한다.","doWork":"기업의 상품 및 서비스의 환경유해 및 인체위해 요소를 분석한다. 친환경적인 원료, 디자인, 포장의 적용을 통해 환경친화적인 기업전략의 수립을 조언한다. 기업이 제공하는 상품 및 서비스의 특징과 가격, 유통구조, 비용, 소비자의 성향, 판매수준 등을 분석하여 친환경제품의 판매 및 홍보전략을 자문한다. 친환경적인 기업활동을 지속할 수 있도록 기업 조직구조, 의사결정 등의 기업전략 수립을 자문한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"그린마케팅컨설턴트","dJobECd":"0221","dJobECdNm":"[0221]경영·진단 전문가","dJobJCd":"2715","dJobJCdNm":"[2715]경영 및 진단 전문가","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004761:1', '{"dJobCd":"K000004761","dJobCdSeq":"1","dJobNm":"컴퓨터기반공학컨설턴트","workSum":"산업현장에서 일어나는 요구사항을 컴퓨터 시뮬레이션 기술을 활용하여 사전 성능예측, 제품개발 프로세스 전반에 걸쳐 문제점을 진단하고 개선방안을 제시한다.","doWork":"산업현장의 신제품 개발 또는 기존 제품의 성능개선 문제를 분석한다. 컴퓨터 시뮬레이션 기술을 활용하여 문제점을 진단하고 분석한다. CAE(Computer Aided Engineering)가 프로세스에 접목되어 개발 효율성을 나타낼 수 있도록 신제품 개발 또는 기존 제품의 성능개선을 위한 기술지원을 한다. 현장 문제점 개선을 위한 교육 및 코칭업무를 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"손사용|언어력|시각|","workFunc1":"조정","workFunc2":"자문","workFunc3":"제어조작","similarNm":"CAE컨설턴트","dJobECd":"0221","dJobECdNm":"[0221]경영·진단 전문가","dJobJCd":"2715","dJobJCdNm":"[2715]경영 및 진단 전문가","dJobICd":"M715/N759","dJobICdNm":"[M715]회사 본부 및 경영 컨설팅 서비스업 / [N759]기타 사업지원 서비스업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006855:1', '{"dJobCd":"K000006855","dJobCdSeq":"1","dJobNm":"콘텐츠컨설턴트","workSum":"학교, 기업, 개인 등 콘텐츠 수요자를 대상으로 목적과 예산 등을 종합적으로 검토하여 요구에 적합한 콘텐츠를 기획, 제작하거나 교육한다.","doWork":"수요자의 주된 활동지를 방문하여 상황을 파악한다. 수요자와 상담하여 당면과제, 예산, 콘텐츠 개발 목적 등을 파악한다. 요구조사 결과를 토대로 콘텐츠의 방향성을 공유하기 위한 선행사례를 제시한다. 플랫폼별 특징을 교육하고 맞춤 콘텐츠를 추천한다. 수요자를 대상으로 콘텐츠 개발방법 등을 교육한다. 필요시 의뢰자의 요구사항을 반영하여 영상콘텐츠를 제작한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내·외","physicalAct":"청각|언어력|시각|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0221","dJobECdNm":"[0221]경영·진단 전문가","dJobJCd":"2715","dJobJCdNm":"[2715]경영 및 진단 전문가","dJobICd":"M715","dJobICdNm":"[M715]회사 본부 및 경영 컨설팅 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007099:1', '{"dJobCd":"K000007099","dJobCdSeq":"1","dJobNm":"탄소배출권거래컨설턴트","workSum":"국내외 온실가스 감축을 통해 발생된 탄소배출권(Credit)을 선진국에 판매하여 거래를 성사시키는 컨설팅을 한다.","doWork":"국내외 기후변화 관련 포럼 및 세미나에 참가하고 학회 및 연구기관의 동향분석 자료를 발간한다. 포인트카본 가입을 통해 탄소시장 동향을 분석하고 정기적으로 구매희망업체를 선별하여 세미나를 주최한다. 향후 탄소배출권 가격전망과 구매자에 대해 분석하고 거래안정성 등에 관한 연구를 한다. 구매자가 나타나면 최적거래시기를 선정하여 최적거래가를 도출하여 거래가 성사되도록 한다. 탄소배출권 투자상품을 개발하고 운영한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"탄소배출권거래중개인","certLic":"온실가스관리기사","dJobECd":"0221","dJobECdNm":"[0221]경영·진단 전문가","dJobJCd":"2715","dJobJCdNm":"[2715]경영 및 진단 전문가","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001480:1', '{"dJobCd":"K000001480","dJobCdSeq":"1","dJobNm":"통신서비스시장분석가","workSum":"마케팅전략 수립과 통신망 시설투자계획 수립을 위해 일반전화, 통신망회선 및 각종 통신 관련 상품의 현재 및 미래의 수요를 파악하고 고객의 이용성향을 분석한다.","doWork":"경제·사회지표, 경기전망 및 계약자 수, 시설 수 등의 통계를 분석하여 인터넷, 무선인터넷, 모바일인터넷, IPTV, 이동통신 등 각종 통신서비스의 수요를 조사하고 장래수요를 예측한다. 타 사업자의 수요, 통신정책 등과 일반전화 가입수요 및 트래픽을 분석하여 통신망회선 수요를 예측한다. 시외전화 영업정보시스템을 운용하여 시외전화 이용성향을 분석한다. 국제 관문국 국가별 통화 건수, 지역별 국제통화 건수, 통화시간, 매출액을 조사하여 국제전화 이용성향을 분석한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","certLic":"정보처리기사","dJobECd":"0221","dJobECdNm":"[0221]경영·진단 전문가","dJobJCd":"2715","dJobJCdNm":"[2715]경영 및 진단 전문가","dJobICd":"J612","dJobICdNm":"[J612]전기 통신업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003151:1', '{"dJobCd":"K000003151","dJobCdSeq":"1","dJobNm":"품질관리컨설턴트","workSum":"사업체의 품질관리시스템에 대하여 자문하고 품질관리 인증을 받을 수 있도록 진단 및 교육을 실시한다.","doWork":"품질관리시스템에 관해 진단을 의뢰한 사업체의 당면과제를 파악한다. 국제표준화기구(ISO)의 품질보증모델인 국제표준품질보증시스템(ISO 9000)의 추진목표, 방향, 범위를 설정한다. 현행 품질 관련 업무를 파악하고 분석한다. 국내외 표준품질보증에 관련된 심사를 받을 수 있도록 시스템을 구축한다. 품질관리절차서를 포함한 각종 필요한 문서작성에 대해 자문한다. 심사에서 부적합한 경우가 발생하여 심사위원이 시정조치를 요구하면 사업체가 시정조치를 할 수 있도록 자문한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","certLic":"품질관리기술사, 품질경영기사, 품질경영산업기사, 경영지도사(생산관리)","dJobECd":"0221","dJobECdNm":"[0221]경영·진단 전문가","dJobJCd":"2715","dJobJCdNm":"[2715]경영 및 진단 전문가","dJobICd":"M715","dJobICdNm":"[M715]회사 본부 및 경영 컨설팅 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001998:1', '{"dJobCd":"K000001998","dJobCdSeq":"1","dJobNm":"할랄컨설턴트","workSum":"기업체에서 식품, 화장품, 의약품 등 할랄인증을 받고자 할 경우 인증을 위한 제반 절차와 방법을 컨설팅하고 인증업무를 대행하기도 한다.","doWork":"기업에서 인증컨설팅 의뢰가 오면 인증받을 제품이나 인증대상 국가 등 사업체의 요구를 파악하여 인증절차나 방법, 인증기간, 인증비용, 인증필요서류 등을 안내한다. 사업체를 방문하여 사용하는 원료, 시설, 공정, 인적 구성 등, 인증항목과 기준에 적절한지 확인하고 개선안을 마련하여 제공한다. 인증준비를 위해 각종 서류작성을 도와주거나 할랄보증시스템을 구축해 준다. 인증심사원이 배정되면 인증심사원의 이동이나 사업체방문 시 인증을 위한 통역 등 각종 지원을 한다. 사업체가 인증을 받지 못할 경우 문제점을 분석해서 보완하도록 안내하고 필요시 지원한다. 할랄에 대한 인식 전환과 할랄인증 홍보를 위한 컨퍼런스를 개최하고 할랄인증 관련 교육 등을 수행하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"할랄지도사","connectJob":"할랄인증심사원","dJobECd":"0221","dJobECdNm":"[0221]경영·진단 전문가","dJobJCd":"2715","dJobJCdNm":"[2715]경영 및 진단 전문가","dJobICd":"M715","dJobICdNm":"[M715]회사 본부 및 경영 컨설팅 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003296:1', '{"dJobCd":"K000003296","dJobCdSeq":"1","dJobNm":"협동조합코디네이터","workSum":"협동조합(재화 또는 용역의 구매·생산·판매·제공 등을 협동으로 영위함으로써 조합원의 권익을 향상하고 지역사회에 공헌하고자 하는 사업조직)의 설립과 경영 전반에 대하여 지원, 자문한다.","doWork":"협동조합을 설립하고자 하는 사람에게 상담을 통해 협동조합 설립 가능여부, 설립절차, 운영방법 등에 대해 설명한다. 발기인 모집, 정관 작성, 설립동의자 모집, 설립신고, 사무인계, 출자금 납입, 설립등기 등 협동조합 설립절차를 지원한다. 정관, 창립총회 공고문, 의사록, 사업계획서, 수입지출예산서, 설립동의자 명부, 출자금, 임원명부, 임원이력서 등 관련 서류를 검토하고 미흡한 부분을 수정·보완한다. 설립(인가)된 협동조합의 경영(법무, 세무, 인사, 노무, 홍보, 마케팅 등)을 지원한다. 협동조합 운영 중에 발생할 수 있는 문제점(이익 배당의 갈등, 조합원의 임원에 대한 불신, 조합원의 참여의식 부재, 공동체의식 부재 등)에 대하여 사전에 예방하거나 문제해결을 지원한다. 각 협동조합 간 협력요소를 파악하고 자원연계를 추진하여 건강한 협동조합 생태계를 도모한다. 협동조합 설립 이후에 사후관리 차원에서 교육프로그램을 제공하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"협동조합컨설턴트","connectJob":"마을기업인큐베이터","certLic":"경영지도사","dJobECd":"0221","dJobECdNm":"[0221]경영·진단 전문가","dJobJCd":"2715","dJobJCdNm":"[2715]경영 및 진단 전문가","dJobICd":"M715","dJobICdNm":"[M715]회사 본부 및 경영 컨설팅 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005638:1', '{"dJobCd":"K000005638","dJobCdSeq":"1","dJobNm":"국제투자기획원","workSum":"금융기관의 국제투자부문에 소속되어 국제 간 투자업무를 기획·추진한다.","doWork":"국제산업 및 국제경제전망, 국제정세분석보고서 등의 정보와 자료를 수집·분석하여 연구한다. 투자전망을 예측한다. 국제금융시장의 동향을 분석한다. 국제투자 추진방향을 설정하고 업무별 추진전략 및 영업목표를 관리한다. 국제투자설명회, 국제투자포럼 등에 참석하여 국제투자시장의 동향을 파악한다. 업무교류 대상 금융기관을 선정하고 업무제휴방안을 수립한다. 신규 국제투자처를 개발한다. 대내외 환경변화에 따른 제도개선업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0311","dJobECdNm":"[0311]투자·신용 분석가","dJobJCd":"2721","dJobJCdNm":"[2721]투자 및 신용 분석가","dJobICd":"K641","dJobICdNm":"[K641]은행 및 저축기관","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006357:1', '{"dJobCd":"K000006357","dJobCdSeq":"1","dJobNm":"기업신용조사분석원","workSum":"신용정보회사 또는 금융기관에 소속되어 기업에 대한 신용도를 조사·분석하여 보고한다.","doWork":"법인 또는 개인사업자가 기업 및 기관(금융기관, 정부기관 등)과 거래, 계약, 금융업무 등을 진행하기 위하여 신용정보를 의뢰할 경우, 기업 및 기관에 대한 조사·분석에 착수한다. 증권감독원, 상공회의소, 법원등기소 등 관청이나 관계기관, 협회, 조합 및 사업체를 방문하고 자료를 수집한다. 사업체의 사업내용, 거래실적, 설비규모, 자본금 및 사채발행 현황 등과 같은 자산구성, 경영자의 능력 및 동종업계의 현황과 전망 등을 조사·검토한다. 수집된 자료와 조사내용을 정리하고 회보서(조회보고서)를 작성하여 의뢰인에게 제출한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","similarNm":"신용분석가","certLic":"신용분석사, 신용위험분석사","dJobECd":"0311","dJobECdNm":"[0311]투자·신용 분석가","dJobJCd":"2721","dJobJCdNm":"[2721]투자 및 신용 분석가","dJobICd":"K641/N759","dJobICdNm":"[K641]은행 및 저축기관 / [N759]기타 사업지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005128:1', '{"dJobCd":"K000005128","dJobCdSeq":"1","dJobNm":"선물옵션시장분석가","workSum":"국내외 선물옵션시장에 대한 시장분석 및 예측을 하고, 투자전략의 수립, 투자기법 개발, 신상품 개발 등의 업무를 수행한다.","doWork":"국내외 산업동향, 날씨, 정책, 경제상황 등을 실시간으로 주시하며 정보네트워크 및 선물, 옵션시장의 시황을 파악하고 분석한다. 국내외 선물, 옵션 관련 데이터 및 정보를 수집한다. 미시적인 경제동향, 거시경제현황분석, 전일동향 및 전망을 분석하여 파악한다. 수집한 정보와 자료를 종합하고 선물, 옵션시장의 지수, 가격 및 시세변동을 실시간으로 파악하여 수익성을 예측한다. 선물옵션매매시스템을 검사·선별하여 국내 선물·옵션시장의 전반적인 움직임을 파악한다. 종목별 매매가와 거래량 등의 추이 및 시황을 분석한다. 선물옵션 투자전략을 수립하며, 투자기법을 개발한다. 다양한 거래구조와 상품을 조합하여 신상품 적용가능성을 검토하고 시장상황에 기초하여 신상품을 개발한다. 거래시스템의 구축을 지원하고 각종 조사분석결과를 정보로서 제공한다. 분석 및 연구결과를 인터넷상에 공개하거나 기업경제연구소 및 기관에 제공하기도 한다. 선물옵션거래에 관련한 컨설팅을 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"금융공학연구원, 파생상품투자전략가, 파생상품연구원","dJobECd":"0311","dJobECdNm":"[0311]투자·신용 분석가","dJobJCd":"2721","dJobJCdNm":"[2721]투자 및 신용 분석가","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002944:1', '{"dJobCd":"K000002944","dJobCdSeq":"1","dJobNm":"애널리스트","workSum":"국내외 금융시장 정보를 수집·분석·예측하여 소속 금융사 또는 일반 투자자에게 투자자문을 제공한다.","doWork":"국내외 경제상황 및 산업·기업별 정보를 수집·분석한다. 환경변화에 따라 담당산업을 전망한다. 주식 및 채권보고서, 경제예측, 거래량, 금융잡지, 증권편람, 회사재무제표 등을 활용하여 회사, 주식, 채권 및 기타 투자에 대한 정보를 수집한다. 산업전망에 따라 주식 및 파생상품 시장의 관계를 분석하고 동향을 분석한다. 개별기업들의 영업환경 및 주요 자금운용계획, 재무분석 등을 통해 향후 수익 및 주가를 전망한다. 저평가된 기업들의 적정주가를 다양한 평가방법으로 재산정한다. 종목별 또는 상품별 매매가와 거래량 등의 추이 및 시황을 분석하여 주식 및 파생상품 투자전략을 수립한다. 분석결과를 보고서로 작성하고 발표한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"설득","workFunc3":"관련없음","connectJob":"담당 분야에 따라 증권애널리스트(증권투자분석가), 파생상품애널리스트(파생상품투자분석가), 투자애널리스트, 펀드애널리스트, 계량분석가(퀀츠), 퀀츠디벨로퍼","dJobECd":"0311","dJobECdNm":"[0311]투자·신용 분석가","dJobJCd":"2721","dJobJCdNm":"[2721]투자 및 신용 분석가","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003622:1', '{"dJobCd":"K000003622","dJobCdSeq":"1","dJobNm":"은행개인금융심사역","workSum":"은행 개인대출담당자가 요청한 심사요청 내용의 적정성을 판단하여 개인금융 취급 여부를 결정한다.","doWork":"개인고객의 신용도 적정성을 검토한다. 개인고객의 자금용도 적정성을 검토한다. 개인고객의 담보제공 가능성 및 적정성을 검토한다. 심사요청서의 적정성을 검토한다. 대출취급 적정성을 판단한다. 대출심사승인서를 전산시스템에 입력한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","similarNm":"개인금융CO(Credit Officer)","dJobECd":"0311","dJobECdNm":"[0311]투자·신용 분석가","dJobJCd":"2721","dJobJCdNm":"[2721]투자 및 신용 분석가","dJobICd":"K649","dJobICdNm":"[K649]기타 금융업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006386:1', '{"dJobCd":"K000006386","dJobCdSeq":"1","dJobNm":"은행기업금융심사보조역","workSum":"은행에서 기업금융심사역이 기업금융 취급가능 여부를 판단할 수 있도록 심사기초자료를 작성한다.","doWork":"기업고객의 계량 및 비계량 부문 분석을 위한 기초자료를 작성한다. 기업고객의 사업성(산업 동향 분석 및 미래 예측, 경쟁기업 분석, 시장점유율 예측 등) 및 적정성 분석을 위한 기초자료를 작성한다. 기업고객의 미래 현금흐름(Cash Flow)분석을 위한 기초자료를 작성한다. 기업고객 신용분석 및 신용부족분 보완방안 검토를 위한 기초자료를 작성한다. 기업금융상담역이 작성한 심사요청서를 사전 분석한다. 작성한 기초자료를 심사승인시스템에 입력한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","similarNm":"기업금융CA(Credit Assistant)","connectJob":"중소기업금융을 전담하는 경우 중소기업금융CA, 특수금융을 전담하는 경우 특수금융CA","certLic":"공인회계사, 신용위험분석사(Credit Risk Analyst), 신용분석사, AICPA(American Institude of Certified Public Accountant)","dJobECd":"0311","dJobECdNm":"[0311]투자·신용 분석가","dJobJCd":"2721","dJobJCdNm":"[2721]투자 및 신용 분석가","dJobICd":"K641","dJobICdNm":"[K641]은행 및 저축기관","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001308:1', '{"dJobCd":"K000001308","dJobCdSeq":"1","dJobNm":"은행기업금융심사역","workSum":"은행에서 기업금융고객상담역이 요청한 기업금융심사요청서의 적정성 및 기업금융 취급가능 여부를 심사한다.","doWork":"기업고객의 계량 및 비계량부문을 분석한다. 기업고객의 사업성(산업 동향 분석 및 미래 예측, 경쟁기업 분석, 시장점유율 예측 등) 및 적정성 분석을 한다. 기업고객의 미래 현금흐름(Cash Flow) 분석을 한다. 기업고객 신용분석 및 신용부족분 보완방안을 검토한다. 기업금융상담역이 작성한 심사요청서의 적정성을 심사한다. 기업금융승인시스템에 심사내용을 입력한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","similarNm":"기업금융CO(Credit Officer)","connectJob":"중소기업금융을 전담하는 경우 중소기업금융CO, 특수금융을 전담하는 경우 특수금융CO","certLic":"공인회계사, 신용위험분석사(Credit Risk Analyst), 신용분석사, AICPA(American Institude of Certified Public Accountant)","dJobECd":"0311","dJobECdNm":"[0311]투자·신용 분석가","dJobJCd":"2721","dJobJCdNm":"[2721]투자 및 신용 분석가","dJobICd":"K641","dJobICdNm":"[K641]은행 및 저축기관","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003143:1', '{"dJobCd":"K000003143","dJobCdSeq":"1","dJobNm":"자본시장분석가","workSum":"금융산업·금융제도의 변화, 금리변동의 전망, 주식·채권 및 파생상품시장의 전망, 현안문제 등을 분석하여 중장기 투자전략 수립에 필요한 기초자료를 제공한다.","doWork":"국내외 금융시장의 동향을 파악하고 금융정보를 수집·분석한다. 금융산업에 대한 동향을 분석하고 금융제도를 연구한다. 은행산업, 주식시장, 채권시장, 파생상품시장(선물옵션시장)에 대한 연구를 수행한다. 금리 및 환율 동향에 대한 자료를 수집·분석하고 향후 금리예측 및 환율예측을 제공한다. 금융산업의 장기적인 발전방안에 대해 연구한다. 금융 관련 학술회에 참가하여 정보를 수집하고 연구결과를 발표한다. 연구결과를 바탕으로 경제전문서적을 출간하거나 강연을 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","similarNm":"금융시장분석가, 이코노미스트","dJobECd":"0311","dJobECdNm":"[0311]투자·신용 분석가","dJobJCd":"2721","dJobJCdNm":"[2721]투자 및 신용 분석가","dJobICd":"K","dJobICdNm":"[K]금융 및 보험업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002001:1', '{"dJobCd":"K000002001","dJobCdSeq":"1","dJobNm":"주식시장투자전략가","workSum":"주식시장을 분석·예측하여 투자전략을 수립하고 투자종목을 선정한다.","doWork":"국내외 산업동향을 분석하고 신기술개발 등의 정보를 수집하여 주가를 예측한다. 주식매매시스템을 통해 증권시장 동향을 파악한다. 정보네트워크를 통해 국내외 증시데이터 및 정보를 수집한다. 시황분석자료를 검토하고 경제변수(환율, 물가, GDP, 수출입증가율 등) 및 시장변수(주가지수, 거래량 등)를 분석한다. 분석결과를 토대로 손절매(손실매도)전략, 포트폴리오 구성방법(주식과 현금 분배), 비중조절에 따른 분할매수 등의 투자전략 및 추천종목을 대내외에 발표한다. 인터넷상으로 투자전략을 강의하고 관련 정보를 제공한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0311","dJobECdNm":"[0311]투자·신용 분석가","dJobJCd":"2721","dJobJCdNm":"[2721]투자 및 신용 분석가","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002327:1', '{"dJobCd":"K000002327","dJobCdSeq":"1","dJobNm":"주식시황분석원","workSum":"주식시장의 전반적인 시세 및 거래동향, 신용 및 예탁금 추이 등을 분석·종합하여 전반적인 시황을 분석한다.","doWork":"코스피 차트를 통하여 지수변동을 분석한다. 원달러 및 엔달러 환율의 변화, 국제유가 변화, 매수상위종목, 대차거래내역, 미국국채 수익률 등 주식시장의 전반적인 현황과 움직임을 분석한다. 각각의 개별매매가 동향, 종목별거래량 등의 추이를 바탕으로 시황을 분석하고 결과표를 작성하여 관련 부서에 송부한다. 개별장세와 전반장세를 종합하여 연·월·주일별로 시황을 분석하고 지수 변동요인을 검토한다. 결과표를 작성하여 인터넷 혹은 증시 관련 자료를 통해 정보를 제공한다. 시황 문의에 답변한다. 주식종목에 대한 등락예측을 하여 주식투자 컨설팅을 하며 인터넷 온라인회사에 정보를 제공하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"시황분석가","dJobECd":"0311","dJobECdNm":"[0311]투자·신용 분석가","dJobJCd":"2721","dJobJCdNm":"[2721]투자 및 신용 분석가","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001582:1', '{"dJobCd":"K000001582","dJobCdSeq":"1","dJobNm":"증권분석사","workSum":"경제동향을 비롯하여 기업의 재무상태나 신용도 등의 정보를 근거로 유가증권을 분석한다.","doWork":"특정 유가증권의 본질적인 가치에 관한 자료를 수집한다. 일정한 기준을 사용하여 해당 증권의 수익성이나 유동성을 파악하여 그 가치를 매긴다. 주가등락을 수리적, 과학적인 방법을 동원해 논리적으로 측정하고 보고서를 작성한다. 일반투자자나 기관투자자들에게 보고서를 배포하여 투자정보를 제공한다. 분석자료를 정리·요약하고, 재무구조 등의 개선방향을 기업이나 고객에게 제시하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"교육","workFunc3":"수동조작","similarNm":"증권분석가, 애널리스트","dJobECd":"0311","dJobECdNm":"[0311]투자·신용 분석가","dJobJCd":"2721","dJobJCdNm":"[2721]투자 및 신용 분석가","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005986:1', '{"dJobCd":"K000005986","dJobCdSeq":"1","dJobNm":"해외증시동향분석원","workSum":"해외증권시장의 정보를 수집하여 동향을 분석하고 전망한다.","doWork":"해외증권시장 동향에 대한 전일금일시장정리, 장중 변동데이터, 해외주요지수, 지수 및 업종현재가, 등락률 현황, 주가지수선물, 해외DR(Depositary Receipts, 주식예탁증서, 국제간에 걸친 주식의 유통수단으로 이용되는 대체증권) 시세정보를 검색하고 번역·요약한다. 해외주요 경제지표를 검색·작성하여 데이터베이스에 입력·관리한다. 해외증권시장 제도 및 해외뉴스를 조사·관리한다. 조사분석한 내용을 보고서로 작성하여 발간물이나 신문방송 등을 통해 증권관계자 및 투자자에게 정보로서 제공한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"0311","dJobECdNm":"[0311]투자·신용 분석가","dJobJCd":"2721","dJobJCdNm":"[2721]투자 및 신용 분석가","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004332:1', '{"dJobCd":"K000004332","dJobCdSeq":"1","dJobNm":"개인자산관리사","workSum":"고객들의 자산관리에 대해 조언하고, 투자방법에 대한 정보를 제공한다.","doWork":"고객들의 재무상태를 파악한다. 각종 금융상품, 주식, 부동산 등의 투자대상을 고객에게 추천한다. 고객의 특성에 맞는 자산관리방법을 개발한다. 고객들이 원하는 재무목표를 달성할 수 있도록 계획을 수립한다. 새로운 금융상품이나 투자처에 대해 조사 및 연구한다. 고객에게 수익률과 만기시점을 알려준다. 고객들의 세금을 줄일 수 있는 절세방법과 자산관리에 대하여 상담하고 조언한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"설득","workFunc3":"관련없음","similarNm":"개인자산운용가, 고객자산관리운용가","connectJob":"금융자산관리사, 부동산자산관리사","dJobECd":"0312","dJobECdNm":"[0312]자산 운용가","dJobJCd":"2722","dJobJCdNm":"[2722]자산 운용가","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006022:1', '{"dJobCd":"K000006022","dJobCdSeq":"1","dJobNm":"금융회사자산운용가","workSum":"금융회사의 고유자산을 안정적으로 유지 및 증식하기 위하여 회사 명의로 각종 금융투자 및 부동산투자를 한다.","doWork":"금융회사(은행, 보험사, 증권회사 등)의 주식, 채권, 선물옵션 및 부동산 등 자산을 운용하기 위하여 국내외 증권시장 및 선물옵션 등 파생상품 시장의 정보 및 기업분석보고서 등 각종 자료와 정보를 수집·분석·종합한다. 국내 코스피(KOSPI)동향, 코스닥(KOSDAQ), 부동산 동향 등 관련 제반 정보들을 파악하고 투자 및 운용계획을 수립한다. 전산시스템을 통하여 실시간으로 국내외의 주식, 채권 및 선물옵션시장 등 금융시장의 동향을 분석한다. 낮은 위험으로 높은 수익을 창출할 수 있도록 투자전략을 세운다. 세워진 투자전략에 따라 주식, 선물옵션을 매입하거나 매도한다. 전산시스템을 통하여 실시간으로 자산운용의 결과를 분석한다. 정기적으로 운용결과를 보고한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"유가증권자기매매운용가, 증권딜러","dJobECd":"0312","dJobECdNm":"[0312]자산 운용가","dJobJCd":"2722","dJobJCdNm":"[2722]자산 운용가","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005942:1', '{"dJobCd":"K000005942","dJobCdSeq":"1","dJobNm":"부동산펀드매니저","workSum":"고객의 투자를 유치하여 부동산 관련 펀드를 개발·운용한다.","doWork":"아파트, 빌딩, 토지, 상가 등의 부동산 투자전략 및 운영계획을 수립한다. 부동산 시장정보를 습득하고, 부동산의 시장성과 적정가치를 평가한다. 향후 수익가능성이 높은 부동산을 공개구입 또는 경매를 통해 입찰한다. 부동산 구조 및 설비를 조사하고 부동산 가치를 평가한다. 투자자를 모집하고 펀드를 상장한다. 부동산을 운영하고 수익을 투자자에게 배분한다. 펀드를 개발하여 부동산개발회사에 투자한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0312","dJobECdNm":"[0312]자산 운용가","dJobJCd":"2722","dJobJCdNm":"[2722]자산 운용가","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005395:1', '{"dJobCd":"K000005395","dJobCdSeq":"1","dJobNm":"선물자산운용가","workSum":"선물시장에서 선물회사 혹은 증권사 자체의 투자자산이나 고객이 투자를 위탁한 자산을 운용한다.","doWork":"딜링룸(Dealing Room:매매 및 거래전용 사무실)에서 뉴스나 방송으로부터 국내외 산업정보를 수집하고 분석한다. 거래준비를 위해 여러 대의 컴퓨터 정보단말기의 작동 여부를 확인하고 거래명세서, 타이머 등 업무에 필요한 장비와 도구를 준비한다. 컴퓨터 정보단말기를 통하여 시간대별 현재가, 기준가, 시가, 고가, 거래량, 거래금액, 체결가, 전일비, 매도호가, 매수호가 등 종목별 상세현황을 분석한다. 전일의 국내외 선물시장동향, 시장주도종목 등을 분석한다. 국내외 선물시장의 시황을 실시간 파악하고 분석하여 매입, 매수타이밍을 예측한다. 선물시장의 지수, 가격 및 시세변동을 실시간으로 파악하고 가격변동추이를 분석하는 각종 통계프로그램을 이용하여 수익성을 예측하여 최적의 수익률이 예측되는 시점에 주문을 낸다. 선물회사 혹은 증권사 자체의 투자자산이나 고객이 투자를 위탁한 자산을 기초로 하여 매매이익을 목적으로 선물시장에서 거래되는 통화선물 및 옵션, 금리선물, 상품선물(금, 농산물), 옵션, 주가지수선물 등의 선물상품을 매입하거나 매도하는 투자행위를 수행한다. 투자결과를 종합하여 수익률과 배당률을 통계하여 전산프로그램에 관리한다. 거래가 마감되면 거래결과에 대하여 동료들과 논의하며 거래상의 문제점 등을 보완·수정하며 시황차트를 분석하여 익일거래에 대비한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","similarNm":"파생상품투자운용가, 선물거래사","dJobECd":"0312","dJobECdNm":"[0312]자산 운용가","dJobJCd":"2722","dJobJCdNm":"[2722]자산 운용가","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003511:1', '{"dJobCd":"K000003511","dJobCdSeq":"1","dJobNm":"신탁자산관리운용원","workSum":"신탁운용사(채권과 주식을 매매하고 펀드를 관리하는 펀드매니저가 있는 회사)에 소속되어 신탁자산을 관리·운용한다.","doWork":"신탁업무 전반에 대한 이해를 바탕으로 신탁자산의 관리 및 운용업무에 대한 추진방향을 설정한다. 펀드별 자산배분 및 운용전략을 수립한다. 신용분석, 시장분석을 통하여 장단기 신탁자금운용계획을 수립한다. 국내외 투자 및 운용부문에 대한 조정, 통제업무를 수행한다. 신탁운용에 관련한 금융제도 및 국내 신탁운용사에 대한 정보와 자료를 수집·분석·연구한다. 신탁자금수지계획에 따라 장단기 신탁자금의 환금성, 안전성, 수익성 등을 조합하여 최대의 자금효율을 높일 수 있는 전략을 수립한다. 자산운용사 선정을 위한 시장조사를 하여 운용사를 선정한다. 성과분석, 투자적정성 검토, 수익률 제고를 위한 회의를 한다. 신탁투자수익률을 높이기 위하여 신탁자산운용제도의 개선을 제안한다. 펀드별로 신탁수익률을 평가하고 특정금전신탁의 수익률을 관리하며 수익률 변동원인 분석 및 제고방안을 검토한다. 수익률이 저조하거나 수익전망의 하락이 예측되는 투자상품의 실적을 검토하여 투자원금을 회수한다. 신탁고객의 대출요구에 따라 대출을 관리하는 업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0312","dJobECdNm":"[0312]자산 운용가","dJobJCd":"2722","dJobJCdNm":"[2722]자산 운용가","dJobICd":"K642","dJobICdNm":"[K642]신탁업 및 집합투자업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004166:1', '{"dJobCd":"K000004166","dJobCdSeq":"1","dJobNm":"증권사사모투자펀드운용원","workSum":"증권사에서 사모펀드(Private Equity Fund:특정기업의 주식을 대량 인수해 경영에 참여하는 방식의 펀드)를 운용한다.","doWork":"M&A(기업인수합병) 및 CR(기업구조조정) 관련 주관 획득을 위한 제반 업무를 수행한다. M&A 및 CR의 주관업무를 수행한다. M&A 관련 투자 및 금융자문 관련 제반 업무를 수행한다. 기타 기업분할, 주식교환 등의 주관업무 획득을 위한 제반 업무와 주관업무를 수행한다. 공개매수 관련 제반 업무를 수행한다. SPAC((Special Purpose Acquisition Company:특수인수목적회사)의 운용, 합병에 관련된 제반 업무를 수행한다. PEF(Private Equity Fund:사모투자펀드)구조를 설계한다. PEF출자자를 모집한다. PEF설립등기를 한다. 금융위원회에 출자승인 및 등록한다. 관할세무서에 사업자등록을 한다. 기타 PEF설립과 관련된 업무를 수행하여 PEF설립을 완료한다. PEF자산운용(투자대상기업의 발행주식총수 또는 출자총액의 10% 이상이 되도록 하는 투자, 임원의 임면 등 투자대상기업의 주요 경영사항에 대하여 사실상 지배력 행사가 가능하도록 하는 투자, 기타 법령에 의해 허용된 투자)업무를 수행한다. PEF의 운영 및 계산업무를 수행한다. 자본시장과 금융투자업에 관한 법률 또는 PEF정관에 의한 통지 및 공고업무를 수행한다. PEF 해산 시 청산인 및 청산감독인의 지시에 따라 행하는 일반사무관리업무를 수행한다. PEF투자금 회수, PEF투자대상기업 관리, PEF청산업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","dJobECd":"0312","dJobECdNm":"[0312]자산 운용가","dJobJCd":"2722","dJobJCdNm":"[2722]자산 운용가","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006421:1', '{"dJobCd":"K000006421","dJobCdSeq":"1","dJobNm":"증권사장외파생금융상품운용원","workSum":"증권사에서 장외파생금융상품을 투자자의 이익을 위하여 정해진 투자목적에 맞게 운용한다.","doWork":"장외파생금융상품(거래소를 통하지 않고 쌍방 간의 협정에 따라 거래되는 파생상품)의 구조설계를 한다. 장외파생금융상품 운용 및 헷징(Hedging:자신의 이익을 가격변동위험으로부터 보호하고자 이미 보유하고 있거나 보유할 예정인 현물포지션에 대응하여 동일한 수량의 반대포지션을 선물시장에서 취하는 것)을 위한 상품운용을 한다. 장외파생금융상품(장외옵션, 장외주식, 해외옵션, 해외주식, 해외선물, 해외채권)을 운용하고 운용에 수반되는 외환거래업무를 수행한다. 주식 및 파생상품을 전략적으로 매매하거나 유동성 공급을 위해 매매한다. 외부공시 관련 문서를 작성한다. 장외파생금융상품 신상품을 개발한다. 장외파생금융상품 판매를 지원하고 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","similarNm":"OTC운용원(Over The Counter derivatives)","dJobECd":"0312","dJobECdNm":"[0312]자산 운용가","dJobJCd":"2722","dJobJCdNm":"[2722]자산 운용가","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;