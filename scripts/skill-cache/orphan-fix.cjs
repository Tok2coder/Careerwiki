#!/usr/bin/env node
// scripts/skill-cache/orphan-fix.cjs
// orphanSrc 자동 fix: _sources tail entries 중 본문 [N] 매핑 없는 것 제거.
//
// 알고리즘:
// 1) DB에서 job UCJ + body fields fetch
// 2) 각 field별 body [N] 마커 max 계산
// 3) _sources[field] 길이를 body max로 truncate (tail orphan 제거)
// 4) POST /api/job/{id}/edit (sources만 patch)
// 5) audit 검증
//
// 사용:
//   node scripts/skill-cache/orphan-fix.cjs --slug={slug} [--dry-run]

'use strict';

const fs = require('fs');
const path = require('path');
const { spawnSync } = require('child_process');

// audit-sources-deep.cjs와 동일한 BODY_FIELDS 정의 — 이 fields의 _sources만 orphan으로 인정
const BODY_FIELDS = [
  'way',
  'trivia',
  'overviewProspect.main',
  'overviewSalary.sal',
  'detailWlb.wlbDetail',
  'detailWlb.socialDetail',
  'overviewAbilities.technKnow',
  'summary',
];

const REPO_ROOT = path.resolve(__dirname, '..', '..');
const args = process.argv.slice(2).reduce((acc, a) => {
  const m = a.match(/^--([^=]+)(?:=(.+))?$/);
  if (m) acc[m[1]] = m[2] ?? true;
  return acc;
}, {});

if (!args.slug) {
  console.error('Usage: --slug={slug} [--dry-run]');
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

function getNestedField(obj, dotted) {
  const parts = dotted.split('.');
  let cur = obj;
  for (const p of parts) {
    if (cur == null) return undefined;
    cur = cur[p];
  }
  return cur;
}

function maxMarkerInBody(text) {
  if (!text || typeof text !== 'string') return 0;
  const matches = text.match(/\[(\d+)\]/g) || [];
  let max = 0;
  for (const m of matches) {
    const n = parseInt(m.slice(1, -1), 10);
    if (n > max) max = n;
  }
  return max;
}

async function main() {
  const slug = args.slug;
  const sql = `SELECT id, slug, user_contributed_json FROM jobs WHERE slug='${slug.replace(/'/g, "''")}'`;
  const rows = d1Query(sql);
  if (rows.length === 0) throw new Error(`slug '${slug}' DB에서 못 찾음`);
  const row = rows[0];
  const ucj = JSON.parse(row.user_contributed_json || '{}');
  const sources = ucj._sources || {};

  console.log(`[orphan-fix] ${slug} (id=${row.id})`);
  console.log(`  현재 _sources fields: ${Object.keys(sources).length}개`);

  const newSources = JSON.parse(JSON.stringify(sources));
  const changes = [];

  // sources patch payload: truncate or delete per field
  const sourcesPatch = {};
  for (const field of Object.keys(newSources)) {
    if (!BODY_FIELDS.includes(field)) continue; // ARRAY_FIELDS는 orphan 대상 아님
    const arr = newSources[field];
    if (!Array.isArray(arr)) continue;

    // body text from UCJ
    const body = getNestedField(ucj, field) ?? '';
    const bodyMax = maxMarkerInBody(body);

    if (arr.length > bodyMax) {
      changes.push({ field, before: arr.length, after: bodyMax, removed: arr.length - bodyMax });
      if (bodyMax === 0) {
        // 전체 제거 (빈 배열 보내도 editService가 무시 — delete:true로 명시)
        sourcesPatch[field] = { delete: true };
      } else {
        // truncate (editService는 normalized array로 overwrite)
        sourcesPatch[field] = arr.slice(0, bodyMax);
      }
    }
  }

  if (changes.length === 0) {
    console.log(`  이미 CLEAN — 제거할 orphan 없음`);
    return;
  }

  console.log(`  truncate ${changes.length} fields:`);
  changes.forEach(c => console.log(`    ${c.field}: ${c.before} → ${c.after} (${c.removed}건 제거)`));

  if (args['dry-run']) {
    const outPath = path.resolve(REPO_ROOT, `data/orphan-fix-dryrun-${slug}.json`);
    fs.writeFileSync(outPath, JSON.stringify({ slug, id: row.id, before: sources, after: newSources, changes }, null, 2), 'utf8');
    console.log(`[dry-run] 변경사항 저장: ${outPath}`);
    return;
  }

  const body = JSON.stringify({
    jobName: slug,
    fields: {},
    sources: sourcesPatch,
    changeSummary: `[job-data-enhance][orphan-fix] _sources tail orphan ${changes.reduce((s, c) => s + c.removed, 0)}건 제거`,
  });

  console.log(`\n[POST] ${API_BASE}/api/job/${row.id}/edit ...`);
  const url = `${API_BASE}/api/job/${row.id}/edit`;
  const resp = await fetch(url, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json', 'X-Admin-Secret': ADMIN_SECRET },
    body,
  });
  const respText = await resp.text();
  console.log(`  status: ${resp.status}`);
  console.log(`  body: ${respText.slice(0, 300)}`);
  if (!resp.ok) {
    console.error(`[FAIL] POST 실패`);
    process.exit(1);
  }

  // audit verify
  console.log(`\n[audit] node scripts/skill-cache/audit-sources-deep.cjs --slug=${slug} --json`);
  const auditR = spawnSync('node', ['scripts/skill-cache/audit-sources-deep.cjs', `--slug=${slug}`, '--json'], {
    cwd: REPO_ROOT, encoding: 'utf8', maxBuffer: 50 * 1024 * 1024,
  });
  const auditOut = auditR.stdout || '';
  let auditJson;
  try {
    const start = auditOut.indexOf('{');
    auditJson = JSON.parse(auditOut.slice(start));
  } catch (e) {
    console.error(`[audit] JSON parse 실패: ${e.message}`);
    return;
  }
  const sum = auditJson.summary;
  const orphanCount = sum.orphanSrc;
  const status = orphanCount === 0 ? '✅ CLEAN' : `⚠️ orphan 잔존: ${orphanCount}`;
  console.log(`[audit] ${status}`);
  for (const [k, v] of Object.entries(sum)) {
    if (k === 'total_jobs' || k === 'clean') continue;
    if (v > 0) console.log(`  ${k}: ${v}`);
  }
  console.log(`DONE: ${slug} orphan-fix=${orphanCount === 0 ? 'CLEAN' : 'PARTIAL'}`);
}

main().catch(e => { console.error(e); process.exit(1); });
