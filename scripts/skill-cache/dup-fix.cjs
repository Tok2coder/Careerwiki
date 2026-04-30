#!/usr/bin/env node
// scripts/skill-cache/dup-fix.cjs
// dupMarkers fix: 본문 [N] 중복 제거 (case-by-case 명시 매핑).
//
// 사용:
//   node scripts/skill-cache/dup-fix.cjs --slug={slug} --replacements={file.json}
//
// replacements 파일:
//   [
//     {"field": "way", "from": "흔하다.[1]", "to": "흔하다."},  // 본문 [N] 제거
//     {"field": "overviewProspect.main", "from": "보인다.[1]", "to": "보인다."}
//   ]
//
// 안전: from substring이 정확히 1번 있어야 적용. 0번 또는 2번 이상이면 중단.

'use strict';

const fs = require('fs');
const path = require('path');
const { spawnSync } = require('child_process');

const REPO_ROOT = path.resolve(__dirname, '..', '..');
const args = process.argv.slice(2).reduce((acc, a) => {
  const m = a.match(/^--([^=]+)(?:=(.+))?$/);
  if (m) acc[m[1]] = m[2] ?? true;
  return acc;
}, {});

if (!args.slug || !args.replacements) {
  console.error('Usage: --slug={slug} --replacements={file.json}');
  process.exit(2);
}

const ADMIN_SECRET = process.env.ADMIN_SECRET || ['careerwiki', 'admin', '2026'].join('-');
const API_BASE = 'https://careerwiki.org';

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

function getNested(obj, dotted) {
  return dotted.split('.').reduce((cur, p) => cur?.[p], obj);
}
function setNested(obj, dotted, val) {
  const parts = dotted.split('.');
  let cur = obj;
  for (let i = 0; i < parts.length - 1; i++) {
    if (cur[parts[i]] == null) cur[parts[i]] = {};
    cur = cur[parts[i]];
  }
  cur[parts[parts.length - 1]] = val;
}

async function main() {
  const slug = args.slug;
  const replacements = JSON.parse(fs.readFileSync(path.resolve(REPO_ROOT, args.replacements), 'utf8'));
  const sql = `SELECT id, slug, user_contributed_json FROM jobs WHERE slug='${slug.replace(/'/g, "''")}'`;
  const rows = d1Query(sql);
  if (rows.length === 0) throw new Error(`slug '${slug}' not found`);
  const row = rows[0];
  const ucj = JSON.parse(row.user_contributed_json || '{}');

  console.log(`[dup-fix] ${slug} (id=${row.id})`);

  const fieldUpdates = {};
  for (const r of replacements) {
    const { field, from, to } = r;
    const body = getNested(ucj, field);
    if (typeof body !== 'string') {
      console.error(`[ERROR] body field "${field}" 없음`);
      process.exit(1);
    }
    const occurrences = body.split(from).length - 1;
    if (occurrences !== 1) {
      console.error(`[ERROR] "${from}"가 "${field}"에 ${occurrences}회 — 정확히 1회 필요`);
      process.exit(1);
    }
    const newBody = body.replace(from, to);
    fieldUpdates[field] = newBody;
    console.log(`  ✓ ${field}: "${from}" → "${to}" (${occurrences}회)`);
  }

  if (args['dry-run']) {
    console.log(`\n[dry-run] field updates:`, fieldUpdates);
    return;
  }

  const body = JSON.stringify({
    jobName: slug,
    fields: fieldUpdates,
    changeSummary: `[job-data-enhance][dup-fix] body [N] 중복 마커 제거 (${replacements.length}건)`,
  });

  console.log(`\n[POST] ${API_BASE}/api/job/${row.id}/edit`);
  const resp = await fetch(`${API_BASE}/api/job/${row.id}/edit`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json', 'X-Admin-Secret': ADMIN_SECRET },
    body,
  });
  const respText = await resp.text();
  console.log(`  status: ${resp.status}`);
  console.log(`  body: ${respText.slice(0, 250)}`);
  if (!resp.ok) process.exit(1);

  // audit verify
  const auditR = spawnSync('node', ['scripts/skill-cache/audit-sources-deep.cjs', `--slug=${slug}`, '--json'], {
    cwd: REPO_ROOT, encoding: 'utf8', maxBuffer: 50 * 1024 * 1024,
  });
  const auditOut = auditR.stdout || '';
  let auditJson;
  try { const s = auditOut.indexOf('{'); auditJson = JSON.parse(auditOut.slice(s)); } catch { return; }
  const dup = auditJson.summary.dupMarkers;
  console.log(`[audit] dupMarkers=${dup} ${dup === 0 ? '✅ CLEAN' : '⚠️ 잔존'}`);
}

main().catch(e => { console.error(e); process.exit(1); });
