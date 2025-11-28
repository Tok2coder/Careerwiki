/**
 * Seed CareerNet Majors
 */

import type { D1Database } from '@cloudflare/workers-types'
import { searchMajors, getMajorDetail, type SearchMajorsParams } from '../../api/careernetAPI'
import { normalizeCareerNetMajorDetail } from '../../api/careernetAPI'

interface Env {
  DB: D1Database
  CAREER_NET_API_KEY: string
}

interface SeedProgress {
  total: number
  processed: number
  success: number
  failed: number
  skipped: number
  errors: Array<{ id: string; name: string; error: string }>
  startTime: number
}

function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms))
}

async function createSeedLog(
  db: D1Database,
  seedType: string,
  status: string,
  stats: Partial<SeedProgress>
): Promise<number> {
  const now = Date.now()
  const result = await db.prepare(`
    INSERT INTO seed_logs (
      seed_type, started_at, completed_at, status,
      total_count, success_count, failed_count, skipped_count,
      created_at
    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
  `).bind(
    seedType,
    stats.startTime || now,
    status === 'running' ? null : now,
    status,
    stats.total || 0,
    stats.success || 0,
    stats.failed || 0,
    stats.skipped || 0,
    now
  ).run()
  
  return result.meta.last_row_id as number
}

async function upsertMajorSource(
  db: D1Database,
  data: {
    sourceSystem: 'CAREERNET'
    sourceKey: string
    sourceType: string
    majorSeq?: string
    rawPayload: any
    normalizedPayload: any
  }
): Promise<void> {
  const now = Date.now()
  const rawJson = JSON.stringify(data.rawPayload)
  const normalizedJson = JSON.stringify(data.normalizedPayload)
  
  await db.prepare(`
    INSERT INTO major_sources (
      major_id, source_system, source_key, source_type,
      major_seq, department_cd, track, gubun,
      raw_payload, normalized_payload,
      fetched_at, updated_at, retry_count
    ) VALUES (
      NULL, ?, ?, ?,
      ?, NULL, NULL, NULL,
      ?, ?,
      ?, ?, 0
    )
    ON CONFLICT(source_system, source_key) DO UPDATE SET
      raw_payload = excluded.raw_payload,
      normalized_payload = excluded.normalized_payload,
      updated_at = excluded.updated_at
  `).bind(
    data.sourceSystem,
    data.sourceKey,
    data.sourceType,
    data.majorSeq || null,
    rawJson,
    normalizedJson,
    now,
    now
  ).run()
}

export async function seedCareerNetMajors(
  db: D1Database,
  env: Env,
  options: {
    limit?: number
    skipExisting?: boolean
  } = {}
): Promise<SeedProgress> {
  console.log('🌱 Seeding CareerNet Majors...')
  
  const progress: SeedProgress = {
    total: 0,
    processed: 0,
    success: 0,
    failed: 0,
    skipped: 0,
    errors: [],
    startTime: Date.now()
  }
  
  const seedLogId = await createSeedLog(db, 'CAREERNET_MAJOR_LIST', 'running', progress)
  
  try {
    console.log('📋 Step 1: Fetching major list...')
    
    const allMajorIds = new Set<string>()
    const majorNames = new Map<string, string>()
    
    let page = 1
    let hasMore = true
    
    while (hasMore) {
      try {
        const params: SearchMajorsParams = {
          thisPage: page,
          perPage: 100
        }
        
        const majors = await searchMajors(params, env)
        
        if (majors.length === 0) {
          hasMore = false
          break
        }
        
        majors.forEach(major => {
          const majorId = major.majorSeq  // ✅ majorSeq 필드 사용 (숫자 ID)
          if (majorId) {
            allMajorIds.add(majorId)
            majorNames.set(majorId, major.mClass || major.facilName || major.majorName)
          }
        })
        
        page++
        await sleep(300)
        
      } catch (error) {
        console.error(`  Error fetching page ${page}:`, error)
        hasMore = false
      }
      
      if (options.limit && allMajorIds.size >= options.limit) {
        hasMore = false
      }
    }
    
    const majorIdArray = Array.from(allMajorIds).slice(0, options.limit)
    progress.total = majorIdArray.length
    
    console.log(`📊 Found ${progress.total} majors to seed`)
    
    for (const majorId of majorIdArray) {
      progress.processed++
      
      if (progress.processed % 10 === 0) {
        console.log(`📊 Progress: ${progress.processed}/${progress.total}`)
      }
      
      try {
        const detail = await getMajorDetail(majorId, env)
        
        if (!detail) {
          throw new Error('API returned null')
        }
        
        const normalized = normalizeCareerNetMajorDetail(detail)
        
        await upsertMajorSource(db, {
          sourceSystem: 'CAREERNET',
          sourceKey: `CAREERNET:${majorId}`,
          sourceType: 'DETAIL_UNIV',  // ✅ CHECK constraint 만족
          majorSeq: majorId,
          rawPayload: detail,
          normalizedPayload: normalized
        })
        
        progress.success++
        await sleep(300)
        
      } catch (error) {
        const errorMessage = error instanceof Error ? error.message : String(error)
        console.error(`  ❌ ${majorNames.get(majorId) || majorId}: ${errorMessage}`)
        
        progress.failed++
        progress.errors.push({
          id: majorId,
          name: majorNames.get(majorId) || majorId,
          error: errorMessage
        })
        
        await sleep(300)
      }
    }
    
    await createSeedLog(db, 'CAREERNET_MAJOR_LIST', 'completed', progress)
    
    console.log('\n✅ CareerNet Major Seeding Complete')
    console.log(`   Total: ${progress.total}`)
    console.log(`   Success: ${progress.success}`)
    console.log(`   Failed: ${progress.failed}`)
    
    return progress
    
  } catch (error) {
    console.error('❌ Fatal error during seeding:', error)
    await createSeedLog(db, 'CAREERNET_MAJOR_LIST', 'failed', progress)
    throw error
  }
}

