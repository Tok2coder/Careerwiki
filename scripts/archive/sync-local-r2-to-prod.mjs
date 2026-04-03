#!/usr/bin/env node
/**
 * 로컬 R2의 HowTo 이미지를 Production R2로 업로드
 */

import Database from 'better-sqlite3';
import { readFileSync, existsSync } from 'fs';
import { execSync } from 'child_process';
import { fileURLToPath } from 'url';
import { dirname, join } from 'path';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);
const rootDir = join(__dirname, '..');

// 로컬 R2 SQLite 경로
const R2_DB_PATH = join(rootDir, '.wrangler/state/v3/r2/careerwiki-uploads/18ff2cc45daf2fc34011c4fb8bac92efb38a07255e5c66f9012346ba52364739.sqlite');
const R2_BLOBS_DIR = join(rootDir, '.wrangler/state/v3/r2/careerwiki-uploads/blobs');

if (!existsSync(R2_DB_PATH)) {
  console.error('❌ 로컬 R2 DB를 찾을 수 없습니다.');
  process.exit(1);
}

const db = new Database(R2_DB_PATH, { readonly: true });

// HowTo 이미지 키 조회
const howtoImages = db.prepare("SELECT key, blob_id FROM _mf_objects WHERE key LIKE 'howto/%'").all();

console.log(`📁 로컬 R2에서 ${howtoImages.length}개의 HowTo 이미지 발견\n`);

let uploaded = 0;
let skipped = 0;
let failed = 0;

for (const img of howtoImages) {
  const { key, blob_id } = img;
  const blobPath = join(R2_BLOBS_DIR, blob_id);
  
  if (!existsSync(blobPath)) {
    console.log(`⏭️  ${key}: blob 없음`);
    skipped++;
    continue;
  }
  
  try {
    // wrangler r2 object put 명령으로 업로드
    execSync(
      `npx wrangler r2 object put careerwiki-uploads/${key} --file="${blobPath}" --remote`,
      { stdio: 'ignore' }
    );
    console.log(`✅ ${key}`);
    uploaded++;
  } catch (e) {
    console.log(`❌ ${key}: 업로드 실패`);
    failed++;
  }
}

db.close();

console.log('\n========================================');
console.log(`✅ 업로드: ${uploaded}`);
console.log(`⏭️  스킵: ${skipped}`);
console.log(`❌ 실패: ${failed}`);
console.log('========================================\n');
