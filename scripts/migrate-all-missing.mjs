#!/usr/bin/env node
/**
 * 모든 누락된 테이블 데이터 마이그레이션
 */

import { execSync } from 'child_process';

const API_TOKEN = 'H3nfdRXvuqu9qr28KxzGrL5XoeezZ7_GG1SdPAmL';

// 누락된 테이블 목록 (로컬 데이터 > 0 인 것들)
const MISSING_TABLES = [
  'anonymous_comment_counters',
  'anonymous_daily_limits',
  'consents',
  'draft_related_jobs',
  'draft_related_majors',
  'draft_tags',
  'facts',
  'facts_backup',
  'job_dictionary_index',
  'job_sources',
  'major_sources',
  'page_revisions',
  'profanity_rules',
  'question_history',
  'raw_events',
  'raw_events_backup',
  'schema_migrations',
  'seed_errors',
  'seed_logs',
  'tagger_errors',
  'tagger_runs',
  'uploaded_files',
  'user_attributions',
  'user_bookmarks',
  'wiki_pages'
];

function runLocal(sql) {
  try {
    const result = execSync(
      `npx wrangler d1 execute careerwiki --local --command "${sql}" --json`,
      {
        encoding: 'utf-8',
        env: { ...process.env, CLOUDFLARE_API_TOKEN: API_TOKEN },
        maxBuffer: 500 * 1024 * 1024,
        stdio: ['pipe', 'pipe', 'pipe']
      }
    );
    return JSON.parse(result);
  } catch (e) {
    return null;
  }
}

function runRemote(sql) {
  const escaped = sql.replace(/\\/g, '\\\\').replace(/"/g, '\\"').replace(/\$/g, '\\$');
  try {
    execSync(
      `npx wrangler d1 execute careerwiki --remote --command "${escaped}"`,
      {
        encoding: 'utf-8',
        env: { ...process.env, CLOUDFLARE_API_TOKEN: API_TOKEN },
        maxBuffer: 10 * 1024 * 1024,
        stdio: ['pipe', 'pipe', 'pipe']
      }
    );
    return true;
  } catch (e) {
    return false;
  }
}

function escapeSQL(val) {
  if (val === null || val === undefined) return 'NULL';
  if (typeof val === 'number') return val.toString();
  if (typeof val === 'boolean') return val ? '1' : '0';
  const str = String(val).replace(/'/g, "''");
  return `'${str}'`;
}

function getColumns(table) {
  const result = runLocal(`PRAGMA table_info(${table});`);
  return result?.[0]?.results?.map(r => r.name) || [];
}

function getLocalData(table) {
  const result = runLocal(`SELECT * FROM ${table};`);
  return result?.[0]?.results || [];
}

function getRemoteCount(table) {
  try {
    const result = execSync(
      `npx wrangler d1 execute careerwiki --remote --command "SELECT COUNT(*) as cnt FROM ${table};" --json`,
      {
        encoding: 'utf-8',
        env: { ...process.env, CLOUDFLARE_API_TOKEN: API_TOKEN },
        stdio: ['pipe', 'pipe', 'pipe']
      }
    );
    return JSON.parse(result)?.[0]?.results?.[0]?.cnt || 0;
  } catch {
    return 0;
  }
}

async function migrateTable(table) {
  const columns = getColumns(table);
  if (columns.length === 0) {
    console.log(`  ⚠️ ${table}: 컬럼 정보 없음`);
    return { success: 0, failed: 0 };
  }

  const rows = getLocalData(table);
  if (rows.length === 0) {
    console.log(`  ⬜ ${table}: 데이터 없음`);
    return { success: 0, failed: 0 };
  }

  console.log(`  📦 ${table}: ${rows.length}개 마이그레이션 중...`);

  let success = 0;
  let failed = 0;

  for (let i = 0; i < rows.length; i++) {
    const row = rows[i];
    const values = columns.map(col => escapeSQL(row[col])).join(', ');
    const sql = `INSERT OR REPLACE INTO ${table} (${columns.join(', ')}) VALUES (${values});`;

    if (runRemote(sql)) {
      success++;
    } else {
      failed++;
    }

    // 진행상황 (100개마다)
    if ((i + 1) % 100 === 0) {
      process.stdout.write(`\r  📦 ${table}: ${i + 1}/${rows.length}...`);
    }
  }

  if (rows.length >= 100) {
    process.stdout.write('\r');
  }

  const remoteCount = getRemoteCount(table);
  const localCount = rows.length;
  const status = remoteCount >= localCount ? '✅' : '⚠️';
  
  console.log(`  ${status} ${table}: ${success}/${rows.length} (Production: ${remoteCount})`);

  return { success, failed };
}

async function main() {
  console.log('='.repeat(60));
  console.log('누락된 모든 테이블 마이그레이션');
  console.log('='.repeat(60));
  console.log('');

  let totalSuccess = 0;
  let totalFailed = 0;

  for (const table of MISSING_TABLES) {
    const { success, failed } = await migrateTable(table);
    totalSuccess += success;
    totalFailed += failed;
  }

  console.log('');
  console.log('='.repeat(60));
  console.log(`완료: 성공 ${totalSuccess}, 실패 ${totalFailed}`);
  console.log('='.repeat(60));
}

main().catch(console.error);

