import Database from 'better-sqlite3';
import fs from 'fs';
import path from 'path';
import fetch from 'node-fetch';

const BACKUP_R2_DB_PATH = 'backup/backup_20251222_151839/.wrangler/state/v3/r2/careerwiki-uploads/18ff2cc45daf2fc34011c4fb8bac92efb38a07255e5c66f9012346ba52364739.sqlite';
const BACKUP_R2_BLOBS_DIR = 'backup/backup_20251222_151839/.wrangler/state/v3/r2/careerwiki-uploads/blobs';

const LOCAL_R2_DB_PATH = '.wrangler/state/v3/r2/careerwiki-uploads/18ff2cc45daf2fc34011c4fb8bac92efb38a07255e5c66f9012346ba52364739.sqlite';
const LOCAL_R2_BLOBS_DIR = '.wrangler/state/v3/r2/careerwiki-uploads/blobs';

const ACCOUNT_ID = '3587865378649966bfb0a814fce73c77';
const BUCKET_NAME = 'careerwiki-uploads';
const API_TOKEN = process.env.CLOUDFLARE_API_TOKEN;

if (!API_TOKEN) {
    console.error('❌ CLOUDFLARE_API_TOKEN 환경 변수가 설정되지 않았습니다.');
    process.exit(1);
}

async function uploadToR2(fileKey, body, contentType) {
    const url = `https://api.cloudflare.com/client/v4/accounts/${ACCOUNT_ID}/r2/buckets/${BUCKET_NAME}/objects/${encodeURIComponent(fileKey)}`;
    const headers = {
        'Content-Type': contentType,
        'Authorization': `Bearer ${API_TOKEN}`
    };

    try {
        const response = await fetch(url, {
            method: 'PUT',
            headers: headers,
            body: body
        });

        if (!response.ok) {
            const errorText = await response.text();
            throw new Error(`R2 API Error: ${response.status} ${response.statusText} - ${errorText}`);
        }
        return { success: true };
    } catch (error) {
        return { success: false, error: error.message };
    }
}

async function main() {
    console.log('=== 백업에서 누락된 이미지 복구 ===');

    // 현재 로컬 R2 DB에서 blob이 없는 객체 찾기
    const localDb = new Database(LOCAL_R2_DB_PATH, { readonly: true });
    const localObjects = localDb.prepare('SELECT key, blob_id, size, http_metadata FROM _mf_objects').all();
    localDb.close();

    const localBlobFiles = new Set(fs.readdirSync(LOCAL_R2_BLOBS_DIR));
    const missingInLocal = localObjects.filter(o => !localBlobFiles.has(o.blob_id));
    
    console.log('로컬에서 blob 누락된 객체:', missingInLocal.length);

    // 백업 R2 DB
    const backupDb = new Database(BACKUP_R2_DB_PATH, { readonly: true });
    const backupObjects = backupDb.prepare('SELECT key, blob_id, size, http_metadata FROM _mf_objects').all();
    backupDb.close();

    const backupByKey = new Map(backupObjects.map(o => [o.key, o]));

    console.log('\n🚀 Production R2에 업로드 시작...');

    let successCount = 0;
    let failCount = 0;
    let notInBackup = 0;

    for (let i = 0; i < missingInLocal.length; i++) {
        const localObj = missingInLocal[i];
        const backupObj = backupByKey.get(localObj.key);

        if (!backupObj) {
            console.warn(`⚠️ ${decodeURIComponent(localObj.key)}: 백업에 없음`);
            notInBackup++;
            continue;
        }

        const blobPath = path.join(BACKUP_R2_BLOBS_DIR, backupObj.blob_id);
        if (!fs.existsSync(blobPath)) {
            console.warn(`⚠️ ${decodeURIComponent(localObj.key)}: 백업 blob 없음`);
            failCount++;
            continue;
        }

        const blobData = fs.readFileSync(blobPath);
        
        let contentType = 'image/webp';
        try {
            const httpMeta = JSON.parse(backupObj.http_metadata || '{}');
            if (httpMeta.contentType) contentType = httpMeta.contentType;
        } catch (e) {}

        // Production R2에 업로드 (디코딩된 키 사용 - 기존 방식과 일관성)
        const decodedKey = decodeURIComponent(localObj.key);
        const result = await uploadToR2(decodedKey, blobData, contentType);

        if (result.success) {
            successCount++;
        } else {
            console.error(`❌ ${decodedKey}: ${result.error}`);
            failCount++;
        }
        
        process.stdout.write(`\r[${i + 1}/${missingInLocal.length}] ✅ ${successCount} 성공, ❌ ${failCount} 실패`);
    }

    console.log('\n\n=== 복구 완료 ===');
    console.log(`성공: ${successCount}`);
    console.log(`실패: ${failCount}`);
    console.log(`백업에 없음: ${notInBackup}`);
}

main();


