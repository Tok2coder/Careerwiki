#!/usr/bin/env node
// sidebarCerts 데이터 오염 sweep
// 휴리스틱: 자격증 도메인 vs 직업 도메인 mismatch 검출

const fs = require('fs');
const path = require('path');

const data = JSON.parse(fs.readFileSync(path.resolve(__dirname, '..', '.allcerts.json'), 'utf8'));
const rows = data[0].results;

// 직업 도메인 카테고리 — slug 기반 매핑
const JOB_DOMAIN = {
  // 사회복지/심리/교육복지
  social_welfare: ['사회복지', '청소년상담', '심리상담', '심리상담전문가', '보육교사', '특수학교교사', '특수교사', '직업상담사', '청소년지도사'],
  // 의료
  medical: ['의사', '치과의사', '치과위생사', '치과기공사', '약사', '병원약사', '약국약사', '간호', '간호사', '간호조무사',
            '한의', '조산사', '응급구조사', '임상병리사', '방사선사', '물리치료사', '작업치료사', '언어치료사', '안경사',
            '보건교사', '병원관리자', '재활의학과', '소아청소년과', '응급의학과', '정신건강의학', '공중보건의사',
            '내과의사', '외과의사', '산부인과의사', '피부과의사', '안과의사', '이비인후과의사', '성형외과의사',
            '가정의학과의사', '운동처방사', '운동감독', '스포츠트레이너', '스포츠심리', '스포츠강사'],
  // 항공
  aviation: ['항공기조종사', '항공교통관제사', '항공기객실승무원', '항공공학기술자', '드론'],
  // 공학·기술
  engineering: ['공학기술자', '플랜트', '재료공학', '금속공학', '화학공학', '전기공학', '전자공학', '자동차공학',
                '조선공학', '토목공학', '토목감리', '토목안전', '섬유공학', '식품공학', '건축공학', '건축감리',
                '원자력', '반도체', '로봇', '기계', '산업용기계설계', '제품디자이너', '인테리어디자이너',
                '도시계획', '환경영향평가', '환경기술자', '안전관리'],
  // IT·디지털
  it: ['프로그래머', '개발자', '엔지니어', 'AI', '인공지능', '데이터', 'IT', 'UX', 'UI', '블록체인',
       '메타버스', '게임', '시스템', '네트워크', '클라우드', '보안', '정보보안', '빅데이터', 'IoT', 'RPA',
       'GIS', '디지털', '버추얼스트리머', '숏폼', 'esports', 'e스포츠'],
  // 미디어·콘텐츠 (기자·PD·작가·방송)
  media: ['기자', '편집기자', '잡지기자', '사진기자', '방송연출가', '드라마프로듀서', '예능프로그램프로듀서',
          '아나운서', '방송기자', '리포터', '쇼핑호스트', '드라마작가', '방송작가', '구성작가', '시나리오작가',
          '게임시나리오작가', '카피라이터', '광고기획자', '편집-디자이너', '편집기자', '평론가',
          '디지털크리에이터', '컴퓨터애니메이션감독', '촬영감독', '음향감독', '조명감독', '영화감독',
          '영상편집기자', '게임개발프로듀서', '디지털인플루언서관리자', '웹툰배경작가', '웹툰작가', '웹툰번역가',
          '출판편집자'],
  // 예술·디자인·창작
  art: ['만화가', '서예가', '조각가', '화가', '사진작가', '일러스트레이터', '그래픽디자이너', '시각디자이너',
        '디자이너', '안무가', '무용가', '패션모델', '패션코디네이터', '패션어드바이저', '스타일리스트',
        '공예가', '공예원', '도자기제조원', '귀금속', '플로리스트'],
  // 음악·연기
  performing: ['지휘자', '성악가', '국악인', '작곡가', '작사가', '가수', '대중가수', '뮤지컬배우', '연기자',
               '연극연출가', '연극제작자', '희극배우', '레이싱모델', '모델', '광고모델', '성우', '기악연주자',
               '심판'],
  // 금융·법조·전문직
  finance_law: ['검사', '판사', '변호사', '법무사', '노무사', '관세사', '세무사', '회계사', '감정평가사',
                '손해사정사', '보험계리사', '보험설계사', '재무설계사', '재무관리자', '금융관리자',
                '벤처캐피탈', '외환딜러', '애널리스트', '주식시장투자', '은행', '국제투자기획원',
                '최고재무책임자', '최고마케팅책임자', '경영컨설턴트', 'IT-컨설턴트', '변리사'],
  // 외식·요리
  culinary: ['한식조리사', '양식조리사', '일식조리사', '중식조리사', '주방장', '바리스타', '소믈리에',
             '바텐더', '요리연구가', '제과제빵사', '식품공학기술자'],
  // 미용·외양
  beauty: ['미용사', '네일아티스트', '피부관리사', '메이크업아티스트', '뷰티매니저', '조향사', '헤어'],
  // 외교·공직·운송
  public_transport: ['외교관', '공무원', '사회복지전담공무원', '법원공무원', '청원경찰', '경찰관', '해양경찰관',
                     '교도관', '경호원', '소방관', '직업군인', '부사관', '위관급장교',
                     '택시운전기사', '버스운전기사', '집배원', '우편물집배원', '택배원', '퀵배달원',
                     '선박기관사', '철도여행상품개발원'],
  // 여행·관광·서비스
  travel_service: ['여행안내원', '관광통역안내원', '호텔지배인', '항공기객실승무원', '비행기승무원',
                   '여행상품개발', '관광', '웨딩플래너', '국제회의전문가', '선물큐레이터', '박물관관리자',
                   '학예사', '문화재보존원', '비서', '총무사무원', '경리사무원', '총무인사관리자',
                   '직업상담사'],
  // 농림수산
  agri: ['양사육사', '곤충식품연구원', '동물조련사', '반려동물', '가축사육자', '곡식작물재배자',
         '해양수산기술자'],
  // 연구·학자
  research: ['연구원', '학자', '교수', '대학교수', '학원강사', '입학사정관'],
  // 마케팅·기획·관리
  marketing: ['마케터', '마케팅', '브랜드', '개인브랜드매니저', '상품기획자', '창업기획자', '기업고위임원',
              '헤드헌터', '고객관리시스템', 'CRM', '인사', '경영컨설턴트'],
  // 종교·문학
  religion_lit: ['목사', '신부', '승려', '성직자', '시인', '소설가', '극작가', '각색작가'],
  // 물류·서비스
  logistics: ['물류관리사'],
};

// 자격증 도메인 카테고리 — name 키워드 매칭
const CERT_DOMAIN_RULES = [
  { domain: 'social_welfare', keywords: ['사회복지사', '직업상담사', '청소년상담사', '청소년지도사', '심리상담', '임상심리사', '정신건강', '정신보건', '언어재활사', 'BCBA', 'ACT', '특수교사', '특수교육', '재활상담사', '장애인재활', '요양보호사', '보육교사', '한국코치협회', '국제코칭연맹', 'KAC', 'KPC', 'KSC', 'PCC', 'MCC'] },
  { domain: 'medical_strict', keywords: ['의사면허', '치과의사', '한의사', '약사면허', '간호사면허', '간호조무사', '조산사', '응급구조사', '임상병리사', '방사선사', '물리치료사', '작업치료사', '언어치료사', '안경사', '보건교사', '의무기록사', '치과위생사', '치과기공사', '병원감염', 'BLS', 'BCLS', 'ACLS', '소생술', '심폐소생', '전문의', 'BCM'] },
  { domain: 'aviation', keywords: ['운송용 조종사', '사업용 조종사', '계기비행', '항공영어', '항공무선통신사', '항공정비사', '경량항공기', '드론'] },
  { domain: 'culinary', keywords: ['한식조리', '양식조리', '일식조리', '중식조리', '복어조리', '제과', '제빵', '조주기능사', '소믈리에', '소믈리에시험', '식품기사', '영양사', '위생사', '바리스타'] },
  { domain: 'beauty', keywords: ['미용사', '이용사', '네일아트', '피부미용', '메이크업', '두피관리', '뷰티'] },
  { domain: 'driving', keywords: ['운전면허', '대형면허', '특수면허', '버스운전', '택시운전', '제2종', '제1종'] },
  { domain: 'engineering_eng', keywords: ['전기기사', '전자기사', '기계기사', '화학공학기사', '토목기사', '건축기사', '재료기사', '금속재료', '조선기사', '자동차정비', '소방기술사', '품질경영기사', '위험물', '소방설비', '에너지관리'] },
  { domain: 'it', keywords: ['정보처리기사', 'SQLD', 'ADsP', 'AICE', '정보보안', '리눅스마스터', '네트워크관리사', '클라우드', '데이터분석', 'AWS', 'CKA', 'OCJP', 'OCP'] },
  { domain: 'design', keywords: ['시각디자인', '제품디자인', '컬러리스트', 'GTQ', '웹디자인', '컴퓨터그래픽스'] },
  { domain: 'agri_animal', keywords: ['축산기사', '동물조련사', '반려동물', '식육처리', '수의', '농업기사'] },
];

// 광범위/다용도 자격증 (어떤 직업에도 등장 가능 — 의심 안 함)
const UNIVERSAL_CERTS = ['컴퓨터활용능력', '한국사', 'TOEIC', 'TEPS', 'HSK', 'JLPT', 'OPIc', '워드프로세서',
                         'MOS', 'GTQ', '국제회의기획사', 'PMP', '프레젠테이션',
                         '공인중개사', '경영지도사', 'MBA'];

function classifyJob(slug) {
  for (const [domain, keywords] of Object.entries(JOB_DOMAIN)) {
    for (const kw of keywords) {
      if (slug.includes(kw)) return domain;
    }
  }
  return 'unknown';
}

function classifyCert(name) {
  if (!name || typeof name !== 'string') return 'unknown';
  // Universal first
  for (const u of UNIVERSAL_CERTS) {
    if (name.includes(u)) return 'universal';
  }
  for (const rule of CERT_DOMAIN_RULES) {
    for (const kw of rule.keywords) {
      if (name.includes(kw)) return rule.domain;
    }
  }
  return 'unknown';
}

// 도메인 호환성 매트릭스 — 직업이 자격증 도메인을 받아들일 수 있는가
const COMPATIBLE = {
  social_welfare: ['social_welfare'],
  medical: ['medical_strict', 'social_welfare'],  // 의료가 사회복지 자격 보조 가능
  aviation: ['aviation'],
  engineering: ['engineering_eng', 'it'],
  it: ['it'],
  media: [],  // 미디어 직업은 일반자격증 가능 (universal 별도)
  art: ['design'],
  performing: [],
  finance_law: [],
  culinary: ['culinary', 'beauty'],  // 외식엔 미용 안 와야 — culinary만
  beauty: ['beauty'],
  public_transport: ['driving'],
  travel_service: [],
  agri: ['agri_animal'],
  research: [],
  marketing: [],
  religion_lit: [],
  logistics: [],
};

// 검사
const suspects = [];
for (const r of rows) {
  const certs = JSON.parse(r.sc);
  const jobDomain = classifyJob(r.slug);
  const issues = [];
  for (const cert of certs) {
    const certDomain = classifyCert(cert.name);
    if (certDomain === 'universal') continue;
    if (certDomain === 'unknown') continue;  // 분류 못한 자격증은 검사 보류 (사용자 검토 권장)
    const compatible = (COMPATIBLE[jobDomain] || []).includes(certDomain) || certDomain === jobDomain;
    if (!compatible) {
      issues.push({ name: cert.name, certDomain, jobDomain, reason: `자격증 도메인 '${certDomain}' ≠ 직업 도메인 '${jobDomain}'` });
    }
  }
  if (issues.length > 0) {
    suspects.push({ slug: r.slug, jobDomain, allCerts: certs.map(c=>c.name), issues });
  }
}

console.log(`\n=== 의심 케이스 ${suspects.length}개 ===\n`);
for (const s of suspects) {
  console.log(`■ ${s.slug} (jobDomain=${s.jobDomain})`);
  console.log(`   현재 sidebarCerts: [${s.allCerts.join(', ')}]`);
  for (const iss of s.issues) {
    console.log(`   ❌ "${iss.name}" → ${iss.reason}`);
  }
  console.log();
}

console.log(`\n=== 직업 도메인 분류 통계 ===`);
const domainCount = {};
for (const r of rows) {
  const d = classifyJob(r.slug);
  domainCount[d] = (domainCount[d]||0)+1;
}
for (const [d,c] of Object.entries(domainCount).sort((a,b)=>b[1]-a[1])) {
  console.log(`  ${d}: ${c}`);
}

console.log(`\n=== 자격증 도메인 분류 통계 ===`);
const certCount = {};
let totalCerts = 0;
for (const r of rows) {
  const certs = JSON.parse(r.sc);
  for (const c of certs) {
    const d = classifyCert(c.name);
    certCount[d] = (certCount[d]||0)+1;
    totalCerts++;
  }
}
console.log(`  total cert entries: ${totalCerts}`);
for (const [d,c] of Object.entries(certCount).sort((a,b)=>b[1]-a[1])) {
  console.log(`  ${d}: ${c}`);
}
