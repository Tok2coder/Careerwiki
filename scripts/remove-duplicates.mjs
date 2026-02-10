import fetch from 'node-fetch';

const ACCOUNT_ID = '3587865378649966bfb0a814fce73c77';
const BUCKET_NAME = 'careerwiki-uploads';
const API_TOKEN = process.env.CLOUDFLARE_API_TOKEN;

async function listAll() {
    let all = [];
    let cursor = null;
    while (true) {
        const url = `https://api.cloudflare.com/client/v4/accounts/${ACCOUNT_ID}/r2/buckets/${BUCKET_NAME}/objects?limit=1000${cursor ? `&cursor=${cursor}` : ''}`;
        const res = await fetch(url, { headers: { 'Authorization': `Bearer ${API_TOKEN}` } });
        const data = await res.json();
        if (!data.success) break;
        all = all.concat(data.result);
        cursor = data.result_info?.cursor;
        if (!cursor) break;
    }
    return all;
}

async function deleteR2(key) {
    const url = `https://api.cloudflare.com/client/v4/accounts/${ACCOUNT_ID}/r2/buckets/${BUCKET_NAME}/objects/${encodeURIComponent(key)}`;
    const res = await fetch(url, { method: 'DELETE', headers: { 'Authorization': `Bearer ${API_TOKEN}` } });
    return res.ok;
}

async function main() {
    console.log('=== 중복 이미지 정리 ===\n');
    
    const objects = await listAll();
    console.log(`총 객체: ${objects.length}개`);
    
    // 디코딩된 키로 그룹화
    const groups = new Map();
    objects.forEach(o => {
        const decoded = decodeURIComponent(o.key);
        if (!groups.has(decoded)) {
            groups.set(decoded, []);
        }
        groups.get(decoded).push(o.key);
    });
    
    // 중복 찾기 (같은 디코딩된 이름으로 2개 이상)
    const toDelete = [];
    groups.forEach((keys, decoded) => {
        if (keys.length > 1) {
            // 한글(디코딩된) 키 유지, 인코딩된 키 삭제
            keys.forEach(key => {
                if (key !== decoded) { // 인코딩된 키
                    toDelete.push(key);
                }
            });
        }
    });
    
    console.log(`중복으로 인해 삭제할 키: ${toDelete.length}개\n`);
    
    if (toDelete.length === 0) {
        console.log('✅ 삭제할 중복이 없습니다.');
        return;
    }
    
    // 삭제 실행
    let deleted = 0;
    for (let i = 0; i < toDelete.length; i++) {
        const ok = await deleteR2(toDelete[i]);
        if (ok) deleted++;
        process.stdout.write(`\r[${i + 1}/${toDelete.length}] ${deleted} 삭제`);
    }
    
    console.log('\n\n✅ 완료: ' + deleted + '개 삭제');
}

main();


