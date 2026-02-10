import Database from 'better-sqlite3';

const LOCAL_DB_PATH = '.wrangler/state/v3/d1/miniflare-D1DatabaseObject/926ac646196f97cbbf82a014f1749799d60a709010a65dbb289e4b2e6132a340.sqlite';

console.log('=== 로컬 D1 데이터 확인 ===');
const localDb = new Database(LOCAL_DB_PATH, { readonly: true });
const localRow = localDb.prepare("SELECT slug, meta_data FROM pages WHERE slug = 'HowTo-가이드-작성법'").get();
localDb.close();

if (localRow) {
  console.log('slug:', localRow.slug);
  console.log('meta_data type:', typeof localRow.meta_data);
  console.log('meta_data length:', localRow.meta_data?.length || 0);
  console.log('First 200 chars:', localRow.meta_data?.substring(0, 200));
  
  try {
    const meta = JSON.parse(localRow.meta_data);
    console.log('\n✅ JSON 파싱 성공!');
    console.log('Keys:', Object.keys(meta));
    console.log('thumbnailUrl:', meta.thumbnailUrl);
  } catch (e) {
    console.log('\n❌ JSON 파싱 실패:', e.message);
  }
} else {
  console.log('로컬에서 데이터 없음');
}

console.log('\n=== Production D1 데이터 확인 ===');
const ACCOUNT_ID = '3587865378649966bfb0a814fce73c77';
const DATABASE_ID = 'edc21e23-c2ac-4693-bb79-389b6914e173';
const API_TOKEN = 'H3nfdRXvuqu9qr28KxzGrL5XoeezZ7_GG1SdPAmL';

const url = `https://api.cloudflare.com/client/v4/accounts/${ACCOUNT_ID}/d1/database/${DATABASE_ID}/query`;

const res = await fetch(url, {
  method: 'POST',
  headers: { 
    'Authorization': `Bearer ${API_TOKEN}`, 
    'Content-Type': 'application/json' 
  },
  body: JSON.stringify({ 
    sql: "SELECT slug, meta_data FROM pages WHERE slug = 'HowTo-가이드-작성법'" 
  })
});

const data = await res.json();
if (data.result && data.result[0] && data.result[0].results && data.result[0].results[0]) {
  const row = data.result[0].results[0];
  console.log('slug:', row.slug);
  console.log('meta_data type:', typeof row.meta_data);
  console.log('meta_data length:', row.meta_data?.length || 0);
  console.log('First 200 chars:', row.meta_data?.substring(0, 200));
  
  try {
    const meta = JSON.parse(row.meta_data);
    console.log('\n✅ JSON 파싱 성공!');
    console.log('Keys:', Object.keys(meta));
    console.log('thumbnailUrl:', meta.thumbnailUrl);
  } catch (e) {
    console.log('\n❌ JSON 파싱 실패:', e.message);
    
    // 이중 파싱 시도
    console.log('\n이중 파싱 시도...');
    try {
      // 이스케이프된 문자열을 직접 수정해서 파싱 시도
      const cleanedStr = row.meta_data.replace(/\\"/g, '"').replace(/\\\\/g, '\\');
      console.log('Cleaned first 200 chars:', cleanedStr.substring(0, 200));
    } catch (e2) {
      console.log('이중 파싱도 실패:', e2.message);
    }
  }
} else {
  console.log('Production에서 데이터 없음');
}


