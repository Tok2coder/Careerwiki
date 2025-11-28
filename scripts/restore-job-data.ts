/**
 * 특정 직업 페이지의 데이터 복구 스크립트
 * 
 * 사용법:
 * npx tsx scripts/restore-job-data.ts <job-slug-or-id>
 * 
 * 예시:
 * npx tsx scripts/restore-job-data.ts "uxui디자이너"
 * npx tsx scripts/restore-job-data.ts "K000000123"
 */

// 간단한 복구 스크립트: API 엔드포인트를 통해 복구
// 또는 직접 DB 쿼리로 복구

async function restoreViaAPI(jobSlug: string) {
  const baseUrl = process.env.API_BASE_URL || 'http://localhost:3000'
  
  console.log(`🔍 Fetching revision history for: ${jobSlug}`)
  
  // 1. Revision history 조회
  const revisionsResponse = await fetch(`${baseUrl}/api/job/${encodeURIComponent(jobSlug)}/revisions`, {
    headers: {
      'Authorization': 'Bearer dev-admin-token' // 로컬 개발용
    }
  })
  
  if (!revisionsResponse.ok) {
    const error = await revisionsResponse.json()
    throw new Error(`Failed to fetch revisions: ${error.error || revisionsResponse.statusText}`)
  }
  
  const revisionsData = await revisionsResponse.json()
  const revisions = revisionsData.data?.revisions || []
  
  if (revisions.length === 0) {
    throw new Error('No revisions found')
  }
  
  console.log(`\n📋 Found ${revisions.length} revisions:`)
  revisions.forEach((rev: any, index: number) => {
    const isCurrent = rev.isCurrent ? ' [CURRENT]' : ''
    console.log(`\n${index + 1}. Revision ${rev.revisionNumber} (ID: ${rev.id})${isCurrent}`)
    console.log(`   Editor: ${rev.editorName || 'Unknown'} (${rev.editorType})`)
    console.log(`   Type: ${rev.changeType}`)
    console.log(`   Summary: ${rev.changeSummary || 'N/A'}`)
    console.log(`   Changed fields: ${rev.changedFields?.length || 0}`)
    console.log(`   Created: ${rev.createdAt}`)
  })
  
  // 가장 오래된 revision (초기 데이터) 찾기
  // Revision 1이 가장 많은 원본 데이터를 포함할 가능성이 높음
  const oldestRevision = revisions[revisions.length - 1]  // 가장 오래된 revision (Revision 1)
  
  console.log(`\n💡 Restoring to oldest revision (most complete data): Revision ${oldestRevision.revisionNumber} (ID: ${oldestRevision.id})`)
  
  const targetRevision = oldestRevision
  
  // 2. user_contributed_json 비우기 (원본 API 데이터 표시)
  console.log(`\n🔄 Clearing user_contributed_json to show original API data...`)
  const resetResponse = await fetch(`${baseUrl}/api/job/${encodeURIComponent(jobSlug)}/reset-contributions`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer dev-admin-token'
    },
    body: JSON.stringify({})
  })
  
  if (!resetResponse.ok) {
    const error = await resetResponse.json()
    throw new Error(`Failed to reset contributions: ${error.error || resetResponse.statusText}`)
  }
  
  const resetData = await resetResponse.json()
  console.log(`✅ Successfully cleared user contributions!`)
  console.log(`   ${resetData.message || 'Original API data will now be displayed.'}`)
  
  return resetData
}

async function findJobId(db: D1Database, slugOrId: string): Promise<string | null> {
  // 1. ID로 직접 조회 시도
  let job = await db.prepare('SELECT id, name FROM jobs WHERE id = ? AND is_active = 1')
    .bind(slugOrId)
    .first<{ id: string; name: string }>()
  
  if (job) {
    console.log(`✅ Job found by ID: ${job.id} (${job.name})`)
    return job.id
  }
  
  // 2. URL 디코딩된 slug로 조회
  const decodedSlug = decodeURIComponent(slugOrId)
  const normalizedSlug = decodedSlug.toLowerCase()
  
  // 정규화된 slug로 조회
  job = await db.prepare(
    'SELECT id, name FROM jobs WHERE LOWER(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(name, "-", ""), ",", ""), "·", ""), "ㆍ", ""), "/", ""), " ", ""), "(", ""), ")", "")) = ? AND is_active = 1 LIMIT 1'
  ).bind(normalizedSlug).first<{ id: string; name: string }>()
  
  if (job) {
    console.log(`✅ Job found by normalized slug: ${job.id} (${job.name})`)
    return job.id
  }
  
  // 3. 정확한 이름으로 조회
  job = await db.prepare(
    'SELECT id, name FROM jobs WHERE LOWER(name) = ? AND is_active = 1 LIMIT 1'
  ).bind(normalizedSlug).first<{ id: string; name: string }>()
  
  if (job) {
    console.log(`✅ Job found by name: ${job.id} (${job.name})`)
    return job.id
  }
  
  // 4. 부분 일치로 조회
  job = await db.prepare(
    'SELECT id, name FROM jobs WHERE LOWER(name) LIKE ? AND is_active = 1 LIMIT 1'
  ).bind(`%${normalizedSlug}%`).first<{ id: string; name: string }>()
  
  if (job) {
    console.log(`✅ Job found by partial match: ${job.id} (${job.name})`)
    return job.id
  }
  
  console.error(`❌ Job not found: ${slugOrId}`)
  return null
}

async function listRevisions(db: D1Database, jobId: string) {
  const revisions = await db.prepare(`
    SELECT 
      id,
      revision_number,
      is_current,
      editor_name,
      editor_type,
      change_type,
      change_summary,
      changed_fields,
      created_at,
      data_snapshot
    FROM page_revisions
    WHERE entity_type = 'job' AND entity_id = ?
    ORDER BY revision_number DESC
    LIMIT 20
  `).bind(jobId).all<{
    id: number
    revision_number: number
    is_current: number
    editor_name: string | null
    editor_type: string
    change_type: string
    change_summary: string | null
    changed_fields: string | null
    created_at: string
    data_snapshot: string
  }>()
  
  return revisions.results || []
}

async function restoreToRevision(db: D1Database, revisionId: number) {
  const { restoreRevision } = await import('../src/services/revisionService')
  
  try {
    const restored = await restoreRevision(db, revisionId, null, null)
    console.log(`✅ Successfully restored to revision ${restored.revisionNumber}`)
    return restored
  } catch (error) {
    console.error(`❌ Failed to restore revision ${revisionId}:`, error)
    throw error
  }
}

async function main() {
  const slugOrId = process.argv[2]
  
  if (!slugOrId) {
    console.error('Usage: npx tsx scripts/restore-job-data.ts <job-slug-or-id>')
    console.error('Example: npx tsx scripts/restore-job-data.ts "uxui디자이너"')
    process.exit(1)
  }
  
  try {
    console.log(`🔍 Restoring data for job: ${slugOrId}`)
    
    // URL 디코딩된 slug 사용
    const decodedSlug = decodeURIComponent(slugOrId)
    await restoreViaAPI(decodedSlug)
    
    console.log(`\n✅ Data restoration completed!`)
    console.log(`   Please refresh the page: http://localhost:3000/job/${encodeURIComponent(decodedSlug)}`)
    
  } catch (error) {
    console.error('❌ Error:', error)
    if (error instanceof Error) {
      console.error('   Message:', error.message)
    }
    process.exit(1)
  }
}

main()

