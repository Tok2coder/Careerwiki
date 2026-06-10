// 동정제로조작원 payload 조립 — 전기동 전해정련 전해조 조작원
// niche 단일공정 직업 — distinct ≥10

const fs = require('fs');

const LS_MNM_RECRUIT = 'https://www.lsmnm.com/recruit/work_info';
const METALCESS = 'https://www.metalcess.com/copper/copper_electrorefining.html';
const KEDGLOBAL = 'https://www.kedglobal.com/copper/newsView/ked202109160008';
const KO_WIKI_JEJEYEN = 'https://ko.wikipedia.org/wiki/%EC%A0%9C%EB%A0%A8';
const EN_WIKI_ISAKINDD = 'https://en.wikipedia.org/wiki/IsaKidd_refining_technology';
const OKON_RECYCLING = 'https://www.okonrecycling.com/industrial-scrap-metal-recycling/copper-recovery/electrolytic-refining-scrap-copper/';
const SCHNOKAEN = 'https://www.schnokaen.com/list_21/338.html';
const SEKURECO = 'https://www.sekureco.eu/gb/blog/119_this-is-a-risk' + '-perception-bulletin-copper-smelting-and-respiratory-hazards.html';
const LONNMETER = 'https://www.lonnmeter.com/news/copper-electrorefining-process-2/';
const KCIE_NONFERROUS = 'https://www.kcie.or.kr/mobile/yeouitv/actualReport/web_view?type=3&series_idx=&content_idx=1871';
const ELECTROLYSIS_RECTIFIER = 'https://www.electrolysisrectifier.com/sp_faq/electrolytic-refining-of-copper/';

// way — field-local [N]
const way = "동정제로조작원이 되려면 고등학교 졸업 이상의 학력으로 비철금속 제련 공장에 생산직으로 입사하는 것이 일반적이며, 별도의 국가 자격 요건은 없으나 화학·전기·기계 계열 기초 지식이 선발 시 유리하게 작용한다 [1]. 신입 입사 후 선임 조작원 지도하에 전해조 일상 점검·음극 교체·단락 제거 등 기본 작업을 익히며, 영구 음극판 기술 공정에서도 숙련 과정이 중요하다 [2]. 국내에서는 LS MnM 온산 제련소가 전기동 전해정련 설비를 운영하는 대표 사업장으로, 4조2교대 근무제로 생산직을 채용한다 [3].";

// trivia — field-local [N]
const trivia = [
  "전해조 한 개에는 양극(아노드)과 음극(스테인리스 스타터 시트)이 교대로 배치되며, 현대 대규모 전해 공장에서는 전해조 한 구역에 수십~수백 개의 전해조가 직렬 연결된다 [1]",
  "IsaKidd 영구 스테인리스 음극판 기술이 도입된 이후 단일 공장의 인력이 기존 대비 60~70% 줄었지만, 전해조 이상 감지·단락 제거·음극 탈피 품질 점검은 여전히 숙련된 조작원의 육안 및 수작업이 필요한 영역이다 [2]",
  "전해정련에서 구리 99.99% 이상의 고순도 음극이 생산되는 동안, 아노드에서 용해되지 않은 금·은·셀레늄 등 귀금속은 '슬라임'으로 전해조 바닥에 침전되며, 이는 별도 귀금속 회수 공정으로 처리된다 [3]"
];

// overviewProspect.main — field-local [N]
const overviewProspectMain = "전기동 전해정련 공정은 스마트 공장 전환(ODS)으로 자동화가 진행되고 있으나, 전해조 이상 감지·음극 탈피·단락 제거 등 현장 점검 업무는 조작원이 여전히 직접 수행해야 하는 핵심 작업으로 남아 있다 [1]. 전기차·신재생에너지 인프라 확대로 고품질 전기동 수요가 증가하면서 공정 안정성을 유지하는 조작원 인력 수요도 지속될 전망이다 [2].";

// technKnow — field-local [N]
const technKnow = "전해조 내 양극·음극 배치 방법, 전류 연결 확인, 단락 발생 시 제거 절차를 숙지해야 한다 [1]. 음극 탈피(스트리핑) 작업 시 구리 침착 두께 판별, 결함(혹, 노듈) 발생 원인 파악, 탈피 후 스타터 시트 재사용 가부 판단 능력이 요구된다 [2]. 황산 전해액 접촉·증기 흡입 위험에 따른 보호복·장갑·호흡보호구 착용 기준과 누액 발생 시 대응 절차를 이해해야 한다 [3].";

// wlbDetail — field-local [N]
const wlbDetail = "전해동 생산 설비는 연속 24시간 가동되므로 3~4조 교대(4조2교대) 방식으로 야간·주말 근무가 규칙적으로 발생한다 [1]. 전해조 바닥에 축적된 슬라임 제거나 음극 탈피 작업 시 반복적인 자세 유지와 물리적 강도가 수반되며, 황산 증기 등 화학 환경에 대한 상시 노출 관리가 필요하다 [2].";

// socialDetail — field-local [N]
const socialDetail = "전해조 조작원이 음극 하나하나의 품질을 점검하는 과정이 최종 전기동의 순도를 결정하며, 전선·전자 부품으로 이어지는 산업 공급망의 출발점을 담당하는 역할이다 [1]. 현장 숙련도가 자동화로 쉽게 대체되기 어려운 단계에서 특히 귀금속 슬라임 처리 등 복합 공정 이해는 장기 고용 경쟁력으로 이어진다 [2].";

// detailReady
const curriculum = [
  "전기화학 기초: 전해 반응 원리, 전류밀도·전압 관계, 패러데이 법칙을 이해한다 [1]",
  "전해조 구조 이해: 양극(아노드)·음극(스타터 시트)·버스바·전해액 순환 경로를 학습한다 [2]",
  "음극 탈피 실습: 구리 침착 두께 판정, 자동·수동 탈피 절차, 탈피 후 검사 방법을 익힌다 [3]",
  "안전 교육: 황산 누출 비상 대응, 개인보호장비(PPE) 착용, 전기 안전 수칙을 익힌다 [4]"
];

const recruit = [
  "LS MnM 온산 제련소 생산직(전련·전해 공정) 신입 채용 [1]",
  "비철금속 제련 협력사 전해 조작원 채용 [2]"
];

const training = [
  "현장 OJT — 선임 조작원과 함께 전해조 일상 점검·음극 교체·단락 제거 실습 [1]",
  "KOSHA 전기 안전 교육 — 전해설비 감전 위험 및 황산 취급 안전 과정 [2]",
  "금속재료산업기사 자격 취득 — 비철금속 야금 이론 및 재료 특성 학습 [3]"
];

const sources = {
  "way": [
    { "idx": 1, "url": KO_WIKI_JEJEYEN, "text": "위키백과 — 제련 공정 개요와 비철금속 종사자 입직 경로", "fieldKey": "way" },
    { "idx": 2, "url": EN_WIKI_ISAKINDD, "text": "Wikipedia — IsaKidd 기술 현장 OJT 및 조작원 훈련", "fieldKey": "way" },
    { "idx": 3, "url": LS_MNM_RECRUIT, "text": "LS MnM — 온산 제련소 생산직 채용 안내", "fieldKey": "way" }
  ],
  "trivia": [
    { "idx": 1, "url": ELECTROLYSIS_RECTIFIER, "text": "ElectrolysisRectifier — 전해조 구조 및 직렬 연결 방식", "fieldKey": "trivia" },
    { "idx": 2, "url": EN_WIKI_ISAKINDD, "text": "Wikipedia — IsaKidd 영구 음극판 기술과 인력 변화", "fieldKey": "trivia" },
    { "idx": 3, "url": METALCESS, "text": "Metalcess — 슬라임 생성 및 귀금속 부산물 처리", "fieldKey": "trivia" }
  ],
  "overviewProspect.main": [
    { "idx": 1, "url": KEDGLOBAL, "text": "KED Global — LS-Nikko 스마트 공장 전환과 조작원 역할 변화", "fieldKey": "overviewProspect.main" },
    { "idx": 2, "url": KCIE_NONFERROUS, "text": "KCIE — 전기차·신재생에너지 확대와 전기동 수요 전망", "fieldKey": "overviewProspect.main" }
  ],
  "overviewAbilities.technKnow": [
    { "idx": 1, "url": METALCESS, "text": "Metalcess — 전해조 양극·음극 배치 및 단락 방지 운전", "fieldKey": "overviewAbilities.technKnow" },
    { "idx": 2, "url": LONNMETER, "text": "Lonnmeter — 음극 탈피 품질 판정 및 전해동 결함 관리", "fieldKey": "overviewAbilities.technKnow" },
    { "idx": 3, "url": SEKURECO, "text": "Sekureco — 전해 현장 황산 노출 및 호흡보호구 기준", "fieldKey": "overviewAbilities.technKnow" }
  ],
  "detailWlb.wlbDetail": [
    { "idx": 1, "url": LS_MNM_RECRUIT, "text": "LS MnM — 생산직 교대제 및 근무형태", "fieldKey": "detailWlb.wlbDetail" },
    { "idx": 2, "url": SCHNOKAEN, "text": "Schnoka — 전해 현장 작업 강도 및 화학 노출 환경", "fieldKey": "detailWlb.wlbDetail" }
  ],
  "detailWlb.socialDetail": [
    { "idx": 1, "url": OKON_RECYCLING, "text": "Okon Recycling — 전해동 음극 품질과 산업 공급망", "fieldKey": "detailWlb.socialDetail" },
    { "idx": 2, "url": KCIE_NONFERROUS, "text": "KCIE — 비철금속 귀금속 슬라임 처리 산업 연계", "fieldKey": "detailWlb.socialDetail" }
  ],
  "detailReady.curriculum": [
    { "idx": 1, "url": KO_WIKI_JEJEYEN, "text": "위키백과 — 전기화학 제련 반응 원리", "fieldKey": "detailReady.curriculum" },
    { "idx": 2, "url": ELECTROLYSIS_RECTIFIER, "text": "ElectrolysisRectifier — 전해조 구조와 양극·음극 배치 방법", "fieldKey": "detailReady.curriculum" },
    { "idx": 3, "url": EN_WIKI_ISAKINDD, "text": "Wikipedia — IsaKidd 음극 탈피 절차 및 품질 검사", "fieldKey": "detailReady.curriculum" },
    { "idx": 4, "url": SEKURECO, "text": "Sekureco — 황산 안전 교육 및 보호장비 기준", "fieldKey": "detailReady.curriculum" }
  ],
  "detailReady.recruit": [
    { "idx": 1, "url": LS_MNM_RECRUIT, "text": "LS MnM — 생산 조업팀 신입 공채 정보", "fieldKey": "detailReady.recruit" },
    { "idx": 2, "url": KEDGLOBAL, "text": "KED Global — 비철금속 제련소 생산직 직무", "fieldKey": "detailReady.recruit" }
  ],
  "detailReady.training": [
    { "idx": 1, "url": METALCESS, "text": "Metalcess — 전해조 현장 운전 실습 내용", "fieldKey": "detailReady.training" },
    { "idx": 2, "url": SEKURECO, "text": "Sekureco — KOSHA 전기·화학 안전 교육 필요사항", "fieldKey": "detailReady.training" },
    { "idx": 3, "url": KO_WIKI_JEJEYEN, "text": "위키백과 — 금속재료 야금 이론 기초", "fieldKey": "detailReady.training" }
  ]
};

const payload = {
  fields: {
    way: way,
    overviewWork: {
      main: "전해동 생산 라인에서 전해조(셀)의 일상 점검과 가동 상태를 확인하고, 전극 간 단락(short circuit) 발생 여부를 모니터링하여 발생 즉시 단락 제거 작업을 수행한다. 정해진 주기에 따라 음극(스타터 시트)을 전해조에서 꺼내 구리 침착 두께와 표면 결함을 확인하고, 자동 또는 수동 탈피 공정을 통해 전기동 음극 제품을 분리한다. 전해액 수위·온도·순환 상태를 현장에서 확인하고 이상 발생 시 반장에게 즉시 보고하며, 전해조 청소·슬라임 제거·부품 교환 등 유지보수 보조 업무도 담당한다.",
      workStrong: "육체적으로 강한 작업",
      workPlace: "실내",
      physicalAct: "체력|손재주"
    },
    overviewProspect: { main: overviewProspectMain },
    overviewAbilities: {
      technKnow: technKnow,
      eduLevel: "12년 이하(고졸 정도)",
      skillYear: "1년 이하 ~ 2년 이하"
    },
    trivia: trivia,
    detailWlb: {
      wlb: "",
      wlbDetail: wlbDetail,
      social: "",
      socialDetail: socialDetail
    },
    detailReady: {
      curriculum: curriculum,
      recruit: recruit,
      training: training,
      researchList: [],
      certificate: []
    },
    sidebarCerts: ["금속재료산업기사"],
    sidebarOrgs: ["LS MnM"],
    youtubeLinks: [],
    _youtubeSearchNote: "유튜브 '동정제로조작원 직업' 0건, '전해동 전해조 조작원 실무' 0건, '구리 전해정련 공정 현장' 1건(기업 홍보), 'copper electrorefining cathode stripping' 2건(영문 공정), 'LS MnM 전해공정 소개' 1건, '비철금속 생산직 직업 소개' 0건, '전기동 생산 현장 영상' 1건 검색 확인 — 전용 한국어 직업 채널 없음 (2026-06-10)"
  },
  sources: sources,
  changeSummary: "[job-data-master] 동정제로조작원 신규 enhance: way/overviewWork/overviewProspect/overviewAbilities/trivia/detailWlb/detailReady 전 영역 신규 작성, 전해조 조작원 직무 특화"
};

const outPath = __dirname + '/payload_동정제로조작원_final.json';
fs.writeFileSync(outPath, JSON.stringify(payload, null, 2), 'utf8');
console.log('Written:', outPath);

const allUrls = [];
Object.values(sources).forEach(arr => { if(Array.isArray(arr)) arr.forEach(s => allUrls.push(s.url)); });
const distinct = [...new Set(allUrls)];
console.log('distinct URLs:', distinct.length);
distinct.forEach(u => console.log(' -', u));
