#!/usr/bin/env node
const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

const stdin = fs.readFileSync(0, 'utf8');
let input;
try { input = JSON.parse(stdin); } catch { process.exit(0); }

const cmd = input?.tool_input?.command || '';
const result = input?.tool_response;
const exitCode = (result && typeof result.exitCode === 'number') ? result.exitCode : 0;
if (exitCode !== 0) process.exit(0);

const m = cmd.match(/\/api\/job\/([^/]+)\/edit/);
if (!m) process.exit(0);
const jobIdOrSlug = m[1];

const cwd = process.env.CLAUDE_PROJECT_DIR || process.cwd();
const auditScript = path.join(cwd, 'scripts', 'skill-cache', 'audit-sources-deep.cjs');
if (!fs.existsSync(auditScript)) {
  console.log(`[audit-after-edit] script 없음: ${auditScript} — skip`);
  process.exit(0);
}

let slug = jobIdOrSlug;
if (/^\d+$/.test(jobIdOrSlug)) {
  try {
    const out = execSync(
      `wrangler d1 execute careerwiki-kr --remote --json --command "SELECT slug FROM jobs WHERE id=${jobIdOrSlug} LIMIT 1"`,
      { cwd, encoding: 'utf8', timeout: 30000 }
    );
    const j = JSON.parse(out);
    const found = j?.[0]?.results?.[0]?.slug;
    if (found) slug = found;
  } catch (e) {
    console.log(`[audit-after-edit] slug 조회 실패: ${e.message?.split('\n')[0]} — id ${jobIdOrSlug}로 시도`);
  }
}

console.log(`[audit-after-edit] 실행: slug=${slug}`);
try {
  const out = execSync(`node "${auditScript}" --slug=${slug}`, { cwd, encoding: 'utf8', timeout: 90000 });
  const tail = out.trim().split('\n').slice(-30).join('\n');
  console.log(tail);
  if (/FAIL|WARN/i.test(out)) {
    console.log('');
    console.log('⚠ audit-deep WARN/FAIL 발견. 위 로그 확인 후 fix 필요.');
  }
} catch (e) {
  const out = (e.stdout?.toString() || '') + (e.stderr?.toString() || '');
  console.log(out.trim().split('\n').slice(-30).join('\n'));
  console.log('⚠ audit-deep 실행 실패 또는 FAIL — 수동 확인 필요.');
}
process.exit(0);
