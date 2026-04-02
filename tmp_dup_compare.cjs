const { execSync } = require('child_process');

const pairs = [
  [1, "C", "컴퓨터게임시나리오작가", "게임시나리오작가"],
  [2, "C", "컴퓨터기술영업원", "기술영업원"],
  [3, "C", "컴퓨터속기사", "속기사"],
  [4, "C", "컴퓨터시스템엔지니어", "시스템엔지니어"],
  [5, "D", "곡식작물재배원", "곡식작물재배자"],
  [6, "D", "과수작물재배원", "과수작물재배자"],
  [7, "D", "여행상품개발원", "여행상품개발자"],
  [8, "D", "식물원관리원", "식물원관리자"],
  [9, "D", "골프장코스관리사", "골프장코스관리자"],
  [10, "D", "증권분석가", "증권분석사"],
  [11, "D", "특수효과기사", "특수효과기술자"],
  [12, "D", "정보보안전문가", "정보보호전문가"],
  [13, "E", "개그맨 및 코미디언", "개그맨"],
  [14, "E", "건축시공기술자 및 견적원", "건축시공기술자"],
  [15, "E", "계산원 및 매표원", "매표원"],
  [16, "E", "공연·영화 및 음반기획자", "음반기획자"],
  [17, "E", "구두미화원 및 수선원", "구두미화원"],
  [18, "E", "대기환경기술자 및 연구원", "대기환경기술자"],
  [19, "E", "대학교 총장 및 대학학장", "대학교총장"],
  [20, "E", "매표원 및 복권판매원", "매표원"],
  [21, "E", "메이크업아티스트 및 뷰티매니저", "메이크업아티스트"],
  [22, "E", "반도체공학기술자 및 연구원", "반도체공학기술자"],
  [23, "E", "법무사 및 집행관", "법무사"],
  [24, "E", "법무사 및 집행관", "집행관"],
  [25, "E", "사진작가 및 사진사", "사진작가"],
  [26, "E", "사진작가 및 사진사", "사진사"],
  [27, "E", "산업안전원 및 위험관리원", "위험관리원"],
  [28, "E", "상품중개인 및 경매사", "상품중개인"],
  [29, "E", "선박 및 열차객실승무원", "열차객실승무원"],
  [30, "E", "선장 및 항해사", "항해사"],
  [31, "E", "소음진동기술자 및 연구원", "소음진동기술자"],
  [32, "E", "식품공학기술자 및 연구원", "식품공학기술자"],
  [33, "E", "악기수리원 및 조율사", "악기수리원"],
  [34, "E", "악기제조원 및 조율사", "악기제조원"],
  [35, "E", "약사 및 한약사", "약사"],
  [36, "E", "약사 및 한약사", "한약사"],
  [37, "E", "양장사 및 양복사", "양장사"],
  [38, "E", "양장사 및 양복사", "양복사"],
  [39, "E", "어부 및 해녀", "해녀"],
  [40, "E", "연극 및 뮤지컬배우", "뮤지컬배우"],
  [41, "E", "연근해 어부 및 해녀", "해녀"],
  [42, "E", "영상·녹화 및 편집기사", "편집기사"],
  [43, "E", "요양보호사 및 간병인", "요양보호사"],
  [44, "E", "요양보호사 및 간병인", "간병인"],
  [45, "E", "유치원 원장 및 원감", "유치원원장"],
  [46, "E", "장례지도사 및 장례상담원", "장례지도사"],
  [47, "E", "전산자료입력원 및 사무보조원", "사무보조원"],
  [48, "E", "조림 영림 및 벌목원", "벌목원"],
  [49, "E", "조림·산림경영인 및 벌목원", "벌목원"],
  [50, "E", "중고등학교 교장 및 교감", "교감"],
  [51, "E", "직업상담 및 취업알선원", "취업알선원"],
  [52, "E", "채소 및 특용작물재배자", "특용작물재배자"],
  [53, "E", "초등학교 교장 및 교감", "교감"],
  [54, "E", "컴퓨터하드웨어 기술자 및 연구원", "컴퓨터하드웨어기술자"],
  [55, "E", "토목시공기술자 및 견적원", "토목시공기술자"],
  [56, "E", "토양환경기술자 및 연구원", "토양환경기술자"],
  [57, "E", "피부 및 체형관리사", "체형관리사"],
  [58, "E", "홍보도우미 및 판촉원", "홍보도우미"],
  [59, "E", "환경미화원 및 재활용품수거원", "환경미화원"],
  [60, "E", "가스ㆍ수도ㆍ전기 계기 검침원 및 안전점검원", "계기검침원 및 가스점검원"],
  [61, "F", "어부 및 해녀", "연근해 어부 및 해녀"],
  [62, "F", "조림 영림 및 벌목원", "조림·산림경영인 및 벌목원"],
  [63, "F", "가스ㆍ수도ㆍ전기 계기 검침원 및 안전점검원", "계기검침원 및 가스점검원"],
];

// Collect all unique names
const allNames = new Set();
for (const [,,a,b] of pairs) {
  allNames.add(a);
  allNames.add(b);
}

const nameList = [...allNames];

// Build SQL with all names in one query
const escapedNames = nameList.map(n => n.replace(/'/g, "''"));
const inClause = escapedNames.map(n => `'${n}'`).join(',');

const sql = `SELECT id, name, json_extract(merged_profile_json, '$.heroIntro') as intro, json_extract(merged_profile_json, '$.summary') as summary, substr(json_extract(merged_profile_json, '$.overviewWork.main'), 1, 500) as work, substr(json_extract(merged_profile_json, '$.duties'), 1, 500) as duties FROM jobs WHERE is_active = 1 AND name IN (${inClause})`;

console.error('Querying DB for', nameList.length, 'unique job names...');

let result;
try {
  const cmd = `npx wrangler d1 execute careerwiki-kr --remote --json --command "${sql.replace(/"/g, '\\"')}"`;
  const out = execSync(cmd, { cwd: 'C:/Users/PC/Careerwiki', maxBuffer: 50 * 1024 * 1024, encoding: 'utf8' });
  result = JSON.parse(out);
} catch (e) {
  console.error('Query failed, trying chunked approach...');
  // Try chunked - split into groups of 30
  const chunks = [];
  for (let i = 0; i < nameList.length; i += 30) {
    chunks.push(nameList.slice(i, i + 30));
  }

  let allRows = [];
  for (const chunk of chunks) {
    const esc = chunk.map(n => n.replace(/'/g, "''"));
    const inc = esc.map(n => `'${n}'`).join(',');
    const sq = `SELECT id, name, json_extract(merged_profile_json, '$.heroIntro') as intro, json_extract(merged_profile_json, '$.summary') as summary, substr(json_extract(merged_profile_json, '$.overviewWork.main'), 1, 500) as work, substr(json_extract(merged_profile_json, '$.duties'), 1, 500) as duties FROM jobs WHERE is_active = 1 AND name IN (${inc})`;
    const cmd2 = `npx wrangler d1 execute careerwiki-kr --remote --json --command "${sq.replace(/"/g, '\\"')}"`;
    const out2 = execSync(cmd2, { cwd: 'C:/Users/PC/Careerwiki', maxBuffer: 50 * 1024 * 1024, encoding: 'utf8' });
    const r = JSON.parse(out2);
    const rows = r[0]?.results || [];
    allRows = allRows.concat(rows);
    console.error(`Chunk done: ${rows.length} rows`);
  }
  result = [{ results: allRows }];
}

const rows = result[0]?.results || [];
console.error(`Got ${rows.length} rows total`);

// Build lookup
const lookup = {};
for (const row of rows) {
  lookup[row.name] = row;
}

// Helper: truncate to N chars
function trunc(s, n) {
  if (!s) return '(없음)';
  s = s.replace(/\n/g, ' ').replace(/\s+/g, ' ').trim();
  return s.length > n ? s.substring(0, n) + '...' : s;
}

// Get best description for a job
function getDesc(row) {
  if (!row) return '(DB에 없음)';
  // Priority: work > summary > intro > duties
  return row.work || row.summary || row.intro || row.duties || '(설명 없음)';
}

// Compare two jobs
function isSameJob(rowA, rowB) {
  if (!rowA || !rowB) return { verdict: '?', reason: 'DB에 한쪽 없음' };

  const descA = getDesc(rowA);
  const descB = getDesc(rowB);

  if (descA === '(설명 없음)' && descB === '(설명 없음)') {
    return { verdict: '?', reason: '양쪽 설명 없음' };
  }

  // Check if descriptions are very similar
  const wordsA = new Set((descA || '').replace(/[^가-힣a-zA-Z0-9\s]/g, '').split(/\s+/).filter(w => w.length > 1));
  const wordsB = new Set((descB || '').replace(/[^가-힣a-zA-Z0-9\s]/g, '').split(/\s+/).filter(w => w.length > 1));

  if (wordsA.size === 0 || wordsB.size === 0) return { verdict: '?', reason: '단어 추출 불가' };

  const intersection = new Set([...wordsA].filter(w => wordsB.has(w)));
  const union = new Set([...wordsA, ...wordsB]);
  const jaccard = intersection.size / union.size;

  // Also check exact substring match
  const exactMatch = descA === descB;

  if (exactMatch) return { verdict: 'O', reason: `설명 동일 (100%)` };
  if (jaccard > 0.7) return { verdict: 'O', reason: `높은 유사도 (${(jaccard*100).toFixed(0)}%)` };
  if (jaccard > 0.4) return { verdict: '?', reason: `중간 유사도 (${(jaccard*100).toFixed(0)}%) - 수동확인 필요` };
  return { verdict: 'X', reason: `낮은 유사도 (${(jaccard*100).toFixed(0)}%)` };
}

// Output results
console.log('| # | Cat | 직업 A | 직업 B | A 하는일 요약 | B 하는일 요약 | 판단 | 사유 |');
console.log('|---|-----|--------|--------|---------------|---------------|------|------|');

for (const [num, cat, nameA, nameB] of pairs) {
  const rowA = lookup[nameA];
  const rowB = lookup[nameB];
  const descA = getDesc(rowA);
  const descB = getDesc(rowB);
  const { verdict, reason } = isSameJob(rowA, rowB);

  const aExists = rowA ? `id:${rowA.id}` : 'NOT FOUND';
  const bExists = rowB ? `id:${rowB.id}` : 'NOT FOUND';

  console.log(`| ${num} | ${cat} | ${nameA} (${aExists}) | ${nameB} (${bExists}) | ${trunc(descA, 80)} | ${trunc(descB, 80)} | ${verdict} | ${reason} |`);
}

// Also output a summary of NOT FOUND items
const notFound = nameList.filter(n => !lookup[n]);
if (notFound.length > 0) {
  console.log('\n### DB에서 찾을 수 없는 직업명:');
  for (const n of notFound) {
    console.log(`- "${n}"`);
  }
}
