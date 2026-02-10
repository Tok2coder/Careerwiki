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

async function main() {
    console.log('R2 상태 확인 중...\n');
    const objects = await listAll();
    
    // 폴더별 카운트
    const folders = { jobs: 0, majors: 0, howto: 0, other: 0 };
    const encodedCount = { jobs: 0, majors: 0 };
    const decodedCount = { jobs: 0, majors: 0 };
    
    objects.forEach(o => {
        const folder = o.key.split('/')[0];
        if (folder === 'jobs') {
            folders.jobs++;
            if (/%[0-9A-Fa-f]{2}/.test(o.key)) encodedCount.jobs++;
            else decodedCount.jobs++;
        } else if (folder === 'majors') {
            folders.majors++;
            if (/%[0-9A-Fa-f]{2}/.test(o.key)) encodedCount.majors++;
            else decodedCount.majors++;
        } else if (folder === 'howto') {
            folders.howto++;
        } else {
            folders.other++;
        }
    });
    
    // 중복 확인 (디코딩 후 같은 이름)
    const decodedKeys = new Map();
    let duplicates = 0;
    objects.forEach(o => {
        const decoded = decodeURIComponent(o.key);
        if (decodedKeys.has(decoded)) {
            duplicates++;
        } else {
            decodedKeys.set(decoded, o.key);
        }
    });
    
    console.log('=== R2 현재 상태 ===');
    console.log(`총 객체: ${objects.length}개`);
    console.log(`\n폴더별:`);
    console.log(`  jobs/: ${folders.jobs}개 (인코딩: ${encodedCount.jobs}, 한글: ${decodedCount.jobs})`);
    console.log(`  majors/: ${folders.majors}개 (인코딩: ${encodedCount.majors}, 한글: ${decodedCount.majors})`);
    console.log(`  howto/: ${folders.howto}개`);
    console.log(`  기타: ${folders.other}개`);
    console.log(`\n중복 (같은 이름, 다른 인코딩): ${duplicates}개`);
    
    if (duplicates > 0) {
        console.log('\n⚠️ 중복 정리 필요!');
    } else {
        console.log('\n✅ 중복 없음');
    }
}

main();


