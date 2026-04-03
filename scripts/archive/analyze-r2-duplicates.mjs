import Database from 'better-sqlite3';

const ACCOUNT_ID = '3587865378649966bfb0a814fce73c77';
const BUCKET_NAME = 'careerwiki-uploads';
const API_TOKEN = 'H3nfdRXvuqu9qr28KxzGrL5XoeezZ7_GG1SdPAmL';
const LOCAL_R2_DB_PATH = '.wrangler/state/v3/r2/careerwiki-uploads/18ff2cc45daf2fc34011c4fb8bac92efb38a07255e5c66f9012346ba52364739.sqlite';

// Production R2에서 모든 객체 가져오기
async function getAllProductionObjects() {
  const objects = [];
  let cursor = null;
  let iterations = 0;
  
  do {
    let url = `https://api.cloudflare.com/client/v4/accounts/${ACCOUNT_ID}/r2/buckets/${BUCKET_NAME}/objects?per_page=1000`;
    if (cursor) url += `&cursor=${cursor}`;
    
    const res = await fetch(url, { headers: { 'Authorization': `Bearer ${API_TOKEN}` } });
    const data = await res.json();
    
    if (data.success && data.result) {
      objects.push(...data.result);
      cursor = data.result_info?.cursor || null;
    } else break;
    
    iterations++;
    process.stdout.write(`\r  ${objects.length}개 로드 중...`);
    if (iterations > 50) break;
  } while (cursor);
  
  console.log(`\n  완료: ${objects.length}개`);
  return objects;
}

// 로컬 R2 키
function getLocalKeys() {
  const db = new Database(LOCAL_R2_DB_PATH, { readonly: true });
  const rows = db.prepare("SELECT key FROM _mf_objects").all();
  db.close();
  return new Set(rows.map(r => r.key));
}

console.log('=== R2 중복/누락 분석 ===\n');

console.log('1. 로컬 R2 키 로드...');
const localKeys = getLocalKeys();
console.log(`   로컬: ${localKeys.size}개\n`);

console.log('2. Production R2 객체 로드...');
const productionObjects = await getAllProductionObjects();

// Production에만 있는 것들 분석
const onlyInProduction = productionObjects.filter(obj => !localKeys.has(obj.key));
const onlyInLocal = [...localKeys].filter(k => !productionObjects.find(o => o.key === k));

console.log('\n3. 분석 결과:');
console.log(`   - 로컬에만 있음 (누락): ${onlyInLocal.length}개`);
console.log(`   - Production에만 있음: ${onlyInProduction.length}개`);

// Production에만 있는 것들의 패턴 분석
console.log('\n4. Production에만 있는 객체 패턴 분석:');

const patterns = {};
onlyInProduction.forEach(obj => {
  const folder = obj.key.split('/')[0] || 'root';
  patterns[folder] = (patterns[folder] || 0) + 1;
});

Object.entries(patterns).sort((a, b) => b[1] - a[1]).forEach(([folder, count]) => {
  console.log(`   - ${folder}/: ${count}개`);
});

// 샘플 확인
console.log('\n5. Production에만 있는 객체 샘플 (처음 10개):');
onlyInProduction.slice(0, 10).forEach(obj => {
  let decoded = obj.key;
  try { decoded = decodeURIComponent(obj.key); } catch (e) {}
  console.log(`   - ${decoded} (${(obj.size / 1024).toFixed(1)} KB)`);
});

// 중복 확인 (같은 파일명이 다른 인코딩으로 저장되었는지)
console.log('\n6. 중복 가능성 확인 (디코딩 후 같은 이름):');
const decodedKeys = new Map(); // decoded -> [original keys]
productionObjects.forEach(obj => {
  let decoded = obj.key;
  try { decoded = decodeURIComponent(obj.key); } catch (e) {}
  
  if (!decodedKeys.has(decoded)) {
    decodedKeys.set(decoded, []);
  }
  decodedKeys.get(decoded).push(obj.key);
});

const duplicates = [...decodedKeys.entries()].filter(([_, keys]) => keys.length > 1);
console.log(`   중복된 파일 (같은 이름, 다른 인코딩): ${duplicates.length}개`);
if (duplicates.length > 0) {
  console.log('   샘플:');
  duplicates.slice(0, 5).forEach(([decoded, keys]) => {
    console.log(`   - ${decoded}:`);
    keys.forEach(k => console.log(`     • ${k}`));
  });
}

// 정리 계획 출력
console.log('\n=== 정리 계획 ===');
console.log(`1. 삭제 대상: Production에만 있는 ${onlyInProduction.length}개`);
console.log(`2. 업로드 대상: 로컬에만 있는 ${onlyInLocal.length}개`);
console.log(`3. 최종 결과: ${localKeys.size}개 (로컬과 동일)`);


