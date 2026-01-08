#!/usr/bin/env node
/**
 * 로컬 R2 → Production R2 배치 업로드 (병렬 처리)
 * 
 * wrangler r2 object put이 느리므로, 병렬로 여러 파일을 동시에 업로드합니다.
 */

import { execSync, spawn } from 'child_process';
import { readFileSync, readdirSync, statSync, existsSync } from 'fs';
import { join } from 'path';
import dotenv from 'dotenv';
import Database from 'better-sqlite3';

dotenv.config({ path: '.dev.vars' });

const API_TOKEN = process.env.CLOUDFLARE_API_TOKEN;
const LOCAL_R2_BLOBS = '.wrangler/state/v3/r2/careerwiki-uploads/blobs';
const BUCKET_NAME = 'careerwiki-uploads';
const DB_PATH = '.wrangler/state/v3/r2/careerwiki-uploads/18ff2cc45daf2fc34011c4fb8bac92efb38a07255e5c66f9012346ba52364739.sqlite';

const BATCH_SIZE = 10; // 동시에 업로드할 파일 수

function log(msg) {
  console.log(`[${new Date().toISOString().slice(11, 19)}] ${msg}`);
}

function uploadFilePromise(localPath, remotePath) {
  return new Promise((resolve, reject) => {
    const isWindows = process.platform === 'win32';
    const command = isWindows ? 'npx.cmd' : 'npx';
    
    const proc = spawn(command, [
      'wrangler', 'r2', 'object', 'put',
      `${BUCKET_NAME}/${remotePath}`,
      `--file=${localPath}`,
      '--remote'
    ], {
      env: { ...process.env, CLOUDFLARE_API_TOKEN: API_TOKEN },
      stdio: 'pipe',
      shell: isWindows
    });

    let stderr = '';
    proc.stderr.on('data', (data) => {
      stderr += data.toString();
    });

    proc.on('close', (code) => {
      if (code === 0) {
        resolve(true);
      } else {
        console.error(`❌ 업로드 실패: ${remotePath}`);
        if (stderr) console.error(`   ${stderr.trim()}`);
        resolve(false);
      }
    });

    proc.on('error', (err) => {
      console.error(`❌ 프로세스 오류: ${remotePath} - ${err.message}`);
      resolve(false);
    });
  });
}

async function uploadBatch(batch) {
  const promises = batch.map(({ localPath, remotePath }) => 
    uploadFilePromise(localPath, remotePath)
  );
  return await Promise.all(promises);
}

async function main() {
  console.log('='.repeat(60));
  console.log('로컬 R2 → Production R2 배치 업로드');
  console.log(`병렬 처리: ${BATCH_SIZE}개씩`);
  console.log('='.repeat(60));
  console.log('');

  if (!API_TOKEN) {
    console.error('❌ CLOUDFLARE_API_TOKEN이 설정되지 않았습니다.');
    process.exit(1);
  }

  log('SQLite 데이터베이스에서 파일 매핑 읽기...');
  
  const db = new Database(DB_PATH, { readonly: true });
  
  const objects = db.prepare(`
    SELECT key, blob_id 
    FROM _mf_objects 
    ORDER BY key
  `).all();
  
  db.close();
  
  log(`총 ${objects.length}개 파일 발견`);
  console.log('');

  // 업로드할 파일 목록 준비
  const uploadQueue = [];
  let skipped = 0;

  for (const { key, blob_id } of objects) {
    const localBlobPath = join(LOCAL_R2_BLOBS, blob_id);
    
    if (existsSync(localBlobPath)) {
      uploadQueue.push({ localPath: localBlobPath, remotePath: key });
    } else {
      skipped++;
    }
  }

  log(`업로드 대상: ${uploadQueue.length}개, 스킵: ${skipped}개`);
  console.log('');

  let uploaded = 0;
  let failed = 0;

  // 배치 단위로 업로드
  for (let i = 0; i < uploadQueue.length; i += BATCH_SIZE) {
    const batch = uploadQueue.slice(i, i + BATCH_SIZE);
    const progress = ((i / uploadQueue.length) * 100).toFixed(1);
    
    log(`진행: ${i}/${uploadQueue.length} (${progress}%) - 배치 ${Math.floor(i/BATCH_SIZE) + 1} 업로드 중...`);
    
    const results = await uploadBatch(batch);
    
    results.forEach(success => {
      if (success) uploaded++;
      else failed++;
    });
  }

  console.log('');
  console.log('='.repeat(60));
  console.log(`완료: 업로드 ${uploaded}, 실패 ${failed}, 스킵 ${skipped}`);
  console.log('='.repeat(60));
}

main().catch(e => {
  console.error('스크립트 실행 중 오류:', e);
  process.exit(1);
});

