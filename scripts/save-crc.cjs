'use strict';
// 임상시험코디네이터 데이터 저장 (UTF-8 안전)
const ID = '1765283658228622';
const API = `https://careerwiki.org/api/job/${ID}/edit`;
const HEADERS = {
  'Content-Type': 'application/json',
  'X-Admin-Secret': 'careerwiki-admin-2026',
};

const payload = {
  fields: {
    way: '임상시험코디네이터(CRC)가 되려면 전문학사 이상의 학위가 기본 자격이며, 전공 제한은 없지만 간호학·임상병리학·약학·생명과학 계열 졸업자가 취업에 유리하다. 취업 후에는 식약처가 지정한 교육기관에서 신규자 교육 20시간 이상을 이수해야 실무 투입이 가능하며, 실무 경력 3년 이상이면 KONECT(국가임상시험지원재단)의 CCRC 자격인증에 응시해 전문성을 공식 인정받을 수 있다.[1] 취업 경로는 대학병원 임상시험센터 직고용, SMO(임상시험실시기관 지원 업체), CRO(임상시험수탁기관) 세 가지로 나뉘며, 경력을 쌓은 후 CRA(임상시험모니터요원)로 전직하는 경우도 많다.[2]',
    trivia: '2023년 국내 임상시험 승인 건수는 783건으로 2022년 대비 10.1% 증가했으며, 한국은 국가별 임상시험 건수 세계 4위, 서울은 전 세계 도시 중 임상시험 실시 건수 1위를 기록해 글로벌 임상시험 허브로 자리잡았다.[1]',
    overviewProspect: {
      main: '국내 임상시험 승인 건수는 2023년 783건으로 세계 4위를 기록했고, 서울은 전 세계 도시 중 임상시험 건수 1위다.[1] 제약·바이오 신약 개발 투자가 확대되면서 CRC 수요도 꾸준히 증가하고 있으나, 숙련된 CRC 인력이 부족해 전문 인력 양성에 집중적인 투자가 필요하다는 업계 평가가 이어지고 있어 향후 처우 개선 및 채용 기회 확대가 기대된다.[2]',
    },
    detailReady: {
      curriculum: [
        '간호학과를 졸업하고 간호사 면허를 취득하면 대학병원 임상시험센터 취업 경쟁에서 유리하다',
        '임상병리학과·보건관리학과 등 보건의료 계열에서 임상 관련 전공 지식 기반을 쌓을 수 있다',
        '생명과학과·약학과 졸업 후 CRO 기업 취업으로 CRC 실무 경력을 시작하는 경로도 많다',
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
    detailWlb: {
      wlbDetail: '대학병원 임상시험센터·SMO 소속 CRC는 주 5일 근무가 기본이나, 시험대상자 방문 일정과 CRA 모니터링 일정에 따라 근무 시간이 유동적이다. 담당 프로토콜 수가 많거나 임상시험 집중 일정 시기에는 연장 근무가 발생할 수 있으며, 응급 상황 발생 시 즉각 대응이 필요한 경우도 있다.[1]',
      socialDetail: 'CRC는 임상시험 참여 환자(시험대상자)가 안전하게 프로토콜을 이행하도록 전 과정을 보조하며, 신약의 안전성·유효성 검증에 핵심적으로 기여한다. 국내 임상시험의 국제적 신뢰도 향상과 신약 개발 기간 단축에 직접 영향을 미친다.[1]',
      wlb: '보통',
      social: '높음',
    },
    sidebarCerts: [
      { name: 'QCRC 자격증 (Qualified CRC)', url: 'https://lms.konect.or.kr/web/intro/authenticationInfo.do' },
      { name: 'CCRC 자격증 (Certified CRC)', url: 'https://lms.konect.or.kr/web/intro/authenticationInfo.do' },
    ],
    sidebarMajors: ['간호학과', '임상병리학과', '약학과', '생명과학과', '보건관리학과'],
    sidebarOrgs: [
      { name: '국가임상시험지원재단(KONECT)', url: 'https://www.konect.or.kr' },
      { name: '한국임상연구코디네이터회(KACRC)', url: 'https://www.kacrc.or.kr/' },
    ],
    heroTags: ['임상연구간호사', 'CRC', '연구코디네이터', '연구간호사', 'SMO 연구원'],
  },
  sources: {
    way: [
      { id: 1, text: '국가임상시험지원재단(KONECT) 임상교육원 자격제 안내', url: 'https://lms.konect.or.kr/web/intro/authenticationInfo.do' },
      { id: 2, text: 'CRC를 하고 싶은 당신을 위한 임상시험 코디네이터(CRC)의 일상', url: 'https://clinicaltrialtools.com/crc%EB%A5%BC-%ED%95%98%EA%B3%A0-%EC%8B%B6%EC%9D%80-%EB%8B%B9%EC%8B%A0%EC%9D%84-%EC%9C%84%ED%95%9C-%EC%9E%84%EC%83%81%EC%8B%9C%ED%97%98-%EC%BD%94%EB%94%94%EB%84%A4%EC%9D%B4%ED%84%B0crc%EC%9D%98/' },
    ],
    trivia: [
      { id: 1, text: '메디컬월드뉴스, 2023년 국내 임상시험 승인 건수 783건…전 세계 점유율 4위', url: 'https://medicalworldnews.co.kr/m/view.php?idx=1510960976' },
    ],
    'overviewProspect.main': [
      { id: 1, text: '메디컬월드뉴스, 2023년 국내 임상시험 승인 건수 783건…전 세계 점유율 4위', url: 'https://medicalworldnews.co.kr/m/view.php?idx=1510960976' },
      { id: 2, text: '헬스코리아뉴스, 코로나가 몰고 온 글로벌 CRO 시장의 지각변동', url: 'https://www.hkn24.com/news/articleView.html?idxno=320068' },
    ],
    'detailReady.curriculum': [
      { id: 1, text: '국가임상시험지원재단(KONECT) 임상교육원 자격제 안내', url: 'https://lms.konect.or.kr/web/intro/authenticationInfo.do' },
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
    'detailWlb.wlbDetail': [
      { id: 1, text: 'CRC를 하고 싶은 당신을 위한 임상시험 코디네이터(CRC)의 일상', url: 'https://clinicaltrialtools.com/crc%EB%A5%BC-%ED%95%98%EA%B3%A0-%EC%8B%B6%EC%9D%80-%EB%8B%B9%EC%8B%A0%EC%9D%84-%EC%9C%84%ED%95%9C-%EC%9E%84%EC%83%81%EC%8B%9C%ED%97%98-%EC%BD%94%EB%94%94%EB%84%A4%EC%9D%B4%ED%84%B0crc%EC%9D%98/' },
    ],
    'detailWlb.socialDetail': [
      { id: 1, text: '국가임상시험지원재단(KONECT) CRC 소개', url: 'https://www.konect.or.kr' },
    ],
  },
  changeSummary: '임상시험코디네이터 데이터 고도화: way/trivia/overviewProspect/detailReady/detailWlb/sidebarCerts/sidebarMajors/sidebarOrgs/heroTags 신규 작성',
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
