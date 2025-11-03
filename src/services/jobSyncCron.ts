/**
 * Job Sync Cron Service
 * 2주일에 1번 API 데이터 동기화
 */

import { getUnifiedJobDetailWithRawData } from './profileDataService'
import { getAllActiveJobIds, updateApiData, getRecentUpdates } from './jobStorage'

// Cron 핸들러 (2주일에 1번 실행)
export async function syncJobsWithAPI(env: any): Promise<{
  total: number
  updated: number
  unchanged: number
  errors: string[]
}> {
  console.log('🔄 Starting biweekly job sync...')
  
  const stats = {
    total: 0,
    updated: 0,
    unchanged: 0,
    errors: [] as string[]
  }
  
  try {
    // 1. 모든 활성 직업 ID 가져오기
    const jobIds = await getAllActiveJobIds(env.DB)
    stats.total = jobIds.length
    
    console.log(`📊 Total jobs to sync: ${jobIds.length}`)
    
    // 2. 각 직업 순회하며 API 데이터 가져와서 비교
    for (const jobId of jobIds) {
      try {
        // Rate limiting: 각 요청 사이 500ms 대기
        await sleep(500)
        
        console.log(`🔍 Checking ${jobId}...`)
        
        // API에서 최신 데이터 가져오기
        const result = await getUnifiedJobDetailWithRawData(
          { id: jobId, includeSources: ['CAREERNET', 'GOYONG24'] },
          env
        )
        
        if (!result.profile) {
          console.log(`⚠️ No data for ${jobId}, keeping existing data`)
          stats.unchanged++
          continue
        }
        
        // DB 업데이트 (변경 시에만)
        const { updated, changedFields } = await updateApiData(
          env.DB,
          jobId,
          result.profile
        )
        
        if (updated) {
          console.log(`✅ Updated ${jobId}: ${changedFields.join(', ')}`)
          stats.updated++
        } else {
          console.log(`✓ No changes for ${jobId}`)
          stats.unchanged++
        }
        
      } catch (error) {
        const errorMsg = `Error syncing ${jobId}: ${error}`
        console.error(`❌ ${errorMsg}`)
        stats.errors.push(errorMsg)
      }
    }
    
    // 3. 결과 요약
    console.log('📈 Sync completed!')
    console.log(`   Total: ${stats.total}`)
    console.log(`   Updated: ${stats.updated}`)
    console.log(`   Unchanged: ${stats.unchanged}`)
    console.log(`   Errors: ${stats.errors.length}`)
    
    // 4. 최근 업데이트 로그 출력
    const recentUpdates = await getRecentUpdates(env.DB, 10)
    console.log('📋 Recent updates:')
    for (const update of recentUpdates) {
      console.log(`   - ${update.jobName}: ${update.changedFields.join(', ')}`)
    }
    
  } catch (error) {
    console.error('💥 Sync failed:', error)
    stats.errors.push(`Fatal error: ${error}`)
  }
  
  return stats
}

// Sleep helper
function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms))
}

// 특정 직업만 강제 업데이트 (관리자 도구)
export async function forceUpdateJob(
  env: any,
  jobId: string
): Promise<{ success: boolean; changedFields: string[] }> {
  try {
    const result = await getUnifiedJobDetailWithRawData(
      { id: jobId, includeSources: ['CAREERNET', 'GOYONG24'] },
      env
    )
    
    if (!result.profile) {
      return { success: false, changedFields: [] }
    }
    
    const { updated, changedFields } = await updateApiData(
      env.DB,
      jobId,
      result.profile,
      { forceUpdate: true }
    )
    
    return { success: updated, changedFields }
  } catch (error) {
    console.error(`Error force updating ${jobId}:`, error)
    return { success: false, changedFields: [] }
  }
}
