#!/usr/bin/env node
/**
 * 누락된 jobs 레코드 복구
 * - 기존 DB에서 새 DB에 없는 jobs ID를 찾아서 삽입
 */

import { readFileSync, existsSync } from 'fs';
import { join, dirname } from 'path';
import { fileURLToPath } from 'url';

const __dirname = dirname(fileURLToPath(import.meta.url));

const ACCOUNT_ID = '3587865378649966bfb0a814fce73c77';
const SOURCE_DB_ID = 'edc21e23-c2ac-4693-bb79-389b6914e173';  // careerwiki-kr
const TARGET_DB_ID = '1dbc57d6-0ce3-4a7e-8d2e-3159b0df1315';  // careerwiki-kr

function loadApiToken() {
  const devVarsPath = join(__dirname, '..', '.dev.vars');
  const content = readFileSync(devVarsPath, 'utf-8');
  const match = content.match(/CLOUDFLARE_API_TOKEN\s*=\s*["']?([^"'\n]+)/);
  return match[1].trim();
}

const API_TOKEN = loadApiToken();
const API_BASE = 'https://api.cloudflare.com/client/v4';

async function query(dbId, sql) {
  const res = await fetch(`${API_BASE}/accounts/${ACCOUNT_ID}/d1/database/${dbId}/query`, {
    method: 'POST',
    headers: {
      'Authorization': `Bearer ${API_TOKEN}`,
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({ sql }),
  });
  return res.json();
}

async function main() {
  console.log('🔍 누락된 jobs 찾는 중...\n');
  
  // 1. 기존 DB에서 모든 job ID 가져오기
  const sourceResult = await query(SOURCE_DB_ID, 'SELECT id FROM jobs ORDER BY id');
  const sourceIds = new Set(sourceResult.result?.[0]?.results?.map(r => r.id) || []);
  console.log(`   기존 DB jobs: ${sourceIds.size}개`);
  
  // 2. 새 DB에서 모든 job ID 가져오기
  const targetResult = await query(TARGET_DB_ID, 'SELECT id FROM jobs ORDER BY id');
  const targetIds = new Set(targetResult.result?.[0]?.results?.map(r => r.id) || []);
  console.log(`   새 DB jobs: ${targetIds.size}개`);
  
  // 3. 누락된 ID 찾기
  const missingIds = [...sourceIds].filter(id => !targetIds.has(id));
  console.log(`   누락된 jobs: ${missingIds.length}개\n`);
  
  if (missingIds.length === 0) {
    console.log('✅ 누락된 레코드 없음!');
    return;
  }
  
  console.log('📥 누락된 jobs 복구 중...\n');
  
  let successCount = 0;
  let errorCount = 0;
  
  // 4. 누락된 jobs를 하나씩 복구
  for (let i = 0; i < missingIds.length; i++) {
    const id = missingIds[i];
    
    try {
      // 기존 DB에서 해당 job 데이터 가져오기
      const jobResult = await query(SOURCE_DB_ID, `SELECT * FROM jobs WHERE id = ${id}`);
      const job = jobResult.result?.[0]?.results?.[0];
      
      if (!job) {
        errorCount++;
        continue;
      }
      
      // 컬럼 이름과 값 추출
      const columns = Object.keys(job);
      const values = columns.map(col => {
        const val = job[col];
        if (val === null) return 'NULL';
        if (typeof val === 'number') return val;
        // 문자열 이스케이프
        return `'${String(val).replace(/'/g, "''")}'`;
      });
      
      // INSERT 문 생성
      const insertSql = `INSERT INTO jobs (${columns.join(', ')}) VALUES (${values.join(', ')})`;
      
      // 새 DB에 삽입
      const insertResult = await query(TARGET_DB_ID, insertSql);
      
      if (insertResult.success && !insertResult.errors?.length) {
        successCount++;
      } else {
        errorCount++;
        if (errorCount <= 3) {
          console.log(`   ⚠️ ID ${id} 실패: ${insertResult.errors?.[0]?.message?.slice(0, 100)}`);
        }
      }
    } catch (err) {
      errorCount++;
    }
    
    // 진행률 표시
    if ((i + 1) % 50 === 0 || i === missingIds.length - 1) {
      const progress = Math.round((i + 1) / missingIds.length * 100);
      process.stdout.write(`   진행: ${progress}% (${successCount} 성공, ${errorCount} 실패)\r`);
    }
    
    // Rate limiting 방지
    if (i > 0 && i % 100 === 0) {
      await new Promise(r => setTimeout(r, 500));
    }
  }
  
  console.log(`\n\n📊 복구 결과:`);
  console.log(`   - 성공: ${successCount}`);
  console.log(`   - 실패: ${errorCount}`);
  console.log(`   - 최종 누락: ${missingIds.length - successCount}`);
}

main().catch(console.error);
