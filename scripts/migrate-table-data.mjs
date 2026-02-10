#!/usr/bin/env node
/**
 * D1 테이블 데이터 마이그레이션 스크립트
 * 배치로 나눠서 Production에 전송
 */

import { execSync } from 'child_process';

const BATCH_SIZE = 100; // 한 번에 전송할 레코드 수
const API_TOKEN = process.env.CLOUDFLARE_API_TOKEN || 'H3nfdRXvuqu9qr28KxzGrL5XoeezZ7_GG1SdPAmL';

// 마이그레이션할 테이블 목록 (의존성 순서)
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
  'job_match_overrides',
  'name_mappings',
  'tags',
  'howtos',
  'howto_tags',
  'howto_related_jobs',
  'howto_related_majors',
  'howto_related_howtos',
  'howto_reports',
  'howto_reviews',
  'howto_drafts',
  'draft_tags',
  'draft_related_jobs',
  'draft_related_majors',
  'draft_related_howtos',
  'comments',
  'comment_votes',
  'comment_reports',
  'page_revisions',
  'page_relations',
  'wiki_pages',
  'search_index',
  'uploaded_files',
  'user_bookmarks',
  'user_attributions',
  'seed_logs',
  'seed_errors',
  'slug_history',
  'tagger_runs',
  'tagger_errors',
  'ip_blocks',
  'profanity_rules',
  'd1_migrations',
  'schema_migrations',
  'ai_sessions',
  'ai_analysis_requests',
  'ai_analysis_results',
  'career_analyses',
  'raw_events',
  'facts',
  'confirmed_constraints',
  'followup_responses',
  'question_history',
  'consents',
  'serp_interaction_logs',
  'serp_interaction_daily_summary',
  'anonymous_comment_counters',
  'anonymous_daily_limits',
  'anonymous_edit_limits',
  'feedback_posts',
  'feedback_comments',
  'feedback_replies',
];

function runCommand(cmd) {
  try {
    return execSync(cmd, { 
      encoding: 'utf-8',
      env: { ...process.env, CLOUDFLARE_API_TOKEN: API_TOKEN },
      maxBuffer: 100 * 1024 * 1024 // 100MB 버퍼
    });
  } catch (e) {
    return null;
  }
}

function getRowCount(table) {
  const result = runCommand(
    `npx wrangler d1 execute careerwiki --local --command "SELECT COUNT(*) as count FROM ${table};" --json`
  );
  if (!result) return 0;
  try {
    const json = JSON.parse(result);
    return json[0]?.results?.[0]?.count || 0;
  } catch {
    return 0;
  }
}

function getColumnNames(table) {
  const result = runCommand(
    `npx wrangler d1 execute careerwiki --local --command "PRAGMA table_info(${table});" --json`
  );
  if (!result) return [];
  try {
    const json = JSON.parse(result);
    return json[0]?.results?.map(r => r.name) || [];
  } catch {
    return [];
  }
}

function escapeValue(val) {
  if (val === null || val === undefined) return 'NULL';
  if (typeof val === 'number') return val.toString();
  if (typeof val === 'boolean') return val ? '1' : '0';
  // SQL 문자열 이스케이프
  return `'${String(val).replace(/'/g, "''")}'`;
}

async function migrateTable(table) {
  const rowCount = getRowCount(table);
  if (rowCount === 0) {
    console.log(`  ⏭️  ${table}: 0 rows (스킵)`);
    return { success: true, rows: 0 };
  }

  console.log(`  📦 ${table}: ${rowCount} rows 마이그레이션 중...`);
  
  const columns = getColumnNames(table);
  if (columns.length === 0) {
    console.log(`    ❌ 컬럼 정보를 가져올 수 없습니다.`);
    return { success: false, rows: 0 };
  }

  let migratedRows = 0;
  const totalBatches = Math.ceil(rowCount / BATCH_SIZE);

  for (let batch = 0; batch < totalBatches; batch++) {
    const offset = batch * BATCH_SIZE;
    
    // 배치 데이터 가져오기
    const dataResult = runCommand(
      `npx wrangler d1 execute careerwiki --local --command "SELECT * FROM ${table} LIMIT ${BATCH_SIZE} OFFSET ${offset};" --json`
    );
    
    if (!dataResult) {
      console.log(`    ❌ 배치 ${batch + 1}/${totalBatches} 데이터 가져오기 실패`);
      continue;
    }

    let rows;
    try {
      const json = JSON.parse(dataResult);
      rows = json[0]?.results || [];
    } catch {
      console.log(`    ❌ 배치 ${batch + 1}/${totalBatches} JSON 파싱 실패`);
      continue;
    }

    if (rows.length === 0) break;

    // INSERT 문 생성 (개별 INSERT로 분리)
    for (const row of rows) {
      const values = columns.map(col => escapeValue(row[col])).join(', ');
      const insertSQL = `INSERT OR REPLACE INTO ${table} (${columns.join(', ')}) VALUES (${values});`;
      
      // Production에 실행
      const insertResult = runCommand(
        `npx wrangler d1 execute careerwiki --remote --command "${insertSQL.replace(/"/g, '\\"')}"`
      );
      
      if (insertResult) {
        migratedRows++;
      }
    }

    process.stdout.write(`    진행: ${Math.min((batch + 1) * BATCH_SIZE, rowCount)}/${rowCount} rows\r`);
  }

  console.log(`    ✅ ${migratedRows}/${rowCount} rows 완료`);
  return { success: true, rows: migratedRows };
}

async function main() {
  console.log('============================================');
  console.log('D1 Production 데이터 마이그레이션');
  console.log('============================================\n');

  const results = {
    success: 0,
    skipped: 0,
    failed: 0,
    totalRows: 0
  };

  for (const table of TABLES) {
    try {
      const result = await migrateTable(table);
      if (result.rows === 0) {
        results.skipped++;
      } else if (result.success) {
        results.success++;
        results.totalRows += result.rows;
      } else {
        results.failed++;
      }
    } catch (e) {
      console.log(`  ❌ ${table}: 오류 - ${e.message}`);
      results.failed++;
    }
  }

  console.log('\n============================================');
  console.log('마이그레이션 결과');
  console.log('============================================');
  console.log(`  성공: ${results.success} 테이블 (${results.totalRows} rows)`);
  console.log(`  스킵: ${results.skipped} 테이블 (데이터 없음)`);
  console.log(`  실패: ${results.failed} 테이블`);
}

main().catch(console.error);

