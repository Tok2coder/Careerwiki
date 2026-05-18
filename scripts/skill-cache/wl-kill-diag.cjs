#!/usr/bin/env node
/**
 * WL-KILL Diagnosis — Phase 0-DIAG 자동 enumerate
 *
 * 사용:
 *   node scripts/skill-cache/wl-kill-diag.cjs <slug>
 *
 * 출력: 21+ 영역 자동 enumerate Self-Report 형식.
 * - prose body 14 영역 (abilities/summary/duties 포함 자동 검출)
 * - sidebar 4 영역
 * - 보조 영역 5개 (등급 2 + heroTags + youtubeLinks + careerTree)
 *
 * 화이트리스트 폐기 (WL-KILL 룰, 2026-05-16).
 * Round 1~9 137건 사고 잔존 (abilities/summary/duties invisible) 재발 방지.
 */
const { spawnSync } = require('child_process');

const slug = process.argv[2];
if (!slug) {
  console.error('Usage: wl-kill-diag.cjs <slug>');
  process.exit(1);
}

// 21+ 영역 정의 (sal-protection: overviewSalary.sal 제외)
const PROSE_BODY_FIELDS = [
  { key: 'way', minLen: 200, label: 'way (되는 방법)' },
  { key: 'summary', minLen: 80, label: 'summary (직업 설명)' },
  { key: 'trivia', minLen: 80, label: 'trivia (여담)' },
  { key: 'overviewWork.main', minLen: 100, label: 'duties (overviewWork.main)' },
  { key: 'overviewProspect.main', minLen: 100, label: 'prospect (overviewProspect.main)' },
  { key: 'overviewAbilities.technKnow', minLen: 100, label: 'abilities (overviewAbilities.technKnow)' },
  { key: 'detailWlb.wlbDetail', minLen: 130, label: 'wlbDetail' },
  { key: 'detailWlb.socialDetail', minLen: 100, label: 'socialDetail' },
  { key: 'detailReady.curriculum', minLen: null, minCount: 5, label: 'curriculum (array)' },
  { key: 'detailReady.recruit', minLen: null, minCount: 3, label: 'recruit (array)' },
  { key: 'detailReady.training', minLen: null, minCount: 2, label: 'training (array)' },
  { key: 'detailReady.researchList', minLen: null, label: 'researchList (careernet 원본 보존)' },
  { key: 'detailReady.certificate', minLen: null, label: 'certificate (보존)' },
  { key: 'detailReady.pathExplore', minLen: null, label: 'pathExplore (보존)' },
];

const SIDEBAR_FIELDS = [
  { key: 'sidebarJobs', minCount: 7, label: 'sidebarJobs' },
  { key: 'sidebarMajors', minCount: 3, label: 'sidebarMajors' },
  { key: 'sidebarCerts', minCount: 2, label: 'sidebarCerts' },
  { key: 'sidebarOrgs', minCount: 1, label: 'sidebarOrgs' },
];

const AUX_FIELDS = [
  { key: 'detailWlb.wlb', label: 'wlb 등급' },
  { key: 'detailWlb.social', label: 'social 등급' },
  { key: 'heroTags', minCount: 4, label: 'heroTags' },
  { key: 'youtubeLinks', minCount: 1, label: 'youtubeLinks' },
  // careerTree는 별도 테이블 (career_trees + career_tree_job_links)로 저장됨.
  // merged_profile_json.careerTree만 보면 ETL 미반영 케이스에서 false negative 발생.
  // 2026-05-12 사고 (건축사·경제학연구원·CRM): prod 페이지에 careerTree 정상 렌더되지만
  // diag가 "NULL" 표시. DB 진실은 career_tree_job_links.job_slug = j.slug JOIN으로 검사.
  // → AUX_FIELDS에서 분리. 아래 careerTreeLinkCount로 별도 출력.
];

// SQL 자동 생성
function buildSelectClauses(fields) {
  const parts = [];
  for (const f of fields) {
    const path = '$.' + f.key;
    const safeKey = f.key.replace(/[.]/g, '_');
    parts.push(`json_type(merged_profile_json,'${path}') AS ${safeKey}_type`);
    parts.push(`length(json_extract(merged_profile_json,'${path}')) AS ${safeKey}_len`);
    parts.push(`json_array_length(merged_profile_json,'${path}') AS ${safeKey}_count`);
  }
  return parts.join(', ');
}

// 메인 SQL — jobs row + JSON path 추출
const sql = `SELECT j.id, j.slug, j.name, ${buildSelectClauses([...PROSE_BODY_FIELDS, ...SIDEBAR_FIELDS, ...AUX_FIELDS])}, json_extract(user_contributed_json,'$._sources') AS sources_json FROM jobs j WHERE slug='${slug}';`;

// careerTree 진실 SQL — 별도 테이블 JOIN (2026-05-12 fix).
// merged_profile_json.careerTree는 ETL 미반영 시 NULL이지만 실제 페이지엔 노출됨.
// career_trees + career_tree_job_links.job_slug = slug 로 진실 link 카운트 조회.
const careerTreeSql = `SELECT COUNT(*) AS link_count FROM career_tree_job_links ctjl JOIN career_trees ct ON ct.id = ctjl.career_tree_id WHERE ctjl.job_slug='${slug}' AND ct.is_active = 1;`;

const r = spawnSync('cmd.exe', ['/c', 'npx', 'wrangler', 'd1', 'execute', 'careerwiki-kr', '--remote', '--command', sql, '--json'], { encoding: 'utf8' });

let data;
try {
  data = JSON.parse(r.stdout)[0].results[0];
} catch (e) {
  console.error('SQL fail:', r.stderr.slice(-300));
  process.exit(1);
}

if (!data) {
  console.error(`Job not found: ${slug}`);
  process.exit(1);
}

// careerTree 진실 link_count 조회 (선택적 — 실패해도 진단 계속)
let careerTreeLinkCount = null;
try {
  const ctr = spawnSync('cmd.exe', ['/c', 'npx', 'wrangler', 'd1', 'execute', 'careerwiki-kr', '--remote', '--command', careerTreeSql, '--json'], { encoding: 'utf8' });
  const ctParsed = JSON.parse(ctr.stdout)[0].results[0];
  if (ctParsed && typeof ctParsed.link_count === 'number') {
    careerTreeLinkCount = ctParsed.link_count;
  }
} catch (e) {
  // careerTree 조회 실패는 fatal X — null로 표시
}

const sources = data.sources_json ? JSON.parse(data.sources_json) : {};
const sourceKeys = new Set(Object.keys(sources));

function statusFor(field, type, len, count) {
  const safeKey = field.key.replace(/[.]/g, '_');
  if (type === null || type === undefined) return '❌ NULL';
  if (field.minLen && len !== null) {
    if (len === 0) return '❌ 0자';
    if (len < field.minLen) return `⚠️ ${len}자 (권장 ${field.minLen}자+)`;
    return `✅ ${len}자`;
  }
  if (field.minCount !== undefined) {
    const c = count || 0;
    if (c === 0) return '❌ 0개';
    if (c < field.minCount) return `⚠️ ${c}개 (권장 ${field.minCount}개+)`;
    return `✅ ${c}개`;
  }
  if (field.minLen === null && len !== null) return `✅ ${len}자 (보존)`;
  if (count !== null) return `✅ ${count}개`;
  if (len !== null) return `✅ ${len}자`;
  return `✅ ${type}`;
}

console.log(`\n[${data.name || slug}] WL-KILL Self-Report (21+ 영역 자동 enumerate)\n`);

let missingCount = 0;

console.log('== Prose Body 14 영역 (audit OMEGA 자동 검출) ==');
PROSE_BODY_FIELDS.forEach((f, i) => {
  const safeKey = f.key.replace(/[.]/g, '_');
  const type = data[`${safeKey}_type`];
  const len = data[`${safeKey}_len`];
  const count = data[`${safeKey}_count`];
  const status = statusFor(f, type, len, count);
  const hasSrc = sourceKeys.has(f.key) ? ` _sources(${sources[f.key].length})` : ' _sources(0)';
  if (status.startsWith('❌') || status.startsWith('⚠️')) missingCount++;
  console.log(`  ${i + 1}. ${f.label}: ${status}${hasSrc}`);
});

console.log('\n== Sidebar 4 영역 ==');
SIDEBAR_FIELDS.forEach((f, i) => {
  const safeKey = f.key.replace(/[.]/g, '_');
  const type = data[`${safeKey}_type`];
  const count = data[`${safeKey}_count`];
  const len = data[`${safeKey}_len`];
  const status = statusFor(f, type, len, count);
  if (status.startsWith('❌') || status.startsWith('⚠️')) missingCount++;
  console.log(`  ${i + 15}. ${f.label}: ${status}`);
});

console.log('\n== 보조 영역 ==');
AUX_FIELDS.forEach((f, i) => {
  const safeKey = f.key.replace(/[.]/g, '_');
  const type = data[`${safeKey}_type`];
  const count = data[`${safeKey}_count`];
  const len = data[`${safeKey}_len`];
  const status = statusFor(f, type, len, count);
  if (status.startsWith('❌')) missingCount++;
  console.log(`  ${i + 19}. ${f.label}: ${status}`);
});

// careerTree — 별도 테이블 진실 (2026-05-12 fix; AUX_FIELDS에서 분리)
let ctStatus;
if (careerTreeLinkCount === null) ctStatus = '⚠️ (DB 조회 실패 — career_trees 테이블 접근 불가)';
else if (careerTreeLinkCount === 0) ctStatus = '❌ 0건';
else ctStatus = `✅ ${careerTreeLinkCount}건 (career_tree_job_links)`;
if (ctStatus.startsWith('❌')) missingCount++;
console.log(`  ${AUX_FIELDS.length + 19}. careerTree (별도 테이블 진실): ${ctStatus}`);

console.log('\n== _sources 등록 키 ==');
console.log(`  ${[...sourceKeys].join(', ') || '(none)'}`);

console.log(`\n== WL-KILL 진단 결과 ==`);
console.log(`  미작업/부실 영역: ${missingCount}개`);
console.log(`  → 각 영역 patch 또는 skip 사유 명시 의무. patch 계획 작성 후 Phase 3 진행.`);
console.log(`  → changeSummary에 patch 영역 list + skip 영역 사유 명시 강제.\n`);
