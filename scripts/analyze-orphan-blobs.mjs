import Database from 'better-sqlite3';
import fs from 'fs';
import path from 'path';

const LOCAL_R2_DB_PATH = '.wrangler/state/v3/r2/careerwiki-uploads/18ff2cc45daf2fc34011c4fb8bac92efb38a07255e5c66f9012346ba52364739.sqlite';
const LOCAL_R2_BLOBS_DIR = '.wrangler/state/v3/r2/careerwiki-uploads/blobs';

const db = new Database(LOCAL_R2_DB_PATH, { readonly: true });

// DB의 모든 blob_id
const allDbBlobIds = new Set(db.prepare('SELECT blob_id FROM _mf_objects').all().map(r => r.blob_id));

// Blob 디렉토리의 모든 파일
const blobFiles = fs.readdirSync(LOCAL_R2_BLOBS_DIR);

// 고아 blob (DB에 없는 파일)
const orphanBlobs = blobFiles.filter(f => !allDbBlobIds.has(f));

console.log('=== 고아 Blob 분석 ===');
console.log('총 고아 blob:', orphanBlobs.length);

// 파일 타입별 분류
const fileTypes = {};
let webpCount = 0;

orphanBlobs.forEach(blobId => {
  const blobPath = path.join(LOCAL_R2_BLOBS_DIR, blobId);
  const stats = fs.statSync(blobPath);
  
  // 파일 헤더 읽기 (처음 12바이트)
  const fd = fs.openSync(blobPath, 'r');
  const buffer = Buffer.alloc(12);
  fs.readSync(fd, buffer, 0, 12, 0);
  fs.closeSync(fd);
  
  // 파일 타입 확인
  let fileType = 'unknown';
  if (buffer[0] === 0x52 && buffer[1] === 0x49 && buffer[2] === 0x46 && buffer[3] === 0x46 &&
      buffer[8] === 0x57 && buffer[9] === 0x45 && buffer[10] === 0x42 && buffer[11] === 0x50) {
    fileType = 'webp';
    webpCount++;
  } else if (buffer[0] === 0x89 && buffer[1] === 0x50 && buffer[2] === 0x4E && buffer[3] === 0x47) {
    fileType = 'png';
  } else if (buffer[0] === 0xFF && buffer[1] === 0xD8 && buffer[2] === 0xFF) {
    fileType = 'jpeg';
  }
  
  if (!fileTypes[fileType]) {
    fileTypes[fileType] = [];
  }
  fileTypes[fileType].push({ blobId, size: stats.size });
});

console.log('\n파일 타입별 분류:');
for (const [type, files] of Object.entries(fileTypes)) {
  console.log(`  ${type}: ${files.length}개`);
}

// webp 파일 크기 분포 확인 (직업 이미지와 비슷한 크기인지)
console.log('\n=== WebP 고아 blob 상세 ===');
if (fileTypes.webp) {
  const webpBlobs = fileTypes.webp.sort((a, b) => b.size - a.size);
  console.log('총:', webpBlobs.length);
  console.log('크기 범위:', (webpBlobs[webpBlobs.length - 1].size / 1024).toFixed(1), 'KB ~', (webpBlobs[0].size / 1024).toFixed(1), 'KB');
  
  // 직업 이미지 크기 (보통 200KB ~ 800KB)
  const jobSizeBlobs = webpBlobs.filter(b => b.size >= 100000 && b.size <= 900000);
  console.log('직업 이미지 크기 범위 (100KB~900KB):', jobSizeBlobs.length);
  
  // 샘플 출력
  console.log('\n샘플 (처음 10개):');
  webpBlobs.slice(0, 10).forEach(b => {
    console.log(`  ${b.blobId.substring(0, 30)}... (${(b.size / 1024).toFixed(1)} KB)`);
  });
}

// 누락된 blob의 예상 크기 확인
console.log('\n=== 누락된 Blob 정보 ===');
const missingBlobs = db.prepare(`
  SELECT key, blob_id, size 
  FROM _mf_objects 
  WHERE blob_id NOT IN (${blobFiles.map(() => '?').join(',')})
  LIMIT 10
`).all(...blobFiles);

console.log('누락된 blob 샘플:');
missingBlobs.forEach(m => {
  console.log(`  ${decodeURIComponent(m.key)} - ${(m.size / 1024).toFixed(1)} KB`);
});

db.close();


