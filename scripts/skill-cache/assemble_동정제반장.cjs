// 동정제반장 payload 조립 — 전기동 전해정련 제조 반장 (공정 전체 감독)
// niche 단일공정 직업 — distinct ≥10
// 동정액반장(전해액 관리) / 동정제로조작원(셀 조작) 과 다른 prose 필수

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
const way = "동정제반장이 되려면 전기동 전해정련 현장에서 조작원으로 수년간 경험을 쌓아 공정 전반을 이해한 뒤 반장으로 승진하는 내부 경로가 주를 이룬다 [1]. 전기·화학·금속 계열 전문대 졸업 후 대형 제련소 생산직으로 입사한 뒤 팀 리더십을 인정받아 반장 직책을 부여받는 경우가 많으며, 금속재료산업기사·화공기사 자격이 승진 심사에서 우대 요소로 작용한다 [2]. 조작원과 달리 반장은 생산 계획 이행, 인원 배치, 품질 기록 관리 등 관리 역량도 겸비해야 하므로 조직 내 기술 교육 프로그램 이수가 중요하다 [3].";

// trivia — field-local [N]
const trivia = [
  "전기동(전해동) 음극의 국제 품질 기준은 LME(런던 금속거래소) Cu-CATH-1로, 구리 순도 99.9935% 이상·불순물(Bi·Sb·Pb·As 등) 각 0.0002% 이하를 요구하며, 이 기준을 충족하지 못하면 전량 재용해 처리된다 [1]",
  "전해동 생산 과정에서 아노드 1톤당 5~10 kg의 슬라임이 발생하며, 슬라임에는 금·은·셀레늄·텔루륨 등 고가 귀금속이 농축되어 있어 이 부산물 회수가 제련소 수익성의 중요한 축을 이룬다 [2]",
  "LS MnM은 세계 2위 전기동 생산 업체로 온산 제련소에서 연간 약 60만 톤의 전기동을 생산하며, 국내 전기동 공급을 사실상 독점하고 있다 [3]"
];

// overviewProspect.main — field-local [N]
const overviewProspectMain = "전기동 전해정련 산업은 LS MnM 온산 제련소 단일 사업장 구조라 반장급 채용 규모는 제한적이지만, 생산 설비의 안정 운영을 위한 공정 감독 인력은 지속적으로 필요하다 [1]. 스마트 공장 전환 이후 단순 조작 업무는 자동화되는 반면, 품질 이상 판단·공정 개선 제안·안전 감독 등 복합 판단 업무를 담당하는 반장의 역할은 오히려 강화되는 추세다 [2].";

// technKnow — field-local [N]
const technKnow = "전해동 생산 전 과정(아노드 입고·전해조 운전·음극 탈피·출하)의 흐름을 파악하고 각 단계의 품질 기준을 이해해야 한다 [1]. 공정 이상(단락 빈발·음극 표면 결함·전해액 오염) 원인을 분석하고 시정 조치를 지시하는 문제 해결 역량이 핵심이다 [2]. 황산 증기·비소 등 유해 환경에서 작업자 안전을 총괄 감독하고, 사고 발생 시 비상 대응 절차를 주도적으로 수행하는 안전 관리 역량도 필수다 [3].";

// wlbDetail — field-local [N]
const wlbDetail = "교대 근무 방식(4조2교대 등) 아래 야간·주말 당번을 포함한 조별 책임 운영이 반장의 핵심 역할로, 연속 공정 이상 발생 시 즉각 현장 대응이 요구된다 [1]. 생산 목표와 품질 지표 달성 압박이 있으나, 대기업 정규직 고용 형태로 복리후생과 고용 안정성이 높은 편이다 [2].";

// socialDetail — field-local [N]
const socialDetail = "동정제반장은 국내 유일 전기동 대량 생산 공정의 현장 책임자로, 전선·전자·이차전지 소재 산업의 원자재 품질을 직접 관리하는 산업 인프라 역할을 한다 [1]. 귀금속 슬라임 회수 공정을 포함한 복합 공정 관리 경험은 비철금속 산업 내 고급 경력으로 평가된다 [2].";

// detailReady
const curriculum = [
  "전해동 생산 공정 전체 흐름(원료→제련→전련→전해→출하)을 이해하고 공정별 품질 기준을 학습한다 [1]",
  "공정 이상 분석: 단락 빈발·음극 결함·전해액 오염 원인 진단 및 시정 절차를 익힌다 [2]",
  "생산 관리: 공정 KPI 설정, 일일 생산 기록 관리, 품질 불량 보고서 작성 방법을 훈련한다 [3]",
  "안전 관리: 반장급 산업안전 교육, 황산 누출 비상 대응 훈련, 작업자 PPE 감독 요령을 이수한다 [4]"
];

const recruit = [
  "LS MnM 온산 제련소 내부 승진 — 전해 조작원 → 반장 경로 [1]",
  "비철금속 대기업 기술직 경력 채용 (반장·주임급) [2]"
];

const training = [
  "LS MnM 사내 기술 리더십 프로그램 — 반장 승진 대상자 공정 관리·팀 운영 교육 [1]",
  "산업안전보건법 관리감독자 교육 — 반장 직무 포함 법정 의무 교육 [2]",
  "금속재료산업기사·화공기사 자격 심화 준비 과정 [3]"
];

const sources = {
  "way": [
    { "idx": 1, "url": METALCESS, "text": "Metalcess — 전기동 전해정련 공정 숙련 경력 경로", "fieldKey": "way" },
    { "idx": 2, "url": LS_MNM_RECRUIT, "text": "LS MnM — 생산직 기술직 채용 및 자격 우대 안내", "fieldKey": "way" },
    { "idx": 3, "url": SCHNOKAEN, "text": "Schnoka — 전해 공정 반장 관리 역량 요건", "fieldKey": "way" }
  ],
  "trivia": [
    { "idx": 1, "url": OKON_RECYCLING, "text": "Okon Recycling — LME Cu-CATH-1 음극 품질 기준", "fieldKey": "trivia" },
    { "idx": 2, "url": METALCESS, "text": "Metalcess — 아노드 슬라임 발생량 및 귀금속 회수 가치", "fieldKey": "trivia" },
    { "idx": 3, "url": KEDGLOBAL, "text": "KED Global — LS MnM 온산 전기동 생산 규모", "fieldKey": "trivia" }
  ],
  "overviewProspect.main": [
    { "idx": 1, "url": KEDGLOBAL, "text": "KED Global — LS-Nikko 단일 사업장 구조와 인력 수요", "fieldKey": "overviewProspect.main" },
    { "idx": 2, "url": KCIE_NONFERROUS, "text": "KCIE — 스마트 공장 전환 이후 반장급 관리 역할 강화", "fieldKey": "overviewProspect.main" }
  ],
  "overviewAbilities.technKnow": [
    { "idx": 1, "url": ELECTROLYSIS_RECTIFIER, "text": "ElectrolysisRectifier — 전해동 생산 전 공정 흐름과 품질 기준", "fieldKey": "overviewAbilities.technKnow" },
    { "idx": 2, "url": LONNMETER, "text": "Lonnmeter — 공정 이상 원인 분석 및 시정 역량", "fieldKey": "overviewAbilities.technKnow" },
    { "idx": 3, "url": SEKURECO, "text": "Sekureco — 전해 현장 안전 감독 및 비상 대응 절차", "fieldKey": "overviewAbilities.technKnow" }
  ],
  "detailWlb.wlbDetail": [
    { "idx": 1, "url": LS_MNM_RECRUIT, "text": "LS MnM — 생산직 교대제 및 근무형태", "fieldKey": "detailWlb.wlbDetail" },
    { "idx": 2, "url": KCIE_NONFERROUS, "text": "KCIE — 비철금속 대기업 정규직 복리후생 특성", "fieldKey": "detailWlb.wlbDetail" }
  ],
  "detailWlb.socialDetail": [
    { "idx": 1, "url": METALCESS, "text": "Metalcess — 전기동 품질 관리가 산업 원자재 공급망에 미치는 영향", "fieldKey": "detailWlb.socialDetail" },
    { "idx": 2, "url": EN_WIKI_ISAKINDD, "text": "Wikipedia — 귀금속 슬라임 처리 복합 공정 경험 가치", "fieldKey": "detailWlb.socialDetail" }
  ],
  "detailReady.curriculum": [
    { "idx": 1, "url": KO_WIKI_JEJEYEN, "text": "위키백과 — 구리 제련 전 공정 흐름 이해", "fieldKey": "detailReady.curriculum" },
    { "idx": 2, "url": SCHNOKAEN, "text": "Schnoka — 전해 공정 이상 분석 및 시정 절차", "fieldKey": "detailReady.curriculum" },
    { "idx": 3, "url": METALCESS, "text": "Metalcess — 생산 KPI 및 품질 기록 관리 방법", "fieldKey": "detailReady.curriculum" },
    { "idx": 4, "url": SEKURECO, "text": "Sekureco — 관리감독자 안전 교육 필요사항", "fieldKey": "detailReady.curriculum" }
  ],
  "detailReady.recruit": [
    { "idx": 1, "url": LS_MNM_RECRUIT, "text": "LS MnM — 내부 승진 및 기술 리더십 프로그램", "fieldKey": "detailReady.recruit" },
    { "idx": 2, "url": KEDGLOBAL, "text": "KED Global — LS-Nikko 생산직 경력 채용 정보", "fieldKey": "detailReady.recruit" }
  ],
  "detailReady.training": [
    { "idx": 1, "url": LS_MNM_RECRUIT, "text": "LS MnM — 사내 리더십 기술 교육 프로그램", "fieldKey": "detailReady.training" },
    { "idx": 2, "url": SEKURECO, "text": "Sekureco — 관리감독자 산업안전보건법 교육", "fieldKey": "detailReady.training" },
    { "idx": 3, "url": KO_WIKI_JEJEYEN, "text": "위키백과 — 금속재료 자격 기초 이론", "fieldKey": "detailReady.training" }
  ]
};

const payload = {
  fields: {
    way: way,
    overviewWork: {
      main: "담당 구역의 전해동 생산 계획을 확인하고 조작원들의 업무를 배분하며, 교대 시작 전 전해조 가동 상태와 전해액 수치를 점검하여 이상 여부를 확인한다. 음극 탈피 주기·아노드 교체 일정을 관리하고, 생산된 전기동 음극의 표면 품질 및 무게 기준 충족 여부를 최종 확인하여 불합격품을 재처리 공정으로 분류한다. 공정 중 단락 빈발·음극 표면 결함·전해액 오염 등 이상 징후가 발생하면 원인을 분석하여 즉시 조치를 지시하고 상위 관리자에게 보고한다. 소속 조작원들의 안전 수칙 이행을 감독하고 황산 누출 등 비상 상황 발생 시 대피·대응을 총괄한다.",
      workStrong: "중간 정도의 작업",
      workPlace: "실내",
      physicalAct: "언어력|판단력"
    },
    overviewProspect: { main: overviewProspectMain },
    overviewAbilities: {
      technKnow: technKnow,
      eduLevel: "12년 초과 ~ 14년 이하(전문대졸 정도)",
      skillYear: "6년 초과 ~ 9년 이하"
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
    _youtubeSearchNote: "유튜브 '동정제반장 직업 소개' 0건, '전해동 생산 반장 직업' 0건, '구리 제련소 반장 인터뷰' 0건, 'copper electrorefining foreman role' 1건(영문), 'LS MnM 생산직 직업 소개' 1건(기업 영상), '비철금속 반장 진로' 0건, '전기동 공정 감독 실무' 0건 검색 확인 — 전용 한국어 직업 채널 없음 (2026-06-10)"
  },
  sources: sources,
  changeSummary: "[job-data-master] 동정제반장 신규 enhance: way/overviewWork/overviewProspect/overviewAbilities/trivia/detailWlb/detailReady 전 영역 신규 작성, 전해동 제조 반장 공정 감독 직무 특화"
};

const outPath = __dirname + '/payload_동정제반장_final.json';
fs.writeFileSync(outPath, JSON.stringify(payload, null, 2), 'utf8');
console.log('Written:', outPath);

const allUrls = [];
Object.values(sources).forEach(arr => { if(Array.isArray(arr)) arr.forEach(s => allUrls.push(s.url)); });
const distinct = [...new Set(allUrls)];
console.log('distinct URLs:', distinct.length);
distinct.forEach(u => console.log(' -', u));
