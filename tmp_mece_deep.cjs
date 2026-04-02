const fs = require('fs');
const d = JSON.parse(fs.readFileSync('tmp_all_jobs.json', 'utf8'));
const jobs = d[0]?.results || [];
const names = jobs.map(j => j.name);

console.log('=== 의미적 중복 정밀 분석 ===\n');

// 1. "(일반)" 변형 패턴 — "X" 와 "X(일반)" 공존
const generalPairs = [];
const nameSet = new Set(names);
for (const n of names) {
  if (n.endsWith('(일반)')) {
    const base = n.replace('(일반)', '').trim();
    if (nameSet.has(base)) {
      generalPairs.push({ base, variant: n });
    }
  }
}
console.log('1. "X" ↔ "X(일반)" 공존 (' + generalPairs.length + '쌍)');
generalPairs.forEach(p => console.log(`  "${p.base}" ↔ "${p.variant}"`));

// 2. 괄호 변형 — 같은 직업의 다른 표현
const bracketJobs = names.filter(n => n.includes('(') && n.includes(')'));
const bracketGroups = {};
for (const n of bracketJobs) {
  const base = n.replace(/\(.*?\)/g, '').trim();
  if (base.length >= 2) {
    if (!bracketGroups[base]) bracketGroups[base] = [];
    bracketGroups[base].push(n);
  }
}
// 괄호 제거 후 base가 같은데 원본도 존재하는 경우
console.log('\n2. 괄호 변형 — 동일 base 다른 괄호 (2개+)');
const bracketDups = Object.entries(bracketGroups)
  .filter(([k, v]) => v.length >= 2 || (v.length >= 1 && nameSet.has(k)))
  .sort((a, b) => b[1].length - a[1].length);
bracketDups.slice(0, 30).forEach(([base, variants]) => {
  const hasBase = nameSet.has(base);
  console.log(`\n  [${base}] ${hasBase ? '(base도 존재)' : ''}`);
  if (hasBase) console.log(`    - ${base}`);
  variants.forEach(v => console.log(`    - ${v}`));
});
console.log('  총:', bracketDups.length, '그룹');

// 3. 영문/한글 혼용 — 같은 직업 다른 표기
console.log('\n3. 영문/한글 혼용 의심 쌍');
const engKorMap = {
  'UX': '사용자경험', 'UI': '사용자인터페이스', 'AI': '인공지능',
  'VR': '가상현실', 'AR': '증강현실', 'IoT': '사물인터넷',
  'IT': '정보기술', 'SW': '소프트웨어', 'HW': '하드웨어',
  'QA': '품질보증', 'CEO': '최고경영자', 'CFO': '최고재무책임자',
  'CTO': '최고기술책임자', 'PM': '프로젝트매니저',
  'MD': '머천다이저', 'PD': '프로듀서',
};
for (const [eng, kor] of Object.entries(engKorMap)) {
  const engJobs = names.filter(n => n.includes(eng));
  const korJobs = names.filter(n => n.includes(kor));
  if (engJobs.length > 0 && korJobs.length > 0) {
    console.log(`\n  [${eng} / ${kor}]`);
    engJobs.slice(0, 5).forEach(n => console.log(`    ENG: ${n}`));
    korJobs.slice(0, 5).forEach(n => console.log(`    KOR: ${n}`));
  }
}

// 4. 세분화 과잉 — 하나의 직업이 너무 세분화된 경우
console.log('\n\n4. 과도한 세분화 (같은 도메인 10개+)');
const domainKeywords = [
  '도금', '용접', '압연', '선별', '조립', '검사원', '포장',
  '재단', '재봉', '인쇄', '연마', '절단', '세척', '도장',
  '전문의사', '판매원', '영업원', '관리원', '조작원', '운전원',
  '설계', '감독', '기능사', '기술자', '사무원', '안내원',
];
for (const kw of domainKeywords) {
  const matches = names.filter(n => n.includes(kw));
  if (matches.length >= 10) {
    console.log(`\n  "${kw}" 포함 직업: ${matches.length}개`);
    matches.slice(0, 5).forEach(n => console.log(`    - ${n}`));
    console.log(`    ... 외 ${matches.length - 5}개`);
  }
}

// 5. 진짜 의미적 중복 후보 (수동 검토 필요)
console.log('\n\n5. 의미적 중복 강력 후보 (같은 직업 다른 이름)');
const semanticDups = [
  ['기자', '리포터', '저널리스트'],
  ['프로그래머', '개발자', '엔지니어'],
  ['상담사', '상담원', '카운슬러'],
  ['디자이너', '설계사'],
  ['작가', '저술가', '라이터'],
  ['요리사', '셰프', '조리사'],
  ['가수', '보컬리스트', '싱어'],
  ['배우', '연기자', '액터'],
  ['의사', '전문의사', '전문의'],
  ['번역가', '번역사'],
  ['통역가', '통역사'],
  ['분석가', '분석사', '애널리스트'],
  ['감독', '디렉터'],
  ['관리자', '매니저'],
  ['기술자', '기사', '테크니션'],
  ['코디네이터', '조정원', '조율자'],
];

for (const group of semanticDups) {
  const found = {};
  for (const term of group) {
    found[term] = names.filter(n => n.endsWith(term) || n === term);
  }
  const totalFound = Object.values(found).filter(v => v.length > 0);
  if (totalFound.length >= 2) {
    console.log(`\n  === ${group.join(' / ')} ===`);
    for (const [term, matches] of Object.entries(found)) {
      if (matches.length > 0) {
        console.log(`  [${term}] ${matches.length}개`);
        matches.slice(0, 3).forEach(n => console.log(`    - ${n}`));
        if (matches.length > 3) console.log(`    ... 외 ${matches.length - 3}개`);
      }
    }
  }
}

// 6. "건설" vs "건축" — 유사 도메인
console.log('\n\n6. 유사 도메인 쌍');
const domainPairs = [
  ['건설', '건축'], ['전기', '전자'], ['기계', '기관'],
  ['화학', '화공'], ['토목', '건설'], ['의료', '보건'],
  ['컴퓨터', '전산'], ['통신', '정보'], ['광고', '마케팅'],
  ['금융', '보험'], ['해양', '수산'], ['항공', '우주'],
];
for (const [a, b] of domainPairs) {
  const aJobs = names.filter(n => n.startsWith(a));
  const bJobs = names.filter(n => n.startsWith(b));
  if (aJobs.length >= 3 && bJobs.length >= 3) {
    console.log(`\n  "${a}" (${aJobs.length}개) vs "${b}" (${bJobs.length}개)`);
    // 겹치는 suffix 찾기
    const aSuffix = new Set(aJobs.map(n => n.slice(a.length)));
    const bSuffix = new Set(bJobs.map(n => n.slice(b.length)));
    const overlap = [...aSuffix].filter(s => bSuffix.has(s) && s.length >= 2);
    if (overlap.length > 0) {
      console.log(`  겹치는 접미사 ${overlap.length}개:`);
      overlap.slice(0, 5).forEach(s => console.log(`    "${a}${s}" ↔ "${b}${s}"`));
    }
  }
}
