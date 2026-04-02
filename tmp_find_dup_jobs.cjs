/**
 * 중복/유사 직업 탐색 스크립트
 *
 * 패턴:
 * 1. "및", "과", "/" 등으로 분리한 토큰이 다른 직업과 겹침
 * 2. 편집거리(Levenshtein)가 매우 가까운 쌍
 * 3. 한 이름이 다른 이름의 substring인 경우
 * 4. 접두사/접미사 변형 (예: ~사, ~원, ~가, ~자 등)
 */

const fs = require('fs');

const jobs = JSON.parse(fs.readFileSync('tmp_dup_jobs_list.json', 'utf8'));
console.log(`Loaded ${jobs.length} jobs`);

// Levenshtein distance
function levenshtein(a, b) {
  const m = a.length, n = b.length;
  if (m === 0) return n;
  if (n === 0) return m;
  // Use two-row optimization for memory
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

// Normalize name for comparison
function normalize(name) {
  return name
    .replace(/\s+/g, '')
    .replace(/[()（）]/g, '')
    .toLowerCase()
    .trim();
}

// Split compound names
function splitCompound(name) {
  // Split by 및, 과, /, · etc.
  const parts = name.split(/\s*(?:및|과|\/|·)\s*/).map(s => s.trim()).filter(Boolean);
  return parts;
}

const results = [];
const seen = new Set();

function addResult(a, b, reason, recommendation) {
  const key = [a.id, b.id].sort().join('-');
  if (seen.has(key)) return;
  seen.add(key);
  results.push({ a, b, reason, recommendation });
}

// Build lookup maps
const nameMap = new Map(); // normalized name -> job
const nameList = jobs.map(j => ({ ...j, norm: normalize(j.name) }));

for (const j of nameList) {
  if (!nameMap.has(j.norm)) {
    nameMap.set(j.norm, []);
  }
  nameMap.get(j.norm).push(j);
}

// 0. Exact duplicates after normalization
console.log('\n=== Phase 0: Exact normalized duplicates ===');
for (const [norm, group] of nameMap) {
  if (group.length > 1) {
    for (let i = 0; i < group.length; i++) {
      for (let j = i + 1; j < group.length; j++) {
        addResult(group[i], group[j], `정규화 후 동일 이름: "${norm}"`, '합침 (완전 동일)');
      }
    }
  }
}

// 1. Compound name token overlap
console.log('=== Phase 1: Compound name token overlap ===');
const allNames = new Set(nameList.map(j => j.norm));
const nameToJob = new Map();
for (const j of nameList) {
  nameToJob.set(j.norm, j);
}

for (const job of nameList) {
  const parts = splitCompound(job.name);
  if (parts.length < 2) continue;

  for (const part of parts) {
    const normPart = normalize(part);
    if (normPart.length < 2) continue;

    // Check if this part exists as a standalone job
    if (nameMap.has(normPart)) {
      const matches = nameMap.get(normPart);
      for (const match of matches) {
        if (match.id === job.id) continue;
        addResult(job, match, `복합명 "${job.name}"의 구성요소 "${part}"가 독립 직업으로 존재`, `"${match.name}"을 "${job.name}"으로 합침 검토`);
      }
    }
  }
}

// 2. Substring matches (one name contained in another)
console.log('=== Phase 2: Substring matches ===');
// Sort by name length for efficient substring checking
const sortedByLen = [...nameList].sort((a, b) => a.norm.length - b.norm.length);

for (let i = 0; i < sortedByLen.length; i++) {
  const short = sortedByLen[i];
  if (short.norm.length < 3) continue; // too short to be meaningful

  for (let j = i + 1; j < sortedByLen.length; j++) {
    const long = sortedByLen[j];
    if (long.norm.length === short.norm.length) continue; // same length = not substring
    if (long.norm.length - short.norm.length > 6) continue; // too different in length

    if (long.norm.includes(short.norm)) {
      // Check it's a meaningful overlap (not just common suffix like 사, 원)
      const diff = long.norm.replace(short.norm, '');
      if (diff.length <= 3) {
        addResult(short, long, `"${short.name}"이 "${long.name}"의 부분 문자열 (차이: "${diff}")`, `유사 직업 - 합침 검토`);
      }
    }
  }
}

// 3. Levenshtein distance (only for names of similar length)
console.log('=== Phase 3: Levenshtein distance ===');
// Group by length range for efficiency
const lengthGroups = new Map();
for (const j of nameList) {
  const len = j.norm.length;
  for (let l = Math.max(2, len - 2); l <= len + 2; l++) {
    if (!lengthGroups.has(l)) lengthGroups.set(l, []);
    // Only add to own length group
    if (l === len) lengthGroups.get(l).push(j);
  }
}

// Compare within similar length groups
const comparedPairs = new Set();
for (const j1 of nameList) {
  if (j1.norm.length < 3) continue;

  // Get candidates with similar length
  for (let targetLen = Math.max(2, j1.norm.length - 2); targetLen <= j1.norm.length + 2; targetLen++) {
    const candidates = lengthGroups.get(targetLen) || [];
    for (const j2 of candidates) {
      if (j1.id >= j2.id) continue; // avoid duplicates and self-compare
      const pairKey = j1.id + '-' + j2.id;
      if (comparedPairs.has(pairKey)) continue;
      comparedPairs.add(pairKey);

      const dist = levenshtein(j1.norm, j2.norm);
      const maxLen = Math.max(j1.norm.length, j2.norm.length);

      // Threshold: distance <= 1 for short names, <= 2 for longer names
      let threshold;
      if (maxLen <= 4) threshold = 1;
      else if (maxLen <= 8) threshold = 2;
      else threshold = 2;

      if (dist > 0 && dist <= threshold) {
        addResult(j1, j2, `편집거리 ${dist} (이름 길이 ${maxLen}): "${j1.name}" ↔ "${j2.name}"`, '유사 이름 - 합침 검토');
      }
    }
  }
}

// 4. Suffix/prefix variations (직업명 끝 변형)
console.log('=== Phase 4: Suffix variations ===');
const suffixPairs = [
  ['사', '원'], ['사', '가'], ['사', '자'],
  ['원', '가'], ['원', '자'], ['가', '자'],
  ['기사', '기술자'], ['전문가', '전문의'],
  ['관리사', '관리자'], ['상담사', '상담원'],
  ['연구원', '연구자'], ['기술자', '기술원'],
  ['설계사', '설계자'], ['치료사', '치료사'],
  ['디자이너', '설계사'],
];

for (const [suf1, suf2] of suffixPairs) {
  for (const j1 of nameList) {
    if (!j1.norm.endsWith(suf1)) continue;
    const stem = j1.norm.slice(0, -suf1.length);
    if (stem.length < 2) continue;

    const target = stem + suf2;
    if (nameMap.has(target)) {
      for (const j2 of nameMap.get(target)) {
        addResult(j1, j2, `접미사 변형: "${j1.name}" (${suf1}) ↔ "${j2.name}" (${suf2})`, '접미사만 다른 유사 직업 - 합침 검토');
      }
    }
  }
}

// 5. With/without specific prefixes or words
console.log('=== Phase 5: Prefix/word variations ===');
const prefixes = ['전문', '일반', '수석', '선임'];
for (const prefix of prefixes) {
  for (const j1 of nameList) {
    if (!j1.norm.startsWith(prefix)) continue;
    const rest = j1.norm.slice(prefix.length);
    if (rest.length < 2) continue;
    if (nameMap.has(rest)) {
      for (const j2 of nameMap.get(rest)) {
        addResult(j1, j2, `접두사 "${prefix}" 유무 차이: "${j1.name}" ↔ "${j2.name}"`, `"${j2.name}"이 상위 범주일 가능성 - 검토`);
      }
    }
  }
}

// 6. Korean/English mixed duplicates - check if one has 한글 version
console.log('=== Phase 6: Similar with parenthetical forms ===');
for (const j1 of nameList) {
  // Check for parenthetical names like "A(B)" matching "B"
  const parenMatch = j1.name.match(/^(.+)[（(](.+)[）)]$/);
  if (parenMatch) {
    const [, mainPart, altPart] = parenMatch;
    const normMain = normalize(mainPart);
    const normAlt = normalize(altPart);

    if (nameMap.has(normMain)) {
      for (const j2 of nameMap.get(normMain)) {
        if (j2.id !== j1.id) {
          addResult(j1, j2, `괄호 포함명 "${j1.name}"의 본명이 "${j2.name}"과 동일`, '합침');
        }
      }
    }
    if (nameMap.has(normAlt)) {
      for (const j2 of nameMap.get(normAlt)) {
        if (j2.id !== j1.id) {
          addResult(j1, j2, `괄호 포함명 "${j1.name}"의 별칭이 "${j2.name}"과 동일`, '합침');
        }
      }
    }
  }
}

// Sort results by reason type
results.sort((a, b) => a.reason.localeCompare(b.reason));

// Output
console.log(`\n========================================`);
console.log(`총 중복 후보: ${results.length}쌍`);
console.log(`========================================\n`);

// Print as table
for (const r of results) {
  console.log(`| ${r.a.id} "${r.a.name}" | ${r.b.id} "${r.b.name}" | ${r.reason} | ${r.recommendation} |`);
}

// Save to JSON for further processing
fs.writeFileSync('tmp_dup_job_results.json', JSON.stringify(results, null, 2));
console.log(`\nResults saved to tmp_dup_job_results.json`);
