/**
 * Job Profile Merge Test Runner
 * 샘플 직업들만 병합해서 빠른 테스트
 */

import { readFileSync } from 'fs'
import { join } from 'path'
import { mergeJobProfiles } from './etl/mergeJobProfiles'

// Miniflare setup
import { Miniflare } from 'miniflare'
import { config } from 'dotenv'

// Load .dev.vars
config({ path: '.dev.vars' })

async function main() {
  console.log('🚀 Starting Test Job Profile Merge Runner...')
  
  // Load sample jobs
  const sampleJobsPath = join(process.cwd(), 'test-sample-jobs.json')
  const sampleJobs = JSON.parse(readFileSync(sampleJobsPath, 'utf-8'))
  
  console.log(`📋 Testing with ${sampleJobs.jobs.length} sample jobs`)
  
  // Setup Miniflare
  const mf = new Miniflare({
    script: '',
    modules: true,
    d1Databases: {
      DB: 'edc21e23-c2ac-4693-bb79-389b6914e173'
    },
    d1Persist: '.wrangler/state/v3/d1'
  })
  
  console.log('✅ Miniflare initialized')
  
  try {
    const env = await mf.getBindings()
    const db = env.DB
    
    // Run merge with sample jobs only
    const progress = await mergeJobProfiles(db, {
      jobNames: sampleJobs.jobs
    })
    
    console.log('\n' + '='.repeat(50))
    console.log('📊 FINAL SUMMARY')
    console.log('='.repeat(50))
    console.log(`Total:   ${progress.total}`)
    console.log(`Success: ${progress.success}`)
    console.log(`Failed:  ${progress.failed}`)
    console.log(`Time:    ${Math.round((Date.now() - progress.startTime) / 1000)}s`)
    console.log('='.repeat(50))
    
    if (progress.errors.length > 0) {
      console.log('\n❌ Errors:')
      progress.errors.forEach(err => {
        console.log(`  - ${err.id}: ${err.error}`)
      })
    }
    
  } catch (error) {
    console.error('❌ Error during merge:', error)
    process.exit(1)
  }
  
  process.exit(0)
}

main()

