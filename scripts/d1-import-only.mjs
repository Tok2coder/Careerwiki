#!/usr/bin/env node
/**
 * D1 Import만 실행 (SQL 파일 이미 있음)
 */

import { readFileSync, existsSync } from 'fs';
import { join, dirname } from 'path';
import { fileURLToPath } from 'url';

const __dirname = dirname(fileURLToPath(import.meta.url));

// 설정
const ACCOUNT_ID = '3587865378649966bfb0a814fce73c77';
const TARGET_DB_ID = '1dbc57d6-0ce3-4a7e-8d2e-3159b0df1315';  // careerwiki-kr
const SQL_FILE = join(__dirname, '..', 'careerwiki-kr-export.sql');

// API 토큰 로드
function loadApiToken() {
  const devVarsPath = join(__dirname, '..', '.dev.vars');
  if (!existsSync(devVarsPath)) {
    console.error('❌ .dev.vars 파일이 없습니다.');
    process.exit(1);
  }
  const content = readFileSync(devVarsPath, 'utf-8');
  const match = content.match(/CLOUDFLARE_API_TOKEN\s*=\s*["']?([^"'\n]+)/);
  if (!match) {
    console.error('❌ CLOUDFLARE_API_TOKEN을 찾을 수 없습니다.');
    process.exit(1);
  }
  return match[1].trim();
}

const API_TOKEN = loadApiToken();
const API_BASE = 'https://api.cloudflare.com/client/v4';

async function apiCall(endpoint, method = 'GET', body = null) {
  const options = {
    method,
    headers: {
      'Authorization': `Bearer ${API_TOKEN}`,
      'Content-Type': 'application/json',
    },
  };
  if (body) options.body = JSON.stringify(body);
  
  const res = await fetch(`${API_BASE}${endpoint}`, options);
  return res.json();
}

async function main() {
  console.log('═══════════════════════════════════════════════════════════');
  console.log('   📤 D1 Import: careerwiki-kr');
  console.log('═══════════════════════════════════════════════════════════\n');
  
  if (!existsSync(SQL_FILE)) {
    console.error('❌ SQL 파일이 없습니다:', SQL_FILE);
    process.exit(1);
  }
  
  const sqlContent = readFileSync(SQL_FILE, 'utf-8');
  console.log(`📁 SQL 파일: ${(sqlContent.length / 1024 / 1024).toFixed(2)} MB`);
  
  // SQL을 개별 문장으로 분리 (CREATE TABLE, INSERT 등)
  // 세미콜론으로 분리하되, 문자열 내부의 세미콜론은 무시
  const rawStatements = sqlContent.split(/;\s*\n/);
  const statements = rawStatements
    .map(s => s.trim())
    .filter(s => s.length > 0 && !s.startsWith('--') && !s.startsWith('PRAGMA') && !s.startsWith('BEGIN') && !s.startsWith('COMMIT'));
  
  console.log(`📊 총 ${statements.length}개 SQL 문장\n`);
  
  // 테이블 생성 문장 먼저 추출
  const createStatements = statements.filter(s => s.toUpperCase().startsWith('CREATE'));
  const insertStatements = statements.filter(s => s.toUpperCase().startsWith('INSERT'));
  const otherStatements = statements.filter(s => 
    !s.toUpperCase().startsWith('CREATE') && 
    !s.toUpperCase().startsWith('INSERT')
  );
  
  console.log(`   - CREATE: ${createStatements.length}개`);
  console.log(`   - INSERT: ${insertStatements.length}개`);
  console.log(`   - 기타: ${otherStatements.length}개\n`);
  
  let successCount = 0;
  let errorCount = 0;
  let skipCount = 0;
  
  // 1. CREATE TABLE 먼저 실행
  console.log('📐 [1/3] 테이블 생성 중...');
  for (let i = 0; i < createStatements.length; i++) {
    const stmt = createStatements[i];
    try {
      const result = await apiCall(
        `/accounts/${ACCOUNT_ID}/d1/database/${TARGET_DB_ID}/query`,
        'POST',
        { sql: stmt + ';' }
      );
      
      if (result.success) {
        successCount++;
      } else if (result.errors?.[0]?.message?.includes('already exists')) {
        skipCount++;
      } else {
        console.log(`   ⚠️ 오류: ${result.errors?.[0]?.message?.slice(0, 100)}`);
        errorCount++;
      }
    } catch (err) {
      errorCount++;
    }
    
    if ((i + 1) % 10 === 0 || i === createStatements.length - 1) {
      process.stdout.write(`   진행: ${i + 1}/${createStatements.length}\r`);
    }
  }
  console.log(`\n   ✅ 테이블: ${successCount} 생성, ${skipCount} 이미 존재, ${errorCount} 오류\n`);
  
  // 2. INSERT 문 배치로 실행
  console.log('📦 [2/3] 데이터 삽입 중...');
  const insertBatchSize = 50;  // 한 번에 50개씩
  let insertSuccess = 0;
  let insertError = 0;
  
  for (let i = 0; i < insertStatements.length; i += insertBatchSize) {
    const batch = insertStatements.slice(i, i + insertBatchSize);
    
    // 개별 실행
    for (const stmt of batch) {
      try {
        const result = await apiCall(
          `/accounts/${ACCOUNT_ID}/d1/database/${TARGET_DB_ID}/query`,
          'POST',
          { sql: stmt + ';' }
        );
        
        if (result.success) {
          insertSuccess++;
        } else {
          insertError++;
          // 첫 번째 에러만 출력
          if (insertError === 1) {
            console.log(`\n   ⚠️ 첫 오류: ${result.errors?.[0]?.message?.slice(0, 150)}`);
          }
        }
      } catch (err) {
        insertError++;
      }
    }
    
    const progress = Math.round((i + batch.length) / insertStatements.length * 100);
    process.stdout.write(`   진행: ${progress}% (${insertSuccess} 성공, ${insertError} 실패)          \r`);
    
    // Rate limiting 방지
    if (i > 0 && i % 500 === 0) {
      await new Promise(r => setTimeout(r, 1000));
    }
  }
  console.log(`\n   ✅ 데이터: ${insertSuccess} 성공, ${insertError} 실패\n`);
  
  // 3. 기타 문장 실행
  if (otherStatements.length > 0) {
    console.log('🔧 [3/3] 기타 SQL 실행 중...');
    let otherSuccess = 0;
    let otherError = 0;
    
    for (const stmt of otherStatements) {
      try {
        const result = await apiCall(
          `/accounts/${ACCOUNT_ID}/d1/database/${TARGET_DB_ID}/query`,
          'POST',
          { sql: stmt + ';' }
        );
        if (result.success) otherSuccess++;
        else otherError++;
      } catch {
        otherError++;
      }
    }
    console.log(`   ✅ 기타: ${otherSuccess} 성공, ${otherError} 실패\n`);
  }
  
  console.log('═══════════════════════════════════════════════════════════');
  console.log('   🎉 Import 완료!');
  console.log('═══════════════════════════════════════════════════════════');
  console.log(`\n📊 결과 요약:`);
  console.log(`   - 테이블 생성: ${successCount + skipCount}`);
  console.log(`   - 데이터 삽입: ${insertSuccess}`);
  console.log(`   - 총 오류: ${errorCount + insertError}`);
  console.log('\n🔍 검증:');
  console.log('   npx wrangler d1 execute careerwiki-kr --remote --command "SELECT COUNT(*) FROM jobs;"');
}

main().catch(err => {
  console.error('\n❌ 오류:', err);
  process.exit(1);
});
