/**
 * CLI Runner for Bidirectional Related Jobs Update
 * 
 * 양방향 연관직업 관계를 업데이트합니다.
 * - mergeJobProfiles 실행 후 사용 권장
 */

import { Miniflare } from 'miniflare'
import * as dotenv from 'dotenv'
import { updateRelatedJobs } from './etl/updateRelatedJobs'

dotenv.config({ path: '.dev.vars' })

async function main() {
  console.log('🔗 Starting Related Jobs Update Runner...')
  
  const args = process.argv.slice(2)
  const limitArg = args.find(arg => arg.startsWith('--limit='))
  const limit = limitArg ? parseInt(limitArg.split('=')[1]) : undefined
  const dryRun = args.includes('--dry-run')
  
  console.log(`⚙️  Options: Limit=${limit || 'none'}, DryRun=${dryRun}`)
  
  const mf = new Miniflare({
    modules: true,
    script: '',
    d1Databases: {
      DB: 'edc21e23-c2ac-4693-bb79-389b6914e173'
    },
    d1Persist: '.wrangler/state/v3/d1'
  })
  
  try {
    const db = await mf.getD1Database('DB')
    console.log('✅ Miniflare initialized\n')
    
    const result = await updateRelatedJobs(db, { limit, dryRun })
    
    console.log('\n' + '='.repeat(50))
    console.log('📊 FINAL SUMMARY')
    console.log('='.repeat(50))
    console.log(`Total:   ${result.total}`)
    console.log(`Updated: ${result.updated}`)
    console.log(`Skipped: ${result.skipped}`)
    console.log(`Errors:  ${result.errors.length}`)
    console.log(`Time:    ${Math.round((Date.now() - result.startTime) / 1000)}s`)
    
    if (result.errors.length > 0) {
      console.log(`\n❌ Error Details (first 10):`)
      result.errors.slice(0, 10).forEach(e => {
        console.log(`   ${e.jobName}: ${e.error}`)
      })
    }
    console.log('='.repeat(50))
    
    await mf.dispose()
    process.exit(result.errors.length > 0 ? 1 : 0)
    
  } catch (error) {
    console.error('❌ Fatal error:', error)
    await mf.dispose()
    process.exit(1)
  }
}

main()

