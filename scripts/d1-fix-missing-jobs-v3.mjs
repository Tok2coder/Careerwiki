#!/usr/bin/env node
/**
 * 누락된 jobs 복구 v3
 * - 최소 필드만 INSERT (id, slug, name만)
 * - 나머지 필드는 개별 UPDATE
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

function escapeValue(val) {
  if (val === null || val === undefined) return 'NULL';
  if (typeof val === 'number') return val;
  const str = String(val).replace(/'/g, "''");
  return `'${str}'`;
}

// 문자열을 청크로 분할
function chunkString(str, maxLen = 50000) {
  const chunks = [];
  for (let i = 0; i < str.length; i += maxLen) {
    chunks.push(str.slice(i, i + maxLen));
  }
  return chunks;
}

async function main() {
  console.log('═══════════════════════════════════════════════════════════');
  console.log('   🔧 누락된 jobs 복구 v3 (최소 INSERT + 개별 UPDATE)');
  console.log('═══════════════════════════════════════════════════════════\n');
  
  // 1. 누락된 ID 찾기
  console.log('[1/4] 누락된 jobs ID 확인...');
  const sourceResult = await query(SOURCE_DB_ID, 'SELECT id FROM jobs ORDER BY id');
  const sourceIds = new Set(sourceResult.result?.[0]?.results?.map(r => r.id) || []);
  
  const targetResult = await query(TARGET_DB_ID, 'SELECT id FROM jobs ORDER BY id');
  const targetIds = new Set(targetResult.result?.[0]?.results?.map(r => r.id) || []);
  
  const missingIds = [...sourceIds].filter(id => !targetIds.has(id));
  console.log(`      기존 DB: ${sourceIds.size}개, 새 DB: ${targetIds.size}개`);
  console.log(`      누락된 jobs: ${missingIds.length}개\n`);
  
  if (missingIds.length === 0) {
    console.log('✅ 누락된 레코드 없음!');
    return;
  }
  
  // 2. 테이블 스키마 확인
  console.log('[2/4] jobs 테이블 스키마 확인...');
  const schemaResult = await query(SOURCE_DB_ID, "PRAGMA table_info(jobs)");
  const columns = schemaResult.result?.[0]?.results?.map(r => r.name) || [];
  console.log(`      컬럼 수: ${columns.length}개\n`);
  
  // 최소 필드 (실제 jobs 테이블 컬럼 기준)
  // jobs: id, careernet_id, goyong24_id, name, api_data_json, api_data_hash, 
  //       api_last_fetched_at, api_last_updated_at, user_contributed_json, 
  //       user_last_updated_at, admin_data_json, admin_last_updated_at, 
  //       created_at (NOT NULL), is_active, slug, primary_source, 
  //       merged_profile_json, ai_data_json, ai_last_updated_at, 
  //       image_url, image_alt, image_credits, name_en, image_prompt
  const minimalFields = ['id', 'slug', 'name', 'name_en', 'created_at', 'is_active'];
  
  // 3. 최소 필드로 INSERT
  console.log('[3/4] 최소 필드로 INSERT...');
  let insertSuccess = 0;
  let insertFail = 0;
  
  for (let i = 0; i < missingIds.length; i++) {
    const id = missingIds[i];
    
    try {
      // 기존 DB에서 데이터 가져오기
      const jobResult = await query(SOURCE_DB_ID, `SELECT ${minimalFields.join(',')} FROM jobs WHERE id = ${id}`);
      const job = jobResult.result?.[0]?.results?.[0];
      
      if (!job) {
        insertFail++;
        continue;
      }
      
      const values = minimalFields.map(col => escapeValue(job[col]));
      const sql = `INSERT INTO jobs (${minimalFields.join(',')}) VALUES (${values.join(',')})`;
      
      const result = await query(TARGET_DB_ID, sql);
      
      if (result.success && !result.errors?.length) {
        insertSuccess++;
      } else {
        insertFail++;
        if (insertFail <= 5) {
          console.log(`      ⚠️ ID ${id}: ${result.errors?.[0]?.message?.slice(0, 60)}`);
        }
      }
    } catch (err) {
      insertFail++;
    }
    
    if ((i + 1) % 100 === 0 || i === missingIds.length - 1) {
      process.stdout.write(`      진행: ${i + 1}/${missingIds.length} (${insertSuccess} 성공)\r`);
    }
  }
  
  console.log(`\n      ✅ INSERT 완료: ${insertSuccess}개 성공, ${insertFail}개 실패\n`);
  
  if (insertSuccess === 0) {
    console.log('❌ INSERT 전부 실패. 종료.');
    return;
  }
  
  // 4. 나머지 필드 개별 UPDATE
  console.log('[4/4] 나머지 필드 UPDATE...');
  
  // 새로 삽입된 ID 확인
  const newTargetResult = await query(TARGET_DB_ID, 'SELECT id FROM jobs ORDER BY id');
  const newTargetIds = new Set(newTargetResult.result?.[0]?.results?.map(r => r.id) || []);
  const insertedIds = missingIds.filter(id => newTargetIds.has(id));
  
  console.log(`      업데이트 대상: ${insertedIds.length}개\n`);
  
  // 업데이트할 필드 (최소 필드 제외)
  const updateFields = columns.filter(c => !minimalFields.includes(c));
  
  let totalUpdates = 0;
  let failedUpdates = 0;
  
  for (let i = 0; i < insertedIds.length; i++) {
    const id = insertedIds[i];
    
    try {
      // 전체 데이터 가져오기
      const jobResult = await query(SOURCE_DB_ID, `SELECT * FROM jobs WHERE id = ${id}`);
      const job = jobResult.result?.[0]?.results?.[0];
      
      if (!job) continue;
      
      // 각 필드를 개별 UPDATE
      for (const field of updateFields) {
        const val = job[field];
        if (val === null || val === undefined) continue;
        
        const strVal = String(val);
        
        // 큰 값은 청크로 분할하여 concat으로 업데이트
        if (strVal.length > 50000) {
          // 먼저 빈 문자열로 설정
          await query(TARGET_DB_ID, `UPDATE jobs SET ${field} = '' WHERE id = ${id}`);
          
          // 청크 단위로 concat
          const chunks = chunkString(strVal, 30000);
          for (const chunk of chunks) {
            const escaped = chunk.replace(/'/g, "''");
            const concatSql = `UPDATE jobs SET ${field} = ${field} || '${escaped}' WHERE id = ${id}`;
            try {
              await query(TARGET_DB_ID, concatSql);
            } catch {
              failedUpdates++;
            }
          }
          totalUpdates++;
        } else {
          // 일반 UPDATE
          const sql = `UPDATE jobs SET ${field} = ${escapeValue(val)} WHERE id = ${id}`;
          try {
            const result = await query(TARGET_DB_ID, sql);
            if (result.success) {
              totalUpdates++;
            } else {
              failedUpdates++;
            }
          } catch {
            failedUpdates++;
          }
        }
      }
    } catch (err) {
      // 무시
    }
    
    if ((i + 1) % 50 === 0 || i === insertedIds.length - 1) {
      process.stdout.write(`      진행: ${i + 1}/${insertedIds.length} jobs 처리 (${totalUpdates} 필드 업데이트)\r`);
    }
    
    // Rate limiting
    if (i > 0 && i % 30 === 0) {
      await new Promise(r => setTimeout(r, 500));
    }
  }
  
  console.log(`\n\n═══════════════════════════════════════════════════════════`);
  console.log('   📊 최종 결과');
  console.log('═══════════════════════════════════════════════════════════');
  console.log(`   INSERT 성공: ${insertSuccess}개`);
  console.log(`   UPDATE 처리: ${totalUpdates}개 필드`);
  console.log(`   UPDATE 실패: ${failedUpdates}개 필드\n`);
  
  // 최종 확인
  const finalResult = await query(TARGET_DB_ID, 'SELECT COUNT(*) as cnt FROM jobs');
  const finalCount = finalResult.result?.[0]?.results?.[0]?.cnt;
  console.log(`   새 DB jobs 총: ${finalCount}개 / 기존 ${sourceIds.size}개`);
  
  if (finalCount === sourceIds.size) {
    console.log('\n   🎉 100% 복구 완료!');
  } else {
    console.log(`\n   ⚠️ ${sourceIds.size - finalCount}개 아직 누락`);
  }
}

main().catch(console.error);
