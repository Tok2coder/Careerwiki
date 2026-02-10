#!/usr/bin/env node
/**
 * Vectorize 재인덱싱 스크립트 (wrangler 사용)
 * 
 * OpenAI Embedding을 생성하고 wrangler vectorize insert로 업로드합니다.
 * 
 * 사용법:
 *   node scripts/reindex-vectorize-wrangler.mjs
 */

import dotenv from 'dotenv'
import { readFileSync, writeFileSync, existsSync } from 'fs'
import { join, dirname } from 'path'
import { fileURLToPath } from 'url'
import { execSync } from 'child_process'

const __dirname = dirname(fileURLToPath(import.meta.url))

// .dev.vars 로드
const devVarsPath = join(__dirname, '..', '.dev.vars')
try {
  const devVarsContent = readFileSync(devVarsPath, 'utf-8')
  const vars = dotenv.parse(devVarsContent)
  Object.assign(process.env, vars)
} catch (e) {
  console.log('.dev.vars 파일을 찾을 수 없습니다. 환경 변수를 사용합니다.')
}

const OPENAI_API_KEY = process.env.OPENAI_API_KEY
const VECTORIZE_INDEX_NAME = 'careerwiki-embeddings'
const EMBEDDING_MODEL = 'text-embedding-3-small'
const EMBEDDING_DIMENSIONS = 1536

if (!OPENAI_API_KEY) {
  console.error('OPENAI_API_KEY가 설정되지 않았습니다.')
  process.exit(1)
}

// 진행 상황 저장 파일
const PROGRESS_FILE = join(__dirname, '..', 'artifacts', 'vectorize-wrangler-progress.json')

// ============================================
// OpenAI Embedding 생성
// ============================================
async function generateEmbedding(texts) {
  const response = await fetch('https://api.openai.com/v1/embeddings', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${OPENAI_API_KEY}`,
    },
    body: JSON.stringify({
      model: EMBEDDING_MODEL,
      input: texts,
      dimensions: EMBEDDING_DIMENSIONS,
    }),
  })

  if (!response.ok) {
    const error = await response.text()
    throw new Error(`OpenAI Embedding API error: ${response.status} - ${error}`)
  }

  const data = await response.json()
  
  return data.data
    .sort((a, b) => a.index - b.index)
    .map(item => item.embedding)
}

// ============================================
// wrangler vectorize insert 실행 (OAuth 토큰 사용)
// ============================================
function uploadToVectorize(ndjsonPath) {
  try {
    // CLOUDFLARE_API_TOKEN을 비워서 OAuth 토큰 사용
    execSync(
      `npx wrangler vectorize insert ${VECTORIZE_INDEX_NAME} --file="${ndjsonPath}"`,
      { 
        stdio: 'inherit', 
        encoding: 'utf-8',
        env: { 
          ...process.env, 
          CLOUDFLARE_API_TOKEN: '',  // OAuth 토큰 사용을 위해 비움
        }
      }
    )
    return true
  } catch (error) {
    console.error('wrangler vectorize insert 실패:', error.message)
    return false
  }
}

// ============================================
// 진행 상황 저장/로드
// ============================================
function loadProgress() {
  if (existsSync(PROGRESS_FILE)) {
    const data = readFileSync(PROGRESS_FILE, 'utf-8')
    return JSON.parse(data)
  }
  return { lastProcessedIndex: -1, totalIndexed: 0, totalErrors: 0 }
}

function saveProgress(progress) {
  writeFileSync(PROGRESS_FILE, JSON.stringify(progress, null, 2))
}

// ============================================
// 메인 함수
// ============================================
async function main() {
  console.log('========================================')
  console.log('Vectorize 재인덱싱 (wrangler + OpenAI Embedding)')
  console.log('========================================')
  console.log(`모델: ${EMBEDDING_MODEL}`)
  console.log(`차원: ${EMBEDDING_DIMENSIONS}`)
  console.log(`인덱스: ${VECTORIZE_INDEX_NAME}`)
  console.log('')
  
  // 직업 데이터 로드
  const inputPath = join(__dirname, '..', 'artifacts', 'jobs-for-vectorize.json')
  if (!existsSync(inputPath)) {
    console.error('직업 데이터 파일이 없습니다.')
    console.error('먼저 D1에서 데이터를 추출하세요:')
    console.error('  npx wrangler d1 execute careerwiki-kr --remote --json --command "SELECT job_id, job_name FROM job_attributes" > artifacts/jobs-for-vectorize.json')
    process.exit(1)
  }
  
  // BOM 제거 및 JSON 파싱
  let fileContent = readFileSync(inputPath, 'utf-8')
  if (fileContent.charCodeAt(0) === 0xFEFF) {
    fileContent = fileContent.slice(1)
  }
  
  const rawData = JSON.parse(fileContent)
  const jobs = rawData[0]?.results || rawData
  console.log(`총 ${jobs.length}개 직업 로드됨`)
  
  // 진행 상황 복원
  const progress = loadProgress()
  console.log(`이전 진행 상황: ${progress.lastProcessedIndex + 1}/${jobs.length} 완료`)
  console.log('')
  
  const BATCH_SIZE = 100  // wrangler insert는 더 큰 배치 가능
  const startTime = Date.now()
  const ndjsonPath = join(__dirname, '..', 'artifacts', 'vectorize-batch.ndjson')
  
  for (let i = progress.lastProcessedIndex + 1; i < jobs.length; i += BATCH_SIZE) {
    const batch = jobs.slice(i, i + BATCH_SIZE)
    const batchEnd = Math.min(i + BATCH_SIZE, jobs.length)
    
    console.log(`[${new Date().toISOString()}] 배치 처리: ${i + 1}-${batchEnd}/${jobs.length}`)
    
    // 임베딩 텍스트 준비 (직업명만 사용 - 설명 없음)
    const textsForEmbedding = batch.map(job => job.job_name)
    
    try {
      // 임베딩 생성
      console.log('  임베딩 생성 중...')
      const embeddings = await generateEmbedding(textsForEmbedding)
      
      // NDJSON 파일 생성
      const ndjsonContent = batch.map((job, idx) => JSON.stringify({
        id: job.job_id,
        values: embeddings[idx],
        metadata: { job_name: job.job_name },
      })).join('\n')
      
      writeFileSync(ndjsonPath, ndjsonContent)
      
      // wrangler로 업로드
      console.log('  wrangler vectorize insert 실행 중...')
      const success = uploadToVectorize(ndjsonPath)
      
      if (success) {
        progress.totalIndexed += batch.length
        progress.lastProcessedIndex = batchEnd - 1
        saveProgress(progress)
        console.log(`  ✅ ${batch.length}개 인덱싱 완료 (총 ${progress.totalIndexed}개)`)
      } else {
        progress.totalErrors += batch.length
        saveProgress(progress)
        console.log(`  ⚠️ 배치 실패, 다음 배치로 진행`)
      }
      
    } catch (error) {
      console.error(`  ❌ 배치 처리 실패: ${error.message}`)
      progress.totalErrors += batch.length
      saveProgress(progress)
      
      // Rate limit이면 대기
      if (error.message.includes('429') || error.message.includes('rate')) {
        console.log('  ⏳ Rate limit 감지, 30초 대기...')
        await new Promise(resolve => setTimeout(resolve, 30000))
      }
    }
    
    // Rate limit 방지
    await new Promise(resolve => setTimeout(resolve, 1500))
  }
  
  const duration = (Date.now() - startTime) / 1000
  
  console.log('')
  console.log('========================================')
  console.log('완료!')
  console.log('========================================')
  console.log(`총 인덱싱: ${progress.totalIndexed}개`)
  console.log(`에러: ${progress.totalErrors}개`)
  console.log(`소요 시간: ${duration.toFixed(1)}초`)
}

main().catch(error => {
  console.error('치명적 오류:', error)
  process.exit(1)
})
