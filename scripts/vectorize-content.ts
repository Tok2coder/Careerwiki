#!/usr/bin/env npx tsx
/**
 * vectorize-content.ts
 * 
 * Part 2.3: 직업/전공/HowTo 콘텐츠 임베딩 생성 및 Vectorize 업로드
 * 
 * Usage:
 *   npx tsx scripts/vectorize-content.ts --type job --limit 100
 *   npx tsx scripts/vectorize-content.ts --type major --limit 50
 *   npx tsx scripts/vectorize-content.ts --type howto --limit 50
 *   npx tsx scripts/vectorize-content.ts --reindex  # 전체 재색인
 */

import { execSync } from 'child_process'
import * as fs from 'fs'
import * as crypto from 'crypto'

interface CLIArgs {
  type: 'job' | 'major' | 'howto' | 'all'
  limit: number
  offset: number
  reindex: boolean
  dryRun: boolean
}

interface ContentChunk {
  id: string  // namespace:entity_id:chunk_index
  namespace: string
  entity_id: string
  text: string
  text_hash: string
  metadata: {
    type: 'job' | 'major' | 'howto'
    entity_id: string
    slug: string
    title: string
    section: string
    chunk_index: number
  }
}

function parseArgs(): CLIArgs {
  const args: CLIArgs = {
    type: 'job',
    limit: 100,
    offset: 0,
    reindex: false,
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
    } else if (arg === '--reindex') {
      args.reindex = true
    } else if (arg === '--dry-run') {
      args.dryRun = true
    } else if (arg === '--help' || arg === '-h') {
      console.log(`
Usage: npx tsx scripts/vectorize-content.ts [options]

Options:
  --type, -t <type>  Content type: job, major, howto, all (default: job)
  --limit <n>        Number of items to process (default: 100)
  --offset <n>       Skip first n items (default: 0)
  --reindex          Force reindex all items
  --dry-run          Preview without uploading
  --help, -h         Show this help

Prerequisites:
  1. Create Vectorize index:
     wrangler vectorize create careerwiki-embeddings --dimensions=768 --metric=cosine
  
  2. Ensure wrangler is configured with your account
      `)
      process.exit(0)
    }
  }
  
  return args
}

function executeD1Query(query: string): string {
  try {
    const result = execSync(
      `npx wrangler d1 execute careerwiki-db --local --json --command="${query.replace(/"/g, '\\"')}"`,
      { encoding: 'utf-8', maxBuffer: 100 * 1024 * 1024 }
    )
    return result
  } catch (error: any) {
    console.error('D1 query failed:', error.message)
    throw error
  }
}

function generateTextHash(text: string): string {
  return crypto.createHash('md5').update(text).digest('hex').slice(0, 16)
}

function extractJobChunks(jobId: string, jobName: string, payload: any): ContentChunk[] {
  const chunks: ContentChunk[] = []
  const slug = jobId
  
  // Key sections to embed
  const sections: Array<{ key: string; name: string }> = [
    { key: 'duties', name: '하는 일' },
    { key: 'environment', name: '근무 환경' },
    { key: 'qualifications', name: '필요 역량' },
    { key: 'outlook', name: '전망' },
  ]
  
  let chunkIndex = 0
  for (const section of sections) {
    const text = payload[section.key]
    if (!text || text.trim().length < 20) continue
    
    // Clean and normalize text
    const cleanText = text.trim().slice(0, 1000)  // Limit chunk size
    
    chunks.push({
      id: `job:${jobId}:${chunkIndex}`,
      namespace: 'job-content',
      entity_id: jobId,
      text: `${jobName} - ${section.name}: ${cleanText}`,
      text_hash: generateTextHash(cleanText),
      metadata: {
        type: 'job',
        entity_id: jobId,
        slug,
        title: jobName,
        section: section.name,
        chunk_index: chunkIndex,
      }
    })
    chunkIndex++
  }
  
  // Add combined summary chunk
  const summary = [
    payload.duties?.slice(0, 200),
    payload.qualifications?.slice(0, 100),
  ].filter(Boolean).join(' ')
  
  if (summary.length > 50) {
    chunks.push({
      id: `job:${jobId}:summary`,
      namespace: 'job-content',
      entity_id: jobId,
      text: `${jobName} 요약: ${summary}`,
      text_hash: generateTextHash(summary),
      metadata: {
        type: 'job',
        entity_id: jobId,
        slug,
        title: jobName,
        section: '요약',
        chunk_index: chunkIndex,
      }
    })
  }
  
  return chunks
}

async function fetchJobs(limit: number, offset: number): Promise<ContentChunk[]> {
  console.log(`📊 Fetching jobs (limit: ${limit}, offset: ${offset})...`)
  
  const query = `
    SELECT job_id, json_extract(normalized_payload, '$.name') as job_name, normalized_payload
    FROM job_sources
    ORDER BY job_id
    LIMIT ${limit} OFFSET ${offset}
  `
  
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
    let payload: any = {}
    try {
      payload = typeof row.normalized_payload === 'string' 
        ? JSON.parse(row.normalized_payload) 
        : row.normalized_payload || {}
    } catch { /* ignore */ }
    
    const chunks = extractJobChunks(row.job_id, row.job_name || payload.name || 'Unknown', payload)
    allChunks.push(...chunks)
  }
  
  return allChunks
}

async function generateEmbeddings(chunks: ContentChunk[]): Promise<Array<{ chunk: ContentChunk; vector: number[] }>> {
  console.log(`\n🧠 Generating embeddings for ${chunks.length} chunks...`)
  console.log('   Note: This requires Workers AI access. Using placeholder vectors for now.')
  
  // In a real implementation, you would call the AI API here:
  // const response = await AI.run('@cf/baai/bge-m3', { text: chunks.map(c => c.text) })
  
  // For now, generate placeholder vectors (768 dimensions)
  // In production, replace with actual AI embeddings
  const results: Array<{ chunk: ContentChunk; vector: number[] }> = []
  
  for (const chunk of chunks) {
    // Placeholder: generate deterministic vector from text hash
    const hashBytes = Buffer.from(chunk.text_hash, 'hex')
    const vector: number[] = new Array(768).fill(0).map((_, i) => {
      // Generate pseudo-random float from hash
      return (hashBytes[i % hashBytes.length] / 255) * 2 - 1
    })
    
    // Normalize vector
    const norm = Math.sqrt(vector.reduce((sum, v) => sum + v * v, 0))
    const normalizedVector = vector.map(v => v / norm)
    
    results.push({ chunk, vector: normalizedVector })
  }
  
  return results
}

async function uploadToVectorize(embeddings: Array<{ chunk: ContentChunk; vector: number[] }>, dryRun: boolean): Promise<void> {
  console.log(`\n☁️ Uploading ${embeddings.length} vectors to Vectorize...`)
  
  if (dryRun) {
    console.log('   [DRY RUN] Skipping actual upload')
    console.log('   Sample vector ID:', embeddings[0]?.chunk.id)
    console.log('   Sample metadata:', JSON.stringify(embeddings[0]?.chunk.metadata, null, 2))
    return
  }
  
  // In a real implementation, you would use the Vectorize API:
  // await VECTORIZE.upsert(embeddings.map(e => ({
  //   id: e.chunk.id,
  //   values: e.vector,
  //   namespace: e.chunk.namespace,
  //   metadata: e.chunk.metadata,
  // })))
  
  // For now, save to a file for manual upload or testing
  const outputPath = 'artifacts/vectorize-data.json'
  const outputDir = 'artifacts'
  if (!fs.existsSync(outputDir)) {
    fs.mkdirSync(outputDir, { recursive: true })
  }
  
  const data = embeddings.map(e => ({
    id: e.chunk.id,
    values: e.vector,
    namespace: e.chunk.namespace,
    metadata: e.chunk.metadata,
  }))
  
  fs.writeFileSync(outputPath, JSON.stringify(data, null, 2), 'utf-8')
  console.log(`   Saved ${embeddings.length} vectors to ${outputPath}`)
  console.log('   ')
  console.log('   To upload to Vectorize:')
  console.log('   1. Create index if not exists:')
  console.log('      wrangler vectorize create careerwiki-embeddings --dimensions=768 --metric=cosine')
  console.log('   2. Use Vectorize API or wrangler to upload vectors')
}

async function main() {
  const args = parseArgs()
  
  console.log('🚀 Vectorize Content Script')
  console.log(`   Type: ${args.type}`)
  console.log(`   Limit: ${args.limit}`)
  console.log(`   Reindex: ${args.reindex}`)
  console.log(`   Dry run: ${args.dryRun}`)
  console.log('')
  
  let allChunks: ContentChunk[] = []
  
  if (args.type === 'job' || args.type === 'all') {
    const jobChunks = await fetchJobs(args.limit, args.offset)
    allChunks.push(...jobChunks)
  }
  
  // TODO: Add major and howto content extraction
  // if (args.type === 'major' || args.type === 'all') { ... }
  // if (args.type === 'howto' || args.type === 'all') { ... }
  
  if (allChunks.length === 0) {
    console.log('⚠️ No content chunks to process')
    return
  }
  
  console.log(`\n📝 Total chunks to embed: ${allChunks.length}`)
  
  // Generate embeddings
  const embeddings = await generateEmbeddings(allChunks)
  
  // Upload to Vectorize
  await uploadToVectorize(embeddings, args.dryRun)
  
  // Summary
  console.log('\n✅ Done!')
  console.log(`   Processed: ${allChunks.length} chunks`)
  console.log(`   Generated: ${embeddings.length} embeddings`)
  
  // Show sample
  if (embeddings.length > 0) {
    console.log('\n📋 Sample chunk:')
    console.log(`   ID: ${embeddings[0].chunk.id}`)
    console.log(`   Text: ${embeddings[0].chunk.text.slice(0, 100)}...`)
    console.log(`   Vector dims: ${embeddings[0].vector.length}`)
  }
}

main().catch(console.error)



