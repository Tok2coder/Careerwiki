#!/usr/bin/env node
// emit-activity.cjs — 배치 cycle 서브에이전트 활동을 app.wikicomu.com /activity 에 보고.
//
// 사용법 1 (raw JSON):   node scripts/emit-activity.cjs '{"events":[{...}]}'
// 사용법 2 (파일 기반):  node scripts/emit-activity.cjs --file <path.json> [overrides]
//   - 한글 label(직업명)이 argv로 전달될 때의 인코딩 깨짐(mojibake)을 피하려면 파일 기반 사용.
//   - base 파일에는 status:'running' 으로 lifecycle 이벤트 1건을 넣고,
//     호출 시 아래 override 플래그로 같은 (source, external_id) 행을 upsert 한다.
//   overrides (단일 이벤트일 때만 적용):
//     --status running|done|failed   이벤트 status 덮어쓰기 (lifecycle 전환)
//     --tool-calls <N>                tool_calls 채움
//     --detail "<문자열>"             detail 채움 (PASS/FAIL 요약 등)
//
//   <json> = {"events":[{source:'batch', external_id, group_key, agent_slug, label, model, status, tool_calls?, detail?}]}
//   (source, external_id) 가 유니크 키 — 같은 external_id로 running→done 보내면 같은 행이 upsert(라이프사이클).
//
// BRIDGE_SECRET 환경변수가 없으면 조용히 skip (비-데몬 환경에서 무해).
//
// 계약: POST /bridge/activity, HMAC-SHA256( `${ts}.${body}` ), headers
//   X-Bridge-Timestamp(초), X-Bridge-Signature(hex), X-Bridge-Daemon-Id
const crypto = require('crypto');
const https = require('https');
const http = require('http');
const fs = require('fs');

const SECRET = process.env.BRIDGE_SECRET;
if (!SECRET) {
  // 데몬 환경이 아니면 활동 보고를 건너뛴다 (배치 자체는 정상 진행).
  process.exit(0);
}

// ─── argv 파싱: raw JSON 위치인자 또는 --file + override 플래그 ───
function parseArgs(argv) {
  const out = { file: null, raw: null, status: null, toolCalls: null, detail: null };
  for (let i = 0; i < argv.length; i++) {
    const a = argv[i];
    if (a === '--file') out.file = argv[++i];
    else if (a === '--status') out.status = argv[++i];
    else if (a === '--tool-calls') out.toolCalls = parseInt(argv[++i], 10);
    else if (a === '--detail') out.detail = argv[++i];
    else if (!a.startsWith('--') && out.raw === null) out.raw = a; // 위치인자 = raw JSON
  }
  return out;
}
const args = parseArgs(process.argv.slice(2));

let body;
if (args.file) {
  let parsed;
  try {
    parsed = JSON.parse(fs.readFileSync(args.file, 'utf8'));
  } catch (e) {
    console.error(`[emit-activity] --file 읽기/파싱 실패: ${args.file} — ${e.message}`);
    process.exit(1);
  }
  // 단일 이벤트면 override 적용
  if (parsed && Array.isArray(parsed.events) && parsed.events.length === 1) {
    const ev = parsed.events[0];
    if (args.status) ev.status = args.status;
    if (Number.isFinite(args.toolCalls)) ev.tool_calls = args.toolCalls;
    if (args.detail != null) ev.detail = args.detail;
  } else if (args.status || args.toolCalls != null || args.detail != null) {
    console.error('[emit-activity] override 플래그는 단일 이벤트(events 길이 1)에만 적용 가능.');
    process.exit(1);
  }
  body = JSON.stringify(parsed);
} else {
  body = args.raw;
}

if (!body) {
  console.error('[emit-activity] usage: node emit-activity.cjs \'{"events":[...]}\'  |  --file <path> [--status done] [--tool-calls N] [--detail "..."]');
  process.exit(1);
}

const RAW_BASE = process.env.BRIDGE_BASE_URL || 'https://app.wikicomu.com';
const isHttps = !RAW_BASE.startsWith('http://');
const hostname = RAW_BASE.replace(/^https?:\/\//, '').replace(/\/.*$/, '');
const DID = process.env.DAEMON_ID || 'jason-pc';
const ts = Math.floor(Date.now() / 1000).toString();
const sig = crypto.createHmac('sha256', SECRET).update(`${ts}.${body}`).digest('hex');

const lib = isHttps ? https : http;
const req = lib.request(
  {
    hostname,
    path: '/bridge/activity',
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'X-Bridge-Timestamp': ts,
      'X-Bridge-Signature': sig,
      'X-Bridge-Daemon-Id': DID,
    },
  },
  (r) => {
    let d = '';
    r.on('data', (c) => (d += c));
    r.on('end', () => {
      if (r.statusCode >= 200 && r.statusCode < 300) {
        console.log(`[emit-activity] ${r.statusCode} ${d}`);
      } else {
        console.error(`[emit-activity] HTTP ${r.statusCode} ${d}`);
      }
    });
  },
);
// 활동 보고 실패가 배치를 죽이면 안 된다 — 에러는 로그만.
req.on('error', (e) => console.error('[emit-activity] failed:', e.message));
req.end(body);
