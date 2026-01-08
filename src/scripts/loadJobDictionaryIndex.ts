/**
 * Load Job Dictionary Index from CSV
 * 직업사전_세세분류_코드.csv 파일을 파싱하여 job_dictionary_index 테이블에 로드
 */

import type { D1Database } from '@cloudflare/workers-types'
import * as fs from 'fs'
import * as path from 'path'
import { Miniflare } from 'miniflare'
import * as dotenv from 'dotenv'

interface JobDictionaryRow {
  largeClassCd: string
  mediumClassCd: string
  smallClassCd: string
  dJobCd: string
  dJobCdSeq: string
  largeClassNm: string
  mediumClassNm: string
  smallClassNm: string
  jobNm: string
  relatedJob: string
  similarJobNm: string
}

interface LoadProgress {
  total: number
  loaded: number
  skipped: number
  errors: number
  errorDetails: Array<{ row: number; error: string }>
}

/**
 * Parse CSV file
 */
function parseCSV(filePath: string): JobDictionaryRow[] {
  const content = fs.readFileSync(filePath, 'utf-8')
  const lines = content.split('\n')
  
  const rows: JobDictionaryRow[] = []
  
  // Skip first 2 lines (title and empty line)
  // Line 3 is header
  const headerLine = lines[2]
  
  // Start from line 4 (index 3)
  for (let i = 3; i < lines.length; i++) {
    const line = lines[i].trim()
    if (!line) continue
    
    // CSV parsing with comma delimiter
    const parts = line.split(',').map(p => p.trim())
    
    if (parts.length < 11) continue
    
    const [
      largeClassCd,
      mediumClassCd,
      smallClassCd,
      dJobCd,
      dJobCdSeq,
      largeClassNm,
      mediumClassNm,
      smallClassNm,
      jobNm,
      relatedJob,
      similarJobNm
    ] = parts
    
    // Skip if no job code or no job name
    if (!dJobCd || !jobNm) continue
    
    // Skip if it's a classification header row (no sequence number)
    if (!dJobCdSeq) continue
    
    rows.push({
      largeClassCd,
      mediumClassCd,
      smallClassCd,
      dJobCd,
      dJobCdSeq,
      largeClassNm,
      mediumClassNm,
      smallClassNm,
      jobNm,
      relatedJob,
      similarJobNm
    })
  }
  
  return rows
}

/**
 * Load job dictionary index into D1
 */
export async function loadJobDictionaryIndex(
  db: D1Database,
  csvFilePath?: string
): Promise<LoadProgress> {
  console.log('🔨 Loading Job Dictionary Index from CSV...')
  
  const progress: LoadProgress = {
    total: 0,
    loaded: 0,
    skipped: 0,
    errors: 0,
    errorDetails: []
  }
  
  // Default CSV path
  const filePath = csvFilePath || path.join(process.cwd(), 'docs', '직업사전_세세분류_코드.csv')
  
  console.log(`📂 Reading file: ${filePath}`)
  
  // Check if file exists
  if (!fs.existsSync(filePath)) {
    throw new Error(`CSV file not found: ${filePath}`)
  }
  
  // Parse CSV
  const rows = parseCSV(filePath)
  progress.total = rows.length
  
  console.log(`📊 Parsed ${rows.length} job dictionary entries`)
  
  // Load into D1
  const now = Date.now()
  
  for (let i = 0; i < rows.length; i++) {
    const row = rows[i]
    
    try {
      // Check if already exists
      const existing = await db.prepare(`
        SELECT id FROM job_dictionary_index 
        WHERE d_job_cd = ? AND d_job_cd_seq = ?
      `).bind(row.dJobCd, row.dJobCdSeq).first()
      
      if (existing) {
        progress.skipped++
        continue
      }
      
      // Insert
      await db.prepare(`
        INSERT INTO job_dictionary_index (
          d_job_cd, d_job_cd_seq,
          large_class_cd, medium_class_cd, small_class_cd,
          large_class_nm, medium_class_nm, small_class_nm,
          job_nm, related_job, similar_job_nm,
          is_seeded, created_at
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 0, ?)
      `).bind(
        row.dJobCd,
        row.dJobCdSeq,
        row.largeClassCd || null,
        row.mediumClassCd || null,
        row.smallClassCd || null,
        row.largeClassNm || null,
        row.mediumClassNm || null,
        row.smallClassNm || null,
        row.jobNm,
        row.relatedJob || null,
        row.similarJobNm || null,
        now
      ).run()
      
      progress.loaded++
      
      // Progress every 100 rows
      if ((i + 1) % 100 === 0) {
        console.log(`  ✅ Loaded ${progress.loaded}/${progress.total} (${Math.round((i + 1) / progress.total * 100)}%)`)
      }
      
    } catch (error) {
      progress.errors++
      progress.errorDetails.push({
        row: i + 4,  // CSV line number (3 header lines + 1-indexed)
        error: error instanceof Error ? error.message : String(error)
      })
      
      if (progress.errors <= 10) {
        console.error(`  ❌ Row ${i + 4}: ${row.jobNm} - ${error}`)
      }
    }
  }
  
  console.log('\n✅ Job Dictionary Index Loading Complete')
  console.log(`   Total: ${progress.total}`)
  console.log(`   Loaded: ${progress.loaded}`)
  console.log(`   Skipped: ${progress.skipped}`)
  console.log(`   Errors: ${progress.errors}`)
  
  return progress
}

/**
 * Initialize Miniflare with D1 binding
 */
async function initMiniflare(): Promise<{ mf: Miniflare; db: D1Database }> {
  // Load environment variables
  dotenv.config({ path: '.dev.vars' })
  
  const mf = new Miniflare({
    modules: true,
    script: '',
    // 로컬 D1 바인딩 (Wrangler와 동일한 DB ID 사용)
    d1Databases: {
      DB: 'edc21e23-c2ac-4693-bb79-389b6914e173'
    },
    // wrangler 로컬 DB가 저장되는 기본 경로
    d1Persist: '.wrangler/state/v3/d1'
  })
  
  const db = await mf.getD1Database('DB')
  
  return { mf, db }
}

// CLI execution - Always run when executed directly
(async () => {
  console.log('🚀 Starting Job Dictionary Index Loader...\n')
  
  let mf: Miniflare | null = null
  
  try {
    // Initialize Miniflare
    console.log('🔧 Initializing Miniflare...')
    const { mf: miniflare, db } = await initMiniflare()
    mf = miniflare
    console.log('✅ Miniflare initialized\n')
    
    // Load job dictionary index
    const progress = await loadJobDictionaryIndex(db)
    
    // Summary
    console.log('\n' + '='.repeat(50))
    console.log('📊 FINAL SUMMARY')
    console.log('='.repeat(50))
    console.log(`Total:   ${progress.total}`)
    console.log(`Loaded:  ${progress.loaded}`)
    console.log(`Skipped: ${progress.skipped}`)
    console.log(`Errors:  ${progress.errors}`)
    
    if (progress.errors > 0 && progress.errorDetails.length > 0) {
      console.log('\n❌ Error Details (first 10):')
      progress.errorDetails.slice(0, 10).forEach(err => {
        console.log(`   Row ${err.row}: ${err.error}`)
      })
    }
    
    console.log('='.repeat(50))
    
    process.exit(progress.errors > 0 ? 1 : 0)
    
  } catch (error) {
    console.error('\n❌ Fatal Error:', error)
    process.exit(1)
  } finally {
    // Cleanup
    if (mf) {
      await mf.dispose()
    }
  }
})()

export default {
  async fetch(request: Request, env: { DB: D1Database }): Promise<Response> {
    try {
      const progress = await loadJobDictionaryIndex(env.DB)
      return new Response(JSON.stringify(progress, null, 2), {
        headers: { 'Content-Type': 'application/json' }
      })
    } catch (error) {
      return new Response(
        JSON.stringify({
          error: error instanceof Error ? error.message : String(error)
        }),
        { status: 500, headers: { 'Content-Type': 'application/json' } }
      )
    }
  }
}

