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
  ['Cloudflare API token',   /[A-Za-z0-9_-]{37,40}(?:\s|$)/],   // broad — catches wrangler tokens
  ['Generic password assign',/password\s*[:=]\s*["'][^"']{8,}/i],
  ['Admin secret pattern',   /admin[_-]?secret\s*[:=]\s*["']?[A-Za-z0-9_-]{8,}/i],
  ['JWT secret',             /jwt[_-]?secret\s*[:=]\s*["']?[A-Za-z0-9_-]{16,}/i],
];

// Files to always skip (binary / generated / documentation)
const SKIP_EXTENSIONS = new Set([
  '.png', '.jpg', '.jpeg', '.gif', '.webp', '.ico', '.svg',
  '.woff', '.woff2', '.ttf', '.eot',
  '.zip', '.tar', '.gz', '.tgz',
  '.pdf', '.docx', '.xlsx', '.pptx',
  '.mp4', '.mp3', '.avi', '.mov',
  '.sqlite', '.db',
  '.md', '.mdx', '.txt', '.rst',  // documentation — may contain example values
]);

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
        if (pattern.test(line)) {
          violations.push({ file: filePath, label, line: i + 1, match: line.trim().slice(0, 80) });
          break; // one violation per line is enough
        }
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
