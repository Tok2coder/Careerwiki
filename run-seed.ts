#!/usr/bin/env tsx
import { seedAllJobsToD1 } from './src/scripts/seedAllJobs'

// Mock environment for direct execution
const mockEnv = {
  DB: null as any, // Will use D1 via wrangler
  CAREER_NET_API_KEY: process.env.CAREER_NET_API_KEY || '',
  GOYONG24_MAJOR_API_KEY: process.env.GOYONG24_MAJOR_API_KEY || '',
  GOYONG24_JOB_API_KEY: process.env.GOYONG24_JOB_API_KEY || '',
  ENVIRONMENT: 'production' as const
}

async function main() {
  console.log('⚠️  Direct D1 access from Node.js is not supported.')
  console.log('📝 Use the API endpoint instead:')
  console.log('')
  console.log('   curl -X POST "http://localhost:3002/api/admin/seed-jobs?limit=10"')
  console.log('')
  console.log('Or check the seed endpoint in the browser:')
  console.log('   http://localhost:3002/api/admin/seed-jobs?limit=10')
}

main()
