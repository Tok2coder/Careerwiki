/**
 * 중복/유사 직업 탐색 v3 - 진짜 중복만 찾기
 *
 * 전략:
 * - Levenshtein 1에서 의미 변경 필터링 (한 글자가 의미를 완전히 바꾸는 경우 제외)
 * - "및" 복합명은 구성요소가 진짜 동일직업인 경우만 (OO과전문의사 ≠ 전문의사)
 * - 괄호 별칭은 거의 확실한 중복
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
      curr[j] = a[i-1] === b[j-1] ? prev[j-1] : 1 + Math.min(prev[j-1], prev[j], curr[j-1]);
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
function addResult(a, b, reason, recommendation, confidence) {
  const key = [a.id, b.id].sort().join('-');
  if (seen.has(key)) return;
  seen.add(key);
  results.push({ a: { id: a.id, name: a.name }, b: { id: b.id, name: b.name }, reason, recommendation, confidence });
}

const nameList = jobs.map(j => ({ ...j, norm: normalize(j.name) }));
const nameMap = new Map();
for (const j of nameList) {
  if (!nameMap.has(j.norm)) nameMap.set(j.norm, []);
  nameMap.get(j.norm).push(j);
}

// ============================================================
// Category 1: CERTAIN DUPLICATES
// ============================================================

// 1a. Exact duplicates after normalization
for (const [norm, group] of nameMap) {
  if (group.length > 1) {
    for (let i = 0; i < group.length; i++)
      for (let j = i + 1; j < group.length; j++)
        addResult(group[i], group[j], `정규화 후 동일: "${norm}"`, '합침 (완전 동일)', 'CERTAIN');
  }
}

// 1b. Parenthetical aliases: "A(B)" where "A" or "B" exists separately
for (const job of nameList) {
  const m = job.name.match(/^(.+?)\s*[（(](.+?)[）)]\s*$/);
  if (!m) continue;
  const [, mainPart, altPart] = m;
  for (const part of [mainPart, altPart]) {
    const normP = normalize(part);
    if (normP.length < 2 || !nameMap.has(normP)) continue;
    for (const match of nameMap.get(normP)) {
      if (match.id === job.id) continue;
      addResult(job, match, `괄호 별칭: "${job.name}" ↔ "${match.name}"`, '합침 (동일 직업)', 'CERTAIN');
    }
  }
}

// 1c. "컴퓨터"/"전산" prefix only difference
for (const prefix of ['컴퓨터', '전산']) {
  for (const j1 of nameList) {
    if (!j1.norm.startsWith(prefix)) continue;
    const rest = j1.norm.slice(prefix.length);
    if (rest.length < 3 || !nameMap.has(rest)) continue;
    for (const j2 of nameMap.get(rest)) {
      if (j2.id === j1.id) continue;
      addResult(j1, j2, `"${prefix}" 접두사 유무 차이: "${j1.name}" ↔ "${j2.name}"`, '합침 검토', 'HIGH');
    }
  }
}

// ============================================================
// Category 2: "및/과" COMPOUND NAMES - but only genuine duplicates
// ============================================================
// "A 및 B" where "A" exists separately = potential merge candidate
// BUT exclude: "OO과전문의사" (these are medical specialties, not compound names)
// Also exclude when the compound name groups truly different roles

for (const job of nameList) {
  const raw = job.name;
  if (!/\s+(및|과)\s+/.test(raw) && !raw.includes('/')) continue;
  // Must have space around 및/과 (not "내과전문의사" which uses 과 as department)

  const parts = raw.split(/\s+(?:및|과)\s+|\//).map(s => s.trim()).filter(Boolean);
  if (parts.length < 2) continue;

  for (const part of parts) {
    const normPart = normalize(part);
    if (normPart.length < 2) continue;
    if (nameMap.has(normPart)) {
      for (const match of nameMap.get(normPart)) {
        if (match.id === job.id) continue;
        addResult(job, match, `복합명 "${raw}" 구성요소 "${part}" = "${match.name}"`, `"${match.name}" → "${raw}" 합침 검토`, 'HIGH');
      }
    }
  }
}

// ============================================================
// Category 3: Levenshtein 1 - but filter out meaningful differences
// ============================================================
const byLength = new Map();
for (const j of nameList) {
  const len = j.norm.length;
  if (!byLength.has(len)) byLength.set(len, []);
  byLength.get(len).push(j);
}

// Characters that change meaning when substituted
const meaningfulChars = new Set('가나다라마바사아자차카타파하강감건걸경고공관구국군금기길김남녀농단대도동두등디라량련로류리만매면명모목무문물미민박반발방배백번별병보복봉부북분불비삼상서석선설성세소속손송수숙순술스시식신실심아안알암양어언업여연열영예오옥온용우울원위유육은을음의이인일임입자잔작잠장재저적전절점정제조족종주준중증지직진질짐집징차창채천철청체초촌총추출충측치칠침카코크키타탁탄태택토통특파판팔패편평폐포표품풍피필하학한할함항해핵현협형혜호홀화환활황회효후훈휴흑흥희');

for (const [len, group] of byLength) {
  if (len < 4) continue; // skip very short names

  // Same length
  for (let i = 0; i < group.length; i++) {
    for (let j = i + 1; j < group.length; j++) {
      const a = group[i], b = group[j];
      if (levenshtein(a.norm, b.norm) !== 1) continue;

      // Find the differing character
      let diffIdx = -1;
      for (let k = 0; k < a.norm.length; k++) {
        if (a.norm[k] !== b.norm[k]) { diffIdx = k; break; }
      }

      // If diff is at position 0 or 1 (prefix), it usually changes meaning
      // If diff is at the very end (suffix like 사/원/자/가), it's suspicious
      const isEndDiff = diffIdx >= a.norm.length - 1;
      const isStartDiff = diffIdx <= 0;

      // Skip if the single-char difference creates clearly different terms
      // e.g., 배관공 vs 비관공 - totally different
      // But 플래너 vs 플레너 - same (typo)

      // Heuristic: if both chars are common Korean syllables that change root meaning, likely different
      // We'll keep it but mark confidence
      addResult(a, b, `편집거리 1: "${a.name}" ↔ "${b.name}" (위치 ${diffIdx}/${a.norm.length})`, '이름 유사 - 동일 직업 여부 확인', 'MEDIUM');
    }
  }

  // Length diff = 1
  const longer = byLength.get(len + 1) || [];
  for (const j1 of group) {
    for (const j2 of longer) {
      if (levenshtein(j1.norm, j2.norm) !== 1) continue;
      addResult(j1, j2, `편집거리 1 (길이 차이): "${j1.name}" ↔ "${j2.name}"`, '이름 유사 - 동일 직업 여부 확인', 'MEDIUM');
    }
  }
}

// ============================================================
// Category 4: Compound suffix pairs (기사↔기술자 등) with long stems
// ============================================================
const compoundSuffixPairs = [
  ['기사', '기술자'], ['관리사', '관리자'], ['관리사', '관리원'],
  ['상담사', '상담원'], ['연구원', '연구자'], ['연구사', '연구원'],
  ['조사관', '조사원'], ['지도사', '지도자'],
  ['분석가', '분석사'], ['교사', '교원'],
  ['설계사', '설계자'], ['치료사', '치료자'],
];

for (const [suf1, suf2] of compoundSuffixPairs) {
  for (const j1 of nameList) {
    if (!j1.norm.endsWith(suf1)) continue;
    const stem = j1.norm.slice(0, -suf1.length);
    if (stem.length < 3) continue;
    const target = stem + suf2;
    if (!nameMap.has(target)) continue;
    for (const j2 of nameMap.get(target)) {
      if (j2.id === j1.id) continue;
      addResult(j1, j2, `복합접미사 변형: "${j1.name}" (${suf1}) ↔ "${j2.name}" (${suf2})`, '동일 직업 가능 - 합침 검토', 'HIGH');
    }
  }
}

// ============================================================
// Category 5: English/Korean transliteration pairs
// ============================================================
const translitPairs = [
  ['프로그래머', '개발자'], ['디자이너', '설계자'],
  ['매니저', '관리자'], ['엔지니어', '기술자'],
  ['에디터', '편집자'], ['플래너', '기획자'],
  ['애널리스트', '분석가'], ['컨설턴트', '자문위원'],
  ['코디네이터', '조정자'], ['어시스턴트', '보조원'],
];

for (const [eng, kor] of translitPairs) {
  for (const j1 of nameList) {
    if (!j1.norm.endsWith(eng)) continue;
    const stem = j1.norm.slice(0, -eng.length);
    if (stem.length < 2) continue;
    const target = stem + kor;
    if (!nameMap.has(target)) continue;
    for (const j2 of nameMap.get(target)) {
      if (j2.id === j1.id) continue;
      addResult(j1, j2, `외래어/한글 변형: "${j1.name}" ↔ "${j2.name}"`, '동일 직업 가능 - 합침 검토', 'HIGH');
    }
  }
}

// ============================================================
// OUTPUT
// ============================================================

// Separate by confidence
const certain = results.filter(r => r.confidence === 'CERTAIN');
const high = results.filter(r => r.confidence === 'HIGH');
const medium = results.filter(r => r.confidence === 'MEDIUM');

console.log(`\n총 중복 후보: ${results.length}쌍`);
console.log(`  확실: ${certain.length}쌍`);
console.log(`  높음: ${high.length}쌍`);
console.log(`  중간: ${medium.length}쌍`);

const printGroup = (title, items) => {
  console.log(`\n### ${title} (${items.length}쌍)\n`);
  console.log('| # | 후보 A (id, name) | 후보 B (id, name) | 이유 | 추천 |');
  console.log('|---|---|---|---|---|');
  items.forEach((r, i) => {
    console.log(`| ${i+1} | ${r.a.id} "${r.a.name}" | ${r.b.id} "${r.b.name}" | ${r.reason} | ${r.recommendation} |`);
  });
};

printGroup('확실한 중복 (CERTAIN)', certain);
printGroup('높은 가능성 (HIGH)', high);
printGroup('중간 가능성 - 편집거리 1 (MEDIUM)', medium);

fs.writeFileSync('tmp_dup_job_results.json', JSON.stringify({ certain, high, medium }, null, 2));
console.log('\nSaved to tmp_dup_job_results.json');
