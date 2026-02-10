#!/usr/bin/env node
/**
 * careerwiki-kr에서 새 careerwiki DB로 직접 데이터 마이그레이션
 * 배치 파일보다 빠르게 진행
 */

import { execSync } from 'child_process';
import { writeFileSync, unlinkSync } from 'fs';

const SOURCE_DB = 'careerwiki-kr';
const TARGET_DB = 'careerwiki';

// 마이그레이션 순서 (FK 의존성 고려)
const TABLES = [
  'users',
  'tags',
  'jobs',
  'majors',
  'pages',
  'job_attributes',
  'job_sources',
  'major_sources',
  'job_dictionary_index',
  'ai_analysis_requests',
  'ai_analysis_results',
  'page_revisions',
  'uploaded_files',
  'wiki_pages',
  'howto_drafts',
  'howtos',
  'howto_tags',
  'howto_related_jobs',
  'howto_related_majors',
  'howto_related_howtos',
  'draft_tags',
  'draft_related_jobs',
  'draft_related_majors',
  'draft_related_howtos',
  'comments',
  'career_analyses',
  'search_index',
  'ai_sessions',
  'serp_interaction_logs',
  'serp_interaction_daily_summary',
  'comment_votes',
  'comment_reports',
  'ip_blocks',
  'anonymous_comment_counters',
  'anonymous_daily_limits',
  'anonymous_edit_limits',
  'job_match_overrides',
  'job_assets',
  'major_assets',
  'seed_logs',
  'seed_errors',
  'feedback_posts',
  'feedback_replies',
  'schema_migrations',
  'name_mappings',
  'howto_reports',
  'slug_history',
  'howto_reviews',
  'user_bookmarks',
  'page_relations',
  'user_attributions',
  'consents',
  'profanity_rules',
  'feedback_comments',
  'followup_responses',
  'confirmed_constraints',
  'question_history',
  'tagger_runs',
  'tagger_errors',
  'raw_events_backup',
  'facts_backup',
  'raw_events',
  'facts',
  'conversation_turns',
  'user_profile_snapshots',
  'hypothesis_history'
];

function log(msg) {
  console.log(`[${new Date().toISOString().slice(11, 19)}] ${msg}`);
}

function getTableCount(db, table) {
  try {
    const result = execSync(
      `npx wrangler d1 execute ${db} --remote --command "SELECT COUNT(*) as cnt FROM ${table}" --json`,
      { encoding: 'utf-8', stdio: 'pipe' }
    );
    const data = JSON.parse(result);
    return data[0].results[0]?.cnt || 0;
  } catch (e) {
    return 0;
  }
}

function migrateTable(table) {
  log(`🔄 ${table} 마이그레이션 중...`);
  
  const sourceCount = getTableCount(SOURCE_DB, table);
  const targetCount = getTableCount(TARGET_DB, table);
  
  if (sourceCount === 0) {
    log(`   ⏭️  소스에 데이터 없음`);
    return { success: true, count: 0 };
  }
  
  if (targetCount === sourceCount) {
    log(`   ✅ 이미 마이그레이션 완료 (${targetCount}개)`);
    return { success: true, count: targetCount };
  }
  
  log(`   📊 소스: ${sourceCount}개, 타겟: ${targetCount}개`);
  
  // 데이터 추출 및 삽입
  try {
    // 1. 소스에서 데이터 추출
    const exportResult = execSync(
      `npx wrangler d1 execute ${SOURCE_DB} --remote --command "SELECT * FROM ${table}" --json`,
      { encoding: 'utf-8', stdio: 'pipe', maxBuffer: 500 * 1024 * 1024 }
    );
    
    const data = JSON.parse(exportResult);
    const rows = data[0].results;
    
    if (rows.length === 0) {
      log(`   ⏭️  데이터 없음`);
      return { success: true, count: 0 };
    }
    
    // 2. INSERT 문 생성 (배치로 나누기)
    const BATCH_SIZE = 100;
    let inserted = 0;
    
    for (let i = 0; i < rows.length; i += BATCH_SIZE) {
      const batch = rows.slice(i, i + BATCH_SIZE);
      const cols = Object.keys(batch[0]);
      
      const values = batch.map(row => {
        const vals = cols.map(col => {
          const val = row[col];
          if (val === null) return 'NULL';
          if (typeof val === 'number') return val;
          return "'" + String(val).replace(/'/g, "''") + "'";
        });
        return `(${vals.join(', ')})`;
      });
      
      const sql = `INSERT OR REPLACE INTO ${table} (${cols.join(', ')}) VALUES ${values.join(', ')};`;
      
      // 임시 파일에 저장
      const tempFile = `temp_migrate_${table}_${i}.sql`;
      writeFileSync(tempFile, sql, 'utf8');
      
      try {
        execSync(
          `npx wrangler d1 execute ${TARGET_DB} --remote --file="${tempFile}"`,
          { stdio: 'pipe', maxBuffer: 100 * 1024 * 1024 }
        );
        inserted += batch.length;
        process.stdout.write(`\r   진행: ${inserted}/${rows.length} `);
      } catch (e) {
        log(`\n   ❌ 배치 ${i} 실패: ${e.message}`);
      }
      
      // 임시 파일 삭제
      try { unlinkSync(tempFile); } catch {}
    }
    
    console.log(`\n   ✅ 완료: ${inserted}개 삽입`);
    
    // 확인
    const finalCount = getTableCount(TARGET_DB, table);
    if (finalCount === sourceCount) {
      return { success: true, count: finalCount };
    } else {
      log(`   ⚠️  개수 불일치: 예상 ${sourceCount}, 실제 ${finalCount}`);
      return { success: false, count: finalCount };
    }
    
  } catch (e) {
    log(`   ❌ 실패: ${e.message}`);
    return { success: false, count: 0 };
  }
}

async function main() {
  console.log('🚀 careerwiki-kr → careerwiki 직접 마이그레이션\n');
  
  let totalSuccess = 0;
  let totalFailed = 0;
  let totalRows = 0;
  
  for (const table of TABLES) {
    const result = await migrateTable(table);
    if (result.success) {
      totalSuccess++;
      totalRows += result.count;
    } else {
      totalFailed++;
    }
    console.log(''); // 빈 줄
  }
  
  console.log('========================================');
  console.log(`✅ 성공 테이블: ${totalSuccess}`);
  console.log(`❌ 실패 테이블: ${totalFailed}`);
  console.log(`📊 총 데이터 행: ${totalRows.toLocaleString()}`);
  console.log('========================================\n');
  
  // 최종 확인
  console.log('📊 최종 데이터 확인...');
  const jobs = getTableCount(TARGET_DB, 'jobs');
  const majors = getTableCount(TARGET_DB, 'majors');
  const users = getTableCount(TARGET_DB, 'users');
  console.log(`jobs: ${jobs}, majors: ${majors}, users: ${users}`);
}

main().catch(e => {
  console.error('오류:', e.message);
  process.exit(1);
});
