#!/usr/bin/env node
const fs = require('fs');
const path = require('path');

const stdin = fs.readFileSync(0, 'utf8');
let input;
try { input = JSON.parse(stdin); } catch { process.exit(0); }

const cmd = input?.tool_input?.command || '';
if (!/POST.*\/api\/job\/[^/]+\/edit/i.test(cmd)) process.exit(0);

let payload = null;
const fileMatch = cmd.match(/(?:-d|--data(?:-binary|-raw)?)\s+@([^\s'"]+)/);
if (fileMatch) {
  const file = fileMatch[1];
  try {
    const abs = path.isAbsolute(file) ? file : path.join(process.env.CLAUDE_PROJECT_DIR || process.cwd(), file);
    payload = fs.readFileSync(abs, 'utf8');
  } catch {
    process.exit(0);
  }
} else {
  const inlineMatch = cmd.match(/(?:-d|--data(?:-binary|-raw)?)\s+(?!@)('([^']*)'|"([^"]*)"|([^\s]+))/);
  if (!inlineMatch) process.exit(0);
  payload = inlineMatch[2] ?? inlineMatch[3] ?? inlineMatch[4] ?? '';
}
if (!payload) process.exit(0);

const ORIGIN_PATTERNS = [
  { name: 'career.go.kr', re: /\bcareer\.go\.kr\b/i },
  { name: 'wagework.go.kr', re: /\bwagework\.go\.kr\b/i },
  { name: 'work24.go.kr', re: /\bwork24\.go\.kr\b/i },
  { name: 'work.go.kr', re: /\bwork\.go\.kr\b/i },
  { name: 'job.go.kr', re: /\bjob\.go\.kr\b/i },
  { name: 'careerwiki.org', re: /\bcareerwiki\.org\b/i },
];
const hits = ORIGIN_PATTERNS.filter(p => p.re.test(payload)).map(p => p.name);
if (hits.length === 0) process.exit(0);

console.error('🛑 BLOCKED: payload에 origin domain URL 포함');
console.error('차단 패턴: ' + hits.join(', '));
console.error('이유: 정부 직업포털 (career/work/wagework/work24/job.go.kr) + careerwiki.org 자기인용은 무가치 출처.');
console.error('조치: sources에서 해당 URL 제거 → 한국 1차 출처 (정부 deep page / 협회 deep page) 또는 한국 미디어 deep article 사용.');
process.exit(2);
