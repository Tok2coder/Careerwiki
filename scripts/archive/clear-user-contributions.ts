/**
 * user_contributed_json을 비워서 원본 API 데이터를 표시하는 스크립트
 * 
 * 사용법:
 * npx tsx scripts/clear-user-contributions.ts <job-slug-or-id>
 */

async function clearUserContributions(jobSlug: string) {
  const baseUrl = process.env.API_BASE_URL || 'http://localhost:3000'
  
  console.log(`🔍 Finding job: ${jobSlug}`)
  
  // 1. Job ID 찾기 (revisions API를 통해)
  const revisionsResponse = await fetch(`${baseUrl}/api/job/${encodeURIComponent(jobSlug)}/revisions`, {
    headers: {
      'Authorization': 'Bearer dev-admin-token'
    }
  })
  
  if (!revisionsResponse.ok) {
    const error = await revisionsResponse.json()
    throw new Error(`Failed to fetch revisions: ${error.error || revisionsResponse.statusText}`)
  }
  
  const revisionsData = await revisionsResponse.json()
  const revisions = revisionsData.data?.revisions || []
  
  if (revisions.length === 0) {
    throw new Error('No revisions found - cannot determine job ID')
  }
  
  // 첫 번째 revision에서 entityId 추출
  const jobId = revisions[0].entityId
  
  console.log(`✅ Found job ID: ${jobId}`)
  console.log(`\n🔄 Clearing user_contributed_json to show original API data...`)
  
  // 2. 직접 DB 업데이트 (API 엔드포인트가 없으므로 직접 구현)
  // 대신 edit API를 사용하여 빈 데이터로 업데이트
  // 또는 직접 DB 쿼리 실행
  
  console.log(`\n⚠️  This requires direct database access.`)
  console.log(`   Please use the following SQL command:`)
  console.log(`   UPDATE jobs SET user_contributed_json = '{}', user_last_updated_at = ${Date.now()} WHERE id = '${jobId}';`)
  
  return { jobId }
}

async function main() {
  const slugOrId = process.argv[2]
  
  if (!slugOrId) {
    console.error('Usage: npx tsx scripts/clear-user-contributions.ts <job-slug-or-id>')
    console.error('Example: npx tsx scripts/clear-user-contributions.ts "uxui디자이너"')
    process.exit(1)
  }
  
  try {
    const decodedSlug = decodeURIComponent(slugOrId)
    const result = await clearUserContributions(decodedSlug)
    
    console.log(`\n✅ Job ID found: ${result.jobId}`)
    console.log(`\n📝 Next steps:`)
    console.log(`   1. Connect to your D1 database`)
    console.log(`   2. Run: UPDATE jobs SET user_contributed_json = '{}' WHERE id = '${result.jobId}';`)
    console.log(`   3. Refresh the page to see original API data`)
    
  } catch (error) {
    console.error('❌ Error:', error)
    if (error instanceof Error) {
      console.error('   Message:', error.message)
    }
    process.exit(1)
  }
}

main()

