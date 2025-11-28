import { Miniflare } from 'miniflare'
import * as dotenv from 'dotenv'
import { seedWork24MajorsFromCSV } from './etl/seedWork24MajorsFromCSV'

dotenv.config({ path: '.dev.vars' })

async function main() {
  console.log('🚀 Starting Work24 Majors CSV Seeding Runner...')
  
  const args = process.argv.slice(2)
  const limitArg = args.find(arg => arg.startsWith('--limit='))
  const limit = limitArg ? parseInt(limitArg.split('=')[1]) : undefined
  
  const mf = new Miniflare({
    modules: true,
    script: '',
    bindings: { GOYONG24_MAJOR_API_KEY: process.env.GOYONG24_MAJOR_API_KEY || '' },
    d1Databases: { DB: 'edc21e23-c2ac-4693-bb79-389b6914e173' },
    d1Persist: '.wrangler/state/v3/d1'
  })
  
  try {
    const db = await mf.getD1Database('DB')
    console.log('✅ Miniflare initialized\n')
    
    const result = await seedWork24MajorsFromCSV(db, { DB: db, GOYONG24_MAJOR_API_KEY: process.env.GOYONG24_MAJOR_API_KEY || '' }, { limit })
    
    console.log('\n' + '='.repeat(50))
    console.log('📊 FINAL SUMMARY')
    console.log('='.repeat(50))
    console.log(`Total: ${result.total}, Success: ${result.success}, Skipped: ${result.skipped}, Failed: ${result.failed}`)
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

