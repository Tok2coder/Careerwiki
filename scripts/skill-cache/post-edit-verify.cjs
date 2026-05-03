#!/usr/bin/env node
// scripts/skill-cache/post-edit-verify.cjs
// /api/job/{id}/edit POST 직후 자동 _sources URL HEAD fetch 검증.
// BROKEN 발견 시 즉시 alert (exit 1) — dispatch session prompt의 Phase 5-VERIFY에서 호출.
//
// 사용:
//   node scripts/skill-cache/post-edit-verify.cjs --slug={slug}
//   node scripts/skill-cache/post-edit-verify.cjs --slug={slug} --strict   (BROKEN 1건이라도 exit 1)
//
// 결과:
//   exit 0 — 모든 URL 200 OK (또는 BROKEN ≤ tolerance)
//   exit 1 — BROKEN 발견 (rollback 또는 즉시 fix 필요)

'use strict';

const path = require('path');
const { spawnSync } = require('child_process');

const REPO_ROOT = path.resolve(__dirname, '..', '..');
const args = process.argv.slice(2).reduce((acc, a) => {
  const m = a.match(/^--([^=]+)(?:=(.+))?$/);
  if (m) acc[m[1]] = m[2] ?? true;
  return acc;
}, {});

if (!args.slug) {
  console.error('Usage: --slug={slug} [--strict] [--tolerance=N]');
  process.exit(2);
}

const TOLERANCE = parseInt(args.tolerance || (args.strict ? '0' : '0'), 10);

function d1Query(sql) {
  const escaped = sql.replace(/\\/g, '\\\\').replace(/"/g, '\\"').replace(/\s+/g, ' ').trim();
  const r = spawnSync(`npx wrangler d1 execute careerwiki-kr --remote --json --command "${escaped}"`, {
    cwd: REPO_ROOT, encoding: 'utf8', maxBuffer: 100 * 1024 * 1024,
    shell: true, windowsHide: true,
  });
  const out = (r.stdout || '').trim();
  const start = out.indexOf('[');
  if (start < 0) return [];
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

const TIMEOUT = 6000;
// HEAD fetch + GET retry on 400/403/404/405/501 (HEAD 차단·미지원 사이트 false positive 차단).
// audit-sources-deep.cjs의 verifyUrlsForJobs와 동일 정책 (2026-05-01/05-03 commit 79f0fbe 후속).
async function checkUrl(url) {
  const headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36',
    'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
    'Accept-Language': 'ko,en-US;q=0.9,en;q=0.8',
  };
  try {
    const ac = new AbortController();
    const t = setTimeout(() => ac.abort(), TIMEOUT);
    let resp;
    try {
      resp = await fetch(url, { method: 'HEAD', signal: ac.signal, redirect: 'follow', headers });
    } catch {
      resp = await fetch(url, { method: 'GET', signal: ac.signal, redirect: 'follow', headers });
    }
    // HEAD 차단·미지원 → GET retry (400/403/404/405/501)
    if (resp && (resp.status === 400 || resp.status === 403 || resp.status === 404 || resp.status === 405 || resp.status === 501)) {
      try {
        resp = await fetch(url, { method: 'GET', signal: ac.signal, redirect: 'follow', headers });
      } catch { /* keep original resp */ }
    }
    clearTimeout(t);
    if (!resp || resp.status >= 400) return { ok: false, status: resp ? resp.status : 'NO_RESPONSE' };
    return { ok: true, status: resp.status };
  } catch (e) {
    const msg = String(e.message || e);
    let status = 'FETCH_ERR';
    if (msg.includes('CERT')) status = 'SSL_ERROR';
    else if (msg.includes('ENOTFOUND')) status = 'DNS_ERROR';
    else if (msg.includes('aborted') || msg.includes('timeout')) status = 'TIMEOUT';
    return { ok: false, status };
  }
}

async function main() {
  const slug = args.slug;
  const sql = `SELECT slug, user_contributed_json FROM jobs WHERE slug='${slug.replace(/'/g, "''")}'`;
  const rows = d1Query(sql);
  if (rows.length === 0) { console.error(`[post-edit-verify] slug '${slug}' not found`); process.exit(1); }
  const ucj = JSON.parse(rows[0].user_contributed_json || '{}');
  const sources = ucj._sources || {};

  const urls = [];
  for (const [field, arr] of Object.entries(sources)) {
    if (!Array.isArray(arr)) continue;
    arr.forEach((s, idx) => { if (s && s.url) urls.push({ field, idx, url: s.url }); });
  }

  if (urls.length === 0) { console.log(`[post-edit-verify] ${slug}: _sources URL 0건 — skip`); process.exit(0); }

  console.log(`[post-edit-verify] ${slug}: ${urls.length} URLs HEAD fetch 검증 중...`);

  const concurrency = 8;
  const queue = [...urls];
  const broken = [];
  await Promise.all(Array(concurrency).fill(0).map(async () => {
    while (queue.length > 0) {
      const u = queue.shift();
      const r = await checkUrl(u.url);
      if (!r.ok) broken.push({ ...u, status: r.status });
    }
  }));

  if (broken.length === 0) {
    console.log(`[post-edit-verify] ✅ ${slug}: ${urls.length}/${urls.length} URL OK`);
    process.exit(0);
  }

  console.log(`[post-edit-verify] ⚠️ ${slug}: BROKEN ${broken.length}/${urls.length}`);
  broken.forEach(b => console.log(`  [${b.field}#${b.idx}] HTTP ${b.status} — ${b.url}`));

  if (broken.length > TOLERANCE) {
    console.log(`[post-edit-verify] ❌ FAIL — BROKEN ${broken.length} > tolerance ${TOLERANCE}. fix 필요 (purge-broken-urls.cjs 호출 또는 다른 출처로 교체).`);
    process.exit(1);
  }
  console.log(`[post-edit-verify] ⚠️ PASS WITH BROKEN — ${broken.length} ≤ ${TOLERANCE} 허용 범위`);
  process.exit(0);
}

main().catch(e => { console.error(e); process.exit(1); });
