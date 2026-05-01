#!/usr/bin/env node
// scripts/skill-cache/prepare-suspect-rebuild.cjs
// 의심직업 14건의 현재 본문 + _sources 상태 fetch → context json
//
// 사용:
//   node scripts/skill-cache/prepare-suspect-rebuild.cjs --slug={slug} --out=.tmp-rebuild-{slug}.json

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

if (!args.slug) { console.error('--slug=X --out=Y'); process.exit(2); }

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

const FIELDS = [
  'summary', 'way', 'trivia',
  'overviewProspect.main', 'overviewSalary.sal',
  'detailWlb.wlbDetail', 'detailWlb.socialDetail',
  'overviewAbilities.technKnow',
  'detailReady.curriculum', 'detailReady.recruit', 'detailReady.training',
];

function getNested(obj, dotted) { return dotted.split('.').reduce((cur, p) => cur?.[p], obj); }

const sql = `SELECT id, slug, user_contributed_json FROM jobs WHERE slug='${args.slug.replace(/'/g, "''")}'`;
const rows = d1Query(sql);
if (rows.length === 0) { console.error('not found'); process.exit(1); }
const r = rows[0];
const ucj = JSON.parse(r.user_contributed_json || '{}');
const sources = ucj._sources || {};

const bodies = {};
const sourcesNow = {};
const markersInBody = {};
for (const f of FIELDS) {
  const val = getNested(ucj, f);
  if (val !== undefined && val !== null) {
    bodies[f] = val;
    if (typeof val === 'string') {
      const m = (val.match(/\[(\d+)\]/g) || []).map(x => parseInt(x.slice(1, -1), 10));
      markersInBody[f] = m;
    } else if (Array.isArray(val)) {
      // detailReady.* arrays
      const m = [];
      val.forEach(item => {
        if (typeof item === 'string') {
          const ms = (item.match(/\[(\d+)\]/g) || []).map(x => parseInt(x.slice(1, -1), 10));
          m.push(...ms);
        }
      });
      markersInBody[f] = m;
    }
  }
  if (sources[f]) sourcesNow[f] = sources[f];
}

const out = {
  slug: r.slug,
  id: r.id,
  bodies,
  sourcesNow,
  markersInBody,
  fieldStats: Object.fromEntries(FIELDS.map(f => [
    f,
    {
      hasBody: bodies[f] !== undefined,
      sourcesCount: (sources[f] || []).length,
      markersCount: (markersInBody[f] || []).length,
      maxMarker: Math.max(0, ...(markersInBody[f] || [])),
    }
  ])),
};

const outPath = args.out || `.tmp-rebuild-${args.slug}.json`;
fs.writeFileSync(path.resolve(REPO_ROOT, outPath), JSON.stringify(out, null, 2), 'utf8');
console.log(`saved: ${outPath}`);
