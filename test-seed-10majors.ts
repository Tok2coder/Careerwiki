/**
 * Test Seed 10 Majors - Phase 1 Verification
 * 10개 샘플 학과로 Phase 1 필드 수집 테스트
 */

import type { D1Database } from '@cloudflare/workers-types'
import { getMajorDetail, normalizeCareerNetMajorDetail } from './src/api/careernetAPI'

// 환경 변수 타입
interface Env {
  DB: D1Database
  CAREER_NET_API_KEY?: string
  GOYONG24_MAJOR_API_KEY?: string
  GOYONG24_JOB_API_KEY?: string
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

// 10개 테스트 샘플 (다양한 분야) - 실제 CareerNet majorSeq 사용
const TEST_MAJORS = [
  { id: '463', name: '전기전자공학과', category: '공학' },
  { id: '86', name: '기계공학과', category: '공학' },
  { id: '23', name: '경영학과', category: '사회과학' },
  { id: '330', name: '심리학과', category: '사회과학' },
  { id: '10', name: '간호학과', category: '의학' },
  { id: '33', name: '공업디자인과', category: '예체능' },
  { id: '396', name: '음악학과', category: '예체능' },
  { id: '69', name: '국어국문학과', category: '인문' },
  { id: '366', name: '영어영문학과', category: '인문' },
  { id: '20', name: '건축학과', category: '공학' }
]

async function testSeed10Majors(env: Env) {
  console.log('🧪 10개 샘플 학과 재시딩 테스트 시작\n')
  console.log('=' .repeat(60))
  
  const stats = {
    total: TEST_MAJORS.length,
    success: 0,
    failed: 0,
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
  
  for (const testMajor of TEST_MAJORS) {
    try {
      console.log(`\n📝 ${testMajor.name} (${testMajor.category})`)
      console.log(`   ID: ${testMajor.id}`)
      
      // 1. CareerNet API에서 직접 데이터 가져오기 (env 없이 호출 - 기본 API 키 사용)
      const careernetRaw = await getMajorDetail(testMajor.id)
      
      if (!careernetRaw) {
        throw new Error('CareerNet API 데이터 없음')
      }
      
      // 2. 정규화
      const profile = normalizeCareerNetMajorDetail(careernetRaw)
      
      // 3. Phase 1 필드 확인
      const hasRelateSubject = !!(profile.relateSubject && profile.relateSubject.length > 0)
      const hasCareerAct = !!(profile.careerAct && profile.careerAct.length > 0)
      const hasMainSubject = !!(profile.mainSubject && profile.mainSubject.length > 0)
      const hasEnterField = !!(profile.enterField && profile.enterField.length > 0)
      const hasProperty = !!profile.property
      const hasUniversityList = !!(profile.universityList && profile.universityList.length > 0)
      const hasChartData = !!profile.chartData
      const hasGenCD = !!profile.genCD
      const hasSchClass = !!profile.schClass
      const hasLstMiddleAptd = !!profile.lstMiddleAptd
      const hasLstHighAptd = !!profile.lstHighAptd
      const hasLstVals = !!profile.lstVals
      
      // 통계 업데이트
      if (hasRelateSubject) stats.phase1Fields.relateSubject++
      if (hasCareerAct) stats.phase1Fields.careerAct++
      if (hasMainSubject) stats.phase1Fields.mainSubject++
      if (hasEnterField) stats.phase1Fields.enterField++
      if (hasProperty) stats.phase1Fields.property++
      if (hasUniversityList) stats.phase1Fields.universityList++
      if (hasChartData) stats.phase1Fields.chartData++
      if (hasGenCD) stats.phase1Fields.genCD++
      if (hasSchClass) stats.phase1Fields.schClass++
      if (hasLstMiddleAptd) stats.phase1Fields.lstMiddleAptd++
      if (hasLstHighAptd) stats.phase1Fields.lstHighAptd++
      if (hasLstVals) stats.phase1Fields.lstVals++
      
      // 필드별 상세 정보
      console.log(`   ✅ relateSubject: ${hasRelateSubject ? `${profile.relateSubject!.length}개` : '❌'}`)
      console.log(`   ✅ careerAct: ${hasCareerAct ? `${profile.careerAct!.length}개` : '❌'}`)
      console.log(`   ✅ mainSubject: ${hasMainSubject ? `${profile.mainSubject!.length}개` : '❌'}`)
      console.log(`   ✅ enterField: ${hasEnterField ? `${profile.enterField!.length}개` : '❌'}`)
      console.log(`   ✅ property: ${hasProperty ? '있음' : '❌'}`)
      console.log(`   ✅ universityList: ${hasUniversityList ? `${profile.universityList!.length}개` : '❌'}`)
      console.log(`   ✅ chartData: ${hasChartData ? '있음' : '❌'}`)
      console.log(`   ✅ genCD: ${hasGenCD ? '있음' : '❌'}`)
      console.log(`   ✅ schClass: ${hasSchClass ? '있음' : '❌'}`)
      console.log(`   ✅ lstMiddleAptd: ${hasLstMiddleAptd ? '있음' : '❌'}`)
      console.log(`   ✅ lstHighAptd: ${hasLstHighAptd ? '있음' : '❌'}`)
      console.log(`   ✅ lstVals: ${hasLstVals ? '있음' : '❌'}`)
      
      // 4. D1에 저장
      const apiData = {
        careernet: careernetRaw,
        goyong24: null,
        merged: profile,
        sources: ['CAREERNET']
      }
      
      const api_data_json = JSON.stringify(apiData)
      const api_data_hash = await generateDataHash(apiData)
      const now = Date.now()
      
      // 기존 데이터 확인
      const existing = await env.DB.prepare('SELECT id FROM majors WHERE id = ?')
        .bind(testMajor.id)
        .first<{ id: string }>()
      
      if (existing) {
        // 업데이트
        await env.DB.prepare(`
          UPDATE majors SET
            name = ?,
            careernet_id = ?,
            api_data_json = ?,
            api_data_hash = ?,
            api_last_fetched_at = ?,
            api_last_updated_at = ?
          WHERE id = ?
        `).bind(
          testMajor.name,
          testMajor.id,
          api_data_json,
          api_data_hash,
          now,
          now,
          testMajor.id
        ).run()
        
        console.log(`   💾 D1 업데이트 완료`)
      } else {
        // 신규 삽입
        await env.DB.prepare(`
          INSERT INTO majors (
            id, name, careernet_id,
            api_data_json, api_data_hash,
            api_last_fetched_at, api_last_updated_at,
            created_at, is_active
          ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, 1)
        `).bind(
          testMajor.id,
          testMajor.name,
          testMajor.id,
          api_data_json,
          api_data_hash,
          now,
          now,
          now
        ).run()
        
        console.log(`   💾 D1 삽입 완료`)
      }
      
      stats.success++
      
      // Rate limiting
      await new Promise(resolve => setTimeout(resolve, 500))
      
    } catch (error: any) {
      console.error(`   ❌ 오류: ${error.message}`)
      stats.failed++
    }
  }
  
  // 최종 통계
  console.log('\n' + '='.repeat(60))
  console.log('📊 테스트 결과 요약')
  console.log('='.repeat(60))
  console.log(`총 테스트: ${stats.total}개`)
  console.log(`✅ 성공: ${stats.success}개`)
  console.log(`❌ 실패: ${stats.failed}개`)
  
  console.log('\n📊 Phase 1 필드 수집률:')
  const total = stats.success
  console.log(`   relateSubject: ${stats.phase1Fields.relateSubject}/${total} (${Math.round(stats.phase1Fields.relateSubject / total * 100)}%)`)
  console.log(`   careerAct: ${stats.phase1Fields.careerAct}/${total} (${Math.round(stats.phase1Fields.careerAct / total * 100)}%)`)
  console.log(`   mainSubject: ${stats.phase1Fields.mainSubject}/${total} (${Math.round(stats.phase1Fields.mainSubject / total * 100)}%)`)
  console.log(`   enterField: ${stats.phase1Fields.enterField}/${total} (${Math.round(stats.phase1Fields.enterField / total * 100)}%)`)
  console.log(`   property: ${stats.phase1Fields.property}/${total} (${Math.round(stats.phase1Fields.property / total * 100)}%)`)
  console.log(`   universityList: ${stats.phase1Fields.universityList}/${total} (${Math.round(stats.phase1Fields.universityList / total * 100)}%)`)
  console.log(`   chartData: ${stats.phase1Fields.chartData}/${total} (${Math.round(stats.phase1Fields.chartData / total * 100)}%)`)
  console.log(`   genCD: ${stats.phase1Fields.genCD}/${total} (${Math.round(stats.phase1Fields.genCD / total * 100)}%)`)
  console.log(`   schClass: ${stats.phase1Fields.schClass}/${total} (${Math.round(stats.phase1Fields.schClass / total * 100)}%)`)
  console.log(`   lstMiddleAptd: ${stats.phase1Fields.lstMiddleAptd}/${total} (${Math.round(stats.phase1Fields.lstMiddleAptd / total * 100)}%)`)
  console.log(`   lstHighAptd: ${stats.phase1Fields.lstHighAptd}/${total} (${Math.round(stats.phase1Fields.lstHighAptd / total * 100)}%)`)
  console.log(`   lstVals: ${stats.phase1Fields.lstVals}/${total} (${Math.round(stats.phase1Fields.lstVals / total * 100)}%)`)
  
  console.log('\n✅ 10개 샘플 테스트 완료!')
}

// Main execution
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
      console.log('✅ Loaded environment variables from .dev.vars\n')
    } catch (e) {
      console.warn('⚠️  Could not load .dev.vars file, using system environment variables\n')
    }
    
    // Miniflare를 사용하여 로컬 D1 인스턴스 생성
    const { Miniflare } = await import('miniflare')
    
    const mf = new Miniflare({
      modules: true,
      script: '',
      d1Databases: {
        DB: 'edc21e23-c2ac-4693-bb79-389b6914e173'
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

    await testSeed10Majors(env)
    process.exit(0)
  } catch (error) {
    console.error('\n❌ Test failed:', error)
    process.exit(1)
  }
})()
