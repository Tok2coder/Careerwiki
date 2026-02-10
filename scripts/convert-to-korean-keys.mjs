import fetch from 'node-fetch';

const ACCOUNT_ID = '3587865378649966bfb0a814fce73c77';
const BUCKET_NAME = 'careerwiki-uploads';
const API_TOKEN = process.env.CLOUDFLARE_API_TOKEN;
const CONCURRENCY = 10; // 동시 처리 수

const delay = (ms) => new Promise(r => setTimeout(r, ms));

async function retry(fn, maxRetries = 3) {
    for (let i = 0; i < maxRetries; i++) {
        try {
            return await fn();
        } catch (e) {
            if (i === maxRetries - 1) throw e;
            await delay(500 * (i + 1));
        }
    }
}

async function listAll() {
    let all = [];
    let cursor = null;
    process.stdout.write('객체 목록 조회 중...');
    while (true) {
        const url = `https://api.cloudflare.com/client/v4/accounts/${ACCOUNT_ID}/r2/buckets/${BUCKET_NAME}/objects?limit=1000${cursor ? `&cursor=${cursor}` : ''}`;
        const res = await retry(() => fetch(url, { headers: { 'Authorization': `Bearer ${API_TOKEN}` } }));
        const data = await res.json();
        if (!data.success) break;
        all = all.concat(data.result);
        cursor = data.result_info?.cursor;
        process.stdout.write(`\r객체 목록 조회 중... ${all.length}개`);
        if (!cursor) break;
    }
    console.log('');
    return all;
}

async function getObject(key) {
    const url = `https://api.cloudflare.com/client/v4/accounts/${ACCOUNT_ID}/r2/buckets/${BUCKET_NAME}/objects/${encodeURIComponent(key)}`;
    const res = await retry(() => fetch(url, { headers: { 'Authorization': `Bearer ${API_TOKEN}` }, timeout: 30000 }));
    if (!res.ok) return null;
    return { data: Buffer.from(await res.arrayBuffer()), contentType: res.headers.get('content-type') || 'application/octet-stream' };
}

async function putObject(key, body, contentType) {
    const url = `https://api.cloudflare.com/client/v4/accounts/${ACCOUNT_ID}/r2/buckets/${BUCKET_NAME}/objects/${encodeURIComponent(key)}`;
    const res = await retry(() => fetch(url, { method: 'PUT', headers: { 'Authorization': `Bearer ${API_TOKEN}`, 'Content-Type': contentType }, body, timeout: 30000 }));
    return res.ok;
}

async function deleteObject(key) {
    const url = `https://api.cloudflare.com/client/v4/accounts/${ACCOUNT_ID}/r2/buckets/${BUCKET_NAME}/objects/${encodeURIComponent(key)}`;
    const res = await retry(() => fetch(url, { method: 'DELETE', headers: { 'Authorization': `Bearer ${API_TOKEN}` }, timeout: 10000 }));
    return res.ok;
}

function isEncoded(key) {
    return /%[0-9A-Fa-f]{2}/.test(key);
}

async function processOne(obj, allKeys) {
    const decodedKey = decodeURIComponent(obj.key);
    
    try {
        // 이미 한글 키 존재하면 인코딩 키만 삭제
        if (allKeys.has(decodedKey)) {
            await deleteObject(obj.key);
            return 'skipped';
        }
        
        // 다운로드
        const data = await getObject(obj.key);
        if (!data) return 'failed';
        
        // 한글 키로 업로드
        const uploaded = await putObject(decodedKey, data.data, data.contentType);
        if (!uploaded) return 'failed';
        
        // 인코딩 키 삭제
        await deleteObject(obj.key);
        return 'converted';
    } catch (e) {
        return 'failed';
    }
}

async function main() {
    console.log('=== R2 키 한글 변환 (병렬) ===\n');
    
    const objects = await listAll();
    const allKeys = new Set(objects.map(o => o.key));
    
    const encodedKeys = objects.filter(o => {
        const folder = o.key.split('/')[0];
        return (folder === 'jobs' || folder === 'majors') && isEncoded(o.key);
    });
    
    console.log(`남은 변환 대상: ${encodedKeys.length}개 (동시처리: ${CONCURRENCY}개)\n`);
    
    if (encodedKeys.length === 0) {
        console.log('✅ 모든 키가 이미 한글로 변환되었습니다.');
        return;
    }
    
    let converted = 0, skipped = 0, failed = 0, processed = 0;
    
    // 배치 처리
    for (let i = 0; i < encodedKeys.length; i += CONCURRENCY) {
        const batch = encodedKeys.slice(i, i + CONCURRENCY);
        const results = await Promise.all(batch.map(obj => processOne(obj, allKeys)));
        
        for (const r of results) {
            if (r === 'converted') converted++;
            else if (r === 'skipped') skipped++;
            else failed++;
        }
        processed += batch.length;
        
        process.stdout.write(`\r[${processed}/${encodedKeys.length}] 변환: ${converted}, 스킵: ${skipped}, 실패: ${failed}  `);
    }
    
    console.log(`\n\n✅ 완료`);
    console.log(`   변환: ${converted}개`);
    console.log(`   스킵: ${skipped}개`);
    console.log(`   실패: ${failed}개`);
}

main().catch(e => console.error('오류:', e.message));
