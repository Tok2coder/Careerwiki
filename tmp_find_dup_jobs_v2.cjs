/**
 * 중복/유사 직업 탐색 스크립트 v2 - 엄격한 기준
 *
 * 진짜 같은 직업인데 이름만 다른 경우만 찾기:
 * 1. 정규화 후 완전 동일
 * 2. "및/과"로 연결된 이름에서 구성요소가 별도 존재 (예: "A 및 B" + "A" 존재)
 * 3. 괄호 안 별칭이 별도 존재 (예: "건축가(건축설계사)" + "건축설계사" 존재)
 * 4. 편집거리 1 (단순 오타/띄어쓰기 수준)
 * 5. 접미사만 다른 완전 동일 stem (예: "~사" vs "~원" with same stem, 길이 6+)
 * 6. "컴퓨터" 등 의미 없는 접두사 유무 차이
 */

const fs = require('fs');

const jobs = JSON.parse(fs.readFileSync('tmp_dup_jobs_list.json', 'utf8'));
console.log(`Loaded ${jobs.length} jobs`);

function levenshtein(a, b) {
  const m = a.length, n = b.length;
  if (m === 0) return n;
  if (n === 0) return m;
  let prev = Array.from({ length: n + 1 }, (_, i) => i);
  let curr = new Array(n + 1);
  for (let i = 1; i <= m; i++) {
    curr[0] = i;
    for (let j = 1; j <= n; j++) {
      if (a[i - 1] === b[j - 1]) {
        curr[j] = prev[j - 1];
      } else {
        curr[j] = 1 + Math.min(prev[j - 1], prev[j], curr[j - 1]);
      }
    }
    [prev, curr] = [curr, prev];
  }
  return prev[n];
}

function normalize(name) {
  return name.replace(/\s+/g, '').replace(/[()（）]/g, '').toLowerCase().trim();
}

const results = [];
const seen = new Set();

function addResult(a, b, reason, recommendation) {
  const key = [a.id, b.id].sort().join('-');
  if (seen.has(key)) return;
  seen.add(key);
  results.push({ a: { id: a.id, name: a.name }, b: { id: b.id, name: b.name }, reason, recommendation });
}

const nameList = jobs.map(j => ({ ...j, norm: normalize(j.name) }));
const nameMap = new Map();
for (const j of nameList) {
  if (!nameMap.has(j.norm)) nameMap.set(j.norm, []);
  nameMap.get(j.norm).push(j);
}

// ============================================================
// Phase 0: Exact duplicates after normalization
// ============================================================
console.log('Phase 0: Exact normalized duplicates');
for (const [norm, group] of nameMap) {
  if (group.length > 1) {
    for (let i = 0; i < group.length; i++) {
      for (let j = i + 1; j < group.length; j++) {
        addResult(group[i], group[j], `정규화 후 동일: "${norm}"`, '합침 (완전 동일)');
      }
    }
  }
}
console.log(`  Found so far: ${results.length}`);

// ============================================================
// Phase 1: "및"/"과"/"/" compound names where ALL parts exist separately
// ============================================================
console.log('Phase 1: Compound name decomposition');
for (const job of nameList) {
  const raw = job.name;
  // Only process names with connectors
  if (!/\s*(및|과|\/)\s*/.test(raw)) continue;

  const parts = raw.split(/\s*(?:및|과|\/)\s*/).map(s => s.trim()).filter(Boolean);
  if (parts.length < 2) continue;

  for (const part of parts) {
    const normPart = normalize(part);
    if (normPart.length < 2) continue;
    if (nameMap.has(normPart)) {
      for (const match of nameMap.get(normPart)) {
        if (match.id === job.id) continue;
        addResult(job, match, `복합명 "${raw}"의 구성요소 "${part}"가 독립 직업 "${match.name}"으로 존재`, `"${match.name}"을 "${raw}"에 합침 검토`);
      }
    }
  }
}
console.log(`  Found so far: ${results.length}`);

// ============================================================
// Phase 2: Parenthetical aliases (e.g., "A(B)" where "B" exists)
// ============================================================
console.log('Phase 2: Parenthetical aliases');
for (const job of nameList) {
  const m = job.name.match(/^(.+?)\s*[（(](.+?)[）)]\s*$/);
  if (!m) continue;
  const [, mainPart, altPart] = m;

  for (const checkPart of [mainPart, altPart]) {
    const normCheck = normalize(checkPart);
    if (normCheck.length < 2) continue;
    if (nameMap.has(normCheck)) {
      for (const match of nameMap.get(normCheck)) {
        if (match.id === job.id) continue;
        addResult(job, match, `괄호 포함명 "${job.name}" ↔ "${match.name}"`, '합침 (동일 직업)');
      }
    }
  }
}
console.log(`  Found so far: ${results.length}`);

// ============================================================
// Phase 3: Levenshtein distance = 1 (typo-level similarity)
// ============================================================
console.log('Phase 3: Levenshtein distance 1');
// Build buckets by length for efficient comparison
const byLength = new Map();
for (const j of nameList) {
  const len = j.norm.length;
  if (!byLength.has(len)) byLength.set(len, []);
  byLength.get(len).push(j);
}

for (const [len, group] of byLength) {
  if (len < 3) continue;
  // Compare within same length
  for (let i = 0; i < group.length; i++) {
    for (let j = i + 1; j < group.length; j++) {
      if (levenshtein(group[i].norm, group[j].norm) === 1) {
        addResult(group[i], group[j], `편집거리 1: "${group[i].name}" ↔ "${group[j].name}"`, '오타/변형 - 합침 검토');
      }
    }
  }
  // Compare with length+1
  const longer = byLength.get(len + 1) || [];
  for (const j1 of group) {
    for (const j2 of longer) {
      if (levenshtein(j1.norm, j2.norm) === 1) {
        addResult(j1, j2, `편집거리 1: "${j1.name}" ↔ "${j2.name}"`, '오타/변형 - 합침 검토');
      }
    }
  }
}
console.log(`  Found so far: ${results.length}`);

// ============================================================
// Phase 4: Same stem with different job suffixes
// Only for stems of 4+ chars (meaningful)
// ============================================================
console.log('Phase 4: Suffix variations on same stem');
const jobSuffixes = ['사', '원', '가', '자', '관', '공', '인', '수'];
const stemMap = new Map(); // stem -> [{suffix, job}]

for (const j of nameList) {
  for (const suf of jobSuffixes) {
    if (j.norm.endsWith(suf) && j.norm.length > suf.length + 3) {
      const stem = j.norm.slice(0, -suf.length);
      if (!stemMap.has(stem)) stemMap.set(stem, []);
      stemMap.get(stem).push({ suffix: suf, job: j });
    }
  }
}

for (const [stem, entries] of stemMap) {
  if (entries.length < 2) continue;
  if (stem.length < 4) continue; // meaningful stem only

  // Group by suffix
  const bySuffix = new Map();
  for (const e of entries) {
    if (!bySuffix.has(e.suffix)) bySuffix.set(e.suffix, []);
    bySuffix.get(e.suffix).push(e.job);
  }

  const suffixGroups = [...bySuffix.entries()];
  for (let i = 0; i < suffixGroups.length; i++) {
    for (let j = i + 1; j < suffixGroups.length; j++) {
      const [suf1, jobs1] = suffixGroups[i];
      const [suf2, jobs2] = suffixGroups[j];
      for (const j1 of jobs1) {
        for (const j2 of jobs2) {
          addResult(j1, j2, `동일 어간 "${stem}" + 접미사 변형 ("${suf1}" vs "${suf2}")`, '접미사 변형 - 합침 검토');
        }
      }
    }
  }
}
console.log(`  Found so far: ${results.length}`);

// ============================================================
// Phase 5: Meaningless prefix differences
// "컴퓨터" prefix is the most common one
// ============================================================
console.log('Phase 5: Meaningless prefix removal');
const meaninglessPrefixes = ['컴퓨터', '전산'];
for (const prefix of meaninglessPrefixes) {
  for (const j1 of nameList) {
    if (!j1.norm.startsWith(prefix)) continue;
    const rest = j1.norm.slice(prefix.length);
    if (rest.length < 3) continue;
    if (nameMap.has(rest)) {
      for (const j2 of nameMap.get(rest)) {
        if (j2.id === j1.id) continue;
        addResult(j1, j2, `"${prefix}" 접두사 유무 차이: "${j1.name}" ↔ "${j2.name}"`, `동일 직업 가능성 높음 - 합침 검토`);
      }
    }
  }
}
console.log(`  Found so far: ${results.length}`);

// ============================================================
// Phase 6: Longer compound suffix pairs (기사↔기술자, 상담사↔상담원 등)
// ============================================================
console.log('Phase 6: Compound suffix pairs');
const compoundSuffixPairs = [
  ['기사', '기술자'], ['기사', '기술원'],
  ['관리사', '관리자'], ['관리사', '관리원'],
  ['상담사', '상담원'], ['상담사', '상담자'],
  ['연구원', '연구자'], ['연구사', '연구원'],
  ['조사관', '조사원'], ['조사관', '조사자'],
  ['지도사', '지도자'], ['지도사', '지도원'],
  ['전문가', '전문의'], ['전문가', '전문인'],
  ['치료사', '치료자'],
  ['교사', '교원'], ['교사', '교수'],
  ['설계사', '설계자'], ['설계사', '설계원'],
  ['분석가', '분석사'], ['분석가', '분석원'],
  ['감정사', '감정평가사'],
  ['프로그래머', '개발자'],
  ['디자이너', '설계사'],
  ['엔지니어', '기술자'], ['엔지니어', '기사'],
  ['매니저', '관리자'],
  ['코디네이터', '조정자'],
  ['컨설턴트', '상담사'],
  ['에디터', '편집자'],
  ['플래너', '기획자'],
  ['애널리스트', '분석가'],
];

for (const [suf1, suf2] of compoundSuffixPairs) {
  for (const j1 of nameList) {
    if (!j1.norm.endsWith(suf1)) continue;
    const stem = j1.norm.slice(0, -suf1.length);
    if (stem.length < 2) continue;

    const target = stem + suf2;
    if (nameMap.has(target)) {
      for (const j2 of nameMap.get(target)) {
        if (j2.id === j1.id) continue;
        addResult(j1, j2, `복합접미사 변형: "${j1.name}"(${suf1}) ↔ "${j2.name}"(${suf2})`, '동일 직업 가능 - 합침 검토');
      }
    }
  }
}
console.log(`  Found so far: ${results.length}`);

// ============================================================
// Phase 7: "전문" prefix (전문의사 vs 의사 etc.)
// But be careful: 전문의 vs 의사 is DIFFERENT (specialist vs general)
// Only flag when prefix adds no specialization
// ============================================================
// (Skipping this - too many false positives)

// ============================================================
// Output
// ============================================================
console.log(`\n========================================`);
console.log(`총 중복 후보: ${results.length}쌍`);
console.log(`========================================\n`);

// Sort by category
results.sort((a, b) => {
  // Sort by reason type
  const typeOrder = (r) => {
    if (r.includes('정규화 후 동일')) return 0;
    if (r.includes('괄호')) return 1;
    if (r.includes('복합명')) return 2;
    if (r.includes('접두사')) return 3;
    if (r.includes('편집거리')) return 4;
    if (r.includes('접미사 변형') || r.includes('복합접미사')) return 5;
    return 6;
  };
  return typeOrder(a.reason) - typeOrder(b.reason);
});

// Print markdown table
console.log('| # | 후보 A (id, name) | 후보 B (id, name) | 이유 | 추천 |');
console.log('|---|---|---|---|---|');
results.forEach((r, i) => {
  console.log(`| ${i+1} | ${r.a.id} "${r.a.name}" | ${r.b.id} "${r.b.name}" | ${r.reason} | ${r.recommendation} |`);
});

fs.writeFileSync('tmp_dup_job_results.json', JSON.stringify(results, null, 2));
console.log(`\nResults saved to tmp_dup_job_results.json`);
