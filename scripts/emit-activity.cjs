#!/usr/bin/env node
// emit-activity.cjs — 배치 cycle 서브에이전트 활동을 app.wikicomu.com /activity 에 보고.
// 사용법: node scripts/emit-activity.cjs '<json>'
//   <json> = {"events":[{label, source, external_id, group_key, agent_slug, model, status, ...}]}
// BRIDGE_SECRET 환경변수가 없으면 조용히 skip (비-데몬 환경에서 무해).
//
// 계약: POST /bridge/activity, HMAC-SHA256( `${ts}.${body}` ), headers
//   X-Bridge-Timestamp(초), X-Bridge-Signature(hex), X-Bridge-Daemon-Id
const crypto = require('crypto');
const https = require('https');
const http = require('http');

const SECRET = process.env.BRIDGE_SECRET;
if (!SECRET) {
  // 데몬 환경이 아니면 활동 보고를 건너뛴다 (배치 자체는 정상 진행).
  process.exit(0);
}

const body = process.argv[2];
if (!body) {
  console.error('[emit-activity] usage: node emit-activity.cjs \'{"events":[...]}\'');
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
