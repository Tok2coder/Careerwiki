#!/usr/bin/env node
// scripts/skill-cache/audit-omega-full.cjs
// 362 master pool 전수 OMEGA 재감사 — 룰 OMEGA (2026-05-15) 통합 자동 스캔.
// 화이트리스트 폐기 — _proseRaw·detailReady·_sources 키 자동 enumerate.
// 사용: node scripts/skill-cache/audit-omega-full.cjs [--slugs slug1,slug2] [--out path] [--concurrency N]

'use strict';

const path = require('path');
const fs = require('fs');
const REPO_ROOT = path.resolve(__dirname, '..', '..');
const { detectAllBodySourceMarkerMismatch } = require(
  path.join(REPO_ROOT, 'scripts', '_shared', 'detect-patterns.cjs'),
);

const SAL_PROTECTED = new Set(['overviewSalary.sal']);

async function fetchJob(slug) {
  const url = 'https://careerwiki.org/api/job/' + encodeURIComponent(slug) + '/edit-data';
  const r = await fetch(url, { headers: { 'Cache-Control': 'no-cache' } });
  if (r.status !== 200) return { error: 'HTTP ' + r.status };
  const j = await r.json();
  if (!j.success) return { error: j.error || 'API failure' };
  return { data: j.data };
}

function analyzeOmega(slug, data) {
  const proseRaw = data._proseRaw || {};
  // sal 영역 prose 제외
  const filteredPr = {};
  for (const [k, v] of Object.entries(proseRaw)) {
    if (SAL_PROTECTED.has(k)) continue;
    filteredPr[k] = v;
  }
  const detailReady = data.detailReady || {};
  const sources = (data._sources && typeof data._sources === 'object') ? data._sources : {};
  const filteredSrcs = {};
  for (const [k, v] of Object.entries(sources)) {
    if (SAL_PROTECTED.has(k)) continue;
    filteredSrcs[k] = v;
  }
  const findings = detectAllBodySourceMarkerMismatch(filteredPr, detailReady, filteredSrcs);
  const fails = findings.filter(f => f.severity === 'FAIL');
  const warns = findings.filter(f => f.severity === 'WARN');
  return {
    slug,
    failCount: fails.length,
    warnCount: warns.length,
    fails,
    warns,
  };
}

async function withConcurrency(items, n, worker) {
  const out = [];
  let i = 0;
  async function next() {
    while (i < items.length) {
      const idx = i++;
      try {
        out[idx] = await worker(items[idx], idx);
      } catch (e) {
        out[idx] = { error: e instanceof Error ? e.message : String(e) };
      }
    }
  }
  await Promise.all(Array.from({ length: n }, next));
  return out;
}

(async () => {
  const argv = process.argv.slice(2);
  let slugs = null;
  let outPath = null;
  let concurrency = 8;
  for (let i = 0; i < argv.length; i++) {
    if (argv[i] === '--slugs') slugs = argv[++i].split(',').filter(Boolean);
    else if (argv[i] === '--out') outPath = argv[++i];
    else if (argv[i] === '--concurrency') concurrency = parseInt(argv[++i], 10) || 8;
  }

  if (!slugs) {
    // master pool 자동 로드
    const poolPath = process.env.MASTER_POOL_JSON || (process.platform === 'win32'
      ? 'C:\\Users\\user\\AppData\\Local\\Temp\\master-pool.json'
      : '/tmp/master-pool.json');
    if (fs.existsSync(poolPath)) {
      const raw = JSON.parse(fs.readFileSync(poolPath, 'utf8'));
      slugs = raw[0]?.results?.map(r => r.slug) || [];
    } else {
      console.error('사용: --slugs slug1,slug2 또는 MASTER_POOL_JSON 환경변수로 pool 파일 경로 지정');
      process.exit(1);
    }
  }

  console.log('[audit-omega-full] target slugs:', slugs.length, '| concurrency:', concurrency);
  const startTs = Date.now();

  const results = await withConcurrency(slugs, concurrency, async (slug, idx) => {
    if ((idx + 1) % 20 === 0) console.log('  progress: ' + (idx + 1) + '/' + slugs.length);
    const r = await fetchJob(slug);
    if (r.error) return { slug, error: r.error };
    return analyzeOmega(slug, r.data);
  });

  const elapsed = ((Date.now() - startTs) / 1000).toFixed(1);
  const total = results.length;
  const failed = results.filter(r => r.failCount > 0).length;
  const errors = results.filter(r => r.error).length;

  console.log('\n=== Summary ===');
  console.log('Total:', total, '| FAIL:', failed, '| ERROR:', errors, '| Elapsed:', elapsed + 's');

  // 사고 영역 카운트
  const ruleCounts = {};
  for (const r of results) {
    if (!r.fails) continue;
    for (const f of r.fails) {
      const key = f.rule + ':' + f.area;
      ruleCounts[key] = (ruleCounts[key] || 0) + 1;
    }
  }
  console.log('\n=== Rule breakdown ===');
  Object.entries(ruleCounts).sort((a, b) => b[1] - a[1])
    .forEach(([k, v]) => console.log(' ', k, '=', v));

  if (outPath) {
    const out = {
      timestamp: new Date().toISOString(),
      total,
      failed,
      errors,
      elapsed_sec: parseFloat(elapsed),
      ruleCounts,
      results,
    };
    fs.writeFileSync(outPath, JSON.stringify(out, null, 2));
    console.log('\nWritten to', outPath);
  }
})();
