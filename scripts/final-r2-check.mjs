import fetch from 'node-fetch';
import Database from 'better-sqlite3';

const ACCOUNT_ID = '3587865378649966bfb0a814fce73c77';
const BUCKET_NAME = 'careerwiki-uploads';
const API_TOKEN = process.env.CLOUDFLARE_API_TOKEN;
const LOCAL_D1_PATH = '.wrangler/state/v3/d1/miniflare-D1DatabaseObject/926ac646196f97cbbf82a014f1749799d60a709010a65dbb289e4b2e6132a340.sqlite';

async function listAllR2Objects() {
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
    console.log('╔═══════════════════════════════════════════╗');
    console.log('║        R2 최종 상태 점검                   ║');
    console.log('╚═══════════════════════════════════════════╝\n');

    // 1. R2 객체 목록
    const r2Objects = await listAllR2Objects();
    
    // 디코딩된 키 맵 생성
    const r2DecodedKeys = new Map();
    r2Objects.forEach(obj => {
        const decoded = decodeURIComponent(obj.key);
        r2DecodedKeys.set(decoded, obj);
        r2DecodedKeys.set(obj.key, obj); // 원본도 추가
    });

    console.log('1️⃣  Production R2 현황');
    console.log('─'.repeat(45));
    
    const folders = {};
    r2Objects.forEach(obj => {
        const folder = obj.key.split('/')[0] || 'root';
        folders[folder] = (folders[folder] || 0) + 1;
    });
    
    Object.entries(folders).sort((a, b) => b[1] - a[1]).forEach(([folder, count]) => {
        console.log(`   ${folder.padEnd(15)} ${count.toString().padStart(6)}개`);
    });
    console.log('─'.repeat(45));
    console.log(`   총계              ${r2Objects.length.toString().padStart(6)}개\n`);

    // 2. D1 jobs와 비교
    const d1Db = new Database(LOCAL_D1_PATH, { readonly: true });
    
    const jobsWithImages = d1Db.prepare(`
        SELECT slug, image_url FROM jobs WHERE image_url IS NOT NULL AND image_url != ''
    `).all();
    
    let jobsMissing = [];
    jobsWithImages.forEach(job => {
        // /uploads/jobs/job-xxx.webp -> jobs/job-xxx.webp
        const r2Key = job.image_url.replace('/uploads/', '');
        // 디코딩된 형태로 비교
        const decodedKey = decodeURIComponent(r2Key);
        
        if (!r2DecodedKeys.has(decodedKey) && !r2DecodedKeys.has(r2Key)) {
            jobsMissing.push(job.slug);
        }
    });

    console.log('2️⃣  Jobs 이미지 상태');
    console.log('─'.repeat(45));
    console.log(`   DB에 image_url 있음    ${jobsWithImages.length.toString().padStart(6)}개`);
    console.log(`   R2에 존재              ${(jobsWithImages.length - jobsMissing.length).toString().padStart(6)}개`);
    console.log(`   R2에 누락              ${jobsMissing.length.toString().padStart(6)}개`);
    
    if (jobsMissing.length > 0) {
        console.log('\n   ⚠️ 누락된 직업 (처음 10개):');
        jobsMissing.slice(0, 10).forEach(slug => console.log(`      - ${slug}`));
        if (jobsMissing.length > 10) console.log(`      ... 외 ${jobsMissing.length - 10}개`);
    }
    console.log('');

    // 3. HowTo 썸네일 상태
    const howtos = d1Db.prepare(`
        SELECT slug, meta_data FROM pages WHERE page_type = 'guide' AND source = 'user'
    `).all();
    
    let howtoOk = 0;
    let howtoMissing = [];
    
    howtos.forEach(h => {
        try {
            const meta = JSON.parse(h.meta_data || '{}');
            if (meta.thumbnailUrl) {
                // localhost 제거
                let r2Key = meta.thumbnailUrl
                    .replace('http://localhost:3000/uploads/', '')
                    .replace('/uploads/', '');
                
                if (r2DecodedKeys.has(r2Key)) {
                    howtoOk++;
                } else {
                    howtoMissing.push({ slug: h.slug, url: meta.thumbnailUrl });
                }
            }
        } catch (e) {}
    });
    
    d1Db.close();

    console.log('3️⃣  HowTo 썸네일 상태');
    console.log('─'.repeat(45));
    console.log(`   총 HowTo 수             ${howtos.length.toString().padStart(6)}개`);
    console.log(`   썸네일 정상             ${howtoOk.toString().padStart(6)}개`);
    console.log(`   썸네일 누락             ${howtoMissing.length.toString().padStart(6)}개`);
    
    if (howtoMissing.length > 0) {
        console.log('\n   ⚠️ 누락된 HowTo 썸네일:');
        howtoMissing.forEach(h => {
            console.log(`      - ${h.slug}`);
            console.log(`        URL: ${h.url}`);
        });
    }
    console.log('');

    // 4. 최종 요약
    console.log('═'.repeat(45));
    console.log('📊 최종 요약');
    console.log('═'.repeat(45));
    
    const allOk = jobsMissing.length === 0 && howtoMissing.length === 0;
    
    if (allOk) {
        console.log('✅ 모든 이미지가 R2에 존재합니다!');
    } else {
        console.log(`⚠️ 누락된 이미지:`);
        console.log(`   - Jobs: ${jobsMissing.length}개 (재생성 필요)`);
        console.log(`   - HowTo: ${howtoMissing.length}개 (썸네일 재업로드 필요)`);
        
        if (jobsMissing.length > 0) {
            console.log('\n💡 Jobs 이미지 복구 방법:');
            console.log('   관리자 페이지에서 이미지 재생성 또는');
            console.log('   /api/image/generate 엔드포인트 사용');
        }
        
        if (howtoMissing.length > 0) {
            console.log('\n💡 HowTo 썸네일 복구 방법:');
            console.log('   HowTo 편집 페이지에서 썸네일 재업로드');
        }
    }
}

main();


