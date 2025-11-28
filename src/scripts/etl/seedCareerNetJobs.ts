/**
 * Seed CareerNet Jobs - Complete Implementation
 * 커리어넷 직업백과 전체 수집 (목록 + 상세 + 백과)
 */

import type { D1Database } from '@cloudflare/workers-types'
import { searchJobs, getJobDetail, getJobEncyclopedia, JOB_CATEGORIES } from '../../api/careernetAPI'
import { normalizeCareerNetJobDetail } from '../../api/careernetAPI'
import type { JobEncyclopediaResponse } from '../../api/careernetAPI'
import { upsertJobSource } from '../../services/jobSourceService'

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
    'CAREERNET_JOB_DETAIL',
    'job',
    entityId,
    entityName,
    error,
    Date.now()
  ).run()
}

/**
 * Seed all CareerNet jobs
 */
export async function seedCareerNetJobs(
  db: D1Database,
  env: Env,
  options: {
    limit?: number
    skipExisting?: boolean
  } = {}
): Promise<SeedProgress> {
  console.log('🌱 Seeding CareerNet Jobs...')
  
  const progress: SeedProgress = {
    total: 0,
    processed: 0,
    success: 0,
    failed: 0,
    skipped: 0,
    errors: [],
    startTime: Date.now()
  }
  
  const seedLogId = await createSeedLog(db, 'CAREERNET_JOB_LIST', 'running', progress)
  
  try {
    // Step 1: Collect all job IDs from all categories
    console.log('📋 Step 1: Fetching job list from all categories...')
    
    const allJobIds = new Set<string>()
    const jobNames = new Map<string, string>()
    
    // Convert JOB_CATEGORIES object to array
    const categories = Object.entries(JOB_CATEGORIES).map(([name, code]) => ({ name, code }))
    
    for (const category of categories) {
      console.log(`  Fetching category: ${category.name}`)
      
      let page = 1
      let hasMore = true
      
      while (hasMore) {
        try {
          const jobs = await searchJobs({
            category: category.code,
            thisPage: page,
            perPage: 100
          }, env)
          
          if (jobs.length === 0) {
            hasMore = false
            break
          }
          
          jobs.forEach(job => {
            const jobId = job.jobdicSeq
            if (jobId) {
              allJobIds.add(jobId)
              jobNames.set(jobId, job.jobName)
            }
          })
          
          page++
          await sleep(300) // Rate limiting
          
        } catch (error) {
          console.error(`  Error fetching ${category.name} page ${page}:`, error)
          hasMore = false
        }
      }
    }
    
    progress.total = allJobIds.size
    console.log(`  Found ${progress.total} unique jobs`)
    
    // Step 2: Fetch details for each job
    console.log('📦 Step 2: Fetching job details...')
    
    for (const jobId of Array.from(allJobIds)) {
      const jobName = jobNames.get(jobId) || jobId
      
      try {
        // Check if already exists
        if (options.skipExisting) {
          const existing = await db.prepare(`
            SELECT id FROM job_sources 
            WHERE source_system = 'CAREERNET' 
            AND source_key = ?
          `).bind(`CAREERNET:${jobId}`).first()
          
          if (existing) {
            progress.skipped++
            progress.processed++
            continue
          }
        }
        
        // Fetch basic detail
        const detail = await getJobDetail(jobId, env)
        
        if (!detail) {
          throw new Error('No detail returned')
        }
        
        // Fetch encyclopedia (additional rich content)
        let encyclopedia: JobEncyclopediaResponse | undefined = undefined
        try {
          const encResult = await getJobEncyclopedia(jobId, env)
          // Convert null to undefined for type compatibility
          encyclopedia = encResult ?? undefined
          // Attach encyclopedia to detail object
          detail.encyclopedia = encyclopedia
        } catch (error) {
          console.warn(`  Encyclopedia not available for ${jobName}`)
        }
        
        // Normalize (encyclopedia is already attached to detail)
        const normalized = normalizeCareerNetJobDetail(detail)
        
        // Extract std_job_cd from encyclopedia if available
        const stdJobCd = detail.encyclopedia?.baseInfo?.std_job_cd || null
        
        // Store basic detail
        await upsertJobSource(db, {
          job_id: null,
          source_system: 'CAREERNET',
          source_key: `CAREERNET:${jobId}`,
          source_type: 'DETAIL',
          std_job_cd: stdJobCd,
          keco_cd: null,
          ksoc_cd: null,
          industry_cd: null,
          raw_payload: JSON.stringify(detail),
          normalized_payload: JSON.stringify(normalized),
          fetched_at: Date.now(),
          updated_at: Date.now(),
          last_error: null,
          retry_count: 0
        })
        
        // Store encyclopedia separately if available
        if (encyclopedia) {
          await upsertJobSource(db, {
            job_id: null,
            source_system: 'CAREERNET',
            source_key: `CAREERNET:${jobId}:ENCYCLOPEDIA`,
            source_type: 'ENCYCLOPEDIA',
            std_job_cd: stdJobCd,
            keco_cd: null,
            ksoc_cd: null,
            industry_cd: null,
            raw_payload: JSON.stringify(encyclopedia),
            normalized_payload: JSON.stringify(normalized),
            fetched_at: Date.now(),
            updated_at: Date.now(),
            last_error: null,
            retry_count: 0
          })
        }
        
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
    
    console.log('\n✅ CareerNet Jobs Seeding Complete')
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

// This script is meant to be imported and run via runCareerNetJobsSeeding.ts

export default {
  async fetch(request: Request, env: Env): Promise<Response> {
    try {
      const url = new URL(request.url)
      const limit = parseInt(url.searchParams.get('limit') || '0') || undefined
      const skipExisting = url.searchParams.get('skip') === 'true'
      
      const progress = await seedCareerNetJobs(env.DB, env, {
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

