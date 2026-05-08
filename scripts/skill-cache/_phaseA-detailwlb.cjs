#!/usr/bin/env node
// detailWlb / way / trivia / summary 정확 구조 확인
'use strict';

const SLUGS = ['방사선사', '게임-프로그래머'];

(async () => {
  for (const slug of SLUGS) {
    const url = `https://careerwiki.org/api/job/${encodeURIComponent(slug)}/edit-data`;
    process.stdout.write(`\n========== ${slug} ==========\n`);
    const r = await fetch(url, { headers: { 'Cache-Control': 'no-cache' } });
    const j = await r.json();
    const data = j.data;

    process.stdout.write(`way (typeof=${typeof data.way}): `);
    if (typeof data.way === 'string') process.stdout.write(`"${data.way}"\n`);
    else process.stdout.write(JSON.stringify(data.way) + '\n');

    process.stdout.write(`\ndetailWlb keys: ${data.detailWlb ? Object.keys(data.detailWlb).join(', ') : 'null'}\n`);
    if (data.detailWlb) {
      for (const k of Object.keys(data.detailWlb)) {
        const v = data.detailWlb[k];
        if (v == null) {
          process.stdout.write(`  ${k}: null/undef\n`);
        } else if (typeof v === 'string') {
          process.stdout.write(`  ${k} (string ${v.length}c): "${v.slice(0, 400)}${v.length > 400 ? '...' : ''}"\n`);
          const m = [...v.matchAll(/\[(\d+)\]/g)].map(x => x[1]);
          process.stdout.write(`     markers: [${m.join(',')}]\n`);
        } else if (Array.isArray(v)) {
          process.stdout.write(`  ${k} (array ${v.length}):\n`);
          for (let i = 0; i < v.length; i++) {
            const it = v[i];
            const text = typeof it === 'string' ? it : (it?.text || it?.value || JSON.stringify(it));
            process.stdout.write(`    [${i}]: "${String(text).slice(0, 200)}"\n`);
            const m = [...String(text).matchAll(/\[(\d+)\]/g)].map(x => x[1]);
            if (m.length) process.stdout.write(`       markers: [${m.join(',')}]\n`);
          }
        } else if (typeof v === 'object') {
          process.stdout.write(`  ${k} (obj keys=${Object.keys(v).join(',')}): ${JSON.stringify(v).slice(0, 200)}\n`);
        }
      }
    }

    process.stdout.write(`\ntrivia (typeof=${typeof data.trivia}, isArr=${Array.isArray(data.trivia)}):\n`);
    if (Array.isArray(data.trivia)) {
      for (let i = 0; i < data.trivia.length; i++) {
        const it = data.trivia[i];
        const text = typeof it === 'string' ? it : (it?.text || it?.value || JSON.stringify(it));
        process.stdout.write(`  [${i}] (${String(text).length}c): "${String(text).slice(0, 500)}${String(text).length > 500 ? '...' : ''}"\n`);
        const m = [...String(text).matchAll(/\[(\d+)\]/g)].map(x => x[1]);
        process.stdout.write(`    markers: [${m.join(',')}]\n`);
      }
    } else if (typeof data.trivia === 'string') {
      process.stdout.write(`  string (${data.trivia.length}c): "${data.trivia.slice(0, 500)}"\n`);
      const m = [...data.trivia.matchAll(/\[(\d+)\]/g)].map(x => x[1]);
      process.stdout.write(`    markers: [${m.join(',')}]\n`);
    } else {
      process.stdout.write('  null/empty\n');
    }

    process.stdout.write(`\nsummary (${typeof data.summary}, ${(data.summary||'').length}c): "${(data.summary||'').slice(0, 300)}"\n`);
    const sm = [...String(data.summary || '').matchAll(/\[(\d+)\]/g)].map(x => x[1]);
    process.stdout.write(`  summary markers: [${sm.join(',')}]\n`);

    process.stdout.write(`\n_sources keys: ${Object.keys(data._sources || {}).join(', ')}\n`);
  }
})();
