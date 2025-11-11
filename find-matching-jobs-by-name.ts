/**
 * 직업명 기반으로 커리어넷 + 고용24 매칭 직업 찾기
 */

import { readFileSync } from 'fs'
import { resolve } from 'path'
import { Miniflare } from 'miniflare'

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
} catch (e) {
  // 무시
}

async function findMatchingJobsByName() {
  console.log('🔍 직업명 기반 커리어넷 + 고용24 매칭 찾기\n')
  
  const mf = new Miniflare({
    modules: true,
    script: '',
    d1Databases: {
      DB: 'edc21e23-c2ac-4693-bb79-389b6914e173'
    },
    d1Persist: './.wrangler/state/v3/d1'
  })

  const db = await mf.getD1Database('DB')

  // 커리어넷 직업 목록
  const careernetJobs = await db.prepare(`
    SELECT id, name, careernet_id, api_data_json
    FROM jobs
    WHERE careernet_id IS NOT NULL
  `).all<{ id: string; name: string; careernet_id: string; api_data_json: string }>()

  // 고용24 직업 목록
  const goyong24Jobs = await db.prepare(`
    SELECT id, name, goyong24_id, api_data_json
    FROM jobs
    WHERE goyong24_id IS NOT NULL
  `).all<{ id: string; name: string; goyong24_id: string; api_data_json: string }>()

  console.log(`📊 커리어넷 직업: ${careernetJobs.results?.length || 0}개`)
  console.log(`📊 고용24 직업: ${goyong24Jobs.results?.length || 0}개\n`)

  // 직업명 정규화 함수
  const normalizeName = (name: string) => {
    return name
      .toLowerCase()
      .trim()
      .replace(/\s+/g, '')
      .replace(/[,·]/g, '')
  }

  // 커리어넷 직업명 맵 생성
  const careernetMap = new Map<string, typeof careernetJobs.results[0]>()
  for (const job of careernetJobs.results || []) {
    const normalizedName = normalizeName(job.name)
    careernetMap.set(normalizedName, job)
  }

  // 매칭되는 직업 찾기
  const matches: Array<{
    name: string
    careernet: typeof careernetJobs.results[0]
    goyong24: typeof goyong24Jobs.results[0]
  }> = []

  for (const goyongJob of goyong24Jobs.results || []) {
    const normalizedName = normalizeName(goyongJob.name)
    const careernetJob = careernetMap.get(normalizedName)
    
    if (careernetJob) {
      matches.push({
        name: careernetJob.name,
        careernet: careernetJob,
        goyong24: goyongJob
      })
    }
  }

  console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━')
  console.log(`✅ 매칭된 직업: ${matches.length}개`)
  console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n')

  if (matches.length === 0) {
    console.log('⚠️  매칭되는 직업이 없습니다.')
    return
  }

  // 처음 5개 샘플 출력
  console.log('📋 샘플 (처음 5개):\n')
  for (let i = 0; i < Math.min(5, matches.length); i++) {
    const match = matches[i]
    console.log(`${i + 1}. ${match.name}`)
    console.log(`   커리어넷 ID: ${match.careernet.careernet_id}`)
    console.log(`   고용24 ID: ${match.goyong24.goyong24_id}`)
    console.log('')
  }

  // 첫 번째 매칭 상세 분석
  const firstMatch = matches[0]
  console.log('\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━')
  console.log(`📊 상세 분석: ${firstMatch.name}`)
  console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n')

  try {
    const careernetData = JSON.parse(firstMatch.careernet.api_data_json)
    const goyong24Data = JSON.parse(firstMatch.goyong24.api_data_json)

    console.log('1️⃣ 커리어넷 데이터:')
    if (careernetData.careernet) {
      const c = careernetData.careernet
      console.log(`   - 직업명: ${c.jobNm || 'N/A'}`)
      console.log(`   - 하는 일: ${c.summary?.substring(0, 100) || 'N/A'}...`)
      console.log(`   - 직업 분류: ${c.jobclsLarge || ''} > ${c.jobclsMedium || ''} > ${c.jobclsSmall || ''}`)
      console.log(`   - 필요 능력: ${c.ability?.substring(0, 80) || 'N/A'}...`)
      console.log(`   - 전망: ${c.prospect?.substring(0, 80) || 'N/A'}...`)
    } else {
      console.log('   ❌ 데이터 없음')
    }

    console.log('\n2️⃣ 고용24 데이터:')
    if (goyong24Data.goyong24) {
      const g = goyong24Data.goyong24
      console.log(`   - 직업명: ${g.jobNm || 'N/A'}`)
      console.log(`   - 직무개요: ${g.jobDef?.substring(0, 100) || 'N/A'}...`)
      console.log(`   - 수행직무: ${g.job?.substring(0, 80) || 'N/A'}...`)
      console.log(`   - 관련학과: ${g.relatedDept?.substring(0, 80) || 'N/A'}...`)
      console.log(`   - 임금: ${g.salProspect?.jobWage || 'N/A'}`)
      console.log(`   - 고용전망: ${g.salProspect?.empProspect || 'N/A'}`)
    } else {
      console.log('   ❌ 데이터 없음')
    }

    console.log('\n3️⃣ 현재 병합 상태:')
    if (careernetData.merged) {
      console.log('   ✅ merged 데이터 존재')
    } else {
      console.log('   ❌ merged 데이터 없음')
    }

    // 전체 데이터 저장
    const fs = await import('fs')
    const outputPath = resolve(process.cwd(), `matched-job-sample-${firstMatch.name.replace(/[^a-zA-Z0-9가-힣]/g, '_')}.json`)
    fs.writeFileSync(outputPath, JSON.stringify({
      name: firstMatch.name,
      careernet: {
        id: firstMatch.careernet.id,
        careernet_id: firstMatch.careernet.careernet_id,
        data: careernetData
      },
      goyong24: {
        id: firstMatch.goyong24.id,
        goyong24_id: firstMatch.goyong24.goyong24_id,
        data: goyong24Data
      }
    }, null, 2))
    console.log(`\n💾 전체 데이터 저장: ${outputPath}`)

    // 매칭 목록 저장
    const matchListPath = resolve(process.cwd(), `matched-jobs-list.json`)
    fs.writeFileSync(matchListPath, JSON.stringify({
      totalMatches: matches.length,
      matches: matches.map(m => ({
        name: m.name,
        careernetId: m.careernet.careernet_id,
        goyong24Id: m.goyong24.goyong24_id
      }))
    }, null, 2))
    console.log(`💾 매칭 목록 저장: ${matchListPath}`)

  } catch (error) {
    console.error(`   ❌ 데이터 파싱 오류:`, error)
  }

  console.log('\n\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━')
  console.log('💡 결론')
  console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━')
  console.log(`\n✅ 직업명 기반 매칭: ${matches.length}개 직업`)
  console.log(`   → 전체 직업의 ${((matches.length / 980) * 100).toFixed(1)}%`)
  console.log(`\n📝 다음 단계:`)
  console.log(`   1. 매칭된 직업 데이터 병합 전략 수립`)
  console.log(`   2. 병합 로직 구현 (mergeJobProfiles 개선)`)
  console.log(`   3. 템플릿에서 병합 데이터 활용`)
}

findMatchingJobsByName().catch(error => {
  console.error('\n❌ 스크립트 실행 실패:', error)
  process.exit(1)
})

