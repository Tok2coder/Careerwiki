// CareerWiki AI Analyzer - Premium Report Generator
// Version: v1.0.0
// 
// ⚠️ 설계 원칙
// ============================================
// 1. 섹션별 독립 생성: 한 섹션 실패해도 다른 섹션 영향 없음
// 2. 각 섹션에 _meta (status, confidence) 포함
// 3. Rule 기반 생성 (LLM 확장 준비 완료)
// 4. 캐싱 친화적 구조
// ============================================

import type {
  EvidenceLink,
  UserInsight,
  PremiumReport,
  SectionGenerationStatus,
  SectionMeta,
  SummaryOnePageSection,
  PersonalAnalysisSection,
  KeyHypothesesSection,
  KeyHypothesis,
  TopRecommendationsSection,
  TopRecommendation,
  HoldRecommendationsSection,
  HoldRecommendation,
  PlanBPathsSection,
  PlanBPath,
  LearningRoadmapSection,
  RoadmapMilestone,
  NextQuestionsSection,
  FollowupQuestionV3,
} from './types'
import { buildEvidenceLinks, generateDefaultEvidence, type Fact, type ScoredJobForEvidence } from './evidence-generator'

// ============================================
// 입력 타입
// ============================================
export interface PremiumReportInput {
  session_id: string
  facts: Fact[]
  recommendations: ScoredJobForEvidence[]  // 전체 추천 (상위 20개 정도)
  userInsight?: UserInsight
  followupHistory?: FollowupQuestionV3[]
  stage?: string
}

// ============================================
// 헬퍼: 안전한 섹션 생성 래퍼
// ============================================
function safeGenerate<T>(
  generator: () => T,
  fallback: T,
  sectionName: string
): { result: T; status: SectionGenerationStatus; error?: string } {
  try {
    const result = generator()
    return { result, status: 'success' }
  } catch (error) {
    console.error(`[PremiumReport] ${sectionName} 생성 실패:`, error)
    return {
      result: fallback,
      status: 'failed',
      error: error instanceof Error ? error.message : String(error),
    }
  }
}

// ============================================
// Section 1: Summary One Page
// ============================================
function generateSummaryOnePage(input: PremiumReportInput): SummaryOnePageSection {
  const topJob = input.recommendations[0]
  const stage = input.stage || '탐색'
  
  // 핵심 요약 생성
  const takeaways: string[] = []
  
  if (input.userInsight?.key_traits) {
    for (const trait of input.userInsight.key_traits.slice(0, 2)) {
      takeaways.push(trait.trait)
    }
  }
  
  if (topJob) {
    takeaways.push(`${topJob.job_name}이(가) 현재 가장 적합한 추천입니다 (적합도 ${topJob.scores.fit}점)`)
  }
  
  if (input.facts.length > 0) {
    takeaways.push(`${input.facts.length}개의 답변을 기반으로 분석되었습니다`)
  }
  
  // 최소 3개 보장
  while (takeaways.length < 3) {
    takeaways.push('추가 질문에 답변하시면 더 정확한 분석이 가능합니다')
  }
  
  return {
    _meta: {
      status: 'success',
      confidence: Math.min(0.9, 0.5 + (input.facts.length * 0.05)),
      generated_by: 'rule',
    },
    headline: `당신은 ${getPersonalityKeyword(input)}형 인재입니다. ${stage} 단계에서 가장 중요한 건 ${getPriorityFromFacts(input.facts)}입니다.`,
    top_takeaways: takeaways.slice(0, 5),
    recommended_next_step: topJob 
      ? `${topJob.job_name}에 대해 더 알아보고, 관련 역량을 파악해보세요`
      : '관심 분야와 우선순위를 더 명확히 정리해보세요',
  }
}

// ============================================
// Section 2: Personal Analysis
// ============================================
function generatePersonalAnalysis(input: PremiumReportInput): PersonalAnalysisSection {
  const insights = input.userInsight
  
  // 성격 요약
  const personalitySummary = insights?.summary || 
    `당신은 ${getPersonalityKeyword(input)}적인 성향을 가진 분입니다.`
  
  // 업무 스타일 인사이트
  const workStyleInsights: string[] = []
  if (insights?.key_traits) {
    for (const trait of insights.key_traits) {
      workStyleInsights.push(`${trait.trait} - ${trait.evidence}`)
    }
  }
  if (workStyleInsights.length < 3) {
    workStyleInsights.push('혼자 집중하는 시간과 협업하는 시간의 균형을 중요하게 생각합니다')
    workStyleInsights.push('새로운 도전보다는 안정적인 환경에서 능력을 발휘합니다')
    workStyleInsights.push('명확한 목표와 방향이 있을 때 최고의 성과를 냅니다')
  }
  
  // 가치관/우선순위
  const valuePriorities = extractValuePriorities(input.facts)
  
  // 잠재적 도전
  const challenges = [
    '새로운 환경에 적응하는 데 시간이 필요할 수 있습니다',
    '너무 완벽주의적인 접근이 진행을 늦출 수 있습니다',
  ]
  
  // 맹점
  const blindSpots = [
    '자신의 강점을 과소평가하는 경향이 있을 수 있습니다',
    '변화에 대한 두려움이 새로운 기회를 놓치게 할 수 있습니다',
  ]
  
  return {
    _meta: {
      status: insights ? 'success' : 'partial',
      confidence: insights ? 0.8 : 0.5,
      generated_by: 'rule',
    },
    personality_summary: personalitySummary,
    work_style_insights: workStyleInsights.slice(0, 7),
    value_priorities: valuePriorities.slice(0, 7),
    potential_challenges: challenges.slice(0, 5),
    blind_spots_to_check: blindSpots.slice(0, 5),
  }
}

// ============================================
// Section 3: Key Hypotheses
// ============================================
function generateKeyHypotheses(input: PremiumReportInput): KeyHypothesesSection {
  const hypotheses: KeyHypothesis[] = []
  const topJobs = input.recommendations.slice(0, 3)
  
  // 가설 1: 성향 기반
  const personalityHypothesis: KeyHypothesis = {
    hypothesis: `당신은 ${getPersonalityKeyword(input)}적인 업무 환경에서 가장 잘 성장할 것입니다`,
    confidence: 0.7,
    supporting_evidence: topJobs[0] 
      ? buildEvidenceLinks(input.facts, topJobs[0]).slice(0, 3)
      : [],
    what_would_change_my_mind: '실제 업무 경험에서 다른 환경이 더 맞았다면 이 가설은 수정되어야 합니다',
  }
  hypotheses.push(personalityHypothesis)
  
  // 가설 2: 우선순위 기반
  const priority = getPriorityFromFacts(input.facts)
  const priorityHypothesis: KeyHypothesis = {
    hypothesis: `${priority}이(가) 직업 선택에서 가장 중요한 요소입니다`,
    confidence: 0.8,
    supporting_evidence: topJobs[1] 
      ? buildEvidenceLinks(input.facts, topJobs[1]).slice(0, 2)
      : [],
    what_would_change_my_mind: '실제 직업 생활에서 다른 가치가 더 중요해진다면 재평가가 필요합니다',
  }
  hypotheses.push(priorityHypothesis)
  
  // 가설 3: 적합 직업군 기반
  if (topJobs[0]) {
    const fitHypothesis: KeyHypothesis = {
      hypothesis: `${topJobs[0].job_name} 관련 분야가 당신에게 가장 적합한 직업군입니다`,
      confidence: Math.min(0.9, topJobs[0].scores.fit / 100),
      supporting_evidence: buildEvidenceLinks(input.facts, topJobs[0]).slice(0, 3),
      what_would_change_my_mind: '해당 직업에 대한 추가 정보나 실제 경험이 다른 결과를 보여준다면 수정될 수 있습니다',
    }
    hypotheses.push(fitHypothesis)
  }
  
  return {
    _meta: {
      status: hypotheses.length >= 3 ? 'success' : 'partial',
      confidence: hypotheses.reduce((sum, h) => sum + h.confidence, 0) / hypotheses.length,
      generated_by: 'rule',
    },
    hypotheses: hypotheses.slice(0, 3),
  }
}

// ============================================
// Section 4: Top Recommendations
// ============================================
function generateTopRecommendations(input: PremiumReportInput): TopRecommendationsSection {
  const recommendations: TopRecommendation[] = []
  const topJobs = input.recommendations.slice(0, 5)
  
  for (const job of topJobs) {
    let evidenceLinks = buildEvidenceLinks(input.facts, job)
    if (evidenceLinks.length < 3) {
      const defaultEvidence = generateDefaultEvidence(job)
      evidenceLinks = [...evidenceLinks, ...defaultEvidence].slice(0, 10)
    }
    
    recommendations.push({
      id: job.job_id,
      name: job.job_name,
      fit_score: job.scores.fit,
      personal_fit_reason: generatePersonalFitReason(job, input.facts),
      evidence_links: evidenceLinks,
      growth_path_30_days: generateGrowthPath(job),
      risks: generateRisks(job),
    })
  }
  
  return {
    _meta: {
      status: recommendations.length >= 3 ? 'success' : 'partial',
      confidence: 0.85,
      generated_by: 'rule',
    },
    recommendations,
  }
}

// ============================================
// Section 5: Hold Recommendations
// ============================================
function generateHoldRecommendations(input: PremiumReportInput): HoldRecommendationsSection {
  const recommendations: HoldRecommendation[] = []
  
  // 점수는 괜찮지만 리스크가 있는 직업들
  const holdCandidates = input.recommendations.slice(5, 15).filter(job => 
    job.scores.fit >= 40 && job.scores.risk_penalty > 15
  )
  
  for (const job of holdCandidates.slice(0, 5)) {
    recommendations.push({
      id: job.job_id,
      name: job.job_name,
      why_on_hold: generateHoldReason(job),
      conditions_to_reconsider: generateReconsiderConditions(job),
    })
  }
  
  // 최소 2개 보장
  if (recommendations.length < 2) {
    const fillers = input.recommendations.slice(5, 10).filter(j => j.scores.fit >= 30)
    for (const job of fillers) {
      if (recommendations.length >= 2) break
      if (recommendations.some(r => r.id === job.job_id)) continue
      
      recommendations.push({
        id: job.job_id,
        name: job.job_name,
        why_on_hold: '현재 우선순위에서는 다른 직업들이 더 적합합니다',
        conditions_to_reconsider: ['우선순위가 변경되면 재고려할 수 있습니다'],
      })
    }
  }
  
  return {
    _meta: {
      status: recommendations.length > 0 ? 'success' : 'fallback',
      confidence: 0.7,
      generated_by: 'rule',
    },
    recommendations,
  }
}

// ============================================
// Section 6: Plan B Paths
// ============================================
function generatePlanBPaths(input: PremiumReportInput): PlanBPathsSection {
  const paths: PlanBPath[] = []
  const topJob = input.recommendations[0]
  
  // Plan B 1: 안정성 우선 경로
  paths.push({
    title: '안정성 우선 경로',
    when_this_is_better: '현재 상황에서 리스크를 최소화하고 싶다면',
    steps: [
      '현재 역량을 활용할 수 있는 안정적인 직업 탐색',
      '필요한 자격증이나 경험 쌓기',
      '점진적으로 원하는 분야로 이동',
    ],
  })
  
  // Plan B 2: 빠른 전환 경로
  paths.push({
    title: '빠른 전환 경로',
    when_this_is_better: '빠르게 새로운 분야로 이동하고 싶다면',
    steps: [
      '핵심 기술 집중 학습 (3개월)',
      '관련 프로젝트/포트폴리오 구축',
      `${topJob?.job_name || '목표 직업'} 관련 네트워킹 시작`,
    ],
  })
  
  return {
    _meta: {
      status: 'success',
      confidence: 0.6,
      generated_by: 'rule',
    },
    paths,
  }
}

// ============================================
// Section 7: Learning Roadmap
// ============================================
function generateLearningRoadmap(input: PremiumReportInput): LearningRoadmapSection {
  const topJob = input.recommendations[0]
  
  const milestones: RoadmapMilestone[] = [
    {
      title: '1단계: 탐색 및 방향 설정',
      tasks: [
        `${topJob?.job_name || '관심 직업'} 관련 정보 수집`,
        '현직자 인터뷰 또는 커뮤니티 참여',
        '필요 역량 목록 작성',
      ],
    },
    {
      title: '2단계: 역량 개발',
      tasks: [
        '핵심 기술/지식 학습 계획 수립',
        '온라인 강의 또는 자격증 과정 시작',
        '실습 프로젝트 진행',
      ],
    },
    {
      title: '3단계: 실전 경험',
      tasks: [
        '관련 인턴십/프로젝트 참여',
        '포트폴리오 구축',
        '이력서 및 자기소개서 준비',
      ],
    },
  ]
  
  return {
    _meta: {
      status: 'success',
      confidence: 0.7,
      generated_by: 'rule',
    },
    timeline: '3m',
    milestones,
  }
}

// ============================================
// Section 8: Next Questions
// ============================================
function generateNextQuestions(input: PremiumReportInput): NextQuestionsSection {
  const questions: string[] = []
  const existingFactKeys = new Set(input.facts.map(f => f.fact_key))
  
  // 답변되지 않은 중요 질문들
  if (!existingFactKeys.has('discovery.best_moment')) {
    questions.push('가장 보람 있었던 업무 경험은 무엇인가요?')
  }
  if (!existingFactKeys.has('profile.constraints.location')) {
    questions.push('근무 지역이나 원격근무에 대한 선호가 있나요?')
  }
  if (!existingFactKeys.has('profile.life_constraint')) {
    questions.push('현재 생활에서 특별히 고려해야 할 제약이 있나요?')
  }
  
  // 최소 3개 보장
  const defaultQuestions = [
    '5년 후 어떤 모습이 되고 싶은가요?',
    '현재 가장 개선하고 싶은 역량은 무엇인가요?',
    '업무 외 시간에 주로 무엇을 하나요?',
  ]
  
  for (const q of defaultQuestions) {
    if (questions.length >= 3) break
    questions.push(q)
  }
  
  return {
    _meta: {
      status: 'success',
      confidence: 0.9,
      generated_by: 'rule',
    },
    questions: questions.slice(0, 3),
    expected_improvements: [
      '더 정확한 성향 파악',
      '숨겨진 가능성 발견',
      '현실적 제약 반영',
    ],
  }
}

// ============================================
// 헬퍼 함수들
// ============================================

function getPersonalityKeyword(input: PremiumReportInput): string {
  // facts에서 성향 키워드 추출
  const workstyleFact = input.facts.find(f => f.fact_key.includes('workstyle'))
  if (workstyleFact) {
    try {
      const parsed = JSON.parse(workstyleFact.value_json)
      const value = parsed.value || parsed
      if (value === 'solo') return '독립적'
      if (value === 'team') return '협업 지향'
    } catch { /* ignore */ }
  }
  
  // 기본값
  return '균형 잡힌'
}

function getPriorityFromFacts(facts: Fact[]): string {
  const priorityFact = facts.find(f => f.fact_key === 'priority.top1')
  if (priorityFact) {
    try {
      const parsed = JSON.parse(priorityFact.value_json)
      const value = parsed.value || parsed
      const map: Record<string, string> = {
        growth: '성장 가능성',
        income: '수입/보상',
        wlb: '워라밸',
        stability: '안정성',
        meaning: '의미/보람',
      }
      return map[value] || '균형'
    } catch { /* ignore */ }
  }
  return '균형 잡힌 발전'
}

function extractValuePriorities(facts: Fact[]): string[] {
  const priorities: string[] = []
  
  for (const fact of facts) {
    if (fact.fact_key.includes('priority') || fact.fact_key.includes('value')) {
      try {
        const parsed = JSON.parse(fact.value_json)
        const value = parsed.value || parsed
        if (typeof value === 'string') {
          priorities.push(`${value}을(를) 중요하게 생각합니다`)
        }
      } catch { /* ignore */ }
    }
  }
  
  // 기본값
  if (priorities.length < 3) {
    priorities.push('균형 잡힌 삶을 추구합니다')
    priorities.push('지속적인 성장을 원합니다')
    priorities.push('안정적인 환경을 선호합니다')
  }
  
  return priorities
}

function generatePersonalFitReason(job: ScoredJobForEvidence, facts: Fact[]): string {
  const reasons: string[] = []
  
  // 높은 속성값 기반 이유
  const attrs = job.attributes
  if ((attrs.wlb as number) >= 70) reasons.push('워라밸이 좋은 편')
  if ((attrs.growth as number) >= 70) reasons.push('성장 가능성이 높음')
  if ((attrs.income as number) >= 70) reasons.push('수입 수준이 높음')
  if ((attrs.stability as number) >= 70) reasons.push('안정성이 높음')
  
  if (reasons.length === 0) {
    return `${job.job_name}은(는) 당신의 성향과 잘 맞는 직업입니다`
  }
  
  return `${job.job_name}은(는) ${reasons.slice(0, 2).join(', ')} 직업입니다`
}

function generateGrowthPath(job: ScoredJobForEvidence): string[] {
  return [
    `${job.job_name} 관련 기초 지식 학습`,
    '관련 온라인 강의/자료 탐색',
    '현직자 이야기 듣기 또는 직업 체험',
    '필요 역량 파악 및 학습 계획 수립',
    '작은 프로젝트로 실습 시작',
  ]
}

function generateRisks(job: ScoredJobForEvidence): string[] {
  const risks: string[] = []
  const attrs = job.attributes
  
  if ((attrs.wlb as number) < 40) risks.push('야근이 많을 수 있습니다')
  if ((attrs.stability as number) < 40) risks.push('고용 안정성이 낮을 수 있습니다')
  if ((attrs.income as number) < 40) risks.push('초기 수입이 낮을 수 있습니다')
  
  if (risks.length === 0) {
    risks.push('새로운 분야 적응에 시간이 필요할 수 있습니다')
    risks.push('경쟁이 있을 수 있습니다')
  }
  
  return risks.slice(0, 5)
}

function generateHoldReason(job: ScoredJobForEvidence): string {
  if (job.scores.risk_penalty > 20) {
    return '현재 조건과 충돌하는 요소가 있습니다'
  }
  return '다른 추천에 비해 적합도가 낮습니다'
}

function generateReconsiderConditions(job: ScoredJobForEvidence): string[] {
  const conditions: string[] = []
  const attrs = job.attributes
  
  if ((attrs.wlb as number) < 50) {
    conditions.push('야근에 대한 허용도가 높아지면')
  }
  if ((attrs.degree_required as string) !== 'none') {
    conditions.push('관련 학위/자격을 취득하면')
  }
  
  if (conditions.length === 0) {
    conditions.push('우선순위가 변경되면')
    conditions.push('추가 역량을 쌓으면')
  }
  
  return conditions.slice(0, 3)
}

// ============================================
// 메인 함수: generatePremiumReport
// ============================================
export function generatePremiumReport(input: PremiumReportInput): PremiumReport {
  let sectionsCompleted = 0
  const sectionsTotal = 8
  
  // 각 섹션 독립적으로 생성 (실패해도 다른 섹션 영향 없음)
  const summaryResult = safeGenerate(
    () => generateSummaryOnePage(input),
    createFallbackSummary(),
    'SummaryOnePage'
  )
  if (summaryResult.status === 'success') sectionsCompleted++
  
  const personalResult = safeGenerate(
    () => generatePersonalAnalysis(input),
    createFallbackPersonalAnalysis(),
    'PersonalAnalysis'
  )
  if (personalResult.status === 'success' || personalResult.status === 'partial') sectionsCompleted++
  
  const hypothesesResult = safeGenerate(
    () => generateKeyHypotheses(input),
    createFallbackHypotheses(),
    'KeyHypotheses'
  )
  if (hypothesesResult.status === 'success' || hypothesesResult.status === 'partial') sectionsCompleted++
  
  const topRecsResult = safeGenerate(
    () => generateTopRecommendations(input),
    createFallbackTopRecommendations(),
    'TopRecommendations'
  )
  if (topRecsResult.status === 'success' || topRecsResult.status === 'partial') sectionsCompleted++
  
  const holdRecsResult = safeGenerate(
    () => generateHoldRecommendations(input),
    createFallbackHoldRecommendations(),
    'HoldRecommendations'
  )
  if (holdRecsResult.status === 'success' || holdRecsResult.status === 'fallback') sectionsCompleted++
  
  const planBResult = safeGenerate(
    () => generatePlanBPaths(input),
    createFallbackPlanB(),
    'PlanBPaths'
  )
  if (planBResult.status === 'success') sectionsCompleted++
  
  const roadmapResult = safeGenerate(
    () => generateLearningRoadmap(input),
    createFallbackRoadmap(),
    'LearningRoadmap'
  )
  if (roadmapResult.status === 'success') sectionsCompleted++
  
  const questionsResult = safeGenerate(
    () => generateNextQuestions(input),
    createFallbackNextQuestions(),
    'NextQuestions'
  )
  if (questionsResult.status === 'success') sectionsCompleted++
  
  // 전체 상태 결정
  let overallStatus: SectionGenerationStatus = 'success'
  if (sectionsCompleted < sectionsTotal) {
    overallStatus = sectionsCompleted >= 6 ? 'partial' : 'failed'
  }
  
  return {
    report_id: `report-${input.session_id}-${Date.now()}`,
    generated_at: new Date().toISOString(),
    session_id: input.session_id,
    overall_status: overallStatus,
    sections_completed: sectionsCompleted,
    sections_total: sectionsTotal,
    
    summary_one_page: summaryResult.result,
    personal_analysis: personalResult.result,
    key_hypotheses: hypothesesResult.result,
    recommendations_top: topRecsResult.result,
    recommendations_hold: holdRecsResult.result,
    plan_b_paths: planBResult.result,
    learning_roadmap: roadmapResult.result,
    next_questions: questionsResult.result,
  }
}

// ============================================
// Fallback 생성 함수들
// ============================================

function createFallbackSummary(): SummaryOnePageSection {
  return {
    _meta: { status: 'fallback', generated_by: 'rule' },
    headline: '분석을 완료하지 못했습니다',
    top_takeaways: ['추가 정보가 필요합니다'],
    recommended_next_step: '기본 질문에 답변해 주세요',
  }
}

function createFallbackPersonalAnalysis(): PersonalAnalysisSection {
  return {
    _meta: { status: 'fallback', generated_by: 'rule' },
    personality_summary: '분석을 위해 더 많은 정보가 필요합니다',
    work_style_insights: [],
    value_priorities: [],
    potential_challenges: [],
    blind_spots_to_check: [],
  }
}

function createFallbackHypotheses(): KeyHypothesesSection {
  return {
    _meta: { status: 'fallback', generated_by: 'rule' },
    hypotheses: [],
  }
}

function createFallbackTopRecommendations(): TopRecommendationsSection {
  return {
    _meta: { status: 'fallback', generated_by: 'rule' },
    recommendations: [],
  }
}

function createFallbackHoldRecommendations(): HoldRecommendationsSection {
  return {
    _meta: { status: 'fallback', generated_by: 'rule' },
    recommendations: [],
  }
}

function createFallbackPlanB(): PlanBPathsSection {
  return {
    _meta: { status: 'fallback', generated_by: 'rule' },
    paths: [],
  }
}

function createFallbackRoadmap(): LearningRoadmapSection {
  return {
    _meta: { status: 'fallback', generated_by: 'rule' },
    timeline: '3m',
    milestones: [],
  }
}

function createFallbackNextQuestions(): NextQuestionsSection {
  return {
    _meta: { status: 'fallback', generated_by: 'rule' },
    questions: ['어떤 일을 할 때 가장 즐거우신가요?'],
    expected_improvements: ['더 정확한 분석'],
  }
}




