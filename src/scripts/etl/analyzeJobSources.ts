/**
 * 각 데이터 소스 조합별로 직업 목록을 찾는 스크립트
 */

import type { D1Database } from '@cloudflare/workers-types'

export async function analyzeJobSources(db: D1Database): Promise<void> {
  console.log('📊 Analyzing job data source combinations...\n')

  // 각 직업별로 어떤 소스가 있는지 확인
  const query = `
    SELECT 
      COALESCE(
        JSON_EXTRACT(normalized_payload, '$.name'),
        JSON_EXTRACT(raw_payload, '$.dJobNm'),
        JSON_EXTRACT(raw_payload, '$.jobNm')
      ) as job_name,
      GROUP_CONCAT(DISTINCT source_system ORDER BY source_system) as sources
    FROM job_sources
    WHERE job_name IS NOT NULL
    GROUP BY job_name
    HAVING sources IS NOT NULL
    ORDER BY job_name
  `

  const { results } = await db.prepare(query).all<{
    job_name: string
    sources: string
  }>()

  if (!results || results.length === 0) {
    console.log('❌ No job data found')
    return
  }

  // 소스 조합별로 분류
  const combos: Record<string, string[]> = {}
  
  for (const row of results) {
    const sources = row.sources || ''
    if (!combos[sources]) {
      combos[sources] = []
    }
    combos[sources].push(row.job_name)
  }

  // 결과 출력
  console.log('\n=== Source Combinations ===\n')
  
  const sortedCombos = Object.entries(combos).sort((a, b) => b[1].length - a[1].length)
  
  for (const [sources, jobs] of sortedCombos) {
    console.log(`📌 ${sources} (${jobs.length}개)`)
    console.log(`   ${jobs.slice(0, 5).join(', ')}${jobs.length > 5 ? '...' : ''}`)
    console.log()
  }

  // 각 케이스별로 3개씩 추출
  console.log('\n=== Test Cases ===\n')

  const cases = [
    {
      name: '1) 커리어넷 + 고용24직업 + 고용24사전',
      pattern: 'CAREERNET,WORK24_DJOB,WORK24_JOB',
      jobs: combos['CAREERNET,WORK24_DJOB,WORK24_JOB']?.slice(0, 3) || []
    },
    {
      name: '2) 커리어넷 + 고용24직업',
      pattern: 'CAREERNET,WORK24_JOB',
      jobs: combos['CAREERNET,WORK24_JOB']?.slice(0, 3) || []
    },
    {
      name: '3) 커리어넷 + 고용24사전',
      pattern: 'CAREERNET,WORK24_DJOB',
      jobs: combos['CAREERNET,WORK24_DJOB']?.slice(0, 3) || []
    },
    {
      name: '4) 고용24직업 + 고용24사전',
      pattern: 'WORK24_DJOB,WORK24_JOB',
      jobs: combos['WORK24_DJOB,WORK24_JOB']?.slice(0, 3) || []
    },
    {
      name: '5) 고용24사전만',
      pattern: 'WORK24_DJOB',
      jobs: combos['WORK24_DJOB']?.slice(0, 3) || []
    },
    {
      name: '6) 커리어넷만',
      pattern: 'CAREERNET',
      jobs: combos['CAREERNET']?.slice(0, 3) || []
    },
    {
      name: '7) 고용24직업만',
      pattern: 'WORK24_JOB',
      jobs: combos['WORK24_JOB']?.slice(0, 3) || []
    }
  ]

  const testJobs: string[] = []
  
  for (const testCase of cases) {
    console.log(`${testCase.name}`)
    if (testCase.jobs.length === 0) {
      console.log('  ❌ 데이터 없음\n')
    } else {
      console.log(`  ✅ ${testCase.jobs.join(', ')}\n`)
      testJobs.push(...testCase.jobs)
    }
  }

  console.log(`\n📝 Total test jobs: ${testJobs.length}`)
  console.log(`\nETL command:`)
  console.log(`npm run etl:merge-jobs -- ${testJobs.map(j => `"${j}"`).join(' ')}`)
}






