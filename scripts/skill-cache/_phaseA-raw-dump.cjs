#!/usr/bin/env node
// Phase A — body 산문 영역 raw text 덤프 (mismatch 정확 식별용)
'use strict';

const SLUGS = ['방사선사', '게임-프로그래머'];

const FIELDS = [
  'summary',
  'way',
  'trivia',
  'overviewProspect.main',
  'overviewSalary.sal',
  'overviewWork.main',
  'detailWlb.wlbDetail',
  'detailWlb.socialDetail',
  'detailWlb.workLifeBalance',
  'detailWlb.socialContribution',
  'detailWlb.workLifeDetail',
  'detailReady.curriculum',
  'detailReady.recruit',
  'detailReady.training',
  'detailReady.research',
  'detailWork.main',
  'detailWork.detail',
  'detailGrowth.main',
  'detailGrowth.detail',
  'overviewAbilities.technKnow',
];

function getNested(obj, p) {
  if (!obj) return undefined;
  if (obj[p] !== undefined) return obj[p];
  let cur = obj;
  for (const part of p.split('.')) { if (cur == null) return undefined; cur = cur[part]; }
  return cur;
}

(async () => {
  for (const slug of SLUGS) {
    const url = `https://careerwiki.org/api/job/${encodeURIComponent(slug)}/edit-data`;
    process.stdout.write(`\n========== ${slug} ==========\n`);
    const r = await fetch(url, { headers: { 'Cache-Control': 'no-cache' } });
    const j = await r.json();
    const data = j.data;
    process.stdout.write(`top-level keys: ${Object.keys(data).slice(0, 50).join(', ')}\n`);
    process.stdout.write(`\n_sources keys: ${JSON.stringify(Object.keys(data._sources || {}))}\n\n`);

    for (const f of FIELDS) {
      const v = getNested(data, f);
      if (v == null) continue;
      if (typeof v === 'string') {
        process.stdout.write(`--- ${f} (string, ${v.length}c) ---\n${v.slice(0, 600)}${v.length > 600 ? '\n...[truncated]' : ''}\n\n`);
      } else if (Array.isArray(v)) {
        process.stdout.write(`--- ${f} (array, ${v.length} items) ---\n`);
        for (let i = 0; i < v.length; i++) {
          const it = v[i];
          if (typeof it === 'string') {
            process.stdout.write(`  [${i}] (str): ${it.slice(0, 200)}\n`);
          } else if (it && typeof it === 'object') {
            const text = it.text || it.curriculum || it.recruit || it.training || it.research || it.value || it.name || JSON.stringify(it).slice(0, 200);
            process.stdout.write(`  [${i}] (obj keys=${Object.keys(it).join(',')}): ${String(text).slice(0, 200)}\n`);
          }
        }
        process.stdout.write('\n');
      }
    }

    process.stdout.write('\n=== _sources contents (full) ===\n');
    const src = data._sources || {};
    for (const k of Object.keys(src)) {
      process.stdout.write(`  [${k}] (${Array.isArray(src[k]) ? src[k].length : '?'}):\n`);
      if (Array.isArray(src[k])) {
        for (const s of src[k]) {
          process.stdout.write(`    id=${s.id} url=${(s.url || '').slice(0, 120)} text="${(s.text || '').slice(0, 80)}"\n`);
        }
      }
    }
  }
})();
