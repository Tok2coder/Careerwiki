import type { D1Database } from '@cloudflare/workers-types'
import { resolve, dirname } from 'path'
import { fileURLToPath } from 'url'
import { Miniflare } from 'miniflare'

async function main() {
  const __filename = fileURLToPath(import.meta.url)
  const projectRoot = resolve(dirname(__filename), '..')

  const mf = new Miniflare({
    modules: true,
    script: '',
    d1Databases: {
      DB: 'edc21e23-c2ac-4693-bb79-389b6914e173'
    },
    d1Persist: resolve(projectRoot, '.wrangler', 'state', 'v3', 'd1')
  })

  const db = (await mf.getD1Database('DB')) as unknown as D1Database

  // ISR 캐시 삭제
  const deleted = await db.prepare(`
    DELETE FROM wiki_pages 
    WHERE page_type = 'job' 
    AND slug IN ('신호원 및 수송원', '기업고위임원', '변호사')
  `).run()

  console.log(`✅ ISR 캐시 삭제 완료: ${deleted.meta?.changes || 0}개 레코드`)
  
  // 남은 job 캐시 확인
  const remaining = await db.prepare(`
    SELECT COUNT(*) as count FROM wiki_pages WHERE page_type = 'job'
  `).first()
  
  console.log(`📊 남은 직업 페이지 캐시: ${(remaining as any)?.count || 0}개`)
}

main().catch(console.error)
