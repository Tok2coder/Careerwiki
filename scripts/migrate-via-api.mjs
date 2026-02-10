#!/usr/bin/env node
/**
 * Cloudflare D1 REST API를 사용한 데이터 마이그레이션
 * careerwiki-kr → careerwiki
 */

import { readFileSync, existsSync } from 'fs';
import { fileURLToPath } from 'url';
import { dirname, join } from 'path';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);
const rootDir = join(__dirname, '..');

const ACCOUNT_ID = '3587865378649966bfb0a814fce73c77';
const OLD_DB_ID = 'edc21e23-c2ac-4693-bb79-389b6914e173'; // careerwiki-kr
const NEW_DB_ID = '37fa15f6-9a2b-4bd6-bae9-687b18dc29f8'; // careerwiki

// .dev.vars에서 API 토큰 읽기
function loadApiToken() {
  const devVarsPath = join(rootDir, '.dev.vars');
  if (!existsSync(devVarsPath)) return process.env.CLOUDFLARE_API_TOKEN;
  
  try {
    const content = readFileSync(devVarsPath, 'utf-8');
    const match = content.match(/CLOUDFLARE_API_TOKEN=["']?([^"'\n]+)["']?/);
    return match ? match[1] : process.env.CLOUDFLARE_API_TOKEN;
  } catch {
    return process.env.CLOUDFLARE_API_TOKEN;
  }
}

const API_TOKEN = loadApiToken();

if (!API_TOKEN) {
  console.error('❌ CLOUDFLARE_API_TOKEN이 필요합니다.');
  process.exit(1);
}

async function query(dbId, sql, params = []) {
  const res = await fetch(
    `https://api.cloudflare.com/client/v4/accounts/${ACCOUNT_ID}/d1/database/${dbId}/query`,
    {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${API_TOKEN}`,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({ sql, params })
    }
  );
  const data = await res.json();
  if (!data.success) {
    throw new Error(data.errors?.[0]?.message || 'D1 API Error');
  }
  return data.result?.[0]?.results || [];
}

async function getCount(dbId, table) {
  try {
    const result = await query(dbId, `SELECT COUNT(*) as cnt FROM ${table}`);
    return result[0]?.cnt || 0;
  } catch {
    return -1;
  }
}

async function getTableColumns(dbId, table) {
  try {
    const result = await query(dbId, `PRAGMA table_info(${table})`);
    return result.map(r => r.name);
  } catch {
    return [];
  }
}

// 마이그레이션할 테이블 (FK 순서)
const TABLES = [
  'users', 'tags', 'jobs', 'majors', 'pages', 
  'job_attributes', 'job_sources', 'major_sources',
  'job_dictionary_index', 'facts', 'profanity_rules',
  'ai_analysis_requests', 'ai_analysis_results',
  'comments', 'comment_votes', 'page_revisions',
  'howtos', 'howto_drafts', 'howto_tags', 'howto_relations',
  'howto_reports', 'uploaded_files', 'user_bookmarks',
  'user_onboarding', 'feedback_posts', 'feedback_comments',
  'name_mappings', 'wiki_pages'
];

async function migrateTable(table) {
  const oldCount = await getCount(OLD_DB_ID, table);
  const newCount = await getCount(NEW_DB_ID, table);
  
  if (oldCount <= 0) {
    console.log(`⏭️  ${table}: 원본 데이터 없음`);
    return true;
  }
  
  if (newCount >= oldCount) {
    console.log(`✅ ${table}: 이미 마이그레이션됨 (${newCount}/${oldCount})`);
    return true;
  }
  
  console.log(`🔄 ${table}: ${oldCount}개 마이그레이션 중...`);
  
  const columns = await getTableColumns(OLD_DB_ID, table);
  if (columns.length === 0) {
    console.log(`❌ ${table}: 컬럼 정보 없음`);
    return false;
  }
  
  // 배치 사이즈 (D1 제한 고려)
  const BATCH_SIZE = 50;
  let offset = 0;
  let migrated = 0;
  
  while (offset < oldCount) {
    try {
      // 데이터 조회
      const rows = await query(
        OLD_DB_ID,
        `SELECT * FROM ${table} LIMIT ${BATCH_SIZE} OFFSET ${offset}`
      );
      
      if (rows.length === 0) break;
      
      // 배치 INSERT
      for (const row of rows) {
        const values = columns.map(col => row[col]);
        const placeholders = columns.map(() => '?').join(', ');
        const colNames = columns.join(', ');
        
        try {
          await query(
            NEW_DB_ID,
            `INSERT OR IGNORE INTO ${table} (${colNames}) VALUES (${placeholders})`,
            values
          );
          migrated++;
        } catch (e) {
          // 중복 등 무시
        }
      }
      
      offset += BATCH_SIZE;
      process.stdout.write(`\r  진행: ${Math.min(offset, oldCount)}/${oldCount}`);
    } catch (e) {
      console.log(`\n❌ ${table}: ${e.message}`);
      break;
    }
  }
  
  console.log(`\n✅ ${table}: ${migrated}개 완료`);
  return migrated > 0;
}

async function main() {
  console.log('🚀 D1 API를 통한 데이터 마이그레이션\n');
  console.log(`원본: careerwiki-kr (${OLD_DB_ID})`);
  console.log(`대상: careerwiki (${NEW_DB_ID})\n`);
  
  let success = 0, failed = 0;
  
  for (const table of TABLES) {
    if (await migrateTable(table)) success++;
    else failed++;
  }
  
  console.log('\n========================================');
  console.log(`✅ 성공: ${success} / ❌ 실패: ${failed}`);
  console.log('========================================\n');
}

main().catch(e => {
  console.error('오류:', e.message);
  process.exit(1);
});
