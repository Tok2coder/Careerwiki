import { Miniflare } from 'miniflare'
import * as dotenv from 'dotenv'
import { mergeMajorProfiles } from './etl/mergeMajorProfiles'

dotenv.config({ path: '.dev.vars' })

async function main() {
  console.log('🚀 Starting Major Profile Merge Runner...')
  
  const args = process.argv.slice(2)
  const limitArg = args.find(arg => arg.startsWith('--limit='))
  const limit = limitArg ? parseInt(limitArg.split('=')[1]) : undefined
  
  // majorGb 옵션: --majorGb=1 (일반학과), --majorGb=2 (이색학과)
  const majorGbArg = args.find(arg => arg.startsWith('--majorGb='))
  const majorGb = majorGbArg ? majorGbArg.split('=')[1] as '1' | '2' : undefined
  
  // 특정 전공명: --name=스마트폰콘텐츠과
  const nameArg = args.find(arg => arg.startsWith('--name='))
  const majorName = nameArg ? nameArg.split('=')[1] : undefined
  
  const mf = new Miniflare({
    modules: true,
    script: '',
    d1Databases: { DB: 'edc21e23-c2ac-4693-bb79-389b6914e173' },
    d1Persist: '.wrangler/state/v3/d1'
  })
  
  try {
    const db = await mf.getD1Database('DB')
    console.log('✅ Miniflare initialized\n')
    
    const result = await mergeMajorProfiles(db, { limit, majorGb, majorName })
    
    console.log('\n' + '='.repeat(50))
    console.log('📊 FINAL SUMMARY')
    console.log('='.repeat(50))
    console.log(`Total: ${result.total}, Success: ${result.success}, Failed: ${result.failed}`)
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

