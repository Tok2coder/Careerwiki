const fs = require('fs');
const d = JSON.parse(fs.readFileSync('tmp_all_majors.json', 'utf8'));
const names = d[0]?.results?.map(m => m.name) || [];
const nameSet = new Set(names);

// 1. 괄호 변형 — BASE 존재
console.log('=== 1. 괄호 변형 (BASE 존재) ===');
for (const n of names) {
  if (n.includes('(')) {
    const base = n.replace(/\(.*?\)/g, '').trim();
    if (nameSet.has(base) && base !== n) {
      console.log(`  ⚠️ "${n}" ↔ "${base}"`);
    }
  }
}

// 2. X과 ↔ X학과 공존
console.log('\n=== 2. "X과" ↔ "X학과" 공존 ===');
const gwaHakgwa = [];
for (const n of names) {
  if (n.endsWith('과') && !n.endsWith('학과') && !n.endsWith('공학과')) {
    const hakgwa = n.slice(0, -1) + '학과';
    if (nameSet.has(hakgwa)) {
      gwaHakgwa.push({ short: n, long: hakgwa });
    }
  }
}
gwaHakgwa.forEach(p => console.log(`  "${p.short}" ↔ "${p.long}"`));
console.log(`  총: ${gwaHakgwa.length}쌍`);

// 3. 학과 ↔ 학부 공존
console.log('\n=== 3. "X학과" ↔ "X학부" 공존 ===');
const hakbuPairs = [];
for (const n of names) {
  if (n.endsWith('학과')) {
    const hakbu = n.slice(0, -1) + '부';
    if (nameSet.has(hakbu)) {
      hakbuPairs.push({ hakgwa: n, hakbu });
    }
  }
}
hakbuPairs.forEach(p => console.log(`  "${p.hakgwa}" ↔ "${p.hakbu}"`));
console.log(`  총: ${hakbuPairs.length}쌍`);

// 4. X공학과 ↔ X학과 / X과
console.log('\n=== 4. "X공학과" ↔ "X학과" / "X과" ===');
for (const n of names) {
  if (n.endsWith('공학과')) {
    const base = n.slice(0, -3); // remove 공학과
    const variants = [];
    if (nameSet.has(base + '학과')) variants.push(base + '학과');
    if (nameSet.has(base + '과')) variants.push(base + '과');
    if (variants.length > 0) {
      console.log(`  "${n}" ↔ ${variants.map(v => `"${v}"`).join(', ')}`);
    }
  }
}

// 5. 의미적 동의어
console.log('\n=== 5. 의미적 동의어 후보 ===');
const synonymGroups = [
  ['컴퓨터', '전산', '정보처리'],
  ['바이오', '생명', '생물'],
  ['미디어', '매체', '언론'],
  ['관광', '호텔', '여행'],
  ['유아', '아동', '보육'],
  ['시각', '그래픽', '영상'],
  ['산업', '공업'],
  ['환경', '생태'],
  ['식품', '영양', '조리'],
];

for (const group of synonymGroups) {
  const found = {};
  for (const term of group) {
    const matches = names.filter(n => n.includes(term));
    if (matches.length > 0) found[term] = matches;
  }
  if (Object.keys(found).length >= 2) {
    console.log(`\n  [${group.join(' / ')}]`);
    for (const [term, matches] of Object.entries(found)) {
      console.log(`    "${term}" (${matches.length}개): ${matches.slice(0, 5).join(', ')}${matches.length > 5 ? '...' : ''}`);
    }
  }
}

// 6. 전체 통계
console.log('\n=== 6. 요약 통계 ===');
const total = names.length;
const withGwa = names.filter(n => n.endsWith('과') && !n.endsWith('학과')).length;
const withHakgwa = names.filter(n => n.endsWith('학과')).length;
const withGonghak = names.filter(n => n.endsWith('공학과')).length;
const withHakbu = names.filter(n => n.endsWith('학부')).length;
const withBrackets = names.filter(n => n.includes('(')).length;
console.log(`  총 ${total}개: ~과 ${withGwa}, ~학과 ${withHakgwa}, ~공학과 ${withGonghak}, ~학부 ${withHakbu}, 괄호 ${withBrackets}`);
