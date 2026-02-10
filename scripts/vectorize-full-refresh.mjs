#!/usr/bin/env node
/**
 * Vectorize Full Refresh Script
 * 
 * 6,945개 직업 전체를 Vectorize 인덱스에 재인덱싱합니다.
 * 체크포인트/재개 가능, 실패 시 지수 백오프 적용.
 * 
 * Usage:
 *   node scripts/vectorize-full-refresh.mjs
 *   node scripts/vectorize-full-refresh.mjs --resume  # 이전 체크포인트에서 재개
 *   node scripts/vectorize-full-refresh.mjs --dry-run # 실행 없이 계획만 출력
 * 
 * 환경변수:
 *   - OPENAI_API_KEY (필수)
 *   - CLOUDFLARE_ACCOUNT_ID
 *   - CLOUDFLARE_API_TOKEN
 */

import { execSync } from 'child_process'
import fs from 'fs'
import path from 'path'

// ============================================
// 설정
// ============================================
const CONFIG = {
  CHECKPOINT_FILE: './artifacts/vectorize-full-refresh-checkpoint.json',
  BATCH_SIZE: 10,  // 줄임 - merged_profile_json이 크기 때문
  MAX_RETRIES: 5,
  BASE_DELAY_MS: 2000,  // 2초로 늘림
  D1_DATABASE_NAME: 'careerwiki-kr',  // Production D1 name (wrangler uses name, not ID)
  VECTORIZE_INDEX: 'careerwiki-embeddings',
  TEMP_DIR: './artifacts',
}

// ============================================
// 유틸리티
// ============================================
function log(message) {
  console.log(`[REFRESH] ${new Date().toISOString()} - ${message}`)
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
    log(`Warning: Could not load checkpoint: ${error.message}`)
  }
  
  return {
    lastJobId: null,
    processedCount: 0,
    errorCount: 0,
    startedAt: new Date().toISOString(),
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
// D1에서 직업 데이터 추출
// ============================================
async function exportJobsFromD1(offset = 0, limit = 1000) {
  log(`Exporting jobs from D1 (offset: ${offset}, limit: ${limit})...`)
  
  // category 컬럼이 Production D1에 없음 - merged_profile_json에서 추출
  const query = `SELECT id, name, merged_profile_json FROM jobs WHERE is_active = 1 ORDER BY id LIMIT ${limit} OFFSET ${offset}`
  
  try {
    // PowerShell에서 안전하게 실행 (stdout으로 직접 수신)
    const result = execSync(
      `npx wrangler d1 execute ${CONFIG.D1_DATABASE_NAME} --remote --json --command "${query}"`,
      { 
        encoding: 'utf-8',
        maxBuffer: 100 * 1024 * 1024,  // 100MB buffer for large JSON
        timeout: 120000,  // 2분 타임아웃
      }
    )
    
    const cleanData = result.replace(/^\uFEFF/, '')  // BOM 제거
    const parsed = JSON.parse(cleanData)
    
    return parsed[0]?.results || []
    
  } catch (error) {
    // stderr에서 더 자세한 에러 정보 추출
    if (error.stderr) {
      log(`Stderr: ${error.stderr.toString().slice(0, 500)}`)
    }
    if (error.stdout) {
      log(`Stdout: ${error.stdout.toString().slice(0, 500)}`)
    }
    log(`Error exporting jobs: ${error.message}`)
    throw error
  }
}

// ============================================
// OpenAI Embedding 생성
// ============================================
async function generateEmbeddings(texts, apiKey) {
  const response = await fetch('https://api.openai.com/v1/embeddings', {
    method: 'POST',
    headers: {
      'Authorization': `Bearer ${apiKey}`,
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({
      model: 'text-embedding-3-small',
      input: texts,
    }),
  })
  
  if (!response.ok) {
    const error = await response.text()
    throw new Error(`OpenAI API error: ${response.status} - ${error}`)
  }
  
  const data = await response.json()
  
  // index 순으로 정렬
  const embeddings = data.data
    .sort((a, b) => a.index - b.index)
    .map(item => item.embedding)
  
  return { embeddings, usage: data.usage }
}

// ============================================
// job_profile_compact 생성 (서버 코드와 동일 로직)
// ============================================
function buildJobProfileCompact(job) {
  const name = job.name || '미상'
  let heroIntro, summary, description, duties, skills, workEnvironment, certifications, category
  
  if (job.merged_profile_json) {
    try {
      const profile = JSON.parse(job.merged_profile_json)
      heroIntro = profile.heroIntro || profile.hero_intro || profile.intro
      summary = profile.summary || profile.brief
      description = profile.description || profile.overview || profile.what || profile.업무내용
      duties = profile.duties || profile.responsibilities || profile.tasks
      skills = Array.isArray(profile.skills) ? profile.skills : 
               Array.isArray(profile.required_skills) ? profile.required_skills : null
      workEnvironment = profile.workEnvironment || profile.work_environment || profile.environment
      certifications = Array.isArray(profile.certifications) ? profile.certifications :
                       Array.isArray(profile.licenses) ? profile.licenses : null
      // category는 merged_profile_json에서 추출
      category = profile.category || profile.job_category || profile.ksco_major || profile.직종분류
    } catch {}
  }
  
  const mainDesc = (heroIntro || summary || description || '').trim()
  const parts = [name]
  
  if (mainDesc) parts.push(mainDesc.slice(0, 300))
  if (duties) parts.push(`핵심업무: ${duties.slice(0, 100)}`)
  if (skills?.length) parts.push(`필요역량: ${skills.slice(0, 5).join(', ')}`)
  if (workEnvironment) parts.push(`환경: ${workEnvironment.slice(0, 50)}`)
  if (certifications?.length) parts.push(`자격: ${certifications.slice(0, 3).join(', ')}`)
  if (category) parts.push(category)
  
  if (parts.length < 2) parts.push(category || '미분류')
  
  return parts.join(' ').substring(0, 1000)
}

// merged_profile_json에서 metadata 추출
function extractMetadata(job) {
  let category, kscoMajor, kscoMid, educationLevel
  
  if (job.merged_profile_json) {
    try {
      const profile = JSON.parse(job.merged_profile_json)
      category = profile.category || profile.job_category || profile.직종분류 || ''
      kscoMajor = profile.ksco_major || profile.kscoMajor || ''
      kscoMid = profile.ksco_mid || profile.kscoMid || ''
      educationLevel = profile.education_level || profile.educationLevel || profile.학력 || ''
    } catch {}
  }
  
  return { category, kscoMajor, kscoMid, educationLevel }
}

// ============================================
// Vectorize에 upsert (wrangler 사용)
// ============================================
async function upsertToVectorize(vectors) {
  // NDJSON 형식으로 저장
  const ndjsonFile = path.join(CONFIG.TEMP_DIR, 'vectorize-batch.ndjson')
  const ndjsonContent = vectors.map(v => JSON.stringify({
    id: v.id,
    values: v.values,
    metadata: v.metadata,
  })).join('\n')
  
  fs.writeFileSync(ndjsonFile, ndjsonContent)
  
  // wrangler vectorize insert 실행
  execSync(
    `npx wrangler vectorize insert ${CONFIG.VECTORIZE_INDEX} --file="${ndjsonFile}"`,
    { stdio: 'pipe' }
  )
  
  return vectors.length
}

// ============================================
// 지수 백오프로 재시도
// ============================================
async function retryWithBackoff(fn, maxRetries = CONFIG.MAX_RETRIES) {
  for (let attempt = 1; attempt <= maxRetries; attempt++) {
    try {
      return await fn()
    } catch (error) {
      if (attempt === maxRetries) {
        throw error
      }
      
      const delay = CONFIG.BASE_DELAY_MS * Math.pow(2, attempt - 1)
      log(`Attempt ${attempt} failed, retrying in ${delay}ms: ${error.message}`)
      await sleep(delay)
    }
  }
}

// ============================================
// 메인 함수
// ============================================
async function main() {
  const args = process.argv.slice(2)
  const isResume = args.includes('--resume')
  const isDryRun = args.includes('--dry-run')
  
  // 환경변수 확인
  const openaiApiKey = process.env.OPENAI_API_KEY
  if (!openaiApiKey) {
    console.error('Error: OPENAI_API_KEY environment variable is required')
    process.exit(1)
  }
  
  // 디렉토리 준비
  fs.mkdirSync(CONFIG.TEMP_DIR, { recursive: true })
  
  // 체크포인트 로드
  let checkpoint = isResume ? loadCheckpoint() : {
    lastJobId: null,
    processedCount: 0,
    errorCount: 0,
    startedAt: new Date().toISOString(),
  }
  
  log(`Starting full refresh (resume: ${isResume}, dry-run: ${isDryRun})`)
  log(`Checkpoint: processed=${checkpoint.processedCount}, errors=${checkpoint.errorCount}`)
  
  // 전체 직업 수 확인
  const totalJobs = await (async () => {
    const countQuery = 'SELECT COUNT(*) as count FROM jobs WHERE is_active = 1'
    const result = execSync(
      `npx wrangler d1 execute ${CONFIG.D1_DATABASE_NAME} --remote --json --command "${countQuery}"`,
      { encoding: 'utf-8' }
    )
    const cleanData = result.replace(/^\uFEFF/, '')
    return JSON.parse(cleanData)[0]?.results?.[0]?.count || 0
  })()
  
  log(`Total active jobs: ${totalJobs}`)
  
  if (isDryRun) {
    log('Dry run complete. Would process:')
    log(`  - Total jobs: ${totalJobs}`)
    log(`  - Batch size: ${CONFIG.BATCH_SIZE}`)
    log(`  - Estimated batches: ${Math.ceil(totalJobs / CONFIG.BATCH_SIZE)}`)
    log(`  - Already processed: ${checkpoint.processedCount}`)
    return
  }
  
  let offset = checkpoint.processedCount
  let totalProcessed = checkpoint.processedCount
  let totalErrors = checkpoint.errorCount
  
  while (offset < totalJobs) {
    log(`Processing batch at offset ${offset}...`)
    
    try {
      // 1. D1에서 배치 추출
      const jobs = await retryWithBackoff(() => 
        exportJobsFromD1(offset, CONFIG.BATCH_SIZE)
      )
      
      if (jobs.length === 0) {
        log('No more jobs to process')
        break
      }
      
      // 2. 인덱싱 텍스트 생성
      const texts = jobs.map(job => buildJobProfileCompact(job))
      
      // 3. OpenAI Embedding 생성
      const { embeddings, usage } = await retryWithBackoff(() =>
        generateEmbeddings(texts, openaiApiKey)
      )
      
      log(`Generated ${embeddings.length} embeddings (tokens: ${usage.total_tokens})`)
      
      // 4. Vectorize에 upsert
      const vectors = jobs.map((job, idx) => {
        const meta = extractMetadata(job)
        
        return {
          id: job.id,
          values: embeddings[idx],
          metadata: {
            job_name: job.name,
            category: meta.category || '',
            ksco_major: meta.kscoMajor || '',
            ksco_mid: meta.kscoMid || '',
            education_level: meta.educationLevel || '',
            embedding_version: 'V1',
          },
        }
      })
      
      await retryWithBackoff(() => upsertToVectorize(vectors))
      
      totalProcessed += jobs.length
      offset += jobs.length
      
      // 체크포인트 저장
      checkpoint = {
        ...checkpoint,
        lastJobId: jobs[jobs.length - 1].id,
        processedCount: totalProcessed,
        errorCount: totalErrors,
        lastUpdated: new Date().toISOString(),
      }
      saveCheckpoint(checkpoint)
      
      log(`Progress: ${totalProcessed}/${totalJobs} (${Math.round(totalProcessed/totalJobs*100)}%)`)
      
      // Rate limit 대기
      await sleep(CONFIG.BASE_DELAY_MS)
      
    } catch (error) {
      log(`Error processing batch at offset ${offset}: ${error.message}`)
      totalErrors++
      
      // 에러 후 체크포인트 저장
      checkpoint = { ...checkpoint, errorCount: totalErrors }
      saveCheckpoint(checkpoint)
      
      // 너무 많은 에러면 중단
      if (totalErrors > 10) {
        log('Too many errors, stopping. Use --resume to continue.')
        process.exit(1)
      }
      
      // 다음 배치로 스킵
      offset += CONFIG.BATCH_SIZE
    }
  }
  
  // 완료
  log('='.repeat(50))
  log('Full refresh completed!')
  log(`  Total processed: ${totalProcessed}`)
  log(`  Total errors: ${totalErrors}`)
  log(`  Duration: ${Date.now() - new Date(checkpoint.startedAt).getTime()}ms`)
  
  // 성공적으로 완료되면 체크포인트 삭제
  if (totalErrors === 0) {
    clearCheckpoint()
  }
  
  // Audit 권장
  log('')
  log('Next steps:')
  log('  1. Run audit: node scripts/vectorize-audit.mjs')
  log('  2. Test search: curl http://localhost:3000/api/ai-analyzer/test-search')
}

main().catch(error => {
  console.error('Fatal error:', error)
  process.exit(1)
})
