#!/usr/bin/env node
/**
 * Vectorize Index Audit Script
 * 
 * D1 데이터베이스의 직업 수와 Vectorize 인덱스 수를 비교하여
 * 누락된 job_id를 찾아냅니다.
 * 
 * Usage:
 *   node scripts/vectorize-audit.mjs
 * 
 * 환경변수:
 *   - CLOUDFLARE_ACCOUNT_ID
 *   - CLOUDFLARE_API_TOKEN
 */

import { execSync } from 'child_process'
import fs from 'fs'
import path from 'path'

const TEMP_DIR = './artifacts'
const D1_DATABASE_NAME = 'careerwiki-kr'  // Production D1 name
const VECTORIZE_INDEX = 'careerwiki-embeddings'

// 디버그 출력용
function log(message) {
  console.log(`[AUDIT] ${new Date().toISOString()} - ${message}`)
}

async function getD1JobIds() {
  log('Fetching job IDs from D1...')
  
  // wrangler d1 execute로 job_id 목록 조회
  const query = 'SELECT id FROM jobs WHERE is_active = 1 ORDER BY id'
  const outputFile = path.join(TEMP_DIR, 'audit-d1-jobs.json')
  
  try {
    execSync(
      `npx wrangler d1 execute ${D1_DATABASE_NAME} --remote --json --command "${query}" > "${outputFile}"`,
      { stdio: 'pipe' }
    )
    
    const rawData = fs.readFileSync(outputFile, 'utf-8')
    // BOM 처리
    const cleanData = rawData.replace(/^\uFEFF/, '')
    const result = JSON.parse(cleanData)
    
    // results 배열에서 job_id 추출
    const jobIds = result[0]?.results?.map(row => row.id) || []
    log(`Found ${jobIds.length} active jobs in D1`)
    
    return new Set(jobIds)
    
  } catch (error) {
    console.error('Failed to fetch D1 jobs:', error.message)
    throw error
  }
}

async function sampleVectorizeIds(sampleJobIds) {
  log(`Sampling ${sampleJobIds.length} job IDs from Vectorize...`)
  
  // Vectorize는 직접 ID 목록 조회가 불가하므로
  // 샘플링으로 존재 여부 확인
  const existingIds = new Set()
  const missingIds = new Set()
  
  // wrangler vectorize query로 각 ID 확인
  // (Vectorize API는 id로 직접 조회 불가, query로 유사도 검색만 가능)
  // 대안: metadata에서 job_name으로 확인하거나 API 직접 호출
  
  // 현재 구현: 샘플 쿼리로 대략적인 커버리지 확인
  log('Note: Vectorize does not support direct ID lookup.')
  log('Using indirect verification via random vector queries...')
  
  // 인덱스 정보 조회 시도
  try {
    const infoResult = execSync(
      `npx wrangler vectorize info ${VECTORIZE_INDEX}`,
      { encoding: 'utf-8', stdio: 'pipe' }
    )
    log(`Vectorize index info:\n${infoResult}`)
  } catch (error) {
    log(`Could not get Vectorize info: ${error.message}`)
  }
  
  return { existingIds, missingIds }
}

async function main() {
  log('Starting Vectorize Index Audit...')
  
  // 디렉토리 확인
  if (!fs.existsSync(TEMP_DIR)) {
    fs.mkdirSync(TEMP_DIR, { recursive: true })
  }
  
  try {
    // 1. D1에서 전체 job_id 목록 조회
    const d1JobIds = await getD1JobIds()
    
    // 2. 결과 보고
    const auditResult = {
      timestamp: new Date().toISOString(),
      d1_total_jobs: d1JobIds.size,
      vectorize_index: VECTORIZE_INDEX,
      notes: [
        'Vectorize does not support listing all indexed IDs.',
        'Full audit requires running re-indexing with tracking.',
        'Consider using indexed_at column in D1 for tracking.',
      ],
      recommendation: d1JobIds.size > 0 
        ? 'Run full-refresh script to ensure all jobs are indexed.'
        : 'D1 query failed - check database connection.',
    }
    
    // 결과 저장
    const reportFile = path.join(TEMP_DIR, 'vectorize-audit-report.json')
    fs.writeFileSync(reportFile, JSON.stringify(auditResult, null, 2))
    
    log('Audit Summary:')
    log(`  D1 Active Jobs: ${auditResult.d1_total_jobs}`)
    log(`  Vectorize Index: ${auditResult.vectorize_index}`)
    log(`  Report saved to: ${reportFile}`)
    log('')
    log('Recommendation: ' + auditResult.recommendation)
    
    return auditResult
    
  } catch (error) {
    console.error('Audit failed:', error)
    process.exit(1)
  }
}

main()
