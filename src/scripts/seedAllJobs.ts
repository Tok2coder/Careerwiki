/**
 * Seed All Jobs Script - Full Version
 * 커리어넷과 고용24의 모든 직업 데이터를 D1 데이터베이스에 저장
 */

import { searchJobs, JOB_CATEGORIES } from '../api/careernetAPI'
import { getUnifiedJobDetailWithRawData } from '../services/profileDataService'
import type { UnifiedJobDetail } from '../types/unifiedProfiles'

// 환경 변수 타입
interface Env {
  DB: D1Database
  CAREER_NET_API_KEY?: string
  GOYONG24_MAJOR_API_KEY?: string
  GOYONG24_JOB_API_KEY?: string
}

// 진행 상태 추적
export interface SeedProgress {
  total: number
  processed: number
  inserted: number
  updated: number
  skipped: number
  errors: number
  errorDetails: Array<{ id: string; name: string; error: string }>
  startTime: number
  estimatedTimeLeft?: string
}

// Rate limiting을 위한 sleep 함수
function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms))
}

// Web Crypto API를 사용한 해시 생성
async function generateDataHash(data: any): Promise<string> {
  const normalized = JSON.stringify(data, Object.keys(data).sort())
  const encoder = new TextEncoder()
  const dataBuffer = encoder.encode(normalized)
  const hashBuffer = await crypto.subtle.digest('SHA-256', dataBuffer)
  const hashArray = Array.from(new Uint8Array(hashBuffer))
  return hashArray.map(b => b.toString(16).padStart(2, '0')).join('')
}

// 직업 데이터를 D1에 저장 (upsert)
async function upsertJob(
  db: D1Database,
  jobData: {
    id: string
    name: string
    careernetId?: string
    goyong24Id?: string
    api_data_json: string
    api_data_hash: string
  }
): Promise<'inserted' | 'updated' | 'skipped'> {
  const now = Date.now()
  
  // 기존 데이터 확인
  const existing = await db.prepare('SELECT id, api_data_hash FROM jobs WHERE id = ?')
    .bind(jobData.id)
    .first<{ id: string; api_data_hash: string }>()
  
  if (existing) {
    // 해시가 같으면 스킵
    if (existing.api_data_hash === jobData.api_data_hash) {
      return 'skipped'
    }
    
    // 업데이트
    await db.prepare(`
      UPDATE jobs SET
        name = ?,
        careernet_id = ?,
        goyong24_id = ?,
        api_data_json = ?,
        api_data_hash = ?,
        api_last_fetched_at = ?,
        api_last_updated_at = ?
      WHERE id = ?
    `).bind(
      jobData.name,
      jobData.careernetId || null,
      jobData.goyong24Id || null,
      jobData.api_data_json,
      jobData.api_data_hash,
      now,
      now,
      jobData.id
    ).run()
    
    return 'updated'
  } else {
    // 신규 삽입
    await db.prepare(`
      INSERT INTO jobs (
        id, name, careernet_id, goyong24_id,
        api_data_json, api_data_hash,
        api_last_fetched_at, api_last_updated_at,
        created_at, is_active
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 1)
    `).bind(
      jobData.id,
      jobData.name,
      jobData.careernetId || null,
      jobData.goyong24Id || null,
      jobData.api_data_json,
      jobData.api_data_hash,
      now,
      now,
      now
    ).run()
    
    return 'inserted'
  }
}

// 커리어넷에서 모든 직업 ID 수집
async function fetchCareernetJobIds(env: Env): Promise<Array<{ id: string; name: string; source: 'careernet' }>> {
  console.log('📋 커리어넷 직업 목록 수집 중...')
  
  const allJobs: Array<{ id: string; name: string; source: 'careernet' }> = []
  
  // 각 카테고리별로 직업 수집
  for (const [categoryName, categoryCode] of Object.entries(JOB_CATEGORIES)) {
    console.log(`  - ${categoryName} (${categoryCode}) 수집 중...`)
    
    try {
      const jobs = await searchJobs({ category: categoryCode }, env)
      
      // Debug: Check first job structure
      if (jobs.length > 0 && allJobs.length === 0) {
        console.log(`    🔍 첫 번째 직업:`, jobs[0].jobdicSeq, jobs[0].jobName)
        console.log(`    🔍 전체 keys:`, Object.keys(jobs[0]).join(', '))
      }
      
      for (const job of jobs) {
        const jobData = {
          id: job.jobdicSeq,  // Changed from job.job_id
          name: job.jobName,   // Changed from job.job_name
          source: 'careernet' as const
        }
        allJobs.push(jobData)
        
        // Debug first 3 jobs from first category
        if (allJobs.length <= 3) {
          console.log(`    📝 추가됨 #${allJobs.length}: id="${jobData.id}", name="${jobData.name}"`)
        }
      }
      
      console.log(`    ✓ ${jobs.length}개 직업 발견`)
      await sleep(300) // Rate limiting
    } catch (error: any) {
      console.error(`  ❌ ${categoryName} 수집 실패:`, error.message)
    }
  }
  
  console.log(`✅ 커리어넷: 총 ${allJobs.length}개 직업 발견`)
  return allJobs
}

// 중복 제거 (이름 기준, 커리어넷 우선)
function deduplicateJobs(jobs: Array<{ id: string; name: string; source: string }>): Array<{ id: string; name: string; source: string }> {
  const seen = new Map<string, { id: string; name: string; source: string }>()
  
  for (const job of jobs) {
    // Safe handling of undefined/null job names
    const normalizedName = (job.name ?? '').trim().toLowerCase()
    
    // Skip jobs with empty names
    if (!normalizedName) {
      continue
    }
    
    if (!seen.has(normalizedName)) {
      seen.set(normalizedName, job)
    } else {
      // 중복 발견 - 커리어넷 우선
      const existing = seen.get(normalizedName)!
      if (job.source === 'careernet' && existing.source !== 'careernet') {
        seen.set(normalizedName, job)
      }
    }
  }
  
  return Array.from(seen.values())
}

// 진행 상태 출력
function printProgress(progress: SeedProgress): void {
  const elapsed = Date.now() - progress.startTime
  const elapsedMinutes = Math.floor(elapsed / 60000)
  const elapsedSeconds = Math.floor((elapsed % 60000) / 1000)
  
  const percentage = progress.total > 0 ? Math.round((progress.processed / progress.total) * 100) : 0
  
  // 예상 남은 시간 계산
  if (progress.processed > 0) {
    const avgTimePerJob = elapsed / progress.processed
    const remainingJobs = progress.total - progress.processed
    const remainingMs = avgTimePerJob * remainingJobs
    const remainingMinutes = Math.floor(remainingMs / 60000)
    const remainingSeconds = Math.floor((remainingMs % 60000) / 1000)
    progress.estimatedTimeLeft = `${remainingMinutes}분 ${remainingSeconds}초`
  }
  
  console.log(`
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 진행 상황: ${progress.processed}/${progress.total} (${percentage}%)
✅ 삽입: ${progress.inserted} | 🔄 업데이트: ${progress.updated} | ⏭️  스킵: ${progress.skipped}
❌ 에러: ${progress.errors}
⏱️  경과 시간: ${elapsedMinutes}분 ${elapsedSeconds}초
${progress.estimatedTimeLeft ? `⏳ 예상 남은 시간: ${progress.estimatedTimeLeft}` : ''}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  `.trim())
}

// 메인 Seed 함수
export async function seedAllJobs(env: Env): Promise<SeedProgress> {
  console.log('🌱 Seed All Jobs - Full Version Starting...')
  console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━')
  
  const progress: SeedProgress = {
    total: 0,
    processed: 0,
    inserted: 0,
    updated: 0,
    skipped: 0,
    errors: 0,
    errorDetails: [],
    startTime: Date.now()
  }
  
  // 1. D1 연결 테스트
  try {
    const result = await env.DB.prepare('SELECT COUNT(*) as count FROM jobs').first()
    console.log('✅ D1 연결 성공, 기존 직업 수:', result)
  } catch (error: any) {
    console.error('❌ D1 연결 실패:', error.message)
    progress.errors++
    progress.errorDetails.push({
      id: 'db-test',
      name: 'Database Connection',
      error: error.message
    })
    return progress
  }
  
  // 2. 커리어넷에서 모든 직업 ID 수집
  let allJobs: Array<{ id: string; name: string; source: string }> = []
  try {
    const careernetJobs = await fetchCareernetJobIds(env)
    allJobs = careernetJobs
  } catch (error: any) {
    console.error('❌ 직업 목록 수집 실패:', error.message)
    progress.errors++
    progress.errorDetails.push({
      id: 'fetch-jobs',
      name: 'Fetch Job List',
      error: error.message
    })
    return progress
  }
  
  // 3. 중복 제거
  const uniqueJobs = deduplicateJobs(allJobs)
  progress.total = uniqueJobs.length
  console.log(`\n📝 중복 제거 완료: ${allJobs.length}개 → ${uniqueJobs.length}개`)
  console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n')
  
  // 4. 각 직업 데이터 수집 및 저장
  for (let i = 0; i < uniqueJobs.length; i++) {
    const job = uniqueJobs[i]
    progress.processed++
    
    try {
      // 통합 직업 상세 데이터 가져오기
      const result = await getUnifiedJobDetailWithRawData({ id: job.id }, env)
      
      // 데이터 검증 강화
      if (!result) {
        throw new Error('API returned null or undefined')
      }
      
      if (!result.profile) {
        throw new Error('Profile data is missing')
      }
      
      // profile의 기본 필드 검증 - 여러 가능한 필드명 확인
      const jobName = result.profile.job_name || result.profile.jobName || result.profile.job || result.profile.name
      if (!jobName || typeof jobName !== 'string') {
        console.error('❌ Invalid job_name. Available fields:', Object.keys(result.profile).slice(0, 20))
        throw new Error('Invalid job_name in profile')
      }
      
      // profile 데이터 정리 - undefined/null 필드 제거 및 문자열 정규화
      const cleanProfile = JSON.parse(JSON.stringify(result.profile, (key, value) => {
        // undefined는 JSON에서 제외됨
        if (value === null) return undefined
        // 빈 문자열도 제거
        if (typeof value === 'string' && value.trim() === '') return undefined
        // 정상 값은 그대로 반환
        return value
      }))
      
      // 안전한 JSON 직렬화 (순환 참조 방지)
      let profileJson: string
      try {
        profileJson = JSON.stringify(cleanProfile)
      } catch (jsonError: any) {
        throw new Error(`JSON serialization failed: ${jsonError.message}`)
      }
      
      // 데이터 해시 생성 (정리된 profile 사용)
      const dataHash = await generateDataHash(cleanProfile)
      
      // D1에 저장
      const action = await upsertJob(env.DB, {
        id: job.id,
        name: job.name,
        careernetId: job.source === 'careernet' ? job.id : undefined,
        api_data_json: profileJson,
        api_data_hash: dataHash
      })
      
      if (action === 'inserted') {
        progress.inserted++
      } else if (action === 'updated') {
        progress.updated++
      } else {
        progress.skipped++
      }
      
      // 10개마다 진행 상황 출력
      if (progress.processed % 10 === 0 || progress.processed === progress.total) {
        printProgress(progress)
      }
      
    } catch (error: any) {
      progress.errors++
      const errorMessage = error?.message || String(error)
      progress.errorDetails.push({
        id: job.id,
        name: job.name,
        error: errorMessage
      })
      
      // 상세 에러 로그 (처음 5개만)
      if (progress.errors <= 5) {
        console.error(`❌ [${job.id}] ${job.name} 처리 실패:`, errorMessage)
        if (error?.stack) {
          console.error('Stack trace:', error.stack.split('\n').slice(0, 3).join('\n'))
        }
      } else if (progress.errors === 6) {
        console.error('❌ 에러가 많아 상세 로그 출력을 중단합니다. 최종 결과에서 확인하세요.')
      }
    }
    
    // Rate limiting: 500ms 대기
    await sleep(500)
  }
  
  // 5. 최종 결과 출력
  const totalTime = Date.now() - progress.startTime
  const totalMinutes = Math.floor(totalTime / 60000)
  const totalSeconds = Math.floor((totalTime % 60000) / 1000)
  
  console.log(`
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🎉 Seed 완료!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 총 처리: ${progress.processed}/${progress.total}
✅ 새로 삽입: ${progress.inserted}
🔄 업데이트: ${progress.updated}
⏭️  변경없음 (스킵): ${progress.skipped}
❌ 에러: ${progress.errors}
⏱️  총 소요 시간: ${totalMinutes}분 ${totalSeconds}초
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  `.trim())
  
  // 에러가 있으면 처음 10개만 출력
  if (progress.errors > 0 && progress.errorDetails.length > 0) {
    console.log('\n❌ 에러 상세 (처음 10개):')
    progress.errorDetails.slice(0, 10).forEach((err, idx) => {
      console.log(`  ${idx + 1}. [${err.id}] ${err.name}: ${err.error}`)
    })
  }
  
  return progress
}
