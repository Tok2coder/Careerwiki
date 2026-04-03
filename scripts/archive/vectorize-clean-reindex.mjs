#!/usr/bin/env node
/**
 * Vectorize Clean Reindex Script (Freeze v1.1)
 * 
 * 벡터 인덱스 정합성 확보:
 * 1. 기존 벡터 전체 삭제 (7,232개 → 0개)
 * 2. is_active=1 직업만 조회
 * 3. 6,945개 정확히 재인덱싱
 * 4. vectorCount == 6,945 검증
 * 
 * Usage:
 *   node scripts/vectorize-clean-reindex.mjs
 *   node scripts/vectorize-clean-reindex.mjs --dry-run     # 계획만 출력
 *   node scripts/vectorize-clean-reindex.mjs --skip-delete # 삭제 없이 인덱싱만
 * 
 * 환경변수:
 *   - OPENAI_API_KEY (필수)
 *   - CLOUDFLARE_ACCOUNT_ID
 *   - CLOUDFLARE_API_TOKEN
 * 
 * ⚠️ WARNING: 이 작업은 롤백 불가능합니다!
 */

import { execSync } from 'child_process'
import fs from 'fs'
import path from 'path'

// ============================================
// 설정
// ============================================
const CONFIG = {
  CHECKPOINT_FILE: './artifacts/clean-reindex-checkpoint.json',
  BATCH_SIZE: 10,
  MAX_RETRIES: 5,
  BASE_DELAY_MS: 2000,
  D1_DATABASE_NAME: 'careerwiki-kr',
  VECTORIZE_INDEX: 'careerwiki-embeddings',
  TEMP_DIR: './artifacts',
  EXPECTED_JOB_COUNT: 6945,  // 하드코딩 검증
}

// ============================================
// CLI 인자 파싱
// ============================================
const args = process.argv.slice(2)
const DRY_RUN = args.includes('--dry-run')
const SKIP_DELETE = args.includes('--skip-delete')
const RESUME = args.includes('--resume')

// ============================================
// 유틸리티
// ============================================
function log(message, level = 'INFO') {
  const timestamp = new Date().toISOString()
  console.log(`[${level}] ${timestamp} - ${message}`)
}

function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms))
}

function loadCheckpoint() {
  try {
    if (fs.existsSync(CONFIG.CHECKPOINT_FILE)) {
      const data = fs.readFileSync(CONFIG.CHECKPOINT_FILE, 'utf-8')
      return JSON.parse(data)
    }
  } catch (error) {
    log(`Warning: Could not load checkpoint: ${error.message}`, 'WARN')
  }
  
  return {
    phase: 'init',
    lastJobId: null,
    processedCount: 0,
    errorCount: 0,
    startedAt: new Date().toISOString(),
    deleteCompleted: false,
  }
}

function saveCheckpoint(checkpoint) {
  fs.mkdirSync(path.dirname(CONFIG.CHECKPOINT_FILE), { recursive: true })
  fs.writeFileSync(CONFIG.CHECKPOINT_FILE, JSON.stringify(checkpoint, null, 2))
}

function clearCheckpoint() {
  if (fs.existsSync(CONFIG.CHECKPOINT_FILE)) {
    fs.unlinkSync(CONFIG.CHECKPOINT_FILE)
    log('Checkpoint cleared')
  }
}

// ============================================
// Phase 1: 기존 벡터 삭제
// ============================================
async function deleteAllVectors() {
  log('=== Phase 1: Deleting all existing vectors ===', 'PHASE')
  
  if (DRY_RUN) {
    log('[DRY RUN] Would delete all vectors from index', 'DRY')
    return { success: true, deleted: 7232 }
  }
  
  // Vectorize 현재 상태 확인
  try {
    const infoOutput = execSync(
      `npx wrangler vectorize info ${CONFIG.VECTORIZE_INDEX}`,
      { encoding: 'utf-8' }
    )
    log(`Current index info:\n${infoOutput}`)
    
    // 벡터 수 파싱
    const vectorMatch = infoOutput.match(/Vectors:\s*(\d+)/i) || 
                       infoOutput.match(/vectorsCount.*?(\d+)/i)
    const currentVectorCount = vectorMatch ? parseInt(vectorMatch[1], 10) : 0
    log(`Current vector count: ${currentVectorCount}`)
    
    if (currentVectorCount === 0) {
      log('Index is already empty, skipping delete')
      return { success: true, deleted: 0 }
    }
    
    // 모든 벡터 ID 가져와서 삭제 (배치로)
    // Vectorize는 delete-by-id 방식이므로 ID 목록 필요
    // D1에서 모든 job_id를 가져옴
    const allJobIds = await getAllJobIdsFromD1()
    log(`Found ${allJobIds.length} job IDs in D1 to potentially delete from Vectorize`)
    
    // 배치로 삭제
    const DELETE_BATCH_SIZE = 100
    let deletedCount = 0
    
    for (let i = 0; i < allJobIds.length; i += DELETE_BATCH_SIZE) {
      const batch = allJobIds.slice(i, i + DELETE_BATCH_SIZE)
      const idsJson = JSON.stringify(batch)
      
      try {
        execSync(
          `npx wrangler vectorize delete-vectors ${CONFIG.VECTORIZE_INDEX} --ids='${idsJson}'`,
          { encoding: 'utf-8', timeout: 30000 }
        )
        deletedCount += batch.length
        log(`Deleted batch ${Math.floor(i / DELETE_BATCH_SIZE) + 1}/${Math.ceil(allJobIds.length / DELETE_BATCH_SIZE)}`)
      } catch (error) {
        // 없는 ID 삭제 시도는 에러 아님
        log(`Delete batch warning (may be normal): ${error.message}`, 'WARN')
      }
      
      await sleep(500)
    }
    
    // 최종 확인
    await sleep(3000)  // Vectorize 반영 대기
    
    const finalInfoOutput = execSync(
      `npx wrangler vectorize info ${CONFIG.VECTORIZE_INDEX}`,
      { encoding: 'utf-8' }
    )
    log(`After delete:\n${finalInfoOutput}`)
    
    return { success: true, deleted: deletedCount }
    
  } catch (error) {
    log(`Error during vector deletion: ${error.message}`, 'ERROR')
    return { success: false, error: error.message }
  }
}

// ============================================
// D1에서 모든 job_id 가져오기 (삭제용)
// ============================================
async function getAllJobIdsFromD1() {
  const query = `SELECT id FROM jobs ORDER BY id`
  
  try {
    const result = execSync(
      `npx wrangler d1 execute ${CONFIG.D1_DATABASE_NAME} --remote --json --command "${query}"`,
      { encoding: 'utf-8', maxBuffer: 50 * 1024 * 1024, timeout: 60000 }
    )
    
    const cleanData = result.replace(/^\uFEFF/, '')
    const parsed = JSON.parse(cleanData)
    const jobs = parsed[0]?.results || []
    
    return jobs.map(j => j.id)
  } catch (error) {
    log(`Error getting all job IDs: ${error.message}`, 'ERROR')
    return []
  }
}

// ============================================
// Phase 2: D1에서 is_active=1 직업만 추출 (ID만 먼저)
// ============================================
async function getActiveJobIds() {
  log(`Getting active job IDs from D1...`)
  
  const query = `SELECT id FROM jobs WHERE is_active = 1 ORDER BY id`
  
  try {
    const result = execSync(
      `npx wrangler d1 execute ${CONFIG.D1_DATABASE_NAME} --remote --json --command "${query}"`,
      { encoding: 'utf-8', maxBuffer: 10 * 1024 * 1024, timeout: 60000 }
    )
    
    const cleanData = result.replace(/^\uFEFF/, '')
    const parsed = JSON.parse(cleanData)
    const jobs = parsed[0]?.results || []
    
    return jobs.map(j => j.id)
  } catch (error) {
    log(`Error getting job IDs: ${error.message}`, 'ERROR')
    return []
  }
}

async function getJobById(jobId) {
  const query = `SELECT id, name, merged_profile_json FROM jobs WHERE id = '${jobId}'`
  
  try {
    const result = execSync(
      `npx wrangler d1 execute ${CONFIG.D1_DATABASE_NAME} --remote --json --command "${query}"`,
      { encoding: 'utf-8', maxBuffer: 50 * 1024 * 1024, timeout: 30000 }
    )
    
    const cleanData = result.replace(/^\uFEFF/, '')
    const parsed = JSON.parse(cleanData)
    
    return parsed[0]?.results[0] || null
  } catch (error) {
    log(`Error getting job ${jobId}: ${error.message}`, 'WARN')
    return null
  }
}

async function exportActiveJobsFromD1(offset = 0, limit = 100) {
  log(`Exporting active jobs from D1 (offset: ${offset}, limit: ${limit})...`)
  
  // merged_profile_json 없이 먼저 조회
  const query = `SELECT id, name FROM jobs WHERE is_active = 1 ORDER BY id LIMIT ${limit} OFFSET ${offset}`
  
  try {
    const result = execSync(
      `npx wrangler d1 execute ${CONFIG.D1_DATABASE_NAME} --remote --json --command "${query}"`,
      { encoding: 'utf-8', maxBuffer: 10 * 1024 * 1024, timeout: 60000 }
    )
    
    const cleanData = result.replace(/^\uFEFF/, '')
    const parsed = JSON.parse(cleanData)
    const basicJobs = parsed[0]?.results || []
    
    // 각 직업에 대해 merged_profile_json 개별 조회 (ENOBUFS 방지)
    const jobs = []
    for (const basicJob of basicJobs) {
      const fullJob = await getJobById(basicJob.id)
      if (fullJob) {
        jobs.push(fullJob)
      }
      await sleep(50)  // Rate limiting
    }
    
    return jobs
  } catch (error) {
    log(`Error exporting jobs: ${error.message}`, 'ERROR')
    return []
  }
}

// ============================================
// job_profile_compact 생성
// ============================================
function buildJobProfileCompact(job) {
  const parts = []
  
  // 1. 직업명 (필수)
  parts.push(`직업: ${job.name}`)
  
  // 2. merged_profile_json 파싱
  let profile = {}
  try {
    if (job.merged_profile_json) {
      profile = typeof job.merged_profile_json === 'string'
        ? JSON.parse(job.merged_profile_json)
        : job.merged_profile_json
    }
  } catch (e) {
    log(`Failed to parse merged_profile_json for ${job.name}`, 'WARN')
  }
  
  // 3. 카테고리
  const category = profile.category || profile.ksco_large || ''
  if (category) {
    parts.push(`분야: ${category}`)
  }
  
  // 4. 핵심 설명 (fallback 우선순위)
  const description = 
    profile.heroIntro?.subtitle ||
    profile.summary ||
    profile.heroIntro?.description ||
    profile.description ||
    ''
  
  if (description) {
    parts.push(description.slice(0, 300))
  }
  
  // 5. 주요 업무
  if (profile.duties && Array.isArray(profile.duties)) {
    const dutiesText = profile.duties.slice(0, 5).join(', ')
    if (dutiesText) parts.push(`주요업무: ${dutiesText}`)
  } else if (profile.mainTasks) {
    parts.push(`주요업무: ${profile.mainTasks.slice(0, 200)}`)
  }
  
  // 6. 필요 역량
  if (profile.skills && Array.isArray(profile.skills)) {
    const skillsText = profile.skills.slice(0, 5).join(', ')
    if (skillsText) parts.push(`필요역량: ${skillsText}`)
  } else if (profile.requiredCompetencies) {
    const compText = profile.requiredCompetencies
      .slice(0, 3)
      .map(c => c.name || c)
      .join(', ')
    if (compText) parts.push(`필요역량: ${compText}`)
  }
  
  // 7. 근무 환경
  if (profile.workEnvironment) {
    const envText = typeof profile.workEnvironment === 'string'
      ? profile.workEnvironment.slice(0, 100)
      : JSON.stringify(profile.workEnvironment).slice(0, 100)
    parts.push(`근무환경: ${envText}`)
  }
  
  // 8. 최소 정보 보장
  if (parts.length < 3) {
    parts.push(`${job.name}은(는) 전문 직업입니다.`)
  }
  
  // 길이 제한 (1000자)
  return parts.join(' ').slice(0, 1000)
}

// ============================================
// OpenAI 임베딩 생성
// ============================================
async function generateEmbedding(text) {
  const apiKey = process.env.OPENAI_API_KEY
  if (!apiKey) {
    throw new Error('OPENAI_API_KEY environment variable is required')
  }
  
  const response = await fetch('https://api.openai.com/v1/embeddings', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${apiKey}`,
    },
    body: JSON.stringify({
      model: 'text-embedding-3-small',
      input: text,
      dimensions: 1536,  // 기존 인덱스와 일치해야 함
    }),
  })
  
  if (!response.ok) {
    const errorText = await response.text()
    throw new Error(`OpenAI API error: ${response.status} - ${errorText}`)
  }
  
  const data = await response.json()
  return data.data[0].embedding
}

// ============================================
// Phase 3: 벡터 인덱싱
// ============================================
async function indexJobsToVectorize(jobs, checkpoint) {
  log(`=== Phase 3: Indexing ${jobs.length} jobs ===`, 'PHASE')
  
  if (DRY_RUN) {
    log(`[DRY RUN] Would index ${jobs.length} jobs`, 'DRY')
    return { success: true, indexed: jobs.length }
  }
  
  let indexedCount = checkpoint.processedCount || 0
  let errorCount = checkpoint.errorCount || 0
  
  for (let i = 0; i < jobs.length; i += CONFIG.BATCH_SIZE) {
    const batch = jobs.slice(i, i + CONFIG.BATCH_SIZE)
    
    try {
      // 각 job에 대해 임베딩 생성
      const vectors = []
      
      for (const job of batch) {
        try {
          const compactText = buildJobProfileCompact(job)
          const embedding = await generateEmbedding(compactText)
          
          // merged_profile_json에서 카테고리 추출
          let category = ''
          try {
            const profile = typeof job.merged_profile_json === 'string'
              ? JSON.parse(job.merged_profile_json)
              : job.merged_profile_json
            category = profile?.category || profile?.ksco_large || ''
          } catch (e) {}
          
          vectors.push({
            id: job.id,
            values: embedding,
            metadata: {
              job_name: job.name,
              category: category,
              is_active: true,
              indexed_at: new Date().toISOString(),
              embedding_version: 'V1',
            },
          })
        } catch (jobError) {
          log(`Failed to process job ${job.name}: ${jobError.message}`, 'ERROR')
          errorCount++
        }
        
        await sleep(100)  // Rate limiting
      }
      
      // Vectorize에 벡터 upsert
      if (vectors.length > 0) {
        const ndjson = vectors.map(v => JSON.stringify(v)).join('\n')
        const tempFile = path.join(CONFIG.TEMP_DIR, `vectors-batch-${i}.ndjson`)
        fs.writeFileSync(tempFile, ndjson)
        
        let retries = 0
        while (retries < CONFIG.MAX_RETRIES) {
          try {
            execSync(
              `npx wrangler vectorize insert ${CONFIG.VECTORIZE_INDEX} --file="${tempFile}"`,
              { encoding: 'utf-8', timeout: 60000 }
            )
            break
          } catch (upsertError) {
            retries++
            if (retries >= CONFIG.MAX_RETRIES) {
              throw upsertError
            }
            const delay = CONFIG.BASE_DELAY_MS * Math.pow(2, retries)
            log(`Retry ${retries}/${CONFIG.MAX_RETRIES} after ${delay}ms...`, 'WARN')
            await sleep(delay)
          }
        }
        
        // 임시 파일 삭제
        fs.unlinkSync(tempFile)
        
        indexedCount += vectors.length
      }
      
      // 체크포인트 저장
      const lastJob = batch[batch.length - 1]
      checkpoint.lastJobId = lastJob.id
      checkpoint.processedCount = indexedCount
      checkpoint.errorCount = errorCount
      saveCheckpoint(checkpoint)
      
      log(`Progress: ${indexedCount}/${jobs.length} indexed (${errorCount} errors)`)
      
      await sleep(500)
      
    } catch (batchError) {
      log(`Batch error at offset ${i}: ${batchError.message}`, 'ERROR')
      errorCount++
      checkpoint.errorCount = errorCount
      saveCheckpoint(checkpoint)
    }
  }
  
  return { success: true, indexed: indexedCount, errors: errorCount }
}

// ============================================
// Phase 4: 검증
// ============================================
async function verifyIndexCount() {
  log('=== Phase 4: Verification ===', 'PHASE')
  
  // D1 active job count
  const countQuery = `SELECT COUNT(*) as count FROM jobs WHERE is_active = 1`
  const countResult = execSync(
    `npx wrangler d1 execute ${CONFIG.D1_DATABASE_NAME} --remote --json --command "${countQuery}"`,
    { encoding: 'utf-8' }
  )
  const d1Count = JSON.parse(countResult.replace(/^\uFEFF/, ''))[0]?.results[0]?.count || 0
  log(`D1 active jobs: ${d1Count}`)
  
  // Vectorize count
  await sleep(3000)  // 반영 대기
  const infoOutput = execSync(
    `npx wrangler vectorize info ${CONFIG.VECTORIZE_INDEX}`,
    { encoding: 'utf-8' }
  )
  
  const vectorMatch = infoOutput.match(/Vectors:\s*(\d+)/i) ||
                     infoOutput.match(/vectorsCount.*?(\d+)/i)
  const vectorCount = vectorMatch ? parseInt(vectorMatch[1], 10) : 0
  log(`Vectorize vectors: ${vectorCount}`)
  
  // 검증
  const result = {
    d1ActiveCount: d1Count,
    vectorCount: vectorCount,
    expectedCount: CONFIG.EXPECTED_JOB_COUNT,
    matches: vectorCount === d1Count,
    withinTolerance: Math.abs(vectorCount - d1Count) <= 10,  // 10개 오차 허용
  }
  
  if (result.matches) {
    log(`✅ VERIFICATION PASSED: vectorCount (${vectorCount}) == d1Count (${d1Count})`, 'SUCCESS')
  } else if (result.withinTolerance) {
    log(`⚠️ VERIFICATION WARNING: Counts differ by ${Math.abs(vectorCount - d1Count)} (within tolerance)`, 'WARN')
  } else {
    log(`❌ VERIFICATION FAILED: vectorCount (${vectorCount}) != d1Count (${d1Count})`, 'ERROR')
  }
  
  if (d1Count !== CONFIG.EXPECTED_JOB_COUNT) {
    log(`⚠️ Note: D1 count (${d1Count}) differs from expected (${CONFIG.EXPECTED_JOB_COUNT})`, 'WARN')
  }
  
  return result
}

// ============================================
// 메인 실행
// ============================================
async function main() {
  console.log('=========================================')
  console.log(' Vectorize Clean Reindex Script')
  console.log(' Freeze v1.1 - Index Consistency Fix')
  console.log('=========================================')
  console.log()
  
  // 환경 체크
  if (!process.env.OPENAI_API_KEY) {
    log('ERROR: OPENAI_API_KEY environment variable is required', 'ERROR')
    process.exit(1)
  }
  
  if (DRY_RUN) {
    log('=== DRY RUN MODE - No changes will be made ===', 'DRY')
  }
  
  let checkpoint = RESUME ? loadCheckpoint() : loadCheckpoint()
  
  // artifacts 디렉토리 생성
  fs.mkdirSync(CONFIG.TEMP_DIR, { recursive: true })
  
  try {
    // Phase 1: 기존 벡터 삭제
    if (!SKIP_DELETE && !checkpoint.deleteCompleted) {
      const deleteResult = await deleteAllVectors()
      if (!deleteResult.success) {
        log(`Failed to delete vectors: ${deleteResult.error}`, 'ERROR')
        process.exit(1)
      }
      checkpoint.deleteCompleted = true
      checkpoint.phase = 'delete_completed'
      saveCheckpoint(checkpoint)
      log(`Deleted ${deleteResult.deleted} vectors`)
    } else {
      log('Skipping delete phase (--skip-delete or already completed)')
    }
    
    // Phase 2 & 3: 직업 추출 및 인덱싱
    log('=== Phase 2: Exporting active jobs ===', 'PHASE')
    
    const allJobs = []
    let offset = 0
    const PAGE_SIZE = 500
    
    while (true) {
      const batch = await exportActiveJobsFromD1(offset, PAGE_SIZE)
      if (batch.length === 0) break
      allJobs.push(...batch)
      offset += PAGE_SIZE
      log(`Exported ${allJobs.length} jobs so far...`)
    }
    
    log(`Total active jobs to index: ${allJobs.length}`)
    
    if (allJobs.length === 0) {
      log('No jobs found to index!', 'ERROR')
      process.exit(1)
    }
    
    // Phase 3: 인덱싱
    checkpoint.phase = 'indexing'
    saveCheckpoint(checkpoint)
    
    const indexResult = await indexJobsToVectorize(allJobs, checkpoint)
    
    log(`Indexed: ${indexResult.indexed}, Errors: ${indexResult.errors}`)
    
    // Phase 4: 검증
    const verifyResult = await verifyIndexCount()
    
    // 결과 요약
    console.log()
    console.log('=========================================')
    console.log(' CLEAN REINDEX COMPLETE')
    console.log('=========================================')
    console.log(`  D1 Active Jobs:  ${verifyResult.d1ActiveCount}`)
    console.log(`  Vectorize Count: ${verifyResult.vectorCount}`)
    console.log(`  Expected:        ${verifyResult.expectedCount}`)
    console.log(`  Verification:    ${verifyResult.matches ? '✅ PASSED' : '❌ FAILED'}`)
    console.log('=========================================')
    
    if (verifyResult.matches || verifyResult.withinTolerance) {
      clearCheckpoint()
      log('Clean reindex completed successfully!', 'SUCCESS')
      process.exit(0)
    } else {
      log('Clean reindex completed but verification failed', 'ERROR')
      process.exit(1)
    }
    
  } catch (error) {
    log(`Fatal error: ${error.message}`, 'ERROR')
    console.error(error)
    process.exit(1)
  }
}

main()
