#!/usr/bin/env node
/**
 * Cloudflare D1 Import API 제대로 사용
 * https://developers.cloudflare.com/api/resources/d1/subresources/database/methods/import/
 */

import { readFileSync, existsSync } from 'fs';
import { join, dirname } from 'path';
import { fileURLToPath } from 'url';

const __dirname = dirname(fileURLToPath(import.meta.url));

const ACCOUNT_ID = '3587865378649966bfb0a814fce73c77';
const TARGET_DB_ID = '1dbc57d6-0ce3-4a7e-8d2e-3159b0df1315';
const SQL_FILE = join(__dirname, '..', 'careerwiki-kr-export.sql');

function loadApiToken() {
  const devVarsPath = join(__dirname, '..', '.dev.vars');
  const content = readFileSync(devVarsPath, 'utf-8');
  const match = content.match(/CLOUDFLARE_API_TOKEN\s*=\s*["']?([^"'\n]+)/);
  return match[1].trim();
}

const API_TOKEN = loadApiToken();
const API_BASE = 'https://api.cloudflare.com/client/v4';

async function main() {
  console.log('═══════════════════════════════════════════════════════════');
  console.log('   📤 D1 Import API v2');
  console.log('═══════════════════════════════════════════════════════════\n');
  
  // SQL 파일 확인
  if (!existsSync(SQL_FILE)) {
    console.error('❌ SQL 파일이 없습니다:', SQL_FILE);
    return;
  }
  
  const sqlContent = readFileSync(SQL_FILE);
  console.log(`📁 SQL 파일: ${(sqlContent.length / 1024 / 1024).toFixed(2)} MB\n`);
  
  // Step 1: Init - upload URL 받기
  console.log('[1/4] Init - Upload URL 받기...');
  const initRes = await fetch(`${API_BASE}/accounts/${ACCOUNT_ID}/d1/database/${TARGET_DB_ID}/import`, {
    method: 'POST',
    headers: {
      'Authorization': `Bearer ${API_TOKEN}`,
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({ action: 'init' }),
  });
  
  const initJson = await initRes.json();
  console.log('   Response:', JSON.stringify(initJson, null, 2).slice(0, 500));
  
  if (!initJson.success) {
    console.log('\n⚠️ Init 응답이 success=false이지만 upload_url이 있으면 계속...');
  }
  
  const uploadUrl = initJson.result?.upload_url;
  const filename = initJson.result?.filename;
  
  if (!uploadUrl) {
    console.error('\n❌ upload_url을 받지 못했습니다.');
    console.log('   전체 응답:', JSON.stringify(initJson, null, 2));
    return;
  }
  
  console.log(`   ✅ Upload URL: ${uploadUrl.slice(0, 80)}...`);
  console.log(`   ✅ Filename: ${filename}\n`);
  
  // Step 2: SQL 파일 업로드
  console.log('[2/4] SQL 파일 업로드...');
  const uploadRes = await fetch(uploadUrl, {
    method: 'PUT',
    body: sqlContent,
    headers: {
      'Content-Type': 'application/octet-stream',
    },
  });
  
  console.log(`   Status: ${uploadRes.status} ${uploadRes.statusText}`);
  
  if (!uploadRes.ok) {
    const errorText = await uploadRes.text();
    console.error('   ❌ 업로드 실패:', errorText.slice(0, 200));
    return;
  }
  
  const etag = uploadRes.headers.get('etag')?.replace(/"/g, '');
  console.log(`   ✅ ETag: ${etag}\n`);
  
  // Step 3: Import 시작
  console.log('[3/4] Import 시작...');
  const startRes = await fetch(`${API_BASE}/accounts/${ACCOUNT_ID}/d1/database/${TARGET_DB_ID}/import`, {
    method: 'POST',
    headers: {
      'Authorization': `Bearer ${API_TOKEN}`,
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({ action: 'start', etag, filename }),
  });
  
  let startJson = await startRes.json();
  console.log('   Response:', JSON.stringify(startJson, null, 2).slice(0, 500));
  
  if (!startJson.success && startJson.errors?.length) {
    console.error('   ❌ Import 시작 실패:', startJson.errors);
    return;
  }
  
  let bookmark = startJson.result?.at_bookmark;
  let status = startJson.result?.status || 'unknown';
  console.log(`   Status: ${status}, Bookmark: ${bookmark?.slice(0, 30)}...\n`);
  
  // Step 4: Polling
  console.log('[4/4] Import 진행 중 (Polling)...');
  let pollCount = 0;
  
  while (status !== 'complete' && status !== 'error') {
    await new Promise(r => setTimeout(r, 5000));
    pollCount++;
    
    const pollRes = await fetch(`${API_BASE}/accounts/${ACCOUNT_ID}/d1/database/${TARGET_DB_ID}/import`, {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${API_TOKEN}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ action: 'poll', current_bookmark: bookmark }),
    });
    
    const pollJson = await pollRes.json();
    
    if (pollJson.result?.error) {
      console.error(`   ❌ Import 오류: ${pollJson.result.error}`);
      break;
    }
    
    status = pollJson.result?.status || status;
    bookmark = pollJson.result?.at_bookmark || bookmark;
    
    console.log(`   Poll #${pollCount}: status=${status}`);
    
    if (pollCount > 120) {  // 10분 timeout
      console.error('   ⚠️ Timeout (10분)');
      break;
    }
  }
  
  if (status === 'complete') {
    console.log('\n═══════════════════════════════════════════════════════════');
    console.log('   🎉 Import 완료!');
    console.log('═══════════════════════════════════════════════════════════');
  } else {
    console.log(`\n⚠️ Import 종료 (status: ${status})`);
  }
}

main().catch(console.error);
