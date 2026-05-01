#!/usr/bin/env node
// scripts/skill-cache/analyze-wholesale-purged.cjs
// wholesale 제거된 직업의 본문 분석 — 출처 없는 hallucinated 내용 잔존 위험 평가
//
// 사용:
//   node scripts/skill-cache/analyze-wholesale-purged.cjs --slugs=data/wholesale-purged-58.txt --verify=data/url-verify-142.json --out=data/wholesale-purged-analysis.json

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

const BODY_FIELDS = [
  'way','trivia','overviewProspect.main','overviewSalary.sal',
  'detailWlb.wlbDetail','detailWlb.socialDetail','overviewAbilities.technKnow','summary',
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

// 출처가 필요한 의심 fact 패턴 식별
function detectFactClaims(text) {
  if (typeof text !== 'string') return [];
  const claims = [];
  // 통계/숫자 패턴
  const patterns = [
    { re: /(\d+(?:,\d+)*(?:\.\d+)?)\s*(%|퍼센트)/g, kind: '%수치' },
    { re: /(\d+(?:,\d+)*)\s*(만\s*명|명|건|개|만원|억\s*원|조\s*원|억\s*달러|달러)/g, kind: '수량' },
    { re: /(20\d{2})년/g, kind: '연도근거' },
    { re: /(통계청|보건복지부|국토교통부|고용노동부|교육부|KOSIS|OECD|KOCCA|KOSHA|국세청|대법원|헌법재판소|국시원|식약처|관세청|농림축산식품부|과기정통부)/g, kind: '기관인용' },
    { re: /(보고서|발표|조사|통계|연구|논문|백서|기본계획|보도자료)/g, kind: '근거유형' },
    { re: /(평균\s*\d|상위\s*\d|하위\s*\d|순위|증가|감소|성장률|점유율)/g, kind: '비교지표' },
  ];
  for (const { re, kind } of patterns) {
    let m;
    while ((m = re.exec(text)) !== null) {
      claims.push({ kind, text: m[0], pos: m.index });
    }
  }
  return claims;
}

async function main() {
  const slugs = fs.readFileSync(path.resolve(REPO_ROOT, args.slugs), 'utf8').split('\n').map(s => s.trim()).filter(Boolean);
  const verify = args.verify ? JSON.parse(fs.readFileSync(path.resolve(REPO_ROOT, args.verify), 'utf8')) : null;

  // batch fetch UCJ
  const slugIn = slugs.map(s => `'${s.replace(/'/g, "''")}'`).join(',');
  const rows = d1Query(`SELECT slug, user_contributed_json FROM jobs WHERE slug IN (${slugIn})`);
  const ucjMap = new Map(rows.map(r => [r.slug, JSON.parse(r.user_contributed_json || '{}')]));

  const result = [];
  for (const slug of slugs) {
    const ucj = ucjMap.get(slug);
    if (!ucj) { result.push({ slug, error: 'NOT_FOUND' }); continue; }

    const sources = ucj._sources || {};
    let totalBodyLen = 0;
    let totalMarkers = 0;
    let totalSourcesNow = 0;
    let totalFactClaims = 0;
    const fields = {};

    for (const f of BODY_FIELDS) {
      const v = getNested(ucj, f);
      if (typeof v === 'string') {
        const len = v.length;
        const markers = (v.match(/\[(\d+)\]/g) || []).length;
        const srcLen = (sources[f] || []).length;
        const claims = detectFactClaims(v);
        totalBodyLen += len;
        totalMarkers += markers;
        totalSourcesNow += srcLen;
        totalFactClaims += claims.length;
        if (len > 0) {
          fields[f] = { len, markers, sourcesNow: srcLen, factClaims: claims.length, sample: v.slice(0, 120) };
        }
      }
    }

    // 이전 _sources 카운트 (verify-142.json 기준)
    let sourcesPrior = 0;
    if (verify && verify.by_slug && verify.by_slug[slug]) {
      sourcesPrior = verify.by_slug[slug].total;
    }

    const sourcesPurged = Math.max(0, sourcesPrior - totalSourcesNow);
    const factsPerSource = totalSourcesNow === 0 ? totalFactClaims : (totalFactClaims / totalSourcesNow).toFixed(1);
    // 의심도 score: factClaims 많고 sourcesNow 적을수록 ↑
    const suspicionScore = totalFactClaims * 10 - totalSourcesNow * 5 + Math.floor(totalBodyLen / 500);

    result.push({
      slug,
      bodyLen: totalBodyLen,
      markers: totalMarkers,
      sourcesNow: totalSourcesNow,
      sourcesPrior,
      sourcesPurged,
      factClaims: totalFactClaims,
      factsPerSource,
      suspicionScore,
      fields,
    });
  }

  // sort by suspicionScore desc
  result.sort((a, b) => (b.suspicionScore || 0) - (a.suspicionScore || 0));

  if (args.out) {
    fs.writeFileSync(path.resolve(REPO_ROOT, args.out), JSON.stringify(result, null, 2), 'utf8');
    console.log(`saved: ${args.out}`);
  }

  // 사람용 markdown table
  console.log(`\n## Wholesale 정리한 ${result.length}직업 — 의심도 sort\n`);
  console.log('| # | slug | 본문bytes | 마커 | _sources(now/prev/purged) | factClaims | factsPerSource | suspicionScore |');
  console.log('|---|------|-----------|------|----------------------------|------------|----------------|----------------|');
  result.forEach((r, i) => {
    if (r.error) { console.log(`| ${i+1} | ${r.slug} | ERROR: ${r.error} |`); return; }
    console.log(`| ${i+1} | [${r.slug}](https://careerwiki.org/job/${r.slug}) | ${r.bodyLen} | ${r.markers} | ${r.sourcesNow}/${r.sourcesPrior}/${r.sourcesPurged} | ${r.factClaims} | ${r.factsPerSource} | ${r.suspicionScore} |`);
  });

  // 표본 top 10 상세
  console.log(`\n## Top 10 의심 직업 (factClaims 多 + sourcesNow 적음)\n`);
  result.slice(0, 10).forEach((r, i) => {
    console.log(`\n### ${i+1}. [${r.slug}](https://careerwiki.org/job/${r.slug})`);
    console.log(`- 본문: ${r.bodyLen} bytes / 마커 ${r.markers}개 / 출처 ${r.sourcesNow}건 (이전 ${r.sourcesPrior}건, ${r.sourcesPurged}건 제거)`);
    console.log(`- 출처가 필요한 fact claim: **${r.factClaims}건** (수치·기관 인용·연도·비교지표 등)`);
    console.log(`- 의심 노트: 본문에 ${r.factClaims}개 fact claim이 있는데 출처가 ${r.sourcesNow}건뿐 → ${r.factClaims - r.sourcesNow}건 무근거 가능성`);
  });
}

main().catch(e => { console.error(e); process.exit(1); });
