#!/usr/bin/env node
/**
 * 누락된 jobs 레코드 복구 v2
 * - 큰 필드를 분리해서 삽입
 */

import { readFileSync } from 'fs';
import { join, dirname } from 'path';
import { fileURLToPath } from 'url';

const __dirname = dirname(fileURLToPath(import.meta.url));

const ACCOUNT_ID = '3587865378649966bfb0a814fce73c77';
const SOURCE_DB_ID = 'edc21e23-c2ac-4693-bb79-389b6914e173';
const TARGET_DB_ID = '1dbc57d6-0ce3-4a7e-8d2e-3159b0df1315';

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

// 큰 텍스트/JSON 필드들
const LARGE_FIELDS = [
  'related_majors', 'career_paths', 'outlook', 'description', 
  'work_environment', 'required_skills', 'certifications',
  'salary_info', 'employment_trend', 'personality_fit',
  'abilities', 'knowledge', 'work_activities', 'work_values',
  'interests', 'development_path', 'additional_info',
  'thumbnail_url', 'image_url'
];

function escapeValue(val) {
  if (val === null || val === undefined) return 'NULL';
  if (typeof val === 'number') return val;
  return `'${String(val).replace(/'/g, "''")}'`;
}

async function main() {
  console.log('🔍 누락된 jobs 찾는 중...\n');
  
  // 1. 누락된 ID 찾기
  const sourceResult = await query(SOURCE_DB_ID, 'SELECT id FROM jobs ORDER BY id');
  const sourceIds = new Set(sourceResult.result?.[0]?.results?.map(r => r.id) || []);
  
  const targetResult = await query(TARGET_DB_ID, 'SELECT id FROM jobs ORDER BY id');
  const targetIds = new Set(targetResult.result?.[0]?.results?.map(r => r.id) || []);
  
  const missingIds = [...sourceIds].filter(id => !targetIds.has(id));
  console.log(`   누락된 jobs: ${missingIds.length}개\n`);
  
  if (missingIds.length === 0) {
    console.log('✅ 누락된 레코드 없음!');
    return;
  }
  
  console.log('📥 Step 1: 기본 데이터 삽입 (큰 필드 제외)...\n');
  
  let insertSuccess = 0;
  let insertError = 0;
  
  for (let i = 0; i < missingIds.length; i++) {
    const id = missingIds[i];
    
    try {
      // 기존 DB에서 해당 job 데이터 가져오기
      const jobResult = await query(SOURCE_DB_ID, `SELECT * FROM jobs WHERE id = ${id}`);
      const job = jobResult.result?.[0]?.results?.[0];
      
      if (!job) {
        insertError++;
        continue;
      }
      
      // 작은 필드만 선택
      const smallColumns = Object.keys(job).filter(col => !LARGE_FIELDS.includes(col));
      const values = smallColumns.map(col => escapeValue(job[col]));
      
      const insertSql = `INSERT INTO jobs (${smallColumns.join(', ')}) VALUES (${values.join(', ')})`;
      
      const insertResult = await query(TARGET_DB_ID, insertSql);
      
      if (insertResult.success && !insertResult.errors?.length) {
        insertSuccess++;
      } else {
        insertError++;
        if (insertError <= 3) {
          console.log(`   ⚠️ ID ${id}: ${insertResult.errors?.[0]?.message?.slice(0, 80)}`);
        }
      }
    } catch (err) {
      insertError++;
    }
    
    if ((i + 1) % 50 === 0 || i === missingIds.length - 1) {
      const progress = Math.round((i + 1) / missingIds.length * 100);
      process.stdout.write(`   진행: ${progress}% (${insertSuccess} 성공, ${insertError} 실패)\r`);
    }
    
    if (i > 0 && i % 100 === 0) await new Promise(r => setTimeout(r, 300));
  }
  
  console.log(`\n\n   ✅ 기본 데이터 삽입: ${insertSuccess}개 성공\n`);
  
  if (insertSuccess === 0) {
    console.log('❌ 기본 데이터 삽입도 실패. 종료.');
    return;
  }
  
  // Step 2: 큰 필드를 개별 UPDATE로 추가
  console.log('📥 Step 2: 큰 필드 개별 UPDATE...\n');
  
  // 새로 삽입된 ID 확인
  const newTargetResult = await query(TARGET_DB_ID, 'SELECT id FROM jobs ORDER BY id');
  const newTargetIds = new Set(newTargetResult.result?.[0]?.results?.map(r => r.id) || []);
  const insertedIds = missingIds.filter(id => newTargetIds.has(id));
  
  console.log(`   업데이트 대상: ${insertedIds.length}개\n`);
  
  let updateSuccess = 0;
  let updateError = 0;
  
  for (let i = 0; i < insertedIds.length; i++) {
    const id = insertedIds[i];
    
    try {
      const jobResult = await query(SOURCE_DB_ID, `SELECT * FROM jobs WHERE id = ${id}`);
      const job = jobResult.result?.[0]?.results?.[0];
      
      if (!job) continue;
      
      // 각 큰 필드를 개별 UPDATE
      for (const field of LARGE_FIELDS) {
        if (job[field] === null || job[field] === undefined) continue;
        
        const updateSql = `UPDATE jobs SET ${field} = ${escapeValue(job[field])} WHERE id = ${id}`;
        
        try {
          const updateResult = await query(TARGET_DB_ID, updateSql);
          if (!updateResult.success || updateResult.errors?.length) {
            // 너무 큰 필드는 건너뛰기
          }
        } catch {
          // 개별 필드 실패는 무시
        }
      }
      
      updateSuccess++;
    } catch {
      updateError++;
    }
    
    if ((i + 1) % 50 === 0 || i === insertedIds.length - 1) {
      const progress = Math.round((i + 1) / insertedIds.length * 100);
      process.stdout.write(`   진행: ${progress}% (${updateSuccess} 처리)\r`);
    }
    
    if (i > 0 && i % 50 === 0) await new Promise(r => setTimeout(r, 500));
  }
  
  console.log(`\n\n📊 최종 결과:`);
  console.log(`   - 기본 데이터 삽입: ${insertSuccess}개`);
  console.log(`   - 필드 업데이트: ${updateSuccess}개 처리`);
  
  // 최종 확인
  const finalResult = await query(TARGET_DB_ID, 'SELECT COUNT(*) as cnt FROM jobs');
  console.log(`   - 새 DB jobs 총: ${finalResult.result?.[0]?.results?.[0]?.cnt}개`);
}

main().catch(console.error);
