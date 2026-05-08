#!/usr/bin/env node
// Phase B 본문 산문 풀 추출 — game-programmer way / wlbDetail / socialDetail / trivia
'use strict';

const SLUGS = ['게임-프로그래머', '방사선사'];

function plainText(html) {
  return html.replace(/<[^>]+>/g, '').replace(/&#39;/g, "'").replace(/&amp;/g, '&').replace(/\s+/g, ' ').trim();
}

(async () => {
  for (const slug of SLUGS) {
    process.stdout.write(`\n========== ${slug} ==========\n`);
    const r = await fetch(`https://careerwiki.org/job/${encodeURIComponent(slug)}`);
    const html = await r.text();

    // 1) wlbDetail / socialDetail h4 본문 추출
    for (const sec of ['워라밸', '사회적 기여']) {
      const startKey = `>${sec}</h4>`;
      const idx = html.indexOf(startKey);
      if (idx < 0) { process.stdout.write(`  [${sec}] not found\n`); continue; }
      // h4 다음 첫 닫는 </div> until 첫 `</div></div>` (block scope)
      let body = html.slice(idx + startKey.length);
      const endIdx = body.indexOf('</div>');
      if (endIdx > 0) body = body.slice(0, endIdx);
      // 본문 + sup data-source-id 매핑
      const sups = [...body.matchAll(/<sup[^>]*data-source-id=\"(\d+)\"[^>]*>\[(\d+)\]<\/sup>/g)].map(m => ({ id: m[1], n: m[2] }));
      process.stdout.write(`  [${sec}]:\n`);
      process.stdout.write(`    body: "${plainText(body)}"\n`);
      process.stdout.write(`    sups: ${JSON.stringify(sups)}\n`);
    }

    // 2) trivia (여담) 본문 — <article id="overview-여담"> 안 본문
    const trivIdx = html.indexOf('id="overview-여담"');
    if (trivIdx >= 0) {
      // trivia 카드 본문
      const slice = html.slice(trivIdx, trivIdx + 5000);
      // 첫 <li class= 또는 <p> 본문 ~ 끝
      const closeArticle = slice.indexOf('</article>');
      const trivia = closeArticle > 0 ? slice.slice(0, closeArticle) : slice.slice(0, 3500);
      const sups = [...trivia.matchAll(/<sup[^>]*data-source-id=\"(\d+)\"[^>]*>\[(\d+)\]<\/sup>/g)].map(m => ({ id: m[1], n: m[2] }));
      process.stdout.write(`\n  [여담(trivia)]:\n`);
      process.stdout.write(`    body: "${plainText(trivia).slice(0, 1500)}"\n`);
      process.stdout.write(`    sups: ${JSON.stringify(sups)}\n`);
    }

    // 3) way (입직 경로) — <article id="overview-입직-경로"> 또는 비슷한 anchor
    for (const wayAnchor of ['id="overview-입직-경로"', 'id="overview-입직경로"', 'id="overview-입직"', 'id="overview-되는-방법"', 'id="overview-되는방법"']) {
      const wayIdx = html.indexOf(wayAnchor);
      if (wayIdx < 0) continue;
      const slice = html.slice(wayIdx, wayIdx + 5000);
      const closeArticle = slice.indexOf('</article>');
      const way = closeArticle > 0 ? slice.slice(0, closeArticle) : slice.slice(0, 3500);
      const sups = [...way.matchAll(/<sup[^>]*data-source-id=\"(\d+)\"[^>]*>\[(\d+)\]<\/sup>/g)].map(m => ({ id: m[1], n: m[2] }));
      process.stdout.write(`\n  [입직(way) anchor=${wayAnchor}]:\n`);
      process.stdout.write(`    body: "${plainText(way).slice(0, 1500)}"\n`);
      process.stdout.write(`    sups: ${JSON.stringify(sups)}\n`);
      break;
    }
  }
})();
