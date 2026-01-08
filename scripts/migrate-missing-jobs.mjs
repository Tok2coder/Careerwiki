#!/usr/bin/env node
/**
 * 누락된 jobs 마이그레이션 스크립트
 * merged_profile_json 등 큰 컬럼을 제외하고 기본 데이터만 먼저 INSERT
 */

import { execSync } from 'child_process';
import { readFileSync, writeFileSync } from 'fs';

const API_TOKEN = 'H3nfdRXvuqu9qr28KxzGrL5XoeezZ7_GG1SdPAmL';

// 작은 컬럼만 선택 (큰 JSON 컬럼 제외)
const SMALL_COLUMNS = [
  'id', 'careernet_id', 'goyong24_id', 'name', 'slug', 
  'primary_source', 'is_active', 'created_at',
  'image_url', 'image_alt', 'image_credits', 'name_en', 'image_prompt',
  'api_data_hash', 'api_last_fetched_at', 'api_last_updated_at',
  'user_last_updated_at', 'admin_last_updated_at', 'ai_last_updated_at'
];

function runLocal(cmd) {
  try {
    return execSync(cmd, {
      encoding: 'utf-8',
      env: { ...process.env, CLOUDFLARE_API_TOKEN: API_TOKEN },
      maxBuffer: 500 * 1024 * 1024,
      stdio: ['pipe', 'pipe', 'pipe']
    });
  } catch (e) {
    return null;
  }
}

function runRemote(sql) {
  const escaped = sql.replace(/"/g, '\\"').replace(/\$/g, '\\$');
  try {
    execSync(
      `npx wrangler d1 execute careerwiki-db --remote --command "${escaped}"`,
      {
        encoding: 'utf-8',
        env: { ...process.env, CLOUDFLARE_API_TOKEN: API_TOKEN },
        maxBuffer: 10 * 1024 * 1024,
        stdio: ['pipe', 'pipe', 'pipe']
      }
    );
    return true;
  } catch (e) {
    return false;
  }
}

function escapeSQL(val) {
  if (val === null || val === undefined) return 'NULL';
  if (typeof val === 'number') return val.toString();
  if (typeof val === 'boolean') return val ? '1' : '0';
  const str = String(val).replace(/'/g, "''");
  return `'${str}'`;
}

async function main() {
  console.log('누락된 jobs 마이그레이션 시작...\n');

  // 누락된 ID 읽기
  const missingIds = readFileSync('migration_data/missing_job_ids.txt', 'utf-8')
    .trim()
    .split('\n')
    .filter(Boolean);

  console.log(`누락된 jobs: ${missingIds.length}개\n`);

  let success = 0;
  let failed = 0;

  for (let i = 0; i < missingIds.length; i++) {
    const id = missingIds[i].trim();
    if (!id) continue;

    // 로컬에서 해당 job 데이터 가져오기
    const result = runLocal(
      `npx wrangler d1 execute careerwiki-db --local --command "SELECT ${SMALL_COLUMNS.join(', ')} FROM jobs WHERE id='${id}';" --json`
    );

    if (!result) {
      console.log(`  ❌ ${id}: 로컬 데이터 없음`);
      failed++;
      continue;
    }

    let row;
    try {
      const json = JSON.parse(result);
      row = json[0]?.results?.[0];
    } catch {
      failed++;
      continue;
    }

    if (!row) {
      failed++;
      continue;
    }

    // INSERT 문 생성
    const values = SMALL_COLUMNS.map(col => escapeSQL(row[col])).join(', ');
    const sql = `INSERT OR REPLACE INTO jobs (${SMALL_COLUMNS.join(', ')}) VALUES (${values});`;

    // Production에 실행
    if (runRemote(sql)) {
      success++;
    } else {
      failed++;
    }

    if ((i + 1) % 50 === 0) {
      console.log(`  진행: ${i + 1}/${missingIds.length} (성공: ${success}, 실패: ${failed})`);
    }
  }

  console.log(`\n완료: 성공 ${success}, 실패 ${failed}`);
}

main().catch(console.error);

