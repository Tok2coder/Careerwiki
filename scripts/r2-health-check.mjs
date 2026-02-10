import fetch from 'node-fetch';
import Database from 'better-sqlite3';

const ACCOUNT_ID = '3587865378649966bfb0a814fce73c77';
const BUCKET_NAME = 'careerwiki-uploads';
const API_TOKEN = process.env.CLOUDFLARE_API_TOKEN;

const LOCAL_D1_PATH = '.wrangler/state/v3/d1/miniflare-D1DatabaseObject/926ac646196f97cbbf82a014f1749799d60a709010a65dbb289e4b2e6132a340.sqlite';

async function listAllR2Objects() {
    let allObjects = [];
    let cursor = null;
    
    while (true) {
        const url = `https://api.cloudflare.com/client/v4/accounts/${ACCOUNT_ID}/r2/buckets/${BUCKET_NAME}/objects?limit=1000${cursor ? `&cursor=${cursor}` : ''}`;
        const res = await fetch(url, { headers: { 'Authorization': `Bearer ${API_TOKEN}` } });
        const data = await res.json();
        
        if (!data.success) break;
        allObjects = allObjects.concat(data.result);
        cursor = data.result_info?.cursor;
        if (!cursor) break;
    }
    return allObjects;
}

async function main() {
    console.log('=== R2 상태 점검 ===\n');

    // 1. Production R2 객체 목록
    console.log('1️⃣ Production R2 객체 수...');
    const r2Objects = await listAllR2Objects();
    console.log(`   총: ${r2Objects.length}개\n`);

    // 폴더별 분류
    const folders = {};
    r2Objects.forEach(obj => {
        const folder = obj.key.split('/')[0] || 'root';
        folders[folder] = (folders[folder] || 0) + 1;
    });
    console.log('   폴더별 분포:');
    Object.entries(folders).sort((a, b) => b[1] - a[1]).forEach(([folder, count]) => {
        console.log(`     ${folder}: ${count}개`);
    });

    // 2. D1의 image_url과 R2 비교
    console.log('\n2️⃣ D1 jobs.image_url과 R2 비교...');
    const d1Db = new Database(LOCAL_D1_PATH, { readonly: true });
    const jobsWithImages = d1Db.prepare(`
        SELECT slug, image_url FROM jobs WHERE image_url IS NOT NULL AND image_url != ''
    `).all();
    d1Db.close();

    console.log(`   D1에 image_url 있는 jobs: ${jobsWithImages.length}개`);

    // R2 키를 디코딩된 형태와 인코딩된 형태 모두 Set에 추가
    const r2KeysDecoded = new Set();
    const r2KeysEncoded = new Set();
    r2Objects.forEach(obj => {
        r2KeysDecoded.add(obj.key);
        r2KeysEncoded.add(obj.key);
        try {
            r2KeysDecoded.add(decodeURIComponent(obj.key));
        } catch (e) {}
    });

    // 누락된 이미지 찾기
    const missingImages = [];
    jobsWithImages.forEach(job => {
        // /uploads/jobs/job-xxx.webp -> jobs/job-xxx.webp
        const r2Key = job.image_url.replace('/uploads/', '');
        const encodedKey = encodeURIComponent(r2Key.split('/').pop());
        const fullEncodedKey = `jobs/${encodedKey}`;
        
        if (!r2KeysDecoded.has(r2Key) && !r2KeysEncoded.has(fullEncodedKey)) {
            missingImages.push({ slug: job.slug, url: job.image_url });
        }
    });

    console.log(`   R2에 없는 이미지: ${missingImages.length}개`);
    if (missingImages.length > 0 && missingImages.length <= 20) {
        missingImages.forEach(m => console.log(`     - ${m.slug}: ${m.url}`));
    } else if (missingImages.length > 20) {
        missingImages.slice(0, 10).forEach(m => console.log(`     - ${m.slug}`));
        console.log(`     ... 외 ${missingImages.length - 10}개`);
    }

    // 3. HowTo 썸네일 확인
    console.log('\n3️⃣ HowTo 썸네일 확인...');
    const d1Db2 = new Database(LOCAL_D1_PATH, { readonly: true });
    const howtos = d1Db2.prepare(`
        SELECT slug, meta_data FROM pages WHERE page_type = 'guide'
    `).all();
    d1Db2.close();

    let howtoMissing = 0;
    howtos.forEach(h => {
        try {
            const meta = JSON.parse(h.meta_data || '{}');
            if (meta.thumbnailUrl) {
                const r2Key = meta.thumbnailUrl.replace('/uploads/', '').replace('http://localhost:3000/uploads/', '');
                if (!r2KeysDecoded.has(r2Key)) {
                    console.log(`     - ${h.slug}: ${meta.thumbnailUrl}`);
                    howtoMissing++;
                }
            }
        } catch (e) {}
    });
    console.log(`   HowTo 총: ${howtos.length}개, 썸네일 누락: ${howtoMissing}개`);

    // 4. 최종 요약
    console.log('\n=== 요약 ===');
    console.log(`✅ Production R2: ${r2Objects.length}개 객체`);
    console.log(`${missingImages.length === 0 ? '✅' : '⚠️'} Jobs 이미지 누락: ${missingImages.length}개`);
    console.log(`${howtoMissing === 0 ? '✅' : '⚠️'} HowTo 썸네일 누락: ${howtoMissing}개`);
}

main();


