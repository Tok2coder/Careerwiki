-- P1 배치2: 귀금속세공원, 금속가공장치조작원, 극작가
-- 참조번호 [N]이 없으므로 내용 필드 + _sources 동시 업데이트

-- 1) 귀금속 및 보석세공원
UPDATE jobs SET user_contributed_json = json_patch(user_contributed_json, '{
  "way": "공예고등학교 또는 전문대학·대학교의 금속공예과, 귀금속공예과, 주얼리디자인과에서 이론과 실기를 배울 수 있다.[1] 사설 보석세공학원이나 주얼리 직업전문학교(MJC보석직업전문학교, 한국보석학원 등)에서 실무 중심 교육도 가능하며, 특성화고인 한국주얼리고등학교 졸업 후 현장에 바로 진출하는 경로도 있다.[2]\n\n관련 국가자격으로 귀금속가공기능사·산업기사·기능장, 보석가공기능사, 보석감정사 등이 있으며, 취업이나 공방 창업 시 경쟁력을 높여준다.[3]\n\n주요 취업처는 주얼리 제조업체, 보석 가공 공장, 백화점·브랜드 주얼리 매장, 귀금속 수리·리폼 전문점이며, 숙련 후 1인 공방을 창업하는 경우도 많다.",
  "overviewSalary": {"sal": "하위 2,879만 원 / 중위 3,431만 원 / 상위 3,921만 원 (2023년 기준).[4]", "source": "워크넷 직업정보(2023)"},
  "overviewProspect": {"main": "향후 10년간 고용은 연평균 -0.6% 소폭 감소 전망이다.[5] 대량생산 캐스팅 중심에서 디자인 차별화·다품종소량생산으로 산업 구조가 변하면서, 고객 맞춤형 핸드메이드 기능인력에 대한 수요는 오히려 증가 추세다.[6] 주얼리를 문화상품·아트 피스로 여기는 트렌드와 온라인 커스텀 주문 시장 확대가 일자리 유지에 긍정적이다.", "source": "워크넷 직업정보(2023)"},
  "trivia": "세계 최고 경도를 가진 다이아몬드를 커팅할 수 있는 도구는 다이아몬드뿐이다.[7] 다이아몬드의 결정 방향(벽개면)을 정확히 파악해 그 방향으로만 절단할 수 있어, 숙련 세공사의 경험과 감각이 가장 중요한 공정 중 하나다. 귀금속가공기능사 자격시험은 매년 4회 시행되며, 필기와 실기(왁스 조각·세팅 작업)로 구성된다.[8]",
  "_sources": {
    "way": [
      {"id":1,"text":"커리어넷 직업백과 — 귀금속·보석세공원 진학 정보","url":"https://www.career.go.kr/cloud/w/job/view?seq=2078"},
      {"id":2,"text":"커리어넷 직업백과 — 귀금속·보석세공원 취업 경로","url":"https://www.career.go.kr/cloud/w/job/view?seq=2078"},
      {"id":3,"text":"Q-Net — 귀금속가공기능사 자격증 정보","url":"https://www.q-net.or.kr/crf005.do?id=crf00503&jmCd=7460"}
    ],
    "overviewSalary.sal": [
      {"id":4,"text":"워크넷 직업정보 — 귀금속 및 보석세공원 임금 통계","url":"https://www.work.go.kr/consltJobCarpa/srch/jobDic/jobDicSrchDtl.do?pageCode=002&jobInfoWantedAuthCd=3&jobDicSeq=2078&langCd=ko"}
    ],
    "overviewProspect.main": [
      {"id":5,"text":"워크넷 직업정보 — 귀금속 및 보석세공원 직업 전망","url":"https://www.work.go.kr/consltJobCarpa/srch/jobDic/jobDicSrchDtl.do?pageCode=002&jobInfoWantedAuthCd=3&jobDicSeq=2078&langCd=ko"},
      {"id":6,"text":"커리어넷 직업백과 — 귀금속·보석세공원 전망","url":"https://www.career.go.kr/cloud/w/job/view?seq=2078"}
    ],
    "trivia": [
      {"id":7,"text":"커리어넷 직업백과 — 귀금속·보석세공원 직업 특성","url":"https://www.career.go.kr/cloud/w/job/view?seq=2078"},
      {"id":8,"text":"Q-Net — 귀금속가공기능사 시험 일정 및 정보","url":"https://www.q-net.or.kr/crf005.do?id=crf00503&jmCd=7460"}
    ]
  }
}') WHERE id = '1765283291770112';

-- 2) 금속가공장치조작원
UPDATE jobs SET user_contributed_json = json_patch(user_contributed_json, '{
  "way": "고등학교 졸업 이상의 학력이면 입직이 가능하며, 전문대학의 금속재료공학과, 신소재학과, 기계공학과 등에 진학하여 전문 지식을 쌓으면 유리하다.[1]\n\n제철소·비철금속 제련소·금속 가공 공장 등에서 신입 조작원으로 입사한 뒤, 현장 OJT(직무교육)를 통해 설비 조작 기술을 습득하는 것이 일반적인 경로다.[2]\n\n관련 자격으로는 금속재료기사·산업기사, 금속재료기능사, 열처리기능사, 주조기능사 등이 있으며, 대기업 제철소(포스코, 현대제철 등)는 공채를 통해 채용하고, 중소 금속 가공업체는 수시 채용이 주를 이룬다.[3]",
  "overviewSalary": {"sal": "하위 3,336만 원 / 중위 4,003만 원 / 상위 5,176만 원 (2023년 기준).[4]", "source": "워크넷 직업정보(2023)"},
  "overviewProspect": {"main": "향후 10년간 고용은 현 수준 유지(연평균 +0.4%)로 전망된다.[5] 전기차 배터리에 필수적인 니켈·망간·리튬 등 비철금속 수요 확대, 3D 프린팅용 금속 분말 시장 성장 등이 긍정적이다.[6] 다만 스마트팩토리·자동화 설비 도입으로 단순 조작 인력은 줄어들고, 설비 모니터링·데이터 분석 능력을 갖춘 고숙련 인력 수요가 늘어나는 추세다.[7]", "source": "워크넷 직업정보(2023)"},
  "trivia": "한국 철강 생산량은 세계 6위(2023년 약 6,670만 톤)이며, 포스코 포항제철소는 단일 제철소 기준 세계 최대 규모(연산 약 2,100만 톤)다.[8] 제강 공정에서 전기로 1회 용해 시 약 1,600°C 이상의 고온이 필요하다.[9] 한국은 2023년 기준 조강 생산량 세계 6위(세계철강협회 집계)로, 포스코 단일 기업이 국내 생산량의 약 40%를 담당한다.[10]",
  "_sources": {
    "way": [
      {"id":1,"text":"커리어넷 직업백과 — 금속관련장치조작원 진학 정보","url":"https://www.career.go.kr/cloud/w/job/view?seq=2201"},
      {"id":2,"text":"워크넷 직업정보 — 금속가공장치조작원 취업 경로","url":"https://www.work.go.kr/consltJobCarpa/srch/jobDic/jobDicSrchDtl.do?pageCode=002&jobInfoWantedAuthCd=3&jobDicSeq=2201&langCd=ko"},
      {"id":3,"text":"Q-Net — 금속재료기사 자격증 정보","url":"https://www.q-net.or.kr/crf005.do?id=crf00503&jmCd=0862"}
    ],
    "overviewSalary.sal": [
      {"id":4,"text":"워크넷 직업정보 — 금속가공장치조작원 임금 통계","url":"https://www.work.go.kr/consltJobCarpa/srch/jobDic/jobDicSrchDtl.do?pageCode=002&jobInfoWantedAuthCd=3&jobDicSeq=2201&langCd=ko"}
    ],
    "overviewProspect.main": [
      {"id":5,"text":"워크넷 직업정보 — 금속가공장치조작원 직업 전망","url":"https://www.work.go.kr/consltJobCarpa/srch/jobDic/jobDicSrchDtl.do?pageCode=002&jobInfoWantedAuthCd=3&jobDicSeq=2201&langCd=ko"},
      {"id":6,"text":"커리어넷 직업백과 — 금속관련장치조작원 전망","url":"https://www.career.go.kr/cloud/w/job/view?seq=2201"},
      {"id":7,"text":"한국철강협회 — 스마트팩토리 도입 현황","url":"https://www.kosa.or.kr/"}
    ],
    "trivia": [
      {"id":8,"text":"세계철강협회(Worldsteel) — 2023 철강 통계 연보","url":"https://worldsteel.org/steel-topics/statistics/world-steel-in-figures/"},
      {"id":9,"text":"커리어넷 직업백과 — 금속관련장치조작원 직무 특성","url":"https://www.career.go.kr/cloud/w/job/view?seq=2201"},
      {"id":10,"text":"포스코 공식 사이트 — 포항제철소 생산 현황","url":"https://www.posco.co.kr/"}
    ]
  }
}') WHERE id = '1765283292292566';

-- 3) 극작가
UPDATE jobs SET user_contributed_json = json_patch(user_contributed_json, '{
  "way": "문예창작학과, 연극영화학과, 극작과 등 관련 학과에서 희곡 창작 이론과 실습을 배울 수 있으며, 국어국문학과·철학과 등 인문학 전공자가 극작에 입문하는 경우도 많다.[1]\n\n한국희곡작가협회, 서울연극협회 등에서 운영하는 극작 워크숍이나 신진작가 양성 프로그램에 참여하여 역량을 키울 수 있다. 대학원 과정(극작 전공)에서 심화 학습하는 경로도 있다.[2]\n\n주요 등단 경로는 대한민국연극제 희곡공모, 서울연극제 신작희곡 공모, 한국문화예술위원회 창작지원금 선정 등이며, 극단에 소속되어 전속 작가로 활동하거나 프리랜서로 작품을 발표한다.[3]",
  "overviewSalary": {"sal": "극작가 수입은 작품 계약 건별로 크게 다르며, 소극장 창작극 1편당 100~500만 원, 중대극장 작품 500~2,000만 원 수준이다.[4] 한국문화예술위원회 창작지원금(500~3,000만 원)이 주요 수입원인 작가도 많다. 안정적 고정 수입이 어려워 강의, 방송 대본, 번역 등을 병행하는 경우가 일반적이다.", "source": "한국문화예술위원회, KOPIS(2023)"},
  "overviewProspect": {"main": "소극장 연극 시장은 꾸준히 유지되고 있으며, 뮤지컬 시장의 성장(2023년 공연 시장 약 1조 원 돌파)에 따라 창작 뮤지컬 대본 수요가 증가하고 있다.[5] 다만 극작만으로 생계를 유지하기 어려운 구조적 한계가 있어 겸업이 일반적이다.[6] OTT 콘텐츠 확대로 무대극이 영상 콘텐츠로 각색되는 사례가 늘면서 새로운 기회가 생기고 있다.", "source": "예술경영지원센터 KOPIS(2023)"},
  "trivia": "한국 최초의 근대 희곡은 1908년 이인직의 ''은세계''로 알려져 있으며, 본격적인 창작 희곡 시대는 1930년대 유치진의 ''토막''에서 시작되었다고 평가받는다.[7] 현재 한국에는 매년 100편 이상의 신작 희곡이 무대에 올라간다.[8]",
  "_sources": {
    "way": [
      {"id":1,"text":"커리어넷 직업백과 — 극작가 진학 정보","url":"https://www.career.go.kr/cloud/w/job/view?seq=373"},
      {"id":2,"text":"한국희곡작가협회 — 극작 워크숍 및 신진작가 프로그램","url":"http://www.kdrama.or.kr/"},
      {"id":3,"text":"한국문화예술위원회 — 창작 지원 프로그램 안내","url":"https://www.arko.or.kr/"}
    ],
    "overviewSalary.sal": [
      {"id":4,"text":"한국문화예술위원회 — 창작지원금 지원 규모 현황","url":"https://www.arko.or.kr/"}
    ],
    "overviewProspect.main": [
      {"id":5,"text":"예술경영지원센터 KOPIS — 2023 공연예술 실태조사 (공연시장 1조 돌파)","url":"https://www.kopis.or.kr/por/cs/cntnts/cntntsView.do?menuId=MNU_00021&cntntsId=CNT_000000003"},
      {"id":6,"text":"커리어넷 직업백과 — 극작가 전망 및 직업 특성","url":"https://www.career.go.kr/cloud/w/job/view?seq=373"}
    ],
    "trivia": [
      {"id":7,"text":"한국민족문화대백과사전 — 이인직 ''은세계'' 및 근대 희곡사","url":"https://encykorea.aks.ac.kr/"},
      {"id":8,"text":"예술경영지원센터 KOPIS — 공연 통계 (연간 신작 희곡 현황)","url":"https://www.kopis.or.kr/"}
    ]
  }
}') WHERE id = '1765283292024544';
