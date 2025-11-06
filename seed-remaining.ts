/**
 * 나머지 전공 시딩 스크립트
 * 이미 저장된 전공은 제외하고 나머지만 수집
 */

import type { D1Database } from '@cloudflare/workers-types'
import { searchMajors as searchCareerNetMajors } from './src/api/careernetAPI'
import { fetchGoyong24MajorList } from './src/api/goyong24API'
import { getUnifiedMajorDetail } from './src/services/profileDataService'

interface Env {
  DB: D1Database
  CAREER_NET_API_KEY?: string
  GOYONG24_MAJOR_API_KEY?: string
  GOYONG24_JOB_API_KEY?: string
}

async function generateDataHash(data: any): Promise<string> {
  const normalized = JSON.stringify(data, Object.keys(data).sort())
  const encoder = new TextEncoder()
  const dataBuffer = encoder.encode(normalized)
  const hashBuffer = await crypto.subtle.digest('SHA-256', dataBuffer)
  const hashArray = Array.from(new Uint8Array(hashBuffer))
  return hashArray.map(b => b.toString(16).padStart(2, '0')).join('')
}

function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms))
}

async function seedRemaining(env: Env) {
  console.log('🌱 나머지 전공 시딩 시작...\n')
  
  const startTime = Date.now()
  let processed = 0
  let inserted = 0
  let updated = 0
  let skipped = 0
  let errors = 0
  
  // 1. 이미 저장된 전공 ID 목록 가져오기
  console.log('📋 이미 저장된 전공 목록 확인 중...')
  const existingIds = new Set<string>()
  
  const existingResult = await env.DB.prepare('SELECT id FROM majors').all<{ id: string }>()
  for (const row of existingResult.results || []) {
    existingIds.add(row.id)
  }
  
  console.log(`✅ 이미 저장됨: ${existingIds.size}개\n`)
  
  // 2. CareerNet에서 전체 학과 목록 수집
  console.log('📋 CareerNet 학과 목록 수집 중...')
  const careernetMajors: Array<{ id: string; name: string }> = []
  
  let page = 1
  while (true) {
    const majors = await searchCareerNetMajors({ thisPage: page, perPage: 100 }, env)
    if (majors.length === 0) break
    
    for (const major of majors) {
      if (!major.majorSeq) continue
      if (!existingIds.has(major.majorSeq)) {
        careernetMajors.push({
          id: major.majorSeq,
          name: major.major || major.summary || ''
        })
      }
    }
    
    console.log(`  페이지 ${page}: ${majors.length}개 수집 (신규: ${careernetMajors.length})`)
    if (majors.length < 100) break
    page++
    await sleep(300)
  }
  
  console.log(`✅ CareerNet 신규: ${careernetMajors.length}개\n`)
  
  // 3. Goyong24에서 전체 학과 목록 수집
  console.log('📋 Goyong24 학과 목록 수집 중...')
  const goyong24Majors: Array<{ id: string; name: string; majorGb: '1' | '2'; departmentId: string; majorId: string }> = []
  
  const keywords = ['과', '학', '부', '공', '전공']
  const seenIds = new Set<string>()
  
  for (const keyword of keywords) {
    try {
      const response = await fetchGoyong24MajorList({ keyword, srchType: 'K' }, env)
      
      for (const major of response.items) {
        if (!major.empCurtState2Id || !major.knowDtlSchDptNm) continue
        
        const uniqueKey = `${major.knowDtlSchDptNm}_${major.empCurtState2Id}`
        if (seenIds.has(uniqueKey)) continue
        seenIds.add(uniqueKey)
        
        const id = `G${major.empCurtState2Id}_${major.knowDtlSchDptNm}`
        if (!existingIds.has(id)) {
          goyong24Majors.push({
            id,
            name: major.knowDtlSchDptNm,
            majorGb: (major.majorGb as '1' | '2') || '1',
            departmentId: major.empCurtState1Id,
            majorId: major.empCurtState2Id
          })
        }
      }
      
      console.log(`  키워드 "${keyword}": ${response.items.length}개 발견 (신규: ${goyong24Majors.length})`)
      await sleep(300)
    } catch (error: any) {
      console.warn(`  ⚠️  키워드 "${keyword}" 실패: ${error.message}`)
    }
  }
  
  console.log(`✅ Goyong24 신규: ${goyong24Majors.length}개\n`)
  
  // 4. 전체 신규 전공 목록
  const allNewMajors = [...careernetMajors, ...goyong24Majors]
  const total = allNewMajors.length
  
  console.log(`📊 총 ${total}개 신규 전공 발견`)
  console.log(`   - CareerNet: ${careernetMajors.length}개`)
  console.log(`   - Goyong24: ${goyong24Majors.length}개\n`)
  
  if (total === 0) {
    console.log('✅ 모든 전공이 이미 저장되어 있습니다!')
    return
  }
  
  console.log('🚀 신규 전공 수집 시작...\n')
  
  // 5. 각 전공 수집
  for (const major of allNewMajors) {
    try {
      const request = major.id.startsWith('G')
        ? {
            id: major.id,
            goyong24Params: {
              majorGb: (major as any).majorGb,
              departmentId: (major as any).departmentId,
              majorId: (major as any).majorId
            }
          }
        : { id: major.id, careernetId: major.id }
      
      const result = await getUnifiedMajorDetail(request, env)
      
      if (!result.profile) {
        throw new Error('전공 상세 데이터를 가져올 수 없습니다')
      }
      
      const apiData = {
        careernet: result.partials?.CAREERNET || null,
        goyong24: result.partials?.GOYONG24 || null,
        merged: result.profile,
        sources: result.sources
      }
      
      const api_data_json = JSON.stringify(apiData)
      const api_data_hash = await generateDataHash(apiData)
      const now = Date.now()
      
      // D1에 저장
      await env.DB.prepare(`
        INSERT INTO majors (
          id, name, careernet_id, goyong24_id,
          api_data_json, api_data_hash,
          api_last_fetched_at, api_last_updated_at,
          created_at, is_active
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 1)
      `).bind(
        major.id,
        major.name,
        major.id.startsWith('G') ? null : major.id,
        major.id.startsWith('G') ? major.id : null,
        api_data_json,
        api_data_hash,
        now,
        now,
        now
      ).run()
      
      inserted++
      
    } catch (error: any) {
      errors++
      console.error(`❌ 오류 (${major.id} - ${major.name}): ${error.message}`)
    }
    
    processed++
    
    // 진행 상황 출력 (매 50개마다)
    if (processed % 50 === 0 || processed === total) {
      const elapsed = Date.now() - startTime
      const elapsedMin = Math.floor(elapsed / 60000)
      const elapsedSec = Math.floor((elapsed % 60000) / 1000)
      const percentage = Math.round((processed / total) * 100)
      
      console.log(`📊 진행: ${processed}/${total} (${percentage}%) | ✅ ${inserted} | ❌ ${errors} | ⏱️  ${elapsedMin}분 ${elapsedSec}초`)
    }
    
    await sleep(500)
  }
  
  // 최종 결과
  const elapsed = Date.now() - startTime
  const elapsedMin = Math.floor(elapsed / 60000)
  const elapsedSec = Math.floor((elapsed % 60000) / 1000)
  
  console.log('\n' + '='.repeat(60))
  console.log('✅ 시딩 완료!')
  console.log('='.repeat(60))
  console.log(`총 처리: ${processed}/${total}`)
  console.log(`✅ 삽입: ${inserted}`)
  console.log(`❌ 오류: ${errors}`)
  console.log(`⏱️  총 소요 시간: ${elapsedMin}분 ${elapsedSec}초`)
}

// Main execution
;(async () => {
  try {
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
      console.warn('⚠️  Could not load .dev.vars file\n')
    }
    
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

    await seedRemaining(env)
    process.exit(0)
  } catch (error) {
    console.error('\n❌ Seeding failed:', error)
    process.exit(1)
  }
})()
