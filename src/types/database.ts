/**
 * Database schema types for the new job/major source architecture
 * Based on job-database.plan.md
 */

import type { UnifiedJobDetail, UnifiedMajorDetail } from './unifiedProfiles'

// ============================================================================
// Source Tables
// ============================================================================

/**
 * job_sources table row
 * Stores individual API responses for jobs
 */
export interface JobSourceRow {
  id: number
  job_id: string | null
  source_system: 'CAREERNET' | 'WORK24_JOB' | 'WORK24_DJOB'
  source_key: string  // e.g., 'CAREERNET:354', 'WORK24_JOB:K000007482'
  source_type?: 'LIST' | 'DETAIL' | 'ENCYCLOPEDIA' | 'DICTIONARY' | null
  std_job_cd?: string | null
  keco_cd?: string | null
  ksoc_cd?: string | null
  industry_cd?: string | null
  raw_payload: string        // JSON string of original API response
  normalized_payload: string // JSON string of Partial<UnifiedJobDetail>
  fetched_at: number
  updated_at: number
  last_error?: string | null
  retry_count?: number | null
}

/**
 * major_sources table row
 * Stores individual API responses for majors
 */
export interface MajorSourceRow {
  id: number
  major_id: string | null
  source_system: 'CAREERNET' | 'WORK24_MAJOR'
  source_key: string
  source_type?: 'LIST' | 'DETAIL_UNIV' | 'DETAIL_HIGH' | 'DETAIL_GENERAL' | 'DETAIL_SPECIAL' | null
  major_seq?: string | null
  department_cd?: string | null
  track?: string | null  // '고등학교', '대학교', '공통'
  gubun?: string | null  // '고등학교', '대학교' (CareerNet)
  raw_payload: string
  normalized_payload: string
  fetched_at: number
  updated_at: number
  last_error?: string | null
  retry_count?: number | null
}

/**
 * job_match_overrides table row
 * Manual matching overrides for ambiguous cases
 */
export interface JobMatchOverrideRow {
  id: number
  job_id: string
  source_system: 'CAREERNET' | 'WORK24_JOB' | 'WORK24_DJOB'
  source_key: string
  reason?: string | null
  confidence?: number | null
  created_by?: string | null
  created_at: number
  updated_at?: number | null
}

// ============================================================================
// Asset Tables
// ============================================================================

export type JobAssetType = 'hero_image' | 'infographic' | 'icon' | 'chart' | 'video_thumbnail' | 'other'
export type MajorAssetType = 'hero_image' | 'infographic' | 'icon' | 'chart' | 'campus_photo' | 'other'
export type AssetSource = 'AI' | 'USER' | 'ADMIN' | 'OFFICIAL' | 'API'

/**
 * job_assets table row
 */
export interface JobAssetRow {
  id: number
  job_id: string
  type: JobAssetType
  source: AssetSource
  url: string
  caption?: string | null
  alt_text?: string | null
  meta_json?: string | null  // JSON string
  display_order: number
  is_active: number  // 0 or 1
  created_at: number
  updated_at?: number | null
}

/**
 * major_assets table row
 */
export interface MajorAssetRow {
  id: number
  major_id: string
  type: MajorAssetType
  source: AssetSource
  url: string
  caption?: string | null
  alt_text?: string | null
  meta_json?: string | null
  display_order: number
  is_active: number
  created_at: number
  updated_at?: number | null
}

/**
 * Asset metadata examples
 */
export interface AssetMetadata {
  // For AI-generated images
  model?: string              // 'dall-e-3', 'midjourney', etc.
  prompt?: string
  generation_id?: string
  
  // For all images
  width?: number
  height?: number
  file_size?: number
  mime_type?: string
  
  // For user uploads
  original_filename?: string
  uploaded_by?: string
  
  // For charts
  chart_type?: string
  data_source?: string
  generated_at?: number
  
  // Licensing
  license?: string
  attribution?: string
}

// ============================================================================
// Job/Major Table Extended Rows
// ============================================================================

/**
 * jobs table row (with new fields from migration 0016)
 */
export interface JobRow {
  id: string
  careernet_id?: string | null
  goyong24_id?: string | null
  name: string
  api_data_json?: string | null
  api_data_hash?: string | null
  api_last_fetched_at?: number | null
  api_last_updated_at?: number | null
  user_contributed_json?: string | null
  user_last_updated_at?: number | null
  admin_data_json?: string | null
  admin_last_updated_at?: number | null
  created_at: number
  is_active: number
  
  // New fields from migration 0016
  slug?: string | null
  ai_data_json?: string | null
  ai_last_updated_at?: number | null
  primary_source?: 'CAREERNET' | 'WORK24_JOB' | 'WORK24_DJOB' | null
  primary_std_code?: string | null
  name_en?: string | null
}

/**
 * majors table row (with new fields from migration 0016)
 */
export interface MajorRow {
  id: string
  careernet_id?: string | null
  goyong24_id?: string | null
  name: string
  api_data_json?: string | null
  api_data_hash?: string | null
  api_last_fetched_at?: number | null
  api_last_updated_at?: number | null
  user_contributed_json?: string | null
  user_last_updated_at?: number | null
  admin_data_json?: string | null
  admin_last_updated_at?: number | null
  created_at: number
  is_active: number
  
  // New fields from migration 0016
  slug?: string | null
  ai_data_json?: string | null
  ai_last_updated_at?: number | null
  primary_source?: 'CAREERNET' | 'WORK24_MAJOR' | null
  name_en?: string | null
}

// ============================================================================
// JSON Column Types
// ============================================================================

/**
 * jobs.api_data_json structure
 * Simplified structure with source summary
 */
export interface JobApiData {
  merged: UnifiedJobDetail  // Merged final view
  
  sourcesSummary: {
    careernet?: {
      job_cd: string
      std_job_cd?: string
      last_updated?: number
      url?: string
    }
    work24_job?: {
      jobCd: string
      inqYear?: number
    }
    work24_djob?: {
      dJobCd: string
      dJobCdSeq: string
      inqYear?: string
    }
  }
  
  lastMergedAt: number  // When merge was performed
  mergeVersion: string  // e.g., 'v2.0' - for cache invalidation
}

/**
 * majors.api_data_json structure
 */
export interface MajorApiData {
  merged: UnifiedMajorDetail
  
  sourcesSummary: {
    careernet?: {
      major_seq: string
      last_updated?: number
    }
    work24_major?: {
      majorGb: '1' | '2'
      departmentId: string
      majorId: string
    }
  }
  
  lastMergedAt: number
  mergeVersion: string
}

/**
 * AI section metadata
 */
export interface AiSection {
  content: string          // Actual text/HTML
  source: 'AI'
  model: string            // 'gpt-4', 'claude-3-sonnet', etc.
  prompt_version: string   // 'pathway_v1', 'summary_v2'
  generated_at: number     // Unix timestamp
  auto_publish: boolean    // true = show immediately, false = needs review
  reviewed_by?: string     // Admin user id if reviewed
  reviewed_at?: number
}

/**
 * jobs.ai_data_json / majors.ai_data_json structure
 * AI-generated content sections
 */
export interface JobAiData {
  sections: {
    // Core sections
    pathway_ai?: AiSection          // "되는 길" - career pathway
    summary_student?: AiSection     // Student-friendly summary
    summary_parent?: AiSection      // Parent-friendly summary
    
    // Educational
    faq?: AiSection                 // Q&A format
    tips_study?: AiSection          // Study tips
    tips_career?: AiSection         // Career tips
    
    // Storytelling
    day_in_life?: AiSection         // Day in the life story
    success_story?: AiSection       // Success case story
    
    // Images
    hero_image_caption?: AiSection  // Main image caption/alt
    infographic_data?: AiSection    // Data for infographic generation
    
    // Custom sections (extensible)
    [key: `custom_${string}`]: AiSection
  }
  
  // Generation metadata
  generation_history?: Array<{
    section_key: string
    generated_at: number
    model: string
    auto_published: boolean
  }>
}

/**
 * Alias for majors (same structure)
 */
export type MajorAiData = JobAiData

/**
 * jobs.user_contributed_json / admin_data_json
 * Partial override pattern
 */
export interface JobOverrideData {
  // Core fields that can be overridden
  summary?: string
  work?: string[]
  duties?: string
  
  // Pathway overrides
  pathway?: {
    education?: string
    training?: string
    typical_route?: string
    user_notes?: string    // User's personal experience
    admin_notes?: string   // Official curated notes
  }
  
  // Additional content
  extra_sections?: {
    [sectionId: string]: {
      title: string
      content: string
      author?: string
      created_at?: number
    }
  }
  
  // Override specific fields
  overrides?: {
    [field: string]: any  // Flexible override
  }
}

/**
 * Alias for majors (same structure)
 */
export type MajorOverrideData = JobOverrideData

// ============================================================================
// Service Layer Types
// ============================================================================

/**
 * Result type for getJobWithSources()
 */
export interface JobWithSources {
  job: JobRow
  sources: JobSourceRow[]
  assets?: JobAssetRow[]
}

/**
 * Result type for getMajorWithSources()
 */
export interface MajorWithSources {
  major: MajorRow
  sources: MajorSourceRow[]
  assets?: MajorAssetRow[]
}

/**
 * Migration report structure
 */
export interface MigrationReport {
  timestamp: string
  duration_ms: number
  jobs_migrated: number
  majors_migrated: number
  sources_created: number
  errors: number
  warnings: string[]
  validation: {
    all_jobs_have_sources: boolean
    all_majors_have_sources: boolean
    slug_duplicates: number
    data_integrity: 'OK' | 'FAILED'
  }
}

