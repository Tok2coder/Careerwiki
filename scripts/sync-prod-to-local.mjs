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

const API_TOKEN = process.env.CLOUDFLARE_API_TOKEN;

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
  console.log('='.repeat(50));
  console.log('Production → 로컬 D1 동기화');
  console.log('='.repeat(50));
  console.log('');

  if (!API_TOKEN) {
    console.error('❌ CLOUDFLARE_API_TOKEN 환경변수가 필요합니다.');
    console.error('   PowerShell: $env:CLOUDFLARE_API_TOKEN="your-token"');
    process.exit(1);
  }

  log('동기화 시작...');
  console.log('');

  let success = 0;
  let failed = 0;

  for (const table of SYNC_TABLES) {
    if (await syncTable(table)) {
      success++;
    } else {
      failed++;
    }
  }

  console.log('');
  console.log('='.repeat(50));
  console.log(`완료: 성공 ${success}, 실패 ${failed}`);
  console.log('='.repeat(50));

  // 정리
  if (existsSync('sync_temp')) {
    runCommand('rm -rf sync_temp', { silent: true, ignoreError: true });
  }
}

main().catch(console.error);

