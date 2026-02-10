/**
 * HowTo 이미지 정리 스크립트
 * 'HowTo 작성법'에 있는 이미지만 유지하고 나머지 삭제
 */
import fetch from 'node-fetch';
import Database from 'better-sqlite3';

const ACCOUNT_ID = '3587865378649966bfb0a814fce73c77';
const BUCKET_NAME = 'careerwiki-uploads';
const API_TOKEN = process.env.CLOUDFLARE_API_TOKEN;
const LOCAL_D1_PATH = '.wrangler/state/v3/d1/miniflare-D1DatabaseObject/926ac646196f97cbbf82a014f1749799d60a709010a65dbb289e4b2e6132a340.sqlite';

if (!API_TOKEN) {
    console.error('❌ CLOUDFLARE_API_TOKEN 환경 변수가 설정되지 않았습니다.');
    process.exit(1);
}

async function listR2Objects(prefix) {
    let allObjects = [];
    let cursor = null;
    
    while (true) {
        const url = `https://api.cloudflare.com/client/v4/accounts/${ACCOUNT_ID}/r2/buckets/${BUCKET_NAME}/objects?prefix=${encodeURIComponent(prefix)}&limit=1000${cursor ? `&cursor=${cursor}` : ''}`;
        const res = await fetch(url, { headers: { 'Authorization': `Bearer ${API_TOKEN}` } });
        const data = await res.json();
        
        if (!data.success) break;
        allObjects = allObjects.concat(data.result);
        cursor = data.result_info?.cursor;
        if (!cursor) break;
    }
    return allObjects;
}

async function deleteR2Object(key) {
    const url = `https://api.cloudflare.com/client/v4/accounts/${ACCOUNT_ID}/r2/buckets/${BUCKET_NAME}/objects/${encodeURIComponent(key)}`;
    const res = await fetch(url, {
        method: 'DELETE',
        headers: { 'Authorization': `Bearer ${API_TOKEN}` }
    });
    return res.ok;
}

function extractImageUrls(content) {
    const urls = [];
    if (!content) return urls;
    
    // Markdown 이미지: ![alt](url)
    const mdRegex = /!\[[^\]]*\]\(([^)]+)\)/g;
    let match;
    while ((match = mdRegex.exec(content)) !== null) {
        urls.push(match[1]);
    }
    
    // HTML img 태그: <img src="url">
    const imgRegex = /<img[^>]+src=["']([^"']+)["']/gi;
    while ((match = imgRegex.exec(content)) !== null) {
        urls.push(match[1]);
    }
    
    // 일반 URL (howto/ 포함)
    const urlRegex = /\/uploads\/howto\/[^\s"'<>)]+/g;
    while ((match = urlRegex.exec(content)) !== null) {
        urls.push(match[0]);
    }
    
    return urls;
}

function urlToR2Key(url) {
    // /uploads/howto/xxx.png -> howto/xxx.png
    // http://localhost:3000/uploads/howto/xxx.png -> howto/xxx.png
    return url
        .replace('http://localhost:3000/uploads/', '')
        .replace('/uploads/', '')
        .split('?')[0]; // 쿼리스트링 제거
}

async function main() {
    console.log('=== HowTo 이미지 정리 ===\n');
    
    // 1. 'HowTo 작성법'에서 사용 중인 이미지 추출
    console.log('1️⃣  "HowTo 작성법"에서 사용 중인 이미지 추출...');
    
    const db = new Database(LOCAL_D1_PATH, { readonly: true });
    const howto = db.prepare(`
        SELECT content, meta_data FROM pages 
        WHERE slug = 'HowTo-가이드-작성법' AND page_type = 'guide'
    `).get();
    db.close();
    
    if (!howto) {
        console.log('   ❌ "HowTo 작성법" 페이지를 찾을 수 없습니다.');
        return;
    }
    
    // 본문에서 이미지 URL 추출
    const contentUrls = extractImageUrls(howto.content);
    
    // 썸네일 URL 추출
    let thumbnailUrl = null;
    try {
        const metaData = JSON.parse(howto.meta_data || '{}');
        if (metaData.thumbnailUrl) {
            thumbnailUrl = metaData.thumbnailUrl;
            contentUrls.push(thumbnailUrl);
        }
    } catch (e) {}
    
    // R2 키로 변환
    const usedKeys = new Set(contentUrls.map(urlToR2Key).filter(k => k.startsWith('howto/')));
    
    console.log(`   사용 중인 이미지: ${usedKeys.size}개`);
    usedKeys.forEach(key => console.log(`     - ${key}`));
    
    // 2. R2 howto/ 폴더의 모든 이미지 조회
    console.log('\n2️⃣  R2 howto/ 폴더 조회...');
    const howtoObjects = await listR2Objects('howto/');
    console.log(`   총 이미지: ${howtoObjects.length}개`);
    
    // 3. 삭제 대상 식별
    const toDelete = howtoObjects.filter(obj => !usedKeys.has(obj.key));
    console.log(`   삭제 대상: ${toDelete.length}개`);
    
    if (toDelete.length === 0) {
        console.log('\n✅ 삭제할 이미지가 없습니다.');
        return;
    }
    
    // 4. 삭제 실행
    console.log('\n3️⃣  불필요한 이미지 삭제 중...');
    
    let deletedCount = 0;
    let errorCount = 0;
    
    for (let i = 0; i < toDelete.length; i++) {
        const obj = toDelete[i];
        const deleted = await deleteR2Object(obj.key);
        
        if (deleted) {
            deletedCount++;
        } else {
            errorCount++;
            console.log(`   ⚠️ 삭제 실패: ${obj.key}`);
        }
        
        process.stdout.write(`\r[${i + 1}/${toDelete.length}] ${deletedCount} 삭제, ${errorCount} 오류`);
    }
    
    console.log('\n');
    console.log('=== 정리 완료 ===');
    console.log(`   삭제: ${deletedCount}개`);
    console.log(`   오류: ${errorCount}개`);
    console.log(`   유지: ${usedKeys.size}개`);
}

main();


