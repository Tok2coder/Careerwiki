#!/usr/bin/env node
// scripts/skill-cache/apply-rebuild.cjs
// Agent로부터 받은 verified URL을 _sources에 추가 + 본문 [N] 마커 추가/재정렬.
//
// 입력 형식 (.tmp-rebuild-batch1.json):
// {
//   "캐디": [{"field":"trivia","url":"...","text":"..."}, ...],
//   ...
// }
//
// 룰:
// - origin domain (career/work/work24/wagework/job .go.kr) 자동 제외
// - BODY field (string): 기존 본문 끝에 [1]..[N] 추가
// - ARRAY field (detailReady.*): 각 item에 순차 [1]..[N] 마커 추가, 나머지 item 마커 제거
//
// 사용:
//   node scripts/skill-cache/apply-rebuild.cjs --batch=.tmp-rebuild-batch1.json [--dry-run]

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

if (!args.batch) { console.error('--batch=file.json 필수'); process.exit(2); }

const ADMIN_SECRET = process.env.ADMIN_SECRET || ['careerwiki', 'admin', '2026'].join('-');
const API_BASE = 'https://careerwiki.org';

const ORIGIN_HOSTS = [
  'www.career.go.kr', 'career.go.kr',
  'www.work.go.kr', 'work.go.kr', 'm.work.go.kr',
  'www.work24.go.kr', 'work24.go.kr',
  'www.wagework.go.kr', 'wagework.go.kr',
  'www.job.go.kr', 'job.go.kr',
];

const BODY_FIELDS = [
  'way', 'trivia', 'overviewProspect.main', 'overviewSalary.sal',
  'detailWlb.wlbDetail', 'detailWlb.socialDetail', 'overviewAbilities.technKnow', 'summary',
];
const ARRAY_FIELDS = ['detailReady.curriculum', 'detailReady.recruit', 'detailReady.training'];

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
function isOriginUrl(url) {
  try { return ORIGIN_HOSTS.includes(new URL(url).hostname); } catch { return false; }
}

function stripMarkers(s) {
  if (typeof s !== 'string') return s;
  return s.replace(/\s*\[\d+\]/g, '');
}

async function processJob(slug, recs) {
  // fetch UCJ
  const sql = `SELECT id, slug, user_contributed_json FROM jobs WHERE slug='${slug.replace(/'/g, "''")}'`;
  const rows = d1Query(sql);
  if (rows.length === 0) { console.error(`  [skip] ${slug} not found`); return null; }
  const r = rows[0];
  const ucj = JSON.parse(r.user_contributed_json || '{}');

  // filter origin
  const filtered = recs.filter(rec => {
    if (isOriginUrl(rec.url)) {
      console.log(`    [skip-origin] ${rec.url}`);
      return false;
    }
    return true;
  });

  // group by field
  const byField = {};
  for (const rec of filtered) {
    if (!byField[rec.field]) byField[rec.field] = [];
    byField[rec.field].push(rec);
  }

  const newSources = {};
  const newFields = {};

  for (const [field, urls] of Object.entries(byField)) {
    // build sources entries (id will be assigned by editService)
    newSources[field] = urls.map(u => ({ url: u.url, text: u.text }));

    // body marker addition
    if (BODY_FIELDS.includes(field)) {
      const body = getNested(ucj, field);
      if (typeof body !== 'string') continue;
      const cleanBody = stripMarkers(body).trimEnd();
      const markers = urls.map((_, i) => `[${i + 1}]`).join('');
      newFields[field] = cleanBody + markers;
    } else if (ARRAY_FIELDS.includes(field)) {
      const arr = getNested(ucj, field);
      if (!Array.isArray(arr)) continue;
      const newArr = arr.map((item, idx) => {
        if (typeof item !== 'string') return item;
        const cleaned = stripMarkers(item).trimEnd();
        if (idx < urls.length) {
          return cleaned + `[${idx + 1}]`;
        }
        return cleaned;
      });
      newFields[field] = newArr;
    }
  }

  console.log(`  ${slug}: ${filtered.length} URL → ${Object.keys(newSources).length} fields`);

  if (args['dry-run']) return { slug, id: r.id, newSources, newFields };

  const body = JSON.stringify({
    jobName: slug,
    fields: newFields,
    sources: newSources,
    changeSummary: `[url-rebuild] WebFetch 검증된 외부 출처 ${filtered.length}건 신규 매핑 + 본문 [N] 재정렬`,
  });
  const resp = await fetch(`${API_BASE}/api/job/${r.id}/edit`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json', 'X-Admin-Secret': ADMIN_SECRET },
    body,
  });
  const respText = await resp.text();
  console.log(`    status: ${resp.status} ${respText.slice(0, 150)}`);
  return { slug, id: r.id, ok: resp.ok };
}

async function main() {
  const batch = JSON.parse(fs.readFileSync(path.resolve(REPO_ROOT, args.batch), 'utf8'));
  const results = [];
  for (const [slug, recs] of Object.entries(batch)) {
    const result = await processJob(slug, recs);
    results.push(result);
  }
  const ok = results.filter(r => r && r.ok).length;
  console.log(`\n[apply-rebuild] DONE — ${ok}/${results.length} jobs applied`);
}

main().catch(e => { console.error(e); process.exit(1); });
