#!/usr/bin/env node
/**
 * Production D1 → 로컬 D1 동기화 스크립트
 * 
 * 사용: npm run sync:prod-to-local
 * 
 * Production의 핵심 데이터를 로컬로 동기화합니다.
 */

import { execSync } from 'child_process';
import { readFileSync, writeFileSync, mkdirSync, existsSync } from 'fs';
import { fileURLToPath } from 'url';
import { dirname, join } from 'path';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);
const rootDir = join(__dirname, '..');

// .dev.vars에서 API 토큰 읽기
function loadDevVars() {
  const devVarsPath = join(rootDir, '.dev.vars');
  if (!existsSync(devVarsPath)) {
    return null;
  }

  try {
    const content = readFileSync(devVarsPath, 'utf-8');
    // PowerShell 형식: $env:CLOUDFLARE_API_TOKEN="..."
    const match = content.match(/\$env:CLOUDFLARE_API_TOKEN=["']([^"']+)["']/);
    if (match) {
      return match[1];
    }
    // 일반 형식: CLOUDFLARE_API_TOKEN=...
    const match2 = content.match(/^CLOUDFLARE_API_TOKEN=["']?([^"'\n]+)["']?$/m);
    if (match2) {
      return match2[1];
    }
  } catch (e) {
    // 무시
  }
  return null;
}

const API_TOKEN = process.env.CLOUDFLARE_API_TOKEN || loadDevVars();

// 동기화할 핵심 테이블 (순서 중요: FK 의존성 고려)
const SYNC_TABLES = [
  'users',
  'tags',
  'jobs',
  'majors',
  'pages',
  'job_attributes',
  'facts',
  'profanity_rules'
];

function log(msg) {
  console.log(`[${new Date().toISOString().slice(11, 19)}] ${msg}`);
}

function runCommand(cmd, options = {}) {
  try {
    return execSync(cmd, {
      encoding: 'utf-8',
      env: { ...process.env, CLOUDFLARE_API_TOKEN: API_TOKEN },
      maxBuffer: 500 * 1024 * 1024,
      stdio: options.silent ? ['pipe', 'pipe', 'pipe'] : 'inherit',
      ...options
    });
  } catch (e) {
    if (!options.ignoreError) {
      console.error(`명령 실패: ${cmd}`);
      throw e;
    }
    return null;
  }
}

function getRemoteCount(table) {
  const result = runCommand(
    `npx wrangler d1 execute careerwiki-db --remote --command "SELECT COUNT(*) as cnt FROM ${table};" --json`,
    { silent: true }
  );
  try {
    return JSON.parse(result)?.[0]?.results?.[0]?.cnt || 0;
  } catch {
    return 0;
  }
}

function getLocalCount(table) {
  const result = runCommand(
    `npx wrangler d1 execute careerwiki-db --local --command "SELECT COUNT(*) as cnt FROM ${table};" --json`,
    { silent: true }
  );
  try {
    return JSON.parse(result)?.[0]?.results?.[0]?.cnt || 0;
  } catch {
    return 0;
  }
}

async function syncTable(table) {
  const remoteCount = getRemoteCount(table);
  const localCount = getLocalCount(table);

  if (remoteCount === localCount) {
    log(`✅ ${table}: 동기화됨 (${remoteCount})`);
    return true;
  }

  log(`🔄 ${table}: Production ${remoteCount} → 로컬 ${localCount}`);

  // Production에서 덤프
  const dumpFile = `sync_temp/${table}.sql`;
  if (!existsSync('sync_temp')) {
    mkdirSync('sync_temp', { recursive: true });
  }

  try {
    runCommand(
      `npx wrangler d1 export careerwiki-db --remote --no-schema --table=${table} --output=${dumpFile}`,
      { silent: true }
    );

    // 로컬 테이블 비우기
    runCommand(
      `npx wrangler d1 execute careerwiki-db --local --command "DELETE FROM ${table};"`,
      { silent: true }
    );

    // 로컬에 적용
    runCommand(
      `npx wrangler d1 execute careerwiki-db --local --file=${dumpFile}`,
      { silent: true }
    );

    const newLocalCount = getLocalCount(table);
    log(`✅ ${table}: ${newLocalCount}개 동기화 완료`);
    return true;
  } catch (e) {
    log(`❌ ${table}: 동기화 실패 - ${e.message}`);
    return false;
  }
}

async function main() {
  // API 토큰 없으면 경고만 하고 스킵
  if (!API_TOKEN) {
    console.log('⚠️  CLOUDFLARE_API_TOKEN이 없어 동기화를 스킵합니다.');
    console.log('   동기화 없이 개발 서버를 시작합니다...\n');
    process.exit(0);
  }

  console.log('🔄 Production → 로컬 D1 동기화 중...\n');

  let success = 0;
  let failed = 0;
  let needsSync = false;

  // 빠른 체크: 동기화 필요한지 확인
  for (const table of SYNC_TABLES) {
    const remoteCount = getRemoteCount(table);
    const localCount = getLocalCount(table);
    if (remoteCount !== localCount) {
      needsSync = true;
      break;
    }
  }

  if (!needsSync) {
    console.log('✅ 모든 데이터가 이미 동기화되어 있습니다.\n');
    process.exit(0);
  }

  // 동기화 실행
  for (const table of SYNC_TABLES) {
    if (await syncTable(table)) {
      success++;
    } else {
      failed++;
    }
  }

  console.log('');
  if (failed === 0) {
    console.log('✅ 동기화 완료!\n');
  } else {
    console.log(`⚠️  동기화 완료 (일부 실패: ${failed})\n`);
  }

  // 정리
  if (existsSync('sync_temp')) {
    runCommand('rm -rf sync_temp', { silent: true, ignoreError: true });
  }
}

main().catch((err) => {
  console.error('동기화 중 오류:', err.message);
  // 실패해도 개발 서버는 실행되도록
  process.exit(0);
});

