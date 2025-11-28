/**
 * Run all database migrations for the new job sources architecture
 * 
 * Usage:
 * - Local: npm run migrate:run
 * - Production: wrangler d1 migrations apply careerwiki-db --remote
 */

import type { D1Database } from '@cloudflare/workers-types'
import { migrateToJobSources } from './migrateToJobSources'

/**
 * Execute SQL migration files
 */
async function executeMigrationFiles(db: D1Database): Promise<void> {
  console.log('Executing migration files...')
  
  // Note: In production, use wrangler d1 migrations apply command
  // This script is for programmatic execution if needed
  
  console.log('✅ Migration files should be executed via wrangler d1 migrations apply')
  console.log('   Local: wrangler d1 migrations apply careerwiki-db --local')
  console.log('   Remote: wrangler d1 migrations apply careerwiki-db --remote')
}

/**
 * Main migration runner
 */
async function runMigrations(db: D1Database): Promise<void> {
  console.log('='.repeat(60))
  console.log('CareerWiki Database Migration Runner')
  console.log('Job Sources Architecture Migration')
  console.log('='.repeat(60))
  console.log('')
  
  try {
    // Step 1: Execute migration files (create tables, alter tables)
    console.log('Step 1: Execute migration files')
    await executeMigrationFiles(db)
    console.log('')
    
    // Step 2: Run data migration
    console.log('Step 2: Run data migration')
    const report = await migrateToJobSources(db)
    console.log('')
    
    // Step 3: Display summary
    console.log('='.repeat(60))
    console.log('Migration Summary')
    console.log('='.repeat(60))
    console.log(`Jobs migrated: ${report.jobs_migrated}`)
    console.log(`Majors migrated: ${report.majors_migrated}`)
    console.log(`Sources created: ${report.sources_created}`)
    console.log(`Errors: ${report.errors}`)
    console.log(`Duration: ${report.duration_ms}ms`)
    console.log(`Data integrity: ${report.validation.data_integrity}`)
    console.log('')
    
    if (report.warnings.length > 0) {
      console.log('Warnings:')
      report.warnings.forEach(w => console.log(`  ⚠️  ${w}`))
      console.log('')
    }
    
    if (report.validation.data_integrity === 'OK') {
      console.log('✅ Migration completed successfully!')
    } else {
      console.log('❌ Migration completed with issues. Please review:')
      console.log(`   - Jobs without sources: ${report.validation.all_jobs_have_sources ? 0 : 'FAILED'}`)
      console.log(`   - Majors without sources: ${report.validation.all_majors_have_sources ? 0 : 'FAILED'}`)
      console.log(`   - Slug duplicates: ${report.validation.slug_duplicates}`)
    }
    
  } catch (error) {
    console.error('❌ Migration failed:', error)
    throw error
  }
}

// Export for command-line execution
export { runMigrations }

// Cloudflare Worker handler
export default {
  async fetch(request: Request, env: { DB: D1Database }): Promise<Response> {
    try {
      await runMigrations(env.DB)
      return new Response('Migration completed. Check logs for details.', {
        headers: { 'Content-Type': 'text/plain' }
      })
    } catch (error) {
      return new Response(
        `Migration failed: ${error instanceof Error ? error.message : String(error)}`,
        { status: 500, headers: { 'Content-Type': 'text/plain' } }
      )
    }
  }
}

