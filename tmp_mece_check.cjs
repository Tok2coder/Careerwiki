const fs = require('fs');
const d = JSON.parse(fs.readFileSync('tmp_all_jobs.json', 'utf8'));
const jobs = d[0]?.results || [];
console.log('전체 직업 수:', jobs.length);

// ============ 1. 접미사만 다른 그룹 ============
const suffixes = ['기술자','기능사','기사','연구원','전문가','분석가','관리자','설계사','기능장','산업기사','지도사','상담사','치료사','교사','강사','코치','컨설턴트','디자이너','엔지니어','프로그래머','개발자','운영자','감독관','감독','감리원','감리','검사원','조사원','시험원','평가원','사무원','계원','안내원','진행자','해설사','가이드','작가','기자','편집자','PD','원장','의사','약사','간호사','사서','판사','변호사','세무사','회계사','노무사','감정사','평가사','중개사','관리인'];
const groups = {};
for (const j of jobs) {
  let base = j.name;
  for (const s of suffixes) {
    if (base.endsWith(s) && base.length > s.length) {
      base = base.slice(0, -s.length).trim();
      break;
    }
  }
  if (base.length >= 2) {
    if (!groups[base]) groups[base] = [];
    groups[base].push(j.name);
  }
}
const bigGroups = Object.entries(groups).filter(([k, v]) => v.length >= 3).sort((a, b) => b[1].length - a[1].length);
console.log('\n========================================');
console.log('1. 같은 베이스 + 접미사만 다른 그룹 (3개+)');
console.log('========================================');
bigGroups.slice(0, 30).forEach(([base, names]) => {
  console.log(`\n[${base}] (${names.length}개)`);
  names.forEach(n => console.log('  - ' + n));
});
console.log('\n총 그룹 수:', bigGroups.length);

// ============ 2. 레벤슈타인 거리 2 이내 유사 이름 ============
function levenshtein(a, b) {
  const m = a.length, n = b.length;
  if (Math.abs(m - n) > 3) return 99; // early exit
  const dp = Array.from({ length: m + 1 }, () => new Array(n + 1).fill(0));
  for (let i = 0; i <= m; i++) dp[i][0] = i;
  for (let j = 0; j <= n; j++) dp[0][j] = j;
  for (let i = 1; i <= m; i++) {
    for (let j = 1; j <= n; j++) {
      dp[i][j] = a[i - 1] === b[j - 1]
        ? dp[i - 1][j - 1]
        : 1 + Math.min(dp[i - 1][j], dp[i][j - 1], dp[i - 1][j - 1]);
    }
  }
  return dp[m][n];
}

const names = jobs.map(j => j.name).sort();
const nearDups = [];
for (let i = 0; i < names.length; i++) {
  for (let j = i + 1; j < names.length; j++) {
    if (Math.abs(names[i].length - names[j].length) > 2) continue;
    const dist = levenshtein(names[i], names[j]);
    if (dist <= 2 && dist > 0) {
      nearDups.push({ a: names[i], b: names[j], dist });
    }
  }
}
console.log('\n========================================');
console.log('2. 레벤슈타인 거리 ≤2 유사 이름 쌍');
console.log('========================================');
nearDups.sort((a, b) => a.dist - b.dist);
nearDups.forEach(p => console.log(`  [거리${p.dist}] "${p.a}" ↔ "${p.b}"`));
console.log('총:', nearDups.length, '쌍');

// ============ 3. 포함 관계 (A가 B의 부분 문자열) ============
const containPairs = [];
for (let i = 0; i < names.length; i++) {
  for (let j = i + 1; j < names.length; j++) {
    if (names[j].includes(names[i]) && names[i].length >= 3 && names[i] !== names[j]) {
      containPairs.push({ short: names[i], long: names[j] });
    }
  }
}
console.log('\n========================================');
console.log('3. 포함 관계 (짧은 이름이 긴 이름에 포함)');
console.log('========================================');
// 짧은 이름 기준으로 그룹화
const containGroups = {};
for (const p of containPairs) {
  if (!containGroups[p.short]) containGroups[p.short] = [];
  containGroups[p.short].push(p.long);
}
const bigContainGroups = Object.entries(containGroups).filter(([k, v]) => v.length >= 3).sort((a, b) => b[1].length - a[1].length);
bigContainGroups.slice(0, 20).forEach(([short, longs]) => {
  console.log(`\n"${short}" 포함하는 직업 (${longs.length}개):`);
  longs.slice(0, 8).forEach(l => console.log('  - ' + l));
  if (longs.length > 8) console.log(`  ... 외 ${longs.length - 8}개`);
});

// ============ 4. 의미적 중복 후보 (동일 역할, 다른 이름) ============
console.log('\n========================================');
console.log('4. 의미적 중복 후보 (수동 검토 필요)');
console.log('========================================');
const semanticPatterns = [
  { pattern: /프로그래머|개발자|소프트웨어엔지니어|코더/, label: 'SW 개발' },
  { pattern: /디자이너|디자인/, label: '디자인' },
  { pattern: /상담사|상담원|상담/, label: '상담' },
  { pattern: /교사|교수|강사|선생|교관/, label: '교육' },
  { pattern: /관리자|매니저|관리/, label: '관리' },
  { pattern: /분석가|분석사|애널리스트/, label: '분석' },
  { pattern: /기자|리포터|저널리스트/, label: '기자' },
  { pattern: /의사|의료|의학/, label: '의료' },
  { pattern: /경찰|수사|경비/, label: '보안/경비' },
  { pattern: /요리사|셰프|조리/, label: '요리' },
  { pattern: /운전|기사$|운송/, label: '운전/운송' },
  { pattern: /영업|세일즈|판매/, label: '판매' },
  { pattern: /번역|통역/, label: '번역/통역' },
  { pattern: /촬영|카메라|영상/, label: '촬영/영상' },
];

for (const { pattern, label } of semanticPatterns) {
  const matches = names.filter(n => pattern.test(n));
  if (matches.length >= 5) {
    console.log(`\n[${label}] (${matches.length}개)`);
    matches.slice(0, 10).forEach(n => console.log('  - ' + n));
    if (matches.length > 10) console.log(`  ... 외 ${matches.length - 10}개`);
  }
}

// ============ 5. 데이터 소스별 분포 ============
console.log('\n========================================');
console.log('5. 전체 통계');
console.log('========================================');
const lengthDist = { '1-3자': 0, '4-6자': 0, '7-10자': 0, '11-15자': 0, '16자+': 0 };
for (const n of names) {
  if (n.length <= 3) lengthDist['1-3자']++;
  else if (n.length <= 6) lengthDist['4-6자']++;
  else if (n.length <= 10) lengthDist['7-10자']++;
  else if (n.length <= 15) lengthDist['11-15자']++;
  else lengthDist['16자+']++;
}
console.log('이름 길이 분포:', lengthDist);
console.log('총 고유 이름:', new Set(names).size, '/', names.length);
