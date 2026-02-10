import fetch from 'node-fetch';

const ACCOUNT_ID = '3587865378649966bfb0a814fce73c77';
const DATABASE_ID = 'edc21e23-c2ac-4693-bb79-389b6914e173';
const API_TOKEN = process.env.CLOUDFLARE_API_TOKEN;

async function queryD1(sql, params = []) {
    const res = await fetch(`https://api.cloudflare.com/client/v4/accounts/${ACCOUNT_ID}/d1/database/${DATABASE_ID}/query`, {
        method: 'POST',
        headers: { 'Authorization': `Bearer ${API_TOKEN}`, 'Content-Type': 'application/json' },
        body: JSON.stringify({ sql, params })
    });
    const data = await res.json();
    if (!data.success) throw new Error(data.errors?.[0]?.message || 'D1 error');
    return data.result?.[0]?.results || [];
}

async function main() {
    console.log('=== Pages 테이블 정리 ===\n');
    
    // 1. 불필요한 영문 샘플 데이터 확인
    const kebabPages = await queryD1(`
        SELECT id, slug, page_type, title, source 
        FROM pages 
        WHERE slug NOT LIKE '%:%' 
          AND slug LIKE '%-%'
    `);
    
    console.log(`영문 케밥케이스 페이지: ${kebabPages.length}개\n`);
    
    for (const page of kebabPages) {
        console.log(`  [${page.page_type}] ${page.slug}`);
        console.log(`    title: ${page.title || '(없음)'}`);
        console.log(`    source: ${page.source || '(없음)'}\n`);
    }
    
    if (kebabPages.length === 0) {
        console.log('삭제할 페이지가 없습니다.');
        return;
    }
    
    // 2. 삭제 실행
    console.log('삭제 진행 중...\n');
    
    for (const page of kebabPages) {
        // 관련 댓글 먼저 확인
        const comments = await queryD1('SELECT COUNT(*) as cnt FROM comments WHERE page_id = ?', [page.id]);
        const commentCount = comments[0]?.cnt || 0;
        
        if (commentCount > 0) {
            console.log(`  ⚠️ ${page.slug}: 댓글 ${commentCount}개 있음 - 스킵`);
            continue;
        }
        
        // 삭제
        await queryD1('DELETE FROM pages WHERE id = ?', [page.id]);
        console.log(`  ✅ ${page.slug} 삭제 완료`);
    }
    
    console.log('\n✅ Pages 정리 완료');
}

main().catch(e => console.error('Error:', e.message));


