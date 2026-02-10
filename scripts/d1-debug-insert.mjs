#!/usr/bin/env node
/**
 * INSERT 실패 원인 디버깅
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

async function query(dbId, sql) {
  const res = await fetch(`https://api.cloudflare.com/client/v4/accounts/${ACCOUNT_ID}/d1/database/${dbId}/query`, {
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
  console.log('🔍 INSERT 실패 원인 디버깅\n');
  
  // 1. 누락된 ID 하나 찾기
  const srcIds = await query(SOURCE_DB_ID, 'SELECT id FROM jobs ORDER BY id');
  const tgtIds = await query(TARGET_DB_ID, 'SELECT id FROM jobs ORDER BY id');
  
  const srcSet = new Set(srcIds.result?.[0]?.results?.map(r => r.id) || []);
  const tgtSet = new Set(tgtIds.result?.[0]?.results?.map(r => r.id) || []);
  
  const missing = [...srcSet].filter(id => !tgtSet.has(id));
  console.log(`누락된 ID 수: ${missing.length}`);
  console.log(`첫 번째 누락 ID: ${missing[0]}\n`);
  
  if (missing.length === 0) {
    console.log('누락된 ID 없음!');
    return;
  }
  
  const testId = missing[0];
  
  // 2. 원본 데이터 확인
  const jobResult = await query(SOURCE_DB_ID, `SELECT id, slug, name, name_en FROM jobs WHERE id = ${testId}`);
  const job = jobResult.result?.[0]?.results?.[0];
  
  console.log('원본 데이터:');
  console.log('  id:', job?.id);
  console.log('  slug:', job?.slug);
  console.log('  name:', job?.name?.slice(0, 50));
  console.log('  name_en:', job?.name_en?.slice(0, 50));
  console.log();
  
  // 3. 전체 데이터로 INSERT 시도
  const fullJob = await query(SOURCE_DB_ID, `SELECT * FROM jobs WHERE id = ${testId}`);
  const fullData = fullJob.result?.[0]?.results?.[0];
  
  console.log('전체 컬럼:', Object.keys(fullData || {}).join(', '));
  console.log();
  
  if (fullData) {
    // 모든 필수 필드 포함
    const fields = ['id', 'slug', 'name', 'name_en', 'created_at', 'updated_at', 'source'];
    const values = fields.map(f => {
      const v = fullData[f];
      if (v === null || v === undefined) return 'NULL';
      if (typeof v === 'number') return v;
      return `'${String(v).replace(/'/g, "''")}'`;
    });
    
    const sql = `INSERT INTO jobs (${fields.join(', ')}) VALUES (${values.join(', ')})`;
    
    console.log('INSERT SQL 길이:', sql.length);
    console.log('SQL:', sql.slice(0, 300), '...\n');
    
    const result = await query(TARGET_DB_ID, sql);
    console.log('INSERT 결과:');
    console.log('  success:', result.success);
    console.log('  errors:', JSON.stringify(result.errors));
    
    if (result.success) {
      // 삽입 성공! 검증
      const check = await query(TARGET_DB_ID, `SELECT id, name FROM jobs WHERE id = ${testId}`);
      console.log('  검증:', JSON.stringify(check.result?.[0]?.results?.[0]));
    }
  }
}

main().catch(console.error);
