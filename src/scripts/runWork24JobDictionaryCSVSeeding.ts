/**
 * CLI Runner for Work24 Job Dictionary CSV Seeding
 */

import { Miniflare } from 'miniflare'
import * as dotenv from 'dotenv'
import { seedWork24JobDictionaryFromCSV } from './etl/seedWork24JobDictionaryFromCSV'

dotenv.config({ path: '.dev.vars' })

async function main() {
  console.log('🚀 Starting Work24 Job Dictionary CSV Seeding Runner...')
  
  const authKey = process.env.GOYONG24_JOB_API_KEY
  if (!authKey) {
    console.error('❌ GOYONG24_JOB_API_KEY not found in .dev.vars')
    process.exit(1)
  }
  
  console.log(`⚙️  API Key: ${authKey.substring(0, 8)}...`)
  
  const mf = new Miniflare({
    modules: true,
    script: '',
    d1Databases: { DB: 'edc21e23-c2ac-4693-bb79-389b6914e173' },
    d1Persist: '.wrangler/state/v3/d1'
  })
  
  try {
    const db = await mf.getD1Database('DB')
    console.log('✅ Miniflare initialized\n')
    
    await seedWork24JobDictionaryFromCSV(db, authKey)
    
    await mf.dispose()
    process.exit(0)
  } catch (error) {
    console.error('❌ Fatal error:', error)
    await mf.dispose()
    process.exit(1)
  }
}

main()


