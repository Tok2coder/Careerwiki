#!/usr/bin/env node
const fs = require('fs');
const { execSync } = require('child_process');

const stdin = fs.readFileSync(0, 'utf8');
let input;
try { input = JSON.parse(stdin); } catch { process.exit(0); }

const filePath = input?.tool_input?.file_path || '';
if (!/\.tsx?$/.test(filePath)) process.exit(0);
if (filePath.includes('node_modules') || filePath.includes('.skill-cache') || filePath.includes('.tmp-')) process.exit(0);

const cwd = process.env.CLAUDE_PROJECT_DIR || process.cwd();
try {
  execSync('npx tsc --noEmit', { cwd, stdio: 'pipe', timeout: 55000 });
  process.exit(0);
} catch (e) {
  const out = (e.stdout?.toString() || '') + (e.stderr?.toString() || '');
  const lines = out.trim().split('\n').slice(-30).join('\n');
  console.error('⚠ TypeScript 에러 발생 — 다음 작업 전 fix 필요');
  console.error(lines);
  process.exit(0);
}
