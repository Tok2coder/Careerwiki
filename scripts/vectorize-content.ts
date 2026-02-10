#!/usr/bin/env npx tsx
/**
 * vectorize-content.ts
 * 
 * 직업 콘텐츠 임베딩 생성 및 Vectorize 업로드
 * 
 * Usage:
 *   npx tsx scripts/vectorize-content.ts --type job --limit 100
 *   npx tsx scripts/vectorize-content.ts --type job --dry-run
 *   npx tsx scripts/vectorize-content.ts --type job  # 전체 실행
 * 
 * Prerequisites:
 *   1. CLOUDFLARE_ACCOUNT_ID 환경변수 설정
 *   2. CLOUDFLARE_API_TOKEN 환경변수 설정 (Workers AI 권한 필요)
 *   3. Vectorize 인덱스 생성: wrangler vectorize create careerwiki-embeddings --dimensions=768 --metric=cosine
 */

import { execSync } from 'child_process'
import * as fs from 'fs'
import * as crypto from 'crypto'

// ============================================
// 설정
// ============================================
const EMBEDDING_MODEL = '@cf/baai/bge-base-en-v1.5'
const VECTOR_DIMENSIONS = 768
const VECTORIZE_INDEX = 'careerwiki-embeddings'
const BATCH_SIZE = 20 // Workers AI 배치 크기 제한
const D1_DATABASE = 'careerwiki-kr'
const ACCOUNT_ID = '3587865378649966bfb0a814fce73c77'
// Workers AI 전용 토큰 (D1/Vectorize 권한 불필요, AI 권한만 필요)
const AI_API_TOKEN = 'koXCD2lF5brPHwZZO-oxLQW3PLuK9_-vQA7zr1AJ'

interface CLIArgs {
  type: 'job' | 'major' | 'howto' | 'all'
  limit: number
  offset: number
  dryRun: boolean
}

interface ContentChunk {
  id: string
  namespace: string
  entity_id: string
  text: string
  metadata: {
    type: 'job' | 'major' | 'howto'
    entity_id: string
    job_name: string
    section: string
  }
}

interface VectorData {
  id: string
  values: number[]
  namespace?: string
  metadata: Record<string, string | number>
}

// ============================================
// CLI 인자 파싱
// ============================================
function parseArgs(): CLIArgs {
  const args: CLIArgs = {
    type: 'job',
    limit: 1000, // 기본값: 전체
    offset: 0,
    dryRun: false,
  }
  
  for (let i = 2; i < process.argv.length; i++) {
    const arg = process.argv[i]
    if ((arg === '--type' || arg === '-t') && process.argv[i + 1]) {
      args.type = process.argv[++i] as CLIArgs['type']
    } else if (arg === '--limit' && process.argv[i + 1]) {
      args.limit = parseInt(process.argv[++i], 10)
    } else if (arg === '--offset' && process.argv[i + 1]) {
      args.offset = parseInt(process.argv[++i], 10)
    } else if (arg === '--dry-run') {
      args.dryRun = true
    } else if (arg === '--help' || arg === '-h') {
      console.log(`
Usage: npx tsx scripts/vectorize-content.ts [options]

Options:
  --type, -t <type>  Content type: job, major, howto, all (default: job)
  --limit <n>        Number of items to process (default: 1000)
  --offset <n>       Skip first n items (default: 0)
  --dry-run          Preview without uploading
  --help, -h         Show this help

Environment Variables:
  CLOUDFLARE_ACCOUNT_ID  Your Cloudflare account ID
  CLOUDFLARE_API_TOKEN   API token with Workers AI permission

Example:
  npx tsx scripts/vectorize-content.ts --type job --limit 100 --dry-run
  npx tsx scripts/vectorize-content.ts --type job
      `)
      process.exit(0)
    }
  }
  
  return args
}

// ============================================
// D1 쿼리 실행 (로컬 또는 리모트)
// ============================================
function executeD1Query(query: string, remote: boolean = true): string {
  try {
    const remoteFlag = remote ? '--remote' : '--local'
    // 쿼리를 한 줄로 정리 (줄바꿈 제거)
    const singleLineQuery = query.replace(/\s+/g, ' ').trim()
    const escapedQuery = singleLineQuery.replace(/"/g, '\\"')
    const result = execSync(
      `npx wrangler d1 execute ${D1_DATABASE} ${remoteFlag} --json --command="${escapedQuery}"`,
      { encoding: 'utf-8', maxBuffer: 100 * 1024 * 1024 }
    )
    return result
  } catch (error: any) {
    console.error('D1 query failed:', error.message)
    throw error
  }
}

// ============================================
// 직업 데이터 조회 (jobs 테이블 - merged_profile_json)
// ============================================
async function fetchJobs(limit: number, offset: number): Promise<ContentChunk[]> {
  console.log(`📊 Fetching jobs (limit: ${limit}, offset: ${offset})...`)
  
  // jobs 테이블에서 merged_profile_json 조회
  const query = `SELECT id, name, merged_profile_json FROM jobs WHERE merged_profile_json IS NOT NULL AND is_active = 1 ORDER BY id LIMIT ${limit} OFFSET ${offset}`
  
  const rawResult = executeD1Query(query)
  let parsed: any
  
  try {
    const fullParsed = JSON.parse(rawResult)
    parsed = Array.isArray(fullParsed) && fullParsed[0]?.results 
      ? fullParsed[0] 
      : { results: fullParsed }
  } catch {
    console.error('Failed to parse D1 result')
    return []
  }
  
  const rows = parsed.results || []
  console.log(`   Found ${rows.length} jobs`)
  
  const allChunks: ContentChunk[] = []
  for (const row of rows) {
    let profile: any = {}
    try {
      profile = typeof row.merged_profile_json === 'string' 
        ? JSON.parse(row.merged_profile_json) 
        : row.merged_profile_json || {}
    } catch { /* ignore */ }
    
    const jobName = row.name || profile.name || 'Unknown'
    const jobId = row.id
    
    // 직업 설명 텍스트 생성 (heroIntro + overviewWork.main)
    const textParts: string[] = [jobName]
    
    // heroIntro 추가
    if (profile.heroIntro) {
      textParts.push(profile.heroIntro.slice(0, 200))
    }
    
    // overviewWork.main 추가
    if (profile.overviewWork?.main) {
      textParts.push(`하는 일: ${profile.overviewWork.main.slice(0, 400)}`)
    }
    
    // heroTags 추가
    if (profile.heroTags && Array.isArray(profile.heroTags)) {
      textParts.push(`키워드: ${profile.heroTags.slice(0, 10).join(', ')}`)
    }
    
    const text = textParts.join(' ').slice(0, 800) // 최대 800자
    
    if (text.length < 30) continue // 너무 짧은 텍스트 제외
    
    allChunks.push({
      id: `job:${jobId}`,
      namespace: 'job-content',
      entity_id: jobId,
      text,
      metadata: {
        type: 'job',
        entity_id: jobId,
        job_name: jobName,
        section: 'summary',
      }
    })
  }
  
  return allChunks
}

// ============================================
// Cloudflare Workers AI로 임베딩 생성
// ============================================
async function generateEmbeddingsViaAPI(
  texts: string[],
  accountId: string,
  apiToken: string
): Promise<number[][]> {
  const url = `https://api.cloudflare.com/client/v4/accounts/${accountId}/ai/run/${EMBEDDING_MODEL}`
  
  const response = await fetch(url, {
    method: 'POST',
    headers: {
      'Authorization': `Bearer ${apiToken}`,
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({ text: texts }),
  })
  
  if (!response.ok) {
    const errorText = await response.text()
    throw new Error(`Workers AI API failed: ${response.status} - ${errorText}`)
  }
  
  const result = await response.json() as { success: boolean; result: { data: number[][] }; errors?: any[] }
  
  if (!result.success) {
    throw new Error(`Workers AI failed: ${JSON.stringify(result.errors)}`)
  }
  
  return result.result.data
}

// ============================================
// Vectorize에 업로드 (NDJSON 파일 + wrangler CLI)
// ============================================
async function uploadToVectorize(vectors: VectorData[]): Promise<void> {
  if (vectors.length === 0) {
    console.log('   No vectors to upload')
    return
  }
  
  // NDJSON 파일 생성
  const ndjsonPath = 'artifacts/vectorize-upload.ndjson'
  const artifactsDir = 'artifacts'
  
  if (!fs.existsSync(artifactsDir)) {
    fs.mkdirSync(artifactsDir, { recursive: true })
  }
  
  // NDJSON 형식으로 저장
  const ndjsonContent = vectors.map(v => JSON.stringify(v)).join('\n')
  fs.writeFileSync(ndjsonPath, ndjsonContent, 'utf-8')
  
  console.log(`   Saved ${vectors.length} vectors to ${ndjsonPath}`)
  
  // wrangler vectorize insert 실행
  try {
    console.log(`   Uploading to Vectorize index: ${VECTORIZE_INDEX}...`)
    const result = execSync(
      `npx wrangler vectorize insert ${VECTORIZE_INDEX} --file="${ndjsonPath}"`,
      { encoding: 'utf-8', timeout: 120000 }
    )
    console.log(`   Upload result: ${result.trim()}`)
  } catch (error: any) {
    console.error('   Upload failed:', error.message)
    throw error
  }
}

// ============================================
// 메인 함수
// ============================================
async function main() {
  const args = parseArgs()
  
  console.log('🚀 Vectorize Content Script')
  console.log(`   Type: ${args.type}`)
  console.log(`   Limit: ${args.limit}`)
  console.log(`   Offset: ${args.offset}`)
  console.log(`   Dry run: ${args.dryRun}`)
  console.log('')
  
  // 하드코딩된 상수 사용 (환경변수 대신 - wrangler OAuth와 충돌 방지)
  const accountId = ACCOUNT_ID
  const apiToken = AI_API_TOKEN
  
  console.log(`   Account ID: ${accountId.slice(0, 8)}...`)
  console.log(`   API Token: ${apiToken.slice(0, 8)}...`)
  
  // 직업 데이터 조회
  let allChunks: ContentChunk[] = []
  
  if (args.type === 'job' || args.type === 'all') {
    const jobChunks = await fetchJobs(args.limit, args.offset)
    allChunks.push(...jobChunks)
  }
  
  if (allChunks.length === 0) {
    console.log('⚠️ No content chunks to process')
    return
  }
  
  console.log(`\n📝 Total chunks to embed: ${allChunks.length}`)
  
  if (args.dryRun) {
    console.log('\n[DRY RUN] Skipping embedding generation and upload')
    console.log('Sample chunks:')
    for (const chunk of allChunks.slice(0, 3)) {
      console.log(`  - ${chunk.id}: ${chunk.text.slice(0, 80)}...`)
    }
    return
  }
  
  // 배치 처리로 임베딩 생성
  console.log(`\n🧠 Generating embeddings (batch size: ${BATCH_SIZE})...`)
  
  const allVectors: VectorData[] = []
  let processedCount = 0
  
  for (let i = 0; i < allChunks.length; i += BATCH_SIZE) {
    const batch = allChunks.slice(i, i + BATCH_SIZE)
    const texts = batch.map(c => c.text)
    
    try {
      console.log(`   Processing batch ${Math.floor(i / BATCH_SIZE) + 1}/${Math.ceil(allChunks.length / BATCH_SIZE)} (${batch.length} items)...`)
      
      const embeddings = await generateEmbeddingsViaAPI(texts, accountId!, apiToken!)
      
      for (let j = 0; j < batch.length; j++) {
        const chunk = batch[j]
        const vector = embeddings[j]
        
        if (vector && vector.length === VECTOR_DIMENSIONS) {
          allVectors.push({
            id: chunk.id,
            values: vector,
            namespace: chunk.namespace,
            metadata: {
              job_name: chunk.metadata.job_name,
              entity_id: chunk.metadata.entity_id,
              type: chunk.metadata.type,
            },
          })
          processedCount++
        }
      }
      
      // Rate limiting: 배치 사이에 짧은 딜레이
      if (i + BATCH_SIZE < allChunks.length) {
        await new Promise(resolve => setTimeout(resolve, 500))
      }
      
    } catch (error) {
      console.error(`   Batch ${Math.floor(i / BATCH_SIZE) + 1} failed:`, error)
      // 실패해도 계속 진행
    }
  }
  
  console.log(`\n✅ Generated ${processedCount} embeddings`)
  
  // Vectorize에 업로드
  if (allVectors.length > 0) {
    console.log(`\n☁️ Uploading to Vectorize...`)
    await uploadToVectorize(allVectors)
  }
  
  // 최종 요약
  console.log('\n📊 Summary:')
  console.log(`   Total chunks: ${allChunks.length}`)
  console.log(`   Embeddings generated: ${processedCount}`)
  console.log(`   Vectors uploaded: ${allVectors.length}`)
  
  if (allVectors.length > 0) {
    console.log('\n📋 Sample vector:')
    console.log(`   ID: ${allVectors[0].id}`)
    console.log(`   Metadata: ${JSON.stringify(allVectors[0].metadata)}`)
    console.log(`   Vector dims: ${allVectors[0].values.length}`)
  }
}

main().catch(console.error)
