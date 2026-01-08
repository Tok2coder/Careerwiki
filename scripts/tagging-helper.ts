#!/usr/bin/env npx tsx
/**
 * tagging-helper.ts
 * 
 * 태깅 워크플로우 헬퍼 - 배치 추출/적용을 간편하게
 * 
 * Usage:
 *   npx tsx scripts/tagging-helper.ts status          # 현재 상황 확인
 *   npx tsx scripts/tagging-helper.ts next            # 다음 배치 추출
 *   npx tsx scripts/tagging-helper.ts apply 001       # 배치 001 결과 적용
 *   npx tsx scripts/tagging-helper.ts prompt 001      # 배치 001용 프롬프트 생성
 */

import { execSync } from 'child_process'
import * as fs from 'fs'
import * as path from 'path'

const BATCH_SIZE = 100
const BATCHES_DIR = 'tagging-batches'
const RESULTS_DIR = 'tagging-batches/results'
const COMPLETED_DIR = 'tagging-batches/completed'

function executeD1Query(query: string): any {
  const cleanQuery = query.replace(/\s+/g, ' ').trim()
  const cmd = `npx wrangler d1 execute careerwiki-db --local --json --command="${cleanQuery.replace(/"/g, '\\"')}"`
  const result = execSync(cmd, { encoding: 'utf-8', maxBuffer: 50 * 1024 * 1024 })
  const parsed = JSON.parse(result)
  return parsed[0]?.results || []
}

function getStatus() {
  console.log('\n📊 태깅 현황\n')

  // Total unique jobs
  const totalResult = executeD1Query("SELECT COUNT(DISTINCT job_id) as total FROM job_sources")
  const total = totalResult[0]?.total || 0

  // Tagged count (unique jobs)
  const taggedResult = executeD1Query("SELECT COUNT(DISTINCT job_id) as tagged FROM job_attributes WHERE status = 'tagged'")
  const tagged = taggedResult[0]?.tagged || 0

  // Untagged count
  const untagged = total - tagged
  const progress = ((tagged / total) * 100).toFixed(1)

  console.log(`전체 고유 직업: ${total.toLocaleString()}개`)
  console.log(`태깅 완료:      ${tagged.toLocaleString()}개 (${progress}%)`)
  console.log(`미태깅:         ${untagged.toLocaleString()}개`)
  console.log(``)
  console.log(`남은 배치 수:   ${Math.ceil(untagged / BATCH_SIZE)}개 (배치당 ${BATCH_SIZE}개)`)

  // Check for pending batches
  const pendingBatches = fs.readdirSync(BATCHES_DIR)
    .filter(f => f.startsWith('batch_') && f.endsWith('.json'))

  if (pendingBatches.length > 0) {
    console.log(`\n📁 추출된 배치: ${pendingBatches.join(', ')}`)
  }

  const pendingResults = fs.existsSync(RESULTS_DIR)
    ? fs.readdirSync(RESULTS_DIR).filter(f => f.endsWith('_tagged.json'))
    : []

  if (pendingResults.length > 0) {
    console.log(`📝 적용 대기 결과: ${pendingResults.join(', ')}`)
  }

  console.log('\n💡 다음 명령어:')
  console.log('   npx tsx scripts/tagging-helper.ts next       # 다음 배치 추출')
  console.log('   npx tsx scripts/tagging-helper.ts prompt 001 # 프롬프트 생성')
  console.log('   npx tsx scripts/tagging-helper.ts apply 001  # 결과 적용')
}

function getNextBatchNumber(): string {
  // Find the highest batch number that has been extracted or completed
  const allBatches = [
    ...fs.readdirSync(BATCHES_DIR).filter(f => f.startsWith('batch_')),
    ...fs.readdirSync(COMPLETED_DIR).filter(f => f.startsWith('batch_')),
  ]
  
  let maxNum = 0
  for (const batch of allBatches) {
    const match = batch.match(/batch_(\d+)/)
    if (match) {
      const num = parseInt(match[1], 10)
      if (num > maxNum) maxNum = num
    }
  }
  
  return String(maxNum + 1).padStart(3, '0')
}

function extractNextBatch() {
  const batchNum = getNextBatchNumber()
  const offset = (parseInt(batchNum, 10) - 1) * BATCH_SIZE
  const outputFile = path.join(BATCHES_DIR, `batch_${batchNum}.json`)
  
  console.log(`\n📦 배치 ${batchNum} 추출 중... (offset: ${offset})`)
  
  try {
    execSync(
      `npx tsx scripts/export-jobs-for-tagging.ts --limit ${BATCH_SIZE} --offset ${offset} --output ${outputFile}`,
      { stdio: 'inherit' }
    )
    
    console.log(`\n✅ 저장됨: ${outputFile}`)
    console.log(`\n💡 다음 단계:`)
    console.log(`   1. docs/TAGGING_PROMPT_TEMPLATE.md 열기`)
    console.log(`   2. ${outputFile} 내용으로 태깅 진행`)
    console.log(`   3. 결과를 ${RESULTS_DIR}/batch_${batchNum}_tagged.json 에 저장`)
    console.log(`   4. npx tsx scripts/tagging-helper.ts apply ${batchNum}`)
  } catch (error) {
    console.error('추출 실패:', error)
  }
}

function generatePrompt(batchNum: string) {
  const inputFile = path.join(BATCHES_DIR, `batch_${batchNum}.json`)
  
  if (!fs.existsSync(inputFile)) {
    console.error(`❌ 배치 파일 없음: ${inputFile}`)
    console.log(`   먼저 실행: npx tsx scripts/tagging-helper.ts next`)
    return
  }
  
  const jobs = JSON.parse(fs.readFileSync(inputFile, 'utf-8'))
  
  // Read prompt template
  const template = fs.readFileSync('docs/TAGGING_PROMPT_TEMPLATE.md', 'utf-8')
  
  // Extract just the prompt part
  const promptMatch = template.match(/```[\s\S]*?당신은[\s\S]*?```/m)
  const prompt = promptMatch ? promptMatch[0].replace(/```/g, '').trim() : ''
  
  console.log('\n' + '='.repeat(80))
  console.log('📋 태깅 프롬프트 (복사해서 Cursor/Grok에 붙여넣기)')
  console.log('='.repeat(80))
  console.log('')
  console.log(prompt)
  console.log('')
  console.log('### 직업 정보 (아래 JSON 배열을 태깅해주세요)')
  console.log('')
  console.log('```json')
  console.log(JSON.stringify(jobs.slice(0, 10), null, 2))  // Show first 10 for preview
  console.log('```')
  console.log('')
  console.log(`총 ${jobs.length}개 직업 - 전체 데이터: ${inputFile}`)
  console.log('')
  console.log('='.repeat(80))
  console.log('')
  console.log(`💡 결과 저장 경로: ${RESULTS_DIR}/batch_${batchNum}_tagged.json`)
}

function applyBatch(batchNum: string) {
  const inputFile = path.join(RESULTS_DIR, `batch_${batchNum}_tagged.json`)
  const outputFile = path.join(COMPLETED_DIR, `batch_${batchNum}.sql`)
  
  if (!fs.existsSync(inputFile)) {
    console.error(`❌ 결과 파일 없음: ${inputFile}`)
    console.log(`   태깅 결과를 ${inputFile}에 저장하세요.`)
    return
  }
  
  console.log(`\n📥 배치 ${batchNum} 적용 중...`)
  
  try {
    // Generate SQL
    execSync(
      `npx tsx scripts/generate-tagging-sql.ts --input ${inputFile} --output ${outputFile}`,
      { stdio: 'inherit' }
    )
    
    // Apply SQL
    console.log('\n⚡ SQL 적용 중...')
    execSync(
      `npx wrangler d1 execute careerwiki-db --local --file ${outputFile}`,
      { stdio: 'inherit' }
    )
    
    console.log(`\n✅ 배치 ${batchNum} 적용 완료!`)
    console.log('\n💡 다음: npx tsx scripts/tagging-helper.ts status')
  } catch (error) {
    console.error('적용 실패:', error)
  }
}

function main() {
  const command = process.argv[2]
  const arg = process.argv[3]
  
  // Ensure directories exist
  ;[BATCHES_DIR, RESULTS_DIR, COMPLETED_DIR].forEach(dir => {
    if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true })
  })
  
  switch (command) {
    case 'status':
      getStatus()
      break
    case 'next':
      extractNextBatch()
      break
    case 'prompt':
      if (!arg) {
        console.error('사용법: npx tsx scripts/tagging-helper.ts prompt <배치번호>')
        console.error('예: npx tsx scripts/tagging-helper.ts prompt 001')
        process.exit(1)
      }
      generatePrompt(arg.padStart(3, '0'))
      break
    case 'apply':
      if (!arg) {
        console.error('사용법: npx tsx scripts/tagging-helper.ts apply <배치번호>')
        console.error('예: npx tsx scripts/tagging-helper.ts apply 001')
        process.exit(1)
      }
      applyBatch(arg.padStart(3, '0'))
      break
    default:
      console.log(`
태깅 헬퍼 스크립트

사용법:
  npx tsx scripts/tagging-helper.ts <command> [args]

명령어:
  status          현재 태깅 현황 확인
  next            다음 배치 추출 (100개)
  prompt <num>    배치용 프롬프트 출력
  apply <num>     태깅 결과 적용

예시:
  npx tsx scripts/tagging-helper.ts status
  npx tsx scripts/tagging-helper.ts next
  npx tsx scripts/tagging-helper.ts prompt 001
  npx tsx scripts/tagging-helper.ts apply 001
      `)
  }
}

main()

