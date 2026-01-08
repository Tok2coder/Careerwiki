#!/usr/bin/env node
/**
 * D1 데이터 마이그레이션: 배치 파일 분할 및 실행
 * 큰 테이블을 작은 SQL 파일로 나눠서 순차 실행
 */

import { execSync } from 'child_process';
import { writeFileSync, mkdirSync, existsSync, readdirSync, unlinkSync } from 'fs';

const API_TOKEN = 'H3nfdRXvuqu9qr28KxzGrL5XoeezZ7_GG1SdPAmL';
const BATCH_SIZE = 50; // 한 배치당 레코드 수
const OUTPUT_DIR = 'migration_data/batches';

// 마이그레이션할 테이블 (의존성 순서)
const TABLES = [
  'users',
  'pages', 
  'jobs',
  'majors',
  'job_sources',
  'major_sources',
  'job_attributes',
  'job_assets',
  'major_assets',
  'job_dictionary_index',
  'name_mappings',
  'tags',
  'howtos',
  'howto_tags',
  'howto_related_jobs',
  'howto_related_majors',
  'comments',
  'page_revisions',
  'wiki_pages',
  'uploaded_files',
  'd1_migrations',
  'ai_sessions',
  'ai_analysis_requests',
  'ai_analysis_results',
  'serp_interaction_logs',
];

function runLocal(cmd) {
  try {
    return execSync(cmd, {
      encoding: 'utf-8',
      env: { ...process.env, CLOUDFLARE_API_TOKEN: API_TOKEN },
      maxBuffer: 500 * 1024 * 1024,
      stdio: ['pipe', 'pipe', 'pipe']
    });
  } catch (e) {
    return null;
  }
}

function runRemote(cmd) {
  try {
    execSync(cmd, {
      encoding: 'utf-8',
      env: { ...process.env, CLOUDFLARE_API_TOKEN: API_TOKEN },
      maxBuffer: 100 * 1024 * 1024,
      stdio: 'inherit'
    });
    return true;
  } catch (e) {
    return false;
  }
}

function getRowCount(table) {
  const result = runLocal(
    `npx wrangler d1 execute careerwiki-db --local --command "SELECT COUNT(*) as count FROM ${table};" --json`
  );
  if (!result) return 0;
  try {
    const json = JSON.parse(result);
    return json[0]?.results?.[0]?.count || 0;
  } catch {
    return 0;
  }
}

function escapeSQL(val) {
  if (val === null || val === undefined) return 'NULL';
  if (typeof val === 'number') return val.toString();
  if (typeof val === 'boolean') return val ? '1' : '0';
  const str = String(val)
    .replace(/'/g, "''")
    .replace(/\\/g, '\\\\');
  return `'${str}'`;
}

async function splitTableToBatches(table) {
  const rowCount = getRowCount(table);
  if (rowCount === 0) {
    console.log(`  ⏭️  ${table}: 0 rows (스킵)`);
    return { batches: 0, rows: 0 };
  }

  console.log(`  📦 ${table}: ${rowCount} rows 분할 중...`);
  
  // 컬럼 정보 가져오기
  const pragmaResult = runLocal(
    `npx wrangler d1 execute careerwiki-db --local --command "PRAGMA table_info(${table});" --json`
  );
  if (!pragmaResult) {
    console.log(`    ❌ 컬럼 정보 가져오기 실패`);
    return { batches: 0, rows: 0 };
  }
  
  let columns;
  try {
    const json = JSON.parse(pragmaResult);
    columns = json[0]?.results?.map(r => r.name) || [];
  } catch {
    console.log(`    ❌ 컬럼 파싱 실패`);
    return { batches: 0, rows: 0 };
  }

  const totalBatches = Math.ceil(rowCount / BATCH_SIZE);
  const tableDir = `${OUTPUT_DIR}/${table}`;
  
  if (!existsSync(tableDir)) {
    mkdirSync(tableDir, { recursive: true });
  }

  for (let batch = 0; batch < totalBatches; batch++) {
    const offset = batch * BATCH_SIZE;
    
    // 배치 데이터 가져오기
    const dataResult = runLocal(
      `npx wrangler d1 execute careerwiki-db --local --command "SELECT * FROM ${table} LIMIT ${BATCH_SIZE} OFFSET ${offset};" --json`
    );
    
    if (!dataResult) {
      console.log(`    ❌ 배치 ${batch + 1} 데이터 가져오기 실패`);
      continue;
    }

    let rows;
    try {
      const json = JSON.parse(dataResult);
      rows = json[0]?.results || [];
    } catch {
      continue;
    }

    if (rows.length === 0) break;

    // SQL 파일 생성
    let sql = `-- ${table} batch ${batch + 1}/${totalBatches}\n`;
    sql += `-- Rows: ${rows.length}\n\n`;
    
    for (const row of rows) {
      const values = columns.map(col => escapeSQL(row[col])).join(', ');
      sql += `INSERT OR REPLACE INTO ${table} (${columns.join(', ')}) VALUES (${values});\n`;
    }

    const batchFile = `${tableDir}/batch_${String(batch + 1).padStart(4, '0')}.sql`;
    writeFileSync(batchFile, sql);
    
    process.stdout.write(`    분할: ${batch + 1}/${totalBatches}\r`);
  }

  console.log(`    ✅ ${totalBatches} 배치 파일 생성 완료`);
  return { batches: totalBatches, rows: rowCount };
}

async function applyBatches(table) {
  const tableDir = `${OUTPUT_DIR}/${table}`;
  if (!existsSync(tableDir)) {
    return { success: 0, failed: 0 };
  }

  const files = readdirSync(tableDir)
    .filter(f => f.endsWith('.sql'))
    .sort();

  if (files.length === 0) return { success: 0, failed: 0 };

  console.log(`  🚀 ${table}: ${files.length} 배치 적용 중...`);
  
  let success = 0;
  let failed = 0;

  for (let i = 0; i < files.length; i++) {
    const file = files[i];
    const filePath = `${tableDir}/${file}`;
    
    process.stdout.write(`    적용: ${i + 1}/${files.length}\r`);
    
    const result = runRemote(
      `npx wrangler d1 execute careerwiki-db --remote --file="${filePath}"`
    );
    
    if (result) {
      success++;
    } else {
      failed++;
      console.log(`\n    ⚠️  ${file} 실패`);
    }
  }

  console.log(`    ✅ 완료: ${success}/${files.length} 배치 성공`);
  return { success, failed };
}

async function main() {
  console.log('============================================');
  console.log('D1 Production 데이터 마이그레이션');
  console.log('============================================\n');

  // 출력 디렉토리 생성
  if (!existsSync(OUTPUT_DIR)) {
    mkdirSync(OUTPUT_DIR, { recursive: true });
  }

  // Phase 1: 배치 파일 생성
  console.log('[Phase 1] 배치 파일 생성\n');
  
  const splitResults = {};
  for (const table of TABLES) {
    splitResults[table] = await splitTableToBatches(table);
  }

  // Phase 2: Production에 적용
  console.log('\n[Phase 2] Production에 적용\n');
  
  const applyResults = {};
  for (const table of TABLES) {
    if (splitResults[table]?.batches > 0) {
      applyResults[table] = await applyBatches(table);
    }
  }

  // 결과 요약
  console.log('\n============================================');
  console.log('마이그레이션 결과');
  console.log('============================================');
  
  let totalRows = 0;
  let totalSuccess = 0;
  let totalFailed = 0;

  for (const table of TABLES) {
    const split = splitResults[table];
    const apply = applyResults[table];
    
    if (split?.rows > 0) {
      console.log(`  ${table}: ${split.rows} rows, ${apply?.success || 0}/${split.batches} 배치 성공`);
      totalRows += split.rows;
      totalSuccess += apply?.success || 0;
      totalFailed += apply?.failed || 0;
    }
  }

  console.log('--------------------------------------------');
  console.log(`  총 ${totalRows} rows, ${totalSuccess} 배치 성공, ${totalFailed} 배치 실패`);
}

main().catch(console.error);

