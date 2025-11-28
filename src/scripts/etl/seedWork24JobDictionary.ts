/**
 * Seed Work24 Job Dictionary (D50)
 * job_dictionary_index → Work24 API 호출 → job_sources 저장
 */

import type { D1Database } from '@cloudflare/workers-types'
import {
  fetchGoyong24JobDictionaryDetail,
  normalizeGoyong24JobDictionaryDetail,
  type EnvWithGoyong24Keys
} from '../../api/goyong24API'

interface Env extends EnvWithGoyong24Keys {
  DB: D1Database
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

interface JobDictionaryIndexRow {
  id: number
  d_job_cd: string
  d_job_cd_seq: string
  job_nm: string
  is_seeded: number
  retry_count: number
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

async function logSeedError(
  db: D1Database,
  seedLogId: number,
  entityId: string,
  entityName: string,
  error: string
): Promise<void> {
  await db.prepare(`
    INSERT INTO seed_errors (
      seed_log_id, seed_type, entity_type, entity_id, entity_name,
      error_message, retry_count, created_at
    ) VALUES (?, ?, ?, ?, ?, ?, 0, ?)
  `).bind(
    seedLogId,
    'WORK24_JOB_DICT_DETAIL',
    'job',
    entityId,
    entityName,
    error,
    Date.now()
  ).run()
}

async function updateIndexStatus(
  db: D1Database,
  indexId: number,
  success: boolean,
  error?: string
): Promise<void> {
  const now = Date.now()
  if (success) {
    await db.prepare(`
      UPDATE job_dictionary_index
      SET is_seeded = 1, seeded_at = ?, seed_error = NULL, retry_count = 0
      WHERE id = ?
    `).bind(now, indexId).run()
  } else {
    await db.prepare(`
      UPDATE job_dictionary_index
      SET seed_error = ?, retry_count = retry_count + 1
      WHERE id = ?
    `).bind(error || 'Unknown error', indexId).run()
  }
}

async function upsertJobSource(
  db: D1Database,
  data: {
    sourceSystem: 'WORK24_DJOB'
    sourceKey: string
    sourceType: 'DICTIONARY'
    dJobCd: string
    dJobCdSeq: string
    rawPayload: any
    normalizedPayload: any
  }
): Promise<void> {
  const now = Date.now()
  const rawJson = JSON.stringify(data.rawPayload)
  const normalizedJson = JSON.stringify(data.normalizedPayload)
  
  await db.prepare(`
    INSERT INTO job_sources (
      job_id, source_system, source_key, source_type,
      std_job_cd, keco_cd, ksoc_cd, industry_cd,
      raw_payload, normalized_payload,
      fetched_at, updated_at, retry_count
    ) VALUES (
      NULL, ?, ?, ?,
      NULL, NULL, NULL, NULL,
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
    rawJson,
    normalizedJson,
    now,
    now
  ).run()
}

/**
 * Seed Work24 Job Dictionary for all entries in job_dictionary_index
 */
export async function seedWork24JobDictionary(
  db: D1Database,
  env: Env,
  options: {
    limit?: number
    skipExisting?: boolean
    maxRetries?: number
  } = {}
): Promise<SeedProgress> {
  console.log('🌱 Seeding Work24 Job Dictionary (D50)...')
  
  const { limit, skipExisting = true, maxRetries = 3 } = options
  
  const progress: SeedProgress = {
    total: 0,
    processed: 0,
    success: 0,
    failed: 0,
    skipped: 0,
    errors: [],
    startTime: Date.now()
  }
  
  // Create seed log
  const seedLogId = await createSeedLog(db, 'WORK24_JOB_DICT_DETAIL', 'running', progress)
  
  try {
    // Get all unseeded jobs from index
    let query = `
      SELECT id, d_job_cd, d_job_cd_seq, job_nm, is_seeded, retry_count
      FROM job_dictionary_index
      WHERE 1=1
    `
    
    if (skipExisting) {
      query += ` AND (is_seeded = 0 OR is_seeded IS NULL)`
    }
    
    if (maxRetries > 0) {
      query += ` AND retry_count < ${maxRetries}`
    }
    
    if (limit) {
      query += ` LIMIT ${limit}`
    }
    
    const { results } = await db.prepare(query).all<JobDictionaryIndexRow>()
    
    if (!results || results.length === 0) {
      console.log('ℹ️  No jobs to seed')
      await createSeedLog(db, 'WORK24_JOB_DICT_DETAIL', 'completed', progress)
      return progress
    }
    
    progress.total = results.length
    console.log(`📊 Found ${progress.total} jobs to seed`)
    
    // Process each job
    for (const job of results) {
      progress.processed++
      
      // Progress indicator
      if (progress.processed % 10 === 0 || progress.processed === progress.total) {
        const elapsed = Date.now() - progress.startTime
        const avgTime = elapsed / progress.processed
        const remaining = (progress.total - progress.processed) * avgTime
        
        console.log(`━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`)
        console.log(`📊 진행 상황: ${progress.processed}/${progress.total} (${Math.round(progress.processed / progress.total * 100)}%)`)
        console.log(`✅ 성공: ${progress.success} | ❌ 실패: ${progress.failed} | ⏭️  스킵: ${progress.skipped}`)
        console.log(`⏱️  경과 시간: ${Math.round(elapsed / 1000)}초`)
        console.log(`⏳ 예상 남은 시간: ${Math.round(remaining / 1000)}초`)
        console.log(`━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`)
      }
      
      try {
        // Fetch from Work24 API
        const rawDetail = await fetchGoyong24JobDictionaryDetail(
          env.WORK24_SERVICE_KEY,
          job.d_job_cd,
          job.d_job_cd_seq
        )
        
        if (!rawDetail) {
          throw new Error('API returned null')
        }
        
        // Normalize
        const normalized = normalizeGoyong24JobDictionaryDetail(rawDetail)
        
        // Store in job_sources
        await upsertJobSource(db, {
          sourceSystem: 'WORK24_DJOB',
          sourceKey: `${job.d_job_cd}:${job.d_job_cd_seq}`,
          sourceType: 'DICTIONARY',
          dJobCd: job.d_job_cd,
          dJobCdSeq: job.d_job_cd_seq,
          rawPayload: rawDetail,
          normalizedPayload: normalized
        })
        
        // Update index status
        await updateIndexStatus(db, job.id, true)
        
        progress.success++
        
        // Rate limiting: 300ms between requests
        await sleep(300)
        
      } catch (error) {
        const errorMessage = error instanceof Error ? error.message : String(error)
        console.error(`  ❌ ${job.job_nm} (${job.d_job_cd}:${job.d_job_cd_seq}): ${errorMessage}`)
        
        progress.failed++
        progress.errors.push({
          id: `${job.d_job_cd}:${job.d_job_cd_seq}`,
          name: job.job_nm,
          error: errorMessage
        })
        
        await updateIndexStatus(db, job.id, false, errorMessage)
        await logSeedError(
          db,
          seedLogId,
          `${job.d_job_cd}:${job.d_job_cd_seq}`,
          job.job_nm,
          errorMessage
        )
        
        // Still wait before next request
        await sleep(300)
      }
    }
    
    // Update seed log
    await createSeedLog(db, 'WORK24_JOB_DICT_DETAIL', 'completed', progress)
    
    console.log('\n✅ Work24 Job Dictionary Seeding Complete')
    console.log(`   Total: ${progress.total}`)
    console.log(`   Success: ${progress.success}`)
    console.log(`   Failed: ${progress.failed}`)
    console.log(`   Skipped: ${progress.skipped}`)
    
    return progress
    
  } catch (error) {
    console.error('❌ Fatal error during seeding:', error)
    await createSeedLog(db, 'WORK24_JOB_DICT_DETAIL', 'failed', progress)
    throw error
  }
}

// This script is meant to be imported and run via runWork24JobDictionarySeeding.ts

