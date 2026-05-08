#!/usr/bin/env node
'use strict';

const SLUGS = ['방사선사', '게임-프로그래머'];
const SECTIONS = ['워라밸', '사회적 기여', '여담', '커리어 트리'];

(async () => {
  for (const slug of SLUGS) {
    process.stdout.write(`\n========== ${slug} ==========\n`);
    const r = await fetch(`https://careerwiki.org/job/${encodeURIComponent(slug)}`);
    const html = await r.text();

    for (const sec of SECTIONS) {
      // h4 + content-heading 본문 추출 — content-heading 다음 첫 닫힘 div
      const startKey = `>${sec}</h4>`;
      const idx = html.indexOf(startKey);
      if (idx < 0) {
        process.stdout.write(`  [${sec}] not found\n`);
        continue;
      }
      // h4 다음 첫 closing </div> until depth 0
      let body = html.slice(idx + startKey.length, idx + startKey.length + 2000);
      // </div></div> 까지
      const cut = body.indexOf('</div>');
      if (cut > 0) body = body.slice(0, cut);
      const ids = [...body.matchAll(/data-source-id="(\d+)"/g)].map(x => x[1]);
      const titles = [...body.matchAll(/title="([^"]+)"/g)].map(x => x[1]);
      const markers = [...body.matchAll(/\[(\d+)\]/g)].map(x => x[1]);
      const plain = body.replace(/<[^>]+>/g, '').replace(/\s+/g, ' ').trim();
      process.stdout.write(`  [${sec}]:\n`);
      process.stdout.write(`    text: "${plain.slice(0, 400)}${plain.length > 400 ? '...' : ''}"\n`);
      process.stdout.write(`    [N] markers: [${markers.join(',')}]\n`);
      process.stdout.write(`    data-source-id: [${ids.join(',')}]\n`);
      process.stdout.write(`    titles: ${JSON.stringify(titles)}\n`);
    }

    // 출처 섹션 (footer or sidebar) 검색 — 출처 list 표시 검사
    const sourceListIdx = html.indexOf('user-source-list');
    if (sourceListIdx > 0) {
      const slice = html.slice(sourceListIdx, sourceListIdx + 4000);
      const liCount = [...slice.matchAll(/<li[^>]*data-source-/g)].length;
      const titles = [...slice.matchAll(/title="([^"]+)"/g)].map(x => x[1]);
      process.stdout.write(`  [출처 섹션 (user-source-list)] li count=${liCount}\n`);
      process.stdout.write(`    titles: ${JSON.stringify(titles.slice(0, 20))}\n`);
    }

    // 입직 경로 (way 영역) — fnref 패턴 검색
    const wayIdx = html.indexOf('id="overview-입직');
    if (wayIdx > 0) {
      const slice = html.slice(wayIdx, wayIdx + 3000);
      const sourceIds = [...slice.matchAll(/data-source-id="(\d+)"/g)].map(x => x[1]);
      const txt = slice.replace(/<[^>]+>/g, '').replace(/\s+/g, ' ');
      process.stdout.write(`  [입직(way) 영역] source-ids=[${sourceIds.join(',')}]\n`);
      process.stdout.write(`    snippet: "${txt.slice(0, 300)}"\n`);
    }
  }
})();
