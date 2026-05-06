#!/usr/bin/env node
const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

const stdin = fs.readFileSync(0, 'utf8');
let input;
try { input = JSON.parse(stdin); } catch { input = {}; }

const cwd = process.env.CLAUDE_PROJECT_DIR || process.cwd();

let codeChanged = false;
const transcript = input?.transcript_path;
if (transcript && fs.existsSync(transcript)) {
  try {
    const stat = fs.statSync(transcript);
    const size = stat.size;
    const fd = fs.openSync(transcript, 'r');
    const tailSize = Math.min(size, 256 * 1024);
    const buf = Buffer.alloc(tailSize);
    fs.readSync(fd, buf, 0, tailSize, size - tailSize);
    fs.closeSync(fd);
    const tail = buf.toString('utf8');
    if (/"name"\s*:\s*"(Edit|Write|MultiEdit)"/.test(tail)) codeChanged = true;
  } catch {}
}

if (!codeChanged) {
  try {
    const status = execSync('git status --short', { cwd, encoding: 'utf8', timeout: 10000 });
    if (/^[ M?A]{2}\s+(src\/|migrations\/|scripts\/|\.claude\/)/m.test(status)) codeChanged = true;
  } catch {}
}
if (!codeChanged) process.exit(0);

console.log('[stop-validate] 코드 변경 감지 — 검증 실행');

const skillCache = path.join(cwd, 'scripts', 'skill-cache');
let recentDraft = null;
if (fs.existsSync(skillCache)) {
  const files = fs.readdirSync(skillCache)
    .filter(f => /\.json$/.test(f))
    .map(f => ({ f, full: path.join(skillCache, f), mtime: fs.statSync(path.join(skillCache, f)).mtimeMs }))
    .filter(x => Date.now() - x.mtime < 600_000)
    .sort((a, b) => b.mtime - a.mtime);
  if (files.length) recentDraft = files[0].full;
}
if (recentDraft) {
  console.log(`[validate-job-edit] ${path.basename(recentDraft)}`);
  try {
    const out = execSync(`node scripts/validate-job-edit.cjs "${recentDraft}"`, { cwd, encoding: 'utf8', timeout: 30000 });
    console.log(out.trim().split('\n').slice(-20).join('\n'));
  } catch (e) {
    const out = (e.stdout?.toString() || '') + (e.stderr?.toString() || '');
    console.log(out.trim().split('\n').slice(-20).join('\n'));
  }
}

try {
  const status = execSync('git status --short', { cwd, encoding: 'utf8', timeout: 10000 });
  console.log('\n[git status]');
  console.log(status.trim().split('\n').slice(0, 20).join('\n'));
  if (/^[ MA]M?\s+src\/.*\.tsx?$/m.test(status)) {
    console.log('\n[tsc — src/ 변경 있음]');
    try {
      execSync('npx tsc --noEmit', { cwd, stdio: 'pipe', timeout: 55000 });
      console.log('OK');
    } catch (e) {
      const out = (e.stdout?.toString() || '') + (e.stderr?.toString() || '');
      console.log(out.trim().split('\n').slice(-10).join('\n'));
    }
  }
} catch {}

process.exit(0);
