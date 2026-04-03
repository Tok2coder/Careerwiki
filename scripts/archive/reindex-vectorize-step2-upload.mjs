#!/usr/bin/env node
/**
 * Step 2: OpenAI Embedding 생성 및 Vectorize 업로드
 * 
 * Step 1에서 내보낸 JSON을 읽어서 OpenAI Embedding을 생성하고
 * Cloudflare Vectorize에 업로드합니다.
 * 
 * 사용법:
 *   node scripts/reindex-vectorize-step2-upload.mjs
 * 
 * 환경 변수:
 *   - OPENAI_API_KEY: OpenAI API 키
 *   - CLOUDFLARE_ACCOUNT_ID: Cloudflare 계정 ID
 *   - CLOUDFLARE_API_TOKEN: Cloudflare API 토큰 (Vectorize 권한 필요)
 */

import dotenv from 'dotenv'
import { readFileSync, writeFileSync, existsSync } from 'fs'
import { join, dirname } from 'path'
import { fileURLToPath } from 'url'

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
const CLOUDFLARE_ACCOUNT_ID = process.env.CLOUDFLARE_ACCOUNT_ID
// CLOUDFLARE_API_TOKEN_2가 있으면 우선 사용 (Vectorize 권한 있을 수 있음)
const CLOUDFLARE_API_TOKEN = process.env.CLOUDFLARE_API_TOKEN_2 || process.env.CLOUDFLARE_API_TOKEN

const VECTORIZE_INDEX_NAME = 'careerwiki-embeddings'
const EMBEDDING_MODEL = 'text-embedding-3-small'
const EMBEDDING_DIMENSIONS = 1536

// 필수 환경 변수 확인
if (!OPENAI_API_KEY) {
  console.error('OPENAI_API_KEY가 설정되지 않았습니다.')
  process.exit(1)
}
if (!CLOUDFLARE_ACCOUNT_ID) {
  console.error('CLOUDFLARE_ACCOUNT_ID가 설정되지 않았습니다.')
  process.exit(1)
}
if (!CLOUDFLARE_API_TOKEN) {
  console.error('CLOUDFLARE_API_TOKEN이 설정되지 않았습니다.')
  process.exit(1)
}

// Vectorize API URL
const VECTORIZE_API_URL = `https://api.cloudflare.com/client/v4/accounts/${CLOUDFLARE_ACCOUNT_ID}/vectorize/v2/indexes/${VECTORIZE_INDEX_NAME}`

// 진행 상황 저장 파일
const PROGRESS_FILE = join(__dirname, '..', 'artifacts', 'vectorize-progress.json')

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
  
  // 인덱스 순서대로 정렬
  return data.data
    .sort((a, b) => a.index - b.index)
    .map(item => item.embedding)
}

// ============================================
// Vectorize에 벡터 업서트
// ============================================
async function upsertVectors(vectors) {
  // NDJSON 형식으로 변환
  const ndjson = vectors.map(v => JSON.stringify({
    id: v.id,
    values: v.values,
    metadata: v.metadata,
  })).join('\n')
  
  const response = await fetch(`${VECTORIZE_API_URL}/upsert`, {
    method: 'POST',
    headers: {
      'Authorization': `Bearer ${CLOUDFLARE_API_TOKEN}`,
      'Content-Type': 'application/x-ndjson',
    },
    body: ndjson,
  })

  if (!response.ok) {
    const error = await response.text()
    throw new Error(`Vectorize upsert error: ${response.status} - ${error}`)
  }

  const data = await response.json()
  return data
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
  console.log('Step 2: Vectorize 업로드 (OpenAI Embedding)')
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
  // UTF-8 BOM 제거
  if (fileContent.charCodeAt(0) === 0xFEFF) {
    fileContent = fileContent.slice(1)
  }
  // UTF-16 LE BOM 제거 (필요시)
  fileContent = fileContent.replace(/^\uFFFE/, '').replace(/^\uFEFF/, '')
  
  const rawData = JSON.parse(fileContent)
  // wrangler 출력 형식: [{ "results": [...] }]
  const jobs = rawData[0]?.results || rawData
  console.log(`총 ${jobs.length}개 직업 로드됨`)
  
  // 진행 상황 복원
  const progress = loadProgress()
  console.log(`이전 진행 상황: ${progress.lastProcessedIndex + 1}/${jobs.length} 완료`)
  
  const BATCH_SIZE = 50  // OpenAI rate limit 고려
  const startTime = Date.now()
  
  for (let i = progress.lastProcessedIndex + 1; i < jobs.length; i += BATCH_SIZE) {
    const batch = jobs.slice(i, i + BATCH_SIZE)
    const batchEnd = Math.min(i + BATCH_SIZE, jobs.length)
    
    console.log(`[${new Date().toISOString()}] 배치 처리: ${i + 1}-${batchEnd}/${jobs.length}`)
    
    // 임베딩 텍스트 준비
    const textsForEmbedding = batch.map(job => 
      `${job.job_name} ${job.description || ''} ${job.category || ''}`.trim()
    )
    
    try {
      // 임베딩 생성
      console.log('  임베딩 생성 중...')
      const embeddings = await generateEmbedding(textsForEmbedding)
      
      // 벡터 데이터 준비
      const vectors = batch.map((job, idx) => ({
        id: job.job_id,
        values: embeddings[idx],
        metadata: {
          job_name: job.job_name,
          category: job.category || '',
        },
      }))
      
      // Vectorize에 업서트
      console.log('  Vectorize에 업서트 중...')
      await upsertVectors(vectors)
      
      progress.totalIndexed += batch.length
      progress.lastProcessedIndex = batchEnd - 1
      saveProgress(progress)
      
      console.log(`  ✅ ${batch.length}개 인덱싱 완료 (총 ${progress.totalIndexed}개)`)
      
    } catch (error) {
      console.error(`  ❌ 배치 처리 실패: ${error.message}`)
      progress.totalErrors += batch.length
      
      // 에러가 rate limit이면 잠시 대기
      if (error.message.includes('429') || error.message.includes('rate')) {
        console.log('  ⏳ Rate limit 감지, 30초 대기...')
        await new Promise(resolve => setTimeout(resolve, 30000))
      }
    }
    
    // Rate limit 방지 (1.5초 대기)
    await new Promise(resolve => setTimeout(resolve, 1500))
  }
  
  const duration = (Date.now() - startTime) / 1000
  
  console.log('')
  console.log('========================================')
  console.log('업로드 완료!')
  console.log('========================================')
  console.log(`총 인덱싱: ${progress.totalIndexed}개`)
  console.log(`에러: ${progress.totalErrors}개`)
  console.log(`소요 시간: ${duration.toFixed(1)}초`)
  
  // 진행 파일 삭제 (완료 시)
  if (progress.lastProcessedIndex >= jobs.length - 1) {
    console.log('진행 파일 정리됨')
  }
}

main().catch(error => {
  console.error('치명적 오류:', error)
  process.exit(1)
})
