#!/usr/bin/env node
/**
 * scan-trivia-inline-footnotes.cjs
 *
 * UCJ trivia 필드에서 "마지막 [N] 이후에 문장이 이어지는" 위반을 전수 탐지.
 * 룰 D: detectTriviaInlineFootnote
 *
 * Usage: node scripts/selfcheck/scan-trivia-inline-footnotes.cjs
 */

'use strict';

const { execSync } = require('child_process');
const path = require('path');

const ROOT = path.resolve(__dirname, '../..');

function detectTriviaInlineFootnote(trivia) {
  if (!trivia || typeof trivia !== 'string') return false;
  const trimmed = trivia.trim();
  const all = [...trimmed.matchAll(/\[\d+\]/g)];
  if (all.length === 0) return false; // [N] 없음 — 별도 문제

  const last = all[all.length - 1];
  const after = trimmed.slice(last.index + last[0].length).trim();
  // 마지막 [N] 이후에 한글·영문·숫자 등 실질 텍스트가 있으면 위반
  return /[가-힣a-zA-Z0-9]/.test(after);
}

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
  if (detectTriviaInlineFootnote(row.trivia)) {
    violations.push(row);
  } else if (!/\[\d+\]/.test(row.trivia)) {
    noFootnote.push(row);
  }
}

console.log(`\n전체 UCJ trivia: ${rows.length}개`);
console.log(`[N] 없음 (별도 검토): ${noFootnote.length}개`);
console.log(`\n═══ [Trivia/각주중간배치] 위반 — ${violations.length}개 ═══\n`);

for (const v of violations) {
  const preview = v.trivia.length > 200 ? v.trivia.slice(0, 200) + '...' : v.trivia;
  console.log(`❌ ${v.name} (${v.slug})`);
  console.log(`   ${preview}`);
  console.log();
}

if (violations.length === 0) {
  console.log('위반 없음 ✅');
}

process.exit(violations.length > 0 ? 1 : 0);
