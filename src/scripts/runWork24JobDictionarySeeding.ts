/**
 * CLI Runner for Work24 Job Dictionary Seeding
 * Miniflare로 D1 연결 후 seedWork24JobDictionary 실행
 */

import { Miniflare } from 'miniflare'
import * as dotenv from 'dotenv'
import { seedWork24JobDictionary } from './etl/seedWork24JobDictionary'

dotenv.config({ path: '.dev.vars' })

async function main() {
  console.log('🚀 Starting Work24 Job Dictionary Seeding Runner...')
  console.log('🔧 Initializing Miniflare...')
  
  // Parse command line arguments
  const args = process.argv.slice(2)
  const limitArg = args.find(arg => arg.startsWith('--limit='))
  const skipExisting = !args.includes('--no-skip')
  const limit = limitArg ? parseInt(limitArg.split('=')[1]) : undefined
  
  console.log(`⚙️  Options:`)
  console.log(`   Limit: ${limit || 'none (all records)'}`)
  console.log(`   Skip existing: ${skipExisting}`)
  
  const mf = new Miniflare({
    modules: true,
    script: '',
    bindings: {
      WORK24_SERVICE_KEY: process.env.WORK24_SERVICE_KEY || '',
      GOYONG24_JOB_API_KEY: process.env.GOYONG24_JOB_API_KEY || '',
      CAREERNET_API_KEY: process.env.CAREERNET_API_KEY || ''
    },
    d1Databases: {
      DB: 'edc21e23-c2ac-4693-bb79-389b6914e173'
    },
    d1Persist: '.wrangler/state/v3/d1'
  })
  
  try {
    const db = await mf.getD1Database('DB')
    console.log('✅ Miniflare initialized')
    console.log('')
    
    const env: any = {
      DB: db,
      WORK24_SERVICE_KEY: process.env.WORK24_SERVICE_KEY || process.env.GOYONG24_JOB_API_KEY || '',
      CAREERNET_API_KEY: process.env.CAREERNET_API_KEY || ''
    }
    
    const result = await seedWork24JobDictionary(db, env, {
      limit,
      skipExisting,
      maxRetries: 3
    })
    
    console.log('\n' + '='.repeat(50))
    console.log('📊 FINAL SUMMARY')
    console.log('='.repeat(50))
    console.log(`Total:   ${result.total}`)
    console.log(`Success: ${result.success}`)
    console.log(`Failed:  ${result.failed}`)
    console.log(`Skipped: ${result.skipped}`)
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

