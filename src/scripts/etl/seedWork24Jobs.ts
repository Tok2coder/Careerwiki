/**
 * Seed Work24 Jobs - Complete Implementation
 * 고용24 직업정보 전체 수집 (목록 + 상세 D01-D07)
 */

import type { D1Database } from '@cloudflare/workers-types'
import {
  fetchGoyong24JobList,
  fetchGoyong24JobDetail,
  normalizeGoyong24JobDetail,
  type EnvWithGoyong24Keys
} from '../../api/goyong24API'
import { upsertJobSource } from '../../services/jobSourceService'

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
    'WORK24_JOB_DETAIL',
    'job',
    entityId,
    entityName,
    error,
    Date.now()
  ).run()
}

/**
 * Seed all Work24 jobs
 */
export async function seedWork24Jobs(
  db: D1Database,
  env: Env,
  options: {
    limit?: number
    skipExisting?: boolean
  } = {}
): Promise<SeedProgress> {
  console.log('🌱 Seeding Work24 Jobs...')
  
  const progress: SeedProgress = {
    total: 0,
    processed: 0,
    success: 0,
    failed: 0,
    skipped: 0,
    errors: [],
    startTime: Date.now()
  }
  
  const seedLogId = await createSeedLog(db, 'WORK24_JOB_LIST', 'running', progress)
  
  try {
    // Step 1: Fetch all job list
    console.log('📋 Step 1: Fetching job list...')
    
    const jobListResult = await fetchGoyong24JobList({}, env)
    
    if (!jobListResult || !jobListResult.items) {
      throw new Error('Failed to fetch job list')
    }
    
    progress.total = jobListResult.items.length
    console.log(`  Found ${progress.total} jobs`)
    
    // Step 2: Fetch details for each job
    console.log('📦 Step 2: Fetching job details (D01-D07)...')
    
    for (const jobItem of jobListResult.items) {
      const jobId = jobItem.jobCd
      const jobName = jobItem.jobNm || jobId
      
      try {
        // Check if already exists
        if (options.skipExisting) {
          const existing = await db.prepare(`
            SELECT id FROM job_sources 
            WHERE source_system = 'WORK24_JOB' 
            AND source_key = ?
          `).bind(`WORK24_JOB:${jobId}`).first()
          
          if (existing) {
            progress.skipped++
            progress.processed++
            continue
          }
        }
        
        // Fetch all 7 detail sections (D01-D07)
        const detail = await fetchGoyong24JobDetail(jobId, env)
        
        if (!detail || !detail.summary) {
          throw new Error('No detail returned')
        }
        
        // Normalize
        const normalized = normalizeGoyong24JobDetail(detail)
        
        // Store in job_sources
        await upsertJobSource(db, {
          job_id: null,
          source_system: 'WORK24_JOB',
          source_key: `WORK24_JOB:${jobId}`,
          source_type: 'DETAIL',
          std_job_cd: null,
          keco_cd: detail.path?.kecoList?.[0]?.kecoCd || null,
          ksoc_cd: null,
          industry_cd: null,
          raw_payload: JSON.stringify(detail),
          normalized_payload: JSON.stringify(normalized),
          fetched_at: Date.now(),
          updated_at: Date.now(),
          last_error: null,
          retry_count: 0
        })
        
        progress.success++
        
        if (progress.processed % 10 === 0) {
          console.log(`  ✅ Processed ${progress.processed}/${progress.total} (${Math.round(progress.processed / progress.total * 100)}%)`)
        }
        
        await sleep(300) // Rate limiting
        
      } catch (error) {
        progress.failed++
        const errorMsg = error instanceof Error ? error.message : String(error)
        progress.errors.push({ id: jobId, name: jobName, error: errorMsg })
        
        await logSeedError(db, seedLogId, jobId, jobName, errorMsg)
        
        if (progress.errors.length <= 10) {
          console.error(`  ❌ ${jobName} (${jobId}): ${errorMsg}`)
        }
      }
      
      progress.processed++
      
      if (options.limit && progress.processed >= options.limit) {
        break
      }
    }
    
    // Update seed log
    await db.prepare(`
      UPDATE seed_logs SET
        completed_at = ?,
        status = ?,
        total_count = ?,
        success_count = ?,
        failed_count = ?,
        skipped_count = ?
      WHERE id = ?
    `).bind(
      Date.now(),
      progress.failed > 0 ? 'partial' : 'completed',
      progress.total,
      progress.success,
      progress.failed,
      progress.skipped,
      seedLogId
    ).run()
    
    const duration = Date.now() - progress.startTime
    const durationMin = Math.floor(duration / 60000)
    const durationSec = Math.floor((duration % 60000) / 1000)
    
    console.log('\n✅ Work24 Jobs Seeding Complete')
    console.log(`   Total: ${progress.total}`)
    console.log(`   Success: ${progress.success}`)
    console.log(`   Failed: ${progress.failed}`)
    console.log(`   Skipped: ${progress.skipped}`)
    console.log(`   Duration: ${durationMin}m ${durationSec}s`)
    
    return progress
    
  } catch (error) {
    // Update seed log as failed
    await db.prepare(`
      UPDATE seed_logs SET
        completed_at = ?,
        status = 'failed',
        error_message = ?
      WHERE id = ?
    `).bind(
      Date.now(),
      error instanceof Error ? error.message : String(error),
      seedLogId
    ).run()
    
    throw error
  }
}

// This script is meant to be imported and run via runWork24JobsSeeding.ts

export default {
  async fetch(request: Request, env: Env): Promise<Response> {
    try {
      const url = new URL(request.url)
      const limit = parseInt(url.searchParams.get('limit') || '0') || undefined
      const skipExisting = url.searchParams.get('skip') === 'true'
      
      const progress = await seedWork24Jobs(env.DB, env, {
        limit,
        skipExisting
      })
      
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

