# Job Sources Architecture Documentation

## Overview

The Job Sources Architecture separates data collection, normalization, and presentation into distinct layers, making it easier to manage multiple data sources, track data provenance, and support AI-generated content.

## Architecture Layers

```
┌─────────────────────────────────────────────────────────────┐
│ Layer 1: UI Cache (wiki_pages)                              │
│ - Rendered HTML cache                                        │
│ - ISR (Incremental Static Regeneration)                     │
└─────────────────────────────────────────────────────────────┘
                          ↑
┌─────────────────────────────────────────────────────────────┐
│ Layer 2: Entity (jobs, majors)                              │
│ - Canonical page entity                                      │
│ - Merged profile data (api_data_json)                       │
│ - AI-generated content (ai_data_json)                       │
│ - User/admin overrides                                       │
└─────────────────────────────────────────────────────────────┘
                          ↑ ↓
┌─────────────────────────────────────────────────────────────┐
│ Layer 3: Sources (job_sources, major_sources)               │
│ - Individual API responses                                   │
│ - Raw payload (original response)                           │
│ - Normalized payload (UnifiedProfile)                       │
│ - Classification codes for matching                         │
└─────────────────────────────────────────────────────────────┐
                          ↑ ↓
┌─────────────────────────────────────────────────────────────┐
│ Layer 4: Community (comments, assets, revisions)            │
│ - User-contributed content                                   │
│ - Images and visual assets                                   │
│ - Edit history and revisions                                │
└─────────────────────────────────────────────────────────────┘
                          ↑
┌─────────────────────────────────────────────────────────────┐
│ Layer 5: AI (ai_data_json within jobs/majors)               │
│ - AI-generated summaries                                     │
│ - Career pathway recommendations                            │
│ - Student/parent-friendly content                           │
└─────────────────────────────────────────────────────────────┘
```

## Database Schema

### Core Tables

#### jobs / majors
**Purpose**: Canonical page entity (1 page = 1 row)

**Key Fields**:
- `id`: Unique identifier
- `slug`: URL-friendly identifier
- `name`: Display name
- `api_data_json`: Merged profile data from all sources
- `ai_data_json`: AI-generated content sections
- `user_contributed_json`: User overrides
- `admin_data_json`: Admin overrides
- `primary_source`: Which API is authoritative
- `primary_std_code`: Main classification code

#### job_sources / major_sources
**Purpose**: Store individual API responses

**Key Fields**:
- `id`: Auto-increment primary key
- `job_id`/`major_id`: Link to parent entity (NULL if unmatched)
- `source_system`: 'CAREERNET', 'WORK24_JOB', 'WORK24_DJOB', 'WORK24_MAJOR'
- `source_key`: Unique identifier like 'CAREERNET:354'
- `raw_payload`: Complete original API response (JSON)
- `normalized_payload`: Normalized to UnifiedProfile format (JSON)
- Classification codes: `std_job_cd`, `keco_cd`, `ksoc_cd`, `industry_cd`

#### job_match_overrides
**Purpose**: Manual source-to-job matching

**Use Case**: When automatic matching is ambiguous (e.g., "소프트웨어 개발자" vs "SW개발자")

**Key Fields**:
- `job_id`: Target job
- `source_system`, `source_key`: Source to match
- `reason`: Why this match was made
- `confidence`: Matching confidence score (0.0-1.0)
- `created_by`: Admin who created the override

#### job_assets / major_assets
**Purpose**: Images, infographics, charts

**Asset Types**:
- `hero_image`: Main page banner
- `infographic`: Data visualization
- `icon`: Small icon/logo
- `chart`: Statistical chart
- `video_thumbnail`: Video preview image
- `campus_photo`: (majors only) Campus photo

**Asset Sources**:
- `AI`: AI-generated (DALL-E, Midjourney)
- `USER`: User-uploaded
- `ADMIN`: Admin-curated
- `OFFICIAL`: Official source
- `API`: From API response

## Data Flow

### 1. Data Collection (Seeding)

```typescript
// src/scripts/seedAllJobs.ts
for (const jobId of allJobIds) {
  // Fetch from CareerNet
  const careernetData = await fetchCareerNetJobDetail(jobId)
  const careernetNormalized = normalizeCareerNetJobDetail(careernetData)
  
  // Fetch from Work24
  const work24Data = await fetchGoyong24JobDetail(jobId)
  const work24Normalized = normalizeGoyong24JobDetail(work24Data)
  
  // Store sources individually
  await upsertJobSource(db, {
    job_id: canonicalJobId,
    source_system: 'CAREERNET',
    source_key: `CAREERNET:${careernetData.job_cd}`,
    raw_payload: JSON.stringify(careernetData),
    normalized_payload: JSON.stringify(careernetNormalized),
    std_job_cd: careernetData.std_job_cd,
    fetched_at: Date.now(),
    updated_at: Date.now()
  })
  
  // Merge profiles
  const merged = mergeJobProfiles([careernetNormalized, work24Normalized])
  
  // Save merged data to jobs table
  await saveMergedJobProfile(db, canonicalJobId, merged)
}
```

### 2. Data Retrieval (Runtime)

```typescript
// src/services/jobSourceService.ts
export async function getJobWithSources(db: D1Database, jobId: string) {
  // Get job entity
  const job = await db.prepare('SELECT * FROM jobs WHERE id = ?').bind(jobId).first()
  
  // Get all sources
  const sources = await db.prepare('SELECT * FROM job_sources WHERE job_id = ?')
    .bind(jobId).all()
  
  // Parse merged data
  const apiData = JSON.parse(job.api_data_json)
  const aiData = job.ai_data_json ? JSON.parse(job.ai_data_json) : null
  
  return {
    job,
    sources: sources.results,
    merged: apiData.merged,
    ai: aiData
  }
}
```

### 3. Data Rendering

```typescript
// src/index.tsx
app.get('/job/:slug', async (c) => {
  const { job, sources, merged, ai } = await getJobWithSources(c.env.DB, slug)
  
  // Apply user/admin overrides
  const profile = applyOverrides(merged, job.user_contributed_json, job.admin_data_json)
  
  // Inject AI content if available
  if (ai?.sections?.summary_student) {
    profile.aiSummary = ai.sections.summary_student.content
  }
  
  // Render template
  return c.html(renderUnifiedJobDetail({ profile }))
})
```

## Key Benefits

### 1. Data Provenance
Every piece of data can be traced back to its source:
```typescript
const sources = await getJobSources(db, 'software-developer')
// [
//   { source_system: 'CAREERNET', source_key: 'CAREERNET:354', ... },
//   { source_system: 'WORK24_JOB', source_key: 'WORK24_JOB:K000001', ... }
// ]
```

### 2. Flexible Matching
Manual overrides for ambiguous cases:
```typescript
await createMatchOverride(db, {
  job_id: 'software-developer',
  source_system: 'WORK24_JOB',
  source_key: 'WORK24_JOB:K000002',
  reason: 'Same role, different terminology',
  confidence: 0.95,
  created_by: 'admin123'
})
```

### 3. AI Integration
Structured sections for AI-generated content:
```typescript
const aiData: JobAiData = {
  sections: {
    summary_student: {
      content: '소프트웨어 개발자는...',
      source: 'AI',
      model: 'gpt-4',
      prompt_version: 'summary_v2',
      generated_at: Date.now(),
      auto_publish: false  // Needs review
    },
    pathway_ai: {
      content: '소프트웨어 개발자가 되려면...',
      source: 'AI',
      model: 'claude-3-sonnet',
      prompt_version: 'pathway_v1',
      generated_at: Date.now(),
      auto_publish: true
    }
  }
}
```

### 4. Asset Management
Rich visual content with metadata:
```typescript
await addJobAsset(db, {
  job_id: 'software-developer',
  type: 'hero_image',
  source: 'AI',
  url: 'https://r2.careerwiki.org/jobs/software-developer-hero.jpg',
  alt_text: 'Software developer working on code',
  meta_json: JSON.stringify({
    model: 'dall-e-3',
    prompt: 'Professional software developer at desk',
    width: 1920,
    height: 1080
  }),
  display_order: 0,
  is_active: 1
})
```

## Query Patterns

### Search with Source Count
```sql
SELECT 
  j.*,
  COUNT(DISTINCT js.id) as source_count
FROM jobs j
LEFT JOIN job_sources js ON js.job_id = j.id
WHERE j.is_active = 1
  AND j.name LIKE '%developer%'
GROUP BY j.id
ORDER BY source_count DESC
LIMIT 20;
```

### Find by Classification Code
```sql
SELECT j.*, js.source_system, js.source_key
FROM jobs j
JOIN job_sources js ON js.job_id = j.id
WHERE js.keco_cd = '2222'
  AND j.is_active = 1;
```

### Jobs Needing AI Content
```sql
SELECT id, slug, name
FROM jobs
WHERE is_active = 1
  AND (
    ai_data_json IS NULL 
    OR json_extract(ai_data_json, '$.sections.summary_student') IS NULL
  )
LIMIT 100;
```

## Migration Path

### Phase 1: Non-Breaking Changes ✅
- Create new tables (job_sources, major_sources, etc.)
- Add new columns to jobs/majors
- Existing data and code remain functional

### Phase 2: Data Migration ✅
- Extract sources from api_data_json
- Populate job_sources/major_sources
- Generate slugs
- Validate data integrity

### Phase 3: Application Updates 🔄
- Update services to query job_sources
- Add admin UI for source management
- Implement AI content generation
- Update templates as needed

### Phase 4: Optimization ⏳
- Add query indexes
- Optimize merge logic
- Implement caching strategies
- Monitor performance

## API Reference

### jobSourceService.ts

```typescript
// Get job with all sources
const jobData = await getJobWithSources(db, 'software-developer')

// Get job by slug
const jobData = await getJobBySlug(db, 'software-developer')

// Search jobs
const results = await searchJobs(db, 'developer', 20, 0)

// Upsert source
await upsertJobSource(db, {
  job_id: 'software-developer',
  source_system: 'CAREERNET',
  source_key: 'CAREERNET:354',
  raw_payload: '...',
  normalized_payload: '...',
  fetched_at: Date.now(),
  updated_at: Date.now()
})

// Add asset
await addJobAsset(db, {
  job_id: 'software-developer',
  type: 'hero_image',
  source: 'AI',
  url: 'https://...',
  display_order: 0,
  is_active: 1
})
```

## Best Practices

### 1. Always Normalize Sources
Store both raw and normalized payloads:
```typescript
const raw = await fetchCareerNetJobDetail(jobId)
const normalized = normalizeCareerNetJobDetail(raw)

await upsertJobSource(db, {
  raw_payload: JSON.stringify(raw),      // Preserve original
  normalized_payload: JSON.stringify(normalized)  // For merging
})
```

### 2. Use Transactions for Multi-Table Operations
```typescript
const batch = [
  db.prepare('UPDATE jobs SET ...'),
  db.prepare('INSERT INTO job_sources ...'),
  db.prepare('INSERT INTO job_assets ...')
]
await db.batch(batch)
```

### 3. Validate Before Auto-Publishing AI Content
```typescript
if (aiSection.auto_publish && !isValidContent(aiSection.content)) {
  aiSection.auto_publish = false
  aiSection.review_required = true
}
```

### 4. Track Data Freshness
```typescript
const isStale = (job.api_last_fetched_at || 0) < Date.now() - 30 * 24 * 60 * 60 * 1000
if (isStale) {
  // Trigger re-fetch
}
```

## Troubleshooting

### Issue: Sources not showing in debug page

**Check**:
1. Are sources populated in `job_sources` table?
2. Is `job_id` correctly set?
3. Is the service using `getJobWithSources()`?

### Issue: Slug conflicts

**Solution**: Add suffix to duplicate slugs
```sql
UPDATE jobs 
SET slug = 'job-name-2' 
WHERE id = 'duplicate-id' AND slug = 'job-name';
```

### Issue: AI content not displaying

**Check**:
1. Is `ai_data_json` properly formatted?
2. Is `auto_publish` set to `true`?
3. Is the template checking for AI content?

---

**Last Updated**: 2025-01-20  
**Version**: 1.0  
**Related**: See `job-database.plan.md` for original design

