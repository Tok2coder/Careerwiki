import fetch from 'node-fetch';

const ACCOUNT_ID = '3587865378649966bfb0a814fce73c77';
const DATABASE_ID = 'edc21e23-c2ac-4693-bb79-389b6914e173';
const BUCKET_NAME = 'careerwiki-uploads';
const API_TOKEN = process.env.CLOUDFLARE_API_TOKEN;

async function queryD1(sql) {
    const res = await fetch(`https://api.cloudflare.com/client/v4/accounts/${ACCOUNT_ID}/d1/database/${DATABASE_ID}/query`, {
        method: 'POST',
        headers: { 'Authorization': `Bearer ${API_TOKEN}`, 'Content-Type': 'application/json' },
        body: JSON.stringify({ sql })
    });
    const data = await res.json();
    return data.result?.[0]?.results || [];
}

async function listR2(prefix = '', limit = 100) {
    const url = `https://api.cloudflare.com/client/v4/accounts/${ACCOUNT_ID}/r2/buckets/${BUCKET_NAME}/objects?limit=${limit}${prefix ? `&prefix=${prefix}` : ''}`;
    const res = await fetch(url, { headers: { 'Authorization': `Bearer ${API_TOKEN}` } });
    const data = await res.json();
    return data.result || [];
}

async function main() {
    console.log('╔════════════════════════════════════════╗');
    console.log('║   R2/D1 네이밍 규칙 분석               ║');
    console.log('╚════════════════════════════════════════╝\n');

    // 1. R2 키 구조 분석
    console.log('=== R2 키 구조 분석 ===\n');
    
    const jobsKeys = await listR2('jobs/', 20);
    const majorsKeys = await listR2('majors/', 20);
    const howtoKeys = await listR2('howto/', 20);
    
    console.log('📁 jobs/ 폴더 샘플:');
    jobsKeys.slice(0, 5).forEach(o => console.log(`   ${o.key}`));
    
    console.log('\n📁 majors/ 폴더 샘플:');
    majorsKeys.slice(0, 5).forEach(o => console.log(`   ${o.key}`));
    
    console.log('\n📁 howto/ 폴더 샘플:');
    howtoKeys.slice(0, 5).forEach(o => console.log(`   ${o.key}`));

    // 2. D1 테이블 구조
    console.log('\n\n=== D1 테이블 구조 ===\n');
    
    const tables = await queryD1("SELECT name FROM sqlite_master WHERE type='table' ORDER BY name");
    console.log('테이블 목록:');
    tables.forEach(t => console.log(`   - ${t.name}`));

    // 3. slug 패턴 분석
    console.log('\n\n=== Slug 패턴 분석 ===\n');
    
    const jobSlugs = await queryD1('SELECT slug FROM jobs LIMIT 10');
    console.log('Jobs slug 샘플:');
    jobSlugs.forEach(j => console.log(`   ${j.slug}`));
    
    const majorSlugs = await queryD1('SELECT slug FROM majors LIMIT 10');
    console.log('\nMajors slug 샘플:');
    majorSlugs.forEach(m => console.log(`   ${m.slug}`));
    
    const pageSlugs = await queryD1("SELECT slug, page_type FROM pages LIMIT 10");
    console.log('\nPages slug 샘플:');
    pageSlugs.forEach(p => console.log(`   [${p.page_type}] ${p.slug}`));

    // 4. image_url 패턴 분석
    console.log('\n\n=== Image URL 패턴 분석 ===\n');
    
    const jobImages = await queryD1('SELECT slug, image_url FROM jobs WHERE image_url IS NOT NULL LIMIT 5');
    console.log('Jobs image_url 샘플:');
    jobImages.forEach(j => console.log(`   ${j.slug}\n   → ${j.image_url}\n`));
    
    const majorImages = await queryD1('SELECT slug, image_url FROM majors WHERE image_url IS NOT NULL LIMIT 5');
    console.log('Majors image_url 샘플:');
    majorImages.forEach(m => console.log(`   ${m.slug}\n   → ${m.image_url}\n`));

    // 5. 패턴 일관성 체크
    console.log('\n=== 패턴 일관성 체크 ===\n');
    
    // R2 키와 slug 매칭 확인
    const allJobImages = await queryD1('SELECT slug, image_url FROM jobs WHERE image_url IS NOT NULL');
    let mismatchCount = 0;
    let queryStringCount = 0;
    let localhostCount = 0;
    
    for (const job of allJobImages) {
        if (!job.image_url) continue;
        
        // 쿼리스트링 체크
        if (job.image_url.includes('?')) queryStringCount++;
        
        // localhost 체크
        if (job.image_url.includes('localhost')) localhostCount++;
        
        // slug와 파일명 매칭 체크
        const expectedKey = `jobs/job-${job.slug}.webp`;
        if (!job.image_url.includes(job.slug)) mismatchCount++;
    }
    
    console.log(`총 job 이미지: ${allJobImages.length}개`);
    console.log(`쿼리스트링 포함: ${queryStringCount}개`);
    console.log(`localhost URL: ${localhostCount}개`);
    console.log(`slug 불일치: ${mismatchCount}개`);

    console.log('\n════════════════════════════════════════');
}

main().catch(e => console.error('Error:', e.message));


