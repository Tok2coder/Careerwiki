#!/usr/bin/env node
// 2026-05-24 사고 재발 방지 — 자작 cycle/generic/bulk/pool 스크립트 Write/Edit 차단.
// P1~P5 5세션이 _cyclegeneric.cjs 류로 WebFetch 우회 + 보일러플레이트 6,440 직업 박은 사고 후속.
// 정상 작업은 SKILL.md (job-data-master) 사용. helper 스크립트 작성 시 본 hook이 즉시 차단.

const fs = require('fs');

const stdin = fs.readFileSync(0, 'utf8');
let input;
try { input = JSON.parse(stdin); } catch { process.exit(0); }

const toolName = input?.tool_name || '';
if (!['Write', 'Edit', 'MultiEdit'].includes(toolName)) process.exit(0);

const filePath = input?.tool_input?.file_path || '';
if (!filePath) process.exit(0);

// 매치 패턴 — 파일명 basename 기준 (디렉토리 경로 무시)
const basename = filePath.split(/[\\/]/).pop().toLowerCase();

const BLOCKED_PATTERNS = [
  /^_?cycle[\w-]*\.(cjs|mjs|js|ts)$/,            // _cycle*.cjs, cyclegeneric.cjs
  /^_?cyclegeneric[\w-]*\.(cjs|mjs|js|ts)$/,
  /^_?generic[\w-]*\.(cjs|mjs|js|ts)$/,          // _generic*.cjs, genericbase.cjs
  /^_?bulk[\w-]*\.(cjs|mjs|js|ts)$/,             // _bulk*.cjs
  /^_?pool[\w-]*\.(cjs|mjs|js|ts)$/,             // _pool*.cjs
  /^_?dispatch[\w-]*generic[\w-]*\.(cjs|mjs|js|ts)$/,  // dispatch_generic_*.cjs
  /^_?force-enhance[\w-]*\.(cjs|mjs|js|ts)$/,    // force-enhance*.cjs (자작 dispatch)
  /^_?mass[\w-]*\.(cjs|mjs|js|ts)$/,             // _mass*.cjs
];

const matched = BLOCKED_PATTERNS.find(re => re.test(basename));
if (matched) {
  const msg = `[cycle-script-block] 자작 cycle/generic 스크립트 작성 금지 — 파일명 "${basename}" 차단.\n` +
    `사고 컨텍스트: 2026-05-24 P1~P5가 _cyclegeneric.cjs로 WebFetch 우회 + 보일러플레이트 6,440 직업 박음.\n` +
    `정상 작업은 .claude/skills/job-data-master/SKILL.md 사용. 별도 dispatcher 필요 시 사용자 승인 받고 명시적 cleanup-only 패턴만.`;
  console.error(msg);
  process.exit(2);
}

process.exit(0);
