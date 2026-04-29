#!/usr/bin/env node
// scripts/skill-cache/count-unique-urls.cjs
// 각 직업의 _sources에서 unique URL 카운트 (모든 sources field 합산).
// URL ≤ threshold 직업 = 출처 빈약 → 보강 후보.
//
// 사용:
//   node scripts/skill-cache/count-unique-urls.cjs --threshold=10
//   node scripts/skill-cache/count-unique-urls.cjs --threshold=5 --json

const { spawnSync } = require('child_process');
const path = require('path');
const fs = require('fs');

const REPO_ROOT = path.resolve(__dirname, '..', '..');
const args = process.argv.slice(2).reduce((acc, a) => {
  const m = a.match(/^--([^=]+)(?:=(.+))?$/);
  if (m) acc[m[1]] = m[2] ?? true;
  return acc;
}, {});

const THRESHOLD = parseInt(args.threshold || '10');

function d1Query(sql) {
  const escaped = sql.replace(/\\/g, '\\\\').replace(/"/g, '\\"').replace(/\s+/g, ' ').trim();
  const cmdline = `npx wrangler d1 execute careerwiki-kr --remote --json --command "${escaped}"`;
  const r = spawnSync(cmdline, {
    cwd: REPO_ROOT, encoding: 'utf8', maxBuffer: 200 * 1024 * 1024,
    shell: true, windowsHide: true,
  });
  if (r.status !== 0 && !r.stdout) {
    throw new Error(`wrangler failed: ${(r.stderr || '').slice(0, 500)}`);
  }
  const out = (r.stdout || '').trim();
  const startIdx = out.indexOf('[');
  if (startIdx < 0) return [];
  return JSON.parse(out.slice(startIdx))[0]?.results || [];
}

console.log(`=== count-unique-urls (threshold=${THRESHOLD}) ===\n`);

// 모든 enhance-touched 직업 (UCJ NOT NULL)
const rows = d1Query(`
  SELECT id, slug, json_extract(user_contributed_json,'$._sources') AS sources_blob
  FROM jobs
  WHERE is_active=1 AND user_contributed_json IS NOT NULL
  ORDER BY slug
`);

const stats = [];
for (const r of rows) {
  if (!r.sources_blob) {
    stats.push({ slug: r.slug, urlCount: 0, fieldCount: 0, hasMojibake: false, hasRawUrl: false, hasBracketPrefix: false });
    continue;
  }
  let sources;
  try { sources = JSON.parse(r.sources_blob); }
  catch { stats.push({ slug: r.slug, urlCount: 0, fieldCount: 0, parse_error: true }); continue; }

  if (!sources || typeof sources !== 'object' || Array.isArray(sources)) {
    stats.push({ slug: r.slug, urlCount: 0, fieldCount: 0 });
    continue;
  }

  const urls = new Set();
  let totalEntries = 0;
  let hasMojibake = false;
  let hasRawUrl = false;
  let hasBracketPrefix = false;

  for (const [key, arr] of Object.entries(sources)) {
    if (!Array.isArray(arr)) continue;
    for (const s of arr) {
      totalEntries++;
      if (typeof s === 'object' && s !== null) {
        if (typeof s.url === 'string' && s.url.startsWith('http')) urls.add(s.url);
        if (typeof s.text === 'string') {
          if (s.text.includes('�')) hasMojibake = true;
          if (/^https?:\/\//.test(s.text)) hasRawUrl = true;
          if (/^\[\d+\]/.test(s.text)) hasBracketPrefix = true;
        }
      } else if (typeof s === 'string' && s.startsWith('http')) {
        urls.add(s);
      }
    }
  }

  stats.push({
    slug: r.slug,
    urlCount: urls.size,
    fieldCount: Object.keys(sources).length,
    totalEntries,
    hasMojibake,
    hasRawUrl,
    hasBracketPrefix,
  });
}

// 분포 통계
const dist = {};
for (const s of stats) {
  const bucket = s.urlCount <= 5 ? '0-5' : s.urlCount <= 10 ? '6-10' : s.urlCount <= 20 ? '11-20' : '21+';
  dist[bucket] = (dist[bucket] || 0) + 1;
}
console.log('URL 분포:');
console.log(`  0-5:   ${dist['0-5'] || 0}`);
console.log(`  6-10:  ${dist['6-10'] || 0}`);
console.log(`  11-20: ${dist['11-20'] || 0}`);
console.log(`  21+:   ${dist['21+'] || 0}`);

const lowThreshold = stats.filter(s => s.urlCount <= THRESHOLD);
console.log(`\nURL ≤ ${THRESHOLD}: ${lowThreshold.length}개`);

// 사고 패턴 교차 분석
const breakdown = {
  mojibake: lowThreshold.filter(s => s.hasMojibake).length,
  rawUrl: lowThreshold.filter(s => s.hasRawUrl).length,
  bracketPrefix: lowThreshold.filter(s => s.hasBracketPrefix).length,
  cleanButLow: lowThreshold.filter(s => !s.hasMojibake && !s.hasRawUrl && !s.hasBracketPrefix).length,
};
console.log(`\n사고 패턴 교차 (URL ≤ ${THRESHOLD} 풀):`);
console.log(`  mojibake: ${breakdown.mojibake}`);
console.log(`  raw URL in text: ${breakdown.rawUrl}`);
console.log(`  bracket prefix: ${breakdown.bracketPrefix}`);
console.log(`  깨끗하지만 빈약: ${breakdown.cleanButLow}`);

// 정렬: URL 적은 순
lowThreshold.sort((a, b) => a.urlCount - b.urlCount);

if (args.json) {
  console.log(JSON.stringify({
    threshold: THRESHOLD,
    distribution: dist,
    low_threshold_count: lowThreshold.length,
    breakdown,
    items: lowThreshold,
  }, null, 2));
} else {
  console.log(`\n[빈약 직업 sample — top 30]`);
  lowThreshold.slice(0, 30).forEach(s => {
    const flags = [];
    if (s.hasMojibake) flags.push('moji');
    if (s.hasRawUrl) flags.push('rawURL');
    if (s.hasBracketPrefix) flags.push('brkt');
    console.log(`  ${s.urlCount.toString().padStart(2)} URL · ${s.slug.padEnd(20)} ${flags.length ? '[' + flags.join(',') + ']' : ''}`);
  });

  // JSON 저장
  const outPath = path.join(REPO_ROOT, 'data', `low-url-jobs-le${THRESHOLD}.json`);
  fs.writeFileSync(outPath, JSON.stringify({
    threshold: THRESHOLD,
    generated_at: new Date().toISOString(),
    items: lowThreshold,
  }, null, 2));
  console.log(`\n💾 저장: data/low-url-jobs-le${THRESHOLD}.json (${(fs.statSync(outPath).size / 1024).toFixed(1)} KB)`);
}
