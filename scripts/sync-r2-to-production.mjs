/**
 * 로컬 R2 이미지를 Production R2로 동기화
 * S3 호환 API 사용
 */

import Database from 'better-sqlite3';
import fs from 'fs';
import path from 'path';
import { createHash, createHmac } from 'crypto';

const ACCOUNT_ID = '3587865378649966bfb0a814fce73c77';
const BUCKET_NAME = 'careerwiki-uploads';
const R2_ACCESS_KEY_ID = process.env.R2_ACCESS_KEY_ID || 'e9762d4b935b091ac204ec9d445b2f8a';
const R2_SECRET_ACCESS_KEY = process.env.R2_SECRET_ACCESS_KEY || '8f41e6270db28fdbdb4305c4cedef88a4a4c7c6003d59c2b3d82f1b5eb52726e';

// AWS Signature V4 서명 생성
function getSignatureKey(key, dateStamp, regionName, serviceName) {
  const kDate = createHmac('sha256', 'AWS4' + key).update(dateStamp).digest();
  const kRegion = createHmac('sha256', kDate).update(regionName).digest();
  const kService = createHmac('sha256', kRegion).update(serviceName).digest();
  const kSigning = createHmac('sha256', kService).update('aws4_request').digest();
  return kSigning;
}

async function uploadToR2(objectKey, body, contentType) {
  const endpoint = `https://${ACCOUNT_ID}.r2.cloudflarestorage.com`;
  const method = 'PUT';
  const service = 's3';
  const region = 'auto';
  
  const now = new Date();
  const amzDate = now.toISOString().replace(/[:-]|\.\d{3}/g, '');
  const dateStamp = amzDate.slice(0, 8);
  
  const payloadHash = createHash('sha256').update(body).digest('hex');
  
  const canonicalUri = '/' + BUCKET_NAME + '/' + objectKey;
  const canonicalQueryString = '';
  const canonicalHeaders = 
    'content-type:' + contentType + '\n' +
    'host:' + ACCOUNT_ID + '.r2.cloudflarestorage.com\n' +
    'x-amz-content-sha256:' + payloadHash + '\n' +
    'x-amz-date:' + amzDate + '\n';
  const signedHeaders = 'content-type;host;x-amz-content-sha256;x-amz-date';
  
  const canonicalRequest = method + '\n' + canonicalUri + '\n' + canonicalQueryString + '\n' + canonicalHeaders + '\n' + signedHeaders + '\n' + payloadHash;
  
  const algorithm = 'AWS4-HMAC-SHA256';
  const credentialScope = dateStamp + '/' + region + '/' + service + '/aws4_request';
  const stringToSign = algorithm + '\n' + amzDate + '\n' + credentialScope + '\n' + createHash('sha256').update(canonicalRequest).digest('hex');
  
  const signingKey = getSignatureKey(R2_SECRET_ACCESS_KEY, dateStamp, region, service);
  const signature = createHmac('sha256', signingKey).update(stringToSign).digest('hex');
  
  const authorizationHeader = algorithm + ' Credential=' + R2_ACCESS_KEY_ID + '/' + credentialScope + ', SignedHeaders=' + signedHeaders + ', Signature=' + signature;
  
  const response = await fetch(endpoint + canonicalUri, {
    method: 'PUT',
    headers: {
      'Content-Type': contentType,
      'x-amz-content-sha256': payloadHash,
      'x-amz-date': amzDate,
      'Authorization': authorizationHeader
    },
    body: body
  });
  
  if (!response.ok) {
    const text = await response.text();
    throw new Error(`R2 업로드 실패: ${response.status} ${text}`);
  }
  
  return true;
}

async function main() {
  // 1. 로컬 R2 SQLite에서 이미지 키 목록 추출
  const r2DbDir = '.wrangler/state/v3/r2/careerwiki-uploads';
  const files = fs.readdirSync(r2DbDir);
  const sqliteFile = files.find(f => f.endsWith('.sqlite') && !f.includes('-shm') && !f.includes('-wal'));
  
  if (!sqliteFile) {
    console.error('❌ 로컬 R2 SQLite 파일을 찾을 수 없습니다.');
    process.exit(1);
  }
  
  const dbPath = path.join(r2DbDir, sqliteFile);
  console.log(`📂 로컬 R2 DB: ${dbPath}`);
  
  const db = new Database(dbPath, { readonly: true });
  
  // R2 메타데이터 테이블에서 객체 키 조회
  const objects = db.prepare(`
    SELECT key, blob_id, size, http_metadata
    FROM _mf_objects
    WHERE key NOT LIKE '.%'
  `).all().map(obj => {
    let contentType = 'application/octet-stream';
    try {
      const httpMeta = JSON.parse(obj.http_metadata);
      contentType = httpMeta.contentType || 'application/octet-stream';
    } catch {}
    return { ...obj, content_type: contentType };
  });
  
  console.log(`📊 업로드할 이미지: ${objects.length}개`);
  
  if (objects.length === 0) {
    console.log('⚠️ 업로드할 이미지가 없습니다.');
    db.close();
    return;
  }
  
  // 2. blob 디렉토리 경로
  const blobDir = path.join(r2DbDir, 'blobs');
  
  // 3. 이미지 업로드
  let successCount = 0;
  let errorCount = 0;
  let skipCount = 0;
  
  console.log('\n🚀 Production R2 업로드 시작...\n');
  
  for (let i = 0; i < objects.length; i++) {
    const obj = objects[i];
    const progress = `[${i + 1}/${objects.length}]`;
    
    try {
      // blob 파일 경로
      const blobPath = path.join(blobDir, obj.blob_id);
      
      if (!fs.existsSync(blobPath)) {
        skipCount++;
        continue;
      }
      
      const body = fs.readFileSync(blobPath);
      const contentType = obj.content_type || 'application/octet-stream';
      
      await uploadToR2(obj.key, body, contentType);
      successCount++;
      
      if (successCount % 100 === 0) {
        console.log(`${progress} ✅ ${successCount} 성공, ${errorCount} 실패, ${skipCount} 스킵`);
      }
    } catch (error) {
      errorCount++;
      if (errorCount <= 5) {
        console.log(`\n${progress} ❌ ${obj.key} 실패: ${error.message}`);
      }
    }
    
    // Rate limiting 방지
    if ((i + 1) % 50 === 0) {
      await new Promise(r => setTimeout(r, 500));
    }
  }
  
  db.close();
  
  console.log(`\n\n✅ R2 동기화 완료!`);
  console.log(`   - 성공: ${successCount}개`);
  console.log(`   - 실패: ${errorCount}개`);
  console.log(`   - 스킵 (blob 없음): ${skipCount}개`);
}

main().catch(console.error);

