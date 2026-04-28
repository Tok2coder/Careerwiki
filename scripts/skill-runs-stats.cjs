#!/usr/bin/env node
// skill-runs.jsonl 분석기 — 시간/결과/토큰 통계
// 사용법:
//   node scripts/skill-runs-stats.cjs                     (전체 통계)
//   node scripts/skill-runs-stats.cjs --slug=웹툰작가      (특정 직업만)
//   node scripts/skill-runs-stats.cjs --since=2026-04-01  (해당 일자 이후)

const fs = require('fs');
const path = require('path');

const LOG = path.join('data', 'skill-runs.jsonl');

const args = process.argv.slice(2).reduce((acc, a) => {
  const m = a.match(/^--([^=]+)(?:=(.+))?$/);
  if (m) acc[m[1]] = m[2] ?? true;
  return acc;
}, {});

if (!fs.existsSync(LOG)) {
  console.log(`(${LOG} 부재 — 실행 기록 없음)`);
  process.exit(0);
}

const rows = fs.readFileSync(LOG, 'utf8').split('\n').filter(Boolean).map((line, i) => {
  try { return JSON.parse(line); }
  catch (e) { console.error(`L${i+1} parse error: ${e.message}`); return null; }
}).filter(Boolean);

const filtered = rows.filter(r => {
  if (args.slug && r.slug !== args.slug) return false;
  if (args.since && r.start_ts < args.since) return false;
  return true;
});

if (filtered.length === 0) { console.log('(필터 조건에 맞는 row 없음)'); process.exit(0); }

const percentile = (arr, p) => {
  if (arr.length === 0) return null;
  const sorted = [...arr].sort((a, b) => a - b);
  const idx = Math.min(sorted.length - 1, Math.floor((sorted.length - 1) * p / 100));
  return sorted[idx];
};

const durations = filtered.map(r => r.duration_sec).filter(d => Number.isFinite(d) && d > 0);
const tokensIn = filtered.map(r => r.tokens_in).filter(t => Number.isFinite(t) && t > 0);
const tokensOut = filtered.map(r => r.tokens_out).filter(t => Number.isFinite(t) && t > 0);

const counts = (key) => filtered.reduce((m, r) => {
  const v = r[key] ?? '(none)';
  m[v] = (m[v] || 0) + 1;
  return m;
}, {});

const fieldFreq = filtered.reduce((m, r) => {
  for (const f of (r.fields_modified || [])) m[f] = (m[f] || 0) + 1;
  return m;
}, {});

const filterDesc = [
  args.slug ? `slug=${args.slug}` : null,
  args.since ? `since=${args.since}` : null,
].filter(Boolean).join(', ') || '(전체)';

console.log(`\n=== skill-runs.jsonl 통계 ${filterDesc} ===`);
console.log(`총 row: ${filtered.length}`);

if (durations.length > 0) {
  console.log(`\n[실행 시간 (sec)]`);
  console.log(`  count: ${durations.length}`);
  console.log(`  min: ${Math.min(...durations)}`);
  console.log(`  p50 (median): ${percentile(durations, 50)}`);
  console.log(`  p90: ${percentile(durations, 90)}`);
  console.log(`  max: ${Math.max(...durations)}`);
  console.log(`  total: ${durations.reduce((a,b)=>a+b,0)}`);
}

console.log(`\n[validate_status]`);
for (const [k, v] of Object.entries(counts('validate_status')).sort((a,b)=>b[1]-a[1])) {
  console.log(`  ${k}: ${v}`);
}

console.log(`\n[audit_status]`);
for (const [k, v] of Object.entries(counts('audit_status')).sort((a,b)=>b[1]-a[1])) {
  console.log(`  ${k}: ${v}`);
}

if (tokensIn.length > 0 || tokensOut.length > 0) {
  console.log(`\n[토큰 사용]`);
  if (tokensIn.length > 0) console.log(`  in (count=${tokensIn.length}): total=${tokensIn.reduce((a,b)=>a+b,0)}, p50=${percentile(tokensIn, 50)}, p90=${percentile(tokensIn, 90)}`);
  if (tokensOut.length > 0) console.log(`  out (count=${tokensOut.length}): total=${tokensOut.reduce((a,b)=>a+b,0)}, p50=${percentile(tokensOut, 50)}, p90=${percentile(tokensOut, 90)}`);
  // Claude Opus 4.7 단가(2026-04 기준 $15/M in, $75/M out — 추정치)로 추산
  const RATE_IN = 15 / 1e6;
  const RATE_OUT = 75 / 1e6;
  const cost = tokensIn.reduce((a,b)=>a+b,0) * RATE_IN + tokensOut.reduce((a,b)=>a+b,0) * RATE_OUT;
  console.log(`  추산 비용 (Opus 단가 가정): $${cost.toFixed(4)}`);
}

console.log(`\n[fields_modified 빈도 — 상위 15]`);
for (const [f, c] of Object.entries(fieldFreq).sort((a,b)=>b[1]-a[1]).slice(0,15)) {
  console.log(`  ${f}: ${c}`);
}

const ctChanges = filtered.map(r => r.careerTree_changes ?? 0).filter(n => n > 0);
console.log(`\n[careerTree 변경]`);
console.log(`  변경 있는 run: ${ctChanges.length}/${filtered.length}`);
if (ctChanges.length > 0) console.log(`  총 추가/수정: ${ctChanges.reduce((a,b)=>a+b,0)}`);

if (filtered.length <= 30) {
  console.log(`\n[최근 row 목록]`);
  for (const r of filtered.slice(-10)) {
    console.log(`  ${r.start_ts} ${r.slug.padEnd(18)} ${String(r.duration_sec)}s validate=${r.validate_status||"-"} audit=${r.audit_status||"-"} fields=${(r.fields_modified||[]).length}개`);
  }
}
