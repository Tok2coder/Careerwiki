#!/usr/bin/env node
// scripts/skill-cache/audit-detailready-omission.cjs
// detailReady.curriculum/recruit/training 항목별 [N] 마커 누락 + _sources 등록 누락 audit.
// cycle 1 21 unique 처리 직업만 대상으로 점검.

'use strict';

const { spawnSync } = require('child_process');
const path = require('path');

const REPO_ROOT = path.resolve(__dirname, '..', '..');

// cycle 1 처리 21건 (표본 5 + Round 1-3 15 + Round 5 1)
const CYCLE1_DONE = [
  '수의사보조원', '만화가', '사서', '경제학연구원', '리포터',
  '입학사정관', '보험계리사', '의료코디네이터', '수상운송사무원', '드라마작가',
  '사회단체활동가', '집배원', '마취병리과의사', '법원공무원', '네일아티스트',
  '마케팅전문가', '전문의사', '방송연출가', '사회학연구원', '역사학연구원',
  '전화교환원',
];

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

const slugList = CYCLE1_DONE.map(s => `'${s.replace(/'/g, "''")}'`).join(',');
const rows = d1Query(`SELECT slug, user_contributed_json FROM jobs WHERE slug IN (${slugList}) ORDER BY slug`);

const SUB_FIELDS = ['curriculum', 'recruit', 'training'];

const results = [];

for (const row of rows) {
  if (!row.user_contributed_json) continue;
  let ucj;
  try { ucj = JSON.parse(row.user_contributed_json); } catch { continue; }
  const dr = ucj.detailReady;
  if (!dr) continue;
  const sources = ucj._sources || {};

  const findings = { slug: row.slug, omissions: [], sourcesMissing: [] };

  for (const sub of SUB_FIELDS) {
    if (!Array.isArray(dr[sub]) || dr[sub].length === 0) continue;

    // 항목별 [N] 마커 누락 검사
    const items = dr[sub];
    const missingMarkerIdx = [];
    for (let i = 0; i < items.length; i++) {
      const text = typeof items[i] === 'string' ? items[i] : (items[i]?.text || '');
      if (text.trim() && !/\[\d+\]/.test(text)) {
        missingMarkerIdx.push(i);
      }
    }
    if (missingMarkerIdx.length > 0) {
      findings.omissions.push({
        sub,
        totalItems: items.length,
        missingCount: missingMarkerIdx.length,
        missingIdxs: missingMarkerIdx,
        sample: items[missingMarkerIdx[0]] && (typeof items[missingMarkerIdx[0]] === 'string' ? items[missingMarkerIdx[0]] : items[missingMarkerIdx[0]]?.text),
      });
    }

    // _sources["detailReady.X"] 미등록 검사 (항목 있는데 sources 없음)
    const srcKey = `detailReady.${sub}`;
    if (!sources[srcKey] || (Array.isArray(sources[srcKey]) && sources[srcKey].length === 0)) {
      findings.sourcesMissing.push({ sub, totalItems: items.length });
    }
  }

  if (findings.omissions.length > 0 || findings.sourcesMissing.length > 0) {
    results.push(findings);
  }
}

// 출력
console.log(`\n=== detailReady [N] + _sources omission audit (cycle 1 처리 21건) ===\n`);
console.log(`총 검사: ${rows.length}건 / 누락 발견: ${results.length}건\n`);

if (results.length === 0) {
  console.log('✅ 모든 cycle 1 처리 직업의 detailReady가 [N] + _sources 정상');
} else {
  for (const r of results) {
    console.log(`📌 ${r.slug}`);
    if (r.omissions.length > 0) {
      for (const o of r.omissions) {
        console.log(`   - detailReady.${o.sub}: ${o.missingCount}/${o.totalItems} 항목 [N] 누락 (idx ${o.missingIdxs.join(',')}) — 예: "${(o.sample || '').slice(0, 50)}..."`);
      }
    }
    if (r.sourcesMissing.length > 0) {
      for (const s of r.sourcesMissing) {
        console.log(`   - _sources["detailReady.${s.sub}"] 미등록 (${s.totalItems}개 항목 있음)`);
      }
    }
    console.log('');
  }
}

// JSON 출력 (--json)
if (process.argv.includes('--json')) {
  console.log(JSON.stringify(results, null, 2));
}
