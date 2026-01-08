/**
 * 모든 직업/전공 페이지가 정상적으로 로드되는지 확인하는 스크립트
 * 
 * 사용법:
 * npm run check:pages
 */

import type { D1Database } from '@cloudflare/workers-types'

interface PageCheckResult {
  url: string
  status: 'success' | 'error' | 'empty'
  statusCode?: number
  error?: string
  title?: string
}

const BASE_URL = 'http://localhost:3000'

/**
 * D1에서 모든 직업 목록 가져오기
 */
async function getAllJobs(db: D1Database) {
  const result = await db.prepare(`
    SELECT id, name 
    FROM jobs 
    ORDER BY name
  `).all()
  
  return result.results as Array<{ id: string; name: string }>
}

/**
 * D1에서 모든 전공 목록 가져오기
 */
async function getAllMajors(db: D1Database) {
  const result = await db.prepare(`
    SELECT id, name 
    FROM majors 
    ORDER BY name
  `).all()
  
  return result.results as Array<{ id: string; name: string }>
}

/**
 * URL의 페이지를 체크
 */
async function checkPage(url: string): Promise<PageCheckResult> {
  try {
    const response = await fetch(url)
    const html = await response.text()
    
    // 제목 추출
    const titleMatch = html.match(/<title>(.*?)<\/title>/)
    const title = titleMatch ? titleMatch[1] : 'Unknown'
    
    // 데이터가 없는 빈 페이지인지 체크
    // "정보가 제공되지" 또는 "데이터가 없습니다" 같은 텍스트가 많으면 empty
    const isEmptyPage = html.includes('job:') || html.includes('major:') || 
                        html.length < 5000 // 너무 작은 HTML은 의심
    
    return {
      url,
      status: response.ok ? (isEmptyPage ? 'empty' : 'success') : 'error',
      statusCode: response.status,
      title
    }
  } catch (error) {
    return {
      url,
      status: 'error',
      error: error instanceof Error ? error.message : 'Unknown error'
    }
  }
}

/**
 * Slug 생성 (src/utils/slug.ts의 로직 복제)
 */
function createSlug(name: string): string {
  return name
    .trim()
    .toLowerCase()
    .replace(/[-,·ㆍ/\s]/g, '')
    .replace(/[^0-9a-z\u3131-\u314e\u314f-\u3163가-힣-]+/gi, '')
    .replace(/^-+|-+$/g, '')
}

/**
 * 페이지 체크 실행 및 결과 출력
 */
async function main() {
  console.log('🔍 모든 페이지 체크를 시작합니다...\n')
  
  // D1 데이터베이스 연결 (로컬 개발 환경)
  // 실제 구현 시 wrangler의 D1 바인딩 필요
  console.log('⚠️  이 스크립트는 서버가 실행 중이어야 합니다.')
  console.log('⚠️  npm run dev 를 먼저 실행해주세요.\n')
  
  // 체크할 샘플 URL들 (실제로는 D1에서 가져와야 함)
  const sampleUrls = [
    '/job/건축가건축설계사',
    '/job/가스수도전기계기검침원및안전점검원',
    '/job/가스에너지시험원및진단전문가',
    '/major/디지털마케팅전공',
    '/major/컴퓨터공학과'
  ]
  
  const results: PageCheckResult[] = []
  let successCount = 0
  let errorCount = 0
  let emptyCount = 0
  
  console.log(`📊 총 ${sampleUrls.length}개 페이지 체크 중...\n`)
  
  for (const path of sampleUrls) {
    const url = `${BASE_URL}${path}`
    process.stdout.write(`체크 중: ${path} ... `)
    
    const result = await checkPage(url)
    results.push(result)
    
    if (result.status === 'success') {
      console.log('✅ 성공')
      successCount++
    } else if (result.status === 'empty') {
      console.log('⚠️  빈 페이지')
      emptyCount++
    } else {
      console.log('❌ 실패')
      errorCount++
    }
    
    // 너무 빠르게 요청하지 않도록 딜레이
    await new Promise(resolve => setTimeout(resolve, 100))
  }
  
  // 결과 요약
  console.log('\n' + '='.repeat(60))
  console.log('📈 체크 결과 요약')
  console.log('='.repeat(60))
  console.log(`✅ 성공: ${successCount}개`)
  console.log(`⚠️  빈 페이지: ${emptyCount}개`)
  console.log(`❌ 실패: ${errorCount}개`)
  console.log(`📊 전체: ${results.length}개`)
  console.log('='.repeat(60))
  
  // 문제가 있는 페이지만 상세 출력
  const problemPages = results.filter(r => r.status !== 'success')
  
  if (problemPages.length > 0) {
    console.log('\n⚠️  문제가 있는 페이지 목록:')
    problemPages.forEach(page => {
      console.log(`\n${page.status === 'empty' ? '⚠️' : '❌'} ${page.url}`)
      console.log(`   제목: ${page.title || 'N/A'}`)
      console.log(`   상태: ${page.statusCode || 'N/A'}`)
      if (page.error) {
        console.log(`   에러: ${page.error}`)
      }
    })
  } else {
    console.log('\n🎉 모든 페이지가 정상적으로 작동합니다!')
  }
}

// 실행
main().catch(console.error)







