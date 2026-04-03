import Database from 'better-sqlite3';
import fs from 'fs';
import path from 'path';
import fetch from 'node-fetch';

const MINIFLARE_R2_DB = '.wrangler/state/v3/r2/miniflare-R2BucketObject/18ff2cc45daf2fc34011c4fb8bac92efb38a07255e5c66f9012346ba52364739.sqlite';
const MINIFLARE_R2_BLOBS = '.wrangler/state/v3/r2/miniflare-R2BucketObject/blobs';

const BACKUP_R2_DB = 'backup/backup_20251222_151839/.wrangler/state/v3/r2/careerwiki-uploads/18ff2cc45daf2fc34011c4fb8bac92efb38a07255e5c66f9012346ba52364739.sqlite';

const ACCOUNT_ID = '3587865378649966bfb0a814fce73c77';
const BUCKET_NAME = 'careerwiki-uploads';
const API_TOKEN = process.env.CLOUDFLARE_API_TOKEN;

// 복구된 4개 이미지의 키 (인코딩된 형태)
const recoveredKeys = [
  { name: '가수', encoded: '%EA%B0%80%EC%88%98' },
  { name: '간호조무사', encoded: '%EA%B0%84%ED%98%B8%EC%A1%B0%EB%AC%B4%EC%82%AC' },
  { name: '매장매니저', encoded: '%EB%A7%A4%EC%9E%A5%EB%A7%A4%EB%8B%88%EC%A0%80' }
];

async function uploadToR2(fileKey, body, contentType) {
    const url = `https://api.cloudflare.com/client/v4/accounts/${ACCOUNT_ID}/r2/buckets/${BUCKET_NAME}/objects/${encodeURIComponent(fileKey)}`;
    const response = await fetch(url, {
        method: 'PUT',
        headers: { 'Content-Type': contentType, 'Authorization': `Bearer ${API_TOKEN}` },
        body: body
    });
    if (!response.ok) throw new Error(`R2 API Error: ${response.status}`);
    return { success: true };
}

async function main() {
    console.log('=== 복구된 이미지 비교 (miniflare vs 백업) ===\n');

    const miniflareDb = new Database(MINIFLARE_R2_DB, { readonly: true });
    const backupDb = new Database(BACKUP_R2_DB, { readonly: true });

    const upgrades = [];

    for (const item of recoveredKeys) {
        console.log(`📷 ${item.name}:`);
        
        const miniflareResult = miniflareDb.prepare(`
            SELECT key, blob_id, size FROM _mf_objects WHERE key LIKE ?
        `).get(`%${item.encoded}%`);
        
        const backupResult = backupDb.prepare(`
            SELECT key, blob_id, size FROM _mf_objects WHERE key LIKE ?
        `).get(`%${item.encoded}%`);
        
        const miniflareSize = miniflareResult ? miniflareResult.size : 0;
        const backupSize = backupResult ? backupResult.size : 0;
        
        console.log(`   miniflare: ${miniflareSize ? (miniflareSize/1024).toFixed(1) + ' KB' : '없음'}`);
        console.log(`   백업: ${backupSize ? (backupSize/1024).toFixed(1) + ' KB' : '없음'}`);
        
        if (miniflareSize > backupSize && miniflareResult) {
            const blobPath = path.join(MINIFLARE_R2_BLOBS, miniflareResult.blob_id);
            if (fs.existsSync(blobPath)) {
                console.log(`   ⬆️ miniflare가 더 큼! 업그레이드 대상`);
                upgrades.push({
                    name: item.name,
                    key: miniflareResult.key,
                    blobId: miniflareResult.blob_id,
                    size: miniflareSize
                });
            }
        } else {
            console.log(`   ✅ 현재 버전 유지`);
        }
        console.log('');
    }

    miniflareDb.close();
    backupDb.close();

    if (upgrades.length > 0 && API_TOKEN) {
        console.log('=== 더 나은 이미지로 업그레이드 ===\n');
        
        for (const upgrade of upgrades) {
            const blobPath = path.join(MINIFLARE_R2_BLOBS, upgrade.blobId);
            const blobData = fs.readFileSync(blobPath);
            const decodedKey = decodeURIComponent(upgrade.key);
            
            try {
                await uploadToR2(decodedKey, blobData, 'image/webp');
                console.log(`✅ ${upgrade.name}: ${(upgrade.size/1024).toFixed(1)} KB 업로드 완료`);
            } catch (error) {
                console.error(`❌ ${upgrade.name}: 업로드 실패 - ${error.message}`);
            }
        }
    } else if (upgrades.length === 0) {
        console.log('✅ 모든 이미지가 이미 최선의 버전입니다.');
    }
}

main();


