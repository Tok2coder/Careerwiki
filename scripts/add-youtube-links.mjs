/**
 * add-youtube-links.mjs
 *
 * youtubeLinks가 비어있는 직업들에 YouTube 영상 2~3개를 자동 추가합니다.
 *
 * 사전 준비:
 *   1. Google Cloud Console에서 YouTube Data API v3 활성화
 *   2. API 키 발급 (무료, 일일 10,000 units 쿼터)
 *   3. YOUTUBE_API_KEY 환경변수 설정
 *
 * 사용법:
 *   YOUTUBE_API_KEY=AIza... node scripts/add-youtube-links.mjs --pilot
 *   YOUTUBE_API_KEY=AIza... node scripts/add-youtube-links.mjs --batch --start=0 --limit=50
 *   YOUTUBE_API_KEY=AIza... node scripts/add-youtube-links.mjs --all
 *   node scripts/add-youtube-links.mjs --list   # DB에서 대상 목록만 추출
 */

import { execSync } from 'child_process'
import { writeFileSync, readFileSync, existsSync } from 'fs'
import { join, dirname } from 'path'
import { fileURLToPath } from 'url'

const __dirname = dirname(fileURLToPath(import.meta.url))
const ROOT = join(__dirname, '..')

// ─── 설정 ────────────────────────────────────────────────────────────────────
const YOUTUBE_API_KEY = process.env.YOUTUBE_API_KEY
const CAREERWIKI_API = 'https://careerwiki.org'
const ADMIN_SECRET = 'careerwiki-admin-2026'
const PROGRESS_FILE = join(ROOT, 'scripts', 'youtube-progress.json')
const JOBS_CACHE_FILE = join(ROOT, 'scripts', 'youtube-jobs-cache.json')

// 검색 옵션
const MAX_RESULTS = 3          // 직업당 최대 영상 수
const SEARCH_DELAY_MS = 500    // API 호출 간격 (rate limit 방지)
const API_UPDATE_DELAY_MS = 300 // CareerWiki API 업데이트 간격

// ─── 인자 파싱 ─────────────────────────────────────────────────────────────
const args = process.argv.slice(2)
const isPilot = args.includes('--pilot')
const isAll = args.includes('--all')
const isList = args.includes('--list')
const isBatch = args.includes('--batch')
const startIdx = parseInt(args.find(a => a.startsWith('--start='))?.split('=')[1] ?? '0')
const limitCount = parseInt(args.find(a => a.startsWith('--limit='))?.split('=')[1] ?? (isPilot ? '10' : '50'))

// ─── 유틸리티 ──────────────────────────────────────────────────────────────
function sleep(ms) {
  return new Promise(r => setTimeout(r, ms))
}

function log(msg) {
  const ts = new Date().toISOString().slice(11, 19)
  console.log(`[${ts}] ${msg}`)
}

function saveProgress(data) {
  writeFileSync(PROGRESS_FILE, JSON.stringify(data, null, 2))
}

function loadProgress() {
  if (!existsSync(PROGRESS_FILE)) return { processed: [], failed: [], lastRun: null }
  return JSON.parse(readFileSync(PROGRESS_FILE, 'utf8'))
}

// ─── DB에서 대상 직업 목록 추출 ────────────────────────────────────────────
function queryJobsFromDB() {
  log('DB에서 youtubeLinks 비어있는 직업 목록 조회 중...')

  const sql = `SELECT id, name, slug FROM jobs WHERE is_active = 1 AND LENGTH(user_contributed_json) > 500 AND (user_contributed_json NOT LIKE '%youtubeLinks%' OR user_contributed_json LIKE '%"youtubeLinks":[]%' OR user_contributed_json LIKE '%"youtubeLinks": []%') ORDER BY name`

  try {
    const result = execSync(
      `npx wrangler d1 execute careerwiki-kr --remote --command "${sql.replace(/"/g, '\\"')}" 2>&1`,
      { cwd: ROOT, encoding: 'utf8', maxBuffer: 10 * 1024 * 1024 }
    )

    const jsonMatch = result.match(/"results":\s*(\[[\s\S]*?\])\s*,\s*"success"/)
    if (!jsonMatch) throw new Error('DB 쿼리 결과 파싱 실패')

    const jobs = JSON.parse(jsonMatch[1])
    log(`총 ${jobs.length}개 직업 발견`)
    return jobs
  } catch (err) {
    log(`DB 쿼리 실패: ${err.message}`)
    throw err
  }
}

// ─── YouTube Data API 검색 ─────────────────────────────────────────────────
async function searchYouTube(jobName, maxResults = MAX_RESULTS) {
  if (!YOUTUBE_API_KEY) {
    throw new Error('YOUTUBE_API_KEY 환경변수가 설정되지 않았습니다.')
  }

  // 검색 쿼리 생성 (한국어 우선, 직업 소개/진로 관련)
  const queries = [
    `${jobName} 직업소개`,
    `${jobName} 하는일`,
    `${jobName} 진로`,
  ]

  const videos = []
  const seenIds = new Set()

  for (const query of queries) {
    if (videos.length >= maxResults) break

    const url = new URL('https://www.googleapis.com/youtube/v3/search')
    url.searchParams.set('part', 'snippet')
    url.searchParams.set('q', query)
    url.searchParams.set('maxResults', String(maxResults))
    url.searchParams.set('type', 'video')
    url.searchParams.set('relevanceLanguage', 'ko')
    url.searchParams.set('regionCode', 'KR')
    url.searchParams.set('key', YOUTUBE_API_KEY)

    try {
      const res = await fetch(url.toString())
      if (!res.ok) {
        const err = await res.json()
        throw new Error(`YouTube API 오류: ${err.error?.message || res.status}`)
      }

      const data = await res.json()

      for (const item of data.items || []) {
        if (videos.length >= maxResults) break
        const videoId = item.id?.videoId
        if (!videoId || seenIds.has(videoId)) continue

        const title = item.snippet?.title || ''
        const channelTitle = item.snippet?.channelTitle || ''

        // 관련성 필터: 스팸/무관/채용광고 영상 제외
        const titleLower = title.toLowerCase()
        const isRelevant =
          !titleLower.includes('asmr') &&
          !titleLower.includes('mukbang') &&
          !titleLower.includes('먹방') &&
          !title.includes('직업소개소') &&
          !title.includes('채용합니다') &&
          !title.includes('모집합니다') &&
          !title.includes('구인') &&
          !title.includes('당일지급') &&
          !title.includes('일용직') &&
          title.length > 5

        if (!isRelevant) continue

        seenIds.add(videoId)
        videos.push({
          url: `https://www.youtube.com/watch?v=${videoId}`,
          title: title,
          channelTitle: channelTitle
        })
      }

      await sleep(SEARCH_DELAY_MS)
    } catch (err) {
      log(`  YouTube 검색 실패 (${query}): ${err.message}`)
      if (err.message.includes('quotaExceeded')) {
        throw new Error('YouTube API 쿼터 초과. 내일 다시 시도하세요.')
      }
    }
  }

  return videos
}

// ─── CareerWiki API로 업데이트 ─────────────────────────────────────────────
async function updateJobYoutubeLinks(jobId, jobName, videos) {
  if (videos.length === 0) {
    log(`  → 영상 없음, 스킵`)
    return { success: false, reason: 'no_videos' }
  }

  // youtubeLinks 형식으로 변환
  const youtubeLinks = videos.map(v => ({
    url: v.url,
    title: v.title
  }))

  const body = {
    fields: {
      youtubeLinks: youtubeLinks
    },
    changeSummary: `YouTube 영상 ${youtubeLinks.length}개 자동 추가 (검색: ${jobName} 직업소개)`
  }

  try {
    const res = await fetch(`${CAREERWIKI_API}/api/job/${jobId}/edit`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-Admin-Secret': ADMIN_SECRET
      },
      body: JSON.stringify(body)
    })

    const data = await res.json()

    if (data.success) {
      return { success: true, count: youtubeLinks.length }
    } else {
      return { success: false, reason: data.error || 'unknown' }
    }
  } catch (err) {
    return { success: false, reason: err.message }
  }
}

// ─── 파일럿 / 배치 실행 ────────────────────────────────────────────────────
async function run() {
  // 목록 조회만
  if (isList) {
    const jobs = queryJobsFromDB()
    const cacheData = { jobs, fetchedAt: new Date().toISOString(), total: jobs.length }
    writeFileSync(JOBS_CACHE_FILE, JSON.stringify(cacheData, null, 2))
    log(`직업 목록을 ${JOBS_CACHE_FILE}에 저장했습니다.`)
    console.table(jobs.slice(0, 20))
    if (jobs.length > 20) log(`... 외 ${jobs.length - 20}개`)
    return
  }

  if (!YOUTUBE_API_KEY && !isList) {
    console.error(`
❌ YOUTUBE_API_KEY가 없습니다.

YouTube Data API v3 키 발급 방법:
1. https://console.cloud.google.com/ 접속
2. "새 프로젝트" 생성
3. "API 및 서비스" → "라이브러리" → "YouTube Data API v3" 검색 후 활성화
4. "사용자 인증 정보" → "API 키 만들기"
5. 아래 명령어로 실행:

  YOUTUBE_API_KEY=AIza... node scripts/add-youtube-links.mjs --pilot

일일 무료 쿼터: 10,000 units (검색 1회 = 100 units → 하루 최대 100개 직업 처리)
`)
    process.exit(1)
  }

  // 직업 목록 로드 (캐시 또는 DB 쿼리)
  let jobs
  if (existsSync(JOBS_CACHE_FILE)) {
    const cache = JSON.parse(readFileSync(JOBS_CACHE_FILE, 'utf8'))
    const cacheAge = Date.now() - new Date(cache.fetchedAt).getTime()
    if (cacheAge < 3600000) { // 1시간 이내 캐시 재사용
      jobs = cache.jobs
      log(`캐시에서 ${jobs.length}개 직업 로드 (${Math.round(cacheAge/60000)}분 전)`)
    } else {
      jobs = queryJobsFromDB()
    }
  } else {
    jobs = queryJobsFromDB()
  }

  if (jobs.length === 0) {
    log('처리할 직업이 없습니다.')
    return
  }

  // 진행 상황 로드
  const progress = loadProgress()
  const alreadyProcessed = new Set(progress.processed.map(p => p.id))

  // 대상 범위 결정
  const pending = jobs.filter(j => !alreadyProcessed.has(j.id))
  const targetJobs = isPilot
    ? pending.slice(0, 10)
    : isBatch
    ? pending.slice(startIdx, startIdx + limitCount)
    : pending  // --all

  log(`─────────────────────────────────────`)
  log(`모드: ${isPilot ? '파일럿(10개)' : isBatch ? `배치(${startIdx}~${startIdx+limitCount})` : '전체'}`)
  log(`처리 예정: ${targetJobs.length}개 직업`)
  log(`이미 처리됨: ${alreadyProcessed.size}개`)
  log(`예상 YouTube API 사용량: ${targetJobs.length * 100} units`)
  log(`─────────────────────────────────────`)

  const results = []
  let successCount = 0
  let failCount = 0

  for (let i = 0; i < targetJobs.length; i++) {
    const job = targetJobs[i]
    log(`[${i+1}/${targetJobs.length}] ${job.name} (${job.id})`)

    try {
      // YouTube 검색
      const videos = await searchYouTube(job.name)
      log(`  → ${videos.length}개 영상 찾음: ${videos.map(v => `"${v.title.slice(0,30)}"`).join(', ')}`)

      if (videos.length === 0) {
        log(`  ⚠ 검색 결과 없음`)
        failCount++
        results.push({ id: job.id, name: job.name, status: 'no_results', videos: [] })
        progress.failed.push({ id: job.id, name: job.name, reason: 'no_youtube_results' })
        saveProgress(progress)
        continue
      }

      // API 업데이트
      await sleep(API_UPDATE_DELAY_MS)
      const updateResult = await updateJobYoutubeLinks(job.id, job.name, videos)

      if (updateResult.success) {
        log(`  ✓ 업데이트 완료 (${updateResult.count}개 영상)`)
        successCount++
        results.push({ id: job.id, name: job.name, status: 'success', videos })
        progress.processed.push({
          id: job.id,
          name: job.name,
          processedAt: new Date().toISOString(),
          videoCount: updateResult.count,
          videos: videos.map(v => ({ url: v.url, title: v.title }))
        })
      } else {
        log(`  ✗ 업데이트 실패: ${updateResult.reason}`)
        failCount++
        results.push({ id: job.id, name: job.name, status: 'api_error', reason: updateResult.reason, videos })
        progress.failed.push({ id: job.id, name: job.name, reason: updateResult.reason })
      }

      saveProgress(progress)

    } catch (err) {
      if (err.message.includes('쿼터 초과')) {
        log(`⛔ YouTube API 쿼터 초과! 중단합니다. (${i}/${targetJobs.length} 완료)`)
        break
      }
      log(`  ✗ 오류: ${err.message}`)
      failCount++
      results.push({ id: job.id, name: job.name, status: 'error', reason: err.message })
    }
  }

  // 결과 보고
  console.log('\n' + '═'.repeat(50))
  console.log('📊 실행 결과 요약')
  console.log('═'.repeat(50))
  console.log(`✅ 성공: ${successCount}개`)
  console.log(`❌ 실패: ${failCount}개`)
  console.log(`📁 진행 파일: ${PROGRESS_FILE}`)

  if (isPilot && successCount > 0) {
    console.log('\n🎬 추가된 YouTube 영상 샘플:')
    results
      .filter(r => r.status === 'success')
      .slice(0, 5)
      .forEach(r => {
        console.log(`\n  직업: ${r.name}`)
        r.videos.forEach(v => console.log(`    - ${v.title}`))
        console.log(`    ${r.videos.map(v => v.url).join('\n    ')}`)
      })

    console.log('\n▶ 파일럿 성공! 전체 배치 실행:')
    console.log(`  YOUTUBE_API_KEY=${YOUTUBE_API_KEY} node scripts/add-youtube-links.mjs --batch --start=0 --limit=50`)
    console.log(`  YOUTUBE_API_KEY=${YOUTUBE_API_KEY} node scripts/add-youtube-links.mjs --batch --start=50 --limit=50`)
    console.log(`  (일일 쿼터 = 100개/일, 483개 = 약 5일 소요)`)
  }

  // 결과 파일 저장
  const resultFile = join(ROOT, 'scripts', `youtube-results-${Date.now()}.json`)
  writeFileSync(resultFile, JSON.stringify({ results, summary: { successCount, failCount } }, null, 2))
  log(`결과 파일 저장: ${resultFile}`)
}

run().catch(err => {
  console.error('Fatal error:', err)
  process.exit(1)
})
