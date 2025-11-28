INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001251:1', '{"dJobCd":"K000001251","dJobCdSeq":"1","dJobNm":"웹툰아트디렉터","workSum":"웹툰의 최종 원고를 검토하고 편집, 수정 및 확정하여 완성도를 높인다.","doWork":"웹툰 스튜디오(웹툰 전문 제작사)의 제작프로젝트 책임자로서 작업 일정을 정한다. 콘티, 작화(선화), 채색, 배경, 후보정 등의 각 제작 파트를 조율한다. 웹툰의 최종 원고를 검토하고 원고의 각 요소를 조화롭게 편집, 수정 및 확정(컨펌)하여 작품 완성도를 높인다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"청각|손사용|언어력|시각|","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"만화아트디렉터, AD(Art Director)","dJobECd":"4113","dJobECdNm":"[4113]출판물 전문가","dJobJCd":"2812","dJobJCdNm":"[2812]출판물 전문가","dJobICd":"J581","dJobICdNm":"[J581]서적, 잡지 및 기타 인쇄물 출판업","inqYear":"2023"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004459:1', '{"dJobCd":"K000004459","dJobCdSeq":"1","dJobNm":"출판물편집자","workSum":"사전, 학습지, 교과서, 단행본, 사보, 잡지 등의 출판물에 수록될 원고를 편집·조정한다.","doWork":"출판물 편집장 및 부서 책임자와 협의한 편집 방침에 따라 잡지취재기자나 작가가 작성한 원고를 검토·평가한다. 독자의 경향과 인성에 관한 지식 등을 근거로 수요를 결정하여 발행부수, 마케팅 방안을 제시한다. 표지 및 본문에 대한 디자인의 구체적인 사항을 출판물의 특성 및 내용에 맞게 출판물 디자이너와 협의하고 관련 내용을 의뢰한다. 원고의 재조정 및 가필·삭제의 필요성에 따라 필자와 협의한다. 출판일자·판권·인쇄부수 등을 조정하기 위하여 저자 및 출판업자와 협의한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"협의","workFunc3":"관련없음","connectJob":"출판물을 기획 및 제작하는 업무를 전문으로 하는 경우 출판물기획자(출판기획자)","dJobECd":"4113","dJobECdNm":"[4113]출판물 전문가","dJobJCd":"2812","dJobJCdNm":"[2812]출판물 전문가","dJobICd":"J581","dJobICdNm":"[J581]서적, 잡지 및 기타 인쇄물 출판업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007267:1', '{"dJobCd":"K000007267","dJobCdSeq":"1","dJobNm":"편집장","workSum":"신문, 잡지, 책 등 각종 출판물을 발간하기 위한 취재·편집 업무를 총괄 관리하고 관련 종사자들의 활동을 감독·조정한다.","doWork":"정치·경제·사회·교육 등 취재 및 편집 분야에 따라 편집계획 및 편집방침 등을 결정한다. 일정에 맞추어 관련 자료 수집업무를 편집진들에게 분담한다. 기사획득, 사실입증 자료준비, 정보의 명료화를 위한 업무를 취재기자, 편집기자들에게 지시한다. 취재 및 편집된 기사를 최종 확인하고 전체적인 면 구성을 계획한다. 필요한 경우 사진, 그림, 삽화 등을 편집디자이너에게 지시한다. 도해자료 및 인쇄자료의 크기와 위치를 지정하기 위하여 견본 페이지를 표시한다. 최종 교정을 검토·승인한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","connectJob":"전문 분야에 따라 신문편집장, 잡지편집장, 출판물편집장","dJobECd":"4113","dJobECdNm":"[4113]출판물 전문가","dJobJCd":"2812","dJobJCdNm":"[2812]출판물 전문가","dJobICd":"J581","dJobICdNm":"[J581]서적, 잡지 및 기타 인쇄물 출판업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006283:1', '{"dJobCd":"K000006283","dJobCdSeq":"1","dJobNm":"e스포츠기자","workSum":"e스포츠 리그 현장 및 선수들을 취재하여 기사를 작성하고 e스포츠 포털사이트에 게시한다.","doWork":"경기 프리뷰를 리뷰한다. 팀전력, 동향 등을 분석한다. 주목되는 경기 및 선수를 파악한다. 해설자 및 방송 관계자와 면담하고 관련 정보를 수집한다. e스포츠 리그, 경기 내용 및 결과, 경기 후 선수단 인터뷰, 현장사진 등 현장취재를 진행하고 기사를 작성한다. 게임단의 감독, 코치, 선수 등을 인터뷰하고 게임단의 전력을 분석한다. 주간 편집회의에 참석하여 기사 아이템을 공유하고 일정을 조정한다. 사진 등 취재 관련 자료를 정리하고 관리한다. 선수들의 프로필을 촬영하거나 팬북을 제작하기도 한다. 게임 관련 커뮤니티나 팬클럽 운영자 등 다양한 취재원과 접촉하여 정보를 수집한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"4120","dJobECdNm":"[4120]기자 및 언론 전문가","dJobJCd":"2813","dJobJCdNm":"[2813]기자 및 언론 관련 전문가","dJobICd":"J581/J602","dJobICdNm":"[J581]서적, 잡지 및 기타 인쇄물 출판업 / [J602]텔레비전 방송업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004327:1', '{"dJobCd":"K000004327","dJobCdSeq":"1","dJobNm":"신문주필","workSum":"신문사 논설위원실의 최고책임자로서 사설과 논설기사 등에 대해 책임진다.","doWork":"논설위원과 함께 사설의 기본 방향, 구체적인 내용, 논조 등을 결정한다. 사설을 작성할 논설위원의 선정을 협의하고 결정한다. 호외의 발행을 지시하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"논설주간","dJobECd":"4120","dJobECdNm":"[4120]기자 및 언론 전문가","dJobJCd":"2813","dJobJCdNm":"[2813]기자 및 언론 관련 전문가","dJobICd":"J581","dJobICdNm":"[J581]서적, 잡지 및 기타 인쇄물 출판업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001224:1', '{"dJobCd":"K000001224","dJobCdSeq":"1","dJobNm":"영상기자","workSum":"정치, 경제, 사회, 국제, 문화 스포츠 등 사회 각 분야에서 발생하는 사건, 사고 및 주요 이슈, 행사, 현상 등을 현장에서 영상으로 촬영하고, 취재한 영상을 자료화하여 편집하고, 새로운 뉴스시사콘텐츠로 개발 및 제작한다.","doWork":"뉴스로 영상보도할 아이템 및 주제를 선별, 확정하여 취재, 보도 계획을 수립 및 기획한다. 각종 사건사고, 행사, 이슈 등이 이루어지는 뉴스현장에 직접 찾아가 현장에서 발생했거나 발생중인 뉴스정보와 관련된 인물 또는 전문의 목격담과 입장, 견해를 영상으로 기록한다. 시청자의 알권리를 추구하고, 취재원의 인권을 보호하면서 영상보도 가이드라인과 취재가이드라인을 바탕으로 취재한다. 시청자들이 뉴스현장과 내용을 이해하기 쉽게 영상으로 구성하고 편집하여 보도한다. 주요 국가 행사, 출입처, 사회적 관심이 큰 취재현장에서는 취재진의 과열을 막고 원활한 취재원의 업무수행을 위해 취재풀단 또는 출입기자단을 구성하고 운영한다. 취재원의 인권보호를 위한 포토라인을 운영한다. 생방송 송출 장비를 활용하여 재난재해, 사회적 관심이 큰 뉴스이슈에 대하여 취재현장에서 라이브로 송출하거나 취재기자의 라이브 리포트를 촬영 및 진행한다. 취재한 영상을 사내 영상자료화 하고, 영상편집을 위한 시스템을 관리한다. 영상자료를 활용한 온라인 및 모바일 뉴스콘텐츠를 제작하고 시사프로그램에서의 활용을 위한 프로그램 포맷을 개발하고 제작한다. 새로운 방송통신기술 개발과 시대적 사회윤리의 변화에 맞춰 영상취재 및 보도 전반에 대한 업무적 변화발전을 연구한다. 취재보도윤리를 강화 및 개선하는 연구 및 활동을 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"언어력|시각|","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"촬영기자, 카메라기자","dJobECd":"4120","dJobECdNm":"[4120]기자 및 언론 전문가","dJobJCd":"2813","dJobJCdNm":"[2813]기자 및 언론 관련 전문가","dJobICd":"J602","dJobICdNm":"[J602]텔레비전 방송업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006997:1', '{"dJobCd":"K000006997","dJobCdSeq":"1","dJobNm":"영상편집기자","workSum":"취재된 기사, 영상, 자료 등을 방송 및 디지털 매체에 보도하기 위하여 영상을 기획, 구성, 편집한다.","doWork":"취재기자가 취재한 기사 내용과 촬영기자가 촬영한 영상을 검토한다. 각 분야(정치, 경제, 사회, 문화, 스포츠 등)의 취재 및 촬영 영상 내용을 파악한다. 수집된 영상 및 자료가 보도기준과 기사내용에 적합한 지 판단한다. 오디오와 영상(촬영본, 자료, 외신 등), CG를 활용하여 영상을 구성하고 편집한다. 제작한 영상을 최종 검수하고 뉴스 송출 부조정실로 전송한다. 뉴미디어 분야의 경우, 온라인 멀티 플랫폼의 특성을 고려하여 콘텐츠 제작을 기획하고 편집한다. 완성한 영상을 디지털매체에 전송한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"방송편집기자","dJobECd":"4120","dJobECdNm":"[4120]기자 및 언론 전문가","dJobJCd":"2813","dJobJCdNm":"[2813]기자 및 언론 관련 전문가","dJobICd":"J602","dJobICdNm":"[J602]텔레비전 방송업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002578:1', '{"dJobCd":"K000002578","dJobCdSeq":"1","dJobNm":"취재기자","workSum":"국내외에서 발생한 주요 사건·사고 및 정보를 텔레비전, 인터넷 등으로 제공하기 위하여 취재한다.","doWork":"범죄·화재 및 교통사고 등 각종 사건·사고현장, 운동경기, 박람회 및 전시회 등 국민의 관심을 불러일으킬 수 있는 정치, 경제, 사회, 문화 등의 각 분야에 대한 정보를 수집한다. 취재기획서를 작성하고 취재관리자에게 보고한다. 관련 현장을 찾아가서 사건의 진행과정 및 결과 등을 취재한다. 수집자료 및 취재내용을 분석 및 정리하고 기사를 작성하여 편집실로 전송한다. 편집기사의 편집업무를 도와주거나 직접 내용을 편집한다. 한 분야만을 전문적으로 취재하기도 하며, 외국에 파견되어 취재하기도 한다. 방송에 직접 출연하여 녹화·녹음하거나 현장에서 생방송으로 중계하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"보도기자","connectJob":"매체에 따라 방송기자, 인터넷기자, 신문기자, 잡지기자, 생활정보지기자, 외국에 주재하여 취재 활동을 하는 경우 특파원","dJobECd":"4120","dJobECdNm":"[4120]기자 및 언론 전문가","dJobJCd":"2813","dJobJCdNm":"[2813]기자 및 언론 관련 전문가","dJobICd":"J581/J601/J602","dJobICdNm":"[J581]서적, 잡지 및 기타 인쇄물 출판업 / [J601]라디오 방송업 / [J602]텔레비전 방송업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007242:1', '{"dJobCd":"K000007242","dJobCdSeq":"1","dJobNm":"콘텐츠큐레이터","workSum":"일반인들이 콘텐츠 및 미디어 시장에 대해 정확하게 이해하고 예측할 수 있도록 콘텐츠 및 미디어 시장에 관하여 주요 정보를 수집, 분석, 평가한다.","doWork":"콘텐츠 및 미디어 시장 전반에 관련된 중요 뉴스기사나 글, 보고서, 동영상 등을 수집하고 정리한다. 콘텐츠의 다양한 시각으로 가치와 의미를 평가하여 글 또는 영상물 등을 통해 전달한다. 다른 사람이 작성한 콘텐츠에 대해 가치와 의미를 평가한다. 자신의 식견이나 통찰력(insight)를 반영한 평론 글을 작성한다. 콘텐츠 및 미디어 시장의 동향과 이해를 돕기 위해 외부 기관에서 강의나 강연을 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"종합","workFunc2":"교육","workFunc3":"관련없음","dJobECd":"4120","dJobECdNm":"[4120]기자 및 언론 전문가","dJobJCd":"2813","dJobJCdNm":"[2813]기자 및 언론 관련 전문가","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2020"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006292:1', '{"dJobCd":"K000006292","dJobCdSeq":"1","dJobNm":"편집기자","workSum":"취재된 기사, 사진 및 자료 등을 신문이나 방송에 보도하기 위한 편집업무를 한다.","doWork":"데스크(편집장)에서 선택한 기사의 정확한 내용을 파악한다. 보도기사의 내용을 보완하기 위하여 보충자료를 수집하여 수정한다. 각 지면(사회, 문화, 경제 등)에 맞도록 기사의 분량과 지면배치, 기사제목을 수정하여 정리한다. 언론회사에서 인터넷으로 띄운 유용한 국내외 기사를 읽고 편집하기도 한다. 입수된 외국의 보도자료를 번역하여 기사로 작성한다. 국내의 자료를 영문으로 번역하여 외국 언론사나 영자신문 기사를 작성하기도 한다. 오탈자를 잡고 문장을 다듬으며 기사의 사실관계를 확인하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"분석","workFunc2":"협의","workFunc3":"관련없음","connectJob":"매체에 따라 방송편집기자, 신문편집기자, 잡지편집기사, 교열기자","dJobECd":"4120","dJobECdNm":"[4120]기자 및 언론 전문가","dJobJCd":"2813","dJobJCdNm":"[2813]기자 및 언론 관련 전문가","dJobICd":"J581","dJobICdNm":"[J581]서적, 잡지 및 기타 인쇄물 출판업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004245:1', '{"dJobCd":"K000004245","dJobCdSeq":"1","dJobNm":"평론가","workSum":"문학작품, 미술, 음악, 연극, 영화 등 예술활동의 가치를 평가하고, 방송 또는 출판을 위한 평론을 작성한다.","doWork":"미술전람회, 음악연주회, 연극공연 등에 참석하거나 영화, 방송 등을 관람하여 작품을 검토한다. 예술작품의 주제, 표현, 기술 등의 요인을 분석한다. 지식, 판단, 경험 등을 근거로 작품을 평론한다. 예술작품에 관련된 자료를 수집하고 일간지, 잡지 등에 칼럼을 쓰거나 논평을 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"예술작품의 전문 분야에 따라 문학평론가, 미술평론가, 연극평론가, 영화평론가, 음악평론가, 대중문화평론가, 무용평론가","dJobECd":"4120","dJobECdNm":"[4120]기자 및 언론 전문가","dJobJCd":"2813","dJobJCdNm":"[2813]기자 및 언론 관련 전문가","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002374:1', '{"dJobCd":"K000002374","dJobCdSeq":"1","dJobNm":"해설위원","workSum":"보도방송을 위하여 정치, 경제, 사회, 스포츠 등 여러 분야의 현상들을 분석하고 논평한다.","doWork":"정치, 경제, 사회, 스포츠 등 각 분야에서 발생하는 현상에 관련된 정보를 수집·분석하여 보도자료를 정리한다. 방송을 통하여 여러 현상에 관련된 논평내용을 설명한다. 정치, 경제, 사회, 문화 등과 같은 특정한 분야를 전문으로 해설하기도 한다. 사회적 쟁점이 되는 사안에 대해 사회여론을 형성하여 이에 대한 해결책을 여론을 통해 마련하도록 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"논설위원","connectJob":"뉴스해설위원, 스포츠해설위원","dJobECd":"4120","dJobECdNm":"[4120]기자 및 언론 전문가","dJobJCd":"2813","dJobJCdNm":"[2813]기자 및 언론 관련 전문가","dJobICd":"J601/J602","dJobICdNm":"[J601]라디오 방송업 / [J602]텔레비전 방송업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005849:1', '{"dJobCd":"K000005849","dJobCdSeq":"1","dJobNm":"게임번역사","workSum":"국내외 다양한 게임들의 콘텐츠를 해당 국가(지역)의 문화에 맞게 번역하고 현지화(Localization)한다.","doWork":"게임 플레이를 통해 해당 게임의 장르, 특성, 세계관을 이해한다. 게임 프로그램에서 추출된 언어팩을 XML 또는 엑셀 파일로 받아 원본을 검토한다. 게임 내 다양한 콘텐츠(시스템 메시지, 유저 인터페이스, 세계관, 캐릭터 설명, 퀘스트, 아이템, 스킬 등)를 해당 지역의 문화를 살려 생생하게 번역한다. 번역이 완료되면 개발사에 보내고 게임 개발사의 품질 테스트 과정에서 번역 내용이 게임의 이미지, 캐릭터, 흐름 등에 맞는지, 텍스트의 길이가 적합한지 최종 검수를 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|언어력|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"4112","dJobECdNm":"[4112]번역가 및 통역가","dJobJCd":"2814","dJobJCdNm":"[2814]번역가 및 통역가","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001873:1', '{"dJobCd":"K000001873","dJobCdSeq":"1","dJobNm":"번역가(일반)","workSum":"외국어를 국문으로, 국문을 외국어로 번역하고 글로 작성한다.","doWork":"번역할 내용을 파악한다. 번역 완료시점 등 번역 관련 사항을 의뢰자와 협의한다. 번역에 필요한 용어, 문화적 배경 등 번역에 필요한 내용을 수집한다. 원문을 연구하여 본래의 사상과 감정을 그대로 살려 해석문을 쓴다. 번역에 대해 감수를 받는다. 원문과의 대조를 통해 누락되거나 잘못 번역된 부분이 없는지 확인한다. 번역된 내용에 대한 수정·보완을 하고 교정작업을 거쳐 최종 번역을 완성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"번역사","connectJob":"영역에 따라 인문번역가, 경영·경제번역가, 과학기술번역가, 번역 언어에 따라 영어번역가, 일어번역가, 중국어번역가, 러시아번역가, 독일어번역가, 스페인어번역가, 불어번역가, 번역 단계에 따라 초벌번역가, 전문번역가, 게임번역가, 지식재산번역가(IP번역가)","dJobECd":"4112","dJobECdNm":"[4112]번역가 및 통역가","dJobJCd":"2814","dJobJCdNm":"[2814]번역가 및 통역가","dJobICd":"M739","dJobICdNm":"[M739]그 외 기타 전문, 과학 및 기술 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007176:1', '{"dJobCd":"K000007176","dJobCdSeq":"1","dJobNm":"번역물품질관리사무원","workSum":"영상, 게임, 웹툰 등의 번역물 수주부터 용역체결, 번역자 섭외 및 번역물 납기관리까지 번역물이 만들어지는 전 과정을 관리한다.","doWork":"번역의뢰자와 납기기간, 용역, 금액, 요구조건 등을 협의하고 계약을 체결한다. 데이터베이스를 통해 번역할 번역가를 파악하고 섭외한다. 번역가와 납기기간, 의뢰자 요청사항 등에 대해서 협의한다. 번역의 완성도 및 일정을 관리한다. 번역결과를 감수자에게 의뢰한다. 번역결과를 의뢰자에게 제공하고 문제점이 있을 시 번역가에게 수정토록 요청한다. 번역에 대한 불만 등을 처리한다. 필요 시 번역 또는 감수를 하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"게임품질보증원(게임QA원), 웹툰품질보증원(웹툰QA원)","dJobECd":"4112","dJobECdNm":"[4112]번역가 및 통역가","dJobJCd":"2814","dJobJCdNm":"[2814]번역가 및 통역가","dJobICd":"M739","dJobICdNm":"[M739]그 외 기타 전문, 과학 및 기술 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005929:1', '{"dJobCd":"K000005929","dJobCdSeq":"1","dJobNm":"수어통역사","workSum":"농아인과 청인의 대화소통을 돕기 위해 음성, 수화(手話), 지화(指話)를 사용하여 통역한다.","doWork":"농아인과 청인에게 통역에 대해 안내하고, 수화통역사를 소개한다. 화자 옆에 서서 음성통역(농아인의 수어를 보고 음성으로 통역)과 수어통역(청인의 음성언어를 수화로 통역)을 사용하여 농아인과 청인의 대화를 통역한다. 농아인과의 많은 대화를 통해 농아인 특유의 관용적 표현을 익힌다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|언어력|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"수화통역가, 수화통역사","certLic":"수화통역사","dJobECd":"4112","dJobECdNm":"[4112]번역가 및 통역가","dJobJCd":"2814","dJobJCdNm":"[2814]번역가 및 통역가","dJobICd":"M739","dJobICdNm":"[M739]그 외 기타 전문, 과학 및 기술 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005937:1', '{"dJobCd":"K000005937","dJobCdSeq":"1","dJobNm":"영상물번역가","workSum":"외국이나 국내에서 제작된 영화·드라마 등의 영상물에 자막을 넣기 위해 대사를 해당 언어로 번역한다.","doWork":"번역할 영화, 드라마, 방송프로그램 등 영상물의 장르 및 줄거리를 확인한다. 번역을 위해 해당 나라의 언어, 역사 및 풍속 등을 연구한다. 원작의 대본을 검토한다. 영상물을 보면서 외국어를 한글로 또는 한글을 외국어로 번역한다. 정해진 글자 수를 넘지 않게 대사를 함축시키고, 각 장면에 적합한 언어를 사용하여 직역 및 의역한다. 컴퓨터를 이용하여 장면을 구분지어 번역한 내용을 작성한다. 번역 후 유행어, 맞춤법 등을 고려하여 수정한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"영화번역가","dJobECd":"4112","dJobECdNm":"[4112]번역가 및 통역가","dJobJCd":"2814","dJobJCdNm":"[2814]번역가 및 통역가","dJobICd":"M739","dJobICdNm":"[M739]그 외 기타 전문, 과학 및 기술 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005213:1', '{"dJobCd":"K000005213","dJobCdSeq":"1","dJobNm":"웹툰번역가","workSum":"국내외 다양한 웹툰을 장르의 특성을 살려 해당 국가(지역)의 문화에 맞게 번역한다.","doWork":"웹툰 번역 내용을 받아 장르, 캐릭터, 세계관 등을 검토한다. 원작자의 의도에 맞추고 해당 지역의 문화를 살려 만화 컷과 말풍선 등의 제약된 공간 안에 글자를 맞춰 번역을 한다. 번역이 완료되면 개발사에 보내고 개발사의 품질 테스트 과정에서 번역 내용이 이미지, 캐릭터, 흐름 등에 맞는지, 텍스트의 길이가 적합한지 검토된 결과를 토대로 수정한다. 번역 외에 번역내용을 감수하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|언어력|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","dJobECd":"4112","dJobECdNm":"[4112]번역가 및 통역가","dJobJCd":"2814","dJobJCdNm":"[2814]번역가 및 통역가","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006925:1', '{"dJobCd":"K000006925","dJobCdSeq":"1","dJobNm":"통신중계사","workSum":"전화통화가 어려운 청각언어장애인 이용자(수어, 문자)와 통화 상대방(음성)의 중간에서 음성, 수어, 문자로 통화내용을 실시간 중계하는 통신중계서비스를 제공한다.","doWork":"청각언어장애인으로부터 수어(영상)로 통화내용을 전달받아 통역한다. 전달받은 내용을 음성으로 상대방인 제3자에게 전달한다. 통화내용(음성)을 다시 청각언어장애인에게 수어(영상)으로 실시간으로 전달한다. 청각언어장애인이 문자로 입력한 통화내용을 전달받는다. 입력받은 내용을 음성으로 상대방에게 전달한다. 상대방의 통화내용(음성)을 청각언어장애인에게 문자로 실시간 전달한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|언어력|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"영상중계사, 문자중계사, TRS(Telecommunications Relay Service)중계사","certLic":"수어통역사, 속기사","dJobECd":"4112","dJobECdNm":"[4112]번역가 및 통역가","dJobJCd":"2814","dJobJCdNm":"[2814]번역가 및 통역가","dJobICd":"O841","dJobICdNm":"[O841]입법 및 일반 정부 행정","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006788:1', '{"dJobCd":"K000006788","dJobCdSeq":"1","dJobNm":"통역가(일반)","workSum":"국제회의, 세미나, 학회, 기자회견, 사업상 미팅 등에서 외국인의 대화나 발표를 우리말로 전달하거나 우리말을 외국어로 전달한다.","doWork":"통역할 주제와 관련된 자료를 수집한다. 국제회의나 세미나, 심포지엄, 포럼 등에 따로 마련된 통역부스 안에서 외국인의 대화나 발표를 듣고 우리말로 전달한다. 자국인의 대화나 발표를 듣고 외국어로 전달한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"통역사","connectJob":"통역 방법에 따라 동시통역사, 순차통역사, 언어에 따라 영어통역사, 불어통역사, 일본어통역사, 중국어통역사, 독어통역사, 통역 분야에 따라 의료통역사, 국제회의통역사, 수행통역사, 스포츠통역사, 사법통역사","certLic":"동시통역사","dJobECd":"4112","dJobECdNm":"[4112]번역가 및 통역가","dJobJCd":"2814","dJobJCdNm":"[2814]번역가 및 통역가","dJobICd":"M739","dJobICdNm":"[M739]그 외 기타 전문, 과학 및 기술 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004149:1', '{"dJobCd":"K000004149","dJobCdSeq":"1","dJobNm":"통역지원사","workSum":"다문화가족지원센터에서 다문화가족의 의사소통을 지원하는 일을 한다.","doWork":"결혼이민자로서 한국어 실력을 인정받아 한국어에 서툰 다른 결혼이민자들을 위해 전화, 이메일, 방문 등의 방법으로 통역 및 번역 서비스를 한다. 입국 초기 상담 및 정보 제공, 가족 간 의사소통 지원, 행정기관·사법기관·병원·보건소·경찰서·학교 등을 이용할 때 필요한 통·번역 서비스, 임신·출산·양육 관련 통·번역 서비스, 생활 상담, 기타 위기상황 시 긴급 지원 등의 업무를 수행한다. 서비스 대상 언어에 따라 중국어, 베트남어, 인도네시아어, 일본어, 영어, 필리핀어, 캄보디아어, 러시아어, 몽골어, 태국어, 네팔어 등을 서비스한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"결혼이민자통역지원사","connectJob":"번역지원사","dJobECd":"4112","dJobECdNm":"[4112]번역가 및 통역가","dJobJCd":"2814","dJobJCdNm":"[2814]번역가 및 통역가","dJobICd":"O845","dJobICdNm":"[O845]사회보장 행정","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006596:1', '{"dJobCd":"K000006596","dJobCdSeq":"1","dJobNm":"국가유산보존가","workSum":"역사적·예술적으로 가치가 있는 건조물, 서적, 미술품, 공예품, 조각품 등의 유형문화유산을 보존·수리·복원하는 업무를 한다.","doWork":"X-선 촬영, 현미경 조사 등의 상태조사와 국가유산분석원의 분석결과를 토대로 금속유물, 수침목재, 목칠공예품, 회화·지류, 토기·도자기, 벽화, 석조물 등의 국가유산 및 예술품의 보존처리 방법을 수립한다. 수립 방법에 따라 이물질 및 손상 원인물질을 약품, 장비 등을 이용하여 제거한다. 분리된 편들을 접합하고, 취약한 국가유산은 강화시킨다. 유물의 제작기법, 원형상 등을 조사한 후 가역성 재료를 사용하여 복원한다. 보존처리 방법, 사용재료 등 보존처리 과정을 기록하고 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"대기환경미흡|위험내재|","workFunc1":"종합","workFunc2":"관련없음","workFunc3":"정밀작업","similarNm":"국가유산보존처리전문가(Conservator), 국가유산보존전문가, 국가유산보존원","connectJob":"국가유산보수기술자(Restorer), 국가유산보존방안연구자(Investigator), 국가유산보존분석가(Analyzer), 고고과학자(Archaeological Scientist), 국가유산보전처리공, 국가유산훈증공","certLic":"문화재수리기술자(보존과학, 보수) → 국가유산수리기술자(보존과학, 보수)\r\n문화재수리기능자(보존처리공) → 국가유산수리기능자(보존처리공)\r\n문화재수리기능자(훈증공) → 국가유산수리기능자(훈증공)","dJobECd":"4131","dJobECdNm":"[4131]학예사 및 문화재 보존원","dJobJCd":"2821","dJobJCdNm":"[2821]학예사 및 문화재 보존원","dJobICd":"R902","dJobICdNm":"[R902]도서관, 사적지 및 유사 여가관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005485:1', '{"dJobCd":"K000005485","dJobCdSeq":"1","dJobNm":"국악연구원","workSum":"국악에 대한 학술·정책을 연구하고 국악 관련 콘텐츠 개발 및 국악기의 연구·개선·복원 업무를 한다.","doWork":"국악에 대한 국내외 학술회의를 준비하여 개최한다. 국악교육 표준화를 위해 민요 표준악보·교육용 국악기 및 콘텐츠를 개발한다. 국악 산업 지표 설계 및 국악교육 현황 통계를 조사하고, 국악연감 등 국악자료집 및 연구보고서를 발간한다. 국내외 국악자료를 조사·수집하고 국악기의 재료·음향·음량을 개선하고 복원한다. 그 외에 연구원(일반)이 수행하는 일반적인 업무를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"청각|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"국악학예사","certLic":"학예사","dJobECd":"4131","dJobECdNm":"[4131]학예사 및 문화재 보존원","dJobJCd":"2821","dJobJCdNm":"[2821]학예사 및 문화재 보존원","dJobICd":"R902","dJobICdNm":"[R902]도서관, 사적지 및 유사 여가관련 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005377:1', '{"dJobCd":"K000005377","dJobCdSeq":"1","dJobNm":"디지털국가유산복원전문가","workSum":"유형유산과 무형유산을 디지털 기술을 활용해 원형대로 복원한다.","doWork":"대상 유물의 특징을 파악하고 3D 스캐너를 통해 정밀하게 촬영한다. 촬영한 데이터를 병합 및 정합하여 3D이미지 형상을 완성한다. 영상 복원에 앞서 2D사진, X-ray, CT사진 등을 통해 표면 및 내부 모습도 관찰하고 고증자료를 조사하여 참고한다. 원형의 모습을 간직한 부분을 선정하고 해체하여 모델링 작업한다. 모델링된 부재들을 기초로 변형된 형상을 수정한다. 스캔 데이터와 복원 데이터를 비교·검토하고 수정사항을 확인한 뒤 최종 검토를 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"디지털복원전문가","dJobECd":"4131","dJobECdNm":"[4131]학예사 및 문화재 보존원","dJobJCd":"2821","dJobJCdNm":"[2821]학예사 및 문화재 보존원","dJobICd":"R902","dJobICdNm":"[R902]도서관, 사적지 및 유사 여가관련 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004385:1', '{"dJobCd":"K000004385","dJobCdSeq":"1","dJobNm":"문화재분석원","workSum":"국가유산을 과학적으로 연구하고 복원 및 보존처리하기 위하여 각종 분석기기를 조작하여 국가유산을 분석한다.","doWork":"국가유산을 포함한 예술품의 분석 의뢰가 들어오면 재질에 따라 시료를 전처리한다. 재질분석을 위한 주사전자현미경(SEM), 원자흡수분광분석기(AAS), X-선형광분석기(XRF:원소분석), 에너지·파장분산형분광기(EDS·WDS) 및 부식화합물을 분석하기 위한 X-선회절분석기(XRD) 등의 분석기를 조작한다. 분석결과를 토대로 국가유산의 성분, 제작 연대, 제작 기술 및 산지 추정 등에 관하여 연구한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"대기환경미흡|위험내재|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"4131","dJobECdNm":"[4131]학예사 및 문화재 보존원","dJobJCd":"2821","dJobJCdNm":"[2821]학예사 및 문화재 보존원","dJobICd":"R902","dJobICdNm":"[R902]도서관, 사적지 및 유사 여가관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003969:1', '{"dJobCd":"K000003969","dJobCdSeq":"1","dJobNm":"박제및표본제작공","workSum":"폐사한 동물을 해부하여 표피를 벗겨 약물로 방부, 방충 처리를 한 후 원래 살아 있을 때의 모습으로 재현한다.","doWork":"박제할 동물이나 조류의 표본을 확보하고 상태를 확인한다. 가죽을 벗겨내고 가죽에 붙어 있는 단백질이나 지방을 일정한 두께로 깎아낸다. 표본을 세척하며 훼손된 부분을 복원한다. 표피를 벗겨 약물로 방부하고 방충 처리를 한다. 동물의 가죽과 근조직 등을 유추해 크기를 설정하고 우레탄, 종이, 호일 등을 넣어 몸통을 만들어 가죽을 씌운다. 눈, 입, 수염 등의 세밀한 작업 후 건조한다. 박제, 표본과 관련된 전시기법을 개발한다. 전시관 내 생물표본의 점검, 보수, 교체 및 관리를 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"박제사, 박제제작공","certLic":"국가유산수리기능자(박제 및 표본제작공)","dJobECd":"4131","dJobECdNm":"[4131]학예사 및 문화재 보존원","dJobJCd":"2821","dJobJCdNm":"[2821]학예사 및 문화재 보존원","dJobICd":"R902","dJobICdNm":"[R902]도서관, 사적지 및 유사 여가관련 서비스업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001840:1', '{"dJobCd":"K000001840","dJobCdSeq":"1","dJobNm":"소장품관리원","workSum":"수집된 국가유산 또는 예술품을 등록하고 보관·관리한다.","doWork":"소장품이나 구입, 기증, 국고귀속 등에 의해 수집된 국가유산이나 예술품을 재질별로 분류하고 유물카드를 작성하여 등록한다. 등록된 소장품을 보존환경이 갖추어진 수장고에 보관하여 관리한다. 소장품의 대여, 보관, 실사 등 출납에 관한 내용을 기록하며, 소장품의 현존 유무를 확인한다. 국내 및 해외전시를 위한 소장품의 대여 시 대여 장소의 보관환경을 점검한다. 소장품의 상태를 조사하여 상태보고서를 작성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"조정","workFunc2":"관련없음","workFunc3":"제어조작","similarNm":"레지스트라, 예술품관리원","dJobECd":"4131","dJobECdNm":"[4131]학예사 및 문화재 보존원","dJobJCd":"2821","dJobJCdNm":"[2821]학예사 및 문화재 보존원","dJobICd":"R902","dJobICdNm":"[R902]도서관, 사적지 및 유사 여가관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004112:1', '{"dJobCd":"K000004112","dJobCdSeq":"1","dJobNm":"영화복원원","workSum":"영화필름 보존소를 운영하며 시간이 경과하여 상영이 불가능하거나 영상품질이 떨어진 필름을 원상태에 가깝게 복원한다.","doWork":"수집된 영화필름 및 부가자료(영화제작기록 노트, 포스터, 홍보물, 스틸자료 등)를 보존 장소에 보관하고 주기적으로 유지·관리한다. 영화필름의 보존주기 및 복원가치와 목적에 따라 복원할 필름을 선정한다. 원본 필름의 품질, 보존한계, 복원비용 등을 고려하여 복원유형(원본 보전을 위한 부분복원, 필름을 필름으로 복제, 복원 결과물의 저장 및 활용 방식)과 복원방법(아날로그 복원, 디지털 복원, 부분 디지털 복원, 손상부분만 복원)을 결정한다. 복원할 필름의 종류, 상태, 필름 캔 위의 정보를 점검한다. 필름의 길이를 측정하고 퍼포레이션(Perforation:영사기의 스프로킷과 핀에 맞물릴 수 있도록 필름 가장자리에 일정한 간격으로 뚫린 구멍)의 훼손상태, 스크래치가 발생한 부분, 인화물질의 농도값, 필름의 수축상태, 필름의 휨상태 등을 측정한다. 기술적으로 복원 가능한 상태인지 검토하고 필요시 외부의 기술지원을 받는다. 영사기 오일이나 곰팡이와 같은 오염물질을 화학용액, 물 등을 이용하여 세척하고 PTR로울러(Particle Transfor Roller:특수 제작된 연질의 폴리우레탄 롤러의 점착성을 이용해 필름의 이물질을 제거)를 사용하여 이물질을 제거한다. 퍼포레이션 등 필름의 찢어진 부분을 수작업으로 접착하여 복원한다. 사운드를 체크하고 사운드 보정 프로그램을 사용하여 보정한다. 복원된 필름을 새 필름에 현상하여 복원된 필름을 만든다. 필요시 영화 후반 편집 작업과 유사한 보정작업을 진행하기도 한다. 영화필름의 부분 또는 전부를 디지털 방식으로 복원하는 경우, 복원할 필름을 프레임 하나씩 디지털로 스캔해서 디지털 이미지로 변환하고, 컴퓨터 프로그램을 사용하여 먼지 제거, 스크래치 복원, 화면떨림 보정, 잡음 제거, 색 보정, 사운드 보정 등의 작업을 진행한 후, 복원된 이미지를 사용하여 최종 파일을 만들고 보관용 필름 또는 상영용 필름, 디지털 시네마 파일, 디지털 콘텐츠 파일을 만든다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"청각|손사용|시각|","workFunc1":"분석","workFunc2":"관련없음","workFunc3":"정밀작업","dJobECd":"4131","dJobECdNm":"[4131]학예사 및 문화재 보존원","dJobJCd":"2821","dJobJCdNm":"[2821]학예사 및 문화재 보존원","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007688:1', '{"dJobCd":"K000007688","dJobCdSeq":"1","dJobNm":"전시레지스트라","workSum":"전시작품의 운송(반입·반출), 설치·철거 및 보험 업무를 계획하고 해당 작업을 점검 및 관리·감독한다.","doWork":"전시 출품작의 대여를 위한 보험, 운송, 설치, 전시 환경 등의 사항을 검토하고 진행 일정을 수립한다. 대여가 완료된 작품에 대해 작품 보험 가입을 추진한다. 국내외 대여 작품의 운송 계획을 수립·추진하고 실행 과정에서 세관·통관 등 국제 및 국내 운송 절차 등 제반 업무를 처리한다. 운송된 전시 작품의 설치 및 철거 계획을 수립하고, 진행 상황을 관리·감독하며 기록한다. 작품의 전시 및 임시 보관 환경을 검토하여 작품 보호 조치를 취하고, 전시 중 작품 상태의 변화를 관리·기록한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|시각|","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"전시운영원, 레지스트라","connectJob":"소장품관리원(소장품레지스트라)","dJobECd":"4131","dJobECdNm":"[4131]학예사 및 문화재 보존원","dJobJCd":"2821","dJobJCdNm":"[2821]학예사 및 문화재 보존원","dJobICd":"R902","dJobICdNm":"[R902]도서관, 사적지 및 유사 여가관련 서비스업","inqYear":"2025"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002722:1', '{"dJobCd":"K000002722","dJobCdSeq":"1","dJobNm":"학예연구사","workSum":"박물관, 미술관, 화랑 등에서 소장품에 대한 관리, 전시기획, 학술연구 등의 업무를 수행한다.","doWork":"전시회를 개최하기 위해 전시 목적·유형·규모 등을 결정하고, 자료 및 시장조사를 통해 전시기획서를 작성한다. 제작연도, 종류, 출토지역 등에 따라 소장품의 종류를 검토·분석하여 전시대상 소장품을 선별한다. 전시대상 소장품의 도록과 전시 홍보자료를 제작한다. 전시장의 소장품을 진열하고 관리한다. 전시 개막식을 준비하는 등 전시와 관련한 업무를 총괄한다. 소장품의 수집이나 대여, 기탁 등을 기획하고 관리한다. 소장품에 대해 연구하고 보고서 및 출판물을 발간한다. 관람객 또는 일반인을 대상으로 교육프로그램을 기획·관리한다. 외국 문화재의 국내 전시 및 국내 문화재의 해외 전시를 기획하기도 한다. 소장품의 진품 여부나 가치 등을 감정하기도 한다. 전시를 위해 작가 및 작품을 섭외하기도 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"종합","workFunc2":"협의","workFunc3":"관련없음","similarNm":"큐레이터, 학예사, 전시기획자","connectJob":"동물원에서 일하는 경우 동물원큐레이터","certLic":"정학예사, 준학예사","dJobECd":"4131","dJobECdNm":"[4131]학예사 및 문화재 보존원","dJobJCd":"2821","dJobJCdNm":"[2821]학예사 및 문화재 보존원","dJobICd":"R902","dJobICdNm":"[R902]도서관, 사적지 및 유사 여가관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001901:1', '{"dJobCd":"K000001901","dJobCdSeq":"1","dJobNm":"기록연구사","workSum":"행정기관, 대학, 공사·공단, 기업, 단체 등의 기록물의 체계적인 관리를 위한 분류, 평가, 보존, 활용 등의 업무를 수행한다.","doWork":"국가기록원과 같은 영구기록물관리기관 및 행정기관, 공사·공단, 대학 등의 기록관에서 또는 기업, 단체, 개인 등의 영역(조직)에서 기록물관리를 담당한다. 해당 기관(단체)의 조직과 기능, 업무환경 등을 조사·분석하여 기록관리 계획을 수립한다. 업무기능에 기반한 기록물 처리 일정표를 작성하여 기록물을 분류하고 보존기간을 책정한다. 영구 보존할 기록과 폐기할 기록을 선별·평가한다. 기관의 유형과 업무기능에 따라 기록물을 이관하기도 하고 가치 있는 기록을 수집하기도 한다. 보유기록을 안전하게 보존하고 이용자가 이용할 수 있도록 돕는다. 궁극적으로 조직의 설명책임성을 보장하여 신뢰도를 높이고, 역사적으로 중요한 기록물을 후대에 전승하는 역할을 담당한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"기록물관리전문요원","certLic":"기록물관리전문요원","dJobECd":"4132","dJobECdNm":"[4132]사서 및 기록물 관리사","dJobJCd":"2822","dJobJCdNm":"[2822]사서 및 기록물 관리사","dJobICd":"O841/O842/R902","dJobICdNm":"[O841]입법 및 일반 정부 행정 / [O842]사회 및 산업정책 행정 / [R902]도서관, 사적지 및 유사 여가관련 서비스업","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002010:1', '{"dJobCd":"K000002010","dJobCdSeq":"1","dJobNm":"미술아키비스트","workSum":"미술 기록을 평가, 수집, 정리, 보존, 관리하고 검색을 제공한다.","doWork":"미술계의 정보를 상시적으로 탐색한다. 작가 및 유족의 기증, 방문수집, 전시회 자료, 미술품 유통경로 등 다양한 방법으로 미술자료 및 정보를 수집한다. 기록의 진본성과 맥락을 유지하기 위해 기록생산정보 및 기록 사이의 관계를 기록한다. 미술작품, 도록, 엽서, 홍보물, 간행물, 평론, 방명록, 전시기사, 작가노트 등 수집된 자료를 평가하여 보존할 기록과 폐기할 기록을 선별한다. 기록 보유기간을 결정하고 기록 처분 일정을 승인한다. 작가별, 작품별, 종류별, 시대별 분류체계를 수립하고 색인화 한다. 자료를 미술아카이브 매니지먼트 시스템에 등록하고 열람 서비스를 제공한다. 실물자료를 보존, 유지하고 반출·반입을 관리한다. 자료 반출 시 보험에 가입하거나 대여료를 정산하기도 한다. 기록보존에 관련된 행정업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"미술기록보존전문가, 미술기록연구사, 미술기록물관리자","certLic":"준학예사, 정학예사(1급, 2급, 3급)","dJobECd":"4132","dJobECdNm":"[4132]사서 및 기록물 관리사","dJobJCd":"2822","dJobJCdNm":"[2822]사서 및 기록물 관리사","dJobICd":"R902","dJobICdNm":"[R902]도서관, 사적지 및 유사 여가관련 서비스업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007532:1', '{"dJobCd":"K000007532","dJobCdSeq":"1","dJobNm":"사서","workSum":"도서관 및 자료실에서 도서 및 자료를 관리하고 이용자가 원하는 자료를 대출 및 수납하는 업무를 한다.","doWork":"책, 비디오, DVD, 연간물 등 이용자가 희망한 자료나 신간자료를 구입한다. 구입한 자료에 등록번호인 바코드를 붙이고 책 윗면, 아랫면에 도장을 찍는다. 자료명칭, 저자, 출판사항, 분류 및 주제명 등을 확인하여 컴퓨터에 입력한다. 자료에 숫자와 문자의 기호체계가 적힌 각각의 라벨을 붙인다. 관련 코너로 운반하여 서가상에 배열한다. 이용자에게 자료를 대출하고 반납된 자료를 확인하여 정리한 후 배열한다. 대출 및 반납자료의 현황을 파악하고 주제별, 자료형태별로 이용률을 계산하여 장서개발에 필요한 자료를 작성한다. 이용자들이 원하는 자료를 찾아주는 참고봉사를 하며, 모든 자료들이 배치되어 있는지 장서점검을 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"주제전문사서, 사서교사","certLic":"준사서, 정사서, 사서교사","dJobECd":"4132","dJobECdNm":"[4132]사서 및 기록물 관리사","dJobJCd":"2822","dJobJCdNm":"[2822]사서 및 기록물 관리사","dJobICd":"R902","dJobICdNm":"[R902]도서관, 사적지 및 유사 여가관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005701:1', '{"dJobCd":"K000005701","dJobCdSeq":"1","dJobNm":"영상필름관리원","workSum":"영상필름을 수집하고, 자료 활용을 위한 보존·관리 업무를 한다.","doWork":"필름을 인수하여 종류 및 수량을 확인한다. 필름을 권수별로 구분하여 길이를 측정한다. 필름의 손상된 부분을 제거하거나 파손부위를 편집하여 원상태로 복원한다. 약품을 사용하여 필름을 세척한다. 필름의 변질이나 먼지유입을 방지하기 위하여 비닐로 밀봉·포장한다. 밀봉한 필름을 보관용 캔에 넣고 테이프로 밀봉한다. 필름보관용 캔의 표면에 제작연도, 제목, 주연배우, 감독 등 영상물의 정보를 기록하여 부착하고 필름보관실에 순서대로 정렬한다. 필름보관실의 온도, 습도 등을 조절하고 수시로 측정기기의 상태를 확인·기록한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"수동조작","dJobECd":"4132","dJobECdNm":"[4132]사서 및 기록물 관리사","dJobJCd":"2822","dJobJCdNm":"[2822]사서 및 기록물 관리사","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005435:1', '{"dJobCd":"K000005435","dJobCdSeq":"1","dJobNm":"VFX수퍼바이저","workSum":"영화 등 영상물의 시각효과(VFX:Visual Effects)를 총괄한다.","doWork":"제작하려는 영상물의 시나리오를 받아 분석하고 비주얼적 아이디어를 제공하여 전체 콘셉트를 잡는다. 콘셉트에 의한 사전 시각화 작업을 통해 감독과 협의를 한다. 촬영이 시작되면 촬영감독, 조명감독, 미술감독 등 촬영 스태프와 협의를 통해 역할 분담을 한다. 2D팀과 3D팀의 작업상황을 확인하고 전체 일정에 맞춰 완성도를 높이기 위하여 각 팀의 업무를 조율한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","connectJob":"vfx아티스트","dJobECd":"4161","dJobECdNm":"[4161]감독 및 기술감독","dJobJCd":"2831","dJobJCdNm":"[2831]감독 및 기술 감독","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006509:1', '{"dJobCd":"K000006509","dJobCdSeq":"1","dJobNm":"VFX코디네이터","workSum":"성공적인 프로젝트를 위해 VFX(시각효과) 팀 및 구성원 간의 소통을 촉진하고 조율한다.","doWork":"VFX수퍼바이저와 팀코디네이터와 함께 효율적 작업을 위하여 리소스를 배치하고 스케줄링한다. 성공적인 프로젝트 관리를 위해 일정과 예산을 VFX수퍼바이저와 협의한다. 마스터 스케줄, 업데이트 스케줄, 리소스 스케줄을 관리하고 프로덕션 책임자와 클라이언트에게 주 단위의 프로세스를 보고한다. 프로젝트를 위한 아웃소싱 입찰관리를 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"VFX프로듀서","dJobECd":"4161","dJobECdNm":"[4161]감독 및 기술감독","dJobJCd":"2831","dJobJCdNm":"[2831]감독 및 기술 감독","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005027:1', '{"dJobCd":"K000005027","dJobCdSeq":"1","dJobNm":"게임개발프로듀서","workSum":"게임의 기획·예산·제작에서부터 마케팅까지 게임 개발의 전반적 사항을 총괄한다.","doWork":"게임기획자가 기획한 내용을 살펴보고 상품성에 대해 평가한다. 상품화가 결정이 나면 게임제작의 일정, 제작 예산 등을 총괄한다. 게임시나리오작가, 게임프로그래머, 게임그래픽디자이너, 게임음악가 등 필요한 인원을 구성한다. 게임제작의 전반적인 요소들을 정리하고 연출한다. 게임제작 진행과정을 보고 받고 마감시기를 놓치지 않도록 팀원 간 업무를 조율한다. 팀원 간 의사소통을 책임진다. 게임 제작이 진행되는 동안 게임마케터와 함께 마케팅과 홍보에 대한 전략을 수립한다. 게임의 테스트 과정에 참여한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","similarNm":"게임피디(PD), 게임제작감독, 게임연출자","certLic":"게임기획전문가","dJobECd":"4161","dJobECdNm":"[4161]감독 및 기술감독","dJobJCd":"2831","dJobJCdNm":"[2831]감독 및 기술 감독","dJobICd":"J582","dJobICdNm":"[J582]소프트웨어 개발 및 공급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003776:1', '{"dJobCd":"K000003776","dJobCdSeq":"1","dJobNm":"게임방송연출가","workSum":"게임방송에서 각 게임마다 최적의 게임흐름을 보여주고 현장감 있는 게임방송을 연출한다.","doWork":"게임 장르별 특징, 시청자의 연령대와 선호도, 게임플레이, 게임VOD, 모니터링 자료를 분석한다. 해설자와 연출 내용을 협의한다. 출전 선수의 전략을 파악한다. 카메라 커팅 및 팬(카메라의 움직임, 장면전환, 포커스, 특수효과 등)을 적용한다. 해설자의 해설, 선수의 전략 및 플레이, 다양한 각도의 카메라, 경기의 진행, 게임 화면, 현장감 등을 구성하여 게임방송을 연출한다. 게임방송에 필요한 장비를 설치하고 관리한다. 방송장비 사고를 방지하고 필요시 교체 및 보수한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"정밀작업","dJobECd":"4161","dJobECdNm":"[4161]감독 및 기술감독","dJobJCd":"2831","dJobJCdNm":"[2831]감독 및 기술 감독","dJobICd":"J591/J602","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업 / [J602]텔레비전 방송업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005465:1', '{"dJobCd":"K000005465","dJobCdSeq":"1","dJobNm":"게임방송촬영감독","workSum":"현장감 있는 게임경기 영상을 촬영하여 현장의 관객 및 게임방송 시청자에게 보여준다.","doWork":"카메라 배치를 계획하고, 제작팀, 조명감독, 오디오감독, 무대감독, 광고팀, 출연자 등과 협의하여 촬영을 기획한다. 게임경기에 따라 스튜디오촬영, 야외촬영을 진행한다. 방송프로그램에 따라 촬영인원을 배치하고 일정 및 편성표를 관리한다. 게임방송국의 통합방송시스템을 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"청각|시각|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","dJobECd":"4161","dJobECdNm":"[4161]감독 및 기술감독","dJobJCd":"2831","dJobJCdNm":"[2831]감독 및 기술 감독","dJobICd":"J591/J602","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업 / [J602]텔레비전 방송업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001786:1', '{"dJobCd":"K000001786","dJobCdSeq":"1","dJobNm":"게임방송프로듀서","workSum":"게임방송프로그램이나 게임대회를 기획하고 제작한다.","doWork":"연출할 게임방송프로그램이나 게임대회의 성격을 파악한다. 게임방송프로그램 연출 시 제작방향을 설정한다. 스태프와 출연진을 구성한다. 조명감독, 음향감독, 기술감독 등 제작기술직 종사자들과 일정을 협의하여 결정한다. 무대설치, 소품준비 등을 지시하여 방송을 총지휘한다. 게임대회 연출 시 중계가능 여부 및 방송에 적합한 시스템 개발 여부를 판단한다. 게임전문 캐스터 및 해당 게임의 정보를 효과적으로 전달할 수 있는 해설가를 섭외하기도 한다. 예선전을 진행하여 참가선수를 확보한다. 대회의 규칙을 제정하고 맵(MAP)을 선정한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"수동조작","similarNm":"게임방송연출가, 게임방송PD","dJobECd":"4161","dJobECdNm":"[4161]감독 및 기술감독","dJobJCd":"2831","dJobJCdNm":"[2831]감독 및 기술 감독","dJobICd":"J602","dJobICdNm":"[J602]텔레비전 방송업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007460:1', '{"dJobCd":"K000007460","dJobCdSeq":"1","dJobNm":"광고영상감독","workSum":"광고주의 의도와 목적에 따라 광고 영상물을 제작한다.","doWork":"상업용 영상물을 형태(동영상, 정지화상)와 목적(광고용, 홍보용 등) 등에 맞게 제작하기 위하여 연출콘티를 작성한다(콘티작가에게 기초작성 의뢰). 스태프와 협의하여 촬영스케줄을 잡는다. 촬영감독과 협의하여 촬영하고 그 결과물을 평가하여 완성하다. 현상 및 텔레시네(Telecine:필름으로 제작된 영상물을 비디오용 포맷으로 변환하는 작업)작업 의뢰를 지시한다. 음향효과와 컴퓨터그래픽 작업을 의뢰하여 최종 영상물을 완성한다. 최종 영상물이 만들어지면 제작주와 시사회를 갖고 추가사항이나 변경사항 등에 대해 협의한다. 공중파방송의 경우 방송심의를 의뢰하여 경우에 따라 수정한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","dJobECd":"4161","dJobECdNm":"[4161]감독 및 기술감독","dJobJCd":"2831","dJobJCdNm":"[2831]감독 및 기술 감독","dJobICd":"M713","dJobICdNm":"[M713]광고업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005235:1', '{"dJobCd":"K000005235","dJobCdSeq":"1","dJobNm":"광고음향기획원","workSum":"TV, 라디오 등의 광고물 제작에 사용되는 각종 음향물을 제작하고 연출한다.","doWork":"광고영상연출기획원, 상업용영상물제작감독, 광고주담당자 등과 협의하여 광고전략에 맞는 음향을 기획한다. 광고영상에 맞는 음향을 제작하기 위하여 광고음악제작자 등에게 광고음향 제작을 의뢰한다. 특수음향을 제작하기 위해서 컴퓨터음성합성을 기획하기도 한다. 기존에 있는 음향(음악 포함)을 사용하면 저작권과 관련한 문제를 저작권자와 협의한다. 적합한 효과음을 채집하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"청각|","workFunc1":"종합","workFunc2":"협의","workFunc3":"관련없음","similarNm":"오디오피디(Audio Producer), BGM(Back-Ground Music)기획원","dJobECd":"4161","dJobECdNm":"[4161]감독 및 기술감독","dJobJCd":"2831","dJobJCdNm":"[2831]감독 및 기술 감독","dJobICd":"M713","dJobICdNm":"[M713]광고업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001245:1', '{"dJobCd":"K000001245","dJobCdSeq":"1","dJobNm":"광고제작연출감독","workSum":"광고주 혹은 광고대행사와 계약에 의해 기획된 광고표현물(인쇄나 전파 등)을 제작한다.","doWork":"광고영상감독에게 광고물의 제작 감독 및 일정 조정에 대한 권한을 위임하여, 촬영기사, 조명기사, 음향기사, 영상기사 등과 공동작업을 하도록 지시한다. 제작 후 제작물에 각종 영상 효과를 부여하기 위하여 영상효과원, 키네코기사 등에게 추가적인 작업을 지시한다. 포스트프로덕션(Post-Production) 회사에 영상물사후제작(색보정, 특수효과, 음향편집 등) 완성 등의 추가적인 작업을 의뢰토록 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","similarNm":"광고제작감독, 씨에프감독(CF감독), CF(Commercial Film)감독","dJobECd":"4161","dJobECdNm":"[4161]감독 및 기술감독","dJobJCd":"2831","dJobJCdNm":"[2831]감독 및 기술 감독","dJobICd":"M713","dJobICdNm":"[M713]광고업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006389:1', '{"dJobCd":"K000006389","dJobCdSeq":"1","dJobNm":"교양프로그램프로듀서","workSum":"교양프로그램(스튜디오에서 녹화하는 정보나 토크 혹은 가벼운 오락 프로그램)을 기획·제작 총괄하고 관련 종사원들의 활동을 지휘한다.","doWork":"방송편성의 기본 방향과 방송법, 심의기준, 방송강령, 제작 가이드라인을 숙지한다. 프로그램 아이디어 창출을 위한 기획회의를 한다. 아이디어에 따른 예비조사 자료를 수집한다. 특정 분야의 전문가에게 자문을 구하기도 한다. 프로그램의 제작방식을 정하고 기본 구성작업(토론, 인터뷰, 방청객 여부, 스튜디오, 생방송, 녹화방송, 제작소요시간 등)을 한다. 제작비 추정 예산안을 작성한다. 기획회의 보고서 및 제작기획서를 제출하고 결재를 받는다. 제작진행표를 작성하고 큐시트, 대본, 제작일정표를 작성한다. 출연자를 섭외한다. 스태프 회의를 통해 프로그램의 구성개요, 요점, 목표전달, 프로그램 유형, 세트 위치, 연출의 주요 무대, 제작진행 상의 특별한 계획, 효과구성 등을 세부적으로 기획·수립·전달한다. 야외 취재 및 사전 헌팅을 하기도 한다. 세트디자인 및 소품회의를 진행한다. 음악, 음향효과 관련 협의를 한다. 컴퓨터 그래픽, 애니메이션, 특수효과, 캡션 등을 협의한다. 인서트용 편집을 한다. 홍보전략을 구상하고 홍보문안 및 사전 자료를 준비한다. 녹화 전 최종점검(자막, 소도구, 애니메이션, 인서트용 등)을 한다. 카메라 리허설을 진행하기도 한다. 방송녹화(또는 생방송)를 진행·관장한다. 제작분석 평가 및 시청자 반응을 검토한다. 제작하는 프로그램의 종류에 따라 인터뷰 프로그램, 토론 프로그램, 여성 프로그램, 어린이 프로그램, 종교 프로그램 등을 제작한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"교양방송연출가, 교양PD","dJobECd":"4161","dJobECdNm":"[4161]감독 및 기술감독","dJobJCd":"2831","dJobJCdNm":"[2831]감독 및 기술 감독","dJobICd":"J591/J602","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업 / [J602]텔레비전 방송업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005992:1', '{"dJobCd":"K000005992","dJobCdSeq":"1","dJobNm":"뉴스프로듀서","workSum":"뉴스 제작을 기획·총괄하고, 관련 종사원들의 활동을 지휘·감독한다.","doWork":"뉴스 아이템이 각 팀(사회부, 국제부, 경제부, 문화부 등)별로 배정되고 나면 큐시트 가안을 만들어서 스태프나 관계자들에게 전달한다. 영상 편집과 앵커 멘트를 준비시킨다. 중계차나 전화연결 준비가 되었는지 점검한다. 아이템별로 리포트들이 준비되면 각 담당 기자에게 리포트의 시간 분량을 파악하고 전체 뉴스 진행시간과 맞는지 조정하며 자막을 체크한다. 이펙트(앵커가 멘트할 때 화면 아래에 또는 좌우측 상단에 표시되는 자막)을 만들고 점검한다. 헤드라인(그 날의 뉴스 중 가장 대표적인 뉴스 몇 가지를 뽑아 제목을 간략하게 요약한 것)과 간추린 뉴스기사의 자막을 작성한다. 기자들이 만들어온 리포트 테이프가 뉴스 순서에 맞게 플레이되도록 정리한다. 뉴스 생방송 진행 중에 부조종실에서 기술감독, 앵커, 카메라감독, 비디오 담당자, 자막 담당자 등에게 큐사인을 주며 진행을 지휘한다. 큐시트에 맞게 시간을 체크하고 정확한 시간에 종료될 수 있도록 시간관리 및 전체적인 진행을 총괄한다. 방송 중 예상치 못한 상황에 적절히 대응한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","similarNm":"방송연출가, 뉴스PD","dJobECd":"4161","dJobECdNm":"[4161]감독 및 기술감독","dJobJCd":"2831","dJobJCdNm":"[2831]감독 및 기술 감독","dJobICd":"J591/J602","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업 / [J602]텔레비전 방송업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004993:1', '{"dJobCd":"K000004993","dJobCdSeq":"1","dJobNm":"드라마프로듀서","workSum":"방송드라마의 기획, 구성 및 제작과정 전반을 기획·총괄하고 관련 종사원들의 활동을 지휘·감독한다.","doWork":"드라마의 제작 목적, 시청 대상 등을 설정하고 드라마 기획안을 작성한다. 연출자, 제작부서의 간부, 편성 관계자 등과 기획협의를 하고 기획안을 채택한다. 제작예산을 수립하고 신청한다. 작가와 연출자를 선정한다. 작품의 내용, 방향, 구성, 소재 등에 대하여 전반적인 협의를 하여 작가가 대본 집필을 시작하도록 한다. 이미 작성된 대본의 경우 원작료 지불에 대한 협의를 한다. 사내 인력으로 제작스태프(스튜디오 카메라, 기술스태프, 미술스태프, 스크립터, FD 등)을 조직하거나 필요시 외부 용역으로 구성한다. 배역을 캐스팅한다. 대본연습, 제작스태프 회의, 음악, 음향효과, 세트, 의상, 소품, 분장, 야외녹화, 스튜디오 녹화, 드라이 리허설, 카메라 리허설, 타이틀 제작 등 제작 전반에 관여하며 비용을 정산한다. 편집을 한다. 방송심의를 받는다. 시사회 및 홍보를 기획하고 진행한다. 장소협찬 및 PPL(Product PLacement:영화나 드라마 속에 상품을 소품으로 등장시키는 광고)을 결정하기도 한다. 시청률을 검토한다. 해외판매 전략을 수립하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"드라마방송연출가, 기획PD, 제작PD","dJobECd":"4161","dJobECdNm":"[4161]감독 및 기술감독","dJobJCd":"2831","dJobJCdNm":"[2831]감독 및 기술 감독","dJobICd":"J591/J602","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업 / [J602]텔레비전 방송업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004421:1', '{"dJobCd":"K000004421","dJobCdSeq":"1","dJobNm":"디지털크리에이터","workSum":"유튜브 등 광고기반 플랫폼에 개인의 영상 콘텐츠를 제작하여 올리고 이를 통해 수익을 창출한다.","doWork":"촬영하고 싶은 영상 주제를 선정한다. 주제에 맞는 내용을 수집하고 정한다. 대사, 출연진, 촬영구도 등 영상 촬영계획을 수립하고 제작한다. 촬영 시 도움을 받을 경우 담당 PD와 영상연출에 대해 논의한다. 촬영 후 편집하고 유튜브 등 광고기반 플랫폼에 영상을 올린다. 홍보, 광고 등을 목적으로 각종 이벤트에 참여하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"1인크리에이터, 온라인콘텐츠창작자, 인터넷 방송인, 미디어콘텐츠창작자","connectJob":"BJ, 인플루언서, 유튜버, 인스타그래머, 스트리머","dJobECd":"4161","dJobECdNm":"[4161]감독 및 기술감독","dJobJCd":"2831","dJobJCdNm":"[2831]감독 및 기술 감독","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2024"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006667:1', '{"dJobCd":"K000006667","dJobCdSeq":"1","dJobNm":"라디오프로듀서","workSum":"라디오프로그램을 기획·제작 총괄하고 관련 종사원들의 활동을 지휘·감독한다.","doWork":"방송 편성 의도를 파악하고 제작기획서(프로그램명, 방송일시, 제작의도, 주제 및 내용, 주요 진행자, 제작비 소요내역 등)를 작성하여 결재를 받는다. 프로그램의 제작이 결정되면 구체적인 기획·구성을 한다. 라디오방송작가와 함께 방송원고를 작성 및 검토한다. 출연자를 섭외하거나 섭외를 지시한다. 채널, 시간대, 청취대상, 프로그램 성격을 고려하여 시그널 음악을 선곡한다. 방송에 사용될 취재를 진행한다. 제작진행표(Cue Sheet:프로그램 주제, 방송일시, 방송진행 순서, 삽입음악의 배열, 출연자의 취재 삽입 등을 기록)를 작성하고, 녹음 및 생방송 제작을 진행하기 전에 심의를 받는다. 스튜디오를 배정받는다. 스태프와의 회의를 주관하여 진행자 및 출연자, 제작스태프에게 제작진행표를 제공하고 협의한다. 스튜디오 또는 생방송 현장에서 제작을 지휘한다. 제작된 소스를 방송에 적합하도록 편집하고 라디오 운행부서(송출 주조종실)에 인계한다. 청취율을 검토한다. 프로그램 홍보전략을 구상하고 진행한다. 프로그램 내 광고시간을 배정한다. 프로그램의 종류에 따라, 라디오생방송, 라디오드라마, 라디오토크, 음악프로그램, 라디오공개방송, 녹음구성 프로그램, 인터넷으로 제공되는 보이는 라디오프로그램의 제작을 진행하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"라디오방송연출가, 라디오PD","dJobECd":"4161","dJobECdNm":"[4161]감독 및 기술감독","dJobJCd":"2831","dJobJCdNm":"[2831]감독 및 기술 감독","dJobICd":"J591/J601","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업 / [J601]라디오 방송업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007153:1', '{"dJobCd":"K000007153","dJobCdSeq":"1","dJobNm":"라이브사운드엔지니어","workSum":"방송, 영화, 콘서트 등의 공연을 제작하기 위해 음향계획을 수립하고 관련 종사원들의 업무를 지휘한다.","doWork":"음향이 사용되는 공연의 특성을 파악한 후 방송프로듀서(방송연출가), 연극연출가 등과 협의를 통해 음향과 관련된 제작장비의 시스템을 구성한다. 음향시스템을 유지·관리하고, 제작의도에 맞게 음향시스템을 설치하고 조율한다. 음향시스템의 설정이 완료되면 사운드를 점검한다. 공연이 시작되면 무대의 변환에 따라 마이크의 밸런스와 크기를 조절한다. 현장의 소리가 관객에게 전달되도록 음향장비(믹싱콘솔mixing console)을 조작한다. 압축, 리버브, 코러스 및 기타 디지털 효과와 같은 음향효과를 주기 위해 장비를 조작한다. 음향 시스템을 설계하거나 컨설팅한다. 음향기사의 업무를 지시 및 감독한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"청각|","workEnv":"소음·진동|","workFunc1":"조정","workFunc2":"협의","workFunc3":"제어조작","similarNm":"사운드디렉터, 사운드믹싱엔지니어, 사운드엔지니어, 콘서트, 뮤지컬, 행사 등의 경우 라이브사운드엔지니어, 음향·영상 시스템 설계 및 컨설팅을 하는 경우 인스톨엔지니어, 영화나 드라마의 경우 레코딩엔지니어","certLic":"무대예술전문인(음향)","dJobECd":"4161","dJobECdNm":"[4161]감독 및 기술감독","dJobJCd":"2831","dJobJCdNm":"[2831]감독 및 기술 감독","dJobICd":"J591/J601/J602","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업 / [J601]라디오 방송업 / [J602]텔레비전 방송업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007053:1', '{"dJobCd":"K000007053","dJobCdSeq":"1","dJobNm":"라이브커머스PD","workSum":"방송 기획부터 송출까지 모든 전반적인 업무를 맡아서 진행한다.","doWork":"예상 시청자층을 분석하고 판매율이 높을 것으로 판단되고 방송에 적합한 제품을 구성한다.  메인상품, 서브상품, 미끼상품 등 각 포지션에 맡게 적절한 상품을 선택하고 배치한다. 선택된 상품에 맞는 이벤트, 시나리오를 구성한다. 제품에 따른 콘셉트를 기획하고 시간별 타임테이블을 구성한다. 멘트와 설명 정보를 스크립트 형식으로 작성한다. 기획안이 완성되면 구성과 어울리는 쇼호스트를 섭외한다. 현장 네트워크와 공간을 사전에 답사하여 체크한다. 세트장 연출과 장비 세팅을 하고 방송 전 간단한 사전 미팅 후 최종 리허설을 진행하여 점검한다. 정해진 방송 시간에 생방송을 진행한다. 진행자가 정해진 시나리오 구성에 맞춰 이끌어 갈 수 있도록 모니터 혹은 보드판 등을 이용해서 전반적인 지시사항을 전달한다. 방송 중간마다 진행되는 이벤트에 대한 결과도 진행자들이 확인할 수 있도록 전달한다. 1인의 경우 모든 작업을 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"라이브커머스기획자, 라이브커머스감독, 라이브커머스크리에이터","connectJob":"라이브커머스작가, 모바일쇼호스트","dJobECd":"4161","dJobECdNm":"[4161]감독 및 기술감독","dJobJCd":"2831","dJobJCdNm":"[2831]감독 및 기술 감독","dJobICd":"J591/J602","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업 / [J602]텔레비전 방송업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004992:1', '{"dJobCd":"K000004992","dJobCdSeq":"1","dJobNm":"만화영화연출가","workSum":"만화영화를 제작하기 위한 기획, 제작, 스토리구성 등에 종사하는 작업원들을 지휘·감독한다.","doWork":"제작할 만화영화의 대본을 해석하고 구체적인 영상으로 표현하기 위하여 전체적인 대사, 연기, 의상, 조명, 음악, 효과를 고안한다. 만화영화화가와 협의하여 배경화면의 구성을 결정한다. 배경화면에 전반적인 줄거리를 파악하기 위한 기본장면을 배열하고 각 장면에 필요한 대사, 음악, 효과, 시간 등 화면에 대한 보충 설명을 기록한다. 인물 및 배경의 색상을 검토한다. 각 장면과 장면이 부드럽게 이어지면서 줄거리가 효과적으로 표현되었는지 검토한다. 시연을 거쳐 부족한 부분을 보완하여 최종작품을 완성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"조정","workFunc2":"협의","workFunc3":"정밀작업","dJobECd":"4161","dJobECdNm":"[4161]감독 및 기술감독","dJobJCd":"2831","dJobJCdNm":"[2831]감독 및 기술 감독","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001521:1', '{"dJobCd":"K000001521","dJobCdSeq":"1","dJobNm":"무대감독","workSum":"조명, 음향 등 무대장치의 설치와 무대공연의 진행을 총괄하고, 관련 종사원들의 활동을 지휘·감독한다.","doWork":"공연대본을 분석하여 작품의 흐름 및 분위기, 시간과 공연극장의 안전사항에 대하여 검토한다. 무대장치, 조명, 음향, 진행 등 무대 관련 종사원들과 협의하여 진행사항을 확인하고 작업일정을 조정한다. 관련 종사원들의 활동을 감독하고 무대설치, 스크린 설치 등을 지시한다. 공연 시 무대전환을 위해 대본(큐시트)을 확인한다. 장면전환 시 무대전환 및 무대기계조정원에게 신호를 보내 무대전환을 지시한다. 공연이 끝나면 무대의 철거를 지시하고 감독한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","dJobECd":"4161","dJobECdNm":"[4161]감독 및 기술감독","dJobJCd":"2831","dJobJCdNm":"[2831]감독 및 기술 감독","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006936:1', '{"dJobCd":"K000006936","dJobCdSeq":"1","dJobNm":"무대디자이너","workSum":"연극, 영화 및 방송프로그램 제작을 위해 무대장치(세트)를 설계한다.","doWork":"대본(시나리오)을 검토하여 작가 및 연출가의 제작의도를 고려해 컴퓨터에서 이미지 맵을 그린다. 방송프로듀서(방송연출가), 영화감독, 연극연출가 등과 협의하여 무대장치의 종류, 크기, 색상 등 세부사항을 결정하고 캐드작업을 통해 도면을 작성한다. 인테리어디자이너 및 소품 담당자와 함께 무대장식에 대해 협의한다. 무대조립원의 활동을 감독·지시한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"종합","workFunc2":"협의","workFunc3":"정밀작업","similarNm":"세트디자이너, 프러덕션디자이너","dJobECd":"4161","dJobECdNm":"[4161]감독 및 기술감독","dJobJCd":"2831","dJobJCdNm":"[2831]감독 및 기술 감독","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002702:1', '{"dJobCd":"K000002702","dJobCdSeq":"1","dJobNm":"무술감독","workSum":"영화나 텔레비전 드라마에 출연하는 배우나 연기자에게 무술연기를 지시한다.","doWork":"방송 프로듀서나 영화감독과 무술촬영에 대해 협의한다. 대본(시나리오)을 분석하고 배역이 결정되면 그 배역의 신체와 비슷한 스턴트맨을 선정한다. 무술 촬영현장의 세트디자인을 검토하고 촬영계획을 세운다. 무술 촬영현장 및 준비과정을 확인한다. 대본을 토대로 연기자에게 무술장면을 지시하고 필요하면 연기자에게 무술을 지도한다. 촬영 장면을 확인하고 필요하면 재촬영을 유도한다. 방송과 영화에 관련된 내용을 교육하거나 무술이 중요한 역할을 하는 영화나 드라마 제작 시 조언을 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","workEnv":"위험내재|","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","similarNm":"무술총감독","connectJob":"무술지도감독","dJobECd":"4161","dJobECdNm":"[4161]감독 및 기술감독","dJobJCd":"2831","dJobJCdNm":"[2831]감독 및 기술 감독","dJobICd":"J591/J602","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업 / [J602]텔레비전 방송업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007842:1', '{"dJobCd":"K000007842","dJobCdSeq":"1","dJobNm":"문화세트기술자","workSum":"영화, 드라마, CF, 연극, 뮤지컬 등에서 사용되는 세트를 물리적으로 구현하기 위해 시공 설계를 하고 세트 제작 및 설치에 관련된 자재, 인력, 안전 관리와 감독 업무를 한다.","doWork":"세트디자이너의 콘셉트 도면 및 설명을 검토하여 기술적으로 실현가능한 구조를 설계한다. 콘셉트 도면이 잘못되어 있는 경우 디자인팀과 조정하여 수정한다. 설계 도면에 따라 세트 구조물이나 설치물이 기간 내 안전하게 설치되도록 관리하고 감독한다. 세트 제작, 설치 및 유지보수에 필요한 견적 산출, 자재 및 대도구 관리, 인력관리, 안전관리 등의 계획을 수립하고 이를 실행한다. 방송, 공연, 드라마 제작 중에 설치한 세트 및 구조물의 상태를 점검하고 필요시 보완한다. 세트의 해체 작업을 관리하고 감독한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"손사용|언어력|시각|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"세트제작관리자, 세트설치 및 유지관리자, 세트감독","dJobECd":"4161","dJobECdNm":"[4161]감독 및 기술감독","dJobJCd":"2831","dJobJCdNm":"[2831]감독 및 기술 감독","dJobICd":"J591/J602/R901","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업 / [J602]텔레비전 방송업 / [R901]창작 및 예술관련 서비스업","inqYear":"2025"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006036:1', '{"dJobCd":"K000006036","dJobCdSeq":"1","dJobNm":"미술감독","workSum":"영화 제작의도를 파악하여 각본에 맞는 장면을 디자인하고, 미술팀원의 활동을 조정·감독한다.","doWork":"시나리오를 분석하여 전체적인 영화의 흐름이나 분위기에 대하여 영화감독과 협의한다. 영화분위기에 맞는 이미지를 그림이나 사진, 스케치 등으로 구체화시켜 미술 전반의 콘셉트를 구상한다. 촬영장소를 방문하여 각 장면의 배경이 되는 산이나 바다, 건물 등의 지역 또는 장소를 선정한다. 영화 세트를 설치하기 위해 무대디자이너와 설치계획을 협의하고, 분장, 의상, 소품 등 각 분야별 팀원들과의 협의를 통해 구체적인 제작방향 및 계획을 논의한다. 미술 관련 분야의 예산을 작성한다. 준비작업부터 촬영까지의 일정을 계획한다. 미술팀 전반적인 업무를 조정하고 지휘·감독한다. 직접 세트를 설계하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"시각|","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"아트디렉터, 프러덕션디자이너","dJobECd":"4161","dJobECdNm":"[4161]감독 및 기술감독","dJobJCd":"2831","dJobJCdNm":"[2831]감독 및 기술 감독","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003321:1', '{"dJobCd":"K000003321","dJobCdSeq":"1","dJobNm":"방송기술감독","workSum":"방송프로그램의 제작기술 업무를 총괄하고, 관련 종사원들의 활동을 지휘·감독한다.","doWork":"부조정실의 기술팀을 구성하여 제작시간, 출연자, 소요장비 등의 제작에 관해 협의·조정한다. 영상, 음향, 조명감독 등 기술팀 회의를 주관하고 의견을 조율한다. 음향 및 영상 등의 제작기술의 품질을 관리한다. 부조정실에서 비디오믹서(비디오 스위처)를 조정하여 화면의 영상을 변화시킨다. 야외 제작 시 시스템 구성을 감독한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"감독","workFunc3":"제어조작","similarNm":"TD(Technical Director)","dJobECd":"4161","dJobECdNm":"[4161]감독 및 기술감독","dJobJCd":"2831","dJobJCdNm":"[2831]감독 및 기술 감독","dJobICd":"J601/J602","dJobICdNm":"[J601]라디오 방송업 / [J602]텔레비전 방송업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006269:1', '{"dJobCd":"K000006269","dJobCdSeq":"1","dJobNm":"방송영상감독","workSum":"카메라로 촬영된 영상의 화질을 개선하기 위해 영상장비를 조작·운영한다.","doWork":"카메라, 조명의 세팅상태를 점검하고 케이블 등의 연결상태를 확인한다. 영상장비를 점검하고, 화면테스트를 시행한다. 방송국 내의 부조정실(부조실)에서 촬영기사가 촬영한 영상을 화면으로 관찰하면서 영상장비를 이용해 명도, 색상 등의 파형 및 영상레벨을 조정한다. 일관된 색상과 흔들림 없는 영상을 유지하기 위해 화질을 지속적으로 관찰한다. 부조정실 내의 카메라 및 영상장비를 운용하고 점검·관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"비디오엔지니어, 비디오맨, 영상기사, 시스템영상기사","connectJob":"무대영상감독","dJobECd":"4161","dJobECdNm":"[4161]감독 및 기술감독","dJobJCd":"2831","dJobJCdNm":"[2831]감독 및 기술 감독","dJobICd":"J602","dJobICdNm":"[J602]텔레비전 방송업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003590:1', '{"dJobCd":"K000003590","dJobCdSeq":"1","dJobNm":"방송운행프로듀서","workSum":"방송국 주조정실에서 당일 방송운행의 지휘감독자로서 방송 개시부터 종료까지의 방송운행을 책임진다.","doWork":"편성연락과 운행표를 점검하고 일일 방송순서 및 주간 방송순서를 숙지한다. 전체 방송의 흐름을 파악한다. 각 프로그램, 예고, 캠페인 등 스파트(방송프로그램과 프로그램 사이에 내보내는 화면), ID(자막광고), CM(광고방송), 각종 자막방송 스크롤, 유사시 대체방송물(Filler)의 준비상태를 확인한다. 준비되지 않은 프로그램이 있는지 확인하고 어느 장소에서 녹화 또는 편집 중인지 확인한다. 화면조정시간(TPH:Test Pattern Hour) 또는 방송사고나 비상사태에 대비한 음악을 선곡, 준비한다. 재해·경보방송, 뉴스속보 등을 신속히 조치한다. 각종 방송사고를 예방 및 응급조치한다. 방송진행 상황을 동시녹화한다. 방송운행 상황에 대한 문의에 응대한다. 방송운행일지에 운행사항을 기록하고 보관한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"정밀작업","similarNm":"MD(Master Director), 주조감독","dJobECd":"4161","dJobECdNm":"[4161]감독 및 기술감독","dJobJCd":"2831","dJobJCdNm":"[2831]감독 및 기술 감독","dJobICd":"J591/J601/J602","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업 / [J601]라디오 방송업 / [J602]텔레비전 방송업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006220:1', '{"dJobCd":"K000006220","dJobCdSeq":"1","dJobNm":"방송책임프로듀서","workSum":"담당 방송프로그램의 기획 및 제작을 총괄 관리의 책임을 지고, 관련 종사원들의 활동을 관리·감독한다.","doWork":"방송 편성회의에 참여하여 방송사의 중장기 전략, 각 프로그램의 편성방향 등에 대해 협의한다. 소속 직원들의 인사관리를 한다. 담당 프로듀서와 상의하여 작품을 배정한다. 프로듀서가 제출하는 제작기획서를 검토하고 경영진과 협의하여 프로그램의 작가, 연기자, MC 및 외부 연출가를 선정 및 결정한다. 제작 예산을 승인하고 관리한다. 제작된 프로그램을 시사하고 수정 및 보완사항을 결정한다. 담당하는 프로그램의 기획, 예산, 편집, 홍보 등을 총괄적으로 관리하며 책임을 진다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"CP(Chief Producer), EP(Executive Producer), 수석프로듀서, 프로덕션매니저","dJobECd":"4161","dJobECdNm":"[4161]감독 및 기술감독","dJobJCd":"2831","dJobJCdNm":"[2831]감독 및 기술 감독","dJobICd":"J591/J601/J602","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업 / [J601]라디오 방송업 / [J602]텔레비전 방송업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007394:1', '{"dJobCd":"K000007394","dJobCdSeq":"1","dJobNm":"비디오저널리스트","workSum":"6mm카메라를 이용하여 시사적인 주제를 선정·기획, 취재, 촬영 편집 등을 혼자 수행한다.","doWork":"개인적인 시각에 따라 촬영주제를 선정하거나 구성작가 등과 촬영주제에 대해서 협의한다. 촬영주제를 선정한다. 주제에 적합한 촬영 대상을 섭외한다. 주제를 최대한 부각할 수 있는 세밀한 촬영구성안을 작성한다. 6mm카메라를 사용하여 구성안에 맞춰 촬영을 한다. 전체적인 흐름에 따라 영상을 컷 위주로 가편집한다. 내레이션 안을 작성하고, 효과, 자막, 음악, 녹음 등 종합편집을 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"웅크림|손사용|","workFunc1":"조정","workFunc2":"협의","workFunc3":"제어조작","connectJob":"영상기자","dJobECd":"4161","dJobECdNm":"[4161]감독 및 기술감독","dJobJCd":"2831","dJobJCdNm":"[2831]감독 및 기술 감독","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003093:1', '{"dJobCd":"K000003093","dJobCdSeq":"1","dJobNm":"스포츠프로그램프로듀서","workSum":"스포츠프로그램(스포츠 뉴스, 스포츠 종합 프로그램, 스포츠 경기 중계 등)을 기획·총괄하고 관련 종사원들의 활동을 조정한다.","doWork":"스포츠 뉴스를 기획·제작하는 경우, 경기나 행사가 열리는 장소와 시간을 확인한 후 스포츠기자, 스태프 등과 함께 이동하여 스포츠 뉴스를 취재하거나 스포츠 뉴스 리포트를 제작한다. 스포츠 기획물을 제작하는 경우, 아이템을 선정하고 인물, 팀, 사건 등을 중심으로 기획물을 기획 및 제작 진행한다. 취재 및 리포트가 완료되면 편집하여 방송에 적합한 화면으로 만든다. 스포츠 중계방송을 기획·제작하는 경우, 편성(중계종목, 채널, 방송시간 등)에 따라 편성부서, 기술 중계부서, 아나운서, 카메라 스태프 등 유관 부서에 업무협조 의뢰를 통보한다. 제작계획 및 제작비 산출, 현장상황 파악(경기시간, 진행순서), 아나운서 또는 해설자와 협의, 카메라 위치, 음향, 조명 등 기술적인 확인·점검, 광고 또는 중간예고 등을 기획하고 수행한다. 현장에서 직접 스위칭(Switching:여러 소스의 영상을 선택하는 기계 조작)을 하면서 화면을 구성한다. 해외스포츠의 경우 현지제작 생중계를 하거나, 스튜디오 제작 생중계(해외 경기현장에 중계요원을 파견하지 않고 국제신호에 의해 위성으로 수신되는 경기내용을 스튜디오에 마련된 화면을 통해 중계하는 형식)를 기획한다. 경기 하이라이트 영상을 편집하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"스포츠방송연출가, 스포츠PD","dJobECd":"4161","dJobECdNm":"[4161]감독 및 기술감독","dJobJCd":"2831","dJobJCdNm":"[2831]감독 및 기술 감독","dJobICd":"J591/J602","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업 / [J602]텔레비전 방송업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006151:1', '{"dJobCd":"K000006151","dJobCdSeq":"1","dJobNm":"시사다큐프로그램프로듀서","workSum":"시사·다큐프로그램(실제 사건의 재현이나 기록, 현실을 직접적으로 다루는 영상물)을 기획·제작 총괄하고 관련 종사원들의 활동을 지휘한다.","doWork":"다양한 소재나 제안을 수집·분석한다. 기획회의를 주관하고 소재의 적합성, 시의성, 참신성, 흥미성, 방송 효과, 인력과 예산, 중복 편성 등을 고려하여 소재를 결정한다. 기획안(제목, 기획의도, 방송일자, 제작편수와 분량, 구성방법, 제작일수, 취재지역, 취재인원, 취재장비, 제작비, 취재행동 예정표 등)을 작성하고 결재를 받는다. 작가와 함께 구성안을 기획한다. 제작회의를 주관하여 구성안을 수정 및 보완한다. 촬영콘티뉴어티(스토리보드를 기본으로 해서 출연자의 동작, 대사, 음향, 카메라앵글, 렌즈의 종류, 조명위치, 기타 필요한 일체의 사항과 음악, 음악효과까지 상세히 메모해 둔 연출대본)를 작성한다. 제작스태프(조감독, 촬영감독, 조명기사, 음향기사 등)와 제작 진행 전반을 협의한다. 현장 촬영에서 카메라의 위치, 샷 또는 신을 결정한다. 촬영된 영상을 프리뷰한다. 작가와 함께 편집콘티뉴어티(최초의 구성안을 참고로 화면 또는 음향을 선택하고 연결하기 위한 대본)를 작성한다. 촬영된 영상을 1차로 편집한다. 녹화대본(화면의 내용, 길이, 음향 또는 해설, 음악과 자막, 특수효과 등을 연출한 대본)을 작성하고 최종 녹화·편집하여 프로그램을 완성한다. 예고편을 제작한다. 방송심의를 받는다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"시사다큐방송연출가, 시사다큐PD","connectJob":"자유창작자로서 기획/연출/제작 업무를 수행하는 경우 독립피디","dJobECd":"4161","dJobECdNm":"[4161]감독 및 기술감독","dJobJCd":"2831","dJobJCdNm":"[2831]감독 및 기술 감독","dJobICd":"J591/J602","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업 / [J602]텔레비전 방송업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007503:1', '{"dJobCd":"K000007503","dJobCdSeq":"1","dJobNm":"연극연출가","workSum":"연극을 연출하기 위해 선정된 작품을 해석하고 연극배우들을 연기와 공연을 지휘한다.","doWork":"공연할 희곡을 선정하거나 선정된 작품을 검토한 후 구성요소 분석과 작품 해석을 한다. 연극제작자 및 극작가와 협의하여 대본을 수정하고 극의 세부적인 흐름을 계획한다. 등장인물에 적합한 배우를 오디션을 통해서 선발하거나 직접 캐스팅한다. 음향, 소품, 조명 등 공연 시 기술적인 작업을 담당하는 무대기술진을 구성한다. 무대제작을 포함하여 공연 제작계획을 조정하기 위해 무대감독, 음향, 조명, 의상, 안무 등 관련 종사원들과 협의한다. 연습 및 리허설을 총괄한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","connectJob":"연극PD","dJobECd":"4161","dJobECdNm":"[4161]감독 및 기술감독","dJobJCd":"2831","dJobJCdNm":"[2831]감독 및 기술 감독","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007459:1', '{"dJobCd":"K000007459","dJobCdSeq":"1","dJobNm":"영상그래픽디자이너","workSum":"방송의 뉴스, 일기예보, 속보 등에 사용되는 글, 그림, 데이터, 문자 등을 디자인하고 송출한다.","doWork":"뉴스, 일기예보, 다큐멘터리 등 제작팀의 방송프로듀서(방송연출가) 또는 보조연출가 등으로부터 방송 자막이나 그림으로 사용될 내용을 받는다. 방송의 특성을 고려하며 글에 적합한 글꼴, 크기, 디자인 그리고 색채 등을 결정하며 관계자와 협의하여 최종 결정한다. 컴퓨터, 그래픽 소프트웨어, 마우스 등을 사용하여 글을 작성하고 디자인한다. 캡처기, VTR 등을 사용하여 방송에 사용될 인물사진이나 기존 자료 등을 캡처한다. 디자인한 내용을 송출기기를 사용하여 전송하거나 녹화기를 사용하여 녹화한다. 속보 등 관련 내용을 컴퓨터에 저장하거나 방송에 적합한 글, 그림, 디자인 등을 사전 작업하여 DB에 구축한다. 방송되는 내용을 관찰하고 개선점을 찾는다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"방송그래픽디자이너","certLic":"컴퓨터그래픽스운용기능사","dJobECd":"4155","dJobECdNm":"[4155]미디어 콘텐츠 디자이너","dJobJCd":"2831","dJobJCdNm":"[2831]감독 및 기술 감독","dJobICd":"J591/J602","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업 / [J602]텔레비전 방송업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007458:1', '{"dJobCd":"K000007458","dJobCdSeq":"1","dJobNm":"영화감독","workSum":"영화 제작을 위해 연기자와 제작진의 활동을 조정·감독하고 촬영 및 편집 등 영화제작 전반에 대하여 총괄한다.","doWork":"시나리오를 분석하고 시나리오작가 및 영화제작자 등과 협의하여 제작스태프 및 배역을 결정한다. 제작진과 촬영현장을 답사하고 세트디자인을 검토하고 촬영계획을 세운다. 촬영일정대로 촬영을 진행하기 위해 스태프의 업무를 조정·지휘하고, 촬영현장 및 준비과정을 확인한다. 연기자에게 연기를 지도하고, 촬영된 필름을 확인하며 재촬영 여부를 결정한다. 영화편집기사, 음향기사 등과 협의하여 편집을 돕고, 내부 시사회를 거쳐 최종적으로 영화를 완성한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","connectJob":"독립영화감독, 영화편집감독","dJobECd":"4161","dJobECdNm":"[4161]감독 및 기술감독","dJobJCd":"2831","dJobJCdNm":"[2831]감독 및 기술 감독","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006466:1', '{"dJobCd":"K000006466","dJobCdSeq":"1","dJobNm":"영화기술감독","workSum":"디지털 영상데이터를 관리·감독하고 영화제작 과정 중 후반작업(편집, 믹싱, 컴퓨터그래픽 등)에 필요한 영상데이터 처리기술을 지원하고 관리한다.","doWork":"영화 촬영현장에서 촬영 시작 전에 촬영감독과 협의하여 현장촬영 조건에 맞는 디지털카메라를 선정한다. 촬영이 진행되면 매회 촬영 분량의 영상데이터 파일을 컴퓨터를 사용하여 안전하게 저장한다. 영상데이터 파일을 편집이 가능한 형태로 변환하여 편집실로 보낸다. 편집실에서 이루어지는 영화후반작업(편집, 믹싱, 컴퓨터그래픽 작업)에 영상데이터를 처리하는 기술적 지원을 한다. 납기 기간 안에 후반작업이 완료되도록 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"분석","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"영화테크니컬디렉터","dJobECd":"4161","dJobECdNm":"[4161]감독 및 기술감독","dJobJCd":"2831","dJobJCdNm":"[2831]감독 및 기술 감독","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005189:1', '{"dJobCd":"K000005189","dJobCdSeq":"1","dJobNm":"영화라인프로듀서","workSum":"영화제작부의 실무적인 역할을 수행하며 프로듀서에 의해 결제된 단기간의 예산을 집행한다.","doWork":"영화조감독과 협의하여 촬영계획을 수립하고 진행상황을 확인한다. 프로덕션 보드(Production Board), 배우 스케줄, 장소 및 장면 구분표 등 각종 제작부 문서를 작성한다. 오디션을 준비한다. 촬영장소를 섭외하고 식당 및 야식업체 선정, 촬영장소의 차량 및 행인의 통제, 배우보호, 보조출연자를 관리한다. 제작일정에 따라 소품, 의상, 분장, 촬영스태프, 미술, 조명, 동시녹음, 편집, 현상소, 조연, 단역 등과 계약을 체결하고 집행한다. 예산을 관리하고 비용을 정산한다. 협찬업체를 면담하여 협찬을 진행한다. 촬영장비 임대업체와 계약을 체결하고 세부항목을 확인한다. 촬영차량을 관리한다. 촬영에 사용되는 소모품·비용을 관리한다. 프로덕션 과정이 종료되면 편집, 특수효과, 음악, 사운드믹싱 등 포스트프로덕션 과정이 진행되도록 제반 업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"언어력|시각|","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"line Producer, 프로덕션매니저(Production Manager)","dJobECd":"4161","dJobECdNm":"[4161]감독 및 기술감독","dJobJCd":"2831","dJobJCdNm":"[2831]감독 및 기술 감독","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007332:1', '{"dJobCd":"K000007332","dJobCdSeq":"1","dJobNm":"영화스토리보드작가","workSum":"영화 촬영을 위해 영화감독의 표현구상과 영화적 상황을 그림(Story Board:스토리보드)으로 형상화한다.","doWork":"시나리오를 이해하고, 로케이션 및 세트 설계도, 헌팅이미지를 확인하면서 콘티를 구상한다. 감독과 협의하여 표현하고자 하는 주요 장면들(특수효과, 불꽃 장면, 군중 신, 액션 신, 복잡한 카메라의 움직임, 몽타주 시퀀스, 오프닝 신과 마감 신 등)의 우선순위를 정하고 순서대로 작업한다. 종이와 연필, 목탄, 잉크 등을 사용하여 드로잉하거나, 사진과 비디오, 컴퓨터그래픽 프로그램을 이용한다. 용도에 따라 러프보드(피사체와 카메라의 움직임의 골격만을 표현하여 대본을 대충 시각화 한 것), 프레젠테이션 보드(보여주기 위한 목적으로 만든 스토리보드), 촬영콘티(실제로 촬영현장에서 사용하는 스토리보드)를 제작한다. 감독과 함께 교정작업을 한다. 완료된 스토리보드를 각 부서장, 특수효과팀과 스턴트팀에 송부한다. 우선순위 장면들 이외의 나머지 신들에 대하여 계속 작업하여 스토리보드 제작을 완료한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|시각|","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"영화콘티작가, 스토리보드아티스트","dJobECd":"4161","dJobECdNm":"[4161]감독 및 기술감독","dJobJCd":"2831","dJobJCdNm":"[2831]감독 및 기술 감독","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004215:1', '{"dJobCd":"K000004215","dJobCdSeq":"1","dJobNm":"영화예고편제작자","workSum":"국내 및 해외영화 예고편 수주를 받아 영화예고편을 제작한다.","doWork":"영화제작사의 영화예고편 제작의뢰를 받으면 영화의 특징에 맞춰 예고편 콘셉트에 대하여 제안하고 조율한다. 협의된 내용에 따라 영화예고편의 구성안을 작성하고 영화 각 부분의 영상을 편집하고 자막, 성우더빙, 음악 등을 넣고 색 보정하여 영화예고편을 제작한다. 예고편을 위하여 별도의 영상 촬영을 하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|시각|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","similarNm":"티저예고편제작자, 메인예고편제작자","dJobECd":"4161","dJobECdNm":"[4161]감독 및 기술감독","dJobJCd":"2831","dJobJCdNm":"[2831]감독 및 기술 감독","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003300:1', '{"dJobCd":"K000003300","dJobCdSeq":"1","dJobNm":"예능프로그램프로듀서","workSum":"예능프로그램(음악, 오락, 쇼 프로그램 등 TV 매체를 통하여 즐거움과 재미를 주는 프로그램)을 기획·총괄하고 관련 종사원들의 활동을 지휘한다.","doWork":"프로그램 기획보고서에 따라 CP, 연출, 조연출, 구성작가 등 기획구성 협의 과정을 거처 프로그램 제작형식인 공개, 비공개, 녹화, 생방송, 스튜디오제작, 야외제작 여부 등의 구체적인 구성안을 작성한다. 큐시트, 대본안을 작성한다. MC 및 출연예정자를 선정한다. 대본에는 방송 녹화, 연습일정, 스태프진, 연출진을 표시한다. 큐시트에는 프로그램 러닝타임에 맞게 구성 아이템별 타임스케줄을 명시한다. 기술감독, 조명, 음향, 카메라, 세트, 소품, 의상 등 제작에 관여하는 전 스태프가 프로그램 제작 전반에 걸쳐 상호 협의한다. 제작기획 단계를 거처 확정된 큐시트, 대본을 프로그램 진행자 및 출연진, 스태프에게 전달한다. 제작협조를 의뢰(녹화 스튜디오·녹음실·편집실 배정, 소품, 의상, 분장, 특수효과, 특수카메라 등의 준비, 합창·무용·보조출연자 인력동원, 공개프로그램인 경우 방청객 동원·방청권 배부 등 제반 사항)하고 준비 상황을 점검한다. 녹화 전에 드라이 리허설(녹화가 시작되기 전에 출연자의 등장, 퇴장 방향과 스튜디오 운영 등 진행상황 연습), 카메라 리허설(드라이 리허설이 끝나면 카메라 동작을 함께 연습)을 진행하며 각 부분별로 녹화준비가 완전한지 점검한다. 녹화를 지휘한다. 편집(녹화된 부분의 시간조정 또는 수정·보완이 필요한 부분과 음향과 영상효과, 컴퓨터 그래픽 등의 보완편집) 작업을 한다. 예고편을 제작한다. 홍보자료를 작성한다. 방송심의를 받는다. 제작하는 프로그램에 따라 뮤직쇼, 버라이어티쇼, 코미디 프로그램을 제작한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"정밀작업","similarNm":"예능방송연출가, 예능PD","dJobECd":"4161","dJobECdNm":"[4161]감독 및 기술감독","dJobJCd":"2831","dJobJCdNm":"[2831]감독 및 기술 감독","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002468:1', '{"dJobCd":"K000002468","dJobCdSeq":"1","dJobNm":"음반프로듀서","workSum":"음반 제작을 위해 음악과 녹음에 관련된 작업을 총괄한다.","doWork":"음반제작자와 협의하여 음반의 분위기를 정하고 음반에 포함될 곡을 선정한다. 선정된 곡의 작곡가 및 편곡가와 협의하여 곡의 특성을 살릴 수 있는 녹음 방법을 결정한다. 레코딩, 믹싱 및 마스터링 등 녹음의 전 과정에 관여하여 녹음엔지니어 및 마스터링엔지니어에게 음악적인 부분을 조언한다. 연주가 및 가수에게 곡의 녹음 방향을 설명하고 지도한다. 녹음 관련 종사원들의 작업을 관리하고 감독한다. 음악적 통일감을 주기 위해서 음반 수록곡의 순서를 정한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"청각|","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"음반제작자, 음반PD","dJobECd":"4161","dJobECdNm":"[4161]감독 및 기술감독","dJobJCd":"2831","dJobJCdNm":"[2831]감독 및 기술 감독","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002245:1', '{"dJobCd":"K000002245","dJobCdSeq":"1","dJobNm":"음악감독","workSum":"방송, 영화, 연극, 뮤지컬 등에 사용될 음악을 선정하거나 작곡 및 편곡한다.","doWork":"대본 또는 시나리오를 보고 방송프로듀서(방송연출가), 영화감독 및 연극연출가, 음향감독 등과 함께 프로그램 또는 공연의 성격 및 진행 흐름에 대해서 협의한다. 음악이 삽입될 장면 및 상황에 들어갈 음악을 선정한다. 선정한 곡을 편곡하거나 새로운 곡을 작곡한다. 앨범을 제작할 경우 가수·세션맨 등을 선정하기도 한다. 앨범제작 업무에 참여하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"청각|","workFunc1":"종합","workFunc2":"협의","workFunc3":"수동조작","connectJob":"뮤지컬음악감독, 영화음악감독","dJobECd":"4161","dJobECdNm":"[4161]감독 및 기술감독","dJobJCd":"2831","dJobJCdNm":"[2831]감독 및 기술 감독","dJobICd":"J591/J602/R901","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업 / [J602]텔레비전 방송업 / [R901]창작 및 예술관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003092:1', '{"dJobCd":"K000003092","dJobCdSeq":"1","dJobNm":"음향감독","workSum":"방송프로그램을 제작하기 위해 음향계획을 수립하고 관련 종사원들의 업무를 지휘한다.","doWork":"프로그램의 특성을 파악한 후 방송프로듀서(방송연출가), 연극연출가 등과 협의를 통해 음향과 관련된 제작장비의 시스템을 구성한다. 음향시스템을 유지·관리하고, 제작의도에 맞게 음향시스템을 최적으로 유지한다. 음향기술을 개발한다. 배우들의 음성, 노래, 악기소리 등을 최적의 상태로 혼합하기 위해 오디오믹서(음성혼합기) 및 음향효과(이펙트)장비를 조작한다. 음향기사의 업무를 지시 및 감독한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"청각|","workEnv":"소음·진동|","workFunc1":"조정","workFunc2":"협의","workFunc3":"제어조작","similarNm":"사운드디렉터, 사운드믹싱엔지니어, 사운드엔지니어","certLic":"무대예술전문인(음향)","dJobECd":"4161","dJobECdNm":"[4161]감독 및 기술감독","dJobJCd":"2831","dJobJCdNm":"[2831]감독 및 기술 감독","dJobICd":"J591/J601/J602","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업 / [J601]라디오 방송업 / [J602]텔레비전 방송업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003470:1', '{"dJobCd":"K000003470","dJobCdSeq":"1","dJobNm":"조명감독","workSum":"방송프로그램, 영화, 공연 등을 제작하기 위하여 조명 관련 업무를 총괄하고, 조명장비와 인력을 관리·감독한다.","doWork":"조명디자인을 계획하기 위해 방송프로듀서(방송연출가), 영화감독, 연극연출가 등과 협의한다. 세트규모, 인원, 카메라 위치, 분위기 등을 파악하여 조명의 연출방법, 시간, 조합 순서 등을 계획한다. 조도, 색온도, 조명 효과 등을 확인한다. 조명 관련 종사원의 업무를 할당한다. 조명기구의 설치를 감독한다. 조명기술을 개발하고 조명장비를 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"시각|","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","similarNm":"LD(Lighting Director)","connectJob":"영화조명감독, 연극조명감독, 방송조명감독, 조명디자이너, 조명연출가","certLic":"무대예술전문인(조명)","dJobECd":"4161","dJobECdNm":"[4161]감독 및 기술감독","dJobJCd":"2831","dJobJCdNm":"[2831]감독 및 기술 감독","dJobICd":"J591/J602/R901","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업 / [J602]텔레비전 방송업 / [R901]창작 및 예술관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006402:1', '{"dJobCd":"K000006402","dJobCdSeq":"1","dJobNm":"조연출가","workSum":"방송프로듀서(방송연출가)의 지시에 따라 프로그램제작에 관련된 진행업무를 수행한다.","doWork":"프로그램을 제작하기 위하여 대본을 검토하고 출연자 섭외, 편집, 음악 등에 대해 방송프로듀서(방송연출가)와 협의한다. 촬영 및 프로그램이 원활히 진행되도록 출연자, 스태프 등을 관리하고 점검한다. 연습 또는 실제 촬영 중에 카메라, 마이크, 조명 등 촬영장비(방송장비)의 배치와 운영을 지원하고 방송연출가의 지시내용을 전달한다. 프로그램의 촬영이 완료되면 편집, 더빙, 컴퓨터그래픽 작업 등 후반작업의 진행을 관리하고 지원한다. 제작비, 제작기간, 제작일정을 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"협의","workFunc3":"유지","similarNm":"보조프로듀서, 보조PD, AD(Assistant Director)","dJobECd":"4161","dJobECdNm":"[4161]감독 및 기술감독","dJobJCd":"2831","dJobJCdNm":"[2831]감독 및 기술 감독","dJobICd":"J601/J602","dJobICdNm":"[J601]라디오 방송업 / [J602]텔레비전 방송업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006141:1', '{"dJobCd":"K000006141","dJobCdSeq":"1","dJobNm":"종합유선방송국편성프로듀서","workSum":"종합유선방송국에서 채널을 편성한다.","doWork":"종합유선방송국(CATV SO:Cable Television System Operator,방송프로그램을 편성, 운영, 송출하기 위한 설비와 방송을 수신자에게 전송하는 전송 선로 설비로 구성되는 종합 유선 방송 시설을 갖추고 방송을 하는 사업체)에 소속되어 다양한 프로그램 공급업자(PP:Program Provider, 바둑채널, 증권채널, 영화채널 등)가 제공하는 채널을 편성한다. 제작파트와 광고사업국(채널팀), 경영지원실(마케팅팀)과 협의하여 채널의 주요 시청자, 콘셉트 등 채널의 성격을 규정하고 채널 전략을 수립하여 방송시간을 기획하고 운영한다. 채널의 중장기 전략을 수립하고 채널의 목표, 콘셉트, 프로그램 방향을 설정한다. 개편의 방향을 수립한다. 채널 프로그램 예산을 관리한다. 신규 프로그램을 기획한다. 수립된 편성방향에 따라 실제 편성표를 작성한다. 채널 시청률을 분석·관리한다. 콘텐츠의 시청 형태를 조사하여 내용의 개선을 제시한다. 사내의 제작파트, 송출팀, 홍보, 웹팀, OAP(One-air Promotion)팀, 콘텐츠 구매팀, 마케팅팀, 광고팀, 매체팀 등 각 부서와 업무협의를 한다. 채널 사업과 연관된 부대사업을 기획 및 진행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"4161","dJobECdNm":"[4161]감독 및 기술감독","dJobJCd":"2831","dJobJCdNm":"[2831]감독 및 기술 감독","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005103:1', '{"dJobCd":"K000005103","dJobCdSeq":"1","dJobNm":"촬영감독","workSum":"영화, 방송프로그램 제작을 위해 카메라 촬영 업무를 총괄하고, 촬영기사의 활동을 조정·감독한다.","doWork":"촬영할 대본(시나리오)을 분석하여 촬영 방향 및 연출할 영상 효과에 대하여 논의한다. 촬영장비를 선정하고 촬영기사에게 점검을 지시한다. 촬영현장을 답사하여 촬영효과에 영향을 줄 수 있는 요인을 분석하고 촬영 및 조명설치에 필요한 제반 사항을 결정한다. 조명감독과 조명설치에 대하여 협의한다. 촬영대상, 촬영거리, 화면사이즈, 적정노출 등을 고려하여 촬영하도록 지시하거나 직접 촬영한다. 촬영기사의 업무를 조정하고 감독한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"시각|","workFunc1":"조정","workFunc2":"협의","workFunc3":"제어조작","similarNm":"카메라감독","connectJob":"영화촬영감독, 방송촬영감독","dJobECd":"4161","dJobECdNm":"[4161]감독 및 기술감독","dJobJCd":"2831","dJobJCdNm":"[2831]감독 및 기술 감독","dJobICd":"J591/J602","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업 / [J602]텔레비전 방송업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002046:1', '{"dJobCd":"K000002046","dJobCdSeq":"1","dJobNm":"컴퓨터애니메이션감독","workSum":"애니메이션의 기획에서 제작, 편집까지의 전반적인 작업을 총괄하고 관련 종사원들의 활동을 감독한다.","doWork":"애니메이션기획자 및 애니메이션시나리오작가와 진행방향에 대하여 협의하여 제작과정과 제작기법 등을 결정한다. 시나리오 및 콘티 등을 검토하고 스토리, 캐릭터, 소품 등을 관련 담당자와 협의하여 결정한다. 원화 및 동화, 배경 등 실무 분야에 대하여 애니메이션연출가와 협의하고, 촬영, 편집 및 녹음 등 일련의 제작과정을 총괄한다. 일의 진행과정을 파악하여 일정을 조정하고, 제작팀 간의 업무를 조율한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"4161","dJobECdNm":"[4161]감독 및 기술감독","dJobJCd":"2831","dJobJCdNm":"[2831]감독 및 기술 감독","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002834:1', '{"dJobCd":"K000002834","dJobCdSeq":"1","dJobNm":"편성프로듀서","workSum":"텔레비전 및 라디오 방송의 방송시간대별 프로그램 편성을 총괄한다.","doWork":"텔레비전, 라디오 프로그램의 장·단기 방송전략을 기획·수립한다. 시청률, 청취율과 관련 자료 등을 참고하여 개편 전략을 수립한다. 방송시간 편성 및 방송시간대별 전략을 수립하기 위해 방송제작에 따른 표준제작비를 검토한다. 회의를 통해 프로그램의 정기개편 및 주간편성 업무를 한다. 특집프로그램을 기획하여 시간을 조정한다. 예고 및 캠페인 등의 프로그램을 기획한다. 프로그램 시간에 맞추어 방송될 광고, 프로그램 예고 등을 조정한다. 대외업무를 처리한다. 방송이미지 제고를 위한 계획을 수립한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"편성PD","dJobECd":"4161","dJobECdNm":"[4161]감독 및 기술감독","dJobJCd":"2831","dJobJCdNm":"[2831]감독 및 기술 감독","dJobICd":"J601/J602","dJobICdNm":"[J601]라디오 방송업 / [J602]텔레비전 방송업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005481:1', '{"dJobCd":"K000005481","dJobCdSeq":"1","dJobNm":"홈쇼핑피디","workSum":"홈쇼핑 방송프로그램을 기획하고 제작한다.","doWork":"방송일정에 따라 쇼호스트를 섭외한다. MD, 협력사, 작가 등 관계자와 회의하여 방송될 상품을 분석하고 방송 콘셉트를 기획한다. 제품 이미지, 프로모션, 제품사용법 등 방송에 활용할 사전자료를 촬영한다. 그래픽 등 화면구성요소를 제작한다. 스태프회의를 통해 방송세트, 의상, 메이크업, 쇼호스트 멘트 등을 기획한다. CG, 음악, 자막 등 전체적인 스토리텔링을 기획하고 큐시트를 작성한다. 스튜디오를 세팅하고 방송 준비상태를 확인한다. 생방송을 진행하고 현장을 지휘한다. 방송 종료 후에 방송진행, 판매실적 등을 평가하고 다음 방송에 반영한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"감독","workFunc3":"관련없음","dJobECd":"4161","dJobECdNm":"[4161]감독 및 기술감독","dJobJCd":"2831","dJobJCdNm":"[2831]감독 및 기술 감독","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2018"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005960:1', '{"dJobCd":"K000005960","dJobCdSeq":"1","dJobNm":"광고모델","workSum":"영상물이나 인쇄물의 광고 촬영을 위해 자세를 취하거나 연기를 한다.","doWork":"대본과 광고 콘셉트에 맞게 의상을 입고 화장을 한다. 광고 효과를 높이기 위하여 알맞은 자세를 취한 후 사진촬영을 하거나 광고감독의 요청이나 대본(시나리오)에 따라 연기를 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|","workFunc1":"관련없음","workFunc2":"오락제공","workFunc3":"관련없음","similarNm":"CF모델(Commercial Film Model)","connectJob":"손/머릿결/다리 등의 신체의 일부분만을 광고에서 보여주는 경우 부분모델, 속옷 광고를 하는 경우 언더웨어모델, 어린이로서 광고에 출연하는 경우 어린이모델","dJobECd":"4162","dJobECdNm":"[4162]배우 및 모델","dJobJCd":"2832","dJobJCdNm":"[2832]배우 및 모델","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001732:1', '{"dJobCd":"K000001732","dJobCdSeq":"1","dJobNm":"무술연기자","workSum":"영화나 텔레비전 드라마에 출연하여 무술 연기를 한다.","doWork":"무술감독, 무술지도원의 지시하에 액션 연기나 스턴트 연기를 연습한다. 대사가 있는 경우 대본을 연습한다. 영화나 드라마의 각 장면에서 연출되는 특정 상황에 맞는 복장이나 분장을 하고 액션 연기나 스턴트 연기를 한다. 주연배우를 대신하여 자동차나 말에서 뛰어내리는 등의 위험하거나 특수한 연기를 한다. 액션이나 스턴트 연기를 위해 훈련한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"균형감각|웅크림|손사용|","workEnv":"위험내재|","workFunc1":"분석","workFunc2":"오락제공","workFunc3":"정밀작업","connectJob":"스턴트맨","dJobECd":"4162","dJobECdNm":"[4162]배우 및 모델","dJobJCd":"2832","dJobJCdNm":"[2832]배우 및 모델","dJobICd":"J591/J602","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업 / [J602]텔레비전 방송업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005004:1', '{"dJobCd":"K000005004","dJobCdSeq":"1","dJobNm":"뮤지컬배우","workSum":"뮤지컬 공연을 위해 무대 위에서 노래, 춤, 연기를 한다.","doWork":"출연할 작품의 대본을 보고 주어진 배역에 대하여 분석한다. 대본을 읽으며 대사를 외우고, 노래를 연습한다. 장면별로 여러 배우들과 함께 율동을 연습한다. 무대 위에서 연기를 하면서 노래를 부르고, 율동을 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"종합","workFunc2":"오락제공","workFunc3":"관련없음","dJobECd":"4162","dJobECdNm":"[4162]배우 및 모델","dJobJCd":"2832","dJobJCdNm":"[2832]배우 및 모델","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003045:1', '{"dJobCd":"K000003045","dJobCdSeq":"1","dJobNm":"배우","workSum":"방송드라마, 영화 및 연극의 등장인물로 출연하여 연기한다.","doWork":"방송드라마, 영화 제작 또는 무대공연을 위해서 희곡(대본)을 읽고 극 중 인물을 분석한다. 배역을 맡기 위해 오디션을 본다. 배역의 성격, 언어, 특징 등을 연구한 후 대사를 암기하고 행동이나 얼굴 표정 등을 연습한다. 관객 또는 카메라 앞에서 상대 배우들과 호흡을 맞추며 연기한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"언어력|","workFunc1":"종합","workFunc2":"오락제공","workFunc3":"관련없음","similarNm":"연기자","connectJob":"탤런트, 영화배우, 연극배우, 아동극단원","dJobECd":"4162","dJobECdNm":"[4162]배우 및 모델","dJobJCd":"2832","dJobJCdNm":"[2832]배우 및 모델","dJobICd":"J591/J602/R901","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업 / [J602]텔레비전 방송업 / [R901]창작 및 예술관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007476:1', '{"dJobCd":"K000007476","dJobCdSeq":"1","dJobNm":"성우","workSum":"외국영화를 우리말로 더빙하고, 텔레비전·라디오 등의 각종 프로그램에서 목소리 연기를 한다.","doWork":"외국 영화 및 만화의 더빙, 라디오드라마, 방송프로그램의 진행멘트, 방송광고물 및 홍보물의 내레이션 등 역할을 배정받고 연기할 대본을 미리 확인한다. 배역의 성격, 대사, 역할 및 연기물의 분위기 등을 파악하여 목소리를 연습한다. 배역의 성격에 따라 어린이, 노인, 성인남녀 등의 다양한 목소리로 연기한다. 영화녹음 또는 외국영화의 대사를 우리말로 녹음한다. 동시에 1인 다역을 담당하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"종합","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"줄거리나 장면의 내용을 설명하는 내레이터","dJobECd":"4162","dJobECdNm":"[4162]배우 및 모델","dJobJCd":"2832","dJobJCdNm":"[2832]배우 및 모델","dJobICd":"J601/R901","dJobICdNm":"[J601]라디오 방송업 / [R901]창작 및 예술관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005954:1', '{"dJobCd":"K000005954","dJobCdSeq":"1","dJobNm":"예술모델","workSum":"사진작가, 조각가 또는 화가의 예술작품을 위하여 일정한 자세를 취해 예술작품의 대상이 된다.","doWork":"조각, 사진, 그림, 영화, 광고, 퍼포먼스, 미술교육 등 예술작품을 제작하기 위하여 예술가의 요구에 따라 자세를 취한다. 바구니, 공 등의 소품을 들거나 안고 자세를 취하거나 다양한 포즈로 바꾸어가며 자세를 취하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"힘든 작업","workPlace":"실내·외","physicalAct":"웅크림|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"누드화의 모델이 되는 경우 누드모델","dJobECd":"4162","dJobECdNm":"[4162]배우 및 모델","dJobJCd":"2832","dJobJCdNm":"[2832]배우 및 모델","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004865:1', '{"dJobCd":"K000004865","dJobCdSeq":"1","dJobNm":"패션모델","workSum":"패션쇼 및 기타 장소에서 의상이나 패션소품을 발표하거나 홍보하기 위해 워킹, 포즈 등의 활동을 한다.","doWork":"새롭게 유행되는 스타일 또는 고객이 원하는 타입의 의상을 입는다. 의상에 맞게 화장을 하거나 액세서리를 착용한다. 구매의욕을 높이기 위해 디자이너·구매자 또는 고객 앞에서 스타일과 기타 특징을 최대한 살려 의상을 입고 나와 걷고, 돌고, 기타 방법으로 선보인다. 광고용 스틸사진이나 삽화를 위해 모델이 되기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"홈쇼핑 등에서 의상의 착용사진을 전문으로 촬영하는 경우 피팅모델","dJobECd":"4162","dJobECdNm":"[4162]배우 및 모델","dJobJCd":"2832","dJobJCdNm":"[2832]배우 및 모델","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005632:1', '{"dJobCd":"K000005632","dJobCdSeq":"1","dJobNm":"피팅모델","workSum":"의상, 잡화(신발, 가방 등), 장신구 등의 판매증진을 위해 이들을 입거나 걸치고 포즈를 취하여 착용감, 외관, 멋스러움 등을 소비자에게 잘 드러낸다.","doWork":"촬영된 이미지의 사용처(회사명, 브랜드, 웹사이트, 간행물 게재 등), 촬영 수량 등을 확인하고 계약서에 서명한다. 촬영 일정을 확인하고 촬영할 제품(의상, 잡화, 장신구 등)의 특징 및 장점, 유행, 주제, 사이즈, 노출범위(얼굴 노출, 부분 노출) 등을 확인한다. 제품, 촬영조건, 촬영장소(스튜디오 촬영, 야외촬영), 계절, 유행 등을 고려하여 적절한 메이크업을 한다. 촬영장에서 제품을 착용하고 사진사의 지시에 따라 포즈를 취한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"Fitting Model","dJobECd":"4162","dJobECdNm":"[4162]배우 및 모델","dJobJCd":"2832","dJobJCdNm":"[2832]배우 및 모델","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004874:1', '{"dJobCd":"K000004874","dJobCdSeq":"1","dJobNm":"희극배우","workSum":"관객 및 시청자의 즐거움을 위해 방송의 코미디 프로그램이나 공연장에서 익살스러운 대사나 행동으로 연기한다.","doWork":"방송프로듀서(방송연출가) 또는 공연기획가, 작가 등과 협의를 통해 아이템을 구상한다. 공연 또는 방송에서 청중을 웃길 수 있는 언어와 행동을 창작한다. 개인 또는 단체로 창작한 내용을 연습하고 무대에서 공연한다. 관객의 반응을 관찰하고 호응이 없는 장면을 수정·보완한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"종합","workFunc2":"오락제공","workFunc3":"관련없음","similarNm":"코미디언, 개그맨, 개그우먼","dJobECd":"4162","dJobECdNm":"[4162]배우 및 모델","dJobJCd":"2832","dJobJCdNm":"[2832]배우 및 모델","dJobICd":"J602/R901","dJobICdNm":"[J602]텔레비전 방송업 / [R901]창작 및 예술관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002936:1', '{"dJobCd":"K000002936","dJobCdSeq":"1","dJobNm":"게임방송해설가","workSum":"방송으로 중계되는 게임의 해설을 담당한다.","doWork":"중계할 경기에 대한 스케줄을 체크한다. 경기에 쓰일 맵과 선수들에 대한 데이터를 수집하고 정리한다. 게임캐스터와 함께 리허설을 실시한다. 선수들과의 인터뷰를 통해 정보를 수집한다. 경기 중의 상황 및 각종 통계자료를 시청자에게 설명한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"수집","workFunc2":"오락제공","workFunc3":"관련없음","connectJob":"게임캐스터, 게임자키, 게임방송PD","dJobECd":"4163","dJobECdNm":"[4163]아나운서 및 리포터","dJobJCd":"2833","dJobJCdNm":"[2833]아나운서 및 리포터","dJobICd":"J602","dJobICdNm":"[J602]텔레비전 방송업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005742:1', '{"dJobCd":"K000005742","dJobCdSeq":"1","dJobNm":"게임자키","workSum":"게임프로그램을 진행하면서 게임을 소개하고 관련 소식을 전한다.","doWork":"게임프로그램에서 다룰 게임에 대하여 직접 해보거나 전문가의 의견을 수집하는 등 방송준비를 한다. 방송에서 사용할 대본을 미리 숙지하고 작가나 프로듀서 등과 함께 방송진행에 대한 협의를 한다. 녹화방송 혹은 생방송 형태의 방송프로그램을 진행한다. 방송이 끝난 후 모니터링을 통해 문제점을 파악하여 개선한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"수집","workFunc2":"오락제공","workFunc3":"관련없음","similarNm":"게임프로그램진행자","dJobECd":"4163","dJobECdNm":"[4163]아나운서 및 리포터","dJobJCd":"2833","dJobJCdNm":"[2833]아나운서 및 리포터","dJobICd":"J602","dJobICdNm":"[J602]텔레비전 방송업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003903:1', '{"dJobCd":"K000003903","dJobCdSeq":"1","dJobNm":"경기장아나운서","workSum":"방송장비를 사용하여 운동경기의 상황을 관중들에게 알린다.","doWork":"심판이나 운동경기기록원으로부터 경기상황을 접수한다. 선수명단, 교체선수, 판정내용 등을 방송장비를 이용하여 관중에게 알린다. 장내의 소란을 예방하거나 사람을 찾기 위하여 안내방송을 하기도 한다. 스포츠방송프로듀서(방송연출가)의 지시를 받아 방송하기도 한다. 시상식 등의 행사에서 사회를 보기도 한다. 정해진 음악을 방송하기도 한다. 방송상태 점검을 위하여 장내의 스피커를 점검하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"수집","workFunc2":"오락제공","workFunc3":"관련없음","similarNm":"장내아나운서","dJobECd":"4163","dJobECdNm":"[4163]아나운서 및 리포터","dJobJCd":"2833","dJobJCdNm":"[2833]아나운서 및 리포터","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006685:1', '{"dJobCd":"K000006685","dJobCdSeq":"1","dJobNm":"경주장아나운서","workSum":"경마, 경륜 및 경정장에서 관중에게 경주상황을 중계하고, 관련 프로그램을 진행한다.","doWork":"경주에 참여하는 선수 및 장비, 마필 등의 정보를 수집한다. 관중에게 설명할 자료를 정리하고 방송장비 상태를 점검한다. 경주 중계 시 선수명단, 경주상황, 결과 등을 실황으로 알린다. 장내 질서정리방송 및 안내방송을 한다. 중계내용을 모니터링하고 경주 관련 프로그램을 진행하거나 해설하기도 한다. 선수나 교관 등을 인터뷰하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|시각|","workFunc1":"수집","workFunc2":"오락제공","workFunc3":"관련없음","connectJob":"경마아나운서, 경륜아나운서, 경정아나운서","dJobECd":"4163","dJobECdNm":"[4163]아나운서 및 리포터","dJobJCd":"2833","dJobJCdNm":"[2833]아나운서 및 리포터","dJobICd":"R911","dJobICdNm":"[R911]스포츠 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002291:1', '{"dJobCd":"K000002291","dJobCdSeq":"1","dJobNm":"기상캐스터","workSum":"날씨와 관련된 기사를 작성하고 편집하여 방송에서 보도한다.","doWork":"기상청에서 제공하는 자료를 정리하여 방송보도용 기사를 작성한다. 기온, 구름, 바람 등 기상상황을 보여줄 방송화면 그래픽의 순서를 정하고 영상그래픽디자이너와 협의한다. 방송프로듀서(방송연출가)와 협의하여 최종적으로 기사를 편집한다. 기상보도 내용을 연습한 후 생방송 또는 녹화방송을 한다. 야외 보도를 위해 촬영장소 및 시간 등을 기획하고 중계차 기술자들과 협의한다. 현장에서 날씨와 관련된 기사를 취재하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"웨더캐스터","certLic":"기상예보기술사, 기상기사, 기상감정기사","dJobECd":"4163","dJobECdNm":"[4163]아나운서 및 리포터","dJobJCd":"2833","dJobJCdNm":"[2833]아나운서 및 리포터","dJobICd":"J602","dJobICdNm":"[J602]텔레비전 방송업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007085:1', '{"dJobCd":"K000007085","dJobCdSeq":"1","dJobNm":"디스크자키","workSum":"유선방송, 라디오방송 등의 음악프로그램에서 음악방송을 진행한다.","doWork":"라디오방송작가, 라디오방송PD와 협의하여 프로그램의 특성과 청취자의 기호, 신청곡 등에 대한 정보를 기초로 방송될 음악 및 방송대본을 구상한다. 음악해설을 하고 기후, 계절, 교통정보 등 청취자의 관심사에 대하여 이야기한다. 음악신청에 따른 사연을 방송하고 신청자와 전화로 통화하거나 SMS(문자메시지서비스), 인터넷 게시판 등을 통해 방송을 이끌어 나간다. 방송 중에 음악관계자 및 유명인과 인터뷰를 하기도 한다. 국악, 고전음악, 가요 등 한 분야의 음악방송을 전문으로 하기도 한다. 인터넷을 통해 청취자에게 방송실의 영상을 제공하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"청각|언어력|","workFunc1":"수집","workFunc2":"오락제공","workFunc3":"관련없음","similarNm":"DJ","connectJob":"인터넷라디오DJ","dJobECd":"4163","dJobECdNm":"[4163]아나운서 및 리포터","dJobJCd":"2833","dJobJCdNm":"[2833]아나운서 및 리포터","dJobICd":"J601","dJobICdNm":"[J601]라디오 방송업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004443:1', '{"dJobCd":"K000004443","dJobCdSeq":"1","dJobNm":"방송리포터","workSum":"라디오 및 텔레비전 프로그램의 일부 코너에서 특정 정보를 제공하기 위해 취재하고 보도한다.","doWork":"프로그램 제작팀원과의 회의나 자신의 제안을 통해 국민의 관심사가 될 수 있는 주제를 결정한다. 관련된 정보를 수집한 후 취재대상을 섭외한다. 주요 질문내용을 정리하고 취재대상을 만나 취재한다. 취재내용을 녹음 또는 녹화하거나 생방송으로 보도한다. 취재 원고를 작성하거나 편집하기도 한다. 정치, 경제, 사회, 문화, 교통, 스포츠 등의 특정한 분야를 전문적으로 담당하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","similarNm":"리포터","connectJob":"활동 영역에 따라 라디오리포터, 텔레비전리포터, 외국에 거주하면서 해당 지역의 소식을 전하는 경우 통신원","dJobECd":"4163","dJobECdNm":"[4163]아나운서 및 리포터","dJobJCd":"2833","dJobJCdNm":"[2833]아나운서 및 리포터","dJobICd":"J601/J602","dJobICdNm":"[J601]라디오 방송업 / [J602]텔레비전 방송업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005513:1', '{"dJobCd":"K000005513","dJobCdSeq":"1","dJobNm":"방송아나운서","workSum":"텔레비전, 라디오, 케이블 및 인터넷 방송 등을 통하여 뉴스, 공보 및 기타 고지사항을 전달하고 프로그램을 진행한다.","doWork":"국내·외에서 발생한 모든 사건을 진행순서에 따라 보도한다. 취재기자를 연결하여 현장의 상황을 시청자 및 청취자에게 전달한다. 시사프로그램 및 토론프로그램을 진행한다. 사건·사고에 관련된 사람을 취재하여 원인, 진행과정, 결과 등을 보도한다. 쇼프로그램을 진행하거나 의식 또는 행사를 중계방송하기도 한다. 운동경기가 열리는 현장에서 생방송 또는 녹화방송으로 중계하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"분석","workFunc2":"말하기신호","workFunc3":"관련없음","connectJob":"스포츠 방송을 전담하는 경우 스포츠캐스터, 사내방송을 진행하는 경우 사내방송아나운서, 기상캐스터, 교통캐스터","dJobECd":"4163","dJobECdNm":"[4163]아나운서 및 리포터","dJobJCd":"2833","dJobJCdNm":"[2833]아나운서 및 리포터","dJobICd":"J601/J602","dJobICdNm":"[J601]라디오 방송업 / [J602]텔레비전 방송업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004407:1', '{"dJobCd":"K000004407","dJobCdSeq":"1","dJobNm":"비디오자키","workSum":"음악방송에서 뮤직비디오를 소개하거나 방송프로그램을 진행한다.","doWork":"소개할 뮤직비디오나 진행할 방송프로그램에 대해서 작가나 연출자(PD)와 협의한다. 뮤직비디오의 내용이나 방송프로그램의 특색을 고려하여 본인의 개성을 가미하면서 뮤직비디오를 소개하거나 방송을 진행한다. 각종 음악 관련 정보·자료를 수집하거나 현장경험을 통해 젊은이들의 패션, 음악의 선호 등을 파악한다. 연예계 소식을 전하는 연예계뉴스프로그램을 진행하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"청각|언어력|","workFunc1":"수집","workFunc2":"오락제공","workFunc3":"관련없음","similarNm":"VJ","dJobECd":"4163","dJobECdNm":"[4163]아나운서 및 리포터","dJobJCd":"2833","dJobJCdNm":"[2833]아나운서 및 리포터","dJobICd":"J602","dJobICdNm":"[J602]텔레비전 방송업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003442:1', '{"dJobCd":"K000003442","dJobCdSeq":"1","dJobNm":"사회자","workSum":"음악회, 나이트클럽, 텔레비전 및 기타 행사 및 집회장소에서 행사진행이 원활하게 이루어질 수 있도록 사회를 본다.","doWork":"행사진행에 대한 전반적인 사항을 숙지하고 행사진행이 원활히 이루어질 수 있도록 계획을 세운다. 연예인 및 기타 출연자를 청중에게 소개한다. 행상계획에 따라 발음, 표정, 태도 등에 주의하여 행사를 진행한다. 진행상 돌발사고에 대처하여 행사가 원활히 진행되도록 한다. 갖추어 진행이 원활히 이루어지도록 유도한다. 평소에 유머 감각과 행사진행 감각을 키우도록 연습한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내·외","physicalAct":"언어력|","workFunc1":"수집","workFunc2":"오락제공","workFunc3":"관련없음","similarNm":"행사진행자, 진행자, 엠시(MC)","connectJob":"이벤트를 진행할 경우 이벤트진행자","dJobECd":"4163","dJobECdNm":"[4163]아나운서 및 리포터","dJobJCd":"2833","dJobJCdNm":"[2833]아나운서 및 리포터","dJobICd":"J602/R901","dJobICdNm":"[J602]텔레비전 방송업 / [R901]창작 및 예술관련 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;