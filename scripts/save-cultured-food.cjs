'use strict';
// 세포배양기반대체식품연구원 데이터 저장 (UTF-8 안전)
const ID = '1765283971835349';
const API = `https://careerwiki.org/api/job/${ID}/edit`;
const HEADERS = {
  'Content-Type': 'application/json',
  'X-Admin-Secret': 'careerwiki-admin-2026',
};

const payload = {
  fields: {
    way: '세포배양기반대체식품연구원이 되려면 식품공학·생명공학·동물세포공학 관련 학과의 학사 이상 학위가 기본 자격이며, 연구기관·기업에서는 석사·박사 학위 소지자를 우대하는 경우가 많다. 국내에서는 스페이스에프·다나그린 등 배양육 스타트업이나 한국생명공학연구원(KRIBB) 등 정부출연 연구기관에서 연구직으로 진입하는 경로가 주를 이룬다.[1] 분야 특성상 동물세포 배양 실험 역량이 핵심이며, 국내에서는 식약처의 배양육 상업 승인이 진행 중이어서 현재 대부분의 연구는 R&D 프로젝트 형태로 이루어진다.[2]',
    trivia: '배양육은 기존 축산업 대비 토지 사용을 최대 99%, 물 사용을 최대 96% 줄이고 온실가스 배출을 최대 92% 감소시키는 것으로 보고됐으며, 싱가포르는 2020년 세계 최초로 배양육 상업 판매를 승인해 글로벌 규제의 선례가 됐다.[1]',
    overviewProspect: {
      main: '글로벌 배양육 시장은 2026년 약 3억 달러 규모로 예상되며, 2035년까지 연평균 30% 이상의 성장세가 전망된다.[1] 국내에서는 식약처가 배양육 상업 승인 기준을 마련 중으로, 승인이 완료되면 관련 연구 인력 수요가 크게 증가할 것으로 업계는 기대하지만 현재는 R&D 단계 중심으로 정규직 채용 규모가 제한적이다.[2]',
    },
    detailReady: {
      curriculum: [
        '식품공학과·생명공학과·동물세포공학과 등 관련 학과에서 세포 배양·미생물학·식품가공학 기초 역량을 쌓고 학사 이상 학위를 취득한다',
        '대학원 석사·박사 과정에서 동물세포 배양·조직공학·식품 단백질 연구를 심화 전공하면 연구직 입직에 유리하다',
        '식품기사·식품기술사 등 국가자격증을 취득하면 식품 연구기관·기업 취업 시 경쟁력이 높아진다',
        '한국생명공학연구원(KRIBB) 인턴십이나 대학 부설 세포배양 실험실 참여로 현장 실험 경험을 쌓을 수 있다',
        '의성군 세포배양식품 규제자유특구 등 정부 R&D 사업에 연구보조원으로 참여해 배양육 특화 실무 역량을 갖춘다[1]',
      ],
      recruit: [
        '스페이스에프·다나그린 등 국내 배양육 스타트업의 채용 공고를 확인하고 연구직에 지원한다[1]',
        '한국생명공학연구원(KRIBB) 채용 페이지에서 세포배양·대체식품 관련 연구직 공고를 모니터링한다[2]',
        '사람인·잡코리아에서 \'배양육\', \'세포배양\', \'대체단백질\' 키워드로 스타트업·식품 연구기관 채용공고를 검색한다[3]',
      ],
      training: [
        '의성군 세포배양식품 규제자유특구 연구센터(USC) — 세포배양 기반 식품 R&D 프로그램 운영, 연구 인력 대상 교육 제공[1]',
        '한국생명공학연구원(KRIBB) 바이오인력양성센터 — 동물세포 배양·바이오의약 연구 기술 교육 과정 운영[2]',
      ],
    },
    detailWlb: {
      wlbDetail: '세포배양기반대체식품연구원은 실험실 중심으로 근무하며, 세포 배양 주기에 따라 주말·야간 점검이 필요한 경우가 있다. 스타트업 소속의 경우 소규모 팀이 여러 프로젝트를 동시에 담당하는 구조로 업무 강도가 높은 편이다.[1]',
      socialDetail: '세포배양기반대체식품연구원은 기존 축산업 대비 온실가스·토지·물 사용을 대폭 줄이는 대체 단백질 식품 개발을 주도하며, 식량 안보와 기후 위기 대응에 직접 기여한다.[1]',
      wlb: '보통 이하',
      social: '높음',
    },
    sidebarCerts: [
      { name: '식품기술사', url: 'https://www.q-net.or.kr' },
      { name: '식품기사', url: 'https://www.q-net.or.kr/crf005.do?id=crf00503&jmCd=1530' },
      { name: '식품산업기사', url: 'https://www.q-net.or.kr/crf005.do?id=crf00503&jmCd=2450' },
      { name: '식품가공기능사', url: 'https://www.q-net.or.kr' },
      { name: '식품영양사', url: 'https://www.kuksiwon.or.kr' },
    ],
    sidebarMajors: ['생명공학과', '생물학과', '식품공학과', '식품영양학과', '화학공학과', '축산학과'],
    sidebarOrgs: [
      { name: '한국생명공학연구원(KRIBB)', url: 'https://www.kribb.re.kr' },
      { name: '의성 세포배양식품 규제자유특구 연구센터(USC)', url: 'https://usc.go.kr/cell/index.do' },
    ],
    heroTags: ['식품연구원', '가공식품연구원', '대체단백질연구원', '대체지방연구원', '세포배양기조작원', '대체식품향미개선연구원', '배양육연구원'],
  },
  sources: {
    way: [
      { id: 1, text: '스페이스에프 기업 정보 (The VC)', url: 'https://thevc.kr/spacef' },
      { id: 2, text: '뉴스1, 국내 배양육 연구 현황', url: 'https://www.news1.kr/bio/pharmaceutical-bio/5462550' },
    ],
    trivia: [
      { id: 1, text: '헬스코리아뉴스, 배양육 글로벌 동향 리포트', url: 'https://www.hkn24.com/news/articleView.html?idxno=348201' },
    ],
    'overviewProspect.main': [
      { id: 1, text: '헬스코리아뉴스, 배양육 글로벌 동향 리포트', url: 'https://www.hkn24.com/news/articleView.html?idxno=348201' },
      { id: 2, text: '뉴스1, 국내 배양육 연구 현황', url: 'https://www.news1.kr/bio/pharmaceutical-bio/5462550' },
    ],
    'detailReady.curriculum': [
      { id: 1, text: '의성군 세포배양식품 규제자유특구 연구센터(USC)', url: 'https://usc.go.kr/cell/index.do' },
    ],
    'detailReady.recruit': [
      { id: 1, text: '스페이스에프 기업 정보 (The VC)', url: 'https://thevc.kr/spacef' },
      { id: 2, text: '한국생명공학연구원(KRIBB) 채용', url: 'https://www.kribb.re.kr/kor/sub03/sub03_01_01.jsp' },
      { id: 3, text: '사람인 취업포털', url: 'https://www.saramin.co.kr' },
    ],
    'detailReady.training': [
      { id: 1, text: '의성군 세포배양식품 규제자유특구 연구센터(USC)', url: 'https://usc.go.kr/cell/index.do' },
      { id: 2, text: '한국생명공학연구원(KRIBB) 바이오인력양성센터', url: 'https://www.kribb.re.kr' },
    ],
    'detailWlb.wlbDetail': [
      { id: 1, text: '스페이스에프 기업 정보 (The VC)', url: 'https://thevc.kr/spacef' },
    ],
    'detailWlb.socialDetail': [
      { id: 1, text: '헬스코리아뉴스, 배양육 글로벌 동향 리포트', url: 'https://www.hkn24.com/news/articleView.html?idxno=348201' },
    ],
  },
  changeSummary: '세포배양기반대체식품연구원 데이터 고도화: way/trivia/overviewProspect/detailReady/detailWlb/sidebarCerts URL 추가/sidebarMajors/sidebarOrgs/heroTags 보강',
};

fetch(API, {
  method: 'POST',
  headers: HEADERS,
  body: JSON.stringify(payload),
})
  .then(r => r.json())
  .then(j => {
    console.log('결과:', JSON.stringify(j, null, 2));
    if (j.success) console.log('✅ 저장 완료');
    else console.error('❌ 실패:', j);
  })
  .catch(e => { console.error(e); process.exit(1); });
