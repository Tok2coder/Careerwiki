import Database from 'better-sqlite3';
import fs from 'fs';
import path from 'path';

const ACCOUNT_ID = '3587865378649966bfb0a814fce73c77';
const BUCKET_NAME = 'careerwiki-uploads';
const API_TOKEN = 'H3nfdRXvuqu9qr28KxzGrL5XoeezZ7_GG1SdPAmL';
const LOCAL_R2_DB_PATH = '.wrangler/state/v3/r2/careerwiki-uploads/18ff2cc45daf2fc34011c4fb8bac92efb38a07255e5c66f9012346ba52364739.sqlite';
const LOCAL_R2_BLOBS_DIR = '.wrangler/state/v3/r2/careerwiki-uploads/blobs';

// API 호출 (재시도 로직 포함)
async function apiCall(url, options, retries = 3) {
  for (let i = 0; i < retries; i++) {
    try {
      const res = await fetch(url, options);
      if (res.status === 429) {
        console.log('  Rate limited, waiting 5s...');
        await new Promise(r => setTimeout(r, 5000));
        continue;
      }
      return res;
    } catch (e) {
      if (i === retries - 1) throw e;
      await new Promise(r => setTimeout(r, 1000));
    }
  }
}

// Production R2에서 객체 삭제
async function deleteObject(key) {
  const url = `https://api.cloudflare.com/client/v4/accounts/${ACCOUNT_ID}/r2/buckets/${BUCKET_NAME}/objects/${encodeURIComponent(key)}`;
  const res = await apiCall(url, {
    method: 'DELETE',
    headers: { 'Authorization': `Bearer ${API_TOKEN}` }
  });
  return res.ok;
}

// Production R2에 객체 업로드
async function uploadObject(key, body, contentType) {
  const url = `https://api.cloudflare.com/client/v4/accounts/${ACCOUNT_ID}/r2/buckets/${BUCKET_NAME}/objects/${encodeURIComponent(key)}`;
  const res = await apiCall(url, {
    method: 'PUT',
    headers: { 
      'Authorization': `Bearer ${API_TOKEN}`,
      'Content-Type': contentType
    },
    body: body
  });
  return res.ok;
}

// Production R2 모든 객체 가져오기
async function getAllProductionObjects() {
  const objects = [];
  let cursor = null;
  
  do {
    let url = `https://api.cloudflare.com/client/v4/accounts/${ACCOUNT_ID}/r2/buckets/${BUCKET_NAME}/objects?per_page=1000`;
    if (cursor) url += `&cursor=${cursor}`;
    
    const res = await fetch(url, { headers: { 'Authorization': `Bearer ${API_TOKEN}` } });
    const data = await res.json();
    
    if (data.success && data.result) {
      objects.push(...data.result);
      cursor = data.result_info?.cursor || null;
    } else break;
    
    process.stdout.write(`\r  ${objects.length}개 로드...`);
  } while (cursor);
  
  console.log();
  return objects;
}

// 로컬 R2 객체 정보 가져오기
function getLocalObjects() {
  const db = new Database(LOCAL_R2_DB_PATH, { readonly: true });
  const rows = db.prepare("SELECT key, blob_id, http_metadata FROM _mf_objects").all();
  db.close();
  return rows;
}

console.log('=== R2 정리 시작 ===\n');

// 1. 데이터 로드
console.log('1. 데이터 로드 중...');
const localObjects = getLocalObjects();
const localKeys = new Set(localObjects.map(o => o.key));
console.log(`   로컬: ${localObjects.length}개`);

console.log('   Production 로드 중...');
const productionObjects = await getAllProductionObjects();
console.log(`   Production: ${productionObjects.length}개`);

// 2. 삭제 대상 식별 (Production에만 있는 것)
const keysToDelete = productionObjects
  .filter(obj => !localKeys.has(obj.key))
  .map(obj => obj.key);

console.log(`\n2. 삭제 대상: ${keysToDelete.length}개`);

// 3. 업로드 대상 식별 (로컬에만 있는 것)
const productionKeySet = new Set(productionObjects.map(o => o.key));
const objectsToUpload = localObjects.filter(obj => !productionKeySet.has(obj.key));

console.log(`   업로드 대상: ${objectsToUpload.length}개`);

// 4. 삭제 실행
console.log('\n3. 중복/불필요한 객체 삭제 중...');
let deleteSuccess = 0;
let deleteFail = 0;

for (let i = 0; i < keysToDelete.length; i++) {
  const key = keysToDelete[i];
  const success = await deleteObject(key);
  if (success) deleteSuccess++;
  else deleteFail++;
  
  if ((i + 1) % 100 === 0 || i === keysToDelete.length - 1) {
    process.stdout.write(`\r   [${i + 1}/${keysToDelete.length}] 삭제: ${deleteSuccess} 성공, ${deleteFail} 실패`);
  }
  
  // Rate limiting 방지
  if ((i + 1) % 50 === 0) {
    await new Promise(r => setTimeout(r, 100));
  }
}
console.log();

// 5. 업로드 실행
console.log('\n4. 누락된 객체 업로드 중...');
let uploadSuccess = 0;
let uploadFail = 0;

for (let i = 0; i < objectsToUpload.length; i++) {
  const obj = objectsToUpload[i];
  const blobPath = path.join(LOCAL_R2_BLOBS_DIR, obj.blob_id);
  
  if (!fs.existsSync(blobPath)) {
    console.log(`\n   ⚠️ Blob 없음: ${obj.key}`);
    uploadFail++;
    continue;
  }
  
  const blobData = fs.readFileSync(blobPath);
  let contentType = 'application/octet-stream';
  
  try {
    const httpMeta = JSON.parse(obj.http_metadata || '{}');
    if (httpMeta.contentType) contentType = httpMeta.contentType;
  } catch (e) {}
  
  const success = await uploadObject(obj.key, blobData, contentType);
  if (success) uploadSuccess++;
  else uploadFail++;
  
  process.stdout.write(`\r   [${i + 1}/${objectsToUpload.length}] 업로드: ${uploadSuccess} 성공, ${uploadFail} 실패`);
}
console.log();

// 6. 결과 요약
console.log('\n=== 정리 완료 ===');
console.log(`삭제: ${deleteSuccess}/${keysToDelete.length} 성공`);
console.log(`업로드: ${uploadSuccess}/${objectsToUpload.length} 성공`);
console.log(`\n최종 Production R2 객체 수: 약 ${productionObjects.length - deleteSuccess + uploadSuccess}개`);
console.log(`(예상: ${localObjects.length}개와 동일해야 함)`);


