import Database from 'better-sqlite3';
import fs from 'fs';
import path from 'path';
import fetch from 'node-fetch';

const LOCAL_R2_DB_PATH = '.wrangler/state/v3/r2/miniflare-R2BucketObject/18ff2cc45daf2fc34011c4fb8bac92efb38a07255e5c66f9012346ba52364739.sqlite';
const LOCAL_R2_BLOBS_DIR = '.wrangler/state/v3/r2/miniflare-R2BucketObject/blobs';

const ACCOUNT_ID = '3587865378649966bfb0a814fce73c77';
const BUCKET_NAME = 'careerwiki-uploads';
const API_TOKEN = process.env.CLOUDFLARE_API_TOKEN;

async function uploadToR2(key, data, contentType) {
    const url = `https://api.cloudflare.com/client/v4/accounts/${ACCOUNT_ID}/r2/buckets/${BUCKET_NAME}/objects/${encodeURIComponent(key)}`;
    const res = await fetch(url, {
        method: 'PUT',
        headers: { 'Authorization': `Bearer ${API_TOKEN}`, 'Content-Type': contentType },
        body: data
    });
    return res.ok;
}

async function main() {
    console.log('=== 로컬 R2에서 프로필 이미지 찾기 ===\n');
    
    // 로컬 R2 DB 확인
    if (!fs.existsSync(LOCAL_R2_DB_PATH)) {
        console.log('❌ 로컬 R2 DB 파일을 찾을 수 없습니다.');
        return;
    }
    
    const db = new Database(LOCAL_R2_DB_PATH, { readonly: true });
    
    // profile/ 키 찾기
    const profileObjects = db.prepare("SELECT key, blob_id, http_metadata FROM _mf_objects WHERE key LIKE 'profile/%'").all();
    
    console.log(`로컬 R2 profile/ 객체: ${profileObjects.length}개\n`);
    
    if (profileObjects.length === 0) {
        // 다른 R2 state 확인
        console.log('다른 R2 state 확인 중...');
        const otherPaths = [
            '.wrangler/state/v3/r2/careerwiki-uploads'
        ];
        
        for (const basePath of otherPaths) {
            const sqlitePath = path.join(basePath, '18ff2cc45daf2fc34011c4fb8bac92efb38a07255e5c66f9012346739.sqlite');
            if (fs.existsSync(sqlitePath)) {
                console.log(`\n${sqlitePath} 확인:`);
                const otherDb = new Database(sqlitePath, { readonly: true });
                const otherProfile = otherDb.prepare("SELECT key FROM _mf_objects WHERE key LIKE 'profile/%'").all();
                console.log(`  profile/ 객체: ${otherProfile.length}개`);
                otherProfile.forEach(obj => console.log(`    - ${obj.key}`));
                otherDb.close();
            }
        }
        
        db.close();
        return;
    }
    
    // 업로드
    console.log('Production R2에 업로드 중...\n');
    
    for (const obj of profileObjects) {
        const blobPath = path.join(LOCAL_R2_BLOBS_DIR, obj.blob_id);
        
        if (!fs.existsSync(blobPath)) {
            console.log(`❌ ${obj.key}: blob 파일 없음`);
            continue;
        }
        
        const data = fs.readFileSync(blobPath);
        let contentType = 'image/png';
        
        try {
            const httpMeta = JSON.parse(obj.http_metadata);
            if (httpMeta.contentType) contentType = httpMeta.contentType;
        } catch (e) {}
        
        const success = await uploadToR2(obj.key, data, contentType);
        console.log(`${success ? '✅' : '❌'} ${obj.key} (${(data.length / 1024).toFixed(1)} KB)`);
    }
    
    db.close();
    console.log('\n✅ 완료');
}

main().catch(e => console.error('Error:', e.message));


