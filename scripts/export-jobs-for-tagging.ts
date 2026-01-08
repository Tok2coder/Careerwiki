#!/usr/bin/env npx tsx
/**
 * export-jobs-for-tagging.ts
 * 
 * Part 1.1: 태깅 대상 직업 추출 스크립트
 * 미태깅 직업만 추출하여 JSON 형식으로 출력
 * 
 * Usage:
 *   npx tsx scripts/export-jobs-for-tagging.ts --limit 50
 *   npx tsx scripts/export-jobs-for-tagging.ts --limit 50 --offset 100 --output jobs_batch2.json
 */

import { execSync } from 'child_process'
import * as fs from 'fs'
import * as path from 'path'

interface CLIArgs {
  limit: number
  offset: number
  output: string
  source?: string  // 'CAREERNET' | 'WORK24_JOB' | 'MERGED'
  statusFilter: string  // 'pending' | 'stubbed' | 'all'
}

function parseArgs(): CLIArgs {
  const args: CLIArgs = {
    limit: 50,
    offset: 0,
    output: 'jobs_for_tagging.json',
    statusFilter: 'pending',
  }
  
  for (let i = 2; i < process.argv.length; i++) {
    const arg = process.argv[i]
    if (arg === '--limit' && process.argv[i + 1]) {
      args.limit = parseInt(process.argv[++i], 10)
    } else if (arg === '--offset' && process.argv[i + 1]) {
      args.offset = parseInt(process.argv[++i], 10)
    } else if (arg === '--output' && process.argv[i + 1]) {
      args.output = process.argv[++i]
    } else if (arg === '--source' && process.argv[i + 1]) {
      args.source = process.argv[++i]
    } else if (arg === '--status' && process.argv[i + 1]) {
      args.statusFilter = process.argv[++i]
    } else if (arg === '--help' || arg === '-h') {
      console.log(`
Usage: npx tsx scripts/export-jobs-for-tagging.ts [options]

Options:
  --limit <n>     Number of jobs to export (default: 50)
  --offset <n>    Skip first n jobs (default: 0)
  --output <file> Output file name (default: jobs_for_tagging.json)
  --source <src>  Filter by source system (CAREERNET, WORK24_JOB, MERGED)
  --status <s>    Filter by status: pending, stubbed, all (default: pending)
  --help, -h      Show this help
      `)
      process.exit(0)
    }
  }
  
  return args
}

function executeD1Query(query: string): string {
  try {
    // Clean query - remove newlines and extra spaces
    const cleanQuery = query.replace(/\s+/g, ' ').trim()
    const cmd = `npx wrangler d1 execute careerwiki-db --local --json --command="${cleanQuery.replace(/"/g, '\\"')}"`
    
    const result = execSync(cmd, { 
      encoding: 'utf-8', 
      maxBuffer: 50 * 1024 * 1024,
      stdio: ['pipe', 'pipe', 'pipe']
    })
    return result
  } catch (error: any) {
    console.error('D1 query failed:', error.message)
    if (error.stderr) console.error('Stderr:', error.stderr.toString())
    throw error
  }
}

interface JobSourceRow {
  job_id: string
  job_name: string
  source_system: string
  normalized_payload: string
  raw_payload: string
  tagging_status: string | null
}

// WORK24_DJOB raw_payload 필드를 정규화된 형식으로 변환
function normalizeWork24DJob(raw: any): any {
  if (!raw || typeof raw !== 'object') return {}
  
  const optionInfo = raw.optionJobInfo || {}
  
  // 학력/경력 정보를 qualifications로 조합
  const qualParts: string[] = []
  if (optionInfo.eduLevel) qualParts.push(`학력: ${optionInfo.eduLevel}`)
  if (optionInfo.skillYear) qualParts.push(`경력: ${optionInfo.skillYear}`)
  
  // 업무 환경 정보 조합
  const envParts: string[] = []
  if (optionInfo.workPlace) envParts.push(`근무장소: ${optionInfo.workPlace}`)
  if (optionInfo.workStrong) envParts.push(`작업강도: ${optionInfo.workStrong}`)
  if (optionInfo.physicalAct) envParts.push(`신체활동: ${optionInfo.physicalAct.replace(/\|/g, ', ')}`)
  
  return {
    name: raw.dJobNm || '',
    duties: [raw.workSum, raw.doWork].filter(Boolean).join('\n\n'),
    environment: envParts.join(', '),
    qualifications: qualParts.join(', '),
    outlook: '',
    salary_info: '',
    related_majors: [],
    related_licenses: [],
    classifications: {
      keco: optionInfo.dJobECd ? { code: optionInfo.dJobECd, name: optionInfo.dJobECdNm } : undefined,
      ksoc: optionInfo.dJobJCd ? { code: optionInfo.dJobJCd, name: optionInfo.dJobJCdNm } : undefined,
      industry: optionInfo.dJobICd ? { code: optionInfo.dJobICd, name: optionInfo.dJobICdNm } : undefined,
    },
    similar_jobs: optionInfo.similarNm || '',
  }
}

function main() {
  const args = parseArgs()
  
  console.log('🔍 Exporting jobs for tagging...')
  console.log(`   Limit: ${args.limit}, Offset: ${args.offset}`)
  console.log(`   Status filter: ${args.statusFilter}`)
  if (args.source) console.log(`   Source filter: ${args.source}`)
  
  // Build query
  // 1. Get jobs from job_sources that are not in job_attributes OR have pending/stubbed status
  let query: string
  
  // Use GROUP BY to deduplicate jobs with same job_id from different sources
  // Prefer MERGED > CAREERNET > WORK24_JOB
  const sourceFilter = args.source ? `AND js.source_system = '${args.source}'` : ''
  const qualityFilter = args.source === 'CAREERNET' ? `AND json_extract(js.normalized_payload, '$.duties') != '' AND LENGTH(json_extract(js.normalized_payload, '$.duties')) > 50` : ''

  if (args.statusFilter === 'all') {
    query = `SELECT js.job_id, MAX(json_extract(js.normalized_payload, '$.name')) as job_name, MAX(js.source_system) as source_system, MAX(js.normalized_payload) as normalized_payload, MAX(js.raw_payload) as raw_payload, MAX(ja.status) as tagging_status FROM job_sources js LEFT JOIN job_attributes ja ON js.job_id = ja.job_id WHERE ja.id IS NULL OR ja.status IN ('pending', 'stubbed') ${sourceFilter} ${qualityFilter} GROUP BY js.job_id ORDER BY js.job_id LIMIT ${args.limit} OFFSET ${args.offset}`
  } else {
    query = `SELECT js.job_id, MAX(json_extract(js.normalized_payload, '$.name')) as job_name, MAX(js.source_system) as source_system, MAX(js.normalized_payload) as normalized_payload, MAX(js.raw_payload) as raw_payload, COALESCE(MAX(ja.status), 'not_started') as tagging_status FROM job_sources js LEFT JOIN job_attributes ja ON js.job_id = ja.job_id WHERE ja.id IS NULL OR ja.status = '${args.statusFilter}' ${sourceFilter} ${qualityFilter} GROUP BY js.job_id ORDER BY js.job_id LIMIT ${args.limit} OFFSET ${args.offset}`
  }
  
  console.log('\n📊 Executing query...')
  
  let rawResult: string
  try {
    rawResult = executeD1Query(query)
  } catch (error) {
    console.error('Failed to execute query')
    process.exit(1)
  }
  
  // Parse JSON result
  let parsed: any
  try {
    // The output may have wrangler CLI messages, find the JSON array
    const jsonMatch = rawResult.match(/\[[\s\S]*?\]/m)
    if (!jsonMatch) {
      // Try to find JSON object with results
      const objMatch = rawResult.match(/\{[\s\S]*?"results"[\s\S]*?\}/m)
      if (objMatch) {
        parsed = JSON.parse(objMatch[0])
      } else {
        console.error('No JSON found in output')
        console.error('Raw output:', rawResult.slice(0, 500))
        process.exit(1)
      }
    } else {
      // Handle different wrangler output formats
      const fullParsed = JSON.parse(rawResult)
      if (Array.isArray(fullParsed) && fullParsed[0]?.results) {
        parsed = fullParsed[0]
      } else {
        parsed = { results: fullParsed }
      }
    }
  } catch (error: any) {
    console.error('Failed to parse JSON:', error.message)
    console.error('Raw output:', rawResult.slice(0, 1000))
    process.exit(1)
  }
  
  const rows: JobSourceRow[] = parsed.results || []
  
  console.log(`\n✅ Found ${rows.length} jobs`)
  
  if (rows.length === 0) {
    console.log('No jobs to export.')
    process.exit(0)
  }
  
  // Transform to tagging input format
  const taggingInput = rows.map(row => {
    let payload: any = {}
    let rawPayload: any = {}
    
    // Parse normalized_payload
    try {
      payload = typeof row.normalized_payload === 'string' 
        ? JSON.parse(row.normalized_payload) 
        : row.normalized_payload
    } catch { /* ignore */ }
    
    // Parse raw_payload
    try {
      rawPayload = typeof row.raw_payload === 'string' 
        ? JSON.parse(row.raw_payload) 
        : row.raw_payload
    } catch { /* ignore */ }
    
    // normalized_payload가 비어있으면 raw_payload 사용 (WORK24_DJOB)
    const isNormalizedEmpty = !payload || Object.keys(payload).length === 0 || !payload.duties
    if (isNormalizedEmpty && rawPayload && Object.keys(rawPayload).length > 0) {
      // WORK24_DJOB 형식의 raw_payload를 정규화
      if (rawPayload.dJobNm || rawPayload.doWork) {
        payload = normalizeWork24DJob(rawPayload)
      }
    }
    
    // job_name 결정: "null" 문자열도 무효로 처리
    const validJobName = row.job_name && row.job_name !== 'null' ? row.job_name : null
    const finalJobName = validJobName || payload.name || rawPayload.dJobNm || 'Unknown'
    
    return {
      job_id: row.job_id,
      job_name: finalJobName,
      source_system: row.source_system,
      current_status: row.tagging_status || 'not_started',
      // Key content for tagging
      content: {
        duties: payload.duties || '',
        environment: payload.environment || '',
        qualifications: payload.qualifications || '',
        outlook: payload.outlook || '',
        salary_info: payload.salary_info || '',
        related_majors: payload.related_majors || [],
        related_licenses: payload.related_licenses || [],
        classifications: payload.classifications || {},
      }
    }
  })
  
  // Ensure output directory exists
  const outputDir = path.dirname(args.output)
  if (outputDir && outputDir !== '.' && !fs.existsSync(outputDir)) {
    fs.mkdirSync(outputDir, { recursive: true })
  }
  
  // Write output
  fs.writeFileSync(args.output, JSON.stringify(taggingInput, null, 2), 'utf-8')
  
  console.log(`\n📁 Saved to: ${args.output}`)
  console.log('\nSample job:')
  console.log(JSON.stringify(taggingInput[0], null, 2).slice(0, 500) + '...')
  
  // Summary
  const statusCounts = taggingInput.reduce((acc, job) => {
    acc[job.current_status] = (acc[job.current_status] || 0) + 1
    return acc
  }, {} as Record<string, number>)
  
  console.log('\n📊 Status breakdown:')
  Object.entries(statusCounts).forEach(([status, count]) => {
    console.log(`   ${status}: ${count}`)
  })
  
  console.log('\n✨ Done! Use this file with TAGGING_PROMPT_TEMPLATE.md for tagging.')
}

main()
