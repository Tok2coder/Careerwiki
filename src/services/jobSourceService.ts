/**
 * Job Source Service
 * Functions for working with the new job_sources/major_sources architecture
 */

import type { D1Database } from '@cloudflare/workers-types'
import type {
  JobRow,
  MajorRow,
  JobSourceRow,
  MajorSourceRow,
  JobWithSources,
  MajorWithSources,
  JobAssetRow,
  MajorAssetRow,
  JobMatchOverrideRow
} from '../types/database'
import type {
  UnifiedJobDetail,
  UnifiedMajorDetail
} from '../types/unifiedProfiles'

// ============================================================================
// Job Sources
// ============================================================================

/**
 * Get job with all associated sources
 */
export async function getJobWithSources(
  db: D1Database,
  jobId: string
): Promise<JobWithSources | null> {
  // Get job
  const job = await db.prepare(`
    SELECT * FROM jobs WHERE id = ? AND is_active = 1
  `).bind(jobId).first<JobRow>()
  
  if (!job) {
    return null
  }
  
  // Get all sources
  const sources = await db.prepare(`
    SELECT * FROM job_sources WHERE job_id = ? ORDER BY source_system
  `).bind(jobId).all<JobSourceRow>()
  
  // Get assets (optional)
  const assets = await db.prepare(`
    SELECT * FROM job_assets 
    WHERE job_id = ? AND is_active = 1 
    ORDER BY display_order
  `).bind(jobId).all<JobAssetRow>()
  
  return {
    job,
    sources: sources.results || [],
    assets: assets.results || []
  }
}

/**
 * Get job by slug
 */
export async function getJobBySlug(
  db: D1Database,
  slug: string
): Promise<JobWithSources | null> {
  const job = await db.prepare(`
    SELECT * FROM jobs WHERE slug = ? AND is_active = 1
  `).bind(slug).first<JobRow>()
  
  if (!job) {
    return null
  }
  
  return getJobWithSources(db, job.id)
}

/**
 * Get all sources for a job
 */
export async function getJobSources(
  db: D1Database,
  jobId: string
): Promise<JobSourceRow[]> {
  const result = await db.prepare(`
    SELECT * FROM job_sources WHERE job_id = ? ORDER BY source_system
  `).bind(jobId).all<JobSourceRow>()
  
  return result.results || []
}

/**
 * Get source by key
 */
export async function getJobSourceByKey(
  db: D1Database,
  sourceSystem: string,
  sourceKey: string
): Promise<JobSourceRow | null> {
  return await db.prepare(`
    SELECT * FROM job_sources 
    WHERE source_system = ? AND source_key = ?
  `).bind(sourceSystem, sourceKey).first<JobSourceRow>()
}

/**
 * Upsert job source
 */
export async function upsertJobSource(
  db: D1Database,
  source: Omit<JobSourceRow, 'id'>
): Promise<void> {
  await db.prepare(`
    INSERT INTO job_sources (
      job_id, source_system, source_key, source_type,
      std_job_cd, keco_cd, ksoc_cd, industry_cd,
      raw_payload, normalized_payload,
      fetched_at, updated_at,
      last_error, retry_count
    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    ON CONFLICT(source_system, source_key) DO UPDATE SET
      job_id = excluded.job_id,
      source_type = excluded.source_type,
      std_job_cd = excluded.std_job_cd,
      keco_cd = excluded.keco_cd,
      ksoc_cd = excluded.ksoc_cd,
      industry_cd = excluded.industry_cd,
      raw_payload = excluded.raw_payload,
      normalized_payload = excluded.normalized_payload,
      fetched_at = excluded.fetched_at,
      updated_at = excluded.updated_at,
      last_error = excluded.last_error,
      retry_count = excluded.retry_count
  `).bind(
    source.job_id || null,
    source.source_system,
    source.source_key,
    source.source_type || null,
    source.std_job_cd || null,
    source.keco_cd || null,
    source.ksoc_cd || null,
    source.industry_cd || null,
    source.raw_payload,
    source.normalized_payload,
    source.fetched_at,
    source.updated_at,
    source.last_error || null,
    source.retry_count || 0
  ).run()
}

/**
 * Find jobs by code (for matching)
 */
export async function findJobsByCode(
  db: D1Database,
  codeType: 'std_job_cd' | 'keco_cd' | 'ksoc_cd' | 'industry_cd',
  codeValue: string
): Promise<Array<{ job: JobRow; source: JobSourceRow }>> {
  const query = `
    SELECT j.*, js.*
    FROM jobs j
    JOIN job_sources js ON js.job_id = j.id
    WHERE j.is_active = 1 AND js.${codeType} = ?
  `
  
  const result = await db.prepare(query).bind(codeValue).all<any>()
  
  return (result.results || []).map((row: any) => ({
    job: {
      id: row.id,
      careernet_id: row.careernet_id,
      goyong24_id: row.goyong24_id,
      name: row.name,
      // ... other job fields
    } as JobRow,
    source: {
      // Extract source fields (they'll be prefixed in the result)
      // This is a simplified version - you may need to adjust field extraction
    } as JobSourceRow
  }))
}

// ============================================================================
// Major Sources
// ============================================================================

/**
 * Get major with all associated sources
 */
export async function getMajorWithSources(
  db: D1Database,
  majorId: string
): Promise<MajorWithSources | null> {
  const major = await db.prepare(`
    SELECT * FROM majors WHERE id = ? AND is_active = 1
  `).bind(majorId).first<MajorRow>()
  
  if (!major) {
    return null
  }
  
  const sources = await db.prepare(`
    SELECT * FROM major_sources WHERE major_id = ? ORDER BY source_system
  `).bind(majorId).all<MajorSourceRow>()
  
  const assets = await db.prepare(`
    SELECT * FROM major_assets 
    WHERE major_id = ? AND is_active = 1 
    ORDER BY display_order
  `).bind(majorId).all<MajorAssetRow>()
  
  return {
    major,
    sources: sources.results || [],
    assets: assets.results || []
  }
}

/**
 * Get major by slug
 */
export async function getMajorBySlug(
  db: D1Database,
  slug: string
): Promise<MajorWithSources | null> {
  const major = await db.prepare(`
    SELECT * FROM majors WHERE slug = ? AND is_active = 1
  `).bind(slug).first<MajorRow>()
  
  if (!major) {
    return null
  }
  
  return getMajorWithSources(db, major.id)
}

/**
 * Upsert major source
 */
export async function upsertMajorSource(
  db: D1Database,
  source: Omit<MajorSourceRow, 'id'>
): Promise<void> {
  await db.prepare(`
    INSERT INTO major_sources (
      major_id, source_system, source_key, source_type,
      major_seq, department_cd, track, gubun,
      raw_payload, normalized_payload,
      fetched_at, updated_at,
      last_error, retry_count
    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    ON CONFLICT(source_system, source_key) DO UPDATE SET
      major_id = excluded.major_id,
      source_type = excluded.source_type,
      major_seq = excluded.major_seq,
      department_cd = excluded.department_cd,
      track = excluded.track,
      gubun = excluded.gubun,
      raw_payload = excluded.raw_payload,
      normalized_payload = excluded.normalized_payload,
      fetched_at = excluded.fetched_at,
      updated_at = excluded.updated_at,
      last_error = excluded.last_error,
      retry_count = excluded.retry_count
  `).bind(
    source.major_id || null,
    source.source_system,
    source.source_key,
    source.source_type || null,
    source.major_seq || null,
    source.department_cd || null,
    source.track || null,
    source.gubun || null,
    source.raw_payload,
    source.normalized_payload,
    source.fetched_at,
    source.updated_at,
    source.last_error || null,
    source.retry_count || 0
  ).run()
}

// ============================================================================
// Match Overrides
// ============================================================================

/**
 * Get match override for a source
 */
export async function getMatchOverride(
  db: D1Database,
  sourceSystem: string,
  sourceKey: string
): Promise<JobMatchOverrideRow | null> {
  return await db.prepare(`
    SELECT * FROM job_match_overrides 
    WHERE source_system = ? AND source_key = ?
  `).bind(sourceSystem, sourceKey).first<JobMatchOverrideRow>()
}

/**
 * Create match override
 */
export async function createMatchOverride(
  db: D1Database,
  override: Omit<JobMatchOverrideRow, 'id'>
): Promise<void> {
  await db.prepare(`
    INSERT INTO job_match_overrides (
      job_id, source_system, source_key,
      reason, confidence, created_by, created_at, updated_at
    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?)
    ON CONFLICT(source_system, source_key) DO UPDATE SET
      job_id = excluded.job_id,
      reason = excluded.reason,
      confidence = excluded.confidence,
      updated_at = excluded.updated_at
  `).bind(
    override.job_id,
    override.source_system,
    override.source_key,
    override.reason || null,
    override.confidence || null,
    override.created_by || null,
    override.created_at,
    override.updated_at || null
  ).run()
}

// ============================================================================
// Assets
// ============================================================================

/**
 * Get assets for a job
 */
export async function getJobAssets(
  db: D1Database,
  jobId: string,
  type?: string
): Promise<JobAssetRow[]> {
  const query = type
    ? `SELECT * FROM job_assets WHERE job_id = ? AND type = ? AND is_active = 1 ORDER BY display_order`
    : `SELECT * FROM job_assets WHERE job_id = ? AND is_active = 1 ORDER BY display_order`
  
  const stmt = type
    ? db.prepare(query).bind(jobId, type)
    : db.prepare(query).bind(jobId)
  
  const result = await stmt.all<JobAssetRow>()
  return result.results || []
}

/**
 * Add asset to job
 */
export async function addJobAsset(
  db: D1Database,
  asset: Omit<JobAssetRow, 'id' | 'created_at' | 'updated_at'>
): Promise<void> {
  await db.prepare(`
    INSERT INTO job_assets (
      job_id, type, source, url,
      caption, alt_text, meta_json,
      display_order, is_active, created_at
    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
  `).bind(
    asset.job_id,
    asset.type,
    asset.source,
    asset.url,
    asset.caption || null,
    asset.alt_text || null,
    asset.meta_json || null,
    asset.display_order,
    asset.is_active,
    Date.now()
  ).run()
}

// ============================================================================
// Search & List
// ============================================================================

/**
 * Search jobs with source count
 */
export async function searchJobs(
  db: D1Database,
  query: string,
  limit: number = 20,
  offset: number = 0
): Promise<Array<{ job: JobRow; source_count: number }>> {
  const result = await db.prepare(`
    SELECT 
      j.*,
      COUNT(DISTINCT js.id) as source_count
    FROM jobs j
    LEFT JOIN job_sources js ON js.job_id = j.id
    WHERE j.is_active = 1
      AND (j.name LIKE ? OR j.name_en LIKE ?)
    GROUP BY j.id
    ORDER BY j.name
    LIMIT ? OFFSET ?
  `).bind(`%${query}%`, `%${query}%`, limit, offset).all<any>()
  
  return (result.results || []).map((row: any) => ({
    job: row as JobRow,
    source_count: row.source_count || 0
  }))
}

/**
 * List all jobs with source info
 */
export async function listJobsWithSources(
  db: D1Database,
  limit: number = 100,
  offset: number = 0
): Promise<Array<{ job: JobRow; source_count: number }>> {
  const result = await db.prepare(`
    SELECT 
      j.*,
      COUNT(DISTINCT js.id) as source_count
    FROM jobs j
    LEFT JOIN job_sources js ON js.job_id = j.id
    WHERE j.is_active = 1
    GROUP BY j.id
    ORDER BY j.name
    LIMIT ? OFFSET ?
  `).bind(limit, offset).all<any>()
  
  return (result.results || []).map((row: any) => ({
    job: row as JobRow,
    source_count: row.source_count || 0
  }))
}

