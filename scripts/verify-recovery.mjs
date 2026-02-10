import fetch from 'node-fetch';

const ACCOUNT_ID = '3587865378649966bfb0a814fce73c77';
const BUCKET_NAME = 'careerwiki-uploads';
const API_TOKEN = process.env.CLOUDFLARE_API_TOKEN;

async function listR2(prefix) {
  const url = `https://api.cloudflare.com/client/v4/accounts/${ACCOUNT_ID}/r2/buckets/${BUCKET_NAME}/objects?prefix=${encodeURIComponent(prefix)}&limit=100`;
  const res = await fetch(url, { headers: { 'Authorization': `Bearer ${API_TOKEN}` } });
  const data = await res.json();
  return data.success ? data.result : [];
}

async function main() {
  // 복구된 4개 이미지 확인
  const recoveredKeys = [
    'jobs/job-가상현실전문가.webp',
    'jobs/job-가수.webp', 
    'jobs/job-간호조무사.webp',
    'jobs/job-매장매니저.webp'
  ];

  console.log('=== 복구된 이미지 확인 ===');
  
  for (const key of recoveredKeys) {
    // 디코딩된 키와 인코딩된 키 모두 검색
    const encodedKey = encodeURIComponent(key.replace('jobs/', ''));
    
    // 해당 이름으로 시작하는 객체 검색
    const prefix = key.split('.')[0]; // jobs/job-가상현실전문가
    const results = await listR2(prefix);
    
    console.log(`\n${key.replace('jobs/job-', '').replace('.webp', '')}:`);
    if (results.length > 0) {
      results.forEach(obj => {
        console.log(`  ✅ ${obj.key} (${(obj.size / 1024).toFixed(1)} KB)`);
      });
    } else {
      console.log(`  ❌ 찾을 수 없음`);
    }
  }

  // 전체 jobs 이미지 수 확인
  console.log('\n=== 전체 jobs 이미지 수 ===');
  let total = 0;
  let cursor = null;
  
  while (true) {
    const url = `https://api.cloudflare.com/client/v4/accounts/${ACCOUNT_ID}/r2/buckets/${BUCKET_NAME}/objects?prefix=jobs/&limit=1000${cursor ? `&cursor=${cursor}` : ''}`;
    const res = await fetch(url, { headers: { 'Authorization': `Bearer ${API_TOKEN}` } });
    const data = await res.json();
    
    if (data.success) {
      total += data.result.length;
      cursor = data.result_info.cursor;
      if (!cursor) break;
    } else {
      break;
    }
  }
  
  console.log(`총: ${total}개`);
}

main();


