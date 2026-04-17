#!/usr/bin/env node
/**
 * scan-trivia-inline-footnotes.cjs
 *
 * UCJ trivia 필드에서 룰 D 위반을 전수 탐지.
 *   (a) 마지막 [N] 뒤에 실질 텍스트가 이어짐
 *   (b) 각주 2개 이상이 맨 끝에 연속 몰려 있음
 *
 * Usage: node scripts/selfcheck/scan-trivia-inline-footnotes.cjs
 */

'use strict';

const { execSync } = require('child_process');
const path = require('path');
const { detectTriviaInlineFootnote } = require(path.join(__dirname, '..', '_shared', 'detect-patterns.cjs'));

const ROOT = path.resolve(__dirname, '../..');

// DB에서 UCJ trivia 전체 조회
function fetchAll() {
  const sql = `SELECT name, slug, json_extract(user_contributed_json, '$.trivia') as trivia FROM jobs WHERE is_active=1 AND json_extract(user_contributed_json, '$.trivia') IS NOT NULL AND json_extract(user_contributed_json, '$.trivia') != '' ORDER BY name`;
  const out = execSync(
    `npx wrangler d1 execute careerwiki-kr --remote --json --command "${sql.replace(/"/g, '\\"')}"`,
    { encoding: 'utf8', cwd: ROOT, timeout: 60000, stdio: ['pipe','pipe','pipe'] }
  );
  const parsed = JSON.parse(out);
  return parsed?.[0]?.results || [];
}

const rows = fetchAll();
const violations = [];
const noFootnote = [];

for (const row of rows) {
  if (!row.trivia) continue;
  const reason = detectTriviaInlineFootnote(row.trivia);
  if (reason) {
    violations.push({ ...row, reason });
  } else if (!/\[\d+\]/.test(row.trivia)) {
    noFootnote.push(row);
  }
}

console.log(`\n전체 UCJ trivia: ${rows.length}개`);
console.log(`[N] 없음 (별도 검토): ${noFootnote.length}개`);
console.log(`\n═══ [Trivia/각주배치] 위반 — ${violations.length}개 ═══\n`);

for (const v of violations) {
  const preview = v.trivia.length > 200 ? v.trivia.slice(0, 200) + '...' : v.trivia;
  console.log(`❌ ${v.name} (${v.slug}) — ${v.reason}`);
  console.log(`   ${preview}`);
  console.log();
}

if (violations.length === 0) {
  console.log('위반 없음 ✅');
}

process.exit(violations.length > 0 ? 1 : 0);
