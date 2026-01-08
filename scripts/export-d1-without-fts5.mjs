#!/usr/bin/env node
/**
 * D1 데이터베이스에서 FTS5 가상 테이블을 제외하고 SQL 덤프 생성
 * better-sqlite3 사용
 * 
 * 사용법:
 * node scripts/export-d1-without-fts5.mjs
 */

import Database from 'better-sqlite3';
import { readFileSync, writeFileSync, existsSync } from 'fs';
import { join, dirname } from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

const DB_PATH = join(__dirname, '..', '.wrangler/state/v3/d1/miniflare-D1DatabaseObject/careerwiki-db.sqlite');
const OUTPUT_FILE = join(__dirname, '..', 'migration_backup.sql');

console.log('📦 D1 데이터베이스 덤프 생성 중 (FTS5 제외)...\n');
console.log(`📂 DB 경로: ${DB_PATH}`);
console.log(`📂 출력 파일: ${OUTPUT_FILE}\n`);

try {
  // DB 파일 존재 확인
  if (!existsSync(DB_PATH)) {
    console.error(`❌ DB 파일을 찾을 수 없습니다: ${DB_PATH}`);
    process.exit(1);
  }

  const db = new Database(DB_PATH, { readonly: true });

  // 테이블 목록 가져오기 (FTS5 제외)
  const allTables = db.prepare(`
    SELECT name 
    FROM sqlite_master 
    WHERE type='table'
    ORDER BY name
  `).all().map(row => row.name);
  
  console.log(`🔍 전체 테이블: ${allTables.length}개`);
  console.log(`   예시: ${allTables.slice(0, 5).join(', ')}...\n`);
  
  // FTS5 및 시스템 테이블 제외
  const tables = allTables.filter(name => 
    !name.includes('_fts') && 
    !name.startsWith('sqlite_') &&
    name !== '_cf_METADATA' &&
    name !== '_cf_KV'
  );

  console.log(`📊 마이그레이션 대상 테이블: ${tables.length}개\n`);

  let sqlDump = `-- D1 Database Dump (FTS5 제외)
-- Generated: ${new Date().toISOString()}
-- Tables: ${tables.length}

PRAGMA foreign_keys = OFF;
BEGIN TRANSACTION;

`;

  // 스키마 덤프
  console.log('📐 스키마 덤프 중...');
  for (const table of tables) {
    try {
      const schema = db.prepare(`SELECT sql FROM sqlite_master WHERE type='table' AND name=?`).get(table);
      if (schema && schema.sql) {
        sqlDump += `-- Table: ${table}\n${schema.sql};\n\n`;
      }
    } catch (e) {
      console.warn(`⚠️  테이블 ${table} 스키마 가져오기 실패: ${e.message}`);
    }
  }

  // 데이터 덤프
  console.log('📦 데이터 덤프 중...');
  for (const table of tables) {
    try {
      const rowCount = db.prepare(`SELECT COUNT(*) as count FROM ${table}`).get().count;

      if (rowCount > 0) {
        console.log(`  - ${table}: ${rowCount} rows`);
        
        // 컬럼 정보 가져오기
        const columns = db.prepare(`PRAGMA table_info(${table})`).all();
        const columnNames = columns.map(col => col.name);
        
        // 데이터 가져오기
        const rows = db.prepare(`SELECT * FROM ${table}`).all();
        
        if (rows.length > 0) {
          sqlDump += `-- Data for table: ${table} (${rowCount} rows)\n`;
          
          // 배치 INSERT (1000개씩)
          const batchSize = 1000;
          for (let i = 0; i < rows.length; i += batchSize) {
            const batch = rows.slice(i, i + batchSize);
            
            sqlDump += `INSERT INTO ${table} (${columnNames.join(', ')}) VALUES\n`;
            
            const values = batch.map(row => {
              const vals = columnNames.map(col => {
                const val = row[col];
                if (val === null) return 'NULL';
                if (typeof val === 'string') {
                  // SQL injection 방지: 작은따옴표 이스케이프
                  return `'${val.replace(/'/g, "''")}'`;
                }
                if (typeof val === 'number') return val;
                if (typeof val === 'boolean') return val ? 1 : 0;
                if (Buffer.isBuffer(val)) {
                  // BLOB을 hex 문자열로 변환
                  return `X'${val.toString('hex')}'`;
                }
                // JSON 등 기타 타입
                return `'${String(val).replace(/'/g, "''")}'`;
              });
              return `  (${vals.join(', ')})`;
            });
            
            sqlDump += values.join(',\n') + ';\n\n';
          }
        }
      }
    } catch (e) {
      console.warn(`⚠️  테이블 ${table} 데이터 가져오기 실패: ${e.message}`);
    }
  }

  sqlDump += `COMMIT;
PRAGMA foreign_keys = ON;
`;

  db.close();

  // 파일 저장
  writeFileSync(OUTPUT_FILE, sqlDump, 'utf-8');
  
  const fileSize = (readFileSync(OUTPUT_FILE).length / 1024 / 1024).toFixed(2);
  console.log(`\n✅ 덤프 완료: ${OUTPUT_FILE}`);
  console.log(`📊 파일 크기: ${fileSize} MB`);
  console.log(`📊 테이블 수: ${tables.length}개`);

} catch (error) {
  console.error('❌ 오류 발생:', error.message);
  console.error(error.stack);
  process.exit(1);
}
