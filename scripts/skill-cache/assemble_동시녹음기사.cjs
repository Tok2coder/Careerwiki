// 동시녹음기사 payload 조립
// ALLOWED source fields: way/trivia/overviewProspect.main/overviewAbilities.technKnow/
//   overviewSalary.sal/detailWlb.wlbDetail/detailWlb.socialDetail +
//   detailReady.{curriculum,recruit,training,researchList,certificate}

const fs = require('fs');

const REALRECORDING = 'https://realrecording.live/' + encodeURIComponent('동시녹음-일기-1') + '/';
const ASAMARU_JOB = 'https://job.asamaru.net/' + encodeURIComponent('직업') + '/' + encodeURIComponent('음향-및-녹음기사') + '/';
const ASAMARU_DIC = 'https://job.asamaru.net/' + encodeURIComponent('직업사전') + '/' + encodeURIComponent('녹음기사') + '/';
const ASAMARU_SOUND_DIRECTOR = 'https://job.asamaru.net/' + encodeURIComponent('직업사전') + '/' + encodeURIComponent('음향감독') + '/';
const MIXING_CO = 'https://mixing.co.kr/3084';

// way — field-local [N]
const way = "동시녹음기사가 되려면 영화·방송 현장의 하위 직급(케이블맨 → 붐어시스턴트)부터 시작하여 단계적으로 경력을 쌓는 것이 일반적이며, 케이블맨에서 녹음감독이 되기까지 약 10년이 소요된다 [1]. 관련 학과(영상음향, 사운드디자인, 방송기술 계열)를 졸업하거나 방송아카데미·서울필름아카데미 등 사설 교육기관에서 3~6개월 과정을 이수한 뒤 현장에 투입되는 경우도 많다 [2]. 별도의 국가자격은 없으며 현장 경험과 포트폴리오, 수음·장비 운용 기술이 핵심 역량으로 평가된다 [3].";

// trivia — field-local [N]
const trivia = [
  "동시녹음은 촬영과 동시에 배우의 대사를 녹음하는 방식으로, 배우의 감정 연기가 중요하거나 현장의 소리가 반드시 필요할 때 사용한다 [1]",
  "붐오퍼레이터는 붐폴에 달린 마이크를 카메라 앵글·조명·배우 동선에 맞춰 조작하며, 대사를 완전히 암기해야 배우의 움직임보다 먼저 마이크를 위치시킬 수 있다 [2]",
  "OTT 콘텐츠 투자 확대로 넷플릭스가 2025년 한국 콘텐츠에 약 7,000억 원을 집행했으며 2026년에는 10% 이상 증가할 전망으로, 동시녹음 기술인력 수요도 함께 늘고 있다 [3]",
  "영화 현장 녹음팀은 평균 4~5명으로 구성되며 녹음감독·녹음기사·붐오퍼레이터·붐어시스턴트·케이블맨 순서로 역할이 세분화되고, 케이블맨부터 녹음감독까지 약 10년의 경력이 필요하다 [4]",
  "동시녹음 현장에서는 마이크 위치 조정 외에도 비닐봉지·바람 소리 등 예상치 못한 소음 원인을 즉시 파악하고 제거하는 '소음 탐정' 역할도 요구된다 [5]"
];
// [1]=kmdb, [2]=kmdb, [3]=lifebase ott

// overviewProspect.main — field-local [N]
const overviewProspectMain = "향후 10년간 음향·녹음기사의 고용은 연평균 2.3% 증가할 것으로 전망된다 [1]. OTT 플랫폼의 콘텐츠 투자 확대로 K-드라마·영화 제작 편수가 늘면서 현장 음향 기술인력 수요도 증가 추세에 있다 [2]. 프로덕션 사운드 믹서는 영화 현장에서 음향을 총괄하는 핵심 역할로, 디지털 제작 환경 전환과 함께 기술 전문성 수요가 높아지고 있다 [3]. 음향감독으로 성장하면 프리랜서 단가가 높아지고 장편영화·드라마 메인 프로젝트를 지휘하는 고급 경력 경로로 이어진다 [4]. 음향 전공자의 진로 선택지로 동시녹음기사는 방송·영화 외에도 광고·뮤직비디오·다큐멘터리 현장에서 활발히 활동한다 [5].";
// [1]=asamaru job, [2]=hscpa ott drama, [3]=wikipedia prod sound mixer, [4]=asamaru sound director, [5]=mixing.co.kr

// technKnow — field-local [N]
const technKnow = "Sound Devices·Zoom 계열 휴대용 다채널 레코더 운용 기술과 함께 샷건 마이크, 무선 라발리에(핀마이크), 붐폴 운용법을 숙련해야 한다 [1]. 서울필름아카데미 등 실무 교육에서는 음향이론(주파수·데시벨·신호 처리)과 믹서 조작 실습을 핵심으로 다룬다 [2]. 붐오퍼레이터는 카메라 앵글과 조명 방향을 파악하고 대사에 맞춰 마이크를 프레임 밖에서 정확히 유지하는 역량이 필수이다 [3]. 타임코드 동기화·멀티트랙 녹음·편집 개념도 디지털 제작 환경에서 기본 소양으로 요구된다 [4].";
// [1]=kmdb story, [2]=seoulfilm academy

// wlbDetail — field-local [N]
const wlbDetail = "촬영 일정에 따라 새벽·야간·주말 근무가 빈번하며 장거리 로케이션 출장도 잦다 [1]. 프리랜서 형태로 활동하는 경우가 많아 작품 단위로 수입이 발생하며, 방송국·영화사 소속 직원의 경우 상대적으로 고용이 안정적이다 [2]. 음향 분야의 경력자 연봉은 초봉 4,000만원 수준에서 숙련 전문가는 억대 연봉도 가능한 편이다 [3].";
// [1]=asamaru job, [2]=asamaru job

// socialDetail — field-local [N]
const socialDetail = "배우의 대사와 현장의 살아있는 소리를 포착하는 작업으로 현장의 이야기를 가장 가까이서 체험할 수 있다 [1]. K-드라마·영화 글로벌 수요 증가로 동시녹음 기술의 국제적 위상이 높아지고 있으며, 사운드 품질이 작품 평가에 직결된다는 인식도 확산되고 있다 [2].";
// [1]=kmdb story, [2]=hscpa ott drama

// detailReady
const curriculum = [
  "음향이론(주파수·데시벨·신호 처리)과 전기음향 기초를 학습하여 소리의 물리적 특성을 이해한다 [1]",
  "레코더·믹서·마이크 종류별 특성과 운용법을 익히고, 붐폴 조작과 무선 라발리에 시스템 세팅을 실습한다 [2]",
  "DAW(Pro Tools·Reaper 등) 기반 편집과 싱크 작업, 후시녹음(ADR) 기초를 이해한다 [3]",
  "실제 단편영화·광고 촬영 현장에서 케이블맨·붐어시스턴트로 참여하며 현장 노하우를 축적한다 [4]"
];
// [1]=dept.daelim, [2]=mediact, [3]=seoulfilm, [4]=kmdb

const recruit = [
  "영화·드라마 제작사 현장 음향팀 보조 인력 지원 [1]",
  "방송국(KBS·MBC·SBS 등) 기술직 공채 및 외주제작사 채용 [2]",
  "광고·뮤직비디오·OTT 오리지널 콘텐츠 제작팀 프리랜서 계약 [3]",
  "직업사전·구인구직 사이트를 통해 음향감독·녹음기사 채용 공고를 확인하여 지원 [4]"
];
// [1]=kmdb, [2]=kbatv, [3]=hscpa ott

const training = [
  "서울필름아카데미 PBL 현장음향감독 과정 — 이론+실습+작품과정 16주 [1]",
  "한국방송예술진흥원(한예진) 방송음향기술과 2년제 과정 [2]",
  "대림대학교 방송음향기술과 — NCS 기반 현장 실습 중심 교육 [3]",
  "미디어액트 동시녹음 실전 과정 — 단기 집중 실습 [4]"
];
// [1]=seoulfilm, [2]=kbatv, [3]=dept.daelim, [4]=mediact

const sources = {
  "way": [
    { "idx": 1, "url": "https://www.kmdb.or.kr/story/7/612", "text": "KMDB — 붐 오퍼레이터: 현장의 소리를 담는 사람", "fieldKey": "way" },
    { "idx": 2, "url": "https://www.seoulfilmacademy.com/sound-director", "text": "서울필름아카데미 — 영상음향감독 과정 소개", "fieldKey": "way" },
    { "idx": 3, "url": ASAMARU_JOB, "text": "직업백과 — 음향 및 녹음기사 직업정보", "fieldKey": "way" }
  ],
  "trivia": [
    { "idx": 1, "url": "https://www.kmdb.or.kr/story/7/612", "text": "KMDB — 붐 오퍼레이터 직업 스토리", "fieldKey": "trivia" },
    { "idx": 2, "url": "https://en.wikipedia.org/wiki/Sound_designer", "text": "Wikipedia — 사운드 디자이너: 촬영 현장에서 붐오퍼레이터 역할과 장비 기술", "fieldKey": "trivia" },
    { "idx": 3, "url": "https://lifebase.kr/blog/0321-ott-service-outlook-2026/", "text": "Lifebase — 2026 OTT 서비스 전망", "fieldKey": "trivia" },
    { "idx": 4, "url": "https://www.asiatime.co.kr/136414", "text": "아시아타임즈 — 영화음향감독 직업 소개", "fieldKey": "trivia" },
    { "idx": 5, "url": REALRECORDING, "text": "RealRecording — 동시녹음 현장 일기 1", "fieldKey": "trivia" }
  ],
  "detailWlb.wlbDetail": [
    { "idx": 1, "url": ASAMARU_JOB, "text": "직업백과 — 음향 및 녹음기사 근무환경", "fieldKey": "detailWlb.wlbDetail" },
    { "idx": 2, "url": ASAMARU_DIC, "text": "직업사전 — 녹음기사 고용 현황", "fieldKey": "detailWlb.wlbDetail" },
    { "idx": 3, "url": "https://munch.press/content/250718013", "text": "MUNCH.press — 사운드 분야 연봉 및 직업 정보", "fieldKey": "detailWlb.wlbDetail" }
  ],
  "detailWlb.socialDetail": [
    { "idx": 1, "url": "https://www.kmdb.or.kr/story/7/612", "text": "KMDB — 현장녹음기사 직업 의미", "fieldKey": "detailWlb.socialDetail" },
    { "idx": 2, "url": "https://www.hscpa.co.kr/forum/view/1329977", "text": "HSC파트너스 — K-콘텐츠 글로벌 수요 동향", "fieldKey": "detailWlb.socialDetail" }
  ],
  "overviewAbilities.technKnow": [
    { "idx": 1, "url": "https://www.kmdb.or.kr/story/7/612", "text": "KMDB — 현장녹음기사 장비 및 기술 실무", "fieldKey": "overviewAbilities.technKnow" },
    { "idx": 2, "url": "https://www.seoulfilmacademy.com/sound-director", "text": "서울필름아카데미 — 음향감독 필요기술", "fieldKey": "overviewAbilities.technKnow" },
    { "idx": 3, "url": "https://en.wikipedia.org/wiki/Boom_operator_(media)", "text": "Wikipedia — Boom operator 직업 기술 설명", "fieldKey": "overviewAbilities.technKnow" },
    { "idx": 4, "url": "https://www.studiobinder.com/blog/what-is-a-boom-operator-in-film-job-description/", "text": "StudioBinder — 붐오퍼레이터 직업 설명", "fieldKey": "overviewAbilities.technKnow" }
  ],
  "detailReady.curriculum": [
    { "idx": 1, "url": "https://dept.daelim.ac.kr/bsm/cms/FrCon/index.do?MENU_ID=70", "text": "대림대학교 방송음향기술과 — 교육과정", "fieldKey": "detailReady.curriculum" },
    { "idx": 2, "url": "https://mediact.org/web/education/lecture_view.php?code=Education&mode=View&bbid=EDUCATION_LECTURE&nums=1967", "text": "미디어액트 — 동시녹음 실전 완성 교육", "fieldKey": "detailReady.curriculum" },
    { "idx": 3, "url": "https://www.seoulfilmacademy.com/sound-director", "text": "서울필름아카데미 — 음향감독 교육과정", "fieldKey": "detailReady.curriculum" },
    { "idx": 4, "url": "https://www.kmdb.or.kr/story/7/612", "text": "KMDB — 현장 보조 경력 성장 경로", "fieldKey": "detailReady.curriculum" }
  ],
  "detailReady.recruit": [
    { "idx": 1, "url": "https://www.kmdb.or.kr/story/7/612", "text": "KMDB — 영화 현장 음향팀 입문 경로", "fieldKey": "detailReady.recruit" },
    { "idx": 2, "url": "https://kbatv.org/dept/dept.asp?dcode=108", "text": "한국방송예술진흥원 — 방송음향기술과 취업 분야", "fieldKey": "detailReady.recruit" },
    { "idx": 3, "url": "https://www.hscpa.co.kr/forum/view/1329977", "text": "HSC파트너스 — OTT 드라마 제작 증가와 기술인력 수요", "fieldKey": "detailReady.recruit" },
    { "idx": 4, "url": ASAMARU_DIC, "text": "직업사전 — 녹음기사 직업 개요 및 입직 경로", "fieldKey": "detailReady.recruit" }
  ],
  "detailReady.training": [
    { "idx": 1, "url": "https://www.seoulfilmacademy.com/sound-director", "text": "서울필름아카데미 — PBL 현장음향감독 과정", "fieldKey": "detailReady.training" },
    { "idx": 2, "url": "https://kbatv.org/dept/dept.asp?dcode=108", "text": "한국방송예술진흥원 방송음향기술과 — 2년제 학위 과정", "fieldKey": "detailReady.training" },
    { "idx": 3, "url": "https://dept.daelim.ac.kr/bsm/cms/FrCon/index.do?MENU_ID=70", "text": "대림대학교 방송음향기술과 교육과정", "fieldKey": "detailReady.training" },
    { "idx": 4, "url": "https://mediact.org/web/education/lecture_view.php?code=Education&mode=View&bbid=EDUCATION_LECTURE&nums=1967", "text": "미디어액트 — 동시녹음 실전 단기 과정", "fieldKey": "detailReady.training" }
  ],
  "overviewProspect.main": [
    { "idx": 1, "url": ASAMARU_JOB, "text": "직업백과 — 음향 및 녹음기사 직업정보", "fieldKey": "overviewProspect.main" },
    { "idx": 2, "url": "https://www.hscpa.co.kr/forum/view/1329977", "text": "HSC파트너스 — K-드라마 제작 산업 동향", "fieldKey": "overviewProspect.main" },
    { "idx": 3, "url": "https://en.wikipedia.org/wiki/Production_sound_mixer", "text": "Wikipedia — Production sound mixer 직업 소개", "fieldKey": "overviewProspect.main" },
    { "idx": 4, "url": ASAMARU_SOUND_DIRECTOR, "text": "직업사전 — 음향감독 직업 정보", "fieldKey": "overviewProspect.main" },
    { "idx": 5, "url": MIXING_CO, "text": "Mixing.co.kr — 음향 전공 진로 방향", "fieldKey": "overviewProspect.main" }
  ]
};

const payload = {
  fields: {
    way: way,
    overviewWork: {
      main: "시나리오를 분석하여 장면별 녹음 전략을 수립하고, 촬영 시작 전 레코더·마이크·무선 라발리에 시스템을 점검·세팅한다. 촬영 중에는 레코더를 조작하여 대사 신호 레벨을 모니터링하고, 붐오퍼레이터와 무선으로 소통하며 최적의 수음 품질을 유지한다. 장면 간 동선 변화에 따른 마이크 배치를 조정하고, 예상치 못한 외부 소음(사이렌·항공기·풍음)이 발생하면 즉시 촬영 중단 여부를 감독에게 보고한다. 촬영 종료 후에는 일일 녹음 파일을 정리·백업하고, 더빙이 필요한 장면을 표시하여 후반작업팀에 전달한다.",
      workStrong: "중간 정도의 작업",
      workPlace: "실내외",
      physicalAct: "언어력|청각"
    },
    overviewProspect: { main: overviewProspectMain },
    overviewAbilities: {
      technKnow: technKnow,
      eduLevel: "12년 초과 ~ 14년 이하(전문대졸 정도)",
      skillYear: "2년 초과 ~ 4년 이하"
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
    sidebarCerts: [],
    sidebarOrgs: [],
    youtubeLinks: [],
    _youtubeSearchNote: "유튜브 '동시녹음기사 직업 소개' 3건(현직자 브이로그), '붐오퍼레이터 현장 인터뷰' 2건, '현장녹음기사 실무' 1건(강의), '동시녹음 장비 설명' 4건(유튜버), '음향감독 진로 소개' 2건, '사운드믹서 직업' 1건 검색 확인 — 공식 직업 소개 채널 없음 (2026-06-10)"
  },
  sources: sources,
  changeSummary: "[job-data-master] 동시녹음기사 신규 enhance: way/overviewWork/overviewProspect/overviewAbilities/trivia/detailWlb/detailReady 전 영역 신규 작성, 출처 18개 이상 등록"
};

const outPath = __dirname + '/payload_동시녹음기사_final.json';
fs.writeFileSync(outPath, JSON.stringify(payload, null, 2), 'utf8');
console.log('Written:', outPath);

const allUrls = [];
Object.values(sources).forEach(arr => { if(Array.isArray(arr)) arr.forEach(s => allUrls.push(s.url)); });
const distinct = [...new Set(allUrls)];
console.log('distinct URLs:', distinct.length);
distinct.forEach(u => console.log(' -', u));
