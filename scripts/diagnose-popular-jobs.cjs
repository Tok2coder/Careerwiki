#!/usr/bin/env node
// Diagnose enhancement status of popular_jobs_validated.txt
// Outputs status (COMPLETE/PARTIAL/STUB/EMPTY) per slug + UCJ field count
// Excludes the 9 already done in batches 46/47/48 + already-done jobs from prior batches.

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

const slugs = fs.readFileSync(path.resolve(__dirname, '..', 'popular_jobs_validated.txt'), 'utf8')
  .split(/\r?\n/).map(s => s.trim()).filter(Boolean);

console.log(`Total popular jobs: ${slugs.length}`);

// Build IN list
const inList = slugs.map(s => `'${s.replace(/'/g, "''")}'`).join(',');

const sql = `
SELECT
  j.slug,
  COALESCE(LENGTH(j.user_contributed_json), 0) AS ucj_len,
  CASE WHEN json_extract(j.user_contributed_json, '$.way') IS NOT NULL THEN 1 ELSE 0 END AS f_way,
  CASE WHEN json_extract(j.user_contributed_json, '$.trivia') IS NOT NULL THEN 1 ELSE 0 END AS f_trivia,
  CASE WHEN json_extract(j.user_contributed_json, '$.youtubeLinks') IS NOT NULL THEN 1 ELSE 0 END AS f_yt,
  CASE WHEN json_extract(j.user_contributed_json, '$.heroTag') IS NOT NULL THEN 1 ELSE 0 END AS f_hero,
  CASE WHEN json_extract(j.user_contributed_json, '$.careerSummary') IS NOT NULL THEN 1 ELSE 0 END AS f_summary,
  CASE WHEN json_extract(j.user_contributed_json, '$.dailyLife') IS NOT NULL THEN 1 ELSE 0 END AS f_daily,
  CASE WHEN json_extract(j.user_contributed_json, '$.detailWlb') IS NOT NULL THEN 1 ELSE 0 END AS f_wlb,
  CASE WHEN json_extract(j.user_contributed_json, '$.overviewSalary') IS NOT NULL THEN 1 ELSE 0 END AS f_sal,
  CASE WHEN json_extract(j.user_contributed_json, '$.curriculum') IS NOT NULL THEN 1 ELSE 0 END AS f_curri,
  CASE WHEN json_extract(j.user_contributed_json, '$.training') IS NOT NULL THEN 1 ELSE 0 END AS f_train,
  CASE WHEN json_extract(j.user_contributed_json, '$.recruit') IS NOT NULL THEN 1 ELSE 0 END AS f_recruit,
  CASE WHEN json_extract(j.user_contributed_json, '$.sidebarOrgs') IS NOT NULL THEN 1 ELSE 0 END AS f_sidebar,
  CASE WHEN json_extract(j.user_contributed_json, '$.relatedTags') IS NOT NULL THEN 1 ELSE 0 END AS f_tags,
  CASE WHEN json_extract(j.user_contributed_json, '$.entryHurdle') IS NOT NULL THEN 1 ELSE 0 END AS f_hurdle,
  CASE WHEN json_extract(j.user_contributed_json, '$.licenseDetail') IS NOT NULL THEN 1 ELSE 0 END AS f_license,
  CASE WHEN json_extract(j.user_contributed_json, '$.outlookDetail') IS NOT NULL THEN 1 ELSE 0 END AS f_outlook,
  COALESCE(ct.cnt, 0) AS ct_links
FROM jobs j
LEFT JOIN (SELECT job_slug, COUNT(*) cnt FROM career_tree_job_links GROUP BY job_slug) ct ON ct.job_slug = j.slug
WHERE j.slug IN (${inList})
ORDER BY j.slug
`;

console.log('Querying D1 (remote)...');
// Pass via --command (wrangler --file does NOT return SELECT rows)
const oneLine = sql.replace(/\s+/g, ' ').trim();
const out = execSync(`npx wrangler d1 execute careerwiki-kr --remote --json --command ${JSON.stringify(oneLine)}`, {
  cwd: path.resolve(__dirname, '..'),
  encoding: 'utf8',
  maxBuffer: 100 * 1024 * 1024,
  shell: true,
});

let parsed;
try {
  parsed = JSON.parse(out);
} catch (e) {
  // wrangler sometimes prepends text; try to find JSON
  const m = out.match(/\[\s*\{[\s\S]*\]\s*$/);
  if (!m) throw e;
  parsed = JSON.parse(m[0]);
}

const rows = parsed[0]?.results || [];
const bySlug = new Map(rows.map(r => [r.slug, r]));

// Field checklist (17 weighted): way, trivia, yt, hero, summary, daily, wlb, sal, curri, train, recruit, sidebar, tags, hurdle, license, outlook, ct_links
const FIELD_KEYS = ['f_way','f_trivia','f_yt','f_hero','f_summary','f_daily','f_wlb','f_sal','f_curri','f_train','f_recruit','f_sidebar','f_tags','f_hurdle','f_license','f_outlook'];

const buckets = { COMPLETE: [], PARTIAL: [], STUB: [], EMPTY: [], MISSING: [] };

for (const slug of slugs) {
  const r = bySlug.get(slug);
  if (!r) {
    buckets.MISSING.push({ slug });
    continue;
  }
  const fieldCount = FIELD_KEYS.reduce((a, k) => a + (r[k] || 0), 0);
  const ctOk = (r.ct_links || 0) >= 1;
  const status = (() => {
    if (r.ucj_len === 0) return 'EMPTY';
    if (r.ucj_len < 1000) return 'STUB';
    // PARTIAL/COMPLETE based on field coverage
    // COMPLETE: 14+ of 16 fields AND ct_links≥1 AND UCJ≥3500
    if (fieldCount >= 14 && ctOk && r.ucj_len >= 3500) return 'COMPLETE';
    return 'PARTIAL';
  })();
  buckets[status].push({ slug, ucj_len: r.ucj_len, fieldCount, ct_links: r.ct_links });
}

console.log('\n=== STATUS SUMMARY ===');
for (const k of ['EMPTY','MISSING','STUB','PARTIAL','COMPLETE']) {
  console.log(`${k}: ${buckets[k].length}`);
}

// Recently-done in batches 46-51 (skip even if PARTIAL)
const RECENTLY_DONE = new Set([
  // 46/47/48
  '패션어드바이저','패션코디네이터','스타일리스트','편집-디자이너','공예가','상업사진작가','선물큐레이터','박물관관리자','일반공무원',
  // 49/50/51
  '사회복지전담공무원','해양경찰관','수어통역사','조경설계사','산업용기계설계기술자','플랜트기계공학기술자','천문학연구원','발전환경연구원','곤충식품연구원',
  // 52/53/54
  '창업기획자','총무인사관리자','최고마케팅책임자','퀵배달원','버스운전기사','택시운전기사','신약개발연구원','유전공학연구원','산업공학기술자',
  // 55/56/57
  '평론가','카피라이터','광고모델','검사','노무사','벤처캐피탈투자심사역','우편물집배원','철도여행상품개발원','양사육사',
  // 58/59/60
  '지휘자','성악가','국악인','방송연출가','방송작가','드라마작가','손해사정사','보험설계사','보험계리사',
  // 61/62/63
  '한식조리사','양식조리사','일식조리사','법원공무원','청원경찰','집배원','총무사무원','경리사무원','금융관리자',
  // 64/65/66
  '화학연구원','의학연구원','지질학연구원','섬유공학기술자','토목감리기술자','항공공학기술자','여행안내원','항공기객실승무원','웨딩플래너',
  // 67/68/69
  '화가','조각가','잡지기자','택배원','선박기관사','조경기술자','심리상담전문가','청소년지도사','통역가',
  // 추가로 발견된 사실상 처리됨 (Phase 7 / 수동 보완 등)
  '일러스트레이터',
  // 사실상 처리됨 (마커 또는 수동 보완)
  '연극연출가','외환딜러','작곡가','특수학교교사','영화감독','미용사','사서','가수','감정평가사',
  '모델','대중가수','드론조종사','물류관리사','입학사정관','바텐더','비서','재무관리자','건축감리기술자',
  '게임시나리오작가','관광통역안내원','기상캐스터','호텔지배인',
]);

console.log(`\n=== PROGRESS ===`);
console.log(`Total popular: ${slugs.length}`);
console.log(`RECENTLY_DONE list: ${RECENTLY_DONE.size}`);
console.log(`Approx done %: ${(RECENTLY_DONE.size/slugs.length*100).toFixed(1)}%`);

const candidates = [
  ...buckets.EMPTY,
  ...buckets.MISSING,
  ...buckets.STUB,
  ...buckets.PARTIAL.sort((a, b) => a.fieldCount - b.fieldCount), // lowest field count first
];

const filtered = candidates.filter(c => !RECENTLY_DONE.has(c.slug));

console.log('\n=== TOP 30 NEXT CANDIDATES (after excluding recently done) ===');
filtered.slice(0, 30).forEach((c, i) => {
  const status = buckets.EMPTY.find(x => x.slug === c.slug) ? 'EMPTY'
              : buckets.MISSING.find(x => x.slug === c.slug) ? 'MISSING'
              : buckets.STUB.find(x => x.slug === c.slug) ? 'STUB'
              : 'PARTIAL';
  console.log(`${String(i+1).padStart(2)}. [${status.padEnd(7)}] ${c.slug}  ucj=${c.ucj_len ?? 0} fields=${c.fieldCount ?? 0} ct=${c.ct_links ?? 0}`);
});

// Show order in popular_jobs_validated for top candidates
console.log('\n=== POPULAR ORDER POSITION OF TOP 30 ===');
filtered.slice(0, 30).forEach((c, i) => {
  const idx = slugs.indexOf(c.slug);
  console.log(`${String(i+1).padStart(2)}. ${c.slug}  popular#${idx+1}`);
});

console.log('\n=== STUB DETAILS ===');
buckets.STUB.forEach(c => {
  console.log(`${c.slug}  ucj=${c.ucj_len} fields=${c.fieldCount} ct=${c.ct_links}`);
});

console.log('\n=== PARTIAL — ct>=2 (excluding recently done) ===');
buckets.PARTIAL
  .filter(c => !RECENTLY_DONE.has(c.slug) && c.ct_links >= 2)
  .sort((a,b) => a.ucj_len - b.ucj_len)
  .slice(0, 60)
  .forEach(c => {
    console.log(`${c.slug}\tucj=${c.ucj_len}\tct=${c.ct_links}\tfields=${c.fieldCount}`);
  });
