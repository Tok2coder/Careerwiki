/**
 * API에서 원본 데이터를 다시 가져와서 복구하는 스크립트
 * 
 * 사용법:
 * npx tsx scripts/refetch-job-data.ts <job-slug-or-id>
 */

async function refetchJobData(jobSlug: string) {
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
  console.log(`\n🔄 Fetching original data from API...`)
  
  // 2. API에서 데이터를 강제로 다시 가져와서 api_data_json 업데이트
  const refetchResponse = await fetch(`${baseUrl}/api/job/${encodeURIComponent(jobSlug)}/refetch-api-data`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer dev-admin-token'
    },
    body: JSON.stringify({})
  })
  
  if (!refetchResponse.ok) {
    const error = await refetchResponse.json()
    throw new Error(`Failed to refetch API data: ${error.error || refetchResponse.statusText}`)
  }
  
  const refetchData = await refetchResponse.json()
  console.log(`✅ API data refetched successfully!`)
  console.log(`   Updated: ${refetchData.updated}`)
  if (refetchData.changedFields && refetchData.changedFields.length > 0) {
    console.log(`   Changed fields: ${refetchData.changedFields.join(', ')}`)
  }
  
  // 3. user_contributed_json 비우기 (원본 API 데이터만 표시)
  console.log(`\n🔄 Clearing user_contributed_json...`)
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
  console.log(`✅ ${resetData.message || 'User contributions cleared.'}`)
  
  return { jobId }
}

async function main() {
  const slugOrId = process.argv[2]
  
  if (!slugOrId) {
    console.error('Usage: npx tsx scripts/refetch-job-data.ts <job-slug-or-id>')
    console.error('Example: npx tsx scripts/refetch-job-data.ts "uxui디자이너"')
    process.exit(1)
  }
  
  try {
    const decodedSlug = decodeURIComponent(slugOrId)
    const result = await refetchJobData(decodedSlug)
    
    console.log(`\n✅ Data refetch completed!`)
    console.log(`   Job ID: ${result.jobId}`)
    console.log(`\n📝 Next steps:`)
    console.log(`   1. Refresh the page: http://localhost:3000/job/${encodeURIComponent(decodedSlug)}`)
    console.log(`   2. The page will automatically fetch fresh data from API`)
    console.log(`   3. If data is still missing, check if the job has valid CareerNet/Goyong24 IDs`)
    
  } catch (error) {
    console.error('❌ Error:', error)
    if (error instanceof Error) {
      console.error('   Message:', error.message)
    }
    process.exit(1)
  }
}

main()

