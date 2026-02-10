import Database from 'better-sqlite3';

const ACCOUNT_ID = '3587865378649966bfb0a814fce73c77';
const BUCKET_NAME = 'careerwiki-uploads';
const API_TOKEN = 'H3nfdRXvuqu9qr28KxzGrL5XoeezZ7_GG1SdPAmL';
const LOCAL_R2_DB_PATH = '.wrangler/state/v3/r2/careerwiki-uploads/18ff2cc45daf2fc34011c4fb8bac92efb38a07255e5c66f9012346ba52364739.sqlite';

// Production R2에서 모든 키 가져오기
async function getAllProductionKeys() {
  const keys = new Set();
  let cursor = null;
  let iterations = 0;
  
  do {
    let url = `https://api.cloudflare.com/client/v4/accounts/${ACCOUNT_ID}/r2/buckets/${BUCKET_NAME}/objects?per_page=1000`;
    if (cursor) {
      url += `&cursor=${cursor}`;
    }
    
    const res = await fetch(url, {
      headers: { 'Authorization': `Bearer ${API_TOKEN}` }
    });
    
    const data = await res.json();
    if (data.success && data.result) {
      data.result.forEach(obj => keys.add(obj.key));
      cursor = data.result_info?.cursor || null;
    } else {
      break;
    }
    
    iterations++;
    process.stdout.write(`\r  Production에서 ${keys.size}개 키 로드 중...`);
    
    if (iterations > 50) break; // 안전장치
    
  } while (cursor);
  
  console.log(`\n  완료: ${keys.size}개`);
  return keys;
}

// 로컬 R2에서 모든 키 가져오기
function getAllLocalKeys() {
  const db = new Database(LOCAL_R2_DB_PATH, { readonly: true });
  const rows = db.prepare("SELECT key FROM _mf_objects").all();
  db.close();
  return new Set(rows.map(r => r.key));
}

console.log('=== 로컬 vs Production R2 비교 ===\n');

console.log('1. 로컬 R2 키 로드 중...');
const localKeys = getAllLocalKeys();
console.log(`  로컬 R2: ${localKeys.size}개 객체\n`);

console.log('2. Production R2 키 로드 중...');
const productionKeys = await getAllProductionKeys();

// 비교
console.log('\n3. 비교 결과:');

const onlyInLocal = [...localKeys].filter(k => !productionKeys.has(k));
const onlyInProduction = [...productionKeys].filter(k => !localKeys.has(k));

console.log(`  - 로컬에만 있음: ${onlyInLocal.length}개`);
console.log(`  - Production에만 있음: ${onlyInProduction.length}개`);
console.log(`  - 양쪽 모두 있음: ${localKeys.size - onlyInLocal.length}개`);

// 누락된 이미지 샘플 (jobs 폴더)
const missingJobs = onlyInLocal.filter(k => k.startsWith('jobs/')).slice(0, 20);
if (missingJobs.length > 0) {
  console.log(`\n4. Production에 없는 jobs 이미지 샘플 (${missingJobs.length}개 중 처음 20개):`);
  missingJobs.forEach(k => {
    try {
      console.log(`  - ${decodeURIComponent(k)}`);
    } catch (e) {
      console.log(`  - ${k}`);
    }
  });
}

// 가상현실전문가 확인
const vrKey = 'jobs/job-%EA%B0%80%EC%83%81%ED%98%84%EC%8B%A4%EC%A0%84%EB%AC%B8%EA%B0%80.webp';
console.log(`\n5. 가상현실전문가 이미지:`);
console.log(`  - 로컬: ${localKeys.has(vrKey) ? '✅ 있음' : '❌ 없음'}`);
console.log(`  - Production: ${productionKeys.has(vrKey) ? '✅ 있음' : '❌ 없음'}`);


