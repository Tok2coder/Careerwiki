const ACCOUNT_ID = '3587865378649966bfb0a814fce73c77';
const BUCKET_NAME = 'careerwiki-uploads';
const API_TOKEN = 'H3nfdRXvuqu9qr28KxzGrL5XoeezZ7_GG1SdPAmL';

// 가상현실전문가의 URL 인코딩된 형태
const targetEncoded = 'jobs/job-%EA%B0%80%EC%83%81%ED%98%84%EC%8B%A4%EC%A0%84%EB%AC%B8%EA%B0%80.webp';

// 해당 prefix로 검색
async function searchObject(prefix) {
  const url = `https://api.cloudflare.com/client/v4/accounts/${ACCOUNT_ID}/r2/buckets/${BUCKET_NAME}/objects?prefix=${encodeURIComponent(prefix)}&per_page=100`;
  
  const res = await fetch(url, {
    headers: { 
      'Authorization': `Bearer ${API_TOKEN}`,
      'Content-Type': 'application/json'
    }
  });
  
  return await res.json();
}

console.log('=== 가상현실전문가 이미지 검색 ===\n');

// 가상현실의 인코딩된 형태로 검색: %EA%B0%80%EC%83%81%ED%98%84%EC%8B%A4
const prefix1 = 'jobs/job-%EA%B0%80%EC%83%81';
console.log('검색 prefix:', prefix1);
const result1 = await searchObject(prefix1);

if (result1.success && result1.result && result1.result.length > 0) {
  console.log(`\n✅ 발견된 객체 (${result1.result.length}개):`);
  result1.result.forEach(obj => {
    // 디코딩해서 표시
    let decoded = obj.key;
    try {
      decoded = decodeURIComponent(obj.key);
    } catch (e) {}
    console.log(`  - ${decoded}`);
    console.log(`    원본 키: ${obj.key}`);
    console.log(`    크기: ${(obj.size / 1024).toFixed(1)} KB`);
  });
} else {
  console.log('❌ 해당 prefix로 객체를 찾을 수 없습니다.');
  console.log('응답:', JSON.stringify(result1, null, 2));
}

// 전체 jobs 객체 수 확인
console.log('\n=== jobs/ 폴더 전체 객체 수 ===');
let totalJobs = 0;
let cursor = null;
let iterations = 0;

do {
  let url = `https://api.cloudflare.com/client/v4/accounts/${ACCOUNT_ID}/r2/buckets/${BUCKET_NAME}/objects?prefix=jobs%2F&per_page=1000`;
  if (cursor) {
    url += `&cursor=${cursor}`;
  }
  
  const res = await fetch(url, {
    headers: { 
      'Authorization': `Bearer ${API_TOKEN}`,
      'Content-Type': 'application/json'
    }
  });
  
  const data = await res.json();
  if (data.success && data.result) {
    totalJobs += data.result.length;
    cursor = data.result_info?.cursor || null;
  } else {
    break;
  }
  
  iterations++;
  if (iterations > 20) break; // 안전장치
  
} while (cursor);

console.log(`jobs/ 폴더 총 객체 수: ${totalJobs}개`);


