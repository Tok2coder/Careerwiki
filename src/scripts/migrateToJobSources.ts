/**
 * Data Migration Script: Migrate from old api_data_json structure to new job_sources/major_sources tables
 * Phase 2.2: Extract and migrate existing data
 * 
 * Run with: npm run migrate:job-sources
 * or: wrangler d1 execute careerwiki-kr --local --file=dist/scripts/migrateToJobSources.js
 */

import type { D1Database } from '@cloudflare/workers-types'
import type {
  JobRow,
  MajorRow,
  JobSourceRow,
  MajorSourceRow,
  MigrationReport
} from '../types/database'

/**
 * Generate slug from name
 */
function generateSlug(name: string): string {
  return name
    .toLowerCase()
    .replace(/\s+/g, '-')
    .replace(/\//g, '-')
    .replace(/[()]/g, '')
    .replace(/[^\w\-가-힣]/g, '')
    .replace(/-+/g, '-')
    .replace(/^-|-$/g, '')
}

/**
 * Migrate jobs table
 */
async function migrateJobs(db: D1Database): Promise<{
  migrated: number
  sources: number
  errors: string[]
}> {
  const errors: string[] = []
  let migrated = 0
  let sourcesCreated = 0
  
  // Get all active jobs
  const jobs = await db.prepare(`
    SELECT * FROM jobs WHERE is_active = 1
  `).all<JobRow>()
  
  console.log(`Found ${jobs.results.length} active jobs to migrate`)
  
  for (const job of jobs.results) {
    try {
      // 1. Generate slug if not exists
      if (!job.slug) {
        const slug = generateSlug(job.name)
        await db.prepare(`
          UPDATE jobs SET slug = ? WHERE id = ?
        `).bind(slug, job.id).run()
      }
      
      // 2. Set primary_source based on available data
      if (!job.primary_source) {
        const primarySource = job.careernet_id ? 'CAREERNET' : job.goyong24_id ? 'WORK24_JOB' : null
        if (primarySource) {
          await db.prepare(`
            UPDATE jobs SET primary_source = ? WHERE id = ?
          `).bind(primarySource, job.id).run()
        }
      }
      
      // 3. Extract and migrate sources from api_data_json
      if (job.api_data_json) {
        try {
          const apiData = JSON.parse(job.api_data_json)
          
          // CareerNet source
          if (job.careernet_id && apiData.careernet) {
            const sourceKey = `CAREERNET:${job.careernet_id}`
            
            // Check if source already exists
            const existing = await db.prepare(`
              SELECT id FROM job_sources WHERE source_system = ? AND source_key = ?
            `).bind('CAREERNET', sourceKey).first()
            
            if (!existing) {
              await db.prepare(`
                INSERT INTO job_sources (
                  job_id, source_system, source_key,
                  raw_payload, normalized_payload,
                  fetched_at, updated_at
                ) VALUES (?, ?, ?, ?, ?, ?, ?)
              `).bind(
                job.id,
                'CAREERNET',
                sourceKey,
                JSON.stringify(apiData.careernet),
                JSON.stringify(apiData.careernet),  // Same for now, will be normalized later
                job.api_last_fetched_at || Date.now(),
                job.api_last_updated_at || Date.now()
              ).run()
              
              sourcesCreated++
            }
          }
          
          // Work24 source (legacy goyong24)
          if (job.goyong24_id && apiData.goyong24) {
            const sourceKey = `WORK24_JOB:${job.goyong24_id}`
            
            const existing = await db.prepare(`
              SELECT id FROM job_sources WHERE source_system = ? AND source_key = ?
            `).bind('WORK24_JOB', sourceKey).first()
            
            if (!existing) {
              await db.prepare(`
                INSERT INTO job_sources (
                  job_id, source_system, source_key,
                  raw_payload, normalized_payload,
                  fetched_at, updated_at
                ) VALUES (?, ?, ?, ?, ?, ?, ?)
              `).bind(
                job.id,
                'WORK24_JOB',
                sourceKey,
                JSON.stringify(apiData.goyong24),
                JSON.stringify(apiData.goyong24),
                job.api_last_fetched_at || Date.now(),
                job.api_last_updated_at || Date.now()
              ).run()
              
              sourcesCreated++
            }
          }
        } catch (parseError) {
          errors.push(`Job ${job.id}: Failed to parse api_data_json - ${parseError}`)
        }
      }
      
      migrated++
    } catch (error) {
      errors.push(`Job ${job.id}: ${error instanceof Error ? error.message : String(error)}`)
    }
  }
  
  return { migrated, sources: sourcesCreated, errors }
}

/**
 * Migrate majors table
 */
async function migrateMajors(db: D1Database): Promise<{
  migrated: number
  sources: number
  errors: string[]
}> {
  const errors: string[] = []
  let migrated = 0
  let sourcesCreated = 0
  
  const majors = await db.prepare(`
    SELECT * FROM majors WHERE is_active = 1
  `).all<MajorRow>()
  
  console.log(`Found ${majors.results.length} active majors to migrate`)
  
  for (const major of majors.results) {
    try {
      // 1. Generate slug if not exists
      if (!major.slug) {
        const slug = generateSlug(major.name)
        await db.prepare(`
          UPDATE majors SET slug = ? WHERE id = ?
        `).bind(slug, major.id).run()
      }
      
      // 2. Set primary_source
      if (!major.primary_source) {
        const primarySource = major.careernet_id ? 'CAREERNET' : major.goyong24_id ? 'WORK24_MAJOR' : null
        if (primarySource) {
          await db.prepare(`
            UPDATE majors SET primary_source = ? WHERE id = ?
          `).bind(primarySource, major.id).run()
        }
      }
      
      // 3. Extract and migrate sources
      if (major.api_data_json) {
        try {
          const apiData = JSON.parse(major.api_data_json)
          
          // CareerNet source
          if (major.careernet_id && apiData.careernet) {
            const sourceKey = `CAREERNET:${major.careernet_id}`
            
            const existing = await db.prepare(`
              SELECT id FROM major_sources WHERE source_system = ? AND source_key = ?
            `).bind('CAREERNET', sourceKey).first()
            
            if (!existing) {
              await db.prepare(`
                INSERT INTO major_sources (
                  major_id, source_system, source_key,
                  raw_payload, normalized_payload,
                  fetched_at, updated_at
                ) VALUES (?, ?, ?, ?, ?, ?, ?)
              `).bind(
                major.id,
                'CAREERNET',
                sourceKey,
                JSON.stringify(apiData.careernet),
                JSON.stringify(apiData.careernet),
                major.api_last_fetched_at || Date.now(),
                major.api_last_updated_at || Date.now()
              ).run()
              
              sourcesCreated++
            }
          }
          
          // Work24 source
          if (major.goyong24_id && apiData.goyong24) {
            const sourceKey = `WORK24_MAJOR:${major.goyong24_id}`
            
            const existing = await db.prepare(`
              SELECT id FROM major_sources WHERE source_system = ? AND source_key = ?
            `).bind('WORK24_MAJOR', sourceKey).first()
            
            if (!existing) {
              await db.prepare(`
                INSERT INTO major_sources (
                  major_id, source_system, source_key,
                  raw_payload, normalized_payload,
                  fetched_at, updated_at
                ) VALUES (?, ?, ?, ?, ?, ?, ?)
              `).bind(
                major.id,
                'WORK24_MAJOR',
                sourceKey,
                JSON.stringify(apiData.goyong24),
                JSON.stringify(apiData.goyong24),
                major.api_last_fetched_at || Date.now(),
                major.api_last_updated_at || Date.now()
              ).run()
              
              sourcesCreated++
            }
          }
        } catch (parseError) {
          errors.push(`Major ${major.id}: Failed to parse api_data_json - ${parseError}`)
        }
      }
      
      migrated++
    } catch (error) {
      errors.push(`Major ${major.id}: ${error instanceof Error ? error.message : String(error)}`)
    }
  }
  
  return { migrated, sources: sourcesCreated, errors }
}

/**
 * Create unique indexes on slug fields
 */
async function createSlugIndexes(db: D1Database): Promise<void> {
  try {
    await db.prepare(`
      CREATE UNIQUE INDEX IF NOT EXISTS idx_jobs_slug ON jobs(slug)
    `).run()
    
    await db.prepare(`
      CREATE UNIQUE INDEX IF NOT EXISTS idx_majors_slug ON majors(slug)
    `).run()
    
    console.log('Created unique indexes on slug fields')
  } catch (error) {
    console.error('Failed to create slug indexes:', error)
  }
}

/**
 * Validate migration
 */
async function validateMigration(db: D1Database): Promise<{
  jobsWithoutSources: number
  majorsWithoutSources: number
  slugDuplicates: number
}> {
  // Check jobs without sources
  const jobsWithoutSources = await db.prepare(`
    SELECT COUNT(*) as count
    FROM jobs j
    LEFT JOIN job_sources js ON js.job_id = j.id
    WHERE j.is_active = 1 AND js.id IS NULL
  `).first<{ count: number }>()
  
  // Check majors without sources
  const majorsWithoutSources = await db.prepare(`
    SELECT COUNT(*) as count
    FROM majors m
    LEFT JOIN major_sources ms ON ms.major_id = m.id
    WHERE m.is_active = 1 AND ms.id IS NULL
  `).first<{ count: number }>()
  
  // Check slug duplicates
  const slugDuplicates = await db.prepare(`
    SELECT COUNT(*) as count FROM (
      SELECT slug, COUNT(*) as dup_count
      FROM jobs
      WHERE slug IS NOT NULL
      GROUP BY slug
      HAVING COUNT(*) > 1
      UNION ALL
      SELECT slug, COUNT(*) as dup_count
      FROM majors
      WHERE slug IS NOT NULL
      GROUP BY slug
      HAVING COUNT(*) > 1
    )
  `).first<{ count: number }>()
  
  return {
    jobsWithoutSources: jobsWithoutSources?.count || 0,
    majorsWithoutSources: majorsWithoutSources?.count || 0,
    slugDuplicates: slugDuplicates?.count || 0
  }
}

/**
 * Main migration function
 */
export async function migrateToJobSources(db: D1Database): Promise<MigrationReport> {
  const startTime = Date.now()
  
  console.log('Starting migration to job_sources/major_sources...')
  
  // Phase 1: Migrate jobs
  console.log('\n=== Phase 1: Migrating jobs ===')
  const jobsResult = await migrateJobs(db)
  console.log(`Migrated ${jobsResult.migrated} jobs, created ${jobsResult.sources} sources`)
  if (jobsResult.errors.length > 0) {
    console.error(`Errors: ${jobsResult.errors.length}`)
    jobsResult.errors.forEach(err => console.error(`  - ${err}`))
  }
  
  // Phase 2: Migrate majors
  console.log('\n=== Phase 2: Migrating majors ===')
  const majorsResult = await migrateMajors(db)
  console.log(`Migrated ${majorsResult.migrated} majors, created ${majorsResult.sources} sources`)
  if (majorsResult.errors.length > 0) {
    console.error(`Errors: ${majorsResult.errors.length}`)
    majorsResult.errors.forEach(err => console.error(`  - ${err}`))
  }
  
  // Phase 3: Create slug indexes
  console.log('\n=== Phase 3: Creating slug indexes ===')
  await createSlugIndexes(db)
  
  // Phase 4: Validate migration
  console.log('\n=== Phase 4: Validating migration ===')
  const validation = await validateMigration(db)
  console.log(`Jobs without sources: ${validation.jobsWithoutSources}`)
  console.log(`Majors without sources: ${validation.majorsWithoutSources}`)
  console.log(`Slug duplicates: ${validation.slugDuplicates}`)
  
  const duration = Date.now() - startTime
  const allErrors = [...jobsResult.errors, ...majorsResult.errors]
  const dataIntegrity = validation.jobsWithoutSources === 0 && 
                        validation.majorsWithoutSources === 0 && 
                        validation.slugDuplicates === 0 ? 'OK' : 'FAILED'
  
  const report: MigrationReport = {
    timestamp: new Date().toISOString(),
    duration_ms: duration,
    jobs_migrated: jobsResult.migrated,
    majors_migrated: majorsResult.migrated,
    sources_created: jobsResult.sources + majorsResult.sources,
    errors: allErrors.length,
    warnings: validation.slugDuplicates > 0 ? [`Found ${validation.slugDuplicates} slug duplicates`] : [],
    validation: {
      all_jobs_have_sources: validation.jobsWithoutSources === 0,
      all_majors_have_sources: validation.majorsWithoutSources === 0,
      slug_duplicates: validation.slugDuplicates,
      data_integrity: dataIntegrity
    }
  }
  
  console.log('\n=== Migration Complete ===')
  console.log(`Duration: ${duration}ms`)
  console.log(`Data Integrity: ${dataIntegrity}`)
  
  return report
}

// Export for use in Cloudflare Workers
export default {
  async fetch(request: Request, env: { DB: D1Database }): Promise<Response> {
    if (request.method !== 'POST') {
      return new Response('Method not allowed. Use POST to trigger migration.', { status: 405 })
    }
    
    try {
      const report = await migrateToJobSources(env.DB)
      return new Response(JSON.stringify(report, null, 2), {
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

