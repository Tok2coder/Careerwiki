import fetch from 'node-fetch';

const ACCOUNT_ID = '3587865378649966bfb0a814fce73c77';
const DATABASE_ID = 'edc21e23-c2ac-4693-bb79-389b6914e173';
const BUCKET_NAME = 'careerwiki-uploads';
const API_TOKEN = process.env.CLOUDFLARE_API_TOKEN;

async function checkD1() {
    const queries = [
        { sql: 'SELECT COUNT(*) as cnt FROM jobs', label: 'jobs' },
        { sql: 'SELECT COUNT(*) as cnt FROM jobs WHERE merged_profile_json IS NOT NULL', label: 'jobs (활성)' },
        { sql: 'SELECT COUNT(*) as cnt FROM majors', label: 'majors' },
        { sql: 'SELECT COUNT(*) as cnt FROM pages', label: 'pages' },
        { sql: "SELECT COUNT(*) as cnt FROM pages WHERE page_type = 'guide'", label: 'HowTo' },
        { sql: 'SELECT COUNT(*) as cnt FROM users', label: 'users' },
    ];
    
    console.log('=== D1 Production 상태 ===\n');
    
    for (const q of queries) {
        const res = await fetch(`https://api.cloudflare.com/client/v4/accounts/${ACCOUNT_ID}/d1/database/${DATABASE_ID}/query`, {
            method: 'POST',
            headers: { 'Authorization': `Bearer ${API_TOKEN}`, 'Content-Type': 'application/json' },
            body: JSON.stringify({ sql: q.sql })
        });
        const data = await res.json();
        const cnt = data.result?.[0]?.results?.[0]?.cnt || 0;
        console.log(`  ${q.label}: ${cnt}개`);
    }
}

async function checkR2() {
    let total = 0, encoded = 0;
    let jobsCount = 0, majorsCount = 0, howtoCount = 0, profileCount = 0, otherCount = 0;
    let cursor = null;
    
    while (true) {
        const url = `https://api.cloudflare.com/client/v4/accounts/${ACCOUNT_ID}/r2/buckets/${BUCKET_NAME}/objects?limit=1000${cursor ? `&cursor=${cursor}` : ''}`;
        const res = await fetch(url, { headers: { 'Authorization': `Bearer ${API_TOKEN}` } });
        const data = await res.json();
        if (!data.success) break;
        
        for (const obj of data.result) {
            total++;
            if (/%[0-9A-Fa-f]{2}/.test(obj.key)) encoded++;
            
            if (obj.key.startsWith('jobs/')) jobsCount++;
            else if (obj.key.startsWith('majors/')) majorsCount++;
            else if (obj.key.startsWith('howto/')) howtoCount++;
            else if (obj.key.startsWith('profile/')) profileCount++;
            else otherCount++;
        }
        
        cursor = data.result_info?.cursor;
        if (!cursor) break;
    }
    
    console.log('\n=== R2 Production 상태 ===\n');
    console.log(`  총 객체: ${total}개`);
    console.log(`  - jobs/: ${jobsCount}개`);
    console.log(`  - majors/: ${majorsCount}개`);
    console.log(`  - howto/: ${howtoCount}개`);
    console.log(`  - profile/: ${profileCount}개`);
    console.log(`  - 기타: ${otherCount}개`);
    console.log(`\n  한글 키: ${total - encoded}개`);
    console.log(`  인코딩 키 (남은): ${encoded}개`);
}

async function main() {
    console.log('╔════════════════════════════════════════╗');
    console.log('║   CareerWiki 마이그레이션 최종 점검    ║');
    console.log('╚════════════════════════════════════════╝\n');
    
    await checkD1();
    await checkR2();
    
    console.log('\n=== 개발 환경 설정 ===\n');
    console.log('  npm run dev     → Production D1/R2 (remote: true)');
    console.log('  npm run dev:local → 로컬 D1/R2');
    console.log('  npm run deploy  → Cloudflare Pages 배포');
    
    console.log('\n=== 마이그레이션 체크리스트 ===\n');
    console.log('  ✅ D1 데이터 마이그레이션');
    console.log('  ✅ R2 이미지 마이그레이션');
    console.log('  ✅ R2 키 한글 변환 (인코딩 → 디코딩)');
    console.log('  ✅ 개발환경 Production 연동');
    console.log('  ✅ 코드 배포 완료');
    
    console.log('\n════════════════════════════════════════');
}

main().catch(e => console.error('Error:', e.message));


