#!/usr/bin/env node
/**
 * 필수 데이터만 마이그레이션 (개발 로그 제외)
 */

import { execSync } from 'child_process';

const API_TOKEN = 'H3nfdRXvuqu9qr28KxzGrL5XoeezZ7_GG1SdPAmL';

// 필수 테이블만 (개발 로그 제외)
const ESSENTIAL_TABLES = [
  'draft_related_jobs',
  'draft_related_majors', 
  'draft_tags',
  'job_dictionary_index',
  'job_sources',
  'major_sources',
  'page_revisions',
  'uploaded_files',
  'user_attributions',
  'user_bookmarks',
  'wiki_pages'
];

function runLocal(sql) {
  try {
    const result = execSync(
      `npx wrangler d1 execute careerwiki-db --local --command "${sql}" --json`,
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
      `npx wrangler d1 execute careerwiki-db --remote --command "${escaped}"`,
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
      `npx wrangler d1 execute careerwiki-db --remote --command "SELECT COUNT(*) as cnt FROM ${table};" --json`,
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

function getLocalCount(table) {
  const result = runLocal(`SELECT COUNT(*) as cnt FROM ${table};`);
  return result?.[0]?.results?.[0]?.cnt || 0;
}

async function migrateTable(table) {
  const columns = getColumns(table);
  if (columns.length === 0) {
    console.log(`  ⚠️ ${table}: 컬럼 정보 없음`);
    return { success: 0, failed: 0 };
  }

  const localCount = getLocalCount(table);
  const remoteCount = getRemoteCount(table);
  
  if (localCount === remoteCount && localCount > 0) {
    console.log(`  ✅ ${table}: 이미 동기화됨 (${localCount}개)`);
    return { success: localCount, failed: 0 };
  }

  const rows = getLocalData(table);
  if (rows.length === 0) {
    console.log(`  ⬜ ${table}: 데이터 없음`);
    return { success: 0, failed: 0 };
  }

  console.log(`  📦 ${table}: ${rows.length}개 마이그레이션...`);

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

    if ((i + 1) % 500 === 0) {
      console.log(`     진행: ${i + 1}/${rows.length}`);
    }
  }

  const finalCount = getRemoteCount(table);
  const status = finalCount >= localCount ? '✅' : '⚠️';
  console.log(`  ${status} ${table}: ${finalCount}/${localCount}`);

  return { success, failed };
}

async function main() {
  console.log('='.repeat(50));
  console.log('필수 데이터 마이그레이션 (로그 제외)');
  console.log('='.repeat(50));
  console.log('');

  for (const table of ESSENTIAL_TABLES) {
    await migrateTable(table);
  }

  console.log('');
  console.log('='.repeat(50));
  console.log('완료!');
}

main().catch(console.error);

