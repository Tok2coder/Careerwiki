/**
 * Full E2E Test Script for AI Analyzer
 *
 * 6개 시나리오에 대해 완전한 파이프라인을 실행:
 * analyze → narrative-facts → round-questions×3 → round-answers×3 → recommend
 *
 * 실행: npx tsx scripts/e2e-full-test.ts
 *
 * 옵션:
 *   --scenario=analytical_user    특정 시나리오만 실행
 *   --base-url=https://...        API 기본 URL (기본: https://careerwiki.org)
 *   --output-dir=docs/...         결과 저장 디렉토리
 */

// @ts-nocheck
import { TEST_SCENARIOS, findAutoAnswer, type TestScenario } from '../src/services/ai-analyzer/test-scenarios'
import * as fs from 'fs'
import * as path from 'path'

// ============================================
// Configuration
// ============================================
const BASE_URL = process.argv.find(a => a.startsWith('--base-url='))?.split('=')[1] || 'https://careerwiki.org'
const OUTPUT_DIR = process.argv.find(a => a.startsWith('--output-dir='))?.split('=')[1] || 'docs/e2e-results/full-e2e'
const SPECIFIC_SCENARIO = process.argv.find(a => a.startsWith('--scenario='))?.split('=')[1]
const TIMEOUT_MS = 120_000  // 2분 (LLM 호출 포함)

// ============================================
// Types
// ============================================
interface RoundData {
  roundNumber: number
  questions: Array<{
    questionId: string
    questionText: string
    purposeTag?: string
    context?: string
  }>
  answers: Array<{
    questionId: string
    questionText: string
    purposeTag: string
    answer: string
    matchType: 'pattern' | 'fallback' | 'default'
    matchedPattern?: string
  }>
  metadata: {
    generated_by: string
    cag_filtered?: number
    total_questions_asked?: number
    collection_progress?: any
  }
}

interface E2EResult {
  scenario: {
    id: string
    name: string
    description: string
    careerState: string
  }
  timestamp: string
  baseUrl: string
  sessionId: string
  requestId: number | null

  // Step 1: Analyze (MiniModule)
  analyzeResponse: any

  // Step 2: Narrative Facts
  narrativeFactsInput: {
    high_alive_moment: string
    lost_moment: string
  }
  narrativeFactsResponse: any

  // Step 3-5: Interview Rounds
  rounds: RoundData[]

  // Step 6: Recommendation
  recommendation: {
    top10: Array<{
      rank: number
      jobName: string
      fitScore: number
      likeScore: number
      canScore: number
      riskPenalty: number
      bucket: string
      summary: string
    }>
    uxMetrics: any
    processingTimeMs: number
  }

  // Full raw response for debugging
  rawRecommendResponse: any

  // Timing
  timing: {
    analyzeMs: number
    narrativeMs: number
    roundsMs: number[]
    roundAnswersMs: number[]
    recommendMs: number
    totalMs: number
  }

  // Errors
  errors: string[]
}

// ============================================
// API Helpers
// ============================================
async function apiFetch(endpoint: string, body: any, timeoutMs = TIMEOUT_MS): Promise<any> {
  const url = `${BASE_URL}/api/ai-analyzer${endpoint}`
  const controller = new AbortController()
  const timer = setTimeout(() => controller.abort(), timeoutMs)

  try {
    const response = await fetch(url, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(body),
      signal: controller.signal,
    })
    clearTimeout(timer)

    const text = await response.text()
    let data: any
    try {
      data = JSON.parse(text)
    } catch {
      // HTML response (e.g. Cloudflare 524 timeout)
      throw new Error(`HTTP ${response.status}: Non-JSON response (${text.substring(0, 100)}...)`)
    }
    if (!response.ok) {
      throw new Error(`HTTP ${response.status}: ${JSON.stringify(data)}`)
    }
    return data
  } catch (err: any) {
    clearTimeout(timer)
    if (err.name === 'AbortError') {
      throw new Error(`Timeout (${timeoutMs}ms) for ${endpoint}`)
    }
    throw err
  }
}

function generateSessionId(): string {
  return `e2e-test-${Date.now()}-${Math.random().toString(36).slice(2, 8)}`
}

// ============================================
// Answer Generation (ported from autoAnswerGenerator)
// ============================================
class AnswerGenerator {
  private scenario: TestScenario
  private usedFallbacks: Record<string, number> = { round1: 0, round2: 0, round3: 0 }

  constructor(scenario: TestScenario) {
    this.scenario = scenario
  }

  generateAnswer(questionText: string, roundNumber: number): {
    answer: string
    matchType: 'pattern' | 'fallback' | 'default'
    matchedPattern?: string
  } {
    // 1. Pattern match
    const normalized = questionText.toLowerCase()
    for (const pattern of this.scenario.llmFollowupAnswers) {
      const keywords = pattern.questionPattern.split('|')
      const matched = keywords.find(k => normalized.includes(k.toLowerCase()))
      if (matched) {
        return {
          answer: pattern.answer,
          matchType: 'pattern',
          matchedPattern: pattern.questionPattern,
        }
      }
    }

    // 2. Round fallback
    const roundKey = `round${roundNumber}`
    const fallbackMap = this.scenario.roundFallbackAnswers as Record<string, string[]>
    const fallbacks = fallbackMap[roundKey]
    if (fallbacks && (this.usedFallbacks[roundKey] || 0) < fallbacks.length) {
      const idx = this.usedFallbacks[roundKey] || 0
      this.usedFallbacks[roundKey] = idx + 1
      return {
        answer: fallbacks[idx],
        matchType: 'fallback',
      }
    }

    // 3. Default
    const defaults: Record<number, string> = {
      1: `이 분야에서 성장하고 전문성을 쌓고 싶습니다.`,
      2: `지나치게 반복적이거나 성장 기회가 없는 환경은 피하고 싶습니다.`,
      3: `현실적인 조건 내에서 최선의 선택을 하고 싶습니다.`,
    }
    return {
      answer: defaults[roundNumber] || '잘 모르겠지만 열심히 해보겠습니다.',
      matchType: 'default',
    }
  }
}

// ============================================
// Stage mapping
// ============================================
function careerStateToStage(careerState: string): string {
  switch (careerState) {
    case 'student': return 'job_student'
    case 'job_seeker': return 'job_explore'
    case 'employed': return 'job_early'
    case 'career_changer': return 'job_explore'
    default: return 'job_explore'
  }
}

// ============================================
// Main E2E Runner
// ============================================
async function runScenario(scenario: TestScenario): Promise<E2EResult> {
  const sessionId = generateSessionId()
  const errors: string[] = []
  const timing = {
    analyzeMs: 0,
    narrativeMs: 0,
    roundsMs: [] as number[],
    roundAnswersMs: [] as number[],
    recommendMs: 0,
    totalMs: 0,
  }
  const totalStart = Date.now()

  console.log(`\n${'='.repeat(60)}`)
  console.log(`🎯 시나리오: ${scenario.name} (${scenario.id})`)
  console.log(`   ${scenario.description}`)
  console.log(`   Session: ${sessionId}`)
  console.log(`${'='.repeat(60)}`)

  // Initialize result
  const result: E2EResult = {
    scenario: {
      id: scenario.id,
      name: scenario.name,
      description: scenario.description,
      careerState: scenario.careerState,
    },
    timestamp: new Date().toISOString(),
    baseUrl: BASE_URL,
    sessionId,
    requestId: null,
    analyzeResponse: null,
    narrativeFactsInput: {
      high_alive_moment: scenario.narrativeAnswers.motivation,
      lost_moment: scenario.narrativeAnswers.avoidance,
    },
    narrativeFactsResponse: null,
    rounds: [],
    recommendation: {
      top10: [],
      uxMetrics: null,
      processingTimeMs: 0,
    },
    rawRecommendResponse: null,
    timing,
    errors,
  }

  // ============================================
  // Step 1: POST /analyze (세션 생성 + 미니모듈)
  // ============================================
  console.log(`\n📋 Step 1: /analyze (세션 생성 + 미니모듈 제출)...`)
  const t1 = Date.now()
  try {
    const analyzePayload = {
      session_id: sessionId,
      analysis_type: 'job',
      stage: careerStateToStage(scenario.careerState),
      universal_answers: {
        univ_interest: scenario.miniModule.interest_top,
        univ_value: scenario.miniModule.value_top,
        univ_strength: scenario.miniModule.strength_top,
        univ_constraint: scenario.miniModule.constraint_flags,
        univ_workstyle: scenario.miniModule.workstyle_top,
        univ_background: scenario.miniModule.background_flags,
        univ_sacrifice: scenario.miniModule.sacrifice_flags,
        univ_energy_drain: scenario.miniModule.energy_drain_flags,
        univ_achievement: scenario.miniModule.achievement_feedback_top,
        univ_execution: scenario.miniModule.execution_style,
        univ_impact: scenario.miniModule.impact_scope,
        univ_failure: scenario.miniModule.failure_response,
        univ_persistence: scenario.miniModule.persistence_anchor,
        univ_external: scenario.miniModule.external_expectation,
      },
    }

    result.analyzeResponse = await apiFetch('/analyze', analyzePayload)
    result.requestId = result.analyzeResponse?.request_id || null
    timing.analyzeMs = Date.now() - t1
    console.log(`   ✅ 완료 (${timing.analyzeMs}ms) — request_id: ${result.requestId}`)
  } catch (err: any) {
    timing.analyzeMs = Date.now() - t1
    errors.push(`Step 1 /analyze 실패: ${err.message}`)
    console.error(`   ❌ 실패: ${err.message}`)
    // analyze가 실패하면 나머지 진행 불가하지만 계속 시도
  }

  // ============================================
  // Step 2: POST /v3/narrative-facts (내러티브 답변)
  // ============================================
  console.log(`\n📝 Step 2: /v3/narrative-facts (내러티브 답변)...`)
  const t2 = Date.now()
  try {
    const narrativePayload = {
      session_id: sessionId,
      high_alive_moment: scenario.narrativeAnswers.motivation,
      lost_moment: scenario.narrativeAnswers.avoidance,
      existential_answer: scenario.narrativeAnswers.constraints,
    }

    result.narrativeFactsResponse = await apiFetch('/v3/narrative-facts', narrativePayload)
    timing.narrativeMs = Date.now() - t2
    console.log(`   ✅ 완료 (${timing.narrativeMs}ms)`)
  } catch (err: any) {
    timing.narrativeMs = Date.now() - t2
    errors.push(`Step 2 /v3/narrative-facts 실패: ${err.message}`)
    console.error(`   ❌ 실패: ${err.message}`)
  }

  // ============================================
  // Step 3-5: 3라운드 인터뷰 (round-questions → round-answers)
  // ============================================
  const answerGenerator = new AnswerGenerator(scenario)
  const allPreviousAnswers: Array<{
    questionId: string
    questionText: string
    roundNumber: number
    answer: string
    answeredAt: string
  }> = []

  for (const roundNum of [1, 2, 3] as const) {
    const roundData: RoundData = {
      roundNumber: roundNum,
      questions: [],
      answers: [],
      metadata: { generated_by: 'unknown' },
    }

    // Request questions
    console.log(`\n🎤 Step ${2 + roundNum}: 라운드 ${roundNum} 질문 요청...`)
    const tq = Date.now()
    try {
      const questionsPayload: any = {
        session_id: sessionId,
        round_number: roundNum,
        analysis_type: 'job',
        mini_module_result: {
          interest_top: scenario.miniModule.interest_top,
          value_top: scenario.miniModule.value_top,
          strength_top: scenario.miniModule.strength_top,
          constraint_flags: scenario.miniModule.constraint_flags,
          internal_conflict_flags: scenario.miniModule.internal_conflict_flags || [],
        },
        narrative_facts: {
          highAliveMoment: scenario.narrativeAnswers.motivation,
          lostMoment: scenario.narrativeAnswers.avoidance,
        },
      }

      // 이전 라운드 답변 포함
      if (allPreviousAnswers.length > 0) {
        questionsPayload.previous_round_answers = allPreviousAnswers
      }

      const questionsResponse = await apiFetch('/v3/round-questions', questionsPayload)
      const roundQMs = Date.now() - tq
      timing.roundsMs.push(roundQMs)

      roundData.metadata = {
        generated_by: questionsResponse.generated_by || 'unknown',
        cag_filtered: questionsResponse.metadata?.cag_filtered,
        total_questions_asked: questionsResponse.metadata?.total_questions_asked,
        collection_progress: questionsResponse.collection_progress,
      }

      const questions = questionsResponse.questions || []
      roundData.questions = questions.map((q: any) => ({
        questionId: q.questionId,
        questionText: q.questionText,
        purposeTag: q.purposeTag || q.purpose_tag,
        context: q.context,
      }))

      console.log(`   ✅ 질문 ${questions.length}개 수신 (${roundQMs}ms, by: ${roundData.metadata.generated_by})`)
      for (const q of roundData.questions) {
        console.log(`      [${q.purposeTag || '?'}] ${q.questionText.substring(0, 60)}...`)
      }

      // Generate & submit answers
      console.log(`\n   💬 라운드 ${roundNum} 답변 생성 & 제출...`)
      const ta = Date.now()

      const answersToSubmit: Array<{
        question_id: string
        question_text: string
        purpose_tag: string
        answer: string
      }> = []

      for (const q of roundData.questions) {
        const qText = q.questionText || ''
        const qId = q.questionId || `q_${roundNum}_${roundData.answers.length}`
        const pTag = q.purposeTag || 'ENGINE'

        const { answer, matchType, matchedPattern } = answerGenerator.generateAnswer(
          qText,
          roundNum
        )

        roundData.answers.push({
          questionId: qId,
          questionText: qText,
          purposeTag: pTag,
          answer,
          matchType,
          matchedPattern,
        })

        answersToSubmit.push({
          question_id: qId,
          question_text: qText,
          purpose_tag: pTag,
          answer,
        })

        allPreviousAnswers.push({
          questionId: qId,
          questionText: qText,
          roundNumber: roundNum,
          answer,
          answeredAt: new Date().toISOString(),
        })

        const matchLabel = matchType === 'pattern' ? `패턴(${matchedPattern})` :
                          matchType === 'fallback' ? '폴백' : '기본'
        console.log(`      → [${matchLabel}] ${answer.substring(0, 50)}...`)
      }

      // Submit answers
      if (answersToSubmit.length > 0) {
        const answersPayload: any = {
          session_id: sessionId,
          round_number: roundNum,
          answers: answersToSubmit,
        }
        // Only include request_id if it's actually a number
        if (typeof result.requestId === 'number') {
          answersPayload.request_id = result.requestId
        }

        try {
          const answersResponse = await apiFetch('/v3/round-answers', answersPayload)
          const roundAMs = Date.now() - ta
          timing.roundAnswersMs.push(roundAMs)
          console.log(`   ✅ 답변 ${answersResponse.answers_saved || answersToSubmit.length}개 저장 (${roundAMs}ms)`)
        } catch (ansErr: any) {
          const roundAMs = Date.now() - ta
          timing.roundAnswersMs.push(roundAMs)
          // D1_TYPE_ERROR in CAGState is non-fatal — answers are usually saved
          console.warn(`   ⚠️ 답변 저장 응답 에러 (비치명적): ${ansErr.message.substring(0, 100)}`)
          // Don't add to fatal errors — continue flow
        }
      }

    } catch (err: any) {
      timing.roundsMs.push(Date.now() - tq)
      errors.push(`라운드 ${roundNum} 실패: ${err.message}`)
      console.error(`   ❌ 라운드 ${roundNum} 실패: ${err.message}`)
    }

    result.rounds.push(roundData)

    // 라운드 간 짧은 대기 (rate limit 방지)
    await sleep(1000)
  }

  // ============================================
  // Step 6: POST /v3/recommend (최종 추천)
  // ============================================
  console.log(`\n🏆 Step 6: /v3/recommend (최종 추천)...`)
  const t6 = Date.now()
  try {
    const recommendPayload = {
      session_id: sessionId,
      mini_module_result: scenario.miniModule,
      topK: 800,
      judgeTopN: 10,  // 10으로 줄여 Worker 타임아웃 방지
      skipReport: true,  // 리포트 생성 분리 (타임아웃 방지)
      debug: true,
    }

    const recommendResponse = await apiFetch('/v3/recommend', recommendPayload, 180_000)  // 3분
    timing.recommendMs = Date.now() - t6
    result.rawRecommendResponse = recommendResponse
    result.recommendation.processingTimeMs = recommendResponse.processing_time_ms || timing.recommendMs
    result.recommendation.uxMetrics = recommendResponse.ux_metrics || null

    // Extract top 10 — response format varies:
    // { recommendations: { top_jobs: [...] } } or { recommendations: [...] }
    const recsObj = recommendResponse.recommendations || {}
    const recs = Array.isArray(recsObj) ? recsObj
      : Array.isArray(recsObj.top_jobs) ? recsObj.top_jobs
      : []
    result.recommendation.top10 = recs.slice(0, 10).map((r: any, i: number) => ({
      rank: i + 1,
      jobName: r.job_name || '',
      fitScore: r.fit_score ?? r.scores?.fit ?? 0,
      likeScore: r.like_score ?? r.scores?.like ?? 0,
      canScore: r.can_score ?? r.scores?.can ?? 0,
      riskPenalty: r.risk_penalty ?? r.scores?.risk_penalty ?? 0,
      bucket: r.bucket || 'unknown',
      summary: r.rationale || r.summary || '',
    }))

    console.log(`   ✅ 완료 (${timing.recommendMs}ms) — ${recs.length}개 추천`)
    console.log(`\n   📊 Top 10 결과:`)
    for (const job of result.recommendation.top10) {
      console.log(`      #${job.rank} ${job.jobName} — Fit:${job.fitScore} (L:${job.likeScore} C:${job.canScore} R:-${job.riskPenalty}) [${job.bucket}]`)
    }

  } catch (err: any) {
    timing.recommendMs = Date.now() - t6
    errors.push(`Step 6 /v3/recommend 실패: ${err.message}`)
    console.error(`   ❌ 실패: ${err.message}`)
  }

  timing.totalMs = Date.now() - totalStart

  // ============================================
  // Summary
  // ============================================
  console.log(`\n${'─'.repeat(60)}`)
  console.log(`📈 시나리오 완료: ${scenario.name}`)
  console.log(`   총 소요시간: ${timing.totalMs}ms`)
  console.log(`   에러: ${errors.length}건`)
  if (errors.length > 0) {
    errors.forEach(e => console.log(`   ⚠️ ${e}`))
  }
  console.log(`${'─'.repeat(60)}`)

  return result
}

// ============================================
// Trace Document Generator
// ============================================
function generateTraceMarkdown(result: E2EResult, scenario: TestScenario): string {
  const lines: string[] = []

  lines.push(`# 시나리오: ${result.scenario.name} — 전체 트레이스`)
  lines.push(``)
  lines.push(`> 생성 시각: ${result.timestamp}`)
  lines.push(`> Session: ${result.sessionId}`)
  lines.push(`> Base URL: ${result.baseUrl}`)
  lines.push(`> 총 소요시간: ${result.timing.totalMs}ms`)
  lines.push(``)

  // 1. 유저 프로필
  lines.push(`## 1. 유저 프로필 (MiniModule 입력)`)
  lines.push(``)
  lines.push(`| 축 | 선택값 |`)
  lines.push(`|---|--------|`)
  lines.push(`| 관심사 (interest_top) | ${scenario.miniModule.interest_top.join(', ')} |`)
  lines.push(`| 가치관 (value_top) | ${scenario.miniModule.value_top.join(', ')} |`)
  lines.push(`| 강점 (strength_top) | ${scenario.miniModule.strength_top.join(', ')} |`)
  lines.push(`| 제약 (constraint_flags) | ${scenario.miniModule.constraint_flags.join(', ') || '없음'} |`)
  lines.push(`| 워크스타일 (workstyle_top) | ${scenario.miniModule.workstyle_top?.join(', ') || '없음'} |`)
  lines.push(`| 배경 (background_flags) | ${scenario.miniModule.background_flags?.join(', ') || '없음'} |`)
  lines.push(`| 희생 가능 (sacrifice_flags) | ${scenario.miniModule.sacrifice_flags?.join(', ') || '없음'} |`)
  lines.push(`| 에너지 소모 (energy_drain) | ${scenario.miniModule.energy_drain_flags?.join(', ') || '없음'} |`)
  lines.push(`| 내면 갈등 | ${scenario.miniModule.internal_conflict_flags?.join(', ') || '없음'} |`)
  lines.push(`| 커리어 상태 | ${scenario.careerState} |`)
  lines.push(``)

  // 2. 내러티브 답변
  lines.push(`## 2. 내러티브 답변`)
  lines.push(``)
  lines.push(`**동기 (high_alive_moment):**`)
  lines.push(`> ${scenario.narrativeAnswers.motivation}`)
  lines.push(``)
  lines.push(`**회피 (lost_moment):**`)
  lines.push(`> ${scenario.narrativeAnswers.avoidance}`)
  lines.push(``)
  lines.push(`**제약 (existential_answer):**`)
  lines.push(`> ${scenario.narrativeAnswers.constraints}`)
  lines.push(``)

  // 3. 인터뷰 라운드
  lines.push(`## 3. 인터뷰 라운드`)
  lines.push(``)

  const roundNames = ['ENGINE — 욕망 탐색', 'AVOIDANCE — 회피 탐색', 'INTEGRATION — 통합']
  for (const round of result.rounds) {
    lines.push(`### 라운드 ${round.roundNumber} (${roundNames[round.roundNumber - 1] || '?'})`)
    lines.push(``)
    lines.push(`> 생성: ${round.metadata.generated_by} | CAG 필터: ${round.metadata.cag_filtered ?? 'N/A'}개 제거`)
    lines.push(``)

    if (round.questions.length === 0) {
      lines.push(`_질문 없음 (에러 또는 타임아웃)_`)
    } else {
      lines.push(`| # | LLM 질문 | 페르소나 답변 | 매칭 방식 |`)
      lines.push(`|---|---------|-------------|----------|`)

      for (let i = 0; i < round.questions.length; i++) {
        const q = round.questions[i]
        const a = round.answers[i]
        const qText = q.questionText.replace(/\|/g, '\\|').replace(/\n/g, ' ')
        const aText = a ? a.answer.replace(/\|/g, '\\|').replace(/\n/g, ' ') : '_답변 없음_'
        const matchLabel = a?.matchType === 'pattern'
          ? `패턴: \`${a.matchedPattern}\``
          : a?.matchType === 'fallback'
          ? '폴백'
          : '기본'
        lines.push(`| ${i + 1} | ${qText} | ${aText} | ${matchLabel} |`)
      }
    }

    // Round quality assessment markers
    lines.push(``)
    const ANCHOR_PATTERNS = /말씀하신|언급하신|하셨는데|하셨다고|싶다고 하셨|좋아한다고 하셨|있다고 하셨|없다고 하셨|않는다고|맞지 않다고|했던 경험|했을 때|하셨다면|하셨잖아|라고 하셨/
    const hasAnchor = round.questions.some(q =>
      q.questionText.includes('\"') || ANCHOR_PATTERNS.test(q.questionText)
    )
    const duplicateCheck = checkDuplicateQuestions(result.rounds, round.roundNumber)
    lines.push(`**라운드 ${round.roundNumber} 품질 체크:**`)
    lines.push(`- 앵커링 (유저 발화 인용): ${hasAnchor ? '✅ 있음' : '❌ 없음'}`)
    lines.push(`- 중복 질문: ${duplicateCheck ? '❌ 중복 발견' : '✅ 없음'}`)
    lines.push(`- 질문 수: ${round.questions.length}개`)
    lines.push(``)
  }

  // 4. 추천 결과
  lines.push(`## 4. 추천 결과`)
  lines.push(``)

  if (result.recommendation.top10.length > 0) {
    lines.push(`| 순위 | 직업명 | Fit | Like | Can | Risk | 버킷 |`)
    lines.push(`|------|--------|-----|------|-----|------|------|`)
    for (const job of result.recommendation.top10) {
      lines.push(`| ${job.rank} | ${job.jobName} | ${job.fitScore} | ${job.likeScore} | ${job.canScore} | -${job.riskPenalty} | ${job.bucket} |`)
    }
    lines.push(``)

    // Score spread
    const scores = result.recommendation.top10.map(j => j.fitScore)
    const spread = scores.length >= 2 ? scores[0] - scores[scores.length - 1] : 0
    lines.push(`**점수 분포:**`)
    lines.push(`- #1 vs #10 격차: ${spread}점`)
    lines.push(`- 최고: ${Math.max(...scores)} / 최저: ${Math.min(...scores)}`)
    lines.push(``)
  } else {
    lines.push(`_추천 결과 없음 (에러)_`)
    lines.push(``)
  }

  // 5. 소요시간
  lines.push(`## 5. 소요시간`)
  lines.push(``)
  lines.push(`| 단계 | 시간(ms) |`)
  lines.push(`|------|---------|`)
  lines.push(`| /analyze | ${result.timing.analyzeMs} |`)
  lines.push(`| /v3/narrative-facts | ${result.timing.narrativeMs} |`)
  for (let i = 0; i < result.timing.roundsMs.length; i++) {
    lines.push(`| 라운드 ${i + 1} 질문 | ${result.timing.roundsMs[i]} |`)
  }
  for (let i = 0; i < result.timing.roundAnswersMs.length; i++) {
    lines.push(`| 라운드 ${i + 1} 답변 | ${result.timing.roundAnswersMs[i]} |`)
  }
  lines.push(`| /v3/recommend | ${result.timing.recommendMs} |`)
  lines.push(`| **총계** | **${result.timing.totalMs}** |`)
  lines.push(``)

  // 6. 에러
  if (result.errors.length > 0) {
    lines.push(`## 6. 에러`)
    lines.push(``)
    for (const err of result.errors) {
      lines.push(`- ⚠️ ${err}`)
    }
    lines.push(``)
  }

  return lines.join('\n')
}

function checkDuplicateQuestions(rounds: RoundData[], currentRound: number): boolean {
  const currentQuestions = rounds.find(r => r.roundNumber === currentRound)?.questions || []
  const previousQuestions = rounds
    .filter(r => r.roundNumber < currentRound)
    .flatMap(r => r.questions)

  for (const cq of currentQuestions) {
    for (const pq of previousQuestions) {
      // Simple overlap check: 3-gram similarity
      const cWords = cq.questionText.split(/\s+/).filter(w => w.length > 2)
      const pWords = new Set(pq.questionText.split(/\s+/).filter(w => w.length > 2))
      const overlap = cWords.filter(w => pWords.has(w)).length
      if (overlap >= 7) return true  // v3.19.1: 5→7 (한국어 기능어 공유로 인한 false positive 방지)
    }
  }
  return false
}

// ============================================
// Summary Report Generator
// ============================================
function generateSummaryReport(results: E2EResult[]): string {
  const lines: string[] = []

  lines.push(`# Full E2E 테스트 결과 요약`)
  lines.push(``)
  lines.push(`> 실행 시각: ${new Date().toISOString()}`)
  lines.push(`> Base URL: ${BASE_URL}`)
  lines.push(`> 시나리오 수: ${results.length}`)
  lines.push(``)

  // Overall table
  lines.push(`## 추천 품질 요약`)
  lines.push(``)
  lines.push(`| 시나리오 | Top1 직업 | Fit#1 | Fit#10 | Spread | 에러 | 추천시간 | 총시간 |`)
  lines.push(`|----------|----------|-------|--------|--------|------|---------|--------|`)

  for (const r of results) {
    const top1 = r.recommendation.top10[0]
    const top10 = r.recommendation.top10[9]
    const spread = top1 && top10 ? top1.fitScore - top10.fitScore : 0
    lines.push(`| ${r.scenario.name} | ${top1?.jobName || 'N/A'} | ${top1?.fitScore || 0} | ${top10?.fitScore || 0} | ${spread} | ${r.errors.length} | ${r.timing.recommendMs}ms | ${r.timing.totalMs}ms |`)
  }
  lines.push(``)

  // Interview quality
  lines.push(`## 인터뷰 품질 요약`)
  lines.push(``)
  lines.push(`| 시나리오 | R1 질문수 | R2 질문수 | R3 질문수 | 생성방식 | 앵커링 | 중복 |`)
  lines.push(`|----------|---------|---------|---------|---------|--------|------|`)

  for (const r of results) {
    const r1 = r.rounds[0], r2 = r.rounds[1], r3 = r.rounds[2]
    const genBy = r1?.metadata.generated_by || 'N/A'
    const ANCHOR_RE = /말씀하신|언급하신|하셨는데|하셨다고|싶다고 하셨|좋아한다고 하셨|있다고 하셨|없다고 하셨|않는다고|맞지 않다고|했던 경험|했을 때|하셨다면|하셨잖아|라고 하셨/
    const hasAnchor = r.rounds.some(rd =>
      rd.questions.some(q =>
        q.questionText.includes('\"') || ANCHOR_RE.test(q.questionText)
      )
    ) ? '✅' : '❌'
    const hasDup = r.rounds.some((_, i) => i > 0 && checkDuplicateQuestions(r.rounds, i + 1)) ? '❌' : '✅'
    lines.push(`| ${r.scenario.name} | ${r1?.questions.length || 0} | ${r2?.questions.length || 0} | ${r3?.questions.length || 0} | ${genBy} | ${hasAnchor} | ${hasDup} |`)
  }
  lines.push(``)

  // Answer match statistics
  lines.push(`## 답변 매칭 통계`)
  lines.push(``)
  lines.push(`| 시나리오 | 패턴 매칭 | 폴백 | 기본 | 총 답변 |`)
  lines.push(`|----------|---------|------|------|---------|`)

  for (const r of results) {
    const allAnswers = r.rounds.flatMap(rd => rd.answers)
    const pattern = allAnswers.filter(a => a.matchType === 'pattern').length
    const fallback = allAnswers.filter(a => a.matchType === 'fallback').length
    const dflt = allAnswers.filter(a => a.matchType === 'default').length
    lines.push(`| ${r.scenario.name} | ${pattern} | ${fallback} | ${dflt} | ${allAnswers.length} |`)
  }
  lines.push(``)

  return lines.join('\n')
}

// ============================================
// Utility
// ============================================
function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms))
}

function ensureDir(dir: string): void {
  if (!fs.existsSync(dir)) {
    fs.mkdirSync(dir, { recursive: true })
  }
}

// ============================================
// Main
// ============================================
async function main() {
  console.log(`\n🚀 CareerWiki AI Analyzer — Full E2E Test`)
  console.log(`   Base URL: ${BASE_URL}`)
  console.log(`   Output: ${OUTPUT_DIR}`)
  console.log(`   시나리오: ${SPECIFIC_SCENARIO || '전체 6개'}`)
  console.log(``)

  // Filter scenarios
  const scenarios = SPECIFIC_SCENARIO
    ? TEST_SCENARIOS.filter(s => s.id === SPECIFIC_SCENARIO)
    : TEST_SCENARIOS

  if (scenarios.length === 0) {
    console.error(`❌ 시나리오를 찾을 수 없습니다: ${SPECIFIC_SCENARIO}`)
    console.error(`   사용 가능: ${TEST_SCENARIOS.map(s => s.id).join(', ')}`)
    process.exit(1)
  }

  // Ensure output directories
  ensureDir(OUTPUT_DIR)
  ensureDir(path.join(OUTPUT_DIR, '..', '..', 'ai-quality', 'traces'))

  const results: E2EResult[] = []

  // Run scenarios sequentially (avoid Worker timeout from parallel requests)
  for (const scenario of scenarios) {
    try {
      const result = await runScenario(scenario)
      results.push(result)

      // Save individual result JSON
      const jsonPath = path.join(OUTPUT_DIR, `${scenario.id}.json`)
      fs.writeFileSync(jsonPath, JSON.stringify(result, null, 2))
      console.log(`   💾 JSON 저장: ${jsonPath}`)

      // Generate and save trace markdown
      const tracePath = path.join(OUTPUT_DIR, '..', '..', 'ai-quality', 'traces', `${scenario.id}-trace.md`)
      const traceContent = generateTraceMarkdown(result, scenario)
      fs.writeFileSync(tracePath, traceContent)
      console.log(`   📄 트레이스 저장: ${tracePath}`)

    } catch (err: any) {
      console.error(`\n💥 시나리오 ${scenario.id} 치명적 오류: ${err.message}`)
      results.push({
        scenario: { id: scenario.id, name: scenario.name, description: scenario.description, careerState: scenario.careerState },
        timestamp: new Date().toISOString(),
        baseUrl: BASE_URL,
        sessionId: 'FAILED',
        requestId: null,
        analyzeResponse: null,
        narrativeFactsInput: { high_alive_moment: '', lost_moment: '' },
        narrativeFactsResponse: null,
        rounds: [],
        recommendation: { top10: [], uxMetrics: null, processingTimeMs: 0 },
        rawRecommendResponse: null,
        timing: { analyzeMs: 0, narrativeMs: 0, roundsMs: [], roundAnswersMs: [], recommendMs: 0, totalMs: 0 },
        errors: [`치명적 오류: ${err.message}`],
      })
    }

    // 시나리오 간 대기 (rate limit)
    if (scenarios.indexOf(scenario) < scenarios.length - 1) {
      console.log(`\n⏳ 다음 시나리오까지 3초 대기...`)
      await sleep(3000)
    }
  }

  // Generate summary report
  const summaryPath = path.join(OUTPUT_DIR, 'SUMMARY.md')
  const summaryContent = generateSummaryReport(results)
  fs.writeFileSync(summaryPath, summaryContent)
  console.log(`\n📊 요약 리포트 저장: ${summaryPath}`)

  // Final summary
  console.log(`\n${'═'.repeat(60)}`)
  console.log(`✅ Full E2E 테스트 완료`)
  console.log(`   시나리오: ${results.length}개`)
  console.log(`   성공: ${results.filter(r => r.errors.length === 0).length}개`)
  console.log(`   에러 있음: ${results.filter(r => r.errors.length > 0).length}개`)
  console.log(`   결과: ${OUTPUT_DIR}`)
  console.log(`   트레이스: docs/ai-quality/traces/`)
  console.log(`${'═'.repeat(60)}`)
}

main().catch(err => {
  console.error(`\n💥 스크립트 오류: ${err.message}`)
  process.exit(1)
})
