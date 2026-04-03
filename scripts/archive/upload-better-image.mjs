import Database from 'better-sqlite3';
import fs from 'fs';
import path from 'path';
import fetch from 'node-fetch';

const MINIFLARE_R2_DB = '.wrangler/state/v3/r2/miniflare-R2BucketObject/18ff2cc45daf2fc34011c4fb8bac92efb38a07255e5c66f9012346ba52364739.sqlite';
const MINIFLARE_R2_BLOBS = '.wrangler/state/v3/r2/miniflare-R2BucketObject/blobs';

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

    const response = await fetch(url, {
        method: 'PUT',
        headers: headers,
        body: body
    });

    if (!response.ok) {
        const errorText = await response.text();
        throw new Error(`R2 API Error: ${response.status} - ${errorText}`);
    }
    return { success: true };
}

async function main() {
    console.log('=== miniflare에서 더 나은 이미지 업로드 ===\n');

    const db = new Database(MINIFLARE_R2_DB, { readonly: true });
    
    // 가상현실전문가 이미지 찾기 (인코딩된 키로 검색)
    const searchTerm = '%EA%B0%80%EC%83%81%ED%98%84%EC%8B%A4%EC%A0%84%EB%AC%B8%EA%B0%80';
    const result = db.prepare(`
        SELECT key, blob_id, size, http_metadata 
        FROM _mf_objects 
        WHERE key LIKE ?
    `).get(`%${searchTerm}%`);
    
    db.close();
    
    if (!result) {
        console.log('❌ miniflare에서 이미지를 찾을 수 없습니다.');
        return;
    }
    
    console.log(`찾은 이미지: ${decodeURIComponent(result.key)}`);
    console.log(`크기: ${(result.size / 1024).toFixed(1)} KB`);
    
    const blobPath = path.join(MINIFLARE_R2_BLOBS, result.blob_id);
    if (!fs.existsSync(blobPath)) {
        console.log('❌ Blob 파일이 없습니다.');
        return;
    }
    
    const blobData = fs.readFileSync(blobPath);
    console.log(`Blob 파일 크기: ${(blobData.length / 1024).toFixed(1)} KB`);
    
    let contentType = 'image/webp';
    try {
        const httpMeta = JSON.parse(result.http_metadata || '{}');
        if (httpMeta.contentType) contentType = httpMeta.contentType;
    } catch (e) {}
    
    // Production에 업로드 (기존 파일 덮어쓰기)
    console.log('\n🚀 Production R2에 업로드 중...');
    
    const decodedKey = decodeURIComponent(result.key);
    try {
        await uploadToR2(decodedKey, blobData, contentType);
        console.log(`✅ 업로드 완료: ${decodedKey}`);
    } catch (error) {
        console.error(`❌ 업로드 실패: ${error.message}`);
    }
}

main();

