#!/usr/bin/env npx tsx
/**
 * generate-tagging-sql.ts
 * 
 * Part 1.3: 태깅 결과 JSON → SQL INSERT/UPSERT 생성
 * 
 * Usage:
 *   npx tsx scripts/generate-tagging-sql.ts --input tagging-results.json
 *   npx tsx scripts/generate-tagging-sql.ts --input tagging-results.json --output migrations/batch_tagging.sql
 */

import * as fs from 'fs'
import * as path from 'path'

// Type definitions
interface TaggingResult {
  job_id: string
  job_name: string
  source_system?: string
  tagger_version?: string
  status?: string
  
  // Numeric attributes (0-100)
  wlb?: number
  growth?: number
  stability?: number
  income?: number
  teamwork?: number
  solo_deep?: number
  analytical?: number
  creative?: number
  execution?: number
  people_facing?: number
  
  // Categorical attributes
  work_hours?: string
  shift_work?: string
  travel?: string
  remote_possible?: string
  degree_required?: string
  license_required?: string
  experience_required?: string
  
  // Confidence
  _confidence?: number
  _field_confidence?: Record<string, number>
  
  // Evidence
  evidence?: Record<string, string | { source: string; snippet: string; weight: number }[]>
}

interface CLIArgs {
  input: string
  output: string
  taggerVersion: string
  dryRun: boolean
}

// Validation constants
const VALID_WORK_HOURS = ['regular', 'overtime_some', 'overtime_frequent']
const VALID_SHIFT_WORK = ['none', 'possible', 'required']
const VALID_TRAVEL = ['none', 'some', 'frequent']
const VALID_REMOTE = ['none', 'partial', 'full']
const VALID_DEGREE = ['none', 'college', 'bachelor', 'master', 'phd']
const VALID_LICENSE = ['none', 'preferred', 'required', 'multiple_required']
const VALID_EXPERIENCE = ['none', 'entry', 'junior', 'mid', 'senior']

function parseArgs(): CLIArgs {
  const args: CLIArgs = {
    input: 'tagging-results.json',
    output: '',
    taggerVersion: 'tagger-v1.0.0',
    dryRun: false,
  }
  
  for (let i = 2; i < process.argv.length; i++) {
    const arg = process.argv[i]
    if ((arg === '--input' || arg === '-i') && process.argv[i + 1]) {
      args.input = process.argv[++i]
    } else if ((arg === '--output' || arg === '-o') && process.argv[i + 1]) {
      args.output = process.argv[++i]
    } else if (arg === '--version' && process.argv[i + 1]) {
      args.taggerVersion = process.argv[++i]
    } else if (arg === '--dry-run') {
      args.dryRun = true
    } else if (arg === '--help' || arg === '-h') {
      console.log(`
Usage: npx tsx scripts/generate-tagging-sql.ts [options]

Options:
  --input, -i <file>   Input JSON file (default: tagging-results.json)
  --output, -o <file>  Output SQL file (default: auto-generated)
  --version <ver>      Tagger version (default: tagger-v1.0.0)
  --dry-run            Validate only, don't write file
  --help, -h           Show this help
      `)
      process.exit(0)
    }
  }
  
  // Auto-generate output filename
  if (!args.output) {
    const date = new Date().toISOString().split('T')[0].replace(/-/g, '')
    args.output = `migrations/batch_tagging_${date}.sql`
  }
  
  return args
}

function validateNumeric(value: number | undefined, min: number, max: number): number {
  if (value === undefined || value === null) return 50 // default
  const num = Number(value)
  if (isNaN(num)) return 50
  return Math.max(min, Math.min(max, Math.round(num)))
}

function validateEnum(value: string | undefined, allowed: string[], defaultVal: string): string {
  if (!value) return defaultVal
  const lower = value.toLowerCase()
  return allowed.includes(lower) ? lower : defaultVal
}

function escapeSQL(str: string): string {
  if (!str) return ''
  return str.replace(/'/g, "''")
}

interface ValidationError {
  job_id: string
  field: string
  message: string
}

function validateTaggingResult(result: TaggingResult): ValidationError[] {
  const errors: ValidationError[] = []
  
  if (!result.job_id) {
    errors.push({ job_id: 'unknown', field: 'job_id', message: 'job_id is required' })
  }
  
  // Validate numeric fields (0-100)
  const numericFields = ['wlb', 'growth', 'stability', 'income', 'teamwork', 'solo_deep', 'analytical', 'creative', 'execution', 'people_facing']
  for (const field of numericFields) {
    const value = (result as any)[field]
    if (value !== undefined && value !== null) {
      if (typeof value !== 'number' || value < 0 || value > 100) {
        errors.push({ job_id: result.job_id, field, message: `${field} must be 0-100, got ${value}` })
      }
    }
  }
  
  // Validate enum fields
  if (result.work_hours && !VALID_WORK_HOURS.includes(result.work_hours)) {
    errors.push({ job_id: result.job_id, field: 'work_hours', message: `Invalid work_hours: ${result.work_hours}` })
  }
  if (result.shift_work && !VALID_SHIFT_WORK.includes(result.shift_work)) {
    errors.push({ job_id: result.job_id, field: 'shift_work', message: `Invalid shift_work: ${result.shift_work}` })
  }
  if (result.travel && !VALID_TRAVEL.includes(result.travel)) {
    errors.push({ job_id: result.job_id, field: 'travel', message: `Invalid travel: ${result.travel}` })
  }
  if (result.remote_possible && !VALID_REMOTE.includes(result.remote_possible)) {
    errors.push({ job_id: result.job_id, field: 'remote_possible', message: `Invalid remote_possible: ${result.remote_possible}` })
  }
  if (result.degree_required && !VALID_DEGREE.includes(result.degree_required)) {
    errors.push({ job_id: result.job_id, field: 'degree_required', message: `Invalid degree_required: ${result.degree_required}` })
  }
  if (result.license_required && !VALID_LICENSE.includes(result.license_required)) {
    errors.push({ job_id: result.job_id, field: 'license_required', message: `Invalid license_required: ${result.license_required}` })
  }
  
  return errors
}

function generateInsertSQL(result: TaggingResult, taggerVersion: string): string {
  // Normalize values
  const wlb = validateNumeric(result.wlb, 0, 100)
  const growth = validateNumeric(result.growth, 0, 100)
  const stability = validateNumeric(result.stability, 0, 100)
  const income = validateNumeric(result.income, 0, 100)
  const teamwork = validateNumeric(result.teamwork, 0, 100)
  const solo_deep = validateNumeric(result.solo_deep, 0, 100)
  const analytical = validateNumeric(result.analytical, 0, 100)
  const creative = validateNumeric(result.creative, 0, 100)
  const execution = validateNumeric(result.execution, 0, 100)
  const people_facing = validateNumeric(result.people_facing, 0, 100)
  
  const work_hours = validateEnum(result.work_hours, VALID_WORK_HOURS, 'regular')
  const shift_work = validateEnum(result.shift_work, VALID_SHIFT_WORK, 'none')
  const travel = validateEnum(result.travel, VALID_TRAVEL, 'none')
  const remote_possible = validateEnum(result.remote_possible, VALID_REMOTE, 'none')
  const degree_required = validateEnum(result.degree_required, VALID_DEGREE, 'none')
  const license_required = validateEnum(result.license_required, VALID_LICENSE, 'none')
  const experience_required = validateEnum(result.experience_required, VALID_EXPERIENCE, 'none')
  
  const confidence = result._confidence !== undefined ? result._confidence : 0.7
  const fieldConfidenceJson = JSON.stringify(result._field_confidence || {})
  const evidenceJson = JSON.stringify(result.evidence || {})
  
  return `
INSERT INTO job_attributes (
  job_id, job_name, source_system, tagger_version, status,
  wlb, growth, stability, income,
  teamwork, solo_deep, analytical, creative, execution, people_facing,
  work_hours, shift_work, travel, remote_possible,
  degree_required, license_required, experience_required,
  _confidence, _field_confidence_json, evidence_json
) VALUES (
  '${escapeSQL(result.job_id)}',
  '${escapeSQL(result.job_name || '')}',
  '${escapeSQL(result.source_system || 'MERGED')}',
  '${escapeSQL(taggerVersion)}',
  '${escapeSQL(result.status || 'tagged')}',
  ${wlb}, ${growth}, ${stability}, ${income},
  ${teamwork}, ${solo_deep}, ${analytical}, ${creative}, ${execution}, ${people_facing},
  '${work_hours}', '${shift_work}', '${travel}', '${remote_possible}',
  '${degree_required}', '${license_required}', '${experience_required}',
  ${confidence},
  '${escapeSQL(fieldConfidenceJson)}',
  '${escapeSQL(evidenceJson)}'
)
ON CONFLICT(job_id) DO UPDATE SET
  job_name = excluded.job_name,
  tagger_version = excluded.tagger_version,
  status = excluded.status,
  wlb = excluded.wlb,
  growth = excluded.growth,
  stability = excluded.stability,
  income = excluded.income,
  teamwork = excluded.teamwork,
  solo_deep = excluded.solo_deep,
  analytical = excluded.analytical,
  creative = excluded.creative,
  execution = excluded.execution,
  people_facing = excluded.people_facing,
  work_hours = excluded.work_hours,
  shift_work = excluded.shift_work,
  travel = excluded.travel,
  remote_possible = excluded.remote_possible,
  degree_required = excluded.degree_required,
  license_required = excluded.license_required,
  experience_required = excluded.experience_required,
  _confidence = excluded._confidence,
  _field_confidence_json = excluded._field_confidence_json,
  evidence_json = excluded.evidence_json,
  updated_at = CURRENT_TIMESTAMP;`
}

function main() {
  const args = parseArgs()
  
  console.log('📊 Generating tagging SQL...')
  console.log(`   Input: ${args.input}`)
  console.log(`   Output: ${args.output}`)
  console.log(`   Tagger Version: ${args.taggerVersion}`)
  
  // Read input file
  if (!fs.existsSync(args.input)) {
    console.error(`❌ Input file not found: ${args.input}`)
    process.exit(1)
  }
  
  let results: TaggingResult[]
  try {
    const content = fs.readFileSync(args.input, 'utf-8')
    results = JSON.parse(content)
    if (!Array.isArray(results)) {
      results = [results]
    }
  } catch (error: any) {
    console.error(`❌ Failed to parse input file: ${error.message}`)
    process.exit(1)
  }
  
  console.log(`\n✅ Loaded ${results.length} tagging results`)
  
  // Validate all results
  const allErrors: ValidationError[] = []
  for (const result of results) {
    const errors = validateTaggingResult(result)
    allErrors.push(...errors)
  }
  
  if (allErrors.length > 0) {
    console.log(`\n⚠️ Found ${allErrors.length} validation warnings:`)
    allErrors.slice(0, 10).forEach(e => {
      console.log(`   [${e.job_id}] ${e.field}: ${e.message}`)
    })
    if (allErrors.length > 10) {
      console.log(`   ... and ${allErrors.length - 10} more`)
    }
  }
  
  // Generate SQL
  const sqlStatements: string[] = [
    `-- Batch tagging SQL generated at ${new Date().toISOString()}`,
    `-- Tagger version: ${args.taggerVersion}`,
    `-- Total jobs: ${results.length}`,
    '',
    'BEGIN TRANSACTION;',
    '',
  ]
  
  for (const result of results) {
    sqlStatements.push(generateInsertSQL(result, args.taggerVersion))
    sqlStatements.push('')
  }
  
  sqlStatements.push('COMMIT;')
  
  const sqlContent = sqlStatements.join('\n')
  
  if (args.dryRun) {
    console.log('\n📋 Dry run - SQL preview:')
    console.log(sqlContent.slice(0, 2000))
    console.log('...')
    console.log(`\n✅ Validation complete. ${results.length} jobs would be processed.`)
  } else {
    // Ensure output directory exists
    const outputDir = path.dirname(args.output)
    if (outputDir && outputDir !== '.' && !fs.existsSync(outputDir)) {
      fs.mkdirSync(outputDir, { recursive: true })
    }
    
    fs.writeFileSync(args.output, sqlContent, 'utf-8')
    console.log(`\n📁 SQL file saved to: ${args.output}`)
    console.log(`\n🚀 Apply with:`)
    console.log(`   npx wrangler d1 execute careerwiki-db --local --file ${args.output}`)
  }
  
  // Summary
  console.log('\n📊 Summary:')
  console.log(`   Total jobs: ${results.length}`)
  console.log(`   Validation warnings: ${allErrors.length}`)
  console.log(`   Tagger version: ${args.taggerVersion}`)
}

main()
