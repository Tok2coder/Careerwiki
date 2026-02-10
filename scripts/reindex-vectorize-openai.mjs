#!/usr/bin/env node
/**
 * Vectorize 재인덱싱 스크립트 (OpenAI Embedding 사용)
 * 
 * 사용법:
 *   node scripts/reindex-vectorize-openai.mjs
 * 
 * 환경 변수:
 *   - CLOUDFLARE_ACCOUNT_ID: Cloudflare 계정 ID
 *   - CLOUDFLARE_API_TOKEN: Cloudflare API 토큰
 *   - OPENAI_API_KEY: OpenAI API 키
 */

import dotenv from 'dotenv'
import { readFileSync } from 'fs'
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

const CLOUDFLARE_ACCOUNT_ID = process.env.CLOUDFLARE_ACCOUNT_ID
const CLOUDFLARE_API_TOKEN = process.env.CLOUDFLARE_API_TOKEN
const OPENAI_API_KEY = process.env.OPENAI_API_KEY

const VECTORIZE_INDEX_NAME = 'careerwiki-embeddings'
const EMBEDDING_MODEL = 'text-embedding-3-small'
const EMBEDDING_DIMENSIONS = 1536

// 필수 환경 변수 확인
if (!CLOUDFLARE_ACCOUNT_ID || !CLOUDFLARE_API_TOKEN || !OPENAI_API_KEY) {
  console.error('필수 환경 변수가 설정되지 않았습니다.')
  console.error('필요한 환경 변수:')
  console.error('  - CLOUDFLARE_ACCOUNT_ID')
  console.error('  - CLOUDFLARE_API_TOKEN')
  console.error('  - OPENAI_API_KEY')
  process.exit(1)
}

// D1 API URL
const D1_DATABASE_ID = '1dbc57d6-0ce3-4a7e-8d2e-3159b0df1315' // careerwiki-kr (wrangler.jsonc에서 확인)
const D1_API_URL = `https://api.cloudflare.com/client/v4/accounts/${CLOUDFLARE_ACCOUNT_ID}/d1/database/${D1_DATABASE_ID}/query`

// Vectorize API URL
const VECTORIZE_API_URL = `https://api.cloudflare.com/client/v4/accounts/${CLOUDFLARE_ACCOUNT_ID}/vectorize/v2/indexes/${VECTORIZE_INDEX_NAME}`

// ============================================
// D1 쿼리 실행
// ============================================
async function queryD1(sql, params = []) {
  const response = await fetch(D1_API_URL, {
    method: 'POST',
    headers: {
      'Authorization': `Bearer ${CLOUDFLARE_API_TOKEN}`,
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({ sql, params }),
  })
  
  if (!response.ok) {
    const error = await response.text()
    throw new Error(`D1 API error: ${response.status} - ${error}`)
  }
  
  const data = await response.json()
  if (!data.success) {
    throw new Error(`D1 query failed: ${JSON.stringify(data.errors)}`)
  }
  
  return data.result[0].results
}

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
// 메인 함수
// ============================================
async function main() {
  console.log('========================================')
  console.log('Vectorize 재인덱싱 시작 (OpenAI Embedding)')
  console.log('========================================')
  console.log(`모델: ${EMBEDDING_MODEL}`)
  console.log(`차원: ${EMBEDDING_DIMENSIONS}`)
  console.log(`인덱스: ${VECTORIZE_INDEX_NAME}`)
  console.log('')
  
  const BATCH_SIZE = 50  // OpenAI rate limit 고려
  let offset = 0
  let totalIndexed = 0
  let totalErrors = 0
  const startTime = Date.now()
  
  while (true) {
    // 직업 데이터 조회
    console.log(`[${new Date().toISOString()}] 직업 조회 중... (offset: ${offset})`)
    
    const jobs = await queryD1(`
      SELECT 
        ja.job_id,
        ja.job_name,
        COALESCE(jd.description, '') as description,
        COALESCE(jd.category, '') as category
      FROM job_attributes ja
      LEFT JOIN job_details jd ON ja.job_id = jd.job_id
      LIMIT ? OFFSET ?
    `, [BATCH_SIZE, offset])
    
    if (!jobs || jobs.length === 0) {
      console.log('모든 직업 처리 완료!')
      break
    }
    
    console.log(`  ${jobs.length}개 직업 로드됨`)
    
    // 임베딩 텍스트 준비
    const textsForEmbedding = jobs.map(job => 
      `${job.job_name} ${job.description} ${job.category}`.trim()
    )
    
    try {
      // 임베딩 생성
      console.log('  임베딩 생성 중...')
      const embeddings = await generateEmbedding(textsForEmbedding)
      
      // 벡터 데이터 준비
      const vectors = jobs.map((job, idx) => ({
        id: job.job_id,
        values: embeddings[idx],
        metadata: {
          job_name: job.job_name,
          category: job.category,
        },
      }))
      
      // Vectorize에 업서트
      console.log('  Vectorize에 업서트 중...')
      await upsertVectors(vectors)
      
      totalIndexed += jobs.length
      console.log(`  ✅ ${jobs.length}개 인덱싱 완료 (총 ${totalIndexed}개)`)
      
    } catch (error) {
      console.error(`  ❌ 배치 처리 실패: ${error.message}`)
      totalErrors += jobs.length
    }
    
    offset += BATCH_SIZE
    
    // Rate limit 방지 (1.5초 대기)
    await new Promise(resolve => setTimeout(resolve, 1500))
  }
  
  const duration = (Date.now() - startTime) / 1000
  
  console.log('')
  console.log('========================================')
  console.log('재인덱싱 완료!')
  console.log('========================================')
  console.log(`총 인덱싱: ${totalIndexed}개`)
  console.log(`에러: ${totalErrors}개`)
  console.log(`소요 시간: ${duration.toFixed(1)}초`)
}

main().catch(error => {
  console.error('치명적 오류:', error)
  process.exit(1)
})
