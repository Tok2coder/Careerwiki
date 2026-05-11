#!/usr/bin/env node
// Phase D' — master skill 적용 362 직업 ZZZZ + ZZZ 합산 audit
// 결과: ZZZ FAIL + ZZZZ FAIL + 합산 (중복 제거) slug 리스트

'use strict';
const fs = require('fs');
const path = require('path');
const REPO_ROOT = path.resolve(__dirname, '..', '..');
const {
  detectSourcesWithoutMarkers,
  detectOrphanSources,
} = require(path.join(REPO_ROOT, 'scripts', '_shared', 'detect-patterns.cjs'));

const SLUG_FILE = path.join(__dirname, '_master-slugs.json');
const OUT_FILE = path.join(__dirname, '_phaseD2-result.json');

async function fetchJob(slug) {
  try {
    const url = `https://careerwiki.org/api/job/${encodeURIComponent(slug)}/edit-data`;
    const r = await fetch(url, { headers: { 'Cache-Control': 'no-cache' } });
    if (r.status !== 200) return { error: `HTTP ${r.status}` };
    const j = await r.json();
    if (!j.success) return { error: j.error || 'API failure' };
    return { data: j.data };
  } catch (e) {
    return { error: String(e?.message || e) };
  }
}

const CONCURRENCY = 8;

async function runWorker(queue, results) {
  while (queue.length) {
    const slug = queue.shift();
    if (!slug) break;
    const r = await fetchJob(slug);
    if (r.error) {
      results.push({ slug, error: r.error });
      process.stdout.write(`E`);
      continue;
    }
    const proseRaw = r.data._proseRaw || {};
    const detailReady = r.data.detailReady || {};
    const sources = r.data._sources || {};
    const zzz = detectSourcesWithoutMarkers(proseRaw, detailReady, sources);
    const zzzz = detectOrphanSources(proseRaw, detailReady, sources, r.data);
    results.push({ slug, zzz, zzzz });
    const flag = zzz.length > 0 || zzzz.length > 0 ? '!' : '.';
    process.stdout.write(flag);
  }
}

(async () => {
  const slugs = JSON.parse(fs.readFileSync(SLUG_FILE, 'utf8'));
  console.log(`Auditing ${slugs.length} jobs (Rule ZZZ + ZZZZ)`);
  console.log(`Concurrency: ${CONCURRENCY}`);

  const queue = [...slugs];
  const results = [];
  const workers = Array.from({length: CONCURRENCY}, () => runWorker(queue, results));
  await Promise.all(workers);
  console.log('');

  const zzzFails = results.filter(r => !r.error && r.zzz && r.zzz.length > 0);
  const zzzzFails = results.filter(r => !r.error && r.zzzz && r.zzzz.length > 0);
  const combined = new Set([...zzzFails.map(r => r.slug), ...zzzzFails.map(r => r.slug)]);
  const errors = results.filter(r => r.error);

  // 필드별 빈도
  const zzzFieldCnt = {};
  for (const r of zzzFails) for (const f of r.zzz) zzzFieldCnt[f.field] = (zzzFieldCnt[f.field] || 0) + 1;
  const zzzzFieldCnt = {};
  for (const r of zzzzFails) for (const f of r.zzzz) zzzzFieldCnt[f.field] = (zzzzFieldCnt[f.field] || 0) + 1;
  const zzzzAreaCnt = {};
  for (const r of zzzzFails) for (const f of r.zzzz) zzzzAreaCnt[f.area] = (zzzzAreaCnt[f.area] || 0) + 1;

  console.log(`\n=== Phase D' Summary ===`);
  console.log(`Total audited: ${results.length}`);
  console.log(`ZZZ FAIL:      ${zzzFails.length}`);
  console.log(`ZZZZ FAIL:     ${zzzzFails.length}`);
  console.log(`Combined (unique): ${combined.size}`);
  console.log(`Errors:        ${errors.length}`);

  console.log(`\n=== ZZZ 필드별 분포 ===`);
  for (const [k, v] of Object.entries(zzzFieldCnt).sort((a,b)=>b[1]-a[1])) console.log(`  ${k.padEnd(30)} ${v}`);

  console.log(`\n=== ZZZZ 필드별 분포 ===`);
  for (const [k, v] of Object.entries(zzzzFieldCnt).sort((a,b)=>b[1]-a[1])) console.log(`  ${k.padEnd(30)} ${v}`);

  console.log(`\n=== ZZZZ area별 분포 ===`);
  for (const [k, v] of Object.entries(zzzzAreaCnt).sort((a,b)=>b[1]-a[1])) console.log(`  ${k.padEnd(30)} ${v}`);

  console.log(`\n=== ZZZ FAIL slugs (${zzzFails.length}) ===`);
  for (const r of zzzFails) {
    const f = r.zzz.map(x => `${x.field}(${x.bodyLen}/${x.srcsCount})`).join(', ');
    console.log(`  ${r.slug.padEnd(35)} ${f}`);
  }

  console.log(`\n=== ZZZZ FAIL slugs (${zzzzFails.length}) ===`);
  for (const r of zzzzFails) {
    const f = r.zzzz.map(x => `${x.field}[${x.area}/${x.srcsCount}]`).join(', ');
    console.log(`  ${r.slug.padEnd(35)} ${f}`);
  }

  console.log(`\n=== Combined unique FAIL slugs (${combined.size}) ===`);
  for (const s of [...combined].sort()) console.log(`  ${s}`);

  if (errors.length > 0) {
    console.log(`\n=== Errors (${errors.length}) ===`);
    for (const e of errors) console.log(`  ${e.slug.padEnd(35)} ${e.error}`);
  }

  fs.writeFileSync(OUT_FILE, JSON.stringify({
    auditedAt: new Date().toISOString(),
    total: results.length,
    zzzCount: zzzFails.length,
    zzzzCount: zzzzFails.length,
    combinedCount: combined.size,
    errorCount: errors.length,
    zzzFieldCnt, zzzzFieldCnt, zzzzAreaCnt,
    zzzFails: zzzFails.map(r => ({ slug: r.slug, findings: r.zzz })),
    zzzzFails: zzzzFails.map(r => ({ slug: r.slug, findings: r.zzzz })),
    combinedSlugs: [...combined].sort(),
    errors: errors.map(e => ({ slug: e.slug, error: e.error })),
  }, null, 2));
  console.log(`\nResult saved: ${OUT_FILE}`);
})();
