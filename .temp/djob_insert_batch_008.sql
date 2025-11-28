INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004711:1', '{"dJobCd":"K000004711","dJobCdSeq":"1","dJobNm":"공사견적관리자","workSum":"건설공사의 발주 또는 수주 등의 목적으로 공사비 산출업무를 수행하는 공사견적원의 활동을 감독·조정한다.","doWork":"공사발주처로부터 접수된 입찰도서 및 현장설명에서 수집한 정보를 파악하여 입찰참가 여부를 결정한다. 공사규모와 입찰준비기간 등을 고려하여 견적팀을 구성하고 세부적인 견적사항을 지시한다. 견적서류를 입찰담당부서에 전달하고 관계부서장과 협의하여 낙찰가능한 입찰금액을 예상하고 손익분석을 통해 입찰금액을 확정한다. 외부용역기관에 위탁하여 견적예상금액을 산출하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"감독","workFunc3":"관련없음","similarNm":"공사입찰관리자, 견적관리자","dJobECd":"1402","dJobECdNm":"[1402]건축공학 기술자","dJobJCd":"2312","dJobJCdNm":"[2312]건축공학 기술자","dJobICd":"F411/F412/F421","dJobICdNm":"[F411]건물 건설업 / [F412]토목 건설업 / [F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001370:1', '{"dJobCd":"K000001370","dJobCdSeq":"1","dJobNm":"국가유산보수감리원","workSum":"국가유산 보수의 전 과정이 설계도서, 관련 법령을 포함한 관계규정 및 기술지도에 따라 시행되는지 확인·관리·감독한다.","doWork":"보수국가유산의 설계도면, 공사시방서, 설계내역서를 검토한다. 설계기준 및 보수기준에 따라 품질과 안전을 확보하여 보수공사가 시행될 수 있도록 관리한다. 보수공사현장에서 안전, 환경, 자재, 품질, 공정, 인력 등이 설계도서대로 시행되는지 점검하고 기술을 지도한다. 설계도서에서 정한 규격 및 치수 등에 대하여 육안검사, 측량, 입회, 승인, 시험 등의 방법으로 검측업무를 수행한다. 보수계획, 설계도서, 전통기법, 국가유산수리 표준시방서, 국가유산수리 표준품셈, 현장검토사항, 관련 법령, 감리업무수행지침 등에 따라 감리를 실시하고 감리보고서를 작성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"문화재수리기술자","dJobECd":"1402","dJobECdNm":"[1402]건축공학 기술자","dJobJCd":"2312","dJobJCdNm":"[2312]건축공학 기술자","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003930:1', '{"dJobCd":"K000003930","dJobCdSeq":"1","dJobNm":"녹색건축인증심사전문가","workSum":"친환경건축물인증신청에 대해 관련규정에 적합한지 심사한다.","doWork":"공동주택, 복합건축물, 업무용건물 기타건축물(학교, 숙박, 판매 등)에 대한 녹색건축인증 신청자의 예비인증, 본인증, 연장신청에 대해 신청자가 제출한 서류를 검토한다. 심사대상인 건축물에 대한 현장실사를 실시한다.  건축물과 관련된 토지이용, 교통, 에너지, 재료 및 자원, 수자원, 환경오염, 유지관리, 생태환경, 실내환경 등의 평가항목별로 평가기준에 따라 배점을 부여한다. 평가항목별 점수를 합산한 결과에 따른 인증결과를 인증운영기관과 의뢰자(건축주, 설계사 등)에 통보한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"협의","workFunc3":"관련없음","similarNm":"녹색건축인증심사위원, , 그린빌딩인증심사위원, 그린빌딩평가전문가","dJobECd":"1402","dJobECdNm":"[1402]건축공학 기술자","dJobJCd":"2312","dJobJCdNm":"[2312]건축공학 기술자","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004798:1', '{"dJobCd":"K000004798","dJobCdSeq":"1","dJobNm":"녹색건축인증컨설턴트","workSum":"건축주 또는 시공사가 국내외 녹색건축인증을 취득할 수 있도록 설계, 자재, 시공과정을 진단하고 인증기준을 충족할 수 있는 해결책을 제시한다.","doWork":"그린빌딩(친환경건축물) 관련 인증을 취득하고자 하는 고객에게 녹색건축인증, 주택성능등급, 건축물에너지효율등급, 제로에너지건축물인증, 리드(LEED)인증, BREEAM인증 등 그린빌딩(친환경건축물) 관련 국내외 인증의 대상, 절차, 인증등급과 기준에 대해 설명하고 설계에 반영될 수 있도록 한다. 고객에게 필요한 인증의 종류와 등급, 인증취득의 효과 및 인센티브, 소요비용에 대해 상담한다. 고객의 의뢰에 따라 그린빌딩인증 심사평가의 기준과 절차를 충족하는 설계기법, 자재, 설비 등에 대한 기술적 자문을 비롯하여 서류준비에 대해 자문한다. 고객을 대행하여 인증기관에 인증심사신청을 하고 심의과정에 필요한 서류의 준비·제출, 보고서 작성을 수행하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","similarNm":"그린빌딩인증컨설턴트, 친환경건축물인증컨설턴트","dJobECd":"1402","dJobECdNm":"[1402]건축공학 기술자","dJobJCd":"2312","dJobJCdNm":"[2312]건축공학 기술자","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002958:1', '{"dJobCd":"K000002958","dJobCdSeq":"1","dJobNm":"빌딩정보모델링(BIM)매니저","workSum":"프로젝트의 성격과 특수성을 감안하여 최적의 발주방식을 결정하며, 계약관리, 설계관리, 시공관리, 안전관리, 리스크관리, 유지관리 등 프로젝트 전반에 걸쳐 BIM컨설턴트로서 역할을 한다.","doWork":"BIM프로토콜 및 BIM 구현계획 초안작성과 관련된 모든 건설 및 설계 관련자와 계약 및 작업준비에 대한 업무를 한다. 발주처와 협의하여 프로젝트의 BIM콘텐츠를 승인 및 결정한다. BIM프로세스의 진행과정을 계획하고 모니터링하며 필요한 프로세스와 시스템, 참여자의 구현을 발주 및 재검토한다. 조직 내에서 BIM교육을 진행하고 프로세스 변경에 개입한다. 참여자에 대해서 BIM에 관한 업무, 책임 및 권한을 부여하며, 설계실무자와 시공실무자들과 전략적, 전술적, 운영적 차원에서 인원을 구성하고 프로젝트 전 과정에서 협업하도록 권장한다. 프로젝트 템플릿을 배포하고 팀의 기술을 지원하며, 작업자 간의 효율적인 협력을 도모한다. 현장의 상황을 파악하고 발주처를 대신해서 보고 및 결정한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"BIM컨설턴트","dJobECd":"1402","dJobECdNm":"[1402]건축공학 기술자","dJobJCd":"2312","dJobJCdNm":"[2312]건축공학 기술자","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002559:1', '{"dJobCd":"K000002559","dJobCdSeq":"1","dJobNm":"빌딩정보모델링(BIM)엔지니어","workSum":"BIM 저작 툴(Tool)과 분석 툴(Tool)을 활용하여 건설정보모델과 데이터를 구축하고 공종별로 필요한 모델링을 하며 도면제작 및 시공에 필요한 분석을 하여 IT응용프로그램의 제작작업을 한다.","doWork":"건물 Modeling과 Data를 구축하고 변경 및 확장서비스를 한다. 설계와 건설공종마다 필요한 템플릿과 객체라이브러리를 제작하기도 하고 매개변수를 통한 데이터관리를 한다. 3D모델링 기반에 2D도면화 제작기술과 3D시각화 도면화 기술, 다양한 건설공종별로 필요한 시공모델링과 시공도면 제작기술을 정의한다. 관련 프로그램을 활용하여 BIM 모델링 해석 및 분석업무(도면정합성 분석, 시공성분석, 에너지분석, 간섭체크, 물량산출률 등)를 지원 및 수행한다. 프로젝트 수행과정에 필요한 응용프로그램을 개발하여 설계나 시공단계의 업무의 효율성을 향상시킨다. 3D모델링 및 Data 제작 및 도면작업과정에서 BIM코디네이터와 BIM매니저에게 지속적으로 보고한다. 발주처, 설계자, 시공자 및 제작업체 등과 지속적으로 Data 호환작업과 협업을 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"BIM모델러, BIM테크니션, 건설정보관리자, BIM엔지니어(건축구조, 토목), BIM엔지니어(전기), BIM엔지니어(설비)","certLic":"전산응용건축제도기능사, 건축기사, 건축설비기사, 전기기사 등","dJobECd":"1402","dJobECdNm":"[1402]건축공학 기술자","dJobJCd":"2312","dJobJCdNm":"[2312]건축공학 기술자","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006442:1', '{"dJobCd":"K000006442","dJobCdSeq":"1","dJobNm":"빌딩정보모델링(BIM)코디네이터","workSum":"BIM프로젝트에서 체계적이고 기술적인 수준의 BIM 특정구성을 조정하고 건설의 다양한 공정과 공종의 책임자들과 함께 협업하여 최적인 대안과 기술방법을 제안한다.","doWork":"프로젝트 추진에 앞서 BIM도입의 타당성과 적절성을 분석한다. BIM도입에 따른 BIM소프트웨어 선정과 인력 투입시기를 계획한다. 별도의 개발기술과 응용기술 파트에 대한 부분도 계획한다. BIM소프트웨어 간의 호환성이나 소통형식에 대한 부분을 체계적으로 매뉴얼하고, 작업자의 협업과 소통에 대한 내부관리시스템을 계획한다. 현장내부 및 외부 BIM실무자의 기술인력수요를 확인하고 투입시기 등을 적절히 판단한다. 별도의 기술제안에 따른 문제와 매뉴얼을 확인하고 관리한다. 다양한 건설 관련 공정 및 공종에 참여하는 BIM엔지니어들의 업무를 관리한다. 공정 및 공종 간의 충돌과 간섭을 파악하고, 최적의 기술적 대안과 방향을 제시하여 원활한 설계와 현장업무가 진행되도록 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"BIM기술협업총괄관리자","connectJob":"BIM컨설턴트","dJobECd":"1402","dJobECdNm":"[1402]건축공학 기술자","dJobJCd":"2312","dJobJCdNm":"[2312]건축공학 기술자","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003877:1', '{"dJobCd":"K000003877","dJobCdSeq":"1","dJobNm":"익스테리어디자이너","workSum":"기존 건물 또는 신축건물들의 외관, 외벽, 색채, 조경 등의 여러 요소를 디자인한다.","doWork":"입면디자인 용역공고가 나오면, 디자인제안서를 작성해 입찰에 참여하거나 신축건물 설계도면에 외벽관련 요소 디자인에 참여한다. 프로젝트를 수주하면 고객의 요구를 반영해 디자인을 수정·보강하여 설계안을 확정한다. 신축건물의 경우 설계안에 건물외부 디자인을 하여 전체 설계안과 함께 확정한다. 건물의 골조가 세워지고 외벽 등의 공사가 진행되면 색채업체, 조명업체 등과 조율하여 설계안대로 외관공사가 진행되도록 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1402","dJobECdNm":"[1402]건축공학 기술자","dJobJCd":"2312","dJobJCdNm":"[2312]건축공학 기술자","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001551:1', '{"dJobCd":"K000001551","dJobCdSeq":"1","dJobNm":"인공암벽시설설계기술자","workSum":"인공암벽시설(실내외에 인공으로 만들어진 암벽구조물)을 설계한다.","doWork":"인공암벽시설계획서 및 계획도면을 작성하여 발주자에게 설명하고 발주자의 요구사항을 반영하여 시공계약을 체결한다. 설치장소의 환경을 조사·분석하고 설계에 필요한 국내외 인공암벽설계자료와 국제대회규정 등을 수집한다. 설계의도를 구체화하여 인공암벽의 높이, 다양한 경사의 변화, 루트, 확보물, 표면의 재질 및 색채, 바닥, 홀드부착지점 등을 설계한다. 아동용, 볼더링용, 대회용, 빙벽용, 전망대 등을 설계한다. 인공암벽패널을 디자인하고 제작도면을 작성한다. 관련 법규와 기준, 사업성, 개략공사비, 공사비내역, 자재, 시공성 등을 검토하여 설계에 반영한다. 공간, 조형, 동선, 배치 등을 설계한다. 설계도면과 설계설명서 등을 작성한다. 시공이 설계대로 진행되는지 확인하고 시공품질을 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1402","dJobECdNm":"[1402]건축공학 기술자","dJobJCd":"2312","dJobJCdNm":"[2312]건축공학 기술자","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006899:1', '{"dJobCd":"K000006899","dJobCdSeq":"1","dJobNm":"친환경건설연구원","workSum":"건설과정에서 발생하는 이산화탄소를 최소화하고 건설폐기물을 감소시킬 수 있는 기술과 방안을 연구·개발한다.","doWork":"건설과정에서 배출되는 이산화탄소를 최소화하고 건설폐기물을 감소시키기 위해 친환경자재의 사용 및 활성화, 폐기물 최소화 건설공법, 시공 중 발생할 수 있는 건설자재 등의 자원낭비감소설계기법, 고효율에너지설비의 도입, 정보통신(IT)기술을 이용한 건설현장관리기술과 방법 등을 연구·개발한다. 기타 연구원(일반)들이 수행하는 일반적인 활동을 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"친환경건축생산연구원","dJobECd":"1402","dJobECdNm":"[1402]건축공학 기술자","dJobJCd":"2312","dJobJCdNm":"[2312]건축공학 기술자","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004182:1', '{"dJobCd":"K000004182","dJobCdSeq":"1","dJobNm":"친환경건축연구원","workSum":"에너지와 자원을 절약하고 환경오염을 줄이는 자연친화적이고 쾌적한 친환경건축을 연구·개발한다.","doWork":"쾌적한 거주환경을 위해 건축물의 실내공기질 환경(공기순환, 청정방법 등) 및 실내외 소음·진동의 저감, 빛환경 등에 대해 연구한다. 환경오염방지와 자원절약을 위한 저에너지소모형 빗물·중수 재사용설비의 건축물 적용에 대해 연구한다. 친환경건축자재, 단열재 및 고효율 단열방법에 대해 연구한다. 자연광 또는 신·재생에너지의 건축물 적용에 대해 연구한다. 기타 연구원(일반)들이 수행하는 일반적인 활동을 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"친환경건축연구개발자, 친환경건축물연구원","connectJob":"그린홈연구원, 친환경건축프로젝트관리자","dJobECd":"1402","dJobECdNm":"[1402]건축공학 기술자","dJobJCd":"2312","dJobJCdNm":"[2312]건축공학 기술자","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001253:1', '{"dJobCd":"K000001253","dJobCdSeq":"1","dJobNm":"플랜트프로젝트사업관리자","workSum":"플랜트 EPC(Engineering, Procurement, Construction) 프로젝트 계약자가 계약에 정한 요구조건을 충족한 플랜트를 발주자에게 인도하기 위하여 프로젝트 계획을 수립하고 관리하는 업무를 수행한다.","doWork":"플랜트 분야의 내·외부 경영자원을 결합하여 사업전략계획서를 작성하고 사업타당성을 분석하여 성공적인 사업 착수를 실현하기 위한 사업제안서를 작성한다. 플랜트 프로젝트 통합 관리를 통해 분업화한 설계, 조달, 공사 업무를 원활하게 협업 가능하도록 조정하며 프로젝트 제약 조건을 트레이드 오프(Trade-Off)하여 프로젝트 관리 절차서, 프로젝트 수행 계획서, 프로젝트 성과 보고서, 프로젝트 종료 보고서 등을 작성한다. 플랜트 프로젝트 계약 관리, 공정관리, 원가관리, 품질관리를 수행한다. 프로젝트 목표 달성을 위해 인적자원관리 및 조직원의 성과평가를 하며, 프로젝트의 정보를 포함한 공문서 및 외주 계약 문서관리를 포함한 의사소통관리를 한다. 프로젝트 목표달성에 영향을 주는 리스크를 식별하여 대응 및 통제하며, 플랜트프로젝트 보건안전 환경관리를 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"1402","dJobECdNm":"[1402]건축공학 기술자","dJobJCd":"2312","dJobJCdNm":"[2312]건축공학 기술자","dJobICd":"F41/M721","dJobICdNm":"[F41]종합 건설업 / [M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005147:1', '{"dJobCd":"K000005147","dJobCdSeq":"1","dJobNm":"건설재료연구원","workSum":"교량, 도로, 항만, 건물 등의 건설에 따른 건설재료의 특성, 용도, 시험, 계측 및 재료역학에 관한 사항과 기타 품질관리에 관한 사항을 연구·개발하고 기술지원을 한다.","doWork":"건설현장에 사용되는 재료에 대한 시험 및 계측을 한다. 콘크리트의 동결, 융해 및 동탄성계수를 측정·분석하여 재료의 성능을 개선한다. 콘크리트 Creep시험, 온도에 따른 수축변화, 투수성, 중화성 등을 시험한다. 금속재료의 인장력, 단열재의 열전도율, 아스팔트혼합물 현장시험 및 배합설계, 말뚝(Pile)의 동재하시험 및 건설부자재의 물리성능 등을 시험하고 성능개선을 위한 연구를 수행한다. 기타 연구원(일반)들이 수행하는 일반적인 활동을 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|시각|","workFunc1":"종합","workFunc2":"자문","workFunc3":"설치","similarNm":"건설자재연구원, 건설자재시험연구원","certLic":"건설재료시험기사, 콘크리트기사","dJobECd":"1403","dJobECdNm":"[1403]토목공학 기술자","dJobJCd":"2313","dJobJCdNm":"[2313]토목공학 기술자","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002778:1', '{"dJobCd":"K000002778","dJobCdSeq":"1","dJobNm":"도로공항설계기술자","workSum":"도로 및 교통, 도로구조물, 도로부대시설, 공항시설 및 부대시설, 기타 도로와 공항에 관한 사항에 대한 계획, 설계, 분석, 시험, 운영, 시공, 평가 또는 이에 관한 지도, 감리 등의 기술업무를 수행한다.","doWork":"도로 및 공항의 건설을 위한 기본방향 설정, 공정계획 수립, 인원투입 계획, 실행예산서 작성 등 설계수행계획(Engineering Execution Plan)을 수립한다. 현안파악, 교통수요예측, 대안노선설정, 부대시설, 구조물계획수립 등의 타당성을 조사한다. 주요 구조물(교량, 터널, 교차로 등)의 형식과 개략적인 건설방법을 결정하고 공사비를 추정하고 공정계획을 수립하여 기본설계를 한다. 기본설계에 따라 세부설계인 실시설계도서와 관련 서류를 작성한다. 노선특성, 비교노선 선정·평가, 교량형식·토공구조물 등을 비교·분석하여 기술제안을 한다. 시공에 따른 현장의 설계도면 변경·민원처리의 대책방안 등의 기술지원과 설계도서·문서·기술자료 등을 관리한다. 유지관리에 대한 공법제공·포장상태점검·유지보수에 대한 계획이나 방안제시 등의 업무를 한다. 의뢰에 의해 감리업무를 하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"협의","workFunc3":"관련없음","connectJob":"공항활주로설계원, 고속도로설계원, 국도설계원, 업무에 따라 공항토목설계기술자, 도로토목설계기술자, 교량토목설계기술자","dJobECd":"1403","dJobECdNm":"[1403]토목공학 기술자","dJobJCd":"2313","dJobJCdNm":"[2313]토목공학 기술자","dJobICd":"F412/M721","dJobICdNm":"[F412]토목 건설업 / [M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007158:1', '{"dJobCd":"K000007158","dJobCdSeq":"1","dJobNm":"도로포장기술자","workSum":"일반도로 및 고속도로, 활주로 등을 포장하기 위해 설계도에 따라 아스팔트 또는 콘크리트를 포설하고 다지는 작업원의 활동을 조정하고 감독한다.","doWork":"설계도 또는 작업지시서를 확인하고 작업에 따른 예정공정표를 작성하고 조정한다. 포장에 필요한 각종 자재를 파악하고 구입계획과 절차서를 작성한다. 수송장비의 용량, 작업현장의 조건 등을 감안하여 건설장비의 종류를 파악하고 공정에 따른 장비확보상황을 확인한다. 각종 건설기계운전원 및 포장 관련 작업원들의 안전교육을 실시한다. 공사일정에 맞추어 작업진행 속도, 작업원의 배치 및 자재·장비투입일정을 조정한다. 포장의 재료, 설계강도, 두께 등을 확인한다. 도로포장작업원의 활동을 감독·지휘한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"손사용|시각|","workEnv":"소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","similarNm":"도로포장관리자","connectJob":"활주로를 포장하는 경우 활주로포장기술자","certLic":"토목산업기사, 건설재료시험산업기사, 콘크리트산업기사","dJobECd":"1403","dJobECdNm":"[1403]토목공학 기술자","dJobJCd":"2313","dJobJCdNm":"[2313]토목공학 기술자","dJobICd":"F412","dJobICdNm":"[F412]토목 건설업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005784:1', '{"dJobCd":"K000005784","dJobCdSeq":"1","dJobNm":"매립가스플랜트시공기술자","workSum":"매립가스로부터 전기를 생산하기 위한 발전소 플랜트의 주요 구조물을 시공한다.","doWork":"매립가스(Landfill Gas) 플랜트의 주요 구조물(보일러 건물, 터빈발전기 건물, 냉각탑, 주제어 건물, 환경설비 건물, 옥외변전소 등)을 설치하고 각각의 기능을 원활히 연결하는 기본적인 시스템을 시공한다. 설계내용을 바탕으로 플랜트의 토목공사, 각 구조물의 건축공사 등을 관리·감독한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"매립가스소각시설시공기술자, 매립가스소각로시공기술자","dJobECd":"1403","dJobECdNm":"[1403]토목공학 기술자","dJobJCd":"2313","dJobJCdNm":"[2313]토목공학 기술자","dJobICd":"F412","dJobICdNm":"[F412]토목 건설업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007197:1', '{"dJobCd":"K000007197","dJobCdSeq":"1","dJobNm":"상수도관망시설운영관리사","workSum":"정수장에서 생산된 수돗물을 안전하고 안정적으로 수용가까지 공급하기 위해 상수관로를 비롯한 관련 시설물을 조사진단하여 계획을 수립하고 상수도관망 및 그 부속시설을 운영유지관리한다.","doWork":"송배수급관로, 배수지펌프장, 급수설비, 부속설비 등 상수도관로 운영관리 계획을 수립한다. 상수도관로, 부속시설에 대한 위치, 속성, 이력 자료를 수집하여 전산화하고 원격감시제어시스템을 활용한다. 상수도관로의 체계적 관리와 블로시스템 구축, 관망정비계획 수립을 위해 상수도관로, 밸브류, 유압계, 펌프장, 급수전, 수용가 등 상수도관로시설을 조사탐색한다. 세부계획수립. 수리적 안정성 검토 등을 통해 상수도관로 블록시스템을 구축하고 운영한다. 상수도관로배수지펌프장 등 송배급시설을 기술기준을 준수하면서 운영관리한다. 정수장에서 처리한 수돗물을 공급하는 과정에서 공급량과 사용량을 수집비교하여 유수율을 분석하고 누수탐사를 통하여 누수지점을 개선한다. 수질을 체계적으로 감시하여 수돗물을 안전하게 공급하기 위한 대책수립 등 수질관리를 한다. 펌프, 밸브, 전기설비, 계측제어설비, 감시제어설비 등 상수도관로 기계설비 및 계측제어설비를 점검정비하여 유지관리한다. 상수도관로 수리적, 구조적안전성, 수질적정성 등을 평가하여 상수도 관로의 문제점, 원인을 분석하고 개선방안을 수립하는 시설진단을 한다. 상수도관을 보수, 갱생, 교체 등 유지관리한다. 수돗물의 수질을 유지하기 위하여 상수도관내 침전물이나 슬라임을 제거하는 등 세척한다. 정전설비사고, 자연재해, 누수사고, 돌발단수발생 등 비상시를 대비하여 사전예방 및 사후대처하는 업무를 한다. 상수도관로 운영유지관리를 위하여 관련 기술규정, 기준, 법규, 기술을 파악하고 단수수계전환 계획을 시행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실외","physicalAct":"균형감각|청각|","workEnv":"소음·진동|","workFunc1":"분석","workFunc2":"감독","workFunc3":"제어조작","similarNm":"상수도관망관리사","connectJob":"상수도관망시설기계기술자, 상수도관망시설전기기술자, 상수도관망시설계측제어기술자, 상수도관망시설관로시설점검원","certLic":"상수도관망시설운영관리사1, 2급, 토목기사, 수질환경기사","dJobECd":"1403","dJobECdNm":"[1403]토목공학 기술자","dJobJCd":"2313","dJobJCdNm":"[2313]토목공학 기술자","dJobICd":"E360/F412/M721","dJobICdNm":"[E360]수도업 / [F412]토목 건설업 / [M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003985:1', '{"dJobCd":"K000003985","dJobCdSeq":"1","dJobNm":"상하수도설비기술자","workSum":"효과적인 상수도 공급과 위생적인 하수관리를 위하여 상·하수시설에 관련된 계획을 수립하고 설계, 안전점검 및 감리업무를 수행한다.","doWork":"상하수도사업계획을 시행하기 위하여 관련 자료의 수집·조사 및 현장답사를 통해 설계방향, 규모, 외관 등을 기획·설계한다. 시설물의 사용계획, 시설설비, 규모, 비용 등을 산출한다. 시공할 때 발생하는 문제점들을 해결하기 위한 보완책 마련 및 설계변경 등을 한다. 현장의 기술지원, 사전검토를 통하여 문제요인을 방지하고 안전점검을 한다. 상수도망을 계획할 때에는 개발지역의 도시계획, 장기개발계획, 상수도계획 등 관련 기초자료를 조사하고 현지측량 및 시설물을 조사한다. 취수장이나 가압펌프장, 중수도(처리수 재이용), 하수처리장, 산업폐수처리장 등의 운영에 대한 기술진단·기술개발을 한다. 상하수도 관련 공사에 대한 감리업무를 하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"손사용|시각|","workFunc1":"조정","workFunc2":"협의","workFunc3":"정밀작업","similarNm":"상하수도기술자","connectJob":"상수도계획기술자, 수자원개발설비기술자","certLic":"도로및공항기술사, 토목기사, 상하수도기술사","dJobECd":"1403","dJobECdNm":"[1403]토목공학 기술자","dJobJCd":"2313","dJobJCdNm":"[2313]토목공학 기술자","dJobICd":"F412/M721","dJobICdNm":"[F412]토목 건설업 / [M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005739:1', '{"dJobCd":"K000005739","dJobCdSeq":"1","dJobNm":"상하수도연구원","workSum":"양질의 수돗물 생산 및 공급을 위하여 상하수도 관련 관로, 시설물, 처리방법 등에 대해 실용적이고 경제적인 기술 및 방법을 연구·개발한다.","doWork":"국내외의 상하수도 처리현황 및 추세를 파악하고, 국내에 적합한 상수도시설 및 처리방법과 운영방법에 대한 기초연구를 한다. 정수 및 하수처리방안을 연구한다. 송·배수시스템 운영관리기술을 개발한다. 지하수원과 지표수원의 이용 및 수질개선 방안, 중수도 개발 및 표준화 방안을 연구한다. 누수방지, 배·급수관 부식방지, 관로 내 수질변화 등에 관하여 연구한다. 전력설비의 표준화 및 유지·관리의 효율성 제고를 위하여 연구한다. 기초연구에서 도출된 기술 및 설계를 기본으로 분석장치 및 실험장치를 이용하여 실용화를 위한 운전지침서, 설계지침서를 작성한다. 공사비, 유지관리비 등 경제성 검토 및 경쟁력 있는 기술을 개발하여 국내외 관련 시설에 기술을 적용하고, 제반 기술을 제공한다. 기타 연구원들이 수행하는 일반적인 활동을 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workEnv":"소음·진동|","workFunc1":"종합","workFunc2":"자문","workFunc3":"정밀작업","similarNm":"설계용역, 개발연구","certLic":"수질환경기사, 상하수도기술사, 일반기계기사, 정밀측정산업기사, 전기기사, 소음진동기사 등","dJobECd":"1403","dJobECdNm":"[1403]토목공학 기술자","dJobJCd":"2313","dJobJCdNm":"[2313]토목공학 기술자","dJobICd":"E360","dJobICdNm":"[E360]수도업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003835:1', '{"dJobCd":"K000003835","dJobCdSeq":"1","dJobNm":"수자원개발기술자","workSum":"하천, 하천구조물, 댐, 수력구조물, 지하수이용시설 등과 같은 수자원개발분야에 대한 고도의 전문지식과 실무경험을 바탕으로 상수원개발시설, 지하수이용시설, 하천시설 및 관계설비에 대한 설계, 시험, 운영, 시공, 평가 또는 이에 관한 지도, 감리 등의 업무를 수행한다.","doWork":"수자원개발에 따른 하천, 하천구조물, 댐, 수력구조물 등의 정비 및 개발에 따른 관련 자료를 수집·분석하고 현장실사를 통하여 주변환경에 미치는 환경평가, 경제성 등 타당성을 검토한다. 조사, 수집, 검토된 자료를 근거로 하천정비, 하천환경, 댐건설, 광역상수원개발, 하천구조물, 운하 등에 대한 기본계획·설계를 수립한다. 시공에 따른 상세도서를 작성한다. 시공 시 발생하는 문제점을 보완·점검하고 기술적인 지원을 한다. 새로운 수자원개발기법을 개발하고 소규모 대상유역에 대한 실험을 하여 결과보고서를 작성하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"종합","workFunc2":"협의","workFunc3":"관련없음","connectJob":"댐토목설계기술자, 배수관로토목설계기술자","certLic":"토목산업기사, 토목기사","dJobECd":"1403","dJobECdNm":"[1403]토목공학 기술자","dJobJCd":"2313","dJobJCdNm":"[2313]토목공학 기술자","dJobICd":"F412/M721","dJobICdNm":"[F412]토목 건설업 / [M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006417:1', '{"dJobCd":"K000006417","dJobCdSeq":"1","dJobNm":"수자원시설지반구조연구원","workSum":"다목적댐, 용수전용댐, 지하댐, 도수터널, 광역지질, 지하수 등 수자원시설의 지반구조를 설계하고 관련 연구를 수행한다.","doWork":"다목적댐, 용수전용댐, 지하댐, 도수터널 등 수공구조물의 지반조사, 수치해석 등을 통하여 수자원시설 지반의 안정성을 평가하고, 보안방안 및 대책을 수립하기 위하여 연구한다. 지하수의 위치, 수량, 영향범위와 온천수에 대한 조사를 통해 지하수 이용의 효율적 관리방안을 연구한다. 토질지반·구조·재료·지질분야의 기술개발을 위한 연구를 한다. 현존하는 수자원시설물의 안전성 평가를 통한 유지, 관리 및 효율적 운영을 위한 방안을 연구한다. 수공구조물의 안전성 평가를 위하여 내진성능평가, 보링조사, 관입시험, 비중, 밀도, 함수비 등에 대하여 시험·분석한다. 수공구조물의 설계 및 시공기법을 개발한다. 다목적댐의 거동분석 및 안전도를 평가한다. 수자원시설물의 동적 해석을 한다. 기타 연구원(일반)들이 수행하는 일반적인 활동을 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"종합","workFunc2":"자문","workFunc3":"정밀작업","certLic":"응용지질기사, 토목기사, 측량및지형공간정보기사","dJobECd":"1403","dJobECdNm":"[1403]토목공학 기술자","dJobJCd":"2313","dJobJCdNm":"[2313]토목공학 기술자","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006758:1', '{"dJobCd":"K000006758","dJobCdSeq":"1","dJobNm":"원전토건기술연구원","workSum":"원자력발전소의 각종 건축구조물이 내·외부의 영향으로부터 안전하게 설계되어 시공되도록 도면의 타당성 검토와 시공에 따른 기술지원을 위한 제반 연구를 수행한다.","doWork":"원자력발전을 위한 안전한 건축구조물이 되기 위하여 부지 및 주변환경에 대한 평가를 한다. 선정된 부지의 지진력평가, 지진방재 및 응용지질에 관한 조사, 분석을 통하여 안전성이 확보되었는지 분석·연구한다. 분석한 지진 관련 자료를 근거로 내진설계 및 내진검증, 내진해석에 대한 안전성을 검증한다. 수리해석을 통하여 안전한 수공구조물이 되도록 설계한다. 원자력발전설비의 가동으로 인한 진동 및 소음, 외부영향 등이 구조물에 미치는 파급효과를 분석하여 대처방안을 연구한다. 구조물에 대한 해석, 설계 및 실증시험을 통한 대처기술을 개발하고 구조물에 대한 수명관리, 구조성능평가를 한다. 원자력발전소에 사용되는 건설재료 및 시공기술에 대한 연구와 온배수저감시설에 대한 설계를 한다. 기타 원자력발전소의 각종 구조물 및 건축물에 대한 안전성 확보를 위한 연구 및 개발업무를 수행한다. 기타 연구원(일반)들이 수행하는 일반적인 활동을 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"웅크림|손사용|시각|","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","certLic":"토목기사, 건축기사, 건설재료시험기사","dJobECd":"1403","dJobECdNm":"[1403]토목공학 기술자","dJobJCd":"2313","dJobJCdNm":"[2313]토목공학 기술자","dJobICd":"F412","dJobICdNm":"[F412]토목 건설업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003875:1', '{"dJobCd":"K000003875","dJobCdSeq":"1","dJobNm":"유역수리연구원","workSum":"국토의 하천, 지표면 등 모든 공간에 존재하는 수자원을 효율적으로 관리하기 위한 방안을 연구한다.","doWork":"수자원의 효율적 관리를 위하여 하천정보의 표준화 방안을 연구한다. 홍수로부터 위험을 예방하고 국토를 효율적으로 관리하기 위하여 하천지역의 범람수위를 분석하여 홍수위험지도 제작 및 지침을 개발한다. 하천의 수량 및 수질을 분석하기 위한 수리·수문분석시스템을 개발한다. 홍수로부터 위험을 예방하고 피난경로 등을 제시하기 위한 모델을 개발한다. 강우수치예보자료, 기상위성 및 레이더자료 등을 활용하여 효율적 다목적댐의 치수능력향상에 대한 연구를 한다. 인구증가에 따른 용수수요량 예측, 수자원 공급시설 분석을 통한 물수지 분석, 국토의 지하수 개발 및 이용에 관한 연구, 하천 및 저수지의 수질관리기술개발, 저수지 및 하류하천의 탁수관리를 통한 수자원계획 및 개발기법 등을 연구한다. 기타 연구원(일반)들이 수행하는 일반적인 활동을 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"수리시설물연구원, 수문공학연구원","connectJob":"연안수리시설연구원, 농업수리시설연구원","certLic":"토목기사, 측량 및 지형공간정보기사","dJobECd":"1403","dJobECdNm":"[1403]토목공학 기술자","dJobJCd":"2313","dJobJCdNm":"[2313]토목공학 기술자","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002529:1', '{"dJobCd":"K000002529","dJobCdSeq":"1","dJobNm":"유역수생태연구원","workSum":"수리시설물이 주변환경 및 생태계에 미칠 영향을 분석하기 위하여 실제와 같은 모형을 설치하고 시험한다.","doWork":"수리시험장의 펌프시설, 조석발생장치, 하천유발장치, 파도발생장치 등을 운영·관리한다. 댐, 수로 및 해안수리구조물의 개발 및 관리에 관한 수리시험연구를 한다. 하천, 해안개발 및 보존에 관한 수리환경분야의 실험연구를 한다. 수리분야의 모형실험을 통하여 얻은 기술을 농업 관련 기관에 제공한다. 수리분야의 국제기술을 수집하고 관리한다. 기타 연구원(일반)들이 수행하는 일반적인 활동을 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"종합","workFunc2":"자문","workFunc3":"정밀작업","similarNm":"수리시설물시험연구원","connectJob":"연안수리시설시험연구원, 농업수리시설시험연구원","certLic":"토목기사, 수질환경기사, 해양환경기사","dJobECd":"1403","dJobECdNm":"[1403]토목공학 기술자","dJobJCd":"2313","dJobJCdNm":"[2313]토목공학 기술자","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005703:1', '{"dJobCd":"K000005703","dJobCdSeq":"1","dJobNm":"전력구조물연구원","workSum":"수력, 화력, 원자력, 송·변전 등 전력구조물의 안전성 및 내구성 향상을 위하여 연구, 개발 및 기술지원업무를 수행한다.","doWork":"전력구조물의 구조재료 및 부재의 성능시험, 진동시험 등을 통해 내진해석 및 설계, 구조물의 내진성능평가 및 내진검증업무를 수행한다. 전력구조물에 대한 해석, 설계 및 실증시험을 통한 대처기술을 개발하여 지원한다. 전력구조물에 적합한 구조재료 개발, 경년열화(장기간에 걸쳐서 사용한 부품의 물리적 성질이 열화하는 것) 및 수명관리, 구조건전성평가, 구조물 보수 및 보강기술 등에 대한 연구를 수행한다. 전력구조물의 구조시스템 개선 및 개발, 구조물 계측 및 안전감시, 구조물 부식 및 방식분야 기술개발 및 연구를 수행한다. 전력구조물 안전점검 및 정밀안전진단 등 기술지원을 한다. 각종 전력구조물 및 건축물에 대한 안전성 확보를 위한 연구 및 개발업무를 수행한다. 기타 연구원(일반)들이 수행하는 일반적인 활동을 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|손사용|시각|","workEnv":"위험내재|소음·진동|","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","connectJob":"전력구조물안전성연구원","certLic":"토목기사, 건축기사, 건설재료시험기사","dJobECd":"1403","dJobECdNm":"[1403]토목공학 기술자","dJobJCd":"2313","dJobJCdNm":"[2313]토목공학 기술자","dJobICd":"F412","dJobICdNm":"[F412]토목 건설업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002078:1', '{"dJobCd":"K000002078","dJobCdSeq":"1","dJobNm":"지열시스템천공기술자","workSum":"지열시스템 설계도에 따라 천공수, 천공구경, 천공간격, 지중순환루프(Loof) 등이 제대로 설치되도록 시공 감독한다.","doWork":"지중열교환기 설계공법과 현장상황을 파악하고 장비, 부대장비, 기자재 확보 등 공정계획이 적절하게 추진될 수 있도록 준비한다. 지중해석 프로그램을 이용한 시뮬레이션을 통해 지중열교환기설치부의 지반조사가 끝나면 가장 적절한 천공위치를 결정한다. 드릴링작업으로 보어홀 (Bore Hole) 천공작업을 하고 지중열교환기 및 그라우트주입파이프를 설치한다. 일정깊이의 구멍을 파며 냉난방부하에 따라 구멍의 지름과 천공수를 정한다. 천공의 사이가 일정간격 이상 떨어지도록 한다. 스탠딩컬럼형 지중열교환기 시공의 경우는 천공공벽과 내부케이싱(지열교환파이프)의 적정 간격을 유지하여 지하수 순환이 원활하도록 설치하고 지표오염물질이 들어가지 않도록 밀폐식보호덮개를 씌운다. 밀폐식지중열교환기 시공의 경우 천공된 구멍 안으로 U자형 PE관을 삽입 후 그라우팅재료를 상향식으로 주입하여 구멍을 메운다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"웅크림|손사용|시각|","workEnv":"대기환경미흡|소음·진동|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"지열시스템그라우팅원","dJobECd":"1403","dJobECdNm":"[1403]토목공학 기술자","dJobJCd":"2313","dJobJCdNm":"[2313]토목공학 기술자","dJobICd":"F412","dJobICdNm":"[F412]토목 건설업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003706:1', '{"dJobCd":"K000003706","dJobCdSeq":"1","dJobNm":"철도설계기술자","workSum":"고속철도, 일반철도, 도시철도, 전용철도, 광역철도, 지하철 등 철도의 개량과 신규건설에 따른 타당성 조사를 실시하고 철도설계를 한다.","doWork":"철도설계를 위해 교통환경영향평가서, 토질·기초설계도, 터널설계도, 교통흐름도 등을 참고한다. 지하터널이나 장대교량 등 철도 관련 특수구조물 및 작은 시설물 등 단순구조물을 설계한다. 각종 철도의 계량 및 신규건설에 따른 차량기지건설 등의 사업에 대해 계획단계에서 설계까지 전 과정에 걸쳐 컨설팅을 하기도 한다. 철도시공 시 시공감리를 담당하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","connectJob":"고속철도설계기술자, 일반철도설계기술자, 지하철도설계기술자, 경량철도설계기술자","certLic":"토목기사, 건축기사, 측량 및 지형공간정보기사","dJobECd":"1403","dJobECdNm":"[1403]토목공학 기술자","dJobJCd":"2313","dJobJCdNm":"[2313]토목공학 기술자","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006787:1', '{"dJobCd":"K000006787","dJobCdSeq":"1","dJobNm":"토목감리원","workSum":"도로, 철도, 댐, 지하철, 항만 등의 토목건설에 있어서 품질관리, 예산관리, 공정관리의 목표를 달성하기 위해 시공의 모든 과정을 확인·관리·감독한다.","doWork":"착수회의를 통해서 감리방법, 감리방향 등을 수립한다. 설계도서와 시방서에 의거하여 시공이 이루어졌는지 여부를 체크리스트 등으로 점검한다. 지정된 재료를 사용하거나 요구되는 품질을 확보하는지 파악하기 위해 시험에 입회하며 시험결과를 비교한다. 문제점이 생기면 이를 발주자에게 보고하고 시공자에게 시정을 요청한다. 관련법령 및 계약내용대로 시공되는지 여부를 검측·확인한다. 건설공사 전 과정의 공정, 원가, 품질, 안전, 환경관리 등에 대한 기술지도를 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"감독","workFunc3":"관련없음","similarNm":"토목감리기술자, 감리원","certLic":"토목기술사, 토목(산업)기사, 건설재료시험(산업)기사","dJobECd":"1403","dJobECdNm":"[1403]토목공학 기술자","dJobJCd":"2313","dJobJCdNm":"[2313]토목공학 기술자","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005546:1', '{"dJobCd":"K000005546","dJobCdSeq":"1","dJobNm":"토목견적원","workSum":"토목공사의 발주 또는 수주 등의 목적으로 공사비를 산출하는 업무를 수행한다.","doWork":"공사발주처로부터 시방서, 도면 및 단가설명서 등의 입찰도서를 접수하여 그 내역을 검토한다. 정보를 수집하여 공사 입찰방법, 경쟁업체 등을 파악한다. 전산기준에 맞게 정확한 수량을 산출하고 이상 유무를 확인·수정한다. 각종 견적서를 취합하고, 공사의 입찰결과 분석자료를 활용하여 낙찰가능한 입찰금액을 파악한다. 공사규모에 따른 적정한 인원구성을 산출하고 견적에 적용하여 전체적인 공사비를 산출한다. 입찰내역서, 협력업체 등 입찰 관련 서류를 작성한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"견적원, 적산원, 건축견적원, 건축적산원","certLic":"토목기사, 토목산업기사","dJobECd":"1403","dJobECdNm":"[1403]토목공학 기술자","dJobJCd":"2313","dJobJCdNm":"[2313]토목공학 기술자","dJobICd":"F412/F421","dJobICdNm":"[F412]토목 건설업 / [F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004463:1', '{"dJobCd":"K000004463","dJobCdSeq":"1","dJobNm":"토목공무기술자","workSum":"토목공사 기획 및 계약, 공사현장의 운영, 설계변경, 기성관리, 견적업무, 공사비 및 공사자원관리, 준공 후 사후관리 등 토목공사 수행을 위한 기술적, 관리적 업무를 한다.","doWork":"착공단계에서 사무실을 개설하고 공동도급회사 간 계약이해에 관련되는 상호약정사항을 협의하고 확정하며 착공 시 필요한 인허가신고업무 등 현장착공관리를 한다. 설계도서 간의 상호모순된 항목을 정정하고 현장여건과 상이한 항목을 수정보완하는 등 설계적정성 검토를 한다. 공사에 실제 투입되는 예정원가를 산출하고 도급변경에 따라 변경투입예정원가를 산출하며 관리한다. 실정보고를 통한 설계변경 시 수량 및 단가산출서, 내역서 등을 작성하고 계약금액 조정 시 변경금액을 산출하는 등 계약을 관리한다. 효율적인 인력, 자재 및 장비관리와 적재적소에 자원이 전·출입될 수 있도록 현장자원을 관리한다. 하도급업체에 위탁할 때 필요한 입찰, 계약, 기성집행 등을 관리한다. 공정 및 원가에 대한 자료를 분석·작성하여 사업단위별 손익상태를 관리한다. 사업종료에 따른 정산, 완료보고, 사후관리 등 현장준공을 관리한다. 공사진행과 관련한 이해당사자, 발주처 및 사용자 등의 민원처리 및 예방 등 고객관리를 한다. 하자발생에 대한 기술적, 행정적 관리를 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workEnv":"소음·진동|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"건설공무기술자","certLic":"토목기사, 토목산업기사","dJobECd":"1403","dJobECdNm":"[1403]토목공학 기술자","dJobJCd":"2313","dJobJCdNm":"[2313]토목공학 기술자","dJobICd":"F411/F412","dJobICdNm":"[F411]건물 건설업 / [F412]토목 건설업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001378:1', '{"dJobCd":"K000001378","dJobCdSeq":"1","dJobNm":"토목구조연구원","workSum":"도로, 철도, 교량, 댐, 지하철, 항만 등 토목분야의 구조물에 발생하는 구조적 현상이나 구조물의 거동을 예측하고 실험하여 안전성 및 실용성을 확보할 수 있도록 이론과 실제를 연구한다.","doWork":"토목의 구조공법의 개발을 위한 실험을 한다. 구조물의 부재실험을 통하여 구조의 안전성을 실험하고 문제에 대한 대처방안을 제시한다. 공법에 대한 시공실험을 통하여 실용성을 검증한다. 각 공법의 경제적인 측면, 환경적인 측면 등 타당성을 분석·검토한다. 기타 연구원(일반)들이 수행하는 일반적인 활동을 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"웅크림|손사용|시각|","workFunc1":"종합","workFunc2":"자문","workFunc3":"정밀작업","similarNm":"구조연구기술자","certLic":"토목기사, 토목구조기술사","dJobECd":"1403","dJobECdNm":"[1403]토목공학 기술자","dJobJCd":"2313","dJobJCdNm":"[2313]토목공학 기술자","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005515:1', '{"dJobCd":"K000005515","dJobCdSeq":"1","dJobNm":"토목시공기술자","workSum":"사업계획에 따라 토목공사의 공정계획을 수립하고 토목구조물과 각종 설비가 공정대로 시공되도록 공사과정에서 기술적 관리를 한다.","doWork":"사업계획에 의하여 공사일정, 설계일정, 공사기간 등 단위공사의 기본계획을 작성하고 단위공사의 소요예산, 설계추진일정, 기본상세업무를 추진한다. 기전(機電) 및 건축, 기타 당해설비의 규모, 기능, 하중 등을 파악하여 토목시설물의 규모, 형태 등이 소관설비의 사양에 적합한가를 검토·판단한다. 경제성 등을 고려하여 토목시설물의 재료를 선택하고, 기기의 하중, 풍압 등의 조건에 적합한 구조를 결정하며, 색채, 외형 등이 균형과 조화를 이루도록 관리한다. 토목공사의 각 작업과정의 소요일정, 기전설비와의 연관관계 등을 검토하고, 작업의 우선순위·기후조건 등을 고려하여 종합공정표를 작성한다. 공정대로 공사가 진행되도록 자재, 인원, 장비의 투입 등 전반적인 공정을 검토·분석한다. 시공과정에서 기존공사의 사양변경이나 시공변경, 시공품질 등의 문제점을 검토하여 해결한다. 측량, 조사시험, 설계 등의 용역과 공사시공에 따른 과업지시서, 시공품의 중간검사, 설계변경, 준공검사 등과 시설공사의 감리업무 등 제반 행정처리업무를 수행한다. 조사시험기록의 통계유지, 공사기록지, 건설지 등을 작성·유지하고 제반 행정서류 등 문서이관작업을 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"손사용|시각|","workEnv":"위험내재|소음·진동|","workFunc1":"종합","workFunc2":"협의","workFunc3":"관련없음","similarNm":"토목공학기술자, 토목기술자","connectJob":"대상에 따라 APT토목시공기술자, 부지조성토목시공기술자, 도로건설토목시공기술자, 공항건설토목시공기술자, 교량건설토목시공기술자","certLic":"토목시공기술사, 토목(산업)기사, 콘크리트(산업)기사, 건설재료시험(산업)기사","dJobECd":"1403","dJobECdNm":"[1403]토목공학 기술자","dJobJCd":"2313","dJobJCdNm":"[2313]토목공학 기술자","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004474:1', '{"dJobCd":"K000004474","dJobCdSeq":"1","dJobNm":"토질기초설계기술자","workSum":"흙과 암석의 중요한 성질을 연구·분석하고 각종 구조물의 기초, 토류(土類)구조물 및 지하구조물에 대한 설계, 시공평가 및 감리 등의 기술적 업무를 수행한다.","doWork":"터널, 지하철, 매립지, 고층건물의 지하공간 등에 대한 시공 전이나 시공 중인 구조물의 안전한 시공을 위하여 지질, 토질, 암석 등에 관한 자료를 수집·분석한다. 현장조사를 통하여 터널, 지하공간, 굴착, 가설흙막이, 구조물의 기초지반조사, 지반사면의 안정성 등을 조사·분석한다. 분석된 자료를 토대로 구조물의 기초에 대한 기본계획 및 설계를 한다. 시공상에 적용할 연약지반의 개량공법, 지반계측의 관리, 암석·암반에 대한 처리방법 등을 계획하고 설계한다. 시공에 따르는 안전성 검사와 감리업무를 하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"협의","workFunc3":"관련없음","similarNm":"토목설계기술자","certLic":"토질및기초기술사, 지질및지반기술사, 토목기사","dJobECd":"1403","dJobECdNm":"[1403]토목공학 기술자","dJobJCd":"2313","dJobJCdNm":"[2313]토목공학 기술자","dJobICd":"F412/M721","dJobICdNm":"[F412]토목 건설업 / [M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002769:1', '{"dJobCd":"K000002769","dJobCdSeq":"1","dJobNm":"항만해안설계기술자","workSum":"항만 및 해안구조물의 건설 또는 보수를 위한 계획수립 및 설계를 하고 공사감리를 한다.","doWork":"항만의 외곽시설, 하역시설, 접안시설, 입항교통시설, 보안신호 및 기타 해안구조물의 건설목적과 특성을 파악하여 대상지역 중 최적입지를 선정한다. 대상지역의 지형, 수심, 지질, 조류, 파도, 조석간만의 차, 온도변화, 일조량 등 대상지역의 자연조건에 대한 자료를 수집한다. 대상지역과 인접지역의 취급화물량, 교통량추이, 인구동향, 수요량 변화추이 등을 추정한다. 수집된 자료를 분석하여 항만, 발전소 등 해양구조물의 규모, 형태를 결정하고 계획을 수립한다. 수립된 계획에 따라 기본설계를 하고 타당성과 경제성을 평가한다. 해상수치계산, 구조계산, 도면작성, 공사시방서작성, 공사물량계산, 현가에 의한 공사비산정 등 상세설계를 한다. 건설공사의 감리를 위해 설계와 시공에 대한 문제점을 검토하고, 설계도를 검토하여 과오설계에 대한 시정조언을 한다. 건설공정과 준공도면을 검토하여 발주자에게 공사에 대한 자문을 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"종합","workFunc2":"협의","workFunc3":"관련없음","similarNm":"항만토목설계기술자","connectJob":"수자원해양시설설계기술자","certLic":"항만및해안기술사, 토목(산업)기사, 건설재료시험(산업)기사","dJobECd":"1403","dJobECdNm":"[1403]토목공학 기술자","dJobJCd":"2313","dJobJCdNm":"[2313]토목공학 기술자","dJobICd":"F412/M721","dJobICdNm":"[F412]토목 건설업 / [M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004615:1', '{"dJobCd":"K000004615","dJobCdSeq":"1","dJobNm":"해상기초설계기술자","workSum":"지반조사, 물리적 탐사결과, 해양환경 조사데이터를 기준으로 해상기초구조물의 타입을 결정하며 풍향, 조류, 윈드터빈의 중량에 따른 하중을 산정하여 해양기초구조물을 설계한다.","doWork":"해양지반 및 수심, 계통연결을 고려한 규모산정, 변전소 연계거리, 수자원보호구역 및 항로회피, 주풍향의 횡방향과 종방향의 거리이격을 검토하여 로컬 및 글로벌풍량자원지도를 작성한다. 지반조사 및 기타 해양환경조사 데이터를 기준으로 기초구조물의 타입을 결정한다. 타입이 결정되면 기초구조물의 설계하중결정, 적정하중 예비검토, 구조적 공진검토, 극한상태 검토, 피로 검토 등 5단계 정밀구조해석을 수행한다. 윈드터빈 중량, 파고 및 조류에 관한 데이터를 통해 적정하중을 산정한다. 모든 설계데이터가 얻어지면 해양기초구조물을 해석하고 설계한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"수력구조물토목설계기술자, 하천구조물설계기술자","certLic":"토목기사, 토목산업기사","dJobECd":"1403","dJobECdNm":"[1403]토목공학 기술자","dJobJCd":"2313","dJobJCdNm":"[2313]토목공학 기술자","dJobICd":"F412","dJobICdNm":"[F412]토목 건설업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007337:1', '{"dJobCd":"K000007337","dJobCdSeq":"1","dJobNm":"화약류관리기술자","workSum":"각종 화약류 취급 및 발파에 관한 전문적인 지식을 토대로 건설현장 및 기타 시공현장에서 발파에 관련된 화약류 취급에 따른 기술적인 사항에 관한 업무를 수행한다.","doWork":"암반 및 지반의 특성에 따른 발파설계를 한다. 발파로 인한 진동·소음에 의한 영향평가를 한다. 석산현장의 발파기술을 지원한다. 각종 건축·토목시공현장, 광산현장 및 기타 시공현장의 발파패턴 설계 및 변경 등에 관한 타당성 검토를 하고 화약류관리 및 안전성 확보에 대한 관리 및 암반에 대한 분류, 특성, 평가를 하여 현장발파 관련 업무를 한다. 터널시공 시 계측·시험 등에 관한 종합적인 지원과 시공성 향상을 위한 기술습득 등과 같은 업무를 한다. 건물해체를 위한 발파계획을 수립하고 설계한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"힘든 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"화약관리원","connectJob":"화약발파기술자","certLic":"화약류관리기사, 화약류관리기술사, 1급화약류관리보안책임자","dJobECd":"1403","dJobECdNm":"[1403]토목공학 기술자","dJobJCd":"2313","dJobJCdNm":"[2313]토목공학 기술자","dJobICd":"F412","dJobICdNm":"[F412]토목 건설업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002841:1', '{"dJobCd":"K000002841","dJobCdSeq":"1","dJobNm":"수경연출디자이너","workSum":"수경 및 분수시설을 연출하고 디자인한다.","doWork":"전체 조경계획을 고려해 분수가 위치할 대상지에 대한 환경조사 및 분석을 실시하여 분수의 종류, 규모, 범위 등을 계획한다. 음악분수, 프로그램분수(음악분수와 유사하나 음악이 빠진 분수), 바닥분수, 고사분수, 인공폭포, 벽천, 계류 등의 수경시설 종류 중에서 기후, 주변의 사회적 환경 등을 고려하여 대상지에 적합한 수경시설을 결정한다. 연출목적에 따라 노즐의 구성, 사이즈, 관의 크기, 수압 등을 계산해 설계한다. 분수시설이 설치되는 연못, 호수, 수조 등의 담수량과 급·배수관경, 전기배선 등을 점검한다. 시공과정을 감리한다. 공사가 끝나면 수경시설이 제대로 동작하는지를 점검한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"청각|손사용|시각|","workFunc1":"분석","workFunc2":"협의","workFunc3":"정밀작업","similarNm":"분수설계기술자, 수경연출기술자","dJobECd":"1404","dJobECdNm":"[1404]조경 기술자","dJobJCd":"2314","dJobJCdNm":"[2314]조경 기술자","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005948:1', '{"dJobCd":"K000005948","dJobCdSeq":"1","dJobNm":"위락놀이시설디자이너","workSum":"테마파크(주제공원)안에 조성될 위락놀이시설을 위해 주제(테마) 및 콘셉트에 맞게 위락놀이시설을 설계ㆍ감리한다.","doWork":"테마파크(주제공원)안에 조성될 위락놀이시설을 위해 주제(테마) 및 콘셉트에 대한 아이디어를 얻기 위해 자연환경 및 인문환경 등에 대한 자료를 수집·분석한다. 아이디어 회의를 통해 구체적인 테마를 구상하고 설정한다. 위락놀이시설의 성격과 종류를 선정한다. 필요한 시설 및 소품을 기획하며, 디자인 및 구매와 관련하여 디자이너를 관리·감독하고 업무를 지시한다. 위락놀이시설 시공현장을 지휘하고 진행상황을 확인·조언한다. 위락놀이시설 방문고객의 반응 및 의견을 수렴하여 향후사업에 참고한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"청각|손사용|시각|","workFunc1":"종합","workFunc2":"협의","workFunc3":"관련없음","similarNm":"테마파크 놀이시설 설계기술자, 테마파크 놀이시설 디자이너","dJobECd":"1404","dJobECdNm":"[1404]조경 기술자","dJobJCd":"2314","dJobJCdNm":"[2314]조경 기술자","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002824:1', '{"dJobCd":"K000002824","dJobCdSeq":"1","dJobNm":"정원디자이너","workSum":"정원의 사용자, 부지 특성과 기후를 고려하여 정원의 공간 콘셉트 설정, 공간 구성디자인, 수목 및 초화 식재디자인, 시설물 및 장식물 배치 등을 하고 정원디자인에 맞춰 정원공사를 관리·감독하며, 정원의 지속을 위한 사후컨설팅 및 관리를 총괄한다.","doWork":"공원, 수목원, 상업용·주거용 부지 등 규모와 용도를 막론하고 모든 정원조성 대상 토지의 성격과 기후, 이용목적에 따른 정원의 유형과 콘셉트를 결정한다. 대상토지의 면적, 형상, 토양, 주변과의 조화, 기후, 식물생육환경, 토지이용 관련 법규상의 제한 등을 조사하며 정원 이용자의 취향과 식재환경을 조사한다. 이러한 조사자료를 바탕으로 정원의 공간구성을 하는 마스터플랜을 설계한다. 사계절 변화를 반영하여 나무 및 일년생, 다년생 초화 및 다양한 식물을 이용한 상세한 식재디자인을 한다. 정원에 필요한 수공간과 정원을 장식하는 정자, 게이트, 조명, 담, 화분, 정원가구, 기타 조형물을 배치한다. 정원의 디자인에 따라 정원시공계획표를 만들고 이에 따라 정원공사를 관리·감독한다. 완성된 정원의 수목·초화의 유지, 보완, 관리에 관한 컨설팅을 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"힘든 작업","workPlace":"실내·외","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"수동조작","connectJob":"식재디자이너, 수직정원디자이너, 실내정원디자이너","dJobECd":"1404","dJobECdNm":"[1404]조경 기술자","dJobJCd":"2314","dJobJCdNm":"[2314]조경 기술자","dJobICd":"F412","dJobICdNm":"[F412]토목 건설업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003949:1', '{"dJobCd":"K000003949","dJobCdSeq":"1","dJobNm":"조경감리원","workSum":"발주자가 요구하는 조경목적물이 의도대로 완성되도록 종합적 판단을 통해 조경사업의 설계 및 시공이 관련 도서 및 법규에 따라 제대로 수행되고 있는지 확인하고 관리한다.","doWork":"발주자의 의도와 지시를 파악한다. 조경사업 설계 및 시공이 관련 도서 및 법규에 따라 제대로 수행되고 있는지 대행, 위탁, 협력, 기술지원계약을 체결한다. 조경공사현장에서 최종심의, 승인 등의 업무를 수행한다. 설계변경, 각종 검사 시 현장감독자의 역할을 수행하며 서류작성 등 기술관리·지원업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"청각|손사용|시각|","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","similarNm":"조경기술관리자","connectJob":"국가유산조경수리기술자(조경)","certLic":"조경기술사, 국가유산수리기술자(조경)","dJobECd":"1404","dJobECdNm":"[1404]조경 기술자","dJobJCd":"2314","dJobJCdNm":"[2314]조경 기술자","dJobICd":"F412","dJobICdNm":"[F412]토목 건설업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002088:1', '{"dJobCd":"K000002088","dJobCdSeq":"1","dJobNm":"조경공무기술자","workSum":"조경공사 기획 및 계약, 공사현장의 운영, 설계변경, 기성관리, 견적업무, 공사비 및 공사자원관리, 준공 후 사후관리 등 조경공사 수행을 위한 기술적, 관리적 업무를 한다.","doWork":"착공단계에서 사무실을 개설하고 공동도급회사 간 계약이해에 관련되는 상호약정사항을 협의하고 확정하며 착공 시 필요한 인허가신고 업무 등 현장착공관리를 한다. 설계도서 간의 상호모순된 항목을 정정하고 현장여건과 상이한 항목을 수정 보완하는 등 설계적정성 검토를 한다. 공사에 실제 투입되는 예정원가를 산출하고 도급변경에 따라 변경투입예정원가를 산출하며 관리한다. 실정보고를 통한 설계변경 시 수량 및 단가산출서, 내역서 등을 작성하고 계약금액 조정 시 변경금액을 산출하는 등 계약을 관리한다. 효율적인 인력, 자재 및 장비관리와 적재적소에 자원이 전·출입될 수 있도록 현장자원을 관리한다. 하도급업체에 위탁할 때 필요한 입찰, 계약, 기성집행 등을 관리한다. 공정 및 원가에 대한 자료를 분석·작성하여 사업단위별 손익상태를 관리한다. 사업종료에 따른 정산, 완료보고, 사후관리 등 현장준공을 관리한다. 공사진행과 관련한 이해당사자, 발주처 및 사용자 등의 민원처리 및 예방 등 고객관리를 한다. 하자발생에 대한 기술적, 행정적 관리를 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"청각|손사용|시각|","workEnv":"소음·진동|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"조경건설공무기술자","certLic":"조경산업기사. 조경기사, 문화재수리기술자(조경), 자연생태복원산업기사, 자연생태복원기사","dJobECd":"1404","dJobECdNm":"[1404]조경 기술자","dJobJCd":"2314","dJobJCdNm":"[2314]조경 기술자","dJobICd":"F412","dJobICdNm":"[F412]토목 건설업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001874:1', '{"dJobCd":"K000001874","dJobCdSeq":"1","dJobNm":"조경관리기술자","workSum":"완공된 조경공간과 시설물을 아름다운 경관과 쾌적하고 안전한 환경으로 유지관리하기 위해 예술적, 공학적, 생태적 지식과 기술을 활용하여 유지 관리 업무를 수행한다.","doWork":"조경시설물관리주체(지자체 등), 조경전문회사, 단체 등과 조경유지관리계약을 체결한다. 조경시설의 종류, 설치목적, 규모, 재료 등을 파악하고 유지관리계획을 수립한다. 식재된 식물 및 조경시설물의 점검·보수, 수목의 전정(수목을 원하는 모양으로 유지시키면서 생장을 조절하기 위해 가지와 잎을 잘라내고 정리), 제초, 청소 등 조경공간의 기능을 유지하기 위한 활동을 한다. 운영관리(이용계획, 이용자 실태파악, 이용방법 지도, 이용프로그램 기획, 안전관리, 이용편의 개선, 민원관리 등)업무를 수행한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|손사용|시각|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"감독","workFunc3":"제어조작","similarNm":"관리기사, 시설기사","connectJob":"조경관리자, 조경수리자","certLic":"조경기사, 조경산업기사, 문화재수리기술자(조경), 자연생태복원기사, 자연생태복원산업기사, 문화재시공(조경)","dJobECd":"1404","dJobECdNm":"[1404]조경 기술자","dJobJCd":"2314","dJobJCdNm":"[2314]조경 기술자","dJobICd":"N743","dJobICdNm":"[N743]조경 관리 및 유지 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002731:1', '{"dJobCd":"K000002731","dJobCdSeq":"1","dJobNm":"조경설계사","workSum":"아름다운 경관과 쾌적한 환경을 조성하기 위해 예술적, 공학적, 생태적인 지식과 기술을 활용하여 조경대상지에 조사 분석, 기본구상, 계획, 설계 등 설계 업무와 프로젝트 개발, 도서작성, 프레젠테이션 등 설계 관련한 업무를 수행한다.","doWork":"조경사업의 중장기효과, 건축·토목 등 타 부문과의 조화를 고려하여 사업규모 및 방침을 수립한다. 지역별 최적의 조경설계기준을 설정한다. 국내외 우수조경사례, 관련 자료를 연구·검토하여 새로운 조경소재 도입 및 효율적인 조경시공기법을 개발한다. 조경대상지역의 토지이용 및 기상현황, 지형도, 존치시설, 경사분석도 등 현황표를 종합한다. 조경대상지를 실사하고 현장특성, 법적 제한사항 등 제반 여건을 고려하여 필요한 조경수목, 시설물 등을 결정한다. 배식도, 시설물 배치도 등의 시공도면을 작성하고 내역서를 산출한다. 지형적 위치, 토양, 식물의 성장도, 암석의 특성 등과 같은 대기조건에 관한 자료를 수집하고 분석한다. 시공계획에 의한 공정관리, 반입자재의 품질, 규격의 검수, 작업감독, 안전, 환경관리 등 제반 공사업무를 감독한다. 녹지대유지관리를 위한 제반 작업을 효율적으로 운용할 수 있는 작업체계 및 방침을 수립한다. 시공실적, 대규모단지 녹화관리사례, 기타 관련 자료를 연구·검토한다. 작업능률향상을 위하여 작업방법 개선, 기계화 및 새로운 관리기술 개발을 추진한다. 주요지역 녹지대를 순회점검하고 조치를 한다. 문화재 및 문화재보호구역의 전통조경물에 대해 역사성과 시대성에 부합되도록 고증자료를 근거로 설계·시공·관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"청각|손사용|시각|","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","similarNm":"조경설계가, 조경설계기술자, 조경시설물설계사","connectJob":"문화재조경설계사, 조경건축가, 조경설계건축가, 공원설계기술자, 골프장조경설계기술자, 공원시설물설계기술자, 녹화설계기술자, 수목원식물원조성설계기술자, 숲조성설계기술자, 자원재활용조경시설물디자인기술자","certLic":"조경기술사, 조경기사, 조경산업기사, 문화재수리기술자(조경), 자연환경관리기술사, 자연생태복원기사, 자연생태복원산업기사","dJobECd":"1404","dJobECdNm":"[1404]조경 기술자","dJobJCd":"2314","dJobJCdNm":"[2314]조경 기술자","dJobICd":"F412","dJobICdNm":"[F412]토목 건설업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003517:1', '{"dJobCd":"K000003517","dJobCdSeq":"1","dJobNm":"조경시공기술자","workSum":"설계 도서를 바탕으로 주어진 공정에 맞추어 시공 대상지에 조경기반시설, 수목식재, 조경구조물, 조경시설물, 조경포장, 생태복원, 입체녹화, 실내조경 등의 조경목적물을 주변경관과 조화되게 미적, 친환경적으로 조성하는 업무를 수행한다.","doWork":"조경설계기술자가 설계한 도면을 파악하여 조경공사시공에 필요한 인력, 재료, 장비 등을 산정한다. 도면에 표시된 각종 수목 또는 잔디, 조경석 등의 재료현황을 확인하고 주문·관리한다. 조경설계기술자 및 발주업체관리자와 공사일정에 대하여 협의하고, 시공계획을 수립한다. 조경공 및 보통인부 등 관련 근로자들에게 업무를 할당한다. 나무 및 잔디의 식재, 조경시설물과 부설물의 설치 및 마감 등의 작업을 조정·감독한다. 조경공사가 완료되면 설계도에 따라 시공되었는지 확인하고 준공도면을 준비한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|손사용|시각|","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","similarNm":"조경시공자, 조경작업자","connectJob":"생태복원기술자, 친환경조경기술자, 문화재보수조경기술자","certLic":"조경기사, 조경산업기사, 문화재수리기술자(조경), 자연생태복원기사, 자연생태복원산업기사, 문화재시공(조경)","dJobECd":"1404","dJobECdNm":"[1404]조경 기술자","dJobJCd":"2314","dJobJCdNm":"[2314]조경 기술자","dJobICd":"F412","dJobICdNm":"[F412]토목 건설업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004623:1', '{"dJobCd":"K000004623","dJobCdSeq":"1","dJobNm":"교통사고개선요원","workSum":"교통사고가 빈번한 지역을 조사하여 문제점을 파악하고 개선하는 업무를 수행한다.","doWork":"교통사고 건수와 교통사고 발생지역에 대한 통계자료를 수집한다. 교통사고 발생지역을 방문하여 조사한다. 현장조사 내용을 바탕으로 개선방안을 마련한다. 개선방안에 따라 교통체계 및 도로의 개선사항을 지시한다. 개선공사 후 효과를 분석한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"위험내재|소음·진동|","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"안전연구원","certLic":"교통안전관리자(도로)","dJobECd":"1405","dJobECdNm":"[1405]도시·교통 전문가","dJobJCd":"2315","dJobJCdNm":"[2315]도시 및 교통 관련 전문가","dJobICd":"O842","dJobICdNm":"[O842]사회 및 산업정책 행정","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006819:1', '{"dJobCd":"K000006819","dJobCdSeq":"1","dJobNm":"교통사고조사원","workSum":"교통사고의 정확한 원인규명을 위한 세밀한 현장조사 및 과학적 재현분석업무를 수행한다.","doWork":"교통사고가 발생한 현장을 정밀조사하기 위하여 사고현장과 사고차량에 대한 사진촬영을 실시한다. 교통사고현장에 대한 조사가 끝난 후 사고현장에 대한 정밀도면화작업을 수행한다. 사고현장조사 시 사고과정을 재현하고 정황을 파악한 후 교통사고의 원인을 규명한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|시각|","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","similarNm":"교통사고조사연구원, 도로교통사고감정사, 교통사고현장조사원, 교통사고감정사","connectJob":"교통사고조사연구원, 경찰(교통조사계)","certLic":"교통안전관리자(도로), 도로교통사고감정사","dJobECd":"1405","dJobECdNm":"[1405]도시·교통 전문가","dJobJCd":"2315","dJobJCdNm":"[2315]도시 및 교통 관련 전문가","dJobICd":"O842/O844","dJobICdNm":"[O842]사회 및 산업정책 행정 / [O844]사법 및 공공질서 행정","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005593:1', '{"dJobCd":"K000005593","dJobCdSeq":"1","dJobNm":"교통설계기술자","workSum":"도로망이나 교통시설물을 계획·설계하고, 교통분석 및 교통영향평가 등의 업무를 수행한다.","doWork":"교통 관련 시설을 건설하기 위하여 대상지역의 인구, 교통량, 물동량 등에 관한 자료를 수집한다. 수집된 자료를 바탕으로 기본계획 및 설계를 위한 기초자료를 작성한다. 교통분석, 교통영향평가 등의 계획을 수립한다. 도로망이나 교통시설물 건설에 따른 실시설계도를 작성한다. 공사현장에서 기술을 지원한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"종합","workFunc2":"자문","workFunc3":"관련없음","similarNm":"안전연구원, 교통기술자, 교통계획기술자","connectJob":"친환경교통설계전문가","certLic":"교통기술사, 교통기사, 교통산업기사, 교통안전관리자(도로)","dJobECd":"1405","dJobECdNm":"[1405]도시·교통 전문가","dJobJCd":"2315","dJobJCdNm":"[2315]도시 및 교통 관련 전문가","dJobICd":"M721/O842","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업 / [O842]사회 및 산업정책 행정","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004263:1', '{"dJobCd":"K000004263","dJobCdSeq":"1","dJobNm":"교통심리연구원","workSum":"교통심리학적 지식을 바탕으로 교통이용, 교통안전 등에 관련된 각종 연구를 수행한다.","doWork":"교통심리학(육·수·공의 공간과 시간에 걸쳐 사람이나 물건을 안전하고, 확실하고, 신속하고, 쾌적하게 운반하는 일에 관여하는 인간의 행동에 대해 심리학적 지식과 기술을 적용하는 실천적 과학)적 지식을 기반으로 교통로, 교통흐름, 신호와 표지(標識) 따위의 교통시설, 교통기관 및 그 이용자 등에 대한 연구를 수행한다. 교통안전 관련 연구를 수행하고, 이를 교통정책에 반영할 수 있도록 경찰청이나 국토교통부 등에 제안을 한다. 연구결과를 정책에 반영하기 위해 제도화를 추진하고 활용방안을 모색하기도 한다. 교통안전 주제로 강의를 하기도 한다. 교통안전에 대한 국민인식 제고를 위해 방송 등에서 홍보활동을 하기도 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"관련없음","certLic":"도로교통안전진단사, 운수교통안전진단사, 교통사고분석사","dJobECd":"1405","dJobECdNm":"[1405]도시·교통 전문가","dJobJCd":"2315","dJobJCdNm":"[2315]도시 및 교통 관련 전문가","dJobICd":"M702","dJobICdNm":"[M702]인문 및 사회과학 연구개발업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003125:1', '{"dJobCd":"K000003125","dJobCdSeq":"1","dJobNm":"교통안전시설기술자","workSum":"교통안전시설물에 대한 설계, 검사, 감리 등의 일을 수행한다.","doWork":"전자신호등체계, 안전표지시설물 등의 교통안전시설물에 대한 설계 및 검사업무를 수행하고 설치되어 있는 시설물의 점검을 통하여 개선사항을 설계한다. 특히 교통안전시설에 대해서는 휘도(광원의 단위면적당 밝기의 정도. 발광원 또는 투과면이나 반사면의 표면 밝기) 및 색도 검사를 실시하여 교통사고를 줄일 수 있는 교통안전시설을 설계한다. 교통안전시설 관련 업무로 인해 교통규제심의위원회에 참석하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"교통안전시설물설계가","connectJob":"교통신호설계가","certLic":"교통기술사, 교통기사, 교통산업기사, 교통안전관리자(도로)","dJobECd":"1405","dJobECdNm":"[1405]도시·교통 전문가","dJobJCd":"2315","dJobJCdNm":"[2315]도시 및 교통 관련 전문가","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006265:1', '{"dJobCd":"K000006265","dJobCdSeq":"1","dJobNm":"교통안전연구원","workSum":"교통안전과 관련된 교통정책 및 안전기준 등을 연구·개발한다.","doWork":"교통사고, 교통안전, 첨단교통, 교통운영, 교통법규, 교통기술 등에 대하여 기존 체제를 연구하고 개선방안을 도출해 낸다. 교통을 과학적 차원에서 접근하여 교통안전기준을 제시하고 만드는 일을 수행한다. 종합교통연구체계 구축, 종합교통정보체계 구축, 산·학·연 합동기술연구체계 확립, 국제연구교류 협력업무를 수행한다. 기타 연구원(일반)들이 수행하는 일반적인 활동을 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"자문","workFunc3":"관련없음","connectJob":"교통정책연구원, 교통법규연구원, 교통안전시설연구원","certLic":"교통기술사, 교통기사, 교통안전관리자","dJobECd":"1405","dJobECdNm":"[1405]도시·교통 전문가","dJobJCd":"2315","dJobJCdNm":"[2315]도시 및 교통 관련 전문가","dJobICd":"O842","dJobICdNm":"[O842]사회 및 산업정책 행정","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003794:1', '{"dJobCd":"K000003794","dJobCdSeq":"1","dJobNm":"교통영향평가기술자","workSum":"대량의 교통수요를 유발하거나 유발할 우려가 있는 사업을 시행하거나 시설을 설치할 경우 미리 당해사업의 시행 또는 시설의 설치로 인하여 발생할 교통장애 등 교통상의 각종 문제점을 검토·분석하고, 이에 대한 대책을 강구한다.","doWork":"인접지역의 개발계획을 검토한다. 사업예정지 주변의 토지이용현황 및 교통 관련 현황을 면접이나 관찰을 통해 조사한다. 표본추출과 실제 조사과정을 통해 얻어진 자료를 분석에 이용될 수 있도록 정리한다. 도로시설의 도로조건, 교통조건, 교통통제조건, 발생교통량 등 사업시행 시 영향을 분석한다. 통행발생·분포·교통수단선택·노선배정 단계로 나누어서 장래 교통수요를 예측한다. 조사, 분석된 내용을 검토하여 문제점을 도출하고, 개선방안을 강구한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","similarNm":"교통계획가","connectJob":"교통설계 전문가","certLic":"교통기술사, 교통기사, 교통산업기사","dJobECd":"1405","dJobECdNm":"[1405]도시·교통 전문가","dJobJCd":"2315","dJobJCdNm":"[2315]도시 및 교통 관련 전문가","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004264:1', '{"dJobCd":"K000004264","dJobCdSeq":"1","dJobNm":"교통종합관리자","workSum":"교통관리, 교통안전관리, 교통시스템관리 등에 관한 제반 사항을 지휘·감독한다.","doWork":"고속도로 장단기교통관리에 대한 대책의 수립을 총괄한다. 교통안전에 대한 종합적인 계획수립을 총괄한다. 교통관리시스템구축에 대한 장·단기계획의 수립을 총괄한다. 고속도로 교통상황을 총괄하고 교통정보를 수집·분석·전파함으로써 최적의 차량운행이 되도록 하기 위한 교통종합상황실 운영을 총괄한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"1405","dJobECdNm":"[1405]도시·교통 전문가","dJobJCd":"2315","dJobJCdNm":"[2315]도시 및 교통 관련 전문가","dJobICd":"O842","dJobICdNm":"[O842]사회 및 산업정책 행정","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005323:1', '{"dJobCd":"K000005323","dJobCdSeq":"1","dJobNm":"교통체계연구원","workSum":"교통망 및 교통체계에 관한 계획과 운영방법에 대해 연구한다.","doWork":"고속도로, 간선도로, 지선 등의 도로망을 계획·설계한다. 원활한 교통흐름을 위해 교통망체계의 개선방안을 연구한다. 지역 간 광역교통계획을 수립한다. 교통시설운영정책을 연구한다. 첨단도시교통관리기법을 개발한다. 도시교통량을 분석·예측한다. 교통흐름이 원활하지 못한 지역의 문제점을 파악하고 개선방안을 개발한다. 대중교통 간의 연계방법을 연구한다. 자료분석으로 교통사고 원인을 파악하고, 이를 토대로 교통안전에 대해 연구한다. 교통선진국의 자료를 수집하고 적용방법을 연구한다. 기타 연구원(일반)들이 수행하는 일반적인 활동을 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"종합","workFunc2":"자문","workFunc3":"관련없음","similarNm":"교통운영연구원","connectJob":"교통안전연구원, 도로교통연구원, 도시교통연구원, 철도교통연구원, 항공교통연구원","dJobECd":"1405","dJobECdNm":"[1405]도시·교통 전문가","dJobJCd":"2315","dJobJCdNm":"[2315]도시 및 교통 관련 전문가","dJobICd":"M721/O842","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업 / [O842]사회 및 산업정책 행정","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002277:1', '{"dJobCd":"K000002277","dJobCdSeq":"1","dJobNm":"도로교통안전진단사","workSum":"도로개통 전후의 도로의 안전성을 평가하고 개선안을 제시한다.","doWork":"도로 및 교통에 대한 전문적인 지식을 바탕으로 도로의 속도, 횡단구성, 선형, 평면교차, 입체교차, 보행자 및 자전거, 포장 및 배수, 부속시설, 표지 및 표시, 조명, 기상조건 및 환경, 공사구간 및 사고처리 등 각종 도로환경을 조사하고 분석한다. 도로공사의 설계단계에서 시공도면을 검토한다. 도로공사의 시공단계에서 시공현장을 조사하여 안전상의 문제점을 도출하고 개선안을 제시한다. 도로개통 후에 교통사고가 많이 발생하는 도로에 대해서는 도면검토 및 현장조사를 실시하고 분석하여 도로안전을 위한 개선안을 제시한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"자문","workFunc3":"관련없음","similarNm":"교통안전조사전문가","certLic":"교통기술사, 교통기사, 교통산업기사, 교통안전관리자(도로)","dJobECd":"1405","dJobECdNm":"[1405]도시·교통 전문가","dJobJCd":"2315","dJobJCdNm":"[2315]도시 및 교통 관련 전문가","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006776:1', '{"dJobCd":"K000006776","dJobCdSeq":"1","dJobNm":"도시계획가","workSum":"도시 및 지역의 공간구조, 토지이용, 도시개발, 각종 단지(주거·공업·상업), 공원, 도로 등 인프라에 대한 계획, 설계, 시공, 유지관리를 포괄하는 도시계획 및 개발 관련 업무를 수행한다.","doWork":"도시 및 지역특성과 경제·사회환경의 토대 위에 각종 기상·지형·지세·토지이용현황 과 인프라를 조사한다 종합적인 토지이용계획을 수립한다. 계획안에 대한 평가환류를 통해 미비점을 보완한다. 분석자료와 계획내용을 종합적으로 검토하여 도면과 도식을 작성한다. 관련 행정 및 법구 관련 서류를 작성한다. 관련 서류와 도면을 발주자에게 제시하고 전체계획에 대한 협의를 한다. 도시개발의 경제성과 토지이용의 효율성을 감안하여 구체적인 토지이용상황, 교통, 생활환경 등에 대한 세부계획안을 발주자에게 제시한다. 확정된 계획안을 발주자와 관할관청에 제시하고 승인을 얻는다. 시공 후 제반 문제점을 해결하기 위한 현장점검 및 안전진단업무, 현장지원업무 및 감리 업무를 한다. 개발에 따라 효율성 및 실효성이 있는 기술에 대한 기술제안업무와 기술개발업무를 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","similarNm":"도시계획기술사, 도시계획기사","connectJob":"친환경생태도시계획가, 안전건강도시계획가, 단지계획 및 설계기술자","certLic":"도시계획기술사, 도시계획기사","dJobECd":"1405","dJobECdNm":"[1405]도시·교통 전문가","dJobJCd":"2315","dJobJCdNm":"[2315]도시 및 교통 관련 전문가","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007030:1', '{"dJobCd":"K000007030","dJobCdSeq":"1","dJobNm":"도시재생기획운영가","workSum":"쇠퇴하는 도심과 시가지의 재활성화를 위해 지역자산을 활용한 새로운 도시기능 도입과 지역역량강화 등을 통해 도시 정체성의 보존과 경제, 사회, 환경 등 종합적 재생계획을 수립하고 지원한다.","doWork":"정부, 지자체, 기업 등의 도시재생컨설팅 의뢰를 받고 역할과 권한을 위임받는다. 특히 국비지원 과제 선정시 사업수행에 대한 직무를 맡는다. 도시재생사업 대상지역을 탐방하여 지역의 역사, 문화, 도시기능적 특징, 생태자원, 고유한 환경, 인문학적 특징 등 도시재생을 위한 지역적 자산, 지역내 사회적 관계(갈등사안, 주민 요구, 이해관계 등) 등을 조사한다. 지역의 비전, 지역경제 활성화 방안, 삶의 질 향상 방안, 자립적 선순환 환경시스템, 지역경쟁력 강화, 생태자원의 활용, 인문학적 자산의 활용 등을 기획하고 도시재생마스터플랜을 작성하여 보고한다. 도시재생사업이 추진되면 공공 및 민간분야의 여러 사업주체에게 도시재생기법에 대한 지식을 교육하고 중재자역할을 수행한다. 사업추진 중에 발생하는 갈등을 조정하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내·외","workFunc1":"종합","workFunc2":"협의","workFunc3":"관련없음","similarNm":"도시계획사, 도시계획기술사","certLic":"도시재생기술사","dJobECd":"1405","dJobECdNm":"[1405]도시·교통 전문가","dJobJCd":"2315","dJobJCdNm":"[2315]도시 및 교통 관련 전문가","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004718:1', '{"dJobCd":"K000004718","dJobCdSeq":"1","dJobNm":"도시재생코디네이터","workSum":"도시의 경제적, 사회적, 문화적 활력회복을 위한 도시재생사업의 계획수립을 지원하고, 도시재생사업 운영을 위한 기획과 지원업무를 수행한다.","doWork":"도시의 경제적, 사회적, 문화적 활력회복을 위한 도시재생사업 계획수립과 운영을 지원한다. 도시재생사업의 원활한 추진을 위해 다양한 주체의 교류와 협력을 촉진한다. 중간조정자로서 지역공동체 형성과 민관거버넌스 구축을 지원한다. 지역조사 및 자원발굴, 지역비전수립, 인적자원 발굴과 육성, 도시재생 홍보와 공감대 확대, 마을기업 창업과 육성, 연계사업 도입과 지원, 갈등조정 등 도시재생사업 추진에 필요한 종합적인 기획과 지원업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"언어력|","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"도시재생활동가, 도시재생기획자","connectJob":"마을만들기코디네이터","dJobECd":"1405","dJobECdNm":"[1405]도시·교통 전문가","dJobJCd":"2315","dJobJCdNm":"[2315]도시 및 교통 관련 전문가","dJobICd":"O842","dJobICdNm":"[O842]사회 및 산업정책 행정","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007185:1', '{"dJobCd":"K000007185","dJobCdSeq":"1","dJobNm":"스마트도시계획가","workSum":"스마트도시(Smart city, 사물 인터넷(IoT), 사이버 물리 시스템(CPS), 빅데이터 솔루션 등 최신 정보통신기술(ICT)을 적용하고 다양한 유형의 전자 데이터 수집 센서를 사용하여 자산과 자원을 효율적으로 관리하는 데 필요한 정보를 제공하는 도시 지역)사업을 계획하고 사업 진행을 총괄한다.","doWork":"스마트도시 사업지구의 사업현황, 정책적·경제적·사회문화적 환경, 도시전략 및 지역 특성, 국내외 사례 등에 대한 기초자료를 분석한다. 도시주민들과 이해관계자들의 의견 및 요구사항 등을 수집·분석하여 해당 지구의 스마트도시 핵심 성공 요소를 발굴하고 이를 바탕으로 해당 도시지역의 비전 및 전략을 수립한다. 해당 지구에 맞는 스마트도시 서비스를 선정한다. 선정된 서비스별 하드웨어 및 소프트웨어의 구축, 시설물의 정의, 아키텍처(하드웨어와 소프트웨어를 포함한 컴퓨터시스템 전체의 설계방식)의 구성, 서비스별 운영방안 등 실행안을 수립한다. 통합운영센터의 기능 및 운영조직, 설립부지 선정, 공간구성 및 적정규모, 센터설비 및 IT인프라 구성방안, 통합 플랫폼 및 데이터 구현방안 등 통합운영센터를 구현하기 위한 기획안을 작성한다. 해당 지구의 통신환경, 통신수요 예측, 경제성 분석을 통한 자가망과 임대망의 비용 및 효과비교, 적용기술 선정, 유무선망·센서망·통합망 실행방안, 통신망 운영방안 등의 통신인프라 모델수립 등의 업무도 수행한다. 스마트도시 구축을 체계적으로 이행하기 위해 단계별 사업일정 및 추진체계, 수익창출 및 운영비 최소화 방안, 관련 법률 검토, 스마트도시 구축에 따른 기대효과 및 홍보방안 등 세부전략 및 체계를 세운다. 스마트도시의 구축비와 운영비를 충당하기 위한 비즈니스모델을 개발하고, 모델의 타당성과 비용편익분석을 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"협의","workFunc3":"관련없음","similarNm":"U-City기획자, U-City프로젝트관리자, U-City설계기술자","dJobECd":"1405","dJobECdNm":"[1405]도시·교통 전문가","dJobJCd":"2315","dJobJCdNm":"[2315]도시 및 교통 관련 전문가","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007689:1', '{"dJobCd":"K000007689","dJobCdSeq":"1","dJobNm":"지능형교통체계계획자","workSum":"교통체계지능화사업 추진을 위한 법정계획(국가 및 지방)을 수립하고 사업 추진 시 법정계획을 기반으로 사업을 구상하며, 사업의 체계적인 수행을 위하여 사업 목적 및 목표 설정, 현황 분석, 추진 전략 수립, 서비스 선정 및 기술 대안을 제안한다.","doWork":"교통체계지능화사업 추진을 위하여 여건 및 현황을 진단·전망하여 사업을 계획한다. 사업추진 우선순위 및 예산을 계획한다. 체계적인 사업수행을 위하여 필요성을 검토하고, 공간적, 시간적, 내용적 범위 설정 및 구체적이고 정량화된 목적을 수립한다. 사업에 해당되는 범위(국가, 도시 등)의 교통 관련 현황과 여건, 기존의 지능형교통체계를 조사⋅분석하고, 관련 법⋅제도와 계획⋅정책을 검토하여 문제점을 도출한다. 사업 목표 설정 및 사업추진 방법과 목표 달성을 위한 개별 서비스를 도출한다. 기술동향 조사를 통해 기술의 성능과 표준을 검토하여 교통체계 기능화 사업에 필요한 도입 기술을 선정한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"지능형교통체계기획자","certLic":"교통기술사, 교통기사, 정보통신기사, 도시계획기술사, 도시계획기사, 정보처리기사","dJobECd":"1405","dJobECdNm":"[1405]도시·교통 전문가","dJobJCd":"2315","dJobJCdNm":"[2315]도시 및 교통 관련 전문가","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2025"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005496:1', '{"dJobCd":"K000005496","dJobCdSeq":"1","dJobNm":"지능형첨단교통망연구원","workSum":"지능형교통시스템(ITS:Intelligent Transport Systems)과 관련된 각종 시스템 및 장비를 개발하고 데이터처리방법을 연구한다.","doWork":"국가도로망을 검토하여 지능형교통시스템의 설치지역을 결정하는 데 조언한다. 지능형교통시스템의 구축에 필요한 장비를 개발 및 설계한다. 교통정보데이터의 처리방법을 연구한다. 각종 도로 및 교통 관련 시설의 건설에 대해 조언한다. 외국의 사례를 분석하여 정보를 제공한다. 시스템 도입에 따른 경제적 효과를 계산한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","similarNm":"지능형교통시스템(ITS)전문가, ITS연구원","dJobECd":"1405","dJobECdNm":"[1405]도시·교통 전문가","dJobJCd":"2315","dJobJCdNm":"[2315]도시 및 교통 관련 전문가","dJobICd":"M721","dJobICdNm":"[M721]건축기술, 엔지니어링 및 관련 기술 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004701:1', '{"dJobCd":"K000004701","dJobCdSeq":"1","dJobNm":"공간정보데이터분석원","workSum":"다양한 공간콘텐츠 및 서비스에 이용하기 위해 공간정보데이터를 편집·분석·가공한다.","doWork":"수집된 공간데이터를 확인하고 좌표계 설정, 피처(Feature) 및 속성을 편집하여 공간정보분석에 사용할 수 있는 데이터로 가공한다. 공간데이터의 변환, 위치보정, 위상편집을 통해 데이터 무결성 확보작업을 한다. 공간정보를 분류하고, 중첩분석, 버퍼분석, 지형분석 등을 수행하여 다양한 공간정보 콘텐츠를 생산한다. 공간정보 콘텐츠를 분석·가공하여 다양한 공간정보서비스에 이용될 수 있도록 제공한다. 공간정보 데이터의 해석력과 직관성을 높이기 위해 다양한 분야의 비공간자료와 결합시켜 2차원 또는 3차원 형태의 지도콘텐츠로 표출(시각화)한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"GIS데이터분석자","certLic":"측량및지형공간정보기술사, 측량및지형공간정보기사, 측량및지형공간정보산업기사","dJobECd":"1406","dJobECdNm":"[1406]측량·지리정보 전문가","dJobJCd":"2316","dJobJCdNm":"[2316]측량 및 지리 정보 전문가","dJobICd":"M729","dJobICdNm":"[M729]기타 과학기술 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006710:1', '{"dJobCd":"K000006710","dJobCdSeq":"1","dJobNm":"공간정보시스템설계분석가","workSum":"지상(도로, 건축물 등), 지하(상하수도, 가스 등의 지하매설물 등)의 각종 공간정보의 데이터베이스를 구축하고 관리하기 위한 공간정보시스템을 설계하고 분석한다.","doWork":"사용자의 의견을 수렴하고 해당 분야의 전문가와 협의하여 구축하고자하는 공간정보시스템(GIS: Geographic Information System)의 기능 및 성능을 분석하여 공간정보시스템에 요구되는 사항을 종합적으로 정의한다. 요구되는 사항에 입각하여 데이터베이스, 사용자 인터페이스 및 네트워크 등 기본적인 시스템 구조를 설계한다. 공간정보시스템프로그래머에게 구축하고자하는 공간정보시스템에 대한 설명을 하고 프로그램을 작성하도록 의뢰한다. 시스템이 구축되면 그 기능과 성능에 대한 종합적인 시스템시험을 실시하고 평가한다. 사용자에게 시스템의 운영 및 관리에 대한 교육과 기술적 자문을 한다. 지리정보시스템에 관련된 최신정보기술의 추세 및 동향을 파악 분석하여 향후 정보기술 변화에 대비한다. 그밖에 공간정보시스템 구축에 대한 입찰공고가 나면 해당분야의 전문가와 협의하여 제안서를 작성하고 입찰에 참가하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"협의","workFunc3":"관련없음","similarNm":"지리정보시스템전문가, GIS전문가, 지리정보시스템분석가, GIS기술자, 지리정보전문가","connectJob":"지리정보시스템프로젝트매니저, 광산지리정보시스템개발자, 산림지리정보시스템설계분석가","certLic":"측량및지형공간정보기사","dJobECd":"1406","dJobECdNm":"[1406]측량·지리정보 전문가","dJobJCd":"2316","dJobJCdNm":"[2316]측량 및 지리 정보 전문가","dJobICd":"M729","dJobICdNm":"[M729]기타 과학기술 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005553:1', '{"dJobCd":"K000005553","dJobCdSeq":"1","dJobNm":"공간정보시스템연구원","workSum":"공간정보시스템을 비롯한 관련 분야의 기술을 개발하고 활용방안을 연구한다.","doWork":"공간정보시스템(GIS: Geographic Information System)의 효율적인 구축을 위한 공간정보시스템 데이터베이스 구축방안 및 표준안, 공간정보시스템 데이터 유통방안 등을 연구한다. 수치지도제작의 표준화 및 유지관리를 한다. 공간정보시스템의 관리 및 평가를 한다. 원격탐사(RS: Remote Sensing) 및 범지구측위시스템(GPS: Global Positioning System), 공간데이터베이스, 3차원분석, 맵핑기술, 공간분석 등의 기술을 개발하고 활용방안을 연구한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"자문","workFunc3":"관련없음","dJobECd":"1406","dJobECdNm":"[1406]측량·지리정보 전문가","dJobJCd":"2316","dJobJCdNm":"[2316]측량 및 지리 정보 전문가","dJobICd":"M729","dJobICdNm":"[M729]기타 과학기술 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001682:1', '{"dJobCd":"K000001682","dJobCdSeq":"1","dJobNm":"공간정보영상처리원","workSum":"인공위성, 항공기, 드론 등을 이용하여 취득한 원격탐사영상자료를 공간정보분석에 적합한 형태로 가공한다.","doWork":"수집된 원격탐사자료를 확인하고 잡음제거, 필터링, 오차수정 등 영상전처리작업을 한다. 자료취득에 따라 발생하는 기하오차를 보정하고 공간분석에 적합하도록 지도투영형태로 변환한다. 영상자료의 히스토그램을 보정하거나 관련 프로그램을 사용하여 분석과 판독이 용이하도록 영상강조작업을 한다. 영상의 공간변환을 수행하여 취득된 자료에서 공간정보를 수정하거나 추출한다. 서로 다른 공간해상도의 좌표를 변환하고 융합하여 융합영상을 생성한다. 여러 영상을 하나로 합하여 단일한 영상(영상모자이크작업)을 생성한다. 영상을 분류하고 편집, 수정 및 통계작업을 수행하여 영상분석 및 활용목적에 적합한 자료를 생성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"위성영상처리원, 항공영상처리원, 원격영상처리원","certLic":"측량및지형공간정보기술사, 측량및지형공간정보기사, 측량및지형공간정보산업기사","dJobECd":"1406","dJobECdNm":"[1406]측량·지리정보 전문가","dJobJCd":"2316","dJobJCdNm":"[2316]측량 및 지리 정보 전문가","dJobICd":"M729","dJobICdNm":"[M729]기타 과학기술 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006548:1', '{"dJobCd":"K000006548","dJobCdSeq":"1","dJobNm":"광산측량기술자","workSum":"광산 내의 자원개발을 위하여 측량을 실시하고 도면을 작성하는 광산측량작업을 관리하며, 광산측량사 및 광산측량보조원의 활동을 계획·조정·지시한다.","doWork":"광산의 측량을 실시하여 광상(鑛床:광물자원이 암석 속에 자연상태로 집중되어 있는 것)의 위치, 심도, 규모, 광맥의 변화 등 광산의 조건변화에 대한 조사보고서를 작성한다. 측량현장에서 사용되는 각종 측량기를 조절·점검하고 광산측량사를 지휘하여 측량작업을 수행한다. 측량작업에 따른 안전점검을 실시한다. 측량계획에 의한 인원을 구성하고 구성단위에 대한 경비를 산출한다. 새로운 측량기술을 연구하고 측량결과와 방법을 평가·분석한다. 측량에 대한 기술적 자문을 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workEnv":"위험내재|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","certLic":"측량및지형공간정보기사","dJobECd":"1406","dJobECdNm":"[1406]측량·지리정보 전문가","dJobJCd":"2316","dJobJCdNm":"[2316]측량 및 지리 정보 전문가","dJobICd":"M729","dJobICdNm":"[M729]기타 과학기술 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001371:1', '{"dJobCd":"K000001371","dJobCdSeq":"1","dJobNm":"광산측량사","workSum":"광산의 갱내 외에서 시추와 채굴에 필요한 제반 측량을 실시하여 그 결과를 분석하고 도면을 작성한다.","doWork":"광산보안법을 숙지한다. 측량작업계획을 세운다. 측량장비 및 도구를 준비한다. 토털스테이션(Total Station), 범지구측위시스템(GPS), TLS(레이저 스캐너), 전경의(트랜싯:Transit, 각을 재는 측량기계), 레벨(Level) 등의 측량기구를 사용하여 갱내 일반측량, 갱내 세부측량, 갱도중심선측량, 갱도요선측량, 수갱중심측량, 갱도관측측량 등 다양한 측량작업을 실시한다. 측량결과를 DB로 구축하여 관리·보존한다. 측량성과를 계산하여 결과를 분석하고, 도면을 작성한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|시각|","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"측량기능사, 측량및지형공간정보산업기사","dJobECd":"1406","dJobECdNm":"[1406]측량·지리정보 전문가","dJobJCd":"2316","dJobJCdNm":"[2316]측량 및 지리 정보 전문가","dJobICd":"M729","dJobICdNm":"[M729]기타 과학기술 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002130:1', '{"dJobCd":"K000002130","dJobCdSeq":"1","dJobNm":"내비게이션도로조사원","workSum":"도로조사장비를 이용하여 도로에서 도로데이터를 취득한다.","doWork":"조사계획에 따라 조사할 도로와 관성측정장치, 카메라 등 측정장치의 이상 유무를 확인한다. 도로조사장비(Mobile Mapping System)를 통해 실제 도로를 주행하며 정밀도와 정확도가 뛰어난 고정밀 데이터를 취득한다. 취득한 데이터를 내비게이션도로조사후처리원에게 넘긴다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"수동조작","dJobECd":"1406","dJobECdNm":"[1406]측량·지리정보 전문가","dJobJCd":"2316","dJobJCdNm":"[2316]측량 및 지리 정보 전문가","dJobICd":"M729","dJobICdNm":"[M729]기타 과학기술 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004482:1', '{"dJobCd":"K000004482","dJobCdSeq":"1","dJobNm":"도화사","workSum":"항공사진 및 인공위성에서 취득한 각종 영상에서 지형지물정보를 정해진 축척과 규정에 맞게 도화기를 이용하여 등고선, 객체 등을 추출하는 작업을 수행한다.","doWork":"중복으로 촬영된 입체영상을 이용하여 해당지역의 입체상을 만든다. 입체상을 육안으로 판독하여 실재 지형·지물의 상태를 축척제원에 따라 묘사한다. 등고선 간격과 수직눈금을 결정하고 세부지형을 파악한다. 구축된 등고선과 객체를 컴퓨터에 입력한다. 수치도화기에서 얻은 수치데이터를 지도표현원리 및 작업규정에 따라 일반화, 과장화, 상징화시켜 정위치 편집한다. 객체속성정보를 입력하기 위한 구조화 편집작업을 수행하여 지형정보데이터베이스를 구축한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"제어조작","certLic":"도화기능사","dJobECd":"1406","dJobECdNm":"[1406]측량·지리정보 전문가","dJobJCd":"2316","dJobJCdNm":"[2316]측량 및 지리 정보 전문가","dJobICd":"M729","dJobICdNm":"[M729]기타 과학기술 서비스업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004558:1', '{"dJobCd":"K000004558","dJobCdSeq":"1","dJobNm":"지도제작기술자","workSum":"항공사진측량 및 지형측량성과를 이용하여 지형지물의 3차원 공간정보를 포함하는 지도를 제작한다.","doWork":"지형측량, 측지측량, 항공사진측량 및 원격탐사 등으로 구축된 공간정보를 수집하고 분석한다. 수집된 정보를 이용하여 정위치편집, 구조화편집 등의 공정을 수행하여 지도를 제작한다. 산림도, 교통도 등 다양한 주제를 포함하는 주제도 작성과 인문정보를 포함하는 인문지리정보 구축 등의 업무를 수행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"분석","workFunc2":"서비스제공","workFunc3":"정밀작업","connectJob":"해도제작기술자, GPS지도제작원, 지리모형제작원","certLic":"지도제작기능사","dJobECd":"1406","dJobECdNm":"[1406]측량·지리정보 전문가","dJobJCd":"2316","dJobJCdNm":"[2316]측량 및 지리 정보 전문가","dJobICd":"M729","dJobICdNm":"[M729]기타 과학기술 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003055:1', '{"dJobCd":"K000003055","dJobCdSeq":"1","dJobNm":"측량기술자(일반)","workSum":"토목건설, 지도제작, 토지구획, 지형연구, 천연자원개발, 공간정보개발 및 기타 목적을 위해 지형, 지물을 측량하며, 관련업무의 계획, 실시관리, 분석·평가, 연구 등의 업무를 관리하며, 측량사 및 측량보조원의 활동을 감독·조정한다.","doWork":"지형, 지물에 대한 측지·측량계획을 세운다. 이전의 측량자료, 기록부, 지도, 증서, 물리적 자료 등을 조사하여 측량에 필요한 자료를 수집한다. 조사한 정보와 사진측량기록에서 새로운 자료를 개발하고, 측량통제설정 및 재설정에 필요한 절차와 방법을 결정한다. 토털스테이션, 레벨, 위성측량장비, 지상레이저스케너(TLS) 등 각종 측량장비를 사용하여 대상지역을 측량한다. 측량결과를 검토·수정하여 도면을 작성하고, 측량결과서를 작성한다. 국가기본도를 대상으로 측량계획을 수립하고, 그 관측결과를 이용하여 국토위치의 기본이 되는 통합기준점을 산정하기도 한다. 새로운 측지·측량기술을 연구한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"시각|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"토지측량기술자, 측지기술자","connectJob":"측지측량기술자, 항공측량기술자, 해양측량기술자, 지적기술자, 지적측량기술자, 토목측량기술자, 수로측량기술자, 광파기측량기술자","certLic":"측량및지형공간정보기술사, 측량및지형공간정보기사, 지적기사, 지적기술사","dJobECd":"1406","dJobECdNm":"[1406]측량·지리정보 전문가","dJobJCd":"2316","dJobJCdNm":"[2316]측량 및 지리 정보 전문가","dJobICd":"M729","dJobICdNm":"[M729]기타 과학기술 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003493:1', '{"dJobCd":"K000003493","dJobCdSeq":"1","dJobNm":"측량사(일반)","workSum":"측량기술자의 지시에 따라 토목건설, 지도제작, 토지구획, 지형연구, 천연자원개발, 공간정보개발 및 기타 목적을 위해 지형, 지물을 측지·측량하고 분석한다.","doWork":"측량기술자의 지시에 따라 토털스테이션, 레벨, 위성측량장비, 지상레이저스케너(TLS) 등의 각종 장비를 사용하여 측량할 위치의 지표, 기준점, 시설물, 터널 및 고속도로 등을 측량한다. 측량결과를 검토·수정하여 도면을 작성한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"시각|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"측지사, 계측기사, 측량기사","connectJob":"항공측량사, 해양측량사, 토목계측기사, 토목측량기사","certLic":"측량기능사, 측량및지형공간정보산업기사, 지적산업기사","dJobECd":"1406","dJobECdNm":"[1406]측량·지리정보 전문가","dJobJCd":"2316","dJobJCdNm":"[2316]측량 및 지리 정보 전문가","dJobICd":"M729","dJobICdNm":"[M729]기타 과학기술 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005504:1', '{"dJobCd":"K000005504","dJobCdSeq":"1","dJobNm":"항공사진측량기술자","workSum":"도시계획, 지도제작, 토지구획, 공간정보 구축을 위해 항공기를 이용하여 사진촬영을 하고 항공사진측량과 관련된 영상처리, 성과정리 등의 업무를 수행한다.","doWork":"촬영대상이 되는 지형·지물에 대한 촬영계획을 수립한다. 촬영지역에 대한 촬영허가신청을 한다. 기상상태와 시계 등을 고려하여 촬영일자를 결정하며 촬영에 필요한 점검과 준비를 한다. 항공기에 탑승하여 촬영을 한다. 촬영된 사진을 저장·복사한다. 사진을 검사하고 재촬영 여부를 결정한다. 촬영된 사진에 대한 보안검열을 의뢰한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|시각|","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"항공측량사","certLic":"항공사진기능사","dJobECd":"1406","dJobECdNm":"[1406]측량·지리정보 전문가","dJobJCd":"2316","dJobJCdNm":"[2316]측량 및 지리 정보 전문가","dJobICd":"M729","dJobICdNm":"[M729]기타 과학기술 서비스업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006732:1', '{"dJobCd":"K000006732","dJobCdSeq":"1","dJobNm":"해양관측사","workSum":"조석, 해수유동, 파랑, 해수물성, 해빈류, 해저퇴적물이동, 해빈변화, 해저질변화, 해양기상 등 다양한 해양정보를 관측한다.","doWork":"해양관측 목적에 부합하도록 조사해역과 조사일정을 선정한다. 해역의 제반 특성을 고려한 최적의 관측계획을 수립한다. 해양관측의 특성을 파악할 수 있는 정점에 조위계, 유속계, 파고계, 부표 등 각종 관측장비를 설치한다. 조위관측, 해수유동특성관측, 파랑관측, 해수물성관측, 해빈(海濱)류관측, 해저퇴적물이동관측 자료를 취득하고 분석한다. 해빈단면·해안선조사를 실시하고 해빈폭·해안선자료를 분석하여 해빈변화를 관측한다. 해양기상을 대표할 수 있는 지점에 해양기상관측장비를 설치하여 해양기상자료를 취득하고 분석한다. 각종 해양관측자료를 종합·분석하여 보고서를 작성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1406","dJobECdNm":"[1406]측량·지리정보 전문가","dJobJCd":"2316","dJobJCdNm":"[2316]측량 및 지리 정보 전문가","dJobICd":"M729","dJobICdNm":"[M729]기타 과학기술 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003810:1', '{"dJobCd":"K000003810","dJobCdSeq":"1","dJobNm":"해양측량사","workSum":"해양의 수심, 해저지질, 해저지층, 지구자기, 중력, 해안선의 형태 등을 측량하고 해양공간정보를 구축한다.","doWork":"해양측량 목적에 적합한 측량계획을 수립한다. GNSS(Global Navigation Satellite System), 토털스테이션, 항공레이저 측량기, 수준측량기 등을 활용하여 수로기준점, 해양상대위치 등 해양위치를 측량한다. 다양한 전문장비를 사용하여 해저지형, 해저지층, 해저퇴적물, 해저면, 해안선, 해저지반의 특성과 구조를 측량한다. 수집한 해양공간정보로 데이터베이스를 구축한다. 데이터베이스를 분석하여 해양공간정보도면을 작성하고 활용한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"1406","dJobECdNm":"[1406]측량·지리정보 전문가","dJobJCd":"2316","dJobJCdNm":"[2316]측량 및 지리 정보 전문가","dJobICd":"M729","dJobICdNm":"[M729]기타 과학기술 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005378:1', '{"dJobCd":"K000005378","dJobCdSeq":"1","dJobNm":"콘크리트시험원","workSum":"아파트, 공장 등의 콘크리트 조립건축물을 건립하는 데 필요한 규격에 맞는 기성콘크리트(P·C:precast concrete, 공장에서 제조된 콘크리트 또는 콘크리트 제품) 제품에 대한 생산공정과정에서 요구되는 강성 및 안전성을 확보하기 위해 필요한 각종 시험, 측정을 한다.","doWork":"콘크리트 배합설계에 따른 각종 자재(시멘트, 골재, 철근 등)의 강도, 비중, 밀도, 열전도율, 치수 등을 시험·측정한다. 콘크리트 타설 중 슬럼프측정, 압축강도시험, 공기량 및 염화물의 함유량을 시험한다. 콘크리트 양생 시 계절에 따른 양생시간을 산정하여 양생에 따른 양생온도, 콘크리트강도, 양생상태 등을 시험·측정한다. 배근 및 매입물 부착 시 철근 및 와이어메시의 규격 및 배관을 검사하고 창호, 부속물(전기박스, 파이프, 전선관 등)의 위치 및 상태를 점검한다. 콘크리트 양생에 따른 미장상태, 크랜상태, 치수 등을 압축강도시험기, 함수량시험기, 자갈마모율시험기와 같은 각종 시험기를 통하여 시험·측정한다. 콘크리트제품의 강도를 시험하기 위하여 일정기간 물속에 넣어놓고 강도를 테스트한다. 정확한 시험, 측정을 위하여 외부공인시험기관에 의뢰하기 위한 서류를 작성하고 결과를 보고한다. 콘크리트혼합공장에서 콘크리트의 슬럼프, 공기량, 염화량, 강도 등을 테스트하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"피시테스트원, 해머테스트원","connectJob":"콘크리트강도시험기사","certLic":"콘크리트기사","dJobECd":"1407","dJobECdNm":"[1407]건설자재 시험원","dJobJCd":"2317","dJobJCdNm":"[2317]건설자재 시험원","dJobICd":"C233","dJobICdNm":"[C233]시멘트, 석회, 플라스터 및 그 제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006200:1', '{"dJobCd":"K000006200","dJobCdSeq":"1","dJobNm":"콘크리트재료시험원","workSum":"경제적이고 우수한 품질의 콘크리트를 생산·공급하기 위하여 콘크리트에 관련된 자재 및 생산품에 대한 시험을 한다.","doWork":"시멘트, 골재, 모래, 물, 얼음 등의 시료를 채취한다. 채취된 시료를 선별 또는 세척한다. 콘크리트 재료의 품질시험을 한다. 공인기관에서 시험성적서를 확인하여 혼화재를 선정한다. 구조물에 따른 강도분류와 계절에 따른 대기온도에 따라 기본배합을 설계한다. 콘크리트 재료를 계량하여 콘크리트를 생산한다. 생산된 콘크리트의 슬럼프(Slump), 공기량, 온도 및 단위중량을 시험·측정한다. 생산된 콘크리트의 이상 유무를 확인하여 이상이 있을 시 폐기조치하고 이상이 없으면 타설장소로 운반한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","certLic":"콘크리트기사","dJobECd":"1407","dJobECdNm":"[1407]건설자재 시험원","dJobJCd":"2317","dJobJCdNm":"[2317]건설자재 시험원","dJobICd":"C233","dJobICdNm":"[C233]시멘트, 석회, 플라스터 및 그 제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006561:1', '{"dJobCd":"K000006561","dJobCdSeq":"1","dJobNm":"가스공급상황실운영관리자","workSum":"수요처에 가스를 공급하는 각종 설비 및 배관의 이상 유무를 파악하고 안전유지를 위하여 상황실을 운영·관리한다.","doWork":"가스공급에 필요한 설비 및 배관 등을 모니터로 관찰하며 이상 유무를 확인한다. 상황실 관련 자료 및 민원사항을 기록하고 관리한다. 가스 생산기지 및 관로관리담당자로부터 보고를 접수한다. 상황 및 사고에 따른 보고서를 작성하고 조치한다. 가스공급설비 및 배관 주변의 각종 공사, 굴착작업 등의 현황을 파악하여 안전조치를 취하도록 지시한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"협의","workFunc3":"조작운전","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"D352","dJobICdNm":"[D352]연료용 가스 제조 및 배관공급업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005941:1', '{"dJobCd":"K000005941","dJobCdSeq":"1","dJobNm":"가스공급설비기계관리원","workSum":"가스 공급을 위한 배관망의 각종 기계설비를 유지·관리하고 설비개선을 위한 업무를 한다.","doWork":"가스 공급 배관망의 기계설비(필터설비, 히터설비, 정압설비, 계량설비, 방산탑, 충전설비)를 유지·관리·정비하기 위한 계획을 수립하고, 기계설비의 정비 및 검사를 위한 용역업체를 관리한다. 가스 공급 배관망의 각종 기계설비에 대한 신·증설계획을 수립하고 발주 및 공정관리, 기성 및 준공검사 등의 기술행정 업무를 한다. 정비 및 신·증설 공사에 대한 인·허가 처리를 위한 대관업무, 공사 감독 및 감리 등을 한다. 관할지역의 가스히터, 가스필터 및 각종 밸브 및 배관에 대한 관리 현황을 파악하고 가스공급이 안전하고 원활하게 이루어지도록 유지·관리한다. 각종 기계설비에 대한 자료수집, 설계도면 관리, 기술서 검토 등을 통하여 설비개선을 위한 방안을 강구한다. 담당구역 관리소의 정비의뢰를 받아 정비하고 정비사항에 대한 주요내용을 기록하여 보고한다. 기계설비를 정비하기 위한 각종 장비 및 공구를 관리한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|","workEnv":"대기환경미흡|위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"가스기사, 일반기계기사, 가스기능장, 가스산업기사, 건설기계설비기사, 건설기계설비산업기사, 에너지관리기사, 에너지관리산업기사 ","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"D352","dJobICdNm":"[D352]연료용 가스 제조 및 배관공급업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004860:1', '{"dJobCd":"K000004860","dJobCdSeq":"1","dJobNm":"가스생산설비계기관리원","workSum":"가스를 생산하기 위한 각종 계측제어설비의 유지, 관리, 정비 및 설비개선 업무를 한다.","doWork":"가스생산 계측제어설비에 대한 유지·관리 및 정비계획을 수립하고 수립된 계획에 따라 일일·주간·월간 등의 전기설비 점검을 실시한다. 가스생산기지 내의 계측제어설비를 유지·관리한다. 가스생산설비를 조정하는 각종 제어설비의 작동상태를 감시하고 이상 및 장애요인 발생 시 정상적인 작동이 될 수 있도록 신속히 정비한다. 하역설비, 저장설비, 연소탑, 표본추출설비, 소화·용수설비 등의 주요 계측설비의 주기적 점검과 감시를 통하여 사고를 미연에 방지하고 설비개선을 위한 방안을 강구한다. 각종 계측제어설비에 대한 설계도면, 시방서, 기술서, 절차서 등을 체계적으로 관리한다. 각종 공사에 따른 용역관련 기술행정 업무를 수행한다. 각종 설비자재에 대한 품질검사를 실시한다. 가스를 저장하고 송출하는 각종 설비를 운영하는 프로그램을 유지·관리하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"제어시스템관리원","certLic":"가스기사, 가스산업기사","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"D352","dJobICdNm":"[D352]연료용 가스 제조 및 배관공급업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001808:1', '{"dJobCd":"K000001808","dJobCdSeq":"1","dJobNm":"가스제조연구원","workSum":"가스 생산을 위한 원료 개발, 신제품 개발, 공정 개선 및 신기술 도입을 위한 연구 및 관련 시험·분석을 한다.","doWork":"신제품 개발을 위해 시험계획을 세운다. 시험을 위한 실험기구 및 관련 장치를 설치한다. 관련 장치를 사용하여 제품과 원료를 시험·분석한다. 실험결과의 현장 적용 가능성을 타진하기 위해 사전에 실험하는 파일럿 설비를 설치한다. 공정개선을 위해 각종 데이터를 현장 부서에 지원한다. 가스의 제조 및 공급, 부산물의 정제 및 판매 등의 계획을 세운다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"가스제조기술자","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"D352","dJobICdNm":"[D352]연료용 가스 제조 및 배관공급업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007104:1', '{"dJobCd":"K000007104","dJobCdSeq":"1","dJobNm":"고무재료개발자","workSum":"고무제품에서 요구되는 특성을 만족시키기 위하여 고무배합물 물성·분석 연구 업무를 수행한다.","doWork":"고무제품의 시장 구조 및 고무분야의 시장동향을 분석한다. 고객형태를 파악하고 고객으로부터 구매결정 요인 도출 및 고객 불만에 대한 정보 등 고객동향을 분석한다. 기술문헌·지식재산권·신소재 등의 기술동향을 분석하고 기술을 예측한다. 고무재료의 개발, 제조, 수입, 유통, 폐기의 전 과정 (Life Cycle)과 관련된 국·내외 법적규제, 정부정책, 이해관계자를 파악한다. 고무 재료의 개발을 위하여 외부환경·내부역량 분석결과와 아이디어 도출 작업으로부터 개발 후보군들을 탐색·발굴하고 이들의 우선순위를 평가한다. 고무재료가 미치는 인체ㆍ환경 안전성을 분석하고 지속가능성 여부를 분석한다. 고무재료의 기술적 타당성을 파악하기 위하여 고객 요구사항을 반영하는 프로토타입 제품을 설계하고 품질특성을 평가한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007427:1', '{"dJobCd":"K000007427","dJobCdSeq":"1","dJobNm":"고무제품개발자","workSum":"고무제품 제조개발 및 제품의 성능을 개선하기 위해 실험계획, 공정개발, 분석법 개발 등 제품개발 업무를 수행한다.","doWork":"고무제품을 개발하기 위하여 실험 방향을 설정하고, 실험을 준비하고 실험 일정계획을 수립하는 가공 랩 실험계획과 목표 가공·성형품의 가공공정을 개발하기 위하여 가공공정 시뮬레이션과 가공공정 최적화 실험을 수행하고, 랩 가공공정 개발결과를 종합하는 가공 랩 공정을 개발한다. 가공 랩 실험 시료의 물리·화학적 특성을 분석하기 위하여 시료의 분석실험 항목과 분석방법을 검토·확정하고, 분석실험 결과 데이터를 토대로 가공 랩 분석법을 개발한다. 가공 랩 실험결과를 바탕으로 생산을 위한 제조공정을 확립하기 위하여 스케일업 공정개발을 계획하고 스케일업 실험 준비 및 관리를 수행한 다음, 실험결과를 종합한다. 고무제품을 개발하기 위하여 연구개발 계획을 수립하고 수행과정 및 결과를 모니터링하며 평가한다. 연구개발 결과의 축적과 활용을 위해 연구단계별 노하우, 지식재산권, 허가 및 인증을 확보한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","certLic":"화공기사, 화공기술사","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007434:1', '{"dJobCd":"K000007434","dJobCdSeq":"1","dJobNm":"고무제품설계자","workSum":"고무제품의 제조개발 및 제품의 성능을 개선하기 위해 제품설계의 기본이론 및 제품설계 지식을 사용하여 사양서 검토, 고무제품 설계, 고무시제품 제작, 원가관리 등의 업무를 수행하고 성능시험원에게 지식을 전달하고 업무를 감독한다.","doWork":"고객의 요구사항을 분석하여 고무제품 설계를 실시하기 전에 품질·가격·납기·생산능력 등을 종합적으로 분석하여 고무 제품 사양서를 검토한다. 고무제품을 제조하기 위하여 제품 도면을 설계하고, 원부재료를 선정하여 부가기능을 설계하는 등 고무제품을 설계한다. 고무제품 양산을 위한 작업 조건을 설정하여 고무제품의 요구특성에 부합하는 최적의 시제품을 제작한다. 제작된 고무 시제품의 성능을 평가하기 위해 시제품 성능평가, 시험설비 점검 등을 수행한다. 고무제품성형 작업의 원가 절감을 위해 원가, 공정 및 품질비용을 분석하여 고무제품의 원가를 관리한다. 최적의 고무제품을 생산하기 위해 생산능력 검토, 공정검토 등 고무제품 생산공정을 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002732:1', '{"dJobCd":"K000002732","dJobCdSeq":"1","dJobNm":"고무제품연구원","workSum":"고무원료와 각종 배합제를 이용해 새로운 합성물질을 연구하고 각종 고무제품의 제조공정을 연구·분석한다.","doWork":"각종 고무제품 제조를 위한 프로세스에 따라 합성물질과 제조공정을 연구·설계·개발하고, 공장 설비를 설치·조작·유지·감독한다. 제조공정 및 재료의 개발이나 개선에 관한 연구를 수행하며, 새로운 제조공정을 개발하고자 기계 및 공법에 관련한 연구를 수행한다. 대단위 단지(Complex)에서는 공장들 간의 공정연계도를 효율적으로 관리해 생산의 효율성을 높인다. 공정별로 발생할 수 있는 위험요소 및 사고유형을 분석하고 이에 대한 대응책을 마련한다. 환경과 안전 측면에서 최신 공정을 잘 반영하기 위한 연구 등을 한다. 각종 고무제품의 제조관련 장치 및 장비를 설계·검사하며, 장치의 운용과 유지, 보수작업을 계획한다. 일관성 확보를 위한 품질관리 프로그램, 운영절차 및 통제전략을 세우고 원료, 제품 및 폐기물이나 배출물에 대한 기준을 확립한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"고무제품기술자","certLic":"화공기사, 화공기술사","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003238:1', '{"dJobCd":"K000003238","dJobCdSeq":"1","dJobNm":"고분자공정연구원","workSum":"고분자 가공에 대한 이론과 압출가공, 사출성형, 코팅, 분산혼련 등의 고분자 가공기술 및 기계와 공정을 연구·개발한다.","doWork":"고분자소재와 소재의 특성에 따른 압출가공, 사출성형, 코팅, 분산혼련 등의 가공설비와 기술의 발전동향을 조사·분석한다. 플라스틱, 합성조직, 페인트 및 플라스틱계 복합재료의 제조특성을 분석한다. 폴리머브랜드(Polymer Bland), 섬유방사, 필름블로잉(Film Blowing), 수치묘사, 표면코팅 등의 기술에 관하여 연구한다. 고분자 소재의 특성과 생산품의 물성에 따라 최적화된 가공설비의 배치 및 온도, 압력, 시간 등 중요한 공정변수를 연구한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002236:1', '{"dJobCd":"K000002236","dJobCdSeq":"1","dJobNm":"농약안전성연구원","workSum":"농약의 이화학, 독성, 잔류성, 생물활성을 평가하여 우수하고 안전한 농약사용기술을 연구·개발한다.","doWork":"농약의 안전사용기준을 설정하기 위한 연구를 한다. 인체에 안전한 농산물을 생산하기 위한 기술을 개발한다. 농약의 독성시험기준과 방법 설정 및 개선 연구, 농약의 독성이 인체에 축적될 때 미치는 영향을 연구한다. 농약이 환경생태에 미치는 독성에 관한 연구를 통하여 해결방안을 수립한다. 농산물 잔류농약을 모니터링하고 노출 및 위해성 평가 연구를 하며, 가공에 의한 잔류농약의 실질적인 섭취에 의한 안전성을 평가한다. 재배환경에서 농약의 잔류전이 이동에 관해 검토 및 평가를 해 잔류농약 경감기술을 개발한다. 농약의 안전성에 대한 종합평가기술을 개발한다. 농약의 원제(약제를 제제할 때 사용하는 유효성분 함유 물질), 제품의 규격설정에 관한 시험 및 연구를 한다. 농약의 사용실태에 관한 조사를 통하여 적절한 사용방법을 연구한다. 농약에 투입되는 원·부제의 특성을 분석하기 위한 연구를 한다. 등록신청농약의 인축(人畜:사람과 가축) 및 생태위해성 평가를 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"시각|","workEnv":"대기환경미흡|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"환경농약잔류연구원, 농약안전성평가연구원, 작물농약잔류연구원","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C204/M701","dJobICdNm":"[C204]기타 화학제품 제조업 / [M701]자연과학 및 공학 연구개발업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002066:1', '{"dJobCd":"K000002066","dJobCdSeq":"1","dJobNm":"농약잔류연구원","workSum":"농약의 안전사용 기준설정에 필요한 자료를 확보하기 위해 토양 및 작물체 중의 농약잔류 수준을 평가하는 연구를 수행한다.","doWork":"분석·실험을 위하여 토양 및 작물에 농약을 살포한다. 토양을 채취하고 작물을 수확한다. 농약성분을 추출하고 유기용매를 사용하여 분액한다. 분액에서 불순물을 제거하고 농축하여 분석한다. 토양 및 작물체 중 미량(ppm, ppb 수준)으로 존재하는 농약의 잔류량을 분석할 수 있는 분석법을 개발한다. 확립된 분석법을 이용하여 대상 시료에 대한 분석을 실시한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C204/M701","dJobICdNm":"[C204]기타 화학제품 제조업 / [M701]자연과학 및 공학 연구개발업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004044:1', '{"dJobCd":"K000004044","dJobCdSeq":"1","dJobNm":"도료연구원","workSum":"가정용 및 산업용 도료의 기술을 연구하고 제품을 개발한다.","doWork":"각종 도료 제품을 개발하고자 전색제(도료의 최종 목적인 도막의 주성분이 되는 것으로서 유지, 합성수지, 고무유도체, 수용성화합물 등이 사용됨), 도막형성 부요소(도료의 분산, 건조, 경화 등 여러 성질의 향상을 위하여 소량 첨가되는 물질), 도막조요소(도료를 칠하기 쉽게 하고자 사용하는 용제로서 알코올류, 탄화수소류, 케톤류, 에테르류 등의 화학물질을 혼합하여 사용됨)에 대해 연구한다. 착색안료, 체질안료, 방청안료, 발광안료, 시온안료 등 여러 가지 특수안료 등을 용도에 따라 첨가하고 혼합비율에 대한 연구를 수행하여 도료를 개발한다. 도료의 도장방법(도막형성 속도, 도료의 조도, 건조압법 등)기준을 제시한다. 각종 인증 및 표준 획득을 위한 시험성적서를 작성한다. 생산부서와 기술적 협의를 한다. 생산 중인 도료의 견본을 채취하여 도장성, 내구성, 표면유연성 등의 품질시험을 한다. 원료, 제품 및 폐기물이나 배출물에 대한 기준을 확립한다. 고객이 요구하는 코팅 용액을 설계하기 위하여 설계요구사항을 파악하고 원재로 혼합비율을 결정하며 배합설계프로세스플 결정한다. 도료의 반제품으로 사용되는 수지를 합성하기 위하여 원재의 특성을 파악하고 설계 요구사항을 파악하여 원재료 혼합비율을 결정한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"대기환경미흡|위험내재|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C204","dJobICdNm":"[C204]기타 화학제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005392:1', '{"dJobCd":"K000005392","dJobCdSeq":"1","dJobNm":"리튬이온전지개발자","workSum":"리튬이온전지의 활물질(Active Material)의 적용 및 설계변경 등을 통해 충전능력과 안전성을 높인 고출력 고용량의 리튬이온전지를 연구·개발한다.","doWork":"제품규격에 따른 최적의 구성과 용도에 따른 활물질(Active Material) 구성을 연구·개발한다. NCM(리튬, 니켈, 코발트, 망간 산화물), LTO(Lithium Titanate Spinel), 포스페이트(Phosphate) 등의 활물질을 제품의 용도에 따라 시제품을 만들어 제품 성능을 테스트하고 신제품을 개발한다. 배터리의 성능·안전성·신뢰성 평가업무를 수행하며 양산제품의 불량원인 등을 분석한다. 제품의 용도 및 종류에 따른 리튬이온전지의 에너지밀도와 수명, 안정성 등 효율을 높이기 위해 상용 활물질(Active Material) 간의 비교 연구를 통해 필요한 가장 효율적인 활물질을 선정하며 제조공정상에 최적의 활물질 코팅량 등을 연구한다. 제조된 리튬이온전지의 안정성과 성능을 테스트하고 제품의 문제점과 성능향상을 위한 개선점을 연구한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C282","dJobICdNm":"[C282]일차전지 및 축전지 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002671:1', '{"dJobCd":"K000002671","dJobCdSeq":"1","dJobNm":"리튬이온전지패키지설계기술자","workSum":"리튬이온전지의 셀을 적층한(층층이 쌓아올린) 모듈과 다수의 모듈을 결합한 패키지제품을 설계·개발한다.","doWork":"설계할 제품의 크기, 무게, 성능 등의 요구특성을 파악한다. 요구특성에 적합하도록 셀을 적층하여 케이스에 넣어 연결한 모듈과 패키징 제품을 디자인하고 전원관리시스템(BMS:Battery Management System)을 결합한 제품을 설계한다. 리튬이온전지의 과열을 방지하기 위해 셀의 배열을 고려한 케이스와 발열구조물을 설계한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","connectJob":"리튬이온전지모듈설계원","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C282","dJobICdNm":"[C282]일차전지 및 축전지 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005958:1', '{"dJobCd":"K000005958","dJobCdSeq":"1","dJobNm":"무기폭약감정관","workSum":"사건에 연루된 무기나 폭약의 탄피, 파편 등을 수집·분석하여 무기나 폭약의 종류, 성분, 강도 등을 밝혀낸다.","doWork":"의뢰된 사건에 대한 사건 경위, 분석요구사항 등을 파악하고 사건의뢰자와 협의한다. 필요하면 현장에서 사건과 관련된 무기나 폭약의 파편, 탄환, 탄피 등을 수거한다. 비교현미경, 가스크로마토그래프, 전자현미경 등을 사용하여 탄환 강선흔 및 탄피 격침흔을 비교·분석하거나 수집된 파편, 그을음 등의 종류, 성분, 강도, 발화점 등을 분석한다. 분석방법, 분석결과, 감정소견 등이 포함된 결과보고서를 작성한다. 검사결과에 대한 의견 개진을 위해 법정에서 증언을 하며, 관련 대상자에게 강의를 하기도 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"O844","dJobICdNm":"[O844]사법 및 공공질서 행정","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007808:1', '{"dJobCd":"K000007808","dJobCdSeq":"1","dJobNm":"바이오소재인증연구원","workSum":"바이오매스로부터 제조되는 친환경소재인 바이오플라스틱을 비롯한 다양한 종류의 바이오화학 소재 및 제품의 인증을 위한 시험·평가한다.","doWork":"바이오 연료 및 단량체, 바이오고분자, 바이오플라스틱등의 제품군내에 포함된 바이오매스 함량을 분석한다. 탄소동위원소 12C, 13C, 14C 중 14C은 5730년의 반감기를 통해 소진되어서 원유에는 포함되어 있지 않은 사실로 비교한다. 퇴비화 조건에서 플라스틱 재료의 호기성 생분해도를 평가한다. 퇴비내 시료가 미생물에 의해 분해되어 발생하는 이산화탄소를 포집하여 분해 정도를 확인한다. 바이오기반 소재 및 제품 내 함유된 원소 및 중금속의 극미량 함량을 분석한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"자문","workFunc3":"조작운전","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C211","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007435:1', '{"dJobCd":"K000007435","dJobCdSeq":"1","dJobNm":"바이오의약품공정개발연구원","workSum":"바이오의약품의 효율적인 생산을 위하여 배양공정, 정제공정, 완제공정을 개발하고 최적화하는 연구를 수행한다.","doWork":"바이오의약품을 생산하는 세포주에 적합한 배지, 배양조건 및 배양공정을 최적화하고 크로마토그래피, 막여과방법등을 이용해서 순도가 높고 수율이 높은 정제공정을 개발하고 최적화하여 효율적인 원액제조공정을 개발한다. 원액으로부터 완제품을 제조하기 위한 충진 및 동결건조등의 방법을 이용하여 최적의 완제공정을 개발하는 연구를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"바이오화학제품제조기사","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C211","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006459:1', '{"dJobCd":"K000006459","dJobCdSeq":"1","dJobNm":"바이오의약품분석법개발원","workSum":"바이오의약품의 이화학적·생물학적 특성을 이용하여 연구, 개발, 생산 과정에서 사용되는 분석방법을 개발한다.","doWork":"바이오의약품의 구조적 특성과 다변성, 생산공정과 유통과정에서 품질에 영향을 미칠 수 있는 다양한 변질 요소를 확인한다. 동일한 바이오의약품이 생산될 수 있도록 통제하기 위해 개발 및 생산 단계에서 채취한 시료의 구조, 당사슬, 물리화학적·생물학적·면역학적 성질 등을 파악하기 위해 크로마토그래프, 분광기, 전기영동기 등의 분석장비를 통해 물리화학적, 이화학적 분석방법을 연구·개발한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"바이오화학제품제조기사","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C211","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006090:1', '{"dJobCd":"K000006090","dJobCdSeq":"1","dJobNm":"바이오작물보호제연구원","workSum":"자연계에 존재하는 물질과 생물체를 이용하여 농작물에 피해를 미치는 병원균, 해충 및 잡초 등을 방제하는 작물보호제를 연구·개발한다.","doWork":"바이오농약 개발을 위해 토양, 하천 등에서 유용 미생물을 분리하여 식물 병해충 방제작용이 있는지 여부를 탐색한다. 분자 생물학적 방식 등을 활용하여 미생물을 동정(생물의 종류와 이름을 확인하는 것)한다. 항균 활성, 항해충 활성, 식물병 유도 저항성, 식물생장촉진 능력 등 미생물의 작용을 평가하고 어떤 과정을 거쳐 식물에 작용하는지 작용기작을 규명한다. 미생물의 배양조건을 규모에서 조사하여 최적 배양 조건을 연구하고 생산 공정 설계 및 제제화 공정을 통해 실제 제품화를 연구한다. 제품이 농업환경에 투입되었을 경우 작물 및 환경에의 안전성을 실험작물에 적용하여 시험한다. 병충해 방제작용을 하는 식물추출물, 식물성오일 등과 같은 천연물질을 탐색하여 개발하고, 유효성분의 추출과 제제화 및 제형화 공정을 통한 제품화를 연구한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"시각|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"생물농약연구원, 바이오농약연구원","connectJob":"미생물농약연구원, 생화학농약연구원","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C204/M701","dJobICdNm":"[C204]기타 화학제품 제조업 / [M701]자연과학 및 공학 연구개발업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006428:1', '{"dJobCd":"K000006428","dJobCdSeq":"1","dJobNm":"바이오플라스틱연구원","workSum":"미생물과 이산화탄소로 분해되는 생분해성 플라스틱이나 식물자원을 원료로 한 바이오매스 플라스틱을 연구·개발한다.","doWork":"다양한 작물계, 목질계, 해조류 등을 대상으로 분해가 되는 고분자와 바이오매스에서 유래된 생분해가 되지 않는 고분자, 그리고 단백질, 셀룰로오즈, DNA 등 플라스틱의 원료가 되는 천연 고분자 물질을 수집하고 연구한다. 전처리기술, 당화기술, 발효기술, 산촉매 등의 전환기술을 통한 플랫폼 화합물 제조 및 이를 이용한 바이오플라스틱 제조기술과 공정을 연구·개발한다. 기존 바이오플라스틱의 물성을 개선하기 위한 기술을 연구하기도 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"화공기술사,  화공분석기사","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C222/M701","dJobICdNm":"[C222]플라스틱제품 제조업 / [M701]자연과학 및 공학 연구개발업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007177:1', '{"dJobCd":"K000007177","dJobCdSeq":"1","dJobNm":"바이오화학분석연구원","workSum":"바이오 화학제품의 생리활성 물질을 분리·정제하여, 구조분석 및 물성을 평가 하고, 효능·효과와의 상관관계를 규명하는 업무를 수행한다.","doWork":"바이오 화학제품의 정량법 문헌연구를 진행하고 분석연구 계획, 초기 연구를 위한 시험방법을 작성한다. 생리활성 물질의 품질목표 설정, 배합 적합성 및 가혹시험, 제품의 안전영향성 분석, 첨가제 선정, 배합비율, 허가 시 제출 범위 등을 고려하여 위험성을 평가한다. 분석법 밸리데이션 시험 수행 및 트러블슈팅, 통계적 자료 도출 및 Raw data를 관리한다. 이화학분석실험, 기기분석실험을 진행하며 분석 후 분석결과 보고서를 작성한다. 비교용출시험 실시 및 트러블슈팅과 비교용출 시험 배치들의 제조 정보 및 성적서를 확인한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C211","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007178:1', '{"dJobCd":"K000007178","dJobCdSeq":"1","dJobNm":"바이오화학소재연구원","workSum":"바이오화학 소재개발을 위해 균주를 발굴하고 대사경로를 규명하며, 생산성 향상을 위해 균주를 개량하고 보존하는 업무를 수행한다.","doWork":"바이오화학 소재를 생산할 수 있는 균주를 탐색, 평가하여 잠재성을 갖춘 우수 균주를 선정한다. 선정한 균주의 유전체 분석을 통해 대사경로를 확인하고 최적 경로를 구축한다. 다양한 생명공학기술을 활용하여 균주의 생산 성능을 개선하고 배양 및 발효 공정을 통해 우수 생산균주를 선별한다. 균주 선정, 개발 과정의 결과물을 기반으로 국내외 논문, 특허를 확보한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C211","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007327:1', '{"dJobCd":"K000007327","dJobCdSeq":"1","dJobNm":"바이오화학제제제형연구원","workSum":"바이오화학 생리활성 물질의 안정성 및 시너지 향상을 위하여, 단순혼합, 코팅, 캡슐, 분말화, 액상화, 제형화 등의 방법을 개발한다.","doWork":"바이오화학 원료의 제조처별 물리화학적 특성을 파악하고 배합적합성 평가를 위한 기능별 부형제 선정 및 통계처리를 수행한다. 제제·제형개발 계획서 작성 및 물리화학적 변화 여부에 대하여 분석하고 예비제형과 최적화된 제형 조성을 선정한다. 연구개발 및 상용화에 필요한 시험법의 종류 선정, 다양한 시험조건들에 대한 영향 실험, 시험표준폼 후보군을 확보 및 확정한다. 제품 품질특성에 관련된 시험법 선정과 검증계획서에 따라 검증을 실시한다. 바이오화학제품 제조 및 공정개선 연구, 공정 최적화 연구, 연구 과정의 계획 및 통계처리를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","certLic":"바이오화학제품제조기사","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C211","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007338:1', '{"dJobCd":"K000007338","dJobCdSeq":"1","dJobNm":"바이오화학제품공정개발기술자","workSum":"바이오화학제품 제조를 위해 배양 최적화, 회수, 분리·정제조건, 농축, 건조, 포장 등 제조공정을 개발하고 양산할 수 있도록 공정을 최적화 및 표준화하는 업무를 수행한다.","doWork":"바이오화학제품 생산의 경제적 운영에 필요한 공정기술 연구를 위해 공정 흐름 및 단위공정을 파악하고 공정 시뮬레이션을 실시한다. 공정개발 계획을 수립하고 공정 테스트를 거쳐 공정 상세설계를 한다. 공정 최적화를 위하여 각종 자료를 수집하고 연구하며, 최적 운전조건을 도출하고 최적 생산계획을 수립한다. 스케일업 공정개발 계획과 스케일업 단위공정 및 장치를 설계하고, 신규공정 개발 계획을 수립하여 신규공정을 개발한다. 생산팀과 운전조건 및 일정을 협의하여 시제품을 생산한다. 고객의 요구 사양을 반영하여 공정을 개선한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"1541","dJobECdNm":"[1541]화학공학 기술자 및 연구원","dJobJCd":"2321","dJobJCdNm":"[2321]화학공학 기술자 및 연구원","dJobICd":"C211","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;