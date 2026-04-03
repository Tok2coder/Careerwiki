/**
 * Browser-based E2E Test
 * Chrome을 디버깅 모드로 직접 열고, CDP로 연결해서 자동화합니다.
 * → Google OAuth 차단 우회
 *
 * ⚠️ 실행 전 Chrome을 모두 닫아주세요!
 * 실행: npx tsx scripts/browser-test.ts
 */

import { chromium, type Page, type BrowserContext } from 'playwright'
import { execSync, spawn } from 'child_process'
import { mkdtempSync } from 'fs'
import { tmpdir } from 'os'
import { join } from 'path'

const BASE_URL = 'https://careerwiki.org'
const SLOW = 400
const CDP_PORT = 9222

// ── 페르소나 ──
const PERSONA = {
  chips: {
    univ_interest: ['creating', 'media'],
    univ_priority: ['autonomy', 'creativity'],
    univ_strength: ['creative', 'communication'],
    univ_dislike: ['routine_tasks', 'bureaucracy'],
    univ_workstyle_social: ['flexible'],
    mm_sacrifice: ['low_initial_income'],
    mm_energy_drain: ['routine_drain'],
    mm_achievement: ['creative_output'],
  },
  radios: {
    mm_execution: 'explorer',
    mm_impact: 'wide_influence',
    mm_failure: 'retry_differently',
    mm_anchor: 'inner_mission',
    mm_expectation: 'selective_accept',
  },
  narrative: {
    q0: '어릴 때부터 그림 그리는 걸 좋아했고, 대학에서 시각디자인을 전공하고 있습니다. 브랜딩과 UX 디자인에 특히 관심이 많아요. 프리랜서로 소규모 브랜딩 프로젝트를 몇 건 해봤는데, 제 디자인이 실제로 사용되는 걸 볼 때 가장 행복합니다.',
    q1: '대학 공모전에서 브랜딩 프로젝트로 수상한 경험이 있고, 프리랜서로 중소기업 로고와 CI 작업을 5건 정도 했습니다. 디자인 툴은 Figma, Photoshop, Illustrator를 능숙하게 다룹니다.',
    q2: '단순 시안 수정만 반복하는 하청 작업은 정말 싫습니다. 창의적 방향 설정에 참여하고 싶고, 제 아이디어가 반영되는 환경에서 일하고 싶어요. 관료적인 조직보다는 자유로운 분위기를 선호합니다.',
    q3: '전 세계 사람들이 매일 사용하는 서비스의 디자인을 만들고 싶습니다. 제 디자인이 누군가의 일상을 더 편하고 아름답게 만드는 것이 궁극적인 목표입니다.',
  },
  roundAnswers: [
    { keywords: ['디자인', '포트폴리오', '작품', '경험', '활동', '집중'], answer: '포트폴리오를 계속 쌓고 있고, 특히 UX 리서치와 사용자 테스트에 관심이 생겼습니다. 실제 사용자 경험을 개선하는 디자인을 하고 싶어요. 대학 공모전 수상과 프리랜서 경험이 큰 자신감이 됐습니다.' },
    { keywords: ['싫', '피하', '답답', '스트레스', '소모', '에너지'], answer: '단순 시안 수정만 반복하는 건 정말 싫습니다. 창의적 방향 설정에 참여하고 싶고, 의미 없는 반복 작업은 에너지를 빼앗아가요. 규칙에 얽매인 환경보다 자유롭게 실험할 수 있는 환경이 좋습니다.' },
    { keywords: ['현실', '제약', '조건', '연봉', '급여', '포기', '감수'], answer: '초봉이 낮아도 성장할 수 있는 환경이라면 괜찮습니다. 포트폴리오를 쌓을 수 있는 프로젝트가 더 중요하고, 창의적 자유는 절대 포기할 수 없습니다.' },
    { keywords: ['동기', '원동력', '보람', '행복', '살아'], answer: '제 디자인이 실제 브랜드로 세상에 나가고, 사람들이 좋아할 때 가장 큰 에너지를 얻습니다. 작품이 실제로 쓰이는 걸 볼 때 살아있음을 느낍니다.' },
    { keywords: ['꿈', '목표', '미래', '비전', '계획', '되고 싶'], answer: '아트 디렉터가 되고 싶어요. 브랜딩 전체를 기획하고 방향을 설정하는 역할이 꿈입니다. 다양한 프로젝트 경험을 쌓아가고 있습니다.' },
    { keywords: ['강점', '잘하', '능력', '자신'], answer: '시각적 감각이 좋고 Figma, Illustrator 등 디자인 도구를 능숙하게 다룹니다. 클라이언트 소통도 잘하는 편이에요.' },
    { keywords: ['가치', '원칙', '중요', '절대'], answer: '디자인의 본질은 소통이라고 생각합니다. 예쁘기만 한 것보다 사용자에게 진짜 도움이 되는 디자인이 좋은 디자인입니다.' },
    { keywords: ['사람', '협업', '팀', '함께'], answer: '아이디어를 자유롭게 나눌 수 있는 팀이 좋습니다. 피드백을 주고받으면서 결과물이 나아지는 과정이 좋아요.' },
    { keywords: ['행동', '시작', '작은', '당장'], answer: '매일 30분씩 새로운 디자인 트렌드를 공부하고 개인 프로젝트를 진행하고 있어요. 작은 것부터 시작하는 게 중요하다고 생각합니다.' },
    { keywords: ['성장', '변화', '발전', '기회'], answer: '무급이라도 좋은 프로젝트에 참여하고 싶어요. 성장할 수 있는 경험이라면 뭐든 도전하고 싶습니다.' },
  ],
  defaultAnswer: '디자인과 창의적 작업에 관심이 많고, UX/UI와 브랜딩 분야에서 경력을 쌓고 싶습니다. 자유로운 환경에서 실력을 발휘하고 싶어요. 초봉이 낮아도 성장 가능성이 있다면 괜찮습니다.',
}

function log(msg: string) {
  const t = new Date().toLocaleTimeString('ko-KR')
  console.log(`[${t}] ${msg}`)
}

function findAnswer(questionText: string): string {
  const q = questionText.toLowerCase()
  for (const item of PERSONA.roundAnswers) {
    if (item.keywords.some(k => q.includes(k))) return item.answer
  }
  return PERSONA.defaultAnswer
}

async function main() {
  log('🚀 브라우저 테스트 시작 — 창의형 디자인 학생 페르소나')
  log('⚠️  Chrome이 열려있다면 먼저 닫아주세요!')

  // 별도 프로필로 Chrome 실행 (기존 Chrome은 그대로!)
  const tempDir = mkdtempSync(join(tmpdir(), 'cw-test-'))
  log(`🌐 Chrome 시작 (임시 프로필: ${tempDir}, 포트: ${CDP_PORT})...`)
  log('   ℹ️  기존 Chrome은 그대로 열려있어도 됩니다.')

  execSync(`powershell -Command "Start-Process 'C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe' -ArgumentList '--remote-debugging-port=${CDP_PORT}','--user-data-dir=${tempDir}','--no-first-run','--no-default-browser-check','${BASE_URL}/analyzer/job'"`, { stdio: 'ignore' })

  // Chrome 시작 대기
  log('⏳ Chrome 시작 대기...')
  await new Promise(r => setTimeout(r, 5000))

  // CDP로 연결
  log('🔗 CDP 연결 중...')
  let browser
  for (let i = 0; i < 15; i++) {
    try {
      browser = await chromium.connectOverCDP(`http://localhost:${CDP_PORT}`)
      break
    } catch {
      await new Promise(r => setTimeout(r, 1000))
    }
  }

  if (!browser) {
    log('❌ Chrome에 연결할 수 없습니다.')
    process.exit(1)
  }

  log('✅ Chrome 연결 성공!')

  const contexts = browser.contexts()
  const context = contexts[0]
  if (!context) {
    log('❌ 브라우저 컨텍스트를 찾을 수 없습니다.')
    process.exit(1)
  }

  // analyzer/job 탭 찾기
  let page: Page | null = null
  for (const p of context.pages()) {
    const url = p.url()
    if (url.includes('analyzer') || url.includes('careerwiki') || url.includes('auth')) {
      page = p
      break
    }
  }

  if (!page) {
    page = context.pages()[0] || await context.newPage()
    await page.goto(`${BASE_URL}/analyzer/job`, { waitUntil: 'networkidle' })
  }

  await page.waitForTimeout(3000)

  // 현재 URL 확인
  log(`📍 현재 URL: ${page.url()}`)

  // 로그인 확인 — /analyzer/job에 role-options 버튼이 보일 때까지 대기
  const hasRoleOptions = await page.$('#role-options button').catch(() => null)
  if (!hasRoleOptions) {
    log('🔐 로그인이 필요합니다. 브라우저에서 Google 로그인해주세요!')
    log('   로그인 완료 후 /analyzer/job 페이지에서 역할 선택 버튼이 보이면 자동 계속합니다.')
    log('   ⏳ 최대 5분 대기...')

    // 5분간 2초마다 체크
    let found = false
    for (let i = 0; i < 150; i++) {
      await page.waitForTimeout(2000)
      try {
        const url = page.url()
        if (url.includes('/analyzer/job')) {
          const btn = await page.$('#role-options button')
          if (btn) { found = true; break }
        }
      } catch { /* ignore */ }
    }

    if (!found) {
      log('❌ 로그인 대기 시간 초과. 브라우저에서 직접 진행해주세요.')
      await new Promise(r => setTimeout(r, 600000))
      process.exit(1)
    }
    log('✅ 로그인 확인!')
    await page.waitForTimeout(2000)
  }

  log('📄 직업 추천 페이지 로드 완료\n')

  // ═══════════════════════════════════════
  // Step 1-1: Career State (5축)
  // ═══════════════════════════════════════
  log('━━━ Step 1-1: 커리어 상태 ━━━')

  await safeClick(page, '#role-options button[data-value="student"]', '역할: 학생')
  await page.waitForTimeout(SLOW)

  await page.waitForSelector('#career-stage-options button', { timeout: 5000 }).catch(() => {})
  await safeClick(page, '#career-stage-options button[data-value="explore"]', '경력: 탐색중')
  await page.waitForTimeout(SLOW)

  await page.waitForSelector('#transition-status-options button', { timeout: 5000 }).catch(() => {})
  await safeClick(page, '#transition-status-options button[data-value="find_first_job"]', '목표: 첫 직장')
  await page.waitForTimeout(SLOW)

  await page.waitForSelector('#skill-level-options button', { timeout: 5000 }).catch(() => {})
  await safeClick(page, '#skill-level-options button[data-value="intermediate"]', '숙련도: 중급')
  await page.waitForTimeout(SLOW)

  log('  ➡️ 다음')
  await page.click('#profile1-next-btn')
  await page.waitForTimeout(2000)

  // ═══════════════════════════════════════
  // Step 1-2: Mini Module
  // ═══════════════════════════════════════
  log('\n━━━ Step 1-2: 미니 모듈 ━━━')

  for (const [qid, values] of Object.entries(PERSONA.chips)) {
    for (const val of values) {
      log(`  🔘 ${qid}: ${val}`)
      await page.evaluate(({ qid, val }: { qid: string; val: string }) => {
        const w = window as any
        if (typeof w.toggleIntegratedChip === 'function') {
          w.toggleIntegratedChip(qid, val)
        }
      }, { qid, val })
      await page.waitForTimeout(200)
    }
  }

  for (const [qid, val] of Object.entries(PERSONA.radios)) {
    log(`  🔘 ${qid}: ${val}`)
    await page.evaluate(({ qid, val }: { qid: string; val: string }) => {
      const w = window as any
      if (typeof w.selectIntegratedRadio === 'function') {
        w.selectIntegratedRadio(qid, val)
      }
    }, { qid, val })
    await page.waitForTimeout(200)
  }

  await page.evaluate(() => window.scrollTo(0, document.body.scrollHeight))
  await page.waitForTimeout(500)

  // 분석하기 버튼 활성화 확인 & 클릭
  log('  🔬 분석하기')
  const step1Btn = await page.$('#step1-next-btn')
  if (step1Btn) {
    const disabled = await step1Btn.getAttribute('disabled')
    if (disabled !== null) {
      log('  ⚠️ 분석하기 버튼이 비활성화 — 필수 항목 확인 중...')
      // 누락된 필수 항목 강제 설정
      await page.evaluate(() => {
        const w = window as any
        if (typeof w.checkStep1Completion === 'function') w.checkStep1Completion()
      })
      await page.waitForTimeout(500)
    }
    await step1Btn.click()
  }
  await page.waitForTimeout(4000)

  // ═══════════════════════════════════════
  // Step 2: Narrative
  // ═══════════════════════════════════════
  log('\n━━━ Step 2: 서술형 답변 ━━━')

  const narrativeEntries = [
    ['narrative_q0', PERSONA.narrative.q0],
    ['narrative_q1', PERSONA.narrative.q1],
    ['narrative_q2', PERSONA.narrative.q2],
    ['narrative_q3', PERSONA.narrative.q3],
  ]

  for (const [id, text] of narrativeEntries) {
    const el = await page.$(`#${id}`)
    if (el && await el.isVisible()) {
      log(`  ✏️ ${id}`)
      await el.scrollIntoViewIfNeeded()
      await el.fill(text)
      await page.waitForTimeout(300)
    }
  }

  await page.evaluate(() => window.scrollTo(0, document.body.scrollHeight))
  await page.waitForTimeout(500)

  log('  📤 서술형 제출')
  await page.click('#analyze-btn')
  await page.waitForTimeout(5000)

  // ═══════════════════════════════════════
  // Rounds 1-3
  // ═══════════════════════════════════════
  for (let round = 1; round <= 3; round++) {
    log(`\n━━━ 라운드 ${round}/3 ━━━`)
    await page.waitForTimeout(3000)

    // 라운드 질문 로드 대기
    await page.waitForSelector('#step2 textarea, #step2 select', { timeout: 30000 }).catch(() => {
      log(`  ⚠️ 라운드 ${round} 질문 로드 대기 중...`)
    })
    await page.waitForTimeout(1000)

    // 보이는 textarea에 답변
    const textareas = await page.$$('#step2 textarea')
    for (let i = 0; i < textareas.length; i++) {
      const ta = textareas[i]
      try {
        if (await ta.isVisible()) {
          const qText = await page.evaluate((el: HTMLElement) => {
            let node: HTMLElement | null = el
            for (let j = 0; j < 5; j++) {
              node = node?.parentElement || null
              if (!node) break
              const label = node.querySelector('label, h4, h3, p.font-medium, .font-semibold')
              if (label?.textContent) return label.textContent
            }
            return ''
          }, ta)

          const answer = findAnswer(qText)
          log(`  ✏️ Q${i + 1}: "${qText.substring(0, 50).trim()}..." `)
          await ta.scrollIntoViewIfNeeded()
          await ta.fill(answer)
          await page.waitForTimeout(300)
        }
      } catch { /* skip hidden */ }
    }

    // select 처리
    const selects = await page.$$('#step2 select')
    for (const sel of selects) {
      try {
        if (await sel.isVisible()) {
          const options = await sel.$$('option')
          if (options.length > 1) {
            const val = await options[1].getAttribute('value')
            if (val) {
              log(`  📋 Select: ${val}`)
              await sel.selectOption(val)
            }
          }
        }
      } catch { /* skip */ }
    }

    await page.evaluate(() => window.scrollTo(0, document.body.scrollHeight))
    await page.waitForTimeout(500)

    const btnText = await page.$eval('#analyze-btn', (el: HTMLElement) => el.textContent?.trim()).catch(() => '제출')
    log(`  📤 "${btnText}" 클릭`)
    await page.click('#analyze-btn')

    // 마지막 라운드면 로딩이 길어짐
    if (round === 3) {
      await page.waitForTimeout(5000)
    } else {
      await page.waitForTimeout(3000)
    }
  }

  // ═══════════════════════════════════════
  // 결과 대기
  // ═══════════════════════════════════════
  log('\n━━━ 🏆 추천 결과 대기 (최대 3분) ━━━')
  log('⏳ 프로그레스 바가 표시됩니다...')

  try {
    await page.waitForSelector('#step3:not(.hidden)', { timeout: 200000 })
    log('🎉 추천 결과가 표시되었습니다!')
    await page.waitForTimeout(5000)

    // 스크린샷
    await page.screenshot({ path: 'docs/browser-test-result.png', fullPage: true })
    log('📸 스크린샷: docs/browser-test-result.png')

    // 결과 텍스트 추출 시도
    const resultSummary = await page.evaluate(() => {
      const text = document.querySelector('#step3')?.textContent || ''
      return text.replace(/\s+/g, ' ').substring(0, 1000)
    })
    log(`\n📊 결과 요약: ${resultSummary.substring(0, 300)}...`)

  } catch {
    log('⚠️ 시간 초과. 브라우저에서 직접 확인하세요.')
  }

  log('\n✅ 테스트 완료! 브라우저는 계속 열려있습니다.')
  log('   이 터미널에서 Ctrl+C로 종료하세요.')

  // 대기 (브라우저는 유저가 확인)
  await new Promise(r => setTimeout(r, 600000))
}

async function safeClick(page: Page, selector: string, desc: string) {
  try {
    log(`  🔘 ${desc}`)
    const el = await page.$(selector)
    if (el) {
      await el.scrollIntoViewIfNeeded()
      await el.click()
    } else {
      log(`  ⚠️ ${desc}: 셀렉터 못 찾음 (${selector})`)
    }
  } catch (e: any) {
    log(`  ⚠️ ${desc}: ${e.message?.substring(0, 80)}`)
  }
}

main().catch(e => {
  console.error('❌ 에러:', e.message)
  process.exit(1)
})
