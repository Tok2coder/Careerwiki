#!/usr/bin/env node
const fs = require('fs');
const os = require('os');
const path = require('path');

const stdin = fs.readFileSync(0, 'utf8');
let input;
try { input = JSON.parse(stdin); } catch { process.exit(0); }

const cmd = input?.tool_input?.command || '';
if (!/POST.*\/api\/job\/[^/]+\/edit/i.test(cmd)) process.exit(0);

const cwd = process.env.CLAUDE_PROJECT_DIR || process.cwd();

function buildCandidates(file) {
  const list = [];
  if (path.isAbsolute(file)) list.push(file);
  if (file.startsWith('/tmp/')) {
    const tail = file.slice(5);
    if (process.env.TEMP) list.push(path.join(process.env.TEMP, tail));
    if (process.env.TMP && process.env.TMP !== process.env.TEMP) list.push(path.join(process.env.TMP, tail));
    list.push(path.join(os.tmpdir(), tail));
    list.push(path.join('C:\\Program Files\\Git\\tmp', tail));
  }
  const msys = file.match(/^\/([a-zA-Z])\/(.*)$/);
  if (msys && !/^\/(tmp|var|usr|etc|home|root|opt|proc|sys|dev|bin|sbin|lib|mnt|srv|media)\//.test(file)) {
    list.push(msys[1].toUpperCase() + ':\\' + msys[2].split('/').join('\\'));
  }
  if (!path.isAbsolute(file) && !file.startsWith('/')) {
    list.push(path.join(cwd, file));
  }
  if (file.startsWith('/') && !path.isAbsolute(file)) {
    list.push(file);
    list.push(path.join(cwd, file));
  }
  return Array.from(new Set(list)).filter(Boolean);
}

let payload = null;
let payloadSource = '';
const fileMatch = cmd.match(/(?:-d|--data(?:-binary|-raw)?)\s+@([^\s'"]+)/);
if (fileMatch) {
  const file = fileMatch[1];
  const candidates = buildCandidates(file);
  for (const c of candidates) {
    try {
      payload = fs.readFileSync(c, 'utf8');
      payloadSource = c;
      break;
    } catch {}
  }
  if (payload === null) {
    console.error('🛑 BLOCKED: payload file 못 찾음 — 안전 우선 차단');
    console.error('요청 path: ' + file);
    console.error('시도한 candidate:');
    for (const c of candidates) console.error('  - ' + c);
    console.error('이유: file 검증 실패 시 무차단 통과 금지 (origin domain 검출 못 함 → 잘못된 데이터 prod 저장 위험).');
    console.error('조치: 절대경로 또는 cwd-relative path 명시 (예: scripts/skill-cache/draft.json).');
    process.exit(2);
  }
} else {
  const inlineMatch = cmd.match(/(?:-d|--data(?:-binary|-raw)?)\s+(?!@)('([^']*)'|"([^"]*)"|([^\s]+))/);
  if (!inlineMatch) process.exit(0);
  payload = inlineMatch[2] ?? inlineMatch[3] ?? inlineMatch[4] ?? '';
  payloadSource = '<inline>';
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
console.error('payload source: ' + payloadSource);
console.error('이유: 정부 직업포털 (career/work/wagework/work24/job.go.kr) + careerwiki.org 자기인용은 무가치 출처.');
console.error('조치: sources에서 해당 URL 제거 → 한국 1차 출처 (정부 deep page / 협회 deep page) 또는 한국 미디어 deep article 사용.');
process.exit(2);
