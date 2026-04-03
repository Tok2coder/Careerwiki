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

// 고아 blob 정보 수집
const orphanBlobs = [];
blobFiles.filter(f => !allDbBlobIds.has(f)).forEach(blobId => {
  const blobPath = path.join(LOCAL_R2_BLOBS_DIR, blobId);
  const stats = fs.statSync(blobPath);
  
  // 파일 헤더로 타입 확인
  const fd = fs.openSync(blobPath, 'r');
  const buffer = Buffer.alloc(12);
  fs.readSync(fd, buffer, 0, 12, 0);
  fs.closeSync(fd);
  
  let fileType = 'unknown';
  if (buffer[0] === 0x52 && buffer[1] === 0x49 && buffer[2] === 0x46 && buffer[3] === 0x46 &&
      buffer[8] === 0x57 && buffer[9] === 0x45 && buffer[10] === 0x42 && buffer[11] === 0x50) {
    fileType = 'webp';
  } else if (buffer[0] === 0x89 && buffer[1] === 0x50 && buffer[2] === 0x4E && buffer[3] === 0x47) {
    fileType = 'png';
  }
  
  orphanBlobs.push({ blobId, size: stats.size, type: fileType });
});

// 누락된 blob 정보 (DB에 있지만 파일이 없는 것)
const missingBlobs = db.prepare(`
  SELECT key, blob_id, size 
  FROM _mf_objects
`).all().filter(r => !blobFiles.includes(r.blob_id));

console.log('=== 크기 기반 매칭 시도 ===');
console.log('고아 blob 수:', orphanBlobs.length);
console.log('누락된 blob 수:', missingBlobs.length);

// 크기가 정확히 같은 것 찾기
const matches = [];
const unmatched = [];

missingBlobs.forEach(missing => {
  const key = decodeURIComponent(missing.key);
  // 같은 크기의 고아 blob 찾기 (webp만)
  const candidates = orphanBlobs.filter(o => o.type === 'webp' && o.size === missing.size);
  
  if (candidates.length === 1) {
    matches.push({
      key,
      originalBlobId: missing.blob_id,
      matchedBlobId: candidates[0].blobId,
      size: missing.size
    });
    // 사용된 고아 blob 제거
    const idx = orphanBlobs.findIndex(o => o.blobId === candidates[0].blobId);
    if (idx > -1) orphanBlobs.splice(idx, 1);
  } else if (candidates.length > 1) {
    unmatched.push({ key, size: missing.size, candidateCount: candidates.length });
  } else {
    unmatched.push({ key, size: missing.size, candidateCount: 0 });
  }
});

console.log('\n정확히 매칭된 이미지:', matches.length);
matches.slice(0, 10).forEach(m => {
  console.log(`  ${m.key} (${(m.size / 1024).toFixed(1)} KB)`);
});

console.log('\n매칭 안 된 이미지:', unmatched.length);
unmatched.slice(0, 10).forEach(u => {
  console.log(`  ${u.key} (${(u.size / 1024).toFixed(1)} KB) - 후보: ${u.candidateCount}개`);
});

// 매칭된 이미지 복구 스크립트 생성
if (matches.length > 0) {
  console.log('\n=== 복구 가능 ===');
  console.log(`${matches.length}개 이미지를 고아 blob에서 복구할 수 있습니다.`);
  
  // 복구 스크립트 저장
  const recoveryData = matches.map(m => ({
    key: m.key.startsWith('jobs/') ? m.key : `jobs/${m.key}`,
    blobId: m.matchedBlobId
  }));
  fs.writeFileSync('recovery-map.json', JSON.stringify(recoveryData, null, 2));
  console.log('복구 매핑 저장: recovery-map.json');
}

db.close();


