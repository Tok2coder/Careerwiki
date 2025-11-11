/**
 * 시딩된 데이터 검증 스크립트
 * D1 데이터베이스에 저장된 전공 및 직업 데이터를 검증
 */

import { readFileSync } from 'fs'
import { resolve } from 'path'
import { Miniflare } from 'miniflare'
import type { D1Database } from '@cloudflare/workers-types'

// .dev.vars 파일에서 환경 변수 로드
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

interface VerificationResult {
  majors: {
    total: number
    withCareerNet: number
    withGoyong24: number
    withBoth: number
    phase1Fields: {
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
  jobs: {
    total: number
    withCareerNet: number
    withGoyong24: number
    withBoth: number
  }
}

async function verifyData(): Promise<VerificationResult> {
  // Miniflare를 사용하여 로컬 D1 인스턴스 생성
  const mf = new Miniflare({
    modules: true,
    script: '',
    d1Databases: {
      DB: 'edc21e23-c2ac-4693-bb79-389b6914e173'
    },
    d1Persist: './.wrangler/state/v3/d1'
  })

  const db = await mf.getD1Database('DB') as D1Database

  console.log('🔍 데이터 검증 시작...\n')
  console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━')

  // 1. 전공 데이터 검증
  console.log('📊 전공 데이터 검증')
  console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━')

  const majorCount = await db.prepare('SELECT COUNT(*) as count FROM majors').first<{ count: number }>()
  const majorTotal = majorCount?.count || 0
  console.log(`✅ 총 전공 수: ${majorTotal}개`)

  const majorWithCareerNet = await db.prepare('SELECT COUNT(*) as count FROM majors WHERE careernet_id IS NOT NULL').first<{ count: number }>()
  const majorCareerNetCount = majorWithCareerNet?.count || 0
  console.log(`✅ CareerNet 데이터 보유: ${majorCareerNetCount}개`)

  const majorWithGoyong24 = await db.prepare('SELECT COUNT(*) as count FROM majors WHERE goyong24_id IS NOT NULL').first<{ count: number }>()
  const majorGoyong24Count = majorWithGoyong24?.count || 0
  console.log(`✅ Goyong24 데이터 보유: ${majorGoyong24Count}개`)

  const majorWithBoth = await db.prepare('SELECT COUNT(*) as count FROM majors WHERE careernet_id IS NOT NULL AND goyong24_id IS NOT NULL').first<{ count: number }>()
  const majorBothCount = majorWithBoth?.count || 0
  console.log(`✅ 양쪽 모두 보유: ${majorBothCount}개`)

  // Phase 1 필드 검증
  console.log('\n📋 Phase 1 필드 수집률:')
  const phase1Fields = {
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

  // 샘플 데이터로 필드 확인
  const sampleMajors = await db.prepare('SELECT api_data_json FROM majors LIMIT 100').all<{ api_data_json: string }>()
  
  for (const row of sampleMajors.results || []) {
    try {
      const apiData = JSON.parse(row.api_data_json)
      const merged = apiData?.merged || {}
      
      if (merged.relateSubject && Array.isArray(merged.relateSubject) && merged.relateSubject.length > 0) phase1Fields.relateSubject++
      if (merged.careerAct && Array.isArray(merged.careerAct) && merged.careerAct.length > 0) phase1Fields.careerAct++
      if (merged.mainSubject && Array.isArray(merged.mainSubject) && merged.mainSubject.length > 0) phase1Fields.mainSubject++
      if (merged.enterField && Array.isArray(merged.enterField) && merged.enterField.length > 0) phase1Fields.enterField++
      if (merged.property) phase1Fields.property++
      if (merged.universityList && Array.isArray(merged.universityList) && merged.universityList.length > 0) phase1Fields.universityList++
      if (merged.chartData) phase1Fields.chartData++
      if (merged.genCD) phase1Fields.genCD++
      if (merged.schClass) phase1Fields.schClass++
      if (merged.lstMiddleAptd && Array.isArray(merged.lstMiddleAptd) && merged.lstMiddleAptd.length > 0) phase1Fields.lstMiddleAptd++
      if (merged.lstHighAptd && Array.isArray(merged.lstHighAptd) && merged.lstHighAptd.length > 0) phase1Fields.lstHighAptd++
      if (merged.lstVals && Array.isArray(merged.lstVals) && merged.lstVals.length > 0) phase1Fields.lstVals++
    } catch (e) {
      // JSON 파싱 에러 무시
    }
  }

  // 전체 데이터로 확장 계산
  const sampleSize = sampleMajors.results?.length || 100
  const scaleFactor = majorTotal / sampleSize

  console.log(`   (샘플 ${sampleSize}개 기준, 전체 ${majorTotal}개로 확장)`)
  Object.entries(phase1Fields).forEach(([field, count]) => {
    const estimated = Math.round(count * scaleFactor)
    const percentage = majorTotal > 0 ? ((estimated / majorTotal) * 100).toFixed(1) : '0.0'
    console.log(`   - ${field}: ${estimated}개 (${percentage}%)`)
  })

  // 2. 직업 데이터 검증
  console.log('\n\n📊 직업 데이터 검증')
  console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━')

  const jobCount = await db.prepare('SELECT COUNT(*) as count FROM jobs').first<{ count: number }>()
  const jobTotal = jobCount?.count || 0
  console.log(`✅ 총 직업 수: ${jobTotal}개`)

  const jobWithCareerNet = await db.prepare('SELECT COUNT(*) as count FROM jobs WHERE careernet_id IS NOT NULL').first<{ count: number }>()
  const jobCareerNetCount = jobWithCareerNet?.count || 0
  console.log(`✅ CareerNet 데이터 보유: ${jobCareerNetCount}개`)

  const jobWithGoyong24 = await db.prepare('SELECT COUNT(*) as count FROM jobs WHERE goyong24_id IS NOT NULL').first<{ count: number }>()
  const jobGoyong24Count = jobWithGoyong24?.count || 0
  console.log(`✅ Goyong24 데이터 보유: ${jobGoyong24Count}개`)

  const jobWithBoth = await db.prepare('SELECT COUNT(*) as count FROM jobs WHERE careernet_id IS NOT NULL AND goyong24_id IS NOT NULL').first<{ count: number }>()
  const jobBothCount = jobWithBoth?.count || 0
  console.log(`✅ 양쪽 모두 보유: ${jobBothCount}개`)

  // 3. 데이터 품질 검증
  console.log('\n\n📊 데이터 품질 검증')
  console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━')

  // API 데이터가 있는지 확인
  const majorWithApiData = await db.prepare('SELECT COUNT(*) as count FROM majors WHERE api_data_json IS NOT NULL AND api_data_json != \'\'').first<{ count: number }>()
  const majorApiDataCount = majorWithApiData?.count || 0
  console.log(`✅ 전공 API 데이터 보유: ${majorApiDataCount}/${majorTotal} (${((majorApiDataCount / majorTotal) * 100).toFixed(1)}%)`)

  const jobWithApiData = await db.prepare('SELECT COUNT(*) as count FROM jobs WHERE api_data_json IS NOT NULL AND api_data_json != \'\'').first<{ count: number }>()
  const jobApiDataCount = jobWithApiData?.count || 0
  console.log(`✅ 직업 API 데이터 보유: ${jobApiDataCount}/${jobTotal} (${((jobApiDataCount / jobTotal) * 100).toFixed(1)}%)`)

  // 최근 업데이트 확인
  const recentMajors = await db.prepare('SELECT COUNT(*) as count FROM majors WHERE api_last_updated_at > ?').bind(Date.now() - 24 * 60 * 60 * 1000).first<{ count: number }>()
  const recentMajorCount = recentMajors?.count || 0
  console.log(`✅ 최근 24시간 내 업데이트된 전공: ${recentMajorCount}개`)

  const recentJobs = await db.prepare('SELECT COUNT(*) as count FROM jobs WHERE api_last_updated_at > ?').bind(Date.now() - 24 * 60 * 60 * 1000).first<{ count: number }>()
  const recentJobCount = recentJobs?.count || 0
  console.log(`✅ 최근 24시간 내 업데이트된 직업: ${recentJobCount}개`)

  // 4. 종합 요약
  console.log('\n\n📊 종합 요약')
  console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━')
  console.log(`✅ 전공 데이터: ${majorTotal}개`)
  console.log(`   - CareerNet: ${majorCareerNetCount}개`)
  console.log(`   - Goyong24: ${majorGoyong24Count}개`)
  console.log(`   - 양쪽 모두: ${majorBothCount}개`)
  console.log(`\n✅ 직업 데이터: ${jobTotal}개`)
  console.log(`   - CareerNet: ${jobCareerNetCount}개`)
  console.log(`   - Goyong24: ${jobGoyong24Count}개`)
  console.log(`   - 양쪽 모두: ${jobBothCount}개`)
  console.log(`\n✅ 총 데이터: ${majorTotal + jobTotal}개`)

  return {
    majors: {
      total: majorTotal,
      withCareerNet: majorCareerNetCount,
      withGoyong24: majorGoyong24Count,
      withBoth: majorBothCount,
      phase1Fields: {
        relateSubject: Math.round(phase1Fields.relateSubject * scaleFactor),
        careerAct: Math.round(phase1Fields.careerAct * scaleFactor),
        mainSubject: Math.round(phase1Fields.mainSubject * scaleFactor),
        enterField: Math.round(phase1Fields.enterField * scaleFactor),
        property: Math.round(phase1Fields.property * scaleFactor),
        universityList: Math.round(phase1Fields.universityList * scaleFactor),
        chartData: Math.round(phase1Fields.chartData * scaleFactor),
        genCD: Math.round(phase1Fields.genCD * scaleFactor),
        schClass: Math.round(phase1Fields.schClass * scaleFactor),
        lstMiddleAptd: Math.round(phase1Fields.lstMiddleAptd * scaleFactor),
        lstHighAptd: Math.round(phase1Fields.lstHighAptd * scaleFactor),
        lstVals: Math.round(phase1Fields.lstVals * scaleFactor)
      }
    },
    jobs: {
      total: jobTotal,
      withCareerNet: jobCareerNetCount,
      withGoyong24: jobGoyong24Count,
      withBoth: jobBothCount
    }
  }
}

// Main execution
;(async () => {
  try {
    const result = await verifyData()
    
    console.log('\n✅ 데이터 검증 완료!')
    process.exit(0)
  } catch (error) {
    console.error('\n❌ 데이터 검증 실패:', error)
    process.exit(1)
  }
})()

