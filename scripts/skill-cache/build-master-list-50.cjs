#!/usr/bin/env node
// scripts/skill-cache/build-master-list-50.cjs
// audit-sources-deep.json에서 사고 풀 50건 산출 + jobs.id fetch.
// 산출: data/master-list-50.json + 콘솔 요약 표.

'use strict';

const fs = require('fs');
const path = require('path');
const { spawnSync } = require('child_process');

const REPO_ROOT = path.resolve(__dirname, '..', '..');
const AUDIT = path.join(REPO_ROOT, 'data', 'audit-sources-deep.json');
const OUT = path.join(REPO_ROOT, 'data', 'master-list-50.json');

const EXCLUDE = new Set(['수의사보조원', '만화가', '사서', '경제학연구원', '리포터']);

function d1Query(sql) {
  const escaped = sql.replace(/\\/g, '\\\\').replace(/"/g, '\\"').replace(/\s+/g, ' ').trim();
  const r = spawnSync(`npx wrangler d1 execute careerwiki-kr --remote --json --command "${escaped}"`, {
    cwd: REPO_ROOT, encoding: 'utf8', maxBuffer: 100 * 1024 * 1024,
    shell: true, windowsHide: true,
  });
  const out = (r.stdout || '').trim();
  const start = out.indexOf('[');
  if (start < 0) return [];
  // brace-balanced 추출 — wrangler가 trailing 텍스트 붙일 수 있음
  let depth = 0, end = -1, inStr = false, esc = false;
  for (let i = start; i < out.length; i++) {
    const c = out[i];
    if (esc) { esc = false; continue; }
    if (c === '\\') { esc = true; continue; }
    if (c === '"') { inStr = !inStr; continue; }
    if (inStr) continue;
    if (c === '[') depth++;
    else if (c === ']') { depth--; if (depth === 0) { end = i + 1; break; } }
  }
  if (end < 0) end = out.length;
  return JSON.parse(out.slice(start, end))[0]?.results || [];
}

const data = JSON.parse(fs.readFileSync(AUDIT, 'utf8'));

// 사고 풀 필터 — 사용자 지정 4 패턴 OR
const candidates = data.jobs.filter(j =>
  !EXCLUDE.has(j.slug) && (
    j.rawURL.length >= 1 ||
    j.brokenRef.length >= 1 ||
    j.selfCiteOnly === true ||
    j.mojibake.length >= 1
  )
);

// 정렬: 사고 합계 (severity) 내림차순
function severity(j) {
  return (j.rawURL.length || 0) +
         (j.brokenRef.length || 0) +
         (j.selfCiteOnly ? 5 : 0) +
         (j.mojibake.length || 0) * 10 +
         (j.listPage.length || 0) +
         (j.orphanSrc.length || 0) * 0.5;
}
candidates.sort((a, b) => severity(b) - severity(a));

const top50 = candidates.slice(0, 50);

// 사고 분류 (1줄 요약용)
function classify(j) {
  const tags = [];
  if (j.mojibake.length) tags.push(`mojibake×${j.mojibake.length}`);
  if (j.selfCiteOnly) tags.push('selfCiteOnly');
  if (j.listPage.length) tags.push(`listPage×${j.listPage.length}`);
  if (j.brokenRef.length) tags.push(`brokenRef×${j.brokenRef.length}`);
  if (j.rawURL.length) tags.push(`rawURL×${j.rawURL.length}`);
  if (j.orphanSrc.length) tags.push(`orphan×${j.orphanSrc.length}`);
  if (j.dupMarkers.length) tags.push(`dup×${j.dupMarkers.length}`);
  if (j.idxGap) tags.push('idxGap');
  if (j.selfCite.length) tags.push(`selfCite×${j.selfCite.length}`);
  return tags.join(' / ');
}

function summary(j) {
  const parts = [];
  if (j.mojibake.length) parts.push(`인코딩 깨짐 ${j.mojibake.length}건`);
  if (j.selfCiteOnly) parts.push(`외부 host 0개 — origin(career.go.kr/work.go.kr) 단독`);
  if (j.listPage.length) parts.push(`인덱스 URL ${j.listPage.length}건 (직업 specific URL로 교체)`);
  if (j.brokenRef.length) parts.push(`본문 [N] vs _sources 길이 mismatch ${j.brokenRef.length}건`);
  if (j.rawURL.length) parts.push(`_sources.text가 raw URL ${j.rawURL.length}건 (기관명 교체)`);
  if (j.orphanSrc.length) parts.push(`_sources 등록만 본문 미사용 ${j.orphanSrc.length}건`);
  return parts.join('; ');
}

// id fetch from D1
const slugList = top50.map(j => `'${j.slug.replace(/'/g, "''")}'`).join(',');
const sql = `SELECT id, slug FROM jobs WHERE slug IN (${slugList})`;
console.error(`[build-master-list-50] D1에서 ${top50.length}개 id fetch 중...`);
const idRows = d1Query(sql);
const idMap = new Map(idRows.map(r => [r.slug, r.id]));

const final = top50.map(j => ({
  slug: j.slug,
  id: idMap.get(j.slug) || null,
  totalUrls: j.totalUrls,
  uniqueHosts: j.uniqueHosts,
  externalHostCount: j.externalHostCount,
  patterns: {
    rawURL: j.rawURL.length,
    brokenRef: j.brokenRef.length,
    orphanSrc: j.orphanSrc.length,
    selfCite: j.selfCite.length,
    selfCiteOnly: j.selfCiteOnly,
    listPage: j.listPage.length,
    mojibake: j.mojibake.length,
    dupMarkers: j.dupMarkers.length,
    idxGap: !!j.idxGap,
  },
  severity: severity(j),
  tags: classify(j),
  fixSummary: summary(j),
  // 상세 (재검증·prompt 작성에 활용)
  details: {
    rawURL: j.rawURL,
    brokenRef: j.brokenRef,
    listPage: j.listPage,
    mojibake: j.mojibake,
    orphanSrc: j.orphanSrc,
    selfCiteHosts: [...new Set((j.selfCite || []).map(s => s.host))],
  },
}));

// 누락 id 검사
const missing = final.filter(f => !f.id);
if (missing.length > 0) {
  console.error(`⚠️ id 미매칭 ${missing.length}건: ${missing.map(m => m.slug).join(', ')}`);
}

// 분포 요약
const dist = {
  total: final.length,
  withMojibake: final.filter(f => f.patterns.mojibake > 0).length,
  withSelfCiteOnly: final.filter(f => f.patterns.selfCiteOnly).length,
  withListPage: final.filter(f => f.patterns.listPage > 0).length,
  withBrokenRef: final.filter(f => f.patterns.brokenRef > 0).length,
  withRawURL: final.filter(f => f.patterns.rawURL > 0).length,
  withOrphan: final.filter(f => f.patterns.orphanSrc > 0).length,
  withDup: final.filter(f => f.patterns.dupMarkers > 0).length,
  withIdxGap: final.filter(f => f.patterns.idxGap).length,
};

const out = {
  generated_at: new Date().toISOString(),
  source: 'data/audit-sources-deep.json',
  filter: 'rawURL≥1 OR brokenRef≥1 OR selfCiteOnly=YES OR mojibake≥1; exclude 5 done',
  excluded: [...EXCLUDE],
  distribution: dist,
  jobs: final,
};
fs.writeFileSync(OUT, JSON.stringify(out, null, 2), 'utf8');
console.error(`[build-master-list-50] 저장: ${OUT}`);

// 콘솔 요약 표
console.log('\n=== master-list-50 요약 ===\n');
console.log('분포:');
console.log(`  total                   ${dist.total}`);
console.log(`  mojibake × ≥1            ${dist.withMojibake}`);
console.log(`  selfCiteOnly             ${dist.withSelfCiteOnly}`);
console.log(`  listPage × ≥1            ${dist.withListPage}`);
console.log(`  brokenRef × ≥1           ${dist.withBrokenRef}`);
console.log(`  rawURL × ≥1              ${dist.withRawURL}`);
console.log(`  orphan × ≥1              ${dist.withOrphan}`);
console.log(`  dupMarkers × ≥1          ${dist.withDup}`);
console.log(`  idxGap                   ${dist.withIdxGap}`);
console.log('');

console.log(`${'#'.padStart(3)} | ${'slug'.padEnd(20)} | sev | URL | ext | uniq | 사고 패턴`);
console.log('-'.repeat(110));
final.forEach((f, i) => {
  console.log(
    `${String(i + 1).padStart(3)} | ${f.slug.padEnd(20)} | ${String(f.severity.toFixed(1)).padStart(4)} | ${String(f.totalUrls).padStart(3)} | ${String(f.externalHostCount).padStart(3)} | ${String(f.uniqueHosts).padStart(4)} | ${f.tags}`
  );
});
