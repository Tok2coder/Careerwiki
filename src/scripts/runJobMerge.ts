/**
 * CLI Runner for Job Profile Merging
 */

import { Miniflare } from 'miniflare'
import * as dotenv from 'dotenv'
import { mergeJobProfiles } from './etl/mergeJobProfiles'

dotenv.config({ path: '.dev.vars' })

async function main() {
  console.log('🚀 Starting Job Profile Merge Runner...')
  
  const args = process.argv.slice(2)
  const limitArg = args.find(arg => arg.startsWith('--limit='))
  const limit = limitArg ? parseInt(limitArg.split('=')[1]) : undefined
  
  // 특정 직업명 리스트 추출 (--limit= 제외한 나머지 인자들)
  const jobNames = args.filter(arg => !arg.startsWith('--')).filter(Boolean)
  
  console.log(`⚙️  Options: Limit=${limit || 'none'}, JobNames=${jobNames.length > 0 ? jobNames.length + ' jobs' : 'all'}`)
  if (jobNames.length > 0) {
    console.log(`📋 Target jobs: ${jobNames.join(', ')}`)
  }
  
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
    
    const result = await mergeJobProfiles(db, { 
      limit,
      jobNames: jobNames.length > 0 ? jobNames : undefined
    })
    
    console.log('\n' + '='.repeat(50))
    console.log('📊 FINAL SUMMARY')
    console.log('='.repeat(50))
    console.log(`Total:   ${result.total}`)
    console.log(`Success: ${result.success}`)
    console.log(`Failed:  ${result.failed}`)
    console.log(`Time:    ${Math.round((Date.now() - result.startTime) / 1000)}s`)
    
    if (result.errors.length > 0) {
      console.log(`\n❌ Error Details (first 10):`)
      result.errors.slice(0, 10).forEach(e => {
        console.log(`   ${e.id}: ${e.error}`)
      })
    }
    console.log('='.repeat(50))
    
    await mf.dispose()
    process.exit(result.failed > 0 ? 1 : 0)
    
  } catch (error) {
    console.error('❌ Fatal error:', error)
    await mf.dispose()
    process.exit(1)
  }
}

main()

