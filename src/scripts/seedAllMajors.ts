/**
 * Seed All Majors Script - Full Version
 * 커리어넷과 고용24의 모든 학과(전공) 데이터를 D1 데이터베이스에 저장
 */

import type { D1Database } from '@cloudflare/workers-types'
import { searchMajors as searchCareerNetMajors } from '../api/careernetAPI'
import { fetchGoyong24MajorList, fetchGoyong24MajorDetail } from '../api/goyong24API'
import { getUnifiedMajorDetail } from '../services/profileDataService'
import type { UnifiedMajorDetail } from '../types/unifiedProfiles'

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
  // Phase 1: 새 필드 수집 통계
  phase1Fields?: {
    relateSubject: number
    careerAct: number
    mainSubject: number
    enterField: number
    property: number
    universityList: number
    chartData: number
    genCD: number
    schClass: number
    lstMiddleAptd: number
    lstHighAptd: number
    lstVals: number
  }
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

// 전공 데이터를 D1에 저장 (upsert) - REPLACE 방식 사용
async function upsertMajor(
  db: D1Database,
  majorData: {
    id: string
    name: string
    careernetId?: string
    goyong24Id?: string
    api_data_json: string
    api_data_hash: string
  }
): Promise<'inserted' | 'updated' | 'skipped'> {
  const now = Date.now()
  
  // 기존 데이터 확인 (통계용)
  const existing = await db.prepare('SELECT id, api_data_hash FROM majors WHERE id = ?')
    .bind(majorData.id)
    .first<{ id: string; api_data_hash: string }>()
  
  // INSERT OR REPLACE 방식으로 무조건 삽입/업데이트
  await db.prepare(`
    INSERT OR REPLACE INTO majors (
      id, name, careernet_id, goyong24_id,
      api_data_json, api_data_hash,
      api_last_fetched_at, api_last_updated_at,
      created_at, is_active
    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 1)
  `).bind(
    majorData.id,
    majorData.name,
    majorData.careernetId || null,
    majorData.goyong24Id || null,
    majorData.api_data_json,
    majorData.api_data_hash,
    now,
    now,
    existing ? existing.id : now,  // 기존 created_at 유지 (실제로는 REPLACE로 덮어씌워짐)
  ).run()
  
  if (existing) {
    // 해시가 같아도 업데이트로 처리 (데이터 보장)
    return 'updated'
  } else {
    return 'inserted'
  }
}

// 커리어넷에서 모든 학과 ID 수집
async function fetchCareernetMajorIds(env: Env): Promise<Array<{ id: string; name: string; source: 'careernet' }>> {
  console.log('📋 커리어넷 학과 목록 수집 중...')
  
  const allMajors: Array<{ id: string; name: string; source: 'careernet' }> = []
  
  try {
    let page = 1
    let totalFetched = 0
    
    while (true) {
      const majors = await searchCareerNetMajors({ 
        thisPage: page,
        perPage: 100
      }, env)
      
      if (majors.length === 0) {
        break
      }
      
      for (const major of majors) {
        if (!major.majorSeq) continue
        
        allMajors.push({
          id: major.majorSeq,
          name: major.major || major.summary || '',
          source: 'careernet' as const
        })
      }
      
      totalFetched += majors.length
      console.log(`  페이지 ${page}: ${majors.length}개 수집 (누적: ${totalFetched})`)
      
      // 100개 미만이면 마지막 페이지
      if (majors.length < 100) {
        break
      }
      
      page++
      await sleep(300)
    }
    
    console.log(`✅ 커리어넷: 총 ${allMajors.length}개 학과 발견`)
    
    return allMajors
  } catch (error: any) {
    console.error(`  ❌ 커리어넷 학과 목록 수집 실패:`, error.message)
    return []
  }
}

// 고용24에서 모든 학과 ID 수집
async function fetchGoyong24MajorIds(env: Env): Promise<Array<{ id: string; name: string; source: 'goyong24'; majorGb: '1' | '2'; departmentId: string; majorId: string }>> {
  console.log('📋 고용24 학과 목록 수집 중...')
  
  const allMajors: Array<{ id: string; name: string; source: 'goyong24'; majorGb: '1' | '2'; departmentId: string; majorId: string }> = []
  
  try {
    // 고용24 학과는 키워드 검색이 필요
    // 최적화 전략: 단일 키워드 "과"로 900개 수집 + 보완 키워드로 나머지 20개 수집
    const keywords = [
      // 🔥 최고 효율 키워드 (900개 수집)
      '과',
      
      // 보완 키워드 (누락된 전공 추가)
      '학', '부', '공', '전공'
    ]
    
    const seenIds = new Set<string>()
    
    for (const keyword of keywords) {
      try {
        const response = await fetchGoyong24MajorList({ 
          keyword,
          srchType: 'K'
        }, env)
        
        for (const major of response.items) {
          if (!major.empCurtState2Id || !major.knowDtlSchDptNm) continue
          
          // 중복 체크 - 세부 학과명 기준 (더 많은 전공 수집)
          // knowDtlSchDptNm: 세부 학과명 (예: "컴퓨터교육과")
          // knowSchDptNm: 표준 학과명 (예: "공학교육과")
          const uniqueKey = `${major.knowDtlSchDptNm}_${major.empCurtState2Id}`
          if (seenIds.has(uniqueKey)) continue
          seenIds.add(uniqueKey)
          
          allMajors.push({
            id: `G${major.empCurtState2Id}_${major.knowDtlSchDptNm}`, // 고유 ID 생성 (prefix + 학과명)
            name: major.knowDtlSchDptNm, // 세부 학과명 사용
            source: 'goyong24' as const,
            majorGb: (major.majorGb as '1' | '2') || '1',
            departmentId: major.empCurtState1Id,
            majorId: major.empCurtState2Id
          })
        }
        
        console.log(`  키워드 "${keyword}": ${response.items.length}개 발견 (총 ${allMajors.length}개)`)
        await sleep(300)
      } catch (error: any) {
        console.warn(`  ⚠️  키워드 "${keyword}" 실패: ${error.message}`)
      }
    }
    
    console.log(`✅ 고용24: 총 ${allMajors.length}개 학과 발견`)
  } catch (error: any) {
    console.error(`  ❌ 고용24 목록 수집 실패:`, error.message)
    console.error(`  ℹ️  GOYONG24_MAJOR_API_KEY가 환경 변수에 설정되어 있는지 확인하세요`)
  }
  
  return allMajors
}

// 중복 제거 (ID 기준)
function deduplicateMajors(majors: Array<{ id: string; name: string; source: string }>): Array<{ id: string; name: string; source: string }> {
  const seen = new Map<string, { id: string; name: string; source: string }>()
  
  for (const major of majors) {
    if (!major.id) continue
    
    if (!seen.has(major.id)) {
      seen.set(major.id, major)
    } else {
      // 중복 발견 - 커리어넷 우선
      const existing = seen.get(major.id)!
      if (major.source === 'careernet' && existing.source !== 'careernet') {
        seen.set(major.id, major)
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
    const avgTimePerMajor = elapsed / progress.processed
    const remainingMajors = progress.total - progress.processed
    const remainingMs = avgTimePerMajor * remainingMajors
    const remainingMinutes = Math.floor(remainingMs / 60000)
    const remainingSeconds = Math.floor((remainingMs % 60000) / 1000)
    progress.estimatedTimeLeft = `${remainingMinutes}분 ${remainingSeconds}초`
  }
  
  console.log(
    `\n📊 진행 상황: ${progress.processed}/${progress.total} (${percentage}%)` +
    `\n   ✅ 삽입: ${progress.inserted} | 🔄 업데이트: ${progress.updated} | ⏭️  스킵: ${progress.skipped} | ❌ 오류: ${progress.errors}` +
    `\n   ⏱️  경과: ${elapsedMinutes}분 ${elapsedSeconds}초` +
    (progress.estimatedTimeLeft ? ` | 예상 남은 시간: ${progress.estimatedTimeLeft}` : '')
  )
}

// 메인 시딩 함수
export async function seedAllMajors(env: Env): Promise<SeedProgress> {
  console.log('🌱 전공 데이터 시딩 시작...\n')
  
  const progress: SeedProgress = {
    total: 0,
    processed: 0,
    inserted: 0,
    updated: 0,
    skipped: 0,
    errors: 0,
    errorDetails: [],
    startTime: Date.now(),
    // Phase 1: 새 필드 수집 통계 초기화
    phase1Fields: {
      relateSubject: 0,
      careerAct: 0,
      mainSubject: 0,
      enterField: 0,
      property: 0,
      universityList: 0,
      chartData: 0,
      genCD: 0,
      schClass: 0,
      lstMiddleAptd: 0,
      lstHighAptd: 0,
      lstVals: 0
    }
  }
  
  // 1단계: 커리어넷과 고용24에서 전공 목록 수집
  console.log('1단계: 전공 목록 수집')
  const careernetMajors = await fetchCareernetMajorIds(env)
  const goyong24Majors = await fetchGoyong24MajorIds(env)
  
  // 합치기
  const allMajorsRaw = [...careernetMajors, ...goyong24Majors]
  const allMajors = deduplicateMajors(allMajorsRaw)
  
  progress.total = allMajors.length
  console.log(`\n✅ 총 ${progress.total}개 전공 발견 (커리어넷: ${careernetMajors.length}, 고용24: ${goyong24Majors.length})\n`)
  
  // 2단계: 각 전공의 상세 데이터 수집 및 저장
  console.log('2단계: 전공 상세 데이터 수집 및 D1 저장')
  
  for (const major of allMajors) {
    try {
      // 통합 전공 상세 데이터 가져오기
      const request = major.source === 'goyong24'
        ? { 
            id: major.id,
            goyong24Params: {
              majorGb: (major as any).majorGb,
              departmentId: (major as any).departmentId,
              majorId: (major as any).majorId
            }
          }
        : major.source === 'careernet'
        ? { id: major.id, careernetId: major.id }
        : { id: major.id }
      
      const result = await getUnifiedMajorDetail(request, env)
      
      if (!result.profile) {
        throw new Error('전공 상세 데이터를 가져올 수 없습니다')
      }
      
      // Phase 1: 새 필드 수집 통계 업데이트
      const profile = result.profile
      if (profile.relateSubject && profile.relateSubject.length > 0) progress.phase1Fields!.relateSubject++
      if (profile.careerAct && profile.careerAct.length > 0) progress.phase1Fields!.careerAct++
      if (profile.mainSubject && profile.mainSubject.length > 0) progress.phase1Fields!.mainSubject++
      if (profile.enterField && profile.enterField.length > 0) progress.phase1Fields!.enterField++
      if (profile.property) progress.phase1Fields!.property++
      if (profile.universityList && profile.universityList.length > 0) progress.phase1Fields!.universityList++
      if (profile.chartData) progress.phase1Fields!.chartData++
      if (profile.genCD) progress.phase1Fields!.genCD++
      if (profile.schClass) progress.phase1Fields!.schClass++
      if (profile.lstMiddleAptd) progress.phase1Fields!.lstMiddleAptd++
      if (profile.lstHighAptd) progress.phase1Fields!.lstHighAptd++
      if (profile.lstVals) progress.phase1Fields!.lstVals++
      
      // 처음 3개 샘플에서 Phase 1 필드 상세 로깅
      if (progress.processed < 3) {
        console.log(`\n📝 샘플 ${progress.processed + 1}: ${major.name}`)
        console.log(`   relateSubject: ${profile.relateSubject ? `${profile.relateSubject.length}개 항목` : '없음'}`)
        console.log(`   careerAct: ${profile.careerAct ? `${profile.careerAct.length}개 항목` : '없음'}`)
        console.log(`   mainSubject: ${profile.mainSubject ? `${profile.mainSubject.length}개 항목` : '없음'}`)
        console.log(`   enterField: ${profile.enterField ? `${profile.enterField.length}개 항목` : '없음'}`)
        console.log(`   property: ${profile.property ? '있음' : '없음'}`)
        console.log(`   universityList: ${profile.universityList ? `${profile.universityList.length}개 대학` : '없음'}`)
        console.log(`   chartData: ${profile.chartData ? '있음' : '없음'}`)
        console.log(`   genCD: ${profile.genCD ? '있음' : '없음'}`)
        console.log(`   schClass: ${profile.schClass ? '있음' : '없음'}`)
        console.log(`   lstMiddleAptd: ${profile.lstMiddleAptd ? '있음' : '없음'}`)
        console.log(`   lstHighAptd: ${profile.lstHighAptd ? '있음' : '없음'}`)
        console.log(`   lstVals: ${profile.lstVals ? '있음' : '없음'}`)
      }
      
      // API 데이터 준비 - 모든 원본 필드 보존
      const apiData = {
        // normalize된 데이터 (표시용)
        careernet: result.partials?.CAREERNET || null,
        goyong24: result.partials?.GOYONG24 || null,
        merged: result.profile,
        sources: result.sources,
        // 원본 API 응답 (모든 필드 보존) - CareerNet과 Goyong24의 모든 필드 포함
        rawCareernet: result.rawPartials?.CAREERNET || null,  // CareerNet 원본 Major 객체 전체 (모든 필드)
        rawGoyong24: result.rawPartials?.GOYONG24 || null      // Goyong24 원본 Goyong24MajorDetail 객체 전체 (모든 필드)
      }
      
      const api_data_json = JSON.stringify(apiData)
      const api_data_hash = await generateDataHash(apiData)
      
      // D1에 저장
      const upsertResult = await upsertMajor(env.DB, {
        id: major.id,
        name: major.name,
        careernetId: major.source === 'careernet' ? major.id : undefined,
        goyong24Id: major.source === 'goyong24' ? major.id : undefined,
        api_data_json,
        api_data_hash
      })
      
      if (upsertResult === 'inserted') {
        progress.inserted++
      } else if (upsertResult === 'updated') {
        progress.updated++
      } else {
        progress.skipped++
      }
      
    } catch (error: any) {
      progress.errors++
      const errorMessage = error.message || String(error)
      progress.errorDetails.push({
        id: major.id,
        name: major.name,
        error: errorMessage
      })
      console.error(`  ❌ 오류 (${major.id} - ${major.name}): ${errorMessage}`)
      
      // API 연결 문제인 경우 경고
      if (errorMessage.includes('API 요청 실패') || errorMessage.includes('500') || errorMessage.includes('404')) {
        console.error(`  ⚠️  API 연결 문제가 있습니다. API 키와 엔드포인트를 확인하세요.`)
      }
    }
    
    progress.processed++
    
    // 진행 상황 출력 (매 50개마다)
    if (progress.processed % 50 === 0 || progress.processed === progress.total) {
      printProgress(progress)
    }
    
    // Rate limiting (500ms delay)
    await sleep(500)
  }
  
  // 최종 결과
  const elapsed = Date.now() - progress.startTime
  const elapsedMinutes = Math.floor(elapsed / 60000)
  const elapsedSeconds = Math.floor((elapsed % 60000) / 1000)
  
  console.log('\n' + '='.repeat(60))
  console.log('✅ 시딩 완료!')
  console.log('='.repeat(60))
  console.log(`총 처리: ${progress.processed}/${progress.total}`)
  console.log(`✅ 삽입: ${progress.inserted}`)
  console.log(`🔄 업데이트: ${progress.updated}`)
  console.log(`⏭️  스킵: ${progress.skipped}`)
  console.log(`❌ 오류: ${progress.errors}`)
  console.log(`⏱️  총 소요 시간: ${elapsedMinutes}분 ${elapsedSeconds}초`)
  
  // Phase 1: 새 필드 수집 통계 출력
  if (progress.phase1Fields) {
    const totalProcessed = progress.processed - progress.errors
    console.log('\n📊 Phase 1 필드 수집 통계:')
    console.log(`   relateSubject: ${progress.phase1Fields.relateSubject}/${totalProcessed} (${Math.round(progress.phase1Fields.relateSubject / totalProcessed * 100)}%)`)
    console.log(`   careerAct: ${progress.phase1Fields.careerAct}/${totalProcessed} (${Math.round(progress.phase1Fields.careerAct / totalProcessed * 100)}%)`)
    console.log(`   mainSubject: ${progress.phase1Fields.mainSubject}/${totalProcessed} (${Math.round(progress.phase1Fields.mainSubject / totalProcessed * 100)}%)`)
    console.log(`   enterField: ${progress.phase1Fields.enterField}/${totalProcessed} (${Math.round(progress.phase1Fields.enterField / totalProcessed * 100)}%)`)
    console.log(`   property: ${progress.phase1Fields.property}/${totalProcessed} (${Math.round(progress.phase1Fields.property / totalProcessed * 100)}%)`)
    console.log(`   universityList: ${progress.phase1Fields.universityList}/${totalProcessed} (${Math.round(progress.phase1Fields.universityList / totalProcessed * 100)}%)`)
    console.log(`   chartData: ${progress.phase1Fields.chartData}/${totalProcessed} (${Math.round(progress.phase1Fields.chartData / totalProcessed * 100)}%)`)
    console.log(`   genCD: ${progress.phase1Fields.genCD}/${totalProcessed} (${Math.round(progress.phase1Fields.genCD / totalProcessed * 100)}%)`)
    console.log(`   schClass: ${progress.phase1Fields.schClass}/${totalProcessed} (${Math.round(progress.phase1Fields.schClass / totalProcessed * 100)}%)`)
    console.log(`   lstMiddleAptd: ${progress.phase1Fields.lstMiddleAptd}/${totalProcessed} (${Math.round(progress.phase1Fields.lstMiddleAptd / totalProcessed * 100)}%)`)
    console.log(`   lstHighAptd: ${progress.phase1Fields.lstHighAptd}/${totalProcessed} (${Math.round(progress.phase1Fields.lstHighAptd / totalProcessed * 100)}%)`)
    console.log(`   lstVals: ${progress.phase1Fields.lstVals}/${totalProcessed} (${Math.round(progress.phase1Fields.lstVals / totalProcessed * 100)}%)`)
  }
  
  if (progress.errors > 0) {
    console.log('\n❌ 오류 상세:')
    progress.errorDetails.forEach((detail, index) => {
      console.log(`  ${index + 1}. ${detail.id} - ${detail.name}`)
      console.log(`     ${detail.error}`)
    })
  }
  
  return progress
}

// Main execution - ES Module detection
// Windows 호환성을 위해 더 간단한 체크 사용
const isMainModule = import.meta.url.endsWith(process.argv[1].replace(/\\/g, '/')) || 
                     import.meta.url.includes('seedAllMajors.ts')

if (isMainModule || import.meta.url.includes('seedAllMajors')) {
  ;(async () => {
    try {
      // .dev.vars 파일에서 환경 변수 로드
      const { readFileSync } = await import('fs')
      const { resolve } = await import('path')
      
      try {
        const devVarsPath = resolve(process.cwd(), '.dev.vars')
        const devVarsContent = readFileSync(devVarsPath, 'utf-8')
        devVarsContent.split('\n').forEach(line => {
          const trimmed = line.trim()
          if (trimmed && !trimmed.startsWith('#')) {
            const [key, ...valueParts] = trimmed.split('=')
            if (key && valueParts.length > 0) {
              const value = valueParts.join('=').trim()
              process.env[key.trim()] = value
            }
          }
        })
        console.log('✅ Loaded environment variables from .dev.vars')
      } catch (e) {
        console.warn('⚠️  Could not load .dev.vars file, using system environment variables')
      }
      
      // Miniflare를 사용하여 로컬 D1 인스턴스 생성
      const { Miniflare } = await import('miniflare')
      
      const mf = new Miniflare({
        modules: true,
        script: '',
        d1Databases: {
          DB: 'edc21e23-c2ac-4693-bb79-389b6914e173'  // database_id from wrangler.jsonc
        },
        d1Persist: './.wrangler/state/v3/d1'
      })

      const db = await mf.getD1Database('DB')
      
      const env: Env = {
        DB: db as any,
        CAREER_NET_API_KEY: process.env.CAREER_NET_API_KEY,
        GOYONG24_MAJOR_API_KEY: process.env.GOYONG24_MAJOR_API_KEY,
        GOYONG24_JOB_API_KEY: process.env.GOYONG24_JOB_API_KEY
      }

      console.log('🚀 Starting seeding process...\n')
      await seedAllMajors(env)
      console.log('\n✅ Seeding completed successfully')
      process.exit(0)
    } catch (error) {
      console.error('\n❌ Seeding failed:', error)
      process.exit(1)
    }
  })()
}
