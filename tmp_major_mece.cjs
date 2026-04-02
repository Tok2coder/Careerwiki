const fs = require('fs');
const d = JSON.parse(fs.readFileSync('tmp_all_majors.json', 'utf8'));
const majors = d[0]?.results || [];
const names = majors.map(m => m.name);
const nameSet = new Set(names);

console.log('전체 전공 수:', names.length, '/ 고유:', nameSet.size);

// 1. 완전 동일 이름 중복
const nameCounts = {};
for (const n of names) { nameCounts[n] = (nameCounts[n] || 0) + 1; }
const exactDups = Object.entries(nameCounts).filter(([k, v]) => v > 1);
console.log('\n=== 1. 완전 동일 이름 중복 ===');
if (exactDups.length === 0) console.log('  없음');
else exactDups.forEach(([n, c]) => console.log(`  ${c}x "${n}"`));

// 2. "(일반)" 또는 괄호 변형
console.log('\n=== 2. 괄호 변형 ===');
const bracketMajors = names.filter(n => n.includes('('));
if (bracketMajors.length === 0) console.log('  없음');
else {
  bracketMajors.forEach(n => {
    const base = n.replace(/\(.*?\)/g, '').trim();
    const hasBase = nameSet.has(base);
    console.log(`  "${n}" → base="${base}" ${hasBase ? '⚠️ BASE 존재!' : ''}`);
  });
}

// 3. 레벤슈타인 거리 ≤2 유사 이름
function lev(a, b) {
  const m = a.length, n = b.length;
  if (Math.abs(m - n) > 3) return 99;
  const dp = Array.from({ length: m + 1 }, () => new Array(n + 1).fill(0));
  for (let i = 0; i <= m; i++) dp[i][0] = i;
  for (let j = 0; j <= n; j++) dp[0][j] = j;
  for (let i = 1; i <= m; i++)
    for (let j = 1; j <= n; j++)
      dp[i][j] = a[i-1] === b[j-1] ? dp[i-1][j-1] : 1 + Math.min(dp[i-1][j], dp[i][j-1], dp[i-1][j-1]);
  return dp[m][n];
}
console.log('\n=== 3. 레벤슈타인 거리 ≤2 유사 쌍 ===');
const sorted = [...names].sort();
const nearDups = [];
for (let i = 0; i < sorted.length; i++) {
  for (let j = i + 1; j < sorted.length; j++) {
    if (Math.abs(sorted[i].length - sorted[j].length) > 2) continue;
    const dist = lev(sorted[i], sorted[j]);
    if (dist <= 2 && dist > 0) nearDups.push({ a: sorted[i], b: sorted[j], dist });
  }
}
nearDups.sort((a, b) => a.dist - b.dist);
nearDups.forEach(p => console.log(`  [거리${p.dist}] "${p.a}" ↔ "${p.b}"`));
console.log(`  총: ${nearDups.length}쌍`);

// 4. 포함 관계 (A가 B의 부분문자열)
console.log('\n=== 4. 포함 관계 (짧은 이름이 긴 이름에 포함) ===');
const containGroups = {};
for (let i = 0; i < sorted.length; i++) {
  for (let j = i + 1; j < sorted.length; j++) {
    if (sorted[j].includes(sorted[i]) && sorted[i].length >= 2 && sorted[i] !== sorted[j]) {
      if (!containGroups[sorted[i]]) containGroups[sorted[i]] = [];
      containGroups[sorted[i]].push(sorted[j]);
    }
  }
}
const bigContain = Object.entries(containGroups).filter(([k, v]) => v.length >= 2).sort((a, b) => b[1].length - a[1].length);
bigContain.slice(0, 15).forEach(([short, longs]) => {
  console.log(`\n  "${short}" 포함 (${longs.length}개):`);
  longs.forEach(l => console.log(`    - ${l}`));
});

// 5. 의미적 중복 후보
console.log('\n=== 5. 의미적 중복 후보 ===');
const semGroups = [
  { pattern: /공학$/, label: '~공학' },
  { pattern: /학$/, label: '~학' },
  { pattern: /교육$|교육학$/, label: '~교육' },
  { pattern: /디자인$/, label: '~디자인' },
  { pattern: /경영$|경영학$/, label: '~경영' },
];

// 영문/한글 혼용
const engKorPairs = [
  ['AI', '인공지능'], ['IT', '정보기술'], ['SW', '소프트웨어'],
  ['컴퓨터', '전산'], ['바이오', '생명'], ['미디어', '매체'],
];
console.log('\n  [영문/한글 혼용]');
for (const [eng, kor] of engKorPairs) {
  const engM = names.filter(n => n.includes(eng));
  const korM = names.filter(n => n.includes(kor));
  if (engM.length > 0 && korM.length > 0) {
    console.log(`\n  ${eng} / ${kor}:`);
    engM.forEach(n => console.log(`    ENG: ${n}`));
    korM.forEach(n => console.log(`    KOR: ${n}`));
  }
}

// "X학" vs "X학과" vs "X" 변형
console.log('\n  [학/학과/공학 변형]');
const variations = {};
for (const n of names) {
  let base = n;
  if (base.endsWith('학과')) base = base.slice(0, -1); // 학과 → 학
  if (base.endsWith('공학')) base = base.slice(0, -2); // XX공학 → XX
  if (base.endsWith('학')) base = base.slice(0, -1);    // XX학 → XX
  if (base.length >= 2 && base !== n) {
    if (!variations[base]) variations[base] = [];
    variations[base].push(n);
  }
}
const dupVars = Object.entries(variations).filter(([k, v]) => v.length >= 2).sort((a, b) => b[1].length - a[1].length);
dupVars.forEach(([base, vars]) => {
  console.log(`  [${base}] ${vars.join(', ')}`);
});

// 6. "X 전공" 세분화 과잉
console.log('\n=== 6. 세분화 분석 ===');
const prefixes = {};
for (const n of names) {
  const prefix = n.slice(0, 2);
  if (!prefixes[prefix]) prefixes[prefix] = [];
  prefixes[prefix].push(n);
}
const bigPrefixes = Object.entries(prefixes).filter(([k, v]) => v.length >= 5).sort((a, b) => b[1].length - a[1].length);
bigPrefixes.forEach(([prefix, ms]) => {
  console.log(`\n  "${prefix}~" (${ms.length}개): ${ms.slice(0, 8).join(', ')}${ms.length > 8 ? '...' : ''}`);
});
