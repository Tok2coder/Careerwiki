// 동정액반장 payload 조립 — 전기동 전해정련 전해액(동정액) 관리 반장
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
const way = "동정액반장이 되려면 전기·화학·금속 계열 전문대 이상의 학력이나 비철금속 제련 현장 경력이 필요하다 [1]. 전해동 생산 설비를 운영하는 대형 제련소에 입사하여 조작원으로 경험을 쌓은 뒤 반장으로 승진하는 경로가 일반적이며, 국내에서는 LS MnM(온산) 등 비철금속 제련 전문 업체가 주요 채용처다 [2]. 전기동 전해정련 공정에 관한 자격으로는 금속재료산업기사·화공기사 등이 도움이 되며, 황산화물·전해액 안전 관련 산업안전 교육 이수가 현장 배치 전 필수 요건으로 작용한다 [3].";

// trivia — field-local [N]
const trivia = [
  "전해정련 전해액은 황산구리(CuSO₄)와 황산(H₂SO₄)의 혼합 수용액으로, 구리 이온 농도 40~50 g/L, 황산 농도 175~225 g/L, 온도 60~65°C를 유지해야 고품질 전기동 음극이 생성된다 [1]",
  "불순물 제어가 소홀하면 비소(As), 안티모니(Sb), 비스무트(Bi) 등이 음극 구리 안으로 공침되어 제품 순도가 99.99% 이하로 떨어질 수 있으며, 이는 전선·반도체 기판용 전기동 규격 탈락 원인이 된다 [2]",
  "전해액 밀도계(vibrating element density meter)로 실시간 전해액 조성을 모니터링하면 에너지 소비를 절감하고 전류 효율을 높일 수 있다 [3]"
];

// overviewProspect.main — field-local [N]
const overviewProspectMain = "전기동은 전선·배터리·전자부품의 핵심 소재로, 탄소중립·전기차 보급 확대와 함께 글로벌 수요가 증가하고 있어 국내 전해동 생산 공정 유지 수요는 안정적이다 [1]. 국내 전해동 생산은 LS MnM 온산 제련소가 사실상 독점하고 있어 해당 공정 운영 인력의 고용 안정성은 높으나, 디지털 스마트 공장 전환(ODS)으로 자동화가 진행되면서 단순 조작 인력보다 공정 감독·분석 역량을 갖춘 반장급 이상의 전문 인력이 더 필요해지는 추세다 [2].";

// technKnow — field-local [N]
const technKnow = "전해액 화학 분석(황산 농도·구리 이온 농도·불순물 함량 측정)과 실시간 모니터링 시스템 운용 능력이 핵심 기술 역량이다 [1]. 전해조 전류 밀도, 전압, 액온도 파라미터 관리 및 단락 전류 방지 절차 수행 능력도 필수다 [2]. 구리 제련 현장에서는 황산 증기·비소 등 유해 환경에 노출될 수 있어 산업위생 지식과 보호장비 착용 기준에 대한 이해가 현장에서 요구된다 [3].";

// wlbDetail — field-local [N]
const wlbDetail = "3~4조 교대 근무제(4조2교대 등)를 적용하는 대형 제련소 환경이 일반적이며, 황산 증기 노출 통제를 위한 밀폐 환경에서 작업한다 [1]. 생산 공정 연속 가동 특성상 공정 이상 발생 시 야간·주말 근무가 불가피하며, 전해조 누액 등 비상 상황 대응 능력이 요구된다 [2].";

// socialDetail — field-local [N]
const socialDetail = "전기동은 전선·전자 산업의 필수 원자재로, 공정 품질을 유지하는 반장의 역할이 국내 전기동 생산 경쟁력에 직결된다 [1]. 산업 자동화 전환 속에서도 공정 이상 감지와 품질 책임을 지는 현장 반장의 전문성은 대체 불가한 가치를 지닌다 [2].";

// detailReady
const curriculum = [
  "금속재료·비철금속 야금 기초: 구리 제련 공정(제련→전련→전해정련)과 전기화학 반응 원리를 학습한다 [1]",
  "전해액 분석: 황산 농도 및 구리 이온 농도 측정, 불순물(As·Sb·Bi) 분석 방법을 실습한다 [2]",
  "전해조 운전·안전: 전류밀도 설정, 전압 모니터링, 단락 방지 절차와 황산 취급 안전 수칙을 익힌다 [3]",
  "품질 관리: 음극 품질 기준(LME Cu-CATH-1)과 불합격 원인 분석 방법을 이해한다 [4]"
];

const recruit = [
  "LS MnM(LS니꼬동제련) 온산 제련소 기술직(생산 조업팀) 공채 [1]",
  "비철금속 제련 협력업체 기술직 채용 [2]"
];

const training = [
  "한국산업안전보건공단(KOSHA) 화학공정 안전 교육 — 황산·유해가스 취급 위험 관리 [1]",
  "비철금속학회·한국자원리싸이클링학회 전문 연수 [2]",
  "금속재료산업기사·화공기사 자격 취득 준비 과정 [3]"
];

const sources = {
  "way": [
    { "idx": 1, "url": KO_WIKI_JEJEYEN, "text": "위키백과 — 제련: 비철금속 제련 개요 및 전해정련 설명", "fieldKey": "way" },
    { "idx": 2, "url": LS_MNM_RECRUIT, "text": "LS MnM — 채용 안내 및 생산직 업무 분야", "fieldKey": "way" },
    { "idx": 3, "url": SEKURECO, "text": "Sekureco — 구리 제련 현장 안전 교육 필요사항", "fieldKey": "way" }
  ],
  "trivia": [
    { "idx": 1, "url": LONNMETER, "text": "Lonnmeter — 전해동 정련 전해액 조성 관리", "fieldKey": "trivia" },
    { "idx": 2, "url": SCHNOKAEN, "text": "Schnoka — 구리 전해정련 불순물 관리 공정", "fieldKey": "trivia" },
    { "idx": 3, "url": ELECTROLYSIS_RECTIFIER, "text": "ElectrolysisRectifier — 전해액 밀도 관리와 음극 품질 최적화", "fieldKey": "trivia" }
  ],
  "overviewProspect.main": [
    { "idx": 1, "url": KCIE_NONFERROUS, "text": "KCIE — 비철금속 산업 전망: 구리 수요 전기차·배터리 확대", "fieldKey": "overviewProspect.main" },
    { "idx": 2, "url": KEDGLOBAL, "text": "KED Global — LS-Nikko 스마트 공장 전환 및 공정 디지털화", "fieldKey": "overviewProspect.main" }
  ],
  "overviewAbilities.technKnow": [
    { "idx": 1, "url": METALCESS, "text": "Metalcess — 전기동 전해정련 공정 설계 및 전해액 관리", "fieldKey": "overviewAbilities.technKnow" },
    { "idx": 2, "url": ELECTROLYSIS_RECTIFIER, "text": "ElectrolysisRectifier — 전해 정련 전류밀도·전압·온도 관리", "fieldKey": "overviewAbilities.technKnow" },
    { "idx": 3, "url": SEKURECO, "text": "Sekureco — 전해 현장 유해물질 노출 위험 및 PPE 기준", "fieldKey": "overviewAbilities.technKnow" }
  ],
  "detailWlb.wlbDetail": [
    { "idx": 1, "url": LS_MNM_RECRUIT, "text": "LS MnM — 생산직 근무형태 및 교대제", "fieldKey": "detailWlb.wlbDetail" },
    { "idx": 2, "url": METALCESS, "text": "Metalcess — 전해조 연속 가동 환경 및 비상 대응", "fieldKey": "detailWlb.wlbDetail" }
  ],
  "detailWlb.socialDetail": [
    { "idx": 1, "url": KCIE_NONFERROUS, "text": "KCIE — 전기동의 산업적 중요성", "fieldKey": "detailWlb.socialDetail" },
    { "idx": 2, "url": EN_WIKI_ISAKINDD, "text": "Wikipedia — 전해동 생산 자동화와 전문 인력 역할", "fieldKey": "detailWlb.socialDetail" }
  ],
  "detailReady.curriculum": [
    { "idx": 1, "url": KO_WIKI_JEJEYEN, "text": "위키백과 — 제련 공정 원리: 구리 전해정련 개요", "fieldKey": "detailReady.curriculum" },
    { "idx": 2, "url": SCHNOKAEN, "text": "Schnoka — 전해액 분석 및 불순물 제거 기술", "fieldKey": "detailReady.curriculum" },
    { "idx": 3, "url": OKON_RECYCLING, "text": "Okon Recycling — 전해정련 전해조 운전 및 안전 기준", "fieldKey": "detailReady.curriculum" },
    { "idx": 4, "url": METALCESS, "text": "Metalcess — 전기동 음극 품질 기준 및 검사", "fieldKey": "detailReady.curriculum" }
  ],
  "detailReady.recruit": [
    { "idx": 1, "url": LS_MNM_RECRUIT, "text": "LS MnM — 온산 제련소 생산직 채용 안내", "fieldKey": "detailReady.recruit" },
    { "idx": 2, "url": KEDGLOBAL, "text": "KED Global — 비철금속 대기업 LS-Nikko 생산직 직무", "fieldKey": "detailReady.recruit" }
  ],
  "detailReady.training": [
    { "idx": 1, "url": SEKURECO, "text": "Sekureco — 구리 제련 현장 안전 교육 필요사항", "fieldKey": "detailReady.training" },
    { "idx": 2, "url": KCIE_NONFERROUS, "text": "KCIE — 비철금속 산업 현황 및 종사자 역량", "fieldKey": "detailReady.training" },
    { "idx": 3, "url": LS_MNM_RECRUIT, "text": "LS MnM — 생산 기술직 직무 및 자격 요건", "fieldKey": "detailReady.training" }
  ]
};

const payload = {
  fields: {
    way: way,
    overviewWork: {
      main: "전해정련 공정에서 생성되는 황산구리·황산 혼합 전해액의 조성·농도·온도를 관리하고, 전해조 내 불순물 축적 수준을 주기적으로 측정하여 전해액 교체 또는 정제 시점을 결정한다. 전해액 순환 시스템(순환 펌프·히터·냉각기·필터)의 정상 작동 여부를 점검하고, 비소·안티모니 등 유해 불순물이 규정치를 초과하면 블리드(bleed) 처리를 지시한다. 전해조별 전해액 품질 기록을 관리하고, 전해 효율 저하나 음극 품질 불량 발생 시 원인을 분석하여 공정 파라미터(전류밀도·온도·첨가제) 조정을 지시하며, 해당 구역 소속 조작원들의 작업 지도와 안전 수칙 이행을 감독한다.",
      workStrong: "중간 정도의 작업",
      workPlace: "실내",
      physicalAct: "언어력|화학분석"
    },
    overviewProspect: { main: overviewProspectMain },
    overviewAbilities: {
      technKnow: technKnow,
      eduLevel: "12년 초과 ~ 14년 이하(전문대졸 정도)",
      skillYear: "4년 초과 ~ 6년 이하"
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
    sidebarCerts: ["금속재료산업기사", "화공기사"],
    sidebarOrgs: ["LS MnM"],
    youtubeLinks: [],
    _youtubeSearchNote: "유튜브 '동정액반장 직업 소개' 0건, '전해동 정련 공정 영상' 2건(공정 소개), 'copper electrorefining process animation' 3건(영문 교육), '비철금속 제련 종사자 인터뷰' 0건, 'LS MnM 공정 소개' 1건(기업 홍보), '전해조 운전 실무' 0건, '전기동 생산 현장 직업' 0건 검색 확인 — 동정액반장 전용 한국어 채널 없음 (2026-06-10)"
  },
  sources: sources,
  changeSummary: "[job-data-master] 동정액반장 신규 enhance: way/overviewWork/overviewProspect/overviewAbilities/trivia/detailWlb/detailReady 전 영역 신규 작성, 전해동 정련 전해액 관리 반장 직무 특화"
};

const outPath = __dirname + '/payload_동정액반장_final.json';
fs.writeFileSync(outPath, JSON.stringify(payload, null, 2), 'utf8');
console.log('Written:', outPath);

const allUrls = [];
Object.values(sources).forEach(arr => { if(Array.isArray(arr)) arr.forEach(s => allUrls.push(s.url)); });
const distinct = [...new Set(allUrls)];
console.log('distinct URLs:', distinct.length);
distinct.forEach(u => console.log(' -', u));
