/**
 * R2 키 마이그레이션 스크립트
 * 인코딩된 키(%EA%B0%80...)를 디코딩된 키(한글)로 변환
 */
import fetch from 'node-fetch';

const ACCOUNT_ID = '3587865378649966bfb0a814fce73c77';
const BUCKET_NAME = 'careerwiki-uploads';
const API_TOKEN = process.env.CLOUDFLARE_API_TOKEN;

if (!API_TOKEN) {
    console.error('❌ CLOUDFLARE_API_TOKEN 환경 변수가 설정되지 않았습니다.');
    process.exit(1);
}

async function listAllR2Objects() {
    let allObjects = [];
    let cursor = null;
    
    while (true) {
        const url = `https://api.cloudflare.com/client/v4/accounts/${ACCOUNT_ID}/r2/buckets/${BUCKET_NAME}/objects?limit=1000${cursor ? `&cursor=${cursor}` : ''}`;
        const res = await fetch(url, { headers: { 'Authorization': `Bearer ${API_TOKEN}` } });
        const data = await res.json();
        
        if (!data.success) {
            console.error('R2 API Error:', data.errors);
            break;
        }
        
        allObjects = allObjects.concat(data.result);
        cursor = data.result_info?.cursor;
        if (!cursor) break;
    }
    return allObjects;
}

async function getR2Object(key) {
    const url = `https://api.cloudflare.com/client/v4/accounts/${ACCOUNT_ID}/r2/buckets/${BUCKET_NAME}/objects/${encodeURIComponent(key)}`;
    const res = await fetch(url, { headers: { 'Authorization': `Bearer ${API_TOKEN}` } });
    
    if (!res.ok) return null;
    
    const buffer = await res.arrayBuffer();
    const contentType = res.headers.get('content-type') || 'application/octet-stream';
    return { data: Buffer.from(buffer), contentType };
}

async function putR2Object(key, body, contentType) {
    const url = `https://api.cloudflare.com/client/v4/accounts/${ACCOUNT_ID}/r2/buckets/${BUCKET_NAME}/objects/${encodeURIComponent(key)}`;
    const res = await fetch(url, {
        method: 'PUT',
        headers: { 
            'Authorization': `Bearer ${API_TOKEN}`,
            'Content-Type': contentType
        },
        body: body
    });
    return res.ok;
}

async function deleteR2Object(key) {
    const url = `https://api.cloudflare.com/client/v4/accounts/${ACCOUNT_ID}/r2/buckets/${BUCKET_NAME}/objects/${encodeURIComponent(key)}`;
    const res = await fetch(url, {
        method: 'DELETE',
        headers: { 'Authorization': `Bearer ${API_TOKEN}` }
    });
    return res.ok;
}

function isEncodedKey(key) {
    // %XX 패턴이 포함되어 있으면 인코딩된 키
    return /%[0-9A-Fa-f]{2}/.test(key);
}

async function main() {
    console.log('=== R2 키 마이그레이션 (인코딩 → 디코딩) ===\n');
    
    // 1. 모든 R2 객체 조회
    console.log('1️⃣  R2 객체 목록 조회 중...');
    const allObjects = await listAllR2Objects();
    console.log(`   총 ${allObjects.length}개 객체\n`);
    
    // 2. 인코딩된 키 찾기 (jobs/, majors/ 폴더만)
    const encodedKeys = allObjects.filter(obj => {
        const folder = obj.key.split('/')[0];
        return (folder === 'jobs' || folder === 'majors') && isEncodedKey(obj.key);
    });
    
    console.log(`2️⃣  인코딩된 키: ${encodedKeys.length}개`);
    
    if (encodedKeys.length === 0) {
        console.log('   ✅ 마이그레이션할 키가 없습니다.');
        return;
    }
    
    // 3. 기존 디코딩된 키 목록 (중복 체크용)
    const existingDecodedKeys = new Set(
        allObjects.map(obj => obj.key).filter(key => !isEncodedKey(key))
    );
    
    // 4. 마이그레이션 실행
    console.log('\n3️⃣  마이그레이션 시작...');
    
    let migratedCount = 0;
    let skippedCount = 0;
    let errorCount = 0;
    
    for (let i = 0; i < encodedKeys.length; i++) {
        const obj = encodedKeys[i];
        const encodedKey = obj.key;
        const decodedKey = decodeURIComponent(encodedKey);
        
        process.stdout.write(`\r[${i + 1}/${encodedKeys.length}] 처리 중...`);
        
        // 디코딩된 키가 이미 있으면 인코딩된 키만 삭제
        if (existingDecodedKeys.has(decodedKey)) {
            const deleted = await deleteR2Object(encodedKey);
            if (deleted) {
                skippedCount++;
            } else {
                errorCount++;
            }
            continue;
        }
        
        // 객체 다운로드
        const objData = await getR2Object(encodedKey);
        if (!objData) {
            console.log(`\n   ⚠️ 다운로드 실패: ${decodedKey}`);
            errorCount++;
            continue;
        }
        
        // 디코딩된 키로 업로드
        const uploaded = await putR2Object(decodedKey, objData.data, objData.contentType);
        if (!uploaded) {
            console.log(`\n   ⚠️ 업로드 실패: ${decodedKey}`);
            errorCount++;
            continue;
        }
        
        // 인코딩된 키 삭제
        const deleted = await deleteR2Object(encodedKey);
        if (deleted) {
            migratedCount++;
        } else {
            console.log(`\n   ⚠️ 삭제 실패: ${encodedKey}`);
            errorCount++;
        }
    }
    
    console.log('\n');
    console.log('=== 마이그레이션 완료 ===');
    console.log(`   마이그레이션: ${migratedCount}개`);
    console.log(`   스킵 (이미 존재): ${skippedCount}개`);
    console.log(`   오류: ${errorCount}개`);
}

main();


