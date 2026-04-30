#!/usr/bin/env node
// scripts/skill-cache/purge-suspect-jobs.cjs
// 특정 직업 list의 SUSPECT URL 전체 제거 (hallucination 의심 직업 wholesale 정리).
//
// 사용:
//   node scripts/skill-cache/purge-suspect-jobs.cjs --verify=data/url-verify-result-v2.json --jobs=캐디,가상현실전문가,...

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
function listMarkers(body) {
  if (typeof body !== 'string') return [];
  const re = /\[(\d+)\]/g;
  const out = []; let m;
  while ((m = re.exec(body)) !== null) {
    out.push({ start: m.index, end: m.index + m[0].length, marker: parseInt(m[1], 10) });
  }
  return out;
}
function removeAndRenumber(body, sources, removeIdxSet) {
  if (!Array.isArray(sources) || sources.length === 0) return { newBody: body, newSources: sources, removed: 0 };
  const keepIdxs = sources.map((_, i) => i).filter(i => !removeIdxSet.has(i));
  const oldToNew = {};
  keepIdxs.forEach((oldIdx, newIdx) => { oldToNew[oldIdx] = newIdx; });
  const markers = listMarkers(body);
  let newBody = body;
  for (let i = markers.length - 1; i >= 0; i--) {
    const m = markers[i];
    const oldArrIdx = m.marker - 1;
    if (oldToNew[oldArrIdx] !== undefined) {
      const newMarker = `[${oldToNew[oldArrIdx] + 1}]`;
      newBody = newBody.slice(0, m.start) + newMarker + newBody.slice(m.end);
    } else {
      let removeStart = m.start;
      while (removeStart > 0 && /\s/.test(newBody[removeStart - 1])) removeStart--;
      newBody = newBody.slice(0, removeStart) + newBody.slice(m.end);
    }
  }
  return { newBody, newSources: keepIdxs.map(i => sources[i]), removed: removeIdxSet.size };
}

async function main() {
  const verify = JSON.parse(fs.readFileSync(path.resolve(REPO_ROOT, args.verify), 'utf8'));
  const targetJobs = (args.jobs || '').split(',').map(s => s.trim()).filter(Boolean);
  if (targetJobs.length === 0) { console.error('--jobs=slug1,slug2 필수'); process.exit(2); }

  // build removalMap: target job's SUSPECT URLs
  const removalMap = new Map();
  for (const s of verify.suspect) {
    if (!targetJobs.includes(s.slug)) continue;
    if (!removalMap.has(s.slug)) removalMap.set(s.slug, new Map());
    const fmap = removalMap.get(s.slug);
    if (!fmap.has(s.field)) fmap.set(s.field, new Set());
    fmap.get(s.field).add(s.arrIdx);
  }

  console.log(`[purge-suspect] 대상 직업: ${targetJobs.length}, 발견된 SUSPECT 직업: ${removalMap.size}`);

  const slugIn = targetJobs.map(s => `'${s.replace(/'/g, "''")}'`).join(',');
  const rows = d1Query(`SELECT id, slug, user_contributed_json FROM jobs WHERE slug IN (${slugIn})`);
  const ucjMap = new Map(rows.map(r => [r.slug, { id: r.id, ucj: JSON.parse(r.user_contributed_json || '{}') }]));

  let totalRemoved = 0, totalJobs = 0, failed = 0;
  for (const [slug, fmap] of removalMap) {
    const data = ucjMap.get(slug);
    if (!data) continue;
    const { id, ucj } = data;
    const sources = ucj._sources || {};
    const sourcesPatch = {};
    const fieldsPatch = {};
    let jobRemoved = 0;
    for (const [field, idxSet] of fmap) {
      if (!Array.isArray(sources[field])) continue;
      const isBody = BODY_FIELDS.includes(field);
      const body = isBody ? (getNested(ucj, field) || '') : '';
      const { newBody, newSources, removed } = removeAndRenumber(body, sources[field], idxSet);
      jobRemoved += removed;
      if (newSources.length === 0) sourcesPatch[field] = { delete: true };
      else sourcesPatch[field] = newSources;
      if (isBody && newBody !== body) fieldsPatch[field] = newBody;
    }
    if (jobRemoved === 0) continue;
    console.log(`  ${slug}: ${jobRemoved} URL 제거 (fields=${Object.keys(fieldsPatch).join(',')})`);

    if (args['dry-run']) { totalRemoved += jobRemoved; totalJobs++; continue; }
    const body = JSON.stringify({
      jobName: slug,
      fields: fieldsPatch,
      sources: sourcesPatch,
      changeSummary: `[url-verify][purge-suspect] hallucination 의심 SUSPECT URL ${jobRemoved}건 제거 + 본문 [N] 재번호`,
    });
    const resp = await fetch(`${API_BASE}/api/job/${id}/edit`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json', 'X-Admin-Secret': ADMIN_SECRET },
      body,
    });
    if (!resp.ok) { console.error(`    [FAIL] ${slug} status=${resp.status}: ${(await resp.text()).slice(0, 200)}`); failed++; continue; }
    totalRemoved += jobRemoved;
    totalJobs++;
  }
  console.log(`\n[purge-suspect] DONE — ${totalJobs} jobs, ${totalRemoved} URLs removed, ${failed} failed`);
}

main().catch(e => { console.error(e); process.exit(1); });
