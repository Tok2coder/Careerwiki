#!/usr/bin/env node
/**
 * D1 데이터베이스 마이그레이션: careerwiki-kr -> careerwiki-kr
 * Cloudflare API polling 방식 사용
 */

import { readFileSync, writeFileSync, existsSync } from 'fs';
import { join, dirname } from 'path';
import { fileURLToPath } from 'url';

const __dirname = dirname(fileURLToPath(import.meta.url));

// 설정
const ACCOUNT_ID = '3587865378649966bfb0a814fce73c77';
const SOURCE_DB_ID = 'edc21e23-c2ac-4693-bb79-389b6914e173';  // careerwiki-kr
const TARGET_DB_ID = '1dbc57d6-0ce3-4a7e-8d2e-3159b0df1315';  // careerwiki-kr

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

// API 호출
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

// Export polling
async function exportDatabase() {
  console.log('\n[2/6] 📤 Export 시작 (예상: 5-15분)...');
  
  // 1. Export 시작
  let result = await apiCall(
    `/accounts/${ACCOUNT_ID}/d1/database/${SOURCE_DB_ID}/export`,
    'POST',
    { output_format: 'polling' }
  );
  
  if (!result.success) {
    console.error('❌ Export 시작 실패:', JSON.stringify(result.errors, null, 2));
    return null;
  }
  
  let bookmark = result.result?.at_bookmark;
  let status = result.result?.status;
  console.log(`      Status: ${status}, Bookmark: ${bookmark?.slice(0, 20)}...`);
  
  // 2. Polling (5초마다)
  let pollCount = 0;
  while (status !== 'complete') {
    await new Promise(r => setTimeout(r, 5000)); // 5초 대기
    pollCount++;
    
    result = await apiCall(
      `/accounts/${ACCOUNT_ID}/d1/database/${SOURCE_DB_ID}/export`,
      'POST',
      { output_format: 'polling', current_bookmark: bookmark }
    );
    
    if (!result.success) {
      console.error('❌ Export polling 실패:', JSON.stringify(result.errors, null, 2));
      return null;
    }
    
    if (result.result?.error) {
      console.error('❌ Export 오류:', result.result.error);
      return null;
    }
    
    status = result.result?.status;
    bookmark = result.result?.at_bookmark || bookmark;
    console.log(`      ⏳ Polling #${pollCount}... Status: ${status}`);
    
    // 60회 (5분) 넘으면 경고
    if (pollCount > 60 && pollCount % 12 === 0) {
      console.log(`      ⚠️ ${Math.floor(pollCount * 5 / 60)}분 경과...`);
    }
  }
  
  const signedUrl = result.result?.result?.signed_url;
  if (!signedUrl) {
    console.error('❌ signed_url을 받지 못했습니다:', JSON.stringify(result, null, 2));
    return null;
  }
  
  console.log('      ✅ Export 완료! signed_url 획득');
  return signedUrl;
}

// SQL 다운로드
async function downloadSql(signedUrl) {
  console.log('\n[3/6] 📥 SQL 다운로드 중...');
  
  const res = await fetch(signedUrl);
  if (!res.ok) {
    console.error('❌ SQL 다운로드 실패:', res.status, res.statusText);
    return null;
  }
  
  const sql = await res.text();
  const outputPath = join(__dirname, '..', 'careerwiki-kr-export.sql');
  writeFileSync(outputPath, sql, 'utf-8');
  
  const sizeMB = (sql.length / 1024 / 1024).toFixed(2);
  console.log(`      ✅ 저장 완료: careerwiki-kr-export.sql (${sizeMB} MB)`);
  return outputPath;
}

// Import 실행 (Cloudflare D1 Import API v2)
async function importDatabase(sqlPath) {
  console.log('\n[4/6] 📤 Import 시작 (예상: 5-15분)...');
  
  // SQL 파일 읽기
  const sqlContent = readFileSync(sqlPath, 'utf-8');
  console.log(`      SQL 파일 크기: ${(sqlContent.length / 1024 / 1024).toFixed(2)} MB`);
  
  // 1. Import 초기화 - SQL 직접 전송
  // Cloudflare D1 Import API는 SQL을 직접 받을 수 있음
  console.log('      ⏳ Import API 초기화...');
  
  // 먼저 init으로 upload URL 받기
  const initRes = await fetch(`${API_BASE}/accounts/${ACCOUNT_ID}/d1/database/${TARGET_DB_ID}/import`, {
    method: 'POST',
    headers: {
      'Authorization': `Bearer ${API_TOKEN}`,
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({ action: 'init' }),
  });
  
  const initResult = await initRes.json();
  console.log('      Init response:', JSON.stringify(initResult, null, 2).slice(0, 500));
  
  if (!initResult.success || !initResult.result?.upload_url) {
    // init이 실패하면 다른 방식 시도 (직접 SQL 실행)
    console.log('      ⚠️ Import API init 실패, 직접 SQL 실행 방식으로 전환...');
    return await importViaBatches(sqlPath);
  }
  
  const uploadUrl = initResult.result.upload_url;
  const filename = initResult.result.filename;
  console.log(`      Upload URL 획득, filename: ${filename}`);
  
  // 2. SQL 파일 업로드
  console.log('      ⏳ SQL 업로드 중...');
  const uploadRes = await fetch(uploadUrl, {
    method: 'PUT',
    body: sqlContent,
    headers: { 'Content-Type': 'application/octet-stream' },
  });
  
  if (!uploadRes.ok) {
    console.error('❌ SQL 업로드 실패:', uploadRes.status, uploadRes.statusText);
    return await importViaBatches(sqlPath);
  }
  
  const etag = uploadRes.headers.get('etag')?.replace(/"/g, '');
  console.log(`      ✅ 업로드 완료, ETag: ${etag}`);
  
  // 3. Import 시작
  console.log('      ⏳ Import 실행 중...');
  let result = await apiCall(
    `/accounts/${ACCOUNT_ID}/d1/database/${TARGET_DB_ID}/import`,
    'POST',
    { action: 'start', etag, filename }
  );
  
  if (!result.success) {
    console.error('❌ Import 시작 실패:', JSON.stringify(result.errors, null, 2));
    return await importViaBatches(sqlPath);
  }
  
  let bookmark = result.result?.at_bookmark;
  let status = result.result?.status;
  
  // 4. Import polling
  let pollCount = 0;
  while (status !== 'complete') {
    await new Promise(r => setTimeout(r, 5000));
    pollCount++;
    
    result = await apiCall(
      `/accounts/${ACCOUNT_ID}/d1/database/${TARGET_DB_ID}/import`,
      'POST',
      { action: 'poll', current_bookmark: bookmark }
    );
    
    if (result.result?.error) {
      console.error('❌ Import 실패:', result.result.error);
      return false;
    }
    
    status = result.result?.status;
    bookmark = result.result?.at_bookmark || bookmark;
    console.log(`      ⏳ Import polling #${pollCount}... Status: ${status}`);
  }
  
  const meta = result.result?.result?.meta;
  console.log('      ✅ Import 완료!');
  console.log(`         - Rows written: ${meta?.rows_written || 'N/A'}`);
  console.log(`         - Duration: ${meta?.duration || 'N/A'}ms`);
  console.log(`         - Size after: ${meta?.size_after ? (meta.size_after / 1024 / 1024).toFixed(2) + ' MB' : 'N/A'}`);
  
  return true;
}

// 배치 방식으로 SQL 실행 (대체 방법)
async function importViaBatches(sqlPath) {
  console.log('\n      🔄 배치 방식으로 Import 진행...');
  
  const sqlContent = readFileSync(sqlPath, 'utf-8');
  
  // SQL을 개별 문장으로 분리
  const statements = sqlContent
    .split(';')
    .map(s => s.trim())
    .filter(s => s.length > 0 && !s.startsWith('--'));
  
  console.log(`      총 ${statements.length}개 SQL 문장`);
  
  const batchSize = 100;  // 한 번에 100개씩
  let successCount = 0;
  let errorCount = 0;
  
  for (let i = 0; i < statements.length; i += batchSize) {
    const batch = statements.slice(i, i + batchSize);
    const batchSql = batch.join(';\n') + ';';
    
    try {
      const result = await apiCall(
        `/accounts/${ACCOUNT_ID}/d1/database/${TARGET_DB_ID}/query`,
        'POST',
        { sql: batchSql }
      );
      
      if (result.success) {
        successCount += batch.length;
      } else {
        // 개별 실행
        for (const stmt of batch) {
          try {
            const singleResult = await apiCall(
              `/accounts/${ACCOUNT_ID}/d1/database/${TARGET_DB_ID}/query`,
              'POST',
              { sql: stmt + ';' }
            );
            if (singleResult.success) successCount++;
            else errorCount++;
          } catch {
            errorCount++;
          }
        }
      }
    } catch (err) {
      errorCount += batch.length;
    }
    
    const progress = Math.round((i + batch.length) / statements.length * 100);
    if (progress % 10 === 0 || i + batch.length >= statements.length) {
      console.log(`      진행: ${progress}% (${successCount} 성공, ${errorCount} 실패)`);
    }
  }
  
  console.log(`      ✅ 배치 Import 완료: ${successCount} 성공, ${errorCount} 실패`);
  return errorCount < statements.length * 0.1;  // 90% 이상 성공이면 OK
}

// 메인
async function main() {
  console.log('═══════════════════════════════════════════════════════════');
  console.log('   📋 D1 마이그레이션: careerwiki-kr → careerwiki-kr');
  console.log('═══════════════════════════════════════════════════════════');
  console.log(`\n[1/6] 🔧 설정 확인`);
  console.log(`      Source: careerwiki-kr (${SOURCE_DB_ID})`);
  console.log(`      Target: careerwiki-kr (${TARGET_DB_ID})`);
  console.log('      ✅ API Token 로드 완료');
  
  // Export
  const signedUrl = await exportDatabase();
  if (!signedUrl) {
    console.error('\n❌ Export 실패로 마이그레이션 중단');
    process.exit(1);
  }
  
  // Download
  const sqlPath = await downloadSql(signedUrl);
  if (!sqlPath) {
    console.error('\n❌ SQL 다운로드 실패로 마이그레이션 중단');
    process.exit(1);
  }
  
  // Import
  const success = await importDatabase(sqlPath);
  if (!success) {
    console.error('\n❌ Import 실패로 마이그레이션 중단');
    process.exit(1);
  }
  
  console.log('\n═══════════════════════════════════════════════════════════');
  console.log('   🎉 마이그레이션 완료!');
  console.log('═══════════════════════════════════════════════════════════');
  console.log('\n다음 단계:');
  console.log('  1. npx wrangler d1 execute careerwiki-kr --remote --command "SELECT COUNT(*) FROM jobs;"');
  console.log('  2. wrangler.jsonc에서 database_name/database_id 변경');
}

main().catch(err => {
  console.error('\n❌ 예상치 못한 오류:', err);
  process.exit(1);
});
