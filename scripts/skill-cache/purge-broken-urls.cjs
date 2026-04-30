#!/usr/bin/env node
// scripts/skill-cache/purge-broken-urls.cjs
// url-verify-result.json의 BROKEN/일부 SUSPECT URL을 _sources에서 제거.
// 본문 [N] 매핑 깨지지 않도록 entry 제거 시 본문 [N] 마커도 같이 제거.
//
// 정책:
// - BROKEN: 무조건 제거
// - SUSPECT redirect-to-root: 제거 (deep link 실존 안 함)
// - SUSPECT redirect-host (도메인 변경): 제거 (URL 폐기됨)
// - SUSPECT no-keyword-match: 일단 유지 (false alarm 가능성)
//
// 사용:
//   node scripts/skill-cache/purge-broken-urls.cjs --verify=data/url-verify-result.json [--dry-run]

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
function setNested(obj, dotted, val) {
  const parts = dotted.split('.');
  let cur = obj;
  for (let i = 0; i < parts.length - 1; i++) {
    if (cur[parts[i]] == null) cur[parts[i]] = {};
    cur = cur[parts[i]];
  }
  cur[parts[parts.length - 1]] = val;
}

// 본문에서 [N] 마커들 위치/번호 list 반환 (occurrence 순)
function listMarkers(body) {
  if (typeof body !== 'string') return [];
  const re = /\[(\d+)\]/g;
  const out = [];
  let m;
  while ((m = re.exec(body)) !== null) {
    out.push({ start: m.index, end: m.index + m[0].length, marker: parseInt(m[1], 10), text: m[0] });
  }
  return out;
}

// _sources[field] entries 중 removeIdxSet에 있는 idx (0-based) 제거 + 본문 [N] 마커 재번호.
// removeIdxSet = Set<number> (0-based arrIdx)
// returns {newBody, newSources, removed}
function removeAndRenumber(body, sources, removeIdxSet) {
  if (!Array.isArray(sources) || sources.length === 0) return { newBody: body, newSources: sources, removed: 0 };
  // build mapping old idx → new idx
  const keepIdxs = sources.map((_, i) => i).filter(i => !removeIdxSet.has(i));
  const oldToNew = {};
  keepIdxs.forEach((oldIdx, newIdx) => { oldToNew[oldIdx] = newIdx; });

  // body marker N (1-based) → arrIdx N-1
  // For body, replace each [N] with new [N'] if mapped, else remove the marker.
  const markers = listMarkers(body);
  // process from end to start to preserve offsets
  let newBody = body;
  for (let i = markers.length - 1; i >= 0; i--) {
    const m = markers[i];
    const oldArrIdx = m.marker - 1;
    if (oldToNew[oldArrIdx] !== undefined) {
      const newMarker = `[${oldToNew[oldArrIdx] + 1}]`;
      newBody = newBody.slice(0, m.start) + newMarker + newBody.slice(m.end);
    } else {
      // remove marker (and one preceding space if any "...word [N]" → "...word")
      let removeStart = m.start;
      // strip preceding whitespace if sentence ends right before
      while (removeStart > 0 && /\s/.test(newBody[removeStart - 1])) removeStart--;
      newBody = newBody.slice(0, removeStart) + newBody.slice(m.end);
    }
  }

  const newSources = keepIdxs.map(i => sources[i]);
  return { newBody, newSources, removed: removeIdxSet.size };
}

async function main() {
  const verifyPath = args.verify || 'data/url-verify-result.json';
  const verify = JSON.parse(fs.readFileSync(path.resolve(REPO_ROOT, verifyPath), 'utf8'));

  // group BROKEN + suspect-redirect by slug+field+arrIdx
  const removalMap = new Map(); // slug → field → Set<arrIdx>
  const addRemoval = (slug, field, arrIdx) => {
    if (!removalMap.has(slug)) removalMap.set(slug, new Map());
    const fmap = removalMap.get(slug);
    if (!fmap.has(field)) fmap.set(field, new Set());
    fmap.get(field).add(arrIdx);
  };

  for (const b of verify.broken) addRemoval(b.slug, b.field, b.arrIdx);
  for (const s of verify.suspect) {
    const reasons = s.reasons || [];
    if (reasons.includes('redirect-to-root')) addRemoval(s.slug, s.field, s.arrIdx);
    // redirect-host: 일부는 정상 도메인 이전이지만 안전을 위해 제거
    if (reasons.some(r => r.startsWith('redirect-host:'))) addRemoval(s.slug, s.field, s.arrIdx);
  }

  const slugList = [...removalMap.keys()];
  console.log(`[purge] target jobs: ${slugList.length}`);

  // batch fetch UCJ
  const slugIn = slugList.map(s => `'${s.replace(/'/g, "''")}'`).join(',');
  const rows = d1Query(`SELECT id, slug, user_contributed_json FROM jobs WHERE slug IN (${slugIn})`);
  const ucjMap = new Map(rows.map(r => [r.slug, { id: r.id, ucj: JSON.parse(r.user_contributed_json || '{}') }]));

  let totalRemoved = 0, totalJobs = 0, failedJobs = 0;
  for (const slug of slugList) {
    const data = ucjMap.get(slug);
    if (!data) { console.error(`[skip] ${slug} not in DB`); continue; }
    const { id, ucj } = data;
    const sources = ucj._sources || {};
    const removalsByField = removalMap.get(slug);

    // build sourcesPatch + fields update
    const sourcesPatch = {};
    const fieldsPatch = {};
    let jobRemoved = 0;
    for (const [field, idxSet] of removalsByField) {
      if (!Array.isArray(sources[field])) continue;
      const isBodyField = BODY_FIELDS.includes(field);
      const body = isBodyField ? (getNested(ucj, field) || '') : '';
      const { newBody, newSources, removed } = removeAndRenumber(body, sources[field], idxSet);
      jobRemoved += removed;
      if (newSources.length === 0) {
        sourcesPatch[field] = { delete: true };
      } else {
        sourcesPatch[field] = newSources;
      }
      if (isBodyField && newBody !== body) {
        fieldsPatch[field] = newBody;
      }
    }

    if (jobRemoved === 0) continue;
    console.log(`  ${slug}: ${jobRemoved} URL 제거 (fields=${Object.keys(fieldsPatch).join(',')})`);

    if (args['dry-run']) {
      totalRemoved += jobRemoved;
      totalJobs++;
      continue;
    }

    const body = JSON.stringify({
      jobName: slug,
      fields: fieldsPatch,
      sources: sourcesPatch,
      changeSummary: `[url-verify][purge] BROKEN/redirect URL ${jobRemoved}건 제거 + 본문 [N] 재번호`,
    });
    const resp = await fetch(`${API_BASE}/api/job/${id}/edit`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json', 'X-Admin-Secret': ADMIN_SECRET },
      body,
    });
    if (!resp.ok) {
      console.error(`    [FAIL] ${slug} status=${resp.status}: ${(await resp.text()).slice(0, 200)}`);
      failedJobs++;
      continue;
    }
    totalRemoved += jobRemoved;
    totalJobs++;
  }

  console.log(`\n[purge] DONE — ${totalJobs} jobs, ${totalRemoved} URLs removed, ${failedJobs} failed`);
  if (args['dry-run']) console.log(`[dry-run] DB 변경 안 함`);
}

main().catch(e => { console.error(e); process.exit(1); });
