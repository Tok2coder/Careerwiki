'use strict';
// 3개 직업 curriculum 각주 보강 패치 (UTF-8 안전)
const API_BASE = 'https://careerwiki.org/api/job';
const HEADERS = {
  'Content-Type': 'application/json',
  'X-Admin-Secret': 'careerwiki-admin-2026',
};

const jobs = [
  {
    name: '임상시험코디네이터',
    id: '1765283658228622',
    payload: {
      fields: {
        detailReady: {
          curriculum: [
            '간호학과를 졸업하고 간호사 면허를 취득하면 대학병원 임상시험센터 취업 경쟁에서 유리하다',
            '임상병리학과·보건관리학과 등 보건의료 계열에서 임상 관련 전공 지식 기반을 쌓을 수 있다[2]',
            '생명과학과·약학과 졸업 후 CRO 기업 취업으로 CRC 실무 경력을 시작하는 경로도 많다[3]',
            '국가임상시험지원재단(KONECT) 임상교육원에서 신규 CRC 온라인 과정(20시간)을 이수하면 식약처 인정 교육으로 인정된다',
            'CCRC 자격인증 취득을 위해 실무 3년 이상 경력을 쌓으며 최소 24시간 종사자 보수교육을 이수해야 한다[1]',
          ],
          recruit: [
            '국가임상시험지원재단(KONECT) CRO 목록에서 국내외 CRO 기업을 확인하고 채용공고에 직접 지원한다[1]',
            '사람인·인크루트의 연구간호사·CRC 직종 카테고리에서 병원·SMO·CRO 채용 공고를 검색해 지원한다[2]',
            '서울대병원·서울아산병원·삼성서울병원 등 상급종합병원 임상시험센터 채용 페이지를 모니터링하며 지원한다[3]',
          ],
          training: [
            '국가임상시험지원재단(KONECT) 임상교육원 — 신규 CRC 온라인 과정(20시간, 식약처 인정), 종사자 보수교육 연간 운영[1]',
            '한국임상연구코디네이터회(KACRC) 보수교육 및 CCRC 자격인증 대비 교육 과정 운영[2]',
          ],
        },
      },
      sources: {
        'detailReady.curriculum': [
          { id: 1, text: '국가임상시험지원재단(KONECT) 임상교육원 자격제 안내', url: 'https://lms.konect.or.kr/web/intro/authenticationInfo.do' },
          { id: 2, text: 'CRC를 하고 싶은 당신을 위한 임상시험 코디네이터(CRC)의 일상', url: 'https://clinicaltrialtools.com/crc%EB%A5%BC-%ED%95%98%EA%B3%A0-%EC%8B%B6%EC%9D%80-%EB%8B%B9%EC%8B%A0%EC%9D%84-%EC%9C%84%ED%95%9C-%EC%9E%84%EC%83%81%EC%8B%9C%ED%97%98-%EC%BD%94%EB%94%94%EB%84%A4%EC%9D%B4%ED%84%B0crc%EC%9D%98/' },
          { id: 3, text: '한국임상연구코디네이터회(KACRC)', url: 'https://www.kacrc.or.kr/' },
        ],
        'detailReady.recruit': [
          { id: 1, text: '국가임상시험지원재단(KONECT) CRO 목록', url: 'https://www.konect.or.kr/kr/pages/cro/croAllList.do' },
          { id: 2, text: '사람인 취업포털', url: 'https://www.saramin.co.kr' },
          { id: 3, text: '인크루트 연구간호사(CRC) 채용정보', url: 'https://m.incruit.com/jobdb_list/searchjob.asp?ct=1&ty=3&cd=16836' },
        ],
        'detailReady.training': [
          { id: 1, text: '국가임상시험지원재단(KONECT) 임상교육원', url: 'https://lms.konect.or.kr/web/intro/authenticationInfo.do' },
          { id: 2, text: '한국임상연구코디네이터회(KACRC)', url: 'https://www.kacrc.or.kr/' },
        ],
      },
      changeSummary: '임상시험코디네이터 curriculum 각주 보강: items1-2블록→[2]/item3→[3]/items4-5블록→[1]',
    },
  },
  {
    name: '전문상담교사',
    id: '1765284026240706',
    payload: {
      fields: {
        detailReady: {
          curriculum: [
            '상담학과·심리학과·청소년 관련 학과에서 교직과정을 이수하면 2급 자격 취득이 가능하나, 학과 정원의 5~10%만 선발하므로 최상위권 학점(4.5 만점에 4.1 이상 추천)이 필요하다[1]',
            '교육대학원 상담교육 전공에 진학하면 2년 과정으로 비교적 안정적으로 2급 자격을 취득할 수 있어 대부분의 임용 준비자가 이 경로를 선택한다',
            '교육학과·심리학과·사회복지학과 등 관련 학과 졸업 후 교육대학원 진학으로 자격 취득이 가능하다[3]',
            '현직 교사 경력 3년 이상이면 교육대학원 1급 과정에 지원해 1급 전문상담교사 자격을 취득할 수 있다[4]',
            '임상심리사 2급·청소년상담사 등 상담 관련 국가자격증을 사전에 취득해두면 임용 면접에서 경쟁력을 높일 수 있다[2]',
          ],
          recruit: [
            '각 시도교육청 전문상담교사 임용시험 공고를 확인하고 해당 시도 선발 계획이 발표되는 즉시 준비를 시작한다[1]',
            '교육청 기간제 전문상담교사 채용공고에 지원해 Wee클래스 실무 경험을 쌓으며 정규 임용을 준비한다[2]',
            '사립학교 전문상담교사 채용 또는 사설 청소년상담기관·Wee센터에 취업해 경력을 축적하며 임용을 재도전하는 경로도 있다[3]',
          ],
          training: [
            '전국 주요 교육대학원 상담교육 전공 — 2년 과정, 전문상담교사 1급·2급 자격 취득 가능, 교직 이론·실습 이수 포함[1]',
            '한국상담심리학회(KRCPA) 상담심리사 자격 취득을 위한 수련 및 보수교육 과정, 한국청소년상담원(KYCI) 청소년상담사 자격 연수 과정 운영[2]',
          ],
        },
      },
      sources: {
        'detailReady.curriculum': [
          { id: 1, text: '전문상담교사가 되려면 (brunch 직업 칼럼)', url: 'https://brunch.co.kr/@kyleseling/3' },
          { id: 2, text: 'Q-net 전문상담교사 자격 안내', url: 'https://www.q-net.or.kr/crf005.do?id=crf00503&jmCd=0115' },
          { id: 3, text: '연세대학교 교육대학원 전문상담교사 자격증 안내', url: 'https://gse.yonsei.ac.kr/gse/license/t_counselor.do' },
          { id: 4, text: '찾기쉬운 생활법령정보, 전문상담교사 배치 및 전담기구 구성', url: 'https://easylaw.go.kr/CSP/CnpClsMain.laf?popMenu=ov&csmSeq=1408&ccfNo=2&cciNo=1&cnpClsNo=1' },
        ],
        'detailReady.recruit': [
          { id: 1, text: '찾기쉬운 생활법령정보, 전문상담교사 배치 및 전담기구 구성', url: 'https://easylaw.go.kr/CSP/CnpClsMain.laf?popMenu=ov&csmSeq=1408&ccfNo=2&cciNo=1&cnpClsNo=1' },
          { id: 2, text: '뉴시스, 학교 금쪽이 늘고 상담 대기 반년인데…채용 50%를 줄여?', url: 'https://www.newsis.com/view/NISX20240818_0002853284' },
          { id: 3, text: '전문상담교사가 되려면 (brunch 직업 칼럼)', url: 'https://brunch.co.kr/@kyleseling/3' },
        ],
        'detailReady.training': [
          { id: 1, text: '연세대학교 교육대학원 전문상담교사 자격증 안내', url: 'https://gse.yonsei.ac.kr/gse/license/t_counselor.do' },
          { id: 2, text: '한국청소년상담원(KYCI) 청소년상담사 자격연수·보수교육', url: 'https://www.kyci.or.kr/userSite/sub02_7_cont.asp' },
        ],
      },
      changeSummary: '전문상담교사 curriculum 각주 보강: item1→[1]/items2-3블록→[3]/item4→[4]/item5→[2]',
    },
  },
  {
    name: '세포배양기반대체식품연구원',
    id: '1765283971835349',
    payload: {
      fields: {
        detailReady: {
          curriculum: [
            '식품공학과·생명공학과·동물세포공학과 등 관련 학과에서 세포 배양·미생물학·식품가공학 기초 역량을 쌓고 학사 이상 학위를 취득한다',
            '대학원 석사·박사 과정에서 동물세포 배양·조직공학·식품 단백질 연구를 심화 전공하면 연구직 입직에 유리하다[2]',
            '식품기사·식품기술사 등 국가자격증을 취득하면 식품 연구기관·기업 취업 시 경쟁력이 높아진다[3]',
            '한국생명공학연구원(KRIBB) 인턴십이나 대학 부설 세포배양 실험실 참여로 현장 실험 경험을 쌓을 수 있다[4]',
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
      },
      sources: {
        'detailReady.curriculum': [
          { id: 1, text: '의성군 세포배양식품 규제자유특구 연구센터(USC)', url: 'https://usc.go.kr/cell/index.do' },
          { id: 2, text: '뉴스1, 국내 배양육 연구 현황', url: 'https://www.news1.kr/bio/pharmaceutical-bio/5462550' },
          { id: 3, text: 'Q-net 식품기사 자격 안내', url: 'https://www.q-net.or.kr/crf005.do?id=crf00503&jmCd=1530' },
          { id: 4, text: '한국생명공학연구원(KRIBB) 바이오인력양성센터', url: 'https://www.kribb.re.kr' },
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
      },
      changeSummary: '세포배양기반대체식품연구원 curriculum 각주 보강: items1-2블록→[2]/item3→[3]/item4→[4]/item5→[1]',
    },
  },
];

async function patchJob(job) {
  const url = `${API_BASE}/${job.id}/edit`;
  const res = await fetch(url, {
    method: 'POST',
    headers: HEADERS,
    body: JSON.stringify(job.payload),
  });
  const j = await res.json();
  if (j.success) console.log(`✅ ${job.name} 저장 완료 (revisionId: ${j.revisionId})`);
  else { console.error(`❌ ${job.name} 실패:`, j); process.exit(1); }
}

(async () => {
  for (const job of jobs) {
    await patchJob(job);
  }
})().catch(e => { console.error(e); process.exit(1); });
