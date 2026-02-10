#!/usr/bin/env node
/**
 * 백업된 배치 SQL 파일들을 사용해서 careerwiki DB로 데이터 마이그레이션
 */

import { execSync } from 'child_process';
import { readdirSync, existsSync } from 'fs';
import { join } from 'path';

const BATCH_DIR = 'backup_2026-01-08/migration_data/batches';
const TARGET_DB = 'careerwiki';

// 마이그레이션 순서 (FK 의존성 고려)
const TABLE_ORDER = [
  'users',
  'tags',
  'jobs_new',        // jobs 데이터
  'majors',
  'majors_new',      // majors 추가 데이터
  'pages',
  'job_attributes',
  'job_sources',
  'major_sources',
  'job_dictionary_index',
  'ai_analysis_requests',
  'ai_analysis_results',
  'page_revisions',
  'uploaded_files',
  'wiki_pages'
];

function log(msg) {
  console.log(`[${new Date().toISOString().slice(11, 19)}] ${msg}`);
}

function runBatch(file) {
  try {
    execSync(
      `npx wrangler d1 execute ${TARGET_DB} --remote --file="${file}"`,
      { stdio: 'pipe', maxBuffer: 100 * 1024 * 1024 }
    );
    return true;
  } catch (e) {
    return false;
  }
}

async function migrateTable(table) {
  const tableDir = join(BATCH_DIR, table);
  
  if (!existsSync(tableDir)) {
    log(`⏭️  ${table}: 배치 폴더 없음`);
    return { success: 0, failed: 0 };
  }
  
  const files = readdirSync(tableDir)
    .filter(f => f.endsWith('.sql'))
    .sort();
  
  if (files.length === 0) {
    log(`⏭️  ${table}: SQL 파일 없음`);
    return { success: 0, failed: 0 };
  }
  
  log(`🔄 ${table}: ${files.length}개 배치 실행 중...`);
  
  let success = 0;
  let failed = 0;
  
  for (let i = 0; i < files.length; i++) {
    const file = join(tableDir, files[i]);
    process.stdout.write(`\r   ${i + 1}/${files.length} `);
    
    if (runBatch(file)) {
      success++;
    } else {
      failed++;
    }
  }
  
  console.log(`\n✅ ${table}: 성공 ${success}, 실패 ${failed}`);
  return { success, failed };
}

async function main() {
  console.log('🚀 배치 SQL 파일로 careerwiki 마이그레이션\n');
  
  let totalSuccess = 0;
  let totalFailed = 0;
  
  for (const table of TABLE_ORDER) {
    const result = await migrateTable(table);
    totalSuccess += result.success;
    totalFailed += result.failed;
  }
  
  console.log('\n========================================');
  console.log(`✅ 성공 배치: ${totalSuccess}`);
  console.log(`❌ 실패 배치: ${totalFailed}`);
  console.log('========================================\n');
  
  // 결과 확인
  console.log('📊 데이터 확인 중...');
  try {
    const result = execSync(
      `npx wrangler d1 execute ${TARGET_DB} --remote --command "SELECT 'jobs' as tbl, COUNT(*) as cnt FROM jobs UNION ALL SELECT 'majors', COUNT(*) FROM majors UNION ALL SELECT 'users', COUNT(*) FROM users" --json`,
      { encoding: 'utf-8', stdio: ['pipe', 'pipe', 'pipe'] }
    );
    console.log(result);
  } catch (e) {
    console.log('확인 실패:', e.message);
  }
}

main().catch(e => {
  console.error('오류:', e.message);
  process.exit(1);
});
