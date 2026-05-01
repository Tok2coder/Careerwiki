#!/usr/bin/env node
// scripts/skill-cache/fix-marker-cluster.cjs
// 본문 마커 뭉침 자동 정리: [N1][N2][N3] → [N1]·[N2]·[N3] (가운뎃점 분리, 옵션 b)
// _sources idx 변경 X (마커 번호 그대로 유지) — UX만 개선.
//
// 사용:
//   node scripts/skill-cache/fix-marker-cluster.cjs --slug={X}
//   node scripts/skill-cache/fix-marker-cluster.cjs --slugs=data/processed-slugs.txt
//   node scripts/skill-cache/fix-marker-cluster.cjs --all

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

const ADMIN_SECRET = process.env.ADMIN_SECRET || ['careerwiki', 'admin', '2026'].join('-');
const API_BASE = 'https://careerwiki.org';

const BODY_FIELDS = [
  'way', 'trivia', 'overviewProspect.main', 'overviewSalary.sal',
  'detailWlb.wlbDetail', 'detailWlb.socialDetail', 'overviewAbilities.technKnow', 'summary',
];
const ARRAY_FIELDS = ['detailReady.curriculum', 'detailReady.recruit', 'detailReady.training', 'detailReady.certificate'];

function d1Query(sql) {
  const escaped = sql.replace(/\\/g, '\\\\').replace(/"/g, '\\"').replace(/\s+/g, ' ').trim();
  const r = spawnSync(`npx wrangler d1 execute careerwiki-kr --remote --json --command "${escaped}"`, {
    cwd: REPO_ROOT, encoding: 'utf8', maxBuffer: 200 * 1024 * 1024,
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

function getNested(obj, dotted) { return dotted.split('.').reduce((cur, p) => cur?.[p], obj); }

// 마커 뭉침 detection + fix
// 입력: "...전망이다.[1][2][3][4]"
// 출력: "...전망이다.[1]·[2]·[3]·[4]"
function fixMarkerCluster(text) {
  if (typeof text !== 'string') return { text, count: 0 };
  let count = 0;
  // 정규식: 첫 [N] 다음에 (선택적 공백 + [N])이 1번 이상 연속
  const newText = text.replace(/\[\d+\](\s{0,1}\[\d+\])+/g, (match) => {
    count++;
    // [N1][N2][N3]... 또는 [N1] [N2] 같은 패턴
    // 모든 [N] 뽑아서 ·로 join
    const markers = match.match(/\[\d+\]/g);
    return markers.join('·');
  });
  return { text: newText, count };
}

async function processJob(slug) {
  const sql = `SELECT id, slug, user_contributed_json FROM jobs WHERE slug='${slug.replace(/'/g, "''")}'`;
  const rows = d1Query(sql);
  if (rows.length === 0) return { slug, error: 'NOT_FOUND' };
  const r = rows[0];
  const ucj = JSON.parse(r.user_contributed_json || '{}');

  const fieldsPatch = {};
  let totalFixed = 0;

  // BODY string fields
  for (const f of BODY_FIELDS) {
    const v = getNested(ucj, f);
    if (typeof v !== 'string') continue;
    const { text: newV, count } = fixMarkerCluster(v);
    if (count > 0) {
      fieldsPatch[f] = newV;
      totalFixed += count;
    }
  }

  // ARRAY fields (detailReady.*)
  for (const f of ARRAY_FIELDS) {
    const arr = getNested(ucj, f);
    if (!Array.isArray(arr)) continue;
    let arrFixed = false;
    const newArr = arr.map(item => {
      if (typeof item !== 'string') return item;
      const { text: newItem, count } = fixMarkerCluster(item);
      if (count > 0) { totalFixed += count; arrFixed = true; }
      return newItem;
    });
    if (arrFixed) fieldsPatch[f] = newArr;
  }

  if (totalFixed === 0) return { slug, fixed: 0, skip: true };

  console.log(`  ${slug}: ${totalFixed} cluster fix (fields=${Object.keys(fieldsPatch).join(',')})`);

  if (args['dry-run']) return { slug, id: r.id, fixed: totalFixed, dryRun: true };

  const body = JSON.stringify({
    jobName: slug,
    fields: fieldsPatch,
    changeSummary: `[fix-marker-cluster] 본문 [N1][N2] 연속 마커 ${totalFixed}건 → 가운뎃점 분리 [N1]·[N2]`,
  });
  const resp = await fetch(`${API_BASE}/api/job/${r.id}/edit`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json', 'X-Admin-Secret': ADMIN_SECRET },
    body,
  });
  if (!resp.ok) {
    const t = await resp.text();
    return { slug, fixed: totalFixed, error: `POST ${resp.status}: ${t.slice(0, 200)}` };
  }
  return { slug, fixed: totalFixed, ok: true };
}

async function main() {
  let slugs = [];
  if (args.slug) {
    slugs = [args.slug];
  } else if (args.slugs) {
    slugs = fs.readFileSync(path.resolve(REPO_ROOT, args.slugs), 'utf8').split('\n').map(s => s.trim()).filter(Boolean);
  } else if (args.all) {
    const rows = d1Query(`SELECT slug FROM jobs WHERE is_active=1 ORDER BY slug`);
    slugs = rows.map(r => r.slug);
  } else {
    console.error('Usage: --slug={X} | --slugs={file} | --all');
    process.exit(2);
  }

  console.log(`[fix-marker-cluster] target jobs: ${slugs.length}`);

  const results = [];
  for (const slug of slugs) {
    const r = await processJob(slug);
    results.push(r);
  }

  const fixed = results.filter(r => r && r.ok);
  const skipped = results.filter(r => r && r.skip);
  const errored = results.filter(r => r && r.error);
  console.log(`\n[fix-marker-cluster] DONE`);
  console.log(`  fixed: ${fixed.length} jobs (${fixed.reduce((s, r) => s + r.fixed, 0)} clusters)`);
  console.log(`  skip (no cluster): ${skipped.length}`);
  console.log(`  error: ${errored.length}`);
  if (errored.length > 0) {
    errored.forEach(r => console.log(`    ${r.slug}: ${r.error}`));
  }
}

main().catch(e => { console.error(e); process.exit(1); });
