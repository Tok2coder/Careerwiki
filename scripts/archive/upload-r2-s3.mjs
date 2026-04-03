#!/usr/bin/env node
/**
 * 로컬 R2 → Production R2 업로드 (S3 API 사용)
 * 
 * Cloudflare R2의 S3-compatible API를 직접 사용하여 빠르게 업로드합니다.
 */

import { S3Client, PutObjectCommand } from '@aws-sdk/client-s3';
import { readFileSync, existsSync } from 'fs';
import { join } from 'path';
import dotenv from 'dotenv';
import Database from 'better-sqlite3';

dotenv.config({ path: '.dev.vars' });

// Cloudflare R2 설정
const ACCOUNT_ID = '3587865378649966bfb0a814fce73c77';
const BUCKET_NAME = 'careerwiki-uploads';
const LOCAL_R2_BLOBS = '.wrangler/state/v3/r2/careerwiki-uploads/blobs';
const DB_PATH = '.wrangler/state/v3/r2/careerwiki-uploads/18ff2cc45daf2fc34011c4fb8bac92efb38a07255e5c66f9012346ba52364739.sqlite';

// R2 S3 API endpoint
const R2_ENDPOINT = `https://${ACCOUNT_ID}.r2.cloudflarestorage.com`;

// S3 Client 설정
const s3Client = new S3Client({
  region: 'auto',
  endpoint: R2_ENDPOINT,
  credentials: {
    accessKeyId: process.env.R2_ACCESS_KEY_ID || '',
    secretAccessKey: process.env.R2_SECRET_ACCESS_KEY || ''
  }
});

const BATCH_SIZE = 50; // 동시에 업로드할 파일 수

function log(msg) {
  console.log(`[${new Date().toISOString().slice(11, 19)}] ${msg}`);
}

async function uploadFile(localPath, key) {
  try {
    const fileContent = readFileSync(localPath);
    
    // Content-Type 추론
    let contentType = 'application/octet-stream';
    if (key.endsWith('.webp')) contentType = 'image/webp';
    else if (key.endsWith('.png')) contentType = 'image/png';
    else if (key.endsWith('.jpg') || key.endsWith('.jpeg')) contentType = 'image/jpeg';
    else if (key.endsWith('.svg')) contentType = 'image/svg+xml';
    
    const command = new PutObjectCommand({
      Bucket: BUCKET_NAME,
      Key: key,
      Body: fileContent,
      ContentType: contentType,
      CacheControl: 'public, max-age=31536000'
    });
    
    await s3Client.send(command);
    return true;
  } catch (error) {
    console.error(`❌ 업로드 실패: ${key} - ${error.message}`);
    return false;
  }
}

async function uploadBatch(batch) {
  const promises = batch.map(({ localPath, key }) => uploadFile(localPath, key));
  return await Promise.all(promises);
}

async function main() {
  console.log('='.repeat(60));
  console.log('로컬 R2 → Production R2 업로드 (S3 API)');
  console.log(`병렬 처리: ${BATCH_SIZE}개씩`);
  console.log('='.repeat(60));
  console.log('');

  if (!process.env.R2_ACCESS_KEY_ID || !process.env.R2_SECRET_ACCESS_KEY) {
    console.error('❌ R2 API 자격증명이 없습니다.');
    console.error('');
    console.error('Cloudflare Dashboard에서 R2 API 토큰 생성:');
    console.error('1. https://dash.cloudflare.com 접속');
    console.error('2. R2 > 버킷 > careerwiki-uploads');
    console.error('3. "Manage R2 API Tokens" 클릭');
    console.error('4. "Create API Token" (Admin Read & Write 권한)');
    console.error('5. .dev.vars에 추가:');
    console.error('   R2_ACCESS_KEY_ID=your_access_key_id');
    console.error('   R2_SECRET_ACCESS_KEY=your_secret_access_key');
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
      uploadQueue.push({ localPath: localBlobPath, key });
    } else {
      skipped++;
    }
  }

  log(`업로드 대상: ${uploadQueue.length}개, 스킵: ${skipped}개`);
  console.log('');

  let uploaded = 0;
  let failed = 0;
  const startTime = Date.now();

  // 배치 단위로 업로드
  for (let i = 0; i < uploadQueue.length; i += BATCH_SIZE) {
    const batch = uploadQueue.slice(i, i + BATCH_SIZE);
    const progress = ((i / uploadQueue.length) * 100).toFixed(1);
    const elapsed = Math.floor((Date.now() - startTime) / 1000);
    const rate = i / elapsed || 0;
    const remaining = Math.floor((uploadQueue.length - i) / rate);
    
    log(`진행: ${i}/${uploadQueue.length} (${progress}%) | 속도: ${rate.toFixed(1)}개/초 | 남은시간: ${remaining}초`);
    
    const results = await uploadBatch(batch);
    
    results.forEach(success => {
      if (success) uploaded++;
      else failed++;
    });
  }

  const totalTime = Math.floor((Date.now() - startTime) / 1000);

  console.log('');
  console.log('='.repeat(60));
  console.log(`완료: 업로드 ${uploaded}, 실패 ${failed}, 스킵 ${skipped}`);
  console.log(`총 소요시간: ${Math.floor(totalTime / 60)}분 ${totalTime % 60}초`);
  console.log('='.repeat(60));
}

main().catch(e => {
  console.error('스크립트 실행 중 오류:', e);
  process.exit(1);
});

