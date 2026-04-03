import Database from 'better-sqlite3';
import fs from 'fs';
import path from 'path';

// 모든 R2 SQLite 파일 위치
const R2_LOCATIONS = [
  {
    name: '현재 로컬 careerwiki-uploads',
    db: '.wrangler/state/v3/r2/careerwiki-uploads/18ff2cc45daf2fc34011c4fb8bac92efb38a07255e5c66f9012346ba52364739.sqlite',
    blobs: '.wrangler/state/v3/r2/careerwiki-uploads/blobs'
  },
  {
    name: '현재 로컬 miniflare',
    db: '.wrangler/state/v3/r2/miniflare-R2BucketObject/18ff2cc45daf2fc34011c4fb8bac92efb38a07255e5c66f9012346ba52364739.sqlite',
    blobs: '.wrangler/state/v3/r2/miniflare-R2BucketObject/blobs'
  },
  {
    name: '백업 (2025-12-22)',
    db: 'backup/backup_20251222_151839/.wrangler/state/v3/r2/careerwiki-uploads/18ff2cc45daf2fc34011c4fb8bac92efb38a07255e5c66f9012346ba52364739.sqlite',
    blobs: 'backup/backup_20251222_151839/.wrangler/state/v3/r2/careerwiki-uploads/blobs'
  },
  {
    name: '백업 miniflare',
    db: 'backup/backup_20251222_151839/.wrangler/state/v3/r2/miniflare-R2BucketObject/18ff2cc45daf2fc34011c4fb8bac92efb38a07255e5c66f9012346ba52364739.sqlite',
    blobs: 'backup/backup_20251222_151839/.wrangler/state/v3/r2/miniflare-R2BucketObject/blobs'
  }
];

const searchTerm = '가상현실전문가';
const encodedSearchTerm = '%EA%B0%80%EC%83%81%ED%98%84%EC%8B%A4%EC%A0%84%EB%AC%B8%EA%B0%80';

console.log('=== 모든 R2 저장소에서 가상현실전문가 이미지 검색 ===\n');

for (const loc of R2_LOCATIONS) {
  console.log(`📂 ${loc.name}`);
  
  if (!fs.existsSync(loc.db)) {
    console.log('   ❌ DB 파일 없음\n');
    continue;
  }
  
  try {
    const db = new Database(loc.db, { readonly: true });
    
    // 가상현실전문가 관련 검색
    const results = db.prepare(`
      SELECT key, blob_id, size, http_metadata 
      FROM _mf_objects 
      WHERE key LIKE ? OR key LIKE ?
    `).all(`%${searchTerm}%`, `%${encodedSearchTerm}%`);
    
    db.close();
    
    if (results.length === 0) {
      console.log('   결과 없음\n');
      continue;
    }
    
    results.forEach(r => {
      const blobPath = path.join(loc.blobs, r.blob_id);
      const blobExists = fs.existsSync(blobPath);
      
      let modTime = null;
      if (blobExists) {
        const stats = fs.statSync(blobPath);
        modTime = stats.mtime;
      }
      
      console.log(`   ✅ ${decodeURIComponent(r.key)}`);
      console.log(`      크기: ${(r.size / 1024).toFixed(1)} KB`);
      console.log(`      Blob: ${blobExists ? '있음' : '없음'}`);
      if (modTime) {
        console.log(`      수정일: ${modTime.toISOString()}`);
      }
      console.log(`      blob_id: ${r.blob_id.substring(0, 40)}...`);
    });
    console.log('');
    
  } catch (error) {
    console.log(`   ❌ 오류: ${error.message}\n`);
  }
}

// 고아 blob 중 가상현실전문가 이미지 크기와 비슷한 것 찾기
console.log('=== 고아 Blob 중 비슷한 크기 (600KB~700KB) 검색 ===\n');

const mainBlobsDir = '.wrangler/state/v3/r2/careerwiki-uploads/blobs';
const db = new Database('.wrangler/state/v3/r2/careerwiki-uploads/18ff2cc45daf2fc34011c4fb8bac92efb38a07255e5c66f9012346ba52364739.sqlite', { readonly: true });
const allDbBlobIds = new Set(db.prepare('SELECT blob_id FROM _mf_objects').all().map(r => r.blob_id));
db.close();

const blobFiles = fs.readdirSync(mainBlobsDir);
const orphanBlobs = blobFiles.filter(f => !allDbBlobIds.has(f));

const similarSizeBlobs = [];
orphanBlobs.forEach(blobId => {
  const blobPath = path.join(mainBlobsDir, blobId);
  const stats = fs.statSync(blobPath);
  
  // 600KB ~ 700KB 범위 (가상현실전문가 654KB와 비슷)
  if (stats.size >= 600000 && stats.size <= 700000) {
    // webp 파일인지 확인
    const fd = fs.openSync(blobPath, 'r');
    const buffer = Buffer.alloc(12);
    fs.readSync(fd, buffer, 0, 12, 0);
    fs.closeSync(fd);
    
    if (buffer[0] === 0x52 && buffer[1] === 0x49 && buffer[8] === 0x57 && buffer[9] === 0x45) {
      similarSizeBlobs.push({
        blobId,
        size: stats.size,
        mtime: stats.mtime
      });
    }
  }
});

console.log(`비슷한 크기의 WebP 고아 blob: ${similarSizeBlobs.length}개`);
similarSizeBlobs.sort((a, b) => b.mtime - a.mtime);
similarSizeBlobs.slice(0, 10).forEach(b => {
  console.log(`  ${b.blobId.substring(0, 40)}... (${(b.size / 1024).toFixed(1)} KB, ${b.mtime.toISOString()})`);
});


