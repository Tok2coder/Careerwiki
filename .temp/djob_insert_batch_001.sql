INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007263:1', '{"dJobCd":"K000007263","dJobCdSeq":"1","dJobNm":"고위직공무원(일반)","workSum":"중앙 및 지방행정기관에서 정부정책과 그에 관련된 정책 집행을 기획·지휘·조정한다.","doWork":"정부의 정책을 결정하고 예산 및 법령안을 작성·수정하며 정부부처의 법령을 해석하고 적용한다. 정책수행을 기획·조직 및 통제하고 외국에서 국가를 대표·대리한다. 정부부처의 관련 행정업무를 기획·지휘·조정한다. 각급 지방자치단체의 구역, 조직 및 행정 관리를 담당한다. 지자체의 주민복지 증진, 산업진흥과 지역개발 등 지방행정 분야의 정책 수행을 기획·조직·통제한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0111","dJobECdNm":"[0111]의회의원·고위공무원 및 공공단체임원","dJobJCd":"1110","dJobJCdNm":"[1110]의회 의원·고위 공무원 및 공공단체 임원","dJobICd":"O841","dJobICdNm":"[O841]입법 및 일반 정부 행정","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007264:1', '{"dJobCd":"K000007264","dJobCdSeq":"1","dJobNm":"공공기관임원","workSum":"정부 산하 단체 및 관련 공공기관의 정책 수행을 기획, 조직 및 통제한다.","doWork":"공기업ㆍ준정부기관 등 공공기관의 사업을 기획하고 총괄한다. 기관의 중장기 경영전략 방향과 연간 경영방침을 설정하고 경영목표를 수립한다. 수립된 경영목표 달성을 위한 사업계획을 수립하고 조정한다. 이사회의 심의·의결을 통하여 공공기관의 주요 의사결정을 담당하며 공공기관의 경영을 책임진다. 임기 중 공공기관의 경영성과에 대하여 책임을 진다. 이사회에 부쳐진 안건을 심의하고, 의결에 참여한다. 경영목표에 따른 예산편성 지침을 수립하고 예산을 조정·편성하고 예산 대비 실적을 분석한다. 감사기준에 따라 공기업ㆍ준정부기관의 업무와 회계를 감사하고 그 의견을 이사회에 제출한다. 임무수행에 필요한 직원의 채용과 배치 등에 관하여 필요한 지원을 하고 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"공공기관장, 공공기관고위임원, 공공기관원장, 공공기관부원장, 공공기관 운영이사, 공공기관 관리이사 등","connectJob":"건강보험심사평가원장, 경제인문사회연구회이사장, 공공기관고위임원, 공무원연금공단이사장, 과학기술정책연구원장, 교통안전공단이사장, 국민건강보험공단이사장, 국민연금공단이사장, 국토연구원장, 근로복지공단이사장 등","dJobECd":"0111","dJobECdNm":"[0111]의회의원·고위공무원 및 공공단체임원","dJobJCd":"1110","dJobJCdNm":"[1110]의회 의원·고위 공무원 및 공공단체 임원","dJobICd":"O841","dJobICdNm":"[O841]입법 및 일반 정부 행정","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003893:1', '{"dJobCd":"K000003893","dJobCdSeq":"1","dJobNm":"교육감","workSum":"각 시·도의 교육·학예 업무를 집행하는 시·도교육청의 장으로서 지방교육정책을 수립하고 소속 직원들을 지휘·감독한다.","doWork":"지방교육에 관한 조례 제정, 교육규칙, 예산편성, 교육기관 설치, 건물 신축, 의무교육, 사회교육, 체육진흥 등의 교육정책을 최종 결정한다. 교육비 및 특별회계비를 집행하고 일반사무를 처리한다. 의결을 요하는 안건을 지방의회에 제출한다. 시·도교육위원회가 지방교육정책을 심의·의결할 수 있도록 지원한다. 소속 직원을 지휘·감독한다. 학교직원의 복무, 승진, 징계, 임면 등의 인사행정을 관리한다. 교과서 또는 취학문제 등을 관리, 감독한다. 지역사회 및 공공단체에 협조를 요청하며 교원 또는 개인, 사회단체 및 정부기관 등에 교육계획 및 방침을 설명하는 등 교육청의 대외적인 활동을 지원·조정한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","certLic":"정교사(1급, 2급)","dJobECd":"0111","dJobECdNm":"[0111]의회의원·고위공무원 및 공공단체임원","dJobJCd":"1110","dJobJCdNm":"[1110]의회 의원·고위 공무원 및 공공단체 임원","dJobICd":"O842","dJobICdNm":"[O842]사회 및 산업정책 행정","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001333:1', '{"dJobCd":"K000001333","dJobCdSeq":"1","dJobNm":"국무총리","workSum":"대통령의 명을 받아 각 중앙행정기관의 장을 지휘·감독한다.","doWork":"국무총리실(대통령의 명을 받아 행정 각부를 통괄하는 대통령의 제1위 보좌기관)을 관장한다. 국무위원의 임명을 제청할 수 있는 권한(국무위원 임명제청권)과 해임을 건의할 수 있는 권한(국무위원 해임건의건)을 행사한다. 중앙행정기관의 명령이나 처분이 위법 또는 부당하다고 인정할 때에는 대통령의 승인을 얻어 이를 중지 또는 취소한다. 대통령, 국무위원과 함께 국무회의의 구성원이 되며 국무회의에서 부의장이 된다. 대통령 권한대행, 국회출석 발언권, 국정행위문서 부서권(문서에 의한 대통령의 국법상 행위에 대하여 국무총리와 관계 국무위원이 서명하는 것), 총리령 발포권을 행사한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0111","dJobECdNm":"[0111]의회의원·고위공무원 및 공공단체임원","dJobJCd":"1110","dJobJCdNm":"[1110]의회 의원·고위 공무원 및 공공단체 임원","dJobICd":"O841","dJobICdNm":"[O841]입법 및 일반 정부 행정","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002519:1', '{"dJobCd":"K000002519","dJobCdSeq":"1","dJobNm":"국회의원","workSum":"입법과 관련하여 헌법과 법률을 개정 제안·의결하고, 국가재정과 관련하여 정부의 예산안을 심의·확정하고 결산을 심사하며, 일반국정과 관련하여 감사와 조사를 실시한다.","doWork":"헌법과 법률에 규정된 개정 절차에 따라 특정 조항을 수정·삭제하거나 새로운 조항을 추가한다. 국가나 국민에게 중대한 재정적 부담을 지우는 조약 또는 입법사항에 관한 조약의 체결, 비준에 대한 동의권을 행사한다. 정부의 예산안을 심의, 확정하고 국가의 수입, 지출에 대한 결산을 심사한다. 국정 감사, 조사를 통해 국정운영의 잘못된 부분을 적발하고 시정시킨다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","connectJob":"지방의회의원","dJobECd":"0111","dJobECdNm":"[0111]의회의원·고위공무원 및 공공단체임원","dJobJCd":"1110","dJobJCdNm":"[1110]의회 의원·고위 공무원 및 공공단체 임원","dJobICd":"O841","dJobICdNm":"[O841]입법 및 일반 정부 행정","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003017:1', '{"dJobCd":"K000003017","dJobCdSeq":"1","dJobNm":"군수","workSum":"광역시 또는 도(道)의 관할에 속하는 하급 지방자치단체인 군(郡)의 대표이며 최고책임자로서, 군(郡)에 관한 소관업무를 총괄 관장하고, 소속 공무원을 지휘·감독한다.","doWork":"광역지방자치단체인 군의 최고책임자로서 군을 대표하고 관련된 행정사무를 총괄·지휘한다. 법령이 정하는 바에 따라 소속 공무원을 지휘·감독한다. 군의 고유사무와 법령에 따라 국가로부터 위임받은 업무를 처리한다. 지방의회의 승인을 받아 지방예산을 집행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","connectJob":"도지사, 시장, 구청장","dJobECd":"0111","dJobECdNm":"[0111]의회의원·고위공무원 및 공공단체임원","dJobJCd":"1110","dJobJCdNm":"[1110]의회 의원·고위 공무원 및 공공단체 임원","dJobICd":"O841","dJobICdNm":"[O841]입법 및 일반 정부 행정","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004518:1', '{"dJobCd":"K000004518","dJobCdSeq":"1","dJobNm":"노동조합고위임원","workSum":"근로자의 권리와 경제적 이익을 증진하기 위해 노동조합의 제반 활동을 기획·조정·통제·결정하는 등 노동조합의 업무를 총괄한다.","doWork":"사용자측과 노동조건, 임금, 승진, 해고 등에 대해서 단체교섭을 한다. 조합원 또는 산하조합을 규합하여 동맹파업 등의 쟁의행위를 하며 이를 지휘한다. 정기적으로 또는 수시로 직장대회나 전국대회를 개최한다. 조합의 활동사항, 장래계획, 교섭방침, 경리내용에 대해 발표·보고를 한다. 정기적 또는 부정기적으로 발행하는 조합 기관지의 편집, 발행, 배포를 지도·감독한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","certLic":"공인노무사","dJobECd":"0111","dJobECdNm":"[0111]의회의원·고위공무원 및 공공단체임원","dJobJCd":"1110","dJobJCdNm":"[1110]의회 의원·고위 공무원 및 공공단체 임원","dJobICd":"S942","dJobICdNm":"[S942]노동조합","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003392:1', '{"dJobCd":"K000003392","dJobCdSeq":"1","dJobNm":"노동조합임원","workSum":"사업주에 대해 노동자들의 노동조건 개선과 권리 향상을 위한 업무를 수행한다.","doWork":"임금체불, 퇴직금, 노동조합 가입 등 노동자의 노동조건에 대한 상담을 한다. 노동조합 활동 등의 단위사업장 문제에 대하여 조합원들을 대상으로 교육한다. 노동조합의 상황 점검과 활동 방향, 조합사업 등을 논의한다. 다른 노조의 활동을 지원하거나 공동활동을 모색한다. 언론이나 대중매체에 진행되고 있는 현안에 대하여 보도자료를 제공하고 취재에 협조하여 노동조합의 활동을 홍보한다. 집회를 추진하거나 사업주와 교섭활동을 한다. 공인노무사에게 법률적인 지원을 받거나 노동운동전문가에게 실태조사, 분석에 대한 지원을 받는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","certLic":"공인노무사","dJobECd":"0111","dJobECdNm":"[0111]의회의원·고위공무원 및 공공단체임원","dJobJCd":"1110","dJobJCdNm":"[1110]의회 의원·고위 공무원 및 공공단체 임원","dJobICd":"S942","dJobICdNm":"[S942]노동조합","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003049:1', '{"dJobCd":"K000003049","dJobCdSeq":"1","dJobNm":"대법원장","workSum":"사법부의 최고상급기관인 대법원의 수장으로서 사법행정권을 총괄하고 사법행정상의 최고책임을 진다.","doWork":"대법관이 아닌 법관의 임명권을 행사한다. 대법원의 일반사무를 관장하여 대법원의 직원과 관할 법원의 법원행정사무 및 그 직원을 지휘·감독한다. 대법관회의의 의장이 되며, 전원합의체 재판장으로서의 지위를 가진다. 대법관 임명제청권, 각급판사 보직권, 헌법재판소재판관 지명권, 중앙선거관리위원회위원 지명권, 법원직원 임명권과 사법행정권을 행사한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","connectJob":"헌법재판소장","dJobECd":"0111","dJobECdNm":"[0111]의회의원·고위공무원 및 공공단체임원","dJobJCd":"1110","dJobJCdNm":"[1110]의회 의원·고위 공무원 및 공공단체 임원","dJobICd":"O841","dJobICdNm":"[O841]입법 및 일반 정부 행정","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003854:1', '{"dJobCd":"K000003854","dJobCdSeq":"1","dJobNm":"대통령","workSum":"대한민국의 최고 책임자이며 행정부의 수반으로서 국가를 대표한다.","doWork":"국가의 원수이며, 외국에 대하여 국가를 대표한다. 국가의 독립, 영토의 보전, 국가의 계속성과 헌법을 수호할 책무를 진다. 조국의 평화적 통일을 위한 성실한 의무를 진다. 행정권의 수반으로서 책임을 진다. 필요하다고 인정할 때에는 외교·국방·통일 기타 국가안위에 관한 중요정책을 국민투표에 붙일 수 있다. 조약을 체결·비준한다. 외교사절을 신입·접수 또는 파견한다. 헌법과 법률이 정하는 바에 의하여 국군을 통수한다. 법률에서 구체적으로 범위를 정하여 위임받은 사항과 법률을 집행하기 위하여 필요한 사항에 관하여 대통령령을 발할 수 있다. 내우·외환·천재·지변 또는 중대한 재정·경제상의 위기에 있어서 국가의 안전보장 또는 공공의 안녕질서를 유지하기 위하여 긴급한 조치가 필요하고 국회의 집회를 기다릴 여유가 없을 때에 한하여 최소한으로 필요한 재정·경제상의 처분을 하거나 이에 관하여 법률의 효력을 가지는 명령을 발할 수 있다. 국가의 안위에 관계되는 중대한 교전상태에 있어서 국가를 보위하기 위하여 긴급한 조치가 필요하고 국회의 집회가 불가능한 때에 한하여 법률의 효력을 가지는 명령을 발할 수 있다. 긴급한 조치의 처분 또는 명령을 한 때에는 지체 없이 국회에 보고하여 그 승인을 얻어야 한다. 전시·사변 또는 이에 준하는 국가비상사태에 있어서 병력으로써 군사상의 필요에 응하거나 공공의 안녕질서를 유지할 필요가 있을 때에는 법률이 정하는 바에 의하여 계엄을 선포할 수 있다. 헌법과 법률이 정하는 바에 의하여 공무원을 임면한다. 법률이 정하는 바에 의하여 사면·감형 또는 복권을 명할 수 있다. 법률이 정하는 바에 의하여 훈장 기타의 영전을 수여한다. 국회에 출석하여 발언하거나 서한으로 의견을 표시할 수 있다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0111","dJobECdNm":"[0111]의회의원·고위공무원 및 공공단체임원","dJobJCd":"1110","dJobJCdNm":"[1110]의회 의원·고위 공무원 및 공공단체 임원","dJobICd":"O841","dJobICdNm":"[O841]입법 및 일반 정부 행정","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002528:1', '{"dJobCd":"K000002528","dJobCdSeq":"1","dJobNm":"도지사","workSum":"도(道)의 대표이며 최고책임자로서, 도(道)에 관한 소관업무를 총괄 관장하고, 소속 공무원을 지휘·감독한다.","doWork":"광역지방자치단체인 도의 최고책임자로서 도를 대표하고 관련된 행정사무를 총괄·지휘한다. 법령이 정하는 바에 따라 소속 공무원을 지휘·감독하고 도의 고유사무와, 법령에 따라 국가로부터 위임받은 업무를 처리하며 지방의회의 승인을 받아 지방예산을 집행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0111","dJobECdNm":"[0111]의회의원·고위공무원 및 공공단체임원","dJobJCd":"1110","dJobJCdNm":"[1110]의회 의원·고위 공무원 및 공공단체 임원","dJobICd":"O841","dJobICdNm":"[O841]입법 및 일반 정부 행정","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007355:1', '{"dJobCd":"K000007355","dJobCdSeq":"1","dJobNm":"비영리단체임원","workSum":"각종 비영리단체의 임원으로서 단체를 설립목적에 적합하도록 관장하고 관련 사업의 진행을 관리하며 소속 직원을 지도·감독한다.","doWork":"소속 비영리단체의 설립 목적 달성에 필요한 사업을 계획하고 진행을 관리한다. 소속 비영리단체의 인사, 예산, 기타 행정사무를 관장한다. 각종 임원회의 또는 외부 회의에 참석하여 소관업무에 대하여 의견을 말하고 단체가 해야 할 업무의 개선방향을 모색한다. 연구회, 친목회 등에서 사회를 맡아 회의를 진행하기도 한다. 학술, 문화에 관한 연구를 하여 학회나 학술지 등에 연구결과를 발표하거나, 소속 직원의 연구에 대해 지도를 하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0111","dJobECdNm":"[0111]의회의원·고위공무원 및 공공단체임원","dJobJCd":"1110","dJobJCdNm":"[1110]의회 의원·고위 공무원 및 공공단체 임원","dJobICd":"S949","dJobICdNm":"[S949]기타 협회 및 단체","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004881:1', '{"dJobCd":"K000004881","dJobCdSeq":"1","dJobNm":"비영리단체총괄관리자","workSum":"각종 비영리단체의 대표로서 단체를 설립목적에 적합하도록 관장하고 관련 사업의 진행을 총괄하며 소속 직원을 지도·감독한다.","doWork":"대외적으로 소속단체를 대표하고, 임직원들의 인사권을 행사한다. 소속 비영리단체의 설립 목적 달성에 필요한 사업을 계획하고 진행을 총괄한다. 설립목적을 수행하기 위해 관련 규정과 법령의 범위 내에서 소속단체의 전반적인 정책을 수립하고 운영에 대한 책임을 진다. 기타 소속단체 내의 제반 문제점을 해결한다. 연구, 조사, 관리, 기획 등을 지시·감독·통제·조정한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"비영리단체원장, 비영리단체총재, 비영리단체위원장, 비영리단체회장","dJobECd":"0111","dJobECdNm":"[0111]의회의원·고위공무원 및 공공단체임원","dJobJCd":"1110","dJobJCdNm":"[1110]의회 의원·고위 공무원 및 공공단체 임원","dJobICd":"S949","dJobICdNm":"[S949]기타 협회 및 단체","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005200:1', '{"dJobCd":"K000005200","dJobCdSeq":"1","dJobNm":"시장","workSum":"시의 대표이며 최고책임자로서 시에 관한 소관업무를 총괄 관장하고, 소속 공무원을 지휘·감독한다.","doWork":"기초자치단체 및 광역자치단체인 지방자치단체의 장 또는 제주특별자치도의 행정시장으로서 행정사무를 총괄한다. 시의 공무원에 대한 임면, 교육훈련, 복무, 징계 등에 관한 사항을 처리할 수 있는 권한을 행사한다. 주민의 일상생활과 관계되는 고유사무 및 중앙행정기관으로부터 위탁받은 위임사무를 수행한다. 주민을 대표하는 대표기관으로서 그 지역의 중요한 일을 결정한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","connectJob":"구청장","dJobECd":"0111","dJobECdNm":"[0111]의회의원·고위공무원 및 공공단체임원","dJobJCd":"1110","dJobJCdNm":"[1110]의회 의원·고위 공무원 및 공공단체 임원","dJobICd":"O841","dJobICdNm":"[O841]입법 및 일반 정부 행정","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002871:1', '{"dJobCd":"K000002871","dJobCdSeq":"1","dJobNm":"장관","workSum":"중앙 행정집행기관의 수장으로서 헌법과 법률이 정하는 범위 내의 행정사무를 주관하고, 소속 공무원을 지휘·감독한다.","doWork":"대통령·국무총리의 지휘감독을 받아, 국무회의에서 심의한 사항을 집행하는 행정집행기관의 장으로서 소관사무를 결정·집행한다. 청원의 심사·통지, 소원재결, 소속기관의 주관쟁의 결정, 감독처분, 허가 및 특허 등 각종 행정처분과 사실행위를 한다. 행정각부 장관은 부령(部令)을 제정하여 공포할 수 있다. 소속 공무원의 임명권·임명제청권·징계권·영전수여상신권 등을 행사한다. 주관사무에 관하여 법률이나 대통령령의 제정·개정·폐지가 필요할 때는 그 안을 작성하여 국무회의에 제출하고 중앙관서의 장으로서 헌법·예산회계법 등에 의거한 각종 재정에 관한 권한을 행사한다. 특임장관의 경우 대통령이 특별히 지정하는 사무 또는 대통령의 명을 받아 국무총리가 특히 지정하는 사무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","connectJob":"기획재정부장관, 교육부장관, 과학기술정보통신부장관, 외교부장관, 통일부장관, 법무부장관, 국방부장관, 행정안전부장관, 문화체육관광부장관, 농림축산식품부장관, 산업통상자원부장관, 보건복지부장관, 환경부장관, 고용노동부장관, 여성가족부장관, 국토교통부장관, 해양수산부장관, 중소벤처기업부장관 등 각 행정부처 장관, 대통령비서실장, 국가안보실장, 감사원장, 국가정보원장, 법제처장, 국가보훈처장, 식품의약품안전처장, 국무조정실장, 방송통신위원회위원장, 국가인권위원회위원장, 공정거래위원회위원장, 금융위원회위원장, 국민권익위원회위원장 등 장관급 인사","dJobECd":"0111","dJobECdNm":"[0111]의회의원·고위공무원 및 공공단체임원","dJobJCd":"1110","dJobJCdNm":"[1110]의회 의원·고위 공무원 및 공공단체 임원","dJobICd":"O841","dJobICdNm":"[O841]입법 및 일반 정부 행정","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004357:1', '{"dJobCd":"K000004357","dJobCdSeq":"1","dJobNm":"정당고위임원","workSum":"정당의 목표인 정권창출을 위하여 정당의 전반적인 정책을 결정하고 제반 정치활동을 기획·지휘·조정·통제하는 등 정당의 모든 업무를 총괄한다.","doWork":"당의 정책촉진, 인사, 정치자금의 조달 및 그 운영, 당세 확장, 선거대책, 국회대책 등과 같은 정당의 중요사항에 대한 대강(大綱) 방침을 수립한다. 수립된 대강(大綱) 방침을 당수 및 관계 수뇌부와 협의하여 결정한다. 결정된 대강(大綱) 방침을 당의 조직을 통하거나 개인적인 절충에 의해서 실시하며 원활히 운영한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","connectJob":"중앙당 각 위원회의 위원급 이상인 경우 정무직당직자","dJobECd":"0111","dJobECdNm":"[0111]의회의원·고위공무원 및 공공단체임원","dJobJCd":"1110","dJobJCdNm":"[1110]의회 의원·고위 공무원 및 공공단체 임원","dJobICd":"S949","dJobICdNm":"[S949]기타 협회 및 단체","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006847:1', '{"dJobCd":"K000006847","dJobCdSeq":"1","dJobNm":"정부행정관리자(일반)","workSum":"고위공무원의 포괄적인 지휘 하에 부처 내 다른 부서 관리자와 의논하여 해당 부서의 행정업무를 기획, 지휘 및 조정하거나 지방관서 기관장으로서 지방관서의 행정업무를 기획, 지휘 및 조정한다.","doWork":"행정 분야별 정책을 수립하고 집행하며, 예산을 편성한다. 고객, 정부기관 및 다른 기관과 교섭한다. 인적 및 회계 자원의 이용을 기획·통제하고 전체 근로자의 동향을 파악한다. 종합적 행정업무 수행 계획을 수립하고 집행을 지휘하며 조정한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"정부행정기획자","connectJob":"정부기관 부서장, 정부 지방관서 기관장","dJobECd":"0111","dJobECdNm":"[0111]의회의원·고위공무원 및 공공단체임원","dJobJCd":"1110","dJobJCdNm":"[1110]의회 의원·고위 공무원 및 공공단체 임원","dJobICd":"O841","dJobICdNm":"[O841]입법 및 일반 정부 행정","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002776:1', '{"dJobCd":"K000002776","dJobCdSeq":"1","dJobNm":"차관","workSum":"중앙행정기관의 정무직 공무원으로서 소속 장관을 보좌하고 장관의 직무를 대행하여 수행한다.","doWork":"각 원·부·처의 장관을 보좌한다. 장관의 위임을 받아 소속기관의 사무를 처리한다. 소속 공무원을 지휘·감독한다. 장관의 부재 시에는 그 직무를 대행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","connectJob":"기획재정부차관, 교육부차관, 과학기술정보통신부차관, 외교부차관, 통일부차관, 법무부차관, 국방부차관, 행정안전부차관, 문화체육관광부차관, 농림축산식품부차관, 산업통상자원부차관, 보건복지부차관, 환경부차관, 고용노동부차관, 여성가족부차관, 국토교통부차관, 해양수산부차관, 중소벤처기업부차관 등 각 행정부처 차관, 경호처장, 국가정보원차장, 국가정보원기획조정실장, 감사원사무총장, 감사원감사위원, 방송통신위원회부위원장, 방송통신위원회상임위원, 원자력안전위원회부위원장, 국회사무처사무차장, 국회사무처입법처장, 국회예산정책처장, 국회입법조사처장, 법제처장, 국가보훈차장, 공정거래위원회 부위원장, 국민권익위원회 부위원장, 인사혁신처장, 식품안정처장, 각 청장 (병무청장, 방위사업청장, 경찰청장, 소방청장, 문화재청장, 농촌진흥청장, 산림청장, 특허청장, 기상청장, 질병관리청장), 국무조정실차장, 국무총리비서실장, 정무수석비서관, 국민소통수석비서관, 민정수석비서관, 시민사회수석비서관, 인사수석비서관, 일자리수석비서관, 경제수석비서관, 사회수석비서관, 경제보좌관, 과학기술보좌관, 고위공직자수사처장 등 차관급 인사","dJobECd":"0111","dJobECdNm":"[0111]의회의원·고위공무원 및 공공단체임원","dJobJCd":"1110","dJobJCdNm":"[1110]의회 의원·고위 공무원 및 공공단체 임원","dJobICd":"O841","dJobICdNm":"[O841]입법 및 일반 정부 행정","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006543:1', '{"dJobCd":"K000006543","dJobCdSeq":"1","dJobNm":"협회임원","workSum":"동종업계의 회원이나 회원사의 이익을 도모하기 위하여 단체활동을 조직하고 정보수집, 조사연구, 자료발간, 홍보활동 등을 계획·감독·통제·조정하는 모든 업무를 총괄한다","doWork":"협회 또는 조합 운영에 따른 전반적인 정책을 수립한다. 소속 직원의 인사와 업무수행을 조정·관리하고 예산을 관장한다. 총회, 이사회 등의 회의를 소집한다. 관계 회의나 모임에 참석하여 의견을 교환하고 협회 또는 조합의 활동계획, 개선방향 등을 협의하고 결정한다. 회원 또는 회원사의 운영현황, 실적, 계획 등을 파악·평가하고 이들에게 자문을 한다. 협회 또는 조합을 대표하여 정부기관이나 타 기관 관계자와 협의한다. 회원 또는 회원사에게 필요한 정보를 입수하여 제공한다. 협회 또는 조합의 활동을 홍보하는 업무를 관장한다. 기타 조합·협회 운영상의 문제점을 해결한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","connectJob":"대표하는 단체의 성격에 따라 단체장, 조합장, 협회장","dJobECd":"0111","dJobECdNm":"[0111]의회의원·고위공무원 및 공공단체임원","dJobJCd":"1110","dJobJCdNm":"[1110]의회 의원·고위 공무원 및 공공단체 임원","dJobICd":"S941","dJobICdNm":"[S941]산업 및 전문가 단체","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004115:1', '{"dJobCd":"K000004115","dJobCdSeq":"1","dJobNm":"영리단체총괄경영자","workSum":"영리업체의 대표로서 업체의 이익을 극대화하기 위한 영리 활동에 관련된 제반 업무를 총괄하고 사원들의 인사 관리를 한다.","doWork":"대내외적으로 영리업체를 대표하여 경영방침, 사업계획, 계약 등을 최종결정하고 책임을 진다. 기업 이익을 높이기 위한 제반 업무를 총괄 관리하고 책임을 진다. 임직원들에 대한 인사 업무를 관장한다. 경영의 각종 문제점을 해결한다. 주식회사의 경우, 이사회를 주재한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"사장, 대표이사, CEO(Chief Executive Officer), 최고경영자","connectJob":"CPO (개인정보보호책임자(Chief Privacy Officer)), CIO (최고정보관리책임자(Chief Information Officer)), CMO (최고마케팅책임자(Chief Marketing Officer)), CTO (최고기술책임자(Chief Technology Officer)), CFO (최고재무책임자(Chief Financial Officer)), COO (최고운영책임자(Cheif Operating Officer)), CKO (최고지식경영자(Chief Knowledge Officer)), CAO (최고행정관리자(Chief Administration Officer))","dJobECd":"0112","dJobECdNm":"[0112]기업 고위임원","dJobJCd":"1120","dJobJCdNm":"[1120]기업 고위 임원","dJobICd":"ALL","dJobICdNm":"[ALL]전체","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006953:1', '{"dJobCd":"K000006953","dJobCdSeq":"1","dJobNm":"정보보호최고책임자","workSum":"기업의 정보통신시스템 등에 대한 보안 및 정보의 안전한 관리 등 정보보호 업무를 책임진다.","doWork":"정보통신망의 안정성·신뢰성 확보를 위하여 관리적·기술적·물리적 보호조치를 포함한 종합적 관리체계를 수립하고 운영한다. 하드웨어 또는 소프트웨어의 결함이나 체계 설계상의 허점으로 인해 사용자에게 허용된 권한 이상의 동작이나 허용된 범위 이상의 정보 열람·변조·유출을 가능하게 하는 취약점에 대해 분석하고 개선한다. 침해사고 정의 및 범위, 대응체계, 대응방법 및 절차, 복구방법 및 절차, 증거자료 수집 및 보관 등을 포함한 침해사고 대응계획을 마련한다. 위험을 처리하기 위한 정보보호 대책 선정, 우선순위를 결정한다. 개인정보 및 중요정보 보호를 위한 암호화 대상, 암호강도, 보안서버의 기능·관리·운영 등의 적합성을 검토한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"제어조작","similarNm":"CISO(Chief Information Security Officer)","connectJob":"개인정보보호책임자, 정보호책임관(CIO), 최고보안책임자(CSO)","dJobECd":"0112","dJobECdNm":"[0112]기업 고위임원","dJobJCd":"1120","dJobJCdNm":"[1120]기업 고위 임원","dJobICd":"ALL","dJobICdNm":"[ALL]전체","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007260:1', '{"dJobCd":"K000007260","dJobCdSeq":"1","dJobNm":"최고기술책임자","workSum":"기업의 기술개발·관리·활용을 총괄하고 기술의 발전 방향을 제시한다.","doWork":"기업의 기술 전략을 유지·관리하여 기술성과를 지속적으로 발휘할 수 있도록 한다. 기술적 트렌드 정보를 분석하고 사업에 영향을 미칠 수 있는 기술 전환점을 예측하여 기업의 장기적 기술전략을 수립한다. 장기적인 관점에서 기술 전략 방향을 최고경영자에게 조언하고 대안을 제시한다. 제품 및 서비스의 개발 방향이 기업의 전략적 비전과 부합하도록 기술R&D를 관리한다. 개발조직 간의 협조나 방향을 유도하고 분쟁 등을 조정한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"CTO(Chief Technology Officer), 테크니컬리더","dJobECd":"0112","dJobECdNm":"[0112]기업 고위임원","dJobJCd":"1120","dJobJCdNm":"[1120]기업 고위 임원","dJobICd":"ALL","dJobICdNm":"[ALL]전체","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007261:1', '{"dJobCd":"K000007261","dJobCdSeq":"1","dJobNm":"최고마케팅책임자","workSum":"제품의 외부 홍보 및 생산자의 가치를 소비자에게 전달할 수 있도록 마케팅 전략을 수립한다.","doWork":"매출과 브랜드 인지도 상승을 위한 혁신적인 마케팅 전략을 개발한다. 효율성을 높이는 조직 전체의 프로세스를 구현한다. 고객을 위한 마케팅 전략 구축을 위해 조직원을 동기부여한다. 마케팅 목표가 전반적인 기업의 목표와 일치하도록 영업 및 서비스팀과 협력을 통해 사업 성장을 촉진한다. 시장 내 기업의 위치를 파악하기 위해 조사 및 평가를 진행하고 업계 최신 트렌드를 파악한다. 기업의 제품 및 서비스를 소비자에게 인지시키고 실질적인 수요가 발생하도록 대내외 커뮤니케이션 전략을 수립한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"CMO(Chief Marketing Officer), 마케팅리더, 마케팅총괄","dJobECd":"0112","dJobECdNm":"[0112]기업 고위임원","dJobJCd":"1120","dJobJCdNm":"[1120]기업 고위 임원","dJobICd":"ALL","dJobICdNm":"[ALL]전체","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007262:1', '{"dJobCd":"K000007262","dJobCdSeq":"1","dJobNm":"최고운영책임자","workSum":"기업의 주요 사업을 담당하고 회사 운영을 전반적으로 관리하고 임직원들을 서로 연결해주는 역할을 하기도 한다.","doWork":"경영상태, 시장환경 등 기업 내부 현황을 파악한다. 재무 현황, 조직 현황, 사업 모델, 비전과 목표 등 각 항목의 현황을 분석하고 예상되는 리스크를 진단하여 기업의 방향성을 재정립한다. 경영진과 조직의 목표 및 방향이 통일성을 가지도록 단기 및 중장기 사업 로드맵을 작성한다. 핵심사업 외의 사업을 계획하거나 수립된 사업계획서의 타당성을 검토한다. 기존의 핵심 모델을 분석하기 위해 영업이익률을 검토한다. 자금 조달을 위해 최신 경영정보를 통해 IR(투자사업계획서)를 수립한다. 조직의 원활한 소통을 고려하여 조직을 편성하고 전체적인 프로젝트를 관리한다. 최고경영자(CEO)의 외부활동을 지원하기 위해 경영 대리 업무를 수행하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"COO(Chief Operating Officer)","dJobECd":"0112","dJobECdNm":"[0112]기업 고위임원","dJobJCd":"1120","dJobJCdNm":"[1120]기업 고위 임원","dJobICd":"ALL","dJobICdNm":"[ALL]전체","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006837:1', '{"dJobCd":"K000006837","dJobCdSeq":"1","dJobNm":"최고재무책임자","workSum":"기업의 재무와 회계 업무를 총괄하며 투자와 인수합병 전략을 수립하기도 한다.","doWork":"기업의 가치를 극대화하기 위한 기업전략 도출을 위해 협력 및 의견조정을 담당한다. 현재 영위하고 있는 사업들로부터 최대의 가치를 창조할 수 있도록 계획 수립여부를 점검한다. 주주가치를 창출하기 위한 기업확장전략 개발을 검토하고 평가한다. 전반적인 재무전략의 도출, 채택권고, 실행을 책임진다. 기업의 관리자들이 목표달성, 의사결정, 실적점검을 위한 정보를 제공하기 위한 성과지표 등을 고안하고 실행한다. 외부공시 관리, 제반 세금관련 업무, 거래은행과의 유대관계 유지, 기업의 리스크관리 프로그램 관리 등 기업의 재무활동에 대한 실질적이고 효율적인 관리를 책임진다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"CFO(Chief Financial Officer), 재무담당관리자, 재무총괄","certLic":"회계사","dJobECd":"0112","dJobECdNm":"[0112]기업 고위임원","dJobJCd":"1120","dJobJCdNm":"[1120]기업 고위 임원","dJobICd":"ALL","dJobICdNm":"[ALL]전체","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003688:1', '{"dJobCd":"K000003688","dJobCdSeq":"1","dJobNm":"감사관리자","workSum":"정부부처, 공공기관, 기업 등에서 감사업무에 종사하는 사무원들을 지휘·감독한다.","doWork":"담당 감사사무원에게 업무를 분담하고, 감사방법 및 방향을 지시한다. 소속감사원에 대한 교육을 실시하고 제도개선 및 건의사항을 수렴하여 시정을 건의한다. 위법·위규행위에 대한 제재를 가하며, 부서 간 이해상충 부분을 조율하고, 업무처리 절차를 개선한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"컴플라이언스관리자, 감사역","connectJob":"회계감사역","dJobECd":"0122","dJobECdNm":"[0122]경영지원 관리자","dJobJCd":"1212","dJobJCdNm":"[1212]경영 지원 관리자","dJobICd":"ALL","dJobICdNm":"[ALL]전체","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001349:1', '{"dJobCd":"K000001349","dJobCdSeq":"1","dJobNm":"고객상담업무관리자","workSum":"고객을 대상으로 각종 청구와 상담안내, 수납, 수요조사 등의 전화서비스 업무에 종사하는 직원들의 제반 활동을 감독·조정한다.","doWork":"종사원의 전화서비스 태도, 정확성, 회사정책과의 일치성 등을 감시하고, 관리한다. 소비자의 불평·불만을 조정한다. 계산원장과 고지서의 정확성을 검사한다. 서비스에 대한 고객의 질문에 답한다. 상담품질관리를 위해 상담유형을 분석하여 종사자 교육을 기획하고 진행한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"콜센터관리자","certLic":"소비자전문상담사(1급, 2급)","dJobECd":"0122","dJobECdNm":"[0122]경영지원 관리자","dJobJCd":"1212","dJobJCdNm":"[1212]경영 지원 관리자","dJobICd":"N759","dJobICdNm":"[N759]기타 사업지원 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006848:1', '{"dJobCd":"K000006848","dJobCdSeq":"1","dJobNm":"기획관리자","workSum":"기업의 경영관리에 필요한 경영정보를 수집·분류·관리하고 경영업무를 기획, 조정, 결정한다.","doWork":"최고 경영층의 경영관리에 필요한 제반 의사결정을 위하여 기업경영정보를 수집·분류·정리·보관·검색·이용 및 폐기하는 등 정보처리 전 과정이 합리적으로 수행되도록 관리한다. 수시로 분석된 경영정보에 따라 경영목표 및 계획을 기업 내·외의 환경 변화에 맞추어 수정·보완한다. 중장기 경영계획에 따라 연차별 투자계획을 수립하며, 승인된 투자계획에 따라 사업별, 기간별, 항목별 투자집행을 조성통제한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0122","dJobECdNm":"[0122]경영지원 관리자","dJobJCd":"1212","dJobJCdNm":"[1212]경영 지원 관리자","dJobICd":"ALL","dJobICdNm":"[ALL]전체","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002233:1', '{"dJobCd":"K000002233","dJobCdSeq":"1","dJobNm":"도로영업관리자","workSum":"고속도로를 통행하는 차량에 대한 통행료 징수업무, 영업소 운영개선, 통행료 면제차량 관리 등의 업무를 총괄한다.","doWork":"통행료 징수에 따르는 제반 문제점을 조사하고 파악한다. 영업소 운영개선을 위하여 근로제도를 분석·검토하고 개선안을 마련한다. 영업업무와 관련된 대민 서비스 개선업무의 추진방향을 설정한다. 통행료 면제차량 및 무료통행증을 관리한다. 예매통행권 판매업무를 관리한다. 각종 통행권카드 수급을 관리한다. 통행료 부정방지대책을 수립하고 예방한다. 부정운행차량을 단속 및 계도한다. 도로영업과 관련된 민원을 처리한다. 영업소업무를 지도·감독한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","dJobECd":"0122","dJobECdNm":"[0122]경영지원 관리자","dJobJCd":"1212","dJobJCdNm":"[1212]경영 지원 관리자","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001336:1', '{"dJobCd":"K000001336","dJobCdSeq":"1","dJobNm":"도로영업종합관리자","workSum":"도로영업계획, 도로영업업무, 영업시스템관리, 도로시설영업에 관한 제반 사항을 지휘·감독한다.","doWork":"도로영업에 관한 장·단기 기본계획을 수립한다. 도로영업에 관한 제도개선 연구를 총괄한다. 고속도로를 통행하는 차량에 대한 통행료 징수업무, 영업소 운영개선, 통행료 면제차량 관리 등의 업무를 총괄한다. 고속도로 통행요금징수설비의 시설계획 및 관리계획 등을 총괄한다. 부대사업의 사용료 징수, 계약체결 및 관리에 대한 사항을 감독하고 이에 수반되는 제반 사항을 총괄한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0122","dJobECdNm":"[0122]경영지원 관리자","dJobJCd":"1212","dJobJCdNm":"[1212]경영 지원 관리자","dJobICd":"H529","dJobICdNm":"[H529]기타 운송관련 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003513:1', '{"dJobCd":"K000003513","dJobCdSeq":"1","dJobNm":"병원중앙공급실관리자","workSum":"병원에서 환자의 진료에 사용되는 장비와 물품을 공급하는 중앙공급실에서 활동하는 직원들의 업무를 관리·감독한다.","doWork":"병원에서 사용되는 의료비품의 현황을 파악하고 품목별로 보유량, 분실, 파손에 대하여 기록하고 관리한다. 물품의 재고를 정리하고 공급물품 및 장비를 주문한다. 세척하여 사용하는 비품(시트, 가운, 옷, 장갑, 치료도구 등)의 세척 및 소독 업무에 종사하는 종업원들을 관리·감독한다. 소독장비나 세척장치의 사용방법을 종업원들에게 설명한다. 병원비품을 전문으로 세척하는 외주업체를 관리하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","similarNm":"의료비품관리자","dJobECd":"0122","dJobECdNm":"[0122]경영지원 관리자","dJobJCd":"1212","dJobJCdNm":"[1212]경영 지원 관리자","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004703:1', '{"dJobCd":"K000004703","dJobCdSeq":"1","dJobNm":"신문판매국장","workSum":"자사 신문을 보급하는 지국(支局)을 관리하고 지국관리사무원의 활동을 감독·조정한다.","doWork":"부서책임자 및 지국관리사무원과 협의하여 판매계획 및 운영방침을 확립한다. 신문판매에 대한 영업계획을 평가하여 개선방안 및 대책을 수립한다. 신문판매를 담당하는 지국의 영업실적을 총괄 관리한다. 지국의 실적증대 및 애로점 해결을 위한 대책을 수립하도록 지국관리사무원에게 지시한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"감독","workFunc3":"관련없음","similarNm":"신문판매본부장","dJobECd":"0122","dJobECdNm":"[0122]경영지원 관리자","dJobJCd":"1212","dJobJCdNm":"[1212]경영 지원 관리자","dJobICd":"J581","dJobICdNm":"[J581]서적, 잡지 및 기타 인쇄물 출판업","inqYear":"2012","etc":"김중진 작업 강도 수정"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006657:1', '{"dJobCd":"K000006657","dJobCdSeq":"1","dJobNm":"자재구매관리자","workSum":"기업 또는 단체의 공급, 보관 및 분배활동을 기획, 지휘 및 조정하고 구매계약의 체결, 공급자와의 가격협의, 구매상품의 품질 확보 등 구매 및 자재 관련 관리업무를 수행한다.","doWork":"재무제표, 기업신용평가사 등을 바탕으로 협력사를 발굴하고 관리한다. 생산관련 부서와 협의를 통해 구매계획을 수립한다. 예정가격 작성 기준에 따라 적정 기초금액을 산출하고 원가분석을 통한 발주금액 산정업무를 관리한다. 조직의 경영에 필요한 공사, 용역, 물품, 외자재 등을 적기에 조달하기 위해 효과적이고 효율적으로 조달할 수 있는 계약을 체결하고 입찰 및 계약 관련 지출증빙서류, 계약서류 등을 관리한다. 개발, 생산 현장의 인적/물적 자원을 원활히 보급하기 위하여 필요한 물자공급을 조정·관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0122","dJobECdNm":"[0122]경영지원 관리자","dJobJCd":"1212","dJobJCdNm":"[1212]경영 지원 관리자","dJobICd":"ALL","dJobICdNm":"[ALL]전체","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006658:1', '{"dJobCd":"K000006658","dJobCdSeq":"1","dJobNm":"재무관리자","workSum":"기업 또는 단체 내부의 예산, 회계 및 재정 업무와 재무상황 평가, 예산 편성 및 각종 재정운용을 감독하고 재정정책 수립에 참여하며, 회계 및 경리 업무에 종사하는 직원의 활동을 지휘하고 감독ㆍ조정한다.","doWork":"예산을 효율적으로 확보하여 공사 연간 예산을 합리적으로 편성하고 이를 효율적으로 운영하기 위한 계획을 수립·분석한다. 원활한 사업추진을 위해 현금 흐름을 예측하여 관련된 자금조달과 운용계획을 수립하고적시에 효율적으로 실행하여 재무건전성을 제고한다. 결산 프로세스에 따라 계획을 수립하고 기업의 거래기록을 유지하며 재정과 경영 상태를 분석하고 검토한다. 재무 및 회계 관련 업무를 조정·관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0122","dJobECdNm":"[0122]경영지원 관리자","dJobJCd":"1212","dJobJCdNm":"[1212]경영 지원 관리자","dJobICd":"ALL","dJobICdNm":"[ALL]전체","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006849:1', '{"dJobCd":"K000006849","dJobCdSeq":"1","dJobNm":"준법감시인","workSum":"회사의 내부통제체제 및 내부통제 기준의 준수여부를 점검하고 점검결과에 대하여 대표이사(필요시 상근감사위원 및 감사위원회)에게 보고하는 등 준법감시 부서에서 준법감시 관련 활동과 준법감시담당자의 업무를 지휘감독한다.","doWork":"임직원의 내부 통제기준의 준수여부에 대해 점검 및 조사한다. 정관, 규정의 제개정, 이사회 등 각종 위원회의 부의사항(감사위원회 제외), 새로운 업무의 개발 및 추진 등 주요 업무에 대한 법규 준수 측면에서 사전 검토한다. 임직원의 윤리강령의 제정 및 개정하고 운영한다. 신용평가의 공정성 및 신뢰성 확보를 위한 업무 전반에 대한 상시 감시감독시스템을 구축하고 운영한다. 내부통제기준 준수 매뉴얼을 작성하여 배포한다. 부문별 부서별 준법감시담당자가 행한 내부통제기준 여부 모니터링 결과의 기록을 유지 및 미비한 사항을 개선한다. 임직원의 윤리강령의 제정 및 개정하고 운영한다. 법규준수 관련 임직원을 교육한다. 준법감시 관련 활동과 준법감시담당자의 업무를 지휘·감독한다. 이사회, 감사, 기타 주요 회의에 참석하여 의견을 진술한다. 내부통제 기준의 준수여부를 점검하고 기준을 위반하는 경우 이를 조사하여 상근감사위원 및 감사위원회에 보고한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"준법감시관리자, 컴플라이언스관리자","certLic":"변호사, 공인회계사, 감정평가사, 공인중개사","dJobECd":"0122","dJobECdNm":"[0122]경영지원 관리자","dJobJCd":"1212","dJobJCdNm":"[1212]경영 지원 관리자","dJobICd":"ALL","dJobICdNm":"[ALL]전체","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006752:1', '{"dJobCd":"K000006752","dJobCdSeq":"1","dJobNm":"총무인사관리자","workSum":"기업의 조직구조, 직무, 정원, 채용, 배치, 전환, 인사고과, 급여, 복리후생, 복무, 인간관계, 노사관계 등 인사 관련 업무에 종사하는 사무원의 활동을 지휘하고 감독ㆍ조정한다.","doWork":"인적 자원을 효율적으로 활용하고 육성하기 위하여 직무조사 및 직무 분석을 통해 채용, 배치, 육성, 평가, 보상, 승진, 퇴직 등의 제반 사항을 관리하며, 조직의 인사를 평가하고 인사제도를 개선 및 운영한다. 임금ㆍ인건비 관리, 급여관리, 직무급제 등 급여 및 인건비를 관리한다. 조직의 경영목표를 달성하기 위하여 자산의 효율적인 관리, 임직원에 대한 원활한 업무지원 및 복지지원, 대·내외적인 회사의 품격 유지를 위한 제반 업무를 관리한다. 근태관리, 총무 및 복리후생 관리 및 조직문화를 관리하고 전직지원 및 교육훈련을 운영하고 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","connectJob":"총무관리자, 인사관리자","dJobECd":"0122","dJobECdNm":"[0122]경영지원 관리자","dJobJCd":"1212","dJobJCdNm":"[1212]경영 지원 관리자","dJobICd":"ALL","dJobICdNm":"[ALL]전체","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004970:1', '{"dJobCd":"K000004970","dJobCdSeq":"1","dJobNm":"회계감사관리자","workSum":"의뢰인의 요청에 따라 회계감사, 세무조정계산서 작성, 국세심판 청구대리, 경영진단 및 경영제도의 개선과 원가계산 등을 수행하고 회계감사를 총괄 관리한다.","doWork":"회사 혹은 기타 조직의 회계감사, 법정감사, 주식회사의 외부감사를 수행한다. 세무업무, 법인세와 소득세의 세무조정, 각종 이의신청, 심사, 심판청구 등 세무대리업무, 세무에 대한 자문, 개인기업의 법인전환업무, 장부기장대리, 신고대리, 경영자문 등을 한다. 회계감사 업무를 총괄 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"회계감사역","connectJob":"회계감사원관리자, 원가회계사관리자, 세무관리자","certLic":"공인회계사(CPA)","dJobECd":"0122","dJobECdNm":"[0122]경영지원 관리자","dJobJCd":"1212","dJobJCdNm":"[1212]경영 지원 관리자","dJobICd":"ALL","dJobICdNm":"[ALL]전체","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003873:1', '{"dJobCd":"K000003873","dJobCdSeq":"1","dJobNm":"광고기획총괄관리자","workSum":"광고주와 계약한 광고의 기획, 제작, 실행의 전 과정을 총괄 관리한다.","doWork":"광고주가 의뢰한 제품이나 자료를 검토하여 광고전략을 수립하고, 광고 표현형태 및 제작방향을 설정한다. 광고제작의 실무자들로 이루어진 제작팀 구성을 지시한다. 광고마케터, 시장조사분석가 등에게 시장상황을 분석하도록 지시한다. 시장상황의 분석결과를 바탕으로 광고디자이너, 광고영상감독, 광고문안작성원, 광고기획자 등이 협업하여 광고를 제작하도록 지시한다. 광고제작이 완료되면 광고주를 대상으로 시사회를 열고 광고주의 의견을 받아 광고물을 수정하거나 재촬영을 지시한다. 최종 완성된 광고물이 전파매체에 방송되거나, 신문, 잡지 등에 게재되도록 지시한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"CD(Creative Director)","dJobECd":"0123","dJobECdNm":"[0123]마케팅·광고·홍보 관리자","dJobJCd":"1220","dJobJCdNm":"[1220]마케팅 및 광고·홍보 관리자","dJobICd":"M713","dJobICdNm":"[M713]광고업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003174:1', '{"dJobCd":"K000003174","dJobCdSeq":"1","dJobNm":"광고홍보관리자","workSum":"기업체 혹은 단체의 광고 및 대외 홍보활동을 기획·지휘·조정한다.","doWork":"신문사, 라디오 및 텔레비전 방송국, 경기장 및 문화단체, 공연장, 광고대행사 등과 광고계약을 체결하거나, 광고 전반을 위임하여 관리한다. 기업이나 단체의 이미지 관리 또는 원하는 여론 조성을 위해 기업 혹은 단체의 계획, 업적, 견해 등을 매스컴을 통해 일반 대중에게 알리는 홍보프로그램을 기획하고 실행한다. 제품 및 용역 등의 판매를 위한 광고를 위해 시장규모, 예상 시장점유율, 경쟁사의 광고 지출규모, 생산비, 유통비용, 마진 등을 고려하여 광고예산을 산정하고 실행한다. 광고홍보부서의 사무원들을 지휘·감독한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0123","dJobECdNm":"[0123]마케팅·광고·홍보 관리자","dJobJCd":"1220","dJobJCdNm":"[1220]마케팅 및 광고·홍보 관리자","dJobICd":"M713","dJobICdNm":"[M713]광고업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001350:1', '{"dJobCd":"K000001350","dJobCdSeq":"1","dJobNm":"컨택센터운영관리자","workSum":"컨택센터의 전산·통신시스템 관리, 문자서비스, 이메일, 온라인 상담(채팅, 원격지원)을 통한 수주업무(주문접수 등), 판촉활동, 고객관리 업무 등을 총괄 관리한다.","doWork":"컨택센터 업무추진계획을 수립하고 추진실적을 점검한다. 상담원 인력수급계획을 수립하고 신규 직원을 채용한다. 상담원의 성과를 관리한다. 상담원의 교육계획을 수립하고 추진한다. 컨택센터  전산시스템을 관리한다. 상담원의 판촉활동, 고객관리, 상담활동 등을 관리한다. 컨택센터 고객불만을 접수·처리한다. 고객만족도 실시 등 컨택센터 업무와 관련하여 담당자와 협의한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","similarNm":"콜센터운영관리자","connectJob":"고객상담업무관리자","dJobECd":"0123","dJobECdNm":"[0123]마케팅·광고·홍보 관리자","dJobJCd":"1220","dJobJCdNm":"[1220]마케팅 및 광고·홍보 관리자","dJobICd":"N759","dJobICdNm":"[N759]기타 사업지원 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006753:1', '{"dJobCd":"K000006753","dJobCdSeq":"1","dJobNm":"공학연구관리자","workSum":"기계, 전기, 전자, 건설 등 공학에 대한 상업, 비상업적 연구개발 등과 관련된 활동을 기획, 지휘 및 조정하는 등 연구개발(R&D)업무를 총괄한다.","doWork":"기계, 전기, 전자, 건설 등 공학 분야의 단기 및 중장기 연구계획과 실행계획을 수립한다. 연구개발관련 신사업 기획 및 신제품 발굴 업무를 한다. 연구정책의 방향에 따라 연구부서나 연구팀을 구성하고 그 업무를 관리한다. 진행 중인 연구개발사업의 결과를 검토하고 제안한다. 연구계획부터 진행사항, 최종 결과를 상위 총괄관리자에게 보고하고 협의한다. 연구사업 성과를 평가한다. 연구개발 팀원의 업무를 관리하고 감독·평가한다. 타 부서 또는 본부와 업무를 협의한다. 연구개발 사업과 관련하여 정부, 기업, 유관단체와 네트워크 구축, 업무 협의 및 조정업무를 한다. 연구개발 관련 보고서를 작성하거나 세미나 등에서 발표한다. 연구를 수행하기도 한다. 정부의 과제 등을 프로젝트 수주를 위한 업무를 수행하기도 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"공학연구개발본부장, 공학연구개발부서관리자, 연구소장, CTO(Chief Technical Officer), 공학R&D본부장","dJobECd":"0131","dJobECdNm":"[0131]연구 관리자","dJobJCd":"1311","dJobJCdNm":"[1311]연구 관리자","dJobICd":"C/M","dJobICdNm":"[C]제조업 / [M]전문, 과학 및 기술 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002791:1', '{"dJobCd":"K000002791","dJobCdSeq":"1","dJobNm":"바이오의약품연구기획자","workSum":"임상적 미충족 수요를 파악하기 위해, 시장동향, 기술 및 특허동향, 경제성 분석 후 타겟 질환과 목표제품을 선정, 연구하여 수행체계를 수립한다.","doWork":"해당 질환의 잠재적 시장규모, 시장의 트랜드 및 미래 예측자료를 확인하고 시장성이 우수한 물질을 선정한 후 의약품으로 개발할 물질의 종류를 결정한다. 최적화 및 생산화 기술 파악, 특허전략 수립 및 개발에 소요되는 기간과 계획을 수립하고 전체적인 개발 소요비용을 산출하여 목표 제품특성(TPP) 보고서를 작성한다. 시장 진입 방향 모색을 위한 경쟁자 파악, 신소재 동향 분석에 필요한 자료 수집 및 동향을 파악한다. 빅데이터 분석방법을 활용하고 핵심기술 개발현황을 파악하며 지식 재산권 자료를 수집한다. 특허 맵 작성을 통해 신소재 제품ㆍ신기술 개발현황을 파악하고 미래 기술 도출 및 중장기 기술 로드맵을 작성한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0131","dJobECdNm":"[0131]연구 관리자","dJobJCd":"1311","dJobJCdNm":"[1311]연구 관리자","dJobICd":"C211/M701","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업 / [M701]자연과학 및 공학 연구개발업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003585:1', '{"dJobCd":"K000003585","dJobCdSeq":"1","dJobNm":"바이오화학제품연구기획자","workSum":"바이오화학제품 관련 시장 동향, 기술 동향 및 특허 분석을 통해 바이오화학제품 개발전략을 수립, 연구 지원, 연구결과의 지적재산권을 관리한다.","doWork":"바이오화학 제품시장 및 경쟁사의 동향을 파악하고 사업의 중장기전략을 검토하여 연구개발 목표 및 계획을 수립한다. 연구개발 리스크를 파악하고 연구개발 종합계획·목표달성전략 및 실행방안을 수립한다. 중점 추진전략 및 과제 도출과 투입자원 및 예산계획을 수립하고, 수립된 중장기 제품·기술개발 로드맵과 연구개발 과제를 관리한다. 바이오화학 제품의 국내외 기술 및 시장 정보를 수집하고, 경쟁사 연구개발, 벤치마킹 및 성공사례 등을 분석하여 자사 적용 프로세스를 확립한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0131","dJobECdNm":"[0131]연구 관리자","dJobJCd":"1311","dJobJCdNm":"[1311]연구 관리자","dJobICd":"C211/M701","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업 / [M701]자연과학 및 공학 연구개발업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007150:1', '{"dJobCd":"K000007150","dJobCdSeq":"1","dJobNm":"사회과학연구관리자","workSum":"경제학, 경영학 등 사회과학에 대한 상업, 비상업적 연구개발 등과 관련된 활동을 기획, 지휘 및 조정한다.","doWork":"중장기 발전 목표에 부합하는 연구 사업을 기획하고, 연구 사업을 합목적적으로 수행, 관리한다. 경영 목표를 효과적으로 달성하기 위한 연구 사업을 기획하고, 인적·물적 자원을 관리하여 최적의 성과를 산출할 수 있도록 기관의 의사결정을 체계적으로 관리한다. 연구 사업 목적에 따라 과학적이고 체계적인 조사 계획, 자료 수집, 자료 분석 등 연구 과정을 감독·평가한다. 최종 의사결정 사안에 대해 대안을 제시하거나 조정한다. 정해진 기간과 예산범위 내에서 연구사업을 마칠 수 있도록 연구사업 일정관리, 예산관리 업무를\n수행하며 정해진 심의 및 보고 일정에 따라 과제를 수행한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"사회과학연구개발본부장, 사회과학연구개발부서관리자, 연구소장","connectJob":"인문과학연구관리자, 공학연구관리자, 자연과학연구관리자, 생명과학연구관리자, 예체능연구관리자 등","dJobECd":"0131","dJobECdNm":"[0131]연구 관리자","dJobJCd":"1311","dJobJCdNm":"[1311]연구 관리자","dJobICd":"M702","dJobICdNm":"[M702]인문 및 사회과학 연구개발업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007151:1', '{"dJobCd":"K000007151","dJobCdSeq":"1","dJobNm":"생명과학연구관리자","workSum":"농학, 유전공학 등 생명과학에 대한 상업, 비상업적 연구개발 등과 관련된 활동을 기획, 지휘 및 조정하는 등 연구개발(R&D) 업무를 총괄한다.","doWork":"DNA 조작을 통해 신물질 탐색 실험을 하거나, 실험동물의 체세포나 혈액을 분리 및 조작 실험을 통해 새로운 생물의약품, 생물화학제품, 바이오식품 등의 신제품 개발 업무를 관리한다. 진행 중인 연구개발사업의 결과를 검토하고 제안한다. 연구계획부터 진행사항, 최종 결과를 상위 총괄관리자에게 보고하고 협의한다. 연구사업 성과를 평가한다. 연구개발 팀원의 업무를 관리하고 감독·평가한다. 타 부서 또는 본부와 업무를 협의한다. 연구개발 사업과 관련하여 정부, 기업, 유관단체와 네크워크 구축, 업무 협의 및 조정업무를 한다. 연구개발 관련 보고서를 작성하거나 세미나 등에서 발표한다. 연구를 수행하기도 한다. 정부의 과제 등을 프로젝트 수주를 위한 업무를 수행하기도 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"생명과학연구개발본부장, 생명과학연구개발부서관리자, 연구소장, CTO(Chief Technical Officer), 생명과학R&D연구개발본부장","connectJob":"농학연구관리자","dJobECd":"0131","dJobECdNm":"[0131]연구 관리자","dJobJCd":"1311","dJobJCdNm":"[1311]연구 관리자","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005440:1', '{"dJobCd":"K000005440","dJobCdSeq":"1","dJobNm":"석유화학연구기획자","workSum":"기업의 기술경쟁력 및 연구개발 능력의 강화를 위하여 국내외 시장 및 기술 동향 분석을 통해 연구개발 전략을 수립하고 과제를 관리한다.","doWork":"시장 및 경쟁사 동향을 파악하고 사업 중장기전략 검토하여 연구개발 목표 및 계획을 수립한다. 연구개발 리스크를 파악하고 연구개발 종합계획·목표달성전략 및 실행방안을 수립한다. 중점 추진전략 및 과제 도출과 투입자원 및 예산계획을 수립하고, 수립된 중장기 제품·기술개발 로드맵과 연구개발 과제를 관리한다. 국내외 기술 및 시장 정보를 수집하고, 경쟁사 연구개발 벤치마킹 및 성공사례 등을 분석하여 자사 적용 프로세스를 확립한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0131","dJobECdNm":"[0131]연구 관리자","dJobJCd":"1311","dJobJCdNm":"[1311]연구 관리자","dJobICd":"C201","dJobICdNm":"[C201]기초 화학물질 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007152:1', '{"dJobCd":"K000007152","dJobCdSeq":"1","dJobNm":"연구개발관리자(일반)","workSum":"인문, 자연, 공학 등 연구개발 업무를 계획·조직·통제·조정하며 R&D 총괄업무를 한다.","doWork":"시간, 자원, 설비, 비용 등을 고려하여 단기 및 중장기 연구계획과 실행계획을 수립한다. 연구개발관련 신사업 기획 및 신제품 발굴 업무를 한다. 연구정책의 방향에 따라 연구부서나 연구팀을 구성하고 그 업무를 관리한다. 진행 중인 연구개발사업의 결과를 검토하고 제안한다. 연구계획부터 진행사항, 최종 결과를 상위 총괄관리자에게 보고하고 협의한다. 연구사업 성과를 평가한다. 연구개발 팀원의 업무를 관리하고 감독·평가한다. 타 부서 또는 본부와 업무를 협의한다. 연구개발 사업과 관련하여 정부, 기업, 유관단체와 네트워크 구축, 업무 협의 및 조정업무를 한다. 연구개발 관련 보고서를 작성하거나 세미나 등에서 발표한다. 연구를 수행하기도 한다. 정부의 과제 등을 프로젝트 수주를 위한 업무를 수행하기도 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"연구개발본부장, 연구개발부서관리자, 연구소장, CTO(Chief Technical Officer), R&D연구개발본부장","connectJob":"인문과학연구관리자, 사회과학연구관리자, 공학연구관리자, 자연과학연구관리자, 생명과학연구관리자, 예체능연구관리자 등","dJobECd":"0131","dJobECdNm":"[0131]연구 관리자","dJobJCd":"1311","dJobJCdNm":"[1311]연구 관리자","dJobICd":"ALL","dJobICdNm":"[ALL]전체","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007126:1', '{"dJobCd":"K000007126","dJobCdSeq":"1","dJobNm":"예체능연구관리자","workSum":"음악, 미술, 무용 등 예체능 분야에 대한 상업, 비상업적 연구개발 등과 관련된 활동을 기획, 지휘 및 조정한다.","doWork":"음악, 미술, 무용 등 예체능 분야의 단기 및 중장기 연구계획과 실행계획을 수립한다. 연구개발관련 신사업 기획 및 신제품 발굴 업무를 한다. 연구정책의 방향에 따라 연구부서나 연구팀을 구성하고 그 업무를 관리한다. 진행 중인 연구개발사업의 결과를 검토하고 제안한다. 연구계획부터 진행사항, 최종 결과를 상위 총괄관리자에게 보고하고 협의한다. 연구사업 성과를 평가한다. 연구개발 팀원의 업무를 관리하고 감독·평가한다. 타 부서 또는 본부와 업무를 협의한다. 연구개발 사업과 관련하여 정부, 기업, 유관단체와  네트워크 구축, 업무 협의 및 조정업무를 한다. 연구개발 관련 보고서를 작성하거나 세미나 등에서 발표한다. 연구를 수행하기도 한다. 정부의 과제 등을 프로젝트 수주를 위한 업무를 수행하기도 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"예체능연구개발본부장, 예체능연구개발부서관리자, 연구소장, R&D연구개발본부장","dJobECd":"0131","dJobECdNm":"[0131]연구 관리자","dJobJCd":"1311","dJobJCdNm":"[1311]연구 관리자","dJobICd":"R902","dJobICdNm":"[R902]도서관, 사적지 및 유사 여가관련 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007008:1', '{"dJobCd":"K000007008","dJobCdSeq":"1","dJobNm":"의약품연구기획자","workSum":"의약품 신규 프로젝트의 발굴·기획 및 제품화를 위하여 개발요구사항을 분석하여 연구개발 목표를 설정하고, 연구개발 리스크를 파악하여 연구개발 수행체계를 수립한다.","doWork":"특허·문헌 관련 제품에 관한 자료를 정리하여 보고하고, 조사된 자료를 근거로 개발 아이디어를 구체화하여 제안한다. 연구개발 목표 수립(QTPP) 및 대략적인 개발 일정 수립, 허가요건, 위험요소, 시장 상황, 타부서의 개발 일정을 종합하여 개발전략 수립과 신규 프로젝트로 상정한다. 연구인력, 연구 일정 관리, 프로젝트별 주요 마일스톤 관리와 외부파트너와의 개발일정을 조율하고, 연구 산출물의 검토 및 결과물 관리, 허가 및 외부 송부 문서들을 검토 및 승인한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0131","dJobECdNm":"[0131]연구 관리자","dJobJCd":"1311","dJobJCdNm":"[1311]연구 관리자","dJobICd":"C211/M701","dJobICdNm":"[C211]기초 의약물질 및 생물학적 제제 제조업 / [M701]자연과학 및 공학 연구개발업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006957:1', '{"dJobCd":"K000006957","dJobCdSeq":"1","dJobNm":"인문과학연구관리자","workSum":"교육학 등 인문학에 대한 상업, 비상업적 연구개발 등과 관련된 활동을 기획, 지휘 및 조정한다.","doWork":"교육학 등 인문학 분야의 단기 및 중장기 연구계획과 실행계획을 수립한다. 연구개발관련 신사업 기획 및 신제품 발굴 업무를 한다. 연구정책의 방향에 따라 연구부서나 연구팀을 구성하고 그 업무를 관리한다. 진행 중인 연구개발사업의 결과를 검토하고 제안한다. 연구계획부터 진행사항, 최종 결과를 상위 총괄관리자에게 보고하고 협의한다. 연구사업 성과를 평가한다. 연구개발 팀원의 업무를 관리하고 감독·평가한다. 타 부서 또는 본부와 업무를 협의한다. 연구개발 사업과 관련하여 정부, 기업, 유관단체와 네트워크 구축, 업무 협의 및 조정업무를 한다. 연구개발 관련 보고서를 작성하거나 세미나 등에서 발표한다. 연구를 수행하기도 한다. 정부의 과제 등을 프로젝트 수주를 위한 업무를 수행하기도 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"인문학연구개발본부장, 인문학연구개발부서관리자","connectJob":"사회과학연구관리자, 공학연구관리자, 자연과학연구관리자, 생명과학연구관리자, 예체능연구관리자 등","dJobECd":"0131","dJobECdNm":"[0131]연구 관리자","dJobJCd":"1311","dJobJCdNm":"[1311]연구 관리자","dJobICd":"M702","dJobICdNm":"[M702]인문 및 사회과학 연구개발업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007149:1', '{"dJobCd":"K000007149","dJobCdSeq":"1","dJobNm":"자연과학연구관리자","workSum":"물리학, 화학, 기상학 등 자연과학에 대한 상업, 비상업적 연구개발 등과 관련된 활동을 기획, 지휘 및 조정하는 등 R&D 총괄업무를 한다.","doWork":"물리학, 화학, 기상학 등 자연과학 분야의 단기 및 중장기 연구계획과 실행계획을 수립한다. 연구개발관련 신사업 기획 및 신제품 발굴 업무를 한다. 연구정책의 방향에 따라 연구부서나 연구팀을 구성하고 그 업무를 관리한다. 진행 중인 연구개발사업의 결과를 검토하고 제안한다. 연구계획부터 진행사항, 최종 결과를 상위 총괄관리자에게 보고하고 협의한다. 연구사업 성과를 평가한다. 연구개발 팀원의 업무를 관리하고 감독·평가한다. 타 부서 또는 본부와 업무를 협의한다. 연구개발 사업과 관련하여 정부, 기업, 유관단체와 네트워크 구축, 업무 협의 및 조정업무를 한다. 연구개발 관련 보고서를 작성하거나 세미나 등에서 발표한다. 연구를 수행하기도 한다. 정부의 과제 등을 프로젝트 수주를 위한 업무를 수행하기도 한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"자연과학연구개발본부장, 자연과학연구개발부서관리자, 연구소장, CTO(Chief Technical Officer), 자연과학R&D연구개발본부장","dJobECd":"0131","dJobECdNm":"[0131]연구 관리자","dJobJCd":"1311","dJobJCdNm":"[1311]연구 관리자","dJobICd":"M701","dJobICdNm":"[M701]자연과학 및 공학 연구개발업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007009:1', '{"dJobCd":"K000007009","dJobCdSeq":"1","dJobNm":"정밀화학연구기획자","workSum":"정밀화학 기업의 기술경쟁력 및 연구개발 능력의 강화를 위하여 국내외 시장 및 기술동향 분석을 통해 정밀화학 연구개발 전략을 수립하고 정밀화학 연구과제를 관리한다.","doWork":"정밀화학 제품시장과 고객 요구사항을 분석하고 기술동향 분석을 실시한다. 환경 리스크 분석 및 정밀화학제품 제조의 법적 규제를 파악하여 중장기 연구개발 전략을 수립한다. 자사 기술 로드맵을 구성하고 제품 개발 계획을 수립한다. 정밀화학제품 연구과제를 선정하고 연구과제에 대한 조직과 예산을 관리하고 연구개발 프로세스를 관리하며 연구과제를 평가한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0131","dJobECdNm":"[0131]연구 관리자","dJobJCd":"1311","dJobJCdNm":"[1311]연구 관리자","dJobICd":"C203/C204","dJobICdNm":"[C203]비료, 농약 및 살균, 살충제 제조업 / [C204]기타 화학제품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004553:1', '{"dJobCd":"K000004553","dJobCdSeq":"1","dJobNm":"교감","workSum":"교장을 보좌하여 학교의 교무관리를 한다.","doWork":"교장(초등학교, 중등교육기관, 특수학교 및 외국인학교)을 도와 학교 교무를 처리한다. 교사들의 근무상황을 평가하여 승진 및 개인 인사고과에 반영한다. 교장의 업무를 보좌하고, 교장의 부재 시에는 교장의 직무를 대행한다. 학생들을 지도·교육한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","connectJob":"초등학교교감, 중학교교감, 고등학교교감, 특수학교교감","certLic":"초등학교 정교사(1급, 2급), 중등학교 정교사(1급, 2급), 보건교사 (1급, 2급)","dJobECd":"0132","dJobECdNm":"[0132]교육 관리자","dJobJCd":"1312","dJobJCdNm":"[1312]교육 관리자","dJobICd":"P851/P852","dJobICdNm":"[P851]초등 교육기관 / [P852]중등 교육기관","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007069:1', '{"dJobCd":"K000007069","dJobCdSeq":"1","dJobNm":"교육장","workSum":"시·도교육청 소속 지역 교육지원청의 소속 각급 학교(유치원, 초등학교, 중학교 등)의 교육 및 학습활동에 관한 사무를 관장한다.","doWork":"관할 교육지원청에 배정된 교육비 특별회계의 범위 내에서 예산을 관리·집행하고 일반사무를 처리한다. 관할 교육지원청의 기본재산과 공공시설 등을 관리한다. 소속 직원을 지휘·감독한다. 교직원의 복무, 승진, 징계, 임면 등의 인사문제를 관리한다. 각급 학교의 설치·이전·폐지, 교육내용, 검정교과서, 통학구역, 환경정화, 사회 및 기타교육, 학예의 진흥, 학교 및 일반체육, 교육·학예시설 및 교구 등에 관한 사항을 관장하고 처리한다. 대외적으로 지역사회 및 공공단체의 협조를 얻기 위한 일을 수행한다. 소속 각급 학교의 운영계획과 방침을 지도·감독한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","certLic":"초등학교 정교사(1급, 2급), 중등학교 정교사(1급, 2급)","dJobECd":"0132","dJobECdNm":"[0132]교육 관리자","dJobJCd":"1312","dJobJCdNm":"[1312]교육 관리자","dJobICd":"O842","dJobICdNm":"[O842]사회 및 산업정책 행정","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003010:1', '{"dJobCd":"K000003010","dJobCdSeq":"1","dJobNm":"교장","workSum":"각급 학교에서 교육, 행정 및 기타 운영활동을 관리·감독한다.","doWork":"교무를 총괄한다. 소속 교직원을 지도·감독한다. 학교의 교육 문제에 관하여 교사, 학부모 및 학생들과 상담한다. 지역단체 및 다른 학교들과 협조관계 유지를 위한 활동을 한다. 교사들과 협의하여 교육과정 및 각종 행사계획 등 제반 교육활동을 수립·운영한다. 주단위로 교직원 조회를 관장한다. 담당교사와 협의하고 수업참관을 통해 수업장학을 실시한다. 교무일지, 근무상황부, 출장명령부 등의 각종 장부 및 공문서를 결재한다. 학교시설을 순시하며 안전문제를 확인·점검하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","connectJob":"초등학교교장, 중학교교장, 고등학교교장, 특수학교교장","certLic":"정교사1급자격","dJobECd":"0132","dJobECdNm":"[0132]교육 관리자","dJobJCd":"1312","dJobJCdNm":"[1312]교육 관리자","dJobICd":"P851/P852","dJobICdNm":"[P851]초등 교육기관 / [P852]중등 교육기관","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007070:1', '{"dJobCd":"K000007070","dJobCdSeq":"1","dJobNm":"대학교무처장","workSum":"대학의 교무업무 전반을 총괄 조정·감독한다.","doWork":"교원의 인사정책 수립, 신입생 선발원칙 수립, 연구업적 평가 등의 교무업무 전반에 대해 조정, 관장한다. 소속 교직원들을 지휘·감독한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","connectJob":"대학교학처장, 대학입학처장","dJobECd":"0132","dJobECdNm":"[0132]교육 관리자","dJobJCd":"1312","dJobJCdNm":"[1312]교육 관리자","dJobICd":"P853","dJobICdNm":"[P853]고등 교육기관","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001964:1', '{"dJobCd":"K000001964","dJobCdSeq":"1","dJobNm":"대학교총장","workSum":"대학을 대표하여 대외적인 활동을 하며 학내의 전반적인 정책을 결정하고 학내 업무 전반을 총괄 관리한다.","doWork":"대학을 대표하여 정부기관, 산업계, 교육 관련 기관, 민간을 대상으로 대외활동을 한다. 이사장으로부터 권한을 위임받아 대학 내부의 행정업무 전반을 총괄하고 책임을 진다. 대학의 조직, 운영 및 교과에 관한 계획을 수립하기 위해 교육당국과 협의하고 그 실행을 감독한다. 예산문제, 시설확장 등 제반 재정문제를 관장한다. 교수진과 간부진의 등급규정, 재정지불규정, 회계규정 등에 관한 운용절차, 규칙 및 규정을 정립한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0132","dJobECdNm":"[0132]교육 관리자","dJobJCd":"1312","dJobJCdNm":"[1312]교육 관리자","dJobICd":"P853","dJobICdNm":"[P853]고등 교육기관","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007071:1', '{"dJobCd":"K000007071","dJobCdSeq":"1","dJobNm":"대학기획처장","workSum":"대학의 기획업무 전반을 총괄 조정·감독한다.","doWork":"대학의 장·단기 발전계획 시행에 따른 전체적인 업무조정과 교육개혁추진 업무를 관리한다. 예산 관련 업무를 총괄하고 사업의 검수평가를 관장한다. 소속 교직원들을 지휘·감독한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0132","dJobECdNm":"[0132]교육 관리자","dJobJCd":"1312","dJobJCdNm":"[1312]교육 관리자","dJobICd":"P853","dJobICdNm":"[P853]고등 교육기관","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004613:1', '{"dJobCd":"K000004613","dJobCdSeq":"1","dJobNm":"대학장","workSum":"각 단과대학의 대표로서 단과대학 행정업무 전반을 총괄 관리한다.","doWork":"단과대학 내 각 학과의 의견을 조정·통합한다. 연간 교육과정의 계획수립에 참여하여 결정한다. 교과과정의 수행을 관장한다. 학생교육 및 교육연구 활동을 감독·조정한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"대학학장","connectJob":"대학원장, 평생교육원장","dJobECd":"0132","dJobECdNm":"[0132]교육 관리자","dJobJCd":"1312","dJobJCdNm":"[1312]교육 관리자","dJobICd":"P853","dJobICdNm":"[P853]고등 교육기관","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007072:1', '{"dJobCd":"K000007072","dJobCdSeq":"1","dJobNm":"대학총무처장","workSum":"대학의 총무업무 전반을 총괄 조정·감독한다.","doWork":"대학의 일반적인 학교 회계 및 재무, 교직원의 인사, 학교 내 건물 및 시설물 관리, 학교 행정 관련 구매 등 행정업무를 총괄 담당한다. 교직원들의 의견을 수렴하고 학교측 의견을 전달하여 교직원과 학교측의 의견을 절충·조절하는 역할을 수행한다. 소속 교직원들을 지휘·감독한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"대학사무처장","dJobECd":"0132","dJobECdNm":"[0132]교육 관리자","dJobJCd":"1312","dJobJCdNm":"[1312]교육 관리자","dJobICd":"P853","dJobICdNm":"[P853]고등 교육기관","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007073:1', '{"dJobCd":"K000007073","dJobCdSeq":"1","dJobNm":"대학학생처장","workSum":"대학의 학생업무 전반을 총괄 조정·감독한다.","doWork":"총학생회를 비롯한 학생대표들의 요구사항을 수렴하고 학교측 의견을 전달하여 학내 구성원 간의 의견을 절충·조절하는 역할을 수행한다. 학사행정 및 학교생활 전반에 관한 업무를 관장한다. 소속 교직원들을 지휘·감독한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"대학교학처장","dJobECd":"0132","dJobECdNm":"[0132]교육 관리자","dJobJCd":"1312","dJobJCdNm":"[1312]교육 관리자","dJobICd":"P853","dJobICdNm":"[P853]고등 교육기관","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005371:1', '{"dJobCd":"K000005371","dJobCdSeq":"1","dJobNm":"사설학원원장","workSum":"사설학원의 운영, 인사, 교육과정, 시설 등을 관리·감독한다.","doWork":"기술, 인문사회, 경영실무, 예능, 보습 등 각종 사설학원의 교육과정, 인사, 예산, 지출, 시설의 운영업무를 총괄한다. 학생의 모집, 정원관리, 교습과정, 수업일수, 학생생활관리 등의 운영에 관한 기본방침을 세우고 관리·감독한다. 실제 단위교과목을 직접 강의하기도 한다. 강사 및 사무직원의 활동을 관리·감독한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","dJobECd":"0132","dJobECdNm":"[0132]교육 관리자","dJobJCd":"1312","dJobJCdNm":"[1312]교육 관리자","dJobICd":"P855","dJobICdNm":"[P855]일반 교습 학원","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003709:1', '{"dJobCd":"K000003709","dJobCdSeq":"1","dJobNm":"유치원원장","workSum":"사립 또는 공립 유치원에서 교육, 행정 및 기타 운영활동을 기획·관리한다.","doWork":"유치원교사 및 직원들의 활동을 관리·감독한다. 유치원의 교육문제에 관하여 유치원교사 및 학부모와 상담한다. 교사들과 협의하여 교육과정 및 각종 행사계획 등 제반 교육활동을 수립·운영한다. 주기적으로 회의를 관장한다. 유치원 시설을 순시하며 안전문제를 확인·점검한다. 담당교사와 협의하고 수업참관을 통해 수업장학을 실시한다. 교무일지, 근무상황부, 출장명령부 등의 각종 장부 및 공문서를 결재한다. 예산을 집행하며, 교사 및 기타 직원을 모집하고 채용하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","connectJob":"유치원원감","certLic":"원감, 유치원 정교사 (1급, 2급)","dJobECd":"0132","dJobECdNm":"[0132]교육 관리자","dJobJCd":"1312","dJobJCdNm":"[1312]교육 관리자","dJobICd":"P851","dJobICdNm":"[P851]초등 교육기관","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005606:1', '{"dJobCd":"K000005606","dJobCdSeq":"1","dJobNm":"검찰총장","workSum":"대검찰청의 각종 사무 및 국내 검찰사무를 통할하며, 소관 검찰청의 검사 및 직원을 지휘·감독한다.","doWork":"대검찰청 소속 차장검사 또는 부장검사 아래에 정책기획, 계획입안, 연구·조사, 심사·평가, 홍보 등을 담당하는 담당관을 두고 업무를 지휘·감독한다. 소속 검사의 직무인 범죄수사, 공소의 제기 및 그 유지에 필요한 사항, 사법경찰의 지휘·감독, 법원에 대한 법력의 정당한 적용 청구, 재판 집행의 지휘·감독, 국가를 당사자 또는 참가인으로 하는 소송과 행정소송 수행 또는 그 수행에 관한 지휘·감독, 다른 법령에 따라 그 권한에 속하는 사항 등을 총괄한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0133","dJobECdNm":"[0133]법률·경찰·소방·교도 관리자","dJobJCd":"1313","dJobJCdNm":"[1313]법률·경찰·소방 및 교도 관리자","dJobICd":"O844","dJobICdNm":"[O844]사법 및 공공질서 행정","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001953:1', '{"dJobCd":"K000001953","dJobCdSeq":"1","dJobNm":"경찰서장","workSum":"경찰서의 책임자로서 관내의 경찰업무에 관한 사무를 총괄하고 소속 경찰관 및 직원을 지휘·감독한다.","doWork":"국민의 생명·신체 및 재산의 보호, 범죄의 예방·진압 및 수사, 치안 정보의 수집, 교통의 단속, 기타 공공의 안녕과 질서의 유지 등 경찰서의 업무를 총괄하고 책임진다. 대형 사건의 경우 현장에서 수사를 지휘하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0133","dJobECdNm":"[0133]법률·경찰·소방·교도 관리자","dJobJCd":"1313","dJobJCdNm":"[1313]법률·경찰·소방 및 교도 관리자","dJobICd":"O844","dJobICdNm":"[O844]사법 및 공공질서 행정","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004074:1', '{"dJobCd":"K000004074","dJobCdSeq":"1","dJobNm":"교도소장","workSum":"교도소의 행정·사무를 총괄하고 소속 교도관 및 직원을 지휘·감독한다.","doWork":"형의 집행 등 형행에 관한 사무와 미결수용자의 수용에 관한 업무를 관장한다. 교도소 내 서무과, 보안과, 분류심사과, 작업과, 교무과, 용도과, 의무과 등의 모든 부서업무를 지휘하고 총괄한다. 부소장(교정부이사관3급 또는 서기관4급), 교정관(5급), 교감(6급) 등 소속 공무원을 지휘·감독한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","connectJob":"교도소의 종류에 따라 구치소장(미결수용업무를 관장), 개방교도소장(전국의 교도소에서 선발된 모범수형자를 집결하여 수용자치제를 허용하고 외부기업체 취업 등 외부통근제도를 실시하여 출소 전 사회적응능력을 배양하는 교도소), 보호감호소장(보호감호처분을 받은 자에 대한 수용·보호 및 사회복귀 처우를 하는 교도소)","dJobECd":"0133","dJobECdNm":"[0133]법률·경찰·소방·교도 관리자","dJobJCd":"1313","dJobJCdNm":"[1313]법률·경찰·소방 및 교도 관리자","dJobICd":"O844","dJobICdNm":"[O844]사법 및 공공질서 행정","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004872:1', '{"dJobCd":"K000004872","dJobCdSeq":"1","dJobNm":"법원장","workSum":"법원의 사법사무를 총괄하고 소속 판사 및 직원을 지휘·감독한다.","doWork":"각급 법원의 수장으로서 관할 법원의 사법행정사무(사법재판과 사법행정에 관한 사무)를 관장한다. 소속 공무원을 지휘·감독한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","connectJob":"법원의 종류에 따라 고등법원장, 지방법원장, 특허법원장, 가정법원장, 행정법원장, 대법관, 헌법재판소재판관","dJobECd":"0133","dJobECdNm":"[0133]법률·경찰·소방·교도 관리자","dJobJCd":"1313","dJobJCdNm":"[1313]법률·경찰·소방 및 교도 관리자","dJobICd":"O844","dJobICdNm":"[O844]사법 및 공공질서 행정","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004128:1', '{"dJobCd":"K000004128","dJobCdSeq":"1","dJobNm":"소방서장","workSum":"소방서의 책임자로서 관내의 소방에 관한 사무를 총괄하고 소속 소방관 및 직원을 지휘·감독한다.","doWork":"화재의 예방, 진압, 재난현장에서의 구조, 구급 업무와 소방활동, 화재조사, 의용소방대 운영 및 산하단체의 활동, 소방시설의 설치와 관리, 소방행정 등 소방서의 제반 업무를 기획·관리한다. 소방서 소속의 소방관 및 직원을 지휘·감독한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0133","dJobECdNm":"[0133]법률·경찰·소방·교도 관리자","dJobJCd":"1313","dJobJCdNm":"[1313]법률·경찰·소방 및 교도 관리자","dJobICd":"O844","dJobICdNm":"[O844]사법 및 공공질서 행정","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001686:1', '{"dJobCd":"K000001686","dJobCdSeq":"1","dJobNm":"국제투자사무관리자","workSum":"국제 투·융자업무, 외환딜링(국제외환시장에서의 은행 간 거래) 및 외화자금관리업무, 해외점포 경영지원업무 등을 총괄 관리한다.","doWork":"국제금융정세 및 국제주식·채권보고서, 경제예측, 증권편람, 회사재무제표 및 기타 금융·재무보고서, 금융잡지 및 기타 출판물 등을 이용하여 주식, 채권 및 기타 투·융자에 대한 정보를 수집한다. 외화자금의 수급계획을 수립하고 외화유동성(외화준비금)을 관리한다. 국내기업의 해외사업 투자, 외국 우량차주에 대한 융자, 국내기업(금융사 포함)의 현지법인 및 해외지사 투자, 외국정부·국제기구·외국금융기관에 대한 투자 시 차입신청인의 신용도 및 소속국가의 신용도, 대출기간 및 금융시장 등의 여건을 분석하여 투자 승인 및 융자금 관리를 한다. 외국환거래 계약의 체결과 환거래은행의 수익을 분석한다. 외화대출 자금배정을 승인·통지한다. 외화자금 관련 금리, 수수료율을 결정하고 환율결정을 고시한다. 국외신용평가 관련 업무를 담당한다. 외화자금 상황 보고를 수행하고 외화예치금을 관리한다. 국제회의에 참석하고 환거래은행 방문자를 면담하고 관리한다. 국제투자, 융자업무와 사후관리를 지도한다. 국외점포의 투자·융자에 대해 심사·승인한다. 외환딜링업무를 관리하고 외화자금 결제 및 이체업무를 지도한다. 외화계산과 결산업무를 처리한다. 국외점포의 신설·이전·폐쇄·경영지원 등을 총괄하고 평가한다. 외국인 투자자에 대한 서비스제공 등 관련 업무를 총괄한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","connectJob":"국제투자기획원","dJobECd":"0124","dJobECdNm":"[0124]금융·보험 관리자","dJobJCd":"1320","dJobJCdNm":"[1320]보험 및 금융 관리자","dJobICd":"K641","dJobICdNm":"[K641]은행 및 저축기관","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002947:1', '{"dJobCd":"K000002947","dJobCdSeq":"1","dJobNm":"금융기관지역사업부장","workSum":"지역사업부 관할 내의 금융지점 및 영업점의 업무를 총괄 관리한다.","doWork":"금융기관(일반은행, 특수은행, 비은행예금취급기관, 보험사, 증권사, 카드사 등)의 각 지역별 영업 및 판매실적을 분석하고 상품별 통계치와 실적을 관리한다. 영업망별 목표와 예산을 배분한다. 영업부문 회의를 주관한다. 지역영업점의 영업방침, 개선사항을 계획하고 수정한다. 영업망의 제휴 관련 업무를 지원하고 영업망별 판촉계획을 수립·추진한다. 포상 등 영업촉진제도를 개발하고, 우수 지점 및 영업점에 대해서는 인센티브(성과금)를 부여하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0124","dJobECdNm":"[0124]금융·보험 관리자","dJobJCd":"1320","dJobJCdNm":"[1320]보험 및 금융 관리자","dJobICd":"K641","dJobICdNm":"[K641]은행 및 저축기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006437:1', '{"dJobCd":"K000006437","dJobCdSeq":"1","dJobNm":"금융기관지점관리자","workSum":"지점의 영업활동을 책임지고 대외활동 계획수립 및 이행사항을 점검하며 종업원들의 활동을 지휘·감독한다.","doWork":"각 지점의 예금영업 및 대출영업 등의 영업운영방침 및 예금, 대출업무계획을 수립한다. 고객응대서비스를 개발하며 세부실천계획 수립 및 이행상황을 점검한다. 주식거래 및 투신거래에 관하여 고객과 상담하여 결과를 분석한다. 직원 근태상황관리 및 직원 신상문제를 상담하고 직원 실무연수를 주관한다. 지점의 예금수탁율과 여신율의 실적을 증대시키기 위하여 여러 가지 영업전략 및 서비스를 개발하여 실행한다. 직원의 기술적 업무와 고객대응서비스 업무에 대한 조언 및 교육을 한다. 영업점 업무에 대하여 지도, 감독한다. 대내외 감사에 대한 책임을 진다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","similarNm":"금융기관지점장","dJobECd":"0124","dJobECdNm":"[0124]금융·보험 관리자","dJobJCd":"1320","dJobJCdNm":"[1320]보험 및 금융 관리자","dJobICd":"K641","dJobICdNm":"[K641]은행 및 저축기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002235:1', '{"dJobCd":"K000002235","dJobCdSeq":"1","dJobNm":"금융위험관리관리자","workSum":"금융회사의 이익을 보전하고 손실을 방지하기 위해 금융위험 관리계획을 세우고 위험관리업무에 종사하는 종업원들의 활동을 지휘·감독한다.","doWork":"금융회사 전체의 금융위험을 관리하기 위해 금융위험을 측정하여 대처계획을 세우고 각 분야의 업무를 조정하고 통제한다. 시장위험, 신용위험, 운영위험 등의 위험관리를 위하여 위험관리시스템을 구축하고, 관련 사무원들을 교육하여 향후 발생할 수 있는 위험을 검토하여 방안을 강구토록 지시한다. 투자대상별 리스크(Risk)를 분석한다. 리스크 허용한도의 결정 및 점검, 리스크 계량화 방안수립, 리스크 관리규정 준수여부 및 점검, 리스크 관련 정기보고 등을 통하여 금융위험관리를 수행한다. 부실채권에 대한 회수업무를 총괄 관리하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","similarNm":"금융리스크관리관리자","dJobECd":"0124","dJobECdNm":"[0124]금융·보험 관리자","dJobJCd":"1320","dJobJCdNm":"[1320]보험 및 금융 관리자","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007471:1', '{"dJobCd":"K000007471","dJobCdSeq":"1","dJobNm":"보험관리자","workSum":"회사의 보험정책에 따라 보험인수 시 위험정도 평가와 청약서 검토를 통해 청약을 수락·거절하며, 보험금 지급계획을 수립하고 종업원들을 지휘·감독한다.","doWork":"보험청약자의 재정적 지위, 나이, 직업, 재산, 부동산의 가치와 상태 등을 기초로 청약자의 위험정도를 판단한다. 보험청약서, 조사보고서, 건강진단서 등의 서류를 검토한다. 보험가입 시 회사의 부담위험이 큰 개인 또는 단체의 보유보험계약액을 확인하여 회사부담위험의 정도가 지나치게 과다한 계약인지를 판단한다. 연간운영계획을 수립하고 기관별 보험상품 판매실적을 월간·연간으로 분석·평가한다. 분석한 실적결과에 따라 대책을 수립하고 시행한다. 보험금 지급계획을 수립하여 지급업무와 관련된 지시사항에 대하여 조치와 보고를 한다. 보험시장에 대한 정보를 수집하고 보험상품을 홍보한다. 직원을 관리하고 타 보험사업자, 의료기관 등과 교섭한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","dJobECd":"0124","dJobECdNm":"[0124]금융·보험 관리자","dJobJCd":"1320","dJobJCdNm":"[1320]보험 및 금융 관리자","dJobICd":"K651","dJobICdNm":"[K651]보험업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002002:1', '{"dJobCd":"K000002002","dJobCdSeq":"1","dJobNm":"보험대리점소장","workSum":"회사의 영업정책에 따라 영업점의 영업활동을 책임지고, 보험모집인의 활동을 지휘·감독한다.","doWork":"회사의 영업정책에 따라 영업점의 운영방침 및 업무계획을 수립한다. 연간·월간계획을 수립한다. 보험모집인의 영업활동을 지휘·감독한다. 보험모집인이 제출한 청약서를 검토하여 청약을 수락·거절한다. 보험가입 시 회사의 부담위험이 큰 계약인지를 확인한다. 보험상품의 판매실적을 분석·평가하며, 실적에 따라 대책을 수립·시행한다. 보험금 지급계획을 수립하여 지급업무에 관한 지시사항을 조치하고, 회사에 보고한다. 보험시장에 관한 정보를 수집한다. 고객을 유지·관리한다. 신입사원을 채용하고 교육한다. 보험모집인의 근태 상황을 관리하고, 신상 문제를 상담한다. 대내·외 감사에 대한 책임을 진다. 고액 보험가입대상자를 선정하여 직접 방문 후 보험상품을 설명하고, 고객의 건강상태, 생활수준, 미래계획 등을 파악하여 적합한 상품을 권유한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","similarNm":"보험대리점사장","certLic":"보험중개사","dJobECd":"0124","dJobECdNm":"[0124]금융·보험 관리자","dJobJCd":"1320","dJobJCdNm":"[1320]보험 및 금융 관리자","dJobICd":"K651","dJobICdNm":"[K651]보험업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007138:1', '{"dJobCd":"K000007138","dJobCdSeq":"1","dJobNm":"선물옵션거래관리자","workSum":"국내외 선물시장에서 선물거래와 관련 업무를 수행하는 종업원들의 활동을 지휘·감독한다.","doWork":"선물회사 또는 선물거래 관련 부서의 운영방침 및 업무계획을 수립하고 이행상황을 점검한다. 선물거래에 관하여 고객과 상담하여 결과를 분석한다. 직원 근무상황 관리 및 직원 신상문제를 상담하고 직원 실무연수를 주관한다. 선물거래중개인의 업무에 대하여 지도·감독하며 대내외 감사에 대한 책임을 진다. 고객들을 대상으로 선물거래에 대한 교육을 주관하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","similarNm":"파생상품거래관리자","dJobECd":"0124","dJobECdNm":"[0124]금융·보험 관리자","dJobJCd":"1320","dJobJCdNm":"[1320]보험 및 금융 관리자","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003589:1', '{"dJobCd":"K000003589","dJobCdSeq":"1","dJobNm":"신용조사관리자","workSum":"법인사업자와 개인사업자가 상거래에 필요한 개인이나 기업의 금융자산에 대한 신용도조사를 계획하고 조사실시를 지시하며 조사결과를 종합 검토한다.","doWork":"고객으로부터 특정 법인이나 개인의 신용도조사 의뢰서를 접수하고 조사의 목적과 특징을 협의한다. 조사대상업체나 개인사업자의 업무성격에 따라 조사소요기간, 조사방법, 자료활용방법 등을 결정한다. 신용도조사의 대상 등 사안에 따라 담당자를 선정한다. 신용조사분석원에게 조사할 내용을 설명하고 조사방법을 지시한다. 조사된 내용을 검토하여 신용의 객관성과 엄밀성을 유지한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0124","dJobECdNm":"[0124]금융·보험 관리자","dJobJCd":"1320","dJobJCdNm":"[1320]보험 및 금융 관리자","dJobICd":"N759","dJobICdNm":"[N759]기타 사업지원 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004374:1', '{"dJobCd":"K000004374","dJobCdSeq":"1","dJobNm":"신용평가관리자","workSum":"투자자에게 투자대상 기업에 대한 재정적 상태를 등급으로 표시하는 기업평가업무를 총괄 관리한다.","doWork":"등급평정 대상업체의 자료제출을 요구하고 그 자료를 분석한다. 현지방문을 하여 경영자를 면담하고 정밀분석 후 보고서를 작성한다. 등급심의 회의에 회부토록 하여 등급결정 및 공시업무 전반을 지시·관장한다. 기업 신용평가업무에 필요한 인원 및 적임자를 선정한다. 신용평가분석원에게 조사할 내용을 설명하고 조사방법을 지시한다. 조사된 내용을 검토하여 해당 기업의 재정적 상태를 적절히 평정토록 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0124","dJobECdNm":"[0124]금융·보험 관리자","dJobJCd":"1320","dJobJCdNm":"[1320]보험 및 금융 관리자","dJobICd":"N759","dJobICdNm":"[N759]기타 사업지원 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004345:1', '{"dJobCd":"K000004345","dJobCdSeq":"1","dJobNm":"신탁사무관리자","workSum":"신탁업무를 기획·운용하고 총괄 관리한다.","doWork":"금융, 부동산 등 자산 관련 신탁상품(증권, 채권, 부동산 등)에 대한 정보와 자료를 수집한다. 금융시장 및 부동산시장의 동향을 분석한다. 신탁보수 및 환매수수료를 산정하고 기획한다. 신탁 마케팅전략을 수립하고 추진한다. 상품 및 섭외서비스 개발, 신탁 여·수신 평가서비스 개발, 신탁고객 불만사항 등을 관리한다. 신탁자산운용계획을 수립·운용한다. 자산운용사 및 운용자산을 선정하고 관리한다. 신탁수익률을 관리하고 신탁계정 회계 및 결산업무를 지도한다. 신탁재산의 사후관리와 신탁계정 위험관리 업무를 담당한다. 실물자산, 증권, 채권, 부동산투자신탁상품 관련 업무를 기획·운영한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","dJobECd":"0124","dJobECdNm":"[0124]금융·보험 관리자","dJobJCd":"1320","dJobJCdNm":"[1320]보험 및 금융 관리자","dJobICd":"K642","dJobICdNm":"[K642]신탁업 및 집합투자업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002112:1', '{"dJobCd":"K000002112","dJobCdSeq":"1","dJobNm":"여신사무관리자","workSum":"고객의 요구에 부합하는 안정적인 대출과 자산운용·관리의 총괄업무를 수행한다.","doWork":"개인신용, 담보물건, 기업대출을 위한 신청자들을 면담하고 여신상품 및 서비스에 대해 고객과 상담하며 대출약관에 대해 설명한다. 여신상품, 여신서비스 여신한도 결정 및 여신금리 운영업무를 담당한다. 여신상품 관련 신용평가 및 담보평가시스템을 운용한다. 개인여신 및 기업을 대상으로 정책자금 대출 업무를 총괄한다. 여신제도 및 업무절차를 개선하고 규정을 관리한다. 신영업점 관련 대출 업무절차를 관리하고 모니터링한다. 인터넷을 통한 여신판매를 지원한다. 신용등급별 포트폴리오 전략수립 및 한도관리업무를 지도한다. 할부채권(할부보증채권) 인수 및 관련 기관 섭외를 관리한다. 집단대출 영업점의 지원업무를 기획하고 추진한다. 타 기관의 여신 관련 법규와 규정을 비교·분석한다. 신용 및 대출서비스 판매를 촉진한다. 법인회사, 상업 및 개인대출계좌를 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","dJobECd":"0124","dJobECdNm":"[0124]금융·보험 관리자","dJobJCd":"1320","dJobJCdNm":"[1320]보험 및 금융 관리자","dJobICd":"K641","dJobICdNm":"[K641]은행 및 저축기관","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006336:1', '{"dJobCd":"K000006336","dJobCdSeq":"1","dJobNm":"증권거래소관리자","workSum":"상장기업들의 증권매매를 성립시켜주는 증권거래소 종사원들의 활동을 지휘·감독한다.","doWork":"기업의 상장이나 등록신청을 받아 상장기업으로 등록하고 증권의 공모를 주선한다. 공정한 매매를 위하여 악성풍문 또는 이상매매에 대한 원인을 파악하여 공시한다. 투자자에게 투자기회를 부여하기 위하여 담당직원에게 시세 게시판 운영을 지시한다. 주식, 채권, 주가지수선물과 주가지수옵션, 상장지수펀드(ETF) 등의 유가증권 상장 및 심사, 매매체결 및 매매결과의 처리, 기업내용 공시, 주가감시 및 감리 등을 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","dJobECd":"0124","dJobECdNm":"[0124]금융·보험 관리자","dJobJCd":"1320","dJobJCdNm":"[1320]보험 및 금융 관리자","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002320:1', '{"dJobCd":"K000002320","dJobCdSeq":"1","dJobNm":"증권회사심사관리자","workSum":"기업체 지급보증심사 및 유가증권분석업무에 종사하는 종업원들의 활동을 지휘·감독한다.","doWork":"지급보증업체 및 신종기업어음 적격업체에 대한 동향을 조사한다. 지급보증업체 및 사채모집 수탁업체에 대한 사후관리를 지시한다. 채권관리 및 회수를 위한 기초지식을 종사원에게 교육하고 유가증권 분석을 위한 일반지식을 숙지시킨다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","dJobECd":"0124","dJobECdNm":"[0124]금융·보험 관리자","dJobJCd":"1320","dJobJCdNm":"[1320]보험 및 금융 관리자","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001282:1', '{"dJobCd":"K000001282","dJobCdSeq":"1","dJobNm":"채권추심관리자","workSum":"채권추심업무를 위임받아 채권추심업무를 관장하고 채권추심원들을 관리·감독한다.","doWork":"채권추심원에게 추심업무를 배정한다. 추심에 관련된 신용조사 등 채권추심업무를 진행하도록 지시한다. 추심과 관련하여 감면범위, 감면기준, 상환기간 등의 적절성과 타당성 등을 검토하여 결정한다. 상환약정업무 체결을 관리하고 감독한다. 채권추심원의 성과 및 목표를 관리한다. 기타 관리자로서 업무를 수행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","dJobECd":"0124","dJobECdNm":"[0124]금융·보험 관리자","dJobJCd":"1320","dJobJCdNm":"[1320]보험 및 금융 관리자","dJobICd":"K649","dJobICdNm":"[K649]기타 금융업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003292:1', '{"dJobCd":"K000003292","dJobCdSeq":"1","dJobNm":"카드사무관리자","workSum":"신용카드 상품의 전략개발, 가맹점 관리 및 대금정산, 회원심사 및 채권관리 등 카드업무를 총괄 관리한다.","doWork":"목표이익을 수립하여 관리한다. 신용카드 상품의 전략개발, 제도개선 및 규정, 금리·수수료 관련 업무를 관리한다. 신용카드시스템 구축과 가맹점을 관리한다. 카드이용대금 결제 및 신용카드 신용평점모형 운영업무를 총괄한다. 부정사용방지시스템 운영과 신용카드 사후관리업무, 신용카드 연체 채권업무를 지도한다. 신용카드 부실채권 관련 경매소송을 관리한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0124","dJobECdNm":"[0124]금융·보험 관리자","dJobJCd":"1320","dJobJCdNm":"[1320]보험 및 금융 관리자","dJobICd":"K649","dJobICdNm":"[K649]기타 금융업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004940:1', '{"dJobCd":"K000004940","dJobCdSeq":"1","dJobNm":"파생상품거래관리자","workSum":"국내외 선물, 옵션 등의 파생상품 매매를 총괄 관리하고, 종사원들의 활동을 지도·감독한다.","doWork":"선물회사 또는 증권사의 파생상품운용부서의 운영방침 및 업무계획을 수립한다. 세부실천계획을 수립하고 실행할 사항을 점검한다. 파생상품자산운용가의 업무를 지도·감독한다. 매매결과를 분석한다. 직원의 근무상황을 관리하고 실무연수를 주관한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"단순작업","similarNm":"선물옵션거래관리자","dJobECd":"0124","dJobECdNm":"[0124]금융·보험 관리자","dJobJCd":"1320","dJobJCdNm":"[1320]보험 및 금융 관리자","dJobICd":"K661","dJobICdNm":"[K661]금융 지원 서비스업","inqYear":"2012"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004094:1', '{"dJobCd":"K000004094","dJobCdSeq":"1","dJobNm":"간호부장","workSum":"환자들에게 양질의 간호를 제공하기 위하여 간호업무 전반을 기획·감독·조정한다.","doWork":"간호부서의 업무를 통괄하여 관리하고 병원관리자를 보좌하여 병원 운영에 참여한다. 간호부서의 예산을 편성·집행한다. 간호업무에 필요한 시설, 비품 및 물자의 사용기준량을 책정하고 관리체계를 정립한다. 병원의 간호활동 목표 및 방침을 직원들에게 교육한다. 환자간호에 필요한 서류양식, 보고서 등의 기록방법과 제출절차를 제도화한다. 간호학생의 임상교육방침을 학교측과 협의·결정하기도 한다. 간호와 관련된 각종 지역사회건강사업 및 의료봉사활동에 참여하기 위해 계획하고 시행을 지시하기도 한다. 간호사업과 관련하여 전문단체의 자문에 응하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","certLic":"간호사","dJobECd":"0134","dJobECdNm":"[0134]보건·의료 관리자","dJobJCd":"1331","dJobJCdNm":"[1331]보건 의료 관련 관리자","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007133:1', '{"dJobCd":"K000007133","dJobCdSeq":"1","dJobNm":"병원관리자","workSum":"병원의 전반적인 운영 및 경영 활동을 관리·감독한다.","doWork":"의학적 연구 및 예방활동 또는 사회의 건강과 복지 등에 관한 서비스와 프로그램을 개발하고 확산하는 제반 활동을 조정한다. 예산 및 회계업무를 관리한다. 보험진료비 청구 내역을 검토하고 승인한다. 직원의 고용과 교육을 관장한다. 병원 건물과 시설물을 개선·확장하기 위하여 관계 직원 또는 단체들과 협의한다. 의사, 간호사, 관리직원들의 의료활동을 감독·조정한다. 각종 병원업무의 처리절차와 정책을 개발한다. 병원의 마케팅 및 홍보업무를 주관한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","connectJob":"병원장, 병원사무장","dJobECd":"0134","dJobECdNm":"[0134]보건·의료 관리자","dJobJCd":"1331","dJobJCdNm":"[1331]보건 의료 관련 관리자","dJobICd":"Q861","dJobICdNm":"[Q861]병원","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006258:1', '{"dJobCd":"K000006258","dJobCdSeq":"1","dJobNm":"보건소장","workSum":"보건소의 행정·사무를 총괄하고 소속 직원을 지휘·감독한다.","doWork":"법률로 정해진 보건소의 업무인 국민건강증진·보건교육·구강건강 및 영양관리사업, 감염병의 예방·관리 및 진료, 모자보건 및 가족계획사업, 노인보건사업, 공중위생 및 식품위생, 의료인 및 의료기관에 대한 지도 등에 관한 사항, 의료기사·의무기록사 및 안경사에 대한 지도 등에 관한 사항, 응급의료에 관한 사항, 공중보건의사·보건진료원 및 보건진료소에 대한 지도 등에 관한 사항, 약사에 관한 사항, 마약·향정신성의약품의 관리에 관한 사항, 정신보건에 관한 사항, 가정·사회복지시설 등을 방문하여 행하는 보건의료사업, 지역주민에 대한 진료·건강진단 및 만성퇴행성질환 등의 질병관리에 관한 사항, 보건에 관한 실험 또는 검사에 관한 사항, 장애인의 재활사업 등 사회복지사업, 기타 지역주민의 보건의료의 향상·증진에 관한 사업을 시행하고 관장한다. 보건 관련 연구를 하기도 한다. 보건소 소속 직원을 지휘·감독한다.","optionJobInfo":{"eduLevel":"16년 초과(대학원 이상)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","certLic":"의사, 간호사, 약사","dJobECd":"0134","dJobECdNm":"[0134]보건·의료 관리자","dJobJCd":"1331","dJobJCdNm":"[1331]보건 의료 관련 관리자","dJobICd":"Q863","dJobICdNm":"[Q863]공중 보건 의료업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006440:1', '{"dJobCd":"K000006440","dJobCdSeq":"1","dJobNm":"헌혈권장관리자","workSum":"가두헌혈권장원의 활동을 관리·감독한다.","doWork":"헌혈권장원을 선발하여 교육한다. 헌혈권장 관련 보고서를 검토·분석하고 문제점을 해결한다. 혈액원의 기구, 직능, 운영현황 및 업무절차 등을 헌혈권장원에게 설명하여 헌혈권장활동에 활용하도록 한다. 헌혈자 및 헌혈단체와 혈액원 간의 연락업무를 관장한다. 혈액원의 기능과 업무를 홍보한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"분석","workFunc2":"교육","workFunc3":"관련없음","similarNm":"헌혈홍보관리자","dJobECd":"0134","dJobECdNm":"[0134]보건·의료 관리자","dJobJCd":"1331","dJobJCdNm":"[1331]보건 의료 관련 관리자","dJobICd":"Q869","dJobICdNm":"[Q869]기타 보건업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006918:1', '{"dJobCd":"K000006918","dJobCdSeq":"1","dJobNm":"보육시설원장","workSum":"어린이집, 놀이방 등 보육시설을 운영하고 관리한다.","doWork":"영유아의 연령에 따른 일간, 주간, 월간 보육계획을 수립한다. 보육계획에 따라 실시 여부를 관리하고 감독한다. 보육교사, 영양사 등 관련 종사원의 인사, 교육 등을 관리하고 감독한다. 보육일지 작성을 지시한다. 화재 등 긴급사태에 대비한 계획을 수립하고 정기적인 점검 및 훈련을 실시한다. 조리실, 화장실, 침구 등에 대한 정기적인 소독을 실시하고, 음식물을 관리하는 등 영유아의 건강을 관리한다. 보육교사의 업무를 병행하기도 한다.","optionJobInfo":{"eduLevel":"12년 초과 ~ 14년 이하(전문대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"언어력|","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","certLic":"보육교사","dJobECd":"0135","dJobECdNm":"[0135]사회복지 관리자","dJobJCd":"1332","dJobJCdNm":"[1332]사회복지 관련 관리자","dJobICd":"Q872","dJobICdNm":"[Q872]비거주 복지시설 운영업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005501:1', '{"dJobCd":"K000005501","dJobCdSeq":"1","dJobNm":"사회복지시설관리자","workSum":"노인복지시설을 포함한 사회복지시설의 업무를 책임지고 재정, 인사 등을 관리·감독한다.","doWork":"영아원, 육아원, 아동입양위탁시설, 모자보호시설, 갱생원, 양로원, 재활원, 요양시설 등 각종 사회복지시설에서 인사·재정을 관리·감독한다. 사회복지활동을 기획·지휘·조정한다. 수용된 영아, 고아, 노인, 미혼모, 장애자 등에 대한 일반교육, 생활 및 기술지도, 건강관리 등 제반 보호업무를 관장한다. 수용자의 입·퇴실 상황 판별 및 조치, 취업알선, 입양, 위탁보호지도 및 발육경과 등에 대한 각종 일지와 장부를 관리하고 관할 행정기관에 보고한다. 수용자의 보호자와 긴밀한 유대관계를 갖고 보호의 경과를 알려주며 상담에 응하거나 이해를 촉구한다. 관계행정기관, 사회사업단체 및 기타 지역사회단체가 주관·주최하는 관계회의에 참석하여 의견을 교환하고 이해와 협조를 요청한다. 후원자 개발을 위해 지역주민 및 유지를 만나 복지사업에 관하여 설명한다. 소년·소녀가장, 독거노인, 장애자 등에게 장학금 및 생활비를 전달한다. 노인의료복지시설이나 재가노인복지시설의 요양보호사나 사회복지사의 업무를 관리·감독한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","connectJob":"양로원장, 영아원장, 육아원장, 재활원장, 아동사회복지시설관리자, 여성사회복지시설관리자, 장애인사회복지시설관리자, 일반사회복지시설관리자, 저소득사회복지시설관리자, 노숙인사회복지시설관리자, 청소년사회복지시설관리자, 노인복지시설관리자 (노인주거복지시설관리자, 노인의료복지시설관리자, 노인여가복지시설관리자, 재가노인복지시설관리자, 노인보호전문기관관리자), 노인재가복지센터장 등","certLic":"사회복지사 1급, 사회복지사 2급","dJobECd":"0135","dJobECdNm":"[0135]사회복지 관리자","dJobJCd":"1332","dJobJCdNm":"[1332]사회복지 관련 관리자","dJobICd":"Q871/Q872","dJobICdNm":"[Q871]거주 복지시설 운영업 / [Q872]비거주 복지시설 운영업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007292:1', '{"dJobCd":"K000007292","dJobCdSeq":"1","dJobNm":"사회사업단체임원","workSum":"사회사업단체의 이사장 또는 임원으로서 단체의 설립 취지에 따라 각종 사회복지사업을 운영·총괄하고, 소속 직원을 지도·감독한다.","doWork":"사회복지사업단체의 이사장, 단장, 대표자 등의 임원으로서 부하직원을 지도·감독한다. 양로원, 구호소, 모자원, 생활보조를 하는 사업, 경제보호를 하는 사회사업 등 사회복지를 목적으로 하는 사업 또는 이들 사업에 관한 지도, 연락, 조성 등의 업무를 운영·총괄한다. 사회사업을 위한 운영자금을 조달 집행한다. 단체 내 소관 관공서 회의에 출석하고 의견을 교환하고 사업의 원활한 운영에 이바지한다. 직원의 인사 및 운영비 등을 관장한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","dJobECd":"0135","dJobECdNm":"[0135]사회복지 관리자","dJobJCd":"1332","dJobJCdNm":"[1332]사회복지 관련 관리자","dJobICd":"S949","dJobICdNm":"[S949]기타 협회 및 단체","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006853:1', '{"dJobCd":"K000006853","dJobCdSeq":"1","dJobNm":"과학관관리자","workSum":"신개발품, 연구결과 등을 전시하는 과학관에 종사하는 작업원들의 활동을 감독·조정한다.","doWork":"과학관에 전시되어 있는 각종 제품의 목록 및 설비 등을 점검한다. 신제품 및 연구결과의 전시계획을 기획·조정한다. 시설물 및 전시품 관리, 회계, 개발, 전시, 교육 등에 종사하는 작업원들의 활동을 감독한다. 연구·개발된 각종 제품이나 설비의 과학적인 가치를 평가하는 활동을 감독한다. 대외적인 회의에서 과학관을 대표하여 의견을 제시한다. 각종 과학교육 및 과학 관련 행사를 기획하고 홍보하여 행사를 진행한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","similarNm":"과학관장","dJobECd":"0136","dJobECdNm":"[0136]예술·디자인·방송 관리자","dJobJCd":"1340","dJobJCdNm":"[1340]문화·예술 관련 관리자","dJobICd":"R902","dJobICdNm":"[R902]도서관, 사적지 및 유사 여가관련 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005077:1', '{"dJobCd":"K000005077","dJobCdSeq":"1","dJobNm":"극장관리자","workSum":"극장이나 영화관에서 영화상영, 예매, 마케팅, 매점 등을 운영 및 관리하고 종사원들의 활동을 관리·감독한다.","doWork":"극장이나 영화관을 효율적으로 운영하기 위하여 영화상영, 온·오프라인 예매, 극장시설의 유지·보수, 마케팅, 대관, 매점, 회계, 소방·안전·안내 업무를 수행하는 종사원들의 활동을 관리·감독한다. 고객의 불만사항을 접수하여 담당자들에게 통보하고 개선하도록 지시한다. 영화제작자와 영화 상영기간을 협의하고, 영화관 체인의 경우에는 본사의 지시에 따라 영화 상영계획을 수립한다. 제휴사와 공동으로 각종 할인권, 초대권, 카드할인 등의 마케팅을 하기도 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","similarNm":"극장지배인","dJobECd":"0136","dJobECdNm":"[0136]예술·디자인·방송 관리자","dJobJCd":"1340","dJobJCdNm":"[1340]문화·예술 관련 관리자","dJobICd":"R901","dJobICdNm":"[R901]창작 및 예술관련 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004025:1', '{"dJobCd":"K000004025","dJobCdSeq":"1","dJobNm":"도서관관리자","workSum":"도서관의 장서 및 인력과 시설을 관리하며 운영계획을 수립·관리한다.","doWork":"관련 부서의 추정예산을 분석·조정한다. 승인된 예산을 집행하기 위한 경비를 통제·관리한다. 고서, 연속간행물, 비도서자료 등의 장서개발계획을 검토하고 실행한다. 각종 비품 및 시설을 관리·감독한다. 인사규정을 관장하며 직원의 근무평정을 한다. 도서관의 홍보를 계획하고 추진한다. 자료의 전산화계획을 관리·감독한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"도서관장","dJobECd":"0136","dJobECdNm":"[0136]예술·디자인·방송 관리자","dJobJCd":"1340","dJobJCdNm":"[1340]문화·예술 관련 관리자","dJobICd":"R902","dJobICdNm":"[R902]도서관, 사적지 및 유사 여가관련 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001424:1', '{"dJobCd":"K000001424","dJobCdSeq":"1","dJobNm":"동물원관리자","workSum":"동물원을 운영하는 데 종사하는 작업원들의 활동을 감독·조정한다.","doWork":"동물원에서 사육하는 동물의 종류 및 수량을 점검한다. 동물원 운영계획에 따라 동물 반입계획 및 종류를 검토한다. 동물원의 관리방침을 설정하고 동물의 사육과 관람에 관한 운영계획을 수립한다. 동물을 사육하고 일반 관중에게 서비스를 제공하는 작업원들의 활동을 조정한다. 야생에서 멸종 위기에 있는 동물들을 일시적으로 수용하여 사육, 번식시키는 보존 및 연구에 종사하는 작업원들의 활동을 관리·감독한다. 희귀동물과 관련된 국내외 자료를 수집·분석한다. 동물의 성장, 번식, 사육 등에 관한 조사·연구활동을 수행하기도 한다. 동물의 수입이나 교환을 위하여 관련 기관과 협의한다. 예산을 편성, 관리, 집행하는 데 종사하는 작업원들의 활동을 감독한다. 대외적인 회의에서 기관을 대표하여 의견을 제시한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"동물원장","dJobECd":"0136","dJobECdNm":"[0136]예술·디자인·방송 관리자","dJobJCd":"1340","dJobJCdNm":"[1340]문화·예술 관련 관리자","dJobICd":"R902","dJobICdNm":"[R902]도서관, 사적지 및 유사 여가관련 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002937:1', '{"dJobCd":"K000002937","dJobCdSeq":"1","dJobNm":"디자인부서관리자","workSum":"디자인 전략을 기획하고 디자이너 및 부서 직원들을 관리·감독한다.","doWork":"시장상황을 조사한다. 경영진, 마케팅부서, 제조부서, 개발부서 등과 협의하여 디자인 전략을 수립한다. 생산성, 경쟁력, 품질, 원가 등에 대해 관련 부서와 협력하여 디자인 결과물을 수정·보완한다. 디자인부서에서 종사하는 디자이너들의 업무계획을 수립하고 지휘·감독한다. 그래픽디자인, 제품디자인, 패션디자인 등의 각종 분야에서 전문성을 가지고 활동한다. 기존 제품과 신제품 관련하여 온/오프라인에 따른 콘텐츠 제작에 관하여 총괄한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","certLic":"제품디자인기술사, 제품디자인기사, 제품디자인산업기사","dJobECd":"0136","dJobECdNm":"[0136]예술·디자인·방송 관리자","dJobJCd":"1340","dJobJCdNm":"[1340]문화·예술 관련 관리자","dJobICd":"M732","dJobICdNm":"[M732]전문 디자인업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006169:1', '{"dJobCd":"K000006169","dJobCdSeq":"1","dJobNm":"미술관관리자","workSum":"한국화, 서양화, 판화, 조각, 공예, 설치미술 등의 미술작품을 전시하는 미술관의 운영을 총괄하고, 관련 종사원들의 활동을 지휘·감독한다.","doWork":"미술관에 보관된 한국화, 서양화, 판화, 조각, 공예, 설치미술 등 미술작품의 수량 및 종류를 점검하고 전시계획을 조정한다. 대여하거나 대출된 미술작품의 종류와 수량을 확인한다. 관리, 회계, 조사 등에 종사하는 작업원들의 활동을 감독한다. 예산을 편성·관리한다. 대외적인 회의에서 기관을 대표하여 의견을 제시한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"미술관장","connectJob":"화랑디렉터(갤러리운영자, 갤러리스트), 미술품경매관리자, 아트페어관리자","dJobECd":"0136","dJobECdNm":"[0136]예술·디자인·방송 관리자","dJobJCd":"1340","dJobJCdNm":"[1340]문화·예술 관련 관리자","dJobICd":"R902","dJobICdNm":"[R902]도서관, 사적지 및 유사 여가관련 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002733:1', '{"dJobCd":"K000002733","dJobCdSeq":"1","dJobNm":"박물관관리자","workSum":"각종 국가유산을 발굴·복원·전시하는 박물관의 운영을 총괄하고, 관련 종사원들의 활동을 지휘·감독한다.","doWork":"박물관에 보관된 국가유산의 종류 및 수량을 점검하고 전시계획을 조정한다. 국내외 전시관에 대여하거나 대출된 국가유산의 종류와 수량을 확인한다. 관리, 회계, 복원, 조사 등에 종사하는 작업원들의 활동을 감독한다. 예산편성을 관리한다. 대외적인 회의에서 기관을 대표하여 의견을 제시한다. 문헌, 역사자료 등을 검토하고 국가유산연구원 및 대학 등 유관기관과 협의하여 유적의 발굴계획을 수립·조정한다. 발굴현장을 탐사하여 발굴방법 및 절차에 관련된 의견을 협의하고 발굴유물에 대한 역사적인 가치를 평가한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"박물관장","dJobECd":"0136","dJobECdNm":"[0136]예술·디자인·방송 관리자","dJobJCd":"1340","dJobJCdNm":"[1340]문화·예술 관련 관리자","dJobICd":"R902","dJobICdNm":"[R902]도서관, 사적지 및 유사 여가관련 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003878:1', '{"dJobCd":"K000003878","dJobCdSeq":"1","dJobNm":"방송심의위원","workSum":"라디오와 텔레비전의 방송내용, 대본 또는 편집이 완료된 드라마 등을 심의·평가한다.","doWork":"방송심의규정에 따라 민주질서 유지, 건전한 가정생활, 아동 및 청소년 보호, 공중도덕 및 사회윤리, 양성평등, 국제적 우의 증진, 소외계층의 권익증진, 민족문화 창달, 보도 및 논평의 공정성·공공성, 언어순화, 시정 및 제재조치 등을 심의하기 위해 방송대본이나 편집 완료된 드라마, 광고 등을 비교·검토한다. 방송규정에 위배되는 사항을 삭제·변경·수정하도록 관련 부서에 통보한다. 아동과 청소년을 보호하기 위하여 시청 연령 등급을 분류한다. 방송통신 환경 및 관련 법제도 변화에 따른 관련 심의 규정 및 기준 등 제·개정한다. 명예훼손분쟁조정 및 이용자에게 정보를 제공하고, 피해 상담을 한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","physicalAct":"시각|","workFunc1":"분석","workFunc2":"협의","workFunc3":"관련없음","connectJob":"심의하는 방송매체의 종류에 따라 라디오방송심의위원, 텔레비전방송심의위원, 심의하는 대상의 종류에 따라 시청자불만심의위원, 영화심의위원, 광고심의위원","dJobECd":"0136","dJobECdNm":"[0136]예술·디자인·방송 관리자","dJobJCd":"1340","dJobJCdNm":"[1340]문화·예술 관련 관리자","dJobICd":"O842","dJobICdNm":"[O842]사회 및 산업정책 행정","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001773:1', '{"dJobCd":"K000001773","dJobCdSeq":"1","dJobNm":"수족관관리자","workSum":"해수어, 담수어 등의 어류, 포유류, 양서류, 파충류 및 표본 등을 사육·전시하는 수족관의 운영을 총괄하고, 관련 종사원들의 활동을 감독·조정한다.","doWork":"수족관에서 사육되는 각종 어류, 포유류, 양서류, 파충류 및 표본의 종류 및 수량, 각종 여과장치들을 점검한다. 수족관 전시일정을 조정한다. 국내외의 희귀어류에 관련된 자료를 수집·분석한다. 어류의 반입을 관련 부서와 협의한다. 관리, 회계, 조사, 사육 등에 관련된 종업원들의 활동을 감독한다. 예산을 편성·관리한다. 대외적인 회의에서 기관을 대표하여 의견을 제시한다. 어류의 생태 및 수족관의 적응과정을 정리하여 관련 학회에 보고·발표한다. 어류의 생태 및 희귀어종을 연구·조사하기도 한다. 수족관 관람객을 위한 수족관 이벤트를 기획왎楮되磯","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"10년 초과","workStrong":"아주 가벼운 작업","workPlace":"실내","workFunc1":"조정","workFunc2":"협의","workFunc3":"관련없음","similarNm":"수족관장","dJobECd":"0136","dJobECdNm":"[0136]예술·디자인·방송 관리자","dJobJCd":"1340","dJobJCdNm":"[1340]문화·예술 관련 관리자","dJobICd":"R902","dJobICdNm":"[R902]도서관, 사적지 및 유사 여가관련 서비스업","inqYear":"2021"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;