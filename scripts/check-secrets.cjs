#!/usr/bin/env node
/**
 * check-secrets.cjs — pre-commit secret scanner
 * Scans staged files for credential patterns and blocks the commit if found.
 */

'use strict';
const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');

// Dangerous filename patterns (block entire file regardless of content)
const BLOCKED_FILENAMES = [
  /^dev\.vars$/i,
  /^\.env(\.|$)/i,
  /^secrets\.json$/i,
  /^credentials\.json$/i,
  /^serviceAccountKey\.json$/i,
];

// Content patterns: [label, regex]
const SECRET_PATTERNS = [
  ['OpenAI API Key',         /sk-[A-Za-z0-9_-]{20,}/],
  ['OpenAI Project Key',     /sk-proj-[A-Za-z0-9_-]{20,}/],
  ['AWS Access Key',         /AKIA[0-9A-Z]{16}/],
  ['Google OAuth Client ID', /[0-9]+-[a-z0-9]+\.apps\.googleusercontent\.com/],
  ['Google OAuth Secret',    /GOCSPX-[A-Za-z0-9_-]{20,}/],
  ['Generic client_secret',  /client_secret\s*[:=]\s*["']?[A-Za-z0-9_-]{10,}/i],
  ['Generic API key assign', /(?:api[_-]?key|apikey|api_secret)\s*[:=]\s*["']?[A-Za-z0-9_/+=-]{16,}/i],
  ['Bearer token',           /Bearer\s+[A-Za-z0-9._~+/-]{20,}/],
  ['Private key header',     /-----BEGIN (RSA |EC |OPENSSH )?PRIVATE KEY-----/],
  // Cloudflare token: 37-40자 영숫자, 반드시 알파벳/숫자로 시작 (구분선 같은 순수 `-` 라인 회피)
  ['Cloudflare API token',   /\b[A-Za-z0-9][A-Za-z0-9_]{20,}[A-Za-z0-9_-]{10,}\b/],
  ['Generic password assign',/password\s*[:=]\s*["'][^"']{8,}/i],
  ['Admin secret pattern',   /admin[_-]?secret\s*[:=]\s*["'][A-Za-z0-9_-]{8,}/i],
  ['JWT secret',             /jwt[_-]?secret\s*[:=]\s*["'][A-Za-z0-9_-]{16,}/i],
  // 한국 공공 API (공공데이터포털/워크넷/커리어넷) — UUID 8-4-4-4-12 포맷
  ['Korean public API UUID', /\b[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\b/i],
  // GOYONG24 / Work24 / CareerNet 키 literal string 할당만 차단 (함수 호출 제외)
  ['GOYONG24 key assign',    /GOYONG24_[A-Z_]*KEY\s*[:=]\s*["'][A-Za-z0-9_/+=.-]{10,}["']/],
  ['CareerNet key assign',   /CAREER[_-]?NET[_-]?[A-Z_]*KEY\s*[:=]\s*["'][A-Za-z0-9_/+=.-]{10,}["']/i],
  ['authKey query param',    /[?&]authKey=[A-Za-z0-9_/+=-]{10,}/],
];

// Whitelist: specific UUIDs known to be non-secret (D1 database IDs, R2 object keys, etc.)
// These are referenced in wrangler.jsonc or as public resource IDs and are safe to commit.
const UUID_WHITELIST = new Set([
  'edc21e23-c2ac-4693-bb79-389b6914e173',   // D1 database ID (legacy)
  '1dbc57d6-0ce3-4a7e-8d2e-3159b0df1315',   // D1 database ID (current, in wrangler.jsonc)
  '37fa15f6-9a2b-4bd6-bae9-687b18dc29f8',   // D1 database ID (new)
]);

// Files to always skip (binary / generated / documentation)
const SKIP_EXTENSIONS = new Set([
  '.png', '.jpg', '.jpeg', '.gif', '.webp', '.ico', '.svg',
  '.woff', '.woff2', '.ttf', '.eot',
  '.zip', '.tar', '.gz', '.tgz',
  '.pdf', '.docx', '.xlsx', '.pptx',
  '.mp4', '.mp3', '.avi', '.mov',
  '.sqlite', '.db',
  '.md', '.mdx', '.txt', '.rst',  // documentation — may contain example values
  '.example', '.sample',           // example env files — placeholder values expected
]);

// Filename patterns to always skip (placeholders inside)
const SKIP_BASENAMES = [
  /\.example$/i,
  /\.sample$/i,
  /\.example\./i,       // e.g. .env.example.yaml
];

function getStagedFiles() {
  try {
    const out = execSync('git diff --cached --name-only --diff-filter=ACM', { encoding: 'utf8' });
    return out.trim().split('\n').filter(Boolean);
  } catch {
    return [];
  }
}

function main() {
  const staged = getStagedFiles();
  if (staged.length === 0) process.exit(0);

  const violations = [];

  for (const filePath of staged) {
    const basename = path.basename(filePath);
    const ext = path.extname(filePath).toLowerCase();

    // Check filename block-list
    if (BLOCKED_FILENAMES.some(re => re.test(basename))) {
      violations.push({ file: filePath, label: 'Blocked filename (secrets file)', line: null, match: basename });
      continue;
    }

    // Skip binary/non-text files
    if (SKIP_EXTENSIONS.has(ext)) continue;
    // Skip *.example / *.sample placeholder files
    if (SKIP_BASENAMES.some(re => re.test(basename))) continue;

    // Read staged content via git show
    let content;
    try {
      content = execSync(`git show :${filePath}`, { encoding: 'utf8', maxBuffer: 4 * 1024 * 1024 });
    } catch {
      continue; // unreadable / binary
    }

    const lines = content.split('\n');
    for (let i = 0; i < lines.length; i++) {
      const line = lines[i];
      for (const [label, pattern] of SECRET_PATTERNS) {
        const m = pattern.exec(line);
        if (!m) continue;
        // UUID whitelist: D1 DB IDs / public resource UUIDs are not secrets
        if (label === 'Korean public API UUID') {
          const uuid = m[0].toLowerCase();
          if (UUID_WHITELIST.has(uuid)) break;
        }
        // Cloudflare token regex는 너무 광범위 — ENV var 이름·주석·식별자 false positive 다수
        // 실제 토큰만 잡도록 추가 검증:
        //   1) 매치가 전부 UPPER + 언더스코어면 ENV var 이름 (skip)
        //   2) 라인이 import/require/주석/식별자 참조 패턴이면 skip
        //   3) 따옴표·= 등 값 컨텍스트 없으면 skip
        if (label === 'Cloudflare API token') {
          const matched = m[0];
          // ENV var 이름 패턴 (전부 대문자 + 언더스코어 + 숫자만)
          if (/^[A-Z0-9_]+$/.test(matched)) break;
          // 메모리 파일명·식별자 (소문자 + 언더스코어, snake_case)
          if (/^[a-z][a-z0-9_]*$/.test(matched)) break;
          // camelCase 함수·변수명 (소문자 시작 + 대소문자 혼용, _·- 없음)
          if (/^[a-z][a-zA-Z0-9]+$/.test(matched)) break;
          // 라인이 명백한 비-secret 컨텍스트
          const lineLower = line.toLowerCase();
          if (/^\s*(import|from|require|\/\/|\*|#|export\s+(type|interface|const\s+[A-Z]))/.test(line)) break;
          // 값 할당 컨텍스트 없음 (=, :, " ", ' ')
          const ctxStart = Math.max(0, m.index - 3);
          const ctx = line.substring(ctxStart, m.index + matched.length + 3);
          if (!/["'`=:]/.test(ctx)) break;
        }
        violations.push({ file: filePath, label, line: i + 1, match: line.trim().slice(0, 80) });
        break; // one violation per line is enough
      }
    }
  }

  if (violations.length === 0) {
    process.exit(0);
  }

  console.error('\n🚨 비밀키 의심 파일 발견 — 커밋 차단\n');
  for (const v of violations) {
    const loc = v.line ? `:${v.line}` : '';
    console.error(`  ⛔ [${v.label}] ${v.file}${loc}`);
    if (v.match) console.error(`     → ${v.match}`);
  }
  console.error('\n staged 파일을 확인하고 비밀키를 제거한 뒤 다시 커밋하세요.');
  console.error(' 비밀키는 .env / .dev.vars 파일에만 보관하고 .gitignore에 포함시키세요.\n');
  process.exit(1);
}

main();
