/**
 * Local ETL Runner using Miniflare
 * Miniflare를 사용하여 로컬 D1에 직접 접근하는 Node 실행 가능 스크립트
 */

import { Miniflare } from 'miniflare'
import * as fs from 'fs'
import * as path from 'path'
import { fileURLToPath } from 'url'

const __filename = fileURLToPath(import.meta.url)
const __dirname = path.dirname(__filename)

// CSV 파싱
function parseCSV(filePath: string): any[] {
  const content = fs.readFileSync(filePath, 'utf-8')
  const lines = content.split('\n')
  const rows: any[] = []
  
  for (let i = 3; i < lines.length; i++) {
    const line = lines[i].trim()
    if (!line) continue
    
    const parts = line.split(',').map(p => p.trim())
    if (parts.length < 11) continue
    
    const [
      largeClassCd, mediumClassCd, smallClassCd,
      dJobCd, dJobCdSeq,
      largeClassNm, mediumClassNm, smallClassNm,
      jobNm, relatedJob, similarJobNm
    ] = parts
    
    if (!dJobCd || !jobNm || !dJobCdSeq) continue
    
    rows.push({
      largeClassCd, mediumClassCd, smallClassCd,
      dJobCd, dJobCdSeq,
      largeClassNm, mediumClassNm, smallClassNm,
      jobNm, relatedJob, similarJobNm
    })
  }
  
  return rows
}

async function main() {
  console.log('🚀 Starting Local ETL...')
  
  // Miniflare 초기화
  const mf = new Miniflare({
    modules: true,
    scriptPath: './dist/_worker.js',
    d1Databases: {
      DB: 'edc21e23-c2ac-4693-bb79-389b6914e173'
    },
    d1Persist: '.wrangler/state/v3/d1'
  })
  
  const db = await mf.getD1Database('DB')
  
  console.log('\n📋 STEP 1: Loading Job Dictionary Index...')
  const csvPath = path.join(process.cwd(), 'docs', '직업사전_세세분류_코드.csv')
  const rows = parseCSV(csvPath)
  console.log(`  Parsed ${rows.length} entries`)
  
  let loaded = 0
  let skipped = 0
  const now = Date.now()
  
  for (const row of rows) {
    try {
      const existing = await db.prepare(`
        SELECT id FROM job_dictionary_index 
        WHERE d_job_cd = ? AND d_job_cd_seq = ?
      `).bind(row.dJobCd, row.dJobCdSeq).first()
      
      if (existing) {
        skipped++
        continue
      }
      
      await db.prepare(`
        INSERT INTO job_dictionary_index (
          d_job_cd, d_job_cd_seq,
          large_class_cd, medium_class_cd, small_class_cd,
          large_class_nm, medium_class_nm, small_class_nm,
          job_nm, related_job, similar_job_nm,
          is_seeded, created_at
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 0, ?)
      `).bind(
        row.dJobCd, row.dJobCdSeq,
        row.largeClassCd || null, row.mediumClassCd || null, row.smallClassCd || null,
        row.largeClassNm || null, row.mediumClassNm || null, row.smallClassNm || null,
        row.jobNm, row.relatedJob || null, row.similarJobNm || null,
        now
      ).run()
      
      loaded++
      
      if (loaded % 500 === 0) {
        console.log(`  ✅ Loaded ${loaded}/${rows.length}`)
      }
    } catch (error) {
      console.error(`  ❌ Error loading ${row.jobNm}:`, error)
    }
  }
  
  console.log(`\n✅ Job Dictionary Index Complete`)
  console.log(`   Loaded: ${loaded}`)
  console.log(`   Skipped: ${skipped}`)
  
  // 확인
  const count = await db.prepare(`SELECT COUNT(*) as count FROM job_dictionary_index`).first()
  console.log(`   Total in DB: ${count.count}`)
  
  await mf.dispose()
  
  console.log('\n🎉 ETL Step 1 Complete!')
  console.log('\n다음 단계:')
  console.log('2. npm run dev (개발 서버 시작)')
  console.log('3. 브라우저에서 http://localhost:3000/api/admin/seed-jobs 호출')
}

main().catch(console.error)

