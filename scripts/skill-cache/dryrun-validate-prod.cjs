#!/usr/bin/env node
// scripts/skill-cache/dryrun-validate-prod.cjs
// 표본 직업의 production user_contributed_json을 fetch해서
// validate-job-edit.cjs의 새 룰들이 어떻게 detect하는지 확인.
//
// 사용:
//   node scripts/skill-cache/dryrun-validate-prod.cjs <slug1> <slug2> ...

'use strict';

const { spawnSync } = require('child_process');
const path = require('path');
const { validate } = require(path.join(__dirname, '..', 'validate-job-edit.cjs'));

const REPO_ROOT = path.resolve(__dirname, '..', '..');

function d1Query(sql) {
  const escaped = sql.replace(/\\/g, '\\\\').replace(/"/g, '\\"').replace(/\s+/g, ' ').trim();
  const r = spawnSync(`npx wrangler d1 execute careerwiki-kr --remote --json --command "${escaped}"`, {
    cwd: REPO_ROOT, encoding: 'utf8', maxBuffer: 100 * 1024 * 1024,
    shell: true, windowsHide: true,
  });
  const out = (r.stdout || '').trim();
  const startIdx = out.indexOf('[');
  if (startIdx < 0) return [];
  return JSON.parse(out.slice(startIdx))[0]?.results || [];
}

const slugs = process.argv.slice(2);
if (slugs.length === 0) {
  console.error('Usage: node dryrun-validate-prod.cjs <slug1> <slug2> ...');
  process.exit(1);
}

const slugList = slugs.map(s => `'${s.replace(/'/g, "''")}'`).join(',');
const sql = `SELECT slug, user_contributed_json FROM jobs WHERE slug IN (${slugList})`;
const rows = d1Query(sql);

const summary = [];

for (const row of rows) {
  const ucj = row.user_contributed_json ? JSON.parse(row.user_contributed_json) : {};
  const sources = ucj._sources || {};
  // _sources 제외한 나머지를 fields로 (실제 enhance draft 형식 시뮬레이션)
  const { _sources, ...fields } = ucj;

  // changeSummary 마커는 빈 fields/sources에서 minimalPOST 가드를 회피하기 위해 비움
  const draft = {
    jobName: row.slug,
    fields,
    sources,
    changeSummary: '[dry-run] existing prod data validation',
  };

  const { errors, warnings } = validate(draft);

  // 새 룰 관련만 필터링 (2026-04-29 originDomain 격상 반영)
  const newRulePatterns = ['selfDomain', 'originDomain', 'selfCiteOnly', 'selfCite', 'listPageURL', 'brokenRef', 'orphanSrc'];
  const newErrors = errors.filter(e => newRulePatterns.some(p => e.includes(`[${p}]`)));
  const newWarns = warnings.filter(w => newRulePatterns.some(p => w.includes(`[${p}]`)));

  console.log(`\n=== ${row.slug} ===`);
  console.log(`  전체 errors: ${errors.length}, warnings: ${warnings.length}`);
  console.log(`  새 룰 errors: ${newErrors.length}, warnings: ${newWarns.length}`);

  if (newErrors.length > 0) {
    console.log('  [신규 ERROR]');
    for (const e of newErrors) console.log(`    - ${e.slice(0, 200)}`);
  }
  if (newWarns.length > 0) {
    console.log('  [신규 WARN]');
    for (const w of newWarns) console.log(`    - ${w.slice(0, 200)}`);
  }

  summary.push({ slug: row.slug, totalErrors: errors.length, totalWarns: warnings.length, newErrors: newErrors.length, newWarns: newWarns.length });
}

console.log('\n=== summary ===');
console.table(summary);
