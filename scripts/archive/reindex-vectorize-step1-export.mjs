#!/usr/bin/env node
/**
 * Step 1: D1에서 직업 데이터 내보내기
 * 
 * wrangler d1 execute를 통해 직업 데이터를 JSON으로 내보냅니다.
 * 
 * 사용법:
 *   node scripts/reindex-vectorize-step1-export.mjs
 * 
 * 출력:
 *   artifacts/jobs-for-vectorize.json
 */

import { execSync } from 'child_process'
import { writeFileSync } from 'fs'
import { join, dirname } from 'path'
import { fileURLToPath } from 'url'

const __dirname = dirname(fileURLToPath(import.meta.url))

async function main() {
  console.log('========================================')
  console.log('Step 1: D1에서 직업 데이터 내보내기')
  console.log('========================================')
  
  const BATCH_SIZE = 200
  let offset = 0
  const allJobs = []
  
  while (true) {
    console.log(`직업 조회 중... (offset: ${offset})`)
    
    try {
      const result = execSync(
        `npx wrangler d1 execute careerwiki-kr --remote --json --command "SELECT ja.job_id, ja.job_name, COALESCE(jd.description, '') as description, COALESCE(jd.category, '') as category FROM job_attributes ja LEFT JOIN job_details jd ON ja.job_id = jd.job_id LIMIT ${BATCH_SIZE} OFFSET ${offset}"`,
        { encoding: 'utf-8', maxBuffer: 50 * 1024 * 1024 }
      )
      
      const data = JSON.parse(result)
      const jobs = data[0]?.results || []
      
      if (jobs.length === 0) {
        console.log('모든 직업 조회 완료!')
        break
      }
      
      console.log(`  ${jobs.length}개 직업 로드됨`)
      allJobs.push(...jobs)
      
      offset += BATCH_SIZE
      
      // Rate limit 방지
      await new Promise(resolve => setTimeout(resolve, 500))
      
    } catch (error) {
      console.error(`오류 발생 (offset: ${offset}):`, error.message)
      // 재시도
      await new Promise(resolve => setTimeout(resolve, 2000))
    }
  }
  
  // JSON 파일로 저장
  const outputPath = join(__dirname, '..', 'artifacts', 'jobs-for-vectorize.json')
  writeFileSync(outputPath, JSON.stringify(allJobs, null, 2))
  
  console.log('')
  console.log('========================================')
  console.log('내보내기 완료!')
  console.log('========================================')
  console.log(`총 직업: ${allJobs.length}개`)
  console.log(`출력 파일: ${outputPath}`)
}

main().catch(error => {
  console.error('치명적 오류:', error)
  process.exit(1)
})
