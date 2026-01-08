#!/usr/bin/env node
/**
 * 로컬 R2 → Production R2 업로드 스크립트
 * 
 * 로컬 Wrangler R2 상태에서 이미지를 추출하여 Production R2로 업로드합니다.
 */

import { execSync } from 'child_process';
import { readFileSync, readdirSync, statSync } from 'fs';
import { join, relative } from 'path';
import dotenv from 'dotenv';

dotenv.config({ path: '.dev.vars' });

const API_TOKEN = process.env.CLOUDFLARE_API_TOKEN;
const LOCAL_R2_BLOBS = '.wrangler/state/v3/r2/careerwiki-uploads/blobs';
const BUCKET_NAME = 'careerwiki-uploads';

// SQLite에서 blob 경로 매핑을 읽기 위한 설정
import Database from 'better-sqlite3';

const DB_PATH = '.wrangler/state/v3/r2/careerwiki-uploads/18ff2cc45daf2fc34011c4fb8bac92efb38a07255e5c66f9012346ba52364739.sqlite';

function log(msg) {
  console.log(`[${new Date().toISOString().slice(11, 19)}] ${msg}`);
}

function runCommand(cmd, silent = false) {
  try {
    return execSync(cmd, {
      encoding: 'utf-8',
      env: { ...process.env, CLOUDFLARE_API_TOKEN: API_TOKEN },
      stdio: silent ? 'pipe' : 'inherit',
      maxBuffer: 100 * 1024 * 1024
    });
  } catch (e) {
    if (!silent) {
      console.error(`명령 실패: ${cmd}`);
      console.error(e.message);
    }
    throw e;
  }
}

async function uploadFile(localPath, remotePath) {
  try {
    // wrangler r2 object put을 사용하여 업로드
    runCommand(
      `npx wrangler r2 object put ${BUCKET_NAME}/${remotePath} --file="${localPath}" --remote`,
      true
    );
    return true;
  } catch (e) {
    console.error(`❌ 업로드 실패: ${remotePath}`);
    return false;
  }
}

async function main() {
  console.log('='.repeat(60));
  console.log('로컬 R2 → Production R2 업로드');
  console.log('='.repeat(60));
  console.log('');

  if (!API_TOKEN) {
    console.error('❌ CLOUDFLARE_API_TOKEN이 설정되지 않았습니다.');
    process.exit(1);
  }

  log('SQLite 데이터베이스에서 파일 매핑 읽기...');
  
  const db = new Database(DB_PATH, { readonly: true });
  
  // R2 객체 목록 가져오기
  const objects = db.prepare(`
    SELECT key, blob_id 
    FROM _mf_objects 
    ORDER BY key
  `).all();
  
  log(`총 ${objects.length}개 파일 발견`);
  console.log('');

  let uploaded = 0;
  let failed = 0;
  let skipped = 0;

  for (let i = 0; i < objects.length; i++) {
    const { key, blob_id } = objects[i];
    const localBlobPath = join(LOCAL_R2_BLOBS, blob_id);
    
    // 진행률 표시
    if (i % 100 === 0) {
      log(`진행: ${i}/${objects.length} (${((i/objects.length)*100).toFixed(1)}%)`);
    }

    try {
      // blob 파일이 존재하는지 확인
      statSync(localBlobPath);
      
      // Production에 업로드
      if (await uploadFile(localBlobPath, key)) {
        uploaded++;
      } else {
        failed++;
      }
    } catch (e) {
      console.error(`⚠️ blob 파일 없음: ${blob_id} (key: ${key})`);
      skipped++;
    }
  }

  db.close();

  console.log('');
  console.log('='.repeat(60));
  console.log(`완료: 업로드 ${uploaded}, 실패 ${failed}, 스킵 ${skipped}`);
  console.log('='.repeat(60));
}

main().catch(e => {
  console.error('스크립트 실행 중 오류:', e);
  process.exit(1);
});

